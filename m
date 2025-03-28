Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4403DC36010
	for <webhook@archiver.kernel.org>; Fri, 28 Mar 2025 08:43:25 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.6763.1743151400245318913
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 28 Mar 2025 01:43:20 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=5182795c15=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52S5UUjB009562
	for <yocto-patches@lists.yoctoproject.org>; Fri, 28 Mar 2025 08:43:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hm68pye9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 28 Mar 2025 08:43:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXkSnOyGJOS8jf1utuE+7waZ+8qe7diZhjcPMWVhoPJhapCcfZ4uSuIP10sE1KyYagApB2mx/ShDmRe7kXfEzJr02cqgpSxFfgW8+AX2hhmeMfii5O5A78bYTydq1/VsLeaXx64XGulO7kIfBwrF4BNSjNJ6zfQS/xXJAEi+wEqrL28GyL8IZncQgqki8gNB8CslRVlQc10rOVl8FaAljCI7Q34sgx/YMT3GuNBY4yWuyxBv7Iv3YEEPxwwiiriCy3ug9LP4nbeF6IGOF+pAECfWmK7Jc8iAr475yoBtuIb5YLHMQiHV+lcDMl0iZdulac9MuccYRFxXqBdnrbqLYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fk679OSvnpt4rKT8hYD+A0lgrdXniI+xK03AtqLJbAw=;
 b=ofABb3+6BnjTWZ0KdpzN0Nfa4+vH/O55kgXI0QZu6JPwnzTU6UF/J51TbqzukDrN1J/Egu2Q+06CCrCg2RAumP5Z2/vA96ImfMYAHmzspGBdCNX1lNOK7U5oq9RVj2AUUt42mpMt9LZdxbzjbYmzfQVafuLFiYgfYAtClnwygXrVztDfUaTIMUaqLfcTR4h/thNx37KrjkuNeqYRGLyFJZagYuCdtw7cRKyHoftlNwo2w+WcjEagPzBN+lqmdKDUQeHxCmeaXQUojwTMNJuREvFT26XKReujj4XOj+m688H0pPt9RrgdxLvfKzbQHBN+dxnLjDbETnrLLcg9vv5j2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 SA2PR11MB5052.namprd11.prod.outlook.com (2603:10b6:806:fa::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Fri, 28 Mar 2025 08:43:16 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%5]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 08:43:16 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-mingw][PATCH] libxcrypt: fix build error for nativesdk
