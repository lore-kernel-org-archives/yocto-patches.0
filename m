Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C15C3DA4A
	for <webhook@archiver.kernel.org>; Mon, 19 Aug 2024 23:44:56 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.7016.1724111095372786442
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Aug 2024 16:44:55 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=89611b77dd=yi.zhao@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JNUn9f004857
	for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Aug 2024 23:44:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 412j0xjbvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Aug 2024 23:44:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKRjSRvNHgHPRlZiO9C6iubN4I4oTXxJ0Lcc3//0tgcS6fEFwMTrSh5XkOwI/0KOPxClhA26YmVp8iz6Zdp5oe3f9KZ6ZlcUOrGo5kWh5sGYg3vyzCJL0vgSIsI0a+beER29UF6NPuQHXDdv8NX8uRozoGLCYbtgKtPNwfJV+1PvhR5ozOO2PwvvScKWJb5c6VhybALWBVb+igvQn4zxUvpFoaFNpDK3JW85NNehmNrNJrQVebcibX+Ih6XrBv5o50cfFFrT6iwqlaCyAll3G2DxYUdjSqBsDOzbRYjdKg6JYGN4+C0FZFv65JpAwd/J/aJO7iJJffUnbMyLJvIX3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qW5o4J+lTTLHAbT6sZtOqJkW+HOBB4lIbebDchK972I=;
 b=n0o33OC4b2hqksTcXMP8meH1940BTCJ5OHdyrA+4riDpC3OBUI808nB03Pg8PNvIOzmCIpRWn6yLcxbD2PjY16I/8Y9OwCj/TrxwEQSt+tnCs5LtN23GtA1JOd+T3q7ltN1dDrlS/yFdqhFgRPjvZQjJPiqjFAxSNDuer4X2CJe+/w3vQPo9TYnsv1p3ntvri9wJNZkjc6tjfuHDBsrTQYrJnyA8nDqUDdoCkNMTX0yMArEb4o5I5Ae43dcXk3NFhDzJMbs67QoHWVF4HK+4nHaOhrn6KyPmfXaTxs/MQqgdoixVEMjk03mWxag5IN/DFA0zL4gDxFhLax78MESRFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 CH3PR11MB7180.namprd11.prod.outlook.com (2603:10b6:610:148::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Mon, 19 Aug 2024 23:44:51 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 23:44:51 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 1/2] openscap: upgrade 1.3.10 -> 1.4.0
