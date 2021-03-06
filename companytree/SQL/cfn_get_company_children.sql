
/****** Object:  UserDefinedFunction [dbo].[cfn_get_company_children]    Script Date: 2015-02-16 13:04:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		JKS
-- Create date: 2015-02-18
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[cfn_get_company_children]
(
	-- Add the parameters for the function here
	@@idparent INTEGER,
	@@level INTEGER,
	@@includeperson BIT
)
RETURNS XML

AS
BEGIN
	-- Declare the return variable here
		DECLARE @sql AS NVARCHAR(MAX)
		DECLARE @ret AS XML
		DECLARE @includeperson AS INTEGER = -1


		IF @@includeperson = 1
			SET @includeperson = @@idparent

		;WITH cte AS (
			SELECT	
					[name] AS 'name',
					[idcompany] AS 'idrecord',
					'company' AS 'type',
					CASE WHEN [postaladdress1] <> '' THEN [postaladdress1] + ', ' ELSE '' END + [postalcity] AS 'info',
					CASE WHEN @@level < 10 THEN ISNULL([dbo].[cfn_get_company_children]([idcompany],@@level + 1, @@includeperson),N'') ELSE N'' END AS 'children'
			FROM [company]
			WHERE [parentcompany]= @@idparent AND [status] = 0

			UNION ALL

			SELECT	
					[name] AS 'name',
					[idperson] AS 'idrecord',
					'person' AS 'type',
					'' as 'info',
					N'' AS 'children'
			FROM [person]
			WHERE [company] = @includeperson AND [status] = 0
		) 
		SELECT @ret = (SELECT [name],[idrecord], [type],[info], [children] FROM cte FOR XML PATH(''), TYPE)
		RETURN @ret

END
