Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9EACD13CF
	for <webhook@archiver.kernel.org>; Mon,  2 Sep 2024 06:52:37 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.32944.1725259951405781495
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 01 Sep 2024 23:52:31 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=99754e51c4=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4826A6q0017522
	for <yocto-patches@lists.yoctoproject.org>; Sun, 1 Sep 2024 23:52:31 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41bxf49fqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Sun, 01 Sep 2024 23:52:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTCU4d+k1s157GU4anAA02PxD/4bdavJ7BkBR1woyorZqKeRajrhXpWzHAlhKQls7CyfjjFWE2xf4RheRiAdl6qaN6cpowWi9B7YvGznuNYfXhVt1bQ9NyHbez2fVHl5nSvzxQwOy8u+2qN4LTqM2QY1oT475J9kNNcGKEg1OLqiEExu3CAkDEt4E2Q+rmatL04Q5WsTnMSAilr7Gvk1st1cC08LIWNR5aArX6HUua2+b2+NFuhIlTVNlU/wy82XEeylXIsoc1Ep5OTzpm8Wc+U2GXI38mH1m2g2YDDSd9UKexdXI6HPxEpw4OJSW/QH31UQ5mRvDtEKLRmRjz3CBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfVPe3egYz4M5ClZnEIM7M7Q1HdJvfiOlc21VhLVl+g=;
 b=SCqE/ULYauXAAigPLHf2ZWdzuImUi45BXK7p/Y32R/5ThNdNaq1hcbEzK7F3nXbputwTzcaUBQdZDIj5ea+W33icPs4UGaLiLmkNryTrgiohiFTnovQXkXp/b/KS5i89I2ISrDCbT4u5ZEIWYWvkb3dlnblq9Q2oHFm8FL2y6HGjsWl6Z67yK76Gx8NVQgPwN3aEdVN74KeYVSzbd1RbLFcX8K+qNGjsDB6YCuP+f9MXePc+ke3iq7IIMjHgXp1NHjOHtzrY7cPKgLVn8352tf0mb17/swPptNvMt67/3a7hFo4gXrVAsbtZXQGMaUv8uZ95Tj0WXpCCluqU7F8/IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by DM4PR11MB5261.namprd11.prod.outlook.com (2603:10b6:5:388::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 06:52:27 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::a7e3:721d:9cec:6093]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::a7e3:721d:9cec:6093%7]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 06:52:26 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH] libgssglue: switch to use git source
