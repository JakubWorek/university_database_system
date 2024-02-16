# Procedury

## Dodawanie nowego zamówienia

```sql
create procedure AddOrder
@OrderID int,
@StudentID int,
@Paid money
as
begin
set nocount on;
-- Sprawdź, czy istnieje student o podanym StudentID
if not exists (select 1 from Students where StudentID = @StudentID)
begin
raiserror('Student o podanym ID nie istnieje.', 16, 1);
end
-- Wstaw nowe zamówienie do tabeli Orders
insert into Orders (OrderID, StudentID, Paid, OrderDate)
values (@OrderID, @StudentID, @Paid, getdate());
print 'Zamówienie dodane pomyślnie.';
end;
```

## Dodawanie szczegółów zamówienia

```sql
CREATE PROCEDURE [dbo].[AddOrderDetail]
@OrderDetailID int,
@OrderID int,
@PaidDate datetime = null,
@WebinarID int = null,
@CourseID int = null,
@StudiesID int = null,
@StudyMeetingID int = null
as
begin
set nocount on;
    if @PaidDate is null
    begin
        set @PaidDate = getdate();
    end

    -- Sprawdź, czy istnieje zamówienie o podanym OrderID
    if not exists (select 1 from Orders where OrderID = @OrderID)
    begin
        raiserror('Zamówienie o podanym ID nie istnieje.', 16, 1);
    end

    -- Sprawdź, czy student z zamówienia o id OrderID jest już zapisany na webinar
    IF @WebinarID IS NOT NULL AND EXISTS (
        SELECT StudentID
        FROM Orders
        WHERE @OrderId = Orders.OrderID
        AND StudentID IN (
            SELECT DISTINCT StudentID
            FROM WebinarDetails
            WHERE WebinarDetails.WebinarID = @WebinarID
        )
    )
    BEGIN
        RAISERROR('Student o podanym ID jest już zapisany na ten webinar.', 16, 1);
    END
    -- Sprawdź, czy student z zamówienia o id OrderID jest już zapisany na kurs
    ELSE IF @CourseID IS NOT NULL AND EXISTS (
        SELECT StudentID
        FROM Orders
        WHERE @OrderId = Orders.OrderID
        AND StudentID IN (
            SELECT DISTINCT StudentID
            FROM CourseDetails
            WHERE CourseDetails.CourseID = @CourseID
        )
    )
    BEGIN
        RAISERROR('Student o podanym ID jest już zapisany na ten kurs.', 16, 1);
    END
    -- Sprawdź, czy student z zamówienia o id OrderID jest już zapisany na studia
    ELSE IF @StudiesID IS NOT NULL AND EXISTS (
        SELECT StudentID
        FROM Orders
        WHERE @OrderId = Orders.OrderID
        AND StudentID IN (
            SELECT DISTINCT StudentID
            FROM StudiesDetails
            WHERE StudiesDetails.StudiesID = @StudiesID
        )
    )
    BEGIN
        RAISERROR('Student o podanym ID jest już zapisany na te studia.', 16, 1);
    END
    ELSE IF @StudiesID IS NOT NULL AND EXISTS (
        SELECT StudentID
        FROM Orders
        WHERE @OrderId = Orders.OrderID
        AND dbo.IsStudentInAnyStudyMeeting(StudentID, @StudiesID) = 1
    )
    BEGIN
        RAISERROR('Student o podanym ID jest zapisany na jedno ze spotkań tych studiów.', 16, 1);
    END
    ELSE IF @StudyMeetingID IS NOT NULL AND EXISTS (
        SELECT StudentID
        FROM Orders
        WHERE @OrderId = Orders.OrderID
        AND StudentID IN (
            SELECT DISTINCT StudentID
            FROM StudyMeetingDetails
            WHERE StudyMeetingDetails.StudyMeetingID = @StudyMeetingID
        )
    )
    BEGIN
        RAISERROR('Student o podanym ID jest już zapisany na to spotkanie studyjne.', 16, 1);
    END
    ELSE
    BEGIN
        -- Sprawdź, czy istnieje zamówienie o podanym OrderID
        if not exists (select 1 from Orders where OrderID = @OrderID)
        begin
            raiserror('Zamówienie o podanym ID nie istnieje.', 16, 1);
        end
        else
            begin
                -- dodaj do OrderDetails
                insert into OrderDetails (OrderDetailsID, OrderID, PaidDate)
                values (@OrderDetailID, @OrderID, @PaidDate);
            end

        -- Sprawdź, czy istnieje webinar o podanym WebinarID
        if @WebinarID is not null and not exists (select 1 from Webinars where WebinarID = @WebinarID)
        begin
            raiserror('Webinar o podanym ID nie istnieje.', 16, 1);
        end
        -- jeżeli istnieje to dodajemy do OrderWebinars
        else if @WebinarID is not null and exists (select 1 from Webinars where WebinarID = @WebinarID)
            begin
                -- dodaj webinar do OrderWebinars
                insert into OrderWebinars (OrderDetailsID, WebinarID)
                values (@OrderDetailID, @WebinarID);
                print 'Szczegół zamówienia dodany pomyślnie.';
                return;
            end

        -- Sprawdź, czy istnieje kurs o podanym CourseID
        if @CourseID is not null and not exists (select 1 from Courses where CourseID = @CourseID)
        begin
            raiserror('Kurs o podanym ID nie istnieje.', 16, 1);
        end
        -- jeżeli istnieje to dodajemy do OrderCourse
        else if @CourseID is not null and exists (select 1 from Courses where CourseID = @CourseID)
            begin
                -- dodaj kurs do OrderCourses
                insert into OrderCourse (OrderDetailsID, CourseID)
                values (@OrderDetailID, @CourseID);
                print 'Szczegół zamówienia dodany pomyślnie.';
                return;
            end

        -- Sprawdź, czy istnieje studia o podanym StudiesID
        if @StudiesID is not null and not exists (select 1 from Studies where StudiesID = @StudiesID)
        begin
            raiserror('Studia o podanym ID nie istnieją.', 16, 1);
        end
        -- jeżeli istnieje to dodajemy do OrderStudies
        else if @StudiesID is not null and exists (select 1 from Studies where StudiesID = @StudiesID)
            begin
                -- dodaj studia do OrderStudies
                insert into OrderStudies (OrderDetailsID, StudiesID)
                values (@OrderDetailID, @StudiesID);
                print 'Szczegół zamówienia dodany pomyślnie.';
                return;
            end

        -- Sprawdź, czy istnieje spotkanie o podanym StudyMeetingID
        if @StudyMeetingID is not null and not exists (select 1 from StudyMeeting where StudyMeetingID = @StudyMeetingID)
        begin
            raiserror('Spotkanie o podanym ID nie istnieje.', 16, 1);
        end
        -- jeżeli istnieje to dodajemy do OrderStudyMeeting
        else if @StudyMeetingID is not null and exists (select 1 from StudyMeeting where StudyMeetingID = @StudyMeetingID)
            begin
                -- dodaj spotkanie do OrderStudyMeetings
                insert into OrderStudyMeeting (OrderDetailsID, StudyMeetingID)
                values (@OrderDetailID, @StudyMeetingID);
                print 'Szczegół zamówienia dodany pomyślnie.';
                return;
            end
    END
END
```

