Return-Path: <joerg.sommer@navimatix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8F0C83F03
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 17:41:58 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.80])
 by mx.groups.io with SMTP id smtpd.web10.1643.1751650916956372411
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 04 Jul 2025 10:41:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@navimatix.de header.s=selector1 header.b=WdpAA21X;
 spf=pass (domain: navimatix.de, ip: 52.101.65.80, mailfrom: joerg.sommer@navimatix.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2h/lYwhKbPEzY9iNesy1F/jP/kD5rcsnc3JJMyJQBJLQe5pqK0bP4IajogeGiUjzXRjoWcpYxhs5k0qXxJebu0g5+n0QIth7VBxYBjg4nmGw4F9yTdsc9fzpbvd8K3gHw28IRUrToyTUfHD2/NcdUjaVBB2hxsFCWUsIA41iAUjHsnU+o0+4VSG2bLD/1Gho6oy/sJRee1l3WiduZuesi5+JL6/e/xa/Yr4kE/ps6QHLJzoDEK29m0pSssFqJq8xXHblV3YrMIkn7+Z1gTgpynAOjF6tJ1ycdnW/c+Ic+jF81fUABIiIz0ef1CvhG160m2Q9RjEXhkbAUDovbh7aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmvYWdYwlA3aEO7kYAxEyHubu4il1G6pwyu2TypsXDI=;
 b=Trv4gfiEZ3JzGTovFWEoX6vQUswf1c1WV8/yOy1T1nVebB9Yl3OtV4ORrra1OyRbO028b6NmBODwL56iEJ51ujb8SSSXAOB9mC0AhW0UndRSEg1Wi06MznkxJ0ZzWHmaE+2zM56Pfmvbw3rYn7ZkKkqXn5QNbS081JZNHrM7PLey+g0nWsZZYQ0RPhSpkoeyZ3d8jgJf8uZHClT2MnkmRl5Ap1M657dzJiw+7uZ6no0RyGPOB33EEgmtiQCTMY7OClq0H8kFPSRVxwGAp1uxqhUBtt7bR3ii9wNflHLs9dh6rwlOcPLZsHgY9PB6JpKQBA3uZTqD9shcwYa5vQaVMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=navimatix.de; dmarc=pass action=none header.from=navimatix.de;
 dkim=pass header.d=navimatix.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navimatix.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmvYWdYwlA3aEO7kYAxEyHubu4il1G6pwyu2TypsXDI=;
 b=WdpAA21XEhTwuREf7mW0EEDo/Y/OglmFQnWhJ2rh1T2UgvsPzxUVXGm0MM3fzaLteTUVoKvK11RkG/rhcIG6sJYV4TnBaYE0v5UBcak+h6BexKt6RIJI6fSMkHvM9M/CEGyBNcbXOIBL8Vi9uuiR95iNPYcQ0EVkFANDwEzxc14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=navimatix.de;
Received: from PA4PR01MB7726.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:cb::18) by AM8PR01MB7636.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:24f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Fri, 4 Jul
 2025 17:41:52 +0000
