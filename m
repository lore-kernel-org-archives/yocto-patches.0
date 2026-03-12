Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9DDFED2D7
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 03:52:55 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13959.1773287566193950401
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Mar 2026 20:52:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=X4fzJTF8;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75310a015d=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C3pA0m2877391;
	Thu, 12 Mar 2026 03:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=Y26leeUCfNN6Qx8FzI828Mo7d1Fz+oE9ir9jOd9E0rA=; b=
	X4fzJTF8dh77jfsCkg3TVBM3VZ1N/s7IQWvh/u0UXnrkcOuzTkh8lgVGMWdGRvdc
	5YUiYnSZeTMe4M10M7aAo8xv7jXs2G5IktfqZQLrYQqmAvbC8Lv1CFowVveWzW0v
	26cDR9rbnkqlsH9jgvMBPpRG77pjKaqWCZW8xo2FT3DrrmAtiphKlTXxjKN/MsoA
	XeL0gWm75ljTWCaFpKCDbLdwntahNbLhTW1AqYMogMGVARfLLWHlzzU6y7EGUlfk
	LC7+c6ziBdtkSkdBKC5qVy2vrwK4VePrqTWAqLM2Hgp8ldy8OFUKcFCojLdfUt5v
	xgD5N5A4yM13nFC9Me/gpg==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cuh78g75x-6
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 03:52:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0bU6PlEZtR4dsHB3TyR2TZz0dnajXkVZW8fpitHSPF1vGQugao3cb8gURp+fSmdfvqcCmIjotugc4gWCNDdDAAYQdv884FYiKvCSYeAtQOjSX5IJPrvFVU79cwAp00Et29oyIjKRDZ8uE/Eof6DVt8H6EcVV5Z7BsB534WMvUbpNOM8Kpljp9PBpwhscOgHei/AYImtVVBKQur3T2fFuu5kCHlM/+NSvCkOswqvKInqZIA59WjVBx9epL3pOFXEuwm68gR0p/AoeC6YLZpUU9Cyneajz3IvgVZlHqqBlHFO7ciW9rIdniY5OkWXJ27b0Y3s5RUMGBVc9cWwMxmreQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y26leeUCfNN6Qx8FzI828Mo7d1Fz+oE9ir9jOd9E0rA=;
 b=FNKXtDpNo7niDG8StI8l7izOQPuiJY+l4kbLONO7KwzEtg4nnDZPllWeTqiKgCe3ev7ryJOtqFepsm66UTJYm3jPVTHHCEzuxt0CNWGWMER2aku21nl2JH3A7kt15TWCR3ganWDOE4giRPoZ3WVeirNYJ6EBzDzuxgOK7cyYf6FRdWlFDPwdY493ufx19g6S0vXrFJedmrhLh/DtDdN00yn9hUjd8h5oxPh5srYLy8mcjXvVNw0yNaAdauXy4t2x5RG8ziDw8upoAXPepaLPyv+gSjlPCevm/f6xgRyWtb2ALOYKHgg2ILzO7/SnxDdsix0ocP0/8DNLlGqj+Hzoqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by IA1PR11MB7942.namprd11.prod.outlook.com (2603:10b6:208:3fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 03:52:39 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Thu, 12 Mar 2026
 03:52:39 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH V3 07/11] upgrade-helper.py: avoid unnecessary and confusing short names