## Dodawanie nowego kursu

```sql
CREATE PROCEDURE [dbo].[AddCourse]
@CourseID int,
@CourseName varchar(50),
@CourseDescription text null,
@CoursePrice money,
@CourseCoordinatorID int
AS
BEGIN
-- Sprawdź, czy istnieje koordynator o podanym CourseCoordinatorID
IF NOT EXISTS (
SELECT 1
FROM Employees e
JOIN dbo.EmployeeTypes et ON e.EmployeeType = et.EmployeeTypeID
WHERE EmployeeID = @CourseCoordinatorID
AND et.EmployeeTypeName LIKE 'Course Coordinator'
)
BEGIN
RAISERROR('Koordynator o podanym ID nie istnieje.', 16, 1);
END
    -- Wstaw nowy kurs do tabeli Courses
    INSERT INTO Courses (CourseID, CourseName, CourseDescription, CoursePrice, CourseCoordinatorID)
    VALUES (@CourseID, @CourseName, @CourseDescription, @CoursePrice, @CourseCoordinatorID);

    PRINT 'Kurs dodany pomyślnie.';
END;
```

## Dodawanie modułu do istniejącego kursu

```sql
CREATE PROCEDURE [dbo].[AddCourseModule]
@ModuleID int,
@CourseID int,
@TeacherID int,
@ModuleName varchar(50),
@Date datetime,
@DurationTime time,
@TranslatorID int = null,
@LanguageID int = null
AS
BEGIN
SET NOCOUNT ON;
    -- Sprawdź, czy istnieje kurs o podanym CourseID
    IF NOT EXISTS (SELECT 1 FROM Courses WHERE CourseID = @CourseID)
    BEGIN
        RAISEERROR('Kurs o podanym ID nie istnieje.', 16, 1);
    END

    -- Sprawdź, czy istnieje nauczyciel o podanym TeacherID
    IF NOT EXISTS (
        SELECT 1
        FROM Employees e
        WHERE EmployeeID = @TeacherID
    )
    BEGIN
        RAISERROR('Nauczyciel o podanym ID nie istnieje.', 16, 1);
    END

    IF dbo.CheckTranslatorLanguage(@TranslatorID, @LanguageID) = CAST(0 AS bit)
    BEGIN
        RAISERROR('Podano nieprawidłową kombinację tłumacza i języka.', 16, 1);
    END

    -- Wstaw nowy moduł do tabeli Modules
    INSERT INTO CourseModules (ModuleID, CourseID, TeacherID, ModuleName, Date, DurationTime, TranslatorID, LanguageID)
    VALUES (@ModuleID, @CourseID, @TeacherID, @ModuleName, @Date, @DurationTime, @TranslatorID, @LanguageID);

    PRINT 'Moduł dodany pomyślnie.';
END;
```

