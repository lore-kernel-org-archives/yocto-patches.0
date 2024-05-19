Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC303C25B75
	for <webhook@archiver.kernel.org>; Sun, 19 May 2024 22:57:51 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.48207.1716159467464956623
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 19 May 2024 15:57:47 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=58693ea910=yi.zhao@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44JMqmEF008218
	for <yocto-patches@lists.yoctoproject.org>; Sun, 19 May 2024 15:57:47 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3y7c738dvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Sun, 19 May 2024 15:57:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzVAnClXLLq9JWwgIUWZ23AgoQ3VuAcRws9QStfxvxilEqro8it3+9crG6gWDQnVygwIYnFh+P+H6Orjb/U2O4LnQVTjHX4in8szsLIZ4Q0g85fYk2wx86D4KDW3DY6jkRbqaX6rlolKIwVRItlIBw9Ef7xZUIw/LSRnp95yFSKtnEkkJeTYFYq3dJEo9j/tcn0u1G1SJVW72K9leFJGdz/rrI4voDVSkKt1hLtXD6Ko7PUeCsrm37Cd3+eP6xN5YOcMMu130JJzsomjzsf7u5Q1Fj5XiYRhgFmGuuOaBLMuuRGh5LnMlsY93LbebsNrt/W5y6Oo86WNtagokMR1qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oASgWe9kYXCYmzBUktDWVKjZ+aIFU/o5f6bwqWfjFKk=;
 b=WTpW1It7JbZxUwOh8Igc+jaA+57/jE7h2rkh95f6oS6nKeRtrLpwb47Y27TpCcHO8I846uvFKrF/kif0RyMCgXFZVM2XXhpW4jTH5kg/bc3yWU+rf6nQcchao1a7GVUmTHvWVWGlo7tjOUiWis+qGJhKYCVL61z0R/j9hgg1iPxfLmV2H6Tsl6FsYapi0g43pw8Xrp0C3gcFdM5r2JzDJIlOzcxXuihAG3M9EFRKd3c7I+TyssAiaJL+pvSLHE/BJxI6e98zdSJyPSM6UPat3fh63XR/NFJQpm+sIqp4Bpao/V3u2M8bKvgnkwDhdb46KsMA4H0Zbg5obE7gzI0o3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7484.namprd11.prod.outlook.com (2603:10b6:8:14c::10)
 by PH7PR11MB6521.namprd11.prod.outlook.com (2603:10b6:510:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Sun, 19 May
 2024 22:57:44 +0000
Received: from DS0PR11MB7484.namprd11.prod.outlook.com
 ([fe80::4e72:f734:5886:b658]) by DS0PR11MB7484.namprd11.prod.outlook.com
 ([fe80::4e72:f734:5886:b658%4]) with mapi id 15.20.7587.030; Sun, 19 May 2024
 22:57:44 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH] scap-security-guide: upgrade 0.1.72 -> 0.1.73
