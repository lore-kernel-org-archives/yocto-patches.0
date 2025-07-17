Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CE6C83F22
	for <webhook@archiver.kernel.org>; Thu, 17 Jul 2025 02:12:51 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.39533.1752718368300011709
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Jul 2025 19:12:48 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=92938ba514=yi.zhao@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56H0e6cQ3863086
	for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Jul 2025 19:12:48 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 47wds0tk5x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Jul 2025 19:12:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YR4GYQvBujMQeU/qRPZU+otEnco8EhGrJCpupaJp4vQBImmq/muLDcrpN/3IMwxQGcRoL+YMrO74boMA9jfajezsAb0BTO/7UtePmrxIEt79zgzXmB7Tp3+h1r+vdt70ZXYLmCNyf7/urgqgSbFV2PLbY0ywPBSQHz7/8sxzy38/n/n+gLv1NNN4b14gLkULmA9arObCVUDXDKZWXpBBvo4n3CCeu+rx1BqcRQSdMHtmWXiA/bwokBWJl0RAIxwFSBhNqSJUMGMG0R/dM7x/N+kqHKQwQjiR0KsDZX+YfXvyXPImfRjp8jMdLI2xl7qliQkPUAlj1AWpcpv814H7LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxZSms3OoD/vKHR6n55P2emoPLXEoX5GY7BX5eWa0Lo=;
 b=vK2/emW2Q8nUhHWbmAP5YXi1DYTKWhll6qjIg2Wn5TPGrAxj9ESQH/hgm/VHxVhHM/Tg32f7RrbrATqVt6m6cUO4C9S2S1tFiUSMRaurZZuGt7eM1xbaQ8fXz7/E0IBhQiuEMqCRx3A3KNBlHZfukSA+bUl98pIFQEcsAOXnDUHIKiCaHT1VUmky9b6a0lCiOgPXDA1SK/h2btCQJgCSJPtj47Bh4OAqr8QQ3MCXhV9nSzf3w2DoM+LnD3lPmUb2RzdeIpnoIqVq1rJGuvACWi8JfqZF/9jwwP3OVxgdL7NrBBY25uzF7hHEU39ZRRzcS6zirXkIq5W4uuVex0Xt7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 DS0PR11MB9502.namprd11.prod.outlook.com (2603:10b6:8:295::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.32; Thu, 17 Jul 2025 02:12:45 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.8901.033; Thu, 17 Jul 2025
 02:12:45 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH] scap-security-guide: disable ptest
