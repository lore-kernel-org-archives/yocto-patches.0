Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9098C28B20
	for <webhook@archiver.kernel.org>; Wed,  2 Apr 2025 06:06:17 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.1463.1743573973166477737
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 01 Apr 2025 23:06:13 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=61876035f4=yi.zhao@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5325AT6D029789
	for <yocto-patches@lists.yoctoproject.org>; Wed, 2 Apr 2025 06:06:12 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45rtd4ravt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 02 Apr 2025 06:06:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7bwoXGlusHa4FvsnsFzAE/THepuyjsBmHxDJkVqtnA8Ixw6m3NcoWSvs6dC0dRZt0q8q6WcuVn2axRBqIZvP/FKRdC/SSy6cFd3EWvnDvrxInhG66D6cIHc+tDQmWbGNw06psmV5qrXzfPd16Y7yUWQwYe4RO5uiO7WIi065a9D0wKY4q7oZBwdsp+2F6h3MNafXNSSf/d/kLjsud9OVGlPc9qonP0AqoPlSF95z3Fq/YG+sP/A+JYUTwu/AHpHnytnM55PUyLtLvLRMWsqmT8mUmORk94XVfMZn9zKx84c1BF6JUrvyzSt/69Dcng8BUnsr/73RI9UFPsw7Ny0QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IioYyaIaa5tFCwXibVEfgtU0NdKmUumQZya93Jjh6m0=;
 b=y3vdeVwViu0Bdi9Zb9XIv2OoRJfoZsQvSC4vrfuRQZ3lCes2OGgiWxOSeEqHQg4b5Wbm4vqQ4TIteZh4ddEtB7154PRpmdtQPMVbJVkT3DA5I4JGYuPfhlLUMnXdeXs2TNkt0rX02zr0YbgVTzmLz6ooKqn2+nqde+YlZz5RPcYdEZPYfw8cvAtb4hFK4gZ9352wkmcAOO1eEd87v8gDzZZuK6qGxn20GdPfD6LwCd/vJEKe6EKM6EUylyh7mCDwRpQOYUOl7CS0XNhLPSKhbEiJFkoHphPzljDtl/GB4lebG35ymrtgV6YIuE/NX9FXgaPHEXMWAI/UAxaeFhCReg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 CH0PR11MB8085.namprd11.prod.outlook.com (2603:10b6:610:183::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 06:06:09 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%5]) with mapi id 15.20.8534.048; Wed, 2 Apr 2025
 06:06:09 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH] refpolicy: update to latest rev
