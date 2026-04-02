Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E36D39414
	for <webhook@archiver.kernel.org>; Thu,  2 Apr 2026 11:09:42 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13250.1775128175210193443
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 Apr 2026 04:09:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=rwwJYZjl;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=8552b40fc7=yi.zhao@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63203LTm2296855
	for <yocto-patches@lists.yoctoproject.org>; Thu, 2 Apr 2026 11:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=+c3pZYtvIBzzC8fVXIgB
	kOTkwkRnMDlZEyivnMStVc0=; b=rwwJYZjloXuJElAE88AJ8sToV5GSkXJsKrH2
	LXIOwxzoixSL1xygshz2zw/rXCUw5ezTbmRXNke5ThoRCQUz0aCGlNd5RftUlPE8
	cOpVwBzywjdHHbD5A13/Z/2BR1/KUAxOfpX3BAR8EnkTek/J34pIv1UQm3cVLI3w
	QRQziFWWVqJbZXKAiwItzLwX7gBg30mg5pkQ7c+IM4OM2skjJad1Oj/CVLeP+9h9
	0jhWIpCfrdw8Iv2eB74jsefpNYY7qiYitaJVhV8P7sZ4K4dzOrT2BcmOeL9YXsLY
	3h38tTi8fquc/gDV5Xe8fEoEfdCEGfOjmbts9nfxLSqQpEBZZg==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d646vyrfg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 02 Apr 2026 11:09:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXvL0e5Zr9+uOCnS/NmEja10IJvJa5n3+RmsCf2mxz0Rf5B/qWMEk8D5bGL/6M7pAvQe7BeYj73naMMmuRZBcEUfeqt+1XbYjPjtiavwLXjBefBJzgnTgSaKiVLmovgat5uCaDpul+EC+gi7hXtL5TnfvgM0a/2BkIkW0E5C5W/drd4jrMfgP8J3hLatGZdc6VQJM+V8kPfnIPCfu4a3xIXlJ31m+ObmoStPEIpxu2pocGR5T5hwAhMCneIrLOinokmQUWbkewq62bUG6Jt+8jsMQ1hMHbMZnge1JFsWO7pTv1gidfQ6T6pxOQVNmWZKt3E9RgC6otuv4ZeCIgugWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+c3pZYtvIBzzC8fVXIgBkOTkwkRnMDlZEyivnMStVc0=;
 b=etgXQFCBdPY5ZKYAhq/LVv8ysYLxup19c3aICVp2D7vn/WESi0MntJcWPzd+WgMjKLITLHOZq1J67d53ibItw1NIK5IjCuKrnLkjZZ24UWcGGtSgtSMhHQu72nIZwRFM/bWw2YyjoBxMKSjDZtgDLZitSLsUbwdwaIV2+a4bLuKVbO7QCxcNSMkCpH2i8Qh2REu7DNu+RMCfLAciwr0I5+61ScSYbIrzldWUDifDhN+Qv/Oo5JTMjp5md5SPKnpHEeAw2LJSIahGebw2gLE2Eh4W98UT6mdkLA5Hw+kpUDM7Gb/Vifn2B8Cfc28bMDVG/SBPsss1U6LuoTWk13Swsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 SN7PR11MB7708.namprd11.prod.outlook.com (2603:10b6:806:352::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Thu, 2 Apr
 2026 11:09:30 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831%6]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 11:09:30 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH] refpolicy: update to latest git rev
