Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEF2CAC597
	for <webhook@archiver.kernel.org>; Sat, 20 Sep 2025 07:10:21 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.5240.1758352220046875868
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 20 Sep 2025 00:10:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=KjHfL4iD;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=1358784b4f=yi.zhao@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58K77XgC3682684
	for <yocto-patches@lists.yoctoproject.org>; Sat, 20 Sep 2025 07:10:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=b4nDwYRW5HLtZKWQxnBi
	yAFfhg+gVj0iLki/BFvEhNc=; b=KjHfL4iD6S/CbbCV1Kehg6nSMLBIje5+mwXE
	H2rJhWRYTD5GRjy2OQJ2i3S/msCs99gZbaecHTBkPP0p07FkdvyDGTpoXXCaxOXc
	d3x5spzbPyH7bT4mPDcGL1huKUrQ5PNdZDOGJE2T33SuFkOehbhWxjtg+ZAB7vmM
	IqJuvZQ2d0VPs7rhY82ZC8zKOY0Y+uS+rszZuKfWQdwtrIeAWviJUYtRqO3hDDjx
	l7wPZN6uqSHRH4pYtSEvHhASky7Eq1VQ8duJ7L+1C+OMaV02c1VEfyN4tXKLcAWC
	60Y/mnmK/DmKl4gLPCNLEIlo2wTHL2p8sm05BpO4a64+0hRxFw==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011014.outbound.protection.outlook.com [40.107.208.14])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 499hg1g6b4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Sat, 20 Sep 2025 07:10:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YyAPnuln9FJF0tjWrdB2d9VdUVAkZYKCCKhfnUVdJV3rC5sN42FnmmhOGtFYMtL9P+0Yuk9v2zPDW0YpGA3Y6A/LZdWH4JWG+wya0Ehdps6OGbLYOkNrE1gMv8XCSgMifwDAzF6R2nF3LCchvBYFsc11oLkE5hzKiGx3/4W0YWT8b/lrvXmQqsDuPwaXQrGNiWPRZHolIw2AB1af8MO4FOPxtW847Z3wH3VQdtcEOkO/gFsKPC/mJ+ABtdz7/uU5wirCHJDdJtH0a18kAWEVCS+OrIpKY926J/mTgXYsUbXJtm9DcxzUj/QBBq1MakMxJlLNyKCSv8k56a1qywlvvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4nDwYRW5HLtZKWQxnBiyAFfhg+gVj0iLki/BFvEhNc=;
 b=fKR4b2MB+k4V7sVolGNhMZOLqcvlg5n9VSstDh8fyOk6+UfV6X4ST3cqV813lQtdePgNQ9p8wxd1cMH0qLPKh/BSbaEm1v4K+EcEy3UGVvW+Cd/I5lCSCXYyTspHhcaGcJ7XDZRuhjD+mkQqoYMBVTLnno+XHby3RvMIsvaAVwJ5/9SoeguL/DIe5tedkOB1qEAzhIZUZhXPQSi80ZBXhEB7YQkk7aKg5QFLUSpB+Ug2Am5axjXsgy54EWOAGasyr/wtm9OCmtyx6sPd0p2uHHOcLbxLJhWuHTqT6GEe1KDUW64IFPVAN75kqKeKcO1snif++LD7I0CoWJstZHOi3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 IA1PR11MB6418.namprd11.prod.outlook.com (2603:10b6:208:3aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Sat, 20 Sep
 2025 07:10:16 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%4]) with mapi id 15.20.9137.015; Sat, 20 Sep 2025
 07:10:15 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [walnascar][PATCH] openssh: update sshd_config
