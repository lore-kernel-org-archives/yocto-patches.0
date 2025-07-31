Return-Path: <astewart@tektelic.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D502FC87FD2
	for <webhook@archiver.kernel.org>; Thu, 31 Jul 2025 19:36:02 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com (CH5PR02CU005.outbound.protection.outlook.com [40.107.200.77])
 by mx.groups.io with SMTP id smtpd.web10.71110.1753990554741579748
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 31 Jul 2025 12:35:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@Tektelic.onmicrosoft.com header.s=selector2-Tektelic-onmicrosoft-com header.b=cOnHfsAn;
 spf=pass (domain: tektelic.com, ip: 40.107.200.77, mailfrom: astewart@tektelic.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwAyv8oPu1w7WoTDayDcREAALx0IUwGfJqgd0019E+00xXbpYn1EiJCjJuTI6fTDDdM+XvDe98nG5UmACCe0JNDB9fBiL3LwzDnUd1tzZI+Ku5UBJGGhZpCaGCOYEU5pvw+S84dbZ3BzAjYKh6S72vyPJAVKA6Mm5suGZSblEsGuzctrwb2FvJWmPwiz4uOjFcloN/avQddqG2p+wN5nxtT4QB9CE1g1mFBgMV3h17YJjxYZjc0+MrKNtdYuVkTSE8BNMVxCX+zw5ZQHHiqOirhP2OxPR+oTk2K3sndwkCMA8VY8vidcFO94jmSSYzolgKAEgPo8tjFgQ7dCTnEkUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUVWxVyoUn9FlfUXtbvRu76kdLkcvqMvzjpD7ldheJA=;
 b=H7aA1lDkVv31lnm6zumCjgBJg65LJH9SbPGNpGBXJc5hyVUZ6pRWWtPGIqsZsQbS/2CNvFlnNy+Vh3ym8aTpftcx7uDJ/DP39u7dHK3b7eov03Y4swkKvQQ+uYfm3ZS9bY8LGT+7axRRckG/H1sfbx03tePNa1U1uMLVM0P5nOfwThzW4wqKdgxtKiZovIRr1SpJxOTnHbQc9H7i0+w4xRTGX/FSZLIsFqYXgXBx9FveR4teKbdj5EHQsXIrscYmunY6AhWZOXHbh6xnhtEYBKS7+Brd4lQ4R2IrOtp1kzleTmiIKMkDWqzzoynW/ekwgsNIs73X1bkwSnILB1wfJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tektelic.com; dmarc=pass action=none header.from=tektelic.com;
 dkim=pass header.d=tektelic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Tektelic.onmicrosoft.com; s=selector2-Tektelic-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUVWxVyoUn9FlfUXtbvRu76kdLkcvqMvzjpD7ldheJA=;
 b=cOnHfsAnwovGdlKKc8RhYbgt28IPM+Ae5i0fKX6y1GE2QOrAvmWreQBNr8p8kIOVM69+Clvi5oDRGP9r4y3X2diaiqcGgqNU1o2ndqU5I808x9p9rOnjLXIaFqBo/uTgztuVvP6lz4z9rbg8tFhHND9kkE1lvnd1KUHShnIZmaw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tektelic.com;
Received: from DM6PR05MB4923.namprd05.prod.outlook.com (2603:10b6:5:f9::28) by
 DM4PR05MB9037.namprd05.prod.outlook.com (2603:10b6:8:b3::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.12; Thu, 31 Jul 2025 19:35:50 +0000
Received: from DM6PR05MB4923.namprd05.prod.outlook.com
 ([fe80::27b8:b7d6:e940:74bc]) by DM6PR05MB4923.namprd05.prod.outlook.com
 ([fe80::27b8:b7d6:e940:74bc%5]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 19:35:43 +0000
From: Aidan Stewart <astewart@tektelic.com>
To: yocto-patches@lists.yoctoproject.org
CC: Aidan Stewart <astewart@tektelic.com>
Subject: [meta-security][scarthgap][PATCH] smack: Switch to CVE_STATUS
Date: Thu, 31 Jul 2025 13:35:30 -0600
Message-ID: <20250731193530.705140-1-astewart@tektelic.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:303:83::20) To DM6PR05MB4923.namprd05.prod.outlook.com
 (2603:10b6:5:f9::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR05MB4923:EE_|DM4PR05MB9037:EE_
X-MS-Office365-Filtering-Correlation-Id: 064a1f2a-c4b7-4c4f-4a70-08ddd06970a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?jthwFLHJgAS2jzidalKp5DdoUuc+984Kd3LbgY5tUthnFkE0F8mgk96A2Qjy?=
 =?us-ascii?Q?1Q7kafWlcDwtu+ZUdo6kGFaoWLimQ6VvmnMs+HAsqnzJypZ5N9Bw6x6AHSPj?=
 =?us-ascii?Q?ZadeHY9B3ZKrMFMaSqcCDE6kSpIEccRq+AkKaURtLsl2WgeBvVxaqEMmugik?=
 =?us-ascii?Q?U2ci6qZ5TV1gCgFK3g5RnQkw89CllTgvjV+xcvIVgl64AqX4uimNVW4pUJFy?=
 =?us-ascii?Q?UYAOFLp74gNPpBmTD0lMntRse6pDztw8NUA58gcpjeXSvp5QFCIUJC96lnXw?=
 =?us-ascii?Q?dfaLCb+Q7p7Musjp0AC+NZYRUZMKByZZELENOSSC+hgmPvuhmXATjeUaDtY2?=
 =?us-ascii?Q?vyk1Fcc3ckFJ49oVALA8vngoVzGfZk2ZRpR8+tHLWucxxhMtwG94909G2dNA?=
 =?us-ascii?Q?HcCjlINSwao47VbLKG4ARwC5T4g0My8Vq76bW0ApsvYpwj37iHmKaJGyQ/sF?=
 =?us-ascii?Q?mjc38A6IYgbbWa2ImlUvNUmBcx3Fpp6tyOL2CwLV8dW7Cxw/Tm399CtLhfJG?=
 =?us-ascii?Q?EumSQjBcHK6g7BaWn8ZtaIlLTiPJDVhfxO2KPdRhRz2aiFEI+zHx3cjUBX0l?=
 =?us-ascii?Q?IK24QE+L5GzaAnyyvxiloIgfH/Rkqslg1Io4sVawVVPUs2wDOvUi0sEI4Nql?=
 =?us-ascii?Q?wbS8y9VNWRhc+84/l2E2wJOzJjoXb+qUCMsXknOB4OjJeUySzGZhc98VDFef?=
 =?us-ascii?Q?4aoCkUM7NArsbNMlXJZvJKmfg064BF1nWENT7J0l02M/6Y62a/UnybVKZHuW?=
 =?us-ascii?Q?Rdaaxo+LVV8ofh17xP2JGOeYeHQ+kHQWMiVEsmToAzAHQQ0pUR23hE8LzI5c?=
 =?us-ascii?Q?SKJaNtHBOjeYgBTzSJUV8L9Ts1phAw5qKnzhAsqamSBlZVJiBTQ/eS6Mc3J9?=
 =?us-ascii?Q?cMgjstvyyy0VQGkjoHPtlz7FH8TOBkHJNYZ84WysvYv8bYdtDcgosg/MLkDj?=
 =?us-ascii?Q?lylUytX1OYI9z5FeOHeaLsgH7Pfzv1m6q3zdFOh7ELLcqi5DjTilkCUhnGIU?=
 =?us-ascii?Q?4mgSeF7fJBC+u+ckb896V1ojoVynRg8fhNxl0eS2xqfwTZ9Mofp5ZqsHA9op?=
 =?us-ascii?Q?ydZuoLqYlhMbWg0Z66MPjZ+PFh9aiM60p11JDF076oAov8WTL3CD9325isIE?=
 =?us-ascii?Q?LOzYhrdRQbT+6hPZiTQE0afQDTzsHW8vmgykmV4tp0FLY7PWMCK4ZgMeAUfF?=
 =?us-ascii?Q?NNKel7aUqYAO8HQhVX6UBNav0JgoTd+zY2AdmR1hJV+uZl+rpO6SwBKw9hND?=
 =?us-ascii?Q?Ipl0VrpuXdMvI4Pz2D/dJvszFqrftYA1/cam/fxVaVRhmIlOz7yLg9ucw/nn?=
 =?us-ascii?Q?Eh3ZJl/i6H6qOEm2hp2ebUqot7jNv2/jUstzpS+nAK9gw6jQutXtg80RWQ04?=
 =?us-ascii?Q?2Dnz1jL0JxGO+cirB6AhxbDaEX1mXzfXXWPqq2SIJ+ODjArRmtPNHPEOZZ+s?=
 =?us-ascii?Q?WsaR2I15T2A=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR05MB4923.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5LHk/dgLB/ibWPnxR5cFGyYrLuArIPn7uGFvcPqNqEETzrQpczkIkgstDrWM?=
 =?us-ascii?Q?7QX/XbKXMs+qyd5duQkmrCmUfYQ6XNMIoy3oq8fgDO0vLz0s437bhiyR5RmL?=
 =?us-ascii?Q?TvSW78fmJd4k3BWR5/2Hd6oGcvNR0zSbr/2EiMrIbZVjl3T7N4tbGEhsPMIt?=
 =?us-ascii?Q?gFar9OQFlvUR3Cl8WjuGsD0Tp9G1fTp5bYMvSD7tYVAZSbhh9zE0ysYUKpFQ?=
 =?us-ascii?Q?Fc6xGeHIoCAj9VbxyDS+IakXFEJ8BTOPgpLbFi2eZmNQHXsYkBSD+5YW4mOS?=
 =?us-ascii?Q?IqQKCmSI8QoCPXZZvj61S152t1ZSHYTC+8mQAJSJhcifs6+lFN/ygCknGL+D?=
 =?us-ascii?Q?Fa06Y993MjXuz46+xJ21rz9D4CHG0M5MtJMgIU/UpwVrTXpFKXYDxHb8ZKyl?=
 =?us-ascii?Q?pZ4nhr3mRvuR2RApj+Q+1x0zvw/CWk7m+P6a58Ja3/SXdwhwoaNtZ+C57k58?=
 =?us-ascii?Q?2yhnPcmEvRs39f0ImN7lpUugI4waHVRgnZaoF/+UZt0iJCm/cmkuRgxCne4m?=
 =?us-ascii?Q?IFl4gf/lv2J46yE+SJrvvPjJuhNrDGqS+1TC0zHhRrRqnlQiR8NskMJDtM3T?=
 =?us-ascii?Q?sqdVHYCaQEN6rl/oPBkvNWFu+MAGTAb2U5zDmOqNLzWwLIEHKNp00Rl/lwlZ?=
 =?us-ascii?Q?O2uoegU88C2v46Q+5cgcJVCscBbAVsgRVcfpdy0nDgQpqGJqQFOOFqkqOZY4?=
 =?us-ascii?Q?FTTqcD2DcvN2leMWGrzTbF9we3pIU6PqMAC2gNdXkhPlNIIBU86wHD/0CSzV?=
 =?us-ascii?Q?+zdXlnpA0z8e6Kc8ap3Sc4ONxTNAnYgpF06hk2F7DP5nX/7QKjYIIxP/+mZg?=
 =?us-ascii?Q?mukyqUcbZJngtSJiLT/iU9yyFde1a5WfNNBE/I/tQBVW0/OTeDHDZzQXxyVD?=
 =?us-ascii?Q?on+d6pK3ACxbCmtXae7Wy93uuWsnq7wUt3eVp5BhyiTbP2DSYayKWcng9Pbz?=
 =?us-ascii?Q?66scyLRx0j75hgn0tJcLeNRQnqX9MVtF8mexGEdU219TSCgWduHGRn4F2ZYB?=
 =?us-ascii?Q?IJf3TAt3Onpn12wtLU/P/5lZ3ivrPmFRCqWw3UMWoZnwOY0M/vF1LG1tHJyz?=
 =?us-ascii?Q?4vlqhL8syvU7RSNoCRkeFZYq0fuBBOgYH0uROTwmXbUDa2gxLJemheCOB//e?=
 =?us-ascii?Q?Zvw2L8mIXyACVbnUCe6fOQo/ec8XvDH7InytEH4Kz76nzlTgZjPFVYB1ujkc?=
 =?us-ascii?Q?ZZGPrYImfpPPcSz41AxzBe0axE7bFSuJurNUXf/U6a+xX42cSrKecz1oIL7+?=
 =?us-ascii?Q?WYofYERyHzgqBmyydpNGbJU1R9R9Uyf5PqFINTYNracsLQmVPG4exJ3jGcmd?=
 =?us-ascii?Q?J5qCNo8Sp8F76tOw5Uana62NHuG7zcXffeV5erT6TzjJ/MQ6OFK28JVbggwX?=
 =?us-ascii?Q?weHyt2er+0HC7yLaCE4BCmqr3dcdmKjNfdD7qj/37ArNnsWXqYTKCd06acf0?=
 =?us-ascii?Q?3fkPLCBcmpR90hUA4Y2Gy5x72I0hSNAqhdq8Qj94EtaxGnpOh0vyYH4GayWR?=
 =?us-ascii?Q?jPmAmRmJ9Tcevmq7k0bPu/MOfsnivZNFbmeRo1nfzI5q1kqz7ogxyWPoPPJg?=
 =?us-ascii?Q?lloDYxNmEpH2xpcQG7A/tjikPRyBonKUkWvROz+o?=
X-OriginatorOrg: tektelic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 064a1f2a-c4b7-4c4f-4a70-08ddd06970a8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR05MB4923.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 19:35:43.8814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 852583a0-3638-4a6d-8abc-0bf61d273218
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5KOiq6I0OsJ1Zsy/HQ18ws7Ceizxq7kV1A9PWKLhbu9852aa2KZ3mJ5MXb1nolu3azLF3rdQelmx/qhSc4lbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR05MB9037
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 31 Jul 2025 19:36:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1880

CVE_CHECK_IGNORE has been deprecated starting with the Nanbield
release.

Signed-off-by: Aidan Stewart <astewart@tektelic.com>
---
 recipes-mac/smack/smack_1.3.1.bb | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/recipes-mac/smack/smack_1.3.1.bb b/recipes-mac/smack/smack_1.3=
.1.bb
index 6c523929088e..04e7a6e9ad1c 100644
--- a/recipes-mac/smack/smack_1.3.1.bb
+++ b/recipes-mac/smack/smack_1.3.1.bb
@@ -13,10 +13,9 @@ SRC_URI =3D " \
=20
 PV =3D "1.3.1"
=20
-# CVE-2014-0363, CVE-2014-0364, CVE-2016-10027 is valnerble for other prod=
uct.
-CVE_CHECK_IGNORE +=3D "CVE-2014-0363"
-CVE_CHECK_IGNORE +=3D "CVE-2014-0364"
-CVE_CHECK_IGNORE +=3D "CVE-2016-10027"
+CVE_STATUS[CVE-2014-0363] =3D "cpe-incorrect: Affects Ignite Realtime Smac=
k XMPP API"
+CVE_STATUS[CVE-2014-0364] =3D "cpe-incorrect: Affects Ignite Realtime Smac=
k XMPP API"
+CVE_STATUS[CVE-2016-10027] =3D "cpe-incorrect: Affects Ignite Realtime Sma=
ck XMPP API"
=20
 inherit autotools update-rc.d pkgconfig ptest
 inherit ${@bb.utils.contains('VIRTUAL-RUNTIME_init_manager','systemd','sys=
temd','', d)}
--=20
2.50.1


