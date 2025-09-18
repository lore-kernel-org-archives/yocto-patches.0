Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57381CAC59F
	for <webhook@archiver.kernel.org>; Thu, 18 Sep 2025 02:05:08 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.4191.1758161106199032331
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 17 Sep 2025 19:05:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=oiOajckn;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=1356ee1fc6=yi.zhao@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58I0xfEJ3073366
	for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Sep 2025 19:05:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=b4nDwYRW5HLtZKWQxnBiyAFfhg+gVj0iLki/BFvEhNc=; b=oiOajcknT4ea
	dynACjuOo0elCnHr2AdV9VIItiYfct+An7TBPAcGmiRSLHDY8f9SuE31bvi3irSq
	fK6uoRaPF+aF+MGewup82sqXay/UST8zN77oalvgJmV6524E/dRpbjG6UlTYZ25o
	CHRoRBZ4a132DOUbo9D2acZrM535qLTASkMOlEfxNd5rnLnSDdeyIx+RHgUsiAxx
	KLK68jJVbYTDyYzr9yT6tUta96Abm3Hj/06ioPSVBo1Odr7mDeDwgyYfVQWvC/fW
	U/hfC/HoLM0nNtx/tnL/XeYWMsHgdO3mDFwPrdGEodg1UqQ3v86Lv1HvKWnBsD1i
	JAHHo1GD8A==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011021.outbound.protection.outlook.com [52.101.57.21])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 497fwr1g8d-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Sep 2025 19:05:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sIJOJv539o8Z5jmg6xtDyyNW9j5beKR2vKGubGkGH9n4rekO7IJTLvhH8kE1SuSuOAaKH/RMjV23Lst3lqlQc3HVSXrvz/P/WV6uggq1ZDvkWBeUUrBtvbVlw/FvoUJushTF4ep9lLq8bsqZGxUeJL7VCeodvK3XiZXb+4/YTxkLjT8Ya0h+CakbXDIKLxju/AYT1bzDnSk9LxDVan6X134AE9866wq2HEAUC2m/z2MSeiypSZylfnFH8Vdkm67g2swQRgR1BHfMukiig9syAyeY3NLuKasB3YSwfgbGZQ9xP2pAffayZOrQpr8657QhXhQ03qTvjEpfGx9ubDXwog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4nDwYRW5HLtZKWQxnBiyAFfhg+gVj0iLki/BFvEhNc=;
 b=iHTTkOPZD8eCUAUpxuEMykzA9wtS0hDLNlSlEJGutB/3dlysU2Ybxr9ZNtYOuO4anaH0GiGTmZUBWNstRWtoG1ZLWBg2Xu8WtwPbW+/pbdofIdIVNsAWKt9gEZX5df3Eef6B2JRZceDkXn564pavAvX5tI8so42k9mZUWnYUx9DL6/YzdJqdz+Y+eO6B+9PkqsZdX5BNtrifNpd4o8S1U557wiPGdX/00PF+fPiKdyERHIapBSbxJwaqu+vuAcQ7SDhiOpWQrZm22Ot3ywsBpniwKUGyHRK80dTgQMaWIUlnHjWfIIw01RQQMEExU0bZqU68NmlCX+KoNK4n5A92EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 DM3PR11MB8681.namprd11.prod.outlook.com (2603:10b6:0:49::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.23; Thu, 18 Sep 2025 02:05:03 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 02:05:03 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][scarthgap][PATCH 2/2] openssh: update sshd_config