Date: Sat, 20 Sep 2025 15:09:58 +0800
Message-Id: <20250920070958.4025137-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0182.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::6) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|IA1PR11MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: bad1f0c3-8702-465d-b858-08ddf814bfcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?N9uB/3+rJCUlPlW4EMrHRQa5IgbPhw9/w56Vra17gfrz/DoWEJoYA87ileeg?=
 =?us-ascii?Q?PipufT3Vrnsg1umnxESrPIE49XKxgHPUNIV/1OCcK30wbqS+PS/irnHrn8i+?=
 =?us-ascii?Q?p755qQBHVZvzvP9ZjwVy6tNPrpdh0iFivj7xyo8d5k6XUEJPTqPwFHYkneea?=
 =?us-ascii?Q?hOEZFH4ijZvEWClw9G4+K+8a2YzxNTDKWTquHj2bRi6yirbkopSRgB4rXix1?=
 =?us-ascii?Q?oHrqeLsvCDDQi2l4QVdKazZLYrQFDd3hq/yzrZE2aBFPhfP5yNPshrG53OqI?=
 =?us-ascii?Q?uKL4pDz6Zl5sumO1sohJsTpKwmBYIM0+NGFo9OJ50uhfS0idjdhJ610glqnm?=
 =?us-ascii?Q?ni+UaD+Yv0dPGaM2p0aZ9RRIxf8BtmbZ5h9ota4AadMp1Lgi6gTbDt4fhMe8?=
 =?us-ascii?Q?fEjiiGieOcetZulfmCSUHo6jxQbH8ldYOVO+teMDvux727Ul0QCNSfIWx2tU?=
 =?us-ascii?Q?ovgUxYuBTXMRlraZxYjP20R2kKKCaT+VAPX3rHQmLEgSvPicPem7sVVpzyq2?=
 =?us-ascii?Q?NauQqVJdkpjA5FzIkBwn/oLIqxI8NKtrQ46An2urdPhhvTF+J8B+pFGMuvHd?=
 =?us-ascii?Q?DUV+NliFDJpFrmae6iPd69EURg3h8fAz08g5qzrb8qodF6opNgKCKKBX3+JY?=
 =?us-ascii?Q?ABxE9/MPkVsoezOkpPynxaPhvrWw5I7K39y5wwN0GQ76bWNcumh/PPIvM6mU?=
 =?us-ascii?Q?wBMIbgNYtzKfIYozNCK381clwUbJvmz+B0p8VERchjwh1K9rAQN05WCYGRGW?=
 =?us-ascii?Q?Jo9IznSh+23ha53T5i5uF44vj/WRg4/CGnWjnhjvegJTqxA5aMjTyOm8+zv+?=
 =?us-ascii?Q?7yi9pbTP5q1zbRBJr1T32XquZ+BAaJrk/u+MG3xOBNfVLJxgTSz8TdsdSrU/?=
 =?us-ascii?Q?lia2+bKFOMV7yb1PhsMN8KC1OetBgFVujxdrTexeOCeG4306Tq1+BGqHBDoA?=
 =?us-ascii?Q?1ekxfqJVLw1Il1qU14VoiEa/52aC9W5ThhyphADv1/uuXM+hUKbFBX/HqHSv?=
 =?us-ascii?Q?fy9BPXJwff0LZoiYaRGxPs92ZpkJKtolrZPZy03LcmLx3cGD6O3ICxF1PkjX?=
 =?us-ascii?Q?4u6IDznHRv6lX8cTIryn44rOrGp0j7w04o6W4oI4xWcqpCDgMLXhDQa9kx1Y?=
 =?us-ascii?Q?nnNAltEKAOW07VRKNKckKCfTyGHYPnhuHQ9afE64EWjeKFUKhbcCJAgzknM4?=
 =?us-ascii?Q?Zus6o3P6olcsfbwTsr9c1yJ9dkdkqgPPWwG1OS7Mt3QxbTR+LCvu41LWO1vF?=
 =?us-ascii?Q?p+3wRHmxoOnSUZo30f+F4og6TB+BoG/2ur+ArWnsntXToUnt/Yss8yslFuyG?=
 =?us-ascii?Q?kbn9JRhpAJu7qXN6zzGeUN9M+R0W8GqxruflFtNpP+DJrvCbvyjjttwrW3iL?=
 =?us-ascii?Q?2K+d/Xl4KBA36aB4zBlBXkLs5S/jR8O8NUEJC8pAG5ADY5p1nYRm8j2fRi2H?=
 =?us-ascii?Q?Otn+btndpjikda9sHBb5KGu0nm/tzz9te57jxGwWpcHS5ryt3rYcTQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?x35/teVck6Sil0LHZO8k9h7ku678OpA7k3CEGbg3d7Ko7d7G+SO3QFMTMfOY?=
 =?us-ascii?Q?gVti64IMo9fMgWAN237s5PmB+9hjv+7RpjoZPjK2jDFJM4T2kdIrQSyflKZK?=
 =?us-ascii?Q?k/eoFqEAfKxVVAr3w5k5ofdeBLHrIQLSMWFtHVwnzePpPuhWmPaDWnsf2xEj?=
 =?us-ascii?Q?34iFYgi+UcAusZmnrAWfuNnCkscAD8lGea4DoL5Fim/ptOX174yOxuwmwOAQ?=
 =?us-ascii?Q?no03clUwhdy/a0HU9lidjaznrIg4WSK/b/ThHQGgnIml2Mci3OgIXCvR4V92?=
 =?us-ascii?Q?LyT+d4uMI4JsXauKrMRIrFQWWzj5mWU8wh5oc8jYA1SJ3shqU1nuo/fxVR7A?=
 =?us-ascii?Q?4K5zXOfEKdycIa0QCYnlPF+ZtcKVT5eSNLHK1mj/KXxJUA4jXGSUCLhHtZwW?=
 =?us-ascii?Q?vOUny1yG8CSgwUmj+eKSoG9fk2KtujeiN46SlrteUb993gERsJbTL5Kb32dz?=
 =?us-ascii?Q?9P+8rsoZTPyLjXEdCZXlh6qVgc+jpQ+kC694/FDyfNoF7zZoo0MDvW/aC3rc?=
 =?us-ascii?Q?lvTZROBd59S6jtu6qIr3i8Ev6w/j549Hn/h8SCRKeoDU2PRa6gWS16h+Kepi?=
 =?us-ascii?Q?l3oyWp8NCxp/64zZlu5Vh5E7RHeAuzWXuSpBt8xqgbYZq5mu+HgRtD/8bDmW?=
 =?us-ascii?Q?CP/6TYnVQZ1W9s7F8Ooq+DdFmaMejEPMTbxO529LHzyfOmzPVjnEHbNg2loQ?=
 =?us-ascii?Q?meev7Sec/ljc0DQaOhOT3CT35tFccN6wrSFd3jfjHT1bsqKbNMGNTb38bgKg?=
 =?us-ascii?Q?IcRj3+cZm2qKQaQ+1O++75hTuH2tg9L7YWx0fyAO7r38DjBalelmcfHkP9AW?=
 =?us-ascii?Q?hhj7A4AjU2fTkPaDDrno5v7Jw36oSrkxdjAflYF9OK4v5suw65qHQW8q1rBn?=
 =?us-ascii?Q?4MfJ20Yf491KyICQzNod2lTQ34LgJC3iZVUCX/DTSZ+rxLhg/t3qPHBQ36O9?=
 =?us-ascii?Q?WHyD0szYOUpF83UMJgBPlnXXWaV+7kjNmcjR2sWIUY0CNTIpSS6K4EIeWkZ9?=
 =?us-ascii?Q?b5vomNZbpCc841nG8XTSVgJ+xvnuoCSGQIjUtWceuOgEDIm7AM+9IYmY7UMN?=
 =?us-ascii?Q?VUNPRS8zTUm9Lt1kwqEpapc39hqdJyYwIgyenLFR0PVjyNxeIYptHUto4uyZ?=
 =?us-ascii?Q?/Rq3fAyR5D9/ltRJ+sOfuKZfcY0/96PezKB6Nk20G6nPfhy+AcveyOYfR0QY?=
 =?us-ascii?Q?AC382wxTFofQGEzM+iZUVuISSbdIJB1+Gv2fZ+vPlNQ47u5fS3tnzSOYCxZI?=
 =?us-ascii?Q?YYWLhyyiuH517kn9AZ2faMd0AEmvQTsWzUnF/ysoJeCVHE5SA6nEawo8miNU?=
 =?us-ascii?Q?c4bTUYTYZQya1j5s/jyBSxkOGEjKMK0lyVyAC2PptFnSlbDnxaXs/zxmmfd3?=
 =?us-ascii?Q?o2G1VMksO1AiqcMJ8pfYOSCX+hfRN0wI7M/7nzwTJrpNbxM9yFBvy9b11BG9?=
 =?us-ascii?Q?BiSdb4Y3f8fehL5IwamECDehpaZ2hGfUuLhLBY+GuPlIsEwWcIxC4ca/Uocq?=
 =?us-ascii?Q?YXfa4lVyC8kzClY4IRNdFRuquj5BJ/FIaoCT6XX0LpJTkM7f1jtsss5+4kFA?=
 =?us-ascii?Q?9bqzp1yx9U5e7oSkz1eob+MNZsg0tInvEP62DBsX?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad1f0c3-8702-465d-b858-08ddf814bfcd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2025 07:10:15.9235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XeMfGugsLhiGyoRgEQP+tauS0gZyM5ASZyuDuOhApNor9hodeKewX4qPUgARQ1wPhvJnHlkK5qdrwDJWDy/zcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6418