Date: Sun,  1 Sep 2024 23:52:15 -0700
Message-Id: <20240902065215.1863037-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0142.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::27) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|DM4PR11MB5261:EE_
X-MS-Office365-Filtering-Correlation-Id: bdcd7702-7d52-4d96-4bfd-08dccb1bce47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Ku3AIvTOfCFq1RiHcpFRvIczLK5v8q/wGJNkkklpdSzjMgQvBb6+WxvVqHWt?=
 =?us-ascii?Q?vpIzHeF2IOHXetswXsia1VA7JzoGUBrc5rQPm4O5a31tXhFJeMuiSCqOUu1Y?=
 =?us-ascii?Q?SOL7fUVrHrmWk121JVIkCwZ6RRfTTKuRolcGrGMaiGZcEwVAQgR2s5k633QQ?=
 =?us-ascii?Q?4vZtu38D0xyI9dGxnWs0HZaSTI6HwxTAEnHdhB3jkL3UJeckzoRQTfupLZ+t?=
 =?us-ascii?Q?C1+tGHF2QLLhFjCRn3assBzZzphZfr1ywMc22fv7VEJsFUAfUe9eU4lfEDCf?=
 =?us-ascii?Q?j7ub9CGlYx/99e4LnKviC+qUhiWAQqKjK1ujk56DQ/9aJNoxuOdcGJRL6oP8?=
 =?us-ascii?Q?rx7pZOEPv1cPWyg06wjxwme41TxFIDw0oWw5YwV97D3qeyCN7fcUBcZg6vGK?=
 =?us-ascii?Q?8KAMxIgtT9GgUE0MO6U7KDStn3s3D7osEj0slvaPlnGUrtMUbpXjSJc5iP9P?=
 =?us-ascii?Q?SJOuk/AJGBwrfZJVMSP/WragTLF9h+ioac5zi2+cTIx7HTEsiO1MrWm93wSt?=
 =?us-ascii?Q?4ifieKE54lv0fB9N5w1ZpL1u6lFvB4JGl3uxKy+XUeia4nW4WRKnLpiSrtQ7?=
 =?us-ascii?Q?W0zAMJjb1d8KXMYRclRcMSUsKwrRYo1bA9hpNRnUvTc1KHRNKLl+V/bbijXB?=
 =?us-ascii?Q?t/c8IQKkRNmZqciVsHXtRlDQFK8bFJMTBxJnLYHYk4kFWzHpESWU6tAQDYC1?=
 =?us-ascii?Q?sH6z2wr5AIaShMtLqcr06sIqhKOqjW++4wsJtW/evo42O9BD4jR9/Zrl29Ab?=
 =?us-ascii?Q?CqAfMg20Uq6R5j+/aEYJXOAUhuJDv0C1/Y1O8i+eiRakrQrzulUYOgMynott?=
 =?us-ascii?Q?CQ41KBhU80S4R/h1JhYdItS4wVYdtYHktZR2gBxZWWJhXZCEWLu9QAjl29N9?=
 =?us-ascii?Q?fORBNF+LY8hDUf1TbS9MPbAArFriMo/zksvbdYQ8fzMWXZ8AnCAxJNhZJpK0?=
 =?us-ascii?Q?E8AOJ2ARV9/pD/OtV0bbfHcZ8Lw4GAsgmYWx8R/CN+mwqH5Vl2AWwpIGsB51?=
 =?us-ascii?Q?juVetvBbeSVCP16Ukdcv6MgltD5743XH+Cb3+vaydgppMV6rUdjPZyujeJTV?=
 =?us-ascii?Q?Pi4+PtxEEwlMjUc7ogEVT1PK6zivimRUfyiU+gPl5/RYCSkLxCrjYqk9FSJR?=
 =?us-ascii?Q?BVyQZXOkMKS+KVbIfstqpO37RKnvuCwf0QoyEkV912LTVGZiUZaf2zdfOtqW?=
 =?us-ascii?Q?BW/myadfjWU77BvnjOIkiezPFkXRzjEV0ErUlhkp1pWseJ6GtcgmPbaYCiJJ?=
 =?us-ascii?Q?94XqZiWyEvAPAAaX3uz0afDezxGnZYepTA68MxvNDb4gt9/GclKUqoOyOHUs?=
 =?us-ascii?Q?6fQB+JNNU18mDorJ3omwLJnuXwEOTRgFb9dUHhg+mP+9/eML1Q8Mb/cc9gvu?=
 =?us-ascii?Q?kIPSMd9PeMCr9SIUX/QXyEPgwM515RE5Ov4s6Xs9EoL4FGojoQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?r40N1GA9sccNd4NALZ0NtNsWzmQuwMWs9tX2m1D9Ti9VbWKwngZIIonYklzG?=
 =?us-ascii?Q?0s2P3YEn99R5U7tjThBrpOLtyIvUP8sOtyDvuHXREsCNo7RN6redWyp0g/n0?=
 =?us-ascii?Q?mpbZ7ggsyakdMHew9tfF4kBr+mAlCIR5Vx/OMs0JQikyCn5JiDlMrJRktDYW?=
 =?us-ascii?Q?jPpga/TsIZKdv6i6VC5sfGEYWQoLAtvI6lRjXh9Pum6uC6ase/aomX/d6Xc2?=
 =?us-ascii?Q?m7ZruNBqUQXtbxyog7DnLri1wsF4sf9WiSZTQlsnjVMePG5gmw9ueGWfzHCL?=
 =?us-ascii?Q?6whWJqqWONiABFGjrKdj9w1JJc/sCXCPO2xllmDoe/xZQAle3bA2d1Z+lisN?=
 =?us-ascii?Q?l7QHjX3K9YViRkvo7LMEHodiYFlU1xKkQOCGo8rs8lvbvLSFQpq1OhWRIhb+?=
 =?us-ascii?Q?aD5yty0QMiWO2eCWyuOkpfGSNZD9Wt1VGBKUYV1J7Ps2kpLnsvAktQj5Gn+W?=
 =?us-ascii?Q?8XtIwT+rOnbMFBiXyJlXWQqPR1cYoZf1j6uNgumwc/c9uOyu6HA2Z1TKdwSf?=
 =?us-ascii?Q?F7W5pD84DmXGHpSRPJBzsFlvtzR0tkDZdidICPPq5wOFeS9AEBddny5IzpTw?=
 =?us-ascii?Q?G3tGtRB40jPDp+R0n3UI6KDBb6FZCZiUMTmapbURgKC3wFiwTxOcXJ56WrDM?=
 =?us-ascii?Q?h0om6aqY4eucclucI+GXPezu6rgaaV8D431/4IrsVlaoxqFW73KmtXlWwITO?=
 =?us-ascii?Q?uwDWV8FKEd9Ecb6Pic98uAW0d+UxE9phqsDWXmMMObzhsOeFx0Buh9Px0ogA?=
 =?us-ascii?Q?94EVqFb5MUxj8LuftfJNXOHqgkKkSiKV7XSdlhako+siqAzon70jEyfv0P7o?=
 =?us-ascii?Q?LHAAQ3yAXx5NkjfnQtOTpks1mmBSRGaDJBOEE+ZJ7WsW+UeHv+WWdr9eidp6?=
 =?us-ascii?Q?/c66zI/Ppm/q6CwLujxKo++iLDV7zv2rzXc1f4cbrLWq76p481xPqRlkyMPf?=
 =?us-ascii?Q?RgnQquuBrguV8MH4STtxhYlTdKQPVzQLidoWGEJJTwNnfT1D2+6JPqVXbPPv?=
 =?us-ascii?Q?P0iWkBHCpze46h7gF18fT//Ask7ttRQyP73JHFS6Gq9dzjkDGLLzqKpIZZ2W?=
 =?us-ascii?Q?6/AOYbVqmIxx/DQQY1r4Z5a1gzHqMGwmvnPa+uOcsdVOPkVZrHuX4CQaR69x?=
 =?us-ascii?Q?KHdhGBRsdporNBXOsGsiMiZB+KaYDfcql7Vg70bls8yPsP0Rh52wCkzylN+h?=
 =?us-ascii?Q?Ld+m39FYO2ThLmP7eAWSXD0JDy82a4HTah//Sj4vsv5mRddHXSAYpPnvYyGJ?=
 =?us-ascii?Q?kQXpYyBJUciJ9bCCUmvP9JmlsecSYY7rbzo1cnTZNn3g5CM0Hmz/ULnKMpiS?=
 =?us-ascii?Q?wj9UIsmgipnq6ldGYHpnRXjlIPrJR2EgkV7S2uyVQRAGAYAJmHQfD64UnQWO?=
 =?us-ascii?Q?gJIkiGYiklyJS5agIEFuYSp2T6KuFp27Cyki7g/nkd0t4t33S2n9V5pW87yv?=
 =?us-ascii?Q?cItgO0LKjzKQ0pOBAjIOsMNXGIm7N39n8nmfm5+AHR6k00a7FA/uLsJVFpuX?=
 =?us-ascii?Q?GXk8KlfwT7VDDeaEzH+1OdFIA78B4ND0qcMMGvdePxsDLOoSzwswaUhBN0ew?=
 =?us-ascii?Q?07smx7Zj7ZSASMmjRx9jsALBZG9BTOjU3fX/nhGg?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdcd7702-7d52-4d96-4bfd-08dccb1bce47
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 06:52:26.7503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kt5kAIL523F90w3eHB8B3fOHeUMMiP0oHrvdikFUBhxBu1+0fr01q8+VdkLNGlWJfcYEZaJyslzYCYrgsdhew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5261
X-Proofpoint-ORIG-GUID: Md5iDX3td2YtTRjOdeCkHb-UnPLZ3ewc
X-Authority-Analysis: v=2.4 cv=X8QAK3Te c=1 sm=1 tr=0 ts=66d560ae cx=c_pps a=Bc47kgIQ+uE7vzpOcRUeGA==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=EaEq8P2WXUwA:10 a=bRTqI5nwn0kA:10 a=t7CeM3EgAAAA:8 a=p0WdMEafAAAA:8 a=U2UOgzUH0LVdw_PmGPIA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: Md5iDX3td2YtTRjOdeCkHb-UnPLZ3ewc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-09-01_06,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=608 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.21.0-2407110000
 definitions=main-2409020056
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 02 Sep 2024 06:52:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/607