Date: Thu, 18 Sep 2025 10:04:45 +0800
Message-Id: <20250918020445.1175478-2-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918020445.1175478-1-yi.zhao@windriver.com>
References: <20250918020445.1175478-1-yi.zhao@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0218.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::17) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|DM3PR11MB8681:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad1843d-6a0b-4b5a-4662-08ddf657c814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?LvmLCrgC1U28QsPHHM2jO90Ed+o+3M+c1qN5iJBlqZz4cDgfFcdA6ZDnSGx0?=
 =?us-ascii?Q?Va6ESGEBepZhV6DGLajnq7BHSKV2e5Us9Op0OivNPEJ5lHVddKmp4n9nJ9Ox?=
 =?us-ascii?Q?gVN4Sc5S8Xy7XCFwjnHfITtgaopOChDuGJvQzL29+ct5TaXNMu28Y2lVsH9R?=
 =?us-ascii?Q?uL+xwU30lFZ54IYA7CPw5Q1qP9RwmsIl2H3isOqsjzscTFR4IQzZzjwVo3db?=
 =?us-ascii?Q?LGpEDq/5d2k1hB5jhwAg32fVHX8/YsKnycYBQMrGCLFmnrxhNL3dFiiEo4f7?=
 =?us-ascii?Q?ejf0FdhY6tmcu5vFoMK0xeKjOrXnKqQi/rts3cLER80BwNnUnbYAxyMF7ed0?=
 =?us-ascii?Q?TjG3et2NMkkB61qMgEs27cSuQ2XJurBEr3YHiBQ1j6aQpivbM+mqFWtZvVuZ?=
 =?us-ascii?Q?el2AOX+OrzrhanHgbo1rjVwMG7sXZ9ag/Uk4bKNefa/kEH65OL/l9IyD/r9l?=
 =?us-ascii?Q?ToElklOMNFwNnj79ehsneY3k8Z2eqG22rPieGNp5iy8k9cGeSYAbpodL5+21?=
 =?us-ascii?Q?2bP+t0pCYsTvQFZPbU5QtPNcWOtADca5z1SXt6gmz7a/ok+ietr1rygTwJhx?=
 =?us-ascii?Q?Mzllr/RTUwL66CEXiQZ5lV4qTIS1vkZuoffGOrMYqst/LafzwzI/YKVTW4hN?=
 =?us-ascii?Q?49IRex7O8agIQHmTN3MY/WwuyGE30+M0NK6i6sWZWi2PdtdXcSi+45TTAcug?=
 =?us-ascii?Q?dzzzA5xlMRnMBToHHDF2MImglR1vFy4VB0NKaCMVUX5y36viujOCjk9qO2QB?=
 =?us-ascii?Q?NQIPcOta4YS/8cLet5GOU+OKqo432ZOx8CAlR8HUfe8SsBN1e5I+EDZc3JUl?=
 =?us-ascii?Q?iOpa/Thw1ZiuGlpC98mQc/yqRSrTRVpAZmuypeJTJN/3Hhdgl7UhBlxeiwTF?=
 =?us-ascii?Q?FL05fhd/+uInU5QZ9tETGzvNddZz2zuMrUotirTV8BIkigVmF4vofNX/DeWV?=
 =?us-ascii?Q?iptxgrO+4v6sEnoKp8yS0yliKgFUcNcdJvVf8AMnklOKymB+fj+X8zhfe+xZ?=
 =?us-ascii?Q?sSfaDnrewRQw0QVSRi8U8ZzWDp8XX0mekuus0LX+sCPNmYrd6X/DCjTElb6H?=
 =?us-ascii?Q?2r+iItC1KMhnWICMITogR2A3D9AS7s6ie1Wl2fFutYBtRTf6O9mJBL7V3zmk?=
 =?us-ascii?Q?SQOqw5rAfJa70ORgnVSjzLMk4SBGHfdhFb/CqMapaERnwayzAsrii5UrvnS2?=
 =?us-ascii?Q?9K2UGVHV+huqckPiqHPwfs7NQLdvBwJKfqPgoBMeAln5IIFh05nIFaBM0WUg?=
 =?us-ascii?Q?REZMNQ13c93tHWMTKgtd4DaYWfG+AX4kZwfGTN9caAtxvWJotn1frN29FazU?=
 =?us-ascii?Q?48gTcWSHFKEvF/flif73ah42iztUXbbLT0IUbM9bsC1zGT9FGRVBmOD64Sy7?=
 =?us-ascii?Q?lMOfO9/kz8DWisUK/af6WtKAaXNp5JwvCNUq7YRupwIYLt9wyj7CpfzebSiY?=
 =?us-ascii?Q?Oa3Qibtf0sCqu/gKLT2cy5F+Sc3WUMsPCm8JkJGhoqsCRaIKhJkYrg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fLLxoloCPMLAOH21PntE8LH5mJJETYrJkNots623DrOxjfGK5n2KM6AaL0gr?=
 =?us-ascii?Q?TuQDwsz+xdXjXKJsRHWOqLAd1v85jKwXX5SRLmsASGR743uZinHbd3TFUtiT?=
 =?us-ascii?Q?VNyC7hVWwalLyt6V/UlQi4X2l6hX4pjruBfNTdmiMxpDT49q56yZZ+82jp7C?=
 =?us-ascii?Q?wwGvPxLGy+S8O6MzpHlmB42xducYd28cN8WJgeVfitSvnZolXDEEPRPHPLpa?=
 =?us-ascii?Q?WkBHpANttrQa3vYyf9YCP67b5CP1ljd2/22f0AiEVIJuK6aobWaYufOtZdmt?=
 =?us-ascii?Q?w2XeUz2pSaomlSYN9Tov+v3XPF1jUbY2R1LzkxNQUhWb6xNlXYXBICVUmeoT?=
 =?us-ascii?Q?T5YNP7oZ67ogBlFwG7lFWt1gdHb8mjia8A3g+yeVZnFNHC5fGPOmsit8+nbh?=
 =?us-ascii?Q?RiSbfbNUR41Z/hhhSI3lC9iYaPZQkLYTM+dbSiq/htZe54Jy87xq3xrx72de?=
 =?us-ascii?Q?/U7r5h4kRn/cmPJcuVv9c0B2W6UVTK5XfaiSFuEpUVKp/bcpe5y29v8ykVx6?=
 =?us-ascii?Q?+gsykDt7+nHaccpRAEZ4hkx80YKgMHCtofNZmoFAKBZ2TPzhLGOZEG6uFslq?=
 =?us-ascii?Q?UIc5IdoRMgLMmG0FZKFjUuKNheS83qe5KzHB1EGmCPDdxBLkDsJP4nhGhQIe?=
 =?us-ascii?Q?0PkDgzPAXDjLfgUru7usiixiYXg81OfLB6KeKsDm4tJEqcK8P1z3+lKptsUg?=
 =?us-ascii?Q?rH+Ib2TWIRL1ohlhTBleFjGBjVCl9pLq25wQaA8Sa97G4uQCCcduCdwlfBHT?=
 =?us-ascii?Q?jPpFSiPpNd1f7tWSITzUfiHKQwroe8iEP65WLd2PcCG90K0Y73GOgB5uwCoE?=
 =?us-ascii?Q?omerX2tDWCATP+V61SlJ0S8v7RGpVuPXLePZ7e9gPOjw5ARD9O48g3Xc1lxD?=
 =?us-ascii?Q?CHm4is3LcNL2+tL/xZ/QzamcxcGVYHqnzKPwi/RDewv6a0lCoSalraF4VnhQ?=
 =?us-ascii?Q?PgJeHPkX4WMAYT8WbAUuGLoyXOyVW1xZSChBBg/L55m8dYPUEnG9NQS4Is83?=
 =?us-ascii?Q?OkkHS30umBZv3PKsal5chP5NErtwm/DbbbVDSSQdkt46oLvY86LnkJnpFSSC?=
 =?us-ascii?Q?071kctHWMJUKhht31MMSTKzUytFiS5Mj4pR552+suHbtWE6j6xMNbQFafxlA?=
 =?us-ascii?Q?uNQ4jo4tI4dSvzmVh5GGaDuz+FrVKEILQbOpBa9aZDI8Jymsl4132w99aKC6?=
 =?us-ascii?Q?3x7B1YadKFIVU2QQ0hMo+1OXJrBh3Y66TIx+Mzc13dkeCl65ybOa3QICnpm2?=
 =?us-ascii?Q?AB1a2voLQEMFD6TdPVEvg8ilOl2UJ+FfrhltuyQbyiBy6S/O1tL3MZNKP/gr?=
 =?us-ascii?Q?1Halh4HTL+7VESfr2x0qt9JGb/NiVSe89HiTdoSivkSpQhS4uxVYCyVxsjD4?=
 =?us-ascii?Q?RoYLVekoTUaVr2J2ZEF3s8cWXqMYuGaaGHBRIn9viYPk/Z1XbFMx/pfNES86?=
 =?us-ascii?Q?+C3NumXdo7gZvyIQi8FsH7DzT6Ngk1BqWA7XaIn7bGS9/Nr+ER4MG9NgYvxR?=
 =?us-ascii?Q?3mxd0eC0zPOoIAZ97w7g6XwuEHDdwOzgWG/kTl7hinb9KDtNSQeRp3iZeb4Z?=
 =?us-ascii?Q?NiCsOWDtMgIJ+7K6fXPq5r9VJ9WTpyTcZXFtnAfI?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad1843d-6a0b-4b5a-4662-08ddf657c814
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 02:05:03.7536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urEoQNtSwf8daiByEpwqDsUClDjFxLxV+zhv3nHGMR/waZB8cLVgJrQnjprIq0S5tcbFQ8zvaQg5RYbKiuBjGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8681
X-Proofpoint-GUID: L34tREUQeU9oKdtjDOgjYPSSNCK_4mLH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDAxNiBTYWx0ZWRfX3imIltDDUWYM
 Nt68x790l6rWc9Gogdhj0Ebx7IlT+kXsdML+BMqN8e7NefN1eXIo1P5fUQTPAYVIZv1Er/leH3d
 RXUef0LJIChwlXta30EZO4BIaLONttR6qA18jH0gNfcIMtZhBN4+vpL2OgRnfbeGV2FcluLZgEQ
 Ycpch/YPrTVo9qLpY9/uhD+6lUL+9SU7L+9brNj1B9aZjzCCOaFG7OP4qegdhy6JGnm8MQTVI4i
 BaxwUk1fzls9riWmTGAa2UElgeppeqgz4TEdU7+PK3Iy9Y16SFycCSfKInPNp1sHUj92QvjTbF0
 yT7Mqyn3ha6u/1fXLSw1c1wZAInfktQujiquoHm2szjSsNvtbMULtRpJ4IN/WA=
