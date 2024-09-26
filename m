Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64879CCFA13
	for <webhook@archiver.kernel.org>; Thu, 26 Sep 2024 11:29:16 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.40405.1727350149855519245
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Sep 2024 04:29:09 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=999950a969=yi.zhao@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QAL98U012798
	for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Sep 2024 04:29:09 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41um553aaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Sep 2024 04:29:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYfUOr98/8gDGPQrxqY6+YIDrLl7H3Xq6TWXLcYZbGsgEBJ7eHZpl3Sd4tiBmKRYNcd99SlClPWK/PEDaKHFl9Aqz0HMTiHI08sT7twqBo420QwXeEm89Te7qn17IAA574V+419Ai3mlsFPjUwHhxDdV9ELzHznw6GhOjFcWGyiyyAlxOdbnhPmuUu6qcIy39eLJGZhFJT37ae/wQpNCI7rh8xFkhqBLra7NWHk/IBu68WJoNjWfB/eIPrw8r2n4b9vaTp57bs+kQWNSpqCUvsBbz3DrRtOyUPmkQIgGC6hDqGPqsgyM0NfWE4cRimUdq9mKvNxW4q8dWgug8/qIYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUh1PRFrUzE25AYx3epNuRYXMt3ZWoCSJOrdI3s31vI=;
 b=rNpwrOQP5j2eQWARJgYB75ziCxmDrueU6HYiSLEsc6f14w5KhR7bQYPW03lau6SimynUKefLLUG6/BdQYfS3DsU3/NvjTPZM23lMNLCh4uZ5D0sb0avL0qSDlUSHi7y4+E3F/XyyqcybUAPwxATjI7qHn8RQs5I3gTAWXl3sq5TacLYU0sCe3/p91gBj7i8Iwz6C5SZATjFrqt1IZfE8xX+aWpm5pj2XTRBPuD4Yx0T26fB2DJIwa5Ct9jiZsvphKgDWxoM6JfRnrGR27LdVY+mHNjStWwSjvngd3nPyNuNZoHhqia9JseYEQfz7hQyDRl1kPVLozLwv6awTfXosuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 SJ2PR11MB8423.namprd11.prod.outlook.com (2603:10b6:a03:53b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Thu, 26 Sep
 2024 11:29:07 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%5]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 11:29:06 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH] selinux-python: fix sepolicy runtime error