Date: Wed,  2 Apr 2025 14:05:56 +0800
Message-Id: <20250402060556.3627656-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0078.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::14) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|CH0PR11MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: daf9e7b3-6193-4837-cbd8-08dd71ac7696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?9VPHv2W93YdU8rQGoKTGk3yjUC7MPHQzx2zJwELKqLrESC+y7U5uONDoQn7x?=
 =?us-ascii?Q?zFdbdL0dZ0nuewuskUi8GY9DmvCVFIimrRVix+DiUtyY/DPWOOTXxpuC97in?=
 =?us-ascii?Q?c/qPNy2/zl7BfvHHL9dI+xr2JBnNblqoOSBTILUDPVELvNLfaUl6CvDjX0uc?=
 =?us-ascii?Q?wrEZSpbhVK4FvgD3X1b/me+sbL8yfHscPvoiS0QRUOvH1sDmBhOyqe+imwww?=
 =?us-ascii?Q?c1WvMRH4/j+VQM8Se9VduVeufcvmlNgy7ZGEQZQKhILxrOrD4SL4YesI+pNO?=
 =?us-ascii?Q?jYVd6cDGzaavjh2YU2fzAU1af+rE8g3GD/QmdsIGCTjqgBjO7QRaM2nfQE5R?=
 =?us-ascii?Q?qJVsSiulAjbaIJKlUjS6lzWRxxg+4R95pwlg2K/ds2MZSPJNVFwzke/7ppLC?=
 =?us-ascii?Q?ykTpQBZ8IE/XgzCKdMvvp9xBTS2Pit4csmByIQ3ijJ1PTmOF/bNs8Ep/CIKd?=
 =?us-ascii?Q?yrat2YDacuiPFw7kriX9/lp1tWIE4pfpbNFqhnDT9gen93aeOqZF69E6G6HK?=
 =?us-ascii?Q?9Aaf7YqBdDE63tw9aXQbGadjx1AvIMzc+cUedYxIslRJIGLMaTlrnnymJVNy?=
 =?us-ascii?Q?1cHXcWEXC8zOLdFvzZ0CKsX5uKngxAqv6bN7FduMSakzk2EzBOXgZNe9HLxq?=
 =?us-ascii?Q?ho5HP4wF11Hd+ZQn5QGjWiIKnq8dOKgpGXaPgqQn+PkDkMpNys3ZPTCM72pI?=
 =?us-ascii?Q?t4V/zMb4d5N/LVELXWFxAfSrMoAXSMojKqFy26Yu2L4wegNs/M7y7JEHk0+7?=
 =?us-ascii?Q?yy6fGiTQbY8anLgZb8kNzdgZYtZLNamSZM19Dh1o2XCa2r0MzXDfDBL2ZuKb?=
 =?us-ascii?Q?3cGtanlKCAVNTXUh2EH0WUEQL0i1btsAuZvTfuY1kZtbQdZ6Fov9ttRL8Xpp?=
 =?us-ascii?Q?1NKD9rMnWodVdsSP1Un+gCEDMPTAvKX2SZTnqKFMLRYEuGKClIVt9L/otshX?=
 =?us-ascii?Q?E8nhGsyRKEyVUkILW/iqUQIQcbDGX2Nhfa6bgHrZZTz/yyqez3s5fi3b0Twy?=
 =?us-ascii?Q?Zd4AThcBcbaU4jCKv1THLxmdaWWiwLiaRkf0mS0w9lB5IsELP0StfBJTZObW?=
 =?us-ascii?Q?EbkyILvJquLAvESBPvKBLOQZ5qI4871KJEFdFeWNZuLW4IgHonP8qEk6pSKE?=
 =?us-ascii?Q?b6aR5eOQG8951IUfdwjJNGmlzywiuZoXOZrxiGqb0HJIzCIH4C59B6BFFIxy?=
 =?us-ascii?Q?fwjHzSDPRuXLZedjWcJnYeURlsK2uc9hh2VjNnOdQts8O16Di2uFIXzowVrQ?=
 =?us-ascii?Q?hUfRAgcEJBa8238aEEf/E80iyJNl2XwUs/1AW5VWFxpsRkaqMKs7YPlPK3oN?=
 =?us-ascii?Q?052G14ly+QoiK0Z+YmiSkvEkd9OWau3maMsOnCyRq1jHCjOT3xqWjbPk9K4r?=
 =?us-ascii?Q?rUAn6IhzEI1wV9o0C1AK4H+hKfBYC/gpg7Kuu6TfnV9HV7vSX6J8zgiV/2HG?=
 =?us-ascii?Q?cwcpDZGPc9cAOHnwfXhPL34F8lbqqm/R?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?R4CzT8acFmODPro0QAfsOr/io+/1WkeMLliHHrsefX7kyAzysUuXQyHYIbRw?=
 =?us-ascii?Q?9Ly3qK0e7nu7KHchQn5BOe1/Ng5CrBB9ENCV41kUmDoshq7UX4tbhN7HjdiS?=
 =?us-ascii?Q?Q9wnCaBlSzTgVa+8ON5vdrLsUiyyfgDf6aWYVyxFdhufay/fHbDqacfhjK+o?=
 =?us-ascii?Q?FyT/H3lLaYYZyz8zzPEri2fVXLzol2RbnKGl/kysUcE77xdlqkOi2cCAhC0i?=
 =?us-ascii?Q?LE6GZ4vqPdSdV5rrWCexNSzqC9tGmBTG5uDK/v1pBX1sIMCLXtWFsvI+I4Us?=
 =?us-ascii?Q?lPz1dow32XKh9HhNdhnMOVSQwd1XJeLPFOfczs9ZlA1R4CKBhOghkZ3Ml28L?=
 =?us-ascii?Q?38cWygWnEcBxn8S4SqpWltg59W8VlpsN9XQFhq2NtBl7sJ1+InU6VQVLV4cv?=
 =?us-ascii?Q?NldjZ0HS98L33g9be10sHU7UWyeJ63teUihOCYxmv2JTzDbWUeoy9GbVLH32?=
 =?us-ascii?Q?695AspL7tjxCDEgLeRWWw57y+JiOTeTT4YCnvpzOx7TJYrukvWQ/F+P1+NyS?=
 =?us-ascii?Q?GmijRernoWxLHUXJ3TfAqAT1obEZo1ZIRni0Qb8Ng3aVSykRKPPVEnqSgqfs?=
 =?us-ascii?Q?SvgPE+JpOMphsiSdlqV5tlQonbdV4zc1pTXnfi1MAVgdVZpbSrw1dmvY+DUy?=
 =?us-ascii?Q?AHuAwd+d6UyBvbo3xD9Gvzv/I3Q9fzJvn7Z5olRC8TdBBWC7Tt1OE5beimCa?=
 =?us-ascii?Q?sJ544heK0C6ISQ55oawr1sfcyf3HLEwEO/VK0SrfuudYvC4ZbHr+iIIulqLL?=
 =?us-ascii?Q?1gZQXRyBk1Y8EeI1xfU5FF1Cm5k58kJlmfDOKMZKBwOg18KClqlEaJF6IpM4?=
 =?us-ascii?Q?icW+M7UM+LcB/5i+FhpG04LlD+gHvzEpj9Um560fNXgVm0ug8TcG7b+9Mwu2?=
 =?us-ascii?Q?swCyoSD5Rg+Orhw/4mWgg39FBnGoG15jux8Jgx4QaMDlQ3wW7zKF6MLWERNm?=
 =?us-ascii?Q?zpgpmsp9iwJFCN38LKlJhxRKu5jQBjNTPZ0ZZAG5bytaJbiOy28JeP8HVWjN?=
 =?us-ascii?Q?rtSdHS4HkGPKeJdQxtcwkcoyQEGmOYpHWugR3jiwkiVRaXBbFsCD5mFX8GvU?=
 =?us-ascii?Q?9EDf9alXtyelTe8v0wbQR1gqPlZ8s5FMF3Ylga4Jzp55prj9wo7zynSW1CWr?=
 =?us-ascii?Q?04u9G6JxD27bUEF2sPKo9cYG/Q+HOVbe84A9DWqm8trXGPMdRsS2ay1wh3qS?=
 =?us-ascii?Q?nrNiyRQgsFIQ1sSazPl+HvGFGf4hZzWMIsa/zpW+zP1jsDqhwTYVsAKIwTqk?=
 =?us-ascii?Q?QuZL2GE+YsBOHmWJHGCSGxAIekrt2qCHWSerATICcyCkRYXdcR028kwuuZ+m?=
 =?us-ascii?Q?kRDpwRxRi+4ghgp3zlMBESrV7R5WCWoUDAB1vNK6MV0CkzVBDe01HJ16FmnU?=
 =?us-ascii?Q?5OBxlHgVAR2uIgM4itn7o5UgcxXBzgN2k9SdXFNo3dqkeTSbS3OYtsl9VgKP?=
 =?us-ascii?Q?tJnkLnfPiKNRicHTcMkgVFzlDRcg/Wq1OWNVjknbr6y27KJLeWtaRBzjHIUe?=
 =?us-ascii?Q?phNR9b6kdkDDonSuzIma1QdqVpxOTe6u3BCnZFSDzXSb6SnNT+5pCXU5jzAS?=
 =?us-ascii?Q?n7qcEUunlhDKmTpL9b00oqi4l460RRzAV9ct8ka/?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daf9e7b3-6193-4837-cbd8-08dd71ac7696
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 06:06:09.6103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLDmuFzWdFMPceGNT1HwemIncd2hqW7uB2I6UfLYCLcZM6oQmE9aOh6Zii5mQXl5ZzssIxpOlhaZnRPfeJJ9Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8085
X-Proofpoint-GUID: g0W0tlHaOVhAmAb1HQCDp7NHQ1n9jA13
X-Proofpoint-ORIG-GUID: g0W0tlHaOVhAmAb1HQCDp7NHQ1n9jA13
X-Authority-Analysis: v=2.4 cv=famty1QF c=1 sm=1 tr=0 ts=67ecd3d4 cx=c_pps a=7Qu+2NBwJcyibZ5HEcOKcA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=H5OGdu5hBBwA:10 a=t7CeM3EgAAAA:8 a=NEAV23lmAAAA:8 a=tFaZdj1GPJY2ZAAytJkA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_02,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504020037
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 02 Apr 2025 06:06:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1275

