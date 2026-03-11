Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71EAFD0636
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 06:48:37 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14794.1773211713219210897
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 23:48:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=gI5uYqOq;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=7530ed8fe6=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B53Y1F2763276;
	Tue, 10 Mar 2026 23:48:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=1OZmoIrr8mddurH6PN9sKyMqrFhJCFfrm7b+tWGVto4=; b=
	gI5uYqOq+32JVARTx9Mu1Hs87q8aSTs31HWpK5cEC8mWHXoUboOe/3SlnHvMpg0K
	pnl6Vdy1530Qftl/6nHPZq40j2AendZYH0MR07qoKqpG5WuL3D4tBl7Cl+yv20r1
	sF4IGPKMJA72plDu3UiIKKdu+sqsjBIKsl6pkLBTtMzusIbGt06b63qIC/40StW0
	aMm0I+nIFUYpY9r4cV+aF7HsaQPe8GJRYxUJ6hUlqQrhjmuWUH+iQU2o1dAw/80d
	y4xm06b8mY4nFeCw54D7r6ENByZS75DJOBbaWU3Mm8ZbYOknYZ1Ee67L0HD/UFce
	xVZJ53NDxJnsLPMftVWjZA==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011049.outbound.protection.outlook.com [52.101.52.49])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cty3j07d2-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 23:48:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6pjDqk4Kdkxq9syvKkIFsdWwKo22tVjQWaY6u35F4nm+ryDB198B2+nkytgSrheENmOhK2ub2/olIx7SMCf91xcIDscaonveHK1EnpUyiYlLL1oR89vCrB/Nj012KABIlobH6VkZBo5wg2K5lm+08iLGS7SZH722Rk9DQ0uU1MIe+HJGfcEipe6unfE5vqU5ZytHfb/e/wRLTxtj6fvXwlpp4BXfnUJHpYxBZFE9drSv4u0wIoodgOSadb6akWYfe4CER/Z0mFqqWVSl/rmMRMstAYmatUgT40JXjBf3tFbWm3qkPDJd6NKAID0CIS8cxboUA5LODXi+2rPa7RgjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OZmoIrr8mddurH6PN9sKyMqrFhJCFfrm7b+tWGVto4=;
 b=JhYXVj+En8zjVMxcc5PNL5ieof3lSrlEsgN4vIk7cTlOBRpZ558WlCJ/mw4C8QGMU6psP97hhobjFdalM6PHcip1tOIlzAg6qoTOsX/VAMyQ8o1B1MAWCjEvpf8HPcMQVLMnkSfR3RzqG//d7+FRUZrTgHoJB10o/li3U/1CPGgCebD//aYkpUGLY8nKXEoB8Xlzh8gCMuJ+3HE7tPc2M68BPOOUiQvjJSLyiMSQ/Uxy594Pzu0gvdojdWYebQ6mRo96CbBDp/g0W5Fi5TKBgypycZc6p8fs5iVjW58gx445peRl0RU3BlQdEXNR9CWPGE8RmoDvEIshY69Ive08+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by SJ0PR11MB4974.namprd11.prod.outlook.com (2603:10b6:a03:2d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 06:48:29 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Wed, 11 Mar 2026
 06:48:29 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH V2 02/12] upgrade-helper.py: use scripts path to locate oe-core directory