Date: Thu, 26 Sep 2024 19:28:47 +0800
Message-Id: <20240926112847.819251-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:194::21) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|SJ2PR11MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: 26860915-d4ea-4c96-6eb7-08dcde1e6e9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?LgHcrCil1yLh5RLrakNDOkP4tlSWlEmiah6xrrKBqPM4YhSZoLxMXOoo5/6q?=
 =?us-ascii?Q?PBsADGTU/fBOFQv5zU3QQ/z04nlzldI/DUccQ7muBzCZBK7lz0rZJ1h7Y1tf?=
 =?us-ascii?Q?bcWW41CDND0smwgjhNzAue575UYfbYiZmcm6WBorEdVBv+wFRW1g3WN/Y/dF?=
 =?us-ascii?Q?TzwowDCJNLKOoo6iX5fHFR2IjLxXLo/tyfcmLPN+Axn3xeIY8LgF58OI9kgU?=
 =?us-ascii?Q?K+vTtZ5EkThgUQDyWfZDAfPu72gR8MoujSYYDbFXwiywGqaFpKaRADaiE5FQ?=
 =?us-ascii?Q?kX1Aa8qk3H+/8N8LrVjDyk7rE7VeFS2j7J2Iq2LEo8Vzkp0/1aL3nAZL7kfW?=
 =?us-ascii?Q?iiFW2XYoVoL6sazUxwj6ZMM/7fDJlS/bjQXYAC19C/cF4YVjtAN08SQngbX+?=
 =?us-ascii?Q?DSZfoVgJdFbWDpsy1bbCiZJnq7w4sgRsxod7llFfufYMt0cAIskEXKHcBHqu?=
 =?us-ascii?Q?BnskMX/mHoeKD0skP8BK40/ru+YAYck62/dDSc8Mkf/g3qyeSdDepKUnoSuC?=
 =?us-ascii?Q?dy0qHCEhfgbEX79a4eL3KmcQhW8VXAD/YiM6lnvAEJFp3KADd9lGEBRrsSVD?=
 =?us-ascii?Q?Onziqq1PBdGE+CTMRPq6RdpJq/GkDTbgnkZ42blwBeVy0Wrx141gWPyg+9EQ?=
 =?us-ascii?Q?7iGaRW0BPQcCfvW3tLcdRTv8rfipYcDXRXybYE8wch/PQd1VgJhIe4OrQn12?=
 =?us-ascii?Q?TAJmyyVPTfrkgfcNoHzv+wcFhelGEJsvfQtA+VR0agfwhReka+kBoaYbD5TC?=
 =?us-ascii?Q?CnTHW+YtL07JX/zbxuc0MGFT9pvRiftSXO/h27qUX3+LMMmrBNxRnn3IgQ8f?=
 =?us-ascii?Q?x/41lD+guAS9P70fc0CcOtPnKW6dkyz7flRKwwgjDNOZRkob23DjYSFKyi25?=
 =?us-ascii?Q?ZGPuZC72yBMkCfLzbDbm7xHTGf+zFsU1CFGaeey4hTmGsU+txIfqc28DhZfS?=
 =?us-ascii?Q?LCBZdTB6zRQyq4GL40OEdaS06Y84n9N4ahqUACliWHyZPDao5C0WU57GknpZ?=
 =?us-ascii?Q?9suQSp/GdgKofjYFgymEhLkNkeOfhJBjcWealB3h7etRmBx/DdmbPRStLvxR?=
 =?us-ascii?Q?dQfHPbFLZ0ia/u7NoxcbuQLb3k9N3QYnY4e+aXohfFPZPlewB9GW8MNheTsX?=
 =?us-ascii?Q?YzMSpv+WK6F/Hflaiw5UVhmN2DNdd2N9C6xnVNAQ1amFBFJ6Rp1lRJjY6tW0?=
 =?us-ascii?Q?HPm7GKM0jTobhaoFQECJ6xe3h/PcSDsUWAJ6zKAmOuMnhYdDFLw+MJCXmuRJ?=
 =?us-ascii?Q?0eYEfRmCtI++Qu1+XYD6RD6UVc3xb8/d91tze9LJyh9hQ4WeoQCgizqp2ObY?=
 =?us-ascii?Q?fCE3YAMydmPSwr90GKmlwBSsnxlxCF8FbSUz2q7E19+BKQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XAH0xQmzEj6O42apVlZg7I3++GdoYX0CbuxaI5hTycMV2X/1AxG1KnilYTbc?=
 =?us-ascii?Q?zxBsLO/cst6lwg9MlM/vkMiwktmXvFKBrrR1+c1Okd1NBkN/DtyZSNQjNyjz?=
 =?us-ascii?Q?XGQHFIUNwegpYYAH8MAsa9nVYoNI4wGbXC0fqFMCvCKsauLBjwzyPEW5md1x?=
 =?us-ascii?Q?SpHtXqI/BLYLvfWgN4dXDovjXGo5JhQmJ5A0n4k38CqYn+eQ/ik388Gf3B/9?=
 =?us-ascii?Q?3Nb1O2VqTUNJehFqOZxyXylwfbLeBce5cIV3wJU6ncfJq7y6ZhSPId860rEM?=
 =?us-ascii?Q?flp4c0dBugkphCfm/P58QOludayEus0u8BS3QSpqzcOqbJ9+0tv/hrgg4jr3?=
 =?us-ascii?Q?dakazBmF5uiZWvu3ReYAHRms3HIThTksj98oK4dqK3z15dHrLTkigpMCrq7T?=
 =?us-ascii?Q?HgFJ430ICU8cMZ22DPhBeohf3rK6XNf91t5caJ+ImGnopCYP8MRZVmtWLZui?=
 =?us-ascii?Q?sONnLKgv/uSBwl10RXYflqLJucFkgukh5n9yJ7CGC8rWEH5h2tMVjiuacpzB?=
 =?us-ascii?Q?eY7IjWZnvH8EI188bbK/v8TTOnpMEh1C/i+hhyurJpLldZdZgq7YtolL02Cl?=
 =?us-ascii?Q?httu8ZLkSHaMzvyGn3lDz9nkAl+ik3yhdYkh0jxkl059wB2TSFnihmAX3FE5?=
 =?us-ascii?Q?JKBR4R7YEh5aE12jsmmxLwv+P9+2OgOqwurVSFg+XsIjFujQLYHDw63DV+/D?=
 =?us-ascii?Q?ol/p5b/0B3IIQ0YMfbFHRsNWQLY76kTUAZaOt/tWJfvKjifF/LQjbCWX9Iw+?=
 =?us-ascii?Q?A0sxSDifNMxkqRPR5U7wtmIaTVi/hTKEmzjNVOqGDxjuUeb8FSQ5n5A8+Eyz?=
 =?us-ascii?Q?xxj8luKJwvo8ze86rFs6BrbbYXYxPFy3BIQWuBBcRhex20t8rugapXqyiMzv?=
 =?us-ascii?Q?jaxI/3+Fmz8O0j/ZOcWiGr/7l26a/J2euIm/AGBOWDHg5vCYuoe/e0m/gFyE?=
 =?us-ascii?Q?njjV+FV22Y2E5b5aSdAMh5KqhBj9Kc/wWSfCt2KLUYw+Hz0M1dhhx7a1+II3?=
 =?us-ascii?Q?Kj45uTIUed/9Ras1xXnJB97RSZzuLlmIw2Z9Yth9VwPKCJDJgFSwPE6Yq0Nj?=
 =?us-ascii?Q?WmKbmfa54Rzgkd7zz2Lp3cIKcuFrmIjMb4otCNQlMYJPFTRSW2Kl7SqL54u4?=
 =?us-ascii?Q?sYlswfPHDO3xgeye/HOaVEOVfRgxnq7JgziE2gC+Bg7MOFS8sgdAzZz+0353?=
 =?us-ascii?Q?NQ/2Z1y3qNQqhxwGuu270Gui4uKiUl+cvyGbSN5iBVE7dn1G7nb7c0hWzJ7V?=
 =?us-ascii?Q?SJSKA7fmeEJwR/cU14iSqZLIHkc5ISLqrXnc4iAoMBOg/fnguL+ydkH56Vc5?=
 =?us-ascii?Q?4ddlHR6BDMK5a57HOai8hxdsYnG4U3g3UIS94HcAdjld9kdL1YY7DWH22i1R?=
 =?us-ascii?Q?7AOz5XnOsWQDJX0Te57ouXaNYNw03pZH45GPpPfJRhkVDRlFzhu9VzgEiI7+?=
 =?us-ascii?Q?vfqAEy2qVlBwvfLV6GwIYbO2ZEzqI/++6jbF6oKUabq3HZ7aAAURxgFkXzg9?=
 =?us-ascii?Q?fY+81YJbcQGasAIa6Ps7nV/+68JLow4aHYsYCEQpliy/xQKB4X5lRw3nKAR4?=
 =?us-ascii?Q?gfx4Z1bbrMbmbru53BQp+QcbPlgrK7Tb6yYqduEo?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26860915-d4ea-4c96-6eb7-08dcde1e6e9f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 11:29:06.7678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NUnloVo+Wp9I8MvoI4jSArSwyqVvx1VkA/ReTArhgiz93JclxeCTVha5QPY4PbHAEwOuN2sis2EEkj+WBJM1sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8423