Date: Thu,  2 Apr 2026 19:09:16 +0800
Message-Id: <20260402110916.1089259-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0121.KORP216.PROD.OUTLOOK.COM (2603:1096:101::18)
 To DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|SN7PR11MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: df0ecf13-bd81-4e66-c572-08de90a85018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	h/ZZS6htRNKES207O0T9s2vUsapdfSXLQXrHUdJfGqwo8BSmpLCqtdRV62cqQ6/+ILQ9aIpDbtYW1Qpmk9is2m0AEDg+GeEmSQgz1OMOzI78/5Xpi0iM3Yg5DUvRTVqM30MuDv2+GycDkH02Xdz+dnGNhHjH8Mt+pyYWfZhqqSdfvP0xQaOmvP3k8di6n6HAJCsAZYWjc0DXJ1qv0ETopbuvODVKEQSCKr54ZUf2G+kF2taAXPnu1ug7GEsqop50XUi03Ts/3uMFrO24hQ8vFVtkcmPp/TVb54aHBLPGatrUX9+jb7CSoAL09iGqqK/7TBG7M/l+HXTV6URwXdxE4B2BCt1OmBSLxuXlrscuZHbNIpjt+zdrkyFE/+Qx67qDDlmz8FI/aTPqQkhPJ37kfEFD3pVq8JO0RSZJucwOyQKAx7jES+r16caOT0Pl9V/oQBJcHhP0D5xjgMNbHeUnvWepF8nBEbVQly8XFbWBMYBBwnM0V3mAnkgI9bIsFTEXFKNe8R5N47prLypib/2vIUrJa1Av3Hyho+Qs44Bm06IiKj6abDzu1OLXAOT58mIyr3dYb/frFdgH+zrpdW3IVuCxSZxg3foHghYQB6GQljZtuASOOH5VveczDbBCW4fiz0yujNtrxycUfrVBGPAkcb09LDiDiq+Hq7s78N40miqrs7LI4MK9bthubcsCZ7Qwv2T1B45H+iZFjkLi0nW4jTT6uRujV14pw7xWJ80zqKyy5deV15FKt9W8665ARd8SakLGteagFLY4C+ErpQRqMyhENCLg+y0ZmtY69T7mKuQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xXz/gvJeOJXniV6KElV/R9fWcOBELlFRaJtQyX2MnibzrvejvtsvAiBm7b31?=
 =?us-ascii?Q?bgaHxbkGvZC4RI2aWtf3dtU2qxPUW/7JR7W1yQdd+PN7aNpv6fvfpf0YiCxa?=
 =?us-ascii?Q?4Vi062UiOAa/7ZSrnL0E+745PKU3WAZV/MS1AgINBABzeMv/Md6+r1Qi/wZZ?=
 =?us-ascii?Q?yc35xiyD9AYuh0SZgT05voPmxV3LfIO3i4tTGTgQaYuDG3O6y1e5P3OHoHX6?=
 =?us-ascii?Q?WkFMne0jcSHExKUW5yk5VANOCstvWcNUbQv15eKI5pESxUsx4NLrJOSjXQ/4?=
 =?us-ascii?Q?tGeXJkmZXR+PhSITIyLBjd19lSs03/ckTsTaev2tKRxsR/FLzTEwmTokpFMa?=
 =?us-ascii?Q?oyiqmgcNlu7RuDsbWcw2vBdWe94UMO0CQcoFQ3Xg3fW810SoaKD4XhfxvqDc?=
 =?us-ascii?Q?yNexXx4iTmRgrO57KYMoXU6HOsSP/inciXhCCkFZUnlQRMiLoq/9QsEhnGl0?=
 =?us-ascii?Q?Smtvow7gQ2fRsTCzrbCm1ab0huVdtHMJ19To1jo3bOO9jc+O1/XUfaaCBoMD?=
 =?us-ascii?Q?i1oNHTey544QsBWkBdXteMAbJczJr8usfRHmY0FR2svhq6cNMeNf3uy7KMO6?=
 =?us-ascii?Q?r9QCfu3XvSlZv0b1zC1zBJcvRIMIhNnKDDOhGPBf3ING0pla/BBW6mvas9BS?=
 =?us-ascii?Q?3ScHuCv/Ti4EKqm7kaqfQROVus8DRPaZIE9nU4hpvXaHI8D3B7p4lJOPvQoV?=
 =?us-ascii?Q?CXXxTVdc0udyKL5HgJJNWRgtQVZUGQsOScPVvD6XSw7su2pYY7yYQNvI1BYa?=
 =?us-ascii?Q?B5pWsizqvukfQmRsNLCec5e1fCRrne0qlSuehRbDlD8Ux0j90hrUBs7AhCtp?=
 =?us-ascii?Q?8fNvO8zVYeIselXCzTAWb2CSihvI+pKcOS7paz5uvDWUAQMhn7uTDEZ9ztIY?=
 =?us-ascii?Q?4q/gD3abE8UeHed0DsiybDeec1noN/YkZ91fW8uNjDICfqwrGb5JCu7O3F3/?=
 =?us-ascii?Q?1WKx9DxeeRMfBd0xaIEDIzCZjSpLAwuLwMOsthWoNvhilucBbww+DwM3XzbU?=
 =?us-ascii?Q?HGFZaVK1HhfW2ZWOMT++80H8tkpGvvMTrIy/p/RlnT2CC2ZYMCwT0b7NCaur?=
 =?us-ascii?Q?H+1pL07pEs7CrcURaO838tKSdc2fSliallDd3S+UJa4VX4oNcI4SMAIKsS0u?=
 =?us-ascii?Q?NdZalE0n4IvfewogtnbSdm+dG2msmitbFLoTI0THfUKX9ETEXe+r8Bq1COKV?=
 =?us-ascii?Q?shKO8BkvzNG2YJS8DYtJtnb8iy87VqophDpc8qpO0qKG+hrHdNeCMfkQhnYL?=
 =?us-ascii?Q?JjqiJDSCdB5gpEBERnK8oTn/Xt7m+TEySYxnTiIwmO7ed5I+jQJ9uL0C7Xg9?=
 =?us-ascii?Q?8ErS7SJZXhW7EaFu1eXCzmK68xv0sUuRffVXRfcqsBUU6EtbViVlqGv8A5MI?=
 =?us-ascii?Q?0IfTlBrjw1mq4eAdST0U1nkCJKhAHtmPPYoHofTGEZHKwL+tZuTfH3yEW+EM?=
 =?us-ascii?Q?hjGYYwM1NBTWDTdlY7WOzQvvPmnUkP2e5xd6KJNynppShDgdS/2qVLns3+2I?=
 =?us-ascii?Q?Ngap91nfIZqHIUR3k/mCatDyCMFYRfRayEJNH+CzTlnDp2bncKV7ib4OApHT?=
 =?us-ascii?Q?KtZyR0EDq1IEHYLJDhKA/BnEkR/dpdKE9Q3SgClB6v1vw9rz+4OCyPhlKG8U?=
 =?us-ascii?Q?W/nb/PD+5wmUi8hJDeKUAVqKXH9cVLu7ehKIHAv5SmZrOBHkVfsTrhWfd5Kq?=
 =?us-ascii?Q?Lbf7lMaXXjai90yNAmsZ+eKFwVrX5HZsF/Sj76FNBJhWlXqMSd14ugwyldOo?=
 =?us-ascii?Q?uclreEKnOA=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	UgLwlM3xNZu+fYSWkwHgtuM6OaPe8jsdrqAvVTcNao2ld2fFSdknAPDF6HzJg8lRed34kGC7/sr9JlFgeZ5FhzVLCgzmIJ6xfIEScL7TetTz2+GArqXEnGotnDWx8gizgUwNEGUWTbU2z2WPK/D/azTVZu76r8HMvwZoSzt71cRYzmkh+g5PWDoCetyymb5A3dbRcIpiPSBbCccZpprLgrhs/K/7HERAtDZtDNVU9bAHgMCuqnWnKXWgLjfWOZ3CCseGLGxQo+P7uyKYj5HpADjQ6nmhZzF52I9ZsUzX6YpiKoYptAi0vi47JWplOPhxeaC2cnTbTzUTpw1NBLtmmw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df0ecf13-bd81-4e66-c572-08de90a85018
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 11:09:30.8096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtjmARtDFDM6RBFFGnPQgKANrqBQpTqD3FraPbp3Wli+SKrt5gX4AVH328pk6VFYsaN6AaeMNJBs+03TziziOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7708
X-Authority-Analysis: v=2.4 cv=Zqjg6t7G c=1 sm=1 tr=0 ts=69ce4e6d cx=c_pps
 a=5ROfPwdIRWh2zNeQ7OwrBw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=NEAV23lmAAAA:8 a=HEPJ--p_9Lqn54SzGH4A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: FLXMuyc1efwVlMlubG2Ng5NvyjMZBRFP
