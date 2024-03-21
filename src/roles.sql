-- admin
create role admin
grant all privileges on u_michaluk.dbo to admin

-- dyrektor
create role dyrektor
grant select on NUMBER_OF_PEOPLE_REGISTRED_FOR_FUTURE_EVENTS to dyrektor
grant select on NUMBER_OF_PEOPLE_REGISTRED_FOR_FUTURE_COURSE_MODULES to dyrektor
grant select on NUMBER_OF_PEOPLE_REGISTERED_FOR_FUTURE_STUDY_MEETINGS to dyrektor
grant select on NUMBER_OF_PEOPLE_REGISTERED_FOR_FUTURE_WEBINARS to dyrektor
grant select on ATTENDANCE_SUMMARY to dyrektor
grant select on COURSE_MODULES_ATTENDANCE_SUMMARY to dyrektor
grant select on STUDY_MEETINGS_ATTENDANCE_SUMMARY to dyrektor
grant select on WEBINARS_ATTENDANCE_SUMMARY to dyrektor
grant select on LIST_OF_DEBTORS to dyrektor

-- księgowy
create role ksiegowy
grant select on LIST_OF_DEBTORS to ksiegowy
grant select on ALL_FUTURE_EVENTS_LIST to ksiegowy
grant select on NUMBER_OF_PEOPLE_REGISTRED_FOR_FUTURE_EVENTS to ksiegowy
grant select on NUMBER_OF_PEOPLE_REGISTERED_FOR_FUTURE_COURSE_MODULES to ksiegowy
grant select on NUMBER_OF_PEOPLE_REGISTERED_FOR_FUTURE_STUDY_MEETINGS to ksiegowy
grant select on NUMBER_OF_PEOPLE_REGISTERED_FOR_FUTURE_WEBINARS to ksiegowy
grant select on FINANCIAL_REPORT to ksiegowy
grant select on COURSES_FINANCIAL_REPORT to ksiegowy
grant select on STUDIES_FINANCIAL_REPORT to ksiegowy
grant select on WEBINARS_FINANCIAL_REPORT to ksiegowy
grant select, insert, update, delete on Orders to ksiegowy
grant select, insert, update, delete on OrderDetails to ksiegowy
grant select, insert, update, delete on OrderStudies to ksiegowy
grant select, insert, update, delete on OrderStudyMeeting to ksiegowy
grant select, insert, update, delete on OrderCourse to ksiegowy
grant select, insert, update, delete on OrderWebinars to ksiegowy

-- nauczyciel
create role nauczyciel
grant select on PRESENCE_LIST to nauczyciel
grant select on COURSE_MODULES_PRESENCE_LIST to nauczyciel
grant select on STUDY_MEETINGS_PRESENCE_LIST to nauczyciel
grant update (Presence) on StudyMeetingDetails to nauczyciel
grant update (Presence) on CourseModulesDetails to nauczyciel
grant execute on AddWebinar to nauczyciel
grant select, update on Webinars to nauczyciel


-- kierownik kursu
create role kierownik_kursu
grant select on PRESENCE_LIST to kierownik_kursu
grant select on COURSE_MODULES_PRESENCE_LIST to kierownik_kursu
grant select on STUDY_MEETINGS_PRESENCE_LIST to kierownik_kursu
grant update (Presence) on StudyMeetingDetails to kierownik_kursu
grant update (Presence) on CourseModulesDetails to kierownik_kursu
grant execute on AddWebinar to kierownik_kursu
grant select, update on Webinars to kierownik_kursu
grant select on COURSE_MODULES_ATTENDANCE_SUMMARY to kierownik_kursu
grant select on COURSES_FINANCIAL_REPORT to kierownik_kursu
grant execute on AddCourse to kierownik_kursu
grant execute on AddCourseModule to kierownik_kursu
grant execute on GetMaxCourseCapacity to kierownik_kursu
grant execute on HowManyCourseVacancies to kierownik_kursu

