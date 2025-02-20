Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631C9C021B1
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 09:44:31 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.45837.1740044664539797685
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Feb 2025 01:44:24 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=41465756f6=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K7gCeW022618;
	Thu, 20 Feb 2025 09:44:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 44w00kj5mb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 09:44:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkLzlYaBVksI5BNqQxknklVjlkRiZ55tlJJ81cxqKSMGQmjNriti7pHq2MgVkWvCHhzz14rw317vURMGT+LsL5Y68q5VZLs29Bp71IOkU3JBk21YDzoqdEO4vdl+f6PiUvkIKM2fDYtYlaY6ZxgNgdV7gIpJOqtEU6gG+tkXH8T88K+FtsnbI16r2P40JSk0SxLv1nJOt9bF2QnygRnkuu5BEhkBp918XtWGXaRh1tQ9CrkL01UGUS2qvXt6h1NcGCbs0jPTDLcsqGduzMpNg2ivqzJ0urH8AivtCzMIicA5Homkxrk6Me6BNN15smyPLCNPeU2ZdAoXf+3qQgYpsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uWqe03KrwozxPnFUWpS+cy2XV9w5L9CNP7Ldki1HJU=;
 b=aOCvoxHKuVPYpTgTVHheS2bS6Jp+GCgL45ZRS+m7Pl1Gc0EbvdYAPuYQVV4PkwyJevPJyjf8AAwKLQG00jzqUphOKhQ6FVUDbQ1AApVlI2OC9U/UZqLrFpbwHoYsgRx6BJyGnBKVun5evDlf/J95GdbIeWTtaVOOLzPCEnOmlROdzIHTlfsZm+ptgqF9CHBCtf0meivKz6GWXJjHOx0PzFYBCjGp9n2Qp7BPGjr8cyLeQY1gVlcPOgc+/AaOGArBjmkoSqm0cdv5yjYB4zIawaO+Ioin9x+DEuhr/IteNKpit6PeX2u4tQn+oWYoapi+AKXRzr+alWmHnF0Skyvzpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 SJ2PR11MB7672.namprd11.prod.outlook.com (2603:10b6:a03:4cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 09:44:19 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%5]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 09:44:19 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org, joe@deserted.net,
        joe.macdonald@siemens.com
Subject: [meta-selinux][PATCH 3/3] refpolicy: update to 20250213+git
Date: Thu, 20 Feb 2025 17:43:45 +0800
Message-Id: <20250220094345.1119650-3-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250220094345.1119650-1-yi.zhao@windriver.com>
References: <20250220094345.1119650-1-yi.zhao@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0054.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::23)
 To DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|SJ2PR11MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 50039d2b-cd8f-46ea-b5a6-08dd519325be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Acj/auZmQJTUDuFGJe/bGg65okV2KPT2ZmzczXYQTOTR1VCCchgkXWvwCQ5a?=
 =?us-ascii?Q?2neCLEsoJrmX0BjR6MivaY1pX55bbrmm2jW3etCZCbc6mkG5iwKjsOfGNI53?=
 =?us-ascii?Q?2pYspSUvkG1T6z4O5F9uJhfKHr5+7L/yvpHJxAUgrwafjkICO13hbp+5Sh9F?=
 =?us-ascii?Q?zaZxYywbyZ6ElYZ0otNV8FEAmo4vZViN1cBHg8sSEddoNBWYi+kLz3dxCsOR?=
 =?us-ascii?Q?mZVDc+pa+frTtY/y9M+4HhwhQmq/EVuu/Sw7GheqKGFMXNC2i0NvCrrmPDb4?=
 =?us-ascii?Q?if0Q65pQJVb+ojjx2tEGroXqBjAGyS8toE7QzhKBi62iWOk4YeKLlyEXTcyX?=
 =?us-ascii?Q?PecLK8q8tKtI7ANUHegMbo0NK1s3SxfHP8YIvRBZdUKwIivZQy3eGEWf3uqs?=
 =?us-ascii?Q?L8ZLM7RY6wS33YrC2KflEGbmlWGcQ9E9EYQCBCgCtFLQn/gWXhJSs2lfv9ah?=
 =?us-ascii?Q?9SunofEw7276I9mbhy46axMgdxsMT6Sx7WGx8hapsun6X4RTRZY4Z1+BkbHH?=
 =?us-ascii?Q?5bxQoyYE5XnZqC731Dq6cttzrM3IxF8TI9CXyalb6hAHZasUjIsyIKcY9/Fu?=
 =?us-ascii?Q?yYZ5d5Rkbz/Apx8F975QKJuD//mDx+kdm9WjEqfgBxcKGlU/GmklGFs+/fu2?=
 =?us-ascii?Q?zHL1ZTGABbiEZZ8cL/GzmSLmaxI45kapJQHmkM0bakbRkNuPCTihfHhzcuVP?=
 =?us-ascii?Q?YLiOo+zxc74uNLpCRAvpcmEs2W8Etb1T0HJC5B6QXw+GV1mBwddh/WG/wOcK?=
 =?us-ascii?Q?PJhVUHpbpm7AIKq2aORlnxYG4Q44x/3eIatpLu6rQcvkKXMT0ulAUvp29FA/?=
 =?us-ascii?Q?j74MdcYxJeufeWro1dNrkS+gxORSX19+/P16/FJ0NEQX+Y2AiNz/0ihJkiQl?=
 =?us-ascii?Q?ZTYXYvNAyVo2WZVK8EVmCMvzxAbB9T15KpNcnYKmJFan8yty87jX1/Q5e6uG?=
 =?us-ascii?Q?D009IMWjOjTjbAhYbCupNmYj5/o3z7zy2kz0H/O2y0E1n3g3rc1XU9TSwvr+?=
 =?us-ascii?Q?QzStSqYurLGfhi5/G3wuwBnpvr2Wa1n0SgpL/X1nBPOmX5HS86iQ/XsA3YTV?=
 =?us-ascii?Q?r1d21woPJtKFarnkHadZFem1BKrKGD/L5KM0dR1540F2UTCT+L1V+Aaaj/hJ?=
 =?us-ascii?Q?UxdVDdx7riY1LLUYB/pJ9ajRKBL8E4bHyWpmFAgstbVfNfxW3w/OdaQb+BIC?=
 =?us-ascii?Q?AeHv3Z4bNgUjgot4l/Mts1PS/dkvlvH8srRe21RpnWjMUWp3lCEB6KSEh75u?=
 =?us-ascii?Q?39a6bLfCZOkQl6mvERu385ImmTb3wnfXh26VKJO+NNoOaf0prKfAxj9gCP1W?=
 =?us-ascii?Q?aaKIz1tddqKE6/T3I2FkxFcOn+9SgFvRXcGG5DqWDOUpWbmWU/yf5u5+z0/T?=
 =?us-ascii?Q?5Lln9vUvb/4IuH9Pt7eBXUFR4iIGFq6UVTFFEPcuTbxBKEvvw9NHzOY1Bpfc?=
 =?us-ascii?Q?nUW5PpfvamHNBWbuzEc8mYlyRM+btdmA?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XuSWBDD3UwRkGPeFhFJx41VQ99sfUEOuxoUb47tPjD1DfakiKW+IwIjFRmxS?=
 =?us-ascii?Q?UlQrPsXOkixDpGcAAQQuYpH/O0MaqXtZ4+Bq+7sBbb7blY1mxIA4+DAVuult?=
 =?us-ascii?Q?o77xcFRg3VyYX1/z1t0EXz7yx8ZOoDvg6fMAavEgjShT4NPUi65OSyZA9Bsq?=
 =?us-ascii?Q?WmzaGeq/89/R1ZwHpLrwGgyzk+kxG2DYjYGJZd2Wqf7M1PCZpA4zbHz6lqzI?=
 =?us-ascii?Q?TDjlBJBC9QrEqmOmlReGbSc1w3hsIpSBqBUbLGi19/gFz+QL5VXWZ0l/r+fg?=
 =?us-ascii?Q?szmIlka39VI/TXi2kA6agjtdjsi0eKjuFkC02HCGD0pDb5/U/S/AHTmJeqwr?=
 =?us-ascii?Q?QErxKvhX+bQ6z6X8C4pixGkwahxIIxm/gY1ArQoxXzrN/p6Q7L9A0Zh9GaiA?=
 =?us-ascii?Q?bE4pMgQotob9j/IvWivovdFHrbHtgVeXQ8bCDOag02Kc+K+OujZCUHqRwfIc?=
 =?us-ascii?Q?u/NsfamE3RZ81agwZ2IoyBXtgx4dsYAItAi6r1doYK5/DqNxp8RHcnkfVXZl?=
 =?us-ascii?Q?IwXcRXhA/mNOzsyERMLVJtSE3vrpavRkd7t1M1MAmnwmaVXgItZn/mGP7/Vg?=
 =?us-ascii?Q?mrNha1q/INbEqnLk4rwByFUhJqp6DVHGQZ/uKr4zi7Q7RPTp55S4BXLK3UgK?=
 =?us-ascii?Q?SuF0WNjTxhCv70br1f0KBhiRAD4CG26l+ETC+eq2DrJdW1CmecZWivWaiggg?=
 =?us-ascii?Q?Z+g4sIUuiH3hR2RNQjN2hFeAumiJ/4Wm5tVQcL8bk0T7mYN8dxdfiHHdk/gM?=
 =?us-ascii?Q?mTHgd2mPjuphWasmjRc3GaEVKT7prodB2m8FziNMhGTl98IHHrRF64ANYhJZ?=
 =?us-ascii?Q?NIJZuU+vgpp6PXwG2AH6F0Ur7wzkxufR6QzuOM/g8VJOq2/6mjFkECNk8E20?=
 =?us-ascii?Q?GBqq1vD8+KR5qcVRx0T+s44MW6jBYsBoQcjZvb6rAuSjSQ4E6eGLoDYZT1PV?=
 =?us-ascii?Q?eZPTuAcPohOOnjXo3mz5b2UUKALXpbZUGRRNoo4VUeBnP8v+ga3tycOrt6Fx?=
 =?us-ascii?Q?Lb7d5XphLvkqWScVQLfIGV38hKwl1LY1+rbV6dAKZZakqLANKl2878EicZ8a?=
 =?us-ascii?Q?50DR0636W+/ncwf+FxdDXY5mdB2XRPFhc+72HZysQjsq/LLsmYv0Q3wyOFFZ?=
 =?us-ascii?Q?MZGH8tpyRKcOx02Py66udRyo4prdzzO7Ilng5NsjA2tDYO7M85GG/Ii+Q51J?=
 =?us-ascii?Q?VoPM7X5upDibEsYOHhjQvSRUNpgLNh1hKmDcvZydpE82zC/PEwNMNhzZCcBe?=
 =?us-ascii?Q?BA8gAPTJmvFbvkf0FG0cpgwplIO7Toyu/8gNEGF5yTIQk5cFY1/YOkzVhVdY?=
 =?us-ascii?Q?/k0aaURNV1UStPv8tPDRAod0ipINwBs8wlM82oA9WvX8AhvCfIOA/1lmqN2j?=
 =?us-ascii?Q?H7wV7WgSx3FEU3al9rhgRnGZDVZGDxfKNz9wedRpZFNdg1yY/d/Hp3d0x3Uq?=
 =?us-ascii?Q?mtS6VbseVFsc6b/XaQMzfXQU7OophQk2DSZ8yOYETTDrqCfKDe+ok3hhs4ai?=
 =?us-ascii?Q?RSkG9P4Z2PFj3Jolo2SDR7ihn3rz3qL7rbxbLd8IuugN1vLniNNBzIwJJl4F?=
 =?us-ascii?Q?1Z61L33cGYDTw6ztEi1uMJ2p5NaY0A7QBy80dv51?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50039d2b-cd8f-46ea-b5a6-08dd519325be
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 09:44:19.5579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4NDM9DdB8dHs0Fcac0zFkaxzHKkFNc3DjjRfYhPZ0RYpwNJDOhEc5+VBPuXQZnLWnwtv0eQvtsOrtJSvSOHPxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7672
X-Proofpoint-GUID: 0gm-hSrhqDMDDWm3_9yOw6g3wzKx9n4a
X-Proofpoint-ORIG-GUID: 0gm-hSrhqDMDDWm3_9yOw6g3wzKx9n4a
X-Authority-Analysis: v=2.4 cv=BvtnwZX5 c=1 sm=1 tr=0 ts=67b6f976 cx=c_pps a=F7QtyTBSWJEVkVFduP+sHw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10 a=NEAV23lmAAAA:8 a=20KFwNOVAAAA:8
 a=t7CeM3EgAAAA:8 a=9Wbp7B8dAAAA:8 a=Mq066dflDpQVVfVOwSgA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=BESxJfN36ujmTJQqZ0Zq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 impostorscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2502200071
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Feb 2025 09:44:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1099

ChangeLog:
https://github.com/SELinuxProject/refpolicy/releases/tag/RELEASE_2_20250213

