Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01B0C369CB
	for <webhook@archiver.kernel.org>; Tue, 22 Apr 2025 06:29:52 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.33974.1745303386795735284
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 21 Apr 2025 23:29:46 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=62076c2214=yi.zhao@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M4Qqbi004866
	for <yocto-patches@lists.yoctoproject.org>; Mon, 21 Apr 2025 23:29:46 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4647442dw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 21 Apr 2025 23:29:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkc+aG8pAUQHucFUZlGWxXRzoSNEigfOCvqu8oqn72o6ij8KrvmsMo0KDr5kVXgQIT9v1b+SAqbZcL9o8OemBMbgTUq8IkqjzAi38q9uMMB0otQxiOX+D605DT5OV30i5lAKxcxdCaD7xKQz32wMk8aYIXEV6P3w3RFppOeiM/ZCvA9Hp+kvQjguOsw+03vzj/ISze/kpXlyq9xWxe/JLD/Awvi5DO9yDFmyvgvuHtzpPvibU5j6se4PM189lyov3EYe5MpBSkFqbvDNbiNGa501fGTuhlq9ej4EYTtTXO/qzUVKayG7yaGQ1/NF0SR8SIk/dcjWN6v3itExJ5rwFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ms3S1L5DcF6WWnAlgYDYdOz454yivH3ACNL4k+OCvQ0=;
 b=mJxg0s1bk5b4C9K5NX/dZbxQzPZdGAytGHYLPxf+ynPCEKMqahyev64EpgObCHbIH77AukO0xf7p+ldB1zEDUSlwR+X0Sw6EF0XGJcQNycXkBteL9GBKujAmjEAXxbcD+KZ9DZye2j0zhDkuAw5+ujOpwJP7zPb8yQ+k6i0yvVmwysu3Bae2M1KCuMXUCkSh7mVNdDaJfrh1vHYDV1vfy6DQw18PNsRaigx5+DAaR7/nc2AXzBsHkeMagBSescCLt9nuXl0BeBXjpwrx8SSXAqWkT66GibQr5hGZxXIQe20aOIpajGlyn4/UpipZBvLOJjJDAeBRZQzWQu4kAyp9qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 IA0PR11MB7260.namprd11.prod.outlook.com (2603:10b6:208:43b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 06:29:43 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%4]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 06:29:43 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH] refpolicy: update to latest git rev
