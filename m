Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8D6CED267
	for <webhook@archiver.kernel.org>; Tue,  8 Oct 2024 04:44:19 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.1571.1728362653634827734
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Oct 2024 21:44:13 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=001105f10e=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4984YWHi002466;
	Tue, 8 Oct 2024 04:44:11 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 422ve8tr8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 04:44:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qChE2YyBW9KSRGVrLkXSI4Pnk76doHcGNnut9OU5sK+uUoq+mghhhhRC9ceINdgErm6N3Ka0Hp7dwbD/H4esHgR7ceABxNGGobttURwiu9KZ4OKGV721ygQxvZ8LATeXTNywy5rqGGCAYNzrw/iGmy2qFeZehUCkgaH++24Kwj9AnTKVBwAAzeY2Tdrj4eVkf4S2qNFEsPEXqJP2DCrumNemGL9wZnuWDp0N2bL8vuExPwdC/zse4+CQUqdq+wAvd2DYBI+1ecDYZacw7MY1rIPtBTUFKfQodiQGcSuSp0CPuU7XIXkv/dPBTIkOEi2/itEbL1S2UsKVI9zdV0VCMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/RsUqpMLddnUJVabnv5ew6gjliNqWvazrtz7cGKqCw=;
 b=izu8iTTFgi5eu8aEKuTE8K++CieqC0FpL81IvoelFCziVII9DCPeKWUcI9HdDzsJkbk2+UBsgkU/XYfhUkyDyy+uWJG4Rh78zelLUfoeOj5cNwxq6Yf0nLsGgGhJ8itQhLE0opfDTr3oUTeXydDpQstcwho0z2PJvMrl1y8Fa0mdaLD/uvm3MYgQS85nsKJ1rQmmSUGAr+3DSK5bETITGht+cqJJ/3Z+3IBFg6IG+iIzfqakCD3zROsbiELelMV/izpqzPkhnTlI8QWN4azuLT4ejX/RcA94p8seHIMTtuqsAOg6r0NhjN7jGmQ+GMt1gL6n1Hw1p6AyuP6qQ4RGoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 MW4PR11MB6716.namprd11.prod.outlook.com (2603:10b6:303:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 04:44:07 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%5]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 04:44:07 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org, joe@deserted.net,
        joe.macdonald@siemens.com
Subject: [meta-selinux][PATCH] refpolicy: upgrade 20240226+git -> 20240916+git
Date: Tue,  8 Oct 2024 12:43:57 +0800
Message-Id: <20241008044357.182503-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:404:f6::27) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|MW4PR11MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: 303b9fc3-06a0-44ae-29c9-08dce753d7ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?TByfVy9lI35T9CaPDn9wi6UbPQMa+aN2eFe668Ik2lPxMUY9f1DkALsVC5z3?=
 =?us-ascii?Q?n7yliEFZFlQ5Wejiv4nPo8LtqbGMetSFqxDB/G3ABFv/BdNTH9ct3dxG/4wo?=
 =?us-ascii?Q?I/eD5Kx55ShCHC9tDs+1AKfSGejGby7CnlOfs42+PUiOHrIr0HYI1s1EpxPn?=
 =?us-ascii?Q?ich4tj3aJWf/tgfZX8GYbRgHN2YkTA/6gSyRoVer5ZSuVpLUU+eujnlJoERw?=
 =?us-ascii?Q?81HAjcoNMZfAXN4aSaCJTyzG7QlzVKDR3lLqx6QwICh0nqcyFTsOlsZ1jpZr?=
 =?us-ascii?Q?6VT3JCUErT8JvvvaS8DN8P/cTD7tBYCKVYC9PEVpNElnE/G5IFJQxa0zgSvP?=
 =?us-ascii?Q?VuatixBvG3Tm5Qpf0gnZ/XBrOTrRnXbMNH37sLj/0/i3gz7DlXQVq919DV1+?=
 =?us-ascii?Q?colptv7I999tCABZxhcx2tJZldQ8bnVRMmGJb+SnfxEOPHZIViuwHi5sZpIR?=
 =?us-ascii?Q?lNoIw77QRSQPtuWQe8zGzAplqW5jFAs0YLBgbvVSYh3xMmxKLpIggfkfkH2T?=
 =?us-ascii?Q?NSPTRvMvV/75ilPJuLu8DncXk771LQJV2QjDWBokC3w+illDY/WF0c5OjUSW?=
 =?us-ascii?Q?UJfTK+X+U8fnhiESKkoAvHnmge2c7StgtLJrR8udpH4pbXZKXNhDzuHv/bSv?=
 =?us-ascii?Q?Xsx0KABbkGyOGr8DYAd+CsYGw7MRIo8QMo+tzKLTc2cMl4RaU52U3vVIrW4W?=
 =?us-ascii?Q?QTMHUJ33Qv+yrzr59QLpSL/FjXr9EI+IYm4176PaNyjCaiPyVaWGfSC3KYEV?=
 =?us-ascii?Q?/Grb/OcSXCXi4PWG74IwxKBkfgOgUkIO/lIB1Sp12AsrdkfO0pKQ2aaUFCdl?=
 =?us-ascii?Q?sDVc8cufxXr2pNFKqmAA51VJb4yzBgQGWpes7U0ar91+j9R3DgcAd9IOPf5A?=
 =?us-ascii?Q?xKceETlSs5nVb0SbT7fsU+l6AU7nyIwQa4Sme0uRZKofkriilAjFYk9MB6cZ?=
 =?us-ascii?Q?Fk6O68sg0UwYhMoEpWeAwpJxOJyPMfI1ieAg1YhpWGqejQT8WzAa+aLohbSd?=
 =?us-ascii?Q?WE2cH6gBObtZ1XepMIzjvSDBQZN8EVJAirw3GQFvMcJ/Gawi89YeiLS67shC?=
 =?us-ascii?Q?/U7OLgbyiBL0waeRqP5U7RZ/NZYKSmiFHAXLzaO68P8zS4gq0qAwFyKQoT4l?=
 =?us-ascii?Q?RrCklIH0OFsPX7yTAKfZl38ibDAWQNFMoqNn9SmKq50+Rdi57gRqIWiex0m0?=
 =?us-ascii?Q?lk+FpoCyclExBJZxL1VnfssHZvSkAKSpHlvS1LHoXNWtaft+zGLL13LTAj9h?=
 =?us-ascii?Q?fw3TVw+fPHobTfJ2Km54kdjIy+1eLcbTa7ABzmbyQC2uWFvWEkQtkevuMbaM?=
 =?us-ascii?Q?+hI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KbyWVzj0zcnn+EO5+q0wA2MLFB2+c8GFv5tQOomSw1xeW5FpeABVPb5PDYRu?=
 =?us-ascii?Q?fLajdhAPJazheeJNV6ESDYgvOlpMp1exjs+xJdq6+f2jhN2AlE2zsc8EzEI7?=
 =?us-ascii?Q?/z9aNQ0Y2I7Wjv545swlUWN7lBNhmz4dKZ7YtXFtQwZxKqDLyHHX3zP+byxu?=
 =?us-ascii?Q?S0IQssfgRY9/snygOcJjIeMeL0SkbJsMsVIFHPdaIjYfI+7wgwA8hkbOrET0?=
 =?us-ascii?Q?j4OJD9LTM0tVLFeqPLKLmUAqtFjHP8nR2L+6RIH0coMyt6Gl6Yg/vvD6goak?=
 =?us-ascii?Q?eUDRnyAr4+gtZJfMTxmJveknMu4QpsUFFWWco+16w3XHvQ62u04AP3pa5Wp3?=
 =?us-ascii?Q?9arjYH2F/sEbb48z0ywvyx0kYN03GTbWrmfQ5XNTE3IrMag5xbrpuASX+A65?=
 =?us-ascii?Q?1MuwPlg/IA47ynfm15LZ9x+vjdDJMT9iT0TllLgeTp8/rSImjMOj+AlftsbC?=
 =?us-ascii?Q?tN6A+d+uY8+1cRcw0cDDbGH0F2RkJgjETc47hVC/j0GkaGOW6AVOuig10Z1/?=
 =?us-ascii?Q?wI2GLzAjSFfB+ozlX/mnytmU2WCCz+zDkAeVNMzqr9dpk5EODxyFzuq+Grtr?=
 =?us-ascii?Q?s9a0VZBJTXaGlY9BNeMpmfhyBmqHCbgGwlMirYUM1GREXLxkQM+FrT9pXubz?=
 =?us-ascii?Q?5bJzguZMCmzg8lvRlCeJ+5EQnJhw80+Xcwbp0+xcPNZFtuSZUiVsiTbLDfQX?=
 =?us-ascii?Q?NqrKi1MrPWgu+xvB8OOM8t4ISLtmm9wcilepNZO75xldATtRnD0Z+PYOCn/f?=
 =?us-ascii?Q?Cvg2akvUU7+nDilbTgtJ3l4ncvtkW7FS8bm6t+82RXo1zU1kS7A02fKIp3K8?=
 =?us-ascii?Q?btCBij3upzRgXVlAO0O6SsY1njuc4aOJ+xOAZFzIgGcqQ1IPCHgMIn7Bxqh6?=
 =?us-ascii?Q?oDxoWedy3s8HsWBuLbjFvbYKwFXTLIkVdtkFP0kXdPXi+SADZ0Thv76p8UWS?=
 =?us-ascii?Q?3uGqzVieDhP9ZCBojiBzaOIn5uy2S3JHnEWTXj79miZrekiXCIBSS/ZReBcs?=
 =?us-ascii?Q?k6dQtqHMrZ3/OomTpXTM1ExjqkqqozIySCjcjmxe9mvEopTwq584dBJ3Zbfq?=
 =?us-ascii?Q?S88QrlMSr6WV2aeD2v36vnIrWNI72X0pVUHO2NKt/+yQlemszHPljaop/tGT?=
 =?us-ascii?Q?5CE3not7g7xDoqrRmpPl7W1Offz8OM3n+yNB9IopWHGe650eVrwFMrW4hgQ+?=
 =?us-ascii?Q?WYyB+Zg9UxwwoFQEltIg4pXHKMb2hZvwx7jmEv0ZR8MD6cTHEPXJbaCfBJ76?=
 =?us-ascii?Q?e32hk8HWDtSmPZ7ATX7XZQEcABi9oubpwoKQgZndagOXSExsz798a/89VG9+?=
 =?us-ascii?Q?oH54hBOOnYQ96mZoeeiuOw7RP5WvDga/Lct+ly8KRYv++kXaOriwa2fMKBtY?=
 =?us-ascii?Q?9GKrpKQEHf0ayuHDeAWcqSXJs6WoArsEsgfyPBAf4mXnTJr3yuPtSHxxLyh9?=
 =?us-ascii?Q?JdNcqTmtXeVZppOw2C+YKjV9GEObDq4AP4FO+VSc3uwWVcbJcI+hZfevmCsT?=
 =?us-ascii?Q?jiqOV6UUeT2XYku8//uVKy66Ia00GuHW1X1ttue9EuXWdz+1AVZBzk0igDQf?=
 =?us-ascii?Q?t+3oKVeAeiqwoiG3swu45Miee8mC5ZvDt2/Xq5zt?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 303b9fc3-06a0-44ae-29c9-08dce753d7ec
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 04:44:07.5025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZUVO8cvoqIkguqj5hy3SdOBbEX3OeqfGxJb77/jqGhshz2+8CBNlJDyyLK0+0W9Z3uoAWFX5k2AQ5j+HqU1fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6716
X-Authority-Analysis: v=2.4 cv=CPp4XgrD c=1 sm=1 tr=0 ts=6704b89b cx=c_pps a=sGbpJkUcFVeWJOR+0qTsNQ==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=DAUX931o1VcA:10 a=bRTqI5nwn0kA:10 a=NEAV23lmAAAA:8 a=t7CeM3EgAAAA:8 a=9Wbp7B8dAAAA:8
 a=oZbWWg3rAAAA:8 a=20KFwNOVAAAA:8 a=ocwmDU9ZECeOF1oFSqgA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=BESxJfN36ujmTJQqZ0Zq:22 a=JYnrc9oPTx9ts3FRaIb5:22
X-Proofpoint-ORIG-GUID: hUM9lj8SxAebD_H8qVTWSlnbrq3NWyPN
X-Proofpoint-GUID: hUM9lj8SxAebD_H8qVTWSlnbrq3NWyPN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_03,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 impostorscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.21.0-2409260000
 definitions=main-2410080028
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 08 Oct 2024 04:44:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/692

ChangeLog:
https://github.com/SELinuxProject/refpolicy/releases/tag/RELEASE_2_20240916

