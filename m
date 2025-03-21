Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858E1C35FF3
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 07:18:48 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.15683.1742541524660694252
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 21 Mar 2025 00:18:44 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=5175c14ca8=yi.zhao@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L5KLqj011843
	for <yocto-patches@lists.yoctoproject.org>; Fri, 21 Mar 2025 07:18:43 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45cxs0y0xg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 21 Mar 2025 07:18:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFrbwtjXtbO52u+9RsNsxk4q0vHrJkd9jHekig4sBF6TtIHB7BT5gA2GPNMywPlUUkDaSYACO5uGTXSM6p1TEXt5yy4xXRxhVZ6/lmnjS+G7APD/vvmLju9UduQuyt5FQcBybwiLisv+AmyQzm0fUzrZCMGz4vlamh3x8nq3QjKFmSQ+5sdLDp1WzJlzZPGw70sqiU5dRIhY2BGXgQVV9hUu8ObO/YsFYogXDjkMd/C5ZHrF95DBcNBSdZGWel5OEuAayk5wFfJcHe2n7l/GjD5gthb/uuQ6VCIQdTbDxDrW/IzevvXztC/IoLKe27p4JwrdJdwmfgJjSogf8Zm4Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DA/PEf0gUkc4MYrYerY/GMs91CXSHitT5k+x1piIyS8=;
 b=h8f82AVBWvQ1KsKA7eiW1gfLnyVmRoifm78izJkvLTGCZ3q/dRgWalydMotG4ouB+l8Bq6FN33+HuhNPbCUyaQHj+J/FEzjW2ie8sM1/KmJ4gaz+rqRjgmInvIIX7YEM68Bf1i5KaFcIDPmNU+ywFgz4e+e7LOpwMFTP3zkS+5PeewRvfFhY0GE8YTOC+m4Ckw+7JlkHJn7045lmYXRJaUShE9UvQcefVCOhnSG7da1ZXgIBhca1rLALU1C9eHANEwK8mNnnngiwOn8XIYjkZ/2I13NkXnIWYgz0qdOqyoAlpJrVF95fiOEuOdp7T5DQw4EonW0IPYfqz1z89W0Wtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA1PR11MB6396.namprd11.prod.outlook.com (2603:10b6:208:3ab::10)
 by DM6PR11MB4676.namprd11.prod.outlook.com (2603:10b6:5:2a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 07:18:41 +0000
Received: from IA1PR11MB6396.namprd11.prod.outlook.com
 ([fe80::79e6:58f0:788d:b45]) by IA1PR11MB6396.namprd11.prod.outlook.com
 ([fe80::79e6:58f0:788d:b45%5]) with mapi id 15.20.8534.031; Fri, 21 Mar 2025
 07:18:41 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH] scap-security-guide: upgrade 0.1.75 -> 0.1.76
