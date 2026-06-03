Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679E6CD6E55
	for <webhook@archiver.kernel.org>; Wed,  3 Jun 2026 15:27:40 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23230.1780500450415139737
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 03 Jun 2026 08:27:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=bAjxVITR;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=0614749be0=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653EEkPU4164701
	for <yocto-patches@lists.yoctoproject.org>; Wed, 3 Jun 2026 15:27:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=aQUO8tDJ2+YDYV0faITw
	tAfawYGrfWAQedZi5m+njSA=; b=bAjxVITRkF3bR97TXogD59IU3pZpRC0XP1pd
	PePf11RFvz9XEp5ZMp0o36xM/bKKEmfYh2IjH5NrfCr3p/Nc1QQHsZM/UUqjR+nj
	2Zw4koG43GSVw8ABmGJGHKpL/MvmS8B2r2Ui7cwB4WRuUjigtBgwCc1PoKLsIYqN
	4yTvez0ez9jksQfLsbp8+SX1jraP7i1SMtkp2/AJg3+Fv8NeB/FGa2TsXYU2tPmr
	MXAGt8OtfmPZW2DYxj6h94Q/bYNQCu+SREiSVnxQtihGbqBXHYukZjIdrm/xCsrd
	5qqvZtyq/VS3ZB79TnngKvDxeeGxLJcHgpjqyRmOADfzkpnggA==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4efpv8f093-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 03 Jun 2026 15:27:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwcIOmOxKpy1xhDWW3GhVb8pvkptb8LMvc2SCnfvqnfk0JLLqcEcnJfvzDBXxD4FsYkmJ0NxSf5ytPsywS9Q0QLExyt8292mmYQIgKE0yeAmPC0CzlX0ShxmFtP6ClRWNzwpU7aUM1Df4btqJaHJY1JPUq/KlWOs9Y4P4NPE6w2BpBO2I9jCnuIYWlp2NjUszQtMF9qYW1TYeEW8Dns375UERR7YRXNVoy7e0PGzTTHd3ywrTWXgJ+UzBk2uBNsIrck04qwGdZ3QSQ7YVraFJlAlpkEmxgA80I+aDxgfjlHcmDSiwoLRVhMwk5wKZZEGOW7FKThp76EDmF7+DCQwAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQUO8tDJ2+YDYV0faITwtAfawYGrfWAQedZi5m+njSA=;
 b=l40tsBg2Pf7DCPEHtQJc+lwpfV3pdKRd5RKtIG/V159mOOMZoYMt5RZOZUxNaEeZzoadReAETo2pfFv+ggxrzNlPAHn3+nswoIgUnmxfXSHn2YK+NIL+Jq9/Rhwo0RvNUBUfzwW2nyFvxf6dU0IuE9oUqiWwsNnlgU6urH7bQPQYDHJgm0pPOLScL0OQlCLj0PkufEBeAY0EF09/cxX0OGNlkce8vCXFI7BpM35ksuFJwAidSFK1y20SW8c6pXp3qZtkx/UhX8h6KoO+XRj4kFJA3wG8svH+UXV+ytkiKZr0J3VNMPZfstTaQitbL3ZZT1KmdyWlpxrfp6LP/+ZE6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 DSWPR11MB9738.namprd11.prod.outlook.com (2603:10b6:8:353::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.7; Wed, 3 Jun 2026 15:27:27 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 15:27:26 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH] refpolicy: update to latest git rev
Date: Wed,  3 Jun 2026 23:27:03 +0800
Message-Id: <20260603152703.3701434-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1PR01CA0154.apcprd01.prod.exchangelabs.com
 (2603:1096:820:149::8) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|DSWPR11MB9738:EE_
