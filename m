Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA36FD062B
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 06:36:37 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14981.1773210992188554570
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 23:36:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=F1yrFE9Q;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7530ed8fe6=qi.chen@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B4pLkw2782713;
	Wed, 11 Mar 2026 06:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=Y26leeUCfNN6Qx8FzI828Mo7d1Fz+oE9ir9jOd9E0rA=; b=
	F1yrFE9QIrnD7xIjyDb2dB9lBlw/gzXou9fvLHZP5VKSBJOzIGXhbFD//lisngGC
	OiLFG9YG0cabVdQ2/Z1rl8sFyHc5ibDjX90jI4c8sglH4bS5/23NHSL/Rqw80LiV
	EBIvbidPzwZfE2oAshzc3nkC/khDHIRZQBxwVyaLIHvRRePXNveh851y6CfTZ8pM
	TMCi05K87cY7tSBQ8UqXarV01f88tkRVIR1cdZ1MX1LgHIjiN8K4RiQ0nI8GThCS
	O+w+1Nb8ikcWMbb3n91Q0XXzoxvJIGl1uj4GX8wBhAYquTSVNOdMv0nerZQ2N6x/
	+0Yis52b/Xy0NuOs0OE/3w==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cty22r772-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 06:36:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vH68n+2V3nWh+vK/ffBmh1lVKFPe0lbPwKM4EiPCRGwWIx0p2Srt4cvaCFvI3djMDNJKw+Xkd9q13D61yWfke9WYc/NhIKzQ5ITslNy9QC57hq5lGKHs9/djDzhgehyOcson5wZ8tyFtVIodlrQtixiGQzZGZIRLzVV9hc9PL6Vwq3MJHu1f8GI/0Acr8Msqzi919v+2jhjAnoneQ213wHyBeUZw7CvqnkCE2Wnlw+ecH8OVgyExDuZ+O/FY6VLgRk4AwWzii7x7MOEclyc1Q7cJcqFp+tls7IYyrBQyxBUfjccdSUUfZrEjmwB7v7IYL+TamtlIuktGpTSjHTlEbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y26leeUCfNN6Qx8FzI828Mo7d1Fz+oE9ir9jOd9E0rA=;
 b=l/m5oJ7h6TM8VqL6jaS82n1tcq6iDLw83/YfdeTm4UKk96uPt2YC/QEwkSJuZKxHsWOrr3PxRvL5cLp/0YJ4Y6KUSS9KI/Alv7Bn5JPYUnr6p1D1BGFtZLSWOeNJNHHf0p+zLTKw6JJCSBMpy0/wR2SYmbMoM6iR/+OOZ8xS3aRJaqltnsz9tJ3qMbZAj9GtTJ1UXXvyL+h8XD4gr9l5+ZKCm/BD8DPCiiyE/hGYqauOljAJL5Y9bxLbvigR3U107/dDY0raVASNQOxCSApGQ5iYDLt71cKIAQtsHj78g7pgEjfc9oe3geKZFUE8Mj5qY7GCg6A4u8DfHLl4YwWExg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by IA1PR11MB8787.namprd11.prod.outlook.com (2603:10b6:208:598::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 06:36:28 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Wed, 11 Mar 2026
 06:36:28 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH 08/11] upgrade-helper.py: avoid unnecessary and confusing short names
