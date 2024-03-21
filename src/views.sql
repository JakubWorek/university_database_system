CREATE VIEW FINANCIAL_REPORT AS
SELECT w.WebinarID AS ID, w.WebinarName AS Name, 'Webinar' AS Type, w.WebinarPrice *
    (SELECT count(*)
    FROM OrderWebinars ow JOIN
    OrderDetails od ON ow.OrderDetailsID = od.OrderDetailsID JOIN
    Orders o ON od.OrderID = o.OrderID
    WHERE ow.WebinarID = w.WebinarID) AS TotalIncome
FROM Webinars w
UNION
SELECT c.CourseID AS ID, c.CourseName AS Name, 'Course' AS Type, c.CoursePrice *
    (SELECT count(*)
    FROM OrderCourse oc JOIN
    OrderDetails od ON oc.OrderDetailsID = od.OrderDetailsID JOIN
    Orders o ON od.OrderID = o.OrderID
    WHERE oc.CourseID = c.CourseID) AS TotalIncome
FROM Courses c
UNION
SELECT s.StudiesID AS ID, s.StudiesName AS Name, 'Study' AS Type, s.StudiesEntryFeePrice *
    (SELECT count(*)
    FROM OrderStudies os JOIN
    OrderDetails od ON os.OrderDetailsID = od.OrderDetailsID JOIN
    Orders o ON od.OrderID = o.OrderID
    WHERE os.StudiesID = s.StudiesID) +
    (SELECT sum(sm.MeetingPrice)
    FROM StudyMeeting sm JOIN
    Subject sb ON sm.SubjectID = sb.SubjectID
    WHERE sb.StudiesID = s.StudiesID) AS TotalIncome
FROM Studies s

CREATE VIEW WEBINARS_FINANCIAL_REPORT AS
SELECT ID AS 'Webinar ID', Name, TotalIncome
FROM FINANCIAL_REPORT
WHERE Type = 'Webinar'

CREATE VIEW COURSES_FINANCIAL_REPORT AS
SELECT ID AS 'Course ID', Name, TotalIncome
FROM FINANCIAL_REPORT
WHERE Type = 'Course'

CREATE VIEW STUDIES_FINANCIAL_REPORT AS
SELECT ID AS 'Study ID', Name, TotalIncome
FROM FINANCIAL_REPORT
WHERE Type = 'Study'

CREATE VIEW LIST_OF_DEBTORS AS
SELECT DISTINCT
s.StudentID,
s.FirstName,
s.LastName,
s.Email,
s.Phone
FROM Students s
WHERE StudentID NOT IN
(SELECT DISTINCT s.StudentID
FROM Students s JOIN Orders o ON s.StudentID = o.StudentID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN OrderWebinars ow ON od.OrderDetailsID = ow.OrderDetailsID
JOIN Webinars w ON ow.WebinarID = w.WebinarID
WHERE o.OrderDate < w.WebinarDate
UNION
SELECT DISTINCT s.StudentID
FROM Students s
JOIN Orders o ON s.StudentID = o.StudentID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN OrderCourse oc ON od.OrderDetailsID = oc.OrderDetailsID
JOIN Courses c ON oc.CourseID = c.CourseID
WHERE o.OrderDate < dateadd(day, - 3,
    (SELECT min(cm.Date)
    FROM CourseModules cm
    WHERE cm.CourseID = c.CourseID))
UNION
SELECT DISTINCT s.StudentID
FROM Students s
JOIN Orders o ON s.StudentID = o.StudentID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN OrderStudies os ON od.OrderDetailsID = os.OrderDetailsID
JOIN Studies st ON os.StudiesID = st.StudiesID
WHERE o.OrderDate < dateadd(day, - 3,
    (SELECT min(sm.Date)
    FROM StudyMeeting sm
          JOIN Subject sb ON sm.SubjectID = sb.SubjectID



    WHERE sb.StudiesID = st.StudiesID))
UNION
SELECT DISTINCT s.StudentID
FROM Students s
JOIN Orders o ON s.StudentID = o.StudentID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN OrderStudyMeeting osm ON od.OrderDetailsID = osm.OrderDetailsID
JOIN StudyMeeting sm ON osm.StudyMeetingID = sm.StudyMeetingID
WHERE o.OrderDate < dateadd(day, - 3,
    (SELECT sm.Date
    FROM StudyMeeting sm
    WHERE sm.StudyMeetingID = osm.StudyMeetingID)))