* Add tool for validating appconfig contexts files.
* Add netlink extended permissions definitions.
* Updates for Systemd up to v257.

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../refpolicy/refpolicy-minimum_git.bb        |   2 +-
 .../refpolicy/refpolicy-targeted_git.bb       |   3 +-
 ...tile-alias-common-var-volatile-paths.patch |   2 +-
 ...inimum-make-sysadmin-module-optional.patch |  10 +-
 ...e-unconfined_u-definition-to-unconfi.patch |  83 ++++++++++++++
 ...box-set-aliases-for-bin-sbin-and-usr.patch |   2 +-
 ...-allow-systemd-networkd-to-accept-a.patch} |  32 +++---
 ...d-make-unconfined_u-the-default-sel.patch} |   2 +-
 ...y-policy-to-common-yocto-hostname-al.patch |   2 +-
 ...sr-bin-bash-context-to-bin-bash.bash.patch |   4 +-
 ...abel-resolv.conf-in-var-run-properly.patch |   2 +-
 ...-apply-login-context-to-login.shadow.patch |   4 +-
 ...-fc-hwclock-add-hwclock-alternatives.patch |   2 +-
 ...g-apply-policy-to-dmesg-alternatives.patch |   2 +-
 ...ssh-apply-policy-to-ssh-alternatives.patch |   4 +-
 ...ply-policy-to-network-commands-alter.patch |   2 +-
 ...ply-rpm_exec-policy-to-cpio-binaries.patch |   2 +-
 ...c-su-apply-policy-to-su-alternatives.patch |   2 +-
 ...fc-fstools-fix-real-path-for-fstools.patch |  14 +--
 ...fix-update-alternatives-for-sysvinit.patch |   4 +-
 ...l-apply-policy-to-brctl-alternatives.patch |   2 +-
 ...apply-policy-to-nologin-alternatives.patch |   6 +-
 ...apply-policy-to-sulogin-alternatives.patch |   2 +-
 ...tp-apply-policy-to-ntpd-alternatives.patch |   2 +-
 ...pply-policy-to-kerberos-alternatives.patch |   2 +-
 ...ap-apply-policy-to-ldap-alternatives.patch |   2 +-
 ...ply-policy-to-postgresql-alternative.patch |   2 +-
 ...-apply-policy-to-screen-alternatives.patch |   2 +-
 ...ply-policy-to-usermanage-alternative.patch |   2 +-
 ...etty-add-file-context-to-start_getty.patch |   2 +-
 ...k-apply-policy-to-vlock-alternatives.patch |   2 +-
 ...for-init-scripts-and-systemd-service.patch |   8 +-
 ...bs_dist-set-aliase-for-root-director.patch |   2 +-
 ...ystem-logging-add-rules-for-the-syml.patch |   2 +-
 ...ystem-logging-add-rules-for-syslogd-.patch |   4 +-
 ...ernel-files-add-rules-for-the-symlin.patch |  20 ++--
 ...ystem-logging-fix-auditd-startup-fai.patch |   4 +-
 ...ernel-terminal-don-t-audit-tty_devic.patch |   2 +-
 ...ystem-systemd-enable-support-for-sys.patch |   4 +-
 ...ystem-logging-allow-systemd-tmpfiles.patch |   4 +-
 ...les-sysadm-allow-sysadm-to-use-init.patch} |   4 +-
 ...ystem-systemd-allow-systemd_logind_t.patch |  43 -------
 ...s-system-systemd-systemd-user-fixes.patch} |   8 +-
 ...stem-logging-grant-getpcap-capabili.patch} |   4 +-
 ...stem-allow-services-to-read-tmpfs-u.patch} |  10 +-
 ...rnel-domain-allow-all-domains-to-co.patch} |   2 +-
 ...-allow-systemd-logind-to-inherit-fds.patch |  68 +++++++++++
 ...stemd-tmpfiles-to-read-bin_t-symlink.patch | 107 ++++++++++++++++++
 ...stem-mount-make-mount_t-domain-MLS-.patch} |   6 +-
 ...les-sysadm-MLS-sysadm-rw-to-clearan.patch} |   4 +-
 ...rvices-rpc-make-nfsd_t-domain-MLS-t.patch} |   6 +-
 ...min-dmesg-make-dmesg_t-MLS-trusted-.patch} |   2 +-
 ...rnel-kernel-make-kernel_t-MLS-trust.patch} |   6 +-
 ...stem-init-make-init_t-MLS-trusted-f.patch} |   6 +-
 ...stem-systemd-make-systemd-tmpfiles_.patch} |   6 +-
 ...stem-systemd-systemd-make-systemd_-.patch} |  14 +--
 ...stem-logging-add-the-syslogd_t-to-t.patch} |   4 +-
 ...stem-init-make-init_t-MLS-trusted-f.patch} |   6 +-
 ...stem-init-all-init_t-to-read-any-le.patch} |   6 +-
 ...stem-logging-allow-auditd_t-to-writ.patch} |   4 +-
 ...rnel-kernel-make-kernel_t-MLS-trust.patch} |   6 +-
 ...stem-setrans-allow-setrans_t-use-fd.patch} |   2 +-
 ...stem-systemd-make-_systemd_t-MLS-tr.patch} |   6 +-
 ...stem-logging-make-syslogd_runtime_t.patch} |   4 +-
 .../refpolicy/refpolicy_common.inc            |  45 ++++----
 recipes-security/refpolicy/refpolicy_git.inc  |   4 +-
 66 files changed, 428 insertions(+), 211 deletions(-)
 create mode 100644 recipes-security/refpolicy/refpolicy/0001-refpolicy-targeted-Revert-users-Move-unconfined_u-definition-to-unconfi.patch
 rename recipes-security/refpolicy/refpolicy/{0002-refpolicy-minimum-enable-nscd_use_shm.patch => 0002-refpolicy-minimum-allow-systemd-networkd-to-accept-a.patch} (49%)
 rename recipes-security/refpolicy/refpolicy/{0001-refpolicy-targeted-make-unconfined_u-the-default-sel.patch => 0002-refpolicy-targeted-make-unconfined_u-the-default-sel.patch} (98%)
 rename recipes-security/refpolicy/refpolicy/{0036-policy-modules-roles-sysadm-allow-sysadm-to-use-init.patch => 0035-policy-modules-roles-sysadm-allow-sysadm-to-use-init.patch} (91%)
 delete mode 100644 recipes-security/refpolicy/refpolicy/0035-policy-modules-system-systemd-allow-systemd_logind_t.patch
 rename recipes-security/refpolicy/refpolicy/{0037-policy-modules-system-systemd-systemd-user-fixes.patch => 0036-policy-modules-system-systemd-systemd-user-fixes.patch} (93%)
 rename recipes-security/refpolicy/refpolicy/{0038-policy-modules-system-logging-grant-getpcap-capabili.patch => 0037-policy-modules-system-logging-grant-getpcap-capabili.patch} (92%)
 rename recipes-security/refpolicy/refpolicy/{0039-policy-modules-system-allow-services-to-read-tmpfs-u.patch => 0038-policy-modules-system-allow-services-to-read-tmpfs-u.patch} (95%)
 rename recipes-security/refpolicy/refpolicy/{0040-policy-modules-kernel-domain-allow-all-domains-to-co.patch => 0039-policy-modules-kernel-domain-allow-all-domains-to-co.patch} (95%)
 create mode 100644 recipes-security/refpolicy/refpolicy/0040-systemd-allow-systemd-logind-to-inherit-fds.patch
 create mode 100644 recipes-security/refpolicy/refpolicy/0041-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch
 rename recipes-security/refpolicy/refpolicy/{0041-policy-modules-system-mount-make-mount_t-domain-MLS-.patch => 0042-policy-modules-system-mount-make-mount_t-domain-MLS-.patch} (85%)
 rename recipes-security/refpolicy/refpolicy/{0042-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch => 0043-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch} (92%)
 rename recipes-security/refpolicy/refpolicy/{0043-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch => 0044-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch} (90%)
 rename recipes-security/refpolicy/refpolicy/{0044-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch => 0045-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch} (94%)
 rename recipes-security/refpolicy/refpolicy/{0045-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch => 0046-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch} (95%)
 rename recipes-security/refpolicy/refpolicy/{0046-policy-modules-system-init-make-init_t-MLS-trusted-f.patch => 0047-policy-modules-system-init-make-init_t-MLS-trusted-f.patch} (90%)
 rename recipes-security/refpolicy/refpolicy/{0047-policy-modules-system-systemd-make-systemd-tmpfiles_.patch => 0048-policy-modules-system-systemd-make-systemd-tmpfiles_.patch} (92%)
 rename recipes-security/refpolicy/refpolicy/{0048-policy-modules-system-systemd-systemd-make-systemd_-.patch => 0049-policy-modules-system-systemd-systemd-make-systemd_-.patch} (88%)
 rename recipes-security/refpolicy/refpolicy/{0049-policy-modules-system-logging-add-the-syslogd_t-to-t.patch => 0050-policy-modules-system-logging-add-the-syslogd_t-to-t.patch} (92%)
 rename recipes-security/refpolicy/refpolicy/{0050-policy-modules-system-init-make-init_t-MLS-trusted-f.patch => 0051-policy-modules-system-init-make-init_t-MLS-trusted-f.patch} (86%)
 rename recipes-security/refpolicy/refpolicy/{0051-policy-modules-system-init-all-init_t-to-read-any-le.patch => 0052-policy-modules-system-init-all-init_t-to-read-any-le.patch} (88%)
 rename recipes-security/refpolicy/refpolicy/{0052-policy-modules-system-logging-allow-auditd_t-to-writ.patch => 0053-policy-modules-system-logging-allow-auditd_t-to-writ.patch} (92%)
 rename recipes-security/refpolicy/refpolicy/{0053-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch => 0054-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch} (84%)
 rename recipes-security/refpolicy/refpolicy/{0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch => 0055-policy-modules-system-setrans-allow-setrans_t-use-fd.patch} (93%)
 rename recipes-security/refpolicy/refpolicy/{0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch => 0056-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch} (88%)
 rename recipes-security/refpolicy/refpolicy/{0056-policy-modules-system-logging-make-syslogd_runtime_t.patch => 0057-policy-modules-system-logging-make-syslogd_runtime_t.patch} (94%)

diff --git a/recipes-security/refpolicy/refpolicy-minimum_git.bb b/recipes-security/refpolicy/refpolicy-minimum_git.bb
index 233c851..7b75d26 100644
--- a/recipes-security/refpolicy/refpolicy-minimum_git.bb
+++ b/recipes-security/refpolicy/refpolicy-minimum_git.bb
@@ -13,7 +13,7 @@ domains are unconfined. \
 
 SRC_URI += " \
         file://0001-refpolicy-minimum-make-sysadmin-module-optional.patch \
-        file://0002-refpolicy-minimum-enable-nscd_use_shm.patch \
+        file://0002-refpolicy-minimum-allow-systemd-networkd-to-accept-a.patch \
         "
 
 POLICY_NAME = "minimum"
diff --git a/recipes-security/refpolicy/refpolicy-targeted_git.bb b/recipes-security/refpolicy/refpolicy-targeted_git.bb
index de81d46..321407d 100644
--- a/recipes-security/refpolicy/refpolicy-targeted_git.bb
+++ b/recipes-security/refpolicy/refpolicy-targeted_git.bb
@@ -13,5 +13,6 @@ POLICY_MLS_SENS = "0"
 include refpolicy_${PV}.inc
 
 SRC_URI += " \
-        file://0001-refpolicy-targeted-make-unconfined_u-the-default-sel.patch \
+        file://0001-refpolicy-targeted-Revert-users-Move-unconfined_u-definition-to-unconfi.patch \
+        file://0002-refpolicy-targeted-make-unconfined_u-the-default-sel.patch \
         "
diff --git a/recipes-security/refpolicy/refpolicy/0001-fc-subs-volatile-alias-common-var-volatile-paths.patch b/recipes-security/refpolicy/refpolicy/0001-fc-subs-volatile-alias-common-var-volatile-paths.patch
index 45686b2..87febdc 100644
--- a/recipes-security/refpolicy/refpolicy/0001-fc-subs-volatile-alias-common-var-volatile-paths.patch
+++ b/recipes-security/refpolicy/refpolicy/0001-fc-subs-volatile-alias-common-var-volatile-paths.patch
@@ -1,4 +1,4 @@
-From 2627c403bb84d710a2469e501e6a0ccf5c7fb438 Mon Sep 17 00:00:00 2001
+From c36ccb73201949df2e4e01dc12e36c77bc42e099 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 16:14:09 -0400
 Subject: [PATCH] fc/subs/volatile: alias common /var/volatile paths
diff --git a/recipes-security/refpolicy/refpolicy/0001-refpolicy-minimum-make-sysadmin-module-optional.patch b/recipes-security/refpolicy/refpolicy/0001-refpolicy-minimum-make-sysadmin-module-optional.patch
index 73e6b48..b0c0556 100644
--- a/recipes-security/refpolicy/refpolicy/0001-refpolicy-minimum-make-sysadmin-module-optional.patch
+++ b/recipes-security/refpolicy/refpolicy/0001-refpolicy-minimum-make-sysadmin-module-optional.patch
@@ -1,4 +1,4 @@
-From 923dec0f0231024680bb6f7d48ff7edf82ed8082 Mon Sep 17 00:00:00 2001
+From 4a5d6d9b7c317a2b819ef9a0ebce2e913ad42be9 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 5 Apr 2019 11:53:28 -0400
 Subject: [PATCH] refpolicy-minimum: make sysadmin module optional
@@ -22,10 +22,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  2 files changed, 11 insertions(+), 7 deletions(-)
 
 diff --git a/policy/modules/system/init.te b/policy/modules/system/init.te
-index 8af34aa7e..fdd64fb5b 100644
+index 7df44cead..65146974b 100644
 --- a/policy/modules/system/init.te
 +++ b/policy/modules/system/init.te