X-Proofpoint-GUID: -T9Gm7sBhY2WXvPp4DfeoXVhFzC14iwa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDA2NyBTYWx0ZWRfX1Xis8iZHMKBu
 sdUDBFHFg/kLYEXZ/92SMWQ6x6iXzsZm3ZD+7KHq290mhSnczrSPRSIKJr7rUth5UKPH3vp+DIz
 dVD94cRo1WCfnPlhGL8N5u1NGjeiyh2tiW0cXJr0XAM6Z4h8zJf2nqoVei5ocHvrm7KtqiVjJgF
 yjm44TKOayNc8X62HgYuOFPQ1/IpXTWK1kB6pUL0/qqgOuVW7R9Ta5nzraUqsxa27fea6KO1bgy
 F6+odbiWlWaR3IE3qFx8zwUWkpEaS3PlnNtD2mQ700n9+jk0oU2awS58oie1Pk2gXW0ysaHIRWO
 d82R7gStSBPgaJLHWSBGc7vCcuJNMfVn/7y56XsP2BoY5SGe04WsCtHg3WJD80=
X-Authority-Analysis: v=2.4 cv=Yfi95xRf c=1 sm=1 tr=0 ts=68ce535a cx=c_pps
 a=RGFq7D/WLd/IouGP2/vkQQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=t7CeM3EgAAAA:8 a=uSm21Sp0dwqMU9z6AYoA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: -T9Gm7sBhY2WXvPp4DfeoXVhFzC14iwa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 20 Sep 2025 07:10:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2222