Date: Fri, 28 Mar 2025 16:43:00 +0800
Message-Id: <20250328084300.2001238-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::12) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|SA2PR11MB5052:EE_
X-MS-Office365-Filtering-Correlation-Id: 690ee802-4d59-4e0c-b11d-08dd6dd4957d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?CwXKQ4qSW9PFc5sa8+oI643WXpgZmQ3Mr2dl576pDWKlpmFYLqz1P880wJlc?=
 =?us-ascii?Q?uJCnC1CxKf508uYxZNJrLsXAee400Jt+1AoT/0G1szyQAAcRSjWribhUhs7S?=
 =?us-ascii?Q?DflYAhMYGXHyOAtGL98re5aVEERUx+/s2bFBtaqEe1pUHC80+IDWOvDJHswZ?=
 =?us-ascii?Q?SsjrT6kQUKQ/G6iFJ1+Pc8DKBInXkcFAwuueye19wxqO4vaZUV1xanWw25rq?=
 =?us-ascii?Q?sbwnyyQrMpG2TU0rD0oj4d5Y+pidFcARH6T9Umlu16lb5m6JJIUVx4t+dO0p?=
 =?us-ascii?Q?Aq7U4J5RgK2i2HhdDDwj01tt4yt8/YDjEEaGjXHfHZsnrEAhy7jO9Hv2eiOa?=
 =?us-ascii?Q?D7PTGqjaEydo4MqvzA+1oLjllqNFP3JtpXS3weblK1a1U0lKV+93cLTiX/eF?=
 =?us-ascii?Q?GKrP4Uuhx0gCyNJAYuzvHMCZKVAtsoBindvbMILpRkfGu/KcYSu1929eiiGZ?=
 =?us-ascii?Q?PTBCoqDyfLfICGSodMnZAXqP1c4BkGJ21Nx5uN8cVwUY5tvvC4WOXeTxUby4?=
 =?us-ascii?Q?7ddpOYLeaUpNToRhRxfyJd76ITRFc6iI2CPzLvXqa+lEKSXPK8xr+qFm8/9e?=
 =?us-ascii?Q?ua5RGpvzWxfcErmKFqysl1f9qk94Qfzbvqd2Jf3cSaWxaXoTZhW3OxN6hPPg?=
 =?us-ascii?Q?qC6upkqsmaMqPoR47PjoDaFTL+IfcOjeWkCUMdeNLQT7+IJniZxpm403hJip?=
 =?us-ascii?Q?td5KKujFhy1Ay1Y7UXty3pMxmFk4IeO0g1XhkgZW256kWrFDnr2cgVfEEA8I?=
 =?us-ascii?Q?VGTd5zx52sv2/pf+6aoIN4DMk7KIu2ZlqsTB0Kjg8DoPbpBCU/2Q3QXwQsrz?=
 =?us-ascii?Q?js5GwwcSvpjjXaeEvfLNIeb52u7RHpaufwQnh3g5Uz9BRiDvLwNhKxvOAK+U?=
 =?us-ascii?Q?QfimbRZZkO73sLZXavDIokQJOBtA1ztrxDo4rjIUxpPKskM8zU7Tzl51bPwc?=
 =?us-ascii?Q?0D5W6kCpVzEqnnX7RKR8wl5DYndpVkDAVXo0fUCOb4mFKKJ8gBVDfMtg7dJ5?=
 =?us-ascii?Q?7KgNnAOjkklFnRpxbG5AvrwEo7gMGhNrfayUXVOHcq79aAghEX08wMWtYZ1M?=
 =?us-ascii?Q?FQ6N8m0V7XpjmNQZaNK3DL/bthlxMkWE8iCn0N9TlZvvK9b5BeB/SkNwt9JI?=
 =?us-ascii?Q?pShFrjlYR+/SuEyu2C8Bj4OCpWihusZrZSXzeyr2FgezaOSkMv8RwzWmq1Zg?=
 =?us-ascii?Q?vafmwfQN+9B68emcun9w78Waxn8+GCX8mR86fFFc81vSDVmtGp9n2DvguH2W?=
 =?us-ascii?Q?pP/m0ISxrHQ5outUdU1ZPQvS+8KJO+gcx6hhj1j2ag16aoAAEsqIBTDm1j3i?=
 =?us-ascii?Q?hmwRMZiFL37/SmTgEVChUqR0pudvaOvR7nk4uaFMMldyf9+DndxRChuipfW7?=
 =?us-ascii?Q?lST4+nzeLSiv9Z5TyUfWXIDxZxG18g+xsAh/q06Qbcu5tCX6LSx6FY8zfOdV?=
 =?us-ascii?Q?EcfPoQlThEs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?06YuJUlThrGXgh6i2enWA7IZ/PQrUTW41GzUD9OWJcO1ejkhklrVtH9NrL0N?=
 =?us-ascii?Q?jaYPHkT/6TDncSzvT7d6lRkJNRYQ7fviDDt2kvnKbE0rVjomdBMz7eobUX+a?=
 =?us-ascii?Q?xHZCb7rUEZn7de95xbvSAEszBkUIZ64nLPMs9kSX+00244TmhJK45/E/ohmh?=
 =?us-ascii?Q?VD1CagPuQIS7Jqnux0jvgRh67D8pFn8Dwn6kgZFaoUlP+pHEBw41kfMJap2x?=
 =?us-ascii?Q?9xk+R0VNgMFIZKkgaqkvOB6JUPEJnZxbbEVv9swgnpMoHU6vcdmgnTPUzpK2?=
 =?us-ascii?Q?P3oRLVNEwauw+ZW8fqTr0EpRCO295+o+BtBofuH5iTc/wMmteLr+e36DXDOi?=
 =?us-ascii?Q?bkee2xM9obWGFZ9gq1HGW+MjJCYkxoyAEgHLWQIK2hQvC4GgFnsCP4kYkC+o?=
 =?us-ascii?Q?wQUGMHlBOy5BWHMZZnj5DT2qWpQ9UksK+4yEPHtbxmfCYNM5adVs2fIPCJ7f?=
 =?us-ascii?Q?ltippuZ3Arq5c641j3w8KF/fHiX2SH98RgwKCwhFC/cbQMIFdb5J4gApqV/Z?=
 =?us-ascii?Q?2iCTAJe6H6VQdJDL8bc/uIUy3dCcAzCgJ/YLpjd1sxaPwWn/aynvYcdfPmBA?=
 =?us-ascii?Q?QRVD5n18ecS6smqis+hX8lyiAa5U8y8rUDFmIHwlI+KmYIGSZ3YchgxKi+F+?=
 =?us-ascii?Q?Qd6oooncatgsCPfklvhgJBQegGY//iATqPjNZBrXMmIpIPhElGHsMbmf5DWQ?=
 =?us-ascii?Q?+Nt6Bmsp2kZV+jclriKF1t1I/yLW1O6Ht45O0yDS5Iu4D7fROyCBLLvUytSm?=
 =?us-ascii?Q?cQkmGo9tekjXqPEYbhUnZyws0LcIpm380ey4IVtoRfV1ksamFYWFLc+nB52T?=
 =?us-ascii?Q?0KmnUI/qo1PJOQxg25wmEVMLG1Oa0MrEVNwTpdjixcMlSTVTpuOzvKRuqw9r?=
 =?us-ascii?Q?Ozx2bdmkYA0y+B4GQ5XMEz7uR7RlWBzv6jGwHw1yjupfNjaSWgZnXceVl4mS?=
 =?us-ascii?Q?k3txIWkh+MK4oOWQNIXMoRePn3vjI2lvSN6skQDddT44362KEjGz/y56FWEl?=
 =?us-ascii?Q?Kj+nkV265289yryAeuNWeMBaf6TUfXh+MPY0pNk9z5159iLHPgr5Owswsj2z?=
 =?us-ascii?Q?7iHmxbyY+R4Z/S3zzZu8WoZKKL4TclKraUrCqsPQ46uQA0mbZ81CFPlVEYlB?=
 =?us-ascii?Q?OcYbCVDIL/dmD3/H7G0cFYBShCMxsIZc/UCj/1p9R1N4CdCH06Nlld6XlnLb?=
 =?us-ascii?Q?8oIexrpXwdvB2ZgAELo5HM2vR/8uUwYMjRmcqsV86f0WepxOqjMHbeKyOgfL?=
 =?us-ascii?Q?rHTD4AJf5Bzt83qDrouPGhF4qBbEQRsRERLID0qvoQpdL0YyqLXzaUoyLxDn?=
 =?us-ascii?Q?dfMnbkb61ErjQRWcgGjvFl3Ktje7WymJCRRL0w/+WFAxKRJom5Mt0BAsZLpe?=
 =?us-ascii?Q?M7CTGqrpFqHHU2GlU7JRIPiuFgOu3MS1Zb5JjgkFTtqexVuNukyTjiJYlNRC?=
 =?us-ascii?Q?SW5JAL2ZU4KgsMmvUTmFZGZSFxxz4oGlOkm08y7xrJM0DknTfRAdapj1KNe4?=
 =?us-ascii?Q?2og9JQFhYPh6Hz4aRu8cMlkHh7fCdgosFpKkYv0vjtcdVtmeTxZ44qv4d0p0?=
 =?us-ascii?Q?k2wqv2LbZVeMiLDdikmseo6gS3r7Z4kx36PpF7hR?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690ee802-4d59-4e0c-b11d-08dd6dd4957d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 08:43:16.6745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HOmDcEAK2XbOEGhVNDfkFbxQMQJLOZe+RuFnxXCaQGItN7t9woTkfiG+uyRgXIbBRBpbudyW/sZqIo1IdkMAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5052