X-MS-Office365-Filtering-Correlation-Id: b163b93f-bb0b-417e-fe77-08dec1849d87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014|3023799007|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	QaUl5iIeOMOM19ajACwVtysEfMzEuVruonkv/ZDyzxxKhe9YHozH5OwzjKI2t68KxfwuQXikv31bOfaa/13NFfVocjVjOBfS2BOADY+lCHoriQCsvFgOcXzzD8VyOQGhvsSo5Rv7b2nppAz+4b826EJOk0UMCwk8jVsx9kmX/z4kaxi+tYAeoYKazQX5p2LJYJQolYSVWjMytaN8Ga+WTG4Zk0xl3dCzEBfnNJqYwno6OlCcF5v3ccdr6koagn6wpk2xjL2oXRUnqv7acCIqpdtWZyMDWf2bCwKvCTZ6Ybz1pWK/LRHBffq2agXKSdJ6f6a0QM1e85CEBnTwpvEZCyxAAtJ2zxQc3A2AgDJli4N/SnZGlkVLvI3yagbsRSi2JHy1jrgNKYHte2GVxtGCNhbwFfo4FaVKwV8XVyjZhZ2/6yLDyuVC5GUOb/TkYdWMQ6j8Jpa90aWabZixZzIaVNROMpQjZ1NwXyRjOyXqRUHBf6Y0gmJiK/TsutkWaErGbFXV3sfX6i8GSQTD5czx1KHTxqSfGn79D8ReCvGTNhOzKl2z8XTxO2AlAzJWDY2O6yd60xQsUdVpSHiMOv8SWtMPG0atIMFebhqRWlVy3RKlovT5a+bPRxNofPA4ujjperw/7kg9r6Q+H8DFKqpR5qaDS812M71JqowFA0XjniU8L1LLw4tRS0DWiEJEDJvitx8pYHVReS4PVI8ckNNvmQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014)(3023799007)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Bk3A76rLm0B5CEsBNXRVwpVroTYZ7wcc0pc92mvqDUHvwRLORBUl7VUgucSo?=
 =?us-ascii?Q?mCT6whSI+t782kFduYzqGnUFf0HJyU77o8soJBG1A+3iL9IMykslkwI/KjD7?=
 =?us-ascii?Q?OV9zT2HHu1LL+hxsJ9FBuCMwBNrAc+JoFO5UMdEWXZgn2Ytd+HY+CiZJDEj6?=
 =?us-ascii?Q?tzz+8GVw1ijRGZsQx+wQPUSj/EwGpr6Hw4eYRPlrNskcoqMep5zi5ngdbzNu?=
 =?us-ascii?Q?tW2kdGuUuk+/wX2aOGJcpjci3qdjk6/aB0JiD9PNIKF9RXZ4pETH3K6XWLFD?=
 =?us-ascii?Q?eaChOoV1HEmnb8bHiBnx4o8cAirQfq/kH/VzdD56NxCTXZA/hNmRRraWmbIN?=
 =?us-ascii?Q?vIzAXyOAv0c9KmRGE4NX7VRz/mPprv06Cko+izyiRjKkLyT8nT6JqNKW9J4r?=
 =?us-ascii?Q?4nzpl9sXBinSOFofSVy+jeGVBkecy//yyT7HWCfp40xhDiRQLdc/ZepVUrMi?=
 =?us-ascii?Q?bg8UYQpY6XIKZ6ruMMgmM/X6Vj23koiIHVEdz6XokXllnusM8mX55wg3P9a+?=
 =?us-ascii?Q?GMdkVLtcPa6GRUm7UNL5tDfDBsa+i++EbqRsIWuHtfM4qPwyF39d7C4tpQ1V?=
 =?us-ascii?Q?GPKuYM86l3Ak0wKFgLKLBehxKvZR+ji8EwXhu/PkklAsR+xqGnZF3VnxqwWS?=
 =?us-ascii?Q?ujHLXVfeeILOKJLtSa8XYDGR80yR6mjsAMhsXOntNXJ7sQLR9R8JUaug+trA?=
 =?us-ascii?Q?vdaVQe2ixBgufuGd3LfbSt8ySzYTNdz+KCsdmNBuDbipTMoKHmANkjLiEDCG?=
 =?us-ascii?Q?01Bq3jSvbMUPr25/HWi+2x+/RoIyagsToAW5V9D4Nvc6bYc5XrKlwkYHc95B?=
 =?us-ascii?Q?gKAO8fwO483cM84DgRJcycKYnimjOihK9Kkeg8/Kh68HgGM7rpUtuAAqN8Jr?=
 =?us-ascii?Q?eJ2QwFsqalubnyu4VrQ8f+vAeXjVhe4Y4JFgLsRKzPW6GnMqCHk2ASmLYDvs?=
 =?us-ascii?Q?J4QOcrEBtgxG5TPP+dGD6eCUZskBKn3AdpcI/NgawnnSqnn5+JKBx+ntHdtu?=
 =?us-ascii?Q?lj78nfNsn0QWxLa1/FAdXdQOGZQaV6wxW4wV30xECTeJ9cfBezik3RgKF+Iu?=
 =?us-ascii?Q?0B42CgEOiWY4Q1ELv5md5U/V61IHiZGrb3GoE9+zgRgRmhlDGRLYXCz6pm1d?=
 =?us-ascii?Q?AyO4oPO7uFzbp4IULAY6j+skzOy8jiSpHJkVa8R78sW8LokXFllAKcpujjMj?=
 =?us-ascii?Q?J1a1VZvtW2uKM5gly6lC78NWnAiM2fXjdjrhWCuWCjI0oyU2jHnof7753SRV?=
 =?us-ascii?Q?w+uTTab7r2FiYAZrOH/1nNMczGkXTur+gVfx5BQpTdcR5Bhe7jw/rkCIxCFE?=
 =?us-ascii?Q?avqzry2H1RAwlgPOTCfVGPoW4kCaXNP2a5hxUe+LPIps4yQW+vqhnsAY0EA1?=
 =?us-ascii?Q?LMXjyw5sWDPBqk0DxOhwZkJ02DXcng0HrxoUkSDu83zArl7+w79DENH6MWjv?=
 =?us-ascii?Q?VdXn0HBDCpxLjxFctKclks1H6d/ot7iiVir1zPT0KNUdexc+ohzQwvpHBoog?=
 =?us-ascii?Q?9wa87t3Te61bKDOJMzgOJklrvJSfNeBkSfReJNfCYfvwSbwSuNiyeZJPUt+w?=
 =?us-ascii?Q?uDM55T7B3XLw705j82C3YtLL4Au6PkVjSo77pogY96tVJ96AYIgsR18gWZgK?=
 =?us-ascii?Q?UCLbP6yJIl3v96ZQNyyGbqg3hWmf5sO+xphu0/7gHm+nY46X887cBj2wPqkY?=
 =?us-ascii?Q?0PUjAhJ14FN/xLBiiI552hrJa5+wBqqhUkkVxBeYrZBmCZewkmvNx6kOlXu+?=
 =?us-ascii?Q?dnBV/wO7+g=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	AR72B9P84ciQJ8znC2KJoGduSoTQUoLTdW1xZsaGAkVkt1cPMZ07lVzecvN320q2UrVpqjumRSzEBC/fgOAuygF20MUq3HXPksXTgYaTC/PVd2YSaWqCdTE/ORqG9xpk0Gnt6kXg0kewf1cnXgDSuTH0+k22YXSTzoNfIXoXFuXf43O03+IVegLH3uv4Qc/whHr26I7n/SUn4r4oN9dVzMNmuGR+Pjm1aiH5qGw6jveziNiUFOuoRFsK7/bdeZTl8ZKiNFTKBnjd61oFj0acyecmw0cXE6t28ILJFB0He10Ti9KheTfgosNUk76Yj/ATJicHqSf4Ry1CHlxG/PwpuA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b163b93f-bb0b-417e-fe77-08dec1849d87
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 15:27:26.1244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tGlsWFkr8leU3rviitHqUG956oJAQ3ftPg74UmKAgywSicinU+5zJw39HYE3jee6iFtAkZa/vR+Wo78sOnJ7JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9738
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDE0OSBTYWx0ZWRfX3NStnHpCkmiB
 +/bZcMxlyks7pPGnBD7/22OmQ/6VnRGwLvqn3/95G5dej6WpADzppAKD18XSRGrNNbveXUi8LfH
 g/kUWxqZhh4Jp/2pY2Mrz8D2RS6nFAcnYSbcEsqQIzhzzP/8inD4PToN018r3sxsHg7uLKsZvxD
 cGZ0axnSdjxmsHtIRCooAA4zmsLiCKQzJgBPxiAfD/QrE9nolzUjdDILTCXesttMUQZPi3egQ7z
 EpCSLgADhpHwFwSrbA2ow+bMy7EMlSU1XzGN15Dxw7lqT+uC8mHhWpC7PWxTnTsBltzhMMuctHF
 yv1qhIrTSEv+cSyah8zeJJAhDX+jlMCQIdTTZs0CvhuHI0Rn3CX75QE3rbfCSyT6kt9SG3AkzKX
 gf6YrM0IkKvVQCLJnelcCpr+ZUmymhdp6wNSOZwt+mMjO7jNxy6HplRv1dpEMVh1dVTEuotBYwR
 8Hdx66CzZJOMbJ7NLtg==
