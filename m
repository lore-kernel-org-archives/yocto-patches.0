Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E643CAC5A5
	for <webhook@archiver.kernel.org>; Thu, 18 Sep 2025 02:05:08 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.4330.1758161105827075568
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 17 Sep 2025 19:05:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=qGIcWlxX;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=1356ee1fc6=yi.zhao@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58I0xfEI3073366
	for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Sep 2025 19:05:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=qrtq8wYNTXbuGaDOS3Jz
	3UfoQ8K2GTHmrV0oSWkuFk0=; b=qGIcWlxXw6zsqHpk50zs7lFJqQnBHJ/KxBVJ
	uElKmNAlRZNQGu5L8xePJL9FBH5dh9s1ym2PbfPCwxYZP1NolocCmeqtoTJ/JLil
	0ZlzeYuNKFkTlWN2GVhZ4w2/F7DV7s1jmEEzyzi/XGU701Fkmu2sOgx0wL8bL0+t
	ErdQgqJsvRD9dFe8hXA1W5MigvrAkQ2ynmnC48nEd0zk9kKZ/go5B5In0X5Y7+Ni
	HjRLa4ac3Ww1ZbKzm3ntikdpcVc+rN49CBDh8FofOn1+5RwJLJVeSjU5hyz7vR5l
	cEWjdIRtsnN9t9pADoZ7E8duhk7dFfTXm0N7P3Ud2fZSvpZP3Q==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011021.outbound.protection.outlook.com [52.101.57.21])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 497fwr1g8d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Sep 2025 19:05:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SgPBcGrcNZZ8nBCBfDNYRlMK2iCtMNta6vxTJEhiKaNYDS016/rl0tEU6NvMdR4zoZr1xzcaUrxkUNSp0POkgZtaswIiYquSZto97d6ggQON/Su5h/ZIBlcEitnOisToOqFh5pfCXuquk7qpKaRF+7bvmKMSYhG6HG+YgEPGEix5286m87NRI//0gBk1FnzawhmGtInQB4Y4h/8rjGfkpLRLU1m8z/t3x/G0IbBGOWWz1DYNAhgxiFO60tEcUGn+l/gZxF32SVnTdiChW7BVl28DJBRo5wKPH+Q+CTJVF+1y37QQVC+ldq31blQx95M03lBsDQ0vY4DGFL89aDODlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrtq8wYNTXbuGaDOS3Jz3UfoQ8K2GTHmrV0oSWkuFk0=;
 b=YJwrZKdioLck8okhE3yqM7j9prCvD5DPSxjhSQCv4tnroQ0hkA3qII12XcQxsqJXrbt8D+yffEXv4kKQX4Rf1V+FuYIycADXwoZxEgI0qsGiWckrz7Bx0pfyvxDQVb5CkuSS0EIowEThEdloWhzFBuJOrbz1/RBb8/Ud57lqI9d6zhIdHIS+FqQOQI0HLmSHuNpVQWG9cWHiB3MzZOgUiyOWUz9G3rtTVNzsYrpdXho21/K/jTdorzY12/weY1wwiKItyLthvug40xfSfwQIKLdVjHJlYs8dzfJKJIT4ddQhqwCb40lyFBBIQVdY+P5NBYsohmEnJGfGlsEjacr+Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 DM3PR11MB8681.namprd11.prod.outlook.com (2603:10b6:0:49::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.23; Thu, 18 Sep 2025 02:05:02 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 02:05:02 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][scarthgap][PATCH 1/2] refpolicy: fix build for refpolicy-minimum
