
-- soliders table
CREATE TABLE soldiers (
  personal_id INT PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  military_rank VARCHAR(30),
  medical_profile INT,
  birth_date DATE,
  enlistment_date DATE,
  release_date DATE,
  absorption_date DATE,
  sosh VARCHAR(50),
  sabt VARCHAR(50),
  is_combatant BOOLEAN,
  role VARCHAR(50),
  unit VARCHAR(50),
  sub_unit VARCHAR(50),
  tash VARCHAR(50),
  phone VARCHAR(15),
  emergency_contact_name VARCHAR(100),
  emergency_contact_phone VARCHAR(15),
  emergency_contact_relation VARCHAR(50),
  commander_id INT
);

-- user table
CREATE TABLE users (
  personal_id INT PRIMARY KEY,
  password VARCHAR(255),
  permission ENUM('commander','admin')
);

-- freedom table
CREATE TABLE leave_balance (
  id INT AUTO_INCREMENT PRIMARY KEY,
  soldier_id INT,
  leave_type ENUM('חופשה שנתית','מחלה','יום ד','חופשה מיוחדת','ימי מפקד'),
  balance INT DEFAULT 0
);

-- task table
CREATE TABLE tasks (
  task_id INT AUTO_INCREMENT PRIMARY KEY,
  task_type VARCHAR(100),
  soldier_id INT,
  commander_id INT,
  due_date DATE,
  status ENUM('לביצוע','בוצע','ממתין לאישור','סגור'),
  created_by ENUM('system','admin'),
  pdf_path VARCHAR(255)
);

-- day report table
CREATE TABLE daily_reports (
  report_id INT AUTO_INCREMENT PRIMARY KEY,
  report_date DATE,
  soldier_id INT,
  primary_status VARCHAR(50),
  secondary_status VARCHAR(100),
  notes TEXT,
  medical_file_path VARCHAR(255),
  entered_by INT,
  commander_approval BOOLEAN DEFAULT FALSE,
  shalishut_approval BOOLEAN DEFAULT FALSE
);

-- t"t table

CREATE TABLE trip_stations (
  station_id INT AUTO_INCREMENT PRIMARY KEY,
  station_name VARCHAR(100),
  manager_id INT,
  form_type ENUM('יוצא','נכנס','שחרור')
);

CREATE TABLE trip_form_stations (
  id INT AUTO_INCREMENT PRIMARY KEY,
  form_id INT,
  station_id INT,
  approved BOOLEAN DEFAULT FALSE,
  approved_date DATE
);