## Dodawanie studiów

```sql
CREATE PROCEDURE [dbo].[AddStudy]
@StudiesID int,
@StudiesName varchar(50),
@StudiesDescription text null,
@StudiesEntryFreePrice money = NULL,
@StudiesCoordinator int,
@PriceIncrease real = NULL
AS
BEGIN
IF NOT EXISTS (SELECT \* FROM Employees e
JOIN dbo.EmployeeTypes et ON e.EmployeeType = et.EmployeeTypeID
WHERE EmployeeID = @StudiesCoordinator
AND et.EmployeeTypeName LIKE 'Study Coordinator')
BEGIN
RAISERROR('Koordynator o podanym ID nie istnieje.', 16, 1);
END
    IF @StudiesEntryFreePrice IS NULL
        BEGIN
            SET @StudiesEntryFreePrice = 1000
        END

    IF @PriceIncrease IS NULL
        BEGIN
            SET @PriceIncrease = 0.2
        END

    INSERT INTO Studies(StudiesID, StudiesName, StudiesDescription, StudiesEntryFeePrice, StudiesCoordinator, PriceIncrease)
    VALUES (@StudiesID, @StudiesName, @StudiesDescription, @StudiesEntryFreePrice, @StudiesCoordinator, @PriceIncrease)
END
```

## Dodawanie przedmiotów w ramach studiów

```sql
CREATE PROCEDURE [dbo].[AddSubject]
@SubjectID int,
@StudiesID int,
@SubjectCoordinatorID int,
@SubjectName varchar(50),
@SubjectDescription text null
AS
BEGIN
IF NOT EXISTS (SELECT \* FROM Studies s
WHERE s.StudiesID = @StudiesID)
BEGIN
RAISERROR('Nie znaleziono studiów', 16, 1);
END
    IF NOT EXISTS (SELECT * FROM Employees e
        JOIN dbo.EmployeeTypes et ON e.EmployeeType = et.EmployeeTypeID
        WHERE EmployeeID = @SubjectCoordinatorID
        AND et.EmployeeTypeName LIKE 'Subject Coordinator')
    BEGIN
        RAISERROR('Koordynator o podanym ID nie istnieje.', 16, 1);
    END

    INSERT INTO Subject(SubjectID, StudiesID, CoordinatorID, SubjectName, SubjectDescription)
    VALUES (@SubjectID, @StudiesID, @SubjectCoordinatorID, @SubjectName, @SubjectDescription)
END
```

## Dodawanie spotkań do przedmiotów