Date: Wed, 11 Mar 2026 14:35:54 +0800
Message-Id: <20260311063557.229656-8-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311063557.229656-1-Qi.Chen@windriver.com>
References: <20260311063557.229656-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|IA1PR11MB8787:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f26a124-b8af-4db4-859f-08de7f388698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	lvfmoS6LWn07tNalvZv1LKZPcScbwvQYUPnw7FMnTbT0Y5akCJQ0x2VXvmDybW7VvMwyaujHV2WL8nUVIsiL0lzd6mH02FYkNIqXBHDBaer/UvcmdUFzLD1r/WsWKFO2rJ6Lyk+b/RnnTcbhjcjo8xTpi0XL96rfaYByoM/wIb/WKb/6KH1iZdCZ91Jm96PiSVrj72u/8odVjlKAHtHilzma9Zouc/efvt3wnC61VOrpnPO1dotA7iqflA4+hBQP4WPRaJ7orQhQi3XxHzIE0+PFbg6owhNz4em+LXJrMFBw4AqejUhKiFgkiokXyCJGCECCelv/avdiBKPunF629gjrm3s4uu6bvczlhaTDmZO6xT830E+zG9DYW6+Q3K5d0eRTGPvrecgcHCABRMmd1hwn80v8Cw7G5jhLLCOl2yEe490q6YXkxynrazxs+Olox9fK5Mvxzpdhd1vnH8MJf4GRZBGU42qs1F5vZ+idjciSreAJFSfttWNTgSXPR7LxgUF4RCKpQBmrNaUiXIfMyOI/6+bz+VRonq2JmDUl/RXFsBCjSA3pX5fpzb1MK+tpFKTlD/ogDaS2p7ZLVvNQSrT2ucizj7WFWEz8/ewW8cM0iLnt9zex4v9p92VUmzHgWasLDFOzBvKF6v2munPcW1z0X9m0PPNbKxgDfkwHbBZv0zQcmpEsQtiAudAM45lv6bhyGIMCBHlvadJAYG/ari/op//RoDCGaHkb2/cC2OLiiUI5aHUwchXSIuWjqY8TPTifcrZxSucP8GsMZHgNC279R/1UBFK0gRxwqFj8mzU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fci6R3gn772biHjCtWwZVgOcMCrZgU9ujKNxjKAtsppFwfBM3i2qpk3COckD?=
 =?us-ascii?Q?LFzm2egFcTAe8zWaMPqRoyY8Y9YyRUbbUJ2coH9ZfxeUfLsbQoipaDIrKUOC?=
 =?us-ascii?Q?zPssjengdWTyP7A39YQxt6AN+KR8AxBpaOU1c2TfGeq4CEjRU6TnL5a6sxgb?=
 =?us-ascii?Q?KlEllDNyBzyDLT6afEw7GQCZ2vdE3IRfOgfEb9o2AAF6EKYuE9nY15Z9MU92?=
 =?us-ascii?Q?xPivVMX868AWE6/xCPtU5bNhBdRA0hCl3nMymm4t2K4oJfCswPWJnB87HJO6?=
 =?us-ascii?Q?ju0xBCa2SzP60fHOvy/KOdkmE6ighO3dj17Zz/6yxOzP++lncyf6JyEl6k0G?=
 =?us-ascii?Q?qU6s4yHRYFzqpLmsshRxTIBJFrMMRDPPUwIgOipe3dAJLU5lXOI3FtZGt6mb?=
 =?us-ascii?Q?uodbJU1vo2Wfe4WXxr9LbmZwAz6iomUqjgkqRdwr9klqMsvlqNYhLrDcAuvb?=
 =?us-ascii?Q?py9zEd57K1cRpheyfDC28FjsI70K4JoCkzhZIxwVk0mFR0+wE3pjIh55nlXk?=
 =?us-ascii?Q?EJ/8XgcliapF3W+i1NuWs4BS1ADIIkQuz8WWP6XMtsAowpRZDOmKY9Qh7etv?=
 =?us-ascii?Q?s8dhCknwnNjBZsV8FI7/Bspq8Ixvl0z/VTeOXza5t6qTKcf/dge8gioOdmgK?=
 =?us-ascii?Q?oDm0zhXqbu0Ew4OZyzbxlTiNSrsVJf+8mrK98xwdpUZrNqUPpUQ4ElWooKnc?=
 =?us-ascii?Q?2YsAH/ONwTJ+HdxqkYVPS4tuhjWDwUHgHyGGb65C95QdqFlj3ERFHPecDUiu?=
 =?us-ascii?Q?yB4AxSHYFU5ECTpof0QMjrQTHrhPERCJDbtoEfBm2hIHSGWzYBzLoA8ltGqB?=
 =?us-ascii?Q?dKy+/Bgc/jmk9huhzs0umY1fvUXIQ3/XXBMwAgtW5bPYxnc4kD1kB8fm00Rc?=
 =?us-ascii?Q?q/J1SIOVHpYTO4VONqONtTzcxwX5+jciayUBYaKztsDbXREwHJnVAy4D27Je?=
 =?us-ascii?Q?7dgKawECDEkdJpywBKfv4lcmkn04wY398Lbz4dhEYmoRypMrls/575fmnxJo?=
 =?us-ascii?Q?TGXG9/K/cxw1bAcNKz0V9CAdlsEXs+hUVCIARXNqDrNGKs4GejcJAF1aqU5V?=
 =?us-ascii?Q?Tvbn8I7S2Lc7WaueZWdYduix4qmiGMtqaCXBAgfbvkgYQhewi9vrlnWWPeki?=
 =?us-ascii?Q?km/mNPFzruR640pmShSZNqjaWQzy609p6JrFUIMYOzkSHnpO07bNZSujLYvk?=
 =?us-ascii?Q?whMAd16QYyIUXS16WwfVrUocaYZKu6foim0FgfQUL1PE2rl03Fuk9w/py0sf?=
 =?us-ascii?Q?T/YK0O8elnZ490yMpCkldKPVd7AZxqGLPG/yzCEmWSzSf4SAxVX3GmccN4hr?=
 =?us-ascii?Q?bWuoIzPerKMrEB7zmoCcO5oggCk1cx25iAdMpMhdIUNLdmP22O3yr09+iDZa?=
 =?us-ascii?Q?u2YlPSqPJFwgUxTHrYFeyrn93yW11Ym9HEFE0V83K4vPJhERH6MiC10rwh7L?=
 =?us-ascii?Q?s76WWNU4CSDDIAF459Hu5U13/or6ycD4UJCpHwsmmPQpCp9zJUPxq86Goch5?=
 =?us-ascii?Q?Ibulg1jIIUJAVNn8u20efbx7hwro/ujO81WtrccmIEQd0EQaUeNy6xRTbtRc?=
 =?us-ascii?Q?N6VEfaQArou17XzCwFVUkJymi7wx+gT2r0r5N3VAbT2zBMBDAPKE4HsctNgh?=
 =?us-ascii?Q?GYjmnhW3t8Ig9NygGYBqn2+6IBwW58tkaGabtac9LSf4K5VFzgX8sfTKKx9U?=
 =?us-ascii?Q?2xs5Ert0FtkR4yGKOoR8P/JMwvBDin1Rn752iLBwrZgZJh7hK0mqhVotoLDc?=
 =?us-ascii?Q?yqy3JaYRpA=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	dB9izseN5KyV3huppWX7sLUNAz885fsEUklx91dGQLGT0UDvSNNba/XhZx+utXEUAu2EXl01yK7tE8yP2OntBcLE3POLPOfFS2wU6WSrYNH5q/sCekY16YcaP8kRY8Y7Gbehylv87Yjh4Cx7guUqGdb2gBuMayZidDm3SuR14C0fzYY5sjw5iA7mLlv1zkOFslZfa01rCD/A6zY4+NflmCPyQ9OYVjzFHCLvoLg2gC58wpsSENI24FxvJrUY7h5HV22Lkk9kYDsctZzn2llTjLsDKWG77Zu5rbDfTwTcf28ypwCuqZt7QF+gNTo7xTP/kY+3hYSktFMyarwTntB/OQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f26a124-b8af-4db4-859f-08de7f388698
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 06:36:28.7944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z3PHbN3eqPfQG/jy5KrhBiOOO5ttFq+c2rcKJ50VET8/NzaT4e9+0zcjzWoq0QzJcWYd8tW77eAcRqKZi6+QuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8787
X-Authority-Analysis: v=2.4 cv=LqOfC3dc c=1 sm=1 tr=0 ts=69b10d6f cx=c_pps
 a=5NePcLBJi4TpPzNSyn8y/w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=WP5zsaevAAAA:8 a=qV09NasGAAAA:8 a=u-Ev9gDpdlag-DNbPkwA:9
 a=FdTzh2GWekK77mhwV6Dw:22 a=t8Kx07QrZZTALmIZmm-o:22 a=GlicbclHOgpI_Rq0ze_Y:22
