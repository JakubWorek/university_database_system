-- Table: Courses
CREATE TABLE Courses (
CourseID int NOT NULL,
CourseName varchar(50) NOT NULL,
CourseDescription text NULL,
CoursePrice money NULL DEFAULT 1000 CHECK (CoursePrice > 0),
CourseCoordinatorID int NOT NULL,
CONSTRAINT Courses_pk PRIMARY KEY (CourseID)
);

-- Table: CourseDetails
CREATE TABLE CourseDetails (
CourseID int NOT NULL,
StudentID int NOT NULL,
CONSTRAINT CourseDetails_pk PRIMARY KEY (CourseID,StudentID)
);

-- Table: CourseModules
CREATE TABLE CourseModules (
ModuleID int NOT NULL,
CourseID int NOT NULL,
TeacherID int NOT NULL,
ModuleName varchar(50) NOT NULL,
Date datetime NOT NULL,
DurationTime time(0) NULL DEFAULT 01:30:00 CHECK (DurationTime > '00:00:00'),
TranslatorID int NULL,
LanguageID int NULL,
CONSTRAINT CourseModules_pk PRIMARY KEY (ModuleID)
);

-- Table: CourseModulesDetails
CREATE TABLE CourseModulesDetails (
ModuleID int NOT NULL,
StudentID int NOT NULL,
Presence bit NULL DEFAULT 1,
CONSTRAINT CourseModulesDetails_pk PRIMARY KEY (ModuleID,StudentID)
);

-- Table: StationaryModule
CREATE TABLE StationaryModule (
ModuleID int NOT NULL,
Room varchar(10) NOT NULL,
Limit int NULL DEFAULT 30 CHECK (Limit > 0),
CONSTRAINT StationaryModule_pk PRIMARY KEY (ModuleID)
);

-- Table: OnlineAsyncModule
CREATE TABLE OnlineAsyncModule (
ModuleID int NOT NULL,
VideoLink varchar(50) NOT NULL,
CONSTRAINT OnlineAsyncModule_pk PRIMARY KEY (ModuleID)
);

-- Table: OnlineSyncModule
CREATE TABLE OnlineSyncModule (
ModuleID int NOT NULL,
Link varchar(50) NOT NULL,
CONSTRAINT OnlineSyncModule_pk PRIMARY KEY (ModuleID)
);

-- Table: Studies
CREATE TABLE Studies (
    StudiesID int  NOT NULL,
    StudiesName varchar(50)  NOT NULL,
    StudiesDescription text  NULL,
    StudiesEntryFeePrice money  NOT NULL DEFAULT 1000 CHECK (StudiesEntryFeePrice > 0),
    StudiesCoordinator int  NOT NULL,
    PriceIncrease real  NULL DEFAULT 0.2 CHECK (PriceIncrease > 0),
    CONSTRAINT Studies_pk PRIMARY KEY  (StudiesID)
);

-- Table: StudiesDetails
CREATE TABLE StudiesDetails (
StudiesID int NOT NULL,
StudentID int NOT NULL,
StudiesGrade int NOT NULL,
CONSTRAINT StudiesDetails_pk PRIMARY KEY (StudiesID,StudentID)
);

-- Table: Internship
CREATE TABLE Internship (
    InternshipID int  NOT NULL,
    StudiesID int  NOT NULL,
    StartDate datetime  NOT NULL,
    CONSTRAINT Internship_pk PRIMARY KEY  (InternshipID)
);

-- Table: InternshipDetails
CREATE TABLE InternshipDetails (
    InternshipID int  NOT NULL,
    StudentID int  NOT NULL,
    DidAttend bit  NULL DEFAULT 1,
    CONSTRAINT InternshipDetails_pk PRIMARY KEY  (InternshipID,StudentID)
);