X-Proofpoint-ORIG-GUID: Z4AVxgbK9iHcrXKqsPoY6eNurCtg_SJK
X-Authority-Analysis: v=2.4 cv=etjfzppX c=1 sm=1 tr=0 ts=67e66127 cx=c_pps a=Bc47kgIQ+uE7vzpOcRUeGA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=H5OGdu5hBBwA:10 a=t7CeM3EgAAAA:8 a=XpYqKM7IWujKuVQjIXcA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: Z4AVxgbK9iHcrXKqsPoY6eNurCtg_SJK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_04,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503280059
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 28 Mar 2025 08:43:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1271

From: Wenlin Kang <wenlin.kang@windriver.com>

Steps to reproduce
  1) add line in local.conf
     SDKMACHINE = "x86_64-mingw32"
  2) bitbake nativesdk-libxcrypt

Fix:
1. pedantic error
  | ../git/lib/crypt.c:316:24: error: ISO C does not allow extra ';' outside of a function [-Werror=pedantic]
  |   316 | SYMVER_crypt_gensalt_rn;
  |       |

2. conversion error
  | ../git/lib/util-get-random-bytes.c: In function '_crypt_get_random_bytes':
  | ../git/lib/util-get-random-bytes.c:140:42: error: conversion from 'size_t' {aka 'long long unsigned int'} to 'unsigned int' may change value [-Werror=conversion]
  |   140 |           ssize_t nread = read (fd, buf, buflen);

Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...dom-bytes.c-fixed-conversion-error-w.patch | 47 +++++++++++++++++++
 recipes-core/libxcrypt/libxcrypt_%.bbappend   |  7 +++
 2 files changed, 54 insertions(+)
 create mode 100644 recipes-core/libxcrypt/libxcrypt/0001-lib-util-get-random-bytes.c-fixed-conversion-error-w.patch
 create mode 100644 recipes-core/libxcrypt/libxcrypt_%.bbappend

