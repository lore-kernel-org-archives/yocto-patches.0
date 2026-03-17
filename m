Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A14FD877F
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 14:27:10 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.77223.1773757621340017821
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Mar 2026 07:27:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=LC4CfXXw;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7536f4cc45=yi.zhao@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H7BgfF735928
	for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 14:27:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=shXKwwCKYp9aOWKR71c9
	Ex+tkWUDnfnEp+6bNxYDAVE=; b=LC4CfXXwUhmQQboDSzBUIWSPLM9RuCryU8fY
	HNJYZsdJzYqZj2epQBjrKAbbf/nHejNl6DW97aMuEsgk9T5NQCFns38mE5mTLD/3
	ZFixwRdAArZB8F3C+jbVCINrbAC1VcK9cYxDNJkgSeZ6//kTaJtmPfKq5Au/t7TP
	8k2oxRmrcZBp1YQJvVHgyWroEZEHl7cs2BdM0y7BZvIVPxCDiR4a7iBVxa3D1Ih7
	HFBvHJCFfZIKv2LWOsOsCPch+mkMDgw8OONq8hP2f5PMc+BnxIDu2vDI7UE74cW+
	3rd3i+zXAL+KN+dqWM5/Eb8SzJF1HrzwdNFJA2LlaWJ+tCo8XQ==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cvvvykhj0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 14:27:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lAzazArGXmJr46VSs/WdawWLnog1p/0IIeJK3gJjLq9AMJd3IXT2J91vkrMW4ieYgNNUACOl4gBWDPbDHAs2rXnRFiu8lwroqelkPYGNeZQ5sYkATDxnJh/LFyFm0L1dJgCIVCj3UzbPd0LloWltG505JxklAHk0ZLgbxj0jbwhIOSJ7WvAaun91qqxEOwWxgkg9St1RaZgkx09uD2EQalqRY+q/odAz2ROtq65pmp0FzqIK4o+YtNHeCljkBtmFzAc4zzO+R3NE5/FX/+x+FFEXFBBQwiiq1AjiLzqUVTG3zoC4jRI/g9nrYowp037MxcAMIZAbvFHNGVmOX6zyuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shXKwwCKYp9aOWKR71c9Ex+tkWUDnfnEp+6bNxYDAVE=;
 b=agCaQk+35yXO71T4o+CWaWtq3tres3LZNuiKorxVtEygYtqQdOBvTc9VtEPhDkJ8MTl3EeugzCJBbiyuznE/sM8+IejwK9X8u8pXlo8oXBAmByYwT4kz5rWFZ8yteuoIMaCGNuQrHxiyAvVvR6OrTaSQiSWMQl6ZcIEbTG5q+TNm5w2PefJwFMab2yhdSDOPzWj8DzYgmFeL5wJgnB0aL70SQcydbzKXJXaPBfAbQziAFB+xlzZEvIitIxlKCOlkAxs8JSSvno2BHwKERmixlj5dD9tZg6CLehco9pxOi1LcGr7pyhu9JfzSk/Ng3sAF7DVf82dVrO5GRiukENa1bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 SA2PR11MB4826.namprd11.prod.outlook.com (2603:10b6:806:11c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.16; Tue, 17 Mar 2026 14:26:58 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831%6]) with mapi id 15.20.9723.014; Tue, 17 Mar 2026
 14:26:58 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH] refpolicy: upgrade to 20260312
