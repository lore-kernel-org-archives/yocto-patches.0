Return-Path: <xiaozhan.li.cn@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A3CCD4F26
	for <webhook@archiver.kernel.org>; Tue, 12 May 2026 07:08:03 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.70202.1778569678204795538
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 12 May 2026 00:07:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=lkr03FFz;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=9592b31737=xiaozhan.li.cn@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64C6P9jA3584967
	for <yocto-patches@lists.yoctoproject.org>; Tue, 12 May 2026 07:07:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=wsvmzf1Rv
	3FRwcS12U/bcDsEC24iCUh0nmS/sAbMIdI=; b=lkr03FFzMR+eOESj0hCfKiMsg
	tFGN604uPjcqcsKxZxWP9ICEMPmZGjMatgQ1HyQFK2C4Gd87LPfHT5KNAquBjFVZ
	YhuhcFSdXpxWhw7WtpKz3R5MaoqVH5HF6TO/pKT4TZ/9KX5EqfNMRAQlimxj5hoi
	6EHBBK9E/8wdLfW2BWgr59AF15vTXdLyZt7mmMm6cqFtIhA755aItjyZQx8zbBcf
	hN4o7vS3F4A7ABZeKmCxPBhkUQQLb4frLT6gh3Rx8fmQwecjdTbisoHLc1yGV1GF
	EwuusVKRxiPp6W6mZyA1WpZkF7LOgE0e5UQLdHWbiYcMFV6OVCF0PbQo0W67w==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013036.outbound.protection.outlook.com [40.93.196.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e3nvhrhq5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 12 May 2026 07:07:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRluJ+kkPDrgvXcSzQI2eC1RUXmCcu3gZPMAet2fZxuupniGkjFgrp1It94kNSIZM6dBvpyn84G12RS9K00ZtMug7dCtPShz5WRGVj5zesSuMYNlQFxVUJspKVFqIF18qqI+NhCvuTQC5UegSY2hAXu8F3ELKZVITCf9fujLx6KiV0ezCDYJPh6O2FqYKc1szERK9aRRfdTBvuhNtS5A7Vey+azdgWa9AxDW+wSSPMGGRYG8yPXbZVbPwpZn9ofjV6tY2Q3xGId3p4VWzoR/BuOlgh+/b85SUAOJXue+qCB27o76bj+KiQlJ1aY2haY0h0zrEIdwgnz88g37VwW9vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsvmzf1Rv3FRwcS12U/bcDsEC24iCUh0nmS/sAbMIdI=;
 b=mMOE5JZNWy/ts+u0o7sIDvuoyqEvOg/xrz89Sn4hjA5e9ZppXk+2D0gYPoNiXpKJTVh2LBFMP0x5UF8opH/tzIEK6YGlzfDvCCkRybVZuWyElJl8fA9Y9vZTPMwF4saEVGUuWtc618yt07WLl3IRk1GjEJvSVKsLM3208eub3XJKaa5YDhHrk2K2EL7mIoRNqBztP5Z+t4VFMOyaRp5+gh0VLJatNh9OiYqDUqOs7OYrbWXRZrIsuFtFJGWFT40jzVhmjPxexkiQfyaohmwW0dHgKnkqaU978rgf7yxF37pQbsbY7XhF4eMUyDTetWppeWMd1vEooNq3X6nPjmB5Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8344.namprd11.prod.outlook.com (2603:10b6:610:17f::13)
 by CYYPR11MB8405.namprd11.prod.outlook.com (2603:10b6:930:c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Tue, 12 May
 2026 07:07:49 +0000
Received: from CH3PR11MB8344.namprd11.prod.outlook.com
 ([fe80::5596:e734:3fd5:4fc4]) by CH3PR11MB8344.namprd11.prod.outlook.com
 ([fe80::5596:e734:3fd5:4fc4%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 07:07:49 +0000
From: Xiaozhan Li <xiaozhan.li.cn@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Cc: xiaozhan.li.cn@windriver.com
Subject: [meta-security][PATCH] samhain-client: Upgrade to 4.5.3
Date: Tue, 12 May 2026 15:07:38 +0800
Message-ID: <20260512070739.1432995-1-xiaozhan.li.cn@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::17) To CH3PR11MB8344.namprd11.prod.outlook.com
 (2603:10b6:610:17f::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8344:EE_|CYYPR11MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: efa4ec24-1de1-43ae-164c-08deaff52d45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|18002099003|3023799003|11063799003|13003099007|38350700014|56012099003|12006099003;
X-Microsoft-Antispam-Message-Info: 
	VyMZv9MqmwjYVjz6ABqRS7yVd6XLHyVHz4Gn6oGJR4EQxdwv4fIAsfl+5RF5yLFcrJxu07REFeAagHpX7GeRonjhUoNeMUO6PCpgf4QhmTvE5IrDembQz1oqiFtdqTP5kcqPC8cMT9bp4wFAboDz2XBft6iYBlQzoIKlQcJVumKAKRUeJIb9BLtxQd68O0WWL+0ibQUMdWZgE/boe3iv+sBRxAfFWTwtsq7V05i7hUG+LgOV1SmlSUp4Vz2M2ZqFDFjYwcUtouY8RhlbVtsMLxvuwftLV8g17Rh7dSesazc6Zvkie10fCiRPUvHhYpxHZ9JHBqoAcWt14bFI3I8oBttCdURU7Po6MzCwjbvKuL9GnmQX2I5RzV2Z8MFcZmdRtwjWVNvkatTy/Vc18lbtFRWCEbECP3QQx5D6izInj53reGGWo4GKr4VX8f/2PhhTTT1s9KkFm1DW82E12WQ8cSJo1+LoKaPn+U5KO1wivVKvVe6ICXW7B89Fpn3B4YBjn5ZyGTCOL2lLc38rYp9dAjlpxDXcJ6IHqaGuwK+7fOF0JSZSe9rbnaO0HES6QnD0cl87/8H1b37EPbIs7InhZTQs5mdldR3tdA4W8pQy324Q84837AGL6UmgFDJRH0BnZwxj64Y9OzFprNbmYPWZYuzglsqD+mVEoI5d37ULZ9WXPoaNGVYCORdtMh80nC6iQipu7R0jjb0tQIoelYumZw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8344.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(18002099003)(3023799003)(11063799003)(13003099007)(38350700014)(56012099003)(12006099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FWyhwkZ4oXoovzTQe7AV9Bgx+NvTkLZBFcdihGQYwdGVp8J5LrB04P0vRRrt?=
 =?us-ascii?Q?X0YK/tJX/1V7m4vwVUxa1K1B9vO4TsxHmRzD6t/0Y0iWrXfk+X7aWzqQwP5Q?=
 =?us-ascii?Q?RjwpTduZ7JQuZ/EPMjV3sqzrqRSf9v+H9W3Cf0zisGym/QPU1h+1nJtnZTzF?=
 =?us-ascii?Q?SLVN4Umjrlz+h7bhObrvJ06B32mF+YVl0wDsqb1KAtDmsw/V0O4wrlOb1uW+?=
 =?us-ascii?Q?upH30KPnM9XqwOY/M9wbc0q5D3n4Qc3mnubJuG/M5CpHhFOKimvCVrqqs4/G?=
 =?us-ascii?Q?5aWsgEKzS76nuUXHlb8m2HoOX4E6U5S4dhim1+aeBc4wiiVHClBunUkWuZHf?=
 =?us-ascii?Q?sKoato37enu247UDBt4GfCtt5jvbOnbqKuGAqXbw3JozGrtAg6d9otjIOkG6?=
 =?us-ascii?Q?C2WQiSSJpco48luvfeRibAuyxX3Axr+MrIXLSnh9A+PlKWcDg5X3SibDuh2N?=
 =?us-ascii?Q?/nPyiL+TrHzsY00avy2i37gKfavsX2S6A3wPXb6c9E9rnF7yD6aL0YER2Adw?=
 =?us-ascii?Q?2WmKmgTivS37kbVIP+z7NzyF423Vd6yLpvAityndPnP7AZcNuJEsxFrcubpT?=
 =?us-ascii?Q?EO5DoB928b0oG8jza8BinbiBCPo33e4EVn010JFEbMYlep5FvxnsvcpXOy1F?=
 =?us-ascii?Q?uQ8RvXFVsFYturwLAmvVYAF8wOLJos3Lk9U75LGvhTA/7Kkf/hYFOKJ0R3BH?=
 =?us-ascii?Q?Q+HnOYXuTaMx6sESURjsrq5g0czd94l/ohVCrNBysZ18KjgtpkAnZrJJbpe9?=
 =?us-ascii?Q?q0HCsq1cgkwssZf6KKIuv3uD4cO0LLLA9txW5Zl0Kc2HlItLDOH2Fngz+908?=
 =?us-ascii?Q?iUUS9H0cWfEH5qntRTc6N5ZwGX7ZYIujf84GYWu8vazphkSpJmOaR/7lpCjm?=
 =?us-ascii?Q?QtX1XynluP2zDdE5NzvCb82569OLSU2Rali1yCHKsu1uBqzZk9bgMKQyuJpa?=
 =?us-ascii?Q?/gAwbGkvFgSjUmZbWiD2nI6Rw9wLIDhAxmYYQynlF3vYOXm/RBAvWUWC4aAH?=
 =?us-ascii?Q?65ssnPWPGbQFaR/a0IkbzL+aioPZ1poemsIKfizQeg0cg33INpR6B5o0+X0p?=
 =?us-ascii?Q?t1wxKBLSv8OqVM0jYzB3xFsIdhuRmArLgXfB9rhqB9qgWTfaGaBguF7tAKvF?=
 =?us-ascii?Q?S7pg2Z7S9WiaoXbgZ5py+VYK0c2mkYnzIOvKpI+wFZVi+ExSlKbFHn5NM1hF?=
 =?us-ascii?Q?RV7ks7lN1VC+dOSXV7ZQflLyw3VxOYO+dKtxbcty1WQM9RstR+qtdUz2HXHI?=
 =?us-ascii?Q?5lV8B++0P7RUYEfXzxQyHbcIUAUHe37VlNAeBZXZAQUmuoncFH+Vx7qPQgVQ?=
 =?us-ascii?Q?ZBqbBDr58AMQzvmhXuV3M1Audau1IK096EWnBYLt+Z2tsib5pZxoJllHAxOZ?=
 =?us-ascii?Q?YDy76g+AUQMpLqSnxxgj9y/2Cu1Y6Z8ECAOzC8FRfEuDS+kM3veOXA2loJQn?=
 =?us-ascii?Q?TQJhu8U+sS4WvJPt/nsJpNeR2zq9M1TvID4FOKfbNv45esEzkcoituQfp+Vy?=
 =?us-ascii?Q?q7k4nHICPuqG9yE6hP7jW9PxHtkyVX0SLqKoCiMboidvxbSKHla5VuG0Ies6?=
 =?us-ascii?Q?iiBP16DYcl1gWnUQ2eesObq+4oRmA2ZVgx6mY9EFdaDLAd9EseirB25fDR7S?=
 =?us-ascii?Q?Of9sk8wypqG5MvtaJKJ6LAn9ExzFCjzoQ7Z1uIjcPIi9d2t8FTVIoRwCvtmU?=
 =?us-ascii?Q?QKhdByg5m3VqiEaVpNNNH1uB7MXVIGsQQcEZezAUdBtx7Q+bn0fCezXvGjX6?=
 =?us-ascii?Q?oT6EyfbRmx+sqnD3VbhmKkM+DnC8thw=3D?=
X-Exchange-RoutingPolicyChecked: 
	ihi3m+obOctzIBNfnySaDYa/RZKc3QSje+HWLrid+lCEw0DEkRBZCprdbKStmRYFy5pLbGiy21eAbf4z0Jz1EpY9YohPsd4CepDvCwRvsA0uF9Ke/xCjciB2DChCZNpUPqkgzSx3/7UNWAunMB18lN7zcLjzE01Jg9UQ6F7K9xq+T8sGtwe9yg+50HEUzvTu7xLPyawB+RL7NApeNcsdiUuR99EIUk1nZC8bouJDr5T5RjHJ7Nchz+wNF8NVad89j6caGJSCX/pkGhpL6hgRRyzv/Cyf1ITXVXX+jJo9OJGHMQcpkwwUDFSyZy5FCTZuKyryabdJnDg57ERqaxoBfg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa4ec24-1de1-43ae-164c-08deaff52d45
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8344.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 07:07:49.7308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvXeDMWb0JFZrfJ7zhKo7vTO00j5RiI782r6BSKFF5HHBOK446IOoL8uE/Os0DNa+D7OkWojRl9eXcm/SsehqoRxX9H/rSlbPnQPuOH4lSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8405
X-Proofpoint-GUID: d2MiOZWeqDEPFDXO9gX9boiIYoKrlOFO
X-Proofpoint-ORIG-GUID: d2MiOZWeqDEPFDXO9gX9boiIYoKrlOFO
X-Authority-Analysis: v=2.4 cv=b4mCJNGx c=1 sm=1 tr=0 ts=6a02d1cd cx=c_pps
 a=vqIpJ22NDJOYTIB/W/KhXg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=nDJU2pNIAAAA:8
 a=t7CeM3EgAAAA:8 a=-YBnEpcesZVAYn57l0oA:9 a=cvUpGn6QkLxiVzwzn9tb:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA2OSBTYWx0ZWRfX6Rm/tSuDjfRD
 MpyukpgO0b30MH+VKmQQJSiOHD+dlpDslqU1xo3+lGXpRaisR/bzQKMcFTmelCgbJ4tIp28kf/n
 a2LAMXIQAl215CY9V1evFbCUnVOUV6xlnewAZLjCYg9qFdZAqac+/5vMxdeHRz3Hb7cgFl8bEdq
 y5OCZyzVLMF77jmFOR2tbThFdUqLMo70pvgsE4wv8qUuSXSkDkB6NxYMNJrB+c4cb8KUFzxndYH
 S/9qgGWSi8VFDTIZ5lpc25K6IReoQO6flAZ8oxd3lHlgt0bCRPuYomVnemdr/dXEmmOxOSykVgi
 qKOyn3r6u7PBh27dNEgEBjJLNmgzy7PteuqzIgp+9thaz/vuRF2w5IXqvMMKjjiOXySRfhxwkni
 JMkzIDN/1z9P4ofbv6LlCVg0j6zrGS+i4RqxUm/8s8LjxayO+k6C87muO6Wjc1oIR7i/q3HfR0h
 FWDqas48Pt1Ud0Nv8Qw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120069
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 12 May 2026 07:08:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3973

Release notes:
https://www.la-samhna.de/samhain/archive.html

Signed-off-by: Xiaozhan Li <xiaozhan.li.cn@windriver.com>
---
 recipes-ids/samhain/samhain.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-ids/samhain/samhain.inc b/recipes-ids/samhain/samhain.inc
index fc4e423..95413cb 100644
--- a/recipes-ids/samhain/samhain.inc
+++ b/recipes-ids/samhain/samhain.inc
@@ -3,7 +3,7 @@ HOMEPAGE    = "http://www.la-samhna.de/samhain/"
 LICENSE     = "GPL-2.0-only"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=8ca43cbc842c2336e835926c2166c28b"
 
-PV = "4.5.2"
+PV = "4.5.3"
 
 SRC_URI = "https://la-samhna.de/archive/samhain_signed-${PV}.tar.gz \
            file://${INITSCRIPT_NAME}.init \
@@ -22,7 +22,7 @@ SRC_URI = "https://la-samhna.de/archive/samhain_signed-${PV}.tar.gz \
            file://0001-Format-test-output-to-match-Automake-standards.patch \
            "
 
-SRC_URI[sha256sum] = "0b5d3534fd60ecf45dfd79bd415e81f7a56eba7f1755771735e204f334033578"
+SRC_URI[sha256sum] = "e7837adfde3d59a23c59e1bf3ebacdf71bce018619194cfad938cd30cbb9d15b"
 
 UPSTREAM_CHECK_URI = "https://www.la-samhna.de/samhain/archive.html"
 UPSTREAM_CHECK_REGEX = "samhain_signed-(?P<pver>(\d+(\.\d+)+))\.tar"
-- 
2.43.0


