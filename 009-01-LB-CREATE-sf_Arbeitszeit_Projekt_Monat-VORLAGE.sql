USE [FirmaUebung]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
	-- TODO --
	-- wie viel Zeit haben alle Mitarbeiter in dem Monat, 
	-- in dem das Datum liegt, für das Projekt @ProjektID gearbeitet
	-- SET @Arbeitszeit_Projekt_Monat = (SELECT ***)

	SET @Arbeitszeit_Projekt_Monat = 
		iif(@Arbeitszeit_Projekt_Monat IS NULL, 0, @Arbeitszeit_Projekt_Monat);	
	
	-- Return the result of the function
	RETURN @Arbeitszeit_Projekt_Monat;

END
GO