-- Table: Subject
CREATE TABLE Subject (
    SubjectID int  NOT NULL,
    StudiesID int  NOT NULL,
    CoordinatorID int  NOT NULL,
    SubjectName varchar(50)  NOT NULL,
    SubjectDescription text  NULL,
    CONSTRAINT Subject_pk PRIMARY KEY  (SubjectID)
);

-- Table: SubjectDetails
CREATE TABLE SubjectDetails (
    SubjectID int  NOT NULL,
    StudentID int  NOT NULL,
    SubjectGrade int  NOT NULL,
    CONSTRAINT SubjectDetails_pk PRIMARY KEY  (SubjectID,StudentID)
);

-- Table: StudyMeeting
CREATE TABLE StudyMeeting (
    StudyMeetingID int  NOT NULL,
    SubjectID int  NOT NULL,
    TeacherID int  NOT NULL,
    MeetingName varchar(50)  NOT NULL,
    MeetingPrice money  NOT NULL DEFAULT 100 CHECK (MeetingPrice > 0),
    Date datetime  NOT NULL,
    DurationTime time(0)  NULL DEFAULT 01:30:00 CHECK (DurationTime > '00:00:00'),
    TranslatorID int  NULL,
    LanguageID int  NULL,
    CONSTRAINT StudyMeeting_pk PRIMARY KEY  (StudyMeetingID)
);

-- Table: StudyMeetingDetails
CREATE TABLE StudyMeetingDetails (
    StudyMeetingID int  NOT NULL,
    StudentID int  NOT NULL,
    Presence bit  NULL DEFAULT 1,
    CONSTRAINT StudyMeetingDetails_pk PRIMARY KEY  (StudyMeetingID,StudentID)
);

-- Table: StationaryMeeting
CREATE TABLE StationaryMeeting (
    MeetingID int  NOT NULL,
    Room varchar(10)  NOT NULL,
    Limit int  NULL DEFAULT 30 CHECK (Limit > 0),
    CONSTRAINT StationaryMeeting_pk PRIMARY KEY  (MeetingID)
);

-- Table: OnlineAsyncMeeting
CREATE TABLE OnlineAsyncMeeting (
    MeetingID int  NOT NULL,
    VideoLink varchar(50)  NOT NULL,
    CONSTRAINT OnlineAsyncMeeting_pk PRIMARY KEY  (MeetingID)
);

-- Table: OnlineSyncMeeting
CREATE TABLE OnlineSyncMeeting (
    MeetingID int  NOT NULL,
    Link varchar(50)  NOT NULL,
    CONSTRAINT OnlineSyncMeeting_pk PRIMARY KEY  (MeetingID)
);

-- Table: PossibleGrades
CREATE TABLE PossibleGrades (
    GradeID int  NOT NULL,
    GradeValue real  NOT NULL CHECK (GradeValue > 0),
    GradeName varchar(20)  NOT NULL,
    CONSTRAINT PossibleGrades_pk PRIMARY KEY  (GradeID)
);

-- Table: Webinars
CREATE TABLE Webinars (
    WebinarID int  NOT NULL,
    TeacherID int  NOT NULL,
    TranslatorID int  NULL,
    WebinarName varchar(50)  NOT NULL,
    WebinarPrice money  NULL DEFAULT 500 CHECK (WebinarPrice >= 0),
    VideoLink varchar(50)  NOT NULL,
    WebinarDate datetime  NOT NULL,
    DurationTime time(0)  NULL DEFAULT 01:30:00 CHECK (DurationTime > '00:00:00'),
    WebinarDescription text  NULL,
    LanguageID int  NULL,
    CONSTRAINT Webinars_pk PRIMARY KEY  (WebinarID)
);

-- Table: WebinarDetails
CREATE TABLE WebinarDetails (
    StudentID int  NOT NULL,
    WebinarID int  NOT NULL,
    AvailableDue date  NOT NULL,
    CONSTRAINT WebinarDetails_pk PRIMARY KEY  (StudentID,WebinarID)
);

