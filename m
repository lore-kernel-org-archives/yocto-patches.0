Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FE5EEB572
	for <webhook@archiver.kernel.org>; Thu, 12 Sep 2024 09:19:01 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.43837.1726132733388105670
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Sep 2024 02:18:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=998582a7bf=yi.zhao@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48C5E2om016531;
	Thu, 12 Sep 2024 02:18:51 -0700
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41gpbk5j3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 02:18:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMw1RNCnb6z4LCLXJfhq4EBZNLwc4l3SudYHhsPnMnuDmEUVVgLHP+yuV3Rc07JXbp1E5mxmGUItARsRbMls1azzBVW6hrC+A/f8+nc2321Fglihm2yU74pTjQqrdAFyTHWeR0ZwMZdYlh/XKO4uHsCtup0ydOeTy/GUKqpKDGMOH1odGY1EINw6SqOGlmWLmGQ4B1LEv3LX9+hZLnoeywI/3R6AKSZkDi06kg1qUVv+O3DxeGkyCm5YqDskeiQ92u4m8J7yoSibuu7g4q47JRSNR6QBI1f6ZiLGMlvaYVxBC16tc+Q6pYXqWIeEQw5jha4msBfHrkhjIplYk93y0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukDRS/iMndFerbGs+HzHBqSq55RY4Dj0JvXIST+GQP8=;
 b=KcA4/k8LUMcXv6xFRr3zDvaC/wUJ6ZNkC769U/7jPMlg38eaZ9CAVB9KydggZ5RD/19+8VGSGz9Skxt6REk5Ah/X/qfJnoxK29CmkIH9hUCbFqLVAqzmlyRt5ngmwEhz1IWtQ1D9XMyCivhkXaw/9T0Oqy0JONldIsvIVUvo6rz85T7mDdl8B6dtl2bpUz0XMWV8DdSz7WP3yiy3jvGjd47p1AuIUZCerfFEHKMZ/dyZ61/epjzV6tB4MKPW5Nj2e0Dt4SSMw06+2b/DAY9p2CnIGkOhTFFcG0K+L8VUvtdLDYiTnvsN0cYQLkIIquowa9O8p+bMGWVV6fnKeg/MKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 CO1PR11MB4945.namprd11.prod.outlook.com (2603:10b6:303:9c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.17; Thu, 12 Sep 2024 09:18:47 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%5]) with mapi id 15.20.7962.017; Thu, 12 Sep 2024
 09:18:47 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org, joe@deserted.net,
        joe.macdonald@siemens.com
Subject: [meta-selinux][PATCH] refpolicy: update to latest git rev
Date: Thu, 12 Sep 2024 17:18:36 +0800
Message-Id: <20240912091836.179714-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYXPR01CA0058.jpnprd01.prod.outlook.com
 (2603:1096:403:a::28) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|CO1PR11MB4945:EE_
