Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDD7C25B75
	for <webhook@archiver.kernel.org>; Thu,  6 Jun 2024 06:14:49 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.7753.1717654488327643973
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Jun 2024 23:14:48 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=6887b57725=yi.zhao@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4565Arvt021456;
	Wed, 5 Jun 2024 23:14:47 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yfxwyvqjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 23:14:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZJr7ZCPUyK5ljm2Gdlo3MCDLywuiL8wcPveb5jfEubzk8co8IAOyHmVfUXN/f/DgQz65WzcfzUzMmP/gPSQ8+ZIw3PyRwjjTz78Yeoshf7dOa53TBiDBP4xBBNXiZ0toX0ny258++ELfM9uKg4XuV4oZc8UmPTK9soaPO9qwOf1Yka/08CnZ7wfkFY3f+NtmTAOtkWop9yxCadJYgRokFrAa0HcSgNKsjzH4Bp2TrYIZQ/K5IiYCxEzT/k0Fon7Tiuyfkpt+ESKwDz7JS4OvFIX0d31QVaBKubQTxr9HW52twuM3Z20bMmpxOYCF2Who49x5ILxL6gfmBhV78HDGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dyQTEY7TG63xY0fu9URX5Ab7mH8nFkwO2kVduLdbrAY=;
 b=EHfuV0pFy01Od6SD5yzq0xa8fXAY0O3UjflM8tET3iIjekCMahc+aEiT9NRbqfnVwyPYkG6WBDxj0hSq5msrfj5hgiIWyGhdybhbRflElzVXWV7HV9nAsLu26XtdoOs0Mp5MO+ceMmp7ve9n0vVmmfxzJbAqvYUCiPzd0kgPUEOEF58wqhDUD6sTYu0wTX4gFQPLESl8YI4iQuaPXYJpC7Rorc2QhjX+d/87FB5UnqkOSYgO2onuPpEpVjCx1NGQbXNTZyUWb+Hry8J3i2RM4teBQevd9rjYq49VW5nIVHeOcaP3tdVlFczBTb9DMn2haoPTy0sGrBiD44jwSohlSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 IA0PR11MB7307.namprd11.prod.outlook.com (2603:10b6:208:437::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 06:14:44 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%6]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 06:14:44 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org, joe.macdonald@siemens.com,
        joe_macdonald@mentor.com, joe@deserted.net
