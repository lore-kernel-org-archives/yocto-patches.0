Return-Path: <li.zhou@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1C9FF8850
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 02:28:33 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33724.1777256904640471784
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 26 Apr 2026 19:28:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=PMEgMsYn;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=8577cf8428=li.zhou@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R2DcYS548408
	for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 02:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=rPFMar8TVfK/yS9TH+CL
	kHVUw+p0G1LzRSh6p8fWy4U=; b=PMEgMsYnHYv96ed+6q3t7QZE1f6UbJZFDAQs
	LuA6CXqPh5l8Ua986KnNWIS4fwhmyqIQ24tCQEdN9s6DCgN6c8IaqAzpAgtMZTi5
	AB1ZUFd0IlGiQVjc+tcViRRxRM3JKnUmWmy3n7yWq6DAg5viDwb67DlNItUY2WpX
	lpvORAoGCMSeARUPxgLohegwAP3l2Ss9sh+snygWCo3DrDNVpF8LtBIXEuUOeo5l
	MKDMWoSdEPtslyubWVJFMpemo9sPkV5FbiSuDg7fJLSR+ZahOacTQPcjsU3CRdMu
	6hAuhwe/Qxri0vKdu4i5skvXSy0WecMZziLqQqBT7F0vcJ/8DA==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012043.outbound.protection.outlook.com [52.101.43.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4drmk6sf60-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 02:28:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pg5xMbHdVr4YdpHK2jrRd7C6j3R69nsFkfSlPaSYxeTt0eZ2qcAHoyvBSp8zrZmq+2CE0XJigbuWi75/pAc8uUqgqchluT6qWE9dg4wtoqRctsmgykTfWfy67WDA5j2iR8UDJ5z7o4QECyVUcrxoS7FHd8HO++Bnr+aPDdsfHUejZL+KXaQ5NfSPy2A8o8dzont/rP5Ba1nlbjJQ0KRka70h78L9YxCRoEFWJKEF4pUOwKlDy3KarpHBY1mRvprPrQuT9TdGXwRZ77p48jx2IYl9tMQgYuSAATch/yWHqMbpwPouS91j1cf0UNlm8pogzGpmufEpGJywg+79hpkXFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPFMar8TVfK/yS9TH+CLkHVUw+p0G1LzRSh6p8fWy4U=;
 b=arxemkon5WggRAxkjt9NQTqMq4m1HZtySTOvsrrFLGQWUQwjxwXD2O3Sln+njxErWDEhXfZTCj/9l39LxwKqexfbo+TsAyhmomNu/s79ErmWYZf6DhHKiXSODnh1HcpZWpxJ7Z+sNvHuAE6zmnxx5WKZeBy6pQb2PI1/NQwzL5OW18Z6nyHC3AxmaK9LKA2SusoKEy7TsLo25QlbjCTSIbOpLcbDP9Uz8UmKqgG3sj93JJP1N7+FsD6nJ9b9tjD97QTERqC8f2tTfwNIyetxH2VfNn/5C2e+K/dU5yfxXeSzfGfA+1psiLUcOULn7+Nr8AHyOAUY/bCGfwD3PAhz3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7453.namprd11.prod.outlook.com (2603:10b6:a03:4cb::19)
 by IA1PR11MB6347.namprd11.prod.outlook.com (2603:10b6:208:388::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.12; Mon, 27 Apr
 2026 02:28:20 +0000
Received: from SJ2PR11MB7453.namprd11.prod.outlook.com
 ([fe80::3198:3bc6:ec3e:b2ae]) by SJ2PR11MB7453.namprd11.prod.outlook.com
 ([fe80::3198:3bc6:ec3e:b2ae%5]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 02:28:20 +0000
From: Li Zhou <li.zhou@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH] firejail: fix COMPATIBLE_MACHINE setting
Date: Mon, 27 Apr 2026 10:28:01 +0800
Message-ID: <20260427022801.970322-1-li.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0152.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:35::11) To SJ2PR11MB7453.namprd11.prod.outlook.com
 (2603:10b6:a03:4cb::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7453:EE_|IA1PR11MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: fd525be8-bf56-4610-0d47-08dea404a5f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	43R+hW8b9zTyvqjyLY+MoERF8QbHD82S7kg3h2SnJhX2SbszVbxQSxRo6kg9Z+5QP1GCEwkrDHojDfReVPVQnmy3vY2yh+g4i4zEy7QCW4k1SbfDSeM6s/5YrGVmkMhTeY8PfhNcV5JGVPJC1DfldlSVf77BOqxZwwzNKfvPxad9pi4aid0WblzDTgio4gLkTCg+1c6n2+NhAuPy7vTMoYl4dACgpgTRfLXDXUlPoJwGOr4FVn4z15uCWFb1wm8TBM3KIzAYR9Ad/sc0tj8tzYQlXpD/CYxmz166CSw5nawRh7SgXLL1G2bFyVIeIfyhWQSwlqHOSY/R8CEZZatwPfy3e5k3TkvJYOCIcHWXV4+bTROYhhz+1EM9kDMS1bZNnCcouQ7vTlEs9P6vgfXLImBKWS9+gomftcLxSw6rtgAL47T+N/AYz87zgF68N6jQnLfPatno/JkJCiT7RPF9cUTa8MNdLGbJDYysIdvqR2teuzJwlG6VzT4AidWpU1RCWmPQ+KtW9ztO1D916mTHtx3zav+S0Z6bablscmXp+JvUrGty5rKVg7ofnhPgK778Z7XMv3rWBg0hErvQsPLrH0DMNdMUHzqzULY+1inHqhcRdddzE2Gcf+4zjeQvFBJ+fIU7dK7vY/bc1Ztpv9GIQwRFfUBh1igtomkZHPfP4kN9/jhK74fXA8Wmyhc86UfYKMPseXPsxSaGVXijwEbjJ5vak0H2CGmHlRQSwVZn9/aoM38wQK1cDUmVV/Av49ooZtchVc11KoQiecSzzgGKIITkRh/f+LXP9lSl7tqJ5a0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7453.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KLr0yOUCFaegoSwaNF+f/tB5IZvEMIwjImTAT2c4Onl1hEdPcco0csWpEwW/?=
 =?us-ascii?Q?OVMbV+IolzHcgUd4K+/t/t8tjTj1Mtz5gjKgdY+T1L809CmrYyU0Tcsra7Xo?=
 =?us-ascii?Q?1z7bxhscQgnvsx5MR2AA1/i6bLlaXhaMPOPXXPfB9Jpvgu/HX6zCYjWtrlVH?=
 =?us-ascii?Q?fuXnJgesKwcTmck0kzqYja5nKadmqUiyO6DLQwCUUOP1bVy/+F85afjTGSul?=
 =?us-ascii?Q?LfclyTRFborMS+GMZQdBO0MC8St2FLbEq7Ospbe8wRNLhnek34Lc7N7ipXRS?=
 =?us-ascii?Q?UVCycrEU3gB83YLRS0nLEZ/OoLeKns2iJgUDeVARzO93GTuCQFxwHhCrlv0j?=
 =?us-ascii?Q?LgvM6fN3qAo1UpPz0LjNGCi4hM0TcHDFVqnX3YhnBvl3r2W43ItBcGaJ87dJ?=
 =?us-ascii?Q?F4oQbHWgs6Rea9NFlTqgkzLUp1BOI4Bp42X/jUfq9yVu7bRQ6+RfjFgKbyUa?=
 =?us-ascii?Q?j3ocgiW/Y+Wx9BjkYaJBlgOS5Tbe6jXyVbRIiw2PlSG9weqUFGaGNQ8iz0K+?=
 =?us-ascii?Q?t+/bq5+K6jPPnFTbqlEoqXuQvWRsazN6irJP0JqWg8gsZ2IKz6Rz6/SaJWZn?=
 =?us-ascii?Q?OLIxYklF4mi3UnB62QSUVd+buvW3W4FOjmNZCJFdXU18rGgphgyp1Mtp98VT?=
 =?us-ascii?Q?MhXcGn+ffD4AiXLxW+bgP0m23E4t6qFwl3T8vQWcm1l3SRaXrcpwrlDe/r3u?=
 =?us-ascii?Q?duFLPYTlrUJxyr5mwaTHsM/gC95t3KG2RZOLj9Ccrx/4A6KJHW9t8MD06adn?=
 =?us-ascii?Q?5ZqUW8vfnilHpkaIbHgHe/ojpWSpiSAyvXRL4Q3o6ajIN91ResvfQC1FRtMM?=
 =?us-ascii?Q?k2zMONdO1K/L57ge8Mw/0ijkjuL0S3ER0p8lauU2sOD5duOJKUboMqiJPSrT?=
 =?us-ascii?Q?sscxA1zuk5yWjdGYO26X2bsjIcET3E2AqxOR/Hx6syYcb52EI8La2KSO9Qz9?=
 =?us-ascii?Q?6oPmhxe6EZgcERgrKcxRvqwrhmn4j6zytrp+SdxxX/w6EaqsLWcYL03JOpyY?=
 =?us-ascii?Q?kTxv0zIxdfuVD45ie86iIgGsGJgmOi/nvWLURI7t8Fo9HpUD11lFYJOhcgic?=
 =?us-ascii?Q?St4kHM6mbo0NeikZpAFiOvMO0U2z63dTFKnUYPGRP1biaaY9Opiz48GN80r2?=
 =?us-ascii?Q?edh/om6Mc1fXyPh1enfgxbyDH6WEuLc23mFSpNwGj68uCcb1k7gvBbbVo0N+?=
 =?us-ascii?Q?OUzgubIRAbCYyNDKue3KkuMR9zOFWyuo/TTWCyuAyzX2bxqy7S9JrpC6DBud?=
 =?us-ascii?Q?HYTkqVJ35pE7JDlCP2k1GRKpEps46zohnAn8mt1XzmUoCcKO76RcmgUV099U?=
 =?us-ascii?Q?4Zzdoz+Y86WxN/+dE9bSgKTUZxjfDlKNQXwPtcK/GMj3Q4LpYtzS+CR9UJEQ?=
 =?us-ascii?Q?W9/IQ6lQ+bkGUHzs+tLu14e75YgJlS+w9nfNOdXFK8v0FDF/JJ+ydZ0oqSOc?=
 =?us-ascii?Q?418558+Qp8Tt7qYrGaaylW2+lWgNH1jULtUS0itFeoVDpce/hcG/Li0463/J?=
 =?us-ascii?Q?zGYRr094vespp+q4hTCGqpinA2G45xykPNbYnzkJU/qVuq0PR7OkvbGClVaQ?=
 =?us-ascii?Q?09dom5OXpFsHWTve4hEGL6NOyZ+jCirQwmuuzJtf4X4FOrXSE2c448pWU6z2?=
 =?us-ascii?Q?VUM/ooLxtoRv6yWn4OZCE5E1eIL7EM8YNuhYJmoyE9f80WlbTCi6eqB1OJgR?=
 =?us-ascii?Q?irpkqaWlNla22vFX0KlyjAjI6XZcdkFS3p5rYQ4Yb4KIyWKaZQXwJXPeP2H0?=
 =?us-ascii?Q?bt++5YfztA=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	XoFjkY/PbIeil2Y6Ts9Xr57J0Aw7X0jx7izySwgTYvXRvzddkyIFPsZqir/ah9lw11R5P/plzXjr3985VLlvSEtPUYs0mXjO72Bu041Jgx4SLjUksIXSgOvYWMi92KDpmOCml+icQMmLz3B7Rx4TSFqoV9iujSVylz5VPkogfzqsy0yeHWMDvWec5fUtaczO8HaSFbai28rsiXJyIJ9RjQNyvtCyiDVZ/8ClBpVC8NBShIOONpZmEx4p+6Z+mHjeseE2U8CObi4reesQEDLP8blQvi5kLk3TWSJwszpm2O4dGEMxiiJovBFUeBUdaxhQp5Dfz/Ko3ZVIkJuNVgQkhw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd525be8-bf56-4610-0d47-08dea404a5f0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7453.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 02:28:20.6476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9bZCQA1/n+HdijoA0tTePoCC4mfXlmO9lf0qk6ItYsLnRDnHZJ0lZ/0L+Mik1U4jkSi8tiKKsa2x1AqFa+Yy2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6347
X-Proofpoint-ORIG-GUID: KpWv3tDpNezwaYeOoS6tTG_RIukvFcUG
X-Proofpoint-GUID: KpWv3tDpNezwaYeOoS6tTG_RIukvFcUG
X-Authority-Analysis: v=2.4 cv=RN6D2Yi+ c=1 sm=1 tr=0 ts=69eec9c7 cx=c_pps
 a=qH/fS2hzlQnCJHG7LpbWtA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=_fbxoTlDoxdIRCUyn_sA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDAyNCBTYWx0ZWRfXwKB7XwDS2W0d
 A8/xs3dcDM74WAaKEr5BvOA7LYAhMLXFiAJJp1A3rW5M4QkuCmzVo1tHSMhxzxhFWvSKnak8byB
 qvIfVMcprPHsCbpeD9m4Uhhj4Ebi0NHcfWHQ6hpXjGFPKXOEd8+fOpG6B6genaeAbSkmdOfj5TQ
 7vRdvQ2IRDyqoPeX1JWpVIc5THuzW5VvSw4F3bD22wB3D7x7jK90oPLxJVKvmgKKIV3FuyJAahd
 3JJcI+ufhnFRg1sNjRD6KB1jPpPKOCH4vrHkVueUSLHcXHDOE556DNHGNYUr5NKURwExljnSgQF
 oW9VzcGm9Fc1/bUjwIVOclvQMc5ZH+PTEnCeSDBbZSDUO8J3EQKWLz4sBYUi7zXt5qnknRndb1L
 RmQUMBULZ072BUNzzYkTDhDN7Bg9kjhgum+jT5JcOEafJDC1UNhvKMiEXCmH4PaHD2ObEr/dGpS
 phRCrr4Jif56zg5mNog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-26_07,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270024
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 02:28:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3822

Because "x86_64" and "arm64" aren't valid in bitbake OVERRIDES,
they should be corrected to "x86-64" and "aarch64".
On the other side, "x86_64" and "arch64" aren't valid MACHINE
name.
So correct the way to "only allow x86-64 and arm64 to build":
COMPATIBLE_MACHINE = "(-)"          => disallow all machine first
COMPATIBLE_MACHINE:aarch64 = "(.*)" => when arch "aarch64" in
OVERRIDES, allow all machines.
COMPATIBLE_MACHINE:x86-64 = "(.*)"  => when arch "x84-64" in
OVERRIDES, allow all machines.

Fix 1dd076d3a76f ("firejail: only allow x86-64 and arm64 to build")

Signed-off-by: Li Zhou <li.zhou@windriver.com>
---
 recipes-security/Firejail/firejail_0.9.72.bb | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/recipes-security/Firejail/firejail_0.9.72.bb b/recipes-security/Firejail/firejail_0.9.72.bb
index 10023c1..a240872 100644
--- a/recipes-security/Firejail/firejail_0.9.72.bb
+++ b/recipes-security/Firejail/firejail_0.9.72.bb
@@ -59,7 +59,8 @@ pkg_postinst_ontarget:${PN} () {
     ${libdir}/${BPN}/fseccomp memory-deny-write-execute ${libdir}/${BPN}/seccomp.mdwx
 }
 
-COMPATIBLE_MACHINE:x86_64 = "x86_64"
-COMPATIBLE_MACHINE:arm64 = "arch64"
+COMPATIBLE_MACHINE = "(-)"
+COMPATIBLE_MACHINE:aarch64 = "(.*)"
+COMPATIBLE_MACHINE:x86-64 = "(.*)"
 
 RDEPENDS:${PN} = "bash"
-- 
2.43.0