AND s.StudentID IN
    (SELECT DISTINCT s.StudentID
    FROM Students s
    JOIN WebinarDetails wd ON s.StudentID = wd.StudentID
    UNION
    SELECT DISTINCT s.StudentID
    FROM Students s
    JOIN CourseModulesDetails cmd ON s.StudentID = cmd.StudentID
    UNION
    SELECT DISTINCT s.StudentID
    FROM Students s
    JOIN StudyMeetingDetails smd ON s.StudentID = smd.StudentID
    UNION
    SELECT DISTINCT s.StudentID
    FROM Students s
    JOIN StudiesDetails std ON s.StudentID = std.StudentID)

CREATE VIEW NUMBER_OF_PEOPLE_REGISTRED_FOR_FUTURE_EVENTS AS
SELECT w.WebinarID AS ID, w.WebinarName AS Name,
count(*) AS NumberOfParticipants, 'Webinar' AS Type, 'Online' AS Location
FROM Webinars w JOIN
WebinarDetails wd ON w.WebinarID = wd.WebinarID
WHERE WebinarDate > getdate()
GROUP BY w.WebinarID, w.WebinarName
UNION
SELECT cm.ModuleID AS ID, cm.ModuleName AS Name,
count(*) AS NumberOfParticipants, 'Course Module' AS Type, CASE WHEN cm.ModuleID IN
(SELECT smod.ModuleID
FROM StationaryModule smod) THEN 'Stationary' ELSE 'Online' END AS Location
FROM CourseModules cm JOIN
CourseModulesDetails cmd ON cm.ModuleID = cmd.ModuleID
WHERE cm.Date > getdate()
GROUP BY cm.ModuleID, cm.ModuleName
UNION
SELECT sm.StudyMeetingID AS ID, sm.MeetingName AS Name,
count(*) AS NumberOfParticipants, 'Study Meeting' AS Type, CASE WHEN sm.StudyMeetingID IN
(SELECT smeet.MeetingID
FROM StationaryMeeting smeet) THEN 'Stationary' ELSE 'Online' END AS Location
FROM StudyMeeting sm JOIN
StudyMeetingDetails smd ON sm.StudyMeetingID = smd.StudyMeetingID
WHERE  sm.Date > getdate()
GROUP BY sm.StudyMeetingID, sm.MeetingName

CREATE VIEW NUMBER_OF_PEOPLE_REGISTERED_FOR_FUTURE_STUDY_MEETINGS AS
SELECT ID AS 'Study Meeting ID', NumberOfParticipants, Location
FROM NUMBER_OF_PEOPLE_REGISTRED_FOR_FUTURE_EVENTS
WHERE Type = 'Study Meeting'

CREATE VIEW NUMBER_OF_PEOPLE_REGISTERED_FOR_FUTURE_COURSE_MODULES AS
SELECT ID AS 'Course Module ID', NumberOfParticipants, Location
FROM NUMBER_OF_PEOPLE_REGISTRED_FOR_FUTURE_EVENTS
WHERE Type = 'Course Module'

CREATE VIEW NUMBER_OF_PEOPLE_REGISTERED_FOR_FUTURE_WEBINARS AS
SELECT ID AS 'Webinar ID', NumberOfParticipants, Location
FROM NUMBER_OF_PEOPLE_REGISTRED_FOR_FUTURE_EVENTS
WHERE Type = 'Webinar'