-- Table: Students
CREATE TABLE Students (
    StudentID int  NOT NULL,
    FirstName varchar(30)  NOT NULL,
    LastName varchar(30)  NOT NULL,
    Address varchar(30)  NOT NULL,
    CityID int  NOT NULL,
    PostalCode varchar(10)  NOT NULL,
    Phone varchar(15)  NULL CHECK (LEN(Phone) = 15 AND ISNUMERIC(Phone) = 1),
    Email varchar(50)  NOT NULL CHECK (Email LIKE '%_@__%.__%'),
    CONSTRAINT StudentsEmail UNIQUE (Email),
    CONSTRAINT StudentsPhone UNIQUE (Phone),
    CONSTRAINT Students_pk PRIMARY KEY  (StudentID)
);

-- Table: PossibleCity
CREATE TABLE PossibleCity (
    CityID int  NOT NULL,
    CityName varchar(20)  NOT NULL,
    CountryID int  NOT NULL,
    CONSTRAINT PossibleCity_pk PRIMARY KEY  (CityID)
);

-- Table: PossibleCountry
CREATE TABLE PossibleCountry (
    CountryID int  NOT NULL,
    CountryName varchar(20)  NOT NULL,
    CONSTRAINT PossibleCountry_pk PRIMARY KEY  (CountryID)
);

-- Table: Translators
CREATE TABLE Translators (
    TranslatorID int  NOT NULL,
    FirstName varchar(30)  NOT NULL,
    LastName varchar(30)  NOT NULL,
    HireDate date  NULL,
    BirthDate date  NULL,
    Phone varchar(15)  NULL CHECK (LEN(Phone) = 15 AND ISNUMERIC(Phone) = 1),
    Email varchar(50)  NOT NULL CHECK (Email LIKE '%_@__%.__%'),
    CONSTRAINT TranslatorsEmail UNIQUE (Email),
    CONSTRAINT TranslatorsPhone UNIQUE (Phone),
    CONSTRAINT Translators_pk PRIMARY KEY  (TranslatorID)
);

-- Table: TranslatorsLanguages
CREATE TABLE TranslatorsLanguages (
    TranslatorID int  NOT NULL,
    LanguageID int  NOT NULL,
    CONSTRAINT TranslatorsLanguages_pk PRIMARY KEY  (TranslatorID,LanguageID)
);

-- Table: PossibleLanguages
CREATE TABLE PossibleLanguages (
    LanguageID int  NOT NULL,
    LanguageName varchar(20)  NOT NULL,
    CONSTRAINT PossibleLanguages_pk PRIMARY KEY  (LanguageID)
);

-- Table: Employees
CREATE TABLE Employees (
    EmployeeID int  NOT NULL,
    FirstName varchar(30)  NOT NULL,
    LastName varchar(30)  NOT NULL,
    HireDate date  NULL,
    BirthDate date  NULL,
    Phone varchar(15)  NULL CHECK (LEN(Phone) = 15 AND ISNUMERIC(Phone) = 1),
    Email varchar(50)  NOT NULL CHECK (Email LIKE '%_@__%.__%'),
    EmployeeType int  NOT NULL,
    CONSTRAINT EmployeesEmail UNIQUE (Email),
    CONSTRAINT EmployeesPhone UNIQUE (Phone),
    CONSTRAINT Employees_pk PRIMARY KEY  (EmployeeID)
);

-- Table: EmployeeTypes
CREATE TABLE EmployeeTypes (
    EmployeeTypeID int  NOT NULL,
    EmployeeTypeName varchar(30)  NOT NULL,
    CONSTRAINT EmployeeTypes_pk PRIMARY KEY  (EmployeeTypeID)
);

-- Table: Orders
CREATE TABLE Orders (
OrderID int NOT NULL,
StudentID int NOT NULL,
Paid money NULL DEFAULT 0 CHECK (Paid >=0),
OrderDate datetime NOT NULL,
CONSTRAINT Orders_pk PRIMARY KEY (OrderID)
);

