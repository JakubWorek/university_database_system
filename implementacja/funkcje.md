# Funkcje

## Zliczenie frekwencji danego uczestnika na danym kursie

```sql
CREATE FUNCTION GetCourseAttendanceForStudent(@StudentID int, @CourseID int)
RETURNS REAL
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM Students WHERE StudentID = @StudentID)
    BEGIN
        --jeżeli nie znaleziono studenta
        RETURN 0.0;
    END

    IF NOT EXISTS (SELECT * FROM Courses WHERE CourseID = @CourseID)
    BEGIN
        --jeżeli nie znaleziono kursu
        RETURN 0.0;
    END

    IF NOT EXISTS (SELECT * FROM CourseModulesDetails AS cmd
        JOIN CourseModules AS cm ON cmd.ModuleID = cm.ModuleID
        WHERE StudentID = @StudentID AND CourseID = @CourseID)
    BEGIN
        --jeżeli student nie był zapisany na ten kurs
        RETURN 0.0;
    END


    DECLARE @AttendanceCount INT;
    DECLARE @ModulesCount INT;

    SELECT @AttendanceCount = COUNT(*)
    FROM CourseModulesDetails AS cmd JOIN CourseModules AS cm
    ON cmd.ModuleID = cm.ModuleID
    WHERE StudentID = @StudentID AND Presence = 1 AND CourseID = @CourseID AND Date < GETDATE();

    SELECT @AttendanceCount = COUNT(*)
    FROM CourseModulesDetails AS cmd JOIN CourseModules AS cm
    ON cmd.ModuleID = cm.ModuleID
    WHERE StudentID = @StudentID AND CourseID = @CourseID AND Date < GETDATE();

    RETURN @AttendanceCount / @ModulesCount;
END;
```

## Zliczenie frekwencji danego uczestnika na danym przedmiocie na studiach

```sql
CREATE FUNCTION GetSubjectAttendanceForStudent(@StudentID int, @SubjectID int)
RETURNS REAL
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM Students WHERE StudentID = @StudentID)
    BEGIN
        --jeżeli nie znaleziono studenta
        RETURN 0.0;
    END

    IF NOT EXISTS (SELECT * FROM Subject WHERE SubjectID = @SubjectID)
    BEGIN
        --jeżeli nie znaleziono przedmiotu
        RETURN 0.0;
    END

    IF NOT EXISTS (SELECT * FROM StudyMeetingDetails AS smd
        JOIN StudyMeeting AS sm ON smd.StudyMeetingID = sm.StudyMeetingID
        WHERE StudentID = @StudentID AND SubjectID = @SubjectID)
    BEGIN
        --jeżeli student nie był zapisany na zajęcia z tego przedmiotu
        RETURN 0.0;
    END


    DECLARE @AttendanceCount INT;
    DECLARE @MeetingsCount INT;

    SELECT @AttendanceCount = COUNT(*)
    FROM StudyMeetingDetails AS smd JOIN StudyMeeting AS sm
    ON smd.StudyMeetingID = sm.StudyMeetingID
    WHERE StudentID = @StudentID AND Presence = 1 AND SubjectID = @SubjectID AND Date < GETDATE();

    SELECT @MeetingsCount = COUNT(*)
    FROM StudyMeetingDetails AS smd JOIN StudyMeeting AS sm
    ON smd.StudyMeetingID = sm.StudyMeetingID
    WHERE StudentID = @StudentID AND SubjectID = @SubjectID AND Date < GETDATE();

    RETURN @AttendanceCount / @MeetingsCount;
END;
```

## Wyliczenie maksymalnej ilości miejsc na kursie

```sql
CREATE FUNCTION GetMaxCourseCapacity(@CourseID int)
RETURNS int
AS
BEGIN
    DECLARE @MaxCapacity int;

    SELECT @MaxCapacity = MIN(StationaryModule.Limit)
    FROM StationaryModule
    INNER JOIN CourseModules ON StationaryModule.ModuleID = CourseModules.ModuleID
    WHERE CourseModules.CourseID = @CourseID;

    RETURN @MaxCapacity -- if there are no stationary meetings there is no limit so function returns NULL
END
```

## Wyliczenie maksymalnej ilości miejsc na studiach

```sql
CREATE FUNCTION GetMaxStudyCapacity(@StudiesID int)
RETURNS int
AS
BEGIN
    DECLARE @MaxCapacity int;

    SELECT @MaxCapacity = MIN(StationaryMeeting.Limit)
    FROM StationaryMeeting
    INNER JOIN StudyMeeting ON StationaryMeeting.MeetingID = StudyMeeting.StudyMeetingID
    INNER JOIN Subject ON StudyMeeting.SubjectID = Subject.SubjectID
    WHERE Subject.StudiesID = @StudiesID;

    RETURN @MaxCapacity -- if there are no stationary meetings there is no limit so function returns NULL
END
```

## Sprawdzenie czy student odbył praktyki raz na pół roku i czy miał na nich 100% frekwencji