Date: Thu, 17 Jul 2025 10:12:26 +0800
Message-Id: <20250717021226.2067766-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0061.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ba::19) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|DS0PR11MB9502:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b6eda28-f06b-4ca4-335c-08ddc4d76b2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?I8utYVR/YrDSWpfTxNLzs41wMsH96aBt4sy2tKmMC2cvMl7dL2W6tUvgIlwb?=
 =?us-ascii?Q?Zs3rokSxoTyDgdj6Sh+GctsrD+zfouJiiZ4q6zrBEivKQAklzk7TeKMGDXaY?=
 =?us-ascii?Q?oxj7B1LwUpNar9aGhKCviVL8Kw5XrwUV9IU2y8NT+Vth52PZkuX1iOK6WGL/?=
 =?us-ascii?Q?nLuYjMaK91pCIi3NHSZc26DAdIbLu/aAfDgx7/zan0+SC5sRasL1U6V0ivEw?=
 =?us-ascii?Q?/VxD0zfCAlaLncHP3tiOCw4kmVlAdT9oGIVJvYIiHXxFW2+8max60R9UAR76?=
 =?us-ascii?Q?9dXkeuDP3Vxk1CDHOpluEOzDHl8cc3AXAuElA0OjDYTLNXP8qt+lLJR43+4E?=
 =?us-ascii?Q?FSgbYKFRs9CVoNfxhpPEN3mQlYWGZPOgprdAu7ZWkR+NF/2fvo7fmLUPpjCO?=
 =?us-ascii?Q?qt6jxmA2f5S9KTm7hMibEEBp2Inoju4KGF5xaUSjot4NWRkKuVQWuWw7rOEJ?=
 =?us-ascii?Q?FA4lff50s85gu2zJkovSfOFCNy6bWUK6HZSD3pwnhK/go+56xBsBZ4Z084GB?=
 =?us-ascii?Q?HHEnJ+A0Qz2TZsp5FKB+mF3Tn/UONsW6lq8geg/2cMFSwJq15WhirlGpftiP?=
 =?us-ascii?Q?c88jz/r9ErdKXrc9X3uJgSlY0af62ZNR87PMNSSTHIEp8XzSYOYQDsoaexvX?=
 =?us-ascii?Q?knI8P7JUc+fX19ifGRl7sNFAItoOeL9yk+jmgEzHMy9jsqYDunnkMQS8Zh6u?=
 =?us-ascii?Q?i/rQsKe+Kca9bfSylBNflyh05E8Czepal2r4ULmIEHN3+YynJ5nq1SVgZX9z?=
 =?us-ascii?Q?PEjkzPLpjfxpSitozBt1PICgyzNnSk07/d3Vy2tuG9xBRhUfikX6a2w+8fWS?=
 =?us-ascii?Q?PN4JUFmYM7rVc4n35lqt2KRyFZcdx2V58T/7lBnfhsbV6W7B6w4Na/4kb3ld?=
 =?us-ascii?Q?+APi/LJ/RTXivVmbgsg3EPGUYMeU0SYX+n3vMCIonHHNCApciJjGUQ0VvrMU?=
 =?us-ascii?Q?Ld4g6uQwGvJbw5+EZu33/SrLyUBt7+SGMRoK+T61/IhA9IrllIhE2ERLU92k?=
 =?us-ascii?Q?borBy60j8wNvqC7J5mKB/NJk3Mpnb8Vmo534Wmy6cQ+YJQXMWE56CxzXNIEE?=
 =?us-ascii?Q?0lmr5pgcGLTER9h74DsvQsy0ZJMbKp+35Zn6XP8hha8Um9SIKmcQtkgLvM1f?=
 =?us-ascii?Q?UeGQPlMK/oy1+hwpLvDk3fNMDRDskLHjEhOixTPBxdzYttpCmELCulscM9z2?=
 =?us-ascii?Q?dImeVgZzaXSPw5+xqACcFcmKd1BIh2YQarqwdfCKZLq9PkVsZ/yxMH1GnLLw?=
 =?us-ascii?Q?swWzqxASDBWJUqMx6MMXK9565KXA37mSnx7sLMjgdTc8+g+CEBGcJu3et+d0?=
 =?us-ascii?Q?dYZJWvfKYTFnlIV1cxNgdEqOGu3VimNzebcA5P7VHtHlQxXxz/vxmEFYN8vl?=
 =?us-ascii?Q?e0WHN4u170gQkPT2FTfIqgaf/8hPpvyP+cSx0iKfTLfs4A9qJ6Or21IOCRs+?=
 =?us-ascii?Q?KfQzyV7G26gA3T8Z1oyv4QI7dB4h0hxPCd512qKVJ4BrDWNKMQYMkw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MNIzKx69YWexWSRL+L+C6vTzM8BJs7LEtc5nWRr5UuxFYIoY9C2a892hDdK7?=
 =?us-ascii?Q?MYxSlTVaAJbtKFg0gRZdh8svSI/ZZ9khx+9tFYDnIXC9pgtAoZllYUko3fae?=
 =?us-ascii?Q?oL9kWprz83BZ5iEqqRVKKgR6VDYIobtmBD9Rp0JMk74CRjLi7euWcWxlgp0h?=
 =?us-ascii?Q?aI620C26NnLYEhLGZ0XNNsDAC7GTWt1x51SvmyRxf1rHtIYP01wv2TFWpG1n?=
 =?us-ascii?Q?utgREuDvzDf3ojaw87WNVM2NeDYU/PhA9LbkzOydXY1eiz7YFhIrN1k1S5Fx?=
 =?us-ascii?Q?WjqJotoE0SuvkoyEyg+0QwKsYJsNnrDF0U8nsgc0BSzUCEF1IKZEH80LZtzh?=
 =?us-ascii?Q?eLs3hP14CNZL6p6CDqWxoZOg2urKhk0moM49Tf19vGusSD8aPH2JwW6PsqXR?=
 =?us-ascii?Q?hHvRTkZOtKTb0vSA8PjlGvugeUC2umiTY6BbuLT0vsMlCp3eX5xcZBIoYXZA?=
 =?us-ascii?Q?Dlmu+fhHo+anCR2pBko2S9x/9kbRZRtL6C/S9GImmb55pAZ4t4NsfeuF3L4H?=
 =?us-ascii?Q?Ttdmayf8TrNQuvyLs43rQeEaxIutSBXbQy/7HfvutUrkS7XyokswGUKqO0D/?=
 =?us-ascii?Q?+eItrL760m08f/q/Evsr0lR1zV8guBT2NqxA861ghHTr8XHGehu9r7o23FKU?=
 =?us-ascii?Q?YQyqAoXcTqlGJs/B0yU0h8IczzQ+JlBf/FCbczxvRExGuV8aGJZV+misd2dY?=
 =?us-ascii?Q?xHQvDOdJwpNIXXMugahrIGnrkShpD/AjoTTBfnNU1MnibkGwCEbLC2cKSD+2?=
 =?us-ascii?Q?cw8W9YvZ6O4fNKzIFHfW5CZ+LUF6wb74PHqqk3exRHDIzLt3d15RvhQWxgxF?=
 =?us-ascii?Q?dzexXv5a/KDiYuazKOJ5Rw227zcybOseWW9+uBaQbVOMmpP1/4Gdd3x5UA/l?=
 =?us-ascii?Q?B08VLdaH/te/opbsQdb5+eDMAbKwcUOynrbu46EbZanHYttdwV0fkBr14EOK?=
 =?us-ascii?Q?JKSaHpK10hYpP+nF5Un3sVa5hSEZgqsWsXAqOow3AgClARRdMuRXBKxsGdGK?=
 =?us-ascii?Q?LlZSo3HSroeojjqLwbP5vYCtG4/18Df5N+I+3DinBRyAgMFeo6tEZQ7yDzsL?=
 =?us-ascii?Q?8nM/t6z6vVYmuD3jyFgiLhjHcsIuib8kvDGVOVN0vl9/o0R9H64FDWgG+hJj?=
 =?us-ascii?Q?0jK+qrNxbWZrsMqpzL5Z91cOvcdtQMkvafva3Z8jPEYiYEJpYOE7t1g7dyjH?=
 =?us-ascii?Q?AGE3Gl9k6kaHzvyXeMOmHIOVI+WmNzEw6Ii7iAS35YtvzLEyKxsOTcHZjjDk?=
 =?us-ascii?Q?xa66Ggo1RN5GYpYPQuGu5+WVRnoN2GTdA7AMve5CCwGP7xxsqLtHcy0yTU/g?=
 =?us-ascii?Q?zGa022sV9pGrhWNyXg6+vz45ioR3hTDOo0nZapukQV/aX665VmWC/ZMdWQ8A?=
 =?us-ascii?Q?V7yHjKs47+fHXRQjWMS4e1/h8QYXifxfxT+HcjhH07OkP03iYjoY7pH5bR2u?=
 =?us-ascii?Q?9bOAfPL3BCg3mRrgiUqIDIgmoT2BddSzpzj8YihFBm32VPgNTI1YKmGpBB3C?=
 =?us-ascii?Q?BteewdayTlsO68mCeI4SlZg0VpC+Tg9lxIYIVxArodQGyUsekMicbX+8wqiu?=
 =?us-ascii?Q?tUDCEc5AI+Hlk+meKiL4hMYXWLbgNqq9sLKl/atP?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6eda28-f06b-4ca4-335c-08ddc4d76b2e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 02:12:45.4176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lhd4qcbqOj1FfpzOy4+7Mx6Ro2mLUy5rJ3RTjDsOD1TnGZPqHSTpBIAck9RokNGqUSJ7ng+IWzN5UNb98aLYJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB9502