X-Authority-Analysis: v=2.4 cv=Z/q+H2RA c=1 sm=1 tr=0 ts=66f54585 cx=c_pps a=GDxOUaUasxmcDRSC7gC2IA==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=EaEq8P2WXUwA:10 a=bRTqI5nwn0kA:10 a=t7CeM3EgAAAA:8 a=NEAV23lmAAAA:8 a=FU1QvF0BkM4HHXaZ0hYA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: sA6y2uPyKcyjquAEVUkREiT_0TaotVz1
X-Proofpoint-GUID: sA6y2uPyKcyjquAEVUkREiT_0TaotVz1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-26_04,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 mlxscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2408220000 definitions=main-2409260077
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Sep 2024 11:29:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/674

For some distributions (e.g. Yocto) that do not provide
system-release/distribution-release file, libdnf can not get releasever
variable, causing conf.substitutions['releasever'] to not be set.
This will cause 'sepolicy generate' command to fail with the following
error on these distributions:

$ sepolicy generate --init /usr/local/bin/foo
Traceback (most recent call last):
  File "/usr/bin/sepolicy", line 702, in <module>
    args.func(args)
  File "/usr/bin/sepolicy", line 569, in generate
    mypolicy.gen_writeable()
  File "/usr/lib/python3.12/site-packages/sepolicy/generate.py", line 1302, in gen_writeable
    self.__extract_rpms()
  File "/usr/lib/python3.12/site-packages/sepolicy/generate.py", line 1268, in __extract_rpms
    base.read_all_repos()
  File "/usr/lib/python3.12/site-packages/dnf/base.py", line 554, in read_all_repos
    for repo in reader:
                ^^^^^^
  File "/usr/lib/python3.12/site-packages/dnf/conf/read.py", line 42, in __iter__
    for r in self._get_repos(self.conf.config_file_path):
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.12/site-packages/dnf/conf/read.py", line 109, in _get_repos
    parser.setSubstitutions(substs)
  File "/usr/lib/python3.12/site-packages/libdnf/conf.py", line 1643, in setSubstitutions
    return _conf.ConfigParser_setSubstitutions(self, substitutions)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
TypeError: in method 'ConfigParser_setSubstitutions', argument 2 of type 'std::map< std::string,std::string,std::less< std::string >,std::allocator< std::pair< std::string const,std::string > > > const &'