X-MS-Office365-Filtering-Correlation-Id: d97f9729-e1d7-4de3-bd39-08dcd30be7b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?K+p/c5Talqc7qNI8tBAOqUXuCvg0SZKTpqx26aaNxkHGlxeTclNzquZSrFHa?=
 =?us-ascii?Q?iRHawbczpgiePAk1J+WtZej8oJnXnnikSOsmxJVMoRf/9nB574wkFGTb2fyu?=
 =?us-ascii?Q?JdG0gdHCrCfv7WXChf5XX7JNW+Rh7DsHSJ/7BB82oahW9u+EyqhmHqrRq6lU?=
 =?us-ascii?Q?B1H8DMj8VWBC08RfY0Yut7AXaq1NDxoxGkzC0ASotTzinvtcmhfTRmyfS24h?=
 =?us-ascii?Q?k/4UJ1jA8kc5gmJvoAbPrSL5dwVFOnaJPVutHL0MvkY4EDkYn87FwIdbnnAk?=
 =?us-ascii?Q?in4ShzwMUAlshVW77JqUTRnYzXKl1YRUJsRBG/ugbw99qcpz+rGGvdTew1d/?=
 =?us-ascii?Q?xHs4KhJhxVAxeOEbKPY6Si95rTnsENbBmDPYcToX4qg6ga/hBqVXiIjFvGys?=
 =?us-ascii?Q?QFz/r66A9FOEx5VaOV9TUmH2ASxqAvBSIJK2AeykQbGP7/yPrmHmJ44yFPay?=
 =?us-ascii?Q?GZdX58jjTFYVUVOdz9bDoz7I4va5s5F0SVqUbsy3Lwm4XwhrznDc9LI29bYD?=
 =?us-ascii?Q?gsFwIUh1B0lco2jclUo2moDXzPR5uix0oj1AO2BcLnSWcaqsZK5V8R5D8/Yy?=
 =?us-ascii?Q?uYmuWjouyF8W4EoMZ5nnXYeKds/2siUMRbbRtsQOPf6htHyDxI2Bet3nbyHZ?=
 =?us-ascii?Q?M7q4XCZOpw20VZnxH7rs18dKGcwPyNeoYN51rphQw8t7qr7S92/LUSBx9hiQ?=
 =?us-ascii?Q?TBTaMuUCFcnmmm0+EEtyKWrlwb5LXvTZJIl6bWALqZ6svf1zEF4QqwPpHftD?=
 =?us-ascii?Q?CLuwOqlZEyH6+Dsg+7kCZz88IuSFBXuqnsqUfDTBTqJB763rgfJyxjk1GUnX?=
 =?us-ascii?Q?hpqWNeMP7d0Hy2lNtvLWtXvGwfQwD8CadmX/EemwmWto95QLiFl1wCnLTzJp?=
 =?us-ascii?Q?qQlZGVtWbh8CtGCUcBBqjWoXy+5H/MghAICwPU9ot9KN/5Klqh7b8qfmuA7K?=
 =?us-ascii?Q?iTx+clex1dBX0C0ypjeQV4WTUjjBQr6LeBmmKGYoxrmaNqt7t62u/2y4/EL1?=
 =?us-ascii?Q?EpUxB9chjPyU7Pqep9dgOMT+nrmC1iQUZ3mSJKkVmjenhm8/cdmbHkgf+Jzj?=
 =?us-ascii?Q?XC2yESEL0CwE3OcAzvMupcY0m9yZMl6m4EhBLa+/6vqu0KzJo9G7oIKc3yLH?=
 =?us-ascii?Q?ESVWHqF6RmF9YswQxdrMY6i41bhKPA2L6SjScZX7jRQz/T9vdakJWIFXUiR3?=
 =?us-ascii?Q?gw30sXyRNgPOG9+vOYbwd83gzkHU98w5xIKcNbDkiuX95wRhfTTZaXL68P3l?=
 =?us-ascii?Q?PAN9FMISMQzD5nL9oY/dFgs8UQOlodS4Tne8dqeWzfMMcrWuYbSuwMrol2AX?=
 =?us-ascii?Q?pUuXjXgWmYWTITGLwbyrFZzZFAhlV5wSaS6YaK/eiY1Kr84s8l6IuIPAJNaf?=
 =?us-ascii?Q?vL3Jv0Z5Ywa6Pjw/3o5gCP2OOVSTWQWH7n+adZiHjexMP88LJw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OsfUs7ifskE+yN1JJNACaEucHsmZU962Zz7Nf1V0/sxARlDM6IrEnOiqwm5G?=
 =?us-ascii?Q?szxDoU8HItYIY2IfPC4NL9gxC67Ki0OOJviPICRbsOVsY3rK3wDe1XVocWsz?=
 =?us-ascii?Q?BcpIf2GI+XNAjfaRCmzd5ybJlsEMW5PRkf/JsTr2BAzRL2/VjhFalI6ATTTZ?=
 =?us-ascii?Q?k5y/3ekp5QjgD4RlmZ0D4e4WTGuGfHQaPP+1GAb+lVBMq7S2jYzZoG1ULs5c?=
 =?us-ascii?Q?5KlRYNQoHzadk0AXCjb4dzp4xbN6VpiorTDO6FNF/rLhqp3rWIBwOdC782A/?=
 =?us-ascii?Q?aO0iuYkGvnVIH3YiceyCtm8MwLgKLCl9ZikVrWuKFkhULpy0UOA4vWw3wxgp?=
 =?us-ascii?Q?Sxtp69PfNOfpbdIjSUSXx4lQ/1nvPpbn6wYjY0KErcJPr9H8sYjyva4HcS4n?=
 =?us-ascii?Q?xUtceUWztp/JuQcgg8Drb0Z9W1pS1gtmFQVFpjrV1HdNAJOPvxQFht+yOxmH?=
 =?us-ascii?Q?HnuHJf8NRb0yix7ZoEaz9WKQudYuJMahgIXsRdI1c7L8Lws/zTK+1wOZKr99?=
 =?us-ascii?Q?2ZYL/z9Fv9aqKwiFrSGgV5OUBRxHidZHqxDnfFQhlKtiorpl0rWpeSCS11wL?=
 =?us-ascii?Q?o2R+kiJTQ4KNjWrXv11oE99A0nzWpVDzy/uE6OOS26k3gEo17lsYo8zAbIcl?=
 =?us-ascii?Q?TCeiR4Lnu2Wx5KpoDeFnonDHdXOrvtGNJclZdkXyZV/yrzD89hsdEUoeakB6?=
 =?us-ascii?Q?ZbfcT1l0VCZRX2c6eIeHwB4uxdU0T85QIGhhP39yzhhk9GFFnZvOhR+E3Hz4?=
 =?us-ascii?Q?Pky0bLHdsIl2ucU5BFJLJKT9XIL+D1WowqCjqKzVzercXIHsM0lKqrh+dE0y?=
 =?us-ascii?Q?N0UdqqpOLFHioR6/6njwbDj3rUeZb6uTgp9gY8rr//6IBxzLxySH/BNvVKkY?=
 =?us-ascii?Q?qi36gUTLmNz3NYl4bm7QiEoFCuA7J9Hk+OX7lpTq7Zu9SzECX8WyV1IAT7qc?=
 =?us-ascii?Q?zbczUWWLTULRSSDe0i/aS2CKTln0bzs4ukfKnZlzEb3GlZO5bPKx0Ehc69hQ?=
 =?us-ascii?Q?9dw7QzChOSbUlm3Lc9qrFAC16ai46o5l/+W/NEnvRHbTlPIe2okIxWc4azvX?=
 =?us-ascii?Q?rp+fSPRlhT1nq399Ek6RviMMdA2N64C4mhw/0EQIEDFWrBbLTsK3bkr6TCfz?=
 =?us-ascii?Q?cRrFbVwGevlTR+c7rm6BoSGdKHoP4s56j7OH+uccxUMVOvLccpKR1wqG6470?=
 =?us-ascii?Q?s7u1aOibPlwFAcghYvA68+GkHDQD1OjwjcH3RHjgaNyS4GwjVtgmb9d8Wku7?=
 =?us-ascii?Q?Eq1djvap2aurvf/d8oXMqrD1GQxRxTC+VwS+6Hq8klfS5VVTWru2KiM42KbI?=
 =?us-ascii?Q?Q1QK5CzrZSArC9IgpM9QmqeL8ovfcdp/jiPPPSZJK987TdskkPtd8v5YjcmI?=
 =?us-ascii?Q?mX/WdaLZ5jJDSgIta8iELxvlcTv1wN9Llw66GJ5/SlaWZJ/8WYTQpX3+w6aE?=
 =?us-ascii?Q?TsVvCaAzq7iHENqMf6OmxmwRNtthsGMvdKvoI+jQBCQ4jY1Wz8fidUV1j70W?=
 =?us-ascii?Q?JhjgN69tbj0ZB/DY2iUF5wctfOdvbppSbyOnTygDURrAx4Eq4ao/kGE/zmz5?=
 =?us-ascii?Q?bOQv5rlaHkS7TkV9MhTc7kBY5edCPZ0rpPF5KhGm?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d97f9729-e1d7-4de3-bd39-08dcd30be7b9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 09:18:47.0239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ZhrjGTmwpM3K1eyS4shb8xaVIUyey4jJPY200bMRNyxUEDP1tMDSGJPY8RdIS3IQ98HvfSFhMm8oy3YntTyfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4945