-- Table: OrderDetails
CREATE TABLE OrderDetails (
OrderDetailsID int NOT NULL,
OrderID int NOT NULL,
PaidDate datetime NOT NULL,
CONSTRAINT OrderDetails_pk PRIMARY KEY (OrderDetailsID)
);

-- Table: OrderStudies
CREATE TABLE OrderStudies (
OrderDetailsID int NOT NULL,
StudiesID int NOT NULL,
CONSTRAINT OrderStudies_pk PRIMARY KEY (OrderDetailsID)
);

-- Table: OrderStudyMeeting
CREATE TABLE OrderStudyMeeting (
OrderDetailsID int NOT NULL,
StudyMeetingID int NOT NULL,
CONSTRAINT OrderStudyMeeting_pk PRIMARY KEY (OrderDetailsID)
);

-- Table: OrderWebinars
CREATE TABLE OrderWebinars (
OrderDetailsID int NOT NULL,
WebinarID int NOT NULL,
CONSTRAINT OrderWebinars_pk PRIMARY KEY (OrderDetailsID)
);

-- Table: OrderCourse
CREATE TABLE OrderCourse (
OrderDetailsID int NOT NULL,
CourseID int NOT NULL,
CONSTRAINT OrderCourse_pk PRIMARY KEY (OrderDetailsID)
);

-- foreign keys
-- Reference: CourseDetails_Courses (table: CourseDetails)
ALTER TABLE CourseDetails ADD CONSTRAINT CourseDetails_Courses
FOREIGN KEY (CourseID)
REFERENCES Courses (CourseID);

-- Reference: CourseDetails_Students (table: CourseDetails)
ALTER TABLE CourseDetails ADD CONSTRAINT CourseDetails_Students
FOREIGN KEY (StudentID)
REFERENCES Students (StudentID);

-- Reference: CourseModulesDetails_CourseModules (table: CourseModulesDetails)
ALTER TABLE CourseModulesDetails ADD CONSTRAINT CourseModulesDetails_CourseModules
FOREIGN KEY (ModuleID)
REFERENCES CourseModules (ModuleID);

-- Reference: CourseModulesDetails_Students (table: CourseModulesDetails)
ALTER TABLE CourseModulesDetails ADD CONSTRAINT CourseModulesDetails_Students
FOREIGN KEY (StudentID)
REFERENCES Students (StudentID);

-- Reference: CourseModules_Courses (table: CourseModules)
ALTER TABLE CourseModules ADD CONSTRAINT CourseModules_Courses
FOREIGN KEY (CourseID)
REFERENCES Courses (CourseID);

-- Reference: CourseModules_OnlineAsynchronicModule (table: OnlineAsyncModule)
ALTER TABLE OnlineAsyncModule ADD CONSTRAINT CourseModules_OnlineAsynchronicModule
FOREIGN KEY (ModuleID)
REFERENCES CourseModules (ModuleID);

-- Reference: CourseModules_OnlineSynchronicModule (table: OnlineSyncModule)
ALTER TABLE OnlineSyncModule ADD CONSTRAINT CourseModules_OnlineSynchronicModule
FOREIGN KEY (ModuleID)
REFERENCES CourseModules (ModuleID);

-- Reference: CourseModules_PossibleLanguages (table: CourseModules)
ALTER TABLE CourseModules ADD CONSTRAINT CourseModules_PossibleLanguages
FOREIGN KEY (LanguageID)
REFERENCES PossibleLanguages (LanguageID);

-- Reference: CourseModules_Translators (table: CourseModules)
ALTER TABLE CourseModules ADD CONSTRAINT CourseModules_Translators
FOREIGN KEY (TranslatorID)
REFERENCES Translators (TranslatorID);