CREATE VIEW ATTENDANCE_SUMMARY AS
SELECT smd.StudyMeetingID AS 'Event ID',
100 * SUM(CAST(smd.Presence AS Int)) / COUNT(smd.Presence) AS [% Frequence],
'Study meeting' AS 'Event type'
FROM dbo.StudyMeetingDetails AS smd INNER JOIN
dbo.StudyMeeting AS sm ON smd.StudyMeetingID = sm.StudyMeetingID
WHERE (sm.Date < GETDATE())
GROUP BY smd.StudyMeetingID
UNION
SELECT cmd.ModuleID AS 'Event ID',
100 * SUM(CAST(cmd.Presence AS Int)) / COUNT(cmd.Presence) AS [% Frequence],
'Course module' AS 'Event type'
FROM dbo.CourseModulesDetails AS cmd INNER JOIN
dbo.CourseModules AS cm ON cmd.ModuleID = cm.ModuleID
WHERE (cm.Date < GETDATE())
GROUP BY cmd.ModuleID
UNION
SELECT wd.WebinarID AS 'Event ID',
100 * COUNT(*) / (SELECT COUNT(*) AS Expr1
FROM dbo.Students) AS [% Frequence],
'Webinar' AS 'Event type'
FROM dbo.WebinarDetails AS wd INNER JOIN
dbo.Webinars AS w ON wd.WebinarID = w.WebinarID
WHERE (w.WebinarDate < GETDATE())
GROUP BY wd.WebinarID

CREATE VIEW STUDY_MEETINGS_ATTENDANCE_SUMMARY AS
SELECT [Event ID] AS 'Study Meeting ID', [% Frequence]
FROM ATTENDANCE_SUMMARY
WHERE [Event type] = 'Study Meeting'

CREATE VIEW COURSE_MODULES_ATTENDANCE_SUMMARY AS
SELECT [Event ID] AS 'Course Module ID', [% Frequence]
FROM ATTENDANCE_SUMMARY
WHERE [Event type] = 'Course Module'

CREATE VIEW WEBINARS_ATTENDANCE_SUMMARY AS
SELECT [Event ID] AS 'Webinar ID', [% Frequence]
FROM ATTENDANCE_SUMMARY
WHERE [Event type] = 'Webinar'

CREATE VIEW PRESENCE_LIST AS
SELECT smd.StudyMeetingID AS 'Event ID', sm.Date, s.FirstName AS [First Name],
s.LastName, CASE WHEN Presence = 1 THEN 'Present' ELSE 'Absent' END AS [Presence information],
'Study Meeting' AS 'Event type'
FROM dbo.StudyMeetingDetails AS smd INNER JOIN
dbo.Students AS s ON smd.StudentID = s.StudentID INNER JOIN
dbo.StudyMeeting AS sm ON smd.StudyMeetingID = sm.StudyMeetingID
WHERE (sm.Date < GETDATE())
UNION ALL
SELECT cmd.ModuleID AS 'Event ID', cm.Date, s.FirstName AS [First Name],
s.LastName, CASE WHEN Presence = 1 THEN 'Present' ELSE 'Absent' END AS [Presence information],
'Course module' AS 'Event type'
FROM dbo.CourseModulesDetails AS cmd INNER JOIN
dbo.Students AS s ON cmd.StudentID = s.StudentID INNER JOIN
dbo.CourseModules AS cm ON cmd.ModuleID = cm.ModuleID
WHERE (cm.Date < GETDATE())
UNION ALL
SELECT wd.WebinarID AS 'Event ID', w.WebinarDate, s.FirstName AS [First Name],
s.LastName, CASE WHEN wd.StudentID IN (SELECT StudentID
FROM Students) THEN 'Present' ELSE 'Absent' END AS [Presence information],
'Webinar' AS 'Event type'
FROM dbo.WebinarDetails AS wd INNER JOIN
dbo.Students AS s ON wd.StudentID = s.StudentID INNER JOIN
dbo.Webinars AS w ON wd.WebinarID = w.WebinarID
WHERE (w.WebinarDate < GETDATE())