Set conf.substitutions['releasever'] to empty str if releasever is None.

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...f.substitutions-releasever-to-empty-.patch | 61 +++++++++++++++++++
 .../selinux/selinux-python_3.7.bb             |  1 +
 2 files changed, 62 insertions(+)
 create mode 100644 recipes-security/selinux/selinux-python/0001-sepolicy-set-conf.substitutions-releasever-to-empty-.patch

diff --git a/recipes-security/selinux/selinux-python/0001-sepolicy-set-conf.substitutions-releasever-to-empty-.patch b/recipes-security/selinux/selinux-python/0001-sepolicy-set-conf.substitutions-releasever-to-empty-.patch
new file mode 100644
index 0000000..5c744d7
--- /dev/null
+++ b/recipes-security/selinux/selinux-python/0001-sepolicy-set-conf.substitutions-releasever-to-empty-.patch
@@ -0,0 +1,61 @@
+From 70187651a2239d5d8d70130e82c6f108eee77aa1 Mon Sep 17 00:00:00 2001
+From: Yi Zhao <yi.zhao@windriver.com>
+Date: Tue, 24 Sep 2024 14:07:41 +0800
+Subject: [PATCH] sepolicy: set conf.substitutions['releasever'] to empty str
+ when releasever is None
+
+For some distributions (e.g. Yocto) that do not provide
+system-release/distribution-release file, libdnf can not get releasever
+variable, causing conf.substitutions['releasever'] to not be set.
+This will cause 'sepolicy generate' command to fail with the following
+error on these distributions:
+
+$ sepolicy generate --init /usr/local/bin/foo
+Traceback (most recent call last):
+  File "/usr/bin/sepolicy", line 702, in <module>
+    args.func(args)
+  File "/usr/bin/sepolicy", line 569, in generate
+    mypolicy.gen_writeable()
+  File "/usr/lib/python3.12/site-packages/sepolicy/generate.py", line 1302, in gen_writeable
+    self.__extract_rpms()
+  File "/usr/lib/python3.12/site-packages/sepolicy/generate.py", line 1268, in __extract_rpms
+    base.read_all_repos()
+  File "/usr/lib/python3.12/site-packages/dnf/base.py", line 554, in read_all_repos
+    for repo in reader:
+                ^^^^^^
+  File "/usr/lib/python3.12/site-packages/dnf/conf/read.py", line 42, in __iter__
+    for r in self._get_repos(self.conf.config_file_path):
+             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+  File "/usr/lib/python3.12/site-packages/dnf/conf/read.py", line 109, in _get_repos
+    parser.setSubstitutions(substs)
+  File "/usr/lib/python3.12/site-packages/libdnf/conf.py", line 1643, in setSubstitutions
+    return _conf.ConfigParser_setSubstitutions(self, substitutions)
+           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+TypeError: in method 'ConfigParser_setSubstitutions', argument 2 of type 'std::map< std::string,std::string,std::less< std::string >,std::allocator< std::pair< std::string const,std::string > > > const &'
+
+Set conf.substitutions['releasever'] to empty str if releasever is None.
+
+Upstream-Status: Submitted [https://github.com/SELinuxProject/selinux/pull/444]
+
+Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
+---
+ sepolicy/sepolicy/generate.py | 3 +++
+ 1 file changed, 3 insertions(+)
+
+diff --git a/sepolicy/sepolicy/generate.py b/sepolicy/sepolicy/generate.py
+index adf65f2..56923dc 100644
+--- a/sepolicy/sepolicy/generate.py
++++ b/sepolicy/sepolicy/generate.py
+@@ -1265,6 +1265,9 @@ allow %s_t %s_t:%s_socket name_%s;
+         import dnf
+ 
+         with dnf.Base() as base:
++            if base.conf.substitutions.get('releasever') is None:
++                base.conf.substitutions['releasever'] = ''
++
+             base.read_all_repos()
+             base.fill_sack(load_system_repo=True)
+ 
+-- 
+2.25.1
+
diff --git a/recipes-security/selinux/selinux-python_3.7.bb b/recipes-security/selinux/selinux-python_3.7.bb
index faf5d28..e2dc932 100644
--- a/recipes-security/selinux/selinux-python_3.7.bb
+++ b/recipes-security/selinux/selinux-python_3.7.bb
@@ -11,6 +11,7 @@ require selinux_common.inc
 inherit python3targetconfig
 
 SRC_URI += "file://fix-sepolicy-install-path.patch \
+            file://0001-sepolicy-set-conf.substitutions-releasever-to-empty-.patch \
            "
 
 S = "${WORKDIR}/git/python"
-- 
2.25.1


