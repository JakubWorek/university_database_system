# Kategoria Webinars

## Tabela Webinars

Zawiera podstawowe informacje o webinarach:

- **WebinarID** int – klucz główny, identyfikator webinaru
- TeacherID int – identyfikator wykładowcy
- TranslatorID int nullable – identyfikator tłumacza (jeżeli webinar jest prowadzony w obcym języku)
- WebinarName varchar(50) – tytuł webinaru
- WebinarPrice money nullable – cena, jaką należy uiścić za webinar
  - warunek: WebinarPrice >= 0
  - wartość domyślna: 500
- VideoLink varchar(50) – link do nagrania webinaru
- WebinarDate datetime – data (dzień oraz dokładna godzina) rozpoczęcia webinaru
- DurationTime time(0) nullable – czas trwania webinaru
  - warunek: DurationTime > '00:00:00’
  - wartość domyślna: 01:30:00
- WebinarDescription text nullable – opis webinaru
- LanguageID int nullable – identyfikator języka, w jakim jest prowadzony webinar (jeżeli webinar jest prowadzony w obcym języku)

```sql
-- Table: Webinars
CREATE TABLE Webinars (
    WebinarID int  NOT NULL,
    TeacherID int  NOT NULL,
    TranslatorID int  NULL,
    WebinarName varchar(50)  NOT NULL,
    WebinarPrice money  NULL DEFAULT 500 CHECK (WebinarPrice >= 0),
    VideoLink varchar(50)  NOT NULL,
    WebinarDate datetime  NOT NULL,
    DurationTime time(0)  NULL DEFAULT 01:30:00 CHECK (DurationTime > '00:00:00'),
    WebinarDescription text  NULL,
    LanguageID int  NULL,
    CONSTRAINT Webinars_pk PRIMARY KEY  (WebinarID)
);
```

## Tabela WebinarDetails

Zawiera szczegółowe informacje dotyczące uczestnictwa w webinarach:

- **StudentID** int – część klucza głównego, identyfikator studenta, który uczestniczył w danym webinarze
- **WebinarID** int – część klucza głównego, identyfikator webinaru
- AvailableDue date – termin dostępu do nagrania webinaru dla studenta

```sql
-- Table: WebinarDetails
CREATE TABLE WebinarDetails (
    StudentID int  NOT NULL,
    WebinarID int  NOT NULL,
    AvailableDue date  NOT NULL,
    CONSTRAINT WebinarDetails_pk PRIMARY KEY  (StudentID,WebinarID)
);
```
