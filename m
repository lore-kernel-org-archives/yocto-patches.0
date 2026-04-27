Return-Path: <li.zhou@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D409EFF8850
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 02:49:03 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34301.1777258135091078648
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 26 Apr 2026 19:48:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=kv3HTSwo;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=8577cf8428=li.zhou@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R0o1V7406719
	for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 02:48:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=IXLVChaALOEY2JsCe85p
	L2UALDlD3u6r/DIk3h6HPX4=; b=kv3HTSwocbTCNgLFpHKZO9mFXgoNqLaUIYaC
	AZTkZ1xYIHkTL8HTYnwkdyPnr74cD0KjB81dZ4vVGzKDUGd+qw/BGBgDFPaT5a5U
	L5x450CHpay39eF/oKwN6pvS9H0zvGCTKUUPU1PbyaJFXG1QjW6r/Ji/bwJskeiX
	LsNSi8xxIhI9ahKBi9oXg+O825+d70j9jEEwUGz/Xe5xpXaBaUK2s6hTo/G2t50X
	07bEuvFrupdShVrJesBU1N8OaNrWgSJiYZ3jTvFtTPKH0MDZ90Bvc0V+sfs6upRX
	CYSfes+jFgJ+N3SLoE+V/5nNWlSp5PLqW0PWRGbAc/rMeinExg==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010008.outbound.protection.outlook.com [52.101.201.8])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4drmk6sfka-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 02:48:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HgXSB6RuavXd/xyaTNXVCu1G3to/FAIEb1C6XerHmP5RURSbdZLugkUCKgbEVoSF1BsPwG8BbSpOicPcmFLU6lZKNpSfAoUIqyMcTF45HHUmiy7AiuQg+tVONNKI2SXwRGuwC6aXZdYxH6ERxkLZFvvKgQxbrBpCqmCv7LuJJ4miHGSjFLAFjPtUQmlqnxutD1ZNMSBifUPjKM0RRqJIMaKTJ3FtekiJvwjhu8jVb6VtzurTrZDnJU1k0fKJ+Ry5h6sqFizZboFtlw0Ouo/boDnm/E2nuesbzyAZg3Um3+j3mFs/0dzYe5+rL1P2+LP8o5MJbdyeFoY15qBwUNstww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXLVChaALOEY2JsCe85pL2UALDlD3u6r/DIk3h6HPX4=;
 b=B1zbCOaCo8cJIx3P6F9x/g7ug3rXdI3CL0AIuTYm28FBmjPewDyeZt/zIwbYlyckDQdWoVVRoz608vTKxwJ5VzmP547/TZXnD3EUBmalbIdcmBDFu/ZJJPUJ0ni6PkQWZdrvMyNUPPxw6lF+FL5ErxfzRuCLKhudtTPdUyk3KzqZ47mH7wRYo5GaJHWDlpID2ochXLBWqxcXl4Powt+rC8Aliiic+6O9BR63U2ustYUKrlrd+xqtNYJpP/Pgx/bTflPnpR7PxD2EQacW2ZVmhaI2m7khWJthY4JPWh40h2kw7klJHyjOgMoqoNKfyDk7JQx+dHLXXaHu5Tjb5KZEow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7453.namprd11.prod.outlook.com (2603:10b6:a03:4cb::19)
 by CH0PR11MB8166.namprd11.prod.outlook.com (2603:10b6:610:182::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.12; Mon, 27 Apr
 2026 02:48:51 +0000
Received: from SJ2PR11MB7453.namprd11.prod.outlook.com
 ([fe80::3198:3bc6:ec3e:b2ae]) by SJ2PR11MB7453.namprd11.prod.outlook.com
 ([fe80::3198:3bc6:ec3e:b2ae%5]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 02:48:51 +0000
From: Li Zhou <li.zhou@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH] aide-base.bbclass: correct STAGING_AIDE_DIR
Date: Mon, 27 Apr 2026 10:48:32 +0800
Message-ID: <20260427024832.997450-1-li.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2PR03CA0010.apcprd03.prod.outlook.com
 (2603:1096:100:55::22) To SJ2PR11MB7453.namprd11.prod.outlook.com
 (2603:10b6:a03:4cb::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7453:EE_|CH0PR11MB8166:EE_
X-MS-Office365-Filtering-Correlation-Id: 12e6940d-5413-4246-b68d-08dea407835e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	gHtJGwhQme2bTeHNHvLhf54vRDoQinL+5HNHdT0E2HTDSpZ9Nt0C+klUnYOgQs5HNEBTGi3cgoWlNDnqZMKtWjAxPJHUb/AuVKGlnSYzyTLKX5IsIsRTflQq5HEwqqhhHpyB903pMoyrjx1qObSE8qGgfASvBUGCorgdLtiRzXxWasdzU/5ZHLyUifuPhMmH3S1HeBl83cc67Y39QU2TPuvGU9A/qzzrNxHH6ui1sG8Ingf/GeU6a1N2NuTbKDMY3L3FgC7ODj8FX001DpOlpZd/jkYD+LP7Ykn7EHWTEh+08bT57vYtBdYsnNMSAsZzbWdhs9qFvjS/NnsombATIEnvkMaWDeNlYh18VNSqZcpZCVugHRD4XFb3d+EfcUZ/N5NiaFhC6q3PFb0CyZlqcV3SbEAGdi5JoKCrDz0ri5/dW7DpoYMKu6kHjIkl208GdX7vkkVlhH8mdARzE6w/tzXp7y5NAtwZWAxlyUryI+WaAKStqnTIAjOm6xgcSCGMEyeCyd8i+U7azFWySWENK9fqkF5pFLMzMGzgqC6ytTt53mLXSVyZ1837juYopdTUkyHY6VB8Yu48TW7vGJ5WObUG+Q+mvNxwcq6uwoJq7sS+UBh3GGLZ9mXCiWn7cXbVJGIntbO6jahyCj0fdCBkXD50Ge+g+KBdh1OlulfTIoZ8fe7FzerlVZlYPkSgr5oA35Z0d6wLWFQACFjoFf/hPd3/NAAw4wsXlbn9VbNSpcfa0h/YS8vQ7aabEOWnIxWDFmG18IFi+Yjac3HT4nfTEskas9mH9GWbE6sXVGrq3Xw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7453.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zAEMl+vxw+yE4Gre+sLRolygeTywpdpU0zmmwDcQIKPJps4GtQe+7qeHU6zd?=
 =?us-ascii?Q?+vtm/lLIIPuhZtE/+4zcUiFoi2ctm/sffjFVmwj+Ml9WXYnemJJuzXfOaX2g?=
 =?us-ascii?Q?DWnV8lt6wQm2OMgfRUryrvdbtf/0QkzFiA8Ck13bPmY+hxkEKAT30A8F7/wm?=
 =?us-ascii?Q?SbwfzjwvtVxENiznvi8wJPKAJCviXn1XAnMSsoiCiP1nLyNHcDzFk1G3D45x?=
 =?us-ascii?Q?psCf4boWQ3j50B5aTeVVWm1icoDV1/s6wstobrgZ6QqbYIcMNnly30F3flsg?=
 =?us-ascii?Q?884Cei7xgqM5ODN6p/Blhrrx5fJwi9M+Zn965tSj9RfsNHHBWh2zD2K/Fket?=
 =?us-ascii?Q?8qKPd0ZCrIqWytEVIl2cFU23vU5xKnoguZVXtNuqYBmyWM/qQG8xEnYRqwVv?=
 =?us-ascii?Q?cFWUvdH6lW8pQIrPTf3ICvraoBox7ODcW3b9apXOLDzqXyM/j95EmLiCWsU3?=
 =?us-ascii?Q?ITiris78WU74Bw6NeVAU61Q1KWG0Q7tQhDocSSh3jNx6eN26kczLfstuZJxS?=
 =?us-ascii?Q?ErPj3hj4xUZrKBv4XJY93+KpxB6fZHa6meXxH7tcq0xRGbdBmZOlGLRP+8aG?=
 =?us-ascii?Q?6yDbDbrOldb3VlnmQ8qTkfLAvD6gjRdzrdc1VxblP+MGf4A729QrZHUeitVK?=
 =?us-ascii?Q?4j6PwUT9MXDFJy9sFdYvRYvfLLgqxignjaY30frI1U2KyxAPI2gt369USPA8?=
 =?us-ascii?Q?HT0Qk1Hm+XvqvveQWzpl8bxOgTfVfREzJc4P9u+IeQPd/S7Dx2sTzlvFswqF?=
 =?us-ascii?Q?dXbQ28ImNGNsqtI+QmoK10QFF/QQk6qPIvWQEVwVbvWUjdgclAGiZndSoVv2?=
 =?us-ascii?Q?c5lkQb9psCXznqe38J+1ZvZmY9DHMLzPhp8GetaU8KWJDyC6gb9EpJxvHj5A?=
 =?us-ascii?Q?4zrS4/OsMIMVem8lqlsgm0dt3dV8AAjKhKb3fpxUp2a+jv3/xbUu6BSIu8NL?=
 =?us-ascii?Q?zPvR91aC1+keABYh1Ag4HPFGXe0Hwr3fIfsOR14VDNHBRgfWv9P5ki150a+C?=
 =?us-ascii?Q?ZHFQfAfCcAuuFNo0yevdS9qRL82B56sl9USP8edjviePxNKIL1TxDJt7JLUJ?=
 =?us-ascii?Q?UxrAn8XtnVuZ8qyehT6+7H6DqY8gzFA2AbadL28CtDK02S17H4b/DhDHPsMn?=
 =?us-ascii?Q?LCuZGFy5Ldl13LqUYyZh/g+EtCrc/UmKvnke4LI3R8TT3FaCI55rFKNixNpa?=
 =?us-ascii?Q?2UVH3n4oSUf4GCXn8raXBs7edLijTXmA+JNOA7cMriw8ZJn6YrQX4NriYDNT?=
 =?us-ascii?Q?nhwQ6T0QvsuzyvYV6NsySvEeFnfp1VVCUBEmcnTN88MkbQzg7/JwYrluLwGG?=
 =?us-ascii?Q?Gvnedp/N0T1JmtkNtKQHeQAoKp9X8x74OudfuU/+9whfZM9AYZAzMOwmGZY1?=
 =?us-ascii?Q?mPX2JkmsaGTyzIr8QC8Z4pCxYwU3TNPnUxrKmKopGwhgbZQrQcp9xuVfBmjH?=
 =?us-ascii?Q?6S2zoNEtwUHxrU/+Eos1wj4tyQMes5dUjVUkOWzvqggwFrFe8bJAJ4mUch/Q?=
 =?us-ascii?Q?7DXSN4Bv3aDQ8ncAABNm/OybIQ9XcIsE497MfqxQyMplwzzYoJIV1f8vOl21?=
 =?us-ascii?Q?HCDXji6CnX/G+RpTZAPtNWKJeiOC7Qlsfx7gVYXZC3Y6my51xAZV390OJHzo?=
 =?us-ascii?Q?saPeUYZb74zmq6/4K3Mqa5ripO+KEqpjM3XLt82HpEn09obW+ryBoS8/58U7?=
 =?us-ascii?Q?y8J0OArq9C3LQDWCfmEKBaNSfRdLPWXDaT0+J159lgSvCwhwIkcmASsdCUo7?=
 =?us-ascii?Q?fxS0rYP/Qg=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	Cgv8YRWy7yMtSh9JwLGNdKmoA9LJAAAeppWPUJGhpdk+XH94vrmTvF7eoWbkxTuGUVPe1rTEGF7rTLhHC6ukpG7m6qqFleEjA5JozAeRy7vZ37A5eAq1sUMwK7za261kNxP1Pc9TaXyhxTYYSK5rwaFQdvQQkzRldLODjlao4R6BE+yux53YD1fs79hKkqJYhVJvS/692qp+AdF2A50qV3E9B0WXL1BhZGt6UXt2Z7seYFij70f144YRLCiDQUjXFUF5RboJmIzeAkt+TU2jEcLDDbGWfSc4C6Hkqud/NFRfdBt2OOfx4GFGKSAHAXr/MABdkeTka6Mtakbh7aCQYw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e6940d-5413-4246-b68d-08dea407835e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7453.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 02:48:51.1460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5mB3Kdb9hfnZnBGHvF6SLggwyJzUM3hruJg3soPH7DgPSUwzfYmQfDmE719Jo+5NGnwfkii5S9Y7nOcUEpVaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8166
X-Proofpoint-ORIG-GUID: TEm36bf79-5wxzWPaeqXdqFUhiZ0ocMY
X-Proofpoint-GUID: TEm36bf79-5wxzWPaeqXdqFUhiZ0ocMY
X-Authority-Analysis: v=2.4 cv=RN6D2Yi+ c=1 sm=1 tr=0 ts=69eece95 cx=c_pps
 a=5av3elwsUCsOTZAZyay1PA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=pGLkceISAAAA:8 a=7rz_AmffuHcXOf7JQMsA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDAyNyBTYWx0ZWRfX/OO7drneiZYI
 SOIGAw79pMYbilUdL/WM+YzhcGLZFIeSu+hcExIjgqljQAlcwbWFp+klNHDCYvjfVBI6IgXVFLp
 x9QHEGzNV0Ty8/rAJeBuBbOUxPFaQWkjgMeOqJdQ2wXmOIgeHIZoJJT9LtLgxSyeEdEpTxWTaQB
 PQi9KErrT52HMYOblbD8q6m1uui7T3iKsdzzj1xI8r8yrHy2n7pykMawYgIIEvkMDSENdFH1I4X
 /liwcsEtfe+cTtlATph2arl1WfzuhUydntUC+2EYK0hb+X0kxqbGb10eW+hJNVKnRWhKgV5D6Nb
 +OtBt5O/XLWr0nPzsTLI1Ooe+DUDcLdWf1tfciHvx2lzrIrf8RY/bCe1IwbjIn7SHTQ6FrYKWwk
 IlvX/YQDLJlerIgdPXG9urVenmDcmNyzDoZx7sDlqgSPv2L0YcV1HGOU9+CG35vEsIqt6qDQYKr
 u6QxKPguE2tb0+FsnDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-26_07,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270027
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 02:49:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3824

Fix the typo "aida" to "aide" in STAGING_AIDE_DIR.

Signed-off-by: Li Zhou <li.zhou@windriver.com>
---
 classes/aide-base.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/aide-base.bbclass b/classes/aide-base.bbclass
index 36cc454..9d9472c 100644
--- a/classes/aide-base.bbclass
+++ b/classes/aide-base.bbclass
@@ -2,7 +2,7 @@
 # Copyright 2022 Armin Kuster <akuster808@gmail.com>
 #
 
-STAGING_AIDE_DIR ?= "${TMPDIR}/work-shared/${MACHINE}/aida"
+STAGING_AIDE_DIR ?= "${TMPDIR}/work-shared/${MACHINE}/aide"
 AIDE_INCLUDE_DIRS ?= "/lib"
 AIDE_SKIP_DIRS ?= "/lib/modules/.\*"
 
-- 
2.43.0