Date: Fri, 21 Mar 2025 15:18:22 +0800
Message-Id: <20250321071822.3616831-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096::13) To
 IA1PR11MB6396.namprd11.prod.outlook.com (2603:10b6:208:3ab::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6396:EE_|DM6PR11MB4676:EE_
X-MS-Office365-Filtering-Correlation-Id: af4fe21b-9874-4004-6b10-08dd68489b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?iKbEWC4y8xZ/4Ve8036SypR6rQOyOyzEljql93pd2CsvN70U9ht9mthhWWGr?=
 =?us-ascii?Q?fsJonC76kWOZeHQ9vqPWWM73WffpTP29l08+ZKcQ/PPZyEMwAvdhPl2fM5SH?=
 =?us-ascii?Q?c44Zcd+y8Y2Ok49sbVU4tjBCXnNXws8pgKtxX+ZbJlyuLDnbPoyz2VAbC821?=
 =?us-ascii?Q?spx8ZSu2Hws9hpRIIT4f3iSS5W4btYdsft2cgxjS7F33iKLN7/sfbhBE1KxJ?=
 =?us-ascii?Q?L/9oviOx/xOV/5M1c1cv9M1qOR6c/qbwX6lAN76T1LCx95IbUQXV0AL7wKEI?=
 =?us-ascii?Q?+DNtkF2crQsPeCtxevUngCyEsHfydE+uIm8SXyrV3ndkLnC4AmIlXjjYDmMo?=
 =?us-ascii?Q?nG5z2nnIPV3nXZhn//hSBeFfAD513iMDBimcT57a5fm0a2THaJQ+2lspZ9OO?=
 =?us-ascii?Q?D5FUJDKm3v/iHAqD7PS6/NfEXCWVVzrTo0JwH199DotFu12EKjl5+3nyKQLr?=
 =?us-ascii?Q?TPIeYP8sVVcXbr5EXSFsEa+hpvff+SDgN57axKIReJ0L4lsKAB0KGubgsHt5?=
 =?us-ascii?Q?tbrXKkjBO3wgnlW5KAaakddlmwolAsrvn0A2YHwQzS4cGfEJRvpfvW3qqYZs?=
 =?us-ascii?Q?W2Nmopw0WGdP0lZLh7qQB766HCBXFBOVeyQEvzP83BTM+DPNedtmbn5lj20N?=
 =?us-ascii?Q?g90uFknFtlYWpmGOwSeb+EkL7V3wRs+eu1H0BofWb2gZglIxWCuWEJzwi+QH?=
 =?us-ascii?Q?NcHm/W8pIyV69GeHWZOX0PF+KRImfOXKy7+iCj3HWr/es3HgL1rxGww8imYf?=
 =?us-ascii?Q?CuHvrOH1/yy3JEkorPmkUgbz0ZuTSoPDQmIdcRn/B0ek6PUHAEBgGyyAzKq2?=
 =?us-ascii?Q?w7WzpJPOQf8MVPGpyIjH5Fverh4pDn1GMQfWeTxUUzvK1wRA1A4ILUX+2Yqq?=
 =?us-ascii?Q?8mz58y2T/qSzbDhGnIBvkIJSRL8ufwe9FtxI07AkRI9VNfILbb3eXXCeS8u5?=
 =?us-ascii?Q?6vOp4elzJvoNKbRkQgNzWDNQKCoxJxlGHfo7uDqDkDh+csRZPB/evLv0kQaH?=
 =?us-ascii?Q?J+4c25iNx+EL5ryPOvffpOuQo7n+SulbZthg+VE8gUJNxLihYBnHXSVYXzRt?=
 =?us-ascii?Q?HKxMJqkq/uCYxDQsgvmDWaFUg/jR2lG5YEQBZAquReyfdokOWqHgADAfMXHe?=
 =?us-ascii?Q?2eNxv8KiNAyfwtOwfirO/o0/fe4aHeP2LmZnLqo2y5Q8H5hksDl9ym6M7jaS?=
 =?us-ascii?Q?985aPFuDzx/KqhffNT7wTuaLzbYy9spxb4b1UsA7R7HeTvTNQzD8oZaTIPY+?=
 =?us-ascii?Q?pOtC0cnil79p2e5T63XNzPrWpmflGGY1PzzrknJVUKo5RFe8qxaiMU7obkVI?=
 =?us-ascii?Q?mCXDidwAN+PatNL6fBBuMGp/QY4vZ6/KhupuKdpzuBL0c/KEYPAZgB20v+kT?=
 =?us-ascii?Q?5j4GEtuwiLbL1iO8ORJdGruVZta5?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6396.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?W6I/okycfEFv4Lwj5RAUwLPbpKH+6mUiDljQOEB+AaKWGrc2sxFLSkd+7S2p?=
 =?us-ascii?Q?iRAQMgkDvD2kneRJ2KndJ/xR9aCdoMd17CH4pFEWmos6eERVKagyVBZwgnpd?=
 =?us-ascii?Q?kc3fkyTAYoego7ba81XWrZwApN3lgcVHhwnwESmccCg7CVSuOz0CMVycBPVp?=
 =?us-ascii?Q?KA59Wn4uv/2F07EPC3jlOFGr4taW8XLUtu7E/ymSOX5+CdbLRk4ilH39pvPs?=
 =?us-ascii?Q?Y8eoZiOZyi/SYXTkDHpqKL+6ZZE00vF6lm92R+r0k6HZOwvnhLn7kPQ6rA2k?=
 =?us-ascii?Q?bPBd4C5TTBXxLJahQvpNsmQunMoimup7/lKG6MTBAfkzSTEnWQMInunRC6oo?=
 =?us-ascii?Q?E423ocv5gSWlTOu1hGVK95/O+aQQM77PZaXYMSeBx1bEJGVcGKtJfbkggn28?=
 =?us-ascii?Q?WabxmoQ9DsDx2ygY+LDCG1SxaGiE5QrZLZQQE5Rl3Z37qJTm+afkHMHPvz/G?=
 =?us-ascii?Q?13Akx149c8z4omRT88tG0M3pEPHF7VFI+H1DDOfJXrku6XB3Ik8vdxVnJXQw?=
 =?us-ascii?Q?+c5xWaT+o5sF9W6lFhoX5134zV60dUKQB44uaXKtYakp6lR+wFY7LXjLfunc?=
 =?us-ascii?Q?K12FhnfjHArraTGI9sNBkz1BjVhbbKaipkjHKjf1Bk1KitE2XvSZbAt6PwMJ?=
 =?us-ascii?Q?zNSqx1OeplrDXu05hS5RdP0BT9HHDTIjNF2iEGgehmWJdRQNrzIoaPN2BOO2?=
 =?us-ascii?Q?+TLfhkMY0eXtRT6hhi4UgXsiKEr5kJPLb2Q84PbM3G6M56h9HCzkYjZgFkw7?=
 =?us-ascii?Q?Xs7APo7jYZRWLwU7m2FzRM2UcZmfoAzHB5IQA6tS8ocOAjukVMYa5T7gtvhJ?=
 =?us-ascii?Q?OnX33mJhJbEnjhl8u6A+bLUknzwk6d385HebMW2QfgLePMT0Wjaqdq5Lu18a?=
 =?us-ascii?Q?yfZLcws9lnRz1M4RBUdkwc/KFzv/taRJujYDiyAyWO2y7xmX7VqsoB/SDGrE?=
 =?us-ascii?Q?LdKDnFjorgLQIwmpHgKCedu+5FEihv0z8kZPbnsBlwYwn6Dze1r2ov71dHli?=
 =?us-ascii?Q?A9R8yvvzV35cNxhcIhgSrxVpo772raUG+PjFxgLMZ/EVdHThinwt++RciEu1?=
 =?us-ascii?Q?5uPgNvdectuHfbMVuJJsjnaDwfFSgO42XC4qs2tfN9chdW1GYk2/nkyBU4u8?=
 =?us-ascii?Q?VFQJ/NlUWikhhitzDdxAsXEVD9ql2C6d+OkRDzScnV4HF/4KxJ9+4SNYJYDo?=
 =?us-ascii?Q?/xvyNRloVsEUceCCVGSNkRpXpgb7jvUX1DU/IALHmybUseWhb0IpYyrzuEse?=
 =?us-ascii?Q?TX9lHgmgFidcWduzF2yxtFzrqVuWGkKxK6BdiWQQUiCQoT+gnjKm4gpIafGw?=
 =?us-ascii?Q?x3/4Y+BXt1wqBe0kM0Orn49KFUmsMWlq1JwdSsE5GVs3n5VGSDWh/DrMiyJm?=
 =?us-ascii?Q?GzTkFShKc6upojMQVyVs7wpPcgSrkjinC+J2YOdUFG1i6e2Ji/4IjRTBF6hx?=
 =?us-ascii?Q?E68KRsbxXztg+Yaeo75Br+pL0WxM3cln8gXp3xm9FxYH3K7mbnTh8nKlw6aD?=
 =?us-ascii?Q?SMa0Pmw9fEZ0XoJKAY+EZk9SmRvko6DaeKVNnsCeOTON2mHWx5zBhp9CT81K?=
 =?us-ascii?Q?Z0VBLSpyuZ+cOxHe+A10TDRN0up3oJ1vZc0Is+Bg?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af4fe21b-9874-4004-6b10-08dd68489b54
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6396.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 07:18:41.3024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VI1dzy39D8ps8efKo/pQWETgVMe3ZtN1zE6eyTTNxlNWfStTBvtcQhN7UGjE+9sGkCnf2nI76voVxdmX9eofLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4676
X-Proofpoint-ORIG-GUID: 9n8l1beSC07ZVZ_sorUrLtCPXsjcQCDG
X-Proofpoint-GUID: 9n8l1beSC07ZVZ_sorUrLtCPXsjcQCDG
X-Authority-Analysis: v=2.4 cv=NY/m13D4 c=1 sm=1 tr=0 ts=67dd12d3 cx=c_pps a=c8UlD/aNTkVRGuk1JCy5IQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=H5OGdu5hBBwA:10 a=NEAV23lmAAAA:8 a=5B1P-IGBAAAA:8 a=t7CeM3EgAAAA:8 a=TNFYDd7PNYIBf0cqDwIA:9 a=PcRJL-ISiCqaXG01ICqs:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_02,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=932 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503210052
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Mar 2025 07:18:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1238

ChangeLog:
https://github.com/ComplianceAsCode/content/releases/tag/v0.1.76

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...p-security-guide_0.1.75.bb => scap-security-guide_0.1.76.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-compliance/scap-security-guide/{scap-security-guide_0.1.75.bb => scap-security-guide_0.1.76.bb} (98%)

diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.75.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb
similarity index 98%
rename from recipes-compliance/scap-security-guide/scap-security-guide_0.1.75.bb
rename to recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb
index c67a608..73bd576 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.75.bb
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb
@@ -6,7 +6,7 @@ HOME_URL = "https://www.open-scap.org/security-policies/scap-security-guide/"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=9bfa86579213cb4c6adaffface6b2820"
 LICENSE = "BSD-3-Clause"
 
-SRCREV = "73a89fbfd70f4122e2253e4715a9ba6f4525a393"
+SRCREV = "616d4363527acb61c6494a97f3ceb47ec90f65fd"
 SRC_URI = "git://github.com/ComplianceAsCode/content.git;branch=stable;protocol=https \
            file://run_eval.sh \
            file://run-ptest \
-- 
2.25.1


