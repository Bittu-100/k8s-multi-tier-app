const express = require('express');
const mysql = require('mysql2/promise');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

// Database connection
const dbConfig = {
  host: process.env.DB_HOST || 'mysql-service',
  user: process.env.DB_USER || 'appuser',
  password: process.env.DB_PASSWORD || 'app123!',
  database: process.env.DB_NAME || 'appdb',
  port: process.env.DB_PORT || 3306
};

// Initialize database connection
let db;
async function initializeDatabase() {
  try {
    db = await mysql.createConnection(dbConfig);
    console.log('✅ Connected to MySQL database');
    
    // Create tasks table if it doesn't exist
    await db.execute(`
      CREATE TABLE IF NOT EXISTS tasks (
        id INT AUTO_INCREMENT PRIMARY KEY,
        title VARCHAR(255) NOT NULL,
        description TEXT,
        completed BOOLEAN DEFAULT FALSE,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    `);
    console.log('✅ Tasks table ready');
  } catch (error) {
    console.error('❌ Database connection failed:', error.message);
    setTimeout(initializeDatabase, 5000); // Retry after 5 seconds
  }
}

// Routes
app.get('/health', (req, res) => {
  res.json({ 
    status: 'OK', 
    service: 'backend-api',
    timestamp: new Date().toISOString()
  });
});

app.get('/api/tasks', async (req, res) => {
  try {
    const [rows] = await db.execute('SELECT * FROM tasks ORDER BY created_at DESC');
    res.json(rows);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.post('/api/tasks', async (req, res) => {
  try {
    const { title, description } = req.body;
    const [result] = await db.execute(
      'INSERT INTO tasks (title, description) VALUES (?, ?)',
      [title, description]
    );
    res.json({ id: result.insertId, title, description, completed: false });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.get('/api/info', (req, res) => {
  res.json({
    service: 'Backend API',
    version: '1.0.0',
    database: {
      host: dbConfig.host,
      connected: !!db
    },
    environment: process.env.NODE_ENV || 'development'
  });
});

// Start server
app.listen(PORT, async () => {
  console.log(`🚀 Backend API running on port ${PORT}`);
  await initializeDatabase();
});
