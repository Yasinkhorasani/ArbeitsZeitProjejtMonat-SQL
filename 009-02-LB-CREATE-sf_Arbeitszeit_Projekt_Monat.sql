USE [FirmaUebung];
GO

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
DROP FUNCTION IF EXISTS dbo.sf_Arbeitszeit_Projekt_Monat;
GO

CREATE FUNCTION sf_Arbeitszeit_Projekt_Monat 
(
	@ProjektID bigint,
	@Datum date
)
RETURNS smallint
AS
BEGIN
	DECLARE @Arbeitszeit_Projekt_Monat smallint;

---- Monat und Jahr -----------------------------------------------------------	
	DECLARE @Monat int;
	DECLARE @Jahr int;

	SET @Monat = MONTH(@Datum);
	SET @Jahr = YEAR(@Datum);

	-- Var. mit JOIN
	SET @Arbeitszeit_Projekt_Monat = 
	(
		SELECT SUM(dbo.Arbeitszeit.Zeit)
		FROM dbo.Arbeitszeit 
			INNER JOIN dbo.Projektzuordnung 
				ON dbo.Arbeitszeit.ProjektzuordnungID = dbo.Projektzuordnung.ID
		WHERE (YEAR(dbo.Arbeitszeit.Datum) = @Jahr) 
		AND   (MONTH(dbo.Arbeitszeit.Datum) = @Monat) 
		AND   (dbo.Projektzuordnung.ProjektID = @ProjektID)
	);

	-- Var. mit Unterabfrage (subquery)
	--SELECT @Arbeitszeit_Projekt_Monat = SUM(Zeit)
	--FROM dbo.Arbeitszeit
	--WHERE MONTH(Datum) = @Monat
	--	  AND YEAR(Datum) = @Jahr
	--	  AND
	--	  ProjektzuordnungID IN
	--	  ---- Alle @ProjektzuordnungID (@ProjektID) ----
	--	  ---- für @ProjektID arbeiten mehrere Mitarbeiter -----------------
	--	  (
	--		-- das ist eine Unterabfrage (subquery)
	--	  	SELECT ID
	--	  	FROM Projektzuordnung
	--	  	WHERE ProjektID = @ProjektID
	--	  );

/*	
	-- so geht auch, ist aber viel zu kompliziert;)

	DECLARE @Monat int
	DECLARE @Jahr int
	DECLARE @Monatsmuster varchar(2) --'02'
	DECLARE @Datumsmuster varchar(10) --'2020-02-__'

	SET @Monat = MONTH(@Datum)
	SET @Jahr = YEAR(@Datum)

	IF (@Monat < 10) -- Januar bis September: 1 bis 9
		SET @Monatsmuster = '0' + CONVERT(varchar(2),@Monat)
	ELSE -- Oktober bis Dezember
		SET @Monatsmuster = CONVERT(varchar(2),@Monat)	

	SET @Datumsmuster = CONVERT(varchar(4),@Jahr) 
					  + '-' 	 
					  + @Monatsmuster
					  + '-__' 	-- so geht auch:  + '-[0-9][0-9]'
	SELECT @Arbeitszeit_Projekt_Monat = SUM(Zeit)
	FROM dbo.Arbeitszeit
	WHERE ProjektzuordnungID IN
---- Alle @ProjektzuordnungID (@ProjektID) ----
---- für @ProjektID arbeiten mehrere Mitarbeiter -----------------
		(SELECT ID
		 FROM Projektzuordnung
		 WHERE ProjektID = @ProjektID)
	AND Datum LIKE @Datumsmuster;
	-- Es geht auch ohne @Datumsmuster:
	-- AND MONTH(Datum) = @Monat
	-- AND YEAR(Datum) = @Jahr
	*/

	SET @Arbeitszeit_Projekt_Monat = 
		IIF(@Arbeitszeit_Projekt_Monat IS NULL, 0, @Arbeitszeit_Projekt_Monat);
	/*
	Gibt einen von zwei Werten zurück, abhängig davon, 
	ob der boolesche Ausdruck "true" oder "false" in SQL Server ergibt
	https://docs.microsoft.com/de-de/sql/t-sql/functions/logical-functions-iif-transact-sql?view=sql-server-2017
	*/
		
	-- es geht auch so:
	/*
	IF @Arbeitszeit_Projekt_Monat IS NULL
		SET @Arbeitszeit_Projekt_Monat = 0
	--ELSE
		-- nicht ändern
	
	RETURN @Arbeitszeit_Projekt_Monat;
	*/
	
	-- Return the result of the function
	RETURN @Arbeitszeit_Projekt_Monat;

END
GO