Notable Changes
  Added sechecker configuration for GitHub CI actions.
  Cleaned up concerning permissions uncovered by sechecker
  Removed extremely deprecated domains in cups (ptal) and xen (xend/xm)
  Systemd updates up to v256
  Various container fixes

New Modules
  haproxy

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../refpolicy/refpolicy-minimum_git.bb        |  1 +
 ...tile-alias-common-var-volatile-paths.patch |  2 +-
 ...inimum-make-sysadmin-module-optional.patch |  8 ++--
 ...ed-make-unconfined_u-the-default-sel.patch |  4 +-
 ...box-set-aliases-for-bin-sbin-and-usr.patch |  2 +-
 ...efpolicy-minimum-enable-nscd_use_shm.patch | 47 +++++++++++++++++++
 ...y-policy-to-common-yocto-hostname-al.patch |  2 +-
 ...sr-bin-bash-context-to-bin-bash.bash.patch |  2 +-
 ...abel-resolv.conf-in-var-run-properly.patch |  6 +--
 ...-apply-login-context-to-login.shadow.patch |  4 +-
 ...-fc-hwclock-add-hwclock-alternatives.patch |  2 +-
 ...g-apply-policy-to-dmesg-alternatives.patch |  2 +-
 ...ssh-apply-policy-to-ssh-alternatives.patch |  4 +-
 ...ply-policy-to-network-commands-alter.patch |  8 ++--
 ...ply-rpm_exec-policy-to-cpio-binaries.patch |  2 +-
 ...c-su-apply-policy-to-su-alternatives.patch |  2 +-
 ...fc-fstools-fix-real-path-for-fstools.patch |  2 +-
 ...fix-update-alternatives-for-sysvinit.patch |  2 +-
 ...l-apply-policy-to-brctl-alternatives.patch |  2 +-
 ...apply-policy-to-nologin-alternatives.patch |  2 +-
 ...apply-policy-to-sulogin-alternatives.patch |  2 +-
 ...tp-apply-policy-to-ntpd-alternatives.patch |  2 +-
 ...pply-policy-to-kerberos-alternatives.patch |  2 +-
 ...ap-apply-policy-to-ldap-alternatives.patch |  2 +-
 ...ply-policy-to-postgresql-alternative.patch |  2 +-
 ...-apply-policy-to-screen-alternatives.patch |  2 +-
 ...ply-policy-to-usermanage-alternative.patch |  2 +-
 ...etty-add-file-context-to-start_getty.patch |  2 +-
 ...k-apply-policy-to-vlock-alternatives.patch |  2 +-
 ...for-init-scripts-and-systemd-service.patch |  2 +-
 ...bs_dist-set-aliase-for-root-director.patch |  2 +-
 ...ystem-logging-add-rules-for-the-syml.patch |  4 +-
 ...ystem-logging-add-rules-for-syslogd-.patch |  4 +-
 ...ernel-files-add-rules-for-the-symlin.patch | 20 ++++----
 ...ystem-logging-fix-auditd-startup-fai.patch |  4 +-
 ...ernel-terminal-don-t-audit-tty_devic.patch |  4 +-
 ...stem-systemd-enable-support-for-sys.patch} |  4 +-
 ...stem-logging-allow-systemd-tmpfiles.patch} |  4 +-
 ...stem-systemd-allow-systemd_logind_t.patch} |  6 +--
 ...les-sysadm-allow-sysadm-to-use-init.patch} |  4 +-
 ...s-system-systemd-systemd-user-fixes.patch} | 10 ++--
 ...stem-logging-grant-getpcap-capabili.patch} |  6 +--
 ...stem-allow-services-to-read-tmpfs-u.patch} | 13 ++---
 ...ernel-domain-allow-all-domains-to-co.patch | 39 +++++++++++++++
 ...ystem-mount-make-mount_t-domain-MLS-.patch |  6 +--
 ...oles-sysadm-MLS-sysadm-rw-to-clearan.patch |  4 +-
 ...ervices-rpc-make-nfsd_t-domain-MLS-t.patch |  8 ++--
 ...dmin-dmesg-make-dmesg_t-MLS-trusted-.patch |  2 +-
 ...ernel-kernel-make-kernel_t-MLS-trust.patch |  6 +--
 ...ystem-init-make-init_t-MLS-trusted-f.patch |  4 +-
 ...ystem-systemd-make-systemd-tmpfiles_.patch |  6 +--
 ...ystem-systemd-systemd-make-systemd_-.patch | 12 ++---
 ...ystem-logging-add-the-syslogd_t-to-t.patch |  6 +--
 ...ystem-init-make-init_t-MLS-trusted-f.patch |  4 +-
 ...ystem-init-all-init_t-to-read-any-le.patch |  4 +-
 ...ystem-logging-allow-auditd_t-to-writ.patch |  6 +--
 ...ernel-kernel-make-kernel_t-MLS-trust.patch |  6 +--
 ...ystem-setrans-allow-setrans_t-use-fd.patch |  4 +-
 ...ystem-systemd-make-_systemd_t-MLS-tr.patch |  6 +--
 ...ystem-logging-make-syslogd_runtime_t.patch |  6 +--
 .../refpolicy/refpolicy_common.inc            | 15 +++---
 recipes-security/refpolicy/refpolicy_git.inc  |  4 +-
 62 files changed, 224 insertions(+), 135 deletions(-)
 create mode 100644 recipes-security/refpolicy/refpolicy/0002-refpolicy-minimum-enable-nscd_use_shm.patch
 rename recipes-security/refpolicy/refpolicy/{0034-policy-modules-system-systemd-enable-support-for-sys.patch => 0033-policy-modules-system-systemd-enable-support-for-sys.patch} (94%)
 rename recipes-security/refpolicy/refpolicy/{0035-policy-modules-system-logging-allow-systemd-tmpfiles.patch => 0034-policy-modules-system-logging-allow-systemd-tmpfiles.patch} (93%)
 rename recipes-security/refpolicy/refpolicy/{0036-policy-modules-system-systemd-allow-systemd_logind_t.patch => 0035-policy-modules-system-systemd-allow-systemd_logind_t.patch} (89%)
 rename recipes-security/refpolicy/refpolicy/{0037-policy-modules-roles-sysadm-allow-sysadm-to-use-init.patch => 0036-policy-modules-roles-sysadm-allow-sysadm-to-use-init.patch} (91%)
 rename recipes-security/refpolicy/refpolicy/{0038-policy-modules-system-systemd-systemd-user-fixes.patch => 0037-policy-modules-system-systemd-systemd-user-fixes.patch} (90%)
 rename recipes-security/refpolicy/refpolicy/{0040-policy-modules-system-logging-grant-getpcap-capabili.patch => 0038-policy-modules-system-logging-grant-getpcap-capabili.patch} (90%)
 rename recipes-security/refpolicy/refpolicy/{0057-Allow-services-to-read-tmpfs-under-run-credentials.patch => 0039-policy-modules-system-allow-services-to-read-tmpfs-u.patch} (93%)
 create mode 100644 recipes-security/refpolicy/refpolicy/0040-policy-modules-kernel-domain-allow-all-domains-to-co.patch

diff --git a/recipes-security/refpolicy/refpolicy-minimum_git.bb b/recipes-security/refpolicy/refpolicy-minimum_git.bb
index 562ccac..233c851 100644
--- a/recipes-security/refpolicy/refpolicy-minimum_git.bb
+++ b/recipes-security/refpolicy/refpolicy-minimum_git.bb
@@ -13,6 +13,7 @@ domains are unconfined. \
 
 SRC_URI += " \
         file://0001-refpolicy-minimum-make-sysadmin-module-optional.patch \
+        file://0002-refpolicy-minimum-enable-nscd_use_shm.patch \
         "
 
 POLICY_NAME = "minimum"
diff --git a/recipes-security/refpolicy/refpolicy/0001-fc-subs-volatile-alias-common-var-volatile-paths.patch b/recipes-security/refpolicy/refpolicy/0001-fc-subs-volatile-alias-common-var-volatile-paths.patch
index 59169cb..45686b2 100644
--- a/recipes-security/refpolicy/refpolicy/0001-fc-subs-volatile-alias-common-var-volatile-paths.patch
+++ b/recipes-security/refpolicy/refpolicy/0001-fc-subs-volatile-alias-common-var-volatile-paths.patch
@@ -1,4 +1,4 @@
-From 9fdb576862d6a373b4a50e149fcfd4571e01dd1a Mon Sep 17 00:00:00 2001
+From 2627c403bb84d710a2469e501e6a0ccf5c7fb438 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 16:14:09 -0400
 Subject: [PATCH] fc/subs/volatile: alias common /var/volatile paths
diff --git a/recipes-security/refpolicy/refpolicy/0001-refpolicy-minimum-make-sysadmin-module-optional.patch b/recipes-security/refpolicy/refpolicy/0001-refpolicy-minimum-make-sysadmin-module-optional.patch
index 820d71e..73e6b48 100644
--- a/recipes-security/refpolicy/refpolicy/0001-refpolicy-minimum-make-sysadmin-module-optional.patch
+++ b/recipes-security/refpolicy/refpolicy/0001-refpolicy-minimum-make-sysadmin-module-optional.patch
@@ -1,4 +1,4 @@
-From 2d04fadd54814ce01d143262f36edbf0b1700a9b Mon Sep 17 00:00:00 2001
+From 923dec0f0231024680bb6f7d48ff7edf82ed8082 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 5 Apr 2019 11:53:28 -0400
 Subject: [PATCH] refpolicy-minimum: make sysadmin module optional
@@ -22,10 +22,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  2 files changed, 11 insertions(+), 7 deletions(-)
 
 diff --git a/policy/modules/system/init.te b/policy/modules/system/init.te
-index c2380d8b4..31f77cf43 100644
+index 8af34aa7e..fdd64fb5b 100644
 --- a/policy/modules/system/init.te
 +++ b/policy/modules/system/init.te
