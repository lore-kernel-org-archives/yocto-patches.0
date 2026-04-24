Return-Path: <wenlin.kang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E082CFB44C3
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 07:07:28 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15557.1777014443738435165
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Apr 2026 00:07:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=fDLxfCRN;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=857414beef=wenlin.kang@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63O5Pjff4118828;
	Fri, 24 Apr 2026 00:07:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=6wxnWNvOv
	3JNHPTSn8AmhQb3+PEez87Eu4p5OkxgA+A=; b=fDLxfCRNkkXZuqh7NxEAWFcQU
	GTH5lWivsnpALW9o28s575PEcLbhcKjDaBCcHaoMtJCFTaEzT3H/F3ZlWU0fhsku
	g+dIxdEjKmsD+fBmsBLkRSYkYxDBlGHTPeLL5DeIIQtT39VK02/CV73KRvpH35DZ
	I0TgIk4ztqsW1Qj+OD07P0XUgTFQuNZBibZZpvb/0Gy0dHUM1Twl4Wl3qARLS2CA
	18bcYYnYFd8HH//tGWppO9dIMz4PaClh6Q4APdCECaiZwKSX6slcBosUCLqUegrd
	K8c8gN4wKXr3UA+mK+w4EgnASSnO3yBSAYjZtBNAqKHv4hatAA4KdzbPuao0A==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010022.outbound.protection.outlook.com [52.101.46.22])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dq8rcspbk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 00:07:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1IznekB5wA8tc/hyHAcH/fY7902G6IiETcDuKKaxWMuSg6iBkLXfGVkeyyZAMPxS5jAUv3ZNmbkJW24dBxqoGEaSeXBpN/C8twHyVA1LL/wYSt7ZyHp1Kql0hqXjbs4+qIS6BINDoyEmMQok/nAmMjnVDB+Y81RiN3WQlnFNWj+rdpvoZXu53Nzw7GRMgTq6R4Ms+4BC6+EDdePRs1HY0fhbLJLINdOlLf6t24TYhB+uoewbHBb9w+VEvDA/HeKO+m/7yAGI80na33uj9MJy1JXZOrWw2SdXbhMj4Sj9s/xtmUbpIXQXhmapVve3ntc0e1RxTBhlMjQ2X3FV2BSrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wxnWNvOv3JNHPTSn8AmhQb3+PEez87Eu4p5OkxgA+A=;
 b=YgqzjswJfgL/SGH5qXh5fEiCXdGPKRteryjInr2IvXw69+qbp19aJPcOOtMVCm3QJAIAXN1evtrVMGFJWhnOchcP3MqFPzmVBPWm5ZZ+tqLu7mR+7sYfwTrQ0Ozz6R49OpmP48ywXI01St87r111tNcGKDxNzwgB96UT92HdPDPCC6DRHFTP4/Ejdwc7AkVRvjLxj1S9Z67kZWHfxWrP/mMv9L/GIOyjzWCSFPG+VdxwIqyGt9kWI2MdSHXIayW5QZqdBo1T0oVFOJKmKVe2XDgvoyhu6JTUpOJOfc0yxNniiFdTKBZ0Zhg4tZUGyKTbds+wgqu7/9HVuRasyHabhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN0PR11MB6058.namprd11.prod.outlook.com (2603:10b6:208:376::19)
 by LV8PR11MB8678.namprd11.prod.outlook.com (2603:10b6:408:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 07:07:19 +0000
Received: from MN0PR11MB6058.namprd11.prod.outlook.com
 ([fe80::afa6:26f8:72e8:6a11]) by MN0PR11MB6058.namprd11.prod.outlook.com
 ([fe80::afa6:26f8:72e8:6a11%6]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 07:07:18 +0000
From: Kang Wenlin <wenlin.kang@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
Subject: [meta-mingw][PATCH] gettext: Remove empty SRC_URI append
Date: Fri, 24 Apr 2026 15:07:01 +0800
Message-Id: <20260424070701.2950754-1-wenlin.kang@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To MN0PR11MB6058.namprd11.prod.outlook.com
 (2603:10b6:208:376::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6058:EE_|LV8PR11MB8678:EE_
X-MS-Office365-Filtering-Correlation-Id: e4ccf775-0981-4233-77bc-08dea1d01f4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	3FQgBVpMVhqIUDKvHqQum6jzTNnUSct7uhAAU7iDdjZC8J01qF9BXGaaBpMx5sTdlbqOWIVsLvmFYSissbU3dtIMEmCLE4PynRiqsPA3aizCcUwD1uq+DSEVKbDFCM8+WZF+UgIqn2Od0wODM9FFcLQTzumgIvx60WjdUrVQGlnNidjFVhEJn1267Q08QDCOsD/7B6tCzNd1dkv/Z4c3MwAhcSAlNbcx8m48WhZ4hQpzCkAZw9J886zgA5tD9NK0nSBs2mgmgy9T+mLnbJZXShyIpTbly/F8cpzPZN84y7Jt96d2JFAuQVrO35Cy09hsCg0BIuSSiEQvQ+nOwFGu75R+u6xMgBZeG1TWJa/vj8YYJxTEZBzjS7AZ1XcU9ROvtXbyOfK7ESrWIfVdz8EX3oJGP9Q3vbf64xUdplXIJmAnURfDfj/GfaYF2VdFg0il/vFUEi4cBpkJ+uwKp9eQmc1NjfC5A1ol/IOjfz0mFj4qDaADVSjOLKyXGLK0cNetVoJtx1vRTZi2yRlDoSwxkOxo2+y6y4jrCLJjO4p5Z9Ae78bbRDI39E45nAo3qrZ91IQyrNdxnQ3CwYcpGKiSV0m9drHkEeDmIddYe8aJ0NGPohiHYDJp5jWh/yL7S7AqwGneOi922L/skZAEcVesk1H41zfEIcAb7a8qYyavM1NsGawX46QwsLhAKY/r4ttTzQEcZ3y4INpSK0PjtPqiOIEL7khHF/1BdxMhddHo0cRqNMDm9LwVKuXh3o623gun3/ha33413MvrnQ4UItkkiYzJw4oYrXqcXgKFXO5Vdi4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6058.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?C9u0wKzP6jJythS7ql8HznE1gD7KrCgULHGPsgp8hkIgoKsdy9hc2Kj5D6m1?=
 =?us-ascii?Q?T4yjnn+UWNmDyVCoR7uVxRs6GvtTyJJygxpemK/w/Qq+8rgGuWu4gI6J5Bim?=
 =?us-ascii?Q?U9t1KLKtDYQT9KmGkyFuIDNCeHXhCWAoxTIzLff8qCQ1XhaMjbQF6ojZ9y+S?=
 =?us-ascii?Q?xKM1Fnp0tOcz5BJFbZVKh2Uo8Hz6sYNnaKOd15vcm0BOp+H4YmERLSBMIJbV?=
 =?us-ascii?Q?y+WXY4EmKAIZWovRn3AJuj/NAzlxq+vrxnskR+KnP7wES1U0EpMiZERVzvrT?=
 =?us-ascii?Q?/joTiieS/XR7mdwDKCjfCa+tbWi5D1Fz0H6wk3/BbWKAkmqTCjap+GsRzbQ3?=
 =?us-ascii?Q?OrZHcjX9GnE72K+N40BySmAxFeHkeCqmzms3rEVf1Dvh3a+iWBomtmf3m5gj?=
 =?us-ascii?Q?yH5C1q1xUE8XQKMF0Z72/RizOF/Tsa3W76cEKdV10UWSxoFwCTQ5vEx+EPMZ?=
 =?us-ascii?Q?Z9wBhMwg+eEgh8brp1pt3r68mhDEuCfX2ZD8GfPMBzNowI145Dp+/v1BrmVF?=
 =?us-ascii?Q?vZWkCcaaErk9vp3Tqu36O9e3UvkSzqANqcuFCupxTxVj1TqZfPR6Q4rjs2TW?=
 =?us-ascii?Q?87n5so1MGBkGNbpsVLwwRG+f/Hq6G7XcopvOY865VB4CBwheaas64Iul0PsD?=
 =?us-ascii?Q?vOCQsUx+ZiNmWHzEYT3KzuaTDp09VWDR3DgV92N7mK06834z2bn6ijQXnXcz?=
 =?us-ascii?Q?go82Yd/6xG6u01ns+ewXP+xucSfc2mG6+wpezCe2wpA3RpzZNIaZ1GuOE5X7?=
 =?us-ascii?Q?F6Hz6swPDfXrTlRVruCxZ6zHGcYeSeiyaxZQG1+mtawSY+sbLSoOXwzJY9a8?=
 =?us-ascii?Q?8NVqbqyN9XEEy8VFiBaspW/TqI3UVxThakGtQf56Z81v/FIG6UEycVDT5fp5?=
 =?us-ascii?Q?FCi9rAKSxHfTjhs3f+Dst3mj6rFRPD7R7nEUHMoDMHMBny43qfo9kY/hRkm1?=
 =?us-ascii?Q?d8r8BlGj4AKU23D6iuOhF/W/idRRQrLHoOXg2Fisq0W930u+exjZGy+Ge2jn?=
 =?us-ascii?Q?G81OR/0P1JiOXtUHSKPnNbVBaorG7OI4KF6Sd5u3asSK5y6SHUnlkF5Uo7sU?=
 =?us-ascii?Q?AHk67AHgqgBZHnPo2Hvjw8e22Q4TPZjXkoj7a6tYxpI/et7ByKUHTLnstnqS?=
 =?us-ascii?Q?iYYn2DiolWWtDYhUD37UV46KKOBKxUNczMU72PuTKvEeq9q9GlErkoGhU+ht?=
 =?us-ascii?Q?Ww4lL1DgecbjYlfsRa1DyDRp1NTFI0zyToafscnrxL5ccd6AuPFisdIJ0smb?=
 =?us-ascii?Q?7jCjxLWIaZ+8rouyDp73izeFJ/cscomSeaWA4ZUCZWKtgxTKMkRepr344QEP?=
 =?us-ascii?Q?JnJmgVjvLtcmsq5aATLKQw4p/mgeQcR8bBkusjGGT6AijkiWYM0J8Wlq3C6u?=
 =?us-ascii?Q?6PbA4CAGGSsA943hougD0UnlQhK2m2B5TekNm5B8WzA4qoFyBh91FC/K3STU?=
 =?us-ascii?Q?omqBDCK3tutl1mp9r1nY2jxk8KK3KFI5QKGnsD4Zy4x1hQmN1Z6VaMnx3zQ2?=
 =?us-ascii?Q?fy/w4HoVRU8PPDnzRz5iw+lz9eXO90fEtmezmlK2ymvENkLrUVvA5k89RaLg?=
 =?us-ascii?Q?PZxviqDTabky3kWaRWaSnUPoGgoH+e/P2MEzqdTosvcxSF/6zxzamFKqDnvi?=
 =?us-ascii?Q?6c6fxsQ+EHClSi/U10fZ/KOordWGU8SgF94WAKqJ2BheVxbI8EyzHb1Dntk+?=
 =?us-ascii?Q?PzjbFriDJOKs8NAgjAFnzweCWrg0iZW2DlctBFEclclOKuj7JsEhRMqrBFbY?=
 =?us-ascii?Q?QjFyedOqvzInOOIJqJLNh9v+BR4RBOI=3D?=
X-Exchange-RoutingPolicyChecked: 
	VslLjlJ0mvFPkVRdz3q6xLpVHDN7DazQnlEptW9HgkvK6rEzDBpsJqiGc6u8RkRQMjLFPF5bVgtC1AFE2wzRHnkmZJs7lBnfeG3qZoGmrcuAC4ULJlYmVSSP1OPHgda+HjUgi8e90219iZQEVtGrokWr3fQz+BYNm/2tGaoRY6lbyAt8aAnuIOqh75gzMRHuSrM8QbPpe5VOhBL56Fe1ACi6VkOWFycNjA6zO1hGoTQYTpetz7GViuN0vPcz5h/DWxcwsx9Bb2GEj4DgstYMjntEZrVC3MZNAeu2KFQqP8bzWzoj6OFjXKyyzSYlfeIzHdVzAbSOycJNaXiJyKpp0g==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ccf775-0981-4233-77bc-08dea1d01f4f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6058.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 07:07:18.7413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AbQJf8gCk8StfIfTj+8099J2GuMNvs5q+XtbsCOsJa7e6GKgdGar9xW2OhPlrz1xKqI05Xop8LAZlP8aupvGP/O7yDz9OIObW7CwXVLUwag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8678
X-Proofpoint-ORIG-GUID: yjZWZnwLmhLakdWdiC9omx0ZWeZt0dRw
X-Authority-Analysis: v=2.4 cv=MYhcfZ/f c=1 sm=1 tr=0 ts=69eb16aa cx=c_pps
 a=QRdqWuRaZ29IqTB7rU1R+Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=9_iKt2ZvoFicF4a3R-EA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: yjZWZnwLmhLakdWdiC9omx0ZWeZt0dRw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA2NCBTYWx0ZWRfXx/ueXYJqCtke
 LMCT6/KOU+nxha0oItkzeS2HLFR6Rlemrw5FREYCPDNGFDy7BfruUXAwEtc3eJQ1PBDNKeuPg6Y
 fZm0Dr2k21ASiBZA4u4k8/0VrZtsNOXl3XVOT8arcQrPgNWc+uVVzTDoueG4XrWJ8Ucq0lf/p7y
 B5Olk2qmBkArGaAYQS0XnzRnk5ZGWxgPHbOh18dE0VYrbdv92pCwVZfBQwrUGh/ku35YQB1CVBi
 tkywfMz8sYE32lVjuco0v7MluymRmZATD+RLnZWJlQIeej2a5BD/wd3B2i936S087g3YN+Snqir
 U5uG0BWTmwWhSS8rOJu72h5RQf3XJJgp9Oo747GXfsg5ZRM3wUrbpP9pV1ZyfAFFroPV5GGecZP
 Ffu5vYQTq+rtFeZFU1n4kT0hMIhFFmKk0lwrFuTh789lps6nI4l/cfWjONMnItJHGpFA/Azjrgw
 NcwA0/ldViFcLNvB2kw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240064
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 07:07:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3785

From: Wenlin Kang <wenlin.kang@windriver.com>

Remove unused SRC_URI:append:mingw32 that contains no files.

Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
---
 recipes-core/gettext/gettext_%.bbappend | 2 --
 1 file changed, 2 deletions(-)

diff --git a/recipes-core/gettext/gettext_%.bbappend b/recipes-core/gettext/gettext_%.bbappend
index 96f1dcf..6a1345e 100644
--- a/recipes-core/gettext/gettext_%.bbappend
+++ b/recipes-core/gettext/gettext_%.bbappend
@@ -10,8 +10,6 @@ EXTRA_OECONF:append:mingw32 = " --enable-static"
 CFLAGS:append:mingw32 = " -Wno-error=incompatible-pointer-types"
 
 FILESEXTRAPATHS:prepend:mingw32 := "${THISDIR}/${BPN}:"
-SRC_URI:append:mingw32 = " \
-		"
 
 FILES:libgettextlib:mingw32 = "${bindir}/libgettextlib-*.dll"
 FILES:libgettextsrc:mingw32 = "${bindir}/libgettextsrc-*.dll"
-- 
2.34.1