Subject: [meta-selinux][master][scarthgap][PATCH 1/2] refpolicy: update to latest git rev
Date: Thu,  6 Jun 2024 14:14:33 +0800
Message-Id: <20240606061434.2764343-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0017.jpnprd01.prod.outlook.com (2603:1096:405::29)
 To DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|IA0PR11MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: 515cd6e1-f57c-41e7-cdd4-08dc85eff5bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230031|52116005|1800799015|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?775ox/hU3UBULeIfFfE6B1APOE+LR1xatpKgPNpGhoeDoK2zHfa+oJvRCsMR?=
 =?us-ascii?Q?AzByQdlLwybp1qh7JpFFZSQD6ugFJ+X/HMPIr4iPtuWiyPbOAM+2mWxrhobT?=
 =?us-ascii?Q?0307F7hTiIGbxFYv8vq3pZ6Ofbqddch9zaUe7kSmIvPpTX/v46oZbBUYHjt1?=
 =?us-ascii?Q?xFC42tuKLXPX3wjuBOk0eIHltew6H4BZkdrz+HDnW32vTqW9PTyzCqey1A7H?=
 =?us-ascii?Q?qUSbE6r2MVbk1MJjFZVZ/oZYSPVOQrdgcO65C+uYh/szJmAo/Dlo/5MxnL89?=
 =?us-ascii?Q?jJcwmT72r2zF/3kEgRwsU7Ain3R93M3tm+ZU6W/ObmOJKBn16S5sxnoGwIYo?=
 =?us-ascii?Q?fp18+v+1hnB1JDbR7C/JWeSs/HRAsed1H+HST6tRAwphEhWQRaMYANIOd+1S?=
 =?us-ascii?Q?/ff+XTgUOAevFwP1YwWyltdNbasOjV7cRJor2/aLp5pmSKawVDfx+UsUMwba?=
 =?us-ascii?Q?ebxdEwV/4yc7c/xPz+4Y5PydR5FJSfRz1JxOMgTN8QIUgXl+uTPbHeFqM/oc?=
 =?us-ascii?Q?xJBiYcHLD3+hBodIqZZFPQ5lBZdFj0useqlJl2cXvPgxiO+yKhw9PV9pP3Wo?=
 =?us-ascii?Q?xCAA17262uM1M5k/BUjrWzHtS4DRPYRBHqO7yi8ACeS0jT+7IzFgoKwrKsd2?=
 =?us-ascii?Q?wthVo8iHwV9PZthTW9d2NWCbiXR/DbDw6LIuxpBYp78gkIzPX/zJnUUMSd31?=
 =?us-ascii?Q?LYcYeMdAg6TU5StBrYHAtVBlWVnpyYmIvde0fT7B3/DC5SVDpmrHllu+PXY/?=
 =?us-ascii?Q?vAa/YzCDCqXT4kiB1cHbMg/K3WPYjL0Vq4cjxTBSiAB9ByjfTCXsYwjkW3Bt?=
 =?us-ascii?Q?eHEyBsAWUoC10//X/5w6W9Yd0pXruL/VTmHwq7IgUn2LeZP75JkeMd7nvv9g?=
 =?us-ascii?Q?FLDSlPLPeIKpswIxWSOGKp+gBFWf4MEymfOI9Bkq50vPrrKuqnf02d4aPNAC?=
 =?us-ascii?Q?SmiH7V712gykvzmyYBADJXSuG8APFCX8W8HCyjsRLgF2wvTJJoWI3eOds9PF?=
 =?us-ascii?Q?giC9d5yyMhM2t3dEMib+LiNb5Ma5bMXLuOi3IlmVI87L08SlyLTxNe48v/Qz?=
 =?us-ascii?Q?KUdHRr9k/mx298Xxm/05N/XZ5JEEfG03hYfNw0FtEVlwegZZMnNT2pG5ieEU?=
 =?us-ascii?Q?qGiyZcN2FuJ1x1qVnUXo/8DOI9XQ12WR4prQJQ2OHGLauIDrqfkLgP10MFGo?=
 =?us-ascii?Q?Bi2/PFTtCkJdoxNF7IYhBr/906V7/LKj3GA/0r5HBTj+J59/rV/U/PnrTtdl?=
 =?us-ascii?Q?0nQU7llJnOB4iRQTMbjhRQ+bBbxc9F+Wuk/E8M3Yi4pe+S6Gzy+nmZZrQQCz?=
 =?us-ascii?Q?SO1ibGAFNOxjQ5J3TI9eqVqd9Cu88xucKrWqm3/bSKuZHAiEkSw/fjI7Z/LN?=
 =?us-ascii?Q?sVTXKVE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?IHIJ/m+iAPKEmKCBjQNyESUqshiiWjHsA3KskBchA0rp2NW2FnPGkhau2ppd?=
 =?us-ascii?Q?80TKC8Y45Hz5xKA+zcRBtswT06djKBMoOanZk+4tBFYaNTS/MSMxGvHffi+x?=
 =?us-ascii?Q?l1wn3H+0BmFmo3JyIgpRqer35DmQUrMkCgTrP31lYTsrR1r+wntr+Dl5D89m?=
 =?us-ascii?Q?1Lotl+FqDsNij78KEWPVD3bGUt5vf4Gt19ZIPlOVXtvF019TTule8JluEGMn?=
 =?us-ascii?Q?yOuUBrJMVxx8DctUFjczUYO4t4hzFRZ8dg/zCG2oUDML0+LZje9knDT2tj7l?=
 =?us-ascii?Q?QICAsZDiffRHXFAA5tDd1BPzDp8DEBnYcR9QOLuWZ1CxL8iGCx4HbzhCyLXI?=
 =?us-ascii?Q?WdUwzl4NLAbre2h/N0OXGQg90eUye6YErqFBmrFDuJ6OVM/QiSpZXlJ4epcJ?=
 =?us-ascii?Q?jDUvL8ugz4wcMIxyoX4UreQIxFKy1NArvt2kbSBWqAtGsIOVuVXeYFsu0+kD?=
 =?us-ascii?Q?y9nZ9DyWadMFPXQs/dJ0zqWqVHY1Nz0ap4fW1kgrrR2VGpjNb5Z0wJGav2OD?=
 =?us-ascii?Q?dawewGNMEIUojsCcdbHqhthTX1tYKLn8/RkGzVWqhqQOnBUoxPhe1uBAEG9R?=
 =?us-ascii?Q?wRZiFNzrhSca/0ZF+O/dB6c9Hd8xhczrhZmxA6wD/D+YWqHxIMmhUbBCseAv?=
 =?us-ascii?Q?bG+tBP1qpNXA208zZJPLcv8aibXjLSz2UmwYOMh/2daC/pYNxxEIFN2vM3EQ?=
 =?us-ascii?Q?srFIpvCjl48qf5nxln9qdquHSJTOFcEZC5AutP1xjc02MAVp2L+n0Gg8G3TX?=
 =?us-ascii?Q?cYlKjCDkVbFn7PUwH7wa0qCQKXbcmot82Ya/iiSRUtIy3VbnL9mUVFGDllgt?=
 =?us-ascii?Q?wtLouOLVFyKzO0X0nu13AZ24hpOaAyqaJxsYFT9jIy2ixjUH1IcpO2MbwiB/?=
 =?us-ascii?Q?jdb9ogoc5nEFLQEMWtAX1e8QxJzUBlY5v093rySpg87xyg3XMscNfYLVvGnG?=
 =?us-ascii?Q?nOcxmcKsNSew4etZWPmet1i0xJ6LMjXoh+XMPOTRTJ9VNgARB3ev5cv4lxyY?=
 =?us-ascii?Q?5CXY/pM5/1A2GKrPfKr8ekHGf5B1AhJF6unLixj03zzhsriAhRHZm5svlUlt?=
 =?us-ascii?Q?w5648HkwMp650RoPk0iWX3lsqGgKH2yUIuFzBiz2Sogzcg9+N4ImufH1qgUM?=
 =?us-ascii?Q?stsLqPi1cpqyXPXvUc4RYXFjKF3G0HPZB1mCXoTDgfW1qZ6Eru1vokPJJkK7?=
 =?us-ascii?Q?DHNHL8jJZPDFmNtKkeXGHJZC67TEb4nNnPJ/4OQwS93M+2+8+AzGCmkZVrJe?=
 =?us-ascii?Q?wubzCObvUc+kLnxxpmtlEgaXIQrEjVlA3HmgMndH9anyXpXQwDKD7NcbizgL?=
 =?us-ascii?Q?nXEvSPunxh+16lykqIHh/t3Xv5sqkhSvFTH1G/GILp8EHHOOVegCS3Issfpd?=
 =?us-ascii?Q?NAAPeBntlspjnyOP6wcE2RQ7WYUqWFRDV1bO+psaEvnYftKilr+G2bW1emg+?=
 =?us-ascii?Q?qbWvOdfSJCzD0LNb1mJDBOh5O8HR2U8O36P7KOg3OnngOyZWnu51h6IJVznw?=
 =?us-ascii?Q?70DsErMUY5lzPA0Qosyx5IhBaqnDUjC0YBGp/YAtPy/DQoxVFcVW5E9oUkmI?=
 =?us-ascii?Q?1OpRGEjPAvMioF92MstP+piwHNGllk38211DXSO2?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 515cd6e1-f57c-41e7-cdd4-08dc85eff5bf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 06:14:44.8178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LjHM/IpWl01ExBaFGXpyyQS2mf5A4srFwD8RwH00XYkk/5Lp13x7xG7UBI5tUeCxwrah8eWCrEchklRbaxhUZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7307