Date: Tue, 17 Mar 2026 22:26:43 +0800
Message-Id: <20260317142643.1903233-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0171.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::27) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|SA2PR11MB4826:EE_
X-MS-Office365-Filtering-Correlation-Id: ed5f7ce4-05fe-4288-cf0c-08de84313edb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	tprluGVVOh5Wji7XYoo6ONAGkl8NQS9lLOnYdFyrGNZPEPNr3Q8w332fq9pMWeHt1ABTxcgiABU30Ia73YiF8MUiL3uOoF/u01TGredxRHnvsnECsiElbJKIRcHqTHubIpiGWI4ws96s//sm8aM0DnhluOJM9x3Zg9MSPP6LOveFVDTA1/+WtWxmeoWzXh1mzsmTezVBYXoEigKlMHRzT7ybqlwHky+xilKZ7QXWhayJA1LKMBtNQ/9jtfewI1QZI4Lv9l3fg5av8oi8VD91KzGE+DLpQ8hnXNokJqIysrirsD3KhuggtmzSP+4H2S6BiC9gnjZufPG73oJjTE/4PxiqQIszT3E34LdugDzZpnhNZYfOIA4VcBYiENDNGmuLE9NSddhPR3tg+OJjUmPDy8LoYbEhX/wbu/BO/yIkTTF5N0TsoviV4G9JMRNYyw/RxGN1d4RzZD7NSraaCrsnlIaU+sCKy0SYz6cSdkzQybyZXo/c6XZZC0MTYOGsP9D0ac8/SmFJQ7BFn0qkeKzCUjZh8HewemXTLpGBFfQOc1W7olzDLZnMbmFcfsAO8hpN4RnGtFrO6HgXLoHdyw2/C8XgacuOxmIKvdaVA1Dnr0xWLdqrsKz823xQYerFY95qkq/CWdtqijwH8iF/JKmv1BNftXqZUEyNDSJ7FgqjlwUG2Z0SpE35IbC0pHEcBLDeAmWqGCiiqWjgGGFaRC/8/7A5aOLPRUPxjgxIxzmETJtMym4lz1JGIJRXHl9Jpq/koMhvIDSlnF9ZzPyBsdZI7w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(56012099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?aHH8vpA2JJrSbYg1eOSuw2PcMve7qP1WZKe3pkPLuX5FFqYbQZpA9Vp7yZuf?=
 =?us-ascii?Q?BEdpVTbU5IekN6Pi/OBSTP37hwqPBl57WYPeZACKvAS7wZIxv76ZLYVPe9oP?=
 =?us-ascii?Q?OSQ+H6pYhb8VL+KCgH00X2vihmTtAcLEKM1+cb95pDkBGBge/c0xLRex1JjV?=
 =?us-ascii?Q?etUsnHIGsVlNDTnw6swF0H/U5EZvFMTZeZRKlV2AcGThsBFUxiXV9NfgP6YL?=
 =?us-ascii?Q?kVFIoqmvsBfhMg/kXYQ/3mJ76XdRE0/QWyphu1DKfKUIpS5owvuSKneEZfeE?=
 =?us-ascii?Q?s/O+F2ysfZOpUB2kmNmv1Nhi2iabljxBhrbnTvnrOj5odbx6627Uggb1UzY5?=
 =?us-ascii?Q?2ueMWhNb1Q+OWikT9OpmAdlR2up68KgqrDYg2+WPWIJLQMvJy8a9ekdY6rzg?=
 =?us-ascii?Q?E2WymzdefC4MWUbB/NZpZkk0zxrXHYC8dCmumJdiJEZD0fCSGk5eGzGWZFM9?=
 =?us-ascii?Q?AzXep5E5F3KePtw+GiiKFrHwuV2kkT9WWg+MDs5eS7/2Ufxoc7Hv8f40KGfg?=
 =?us-ascii?Q?UcTg/WwmkormFOCW4Dh5Xrj5oz8USFTRvIsuey+wAtwdvoiqnOgq76aAlMr+?=
 =?us-ascii?Q?VfsilXE2sE6h9w5+hL0dyul4IfWgFZza0XC2vRnv83Na2x44mbFA58q3CndC?=
 =?us-ascii?Q?HJ84gcm1YOGyoaLZtgqeeJE5PPtlo7oFOAgTVBHB1MaYSJZ0oBTlY8BbXjZy?=
 =?us-ascii?Q?X93sdOpcYxB3/MH945qoorNrrzKic9/JegPK6DCztkQpAygSK3JJdRq1a0WQ?=
 =?us-ascii?Q?rVNhcgDbe8pCnpbd+E2plsAZuUj4S9NdHaHIeksJW5BK20b302A5rmuCYcaY?=
 =?us-ascii?Q?tQZpYt/yE1aoGq/lwkYlxt13utaT/3KxtqKCJuoGJ9wOET5l2zIgIVij5kAi?=
 =?us-ascii?Q?gU0cffYZekM5VmY03le1/Wjt3xtuAKmu+GY1VS8Tzklc74Ln27BDH5/3oPMk?=
 =?us-ascii?Q?u4KHVODGf3Pz+QoaRaEx/EAlQe0+4KUsa0J8526dS8Q4BLkWQhVNxbC12ecp?=
 =?us-ascii?Q?s/reWjM6RtEe6XuSN69FY8/a26N2oD5W+CX0QQb/0Udn0+UXIMRom4kw+soI?=
 =?us-ascii?Q?8Ckt9Vpb/PkH6AsATSibMtPpNRxngxWjcde8oY6R1wb5QOQH7cqWcOb4ExXw?=
 =?us-ascii?Q?d5FMdM5LmmREewbW3LelMTy192m752J41XvFt2Et2EXD2efUO5EEvzQyXVWV?=
 =?us-ascii?Q?J9+HZGq6kl8a6T3bAHRqWVRTgfV9SKIpnGH85rO6WJkCWRNK6mBHg9AgYMK3?=
 =?us-ascii?Q?qgLjgMF59VH5GwClv9TYJ8VFgHNYsajFzN1175U5k1LfdBLLTt8pQYVEodC1?=
 =?us-ascii?Q?aBySjkJQrynGjdtFlkF6+314gZCwxA5FXXZxafjEnQOGQ9l0jbQz+50ehkzO?=
 =?us-ascii?Q?6hLwZO/Z56zjbJ6fuPTxAPl5M61pRzEQfjcvLRlAg622lNffFqf/jxLOO+MR?=
 =?us-ascii?Q?lACl8pNwpBb64tzp2u6kFmn9XlY59JZvp1Ae69VDfCiq/bz2+ONOdGDBnWmY?=
 =?us-ascii?Q?CLfgJzpQsg85pl5nn4A94oSFdE4CgJUiIHAPOZ4LVRjEx1X4OBhxQEmituwt?=
 =?us-ascii?Q?BZHCcugwoYis6eFK/AQut5dygJXiurObe85FyYK20JObFqxLCXtnwxL3slq6?=
 =?us-ascii?Q?FcqLAhJjtU0Os4VSX/NpwS6FbujxvcEVXxXsn3L4GuvOgyXiomsZ225ZAWxA?=
 =?us-ascii?Q?CBltV7nnEOwpjdnepwdqgLMrHdNTOumeKbVpRwAEE8e+mOVdJWLawm5zNn5x?=
 =?us-ascii?Q?3v6f9QWdbQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	FnrE0qZItWjnCVBZIMFpemmcIo3tZkpsjhdXeTAyajJ212bgortQ00dco9db6Whr8lK4rk52BwS1z45de/HmYp0Err4p1sV3Puk2vvgdO1Rz18hdzx0vjJDWPyj48PCbI9y1CX1fc/EJz8J0YTDoVYfdjDj3ua5vdrU+FJ5qViMw9tziw97jauiGas8j7w/Fpmmi7b2pOnvWSR/8fmLCEC+PAA3rrnT18/iYKxywN0UVqEbeiyaFKySIHjcCtUjlGw0zxcB8oP4R9cTcxTRECAJNMjR0zdL1OKkdV3b/6Vg3o0CeAwAO3B4JKTqvJB6sqlhbFlh8xbyCK9BWo4ievw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5f7ce4-05fe-4288-cf0c-08de84313edb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 14:26:58.0013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ioaq0BJ3TEFl0YA885k00/j5opEa9+o9BnbxNSoEhSF6l/siiEul4rzh6eU441YyCByGNWrCl44N1s73NGwfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4826
