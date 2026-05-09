import './CommanderDashboard.css';

function CommanderDashboard() {
  return (
    <div className="dashboard-wrapper">
      
      {/* עמודה ימנית: הפקודים שלי (Sidebar) */}
      <aside className="soldiers-sidebar">
        <div style={{ textAlign: 'center', marginBottom: '30px' }}>
          <h2 style={{ fontSize: '22px' }}>רס"ן ישראל ישראלי</h2>
          <p style={{ opacity: 0.8 }}>1234567</p>
        </div>
        
        <h3 style={{ marginBottom: '15px' }}>הפקודים שלי</h3>
        <input type="text" placeholder="חיפוש חייל" className="search-box" style={{ padding: '10px', borderRadius: '8px', border: 'none', marginBottom: '20px' }} />

        <div className="soldier-list" style={{ overflowY: 'auto' }}>
          <div className="soldier-card">
            <strong>יהודה לוי | רב"ט</strong>
            <div style={{ fontSize: '14px' }}>2345678</div>
          </div>
          <div className="soldier-card">
            <strong>דנה שרוני | סמל</strong>
            <div style={{ fontSize: '14px' }}>3456789</div>
          </div>
          <div className="soldier-card">
            <strong>אוראל גבעון | טוראי</strong>
            <div style={{ fontSize: '14px' }}>4567891</div>
          </div>
        </div>
      </aside>

      {/* עמודה שמאלית: תוכן מרכזי (Main Content) */}
      <main className="main-content-area">
        
        {/* כותרת סטטיסטיקות */}
        <div className="commander-stats-header">
          <div className="stat-item">תפקיד: <strong>מפקד יחידה</strong></div>
          <div className="stat-item">פרופיל רפואי: <strong>97</strong></div>
          <div className="stat-item">תאריך גיוס: <strong>01/08/2018</strong></div>
          <div className="stat-item">תאריך שחרור: <strong>01/08/2028</strong></div>
        </div>

        {/* כפתורי ניווט */}
        <div style={{ display: 'flex', gap: '15px', justifyContent: 'center' }}>
          <button className="btn-secondary">תיק חייל</button>
          <button className="btn-secondary">הפקת דו"חות</button>
          <button className="btn-secondary">אישור תחנות טופס טיולים</button>
        </div>

        {/* ווידג'טים נתונים */}
        <div className="widgets-grid" style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '20px' }}>
          <div className="widget-box">
            <h3 style={{ color: '#334155', marginBottom: '15px' }}>משימות</h3>
            <p>ביקור בית לחייל חדש - אוראל גבעון</p>
            <p>חוו"ד מילואים - דנה שרוני</p>
          </div>
          
          <div className="widget-box">
            <h3 style={{ color: '#334155', marginBottom: '15px' }}>הזנת דו"ח 1</h3>
            <div style={{ padding: '10px', background: '#f8fafc', borderRadius: '8px' }}>
              ישראל ישראלי: נוכח ביחידה
            </div>
          </div>

          <div className="widget-box" style={{ gridColumn: '1 / 3' }}>
            <h3 style={{ color: '#334155', marginBottom: '15px' }}>יתרת חופשות פקודים</h3>
            <div style={{ height: '120px', display: 'flex', alignItems: 'center', justifyContent: 'center', border: '1px dashed #cbd5e1', borderRadius: '12px' }}>
              [ גרף חופשות ]
            </div>
          </div>
        </div>

      </main>
    </div>
  );
}

export default CommanderDashboard;