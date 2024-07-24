Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D185C3DA63
	for <webhook@archiver.kernel.org>; Wed, 24 Jul 2024 05:39:17 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.4113.1721799551914488828
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Jul 2024 22:39:11 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=793573a770=yi.zhao@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46O3rfqo017816;
	Tue, 23 Jul 2024 22:39:10 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40he0vt68d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 22:39:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xb3l0HDpEkF0OT3j+iolrEMRM2DgFL/yTDncviWO9hxOiMH6abzd0YAJDa6hD3+4w51rrPzexmcmRRxYcj1Gk7SkwsusNw64u9VeG/+J/OlANqPKfnjZsPS47EdHxosV8isjSYcfInoS4UkPpkxkIErEy+IghQyuCTAvM7KhbU3a6sv4DEz2V+Tgqx50EoXy2Pyai0G81Bl/UHKTrsi+rAef7qEsMsM1ZWHh3N3MdrYjtxrXK74B38/jahW5PVMGpa87RwA1iuhFvm71TXLnyP3oxAyXIIpNeQ/+Rsbsw1N7353PfHYrGBoOc720pk6yhFEZRUkotUBN4nKowBbwoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuR/kLawucJJ7EFMXZxE10GIqYdNoa//ZyKpwIoOl7c=;
 b=jpZ8IWEhkN/cqEQ3wCtsA92rxNWoFPekGmYZTZco9whzrusB2/VjH0xDvmjFLv+46qaaSznefo8qXqzYS3gRn2uPsYDq/2sJnj3VFZavMsBris9apHylGjaaySWlgzlGAiCfjI7PnpDhbjUf8HnYra006yc47XGr91it+ryWLe7qQU1brawXfTwLwlB2WIaIKSgTEtVIPb1qLROSJ+pvSsPRGD5gVoG3MIR+N33mpPr1h1L+AGjl+zVOuQarrLJWBXh2qD6Dvy6wHhizME3VMTHUhmYl93NzgKuvrf/tSuI1iVjIUEq/a1UmCfHXJnKFcDw75Gsco2u3fYrZQMPr0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 SJ2PR11MB8514.namprd11.prod.outlook.com (2603:10b6:a03:56b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 24 Jul
 2024 05:39:07 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.7784.016; Wed, 24 Jul 2024
 05:39:07 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org, Joe_MacDonald@mentor.com,
        joe@deserted.net, joe.macdonald@siemens.com
Subject: [meta-selinux][master][scarthgap][PATCH] refpolicy: update to latest git rev
Date: Wed, 24 Jul 2024 13:38:55 +0800
Message-Id: <20240724053855.2843635-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|SJ2PR11MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d5b4515-6447-4767-af2e-08dcaba2efd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?C9hsLB3lWEu1B+GMQFtuKjOwDfiG72udd7JAuOlc+pW7e/hUVburkPRhpejt?=
 =?us-ascii?Q?lWka9TCMh/fb+gYkcfz0xjYZ43m3iY8scNBNzbYIVyIqnl5crIjqjpNJy3MU?=
 =?us-ascii?Q?yIQDQ+l2rR9qybtnQuO+MMEzdKHjsrH1C195awDLBo7sMubCDJ71KEo+4zKB?=
 =?us-ascii?Q?r/WYvVBmxtA/8KWu0M9WxNGxd3pojgNaBl1hya47454/QrPxlKAJLeAdTRit?=
 =?us-ascii?Q?J35mgHszx5tcxU7gUH/rn/zSlPPBO0e9FQVitfxHz3uDEDco35aBVj2yUuRQ?=
 =?us-ascii?Q?NHQGv4tzRzZBhP0fuTwc/ILYLvsviUCq4Qin3TBek5Ndd2OZdxDJb77xvXs5?=
 =?us-ascii?Q?jjGSQCsStnjQRwVzokz7iz6jueuMsJC2auK3Vttt4vFsORNnhmjGdq2iqAnC?=
 =?us-ascii?Q?UMvwpftqZ/Ds9oCKvE0QqDx4gSc+gjH1ZIuCOj5yqC29YZlDESm2l+hurKUP?=
 =?us-ascii?Q?ppV5leJOoTRa+HApo4M4V8mbH/Im7H5fJi8mZDvHYDXJNsDTRQmGCDMFebBG?=
 =?us-ascii?Q?AFn5U/HNHETniFnPyseH1bqeuXJxEE9vl9dtkPKa6CGAGZGTzP12Bn8htt8i?=
 =?us-ascii?Q?8RFHEkyH7X8DieFRN/XgG+iernjNIqeG+Dh6IqPCnGJB9X+3LFS5OEN0o0DZ?=
 =?us-ascii?Q?hIMRpKgWd5ZVHdiwzW5hg3P2QuttauX6KJxyWxjEAGcVNSYUk6Y2qInmEL9J?=
 =?us-ascii?Q?rtF/H7TnJSOUYVurTRoBDdnD1YI9NbQFcoZ2D+f/js9JKDtFYjev4tVg/ecl?=
 =?us-ascii?Q?ym8zKaudbXwKjN7ujSWSwZHn/D3FgJudH4s9T8t6UDOcujqjtjMt3IzivXwW?=
 =?us-ascii?Q?ycYvKgdyxfV/m0xZR/gTvGzNphExuMEX5MynvAtyikhxpmSwbEvibFsdJZ4x?=
 =?us-ascii?Q?2Fv7ujC4+1R4XeICJNWZ81hmiKPSboIGa6oMvUQpwB8JlzJeOKcumRW9fEI8?=
 =?us-ascii?Q?LjGQXOV1Y2RxK/0I6sH082wRi7ze+jwJ64eR2i1bF9HJXBMfCFewj+IfM4+0?=
 =?us-ascii?Q?ruyro/KCofE1gUXeIU39/PdKW+Xl5F2s0V5pzQGZPLMaYFxRAVTuZX2PigSr?=
 =?us-ascii?Q?/rN60QtXBtP1qnfK6Bg1HfDJFeswbtbKERIAuliKLNoN/7pyGV5j62SWUCoC?=
 =?us-ascii?Q?2dzzOpzNstqd5nws8eguxYFy+4wcd55v0ZvQxcKzwTMxg+SIi0oIsRVXKGzr?=
 =?us-ascii?Q?Gu2x+5JA7YoD3os82lYOakYR43+lfAeMWYEwXiGINvU5tyddlfempgO1cZXr?=
 =?us-ascii?Q?tDQh+/8J7U743Ip1Ch8FSjKDLy9z3G441/RlOIBi8+B564bNmAdtJa34RH1s?=
 =?us-ascii?Q?n35hH+/jTDZjstqvN7KSwf8+BgjgFAV0qxO94AtRWi3ojcg7PfLDp7eHEQqc?=
 =?us-ascii?Q?1K7So2Jm9V4jG1Lwu8yM1EvPf83WdGuKC8QHaf+hej7nMmtnjQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6URvE2Px86qe2o+a2gmpngBtnLe+vWJFVxdbz9UKfaBUkxsqXgRTNksnR/H0?=
 =?us-ascii?Q?FbHM3Pf17DXUyM43xhazk7xulCYNfJnE3kKTlPRbEHWbW6Gt+Q5/aSpSP5mV?=
 =?us-ascii?Q?NMQZ+mZkB9GbH7pRaPCrvwnXFZd3yee15AfXLnsXbm5qsEupDJpS0yWgOrPN?=
 =?us-ascii?Q?WS6qw1p/oU9tHj0zo2L64Vj4G60jInwHflimgPtzoxBMm9kMMB4g0RBuQZZ9?=
 =?us-ascii?Q?gAravm31nGLfcaey+yQ0xiAOPznFeXT6ZtpaQc//e0bLnX+qysntESgB2yjO?=
 =?us-ascii?Q?/p1eyMuduJGmwZs+71wceqzvtGVQp34rAh32WsaHUCc1dPNw76c/oBznqzqb?=
 =?us-ascii?Q?YQlcNqnd2B8YWzHZlkFDo8aGXPi9Nk4v927K8fKGvWTiye5SgCF1nqUOnFCU?=
 =?us-ascii?Q?tkPydwfAv8C049Uk6o/2NtnwyBfXR+apUf0LcIpFatNzvYNYIRF005yuLQ6l?=
 =?us-ascii?Q?m6aKgWcmJ7SjJFLz2G9Ul8q8qPL3WtgUSBNSEJi0slPUqepE7m0Op9JLmZuA?=
 =?us-ascii?Q?o80bXA1cifTCwtlAR43Wl8xil1vWa7jz9KVzR/5a+9q1BbrjK+QIw63dzPAK?=
 =?us-ascii?Q?g35hHZOMSkerRkm9exGGWJlO3QIhZ9UzauQoTzhIhPmsw2IQ7fcJWPzT56z8?=
 =?us-ascii?Q?Mp2triunsG1lULPQqP/mZhrch4USZqDvlV40lKTQSzTaRiav7dlN46F+MK3x?=
 =?us-ascii?Q?C9vNfQQx8D2gS6neN51ZclgjQGiEz+cAUAkoF9+/U7aO/q41zccCAFOm40HA?=
 =?us-ascii?Q?owoGKu5OWnq4M6ERDytkqEWCEHMJP1zaFF9cwZn1JGkgMzkwWMpjp1p/0fUO?=
 =?us-ascii?Q?aK0h+ROf7MigyGdwQcc7z63gbrPWzSyhd8iB1g8XJXDLNVy3U1ZleaWxikWY?=
 =?us-ascii?Q?6BNzGM/8XbVeFdHmkYKsfZijPvb64uqmoyUsfnP65bcITrcgmmH4GUGNc5IV?=
 =?us-ascii?Q?lwFddejCk7UklPR1XE3rwXAoroSFuTMXrOnYCERCOLTuzf40mviBnQSaDZ7S?=
 =?us-ascii?Q?PfMYrxlzNewn+9wvCGwNoHkY8gk+HLwmKt7+YxiDo2ZMF51lJ0+Z5WRwnxol?=
 =?us-ascii?Q?kj5cAJ2XeYguBIqBANcPqc4xzNZG9hiZN8CYwKe0s4l5CZS3uIRSViczC1X9?=
 =?us-ascii?Q?g1t+3lhnotRTYrHINhJfgIkPhDxoz471S2DQAnZuurcXVd6qKRXP9F7mV+qY?=
 =?us-ascii?Q?g+lOK/x0XMbHAun1pRywzgmZ1xgikZQVyTJ4mXTjjKZFxWOEPET1pK04hDVW?=
 =?us-ascii?Q?nAlyk3F7mM9/YFianX4hD4SdVzI5jDgX1CVv4IIEi9WcwZ1gj3gihD0cljNH?=
 =?us-ascii?Q?9YjoU24mBv208AdhH7A2WZoCbroCEbeOXMe4AsEMSOOZ3QcHLWorynOvMocZ?=
 =?us-ascii?Q?h4VtQVQhlrVcghaSrLocsnlWdW7r/hj5mwqlIoMUSNgIzEbsvW9yvsC98EwJ?=
 =?us-ascii?Q?c10nyE8IlUzclObhpslWv/obFtER2ZCg+3SawxelANAhgFwMxFA2Mo5ozQG+?=
 =?us-ascii?Q?7lW+2SA9rTSfany6AW8nDUBlKnerJrn9fIT/DYeYZDmDfzvJFTY4J9GsrRnT?=
 =?us-ascii?Q?iJTcd1JrfA8UDkgkV03qunl85tu6oNO20fOtpWcO?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5b4515-6447-4767-af2e-08dcaba2efd3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 05:39:07.8054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YyDL+nKP5E5PwlsQ9jN2iU+KWcsvC/4X2L6SOeYVpk42AVl6xaHzIF7G+ISShMcG4sESQ/OzZAELOicne6FIKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8514
X-Proofpoint-GUID: F_OYKowiydeRmQh10TuSZ7Lo_EZ6qEIC
X-Proofpoint-ORIG-GUID: F_OYKowiydeRmQh10TuSZ7Lo_EZ6qEIC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_03,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 suspectscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2407240040
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 24 Jul 2024 05:39:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/448

* a6cf20736 filesystem, devices: move gadgetfs to usbfs_t
* 75492f95f systemd: make xdg optional
* 097d688ff sshd: label sshd-session as sshd_exec_t
* b57b6005c Setting bluetooth helper domain for bluetoothctl
* 30f451d6a Adding Sepolicy rules to allow pulseaudio to access
            bluetooth sockets.
* 7037c341f systemd: allow logind to use locallogin pidfds
* 5f7f494d1 userdomain: allow administrative user to get attributes of
            shadow history file
* 0126cb1e6 node_exporter: allow reading RPC sysctls
* 9c90f9f7d asterisk: allow reading certbot lib
* bfcaec9ba postfix: allow postfix pipe to watch mail spool
* 06a80c3d8 netutils: allow ping to read net sysctls
* 2e0509c9e node_exporter: allow reading localization
* 50a8cddd1 container: allow containers to execute tmpfs files
* 09a747a16 sysadm: make haproxy admin
* c8c3ae2cb haproxy: initial policy
* 4e97f87ce init: use pidfds from local login
* 7fd9032d8 dbus, init: add interface for pidfd usage
* a6d6921a9 asterisk: allow watching spool dirs
* 72c1d912f su, sudo: allow sudo to signal all su domains
* 8b3178248 sudo: allow systemd-logind to read cgroup state of sudo
* 871f0b0dd postfix: allow smtpd to mmap SASL keytab files
* 578375480 sysnetwork: allow ifconfig to read usr files
* 6916e9b20 systemd: allow systemd-logind to use sshd pidfds
* 96ebb7c4e Reorder perms and classes
* cb68df087 tests.yml: Add policy diff on PRs.
* 99258825c tests.yml: Divide into reusable workflows.
* 1e4b68930 Reorder perms and classes

Drop 0002-refpolicy-minimum-make-xdg-module-optional.patch and
0040-policy-modules-system-systemd-allow-systemd-logind-t.patch which
have been merged upstream.

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../refpolicy/refpolicy-minimum_git.bb        |  1 -
 ...icy-minimum-make-xdg-module-optional.patch | 40 -------------------
 ...stem-logging-grant-getpcap-capabili.patch} |  0
 ...ystem-systemd-allow-systemd-logind-t.patch | 38 ------------------
 .../refpolicy/refpolicy_common.inc            |  3 +-
 recipes-security/refpolicy/refpolicy_git.inc  |  2 +-
 6 files changed, 2 insertions(+), 82 deletions(-)
 delete mode 100644 recipes-security/refpolicy/refpolicy/0002-refpolicy-minimum-make-xdg-module-optional.patch
 rename recipes-security/refpolicy/refpolicy/{0057-policy-modules-system-logging-grant-getpcap-capabili.patch => 0040-policy-modules-system-logging-grant-getpcap-capabili.patch} (100%)
 delete mode 100644 recipes-security/refpolicy/refpolicy/0040-policy-modules-system-systemd-allow-systemd-logind-t.patch

