Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B13FFD0629
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 06:36:27 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14978.1773210981133649320
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 23:36:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=DMBy2Mvt;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7530ed8fe6=qi.chen@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B3lOY52674556;
	Wed, 11 Mar 2026 06:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=1OZmoIrr8mddurH6PN9sKyMqrFhJCFfrm7b+tWGVto4=; b=
	DMBy2MvtZmqWmyYLZrHBN4xfHZqFmmr3vrsee6ShugoiLAYArUm91TFR8sKKM0qO
	y+2HaPdyc1MG5J8JhD7tDY418ErV9K2CtA6TnYuj/4i8wDdBkSOodCk0tM8CxNrh
	8yCB+zAg2gVAy+pw5ha5W2HD1DlbnTSNC5Sf3GFKPRHAJWvKTMtqKoPeZTsaq8Bf
	oOdHQ+S5xapriM5oTC+2VIrawNPMNrdtnCoEFP2NLq+wqGNm9MCxCVlhBzbdPvrj
	t26LSraCuT3G5fbpAw1UH9VABG1Z2U3a/O3+bB9crgKfk38C9D2cUVRqpOYgVOm9
	ZagqTSwuodVeJSXsTlL58g==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011059.outbound.protection.outlook.com [52.101.57.59])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cty22r76h-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 06:36:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqyHyaGu5a46CFUkf/q0GQ3+VRZSrjUXBWNMwtbNbDUN5PbwlNYD6Glh078/uZDJYE5zW3CYl2RHc25QG1vYbl7088BFGYrtuI0xv7HMT14qWWPX9nv/SLzvGn6pasABIuMVhzEIK0rpXYVVbH00EZy+QGZJj2YVS51woLpsIT9+ks7qC1S+E5AuJ+bSVsgUlNMfsu1RqL53E6uUdbJfaI+Tt05dNAipAC2min1CIFq0towhicrG01FsxLSHylyfxhDzMeBq+rppZeBOtePFzAHqxUcK5Cm17V9QmLm+NlsBZD/8TwgWZiJ0edrmGVmxO1zdzfEDmo7pXXSuJ77KbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OZmoIrr8mddurH6PN9sKyMqrFhJCFfrm7b+tWGVto4=;
 b=QV+d42Q7FnJKgGDDLokXRHsZ1m9w/QF4TbAbsDyGjvYOuNNNWxG9mXMCeVVd1yC5reS4oiPzFPMt7tbbevH9vYzn+tZOYs9Fcg4cXJibjRqrGRw7/jM+2PNuJhgEjIeHtFicb/UG5j+XmTpPzR4RGgw2rjlMePfzGTzodld56J34Ybs+CBM6kBWPc4M/UqfgjgLcBQSqLpKSUfTAw9u2YImswDTJchoN+SPlV7RXvhuKF/fwp+JobqlunDDB2A6/lMMa8XK4+ZPBwo5n38I3HL/wyRs0A79/SpVTQhMD2H/VJlruJCU4FeAKiPP5OiGZRji3No/QduFHYrOKqcRIqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by IA1PR11MB8787.namprd11.prod.outlook.com (2603:10b6:208:598::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 06:36:17 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Wed, 11 Mar 2026
 06:36:17 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH 02/11] upgrade-helper.py: use scripts path to locate oe-core directory