Received: from PA4PR01MB7726.eurprd01.prod.exchangelabs.com
 ([fe80::412e:7f2b:cbfe:3d07]) by PA4PR01MB7726.eurprd01.prod.exchangelabs.com
 ([fe80::412e:7f2b:cbfe:3d07%5]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 17:41:52 +0000
Date: Fri, 4 Jul 2025 19:41:51 +0200
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg.sommer@navimatix.de>
To: yocto-patches@lists.yoctoproject.org, anibal@limonsoftware.com, 
	nata.dobrick@gmail.com, joerg.sommer@navimatix.de
CC: anibal@limonsoftware.com, Natalie Dobrick <nata.dobrick@gmail.com>, 
	=?utf-8?B?SsO2cmc=?= Sommer <joerg.sommer@navimatix.de>
Subject: [ptest-runner][PATCH] main.c: Add print_helptext() for detailed help
Message-ID: <61615a15a0fbc852291cf2852972ce38b700ffd7.1751650751.git.joerg.sommer@navimatix.de>
X-Mailer: git-send-email 2.48.1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0283.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::12) To PA4PR01MB7726.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:cb::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR01MB7726:EE_|AM8PR01MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: c7ee8338-0acb-444b-d3cd-08ddbb220fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?7mgRw/rULtxpj3esM84erlSbHGyYltZLUlFFfYsmtDAHxnG1q7mcvB5wzqwi?=
 =?us-ascii?Q?6K2J7vKF2JMr4r5V6xQprdjRJFR5Z9RaSZ8/feEoRi7gPFXx25cx045t2Cp+?=
 =?us-ascii?Q?cmScCjsgK6KJ9nH8Pp6o99LAoY0uOZBKX1ANZx0JHWRqSCAV7UtHzaiydIya?=
 =?us-ascii?Q?j4G3cY6Qj3OJcmwB7yKdqFLXRrFOlk+MxvIbgf2daIjvEPgZg5WmmR4ov7Vi?=
 =?us-ascii?Q?2N0rHyaJ36lNW0AqjOXM7NMIAFHhzn2cvHbrVSrhaiGoHymXkzmnWL8IgOdV?=
 =?us-ascii?Q?qX26xdOkX/kjPIle1UzwRR3abZ0qTnNPaRdT66BlWC89UXSNoUtE9J6+sUha?=
 =?us-ascii?Q?ouoj0fjmIzKRHaOBCYK3jZIF3mMh1v1gOatf2abohQmyljZDaFDvCCOPj1pv?=
 =?us-ascii?Q?ztLPzkzBJfhizp/z5kB0QwIYnNJ3I5nCB8UfYeGfnOoBlkYGXuysIyCgXVQo?=
 =?us-ascii?Q?0nk6XTMADIDvUDYnBoIMOS+K19CXy5irWWFgQDMBeu7Y8LNvFz6ydkWh3WMM?=
 =?us-ascii?Q?gr1DO/eL0Gk6AQsBPc41On3LjRxqKpVmAPmOho2CNFJkwC8MMHN+9B2zmmC/?=
 =?us-ascii?Q?SvCi+TB2mnVgeSuO00TWW5bK4RLDQ3ctefp2NUL8i1zSkfxVR5HsEjRJFYTa?=
 =?us-ascii?Q?tvpBHgzkcf5Fb+3ZK6VxMKSpiwZ0Rnx9+xllqfqbWU+4X2fPQSkpNt9Ieqjp?=
 =?us-ascii?Q?J6epT9do8uz+1GzQ8UH7N37EmxqKI2Wy/YkfY8qWq7qOEe2baFFVr+fMs0aL?=
 =?us-ascii?Q?ScQ/L2dtqc8Ue5skh1If/6Tv3WoKiMLxPXiSo8i4caYFIp4kPMnCCoATOgiG?=
 =?us-ascii?Q?8Cv4i++F38NqlPnouT+C1jJZf8Mub2YGfDUSvLbvUrtPoRseLzaWnT8GdsRU?=
 =?us-ascii?Q?LDCRtOUUXod7c5tVaXwYrL1vIvWx9T8u9YcR0SwpXjimitcwFf45zT1C2dSZ?=
 =?us-ascii?Q?jDjNrlT36UKLyPYWh7RBszmGmMZSTNC7WHaBGeHgOkHh+q5TM0uXu7WCsbEQ?=
 =?us-ascii?Q?a0DrO53OiW6shHbTbF4CigWfP03KHyFnTDTfJ+DFW9OosBa5POVrPZ9UUS02?=
 =?us-ascii?Q?KBNg2fQyP8InBi6CCnxidY2k0L2PqRZUnX4jBDX4LQuA8WMdFFlmxzPjFE3w?=
 =?us-ascii?Q?yrjbGYymyhZGL1F1camAY5P9KJ7WumtchJwifzx83/OALcZ7I1O9PqBYc1fQ?=
 =?us-ascii?Q?6aezRETkmWDJ9uo/EGC+lhIDGQA79dwiXPBZbQorXBVXm6NnsXKPnf126dbL?=
 =?us-ascii?Q?dKjqdVu5KyI+odnLekGN/EGdeDRT6W3eYVdONtaC4tYM1ZsefT3fI7VVokoO?=
 =?us-ascii?Q?ls+BMHYWBkjFzCTLD0t41KOgGPiAuZtCP8RCTf4mUJP6GeA7kDjfbpjTGYqW?=
 =?us-ascii?Q?zDNFaYcKMOlgS9ILYNH1WBBPT9aEwIW5EwuN62AqbDd53Mzg31fk/1thEAo4?=
 =?us-ascii?Q?EnL/euqek8E=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR01MB7726.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/luJmwGyUWaEDZFK61YEWPdH6/N396SHsSXSovQHEOhcRylLqyLDszovCJfb?=
 =?us-ascii?Q?e4IC7aCcH2XlKGgMssJJjfW7rSkpHFpGcPMku03fX1SbzwENhYD1Ridsgy0U?=
 =?us-ascii?Q?ju1hkIrO30WX0KsBJseXc1PvEQwMp049XGvSMKOwWaX8KANQGTNfMAl68vRy?=
 =?us-ascii?Q?h5Bdp4qH0ZTbQQLznRnzAHfrVToNJWPXoDHLYShg9+WomlBw2TCPKxcu3SXS?=
 =?us-ascii?Q?qoCR0sgzVtP8gknhMm1lvLtWc9k/kjV3flh16g6sz13BCXFOSaLXMkAOfhiI?=
 =?us-ascii?Q?AFjsheVkzNwbclMlYlZ6007En4UQxsAn/GMTxGR/JwaQ/iv4nKp9Iz/J18fH?=
 =?us-ascii?Q?O9xmYlc6icKuNY++39xnDgjG0OrKyjF+0x5mNpc9oAS56yScxJHCD0Uo7/lz?=
 =?us-ascii?Q?Fpa7zcVk3E8LG/kCkhBJJv6iq8xdZLuHP8eXmu+9KahKvNS3CJM8WdYyxwSu?=
 =?us-ascii?Q?cBkjrsp76XDpZ7WxJneb3WDjJw2FqMAZaP4qb/cSIlgpqhhDhTCmRPQqhBCA?=
 =?us-ascii?Q?Io1kKGLwPnhlRfrNRouBDfUyfCS0rKoCf0EsjICwfe/fQnVIJ7T4I54te7P2?=
 =?us-ascii?Q?yPBW14OlTYJ7sCv+Qk6vrEQz5URK35u1++n8rpNONYBvSjE9hZerXCOMt86+?=
 =?us-ascii?Q?v0I8E4KtJU5ex1Zx0IciZeY7/WjqYE+TZzbGXLOXfu23nJcwpfxCZLJU8A58?=
 =?us-ascii?Q?Ya2Ifpy9rhL0HoWP3nbywbB7lNWN0kFT2B46WOdZKbt/5zkgLZCXXx5LkWWc?=
 =?us-ascii?Q?AhhAjpCVG9hsdtFzhBBVIA/XEoxeC9NKiJM8v/LJktt+33yrZOmI55evEcQH?=
 =?us-ascii?Q?GhRa2IUtZ7k0dgcHsRdwn8cnF9DPLEJNs4Cl4AACH1LlQbQzLelFSFKpgdb7?=
 =?us-ascii?Q?+YTWCoKRr1Z5CpfrTBpU4ar17LdRAEJpqIC55XDTyvNQSPHviYzC0pm6CEPx?=
 =?us-ascii?Q?jGws+CZcJVLaR99H14TB2cPFrrLlG2c61toQsIvTJuCKRLh9NvgT5lx/yBDa?=
 =?us-ascii?Q?CXJZ+ez4JTIgZ1Vq/864xokXvuICQEDkdy4RXW+Ndkz+vmzvub4GVxbLmulb?=
 =?us-ascii?Q?SeeSzZS6LSq+cKBCqFLXDqmzCES9x3WP9MbnN/mdv83iciokvGxtmODlv+m3?=
 =?us-ascii?Q?UW6RmSO1FNnxTkl9AG0zqqM3Gc7OcETR4+MsCNqDCHaqAORxXGL6SgSdBEJV?=
 =?us-ascii?Q?/yCPt71J7InbMoc+1k1KjCjmCbyYGTUOBLB5lO8O3Y9FIDSyH+Kv5ubwkgu/?=
 =?us-ascii?Q?UsPzpwibc7/dfT7WIOUkFZXYnzZVI4Ctsv4+uwwTVk6gdpXfEByJXKxsRRr+?=
 =?us-ascii?Q?RSeejPejk3W4dotIg8m9jOmm8+QRZUh0swT9Mr22U6HjeI+FJfHxrrKTGED7?=
 =?us-ascii?Q?eTn911KM81k3Wxy1AcRgmzZRyU4JMsf8vlcd//eUiIqi/3MF3ozz8Q69nwGa?=
 =?us-ascii?Q?sszFIEnbLLH9zUo+4j5K1qCk4S3V1EuwOilLJ56FAPBkLTN86hjbP90NvH18?=
 =?us-ascii?Q?RN3k9+OvmFe/44ul3raycrdqWFlKVDufurFdZPzRJQEcnRSKI1khPGTRXF5j?=
 =?us-ascii?Q?vSiKq2D4FI2TNu5JQGzg476+dhCCwgsJIMBPdsZDkLYbZTYxrwJ24FLxGldz?=
 =?us-ascii?Q?UQ=3D=3D?=