-- Reference: Courses_Teachers_Coordinators (table: Courses)
ALTER TABLE Courses ADD CONSTRAINT Courses_Teachers_Coordinators
FOREIGN KEY (CourseCoordinatorID)
REFERENCES Employees (EmployeeID);

-- Reference: InternshipDetails_Internship (table: InternshipDetails)
ALTER TABLE InternshipDetails ADD CONSTRAINT InternshipDetails_Internship
FOREIGN KEY (InternshipID)
REFERENCES Internship (InternshipID);

-- Reference: InternshipDetails_Students (table: InternshipDetails)
ALTER TABLE InternshipDetails ADD CONSTRAINT InternshipDetails_Students
FOREIGN KEY (StudentID)
REFERENCES Students (StudentID);

-- Reference: Internship_Studies (table: Internship)
ALTER TABLE Internship ADD CONSTRAINT Internship_Studies
FOREIGN KEY (StudiesID)
REFERENCES Studies (StudiesID);

-- Reference: OrderCourse_Courses (table: OrderCourse)
ALTER TABLE OrderCourse ADD CONSTRAINT OrderCourse_Courses
FOREIGN KEY (CourseID)
REFERENCES Courses (CourseID);

-- Reference: OrderCourse_OrderDetails (table: OrderCourse)
ALTER TABLE OrderCourse ADD CONSTRAINT OrderCourse_OrderDetails
FOREIGN KEY (OrderDetailsID)
REFERENCES OrderDetails (OrderDetailsID);

-- Reference: OrderDetails_Orders (table: OrderDetails)
ALTER TABLE OrderDetails ADD CONSTRAINT OrderDetails_Orders
FOREIGN KEY (OrderID)
REFERENCES Orders (OrderID);

-- Reference: OrderStudies_OrderDetails (table: OrderStudies)
ALTER TABLE OrderStudies ADD CONSTRAINT OrderStudies_OrderDetails
FOREIGN KEY (OrderDetailsID)
REFERENCES OrderDetails (OrderDetailsID);

-- Reference: OrderStudies_Studies (table: OrderStudies)
ALTER TABLE OrderStudies ADD CONSTRAINT OrderStudies_Studies
FOREIGN KEY (StudiesID)
REFERENCES Studies (StudiesID);

-- Reference: OrderStudyMeeting_OrderDetails (table: OrderStudyMeeting)
ALTER TABLE OrderStudyMeeting ADD CONSTRAINT OrderStudyMeeting_OrderDetails
FOREIGN KEY (OrderDetailsID)
REFERENCES OrderDetails (OrderDetailsID);

-- Reference: OrderStudyMeeting_StudyMeeting (table: OrderStudyMeeting)
ALTER TABLE OrderStudyMeeting ADD CONSTRAINT OrderStudyMeeting_StudyMeeting
FOREIGN KEY (StudyMeetingID)
REFERENCES StudyMeeting (StudyMeetingID);

-- Reference: OrderWebinars_OrderDetails (table: OrderWebinars)
ALTER TABLE OrderWebinars ADD CONSTRAINT OrderWebinars_OrderDetails
FOREIGN KEY (OrderDetailsID)
REFERENCES OrderDetails (OrderDetailsID);

-- Reference: Orders_Students (table: Orders)
ALTER TABLE Orders ADD CONSTRAINT Orders_Students
FOREIGN KEY (StudentID)
REFERENCES Students (StudentID);

-- Reference: PossibleCity_PossibleCountry (table: PossibleCity)
ALTER TABLE PossibleCity ADD CONSTRAINT PossibleCity_PossibleCountry
FOREIGN KEY (CountryID)
REFERENCES PossibleCountry (CountryID);

-- Reference: PossibleLanguages_TranslatorsLanguages (table: TranslatorsLanguages)
ALTER TABLE TranslatorsLanguages ADD CONSTRAINT PossibleLanguages_TranslatorsLanguages
FOREIGN KEY (LanguageID)
REFERENCES PossibleLanguages (LanguageID);

