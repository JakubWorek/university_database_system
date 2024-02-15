# Kategoria Studies

## Tabela Studies

Zawiera podstawowe informacje o studiach:

- **StudiesID** int – klucz główny, identyfikator studiów
- StudiesName varchar(50) – nazwa studiów
- StudiesDescription text nullable – opis studiów
- StudiesEntryFeePrice money – cena wpisowego na studia
  - warunek: StudiesEntryFeePrice > 0
  - wartość domyślna: 1000
- StudiesCoordinator int – identyfikator koordynatora studiów
- PriceIncrease real nullable – wyrażona w rzeczywistych wartościach stopa wzrostu ceny za spotkanie studyjne dla osoby spoza studiów
  - warunek: PriceIncrease > 0
  - wartość domyślna: 0.2

```sql
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
```

## Tabela StudiesDetails

Zawiera szczegółowe informacje dotyczące uczestnictwa w studiach:

- **StudentID** int – część klucza głównego, identyfikator studenta, który uczestniczy w danych studiach
- **StudiesID** int – część klucza głównego, identyfikator studiów
- StudiesGrade int – identyfikator oceny za studia (zaliczenie studiów)

```sql
-- Table: StudiesDetails
CREATE TABLE StudiesDetails (
StudiesID int NOT NULL,
StudentID int NOT NULL,
StudiesGrade int NOT NULL,
CONSTRAINT StudiesDetails_pk PRIMARY KEY (StudiesID,StudentID)
);
```

## Tabela Internship

Zawiera podstawowe informacje o praktykach:

- **InternshipID** int – klucz główny, identyfikator praktyk
- StudiesID int – identyfikator studiów do których dane praktyki przynależą
- StartDate datetime – data rozpoczęcia praktyk

```sql
-- Table: Internship
CREATE TABLE Internship (
    InternshipID int  NOT NULL,
    StudiesID int  NOT NULL,
    StartDate datetime  NOT NULL,
    CONSTRAINT Internship_pk PRIMARY KEY  (InternshipID)
);
```

## Tabela InternshipDetails

Zawiera szczegółowe informacje dotyczące uczestnictwa w praktykach:

- **InternshipID** int – część klucza głównego, identyfikator praktyk
- **StudentID** int – część klucza głównego, identyfikator studenta, który uczestniczy w danych studiach
- DidAttend bit nullable – informacja o tym, czy student zaliczył praktyki
  - Wartość domyślna: 1

```sql
-- Table: InternshipDetails
CREATE TABLE InternshipDetails (
    InternshipID int  NOT NULL,
    StudentID int  NOT NULL,
    DidAttend bit  NULL DEFAULT 1,
    CONSTRAINT InternshipDetails_pk PRIMARY KEY  (InternshipID,StudentID)
);
```

## Tabela Subject

Zawiera podstawowe informacje o przedmiotach:

- **SubjectID** int – klucz główny, identyfikator przedmiotu
- StudiesID int– identyfikator studiów do których dany przedmiot należy
- Coordinator ID int – identyfikator koordynatora przedmiotu
- SubjectName varchar(50) – nazwa przedmiotu
- SubjectDescription text nullable – opis przedmiotu

```sql
-- Table: Subject
CREATE TABLE Subject (
    SubjectID int  NOT NULL,
    StudiesID int  NOT NULL,
    CoordinatorID int  NOT NULL,
    SubjectName varchar(50)  NOT NULL,
    SubjectDescription text  NULL,
    CONSTRAINT Subject_pk PRIMARY KEY  (SubjectID)
);
```

## Tabela SubjectDetails

Zawiera szczegółowe informacje dotyczące uczestnictwa w przedmiocie:

- **SubjectID** int – część klucza głównego, identyfikator przedmiotu
- **StudentID** int – część klucza głównego, identyfikator studenta przynależącego do przedmiotu
- SubjectGrade int – identyfikator oceny za przedmiot (zaliczenie przedmiotu)

```sql
-- Table: SubjectDetails
CREATE TABLE SubjectDetails (
    SubjectID int  NOT NULL,
    StudentID int  NOT NULL,
    SubjectGrade int  NOT NULL,
    CONSTRAINT SubjectDetails_pk PRIMARY KEY  (SubjectID,StudentID)
);
```