CREATE VIEW STUDY_MEETINGS_PRESENCE_LIST AS
SELECT [Event ID] AS 'Study Meeting ID', Date, [First Name], LastName, [Presence information]
FROM PRESENCE_LIST
WHERE [Event type] = 'Study Meeting'
GROUP BY [Event ID], Date, [First Name], LastName, [Presence information]

CREATE VIEW COURSE_MODULES_PRESENCE_LIST AS
SELECT [Event ID] AS 'Course Module ID', Date, [First Name], LastName, [Presence information]
FROM PRESENCE_LIST
WHERE [Event type] = 'Course Module'
GROUP BY [Event ID], Date, [First Name], LastName, [Presence information]

CREATE VIEW WEBINARS_PRESENCE_LIST AS
SELECT [Event ID] AS 'Webinar ID', Date, [First Name], LastName, [Presence information]
FROM PRESENCE_LIST
WHERE [Event type] = 'Webinar'
GROUP BY [Event ID], Date, [First Name], LastName, [Presence information]

CREATE VIEW ALL_STUDIES_TIMETABLE AS
SELECT s.StudiesID, sm.StudyMeetingID, sm.MeetingName, sm.Date, sm.DurationTime
FROM dbo.Studies AS s
INNER JOIN dbo.Subject AS su
ON s.StudiesID = su.StudiesID
INNER JOIN dbo.StudyMeeting AS sm
ON su.SubjectID = sm.SubjectID

CREATE VIEW ALL_COURSES_TIMETABLE AS
SELECT c.CourseID, cm.ModuleID, cm.ModuleName, cm.Date, cm.DurationTime
FROM Courses AS c
INNER JOIN CourseModules AS cm
ON c.CourseID = cm.CourseID

CREATE VIEW ALL_WEBINARS_TIMETABLE AS
SELECT w.WebinarID, w.WebinarName, w.WebinarDate, w.DurationTime
FROM Webinars AS w

CREATE VIEW ALL_FUTURE_EVENTS_LIST AS
SELECT WebinarID AS 'Event ID', WebinarDate AS 'Date', DurationTime, 'Webinar' AS 'Event type'
FROM Webinars
WHERE WebinarDate > GETDATE()
UNION
SELECT ModuleID AS 'Event ID', Date, DurationTime, 'Course Module' AS 'Event type'
FROM CourseModules
WHERE Date > GETDATE()
UNION
SELECT StudyMeetingID AS 'Event ID', Date, DurationTime, 'Study Meeting' AS 'Event type'
FROM StudyMeeting
WHERE Date > GETDATE()

CREATE VIEW FUTURE_STUDY_MEETINGS_LIST AS
SELECT [Event ID] AS 'Study Meeting ID', Date, DurationTime
FROM ALL_FUTURE_EVENTS_LIST
WHERE [Event type] = 'Study Meeting'

CREATE VIEW FUTURE_COURSE_MODULES_LIST AS
SELECT [Event ID] AS 'Course Module ID', Date, DurationTime
FROM ALL_FUTURE_EVENTS_LIST
WHERE [Event type] = 'Course Module'

CREATE VIEW FUTURE_WEBINARS_LIST AS
SELECT [Event ID] AS 'Webinar ID', Date, DurationTime
FROM ALL_FUTURE_EVENTS_LIST
WHERE [Event type] = 'Webinar'

