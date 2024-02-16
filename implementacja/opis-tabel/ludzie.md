# Kategoria People

## Tabela Students

Zawiera podstawowe informacje o studentach:

- **StudentID** int – klucz główny, identyfikator studenta
- FirstName varchar(30) – imię studenta
- LastName varchar(30) – nazwisko studenta
- Address varchar(30) – adres studenta
- CityID int – identyfikator miasta, z którego pochodzi student
- PostalCode varchar(10) – kod pocztowy
- Phone varchar(15) nullable unique – numer telefonu do studenta
  - warunek: LEN(Phone) = 15 AND ISNUMERIC(Phone) = 1
- Email varchar(50) unique – adres poczty elektronicznej studenta.
  - warunek: Email LIKE '%\_@**%.**%'

```sql
-- Table: Students
CREATE TABLE Students (
    StudentID int  NOT NULL,
    FirstName varchar(30)  NOT NULL,
    LastName varchar(30)  NOT NULL,
    Address varchar(30)  NOT NULL,
    CityID int  NOT NULL,
    PostalCode varchar(10)  NOT NULL,
    Phone varchar(15)  NULL CHECK (LEN(Phone) = 15 AND ISNUMERIC(Phone) = 1),
    Email varchar(50)  NOT NULL CHECK (Email LIKE '%_@__%.__%'),
    CONSTRAINT StudentsEmail UNIQUE (Email),
    CONSTRAINT StudentsPhone UNIQUE (Phone),
    CONSTRAINT Students_pk PRIMARY KEY  (StudentID)
);
```

## Tabela PossibleCity

Zawiera informacje o miastach wraz z państwami, w których one leżą:

- **CityID** int – klucz główny, identyfikator miasta
- CityName varchar(20) – nazwa miasta
- CountryID int – identyfikator państwa, w którym dane miasto leży

```sql
-- Table: PossibleCity
CREATE TABLE PossibleCity (
    CityID int  NOT NULL,
    CityName varchar(20)  NOT NULL,
    CountryID int  NOT NULL,
    CONSTRAINT PossibleCity_pk PRIMARY KEY  (CityID)
);
```

## Tabela PossibleCountry

Zawiera informacje o państwach:

- **CountryID** int – klucz główny, identyfikator państwa
- CountryName varchar(20) – identyfikator miasta

```sql
-- Table: PossibleCountry
CREATE TABLE PossibleCountry (
    CountryID int  NOT NULL,
    CountryName varchar(20)  NOT NULL,
    CONSTRAINT PossibleCountry_pk PRIMARY KEY  (CountryID)
);
```

## Tabela Translators

Zawiera podstawowe informacje o tłumaczach:

- **TranslatorID** int – klucz główny, identyfikator tłumacza
- FirstName varchar(30) – imię tłumacza
- LastName varchar(30) – nazwisko tłumacza
- HireDate date nullable – data zatrudnienia tłumacza
- BirthDate date nullable – data urodzenia tłumacza
- Phone varchar(15) nullable unique – numer telefonu do tłumacza
  - warunek: LEN(Phone) = 15 AND ISNUMERIC(Phone) = 1
- Email varchar(50) unique – adres poczty elektronicznej tłumacza.
  - warunek: Email LIKE '%\_@**%.**%'

```sql
-- Table: Translators
CREATE TABLE Translators (
    TranslatorID int  NOT NULL,
    FirstName varchar(30)  NOT NULL,
    LastName varchar(30)  NOT NULL,
    HireDate date  NULL,
    BirthDate date  NULL,
    Phone varchar(15)  NULL CHECK (LEN(Phone) = 15 AND ISNUMERIC(Phone) = 1),
    Email varchar(50)  NOT NULL CHECK (Email LIKE '%_@__%.__%'),
    CONSTRAINT TranslatorsEmail UNIQUE (Email),
    CONSTRAINT TranslatorsPhone UNIQUE (Phone),
    CONSTRAINT Translators_pk PRIMARY KEY  (TranslatorID)
);
```

## Tabela TranslatorsLanguages

Zawiera informacje o tłumaczach oraz językach, z których potrafią tłumaczyć:

- **TranslatorID** int – część klucza głównego, identyfikator tłumacza
- **LanguageID** int – część klucza głównego, identyfikator języka

```sql
-- Table: TranslatorsLanguages
CREATE TABLE TranslatorsLanguages (
    TranslatorID int  NOT NULL,
    LanguageID int  NOT NULL,
    CONSTRAINT TranslatorsLanguages_pk PRIMARY KEY  (TranslatorID,LanguageID)
);
```

## Tabela PossibleLanguages

Zawiera informacje o obsługiwanych językach:

- **LanguageID** int – klucz główny, identyfikator języka
- LanguageName varchar(20) – nazwa języka

```sql
-- Table: PossibleLanguages
CREATE TABLE PossibleLanguages (
    LanguageID int  NOT NULL,
    LanguageName varchar(20)  NOT NULL,
    CONSTRAINT PossibleLanguages_pk PRIMARY KEY  (LanguageID)
);
```

## Tabela Employees

Zawiera podstawowe informacje o pracownikach:

- **EmployeeID** int – klucz główny, identyfikator pracownika
- FirstName varchar(30) – imię pracownika
- LastName varchar(30) – nazwisko pracownika
- HireDate date nullable – data zatrudnienia pracownika
- BirthDate date nullable – data urodzenia pracownika
- Phone varchar(15) nullable unique – numer telefonu do pracownika
  - warunek: LEN(Phone) = 15 AND ISNUMERIC(Phone) = 1
- Email varchar(50) unique – adres poczty elektronicznej pracownika
  - warunek: Email LIKE '%\_@**%.**%’
- EmployeeType int – „rodzaj” pracownika, np. nauczyciel, koordynator kursu

```sql
-- Table: Employees
CREATE TABLE Employees (
    EmployeeID int  NOT NULL,
    FirstName varchar(30)  NOT NULL,
    LastName varchar(30)  NOT NULL,
    HireDate date  NULL,
    BirthDate date  NULL,
    Phone varchar(15)  NULL CHECK (LEN(Phone) = 15 AND ISNUMERIC(Phone) = 1),
    Email varchar(50)  NOT NULL CHECK (Email LIKE '%_@__%.__%'),
    EmployeeType int  NOT NULL,
    CONSTRAINT EmployeesEmail UNIQUE (Email),
    CONSTRAINT EmployeesPhone UNIQUE (Phone),
    CONSTRAINT Employees_pk PRIMARY KEY  (EmployeeID)
);
```

## Tabela EmployeeTypes

Zawiera informacje o rodzajach pracowników:

- **EmployeeTypeID** int – klucz główny, identyfikator typu pracownika
- EmployeeTypeName varchar(30) – nazwa danego rodzaju pracownika

```sql
-- Table: EmployeeTypes
CREATE TABLE EmployeeTypes (
    EmployeeTypeID int  NOT NULL,
    EmployeeTypeName varchar(30)  NOT NULL,
    CONSTRAINT EmployeeTypes_pk PRIMARY KEY  (EmployeeTypeID)
);
```
