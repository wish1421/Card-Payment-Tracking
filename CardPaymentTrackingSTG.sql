USE [CardPaymentTrackingSTG]
GO

/****************** Create Table [dbo].[region] ********************/
CREATE TABLE [dbo].[region](
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

CREATE TABLE [dbo].[category](
	[category_no] [int] NOT NULL,
	[category_desc] [varchar](31) NOT NULL,
 CONSTRAINT [category_ident] PRIMARY KEY CLUSTERED 
(
	[category_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****************** Create Table [dbo].[corporation] ********************/
CREATE TABLE [dbo].[corporation](
	[corp_id] [int] NOT NULL,
	[corp_no] [int] NOT NULL,
	[corp_name] [varchar](31) NOT NULL,
	[expr_dt] [datetime] NOT NULL,
	[region_no] [int] NOT NULL,
 CONSTRAINT [corporation_ident] PRIMARY KEY CLUSTERED 
(
	[corp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****************** Create Table [dbo].[member] ********************/
CREATE TABLE [dbo].[member](
	[member_id] [int] NOT NULL,
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
 CONSTRAINT [member_ident] PRIMARY KEY CLUSTERED 
(
	[member_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****************** Create Table [dbo].[provider] ********************/
CREATE TABLE [dbo].[provider](
	[provider_id] [int] NOT NULL,
	[provider_no] [int] NOT NULL,
	[provider_name] [varchar](15) NOT NULL,
	[issue_dt] [datetime] NOT NULL,
	[expr_dt] [datetime] NOT NULL,
	[region_no] [int] NOT NULL,
 CONSTRAINT [provider_ident] PRIMARY KEY CLUSTERED 
(
	[provider_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****************** Create Table [dbo].[charge] ********************/
CREATE TABLE [dbo].[charge](
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