X-Proofpoint-ORIG-GUID: toP3RzIS3fGp2gvy4Bfagbw_beuva669
X-Authority-Analysis: v=2.4 cv=bLkWIO+Z c=1 sm=1 tr=0 ts=68785c1f cx=c_pps
 a=HHuYzeedka8FW0L2ZmSTYg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=t7CeM3EgAAAA:8 a=NEAV23lmAAAA:8 a=uuMaxHSMTqW_obXEo6oA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDAxNSBTYWx0ZWRfX8PjsUKpuA618
 U9JUQWNjtJbOykXZ731NtrUdQX4rKjfBnejd6ZuxDaAIR42Ilmo8Cr48lvY8Y/y+hhcT9W9IQ57
 LbRQ7SGKs7YQa96DFjgjGuPoDJHGxjqGef1Z3WJswLEpNyuWZAEAcfVuQ5ttK2oIufXl7JmsI5y
 ydt/6qUwouIcijSkDbV8aycLq+74w4QsPZmEixPgnK75PisiUFJopUn/nC84UsxObclZKoMhVDB
 CB/kZX8pgrqV6iwf8YJ/gva079ZvV2MKl9Lh178BVe9jklrlOzDBK/K262SFqrjGDl1MhNn8xkz
 8jgaiw31MIpKlxUn10NizVzMCzhumKeLLQLzk53Qz/P7VOuauPUgd4tzD6hAUvu6C1jqde9A5s9
 5fRAw+hf
X-Proofpoint-GUID: toP3RzIS3fGp2gvy4Bfagbw_beuva669
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2507150015
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 17 Jul 2025 02:12:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1807