diff --git a/recipes-security/refpolicy/refpolicy-minimum_git.bb b/recipes-security/refpolicy/refpolicy-minimum_git.bb
index 67c3785..562ccac 100644
--- a/recipes-security/refpolicy/refpolicy-minimum_git.bb
+++ b/recipes-security/refpolicy/refpolicy-minimum_git.bb
@@ -13,7 +13,6 @@ domains are unconfined. \
 
 SRC_URI += " \
         file://0001-refpolicy-minimum-make-sysadmin-module-optional.patch \
-        file://0002-refpolicy-minimum-make-xdg-module-optional.patch \
         "
 
 POLICY_NAME = "minimum"
diff --git a/recipes-security/refpolicy/refpolicy/0002-refpolicy-minimum-make-xdg-module-optional.patch b/recipes-security/refpolicy/refpolicy/0002-refpolicy-minimum-make-xdg-module-optional.patch
deleted file mode 100644
index cc8c0b7..0000000
--- a/recipes-security/refpolicy/refpolicy/0002-refpolicy-minimum-make-xdg-module-optional.patch
+++ /dev/null
@@ -1,40 +0,0 @@
-From 39b825d24a34864c3d9bae684b083a9b656f641a Mon Sep 17 00:00:00 2001
-From: Yi Zhao <yi.zhao@windriver.com>
-Date: Wed, 29 Sep 2021 11:08:49 +0800
-Subject: [PATCH] refpolicy-minimum: make xdg module optional
-
-The systemd module invokes xdg_config_content and xdg_data_content
-interfaces which are from xdg module. Since xdg is not a core module, we
-could make it optional in minimum policy.
-
-Upstream-Status: Inappropriate [embedded specific]
-
-Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
----
- policy/modules/system/systemd.te | 8 ++++++--
- 1 file changed, 6 insertions(+), 2 deletions(-)
-
-diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index a0e6bb405..b1fc414ea 100644
---- a/policy/modules/system/systemd.te
-+++ b/policy/modules/system/systemd.te
-@@ -313,10 +313,14 @@ init_unit_file(systemd_user_manager_unit_t)
- 
- type systemd_conf_home_t;
- init_unit_file(systemd_conf_home_t)
--xdg_config_content(systemd_conf_home_t)
-+optional_policy(`
-+	xdg_config_content(systemd_conf_home_t)
-+')
- 
- type systemd_data_home_t;
--xdg_data_content(systemd_data_home_t)
-+optional_policy(`
-+	xdg_data_content(systemd_data_home_t)
-+')
- 
- type systemd_user_runtime_notify_t;
- userdom_user_runtime_content(systemd_user_runtime_notify_t)
--- 
-2.25.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0057-policy-modules-system-logging-grant-getpcap-capabili.patch b/recipes-security/refpolicy/refpolicy/0040-policy-modules-system-logging-grant-getpcap-capabili.patch
similarity index 100%
rename from recipes-security/refpolicy/refpolicy/0057-policy-modules-system-logging-grant-getpcap-capabili.patch
rename to recipes-security/refpolicy/refpolicy/0040-policy-modules-system-logging-grant-getpcap-capabili.patch
diff --git a/recipes-security/refpolicy/refpolicy/0040-policy-modules-system-systemd-allow-systemd-logind-t.patch b/recipes-security/refpolicy/refpolicy/0040-policy-modules-system-systemd-allow-systemd-logind-t.patch
deleted file mode 100644
index 4322590..0000000
--- a/recipes-security/refpolicy/refpolicy/0040-policy-modules-system-systemd-allow-systemd-logind-t.patch
+++ /dev/null
@@ -1,38 +0,0 @@
-From 1b8a639bfdce84c9b39cd9e89b6da4c1d06cc7ab Mon Sep 17 00:00:00 2001
-From: Yi Zhao <yi.zhao@windriver.com>
-Date: Sun, 4 Feb 2024 19:40:32 +0800
-Subject: [PATCH] policy/modules/system/systemd: allow systemd-logind to
- inherit local login file descriptors
-
-Fix reboot timeout error:
-$ reboot
-Failed to set wall message, ignoring: Failed to activate service 'org.freedesktop.login1': timed out (service_start_timeout=25000ms)
-Call to Reboot failed: Failed to activate service 'org.freedesktop.login1': timed out (service_start_timeout=25000ms)
-
-avc:  denied  { use } for  pid=287 comm="systemd-logind"
-path="anon_inode:[pidfd]" dev="anon_inodefs" ino=1044
-scontext=system_u:system_r:systemd_logind_t
-tcontext=system_u:system_r:local_login_t tclass=fd permissive=0
-
-Upstream-Status: Pending
-
-Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
----
- policy/modules/system/systemd.te | 1 +
- 1 file changed, 1 insertion(+)
-
-diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index ffce3c0e8..03aeb8515 100644
---- a/policy/modules/system/systemd.te
-+++ b/policy/modules/system/systemd.te
-@@ -973,6 +973,7 @@ init_stop_system(systemd_logind_t)
- miscfiles_read_localization(systemd_logind_t)
- 
- locallogin_read_state(systemd_logind_t)
-+locallogin_use_fds(systemd_logind_t)
- 
- seutil_libselinux_linked(systemd_logind_t)
- seutil_read_default_contexts(systemd_logind_t)
--- 
-2.25.1
-
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 05dca2c..7b45882 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -55,7 +55,7 @@ SRC_URI += " \
         file://0037-policy-modules-roles-sysadm-allow-sysadm-to-use-init.patch \
         file://0038-policy-modules-system-systemd-systemd-user-fixes.patch \
         file://0039-policy-modules-system-authlogin-fix-login-errors-aft.patch \
-        file://0040-policy-modules-system-systemd-allow-systemd-logind-t.patch \
+        file://0040-policy-modules-system-logging-grant-getpcap-capabili.patch \
         file://0041-policy-modules-system-mount-make-mount_t-domain-MLS-.patch \
         file://0042-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch \
         file://0043-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch \
@@ -72,7 +72,6 @@ SRC_URI += " \
         file://0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
         file://0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
         file://0056-policy-modules-system-logging-make-syslogd_runtime_t.patch \
-        file://0057-policy-modules-system-logging-grant-getpcap-capabili.patch \
         "
 
 S = "${WORKDIR}/refpolicy"
diff --git a/recipes-security/refpolicy/refpolicy_git.inc b/recipes-security/refpolicy/refpolicy_git.inc
index ee69664..80d92ac 100644
--- a/recipes-security/refpolicy/refpolicy_git.inc
+++ b/recipes-security/refpolicy/refpolicy_git.inc
@@ -2,7 +2,7 @@ PV = "2.20240226+git"
 
 SRC_URI = "git://github.com/SELinuxProject/refpolicy.git;protocol=https;branch=main;name=refpolicy;destsuffix=refpolicy"
 
-SRCREV_refpolicy ?= "c920fc5d9e626874b9af8693e5aa697200f76a12"
+SRCREV_refpolicy ?= "71f4bd1992e05bcd79dc5234f8a30deeb141aa3d"
 
 UPSTREAM_CHECK_GITTAGREGEX = "RELEASE_(?P<pver>\d+_\d+)"
 
-- 
2.25.1