X-Proofpoint-GUID: nVQbJs-0wV2cQGphM75GrRjlooBS4wJi
X-Proofpoint-ORIG-GUID: nVQbJs-0wV2cQGphM75GrRjlooBS4wJi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 clxscore=1015 adultscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2405170001 definitions=main-2406060044
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 06 Jun 2024 06:14:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/277

* 2102055d4 devices: Change dev_rw_uhid() to use a policy pattern
* 1cbe455a5 device: Move dev_rw_uhid definition
* 7a33b4bc8 Sepolicy changes for bluez to access uhid
* c6dd4087d selinuxutil: make policykit optional
* 10feb47e5 newrole: allow newrole to search faillock runtime directory
* bf34d3e5e sysnetwork: fixes for dhcpcd
* 4663e613f Adding Sepolicy rules to allow bluetoothctl and dbus-daemon
            to access unix stream sockets
* 27602a932 various: various fixes
* 63d50bbaa container, crio, kubernetes: minor fixes
* 11e729e27 container, podman: various fixes
* ef5954a0e systemd: allow systemd-sysctl to search tmpfs
* 472e0442e container: allow containers to getcap
* 7876e5151 container: allow system container engines to mmap runtime
            files
* d917092a8 matrixd: add tunable for binding to all unreserved ports
* 3dba91dd4 bootloader: allow systemd-boot to manage EFI binaries
* ddf395d5d asterisk: allow binding to all unreserved UDP ports
* 3bad3696b postgres: add a standalone execmem tunable
* ef28f7879 userdom: allow users to read user home dir symlinks
* 03711caea dovecot: allow dovecot-auth to read SASL keytab
* cd781e783 fail2ban: allow reading net sysctls
* ddc6ac493 init: allow systemd to use sshd pidfds
* b9c457d80 files context for merged-usr profile on gentoo
* 5040dd3b6 Need map perm for cockpit 300.4
* 2ef9838db tests.yml: Add sechecker testing
* c62bd5c6c cockpit: Change $1_cockpit_tmpfs_t to a tmpfs file type
* 1c694125b certbot: Drop execmem
* 349411d55 xen: Drop xend/xm stack
* 2a261f916 Allow systemd to pass down sig mask
* 2577feb83 cups: Remove PTAL
* 5b02b44e5 xen: Revoke kernel module loading permissions
* 1c20c002c minissdpd: Revoke kernel module loading permissions
* 5671390e2 docker: Fix dockerc typo in container_engine_executable_file
* e1bc4830d cron: Use raw entrypoint rule for system_cronjob_t
* 0f71792c8 uml: Remove excessive access from user domains on
            uml_exec_t