X-Authority-Analysis: v=2.4 cv=Opt/DS/t c=1 sm=1 tr=0 ts=6a2047e1 cx=c_pps
 a=e7UpQLGcWimQYEoqUdNrWw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=1XWaLZrsAAAA:8
 a=t7CeM3EgAAAA:8 a=NEAV23lmAAAA:8 a=IlWeCECU26QsQS3PNhUA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: PaTWY8eYFMQuPmzBckxmpEHRYAYADPwu
X-Proofpoint-ORIG-GUID: PaTWY8eYFMQuPmzBckxmpEHRYAYADPwu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030149
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 03 Jun 2026 15:27:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4120

* fbae93917 btrfs (#1144)
* da94ce004 dmesg: allow dmesg_t access to init script stream sockets
* 78f8b23d4 fapolicyd: fix issue with tmpfs_t write
* 319ac618d fsadm (#1129)
* 7d1dc1f06 systemd: allow tmpfiles to handle auditd_log_t
* d30582816 systemd: allow tmpfiles to relabel various unlabeled objects
* 01f6bb2bc systemd: allow tmpfiles to setrlimit
* d156ca9a6 sshd: guard dbus calls with optional_policy
* 6b7da9b01 sudo: guard auth_use_pam_systemd call
* cd06b5f4b authlogin: guard auth_use_pam_systemd->dbus_system_bus_client calls with optional_policy
* 586caeace Add SELinux policy support for Userspace Resource Manager (URM) (#1097)
* 4e360aab8 tor_pluggable_transports2 (#1133)
* 444f9a669 apt_dpkg_strict (#1131)
* 2cc5c825b corecommands: label /usr/share/pam/security/namespace.init as bin_t
* 6aeb605e8 authlogin: allow pam_domain to read /usr/share/pam
* d97274873 systemd: resolved has a systemd-networkd hook
* fac3aba88 systemd: allow resolved access to /etc/localtime
* a57ca559e authlogin: systemd reads /proc/sys/kernel/random/boot_id via nss
* f6e4064fe Add boolean user_ptrace to allow user domains to strace themselves
* d25098a7d incus: Update module to reflect new incus selinux support
* 73be75170 selinux: Add selinux_read_fs interface
* a75373c3b incus: Allow setting of per instance oom_score_adj
* a8ff7c56b incus: Add incus_entry_type interface
* e4684de6d incus: Fix start of virtual networking in incus >=6.15
* 4b38f2f05 virt: Add virt_relabel_images interface
* 3b11df9e2 container: Add container_write_all_container_state interface
* 0dbad021c qemu: Update incus support
* 69141a369 qemu: Add qemu_manage_image_symlinks interface
* 373d1ee9f qemu: Add qemu_write_state interface
* 6ef6df8b0 qemu: Add qemu_getattr interface
* 5684dae89 selinux: allow ModemManager to send DBus messages to initrc_t.
* a7d4c1333 libvirt_leasesh: Added read and search permission on kernel sysctls
* 75079752d systemd-coredum: Added sepolicy permission to read namespace file
* e0fd56a58 refpolicy: Addressing denial seen on alsa to allow write on event dev node
* 694c913f8 tee_supplicant: Add necessary SELinux policy for qtee_supplicant
* eb28c5a1b su: use auth_use_pam
* e396a31e2 systemd: allow user systemd-tmpfiles to setfscreate
* 26f457f50 systemd: allow systemd-userwork to speak to systemd-machined
* 8762d07ad systemd: allow systemd-nsresourced to interact w/ bpf
* 0b7c88000 kernel: treat /efi similarly to /boot
* 99d522a1d snmpd: snmpd doesn't seem to need dac_override capability
* 192fe63a2 gpg: adapt to Gentoo's app-alternatives/gpg
* ebafd639e selinux: allow seatd to use unallocated TTYs
* cea89176e https://picasa.google.com/
* 8d49a23bd matrixd: gatekeep postgresql calls in an optional policy block
* 169f725b3 newrole_t, run_init_t: call auth_run_pam()
* ffadd83c7 ping: allow execution and PTY access
* e15ac27e0 devices: Add label for /dev/isst_interface
* d4084b9fa Add new kernel security class memfd_file and new kernel permissions
* 928e3bcbb Add new policy cababilities
* 559688316 userdomain: kernel_dontaudit_request_load_module for all users
* 0e76a2a30 Add op-tee based tee supplicant policy

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...ow-systemd-tmpfiles-to-read-bin_t-symlink.patch | 14 +++++++-------
 recipes-security/refpolicy/refpolicy_git.inc       |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/recipes-security/refpolicy/refpolicy/0039-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch b/recipes-security/refpolicy/refpolicy/0039-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch
index d480089..1a16711 100644
--- a/recipes-security/refpolicy/refpolicy/0039-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch
+++ b/recipes-security/refpolicy/refpolicy/0039-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch
@@ -1,4 +1,4 @@
-From 496131601f622dabb953cf3f98c64dd726060d33 Mon Sep 17 00:00:00 2001
+From 40dae32ff55f82d4e4e9d309bc91c0216d616b51 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 18 Feb 2025 15:26:19 +0800
 Subject: [PATCH] systemd: allow systemd-tmpfiles to read bin_t symlink
@@ -23,7 +23,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  4 files changed, 23 insertions(+)
 
 diff --git a/policy/modules/kernel/corecommands.fc b/policy/modules/kernel/corecommands.fc
-index 5fd532202..d51f266e5 100644
+index 0da8a2ddb..007341a65 100644
 --- a/policy/modules/kernel/corecommands.fc
 +++ b/policy/modules/kernel/corecommands.fc
 @@ -249,6 +249,7 @@ ifdef(`distro_gentoo',`
@@ -61,22 +61,22 @@ index 08ed91f19..0fa4cbf7d 100644
 +	read_lnk_files_pattern($1, bin_t, bin_t)
 +')
 diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
-index 0d9ff59e2..da6a30470 100644
+index cc2709551..b67b78a69 100644
 --- a/policy/modules/system/systemd.if
 +++ b/policy/modules/system/systemd.if
-@@ -155,6 +155,7 @@ template(`systemd_role_template',`
- 	userdom_exec_user_bin_files($1_systemd_t)
+@@ -156,6 +156,7 @@ template(`systemd_role_template',`
  
  	# user systemd-tmpfiles rules
+ 	allow $1_systemd_tmpfiles_t self:process setfscreate;
 +	allow $1_systemd_tmpfiles_t self:capability net_admin;
  	allow $1_systemd_tmpfiles_t $1_systemd_t:unix_stream_socket rw_socket_perms;
  	domtrans_pattern($1_systemd_t, systemd_tmpfiles_exec_t, $1_systemd_tmpfiles_t)
  	read_files_pattern($1_systemd_t, $1_systemd_tmpfiles_t, $1_systemd_tmpfiles_t)
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index b9af00ec8..e79dec101 100644
+index 1ae8e3a7d..e1cc0cfde 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -2148,6 +2148,9 @@ kernel_getattr_proc(systemd_tmpfiles_t)
+@@ -2161,6 +2161,9 @@ kernel_getattr_proc(systemd_tmpfiles_t)
  kernel_read_kernel_sysctls(systemd_tmpfiles_t)
  kernel_read_network_state(systemd_tmpfiles_t)
  
diff --git a/recipes-security/refpolicy/refpolicy_git.inc b/recipes-security/refpolicy/refpolicy_git.inc
index 4b2b186..28cc4a3 100644
--- a/recipes-security/refpolicy/refpolicy_git.inc
+++ b/recipes-security/refpolicy/refpolicy_git.inc
@@ -2,7 +2,7 @@ PV = "2.20260312+git"
 
 SRC_URI = "git://github.com/SELinuxProject/refpolicy.git;protocol=https;branch=main;name=refpolicy;destsuffix=refpolicy"
 
-SRCREV_refpolicy = "cffa6e2c93e9f9be74ffbd65237f45ad6e9d7c55"
+SRCREV_refpolicy = "fbae939176fed7163730506878d92d3b1da433e4"
 
 UPSTREAM_CHECK_GITTAGREGEX = "RELEASE_(?P<pver>\d+_\d+)"
 
-- 
2.34.1


