USE [wholesale_ie]
GO
/****** Object:  StoredProcedure [dbo].[csp_getcoworkers]    Script Date: 2015-06-22 11:02:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[csp_getcoworkers]
	@@xml as nvarchar(max) output
AS
BEGIN
	-- FLAG_EXTERNALACCESS --
	declare @xml as xml
	
	select @xml = (
	SELECT idcoworker, name
	FROM coworker
	WHERE [status] = 0
	AND active = 1
	for xml path('coworker'), ROOT('coworkers'))

	set @@xml = case when @xml is null then '' else cast(@xml as nvarchar(max))	end 
END
