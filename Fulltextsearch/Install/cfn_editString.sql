USE [limebootstrap_aas]
GO
/****** Object:  UserDefinedFunction [dbo].[cfn_editString]    Script Date: 2015-04-02 10:15:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Andreas Åström>
-- Create date: <2014-03-11>
-- Description:	<Handels option for full-text search>
-- =============================================
ALTER FUNCTION [dbo].[cfn_editString]
(
	@searchString as nvarchar(4000)
)
RETURNS nvarchar(4000)
AS
BEGIN

	IF (select dbo.cfn_checkString(@searchString)) = 1
	BEGIN 	
	
		declare @word as nvarchar(512)
		declare @type as nvarchar(10)
		declare @subword as nvarchar(512)
		declare @rows as int
		
		set @rows = 0 
		
		declare @stringTable table  
		([rows] int 
		,word  nvarchar(32)
		,[seperator] nvarchar(32)
		,done int)

		while (dbo.cfn_checkString(@searchString) = 1)
		begin
			set @type = ''
			set @type = DBO.cfn_checkType(@searchString)	
			select @word = SUBSTRING(@searchString, 0, CHARINDEX(@type,@searchString))		
			select @searchString = SUBSTRING(@searchString, CHARINDEX(@type,@searchString) + LEN(@type),LEN(@searchString)) 				
		
			IF (select dbo.cfn_checkString(@word)) = 0
			begin					
				insert into @stringTable (word,seperator,[rows],done) values (@word,1,@rows,0 )
				set @rows = @rows + 1 
				insert into @stringTable (word,seperator,[rows],done) values (@type,0,@rows,0)
			end
			else
			begin			
				set @searchString = replace(@word,' ','" & "') + ' ' + @searchString			
			end		
			set @rows = @rows + 1 		
		end
		insert into @stringTable (word,seperator,[rows],done) values (@searchString,1,@rows,0 )
	END 
	ELSE
	BEGIN		
		insert into @stringTable (word,seperator,[rows],done) values ((select replace(@searchString,' ','" & "')),1,@rows,0 )
	END

	declare @count int 
	declare @string as nvarchar(256)
	declare @separator as nvarchar(10)
	set @word = ''
	set @string = ''

	select @count = count(*)  from @stringTable
	where word <> ''
	set @rows = 0

	while(@count >= @rows)
	begin
		select @word = (select top 1 word from @stringTable 
		where done = 0
		and word <> ''
		and seperator = 1) 
	
		select @separator = (select top 1 word from @stringTable
		where done = 0
		and word <> ''
		and seperator = 0)
		
		set @string = @string + '"' + rtrim(Ltrim(ISNULL(@word, ''))) + '"' + case when isnull(@separator,'') = ' && ' then 'AND' else isnull(@separator,'') end

		update @stringTable set done = 1 
		where rows = @rows
		and word <> ''
		set @rows = @rows + 1

		update @stringTable set done = 1 
		where rows = @rows
		and word <> ''
	
		set @rows = @rows + 1
	end

	set @string = replace(@string,'""','')
	
	return @string

END
