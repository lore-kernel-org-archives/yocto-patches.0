Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDC0FD063C
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 06:48:48 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15110.1773211725654673695
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 23:48:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=HFpC5VcT;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7530ed8fe6=qi.chen@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B4suLi2787197;
	Wed, 11 Mar 2026 06:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=Iduc+cqeeDpnzhUhg8U6NtkjFF298dJiFEA+0W5nCv0=; b=
	HFpC5VcTHhy0JfY1X/hCo12UzghcNMoXeM1WLWGgxJ+ybHUmJj4Pcs1Zi5aXu/07
	BSJqfoyrDFf15CYhN9d1oAJhvDKFWoyYl1faE0+bSw+uNGTWqkpqnFb4u72WP0FU
	YvwMF6YBnwyPd2uJG+re8byAj67kGVqCCbO1I2NFWLrHjGAMeGFLNs/vO+bFlovo
	J1PK1klsCJbzYQ3Xk6/GyuMJ/CWzFvXdvbx38yWGVdH8iIBEq3Rd0mxBdB4d5N6M
	KKeRoKso/eRDy+JXo0wLFT6WeLQDiumv9OGJgH0w6mQYKaCN+OPSONa53n5D51zu
	Qvz3zZ3SAG+uopXqPz268g==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013054.outbound.protection.outlook.com [40.107.201.54])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cty22r7gp-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 06:48:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXwdrNhgQp19AfyHNGT3unuBx0bGzz9xdZjx2YBm9ZUKjpDzD/xVhhy0bQ4PD9ckiZ9w6GDtTQpwLxbfRuFPfq9dYW/CU8q5wMDLormwu31/V62QiXhD1IJFHUb4eb6EpEY+MOCzReXgic0uVMPmGQqKbsUqRGRdcIJPOeKoFLLh+gw4fQG/vLrA3+PAO4MBeU3AGXm1MauzH8qf8t7OD4YbF3rPN3aFNeVs3UZOSY7bVvxHTQVs3uEgUIipF1kj3j+aQmtgh3fXs58IIt2TBgPdGA+wJoDNibw1VXWLbZ7n0CLObm7oNrS6QSpLZXUN2BGzNZ4FA7/NK4ClfS4hmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iduc+cqeeDpnzhUhg8U6NtkjFF298dJiFEA+0W5nCv0=;
 b=bTr08BvgnjU1OvNEXBl55ZW06fXteykv5I9Vd6oCgz/CnzkRPYrTLZNfWvmC/G1oZss3ZKzbCvupmKXf5CIXmFTURTPe795XppHF03a99k6gXEoeCQY/0KGTaClt0dynEIMLtEq6H37rzIxOZtD/oRUg8DCYC/YltlDCekr+SK09GF8FR7AaD2warHwlp33XmqwZKAL/2AVlwDFZ6K6mz5PbPPASCaM1J6atGvNUh9b4rA4g8NpFTF1qZgnSkZ17huTISx83XcmYjB4eSy74JiIHfYZWYW3o0UVJHVodbBm61gbgGY8fIN1vQ1iz3sA8qSsyyom7/Tlj4ks7A9wvuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by PH3PPFD01EAC3BA.namprd11.prod.outlook.com (2603:10b6:518:1::d4f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 06:48:42 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9700.009; Wed, 11 Mar 2026
 06:48:42 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: alex.kanavin@gmail.com, randy.macleod@windriver.com
Subject: [auh][PATCH V2 10/12] upgrade-helper.py: use global_maintainer_override if it's set and the recipe has no maintainer
Date: Wed, 11 Mar 2026 14:48:11 +0800
Message-Id: <20260311064813.619683-10-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311064813.619683-1-Qi.Chen@windriver.com>
References: <20260311064813.619683-1-Qi.Chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0181.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::7) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|PH3PPFD01EAC3BA:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b569e3c-b779-454c-c98f-08de7f3a3c00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	ARnOLDRZ/w8Q79VPydoGQ6T1UIDrf3nnh5hxQ/YYWhEIf/bMtepmyqQTchG3eMAhk5XEsjQrZsD2t4qzsPeTV2Io4vfNoq3NWsQ14b8LLf578vcTUY6Sl0IM/iFmfF3oywfd138mvZvV5RMQg8gm2FaZiO8mzJ3F5P2dDBOHtCr8kxnLeoBrz/ft6j80zKCUND3rtCc7MtKJz3j0jsG3IEWYqrts0DIkhwKv1RM+ezTuL7ZxRIcmF+GRkASxR9wYVqjiaHqhknqWWq7eZT4Et0Qjg0zrfEHhouMyLGcXY7wjUvhw3LdqtU1T4nh9KIun/EjHmsrLC43L4uOHf325QflMy11iigBaUEZT49if0RjBrROmksEE+ho2tes4Kyt97LcxEVE8Apvn9cfNFIxw99S2YuSiqCJ59sbnDW/Blw0u6DWUqlCSbWRSYLrhA8cWlbqJoQWIz+v+6CWkcp3+Pfg9eD2HlcV/Nkpcq4MH6Exc2p1d9K48Dh5OBN8tisXtczSTctgsUCX+Taac5on1DzZ6iK0mcoz70U+ht7YZEEWxP/7qIsA1Sz2HO9IVGRIaDC25ULjarCqs7oB1T0Ff2FvmQ+LXhEWbk/yYdKF4gv6DfrwxlMcpNsJTqgoliBpCzGzmGPnxUWz1246xrhPFmc0KfOH2G9YOx+bOZon4ejrJdPMEvOQYZwbJ9EdhHKfaik5p3Nl7Oyg5AG80lIvpvXE5PT99LMfqB0y1UKiuycf4Q6Sfv2BQtLakX5fJsBvAjdAG9cFZnw3acNQJ6g1drlTHun+spugT2YXs2wUHHIk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?NGpfO1fFYVEn9VNuyi4oME2hw/9PPPuM7XK+mXuw1GA2jAJPjGIT+GbKtlNy?=
 =?us-ascii?Q?mdntpvIj8ylMjKdhSJFeUKqX6m2I6ds+ZKdspFEGznPqjgJjBgrjPjgJKzIm?=
 =?us-ascii?Q?aBmqIVumB9FeO6CJMCTHqTndaMy29yNLu5CzohRo8IcTfKfTww+CiCxdLrrZ?=
 =?us-ascii?Q?uhO9b8Ys1f1zu3PvPLE/xrgnScgPoi5nqdNmi6GJciPMPAHl4av7yYKs474c?=
 =?us-ascii?Q?DYL6Q8P0ViDsXNiG8o+7j52oM38AwwfHMcrgmgHuvueWcCoBJmTFjun5aP3f?=
 =?us-ascii?Q?xYc3SRqJOEr9PxwBIwynIBOmWqdLtf0KoBd13xSn9NwH6CWDiq83VQ5XAnjK?=
 =?us-ascii?Q?xIr/E6hlqGj3bxqYhr6scc90H+qVS9R0nqEk+T7pvUi/Kq4s7amN+K3ltT41?=
 =?us-ascii?Q?4TqDDVQUKh729W1sQCcevdi1fXzc5OLSn+MKa73rkOYYqL2AE5vPOJTrzAyo?=
 =?us-ascii?Q?gyj4Q8vbrYUguII5dILLy7ivUAHg+DvxTDvQijL3bmQUHQk0827jhhtrrsab?=
 =?us-ascii?Q?msbnD3Jxp92Q5ebVddrcxiNghZT7CRqFwC1JzclT2mMKaVgBg/GP3kL2/1AL?=
 =?us-ascii?Q?3mb7QSXn2XfqnpMwGHxGvIYcIWdcDFQfGKpRscfxk5BPrUJiTzuAUzAJ3RgV?=
 =?us-ascii?Q?uZZeauPcptJH1wC88xhv8KRfX6tFuVxCk6O3zu+YcTpWKR8tfgYkkeV+BdNI?=
 =?us-ascii?Q?8O7ayYGUxE9kTKKlBjTm0Myocm/K4hDXEkXhg9Aef0mLIrckU8wTvRqu9hnd?=
 =?us-ascii?Q?PiUv/9/spWSzaKI1m7eCA5NhJp2CEk2RDuO0BhI5zs2xXMkaq8cmIMyX/Uz7?=
 =?us-ascii?Q?zO0DHas7JIvDPOulaw1d0qugtEukutDc97A+nscr8TyA9LMNi+y+icg+nnYt?=
 =?us-ascii?Q?dPC6brTgBob6BtS3NVheEXTgAzaBqKXb9zGypgquS7PuZfx3KYn/tqvtsMyP?=
 =?us-ascii?Q?IuuyRUeGFNwgEtZwdjoINU1ePvcfXZpz5CwDFuvZOw4egyz/Ix1n/+/y/tnH?=
 =?us-ascii?Q?rIo/wU6MoQjKlc0jULyBEB4tmfDhuI1BFeE7VEAgwjKaj53RIcnZXm+RV+n2?=
 =?us-ascii?Q?SaMfvb3fi3BKVR7Pblw7KiCZTw8XQX3t9wnkXKkUgKi0q0D/qmOE5+3bW7xm?=
 =?us-ascii?Q?3sFESnWMX8sYTWCjH8rqMKLlHeenU71F4ae/lPPyKxiuJUlFVTz7JlaW6j19?=
 =?us-ascii?Q?haM72U4dFVE2YoyiJ6GFd3B9922PqixxO0QFqqJL+WcEARjNRp5H6OPjeUMp?=
 =?us-ascii?Q?hvZSFZgdrZGxZ4jvICJKu87v86zHJeZsZvN3NnbONh/DWq91qwcROH5RLm9h?=
 =?us-ascii?Q?26ZPDj/jGGGY4NyZRhiwLD8bPT2/9sGtbEoZ75M+ewPPgKTU4ZHvGTjJNBwq?=
 =?us-ascii?Q?YF4VNEkAurb0IY+ETP3FHBvgjZfdB9QUI5KI+5SDUfqn4BXpYMZ0Bq2/JMtj?=
 =?us-ascii?Q?A0hwz41D/QDaBrQJkTlE8ZyHLj8cG/ojcZ8hQIvGUyD0cG4UP/XZ+qY/Hrlc?=
 =?us-ascii?Q?pcQiNFJb5e/JsIpu/usgHfyRLF4PSA9+AxJa81L19+VdiqDd0CmMHPV4WcnX?=
 =?us-ascii?Q?izU3YIzrVQgf8IHP880KD7R/BDsd3PsoY9RLepLAvRuGjjVBEggZD1t2z00w?=
 =?us-ascii?Q?Xmo5R2iqC8QMR5+J+u2Nq8X3h3K4VSffH97IDukxDWP/P/+RACh8xoF7clLB?=
 =?us-ascii?Q?P5L/M8BNKwFRV6J9qR0D/u2C8YFYoOiMd2hSVJFwY4EMdiPoA94LXSODUn1T?=
 =?us-ascii?Q?GhVJUArMhw=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	EFZQ3iuvwMg5HWGKPeiY7oBv85H1SQ4GtAWCmE9Gq5xyLV8zN16Ld31V1a0g0TuZIzW9b0V99FylqPHVnAEtQf3zsBayEicLR6fWVCrwJBnlsd9bi4QOd8zNTA8luo2wkbVYhKNjvshFFBVYSWySPPserbYOJmzED9MoIuVUVuk1fRdPtHax0huzdGFG12EULgsguzH9v/79giDUnYzXtcG8g/++9BqgLaxzX8gUm14etfcUbUJlzEuUkI4202juBLEWFSbvPhGIs4qsJwb3NQoBnL6G3wk7PKmhwfFFFQpUxaOnbYDBZ3AxzQGFL8k4yCHvMZCm4gSn/ZG/QRXTHw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b569e3c-b779-454c-c98f-08de7f3a3c00
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 06:48:42.6632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +q+BpQIpmE8rU+13uJFg1VmTD1T0F4ysc5BmnvUyskPsCSQlMewRGtTiWZnhxAyAc7XYfdVOuDATy3SN4QRZSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFD01EAC3BA
X-Authority-Analysis: v=2.4 cv=LqOfC3dc c=1 sm=1 tr=0 ts=69b1104c cx=c_pps
 a=ikWRpWbkSoEIfbFFe8At+Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=slLyD0mBEoi4DCJX:21 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22
 a=t7CeM3EgAAAA:8 a=43dznphUI-UhAOROJDwA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: C5SbSYVXnKEfR93czqDm7ucJKSWG_-Am
