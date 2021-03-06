USE [master]
GO
/****** Object:  Database [Data_And_Web_SS19]    Script Date: 23-06-2019 11:01:36 ******/
CREATE DATABASE [Data_And_Web_SS19]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Data_And__Web_SS19', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\Data_And__Web_SS19.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Data_And__Web_SS19_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\Data_And__Web_SS19_log.ldf' , SIZE = 2560KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Data_And_Web_SS19] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Data_And_Web_SS19].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Data_And_Web_SS19] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Data_And_Web_SS19] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Data_And_Web_SS19] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Data_And_Web_SS19] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Data_And_Web_SS19] SET ARITHABORT OFF 
GO
ALTER DATABASE [Data_And_Web_SS19] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Data_And_Web_SS19] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Data_And_Web_SS19] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Data_And_Web_SS19] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Data_And_Web_SS19] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Data_And_Web_SS19] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Data_And_Web_SS19] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Data_And_Web_SS19] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Data_And_Web_SS19] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Data_And_Web_SS19] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Data_And_Web_SS19] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Data_And_Web_SS19] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Data_And_Web_SS19] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Data_And_Web_SS19] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Data_And_Web_SS19] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Data_And_Web_SS19] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Data_And_Web_SS19] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Data_And_Web_SS19] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Data_And_Web_SS19] SET  MULTI_USER 
GO
ALTER DATABASE [Data_And_Web_SS19] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Data_And_Web_SS19] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Data_And_Web_SS19] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Data_And_Web_SS19] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Data_And_Web_SS19] SET DELAYED_DURABILITY = DISABLED 
GO
USE [Data_And_Web_SS19]
GO
/****** Object:  Table [dbo].[TBL_WEB_FEED]    Script Date: 23-06-2019 11:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_WEB_FEED](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[TITLE] [nvarchar](255) NULL,
	[PUBLISH_TIME] [datetime] NULL,
	[DB_ENTRY_TIME] [datetime] NULL DEFAULT (getdate()),
	[URL] [nvarchar](255) NULL,
	[PROVIDER] [varchar](255) NULL,
	[VOTE] [int] NULL,
	[ACTIVE_IND] [int] NULL CONSTRAINT [ACTIVE_IND_DF]  DEFAULT ((1)),
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TBL_WEB_FEED_REFRESH]    Script Date: 23-06-2019 11:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_WEB_FEED_REFRESH](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[REFRESH_TIME] [datetime] NULL DEFAULT (getdate()),
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TBL_WEB_FEED_REPLICA]    Script Date: 23-06-2019 11:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TBL_WEB_FEED_REPLICA](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[TITLE] [nvarchar](255) NULL,
	[PUBLISH_TIME] [datetime] NULL,
	[DB_ENTRY_TIME] [datetime] NULL,
	[URL] [nvarchar](255) NULL,
	[PROVIDER] [varchar](255) NULL,
	[VOTE] [int] NULL,
	[ACTIVE_IND] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[WEB_FEED_PROVIDERS]    Script Date: 23-06-2019 11:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WEB_FEED_PROVIDERS](
	[PROVIDER_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[PROVIDER_NAME] [varchar](255) NOT NULL,
	[PROVIDER_URL] [varchar](255) NULL,
	[ACTIVE_IND] [int] NULL DEFAULT ((1)),
	[ACTIVITY_DT_TM] [datetime] NULL DEFAULT (getdate()),
	[FEED_COUNT] [bigint] NULL CONSTRAINT [DF_FEED_COUNT]  DEFAULT ((0)),
	[LAST_REFRESH_TIME] [datetime] NULL,
	[PREVIOUS_FETCH_COUNT] [bigint] NULL DEFAULT ((0)),
	[NEW_FETCH_COUNT] [bigint] NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[PROVIDER_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[TBL_WEB_FEED] ON 

INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (4704, N'Anna  2019', CAST(N'2019-06-19 14:28:16.000' AS DateTime), CAST(N'2019-06-19 16:37:14.433' AS DateTime), N'http://www.fandango.com/anna2019_218458/movieoverview?wssaffid=11840&wssac=123', N'Fandango Movies', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (4705, N'Child s Play  2019', CAST(N'2019-06-19 14:28:15.000' AS DateTime), CAST(N'2019-06-19 16:37:14.433' AS DateTime), N'http://www.fandango.com/childsplay2019_217181/movieoverview?wssaffid=11840&wssac=123', N'Fandango Movies', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (4706, N'Toy Story 4', CAST(N'2019-06-19 14:28:14.000' AS DateTime), CAST(N'2019-06-19 16:37:14.433' AS DateTime), N'http://www.fandango.com/toystory4_185803/movieoverview?wssaffid=11840&wssac=123', N'Fandango Movies', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (4707, N'Wild Rose  2019', CAST(N'2019-06-19 14:28:13.000' AS DateTime), CAST(N'2019-06-19 16:37:14.433' AS DateTime), N'http://www.fandango.com/wildrose2019_214406/movieoverview?wssaffid=11840&wssac=123', N'Fandango Movies', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (4708, N'Burn Your Maps', CAST(N'2019-06-19 14:28:12.000' AS DateTime), CAST(N'2019-06-19 16:37:14.433' AS DateTime), N'http://www.fandango.com/burnyourmaps_198049/movieoverview?wssaffid=11840&wssac=123', N'Fandango Movies', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (4709, N'Round of Your Life', CAST(N'2019-06-19 14:28:11.000' AS DateTime), CAST(N'2019-06-19 16:37:14.433' AS DateTime), N'http://www.fandango.com/roundofyourlife_218984/movieoverview?wssaffid=11840&wssac=123', N'Fandango Movies', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (4710, N'Swinging Safari', CAST(N'2019-06-19 14:28:10.000' AS DateTime), CAST(N'2019-06-19 16:37:14.433' AS DateTime), N'http://www.fandango.com/swingingsafari_218826/movieoverview?wssaffid=11840&wssac=123', N'Fandango Movies', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (4711, N'Toni Morrison: The Pieces I Am', CAST(N'2019-06-19 14:28:09.000' AS DateTime), CAST(N'2019-06-19 16:37:14.433' AS DateTime), N'http://www.fandango.com/tonimorrison:thepiecesiam_217664/movieoverview?wssaffid=11840&wssac=123', N'Fandango Movies', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11038, N'The Real Reason Pet Sematary Changed Its Ending', CAST(N'2019-06-21 22:26:52.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475428/the-real-reason-pet-sematary-changed-its-ending', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11039, N'Fox And Disney Have Been Hit With More Layoffs', CAST(N'2019-06-21 21:35:05.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475423/fox-and-disney-have-been-hit-with-more-layoffs', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11040, N'12 Pixar Easter Eggs And References In Toy Story 4', CAST(N'2019-06-21 21:29:45.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475226/12-pixar-easter-eggs-and-references-in-toy-story-4', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11041, N'Russell Crowe Says ‘There’s No Way’ He Could Have Played Wolverine Like Hugh Jackman', CAST(N'2019-06-21 21:26:23.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475427/russell-crowe-says-theres-no-way-he-could-have-played-wolverine-like-hugh-jackman', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11042, N'To 3D Or Not To 3D: Buy The Right Toy Story 4 Ticket', CAST(N'2019-06-21 20:53:55.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475422/to-3d-or-not-to-3d-buy-the-right-toy-story-4-ticket', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11043, N'The Red Sonja Movie Is Back On, Without Bryan Singer', CAST(N'2019-06-21 20:20:44.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475410/the-red-sonja-movie-is-back-on-without-bryan-singer', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11044, N'ReelBlend #73: Spider Man Reactions And Our Favorite Movies Of 2019  So Far', CAST(N'2019-06-21 19:59:25.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/podcast/2475421/reelblend-73-spider-man-reactions-and-our-favorite-movies-of-2019-so-far', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11045, N'New Lion King TV Spot Has Beyonce And Donald Glover Singing ‘Can You Feel The Love Tonight ’', CAST(N'2019-06-21 19:48:28.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475418/new-lion-king-tv-spot-has-beyonce-and-donald-glover-singing-can-you-feel-the-love-tonight', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11046, N'The Beautiful Way Jim Henson Recorded Rainbow Connection For The Muppet Movie', CAST(N'2019-06-21 19:40:53.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475409/the-beautiful-way-jim-henson-recorded-rainbow-connection-for-the-muppet-movie', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11047, N'Sylvester Stallone s Most Badass Movies, Ranked', CAST(N'2019-06-21 19:33:49.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475396/sylvester-stallones-most-badass-movies-ranked', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11048, N'Michelle Pfeiffer Could Have Joined The Batman Franchise Much Earlier', CAST(N'2019-06-21 19:10:57.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475411/michelle-pfeiffer-could-have-joined-the-batman-franchise-much-earlier', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11049, N'Robert Pattinson Should Be The Next James Bond, According To Danny Boyle', CAST(N'2019-06-21 18:52:10.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475406/robert-pattinson-should-be-the-next-james-bond-according-to-danny-boyle', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11050, N'Yes, Toy Story 4 Has End Credits Scenes, And They re Even More Delightful Than The Movie', CAST(N'2019-06-21 18:49:14.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475405/yes-toy-story-4-has-end-credits-scenes-and-theyre-even-more-delightful-than-the-movie', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11051, N'Why Tommy Lee Jones And Will Smith Don t Show Up In Men In Black International', CAST(N'2019-06-21 18:25:49.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475404/why-tommy-lee-jones-and-will-smith-dont-show-up-in-men-in-black-international', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11052, N'Production On Anne Hathaway s Movie Has Already Resumed After Reported Stabbing On Set', CAST(N'2019-06-21 18:14:53.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475403/production-on-anne-hathaways-movie-has-already-resumed-after-reported-stabbing-on-set', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11053, N'Captain Marvel Directors Have Explained The Big Skrull Twist', CAST(N'2019-06-21 17:39:50.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475400/captain-marvel-directors-have-explained-the-big-skrull-twist', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11054, N'Toy Story 4 Had An Incredible Preview Night, But Didn t Best One Other Animated Movie', CAST(N'2019-06-21 17:15:25.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475399/toy-story-4-had-an-incredible-preview-night-but-didnt-best-one-other-animated-movie', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11055, N'14 Fictional Movie Locations We d Love To Visit', CAST(N'2019-06-21 17:08:14.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475387/14-fictional-movie-locations-wed-love-to-visit', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11056, N'Keri Russell Had An Emotional Reaction To J J  Abrams’s Star Wars: The Rise Of Skywalker Script', CAST(N'2019-06-21 16:51:57.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475392/keri-russell-had-an-emotional-reaction-to-jj-abramss-star-wars-the-rise-of-skywalker-script', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11057, N'5 Great Musical Biopics You Need To See After Bohemian Rhapsody And Rocketman', CAST(N'2019-06-21 16:41:15.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475339/5-great-musical-biopics-you-need-to-see-after-bohemian-rhapsody-and-rocketman', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11058, N'Apparently Dark Phoenix Is Already Leaving A Lot Of Theaters', CAST(N'2019-06-21 15:50:37.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475391/apparently-dark-phoenix-is-already-leaving-a-lot-of-theaters', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11059, N'Why Are So Many Of The X Men Blue', CAST(N'2019-06-21 15:38:32.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475358/why-are-so-many-of-the-x-men-blue', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11060, N'Bond 25 Director Cary Fukunaga Responds To Set Issue Rumors', CAST(N'2019-06-21 15:30:47.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475384/bond-25-director-cary-fukunaga-responds-to-set-issue-rumors', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11061, N'A Spider Man: Into The Spider Verse Sequel Is Actually Happening    Or Is It', CAST(N'2019-06-21 14:41:18.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475386/a-spider-man-into-the-spider-verse-sequel-is-actually-happening-or-is-it', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11062, N'Bill And Ted Face The Music Writer Shares New Photo That s An Excellent Nod To The First Movie', CAST(N'2019-06-21 14:06:57.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475369/bill-and-ted-face-the-music-writer-shares-new-photo-thats-an-excellent-nod-to-the-first-movie', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11063, N'Why Child’s Play’s Director Was An Intimidating Presence On Set… In A Good Way', CAST(N'2019-06-21 10:48:43.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475367/why-childs-plays-director-was-an-intimidating-presence-on-set-in-a-good-way', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11064, N'Why Tom Holland Really Wants A Spider Man And Doctor Strange Team Up Movie', CAST(N'2019-06-21 00:22:15.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475362/why-tom-holland-really-wants-a-spider-man-and-doctor-strange-team-up-movie', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11065, N'Space Jam 2 Has Reportedly Assembled Its Basketball Player Lineup', CAST(N'2019-06-20 22:40:23.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475342/space-jam-2-has-reportedly-assembled-its-basketball-player-lineup', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11066, N'Netflix’s Murder Mystery Might Have Made A Ton Of Money In Theaters', CAST(N'2019-06-20 22:14:40.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475356/netflixs-murder-mystery-might-have-made-a-ton-of-money-in-theaters', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11067, N'The Batman: Would Macaulay Culkin Make A Good Joker', CAST(N'2019-06-20 22:04:47.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475314/the-batman-would-macaulay-culkin-make-a-good-joker', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11068, N'Trolls World Tour Trailer: Justin Timberlake And Anna Kendrick Are Back', CAST(N'2019-06-20 21:03:58.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475350/trolls-world-tour-trailer-justin-timberlake-and-anna-kendrick-are-back', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11069, N'Dark Phoenix Producer Hasn’t Seen The Movie Either', CAST(N'2019-06-20 21:03:13.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475348/dark-phoenix-producer-hasnt-seen-the-movie-either', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11070, N'Jordan Peele Shut Down A Popular Us Fan Theory', CAST(N'2019-06-20 20:06:22.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475341/jordan-peele-shut-down-a-popular-us-fan-theory', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11071, N'10 Underrated Netflix Movies You Really Need To See', CAST(N'2019-06-20 19:42:54.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475335/10-underrated-netflix-movies-you-really-need-to-see', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11072, N'Bad Trip Red Band Trailer: Eric Andre Brings Prank Movies Back In A Big Way', CAST(N'2019-06-20 19:22:19.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475338/bad-trip-red-band-trailer-eric-andre-brings-prank-movies-back-in-a-big-way', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11073, N'Zack Snyder Seemingly Gives Robert Pattinson s Batman His Approval', CAST(N'2019-06-20 18:37:50.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475331/zack-snyder-seemingly-gives-robert-pattinsons-batman-his-approval', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11074, N'Looks Like Halloween 2 Is Actually Happening', CAST(N'2019-06-20 18:22:48.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475334/looks-like-halloween-2-is-actually-happening', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11075, N'Extremely Wicked: How Accurate Was Zac Efron s Ted Bundy Biopic', CAST(N'2019-06-20 18:08:07.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475321/extremely-wicked-how-accurate-was-zac-efrons-ted-bundy-biopic', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11076, N'Disney World Raises Annual Pass Prices Ahead Of Star Wars Galaxy s Edge', CAST(N'2019-06-20 17:56:58.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475295/disney-world-raises-annual-pass-prices-ahead-of-star-wars-galaxys-edge', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11077, N'Rami Malek Breaks Silence About Rumored Bond 25 Set Issues', CAST(N'2019-06-20 17:25:09.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475326/rami-malek-breaks-silence-about-rumored-bond-25-set-issues', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11078, N'People Are Raving About Spider Man Far From Home s Post Credits Scenes', CAST(N'2019-06-20 17:17:07.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475324/people-are-raving-about-spider-man-far-from-homes-post-credits-scenes', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11079, N'Child’s Play Reviews Are Up, See What Critics Are Saying', CAST(N'2019-06-20 17:00:32.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475320/childs-play-reviews-are-up-see-what-critics-are-saying', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11080, N'Why Toy Story 4 s Female Focus Is So Important, According To Christina Hendricks', CAST(N'2019-06-20 17:00:01.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475323/why-toy-story-4s-female-focus-is-so-important-according-to-christina-hendricks', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11081, N'Neo Vs John Wick: Comparing The Matrix And John Wick Movies', CAST(N'2019-06-20 16:49:21.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475305/neo-vs-john-wick-comparing-the-matrix-and-john-wick-movies', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11082, N'Why Avatar: The Last Airbender Deserves Another Movie', CAST(N'2019-06-20 16:22:34.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475104/why-avatar-the-last-airbender-deserves-another-movie', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11083, N'Dwayne Johnson Clarifies Keanu Reeves Is Not In Hobbs And Shaw', CAST(N'2019-06-20 16:22:16.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475317/dwayne-johnson-clarifies-keanu-reeves-is-not-in-hobbs-and-shaw', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11084, N'Point Blank Trailer Pits Marvel Vets Anthony Mackie And Frank Grillo Against The Cops', CAST(N'2019-06-20 15:30:00.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475316/point-blank-trailer-pits-marvel-vets-anthony-mackie-and-frank-grillo-against-the-cops', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11085, N'Kevin Feige Explains Marvel’s Approach To The Black Widow Prequel Movie', CAST(N'2019-06-20 15:11:10.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475309/kevin-feige-explains-marvels-approach-to-the-black-widow-prequel-movie', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11086, N'Yes, Kevin Feige Has Been Thinking About How Marvel Will Bring Mutants To The MCU', CAST(N'2019-06-20 15:10:02.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475308/yes-kevin-feige-has-been-thinking-about-how-marvel-will-bring-mutants-to-the-mcu', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11087, N'Yes, Bo Peep Was Always Going To Be In Toy Story 4', CAST(N'2019-06-20 14:57:41.000' AS DateTime), CAST(N'2019-06-22 00:35:55.770' AS DateTime), N'https://www.cinemablend.com/news/2475311/yes-bo-peep-was-always-going-to-be-in-toy-story-4', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11367, N'Child s Play', CAST(N'2019-06-21 14:55:00.000' AS DateTime), CAST(N'2019-06-22 00:37:25.367' AS DateTime), N'https://www.rogerebert.com/reviews/childs-play-2019', N'Rogerebert', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11368, N'Toy Story 4', CAST(N'2019-06-21 13:34:00.000' AS DateTime), CAST(N'2019-06-22 00:37:25.367' AS DateTime), N'https://www.rogerebert.com/reviews/toy-story-4-2019', N'Rogerebert', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11369, N'If I Had an Emmy Ballot 2019', CAST(N'2019-06-21 13:33:03.000' AS DateTime), CAST(N'2019-06-22 00:37:25.367' AS DateTime), N'https://www.rogerebert.com/demanders/if-i-had-an-emmy-ballot-2019', N'Rogerebert', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11370, N'Cinepocalypse 2019: Into the Dark: Culture Shock', CAST(N'2019-06-21 13:25:16.000' AS DateTime), CAST(N'2019-06-22 00:37:25.367' AS DateTime), N'https://www.rogerebert.com/festivals-and-awards/cinepocalypse-2019-into-the-dark-culture-shock', N'Rogerebert', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11371, N'Anna', CAST(N'2019-06-21 13:24:57.000' AS DateTime), CAST(N'2019-06-22 00:37:25.367' AS DateTime), N'https://www.rogerebert.com/reviews/anna-2019', N'Rogerebert', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11372, N'Wild Rose', CAST(N'2019-06-21 13:21:21.000' AS DateTime), CAST(N'2019-06-22 00:37:25.367' AS DateTime), N'https://www.rogerebert.com/reviews/wild-rose-2019', N'Rogerebert', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11373, N'Toni Morrison: The Pieces I Am', CAST(N'2019-06-21 13:21:11.000' AS DateTime), CAST(N'2019-06-22 00:37:25.367' AS DateTime), N'https://www.rogerebert.com/reviews/toni-morrison-the-pieces-i-am-2019', N'Rogerebert', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11374, N'A Bigger Splash', CAST(N'2019-06-21 13:20:59.000' AS DateTime), CAST(N'2019-06-22 00:37:25.367' AS DateTime), N'https://www.rogerebert.com/reviews/a-bigger-splash-2019', N'Rogerebert', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11375, N'Burn Your Maps', CAST(N'2019-06-21 13:20:49.000' AS DateTime), CAST(N'2019-06-22 00:37:25.367' AS DateTime), N'https://www.rogerebert.com/reviews/burn-your-maps-2019', N'Rogerebert', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (11376, N'Nightmare Cinema', CAST(N'2019-06-21 13:20:25.000' AS DateTime), CAST(N'2019-06-22 00:37:25.367' AS DateTime), N'https://www.rogerebert.com/reviews/nightmare-cinema-2019', N'Rogerebert', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (12783, N'The Craft Remake Has Found Its Lead Actress', CAST(N'2019-06-21 23:12:58.000' AS DateTime), CAST(N'2019-06-22 01:13:01.760' AS DateTime), N'https://www.cinemablend.com/news/2475430/the-craft-remake-has-found-its-lead-actress', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (13789, N'Will James Wan Direct Another Conjuring Universe Movie  Here’s What The Director Says', CAST(N'2019-06-21 23:30:40.000' AS DateTime), CAST(N'2019-06-22 01:40:11.950' AS DateTime), N'https://www.cinemablend.com/news/2475432/will-james-wan-direct-another-conjuring-universe-movie-heres-what-the-director-says', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (14818, N'Apparently There’s A Howard The Duck Easter Egg In Spider Man: Homecoming', CAST(N'2019-06-22 01:24:49.000' AS DateTime), CAST(N'2019-06-22 09:18:07.970' AS DateTime), N'https://www.cinemablend.com/news/2475435/apparently-theres-a-howard-the-duck-easter-egg-in-spider-man-homecoming', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (14819, N'Zack Snyder Reveals Another Green Lantern Hint That Would Have Been In His Justice League', CAST(N'2019-06-22 00:46:31.000' AS DateTime), CAST(N'2019-06-22 09:18:07.970' AS DateTime), N'https://www.cinemablend.com/news/2475434/zack-snyder-reveals-another-green-lantern-hint-that-would-have-been-in-his-justice-league', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (14820, N'A Quiet Place 2 Has Quietly Moved Into Production  Fitting, No', CAST(N'2019-06-22 00:21:25.000' AS DateTime), CAST(N'2019-06-22 09:18:07.970' AS DateTime), N'https://www.cinemablend.com/news/2475433/a-quiet-place-2-has-quietly-moved-into-production-fitting-no', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (17590, N'Pixar Was Worried About Toy Story 4’s Ending Until Tim Allen Read It', CAST(N'2019-06-22 13:04:02.000' AS DateTime), CAST(N'2019-06-22 15:21:08.920' AS DateTime), N'https://www.cinemablend.com/news/2475351/pixar-was-worried-about-toy-story-4s-ending-until-tim-allen-read-it', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (18021, N'That Time Men In Black Had Less Will Smith, But More Tommy Lee Jones Calling Writer An A Hole', CAST(N'2019-06-22 14:41:52.000' AS DateTime), CAST(N'2019-06-22 16:59:28.597' AS DateTime), N'https://www.cinemablend.com/news/2475439/that-time-men-in-black-had-less-will-smith-but-more-tommy-lee-jones-calling-writer-an-a-hole', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (18022, N'Kevin Feige Defends How Avengers: Endgame Handled Marvel s First Openly Gay Character', CAST(N'2019-06-22 14:08:24.000' AS DateTime), CAST(N'2019-06-22 16:59:28.597' AS DateTime), N'https://www.cinemablend.com/news/2475438/kevin-feige-defends-how-avengers-endgame-handled-marvels-first-openly-gay-character', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (18100, N'Jon Watts Still Isn t Sure How Tom Holland s Spider Man Trilogy Will End', CAST(N'2019-06-22 17:05:18.000' AS DateTime), CAST(N'2019-06-22 19:43:30.830' AS DateTime), N'https://www.cinemablend.com/news/2475444/jon-watts-still-isnt-sure-how-tom-hollands-spider-man-trilogy-will-end', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (18101, N'Mark Hamill Confirms The  Peculiar  Way Luke Returns For Star Wars: The Rise Of Skywalker', CAST(N'2019-06-22 16:26:52.000' AS DateTime), CAST(N'2019-06-22 19:43:30.830' AS DateTime), N'https://www.cinemablend.com/news/2475441/mark-hamill-confirms-the-peculiar-way-luke-returns-for-star-wars-the-rise-of-skywalker', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (18102, N'J J  Abrams  Superman: Flyby Storyboards Revealed, Thanks To Spider Man: Into The Spider Verse Director', CAST(N'2019-06-22 15:49:42.000' AS DateTime), CAST(N'2019-06-22 19:43:30.830' AS DateTime), N'https://www.cinemablend.com/news/2475440/jj-abrams-superman-flyby-storyboards-revealed-thanks-to-spider-man-into-the-spider-verse-director', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (18178, N'The Main Differences Between The Original And New Child’s Play Movies', CAST(N'2019-06-22 17:53:31.000' AS DateTime), CAST(N'2019-06-22 20:02:58.773' AS DateTime), N'https://www.cinemablend.com/news/2475443/the-main-differences-between-the-original-and-new-childs-play-movies', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (18237, N'The Month in Movies: What s in Theaters This June', CAST(N'2019-05-30 00:23:28.000' AS DateTime), CAST(N'2019-06-23 00:59:32.570' AS DateTime), N'http://www.movies.com/movie-news/month-movies-what39s-theaters-this-june/24243?wssac=164&wssaffid=news', N'Movies.com', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (18238, N'Sounds Like Ezra Miller s The Flash Movie Will Film After Fantastic Beasts', CAST(N'2019-06-22 22:36:04.000' AS DateTime), CAST(N'2019-06-23 00:59:32.570' AS DateTime), N'https://www.cinemablend.com/news/2475451/sounds-like-ezra-millers-the-flash-movie-will-film-after-fantastic-beasts', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (18239, N'Why Venom Was Such A Massive Hit, According To Amy Pascal', CAST(N'2019-06-22 20:34:25.000' AS DateTime), CAST(N'2019-06-23 00:59:32.570' AS DateTime), N'https://www.cinemablend.com/news/2475449/why-venom-was-such-a-massive-hit-according-to-amy-pascal', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (18240, N'Watch Keanu Reeves Reject A Speed Joke In Netflix s Always Be My Maybe Bloopers', CAST(N'2019-06-22 18:56:16.000' AS DateTime), CAST(N'2019-06-23 00:59:32.570' AS DateTime), N'https://www.cinemablend.com/news/2475447/watch-keanu-reeves-reject-a-speed-joke-in-netflixs-always-be-my-maybe-bloopers', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (18241, N'Watch Michael Keaton Pull A Tom Holland By Spoiling Batman Right Before It Opened', CAST(N'2019-06-22 18:44:28.000' AS DateTime), CAST(N'2019-06-23 00:59:32.570' AS DateTime), N'https://www.cinemablend.com/news/2475445/watch-michael-keaton-pull-a-tom-holland-by-spoiling-batman-right-before-it-opened', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (18242, N'Toy Story 4 Is Actually Opening Below Estimates, And This May Explain Why', CAST(N'2019-06-22 18:26:20.000' AS DateTime), CAST(N'2019-06-23 00:59:32.570' AS DateTime), N'https://www.cinemablend.com/news/2475446/toy-story-4-is-actually-opening-below-estimates-and-this-may-explain-why', N'Cinema Blend', 0, 1)
INSERT [dbo].[TBL_WEB_FEED] ([ID], [TITLE], [PUBLISH_TIME], [DB_ENTRY_TIME], [URL], [PROVIDER], [VOTE], [ACTIVE_IND]) VALUES (18392, N'Shadaa', CAST(N'2019-06-17 14:16:20.000' AS DateTime), CAST(N'2019-06-23 01:01:05.263' AS DateTime), N'https://www.kino.de/film/shadaa-2019/', N'Deutsch Kino', 0, 1)
SET IDENTITY_INSERT [dbo].[TBL_WEB_FEED] OFF
SET IDENTITY_INSERT [dbo].[TBL_WEB_FEED_REFRESH] ON 

INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (1, CAST(N'2019-05-25 14:52:12.850' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (2, CAST(N'2019-05-25 14:54:37.133' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (3, CAST(N'2019-05-25 14:56:21.653' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (4, CAST(N'2019-05-25 14:57:12.720' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (5, CAST(N'2019-05-25 14:57:19.030' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (6, CAST(N'2019-05-25 14:58:28.930' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (7, CAST(N'2019-05-25 14:58:32.217' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (8, CAST(N'2019-05-25 15:00:59.613' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (9, CAST(N'2019-05-25 16:31:29.820' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10, CAST(N'2019-05-25 16:57:52.470' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (11, CAST(N'2019-05-25 16:58:03.950' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (12, CAST(N'2019-05-25 17:19:16.770' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (13, CAST(N'2019-05-25 17:19:40.563' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (14, CAST(N'2019-05-25 17:19:56.263' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (15, CAST(N'2019-05-25 17:20:10.507' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (16, CAST(N'2019-05-25 17:20:24.557' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (17, CAST(N'2019-05-25 17:22:18.013' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (18, CAST(N'2019-05-25 17:22:30.723' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (19, CAST(N'2019-05-25 17:22:35.900' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (20, CAST(N'2019-05-25 17:22:58.353' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (21, CAST(N'2019-05-25 17:23:01.137' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (22, CAST(N'2019-05-25 17:23:19.610' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (23, CAST(N'2019-05-25 17:23:28.857' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (24, CAST(N'2019-05-25 17:23:50.667' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (25, CAST(N'2019-05-25 17:40:02.087' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (26, CAST(N'2019-05-25 17:40:34.130' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (27, CAST(N'2019-05-25 22:20:37.997' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (28, CAST(N'2019-05-26 11:02:53.010' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (29, CAST(N'2019-05-26 11:03:49.173' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (30, CAST(N'2019-05-26 11:04:44.780' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (31, CAST(N'2019-05-26 11:04:58.380' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (32, CAST(N'2019-05-26 11:46:25.043' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (33, CAST(N'2019-05-26 14:52:14.137' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (34, CAST(N'2019-05-26 19:52:07.650' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (35, CAST(N'2019-05-28 00:05:49.970' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (36, CAST(N'2019-05-28 10:45:24.067' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (37, CAST(N'2019-05-28 10:57:08.413' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (38, CAST(N'2019-05-28 11:07:37.300' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (39, CAST(N'2019-05-28 14:11:37.550' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (40, CAST(N'2019-05-28 14:14:31.060' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (41, CAST(N'2019-05-28 14:15:47.917' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (42, CAST(N'2019-05-28 14:45:25.793' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (43, CAST(N'2019-05-28 14:56:17.810' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (44, CAST(N'2019-05-28 15:06:32.660' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (45, CAST(N'2019-05-28 15:17:07.910' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (46, CAST(N'2019-05-28 15:27:55.080' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (47, CAST(N'2019-05-28 15:34:10.203' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (48, CAST(N'2019-05-28 15:34:25.187' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (49, CAST(N'2019-05-28 15:34:28.057' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (50, CAST(N'2019-05-28 15:34:57.303' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (51, CAST(N'2019-05-28 15:39:26.190' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (52, CAST(N'2019-05-28 15:39:49.173' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (53, CAST(N'2019-05-28 15:40:11.110' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (54, CAST(N'2019-05-28 16:10:24.260' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (55, CAST(N'2019-05-28 18:00:07.767' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (56, CAST(N'2019-05-28 18:00:29.970' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (57, CAST(N'2019-05-28 18:06:45.690' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (58, CAST(N'2019-05-28 18:07:18.300' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (59, CAST(N'2019-05-28 23:49:56.990' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (60, CAST(N'2019-05-28 23:49:56.990' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (61, CAST(N'2019-05-28 23:51:21.507' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (62, CAST(N'2019-05-28 23:51:52.057' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (63, CAST(N'2019-05-28 23:54:22.387' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (64, CAST(N'2019-05-28 23:59:23.253' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (65, CAST(N'2019-05-29 00:01:22.997' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (66, CAST(N'2019-05-29 09:41:02.100' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (67, CAST(N'2019-05-29 09:42:58.820' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10055, CAST(N'2019-05-29 13:18:54.690' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10056, CAST(N'2019-05-29 13:26:07.070' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10057, CAST(N'2019-05-29 13:26:08.680' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10058, CAST(N'2019-05-29 13:26:35.880' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10059, CAST(N'2019-05-30 01:53:50.723' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10060, CAST(N'2019-05-30 01:58:57.330' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10061, CAST(N'2019-05-30 01:59:18.137' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10062, CAST(N'2019-05-30 09:51:37.260' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10063, CAST(N'2019-05-30 09:52:30.147' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10064, CAST(N'2019-05-30 09:53:07.253' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10065, CAST(N'2019-05-30 09:53:49.120' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10066, CAST(N'2019-05-30 10:12:21.893' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10067, CAST(N'2019-05-30 10:14:12.687' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10068, CAST(N'2019-05-30 10:15:52.743' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10069, CAST(N'2019-05-30 10:16:46.263' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10070, CAST(N'2019-05-30 10:17:18.890' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10071, CAST(N'2019-05-30 10:18:41.187' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10072, CAST(N'2019-05-30 10:18:58.243' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10073, CAST(N'2019-05-30 10:21:27.357' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10074, CAST(N'2019-05-30 10:22:48.767' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10075, CAST(N'2019-05-30 10:24:33.290' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10076, CAST(N'2019-05-30 10:25:22.450' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10077, CAST(N'2019-05-30 10:25:45.347' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10078, CAST(N'2019-05-30 10:28:27.670' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10079, CAST(N'2019-05-30 10:28:50.110' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10080, CAST(N'2019-05-30 10:29:30.880' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10081, CAST(N'2019-05-30 10:29:34.790' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10082, CAST(N'2019-05-30 10:29:39.357' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10083, CAST(N'2019-05-30 10:30:34.477' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10084, CAST(N'2019-05-30 10:32:58.177' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10085, CAST(N'2019-05-30 10:33:36.347' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10086, CAST(N'2019-05-30 10:34:30.760' AS DateTime))
GO
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10087, CAST(N'2019-05-30 10:35:32.730' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10088, CAST(N'2019-05-30 10:36:22.237' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10089, CAST(N'2019-05-30 10:37:20.247' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10090, CAST(N'2019-05-30 10:38:12.347' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10091, CAST(N'2019-05-30 10:43:59.533' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10092, CAST(N'2019-05-30 10:44:52.510' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10093, CAST(N'2019-05-30 11:22:55.173' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10094, CAST(N'2019-05-30 11:23:59.760' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10095, CAST(N'2019-05-30 11:24:35.890' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10096, CAST(N'2019-05-30 19:11:41.897' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10097, CAST(N'2019-05-30 19:13:11.180' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10098, CAST(N'2019-05-30 19:13:35.307' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10099, CAST(N'2019-05-30 20:15:43.493' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10100, CAST(N'2019-05-30 20:16:43.973' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10101, CAST(N'2019-05-30 20:20:10.657' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10102, CAST(N'2019-05-30 21:05:56.977' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10103, CAST(N'2019-05-30 21:07:12.627' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10104, CAST(N'2019-05-30 21:13:37.400' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10105, CAST(N'2019-05-30 21:14:49.587' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10106, CAST(N'2019-05-30 21:16:25.563' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10107, CAST(N'2019-05-30 21:29:39.080' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10108, CAST(N'2019-05-30 21:30:30.810' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10109, CAST(N'2019-05-30 21:30:50.070' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10110, CAST(N'2019-05-30 21:34:01.120' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10111, CAST(N'2019-05-30 21:35:16.420' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10112, CAST(N'2019-05-30 21:36:18.993' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10113, CAST(N'2019-05-30 21:37:11.190' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10114, CAST(N'2019-05-30 22:23:56.140' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10115, CAST(N'2019-06-01 10:31:55.890' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10116, CAST(N'2019-06-01 10:37:39.237' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10117, CAST(N'2019-06-01 10:42:08.407' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10118, CAST(N'2019-06-01 10:46:00.613' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10119, CAST(N'2019-06-01 10:48:52.280' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10120, CAST(N'2019-06-01 10:50:56.417' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10121, CAST(N'2019-06-01 10:52:01.740' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10122, CAST(N'2019-06-01 10:56:20.773' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10123, CAST(N'2019-06-01 15:18:16.260' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10124, CAST(N'2019-06-01 16:09:48.157' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10125, CAST(N'2019-06-01 16:11:45.727' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10126, CAST(N'2019-06-01 16:17:35.090' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10127, CAST(N'2019-06-01 16:18:02.677' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10128, CAST(N'2019-06-01 16:18:19.253' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10129, CAST(N'2019-06-01 16:18:33.210' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10130, CAST(N'2019-06-01 16:18:58.337' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10131, CAST(N'2019-06-01 16:21:33.557' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10132, CAST(N'2019-06-01 16:22:39.117' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10133, CAST(N'2019-06-01 16:24:25.933' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10134, CAST(N'2019-06-01 16:28:04.263' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10135, CAST(N'2019-06-01 16:35:15.747' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10136, CAST(N'2019-06-01 16:38:34.643' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10137, CAST(N'2019-06-01 16:41:18.727' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10138, CAST(N'2019-06-01 16:41:48.500' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10139, CAST(N'2019-06-01 16:42:08.443' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10140, CAST(N'2019-06-01 16:42:52.883' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10141, CAST(N'2019-06-01 16:43:13.853' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10142, CAST(N'2019-06-01 16:45:12.047' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10143, CAST(N'2019-06-01 17:26:38.873' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10144, CAST(N'2019-06-01 20:47:12.573' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10145, CAST(N'2019-06-02 00:30:07.153' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10146, CAST(N'2019-06-02 00:33:17.237' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10147, CAST(N'2019-06-02 00:38:28.180' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10148, CAST(N'2019-06-02 00:40:03.130' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10149, CAST(N'2019-06-02 00:43:48.570' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10150, CAST(N'2019-06-02 00:45:06.650' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10151, CAST(N'2019-06-02 00:45:32.437' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10152, CAST(N'2019-06-02 00:46:43.910' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10153, CAST(N'2019-06-02 00:47:26.357' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10154, CAST(N'2019-06-02 00:47:59.817' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10155, CAST(N'2019-06-02 00:52:32.450' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10156, CAST(N'2019-06-02 00:53:38.683' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10157, CAST(N'2019-06-02 00:55:30.570' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10158, CAST(N'2019-06-02 00:56:32.420' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10159, CAST(N'2019-06-02 01:02:18.477' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10160, CAST(N'2019-06-02 01:04:07.417' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10161, CAST(N'2019-06-02 01:08:56.677' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10162, CAST(N'2019-06-02 01:09:32.997' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10163, CAST(N'2019-06-02 01:12:07.910' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10164, CAST(N'2019-06-02 01:14:49.090' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10165, CAST(N'2019-06-02 01:15:28.987' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10166, CAST(N'2019-06-02 01:16:56.853' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10167, CAST(N'2019-06-02 01:17:29.670' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10168, CAST(N'2019-06-02 01:18:09.240' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10169, CAST(N'2019-06-02 01:19:09.283' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10170, CAST(N'2019-06-02 01:21:04.530' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10171, CAST(N'2019-06-02 01:57:07.577' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10172, CAST(N'2019-06-02 01:58:15.353' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10173, CAST(N'2019-06-02 01:58:49.767' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10174, CAST(N'2019-06-02 01:59:04.417' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10175, CAST(N'2019-06-02 19:35:52.227' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10176, CAST(N'2019-06-02 19:54:59.417' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10177, CAST(N'2019-06-02 19:55:56.930' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10178, CAST(N'2019-06-02 19:58:31.727' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10179, CAST(N'2019-06-02 19:59:39.113' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10180, CAST(N'2019-06-02 20:02:07.530' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10181, CAST(N'2019-06-02 20:02:45.907' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10182, CAST(N'2019-06-02 20:03:42.490' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10183, CAST(N'2019-06-02 20:05:05.917' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10184, CAST(N'2019-06-02 20:07:19.217' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10185, CAST(N'2019-06-02 20:12:08.687' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10186, CAST(N'2019-06-02 20:34:44.517' AS DateTime))
GO
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10187, CAST(N'2019-06-02 21:27:37.600' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10188, CAST(N'2019-06-04 09:28:33.140' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10189, CAST(N'2019-06-04 09:32:11.030' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10190, CAST(N'2019-06-04 09:33:55.740' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10191, CAST(N'2019-06-04 09:44:51.767' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10192, CAST(N'2019-06-04 09:57:12.583' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10193, CAST(N'2019-06-04 09:58:10.197' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10194, CAST(N'2019-06-04 09:58:44.973' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10195, CAST(N'2019-06-04 09:59:07.443' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10196, CAST(N'2019-06-04 15:53:50.710' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10197, CAST(N'2019-06-04 16:19:57.133' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10198, CAST(N'2019-06-04 16:21:22.867' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10199, CAST(N'2019-06-04 16:21:27.790' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10200, CAST(N'2019-06-04 16:21:30.780' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10201, CAST(N'2019-06-04 16:22:13.233' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10202, CAST(N'2019-06-04 16:25:20.580' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10203, CAST(N'2019-06-04 16:26:05.640' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10204, CAST(N'2019-06-05 10:59:25.980' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10205, CAST(N'2019-06-05 11:17:08.530' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10206, CAST(N'2019-06-05 11:33:38.153' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10207, CAST(N'2019-06-05 11:58:50.490' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10208, CAST(N'2019-06-05 12:00:13.010' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10209, CAST(N'2019-06-05 12:01:17.250' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10210, CAST(N'2019-06-05 12:02:39.333' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10211, CAST(N'2019-06-05 12:04:33.520' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10212, CAST(N'2019-06-05 12:06:05.123' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10213, CAST(N'2019-06-05 12:07:09.620' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10214, CAST(N'2019-06-05 12:08:08.877' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10215, CAST(N'2019-06-05 12:08:29.253' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10216, CAST(N'2019-06-05 12:09:34.737' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10217, CAST(N'2019-06-05 12:09:43.320' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10218, CAST(N'2019-06-05 12:11:07.213' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10219, CAST(N'2019-06-05 12:12:33.580' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10220, CAST(N'2019-06-05 12:13:09.493' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10221, CAST(N'2019-06-05 12:13:20.827' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10222, CAST(N'2019-06-05 12:13:42.010' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10223, CAST(N'2019-06-05 12:13:58.727' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10224, CAST(N'2019-06-05 12:14:39.537' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10225, CAST(N'2019-06-05 12:16:23.123' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10226, CAST(N'2019-06-05 12:17:01.323' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10227, CAST(N'2019-06-05 12:18:52.977' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10228, CAST(N'2019-06-05 12:19:13.270' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10229, CAST(N'2019-06-05 13:12:01.620' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10230, CAST(N'2019-06-05 15:47:50.023' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10231, CAST(N'2019-06-06 09:21:28.473' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10232, CAST(N'2019-06-06 22:40:14.940' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10233, CAST(N'2019-06-08 02:16:12.510' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10234, CAST(N'2019-06-08 02:34:01.740' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10235, CAST(N'2019-06-08 02:56:28.353' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10236, CAST(N'2019-06-08 02:57:14.657' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10237, CAST(N'2019-06-08 03:08:47.210' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10238, CAST(N'2019-06-08 09:40:53.737' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10239, CAST(N'2019-06-08 09:56:00.080' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10240, CAST(N'2019-06-08 13:56:37.307' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10241, CAST(N'2019-06-08 14:34:40.997' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10242, CAST(N'2019-06-08 14:35:53.523' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10243, CAST(N'2019-06-08 15:49:22.130' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10244, CAST(N'2019-06-08 20:32:19.393' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10245, CAST(N'2019-06-08 20:32:58.760' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10246, CAST(N'2019-06-09 17:47:41.400' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10247, CAST(N'2019-06-09 17:53:04.920' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10248, CAST(N'2019-06-09 17:55:20.190' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10249, CAST(N'2019-06-09 17:59:55.667' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10250, CAST(N'2019-06-09 18:19:04.893' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10251, CAST(N'2019-06-09 19:23:39.577' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10252, CAST(N'2019-06-09 20:40:12.680' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10253, CAST(N'2019-06-09 23:01:24.250' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10254, CAST(N'2019-06-10 00:04:32.780' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10255, CAST(N'2019-06-10 11:57:19.273' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10256, CAST(N'2019-06-10 19:16:26.860' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10257, CAST(N'2019-06-10 23:42:04.470' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10258, CAST(N'2019-06-10 23:42:28.683' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10259, CAST(N'2019-06-10 23:42:33.040' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10260, CAST(N'2019-06-10 23:42:37.713' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10261, CAST(N'2019-06-10 23:42:42.990' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10262, CAST(N'2019-06-10 23:42:47.820' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10263, CAST(N'2019-06-10 23:42:59.340' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10264, CAST(N'2019-06-10 23:43:00.207' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10265, CAST(N'2019-06-10 23:43:01.157' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10266, CAST(N'2019-06-10 23:43:02.080' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10267, CAST(N'2019-06-10 23:43:02.640' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10268, CAST(N'2019-06-10 23:44:36.583' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10269, CAST(N'2019-06-10 23:45:00.427' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10270, CAST(N'2019-06-10 23:45:05.260' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10271, CAST(N'2019-06-10 23:46:56.167' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10272, CAST(N'2019-06-10 23:48:10.620' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10273, CAST(N'2019-06-10 23:48:58.247' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10274, CAST(N'2019-06-10 23:49:02.560' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10275, CAST(N'2019-06-10 23:49:07.773' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10276, CAST(N'2019-06-10 23:49:18.037' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10277, CAST(N'2019-06-10 23:49:58.343' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10278, CAST(N'2019-06-10 23:50:37.560' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10279, CAST(N'2019-06-10 23:50:44.363' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10280, CAST(N'2019-06-10 23:51:50.010' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10281, CAST(N'2019-06-10 23:51:55.067' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10282, CAST(N'2019-06-10 23:52:50.937' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10283, CAST(N'2019-06-10 23:54:01.800' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10284, CAST(N'2019-06-10 23:54:14.027' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10285, CAST(N'2019-06-10 23:54:58.727' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10286, CAST(N'2019-06-10 23:56:20.707' AS DateTime))
GO
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10287, CAST(N'2019-06-10 23:58:14.720' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10288, CAST(N'2019-06-10 23:58:48.520' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10289, CAST(N'2019-06-11 00:00:22.627' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10290, CAST(N'2019-06-11 00:00:27.170' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10291, CAST(N'2019-06-11 00:00:32.257' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10292, CAST(N'2019-06-11 00:00:37.060' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10293, CAST(N'2019-06-11 00:04:10.683' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10294, CAST(N'2019-06-11 00:04:16.057' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10295, CAST(N'2019-06-11 00:04:22.103' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10296, CAST(N'2019-06-11 00:04:28.190' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10297, CAST(N'2019-06-11 00:05:08.680' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10298, CAST(N'2019-06-11 00:05:14.493' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10299, CAST(N'2019-06-11 00:05:20.590' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10300, CAST(N'2019-06-11 00:05:30.800' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10301, CAST(N'2019-06-11 00:05:30.860' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10302, CAST(N'2019-06-11 00:06:35.827' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10303, CAST(N'2019-06-11 00:06:42.203' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10304, CAST(N'2019-06-11 00:06:48.077' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10305, CAST(N'2019-06-11 00:06:53.597' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10306, CAST(N'2019-06-11 00:06:59.707' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10307, CAST(N'2019-06-11 00:07:05.837' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10308, CAST(N'2019-06-11 00:07:11.930' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10309, CAST(N'2019-06-11 00:07:17.923' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10310, CAST(N'2019-06-11 00:10:06.053' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10311, CAST(N'2019-06-11 00:11:05.200' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10312, CAST(N'2019-06-11 00:12:05.027' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10313, CAST(N'2019-06-11 00:13:05.553' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10314, CAST(N'2019-06-11 00:14:05.213' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10315, CAST(N'2019-06-11 00:15:05.543' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10316, CAST(N'2019-06-11 00:16:05.770' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10317, CAST(N'2019-06-11 00:17:05.107' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10318, CAST(N'2019-06-11 09:01:34.493' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10319, CAST(N'2019-06-11 10:20:31.177' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10320, CAST(N'2019-06-11 10:25:46.730' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10321, CAST(N'2019-06-11 10:30:47.163' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10322, CAST(N'2019-06-11 10:35:47.463' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10323, CAST(N'2019-06-11 10:40:47.287' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10324, CAST(N'2019-06-11 10:45:47.317' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10325, CAST(N'2019-06-11 10:50:47.587' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10326, CAST(N'2019-06-11 10:55:47.240' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10327, CAST(N'2019-06-11 11:00:46.710' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10328, CAST(N'2019-06-11 11:05:47.430' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10329, CAST(N'2019-06-11 14:05:01.703' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10330, CAST(N'2019-06-11 14:18:10.343' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10331, CAST(N'2019-06-11 14:18:11.590' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10332, CAST(N'2019-06-11 14:18:11.603' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10333, CAST(N'2019-06-11 14:22:37.687' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10334, CAST(N'2019-06-11 14:23:19.710' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10335, CAST(N'2019-06-11 15:40:50.277' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10336, CAST(N'2019-06-11 16:04:53.303' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10337, CAST(N'2019-06-11 16:05:50.897' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10338, CAST(N'2019-06-11 16:06:03.940' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10339, CAST(N'2019-06-11 16:06:20.343' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10340, CAST(N'2019-06-11 16:07:26.193' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10341, CAST(N'2019-06-11 16:07:32.120' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10342, CAST(N'2019-06-11 16:08:16.037' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10343, CAST(N'2019-06-11 16:08:22.947' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10344, CAST(N'2019-06-11 16:08:44.043' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10345, CAST(N'2019-06-11 16:08:52.717' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10346, CAST(N'2019-06-11 16:09:12.483' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10347, CAST(N'2019-06-11 16:09:22.730' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10348, CAST(N'2019-06-11 16:09:36.067' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10349, CAST(N'2019-06-11 16:09:40.533' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10350, CAST(N'2019-06-11 16:11:51.983' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10351, CAST(N'2019-06-11 16:13:28.020' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10352, CAST(N'2019-06-11 21:12:27.483' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10353, CAST(N'2019-06-11 22:48:53.877' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10354, CAST(N'2019-06-12 11:03:42.750' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10355, CAST(N'2019-06-12 11:56:41.863' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10356, CAST(N'2019-06-12 12:09:06.200' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10357, CAST(N'2019-06-12 15:32:52.580' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10358, CAST(N'2019-06-12 15:59:12.637' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10359, CAST(N'2019-06-12 16:00:52.770' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10360, CAST(N'2019-06-12 16:01:46.237' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10361, CAST(N'2019-06-12 16:04:04.950' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10362, CAST(N'2019-06-12 16:06:58.510' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10363, CAST(N'2019-06-12 16:08:29.723' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10364, CAST(N'2019-06-12 16:10:14.693' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10365, CAST(N'2019-06-12 16:16:29.860' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10366, CAST(N'2019-06-12 16:46:53.627' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10367, CAST(N'2019-06-12 17:17:40.803' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10368, CAST(N'2019-06-12 17:26:39.673' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10369, CAST(N'2019-06-12 17:33:44.820' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10370, CAST(N'2019-06-12 17:35:32.293' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10371, CAST(N'2019-06-12 17:35:52.433' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10372, CAST(N'2019-06-12 17:38:40.577' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10373, CAST(N'2019-06-12 21:39:21.493' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10374, CAST(N'2019-06-12 21:57:00.110' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10375, CAST(N'2019-06-12 21:59:30.407' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10376, CAST(N'2019-06-12 22:00:29.037' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10377, CAST(N'2019-06-12 22:01:40.057' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10378, CAST(N'2019-06-12 23:11:33.103' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10379, CAST(N'2019-06-14 21:26:54.813' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10380, CAST(N'2019-06-14 21:31:18.387' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10381, CAST(N'2019-06-14 21:42:04.113' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10382, CAST(N'2019-06-14 21:48:46.260' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10383, CAST(N'2019-06-14 21:49:21.080' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10384, CAST(N'2019-06-14 21:50:33.120' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10385, CAST(N'2019-06-14 21:53:20.497' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10386, CAST(N'2019-06-14 21:53:32.233' AS DateTime))
GO
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10387, CAST(N'2019-06-14 21:55:32.490' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10388, CAST(N'2019-06-14 21:59:37.970' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10389, CAST(N'2019-06-14 22:02:20.220' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10390, CAST(N'2019-06-14 22:11:07.970' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10391, CAST(N'2019-06-14 22:14:55.970' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10392, CAST(N'2019-06-14 22:18:20.760' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10393, CAST(N'2019-06-14 22:19:39.780' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10394, CAST(N'2019-06-14 23:17:23.803' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10395, CAST(N'2019-06-14 23:22:56.990' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10396, CAST(N'2019-06-14 23:33:20.373' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10397, CAST(N'2019-06-14 23:37:22.717' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10398, CAST(N'2019-06-14 23:38:17.647' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10399, CAST(N'2019-06-14 23:39:39.233' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10400, CAST(N'2019-06-14 23:40:17.623' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10401, CAST(N'2019-06-14 23:40:54.237' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10402, CAST(N'2019-06-14 23:41:30.797' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10403, CAST(N'2019-06-14 23:42:26.323' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10404, CAST(N'2019-06-14 23:53:19.697' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10405, CAST(N'2019-06-14 23:54:20.300' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10406, CAST(N'2019-06-14 23:54:42.713' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10407, CAST(N'2019-06-15 01:47:37.043' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10408, CAST(N'2019-06-15 10:57:13.417' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10409, CAST(N'2019-06-15 10:58:24.223' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10410, CAST(N'2019-06-15 10:59:53.390' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10411, CAST(N'2019-06-15 10:59:59.337' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10412, CAST(N'2019-06-15 11:00:05.240' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10413, CAST(N'2019-06-15 11:00:11.467' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10414, CAST(N'2019-06-15 11:00:17.207' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10415, CAST(N'2019-06-15 11:00:23.610' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10416, CAST(N'2019-06-15 11:00:27.333' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10417, CAST(N'2019-06-15 11:00:29.160' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10418, CAST(N'2019-06-15 11:00:35.287' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10419, CAST(N'2019-06-15 11:00:39.760' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10420, CAST(N'2019-06-15 11:00:55.590' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10421, CAST(N'2019-06-15 11:01:01.603' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10422, CAST(N'2019-06-15 11:01:07.513' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10423, CAST(N'2019-06-15 11:01:13.553' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10424, CAST(N'2019-06-15 14:56:51.553' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10425, CAST(N'2019-06-15 15:08:20.397' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10426, CAST(N'2019-06-15 15:49:11.040' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10427, CAST(N'2019-06-15 15:50:52.347' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10428, CAST(N'2019-06-15 15:52:22.190' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10429, CAST(N'2019-06-15 16:55:12.100' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10430, CAST(N'2019-06-15 16:56:47.890' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10431, CAST(N'2019-06-15 17:06:12.483' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10432, CAST(N'2019-06-15 17:07:47.047' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10433, CAST(N'2019-06-16 11:06:16.503' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10434, CAST(N'2019-06-16 11:11:02.573' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10435, CAST(N'2019-06-16 11:12:07.093' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10436, CAST(N'2019-06-16 11:13:08.720' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10437, CAST(N'2019-06-16 11:14:09.073' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10438, CAST(N'2019-06-16 11:14:27.263' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10439, CAST(N'2019-06-16 11:14:50.130' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10440, CAST(N'2019-06-16 11:15:05.077' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10441, CAST(N'2019-06-16 11:15:31.003' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10442, CAST(N'2019-06-16 11:15:44.667' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10443, CAST(N'2019-06-16 11:18:46.750' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10444, CAST(N'2019-06-16 11:21:16.323' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10445, CAST(N'2019-06-16 11:21:48.353' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10446, CAST(N'2019-06-16 11:23:34.380' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10447, CAST(N'2019-06-16 13:35:57.810' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10448, CAST(N'2019-06-16 13:41:51.540' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10449, CAST(N'2019-06-16 13:41:57.273' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10450, CAST(N'2019-06-16 13:42:03.667' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10451, CAST(N'2019-06-16 13:42:09.360' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10452, CAST(N'2019-06-16 13:42:15.450' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10453, CAST(N'2019-06-16 13:42:21.493' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10454, CAST(N'2019-06-16 13:42:53.937' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10455, CAST(N'2019-06-16 13:43:06.260' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10456, CAST(N'2019-06-16 13:43:11.957' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10457, CAST(N'2019-06-16 13:43:40.697' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10458, CAST(N'2019-06-16 13:43:46.620' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10459, CAST(N'2019-06-16 13:43:52.387' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10460, CAST(N'2019-06-16 13:43:58.300' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10461, CAST(N'2019-06-16 13:44:04.980' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10462, CAST(N'2019-06-16 13:44:10.270' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10463, CAST(N'2019-06-16 13:50:12.710' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10464, CAST(N'2019-06-16 13:50:18.300' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10465, CAST(N'2019-06-16 13:50:24.167' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10466, CAST(N'2019-06-16 13:50:30.357' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10467, CAST(N'2019-06-16 13:50:36.340' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10468, CAST(N'2019-06-16 13:50:42.307' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10469, CAST(N'2019-06-16 14:08:47.100' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10470, CAST(N'2019-06-16 14:09:12.593' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10471, CAST(N'2019-06-16 15:04:56.020' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10472, CAST(N'2019-06-17 23:36:38.807' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10473, CAST(N'2019-06-18 09:55:19.157' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10474, CAST(N'2019-06-18 09:57:38.397' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10475, CAST(N'2019-06-18 09:59:03.860' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10476, CAST(N'2019-06-18 10:00:46.220' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10477, CAST(N'2019-06-18 10:00:52.580' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10478, CAST(N'2019-06-18 10:00:58.983' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10479, CAST(N'2019-06-18 10:05:31.697' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10480, CAST(N'2019-06-18 10:05:41.827' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10481, CAST(N'2019-06-18 10:10:50.087' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10482, CAST(N'2019-06-18 10:16:34.387' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10483, CAST(N'2019-06-18 10:17:37.193' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10484, CAST(N'2019-06-18 10:19:15.020' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10485, CAST(N'2019-06-18 10:19:39.197' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10486, CAST(N'2019-06-18 11:52:37.623' AS DateTime))
GO
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10487, CAST(N'2019-06-18 11:57:27.603' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10488, CAST(N'2019-06-18 11:57:31.687' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10489, CAST(N'2019-06-18 11:57:34.840' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10490, CAST(N'2019-06-18 11:57:41.277' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10491, CAST(N'2019-06-18 11:57:45.847' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10492, CAST(N'2019-06-18 16:02:04.243' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10493, CAST(N'2019-06-18 16:25:33.947' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10494, CAST(N'2019-06-18 16:25:54.030' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10495, CAST(N'2019-06-18 16:25:59.153' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10496, CAST(N'2019-06-18 16:26:03.210' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10497, CAST(N'2019-06-18 16:26:25.900' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10498, CAST(N'2019-06-18 16:26:33.110' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10499, CAST(N'2019-06-18 16:26:37.300' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10500, CAST(N'2019-06-18 16:30:48.403' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10501, CAST(N'2019-06-18 16:31:37.170' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10502, CAST(N'2019-06-18 16:32:15.303' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10503, CAST(N'2019-06-18 16:32:40.413' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10504, CAST(N'2019-06-18 16:33:07.060' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10505, CAST(N'2019-06-18 16:34:12.900' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10506, CAST(N'2019-06-18 16:36:00.620' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10507, CAST(N'2019-06-18 16:38:32.670' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10508, CAST(N'2019-06-18 16:39:21.963' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10509, CAST(N'2019-06-18 16:39:41.217' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10510, CAST(N'2019-06-18 16:41:40.550' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10511, CAST(N'2019-06-18 16:41:56.257' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10512, CAST(N'2019-06-18 16:47:37.023' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10513, CAST(N'2019-06-18 16:47:52.470' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10514, CAST(N'2019-06-18 16:48:13.490' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10515, CAST(N'2019-06-18 16:49:26.470' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10516, CAST(N'2019-06-18 16:51:06.127' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10517, CAST(N'2019-06-18 16:51:41.577' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10518, CAST(N'2019-06-18 16:52:34.950' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10519, CAST(N'2019-06-18 16:56:27.550' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10520, CAST(N'2019-06-18 16:57:10.560' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10521, CAST(N'2019-06-18 16:59:05.690' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10522, CAST(N'2019-06-18 17:02:15.810' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10523, CAST(N'2019-06-18 17:04:04.503' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10524, CAST(N'2019-06-18 17:08:03.180' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10525, CAST(N'2019-06-18 17:09:25.690' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10526, CAST(N'2019-06-18 17:09:43.403' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10527, CAST(N'2019-06-18 17:10:31.853' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10528, CAST(N'2019-06-18 17:10:50.083' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10529, CAST(N'2019-06-18 17:11:23.277' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10530, CAST(N'2019-06-18 17:12:37.250' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10531, CAST(N'2019-06-18 17:14:10.583' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10532, CAST(N'2019-06-18 17:14:36.517' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10533, CAST(N'2019-06-18 17:18:22.080' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10534, CAST(N'2019-06-18 17:18:45.047' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10535, CAST(N'2019-06-18 17:18:58.210' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10536, CAST(N'2019-06-18 17:19:17.323' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10537, CAST(N'2019-06-18 17:25:06.140' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10538, CAST(N'2019-06-18 17:25:50.860' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10539, CAST(N'2019-06-18 17:26:16.103' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10540, CAST(N'2019-06-18 17:32:04.323' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10541, CAST(N'2019-06-18 17:33:18.507' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10542, CAST(N'2019-06-18 22:21:19.550' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10543, CAST(N'2019-06-18 22:23:55.593' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10544, CAST(N'2019-06-18 22:24:15.730' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10545, CAST(N'2019-06-18 22:24:59.637' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10546, CAST(N'2019-06-18 22:25:10.003' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10547, CAST(N'2019-06-18 22:26:22.247' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10548, CAST(N'2019-06-18 22:26:39.140' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10549, CAST(N'2019-06-18 22:27:01.407' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10550, CAST(N'2019-06-18 22:27:20.450' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10551, CAST(N'2019-06-18 22:27:26.917' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10552, CAST(N'2019-06-18 22:27:54.480' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10553, CAST(N'2019-06-18 22:29:34.650' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10554, CAST(N'2019-06-18 22:34:14.730' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10555, CAST(N'2019-06-18 22:34:26.600' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10556, CAST(N'2019-06-18 23:22:44.747' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10557, CAST(N'2019-06-18 23:27:49.340' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10558, CAST(N'2019-06-18 23:33:17.130' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10559, CAST(N'2019-06-18 23:33:50.413' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10560, CAST(N'2019-06-19 09:27:11.987' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10561, CAST(N'2019-06-19 09:27:15.417' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10562, CAST(N'2019-06-19 09:43:07.967' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10563, CAST(N'2019-06-19 09:43:27.240' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10564, CAST(N'2019-06-19 09:46:00.763' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10565, CAST(N'2019-06-19 09:46:06.917' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10566, CAST(N'2019-06-19 09:48:07.537' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10567, CAST(N'2019-06-19 09:48:41.557' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10568, CAST(N'2019-06-19 09:49:31.913' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10569, CAST(N'2019-06-19 09:51:20.140' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10570, CAST(N'2019-06-19 09:51:33.690' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10571, CAST(N'2019-06-19 09:51:42.090' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10572, CAST(N'2019-06-19 10:22:54.133' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10573, CAST(N'2019-06-19 10:38:17.690' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10574, CAST(N'2019-06-19 10:38:54.930' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10575, CAST(N'2019-06-19 10:44:17.477' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10576, CAST(N'2019-06-19 10:45:07.520' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10577, CAST(N'2019-06-19 10:45:45.923' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10578, CAST(N'2019-06-19 12:03:53.743' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10579, CAST(N'2019-06-19 12:07:07.240' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10580, CAST(N'2019-06-19 13:13:19.973' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10581, CAST(N'2019-06-19 13:14:54.517' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10582, CAST(N'2019-06-19 13:15:34.237' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10583, CAST(N'2019-06-19 13:18:21.770' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10584, CAST(N'2019-06-19 13:19:11.403' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10585, CAST(N'2019-06-19 16:21:03.413' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10586, CAST(N'2019-06-19 16:22:35.660' AS DateTime))
GO
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10587, CAST(N'2019-06-19 16:23:42.837' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10588, CAST(N'2019-06-19 16:24:12.803' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10589, CAST(N'2019-06-19 16:24:59.363' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10590, CAST(N'2019-06-19 16:25:37.803' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10591, CAST(N'2019-06-19 16:27:02.227' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10592, CAST(N'2019-06-19 16:30:03.293' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10593, CAST(N'2019-06-19 16:31:31.210' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10594, CAST(N'2019-06-19 16:31:53.410' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10595, CAST(N'2019-06-19 16:34:40.737' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10596, CAST(N'2019-06-19 16:35:05.103' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10597, CAST(N'2019-06-19 16:36:48.190' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10598, CAST(N'2019-06-19 16:37:14.473' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10599, CAST(N'2019-06-19 16:38:10.307' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10600, CAST(N'2019-06-19 16:39:10.583' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10601, CAST(N'2019-06-19 21:24:58.237' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10602, CAST(N'2019-06-19 21:28:05.447' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10603, CAST(N'2019-06-19 22:37:05.900' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10608, CAST(N'2019-06-19 23:38:29.763' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10609, CAST(N'2019-06-20 00:00:55.150' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10610, CAST(N'2019-06-20 00:01:00.057' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10611, CAST(N'2019-06-20 00:01:05.997' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10612, CAST(N'2019-06-20 00:01:12.047' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10613, CAST(N'2019-06-20 00:01:17.823' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10614, CAST(N'2019-06-20 00:01:24.100' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10615, CAST(N'2019-06-20 00:56:31.087' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10616, CAST(N'2019-06-20 00:56:36.857' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10617, CAST(N'2019-06-20 00:56:43.120' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10618, CAST(N'2019-06-20 00:56:50.100' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10619, CAST(N'2019-06-20 00:57:04.090' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10620, CAST(N'2019-06-20 00:57:09.543' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10621, CAST(N'2019-06-20 00:57:15.563' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10622, CAST(N'2019-06-20 00:57:21.753' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10623, CAST(N'2019-06-20 00:57:27.690' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10624, CAST(N'2019-06-20 08:23:53.387' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10625, CAST(N'2019-06-20 09:29:55.933' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10626, CAST(N'2019-06-20 09:31:15.083' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10627, CAST(N'2019-06-20 09:31:28.997' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10628, CAST(N'2019-06-20 09:35:29.300' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10629, CAST(N'2019-06-20 09:55:16.603' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10630, CAST(N'2019-06-20 09:57:32.630' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10631, CAST(N'2019-06-20 09:58:31.950' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10632, CAST(N'2019-06-20 10:00:27.787' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10633, CAST(N'2019-06-20 11:42:03.710' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10634, CAST(N'2019-06-20 23:17:09.123' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10635, CAST(N'2019-06-20 23:42:55.150' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10636, CAST(N'2019-06-22 00:08:53.930' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10637, CAST(N'2019-06-22 00:09:44.887' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10638, CAST(N'2019-06-22 00:27:44.460' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10639, CAST(N'2019-06-22 00:35:55.930' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10640, CAST(N'2019-06-22 00:36:21.097' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10641, CAST(N'2019-06-22 00:36:56.953' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10642, CAST(N'2019-06-22 00:37:25.400' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10643, CAST(N'2019-06-22 00:39:23.690' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10644, CAST(N'2019-06-22 00:42:16.880' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10645, CAST(N'2019-06-22 00:42:44.620' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10646, CAST(N'2019-06-22 00:42:59.250' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10647, CAST(N'2019-06-22 00:43:59.750' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10648, CAST(N'2019-06-22 00:44:48.497' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10649, CAST(N'2019-06-22 00:45:01.420' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10650, CAST(N'2019-06-22 00:45:55.850' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10651, CAST(N'2019-06-22 00:46:09.197' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10652, CAST(N'2019-06-22 01:12:04.107' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10653, CAST(N'2019-06-22 01:12:35.177' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10654, CAST(N'2019-06-22 01:13:01.800' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10655, CAST(N'2019-06-22 01:13:22.370' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10656, CAST(N'2019-06-22 01:15:54.690' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10657, CAST(N'2019-06-22 01:21:29.097' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10658, CAST(N'2019-06-22 01:22:04.920' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10659, CAST(N'2019-06-22 01:22:18.693' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10660, CAST(N'2019-06-22 01:40:12.010' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10661, CAST(N'2019-06-22 01:40:42.480' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10662, CAST(N'2019-06-22 01:42:06.813' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10663, CAST(N'2019-06-22 01:42:24.920' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10664, CAST(N'2019-06-22 01:42:38.483' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10665, CAST(N'2019-06-22 09:18:08.093' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10666, CAST(N'2019-06-22 09:50:14.780' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10667, CAST(N'2019-06-22 13:26:38.580' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10668, CAST(N'2019-06-22 13:53:50.530' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10669, CAST(N'2019-06-22 13:56:33.573' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10670, CAST(N'2019-06-22 13:58:49.660' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10671, CAST(N'2019-06-22 14:19:26.280' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10672, CAST(N'2019-06-22 14:28:58.183' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10673, CAST(N'2019-06-22 14:34:58.170' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10674, CAST(N'2019-06-22 14:40:57.970' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10675, CAST(N'2019-06-22 14:46:57.857' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10676, CAST(N'2019-06-22 15:21:08.987' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10677, CAST(N'2019-06-22 15:21:28.147' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10678, CAST(N'2019-06-22 15:22:13.843' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10679, CAST(N'2019-06-22 15:54:53.977' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10680, CAST(N'2019-06-22 16:59:28.613' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10681, CAST(N'2019-06-22 19:43:31.020' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10682, CAST(N'2019-06-22 20:02:58.883' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10683, CAST(N'2019-06-23 00:59:33.067' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10684, CAST(N'2019-06-23 01:00:21.943' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10685, CAST(N'2019-06-23 01:01:05.463' AS DateTime))
INSERT [dbo].[TBL_WEB_FEED_REFRESH] ([ID], [REFRESH_TIME]) VALUES (10686, CAST(N'2019-06-23 10:50:11.477' AS DateTime))
SET IDENTITY_INSERT [dbo].[TBL_WEB_FEED_REFRESH] OFF
SET IDENTITY_INSERT [dbo].[WEB_FEED_PROVIDERS] ON 

INSERT [dbo].[WEB_FEED_PROVIDERS] ([PROVIDER_ID], [PROVIDER_NAME], [PROVIDER_URL], [ACTIVE_IND], [ACTIVITY_DT_TM], [FEED_COUNT], [LAST_REFRESH_TIME], [PREVIOUS_FETCH_COUNT], [NEW_FETCH_COUNT]) VALUES (8, N'Fandango Movies', N'https://www.fandango.com/rss/newmovies.rss', 1, CAST(N'2019-06-22 00:27:44.527' AS DateTime), 0, CAST(N'2019-06-23 10:50:11.527' AS DateTime), 8, 8)
INSERT [dbo].[WEB_FEED_PROVIDERS] ([PROVIDER_ID], [PROVIDER_NAME], [PROVIDER_URL], [ACTIVE_IND], [ACTIVITY_DT_TM], [FEED_COUNT], [LAST_REFRESH_TIME], [PREVIOUS_FETCH_COUNT], [NEW_FETCH_COUNT]) VALUES (20, N'Cinema Blend', N'https://www.cinemablend.com/rss/topic/news/movies', 1, CAST(N'2019-06-22 00:35:54.573' AS DateTime), 0, CAST(N'2019-06-23 10:50:11.527' AS DateTime), 67, 67)
INSERT [dbo].[WEB_FEED_PROVIDERS] ([PROVIDER_ID], [PROVIDER_NAME], [PROVIDER_URL], [ACTIVE_IND], [ACTIVITY_DT_TM], [FEED_COUNT], [LAST_REFRESH_TIME], [PREVIOUS_FETCH_COUNT], [NEW_FETCH_COUNT]) VALUES (22, N'Rogerebert', N'https://www.rogerebert.com/feed', 1, CAST(N'2019-06-22 00:37:23.807' AS DateTime), 0, CAST(N'2019-06-23 10:50:11.527' AS DateTime), 10, 10)
INSERT [dbo].[WEB_FEED_PROVIDERS] ([PROVIDER_ID], [PROVIDER_NAME], [PROVIDER_URL], [ACTIVE_IND], [ACTIVITY_DT_TM], [FEED_COUNT], [LAST_REFRESH_TIME], [PREVIOUS_FETCH_COUNT], [NEW_FETCH_COUNT]) VALUES (23, N'Movies.com', N'http://www.movies.com/rss-feeds/movie-news-rss', 1, CAST(N'2019-06-22 00:42:43.097' AS DateTime), 0, CAST(N'2019-06-23 10:50:11.527' AS DateTime), 1, 1)
INSERT [dbo].[WEB_FEED_PROVIDERS] ([PROVIDER_ID], [PROVIDER_NAME], [PROVIDER_URL], [ACTIVE_IND], [ACTIVITY_DT_TM], [FEED_COUNT], [LAST_REFRESH_TIME], [PREVIOUS_FETCH_COUNT], [NEW_FETCH_COUNT]) VALUES (37, N'Deutsch Kino', N'https://www.kino.de/rss/neu-im-kino', 1, CAST(N'2019-06-23 01:01:03.573' AS DateTime), 0, CAST(N'2019-06-23 10:50:11.527' AS DateTime), 1, 1)
SET IDENTITY_INSERT [dbo].[WEB_FEED_PROVIDERS] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [unique_TTITLE_URL]    Script Date: 23-06-2019 11:01:36 ******/
CREATE UNIQUE NONCLUSTERED INDEX [unique_TTITLE_URL] ON [dbo].[TBL_WEB_FEED]
(
	[TITLE] ASC,
	[URL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = ON, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [unique_TTITLE_URL_Replica]    Script Date: 23-06-2019 11:01:36 ******/
CREATE UNIQUE NONCLUSTERED INDEX [unique_TTITLE_URL_Replica] ON [dbo].[TBL_WEB_FEED_REPLICA]
(
	[TITLE] ASC,
	[URL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = ON, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__WEB_FEED__E6DB4963A78C1B3B]    Script Date: 23-06-2019 11:01:36 ******/
ALTER TABLE [dbo].[WEB_FEED_PROVIDERS] ADD UNIQUE NONCLUSTERED 
(
	[PROVIDER_URL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBL_WEB_FEED_REPLICA] ADD  DEFAULT (getdate()) FOR [DB_ENTRY_TIME]
GO
ALTER TABLE [dbo].[TBL_WEB_FEED_REPLICA] ADD  CONSTRAINT [ACTIVE_IND_DF_REPLICA]  DEFAULT ((1)) FOR [ACTIVE_IND]
GO
/****** Object:  StoredProcedure [dbo].[DELETE_DATA]    Script Date: 23-06-2019 11:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DELETE_DATA]
(
	@Start_Time datetime,
	@End_Time	datetime,
	@Return		INT OUTPUT,
	@COUNT		INT OUTPUT
)
AS
BEGIN
	SELECT @COUNT = COUNT(*) FROM TBL_WEB_FEED
	WHERE PUBLISH_TIME BETWEEN @Start_Time AND @End_Time
	AND ACTIVE_IND = 1

	IF(@COUNT > 0)
	BEGIN
		SET @Return = 1
		DELETE FROM TBL_WEB_FEED
		WHERE PUBLISH_TIME BETWEEN @Start_Time AND @End_Time
		AND ACTIVE_IND = 1
	END

	ELSE
	
	BEGIN
		SET @Return = 0
	END

	SELECT @Return AS Return_Value, @COUNT as Total
END
GO
/****** Object:  StoredProcedure [dbo].[DELETE_OLD_RECORDS]    Script Date: 23-06-2019 11:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DELETE_OLD_RECORDS] 
AS BEGIN  
   DELETE FROM TBL_WEB_FEED
   WHERE DATEDIFF(DAY, PUBLISH_TIME, GETDATE()) > 10
END
GO
/****** Object:  StoredProcedure [dbo].[Insert_New_Provider]    Script Date: 23-06-2019 11:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_New_Provider]
(
	@Provider_Name	VARCHAR(255),
	@Provider_URL	VARCHAR(255),
	@RETURN			INT	OUTPUT
)
AS
BEGIN
	DECLARE @COUNT INT
	SELECT @COUNT = COUNT(*) FROM WEB_FEED_PROVIDERS
	WHERE	PROVIDER_URL	=	@Provider_URL
		OR	PROVIDER_NAME	=	@Provider_Name

	IF(@COUNT = 0)
		BEGIN
			SET @RETURN = 1;
			INSERT INTO WEB_FEED_PROVIDERS(PROVIDER_NAME, PROVIDER_URL, ACTIVITY_DT_TM)
			VALUES(@Provider_Name, @Provider_URL, GETDATE())
		END
	ELSE
		BEGIN
			SET @RETURN = 0;
		END
	SELECT @RETURN AS RETURN_VAL
END
GO
/****** Object:  StoredProcedure [dbo].[PROVIDER_COUNT_REFRESH_TIME]    Script Date: 23-06-2019 11:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PROVIDER_COUNT_REFRESH_TIME]
AS
BEGIN
	DECLARE @COUNT INT					=	0
	DECLARE @PROVIDER_FEED_COUNT INT	=	0
	DECLARE @PREVIOUS_COUNT INT			=	0
	DECLARE @PROVIDER_VAL VARCHAR(255)

	SELECT @COUNT = COUNT(DISTINCT PROVIDER) FROM TBL_WEB_FEED
	
	DECLARE DISTINCT_PROVIDERS CURSOR FOR
	SELECT DISTINCT(PROVIDER) AS PROVIDER FROM TBL_WEB_FEED

	OPEN DISTINCT_PROVIDERS
		WHILE @COUNT > 0
			BEGIN
				FETCH DISTINCT_PROVIDERS INTO @PROVIDER_VAL

				SELECT @PROVIDER_FEED_COUNT = COUNT(*) FROM TBL_WEB_FEED WHERE PROVIDER = @PROVIDER_VAL
				SELECT @PREVIOUS_COUNT      = PREVIOUS_FETCH_COUNT FROM WEB_FEED_PROVIDERS WHERE PROVIDER_NAME =	@PROVIDER_VAL

				IF  @PROVIDER_FEED_COUNT > @PREVIOUS_COUNT
				BEGIN
					UPDATE WEB_FEED_PROVIDERS
					SET	FEED_COUNT				=	(SELECT COUNT(*) FROM TBL_WEB_FEED WHERE PROVIDER = @PROVIDER_VAL) - PREVIOUS_FETCH_COUNT,
						LAST_REFRESH_TIME		=	GETDATE()
					WHERE PROVIDER_NAME			=	@PROVIDER_VAL

					UPDATE WEB_FEED_PROVIDERS
					SET	PREVIOUS_FETCH_COUNT	=	(SELECT COUNT(*) FROM TBL_WEB_FEED WHERE PROVIDER = @PROVIDER_VAL)
					WHERE PROVIDER_NAME			=	@PROVIDER_VAL

				END
				ELSE
				BEGIN
					UPDATE WEB_FEED_PROVIDERS
					SET	PREVIOUS_FETCH_COUNT	=	(SELECT COUNT(*) FROM TBL_WEB_FEED WHERE PROVIDER = @PROVIDER_VAL),
						LAST_REFRESH_TIME		=	GETDATE(),
						FEED_COUNT				=	0
					WHERE PROVIDER_NAME			=	@PROVIDER_VAL
				END
				
				SET @COUNT = @COUNT - 1
			END
	CLOSE DISTINCT_PROVIDERS 
	DEALLOCATE DISTINCT_PROVIDERS 
END

GO
/****** Object:  StoredProcedure [dbo].[PROVIDER_DELETE]    Script Date: 23-06-2019 11:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PROVIDER_DELETE]
(
	--THIS PROCEDURE IS USED TO DELETE THE PROVIDER INFORMATION IF USER CLICKS ON DELETE BUTTON 
	@Provider_Id	VARCHAR(255),
	@RETURN			INT OUTPUT
)
AS
BEGIN
	DECLARE @OLD_PROVIDER_NAME   VARCHAR(255)	
	
	--GET THE OLD NAME FROM THE PROVIDERS TABLE
	SELECT @OLD_PROVIDER_NAME	= PROVIDER_NAME FROM WEB_FEED_PROVIDERS
	WHERE	PROVIDER_ID			= @Provider_Id

	SET @RETURN = 1

	DELETE FROM WEB_FEED_PROVIDERS
	WHERE PROVIDER_ID	= @Provider_Id
	
	--ALSO DELETE THE ENTRIES FROM WEB FEED NEWS TABLE RELATED TO THAT PROVIDER
	DELETE FROM TBL_WEB_FEED
	WHERE PROVIDER	= @OLD_PROVIDER_NAME  

	SELECT @RETURN AS RETURN_VAL
END
GO
/****** Object:  StoredProcedure [dbo].[PROVIDER_EDIT_INSERT]    Script Date: 23-06-2019 11:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PROVIDER_EDIT_INSERT]
(
--THIS PROCEDURE IS USED TO UPDATE THE PROVIDER INFORMATION DURING THE EDIT INSERT OPERATION
	@Provider_Name	VARCHAR(255),
	@Provider_URL	VARCHAR(255),
	@Provider_Id	BIGINT,
	@RETURN			INT OUTPUT
)
AS
BEGIN
	DECLARE @COUNT INT
	DECLARE @OTHER_PROVIDER_NAME INT
	DECLARE @OTHER_PROVIDER_URL  INT
	DECLARE @OLD_PROVIDER_NAME   VARCHAR(255)

	SELECT @OLD_PROVIDER_NAME	= PROVIDER_NAME FROM WEB_FEED_PROVIDERS
	WHERE	PROVIDER_ID			= @Provider_Id 

	--CHECK IF SAME INFORMATION HAS BEEN TRIED TO PROVIDE BY USER
	SELECT @COUNT = COUNT(*) FROM WEB_FEED_PROVIDERS
	WHERE	PROVIDER_ID		= @Provider_Id 
		AND PROVIDER_NAME	= @Provider_Name
		AND PROVIDER_URL	= @Provider_URL

	IF(@COUNT = 0)
	BEGIN
		--CHECK IF THE PROVIDER NAME MATCHES WITH OTHER PROVIDER NAME
		SELECT	@OTHER_PROVIDER_NAME = COUNT(*) FROM WEB_FEED_PROVIDERS
		WHERE	PROVIDER_NAME		 = @Provider_Name
			AND PROVIDER_ID			!= @Provider_Id

		IF(@OTHER_PROVIDER_NAME = 0)
		BEGIN
			--CHECK IF THE PROVIDER URL MATCHES WITH OTHER PROVIDER URL
				SELECT	@OTHER_PROVIDER_URL  = COUNT(*) FROM WEB_FEED_PROVIDERS
				WHERE	PROVIDER_URL		 = @Provider_URL
					AND PROVIDER_ID			!= @Provider_Id

				IF(@OTHER_PROVIDER_URL = 0)
				BEGIN
					SET @RETURN	= 1

					DELETE FROM TBL_WEB_FEED
					WHERE PROVIDER	= @OLD_PROVIDER_NAME 



					--UPDATE PROVIDERS TABLE WITH INFORMATION
					UPDATE WEB_FEED_PROVIDERS
					SET		PROVIDER_NAME	=	@Provider_Name,
							PROVIDER_URL	=	@Provider_URL,
							PREVIOUS_FETCH_COUNT = 0,
							ACTIVITY_DT_TM	=	GETDATE()
					WHERE	PROVIDER_ID		=	@Provider_Id

					--ALSO UPDATE THE DATA TABLE WITH THE NEW PROVIDER NAME
				/*	IF(@OLD_PROVIDER_NAME != @Provider_Name)
					BEGIN
						UPDATE TBL_WEB_FEED
						SET PROVIDER	= @Provider_Name
						WHERE PROVIDER	= @OLD_PROVIDER_NAME
					END
				*/
	
				END
				ELSE
				BEGIN
					SET @RETURN	= 0
				END
		END
		ELSE
		BEGIN
			SET @RETURN	= 0
		END
	END

	ELSE
	BEGIN
		SET @RETURN	= 0
	END
	SELECT @RETURN AS RETURN_VAL
END
GO
/****** Object:  StoredProcedure [dbo].[WEB_DATA_REFRESH_TIME]    Script Date: 23-06-2019 11:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[WEB_DATA_REFRESH_TIME]
@LAST_REFRESH_TIME	DATETIME OUTPUT,
@CURRENT_TIME		DATETIME OUTPUT
AS
SET NOCOUNT ON;
BEGIN
	DECLARE @NumberOfSeconds	INT

	SELECT TOP 1 @LAST_REFRESH_TIME = REFRESH_TIME FROM TBL_WEB_FEED_REFRESH ORDER BY REFRESH_TIME DESC
	
	SELECT @CURRENT_TIME = GETDATE()
	
	--SET @NumberOfSeconds = DATEDIFF(SECOND, @LAST_REFRESH_TIME, GETDATE())
	--SELECT CONVERT(varchar, DATEADD(second, @NumberOfSeconds, 0), 108) AS TIME_DIFFERENCE
	SELECT DATEDIFF(MINUTE, @LAST_REFRESH_TIME, GETDATE()) AS TIME_DIFFERENCE
END
GO
USE [master]
GO
ALTER DATABASE [Data_And_Web_SS19] SET  READ_WRITE 
GO