Date: Wed, 11 Mar 2026 14:35:48 +0800
Message-Id: <20260311063557.229656-2-Qi.Chen@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: d8077f5a-c040-405f-dfbe-08de7f387fe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	Oe/A9SLZbRjjmvD9/KjcVFKBahA92NDh3a06kkiUx9gdEQKO1ZJ8RTX6vCbrzk8Nw88Kpuv3t92N/NnwA2pn38ykSsMD4MU9Cqd1k2LeYd+31W7i2xOZiihbi2AC/Qw1pkXz7sDJFWY1Y3bhyZTN3Bix2A8FPtIUKPzuCQfYngLBXiATww0dDPWgHzTS8avZd3VbGgqldJunfhFUk/dEj//O7T+pVambkqyO8VKXOJVvTyEe1L88zFXNtEfKe0nIat+05ukkRGl7upUk9A2N72vTRfktkevKjMwgT/yIsQil3Kpn8YdvuUosY0v6x5WMIGP40xHMVkXKlaO2XnFcvO0BBgTMjfAtDuEiX3rTgf2oJhjG7wwZUsYng6Y6JGjGhfRGS1FEogvL0kv99Q1fVEnbmczY03AhA4ngHbzR7EjHt+1vubvKiEWKj+89rYKaHTglQDqwsehS3YgsSxcgNo5oQYVGEQk5JGfBv0xZ0Kd4bk3b6X9l9HhfrZfTSZFtLYDcTAaccCnMVLC7F77gEH2J76iKWiiN2HH6Xm6Db7KSJaLd+L0Nsj5dAaEXaQfWWt9n2HB7GuOEdCFllxiZwrrTsKj/gY9Lnn25c+5BXwuWCmEOATRZpKS9AJ6Q4G+Um8FwB+UHlXMOr1hcPflEQ1m+05kAd4uma/aXMhzhPOId3ze4qO+dYbRGrYUk2wAyw7xFdspRadBje0XefHYdmCz2AVLrDkyC7PCPidWwTnUlRU776Ujt9N6g1esTZYFdg8QF58tMJcyGA1G1PQOl5xGPOLzpgwVl/WJbFlSlKPA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ArgIaa+jGC1GixrM3AS8CfioA/k2EBaZBiJ12OuFVHGUmd9Desk+2zZb3e70?=
 =?us-ascii?Q?5x4jE2b2HExgEj/T2Nj9nKjEWdqJF0IH0MYHRMHHtfDJSqZzXmA2+xZysUV0?=
 =?us-ascii?Q?vQRGS/3cXlMP1udhOCFJdPqGjwFd9teCukNlui/Ht3JckPHWrS0llLVQWqjD?=
 =?us-ascii?Q?ZYlkw/3AtKEhYxEdswAE2eBBDCvM45qcvx0RiquuGd+9DeFPXxpkuZkl+gBw?=
 =?us-ascii?Q?tGSMcEnefprpR6KhkOG09g/SF50nSFZ3kXuD+bDw4jPflPureldFHhVqyHDj?=
 =?us-ascii?Q?u42uz6mRduWOBS0fhCPFMuk195JnD52+xkZiUOEtXNrRXzkQq34mv2RvlfbY?=
 =?us-ascii?Q?z2Q+QHR4cmiWF1F7oG1LaZTOPnbbluo6RlhyDyHBOTwwpujnyER6rnxSOdMR?=
 =?us-ascii?Q?+CChiTPWwG2wf4NbBV8MnVz0bc3zZ8FfBoVUxO+gPXcjJn4pSlkvDhvsLQpE?=
 =?us-ascii?Q?/0MKlwEvgbXnX4mRBs3we03/o36cf5Ql0alvtemao8etIXspzlO82/qh1wsP?=
 =?us-ascii?Q?YWDijCtKTbezhYou7f2qM3isTsUA1Qe15Mm++yPCQ75qFiA0rtiryzC90K35?=
 =?us-ascii?Q?TP1DFzyMqQejcgEqsM433xc5HACEKW0NgbBLO2tVdhGTUrbrLyPD6Ag5dhzy?=
 =?us-ascii?Q?poX9d9yfRM97G3SCRuvBYI4bd6pU7TTu0aObQ9cWAZPFOO73fqeNz723jfIe?=
 =?us-ascii?Q?XepZ7vxqtbRpy5ANkr9p/ZIYMSumIjwjEjpSinn9/DyReCMy0wvPLHfAjL2/?=
 =?us-ascii?Q?uFDEie9Y07yF0vhLLFe2wAFPgmo7HjdVCzdHj8sohOoQjaG1FWykdy43QVdh?=
 =?us-ascii?Q?jRKJDMXode+10HxRJ6L+oekjwHpC6tzDj+n65rU0fjl2T6ZITkB5eBYAD5hf?=
 =?us-ascii?Q?LklVncaAsFBFkvpksl2EtfAzUyeKaCZJoywDa4CvwrjFw/ydHL3QsbAUx6rZ?=
 =?us-ascii?Q?l1ZXqsglhpy4/KIliyRY/AVsFSC1hgeGP8KDf58Q0g9qFC0OXrKgw8RllFQU?=
 =?us-ascii?Q?4kJZD7cim8pvkgOLuGmXgu7yBmEvL1ANxDFH9ndx3oazvRe6pUNQ0AHqX5ZX?=
 =?us-ascii?Q?mg87FioVC4SLsbcJyO/Ys7de2421jCnxDjqbxXGhY3H7XmkCFxN/qH63KuzP?=
 =?us-ascii?Q?OUCn8oBYjPEydNIvo96mWYBaGLuorQtxt7+C/D1474SBKXVo3FW3uO4vmCVp?=
 =?us-ascii?Q?z2ykfhb7jCGCSElzl2BeOEPz7hJIlnDipqswEIQ4/nUiOJMyYNLzirBIDb/G?=
 =?us-ascii?Q?R1WiXkniFXFHb2QDGx7Bs8Jfv44Yt2hcnLpfsngPE+4VbYRHHrYz+WjP/dDA?=
 =?us-ascii?Q?+yBimIZRSJtxYPtezy4mW0QJCmGCbn8nGOHYfLptXDzkb07uiyRIh0zOYoqx?=
 =?us-ascii?Q?lLn4OEjswxOYp/grY9lNLpOg3IwpYyHNRpIZO6fUi5g4mdpp0zhUYGDGacFR?=
 =?us-ascii?Q?QhcDClWALHFYNx8xMfI9VcB/3oAc9kimGgxfhOBs5FiCS/t4k3WzyZbg83mo?=
 =?us-ascii?Q?48ubyeWW54hSTXH/UEer4Q13wHVlg2Eav4QzrcTbjtyLL0LY+xxD7VS+o+jL?=
 =?us-ascii?Q?WLPHc0aLw4z7aceLLAzXRDnozhci2Q84Fzx3dnwtEMGrSJmepmkRzf3wTiIU?=
 =?us-ascii?Q?ELK1iR8IKvY+LPY8cvsaya/z8fldw1n0902iUWcCMaEwqsodlEBYwxPQpDcy?=
 =?us-ascii?Q?bEQ4fQnp6ejYDAICT32H8dGydSEqA85J3IjF2BxA35XRU5Zy0hFPqYcBYPX9?=
 =?us-ascii?Q?zs0ALkRuVw=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	t6zAam2ri7oDYsb4H+txLmwNV2mH0qx5wZQwY1hMaZIsMAVi2e+UvJyFZS2OXKMgFluvluVMR3jd7gKBqTRSULH9yoGdc/KNZ0qRPMFW0yrHDVKNKkD1oOaKiDOGD/pLEDvT3ADaRgLytnS6RBsngnVpahV+sUw8XWzfZyOH817br2GdgE+7pAA2lZERVwRbUdQBXtpy/h7DAnjQzOvxyBwwed1TinLSEXDRXv4eFJBD/ut1j9IUrOFb1l44Hv18xodORr2G99ROCNR05gv+VaYMdoyAQQC/5mCkPXk7D1aze/wQFzYFyAoDQu570kdbPaO5r/tXOMne23qcMnYwDQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8077f5a-c040-405f-dfbe-08de7f387fe6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 06:36:17.7137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/GdJOMSMDkMURa4hf+iJDwmNTAKFdl+r/tEapsKiVJFM9TdTpAbLX75CSYEVlx6HaxwtPjPIegFuxqZFBKGxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8787