X-Authority-Analysis: v=2.4 cv=E4XAZKdl c=1 sm=1 tr=0 ts=69b964b4 cx=c_pps
 a=eZaJmiuXqmfvnt2b4sL4XQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=NEAV23lmAAAA:8 a=v2kMPd35iUNuiGckQlsA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEyOCBTYWx0ZWRfXxGX/W3KbQt85
 qR+fdM6JN9BR3McMRX7RWov/qlRUVwZqesMX+3fLujtJuKKoLvk65Bs/I8HgSuTH+uvKv2zYzij
 Ao7gbhSC1di7cC2vSX8OvdszDjtX/sWUzntjbVasUH3OCD+RP9IzgIqgW3UVPl+d8hHd1/85WBy
 FbGkpM6dVMa8aFsFxAImsU5cr4rWDyTSwaiQ7aQGBcMu6m5cTWCgVAG4UJDjAW2BPmMt6ZJvN7m
 WUR5yhswtY/u6cSoELX3LhjG3DGBbNBPZMWsMM5GsETwDh6SJr8IcxbRcLUlssQ3e43rsWgS6Hu
 FO9UjngtC+OQcCMUVl06kREGPd990ETMlJVjGOG8qfoFg9d5r9n+BdSTviPrqWnphgSC1BwbJP7
 6LCXqYsGiKVuzUvwFSfkREuRAmNoXsMwi0st3JIPSgXd50FtcQPKELvdyJ97uIiGyIYjzi3iIxD
 6FkwU95qHOinvS5tU3Q==
X-Proofpoint-GUID: DeHAyBqZeosY9OEFV7k2Csv1KzH6M7wR
X-Proofpoint-ORIG-GUID: DeHAyBqZeosY9OEFV7k2Csv1KzH6M7wR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170128
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 14:27:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3489

* ab1fbc994 systemd: allow systemd-sysusers to send audit messages
* b30600233 systemd: use systemd_stream_connect_userdb() for user runtime client
* cf596dfcf systemd: support LogNamespace
* 113205a65 sechecker.ini: Add net_admin to kmod_t.
* 89379c0b2 kmod: add net_admin capability to kmod_t
* 1efb8ead4 tee_supplicant: Introduce SELinux domain for tee_supplicant
* 0e00aeb25 Define security policy for DSP FastRPC daemons
* cdc9ae133 chronyd: Add urandom access for chronyc UTI_GetRandomBytesUrandom.
* 1ffcf999e devices: Rename FastRPC interfaces to follow dev_ naming convention

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 recipes-security/refpolicy/refpolicy_git.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-security/refpolicy/refpolicy_git.inc b/recipes-security/refpolicy/refpolicy_git.inc
index adf9930..3c6ca0f 100644
--- a/recipes-security/refpolicy/refpolicy_git.inc
+++ b/recipes-security/refpolicy/refpolicy_git.inc
@@ -1,8 +1,8 @@
-PV = "2.20250923+git"
+PV = "2.20260312+git"
 
 SRC_URI = "git://github.com/SELinuxProject/refpolicy.git;protocol=https;branch=main;name=refpolicy;destsuffix=refpolicy"
 
-SRCREV_refpolicy = "2cba8023863718709d0349faf62a9f4da2248a3f"
+SRCREV_refpolicy = "440d3f5f129985c0193edff9948a1add42469692"
 
 UPSTREAM_CHECK_GITTAGREGEX = "RELEASE_(?P<pver>\d+_\d+)"
 
-- 
2.34.1