* d05a0d068 networkmanager: Watch systemd directories for
            nm-session-monitor.
* 3a60340e9 systemd: allow systemd-hostnamed and systemd-rfkill to get
            attributes of nsfs inodes
* ccbf1d66f fixup! Allow to specify module version
* d664ebbaa Allow to specify module version
* 1c8a95dbc Fix mislabeling of /etc/shadow
* ec2b2befd locallogin: allow sulogin_t unconfined domtrans
* 450522052 use init_use_script_ptys for knotc in initscript
* 79dda56d3 locallogin: dontaudit sulogin_t checkpoint_restore
* 4b3b8e7ce lldpad: Configure FW-LLDP on i40e NICs.
* ed9d87976 Revert "Merge pull request #867 from PPN-SD/upd-knot-sel"
* e053fced8 files, init: filetrans /run/machine-id etc_runtime_t
* c5a76add7 firewalld: fix firewalld_t firewalld_tmpfs_t exec
* 8a4043060 firewalld: fix lib_t Python cache denial auditing
* bcb8e1d4d unconfined: fix oddjob security_compute_sid
* ec8a5080a Permit init_t to start a detached screen session
* b025e0ec4 Add setcap to knotd / add knotc_initrc_domtrans
* 231960371 chronyd: fix dac_read_search denials

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...stemd-tmpfiles-to-read-bin_t-symlink.patch | 26 ++++---------------
 recipes-security/refpolicy/refpolicy_git.inc  |  2 +-
 2 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/recipes-security/refpolicy/refpolicy/0041-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch b/recipes-security/refpolicy/refpolicy/0041-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch
