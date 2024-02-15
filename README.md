# PBD 23/24 - Projekt

Projekt realizowany w ramach przedmiotu Podstawy Baz Danych _PBD_ na kierunku Informatyka na AGH.

## Zespół

Projekt został wykonany przez:

- [Konrada Armatys](https://github.com/karmatys8)
- [Wojciecha Michaluk](https://github.com/wojmichaluk)
- [Jakuba Worek](https://github.com/JakubWorek)

## Polecenie

Pełna treść polecenia jest dostępna [tutaj](/polecenie.pdf).

W skrócie mieliśmy zaprojektować i zaimplementować bazę danych przechowujące informacje dotyczące:

- użytkowników, ich obecności, koszyków, zakupów itp.
- pracowników
- webinarów - jednokrotne spotkanie online, które dodatkowo jest nagrywane
- kursów - zbiór spotkań w 3 różnych rodzajach: stacjonarne, online synchroniczne, online asynchroniczne (kurs może zawierać więcej niż 1 rodzaj spotkań)
- studiów - zbiór przedmiotów które składają się z spotkań studyjnych, które mają te same rodzaje co wyżej, dodatkowo użytkownik może zapisać się na pojedyncze spotkanie studyjne

Dodatkowo:

- system płatności jest aktorem zewnętrznym, przechowujemy jedynie informacje o płatnościach
- dyrektor może zmieniać terminy płatności
- możliwość generowania różnych raportów
- kursy stacjonarne i studia mają limit miejsc
- formy kształcenia mogą być w języku innym niż polski, wtedy można przypisać do nich tłumacza

## Nasze założenia

Niektóre aspekty projektu były niedoprecyzowane, dlatego sami je doprecyzowaliśmy.

- Odrabianie nieobecności to lista odrobionych zajęć.
- Przechowujemy informację, czy użytkownik kursu w ramach modułu prowadzonego on-line asynchronicznie obejrzał nagranie lub nie - reszta procesu jest nieistotna.
- Aby otrzymać nagranie z webinaru nie trzeba uczestniczyć na żywo - wystarczy być zapisanym.
- Wzrost ceny spotkania studyjnego dla osób spoza studiów jest zawsze zwiększany o **x**%.
- Przez zajęcia rozumiemy webinary / kursy / studia / pojedyncze spotkania studyjne.
- Zewnętrzny system udostępnia informacje i historie płatności.
- Użytkownik ma możliwość kontaktu z dyrektorem w sprawie odroczenia opłat.

## Schemat ukończonej bazy

![schemat bazy](/schemat.png)