X-Proofpoint-ORIG-GUID: -qcFdM66IsFSMBTb2mJe_KjTlwXfuldV
X-Proofpoint-GUID: -qcFdM66IsFSMBTb2mJe_KjTlwXfuldV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA1NCBTYWx0ZWRfX7VWL+YNcw9Mt
 RObhbBatde1T+ejjLBaUHCAxmA/Ievkz0phTOccfFA4pEeOAOiQmYaQeczRLmYVwfsxAr/oiVWK
 /t2bjyTmglb6dnqsfUYx3PianzHSm2s1fHsPhKBm0GtP81ab9T+nBzVP2jxib7U0tGQ8Wy4Amwm
 xfB8sB9HSXJrb3a8dfznqw6M8fAK0NgTgc6OA3D4TZCUpfGepp7y5jMVUpMcHZVp53i0UWUzAU1
 BD3YvLZJJXLH2Dy1tAry7FENYwh3f3696277nCera7sqolqqHh90tEfdh7NYvW67qm0fES/PtJS
 LAMFRCVwhXvXJG72mLwPPxDv/X6joKACxxSsWvLbsv49fBh/Lt7S44fjNbwDEPDhuNO25TGOY/Q
 JzYTqFykjKdCfSuOJHnIwHGwNHOjM58qemVUkJ9W+TgZSJ/+v91eft3gz2Xc9XgYsOHsbFFJCYr
 4LPffB18RryPM/hzekw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110054
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 06:36:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3409