```sql
CREATE FUNCTION CheckStudentInternships(@StudentID int)
RETURNS bit
AS
BEGIN
    DECLARE @Result bit = 0
-- Sprawdzamy, czy student o danym ID należy do jakichkolwiek studiów
    IF EXISTS (SELECT 1 FROM StudiesDetails WHERE StudentID = @StudentID)
    BEGIN
        -- Sprawdzamy, które praktyki są przypisane do danych studiów i czy już się zakończyły
        IF NOT EXISTS (
            SELECT 1
            FROM Internship i
            INNER JOIN StudiesDetails ss ON i.StudiesID = ss.StudiesID
            WHERE ss.StudentID = @StudentID
            AND i.StartDate <= GETDATE() - 14 -- Praktyki trwają zawsze 14 dni
        )
        BEGIN
            -- Sprawdzamy, czy student zaliczył wszystkie praktyki
            IF NOT EXISTS (
                SELECT 1
                FROM InternshipDetails id
                INNER JOIN Internship i ON id.InternshipID = i.InternshipID
                WHERE i.StartDate <= GETDATE() - 14
                AND id.StudentID = @StudentID
                AND id.DidAttend = 0 -- Jeżeli istnieje praktyka, której student nie zaliczył
            )
            BEGIN
                SET @Result = 1 -- Zwracamy true, jeżeli student odbył wszystkie praktyki
            END
        END
    END

    RETURN @Result
END
```

## Sprawdzenie, czy podana kombinacja tłumacza i języka jest dozwolona (albo obu nie podano, albo jeżeli podano. to tłumacz zna język)

```sql
CREATE FUNCTION CheckTranslatorLanguage
(@TranslatorID int null, @LanguageID int null)
RETURNS bit AS
BEGIN
    IF @TranslatorID IS NOT NULL AND NOT EXISTS (SELECT * FROM Translators WHERE TranslatorID = @TranslatorID)
    BEGIN
        RETURN CAST(0 AS bit)
    END

    IF @LanguageID IS NOT NULL AND NOT EXISTS (SELECT * FROM PossibleLanguages WHERE LanguageID = @LanguageID)
    BEGIN
        RETURN CAST(0 AS bit)
    END

    IF @TranslatorID IS NULL AND @LanguageID IS NOT NULL
    BEGIN
        RETURN CAST(0 AS bit)
    END

    IF @TranslatorID IS NOT NULL AND @LanguageID IS NULL
    BEGIN
        RETURN CAST(0 AS bit)
    END

    IF @TranslatorID IS NOT NULL AND @LanguageID IS NOT NULL AND NOT EXISTS (SELECT * FROM TranslatorsLanguages WHERE TranslatorID = @TranslatorID AND LanguageID = @LanguageID)
    BEGIN
        RETURN CAST(0 AS bit)
    END

    RETURN CAST(1 AS bit)
END
```

## Wyliczenie wolnych miejsc na dany kierunek studiów

```sql
CREATE FUNCTION HowManyStudyVacancies(@StudiesID int)
RETURNS int
AS
BEGIN
    DECLARE @MaximumCapacity int;
    SELECT @MaximumCapacity = dbo.GetMaxStudyCapacity(@StudiesID);

    IF @MaximumCapacity IS NULL
    BEGIN
        RETURN @MaximumCapacity
    END

    DECLARE @CurrentCapacity int;
    SELECT @CurrentCapacity = COUNT(*)
        FROM Students
        WHERE StudentID IN (
            SELECT s.StudentID
            FROM Students AS s
            JOIN StudiesDetails AS sd
            ON s.StudentID = sd.StudentID
            WHERE sd.StudiesID = @StudiesID);

    RETURN @MaximumCapacity - @CurrentCapacity
END
```

## Wyliczenie wolnych miejsc na dany kurs

```sql
CREATE FUNCTION HowManyCourseVacancies(@CourseID int)
RETURNS int
AS
BEGIN
    DECLARE @MaximumCapacity int;
    SELECT @MaximumCapacity = dbo.GetMaxCourseCapacity(@CourseID);

    IF @MaximumCapacity IS NULL
    BEGIN
        RETURN @MaximumCapacity
    END

    DECLARE @CurrentCapacity int;
    SELECT @CurrentCapacity = COUNT(*)
        FROM Students
        WHERE StudentID IN (
            SELECT s.StudentID
            FROM Students AS s
            JOIN CourseDetails AS cd
            ON s.StudentID = cd.StudentID
            WHERE cd.CourseID = @CourseID);

    RETURN @MaximumCapacity - @CurrentCapacity
END
```

## Obliczenie łącznej wartości zamówienia

