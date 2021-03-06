USE [ducat_data]
GO
/****** Object:  Table [dbo].[Ads]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Ads](
	[AdId] [int] IDENTITY(1,1) NOT NULL,
	[ImagePath] [varchar](200) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[DateCreated] [datetime] NULL CONSTRAINT [DF_Ads_DateCreated]  DEFAULT (getdate())
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Areas]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Areas](
	[AreaId] [int] NOT NULL,
	[AreaName] [varchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[AreaNameEN] [varchar](20) COLLATE Chinese_PRC_CI_AS NULL,
 CONSTRAINT [PK_Areas] PRIMARY KEY CLUSTERED 
(
	[AreaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cash]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cash](
	[CashId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[CashMoney] [int] NOT NULL,
	[DateCreated] [datetime] NULL CONSTRAINT [DF_Cash_DateCreated]  DEFAULT (getdate()),
	[IsPayed] [bit] NULL CONSTRAINT [DF_Cash_IsPayed]  DEFAULT ((0)),
	[DatePayed] [datetime] NULL CONSTRAINT [DF_Cash_DatePayed]  DEFAULT (getdate()),
 CONSTRAINT [PK_Cash] PRIMARY KEY CLUSTERED 
(
	[CashId] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Operators]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Operators](
	[OperatorId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](30) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[Mobile] [char](15) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[Password] [char](32) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[RoleId] [int] NOT NULL CONSTRAINT [DF_Users_Role]  DEFAULT ((0)),
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_Users_CreateDate]  DEFAULT (getdate()),
	[LoginDate] [datetime] NOT NULL CONSTRAINT [DF_Users_LoginDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[OperatorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[RegId] [int] NOT NULL,
	[UPId] [int] NOT NULL,
	[BaseMoney] [int] NOT NULL,
	[GovMoney] [int] NOT NULL CONSTRAINT [DF_Orders_GovMoney]  DEFAULT ((0)),
	[SpcMoney] [int] NOT NULL CONSTRAINT [DF_Orders_SpcMoney]  DEFAULT ((0)),
	[OrderDisMoney] [int] NOT NULL CONSTRAINT [DF_Orders_DisMoney]  DEFAULT ((0)),
	[OrderShareMoney] [int] NOT NULL CONSTRAINT [DF_Orders_ShareMoney]  DEFAULT ((0)),
	[IsPayed] [bit] NOT NULL CONSTRAINT [DF_Orders_IsPayed]  DEFAULT ((0)),
	[DateCreated] [datetime] NOT NULL CONSTRAINT [DF_Orders_DateCreated]  DEFAULT (getdate()),
	[DatePayed] [datetime] NOT NULL CONSTRAINT [DF_Orders_DatePayed]  DEFAULT (getdate()),
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderId] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Policies]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Policies](
	[PolicyId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](60) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[Comment] [nvarchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[LimitCountPerUser] [int] NOT NULL CONSTRAINT [DF_Policies_LimitCountPerUser]  DEFAULT ((0)),
	[LimitMinPrice] [int] NULL CONSTRAINT [DF_Policies_LimitMinPrice]  DEFAULT ((0)),
	[LimitNewUser] [bit] NOT NULL CONSTRAINT [DF_Policies_LimitNewUser]  DEFAULT ((0)),
	[LimitOldUser] [bit] NOT NULL CONSTRAINT [DF_Policies_LimitOldUser]  DEFAULT ((0)),
	[IsDisPercent] [bit] NOT NULL CONSTRAINT [DF_Table_1_IsPercent]  DEFAULT ((0)),
	[DisMoney] [int] NOT NULL,
	[IsSharePercent] [bit] NOT NULL CONSTRAINT [DF_Policies_IsSharePercent]  DEFAULT ((0)),
	[ShareMoney] [int] NOT NULL,
	[AreaIds] [varchar](150) COLLATE Chinese_PRC_CI_AS NULL,
	[RefCount] [int] NOT NULL CONSTRAINT [DF_Policies_ReferCount]  DEFAULT ((0)),
	[GenCount] [int] NOT NULL CONSTRAINT [DF_Policies_GenCount]  DEFAULT ((0)),
	[RegCount] [int] NOT NULL,
	[PayCount] [int] NOT NULL CONSTRAINT [DF_Policies_PayCount]  DEFAULT ((0)),
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[IsOffline] [bit] NOT NULL CONSTRAINT [DF_Policies_IsOffline]  DEFAULT ((0)),
 CONSTRAINT [PK_Policies] PRIMARY KEY CLUSTERED 
(
	[PolicyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nchar](30) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[AuthValue] [int] NOT NULL CONSTRAINT [DF_Roles_AuthValue]  DEFAULT ((0)),
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Sessions]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sessions](
	[SessionId] [uniqueidentifier] NOT NULL,
	[WechatSessionKey] [varchar](50) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[WechatOpenId] [char](32) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateExpired] [datetime] NOT NULL,
	[DateLastActived] [datetime] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Solutions]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Solutions](
	[SolutionId] [int] NOT NULL,
	[AreaId] [int] NOT NULL,
	[BasePrice] [int] NOT NULL CONSTRAINT [DF_Solutions_BasePrice]  DEFAULT ((0)),
	[GovPrice] [int] NOT NULL CONSTRAINT [DF_Solutions_GovPrice]  DEFAULT ((0)),
	[SpcPrice] [int] NOT NULL CONSTRAINT [DF_Solutions_SpcPrice]  DEFAULT ((0)),
	[Days] [int] NOT NULL CONSTRAINT [DF_Solutions_Days]  DEFAULT ((0)),
	[SpcDays] [int] NOT NULL CONSTRAINT [DF_Solutions_SpcDays]  DEFAULT ((0)),
 CONSTRAINT [PK_Solutions] PRIMARY KEY CLUSTERED 
(
	[SolutionId] ASC,
	[AreaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserPolicies]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserPolicies](
	[UPId] [int] IDENTITY(1,1) NOT NULL,
	[PolicyId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[CheckCode] [char](10) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[PayCount] [int] NOT NULL CONSTRAINT [DF_UserPolicies_PayCount]  DEFAULT ((0)),
	[DateCreated] [datetime] NOT NULL CONSTRAINT [DF_UserPolicies_DateCreated]  DEFAULT (getdate()),
 CONSTRAINT [PK_UserPolicies] PRIMARY KEY CLUSTERED 
(
	[UPId] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserRegs]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserRegs](
	[RegId] [int] IDENTITY(1,1) NOT NULL,
	[USId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[LinkmanName] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[LinkmanTel] [varchar](50) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[LinkmanEmail] [varchar](50) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[LinkmanAddr] [nvarchar](200) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[LinkmanWechat] [varchar](50) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[CompName1] [nvarchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[CompName2] [nvarchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[CompName3] [nvarchar](100) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[CompRegAddr] [nvarchar](200) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[CompProp] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[StockCount] [int] NULL CONSTRAINT [DF_UserRegs_StockCount]  DEFAULT ((0)),
	[StockHolder] [nvarchar](600) COLLATE Chinese_PRC_CI_AS NULL,
	[CEOName] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[CFOName] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[Secretor] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[SignFile] [varchar](200) COLLATE Chinese_PRC_CI_AS NULL,
	[DateCreated] [datetime] NULL CONSTRAINT [DF_UserRegs_DateCreated]  DEFAULT (getdate()),
	[IsPayed] [bit] NULL CONSTRAINT [DF_UserRegs_IsPayed]  DEFAULT ((0)),
	[UserPolicyId] [int] NULL CONSTRAINT [DF_UserRegs_PolicyId]  DEFAULT ((0)),
	[DatePayed] [datetime] NULL CONSTRAINT [DF_UserRegs_DatePayed]  DEFAULT (getdate()),
 CONSTRAINT [PK_UserRegs] PRIMARY KEY CLUSTERED 
(
	[RegId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Users]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[OpenId] [char](32) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[Nick] [nchar](50) COLLATE Chinese_PRC_CI_AS NULL,
	[OrderCount] [int] NOT NULL CONSTRAINT [DF_Users_OrderCount]  DEFAULT ((0)),
	[UserPoliciesCount] [int] NOT NULL CONSTRAINT [DF_Users_UserPoliciesCount]  DEFAULT ((0)),
	[PayedPoliciesCount] [int] NOT NULL CONSTRAINT [DF_Users_PayedPoliciesCount]  DEFAULT ((0)),
	[WechatId] [varchar](60) COLLATE Chinese_PRC_CI_AS NULL,
	[Mobile] [varchar](30) COLLATE Chinese_PRC_CI_AS NULL,
	[DateCreated] [datetime] NOT NULL CONSTRAINT [DF_Users_DateCreated]  DEFAULT (getdate()),
	[DateLastActived] [datetime] NOT NULL CONSTRAINT [DF_Users_DateLastActived]  DEFAULT (getdate()),
 CONSTRAINT [PK_Users_1] PRIMARY KEY CLUSTERED 
(
	[UserId] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserSolutions]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserSolutions](
	[USId] [int] IDENTITY(1,1) NOT NULL,
	[AreaId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[SolutionId] [int] NOT NULL,
	[IsSpc] [bit] NOT NULL CONSTRAINT [DF_UserSolutions_IsSpc]  DEFAULT ((0)),
	[DateCreated] [datetime] NULL CONSTRAINT [DF_UserSolutions_DateCreated]  DEFAULT (getdate()),
 CONSTRAINT [PK_UserSolutions] PRIMARY KEY CLUSTERED 
(
	[USId] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Ads] ON 

INSERT [dbo].[Ads] ([AdId], [ImagePath], [DateCreated]) VALUES (11, N'048707adc0284bc1ae802376799f3fef.jpg', CAST(N'2017-11-28 13:46:13.067' AS DateTime))
INSERT [dbo].[Ads] ([AdId], [ImagePath], [DateCreated]) VALUES (13, N'8abb37a926db47a48595d0feabbd8421.jpg', CAST(N'2017-11-28 13:59:27.673' AS DateTime))
SET IDENTITY_INSERT [dbo].[Ads] OFF
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (0, N'阿拉巴马州', N'Alabama')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (1, N'阿拉斯加州', N'Alaska')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (2, N'阿肯色州', N'Arkansas')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (3, N'亚利桑那州', N'Arizona')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (4, N'科罗拉多州', N'Colorado')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (5, N'加利福尼亚州', N'California
')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (6, N'康涅狄格州 ', N'Connecticut')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (7, N'特拉华州 ', N'Delaware')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (8, N'佛罗里达州 ', N'Florida')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (9, N'佐治亚州 ', N'Georgia')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (10, N'夏威夷州 ', N'Hawaii')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (11, N'爱达荷州 ', N'Idaho')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (12, N'伊利诺州 ', N'Illinois')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (13, N'印弟安纳州 ', N'Indiana')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (14, N'爱荷华州 ', N'Iowa')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (15, N'堪萨斯州 ', N'Kansas')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (16, N'肯塔基州 ', N'Kentucky')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (17, N'路易斯安那州 ', N'Louisiana')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (18, N'缅因州 ', N'Maine')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (19, N'马里兰州 ', N'Maryland')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (20, N'麻塞诸塞州 ', N'Massachusetts')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (21, N'密歇根州 ', N'Michigan')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (22, N'明尼苏达州 ', N'Minnesota')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (23, N'密西西比州 ', N'Mississippi')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (24, N'密苏里州 ', N'Missour')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (25, N'蒙大拿州 ', N'Montana')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (26, N'内布拉斯加州 ', N'Nebraska')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (27, N'内华达州 ', N'Nevada')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (28, N'新罕布希尔州 ', N'New Hampshire')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (29, N'新泽西州 ', N'New Jersey')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (30, N'新墨西哥州', N'New Mexico')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (31, N'纽约州 ', N'New York')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (32, N'北卡罗来纳州 ', N'North Carolina')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (33, N'北达科他州', N' North Dakota')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (34, N'俄亥俄州 ', N'Ohio')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (35, N'奥克拉荷马州 ', N'Oklahoma')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (36, N'俄勒冈州 ', N'Oregon')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (37, N'宾西法尼亚州', N' Pennsyivania')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (38, N'罗德岛州 ', N'Rhode Island')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (39, N'南卡罗来纳州', N' South Carolina')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (40, N'南达科他州', N' South Dakota')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (41, N'田纳西州 ', N'Tennessee')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (42, N'德克萨斯州 ', N'Texas')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (43, N'犹他州 ', N'Utah')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (44, N'佛蒙特州 ', N'Vermont')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (45, N'弗吉尼亚州 ', N'Virgina')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (46, N'华盛顿州 ', N'Washington')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (47, N'西佛吉尼亚州 ', N'West Virginia')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (48, N'威斯康辛州 ', N'Wisconsin')
INSERT [dbo].[Areas] ([AreaId], [AreaName], [AreaNameEN]) VALUES (49, N'怀俄明州', N' Wyoming')
SET IDENTITY_INSERT [dbo].[Cash] ON 

INSERT [dbo].[Cash] ([CashId], [UserId], [CashMoney], [DateCreated], [IsPayed], [DatePayed]) VALUES (5, 2, 10, CAST(N'2017-12-07 22:16:40.487' AS DateTime), 0, CAST(N'2017-12-07 22:16:40.487' AS DateTime))
SET IDENTITY_INSERT [dbo].[Cash] OFF
SET IDENTITY_INSERT [dbo].[Operators] ON 

INSERT [dbo].[Operators] ([OperatorId], [Name], [Mobile], [Password], [RoleId], [CreateDate], [LoginDate]) VALUES (2, N'root', N'13811290288    ', N'25D55AD283AA400AF464C76D713C07AD', 6, CAST(N'2016-05-03 00:21:44.907' AS DateTime), CAST(N'2017-12-08 11:44:50.893' AS DateTime))
INSERT [dbo].[Operators] ([OperatorId], [Name], [Mobile], [Password], [RoleId], [CreateDate], [LoginDate]) VALUES (6, N'超级管理员', N'13800138000    ', N'25D55AD283AA400AF464C76D713C07AD', 1, CAST(N'2017-12-08 11:45:55.393' AS DateTime), CAST(N'2017-12-08 15:07:08.533' AS DateTime))
SET IDENTITY_INSERT [dbo].[Operators] OFF
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderId], [UserId], [RegId], [UPId], [BaseMoney], [GovMoney], [SpcMoney], [OrderDisMoney], [OrderShareMoney], [IsPayed], [DateCreated], [DatePayed]) VALUES (46, 3, 69, 0, 8, 8, 0, 0, 0, 1, CAST(N'2017-12-08 11:47:01.660' AS DateTime), CAST(N'2017-12-08 11:47:18.127' AS DateTime))
INSERT [dbo].[Orders] ([OrderId], [UserId], [RegId], [UPId], [BaseMoney], [GovMoney], [SpcMoney], [OrderDisMoney], [OrderShareMoney], [IsPayed], [DateCreated], [DatePayed]) VALUES (45, 2, 68, 0, 8, 8, 8, 0, 0, 0, CAST(N'2017-12-08 11:43:51.550' AS DateTime), CAST(N'2017-12-08 11:43:51.550' AS DateTime))
INSERT [dbo].[Orders] ([OrderId], [UserId], [RegId], [UPId], [BaseMoney], [GovMoney], [SpcMoney], [OrderDisMoney], [OrderShareMoney], [IsPayed], [DateCreated], [DatePayed]) VALUES (42, 2, 66, 6, 11, 12, 13, 3, 5, 1, CAST(N'2017-12-07 22:09:29.737' AS DateTime), CAST(N'2017-12-07 22:09:34.783' AS DateTime))
INSERT [dbo].[Orders] ([OrderId], [UserId], [RegId], [UPId], [BaseMoney], [GovMoney], [SpcMoney], [OrderDisMoney], [OrderShareMoney], [IsPayed], [DateCreated], [DatePayed]) VALUES (41, 2, 65, 6, 8, 8, 8, 2, 5, 1, CAST(N'2017-12-07 21:49:47.173' AS DateTime), CAST(N'2017-12-07 21:49:53.627' AS DateTime))
INSERT [dbo].[Orders] ([OrderId], [UserId], [RegId], [UPId], [BaseMoney], [GovMoney], [SpcMoney], [OrderDisMoney], [OrderShareMoney], [IsPayed], [DateCreated], [DatePayed]) VALUES (40, 2, 64, 0, 11, 12, 13, 0, 0, 1, CAST(N'2017-12-07 21:38:32.487' AS DateTime), CAST(N'2017-12-07 21:38:37.360' AS DateTime))
INSERT [dbo].[Orders] ([OrderId], [UserId], [RegId], [UPId], [BaseMoney], [GovMoney], [SpcMoney], [OrderDisMoney], [OrderShareMoney], [IsPayed], [DateCreated], [DatePayed]) VALUES (39, 2, 64, 0, 11, 12, 13, 0, 0, 0, CAST(N'2017-12-07 21:34:58.283' AS DateTime), CAST(N'2017-12-07 21:34:58.283' AS DateTime))
INSERT [dbo].[Orders] ([OrderId], [UserId], [RegId], [UPId], [BaseMoney], [GovMoney], [SpcMoney], [OrderDisMoney], [OrderShareMoney], [IsPayed], [DateCreated], [DatePayed]) VALUES (38, 2, 64, 0, 11, 12, 13, 0, 0, 0, CAST(N'2017-12-07 21:34:44.643' AS DateTime), CAST(N'2017-12-07 21:34:44.643' AS DateTime))
SET IDENTITY_INSERT [dbo].[Orders] OFF
SET IDENTITY_INSERT [dbo].[Policies] ON 

INSERT [dbo].[Policies] ([PolicyId], [Title], [Comment], [LimitCountPerUser], [LimitMinPrice], [LimitNewUser], [LimitOldUser], [IsDisPercent], [DisMoney], [IsSharePercent], [ShareMoney], [AreaIds], [RefCount], [GenCount], [RegCount], [PayCount], [StartTime], [EndTime], [IsOffline]) VALUES (13, N'2018年双12的特价优惠', N'特价优惠', 5, 0, 0, 0, 1, 10, 0, 5, N'0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49', 0, 1, 0, 2, CAST(N'2017-12-07 00:00:00.000' AS DateTime), CAST(N'2017-12-18 00:00:00.000' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Policies] OFF
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RoleId], [RoleName], [AuthValue]) VALUES (1, N'超级管理                          ', 510)
INSERT [dbo].[Roles] ([RoleId], [RoleName], [AuthValue]) VALUES (6, N'订单管理组                         ', 56)
SET IDENTITY_INSERT [dbo].[Roles] OFF
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'b2304f90-d9fa-4772-891d-89c11f6b4cf0', N'ExMPXtGx5hIopeCzIsJYjw==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 10:54:55.130' AS DateTime), CAST(N'2017-12-08 12:54:55.130' AS DateTime), CAST(N'2017-12-08 10:54:55.130' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'2b2a8cc2-1848-4ae9-ae92-cc279c4f27b9', N'ExMPXtGx5hIopeCzIsJYjw==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 10:55:18.100' AS DateTime), CAST(N'2017-12-08 12:55:18.100' AS DateTime), CAST(N'2017-12-08 10:55:18.100' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'd91f3f12-7e95-47b2-8e0a-1cdbbaf47d02', N'bWjxmy9waeaiTtRXvqvzsg==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 10:58:38.707' AS DateTime), CAST(N'2017-12-08 12:58:38.707' AS DateTime), CAST(N'2017-12-08 10:58:38.707' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'f9e8265b-f379-499d-9799-b9a17e12b136', N'0lBrN0ftOhRLn5HYannd6w==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 11:03:58.317' AS DateTime), CAST(N'2017-12-08 13:03:58.317' AS DateTime), CAST(N'2017-12-08 11:03:58.317' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'778e83c5-7cb3-4c24-8a4f-8ba5dae75497', N'0lBrN0ftOhRLn5HYannd6w==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 11:04:16.880' AS DateTime), CAST(N'2017-12-08 13:04:16.880' AS DateTime), CAST(N'2017-12-08 11:04:16.880' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'ff6a16e5-df2b-4f54-b5ab-db83cb9888e4', N'0lBrN0ftOhRLn5HYannd6w==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 11:04:25.363' AS DateTime), CAST(N'2017-12-08 13:04:25.363' AS DateTime), CAST(N'2017-12-08 11:04:25.363' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'dc81183b-dff6-4b98-982f-2970e5ba1e7d', N'iBjYK7hkmRCgAK2YQP0r0g==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 11:07:35.880' AS DateTime), CAST(N'2017-12-08 13:07:35.880' AS DateTime), CAST(N'2017-12-08 11:07:35.880' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'8943af0d-3e71-405e-af68-3512d9043f46', N'iBjYK7hkmRCgAK2YQP0r0g==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 11:08:06.253' AS DateTime), CAST(N'2017-12-08 13:08:06.253' AS DateTime), CAST(N'2017-12-08 11:08:06.253' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'a01c9f38-ed7f-4679-b266-6c62914ba30b', N'iBjYK7hkmRCgAK2YQP0r0g==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 11:08:10.380' AS DateTime), CAST(N'2017-12-08 13:08:10.380' AS DateTime), CAST(N'2017-12-08 11:08:10.380' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'232c973b-7d54-439f-9156-8191c23d6289', N'iBjYK7hkmRCgAK2YQP0r0g==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 11:08:45.223' AS DateTime), CAST(N'2017-12-08 13:08:45.223' AS DateTime), CAST(N'2017-12-08 11:08:45.223' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'8a87593b-d34b-46f3-9edb-32b6d0c84b40', N'iBjYK7hkmRCgAK2YQP0r0g==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 11:09:21.990' AS DateTime), CAST(N'2017-12-08 13:09:21.990' AS DateTime), CAST(N'2017-12-08 11:09:21.990' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'63467f7c-1694-49e1-a2ee-8d1d9c22aa69', N'OtYCRxBY3dUjM80lkwk0Iw==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 11:09:52.457' AS DateTime), CAST(N'2017-12-08 13:09:52.457' AS DateTime), CAST(N'2017-12-08 11:09:52.457' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'03dc7461-1d36-4eee-be50-beac407a9b07', N'OtYCRxBY3dUjM80lkwk0Iw==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 11:10:29.927' AS DateTime), CAST(N'2017-12-08 13:10:29.927' AS DateTime), CAST(N'2017-12-08 11:10:29.927' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'bc04aac7-e91a-4b92-8645-3ff666de6aa5', N'DrJ8/yz7jlzIfscunxfffw==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 11:12:40.100' AS DateTime), CAST(N'2017-12-08 13:12:40.100' AS DateTime), CAST(N'2017-12-08 11:12:40.100' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'a311a0c3-120b-4374-8ae8-c02eba395b40', N'DrJ8/yz7jlzIfscunxfffw==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 11:13:19.583' AS DateTime), CAST(N'2017-12-08 13:13:19.583' AS DateTime), CAST(N'2017-12-08 11:13:19.583' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'9c5a9b9a-f803-488a-b623-385f3cd6f33b', N'DrJ8/yz7jlzIfscunxfffw==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 11:13:46.397' AS DateTime), CAST(N'2017-12-08 13:13:46.397' AS DateTime), CAST(N'2017-12-08 11:13:46.397' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'7d55dbcd-a611-401b-a425-79d1c71543d1', N'DrJ8/yz7jlzIfscunxfffw==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 11:14:12.317' AS DateTime), CAST(N'2017-12-08 13:14:12.317' AS DateTime), CAST(N'2017-12-08 11:14:12.317' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'2a7ff330-1fea-4ccc-a401-eb76d6721d21', N'i0rA7+2qZ4cpwHCHUxzSnQ==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 11:14:48.240' AS DateTime), CAST(N'2017-12-08 13:14:48.240' AS DateTime), CAST(N'2017-12-08 11:14:48.240' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'd91f56d0-5490-4495-81e5-e804f38e977f', N'i0rA7+2qZ4cpwHCHUxzSnQ==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 11:15:25.350' AS DateTime), CAST(N'2017-12-08 13:15:25.350' AS DateTime), CAST(N'2017-12-08 11:15:25.350' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'5eff64b0-1e9c-4285-a8a4-b21fe1da0ed8', N'aDQHA4mZ/3c6LTkiVtExtQ==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 11:17:40.020' AS DateTime), CAST(N'2017-12-08 13:17:40.020' AS DateTime), CAST(N'2017-12-08 11:17:40.020' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'b1b733c1-4d87-40c7-9689-dad9cfa4dded', N'aDQHA4mZ/3c6LTkiVtExtQ==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 11:18:04.567' AS DateTime), CAST(N'2017-12-08 13:18:04.567' AS DateTime), CAST(N'2017-12-08 11:18:04.567' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'2728365e-4abc-42e5-be17-e8cf9e2be06c', N'aDQHA4mZ/3c6LTkiVtExtQ==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 11:18:19.677' AS DateTime), CAST(N'2017-12-08 13:18:19.677' AS DateTime), CAST(N'2017-12-08 11:18:19.677' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'73537184-a39d-4b93-9b35-3c270e12722a', N'aDQHA4mZ/3c6LTkiVtExtQ==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 11:18:24.240' AS DateTime), CAST(N'2017-12-08 13:18:24.240' AS DateTime), CAST(N'2017-12-08 11:18:24.240' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'1bb87f0a-8452-47e9-88f8-c274766ec0e5', N'aDQHA4mZ/3c6LTkiVtExtQ==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 11:19:09.833' AS DateTime), CAST(N'2017-12-08 13:19:09.833' AS DateTime), CAST(N'2017-12-08 11:19:09.833' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'7eb0ed05-5f12-4dfa-b1f6-f92825a0f789', N'UeH561WbhmwnEu8yjay4uw==', N'oIg0D0cg9Y10fgoUSM-NNWRA8YkI    ', CAST(N'2017-12-08 11:20:04.473' AS DateTime), CAST(N'2017-12-08 13:20:04.473' AS DateTime), CAST(N'2017-12-08 11:20:04.473' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'd17e2841-b15a-40a9-8e77-1b6a279d6bdc', N'k2hoapKISFMNbfep3W75jw==', N'oIg0D0VzTk6RfHeV-sPcT5HBLOW4    ', CAST(N'2017-12-08 11:20:05.207' AS DateTime), CAST(N'2017-12-08 13:20:05.207' AS DateTime), CAST(N'2017-12-08 11:20:05.207' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'0162be98-f069-41ae-8a3b-b4258cbb4ad2', N'FtG4RMoMMRaoxHAYSRzHTA==', N'oIg0D0R7FeIrEqq_AoOjYw8Sfucw    ', CAST(N'2017-12-08 11:20:07.020' AS DateTime), CAST(N'2017-12-08 13:20:07.020' AS DateTime), CAST(N'2017-12-08 11:20:07.020' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'7d9dca43-cf8f-46c8-9ce7-dbd0e9faafe4', N'+oBQU7cm7jnrkBCYCJIf5g==', N'oIg0D0d3l6IkUpSnwBiphUepEr_o    ', CAST(N'2017-12-08 11:20:10.067' AS DateTime), CAST(N'2017-12-08 13:20:10.067' AS DateTime), CAST(N'2017-12-08 11:20:10.067' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'33d98c01-2177-4478-bd65-9f45d6680085', N'47hdJw3BBeqVz2thbPEDaA==', N'oIg0D0UTO6TcBfHK8TjsFQY6mN2s    ', CAST(N'2017-12-08 11:20:10.363' AS DateTime), CAST(N'2017-12-08 13:20:10.363' AS DateTime), CAST(N'2017-12-08 11:20:10.363' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'00bc9d8d-fd1b-4884-9522-7b3c31d0da3f', N'XnRwUFt1ONqoUyu71tcSfA==', N'oIg0D0Xo0QeireNVTe9AREF9k6nY    ', CAST(N'2017-12-08 11:20:10.583' AS DateTime), CAST(N'2017-12-08 13:20:10.583' AS DateTime), CAST(N'2017-12-08 11:20:10.583' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'24fa860d-cc0d-486f-99cc-01eb5dd86d18', N'mS798coffYVb5fapjKXqRg==', N'oIg0D0S9Ftp9OBOuRM3YBt6uWSm0    ', CAST(N'2017-12-08 11:20:11.693' AS DateTime), CAST(N'2017-12-08 13:20:11.693' AS DateTime), CAST(N'2017-12-08 11:20:11.693' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'739ca77a-6c36-42eb-8003-1a7772997d30', N'qpLf5JB/eg8BAg0yK+fzHA==', N'oIg0D0aGfRd9gGUCFW28bWxDGWyQ    ', CAST(N'2017-12-08 11:20:12.677' AS DateTime), CAST(N'2017-12-08 13:20:12.677' AS DateTime), CAST(N'2017-12-08 11:20:12.677' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'bb1df635-7ffc-4d42-8e25-15c4e59892b9', N'Jdwyr8MzBK1Cpgxqlr9MLg==', N'oIg0D0eLVByLnE3sgTW74nuuXc_Y    ', CAST(N'2017-12-08 11:20:15.270' AS DateTime), CAST(N'2017-12-08 13:20:15.270' AS DateTime), CAST(N'2017-12-08 11:20:15.270' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'c1495bd6-4c9c-43aa-bf64-a84a491a6129', N'mbXVBoImCYx78xzdcBzUog==', N'oIg0D0SmEANT7Hl81nEADXu9NWYs    ', CAST(N'2017-12-08 11:20:15.647' AS DateTime), CAST(N'2017-12-08 13:20:15.647' AS DateTime), CAST(N'2017-12-08 11:20:15.647' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'3d2cbdba-7bc4-479e-92ec-78126037b526', N'wjF83mm7M/7/kme1NxsHaA==', N'oIg0D0Tsp24n6udWgI4ud7zuR83A    ', CAST(N'2017-12-08 11:20:17.897' AS DateTime), CAST(N'2017-12-08 13:20:17.897' AS DateTime), CAST(N'2017-12-08 11:20:17.897' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'4b8bfcb0-5723-453d-83b6-61b31f7a39ba', N'BQUpZlIESjWNylFFzSnbQw==', N'oIg0D0W6Z5TUMwVOy8xQ9ygf35og    ', CAST(N'2017-12-08 11:20:19.520' AS DateTime), CAST(N'2017-12-08 13:20:19.520' AS DateTime), CAST(N'2017-12-08 11:20:19.520' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'7e84ec27-c795-4e93-88f1-cb8ac0974e37', N'pyV3zz9pF/QxCWZORGxgfg==', N'oIg0D0Sc5rFKvHN89x-qNOZO4CKM    ', CAST(N'2017-12-08 11:20:20.630' AS DateTime), CAST(N'2017-12-08 13:20:20.630' AS DateTime), CAST(N'2017-12-08 11:20:20.630' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'79f69ff6-9b55-4409-8346-7c71261bba01', N'NhKemtbw4Yig6rhEDtAb4w==', N'oIg0D0aAfy-Mmtjscr1kry8nrUwM    ', CAST(N'2017-12-08 11:20:21.850' AS DateTime), CAST(N'2017-12-08 13:20:21.850' AS DateTime), CAST(N'2017-12-08 11:20:21.850' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'c5a2af8d-1e9f-40d5-b123-bf9d2085b7f4', N'm2jONPC7Bk+1kN16vUxxTA==', N'oIg0D0VXgZJfepuv1uPXVMnqpgRc    ', CAST(N'2017-12-08 11:20:30.647' AS DateTime), CAST(N'2017-12-08 13:20:30.647' AS DateTime), CAST(N'2017-12-08 11:20:30.647' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'969436bb-87d8-4561-bddd-a442e399375f', N'b15B60LLhHmpaaqlWnjx0w==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 11:22:19.443' AS DateTime), CAST(N'2017-12-08 13:22:19.443' AS DateTime), CAST(N'2017-12-08 11:22:19.443' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'96212aba-b962-48dc-b098-f9a29f8b1aca', N'vmyYAcOotGjR9x+tbuI1Eg==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 11:24:35.647' AS DateTime), CAST(N'2017-12-08 13:24:35.647' AS DateTime), CAST(N'2017-12-08 11:24:35.647' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'768f56b6-dd43-4254-b0c9-93e9279b2272', N'vmyYAcOotGjR9x+tbuI1Eg==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 11:24:40.083' AS DateTime), CAST(N'2017-12-08 13:24:40.083' AS DateTime), CAST(N'2017-12-08 11:24:40.083' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'e9ddaf0e-524d-4443-a7b9-b9ea7aef4ed9', N'vmyYAcOotGjR9x+tbuI1Eg==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 11:25:24.287' AS DateTime), CAST(N'2017-12-08 13:25:24.287' AS DateTime), CAST(N'2017-12-08 11:25:24.287' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'80221e07-fe5b-4ac6-a599-cc6a5870ec94', N'5fcTixYf3JfuMRge+hZmAg==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 11:30:38.973' AS DateTime), CAST(N'2017-12-08 13:30:38.973' AS DateTime), CAST(N'2017-12-08 11:30:38.973' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'd41a7a83-4f6d-4780-be46-84bd17360fb2', N'5fcTixYf3JfuMRge+hZmAg==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 11:30:52.723' AS DateTime), CAST(N'2017-12-08 13:30:52.723' AS DateTime), CAST(N'2017-12-08 11:30:52.723' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'0741e566-eb71-4a43-87ca-0f813ff8524a', N'2s37Vswhk3C7M/QuVbL6+w==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 11:33:24.647' AS DateTime), CAST(N'2017-12-08 13:33:24.647' AS DateTime), CAST(N'2017-12-08 11:33:24.647' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'2d32f102-7cbc-44cc-8e70-a71b31a8b16b', N'2s37Vswhk3C7M/QuVbL6+w==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 11:33:44.300' AS DateTime), CAST(N'2017-12-08 13:33:44.300' AS DateTime), CAST(N'2017-12-08 11:33:44.300' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'd12c1777-6d7b-4659-a7d0-d6871777857c', N'2s37Vswhk3C7M/QuVbL6+w==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 11:34:07.223' AS DateTime), CAST(N'2017-12-08 13:34:07.223' AS DateTime), CAST(N'2017-12-08 11:34:07.223' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'90b2c304-cdac-43c0-a0a1-f355de5b4ed9', N'Zi3oQNHY2vRaxUOtbZzHGA==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 11:37:20.130' AS DateTime), CAST(N'2017-12-08 13:37:20.130' AS DateTime), CAST(N'2017-12-08 11:37:20.130' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'2bd33359-8015-46a7-8bd2-94962e722d06', N'zp8FMd1wmlMx3IpIBiosfA==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 11:43:08.973' AS DateTime), CAST(N'2017-12-08 13:43:08.973' AS DateTime), CAST(N'2017-12-08 11:43:08.973' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'57bd4ff6-dea6-466c-9573-365162191d6c', N'azrddaqmxsDqPT/wn5LA5A==', N'oIg0D0Y6QJWEBjZ_bNKdE2TU2HrQ    ', CAST(N'2017-12-08 11:43:59.253' AS DateTime), CAST(N'2017-12-08 13:43:59.253' AS DateTime), CAST(N'2017-12-08 11:43:59.253' AS DateTime))
INSERT [dbo].[Sessions] ([SessionId], [WechatSessionKey], [WechatOpenId], [DateCreated], [DateExpired], [DateLastActived]) VALUES (N'6e086215-cabc-4a26-baa3-d5b5d5c9c28a', N'EQLa3svOJv8T8kK+ohEqNA==', N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', CAST(N'2017-12-08 12:26:14.067' AS DateTime), CAST(N'2017-12-08 14:26:14.067' AS DateTime), CAST(N'2017-12-08 12:26:14.067' AS DateTime))
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 0, 1, 2, 3, 4, 5)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 1, 1, 2, 3, 4, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 2, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 3, 1, 2, 3, 4, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 4, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 5, 1, 2, 3, 4, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 6, 1, 2, 3, 4, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 7, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 8, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 9, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 10, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 11, 1, 2, 3, 4, 5)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 12, 1, 2, 3, 4, 5)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 13, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 14, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 15, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 16, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 17, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 18, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 19, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 20, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 21, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 22, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 23, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 24, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 25, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 26, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 27, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 28, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 29, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 30, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 31, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 32, 1, 2, 3, 4, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 33, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 34, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 35, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 36, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 37, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 38, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 39, 1, 2, 3, 4, 5)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 40, 1, 2, 3, 4, 5)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 41, 1, 2, 3, 4, 5)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 42, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 43, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 44, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 45, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 46, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 47, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 48, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (0, 49, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 0, 6, 7, 8, 9, 10)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 1, 5, 6, 7, 8, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 2, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 3, 5, 6, 7, 8, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 4, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 5, 5, 6, 7, 8, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 6, 5, 6, 7, 8, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 7, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 8, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 9, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 10, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 11, 6, 7, 8, 9, 10)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 12, 6, 7, 8, 9, 10)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 13, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 14, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 15, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 16, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 17, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 18, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 19, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 20, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 21, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 22, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 23, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 24, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 25, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 26, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 27, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 28, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 29, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 30, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 31, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 32, 5, 6, 7, 8, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 33, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 34, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 35, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 36, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 37, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 38, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 39, 6, 7, 8, 9, 10)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 40, 6, 7, 8, 9, 10)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 41, 6, 7, 8, 9, 10)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 42, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 43, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 44, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 45, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 46, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 47, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 48, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (1, 49, 0, 0, 0, 0, 0)
GO
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 0, 11, 12, 13, 14, 15)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 1, 9, 10, 11, 12, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 2, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 3, 9, 10, 11, 12, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 4, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 5, 9, 10, 11, 12, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 6, 9, 10, 11, 12, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 7, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 8, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 9, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 10, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 11, 11, 12, 13, 14, 15)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 12, 11, 12, 13, 14, 15)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 13, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 14, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 15, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 16, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 17, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 18, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 19, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 20, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 21, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 22, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 23, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 24, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 25, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 26, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 27, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 28, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 29, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 30, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 31, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 32, 9, 10, 11, 12, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 33, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 34, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 35, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 36, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 37, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 38, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 39, 11, 12, 13, 14, 15)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 40, 11, 12, 13, 14, 15)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 41, 11, 12, 13, 14, 15)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 42, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 43, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 44, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 45, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 46, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 47, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 48, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (2, 49, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 0, 16, 17, 18, 19, 20)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 1, 13, 14, 15, 16, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 2, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 3, 13, 14, 15, 16, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 4, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 5, 13, 14, 15, 16, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 6, 13, 14, 15, 16, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 7, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 8, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 9, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 10, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 11, 16, 17, 18, 19, 20)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 12, 16, 17, 18, 19, 20)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 13, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 14, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 15, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 16, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 17, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 18, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 19, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 20, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 21, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 22, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 23, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 24, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 25, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 26, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 27, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 28, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 29, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 30, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 31, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 32, 13, 14, 15, 16, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 33, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 34, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 35, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 36, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 37, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 38, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 39, 16, 17, 18, 19, 20)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 40, 16, 17, 18, 19, 20)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 41, 16, 17, 18, 19, 20)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 42, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 43, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 44, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 45, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 46, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 47, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 48, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (3, 49, 0, 0, 0, 0, 0)
GO
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 0, 21, 22, 23, 24, 25)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 1, 17, 18, 19, 20, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 2, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 3, 17, 18, 19, 20, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 4, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 5, 17, 18, 19, 20, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 6, 17, 18, 19, 20, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 7, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 8, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 9, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 10, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 11, 21, 22, 23, 24, 25)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 12, 21, 22, 23, 24, 25)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 13, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 14, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 15, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 16, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 17, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 18, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 19, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 20, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 21, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 22, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 23, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 24, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 25, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 26, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 27, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 28, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 29, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 30, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 31, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 32, 17, 18, 19, 20, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 33, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 34, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 35, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 36, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 37, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 38, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 39, 21, 22, 23, 24, 25)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 40, 21, 22, 23, 24, 25)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 41, 21, 22, 23, 24, 25)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 42, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 43, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 44, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 45, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 46, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 47, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 48, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (4, 49, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 0, 26, 27, 28, 29, 30)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 1, 21, 22, 23, 24, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 2, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 3, 21, 22, 23, 24, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 4, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 5, 21, 22, 23, 24, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 6, 21, 22, 23, 24, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 7, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 8, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 9, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 10, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 11, 26, 27, 28, 29, 30)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 12, 26, 27, 28, 29, 30)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 13, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 14, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 15, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 16, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 17, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 18, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 19, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 20, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 21, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 22, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 23, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 24, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 25, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 26, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 27, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 28, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 29, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 30, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 31, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 32, 21, 22, 23, 24, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 33, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 34, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 35, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 36, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 37, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 38, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 39, 26, 27, 28, 29, 30)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 40, 26, 27, 28, 29, 30)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 41, 26, 27, 28, 29, 30)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 42, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 43, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 44, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 45, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 46, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 47, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 48, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (5, 49, 0, 0, 0, 0, 0)
GO
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 0, 31, 32, 4, 5, 7)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 1, 25, 26, 27, 28, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 2, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 3, 25, 26, 27, 28, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 4, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 5, 25, 26, 27, 28, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 6, 25, 26, 27, 28, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 7, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 8, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 9, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 10, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 11, 31, 32, 4, 5, 7)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 12, 31, 32, 4, 5, 7)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 13, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 14, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 15, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 16, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 17, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 18, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 19, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 20, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 21, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 22, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 23, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 24, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 25, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 26, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 27, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 28, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 29, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 30, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 31, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 32, 25, 26, 27, 28, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 33, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 34, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 35, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 36, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 37, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 38, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 39, 31, 32, 4, 5, 7)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 40, 31, 32, 4, 5, 7)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 41, 31, 32, 4, 5, 7)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 42, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 43, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 44, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 45, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 46, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 47, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 48, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (6, 49, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 0, 8, 8, 8, 8, 8)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 1, 29, 30, 31, 32, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 2, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 3, 29, 30, 31, 32, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 4, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 5, 29, 30, 31, 32, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 6, 29, 30, 31, 32, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 7, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 8, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 9, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 10, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 11, 8, 8, 8, 8, 8)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 12, 8, 8, 8, 8, 8)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 13, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 14, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 15, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 16, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 17, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 18, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 19, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 20, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 21, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 22, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 23, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 24, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 25, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 26, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 27, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 28, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 29, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 30, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 31, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 32, 29, 30, 31, 32, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 33, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 34, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 35, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 36, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 37, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 38, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 39, 8, 8, 8, 8, 8)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 40, 8, 8, 8, 8, 8)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 41, 8, 8, 8, 8, 8)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 42, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 43, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 44, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 45, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 46, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 47, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 48, 0, 0, 0, 0, 0)
INSERT [dbo].[Solutions] ([SolutionId], [AreaId], [BasePrice], [GovPrice], [SpcPrice], [Days], [SpcDays]) VALUES (7, 49, 0, 0, 0, 0, 0)
GO
SET IDENTITY_INSERT [dbo].[UserPolicies] ON 

INSERT [dbo].[UserPolicies] ([UPId], [PolicyId], [UserId], [CheckCode], [PayCount], [DateCreated]) VALUES (6, 13, 2, N'7979      ', 2, CAST(N'2017-12-07 21:48:45.520' AS DateTime))
SET IDENTITY_INSERT [dbo].[UserPolicies] OFF
SET IDENTITY_INSERT [dbo].[UserRegs] ON 

INSERT [dbo].[UserRegs] ([RegId], [USId], [UserId], [LinkmanName], [LinkmanTel], [LinkmanEmail], [LinkmanAddr], [LinkmanWechat], [CompName1], [CompName2], [CompName3], [CompRegAddr], [CompProp], [StockCount], [StockHolder], [CEOName], [CFOName], [Secretor], [SignFile], [DateCreated], [IsPayed], [UserPolicyId], [DatePayed]) VALUES (19, 10, 3, N'孙健', N'13811290288', N'51045352@qq.com', N'中华人民共和国北京丰台区', N'wechat', N'多趣互动网络有限公司', N'多趣互动科技网络有限合伙', N'多趣互动科技网络有限公司', N'北京市海淀区', N'游戏', 0, N'孙健', N'孙健', N'CFO', N'李立', N'68bd3806b23743b4bd078bc9d0f26ccd.png', CAST(N'2017-11-19 13:29:58.737' AS DateTime), 0, 0, CAST(N'2017-11-19 13:29:58.737' AS DateTime))
INSERT [dbo].[UserRegs] ([RegId], [USId], [UserId], [LinkmanName], [LinkmanTel], [LinkmanEmail], [LinkmanAddr], [LinkmanWechat], [CompName1], [CompName2], [CompName3], [CompRegAddr], [CompProp], [StockCount], [StockHolder], [CEOName], [CFOName], [Secretor], [SignFile], [DateCreated], [IsPayed], [UserPolicyId], [DatePayed]) VALUES (64, 13, 2, N'sunjian', N'13811290288', N'script@msn.com ', N'北京市朝阳区小关东里14号', N'limingom', N'要注册的公司明1', N'公司名2', N'公司名3', N'公司的地址', N'游戏', 123, N'张三', N'孙健', N'财务', N'秘书长', N'2b2896286cfc4bceabd078fdcf67886b.png', CAST(N'2017-12-07 21:34:44.567' AS DateTime), 1, 0, CAST(N'2017-12-07 21:38:37.360' AS DateTime))
INSERT [dbo].[UserRegs] ([RegId], [USId], [UserId], [LinkmanName], [LinkmanTel], [LinkmanEmail], [LinkmanAddr], [LinkmanWechat], [CompName1], [CompName2], [CompName3], [CompRegAddr], [CompProp], [StockCount], [StockHolder], [CEOName], [CFOName], [Secretor], [SignFile], [DateCreated], [IsPayed], [UserPolicyId], [DatePayed]) VALUES (65, 12, 2, N'张三', N'13811200200', N'script@msn.com ', N'北京市朝阳区小关东里', N'limingok', N'多趣网络有限公司', N'2', N'3', N'北京市海淀区', N'游戏', 0, N'李四', N'王五', N'', N'', N'169693f2c0464641a1eae03076bff249.png', CAST(N'2017-12-07 21:48:20.987' AS DateTime), 1, 0, CAST(N'2017-12-07 21:49:53.627' AS DateTime))
INSERT [dbo].[UserRegs] ([RegId], [USId], [UserId], [LinkmanName], [LinkmanTel], [LinkmanEmail], [LinkmanAddr], [LinkmanWechat], [CompName1], [CompName2], [CompName3], [CompRegAddr], [CompProp], [StockCount], [StockHolder], [CEOName], [CFOName], [Secretor], [SignFile], [DateCreated], [IsPayed], [UserPolicyId], [DatePayed]) VALUES (66, 13, 2, N'sunjan', N'135', N'script@msn.com ', N'heihei', N'hdhd', N'1', N'2', N'3', N'h', N'd', 123, N'djfh', N'sudh', N'dndjd', N'dmfm', N'787c6c64c0cf47049a22a4f3622f5cdb.png', CAST(N'2017-12-07 22:09:29.673' AS DateTime), 1, 0, CAST(N'2017-12-07 22:09:34.783' AS DateTime))
INSERT [dbo].[UserRegs] ([RegId], [USId], [UserId], [LinkmanName], [LinkmanTel], [LinkmanEmail], [LinkmanAddr], [LinkmanWechat], [CompName1], [CompName2], [CompName3], [CompRegAddr], [CompProp], [StockCount], [StockHolder], [CEOName], [CFOName], [Secretor], [SignFile], [DateCreated], [IsPayed], [UserPolicyId], [DatePayed]) VALUES (68, 12, 2, N'哈哈', N'138', N'script@msn.com', N'xhdh', N'djf', N'c', N'c', N'c', N'dh', N'djf', 0, N'djt', N'fjt', N'', N'', N'7b473a980cf94581869ac6be4b616b50.png', CAST(N'2017-12-08 11:43:51.410' AS DateTime), 0, 0, CAST(N'2017-12-08 11:43:51.410' AS DateTime))
INSERT [dbo].[UserRegs] ([RegId], [USId], [UserId], [LinkmanName], [LinkmanTel], [LinkmanEmail], [LinkmanAddr], [LinkmanWechat], [CompName1], [CompName2], [CompName3], [CompRegAddr], [CompProp], [StockCount], [StockHolder], [CEOName], [CFOName], [Secretor], [SignFile], [DateCreated], [IsPayed], [UserPolicyId], [DatePayed]) VALUES (69, 11, 3, N'tty', N'13888888888', N'qfgb@163.rt', N'fgjvg', N'dhjvfyh', N'djsjjsndhd', N'shjsjd', N'shsuxbdb', N'剥削阶级是不是', N'还是觉得不对吧', 0, N'小毛孩', N'大灰狼', N'', N'', N'3ac62295207d44989e1d68b130eac230.png', CAST(N'2017-12-08 11:47:01.597' AS DateTime), 1, 0, CAST(N'2017-12-08 11:47:18.127' AS DateTime))
SET IDENTITY_INSERT [dbo].[UserRegs] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserId], [OpenId], [Nick], [OrderCount], [UserPoliciesCount], [PayedPoliciesCount], [WechatId], [Mobile], [DateCreated], [DateLastActived]) VALUES (18, N'oIg0D0VXgZJfepuv1uPXVMnqpgRc    ', NULL, 0, 0, 0, NULL, NULL, CAST(N'2017-12-08 11:20:30.643' AS DateTime), CAST(N'2017-12-08 11:20:30.643' AS DateTime))
INSERT [dbo].[Users] ([UserId], [OpenId], [Nick], [OrderCount], [UserPoliciesCount], [PayedPoliciesCount], [WechatId], [Mobile], [DateCreated], [DateLastActived]) VALUES (17, N'oIg0D0aAfy-Mmtjscr1kry8nrUwM    ', NULL, 0, 0, 0, NULL, NULL, CAST(N'2017-12-08 11:20:21.847' AS DateTime), CAST(N'2017-12-08 11:20:21.847' AS DateTime))
INSERT [dbo].[Users] ([UserId], [OpenId], [Nick], [OrderCount], [UserPoliciesCount], [PayedPoliciesCount], [WechatId], [Mobile], [DateCreated], [DateLastActived]) VALUES (16, N'oIg0D0Sc5rFKvHN89x-qNOZO4CKM    ', NULL, 0, 0, 0, NULL, NULL, CAST(N'2017-12-08 11:20:20.627' AS DateTime), CAST(N'2017-12-08 11:20:20.627' AS DateTime))
INSERT [dbo].[Users] ([UserId], [OpenId], [Nick], [OrderCount], [UserPoliciesCount], [PayedPoliciesCount], [WechatId], [Mobile], [DateCreated], [DateLastActived]) VALUES (15, N'oIg0D0W6Z5TUMwVOy8xQ9ygf35og    ', NULL, 0, 0, 0, NULL, NULL, CAST(N'2017-12-08 11:20:19.520' AS DateTime), CAST(N'2017-12-08 11:20:19.520' AS DateTime))
INSERT [dbo].[Users] ([UserId], [OpenId], [Nick], [OrderCount], [UserPoliciesCount], [PayedPoliciesCount], [WechatId], [Mobile], [DateCreated], [DateLastActived]) VALUES (14, N'oIg0D0Tsp24n6udWgI4ud7zuR83A    ', NULL, 0, 0, 0, NULL, NULL, CAST(N'2017-12-08 11:20:17.893' AS DateTime), CAST(N'2017-12-08 11:20:17.893' AS DateTime))
INSERT [dbo].[Users] ([UserId], [OpenId], [Nick], [OrderCount], [UserPoliciesCount], [PayedPoliciesCount], [WechatId], [Mobile], [DateCreated], [DateLastActived]) VALUES (13, N'oIg0D0SmEANT7Hl81nEADXu9NWYs    ', NULL, 0, 0, 0, NULL, NULL, CAST(N'2017-12-08 11:20:15.643' AS DateTime), CAST(N'2017-12-08 11:20:15.643' AS DateTime))
INSERT [dbo].[Users] ([UserId], [OpenId], [Nick], [OrderCount], [UserPoliciesCount], [PayedPoliciesCount], [WechatId], [Mobile], [DateCreated], [DateLastActived]) VALUES (12, N'oIg0D0eLVByLnE3sgTW74nuuXc_Y    ', NULL, 0, 0, 0, NULL, NULL, CAST(N'2017-12-08 11:20:15.267' AS DateTime), CAST(N'2017-12-08 11:20:15.267' AS DateTime))
INSERT [dbo].[Users] ([UserId], [OpenId], [Nick], [OrderCount], [UserPoliciesCount], [PayedPoliciesCount], [WechatId], [Mobile], [DateCreated], [DateLastActived]) VALUES (11, N'oIg0D0aGfRd9gGUCFW28bWxDGWyQ    ', NULL, 0, 0, 0, NULL, NULL, CAST(N'2017-12-08 11:20:12.673' AS DateTime), CAST(N'2017-12-08 11:20:12.673' AS DateTime))
INSERT [dbo].[Users] ([UserId], [OpenId], [Nick], [OrderCount], [UserPoliciesCount], [PayedPoliciesCount], [WechatId], [Mobile], [DateCreated], [DateLastActived]) VALUES (10, N'oIg0D0S9Ftp9OBOuRM3YBt6uWSm0    ', NULL, 0, 0, 0, NULL, NULL, CAST(N'2017-12-08 11:20:11.690' AS DateTime), CAST(N'2017-12-08 11:20:11.690' AS DateTime))
INSERT [dbo].[Users] ([UserId], [OpenId], [Nick], [OrderCount], [UserPoliciesCount], [PayedPoliciesCount], [WechatId], [Mobile], [DateCreated], [DateLastActived]) VALUES (9, N'oIg0D0Xo0QeireNVTe9AREF9k6nY    ', NULL, 0, 0, 0, NULL, NULL, CAST(N'2017-12-08 11:20:10.580' AS DateTime), CAST(N'2017-12-08 11:20:10.580' AS DateTime))
INSERT [dbo].[Users] ([UserId], [OpenId], [Nick], [OrderCount], [UserPoliciesCount], [PayedPoliciesCount], [WechatId], [Mobile], [DateCreated], [DateLastActived]) VALUES (8, N'oIg0D0UTO6TcBfHK8TjsFQY6mN2s    ', NULL, 0, 0, 0, NULL, NULL, CAST(N'2017-12-08 11:20:10.363' AS DateTime), CAST(N'2017-12-08 11:20:10.363' AS DateTime))
INSERT [dbo].[Users] ([UserId], [OpenId], [Nick], [OrderCount], [UserPoliciesCount], [PayedPoliciesCount], [WechatId], [Mobile], [DateCreated], [DateLastActived]) VALUES (7, N'oIg0D0d3l6IkUpSnwBiphUepEr_o    ', NULL, 0, 0, 0, NULL, NULL, CAST(N'2017-12-08 11:20:10.067' AS DateTime), CAST(N'2017-12-08 11:20:10.067' AS DateTime))
INSERT [dbo].[Users] ([UserId], [OpenId], [Nick], [OrderCount], [UserPoliciesCount], [PayedPoliciesCount], [WechatId], [Mobile], [DateCreated], [DateLastActived]) VALUES (6, N'oIg0D0R7FeIrEqq_AoOjYw8Sfucw    ', NULL, 0, 0, 0, NULL, NULL, CAST(N'2017-12-08 11:20:07.017' AS DateTime), CAST(N'2017-12-08 11:20:07.017' AS DateTime))
INSERT [dbo].[Users] ([UserId], [OpenId], [Nick], [OrderCount], [UserPoliciesCount], [PayedPoliciesCount], [WechatId], [Mobile], [DateCreated], [DateLastActived]) VALUES (5, N'oIg0D0VzTk6RfHeV-sPcT5HBLOW4    ', NULL, 0, 0, 0, NULL, NULL, CAST(N'2017-12-08 11:20:05.207' AS DateTime), CAST(N'2017-12-08 11:20:05.207' AS DateTime))
INSERT [dbo].[Users] ([UserId], [OpenId], [Nick], [OrderCount], [UserPoliciesCount], [PayedPoliciesCount], [WechatId], [Mobile], [DateCreated], [DateLastActived]) VALUES (4, N'oIg0D0cg9Y10fgoUSM-NNWRA8YkI    ', NULL, 0, 0, 0, NULL, NULL, CAST(N'2017-12-08 11:20:04.487' AS DateTime), CAST(N'2017-12-08 11:20:04.487' AS DateTime))
INSERT [dbo].[Users] ([UserId], [OpenId], [Nick], [OrderCount], [UserPoliciesCount], [PayedPoliciesCount], [WechatId], [Mobile], [DateCreated], [DateLastActived]) VALUES (3, N'oIg0D0Y6QJWEBjZ_bNKdE2TU2HrQ    ', NULL, 1, 0, 0, NULL, NULL, CAST(N'2017-11-19 22:24:10.690' AS DateTime), CAST(N'2017-11-19 22:24:10.690' AS DateTime))
INSERT [dbo].[Users] ([UserId], [OpenId], [Nick], [OrderCount], [UserPoliciesCount], [PayedPoliciesCount], [WechatId], [Mobile], [DateCreated], [DateLastActived]) VALUES (2, N'oIg0D0dhYKV56yJSbLqRb0-tF73A    ', NULL, 3, 0, 2, N'limingok', N'13811290288', CAST(N'2017-11-01 09:01:06.253' AS DateTime), CAST(N'2017-11-01 09:01:06.253' AS DateTime))
SET IDENTITY_INSERT [dbo].[Users] OFF
SET IDENTITY_INSERT [dbo].[UserSolutions] ON 

INSERT [dbo].[UserSolutions] ([USId], [AreaId], [UserId], [SolutionId], [IsSpc], [DateCreated]) VALUES (13, 0, 2, 2, 1, CAST(N'2017-12-02 11:18:13.720' AS DateTime))
INSERT [dbo].[UserSolutions] ([USId], [AreaId], [UserId], [SolutionId], [IsSpc], [DateCreated]) VALUES (12, 0, 2, 7, 1, CAST(N'2017-12-02 10:35:54.127' AS DateTime))
INSERT [dbo].[UserSolutions] ([USId], [AreaId], [UserId], [SolutionId], [IsSpc], [DateCreated]) VALUES (11, 0, 3, 7, 0, CAST(N'2017-11-19 22:28:50.690' AS DateTime))
INSERT [dbo].[UserSolutions] ([USId], [AreaId], [UserId], [SolutionId], [IsSpc], [DateCreated]) VALUES (10, 0, 3, 2, 0, CAST(N'2017-11-19 22:26:43.470' AS DateTime))
SET IDENTITY_INSERT [dbo].[UserSolutions] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Operators]    Script Date: 2017/12/9 0:38:47 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Operators] ON [dbo].[Operators]
(
	[Mobile] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Cash]  WITH CHECK ADD  CONSTRAINT [FK_Cash_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Cash] CHECK CONSTRAINT [FK_Cash_Users]
GO
ALTER TABLE [dbo].[Operators]  WITH CHECK ADD  CONSTRAINT [FK_Operators_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Operators] CHECK CONSTRAINT [FK_Operators_Roles]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_UserRegs] FOREIGN KEY([RegId])
REFERENCES [dbo].[UserRegs] ([RegId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_UserRegs]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Users]
GO
ALTER TABLE [dbo].[UserPolicies]  WITH CHECK ADD  CONSTRAINT [FK_UserPolicies_Policies] FOREIGN KEY([PolicyId])
REFERENCES [dbo].[Policies] ([PolicyId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserPolicies] CHECK CONSTRAINT [FK_UserPolicies_Policies]
GO
ALTER TABLE [dbo].[UserPolicies]  WITH CHECK ADD  CONSTRAINT [FK_UserPolicies_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserPolicies] CHECK CONSTRAINT [FK_UserPolicies_Users]
GO
ALTER TABLE [dbo].[UserSolutions]  WITH CHECK ADD  CONSTRAINT [FK_UserSolutions_Areas] FOREIGN KEY([AreaId])
REFERENCES [dbo].[Areas] ([AreaId])
GO
ALTER TABLE [dbo].[UserSolutions] CHECK CONSTRAINT [FK_UserSolutions_Areas]
GO
ALTER TABLE [dbo].[UserSolutions]  WITH CHECK ADD  CONSTRAINT [FK_UserSolutions_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[UserSolutions] CHECK CONSTRAINT [FK_UserSolutions_Users]
GO
/****** Object:  StoredProcedure [dbo].[ChangePass]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ChangePass]
	-- Add the parameters for the stored procedure here
	@OperatorId int,
	@OldPassword char(32),
	@NewPassword char(32)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update Operators set [Password] = @NewPassword where @OperatorId = @OperatorId and [Password] = @OldPassword;

	select @@ROWCOUNT as Result

END

GO
/****** Object:  StoredProcedure [dbo].[CreateOperator]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateOperator]
	-- Add the parameters for the stored procedure here
	@Name nvarchar(30),
	@Mobile char(15),
	@Password char(32),
	@RoleId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if exists(select Mobile FROM Operators where Mobile = @Mobile)
	begin
		select -1 as OperatorId
		return -1
	end 

	if exists(select Name FROM Operators where Name = @Name)
	begin
		select -2 as OperatorId
		return -2
	end 

    -- Insert statements for procedure here
	INSERT INTO Operators (Name, Mobile, [Password], RoleId)
	VALUES
	(@Name, @Mobile, @Password, @RoleId);


	IF(@@ROWCOUNT > 0 and @@ERROR = 0)
	SELECT @@IDENTITY as OperatorId
	ELSE
	SELECT -2 AS OperatorId
END

GO
/****** Object:  StoredProcedure [dbo].[CreateOrder]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateOrder]
	-- Add the parameters for the stored procedure here
	@UserId int,
	@RegId int,
	@UPId int,
	@BaseMoney int,
	@GovMoney int,
	@SpcMoney int,
	@OrderDisMoney int,
	@OrderShareMoney int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Orders (UserId, RegId, UPId, BaseMoney, GovMoney, SpcMoney, OrderDisMoney, OrderShareMoney) 
	VALUES
	(@UserId, @RegId, @UPId, @BaseMoney, @GovMoney, @SpcMoney, @OrderDisMoney, @OrderShareMoney)

	select @@IDENTITY as OrderId

	DELETE FROM Orders where IsPayed = 0 and DATEDIFF(day, DateCreated, getdate()) > 3
END

GO
/****** Object:  StoredProcedure [dbo].[CreateRole]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[CreateRole]
	-- Add the parameters for the stored procedure here
	@RoleName nchar(30),
	@AuthValue int  = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Roles (RoleName, AuthValue) VALUES (@RoleName, @AuthValue);

	SELECT @@IDENTITY as RoleId;
END

GO
/****** Object:  StoredProcedure [dbo].[DeleteAd]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteAd]
	-- Add the parameters for the stored procedure here
	@AdId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM Ads WHERE AdId = @AdId
END

GO
/****** Object:  StoredProcedure [dbo].[DeleteOperator]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[DeleteOperator]
	-- Add the parameters for the stored procedure here
	@OperatorId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM Operators WHERE OperatorId = @OperatorId;
END

GO
/****** Object:  StoredProcedure [dbo].[DeleteRole]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[DeleteRole]
	-- Add the parameters for the stored procedure here
	@RoleId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM Roles WHERE RoleId = @RoleId;
END

GO
/****** Object:  StoredProcedure [dbo].[DeleteUserReg]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteUserReg]
	@UserId int,
	@RegId int	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM UserRegs WHERE UserId = @UserId AND RegId = @RegId AND IsPayed = 0
END

GO
/****** Object:  StoredProcedure [dbo].[DoCash]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DoCash]
	-- Add the parameters for the stored procedure here
	@CashId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update cash set IsPayed = 1 where CashId = @CashId
END

GO
/****** Object:  StoredProcedure [dbo].[GetAdInfoById]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAdInfoById]
	-- Add the parameters for the stored procedure here
	@AdId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Ads WHERE AdId = @AdId
END

GO
/****** Object:  StoredProcedure [dbo].[GetAds]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAds]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Ads 
END

GO
/****** Object:  StoredProcedure [dbo].[GetAllOperators]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[GetAllOperators]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Operators.OperatorId, Operators.Name, Operators.Mobile, Operators.RoleId, Operators.CreateDate, Operators.LoginDate, Roles.RoleName, Roles.AuthValue FROM Operators LEFT Join Roles
	ON Operators.RoleId = Roles.RoleId
END

GO
/****** Object:  StoredProcedure [dbo].[GetAreaSolution]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAreaSolution]
	-- Add the parameters for the stored procedure here
	@AreaId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Solutions WHERE AreaId =@AreaId ORDER BY SolutionId ASC
END

GO
/****** Object:  StoredProcedure [dbo].[GetAvaiablePolicies]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAvaiablePolicies]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Policies WHERE GetDate() < EndTime ORDER BY PolicyId DESC
END

GO
/****** Object:  StoredProcedure [dbo].[GetCashList]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetCashList] 
	@PageIndex int,
	@PageSize int,
	@TotalCount int output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    declare @StartIndex int
	declare @EndIndex int 

	set @TotalCount = 0;
	set @StartIndex = @PageSize * @PageIndex;
	set @EndIndex = @StartIndex + @PageSize;

    -- Insert statements for procedure here
	declare  @TempCash table
		(Id [int] IDENTITY(0,1) NOT NULL,
		CashId int);

	INSERT INTO @TempCash (CashId) SELECT CashId FROM Cash

	select @TotalCount = count(0) from @TempCash
	
	SELECT  c.*, u.OpenId, u.WechatId, u.Mobile FROM @TempCash t 
	LEFT JOIN Cash c on t.CashId = c.CashId
	left join Users u on c.UserId = u.UserId
	WHERE t.Id >= @StartIndex and t.Id < @EndIndex 
END

GO
/****** Object:  StoredProcedure [dbo].[GetOperatorInfo]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[GetOperatorInfo]
	-- Add the parameters for the stored procedure here
	@OperatorId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select Operators.* , Roles.RoleName, Roles.AuthValue from  Operators left join Roles

	on Operators.RoleId = Roles.RoleId



	where Operators.OperatorId = @OperatorId;
END

GO
/****** Object:  StoredProcedure [dbo].[GetOperatorInfoByMobileAndPassword]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetOperatorInfoByMobileAndPassword]
	-- Add the parameters for the stored procedure here
	@Mobile char(15),
	@PassworldMD5 char(32)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @UserId int
	SET @UserId = -1
    -- Insert statements for procedure here
		SELECT Operators.OperatorId, Operators.Name, Operators.Mobile, Operators.RoleId,  Operators.CreateDate, Operators.LoginDate, Roles.RoleName, Roles.AuthValue FROM Operators LEFT Join Roles
	ON Operators.RoleId = Roles.RoleId
	WHERE Operators.Mobile = @Mobile and Operators.[Password] = @PassworldMD5

	IF(@@ROWCOUNT <> 0)
		UPDATE Operators SET LoginDate = GETDATE() WHERE Mobile = @Mobile
END


GO
/****** Object:  StoredProcedure [dbo].[GetOrderInfoByRegId]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetOrderInfoByRegId]
	-- Add the parameters for the stored procedure here
	@RegId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP 1 o.*, s.IsSpc FROM Orders o left join UserRegs r on o.RegId = r.RegId
	left join UserSolutions s on r.USId = s.USId WHERE o.RegId = @RegId and o.IsPayed = 1
END

GO
/****** Object:  StoredProcedure [dbo].[GetOrders]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetOrders]
	@PageIndex int,
	@PageSize int,
	@TotalCount int output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    declare @StartIndex int
	declare @EndIndex int 

	set @TotalCount = 0;
	set @StartIndex = @PageSize * @PageIndex;
	set @EndIndex = @StartIndex + @PageSize;

    -- Insert statements for procedure here
	declare  @TempOrders table
		(Id [int] IDENTITY(0,1) NOT NULL,
		OrderId int);

	INSERT INTO @TempOrders (OrderId) SELECT OrderId FROM Orders where IsPayed = 1

	select @TotalCount = count(0) from @TempOrders
	select o.*, u.OpenId, ur.CompName1, us.IsSpc  from  @TempOrders t
	left join Orders o on t.OrderId = o.OrderId
	left join Users u on o.UserId = u.UserId
	left join UserRegs ur on o.RegId = ur.RegId
	left join UserSolutions us on ur.USId = us.USId
	WHERE t.Id >= @StartIndex and t.Id < @EndIndex 
END

GO
/****** Object:  StoredProcedure [dbo].[GetPolicies]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetPolicies] 
	@PageIndex int,
	@PageSize int,
	@PageTotal int output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @StartIndex int
	declare @EndIndex int 

	set @PageTotal = 0;
	set @StartIndex = @PageSize * @PageIndex;
	set @EndIndex = @StartIndex + @PageSize;

    -- Insert statements for procedure here
	declare  @TempPolicies table
		(Id [int] IDENTITY(0,1) NOT NULL,
		PolicyId int);

	INSERT INTO @TempPolicies (PolicyId) SELECT PolicyId FROM Policies ORDER BY PolicyId DESC


	declare @RecordCount float;
	select @RecordCount = count(0) from @TempPolicies
	set @PageTotal = CEILING(@RecordCount / cast(@PageSize as float));

	print @PageTotal
	SELECT  p.* FROM @TempPolicies t LEFT JOIN Policies p on t.PolicyId = p.PolicyId
	WHERE t.Id >= @StartIndex and t.Id < @EndIndex 

	return @PageTotal
END

GO
/****** Object:  StoredProcedure [dbo].[GetPolicyInfoById]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetPolicyInfoById]
	-- Add the parameters for the stored procedure here
	@PolicyId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Policies WHERE PolicyId = @PolicyId

END

GO
/****** Object:  StoredProcedure [dbo].[GetRegInfoById]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetRegInfoById] 
	-- Add the parameters for the stored procedure here
	@RegId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT ur.*, 
			us.AreaId,	
			us.IsSpc,	
			us.SolutionId,	
	        a.AreaName,
			a.AreaNameEN,
			s.BasePrice,
			s.GovPrice,
			s.SpcPrice,
			s.Days,
			s.SpcDays
	FROM UserRegs ur 
	left join UserSolutions us on ur.USId = us.USId 
	left join Areas a on us.AreaId = a.AreaId
    left join Solutions s on us.SolutionId = s.SolutionId and us.AreaId = s.AreaId 
	where ur.RegId = @RegId
END

GO
/****** Object:  StoredProcedure [dbo].[GetSessionInfoById]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetSessionInfoById]
	-- Add the parameters for the stored procedure here
	@SessionId uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT u.UserId, s.SessionId, s.WechatOpenId, s.WechatSessionKey, s.DateCreated, s.DateExpired  FROM Sessions s LEFT JOIN Users u ON s.WechatOpenId = u.OpenId  WHERE s.SessionId = @SessionId AND s.DateExpired > GETDATE()
END

GO
/****** Object:  StoredProcedure [dbo].[GetUserCashList]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUserCashList]
	-- Add the parameters for the stored procedure here
	@UserId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Cash where UserId = @UserId
END

GO
/****** Object:  StoredProcedure [dbo].[GetUserCashStatus]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUserCashStatus]
	-- Add the parameters for the stored procedure here
	@UserId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @IncomeTotal int
	declare @CashTotal int
	declare @CashTotalPending int
	declare @CashMoneyLeft int
	declare @WechatId varchar(60)
	declare @Mobile varchar(30)

	set @IncomeTotal = 0;
	set @CashTotal = 0;
	set @CashTotalPending = 0;
	set @CashMoneyLeft = 0
	set @WechatId = '';
	set @Mobile = '';

	select @WechatId = WechatId, @Mobile = Mobile from Users where UserId = @UserId

    -- Insert statements for procedure here
	select @IncomeTotal = sum(o.OrderShareMoney) from Orders o 
	left join UserPolicies up 
	on o.UPId = up.UPId
	where up.UserId = @UserId and o.IsPayed = 1

	if(@IncomeTotal is null)
	begin
		set @IncomeTotal = 0
	end 

	select @CashTotal = sum(CashMoney) from Cash where UserId = @UserId and IsPayed = 1

	if(@CashTotal is NULL)
	begin
		set @CashTotal = 0
	end

	select @CashTotalPending = sum(CashMoney) from Cash where UserId =@UserId and IsPayed = 0

	if(@CashTotalPending is null)
	begin
		set @CashTotalPending = 0
	end

	set @CashMoneyLeft = (@IncomeTotal - @CashTotal - @CashTotalPending);

	select @IncomeTotal as IncomeTotal, 
			@CashTotal as CashTotal, 
			@CashTotalPending as CashTotalPending, 
			@CashMoneyLeft as CashMoneyLeft,
			@WechatId as WechatId,
			@Mobile as Mobile
END

GO
/****** Object:  StoredProcedure [dbo].[GetUserPayedOrdersCount]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUserPayedOrdersCount]
	-- Add the parameters for the stored procedure here
	@UserId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT count(0) FROM Orders WHERE UserId = @UserId and IsPayed = 1
END

GO
/****** Object:  StoredProcedure [dbo].[GetUserPolicies]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUserPolicies]
	-- Add the parameters for the stored procedure here
	@UserId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT up.UPId, up.UserId, up.CheckCode, up.DateCreated, p.* FROM UserPolicies up left join Policies p
	ON up.PolicyId = p.PolicyId
	WHERE up.UserId = @UserId
END

GO
/****** Object:  StoredProcedure [dbo].[GetUserPoliciesCount]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUserPoliciesCount]
	-- Add the parameters for the stored procedure here
	@UserId int,
	@PolicyId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT COUNT(0) as Result FROM Orders o left join UserPolicies up
	on o.UPId = up.UPId
	WHERE o.UserId = @UserId and up.PolicyId = @PolicyId and o.IsPayed = 1
END

GO
/****** Object:  StoredProcedure [dbo].[GetUserPolicyInfoByCheckCode]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUserPolicyInfoByCheckCode]
	-- Add the parameters for the stored procedure here
	@CheckCode char(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	SELECT p.*, up.CheckCode, up.UserId, up.UPId, up.DateCreated, up.CheckCode FROM UserPolicies up left join Policies p on up.PolicyId = p.PolicyId
	where  up.CheckCode = @CheckCode;

END

GO
/****** Object:  StoredProcedure [dbo].[GetUserPolicyInfoById]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUserPolicyInfoById]
	-- Add the parameters for the stored procedure here
	@UPId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT p.*, up.CheckCode, up.UserId, up.UPId, up.DateCreated, up.CheckCode FROM UserPolicies up left join Policies p on up.PolicyId = p.PolicyId
	where  up.UPId = @UPId
END

GO
/****** Object:  StoredProcedure [dbo].[GetUserRegs]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUserRegs] 
	@UserId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT ur.*, 
			us.AreaId,	
			us.IsSpc,	
			us.SolutionId,	
	        a.AreaName,
			a.AreaNameEN,
			s.BasePrice,
			s.GovPrice,
			s.SpcPrice,
			s.Days,
			s.SpcDays
	FROM UserRegs ur 
	left join UserSolutions us on ur.USId = us.USId 
	left join Areas a on us.AreaId = a.AreaId
    left join Solutions s on us.SolutionId = s.SolutionId and us.AreaId = s.AreaId 
	where ur.UserId = @UserId ORDER BY ur.RegId DESC
END

GO
/****** Object:  StoredProcedure [dbo].[GetUsers]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUsers]
	-- Add the parameters for the stored procedure here
	@PageIndex int,
	@PageSize int,
	@PageTotal int output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @StartIndex int
	declare @EndIndex int 

	set @PageTotal = 0;
	set @StartIndex = @PageSize * @PageIndex;
	set @EndIndex = @StartIndex + @PageSize;

    -- Insert statements for procedure here
	declare  @TempUsers table
		(Id [int] IDENTITY(0,1) NOT NULL,
		UserId int);

	INSERT INTO @TempUsers (UserId) SELECT UserId FROM Users


	declare @RecordCount float;
	select @RecordCount = count(0) from @TempUsers
	set @PageTotal = CEILING(@RecordCount / cast(@PageSize as float));


	SELECT  u.* FROM @TempUsers t LEFT JOIN Users u on t.UserId = u.UserId
	WHERE t.Id >= @StartIndex and t.Id < @EndIndex 

	return @PageTotal
END

GO
/****** Object:  StoredProcedure [dbo].[GetUserShareOrders]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUserShareOrders]
	-- Add the parameters for the stored procedure here
	@UserId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT o.*, up.CheckCode, p.Title as PolicyTitle, us.IsSpc  from orders o 
	left join UserPolicies up on o.UPId = up.UPId
	left join Policies p on up.PolicyId = p.PolicyId
	left join UserRegs ur on o.RegId = ur.RegId
	left join UserSolutions us on us.USId = ur.USId
	where up.UserId = @UserId and o.isPayed = 1
END

GO
/****** Object:  StoredProcedure [dbo].[GetUserSolutionByUSId]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUserSolutionByUSId] 
	-- Add the parameters for the stored procedure here
	@USId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select  us.*, 
	        a.AreaName,
			a.AreaNameEN,
			s.BasePrice,
			s.GovPrice,
			s.SpcPrice,
			s.Days,
			s.SpcDays
			from UserSolutions us left join Areas a on us.AreaId = a.AreaId
left join Solutions s on us.SolutionId = s.SolutionId and us.AreaId = s.AreaId 
 WHERE us.USId = @USId
END

GO
/****** Object:  StoredProcedure [dbo].[GetUserSolutions]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUserSolutions]
	-- Add the parameters for the stored procedure here
	@UserId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
select  us.*, 
	        a.AreaName,
			a.AreaNameEN,
			s.BasePrice,
			s.GovPrice,
			s.SpcPrice,
			s.Days,
			s.SpcDays
			from UserSolutions us left join Areas a on us.AreaId = a.AreaId
left join Solutions s on us.SolutionId = s.SolutionId and us.AreaId = s.AreaId 
where us.UserId = 2 order by us.USId desc
END

GO
/****** Object:  StoredProcedure [dbo].[GetUserSolutionsByUserId]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUserSolutionsByUserId]
	-- Add the parameters for the stored procedure here
	@UserId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select  us.*, 
	        a.AreaName,
			a.AreaNameEN,
			s.BasePrice,
			s.GovPrice,
			s.SpcPrice,
			s.Days,
			s.SpcDays
			from UserSolutions us left join Areas a on us.AreaId = a.AreaId
left join Solutions s on us.SolutionId = s.SolutionId and us.AreaId = s.AreaId 
 WHERE us.UserId = @UserId ORDER BY USId DESC
END

GO
/****** Object:  StoredProcedure [dbo].[NewAd]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[NewAd] 
	-- Add the parameters for the stored procedure here
	@ImagePath varchar(200)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Insert into Ads (ImagePath) values (@ImagePath);

	SELECT @@IDENTITY as AdId
END

GO
/****** Object:  StoredProcedure [dbo].[NewCash]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[NewCash] 
	-- Add the parameters for the stored procedure here
	@UserId int,
	@CashMoney int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--不能有待处理的
	if exists(select top 1 CashId from Cash where UserId = @UserId and IsPayed = 0)
	begin
		select -2 as CashId
		return -2
	end

    -- Insert statements for procedure here
	declare @IncomeTotal int
	declare @CashTotal int

	set @IncomeTotal = 0
	set @CashTotal = 0

	--计算历史总收入
	select @IncomeTotal = sum(o.OrderShareMoney) from Orders o 
	left join UserPolicies up 
	on o.UPId = up.UPId
	where up.UserId = @UserId and o.IsPayed = 1

	if(@IncomeTotal is null)
	begin
		set @IncomeTotal = 0
	end 

	--计算已经提现
	select @CashTotal = sum(CashMoney) from Cash where UserId = @UserId

	if(@CashTotal is null)
	begin
		set @CashTotal = 0
	end

	if(@CashMoney > (@IncomeTotal - @CashTotal))
	begin
		select -1 as CashId
		return -1
	end

	insert into Cash (UserId, CashMoney) values (@UserId, @CashMoney);

	select @@IDENTITY as CashId

END

GO
/****** Object:  StoredProcedure [dbo].[NewOrder]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[NewOrder]
	-- Add the parameters for the stored procedure here
	@UserId int,
	@RegId int,
	@UPId int,
	@BaseMoney int,
	@GovMoney int,
	@SpcMoney int,
	@OrderDisMoney int,
	@OrderShareMoney int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Orders (UserId, RegId, UPId, BaseMoney, GovMoney, SpcMoney, OrderDisMoney, OrderShareMoney) 
	VALUES
	(@UserId, @RegId, @UPId, @BaseMoney, @GovMoney, @SpcMoney, @OrderDisMoney, @OrderShareMoney)

	select @@IDENTITY as OrderId
END

GO
/****** Object:  StoredProcedure [dbo].[NewPolicy]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[NewPolicy]
	-- Add the parameters for the stored procedure here
	@Title nvarchar(60),
	@Comment nvarchar(100),
	@LimitCountPerUser int,
	@MinPrice int,
	@LimitNewUser bit,
	@LimitOldUser bit,
	@IsDisPercent bit,
	@DisMoney int,
	@IsSharePercent bit,
	@ShareMoney int,
	@AreaIds varchar(150),
	@RefCount int,
	@GenCount int,
	@RegCount int,
	@PayCount int,
	@StartTime datetime,
	@EndTime datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Policies (Title, Comment, LimitCountPerUser, LimitMinPrice, LimitNewUser, LimitOldUser, IsDisPercent, DisMoney, IsSharePercent, ShareMoney, AreaIds, RefCount, GenCount, RegCount, PayCount, StartTime, EndTime)
	VALUES (@Title, @Comment, @LimitCountPerUser, @MinPrice, @LimitNewUser, @LimitOldUser, @IsDisPercent, @DisMoney, @IsSharePercent, @ShareMoney, @AreaIds, @RefCount, @GenCount, @RegCount, @PayCount, @StartTime, @EndTime);

	SELECT @@IDENTITY as PolicyId
END

GO
/****** Object:  StoredProcedure [dbo].[NewReg]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[NewReg]
	-- Add the parameters for the stored procedure here
	@UserId int,
	@USId int,
	@LinkmanName nvarchar(50),
	@LinkmanTel varchar(50),
	@LinkmanEmail varchar(50),
	@LinkmanAddr nvarchar(200),
	@LinkmanWechat varchar(50),
	@CompName1 nvarchar(90),
	@CompName2 nvarchar(90),
	@CompName3 nvarchar(90),
	@CompRegAddr nvarchar(200),
	@CompProp nvarchar(90),
	@StockCount int,
	@StockHolder nvarchar(600),
	@CEOName nvarchar(50),
	@CFOName nvarchar(50),
	@Secretor nvarchar(50),
	@SignFile varchar(200)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO UserRegs 
	(UserId, USId, LinkmanName, LinkmanTel, LinkmanEmail, LinkmanAddr, LinkmanWechat, CompName1, CompName2, CompName3, CompRegAddr, CompProp, StockCount, StockHolder, CEOName, CFOName, Secretor, SignFile)
	VALUES
	(@UserId, @USId, @LinkmanName,@LinkmanTel, @LinkmanEmail, @LinkmanAddr, @LinkmanWechat, @CompName1, @CompName2, @CompName3, @CompRegAddr, @CompProp, @StockCount, @StockHolder,@CEOName, @CFOName, @Secretor, @SignFile);

	SELECT @@IDENTITY as Result
END

GO
/****** Object:  StoredProcedure [dbo].[NewSession]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[NewSession]
	-- Add the parameters for the stored procedure here
	@SessionId uniqueidentifier,
	@WechatSessionKey varchar(50),
	@WechatOpenId varchar(50),
	@DateCreated datetime,
	@DateExpired datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM Sessions WHERE SessionId = @SessionId OR DateExpired < GETDATE();
	BEGIN TRAN
	INSERT INTO Sessions (SessionId, WechatSessionKey, WechatOpenId, DateCreated, DateExpired, DateLastActived) VALUES
	(@SessionId, @WechatSessionKey, @WechatOpenId, @DateCreated, @DateExpired, @DateCreated);

	IF(@@ERROR <> 0)
	BEGIN
		ROLLBACK TRAN
		SELECT -1 AS Result
		RETURN -1
	END

	DECLARE @UserId INT
	SET @UserId = -1

	SELECT TOP 1 @UserId = UserId FROM Users WHERE OpenId = @WechatOpenId

	IF(@UserId = -1)
	BEGIN
		INSERT INTO Users (OpenId) VALUES (@WechatOpenId)
		IF(@@ERROR <> 0)
		BEGIN
			ROLLBACK TRAN
			SELECT -2 AS Result
			RETURN -2
		END
		ELSE
		BEGIN
			COMMIT TRAN
			SELECT @@IDENTITY as Result;
			RETURN @@IDENTITY
		END
	END
	ELSE
	BEGIN
		COMMIT TRAN
		SELECT @UserId as Result;
		RETURN @UserId
	END
END

GO
/****** Object:  StoredProcedure [dbo].[NewUserAreaSolution]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[NewUserAreaSolution]
	-- Add the parameters for the stored procedure here
	@UserId int,
	@AreaId int,
	@SolutionId int,
	@IsSpc bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF not exists (SELECT TOP 1 UserId FROM Users WHERE UserId = @UserId)
	BEGIN
		SELECT -1 as Result
		RETURN -1
	END

	IF not exists (SELECT TOP 1 SolutionId FROM Solutions WHERE AreaId = @AreaId AND SolutionId = @SolutionId)
	BEGIN
		SELECT -2 as Result
		RETURN -2
	END

	BEGIN TRAN

	DECLARE @USIdFind int
	SET @USIdFind = -1

	SELECT TOP 1 @USIdFind = USId FROM UserSolutions WHERE AreaId = @AreaId AND UserId = @UserId AND SolutionId = @SolutionId And IsSpc = @IsSpc
	IF(@USIdFind <> -1)
	BEGIN
		ROLLBACK TRAN
		SELECT @USIdFind as Result;
		RETURN @USIdFind
	END

	INSERT INTO UserSolutions (AreaId, UserId, SolutionId, IsSpc) VALUES (@AreaId, @UserId, @SolutionId, @IsSpc)

	IF(@@ERROR = 0)
	BEGIN
		COMMIT TRAN
		SELECT @@IDENTITY as Result
		RETURN @@IDENTITY
	END
	ROLLBACK TRAN
	SELECT -4 as Result
	RETURN -4
		
END

GO
/****** Object:  StoredProcedure [dbo].[NewUserPolicy]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[NewUserPolicy]
	-- Add the parameters for the stored procedure here
	@PolicyId int,
	@UserId int,
	@CheckCode char(10)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF EXISTS (SELECT TOP 1 PolicyId FROM UserPolicies WHERE CheckCode = @CheckCode)
	BEGIN
		SELECT -1 as UPId
		RETURN -1
	END


	BEGIN TRAN
    -- Insert statements for procedure here
	INSERT INTO UserPolicies (PolicyId, UserId, CheckCode) VALUES (@PolicyId, @UserId, @CheckCode);

	IF(@@ERROR <> 0)
	BEGIN
		SELECT -2 as UPID
		RETURN -2
	END

	UPDATE Policies SET GenCount = GenCount + 1 WHERE PolicyId = @PolicyId

	IF(@@ROWCOUNT < 1)
	BEGIN
		ROLLBACK TRAN
		SELECT -2 as UPID
		RETURN -2
	END

	COMMIT TRAN

	SELECT @@IDENTITY as UPId
END

GO
/****** Object:  StoredProcedure [dbo].[PayOrder]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PayOrder]
	-- Add the parameters for the stored procedure here
	@OrderId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @FindOrderId int
	declare @UserId int
	declare @PolicyBelongUserId int
	declare @RegId int
	declare @UPId int
	declare @PolicyId int
	declare @IsPayed bit

	set @FindOrderId = -1

    select @FindOrderId = o.OrderId, 
	@UserId = o.UserId, 
	@RegId = o.RegId, 
	@PolicyId = u.PolicyId, 
	@UPId = o.UPId, 
	@PolicyBelongUserId = u.UserId,
	@IsPayed = o.IsPayed
	from Orders o left join UserPolicies u on o.UPId = u.UPId
	where o.OrderId = @OrderId
	
	IF(@FindOrderId = -1)
	BEGIN
		SELECT -1 as PayResult
		RETURN -1
	END

	IF(@IsPayed = 1)
	begin
		select -2 as PayResult
		return -2
	end

	Update Orders SET IsPayed = 1, DatePayed = GetDate() WHERE OrderId = @OrderId

	Update UserRegs SET IsPayed = 1, DatePayed = GetDate() WHERE RegId = @RegId

	Update Users SET OrderCount = OrderCount + 1 where UserId = @UserId

	Update Users Set PayedPoliciesCount = PayedPoliciesCount + 1 WHERE UserId = @PolicyBelongUserId

	Update UserPolicies SET PayCount = PayCount + 1 WHERE UPId = @UPId

	update Policies set PayCount  = PayCount + 1 WHERE PolicyId = @PolicyId

	SELECT @OrderId as PayResult
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateAuthValueOfRole]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[UpdateAuthValueOfRole]
	-- Add the parameters for the stored procedure here
	@RoleId int,
	@AuthValue int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Roles SET AuthValue = @AuthValue WHERE RoleId = @RoleId;
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateRoleOfOperator]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[UpdateRoleOfOperator]
	@OperatorId int,
	@RoleId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Update Operators SET RoleId = @RoleId WHERE OperatorId = @OperatorId;
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateSolutionInfo]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateSolutionInfo]
	-- Add the parameters for the stored procedure here
	@AreaId int,
	@SolutionId int,
	@BasePrice int,
	@GovPrice int,
	@SpcPrice int,
	@Days int,
	@SpcDays int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    -- Insert statements for procedure here
	UPDATE Solutions SET BasePrice = @BasePrice,
		GovPrice = @GovPrice,
		SpcPrice = @SpcPrice,
		Days = @Days,
		SpcDays = @SpcDays
	WHERE AreaId = @AreaId AND SolutionId = @SolutionId
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateUserAccount]    Script Date: 2017/12/9 0:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateUserAccount]
	-- Add the parameters for the stored procedure here
	@UserId int,
	@WechatId varchar(60),
	@Mobile varchar(30)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE Users set WechatId = @WechatId, Mobile = @Mobile where UserId = @UserId;
end

GO
