Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5A0F8E4A1
	for <webhook@archiver.kernel.org>; Fri, 17 Apr 2026 03:15:21 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34014.1776395719685243401
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Apr 2026 20:15:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=QWGJ53na;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=8567b4421f=yi.zhao@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GHKuSa1910226
	for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Apr 2026 20:15:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=DRHxe3yqyKifjlTPM0aY
	wCLQO3pZGEEG8AMxShbZR/s=; b=QWGJ53najA16HxzC8lIVXErfaCS/O/B4kUt9
	4w/g0McLAbJ0DsksqqC9dwYCi9VfFzEcnzAonWJ9D9HMMLRdh97Tuzf2di2DFLUZ
	R8tZBqvVknNekfIiwUuRCFibalxSjK8aqbkU6uBJvwZOqh0MWn9Sbeg85fuhcFiA
	slTkCDDYE5yiWa4NxbDtyFkkZWPjF9IMSp2C708g2X0NV3Vg4hg/ojoCz3SPbjbr
	AGm5TUez0+74fYSo1q/RTCjGJU/jgLq+SLngIFgokZnAeVUHiuXbxEakiv8rEBJ+
	MDLcsLFKNio3SxJdQtV31pJ8G6Cy1jSyjQzfVfOyi0+56xh+lg==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011000.outbound.protection.outlook.com [40.93.194.0])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dh86mchuy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Apr 2026 20:15:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ir5ZJ02JrNbeg5VGGPmsXpA+NFg/ugWOTkNwiuZFmyegDpis8GMBI6CNAHetCy2/L4UXGBH7HsjwOE1X9O/9dmW1v2D0pIvChsRl3qopqPQCXA3d9RxYi469/vsPIoJp06+cKQj6lXXK7LiEb6n6rTzVMrTslem7s6fVcbfluELUo7GZiYPUHPFydiaAgM+ROLTzH4mlhtWZWLJdFX9D7ZhC4No4PIo3i8yV8T+eZ9ugdOSawQGDX/LcVrOD5iVIq8mTHQzOmzIO1tsRjLxFawLuPuDrT7YrBhuIkn1ESKRwwq5B4HmfDVuDOpBvsXFQSh6D4pnoEFgc8KjRIx7CDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRHxe3yqyKifjlTPM0aYwCLQO3pZGEEG8AMxShbZR/s=;
 b=I7Yqew4lBNr2bC2ddfpOG+BkIyjsGm3oyGrubCKZXjXMMEVnyoSpNL7rw5mu6F7bM6wNrgGkv8gAJ1ky+YlC+Bjc79tSzx8p1NeXbjQt+uV7/iVwU13k3gVnDS7Rs6pEyHQviBXp8jdXhn775/ffpbibZ70DwEJ+qusTFJ8Npc8+Z6wjeNkUdu4qq5SgKjGL/8SrbG3Anxooqh3CXH0VLqh2hDKVJTZ2IbLK/CUB+j6hHVZitZqd01gl3UsMewBaXvXQQzqR51LhplR89CUczQh4yDnX6gTJYyT8jc2sMN8XBN1863ZIft6NpDNf10KmrkLAHa5bk/PrCkOGYpl09Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 DS7PR11MB8782.namprd11.prod.outlook.com (2603:10b6:8:253::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.25; Fri, 17 Apr 2026 03:15:16 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831%6]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 03:15:16 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH] partition.py: restore selinux label for fstab