* 511223e2d Set the type on /etc/machine-info to net_conf_t so
            hostnamectl can manipulate it (CRUD)
* 72fc1b2a3 fix: minor correction in MCS_CATS range comment
* cbf56c8ae systemd: allow notify client to stat socket

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...c-init-fix-update-alternatives-for-sysvinit.patch |  9 +++++----
 ...dules-system-authlogin-fix-login-errors-aft.patch | 12 ++++++------
 recipes-security/refpolicy/refpolicy_git.inc         |  2 +-
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/recipes-security/refpolicy/refpolicy/0014-fc-init-fix-update-alternatives-for-sysvinit.patch b/recipes-security/refpolicy/refpolicy/0014-fc-init-fix-update-alternatives-for-sysvinit.patch
index 73a0d8a..01b7cca 100644
--- a/recipes-security/refpolicy/refpolicy/0014-fc-init-fix-update-alternatives-for-sysvinit.patch
+++ b/recipes-security/refpolicy/refpolicy/0014-fc-init-fix-update-alternatives-for-sysvinit.patch
@@ -1,4 +1,4 @@
-From 8eefd8242e8b08fee6886d6bba12c4af202890d0 Mon Sep 17 00:00:00 2001
+From a733674bb530f070ce5363c0b50848d3cb4e113b Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] fc/init: fix update-alternatives for sysvinit
@@ -15,16 +15,17 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  3 files changed, 4 insertions(+)
 
 diff --git a/policy/modules/admin/shutdown.fc b/policy/modules/admin/shutdown.fc
-index 89d682d36..354f4d1d9 100644
+index 2e47783c2..e359539be 100644
 --- a/policy/modules/admin/shutdown.fc
 +++ b/policy/modules/admin/shutdown.fc
-@@ -7,5 +7,6 @@
+@@ -7,6 +7,7 @@
  
  /usr/sbin/halt		--	gen_context(system_u:object_r:shutdown_exec_t,s0)
  /usr/sbin/shutdown	--	gen_context(system_u:object_r:shutdown_exec_t,s0)
 +/usr/sbin/shutdown\.sysvinit	--	gen_context(system_u:object_r:shutdown_exec_t,s0)
  
  /run/shutdown\.pid	--	gen_context(system_u:object_r:shutdown_runtime_t,s0)
+ 
 diff --git a/policy/modules/kernel/corecommands.fc b/policy/modules/kernel/corecommands.fc
 index 7d2efef0a..9a5711a83 100644
 --- a/policy/modules/kernel/corecommands.fc
@@ -39,7 +40,7 @@ index 7d2efef0a..9a5711a83 100644
  /usr/bin/sash			--	gen_context(system_u:object_r:shell_exec_t,s0)
  /usr/bin/sesh			--	gen_context(system_u:object_r:shell_exec_t,s0)
 diff --git a/policy/modules/system/init.fc b/policy/modules/system/init.fc
