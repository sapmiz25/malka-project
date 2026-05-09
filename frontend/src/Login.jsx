import { useState } from 'react';
import './App.css';

function App() {
  const [personalId, setPersonalId] = useState('');
  const [password, setPassword] = useState('');

  const handleLogin = (e) => {
    e.preventDefault();
    console.log("מתחבר עם:", personalId);
  };

  return (
    <div className="login-page">
      <div className="login-card">
        <h1>ברוכים הבאים למלכ"ה</h1> {/* */}
        
        <form onSubmit={handleLogin}>
          <div className="input-group">
            <label>מספר אישי</label> {/* */}
            <input 
              type="text" 
              value={personalId}
              onChange={(e) => setPersonalId(e.target.value)}
              placeholder="הכנס מספר אישי"
              required 
            />
          </div>

          <div className="input-group">
            <label>סיסמה</label> {/* */}
            <input 
              type="password" 
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="הכנס סיסמה"
              required 
            />
          </div>

          <button type="submit" className="login-btn">כניסה</button> {/* */}
        </form>
      </div>
    </div>
  );
}

export default App;