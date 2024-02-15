# Kategoria Courses

## Tabela Courses

Zawiera informacje o kursach:

- **CourseID** int – klucz główny, identyfikator kursu
- CourseName varchar(50) - nazwa kursu
- CourseDescription text nullable - opis kursu
- CoursePrice money nullable - cena kursu
  - warunek: CoursePrice > 0
  - wartość domyślna: 100
- CourseCoordinatorID int - identyfikator koordynatora kursu

```sql
-- Table: Courses
CREATE TABLE Courses (
CourseID int NOT NULL,
CourseName varchar(50) NOT NULL,
CourseDescription text NULL,
CoursePrice money NULL DEFAULT 1000 CHECK (CoursePrice > 0),
CourseCoordinatorID int NOT NULL,
CONSTRAINT Courses_pk PRIMARY KEY (CourseID)
);
```

## Tabela CourseDetails

Zawiera listę studentów zapisanych na dany kurs:

- **CourseID** int - część klucza głównego, identyfikator kursu
- **StudentID** int - część klucza głównego, identyfikator studenta

```sql
-- Table: CourseDetails
CREATE TABLE CourseDetails (
CourseID int NOT NULL,
StudentID int NOT NULL,
CONSTRAINT CourseDetails_pk PRIMARY KEY (CourseID,StudentID)
);
```

## Tabela CourseModules

Zawiera informacje o zajęciach w ramach kursu:

- **ModuleID** int - klucz główny, identyfikator zajęć
- Course ID int - identyfikator kursu, w ramach którego jest moduł
- TeacherID int - identyfikator nauczyciela
- ModuleName varchar(50) - nazwa zajęć
- Date datetime - data rozpoczęcia zajęć
- DurationTime time(0) - czas trwania zajęć
  - warunek: DurationTime > '00:00:00'
  - wartość domyślna: 01:30:00
- TranslatorID int nullable - identyfikator tłumacza (dla modułów prowadzonych w obcym języku)
- LanguageID int nullable - identyfikator języka (dla modułów prowadzonych w obcym języku)

```sql
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
```

## Tabela CourseModulesDetails

Zawiera szczegółowe informacje o obecności studenta na zajęciach:

- **ModuleID** int - część klucza głównego, identyfikator zajęć
- **StudentID** int - część klucza głównego, identyfikator studenta
- Presence bit nullable - informacja o obecności studenta na zajęciach
  - wartość domyślna: 1

```sql
-- Table: CourseModulesDetails
CREATE TABLE CourseModulesDetails (
ModuleID int NOT NULL,
StudentID int NOT NULL,
Presence bit NULL DEFAULT 1,
CONSTRAINT CourseModulesDetails_pk PRIMARY KEY (ModuleID,StudentID)
);
```

## Tabela StationaryModule

Zawiera szczegółowe informacje o stacjonarnych zajęciach:

- **ModuleID** int - klucz główny, identyfikator zajęć
- Room varchar(10) - informacje o pokoju, w którym odbywają się zajęcia
- Limit int nullable - informacja o limicie miejsc na zajęciach
  - warunek: Limit > 0
  - wartość domyślna: 30

```sql
-- Table: StationaryModule
CREATE TABLE StationaryModule (
ModuleID int NOT NULL,
Room varchar(10) NOT NULL,
Limit int NULL DEFAULT 30 CHECK (Limit > 0),
CONSTRAINT StationaryModule_pk PRIMARY KEY (ModuleID)
);
```

## Tabela OnlineAsyncModule:

Zawiera szczegółowe informacje o zdalnych asynchronicznie
prowadzonych zajęciach:

- **ModuleID** int - klucz główny, identyfikator zajęć
- VideoLink varchar(50) - link do udostępnionego wideo, które student musi obejrzeć, aby uzyskać obecność

```sql
-- Table: OnlineAsyncModule
CREATE TABLE OnlineAsyncModule (
ModuleID int NOT NULL,
VideoLink varchar(50) NOT NULL,
CONSTRAINT OnlineAsyncModule_pk PRIMARY KEY (ModuleID)
);
```

## Tabela OnlineSyncModule:

Zawiera szczegółowe informacje o zdalnych synchronicznie
prowadzonych zajęciach:

- **ModuleID** int - klucz główny, identyfikator zajęć
- Link varchar(50) - link do spotkania

```sql
-- Table: OnlineSyncModule
CREATE TABLE OnlineSyncModule (
ModuleID int NOT NULL,
Link varchar(50) NOT NULL,
CONSTRAINT OnlineSyncModule_pk PRIMARY KEY (ModuleID)
);
```
