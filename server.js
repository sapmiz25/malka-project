const express = require('express');
const cors = require('cors');
const db = require('./db');
require('dotenv').config();

const app = express();

app.use(cors());
app.use(express.json());

app.post('/api/login', async (req, res) => {
    const { personalNumber, password } = req.body;

    try {
        const query = `
            SELECT u.PersonalNumber, u.IsAdmin, s.FirstName, s.LastName, s.Role 
            FROM Users u 
            JOIN Soldiers s ON u.PersonalNumber = s.PersonalNumber 
            WHERE u.PersonalNumber = ? AND u.PasswordHash = ?
        `;

        const [rows] = await db.query(query, [personalNumber, password]);

        if (rows.length > 0) {
            const user = rows[0];
            
            res.json({ 
                success: true, 
                message: "התחברת בהצלחה",
                user: {
                    personalNumber: user.PersonalNumber,
                    fullName: `${user.FirstName} ${user.LastName}`,
                    role: user.Role,
                    isAdmin: user.IsAdmin === 1 
                }
            });
        } else {
            res.status(401).json({ success: false, message: "מספר אישי או סיסמה שגויים" });
        }
    } catch (err) {
        console.error("Login error:", err);
        res.status(500).json({ error: "שגיאת שרת פנימית" });
    }
});
app.get('/api/soldiers/commander/:commanderId', async (req, res) => {
    const { commanderId } = req.params;
    try {
        const [rows] = await db.query(
            'SELECT * FROM Soldiers WHERE CommanderID = ?', 
            [commanderId]
        );
        res.json(rows);
    } catch (err) {
        res.status(500).json({ error: "שגיאה בשליפת הפקודים" });
    }
});

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
    console.log(`login: http://localhost:${PORT}/api/login`);
});