From: Chen Qi <Qi.Chen@windriver.com>

The 0.8 orig.tar.gz is not in debian mirror any more. In fact, we
really should avoid using orig.tar.gz like this because distros
like debian will just delete those that they don't maintain any more.

Switch to use git source.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 recipes-security/libgssglue/libgssglue_0.8.bb | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/recipes-security/libgssglue/libgssglue_0.8.bb b/recipes-security/libgssglue/libgssglue_0.8.bb
index 9d01964..e534615 100644
--- a/recipes-security/libgssglue/libgssglue_0.8.bb
+++ b/recipes-security/libgssglue/libgssglue_0.8.bb
@@ -21,11 +21,12 @@ LIC_FILES_CHKSUM = "file://COPYING;md5=56871e72a5c475289c0d5e4ba3f2ee3a \
                     file://src/oid_ops.c;beginline=378;endline=398;md5=72457a5cdc0354cb5c25c8b150326364\
 "
 
-SRC_URI = "${DEBIAN_MIRROR}/main/libg/${BPN}/${BPN}_${PV}.orig.tar.gz \
+SRC_URI = "git://gitlab.com/gsasl/libgssglue.git;protocol=https;branch=master \
            file://libgssglue-canon-name.patch  \
 "
+SRCREV = "c8b4b2936b854a7d4f7ef12e30d6f519b30dec87"
 
-SRC_URI[sha256sum] = "a2bb183e946f6e30562a2a856950a2916c9b6d42c34d67a8400e4efc28917746"
+S = "${WORKDIR}/git"
 
 inherit autotools-brokensep
 
-- 
2.25.1