Date: Tue, 22 Apr 2025 14:29:27 +0800
Message-Id: <20250422062927.206179-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0003.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::10) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|IA0PR11MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e18280c-86cc-44ec-825a-08dd8167118f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?PZOPGvpgT8W31vIzXcVM2DqYuC1f4Rm1gneDcO9cxm66kVbfiLCkeAV9V5jd?=
 =?us-ascii?Q?04DXFCxl77alzZXXrrLJ79XWHFiGF9OUmITIVBG7VEYaDoLAUiQ2hws5ICD8?=
 =?us-ascii?Q?DhbEaLxdTwKtxcDCYTA9EHjb16GK4o4DfWMwb4NhRkf2RJ6QxVo949LF2iXc?=
 =?us-ascii?Q?7GeKNqt0/IQbQ5h2q1O+mKLYLdRw0dPzdpwJVc7AjHZ1UoASV08MBcxKhPYm?=
 =?us-ascii?Q?ZUbVlyz+OxONc05Cc06iAxIRi4XtTLSfESMZEU2hvS25ozc7zxBNdZ7QXTML?=
 =?us-ascii?Q?8X2AhkgMzl9F4Xk6wrMaYYoIGaFwGuR9ZWRg1h3uk6j3XL5RWnnZBa6XMGXh?=
 =?us-ascii?Q?zofjc++W2j7eVAOnkfpLD7FZXkFNGtb/ur/OZ/hBAyEE9xxaFSvNNiWVJMDx?=
 =?us-ascii?Q?vPF1Wz/NEtcYRwMUWIakUuvp0R6Xg974D4h4oRLgFCh4d+fLUP1yfhdSe6fn?=
 =?us-ascii?Q?exXN8KbRubJ7pcb1+U7k0/3SmLfqBSSibno+tL11m/V1RjhK+UpKaij0qnMv?=
 =?us-ascii?Q?5JQrj1yaEOvmjMUymXW4F/ZCETEaWGwYU3LCFib0G/KSpKCug7gWdPuR6rrG?=
 =?us-ascii?Q?tumewhDgT7t+CHaNKeCgl/x3eeGk5Ojfmre9CUufyDAn0o9Mc+YRffQFllcj?=
 =?us-ascii?Q?Vf9Q1uQt7+s7yNJrhaYMOmQuTu9AkQxPd3d4YonOw7gVS6fSlu8zs+1lorFy?=
 =?us-ascii?Q?WnYHeY1rPMuLuLKxRK6X6EPWpQHGXgKzsQ7Om9xrZpxlt1TwqBOXagOaUhY3?=
 =?us-ascii?Q?SgVV5oauSxJA0Ix00epP8VeEsPy0OcRy2RpCJ6C+PdVai3SFvCQhcwEaC4aX?=
 =?us-ascii?Q?KBBX4whdRhJTBTK8nmARtbdiZEUsN8LRB+0ncuJt2MSFk2lBbg0YwrQqUBt0?=
 =?us-ascii?Q?UlVgR/7SlLGjScrkki6pm7264ImVa+3gb8ADXWqnVJGGyYgAx64w/FLxtXvJ?=
 =?us-ascii?Q?R2VYt1y+qtqRN2Kl39r01LHPiYmnSwJ7VJOvbX5M1gYPBO9XNH0HtZbOhQLg?=
 =?us-ascii?Q?rePZXSlLach04RDnXcJ2XI49vPupLoY4GpkWuSP8RBxXH4grPHbsHgHmdz8E?=
 =?us-ascii?Q?GAdTuGheRHWgITWEsso1x7pUkKU3Sr1CAX7Xu37jKgCwLDywk8jMa4JNFp8G?=
 =?us-ascii?Q?c/KGOi4Ub12N8zN2vt3S1w1HhLGVSkIpNQZYxzM4sflQixUDjxBIanWFH5Bh?=
 =?us-ascii?Q?TEV5giu8CSEaudP+Katv2EJw4b70zYqGVsh3p2RgY+3Rae8RQq3dYrgor5vV?=
 =?us-ascii?Q?OF3KGk/5kKBhvD/1pu3MdFfbZtnFiZtJF1K2NnorIad7tlaeC1AsplqU6Ton?=
 =?us-ascii?Q?3c7vea4pTicDDPbu0TOrvsBAoTaKvwonlkbXuw4I9CLqP6awer20VUc+T9GE?=
 =?us-ascii?Q?FKSmBkSQnQaBU9zH69VSZzQw1AfSFmQ7GeXgkdJyL1lkD80FFwj/EXz/w2Of?=
 =?us-ascii?Q?xKdHzpXh6EAhfeNUptykrpSe7yoSeEjHd8CCEAdYYQsuDc1MVP9gSA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?SbhhXvejZbbttxy2l/SZ4NhIOTeAMkPij2jRrLlFnbXdmexExLMLTebh8FJ/?=
 =?us-ascii?Q?kCVpMlqJEXhtQ6/zmJdy8KaKcc8Q5h6aNFlu6xc+352kzbJgLrlzF5oyNdSO?=
 =?us-ascii?Q?DAtcw6YsdTG/BMj0JxI9R1ZKk31a+68qWJKCqL7e/MFZxKFMaw6YZzM1I+5G?=
 =?us-ascii?Q?pC79bCNWJjTfvWomEU8OaFpUfedWLRiZU4/I6gn0YCxt/uyNmiXoChoimw39?=
 =?us-ascii?Q?wAQBdLvSZ92a3rJ97aGlBTnU1fZDhpFfXo100w6MqZH3GKxfr4s/B+1U9PIB?=
 =?us-ascii?Q?6VDUY52gX2gYWT4dTXMULFXyFOicrWJ+5oF81pcswlwLc3gtBV8x4Sh7aFpS?=
 =?us-ascii?Q?YZGAC/BunxmehK+/jggHsNnZB+2oYtN6Nuazs9BiChE17EtM6xtHGdKnaNIZ?=
 =?us-ascii?Q?vIiumPt7qG3G3rvTDumTIq6XIc09cBzUsXD5DSwYO55xMhvHsAdc8YU29uGP?=
 =?us-ascii?Q?EBykqKsv8B4oajXVXRfMc9MjDGyWtk6LZ8ppZraHIb3CVvQRNcdibjUOwZdW?=
 =?us-ascii?Q?y3esHumpnUkx4na+qKAf4jZaqvJjB8kwYLbM/GebMeuoPnJ4WnjMw90fFf/E?=
 =?us-ascii?Q?pmCvJiZgZmqFDRfPYF3MRays8blVuB+1zxCdQEE470wmVz3qpm0w0HCZoGMm?=
 =?us-ascii?Q?XRxhj2HEnxBrFNL0IxHqE1wf7cHdk9oxTTweWmzsqs7g9sy7RQHV1voTQoTh?=
 =?us-ascii?Q?macpkzI7N6kxwZI5ZZkOkqip+RINvJZ5lQNPsANg1dcmfcy3CXhD07EmYNxw?=
 =?us-ascii?Q?4XpSCxyQXM7lG15N7spLkVfThmZpHrQIbeDFD0oYzbVnvyq+GW1rvUcJf/SL?=
 =?us-ascii?Q?vVxuqaMcZy6QYMS+qcS2uYtuMnyCC4tEBmeBwWN7LPf4lvN2CqfE8DiyVc5d?=
 =?us-ascii?Q?P2U9yeq6cBF2H8TPb8ahqlhx5JMvXQcK248ptVwf8EPpQkFPw6QrSFjMRp8F?=
 =?us-ascii?Q?Z+OHnBvoMlyxql5//g7T/qo6zb4UAye2OyVMeieW+Nbu+vXsLKVfNqjC1yrX?=
 =?us-ascii?Q?T2qUy5cOl49/39oRmYDuttQv+nDZjLkUDYi2uZy3YAC1lh+dex621BCGwM14?=
 =?us-ascii?Q?2w0EQVTjJjo2seUWgz5s6dyo8rXQk29DlvwTODT0s9poSi5v0iSzNy7412AO?=
 =?us-ascii?Q?VdqbyGABLjLQKkQWti1z0bKlFR6Fd3AH80C9vuzWPbVbaisogbKUThx2Uqqq?=
 =?us-ascii?Q?bt3qdw+oFoO7eIIsdjmh2m5pxWGQZc/dNV1ONWYddhbTKFzq9uxn9/5KCE6q?=
 =?us-ascii?Q?okyMdC6anczuSXdQ9Py3zr0s3ulJQQqFTlSm3FIhlX82pwSLdMzcy/LeIuDX?=
 =?us-ascii?Q?M/Dp0CjaOPpv00NGqJyylpFpN09PzcbEmL8f44BLPlMZfI6r2KCvj++ASlT2?=
 =?us-ascii?Q?BrUKCOSj1Tvrz9g8bY0dkTCY/ifGrYEv4iFbrmQvKL0ItdlgFdo4HEbA/Jkt?=
 =?us-ascii?Q?oDWhry5q40SBXGi/WYyxKE4Zko8oe5njHgfJsxilELrnPgvuWbAEH67EpNX3?=
 =?us-ascii?Q?4k0+6NMbG8zYrOoPMcXxE7M8ts2+5bwiwu7PiLqbE9kO3RZXrS11+AiqBFjy?=
 =?us-ascii?Q?jtCDs31Z6Wl7mAsPcGl4sDflq3qN/FoN/KUX9yhQ?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e18280c-86cc-44ec-825a-08dd8167118f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 06:29:43.4355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xkKFj92ABUnbvy7KGPi3b53xjFQuZK/QqQpTJ53l9DmIR/n7Pon6hNiw+Hqu/EyMU/OTTuezBOPy5gKdDtaT0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7260
