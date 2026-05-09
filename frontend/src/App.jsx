import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Login from './Login'; // עוד רגע ניצור את הקובץ הזה
import CommanderDashboard from './CommanderDashboard'; // וגם את זה
import './App.css';

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Login />} />
        <Route path="/commander" element={<CommanderDashboard />} />
      </Routes>
    </Router>
  );
}

export default App;