-- Reference: StationaryCourse_CourseModules (table: StationaryModule)
ALTER TABLE StationaryModule ADD CONSTRAINT StationaryCourse_CourseModules
FOREIGN KEY (ModuleID)
REFERENCES CourseModules (ModuleID);

-- Reference: Students_PossibleCity (table: Students)
ALTER TABLE Students ADD CONSTRAINT Students_PossibleCity
FOREIGN KEY (CityID)
REFERENCES PossibleCity (CityID);

-- Reference: StudiesDetails_PossibleGrades (table: StudiesDetails)
ALTER TABLE StudiesDetails ADD CONSTRAINT StudiesDetails_PossibleGrades
FOREIGN KEY (StudiesGrade)
REFERENCES PossibleGrades (GradeID);

-- Reference: StudiesDetails_Students (table: StudiesDetails)
ALTER TABLE StudiesDetails ADD CONSTRAINT StudiesDetails_Students
FOREIGN KEY (StudentID)
REFERENCES Students (StudentID);

-- Reference: StudiesDetails_Studies (table: StudiesDetails)
ALTER TABLE StudiesDetails ADD CONSTRAINT StudiesDetails_Studies
FOREIGN KEY (StudiesID)
REFERENCES Studies (StudiesID);

-- Reference: Studies_Teachers_Coordinators (table: Studies)
ALTER TABLE Studies ADD CONSTRAINT Studies_Teachers_Coordinators
FOREIGN KEY (StudiesCoordinator)
REFERENCES Employees (EmployeeID);

-- Reference: StudyMeetingDetails_Students (table: StudyMeetingDetails)
ALTER TABLE StudyMeetingDetails ADD CONSTRAINT StudyMeetingDetails_Students
FOREIGN KEY (StudentID)
REFERENCES Students (StudentID);

-- Reference: StudyMeetingDetails_StudyMeeting (table: StudyMeetingDetails)
ALTER TABLE StudyMeetingDetails ADD CONSTRAINT StudyMeetingDetails_StudyMeeting
FOREIGN KEY (StudyMeetingID)
REFERENCES StudyMeeting (StudyMeetingID);

-- Reference: StudyMeeting_OnlineAsyncMeeting (table: OnlineAsyncMeeting)
ALTER TABLE OnlineAsyncMeeting ADD CONSTRAINT StudyMeeting_OnlineAsyncMeeting
FOREIGN KEY (MeetingID)
REFERENCES StudyMeeting (StudyMeetingID);

-- Reference: StudyMeeting_OnlineSyncMeeting (table: OnlineSyncMeeting)
ALTER TABLE OnlineSyncMeeting ADD CONSTRAINT StudyMeeting_OnlineSyncMeeting
FOREIGN KEY (MeetingID)
REFERENCES StudyMeeting (StudyMeetingID);

-- Reference: StudyMeeting_PossibleLanguages (table: StudyMeeting)
ALTER TABLE StudyMeeting ADD CONSTRAINT StudyMeeting_PossibleLanguages
FOREIGN KEY (LanguageID)
REFERENCES PossibleLanguages (LanguageID);

-- Reference: StudyMeeting_StationaryMeeting (table: StationaryMeeting)
ALTER TABLE StationaryMeeting ADD CONSTRAINT StudyMeeting_StationaryMeeting
FOREIGN KEY (MeetingID)
REFERENCES StudyMeeting (StudyMeetingID);

-- Reference: StudyMeeting_Subject (table: StudyMeeting)
ALTER TABLE StudyMeeting ADD CONSTRAINT StudyMeeting_Subject
FOREIGN KEY (SubjectID)
REFERENCES Subject (SubjectID);

-- Reference: StudyMeeting_Teachers_Coordinators (table: StudyMeeting)
ALTER TABLE StudyMeeting ADD CONSTRAINT StudyMeeting_Teachers_Coordinators
FOREIGN KEY (TeacherID)
REFERENCES Employees (EmployeeID);