-@@ -645,13 +645,15 @@ ifdef(`init_systemd',`
+@@ -653,13 +653,15 @@ ifdef(`init_systemd',`
  		unconfined_write_keys(init_t)
  	')
  ',`
@@ -48,7 +48,7 @@ index c2380d8b4..31f77cf43 100644
  	')
  ')
 diff --git a/policy/modules/system/locallogin.te b/policy/modules/system/locallogin.te
-index 8330be8a9..933e94b24 100644
+index 4ba131d29..9c4b0a1d8 100644
 --- a/policy/modules/system/locallogin.te
 +++ b/policy/modules/system/locallogin.te
 @@ -277,7 +277,9 @@ userdom_use_unpriv_users_fds(sulogin_t)
diff --git a/recipes-security/refpolicy/refpolicy/0001-refpolicy-targeted-make-unconfined_u-the-default-sel.patch b/recipes-security/refpolicy/refpolicy/0001-refpolicy-targeted-make-unconfined_u-the-default-sel.patch
index f4e4809..ba472d7 100644
--- a/recipes-security/refpolicy/refpolicy/0001-refpolicy-targeted-make-unconfined_u-the-default-sel.patch
+++ b/recipes-security/refpolicy/refpolicy/0001-refpolicy-targeted-make-unconfined_u-the-default-sel.patch
@@ -1,4 +1,4 @@
-From 15b4f9a17d1f45dc6e15e4a3b0e6490a9a518df6 Mon Sep 17 00:00:00 2001
+From 38cac8a2f2ec94bbc9b6d04ffcc35b7459c05b11 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Mon, 20 Apr 2020 11:50:03 +0800
 Subject: [PATCH] refpolicy-targeted: make unconfined_u the default selinux
@@ -38,7 +38,7 @@ index ce614b41b..c0903d98b 100644
 +root:unconfined_u:s0-mcs_systemhigh
 +__default__:unconfined_u:s0
 diff --git a/policy/modules/system/unconfined.te b/policy/modules/system/unconfined.te
-index 6c9769b04..01c9a7243 100644
+index 68b78ff24..d54fe2fd4 100644
 --- a/policy/modules/system/unconfined.te
 +++ b/policy/modules/system/unconfined.te
 @@ -20,6 +20,11 @@ type unconfined_execmem_t alias ada_t;
diff --git a/recipes-security/refpolicy/refpolicy/0002-fc-subs-busybox-set-aliases-for-bin-sbin-and-usr.patch b/recipes-security/refpolicy/refpolicy/0002-fc-subs-busybox-set-aliases-for-bin-sbin-and-usr.patch
index b6be830..5815b47 100644
--- a/recipes-security/refpolicy/refpolicy/0002-fc-subs-busybox-set-aliases-for-bin-sbin-and-usr.patch
+++ b/recipes-security/refpolicy/refpolicy/0002-fc-subs-busybox-set-aliases-for-bin-sbin-and-usr.patch
@@ -1,4 +1,4 @@
-From a3269d08232045835f341e5796da66d9bf948aca Mon Sep 17 00:00:00 2001
+From bd8d0af36d8f6eb0f25c43b94e31e93d4ac7513b Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 20:48:10 -0400
 Subject: [PATCH] fc/subs/busybox: set aliases for bin, sbin and usr
diff --git a/recipes-security/refpolicy/refpolicy/0002-refpolicy-minimum-enable-nscd_use_shm.patch b/recipes-security/refpolicy/refpolicy/0002-refpolicy-minimum-enable-nscd_use_shm.patch
new file mode 100644
index 0000000..72c5374
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0002-refpolicy-minimum-enable-nscd_use_shm.patch
@@ -0,0 +1,47 @@
+From 9494c078e1aea2ab6ecdf0c3ca01e2d3941b11a7 Mon Sep 17 00:00:00 2001
+From: Yi Zhao <yi.zhao@windriver.com>
+Date: Fri, 26 Feb 2021 09:13:23 +0800
+Subject: [PATCH] refpolicy-minimum: enable nscd_use_shm
+
+Fixes:
+avc:  denied  { listen } for  pid=340 comm="systemd-network"
+path="/run/systemd/netif/io.systemd.Network"
+scontext=system_u:system_r:systemd_networkd_t:s0
+tcontext=system_u:system_r:systemd_networkd_t:s0
+tclass=unix_stream_socket permissive=1
+
+avc:  denied  { accept } for  pid=312 comm="systemd-nsresou"
+path="/run/systemd/io.systemd.NamespaceResource"
+scontext=system_u:system_r:systemd_nsresourced_t:s0
+tcontext=system_u:system_r:systemd_nsresourced_t:s0
+tclass=unix_stream_socket permissive=1
+
+avc:  denied  { accept } for  pid=309 comm="systemd-nsresou"
+path="/run/systemd/io.systemd.NamespaceResource"
+scontext=system_u:system_r:systemd_nsresourced_t:s0
+tcontext=system_u:system_r:systemd_nsresourced_t:s0
+tclass=unix_stream_socket permissive=1
+
+Upstream-Status: Inappropriate [embedded specific]
+
+Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
+---
+ policy/modules/services/nscd.te | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/policy/modules/services/nscd.te b/policy/modules/services/nscd.te
+index ffc60497c..d226f1145 100644
+--- a/policy/modules/services/nscd.te
++++ b/policy/modules/services/nscd.te
+@@ -15,7 +15,7 @@ gen_require(`
+ ##	can use nscd shared memory.
+ ##	</p>
+ ## </desc>
+-gen_tunable(nscd_use_shm, false)
++gen_tunable(nscd_use_shm, true)
+ 
+ attribute_role nscd_roles;
+ 
+-- 
+2.25.1
+
diff --git a/recipes-security/refpolicy/refpolicy/0003-fc-hostname-apply-policy-to-common-yocto-hostname-al.patch b/recipes-security/refpolicy/refpolicy/0003-fc-hostname-apply-policy-to-common-yocto-hostname-al.patch
index 69ed556..6e82aee 100644
--- a/recipes-security/refpolicy/refpolicy/0003-fc-hostname-apply-policy-to-common-yocto-hostname-al.patch
+++ b/recipes-security/refpolicy/refpolicy/0003-fc-hostname-apply-policy-to-common-yocto-hostname-al.patch
@@ -1,4 +1,4 @@
-From a78f1bf10f489d1abe8a4db9c8ee29af6ac9d02c Mon Sep 17 00:00:00 2001
+From b8ec557e6aa310c65d9183ae741e649eae1c3619 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] fc/hostname: apply policy to common yocto hostname
diff --git a/recipes-security/refpolicy/refpolicy/0004-fc-bash-apply-usr-bin-bash-context-to-bin-bash.bash.patch b/recipes-security/refpolicy/refpolicy/0004-fc-bash-apply-usr-bin-bash-context-to-bin-bash.bash.patch
index 1eac7ec..27f2ea8 100644
--- a/recipes-security/refpolicy/refpolicy/0004-fc-bash-apply-usr-bin-bash-context-to-bin-bash.bash.patch
+++ b/recipes-security/refpolicy/refpolicy/0004-fc-bash-apply-usr-bin-bash-context-to-bin-bash.bash.patch
@@ -1,4 +1,4 @@
-From 0f549b970d42109994c5736e78f0b7d9267b1ae5 Mon Sep 17 00:00:00 2001
+From ddba777d85a78cb372a84f4ff003888e1ba06afa Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 21:37:32 -0400
 Subject: [PATCH] fc/bash: apply /usr/bin/bash context to /bin/bash.bash
diff --git a/recipes-security/refpolicy/refpolicy/0005-fc-resolv.conf-label-resolv.conf-in-var-run-properly.patch b/recipes-security/refpolicy/refpolicy/0005-fc-resolv.conf-label-resolv.conf-in-var-run-properly.patch
index 4329a12..3c5f5ae 100644
--- a/recipes-security/refpolicy/refpolicy/0005-fc-resolv.conf-label-resolv.conf-in-var-run-properly.patch
+++ b/recipes-security/refpolicy/refpolicy/0005-fc-resolv.conf-label-resolv.conf-in-var-run-properly.patch
@@ -1,4 +1,4 @@
-From d9348cee43dd6d6e2ea971ef22c796956b9677fd Mon Sep 17 00:00:00 2001
+From 3f24037dd9c0c468d4182d6b047a9baa2469726a Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 4 Apr 2019 10:45:03 -0400
 Subject: [PATCH] fc/resolv.conf: label resolv.conf in var/run/ properly
@@ -13,10 +13,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/sysnetwork.fc b/policy/modules/system/sysnetwork.fc
-index 14505efe9..c9ec4e5ab 100644
+index d792422f5..a20f74820 100644
 --- a/policy/modules/system/sysnetwork.fc
 +++ b/policy/modules/system/sysnetwork.fc
-@@ -84,6 +84,7 @@ ifdef(`distro_redhat',`
+@@ -85,6 +85,7 @@ ifdef(`distro_redhat',`
  /run/dhcpcd(/.*)?		gen_context(system_u:object_r:dhcpc_runtime_t,s0)
  /run/netns	-d		gen_context(system_u:object_r:ifconfig_runtime_t,s0)
  /run/netns/[^/]+	--	<<none>>
diff --git a/recipes-security/refpolicy/refpolicy/0006-fc-login-apply-login-context-to-login.shadow.patch b/recipes-security/refpolicy/refpolicy/0006-fc-login-apply-login-context-to-login.shadow.patch
index cdf71d6..53bb1e7 100644
--- a/recipes-security/refpolicy/refpolicy/0006-fc-login-apply-login-context-to-login.shadow.patch
+++ b/recipes-security/refpolicy/refpolicy/0006-fc-login-apply-login-context-to-login.shadow.patch
@@ -1,4 +1,4 @@
-From df2801c3f9689d6c173dca05ee970756ba3b3d04 Mon Sep 17 00:00:00 2001
+From b318d4d8feb1a021e63d38ac2bea4abe834c4e3b Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 21:43:53 -0400
 Subject: [PATCH] fc/login: apply login context to login.shadow
@@ -12,7 +12,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/authlogin.fc b/policy/modules/system/authlogin.fc
-index adb53a05a..a25a9d607 100644
+index fcdd38d6d..c7e7b64a9 100644
 --- a/policy/modules/system/authlogin.fc
 +++ b/policy/modules/system/authlogin.fc
 @@ -8,6 +8,7 @@
diff --git a/recipes-security/refpolicy/refpolicy/0007-fc-hwclock-add-hwclock-alternatives.patch b/recipes-security/refpolicy/refpolicy/0007-fc-hwclock-add-hwclock-alternatives.patch
index db0d93a..c6e4662 100644
--- a/recipes-security/refpolicy/refpolicy/0007-fc-hwclock-add-hwclock-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0007-fc-hwclock-add-hwclock-alternatives.patch
@@ -1,4 +1,4 @@
-From f274bbf18ef930a506c7fe7cc90c32698e51b318 Mon Sep 17 00:00:00 2001
+From 78e157da0424e06347030577dcdd00f3e6c085ef Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 21:59:18 -0400
 Subject: [PATCH] fc/hwclock: add hwclock alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0008-fc-dmesg-apply-policy-to-dmesg-alternatives.patch b/recipes-security/refpolicy/refpolicy/0008-fc-dmesg-apply-policy-to-dmesg-alternatives.patch
index 8030e93..59770e2 100644
--- a/recipes-security/refpolicy/refpolicy/0008-fc-dmesg-apply-policy-to-dmesg-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0008-fc-dmesg-apply-policy-to-dmesg-alternatives.patch
@@ -1,4 +1,4 @@
-From c69e143640f73d13d82aa6cfcbfce64a02bcb13d Mon Sep 17 00:00:00 2001
+From d15ee4e3684c52af2caa3af2c24af73ab7ceb677 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 29 Mar 2019 08:26:55 -0400
 Subject: [PATCH] fc/dmesg: apply policy to dmesg alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0009-fc-ssh-apply-policy-to-ssh-alternatives.patch b/recipes-security/refpolicy/refpolicy/0009-fc-ssh-apply-policy-to-ssh-alternatives.patch
index 40b3e8d..84c5b62 100644
--- a/recipes-security/refpolicy/refpolicy/0009-fc-ssh-apply-policy-to-ssh-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0009-fc-ssh-apply-policy-to-ssh-alternatives.patch
@@ -1,4 +1,4 @@
-From 6cb433b296b2085bf1aa54c7722a8bcf7a69cba8 Mon Sep 17 00:00:00 2001
+From f287a7b6b9a41963cec1e9bf70eff99e840c9cc3 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 29 Mar 2019 09:20:58 -0400
 Subject: [PATCH] fc/ssh: apply policy to ssh alternatives
@@ -12,7 +12,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/services/ssh.fc b/policy/modules/services/ssh.fc
-index 5c512e972..0448c1877 100644
+index a30d01afc..e033d1a70 100644
 --- a/policy/modules/services/ssh.fc
 +++ b/policy/modules/services/ssh.fc
 @@ -4,6 +4,7 @@ HOME_DIR/\.ssh(/.*)?			gen_context(system_u:object_r:ssh_home_t,s0)
diff --git a/recipes-security/refpolicy/refpolicy/0010-fc-sysnetwork-apply-policy-to-network-commands-alter.patch b/recipes-security/refpolicy/refpolicy/0010-fc-sysnetwork-apply-policy-to-network-commands-alter.patch
index 6d1b362..08d6a80 100644
--- a/recipes-security/refpolicy/refpolicy/0010-fc-sysnetwork-apply-policy-to-network-commands-alter.patch
+++ b/recipes-security/refpolicy/refpolicy/0010-fc-sysnetwork-apply-policy-to-network-commands-alter.patch
@@ -1,4 +1,4 @@
-From 89f23ef679f8f0f842b7b41b85c48266d292bcfc Mon Sep 17 00:00:00 2001
+From fcfd91661ea05b5967f75927116056924e972214 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Tue, 9 Jun 2015 21:22:52 +0530
 Subject: [PATCH] fc/sysnetwork: apply policy to network commands alternatives
@@ -14,10 +14,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 4 insertions(+)
 
 diff --git a/policy/modules/system/sysnetwork.fc b/policy/modules/system/sysnetwork.fc
-index c9ec4e5ab..4ca151524 100644
+index a20f74820..6f2e3f8f0 100644
 --- a/policy/modules/system/sysnetwork.fc
 +++ b/policy/modules/system/sysnetwork.fc
-@@ -44,6 +44,7 @@ ifdef(`distro_redhat',`
+@@ -45,6 +45,7 @@ ifdef(`distro_redhat',`
  /usr/bin/dhcpcd		        --	gen_context(system_u:object_r:dhcpc_exec_t,s0)
  /usr/bin/ethtool		    --	gen_context(system_u:object_r:ifconfig_exec_t,s0)
  /usr/bin/ifconfig		    --	gen_context(system_u:object_r:ifconfig_exec_t,s0)
@@ -25,7 +25,7 @@ index c9ec4e5ab..4ca151524 100644
  /usr/bin/ip			        --	gen_context(system_u:object_r:ifconfig_exec_t,s0)
  /usr/bin/ipx_configure		--	gen_context(system_u:object_r:ifconfig_exec_t,s0)
  /usr/bin/ipx_interface		--	gen_context(system_u:object_r:ifconfig_exec_t,s0)
-@@ -60,13 +61,16 @@ ifdef(`distro_redhat',`
+@@ -61,13 +62,16 @@ ifdef(`distro_redhat',`
  /usr/sbin/dhcpcd		--	gen_context(system_u:object_r:dhcpc_exec_t,s0)
  /usr/sbin/ethtool		--	gen_context(system_u:object_r:ifconfig_exec_t,s0)
  /usr/sbin/ifconfig		--	gen_context(system_u:object_r:ifconfig_exec_t,s0)
diff --git a/recipes-security/refpolicy/refpolicy/0011-fc-rpm-apply-rpm_exec-policy-to-cpio-binaries.patch b/recipes-security/refpolicy/refpolicy/0011-fc-rpm-apply-rpm_exec-policy-to-cpio-binaries.patch
index 86fc796..4420b33 100644
--- a/recipes-security/refpolicy/refpolicy/0011-fc-rpm-apply-rpm_exec-policy-to-cpio-binaries.patch
+++ b/recipes-security/refpolicy/refpolicy/0011-fc-rpm-apply-rpm_exec-policy-to-cpio-binaries.patch
@@ -1,4 +1,4 @@
-From 2fb2dc1ab37da9d6d1f885b7f4b3eae8db66844a Mon Sep 17 00:00:00 2001
+From 6e5d4763c0e3e7b2b819694d85710128f4e0ff28 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 29 Mar 2019 09:54:07 -0400
 Subject: [PATCH] fc/rpm: apply rpm_exec policy to cpio binaries
diff --git a/recipes-security/refpolicy/refpolicy/0012-fc-su-apply-policy-to-su-alternatives.patch b/recipes-security/refpolicy/refpolicy/0012-fc-su-apply-policy-to-su-alternatives.patch
index 69e36e1..699fa77 100644
--- a/recipes-security/refpolicy/refpolicy/0012-fc-su-apply-policy-to-su-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0012-fc-su-apply-policy-to-su-alternatives.patch
@@ -1,4 +1,4 @@
-From 95920611d43a3e6352fc16fcac05977844d57398 Mon Sep 17 00:00:00 2001
+From ca60691cffdf516f3f09cee23874a49d890c9de8 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Thu, 13 Feb 2014 00:33:07 -0500
 Subject: [PATCH] fc/su: apply policy to su alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch b/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch
index 55f3175..7e56e75 100644
--- a/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch
+++ b/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch
@@ -1,4 +1,4 @@
-From 8b5320fbdb29ab1bf601d9cf81ffe7ea7b9bc55f Mon Sep 17 00:00:00 2001
+From f6a42851e3abe274a733f92f90541de3047e5d74 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Mon, 27 Jan 2014 03:54:01 -0500
 Subject: [PATCH] fc/fstools: fix real path for fstools
diff --git a/recipes-security/refpolicy/refpolicy/0014-fc-init-fix-update-alternatives-for-sysvinit.patch b/recipes-security/refpolicy/refpolicy/0014-fc-init-fix-update-alternatives-for-sysvinit.patch
index 01b7cca..40e5413 100644
--- a/recipes-security/refpolicy/refpolicy/0014-fc-init-fix-update-alternatives-for-sysvinit.patch
+++ b/recipes-security/refpolicy/refpolicy/0014-fc-init-fix-update-alternatives-for-sysvinit.patch
@@ -1,4 +1,4 @@
-From a733674bb530f070ce5363c0b50848d3cb4e113b Mon Sep 17 00:00:00 2001
+From eecf36ae218ee0d85fd07a14bfbcb6636ab84095 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] fc/init: fix update-alternatives for sysvinit
diff --git a/recipes-security/refpolicy/refpolicy/0015-fc-brctl-apply-policy-to-brctl-alternatives.patch b/recipes-security/refpolicy/refpolicy/0015-fc-brctl-apply-policy-to-brctl-alternatives.patch
index e21e044..fa9e849 100644
--- a/recipes-security/refpolicy/refpolicy/0015-fc-brctl-apply-policy-to-brctl-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0015-fc-brctl-apply-policy-to-brctl-alternatives.patch
@@ -1,4 +1,4 @@
-From e4bdaafd9684b3b46a6d0a417967f596fbdc36c2 Mon Sep 17 00:00:00 2001
+From e26d8e3eea2cab884562793221ce9b8c39c614cc Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:19:54 +0800
 Subject: [PATCH] fc/brctl: apply policy to brctl alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0016-fc-corecommands-apply-policy-to-nologin-alternatives.patch b/recipes-security/refpolicy/refpolicy/0016-fc-corecommands-apply-policy-to-nologin-alternatives.patch
index 3020814..eb49b01 100644
--- a/recipes-security/refpolicy/refpolicy/0016-fc-corecommands-apply-policy-to-nologin-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0016-fc-corecommands-apply-policy-to-nologin-alternatives.patch
@@ -1,4 +1,4 @@
-From 762b0bd9cc26627f7361d5db92ae1cb366c0858b Mon Sep 17 00:00:00 2001
+From 48b69b97a52cf782fbc54f5e55e92ee81466d0bc Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:21:51 +0800
 Subject: [PATCH] fc/corecommands: apply policy to nologin alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0017-fc-locallogin-apply-policy-to-sulogin-alternatives.patch b/recipes-security/refpolicy/refpolicy/0017-fc-locallogin-apply-policy-to-sulogin-alternatives.patch
index cd3cb4b..63fa13a 100644
--- a/recipes-security/refpolicy/refpolicy/0017-fc-locallogin-apply-policy-to-sulogin-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0017-fc-locallogin-apply-policy-to-sulogin-alternatives.patch
@@ -1,4 +1,4 @@
-From d312aa5ea1da9c19eb214a55acb2d2b5347ed68f Mon Sep 17 00:00:00 2001
+From 29e16342861e11d6463ec63ffbe55d1665d05e7d Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:43:28 +0800
 Subject: [PATCH] fc/locallogin: apply policy to sulogin alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0018-fc-ntp-apply-policy-to-ntpd-alternatives.patch b/recipes-security/refpolicy/refpolicy/0018-fc-ntp-apply-policy-to-ntpd-alternatives.patch
index 9009120..1947803 100644
--- a/recipes-security/refpolicy/refpolicy/0018-fc-ntp-apply-policy-to-ntpd-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0018-fc-ntp-apply-policy-to-ntpd-alternatives.patch
@@ -1,4 +1,4 @@
-From 3085ae26b66d82f7c7b3db507153a5976ec26b48 Mon Sep 17 00:00:00 2001
+From c1847b18ed1b1a18dbafc735bfb1368c2abb9d55 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:45:23 +0800
 Subject: [PATCH] fc/ntp: apply policy to ntpd alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0019-fc-kerberos-apply-policy-to-kerberos-alternatives.patch b/recipes-security/refpolicy/refpolicy/0019-fc-kerberos-apply-policy-to-kerberos-alternatives.patch
index 9fc5b90..4248605 100644
--- a/recipes-security/refpolicy/refpolicy/0019-fc-kerberos-apply-policy-to-kerberos-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0019-fc-kerberos-apply-policy-to-kerberos-alternatives.patch
@@ -1,4 +1,4 @@
-From 4f377178aff842dc4ce9c6e705a761478d21f4d3 Mon Sep 17 00:00:00 2001
+From 1400afd28f2cd886bae487fb17811a5fd98b86b9 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:55:05 +0800
 Subject: [PATCH] fc/kerberos: apply policy to kerberos alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0020-fc-ldap-apply-policy-to-ldap-alternatives.patch b/recipes-security/refpolicy/refpolicy/0020-fc-ldap-apply-policy-to-ldap-alternatives.patch
index c2247c3..c0aa11b 100644
--- a/recipes-security/refpolicy/refpolicy/0020-fc-ldap-apply-policy-to-ldap-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0020-fc-ldap-apply-policy-to-ldap-alternatives.patch
@@ -1,4 +1,4 @@
-From 6de6e53b41602b50ebec3627ceede5e13bad3bb6 Mon Sep 17 00:00:00 2001
+From 53370099eb97c008460bb7b99817737beb94a9bf Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 11:06:13 +0800
 Subject: [PATCH] fc/ldap: apply policy to ldap alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0021-fc-postgresql-apply-policy-to-postgresql-alternative.patch b/recipes-security/refpolicy/refpolicy/0021-fc-postgresql-apply-policy-to-postgresql-alternative.patch
index 9d3c2e1..d76d2e3 100644
--- a/recipes-security/refpolicy/refpolicy/0021-fc-postgresql-apply-policy-to-postgresql-alternative.patch
+++ b/recipes-security/refpolicy/refpolicy/0021-fc-postgresql-apply-policy-to-postgresql-alternative.patch
@@ -1,4 +1,4 @@
-From f523a63f9f209544b9a557e76e94354c23d93959 Mon Sep 17 00:00:00 2001
+From 67fda1f031d70d1281b058a5f3a31e220b052d21 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 11:13:16 +0800
 Subject: [PATCH] fc/postgresql: apply policy to postgresql alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0022-fc-screen-apply-policy-to-screen-alternatives.patch b/recipes-security/refpolicy/refpolicy/0022-fc-screen-apply-policy-to-screen-alternatives.patch
index 749c19a..2fe39bf 100644
--- a/recipes-security/refpolicy/refpolicy/0022-fc-screen-apply-policy-to-screen-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0022-fc-screen-apply-policy-to-screen-alternatives.patch
@@ -1,4 +1,4 @@
-From 57c6a0e69aa9d308ec23dc60dc2420ee5c62bf7f Mon Sep 17 00:00:00 2001
+From fb72a7ca4963a7537bcb98a730025f6f8941d146 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 11:15:33 +0800
 Subject: [PATCH] fc/screen: apply policy to screen alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0023-fc-usermanage-apply-policy-to-usermanage-alternative.patch b/recipes-security/refpolicy/refpolicy/0023-fc-usermanage-apply-policy-to-usermanage-alternative.patch
index 152d147..0d95b3c 100644
--- a/recipes-security/refpolicy/refpolicy/0023-fc-usermanage-apply-policy-to-usermanage-alternative.patch
+++ b/recipes-security/refpolicy/refpolicy/0023-fc-usermanage-apply-policy-to-usermanage-alternative.patch
@@ -1,4 +1,4 @@
-From f0706a85dca8801d87130102b701c7bc2fd7476d Mon Sep 17 00:00:00 2001
+From 343389daef155325172928f7d5608e638897775d Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 11:25:34 +0800
 Subject: [PATCH] fc/usermanage: apply policy to usermanage alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0024-fc-getty-add-file-context-to-start_getty.patch b/recipes-security/refpolicy/refpolicy/0024-fc-getty-add-file-context-to-start_getty.patch
index 3527e65..3066e52 100644
--- a/recipes-security/refpolicy/refpolicy/0024-fc-getty-add-file-context-to-start_getty.patch
+++ b/recipes-security/refpolicy/refpolicy/0024-fc-getty-add-file-context-to-start_getty.patch
@@ -1,4 +1,4 @@
-From 2ff44df5a5da2246f2198741a05786e89ac9f4e3 Mon Sep 17 00:00:00 2001
+From 23cef56ad581ee4579ab6ee26c9dd8b114816b6b Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 16:07:30 +0800
 Subject: [PATCH] fc/getty: add file context to start_getty
diff --git a/recipes-security/refpolicy/refpolicy/0025-fc-vlock-apply-policy-to-vlock-alternatives.patch b/recipes-security/refpolicy/refpolicy/0025-fc-vlock-apply-policy-to-vlock-alternatives.patch
index 331eab9..7e596ef 100644
--- a/recipes-security/refpolicy/refpolicy/0025-fc-vlock-apply-policy-to-vlock-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0025-fc-vlock-apply-policy-to-vlock-alternatives.patch
@@ -1,4 +1,4 @@
-From 42676d53a9c8554ac3e05f826f23792edf8d3c27 Mon Sep 17 00:00:00 2001
+From 32988df0a389ef480334dffce4d5cc96b0f1012e Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Wed, 18 Dec 2019 15:04:41 +0800
 Subject: [PATCH] fc/vlock: apply policy to vlock alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0026-fc-add-fcontext-for-init-scripts-and-systemd-service.patch b/recipes-security/refpolicy/refpolicy/0026-fc-add-fcontext-for-init-scripts-and-systemd-service.patch
index 0adb47f..4fe9ee9 100644
--- a/recipes-security/refpolicy/refpolicy/0026-fc-add-fcontext-for-init-scripts-and-systemd-service.patch
+++ b/recipes-security/refpolicy/refpolicy/0026-fc-add-fcontext-for-init-scripts-and-systemd-service.patch
@@ -1,4 +1,4 @@
-From 3cf1f270369d7a2c75faf1a90d1485fe699dbbfe Mon Sep 17 00:00:00 2001
+From 8586fbe84abd716a425e13e8b48179a08e210db2 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 30 Jun 2020 10:45:57 +0800
 Subject: [PATCH] fc: add fcontext for init scripts and systemd service files
diff --git a/recipes-security/refpolicy/refpolicy/0027-file_contexts.subs_dist-set-aliase-for-root-director.patch b/recipes-security/refpolicy/refpolicy/0027-file_contexts.subs_dist-set-aliase-for-root-director.patch
index fbaa44e..0ad146d 100644
--- a/recipes-security/refpolicy/refpolicy/0027-file_contexts.subs_dist-set-aliase-for-root-director.patch
+++ b/recipes-security/refpolicy/refpolicy/0027-file_contexts.subs_dist-set-aliase-for-root-director.patch
@@ -1,4 +1,4 @@
-From 8b5ff44ba4a7819efb694cba6237bc572835628b Mon Sep 17 00:00:00 2001
+From 20f43a932c5f7369a446707624d12285035b72fc Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Sun, 5 Apr 2020 22:03:45 +0800
 Subject: [PATCH] file_contexts.subs_dist: set aliase for /root directory
diff --git a/recipes-security/refpolicy/refpolicy/0028-policy-modules-system-logging-add-rules-for-the-syml.patch b/recipes-security/refpolicy/refpolicy/0028-policy-modules-system-logging-add-rules-for-the-syml.patch
index 4e97d8a..a433cb7 100644
--- a/recipes-security/refpolicy/refpolicy/0028-policy-modules-system-logging-add-rules-for-the-syml.patch
+++ b/recipes-security/refpolicy/refpolicy/0028-policy-modules-system-logging-add-rules-for-the-syml.patch
@@ -1,4 +1,4 @@
-From 6f73afe1d8647bd917f6c06b46b0f0cebc276776 Mon Sep 17 00:00:00 2001
+From 97839d4388be64e168613c2ea3202a76e58fb656 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/system/logging: add rules for the symlink of
@@ -30,7 +30,7 @@ index 0ce2bec4b..8957366b0 100644
  /var/log/dmesg		--	gen_context(system_u:object_r:var_log_t,s0)
  /var/log/syslog		--	gen_context(system_u:object_r:var_log_t,s0)
 diff --git a/policy/modules/system/logging.if b/policy/modules/system/logging.if
-index 49028a0cb..4381d2e83 100644
+index 7487a7053..6acf1f52b 100644
 --- a/policy/modules/system/logging.if
 +++ b/policy/modules/system/logging.if
 @@ -1091,10 +1091,12 @@ interface(`logging_append_all_inherited_logs',`
diff --git a/recipes-security/refpolicy/refpolicy/0029-policy-modules-system-logging-add-rules-for-syslogd-.patch b/recipes-security/refpolicy/refpolicy/0029-policy-modules-system-logging-add-rules-for-syslogd-.patch
index cfef36b..2465417 100644
--- a/recipes-security/refpolicy/refpolicy/0029-policy-modules-system-logging-add-rules-for-syslogd-.patch
+++ b/recipes-security/refpolicy/refpolicy/0029-policy-modules-system-logging-add-rules-for-syslogd-.patch
@@ -1,4 +1,4 @@
-From 9d4f8d201dbdea28a38b5faaef9abc016bcbaab3 Mon Sep 17 00:00:00 2001
+From 9bd0c30476615fd4af29a9dd5b3b664398a9845a Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 29 Mar 2019 10:33:18 -0400
 Subject: [PATCH] policy/modules/system/logging: add rules for syslogd symlink
@@ -18,7 +18,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index 9d9a01fcc..45584dba6 100644
+index eea78ffc5..5f06428f1 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -425,6 +425,7 @@ files_search_spool(syslogd_t)
diff --git a/recipes-security/refpolicy/refpolicy/0030-policy-modules-kernel-files-add-rules-for-the-symlin.patch b/recipes-security/refpolicy/refpolicy/0030-policy-modules-kernel-files-add-rules-for-the-symlin.patch
index 62c1593..6c5731b 100644
--- a/recipes-security/refpolicy/refpolicy/0030-policy-modules-kernel-files-add-rules-for-the-symlin.patch
+++ b/recipes-security/refpolicy/refpolicy/0030-policy-modules-kernel-files-add-rules-for-the-symlin.patch
@@ -1,4 +1,4 @@
-From 1ed2b79828a7dd08079ec111b116f6d288450662 Mon Sep 17 00:00:00 2001
+From 6293ec11e3c471b54c328f56f20c694b7287885f Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/kernel/files: add rules for the symlink of
@@ -30,10 +30,10 @@ index b1728d37c..c5012e6b4 100644
  /tmp/\.journal			<<none>>
  
 diff --git a/policy/modules/kernel/files.if b/policy/modules/kernel/files.if
-index 472b5bb38..a2aa85b1c 100644
+index 811efef94..00146fc23 100644
 --- a/policy/modules/kernel/files.if
 +++ b/policy/modules/kernel/files.if
-@@ -4819,6 +4819,7 @@ interface(`files_search_tmp',`
+@@ -4880,6 +4880,7 @@ interface(`files_search_tmp',`
  	')
  
  	allow $1 tmp_t:dir search_dir_perms;
@@ -41,7 +41,7 @@ index 472b5bb38..a2aa85b1c 100644
  ')
  
  ########################################
-@@ -4855,6 +4856,7 @@ interface(`files_list_tmp',`
+@@ -4916,6 +4917,7 @@ interface(`files_list_tmp',`
  	')
  
  	allow $1 tmp_t:dir list_dir_perms;
@@ -49,7 +49,7 @@ index 472b5bb38..a2aa85b1c 100644
  ')
  
  ########################################
-@@ -4891,6 +4893,7 @@ interface(`files_delete_tmp_dir_entry',`
+@@ -4952,6 +4954,7 @@ interface(`files_delete_tmp_dir_entry',`
  	')
  
  	allow $1 tmp_t:dir del_entry_dir_perms;
@@ -57,7 +57,7 @@ index 472b5bb38..a2aa85b1c 100644
  ')
  
  ########################################
-@@ -4909,6 +4912,7 @@ interface(`files_read_generic_tmp_files',`
+@@ -4970,6 +4973,7 @@ interface(`files_read_generic_tmp_files',`
  	')
  
  	read_files_pattern($1, tmp_t, tmp_t)
@@ -65,7 +65,7 @@ index 472b5bb38..a2aa85b1c 100644
  ')
  
  ########################################
-@@ -4927,6 +4931,7 @@ interface(`files_manage_generic_tmp_dirs',`
+@@ -4988,6 +4992,7 @@ interface(`files_manage_generic_tmp_dirs',`
  	')
  
  	manage_dirs_pattern($1, tmp_t, tmp_t)
@@ -73,7 +73,7 @@ index 472b5bb38..a2aa85b1c 100644
  ')
  
  ########################################
-@@ -4963,6 +4968,7 @@ interface(`files_manage_generic_tmp_files',`
+@@ -5024,6 +5029,7 @@ interface(`files_manage_generic_tmp_files',`
  	')
  
  	manage_files_pattern($1, tmp_t, tmp_t)
@@ -81,7 +81,7 @@ index 472b5bb38..a2aa85b1c 100644
  ')
  
  ########################################
-@@ -4999,6 +5005,7 @@ interface(`files_rw_generic_tmp_sockets',`
+@@ -5060,6 +5066,7 @@ interface(`files_rw_generic_tmp_sockets',`
  	')
  
  	rw_sock_files_pattern($1, tmp_t, tmp_t)
@@ -89,7 +89,7 @@ index 472b5bb38..a2aa85b1c 100644
  ')
  
  ########################################
-@@ -5206,6 +5213,7 @@ interface(`files_tmp_filetrans',`
+@@ -5267,6 +5274,7 @@ interface(`files_tmp_filetrans',`
  	')
  
  	filetrans_pattern($1, tmp_t, $2, $3, $4)
diff --git a/recipes-security/refpolicy/refpolicy/0031-policy-modules-system-logging-fix-auditd-startup-fai.patch b/recipes-security/refpolicy/refpolicy/0031-policy-modules-system-logging-fix-auditd-startup-fai.patch
index 6ad2475..9ddeb9f 100644
--- a/recipes-security/refpolicy/refpolicy/0031-policy-modules-system-logging-fix-auditd-startup-fai.patch
+++ b/recipes-security/refpolicy/refpolicy/0031-policy-modules-system-logging-fix-auditd-startup-fai.patch
@@ -1,4 +1,4 @@
-From 5b33f07f60b20eb6e07ea3f517c43a539ee21332 Mon Sep 17 00:00:00 2001
+From 40ddb313a0cb04b3e9b180e04d3427715de58aee Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/system/logging: fix auditd startup failures
@@ -17,7 +17,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 3 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index 45584dba6..4fb2fb63c 100644
+index 5f06428f1..3ffddcb0a 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -117,6 +117,7 @@ allow auditctl_t self:netlink_audit_socket nlmsg_readpriv;
diff --git a/recipes-security/refpolicy/refpolicy/0032-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch b/recipes-security/refpolicy/refpolicy/0032-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch
index b3dd24f..8af397d 100644
--- a/recipes-security/refpolicy/refpolicy/0032-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch
+++ b/recipes-security/refpolicy/refpolicy/0032-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch
@@ -1,4 +1,4 @@
-From 3da00356bee8be72115652850d535c9ec5f1b333 Mon Sep 17 00:00:00 2001
+From 857a2cf93f6194d04ae8d2a8a544422e8a021e85 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/kernel/terminal: don't audit tty_device_t in
@@ -17,7 +17,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 3 insertions(+)
 
 diff --git a/policy/modules/kernel/terminal.if b/policy/modules/kernel/terminal.if
-index e5645c7c5..6e9f654ac 100644
+index 4db1fd773..f3431fa21 100644
 --- a/policy/modules/kernel/terminal.if
 +++ b/policy/modules/kernel/terminal.if
 @@ -335,9 +335,12 @@ interface(`term_use_console',`
diff --git a/recipes-security/refpolicy/refpolicy/0034-policy-modules-system-systemd-enable-support-for-sys.patch b/recipes-security/refpolicy/refpolicy/0033-policy-modules-system-systemd-enable-support-for-sys.patch
similarity index 94%
rename from recipes-security/refpolicy/refpolicy/0034-policy-modules-system-systemd-enable-support-for-sys.patch
rename to recipes-security/refpolicy/refpolicy/0033-policy-modules-system-systemd-enable-support-for-sys.patch
index 556069a..82fe4ff 100644
--- a/recipes-security/refpolicy/refpolicy/0034-policy-modules-system-systemd-enable-support-for-sys.patch
+++ b/recipes-security/refpolicy/refpolicy/0033-policy-modules-system-systemd-enable-support-for-sys.patch
@@ -1,4 +1,4 @@
-From 59b8730de7af45617a6125c7e23cecf896c30ce4 Mon Sep 17 00:00:00 2001
+From 44fe25734126ae52d95456992d6a5257bb28a5c2 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Thu, 4 Feb 2016 06:03:19 -0500
 Subject: [PATCH] policy/modules/system/systemd: enable support for
@@ -29,7 +29,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+), 1 deletion(-)
 
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index aa9198591..abc324cf1 100644
+index d58aba30b..8ae917644 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
 @@ -10,7 +10,7 @@ policy_module(systemd)
diff --git a/recipes-security/refpolicy/refpolicy/0035-policy-modules-system-logging-allow-systemd-tmpfiles.patch b/recipes-security/refpolicy/refpolicy/0034-policy-modules-system-logging-allow-systemd-tmpfiles.patch
similarity index 93%
rename from recipes-security/refpolicy/refpolicy/0035-policy-modules-system-logging-allow-systemd-tmpfiles.patch
rename to recipes-security/refpolicy/refpolicy/0034-policy-modules-system-logging-allow-systemd-tmpfiles.patch
index 30c7d12..334872a 100644
--- a/recipes-security/refpolicy/refpolicy/0035-policy-modules-system-logging-allow-systemd-tmpfiles.patch
+++ b/recipes-security/refpolicy/refpolicy/0034-policy-modules-system-logging-allow-systemd-tmpfiles.patch
@@ -1,4 +1,4 @@
-From feb50cfed6d7a08bb4e61b47f95df729a4fba9ea Mon Sep 17 00:00:00 2001
+From 07582b5efbc4fd199e80d9cc9b8144e4c88e0a2b Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Sat, 30 Sep 2023 17:20:29 +0800
 Subject: [PATCH] policy/modules/system/logging: allow systemd-tmpfiles to
@@ -24,7 +24,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 4 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index 8bc70b81d..3cab14381 100644
+index 3ffddcb0a..df6095805 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -27,6 +27,10 @@ type auditd_log_t;
diff --git a/recipes-security/refpolicy/refpolicy/0036-policy-modules-system-systemd-allow-systemd_logind_t.patch b/recipes-security/refpolicy/refpolicy/0035-policy-modules-system-systemd-allow-systemd_logind_t.patch
similarity index 89%
rename from recipes-security/refpolicy/refpolicy/0036-policy-modules-system-systemd-allow-systemd_logind_t.patch
rename to recipes-security/refpolicy/refpolicy/0035-policy-modules-system-systemd-allow-systemd_logind_t.patch
index 568f820..39902dd 100644
--- a/recipes-security/refpolicy/refpolicy/0036-policy-modules-system-systemd-allow-systemd_logind_t.patch
+++ b/recipes-security/refpolicy/refpolicy/0035-policy-modules-system-systemd-allow-systemd_logind_t.patch
@@ -1,4 +1,4 @@
-From c21d5186e0625fd83c9d674c3284cfd98c2f02b9 Mon Sep 17 00:00:00 2001
+From 13ad5906311d8e0be5547326c106d9b5ce8481ab Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Sat, 18 Dec 2021 09:26:43 +0800
 Subject: [PATCH] policy/modules/system/systemd: allow systemd_logind_t to read
@@ -27,10 +27,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index abc324cf1..ffce3c0e8 100644
+index 8ae917644..9375e8926 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -1006,6 +1006,7 @@ userdom_relabelfrom_user_runtime_dirs(systemd_logind_t)
+@@ -1056,6 +1056,7 @@ userdom_relabelfrom_user_runtime_dirs(systemd_logind_t)
  userdom_relabelto_user_runtime_dirs(systemd_logind_t)
  userdom_setattr_user_ttys(systemd_logind_t)
  userdom_use_user_ttys(systemd_logind_t)
diff --git a/recipes-security/refpolicy/refpolicy/0037-policy-modules-roles-sysadm-allow-sysadm-to-use-init.patch b/recipes-security/refpolicy/refpolicy/0036-policy-modules-roles-sysadm-allow-sysadm-to-use-init.patch
similarity index 91%
rename from recipes-security/refpolicy/refpolicy/0037-policy-modules-roles-sysadm-allow-sysadm-to-use-init.patch
rename to recipes-security/refpolicy/refpolicy/0036-policy-modules-roles-sysadm-allow-sysadm-to-use-init.patch
index 7d29f23..3461d66 100644
--- a/recipes-security/refpolicy/refpolicy/0037-policy-modules-roles-sysadm-allow-sysadm-to-use-init.patch
+++ b/recipes-security/refpolicy/refpolicy/0036-policy-modules-roles-sysadm-allow-sysadm-to-use-init.patch
@@ -1,4 +1,4 @@
-From e561ad9a73c949768f0b4e91943a32f10a9f4acc Mon Sep 17 00:00:00 2001
+From be2a2d244fd95e4207986fa095988a02cb33cb32 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 28 Oct 2022 11:56:09 +0800
 Subject: [PATCH] policy/modules/roles/sysadm: allow sysadm to use init file
@@ -19,7 +19,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/roles/sysadm.te b/policy/modules/roles/sysadm.te
-index 08cc0e117..c08226dc3 100644
+index 69777df20..af5ccca9d 100644
 --- a/policy/modules/roles/sysadm.te
 +++ b/policy/modules/roles/sysadm.te
 @@ -95,6 +95,8 @@ ifdef(`init_systemd',`
diff --git a/recipes-security/refpolicy/refpolicy/0038-policy-modules-system-systemd-systemd-user-fixes.patch b/recipes-security/refpolicy/refpolicy/0037-policy-modules-system-systemd-systemd-user-fixes.patch
similarity index 90%
rename from recipes-security/refpolicy/refpolicy/0038-policy-modules-system-systemd-systemd-user-fixes.patch
rename to recipes-security/refpolicy/refpolicy/0037-policy-modules-system-systemd-systemd-user-fixes.patch
index 9499e77..02e7541 100644
--- a/recipes-security/refpolicy/refpolicy/0038-policy-modules-system-systemd-systemd-user-fixes.patch
+++ b/recipes-security/refpolicy/refpolicy/0037-policy-modules-system-systemd-systemd-user-fixes.patch
@@ -1,4 +1,4 @@
-From 33164c889a759f4d4f2dc31244b9e2937cba854f Mon Sep 17 00:00:00 2001
+From d57677139a8fc837ede3430986bea0c42f49fc97 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Thu, 4 Feb 2021 10:48:54 +0800
 Subject: [PATCH] policy/modules/system/systemd: systemd --user fixes
@@ -31,10 +31,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  2 files changed, 34 insertions(+)
 
 diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
-index 28f0ad089..d7219dc37 100644
+index e62e8344a..96b5d31b4 100644
 --- a/policy/modules/system/systemd.if
 +++ b/policy/modules/system/systemd.if
-@@ -228,6 +228,36 @@ template(`systemd_role_template',`
+@@ -230,6 +230,36 @@ template(`systemd_role_template',`
  	')
  ')
  
@@ -72,10 +72,10 @@ index 28f0ad089..d7219dc37 100644
  ## <summary>
  ##   Allow the specified domain to be started as a daemon by the
 diff --git a/policy/modules/system/userdomain.if b/policy/modules/system/userdomain.if
-index 088cb87b2..504747917 100644
+index 73bb7c410..ea7a90a5d 100644
 --- a/policy/modules/system/userdomain.if
 +++ b/policy/modules/system/userdomain.if
-@@ -1464,6 +1464,10 @@ template(`userdom_admin_user_template',`
+@@ -1467,6 +1467,10 @@ template(`userdom_admin_user_template',`
  	optional_policy(`
  		userhelper_exec($1_t)
  	')
diff --git a/recipes-security/refpolicy/refpolicy/0040-policy-modules-system-logging-grant-getpcap-capabili.patch b/recipes-security/refpolicy/refpolicy/0038-policy-modules-system-logging-grant-getpcap-capabili.patch
similarity index 90%
rename from recipes-security/refpolicy/refpolicy/0040-policy-modules-system-logging-grant-getpcap-capabili.patch
rename to recipes-security/refpolicy/refpolicy/0038-policy-modules-system-logging-grant-getpcap-capabili.patch
index 5c2e789..3f8d1bd 100644
--- a/recipes-security/refpolicy/refpolicy/0040-policy-modules-system-logging-grant-getpcap-capabili.patch
+++ b/recipes-security/refpolicy/refpolicy/0038-policy-modules-system-logging-grant-getpcap-capabili.patch
@@ -1,4 +1,4 @@
-From f48edb588d799a7aab9110e4f67468d8e5e41c10 Mon Sep 17 00:00:00 2001
+From c54c53f8765c4401aa4c1b4a6204c8b538c008ad Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 28 May 2024 11:21:48 +0800
 Subject: [PATCH] policy/modules/system/logging: grant getpcap capability to
@@ -21,10 +21,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index 511604493..9c0a58aef 100644
+index df6095805..086498936 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
-@@ -404,6 +404,8 @@ optional_policy(`
+@@ -402,6 +402,8 @@ optional_policy(`
  # sys_admin for the integrated klog of syslog-ng and metalog
  # sys_nice for rsyslog
  allow syslogd_t self:capability { chown dac_override fsetid setgid setuid sys_admin sys_nice sys_resource sys_tty_config };
diff --git a/recipes-security/refpolicy/refpolicy/0057-Allow-services-to-read-tmpfs-under-run-credentials.patch b/recipes-security/refpolicy/refpolicy/0039-policy-modules-system-allow-services-to-read-tmpfs-u.patch
similarity index 93%
rename from recipes-security/refpolicy/refpolicy/0057-Allow-services-to-read-tmpfs-under-run-credentials.patch
rename to recipes-security/refpolicy/refpolicy/0039-policy-modules-system-allow-services-to-read-tmpfs-u.patch
index 629de01..1324a17 100644
--- a/recipes-security/refpolicy/refpolicy/0057-Allow-services-to-read-tmpfs-under-run-credentials.patch
+++ b/recipes-security/refpolicy/refpolicy/0039-policy-modules-system-allow-services-to-read-tmpfs-u.patch
@@ -1,7 +1,8 @@
-From be681d155c6c62a2ec4939dedc921921fe73e277 Mon Sep 17 00:00:00 2001
+From 33bc8d28c406ffd7a6aef2f390734b3f5bdfc5a3 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 30 Aug 2024 12:39:48 +0800
-Subject: [PATCH] Allow services to read tmpfs under /run/credentials/
+Subject: [PATCH] policy/modules/system: allow services to read tmpfs under
+ /run/credentials/
 
 $ mount | grep credentials
 tmpfs on /run/credentials/systemd-journald.service type tmpfs (ro,nosuid,nodev,noexec,relatime,nosymfollow,seclabel,size=1024k,nr_inodes=1024,mode=700,noswap)
@@ -66,10 +67,10 @@ index a900226bf..75b94785b 100644
  mcs_process_set_categories(getty_t)
  
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index fc73825fa..d5878876b 100644
+index 086498936..dca46f105 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
-@@ -495,6 +495,7 @@ files_read_kernel_symbol_table(syslogd_t)
+@@ -491,6 +491,7 @@ files_read_kernel_symbol_table(syslogd_t)
  files_var_lib_filetrans(syslogd_t, syslogd_var_lib_t, { file dir })
  
  fs_getattr_all_fs(syslogd_t)
@@ -78,10 +79,10 @@ index fc73825fa..d5878876b 100644
  
  mls_file_write_all_levels(syslogd_t) # Need to be able to write to /var/run/ and /var/log directories
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index 22a319c36..0440b4795 100644
+index 9375e8926..24fc90838 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -1303,6 +1303,7 @@ files_watch_root_dirs(systemd_networkd_t)
+@@ -1294,6 +1294,7 @@ files_watch_root_dirs(systemd_networkd_t)
  files_list_runtime(systemd_networkd_t)
  
  fs_getattr_all_fs(systemd_networkd_t)
diff --git a/recipes-security/refpolicy/refpolicy/0040-policy-modules-kernel-domain-allow-all-domains-to-co.patch b/recipes-security/refpolicy/refpolicy/0040-policy-modules-kernel-domain-allow-all-domains-to-co.patch
new file mode 100644
index 0000000..e9d9114
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0040-policy-modules-kernel-domain-allow-all-domains-to-co.patch
@@ -0,0 +1,39 @@
+From 58adf54a5ef927cda85c11e2c73151d6e91e8294 Mon Sep 17 00:00:00 2001
+From: Yi Zhao <yi.zhao@windriver.com>
+Date: Thu, 3 Oct 2024 21:12:33 +0800
+Subject: [PATCH] policy/modules/kernel/domain: allow all domains to connect to
+ systemd-nsresourced over a unix socket
+
+Refer to Fedora selinux policy[1], allow all domains to connect to
+systemd-nsresourced over a unix socket.
+
+As said in [2]: Each subsystem that needs to define users and groups on
+the local system is supposed to implement this API, and offer its
+interfaces on a Varlink AF_UNIX/SOCK_STREAM file system socket bound
+into the /run/systemd/userdb/ directory.
+
+[1] https://github.com/fedora-selinux/selinux-policy/commit/8c784a48c0833a83de9d2d120f4cb76f0d87895c
+[2] https://systemd.io/USER_GROUP_API/
+
+Upstream-Status: Pending
+
+Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
+---
+ policy/modules/kernel/domain.te | 1 +
+ 1 file changed, 1 insertion(+)
+
+diff --git a/policy/modules/kernel/domain.te b/policy/modules/kernel/domain.te
+index 0f38015b6..e3eee0590 100644
+--- a/policy/modules/kernel/domain.te
++++ b/policy/modules/kernel/domain.te
+@@ -131,6 +131,7 @@ files_list_root(domain)
+ ifdef(`init_systemd',`
+ 	optional_policy(`
+ 		shutdown_sigchld(domain)
++		systemd_stream_connect_nsresourced(domain)
+ 	')
+ ')
+ 
+-- 
+2.25.1
+
diff --git a/recipes-security/refpolicy/refpolicy/0041-policy-modules-system-mount-make-mount_t-domain-MLS-.patch b/recipes-security/refpolicy/refpolicy/0041-policy-modules-system-mount-make-mount_t-domain-MLS-.patch
index 5ced4ae..93a52fd 100644
--- a/recipes-security/refpolicy/refpolicy/0041-policy-modules-system-mount-make-mount_t-domain-MLS-.patch
+++ b/recipes-security/refpolicy/refpolicy/0041-policy-modules-system-mount-make-mount_t-domain-MLS-.patch
@@ -1,4 +1,4 @@
-From 53a770736133d84be9cab23732811f96304bf737 Mon Sep 17 00:00:00 2001
+From fe5fe08deab5f02a3609e5333e09e5e3af05140a Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Sat, 15 Feb 2014 04:22:47 -0500
 Subject: [PATCH] policy/modules/system/mount: make mount_t domain MLS trusted
@@ -19,10 +19,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/mount.te b/policy/modules/system/mount.te
-index 8cd51d563..3fc37619e 100644
+index d9e431a84..20d6aaba1 100644
 --- a/policy/modules/system/mount.te
 +++ b/policy/modules/system/mount.te
-@@ -117,6 +117,7 @@ fs_dontaudit_write_all_image_files(mount_t)
+@@ -118,6 +118,7 @@ fs_dontaudit_write_all_image_files(mount_t)
  
  mls_file_read_all_levels(mount_t)
  mls_file_write_all_levels(mount_t)
diff --git a/recipes-security/refpolicy/refpolicy/0042-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch b/recipes-security/refpolicy/refpolicy/0042-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch
index 07a11ea..2e7a206 100644
--- a/recipes-security/refpolicy/refpolicy/0042-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch
+++ b/recipes-security/refpolicy/refpolicy/0042-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch
@@ -1,4 +1,4 @@
-From 93225203c2a3a767cd1319d6620da1fd1f91b25f Mon Sep 17 00:00:00 2001
+From 7a0339aeba7cfe38b62c81ee4074446bba60e801 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Mon, 28 Jan 2019 14:05:18 +0800
 Subject: [PATCH] policy/modules/roles/sysadm: MLS - sysadm rw to clearance
@@ -23,7 +23,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/roles/sysadm.te b/policy/modules/roles/sysadm.te
-index c08226dc3..4f3207d52 100644
+index af5ccca9d..10cebdc53 100644
 --- a/policy/modules/roles/sysadm.te
 +++ b/policy/modules/roles/sysadm.te
 @@ -48,6 +48,8 @@ logging_watch_all_logs(sysadm_t)
diff --git a/recipes-security/refpolicy/refpolicy/0043-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch b/recipes-security/refpolicy/refpolicy/0043-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch
index a0b5cbc..e37db1b 100644
--- a/recipes-security/refpolicy/refpolicy/0043-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch
+++ b/recipes-security/refpolicy/refpolicy/0043-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch
@@ -1,4 +1,4 @@
-From 3b260a0dc07f61b9bf873a8ac976430c80a653c3 Mon Sep 17 00:00:00 2001
+From a563f59fe223aa9c74df7a482b5da80ce05fbbf5 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Fri, 23 Aug 2013 12:01:53 +0800
 Subject: [PATCH] policy/modules/services/rpc: make nfsd_t domain MLS trusted
@@ -15,10 +15,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  2 files changed, 7 insertions(+)
 
 diff --git a/policy/modules/kernel/kernel.te b/policy/modules/kernel/kernel.te
-index 887ca3332..f6ca775e6 100644
+index 8fd1875d3..6c35a2374 100644
 --- a/policy/modules/kernel/kernel.te
 +++ b/policy/modules/kernel/kernel.te
-@@ -380,6 +380,8 @@ mls_process_read_all_levels(kernel_t)
+@@ -381,6 +381,8 @@ mls_process_read_all_levels(kernel_t)
  mls_process_write_all_levels(kernel_t)
  mls_file_write_all_levels(kernel_t)
  mls_file_read_all_levels(kernel_t)
@@ -28,7 +28,7 @@ index 887ca3332..f6ca775e6 100644
  ifdef(`distro_redhat',`
  	# Bugzilla 222337
 diff --git a/policy/modules/services/rpcbind.te b/policy/modules/services/rpcbind.te
-index 2a712192b..923e48db7 100644
+index 137c21ece..d2ee1edcf 100644
 --- a/policy/modules/services/rpcbind.te
 +++ b/policy/modules/services/rpcbind.te
 @@ -73,6 +73,11 @@ logging_send_syslog_msg(rpcbind_t)
diff --git a/recipes-security/refpolicy/refpolicy/0044-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch b/recipes-security/refpolicy/refpolicy/0044-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch
index c5943cb..7990e3f 100644
--- a/recipes-security/refpolicy/refpolicy/0044-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch
+++ b/recipes-security/refpolicy/refpolicy/0044-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch
@@ -1,4 +1,4 @@
-From faad8b18adb9a4f155ec0ec6317522baffff9117 Mon Sep 17 00:00:00 2001
+From 6bd19ab1f6adac7722ef35c70982efea04b5d91f Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 30 Jun 2020 10:18:20 +0800
 Subject: [PATCH] policy/modules/admin/dmesg: make dmesg_t MLS trusted reading
diff --git a/recipes-security/refpolicy/refpolicy/0045-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch b/recipes-security/refpolicy/refpolicy/0045-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
index a6db8ca..cc603e6 100644
--- a/recipes-security/refpolicy/refpolicy/0045-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
+++ b/recipes-security/refpolicy/refpolicy/0045-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
@@ -1,4 +1,4 @@
-From 2892de4636a61c237688d73c277edbf7a46163ab Mon Sep 17 00:00:00 2001
+From a196f11f4a7f2f96cbf05614513204ca17aa0691 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Fri, 13 Oct 2017 07:20:40 +0000
 Subject: [PATCH] policy/modules/kernel/kernel: make kernel_t MLS trusted for
@@ -59,10 +59,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/kernel/kernel.te b/policy/modules/kernel/kernel.te
-index f6ca775e6..b4b089823 100644
+index 6c35a2374..ebde22e02 100644
 --- a/policy/modules/kernel/kernel.te
 +++ b/policy/modules/kernel/kernel.te
-@@ -382,6 +382,8 @@ mls_file_write_all_levels(kernel_t)
+@@ -383,6 +383,8 @@ mls_file_write_all_levels(kernel_t)
  mls_file_read_all_levels(kernel_t)
  mls_socket_write_all_levels(kernel_t)
  mls_fd_use_all_levels(kernel_t)
diff --git a/recipes-security/refpolicy/refpolicy/0046-policy-modules-system-init-make-init_t-MLS-trusted-f.patch b/recipes-security/refpolicy/refpolicy/0046-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
index b996aa3..95896b2 100644
--- a/recipes-security/refpolicy/refpolicy/0046-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
+++ b/recipes-security/refpolicy/refpolicy/0046-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
@@ -1,4 +1,4 @@
-From f2ff5081b1a98272c803ccfd24aeea91e8d5c368 Mon Sep 17 00:00:00 2001
+From 777e396d61c3af7b847fcc9ebc490f1e5f3969b9 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Fri, 15 Jan 2016 03:47:05 -0500
 Subject: [PATCH] policy/modules/system/init: make init_t MLS trusted for
@@ -27,7 +27,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 4 insertions(+)
 
 diff --git a/policy/modules/system/init.te b/policy/modules/system/init.te
-index 809019873..be9c75155 100644
+index e724c295e..6ffdb547f 100644
 --- a/policy/modules/system/init.te
 +++ b/policy/modules/system/init.te
 @@ -238,6 +238,10 @@ mls_process_write_all_levels(init_t)
diff --git a/recipes-security/refpolicy/refpolicy/0047-policy-modules-system-systemd-make-systemd-tmpfiles_.patch b/recipes-security/refpolicy/refpolicy/0047-policy-modules-system-systemd-make-systemd-tmpfiles_.patch
index 1b90ba6..8b57c70 100644
--- a/recipes-security/refpolicy/refpolicy/0047-policy-modules-system-systemd-make-systemd-tmpfiles_.patch
+++ b/recipes-security/refpolicy/refpolicy/0047-policy-modules-system-systemd-make-systemd-tmpfiles_.patch
@@ -1,4 +1,4 @@
-From 3fab5273a7721e603f2034badeaf73949aaa59a2 Mon Sep 17 00:00:00 2001
+From f87ab013d4dffe5b588376b73c51fbfc5e9b1205 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Thu, 4 Feb 2016 06:03:19 -0500
 Subject: [PATCH] policy/modules/system/systemd: make systemd-tmpfiles_t domain
@@ -43,10 +43,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 5 insertions(+)
 
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index 03aeb8515..e483d8aea 100644
+index 24fc90838..dc3badece 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -1877,6 +1877,11 @@ sysnet_relabel_config(systemd_tmpfiles_t)
+@@ -1970,6 +1970,11 @@ sysnet_relabel_config(systemd_tmpfiles_t)
  
  systemd_log_parse_environment(systemd_tmpfiles_t)
  
diff --git a/recipes-security/refpolicy/refpolicy/0048-policy-modules-system-systemd-systemd-make-systemd_-.patch b/recipes-security/refpolicy/refpolicy/0048-policy-modules-system-systemd-systemd-make-systemd_-.patch
index e3d5db1..c4b799e 100644
--- a/recipes-security/refpolicy/refpolicy/0048-policy-modules-system-systemd-systemd-make-systemd_-.patch
+++ b/recipes-security/refpolicy/refpolicy/0048-policy-modules-system-systemd-systemd-make-systemd_-.patch
@@ -1,4 +1,4 @@
-From 4eaa766ef11cb053f010bcde5121e76031aae799 Mon Sep 17 00:00:00 2001
+From ec080f2b0b18b29e46bded08a0880624e5380026 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Thu, 18 Jun 2020 09:59:58 +0800
 Subject: [PATCH] policy/modules/system/systemd: systemd-*: make systemd_*_t
@@ -43,10 +43,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 12 insertions(+)
 
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index e483d8aea..a0e6bb405 100644
+index dc3badece..0440b4795 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -391,6 +391,9 @@ files_search_var_lib(systemd_backlight_t)
+@@ -430,6 +430,9 @@ files_search_var_lib(systemd_backlight_t)
  fs_getattr_all_fs(systemd_backlight_t)
  fs_search_cgroup_dirs(systemd_backlight_t)
  
@@ -56,7 +56,7 @@ index e483d8aea..a0e6bb405 100644
  #######################################
  #
  # Binfmt local policy
-@@ -560,6 +563,9 @@ term_use_unallocated_ttys(systemd_generator_t)
+@@ -603,6 +606,9 @@ term_use_unallocated_ttys(systemd_generator_t)
  
  udev_read_runtime_files(systemd_generator_t)
  
@@ -66,7 +66,7 @@ index e483d8aea..a0e6bb405 100644
  ifdef(`distro_gentoo',`
  	corecmd_shell_entry_type(systemd_generator_t)
  ')
-@@ -1009,6 +1015,9 @@ userdom_setattr_user_ttys(systemd_logind_t)
+@@ -1058,6 +1064,9 @@ userdom_setattr_user_ttys(systemd_logind_t)
  userdom_use_user_ttys(systemd_logind_t)
  domain_read_all_domains_state(systemd_logind_t)
  
@@ -76,7 +76,7 @@ index e483d8aea..a0e6bb405 100644
  # Needed to work around patch not yet merged into the systemd-logind supported on RHEL 7.x
  # The change in systemd by Nicolas Iooss on 02-Feb-2016 with hash 4b51966cf6c06250036e428608da92f8640beb96
  # should fix the problem where user directories in /run/user/$UID/ are not getting the proper context
-@@ -1591,6 +1600,9 @@ udev_read_runtime_files(systemd_rfkill_t)
+@@ -1681,6 +1690,9 @@ udev_read_runtime_files(systemd_rfkill_t)
  
  systemd_log_parse_environment(systemd_rfkill_t)
  
diff --git a/recipes-security/refpolicy/refpolicy/0049-policy-modules-system-logging-add-the-syslogd_t-to-t.patch b/recipes-security/refpolicy/refpolicy/0049-policy-modules-system-logging-add-the-syslogd_t-to-t.patch
index 6ea1efd..06e4775 100644
--- a/recipes-security/refpolicy/refpolicy/0049-policy-modules-system-logging-add-the-syslogd_t-to-t.patch
+++ b/recipes-security/refpolicy/refpolicy/0049-policy-modules-system-logging-add-the-syslogd_t-to-t.patch
@@ -1,4 +1,4 @@
-From de58aa981e1c05ce06938704089c7c87c765add6 Mon Sep 17 00:00:00 2001
+From 564d43016ed6dcbadb7a7203d8d639d0c782d4e7 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/system/logging: add the syslogd_t to trusted
@@ -18,10 +18,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 3 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index 3cab14381..caf319f04 100644
+index dca46f105..cedcaeb36 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
-@@ -491,6 +491,9 @@ fs_getattr_all_fs(syslogd_t)
+@@ -495,6 +495,9 @@ fs_list_tmpfs(syslogd_t)
  fs_search_auto_mountpoints(syslogd_t)
  
  mls_file_write_all_levels(syslogd_t) # Need to be able to write to /var/run/ and /var/log directories
diff --git a/recipes-security/refpolicy/refpolicy/0050-policy-modules-system-init-make-init_t-MLS-trusted-f.patch b/recipes-security/refpolicy/refpolicy/0050-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
index 9089cb2..1a0aded 100644
--- a/recipes-security/refpolicy/refpolicy/0050-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
+++ b/recipes-security/refpolicy/refpolicy/0050-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
@@ -1,4 +1,4 @@
-From a9ceec99a527007a91ba6685d0b86c327fbb6443 Mon Sep 17 00:00:00 2001
+From c49b89d2a6cfc33c0e6fe6347609fea09ae7fe2e Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 28 May 2019 16:41:37 +0800
 Subject: [PATCH] policy/modules/system/init: make init_t MLS trusted for
@@ -17,7 +17,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/init.te b/policy/modules/system/init.te
-index be9c75155..458906ac5 100644
+index 6ffdb547f..8bd8e2f63 100644
 --- a/policy/modules/system/init.te
 +++ b/policy/modules/system/init.te
 @@ -237,6 +237,7 @@ mls_file_write_all_levels(init_t)
diff --git a/recipes-security/refpolicy/refpolicy/0051-policy-modules-system-init-all-init_t-to-read-any-le.patch b/recipes-security/refpolicy/refpolicy/0051-policy-modules-system-init-all-init_t-to-read-any-le.patch
index 687e1c9..a362c4b 100644
--- a/recipes-security/refpolicy/refpolicy/0051-policy-modules-system-init-all-init_t-to-read-any-le.patch
+++ b/recipes-security/refpolicy/refpolicy/0051-policy-modules-system-init-all-init_t-to-read-any-le.patch
@@ -1,4 +1,4 @@
-From 980d9d3f3c3e1e3517971715c351ec7b747105d0 Mon Sep 17 00:00:00 2001
+From f8b5f66dd987609027d8e0381338e39b52a47138 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Wed, 3 Feb 2016 04:16:06 -0500
 Subject: [PATCH] policy/modules/system/init: all init_t to read any level
@@ -22,7 +22,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 3 insertions(+)
 
 diff --git a/policy/modules/system/init.te b/policy/modules/system/init.te
-index 458906ac5..c2380d8b4 100644
+index 8bd8e2f63..8af34aa7e 100644
 --- a/policy/modules/system/init.te
 +++ b/policy/modules/system/init.te
 @@ -243,6 +243,9 @@ mls_key_write_all_levels(init_t)
diff --git a/recipes-security/refpolicy/refpolicy/0052-policy-modules-system-logging-allow-auditd_t-to-writ.patch b/recipes-security/refpolicy/refpolicy/0052-policy-modules-system-logging-allow-auditd_t-to-writ.patch
index 64a1dfc..a5a368b 100644
--- a/recipes-security/refpolicy/refpolicy/0052-policy-modules-system-logging-allow-auditd_t-to-writ.patch
+++ b/recipes-security/refpolicy/refpolicy/0052-policy-modules-system-logging-allow-auditd_t-to-writ.patch
@@ -1,4 +1,4 @@
-From 2b64eabf0cf8982bbb3c537e84fc3a99085858d3 Mon Sep 17 00:00:00 2001
+From d6573102f922b0e08d49cb5582612dfbaae10600 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Thu, 25 Feb 2016 04:25:08 -0500
 Subject: [PATCH] policy/modules/system/logging: allow auditd_t to write socket
@@ -22,10 +22,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index caf319f04..25e1d1397 100644
+index cedcaeb36..1b181f7cc 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
-@@ -235,6 +235,8 @@ miscfiles_read_localization(auditd_t)
+@@ -236,6 +236,8 @@ miscfiles_read_localization(auditd_t)
  
  mls_file_read_all_levels(auditd_t)
  mls_file_write_all_levels(auditd_t) # Need to be able to write to /var/run/ directory
diff --git a/recipes-security/refpolicy/refpolicy/0053-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch b/recipes-security/refpolicy/refpolicy/0053-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
index 4f3253d..d48db28 100644
--- a/recipes-security/refpolicy/refpolicy/0053-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
+++ b/recipes-security/refpolicy/refpolicy/0053-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
@@ -1,4 +1,4 @@
-From 35351cd7cb07622b5e43254b95d7801a5669358d Mon Sep 17 00:00:00 2001
+From 6b77c79af18f6dba52b7a63a7a2aefdd48c0fd33 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Thu, 31 Oct 2019 17:35:59 +0800
 Subject: [PATCH] policy/modules/kernel/kernel: make kernel_t MLS trusted for
@@ -15,10 +15,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/kernel/kernel.te b/policy/modules/kernel/kernel.te
-index b4b089823..5835d28b2 100644
+index ebde22e02..60e805cb8 100644
 --- a/policy/modules/kernel/kernel.te
 +++ b/policy/modules/kernel/kernel.te
-@@ -384,6 +384,7 @@ mls_socket_write_all_levels(kernel_t)
+@@ -385,6 +385,7 @@ mls_socket_write_all_levels(kernel_t)
  mls_fd_use_all_levels(kernel_t)
  # https://bugzilla.redhat.com/show_bug.cgi?id=667370
  mls_file_downgrade(kernel_t)
diff --git a/recipes-security/refpolicy/refpolicy/0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch b/recipes-security/refpolicy/refpolicy/0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch
index 5118ef8..a5c17de 100644
--- a/recipes-security/refpolicy/refpolicy/0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch
+++ b/recipes-security/refpolicy/refpolicy/0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch
@@ -1,4 +1,4 @@
-From 6d6e2d34ec63771a01ef258c98f1ad49efdc2f67 Mon Sep 17 00:00:00 2001
+From 03e4c0afc4a0aa432b30e9b5e8abbe069871fb9e Mon Sep 17 00:00:00 2001
 From: Roy Li <rongqing.li@windriver.com>
 Date: Sat, 22 Feb 2014 13:35:38 +0800
 Subject: [PATCH] policy/modules/system/setrans: allow setrans_t use fd at any
@@ -13,7 +13,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/system/setrans.te b/policy/modules/system/setrans.te
-index 12e66aad9..5510f7fac 100644
+index 0a87a8d70..738badc52 100644
 --- a/policy/modules/system/setrans.te
 +++ b/policy/modules/system/setrans.te
 @@ -69,6 +69,8 @@ mls_net_receive_all_levels(setrans_t)
diff --git a/recipes-security/refpolicy/refpolicy/0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch b/recipes-security/refpolicy/refpolicy/0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch
index 3e75257..9e46a43 100644
--- a/recipes-security/refpolicy/refpolicy/0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch
+++ b/recipes-security/refpolicy/refpolicy/0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch
@@ -1,4 +1,4 @@
-From 3d5751659380eb04b63f8fc1e6113132dd1310d7 Mon Sep 17 00:00:00 2001
+From 1ca4caa4600e9b742f0c7816efe8cff153fe412a Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Mon, 22 Feb 2021 11:28:12 +0800
 Subject: [PATCH] policy/modules/system/systemd: make *_systemd_t MLS trusted
@@ -24,10 +24,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 3 insertions(+)
 
 diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
-index d7219dc37..7717e0034 100644
+index 96b5d31b4..07c506e1c 100644
 --- a/policy/modules/system/systemd.if
 +++ b/policy/modules/system/systemd.if
-@@ -226,6 +226,9 @@ template(`systemd_role_template',`
+@@ -228,6 +228,9 @@ template(`systemd_role_template',`
  		xdg_read_config_files($1_systemd_t)
  		xdg_read_data_files($1_systemd_t)
  	')
diff --git a/recipes-security/refpolicy/refpolicy/0056-policy-modules-system-logging-make-syslogd_runtime_t.patch b/recipes-security/refpolicy/refpolicy/0056-policy-modules-system-logging-make-syslogd_runtime_t.patch
index d07fa91..cc8a416 100644
--- a/recipes-security/refpolicy/refpolicy/0056-policy-modules-system-logging-make-syslogd_runtime_t.patch
+++ b/recipes-security/refpolicy/refpolicy/0056-policy-modules-system-logging-make-syslogd_runtime_t.patch
@@ -1,4 +1,4 @@
-From 2476910f6d7f116148bb9311498b5c98692c1ef3 Mon Sep 17 00:00:00 2001
+From 8e5a17676c9976d163b70edd31834c4e16405ed9 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Sat, 18 Dec 2021 17:31:45 +0800
 Subject: [PATCH] policy/modules/system/logging: make syslogd_runtime_t MLS
@@ -31,10 +31,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index 25e1d1397..ba0fd10e0 100644
+index 1b181f7cc..d5878876b 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
-@@ -456,6 +456,8 @@ allow syslogd_t syslogd_runtime_t:file map;
+@@ -459,6 +459,8 @@ allow syslogd_t syslogd_runtime_t:file map;
  manage_files_pattern(syslogd_t, syslogd_runtime_t, syslogd_runtime_t)
  files_runtime_filetrans(syslogd_t, syslogd_runtime_t, file)
  
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 8c9d046..f8e5f10 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -48,12 +48,14 @@ SRC_URI += " \
         file://0030-policy-modules-kernel-files-add-rules-for-the-symlin.patch \
         file://0031-policy-modules-system-logging-fix-auditd-startup-fai.patch \
         file://0032-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch \
-        file://0034-policy-modules-system-systemd-enable-support-for-sys.patch \
-        file://0035-policy-modules-system-logging-allow-systemd-tmpfiles.patch \
-        file://0036-policy-modules-system-systemd-allow-systemd_logind_t.patch \
-        file://0037-policy-modules-roles-sysadm-allow-sysadm-to-use-init.patch \
-        file://0038-policy-modules-system-systemd-systemd-user-fixes.patch \
-        file://0040-policy-modules-system-logging-grant-getpcap-capabili.patch \
+        file://0033-policy-modules-system-systemd-enable-support-for-sys.patch \
+        file://0034-policy-modules-system-logging-allow-systemd-tmpfiles.patch \
+        file://0035-policy-modules-system-systemd-allow-systemd_logind_t.patch \
+        file://0036-policy-modules-roles-sysadm-allow-sysadm-to-use-init.patch \
+        file://0037-policy-modules-system-systemd-systemd-user-fixes.patch \
+        file://0038-policy-modules-system-logging-grant-getpcap-capabili.patch \
+        file://0039-policy-modules-system-allow-services-to-read-tmpfs-u.patch \
+        file://0040-policy-modules-kernel-domain-allow-all-domains-to-co.patch \
         file://0041-policy-modules-system-mount-make-mount_t-domain-MLS-.patch \
         file://0042-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch \
         file://0043-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch \
@@ -70,7 +72,6 @@ SRC_URI += " \
         file://0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
         file://0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
         file://0056-policy-modules-system-logging-make-syslogd_runtime_t.patch \
-        file://0057-Allow-services-to-read-tmpfs-under-run-credentials.patch \
         "
 
 S = "${WORKDIR}/refpolicy"
diff --git a/recipes-security/refpolicy/refpolicy_git.inc b/recipes-security/refpolicy/refpolicy_git.inc
index 4043005..22f28ba 100644
--- a/recipes-security/refpolicy/refpolicy_git.inc
+++ b/recipes-security/refpolicy/refpolicy_git.inc
@@ -1,8 +1,8 @@
-PV = "2.20240226+git"
+PV = "2.20240916+git"
 
 SRC_URI = "git://github.com/SELinuxProject/refpolicy.git;protocol=https;branch=main;name=refpolicy;destsuffix=refpolicy"
 
-SRCREV_refpolicy ?= "351a5a7f4dc959769aaa8fe47c6e77f94fe5b657"
+SRCREV_refpolicy ?= "741dc96eb7e737bc2f00b7f4b4b394a66d32d913"
 
 UPSTREAM_CHECK_GITTAGREGEX = "RELEASE_(?P<pver>\d+_\d+)"
 
-- 
2.25.1