-@@ -653,13 +653,15 @@ ifdef(`init_systemd',`
+@@ -648,13 +648,15 @@ ifdef(`init_systemd',`
  		unconfined_write_keys(init_t)
  	')
  ',`
@@ -48,10 +48,10 @@ index 8af34aa7e..fdd64fb5b 100644
  	')
  ')
 diff --git a/policy/modules/system/locallogin.te b/policy/modules/system/locallogin.te
-index 4ba131d29..9c4b0a1d8 100644
+index f96092070..db28ce41c 100644
 --- a/policy/modules/system/locallogin.te
 +++ b/policy/modules/system/locallogin.te
-@@ -277,7 +277,9 @@ userdom_use_unpriv_users_fds(sulogin_t)
+@@ -279,7 +279,9 @@ userdom_use_unpriv_users_fds(sulogin_t)
  userdom_search_user_home_dirs(sulogin_t)
  userdom_use_user_ptys(sulogin_t)
  
diff --git a/recipes-security/refpolicy/refpolicy/0001-refpolicy-targeted-Revert-users-Move-unconfined_u-definition-to-unconfi.patch b/recipes-security/refpolicy/refpolicy/0001-refpolicy-targeted-Revert-users-Move-unconfined_u-definition-to-unconfi.patch
new file mode 100644
index 0000000..6907b19
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0001-refpolicy-targeted-Revert-users-Move-unconfined_u-definition-to-unconfi.patch
@@ -0,0 +1,83 @@
+From b14a64cd3a83e0c3741446cb5bca4773f7db5e6d Mon Sep 17 00:00:00 2001
+From: Yi Zhao <yi.zhao@windriver.com>
+Date: Wed, 19 Feb 2025 21:35:02 +0800
+Subject: [PATCH] Revert "users: Move unconfined_u definition to unconfined
+ module."
+
+This reverts commit ca3698d543c22dbc78c4c491133405754a9f8a3f.
+
+Fix build error for targeted policy.
+
+Upstream-Status: Inappropriate [embedded specific]
+
+Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
+---
+ policy/modules/kernel/kernel.te     |  3 +++
+ policy/modules/system/unconfined.te | 14 --------------
+ policy/users                        |  7 +++++++
+ 3 files changed, 10 insertions(+), 14 deletions(-)
+
+diff --git a/policy/modules/kernel/kernel.te b/policy/modules/kernel/kernel.te
+index 987709345..2dc5c3895 100644
+--- a/policy/modules/kernel/kernel.te
++++ b/policy/modules/kernel/kernel.te
+@@ -33,6 +33,9 @@ role sysadm_r;
+ role staff_r;
+ role user_r;
+ 
++# here until order dependence is fixed:
++role unconfined_r;
++
+ ifdef(`enable_mls',`
+ 	role secadm_r;
+ 	role auditadm_r;
+diff --git a/policy/modules/system/unconfined.te b/policy/modules/system/unconfined.te
+index 6dc1d9484..68b78ff24 100644
+--- a/policy/modules/system/unconfined.te
++++ b/policy/modules/system/unconfined.te
+@@ -8,9 +8,6 @@ policy_module(unconfined)
+ # usage in this module of types created by these
+ # calls is not correct, however we dont currently
+ # have another method to add access to these types
+-
+-role unconfined_r;
+-
+ userdom_base_user_template(unconfined)
+ userdom_manage_home_role(unconfined_r, unconfined_t)
+ userdom_manage_tmp_role(unconfined_r, unconfined_t)
+@@ -253,14 +250,3 @@ unconfined_domain_noaudit(unconfined_execmem_t)
+ optional_policy(`
+ 	unconfined_dbus_chat(unconfined_execmem_t)
+ ')
+-
+-########################################
+-#
+-# Unconfined seuser
+-#
+-
+-ifdef(`direct_sysadm_daemon',`
+-        gen_user(unconfined_u, unconfined, unconfined_r system_r, s0, s0 - mls_systemhigh, mcs_allcats)
+-',`
+-        gen_user(unconfined_u, unconfined, unconfined_r, s0, s0 - mls_systemhigh, mcs_allcats)
+-')
+diff --git a/policy/users b/policy/users
+index 25402afd8..ca203758c 100644
+--- a/policy/users
++++ b/policy/users
+@@ -28,6 +28,13 @@ gen_user(user_u, user, user_r, s0, s0)
+ gen_user(staff_u, staff, staff_r sysadm_r ifdef(`enable_mls',`secadm_r auditadm_r'), s0, s0 - mls_systemhigh, mcs_allcats)
+ gen_user(sysadm_u, sysadm, sysadm_r, s0, s0 - mls_systemhigh, mcs_allcats)
+ 
++# Until order dependence is fixed for users:
++ifdef(`direct_sysadm_daemon',`
++        gen_user(unconfined_u, unconfined, unconfined_r system_r, s0, s0 - mls_systemhigh, mcs_allcats)
++',`
++        gen_user(unconfined_u, unconfined, unconfined_r, s0, s0 - mls_systemhigh, mcs_allcats)
++')
++
+ #
+ # The following users correspond to Unix identities.
+ # These identities are typically assigned as the user attribute
+-- 
+2.25.1
+
diff --git a/recipes-security/refpolicy/refpolicy/0002-fc-subs-busybox-set-aliases-for-bin-sbin-and-usr.patch b/recipes-security/refpolicy/refpolicy/0002-fc-subs-busybox-set-aliases-for-bin-sbin-and-usr.patch
index 5815b47..26b1d9c 100644
--- a/recipes-security/refpolicy/refpolicy/0002-fc-subs-busybox-set-aliases-for-bin-sbin-and-usr.patch
+++ b/recipes-security/refpolicy/refpolicy/0002-fc-subs-busybox-set-aliases-for-bin-sbin-and-usr.patch
@@ -1,4 +1,4 @@
-From bd8d0af36d8f6eb0f25c43b94e31e93d4ac7513b Mon Sep 17 00:00:00 2001
+From 1fd50ccbfb7943a4e479af91d308f433f1f0ec8a Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 20:48:10 -0400
 Subject: [PATCH] fc/subs/busybox: set aliases for bin, sbin and usr
diff --git a/recipes-security/refpolicy/refpolicy/0002-refpolicy-minimum-enable-nscd_use_shm.patch b/recipes-security/refpolicy/refpolicy/0002-refpolicy-minimum-allow-systemd-networkd-to-accept-a.patch
similarity index 49%
rename from recipes-security/refpolicy/refpolicy/0002-refpolicy-minimum-enable-nscd_use_shm.patch
rename to recipes-security/refpolicy/refpolicy/0002-refpolicy-minimum-allow-systemd-networkd-to-accept-a.patch
index 72c5374..e4d697c 100644
--- a/recipes-security/refpolicy/refpolicy/0002-refpolicy-minimum-enable-nscd_use_shm.patch
+++ b/recipes-security/refpolicy/refpolicy/0002-refpolicy-minimum-allow-systemd-networkd-to-accept-a.patch
@@ -1,7 +1,8 @@
-From 9494c078e1aea2ab6ecdf0c3ca01e2d3941b11a7 Mon Sep 17 00:00:00 2001
+From 805d55ae146a21575b013e041cec7f97899d39ae Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 26 Feb 2021 09:13:23 +0800
-Subject: [PATCH] refpolicy-minimum: enable nscd_use_shm
+Subject: [PATCH] refpolicy-minimum: allow systemd-networkd to accept and
+ listen socket
 
 Fixes:
 avc:  denied  { listen } for  pid=340 comm="systemd-network"
@@ -26,22 +27,21 @@ Upstream-Status: Inappropriate [embedded specific]
 
 Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
 ---
- policy/modules/services/nscd.te | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
+ policy/modules/system/systemd.te | 1 +
+ 1 file changed, 1 insertion(+)
 
-diff --git a/policy/modules/services/nscd.te b/policy/modules/services/nscd.te
-index ffc60497c..d226f1145 100644
---- a/policy/modules/services/nscd.te
-+++ b/policy/modules/services/nscd.te
-@@ -15,7 +15,7 @@ gen_require(`
- ##	can use nscd shared memory.
- ##	</p>
- ## </desc>
--gen_tunable(nscd_use_shm, false)
-+gen_tunable(nscd_use_shm, true)
- 
- attribute_role nscd_roles;
+diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
+index 45d4db784..af0e05e9d 100644
+--- a/policy/modules/system/systemd.te
++++ b/policy/modules/system/systemd.te
+@@ -1305,6 +1305,7 @@ allow systemd_networkd_t self:rawip_socket create_socket_perms;
+ allow systemd_networkd_t self:tun_socket { create_socket_perms relabelfrom relabelto };
+ allow systemd_networkd_t self:udp_socket create_socket_perms;
+ allow systemd_networkd_t self:unix_dgram_socket create_socket_perms;
++allow systemd_networkd_t self:unix_stream_socket { accept listen };
  
+ manage_dirs_pattern(systemd_networkd_t, systemd_networkd_runtime_t, systemd_networkd_runtime_t)
+ manage_files_pattern(systemd_networkd_t, systemd_networkd_runtime_t, systemd_networkd_runtime_t)
 -- 
 2.25.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0001-refpolicy-targeted-make-unconfined_u-the-default-sel.patch b/recipes-security/refpolicy/refpolicy/0002-refpolicy-targeted-make-unconfined_u-the-default-sel.patch
similarity index 98%
rename from recipes-security/refpolicy/refpolicy/0001-refpolicy-targeted-make-unconfined_u-the-default-sel.patch
rename to recipes-security/refpolicy/refpolicy/0002-refpolicy-targeted-make-unconfined_u-the-default-sel.patch
index ba472d7..57eb976 100644
--- a/recipes-security/refpolicy/refpolicy/0001-refpolicy-targeted-make-unconfined_u-the-default-sel.patch
+++ b/recipes-security/refpolicy/refpolicy/0002-refpolicy-targeted-make-unconfined_u-the-default-sel.patch
@@ -1,4 +1,4 @@
-From 38cac8a2f2ec94bbc9b6d04ffcc35b7459c05b11 Mon Sep 17 00:00:00 2001
+From 0b299c6f8950cbba592a366e93f9ecb0605ffe9a Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Mon, 20 Apr 2020 11:50:03 +0800
 Subject: [PATCH] refpolicy-targeted: make unconfined_u the default selinux
diff --git a/recipes-security/refpolicy/refpolicy/0003-fc-hostname-apply-policy-to-common-yocto-hostname-al.patch b/recipes-security/refpolicy/refpolicy/0003-fc-hostname-apply-policy-to-common-yocto-hostname-al.patch
index 6e82aee..e2dd9e0 100644
--- a/recipes-security/refpolicy/refpolicy/0003-fc-hostname-apply-policy-to-common-yocto-hostname-al.patch
+++ b/recipes-security/refpolicy/refpolicy/0003-fc-hostname-apply-policy-to-common-yocto-hostname-al.patch
@@ -1,4 +1,4 @@
-From b8ec557e6aa310c65d9183ae741e649eae1c3619 Mon Sep 17 00:00:00 2001
+From db25a33d356c7c273c1bcee33bd1f5df80bf29b0 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] fc/hostname: apply policy to common yocto hostname
diff --git a/recipes-security/refpolicy/refpolicy/0004-fc-bash-apply-usr-bin-bash-context-to-bin-bash.bash.patch b/recipes-security/refpolicy/refpolicy/0004-fc-bash-apply-usr-bin-bash-context-to-bin-bash.bash.patch
index 27f2ea8..f5a012f 100644
--- a/recipes-security/refpolicy/refpolicy/0004-fc-bash-apply-usr-bin-bash-context-to-bin-bash.bash.patch
+++ b/recipes-security/refpolicy/refpolicy/0004-fc-bash-apply-usr-bin-bash-context-to-bin-bash.bash.patch
@@ -1,4 +1,4 @@
-From ddba777d85a78cb372a84f4ff003888e1ba06afa Mon Sep 17 00:00:00 2001
+From 2016c05b60f0d81294ccccc4242e03d4143b843e Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 21:37:32 -0400
 Subject: [PATCH] fc/bash: apply /usr/bin/bash context to /bin/bash.bash
@@ -15,7 +15,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/kernel/corecommands.fc b/policy/modules/kernel/corecommands.fc
-index 04d6caa80..7d2efef0a 100644
+index 9ac701579..b1163fdbb 100644
 --- a/policy/modules/kernel/corecommands.fc
 +++ b/policy/modules/kernel/corecommands.fc
 @@ -147,6 +147,7 @@ ifdef(`distro_gentoo',`
diff --git a/recipes-security/refpolicy/refpolicy/0005-fc-resolv.conf-label-resolv.conf-in-var-run-properly.patch b/recipes-security/refpolicy/refpolicy/0005-fc-resolv.conf-label-resolv.conf-in-var-run-properly.patch
index 3c5f5ae..f039ebe 100644
--- a/recipes-security/refpolicy/refpolicy/0005-fc-resolv.conf-label-resolv.conf-in-var-run-properly.patch
+++ b/recipes-security/refpolicy/refpolicy/0005-fc-resolv.conf-label-resolv.conf-in-var-run-properly.patch
@@ -1,4 +1,4 @@
-From 3f24037dd9c0c468d4182d6b047a9baa2469726a Mon Sep 17 00:00:00 2001
+From e2a5ddc7235c9cf248a9d860ab8d0d71ec42e7a7 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 4 Apr 2019 10:45:03 -0400
 Subject: [PATCH] fc/resolv.conf: label resolv.conf in var/run/ properly
diff --git a/recipes-security/refpolicy/refpolicy/0006-fc-login-apply-login-context-to-login.shadow.patch b/recipes-security/refpolicy/refpolicy/0006-fc-login-apply-login-context-to-login.shadow.patch
index 53bb1e7..346b0db 100644
--- a/recipes-security/refpolicy/refpolicy/0006-fc-login-apply-login-context-to-login.shadow.patch
+++ b/recipes-security/refpolicy/refpolicy/0006-fc-login-apply-login-context-to-login.shadow.patch
@@ -1,4 +1,4 @@
-From b318d4d8feb1a021e63d38ac2bea4abe834c4e3b Mon Sep 17 00:00:00 2001
+From 59b9c22802488a693d40e7570536cca89bdc58ee Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 21:43:53 -0400
 Subject: [PATCH] fc/login: apply login context to login.shadow
@@ -12,7 +12,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/authlogin.fc b/policy/modules/system/authlogin.fc
-index fcdd38d6d..c7e7b64a9 100644
+index eca178a2e..ddf5ecec2 100644
 --- a/policy/modules/system/authlogin.fc
 +++ b/policy/modules/system/authlogin.fc
 @@ -8,6 +8,7 @@
diff --git a/recipes-security/refpolicy/refpolicy/0007-fc-hwclock-add-hwclock-alternatives.patch b/recipes-security/refpolicy/refpolicy/0007-fc-hwclock-add-hwclock-alternatives.patch
index c6e4662..d8c8489 100644
--- a/recipes-security/refpolicy/refpolicy/0007-fc-hwclock-add-hwclock-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0007-fc-hwclock-add-hwclock-alternatives.patch
@@ -1,4 +1,4 @@
-From 78e157da0424e06347030577dcdd00f3e6c085ef Mon Sep 17 00:00:00 2001
+From 9a551208b7e1ebd451115ea36cde1536f34f3866 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 21:59:18 -0400
 Subject: [PATCH] fc/hwclock: add hwclock alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0008-fc-dmesg-apply-policy-to-dmesg-alternatives.patch b/recipes-security/refpolicy/refpolicy/0008-fc-dmesg-apply-policy-to-dmesg-alternatives.patch
index 59770e2..8d6b7b2 100644
--- a/recipes-security/refpolicy/refpolicy/0008-fc-dmesg-apply-policy-to-dmesg-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0008-fc-dmesg-apply-policy-to-dmesg-alternatives.patch
@@ -1,4 +1,4 @@
-From d15ee4e3684c52af2caa3af2c24af73ab7ceb677 Mon Sep 17 00:00:00 2001
+From c67674b38368f5d584fd3013f0193b6e6e733a66 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 29 Mar 2019 08:26:55 -0400
 Subject: [PATCH] fc/dmesg: apply policy to dmesg alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0009-fc-ssh-apply-policy-to-ssh-alternatives.patch b/recipes-security/refpolicy/refpolicy/0009-fc-ssh-apply-policy-to-ssh-alternatives.patch
index 84c5b62..4660bca 100644
--- a/recipes-security/refpolicy/refpolicy/0009-fc-ssh-apply-policy-to-ssh-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0009-fc-ssh-apply-policy-to-ssh-alternatives.patch
@@ -1,4 +1,4 @@
-From f287a7b6b9a41963cec1e9bf70eff99e840c9cc3 Mon Sep 17 00:00:00 2001
+From 0493199f682a52c097ae81ac96118295e47bdf90 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 29 Mar 2019 09:20:58 -0400
 Subject: [PATCH] fc/ssh: apply policy to ssh alternatives
@@ -12,7 +12,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/services/ssh.fc b/policy/modules/services/ssh.fc
-index a30d01afc..e033d1a70 100644
+index 93bfa8d26..7b7e567f9 100644
 --- a/policy/modules/services/ssh.fc
 +++ b/policy/modules/services/ssh.fc
 @@ -4,6 +4,7 @@ HOME_DIR/\.ssh(/.*)?			gen_context(system_u:object_r:ssh_home_t,s0)
diff --git a/recipes-security/refpolicy/refpolicy/0010-fc-sysnetwork-apply-policy-to-network-commands-alter.patch b/recipes-security/refpolicy/refpolicy/0010-fc-sysnetwork-apply-policy-to-network-commands-alter.patch
index 08d6a80..7c092ee 100644
--- a/recipes-security/refpolicy/refpolicy/0010-fc-sysnetwork-apply-policy-to-network-commands-alter.patch
+++ b/recipes-security/refpolicy/refpolicy/0010-fc-sysnetwork-apply-policy-to-network-commands-alter.patch
@@ -1,4 +1,4 @@
-From fcfd91661ea05b5967f75927116056924e972214 Mon Sep 17 00:00:00 2001
+From 53c2af24e86b3ab9be5a982958bb0e5c9e8c1360 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Tue, 9 Jun 2015 21:22:52 +0530
 Subject: [PATCH] fc/sysnetwork: apply policy to network commands alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0011-fc-rpm-apply-rpm_exec-policy-to-cpio-binaries.patch b/recipes-security/refpolicy/refpolicy/0011-fc-rpm-apply-rpm_exec-policy-to-cpio-binaries.patch
index 4420b33..f487090 100644
--- a/recipes-security/refpolicy/refpolicy/0011-fc-rpm-apply-rpm_exec-policy-to-cpio-binaries.patch
+++ b/recipes-security/refpolicy/refpolicy/0011-fc-rpm-apply-rpm_exec-policy-to-cpio-binaries.patch
@@ -1,4 +1,4 @@
-From 6e5d4763c0e3e7b2b819694d85710128f4e0ff28 Mon Sep 17 00:00:00 2001
+From 2df4a4620b74973ceafde3732273234de9668fe3 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 29 Mar 2019 09:54:07 -0400
 Subject: [PATCH] fc/rpm: apply rpm_exec policy to cpio binaries
diff --git a/recipes-security/refpolicy/refpolicy/0012-fc-su-apply-policy-to-su-alternatives.patch b/recipes-security/refpolicy/refpolicy/0012-fc-su-apply-policy-to-su-alternatives.patch
index 699fa77..c84de1b 100644
--- a/recipes-security/refpolicy/refpolicy/0012-fc-su-apply-policy-to-su-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0012-fc-su-apply-policy-to-su-alternatives.patch
@@ -1,4 +1,4 @@
-From ca60691cffdf516f3f09cee23874a49d890c9de8 Mon Sep 17 00:00:00 2001
+From 0d026ac95a9da5e345e5b7fbaded216396e12bde Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Thu, 13 Feb 2014 00:33:07 -0500
 Subject: [PATCH] fc/su: apply policy to su alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch b/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch
index 7e56e75..0ef343d 100644
--- a/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch
+++ b/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch
@@ -1,4 +1,4 @@
-From f6a42851e3abe274a733f92f90541de3047e5d74 Mon Sep 17 00:00:00 2001
+From 09de3f9093cde03bf906411403ff43a25290bd6b Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Mon, 27 Jan 2014 03:54:01 -0500
 Subject: [PATCH] fc/fstools: fix real path for fstools
@@ -14,10 +14,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 10 insertions(+)
 
 diff --git a/policy/modules/system/fstools.fc b/policy/modules/system/fstools.fc
-index 63423802d..124109a68 100644
+index 9064ab52e..5962e5736 100644
 --- a/policy/modules/system/fstools.fc
 +++ b/policy/modules/system/fstools.fc
-@@ -58,7 +58,9 @@
+@@ -57,7 +57,9 @@
  /usr/sbin/addpart		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/badblocks		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/blkid			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
@@ -27,8 +27,8 @@ index 63423802d..124109a68 100644
  /usr/sbin/cfdisk		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/clubufflush		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/delpart		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
-@@ -72,10 +74,13 @@
- /usr/sbin/efibootmgr		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+@@ -70,10 +72,13 @@
+ /usr/sbin/e2mmpstatus		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/fatsort		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/fdisk			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
 +/usr/sbin/fdisk\.util-linux			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
@@ -41,7 +41,7 @@ index 63423802d..124109a68 100644
  /usr/sbin/install-mbr		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/jfs_.*		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/losetup.*		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
-@@ -83,13 +88,16 @@
+@@ -81,13 +86,16 @@
  /usr/sbin/make_reiser4		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/mkdosfs		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/mke2fs		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
@@ -58,7 +58,7 @@ index 63423802d..124109a68 100644
  /usr/sbin/partx			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/raidautorun		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/raidstart		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
-@@ -99,8 +107,10 @@
+@@ -97,8 +105,10 @@
  /usr/sbin/sfdisk		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/smartctl		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
  /usr/sbin/swapoff		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
diff --git a/recipes-security/refpolicy/refpolicy/0014-fc-init-fix-update-alternatives-for-sysvinit.patch b/recipes-security/refpolicy/refpolicy/0014-fc-init-fix-update-alternatives-for-sysvinit.patch
index 40e5413..a483165 100644
--- a/recipes-security/refpolicy/refpolicy/0014-fc-init-fix-update-alternatives-for-sysvinit.patch
+++ b/recipes-security/refpolicy/refpolicy/0014-fc-init-fix-update-alternatives-for-sysvinit.patch
@@ -1,4 +1,4 @@
-From eecf36ae218ee0d85fd07a14bfbcb6636ab84095 Mon Sep 17 00:00:00 2001
+From a76963ea8a74c818bd03acae75ae86db59c366e7 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] fc/init: fix update-alternatives for sysvinit
@@ -27,7 +27,7 @@ index 2e47783c2..e359539be 100644
  /run/shutdown\.pid	--	gen_context(system_u:object_r:shutdown_runtime_t,s0)
  
 diff --git a/policy/modules/kernel/corecommands.fc b/policy/modules/kernel/corecommands.fc
-index 7d2efef0a..9a5711a83 100644
+index b1163fdbb..1c2553d21 100644
 --- a/policy/modules/kernel/corecommands.fc
 +++ b/policy/modules/kernel/corecommands.fc
 @@ -156,6 +156,8 @@ ifdef(`distro_gentoo',`
diff --git a/recipes-security/refpolicy/refpolicy/0015-fc-brctl-apply-policy-to-brctl-alternatives.patch b/recipes-security/refpolicy/refpolicy/0015-fc-brctl-apply-policy-to-brctl-alternatives.patch
index fa9e849..855446c 100644
--- a/recipes-security/refpolicy/refpolicy/0015-fc-brctl-apply-policy-to-brctl-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0015-fc-brctl-apply-policy-to-brctl-alternatives.patch
@@ -1,4 +1,4 @@
-From e26d8e3eea2cab884562793221ce9b8c39c614cc Mon Sep 17 00:00:00 2001
+From 19c91699eda904d2c377a29c62bdf6be1ebf59f7 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:19:54 +0800
 Subject: [PATCH] fc/brctl: apply policy to brctl alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0016-fc-corecommands-apply-policy-to-nologin-alternatives.patch b/recipes-security/refpolicy/refpolicy/0016-fc-corecommands-apply-policy-to-nologin-alternatives.patch
index eb49b01..220a9b8 100644
--- a/recipes-security/refpolicy/refpolicy/0016-fc-corecommands-apply-policy-to-nologin-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0016-fc-corecommands-apply-policy-to-nologin-alternatives.patch
@@ -1,4 +1,4 @@
-From 48b69b97a52cf782fbc54f5e55e92ee81466d0bc Mon Sep 17 00:00:00 2001
+From 3b40ac147bc2e1a1d387d519fd1710e92d934b4e Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:21:51 +0800
 Subject: [PATCH] fc/corecommands: apply policy to nologin alternatives
@@ -11,10 +11,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/kernel/corecommands.fc b/policy/modules/kernel/corecommands.fc
-index 9a5711a83..c9009af5f 100644
+index 1c2553d21..65178ba32 100644
 --- a/policy/modules/kernel/corecommands.fc
 +++ b/policy/modules/kernel/corecommands.fc
-@@ -311,6 +311,8 @@ ifdef(`distro_debian',`
+@@ -312,6 +312,8 @@ ifdef(`distro_debian',`
  /usr/sbin/insmod_ksymoops_clean	--	gen_context(system_u:object_r:bin_t,s0)
  /usr/sbin/mkfs\.cramfs		--	gen_context(system_u:object_r:bin_t,s0)
  /usr/sbin/nologin		--	gen_context(system_u:object_r:shell_exec_t,s0)
diff --git a/recipes-security/refpolicy/refpolicy/0017-fc-locallogin-apply-policy-to-sulogin-alternatives.patch b/recipes-security/refpolicy/refpolicy/0017-fc-locallogin-apply-policy-to-sulogin-alternatives.patch
index 63fa13a..29a9a05 100644
--- a/recipes-security/refpolicy/refpolicy/0017-fc-locallogin-apply-policy-to-sulogin-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0017-fc-locallogin-apply-policy-to-sulogin-alternatives.patch
@@ -1,4 +1,4 @@
-From 29e16342861e11d6463ec63ffbe55d1665d05e7d Mon Sep 17 00:00:00 2001
+From 07657262d8ac7304f8dd0224e3daaecc925d4392 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:43:28 +0800
 Subject: [PATCH] fc/locallogin: apply policy to sulogin alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0018-fc-ntp-apply-policy-to-ntpd-alternatives.patch b/recipes-security/refpolicy/refpolicy/0018-fc-ntp-apply-policy-to-ntpd-alternatives.patch
index 1947803..c16b3d0 100644
--- a/recipes-security/refpolicy/refpolicy/0018-fc-ntp-apply-policy-to-ntpd-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0018-fc-ntp-apply-policy-to-ntpd-alternatives.patch
@@ -1,4 +1,4 @@
-From c1847b18ed1b1a18dbafc735bfb1368c2abb9d55 Mon Sep 17 00:00:00 2001
+From 85f3abe44a579ddff62fa3ef774c9d53c3bb35e4 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:45:23 +0800
 Subject: [PATCH] fc/ntp: apply policy to ntpd alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0019-fc-kerberos-apply-policy-to-kerberos-alternatives.patch b/recipes-security/refpolicy/refpolicy/0019-fc-kerberos-apply-policy-to-kerberos-alternatives.patch
index 4248605..bcbc59f 100644
--- a/recipes-security/refpolicy/refpolicy/0019-fc-kerberos-apply-policy-to-kerberos-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0019-fc-kerberos-apply-policy-to-kerberos-alternatives.patch
@@ -1,4 +1,4 @@
-From 1400afd28f2cd886bae487fb17811a5fd98b86b9 Mon Sep 17 00:00:00 2001
+From b23752c14edcda3a5d25c386986cb2a53f68df71 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:55:05 +0800
 Subject: [PATCH] fc/kerberos: apply policy to kerberos alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0020-fc-ldap-apply-policy-to-ldap-alternatives.patch b/recipes-security/refpolicy/refpolicy/0020-fc-ldap-apply-policy-to-ldap-alternatives.patch
index c0aa11b..111af65 100644
--- a/recipes-security/refpolicy/refpolicy/0020-fc-ldap-apply-policy-to-ldap-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0020-fc-ldap-apply-policy-to-ldap-alternatives.patch
@@ -1,4 +1,4 @@
-From 53370099eb97c008460bb7b99817737beb94a9bf Mon Sep 17 00:00:00 2001
+From e86acf68aec0f34bd0d0e41cedbaf4e1584d1a74 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 11:06:13 +0800
 Subject: [PATCH] fc/ldap: apply policy to ldap alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0021-fc-postgresql-apply-policy-to-postgresql-alternative.patch b/recipes-security/refpolicy/refpolicy/0021-fc-postgresql-apply-policy-to-postgresql-alternative.patch
index d76d2e3..c5f190a 100644
--- a/recipes-security/refpolicy/refpolicy/0021-fc-postgresql-apply-policy-to-postgresql-alternative.patch
+++ b/recipes-security/refpolicy/refpolicy/0021-fc-postgresql-apply-policy-to-postgresql-alternative.patch
@@ -1,4 +1,4 @@
-From 67fda1f031d70d1281b058a5f3a31e220b052d21 Mon Sep 17 00:00:00 2001
+From e237a9acdb30805eec7f7baea6265a4595f93b9d Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 11:13:16 +0800
 Subject: [PATCH] fc/postgresql: apply policy to postgresql alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0022-fc-screen-apply-policy-to-screen-alternatives.patch b/recipes-security/refpolicy/refpolicy/0022-fc-screen-apply-policy-to-screen-alternatives.patch
index 2fe39bf..0ce9694 100644
--- a/recipes-security/refpolicy/refpolicy/0022-fc-screen-apply-policy-to-screen-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0022-fc-screen-apply-policy-to-screen-alternatives.patch
@@ -1,4 +1,4 @@
-From fb72a7ca4963a7537bcb98a730025f6f8941d146 Mon Sep 17 00:00:00 2001
+From 83195f523c21392d9be0af8cd3bc358bd42f882c Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 11:15:33 +0800
 Subject: [PATCH] fc/screen: apply policy to screen alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0023-fc-usermanage-apply-policy-to-usermanage-alternative.patch b/recipes-security/refpolicy/refpolicy/0023-fc-usermanage-apply-policy-to-usermanage-alternative.patch
index 0d95b3c..c4bcc75 100644
--- a/recipes-security/refpolicy/refpolicy/0023-fc-usermanage-apply-policy-to-usermanage-alternative.patch
+++ b/recipes-security/refpolicy/refpolicy/0023-fc-usermanage-apply-policy-to-usermanage-alternative.patch
@@ -1,4 +1,4 @@
-From 343389daef155325172928f7d5608e638897775d Mon Sep 17 00:00:00 2001
+From 75bc058a2571dc61b74b18647fa0288b9c47d628 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 11:25:34 +0800
 Subject: [PATCH] fc/usermanage: apply policy to usermanage alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0024-fc-getty-add-file-context-to-start_getty.patch b/recipes-security/refpolicy/refpolicy/0024-fc-getty-add-file-context-to-start_getty.patch
index 3066e52..c06c824 100644
--- a/recipes-security/refpolicy/refpolicy/0024-fc-getty-add-file-context-to-start_getty.patch
+++ b/recipes-security/refpolicy/refpolicy/0024-fc-getty-add-file-context-to-start_getty.patch
@@ -1,4 +1,4 @@
-From 23cef56ad581ee4579ab6ee26c9dd8b114816b6b Mon Sep 17 00:00:00 2001
+From 5b7b58fb5b23b4ccc427233061ba816b45faaca3 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 16:07:30 +0800
 Subject: [PATCH] fc/getty: add file context to start_getty
diff --git a/recipes-security/refpolicy/refpolicy/0025-fc-vlock-apply-policy-to-vlock-alternatives.patch b/recipes-security/refpolicy/refpolicy/0025-fc-vlock-apply-policy-to-vlock-alternatives.patch
index 7e596ef..670446b 100644
--- a/recipes-security/refpolicy/refpolicy/0025-fc-vlock-apply-policy-to-vlock-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0025-fc-vlock-apply-policy-to-vlock-alternatives.patch
@@ -1,4 +1,4 @@
-From 32988df0a389ef480334dffce4d5cc96b0f1012e Mon Sep 17 00:00:00 2001
+From 6e72fd53bbadf600c06c3f25dfd502e6a9c502fb Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Wed, 18 Dec 2019 15:04:41 +0800
 Subject: [PATCH] fc/vlock: apply policy to vlock alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0026-fc-add-fcontext-for-init-scripts-and-systemd-service.patch b/recipes-security/refpolicy/refpolicy/0026-fc-add-fcontext-for-init-scripts-and-systemd-service.patch
index 4fe9ee9..84af1fa 100644
--- a/recipes-security/refpolicy/refpolicy/0026-fc-add-fcontext-for-init-scripts-and-systemd-service.patch
+++ b/recipes-security/refpolicy/refpolicy/0026-fc-add-fcontext-for-init-scripts-and-systemd-service.patch
@@ -1,4 +1,4 @@
-From 8586fbe84abd716a425e13e8b48179a08e210db2 Mon Sep 17 00:00:00 2001
+From 7f58d61471a45851dd162c2b4bd9733a5311c0b9 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 30 Jun 2020 10:45:57 +0800
 Subject: [PATCH] fc: add fcontext for init scripts and systemd service files
@@ -14,7 +14,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  4 files changed, 5 insertions(+)
 
 diff --git a/policy/modules/services/cron.fc b/policy/modules/services/cron.fc
-index 827363d88..e8412396d 100644
+index e71ad22c1..bb1351732 100644
 --- a/policy/modules/services/cron.fc
 +++ b/policy/modules/services/cron.fc
 @@ -1,4 +1,5 @@
@@ -34,7 +34,7 @@ index 382c067f9..0ecc5acc4 100644
  /usr/bin/rngd	--	gen_context(system_u:object_r:rngd_exec_t,s0)
  
 diff --git a/policy/modules/services/rpc.fc b/policy/modules/services/rpc.fc
-index 7edc09fac..7416fa39f 100644
+index 3b6d1c930..4949d995a 100644
 --- a/policy/modules/services/rpc.fc
 +++ b/policy/modules/services/rpc.fc
 @@ -2,7 +2,9 @@
@@ -46,7 +46,7 @@ index 7edc09fac..7416fa39f 100644
 +/etc/rc\.d/init\.d/nfscommon	--	gen_context(system_u:object_r:rpcd_initrc_exec_t,s0)
  /etc/rc\.d/init\.d/rpcidmapd	--	gen_context(system_u:object_r:rpcd_initrc_exec_t,s0)
  
- /usr/bin/nfsdcld	--	gen_context(system_u:object_r:rpcd_exec_t,s0)
+ /usr/bin/blkmapd	--	gen_context(system_u:object_r:blkmapd_exec_t,s0)
 diff --git a/policy/modules/system/logging.fc b/policy/modules/system/logging.fc
 index 3b0dea51b..0ce2bec4b 100644
 --- a/policy/modules/system/logging.fc
diff --git a/recipes-security/refpolicy/refpolicy/0027-file_contexts.subs_dist-set-aliase-for-root-director.patch b/recipes-security/refpolicy/refpolicy/0027-file_contexts.subs_dist-set-aliase-for-root-director.patch
index 0ad146d..a2a1de8 100644
--- a/recipes-security/refpolicy/refpolicy/0027-file_contexts.subs_dist-set-aliase-for-root-director.patch
+++ b/recipes-security/refpolicy/refpolicy/0027-file_contexts.subs_dist-set-aliase-for-root-director.patch
@@ -1,4 +1,4 @@
-From 20f43a932c5f7369a446707624d12285035b72fc Mon Sep 17 00:00:00 2001
+From de259386cb52e44dd00534f598800a23be0d7689 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Sun, 5 Apr 2020 22:03:45 +0800
 Subject: [PATCH] file_contexts.subs_dist: set aliase for /root directory
diff --git a/recipes-security/refpolicy/refpolicy/0028-policy-modules-system-logging-add-rules-for-the-syml.patch b/recipes-security/refpolicy/refpolicy/0028-policy-modules-system-logging-add-rules-for-the-syml.patch
index a433cb7..7aaf702 100644
--- a/recipes-security/refpolicy/refpolicy/0028-policy-modules-system-logging-add-rules-for-the-syml.patch
+++ b/recipes-security/refpolicy/refpolicy/0028-policy-modules-system-logging-add-rules-for-the-syml.patch
@@ -1,4 +1,4 @@
-From 97839d4388be64e168613c2ea3202a76e58fb656 Mon Sep 17 00:00:00 2001
+From 5147059bcfce76f04c4bacaadc4007588b6a722f Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/system/logging: add rules for the symlink of
diff --git a/recipes-security/refpolicy/refpolicy/0029-policy-modules-system-logging-add-rules-for-syslogd-.patch b/recipes-security/refpolicy/refpolicy/0029-policy-modules-system-logging-add-rules-for-syslogd-.patch
index 2465417..2b43530 100644
--- a/recipes-security/refpolicy/refpolicy/0029-policy-modules-system-logging-add-rules-for-syslogd-.patch
+++ b/recipes-security/refpolicy/refpolicy/0029-policy-modules-system-logging-add-rules-for-syslogd-.patch
@@ -1,4 +1,4 @@
-From 9bd0c30476615fd4af29a9dd5b3b664398a9845a Mon Sep 17 00:00:00 2001
+From e2ce1a7a491ee079b9e393ba6bc6c17d457959f4 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 29 Mar 2019 10:33:18 -0400
 Subject: [PATCH] policy/modules/system/logging: add rules for syslogd symlink
@@ -18,7 +18,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index eea78ffc5..5f06428f1 100644
+index 11bbbc113..38e0b4766 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -425,6 +425,7 @@ files_search_spool(syslogd_t)
diff --git a/recipes-security/refpolicy/refpolicy/0030-policy-modules-kernel-files-add-rules-for-the-symlin.patch b/recipes-security/refpolicy/refpolicy/0030-policy-modules-kernel-files-add-rules-for-the-symlin.patch
index 6c5731b..6256789 100644
--- a/recipes-security/refpolicy/refpolicy/0030-policy-modules-kernel-files-add-rules-for-the-symlin.patch
+++ b/recipes-security/refpolicy/refpolicy/0030-policy-modules-kernel-files-add-rules-for-the-symlin.patch
@@ -1,4 +1,4 @@
-From 6293ec11e3c471b54c328f56f20c694b7287885f Mon Sep 17 00:00:00 2001
+From da3cf0879a8e34996125871e8d1336726f715acb Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/kernel/files: add rules for the symlink of
@@ -30,10 +30,10 @@ index b1728d37c..c5012e6b4 100644
  /tmp/\.journal			<<none>>
  
 diff --git a/policy/modules/kernel/files.if b/policy/modules/kernel/files.if
-index 811efef94..00146fc23 100644
+index e1fafd4ab..dbd7efa60 100644
 --- a/policy/modules/kernel/files.if
 +++ b/policy/modules/kernel/files.if
-@@ -4880,6 +4880,7 @@ interface(`files_search_tmp',`
+@@ -4897,6 +4897,7 @@ interface(`files_search_tmp',`
  	')
  
  	allow $1 tmp_t:dir search_dir_perms;
@@ -41,7 +41,7 @@ index 811efef94..00146fc23 100644
  ')
  
  ########################################
-@@ -4916,6 +4917,7 @@ interface(`files_list_tmp',`
+@@ -4933,6 +4934,7 @@ interface(`files_list_tmp',`
  	')
  
  	allow $1 tmp_t:dir list_dir_perms;
@@ -49,7 +49,7 @@ index 811efef94..00146fc23 100644
  ')
  
  ########################################
-@@ -4952,6 +4954,7 @@ interface(`files_delete_tmp_dir_entry',`
+@@ -4969,6 +4971,7 @@ interface(`files_delete_tmp_dir_entry',`
  	')
  
  	allow $1 tmp_t:dir del_entry_dir_perms;
@@ -57,7 +57,7 @@ index 811efef94..00146fc23 100644
  ')
  
  ########################################
-@@ -4970,6 +4973,7 @@ interface(`files_read_generic_tmp_files',`
+@@ -4987,6 +4990,7 @@ interface(`files_read_generic_tmp_files',`
  	')
  
  	read_files_pattern($1, tmp_t, tmp_t)
@@ -65,7 +65,7 @@ index 811efef94..00146fc23 100644
  ')
  
  ########################################
-@@ -4988,6 +4992,7 @@ interface(`files_manage_generic_tmp_dirs',`
+@@ -5005,6 +5009,7 @@ interface(`files_manage_generic_tmp_dirs',`
  	')
  
  	manage_dirs_pattern($1, tmp_t, tmp_t)
@@ -73,7 +73,7 @@ index 811efef94..00146fc23 100644
  ')
  
  ########################################
-@@ -5024,6 +5029,7 @@ interface(`files_manage_generic_tmp_files',`
+@@ -5041,6 +5046,7 @@ interface(`files_manage_generic_tmp_files',`
  	')
  
  	manage_files_pattern($1, tmp_t, tmp_t)
@@ -81,7 +81,7 @@ index 811efef94..00146fc23 100644
  ')
  
  ########################################
-@@ -5060,6 +5066,7 @@ interface(`files_rw_generic_tmp_sockets',`
+@@ -5077,6 +5083,7 @@ interface(`files_rw_generic_tmp_sockets',`
  	')
  
  	rw_sock_files_pattern($1, tmp_t, tmp_t)
@@ -89,7 +89,7 @@ index 811efef94..00146fc23 100644
  ')
  
  ########################################
-@@ -5267,6 +5274,7 @@ interface(`files_tmp_filetrans',`
+@@ -5284,6 +5291,7 @@ interface(`files_tmp_filetrans',`
  	')
  
  	filetrans_pattern($1, tmp_t, $2, $3, $4)
diff --git a/recipes-security/refpolicy/refpolicy/0031-policy-modules-system-logging-fix-auditd-startup-fai.patch b/recipes-security/refpolicy/refpolicy/0031-policy-modules-system-logging-fix-auditd-startup-fai.patch
index 9ddeb9f..b6ec45c 100644
--- a/recipes-security/refpolicy/refpolicy/0031-policy-modules-system-logging-fix-auditd-startup-fai.patch
+++ b/recipes-security/refpolicy/refpolicy/0031-policy-modules-system-logging-fix-auditd-startup-fai.patch
@@ -1,4 +1,4 @@
-From 40ddb313a0cb04b3e9b180e04d3427715de58aee Mon Sep 17 00:00:00 2001
+From 59c29aa28424cf61f6b71a9022dced52d5b58c8f Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/system/logging: fix auditd startup failures
@@ -17,7 +17,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 3 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index 5f06428f1..3ffddcb0a 100644
+index 38e0b4766..a1912254e 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -117,6 +117,7 @@ allow auditctl_t self:netlink_audit_socket nlmsg_readpriv;
diff --git a/recipes-security/refpolicy/refpolicy/0032-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch b/recipes-security/refpolicy/refpolicy/0032-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch
index 8af397d..77d59b8 100644
--- a/recipes-security/refpolicy/refpolicy/0032-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch
+++ b/recipes-security/refpolicy/refpolicy/0032-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch
@@ -1,4 +1,4 @@
-From 857a2cf93f6194d04ae8d2a8a544422e8a021e85 Mon Sep 17 00:00:00 2001
+From 81222e113818c210d4c2a65567d0b464f96b0523 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/kernel/terminal: don't audit tty_device_t in
diff --git a/recipes-security/refpolicy/refpolicy/0033-policy-modules-system-systemd-enable-support-for-sys.patch b/recipes-security/refpolicy/refpolicy/0033-policy-modules-system-systemd-enable-support-for-sys.patch
index 82fe4ff..0ffd2f7 100644
--- a/recipes-security/refpolicy/refpolicy/0033-policy-modules-system-systemd-enable-support-for-sys.patch
+++ b/recipes-security/refpolicy/refpolicy/0033-policy-modules-system-systemd-enable-support-for-sys.patch
@@ -1,4 +1,4 @@
-From 44fe25734126ae52d95456992d6a5257bb28a5c2 Mon Sep 17 00:00:00 2001
+From 1c992963d7006927a79c9009c372ab9593b5bb95 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Thu, 4 Feb 2016 06:03:19 -0500
 Subject: [PATCH] policy/modules/system/systemd: enable support for
@@ -29,7 +29,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+), 1 deletion(-)
 
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index d58aba30b..8ae917644 100644
+index 523e49f14..e48a8c26f 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
 @@ -10,7 +10,7 @@ policy_module(systemd)
diff --git a/recipes-security/refpolicy/refpolicy/0034-policy-modules-system-logging-allow-systemd-tmpfiles.patch b/recipes-security/refpolicy/refpolicy/0034-policy-modules-system-logging-allow-systemd-tmpfiles.patch
index 334872a..9c5b172 100644
--- a/recipes-security/refpolicy/refpolicy/0034-policy-modules-system-logging-allow-systemd-tmpfiles.patch
+++ b/recipes-security/refpolicy/refpolicy/0034-policy-modules-system-logging-allow-systemd-tmpfiles.patch
@@ -1,4 +1,4 @@
-From 07582b5efbc4fd199e80d9cc9b8144e4c88e0a2b Mon Sep 17 00:00:00 2001
+From 803bb22683f9265837d0a0713d1f49003eb33ac8 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Sat, 30 Sep 2023 17:20:29 +0800
 Subject: [PATCH] policy/modules/system/logging: allow systemd-tmpfiles to
@@ -24,7 +24,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 4 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index 3ffddcb0a..df6095805 100644
+index a1912254e..481ae9d14 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -27,6 +27,10 @@ type auditd_log_t;
diff --git a/recipes-security/refpolicy/refpolicy/0036-policy-modules-roles-sysadm-allow-sysadm-to-use-init.patch b/recipes-security/refpolicy/refpolicy/0035-policy-modules-roles-sysadm-allow-sysadm-to-use-init.patch
similarity index 91%
rename from recipes-security/refpolicy/refpolicy/0036-policy-modules-roles-sysadm-allow-sysadm-to-use-init.patch
rename to recipes-security/refpolicy/refpolicy/0035-policy-modules-roles-sysadm-allow-sysadm-to-use-init.patch
index 3461d66..e0feada 100644
--- a/recipes-security/refpolicy/refpolicy/0036-policy-modules-roles-sysadm-allow-sysadm-to-use-init.patch
+++ b/recipes-security/refpolicy/refpolicy/0035-policy-modules-roles-sysadm-allow-sysadm-to-use-init.patch
@@ -1,4 +1,4 @@
-From be2a2d244fd95e4207986fa095988a02cb33cb32 Mon Sep 17 00:00:00 2001
+From c89141ec6fc96e304a8dac16fa5f4e45fa802201 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 28 Oct 2022 11:56:09 +0800
 Subject: [PATCH] policy/modules/roles/sysadm: allow sysadm to use init file
@@ -19,7 +19,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/roles/sysadm.te b/policy/modules/roles/sysadm.te
-index 69777df20..af5ccca9d 100644
+index acf2c67ae..0c96829a9 100644
 --- a/policy/modules/roles/sysadm.te
 +++ b/policy/modules/roles/sysadm.te
 @@ -95,6 +95,8 @@ ifdef(`init_systemd',`
diff --git a/recipes-security/refpolicy/refpolicy/0035-policy-modules-system-systemd-allow-systemd_logind_t.patch b/recipes-security/refpolicy/refpolicy/0035-policy-modules-system-systemd-allow-systemd_logind_t.patch
deleted file mode 100644
index 39902dd..0000000
--- a/recipes-security/refpolicy/refpolicy/0035-policy-modules-system-systemd-allow-systemd_logind_t.patch
+++ /dev/null
@@ -1,43 +0,0 @@
-From 13ad5906311d8e0be5547326c106d9b5ce8481ab Mon Sep 17 00:00:00 2001
-From: Yi Zhao <yi.zhao@windriver.com>
-Date: Sat, 18 Dec 2021 09:26:43 +0800
-Subject: [PATCH] policy/modules/system/systemd: allow systemd_logind_t to read
- the process state of all domains
-
-We encountered the following su runtime error:
-$ useradd user1
-$ passwd user1
-New password:
-Retype new password:
-passwd: password updated successfully
-$ su - user1
-Session terminated, terminating shell...Hangup
-
-Fixes:
-avc:  denied  { use } for  pid=344 comm="su"
-path="/run/systemd/sessions/c4.ref" dev="tmpfs" ino=661
-scontext=root:sysadm_r:sysadm_su_t
-tcontext=system_u:system_r:systemd_logind_t tclass=fd permissive=0
-
-Upstream-Status: Pending
-
-Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
----
- policy/modules/system/systemd.te | 1 +
- 1 file changed, 1 insertion(+)
-
-diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index 8ae917644..9375e8926 100644
---- a/policy/modules/system/systemd.te
-+++ b/policy/modules/system/systemd.te
-@@ -1056,6 +1056,7 @@ userdom_relabelfrom_user_runtime_dirs(systemd_logind_t)
- userdom_relabelto_user_runtime_dirs(systemd_logind_t)
- userdom_setattr_user_ttys(systemd_logind_t)
- userdom_use_user_ttys(systemd_logind_t)
-+domain_read_all_domains_state(systemd_logind_t)
- 
- # Needed to work around patch not yet merged into the systemd-logind supported on RHEL 7.x
- # The change in systemd by Nicolas Iooss on 02-Feb-2016 with hash 4b51966cf6c06250036e428608da92f8640beb96
--- 
-2.25.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0037-policy-modules-system-systemd-systemd-user-fixes.patch b/recipes-security/refpolicy/refpolicy/0036-policy-modules-system-systemd-systemd-user-fixes.patch
similarity index 93%
rename from recipes-security/refpolicy/refpolicy/0037-policy-modules-system-systemd-systemd-user-fixes.patch
rename to recipes-security/refpolicy/refpolicy/0036-policy-modules-system-systemd-systemd-user-fixes.patch
index 02e7541..fb3146a 100644
--- a/recipes-security/refpolicy/refpolicy/0037-policy-modules-system-systemd-systemd-user-fixes.patch
+++ b/recipes-security/refpolicy/refpolicy/0036-policy-modules-system-systemd-systemd-user-fixes.patch
@@ -1,4 +1,4 @@
-From d57677139a8fc837ede3430986bea0c42f49fc97 Mon Sep 17 00:00:00 2001
+From b2271a808dcc39a199729cbc3884577a5359bb63 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Thu, 4 Feb 2021 10:48:54 +0800
 Subject: [PATCH] policy/modules/system/systemd: systemd --user fixes
@@ -31,10 +31,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  2 files changed, 34 insertions(+)
 
 diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
-index e62e8344a..96b5d31b4 100644
+index 0f92c23bd..1ae6195a1 100644
 --- a/policy/modules/system/systemd.if
 +++ b/policy/modules/system/systemd.if
-@@ -230,6 +230,36 @@ template(`systemd_role_template',`
+@@ -236,6 +236,36 @@ template(`systemd_role_template',`
  	')
  ')
  
@@ -72,7 +72,7 @@ index e62e8344a..96b5d31b4 100644
  ## <summary>
  ##   Allow the specified domain to be started as a daemon by the
 diff --git a/policy/modules/system/userdomain.if b/policy/modules/system/userdomain.if
-index 73bb7c410..ea7a90a5d 100644
+index 677bad480..d2e5feda7 100644
 --- a/policy/modules/system/userdomain.if
 +++ b/policy/modules/system/userdomain.if
 @@ -1467,6 +1467,10 @@ template(`userdom_admin_user_template',`
diff --git a/recipes-security/refpolicy/refpolicy/0038-policy-modules-system-logging-grant-getpcap-capabili.patch b/recipes-security/refpolicy/refpolicy/0037-policy-modules-system-logging-grant-getpcap-capabili.patch
similarity index 92%
rename from recipes-security/refpolicy/refpolicy/0038-policy-modules-system-logging-grant-getpcap-capabili.patch
rename to recipes-security/refpolicy/refpolicy/0037-policy-modules-system-logging-grant-getpcap-capabili.patch
index 3f8d1bd..8885851 100644
--- a/recipes-security/refpolicy/refpolicy/0038-policy-modules-system-logging-grant-getpcap-capabili.patch
+++ b/recipes-security/refpolicy/refpolicy/0037-policy-modules-system-logging-grant-getpcap-capabili.patch
@@ -1,4 +1,4 @@
-From c54c53f8765c4401aa4c1b4a6204c8b538c008ad Mon Sep 17 00:00:00 2001
+From 74f4dd3dfdd0356171a7ce08c5d5c797c57dbe4a Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 28 May 2024 11:21:48 +0800
 Subject: [PATCH] policy/modules/system/logging: grant getpcap capability to
@@ -21,7 +21,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index df6095805..086498936 100644
+index 481ae9d14..be602fc7f 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -402,6 +402,8 @@ optional_policy(`
diff --git a/recipes-security/refpolicy/refpolicy/0039-policy-modules-system-allow-services-to-read-tmpfs-u.patch b/recipes-security/refpolicy/refpolicy/0038-policy-modules-system-allow-services-to-read-tmpfs-u.patch
similarity index 95%
rename from recipes-security/refpolicy/refpolicy/0039-policy-modules-system-allow-services-to-read-tmpfs-u.patch
rename to recipes-security/refpolicy/refpolicy/0038-policy-modules-system-allow-services-to-read-tmpfs-u.patch
index 1324a17..b4b8291 100644
--- a/recipes-security/refpolicy/refpolicy/0039-policy-modules-system-allow-services-to-read-tmpfs-u.patch
+++ b/recipes-security/refpolicy/refpolicy/0038-policy-modules-system-allow-services-to-read-tmpfs-u.patch
@@ -1,4 +1,4 @@
-From 33bc8d28c406ffd7a6aef2f390734b3f5bdfc5a3 Mon Sep 17 00:00:00 2001
+From 0047cbb8997d9d36613dcee9b60430fa44025713 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 30 Aug 2024 12:39:48 +0800
 Subject: [PATCH] policy/modules/system: allow services to read tmpfs under
@@ -67,7 +67,7 @@ index a900226bf..75b94785b 100644
  mcs_process_set_categories(getty_t)
  
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index 086498936..dca46f105 100644
+index be602fc7f..dbb9c62c9 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -491,6 +491,7 @@ files_read_kernel_symbol_table(syslogd_t)
@@ -79,10 +79,10 @@ index 086498936..dca46f105 100644
  
  mls_file_write_all_levels(syslogd_t) # Need to be able to write to /var/run/ and /var/log directories
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index 9375e8926..24fc90838 100644
+index e48a8c26f..23f7a6027 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -1294,6 +1294,7 @@ files_watch_root_dirs(systemd_networkd_t)
+@@ -1332,6 +1332,7 @@ files_watch_root_dirs(systemd_networkd_t)
  files_list_runtime(systemd_networkd_t)
  
  fs_getattr_all_fs(systemd_networkd_t)
@@ -91,7 +91,7 @@ index 9375e8926..24fc90838 100644
  fs_read_nsfs_files(systemd_networkd_t)
  fs_watch_memory_pressure(systemd_networkd_t)
 diff --git a/policy/modules/system/udev.te b/policy/modules/system/udev.te
-index b2e43aa7d..f543a48d2 100644
+index 620de7e2e..ccb073351 100644
 --- a/policy/modules/system/udev.te
 +++ b/policy/modules/system/udev.te
 @@ -142,6 +142,7 @@ files_dontaudit_getattr_tmp_dirs(udev_t)
diff --git a/recipes-security/refpolicy/refpolicy/0040-policy-modules-kernel-domain-allow-all-domains-to-co.patch b/recipes-security/refpolicy/refpolicy/0039-policy-modules-kernel-domain-allow-all-domains-to-co.patch
similarity index 95%
rename from recipes-security/refpolicy/refpolicy/0040-policy-modules-kernel-domain-allow-all-domains-to-co.patch
rename to recipes-security/refpolicy/refpolicy/0039-policy-modules-kernel-domain-allow-all-domains-to-co.patch
index e9d9114..a2238b5 100644
--- a/recipes-security/refpolicy/refpolicy/0040-policy-modules-kernel-domain-allow-all-domains-to-co.patch
+++ b/recipes-security/refpolicy/refpolicy/0039-policy-modules-kernel-domain-allow-all-domains-to-co.patch
@@ -1,4 +1,4 @@
-From 58adf54a5ef927cda85c11e2c73151d6e91e8294 Mon Sep 17 00:00:00 2001
+From 975472091496c8f6ed6544dd307672ccb97cf958 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Thu, 3 Oct 2024 21:12:33 +0800
 Subject: [PATCH] policy/modules/kernel/domain: allow all domains to connect to
diff --git a/recipes-security/refpolicy/refpolicy/0040-systemd-allow-systemd-logind-to-inherit-fds.patch b/recipes-security/refpolicy/refpolicy/0040-systemd-allow-systemd-logind-to-inherit-fds.patch
new file mode 100644
index 0000000..0010a1f
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0040-systemd-allow-systemd-logind-to-inherit-fds.patch
@@ -0,0 +1,68 @@
+From 9627b5cad0230bc937ba1f2901985afbbc8fcff6 Mon Sep 17 00:00:00 2001
+From: Yi Zhao <yi.zhao@windriver.com>
+Date: Tue, 18 Feb 2025 09:54:06 +0800
+Subject: [PATCH] systemd: allow systemd-logind to inherit fds
+
+Fix the timeout issue after exiting su environment:
+root@qemux86-64:~# su - user1
+qemux86-64:~$ exit
+logout
+root@qemux86-64:~# reboot
+Failed to set wall message, ignoring: Connection timed out
+Call to Reboot failed: Connection timed out
+
+Upstream-Status: Pending
+
+Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
+---
+ policy/modules/admin/su.if       |  4 ++++
+ policy/modules/system/systemd.if | 18 ++++++++++++++++++
+ 2 files changed, 22 insertions(+)
+
+diff --git a/policy/modules/admin/su.if b/policy/modules/admin/su.if
+index ebb7ef0e0..0398ce6fd 100644
+--- a/policy/modules/admin/su.if
++++ b/policy/modules/admin/su.if
+@@ -232,6 +232,10 @@ template(`su_role_template',`
+ 		auth_use_pam_systemd($1_su_t)
+ 	')
+ 
++	ifdef(`init_systemd',`
++		systemd_inherit_logind_fds($1_su_t)
++	')
++
+ 	tunable_policy(`su_allow_user_exec_domains',`
+ 		allow $3 $1_su_t:process signal;
+ 
+diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
+index 1ae6195a1..99318a3c2 100644
+--- a/policy/modules/system/systemd.if
++++ b/policy/modules/system/systemd.if
+@@ -1439,6 +1439,24 @@ interface(`systemd_use_logind_fds',`
+ 	allow $1 systemd_logind_t:fd use;
+ ')
+ 
++######################################
++## <summary>
++##   Allow systemd logind to inherit fds
++## </summary>
++## <param name="domain">
++##	<summary>
++##	Domain allowed access.
++##	</summary>
++## </param>
++#
++interface(`systemd_inherit_logind_fds',`
++	gen_require(`
++		type systemd_logind_t;
++	')
++
++	allow systemd_logind_t $1:fd use;
++')
++
+ ######################################
+ ## <summary>
+ ##      Watch logind sessions dirs.
+-- 
+2.25.1
+
diff --git a/recipes-security/refpolicy/refpolicy/0041-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch b/recipes-security/refpolicy/refpolicy/0041-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch
new file mode 100644
index 0000000..f3833a4
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0041-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch
@@ -0,0 +1,107 @@
+From a39879ca482b525ae2b48bf8708615c923df0575 Mon Sep 17 00:00:00 2001
+From: Yi Zhao <yi.zhao@windriver.com>
+Date: Tue, 18 Feb 2025 15:26:19 +0800
+Subject: [PATCH] systemd: allow systemd-tmpfiles to read bin_t symlink
+
+Fixes:
+avc:  denied  { getattr } for  pid=279 comm="systemd-tmpfile"
+path="/etc/profile.d/70-systemd-shell-extra.sh" dev="vda" ino=172
+scontext=system_u:system_r:systemd_tmpfiles_t
+tcontext=system_u:object_r:bin_t tclass=lnk_file permissive=0
+
+Feb 17 10:16:25 qemux86-64 systemd-tmpfiles[279]: Failed to
+fstat(/etc/profile.d/70-systemd-shell-extra.sh): Permission denied
+
+Upstream-Status: Pending
+
+Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
+---
+ policy/modules/kernel/corecommands.fc |  1 +
+ policy/modules/kernel/corecommands.if | 18 ++++++++++++++++++
+ policy/modules/system/systemd.if      |  1 +
+ policy/modules/system/systemd.te      |  5 +++++
+ 4 files changed, 25 insertions(+)
+
+diff --git a/policy/modules/kernel/corecommands.fc b/policy/modules/kernel/corecommands.fc
+index 65178ba32..c7e3d2dae 100644
+--- a/policy/modules/kernel/corecommands.fc
++++ b/policy/modules/kernel/corecommands.fc
+@@ -241,6 +241,7 @@ ifdef(`distro_gentoo',`
+ /usr/lib/sftp-server		--	gen_context(system_u:object_r:bin_t,s0)
+ /usr/lib/ssh(/.*)?			gen_context(system_u:object_r:bin_t,s0)
+ /usr/lib/sudo/sesh		--	gen_context(system_u:object_r:shell_exec_t,s0)
++/usr/lib/systemd/profile\.d(/.*)?	gen_context(system_u:object_r:bin_t,s0)
+ /usr/lib/systemd/systemd.*	--	gen_context(system_u:object_r:bin_t,s0)
+ /usr/lib/systemd/system-shutdown(/.*)?	gen_context(system_u:object_r:bin_t,s0)
+ /usr/lib/systemd/system-sleep(/.*)?	gen_context(system_u:object_r:bin_t,s0)
+diff --git a/policy/modules/kernel/corecommands.if b/policy/modules/kernel/corecommands.if
+index 08ed91f19..0fa4cbf7d 100644
+--- a/policy/modules/kernel/corecommands.if
++++ b/policy/modules/kernel/corecommands.if
+@@ -842,3 +842,21 @@ interface(`corecmd_mmap_all_executables',`
+ 	corecmd_search_bin($1)
+ 	mmap_exec_files_pattern($1, bin_t, exec_type)
+ ')
++
++########################################
++## <summary>
++##	Read symbolic links of bin_t files.
++## </summary>
++## <param name="domain">
++##	<summary>
++##	Domain allowed access.
++##	</summary>
++## </param>
++#
++interface(`fs_read_bin_symlinks',`
++	gen_require(`
++		type bin_t;
++	')
++
++	read_lnk_files_pattern($1, bin_t, bin_t)
++')
+diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
+index 99318a3c2..7654d1076 100644
+--- a/policy/modules/system/systemd.if
++++ b/policy/modules/system/systemd.if
+@@ -146,6 +146,7 @@ template(`systemd_role_template',`
+ 	userdom_exec_user_bin_files($1_systemd_t)
+ 
+ 	# user systemd-tmpfiles rules
++	allow $1_systemd_tmpfiles_t self:capability net_admin;
+ 	allow $1_systemd_tmpfiles_t $1_systemd_t:unix_stream_socket rw_socket_perms;
+ 	domtrans_pattern($1_systemd_t, systemd_tmpfiles_exec_t, $1_systemd_tmpfiles_t)
+ 	read_files_pattern($1_systemd_t, $1_systemd_tmpfiles_t, $1_systemd_tmpfiles_t)
+diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
+index 23f7a6027..c605d58de 100644
+--- a/policy/modules/system/systemd.te
++++ b/policy/modules/system/systemd.te
+@@ -817,6 +817,7 @@ files_read_etc_files(systemd_hostnamed_t)
+ files_read_etc_runtime_files(systemd_hostnamed_t)
+ 
+ fs_getattr_all_fs(systemd_hostnamed_t)
++fs_getattr_nsfs_files(systemd_hostnamed_t)
+ 
+ init_delete_runtime_files(systemd_hostnamed_t)
+ init_read_runtime_files(systemd_hostnamed_t)
+@@ -1705,6 +1706,7 @@ manage_files_pattern(systemd_rfkill_t, systemd_rfkill_var_lib_t, systemd_rfkill_
+ init_var_lib_filetrans(systemd_rfkill_t, systemd_rfkill_var_lib_t, dir)
+ 
+ fs_getattr_all_fs(systemd_rfkill_t)
++fs_getattr_nsfs_files(systemd_rfkill_t)
+ 
+ kernel_getattr_proc(systemd_rfkill_t)
+ kernel_read_kernel_sysctls(systemd_rfkill_t)
+@@ -1930,6 +1932,9 @@ kernel_getattr_proc(systemd_tmpfiles_t)
+ kernel_read_kernel_sysctls(systemd_tmpfiles_t)
+ kernel_read_network_state(systemd_tmpfiles_t)
+ 
++# Allow to read bin_t symlink under /etc/profile.d/
++fs_read_bin_symlinks(systemd_tmpfiles_t)
++
+ dev_getattr_fs(systemd_tmpfiles_t)
+ dev_manage_all_dev_nodes(systemd_tmpfiles_t)
+ dev_read_urand(systemd_tmpfiles_t)
+-- 
+2.25.1
+
diff --git a/recipes-security/refpolicy/refpolicy/0041-policy-modules-system-mount-make-mount_t-domain-MLS-.patch b/recipes-security/refpolicy/refpolicy/0042-policy-modules-system-mount-make-mount_t-domain-MLS-.patch
similarity index 85%
rename from recipes-security/refpolicy/refpolicy/0041-policy-modules-system-mount-make-mount_t-domain-MLS-.patch
rename to recipes-security/refpolicy/refpolicy/0042-policy-modules-system-mount-make-mount_t-domain-MLS-.patch
index 93a52fd..43d4e83 100644
--- a/recipes-security/refpolicy/refpolicy/0041-policy-modules-system-mount-make-mount_t-domain-MLS-.patch
+++ b/recipes-security/refpolicy/refpolicy/0042-policy-modules-system-mount-make-mount_t-domain-MLS-.patch
@@ -1,4 +1,4 @@
-From fe5fe08deab5f02a3609e5333e09e5e3af05140a Mon Sep 17 00:00:00 2001
+From 87ebadc702f2e3de7c4a8470cffde09a53c8fb8f Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Sat, 15 Feb 2014 04:22:47 -0500
 Subject: [PATCH] policy/modules/system/mount: make mount_t domain MLS trusted
@@ -19,10 +19,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/mount.te b/policy/modules/system/mount.te
-index d9e431a84..20d6aaba1 100644
+index c5727585c..71ff4efd1 100644
 --- a/policy/modules/system/mount.te
 +++ b/policy/modules/system/mount.te
-@@ -118,6 +118,7 @@ fs_dontaudit_write_all_image_files(mount_t)
+@@ -119,6 +119,7 @@ fs_dontaudit_write_all_image_files(mount_t)
  
  mls_file_read_all_levels(mount_t)
  mls_file_write_all_levels(mount_t)
diff --git a/recipes-security/refpolicy/refpolicy/0042-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch b/recipes-security/refpolicy/refpolicy/0043-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch
similarity index 92%
rename from recipes-security/refpolicy/refpolicy/0042-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch
rename to recipes-security/refpolicy/refpolicy/0043-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch
index 2e7a206..079510c 100644
--- a/recipes-security/refpolicy/refpolicy/0042-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch
+++ b/recipes-security/refpolicy/refpolicy/0043-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch
@@ -1,4 +1,4 @@
-From 7a0339aeba7cfe38b62c81ee4074446bba60e801 Mon Sep 17 00:00:00 2001
+From 4cb4afe1def20e106b0cbac0fb686c28a95ac6d7 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Mon, 28 Jan 2019 14:05:18 +0800
 Subject: [PATCH] policy/modules/roles/sysadm: MLS - sysadm rw to clearance
@@ -23,7 +23,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/roles/sysadm.te b/policy/modules/roles/sysadm.te
-index af5ccca9d..10cebdc53 100644
+index 0c96829a9..5fbcc7204 100644
 --- a/policy/modules/roles/sysadm.te
 +++ b/policy/modules/roles/sysadm.te
 @@ -48,6 +48,8 @@ logging_watch_all_logs(sysadm_t)
diff --git a/recipes-security/refpolicy/refpolicy/0043-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch b/recipes-security/refpolicy/refpolicy/0044-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch
similarity index 90%
rename from recipes-security/refpolicy/refpolicy/0043-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch
rename to recipes-security/refpolicy/refpolicy/0044-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch
index e37db1b..63e32ec 100644
--- a/recipes-security/refpolicy/refpolicy/0043-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch
+++ b/recipes-security/refpolicy/refpolicy/0044-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch
@@ -1,4 +1,4 @@
-From a563f59fe223aa9c74df7a482b5da80ce05fbbf5 Mon Sep 17 00:00:00 2001
+From 7feb72e30444b314c0bf3ca400375b2486d0e7c9 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Fri, 23 Aug 2013 12:01:53 +0800
 Subject: [PATCH] policy/modules/services/rpc: make nfsd_t domain MLS trusted
@@ -15,10 +15,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  2 files changed, 7 insertions(+)
 
 diff --git a/policy/modules/kernel/kernel.te b/policy/modules/kernel/kernel.te
-index 8fd1875d3..6c35a2374 100644
+index 65c814a97..da264d081 100644
 --- a/policy/modules/kernel/kernel.te
 +++ b/policy/modules/kernel/kernel.te
-@@ -381,6 +381,8 @@ mls_process_read_all_levels(kernel_t)
+@@ -378,6 +378,8 @@ mls_process_read_all_levels(kernel_t)
  mls_process_write_all_levels(kernel_t)
  mls_file_write_all_levels(kernel_t)
  mls_file_read_all_levels(kernel_t)
diff --git a/recipes-security/refpolicy/refpolicy/0044-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch b/recipes-security/refpolicy/refpolicy/0045-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch
similarity index 94%
rename from recipes-security/refpolicy/refpolicy/0044-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch
rename to recipes-security/refpolicy/refpolicy/0045-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch
index 7990e3f..9f53ba7 100644
--- a/recipes-security/refpolicy/refpolicy/0044-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch
+++ b/recipes-security/refpolicy/refpolicy/0045-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch
@@ -1,4 +1,4 @@
-From 6bd19ab1f6adac7722ef35c70982efea04b5d91f Mon Sep 17 00:00:00 2001
+From 929d814365465704142aaa3eaa80abad6d03efde Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 30 Jun 2020 10:18:20 +0800
 Subject: [PATCH] policy/modules/admin/dmesg: make dmesg_t MLS trusted reading
diff --git a/recipes-security/refpolicy/refpolicy/0045-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch b/recipes-security/refpolicy/refpolicy/0046-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
similarity index 95%
rename from recipes-security/refpolicy/refpolicy/0045-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
rename to recipes-security/refpolicy/refpolicy/0046-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
index cc603e6..2073395 100644
--- a/recipes-security/refpolicy/refpolicy/0045-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
+++ b/recipes-security/refpolicy/refpolicy/0046-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
@@ -1,4 +1,4 @@
-From a196f11f4a7f2f96cbf05614513204ca17aa0691 Mon Sep 17 00:00:00 2001
+From 6ebec2a77b771cfcac8a7320eae7a9abde7cfc3a Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Fri, 13 Oct 2017 07:20:40 +0000
 Subject: [PATCH] policy/modules/kernel/kernel: make kernel_t MLS trusted for
@@ -59,10 +59,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/kernel/kernel.te b/policy/modules/kernel/kernel.te
-index 6c35a2374..ebde22e02 100644
+index da264d081..e84bcf2b6 100644
 --- a/policy/modules/kernel/kernel.te
 +++ b/policy/modules/kernel/kernel.te
-@@ -383,6 +383,8 @@ mls_file_write_all_levels(kernel_t)
+@@ -380,6 +380,8 @@ mls_file_write_all_levels(kernel_t)
  mls_file_read_all_levels(kernel_t)
  mls_socket_write_all_levels(kernel_t)
  mls_fd_use_all_levels(kernel_t)
diff --git a/recipes-security/refpolicy/refpolicy/0046-policy-modules-system-init-make-init_t-MLS-trusted-f.patch b/recipes-security/refpolicy/refpolicy/0047-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
similarity index 90%
rename from recipes-security/refpolicy/refpolicy/0046-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
rename to recipes-security/refpolicy/refpolicy/0047-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
index 95896b2..85095df 100644
--- a/recipes-security/refpolicy/refpolicy/0046-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
+++ b/recipes-security/refpolicy/refpolicy/0047-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
@@ -1,4 +1,4 @@
-From 777e396d61c3af7b847fcc9ebc490f1e5f3969b9 Mon Sep 17 00:00:00 2001
+From 93936c7a0cf671f463b5d3360c6c906df4028e33 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Fri, 15 Jan 2016 03:47:05 -0500
 Subject: [PATCH] policy/modules/system/init: make init_t MLS trusted for
@@ -27,10 +27,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 4 insertions(+)
 
 diff --git a/policy/modules/system/init.te b/policy/modules/system/init.te
-index e724c295e..6ffdb547f 100644
+index 43d62b2e1..039272004 100644
 --- a/policy/modules/system/init.te
 +++ b/policy/modules/system/init.te
-@@ -238,6 +238,10 @@ mls_process_write_all_levels(init_t)
+@@ -239,6 +239,10 @@ mls_process_write_all_levels(init_t)
  mls_fd_use_all_levels(init_t)
  mls_process_set_level(init_t)
  
diff --git a/recipes-security/refpolicy/refpolicy/0047-policy-modules-system-systemd-make-systemd-tmpfiles_.patch b/recipes-security/refpolicy/refpolicy/0048-policy-modules-system-systemd-make-systemd-tmpfiles_.patch
similarity index 92%
rename from recipes-security/refpolicy/refpolicy/0047-policy-modules-system-systemd-make-systemd-tmpfiles_.patch
rename to recipes-security/refpolicy/refpolicy/0048-policy-modules-system-systemd-make-systemd-tmpfiles_.patch
index 8b57c70..fd4d1fe 100644
--- a/recipes-security/refpolicy/refpolicy/0047-policy-modules-system-systemd-make-systemd-tmpfiles_.patch
+++ b/recipes-security/refpolicy/refpolicy/0048-policy-modules-system-systemd-make-systemd-tmpfiles_.patch
@@ -1,4 +1,4 @@
-From f87ab013d4dffe5b588376b73c51fbfc5e9b1205 Mon Sep 17 00:00:00 2001
+From a698845641cf86d0cdcab4b014b14757fbc0a605 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Thu, 4 Feb 2016 06:03:19 -0500
 Subject: [PATCH] policy/modules/system/systemd: make systemd-tmpfiles_t domain
@@ -43,10 +43,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 5 insertions(+)
 
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index 24fc90838..dc3badece 100644
+index c605d58de..fb75c2f45 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -1970,6 +1970,11 @@ sysnet_relabel_config(systemd_tmpfiles_t)
+@@ -2024,6 +2024,11 @@ sysnet_relabel_config(systemd_tmpfiles_t)
  
  systemd_log_parse_environment(systemd_tmpfiles_t)
  
diff --git a/recipes-security/refpolicy/refpolicy/0048-policy-modules-system-systemd-systemd-make-systemd_-.patch b/recipes-security/refpolicy/refpolicy/0049-policy-modules-system-systemd-systemd-make-systemd_-.patch
similarity index 88%
rename from recipes-security/refpolicy/refpolicy/0048-policy-modules-system-systemd-systemd-make-systemd_-.patch
rename to recipes-security/refpolicy/refpolicy/0049-policy-modules-system-systemd-systemd-make-systemd_-.patch
index c4b799e..c8cf04a 100644
--- a/recipes-security/refpolicy/refpolicy/0048-policy-modules-system-systemd-systemd-make-systemd_-.patch
+++ b/recipes-security/refpolicy/refpolicy/0049-policy-modules-system-systemd-systemd-make-systemd_-.patch
@@ -1,4 +1,4 @@
-From ec080f2b0b18b29e46bded08a0880624e5380026 Mon Sep 17 00:00:00 2001
+From f70cd58e286d417f9024b23056234038629bb75f Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Thu, 18 Jun 2020 09:59:58 +0800
 Subject: [PATCH] policy/modules/system/systemd: systemd-*: make systemd_*_t
@@ -43,10 +43,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 12 insertions(+)
 
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index dc3badece..0440b4795 100644
+index fb75c2f45..45d4db784 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -430,6 +430,9 @@ files_search_var_lib(systemd_backlight_t)
+@@ -439,6 +439,9 @@ files_search_var_lib(systemd_backlight_t)
  fs_getattr_all_fs(systemd_backlight_t)
  fs_search_cgroup_dirs(systemd_backlight_t)
  
@@ -56,7 +56,7 @@ index dc3badece..0440b4795 100644
  #######################################
  #
  # Binfmt local policy
-@@ -603,6 +606,9 @@ term_use_unallocated_ttys(systemd_generator_t)
+@@ -616,6 +619,9 @@ term_use_unallocated_ttys(systemd_generator_t)
  
  udev_read_runtime_files(systemd_generator_t)
  
@@ -66,9 +66,9 @@ index dc3badece..0440b4795 100644
  ifdef(`distro_gentoo',`
  	corecmd_shell_entry_type(systemd_generator_t)
  ')
-@@ -1058,6 +1064,9 @@ userdom_setattr_user_ttys(systemd_logind_t)
+@@ -1093,6 +1099,9 @@ userdom_relabelto_user_runtime_dirs(systemd_logind_t)
+ userdom_setattr_user_ttys(systemd_logind_t)
  userdom_use_user_ttys(systemd_logind_t)
- domain_read_all_domains_state(systemd_logind_t)
  
 +mls_file_read_all_levels(systemd_logind_t)
 +mls_file_write_all_levels(systemd_logind_t)
@@ -76,7 +76,7 @@ index dc3badece..0440b4795 100644
  # Needed to work around patch not yet merged into the systemd-logind supported on RHEL 7.x
  # The change in systemd by Nicolas Iooss on 02-Feb-2016 with hash 4b51966cf6c06250036e428608da92f8640beb96
  # should fix the problem where user directories in /run/user/$UID/ are not getting the proper context
-@@ -1681,6 +1690,9 @@ udev_read_runtime_files(systemd_rfkill_t)
+@@ -1722,6 +1731,9 @@ udev_read_runtime_files(systemd_rfkill_t)
  
  systemd_log_parse_environment(systemd_rfkill_t)
  
diff --git a/recipes-security/refpolicy/refpolicy/0049-policy-modules-system-logging-add-the-syslogd_t-to-t.patch b/recipes-security/refpolicy/refpolicy/0050-policy-modules-system-logging-add-the-syslogd_t-to-t.patch
similarity index 92%
rename from recipes-security/refpolicy/refpolicy/0049-policy-modules-system-logging-add-the-syslogd_t-to-t.patch
rename to recipes-security/refpolicy/refpolicy/0050-policy-modules-system-logging-add-the-syslogd_t-to-t.patch
index 06e4775..4b70735 100644
--- a/recipes-security/refpolicy/refpolicy/0049-policy-modules-system-logging-add-the-syslogd_t-to-t.patch
+++ b/recipes-security/refpolicy/refpolicy/0050-policy-modules-system-logging-add-the-syslogd_t-to-t.patch
@@ -1,4 +1,4 @@
-From 564d43016ed6dcbadb7a7203d8d639d0c782d4e7 Mon Sep 17 00:00:00 2001
+From 25be898844c76cba143de013c05966258e0ec98d Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/system/logging: add the syslogd_t to trusted
@@ -18,7 +18,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 3 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index dca46f105..cedcaeb36 100644
+index dbb9c62c9..9659937fe 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -495,6 +495,9 @@ fs_list_tmpfs(syslogd_t)
diff --git a/recipes-security/refpolicy/refpolicy/0050-policy-modules-system-init-make-init_t-MLS-trusted-f.patch b/recipes-security/refpolicy/refpolicy/0051-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
similarity index 86%
rename from recipes-security/refpolicy/refpolicy/0050-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
rename to recipes-security/refpolicy/refpolicy/0051-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
index 1a0aded..179fc54 100644
--- a/recipes-security/refpolicy/refpolicy/0050-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
+++ b/recipes-security/refpolicy/refpolicy/0051-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
@@ -1,4 +1,4 @@
-From c49b89d2a6cfc33c0e6fe6347609fea09ae7fe2e Mon Sep 17 00:00:00 2001
+From ba07393b28fd2459a6ae7e4c50a48d1ee954360e Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 28 May 2019 16:41:37 +0800
 Subject: [PATCH] policy/modules/system/init: make init_t MLS trusted for
@@ -17,10 +17,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/init.te b/policy/modules/system/init.te
-index 6ffdb547f..8bd8e2f63 100644
+index 039272004..0a7add4b7 100644
 --- a/policy/modules/system/init.te
 +++ b/policy/modules/system/init.te
-@@ -237,6 +237,7 @@ mls_file_write_all_levels(init_t)
+@@ -238,6 +238,7 @@ mls_file_write_all_levels(init_t)
  mls_process_write_all_levels(init_t)
  mls_fd_use_all_levels(init_t)
  mls_process_set_level(init_t)
diff --git a/recipes-security/refpolicy/refpolicy/0051-policy-modules-system-init-all-init_t-to-read-any-le.patch b/recipes-security/refpolicy/refpolicy/0052-policy-modules-system-init-all-init_t-to-read-any-le.patch
similarity index 88%
rename from recipes-security/refpolicy/refpolicy/0051-policy-modules-system-init-all-init_t-to-read-any-le.patch
rename to recipes-security/refpolicy/refpolicy/0052-policy-modules-system-init-all-init_t-to-read-any-le.patch
index a362c4b..afce2c0 100644
--- a/recipes-security/refpolicy/refpolicy/0051-policy-modules-system-init-all-init_t-to-read-any-le.patch
+++ b/recipes-security/refpolicy/refpolicy/0052-policy-modules-system-init-all-init_t-to-read-any-le.patch
@@ -1,4 +1,4 @@
-From f8b5f66dd987609027d8e0381338e39b52a47138 Mon Sep 17 00:00:00 2001
+From a01c52188566c4148862076dae90baa265e985df Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Wed, 3 Feb 2016 04:16:06 -0500
 Subject: [PATCH] policy/modules/system/init: all init_t to read any level
@@ -22,10 +22,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 3 insertions(+)
 
 diff --git a/policy/modules/system/init.te b/policy/modules/system/init.te
-index 8bd8e2f63..8af34aa7e 100644
+index 0a7add4b7..7df44cead 100644
 --- a/policy/modules/system/init.te
 +++ b/policy/modules/system/init.te
-@@ -243,6 +243,9 @@ mls_key_write_all_levels(init_t)
+@@ -244,6 +244,9 @@ mls_key_write_all_levels(init_t)
  mls_file_downgrade(init_t)
  mls_file_upgrade(init_t)
  
diff --git a/recipes-security/refpolicy/refpolicy/0052-policy-modules-system-logging-allow-auditd_t-to-writ.patch b/recipes-security/refpolicy/refpolicy/0053-policy-modules-system-logging-allow-auditd_t-to-writ.patch
similarity index 92%
rename from recipes-security/refpolicy/refpolicy/0052-policy-modules-system-logging-allow-auditd_t-to-writ.patch
rename to recipes-security/refpolicy/refpolicy/0053-policy-modules-system-logging-allow-auditd_t-to-writ.patch
index a5a368b..ce77779 100644
--- a/recipes-security/refpolicy/refpolicy/0052-policy-modules-system-logging-allow-auditd_t-to-writ.patch
+++ b/recipes-security/refpolicy/refpolicy/0053-policy-modules-system-logging-allow-auditd_t-to-writ.patch
@@ -1,4 +1,4 @@
-From d6573102f922b0e08d49cb5582612dfbaae10600 Mon Sep 17 00:00:00 2001
+From dfc4e8ef225a6ce97ef4862b608228440d099863 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Thu, 25 Feb 2016 04:25:08 -0500
 Subject: [PATCH] policy/modules/system/logging: allow auditd_t to write socket
@@ -22,7 +22,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index cedcaeb36..1b181f7cc 100644
+index 9659937fe..2c733c0f2 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -236,6 +236,8 @@ miscfiles_read_localization(auditd_t)
diff --git a/recipes-security/refpolicy/refpolicy/0053-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch b/recipes-security/refpolicy/refpolicy/0054-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
similarity index 84%
rename from recipes-security/refpolicy/refpolicy/0053-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
rename to recipes-security/refpolicy/refpolicy/0054-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
index d48db28..b0af22d 100644
--- a/recipes-security/refpolicy/refpolicy/0053-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
+++ b/recipes-security/refpolicy/refpolicy/0054-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
@@ -1,4 +1,4 @@
-From 6b77c79af18f6dba52b7a63a7a2aefdd48c0fd33 Mon Sep 17 00:00:00 2001
+From f26d8ea933ef3f6fe72fbded8d1f6b683c135ab9 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Thu, 31 Oct 2019 17:35:59 +0800
 Subject: [PATCH] policy/modules/kernel/kernel: make kernel_t MLS trusted for
@@ -15,10 +15,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/kernel/kernel.te b/policy/modules/kernel/kernel.te
-index ebde22e02..60e805cb8 100644
+index e84bcf2b6..987709345 100644
 --- a/policy/modules/kernel/kernel.te
 +++ b/policy/modules/kernel/kernel.te
-@@ -385,6 +385,7 @@ mls_socket_write_all_levels(kernel_t)
+@@ -382,6 +382,7 @@ mls_socket_write_all_levels(kernel_t)
  mls_fd_use_all_levels(kernel_t)
  # https://bugzilla.redhat.com/show_bug.cgi?id=667370
  mls_file_downgrade(kernel_t)
diff --git a/recipes-security/refpolicy/refpolicy/0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch b/recipes-security/refpolicy/refpolicy/0055-policy-modules-system-setrans-allow-setrans_t-use-fd.patch
similarity index 93%
rename from recipes-security/refpolicy/refpolicy/0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch
rename to recipes-security/refpolicy/refpolicy/0055-policy-modules-system-setrans-allow-setrans_t-use-fd.patch
index a5c17de..d415fa2 100644
--- a/recipes-security/refpolicy/refpolicy/0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch
+++ b/recipes-security/refpolicy/refpolicy/0055-policy-modules-system-setrans-allow-setrans_t-use-fd.patch
@@ -1,4 +1,4 @@
-From 03e4c0afc4a0aa432b30e9b5e8abbe069871fb9e Mon Sep 17 00:00:00 2001
+From 44aada7fe60d66a45fdcb9b1e5039365cf2b962b Mon Sep 17 00:00:00 2001
 From: Roy Li <rongqing.li@windriver.com>
 Date: Sat, 22 Feb 2014 13:35:38 +0800
 Subject: [PATCH] policy/modules/system/setrans: allow setrans_t use fd at any
diff --git a/recipes-security/refpolicy/refpolicy/0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch b/recipes-security/refpolicy/refpolicy/0056-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch
similarity index 88%
rename from recipes-security/refpolicy/refpolicy/0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch
rename to recipes-security/refpolicy/refpolicy/0056-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch
index 9e46a43..bd629fe 100644
--- a/recipes-security/refpolicy/refpolicy/0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch
+++ b/recipes-security/refpolicy/refpolicy/0056-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch
@@ -1,4 +1,4 @@
-From 1ca4caa4600e9b742f0c7816efe8cff153fe412a Mon Sep 17 00:00:00 2001
+From 115135e6809b715df2b382bf9e35eef3e09be311 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Mon, 22 Feb 2021 11:28:12 +0800
 Subject: [PATCH] policy/modules/system/systemd: make *_systemd_t MLS trusted
@@ -24,10 +24,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 3 insertions(+)
 
 diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
-index 96b5d31b4..07c506e1c 100644
+index 7654d1076..22d5e2b18 100644
 --- a/policy/modules/system/systemd.if
 +++ b/policy/modules/system/systemd.if
-@@ -228,6 +228,9 @@ template(`systemd_role_template',`
+@@ -235,6 +235,9 @@ template(`systemd_role_template',`
  		xdg_read_config_files($1_systemd_t)
  		xdg_read_data_files($1_systemd_t)
  	')
diff --git a/recipes-security/refpolicy/refpolicy/0056-policy-modules-system-logging-make-syslogd_runtime_t.patch b/recipes-security/refpolicy/refpolicy/0057-policy-modules-system-logging-make-syslogd_runtime_t.patch
similarity index 94%
rename from recipes-security/refpolicy/refpolicy/0056-policy-modules-system-logging-make-syslogd_runtime_t.patch
rename to recipes-security/refpolicy/refpolicy/0057-policy-modules-system-logging-make-syslogd_runtime_t.patch
index cc8a416..256fa50 100644
--- a/recipes-security/refpolicy/refpolicy/0056-policy-modules-system-logging-make-syslogd_runtime_t.patch
+++ b/recipes-security/refpolicy/refpolicy/0057-policy-modules-system-logging-make-syslogd_runtime_t.patch
@@ -1,4 +1,4 @@
-From 8e5a17676c9976d163b70edd31834c4e16405ed9 Mon Sep 17 00:00:00 2001
+From 17f0718ec39892d411d2cbe029864167d5d191a2 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Sat, 18 Dec 2021 17:31:45 +0800
 Subject: [PATCH] policy/modules/system/logging: make syslogd_runtime_t MLS
@@ -31,7 +31,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index 1b181f7cc..d5878876b 100644
+index 2c733c0f2..c758dbff0 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -459,6 +459,8 @@ allow syslogd_t syslogd_runtime_t:file map;
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index f8e5f10..0661e6c 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -50,28 +50,29 @@ SRC_URI += " \
         file://0032-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch \
         file://0033-policy-modules-system-systemd-enable-support-for-sys.patch \
         file://0034-policy-modules-system-logging-allow-systemd-tmpfiles.patch \
-        file://0035-policy-modules-system-systemd-allow-systemd_logind_t.patch \
-        file://0036-policy-modules-roles-sysadm-allow-sysadm-to-use-init.patch \
-        file://0037-policy-modules-system-systemd-systemd-user-fixes.patch \
-        file://0038-policy-modules-system-logging-grant-getpcap-capabili.patch \
-        file://0039-policy-modules-system-allow-services-to-read-tmpfs-u.patch \
-        file://0040-policy-modules-kernel-domain-allow-all-domains-to-co.patch \
-        file://0041-policy-modules-system-mount-make-mount_t-domain-MLS-.patch \
-        file://0042-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch \
-        file://0043-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch \
-        file://0044-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch \
-        file://0045-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch \
-        file://0046-policy-modules-system-init-make-init_t-MLS-trusted-f.patch \
-        file://0047-policy-modules-system-systemd-make-systemd-tmpfiles_.patch \
-        file://0048-policy-modules-system-systemd-systemd-make-systemd_-.patch \
-        file://0049-policy-modules-system-logging-add-the-syslogd_t-to-t.patch \
-        file://0050-policy-modules-system-init-make-init_t-MLS-trusted-f.patch \
-        file://0051-policy-modules-system-init-all-init_t-to-read-any-le.patch \
-        file://0052-policy-modules-system-logging-allow-auditd_t-to-writ.patch \
-        file://0053-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch \
-        file://0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
-        file://0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
-        file://0056-policy-modules-system-logging-make-syslogd_runtime_t.patch \
+        file://0035-policy-modules-roles-sysadm-allow-sysadm-to-use-init.patch \
+        file://0036-policy-modules-system-systemd-systemd-user-fixes.patch \
+        file://0037-policy-modules-system-logging-grant-getpcap-capabili.patch \
+        file://0038-policy-modules-system-allow-services-to-read-tmpfs-u.patch \
+        file://0039-policy-modules-kernel-domain-allow-all-domains-to-co.patch \
+        file://0040-systemd-allow-systemd-logind-to-inherit-fds.patch \
+        file://0041-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch \
+        file://0042-policy-modules-system-mount-make-mount_t-domain-MLS-.patch \
+        file://0043-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch \
+        file://0044-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch \
+        file://0045-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch \
+        file://0046-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch \
+        file://0047-policy-modules-system-init-make-init_t-MLS-trusted-f.patch \
+        file://0048-policy-modules-system-systemd-make-systemd-tmpfiles_.patch \
+        file://0049-policy-modules-system-systemd-systemd-make-systemd_-.patch \
+        file://0050-policy-modules-system-logging-add-the-syslogd_t-to-t.patch \
+        file://0051-policy-modules-system-init-make-init_t-MLS-trusted-f.patch \
+        file://0052-policy-modules-system-init-all-init_t-to-read-any-le.patch \
+        file://0053-policy-modules-system-logging-allow-auditd_t-to-writ.patch \
+        file://0054-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch \
+        file://0055-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
+        file://0056-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
+        file://0057-policy-modules-system-logging-make-syslogd_runtime_t.patch \
         "
 
 S = "${WORKDIR}/refpolicy"
diff --git a/recipes-security/refpolicy/refpolicy_git.inc b/recipes-security/refpolicy/refpolicy_git.inc
index 22f28ba..94b3379 100644
--- a/recipes-security/refpolicy/refpolicy_git.inc
+++ b/recipes-security/refpolicy/refpolicy_git.inc
@@ -1,8 +1,8 @@
-PV = "2.20240916+git"
+PV = "2.20250213+git"
 
 SRC_URI = "git://github.com/SELinuxProject/refpolicy.git;protocol=https;branch=main;name=refpolicy;destsuffix=refpolicy"
 
-SRCREV_refpolicy ?= "741dc96eb7e737bc2f00b7f4b4b394a66d32d913"
+SRCREV_refpolicy = "badb91ce49e20449b1a73cd98dc9250b622ed369"
 
 UPSTREAM_CHECK_GITTAGREGEX = "RELEASE_(?P<pver>\d+_\d+)"
 
-- 
2.25.1


