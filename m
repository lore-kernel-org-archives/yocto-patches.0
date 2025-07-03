Return-Path: <joerg.sommer@navimatix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCA7C83F03
	for <webhook@archiver.kernel.org>; Thu,  3 Jul 2025 14:15:46 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.134])
 by mx.groups.io with SMTP id smtpd.web10.23812.1751552144618097014
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 03 Jul 2025 07:15:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@navimatix.de header.s=selector1 header.b=zXLJyrq1;
 spf=pass (domain: navimatix.de, ip: 40.107.130.134, mailfrom: joerg.sommer@navimatix.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtpuVjXt6Xqggz/Kruj+hjLg2c9D7zp0Oie+hmUBHpkgzgeXEirCKN7fbkdth6+p05tGiwl9zA7Zvq5ZW5lvsktlkliJkM2jlNzP4NISLK8p4S9LVrxjQ1Kuo6eNUEuMhk7zb30ZniZPHl2f03lDA2v18f+n4SbQc1HnR656ydaZI+lYOUFe6pd48l9Ge0X0/2h0LCtbkNfgWBYfwVvhOUaoWa2gHeOumiFaJjqCibiPY4a2Gid57Obdkop2Y5LzdpXOQh5UVuCBCGuXuL6o5cyJ8boUPFGFCr9+VMo/oHMz4i882YHoQQfrqaOvfLUiNxbKDrdfrinwNobml03yAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrwHZpFx2i/twuN75MPWTWXqa8h+Q+IGWa3NO+Tk1aM=;
 b=iQ4qGcYcAOkq3CrlNE1pKITokHOrbiYRgwbOq+r3agcRvE/RLW83ZRjUtp4DB4Rf+DRztkNXB2umWhC5tTPQeIaKBMxRqEioDPpDAmowpM373+JTldUVzRg+TudoPG5TU3YS7ynCOpwBf0/3mmvqaX5vTBvAcJE0nGsoPtJwev2SKmA6CQxJYC5FMnB//fwnl3Ik6DrZw6Wtjk5QlD6Jqs3kBn96znF6IoesSP269v/d9wc0wUzH1slFHLWrNY71hGEcmO65JXyUmDhAl5CkuYKJwSBgdRoWlrn4YnyAYWo35UswaTIngwQEoay4IDzDFL7x7TrO1U5rXa6T6Aod+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=navimatix.de; dmarc=pass action=none header.from=navimatix.de;
 dkim=pass header.d=navimatix.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navimatix.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrwHZpFx2i/twuN75MPWTWXqa8h+Q+IGWa3NO+Tk1aM=;
 b=zXLJyrq1GVuWzM6FrkLeByNITfOiwHvt16L1AXjW7gZzRm8lKqtxiacFqr8SABBhA5nOGWemYH1hUosy27/d9+RyU5X1CupNY74Q/9LFxv3ZOP1AFMTLAGMz5NZbFuJuyZY3n8tbOhr144VgWR2EcOQUb1nfAdDTw5CwieT4S3A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=navimatix.de;
Received: from PA4PR01MB7726.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:cb::18) by AS8PR01MB8044.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:377::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 14:15:38 +0000
Received: from PA4PR01MB7726.eurprd01.prod.exchangelabs.com
 ([fe80::412e:7f2b:cbfe:3d07]) by PA4PR01MB7726.eurprd01.prod.exchangelabs.com
 ([fe80::412e:7f2b:cbfe:3d07%5]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 14:15:38 +0000
Date: Thu, 3 Jul 2025 16:15:37 +0200
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg.sommer@navimatix.de>
To: yocto-patches@lists.yoctoproject.org, anibal@limonsoftware.com, 
	nata.dobrick@gmail.com, joerg.sommer@navimatix.de
CC: anibal@limonsoftware.com, Natalie Dobrick <nata.dobrick@gmail.com>, 
	=?utf-8?B?SsO2cmc=?= Sommer <joerg.sommer@navimatix.de>
Subject: [ptest-runner][PATCH] main.print_usage: Remove unused argument list
 of -l
Message-ID: <036b0e6d97c28f21acc8a3fa855240b24e2d850c.1751552135.git.joerg.sommer@navimatix.de>
X-Mailer: git-send-email 2.48.1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0450.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::11) To PA4PR01MB7726.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:cb::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR01MB7726:EE_|AS8PR01MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: d74d4eaa-7c5b-4f92-c689-08ddba3c15aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ghSIYOgner4xVATGOIYoTl+vrIRhwEzEnadqi0JkJYagKRQbxMYSEDK+K+dC?=
 =?us-ascii?Q?QJmO9oTTbSzlg202C51jnr3mw9Oq0sDXNfSlNhPxKfI1Fm1WrdC3fQGcqSDR?=
 =?us-ascii?Q?uW7xvkPgh3cbig3vCPtcO23OGVgg4xpdJ+gu0g27NLcOqBUSrnRmrzUZFEXk?=
 =?us-ascii?Q?vzKZ5YVEgnSvqkLQmflFcVIpM1y0Y0r3mETmz5GHoLqX3BCSjKUzGDZDAW45?=
 =?us-ascii?Q?G/aHL4cAZ8HvU7yLOEp0HjVjasziIsdjFMRTWpwhC3GBzLBxaVOmfy+Gc+xt?=
 =?us-ascii?Q?wNVHwDNLs9I3uzcuFbQBK6zKRRhcbVmggmMGoATDXYw/kONScbLALGk35vD0?=
 =?us-ascii?Q?8MzDmA5HUK7Nmm2Zv719Ls6/mUjnZgwv3sL7Pp1/wPluIoZna16DXY0+tohm?=
 =?us-ascii?Q?OsQy1dSDzUfuihzV5xSQQHlNlvcdOtBM6Dx3/tXJIwE+uAn3sxiIUqSQZJ1r?=
 =?us-ascii?Q?cwt5revQKEHLkqraZHl5yUZ6fD9SXA5zCa0U3FjbtmucX4eUn/u1EsrSH4iF?=
 =?us-ascii?Q?KIVH3R7VrfG/Gr0KVk4uKRiNqcgjZd1XDP1pFQ6XLBuxih+7P//Ug4C9gqqJ?=
 =?us-ascii?Q?rCJMrobSoILKaEz+hZLxZz2nHYzHzDxsE2/1asZX4z/x5oFEzOvBNUhUuCGK?=
 =?us-ascii?Q?LWFz80RR3mMpH0euoJR4B2I87UHOUgG+RnldPPWoQwD/sEWT+sEE5HqEEJHH?=
 =?us-ascii?Q?EKhcs0zbjSaOtl5Asro8HOBF1qAY0KuTpRdL27BbpD4iu5iJXYafd433Y+dc?=
 =?us-ascii?Q?EfBtgmEbAt5cs8DLeyn6gtLjAEgGfHOdYsTsDEcfUnxPSaAnXvHFZW5vKHah?=
 =?us-ascii?Q?vnJbkaOUELqobU2XXUfVdXqIAH8k2S0qI8qTkYPRp9oA/VtlR5q+U2yLTSm4?=
 =?us-ascii?Q?H6qraHe3L/9cm8lG+dP84cAnz27uQv9p1/5cLuXbLfe21n/zXDw2uMfvU8o6?=
 =?us-ascii?Q?LwHVNZqe0NLn1Kqq/dR1cFWsGQA6UkaqjVVciEtWtZgZ8WrDxYK7b6+COwgg?=
 =?us-ascii?Q?Bg7O3m/WD4swIgpG3oiZcPFI3Xtr+ohw9a2qf6m9euoz3loxtBkE4Wv0Ylv4?=
 =?us-ascii?Q?TcWtRmul6drkvRcRyMexUEL/qzF+lxeLQVynXaVtuzhlKS6bB8LF4kJozVzy?=
 =?us-ascii?Q?RKPkEzN7V/NJ38uG/Aibcf800s19u39zL2pgiOiK6M1IR3R4YEF+1ClgG8UT?=
 =?us-ascii?Q?TeQTpolphUy6SDete3NNWxGfnU9+Y1Hc1v8//nqn8eyekKAmEeLI5QaFtHV/?=
 =?us-ascii?Q?3Xi5EI8GYsS84o5p+IfY+TO4awb90YLfPg9DGu+viail8aHmSQOk1UCYtfut?=
 =?us-ascii?Q?qbCg4x9iqcwGe6L4YcJxI/L3kQMvmCPHqE1+5Laof+poau1wiD/WQtyPUPJb?=
 =?us-ascii?Q?mrIxP7qVXDuLww+U4J5G2IO5ybweKkFHUPBcCiuudmXkKKyR2fgPySWgBD/F?=
 =?us-ascii?Q?yuKHvbaM3bo=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR01MB7726.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HxYzgLKJBdi9GNiyIkA9zIHDcmHHewcCmWfHg8Mtb1XDkQd0CFSvxfpKisJQ?=
 =?us-ascii?Q?xZ9LbAGg7PweZXNNEHUTQTvw16LUPlezUpfoFWSgS13968cTI+H/XpAmyRoq?=
 =?us-ascii?Q?R3irX6PW1M00M5Pc1bnfaeQ5eHqytrtaXwp8zoPT9t6AaOgyKa0i/mziy9Qc?=
 =?us-ascii?Q?PDg2BuQos9nUgRLzeuAtRvspXgfuN/S64fpvR/E/POiA7/9zU/AyyvTwyiO1?=
 =?us-ascii?Q?0LGQ5KyLFZOdkfkDOksEq4Zr6dqzIvJs6fGXAxVrds6CeoFUILtQQKk07kOq?=
 =?us-ascii?Q?P8NpSJwerLbefqhI+eHM+M2cpsua6TW8yCKoTjgd2yGu4AFWXj+Dx6VNsOBZ?=
 =?us-ascii?Q?eChU9JpcNsBYx+5jZspRRvzcGtnRLGbqChL/gToUCDg7ugd2FaaeE5wGPIr9?=
 =?us-ascii?Q?eHQmtnadqesvP+ygwq172vGqytmXDvaxxMykz17gxoOmngGZ0LnYpMFTzJIY?=
 =?us-ascii?Q?ZPwu1iqTVjOVOl+QJRLJwAEDvlZQzNyNHZAz+vu8YOTUzTDMqDZZIARsbVW+?=
 =?us-ascii?Q?WDxLjH/w5zqbeXOkvSM0JgxTfew5DkYOKxuKqMTwO5NGv/lL1D7gP0YJ9Ll/?=
 =?us-ascii?Q?BYS868PFIxCcVVc0VNlpi/Vsk/c/zc9KYACAMtqorG8rYhmfbozo1ukD+HLB?=
 =?us-ascii?Q?2B7LXGw19f7IgbnMNSTahBuPsgYSbsGGvh7JMbhQxC8q0ky5BLPPMcWD7v2f?=
 =?us-ascii?Q?jE+1DnVIRfZ/U4HhmBwD5Ti8eDRafjGcm24TdyS5Kopjlc6UeElg5+nGMXIK?=
 =?us-ascii?Q?QG7u8F2AOGAp5uf0Rz7jiwKfNniHTaLPQqKdXN6g7Z98zLbtNYHy43/lfNNQ?=
 =?us-ascii?Q?FjRMViN5duo6pphYIhDZZ64niiJAfP+3BCaQiuNnP2xidi6fKsfFpJJaPHuf?=
 =?us-ascii?Q?JUT8EIgWmfT01I8vyXRpHqT407aMCNxowTmtWh9uEr7BdO4KIxYmce3+BSwo?=
 =?us-ascii?Q?/DpngRU34ndPKA0wdjEkq5PA3p1AseUlKtZh310wqDik0HsAS723GaWK75wL?=
 =?us-ascii?Q?StnU4oIBgw76/37xcy9jyv6h1SnuqFNtDhbJuu7Z6AYbJLgjEn6R5mcP/C61?=
 =?us-ascii?Q?8p1WdFNjVOfPvfmD94EkTewlOtRSqB5Ji/1ILYVxnx81FqObyHxLyzPDYT29?=
 =?us-ascii?Q?tKUR/tX+c8xsnYutmID1qdAbHTG12ggXAZyR9vhXPAYoktf0BsKsCkX78fKb?=
 =?us-ascii?Q?Gj63DqXkZ6vTD3eEVJi3eTom+kG4X1uhcefOrdn0GrUFj+CIQAKoATI+EnXI?=
 =?us-ascii?Q?TTEcpuEyDySmr+v2mrQyWdBGhdb4Oz5G0qW95VB7wS2jpC29WTaT64TtZLsx?=
 =?us-ascii?Q?XxBU/R4C4Bx6LOsy1WOC+ilvmfJ2vIjZ0wAkdqJY7zfKPFmhKtHeEwQNCYhQ?=
 =?us-ascii?Q?fSQHvKr9NLSXj3e7idmJHyB3hSa0eBZY0igzvViZ8DmIRKS5/S/AXxY858Sm?=
 =?us-ascii?Q?WJoKRoNAz0V4HvPuu1PdLZkCHMSmqwyCgxepsN3ijTuArnkovwtPQiZZD10A?=
 =?us-ascii?Q?mc9IJazbkU62OnT5Mvk0WbWZYF1tb6L/xcLV2YUYLZGL07kpt9fU171J5K/l?=
 =?us-ascii?Q?HymCnfRUpiI9mJXCQStXfB4L2tMGdBGVyfzNr0DCx9hVS7fOkl/SaftTtmdj?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: navimatix.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d74d4eaa-7c5b-4f92-c689-08ddba3c15aa