Date: Thu, 12 Mar 2026 11:52:07 +0800
Message-Id: <20260312035211.745546-7-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312035211.745546-1-Qi.Chen@windriver.com>
References: <20260312035211.745546-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0021.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::8) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|IA1PR11MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: 2846c4c1-8fed-423b-955d-08de7feacdff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	81fc4OrL78J3ht1IeO9rt8QZsVNpPu0EoxZhJR4k0EQmkU198Xd0PdIv0ffkFVpxPQ/4QcWXZ53H7GdK18NKModMF0tz8quHIn/6uJ2lJOnuj5NOo5hhoQWY4Z7Ov/WbE7cmy9u9SGEq7cllEtIDkVPWYhlNAWmg0Glod2CpLP/wytpQk00KqlmIWIjxoYXyHFxsibAXx5lhWqfV/TJfB4E2CG+uIPy5+x7QZDnDQkbrhuiTZ0rAjxFaEC/GoeW+jNMZcQqP6AZ7RKl6D6C3UM8bRhVyS4t76372MEOcfzR1SLgdXQCNoezc38a+Wid/Kf09R2EjE480R+SLkznXqB0SlyfS24u30/nYXr0ohfbaTOWORBwwzb/eVaW3+Ixe/XH8YWDEoIXrDt3daW4lCL8tbNVv2WPuLuxnvFhlsdZKXys6twVPP1XX//kcIamCQkMaVoQhsAsPZeshHaNML+lDJZ3S398m5qyd7oVtc/bY2LqEC31Tgbrdcus3Zf/OC1VMJWxMQj4jacvQWMyDbdNO4ywrsE7UAD9O0aLehub0GJptBu5IHDV4bXMFxts2VpI6CcVnColUSL7qHoAKsSphaJieAPG9nuvGEcDL6mw5PEkRjeMDm0yOGGTLZ+vulYs01SFkx1WVyuPTqBMPPo8ZEyojYtQbaKfSMCZ+BcUuO2OWI65qf2RTsSNYrWdaf3SeJTrtT1ucH6wS1ffwb+8njDuR/yQKPj2Ug3lesYXousKLJNF7+F2+XMX/RVX5mPQbHIhpqTi19/+WcVHK9EWyABW3JcL5F+fNj/kA0yw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?beWYcdxFRgHSGsZh0Th7JLFbZof+1VZTbmcv9GfnBNqwAHL1M9Om7Qxde9lL?=
 =?us-ascii?Q?9Sd6knzhL3Pj+agYuwBR66560DkVILa9uMhI1iTNy3RxKBeD+LxVomk99aeH?=
 =?us-ascii?Q?eENdyOOOUVh1oBAgjX8wbkitXQMyzdMqF32UKeirZEwOuhFq6tkXFqNE6PWg?=
 =?us-ascii?Q?Y5yCRvneiVOgjG6QEwIZSOGPbYktm54dOZ6fXLRSWln1x0Ynhlmlg/xQgCco?=
 =?us-ascii?Q?PGmWYvKYs45vQuw18mSWurAaMPMFOsluDpbt13a/EFO7PA597DOFIanaVtG6?=
 =?us-ascii?Q?LJH5hWM/WV+H9g1pCqrW6O7q2gGymhLtrDYCUHZY4gJRzSSnIZ+bb9zjQzKq?=
 =?us-ascii?Q?kZ6/lmXFOBAsg0NEn/9Qg+CElUdJq0E7uWlYRBxMHM7QVpzlkdldniH9J/mZ?=
 =?us-ascii?Q?eiknFCqBIp2fEblk1jGkcZxTL2kp2NOMixd9RstZW4kjCHYMefyVwEPrsV2B?=
 =?us-ascii?Q?PFGBw0PxymKaCFRaNKkPRmMdr1dDun+WBuVkoKmNy+BgAz5lD/wARbG+OynP?=
 =?us-ascii?Q?waYtijKpCUfoQEwfweVch5bws2jARUgSBm/HKujD61IjkFcTUjJVlAwAkAod?=
 =?us-ascii?Q?XGBCA+oXGevBouHngUpI8ZQKiIZfjihpxhx4J2KiymyGylnpOG8Cb+4umtqS?=
 =?us-ascii?Q?1zmFs+jJkakqQdag/2V0ZzlTDa89fKOeNTfWBLGj1Hq9sFJuYCKeR8Id9ujY?=
 =?us-ascii?Q?wBI1nhVlmD61//DlS5sLoImVEpGAMIqJs4bJtyhjIspP/Hx467VJT78Clq8O?=
 =?us-ascii?Q?dSp/9A7trYzmVMF0ZhOn1K2mbmglCzW1pFIJaNW37BO43r7ebfqmvj4p2U6L?=
 =?us-ascii?Q?zjLi2URIv47YXUAXnPNz5lTS8+QwOxQbFyRzF+a98JeNDRTerlfslbd1B5Gi?=
 =?us-ascii?Q?Di0+o1EeKmLakTmBUO7M0QMl8Laf53GMVFsLesyFc1ALOnvGuO5l2LfNVvfS?=
 =?us-ascii?Q?aNnroocQsokcNGiEWgnqtsDcuxKRnq9Em6jjh5iVRFatWQ3Cn681bnxX34xQ?=
 =?us-ascii?Q?fQxPgyQHcJOt+ncChUXPsMSsPID6yk6PyjfHserSCi2kR0p9vunW820qYd17?=
 =?us-ascii?Q?ZLxiaNEtHDxb5IjblmuPS51BvMmfdNwazpUy0IWHznzJZi5yHi+3s1CF/3U5?=
 =?us-ascii?Q?iTVdnBHxdsmJDamFkZhrqyYVONIDGYrlYshIs0KKO3uZwr4h6yNahXesXHQA?=
 =?us-ascii?Q?ZZUdCqX1SX3LHmgv5cYNNtO0uEiz6QBE5PbfxzO9/LH7UBPCrZ4e075iORAV?=
 =?us-ascii?Q?Jlba6BS+Do2MeagpeZlZf++pN5vzIAn1LOkFjZd/8aYB3m6vpsTJHygpL5YV?=
 =?us-ascii?Q?hOqA2GEV7cupcKMc4T8BKRQOlHm9w3w4ErM0rJL2PLaSaSxwYotyQWsnIqUP?=
 =?us-ascii?Q?HtdOEI/ORjM4iK9cSq/bzMm6DygzDTror04RuEcU88tFZazm/nvIHgdOzQpO?=
 =?us-ascii?Q?9VLwcR95/t0bzXd203WF/xOjFfFCabqQN8qrMeWtfHxxZ8NMW8lre5sARlNP?=
 =?us-ascii?Q?cnePxHHYnIYG45EGrx8YUcQDEVOstiTZH/CF/qb+QpAqqbJr7LGNDMZ9wb6O?=
 =?us-ascii?Q?l9a/XaozV43M3d8iK0YvoU/5UT+iTyLP/fNDtL7N0tUaHFbU9X9GX0LKiyvO?=
 =?us-ascii?Q?FW0riKsRQ3LDF3Q/rKDRc8NEaNLgnFLNBEV+gL0z8Y1ngBPJcKGcbRPp3kI2?=
 =?us-ascii?Q?J4dW981QwoHV94CftIuWvGw8xL+UktNRWA8semFoEe11NRoZ/Es3c6r44Dqe?=
 =?us-ascii?Q?4vjDWLwPAg=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	W30iLfbBEyjmgWMjyZePoktM93JbRgpO3S30t+eBNBW6rJYxW6m3gkfUHqxdHoRWsfgTTwGoGCeuuBW9Zk3Lt/zrwDr/FmwdBISD0YqwzpH8tZvkTdLtTnoO/ZdLsuXUC8CQWyJ78nEn/Ge2koG5q0AFrL1dOKFqWb/LDfU6HeEbcQNt3x7PmrtiGQaf8shKsi9TdRJ6Bv+t/oiHhUEuWV5gteNiExL3Lvsf8+NWOwXtgL5RmOLWQTMYgvnt3chtWrJZn1OB96PPHiS00M68dEdhfZ9PVC97VBO0rzrU6GP+NAJktg2hTxEtOZ7jy7XV2vFrOxsnaCIHZwzIkM4Wfg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2846c4c1-8fed-423b-955d-08de7feacdff
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 03:52:39.0134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmg23FartcqI66wT5+KEy14nBSVAzargBjEqF/pi+VDfGRV8l1RFM5ucwqE9/CKeHz67M4PvCcqgDHSuvLE/Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7942
X-Authority-Analysis: v=2.4 cv=ALvEU0hV c=1 sm=1 tr=0 ts=69b2388c cx=c_pps
 a=c7CpAOS9Jb82g9OYW51qCA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=WP5zsaevAAAA:8 a=qV09NasGAAAA:8 a=u-Ev9gDpdlag-DNbPkwA:9
 a=FdTzh2GWekK77mhwV6Dw:22 a=t8Kx07QrZZTALmIZmm-o:22 a=GlicbclHOgpI_Rq0ze_Y:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDAyNyBTYWx0ZWRfX/20KR/G93qUH
 70NwB5YU8bsgbQPwWaHNHKZjjyAzBKj6nfx62sXebobUFqzb/nXbeha1VxolZC+MdwbXQGG7T6I
 OZIMK6irxB/pP/ukHohiP5XKzVpswH9fORb4cpHUTvI+lO8NE2gd1Wp9qYxfGERwTIblNMmJNue
 IqWFmJdUgD17/D/LF60W9CMQArOLs/U4BXGGGwvxIWFcfhnjaRzPTxrVxXO1ntOc3e0sIu2Dov+
 Ulv8gZmEDzvpvis4Px8yOmmvpc8TpdAAMSy/6mTi+m4kYLeonGjHZHUaBoGrbBy3F9TdTMLcHGk
 +Jjs/9weUsAg1gCFSZ+hHG45pUoyhP9bmaPYEFGHI8ROJSvtfiIuDhg9n7keYWEGfsto5VyJCYR
 q1QDa3k4TSRET6ntu7SUPc957YOqfX5YMJYsqOQhAjGxfHeJm2+0HGyWHT7Rd/Jy6gxERlAzxzr
 vNh3AMGT01nAV0Yn3ag==
X-Proofpoint-ORIG-GUID: Q5U0tgntb2MpgP8JS9PGKvJAHZcw7XYN
X-Proofpoint-GUID: Q5U0tgntb2MpgP8JS9PGKvJAHZcw7XYN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603120027
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Mar 2026 03:52:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3443

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