X-Proofpoint-ORIG-GUID: C6EQjWhyjmVnS1FbHGrFHdI6pljqprBT
X-Authority-Analysis: v=2.4 cv=UpNjN/wB c=1 sm=1 tr=0 ts=6807375a cx=c_pps a=p6j+uggflNHdUAyuNTtjyw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=t7CeM3EgAAAA:8 a=9Wbp7B8dAAAA:8 a=NEAV23lmAAAA:8 a=_3QLm22W4FMC85kf4KwA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=BESxJfN36ujmTJQqZ0Zq:22
X-Proofpoint-GUID: C6EQjWhyjmVnS1FbHGrFHdI6pljqprBT
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_03,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=975 malwarescore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504220048
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 22 Apr 2025 06:29:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1397

* 5a6c7d8bf systemd: Add log env to systemd-machine-id-setup.
* 33af8dfa4 Module for ipmitool
* a3a6b1704 oddjob: allow oddjob_mkhomedir_t privfd:fd use
* 621eb6caf systemd: allow reading /dev/cpu/0/msr
* fb0e9cdda Remove unneeded backticks from gen_tunable
* 2240e1a89 locallogin: allow sulogin_t user_tty_device_t rw

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...olicy-minimum-make-sysadmin-module-optional.patch | 12 ++++++------
 recipes-security/refpolicy/refpolicy_git.inc         |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/recipes-security/refpolicy/refpolicy/0001-refpolicy-minimum-make-sysadmin-module-optional.patch b/recipes-security/refpolicy/refpolicy/0001-refpolicy-minimum-make-sysadmin-module-optional.patch