X-OriginatorOrg: navimatix.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ee8338-0acb-444b-d3cd-08ddbb220fd3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR01MB7726.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 17:41:52.6220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c87b4f54-b992-4813-8f3f-4a876324197f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sReC8s8ccLqtvFmnh/dWkHANg9sh6YvY8QFKlhG8EUYJ3vAMFAlqui1C4cmlkCQy29KxVcTO/VeEfSz0rurVyE83kFFtxY08OFaVz3Mfyts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR01MB7636
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 17:41:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1765

From: Natalie Dobrick <nata.dobrick@gmail.com>

The flag -h should give a more detailed message to understand the usage of
the flags.

Signed-off-by: Natalie Dobrick <nata.dobrick@gmail.com>
Signed-off-by: J=F6rg Sommer <joerg.sommer@navimatix.de>
---
 main.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)


Feel free to amend the help message. It's only a suggestion to give a bette=
r user experience.


diff --git a/main.c b/main.c
index feb0685..594d198 100644
--- a/main.c
+++ b/main.c
@@ -51,6 +51,26 @@ print_usage(FILE *stream, char *progname)
 			" [-x xml-filename] [-h] [ptest1 ptest2 ...]\n", progname);
 }
=20
+static inline void
+print_help(FILE *stream, char *progname)
+{
+	print_usage(stream, progname);
+	fprintf(stream,
+		"\n  Runs all Yocto/Openembedded ptests installed in " DEFAULT_DIRECTORY
+		"/*/ptest/run-ptest by default.\n\n"
+		"Options:\n\n"
+		"  -d DIRS              Load tests from one or more directories. (defaul=
t: " DEFAULT_DIRECTORY ")\n"
+		"                       DIRS must be a list separated by spaces.\n"
+		"  -e NAMES             Exclude specified tests from execution.\n"
+		"                       NAMES must be a list separated by spaces.\n"
+		"  -h                   This help message.\n"
+		"  -l                   List all available tests and exit.\n"
+		"  -t SECONDS           Set a timeout (in seconds) for each test. (defau=
lt: %d)\n"
+		"  -x FILE              Write test results to an XML file.\n"
+		"\n", DEFAULT_TIMEOUT
+	);
+}
+
 static char **
 str2array(char *str, const char *delim, int *num)
 {
@@ -148,7 +168,7 @@ main(int argc, char *argv[])
 				opts.timeout =3D (unsigned int) atoi(optarg);
 			break;
 			case 'h':
-				print_usage(stdout, argv[0]);
+				print_help(stdout, argv[0]);
 				exit(0);
 			/* break; not needed, not reachable after exit() */
 			case 'x':
--=20
2.48.1