Date: Tue, 20 Aug 2024 07:44:38 +0800
Message-Id: <20240819234439.1234836-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:196::23) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|CH3PR11MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: 993c9338-0d60-45b6-eaf1-08dcc0a8eb56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?8iceaHq2D4Zv9dqMjH5A8gpqyKp8PnQX++m3uofu65yTAWkdCGOvbvpZmoFs?=
 =?us-ascii?Q?QP3/XJKwF62OBV9bm1wd6/8k8orKVq76K0gnBX3jAD5Fv4kzOm31RiIaxT9l?=
 =?us-ascii?Q?OZ0KeMQcsY2ekysphHeHagFW6rzk6nnRytrbt0N7MvL3wLB+ElSHwRIzZmde?=
 =?us-ascii?Q?0xBkprVZ8DzRG9Cq1S1DRl8bIu0CeGGSK4fV3rl2uhTmbjD2MIIONCEHa9HA?=
 =?us-ascii?Q?ppoe/wF1+IjFlAFP6VLp/RdG2G6qe/eO7ZEZf/teiCA2kYWzUN+VIo/DHois?=
 =?us-ascii?Q?MNfaqD4Z+PYSoMxdjDrUguOK0FC7uZ5+Hi9YRboIlquA+Vnjo4iNR7rdob15?=
 =?us-ascii?Q?O1HMUrjqQQc/ujGK02k3Vt06pXmIteJEh+mU4LH97yU/4LNOhCHiJLMSJuEL?=
 =?us-ascii?Q?n/+9SLABE7IIPOqUaTbDc1dha9bGiR8f5Jzjb6cMIVkK4OAKoI/xJjtm8O3s?=
 =?us-ascii?Q?83tx7q7nRLmk8nl/r+nGFa4PdoMHSlWAsts7VEI4mZTR1K4FAumzh8KcSauQ?=
 =?us-ascii?Q?FNi8IM5vtwyU+DbGgcwV4RWAJCTUMqS1k6vINgQqmq2IX6mXK8iaBDuTyEyX?=
 =?us-ascii?Q?xsEREOknOlgs+UE8vXJSQLoiZlVG5p5wTZGSt4QEq9uPvW/PxIguhiwiqtYF?=
 =?us-ascii?Q?40/cBEJMdWp6Q2GbCp8e5Dxuxx5ta7kFHMjmU3wJRQRFblogxCPj8TeNBFtk?=
 =?us-ascii?Q?DYgk8YpqtdUvDOtRzaWwRja33XGVXy67+sOy+IRDaci+Fmd7RnQTd6LFN4hb?=
 =?us-ascii?Q?twiic5kfKqAudE8qP/pSG9cUtn1/GdzQuPBfKDy/JXP0fXyUCOQsbWtlIyCK?=
 =?us-ascii?Q?iRDFme7oHuY8b77AD+UVL7SU1BBDyntgbKdbn+jKNdaW/sb09vTNvQN/FjTp?=
 =?us-ascii?Q?UgLI/AnmS/W+f/WeUBoI6xEbfKK9OpJ4Bgz1JU/DdJ4v/r8s2g2TcvwgvQzh?=
 =?us-ascii?Q?pJpwBFQp4Fugl2NyYhW5qXcdQO9HUqDoUsoAUOKGYU1ye6RlTOluzAApjvmh?=
 =?us-ascii?Q?dF2SNFOEfaKpkvFdJfYwiHER2JMMEYQ2AZVP8VnAmMjjUL3hfKN/HP4nNI9Y?=
 =?us-ascii?Q?rL1nxMWDJF2VE8v14C+YauZXcMz0fFVC69V7zRQWHM9Nrlct6W2jSleFblNt?=
 =?us-ascii?Q?4FYGKIwBKNIF8DK1JpUe3g3AH4O6UaFgxHUzH2yfpDcTiZ4TAF7ptUNzbyfS?=
 =?us-ascii?Q?Wk6feHAyViQJuvvrelA7CEuUwvHS5xgH4tmH83EkA8SH3ppEfFPJacFi21rt?=
 =?us-ascii?Q?/QQZwK53D1mpTIp0F80zCZh2MPhZ02S/s621hLXPCUYSMWJILXgQQAUAIYgV?=
 =?us-ascii?Q?EDkpCbNdb/LIvukIPwttKkyiMilQvwOY9MEO2b2q/05uIGztDR49mxkI3/NS?=
 =?us-ascii?Q?bAo0f6Q=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?P/g1ri39hsFSGpSQ1KJpl9XPP28sd0eDTrhZ9VncI2bbtiy+T6St3HWtgGWp?=
 =?us-ascii?Q?DQHowGyTg5/aVeGDM1/OovuObK3HfbiOlyXff9Di5Xlasv1M6VbBnvZLuMUn?=
 =?us-ascii?Q?Msj/t4XUIQz7p+zXiToVTfyltD9rmygVNA/2wPaqoxvN/v5QPuynsugbUAPT?=
 =?us-ascii?Q?Zs2eLzcvo4yglcXHx1sMx2SMMG0Vi/W4tb9wjkV3FHJl8r+fexatFCT0N6/N?=
 =?us-ascii?Q?l7MPHP3VmSxXvxTvLdSg8K1aYzdgwVwjo7gezaJTEgABdro5WgegC5bJTkg2?=
 =?us-ascii?Q?d298974ci/Yox6wo1ik1q35EryU7mpN/XKzs+LCeYirVlZP7RCbDsXasRvXV?=
 =?us-ascii?Q?ozDy9t54etQG6o9+vMlkGih7s9KOjgQ6UiHLSPmfmrCqyB3LYfQTtbAXvAQW?=
 =?us-ascii?Q?qtDHpavc0ejl/CUZb1mLM1OKaHBV7awZZl2Pq8zZxaK00s9vSc21oiQB9VV8?=
 =?us-ascii?Q?X7B2glYkW0GF8wdMHyTv/E7+mmrtjQMAR0ugUumVE9kmWYeGA390QGx8LB1r?=
 =?us-ascii?Q?2OojOqR7DhPYavCzDAF7tKEci6i9r/lw15JOa48orEJiuy6XaPP5sRdcUy1r?=
 =?us-ascii?Q?F1QYRXg59Q7QsIjqHeDSd+qr8LlnY9cdE4EHiYcBjpayQ8QeL1QvSQKGxzz8?=
 =?us-ascii?Q?xRAmAW7jk2QigTsyGzYeHt3lHpO7sX9/AQxTr2SlPAK4dhoaVQXEMyIMbp7M?=
 =?us-ascii?Q?xJJtLjCarig96UXw325cj8IzvvesbxMiTysHmA2hIT2gjg+1O7fD2iSF0lYY?=
 =?us-ascii?Q?kiWrxj4ui3kj650in6bWviW1qBOztCTxZJBen157tQ/bCvAjje7n1VijmVib?=
 =?us-ascii?Q?qiw33rQHO9yxLPHrPppH7rMX8laqa3ytY7JZNc8q2K3gtQOybi95RiN0bh4r?=
 =?us-ascii?Q?nUzEkHZYcZJ3klw2taW5ImKmPwt1vsKyYXWcd+2tOUs8N/H9r45NeZ3GyrEM?=
 =?us-ascii?Q?TdtMNxm/CSJKv7SnAjJk611jF0k+T7FY1It7yrI0k9aiwdrQpf+TrSOCtJkd?=
 =?us-ascii?Q?rWqqavC1mPqG/5lb3gVSowDSKsG59QEvmYv62OkjzKdeZYWmFl7XNTonOHAL?=
 =?us-ascii?Q?ca77gvpCvmoi4drTbj1f6NDqJEr+vz751CwQ2Ocdh3Rbg9S14WpOBcWicoVx?=
 =?us-ascii?Q?mM76CzTHPoI4HjubfrLooNd8ovsy2EkzMPZC/iO0O4YFF0glkGE8PLrKIl1b?=
 =?us-ascii?Q?y0ldGtUlKVq246/jvqS9fbcGicAdDh8IvGLSacLAo4hzvYQ5pT7e+df+wRrs?=
 =?us-ascii?Q?hOoBviJ8JnBFXWbmh/ih2ntWr0HvDjz1sgoBH1Za1Q54Vz0tTKgMfn7Zlp5R?=
 =?us-ascii?Q?6Lc2hzfJSd6fTjUSlDTD+yEW6FTtvB1D/MAr0Y1P0ESxr4qN3u/47UoBiMQ2?=
 =?us-ascii?Q?IDfW19RKtJfch4sOO4bpXXYsg7kih40cgjL4D8yAckGZQ29sgWPMGRwlqrqe?=
 =?us-ascii?Q?qnXgBxabAYWbtsNi/VDK8iyecAMVcWn41pM4SPu7Gxh3a3S2Rl70K9bD7GbF?=
 =?us-ascii?Q?OrpvSA5Td1igLqh8YYgtMPYi68r9+0sT2w72+QhB5xjitBZHPXbjeMPRz815?=
 =?us-ascii?Q?Iszrep9rPyv2dtGpaguHZ9ohit/XCL8R0ranLgsy?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 993c9338-0d60-45b6-eaf1-08dcc0a8eb56
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 23:44:51.6659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S2VEI+BCJ5tIjduI53muI9bV4QDZpVNEj7/OCMc2HiSyT2WMwmlPVt9ZQRAxGswmgtJYR/mMhqRDkulsxvXesg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7180
X-Authority-Analysis: v=2.4 cv=PszBbBM3 c=1 sm=1 tr=0 ts=66c3d8f6 cx=c_pps a=AuG0SFjpmAmqNFFXyzUckA==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yoJbH4e0A30A:10 a=bRTqI5nwn0kA:10 a=NEAV23lmAAAA:8 a=t7CeM3EgAAAA:8 a=_UPrx8PyLlm5JZs3PkwA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: hn8jlZUnYMdjgS_ZhoKJUWtSa-hQUSWW
X-Proofpoint-GUID: hn8jlZUnYMdjgS_ZhoKJUWtSa-hQUSWW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0 clxscore=1011
 mlxscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2407110000 definitions=main-2408190159
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Aug 2024 23:44:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/521

