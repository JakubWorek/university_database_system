CREATE TRIGGER [dbo].[trg_AddStudentToWebinar]
ON [dbo].[OrderWebinars]
AFTER INSERT
AS
BEGIN
  IF EXISTS (
    SELECT StudentID
    FROM inserted
    INNER JOIN OrderDetails
    ON inserted.OrderDetailsID = OrderDetails.OrderDetailsID
    INNER JOIN Orders
    ON OrderDetails.OrderID = Orders.OrderID
    WHERE StudentID IN (
      SELECT DISTINCT StudentID
      FROM inserted
      INNER JOIN WebinarDetails
      ON inserted.WebinarID = WebinarDetails.WebinarID
    )
  )
  BEGIN
    RAISERROR('Student o podanym ID jest już zapisany na ten webinar.', 16, 1);
  END
  ELSE
    BEGIN
        INSERT INTO WebinarDetails (StudentID, WebinarID, AvailableDue)
        SELECT Orders.StudentID, inserted.WebinarID, DATEADD(DAY, 30, GETDATE())
        FROM inserted
      INNER JOIN OrderDetails
      ON inserted.OrderDetailsID = OrderDetails.OrderDetailsID
      INNER JOIN Orders
      ON OrderDetails.OrderID = Orders.OrderID;
    END
END;

CREATE TRIGGER [dbo].[trg_AddStudentToCourse]
ON [dbo].[OrderCourse]
AFTER INSERT
AS
BEGIN
  IF EXISTS (
    SELECT StudentID
    FROM inserted
    INNER JOIN OrderDetails
    ON inserted.OrderDetailsID = OrderDetails.OrderDetailsID
    INNER JOIN Orders
    ON OrderDetails.OrderID = Orders.OrderID
    WHERE StudentID IN (
      SELECT DISTINCT StudentID
      FROM inserted
      INNER JOIN CourseDetails
      ON inserted.CourseID = CourseDetails.CourseID
    )
  )
  BEGIN
    RAISERROR('Student o podanym ID jest już zapisany na ten kurs.', 16, 1);
  END
  ELSE
  BEGIN
    DECLARE @StudentID int;
    SELECT @StudentID = Orders.StudentID
    FROM inserted
    INNER JOIN OrderDetails
    ON inserted.OrderDetailsID = OrderDetails.OrderDetailsID
    INNER JOIN Orders
    ON OrderDetails.OrderID = Orders.OrderID;

    INSERT INTO CourseDetails (CourseID, StudentID)
    SELECT inserted.CourseID, @StudentID
    FROM inserted;

    INSERT INTO CourseModulesDetails (ModuleID, StudentID, Presence)
    SELECT CourseModules.ModuleID, @StudentID, 0
    FROM inserted
    INNER JOIN CourseModules
    ON inserted.CourseID = CourseModules.CourseID;
  END
END;

CREATE TRIGGER [dbo].[trg_AddStudentToStudyMeeting]
ON [dbo].[OrderStudyMeeting]
AFTER INSERT
AS
BEGIN
  IF EXISTS (
    SELECT StudentID
    FROM inserted
    INNER JOIN OrderDetails
    ON inserted.OrderDetailsID = OrderDetails.OrderDetailsID
    INNER JOIN Orders
    ON OrderDetails.OrderID = Orders.OrderID
    WHERE StudentID IN (
      SELECT DISTINCT StudentID
      FROM inserted
      INNER JOIN StudyMeetingDetails
      ON inserted.StudyMeetingID = StudyMeetingDetails.StudyMeetingID
    )
  )
  BEGIN
    RAISERROR('Student o podanym ID jest już zapisany na to spotkanie studyjne.', 16, 1);
  END
  ELSE
  BEGIN
    INSERT INTO StudyMeetingDetails (StudyMeetingID, StudentID, Presence)
    SELECT inserted.StudyMeetingID, Orders.StudentID, 0
    FROM inserted
    INNER JOIN OrderDetails
    ON inserted.OrderDetailsID = OrderDetails.OrderDetailsID
    INNER JOIN Orders
    ON OrderDetails.OrderID = Orders.OrderID;
  END
END;

CREATE TRIGGER [dbo].[trg_AddStudentToStudy]
ON [dbo].[OrderStudies]
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT StudentID
        FROM inserted
        INNER JOIN OrderDetails
        ON inserted.OrderDetailsID = OrderDetails.OrderDetailsID
        INNER JOIN Orders
        ON OrderDetails.OrderID = Orders.OrderID
        WHERE StudentID IN (
            SELECT DISTINCT StudentID
            FROM inserted
            INNER JOIN StudiesDetails
            ON inserted.StudiesID = StudiesDetails.StudiesID
        )
    )
    BEGIN
        RAISERROR('Student o podanym ID jest już zapisany na te studia.', 16, 1);
    END
    ELSE IF EXISTS (
        SELECT StudentID
        FROM inserted
        INNER JOIN OrderDetails
        ON inserted.OrderDetailsID = OrderDetails.OrderDetailsID
        INNER JOIN Orders
        ON OrderDetails.OrderID = Orders.OrderID
        WHERE dbo.IsStudentInAnyStudyMeeting(StudentID, inserted.StudiesID) = 1
    )
    BEGIN
        RAISERROR('Student o podanym ID jest zapisany na jedno ze spotkań tych studiów.', 16, 1);
    END
    ELSE
    BEGIN
        DECLARE @StudentID int;
        SELECT @StudentID = Orders.StudentID
        FROM inserted
        INNER JOIN OrderDetails
        ON inserted.OrderDetailsID = OrderDetails.OrderDetailsID
        INNER JOIN Orders
        ON OrderDetails.OrderID = Orders.OrderID;

        INSERT INTO StudiesDetails (StudiesID, StudentID, StudiesGrade)
        SELECT inserted.StudiesID, @StudentID, 2
        FROM inserted;

        INSERT INTO StudyMeetingDetails (StudyMeetingID, StudentID, Presence)
        SELECT StudyMeeting.StudyMeetingID, @StudentID, 0
        FROM inserted
        INNER JOIN Subject
        ON inserted.StudiesID = Subject.StudiesID
        INNER JOIN StudyMeeting
        ON Subject.SubjectID = StudyMeeting.SubjectID;
    END
END;