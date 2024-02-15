# Kod generujący zależności między tabelami

```sql
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
```