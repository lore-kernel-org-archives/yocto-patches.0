Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95F3C36012
	for <webhook@archiver.kernel.org>; Thu, 27 Mar 2025 13:23:49 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.49878.1743081827220691312
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Mar 2025 06:23:47 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=5181a5ef2b=yi.zhao@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R8knIs025090
	for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Mar 2025 06:23:46 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hvqkdn2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Mar 2025 06:23:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aq3vokI6dk7R03C5gNJ0CTLn0xWyC7yNFrKdNcgInbKKQHtdD87NsXS+kO7jSV3aWHaAlWmvi0ozKoLeO9rO2uqxTC1/HHW4iTrPNorTdYKOPwUKPvZ9tkYTSCAyWGOKlAfr0ffXWsWLV/vnSbgR/4G2XU6e9u9zhtVH8s3hYzAa/RcDjlIrsqbkME17RbPIWqrp36CPVtsv18/oOlp7exgPFcbkZ0wRui+JAZ7o+r9MyqJxa9Go0qRtG0p41kPHLVxwCvYDG2ymINHU6WAToyNUeqDszhKn4oaGSQ3w7CSBDfejA3J4NxFoGTpuWR61PDl8anpr+tgbPjEufdnuIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r69gaPNA2xdnZX2cmI+QC9o9shOQpBeWzBXgCugZuAw=;
 b=Qn3yC2QnaTt33tQ9yeHhcpEfwhiIb0X0yvZFpNfRrBjOsk55bw0EOxopSxquXcNmup80CEaPOz1jG4RuUfBBRyQUQLyx2+CCk6byRC463BF/ESwIoYmU6qFIPrNKua3rYPHUKlG0Xg4zQNlqAUVbgwYH8O8rcyIizDN6eP5AxzEQZ94bL9fvvkbNVoVJWSSGssm7dKj90/BG73bCgqYW72ZgAHdJvx//uuh16kQKzymAK6v9chZEKBIFYwgtF+G5ifVzYD4/qFfsez25kA5XzEfw1xnbiHuGADxn9sNr2TyzSpcqc31/Y/4V86ZL4d2qYeQwI+Z6kqgi/NtRCSnD1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 MW4PR11MB5773.namprd11.prod.outlook.com (2603:10b6:303:180::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 13:23:43 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 13:23:43 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 1/5] samhain: upgrade 4.4.10 -> 4.5.2
