CREATE INDEX StudyMeeting_Time
ON StudyMeeting (Date, DurationTime)

CREATE INDEX CourseModule_Time
ON CourseModules (Date, DurationTime)

CREATE INDEX Webinar_Time
ON Webinars (WebinarDate, DurationTime)

CREATE INDEX StudyMeeting_Price
ON StudyMeeting (MeetingPrice)

CREATE INDEX Study_Price
ON Studies (StudiesEntryFeePrice)

CREATE INDEX Course_Price
ON Courses (CoursePrice)

CREATE INDEX Webinar_Price
ON Webinars (WebinarPrice)

CREATE INDEX CourseDetails_CourseID ON CourseDetails (CourseID);
CREATE INDEX CourseDetails_StudentID ON CourseDetails (StudentID);

CREATE INDEX CourseModulesDetails_ModuleID ON CourseModulesDetails (ModuleID);
CREATE INDEX CourseModulesDetails_StudentID ON CourseModulesDetails (StudentID);

CREATE INDEX CourseModules_CourseID ON CourseModules (CourseID);
CREATE INDEX CourseModules_TeacherID ON CourseModules (TeacherID);
CREATE INDEX CourseModules_LanguageID ON CourseModules (LanguageID);
CREATE INDEX CourseModules_TranslatorID ON CourseModules (TranslatorID);

CREATE INDEX Courses_CourseCoordinatorID ON Courses (CourseCoordinatorID);

CREATE INDEX Employees_EmployeeType ON Employees (EmployeeType);

CREATE INDEX InternshipDetails_InternshipID ON InternshipDetails (InternshipID);
CREATE INDEX InternshipDetails_StudentID ON InternshipDetails (StudentID);

CREATE INDEX Internship_StudiesID ON Internship (StudiesID);

CREATE INDEX OrderCourse_CourseID ON OrderCourse (CourseID);

CREATE INDEX OrderDetails_OrderID ON OrderDetails (OrderID);
CREATE INDEX OrderDetails_PaidDate ON OrderDetails (PaidDate);

CREATE INDEX OrderStudies_StudiesID ON OrderStudies (StudiesID);

CREATE INDEX OrderStudyMeeting_StudyMeetingID ON OrderStudyMeeting (StudyMeetingID);

CREATE INDEX OrderWebinars_WebinarID ON OrderWebinars (WebinarID);

CREATE INDEX Orders_StudentID ON Orders (StudentID);

CREATE INDEX PossibleCity_CountryID ON PossibleCity (CountryID);

CREATE INDEX Students_CityID ON Students (CityID);

CREATE INDEX StudiesDetails_StudiesID ON StudiesDetails (StudiesID);
CREATE INDEX StudiesDetails_StudentID ON StudiesDetails (StudentID);
CREATE INDEX StudiesDetails_StudiesGrade ON StudiesDetails (StudiesGrade);

CREATE INDEX Studies_StudiesCoordinator ON Studies (StudiesCoordinator);

CREATE INDEX StudyMeetingDetails_StudyMeetingID ON StudyMeetingDetails (StudyMeetingID);
CREATE INDEX StudyMeetingDetails_StudentID ON StudyMeetingDetails (StudentID);

CREATE INDEX StudyMeeting_SubjectID ON StudyMeeting (SubjectID);
CREATE INDEX StudyMeeting_TeacherID ON StudyMeeting (TeacherID);
CREATE INDEX StudyMeeting_LanguageID ON StudyMeeting (LanguageID);
CREATE INDEX StudyMeeting_TranslatorID ON StudyMeeting (TranslatorID);

CREATE INDEX SubjectDetails_SubjectID ON SubjectDetails (SubjectID);
CREATE INDEX SubjectDetails_StudentID ON SubjectDetails (StudentID);
CREATE INDEX SubjectDetails_SubjectGrade ON SubjectDetails (SubjectGrade);

CREATE INDEX Subject_StudiesID ON Subject (StudiesID);
CREATE INDEX Subject_CoordinatorID ON Subject (CoordinatorID);

CREATE INDEX TranslatorsLanguages_TranslatorID ON TranslatorsLanguages (TranslatorID);
CREATE INDEX TranslatorsLanguages_LanguageID ON TranslatorsLanguages (LanguageID);

CREATE INDEX WebinarDetails_StudentID ON WebinarDetails (StudentID);
CREATE INDEX WebinarDetails_WebinarID ON WebinarDetails (WebinarID);

CREATE INDEX Webinars_TeacherID ON Webinars (TeacherID);
CREATE INDEX Webinars_TranslatorID ON Webinars (TranslatorID);
CREATE INDEX Webinars_LanguageID ON Webinars (LanguageID);