X-Proofpoint-GUID: zM7v65sm_igDY2-xkhgRFtUs0mbhilif
X-Authority-Analysis: v=2.4 cv=Ye3v5BRf c=1 sm=1 tr=0 ts=66e2b1fa cx=c_pps a=oYCWE2dcp7hbP1SgTdEJ+A==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=EaEq8P2WXUwA:10 a=bRTqI5nwn0kA:10 a=t7CeM3EgAAAA:8 a=NEAV23lmAAAA:8 a=J3QT8kk37hbbpMvZlQEA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: zM7v65sm_igDY2-xkhgRFtUs0mbhilif
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_02,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2408220000 definitions=main-2409120065
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Sep 2024 09:19:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/644

* Update policy for systemd-v256

  c20cf2214 systemd: allow systemd-hostnamed to read vsock device
  4f3437040 systemd: fix policy for systemd-ssh-generator
  d852b7540 devices: add label vsock_device_t for /dev/vsock
  a4a7b830f systemd: add policy for systemd-nsresourced
  47081be47 systemd: allow system --user to create netlink_route_socket
  78cacc708 systemd: allow systemd-networkd to manage sock files under
            /run/systemd/netif
  29d0bb8c3 systemd: set context to systemd_networkd_var_lib_t for
            /var/lib/systemd/network
  22fd3ddad Allow interactive user terminal output for the NetLabel
            management tool.
  c1284c601 bluetooth: Move line.
  50a5555f2 Adding SE Policy rules to allow usage of unix stream sockets
            by dbus and bluetooth contexts when Gatt notifications are
            turned on by remote.
  2b8fa2b4a kubernetes: allow kubelet to connect all TCP ports
  9ab94df30 container: allow reading generic certs
  7530dfa3c testing: add container_kvm_t to net admin exempt list
  47eced9be Makefile: drop duplicate quotes
  b0b0d52dd various: rules required for DV manipulation in kubevirt
  21e4a44c0 container: add container_kvm_t and supporting kubevirt rules
  a9bd177bb iptables: allow reading container engine tmp files
  af0b40824 container: allow spc various rules for kubevirt
  d585f08c2 container, kubernetes: add supporting rules for kubevirt and
            multus
  9f37f86b2 dbus: dontaudit session bus domains the netadmin capability
  d9ca32f5a container: allow super privileged containers to manage BPF
            dirs
  1900fbe68 kubernetes: allow kubelet to create unlabeled dirs
  b9c8ba607 haproxy: allow interactive usage
  846804c58 podman: allow managing init runtime units
  8787b3d8d iptables: allow reading usr files