Date: Thu, 27 Mar 2025 21:23:23 +0800
Message-Id: <20250327132327.3477926-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|MW4PR11MB5773:EE_
X-MS-Office365-Filtering-Correlation-Id: b4aa21d2-f810-4ca1-fc77-08dd6d329871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?IRR+SdzJr2zkS8gCLR43EDUYavyK+q+Y8JOLTzNVihw1RV6+Twt5wufz48jW?=
 =?us-ascii?Q?u0vLDNag/8z/8xVtLThD6uf14eydr66owRjCNt78yDzbpA3mCkTGl1ohkS3D?=
 =?us-ascii?Q?PgqhMwWLduaQ8six4s36cDh3oB4FE4Ig4HMYO+JuA57jrhHNKZmHuQv1rKjN?=
 =?us-ascii?Q?swPirzKAchZwliwzLNgrd/FUmq87JL0kocFpyOjKdP48G/7XBPxdEo0JV7EK?=
 =?us-ascii?Q?3VX7SqCCecsINGaFSyDPvP2J2mUO1bnptzwTKQ2IiKq4VyD7SM4gTzC8KT+n?=
 =?us-ascii?Q?xfLn5yKrePDBOdA4kQT9dtlL+KGRvV1wnBs8Bqx7T8qMMg34L/GAoze8t2Hh?=
 =?us-ascii?Q?8RQmJkQHaOd3Uk9+NSe0jLTSlN5s6gJwqDMaS78hmvx6CH8VtvvhltxruFRP?=
 =?us-ascii?Q?zhYJzQ3JHUyPrDNMKlXPZWBYXu04Ucb9JGUsGoHgfKCKf/pSHVurKVj7nKbI?=
 =?us-ascii?Q?0e0R6Qf2AUjQgelISzm298Uf8U5RyaWHLzb9RkKucJBRF3vTdWv8fmvoeI7v?=
 =?us-ascii?Q?6vRLHz7tGqBkuuDKCIXi1iI+dbC8wEOult5uou52rrk4vh/B/HsO9wAmDJB6?=
 =?us-ascii?Q?J/xMKrRTD9dQp0z2PcHPrXax9cDBl1nJzqKF2hvCCCJJynxeMzTSUq205t4v?=
 =?us-ascii?Q?X4ggK7wEGKTDnRV4NRQyxcEPeJellUhbfv3hFwTPAMLkZSTxSugJe7a/XDb/?=
 =?us-ascii?Q?SFzcOrIrzr4rzR282qhuEnE00r1DWQXIBAHzkKPBumUTT6WXeZdK1EgKWHAc?=
 =?us-ascii?Q?NtRKgAZRvjqrYZfmjzB6niaJwMBU/6Vm722vshOb8/6gPd3sI2FqgaPZ7gS7?=
 =?us-ascii?Q?Ese7cP0xwAU+ivMRXHy77JWGNN06b2RKZbVkOAy156x517GZjU5F51Lv0xYa?=
 =?us-ascii?Q?gekxKjUiXpPHtsydriMRFArF77iqHAOsL04OIJnpEHfNulZ0Lm8dpm3JzzaG?=
 =?us-ascii?Q?tRGcTn2N63b7PTYNIkp8TIlKsFkQZx5EAa8TL2IeUnqC+6dpSmwb6GNoqEDv?=
 =?us-ascii?Q?Yt7JI+MpW7T77roh6ntcOEyOu5tASFpff4Enw3e03pzfUeGKIKlQMRn3goTK?=
 =?us-ascii?Q?SH5GJvhSkSYletFtmA0HR+xGU5Qfiw1pdEAWK2KqwD3gt9hn80t5f+bpPN7N?=
 =?us-ascii?Q?goSReLSctwe8Zd5MvXxGpETopWxtzuSaRCQpcI5UxiGqcTHnZSKVkAGDEvKH?=
 =?us-ascii?Q?Uyv6RYI2fi1L97KfGb6lokgACiEz0usaSS0dIiDpX6lCU9vox72ZJlLRAtkG?=
 =?us-ascii?Q?MSGtOSWaHY973Kl73TtNub0CnoMLVwRaAbpL0gC+46ztjSRPrF0i4HUSBYOX?=
 =?us-ascii?Q?NSCSjI4wlmFzBefPGZLl2IUgTC2o5dZNXlvW++vodFd8BVvUDOWnP8M9fpn9?=
 =?us-ascii?Q?NcCL8mEZ9dnMWoktDOQn/CXmGf69?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?pa6N2lIqS9aGD2yNgso2Dx85QLMyzdP26v0nScj+z8KJVlTkYNi6VN6AXQOr?=
 =?us-ascii?Q?zCwbYRm4wK2pfcWeutl2tT5Hihr/IQmMlutI6HTinX4V+qOTKIbwqh2xjVnI?=
 =?us-ascii?Q?NWCszpIwAyhE2pcQ4JBXDKuEHONdbYxceYNoHa0llSVcfVaD8lker4aKuQcj?=
 =?us-ascii?Q?CiO6x/gHqohCqqtLBm+smJlkb9L808nQK2cOMDyJWCeJP8S8rwmZFmCT9AKC?=
 =?us-ascii?Q?mdPI955fVdNG8lPXXOxoIiRU/gjugWHGXXTjUbg5kfrqOpDyyzZeo6xNhqT+?=
 =?us-ascii?Q?0+uI7mmWBW1udji6StB//vy30XTrJarhOszBZ8Vfi9a7Hgg0+Jz1GC2Lq1hz?=
 =?us-ascii?Q?dn/TVipXjKlNkVixbjfYUCuHlSkNvEteXgR6dl1ThSBAD/wsS0g8P3ZmMHTD?=
 =?us-ascii?Q?XNN2ZtCPGojEaSA5bK+s5imJ4xvt77voIpfxs2GJASc9cBtjzPCB4MqrKzE5?=
 =?us-ascii?Q?95buzlJfjVemE5Yf8Et3qFjvieikgFCI4x/cvGncB8bHThWW9IyvNkkJA8v9?=
 =?us-ascii?Q?X+t3qlJb9HNWxhU8LhZYzixFZK+aE6vOSq6BbWc6uizeQR1JogUZtOjpZ6MB?=
 =?us-ascii?Q?2Ub1Pmz6/spX0G8lHwu2yPYBhaddLJqFTMpH1GS4ciaXqxdoeq0oRBLZlOww?=
 =?us-ascii?Q?CbtNy73EjA5XU/s9CQMXCvgXikbf5RWlTTpXmoGEQ+b38nJbiE6wazsF0CtN?=
 =?us-ascii?Q?R9fsQM/4mpp4znc3rTMGb4oc8NTnVfYNdM9ukyo8BLAzY9jHxPIUfKvVQS1X?=
 =?us-ascii?Q?qE/UFM6O5YMJGoXo8z7X6Y/OkOH/34zJxWmO9VY6VUBGIypMi9Syd8Wg08CT?=
 =?us-ascii?Q?tNZY8apQM8TkB42vqYS4aw3XroTnfCf4zX0lmScL6cVfsvhwFC3GXytIB978?=
 =?us-ascii?Q?h4v08nyJfvWYV+qWMGnbiIqGHB9lQQR2zGCHjX83OiMMf1h/YIBr7lulQoS0?=
 =?us-ascii?Q?YoQ7EL8AxzypaMF66aXyM0iGrGXQ+/ifVHRY37/wSDPkOQVMXBpZC8Ul0EkQ?=
 =?us-ascii?Q?sRsWkXTLUTHcvcJT/DzzK2q1L2/Q0O4T0AxzwcpJfLRa3fWqoyPDHJ4jxRfC?=
 =?us-ascii?Q?v1trEFYZRTGsPsFsWMf4EvF/WmMMziLXBWmsuMXpJiHKnAEAhW3otfgVfGL+?=
 =?us-ascii?Q?M7Jc3l0yBF+miGpZgkDEDEnzn6pbCDs07Z2oeYWwE7GTImBCQlrJy1gG4boX?=
 =?us-ascii?Q?T2BWVOLh9IfLMrQ6l3AvH2xNhCfy5w4wdAxw9hCcz1Id8+FoMbiw9mNwK1OZ?=
 =?us-ascii?Q?3AKYJ0BG5bvsaWznimy/31if7XCup7bCWd6mjjX6R7V93ubi5MdSf5rRjA2p?=
 =?us-ascii?Q?JPW3eqFqY8LReO3xuuYar75b596hi09IVjXjkavENuAEGPUh1joQDip8ng2N?=
 =?us-ascii?Q?rpuKGTwMlWhSdASswpCC6PjY0vYK2pr5jEnjMRGjvOepVnjxAusrCmRq+A2F?=
 =?us-ascii?Q?amOPr1Frwlhg3WfD5gNFRT8MdF44HkVAICLpKjpuWbd1+uRJ2oL/GKnRruzh?=
 =?us-ascii?Q?seZWIRuD1p1WAh66v7FMC3s33eXSFT+q0VVG09PyPbWEBlqhaWjhgoR65DOJ?=
 =?us-ascii?Q?s0V612QmjEj+Yrj5CPfJlYUayVp7Cyl6RlzU9cQi?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4aa21d2-f810-4ca1-fc77-08dd6d329871
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 13:23:43.3975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWurs0IEm/J+7lkF1/iSTzLElw+WB6ZO5JKW92z9NNzBKUM9MCOB/0Z9TQH18kIII8AKzDoXbhUkJW/9J0Dr0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5773
X-Authority-Analysis: v=2.4 cv=XNkwSRhE c=1 sm=1 tr=0 ts=67e55162 cx=c_pps a=S2IcI55zTQM2EKrhu3zyRw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=H5OGdu5hBBwA:10 a=sC37DgyHAAAA:8 a=nDJU2pNIAAAA:8 a=t7CeM3EgAAAA:8 a=pGLkceISAAAA:8 a=HyIw0vYKUYd5bgbg7FsA:9 a=ujUI9hRtdMIA:10 a=X2ge_OzoSdoA:10 a=NJKfJZhtuoG9hi9TxVfU:22 a=cvUpGn6QkLxiVzwzn9tb:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 4lf-AnmtspFPOCZ4RXx53go-R0ifmZc0
X-Proofpoint-ORIG-GUID: 4lf-AnmtspFPOCZ4RXx53go-R0ifmZc0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503270093
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 27 Mar 2025 13:23:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1266

ChangeLog:
https://fossies.org/linux/samhain/docs/Changelog