X-Proofpoint-GUID: C5SbSYVXnKEfR93czqDm7ucJKSWG_-Am
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA1NiBTYWx0ZWRfXy8G/3Fj+qwbh
 29d+D/z9oAzo/EzvOOhdhe/ReWrExuVISikzQUc32Y92mLY0VnfbTlB/T0Z7ApxCHcXOwlZ1AcM
 njMklIpZ2SUOGa3Uamwz3EsWmMJTOa1zVvsDc5UWiVbyHGxSqSe5gPziXP/I4xk0bmLyRVyVO2F
 g+K2KYCEf7SbqMww7fo4XiHs301erV5UREcYu1d/KlB+q+MFMffi1vrDIwCxPtQFwQQ/rcTPMtH
 26wuuGqzK/rXv/KpK0ATg2P/xN9Ta0bS+COogkYMVwRD2ehaBFUv4CNiISYGPKEMFcK6sUwMOO+
 2jSq4lFqzijuQxkXsQgD4MJlV2rJ0nkSSAqFRLnAP2oAWML7vRZdOq0jaso/LF2AvsfVNF6LtHK
 eq2ZlFAwrAtKl0iYiynqeUXqAKJpMEmintcMcAPIL4bWyg6ql/PDNVSefHQ4vi4l0xrajcu+klZ
 WjeuMMtoRTwdiy59C3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110056
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 06:48:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3423