From: Chen Qi <Qi.Chen@windriver.com>

The following two import...as... statements bring developers
little benefit.
import logging as log
import configparser as cp

For example, the second one is only used here:
cfg = cp.ConfigParser()

It should be clearer that we just use:
cfg = configparser.ConfigParser()

These two short names are not necessary and they will just confuse
users. Use their original module names directly.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 upgrade-helper.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/upgrade-helper.py b/upgrade-helper.py
index 428d66f..9920126 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -31,7 +31,7 @@ import argparse
 import os
 import subprocess
 
-import logging as log
+import logging
 from logging import debug as D
 from logging import info as I
 from logging import warning as W
@@ -41,7 +41,7 @@ from logging import critical as C
 import re
 import signal
 import sys
-import configparser as cp
+import configparser
 from datetime import datetime
 from datetime import date
 import shutil
@@ -125,7 +125,7 @@ def parse_config_file(config_file):
 
     if os.path.exists(cfg_file):
         D("Reading config file %s" % cfg_file)
-        cfg = cp.ConfigParser()
+        cfg = configparser.ConfigParser()
         cfg.read(cfg_file)
         try:
             settings_list = cfg.items("settings")
@@ -217,8 +217,8 @@ class Updater(object):
         os.mkdir(self.uh_recipes_failed_dir)
 
     def _add_file_logger(self):
-        fh = log.FileHandler(os.path.join(self.uh_work_dir, "upgrade-helper.log"))
-        logger = log.getLogger()
+        fh = logging.FileHandler(os.path.join(self.uh_work_dir, "upgrade-helper.log"))
+        logger = logging.getLogger()
         logger.addHandler(fh)
 
     def _get_status_msg(self, err):
@@ -755,10 +755,10 @@ if __name__ == "__main__":
 
     signal.signal(signal.SIGINT, close_child_processes)
 
-    debug_levels = [log.CRITICAL, log.ERROR, log.WARNING, log.INFO, log.DEBUG]
+    debug_levels = [logging.CRITICAL, logging.ERROR, logging.WARNING, logging.INFO, logging.DEBUG]
     args = parse_cmdline()
-    log.basicConfig(format='%(levelname)s:%(message)s',
-                    level=debug_levels[args.debug_level - 1])
+    logging.basicConfig(format='%(levelname)s:%(message)s',
+                        level=debug_levels[args.debug_level - 1])
     settings, maintainer_override = parse_config_file(args.config_file)
     if args.layer_names != '' and args.layer_dir == '':
         E("layer-dir is mandatory if layers are defined")
-- 
2.34.1