X-Authority-Analysis: v=2.4 cv=WvsrMcfv c=1 sm=1 tr=0 ts=68cb68d1 cx=c_pps
 a=UGDxSQ6JIm3CXF+tY3HRSA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=t7CeM3EgAAAA:8 a=uSm21Sp0dwqMU9z6AYoA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: L34tREUQeU9oKdtjDOgjYPSSNCK_4mLH
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2214

Synchronize sshd_config with that in oe-core.

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../openssh/files/sshd_config                 | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/recipes-connectivity/openssh/files/sshd_config b/recipes-connectivity/openssh/files/sshd_config
index 1c33ad0..18a69d9 100644
--- a/recipes-connectivity/openssh/files/sshd_config
+++ b/recipes-connectivity/openssh/files/sshd_config
@@ -1,4 +1,4 @@
-#	$OpenBSD: sshd_config,v 1.102 2018/02/16 02:32:40 djm Exp $
+#	$OpenBSD: sshd_config,v 1.104 2021/07/02 05:11:21 dtucker Exp $
 
 # This is the sshd server system-wide configuration file.  See
 # sshd_config(5) for more information.
@@ -10,6 +10,8 @@
 # possible, but leave them commented.  Uncommented options override the
 # default value.
 
+Include /etc/ssh/sshd_config.d/*.conf
+
 #Port 22
 #AddressFamily any
 #ListenAddress 0.0.0.0
@@ -38,7 +40,7 @@
 
 # The default is to check both .ssh/authorized_keys and .ssh/authorized_keys2
 # but this is overridden so installations will only check .ssh/authorized_keys
-#AuthorizedKeysFile	.ssh/authorized_keys
+AuthorizedKeysFile	.ssh/authorized_keys
 
 #AuthorizedPrincipalsFile none
 
@@ -57,9 +59,9 @@
 #PasswordAuthentication yes
 #PermitEmptyPasswords no
 
-# Change to yes to enable challenge-response passwords (beware issues with
-# some PAM modules and threads)
-ChallengeResponseAuthentication no
+# Change to yes to enable keyboard-interactive authentication (beware issues
+# with some PAM modules and threads)
+KbdInteractiveAuthentication no
 
 # Kerberos options
 #KerberosAuthentication no
@@ -73,13 +75,13 @@ ChallengeResponseAuthentication no
 
 # Set this to 'yes' to enable PAM authentication, account processing,
 # and session processing. If this is enabled, PAM authentication will
-# be allowed through the ChallengeResponseAuthentication and
+# be allowed through the KbdInteractiveAuthentication and
 # PasswordAuthentication.  Depending on your PAM configuration,
-# PAM authentication via ChallengeResponseAuthentication may bypass
+# PAM authentication via KbdInteractiveAuthentication may bypass
 # the setting of "PermitRootLogin without-password".
 # If you just want the PAM account and session checks to run without
 # PAM authentication, then enable this but set PasswordAuthentication
-# and ChallengeResponseAuthentication to 'no'.
+# and KbdInteractiveAuthentication to 'no'.
 UsePAM yes
 
 #AllowAgentForwarding yes
@@ -92,7 +94,6 @@ UsePAM yes
 #PrintMotd yes
 #PrintLastLog yes
 #TCPKeepAlive yes
-#UseLogin no
 #PermitUserEnvironment no
 Compression no
 ClientAliveInterval 15
-- 
2.34.1