X-MS-Exchange-CrossTenant-AuthSource: PA4PR01MB7726.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 14:15:38.2297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c87b4f54-b992-4813-8f3f-4a876324197f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BURkn52QSdPuiR4qfM6QEoMnzQSxwWZVKtMpKIrJa5wzpZQ00MuIVl2i7ymnplOQ78oND5lOJgWLRUPzavkMapgN2a/+kEpdVLFBN2rpYIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR01MB8044
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 03 Jul 2025 14:15:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1744

From: Natalie Dobrick <nata.dobrick@gmail.com>

Removed unused argument 'list' from usage message because the
option -l does not take an argument according to the *get_opt*
specification and *print_list* gets nothing passed, too.

Signed-off-by: Natalie Dobrick <nata.dobrick@gmail.com>
Signed-off-by: J=F6rg Sommer <joerg.sommer@navimatix.de>
---
 main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/main.c b/main.c
index 31e4dd5..feb0685 100644
--- a/main.c
+++ b/main.c
@@ -47,7 +47,7 @@
 static inline void
 print_usage(FILE *stream, char *progname)
 {
-	fprintf(stream, "Usage: %s [-d directory directory2 ...] [-e exclude] [-l=
 list] [-t timeout]"
+	fprintf(stream, "Usage: %s [-d directory directory2 ...] [-e exclude] [-l=
] [-t timeout]"
 			" [-x xml-filename] [-h] [ptest1 ptest2 ...]\n", progname);
 }
=20
--=20
2.48.1