index b0c0556..f963901 100644
--- a/recipes-security/refpolicy/refpolicy/0001-refpolicy-minimum-make-sysadmin-module-optional.patch
+++ b/recipes-security/refpolicy/refpolicy/0001-refpolicy-minimum-make-sysadmin-module-optional.patch
@@ -1,4 +1,4 @@
-From 4a5d6d9b7c317a2b819ef9a0ebce2e913ad42be9 Mon Sep 17 00:00:00 2001
+From abcc9a219a57c4cdc60f72cd91372204f3fcfa38 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 5 Apr 2019 11:53:28 -0400
 Subject: [PATCH] refpolicy-minimum: make sysadmin module optional
@@ -22,10 +22,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  2 files changed, 11 insertions(+), 7 deletions(-)
 
 diff --git a/policy/modules/system/init.te b/policy/modules/system/init.te
-index 7df44cead..65146974b 100644
+index bde3d5944..cff62daa0 100644
 --- a/policy/modules/system/init.te
 +++ b/policy/modules/system/init.te
-@@ -648,13 +648,15 @@ ifdef(`init_systemd',`
+@@ -653,13 +653,15 @@ ifdef(`init_systemd',`
  		unconfined_write_keys(init_t)
  	')
  ',`
@@ -48,12 +48,12 @@ index 7df44cead..65146974b 100644
  	')
  ')
 diff --git a/policy/modules/system/locallogin.te b/policy/modules/system/locallogin.te
-index f96092070..db28ce41c 100644
+index 59bcc78c8..f25168e3b 100644
 --- a/policy/modules/system/locallogin.te
 +++ b/policy/modules/system/locallogin.te
-@@ -279,7 +279,9 @@ userdom_use_unpriv_users_fds(sulogin_t)
+@@ -280,7 +280,9 @@ userdom_use_unpriv_users_fds(sulogin_t)
  userdom_search_user_home_dirs(sulogin_t)
- userdom_use_user_ptys(sulogin_t)
+ userdom_use_user_terminals(sulogin_t)
  
 -sysadm_shell_domtrans(sulogin_t)
 +optional_policy(`
diff --git a/recipes-security/refpolicy/refpolicy_git.inc b/recipes-security/refpolicy/refpolicy_git.inc
index a4ffd5c..955d160 100644
--- a/recipes-security/refpolicy/refpolicy_git.inc
+++ b/recipes-security/refpolicy/refpolicy_git.inc
@@ -2,7 +2,7 @@ PV = "2.20250213+git"
 
 SRC_URI = "git://github.com/SELinuxProject/refpolicy.git;protocol=https;branch=main;name=refpolicy;destsuffix=refpolicy"
 
-SRCREV_refpolicy = "ffc9c4e16cef451bf1d1a1de44bb738aa342c69d"
+SRCREV_refpolicy = "353352e31f0d301e6c49db79a753c7d0179b46c2"
 
 UPSTREAM_CHECK_GITTAGREGEX = "RELEASE_(?P<pver>\d+_\d+)"
 
-- 
2.34.1