* Refresh patches

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...001-Hash-fix-for-MIPS64-and-AARCH64.patch} | 27 ++++---
 ... => 0002-Make-samhainrc-OE-friendly.patch} | 25 ++++---
 ...3-fix-real-path-for-some-files-dirs.patch} | 10 +--
 ...t-the-PID-Lock-path-for-samhain.pid.patch} | 21 +++---
 ...-Fix-sha256-for-big-endian-machines.patch} | 16 ++++-
 ...=> 0006-configure-add-option-for-ps.patch} | 72 +++++++++++--------
 ...avoid-searching-host-for-postgresql.patch} | 27 +++----
 ...riable-for-compiling-samhain_setpwd.patch} |  8 +--
 ...009-fix-build-with-new-version-attr.patch} | 22 +++---
 ...initializer-element-is-not-constant.patch} | 10 ++-
 ...ost-since-we-are-doing-cross-compil.patch} | 13 ++--
 ...=> 0012-Don-t-expose-configure-args.patch} |  4 +-
 recipes-ids/samhain/files/run-ptest           |  0
 recipes-ids/samhain/samhain-standalone.bb     |  7 +-
 recipes-ids/samhain/samhain.inc               | 24 +++----
 15 files changed, 168 insertions(+), 118 deletions(-)
 rename recipes-ids/samhain/files/{samhain-mips64-aarch64-dnmalloc-hash-fix.patch => 0001-Hash-fix-for-MIPS64-and-AARCH64.patch} (70%)
 rename recipes-ids/samhain/files/{samhain-samhainrc.patch => 0002-Make-samhainrc-OE-friendly.patch} (87%)
 rename recipes-ids/samhain/files/{samhain-samhainrc-fix-files-dirs-path.patch => 0003-fix-real-path-for-some-files-dirs.patch} (85%)
 rename recipes-ids/samhain/files/{samhain-pid-path.patch => 0004-Set-the-PID-Lock-path-for-samhain.pid.patch} (54%)
 rename recipes-ids/samhain/files/{samhain-sha256-big-endian.patch => 0005-Fix-sha256-for-big-endian-machines.patch} (50%)
 rename recipes-ids/samhain/files/{samhain-configure-add-option-for-ps.patch => 0006-configure-add-option-for-ps.patch} (67%)
 rename recipes-ids/samhain/files/{samhain-avoid-searching-host-for-postgresql.patch => 0007-configure.ac-avoid-searching-host-for-postgresql.patch} (87%)
 rename recipes-ids/samhain/files/{samhain-add-LDFLAGS-variable-for-samhain_setpwd.patch => 0008-Add-LDFLAGS-variable-for-compiling-samhain_setpwd.patch} (83%)
 rename recipes-ids/samhain/files/{fix-build-with-new-version-attr.patch => 0009-fix-build-with-new-version-attr.patch} (78%)
 rename recipes-ids/samhain/files/{samhain-fix-initializer-element-is-not-constant.patch => 0010-Fix-initializer-element-is-not-constant.patch} (76%)
 rename recipes-ids/samhain/files/{samhain-not-run-ptest-on-host.patch => 0011-not-run-test-on-host-since-we-are-doing-cross-compil.patch} (57%)
 rename recipes-ids/samhain/files/{0001-Don-t-expose-configure-args.patch => 0012-Don-t-expose-configure-args.patch} (94%)
 mode change 100755 => 100644 recipes-ids/samhain/files/run-ptest

diff --git a/recipes-ids/samhain/files/samhain-mips64-aarch64-dnmalloc-hash-fix.patch b/recipes-ids/samhain/files/0001-Hash-fix-for-MIPS64-and-AARCH64.patch
similarity index 70%
rename from recipes-ids/samhain/files/samhain-mips64-aarch64-dnmalloc-hash-fix.patch
rename to recipes-ids/samhain/files/0001-Hash-fix-for-MIPS64-and-AARCH64.patch
index 0608660..a34c553 100644
--- a/recipes-ids/samhain/files/samhain-mips64-aarch64-dnmalloc-hash-fix.patch
+++ b/recipes-ids/samhain/files/0001-Hash-fix-for-MIPS64-and-AARCH64.patch
@@ -1,28 +1,30 @@
-commit 0f6bdc219e598de08a3f37887efa5dfa50e2b996
-Author: Aws Ismail <aws.ismail@windriver.com>
-Date:   Fri Jun 22 15:47:08 2012 -0400
+From 3f6884e711cdbd66ceca8ed13158b11ca2d6ddc1 Mon Sep 17 00:00:00 2001
+From: Aws Ismail <aws.ismail@windriver.com>
+Date: Fri, 22 Jun 2012 15:47:08 -0400
+Subject: [PATCH] Hash fix for MIPS64 and AARCH64
 
-Hash fix for MIPS64 and AARCH64
-    
 Samhain uses the addresses of local variables in generating hash
 values.  The hashing function is designed only for 32-bit values.
 For MIPS64 when a 64-bit address is passed in the resulting hash
 exceeds the limits of the underlying mechanism and samhain
-ultimately fails.  The solution is to simply take the lower 
+ultimately fails.  The solution is to simply take the lower
 32-bits of the address and use that in generating hash values.
-    
+
 Signed-off-by: Greg Moffatt <greg.moffatt@windriver.com>
 
 Upstream-Status: Pending
-    
+
 Signed-off-by: Aws Ismail <aws.ismail@windriver.com>
 Signed-off-by: Jackie Huang <jackie.huang@windriver.com>
+---
+ src/dnmalloc.c | 8 ++++++++
+ 1 file changed, 8 insertions(+)
 
 diff --git a/src/dnmalloc.c b/src/dnmalloc.c
-index da9a5c5..fc91400 100644
+index 9f7bacc..d6e9ec5 100644
 --- a/src/dnmalloc.c
 +++ b/src/dnmalloc.c
