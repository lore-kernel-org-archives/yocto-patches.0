Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F99CAC5A8
	for <webhook@archiver.kernel.org>; Mon, 22 Sep 2025 14:13:20 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.53176.1758550399006232454
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Sep 2025 07:13:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=Yz3rzNcI;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=1360ad79ec=yi.zhao@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58M4iZB13905784
	for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Sep 2025 14:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=DlQRueb4IfjGTOxfcGWb
	We+lcr5Cw/YudTje0ZesIFE=; b=Yz3rzNcIR2H7JgwyZ0Zuzx8fJwSSext14Twz
	EMhP6QuqoeQEqWfym7yiJvk9QK84b6HLPyaqYrNO2Ejc0IVPhtB2hOkhJIOaRk0Q
	JbbVPb0uRgyRw0dXjV3ksGZzc04AL74uRdKsmzaw7liRjHpsCgY/aKzraacoaLhY
	tD7xohXsEIr1t5fFWvBNA9HJNMAN2zDtlLO1740oImsckev0EALcAcaafuzqv17j
	FWyO7nZqU26xPvOvN7loRMj/TqwdICdn1784MFtKwrihY0LHeYnSLKVdJ+7Vwyvb
	v0a84gChZNGXR1sH8Ve+qCtw1aGN0GWLJMDrvdX+zcm+MzEZtA==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010053.outbound.protection.outlook.com [52.101.85.53])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 499hg1hwr7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Sep 2025 14:13:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbDCJaOCGiguxW1sEXq/cvLva4EcKHBNxhP5+yw4lL67YaZqX64ifJrRrWj3lx6Ig1jW+LTTcu7YGiPjXxPrdcpSkmTZ06RdmJUdCaxcpVyhGwzAtcqM9PckA3U/E5KMUI5qLwaLPeO0g+gefS1Cq8mtMJkJ2Mk1Ji0Lg01SC9Cmlmy+hZ1tErbVqsXTj65vNK+O7vZJs6Yv6nog9KyGCgMU/iGAgK4HFuaAO2CZ8P6C6b2s+dVn2etv3auZgIp0GM1/6m8ygE/i3pCaASCR6yJvz/DdryxMXKZSlE/j1iExvcEGQf8xZm+MY7RcS79LJ7kMFwcRT2gQv37C2EnIcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlQRueb4IfjGTOxfcGWbWe+lcr5Cw/YudTje0ZesIFE=;
 b=fLqrtuuDP9q4voFKztUm6h/+R3WA3NYvoMRE9n2XANSzTjRa2gR8K8+LaCCt0OBve/59JJcsUxm28L5yTSaSUTA2pvrj4s4QXdBDDZpaq7cAqdyDLBriAWCWATqLhiyYWaOt/mK8g2gyENMP2AXhV88T8aMneeBgkVT49rYDYHR7ZS2Duq0ght6hzk0y5hqMrVpj7M15YWPKbqqTTBajCG+Md88mrPsSD6ziETWDEi3rx6E3K2/x0ARIz0XNcSZ0C8lSmcjAhr4+DcWZwHS9fOqQurpg0LHl/3vt4datAYmfDxhu82QfoxSn4YvzDu4ceDzixoATVBFgdvXtoNj35g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 PH3PPF957B3B2A8.namprd11.prod.outlook.com (2603:10b6:518:1::d39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 14:13:13 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 14:13:10 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH] setools: upgrade 4.5.1 -> 4.6.0