-- kierownik przedmiotu
create role kierownik_przedmiotu
grant select on PRESENCE_LIST to kierownik_przedmiotu
grant select on COURSE_MODULES_PRESENCE_LIST to kierownik_przedmiotu
grant select on STUDY_MEETINGS_PRESENCE_LIST to kierownik_przedmiotu
grant update (Presence) on StudyMeetingDetails to kierownik_przedmiotu
grant update (Presence) on CourseModulesDetails to kierownik_przedmiotu
grant execute on AddWebinar to kierownik_przedmiotu
grant select, update on Webinars to kierownik_przedmiotu
grant select on COURSE_MODULES_ATTENDANCE_SUMMARY to kierownik_przedmiotu
grant select on COURSES_FINANCIAL_REPORT to kierownik_przedmiotu
grant execute on AddCourse to kierownik_przedmiotu
grant execute on AddCourseModule to kierownik_przedmiotu
grant execute on GetMaxCourseCapacity to kierownik_przedmiotu
grant execute on HowManyCourseVacancies to kierownik_przedmiotu
grant select on STUDY_MEETINGS_ATTENDANCE_SUMMARY to kierownik_przedmiotu
grant execute on AddSubject to kierownik_przedmiotu
grant execute on AddStudyMeeting to kierownik_przedmiotu
grant execute on GetSubjectAttendanceForStudent to kierownik_przedmiotu
grant select, insert, update, delete on Subject to kierownik_przedmiotu
grant select, insert, update, delete on SubjectDetails to kierownik_przedmiotu
grant select, insert, update, delete on StudyMeeting to kierownik_przedmiotu
grant select, insert, update, delete on StudyMeetingDetails to kierownik_przedmiotu
grant insert on StationaryMeeting to kierownik_przedmiotu
grant insert on OnlineAsyncMeeting to kierownik_przedmiotu
grant insert on OnlineSyncMeeting to kierownik_przedmiotu

-- kierownik studiów
create role kierownik_studiow
grant select on PRESENCE_LIST to kierownik_studiow
grant select on COURSE_MODULES_PRESENCE_LIST to kierownik_studiow
grant select on STUDY_MEETINGS_PRESENCE_LIST to kierownik_studiow
grant update (Presence) on StudyMeetingDetails to kierownik_studiow
grant update (Presence) on CourseModulesDetails to kierownik_studiow
grant execute on AddWebinar to kierownik_studiow
grant select, update on Webinars to kierownik_studiow
grant select on COURSE_MODULES_ATTENDANCE_SUMMARY to kierownik_studiow
grant select on COURSES_FINANCIAL_REPORT to kierownik_studiow
grant execute on AddCourse to kierownik_studiow
grant execute on AddCourseModule to kierownik_studiow
grant execute on GetMaxCourseCapacity to kierownik_studiow
grant execute on HowManyCourseVacancies to kierownik_studiow
grant select on STUDY_MEETINGS_ATTENDANCE_SUMMARY to kierownik_studiow
grant execute on AddSubject to kierownik_studiow
grant execute on AddStudyMeeting to kierownik_studiow
grant execute on GetSubjectAttendanceForStudent to kierownik_studiow
grant select, insert, update, delete on Subject to kierownik_studiow
grant select, insert, update, delete on SubjectDetails to kierownik_studiow
grant select, insert, update, delete on StudyMeeting to kierownik_studiow
grant select, insert, update, delete on StudyMeetingDetails to kierownik_studiow
grant insert on StationaryMeeting to kierownik_studiow
grant insert on OnlineAsyncMeeting to kierownik_studiow
grant insert on OnlineSyncMeeting to kierownik_studiow
grant execute on AddStudy to kierownik_studiow
grant select, insert, update, delete on Studies to kierownik_studiow
grant select, insert, update, delete on StudiesDetails to kierownik_studiow
grant select, insert, update, delete on Internship to kierownik_studiow
grant select, insert, update, delete on InternshipDetails to kierownik_studiow

-- osoba odpowiedzialna za praktyki
create role opiekun_praktyk
grant execute on AddInternship to opiekun_praktyk
grant execute on CheckStudentInternships to opiekun_praktyk
grant select, insert, update on Internship to opiekun_praktyk
grant select, insert, update on InternshipDetails to opiekun_praktyk

-- tłumacz
create role tlumacz
grant select on ALL_FUTURE_EVENTS_LIST to tlumacz
grant select on Webinars to tlumacz
grant select on CourseModules to tlumacz
grant select on StudyMeeting to tlumacz

-- kadrowy
create role kadrowy
grant execute on AddEmployee to kadrowy
grant execute on AddStudent to kadrowy
grant execute on AddTranslator to kadrowy

-- system
create role system
grant execute on AddOrder to system
grant execute on AddOrderDetail to system

-- student
create role student
grant select on ALL_FUTURE_EVENTS_LIST to student
grant select on NUMBER_OF_PEOPLE_REGISTRED_FOR_FUTURE_EVENTS to student
grant execute on CheckStudentInternships to student
grant execute on GetSubjectAttendanceForStudent to student
grant execute on GetCourseAttendanceForStudent to student
grant execute on HowManyCourseVacancies to student
grant execute on HowManyStudyVacancies to student