Synchronize sshd_config with that in oe-core.

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../openssh/files/sshd_config                 | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/recipes-connectivity/openssh/files/sshd_config b/recipes-connectivity/openssh/files/sshd_config
index 1c33ad0..18a69d9 100644
--- a/recipes-connectivity/openssh/files/sshd_config
+++ b/recipes-connectivity/openssh/files/sshd_config
@@ -1,4 +1,4 @@
-#	$OpenBSD: sshd_config,v 1.102 2018/02/16 02:32:40 djm Exp $
+#	$OpenBSD: sshd_config,v 1.104 2021/07/02 05:11:21 dtucker Exp $
 
 # This is the sshd server system-wide configuration file.  See
 # sshd_config(5) for more information.
@@ -10,6 +10,8 @@
 # possible, but leave them commented.  Uncommented options override the
 # default value.
 
+Include /etc/ssh/sshd_config.d/*.conf
+
 #Port 22
 #AddressFamily any
 #ListenAddress 0.0.0.0
@@ -38,7 +40,7 @@
 
 # The default is to check both .ssh/authorized_keys and .ssh/authorized_keys2
 # but this is overridden so installations will only check .ssh/authorized_keys
-#AuthorizedKeysFile	.ssh/authorized_keys
+AuthorizedKeysFile	.ssh/authorized_keys
 
 #AuthorizedPrincipalsFile none
 
@@ -57,9 +59,9 @@
 #PasswordAuthentication yes
 #PermitEmptyPasswords no
 
-# Change to yes to enable challenge-response passwords (beware issues with
-# some PAM modules and threads)
-ChallengeResponseAuthentication no
+# Change to yes to enable keyboard-interactive authentication (beware issues
+# with some PAM modules and threads)
+KbdInteractiveAuthentication no
 
 # Kerberos options
 #KerberosAuthentication no
@@ -73,13 +75,13 @@ ChallengeResponseAuthentication no
 
 # Set this to 'yes' to enable PAM authentication, account processing,
 # and session processing. If this is enabled, PAM authentication will
-# be allowed through the ChallengeResponseAuthentication and
+# be allowed through the KbdInteractiveAuthentication and
 # PasswordAuthentication.  Depending on your PAM configuration,
-# PAM authentication via ChallengeResponseAuthentication may bypass
+# PAM authentication via KbdInteractiveAuthentication may bypass
 # the setting of "PermitRootLogin without-password".
 # If you just want the PAM account and session checks to run without
 # PAM authentication, then enable this but set PasswordAuthentication
-# and ChallengeResponseAuthentication to 'no'.
+# and KbdInteractiveAuthentication to 'no'.
 UsePAM yes
 
 #AllowAgentForwarding yes
@@ -92,7 +94,6 @@ UsePAM yes
 #PrintMotd yes
 #PrintLastLog yes
 #TCPKeepAlive yes
-#UseLogin no
 #PermitUserEnvironment no
 Compression no
 ClientAliveInterval 15
-- 
2.34.1