Date: Mon, 22 Sep 2025 22:12:43 +0800
Message-Id: <20250922141243.1477831-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0102.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::9) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|PH3PPF957B3B2A8:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b354b09-381d-46ae-c4cd-08ddf9e228f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?bl58MYFPOZA0BjKFsjhuzv69Qyd9RlOKbZXMTOJud2png4kEBiY16ERcqTB+?=
 =?us-ascii?Q?TaJL2P+wxBXPim6CQpFBt93CLxhNlcXfrR+3lmyy7E5WPx2P/sfTN74mJVWK?=
 =?us-ascii?Q?JXK9na1FYz2lxqmacLJX3MN/klGcVzFoT3OpkbY+lu58b6iRd7fwkMPBUe1u?=
 =?us-ascii?Q?pv57MBCqbN5icaGCYk2bSRTKAMwmxyzEIU7+Lqst6GMlD0Utlo7+0Gi2fh5m?=
 =?us-ascii?Q?gxa2zkj3XPbkEN4Vws8wQWnH+6oqxFp5M49Dp3rbBVvPkQo0RxONj1wcSJt/?=
 =?us-ascii?Q?EAbFiIBs3A8MIkDWQdm1K1hGs2SclXtH2QaLGkas6uJvU3l5WiLBtFCuwZgW?=
 =?us-ascii?Q?GRtFsK7lhvzihWHs2BiUrKHPtfVF7vpM2IFxLnBq1iZR78Dle/iquW7d0en/?=
 =?us-ascii?Q?0FmOg18cJXT+/Mq4dZ2Uy3Usygue0e6SlcEc0jd7MpXrUZUtzP46AYqIUKgB?=
 =?us-ascii?Q?YhS8YrzZjRJH/6PHd0Q8EtEj1mRWGg+pY5p4CfgoJv5PJyZ8AgbOAvrZdnHG?=
 =?us-ascii?Q?FMHprnXOXRhqIh1SAyZNsZeDbN+rQbonspJPImDWSj4xK093uHgkV1kGu2Gr?=
 =?us-ascii?Q?85Pbt7BfnJ0G7SZfkDeUw7dlGOvq1U6B2QVgYJnkXulQhEAPUCw2ROHPzwCB?=
 =?us-ascii?Q?zBd7mURIN4cC9IrgMU+XbdngJ//GNBcl0K2J/yLYwbX/KB5B6AWv2ajb5cSz?=
 =?us-ascii?Q?KL44+l/v+6Nx3FmnrfPOUP1Tm7MsCSHrNp5rUsSR+kavlKvp/FGhYvdZ1TAA?=
 =?us-ascii?Q?tK29dnhxw/rLSfV0UkgjljiH/Gr8h7lacbscX9b2rpN+i5itsT325/1hiuqG?=
 =?us-ascii?Q?TF155+y6MnGgjAhGoRZqB1NjkthqjROCc8UnqVdN39MRMZ/Ok0XmTfmO+TdK?=
 =?us-ascii?Q?UVVCGZEIlzIcptBqwttaQdQQdyAEhVZDo+K/v5x/wP/UlqvyId7JhWXgEVkk?=
 =?us-ascii?Q?lf47bE9TmDNEoO+UZK4zeLqJHkGlL9ywfSDQkRaPQTYquJSysEyII0ljuC/i?=
 =?us-ascii?Q?1i64g2/BYVCMOXkaOvJ0ptl7DlamYzMvA1mZ3yl+777phNtH/Rh1jwlVcath?=
 =?us-ascii?Q?SwcTVa8dZZqSuAZm+/LHBwT+lQLUR4LLd8z6gtmwFhyvpo80vsEJ5F6Vc8Dz?=
 =?us-ascii?Q?zNIFHw6uW7dvn3HbZcjwaPP5ZRm3+p1RTVtv0irfCVM8nXTbF8nyGnNwrIsV?=
 =?us-ascii?Q?hp9g1BvWLkhKqIa519pn1VqRny0f5m0S05z5JO+pQmaGKT2B9xWT2F2LKmV0?=
 =?us-ascii?Q?KeblBdozQcG9P91kXH7l2bjIyJTg2XIPWzACdrl3kpiquezNlRwrUZbOg7II?=
 =?us-ascii?Q?CBqBHojvqlVm7jmMJnaZzQypkdlAKATc2BAPhualWyvhodQxTr4aEiGt/UUI?=
 =?us-ascii?Q?tdMizhm5Cvtay4pNPFiPB3v6IM8OsiihDpePreiyebCcgShI6vffke7RHEc7?=
 =?us-ascii?Q?bqA+hxxEMCRfngD4JLZGpcP6wYSBDU9eeZ6bY9vPNzY3P5JJuU9A9w=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bKZH29VktIEEsV14d+TVNlMewMuAI4GbuCSOe/YLSRK8+EHUZy8AwZ9Os+RZ?=
 =?us-ascii?Q?6C+6OVdjhRfgRB8C4eqreZsYFjslHKVodPaXZEGNJU0ViXhAdFI/rEEJAsp8?=
 =?us-ascii?Q?QPGldxfKnMQcRkjpVPEFbnGqSO83exWQMuqXk9aGo719NBYC0ome1KeWuP8V?=
 =?us-ascii?Q?b1lK/tdV/rdBxFebQgwahgUkRXjlXocvy8vmBo5uXyJWKPD1cWgZqrvN6PsY?=
 =?us-ascii?Q?YwCc+d3i1UogA34231dzMJa8PjbxsqPPI1zcIiw3UWj5/JPuwED/jCcSHKft?=
 =?us-ascii?Q?XFr0RKnG6NrIiww6I3F9K0vlu0QmbKg6jjkXMUQeqgwvJ+6Syvfm5lzMEF/L?=
 =?us-ascii?Q?h41YouueSJh/siIm8zh/+Z9M/0CpJHpBEucl4ncs6j5S7WDnBFNdsgZ54YZk?=
 =?us-ascii?Q?+Np3LSQqgi9z2wm22Uat334irCg0RmtZ1X+JVtdLt1XzZXlY8d36k1YFrY7w?=
 =?us-ascii?Q?789/lWXJmhT5O39/6P6XnNR2rYsbXcgwgGajxd2eFkReEQpEvbtl9+EExba2?=
 =?us-ascii?Q?BwIb2hK3tVf67ZM/8yGhqkCmS7H8Ty5tKkh26yL800+818e2F/xBRju1+o/y?=
 =?us-ascii?Q?zxICdCyplE6ZIPXP8J1O7x3JXxB49YXjiB7ySeQgakmCLQR5TMCkViK6L5sK?=
 =?us-ascii?Q?sPdxftMIVR/PtnqLDuf8JAPZ5R+1cCzpC+2PEkieabVbOKhUZh62rTNA3kDy?=
 =?us-ascii?Q?fRb2x4DR3GNa1m94fILhwX1Y12+KNSpQ1i/cnv43VsM1BFV8NegrZDsUX3s2?=
 =?us-ascii?Q?5Kc9aRJIU4blXySFZdUFHiW2QAT5HpdzyZjaPEReUNKMQTXBcTdhRQ4DxYhY?=
 =?us-ascii?Q?Iete3g9XAKBwjrpftEVlbgYiQzTxJspgqJ1EgLpmLXKZNQZdle717TrDvzSc?=
 =?us-ascii?Q?t1trnYJ80nt+IbaTqRCEUWBGVX14ELNrVpSaV/S9GiCqOTJnvPMSsVEqISCh?=
 =?us-ascii?Q?IOQXA9lXj1+345Z5QH8hqgDrD4JOs9ONuc/o2JO7+QcFtEm8o7meInjfu7cJ?=
 =?us-ascii?Q?P/ojXefl7NU3gB+LNUO5AzMJ9kgXYAfqWVUOgYK7o+q5saQjJxarZEEA7KpS?=
 =?us-ascii?Q?fCRqO1iP7oMwtQL7g5BZQwVTMwL6pHbqhrY5Yp7xihtyG0ucCKbwCjiE+BrF?=
 =?us-ascii?Q?FcGKkZdla2lZGWBHRxwMPYikLao5XwcdrmEy3i9KkRbqexpCI5Y/jRVYsGHU?=
 =?us-ascii?Q?35itV91Xaa1UQKqn54bTiAzVhR/q0XJPxXczJHfh0qZl/qVg7VFbKkzIHLce?=
 =?us-ascii?Q?HmJ0hAn1pfTn75DuhDCDWIr2SIH+07W9vYETGaVqnkQTs/4ulAfetlM9razA?=
 =?us-ascii?Q?pj9FLToSyj1Pbv6lKaK7aWYFGP+OkKItGhkpRlkgksE0FSI6kegxPAAAly3+?=
 =?us-ascii?Q?5+n2BcDDkA6K7dT0HOZhn9JAN9azqFwm2itbghlYZRhx5VoFOSAKb6GztxLC?=
 =?us-ascii?Q?nMtF2+u43xUNxABcWn3YdmdiXF9plild/yhGquRzavUIcldF/TiSLNhrMDnD?=
 =?us-ascii?Q?To5Hs/690ndvSbp9njfiQP23fxRu21wsC7Z5k0Pr7/FIK0PMzK4t1hLcPaAp?=
 =?us-ascii?Q?KwIHbBudBmRSxTlTC2XVNrXfrukitiWQfyc1MHdop+vADJlDPLFgafYfBPD2?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b354b09-381d-46ae-c4cd-08ddf9e228f1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 14:13:10.4338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mt9aRJu9ypSmOk8jcmm9fzbYiOTTZfhxX7WCMhDHTw5+AcZUS67pmIzsWlZ79Hw5CxtAVGSUYZdKEwy7ky3x4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF957B3B2A8