From: Chen Qi <Qi.Chen@windriver.com>

If a recipe has no maintainer, it will be skipped, and there's currently
no switch to force the upgrade. Note that for recipes out of oe-core,
it's so common that they do not have some dedicated maintainer.

The global_maintainer_override setting has the meaning of sending
upgrading emails to the specified person. When it's set, someone
must be using auh to do upgrade. In such case, skipping a recipe
merely because it has no maintainer does not make much sense.

So We could extend the meaning of global_maintainer_override a little
bit so that when people set it, recipes with no maintainer can still
be upgraded.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 upgrade-helper.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/upgrade-helper.py b/upgrade-helper.py
index 9920126..8589f8d 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -712,7 +712,10 @@ class UniverseUpdater(Updater):
             for group in pkggroups:
                 upgrade_group = []
                 for pkg in group:
-                    pkg_to_upgrade = _get_pkg_to_upgrade(self, layer_name, pkg['pn'], pkg['status'], pkg['cur_ver'], pkg['next_ver'], pkg['maintainer'], pkg['revision'], pkg['no_upgrade_reason'])
+                    maintainer = pkg['maintainer']
+                    if not maintainer and 'global_maintainer_override' in settings:
+                        maintainer = settings['global_maintainer_override']
+                    pkg_to_upgrade = _get_pkg_to_upgrade(self, layer_name, pkg['pn'], pkg['status'], pkg['cur_ver'], pkg['next_ver'], maintainer, pkg['revision'], pkg['no_upgrade_reason'])
                     if pkg_to_upgrade:
                         upgrade_group.append(pkg_to_upgrade)
                 if upgrade_group:
-- 
2.34.1