-@@ -2703,11 +2703,19 @@ static void freecilst_add(chunkinfoptr p) {
+@@ -2710,11 +2710,19 @@ static void freecilst_add(chunkinfoptr p) {
  }
  
  /* Calculate the hash table entry for a chunk */
@@ -38,7 +40,10 @@ index da9a5c5..fc91400 100644
  #else
  #define hash(p)  (((unsigned long) p - (unsigned long) startheap) >> 7)
  #endif
-+#endif /* CONFIG_ARCH_MIPS64 */ 
++#endif /* CONFIG_ARCH_MIPS64 */
  
  static void
  hashtable_add (chunkinfoptr ci)
+-- 
+2.34.1
+
diff --git a/recipes-ids/samhain/files/samhain-samhainrc.patch b/recipes-ids/samhain/files/0002-Make-samhainrc-OE-friendly.patch
similarity index 87%
rename from recipes-ids/samhain/files/samhain-samhainrc.patch
rename to recipes-ids/samhain/files/0002-Make-samhainrc-OE-friendly.patch
index 145700a..5e0cf59 100644
--- a/recipes-ids/samhain/files/samhain-samhainrc.patch
+++ b/recipes-ids/samhain/files/0002-Make-samhainrc-OE-friendly.patch
@@ -1,20 +1,22 @@
-commit 4c6658441eb3ffc4e51ed70f78cbdab046957580
-Author: Aws Ismail <aws.ismail@windriver.com>
-Date:   Fri Jun 22 16:38:20 2012 -0400
+From 5797a57fd839d4b42c38fec49a6f937ca2e359af Mon Sep 17 00:00:00 2001
+From: Aws Ismail <aws.ismail@windriver.com>
+Date: Fri, 22 Jun 2012 16:38:20 -0400
+Subject: [PATCH] Make samhainrc OE-friendly.
 
-Make samhainrc OE-friendly.
-
-Patch the samhainrc that will be installed 
+Patch the samhainrc that will be installed
 as part of the 'make install' step to more
 accurately reflect what will be found, and
 what will be of concern, on a OE install.
-    
+
 Upstream-Status: Inappropriate [configuration]
 
 Signed-off-by: Aws Ismail <aws.ismail@windriver.com>
+---
+ samhainrc.linux | 63 +++++++++----------------------------------------
+ 1 file changed, 11 insertions(+), 52 deletions(-)
 
 diff --git a/samhainrc.linux b/samhainrc.linux
-index 9bc5ca4..10a8176 100644
+index 02906bb..5b6ec6a 100644
 --- a/samhainrc.linux
 +++ b/samhainrc.linux
 @@ -74,7 +74,6 @@ dir = 0/
@@ -128,7 +130,7 @@ index 9bc5ca4..10a8176 100644
  
  ## Remote server (yule)
  ##
-@@ -556,7 +513,8 @@ ChecksumTest=check
+@@ -539,7 +496,8 @@ ChecksumTest=check
  ## and I/O limit (kilobytes per second; 0 == off)
  ## to reduce load on host.
  #
@@ -138,7 +140,7 @@ index 9bc5ca4..10a8176 100644
  # SetIOLimit = 0
  
  ## The version string to embed in file signature databases
-@@ -565,13 +523,14 @@ ChecksumTest=check
+@@ -548,13 +506,14 @@ ChecksumTest=check
  
  ## Interval between time stamp messages
  #
@@ -156,3 +158,6 @@ index 9bc5ca4..10a8176 100644
  
  ## Alternative: crontab-like schedule
  #
+-- 
+2.34.1
+
diff --git a/recipes-ids/samhain/files/samhain-samhainrc-fix-files-dirs-path.patch b/recipes-ids/samhain/files/0003-fix-real-path-for-some-files-dirs.patch
similarity index 85%
rename from recipes-ids/samhain/files/samhain-samhainrc-fix-files-dirs-path.patch
rename to recipes-ids/samhain/files/0003-fix-real-path-for-some-files-dirs.patch
index dad6b15..222e1cf 100644
--- a/recipes-ids/samhain/files/samhain-samhainrc-fix-files-dirs-path.patch
+++ b/recipes-ids/samhain/files/0003-fix-real-path-for-some-files-dirs.patch
@@ -1,4 +1,4 @@
-From 00fb527e45da42550156197647e01de9a6b1ad52 Mon Sep 17 00:00:00 2001
+From 041af4897336b0873cbac8d15b434638bf3aaf7e Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Mon, 3 Mar 2014 01:50:01 -0500
 Subject: [PATCH] fix real path for some files/dirs
@@ -7,11 +7,11 @@ Upstream-Status: Inappropriate [configuration]
 
 Signed-off-by: Wenzong Fan <wenzong.fan@windriver.com>
 ---
- samhainrc.linux |   15 +++++++--------
- 1 file changed, 7 insertions(+), 8 deletions(-)
+ samhainrc.linux | 13 ++++++-------
+ 1 file changed, 6 insertions(+), 7 deletions(-)
 
 diff --git a/samhainrc.linux b/samhainrc.linux
-index e9727b4..7775d83 100644
+index 5b6ec6a..ff6ddf1 100644
 --- a/samhainrc.linux
 +++ b/samhainrc.linux
 @@ -93,7 +93,6 @@ dir = 99/etc
@@ -57,5 +57,5 @@ index e9727b4..7775d83 100644
  [Attributes]
  #
 -- 
-1.7.9.5
+2.34.1
 
diff --git a/recipes-ids/samhain/files/samhain-pid-path.patch b/recipes-ids/samhain/files/0004-Set-the-PID-Lock-path-for-samhain.pid.patch
similarity index 54%
rename from recipes-ids/samhain/files/samhain-pid-path.patch
rename to recipes-ids/samhain/files/0004-Set-the-PID-Lock-path-for-samhain.pid.patch
index 8fdadd1..0ae4b62 100644
--- a/recipes-ids/samhain/files/samhain-pid-path.patch
+++ b/recipes-ids/samhain/files/0004-Set-the-PID-Lock-path-for-samhain.pid.patch
@@ -1,22 +1,24 @@
-commit a932b03b65edeb02ccad2fce06bfa68a8f2fbb04
-Author: Aws Ismail <aws.ismail@windriver.com>
-Date:   Thu Jan 10 16:29:05 2013 -0500
+From 942843096e86669492700f49abc2c6489ea9994e Mon Sep 17 00:00:00 2001
+From: Aws Ismail <aws.ismail@windriver.com>
+Date: Thu, 10 Jan 2013 16:29:05 -0500
+Subject: [PATCH] Set the PID Lock path for samhain.pid
 
-Set the PID Lock path for samhain.pid
-    
 The explicit path for samhain.pid inorder
 for samhain to work properly after it initial
 database build.
-    
+
 Upstream-Status: Inappropriate [configuration]
 
 Signed-off-by: Aws Ismail <aws.ismail@windriver.com>
+---
+ samhainrc.linux | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
 
 diff --git a/samhainrc.linux b/samhainrc.linux
-index 10a8176..a7b06e6 100644
+index ff6ddf1..d4b71e9 100644
 --- a/samhainrc.linux
 +++ b/samhainrc.linux
-@@ -639,7 +639,7 @@ SetFileCheckTime = 86400
+@@ -621,7 +621,7 @@ SetFileCheckTime = 86400
  
  ## Path to the PID file
  #
@@ -25,3 +27,6 @@ index 10a8176..a7b06e6 100644
  
  
  ## The digest/checksum/hash algorithm
+-- 
+2.34.1
+
diff --git a/recipes-ids/samhain/files/samhain-sha256-big-endian.patch b/recipes-ids/samhain/files/0005-Fix-sha256-for-big-endian-machines.patch
similarity index 50%
rename from recipes-ids/samhain/files/samhain-sha256-big-endian.patch
rename to recipes-ids/samhain/files/0005-Fix-sha256-for-big-endian-machines.patch
index 3065c73..9467a60 100644
--- a/recipes-ids/samhain/files/samhain-sha256-big-endian.patch
+++ b/recipes-ids/samhain/files/0005-Fix-sha256-for-big-endian-machines.patch
@@ -1,4 +1,7 @@
-samhain: fix sha256 for big-endian machines
+From 54242aa53da0d69c04b76c22120956ac6079ef6f Mon Sep 17 00:00:00 2001
+From: Joe Slater <jslater@windriver.com>
+Date: Thu, 27 Mar 2025 11:12:33 +0800
+Subject: [PATCH] Fix sha256 for big-endian machines
 
 After computing the digest, big-endian machines would
 memset() the digest to the first byte of state instead
@@ -7,11 +10,15 @@ of using memcpy() to transfer it.
 Upstream-Status: Pending
 
 Signed-off-by: Joe Slater <jslater@windriver.com>
+---
+ src/sh_checksum.c | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
 
-
+diff --git a/src/sh_checksum.c b/src/sh_checksum.c
+index e434d5c..dc23738 100644
 --- a/src/sh_checksum.c
 +++ b/src/sh_checksum.c
-@@ -468,7 +468,7 @@ void SHA256_Final(sha2_byte digest[], SH
+@@ -468,7 +468,7 @@ void SHA256_Final(sha2_byte digest[SHA256_DIGEST_LENGTH], SHA256_CTX* context)
        }
      }
  #else
