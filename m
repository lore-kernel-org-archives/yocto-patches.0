Return-Path: <rong.fu.cn@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21644FF8850
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 05:51:45 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.36740.1777269102955559642
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 26 Apr 2026 22:51:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=m5DZ7ZMZ;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=857708df19=rong.fu.cn@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R5Uu2c2874767
	for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 05:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=MscwQQS4D
	BpN2r6LVKEbw5Vow+cakxtxl/gY7T2vWAk=; b=m5DZ7ZMZOArFLXhBbIsvx7uZe
	grBk8iJIAMjXvpuZm8JQHdyz20Qc7g3wXf+Vi8vUq4vTLD/uGRYGpmzN5Mm8kxYC
	i1slE3j0/kDhq81tUIzDJ2ZL4mObfyEXZbDV2bTIP5VnXOVZ28X5EmHy+BQkqe2A
	67fWv8FxC2B3WCfOZEt9Do2Ebfptl8wGPBK/GYU46iT5PFm1TZt8f2WRmVL8jC7Q
	z003b3Sx3HDqjcGzLjGONhqXmHqAvbTuIT6w40MkgFo5S4j8YB+g7xjg+4xYJgvM
	oLfqF4DMh+lphMXGq7ZNZOKOICKw/TbN8k8EwlyAy3edf/XIYwzCnpUGM4QTA==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012011.outbound.protection.outlook.com [40.107.209.11])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4drju09nen-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 05:51:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKDVrzg+tWMw8YeZur9q2HfPKMBz+E0j/fnNQeU0RANxj5uosvYl2WN+qyYPLB53OWSEuihgEPbztUIYBbxzFrENeyyxmnHusPJ4ndFGIELgguPi4MJT/08LYOInR9tz+gPGBQ2CLrAOm4ZVrjsTDCB+8hSb68cEFJ7++iKBrmxE3tFAk3jyf1puIDRdCvlV5rO37r76K+utOPZFnwAEHMLdTMxOmkhXoMUlaVtGacUXQzBTvMi1KwovNoofSpt1rj30GcPXtTpKYKwlkSxFt2w8WPFv782jDiV0+2tIou0PCW9FO/IMj8m0j7OsQQYX56pLRZs7aET0bttscMXCyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MscwQQS4DBpN2r6LVKEbw5Vow+cakxtxl/gY7T2vWAk=;
 b=QXur5Mpd8baQ0M/JEf9vnzEujUwtUG0fssuqFIC/sHaZ4zaVI6vIFCnB2Tq6Nl8A3Sl0GCpDAg94Xfi/szYBjLNqDGXOkiAbAvMV9kM9RGSJad70ekeozwJV7xm5qEBVP8Grz7FxoAyh/4zdZv7vqVXTwJ/iTLnhRnU1c9ZoXwsNwED24YmjlsTTzz4fRuE8PrzMb2Qp+eRLGK4pugBlB2OTe6uC+tA9n4i3LAd1Y5XSHq1BC+/tLJ4QHzIYvRrnxrRm+mIsCxPqu6FrkQM51gEQDgW01pdx3b6wtCgyTvuosatXG6veWMjnE0048Wwn8i58299bqcCGPxEhLaU5wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from LV2PR11MB6069.namprd11.prod.outlook.com (2603:10b6:408:17a::9)
 by PH8PR11MB6777.namprd11.prod.outlook.com (2603:10b6:510:1c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 05:51:38 +0000
Received: from LV2PR11MB6069.namprd11.prod.outlook.com
 ([fe80::d94b:502e:dc16:ad36]) by LV2PR11MB6069.namprd11.prod.outlook.com
 ([fe80::d94b:502e:dc16:ad36%4]) with mapi id 15.20.9870.012; Mon, 27 Apr 2026
 05:51:38 +0000
From: rong.fu.cn@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: rong.fu.cn@windriver.com
Subject: [meta-selinux][PATCH] mingw32-common.inc: disable meson exe wrapper for mingw targets
Date: Mon, 27 Apr 2026 13:51:25 +0800
Message-Id: <20260427055125.2349479-1-rong.fu.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0078.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::14) To LV2PR11MB6069.namprd11.prod.outlook.com
 (2603:10b6:408:17a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR11MB6069:EE_|PH8PR11MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 96085ba0-8f0a-4018-0a50-08dea4210c73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	f2CJydMQrgUEUDv6go7wFhJpmyKWn0zEQy1LGWYr7qsTV+v2vg/aROVyM389WBo3OlW0fk3XS1grHyJjEwozgIt9kleshO6a4QnbvP+/qTi8wr+uzEFsKWg5hGPzSfHnOMoh5aVqEaW4hE11gFutuurYmEe8kjEgzE8toh3OgFZRE/iNAQUE640YAWRDHEpTWm6RGfo4aAlmETYfLGqbXLIScDOLF5tlm4lWpOO1eyQ+OxCDeah0yMyzCCb23SxKR+0tZjZKRkJYLbElv+ljWByuA9XYRzy1ksAjTbpStDngwMxrN8C7ldqzVkeG3CHvl/kzBekEZ5hLxGgj7ELFXRXHulmBLLrTp99pUBLs7GAUMSzR6RKHgeOKjEPKgt6IJPLj73wdqPqeJIaaNrtixvMBw5EoHgTC1kMi+iq6LWxgFc+BO4yUuU5Lb50Zdy7/dG2QEtr0vItNRVrBVPXq+58S0bfew9AngGdjIQOIkfzUW5Vo79TUwww+nExM6uWNPe5D2evGK/ihkKFLTbB8AjNptNuJlREub/sil2f1bm3RT2dVFPjfYOrqTKC5zI/I5ouKWdpHOdn5dqNprUA0zNXMW5f/REtokoL9iXJ0dd5yG66pdzsGxJBJbTqRpvUZYCKWakEgz2ILmfSfoA/Lo50H7y9aovBN6MRLbADw4zbQeWuF/+d5sF+CmuFI2kM+v729nw3+UJcicennqZn9Ov+Wt9YzDUgI6tIfCPDq5DoBCHYcY86Jia6TLjm5phCiG1/3wkERXvjQQrFiQr7Ea+q1du2wDeFc/6dsSqSv2PQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB6069.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QlOddNe+kGkgsAG3CYWBIxrkT+PpTzs1ogxDvcIEVs0jiivdkHTdKl7DTKlh?=
 =?us-ascii?Q?rmlLwAwDulNBikpg+KuxMtkAiVBt2n/+UlvzqyInMgzOcfrTBD1CvFyw9WSx?=
 =?us-ascii?Q?qqp4UCT/kMcoC5ZONOrItopsgu/1uBIO3odyuD/kUXHwE8rV86zx0tcxc7Qb?=
 =?us-ascii?Q?4VdtBX/L7LpeOB9j5AOc8vnlusZPu0M2ilpEfzyesFA9gWlpxMDhXMGBAxzk?=
 =?us-ascii?Q?WYW8A/YKuzQ8t2TAg123/pVkiTLmeFWumsja3TOdVMv3Vv4/893wWHKHcicm?=
 =?us-ascii?Q?hob9rdy8/2D8oRaWzIQ2ZMlw3x2BD9Mp2KKcBfS1yGIi7yRSg47WK7T67hZT?=
 =?us-ascii?Q?Xmqnun3n7bTV9xJ+R7jjyxPr4oOpXIvFSVSZR8wHXDUUdRbbZfWSSPKYklPE?=
 =?us-ascii?Q?C4EFIgww3f8HWOZU1H+SY50if4ZRWyB/qVcDhE7bvZR0YOGaTXA5kRrv6YX9?=
 =?us-ascii?Q?dKr60BkQePBq62edxc5pSF2p0tY91doXYLjQ17aQ/+Ford3aG8hkItvMrOTa?=
 =?us-ascii?Q?Xghc994PwIhgg+vhMQ/RCtrliAiTUR3NXPCEFjX2h4SbK9XnhAGVLzpi7S/1?=
 =?us-ascii?Q?HSXQwM6b/ImM+9nrNXvkCI52sv+0JHuiKkyqvPFWWRD9GtWwz7Y8rzeUMNsy?=
 =?us-ascii?Q?ll4X6Ip7DtlC+YseUdbEgYnxx/+yfNLwOd7SsksJzzFbEbdw3TrNXr4YBQWK?=
 =?us-ascii?Q?tmQ9CIAnzcOiEQigKl725TNKOXD0H3+MjYAKSiEhm/bq4e2MNGAdLMltQ90B?=
 =?us-ascii?Q?G7/15CxQ8xjM/FnbKMgy7dkDMdWnWK+AAHRVRogcFE88W0Cc1ZeBhBtpL8NK?=
 =?us-ascii?Q?Pbv74oUqV7JOyuIwKAt+YIw7EXwvYk8/p/6csbe9Ic6/x75us/ZYe7AMHLQ5?=
 =?us-ascii?Q?tZWxF7XEut+mClL8M0rM9cjukJtmc5gkhtGJ5ZmAZgBp5mg1M0fkU4+5HJ7h?=
 =?us-ascii?Q?ZljMxVTL5TpycTj+68JNyxvX26cTtenJggDSBBS9x8L6Tjbik7ASOdXHYsq0?=
 =?us-ascii?Q?jnafikhEydw5SnGSic5R3/T+NCLD/0Knq3QA2VKXIj/pO2jOYYZJTfPhqsPa?=
 =?us-ascii?Q?RyiEf6XpvAsShA5xiukUqSt1zH2/HAxfJDUt7htAA1jw+pcS5esdl+MnxFhW?=
 =?us-ascii?Q?QdneVF2u5dndqp5GoZ04t6T32hdAAK1H2fp9K8HxHFcBDBHrZdbDY8EfBt2H?=
 =?us-ascii?Q?I2Jl+p/QztFGmi70PZLH5rfEmEzhmY+gDViS9tGswGKQLI4r9RydHtGankNb?=
 =?us-ascii?Q?qijqrg6tFOYsuh8v63oMZpSyvcUhmUWJMJh52RomilNF0RGRSHbqDOp3n2FH?=
 =?us-ascii?Q?7VMQR0IST8FUiHpo7124WKcUySI2gg0EFTUhzJcVmZdgmuuNjzTU3f4ZWhMz?=
 =?us-ascii?Q?HdroY+JJi0OzU/QCHE7F/pLlNVdlOjQRCXAy0yBnZmWXkNKxYpU8hqFeq4gB?=
 =?us-ascii?Q?GevywPzwDvuHV66SfDD6sjW+8JtmNmQoL2tdcyioP7J/VVTHENhhNWsaBKFj?=
 =?us-ascii?Q?c+OVbRlx0RbMFw/4Isz1BMirI02B2Gr1uJGW6hCnAETEC/uiU1a/sP/+TJLR?=
 =?us-ascii?Q?5kf7MrgVQIR179b44zTZOUxxrMDbRkd8gGuT2QS6fZsvhtagRTKXfWp8W85h?=
 =?us-ascii?Q?fpqgtfX+NkPe74c5e+rS1mOEeaYVbKJBk9/+nycPJj5+Gpdu8Vm+hDmsyim2?=
 =?us-ascii?Q?3fq+Sncg8FiBFuemh8OVFCG+0VnPP0F9rSRewzbYU07UmhZecG5Q0zyE3b6A?=
 =?us-ascii?Q?NKx8ZRPFsw=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	rVMlmb9nmhjfuu4FJMXAtL2208aejtt1WJVoO1gMN0doq6An9S2y+3brJgEVg3RMY0yYXdxmDwlQInS1LB8ufy+XoWaBZ8eq+kh0KBDfutBrGIruHKhDU8cMChf0gFernwn66uOorVmqOa5/xyE72yud5MLG+WXjr3w64g/mX0T7atLsqCfwcOFNdiHaDgKjjqhEWy5eheev8/mXQkL7LvpscNjzcABtRJbu25+MmGVtN89WOZs4zegRf1FLiBDO7Mqyxy+m1J3sdWHhQ6ZAuEig8RTcsFfTR3lYEn9srBg0fehvPFNoPEyGTLEQOO2lcml6lI74EVY4regnRIjgYQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96085ba0-8f0a-4018-0a50-08dea4210c73
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB6069.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 05:51:38.5742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFdddG6AIswS/kNYpyoBWkZCoQrDTPithO853SyPL7TS5zjgGRt/i1Q0E8zgFQr0hdc/40XIKVyy17+ausYHvYruqBSBSE4vZME3Cx0ZEbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6777
X-Authority-Analysis: v=2.4 cv=J+SaKgnS c=1 sm=1 tr=0 ts=69eef96d cx=c_pps
 a=q3M5bEXgJc9IxHNyMLvWsA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=5E7aB64u_DvsIhRDXwkA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: o92EzR82xPo1Z_p9RYxICRptr1x1s_Wv
X-Proofpoint-ORIG-GUID: o92EzR82xPo1Z_p9RYxICRptr1x1s_Wv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA2MCBTYWx0ZWRfXyWG3xtEAxmkf
 cFyQXT924PDzw/iPcqk/EMy/9vwdC1vsDwJt3wEjC58neJMA3TpIetBu+D4K8xkJ8xd94Fa12Ft
 3RpwrBAZ7qQ4IBNRp5hHGW28+MoVzRmPvN2VG1hMxgb40h4azSyrqybgJ3XgkEJoFOhTue73cAx
 L4u0X14i0MFSsmooI1Oy+RN7bSE9LBuJHl3xS8QgAfxLf4+X+6nQMGCaIuMbr9qQxW0M1L6uF4D
 5DL1JjzDmQSeJRducEjtB491nNigA4cixOC9Zjf6vM2iuNYJSdGvqohdMe+N5athlcE5yWuyDEF
 vJp/sbhELTB3MhYOJGcZgnBEuFEb8X1zxs/xmRT3qvZtZUcKIt3yOaik9paMf6NDcR9iio+eZNh
 o2/sAhMdXNw9gSS4c4Z8R0iFitpME+z159OR9EMYkbR7q2lDSkNilrNqx2lprfo80HiH05yWqgJ
 oKOIR33G8AO/PyKXxhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270060
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 05:51:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3826

From: Rong Fu <rong.fu.cn@windriver.com>

The meson bbclass uses qemu as an exe_wrapper to run cross-compiled
binaries for sanity checks. However, qemu-i386 cannot execute Windows
PE format executables (.exe), causing meson setup to fail with:

  Executables created by c compiler i686-w64-mingw32-gcc are not runnable.

This affects all meson-based nativesdk recipes when SDKMACHINE is set
to a mingw target (e.g. i686-mingw32), such as nativesdk-dtc.

Disable EXEWRAPPER_ENABLED for mingw32 to skip the qemu exe wrapper
since it is not functional for Windows targets.

Signed-off-by: Rong Fu <rong.fu.cn@windriver.com>
---
 conf/machine-sdk/include/mingw32-common.inc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/conf/machine-sdk/include/mingw32-common.inc b/conf/machine-sdk/include/mingw32-common.inc
index bf3f14e..6014c51 100644
--- a/conf/machine-sdk/include/mingw32-common.inc
+++ b/conf/machine-sdk/include/mingw32-common.inc
@@ -57,6 +57,9 @@ DISABLE_STATIC:mingw32 = ""
 # disable security flags
 GCCPIE:mingw32 = ""
 
+# qemu cannot run Windows PE executables, disable meson exe wrapper
+EXEWRAPPER_ENABLED:mingw32 = "False"
+
 # wine and wineserver are required to test MinGW SDKs
 HOSTTOOLS_NONFATAL += "wine wineserver"
 
-- 
2.34.1