-index 07b12de2e..d99767ce8 100644
+index 75c75e7d1..962f18099 100644
 --- a/policy/modules/system/init.fc
 +++ b/policy/modules/system/init.fc
 @@ -49,6 +49,7 @@ ifdef(`distro_gentoo',`
diff --git a/recipes-security/refpolicy/refpolicy/0039-policy-modules-system-authlogin-fix-login-errors-aft.patch b/recipes-security/refpolicy/refpolicy/0039-policy-modules-system-authlogin-fix-login-errors-aft.patch
index ab5b967..060b01b 100644
--- a/recipes-security/refpolicy/refpolicy/0039-policy-modules-system-authlogin-fix-login-errors-aft.patch
+++ b/recipes-security/refpolicy/refpolicy/0039-policy-modules-system-authlogin-fix-login-errors-aft.patch
@@ -1,4 +1,4 @@
-From b81fc26631ad56608eed244c3a07f6f9b0c7e8c7 Mon Sep 17 00:00:00 2001
+From b5dae809f2b46b82b75abcb562974212b370aa39 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 8 Dec 2023 14:16:26 +0800
 Subject: [PATCH] policy/modules/system/authlogin: fix login errors after
@@ -67,7 +67,7 @@ index dce1a0ea9..c55cdfc09 100644
  	auth_create_faillog_files($1_su_t)
  	auth_rw_faillog($1_su_t)
 diff --git a/policy/modules/system/authlogin.te b/policy/modules/system/authlogin.te
-index 3a5d1ac3e..f9d50a8d4 100644
+index 5d675bc15..2ca79e95d 100644
 --- a/policy/modules/system/authlogin.te
 +++ b/policy/modules/system/authlogin.te
 @@ -10,7 +10,7 @@ policy_module(authlogin)
@@ -80,10 +80,10 @@ index 3a5d1ac3e..f9d50a8d4 100644
  ## <desc>
  ## <p>
 diff --git a/policy/modules/system/selinuxutil.te b/policy/modules/system/selinuxutil.te
-index 3eedf82c3..875f0a02f 100644
+index ebc1abc10..c6b2ec47a 100644
 --- a/policy/modules/system/selinuxutil.te
 +++ b/policy/modules/system/selinuxutil.te
-@@ -247,6 +247,7 @@ allow newrole_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_re
+@@ -251,6 +251,7 @@ allow newrole_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_re
  read_files_pattern(newrole_t, default_context_t, default_context_t)
  read_lnk_files_pattern(newrole_t, default_context_t, default_context_t)
  
@@ -91,10 +91,10 @@ index 3eedf82c3..875f0a02f 100644
  kernel_read_system_state(newrole_t)
  kernel_read_kernel_sysctls(newrole_t)
  kernel_dontaudit_getattr_proc(newrole_t)
-@@ -290,6 +291,7 @@ auth_use_nsswitch(newrole_t)
- auth_run_chk_passwd(newrole_t, newrole_roles)
+@@ -295,6 +296,7 @@ auth_run_chk_passwd(newrole_t, newrole_roles)
  auth_run_upd_passwd(newrole_t, newrole_roles)
  auth_rw_faillog(newrole_t)
+ auth_search_faillog(newrole_t)
 +auth_read_shadow(newrole_t)
  
  # Write to utmp.
diff --git a/recipes-security/refpolicy/refpolicy_git.inc b/recipes-security/refpolicy/refpolicy_git.inc
index 322c277..ee69664 100644
--- a/recipes-security/refpolicy/refpolicy_git.inc
+++ b/recipes-security/refpolicy/refpolicy_git.inc
@@ -2,7 +2,7 @@ PV = "2.20240226+git"
 
 SRC_URI = "git://github.com/SELinuxProject/refpolicy.git;protocol=https;branch=main;name=refpolicy;destsuffix=refpolicy"
 
-SRCREV_refpolicy ?= "6507eebc238b4495b1e0d3baa2bc0bb737f9819a"
+SRCREV_refpolicy ?= "c920fc5d9e626874b9af8693e5aa697200f76a12"
 
 UPSTREAM_CHECK_GITTAGREGEX = "RELEASE_(?P<pver>\d+_\d+)"
 
-- 
2.25.1


