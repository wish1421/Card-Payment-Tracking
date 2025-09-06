USE [CardPaymentTrackingDW]
GO

/****** Object:  Table [dbo].[D_date]    Script Date: 04/21/2024 10:15:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[D_date](
	[date] [date] NOT NULL,
	[year]  AS (datepart(year,[Date])),
	[semester]  AS (CONVERT([varchar](4),datepart(year,[Date]),(0))+case when datepart(month,[Date])>(6) then '2' else '1' end),
	[quarter]  AS (CONVERT([varchar](4),datepart(year,[Date]),(0))+datename(quarter,[Date])),
	[month]  AS (datepart(month,[Date])),
	[month_name]  AS (upper(substring(datename(month,[Date]),(1),(1)))+substring(datename(month,[Date]),(2),len(datename(month,[Date])))),
	[week]  AS ((CONVERT([varchar](4),datepart(year,[Date]),(0))+replicate('0',(2)-len(datepart(week,[Date]))))+CONVERT([nvarchar](2),datepart(week,[Date]),(0))),
	[day]  AS (datepart(day,[Date])),
	[day_of_week]  AS (datename(weekday,[Date])),
	[day_of_year]  AS (datename(dayofyear,[Date])),
	[is_public_holiday] [char](3) NULL,
	[fiscal_week] [int] NULL,
 CONSTRAINT [PK_D_Date] PRIMARY KEY CLUSTERED 
(
	[date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Fill Date    Script Date: 04/21/2024 10:17:10 ******/

declare @d date
set @d='2018-01-01'
while @d<='2023-12-31'
begin
--select @d
insert into D_Date(Date) values (@d)
set @d=dateadd(dd,1,@d)
end

