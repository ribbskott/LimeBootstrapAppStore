/****** Object:  StoredProcedure [dbo].[csp_sendSMS]    Script Date: 07/06/2015 14:14:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		AAS
-- Create date: 2014-11-04
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[csp_sendSMS]	
AS
BEGIN
	-- FLAG_EXTERNALACCESS --
	exec msdb.dbo.sp_start_job N'Lime - Send SMS - Sharp'
END
