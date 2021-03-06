
/****** Object:  StoredProcedure [dbo].[csp_get_historyflow]    Script Date: 2015-02-18 17:13:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[csp_get_historyflow]
	-- Add the parameters for the stored procedure here
	@@table NVARCHAR(32),
	@@hitcount NVARCHAR(8),
	@@idrecord NVARCHAR(16),
	@@lang NVARCHAR(8),
	@@retval NVARCHAR(MAX) OUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--FLAG_EXTERNALACCESS--
	SET NOCOUNT ON;
	
    DECLARE @sql NVARCHAR(MAX)

	SET @sql = '
	SELECT @@retval = 
	(
	SELECT 
	CAST(
		(SELECT(
			SELECT TOP ' + @@hitcount + '
				h.[idhistory],
				s.[sv] AS ''title'',
				ISNULL(p.[name],N'''') AS ''person'',
				SUBSTRING(h.[note],1,50) AS ''text'',
				SUBSTRING(CONVERT(NVARCHAR(32),h.[createdtime],21),1,10) AS ''date'',
				SUBSTRING(CONVERT(NVARCHAR(32),h.[createdtime],21),12,5) as ''time'',
				CASE s.[key] 
					WHEN ''talkedto'' THEN ''fa-phone''
					WHEN ''customervisit'' THEN''fa-group''
					WHEN ''salescall'' THEN''fa-money''
					WHEN ''comment'' THEN''fa-comment''
					WHEN ''sentemail'' THEN''''
					WHEN ''receivedemail'' THEN''fa-inbox''
					WHEN ''noanswer'' THEN''fa-envelope''
					ELSE ''fa-coffee''
				END	AS ''icon''
			FROM [history] h
			LEFT JOIN [person] p ON p.[idperson] = h.[person] AND p.[status] = 0
			INNER JOIN [' + @@table + '] t ON t.[id' + @@table + '] = h.[' + @@table + ']
			INNER JOIN [string] s ON s.[idstring] = h.[type]
			WHERE t.[id' + @@table + '] = ' + @@idrecord + ' AND h.[status] = 0
			ORDER BY h.[createdtime] DESC
			FOR XML PATH(''history''), TYPE
		) FOR XML PATH(''histories''), TYPE 
	) AS NVARCHAR(MAX)))'

	EXEC sp_executesql @sql, N'@@retval NVARCHAR(MAX) OUT', @@retval OUT
	
END