X-Proofpoint-GUID: FLXMuyc1efwVlMlubG2Ng5NvyjMZBRFP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEwMCBTYWx0ZWRfX58zqOK/TX0e9
 PR6Xp/EiARRaLtC7K1HXciqaQV3nCjw6IoYpoYS+kauQ605nNeB8JM2kSh1NCJTYKHe81Rz1lov
 Pi/+xcI09/rThowjlwWc9cGGUHBFughuOVjI4Ww64lsuUJ8CNLYXjYWoBHlhJYuncZEyTWtuW2r
 vmZWpURxXftlo54e3/v23xstpmWy/hCFjwCPPRyDjmK2H3YD6Y7iuYZ1YnbNtv+pjbUROMC4tbA
 EVq/y1ed7Z5gtaiQIgsVDQ9InI53FI6SODKrwzSTlHuI8gT/Yqzp3IM2jLPRklvnOVNaNSH3Fi8
 SbDz6APZ/5RcZrTvCAcLohL4coREKUF15z9gJon9i4TXoWrSa4uPc8z3SwRJyMKNb1qFp5aS8KT
 B4Dzz6B9whDQSCT89hC0+eIX3mGzOQawe1Pl73KQeI+mBgSMGMjL0iNLhp6Q9vOoXv9WhVmdubF
 JmqAiOIXH0X5S552RNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020100
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Apr 2026 11:09:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3616

