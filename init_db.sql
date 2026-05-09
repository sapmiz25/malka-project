CREATE DATABASE IF NOT EXISTS malka_db 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_general_ci;

USE malka_db;

DROP TABLE IF EXISTS VacationBalances;
DROP TABLE IF EXISTS SushVacationConfig;
DROP TABLE IF EXISTS VacationTypes;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS RankHistory;
DROP TABLE IF EXISTS RankRules;
DROP TABLE IF EXISTS TripStationSignatures;
DROP TABLE IF EXISTS TripForms;
DROP TABLE IF EXISTS TripStationsCatalog;
DROP TABLE IF EXISTS SoldierDocuments;
DROP TABLE IF EXISTS AttendanceReports;
DROP TABLE IF EXISTS Tasks;
DROP TABLE IF EXISTS TaskTemplates;
DROP TABLE IF EXISTS AttendanceCatalog;
DROP TABLE IF EXISTS Soldiers;
DROP TABLE IF EXISTS SubUnits;
DROP TABLE IF EXISTS Units;


CREATE TABLE Units (
    UnitCode INT PRIMARY KEY,
    UnitName VARCHAR(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE SubUnits (
    SubUnitCode INT PRIMARY KEY,
    SubUnitName VARCHAR(50) NOT NULL,
    ParentUnitCode INT,
    FOREIGN KEY (ParentUnitCode) REFERENCES Units(UnitCode) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE Soldiers (
    PersonalNumber VARCHAR(7) PRIMARY KEY,
    ID VARCHAR(9) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Gender VARCHAR(10) NOT NULL,
    BirthDate DATE NOT NULL,
    Address VARCHAR(200) NOT NULL,
    PhoneNumber VARCHAR(20),
    EmergencyContactName VARCHAR(100),
    EmergencyContactPhone VARCHAR(20),
    EmergencyRelation VARCHAR(50),
    UnitCode INT NOT NULL,
    SubUnitCode INT NOT NULL,
    Role VARCHAR(100) NOT NULL,
    CommanderID VARCHAR(7) NOT NULL,
    RecruitmentDate DATE NOT NULL,
    ReleaseDate DATE NOT NULL,
    AbsorptionDate DATE NOT NULL,
    MedicalProfile INT NOT NULL,
    CombatStatus VARCHAR(20) NOT NULL,
    SabatStatus VARCHAR(50) NOT NULL,
    SushStatus VARCHAR(50) NOT NULL,
    EaseOfService INT,
    PermissionType VARCHAR(20),
    IsActive BIT DEFAULT 1,
    FOREIGN KEY (UnitCode) REFERENCES Units(UnitCode),
    FOREIGN KEY (SubUnitCode) REFERENCES SubUnits(SubUnitCode)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE TaskTemplates (
    TemplateID INT AUTO_INCREMENT PRIMARY KEY,
    TaskName VARCHAR(100) NOT NULL,
    SubTaskType VARCHAR(100),
    IsAutomatic BIT DEFAULT 1,
    IsCyclic BIT DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Tasks (
    TaskID INT AUTO_INCREMENT PRIMARY KEY,
    SoldierID VARCHAR(7) NOT NULL,
    TemplateID INT NOT NULL,
    CommanderID VARCHAR(7) NOT NULL,
    CreationDate DATE DEFAULT (CURRENT_DATE),
    DueDate DATE NOT NULL,
    ExecutionDate DATE,
    ApprovalDate DATE,
    TaskStatus VARCHAR(50) NOT NULL,
    PdfPath VARCHAR(255),
    FOREIGN KEY (SoldierID) REFERENCES Soldiers(PersonalNumber) ON DELETE CASCADE,
    FOREIGN KEY (TemplateID) REFERENCES TaskTemplates(TemplateID),
    FOREIGN KEY (CommanderID) REFERENCES Soldiers(PersonalNumber)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE AttendanceCatalog (
    StatusID INT AUTO_INCREMENT PRIMARY KEY,
    MainStatus VARCHAR(50) NOT NULL,
    SubStatus VARCHAR(50) NOT NULL,
    IsDeductible BIT DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE AttendanceReports (
    ReportID INT AUTO_INCREMENT PRIMARY KEY,
    SoldierID VARCHAR(7) NOT NULL,
    ReportDate DATE NOT NULL,
    StatusID INT NOT NULL,
    ReportingTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CommanderID VARCHAR(7) NOT NULL,
    ReportFlowStatus VARCHAR(50) DEFAULT 'Not Entered',
    CommanderComments TEXT,
    TaskID INT,
    FOREIGN KEY (SoldierID) REFERENCES Soldiers(PersonalNumber) ON DELETE CASCADE,
    FOREIGN KEY (StatusID) REFERENCES AttendanceCatalog(StatusID),
    FOREIGN KEY (CommanderID) REFERENCES Soldiers(PersonalNumber),
    FOREIGN KEY (TaskID) REFERENCES Tasks(TaskID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE SoldierDocuments (
    DocID INT AUTO_INCREMENT PRIMARY KEY,
    SoldierID VARCHAR(7) NOT NULL,
    CommanderID VARCHAR(7),
    DocType VARCHAR(50) NOT NULL,
    CreationDate DATE DEFAULT (CURRENT_DATE),
    FileName VARCHAR(100) NOT NULL,
    FilePath VARCHAR(255) NOT NULL,
    ApprovalStatus VARCHAR(20) DEFAULT 'Pending',
    ApprovalDate DATE,
    TaskID INT,
    FOREIGN KEY (SoldierID) REFERENCES Soldiers(PersonalNumber) ON DELETE CASCADE,
    FOREIGN KEY (CommanderID) REFERENCES Soldiers(PersonalNumber),
    FOREIGN KEY (TaskID) REFERENCES Tasks(TaskID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE TripStationsCatalog (
    StationID INT AUTO_INCREMENT PRIMARY KEY,
    StationName VARCHAR(100) NOT NULL,
    IsEntryStation BIT DEFAULT 1,
    IsExitReleaseStation BIT DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE TripForms (
    FormID INT AUTO_INCREMENT PRIMARY KEY,
    SoldierID VARCHAR(7) NOT NULL,
    FormType VARCHAR(20) NOT NULL,
    OpenDate DATE DEFAULT (CURRENT_DATE),
    CloseDate DATE,
    FormStatus VARCHAR(20) DEFAULT 'Open',
    FOREIGN KEY (SoldierID) REFERENCES Soldiers(PersonalNumber) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE TripStationSignatures (
    SignatureID INT AUTO_INCREMENT PRIMARY KEY,
    FormID INT NOT NULL,
    StationID INT NOT NULL,
    IsApproved BIT DEFAULT 0,
    ApprovalDate TIMESTAMP NULL,
    ApproverID VARCHAR(7),
    FOREIGN KEY (FormID) REFERENCES TripForms(FormID) ON DELETE CASCADE,
    FOREIGN KEY (StationID) REFERENCES TripStationsCatalog(StationID),
    FOREIGN KEY (ApproverID) REFERENCES Soldiers(PersonalNumber)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE RankRules (
    RankID INT AUTO_INCREMENT PRIMARY KEY,
    RankName VARCHAR(50) NOT NULL,
    RankTrack VARCHAR(20) NOT NULL,    -- סדיר / נגד / קצין
    Gender VARCHAR(10) NOT NULL,       -- זכר / נקבה / כולם
    CombatStatus VARCHAR(20) NOT NULL, -- לוחם / עורפי / כולם
    PazamRequired INT NOT NULL         -- פז"ם בחודשים
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE RankHistory (
    HistoryID INT AUTO_INCREMENT PRIMARY KEY,
    SoldierID VARCHAR(7) NOT NULL,
    RankID INT NOT NULL,
    PromotionDate DATE NOT NULL,
    ApproverID VARCHAR(20) DEFAULT 'System',
    IsDelayed BIT DEFAULT 0,
    DelayReason TEXT,
    FOREIGN KEY (SoldierID) REFERENCES Soldiers(PersonalNumber) ON DELETE CASCADE,
    FOREIGN KEY (RankID) REFERENCES RankRules(RankID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Users (
    PersonalNumber VARCHAR(7) PRIMARY KEY,
    PasswordHash VARCHAR(255) NOT NULL,
    IsAdmin BIT DEFAULT 0,
    IsUser BIT DEFAULT 0,
    IsStationManager BIT DEFAULT 0,
    ManagedStationID INT NULL,
    NeedsPasswordChange BIT DEFAULT 1,
    LastLogin TIMESTAMP NULL,
    FailedAttempts INT DEFAULT 0,
    FOREIGN KEY (PersonalNumber) REFERENCES Soldiers(PersonalNumber) ON DELETE CASCADE,
    FOREIGN KEY (ManagedStationID) REFERENCES TripStationsCatalog(StationID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE SushVacationConfig (
    ConfigID INT AUTO_INCREMENT PRIMARY KEY,
    SushStatus VARCHAR(20) NOT NULL,
    VacationType VARCHAR(50) NOT NULL,
    MaxDaysPerYear INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE VacationBalances (
    SoldierID VARCHAR(7) NOT NULL,
    VacationYear INT NOT NULL,
    TotalQuota INT NOT NULL,
    UsedDays INT DEFAULT 0,
    PRIMARY KEY (SoldierID, VacationYear),
    FOREIGN KEY (SoldierID) REFERENCES Soldiers(PersonalNumber) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


INSERT INTO AttendanceCatalog (MainStatus, SubStatus, IsDeductible) VALUES 
('ביחידה', 'נוכח ביחידה', 0),
('מחוץ ליחידה', 'הפניה רפואית', 0),
('מחוץ ליחידה', 'בתפקיד', 0),
('חופשה', 'חופשה שנתית', 1),
('חופשה', 'חופשה מיוחדת', 1),
('חופשה', 'יום מפקד', 1),
('חופשת מחלה', 'יום ד', 1),
('חופשת מחלה', 'גימלים', 0),
('חופשת מחלה', 'יום הצהרה', 1);

INSERT INTO SushVacationConfig (SushStatus, VacationType, MaxDaysPerYear) VALUES 
('סדיר', 'חופשה שנתית', 18),
('סדיר', 'יום ד', 10),
('סדיר', 'יום מפקד', 5),
('סדיר', 'חופשה מיוחדת', 30),
('נגד', 'חופשה שנתית', 24),
('נגד', 'יום הצהרה', 2),
('קצין', 'חופשה שנתית', 24),
('קצין', 'יום הצהרה', 2);


INSERT INTO RankRules (RankName, RankTrack, Gender, CombatStatus, PazamRequired) VALUES 
('טוראי', 'סדיר', 'כולם', 'כולם', 0),
('רב"ט', 'סדיר', 'כולם', 'לוחם', 7),
('רב"ט', 'סדיר', 'כולם', 'עורפי', 10),
('סמל', 'סדיר', 'כולם', 'לוחם', 9),
('סמל', 'סדיר', 'כולם', 'עורפי', 10),
('סמ"ר', 'סדיר', 'כולם', 'לוחם', 10),
('סמ"ר', 'סדיר', 'גבר', 'עורפי', 8),
('סמ"ר', 'נגד', 'אישה', 'עורפי', 4),
('רס"ל', 'נגד', 'כולם', 'כולם', 24),
('רס"ר', 'נגד', 'כולם', 'כולם', 60),
('רס"ם', 'נגד', 'כולם', 'כולם', 48),
('רס"ב', 'נגד', 'כולם', 'כולם', 48),
('רנ"ג', 'נגד', 'כולם', 'כולם', 48),
('סג"מ', 'סדיר', 'כולם', 'כולם', 0),
('סגן', 'קצין', 'כולם', 'כולם', 12),
('סרן', 'קצין', 'כולם', 'כולם', 24),
('רס"ן', 'קצין', 'כולם', 'כולם', 36),
('סא"ל', 'קצין', 'כולם', 'כולם', 48),
('אל"ם', 'קצין', 'כולם', 'כולם', 48),
('תא"ל', 'קצין', 'כולם', 'כולם', 60);

INSERT INTO TripStationsCatalog (StationName, IsEntryStation, IsExitReleaseStation) VALUES 
('נשקייה', 1, 1),
('אפסנאות', 1, 1),
('מרפאה', 1, 1),
('שלישות', 1, 1),
('ת"ש', 1, 0),
('רס"ר', 1, 0),
('ביטחון מידע', 1, 1);

INSERT INTO TaskTemplates (TaskName, SubTaskType, IsAutomatic, IsCyclic) VALUES 
('טופס טיולים נכנס', 'שלישות', 1, 0),
('ביקור בית לחייל חדש', 'ת"ש', 1, 0),
('טופס טיולים שחרור', 'שלישות', 1, 0),
('ראיון שחרור', 'פיקודי', 1, 0),
('חווד מפקד למילואים', 'פיקודי', 1, 0),
('ראיון קליטה לחייל חדש', 'פיקודי', 1, 0),
('דוח 1', 'שלישות', 1, 1);

INSERT INTO Units (UnitCode, UnitName) VALUES 
(100, 'אג"מ'),
(101, 'לוגיסטיקה'),
(102, 'כח אדם'),
(103, 'שליטה'),
(104, '914'),
(105, 'מטה בסיס');

INSERT INTO SubUnits (SubUnitCode, SubUnitName, ParentUnitCode) VALUES 
(201, 'קשר קווי', 100),
(202, 'צופן', 100),
(203, 'אימון גופני', 100),
(204, 'מעגן', 100),
(205, 'אופרטיבי', 100),
(206, 'מטה פלגה', 100),
(207, 'תיאום', 100),
(208, 'מוקד אג"מ', 100),
(209, 'לוגיסטיקה אט"לי', 101),
(210, 'לוגיסטיקה ייעודי', 101),
(211, 'נשקייה', 101),
(212, 'מטבח', 101),
(213, 'רכב', 101),
(214, 'בינוי', 101),
(215, 'מטה פלגה', 101),
(216, 'מטה פלגה', 102),
(217, 'שק"מ', 102),
(218, 'ת"ש', 102),
(219, 'חינוך', 102),
(220, 'שלישות', 102),
(221, 'מילואים', 102),
(222, 'מטה פלגה', 103),
(223, 'ראש הנקרה', 103),
(224, 'מרכז מדינה', 103),
(225, 'מש"ז', 103),
(226, 'אחזקה', 103),
(227, 'מטה פלגה', 104),
(228, 'קמבצ"ייה', 104),
(229, 'אחזקה', 104),
(230, 'סיירת יסעור - מטה', 104),
(231, 'סיירת יסעור - ד 710', 104),
(232, 'סיירת יסעור - ד 711', 104),
(233, 'סיירת יסעור - ד 712', 104),
(234, 'סיירת נשר - מטה', 104),
(235, 'סיירת נשר - ד 713', 104),
(236, 'סיירת נשר - ד 714', 104),
(237, 'סיירת נשר - ד 715', 104),
(238, 'סיירת כריש - מטה', 104),
(239, 'סיירת כריש - ד 716', 104),
(240, 'סיירת כריש - ד 717', 104),
(241, 'סיירת כריש - ד 718', 104),
(242, 'לשכה', 105),
(243, 'ביטחון מידע', 105),
(244, 'דוברות', 105),
(245, 'יח"צ', 105),
(246, 'בטיחות', 105),
(247, 'הגנה', 105);


INSERT INTO Soldiers (
    PersonalNumber, ID, FirstName, LastName, Gender, BirthDate, 
    Address, PhoneNumber, UnitCode, SubUnitCode, Role, 
    CommanderID, RecruitmentDate, ReleaseDate, AbsorptionDate, 
    MedicalProfile, CombatStatus, SabatStatus, SushStatus
) VALUES (
    '1234567',
    '123456789',
    'מור',
    'שרון',
    'אישה',
    '1995-01-01',
    'הכוכב 1, קריית מוצקין',
    '050-0000000',
    102,
    220,
    'נגדת שלישות',
    '2345678',
    '2008-08-01',
    '2025-08-01',
    '2022-08-15',
    82,
    'עורפי', 
    'קבע', 
    'נגד'
);


INSERT INTO Soldiers (
    PersonalNumber, ID, FirstName, LastName, Gender, BirthDate, 
    Address, PhoneNumber, UnitCode, SubUnitCode, Role, 
    CommanderID, RecruitmentDate, ReleaseDate, AbsorptionDate, 
    MedicalProfile, CombatStatus, SabatStatus, SushStatus
) VALUES (
    '2345678',
    '987654321', 
    'ישראל', 
    'המפקד', 
    'גבר', 
    '1990-01-01', 
    'האילנות 5, חיפה', 
    '052-1111111', 
    102,
    216,
    'מפקד פלגה', 
    '0000000',
    '2010-01-01', 
    '2030-01-01', 
    '2020-01-01', 
    97, 
    'עורפי', 
    'קבע', 
    'קצין'
);


INSERT INTO Users (
    PersonalNumber, PasswordHash, IsAdmin, IsUser, IsStationManager, NeedsPasswordChange
) VALUES (
    '2345678', 
    'password123', 
    0,
    1, 
    0, 
    0
);

INSERT INTO Users (
    PersonalNumber, PasswordHash, IsAdmin, IsUser, IsStationManager, NeedsPasswordChange
) VALUES (
    '1234567',
    '123456',
    1,
    0,
    1,
    0
);