Date: Mon, 20 May 2024 06:57:32 +0800
Message-Id: <20240519225732.753130-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::10) To DS0PR11MB7484.namprd11.prod.outlook.com
 (2603:10b6:8:14c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7484:EE_|PH7PR11MB6521:EE_
X-MS-Office365-Filtering-Correlation-Id: 6849d341-133b-420d-b915-08dc7857183f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|366007|1800799015|52116005|376005|38350700005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?UkhpAhXm1fbaAjYLRRFInk+siGmt6UoKXO6tT612cisEnZL5od9nQUqsVLZy?=
 =?us-ascii?Q?WLsqizDA6oN2txDyv/FK8WCg8RE7v7Tr53HX7vdlgjja1lE9R60RNKk1TPdc?=
 =?us-ascii?Q?ksgySGlZOkXNpqACz+UpxEf/q+6maTx21H28he75SCkLzhmKmbQSxdiKHnIl?=
 =?us-ascii?Q?k0FSHJ5rsux5/gEC4ow3+CWb6dBgFahXRmlaC3tSH8MPST+ShtR37WoAMD+A?=
 =?us-ascii?Q?PoBoyKMW9sIi6a+7IIRgvWhqvHt0NrU3rVKc/yVgGx3R1czS4OV3b7qMOKXL?=
 =?us-ascii?Q?AbxLVujTkNSlEd6P1KJmnPY6rAmxJ8kKehSc4v8s2LsQT0Uf7wJEISzAh3Jt?=
 =?us-ascii?Q?SOFF7akYCAke4nDTfggl9ERF4Df4oL51/vSo7QMK+z/qsqXC6ukLwNW7tlE/?=
 =?us-ascii?Q?l11/de2Nuttb5UmLk7Ag/pj+w3qKVl1IR2Axm8wcoSbIFL93paFg5Bvll+7B?=
 =?us-ascii?Q?XhwOurLTA/p+250lK9cpQRdcVNfTqGpsJ6c9djXVZJqzkCQKbQOsZvOAgOtS?=
 =?us-ascii?Q?5lNBpJemM2vEOrhxZLJKZIpEBlJ+Vud0FOIhEbigrbjo0Z0GciL0uMuD111x?=
 =?us-ascii?Q?50Cd7Dj6vrm6jbW5zGEuuSY0DFEOBxb4zsWJH3Tsu4gN3JaOwNDypgS3P4Z6?=
 =?us-ascii?Q?n/6CcgH5i6W0qKwLxQa0Ve8z8Dw5j5HzLxcDKp3OCIgfWwtJQ4OHexVQZX60?=
 =?us-ascii?Q?gnJ2koHdmWlpcR3Msoc6ksgkno5/UgDC5583ktpua5ab+9XrTxVLyNdtxbWm?=
 =?us-ascii?Q?SirZzk/qjb155LjC/GA0leTDncU8ux4zfmBDsxQ85yYl52ULqJPm7Eg/2sbR?=
 =?us-ascii?Q?0eIioYVbq0/f4mjxQJO32Mgk3OpsRCLHcEbMemkiL3zz7sMPe/GQ6qDXXuVw?=
 =?us-ascii?Q?MK8efg3JBc0UxNVGZi9N5Kx37oh+jkiyg6dFI6pZh7g6E2y5o3522RC8MxYu?=
 =?us-ascii?Q?5OI13fg5BpLrFAfWWugBKnZY9X/CXMaRlQ8A0HMLOrEv9WsHMhoYhhfgTtxT?=
 =?us-ascii?Q?kmYR2SFRWtNCdZCYZ9cGg0ljr+Ql/M8YLCga6BVcokN6Cr58umOzMV04Aywi?=
 =?us-ascii?Q?lliiHpfCRsUTzx+erAYDrtJlstS0RFE3vPG9iATAnBTts5PddveCDetKNX2o?=
 =?us-ascii?Q?r/Vg+nvEEJbUmfphRbbUYtdVaC8DycpD2MSo8c4ZEUP6mclUltYE2PQglGhU?=
 =?us-ascii?Q?CPilUorcq+hD/JfjUQSd91iaszSwyQZB7XRp34eI3TvRcKUKrwd7i9VfCESP?=
 =?us-ascii?Q?67d/qNno6yWC1LqJzZGGHJB4HnZlj3vuEj7XNHrqDw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7484.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3T1xyTxq8POVqjEA+RcbRFLbpnA5dotxTMjAzCfiX8rrg6vpSAweUuM0c4+q?=
 =?us-ascii?Q?7Hzy0tnv1UqRMeh11sTfghxn1VtFVjuhLWVeDi4ySWvq8EO0qrmpAwTtRmdM?=
 =?us-ascii?Q?ockpe0LV6p72PZoHxomo1bFanJyv/xJPeNRAPP37T1F1X/bLIZhCo2iMk8Ne?=
 =?us-ascii?Q?vQ6Upfh9LZxN7G5/7NHc0lVnBKbcIaUKoqBiYlt53H7gJq6v6TamGhkbGkhQ?=
 =?us-ascii?Q?sSlpSsuvne3ebT4193s2+7pjan7LRnegLkAG13JT5CAvPzeF6jepFQTP2DYL?=
 =?us-ascii?Q?ma5W5hpn4mVl5Zarqrc2dwV4JOqsQNNoXyynOE+gL9Yzd+W+srJVeDqVpvx3?=
 =?us-ascii?Q?dNMRxGufLerH0oOCTpNLdDZmCxja9VNGaeURn8uo/anKPAf92WbPT925lXAK?=
 =?us-ascii?Q?/n7URF32rsu5K+M2dRnueNCjQwkvBqqwvlSW28jdBj7gi2hHKKBJmwvWQ8bv?=
 =?us-ascii?Q?rf5CSdNfLwD0lITy3mQ5LkoQtzb1kKd/4k8LE1JJOULIGAOZXt0dNxszaooA?=
 =?us-ascii?Q?sT5bpJybUihe6PAzXUCaloe6BACml7IuOvRZwLUbf9el8PvHPNH9KBLao7hl?=
 =?us-ascii?Q?cZ+N8v0jr41CVrvwNDP5oIU4HNuwvfL9v48wdLFbH/7gYcx+icwbOE6buKbu?=
 =?us-ascii?Q?lsZyqBjl4r6K2rYAdloWsmhWjjM1yBC9z3Z5HUQwKG8BPRkZvmPKZN5gzHbr?=
 =?us-ascii?Q?GQVaux5rrF3Z4jJcuxmu62jjZ0pBPwLGuxPxYflC5kmEUbyXn/0Vh45HBPhD?=
 =?us-ascii?Q?9km1Rr0tIvA9V0Tt6bx8S1LasxKN97jkMn44wnta6ZHsD6Nf00CL3HrDBi9I?=
 =?us-ascii?Q?Uf2z58Kog8BAEvyMm86YXEtKXcL8Wz44r/X+3g36yr4RnGAMBjOkKun5X9Ad?=
 =?us-ascii?Q?VRP4vpJO78nthWz/Pcu4V1g3jwTWE4T/h2tYFTTzmxFGwzEMSFuO9d/e5frZ?=
 =?us-ascii?Q?CCEXUgSKkoqTGAyf7CFb5SaaVK2/rfjyqV5QxtFirbynvj1RkOW8d5MdBkMA?=
 =?us-ascii?Q?SltXdL1oRxhgKMbyr9qPh0ziErS68yPpNHCK9ci2P5l99ucOks+TOHOUuPwm?=
 =?us-ascii?Q?ITV0ug67XIkuN73AhejA5oXmW6VRAo4lQP9YVmSd/WWi6s8dQrJTU6IuN7ix?=
 =?us-ascii?Q?8ZMjevJB6TvG71WJh7PD7IvJIa9p6ULoerufu4Va/vzp0MizaQ7CaDjA4v7O?=
 =?us-ascii?Q?3Zy/Xu7kGEhZSbAdP48TgTuBuQecd3Jw3V7CocQFWh6g2YSmuG/hp/HmCrA7?=
 =?us-ascii?Q?mY0tHV7gD178sxzbaEHb+XQiDu4i0CY+Vbm8Wf80bP1ZW59ksMSTDXco9FuQ?=
 =?us-ascii?Q?JVOH3wDdcBQsoWM1ZvWEVi3jVR46JnbmZhRd+kxKvza+HaziN4hqWkZkSNyQ?=
 =?us-ascii?Q?t04clw248mujPsiErgFoVz5KniMBrDV+0boc1+kxwO5HO5MxQioOSi4O4xcZ?=
 =?us-ascii?Q?8cxPjY9suQCiLa4EGJFPChOpGOIoq9FbIz1/1ShF6kWlIIST0u+rNfrsOEjL?=
 =?us-ascii?Q?6qqq3Pfy3Xci0ubyrqjNoA/gPvdr8X2mUg9VdIze4COtro+AYHUQSLu7RKXI?=
 =?us-ascii?Q?T7mfZnkYyI7nNUUHNH3q+4HorYn6bcoc2aKLgbbI?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6849d341-133b-420d-b915-08dc7857183f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7484.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2024 22:57:44.6846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jw3cFABkCGFdR7oQ7Mp00wOLNknBgq+Fbved41ghhVeToh33YJzeaXg9Qxy/oIIcX5dk2qzEAIohoBz90TJang==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6521
X-Proofpoint-ORIG-GUID: aOnXFMYnfiOxN39-D60FomlaAdxIfRk_
X-Proofpoint-GUID: aOnXFMYnfiOxN39-D60FomlaAdxIfRk_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-19_11,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 clxscore=1011 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405190201
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 19 May 2024 22:57:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/161

ChangeLog:
https://github.com/ComplianceAsCode/content/releases/tag/v0.1.73

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...p-security-guide_0.1.72.bb => scap-security-guide_0.1.73.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-compliance/scap-security-guide/{scap-security-guide_0.1.72.bb => scap-security-guide_0.1.73.bb} (98%)

diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.72.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.73.bb
similarity index 98%
rename from recipes-compliance/scap-security-guide/scap-security-guide_0.1.72.bb
rename to recipes-compliance/scap-security-guide/scap-security-guide_0.1.73.bb
index 549f04a..84f5a11 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.72.bb
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.73.bb
@@ -6,7 +6,7 @@ HOME_URL = "https://www.open-scap.org/security-policies/scap-security-guide/"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=9bfa86579213cb4c6adaffface6b2820"
 LICENSE = "BSD-3-Clause"
 
-SRCREV = "7fb44f78bf33232aad587e87a799afcf576f9b47"
+SRCREV = "2bf9d43840d3ed36a25262d4f45a4015f9b77d8d"
 SRC_URI = "git://github.com/ComplianceAsCode/content.git;branch=stable;protocol=https \
            file://run_eval.sh \
            file://run-ptest \
-- 
2.25.1