* 9ff571c79 refpolicy: donotaudit rsyslogd for net_admin capability on self
* aa350841e refpolicy: Added policy for modprob to read blacklist-video.conf lnk_file
* eef80d415 refpolicy: Added policy for systemd_user_runtime_dir_t to read tmp_t directory
* 2a85bb850 refpolicy: Added policy for rpcbind
* bd3c6e00e refpolicy: Added dontaudit on docker_t to manage /usr directory
* 2aad2d57f kernel: add kernel_read_transparent_hugepage_sysfs interface
* aacef5aae varnishd: update fcontexts for vinyl-cache rename
* e393fdc3c virt: label libvirt hook scripts with dedicated exec type

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...licy-modules-system-logging-grant-getpcap-capabili.patch | 6 +++---
 recipes-security/refpolicy/refpolicy_git.inc                | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/recipes-security/refpolicy/refpolicy/0035-policy-modules-system-logging-grant-getpcap-capabili.patch b/recipes-security/refpolicy/refpolicy/0035-policy-modules-system-logging-grant-getpcap-capabili.patch
index bbd40e8..8c0ba66 100644
--- a/recipes-security/refpolicy/refpolicy/0035-policy-modules-system-logging-grant-getpcap-capabili.patch
+++ b/recipes-security/refpolicy/refpolicy/0035-policy-modules-system-logging-grant-getpcap-capabili.patch
@@ -1,4 +1,4 @@
-From 1960cf45c37cdd9c11a012fe641dd37537b6f6e4 Mon Sep 17 00:00:00 2001
+From 2b90866ebd50527fb3cf099e16a6f5bcd09a9e39 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 28 May 2024 11:21:48 +0800
 Subject: [PATCH] policy/modules/system/logging: grant getpcap capability to
@@ -21,7 +21,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index d22a3207c..b1d9c20d2 100644
+index 950aa3f8d..089ffc768 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -406,6 +406,8 @@ optional_policy(`
@@ -30,7 +30,7 @@ index d22a3207c..b1d9c20d2 100644
  allow syslogd_t self:capability { chown dac_override fsetid setgid setuid sys_admin sys_nice sys_resource sys_tty_config };
 +# Rsyslog configures with --enable-libcap-ng
 +allow syslogd_t self:capability setpcap;
- dontaudit syslogd_t self:capability { sys_ptrace };
+ dontaudit syslogd_t self:capability { sys_ptrace net_admin };
  dontaudit syslogd_t self:cap_userns { kill sys_ptrace };
  # setpgid for metalog
 -- 
diff --git a/recipes-security/refpolicy/refpolicy_git.inc b/recipes-security/refpolicy/refpolicy_git.inc
index 3c6ca0f..4b2b186 100644
--- a/recipes-security/refpolicy/refpolicy_git.inc
+++ b/recipes-security/refpolicy/refpolicy_git.inc
@@ -2,7 +2,7 @@ PV = "2.20260312+git"
 
 SRC_URI = "git://github.com/SELinuxProject/refpolicy.git;protocol=https;branch=main;name=refpolicy;destsuffix=refpolicy"
 
-SRCREV_refpolicy = "440d3f5f129985c0193edff9948a1add42469692"
+SRCREV_refpolicy = "cffa6e2c93e9f9be74ffbd65237f45ad6e9d7c55"
 
 UPSTREAM_CHECK_GITTAGREGEX = "RELEASE_(?P<pver>\d+_\d+)"
 
-- 
2.34.1