## Tabela StudyMeeting

Zawiera podstawowe informacje o pojedynczym spotkaniu studyjnym:

- **StudyMeetingID** int – klucz główny, identyfikator spotkania
- SubjectID int – identyfikator przedmiotu do którego dane spotkanie należy
- TeacherID int – identyfikator nauczyciela
- MeetingName varchar(50) – nazwa spotkania
- MeetingPrice money– cena spotkania
  - warunek: MeetingPrice > 0
  - wartość domyślna: 100
- Date datetime – data spotkania
- DurationTime time(0) – czas trwania spotkania
  - warunek: DurationTime > '00:00:00’
  - wartość domyślna: 01:30:00
- TranslatorID int nullable – identyfikator tłumacza na danym spotkaniu, jeżeli jest ono prowadzone w języku obcym
- LanguageID int nullable – identyfikator języka, w jakim jest prowadzone spotkanie

```sql
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
```

## Tabela StudyMeetingDetails

Zawiera szczegółowe informacje o pojedynczym spotkaniu studyjnym:

- **StudyMeetingID** int – część klucza głównego, identyfikator spotkania
- **StudentID** int – część klucza głównego, identyfikator studenta przynależącego do spotkania
- Presence bit nullable – informacja o obecności studenta na spotkaniu
  - wartość domyślna: 1

```sql
-- Table: StudyMeetingDetails
CREATE TABLE StudyMeetingDetails (
    StudyMeetingID int  NOT NULL,
    StudentID int  NOT NULL,
    Presence bit  NULL DEFAULT 1,
    CONSTRAINT StudyMeetingDetails_pk PRIMARY KEY  (StudyMeetingID,StudentID)
);
```

## Tabela StationaryMeeting

Zawiera szczegółowe informacje o stacjonarnych spotkaniach studyjnych:

- **MeetingID** int – klucz główny, identyfikator spotkania
- Room varchar(10) – informacja o pokoju w którym odbywa się spotkanie
- Limit int nullable – informacja o limicie miejsc na danym spotkaniu
  - warunek: Limit > 0
  - wartość domyślna: 30

```sql
-- Table: StationaryMeeting
CREATE TABLE StationaryMeeting (
    MeetingID int  NOT NULL,
    Room varchar(10)  NOT NULL,
    Limit int  NULL DEFAULT 30 CHECK (Limit > 0),
    CONSTRAINT StationaryMeeting_pk PRIMARY KEY  (MeetingID)
);
```

## Tabela OnlineAsyncMeeting

Zawiera szczegółowe informacje o zdalnych asynchronicznie prowadzonych spotkaniach studyjnych:

- **MeetingID** int – klucz główny, identyfikator spotkania
- VideoLink varchar(50) – link do nagrania, które student musi obejrzeć, by uzyskać obecność na spotkaniu

```sql
-- Table: OnlineAsyncMeeting
CREATE TABLE OnlineAsyncMeeting (
    MeetingID int  NOT NULL,
    VideoLink varchar(50)  NOT NULL,
    CONSTRAINT OnlineAsyncMeeting_pk PRIMARY KEY  (MeetingID)
);
```

## Tabela OnlineSyncMeeting

Zawiera szczegółowe informacje o zdalnych synchronicznie prowadzonych spotkaniach studyjnych:

- **MeetingID** int – klucz główny, identyfikator spotkania
- Link varchar(50) – link do spotkania online

```sql
-- Table: OnlineSyncMeeting
CREATE TABLE OnlineSyncMeeting (
    MeetingID int  NOT NULL,
    Link varchar(50)  NOT NULL,
    CONSTRAINT OnlineSyncMeeting_pk PRIMARY KEY  (MeetingID)
);
```

## Tabela PossibleGrades

Słownik możliwych do uzyskania przez studenta oce:

- **GradeID** int – klucz główny, identyfikator oceny
- GradeValue real – wartość oceny
- GradeName varchar(20) – nazwa oceny

```sql
-- Table: PossibleGrades
CREATE TABLE PossibleGrades (
    GradeID int  NOT NULL,
    GradeValue real  NOT NULL CHECK (GradeValue > 0),
    GradeName varchar(20)  NOT NULL,
    CONSTRAINT PossibleGrades_pk PRIMARY KEY  (GradeID)
);
```
