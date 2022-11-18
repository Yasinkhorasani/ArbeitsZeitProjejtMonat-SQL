USE [FirmaUebung];
GO

--SELECT ID
--FROM Projektzuordnung
--WHERE ProjectID = 70


SELECT dbo.sf_Arbeitszeit_Projekt_Monat (50, '2021-05-18'); -- Pappa Mia, 99 Std.


--SELECT dbo.sf_Arbeitszeit_Projekt_Monat (50, '2023-05-18'); -- Zukunft, NULL -> 0 Std.