Date: Wed, 11 Mar 2026 14:48:03 +0800
Message-Id: <20260311064813.619683-2-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311064813.619683-1-Qi.Chen@windriver.com>
References: <20260311064813.619683-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0181.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::7) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|SJ0PR11MB4974:EE_
X-MS-Office365-Filtering-Correlation-Id: 01758590-89fa-4fee-2fe0-08de7f3a3456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	eUD9Hj6/4LrEnLYL+GgvPyNsrgu87H818JIwTIHwkQB6oJsKFYD5IHP34qjXOXgvtekwdDetH2wdMbCmBDcjJSVF23bgZJ7GLbHcyTMCxdpT8qWcI8mh8S07kF5VQIRvo1/NHTNpM9ED4psMg6obVAGpcENvvhmHBXD/se2vm8Yfi0K9FiidrWBGNQq92AAdv2wTejfcXTlfLSedM5UPAioEQhlvW3RYraE6sDuWVQIyUOyCQTHI7ArbTp9ddgJ9TfhobplOwR+bc7QuEL4Fx/95xXM1vbSK/ec7knsgAqtWrEZGweS6jCqLCcAP42DOwJpNMQl+UYZ5xAPlNf/glqq2yBu4XoNrHnlUuwTGGCW3/60UknApmazo9kbbEnXukz0Le01+IwbsWOmxvdzHxBU10doIsYAWgSGCb/ADJhlo3KVWN7b9bIQKk4ORBCUmQsbHaZDoGcKM4dDUz5Mzcpq3SMiOWzCT/0FvMUaj1KLDxZBM/9VTEmMN8O7y3Ou8iiQlGokqvkcGugTA47S2wom4Ac58Vz8LIv/JztGT/Zyej02gMATG4ZDbAFrzjp5DxJXqZPKIVRQFAtXNb9h7jljvTVqjcuK1ex9QW+BVj0EF3yZbC1M2dfyy9goHMxECi4gpONSwgxif1LO0ZXnNNIMiO5D/L5lm1mbtjqXpxgPeSetpHdukBri2Hd79NLeetEoESXe2i+RUzWpxGQBE0aLbkzQluEaLXPRGTJM6JP/LLiC+BBMo6kVhqlA6PdojuN/KljlcOb2gikfLND/IdyHdZ3PFElqL89PK3B9V5qk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cjfdJeeMfRsAGphmx3BoZsNjsqkH6J4jkP9KPfezxQNLWa2P9yBzr87CzTAe?=
 =?us-ascii?Q?izrM2o9fex1Pa7wg90+gAF/9hiswpgieWLA8Yj4ZHY4QVgMmERVavZj08lea?=
 =?us-ascii?Q?nseevyQAre1zq3Hte7HiufmY4dYSuuDWY70+jfxpKUlOdFm3o2w40RGM1gti?=
 =?us-ascii?Q?JpE5M1vZm2NGixxGw3fRjHnfxSDHJAXeTKJTvBWN6PnRe121fdt7lrFrgN77?=
 =?us-ascii?Q?BF9IjuA8cHq3zItNh6K11j19wMUqPHSL967lh1JNWPjmX2MuAa9DK2b34IVD?=
 =?us-ascii?Q?p7yVhar2K4GIb20oi4/eeoN+fBLQNddZY1YMFA++GEHUrUGuQnV/7b+24Jxo?=
 =?us-ascii?Q?TxXIUoPxAAU0lwL069HQ5nb7ZyzfsCYF6rKqeNHANpVsSIYaD1ykMBkRWcuu?=
 =?us-ascii?Q?ZvSmQmjcK87N7dmW7frlZKZubpQsBhdeW1jBqP/gKAWJX4Nne4g8fz6uyMwk?=
 =?us-ascii?Q?Yx9J5tB7ibccHPGPBUZxZYDFH+GUcsE5A+U+JH+Tx0YiDiOuKSeSBDBTP7tj?=
 =?us-ascii?Q?wzKEGttlMAstRm2ldZ3ggXHT2N6+0Gb1CYEiGCPnY9Woh2DLWwoaa+66Wa9k?=
 =?us-ascii?Q?cV0rhc6/WmmJotuMRai+VjH41bKP5KaMIWd+6Wxtpap9L33ARu+9T5Uz5chn?=
 =?us-ascii?Q?Dwv04qGjtuKU/NsHdo2lHvBFSyAlQsxwwssmfEkkIyvRMkNABr1wSlashPBS?=
 =?us-ascii?Q?MkuTz17wGnqOsRpenDqBl0DqjxmNdVWgdDykiEffBcm63mMElETgLPPM9Ikd?=
 =?us-ascii?Q?/WChKP2pdjiom5qohqVAPdTO12ZoK6oyOh27YBlkZpFrPLwsSH8Hx8bQljhD?=
 =?us-ascii?Q?yFf3zcX6qwtfC8fprXG0iIqj/FtIFR0RvdnsgNZigp9hdWfIPY9cX/0nPVQU?=
 =?us-ascii?Q?bnG3oG0jifWWrHlGUc7vyl46mX42ucfH44Tp1O13RO3dEKZuqYn2rlshdRGt?=
 =?us-ascii?Q?5idy1S2o9x8Pc+k+IU6YLLSbVbH5ilJDG3hK496JajZ3fu0I9nbsblC/2JiI?=
 =?us-ascii?Q?pnHk5Y4f662kOtyB6xIy7ZXLCccfnLIwOzeqLKTqsqC4hYwNNCnfqJYvkUQK?=
 =?us-ascii?Q?fZwhPckkFfhbg53ifEwO0Bgz3mDznY/+z0x8fZYdHN2v9urOQvq8FVjXHjwE?=
 =?us-ascii?Q?pzfWjO9bSMJyyxrQFsxm+VtsLCzaOJjIBBncPp4WZ+z3bagZdBVQCOuf+JNT?=
 =?us-ascii?Q?XbRFxw2xuIobegqbQqoAZfXq/2++XGZWEob+wgjJVquunVnmu8f4m9GQYHfK?=
 =?us-ascii?Q?zTG63I5cIHUli0BhFL/26XE7pLeGK3GjzgjYdd8omjZcFHY4HBgfWi2RoSIR?=
 =?us-ascii?Q?fUFUSACCAadsEBfzxqUlhtMazIrq4vYL9BDg4ZUzpb23mzJZ6YzI0sUPVEow?=
 =?us-ascii?Q?F67Y1K6SiqljbEMzisnXii8dgiFLWCGm9iQgZ1G7tW33m05s9bUB0+cWUy91?=
 =?us-ascii?Q?L4YfqATDR4NtK3qhpadCMshfSGIzpiwq6S2++/GATflj4FLDVhrX5XkcBC/U?=
 =?us-ascii?Q?JKBimzlWJRPPMPs9UL8Hu1HKh+KcbR51fQ1hFm7zuVi/jL98PLTSXUpdxq/L?=
 =?us-ascii?Q?JpRr/fYzhUbyjRfMIe0m5Z+Q9xlT2jvPuEzxBCBE87lvFlU6BODS98UesNUd?=
 =?us-ascii?Q?QOzjj/HdJ1uCfYjleJiRQyb8uXkRS1F+rb77HPD5WqMSG3Yj2ca8v00VTl6X?=
 =?us-ascii?Q?eiHxqEVquSpCISopFnWFYRpMXceUXM2P0S/awt7gnCNaj+lEuo7kdu5Q04uM?=
 =?us-ascii?Q?R22lWn36pA=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	dgz1qYIdnRFq1TRzBWSSTOh/jow+UyHW1peXLIPRSPvnohsFaCXoxn8lDmIeee3W+grDZZBQ8xjvjMhdmjWkJ7VYbJMyHop7gTRzJ9A7WoHqOT8WJOOzMMoVSLR+1QEQEMJ1/o7s4/ZZSDW8GVUIhBHPfqv5gsuK8KmaYhhL1bfMdxvPSV/1Abfu6ZxKgOvUATo5OKqlq77ZyzYxi/iqj0bzvV5Ab1dgsPAdgWf9avHeykWGrIQ9TqlhATWDOUCDxfQvOFvswDX4bn0HRP/ipvvRB2vSFT1P3RW9Nrn5/IAleuykbMNL6LQFYcCfarK5B0AtYkecgnE+ujv8z6UQCw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01758590-89fa-4fee-2fe0-08de7f3a3456
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 06:48:29.8097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIg8uvVuRiSfdkXJx021iHXrKH9Q0WnSvRV7itIJIGJzplgTu58M/appTz2Mqp8dnrLCevVi/BtFKmRu6Wc6DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4974
X-Proofpoint-GUID: KaVH4Qz_zDAhv8MxCLrcTgfEi7VpWT1-
X-Proofpoint-ORIG-GUID: KaVH4Qz_zDAhv8MxCLrcTgfEi7VpWT1-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA1NiBTYWx0ZWRfXx4p5LxXJ9GSw
 ZMmLuEaD1Bs7FIvKqyO7zLPEIbG3fdNOtmdqA/VvvvYTYwuBbhGmmhMRCZ/gv3+/u7E37CiZwXa
 U5VCLXtv4GMSEU9roQ77+WuUB3N80LrGjnfgoawXA7iwcWRXEq3P0GwYWsOwNKJxAMJgHHNhoun
 xwXBhBD9TBUT/3StDfZ4Y8KwvnLi+KBBlrTWhwaGWAcrTgvlJq4j3iJwoj6Rx5TD3y/Srv/FCKF
 ekVYy1TBywCPginfPBkC1nC7nUBzrJy5uVMFFgQ9AoH1fPKxN1l0ixZoErBtq4yDE0iOC93G5BT
 Ns15JnSlmQZZIwipnaU6tAIEVkxibiTawE6Lb28rbQLhXeNsdPX69vovNsSqQgnqh64clHjQLNn
 Jkjyyci5XtDPzS2+5jqXRA5CXuslrMcZKsj8W9tyJ0yjYYnUdJxE/4hRsqrVslfTg84fediUwdU
 J8TzFIbV+B4NmyaKCTQ==
X-Authority-Analysis: v=2.4 cv=Qr1THFyd c=1 sm=1 tr=0 ts=69b1103f cx=c_pps
 a=23BBZRleo/1KOgyGqX6yRw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=lpC2OK7O1r6CxJ4ueCMA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110056
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 06:48:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3414

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