index f3833a4..47209ea 100644
--- a/recipes-security/refpolicy/refpolicy/0041-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch
+++ b/recipes-security/refpolicy/refpolicy/0041-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch
@@ -1,4 +1,4 @@
-From a39879ca482b525ae2b48bf8708615c923df0575 Mon Sep 17 00:00:00 2001
+From f3f3623bf112dee989cae09a5b9842c78655f220 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 18 Feb 2025 15:26:19 +0800
 Subject: [PATCH] systemd: allow systemd-tmpfiles to read bin_t symlink
@@ -19,8 +19,8 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  policy/modules/kernel/corecommands.fc |  1 +
  policy/modules/kernel/corecommands.if | 18 ++++++++++++++++++
  policy/modules/system/systemd.if      |  1 +
- policy/modules/system/systemd.te      |  5 +++++
- 4 files changed, 25 insertions(+)
+ policy/modules/system/systemd.te      |  3 +++
+ 4 files changed, 23 insertions(+)
 
 diff --git a/policy/modules/kernel/corecommands.fc b/policy/modules/kernel/corecommands.fc
 index 65178ba32..c7e3d2dae 100644
@@ -73,26 +73,10 @@ index 99318a3c2..7654d1076 100644
  	domtrans_pattern($1_systemd_t, systemd_tmpfiles_exec_t, $1_systemd_tmpfiles_t)
  	read_files_pattern($1_systemd_t, $1_systemd_tmpfiles_t, $1_systemd_tmpfiles_t)
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index 23f7a6027..c605d58de 100644
+index 64f13e247..c605d58de 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -817,6 +817,7 @@ files_read_etc_files(systemd_hostnamed_t)
- files_read_etc_runtime_files(systemd_hostnamed_t)
- 
- fs_getattr_all_fs(systemd_hostnamed_t)
-+fs_getattr_nsfs_files(systemd_hostnamed_t)
- 
- init_delete_runtime_files(systemd_hostnamed_t)
- init_read_runtime_files(systemd_hostnamed_t)
-@@ -1705,6 +1706,7 @@ manage_files_pattern(systemd_rfkill_t, systemd_rfkill_var_lib_t, systemd_rfkill_
- init_var_lib_filetrans(systemd_rfkill_t, systemd_rfkill_var_lib_t, dir)
- 
- fs_getattr_all_fs(systemd_rfkill_t)
-+fs_getattr_nsfs_files(systemd_rfkill_t)
- 
- kernel_getattr_proc(systemd_rfkill_t)
- kernel_read_kernel_sysctls(systemd_rfkill_t)
-@@ -1930,6 +1932,9 @@ kernel_getattr_proc(systemd_tmpfiles_t)
+@@ -1932,6 +1932,9 @@ kernel_getattr_proc(systemd_tmpfiles_t)
  kernel_read_kernel_sysctls(systemd_tmpfiles_t)
  kernel_read_network_state(systemd_tmpfiles_t)
  
diff --git a/recipes-security/refpolicy/refpolicy_git.inc b/recipes-security/refpolicy/refpolicy_git.inc
index 94b3379..a4ffd5c 100644
--- a/recipes-security/refpolicy/refpolicy_git.inc
+++ b/recipes-security/refpolicy/refpolicy_git.inc
@@ -2,7 +2,7 @@ PV = "2.20250213+git"
 
 SRC_URI = "git://github.com/SELinuxProject/refpolicy.git;protocol=https;branch=main;name=refpolicy;destsuffix=refpolicy"
 
-SRCREV_refpolicy = "badb91ce49e20449b1a73cd98dc9250b622ed369"
+SRCREV_refpolicy = "ffc9c4e16cef451bf1d1a1de44bb738aa342c69d"
 
 UPSTREAM_CHECK_GITTAGREGEX = "RELEASE_(?P<pver>\d+_\d+)"
 
-- 
2.34.1