* Drop obsolete patches:
  0033-policy-modules-services-rpcbind-allow-rpcbind_t-to-c.patch
  0039-policy-modules-system-authlogin-fix-login-errors-aft.patch

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...ervices-rpcbind-allow-rpcbind_t-to-c.patch |  34 ------
 ...ystem-authlogin-fix-login-errors-aft.patch | 104 -----------------
 ...-to-read-tmpfs-under-run-credentials.patch | 106 ++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |   3 +-
 recipes-security/refpolicy/refpolicy_git.inc  |   2 +-
 5 files changed, 108 insertions(+), 141 deletions(-)
 delete mode 100644 recipes-security/refpolicy/refpolicy/0033-policy-modules-services-rpcbind-allow-rpcbind_t-to-c.patch
 delete mode 100644 recipes-security/refpolicy/refpolicy/0039-policy-modules-system-authlogin-fix-login-errors-aft.patch
 create mode 100644 recipes-security/refpolicy/refpolicy/0057-Allow-services-to-read-tmpfs-under-run-credentials.patch

diff --git a/recipes-security/refpolicy/refpolicy/0033-policy-modules-services-rpcbind-allow-rpcbind_t-to-c.patch b/recipes-security/refpolicy/refpolicy/0033-policy-modules-services-rpcbind-allow-rpcbind_t-to-c.patch
deleted file mode 100644
index 073068e..0000000
--- a/recipes-security/refpolicy/refpolicy/0033-policy-modules-services-rpcbind-allow-rpcbind_t-to-c.patch
+++ /dev/null
@@ -1,34 +0,0 @@
-From 8cbc09769a08cf3f5dcb611d471e5da298bde67c Mon Sep 17 00:00:00 2001
-From: Yi Zhao <yi.zhao@windriver.com>
-Date: Wed, 1 Jul 2020 08:44:07 +0800
-Subject: [PATCH] policy/modules/services/rpcbind: allow rpcbind_t to create
- directory with label rpcbind_runtime_t
-
-Fixes:
-avc:  denied  { create } for  pid=136 comm="rpcbind" name="rpcbind"
-scontext=system_u:system_r:rpcbind_t:s0-s15:c0.c1023
-tcontext=system_u:object_r:var_run_t:s0 tclass=dir permissive=0
-
-Upstream-Status: Inappropriate [embedded specific]
-
-Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
----
- policy/modules/services/rpcbind.te | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/policy/modules/services/rpcbind.te b/policy/modules/services/rpcbind.te
-index 137c21ece..2a712192b 100644
---- a/policy/modules/services/rpcbind.te
-+++ b/policy/modules/services/rpcbind.te
-@@ -25,7 +25,7 @@ files_type(rpcbind_var_lib_t)
- # Local policy
- #
- 
--allow rpcbind_t self:capability { dac_override setgid setuid sys_tty_config };
-+allow rpcbind_t self:capability { dac_override setgid setuid sys_tty_config chown };
- # net_admin is for SO_SNDBUFFORCE
- dontaudit rpcbind_t self:capability net_admin;
- allow rpcbind_t self:fifo_file rw_fifo_file_perms;
--- 
-2.25.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0039-policy-modules-system-authlogin-fix-login-errors-aft.patch b/recipes-security/refpolicy/refpolicy/0039-policy-modules-system-authlogin-fix-login-errors-aft.patch
deleted file mode 100644
index 060b01b..0000000
--- a/recipes-security/refpolicy/refpolicy/0039-policy-modules-system-authlogin-fix-login-errors-aft.patch
+++ /dev/null
@@ -1,104 +0,0 @@
-From b5dae809f2b46b82b75abcb562974212b370aa39 Mon Sep 17 00:00:00 2001
-From: Yi Zhao <yi.zhao@windriver.com>
-Date: Fri, 8 Dec 2023 14:16:26 +0800
-Subject: [PATCH] policy/modules/system/authlogin: fix login errors after
- enabling systemd DynamicUser
-
-Allow domains using PAM to read /etc/shadow to fix login errors after
-enabling systemd DynamicUser.
-
-Fixes:
-avc:  denied  { read } for  pid=434 comm="login" name="shadow"
-dev="sda2" ino=26314
-scontext=system_u:system_r:local_login_t:s0-s15:c0.c1023
-tcontext=system_u:object_r:shadow_t:s0 tclass=file permissive=1
-
-avc:  denied  { open } for  pid=434 comm="login" path="/etc/shadow"
-dev="sda2" ino=26314
-scontext=system_u:system_r:local_login_t:s0-s15:c0.c1023
-tcontext=system_u:object_r:shadow_t:s0 tclass=file permissive=1
-
-avc:  denied  { getattr } for  pid=434 comm="login" path="/etc/shadow"
-dev="sda2" ino=26314
-scontext=system_u:system_r:local_login_t:s0-s15:c0.c1023
-tcontext=system_u:object_r:shadow_t:s0 tclass=file permissive=1
-
-avc:  denied  { read } for  pid=457 comm="sshd" name="shadow" dev="sda2"
-ino=26314 scontext=system_u:system_r:sshd_t:s0-s15:c0.c1023
-tcontext=system_u:object_r:shadow_t:s0 tclass=file permissive=1
-
-avc:  denied  { open } for  pid=457 comm="sshd" path="/etc/shadow"
-dev="sda2" ino=26314 scontext=system_u:system_r:sshd_t:s0-s15:c0.c1023
-tcontext=system_u:object_r:shadow_t:s0 tclass=file permissive=1
-
-avc:  denied  { getattr } for  pid=457 comm="sshd" path="/etc/shadow"
-dev="sda2" ino=26314 scontext=system_u:system_r:sshd_t:s0-s15:c0.c1023
-tcontext=system_u:object_r:shadow_t:s0 tclass=file permissive=1
-
-Upstream-Status: Inappropriate [embedded specific]
-
-Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
----
- policy/modules/admin/su.if           | 4 ++--
- policy/modules/system/authlogin.te   | 2 +-
- policy/modules/system/selinuxutil.te | 2 ++
- 3 files changed, 5 insertions(+), 3 deletions(-)
-
-diff --git a/policy/modules/admin/su.if b/policy/modules/admin/su.if
-index dce1a0ea9..c55cdfc09 100644
---- a/policy/modules/admin/su.if
-+++ b/policy/modules/admin/su.if
-@@ -76,7 +76,7 @@ template(`su_restricted_domain_template', `
- 	selinux_compute_access_vector($1_su_t)
- 
- 	auth_domtrans_chk_passwd($1_su_t)
--	auth_dontaudit_read_shadow($1_su_t)
-+	auth_read_shadow($1_su_t)
- 	auth_use_nsswitch($1_su_t)
- 	auth_create_faillog_files($1_su_t)
- 	auth_rw_faillog($1_su_t)
-@@ -183,7 +183,7 @@ template(`su_role_template',`
- 	selinux_use_status_page($1_su_t)
- 
- 	auth_domtrans_chk_passwd($1_su_t)
--	auth_dontaudit_read_shadow($1_su_t)
-+	auth_read_shadow($1_su_t)
- 	auth_use_nsswitch($1_su_t)
- 	auth_create_faillog_files($1_su_t)
- 	auth_rw_faillog($1_su_t)
-diff --git a/policy/modules/system/authlogin.te b/policy/modules/system/authlogin.te
-index 5d675bc15..2ca79e95d 100644
---- a/policy/modules/system/authlogin.te
-+++ b/policy/modules/system/authlogin.te
-@@ -10,7 +10,7 @@ policy_module(authlogin)
- ## Allow PAM usage.  If disabled, read access /etc/shadow is allowed for domains that normally use PAM.
- ## </p>
- ## </desc>
--gen_tunable(authlogin_pam, true)
-+gen_tunable(authlogin_pam, false)
- 
- ## <desc>
- ## <p>
-diff --git a/policy/modules/system/selinuxutil.te b/policy/modules/system/selinuxutil.te
-index ebc1abc10..c6b2ec47a 100644
---- a/policy/modules/system/selinuxutil.te
-+++ b/policy/modules/system/selinuxutil.te
-@@ -251,6 +251,7 @@ allow newrole_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_re
- read_files_pattern(newrole_t, default_context_t, default_context_t)
- read_lnk_files_pattern(newrole_t, default_context_t, default_context_t)
- 
-+kernel_getattr_proc(newrole_t)
- kernel_read_system_state(newrole_t)
- kernel_read_kernel_sysctls(newrole_t)
- kernel_dontaudit_getattr_proc(newrole_t)
-@@ -295,6 +296,7 @@ auth_run_chk_passwd(newrole_t, newrole_roles)
- auth_run_upd_passwd(newrole_t, newrole_roles)
- auth_rw_faillog(newrole_t)
- auth_search_faillog(newrole_t)
-+auth_read_shadow(newrole_t)
- 
- # Write to utmp.
- init_rw_utmp(newrole_t)
--- 
-2.25.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0057-Allow-services-to-read-tmpfs-under-run-credentials.patch b/recipes-security/refpolicy/refpolicy/0057-Allow-services-to-read-tmpfs-under-run-credentials.patch
new file mode 100644
index 0000000..629de01
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0057-Allow-services-to-read-tmpfs-under-run-credentials.patch
@@ -0,0 +1,106 @@
+From be681d155c6c62a2ec4939dedc921921fe73e277 Mon Sep 17 00:00:00 2001
+From: Yi Zhao <yi.zhao@windriver.com>
+Date: Fri, 30 Aug 2024 12:39:48 +0800
+Subject: [PATCH] Allow services to read tmpfs under /run/credentials/
+
+$ mount | grep credentials
+tmpfs on /run/credentials/systemd-journald.service type tmpfs (ro,nosuid,nodev,noexec,relatime,nosymfollow,seclabel,size=1024k,nr_inodes=1024,mode=700,noswap)
+tmpfs on /run/credentials/systemd-udev-load-credentials.service type tmpfs (ro,nosuid,nodev,noexec,relatime,nosymfollow,seclabel,size=1024k,nr_inodes=1024,mode=700,noswap)
+tmpfs on /run/credentials/systemd-tmpfiles-setup-dev-early.service type tmpfs (ro,nosuid,nodev,noexec,relatime,nosymfollow,seclabel,size=1024k,nr_inodes=1024,mode=700,noswap)
+tmpfs on /run/credentials/systemd-sysctl.service type tmpfs (ro,nosuid,nodev,noexec,relatime,nosymfollow,seclabel,size=1024k,nr_inodes=1024,mode=700,noswap)
+tmpfs on /run/credentials/systemd-tmpfiles-setup-dev.service type tmpfs (ro,nosuid,nodev,noexec,relatime,nosymfollow,seclabel,size=1024k,nr_inodes=1024,mode=700,noswap)
+tmpfs on /run/credentials/systemd-vconsole-setup.service type tmpfs (ro,nosuid,nodev,noexec,relatime,nosymfollow,seclabel,size=1024k,nr_inodes=1024,mode=700,noswap)
+tmpfs on /run/credentials/systemd-tmpfiles-setup.service type tmpfs (ro,nosuid,nodev,noexec,relatime,nosymfollow,seclabel,size=1024k,nr_inodes=1024,mode=700,noswap)
+tmpfs on /run/credentials/systemd-resolved.service type tmpfs (ro,nosuid,nodev,noexec,relatime,nosymfollow,seclabel,size=1024k,nr_inodes=1024,mode=700,noswap)
+tmpfs on /run/credentials/systemd-networkd.service type tmpfs (ro,nosuid,nodev,noexec,relatime,nosymfollow,seclabel,size=1024k,nr_inodes=1024,mode=700,noswap)
+tmpfs on /run/credentials/getty@tty1.service type tmpfs (ro,nosuid,nodev,noexec,relatime,nosymfollow,seclabel,size=1024k,nr_inodes=1024,mode=700,noswap)
+
+Fixes:
+avc:  denied  { search } for  pid=106 comm="systemd-journal" name="/"
+dev="tmpfs" ino=1 scontext=system_u:system_r:syslogd_t:s15:c0.c1023
+tcontext=system_u:object_r:tmpfs_t:s0 tclass=dir permissive=1
+
+avc:  denied  { read } for  pid=114 comm="udevadm" name="/" dev="tmpfs"
+ino=1 scontext=system_u:system_r:udev_t:s0-s15:c0.c1023
+tcontext=system_u:object_r:tmpfs_t:s0 tclass=dir permissive=1
+
+avc:  denied  { open } for  pid=114 comm="udevadm"
+path="/run/credentials/systemd-udev-load-credentials.service"
+dev="tmpfs" ino=1 scontext=system_u:system_r:udev_t:s0-s15:c0.c1023
+tcontext=system_u:object_r:tmpfs_t:s0 tclass=dir permissive=1
+
+avc:  denied  { read } for  pid=353 comm="agetty" name="/" dev="tmpfs"
+ino=1 scontext=system_u:system_r:getty_t:s0-s15:c0.c1023
+tcontext=system_u:object_r:tmpfs_t:s0 tclass=dir permissive=1
+
+avc:  denied  { open } for  pid=353 comm="agetty"
+path="/run/credentials/getty@tty1.service" dev="tmpfs" ino=1
+scontext=system_u:system_r:getty_t:s0-s15:c0.c1023
+tcontext=system_u:object_r:tmpfs_t:s0 tclass=dir permissive=1
+
+avc:  denied  { getattr } for  pid=353 comm="agetty"
+path="/run/credentials/getty@tty1.service" dev="tmpfs" ino=1
+scontext=system_u:system_r:getty_t:s0-s15:c0.c1023
+tcontext=system_u:object_r:tmpfs_t:s0 tclass=dir permissive=1
+
+Upstream-Status: Pending
+
+Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
+---
+ policy/modules/system/getty.te   | 1 +
+ policy/modules/system/logging.te | 1 +
+ policy/modules/system/systemd.te | 1 +
+ policy/modules/system/udev.te    | 1 +
+ 4 files changed, 4 insertions(+)
+
+diff --git a/policy/modules/system/getty.te b/policy/modules/system/getty.te
+index a900226bf..75b94785b 100644
+--- a/policy/modules/system/getty.te
++++ b/policy/modules/system/getty.te
+@@ -75,6 +75,7 @@ fs_getattr_cgroup(getty_t)
+ fs_search_cgroup_dirs(getty_t)
+ # for error condition handling
+ fs_getattr_xattr_fs(getty_t)
++fs_list_tmpfs(getty_t)
+ 
+ mcs_process_set_categories(getty_t)
+ 
+diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
+index fc73825fa..d5878876b 100644
+--- a/policy/modules/system/logging.te
++++ b/policy/modules/system/logging.te
+@@ -495,6 +495,7 @@ files_read_kernel_symbol_table(syslogd_t)
+ files_var_lib_filetrans(syslogd_t, syslogd_var_lib_t, { file dir })
+ 
+ fs_getattr_all_fs(syslogd_t)
++fs_list_tmpfs(syslogd_t)
+ fs_search_auto_mountpoints(syslogd_t)
+ 
+ mls_file_write_all_levels(syslogd_t) # Need to be able to write to /var/run/ and /var/log directories
+diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
+index 22a319c36..0440b4795 100644
+--- a/policy/modules/system/systemd.te
++++ b/policy/modules/system/systemd.te
+@@ -1303,6 +1303,7 @@ files_watch_root_dirs(systemd_networkd_t)
+ files_list_runtime(systemd_networkd_t)
+ 
+ fs_getattr_all_fs(systemd_networkd_t)
++fs_list_tmpfs(systemd_networkd_t)
+ fs_search_cgroup_dirs(systemd_networkd_t)
+ fs_read_nsfs_files(systemd_networkd_t)
+ fs_watch_memory_pressure(systemd_networkd_t)
+diff --git a/policy/modules/system/udev.te b/policy/modules/system/udev.te
+index b2e43aa7d..f543a48d2 100644
+--- a/policy/modules/system/udev.te
++++ b/policy/modules/system/udev.te
+@@ -142,6 +142,7 @@ files_dontaudit_getattr_tmp_dirs(udev_t)
+ 
+ fs_getattr_all_fs(udev_t)
+ fs_list_inotifyfs(udev_t)
++fs_list_tmpfs(udev_t)
+ fs_read_cgroup_files(udev_t)
+ fs_rw_anon_inodefs_files(udev_t)
+ fs_search_tracefs(udev_t)
+-- 
+2.25.1
+
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 7b45882..8c9d046 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -48,13 +48,11 @@ SRC_URI += " \
         file://0030-policy-modules-kernel-files-add-rules-for-the-symlin.patch \
         file://0031-policy-modules-system-logging-fix-auditd-startup-fai.patch \
         file://0032-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch \
-        file://0033-policy-modules-services-rpcbind-allow-rpcbind_t-to-c.patch \
         file://0034-policy-modules-system-systemd-enable-support-for-sys.patch \
         file://0035-policy-modules-system-logging-allow-systemd-tmpfiles.patch \
         file://0036-policy-modules-system-systemd-allow-systemd_logind_t.patch \
         file://0037-policy-modules-roles-sysadm-allow-sysadm-to-use-init.patch \
         file://0038-policy-modules-system-systemd-systemd-user-fixes.patch \
-        file://0039-policy-modules-system-authlogin-fix-login-errors-aft.patch \
         file://0040-policy-modules-system-logging-grant-getpcap-capabili.patch \
         file://0041-policy-modules-system-mount-make-mount_t-domain-MLS-.patch \
         file://0042-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch \
@@ -72,6 +70,7 @@ SRC_URI += " \
         file://0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
         file://0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
         file://0056-policy-modules-system-logging-make-syslogd_runtime_t.patch \
+        file://0057-Allow-services-to-read-tmpfs-under-run-credentials.patch \
         "
 
 S = "${WORKDIR}/refpolicy"
diff --git a/recipes-security/refpolicy/refpolicy_git.inc b/recipes-security/refpolicy/refpolicy_git.inc
index 80d92ac..4043005 100644
--- a/recipes-security/refpolicy/refpolicy_git.inc
+++ b/recipes-security/refpolicy/refpolicy_git.inc
@@ -2,7 +2,7 @@ PV = "2.20240226+git"
 
 SRC_URI = "git://github.com/SELinuxProject/refpolicy.git;protocol=https;branch=main;name=refpolicy;destsuffix=refpolicy"
 
-SRCREV_refpolicy ?= "71f4bd1992e05bcd79dc5234f8a30deeb141aa3d"
+SRCREV_refpolicy ?= "351a5a7f4dc959769aaa8fe47c6e77f94fe5b657"
 
 UPSTREAM_CHECK_GITTAGREGEX = "RELEASE_(?P<pver>\d+_\d+)"
 
-- 
2.25.1