CREATE VIEW STUDENTS_REGISTERED_FOR_COLLIDING_FUTURE_EVENTS_LIST AS
SELECT DISTINCT s.StudentID, s.FirstName, s.LastName
FROM Students AS s
    JOIN WebinarDetails AS wd
    ON s.StudentID = wd.StudentID
    JOIN FUTURE_WEBINARS_LIST AS w
    ON wd.WebinarID = w.[Webinar ID]
    JOIN FUTURE_WEBINARS_LIST AS w2
    ON wd.WebinarID = w2.[Webinar ID]
    JOIN CourseModulesDetails AS cmd
    ON s.StudentID = cmd.StudentID
    JOIN FUTURE_COURSE_MODULES_LIST AS cm
    ON cmd.ModuleID = cm.[Course Module ID]
    JOIN FUTURE_COURSE_MODULES_LIST AS cm2
    ON cmd.ModuleID = cm2.[Course Module ID]
    JOIN StudyMeetingDetails AS smd
    ON s.StudentID = smd.StudentID
    JOIN FUTURE_STUDY_MEETINGS_LIST AS sm
    ON smd.StudyMeetingID = sm.[Study Meeting ID]
    JOIN FUTURE_STUDY_MEETINGS_LIST AS sm2
    ON smd.StudyMeetingID = sm2.[Study Meeting ID]
WHERE EXISTS
(SELECT w.Date
    WHERE EXISTS (SELECT w2.Date
    WHERE w.[Webinar ID] <> w2.[Webinar ID] AND
    ((CASE WHEN w2.Date > w.Date THEN w2.Date ELSE w.Date END) <
    (CASE WHEN w2.Date + CAST(w2.DurationTime AS datetime) <
    w.Date + CAST(w.DurationTime AS datetime)
    THEN w2.Date + CAST(w2.DurationTime AS datetime) ELSE w.Date + CAST(w.DurationTime AS datetime) END)))
UNION
    SELECT w.Date WHERE EXISTS
    (SELECT cm.Date WHERE ((CASE WHEN cm.Date > w.Date THEN cm.Date ELSE w.Date END) <
    (CASE WHEN cm.Date + CAST(cm.DurationTime AS datetime) <
    w.Date + CAST(w.DurationTime AS datetime)
    THEN cm.Date + CAST(cm.DurationTime AS datetime) ELSE w.Date + CAST(w.DurationTime AS datetime) END)))
UNION
    SELECT w.Date WHERE  EXISTS
    (SELECT sm.Date WHERE ((CASE WHEN sm.Date > w.Date THEN sm.Date ELSE w.Date END) <
    (CASE WHEN sm.Date + CAST(sm.DurationTime AS datetime) <
    w.Date + CAST(w.DurationTime AS datetime)
    THEN sm.Date + CAST(sm.DurationTime AS datetime) ELSE w.Date + CAST(w.DurationTime AS datetime) END)))
UNION
    SELECT cm.Date WHERE EXISTS
    (SELECT cm2.Date
    WHERE cm.[Course Module ID] <> cm2.[Course Module ID] AND
    ((CASE WHEN cm2.Date > cm.Date THEN cm2.Date ELSE cm.Date END) <
    (CASE WHEN cm2.Date + CAST(cm2.DurationTime AS datetime) <
    cm.Date + CAST(cm.DurationTime AS datetime)
    THEN cm2.Date + CAST(cm2.DurationTime AS datetime) ELSE cm.Date + CAST(cm.DurationTime AS datetime) END)))
UNION
    SELECT cm.Date WHERE EXISTS
    (SELECT sm.Date WHERE ((CASE WHEN sm.Date > cm.Date THEN sm.Date ELSE cm.Date END) <
    (CASE WHEN sm.Date + CAST(sm.DurationTime AS datetime) <
    cm.Date + CAST(cm.DurationTime AS datetime)
    THEN sm.Date + CAST(sm.DurationTime AS datetime) ELSE cm.Date + CAST(cm.DurationTime AS datetime) END)))
UNION
    SELECT sm.Date WHERE EXISTS
    (SELECT sm2.Date
    WHERE sm.[Study Meeting ID] <> sm2.[Study Meeting ID] AND
    ((CASE WHEN sm2.Date > sm.Date THEN sm2.Date ELSE sm.Date END) <
    (CASE WHEN sm2.Date + CAST(sm2.DurationTime AS datetime) <
    sm.Date + CAST(sm.DurationTime AS datetime)
    THEN sm2.Date + CAST(sm2.DurationTime AS datetime) ELSE sm.Date + CAST(sm.DurationTime AS datetime) END))))