/****** Object:  Table [dbo].[D_category]    Script Date: 04/21/2024 10:15:59 ******/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[D_category](
	[category_no] [int] NOT NULL,
	[category_desc] [varchar](31) NOT NULL,
 CONSTRAINT [category_ident] PRIMARY KEY CLUSTERED 
(
	[category_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[D_region]    Script Date: 04/21/2024 10:17:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[D_region](
	[region_no] [int] NOT NULL,
	[region_name] [varchar](15) NOT NULL,
	[street] [varchar](15) NOT NULL,
	[city] [varchar](15) NOT NULL,
	[state_prov] [char](2) NOT NULL,
	[country] [char](2) NOT NULL,
 CONSTRAINT [region_ident] PRIMARY KEY CLUSTERED 
(
	[region_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[D_corporation]    Script Date: 04/21/2024 10:16:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[D_corporation](
	[corp_id] [int] IDENTITY(1,1) NOT NULL,
	[corp_no] [int] NOT NULL,
	[corp_name] [varchar](31) NOT NULL,
	[expr_dt] [datetime] NOT NULL,
	[region_no] [int] NOT NULL,
	[flag] [int] NULL,
 CONSTRAINT [corporation_ident] PRIMARY KEY CLUSTERED 
(
	[corp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[D_member]    Script Date: 04/21/2024 10:17:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[D_member](
	[member_id] [int] IDENTITY(1,1) NOT NULL,
	[member_no] [int] NOT NULL,
	[lastname] [varchar](15) NOT NULL,
	[firstname] [varchar](15) NOT NULL,
	[issue_dt] [datetime] NOT NULL,
	[expr_dt] [datetime] NOT NULL,
	[region_no] [int] NOT NULL,
	[corp_id] [int] NULL,
	[prev_balance] [money] NULL,
	[curr_balance] [money] NULL,
	[gender] [char](5) NULL,
	[flag] [int] NULL,
 CONSTRAINT [member_ident] PRIMARY KEY CLUSTERED 
(
	[member_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[D_provider]    Script Date: 04/21/2024 10:18:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[D_provider](
	[provider_id] [int] IDENTITY(1,1) NOT NULL,
	[provider_no] [int] NOT NULL,
	[provider_name] [varchar](15) NOT NULL,
	[issue_dt] [datetime] NOT NULL,
	[expr_dt] [datetime] NOT NULL,
	[region_no] [int] NOT NULL,
	[flag] [int] NULL,
 CONSTRAINT [provider_ident] PRIMARY KEY CLUSTERED 
(
	[provider_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[F_charge]    Script Date: 04/21/2024 10:18:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[F_charge](
	[member_id] [int] NOT NULL,
	[provider_id] [int] NOT NULL,
	[category_no] [int] NOT NULL,
	[charge_dt] [date] NOT NULL,
	[total_charge_amt] [money] NOT NULL,
	[charge_count] [int] NOT NULL,
 CONSTRAINT [PK_F_Payment] PRIMARY KEY CLUSTERED 
(
	[member_id] ASC,
	[provider_id] ASC,
	[charge_dt] ASC,
	[category_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Constraints    Script Date: 04/21/2024 10:17:10 ******/

ALTER TABLE [dbo].[D_corporation]  WITH CHECK ADD  CONSTRAINT [FK_D_corporation_D_region] FOREIGN KEY([region_no])
REFERENCES [dbo].[D_region] ([region_no])
GO

ALTER TABLE [dbo].[D_corporation] CHECK CONSTRAINT [FK_D_corporation_D_region]
GO

ALTER TABLE [dbo].[D_member]  WITH CHECK ADD  CONSTRAINT [FK_D_member_D_corporation] FOREIGN KEY([corp_id])
REFERENCES [dbo].[D_corporation] ([corp_id])
GO

ALTER TABLE [dbo].[D_member] CHECK CONSTRAINT [FK_D_member_D_corporation]
GO

ALTER TABLE [dbo].[D_member]  WITH CHECK ADD  CONSTRAINT [FK_D_member_D_region] FOREIGN KEY([region_no])
REFERENCES [dbo].[D_region] ([region_no])
GO

ALTER TABLE [dbo].[D_member] CHECK CONSTRAINT [FK_D_member_D_region]
GO

ALTER TABLE [dbo].[D_provider]  WITH CHECK ADD  CONSTRAINT [FK_D_provider_D_region] FOREIGN KEY([region_no])
REFERENCES [dbo].[D_region] ([region_no])
GO

ALTER TABLE [dbo].[D_provider] CHECK CONSTRAINT [FK_D_provider_D_region]
GO

ALTER TABLE [dbo].[F_charge]  WITH CHECK ADD  CONSTRAINT [FK_F_charge_D_category] FOREIGN KEY([category_no])
REFERENCES [dbo].[D_category] ([category_no])
GO

ALTER TABLE [dbo].[F_charge] CHECK CONSTRAINT [FK_F_charge_D_category]
GO

ALTER TABLE [dbo].[F_charge]  WITH CHECK ADD  CONSTRAINT [FK_F_charge_D_date1] FOREIGN KEY([charge_dt])
REFERENCES [dbo].[D_date] ([date])
GO

ALTER TABLE [dbo].[F_charge] CHECK CONSTRAINT [FK_F_charge_D_date1]
GO

ALTER TABLE [dbo].[F_charge]  WITH CHECK ADD  CONSTRAINT [FK_F_charge_D_member] FOREIGN KEY([member_id])
REFERENCES [dbo].[D_member] ([member_id])
GO

ALTER TABLE [dbo].[F_charge] CHECK CONSTRAINT [FK_F_charge_D_member]
GO

ALTER TABLE [dbo].[F_charge]  WITH CHECK ADD  CONSTRAINT [FK_F_charge_D_provider] FOREIGN KEY([provider_id])
REFERENCES [dbo].[D_provider] ([provider_id])
GO

ALTER TABLE [dbo].[F_charge] CHECK CONSTRAINT [FK_F_charge_D_provider]
GO