X-Authority-Analysis: v=2.4 cv=LqOfC3dc c=1 sm=1 tr=0 ts=69b10d63 cx=c_pps
 a=J5CYyyHZZtesdUd/yj239g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=lpC2OK7O1r6CxJ4ueCMA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: Gk5fQ9BXLrxuFVpik5KQZOWPKqq03E2j
X-Proofpoint-GUID: Gk5fQ9BXLrxuFVpik5KQZOWPKqq03E2j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA1NCBTYWx0ZWRfX7QPsXjpWYch9
 4i5cZ661fmgTaq5C9KErrQHgCZIvC6Kkg7C9kaMvmihnJhq0TunEeRbzeqTibcVRayUPQGsyOue
 7d1yBkAFFQtc7LUVBqgQlLStvXzSd5meuxZHtR30MPwL3x0RelIB0INT1QrUTv9CunVHuFe+tpv
 Xso0QGu15jslWS3ebXsoGZmEwrPGx4C7xcblTRXBrrA5XRY128MI1kRIczq1audQKDv3RkgmgIy
 gE2kb4XuX9Pbcfuzry/Ig7tnTyp+l6z54nVr9VSigKt/lz0LpOFuFd8GH1yFBqNwwxNsa84576h
 oiDoufEl6PeBkh/bq/Ku+CGBZyewIC0W5iYldqsR00eEXzZ0HWNwebs8UBx1g2eVOlPpEvWvNbi
 knMg7d9CC/9tyBb0dnmLr4kAE5Dtv+CQJy6K6HUFWMFgRrMEcwPgHzfkIijFAkCWUaPq8NU6aMY
 Ef+D9ibpZyKkBFcYTmA==
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
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 06:36:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3403

From: Chen Qi <Qi.Chen@windriver.com>

Using the first element in PATH is really awkward and prone to
errors. As we have already located the scripts directory by
using shutil.which('devtool'), we could well make use of it to
locate oe-core directory.

Note that the scripts could be a symbolic link to the real location
under oe-core. So we need to use os.path.realpath() to get its
real location.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 upgrade-helper.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/upgrade-helper.py b/upgrade-helper.py
index 3b98f7c..27e1f48 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -67,7 +67,7 @@ if not os.getenv('BUILDDIR', False):
     exit(1)
 
 # Use the location of devtool to find scriptpath and hence bb/oe libs
-scripts_path = os.path.abspath(os.path.dirname(shutil.which("devtool")))
+scripts_path = os.path.realpath(os.path.abspath(os.path.dirname(shutil.which("devtool"))))
 sys.path = sys.path + [scripts_path + '/lib']
 import scriptpath
 scriptpath.add_bitbake_lib_path()
@@ -185,8 +185,8 @@ class Updater(object):
 
             self.git = Git(self.opts['layer_dir'])
         else:
-            # XXX: assume that the poky directory is the first entry in the PATH
-            self.git = Git(os.path.dirname(os.getenv('PATH', False).split(':')[0]))
+            # use scripts_path to get oe-core directory
+            self.git = Git(os.path.dirname(scripts_path))
         self.opts['machines'] = settings.get('machines', 'qemux86-64 qemuarm_musl').split()
 
         self.opts['send_email'] = self.args.send_emails
-- 
2.34.1