@@ -20,3 +27,6 @@ Signed-off-by: Joe Slater <jslater@windriver.com>
      /* bcopy(context->state, d, SHA256_DIGEST_LENGTH); */
  #endif
    }
+-- 
+2.34.1
+
diff --git a/recipes-ids/samhain/files/samhain-configure-add-option-for-ps.patch b/recipes-ids/samhain/files/0006-configure-add-option-for-ps.patch
similarity index 67%
rename from recipes-ids/samhain/files/samhain-configure-add-option-for-ps.patch
rename to recipes-ids/samhain/files/0006-configure-add-option-for-ps.patch
index 7e7f86e..e6a011b 100644
--- a/recipes-ids/samhain/files/samhain-configure-add-option-for-ps.patch
+++ b/recipes-ids/samhain/files/0006-configure-add-option-for-ps.patch
@@ -1,4 +1,4 @@
-From 02a143f0068cbc6cea71359169210fbb3606d4bb Mon Sep 17 00:00:00 2001
+From 2a33032ee97be5015101d94b333244e6fc53840c Mon Sep 17 00:00:00 2001
 From: Jackie Huang <jackie.huang@windriver.com>
 Date: Mon, 18 Jan 2016 00:24:57 -0500
 Subject: [PATCH] configure: add option for ps
@@ -16,12 +16,31 @@ Upstream-Status: Inappropriate [cross compile specific]
 Signed-off-by: Jackie Huang <jackie.huang@windriver.com>
 [AK: refactored for 4.4.3]
 Signed-off-by: Armin Kuster <akuster808@gmail.com>
+Refresh to 4.5.2
+Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
+---
+ acinclude.m4 |  2 +-
+ configure.ac | 60 +++++++++-------------------------------------------
+ 2 files changed, 11 insertions(+), 51 deletions(-)
 
-Index: samhain-4.4.2/configure.ac
-===================================================================
---- samhain-4.4.2.orig/configure.ac
-+++ samhain-4.4.2/configure.ac
-@@ -743,56 +743,16 @@ then
+diff --git a/acinclude.m4 b/acinclude.m4
+index def24be..e2a57e2 100644
+--- a/acinclude.m4
++++ b/acinclude.m4
+@@ -359,7 +359,7 @@ x_includes=NONE
+ x_libraries=NONE
+ DESTDIR=
+ SH_ENABLE_OPTS="selinux posix-acl asm ssp db-reload xml-log message-queue login-watch process-check port-check mounts-check logfile-monitor userfiles debug ptrace static network udp nocl stealth micro-stealth install-name identity khide suidcheck base largefile mail external-scripts encrypt srp dnmalloc ipv6 shellexpand suid"
+-SH_WITH_OPTS="prelude libprelude-prefix database libwrap cflags libs console altconsole timeserver alttimeserver rnd egd-socket port logserver altlogserver signify pubkey-checksum gpg keyid checksum fp recipient sender trusted tmp-dir config-file log-file pid-file state-dir data-file html-file"
++SH_WITH_OPTS="prelude libprelude-prefix database libwrap cflags libs console altconsole timeserver alttimeserver rnd egd-socket port logserver altlogserver signify pubkey-checksum gpg keyid checksum fp recipient sender trusted tmp-dir config-file log-file pid-file state-dir data-file html-file ps-path"
+ 
+ # Installation directory options.
+ # These are left unexpanded so users can "make install exec_prefix=/foo"
+diff --git a/configure.ac b/configure.ac
+index f59754c..d0e3657 100644
+--- a/configure.ac
++++ b/configure.ac
+@@ -799,56 +799,16 @@ then
  fi
  AC_CHECK_HEADERS(gmp.h)
  
@@ -39,17 +58,8 @@ Index: samhain-4.4.2/configure.ac
 -	AC_MSG_RESULT([no])
 -	AC_MSG_ERROR([Cannot find ps in any of /usr/ucb /bin /usr/bin])
 -fi
--AC_DEFINE_UNQUOTED([PSPATH], _("$PS"), [Path to ps])
-+AC_ARG_WITH(ps-path,
-+   [  --with-ps-path=PATH         set path to ps command ],
-+   [
-+   if test "x${withval}" != xno; then
-+       pspath="${withval}"
-+       AC_DEFINE_UNQUOTED([PSPATH], _("${pspath}"), [Path to ps])
-+       AC_DEFINE_UNQUOTED([PSARG], _("ax"), [Argument for ps])
-+   fi
-+   ])
- 
+-AC_DEFINE_UNQUOTED([PSPATH], [_("$PS")], [Path to ps executable])
+-
 -AC_MSG_CHECKING([how to use ps])
 -$PS ax >/dev/null 2>&1
 -if test $? -eq 0; then
@@ -83,20 +93,20 @@ Index: samhain-4.4.2/configure.ac
 -else
 -	PSARG="-e"
 -fi
--AC_DEFINE_UNQUOTED([PSARG], _("$PSARG"), [Argument for ps])
+-AC_DEFINE_UNQUOTED([PSARG], [_("$PSARG")], [Argument for ps])
++AC_ARG_WITH(ps-path,
++	[  --with-ps-path=PATH         set path to ps command ],
++	[
++	if test "x${withval}" != xno; then
++		pspath="${withval}"
++		AC_DEFINE_UNQUOTED([PSPATH], _("${pspath}"), [Path to ps])
++		AC_DEFINE_UNQUOTED([PSARG], _("ax"), [Argument for ps])
++	fi
++	])
++
  AC_MSG_RESULT([$PS $PSARG])
  
  dnl *****************************************