Date: Thu, 18 Sep 2025 10:04:44 +0800
Message-Id: <20250918020445.1175478-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0218.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::17) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|DM3PR11MB8681:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d927bd1-a3fa-414e-023d-08ddf657c729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?54zP6j6bOzWZFSCaHjLhpUAYZfJk4O7F2Lf41J3JGFj1sCbgWklytN/2vifz?=
 =?us-ascii?Q?opo+9FINkYhHgMDuLeZ9u7jtKpiNbzocNt/sue2gaBVUL7tdjgdwgWUOYhnn?=
 =?us-ascii?Q?54PnIaHBYBXyCoeeXFBYE6UKMX+H31qDM5MvHp5iDTNRXDHseobc8Xfjm2f4?=
 =?us-ascii?Q?/VCi0DuTugnbEpsZJz9q3jjWFqBLxqQjoy1o90VNpydT+ScVMX9Q9VMhO1NR?=
 =?us-ascii?Q?Uo9l2e6Vv0xfHMKuPX+5BhVnkJoTSjbPWU4+hU2jIifHbu7AnsTv97MMetgg?=
 =?us-ascii?Q?bNet8rdxXx233s42/RclnluEyDm/ZYSeO6Xc7BO8wn8J/dKyYZClMuIUjZM4?=
 =?us-ascii?Q?JOegsY9K74+JNkO6P/O0YGpEvqV7xh8zHSJO573PxYwf3FhzBCgU/HosOrjs?=
 =?us-ascii?Q?YhUXRemsyRv0hZwqeTQRuLP7lxn9+nraZa7Jy9kNjhY4mriK3k7ytKfMH2D+?=
 =?us-ascii?Q?F1SgtRSgMpM685q9I6ebEhSjvfUgMpuFSSZ+p6H8JWazhIkChDLzeJAgg5km?=
 =?us-ascii?Q?zqvNUl7jeiAeXRbuNT0v+rCMaiQB+e1vcQNIezUunkkc3AQyueI2CLJ56TwT?=
 =?us-ascii?Q?itZgdN0nnR3CObWNR/f4lsi2Fq8bnpw2JGvf7Itm3p+G/fI8w53pNBB5jmog?=
 =?us-ascii?Q?IZ4v+ppKjwX8tBEahQcb8yg0NQm43nPtNLhRJhhBhRov3b0JyPqAevyZrcyC?=
 =?us-ascii?Q?5GpP4sSPDLOd/b3qiAo1DMSWJzWsK0ZvD0GU64wUFdz1n3Eb5xxWSYFX8e5n?=
 =?us-ascii?Q?ZSMZgR2TD3OlvzNrgge2Fc+yfnjFpNWbpiO/eK2hqMUX2AYRAWjw2i5Vzbif?=
 =?us-ascii?Q?+hdjHKATIrwVlNL2GeSfbq6dSpUpypvLPpS3SNvyO0mCo9P8LgsWkHv4BxdU?=
 =?us-ascii?Q?T/r4y5QLRuiW8fGooinXKARCQHKkexqAW8wWH0yz5ZlxtvX+LwDwJm58rBFD?=
 =?us-ascii?Q?0T75hZlU5zF7WyPcD5XUJrtSrq9iu4fuGXb3UIogOE5LQmru1RXu6+QfXqtf?=
 =?us-ascii?Q?6U8DgkvvHOaryiZb1hwhjsoYEK/tcopGhc/MIz8uPm0xXf8Wyf5uRaX68Jwr?=
 =?us-ascii?Q?HzKyyDdy3hQ/zuBFxcLew3gG0iluprRMqls06tbVGzpUM7o4z5KkSCXR/6/o?=
 =?us-ascii?Q?9WJF4TGew/IYugZNzYiz/UH1H13ScpFtpGFO/HIRRTUJrbocM858Te5+U3YF?=
 =?us-ascii?Q?eXT5ypECkbhPPHeXVpPxgiPcAC8YgUDHwLA2RpvafA8eRvmfR3tZI7IRz2p0?=
 =?us-ascii?Q?TocgPYmuX5AWowfRVMXvVcAphl7wsgAa1FWV2LSQcw8YUcgWnYOzQEFNmj1l?=
 =?us-ascii?Q?NqdGEGcDBrMpMz8d3Hj0LYt2UZ8fnzAHAVbSYdnO4ayGGwVw16oIcCCosjA/?=
 =?us-ascii?Q?qMSySFA9fU45tTjjaS4eFbPdr7i/pHKYSDTHw1C82WyQWYbuf7xIevljoOWp?=
 =?us-ascii?Q?4KXDH5SHcCI+cqqvZdrQKmQc/qYR+v3qdjUj3wRFHjG0E5Q5H0rFCPXFMEpF?=
 =?us-ascii?Q?X3B+es3js6J5/B4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/6A4FzEFhum657GnnlNLih/EFibree3f5J1ey8a3GVXE6L3jqAkknC7P4RhH?=
 =?us-ascii?Q?CZFR+WMA35v4amDr9wAjp9amTfWj6mVXtH5Azvf0IMN60SQkOVddC4dPTnk4?=
 =?us-ascii?Q?Yu2MO/+c6mRHgLDM9B1toYANQWXwGB8g1v4u+d/fTwh9KQ5XT/oeVj3VhhtO?=
 =?us-ascii?Q?MzlMdDSKmh0IXwqbLQFW8JMQPd79TGphaCPXT6DhEwDPdIRY3LzSMParheEC?=
 =?us-ascii?Q?knB+lPYJLiarhCMbJ5gX2MqvuIrz9uhmN5U7UeJpiJr3EQlrmZA6OnE2jLVC?=
 =?us-ascii?Q?aaLkAOWpKaGMHe70yD8X6vHQFY2Ma+AhkMNE4l+F2yEz02kWZcovrTS4ZMFF?=
 =?us-ascii?Q?wn3RhoYMo6nVOQGEYoT/CU1RzVUDLQz6ZzFAZTwYg9vQlKqbCZ37at3WIOG/?=
 =?us-ascii?Q?6jeUZdt+xooBunt87wgRq8XMXxgKqa2sDEdFZah6ZHvGV7bLgJly0d15RMMN?=
 =?us-ascii?Q?ehoQhOVIyOr6bhuh88vC0V5MSfrxQBO7MCH0+SGSwWWgo2BEVM+r3+G5qNOH?=
 =?us-ascii?Q?326ouB83A3CfGCl1sgPcc8vBGA/wOjyR7n1uOwqBuaytJZZl97RazOvB/18b?=
 =?us-ascii?Q?KFYyyrejes8RhAZ6wryv6YHpb2uIyuas/tczj0DJJEaV34/lIVYGeoWsYlpx?=
 =?us-ascii?Q?3XJDGvqu1mBzB6Xr/sZDPpYOyb/9duV0d5njHIm0xA3x/sJV8S4hJCa3b46z?=
 =?us-ascii?Q?12YXW4dNSpKrvxBYJvsM/oxvrMLnwMDvHOAL/pnMj9WqaaGx2VQz3udeVx2L?=
 =?us-ascii?Q?1mqsSE/nQRTFbjtjZa+onc2ES+K+E+kIBFYoIorI7heMVlBBs84gPhhjDyul?=
 =?us-ascii?Q?7xZrjK6jyEEfyF8G5M+EderiffGAIFYMgy+XJ4w50F0g49w7wBF2nSofCQwu?=
 =?us-ascii?Q?+YDjupNDKLl+GMpzJEKFq+/74+HNH7CGEh1lbHdK60abQaF5FIsxKfUSEMeL?=
 =?us-ascii?Q?SePjXrjCKYWgpdwsABxMNoRWATakprvW+rnsusrOC9fIEqUyilS6SWbjGtYl?=
 =?us-ascii?Q?melYUu0WEhkr6pU0njrfMOQv8JW0hd/AVvbXwGumbPf+OlxgLSCWrlAmJ1AE?=
 =?us-ascii?Q?GZ4mAgY3bqsIEusXh4cf4CL0N7Tp1MPFcuEfmJCs3GiMSFi1Wz7soVHSr/58?=
 =?us-ascii?Q?Drl/7QcrIyv6tgLlA/ykOOQ6dw6ahsns+mpvsKFWL0r/LQsxHgFEmSgZVWqD?=
 =?us-ascii?Q?AIV0o2Gl00l1mBujfpYFL4eNosaGtrpp3fs82ADW1IUDbApL9ke9MWR9nLhX?=
 =?us-ascii?Q?ComOkl/77sfwzAQZ6ZtuoiBJQZJiGIls6URjIrx/G8Lj8YSRA+lX0NgWFzyC?=
 =?us-ascii?Q?xFLFhAb3+z6Dx4JgocLLRTP05B7U9hosK+AFdhwmBUsYqsQiE2ijDbXEApyc?=
 =?us-ascii?Q?TF6a9u0sNdKTyxNavqpw6u9yeSm1RnsxURAmyiWUML4qZOHIpR3Hlp5WIZOR?=
 =?us-ascii?Q?Aq+j0Tp1FPQsoF/gfpc5Kpr8FnwbcdoKwtuBgwOJT2ylgrfJ4uqtQXRtbVKB?=
 =?us-ascii?Q?C9Os/0ixOADCrd74pnAR+pFQ+8Ya7V1BSAy+sD1EGaffcgeDyykWiQxluGHi?=
 =?us-ascii?Q?nszyZy5xAg8Q18ogllAYBobBvieSg8dzGrCqQWds?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d927bd1-a3fa-414e-023d-08ddf657c729
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 02:05:02.2634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jG+fdUUOOeORKnNN+jkDRA5k5AN6MTmiLmdU047gX4zxkGu9vJ8wfBVjWhBr1v4tAMNcUZd6l0vOlh+dK1BNhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8681
X-Proofpoint-GUID: AiwyO11svTpKwBvpW4wjDXtGt3tkziPv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDAxNiBTYWx0ZWRfX+pbDY7wgN7u3
 3M97rJTi7buNme3fxc+aSd7GKP61hkgSvqkq6a0aNnBtGfez1J85AegtJ2J9r+dgI7efzLmbfVO
 8pqaWZMlVCqR7HpT/ORjdqGt42AY0h27/pJ+kA1Zy5xuxwD+iJlbsdI0C2fkgv/df9xOlSjjnRV
 DsMWHwEdX+tWTDOYP2rqcUq2S9llyBNu2zs0DhQhy90Ir/HcfQYof4IUpyTaRjmH3qECf20IfHG
 95WtTHNnv2EtxSriVKwjf+TSgWKb9EqUue68nq0G5WSE6kOQilSm9hrmqO2uLARNw0K7xS30MhX
 TdtlFO5tgv8TNuJ8E6GQa63VTkqU9wTvJ2mQPr6qVLqqMHLgXmsR4h82khyR2Q=