```sql
CREATE FUNCTION GetOrderValue(@OrderID int)
RETURNS money
AS
BEGIN
    DECLARE @StudiesSum money
    DECLARE @StudyMeetingsSum money
    DECLARE @CoursesSum money
    DECLARE @WebinarsSum money

    SELECT @StudiesSum = ISNULL(SUM(s.StudiesEntryFeePrice), 0)
    FROM Studies AS s
    JOIN OrderStudies AS os ON s.StudiesID = os.StudiesID
    JOIN OrderDetails AS od ON os.OrderDetailsID = od.OrderDetailsID
    WHERE od.OrderID = @OrderID

    SELECT @StudyMeetingsSum = ISNULL(SUM(sm.MeetingPrice), 0)
    FROM Studies AS s
    JOIN Subject AS su ON s.StudiesID = su.StudiesID
    JOIN StudyMeeting AS sm ON su.SubjectID = sm.SubjectID
    JOIN OrderStudies AS os ON s.StudiesID = os.StudiesID
    JOIN OrderDetails AS od ON os.OrderDetailsID = od.OrderDetailsID
    WHERE od.OrderID = @OrderID

    SELECT @CoursesSum = ISNULL(SUM(c.CoursePrice), 0)
    FROM Courses AS c
    JOIN OrderCourse AS oc ON c.CourseID = oc.CourseID
    JOIN OrderDetails AS od ON oc.OrderDetailsID = od.OrderDetailsID
    WHERE od.OrderID = @OrderID

    SELECT @WebinarsSum = ISNULL(SUM(w.WebinarPrice), 0)
    FROM Webinars AS w
    JOIN OrderWebinars AS ow ON w.WebinarID = ow.WebinarID
    JOIN OrderDetails AS od ON ow.OrderDetailsID = od.OrderDetailsID
    WHERE od.OrderID = @OrderID

    SELECT @StudyMeetingsSum =  @StudyMeetingsSum +
    ISNULL(SUM(sm.MeetingPrice * (1 + s.PriceIncrease)), 0)


    FROM StudyMeeting AS sm
    JOIN OrderStudyMeeting AS osm ON sm.StudyMeetingID = osm.StudyMeetingID
    JOIN OrderDetails AS od ON osm.OrderDetailsID = od.OrderDetailsID
    JOIN Subject AS su ON sm.SubjectID = su.SubjectID
    JOIN Studies AS s ON su.StudiesID = s.StudiesID
    WHERE od.OrderID = @OrderID

    RETURN @StudiesSum + @CoursesSum + @WebinarsSum + @StudyMeetingsSum
END
```

## Harmonogram danego kierunku studiów

```sql
CREATE FUNCTION GetStudySchedule(@StudiesID int)
RETURNS TABLE
AS
RETURN
    (SELECT StudyMeetingID, MeetingName, Date, DurationTime
    FROM dbo.ALL_STUDIES_TIMETABLE
    WHERE StudiesID = @StudiesID)
```

## Harmonogram danego kursu

```sql
CREATE FUNCTION GetCourseSchedule(@CourseID int)
RETURNS TABLE
AS
RETURN
    (SELECT ModuleID, ModuleName, Date, DurationTime
    FROM dbo.ALL_COURSES_TIMETABLE
    WHERE CourseID = @CourseID)
```

## Harmonogram zajęć dla studenta

```sql
CREATE FUNCTION GetTimeTableForStudent(@StudentID int)
RETURNS TABLE
AS
RETURN
(
    SELECT 'Study Meeting' AS 'Event type', ss.StudyMeetingID AS 'Event ID',
           ss.MeetingName AS 'Event Name', ss.Date, ss.DurationTime
    FROM dbo.ALL_STUDIES_TIMETABLE ss
    WHERE ss.StudiesID IN
        (SELECT sd.StudiesID
         FROM StudiesDetails AS sd
         WHERE sd.StudentID = @StudentID)
    UNION
    SELECT 'Course Module' AS 'Event type', cs.ModuleID AS 'Event ID',
           cs.ModuleName AS 'Event Name', cs.Date, cs.DurationTime
    FROM dbo.ALL_COURSES_TIMETABLE cs
    WHERE cs.CourseID IN
        (SELECT cd.CourseID
         FROM CourseDetails AS cd
         WHERE cd.StudentID = @StudentID)
    UNION
    SELECT 'Webinar' AS 'Event type', ws.WebinarID AS 'Event ID',
           ws.WebinarName AS 'Event Name', ws.WebinarDate, ws.DurationTime
    FROM dbo.ALL_WEBINARS_TIMETABLE ws
    WHERE ws.WebinarID IN
        (SELECT wd.WebinarID
         FROM WebinarDetails AS wd
         WHERE wd.StudentID = @StudentID)
);
```

## Sprawdzamy czy student jest zapisany do jakiegoś spotkania studyjnego z studiów

```sql
CREATE FUNCTION IsStudentInAnyStudyMeeting(@StudentID int, @StudiesID int)
RETURNS bit
AS
BEGIN
  DECLARE @Result BIT = 0;

  IF EXISTS (
    SELECT DISTINCT StudentID
    FROM Subject
    INNER JOIN StudyMeeting
    ON Subject.SubjectID = StudyMeeting.SubjectID
    INNER JOIN StudyMeetingDetails
    ON StudyMeeting.StudyMeetingID = StudyMeetingDetails.StudyMeetingID
    WHERE Subject.StudiesID = @StudiesID
    AND StudyMeetingDetails.StudentID = @StudentID
  )
  BEGIN
    SET @Result = 1;
  END

  RETURN @Result;
END
```
