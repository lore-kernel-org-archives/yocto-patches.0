Return-Path: <peng.zhang1.cn@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D7BED7B8C
	for <webhook@archiver.kernel.org>; Tue, 14 Apr 2026 08:04:13 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13775.1776153852536437970
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 14 Apr 2026 01:04:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=lCLIwVJt;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=8564569539=peng.zhang1.cn@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63E5VJvV3761929
	for <yocto-patches@lists.yoctoproject.org>; Tue, 14 Apr 2026 08:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=7e7qkGKIZCBffshX93QZ
	nMRvPJua4dJkCTbvSui5mK4=; b=lCLIwVJtQ55dVQPXH++KcwCrR92f0w+wIRZN
	2rwJwknYUHKhaPdP+oH1C611azuZhCUrkG6tI3VX5IzK2VrQSMIsiPqRPp591KKl
	bJFyYh2BlK2j1+Tsj4RU56Q8ElwUTh7jWvn2Wccg4iX6tKyPjvLjpbA35eCbI7+h
	sCublcYLCHxe++SPLCPTrgzL+Bx1fEW/zMYuTqgb5Dk36mhpxVLKs+b2mxlMOGTI
	INeADKAFiS+VpFwIGr9KRoi1VZBSCqASmL2SUr1Wt/obWvfXLhj4ei05BZjtUbAL
	PsokAHdSMQu5Dy5hT3lo3C/ocICpfJ/zBfmVi4abN1xl1JbhwA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011040.outbound.protection.outlook.com [40.93.194.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dh87a8f2e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 14 Apr 2026 08:04:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJO6xSxnMN/vQzlz22qnLSkj4kBqkFP0sQW7XGbsroRpjtcTogTIw7IGORFPITlMbpdo96059DRao3ztuwpU/h5/YmQUp3BImCKNzkyamLXQZCs08Y/3q1sK6n8ZwoF+fYwHhhBzkunzqgrg+QVP0bw/nzxOKnkNon1HOFlktZ96I5s5lCMeidV6Tnk+b/0zUWZamIygb2dMKIPo8MbhD8DvLqJHRhJaUsLvD7IAxMnbqZO0CT+vPgN3qJ2OwsYoSLsNjWWcbH4FkPftLO+da7Ju8HweipAztuYizFbL5M46/6tMWjaf+sl7cBUQPKpQE68mkp/Ymmu7MdV3r0pAqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7e7qkGKIZCBffshX93QZnMRvPJua4dJkCTbvSui5mK4=;
 b=PFcxG1JVHAgnRSA4viey8MqoqgW0TW4NTfXuL0SGhFqG2gZFbZcVCt6ukl88P9IF8GRlufaN3aw796e2rHpmibC1N2Wm/Sc3EhBTFs3Clo3wmYlPWzk6n2QXTbC5NNLs8wOHR8ANJEcYo8imLgcTeDVpV1PSRwsL1kTSfTlUBSPvPTN3TEExojrgWHxsxpPTylciC17upWjwal0AS7l9d/m0x+1qxvv9IMyLvnBcjbTyy+uJPU4btJF3ONhNnClq1uriAsgI+SiqFmYiXKKlEy4FvjgZPH5J1Asy4/+1oPpORTDY8yhBap1ywG1AYhiQ761eLdpG2QEyOK9+5snDTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8562.namprd11.prod.outlook.com (2603:10b6:610:1b8::13)
 by SJ5PPF1170C8165.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::810) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.19; Tue, 14 Apr
 2026 08:04:08 +0000
