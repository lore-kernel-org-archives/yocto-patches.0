Return-Path: <Haixiao.Yan.CN@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BC6CCD1BF
	for <webhook@archiver.kernel.org>; Tue, 28 Oct 2025 03:26:54 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.701.1761622007722064819
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Oct 2025 20:26:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=ocNJ030A;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=239607c8c4=haixiao.yan.cn@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59S1MbXB3399620
	for <yocto-patches@lists.yoctoproject.org>; Tue, 28 Oct 2025 03:26:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=o9t9UfY10LmOXbt7FP3l
	uhNLURteA9oBFB63xJyGzRc=; b=ocNJ030Aash3UpWI13JK8wnPgx6zwo5ifeLP
	U2XYR0qvLaNNd2z2DhOqZPWXvaiavNB3OmwtZIATCSPeyPSUBAkgISIoaBQx2Lj/
	7JTs/mzAlLtIXmS/X6+YgVo3AbNOTXiDC1Tz0PVR7B7oWHdou4kKaux7fdA3FWIU
	eaAD+ufH53IQZZAjgfWGfHmoam0PHBLXsYyitm1GS48kduRXk0OXJYcgcApwAIYI
	LmQg5v1EIqyMKWdy/Q1AfA0SJqBYn/FXFyPhEcXJUXvNBtUeK+QKBJFYFnFBTfeJ
	SXzfxBoW0pOZoY/4ckO5ODH6DiGzhhx8j5rsy05aVpbZkt4tSQ==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010027.outbound.protection.outlook.com [52.101.46.27])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4a0nh5tpk4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 28 Oct 2025 03:26:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HIbRwoFkugADOy0Lf/vmGBLIO5L94CmGPRYeLRSQ9UN//I9qkuvO36Hri1MIw9ct1loZHN+07/vULTlb+UKsM9J9FdUZL6fsqmttsze7xPxe/6MeeKXJ7s5RQucL9U16809vNVp4bX1+GCFvoPPnuZ9Kw60VbLS16wUHo8I+0cT1KF0SrAHWYA20VB1Vu8LX3GPA8X5Rsfqwx8wsXtJ7lDZRHynyoidOExzE25NA4xeGmgs/6vNRlrgSQxgZve6sdo7NcaclOuT0wPS2xWuId7CaR0S8hnOApYDQIuKXJFuEKAWfM1dN6sdTAlu3IaFNQhXckgAfGfASUIBJtMMENg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9t9UfY10LmOXbt7FP3luhNLURteA9oBFB63xJyGzRc=;
 b=p/h3WHm4yqI6X21LPh/jxIGUYi/5v8T4j8Xu7Cm7a1Uw0sDnhfYIyjD8iTUCF3uNlPTcagduwUmrIub0awNHaROeCtSlAUcQ5GPXo0P5j2/+J5w7gp1rrOMd/1dd/7R3bqRqcw/4vLsnKx89w/dYpzDb8e2VBbIt44MplO5Yq/koviPG0+jB8gGJa+ZjHKVPJmOJEFznK3as+uiuHxN1Gt/kQuPVRa+T9s81o/PzkMJY9fC8YQdEs9lQH842onD9Ai0Po7tty27PLgwtkSRwdKfTay6eT0ypX1afuw9mg4RBaTkTSjVar2g4MGBgpLQY7f6qMWvOu/KPU+ho2qg16A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB8189.namprd11.prod.outlook.com (2603:10b6:610:18d::13)
 by PH7PR11MB6608.namprd11.prod.outlook.com (2603:10b6:510:1b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 03:26:43 +0000
Received: from CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::4025:23a:33d9:30a4]) by CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::4025:23a:33d9:30a4%3]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 03:26:43 +0000
From: haixiao.yan.cn@windriver.com
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][walnascar][PATCH] fail2ban: replace fail2ban-python shebang with python3
Date: Tue, 28 Oct 2025 11:26:27 +0800
Message-Id: <20251028032627.1779190-1-haixiao.yan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU2P306CA0076.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3a::6) To CH0PR11MB8189.namprd11.prod.outlook.com
 (2603:10b6:610:18d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8189:EE_|PH7PR11MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: f54ea522-862b-4266-466d-08de15d1d0c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?osulh1d7vi5dnILR5C+YZAAic0SNuSIX3Lgo4Vy65BCmFF29hHqh+tfC7MMy?=
 =?us-ascii?Q?CxGsYzxj4boMKWfPGyxc4seAreI8eiSgH5FQavZQkGwl0ZPbLEiL6GVq8oXT?=
 =?us-ascii?Q?Q9AxRRs6o+bgeA4HjY/OMVWqoQjzOqImQ3RXWXMgsLfmgKmnZsPCcYKRmEI0?=
 =?us-ascii?Q?S9BU7B+4kJ93LxgYLvPMK3tO8XeD4ITYLMCz8DpYjLEQrQqK4aIHwj4gi0CO?=
 =?us-ascii?Q?mj1Oo/PtoM+8tVOyQkBFJsZstYZ/2s1Zpx7kAAmIW7wQTkioZ78l0Uso1hNZ?=
 =?us-ascii?Q?bR4o4hU+JUiX6XRt1l50My2i0dr5mUNtCXtN9uzD7sSMurTsIEa/FVDfOjMH?=
 =?us-ascii?Q?LKTZ9pVoVtrMKkQI9OtSUJojvqCJsXamKvJwHVQci5UlDvyprwgjevkWfjSq?=
 =?us-ascii?Q?h0XQAg764pzukxbcjrB19uRkGS4AMXvnXWcluAoGEkDcppp1iFw5yDPanCzL?=
 =?us-ascii?Q?E/GSPkl3FVbA9kwPoDxBIv19R0CWMHWT1VO3aSj/i86Pn5J6ypcXNTSRUgG3?=
 =?us-ascii?Q?bsKzMwyhM/2LF4tKoRKNXDlpxkLuInQcJZ8RpK0u+uuo3hQjG+NjdivMbhoN?=
 =?us-ascii?Q?jaf1zS6HNxr96UyfqzAOHsdCQBcoN+FPBLjIzgIBerU36Y9tjhzmNJ5MdXgZ?=
 =?us-ascii?Q?7tECZsG8SBUPXQ/d8+M92det8B2esNfcYk7tHv3pqkQ/nHJ0YynpziuDVqUV?=
 =?us-ascii?Q?+mTWpBpYY+dHMhxTRA8eJFaJ+a2AFwViiuPkNvop5CZ3sP0X9oRrdowbgWVE?=
 =?us-ascii?Q?v/ma/91v2Uz7hr+29mBNVVVXTJ4h0DK735xjP4EFIoPKmnrpkxZK1DtBOaM2?=
 =?us-ascii?Q?HjwUjH9qIlkC67AwHYQq5mWtmjhaTz2X/8+bPuQweq9R/Xioghtaw+VQYNU1?=
 =?us-ascii?Q?usgtLXIqwOUqbTjdbAEECo6U+MH30Jy08oCQWyUDwzT23OPxK/s2A1bMBTRa?=
 =?us-ascii?Q?DnNuLBdQSsQQX5MYuHBOkNVKX0e/sL+nZb8rAXXEAih+kwanNK7E+IqIwPzt?=
 =?us-ascii?Q?BeXDE0SNHWn9YiVWf6Eu036+uZZQ39RGGIEzPw3SetYDSEF6yF08Dyqpu6NW?=
 =?us-ascii?Q?C/rE9eOa4wv3VYUb8h4xouOhPu1CP/ycp4S1lHbzQnBj5gDWjR+SeXA3L+5i?=
 =?us-ascii?Q?QM+Xx4KyC0hdgsH7B6mqd4Ywy88fF9EZ3HGKUMudyoSZdqeEZnWa3bN7/p7m?=
 =?us-ascii?Q?rUmjzJh0U1IISQZkuyDYus0TTFahqGwova7ErOIq1n87Zz9AgaPklqGMU+dT?=
 =?us-ascii?Q?hDda5J1RwXvTIeoTfEurYAyZnrEBw3mGxpSxkVufuAXmB5Hw65pQW1l7iZlB?=
 =?us-ascii?Q?WajYS4/Gaq9vfQpv2c2YCTVk4LhocPqXjq9r/Dlw0AU+XgmPChbxMRMpgBqF?=
 =?us-ascii?Q?xL3ZZbYhCtdFB9zE/NgjsaB0RRrRKbO+CgMyQHyrB2Z8asD1ZEoaFHvl6ZKT?=
 =?us-ascii?Q?YJpp0Etb/THsCZ3bislqb1e14UZ9jWQV0JCmLN5zOucjQobqM36y09nIC364?=
 =?us-ascii?Q?hD6P2Jz8nDdMaT+89EH26/2nhfTRfHL0CFq0?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8189.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gH0/YwnC8Jei8L9KebFeajRN+W5MI/RMQCIJf0YoDwOYw1jDmF1v1YA39cK2?=
 =?us-ascii?Q?tHIRxeSKF2Nls6NHQUQPwwuaGgxC+Q4wkC+P0ceSf1RL3fP3HB0PIRu/6ceq?=
 =?us-ascii?Q?GXS9hHcZK7eDvh50KP/dYEfdOOOm2JcTABqp/a/vaQAu/2lxfGhcYIPFdWfs?=
 =?us-ascii?Q?LduspZ6zAvXpIFm0NYwfY1P4YdMgfrxWxd82upvOPuxYXrA45bCBKIHf5Pea?=
 =?us-ascii?Q?1czJNdW91QGOsUkPK/+Ttc02wQ8ZYHE6eF+n/A9Rql9e903V2UWUbeedEbsN?=
 =?us-ascii?Q?6bvIjOr5bBqk+lAOcOdzy1wTJKCLHwzLt7L2BT0vaXFYjmJRXFDDVZzYSgG0?=
 =?us-ascii?Q?9g2DYjoonxQ7p9xSA9WruYTmSxWo5jpfMkaYmnqJAbPojePRmQsY2v25rWMR?=
 =?us-ascii?Q?V0/zdCdZihW4IjTyMHt9VTg39h2p5tYndYJfiltQzwNZlD3qHIdaAQGBF9pn?=
 =?us-ascii?Q?5H9WrhYoh8Ga/9TeHrfxDtlMVpg08aBH0QBto5fM3559bKbskK6214rImM5p?=
 =?us-ascii?Q?IuI1Tj9h5VutpqctoRcyoA+BCOW1PxFstlVkMsR3IaAsxrbKr6gkCdb41E41?=
 =?us-ascii?Q?rexHW4BMC724N2DACSni4yv6A8qLv5lrRymg3jnn2j6rq3oXtq7VwXIuDsFX?=
 =?us-ascii?Q?C5w+o9d6v16eqeAfOH+6EebtE7mQFsxDsJ83k1itydDrofnZjFqJ8Rfdq9Y/?=
 =?us-ascii?Q?gaL8P7WziBt1lWJ1jKvt7IzOELY4BFyMERjRs2QkToSXcHv1uKoXkZihM+M8?=
 =?us-ascii?Q?ThWn+FFzS7fytBWkQOHu7eYW+0/VmKHAtzmWIMLcdyG6lmSUoD3k6vKozIrq?=
 =?us-ascii?Q?4yyh/B5npRgEUv6pju4EFsbkdlLzMVXUDDrLzTuUA8tc4epTD3T4BRHU2GK2?=
 =?us-ascii?Q?pLElvBhB7FObdMi95PYk+iyWQym46mfrfGlZ7SrU6MZe8xhwzf2kwsv7V8J0?=
 =?us-ascii?Q?gRNQUfXlKTNKaKixHxsbtlLUDXwfSl989/N5gwnISoPhWM/lamssel87IwRt?=
 =?us-ascii?Q?UU323sVSN+DZwVsTWJIKTHIzcEapBNPL5u5gVtInY4fSskdMsVExKOmcjRsf?=
 =?us-ascii?Q?dr3RsZpZEmLHTRCt7ByjmsKBtvInB+FJO915KfdkrG6DOlkHm+rySj83okWW?=
 =?us-ascii?Q?AO8JAFDrNeVdmfu5vhT8TkAFXJGzEdJaRMJWLopmkngx87Xbv5TIAM+LqfwI?=
 =?us-ascii?Q?M89uf4imH6eEXQTalEpNE0aAScnQ04H6/Py0Ft+qGJc+SMcR2UvvawJHChpX?=
 =?us-ascii?Q?xWeCNlbeAuPEvfzvmUnhS/B5nMbNYaoz3KyKAir9ExcDnSi3tL9prMArCehL?=
 =?us-ascii?Q?VdpisLADjrMasDPMjFqjVnAl2yrpaCxtXvUX/oHY3PUKDdi+WezSXGVOHhry?=
 =?us-ascii?Q?9AzdNcyjwIwwSLGX9kVkBhctmPVNIxw5iqnlSKeww1zMqepdWazczdsQFxrS?=
 =?us-ascii?Q?8zfDA9sxoyGKJliFg3qu7UrzAX/XIUGJ7en4hD6IW+nYAaBK8qyESbqCw8Au?=
 =?us-ascii?Q?q6/b2jwloMAh5WI7OpXzAuX6ITK8OoGvHsX1bdB/Ukufv1SrEbW2l8RtEc2z?=
 =?us-ascii?Q?x1gqCBhem3u0x3X9deZecQuRc1yyIyeIwFKyitRka1KDj+74ZaTE7jEnaKEh?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54ea522-862b-4266-466d-08de15d1d0c2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8189.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 03:26:42.9808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMYqfDy+v3ABM7aPLQmc2J4DiD9lSoLsZ8tv6p0VWMSzF29nEbYe/7mEi83cLQOb+f4jxU2jz6dEPsfWQYPqIEyE871shPzAtOVSbmCMHG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6608
X-Proofpoint-GUID: -eBRHyhBlyC_cVkbD57U8wSNfEKvuG2d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDAyOCBTYWx0ZWRfXxxZvfGuf+ekn
 kB1sw9yKOKgqwWBhb2Nmv4ePQ5b53EnrcdbUD1KqT2OrwHAl9XmXaprdZKQb4a9xOkFCjIBb7Q9
 uaOZEVL0rO+KdRdlDKmItBbC8uskxhA0d9QI3wptF2IgJL3k/WuMCW2Mx2YN4f0HCH2BzUPuj22
 /tAc+Kj82CTwnK2dz1kOLwmK47Z4jibqQyzfdrbqOD1vzGi+EzhlU/Cs2Us3pUb7FrsJYQ8AzVE
 kVH3gZ9dOO0exBCqUwaV9z1IVrUuAQqSnyvHVJYIgJituaYmHI//gPYD2w+6wfpS2Qz+qfeChcR
 FJ0YW5Uzr/b8rr82r+YTg1Ea7kRb+x5xwivsNqI/tgsUhqmRUOF6vxvj1yFwICeQLovzhwbexkm
 VLce4jKe+6LUkQsUyfE0oC3XGIvCNw==
X-Authority-Analysis: v=2.4 cv=FOoWBuos c=1 sm=1 tr=0 ts=690037f5 cx=c_pps
 a=g+XQapjYtrKCWQI10hurPg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=tUg6EFNUFFAtlYByzcIA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: -eBRHyhBlyC_cVkbD57U8wSNfEKvuG2d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280028
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Oct 2025 03:26:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2396

From: Haixiao Yan <haixiao.yan.cn@windriver.com>

In Yocto, there is only one Python interpreter (python3), and the
auto-generated "fail2ban-python" symlink is not used. To ensure
all installed scripts can run correctly, replace the shebang line
from "#!/usr/bin/env fail2ban-python" to "#!/usr/bin/env python3"
during installation.

Signed-off-by: Haixiao Yan <haixiao.yan.cn@windriver.com>
---
 .../recipes-security/fail2ban/python3-fail2ban_git.bb          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
index 0cac7abcb73d..0ead44a02f08 100644
--- a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
@@ -42,6 +42,7 @@ do_install:append () {
 
     chown -R root:root ${D}/${bindir}
     rm -rf ${D}/run
+    find ${D}${sysconfdir} -type f -exec sed -i '1s/env fail2ban-python/env python3/' {} +
 }
 
 do_install_ptest:append () {
@@ -59,6 +60,8 @@ do_install_ptest:append () {
     install -m 0644 ${S}/README.md ${D}${PTEST_PATH}
     sed -i -e 's|^logpath = README.md|logpath = ${PTEST_PATH}/README.md|g' \
             ${D}${PYTHON_SITEPACKAGES_DIR}/fail2ban/tests/config/jail.conf
+    find ${D}${PYTHON_SITEPACKAGES_DIR} -type f -exec sed -i \
+            '1s/env fail2ban-python/env python3/' {} +
 }
 
 INITSCRIPT_PACKAGES = "${PN}"
-- 
2.34.1