ChangeLog:
https://github.com/OpenSCAP/openscap/releases/tag/1.4.0

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../openscap/{openscap_1.3.10.bb => openscap_1.4.0.bb}      | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
 rename recipes-compliance/openscap/{openscap_1.3.10.bb => openscap_1.4.0.bb} (95%)

diff --git a/recipes-compliance/openscap/openscap_1.3.10.bb b/recipes-compliance/openscap/openscap_1.4.0.bb
similarity index 95%
rename from recipes-compliance/openscap/openscap_1.3.10.bb
rename to recipes-compliance/openscap/openscap_1.4.0.bb
index 5433573..de56e9d 100644
--- a/recipes-compliance/openscap/openscap_1.3.10.bb
+++ b/recipes-compliance/openscap/openscap_1.4.0.bb
@@ -9,12 +9,12 @@ LICENSE = "LGPL-2.1-only"
 DEPENDS = "dbus acl bzip2 pkgconfig gconf procps curl libxml2 libxslt libcap swig libpcre  xmlsec1"
 DEPENDS:class-native = "pkgconfig-native swig-native curl-native libxml2-native libxslt-native libcap-native libpcre-native xmlsec1-native"
 
-#March 18th, 2024
-SRCREV = "6d008616978306ce5e68997dce554a1683064f8f"
-SRC_URI = "git://github.com/OpenSCAP/openscap.git;branch=maint-1.3;protocol=https \
+SRC_URI = "git://github.com/OpenSCAP/openscap.git;branch=main;protocol=https \
            file://0001-CMakeLists.txt-fix-installation-directory-for-system.patch \
           "
 
+SRCREV = "a01b5d6927c7bccf41d9c623fee0c5f7105db835"
+
 S = "${UNPACKDIR}/git"
 
 inherit cmake pkgconfig python3native python3targetconfig perlnative systemd
-- 
2.25.1