-- Reference: StudyMeeting_Translators (table: StudyMeeting)
ALTER TABLE StudyMeeting ADD CONSTRAINT StudyMeeting_Translators
FOREIGN KEY (TranslatorID)
REFERENCES Translators (TranslatorID);

-- Reference: SubjectDetails_PossibleGrades (table: SubjectDetails)
ALTER TABLE SubjectDetails ADD CONSTRAINT SubjectDetails_PossibleGrades
FOREIGN KEY (SubjectGrade)
REFERENCES PossibleGrades (GradeID);

-- Reference: SubjectDetails_Students (table: SubjectDetails)
ALTER TABLE SubjectDetails ADD CONSTRAINT SubjectDetails_Students
FOREIGN KEY (StudentID)
REFERENCES Students (StudentID);

-- Reference: SubjectDetails_Subject (table: SubjectDetails)
ALTER TABLE SubjectDetails ADD CONSTRAINT SubjectDetails_Subject
FOREIGN KEY (SubjectID)
REFERENCES Subject (SubjectID);

-- Reference: Subject_Studies (table: Subject)
ALTER TABLE Subject ADD CONSTRAINT Subject_Studies
FOREIGN KEY (StudiesID)
REFERENCES Studies (StudiesID);

-- Reference: Subject_Teachers_Coordinators (table: Subject)
ALTER TABLE Subject ADD CONSTRAINT Subject_Teachers_Coordinators
FOREIGN KEY (CoordinatorID)
REFERENCES Employees (EmployeeID);

-- Reference: Teachers_CoordinatorTypes (table: Employees)
ALTER TABLE Employees ADD CONSTRAINT Teachers_CoordinatorTypes
FOREIGN KEY (EmployeeType)
REFERENCES EmployeeTypes (EmployeeTypeID);

-- Reference: Teachers_Coordinators_CourseModules (table: CourseModules)
ALTER TABLE CourseModules ADD CONSTRAINT Teachers_Coordinators_CourseModules
FOREIGN KEY (TeacherID)
REFERENCES Employees (EmployeeID);

-- Reference: Teachers_Webinars (table: Webinars)
ALTER TABLE Webinars ADD CONSTRAINT Teachers_Webinars
FOREIGN KEY (TeacherID)
REFERENCES Employees (EmployeeID);

-- Reference: TranslatorsLanguages_Translators (table: TranslatorsLanguages)
ALTER TABLE TranslatorsLanguages ADD CONSTRAINT TranslatorsLanguages_Translators
FOREIGN KEY (TranslatorID)
REFERENCES Translators (TranslatorID);

-- Reference: Translators_Webinars (table: Webinars)
ALTER TABLE Webinars ADD CONSTRAINT Translators_Webinars
FOREIGN KEY (TranslatorID)
REFERENCES Translators (TranslatorID);

-- Reference: WebinarDetails_Students (table: WebinarDetails)
ALTER TABLE WebinarDetails ADD CONSTRAINT WebinarDetails_Students
FOREIGN KEY (StudentID)
REFERENCES Students (StudentID);

-- Reference: WebinarDetails_Webinars (table: WebinarDetails)
ALTER TABLE WebinarDetails ADD CONSTRAINT WebinarDetails_Webinars
FOREIGN KEY (WebinarID)
REFERENCES Webinars (WebinarID);

-- Reference: Webinars_OrderWebinars (table: OrderWebinars)
ALTER TABLE OrderWebinars ADD CONSTRAINT Webinars_OrderWebinars
FOREIGN KEY (WebinarID)
REFERENCES Webinars (WebinarID);

-- Reference: Webinars_PossibleLanguages (table: Webinars)
ALTER TABLE Webinars ADD CONSTRAINT Webinars_PossibleLanguages
FOREIGN KEY (LanguageID)
REFERENCES PossibleLanguages (LanguageID);