-Index: samhain-4.4.2/aclocal.m4
-===================================================================
---- samhain-4.4.2.orig/aclocal.m4
-+++ samhain-4.4.2/aclocal.m4
-@@ -409,7 +409,7 @@ x_includes=NONE
- x_libraries=NONE
- DESTDIR=
- SH_ENABLE_OPTS="selinux posix-acl asm ssp db-reload xml-log message-queue login-watch process-check port-check mounts-check logfile-monitor userfiles debug ptrace static network udp nocl stealth micro-stealth install-name identity khide suidcheck base largefile mail external-scripts encrypt srp dnmalloc ipv6 shellexpand suid"
--SH_WITH_OPTS="prelude libprelude-prefix database libwrap cflags libs console altconsole timeserver alttimeserver rnd egd-socket port logserver altlogserver signify pubkey-checksum gpg keyid checksum fp recipient sender trusted tmp-dir config-file log-file pid-file state-dir data-file html-file"
-+SH_WITH_OPTS="prelude libprelude-prefix database libwrap cflags libs console altconsole timeserver alttimeserver rnd egd-socket port logserver altlogserver kcheck gpg keyid checksum fp recipient sender trusted tmp-dir config-file log-file pid-file state-dir data-file html-file ps-path"
- 
- # Installation directory options.
- # These are left unexpanded so users can "make install exec_prefix=/foo"
+-- 
+2.34.1
+
diff --git a/recipes-ids/samhain/files/samhain-avoid-searching-host-for-postgresql.patch b/recipes-ids/samhain/files/0007-configure.ac-avoid-searching-host-for-postgresql.patch
similarity index 87%
rename from recipes-ids/samhain/files/samhain-avoid-searching-host-for-postgresql.patch
rename to recipes-ids/samhain/files/0007-configure.ac-avoid-searching-host-for-postgresql.patch
index a84229e..9652c53 100644
--- a/recipes-ids/samhain/files/samhain-avoid-searching-host-for-postgresql.patch
+++ b/recipes-ids/samhain/files/0007-configure.ac-avoid-searching-host-for-postgresql.patch
@@ -1,4 +1,4 @@
-From 3e2ca7e06b16ceff6d12beb5113312f6525df595 Mon Sep 17 00:00:00 2001
+From 117078cd32ee2c76bbe7d65325fbc0b451c73ace Mon Sep 17 00:00:00 2001
 From: Jackie Huang <jackie.huang@windriver.com>
 Date: Thu, 14 Sep 2017 11:02:12 +0800
 Subject: [PATCH] configure.ac: avoid searching host for postgresql
@@ -7,16 +7,16 @@ Upstream-Status: Inappropriate [cross compile specific]
 
 Signed-off-by: Jackie Huang <jackie.huang@windriver.com>
 ---
- configure.ac | 101 +++--------------------------------------------------------
+ configure.ac | 101 +++------------------------------------------------
  1 file changed, 5 insertions(+), 96 deletions(-)
 
