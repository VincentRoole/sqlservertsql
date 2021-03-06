USE [MyBank]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 03/23/2013 18:40:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[uid] [int] IDENTITY(1,1) NOT NULL,
	[uname] [varchar](50) NOT NULL,
	[ushenfen] [varchar](50) NOT NULL,
	[utel] [varchar](50) NULL,
	[uaddress] [varchar](100) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[uid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[JYType]    Script Date: 03/23/2013 18:40:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[JYType](
	[jytcode] [int] IDENTITY(1,1) NOT NULL,
	[jytname] [varchar](50) NOT NULL,
 CONSTRAINT [PK_JYType] PRIMARY KEY CLUSTERED 
(
	[jytcode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CardInfo]    Script Date: 03/23/2013 18:40:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CardInfo](
	[cardid] [varchar](50) NOT NULL,
	[uid] [int] NOT NULL,
	[cardpwd] [varchar](20) NOT NULL,
	[cardyu] [float] NOT NULL,
	[opendate] [datetime] NOT NULL,
 CONSTRAINT [PK_CardInfo] PRIMARY KEY CLUSTERED 
(
	[cardid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[YJLog]    Script Date: 03/23/2013 18:40:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[YJLog](
	[jycode] [varchar](50) NOT NULL,
	[cardid] [varchar](50) NOT NULL,
	[jytcode] [int] NOT NULL,
	[jymoney] [float] NOT NULL,
	[jydate] [datetime] NOT NULL,
 CONSTRAINT [PK_YJLog] PRIMARY KEY CLUSTERED 
(
	[jycode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Default [DF_CardInfo_opendate]    Script Date: 03/23/2013 18:40:49 ******/
ALTER TABLE [dbo].[CardInfo] ADD  CONSTRAINT [DF_CardInfo_opendate]  DEFAULT (getdate()) FOR [opendate]
GO
/****** Object:  Default [DF_YJLog_jydate]    Script Date: 03/23/2013 18:40:49 ******/
ALTER TABLE [dbo].[YJLog] ADD  CONSTRAINT [DF_YJLog_jydate]  DEFAULT (getdate()) FOR [jydate]
GO
/****** Object:  Check [CK_CardInfo]    Script Date: 03/23/2013 18:40:49 ******/
ALTER TABLE [dbo].[CardInfo]  WITH CHECK ADD  CONSTRAINT [CK_CardInfo] CHECK  (([cardyu]>(1)))
GO
ALTER TABLE [dbo].[CardInfo] CHECK CONSTRAINT [CK_CardInfo]
GO
/****** Object:  ForeignKey [FK_CardInfo_Users]    Script Date: 03/23/2013 18:40:49 ******/
ALTER TABLE [dbo].[CardInfo]  WITH CHECK ADD  CONSTRAINT [FK_CardInfo_Users] FOREIGN KEY([uid])
REFERENCES [dbo].[Users] ([uid])
GO
ALTER TABLE [dbo].[CardInfo] CHECK CONSTRAINT [FK_CardInfo_Users]
GO
/****** Object:  ForeignKey [FK_YJLog_CardInfo]    Script Date: 03/23/2013 18:40:49 ******/
ALTER TABLE [dbo].[YJLog]  WITH CHECK ADD  CONSTRAINT [FK_YJLog_CardInfo] FOREIGN KEY([cardid])
REFERENCES [dbo].[CardInfo] ([cardid])
GO
ALTER TABLE [dbo].[YJLog] CHECK CONSTRAINT [FK_YJLog_CardInfo]
GO
/****** Object:  ForeignKey [FK_YJLog_JYType]    Script Date: 03/23/2013 18:40:49 ******/
ALTER TABLE [dbo].[YJLog]  WITH CHECK ADD  CONSTRAINT [FK_YJLog_JYType] FOREIGN KEY([jytcode])
REFERENCES [dbo].[JYType] ([jytcode])
GO
ALTER TABLE [dbo].[YJLog] CHECK CONSTRAINT [FK_YJLog_JYType]
GO