Date: Fri, 17 Apr 2026 11:14:17 +0800
Message-Id: <20260417031417.583413-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0052.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::15) To IA1PR11MB6396.namprd11.prod.outlook.com
 (2603:10b6:208:3ab::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|DS7PR11MB8782:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bfab260-db93-48dc-feb0-08de9c2f7ca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	xrkwMfAdHh/SOJ8MNAkyGn3duAytbZhT73oFc6Cp/p1+nWCFTjAoqSY8kC7eju+69w2bYfSt79C7rIkGfe2zcHLyCmlekVrGgE1+fw7lZaVjDF3FVcES3qdf5h20STo4bMvrVkRfgXT0uHEbOO1nNL71XRuRfzL3Y2ZnA/5lF2cciyHT9VBCf2DxfNea8V0YcF0jKMkq+BnOEczBT/M3ZdVLvVHfdZ/rkKLuSKNsrtIvzlicgrF69pltP8nbrOfXIs9Y+p1DyXpyZELFEyofArLCgaqY606Bu/I1kSnXuv72O237BvLDgre3D8Z62E5KawdYYJlvDobY8UxKSZ9WFpenRoaDMvYB3WBCHYkk4M+N28T39g5KBqOIM3frh6pgddus8Ekm7IsFAX/KQhIT483I246eqBZqQT8Z4ub/rNq1mPNN+FWr1d5+Lgd2HNslA5Ya3HP7P0E/DrFKJ6K+E3loDoTdMdb6WHyDfepjTDEKXp6li1WIBzk3a2+mjnWww9Dq/3I0mvzhNdg+MKAqHNhoZpsMXRQ/YpMX0fngAvpmqHQno1cCcD915PJGy/t8a3Q01a36jwew8xZjfP7opWKWqM7syhtCBiuJFTKSWZxS8KgEQRStwWrO2gIrbrzIu3oUxFVwzwGrtdurues09tFUcCRiucrQ130Vep8zTJ1baCmYrrqZ/vR5fMwW1E5EaDYjCPBaZ6U8X2UDEBNe4bVBEqSZKPEgk43zGSUjtPB8ZSxe0k9U/kYdjmJqXEDuTfO52vK+KmJ5qEVAHCAvAKcyjlpZPvBqVjogP+AME1c=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9Qk2X5+yw+SJ2DV1kyQHX0mgwdA6qaDebfApfsv/WK4xMC6WqfW23Qt9A6IK?=
 =?us-ascii?Q?7Ke435x9x6C2XzvIDKx1Te6yvtL79qkWSZrFroK1jHLBPMGpZ0cAxZWaB9ho?=
 =?us-ascii?Q?bCi7eI/pO9KyK+ax14eeMnq8TsZpgMElsTjHuPeU/3s2h8YekJsELURaBPFo?=
 =?us-ascii?Q?OclOLVDf4vEhr7pbBp88Qn4faqhVD1BTRqjdRYo3Wjmk9is2k3e/G0yjaxyU?=
 =?us-ascii?Q?dTg2Yf6IVneYylLJgYjI5GeOgVru3en0pqPtUoVfbzFdJyVCCVS+IKX0U5hB?=
 =?us-ascii?Q?X3BRUZZFEFhX/KKOVXycKRFjhgLiBwc4Ek4RErqcH+/7xUf/P8BdYfRaOX1K?=
 =?us-ascii?Q?2JuHEs02TfxNz/OxOFQii2UWytjx40jS4CmZLRdHpsrEBuE6ONqvb0k55nex?=
 =?us-ascii?Q?9yWt+r64s2T+7L44P/TUkR9i/Xmrr0svQ9G6RJ91h10XrVQ2r/HTFNMDEzrA?=
 =?us-ascii?Q?0MI4mgjGaOwL+2vsMYg1P8qAG9kXgFDLT3mqkuF0AQDpy5lMLBYssUyCf/3j?=
 =?us-ascii?Q?QboYwj8eS6fx915rkpCTZm2NRYhZPqN5g6XEktii14dGxTH7t4aoVZK46rvk?=
 =?us-ascii?Q?k6ikN6zj+h6ebu595VZo+CQXeBLDs4Yd3L2q6rjkVP9D/YDI5XO4Zaa53Tax?=
 =?us-ascii?Q?Cy7SkWJfp5TiqTIO9z0AubJvIZaaKbnj3+OS3k/snQlwGx5k9rlA+tBOa/CO?=
 =?us-ascii?Q?MiYfM9bU8iwjmM1XZ0/l443mgXC35A0V/Cl2JSKBvHFK34HI/6U78ywlkNSL?=
 =?us-ascii?Q?dbM1METkL/NJ1EKXfcDQMIuSCbCjTpwJRaCg0rO2RlDVTh8YPXtV6ualpVvC?=
 =?us-ascii?Q?VDL2t8tveQVTakzGwjjdNlxLyprQz5Cs63jPtFajTm/CrP2bjyKl1n0QGuH6?=
 =?us-ascii?Q?yiLjP/fxSe+POwP8rqrHX6mgHWbsUqzYbJSCOBl4JTaaPfWrNLyfJY+d3x7P?=
 =?us-ascii?Q?NHr3qEVaOfGGzwxoixfkFWIqdJqYSggUTwGklAk/C8X/UASgTx1XpgXyTx6W?=
 =?us-ascii?Q?/SdeSP59Ib5x1xqtu7nMsVb1+il6XJ/M4bM/ufgvIaXMUW1ApG+tfb0ULHoB?=
 =?us-ascii?Q?sSEhVAXQ69DXMUBUaWoSy3kH9I8fvg3QCdqqpoFUR+A5qGT1Cl9jUlSfzpu6?=
 =?us-ascii?Q?88V8WbNwC3Q4gLXIVuc7upwTEfJR0BzC+zE/GiUlHHl49KOCQG++oo0WptIH?=
 =?us-ascii?Q?CbPHtd8GJqsrloPDpbB0zB+Uv81deku6Qgmeka9GVOdP2POSIliQuZ9J2jTL?=
 =?us-ascii?Q?wtppFrG6RsiyMgYVqKuR/5AR6ZgnuQGZ/CGxt83yFF6Jv7Lg0i7AfpCGIYOU?=
 =?us-ascii?Q?xrMREkBK7v2mDAZysZX+qAMDANBcnnCvKH5rKwxyH4sooE0D3XQYuNrCnxK3?=
 =?us-ascii?Q?OuV7Lr29qPTbrH7BWJEAjhJ5T+CSailoLVP7W7IFw+gpiupIpSb/ft5hmgBj?=
 =?us-ascii?Q?Vjgn985deSR2HAn8CR8xqSB8yTcClHj/Ijq8ZGqs4WrVXoXP6SPloXQ+x79s?=
 =?us-ascii?Q?f+NDRaw5DtFB5d95x9Q2GcC+0WsLhEbtsluZvluPMXf6XmhwSJN/rtbYlgE+?=
 =?us-ascii?Q?vqSnW41i5kwWQyFUY66Jm5fHq+IkijuUxswKEGHGx279ANkO1tPz22vW+anI?=
 =?us-ascii?Q?1K4KCjERx214s7TD4XMYqSIr0q4XsxxNg9vQQ5454pTP1iJeGexgv+Uuqevp?=
 =?us-ascii?Q?oo/RzUQviR0kqKxWZHYownCG/KiM2WgpequGWVPCJpqzvgu3duvP0dJ+Hntd?=
 =?us-ascii?Q?qjgTAbKHPw=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	MCm1w9trearFjpHkaZ/JIZS5ekUdV7Iq30ojWmQCVxfYp38weGOwZKjPZzdpIPcmNWfXI2SY3KQwmFwxOVOOJfD6LuUDUxiS93jvJ0NeZOYbKjy0+wVzTiVeuAHzxwyYAomls+TF92rHk4iB4tIkan19V9kL2vHtrehszoadCGs5slKa/D7FXkXFJfJX3g+yJAIvd0jPVNjebhX1SehW/OJyuEAYH9ovORINbEZaCMOPD3r7hu5K3a7s9JndVfH5UN4eLBO2fEbsyS22e4U8z+6diCJULJ6TQQTVw+ZE1JsmzzaQHNllJA7RluhcWV3i7aMtvvJVCW05kxm28QBzig==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bfab260-db93-48dc-feb0-08de9c2f7ca0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6396.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 03:15:16.1946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EER3AWxA+/irHwG/E64RaZ7NmN9gBnYYnwIp/SFuFHbL2UnxZneGwvmjEKNQ4xiI2X9rvkn7G5g98MpFWUqs0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8782
X-Authority-Analysis: v=2.4 cv=Q5riJY2a c=1 sm=1 tr=0 ts=69e1a5c7 cx=c_pps
 a=QnZ2uEdZlRAtgHxfLCbJPw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=1OVO1wKMs3fWjCVhTkcA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: IcjP5u1-tkUizSEsVaB-GQ2KfYaimRlB
X-Proofpoint-ORIG-GUID: IcjP5u1-tkUizSEsVaB-GQ2KfYaimRlB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDAzMCBTYWx0ZWRfX9obTKdvNhPC+
 pJxj+ooGYEEGQXeZMaAlTFBr3N6mTj5N53NG/eD1vXsk/BOgPJO/owoR+VCMbmtm9Af04eLv64j
 bGnngL2M/QIEZUipEaeLCrN+3I+YuJt7WeJL0P8JiPzYF7ZgCge+P6Ohl1My5hLBfY0s2N7osIa
 VGwAuqMl8A/pWpr6tK4/QaKmgXnDIO2ZoP1uVHpz+SYtNVDJy3oThcJZmIrb+m8TTHp0BKfBMFq
 vMUjtV8/GAArC6nYOqVHyOE9vkwt2NvktMGApTCH1mgNGQX0/Epu6iLXSdGw58QMB/vRkK2HeGd
 itn3ov2mvJ9PdvhrdUr+4rQbvVUQa0ASlq78QYIBvsqsT8ZcQEzVGvpkVMM3qFpl6TkVE1sFGLD
 cH2qrWhdx/KWNsy8GvtPqbm5D0BlQ/cWfkpH4pYD/GZp71HGTtx5r4FD+LXGsL+Uy16Dl3/3K+Z
 4fjHM9/N/lDGTZZIByw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_04,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604170030
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 17 Apr 2026 03:15:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3726

When SELinux is enabled, all files within a wic image retain their
SELinux labels except for /etc/fstab, which is replaced by a newly
generated one during the build, causing its extended attributes to be
lost.

Restore the SELinux context on the new fstab using debugfs ea_get and
ea_set commands, ensuring all files are correctly labeled at build time
and avoiding a full SELinux relabel on first boot.

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 src/wic/partition.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/wic/partition.py b/src/wic/partition.py
index 435d31d..506ef2b 100644
--- a/src/wic/partition.py
+++ b/src/wic/partition.py
@@ -362,10 +362,21 @@ class Partition():
 
         if self.updated_fstab_path and self.has_fstab and not self.no_fstab_update:
             debugfs_script_path = os.path.join(cr_workdir, "debugfs_script")
+            fstab_label_path = os.path.join(cr_workdir, "fstab.selinuxlabel")
+            with open(debugfs_script_path, "w") as f:
+                f.write("cd etc\n")
+                # Retrieve fstab selinux label
+                f.write("ea_get -f %s fstab security.selinux\n" % (fstab_label_path))
+            debugfs_cmd = "debugfs -w -f %s %s" % (debugfs_script_path, rootfs)
+            exec_native_cmd(debugfs_cmd, native_sysroot)
+
             with open(debugfs_script_path, "w") as f:
                 f.write("cd etc\n")
                 f.write("rm fstab\n")
                 f.write("write %s fstab\n" % (self.updated_fstab_path))
+                if os.path.isfile(fstab_label_path) and os.path.getsize(fstab_label_path) > 0:
+                    # Restore fstab selinux label
+                    f.write("ea_set -f %s fstab security.selinux\n" % (fstab_label_path))
             debugfs_cmd = "debugfs -w -f %s %s" % (debugfs_script_path, rootfs)
             exec_native_cmd(debugfs_cmd, native_sysroot)
 
-- 
2.43.0