Received: from CH3PR11MB8562.namprd11.prod.outlook.com
 ([fe80::ea76:e083:b8bf:7484]) by CH3PR11MB8562.namprd11.prod.outlook.com
 ([fe80::ea76:e083:b8bf:7484%5]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 08:04:08 +0000
From: peng.zhang1.cn@windriver.com
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH] meta-security: fix incorrect HOMEPAGE variable names
Date: Tue, 14 Apr 2026 16:03:57 +0800
Message-Id: <20260414080357.925722-1-peng.zhang1.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0347.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::7) To CH3PR11MB8562.namprd11.prod.outlook.com
 (2603:10b6:610:1b8::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8562:EE_|SJ5PPF1170C8165:EE_
X-MS-Office365-Filtering-Correlation-Id: 565b0bcb-6b2f-4989-ca4f-08de99fc67ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|13003099007|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	eXwJUeoXjMJKn1VWOnOslbhxQ69cXb79ldiGotX8Qc+RobQo8PygeSBbCpvqIJJcINbwL3NsR4t2sFanxDqRtlRaAbIOwUfWal6AWnbfDBWnZyI0sI9shkcBxF72F7iQCitjfqevwQlHISOIBtjzGbATgiNQX8KiZzqaWKpsbsyiDWOxfgxLgVUSftk4sdOdU+OhDQpCrcJABPz4/mZC0CqU1mSgJMARSbhyPPM55RyYmwIAxlP/tcgt1YhglJzdtVBiKma+Gkx5XOBpgHrI6+Np138W9oopT9qJfkn9bRAcnimkwBH80r9HKB7AEzPg0vr9l2kfTI2ybJBXS3nICP/an22S/+gaJ0XeS/FCjy3or49PRDEuq7BATbMLcXtmgVOJ9AMxEjAzBXib1sP1aRJP3G3qdHt/X0eUvooc0Lg7OYjaPrvYdtjJdy6RVUIHSkQSwKTzTgrCpJapHr7Q9nIEAfaBPbDPmRVe+aHatXK/pLnECEyslRzgFCF5KAgXtX7Ne/aZcup9B/6v0EbiT85ZsE8xSxIwQguGLI0a0+iucp4Fn7ZrEixqC1sJ0qqYZfNZzxt4p+QzgBYV7ui+MoW16z8Rnuji5YtXGY2cuF3+Hf9e/sACZCydCBwwZRKUPm2aDRLT29aFydCO0B1f1DP/wvdmv+x8Fnb+udEAGja+d5KHvlK96fPOiXyL0hMgyEtpeJLLduVKSWSXyEtKmJAVlgpjZw6htLER6YF6QuYnv+KS7fGQ44Va8BrQKYQR
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8562.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(13003099007)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?iLDf9uTO+TXUdG3lCuobOFF9YJdSg0gze00vS7jvyVAoYKuNKM4IrM0pa6Fp?=
 =?us-ascii?Q?zIx02VV/KRbSe+47AOqHG68+5KKNY4bhnaKFIN8aSfyOS6ol5d6AI5fEPp+A?=
 =?us-ascii?Q?ttHAgemAfFMyD8XZd1C0i4whKK0zHU1qQ0WLj/86J+4HK1YWudZ9jPMijwn7?=
 =?us-ascii?Q?EnOAj0+oskxpnMlkA2jtTD46DOG4Ejs9S5H+wuGOnyvB+B5XVbBTOYwel102?=
 =?us-ascii?Q?nrI0/QggGCiA1yqvxdnd+WrtjsH4ZcSJcGqtqJfdu1XxUp0P1rQ6ttrSJVIV?=
 =?us-ascii?Q?c4crYFq7NFk1X78WpJjIQHuJclP0MPo9cJl9tgznWXhxO/Eum3ak3nLyetVX?=
 =?us-ascii?Q?jbcWR76z+y4c/xeKEl3thCjQ+/rvXISMetUGOLbq/hrHngHFHgjMTJ/jwDcd?=
 =?us-ascii?Q?qJKIFADlqXHT0Vi4naBAqSsrmacGdgnGyrjMKkXUkFRHmHvbsUVT8cWJt5B/?=
 =?us-ascii?Q?aLpNXkMcDoxuo+ZjwRe/4xJ4l6aG30CLECfa5H+XdQTxL+H+yAwcaezqYWiz?=
 =?us-ascii?Q?UmeqgPPnFfIeNfeI8ZIDFX0+DmqabmEa/5+OY52DUQY7+gnMrKJbPqApiXq4?=
 =?us-ascii?Q?iUS7Ku0K7rkS31eZAlp5EtdD2PSKap2yrGa679j5aRDGQRtz4IQqACRFGXp5?=
 =?us-ascii?Q?+RAwBlDMbzQExD+zuvdxaLdqs8MW+o2iRJdLti7USAcQLHnRYopYe3S8fdnL?=
 =?us-ascii?Q?UJsfYTAIGhESQE9Rx47t+r/uhli8LD7kpYwa2D26QYypcqggfT0D3ELx7kpV?=
 =?us-ascii?Q?qJHb9MyKs3NR5aRgfv72LLTbkxr8qtp3tGJVyZn36wQE+zNifksVtzaR2WVB?=
 =?us-ascii?Q?LLcKtknn9YpNXJYauRLJWugaKPBVh1H0yT+xAI5WYRXLFbMMaXTX2O/0OwZM?=
 =?us-ascii?Q?dyH5iU6XtM1s+0tOKDMVVow26prTBa9JgP8w0qypDQqbC3MDbh8pZac/ee5Q?=
 =?us-ascii?Q?Jbo+0XGxozyER9chxzuGGtwNc3IX0ts0Sq6lopDLatGqXHdOrO4ovDn0G+xb?=
 =?us-ascii?Q?cJduy0rhuLJQZR2nCIK/k6kM2SCvENTQbchYa0RU1l3+up03AtXqMvi5DzJ/?=
 =?us-ascii?Q?5io/JDDP4fOYma1MkEcaFYq5Np2FvAN13Y2MgXM80tsVP0rDP4qh5YM0qbU0?=
 =?us-ascii?Q?JrJPzrc9It3U4oCSbXXFLfrgRQvKqB8/qnBsQgeb3t1ACJUVR/VlLSE457w4?=
 =?us-ascii?Q?MALXB7NYdULQDYgtwUfGAq7XlQ7SmxycXfV8nKbmJQHEx7WjEprRw48qVeAR?=
 =?us-ascii?Q?uC3kSzZWZr9qMeflDDTUSsPDDdHt7eLrlyg3Ua2GMdMhfQl4waF0i6hQAcQP?=
 =?us-ascii?Q?cJW9ER8LKZNE+oWhkelav9nL97DZYPIVDuNJyxqAfBYE+4d6Tf3SV2/C4GIA?=
 =?us-ascii?Q?VzRRI9A5DqlVoFc3VNcFhMpMd+E5H1GwxCxPwEaGjQ/itCKNo4U5G79S1PH6?=
 =?us-ascii?Q?sjOWm1WhXfl5Ww2obS5Ion6czZkhHFOPzw1IXmSIrt/5uuUS880/OhphFHys?=
 =?us-ascii?Q?JsGbZlcJyZpHXA1zudXLEZukstaqJHPSxwR9ka+iVb86DkdGSMEfOG/d7l/a?=
 =?us-ascii?Q?+sXKJB+HV60gNn53BGrM47zE4+kXT9Uqj15zlOTjodzvzodHIDdMrBIaDGpL?=
 =?us-ascii?Q?PcaMPWzhyxcVdtMj8Lzv2SMyO8Lqsa3pymvDX0Z0jGK1z6JuPDKxgLa8NErj?=
 =?us-ascii?Q?uszI7E3xcXczYg0l0SG9osp59tMa1ohtccULhXPDF7dfRTYTF779Y21QwC6o?=
 =?us-ascii?Q?EKf3gfFPweSS9SDBb/9uvuro+hJof8A=3D?=
X-Exchange-RoutingPolicyChecked: 
	fQhRcV7lIEKNp0n5P/2wkx4SqUAe02Kclz7YNKNQnPgkeK4rItwVGLT4n559L6hQ1aYb802DKP/GHqAec04F+rbFB8IoLl5qOG0HjUSbSZZfaOKsvjCixDDDKRO6lrrn7Xi7VuqJ9lvnW5E1cIUf3qgn2xCCUwAJXZnVxQcjUaXb8shQ/k6G44/q/iVrW19IaQZnXt8/7otAOoNMNaP5+fbZRSQDO4LRvyezTncjA5n2R97VeYy2OmQZsxV7lT3Hv9QgcHAU2iz5quiW9nSkCYnxDjT4C/U3iyAMy6nzvEwgQmLSFBozi5wkkgfJITWEbqHsIsUTXGizm7zRAdxoXQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 565b0bcb-6b2f-4989-ca4f-08de99fc67ca
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8562.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 08:04:08.7627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pm4ocf5cJDAY1/HjxrlRsZFR5LXIT/55QzY4U1zvk9WgrhvXHMjsJGeB+ZnnS8hcNFt3Ob86kDLKlppL+sIM+2mC821EEDXgQdadTWM+c/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1170C8165
X-Proofpoint-GUID: NthTNmkNbCVIcwlRxNhK_So_9XtGlHqQ
X-Authority-Analysis: v=2.4 cv=Q4jiJY2a c=1 sm=1 tr=0 ts=69ddf4fb cx=c_pps
 a=lexSm1xfraBw67q2grWtcw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=CWYfyUVCAAAA:8
 a=5B1P-IGBAAAA:8 a=J35dNKfbAAAA:8 a=NEAV23lmAAAA:8 a=t7CeM3EgAAAA:8
 a=-h1IrQBtcLtun0eN484A:9 a=1VeIQ1mWMp7PqO1uulY2:22 a=PcRJL-ISiCqaXG01ICqs:22
 a=IAy1iaPFTG6ydDzXQ-wZ:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: NthTNmkNbCVIcwlRxNhK_So_9XtGlHqQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA3NCBTYWx0ZWRfXxKZ/1oBSvjM7
 sDLG+A7w4+dYJlcwhYCJQr55qR4T3ov1WDuGczisREv7mGkIGJnyVv5wzM60bAqUj8i1zbWxzgP
 nDldBDdVWMb2+8/QkjaWT6aMMcugG0QbUk2lxOJ2nAqUQLn/ZtJVyOhfrZy394VVMy3RCVCXGxl
 Qc77qZdpeONvoFxiQaUQD7o03lV2YU2O0nnt2GPnYA8w3k721dz4p9kUzKuk0JT/j/FfcpniGFp
 tXdjTLL8QZPyVMsFtclPu/vw2uE9hsic0zemqb3+YMt3s+Tp1MJ7UBAMbOkqSjUU+0myaFfDh/I
 GSZktGAM9OltUTrdK+V9NTkwQcgcrqd+no6TcSkNxHWnbHpOHper0tCxxKbKhsI2kuPd7C5EyB/
 /oetGyyn2sTmQwtn3Xd//WgEtm25HeL1gOV6OFwD0xJ66c3MdWcVd7jrxmH8qFBqjvdHlqV/zu+
 PieLiDhCumOB+zeMkgw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140074
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 14 Apr 2026 08:04:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3699

From: Zhang Peng <peng.zhang1.cn@windriver.com>

Several recipes used non-standard variable names for the homepage
URL (HOME_PAGE, HOME_URL, HOMEDIR) which are not recognized by
bitbake. Rename them all to the correct HOMEPAGE variable.

Affected recipes:
- glome: HOME_PAGE -> HOMEPAGE
- google-authenticator-libpam: HOME_PAGE -> HOMEPAGE
- arpwatch: HOME_PAGE -> HOMEPAGE
- openscap: HOME_URL -> HOMEPAGE
- scap-security-guide: HOME_URL -> HOMEPAGE
- lynis: HOMEDIR -> HOMEPAGE

Signed-off-by: Zhang Peng <peng.zhang1.cn@windriver.com>
---
 recipes-compliance/lynis/lynis_3.1.6.bb                         | 2 +-
 recipes-compliance/openscap/openscap_1.4.2.bb                   | 2 +-
 .../scap-security-guide/scap-security-guide_0.1.78.bb           | 2 +-
 recipes-scanners/arpwatch/arpwatch_3.3.bb                       | 2 +-
 recipes-security/glome/glome_git.bb                             | 2 +-
 .../google-authenticator-libpam_1.09.bb                         | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/recipes-compliance/lynis/lynis_3.1.6.bb b/recipes-compliance/lynis/lynis_3.1.6.bb
index 722072f..0b81ea9 100644
--- a/recipes-compliance/lynis/lynis_3.1.6.bb
+++ b/recipes-compliance/lynis/lynis_3.1.6.bb
@@ -2,7 +2,7 @@
 # Released under the MIT license (see COPYING.MIT for the terms)
 
 SUMMARY = "Lynis is a free and open source security and auditing tool."
-HOMEDIR = "https://cisofy.com/lynis/"
+HOMEPAGE = "https://cisofy.com/lynis/"
 LICENSE = "GPL-3.0-only"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=3edd6782854304fd11da4975ab9799c1"
 
diff --git a/recipes-compliance/openscap/openscap_1.4.2.bb b/recipes-compliance/openscap/openscap_1.4.2.bb
index 7b3786e..85ba9dc 100644
--- a/recipes-compliance/openscap/openscap_1.4.2.bb
+++ b/recipes-compliance/openscap/openscap_1.4.2.bb
@@ -2,7 +2,7 @@
 # Released under the MIT license (see COPYING.MIT for the terms)
 
 SUMMARY = "NIST Certified SCAP 1.2 toolkit"
-HOME_URL = "https://www.open-scap.org/tools/openscap-base/"
+HOMEPAGE = "https://www.open-scap.org/tools/openscap-base/"
 LIC_FILES_CHKSUM = "file://COPYING;md5=fbc093901857fcd118f065f900982c24"
 LICENSE = "LGPL-2.1-only"
 
diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb
index e42b054..f3c4286 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb
@@ -2,7 +2,7 @@
 # Released under the MIT license (see COPYING.MIT for the terms)
 
 SUMARRY = "SCAP content for various platforms, upstream version"
-HOME_URL = "https://www.open-scap.org/security-policies/scap-security-guide/"
+HOMEPAGE = "https://www.open-scap.org/security-policies/scap-security-guide/"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=9bfa86579213cb4c6adaffface6b2820"
 LICENSE = "BSD-3-Clause"
 
diff --git a/recipes-scanners/arpwatch/arpwatch_3.3.bb b/recipes-scanners/arpwatch/arpwatch_3.3.bb
index 84f93da..3ab5993 100644
--- a/recipes-scanners/arpwatch/arpwatch_3.3.bb
+++ b/recipes-scanners/arpwatch/arpwatch_3.3.bb
@@ -1,6 +1,6 @@
 SUMARRY = "The ethernet monitor program; for keeping track of ethernet/ip address pairings"
 LICENSE = "BSD-4-Clause"
-HOME_PAGE = "http://ee.lbl.gov/"
+HOMEPAGE = "http://ee.lbl.gov/"
 LIC_FILES_CHKSUM = "file://configure;md5=0f6cca2f69f384a14e2f5803210ca92e"
 
 DEPENDS += "libpcap"
diff --git a/recipes-security/glome/glome_git.bb b/recipes-security/glome/glome_git.bb
index 5a0300f..68f2132 100644
--- a/recipes-security/glome/glome_git.bb
+++ b/recipes-security/glome/glome_git.bb
@@ -1,5 +1,5 @@
 SUMMARY = "GLOME Login Client"
-HOME_PAGE = "https://github.com/google/glome"
+HOMEPAGE = "https://github.com/google/glome"
 DESCRIPTION = "GLOME is used to authorize serial console access to Linux machines"
 PV = "0.1+git${SRCPV}"
 
diff --git a/recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.09.bb b/recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.09.bb
index 60f2c9e..333caab 100644
--- a/recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.09.bb
+++ b/recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.09.bb
@@ -1,5 +1,5 @@
 SUMMARY = "Google Authenticator PAM module"
-HOME_PAGE = "https://github.com/google/google-authenticator-libpam"
+HOMEPAGE = "https://github.com/google/google-authenticator-libpam"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"
 LICENSE = "Apache-2.0"
 
-- 
2.34.1