```sql
CREATE PROCEDURE [dbo].[AddStudyMeeting]
@StudyMeetingID int,
@SubjectID int,
@TeacherID int,
@MeetingName varchar(50),
@MeetingPrice money = NULL,
@Date datetime,
@DurationTime time(0) = NULL,
@TranslatorID int = NULL,
@LanguageID int = NULL
AS
BEGIN
IF @MeetingPrice IS NULL
BEGIN
SET @MeetingPrice = 100
END
    IF @DurationTime IS NULL
        BEGIN
            SET @DurationTime = '01:30:00'
        END

    IF dbo.CheckTranslatorLanguage(@TranslatorID, @LanguageID) = CAST(0 AS bit)
    BEGIN
        RAISERROR('Podano nieprawidłową kombinację tłumacza i języka.', 16, 1);
    END

    INSERT INTO StudyMeeting(StudyMeetingID, SubjectID, TeacherID, MeetingName, MeetingPrice, Date, DurationTime, TranslatorID, LanguageID)
    VALUES (@StudyMeetingID, @SubjectID, @TeacherID, @MeetingName, @MeetingPrice, @Date, @DurationTime, @TranslatorID, @LanguageID)
END;
```

## Dodawanie nowego stażu

```sql
CREATE PROCEDURE AddInternship
@InternshipID int,
@StudiesID int,
@StartDate datetime
AS
BEGIN
INSERT INTO Internship(InternshipID, StudiesID, StartDate)
VALUES (@InternshipID, @StudiesID, @StartDate)
END
```

## Dodawanie studenta

```sql
CREATE PROCEDURE [dbo].[AddStudent]
@StudentID int, @FirstName varchar(30), @LastName varchar(30), @Address varchar(30),
@CityID int, @PostalCode varchar(10), @Phone varchar(15), @Email varchar(50)
AS
BEGIN
IF NOT EXISTS (SELECT \* FROM PossibleCity WHERE CityID = @CityID)
BEGIN
RAISERROR('Podano nieprawidłowe miasto', 16, 1);
END
INSERT INTO Students (StudentID, FirstName, LastName, Address,
CityID, PostalCode, Phone, Email)
VALUES (@StudentID, @FirstName, @LastName, @Address,
@CityID, @PostalCode, @Phone, @Email);
END;
```

## Dodawanie nowego tłumacza

```sql
CREATE PROCEDURE [dbo].[AddTranslator]
@TranslatorID int, @FirstName varchar(30), @LastName varchar(30),
@HireDate date null, @BirthDate date null, @Phone varchar(15),
@Email varchar(50)
AS
BEGIN
INSERT INTO Translators (TranslatorID, FirstName, LastName,
HireDate, BirthDate, Phone, Email)
VALUES (@TranslatorID, @FirstName, @LastName,
@HireDate, @BirthDate, @Phone, @Email);
END;
```

## Dodawanie pracownika

```sql
CREATE PROCEDURE [dbo].[AddEmployee]
@EmployeeID int, @FirstName varchar(30), @LastName varchar(30),
@HireDate date null, BirthDate date null, @Phone varchar(15),
@Email varchar(50), @EmployeeType int
AS
BEGIN
IF NOT EXISTS (SELECT \* FROM EmployeeTypes WHERE EmployeeTypeID = @EmployeeType)
BEGIN
RAISERROR('Nieprawidłowy rodzaj pracownika.', 16, 1);
END
INSERT INTO Employees (EmployeeID, FirstName, LastName, HireDate,
BirthDate, Phone, Email, EmployeeType)
VALUES (@EmployeeID, @FirstName, @LastName, @HireDate,
@BirthDate, @Phone, @Email, @EmployeeType);
END;
```

## Dodawanie nowego webinaru

```sql
CREATE PROCEDURE AddWebinar
@WebinarID int, @TeacherID int, @TranslatorID int null,
@WebinarName varchar(50), @WebinarPrice money,
@VideoLink varchar(50), @WebinarDate datetime,
@DurationTime time(0), @WebinarDescription text null,
@LanguageID int null
AS
BEGIN
IF NOT EXISTS (SELECT \* FROM Employees WHERE EmployeeID = @TeacherID)
BEGIN
RAISERROR('Nie znaleziono nauczyciela.', 16, 1);
END
    IF dbo.CheckTranslatorLanguage(@TranslatorID, @LanguageID) = CAST(0 AS bit)
    BEGIN
        RAISERROR('Podano nieprawidłową kombinację tłumacza i języka.', 16, 1);
    END
    INSERT INTO Webinars (WebinarID, TeacherID, TranslatorID, WebinarName,
        WebinarPrice, VideoLink, WebinarDate,
        DurationTime, WebinarDescription, LanguageID)
    VALUES (@WebinarID, @TeacherID, @TranslatorID, @WebinarName,
        @WebinarPrice, @VideoLink, @WebinarDate,
        @DurationTime, @WebinarDescription, @LanguageID);

END;
```
