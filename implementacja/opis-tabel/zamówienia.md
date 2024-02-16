# Kategoria Orders

## Tabela Orders

Zawiera podstawowe informacje o zamówieniach studentów:

- **OrderID** int - klucz główny, identyfikator zamówienia
- StudentID int - identyfikator studenta
- Paid money nullable - kwota, którą łącznie zapłacił student do tej pory
  - warunek: Paid >= 0
  - wartość domyślna: 0
- OrderDate datetime - data złożenia zamówienia

```sql
-- Table: Orders
CREATE TABLE Orders (
OrderID int NOT NULL,
StudentID int NOT NULL,
Paid money NULL DEFAULT 0 CHECK (Paid >=0),
OrderDate datetime NOT NULL,
CONSTRAINT Orders_pk PRIMARY KEY (OrderID)
);
```

## Tabela OrderDetails

Zawiera szczegółowe informacje o zamówieniach:

- **OrderDetailsID** int - klucz główny, identyfikator szczegółów zamówienia
- OrderID int - identyfikator zamówienia
- PaidDate datetime - data zapłacenia za część zamówienia

```sql
-- Table: OrderDetails
CREATE TABLE OrderDetails (
OrderDetailsID int NOT NULL,
OrderID int NOT NULL,
PaidDate datetime NOT NULL,
CONSTRAINT OrderDetails_pk PRIMARY KEY (OrderDetailsID)
);
```

## Tabela OrderStudies

Łączy zakupione studia z koszykiem:

- **OrderDetailsID** int - klucz główny, identyfikator szczegółów zamówienia
- StudiesID int - identyfikator studiów

```sql
-- Table: OrderStudies
CREATE TABLE OrderStudies (
OrderDetailsID int NOT NULL,
StudiesID int NOT NULL,
CONSTRAINT OrderStudies_pk PRIMARY KEY (OrderDetailsID)
);
```

## Tabela OrderStudyMeeting

Łączy zakupione spotkania studyjne z koszykiem:

- **OrderDetailsID** int - klucz główny, identyfikator szczegółów zamówienia
- StudyMeetingID int - identyfikator spotkania studyjnego

```sql
-- Table: OrderStudyMeeting
CREATE TABLE OrderStudyMeeting (
OrderDetailsID int NOT NULL,
StudyMeetingID int NOT NULL,
CONSTRAINT OrderStudyMeeting_pk PRIMARY KEY (OrderDetailsID)
);
```

## Tabela OrderWebinars

Łączy zakupione webinary z koszykiem:

- **OrderDetailsID** int - klucz główny, identyfikator szczegółów zamówienia
- WebinarID int - identyfikator webinaru

```sql
-- Table: OrderWebinars
CREATE TABLE OrderWebinars (
OrderDetailsID int NOT NULL,
WebinarID int NOT NULL,
CONSTRAINT OrderWebinars_pk PRIMARY KEY (OrderDetailsID)
);
```

## Tabela OrderCourse

Łączy zakupione kursy z koszykiem:

- **OrderDetailsID** int - klucz główny, identyfikator szczegółów zamówienia
- CourseID int - identyfikator kursu

```sql
-- Table: OrderCourse
CREATE TABLE OrderCourse (
OrderDetailsID int NOT NULL,
CourseID int NOT NULL,
CONSTRAINT OrderCourse_pk PRIMARY KEY (OrderDetailsID)
);
```
