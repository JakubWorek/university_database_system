# Indeksy

## Indeksy ram czasowych oraz cen

### Ramy czasowe spotkania studyjnego

```sql
CREATE INDEX StudyMeeting_Time
ON StudyMeeting (Date, DurationTime)
```

### Ramy czasowe modułu w ramach kursu

```sql
CREATE INDEX CourseModule_Time
ON CourseModules (Date, DurationTime)
```

### Ramy czasowe webinaru

```sql
CREATE INDEX Webinar_Time
ON Webinars (WebinarDate, DurationTime)
```

### Cena za pojedyncze spotkanie studyjne

```sql
CREATE INDEX StudyMeeting_Price
ON StudyMeeting (MeetingPrice)
```

### Cena za cały kierunek studiów

```sql
CREATE INDEX Study_Price
ON Studies (StudiesEntryFeePrice)
```

### Cena za kurs

```sql
CREATE INDEX Course_Price
ON Courses (CoursePrice)
```

### Cena za webinar

```sql
CREATE INDEX Webinar_Price
ON Webinars (WebinarPrice)
```

## Indeksy na kluczach obcych

### Tabela CourseDetails

```sql
CREATE INDEX CourseDetails_CourseID ON CourseDetails (CourseID);
CREATE INDEX CourseDetails_StudentID ON CourseDetails (StudentID);
```

### Tabela CourseModulesDetails

```sql
CREATE INDEX CourseModulesDetails_ModuleID ON CourseModulesDetails (ModuleID);
CREATE INDEX CourseModulesDetails_StudentID ON CourseModulesDetails (StudentID);
```

### Tabela CourseModules

```sql
CREATE INDEX CourseModules_CourseID ON CourseModules (CourseID);
CREATE INDEX CourseModules_TeacherID ON CourseModules (TeacherID);
CREATE INDEX CourseModules_LanguageID ON CourseModules (LanguageID);
CREATE INDEX CourseModules_TranslatorID ON CourseModules (TranslatorID);
```

### Tabela Courses

```sql
CREATE INDEX Courses_CourseCoordinatorID ON Courses (CourseCoordinatorID);
```

### Tabela Employees

```sql
CREATE INDEX Employees_EmployeeType ON Employees (EmployeeType);
```

### Tabela InternshipDetails

```sql
CREATE INDEX InternshipDetails_InternshipID ON InternshipDetails (InternshipID);
CREATE INDEX InternshipDetails_StudentID ON InternshipDetails (StudentID);
```

### Tabela Internship

```sql
CREATE INDEX Internship_StudiesID ON Internship (StudiesID);
```

### Tabela OrderCourse

```sql
CREATE INDEX OrderCourse_CourseID ON OrderCourse (CourseID);
Tabela OrderDetails
CREATE INDEX OrderDetails_OrderID ON OrderDetails (OrderID);
CREATE INDEX OrderDetails_PaidDate ON OrderDetails (PaidDate);
```

### Tabela OrderStudies

```sql
CREATE INDEX OrderStudies_StudiesID ON OrderStudies (StudiesID);
```

### Tabela OrderStudyMeeting

```sql
CREATE INDEX OrderStudyMeeting_StudyMeetingID ON OrderStudyMeeting (StudyMeetingID);
```

### Tabela OrderWebinars

```sql
CREATE INDEX OrderWebinars_WebinarID ON OrderWebinars (WebinarID);
```

### Tabela Orders

```sql
CREATE INDEX Orders_StudentID ON Orders (StudentID);
```

### Tabela PossibleCity

```sql
CREATE INDEX PossibleCity_CountryID ON PossibleCity (CountryID);
```

### Tabela Students

```sql
CREATE INDEX Students_CityID ON Students (CityID);
```

### Tabela StudiesDetails

```sql
CREATE INDEX StudiesDetails_StudiesID ON StudiesDetails (StudiesID);
CREATE INDEX StudiesDetails_StudentID ON StudiesDetails (StudentID);
CREATE INDEX StudiesDetails_StudiesGrade ON StudiesDetails (StudiesGrade);
```

### Tabela Studies

```sql
CREATE INDEX Studies_StudiesCoordinator ON Studies (StudiesCoordinator);
```

### Tabela StudyMeetingDetails

```sql
CREATE INDEX StudyMeetingDetails_StudyMeetingID ON StudyMeetingDetails (StudyMeetingID);
CREATE INDEX StudyMeetingDetails_StudentID ON StudyMeetingDetails (StudentID);
```

### Tabela StudyMeeting

```sql
CREATE INDEX StudyMeeting_SubjectID ON StudyMeeting (SubjectID);
CREATE INDEX StudyMeeting_TeacherID ON StudyMeeting (TeacherID);
CREATE INDEX StudyMeeting_LanguageID ON StudyMeeting (LanguageID);
CREATE INDEX StudyMeeting_TranslatorID ON StudyMeeting (TranslatorID);
```

### Tabela SubjectDetails

```sql
CREATE INDEX SubjectDetails_SubjectID ON SubjectDetails (SubjectID);
CREATE INDEX SubjectDetails_StudentID ON SubjectDetails (StudentID);
CREATE INDEX SubjectDetails_SubjectGrade ON SubjectDetails (SubjectGrade);
```

### Tabela Subject

```sql
CREATE INDEX Subject_StudiesID ON Subject (StudiesID);
CREATE INDEX Subject_CoordinatorID ON Subject (CoordinatorID);
```

### Tabela TranslatorsLanguages

```sql
CREATE INDEX TranslatorsLanguages_TranslatorID ON TranslatorsLanguages (TranslatorID);
CREATE INDEX TranslatorsLanguages_LanguageID ON TranslatorsLanguages (LanguageID);
```

### Tabela WebinarDetails

```sql
CREATE INDEX WebinarDetails_StudentID ON WebinarDetails (StudentID);
CREATE INDEX WebinarDetails_WebinarID ON WebinarDetails (WebinarID);
```

### Tabela Webinars

```sql
CREATE INDEX Webinars_TeacherID ON Webinars (TeacherID);
CREATE INDEX Webinars_TranslatorID ON Webinars (TranslatorID);
CREATE INDEX Webinars_LanguageID ON Webinars (LanguageID);
```