-Index: samhain-4.4.2/configure.ac
-===================================================================
---- samhain-4.4.2.orig/configure.ac
-+++ samhain-4.4.2/configure.ac
-@@ -1290,90 +1290,11 @@ AC_ARG_WITH(database,
-           AC_DEFINE(WITH_POSTGRES)
-           AC_DEFINE(WITH_DATABASE)
+diff --git a/configure.ac b/configure.ac
+index d0e3657..5b8d167 100644
+--- a/configure.ac
++++ b/configure.ac
+@@ -1351,90 +1351,11 @@ AC_ARG_WITH(database,
+           AC_DEFINE([WITH_POSTGRES], [1], [Use postgres as database])
+           AC_DEFINE([WITH_DATABASE], [1], [Use a database])
  	  #
 -	  PGCONF="no"
 -	  MY_PATH="${PATH}:/usr/local/bin:/usr/local/pgsql/bin"
@@ -103,14 +103,14 @@ Index: samhain-4.4.2/configure.ac
 -            AC_MSG_RESULT(yes)
 -
 +	  if test -z "${PGSQL_LIB_DIR}" ; then
-+            FAIL_MESSAGE("PGSQL_LIB_DIR is not set!")
++	    FAIL_MESSAGE("PGSQL_LIB_DIR is not set!")
 +	  elif test -z "${PGSQL_INC_DIR}" ; then
-+            FAIL_MESSAGE("PGSQL_INC_DIR is not set!")
++	    FAIL_MESSAGE("PGSQL_INC_DIR is not set!")
 +	  else
  	    LIBS="$LIBS -L${PGSQL_LIB_DIR} -lpq -lm"
  	    if test x"$enable_static" = xyes; then
  	      LIBS="$LIBS -L${PGSQL_LIB_DIR} -lpq -lcrypt -lm"
-@@ -1382,18 +1303,6 @@ AC_ARG_WITH(database,
+@@ -1443,18 +1364,6 @@ AC_ARG_WITH(database,
  	    fi
  	    # CFLAGS="$CFLAGS -I${PGSQL_INC_DIR}"
  	    CPPFLAGS="$CPPFLAGS -I${PGSQL_INC_DIR}"
@@ -129,3 +129,6 @@ Index: samhain-4.4.2/configure.ac
  	  fi
  	elif test "x${withval}" = "xodbc"; then
  	  AC_MSG_CHECKING(for odbc in /usr /usr/local ODBC_HOME)
+-- 
+2.34.1
+
diff --git a/recipes-ids/samhain/files/samhain-add-LDFLAGS-variable-for-samhain_setpwd.patch b/recipes-ids/samhain/files/0008-Add-LDFLAGS-variable-for-compiling-samhain_setpwd.patch
similarity index 83%
rename from recipes-ids/samhain/files/samhain-add-LDFLAGS-variable-for-samhain_setpwd.patch
rename to recipes-ids/samhain/files/0008-Add-LDFLAGS-variable-for-compiling-samhain_setpwd.patch
index 088a938..f2691e7 100644
--- a/recipes-ids/samhain/files/samhain-add-LDFLAGS-variable-for-samhain_setpwd.patch
+++ b/recipes-ids/samhain/files/0008-Add-LDFLAGS-variable-for-compiling-samhain_setpwd.patch
@@ -1,4 +1,4 @@
-From ae79606a6745dbbd429d1d4671dfe3045d735057 Mon Sep 17 00:00:00 2001
+From 7fc1f0a8d4c6a109f7e86853a9136a008c68808a Mon Sep 17 00:00:00 2001
 From: Jackie Huang <jackie.huang@windriver.com>
 Date: Thu, 14 Sep 2017 13:26:55 +0800
 Subject: [PATCH] Add LDFLAGS variable for compiling samhain_setpwd
@@ -11,10 +11,10 @@ Signed-off-by: Jackie Huang <jackie.huang@windriver.com>
  1 file changed, 1 insertion(+), 1 deletion(-)
 
 diff --git a/Makefile.in b/Makefile.in
-index 01de987..49356cf 100644
+index ade0638..1806159 100644
 --- a/Makefile.in
 +++ b/Makefile.in
-@@ -1128,7 +1128,7 @@ sh_tiger_i.o: $(srcsrc)/$(TIGER_SRC) Makefile config_xor.h
+@@ -1159,7 +1159,7 @@ sh_tiger_i.o: $(srcsrc)/$(TIGER_SRC) Makefile config_xor.h
  samhain_setpwd: encode config_xor.h $(srcsrc)/samhain_setpwd.c
  	@echo '$(COMPILE)  -o samhain_setpwd $(srcsrc)/samhain_setpwd.c'; \
  	./encode $(XOR_CODE) $(srcsrc)/samhain_setpwd.c; \
@@ -24,5 +24,5 @@ index 01de987..49356cf 100644
  
  samhain_stealth: encode config_xor.h $(srcsrc)/samhain_stealth.c
 -- 
-2.11.0
+2.34.1
 
diff --git a/recipes-ids/samhain/files/fix-build-with-new-version-attr.patch b/recipes-ids/samhain/files/0009-fix-build-with-new-version-attr.patch
similarity index 78%
rename from recipes-ids/samhain/files/fix-build-with-new-version-attr.patch
rename to recipes-ids/samhain/files/0009-fix-build-with-new-version-attr.patch
index eaf30db..b58eda9 100644
--- a/recipes-ids/samhain/files/fix-build-with-new-version-attr.patch
+++ b/recipes-ids/samhain/files/0009-fix-build-with-new-version-attr.patch
@@ -1,4 +1,4 @@
-From e67acafa62f71f0015ed548918b98ed0b1ded128 Mon Sep 17 00:00:00 2001
+From 9d693fbeb0a14bfe858aed2b46cb9e74a90d00b9 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Sun, 19 Jan 2020 15:53:48 +0800
 Subject: [PATCH] fix build with new version attr
@@ -12,15 +12,15 @@ Upstream-Status: Pending
 
 Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
 ---
- aclocal.m4    | 26 +++++++++++---------------
+ acinclude.m4  | 26 +++++++++++---------------
  src/sh_unix.c |  2 +-
  2 files changed, 12 insertions(+), 16 deletions(-)
 
-diff --git a/aclocal.m4 b/aclocal.m4
-index ee5b204..38cef8e 100644
---- a/aclocal.m4
-+++ b/aclocal.m4
-@@ -1453,23 +1453,19 @@ AC_DEFUN([sh_CHECK_POSIX_ACL],
+diff --git a/acinclude.m4 b/acinclude.m4
+index e2a57e2..bfdd2f6 100644
+--- a/acinclude.m4
++++ b/acinclude.m4
+@@ -1392,23 +1392,19 @@ AC_DEFUN([sh_CHECK_POSIX_ACL],
  
  AC_DEFUN([sh_CHECK_XATTR],
  [
@@ -53,13 +53,13 @@ index ee5b204..38cef8e 100644
 +  LIBS="$OLDLIBS"
 +
    if test x"$sh_fattr" = xyes; then
- 	  AC_DEFINE(USE_XATTR, 1, [Define if you want extended attributes support.])
+ 	  AC_DEFINE([USE_XATTR], [1], [Define if you want extended attributes support.])
  	  LIBS="$LIBS $LIBATTR"
 diff --git a/src/sh_unix.c b/src/sh_unix.c
-index 3ede57f..ef236e9 100644
+index b1c0b75..2469068 100644
 --- a/src/sh_unix.c
 +++ b/src/sh_unix.c
-@@ -3681,7 +3681,7 @@ static char * sh_unix_getinfo_acl (char * path, int fd, struct stat * buf)
+@@ -3682,7 +3682,7 @@ static char * sh_unix_getinfo_acl (char * path, int fd, struct stat * buf)
  
  #ifdef USE_XATTR
  
@@ -69,5 +69,5 @@ index 3ede57f..ef236e9 100644
  {
    char *  out   = NULL;
 -- 
-2.7.4
+2.34.1
 
diff --git a/recipes-ids/samhain/files/samhain-fix-initializer-element-is-not-constant.patch b/recipes-ids/samhain/files/0010-Fix-initializer-element-is-not-constant.patch
similarity index 76%
rename from recipes-ids/samhain/files/samhain-fix-initializer-element-is-not-constant.patch
rename to recipes-ids/samhain/files/0010-Fix-initializer-element-is-not-constant.patch
index 72cb880..8479165 100644
--- a/recipes-ids/samhain/files/samhain-fix-initializer-element-is-not-constant.patch
+++ b/recipes-ids/samhain/files/0010-Fix-initializer-element-is-not-constant.patch
@@ -1,3 +1,8 @@
+From 77d55c4707395b76e32e07bf0f679b5b6999d568 Mon Sep 17 00:00:00 2001
+From: Kai Kang <kai.kang@windriver.com>
+Date: Thu, 27 Mar 2025 11:43:40 +0800
+Subject: [PATCH] Fix initializer element is not constant
+
 Fix error when compile for powerpc:
 
 | x_sh_dbIO.c: In function 'swap_short':
@@ -13,7 +18,7 @@ Signed-off-by: Kai Kang <kai.kang@windriver.com>
  1 file changed, 2 insertions(+), 1 deletion(-)
 
 diff --git a/src/sh_dbIO.c b/src/sh_dbIO.c
-index b547ac5..23a9621 100644
+index 1f9b152..503456d 100644
 --- a/src/sh_dbIO.c
 +++ b/src/sh_dbIO.c
 @@ -226,7 +226,8 @@ static unsigned short *  swap_short (unsigned short * iptr)
@@ -26,3 +31,6 @@ index b547ac5..23a9621 100644
        unsigned short hi   = (ooop & 0xff00);
        unsigned short lo   = (ooop & 0xff);
        ooop = (lo << 8) | (hi >> 8);
+-- 
+2.34.1
+
diff --git a/recipes-ids/samhain/files/samhain-not-run-ptest-on-host.patch b/recipes-ids/samhain/files/0011-not-run-test-on-host-since-we-are-doing-cross-compil.patch
similarity index 57%
rename from recipes-ids/samhain/files/samhain-not-run-ptest-on-host.patch
rename to recipes-ids/samhain/files/0011-not-run-test-on-host-since-we-are-doing-cross-compil.patch
index e00fc2a..dc9f42e 100644
--- a/recipes-ids/samhain/files/samhain-not-run-ptest-on-host.patch
+++ b/recipes-ids/samhain/files/0011-not-run-test-on-host-since-we-are-doing-cross-compil.patch
@@ -1,17 +1,20 @@
-not run test on host, since we are doing cross-compile
+From 506833786a4ae5b888f12c59b82f7d842cda778c Mon Sep 17 00:00:00 2001
+From: Roy Li <rongqing.li@windriver.com>
+Date: Thu, 27 Mar 2025 11:46:20 +0800
+Subject: [PATCH] not run test on host, since we are doing cross-compile
 
 Upstream-Status: Inappropriate [cross compile specific]
 
 Signed-off-by: Roy Li <rongqing.li@windriver.com>
 ---
- Makefile.in |    1 -
+ Makefile.in | 1 -
  1 file changed, 1 deletion(-)
 
 diff --git a/Makefile.in b/Makefile.in
-index e1b32a8..74bfdc9 100644
+index 1806159..eccb4f6 100644
 --- a/Makefile.in
 +++ b/Makefile.in
-@@ -1234,7 +1234,6 @@ intcutest: internal.h $(OBJECTS) $(CUTEST_OBJECTS) sh_tiger_i.o $(srcsrc)/CuTest
+@@ -1219,7 +1219,6 @@ intcutest: internal.h $(OBJECTS) $(CUTEST_OBJECTS) sh_tiger_i.o $(srcsrc)/CuTest
  	rm x_samhain.c; \
  	$(LINK) sh_tiger_i.o $(CUTEST_OBJECTS) CuTestMain.o CuTest.o $(OBJECTS) $(LIBS_TRY); \
  	test -f ./intcutest && mv ./intcutest ./cutest; \
@@ -20,5 +23,5 @@ index e1b32a8..74bfdc9 100644
  runcutest:
  	gdb ./cutest
 -- 
-1.7.10.4
+2.34.1
 
diff --git a/recipes-ids/samhain/files/0001-Don-t-expose-configure-args.patch b/recipes-ids/samhain/files/0012-Don-t-expose-configure-args.patch
similarity index 94%
rename from recipes-ids/samhain/files/0001-Don-t-expose-configure-args.patch
rename to recipes-ids/samhain/files/0012-Don-t-expose-configure-args.patch
index fedbe5b..f881b5d 100644
--- a/recipes-ids/samhain/files/0001-Don-t-expose-configure-args.patch
+++ b/recipes-ids/samhain/files/0012-Don-t-expose-configure-args.patch
@@ -1,4 +1,4 @@
-From 111b1e8f35e989513d8961a45a806767109f6e1e Mon Sep 17 00:00:00 2001
+From 4625ce72e462950cfbbd37ad2a19be625fd081b0 Mon Sep 17 00:00:00 2001
 From: Mingli Yu <mingli.yu@windriver.com>
 Date: Thu, 11 Aug 2022 17:15:30 +0800
 Subject: [PATCH] Don't expose configure args
@@ -40,5 +40,5 @@ index 635a746..b9a42e7 100644
  
  	echo '#!/bin/sh' > ./sstrip
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-ids/samhain/files/run-ptest b/recipes-ids/samhain/files/run-ptest
old mode 100755
new mode 100644
diff --git a/recipes-ids/samhain/samhain-standalone.bb b/recipes-ids/samhain/samhain-standalone.bb
index ae9ed2b..87df017 100644
--- a/recipes-ids/samhain/samhain-standalone.bb
+++ b/recipes-ids/samhain/samhain-standalone.bb
@@ -1,7 +1,7 @@
 require samhain.inc
 
-SRC_URI += "file://samhain-not-run-ptest-on-host.patch \
-            file://0001-Don-t-expose-configure-args.patch \
+SRC_URI += "file://0011-not-run-test-on-host-since-we-are-doing-cross-compil.patch \
+            file://0012-Don-t-expose-configure-args.patch \
             file://run-ptest \
 "
 
@@ -28,7 +28,8 @@ do_install:append() {
 
 do_install_ptest() {
 	mkdir -p ${D}${PTEST_PATH}
-	install ${S}/cutest ${D}${PTEST_PATH}
+	install -m 755 ${S}/cutest ${D}${PTEST_PATH}
+	install -m 644 ${S}/COPYING ${D}${PTEST_PATH}
 }
 
 RPROVIDES:${PN} += "samhain"
diff --git a/recipes-ids/samhain/samhain.inc b/recipes-ids/samhain/samhain.inc
index 65e6734..6b8d30e 100644
--- a/recipes-ids/samhain/samhain.inc
+++ b/recipes-ids/samhain/samhain.inc
@@ -3,25 +3,25 @@ HOMEPAGE    = "http://www.la-samhna.de/samhain/"
 LICENSE     = "GPL-2.0-only"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=8ca43cbc842c2336e835926c2166c28b"
 
-PV = "4.4.10"
+PV = "4.5.2"
 
 SRC_URI = "https://la-samhna.de/archive/samhain_signed-${PV}.tar.gz \
            file://${INITSCRIPT_NAME}.init \
            file://${INITSCRIPT_NAME}.default \
            file://samhain.service \
-           file://samhain-mips64-aarch64-dnmalloc-hash-fix.patch \
-           file://samhain-samhainrc.patch \
-           file://samhain-samhainrc-fix-files-dirs-path.patch \
-           file://samhain-pid-path.patch \
-           file://samhain-sha256-big-endian.patch \
-           file://samhain-configure-add-option-for-ps.patch \
-           file://samhain-avoid-searching-host-for-postgresql.patch \
-           file://samhain-add-LDFLAGS-variable-for-samhain_setpwd.patch \
-           file://fix-build-with-new-version-attr.patch \
-           file://samhain-fix-initializer-element-is-not-constant.patch \
+           file://0001-Hash-fix-for-MIPS64-and-AARCH64.patch \
+           file://0002-Make-samhainrc-OE-friendly.patch \
+           file://0003-fix-real-path-for-some-files-dirs.patch \
+           file://0004-Set-the-PID-Lock-path-for-samhain.pid.patch \
+           file://0005-Fix-sha256-for-big-endian-machines.patch \
+           file://0006-configure-add-option-for-ps.patch \
+           file://0007-configure.ac-avoid-searching-host-for-postgresql.patch \
+           file://0008-Add-LDFLAGS-variable-for-compiling-samhain_setpwd.patch \
+           file://0009-fix-build-with-new-version-attr.patch \
+           file://0010-Fix-initializer-element-is-not-constant.patch \
            "
 
-SRC_URI[sha256sum] = "ae6ee8eff3cb111b7fc14a57bcc258443dd0bcf1bfacfdf229935ed053c1ce3d"
+SRC_URI[sha256sum] = "0b5d3534fd60ecf45dfd79bd415e81f7a56eba7f1755771735e204f334033578"
 
 UPSTREAM_CHECK_URI = "https://www.la-samhna.de/samhain/archive.html"
 UPSTREAM_CHECK_REGEX = "samhain_signed-(?P<pver>(\d+(\.\d+)+))\.tar"
-- 
2.34.1


