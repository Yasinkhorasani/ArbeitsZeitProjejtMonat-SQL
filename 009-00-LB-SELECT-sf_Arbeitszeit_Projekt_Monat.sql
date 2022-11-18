USE FirmaUebung;
GO

SELECT Projekt.Projekt, 
	   dbo.Projekt.ProjektID,
	   Arbeitszeit.Datum, 
	   Personal.Nachname, Personal.Vorname, 
	   Arbeitszeit.Zeit
FROM Arbeitszeit INNER JOIN
        Projektzuordnung ON Arbeitszeit.ProjektzuordnungID = Projektzuordnung.ID INNER JOIN
        Projekt ON Projektzuordnung.ProjektID = Projekt.ProjektID INNER JOIN
        Personal ON Projektzuordnung.PersonalID = Personal.PersonalID
ORDER BY Projekt, Arbeitszeit.Datum DESC, Personal.Nachname;

SELECT TOP (100) PERCENT 
	SUM(dbo.Arbeitszeit.Zeit) AS SumZeit, 
	dbo.Projekt.ProjektID, dbo.Projekt.Projekt, 
	YEAR(dbo.Arbeitszeit.Datum) AS Jahr, MONTH(dbo.Arbeitszeit.Datum) AS Monat
FROM dbo.Arbeitszeit 
		INNER JOIN dbo.Projektzuordnung 
			ON dbo.Arbeitszeit.ProjektzuordnungID = dbo.Projektzuordnung.ID 
		INNER JOIN dbo.Projekt 
			ON dbo.Projektzuordnung.ProjektID = dbo.Projekt.ProjektID
WHERE 
	(dbo.Projekt.ProjektID = 50)
GROUP BY dbo.Projekt.ProjektID, dbo.Projekt.Projekt, 
YEAR(dbo.Arbeitszeit.Datum), MONTH(dbo.Arbeitszeit.Datum)
ORDER BY Jahr DESC, Monat DESC;

SELECT TOP (100) PERCENT 
	SUM(dbo.Arbeitszeit.Zeit) AS SumZeit, 
	dbo.Projekt.ProjektID, dbo.Projekt.Projekt, 
	YEAR(dbo.Arbeitszeit.Datum) AS Jahr, MONTH(dbo.Arbeitszeit.Datum) AS Monat
FROM dbo.Arbeitszeit INNER JOIN
    dbo.Projektzuordnung ON dbo.Arbeitszeit.ProjektzuordnungID = dbo.Projektzuordnung.ID INNER JOIN
    dbo.Projekt ON dbo.Projektzuordnung.ProjektID = dbo.Projekt.ProjektID
WHERE 
	(YEAR(dbo.Arbeitszeit.Datum) = 2020) 
	AND (MONTH(dbo.Arbeitszeit.Datum) = 4) 
	AND (dbo.Projekt.ProjektID = 50)
GROUP BY dbo.Projekt.ProjektID, dbo.Projekt.Projekt, YEAR(dbo.Arbeitszeit.Datum), MONTH(dbo.Arbeitszeit.Datum);

SELECT SUM(dbo.Arbeitszeit.Zeit) AS SumZeit
FROM dbo.Arbeitszeit 
	INNER JOIN dbo.Projektzuordnung 
		ON dbo.Arbeitszeit.ProjektzuordnungID = dbo.Projektzuordnung.ID 
	INNER JOIN dbo.Projekt 
		ON dbo.Projektzuordnung.ProjektID = dbo.Projekt.ProjektID
WHERE (YEAR(dbo.Arbeitszeit.Datum) = 2021) 
AND (MONTH(dbo.Arbeitszeit.Datum) = 5) 
AND (dbo.Projekt.ProjektID = 50)
--GROUP BY dbo.Projekt.ProjektID, 
--		 dbo.Projekt.Bezeichnung, 
--		 YEAR(dbo.Arbeitszeit.Datum), 
--		 MONTH(dbo.Arbeitszeit.Datum);


SELECT SUM(dbo.Arbeitszeit.Zeit) AS SumZeit
FROM dbo.Arbeitszeit 
	INNER JOIN dbo.Projektzuordnung 
		ON dbo.Arbeitszeit.ProjektzuordnungID = dbo.Projektzuordnung.ID
WHERE (YEAR(dbo.Arbeitszeit.Datum) = 2022) 
AND   (MONTH(dbo.Arbeitszeit.Datum) = 7) 
AND   (dbo.Projektzuordnung.ProjektID = 50); -- 97 Std.