X-Proofpoint-GUID: B_jS2BOVq8mFzhZmEqI9nQ8tcLdSucW8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDEzOCBTYWx0ZWRfX8v8Sq39U5ot5
 uzkmHlYoF0NAjtUuckZf7bkPTw3Rv2fNqG3GgX91ICG4V5phxjdNj6cXgwrcCpYGvmIka3NkfWt
 w5NOX6RNCo1mMQQ1RwUbQ++mSP6w+HpkIsvE+6AjvqEew6c0JkLfiR59wXlP0OqrRnfJJWBO9qU
 JSkWtPF/T/hSlNaMghQRmuP5gEHIEWP6Xuw+azJ+Z6ROKIwCcBwgy0JP0v1BXG1eAvfoEzgote3
 VU5NS5yyuZsvnjOw7Oc7zPWyVTxvsRmJy7wKizxfZj3J5dnBMtR+8oIqFJTeR+xz2sboDm4shpk
 NJxtm+cytYmyzJYzK4fe3eR8VAN6kplIHlyy6YE7yvIqQHu3jRrTtyKibSmqmE=
X-Authority-Analysis: v=2.4 cv=Yfi95xRf c=1 sm=1 tr=0 ts=68d1597d cx=c_pps
 a=m6tRWrYHdetyOVyhMCHtWA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=t7CeM3EgAAAA:8
 a=5Jb09UuhYbDiodkIx_0A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: B_jS2BOVq8mFzhZmEqI9nQ8tcLdSucW8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 22 Sep 2025 14:13:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2225