Enabling ptest will significantly increase build time. Additionally,
since the ptest distro_feature is enabled by default in poky distro,
build time can be very long, which is annoying.

On my build host:
Enable ptest:
$ time build scap-security-guide
real    219m54.529s
user    0m49.040s
sys     0m1.304s

Disable ptest:
$ time build scap-security-guide
real    1m25.222s
user    0m3.306s
sys     0m0.166s

Since no one cares about this ptest and no one fixes the test failures.
Let's disable it.

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../scap-security-guide/files/run-ptest       |  7 ---
 .../scap-security-guide_0.1.76.bb             | 52 +------------------
 2 files changed, 1 insertion(+), 58 deletions(-)
 delete mode 100644 recipes-compliance/scap-security-guide/files/run-ptest

diff --git a/recipes-compliance/scap-security-guide/files/run-ptest b/recipes-compliance/scap-security-guide/files/run-ptest
deleted file mode 100644
index e8d270f..0000000
--- a/recipes-compliance/scap-security-guide/files/run-ptest
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/bin/sh
-
-export PYTHONPATH="/usr/lib/scap-security-guide/ptest/git:$PYTHONPATH"
-
-cd git/build
-
-ctest --output-on-failure -E unique-stigids
diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb
index b9f7a70..ffebc68 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb
@@ -9,7 +9,6 @@ LICENSE = "BSD-3-Clause"
 SRCREV = "616d4363527acb61c6494a97f3ceb47ec90f65fd"
 SRC_URI = "git://github.com/ComplianceAsCode/content.git;nobranch=1;protocol=https \
            file://run_eval.sh \
-           file://run-ptest \
            "
 
 
@@ -17,7 +16,7 @@ DEPENDS = "openscap-native python3-pyyaml-native python3-jinja2-native libxml2-n
 
 B = "${S}/build"
 
-inherit cmake pkgconfig python3native python3targetconfig ptest
+inherit cmake pkgconfig python3native python3targetconfig
 
 STAGING_OSCAP_BUILDDIR = "${TMPDIR}/work-shared/openscap/oscap-build-artifacts"
 export OSCAP_CPE_PATH = "${STAGING_OSCAP_BUILDDIR}${datadir_native}/openscap/cpe"
@@ -40,57 +39,8 @@ do_install:append() {
     install  ${UNPACKDIR}/run_eval.sh ${D}${datadir}/openscap/.
 }
 
-do_compile_ptest() {
-    cd ${S}/build
-    cmake ../
-    make 
-}
-
-do_install_ptest() {
-
-    # remove host & work dir from tests
-    for x in $(find ${S}/build -type f) ;
-    do
-       sed -e 's#${HOSTTOOLS_DIR}/##g' \
-           -e 's#${RECIPE_SYSROOT_NATIVE}##g' \
-           -e 's#${UNPACKDIR}#${PTEST_PATH}#g' \
-           -e 's#/.*/xmllint#/usr/bin/xmllint#g' \
-           -e 's#/.*/oscap#/usr/bin/oscap#g' \
-           -e 's#/python3-native##g' \
-           -i ${x}
-    done
-
-    for x in $(find ${S}/build-scripts -type f) ;
-    do
-       sed -i -e '1s|^#!.*|#!/usr/bin/env python3|' ${x}
-    done
-
-    for x in $(find ${S}/tests -type f) ;
-    do
-       sed -i -e '1s|^#!.*|#!/usr/bin/env python3|' ${x}
-    done
-
-    for x in $(find ${S}/utils -type f) ;
-    do
-       sed -i -e '1s|^#!.*|#!/usr/bin/env python3|' ${x}
-    done
-
-    PDIRS="apple_os build controls products shared components applications linux_os ocp-resources tests utils ssg build-scripts"
-    t=${D}/${PTEST_PATH}/git
-    for d in ${PDIRS}; do
-        install -d ${t}/$d
-        cp -fr ${S}/$d/* ${t}/$d/.
-    done
-
-    # Remove __pycache__ directories as they contain references to TMPDIR
-    for pycachedir in $(find ${D}/${PTEST_PATH} -name __pycache__); do
-        rm -rf $pycachedir
-    done
-}
-
 FILES:${PN} += "${datadir}/xml ${datadir}/openscap"
 
 RDEPENDS:${PN} = "openscap"
-RDEPENDS:${PN}-ptest = "cmake grep sed bash git python3 python3-modules python3-pyyaml python3-pytest libxml2-utils libxslt-bin"
 
 COMPATIBLE_HOST:libc-musl = "null"
-- 
2.34.1