diff --git a/recipes-core/libxcrypt/libxcrypt/0001-lib-util-get-random-bytes.c-fixed-conversion-error-w.patch b/recipes-core/libxcrypt/libxcrypt/0001-lib-util-get-random-bytes.c-fixed-conversion-error-w.patch
new file mode 100644
index 0000000..6320494
--- /dev/null
+++ b/recipes-core/libxcrypt/libxcrypt/0001-lib-util-get-random-bytes.c-fixed-conversion-error-w.patch
@@ -0,0 +1,47 @@
+From 7c45edc1e55295fc5f45cf8ff9e782febfa7fd84 Mon Sep 17 00:00:00 2001
+From: Wenlin Kang <wenlin.kang@windriver.com>
+Date: Mon, 6 Nov 2023 14:43:28 +0800
+Subject: [PATCH] lib/util-get-random-bytes.c: fixed conversion error with
+ mingw
+
+With x86_64-w64-mingw32-gcc. get below error:
+| ../git/lib/util-get-random-bytes.c: In function '_crypt_get_random_bytes':
+| ../git/lib/util-get-random-bytes.c:140:42: error: conversion from 'size_t' {aka 'long long unsigned int'} to 'unsigned int' may change value [-Werror=conversion]
+|   140 |           ssize_t nread = read (fd, buf, buflen);
+|       |                                          ^~~~~~
+
+In util-get-random-bytes.c, has get_random_bytes(void *buf, size_t buflen),
+but in mingw-w64-mingw-w64/mingw-w64-headers/crt/io.h, read() has "unsigned int"
+read(int _FileHandle,void *_DstBuf,unsigned int _MaxCharCount), and has:
+ #ifdef _WIN64
+   __MINGW_EXTENSION typedef unsigned __int64 size_t;
+ #else
+   typedef unsigned int size_t;
+ #endif /* _WIN64 */
+
+Upstream-Status: Pending
+
+Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
+---
+ lib/util-get-random-bytes.c | 4 ++++
+ 1 file changed, 4 insertions(+)
+
+diff --git a/lib/util-get-random-bytes.c b/lib/util-get-random-bytes.c
+index 79816db..68cd378 100644
+--- a/lib/util-get-random-bytes.c
++++ b/lib/util-get-random-bytes.c
+@@ -137,7 +137,11 @@ get_random_bytes(void *buf, size_t buflen)
+         dev_urandom_doesnt_work = true;
+       else
+         {
++#ifdef _WIN64
++          ssize_t nread = read (fd, buf, (unsigned int)buflen);
++#else
+           ssize_t nread = read (fd, buf, buflen);
++#endif
+           if (nread < 0 || (size_t)nread < buflen)
+             dev_urandom_doesnt_work = true;
+ 
+-- 
+2.34.1
+
diff --git a/recipes-core/libxcrypt/libxcrypt_%.bbappend b/recipes-core/libxcrypt/libxcrypt_%.bbappend
new file mode 100644
index 0000000..97bf008
--- /dev/null
+++ b/recipes-core/libxcrypt/libxcrypt_%.bbappend
@@ -0,0 +1,7 @@
+FILESEXTRAPATHS:prepend:mingw32 := "${THISDIR}/${BPN}:"
+
+SRC_URI:append:mingw32 = " \
+                          file://0001-lib-util-get-random-bytes.c-fixed-conversion-error-w.patch \
+                         "
+
+CFLAGS:append:class-nativesdk:mingw32 = " -Wno-pedantic"
-- 
2.34.1