X-Authority-Analysis: v=2.4 cv=WvsrMcfv c=1 sm=1 tr=0 ts=68cb68d1 cx=c_pps
 a=UGDxSQ6JIm3CXF+tY3HRSA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=t7CeM3EgAAAA:8
 a=pGLkceISAAAA:8 a=E7_K9k9lKeYW23klVPMA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: AiwyO11svTpKwBvpW4wjDXtGt3tkziPv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2507300000 definitions=firstrun
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 18 Sep 2025 02:05:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2213

Backport 2 patches to fix build for refpolicy-minimum when INIT_MANAGER
is set to sysvinit.

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../refpolicy/0067-fixdep-dbus.patch          | 45 +++++++++++++++++++
 ...ding-when-dbus-module-is-not-enabled.patch | 42 +++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  2 +
 3 files changed, 89 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0067-fixdep-dbus.patch
 create mode 100644 recipes-security/refpolicy/refpolicy/0068-fix-building-when-dbus-module-is-not-enabled.patch

diff --git a/recipes-security/refpolicy/refpolicy/0067-fixdep-dbus.patch b/recipes-security/refpolicy/refpolicy/0067-fixdep-dbus.patch
new file mode 100644
index 0000000..9f5958a
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0067-fixdep-dbus.patch
@@ -0,0 +1,45 @@
+From 684b47eddf512402db552601c33e2d0ad4eef578 Mon Sep 17 00:00:00 2001
+From: Nicolas PARLANT <nicolas.parlant@parhuet.fr>
+Date: Fri, 17 Jan 2025 15:51:48 +0100
+Subject: [PATCH] fixdep dbus
+
+auth_use_pam_systemd requires dbus  :
+
+> /var/lib/selinux/targeted/tmp/modules/400/authlogin/cil:133 =
+> (typeattributeset cil_gen_require dbusd_system_bus_client)
+
+Upstream-Status: Backport
+[https://github.com/SELinuxProject/refpolicy/commit/684b47eddf512402db552601c33e2d0ad4eef578]
+
+Signed-off-by: Nicolas PARLANT <nicolas.parlant@parhuet.fr>
+Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
+---
+ policy/modules/system/authlogin.te | 5 ++++-
+ 1 file changed, 4 insertions(+), 1 deletion(-)
+
+diff --git a/policy/modules/system/authlogin.te b/policy/modules/system/authlogin.te
+index a75a669b9..d9d1a1428 100644
+--- a/policy/modules/system/authlogin.te
++++ b/policy/modules/system/authlogin.te
+@@ -142,7 +142,6 @@ term_dontaudit_use_all_ptys(chkpwd_t)
+ 
+ auth_read_shadow_history(chkpwd_t)
+ auth_use_nsswitch(chkpwd_t)
+-auth_use_pam_systemd(chkpwd_t)
+ 
+ logging_send_audit_msgs(chkpwd_t)
+ logging_send_syslog_msg(chkpwd_t)
+@@ -160,6 +159,10 @@ ifdef(`distro_ubuntu',`
+ 	')
+ ')
+ 
++ifdef(`init_systemd',`
++	auth_use_pam_systemd(chkpwd_t)
++')
++
+ optional_policy(`
+ 	# apache leaks file descriptors
+ 	apache_dontaudit_rw_tcp_sockets(chkpwd_t)
+-- 
+2.34.1
+
diff --git a/recipes-security/refpolicy/refpolicy/0068-fix-building-when-dbus-module-is-not-enabled.patch b/recipes-security/refpolicy/refpolicy/0068-fix-building-when-dbus-module-is-not-enabled.patch
new file mode 100644
index 0000000..8709932
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0068-fix-building-when-dbus-module-is-not-enabled.patch
@@ -0,0 +1,42 @@
+From 1d62379321c19e89268ac7854a8ff8dce280ed07 Mon Sep 17 00:00:00 2001
+From: Dave Sugar <dsugar100@gmail.com>
+Date: Thu, 15 May 2025 10:05:24 -0400
+Subject: [PATCH] fix building when dbus module is not enabled
+
+Upstream-Status: Backport
+[https://github.com/SELinuxProject/refpolicy/commit/1d62379321c19e89268ac7854a8ff8dce280ed07]
+
+Signed-off-by: Dave Sugar <dsugar100@gmail.com>
+Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
+---
+ policy/modules/system/selinuxutil.te | 7 ++++++-
+ 1 file changed, 6 insertions(+), 1 deletion(-)
+
+diff --git a/policy/modules/system/selinuxutil.te b/policy/modules/system/selinuxutil.te
+index 86a6e5503..cd0e8762f 100644
+--- a/policy/modules/system/selinuxutil.te
++++ b/policy/modules/system/selinuxutil.te
+@@ -99,7 +99,8 @@ role run_init_roles types run_init_t;
+ 
+ type selinux_dbus_t;
+ type selinux_dbus_exec_t;
+-dbus_system_domain(selinux_dbus_t, selinux_dbus_exec_t)
++domain_type(selinux_dbus_t)
++domain_entry_file(selinux_dbus_t, selinux_dbus_exec_t)
+ 
+ type semanage_t;
+ type semanage_exec_t;
+@@ -504,6 +505,10 @@ miscfiles_read_localization(selinux_dbus_t)
+ 
+ seutil_domtrans_semanage(selinux_dbus_t)
+ 
++optional_policy(`
++	dbus_system_domain(selinux_dbus_t, selinux_dbus_exec_t)
++')
++
+ optional_policy(`
+ 	policykit_dbus_chat(selinux_dbus_t)
+ ')
+-- 
+2.34.1
+
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 5cb44a8..d1a6214 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -82,6 +82,8 @@ SRC_URI += " \
         file://0064-policy-modules-system-locallogin-allow-sulogin_t-unc.patch \
         file://0065-policy-modules-system-locallogin-allow-sulogin_t-use.patch \
         file://0066-policy-modules-services-oddjob-allow-oddjob_mkhomedi.patch \
+        file://0067-fixdep-dbus.patch \
+        file://0068-fix-building-when-dbus-module-is-not-enabled.patch \
         "
 
 S = "${WORKDIR}/refpolicy"
-- 
2.34.1