ChangeLog:
https://github.com/SELinuxProject/setools/releases/tag/4.6.0

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../setools4-fixes-for-cross-compiling.patch     | 16 ++++++++--------
 .../{setools_4.5.1.bb => setools_4.6.0.bb}       |  4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)
 rename recipes-security/setools/{setools_4.5.1.bb => setools_4.6.0.bb} (90%)

diff --git a/recipes-security/setools/setools/setools4-fixes-for-cross-compiling.patch b/recipes-security/setools/setools/setools4-fixes-for-cross-compiling.patch
index cdaa45c..bc4cc1a 100644
--- a/recipes-security/setools/setools/setools4-fixes-for-cross-compiling.patch
+++ b/recipes-security/setools/setools/setools4-fixes-for-cross-compiling.patch
@@ -1,4 +1,4 @@
-From 673bac44ce13f475845e0b69dc73bfaa5a0866aa Mon Sep 17 00:00:00 2001
+From fedbd32adb2a9ef2ce3cf9424791f6ca3dd84d88 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Tue, 14 Feb 2017 06:32:35 +0000
 Subject: [PATCH] setools4: fixes for cross compiling
@@ -15,18 +15,18 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+), 1 deletion(-)
 
 diff --git a/setup.py b/setup.py
-index 5584e55..057bbb5 100644
+index 0b8e3e9..a1ce872 100644
 --- a/setup.py
 +++ b/setup.py
-@@ -79,7 +79,7 @@ class QtHelpCommand(Command):
+@@ -10,7 +10,7 @@ from Cython.Build import cythonize
  
  
  # Library linkage
--lib_dirs = ['.', '/usr/lib64', '/usr/lib', '/usr/local/lib']
-+lib_dirs = [os.environ["STAGING_LIBDIR"]]
- include_dirs = []
+-lib_dirs: list[str] = ['.', '/usr/lib64', '/usr/lib', '/usr/local/lib']
++lib_dirs: list[str] = [os.environ["STAGING_LIBDIR"]]
+ include_dirs: list[str] = []
  
- with suppress(KeyError):
+ userspace_src = os.getenv("USERSPACE_SRC", "")
 -- 
-2.25.1
+2.34.1
 
diff --git a/recipes-security/setools/setools_4.5.1.bb b/recipes-security/setools/setools_4.6.0.bb
similarity index 90%
rename from recipes-security/setools/setools_4.5.1.bb
rename to recipes-security/setools/setools_4.6.0.bb
index aaaace5..1c8bc79 100644
--- a/recipes-security/setools/setools_4.5.1.bb
+++ b/recipes-security/setools/setools_4.6.0.bb
@@ -5,10 +5,10 @@ libraries designed to facilitate SELinux policy analysis."
 SECTION = "base"
 LICENSE = "GPL-2.0-only & LGPL-2.1-only"
 
-SRC_URI = "git://github.com/SELinuxProject/${BPN}.git;branch=4.5;protocol=https \
+SRC_URI = "git://github.com/SELinuxProject/${BPN}.git;branch=4.6;protocol=https \
            file://setools4-fixes-for-cross-compiling.patch \
           "
-SRCREV = "659ec47aba0126e3a198362ed1659bf600c067eb"
+SRCREV = "dfb95f338264f2d7ecab46b39479e4c29e44c09e"
 
 LIC_FILES_CHKSUM = "file://${S}/COPYING;md5=69a7b68f0a4a570d7c0c43465333ecbc \
                     file://${S}/COPYING.GPL;md5=b234ee4d69f5fce4486a80fdaf4a4263 \
-- 
2.34.1


