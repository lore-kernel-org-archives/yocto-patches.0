Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D1BCD98F2
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 13:04:55 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20596.1782219888644080841
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Jun 2026 06:04:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=mzpxLGKc;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0634e8a857=yi.zhao@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBVqKv047389
	for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 06:04:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=t5Hbz7FpxF7GwUXoXkxA
	usY4RGMKmBJK/k8bQ8zxK+8=; b=mzpxLGKcPcELCqSh7WXtbxAH8mi0o96KDsHc
	/fnmnR4RwlLdFsd7boDdNUPUDabTmuRyp+gGhpqNrF5AKWUARDE3JR7gj4gkSYCG
	Yd1E6EdI3Vld8wQ63PaKkL+mr9a0YeZZkJY7vJgaQrL3/nuB/wrfl+GUF0n1JH8B
	QUJsIcjBQFTeawxOwx35QZ3B+4xCvoaUWDA8A8yvBgUbl2sStZHtOkSPpkQh/mSh
	3Q8IMxmX2eDi0l76iGSA72Bf8fMSuV6cMrUAMdUjSet+GX16e5kXQyWK85P9MDJx
	OG+BjOfgQEhWegskul95AJ87EuSSTJ9oQN/Sso8JQB6Hy1kcSw==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011004.outbound.protection.outlook.com [52.101.57.4])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ewtccu431-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 06:04:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNfzryDhMS8DXrO3FhOHXiKq72ztuCYB1vp4bUoEg8HR8bboF5WfR4C4wMx/SiqTpNihDNkMQOZW2s5v+pumLfRhWXlYOXSg7Di0HnCchR+azoyyNaqitDbWs0eOWeE8KVx9ignDZiJ0pgb56eqxUzZT6i4FtfRMUiDDJacNsRxxXl5cD81fIihrn4mfHlrQXojOGZQzgoc72pfbi7YeYJFJ6tgYUBccRzRG40aiHKBDCGZrHDhWwo/3AuQKv8I1irAsgJRfFTOJ7VIV7s6lMwP47DVckSfhGHM88o4NsRvubD2p+rPl7JmZnVwODh73hoim6MdXmR5BfFYtAczlYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5Hbz7FpxF7GwUXoXkxAusY4RGMKmBJK/k8bQ8zxK+8=;
 b=tncjERS6axKQ6dN0vgQzyqT8TCg0trczdsZgWOm+oZlYXhvfBjwwGqUtTBwC8FgitIR4GI9u1nsmBaqdu0jws/vetepvUFGjmM0BXoqHJpcWR7ZefDXL64mfb1Asd6zfkhJZRCrxK/ZNQOBlbZgJoMmOmCMJ7rd7MVg/VL1JtNQWi4hqklF9UVfLJxzu0zRdLKoDs9yBJ12yKwCrMGA06fP77lf5ZVrpo5UE7gcOrWoCv1Z6JRz77qdmgM9yz3gEDEsUglVxBJhahCxp+1XoEs9IcdXa3ZsUAYv7BAxNCWlyiVftFKmGTcj++d/QTfzhMpuMpnZIwitGKFXEK28W2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 PH3PPF6E8D29981.namprd11.prod.outlook.com (2603:10b6:518:1::d2d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 13:04:43 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831%4]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 13:04:43 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH] refpolicy: upgrade to 20260616+git
Date: Tue, 23 Jun 2026 21:04:27 +0800
Message-Id: <20260623130427.800925-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0080.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bc::16) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|PH3PPF6E8D29981:EE_
X-MS-Office365-Filtering-Correlation-Id: 78379352-9e5a-4b89-3422-08ded127fd7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|23010399003|56012099006|3023799007|11063799006|5023799004|38350700014|6133799003|17002099007|18002099003;
X-Microsoft-Antispam-Message-Info: 
	G3A5kchYBmOKPI7jiTe/YGwGlqvNTv40YfXT0loVyW6/sa89FfmA/10Euf7VoVwxHoaI4BbbmvnMRfFC6DGkC6dVsyxEzln6akGLBgBzZVwp9r33lfo2/5NylXj2UYYAvGLsbAjFAAHHjQaFIYfQ33B15zmS6H9zFoUqS6ZN/So5i6DBCNU7IMsAO0oqk9wAueLD0I7yhcNEkbnaomtsoyw/EVqkA19YEdIPrM5kNomwCh382SXIPwtC/WMkzp0gGpawrC7GfD1kxA4mNNCQ0tPixRx7aTMtVp2WLXkA2485ZS3gJ9Sl2OBS2qF49SqgyoM/uJ39jIYBZPFufcdGOy3oyb1VNBfBiD9I+NmpC3XXgLZK7gFR07pHuAboeIWMq7VtankObiuSzGkiRQZaqyhhoyBgxd4HRByhDgj7znEsulR+CqeE6T53vHdL4TyRr/js3/VoZ1Xd5ZRL3TaUjsPLtUrzNMU/2CM/8skB/NVldZq8rzOesudVDWztPUN7Kj0jtxPt7Zq/LG2P26LxrWYER2zC/zdUbijMvhcoA/OkZrggfFGBpvJsMlugLMwNr3/a07W1unCionwoT6TrrYaaAup2PSxMaQm++nPHyMS0j7+IhUjopcAuiejNlvWy3XkmAQxoqeM3muICdMuV4pTQM2QMdMhZ2BIi84PDC7KSccJUGIK3losO15veIfrRTHIDzHsuS8zo9eSkm27p/RSU6NpPeIuvrNXM36dUd64=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(23010399003)(56012099006)(3023799007)(11063799006)(5023799004)(38350700014)(6133799003)(17002099007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/Zg2CP+/v2EPXNlvDUtVZB0WYzwxbKlKJ/ZmqwkouseQyBrLpbWRdFJH/IPb?=
 =?us-ascii?Q?2S6j0c4tyn0hiWKMdMEK1Bg6kB5BSUWpt+0tY+i9NBUrTGsoZOhM7BWJmTRL?=
 =?us-ascii?Q?TyAYEcxL55X1HJUtIPriK7W53u4ljSdmBBCSSIgMxJv2Njt1WzdtOp94gCYH?=
 =?us-ascii?Q?z0o0qI8kV+bWiz2y+tIku4ZzvJ1fub3KOtAMVAI42+xwbU5pOOjzBTqVxgdg?=
 =?us-ascii?Q?94u3kVmjsdMTPU3LsCZ1FjdUtl3SEwhe7UpvzFwVJdHdMTchwR66l8LwcTOT?=
 =?us-ascii?Q?Mok0MtRc3zJ4KVMmkYISYKUdyUQ8HhIv+tNsgPEvHbja/3D+4Asp8GDSbSpb?=
 =?us-ascii?Q?av9ndsKkNMj0uFhlEDqwCz9mFKfFGwUPCro0cSYJTJJ9VdYvnzhnBkZmAX7O?=
 =?us-ascii?Q?fkWc4/lz7GbNEIr+xyuG8pqJSfGSUJyWGxCpeV01ZfXjherCnDBDLVl5VloL?=
 =?us-ascii?Q?D311FjFGMDi1LIXA3yYvZfHFEersGSQVcBZ2q9Q7I+lx/iRfRbeuP+pnwLSR?=
 =?us-ascii?Q?5kbldHRwb84FwA/FS1rrtkLbLjY/HKxKDK+uWh82wHonvS+QX0+x+J+i6s8A?=
 =?us-ascii?Q?aO2qe9c40SMCw3dgmr96Vo8P4zCcGZ5jIOq8Pp8d5wY+IktEfDWp7uA6zk6g?=
 =?us-ascii?Q?S+USOtLNC0i1pRsI8nvU5uN/FWUQKeWLbS8VvlDsH4NH4gR09fUkjIXdLDXL?=
 =?us-ascii?Q?FtmTle5+o/n3VfHlcaf1o6h+synr9wumGom4sn09ePMxNhu/zCSFqiM4n5oK?=
 =?us-ascii?Q?S1Nrj4F6r+MraKm7Yu/MIr11QfIPK9+c+lz/HA1xENJlcinbP1M6qzNHl3od?=
 =?us-ascii?Q?rqswLCPT9L84EVMuWZnH4ILsXCkHbPAcSCfzRE+0eIpSVtE2BPDXuMBcEoh/?=
 =?us-ascii?Q?oPxwPfKmke3LNKQN9EQe1JYBH2uBb0Xi/o0CiLFR/HMFCV9vIEZaqEnLzbHp?=
 =?us-ascii?Q?VFWiE6h9wWzTxxrJSHIJLBxKlwWN5oIBa1eS89HTXqDs6wxdiJWkGpmSts1z?=
 =?us-ascii?Q?wzw+Q1c+Q9C+pmzgxn5JlKEZBMFt6Y2nM7EBQzwGrGk/eB6nY+SoWSoBcxMX?=
 =?us-ascii?Q?KzRwTlKX8SaIyfuxoyh3P+6fYyoVfcxZCoGBUjHtVhMYDFbAfo0ni+Jae+1A?=
 =?us-ascii?Q?q3APtje5mTQYDRL4akv5ip0XVwh1PhiMs2dJKGuTCTcuihY539R3y3gatKXn?=
 =?us-ascii?Q?lu3D/zzJUo9TdugEcAiFC+2QS8OdGBlAuljU+dOHD9xq14ngFy07+B659jzJ?=
 =?us-ascii?Q?5MI0ZEmE3uyE16FnrwxfXhMkozJcn45Q4U/NTZ9UXisYFx9jUis0rIr/j8js?=
 =?us-ascii?Q?G9VSdKtZ+YP0yIxVLMoT2P9ze7vL9YqFsIrzCS8NHbwKTpedkF4OffyH7CXv?=
 =?us-ascii?Q?ZFJkTYQcShDWDqSLpBMouWfG2An3G0/vZTCpCdlzYrZp7UqFWtmrBqtNxm5M?=
 =?us-ascii?Q?b/HmNCCkHKcv+FtrwTD/i0OVo9Nr50JkRvtyde5AHntnbvPq3x2cuWB4nXI3?=
 =?us-ascii?Q?uANVfrKuYiMek0WHYpnc5hbF3aYFTs7qB4crdEIjesWMV/kTmWLuUs1aTB5U?=
 =?us-ascii?Q?SVFn4y0nR8PcX9+Ys5hw2lVC5lH6Uwk42ChZfigs1jUjGrhnojsOgAmhr2O4?=
 =?us-ascii?Q?VlOBtmLxCGpgUcfT/8WNutpBq/96K0XI4BpfQbqPZkvSvxzGR6kpG8/PJ4Z8?=
 =?us-ascii?Q?vfsifBKotTEEqRADSahm4PajoxNeShedzFV6gYPayUz4Cp1D//I32MGUbvIt?=
 =?us-ascii?Q?tRmZUURayg=3D=3D?=
X-Exchange-RoutingPolicyChecked: 
	b8Vi2gRaT/Koe5c5UU0lwBCge5ug6i6u8utsJYxkDFVeGeJXC+6EQBhvB640sScxA4iVXJjzqtNwOQzghixrSXOlDldGGCVXdJCv/Km2mz5UUvZ7NwduPfdp7K+Z8wgkcbJazi9nkFx9C5FhFJSWr+NwGBd5whFjvgDZ5MqvljyGFtcixPx7ZDaC7BIQUZpNGmg1PePKnADosf+sFVLqVAUIryKid1S/6HyF0e7KPUQsudpGKGsOWDTn7OWTVwtrx0cu6xdUTaFxM1iCv1lEMDZ4dnIy4O0JpbdC+GuHUxEkEZ8bgh1cwMc3bD4b3NXmj6r45Oybo2wNgF7+jmhfgA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78379352-9e5a-4b89-3422-08ded127fd7c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 13:04:42.9194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vZDZEYH31ItRojPzjXNSXF+ad3Tf1RF/lCRGZwDr9kredoRKFAgb9tk5oy8OH10ODrMoH6fhIB+gUnXXFuinIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF6E8D29981
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEwNyBTYWx0ZWRfXy1TVrcqRgu5v
 MBApkRe6ELXeMCVxqSrhHf4SMZvt7NSh1F+zdsUSG8JzfRY4XpQdNLwf8wcgyzZQJrc2w5ljx8a
 xS4EAajmbjhe0jPK1zUoqHJAE63cELPAL0hGc1PPyb33NJ6mggR6tNRI0wLYQIKe48HuXciVHiw
 m2NdB6/2Yebzm88Wuf2jrOcYWA7nt5VJvGoXjvwterhlhdOxt4nOSG77f8myE1KHnPTrkoOFFEp
 +xALZhfgsV0ksMKvY9lI7pdUjA8TCfmJxnoa6ZFX+vi92U255SNgI7tqxBXWduwnvF/aJCsMJi2
 7bNbHjHbqBYKSzwCZ+Yd9hrcs28p2p/1zK+QRLvOUtM9gAbftnVGY8o9a216I45wS1WwjxmkXwo
 AjoX/FfPMvsiGy9XveJFofjyhwJUEbSWepFRcNHxHr/SYX+QnVn0oKMXRNpscL1IHrtkVYSVqPu
 nuJZd+eQjyzjNI1V7hw==
X-Proofpoint-ORIG-GUID: 3IA7EoIZMiXTtkGLXyzGIPnng7Z-SE3M
X-Authority-Analysis: v=2.4 cv=GuVyPE1C c=1 sm=1 tr=0 ts=6a3a846f cx=c_pps
 a=NhzRQjsTkbCjHKaZ4k3NFQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=20KFwNOVAAAA:8
 a=t7CeM3EgAAAA:8 a=9Wbp7B8dAAAA:8 a=NEAV23lmAAAA:8 a=UWJXjMPQUq0nXfmLY0YA:9
 a=ygLeIr8XoBm-q-Jc:21 a=O8hF6Hzn-FEA:10 a=FdTzh2GWekK77mhwV6Dw:22
 a=BESxJfN36ujmTJQqZ0Zq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEwNyBTYWx0ZWRfX/i9NloPM6fis
 0CmKeee777ECmoapqIYPzirOojjh8k1UknpbmxSWfb1ohcVs9RWKuH/I7tr6501ZLOScfCgy5gv
 QG7ksqkGDsB0r95CDo1lecmBw7drD645/XHFceEjtHEm1IBGy1fO
X-Proofpoint-GUID: 3IA7EoIZMiXTtkGLXyzGIPnng7Z-SE3M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230107
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 13:04:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4282

* 1a3dc6044 Update Changelog and VERSION for release 2.20260616.
* abd97a71a systemd: Fix denial on "systemctl restart systemd-networkd"
* d1288bc8e systemd: Fix systemd-networkd /run/mount denial
* 9ff44d61a container: Allow access to /etc/cdi for CDI configuration
* f4ff996ee irqbalance: v1.9.4 added namespacing in the systemd unit.
* 4e10fcb98 nfs: allow nfsd_t to create netlink_generic_socket
* 79de0aa3d amanda: nit: make comments for "index" in file context spec
            consistent
* 95b5063af uwimap: treeclean
* 7426d2180 file_contexts.subs_dist: treat /sbin and /usr/sbin the same
            as /usr/bin
* 13424dbc7 build-userspace.yml. Use build action from selinux repo.
* 540593db1 Allow fwupd to mmap generic cert files, and manage user
            runtime files.
* 4d1fb251c Added boolean smartmon_megaraid to allow smartd to create
            /dev/megaraid_sas_ioctl_node and other character devices
            labelled fixed_disk_device_t
* 6a84386d1 Allow network manager to use bpf for IPv4 collision
            detection
* 84ccb188c Allow fwupdmgr_exec_t to be run by init scripts
* 0a8ac7e84 Changed paths to /var/lib/boinc-client.
* 91decb5a2 portage: label /etc/portage/gnupg
* f19614fc4 portage: label /var/cache/binhost
* 5489af33d ci: Refactor to centralize global variables.
* 826fb5648 ci: Remove unnecessary archiving in
            actions/upload-artifact.
* 91003a1a2 init: adapt to OpenRC changes
* 178221c42 Label /dev/i2c-* devices and add boolean to allow
            user access (EG for DDC)
* 1d86df179 Update GitHub actions to newest versions.
* 3d81b7012 build-setools.yml: Refactor to use the build-setools action
            from the SETools repo.

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...tile-alias-common-var-volatile-paths.patch |   6 +-
 ...inimum-make-sysadmin-module-optional.patch |   4 +-
 ...e-unconfined_u-definition-to-unconfi.patch |   4 +-
 ...box-set-aliases-for-bin-sbin-and-usr.patch |   8 +-
 ...m-allow-systemd-networkd-to-accept-a.patch |   6 +-
 ...ed-make-unconfined_u-the-default-sel.patch |   2 +-
 ...y-policy-to-common-yocto-hostname-al.patch |   2 +-
 ...efpolicy-minimum-enable-nscd_use_shm.patch |   2 +-
 ...sr-bin-bash-context-to-bin-bash.bash.patch |   4 +-
 ...abel-resolv.conf-in-var-run-properly.patch |   6 +-
 ...-apply-login-context-to-login.shadow.patch |   4 +-
 ...-fc-hwclock-add-hwclock-alternatives.patch |  11 +-
 ...g-apply-policy-to-dmesg-alternatives.patch |   2 +-
 ...ssh-apply-policy-to-ssh-alternatives.patch |   4 +-
 ...ply-policy-to-network-commands-alter.patch |  34 ++----
 ...ply-rpm_exec-policy-to-cpio-binaries.patch |  13 +-
 ...c-su-apply-policy-to-su-alternatives.patch |   2 +-
 ...fc-fstools-fix-real-path-for-fstools.patch | 115 ++++++++++--------
 ...fix-update-alternatives-for-sysvinit.patch |  34 +++---
 ...l-apply-policy-to-brctl-alternatives.patch |   9 +-
 ...apply-policy-to-nologin-alternatives.patch |  22 ++--
 ...apply-policy-to-sulogin-alternatives.patch |  11 +-
 ...tp-apply-policy-to-ntpd-alternatives.patch |  16 +--
 ...pply-policy-to-kerberos-alternatives.patch |  20 ++-
 ...ap-apply-policy-to-ldap-alternatives.patch |   6 +-
 ...ply-policy-to-postgresql-alternative.patch |   2 +-
 ...ply-policy-to-usermanage-alternative.patch |  28 ++---
 ...etty-add-file-context-to-start_getty.patch |   6 +-
 ...k-apply-policy-to-vlock-alternatives.patch |   7 +-
 ...for-init-scripts-and-systemd-service.patch |  10 +-
 ...bs_dist-set-aliase-for-root-director.patch |  12 +-
 ...ystem-logging-add-rules-for-the-syml.patch |   8 +-
 ...ystem-logging-add-rules-for-syslogd-.patch |   4 +-
 ...ernel-files-add-rules-for-the-symlin.patch |  24 ++--
 ...ystem-logging-fix-auditd-startup-fai.patch |   4 +-
 ...ernel-terminal-don-t-audit-tty_devic.patch |   2 +-
 ...ystem-systemd-enable-support-for-sys.patch |   4 +-
 ...ystem-logging-allow-systemd-tmpfiles.patch |  43 -------
 ...s-system-systemd-systemd-user-fixes.patch} |  10 +-
 ...stem-logging-grant-getpcap-capabili.patch} |   6 +-
 ...stem-allow-services-to-read-tmpfs-u.patch} |  10 +-
 ...rnel-domain-allow-all-domains-to-co.patch} |   6 +-
 ...allow-systemd-logind-to-inherit-fds.patch} |   8 +-
 ...temd-tmpfiles-to-read-bin_t-symlink.patch} |  10 +-
 ...systemd-networkd-and-systemd-rfkill.patch} |  10 +-
 ...ain-used-for-login-program-to-conne.patch} |  10 +-
 ...emd-add-rules-for-systemd-ssh-issue.patch} |  12 +-
 ...stem-mount-make-mount_t-domain-MLS-.patch} |   2 +-
 ...les-sysadm-MLS-sysadm-rw-to-clearan.patch} |   2 +-
 ...rvices-rpc-make-nfsd_t-domain-MLS-t.patch} |  10 +-
 ...min-dmesg-make-dmesg_t-MLS-trusted-.patch} |   6 +-
 ...rnel-kernel-make-kernel_t-MLS-trust.patch} |   6 +-
 ...stem-init-make-init_t-MLS-trusted-f.patch} |   4 +-
 ...stem-systemd-make-systemd-tmpfiles_.patch} |   6 +-
 ...stem-systemd-systemd-make-systemd_-.patch} |  12 +-
 ...stem-logging-add-the-syslogd_t-to-t.patch} |   6 +-
 ...stem-init-make-init_t-MLS-trusted-f.patch} |   4 +-
 ...stem-init-all-init_t-to-read-any-le.patch} |   4 +-
 ...stem-logging-allow-auditd_t-to-writ.patch} |   6 +-
 ...rnel-kernel-make-kernel_t-MLS-trust.patch} |   6 +-
 ...stem-setrans-allow-setrans_t-use-fd.patch} |   2 +-
 ...stem-systemd-make-_systemd_t-MLS-tr.patch} |   6 +-
 ...stem-logging-make-syslogd_runtime_t.patch} |   6 +-
 .../refpolicy/refpolicy_common.inc            |  51 ++++----
 recipes-security/refpolicy/refpolicy_git.inc  |   4 +-
 65 files changed, 333 insertions(+), 393 deletions(-)
 delete mode 100644 recipes-security/refpolicy/refpolicy/0033-policy-modules-system-logging-allow-systemd-tmpfiles.patch
 rename recipes-security/refpolicy/refpolicy/{0034-policy-modules-system-systemd-systemd-user-fixes.patch => 0033-policy-modules-system-systemd-systemd-user-fixes.patch} (90%)
 rename recipes-security/refpolicy/refpolicy/{0035-policy-modules-system-logging-grant-getpcap-capabili.patch => 0034-policy-modules-system-logging-grant-getpcap-capabili.patch} (90%)
 rename recipes-security/refpolicy/refpolicy/{0036-policy-modules-system-allow-services-to-read-tmpfs-u.patch => 0035-policy-modules-system-allow-services-to-read-tmpfs-u.patch} (95%)
 rename recipes-security/refpolicy/refpolicy/{0037-policy-modules-kernel-domain-allow-all-domains-to-co.patch => 0036-policy-modules-kernel-domain-allow-all-domains-to-co.patch} (88%)
 rename recipes-security/refpolicy/refpolicy/{0038-systemd-allow-systemd-logind-to-inherit-fds.patch => 0037-systemd-allow-systemd-logind-to-inherit-fds.patch} (89%)
 rename recipes-security/refpolicy/refpolicy/{0039-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch => 0038-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch} (93%)
 rename recipes-security/refpolicy/refpolicy/{0040-systemd-fix-for-systemd-networkd-and-systemd-rfkill.patch => 0039-systemd-fix-for-systemd-networkd-and-systemd-rfkill.patch} (90%)
 rename recipes-security/refpolicy/refpolicy/{0041-systemd-allow-domain-used-for-login-program-to-conne.patch => 0040-systemd-allow-domain-used-for-login-program-to-conne.patch} (91%)
 rename recipes-security/refpolicy/refpolicy/{0042-systemd-add-rules-for-systemd-ssh-issue.patch => 0041-systemd-add-rules-for-systemd-ssh-issue.patch} (94%)
 rename recipes-security/refpolicy/refpolicy/{0043-policy-modules-system-mount-make-mount_t-domain-MLS-.patch => 0042-policy-modules-system-mount-make-mount_t-domain-MLS-.patch} (94%)
 rename recipes-security/refpolicy/refpolicy/{0044-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch => 0043-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch} (95%)
 rename recipes-security/refpolicy/refpolicy/{0045-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch => 0044-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch} (85%)
 rename recipes-security/refpolicy/refpolicy/{0046-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch => 0045-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch} (85%)
 rename recipes-security/refpolicy/refpolicy/{0047-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch => 0046-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch} (95%)
 rename recipes-security/refpolicy/refpolicy/{0048-policy-modules-system-init-make-init_t-MLS-trusted-f.patch => 0047-policy-modules-system-init-make-init_t-MLS-trusted-f.patch} (93%)
 rename recipes-security/refpolicy/refpolicy/{0049-policy-modules-system-systemd-make-systemd-tmpfiles_.patch => 0048-policy-modules-system-systemd-make-systemd-tmpfiles_.patch} (92%)
 rename recipes-security/refpolicy/refpolicy/{0050-policy-modules-system-systemd-systemd-make-systemd_-.patch => 0049-policy-modules-system-systemd-systemd-make-systemd_-.patch} (90%)
 rename recipes-security/refpolicy/refpolicy/{0051-policy-modules-system-logging-add-the-syslogd_t-to-t.patch => 0050-policy-modules-system-logging-add-the-syslogd_t-to-t.patch} (89%)
 rename recipes-security/refpolicy/refpolicy/{0052-policy-modules-system-init-make-init_t-MLS-trusted-f.patch => 0051-policy-modules-system-init-make-init_t-MLS-trusted-f.patch} (91%)
 rename recipes-security/refpolicy/refpolicy/{0053-policy-modules-system-init-all-init_t-to-read-any-le.patch => 0052-policy-modules-system-init-all-init_t-to-read-any-le.patch} (92%)
 rename recipes-security/refpolicy/refpolicy/{0054-policy-modules-system-logging-allow-auditd_t-to-writ.patch => 0053-policy-modules-system-logging-allow-auditd_t-to-writ.patch} (88%)
 rename recipes-security/refpolicy/refpolicy/{0055-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch => 0054-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch} (84%)
 rename recipes-security/refpolicy/refpolicy/{0056-policy-modules-system-setrans-allow-setrans_t-use-fd.patch => 0055-policy-modules-system-setrans-allow-setrans_t-use-fd.patch} (93%)
 rename recipes-security/refpolicy/refpolicy/{0057-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch => 0056-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch} (88%)
 rename recipes-security/refpolicy/refpolicy/{0058-policy-modules-system-logging-make-syslogd_runtime_t.patch => 0057-policy-modules-system-logging-make-syslogd_runtime_t.patch} (90%)

diff --git a/recipes-security/refpolicy/refpolicy/0001-fc-subs-volatile-alias-common-var-volatile-paths.patch b/recipes-security/refpolicy/refpolicy/0001-fc-subs-volatile-alias-common-var-volatile-paths.patch
index 24c822f..112f5cc 100644
--- a/recipes-security/refpolicy/refpolicy/0001-fc-subs-volatile-alias-common-var-volatile-paths.patch
+++ b/recipes-security/refpolicy/refpolicy/0001-fc-subs-volatile-alias-common-var-volatile-paths.patch
@@ -1,4 +1,4 @@
-From b666c26dd4c57e90cd0ab7e3bcb52943b72676a2 Mon Sep 17 00:00:00 2001
+From 3bed8cf8fb9f6a1651d005619a2b029a838539ea Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 16:14:09 -0400
 Subject: [PATCH] fc/subs/volatile: alias common /var/volatile paths
@@ -15,10 +15,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 6 insertions(+)
 
 diff --git a/config/file_contexts.subs_dist b/config/file_contexts.subs_dist
-index ea643ddbb..6c5aa4b91 100644
+index a6b747fad..d64580e89 100644
 --- a/config/file_contexts.subs_dist
 +++ b/config/file_contexts.subs_dist
-@@ -33,3 +33,9 @@
+@@ -34,3 +34,9 @@
  # not for refpolicy intern, but for /var/run using applications,
  # like systemd tmpfiles or systemd socket configurations
  /var/run /run
diff --git a/recipes-security/refpolicy/refpolicy/0001-refpolicy-minimum-make-sysadmin-module-optional.patch b/recipes-security/refpolicy/refpolicy/0001-refpolicy-minimum-make-sysadmin-module-optional.patch
index f3cb097..0406381 100644
--- a/recipes-security/refpolicy/refpolicy/0001-refpolicy-minimum-make-sysadmin-module-optional.patch
+++ b/recipes-security/refpolicy/refpolicy/0001-refpolicy-minimum-make-sysadmin-module-optional.patch
@@ -1,4 +1,4 @@
-From fbf828a2204ae673442f90b17c97db17965578e9 Mon Sep 17 00:00:00 2001
+From a7d979d52785239ca6123c41a54c288b3ffd0efa Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 5 Apr 2019 11:53:28 -0400
 Subject: [PATCH] refpolicy-minimum: make sysadmin module optional
@@ -22,7 +22,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  2 files changed, 11 insertions(+), 7 deletions(-)
 
 diff --git a/policy/modules/system/init.te b/policy/modules/system/init.te
-index 15bffd9cf..9b20ff8d4 100644
+index 8188f8aec..1b790ac23 100644
 --- a/policy/modules/system/init.te
 +++ b/policy/modules/system/init.te
 @@ -680,13 +680,15 @@ ifdef(`init_systemd',`
diff --git a/recipes-security/refpolicy/refpolicy/0001-refpolicy-targeted-Revert-users-Move-unconfined_u-definition-to-unconfi.patch b/recipes-security/refpolicy/refpolicy/0001-refpolicy-targeted-Revert-users-Move-unconfined_u-definition-to-unconfi.patch
index 2d7ac6b..a87a7bc 100644
--- a/recipes-security/refpolicy/refpolicy/0001-refpolicy-targeted-Revert-users-Move-unconfined_u-definition-to-unconfi.patch
+++ b/recipes-security/refpolicy/refpolicy/0001-refpolicy-targeted-Revert-users-Move-unconfined_u-definition-to-unconfi.patch
@@ -1,4 +1,4 @@
-From 433b5e7bc3d3e13ef1bb239c5f543ded27a2d142 Mon Sep 17 00:00:00 2001
+From 72c80020c69df0035a39fb1d6db8c75b2a4f7fa8 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Wed, 19 Feb 2025 21:35:02 +0800
 Subject: [PATCH] Revert "users: Move unconfined_u definition to unconfined
@@ -18,7 +18,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  3 files changed, 10 insertions(+), 14 deletions(-)
 
 diff --git a/policy/modules/kernel/kernel.te b/policy/modules/kernel/kernel.te
-index 7ec2aa471..8f0f6ac2e 100644
+index 287b0098f..26978623b 100644
 --- a/policy/modules/kernel/kernel.te
 +++ b/policy/modules/kernel/kernel.te
 @@ -37,6 +37,9 @@ role sysadm_r;
diff --git a/recipes-security/refpolicy/refpolicy/0002-fc-subs-busybox-set-aliases-for-bin-sbin-and-usr.patch b/recipes-security/refpolicy/refpolicy/0002-fc-subs-busybox-set-aliases-for-bin-sbin-and-usr.patch
index 6c1b839..2bd7953 100644
--- a/recipes-security/refpolicy/refpolicy/0002-fc-subs-busybox-set-aliases-for-bin-sbin-and-usr.patch
+++ b/recipes-security/refpolicy/refpolicy/0002-fc-subs-busybox-set-aliases-for-bin-sbin-and-usr.patch
@@ -1,4 +1,4 @@
-From d5d91fe32d2d3488acfd0df11d80074e6f9c200d Mon Sep 17 00:00:00 2001
+From e0221dfaf60dc6dedbf04247fabd5b13490bbabf Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 20:48:10 -0400
 Subject: [PATCH] fc/subs/busybox: set aliases for bin, sbin and usr
@@ -15,10 +15,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 6 insertions(+)
 
 diff --git a/config/file_contexts.subs_dist b/config/file_contexts.subs_dist
-index 6c5aa4b91..e782151ef 100644
+index d64580e89..8a5274283 100644
 --- a/config/file_contexts.subs_dist
 +++ b/config/file_contexts.subs_dist
-@@ -39,3 +39,9 @@
+@@ -40,3 +40,9 @@
  # volatile hierarchy.
  /var/volatile/log /var/log
  /var/volatile/tmp /var/tmp
@@ -26,7 +26,7 @@ index 6c5aa4b91..e782151ef 100644
 +# busybox aliases
 +# quickly match up the busybox built-in tree to the base filesystem tree
 +/usr/lib/busybox/bin /usr/bin
-+/usr/lib/busybox/sbin /usr/sbin
++/usr/lib/busybox/sbin /usr/bin
 +/usr/lib/busybox/usr /usr
 -- 
 2.34.1
diff --git a/recipes-security/refpolicy/refpolicy/0002-refpolicy-minimum-allow-systemd-networkd-to-accept-a.patch b/recipes-security/refpolicy/refpolicy/0002-refpolicy-minimum-allow-systemd-networkd-to-accept-a.patch
index fe3b386..6571686 100644
--- a/recipes-security/refpolicy/refpolicy/0002-refpolicy-minimum-allow-systemd-networkd-to-accept-a.patch
+++ b/recipes-security/refpolicy/refpolicy/0002-refpolicy-minimum-allow-systemd-networkd-to-accept-a.patch
@@ -1,4 +1,4 @@
-From 756a5281070bee3a99d3a7be82d90e98290c0598 Mon Sep 17 00:00:00 2001
+From e277c2fdb113c6e8e4a608f271b1032f3762e007 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 26 Feb 2021 09:13:23 +0800
 Subject: [PATCH] refpolicy-minimum: allow systemd-networkd to accept and
@@ -31,10 +31,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index 5649f79af..d6757ce56 100644
+index 26f06e482..6e3048648 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -1451,6 +1451,7 @@ allow systemd_networkd_t self:rawip_socket create_socket_perms;
+@@ -1455,6 +1455,7 @@ allow systemd_networkd_t self:rawip_socket create_socket_perms;
  allow systemd_networkd_t self:tun_socket { create_socket_perms relabelfrom relabelto };
  allow systemd_networkd_t self:udp_socket create_socket_perms;
  allow systemd_networkd_t self:unix_dgram_socket create_socket_perms;
diff --git a/recipes-security/refpolicy/refpolicy/0002-refpolicy-targeted-make-unconfined_u-the-default-sel.patch b/recipes-security/refpolicy/refpolicy/0002-refpolicy-targeted-make-unconfined_u-the-default-sel.patch
index 84cc14b..f5c75e7 100644
--- a/recipes-security/refpolicy/refpolicy/0002-refpolicy-targeted-make-unconfined_u-the-default-sel.patch
+++ b/recipes-security/refpolicy/refpolicy/0002-refpolicy-targeted-make-unconfined_u-the-default-sel.patch
@@ -1,4 +1,4 @@
-From b328cb59c1c6bf8a43b496f50e59d277cfdd7946 Mon Sep 17 00:00:00 2001
+From 34f61ba8c90107644ab2be8cc5a4eb70f2b3c0da Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Mon, 20 Apr 2020 11:50:03 +0800
 Subject: [PATCH] refpolicy-targeted: make unconfined_u the default selinux
diff --git a/recipes-security/refpolicy/refpolicy/0003-fc-hostname-apply-policy-to-common-yocto-hostname-al.patch b/recipes-security/refpolicy/refpolicy/0003-fc-hostname-apply-policy-to-common-yocto-hostname-al.patch
index ecd2de9..616bfb9 100644
--- a/recipes-security/refpolicy/refpolicy/0003-fc-hostname-apply-policy-to-common-yocto-hostname-al.patch
+++ b/recipes-security/refpolicy/refpolicy/0003-fc-hostname-apply-policy-to-common-yocto-hostname-al.patch
@@ -1,4 +1,4 @@
-From ca910a2049117088df2feffdd18aafbbc84cbc7c Mon Sep 17 00:00:00 2001
+From 497c78fb77d0b00e02f7268b470dc2c8378eafdc Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] fc/hostname: apply policy to common yocto hostname
diff --git a/recipes-security/refpolicy/refpolicy/0003-refpolicy-minimum-enable-nscd_use_shm.patch b/recipes-security/refpolicy/refpolicy/0003-refpolicy-minimum-enable-nscd_use_shm.patch
index 9e18682..4cc2f88 100644
--- a/recipes-security/refpolicy/refpolicy/0003-refpolicy-minimum-enable-nscd_use_shm.patch
+++ b/recipes-security/refpolicy/refpolicy/0003-refpolicy-minimum-enable-nscd_use_shm.patch
@@ -1,4 +1,4 @@
-From 587af51ddbd93aa7c0dfa13f8abb97d676e200c7 Mon Sep 17 00:00:00 2001
+From db4bc51b3aa88ad4caeebfbfd2205b6976024136 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 26 Feb 2021 09:13:23 +0800
 Subject: [PATCH] refpolicy-minimum: enable nscd_use_shm
diff --git a/recipes-security/refpolicy/refpolicy/0004-fc-bash-apply-usr-bin-bash-context-to-bin-bash.bash.patch b/recipes-security/refpolicy/refpolicy/0004-fc-bash-apply-usr-bin-bash-context-to-bin-bash.bash.patch
index a80ec96..b5121cf 100644
--- a/recipes-security/refpolicy/refpolicy/0004-fc-bash-apply-usr-bin-bash-context-to-bin-bash.bash.patch
+++ b/recipes-security/refpolicy/refpolicy/0004-fc-bash-apply-usr-bin-bash-context-to-bin-bash.bash.patch
@@ -1,4 +1,4 @@
-From cf97382a3c2c8fd841ddd9420fdd51eaaf87a942 Mon Sep 17 00:00:00 2001
+From 9ca5ab98c9bd1fe320fe131b8e9d79bce7378a68 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 21:37:32 -0400
 Subject: [PATCH] fc/bash: apply /usr/bin/bash context to /bin/bash.bash
@@ -15,7 +15,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/kernel/corecommands.fc b/policy/modules/kernel/corecommands.fc
-index a53425b0a..c72dce201 100644
+index 59164d5c6..469dbe67c 100644
 --- a/policy/modules/kernel/corecommands.fc
 +++ b/policy/modules/kernel/corecommands.fc
 @@ -155,6 +155,7 @@ ifdef(`distro_gentoo',`
diff --git a/recipes-security/refpolicy/refpolicy/0005-fc-resolv.conf-label-resolv.conf-in-var-run-properly.patch b/recipes-security/refpolicy/refpolicy/0005-fc-resolv.conf-label-resolv.conf-in-var-run-properly.patch
index 14a8f68..3cb2e91 100644
--- a/recipes-security/refpolicy/refpolicy/0005-fc-resolv.conf-label-resolv.conf-in-var-run-properly.patch
+++ b/recipes-security/refpolicy/refpolicy/0005-fc-resolv.conf-label-resolv.conf-in-var-run-properly.patch
@@ -1,4 +1,4 @@
-From 344b071e8aeb77d15fab6131c3d0540a1d319096 Mon Sep 17 00:00:00 2001
+From dd13c78e2540ace19b4c671f0e5a8c8d8e842930 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 4 Apr 2019 10:45:03 -0400
 Subject: [PATCH] fc/resolv.conf: label resolv.conf in var/run/ properly
@@ -13,10 +13,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/sysnetwork.fc b/policy/modules/system/sysnetwork.fc
-index 5dfd6cd6b..5551ef07f 100644
+index 2e035b326..eab862b3d 100644
 --- a/policy/modules/system/sysnetwork.fc
 +++ b/policy/modules/system/sysnetwork.fc
-@@ -86,6 +86,7 @@ ifdef(`distro_redhat',`
+@@ -71,6 +71,7 @@ ifdef(`distro_redhat',`
  /run/dhcpcd(/.*)?		gen_context(system_u:object_r:dhcpc_runtime_t,s0)
  /run/netns	-d		gen_context(system_u:object_r:ifconfig_runtime_t,s0)
  /run/netns/[^/]+	--	<<none>>
diff --git a/recipes-security/refpolicy/refpolicy/0006-fc-login-apply-login-context-to-login.shadow.patch b/recipes-security/refpolicy/refpolicy/0006-fc-login-apply-login-context-to-login.shadow.patch
index 0753adb..86c4b07 100644
--- a/recipes-security/refpolicy/refpolicy/0006-fc-login-apply-login-context-to-login.shadow.patch
+++ b/recipes-security/refpolicy/refpolicy/0006-fc-login-apply-login-context-to-login.shadow.patch
@@ -1,4 +1,4 @@
-From a6eebdef46d6987614e22dd92edc6ff2202ad88d Mon Sep 17 00:00:00 2001
+From eec64127ce7d0c50b40ae7fd8a8891def106ef37 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 21:43:53 -0400
 Subject: [PATCH] fc/login: apply login context to login.shadow
@@ -12,7 +12,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/authlogin.fc b/policy/modules/system/authlogin.fc
-index 3f13fa9fc..6dbb7a499 100644
+index 584b78fa3..ace52ee63 100644
 --- a/policy/modules/system/authlogin.fc
 +++ b/policy/modules/system/authlogin.fc
 @@ -8,6 +8,7 @@
diff --git a/recipes-security/refpolicy/refpolicy/0007-fc-hwclock-add-hwclock-alternatives.patch b/recipes-security/refpolicy/refpolicy/0007-fc-hwclock-add-hwclock-alternatives.patch
index 53245b5..c86b568 100644
--- a/recipes-security/refpolicy/refpolicy/0007-fc-hwclock-add-hwclock-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0007-fc-hwclock-add-hwclock-alternatives.patch
@@ -1,4 +1,4 @@
-From a572902044b8965a2afbf5436c37d1c910a38dff Mon Sep 17 00:00:00 2001
+From 85a5dda3e1ec15ca867ff459256e987d3fc98718 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Thu, 28 Mar 2019 21:59:18 -0400
 Subject: [PATCH] fc/hwclock: add hwclock alternatives
@@ -12,14 +12,15 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/clock.fc b/policy/modules/system/clock.fc
-index 301965892..139485835 100644
+index 4ed95240e..b8e6b801c 100644
 --- a/policy/modules/system/clock.fc
 +++ b/policy/modules/system/clock.fc
-@@ -3,3 +3,4 @@
+@@ -1,4 +1,5 @@
+ /etc/adjtime		--	gen_context(system_u:object_r:adjtime_t,s0)
+ 
  /usr/bin/hwclock	--	gen_context(system_u:object_r:hwclock_exec_t,s0)
++/usr/bin/hwclock\.util-linux	--	gen_context(system_u:object_r:hwclock_exec_t,s0)
  
- /usr/sbin/hwclock	--	gen_context(system_u:object_r:hwclock_exec_t,s0)
-+/usr/sbin/hwclock\.util-linux	--	gen_context(system_u:object_r:hwclock_exec_t,s0)
 -- 
 2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0008-fc-dmesg-apply-policy-to-dmesg-alternatives.patch b/recipes-security/refpolicy/refpolicy/0008-fc-dmesg-apply-policy-to-dmesg-alternatives.patch
index 2f99afd..ac52d2f 100644
--- a/recipes-security/refpolicy/refpolicy/0008-fc-dmesg-apply-policy-to-dmesg-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0008-fc-dmesg-apply-policy-to-dmesg-alternatives.patch
@@ -1,4 +1,4 @@
-From 085f1fc734f93738e44364de9d5ad2c52321c899 Mon Sep 17 00:00:00 2001
+From 7a8bf5af71c6b931cd7f8f3f103ed4de119339f0 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 29 Mar 2019 08:26:55 -0400
 Subject: [PATCH] fc/dmesg: apply policy to dmesg alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0009-fc-ssh-apply-policy-to-ssh-alternatives.patch b/recipes-security/refpolicy/refpolicy/0009-fc-ssh-apply-policy-to-ssh-alternatives.patch
index 2c47ff1..e049627 100644
--- a/recipes-security/refpolicy/refpolicy/0009-fc-ssh-apply-policy-to-ssh-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0009-fc-ssh-apply-policy-to-ssh-alternatives.patch
@@ -1,4 +1,4 @@
-From 5b45a3a02bb95f6ff008716f3a35c3295dcffc48 Mon Sep 17 00:00:00 2001
+From 87366cc35ac0d63581076ad1885064f8f26e7469 Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 29 Mar 2019 09:20:58 -0400
 Subject: [PATCH] fc/ssh: apply policy to ssh alternatives
@@ -12,7 +12,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/services/ssh.fc b/policy/modules/services/ssh.fc
-index c36f27498..81314fd16 100644
+index f9dd0752d..13d9dd35d 100644
 --- a/policy/modules/services/ssh.fc
 +++ b/policy/modules/services/ssh.fc
 @@ -4,6 +4,7 @@ HOME_DIR/\.ssh(/.*)?			gen_context(system_u:object_r:ssh_home_t,s0)
diff --git a/recipes-security/refpolicy/refpolicy/0010-fc-sysnetwork-apply-policy-to-network-commands-alter.patch b/recipes-security/refpolicy/refpolicy/0010-fc-sysnetwork-apply-policy-to-network-commands-alter.patch
index 2f4eb52..5c87320 100644
--- a/recipes-security/refpolicy/refpolicy/0010-fc-sysnetwork-apply-policy-to-network-commands-alter.patch
+++ b/recipes-security/refpolicy/refpolicy/0010-fc-sysnetwork-apply-policy-to-network-commands-alter.patch
@@ -1,4 +1,4 @@
-From 6ea8be2d788b50a54b52412a473629bbedc99c98 Mon Sep 17 00:00:00 2001
+From 9fa0c7e1c999f0362cc1661366d6cd2767a7019d Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Tue, 9 Jun 2015 21:22:52 +0530
 Subject: [PATCH] fc/sysnetwork: apply policy to network commands alternatives
@@ -10,37 +10,29 @@ Signed-off-by: Shrikant Bobade <Shrikant_Bobade@mentor.com>
 Signed-off-by: Joe MacDonald <joe_macdonald@mentor.com>
 Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
 ---
- policy/modules/system/sysnetwork.fc | 4 ++++
- 1 file changed, 4 insertions(+)
+ policy/modules/system/sysnetwork.fc | 3 +++
+ 1 file changed, 3 insertions(+)
 
 diff --git a/policy/modules/system/sysnetwork.fc b/policy/modules/system/sysnetwork.fc
-index 5551ef07f..18707c702 100644
+index eab862b3d..4c9dac6f3 100644
 --- a/policy/modules/system/sysnetwork.fc
 +++ b/policy/modules/system/sysnetwork.fc
-@@ -46,6 +46,7 @@ ifdef(`distro_redhat',`
+@@ -46,13 +46,16 @@ ifdef(`distro_redhat',`
  /usr/bin/dhcpcd		        --	gen_context(system_u:object_r:dhcpc_exec_t,s0)
  /usr/bin/ethtool		    --	gen_context(system_u:object_r:ifconfig_exec_t,s0)
  /usr/bin/ifconfig		    --	gen_context(system_u:object_r:ifconfig_exec_t,s0)
 +/usr/bin/ifconfig\.net-tools		--	gen_context(system_u:object_r:ifconfig_exec_t,s0)
  /usr/bin/ip			        --	gen_context(system_u:object_r:ifconfig_exec_t,s0)
++/usr/bin/ip\.iproute2		--	gen_context(system_u:object_r:ifconfig_exec_t,s0)
  /usr/bin/ipx_configure		--	gen_context(system_u:object_r:ifconfig_exec_t,s0)
  /usr/bin/ipx_interface		--	gen_context(system_u:object_r:ifconfig_exec_t,s0)
-@@ -62,13 +63,16 @@ ifdef(`distro_redhat',`
- /usr/sbin/dhcpcd		--	gen_context(system_u:object_r:dhcpc_exec_t,s0)
- /usr/sbin/ethtool		--	gen_context(system_u:object_r:ifconfig_exec_t,s0)
- /usr/sbin/ifconfig		--	gen_context(system_u:object_r:ifconfig_exec_t,s0)
-+/usr/sbin/ifconfig\.net-tools		--	gen_context(system_u:object_r:ifconfig_exec_t,s0)
- /usr/sbin/ip			--	gen_context(system_u:object_r:ifconfig_exec_t,s0)
-+/usr/sbin/ip\.iproute2			--	gen_context(system_u:object_r:ifconfig_exec_t,s0)
- /usr/sbin/ipx_configure		--	gen_context(system_u:object_r:ifconfig_exec_t,s0)
- /usr/sbin/ipx_interface		--	gen_context(system_u:object_r:ifconfig_exec_t,s0)
- /usr/sbin/ipx_internal_net	--	gen_context(system_u:object_r:ifconfig_exec_t,s0)
- /usr/sbin/iw			--	gen_context(system_u:object_r:ifconfig_exec_t,s0)
- /usr/sbin/iwconfig		--	gen_context(system_u:object_r:ifconfig_exec_t,s0)
- /usr/sbin/mii-tool		--	gen_context(system_u:object_r:ifconfig_exec_t,s0)
-+/usr/sbin/mii-tool\.net-tools		--	gen_context(system_u:object_r:ifconfig_exec_t,s0)
- /usr/sbin/pump			--	gen_context(system_u:object_r:dhcpc_exec_t,s0)
- /usr/sbin/tc			--	gen_context(system_u:object_r:ifconfig_exec_t,s0)
+ /usr/bin/ipx_internal_net	--	gen_context(system_u:object_r:ifconfig_exec_t,s0)
+ /usr/bin/iw			        --	gen_context(system_u:object_r:ifconfig_exec_t,s0)
+ /usr/bin/iwconfig		    --	gen_context(system_u:object_r:ifconfig_exec_t,s0)
+ /usr/bin/mii-tool		    --	gen_context(system_u:object_r:ifconfig_exec_t,s0)
++/usr/bin/mii-tool\.net-tools		--	gen_context(system_u:object_r:ifconfig_exec_t,s0)
+ /usr/bin/pump			    --	gen_context(system_u:object_r:dhcpc_exec_t,s0)
+ /usr/bin/tc			        --	gen_context(system_u:object_r:ifconfig_exec_t,s0)
  
 -- 
 2.34.1
diff --git a/recipes-security/refpolicy/refpolicy/0011-fc-rpm-apply-rpm_exec-policy-to-cpio-binaries.patch b/recipes-security/refpolicy/refpolicy/0011-fc-rpm-apply-rpm_exec-policy-to-cpio-binaries.patch
index 2500731..13a9540 100644
--- a/recipes-security/refpolicy/refpolicy/0011-fc-rpm-apply-rpm_exec-policy-to-cpio-binaries.patch
+++ b/recipes-security/refpolicy/refpolicy/0011-fc-rpm-apply-rpm_exec-policy-to-cpio-binaries.patch
@@ -1,4 +1,4 @@
-From fbc67ac67b34d0bed2bfd7f9ccbbbc84b9a87c05 Mon Sep 17 00:00:00 2001
+From 6a3fdc4dc073cf37a782292fc1cd006f9c26f68c Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 29 Mar 2019 09:54:07 -0400
 Subject: [PATCH] fc/rpm: apply rpm_exec policy to cpio binaries
@@ -8,18 +8,17 @@ Upstream-Status: Inappropriate [embedded specific]
 Signed-off-by: Joe MacDonald <joe_macdonald@mentor.com>
 Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
 ---
- policy/modules/admin/rpm.fc | 2 ++
- 1 file changed, 2 insertions(+)
+ policy/modules/admin/rpm.fc | 1 +
+ 1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/admin/rpm.fc b/policy/modules/admin/rpm.fc
-index 7efcf71de..2f83019f0 100644
+index 059c35a68..22e2a3f65 100644
 --- a/policy/modules/admin/rpm.fc
 +++ b/policy/modules/admin/rpm.fc
-@@ -74,4 +74,6 @@ ifdef(`distro_redhat',`
+@@ -64,4 +64,5 @@ ifdef(`distro_redhat',`
  
  ifdef(`enable_mls',`
- /usr/sbin/cpio	--	gen_context(system_u:object_r:rpm_exec_t,s0)
-+/usr/bin/cpio	--	gen_context(system_u:object_r:rpm_exec_t,s0)
+ /usr/bin/cpio	--	gen_context(system_u:object_r:rpm_exec_t,s0)
 +/usr/bin/cpio\.cpio	--	gen_context(system_u:object_r:rpm_exec_t,s0)
  ')
 -- 
diff --git a/recipes-security/refpolicy/refpolicy/0012-fc-su-apply-policy-to-su-alternatives.patch b/recipes-security/refpolicy/refpolicy/0012-fc-su-apply-policy-to-su-alternatives.patch
index fae65e3..a822887 100644
--- a/recipes-security/refpolicy/refpolicy/0012-fc-su-apply-policy-to-su-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0012-fc-su-apply-policy-to-su-alternatives.patch
@@ -1,4 +1,4 @@
-From b1484fad712a955c22a9fd0c2db3eb452d171d88 Mon Sep 17 00:00:00 2001
+From 03cc031e0154e032cdcaf75d1f6eeaa473cc37a1 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Thu, 13 Feb 2014 00:33:07 -0500
 Subject: [PATCH] fc/su: apply policy to su alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch b/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch
index 6b2902e..33942dd 100644
--- a/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch
+++ b/recipes-security/refpolicy/refpolicy/0013-fc-fstools-fix-real-path-for-fstools.patch
@@ -1,4 +1,4 @@
-From 078961ecb4615082b4c37354cfd10d30feff5030 Mon Sep 17 00:00:00 2001
+From 3ed3519c26ea0146415bf915a78bad55086abbde Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Mon, 27 Jan 2014 03:54:01 -0500
 Subject: [PATCH] fc/fstools: fix real path for fstools
@@ -14,61 +14,68 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 11 insertions(+)
 
 diff --git a/policy/modules/system/fstools.fc b/policy/modules/system/fstools.fc
-index f12c3515b..500acfb23 100644
+index ece09e6b4..aad5a608e 100644
 --- a/policy/modules/system/fstools.fc
 +++ b/policy/modules/system/fstools.fc
-@@ -55,7 +55,9 @@
- /usr/sbin/addpart		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/badblocks		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/blkid			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
-+/usr/sbin/blkid\.util-linux			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/blockdev		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
-+/usr/sbin/blockdev\.util-linux		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/cfdisk		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/clubufflush		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/delpart		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
-@@ -68,23 +70,30 @@
- /usr/sbin/e2mmpstatus		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/fatsort		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/fdisk			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
-+/usr/sbin/fdisk\.util-linux			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/findfs		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
-+/usr/sbin/findfs\.util-linux		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/fstrim		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
-+/usr/sbin/fstrim\.util-linux		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/fsck.*		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/gdisk			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/hdparm		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
-+/usr/sbin/hdparm\.hdparm		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/install-mbr		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/jfs_.*		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/losetup.*		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/lsraid		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/mkdosfs		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/mke2fs		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
-+/usr/sbin/mke2fs\.e2fsprogs		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/mke4fs		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/mkfs.*		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/mkraid		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/mkswap		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
-+/usr/sbin/mkswap\.util-linux		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/parted		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/partprobe		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
-+/usr/sbin/partprobe\.parted		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/partx			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/raidautorun		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/raidstart		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
-@@ -93,8 +102,10 @@
- /usr/sbin/sfdisk		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/smartctl		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/swapoff		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
-+/usr/sbin/swapoff\.util-linux		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/swapon.*		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/tune2fs		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
-+/usr/sbin/tune2fs\.e2fsprogs		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/zdb			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/zhack			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
- /usr/sbin/zinject		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+@@ -1,7 +1,9 @@
+ /usr/bin/addpart		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/badblocks		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/blkid			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
++/usr/bin/blkid\.util-linux			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/blockdev		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
++/usr/bin/blockdev\.util-linux		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/btrfs			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/cfdisk			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/clubufflush		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+@@ -15,23 +17,29 @@
+ /usr/bin/e2mmpstatus		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/fatsort		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/fdisk			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
++/usr/bin/fdisk\.util-linux			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/findfs			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
++/usr/bin/findfs\.util-linux		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/fsck.*			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/gdisk			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/hdparm			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
++/usr/bin/hdparm\.hdparm		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/install-mbr		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/jfs_.*			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/losetup.*		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/lsraid			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/mkdosfs		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/mke2fs			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
++/usr/bin/mke2fs\.e2fsprogs		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/mke4fs			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/mkfs.*			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/mkraid			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/mkswap			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
++/usr/bin/mkswap\.util-linux		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/parted			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/partition_uuid		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/partprobe		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
++/usr/bin/partprobe\.parted		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/partx			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/raidautorun		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/raidstart		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+@@ -43,8 +51,10 @@
+ /usr/bin/sfdisk			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/smartctl		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/swapoff		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
++/usr/bin/swapoff\.util-linux		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/swapon.*		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/tune2fs		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
++/usr/bin/tune2fs\.e2fsprogs		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/zdb			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/zhack			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ /usr/bin/zinject		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+@@ -53,6 +63,7 @@
+ /usr/bin/ztest			--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ 
+ /usr/bin/fstrim		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
++/usr/bin/fstrim\.util-linux		--	gen_context(system_u:object_r:fsadm_exec_t,s0)
+ 
+ ifdef(`distro_gentoo',`
+ /var/db/smartmontools(/.*)?		gen_context(system_u:object_r:fsadm_db_t,s0)
 -- 
 2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0014-fc-init-fix-update-alternatives-for-sysvinit.patch b/recipes-security/refpolicy/refpolicy/0014-fc-init-fix-update-alternatives-for-sysvinit.patch
index f1a10c0..260d796 100644
--- a/recipes-security/refpolicy/refpolicy/0014-fc-init-fix-update-alternatives-for-sysvinit.patch
+++ b/recipes-security/refpolicy/refpolicy/0014-fc-init-fix-update-alternatives-for-sysvinit.patch
@@ -1,4 +1,4 @@
-From d47e8bdcc5f3b8bc21c7efb11d1028d8aee04743 Mon Sep 17 00:00:00 2001
+From fb8cdae6d8b2b196e47941fff258882c2880f89a Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] fc/init: fix update-alternatives for sysvinit
@@ -15,19 +15,19 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  3 files changed, 4 insertions(+)
 
 diff --git a/policy/modules/admin/shutdown.fc b/policy/modules/admin/shutdown.fc
-index 2e47783c2..e359539be 100644
+index 56476f85b..22368afea 100644
 --- a/policy/modules/admin/shutdown.fc
 +++ b/policy/modules/admin/shutdown.fc
-@@ -7,6 +7,7 @@
+@@ -2,6 +2,7 @@
  
- /usr/sbin/halt		--	gen_context(system_u:object_r:shutdown_exec_t,s0)
- /usr/sbin/shutdown	--	gen_context(system_u:object_r:shutdown_exec_t,s0)
-+/usr/sbin/shutdown\.sysvinit	--	gen_context(system_u:object_r:shutdown_exec_t,s0)
+ /usr/bin/halt	--	gen_context(system_u:object_r:shutdown_exec_t,s0)
+ /usr/bin/shutdown	--	gen_context(system_u:object_r:shutdown_exec_t,s0)
++/usr/bin/shutdown\.sysvinit	--	gen_context(system_u:object_r:shutdown_exec_t,s0)
  
- /run/shutdown\.pid	--	gen_context(system_u:object_r:shutdown_runtime_t,s0)
+ /usr/lib/upstart/shutdown	--	gen_context(system_u:object_r:shutdown_exec_t,s0)
  
 diff --git a/policy/modules/kernel/corecommands.fc b/policy/modules/kernel/corecommands.fc
-index c72dce201..a50256c13 100644
+index 469dbe67c..9020ced10 100644
 --- a/policy/modules/kernel/corecommands.fc
 +++ b/policy/modules/kernel/corecommands.fc
 @@ -164,6 +164,8 @@ ifdef(`distro_gentoo',`
@@ -40,17 +40,17 @@ index c72dce201..a50256c13 100644
  /usr/bin/sash			--	gen_context(system_u:object_r:shell_exec_t,s0)
  /usr/bin/sesh			--	gen_context(system_u:object_r:shell_exec_t,s0)
 diff --git a/policy/modules/system/init.fc b/policy/modules/system/init.fc
-index 75c75e7d1..962f18099 100644
+index 19c876336..e865bea85 100644
 --- a/policy/modules/system/init.fc
 +++ b/policy/modules/system/init.fc
-@@ -49,6 +49,7 @@ ifdef(`distro_gentoo',`
- /usr/libexec/dcc/stop-.* --	gen_context(system_u:object_r:initrc_exec_t,s0)
- 
- /usr/sbin/init(ng)?	--	gen_context(system_u:object_r:init_exec_t,s0)
-+/usr/sbin/init\.sysvinit	--	gen_context(system_u:object_r:init_exec_t,s0)
- /usr/sbin/open_init_pty	--	gen_context(system_u:object_r:initrc_exec_t,s0)
- /usr/sbin/upstart	--	gen_context(system_u:object_r:init_exec_t,s0)
- 
+@@ -28,6 +28,7 @@ ifdef(`distro_gentoo',`
+ # /usr
+ #
+ /usr/bin/init(ng)?	--	gen_context(system_u:object_r:init_exec_t,s0)
++/usr/bin/init\.sysvinit	--	gen_context(system_u:object_r:init_exec_t,s0)
+ /usr/bin/open_init_pty	--	gen_context(system_u:object_r:initrc_exec_t,s0)
+ /usr/bin/sepg_ctl	--	gen_context(system_u:object_r:initrc_exec_t,s0)
+ /usr/bin/systemd	--	gen_context(system_u:object_r:init_exec_t,s0)
 -- 
 2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0015-fc-brctl-apply-policy-to-brctl-alternatives.patch b/recipes-security/refpolicy/refpolicy/0015-fc-brctl-apply-policy-to-brctl-alternatives.patch
index 0164d1e..72b1fd6 100644
--- a/recipes-security/refpolicy/refpolicy/0015-fc-brctl-apply-policy-to-brctl-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0015-fc-brctl-apply-policy-to-brctl-alternatives.patch
@@ -1,4 +1,4 @@
-From d366090f2d89448878cfac371c3d1b9694d67f87 Mon Sep 17 00:00:00 2001
+From 89b022f8aa33ad403b76c3fe53caf1a5fbfe4a4b Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:19:54 +0800
 Subject: [PATCH] fc/brctl: apply policy to brctl alternatives
@@ -11,14 +11,13 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/admin/brctl.fc b/policy/modules/admin/brctl.fc
-index ed472f095..2a852b0fd 100644
+index c7cdc3358..231b82dc5 100644
 --- a/policy/modules/admin/brctl.fc
 +++ b/policy/modules/admin/brctl.fc
-@@ -1,3 +1,4 @@
+@@ -1,2 +1,3 @@
  /usr/bin/brctl	--	gen_context(system_u:object_r:brctl_exec_t,s0)
++/usr/bin/brctl\.bridge-utils	--	gen_context(system_u:object_r:brctl_exec_t,s0)
  
- /usr/sbin/brctl	--	gen_context(system_u:object_r:brctl_exec_t,s0)
-+/usr/sbin/brctl\.bridge-utils	--	gen_context(system_u:object_r:brctl_exec_t,s0)
 -- 
 2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0016-fc-corecommands-apply-policy-to-nologin-alternatives.patch b/recipes-security/refpolicy/refpolicy/0016-fc-corecommands-apply-policy-to-nologin-alternatives.patch
index b2e52fd..03f565c 100644
--- a/recipes-security/refpolicy/refpolicy/0016-fc-corecommands-apply-policy-to-nologin-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0016-fc-corecommands-apply-policy-to-nologin-alternatives.patch
@@ -1,4 +1,4 @@
-From a672c11dd652dced7d36ed4b96ba6fb2b20c07b3 Mon Sep 17 00:00:00 2001
+From c34bda34ad6855b5a75a6573dcc7b6450b1646d1 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:21:51 +0800
 Subject: [PATCH] fc/corecommands: apply policy to nologin alternatives
@@ -11,18 +11,18 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/kernel/corecommands.fc b/policy/modules/kernel/corecommands.fc
-index a50256c13..5fd532202 100644
+index 9020ced10..851529abd 100644
 --- a/policy/modules/kernel/corecommands.fc
 +++ b/policy/modules/kernel/corecommands.fc
-@@ -320,6 +320,8 @@ ifdef(`distro_debian',`
- /usr/sbin/insmod_ksymoops_clean	--	gen_context(system_u:object_r:bin_t,s0)
- /usr/sbin/mkfs\.cramfs		--	gen_context(system_u:object_r:bin_t,s0)
- /usr/sbin/nologin		--	gen_context(system_u:object_r:shell_exec_t,s0)
-+/usr/sbin/nologin\.shadow		--	gen_context(system_u:object_r:shell_exec_t,s0)
-+/usr/sbin/nologin\.util-linux		--	gen_context(system_u:object_r:shell_exec_t,s0)
- /usr/sbin/scponlyc		--	gen_context(system_u:object_r:shell_exec_t,s0)
- /usr/sbin/sesh			--	gen_context(system_u:object_r:shell_exec_t,s0)
- /usr/sbin/smrsh			--	gen_context(system_u:object_r:shell_exec_t,s0)
+@@ -167,6 +167,8 @@ ifdef(`distro_gentoo',`
+ /usr/bin/mountpoint\.sysvinit		--	gen_context(system_u:object_r:bin_t,s0)
+ /usr/bin/mountpoint\.util-linux		--	gen_context(system_u:object_r:bin_t,s0)
+ /usr/bin/nologin		--	gen_context(system_u:object_r:shell_exec_t,s0)
++/usr/bin/nologin\.shadow		--	gen_context(system_u:object_r:shell_exec_t,s0)
++/usr/bin/nologin\.util-linux	--	gen_context(system_u:object_r:shell_exec_t,s0)
+ /usr/bin/sash			--	gen_context(system_u:object_r:shell_exec_t,s0)
+ /usr/bin/sesh			--	gen_context(system_u:object_r:shell_exec_t,s0)
+ /usr/bin/scponly		--	gen_context(system_u:object_r:shell_exec_t,s0)
 -- 
 2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0017-fc-locallogin-apply-policy-to-sulogin-alternatives.patch b/recipes-security/refpolicy/refpolicy/0017-fc-locallogin-apply-policy-to-sulogin-alternatives.patch
index 10e9dec..1cf6ca5 100644
--- a/recipes-security/refpolicy/refpolicy/0017-fc-locallogin-apply-policy-to-sulogin-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0017-fc-locallogin-apply-policy-to-sulogin-alternatives.patch
@@ -1,4 +1,4 @@
-From 3241cedb4f96b2b5a7fd8d9f70f90f339e69ee88 Mon Sep 17 00:00:00 2001
+From 074f896320aec752cf1df689982da3d6c26f48a1 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:43:28 +0800
 Subject: [PATCH] fc/locallogin: apply policy to sulogin alternatives
@@ -11,15 +11,14 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/locallogin.fc b/policy/modules/system/locallogin.fc
-index fc8d58507..59e6e9601 100644
+index 761b02490..a434e5013 100644
 --- a/policy/modules/system/locallogin.fc
 +++ b/policy/modules/system/locallogin.fc
-@@ -2,4 +2,5 @@
+@@ -1,3 +1,4 @@
+ /usr/bin/sulogin	--	gen_context(system_u:object_r:sulogin_exec_t,s0)
++/usr/bin/sulogin\.util-linux	--	gen_context(system_u:object_r:sulogin_exec_t,s0)
  /usr/bin/sushell	--	gen_context(system_u:object_r:sulogin_exec_t,s0)
  
- /usr/sbin/sulogin	--	gen_context(system_u:object_r:sulogin_exec_t,s0)
-+/usr/sbin/sulogin\.util-linux	--	gen_context(system_u:object_r:sulogin_exec_t,s0)
- /usr/sbin/sushell	--	gen_context(system_u:object_r:sulogin_exec_t,s0)
 -- 
 2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0018-fc-ntp-apply-policy-to-ntpd-alternatives.patch b/recipes-security/refpolicy/refpolicy/0018-fc-ntp-apply-policy-to-ntpd-alternatives.patch
index acf8521..ae9a5c7 100644
--- a/recipes-security/refpolicy/refpolicy/0018-fc-ntp-apply-policy-to-ntpd-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0018-fc-ntp-apply-policy-to-ntpd-alternatives.patch
@@ -1,4 +1,4 @@
-From a358cddc1a278ac8e40c40a58f2fb20bd6e8da5c Mon Sep 17 00:00:00 2001
+From bc7cf91865d4f49a2af1100e1a0b692fead807e8 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:45:23 +0800
 Subject: [PATCH] fc/ntp: apply policy to ntpd alternatives
@@ -11,16 +11,16 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/services/ntp.fc b/policy/modules/services/ntp.fc
-index 7b55699ee..b55d5fb86 100644
+index ccea79c30..f24cd7c48 100644
 --- a/policy/modules/services/ntp.fc
 +++ b/policy/modules/services/ntp.fc
-@@ -26,6 +26,7 @@
- /usr/lib/systemd/systemd-timesyncd	--	gen_context(system_u:object_r:ntpd_exec_t,s0)
+@@ -17,6 +17,7 @@
+ /run/systemd/timesync(/.*)?			gen_context(system_u:object_r:ntpd_pid_t,s0)
  
- /usr/sbin/ntpd				--	gen_context(system_u:object_r:ntpd_exec_t,s0)
-+/usr/sbin/ntpd\.ntp				--	gen_context(system_u:object_r:ntpd_exec_t,s0)
- /usr/sbin/ntpdate			--	gen_context(system_u:object_r:ntpdate_exec_t,s0)
- /usr/sbin/sntp				--	gen_context(system_u:object_r:ntpdate_exec_t,s0)
+ /usr/bin/ntpd				--	gen_context(system_u:object_r:ntpd_exec_t,s0)
++/usr/bin/ntpd\.ntp			--	gen_context(system_u:object_r:ntpd_exec_t,s0)
+ /usr/bin/ntpdate			--	gen_context(system_u:object_r:ntpdate_exec_t,s0)
+ /usr/bin/sntp				--	gen_context(system_u:object_r:ntpdate_exec_t,s0)
  
 -- 
 2.34.1
diff --git a/recipes-security/refpolicy/refpolicy/0019-fc-kerberos-apply-policy-to-kerberos-alternatives.patch b/recipes-security/refpolicy/refpolicy/0019-fc-kerberos-apply-policy-to-kerberos-alternatives.patch
index 9cd46b3..8b052f3 100644
--- a/recipes-security/refpolicy/refpolicy/0019-fc-kerberos-apply-policy-to-kerberos-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0019-fc-kerberos-apply-policy-to-kerberos-alternatives.patch
@@ -1,4 +1,4 @@
-From 663b9788a061a029d10b9caae0c08e37f7efa063 Mon Sep 17 00:00:00 2001
+From c5f2bec748a7afbb6ea6ff4fdb2e729f749d7e99 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 10:55:05 +0800
 Subject: [PATCH] fc/kerberos: apply policy to kerberos alternatives
@@ -11,10 +11,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 10 insertions(+)
 
 diff --git a/policy/modules/services/kerberos.fc b/policy/modules/services/kerberos.fc
-index df21fcc78..ce0166edd 100644
+index 81627d2db..4966b06d4 100644
 --- a/policy/modules/services/kerberos.fc
 +++ b/policy/modules/services/kerberos.fc
-@@ -12,6 +12,8 @@ HOME_DIR/\.k5login	--	gen_context(system_u:object_r:krb5_home_t,s0)
+@@ -12,9 +12,13 @@ HOME_DIR/\.k5login	--	gen_context(system_u:object_r:krb5_home_t,s0)
  /etc/rc\.d/init\.d/kprop	--	gen_context(system_u:object_r:kerberos_initrc_exec_t,s0)
  /etc/rc\.d/init\.d/krb524d	--	gen_context(system_u:object_r:kerberos_initrc_exec_t,s0)
  /etc/rc\.d/init\.d/krb5kdc	--	gen_context(system_u:object_r:kerberos_initrc_exec_t,s0)
@@ -23,16 +23,12 @@ index df21fcc78..ce0166edd 100644
  
  /usr/bin/krb5kdc	--	gen_context(system_u:object_r:krb5kdc_exec_t,s0)
  /usr/bin/kadmind	--	gen_context(system_u:object_r:kadmind_exec_t,s0)
-@@ -26,6 +28,8 @@ HOME_DIR/\.k5login	--	gen_context(system_u:object_r:krb5_home_t,s0)
++/usr/bin/kadmin\.local	--	gen_context(system_u:object_r:kadmind_exec_t,s0)
++/usr/bin/kpropd	--	gen_context(system_u:object_r:kpropd_exec_t,s0)
  
- /usr/sbin/krb5kdc	--	gen_context(system_u:object_r:krb5kdc_exec_t,s0)
- /usr/sbin/kadmind	--	gen_context(system_u:object_r:kadmind_exec_t,s0)
-+/usr/sbin/kadmin\.local	--	gen_context(system_u:object_r:kadmind_exec_t,s0)
-+/usr/sbin/kpropd	--	gen_context(system_u:object_r:kpropd_exec_t,s0)
- 
- /usr/local/var/krb5kdc(/.*)?	gen_context(system_u:object_r:krb5kdc_conf_t,s0)
- /usr/local/var/krb5kdc/principal.*	gen_context(system_u:object_r:krb5kdc_principal_t,s0)
-@@ -41,6 +45,12 @@ HOME_DIR/\.k5login	--	gen_context(system_u:object_r:krb5_home_t,s0)
+ /usr/kerberos/sbin/krb5kdc	--	gen_context(system_u:object_r:krb5kdc_exec_t,s0)
+ /usr/kerberos/sbin/kadmind	--	gen_context(system_u:object_r:kadmind_exec_t,s0)
+@@ -39,6 +43,12 @@ HOME_DIR/\.k5login	--	gen_context(system_u:object_r:krb5_home_t,s0)
  /var/kerberos/krb5kdc/principal.*	gen_context(system_u:object_r:krb5kdc_principal_t,s0)
  /var/kerberos/krb5kdc/principal.*\.ok	--	gen_context(system_u:object_r:krb5kdc_lock_t,s0)
  
diff --git a/recipes-security/refpolicy/refpolicy/0020-fc-ldap-apply-policy-to-ldap-alternatives.patch b/recipes-security/refpolicy/refpolicy/0020-fc-ldap-apply-policy-to-ldap-alternatives.patch
index a67af58..b4a6674 100644
--- a/recipes-security/refpolicy/refpolicy/0020-fc-ldap-apply-policy-to-ldap-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0020-fc-ldap-apply-policy-to-ldap-alternatives.patch
@@ -1,4 +1,4 @@
-From cd5fe8a285ee8c9911d80f3c6d92166e59a811e4 Mon Sep 17 00:00:00 2001
+From 5028db3655914d148e82237533dc8c07f99be535 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 11:06:13 +0800
 Subject: [PATCH] fc/ldap: apply policy to ldap alternatives
@@ -11,7 +11,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 5 insertions(+)
 
 diff --git a/policy/modules/services/ldap.fc b/policy/modules/services/ldap.fc
-index 0a1d08d0f..65b202962 100644
+index 40c09df5e..cc6c98221 100644
 --- a/policy/modules/services/ldap.fc
 +++ b/policy/modules/services/ldap.fc
 @@ -1,8 +1,10 @@
@@ -25,7 +25,7 @@ index 0a1d08d0f..65b202962 100644
  
  /usr/bin/slapd	--	gen_context(system_u:object_r:slapd_exec_t,s0)
  
-@@ -25,6 +27,9 @@
+@@ -24,6 +26,9 @@
  /var/log/ldap.*	gen_context(system_u:object_r:slapd_log_t,s0)
  /var/log/slapd.*	gen_context(system_u:object_r:slapd_log_t,s0)
  
diff --git a/recipes-security/refpolicy/refpolicy/0021-fc-postgresql-apply-policy-to-postgresql-alternative.patch b/recipes-security/refpolicy/refpolicy/0021-fc-postgresql-apply-policy-to-postgresql-alternative.patch
index 31770a9..def5e80 100644
--- a/recipes-security/refpolicy/refpolicy/0021-fc-postgresql-apply-policy-to-postgresql-alternative.patch
+++ b/recipes-security/refpolicy/refpolicy/0021-fc-postgresql-apply-policy-to-postgresql-alternative.patch
@@ -1,4 +1,4 @@
-From 386fcec20066a67912e71a2f24d96fccdcd80329 Mon Sep 17 00:00:00 2001
+From 4f43e9a674623e562b1805bd06a61ef4690973d8 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 11:13:16 +0800
 Subject: [PATCH] fc/postgresql: apply policy to postgresql alternatives
diff --git a/recipes-security/refpolicy/refpolicy/0022-fc-usermanage-apply-policy-to-usermanage-alternative.patch b/recipes-security/refpolicy/refpolicy/0022-fc-usermanage-apply-policy-to-usermanage-alternative.patch
index ffbebf4..9ca5223 100644
--- a/recipes-security/refpolicy/refpolicy/0022-fc-usermanage-apply-policy-to-usermanage-alternative.patch
+++ b/recipes-security/refpolicy/refpolicy/0022-fc-usermanage-apply-policy-to-usermanage-alternative.patch
@@ -1,4 +1,4 @@
-From 675ef147f22a7c61dc47d4173307d0b4ce703aff Mon Sep 17 00:00:00 2001
+From 8f2b61f8473e0eb191446f639af7ef71fc50fbec Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 11:25:34 +0800
 Subject: [PATCH] fc/usermanage: apply policy to usermanage alternatives
@@ -7,11 +7,11 @@ Upstream-Status: Inappropriate [embedded specific]
 
 Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
 ---
- policy/modules/admin/usermanage.fc | 8 ++++++++
- 1 file changed, 8 insertions(+)
+ policy/modules/admin/usermanage.fc | 7 +++++++
+ 1 file changed, 7 insertions(+)
 
 diff --git a/policy/modules/admin/usermanage.fc b/policy/modules/admin/usermanage.fc
-index 7209a8dd0..c9dc1f000 100644
+index c228ebce6..9ac425e92 100644
 --- a/policy/modules/admin/usermanage.fc
 +++ b/policy/modules/admin/usermanage.fc
 @@ -4,8 +4,13 @@ ifdef(`distro_debian',`
@@ -36,21 +36,13 @@ index 7209a8dd0..c9dc1f000 100644
  /usr/bin/pwconv		--	gen_context(system_u:object_r:admin_passwd_exec_t,s0)
  /usr/bin/pwunconv	--	gen_context(system_u:object_r:admin_passwd_exec_t,s0)
  /usr/bin/useradd	--	gen_context(system_u:object_r:useradd_exec_t,s0)
-@@ -26,6 +32,7 @@ ifdef(`distro_debian',`
- /usr/lib/cracklib_dict.* --	gen_context(system_u:object_r:crack_db_t,s0)
- 
- /usr/sbin/chpasswd	--	gen_context(system_u:object_r:passwd_exec_t,s0)
-+/usr/sbin/chpasswd\.shadow	--	gen_context(system_u:object_r:passwd_exec_t,s0)
- /usr/sbin/crack_[a-z]*	--	gen_context(system_u:object_r:crack_exec_t,s0)
- /usr/sbin/cracklib-[a-z]* --	gen_context(system_u:object_r:crack_exec_t,s0)
- /usr/sbin/gpasswd	--	gen_context(system_u:object_r:groupadd_exec_t,s0)
-@@ -41,6 +48,7 @@ ifdef(`distro_debian',`
- /usr/sbin/usermod	--	gen_context(system_u:object_r:useradd_exec_t,s0)
- /usr/sbin/vigr		--	gen_context(system_u:object_r:admin_passwd_exec_t,s0)
- /usr/sbin/vipw		--	gen_context(system_u:object_r:admin_passwd_exec_t,s0)
-+/usr/sbin/vipw\.shadow		--	gen_context(system_u:object_r:admin_passwd_exec_t,s0)
+@@ -22,6 +28,7 @@ ifdef(`distro_debian',`
+ /usr/bin/usermod	--	gen_context(system_u:object_r:useradd_exec_t,s0)
+ /usr/bin/vigr		--	gen_context(system_u:object_r:admin_passwd_exec_t,s0)
+ /usr/bin/vipw		--	gen_context(system_u:object_r:admin_passwd_exec_t,s0)
++/usr/bin/vipw\.shadow		--	gen_context(system_u:object_r:admin_passwd_exec_t,s0)
  
- /usr/share/cracklib(/.*)?	gen_context(system_u:object_r:crack_db_t,s0)
+ /usr/lib/cracklib_dict.* --	gen_context(system_u:object_r:crack_db_t,s0)
  
 -- 
 2.34.1
diff --git a/recipes-security/refpolicy/refpolicy/0023-fc-getty-add-file-context-to-start_getty.patch b/recipes-security/refpolicy/refpolicy/0023-fc-getty-add-file-context-to-start_getty.patch
index 1b173a1..e9b70b2 100644
--- a/recipes-security/refpolicy/refpolicy/0023-fc-getty-add-file-context-to-start_getty.patch
+++ b/recipes-security/refpolicy/refpolicy/0023-fc-getty-add-file-context-to-start_getty.patch
@@ -1,4 +1,4 @@
-From 521f56f178d4eb2edb6fb553e7d5a89c34efc502 Mon Sep 17 00:00:00 2001
+From 75ad7b87b85a3fb0f0d00b88831a3171a01e8fa0 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 15 Nov 2019 16:07:30 +0800
 Subject: [PATCH] fc/getty: add file context to start_getty
@@ -11,7 +11,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/getty.fc b/policy/modules/system/getty.fc
-index 116ea6421..53ff6137b 100644
+index c7701c930..8b70b609a 100644
 --- a/policy/modules/system/getty.fc
 +++ b/policy/modules/system/getty.fc
 @@ -4,6 +4,7 @@
@@ -20,8 +20,8 @@ index 116ea6421..53ff6137b 100644
  /usr/bin/.*getty	--	gen_context(system_u:object_r:getty_exec_t,s0)
 +/usr/bin/start_getty	--	gen_context(system_u:object_r:bin_t,s0)
  
- /usr/sbin/.*getty	--	gen_context(system_u:object_r:getty_exec_t,s0)
  
+ /var/log/mgetty\.log.*	--	gen_context(system_u:object_r:getty_log_t,s0)
 -- 
 2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0024-fc-vlock-apply-policy-to-vlock-alternatives.patch b/recipes-security/refpolicy/refpolicy/0024-fc-vlock-apply-policy-to-vlock-alternatives.patch
index fb56f09..a03a10a 100644
--- a/recipes-security/refpolicy/refpolicy/0024-fc-vlock-apply-policy-to-vlock-alternatives.patch
+++ b/recipes-security/refpolicy/refpolicy/0024-fc-vlock-apply-policy-to-vlock-alternatives.patch
@@ -1,4 +1,4 @@
-From e96c35b96cde4176cff786bd9fa7c27f3ef18c62 Mon Sep 17 00:00:00 2001
+From 75acb49606229cb4f8d626249efc75544dc37219 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Wed, 18 Dec 2019 15:04:41 +0800
 Subject: [PATCH] fc/vlock: apply policy to vlock alternatives
@@ -11,15 +11,14 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/apps/vlock.fc b/policy/modules/apps/vlock.fc
-index f668cde9c..c4bc50984 100644
+index bdd3e6a9f..fb5b28d7c 100644
 --- a/policy/modules/apps/vlock.fc
 +++ b/policy/modules/apps/vlock.fc
-@@ -1,4 +1,5 @@
+@@ -1,3 +1,4 @@
  /usr/bin/vlock		--	gen_context(system_u:object_r:vlock_exec_t,s0)
 +/usr/bin/vlock\.kbd		--	gen_context(system_u:object_r:vlock_exec_t,s0)
  /usr/bin/vlock-main	--	gen_context(system_u:object_r:vlock_exec_t,s0)
  
- /usr/sbin/vlock-main	--	gen_context(system_u:object_r:vlock_exec_t,s0)
 -- 
 2.34.1
 
diff --git a/recipes-security/refpolicy/refpolicy/0025-fc-add-fcontext-for-init-scripts-and-systemd-service.patch b/recipes-security/refpolicy/refpolicy/0025-fc-add-fcontext-for-init-scripts-and-systemd-service.patch
index 2cf78d6..25fd308 100644
--- a/recipes-security/refpolicy/refpolicy/0025-fc-add-fcontext-for-init-scripts-and-systemd-service.patch
+++ b/recipes-security/refpolicy/refpolicy/0025-fc-add-fcontext-for-init-scripts-and-systemd-service.patch
@@ -1,4 +1,4 @@
-From f6c4563a967dee1ca09dd4759503f79bfdbe4fe0 Mon Sep 17 00:00:00 2001
+From 4db66a10c2917fe08f643726b9854d1230090bcc Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 30 Jun 2020 10:45:57 +0800
 Subject: [PATCH] fc: add fcontext for init scripts and systemd service files
@@ -14,7 +14,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  4 files changed, 5 insertions(+)
 
 diff --git a/policy/modules/services/cron.fc b/policy/modules/services/cron.fc
-index e71ad22c1..bb1351732 100644
+index 8c9a749bc..f5a52b406 100644
 --- a/policy/modules/services/cron.fc
 +++ b/policy/modules/services/cron.fc
 @@ -1,4 +1,5 @@
@@ -24,7 +24,7 @@ index e71ad22c1..bb1351732 100644
  /etc/cron\.d(/.*)?	gen_context(system_u:object_r:system_cron_spool_t,s0)
  /etc/crontab	--	gen_context(system_u:object_r:system_cron_spool_t,s0)
 diff --git a/policy/modules/services/rngd.fc b/policy/modules/services/rngd.fc
-index 382c067f9..0ecc5acc4 100644
+index 367592c8d..6b5a5f11e 100644
 --- a/policy/modules/services/rngd.fc
 +++ b/policy/modules/services/rngd.fc
 @@ -1,4 +1,5 @@
@@ -34,7 +34,7 @@ index 382c067f9..0ecc5acc4 100644
  /usr/bin/rngd	--	gen_context(system_u:object_r:rngd_exec_t,s0)
  
 diff --git a/policy/modules/services/rpc.fc b/policy/modules/services/rpc.fc
-index fb579bc9d..12e086b8d 100644
+index b6fe7d990..df70afb7c 100644
 --- a/policy/modules/services/rpc.fc
 +++ b/policy/modules/services/rpc.fc
 @@ -2,7 +2,9 @@
@@ -48,7 +48,7 @@ index fb579bc9d..12e086b8d 100644
  
  /usr/bin/blkmapd	--	gen_context(system_u:object_r:blkmapd_exec_t,s0)
 diff --git a/policy/modules/system/logging.fc b/policy/modules/system/logging.fc
-index 102a89e48..b10ea8acf 100644
+index 0b6698d63..e2a43f305 100644
 --- a/policy/modules/system/logging.fc
 +++ b/policy/modules/system/logging.fc
 @@ -24,6 +24,7 @@
diff --git a/recipes-security/refpolicy/refpolicy/0026-file_contexts.subs_dist-set-aliase-for-root-director.patch b/recipes-security/refpolicy/refpolicy/0026-file_contexts.subs_dist-set-aliase-for-root-director.patch
index ccc53e1..cf4d59d 100644
--- a/recipes-security/refpolicy/refpolicy/0026-file_contexts.subs_dist-set-aliase-for-root-director.patch
+++ b/recipes-security/refpolicy/refpolicy/0026-file_contexts.subs_dist-set-aliase-for-root-director.patch
@@ -1,4 +1,4 @@
-From 1186572ce9dd51b05c21e1f93e2495a46eb20176 Mon Sep 17 00:00:00 2001
+From 795b2380c6f1e3541384f69d0f00e8933dfacf93 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Sun, 5 Apr 2020 22:03:45 +0800
 Subject: [PATCH] file_contexts.subs_dist: set aliase for /root directory
@@ -14,16 +14,16 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 4 insertions(+)
 
 diff --git a/config/file_contexts.subs_dist b/config/file_contexts.subs_dist
-index e782151ef..8aaf36858 100644
+index 8a5274283..f54517d89 100644
 --- a/config/file_contexts.subs_dist
 +++ b/config/file_contexts.subs_dist
-@@ -45,3 +45,7 @@
+@@ -46,3 +46,7 @@
  /usr/lib/busybox/bin /usr/bin
- /usr/lib/busybox/sbin /usr/sbin
+ /usr/lib/busybox/sbin /usr/bin
  /usr/lib/busybox/usr /usr
 +
-+# The genhomedircon.py will expand /root home directory to /home/root
-+# Add an aliase for it
++# The script genhomedircon.py will expand `/root` (i.e. root's home
++# directory) to `/home/root`. Add an alias for it.
 +/root /home/root
 -- 
 2.34.1
diff --git a/recipes-security/refpolicy/refpolicy/0027-policy-modules-system-logging-add-rules-for-the-syml.patch b/recipes-security/refpolicy/refpolicy/0027-policy-modules-system-logging-add-rules-for-the-syml.patch
index a27572a..c2972f8 100644
--- a/recipes-security/refpolicy/refpolicy/0027-policy-modules-system-logging-add-rules-for-the-syml.patch
+++ b/recipes-security/refpolicy/refpolicy/0027-policy-modules-system-logging-add-rules-for-the-syml.patch
@@ -1,4 +1,4 @@
-From 90c97030a68682dd11f5bf968c4705a4524b263d Mon Sep 17 00:00:00 2001
+From 318c45578888ef3d697f095869100dce81247c0d Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/system/logging: add rules for the symlink of
@@ -18,10 +18,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  2 files changed, 8 insertions(+)
 
 diff --git a/policy/modules/system/logging.fc b/policy/modules/system/logging.fc
-index b10ea8acf..6aa62b4ba 100644
+index e2a43f305..7bedcdc00 100644
 --- a/policy/modules/system/logging.fc
 +++ b/policy/modules/system/logging.fc
-@@ -53,6 +53,7 @@ ifdef(`distro_suse', `
+@@ -42,6 +42,7 @@ ifdef(`distro_suse', `
  /var/dnscache/log/main(/.*)?	gen_context(system_u:object_r:var_log_t,s0)
  
  /var/log		-d	gen_context(system_u:object_r:var_log_t,s0-mls_systemhigh)
@@ -30,7 +30,7 @@ index b10ea8acf..6aa62b4ba 100644
  /var/log/dmesg		--	gen_context(system_u:object_r:var_log_t,s0)
  /var/log/syslog		--	gen_context(system_u:object_r:var_log_t,s0)
 diff --git a/policy/modules/system/logging.if b/policy/modules/system/logging.if
-index 499da83ba..ac05e206d 100644
+index 3dd2c06c2..7d108709f 100644
 --- a/policy/modules/system/logging.if
 +++ b/policy/modules/system/logging.if
 @@ -1091,10 +1091,12 @@ interface(`logging_append_all_inherited_logs',`
diff --git a/recipes-security/refpolicy/refpolicy/0028-policy-modules-system-logging-add-rules-for-syslogd-.patch b/recipes-security/refpolicy/refpolicy/0028-policy-modules-system-logging-add-rules-for-syslogd-.patch
index 57fd4ba..167f2c0 100644
--- a/recipes-security/refpolicy/refpolicy/0028-policy-modules-system-logging-add-rules-for-syslogd-.patch
+++ b/recipes-security/refpolicy/refpolicy/0028-policy-modules-system-logging-add-rules-for-syslogd-.patch
@@ -1,4 +1,4 @@
-From fb1d2f5840747edf6d8a0031d38c5e7beb872520 Mon Sep 17 00:00:00 2001
+From 88aa13b30249ebcaada8075508efa603a041915b Mon Sep 17 00:00:00 2001
 From: Joe MacDonald <joe_macdonald@mentor.com>
 Date: Fri, 29 Mar 2019 10:33:18 -0400
 Subject: [PATCH] policy/modules/system/logging: add rules for syslogd symlink
@@ -18,7 +18,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index 0ba5d3d8b..d8621f9e1 100644
+index 314b2559b..5d1930a58 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -429,6 +429,7 @@ files_search_spool(syslogd_t)
diff --git a/recipes-security/refpolicy/refpolicy/0029-policy-modules-kernel-files-add-rules-for-the-symlin.patch b/recipes-security/refpolicy/refpolicy/0029-policy-modules-kernel-files-add-rules-for-the-symlin.patch
index 87de42b..367852f 100644
--- a/recipes-security/refpolicy/refpolicy/0029-policy-modules-kernel-files-add-rules-for-the-symlin.patch
+++ b/recipes-security/refpolicy/refpolicy/0029-policy-modules-kernel-files-add-rules-for-the-symlin.patch
@@ -1,4 +1,4 @@
-From 8041f8d8f41166061dd86e5fc1bea9323168ae7f Mon Sep 17 00:00:00 2001
+From 97db230c2b1ddf0a9b725e4bee879fc5c13c86a5 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/kernel/files: add rules for the symlink of
@@ -18,10 +18,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  2 files changed, 9 insertions(+)
 
 diff --git a/policy/modules/kernel/files.fc b/policy/modules/kernel/files.fc
-index d174f882c..d393a6bc2 100644
+index 972e94e3d..f98e9d07c 100644
 --- a/policy/modules/kernel/files.fc
 +++ b/policy/modules/kernel/files.fc
-@@ -167,6 +167,7 @@ HOME_ROOT/lost\+found/.*	<<none>>
+@@ -172,6 +172,7 @@ HOME_ROOT/lost\+found/.*	<<none>>
  # /tmp
  #
  /tmp			-d	gen_context(system_u:object_r:tmp_t,s0-mls_systemhigh)
@@ -30,10 +30,10 @@ index d174f882c..d393a6bc2 100644
  /tmp/\.journal			<<none>>
  
 diff --git a/policy/modules/kernel/files.if b/policy/modules/kernel/files.if
-index e55bf337e..5d67cae99 100644
+index 0b2e449b9..79ea2171f 100644
 --- a/policy/modules/kernel/files.if
 +++ b/policy/modules/kernel/files.if
-@@ -4970,6 +4970,7 @@ interface(`files_search_tmp',`
+@@ -4988,6 +4988,7 @@ interface(`files_search_tmp',`
  	')
  
  	allow $1 tmp_t:dir search_dir_perms;
@@ -41,7 +41,7 @@ index e55bf337e..5d67cae99 100644
  ')
  
  ########################################
-@@ -5006,6 +5007,7 @@ interface(`files_list_tmp',`
+@@ -5024,6 +5025,7 @@ interface(`files_list_tmp',`
  	')
  
  	allow $1 tmp_t:dir list_dir_perms;
@@ -49,7 +49,7 @@ index e55bf337e..5d67cae99 100644
  ')
  
  ########################################
-@@ -5042,6 +5044,7 @@ interface(`files_delete_tmp_dir_entry',`
+@@ -5060,6 +5062,7 @@ interface(`files_delete_tmp_dir_entry',`
  	')
  
  	allow $1 tmp_t:dir del_entry_dir_perms;
@@ -57,7 +57,7 @@ index e55bf337e..5d67cae99 100644
  ')
  
  ########################################
-@@ -5060,6 +5063,7 @@ interface(`files_read_generic_tmp_files',`
+@@ -5078,6 +5081,7 @@ interface(`files_read_generic_tmp_files',`
  	')
  
  	read_files_pattern($1, tmp_t, tmp_t)
@@ -65,7 +65,7 @@ index e55bf337e..5d67cae99 100644
  ')
  
  ########################################
-@@ -5078,6 +5082,7 @@ interface(`files_manage_generic_tmp_dirs',`
+@@ -5096,6 +5100,7 @@ interface(`files_manage_generic_tmp_dirs',`
  	')
  
  	manage_dirs_pattern($1, tmp_t, tmp_t)
@@ -73,7 +73,7 @@ index e55bf337e..5d67cae99 100644
  ')
  
  ########################################
-@@ -5114,6 +5119,7 @@ interface(`files_manage_generic_tmp_files',`
+@@ -5132,6 +5137,7 @@ interface(`files_manage_generic_tmp_files',`
  	')
  
  	manage_files_pattern($1, tmp_t, tmp_t)
@@ -81,7 +81,7 @@ index e55bf337e..5d67cae99 100644
  ')
  
  ########################################
-@@ -5150,6 +5156,7 @@ interface(`files_rw_generic_tmp_sockets',`
+@@ -5168,6 +5174,7 @@ interface(`files_rw_generic_tmp_sockets',`
  	')
  
  	rw_sock_files_pattern($1, tmp_t, tmp_t)
@@ -89,7 +89,7 @@ index e55bf337e..5d67cae99 100644
  ')
  
  ########################################
-@@ -5357,6 +5364,7 @@ interface(`files_tmp_filetrans',`
+@@ -5375,6 +5382,7 @@ interface(`files_tmp_filetrans',`
  	')
  
  	filetrans_pattern($1, tmp_t, $2, $3, $4)
diff --git a/recipes-security/refpolicy/refpolicy/0030-policy-modules-system-logging-fix-auditd-startup-fai.patch b/recipes-security/refpolicy/refpolicy/0030-policy-modules-system-logging-fix-auditd-startup-fai.patch
index 054742a..da1bd03 100644
--- a/recipes-security/refpolicy/refpolicy/0030-policy-modules-system-logging-fix-auditd-startup-fai.patch
+++ b/recipes-security/refpolicy/refpolicy/0030-policy-modules-system-logging-fix-auditd-startup-fai.patch
@@ -1,4 +1,4 @@
-From 403738f594cba99590bdbf01d52d984e55d9e08e Mon Sep 17 00:00:00 2001
+From 41e8dbe65aa55bb892f4e794ce822cdc2cd22339 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/system/logging: fix auditd startup failures
@@ -17,7 +17,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 3 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index d8621f9e1..cbef358c2 100644
+index 5d1930a58..90797d54f 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
 @@ -120,6 +120,7 @@ allow auditctl_t auditd_log_t:file read_file_perms;
diff --git a/recipes-security/refpolicy/refpolicy/0031-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch b/recipes-security/refpolicy/refpolicy/0031-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch
index 58bd04c..436b5f8 100644
--- a/recipes-security/refpolicy/refpolicy/0031-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch
+++ b/recipes-security/refpolicy/refpolicy/0031-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch
@@ -1,4 +1,4 @@
-From 3995b0994210a4e7035169961fe94012afffe544 Mon Sep 17 00:00:00 2001
+From dd08a7cc9679cda711ed3537102458d56224ef5d Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/kernel/terminal: don't audit tty_device_t in
diff --git a/recipes-security/refpolicy/refpolicy/0032-policy-modules-system-systemd-enable-support-for-sys.patch b/recipes-security/refpolicy/refpolicy/0032-policy-modules-system-systemd-enable-support-for-sys.patch
index 8b08712..241ac31 100644
--- a/recipes-security/refpolicy/refpolicy/0032-policy-modules-system-systemd-enable-support-for-sys.patch
+++ b/recipes-security/refpolicy/refpolicy/0032-policy-modules-system-systemd-enable-support-for-sys.patch
@@ -1,4 +1,4 @@
-From 4f6738e1d904da305282cb4c5a8c90669a4d328f Mon Sep 17 00:00:00 2001
+From a9b04a012c6968668ae761818deb2254b0789a53 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Thu, 4 Feb 2016 06:03:19 -0500
 Subject: [PATCH] policy/modules/system/systemd: enable support for
@@ -29,7 +29,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+), 1 deletion(-)
 
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index 4c8158470..255b8a3f0 100644
+index e773deab1..df23d7c62 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
 @@ -10,7 +10,7 @@ policy_module(systemd)
diff --git a/recipes-security/refpolicy/refpolicy/0033-policy-modules-system-logging-allow-systemd-tmpfiles.patch b/recipes-security/refpolicy/refpolicy/0033-policy-modules-system-logging-allow-systemd-tmpfiles.patch
deleted file mode 100644
index 7b317f8..0000000
--- a/recipes-security/refpolicy/refpolicy/0033-policy-modules-system-logging-allow-systemd-tmpfiles.patch
+++ /dev/null
@@ -1,43 +0,0 @@
-From edeb47c29f852c8a85bd8d33c2cb472920cf9a28 Mon Sep 17 00:00:00 2001
-From: Yi Zhao <yi.zhao@windriver.com>
-Date: Sat, 30 Sep 2023 17:20:29 +0800
-Subject: [PATCH] policy/modules/system/logging: allow systemd-tmpfiles to
- create /var/log/audit
-
-Fixes:
-systemd[1]: Starting Security Auditing Service...
-auditd[246]: Could not open dir /var/log/audit (No such file or directory)
-auditd[246]: The audit daemon is exiting.
-systemd[1]: auditd.service: Control process exited, code=exited, status=6/NOTCONFIGURED
-systemd[1]: auditd.service: Failed with result 'exit-code'.
-systemd[1]: Failed to start Security Auditing Service.
-
-AVC avc:  denied  { create } for  pid=224 comm="systemd-tmpfile"
-name="audit" scontext=system_u:system_r:systemd_tmpfiles_t
-tcontext=system_u:object_r:auditd_log_t tclass=dir permissive=0
-
-Upstream-Status: Inappropriate [embedded specific]
-
-Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
----
- policy/modules/system/logging.te | 4 ++++
- 1 file changed, 4 insertions(+)
-
-diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index cbef358c2..d22a3207c 100644
---- a/policy/modules/system/logging.te
-+++ b/policy/modules/system/logging.te
-@@ -27,6 +27,10 @@ type auditd_log_t;
- files_security_file(auditd_log_t)
- files_security_mountpoint(auditd_log_t)
- 
-+optional_policy(`
-+	systemd_tmpfilesd_managed(auditd_log_t)
-+')
-+
- type audit_spool_t;
- files_security_file(audit_spool_t)
- files_security_mountpoint(audit_spool_t)
--- 
-2.34.1
-
diff --git a/recipes-security/refpolicy/refpolicy/0034-policy-modules-system-systemd-systemd-user-fixes.patch b/recipes-security/refpolicy/refpolicy/0033-policy-modules-system-systemd-systemd-user-fixes.patch
similarity index 90%
rename from recipes-security/refpolicy/refpolicy/0034-policy-modules-system-systemd-systemd-user-fixes.patch
rename to recipes-security/refpolicy/refpolicy/0033-policy-modules-system-systemd-systemd-user-fixes.patch
index f826de7..30f0f91 100644
--- a/recipes-security/refpolicy/refpolicy/0034-policy-modules-system-systemd-systemd-user-fixes.patch
+++ b/recipes-security/refpolicy/refpolicy/0033-policy-modules-system-systemd-systemd-user-fixes.patch
@@ -1,4 +1,4 @@
-From cb2183b13c440bfc03d56b26c4f90868e753e307 Mon Sep 17 00:00:00 2001
+From 38eae959958cbf3c1a17a22e853d1765786638a4 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Thu, 4 Feb 2021 10:48:54 +0800
 Subject: [PATCH] policy/modules/system/systemd: systemd --user fixes
@@ -31,10 +31,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  2 files changed, 35 insertions(+)
 
 diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
-index 809fde402..1955f5409 100644
+index 378a4ca3d..f22b8ea82 100644
 --- a/policy/modules/system/systemd.if
 +++ b/policy/modules/system/systemd.if
-@@ -267,6 +267,37 @@ template(`systemd_role_template',`
+@@ -268,6 +268,37 @@ template(`systemd_role_template',`
  	')
  ')
  
@@ -73,10 +73,10 @@ index 809fde402..1955f5409 100644
  ## <summary>
  ##   Allow the specified domain to be started as a daemon by the
 diff --git a/policy/modules/system/userdomain.if b/policy/modules/system/userdomain.if
-index 10b085d41..b751f7de0 100644
+index 6a1009d26..9c32410a5 100644
 --- a/policy/modules/system/userdomain.if
 +++ b/policy/modules/system/userdomain.if
-@@ -1479,6 +1479,10 @@ template(`userdom_admin_user_template',`
+@@ -1489,6 +1489,10 @@ template(`userdom_admin_user_template',`
  	optional_policy(`
  		userhelper_exec($1_t)
  	')
diff --git a/recipes-security/refpolicy/refpolicy/0035-policy-modules-system-logging-grant-getpcap-capabili.patch b/recipes-security/refpolicy/refpolicy/0034-policy-modules-system-logging-grant-getpcap-capabili.patch
similarity index 90%
rename from recipes-security/refpolicy/refpolicy/0035-policy-modules-system-logging-grant-getpcap-capabili.patch
rename to recipes-security/refpolicy/refpolicy/0034-policy-modules-system-logging-grant-getpcap-capabili.patch
index 8c0ba66..60a76b3 100644
--- a/recipes-security/refpolicy/refpolicy/0035-policy-modules-system-logging-grant-getpcap-capabili.patch
+++ b/recipes-security/refpolicy/refpolicy/0034-policy-modules-system-logging-grant-getpcap-capabili.patch
@@ -1,4 +1,4 @@
-From 2b90866ebd50527fb3cf099e16a6f5bcd09a9e39 Mon Sep 17 00:00:00 2001
+From 73445954288e54a76a1eaeaf0cbe43c3b56d3eaa Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 28 May 2024 11:21:48 +0800
 Subject: [PATCH] policy/modules/system/logging: grant getpcap capability to
@@ -21,10 +21,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index 950aa3f8d..089ffc768 100644
+index 90797d54f..cf4fdb2fe 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
-@@ -406,6 +406,8 @@ optional_policy(`
+@@ -402,6 +402,8 @@ optional_policy(`
  # sys_admin for the integrated klog of syslog-ng and metalog
  # sys_nice for rsyslog
  allow syslogd_t self:capability { chown dac_override fsetid setgid setuid sys_admin sys_nice sys_resource sys_tty_config };
diff --git a/recipes-security/refpolicy/refpolicy/0036-policy-modules-system-allow-services-to-read-tmpfs-u.patch b/recipes-security/refpolicy/refpolicy/0035-policy-modules-system-allow-services-to-read-tmpfs-u.patch
similarity index 95%
rename from recipes-security/refpolicy/refpolicy/0036-policy-modules-system-allow-services-to-read-tmpfs-u.patch
rename to recipes-security/refpolicy/refpolicy/0035-policy-modules-system-allow-services-to-read-tmpfs-u.patch
index b032c3f..961a337 100644
--- a/recipes-security/refpolicy/refpolicy/0036-policy-modules-system-allow-services-to-read-tmpfs-u.patch
+++ b/recipes-security/refpolicy/refpolicy/0035-policy-modules-system-allow-services-to-read-tmpfs-u.patch
@@ -1,4 +1,4 @@
-From 75088c2e74893f5ae19f44a15766a91e74a25af2 Mon Sep 17 00:00:00 2001
+From c73aa825771f481be83b6a31e85fa8a885965671 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 30 Aug 2024 12:39:48 +0800
 Subject: [PATCH] policy/modules/system: allow services to read tmpfs under
@@ -67,10 +67,10 @@ index a900226bf..75b94785b 100644
  mcs_process_set_categories(getty_t)
  
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index b1d9c20d2..69b3405b3 100644
+index cf4fdb2fe..9200dcbdb 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
-@@ -495,6 +495,7 @@ files_read_kernel_symbol_table(syslogd_t)
+@@ -491,6 +491,7 @@ files_read_kernel_symbol_table(syslogd_t)
  files_var_lib_filetrans(syslogd_t, syslogd_var_lib_t, { file dir })
  
  fs_getattr_all_fs(syslogd_t)
@@ -79,10 +79,10 @@ index b1d9c20d2..69b3405b3 100644
  
  mls_file_write_all_levels(syslogd_t) # Need to be able to write to /var/run/ and /var/log directories
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index 255b8a3f0..b9af00ec8 100644
+index df23d7c62..b34125656 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -1471,6 +1471,7 @@ files_watch_root_dirs(systemd_networkd_t)
+@@ -1478,6 +1478,7 @@ files_watch_root_dirs(systemd_networkd_t)
  files_list_runtime(systemd_networkd_t)
  
  fs_getattr_all_fs(systemd_networkd_t)
diff --git a/recipes-security/refpolicy/refpolicy/0037-policy-modules-kernel-domain-allow-all-domains-to-co.patch b/recipes-security/refpolicy/refpolicy/0036-policy-modules-kernel-domain-allow-all-domains-to-co.patch
similarity index 88%
rename from recipes-security/refpolicy/refpolicy/0037-policy-modules-kernel-domain-allow-all-domains-to-co.patch
rename to recipes-security/refpolicy/refpolicy/0036-policy-modules-kernel-domain-allow-all-domains-to-co.patch
index a9ba8ad..ce7dd82 100644
--- a/recipes-security/refpolicy/refpolicy/0037-policy-modules-kernel-domain-allow-all-domains-to-co.patch
+++ b/recipes-security/refpolicy/refpolicy/0036-policy-modules-kernel-domain-allow-all-domains-to-co.patch
@@ -1,4 +1,4 @@
-From 41f947d2985d449c5712e56c4b177a7f1b373867 Mon Sep 17 00:00:00 2001
+From 905963229d0456b9e38917f6c2fba8bb57a3e705 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Thu, 3 Oct 2024 21:12:33 +0800
 Subject: [PATCH] policy/modules/kernel/domain: allow all domains to connect to
@@ -23,10 +23,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/kernel/domain.te b/policy/modules/kernel/domain.te
-index 0f38015b6..e3eee0590 100644
+index 7c7fe8f32..241084c4b 100644
 --- a/policy/modules/kernel/domain.te
 +++ b/policy/modules/kernel/domain.te
-@@ -131,6 +131,7 @@ files_list_root(domain)
+@@ -134,6 +134,7 @@ files_list_root(domain)
  ifdef(`init_systemd',`
  	optional_policy(`
  		shutdown_sigchld(domain)
diff --git a/recipes-security/refpolicy/refpolicy/0038-systemd-allow-systemd-logind-to-inherit-fds.patch b/recipes-security/refpolicy/refpolicy/0037-systemd-allow-systemd-logind-to-inherit-fds.patch
similarity index 89%
rename from recipes-security/refpolicy/refpolicy/0038-systemd-allow-systemd-logind-to-inherit-fds.patch
rename to recipes-security/refpolicy/refpolicy/0037-systemd-allow-systemd-logind-to-inherit-fds.patch
index c55a35c..45a419f 100644
--- a/recipes-security/refpolicy/refpolicy/0038-systemd-allow-systemd-logind-to-inherit-fds.patch
+++ b/recipes-security/refpolicy/refpolicy/0037-systemd-allow-systemd-logind-to-inherit-fds.patch
@@ -1,4 +1,4 @@
-From 7ec9f3f6be543977921eed4b2bba4c6e27004883 Mon Sep 17 00:00:00 2001
+From e25f4ac72ae24ac301a334bf9bad4c2992664ee3 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 18 Feb 2025 09:54:06 +0800
 Subject: [PATCH] systemd: allow systemd-logind to inherit fds
@@ -20,7 +20,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  2 files changed, 22 insertions(+)
 
 diff --git a/policy/modules/admin/su.if b/policy/modules/admin/su.if
-index ebb7ef0e0..0398ce6fd 100644
+index 4566b522b..b6c7ca0a5 100644
 --- a/policy/modules/admin/su.if
 +++ b/policy/modules/admin/su.if
 @@ -232,6 +232,10 @@ template(`su_role_template',`
@@ -35,10 +35,10 @@ index ebb7ef0e0..0398ce6fd 100644
  		allow $3 $1_su_t:process signal;
  
 diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
-index 1955f5409..0d9ff59e2 100644
+index f22b8ea82..cc2709551 100644
 --- a/policy/modules/system/systemd.if
 +++ b/policy/modules/system/systemd.if
-@@ -1581,6 +1581,24 @@ interface(`systemd_use_logind_fds',`
+@@ -1582,6 +1582,24 @@ interface(`systemd_use_logind_fds',`
  	allow $1 systemd_logind_t:fd use;
  ')
  
diff --git a/recipes-security/refpolicy/refpolicy/0039-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch b/recipes-security/refpolicy/refpolicy/0038-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch
similarity index 93%
rename from recipes-security/refpolicy/refpolicy/0039-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch
rename to recipes-security/refpolicy/refpolicy/0038-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch
index 1a16711..b36cc5c 100644
--- a/recipes-security/refpolicy/refpolicy/0039-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch
+++ b/recipes-security/refpolicy/refpolicy/0038-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch
@@ -1,4 +1,4 @@
-From 40dae32ff55f82d4e4e9d309bc91c0216d616b51 Mon Sep 17 00:00:00 2001
+From 634dc2988ce5eaff7d1cd27cd5c9eeb32183e637 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 18 Feb 2025 15:26:19 +0800
 Subject: [PATCH] systemd: allow systemd-tmpfiles to read bin_t symlink
@@ -23,10 +23,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  4 files changed, 23 insertions(+)
 
 diff --git a/policy/modules/kernel/corecommands.fc b/policy/modules/kernel/corecommands.fc
-index 0da8a2ddb..007341a65 100644
+index 851529abd..1480e1104 100644
 --- a/policy/modules/kernel/corecommands.fc
 +++ b/policy/modules/kernel/corecommands.fc
-@@ -249,6 +249,7 @@ ifdef(`distro_gentoo',`
+@@ -251,6 +251,7 @@ ifdef(`distro_gentoo',`
  /usr/lib/sftp-server		--	gen_context(system_u:object_r:bin_t,s0)
  /usr/lib/ssh(/.*)?			gen_context(system_u:object_r:bin_t,s0)
  /usr/lib/sudo/sesh		--	gen_context(system_u:object_r:shell_exec_t,s0)
@@ -73,10 +73,10 @@ index cc2709551..b67b78a69 100644
  	domtrans_pattern($1_systemd_t, systemd_tmpfiles_exec_t, $1_systemd_tmpfiles_t)
  	read_files_pattern($1_systemd_t, $1_systemd_tmpfiles_t, $1_systemd_tmpfiles_t)
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index 1ae8e3a7d..e1cc0cfde 100644
+index b34125656..c1c873fa5 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -2161,6 +2161,9 @@ kernel_getattr_proc(systemd_tmpfiles_t)
+@@ -2169,6 +2169,9 @@ kernel_getattr_proc(systemd_tmpfiles_t)
  kernel_read_kernel_sysctls(systemd_tmpfiles_t)
  kernel_read_network_state(systemd_tmpfiles_t)
  
diff --git a/recipes-security/refpolicy/refpolicy/0040-systemd-fix-for-systemd-networkd-and-systemd-rfkill.patch b/recipes-security/refpolicy/refpolicy/0039-systemd-fix-for-systemd-networkd-and-systemd-rfkill.patch
similarity index 90%
rename from recipes-security/refpolicy/refpolicy/0040-systemd-fix-for-systemd-networkd-and-systemd-rfkill.patch
rename to recipes-security/refpolicy/refpolicy/0039-systemd-fix-for-systemd-networkd-and-systemd-rfkill.patch
index c85b08c..57b4296 100644
--- a/recipes-security/refpolicy/refpolicy/0040-systemd-fix-for-systemd-networkd-and-systemd-rfkill.patch
+++ b/recipes-security/refpolicy/refpolicy/0039-systemd-fix-for-systemd-networkd-and-systemd-rfkill.patch
@@ -1,4 +1,4 @@
-From df839088b81e67270d856bebcb6c3b7528f6b46c Mon Sep 17 00:00:00 2001
+From eeb5333253ad0fd19cf065b79c76012d88acfd61 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 26 Sep 2025 15:15:44 +0800
 Subject: [PATCH] systemd: fix for systemd-networkd and systemd-rfkill
@@ -35,10 +35,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 5 insertions(+), 1 deletion(-)
 
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index e79dec101..b4afcab57 100644
+index c1c873fa5..4a790c5dc 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -1423,7 +1423,7 @@ systemd_log_parse_environment(systemd_modules_load_t)
+@@ -1427,7 +1427,7 @@ systemd_log_parse_environment(systemd_modules_load_t)
  # networkd local policy
  #
  
@@ -47,7 +47,7 @@ index e79dec101..b4afcab57 100644
  allow systemd_networkd_t self:netlink_generic_socket create_socket_perms;
  allow systemd_networkd_t self:netlink_kobject_uevent_socket create_socket_perms;
  allow systemd_networkd_t self:netlink_netfilter_socket create_socket_perms;
-@@ -1463,12 +1463,15 @@ corenet_udp_bind_generic_node(systemd_networkd_t)
+@@ -1470,12 +1470,15 @@ corenet_udp_bind_generic_node(systemd_networkd_t)
  dev_read_urand(systemd_networkd_t)
  dev_read_sysfs(systemd_networkd_t)
  dev_write_kmsg(systemd_networkd_t)
@@ -63,7 +63,7 @@ index e79dec101..b4afcab57 100644
  
  fs_getattr_all_fs(systemd_networkd_t)
  fs_list_tmpfs(systemd_networkd_t)
-@@ -1899,6 +1902,7 @@ logging_send_syslog_msg(systemd_pstore_t)
+@@ -1914,6 +1917,7 @@ logging_send_syslog_msg(systemd_pstore_t)
  # Rfkill local policy
  #
  
diff --git a/recipes-security/refpolicy/refpolicy/0041-systemd-allow-domain-used-for-login-program-to-conne.patch b/recipes-security/refpolicy/refpolicy/0040-systemd-allow-domain-used-for-login-program-to-conne.patch
similarity index 91%
rename from recipes-security/refpolicy/refpolicy/0041-systemd-allow-domain-used-for-login-program-to-conne.patch
rename to recipes-security/refpolicy/refpolicy/0040-systemd-allow-domain-used-for-login-program-to-conne.patch
index 6ddc91f..46d3046 100644
--- a/recipes-security/refpolicy/refpolicy/0041-systemd-allow-domain-used-for-login-program-to-conne.patch
+++ b/recipes-security/refpolicy/refpolicy/0040-systemd-allow-domain-used-for-login-program-to-conne.patch
@@ -1,4 +1,4 @@
-From 42297b6e559cce0778517bbc4625a44417d7ce0b Mon Sep 17 00:00:00 2001
+From f94cd726509a88f8efd72b175fe3079544e9ef26 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Fri, 6 Feb 2026 22:13:03 +0800
 Subject: [PATCH] systemd: allow domain used for login program to connect to
@@ -25,10 +25,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  3 files changed, 22 insertions(+)
 
 diff --git a/policy/modules/system/authlogin.if b/policy/modules/system/authlogin.if
-index bb282024c..db8fd8e39 100644
+index 82d3f6684..db1fcc344 100644
 --- a/policy/modules/system/authlogin.if
 +++ b/policy/modules/system/authlogin.if
-@@ -227,6 +227,7 @@ interface(`auth_login_pgm_domain',`
+@@ -230,6 +230,7 @@ interface(`auth_login_pgm_domain',`
  		systemd_read_logind_state($1)
  		systemd_write_inherited_logind_sessions_pipes($1)
  		systemd_use_passwd_agent_fds($1)
@@ -49,10 +49,10 @@ index 505a054ff..e44d82a88 100644
  /run/tmpfiles\.d	-d	gen_context(system_u:object_r:systemd_tmpfiles_conf_t,s0)
  /run/tmpfiles\.d/.*		<<none>>
 diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
-index da6a30470..e184b1d77 100644
+index b67b78a69..cc57a29f4 100644
 --- a/policy/modules/system/systemd.if
 +++ b/policy/modules/system/systemd.if
-@@ -1600,6 +1600,26 @@ interface(`systemd_inherit_logind_fds',`
+@@ -1601,6 +1601,26 @@ interface(`systemd_inherit_logind_fds',`
  	allow systemd_logind_t $1:fd use;
  ')
  
diff --git a/recipes-security/refpolicy/refpolicy/0042-systemd-add-rules-for-systemd-ssh-issue.patch b/recipes-security/refpolicy/refpolicy/0041-systemd-add-rules-for-systemd-ssh-issue.patch
similarity index 94%
rename from recipes-security/refpolicy/refpolicy/0042-systemd-add-rules-for-systemd-ssh-issue.patch
rename to recipes-security/refpolicy/refpolicy/0041-systemd-add-rules-for-systemd-ssh-issue.patch
index 768768a..875896b 100644
--- a/recipes-security/refpolicy/refpolicy/0042-systemd-add-rules-for-systemd-ssh-issue.patch
+++ b/recipes-security/refpolicy/refpolicy/0041-systemd-add-rules-for-systemd-ssh-issue.patch
@@ -1,4 +1,4 @@
-From 77336cfaff881b80e3f0c1dd4abef78a208b304f Mon Sep 17 00:00:00 2001
+From 37f557b73474ed2f746c8bb6c2cd5c5d7de3a7d5 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Mon, 9 Feb 2026 15:42:19 +0800
 Subject: [PATCH] systemd: add rules for systemd-ssh-issue
@@ -70,10 +70,10 @@ index e44d82a88..130c62370 100644
  /run/nologin	--	gen_context(system_u:object_r:systemd_sessions_runtime_t,s0)
  
 diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
-index e184b1d77..c9c841a2a 100644
+index cc57a29f4..3a513a17e 100644
 --- a/policy/modules/system/systemd.if
 +++ b/policy/modules/system/systemd.if
-@@ -3211,3 +3211,22 @@ interface(`systemd_use_inherited_machined_ptys', `
+@@ -3212,3 +3212,22 @@ interface(`systemd_use_inherited_machined_ptys', `
  	allow $1 systemd_machined_t:fd use;
  	allow $1 systemd_machined_devpts_t:chr_file rw_inherited_term_perms;
  ')
@@ -97,10 +97,10 @@ index e184b1d77..c9c841a2a 100644
 +	read_files_pattern($1, systemd_ssh_issue_runtime_t, systemd_ssh_issue_runtime_t)
 +')
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index b4afcab57..11a206fd0 100644
+index 4a790c5dc..c7dc5570c 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -306,6 +306,14 @@ corenet_port(systemd_socket_proxyd_port_t)
+@@ -309,6 +309,14 @@ corenet_port(systemd_socket_proxyd_port_t)
  type systemd_socket_proxyd_unit_file_t;
  init_unit_file(systemd_socket_proxyd_unit_file_t)
  
@@ -115,7 +115,7 @@ index b4afcab57..11a206fd0 100644
  type systemd_sysctl_t;
  type systemd_sysctl_exec_t;
  init_daemon_domain(systemd_sysctl_t, systemd_sysctl_exec_t)
-@@ -2071,6 +2079,33 @@ fs_getattr_nsfs_files(systemd_sysctl_t)
+@@ -2090,6 +2098,33 @@ fs_getattr_nsfs_files(systemd_sysctl_t)
  
  systemd_log_parse_environment(systemd_sysctl_t)
  
diff --git a/recipes-security/refpolicy/refpolicy/0043-policy-modules-system-mount-make-mount_t-domain-MLS-.patch b/recipes-security/refpolicy/refpolicy/0042-policy-modules-system-mount-make-mount_t-domain-MLS-.patch
similarity index 94%
rename from recipes-security/refpolicy/refpolicy/0043-policy-modules-system-mount-make-mount_t-domain-MLS-.patch
rename to recipes-security/refpolicy/refpolicy/0042-policy-modules-system-mount-make-mount_t-domain-MLS-.patch
index 22df7c6..a659716 100644
--- a/recipes-security/refpolicy/refpolicy/0043-policy-modules-system-mount-make-mount_t-domain-MLS-.patch
+++ b/recipes-security/refpolicy/refpolicy/0042-policy-modules-system-mount-make-mount_t-domain-MLS-.patch
@@ -1,4 +1,4 @@
-From 3d50a217b3dabfaf8534041aefad3e9a2477d86a Mon Sep 17 00:00:00 2001
+From 4f1a73b96f69d58c077396f7579eba99992a1c15 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Sat, 15 Feb 2014 04:22:47 -0500
 Subject: [PATCH] policy/modules/system/mount: make mount_t domain MLS trusted
diff --git a/recipes-security/refpolicy/refpolicy/0044-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch b/recipes-security/refpolicy/refpolicy/0043-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch
similarity index 95%
rename from recipes-security/refpolicy/refpolicy/0044-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch
rename to recipes-security/refpolicy/refpolicy/0043-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch
index 1f8e4fc..c2c2352 100644
--- a/recipes-security/refpolicy/refpolicy/0044-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch
+++ b/recipes-security/refpolicy/refpolicy/0043-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch
@@ -1,4 +1,4 @@
-From df5097ba1d8e492c3bd7b019432d9012e943e1d8 Mon Sep 17 00:00:00 2001
+From 296b3dfb91f6d0c8943541c12e0c07a41d39f73c Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Mon, 28 Jan 2019 14:05:18 +0800
 Subject: [PATCH] policy/modules/roles/sysadm: MLS - sysadm rw to clearance
diff --git a/recipes-security/refpolicy/refpolicy/0045-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch b/recipes-security/refpolicy/refpolicy/0044-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch
similarity index 85%
rename from recipes-security/refpolicy/refpolicy/0045-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch
rename to recipes-security/refpolicy/refpolicy/0044-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch
index 621c54b..806499d 100644
--- a/recipes-security/refpolicy/refpolicy/0045-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch
+++ b/recipes-security/refpolicy/refpolicy/0044-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch
@@ -1,4 +1,4 @@
-From 93e604f1b58a174b3871713dd5a3449a9d4a0d04 Mon Sep 17 00:00:00 2001
+From d017af66a1eded70679188844c227ce239b0d794 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Fri, 23 Aug 2013 12:01:53 +0800
 Subject: [PATCH] policy/modules/services/rpc: make nfsd_t domain MLS trusted
@@ -15,10 +15,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  2 files changed, 7 insertions(+)
 
 diff --git a/policy/modules/kernel/kernel.te b/policy/modules/kernel/kernel.te
-index 26578a26d..74984078d 100644
+index cb82f6635..75aa94bc6 100644
 --- a/policy/modules/kernel/kernel.te
 +++ b/policy/modules/kernel/kernel.te
-@@ -384,6 +384,8 @@ mls_process_read_all_levels(kernel_t)
+@@ -392,6 +392,8 @@ mls_process_read_all_levels(kernel_t)
  mls_process_write_all_levels(kernel_t)
  mls_file_write_all_levels(kernel_t)
  mls_file_read_all_levels(kernel_t)
@@ -28,10 +28,10 @@ index 26578a26d..74984078d 100644
  ifdef(`distro_redhat',`
  	# Bugzilla 222337
 diff --git a/policy/modules/services/rpcbind.te b/policy/modules/services/rpcbind.te
-index 137c21ece..d2ee1edcf 100644
+index a0bedbe69..fdd93a469 100644
 --- a/policy/modules/services/rpcbind.te
 +++ b/policy/modules/services/rpcbind.te
-@@ -73,6 +73,11 @@ logging_send_syslog_msg(rpcbind_t)
+@@ -75,6 +75,11 @@ logging_send_syslog_msg(rpcbind_t)
  
  miscfiles_read_localization(rpcbind_t)
  
diff --git a/recipes-security/refpolicy/refpolicy/0046-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch b/recipes-security/refpolicy/refpolicy/0045-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch
similarity index 85%
rename from recipes-security/refpolicy/refpolicy/0046-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch
rename to recipes-security/refpolicy/refpolicy/0045-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch
index 5ca30cb..dadd446 100644
--- a/recipes-security/refpolicy/refpolicy/0046-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch
+++ b/recipes-security/refpolicy/refpolicy/0045-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch
@@ -1,4 +1,4 @@
-From 81bee8a2e32c4e5c0c0e321b4ef1a5c2b7a59c93 Mon Sep 17 00:00:00 2001
+From 836b210ce616aed73769bff2c8b2a5904de900fe Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 30 Jun 2020 10:18:20 +0800
 Subject: [PATCH] policy/modules/admin/dmesg: make dmesg_t MLS trusted reading
@@ -19,10 +19,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/admin/dmesg.te b/policy/modules/admin/dmesg.te
-index f1da315a9..89478c38e 100644
+index 2b98b0e7f..9432cc78a 100644
 --- a/policy/modules/admin/dmesg.te
 +++ b/policy/modules/admin/dmesg.te
-@@ -52,6 +52,8 @@ miscfiles_read_localization(dmesg_t)
+@@ -53,6 +53,8 @@ miscfiles_read_localization(dmesg_t)
  userdom_dontaudit_use_unpriv_user_fds(dmesg_t)
  userdom_use_user_terminals(dmesg_t)
  
diff --git a/recipes-security/refpolicy/refpolicy/0047-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch b/recipes-security/refpolicy/refpolicy/0046-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
similarity index 95%
rename from recipes-security/refpolicy/refpolicy/0047-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
rename to recipes-security/refpolicy/refpolicy/0046-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
index faee3a0..0c7490e 100644
--- a/recipes-security/refpolicy/refpolicy/0047-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
+++ b/recipes-security/refpolicy/refpolicy/0046-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
@@ -1,4 +1,4 @@
-From 6cfdfb222bb39241c126d71c892c73860ad7198a Mon Sep 17 00:00:00 2001
+From 51446ea7377a19f2353c03cf0ad98261f8348c45 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Fri, 13 Oct 2017 07:20:40 +0000
 Subject: [PATCH] policy/modules/kernel/kernel: make kernel_t MLS trusted for
@@ -59,10 +59,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/kernel/kernel.te b/policy/modules/kernel/kernel.te
-index 74984078d..a1fc34ca8 100644
+index 75aa94bc6..329103506 100644
 --- a/policy/modules/kernel/kernel.te
 +++ b/policy/modules/kernel/kernel.te
-@@ -386,6 +386,8 @@ mls_file_write_all_levels(kernel_t)
+@@ -394,6 +394,8 @@ mls_file_write_all_levels(kernel_t)
  mls_file_read_all_levels(kernel_t)
  mls_socket_write_all_levels(kernel_t)
  mls_fd_use_all_levels(kernel_t)
diff --git a/recipes-security/refpolicy/refpolicy/0048-policy-modules-system-init-make-init_t-MLS-trusted-f.patch b/recipes-security/refpolicy/refpolicy/0047-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
similarity index 93%
rename from recipes-security/refpolicy/refpolicy/0048-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
rename to recipes-security/refpolicy/refpolicy/0047-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
index 21c1fa4..3b71066 100644
--- a/recipes-security/refpolicy/refpolicy/0048-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
+++ b/recipes-security/refpolicy/refpolicy/0047-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
@@ -1,4 +1,4 @@
-From 763d9886f4f16582b08deb6485f39c5547e7ceee Mon Sep 17 00:00:00 2001
+From b2e14817293ee3b353e5a333e84c8e7aa82ab280 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Fri, 15 Jan 2016 03:47:05 -0500
 Subject: [PATCH] policy/modules/system/init: make init_t MLS trusted for
@@ -27,7 +27,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 4 insertions(+)
 
 diff --git a/policy/modules/system/init.te b/policy/modules/system/init.te
-index cb9c3d97a..43b4789f7 100644
+index 388c9b28c..25b74378a 100644
 --- a/policy/modules/system/init.te
 +++ b/policy/modules/system/init.te
 @@ -256,6 +256,10 @@ mls_process_write_all_levels(init_t)
diff --git a/recipes-security/refpolicy/refpolicy/0049-policy-modules-system-systemd-make-systemd-tmpfiles_.patch b/recipes-security/refpolicy/refpolicy/0048-policy-modules-system-systemd-make-systemd-tmpfiles_.patch
similarity index 92%
rename from recipes-security/refpolicy/refpolicy/0049-policy-modules-system-systemd-make-systemd-tmpfiles_.patch
rename to recipes-security/refpolicy/refpolicy/0048-policy-modules-system-systemd-make-systemd-tmpfiles_.patch
index 11284c7..57cc208 100644
--- a/recipes-security/refpolicy/refpolicy/0049-policy-modules-system-systemd-make-systemd-tmpfiles_.patch
+++ b/recipes-security/refpolicy/refpolicy/0048-policy-modules-system-systemd-make-systemd-tmpfiles_.patch
@@ -1,4 +1,4 @@
-From 9346ebe2f4863a4adbbb36fa9a9596eafa48f945 Mon Sep 17 00:00:00 2001
+From 4de0cdb34e58244bf7594c567c170c8923f4b907 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Thu, 4 Feb 2016 06:03:19 -0500
 Subject: [PATCH] policy/modules/system/systemd: make systemd-tmpfiles_t domain
@@ -43,10 +43,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 5 insertions(+)
 
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index 11a206fd0..5aa424e5f 100644
+index c7dc5570c..7ead872e9 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -2282,6 +2282,11 @@ sysnet_relabel_config(systemd_tmpfiles_t)
+@@ -2313,6 +2313,11 @@ sysnet_relabel_config(systemd_tmpfiles_t)
  
  systemd_log_parse_environment(systemd_tmpfiles_t)
  
diff --git a/recipes-security/refpolicy/refpolicy/0050-policy-modules-system-systemd-systemd-make-systemd_-.patch b/recipes-security/refpolicy/refpolicy/0049-policy-modules-system-systemd-systemd-make-systemd_-.patch
similarity index 90%
rename from recipes-security/refpolicy/refpolicy/0050-policy-modules-system-systemd-systemd-make-systemd_-.patch
rename to recipes-security/refpolicy/refpolicy/0049-policy-modules-system-systemd-systemd-make-systemd_-.patch
index 18320b9..2cb9fc5 100644
--- a/recipes-security/refpolicy/refpolicy/0050-policy-modules-system-systemd-systemd-make-systemd_-.patch
+++ b/recipes-security/refpolicy/refpolicy/0049-policy-modules-system-systemd-systemd-make-systemd_-.patch
@@ -1,4 +1,4 @@
-From 3bd39b5127037d6aead60d2c665773329fcce203 Mon Sep 17 00:00:00 2001
+From 1ee01571a182d70db76fce86ddd447de4dfd3c32 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Thu, 18 Jun 2020 09:59:58 +0800
 Subject: [PATCH] policy/modules/system/systemd: systemd-*: make systemd_*_t
@@ -43,10 +43,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 12 insertions(+)
 
 diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
-index 5aa424e5f..5649f79af 100644
+index 7ead872e9..26f06e482 100644
 --- a/policy/modules/system/systemd.te
 +++ b/policy/modules/system/systemd.te
-@@ -473,6 +473,9 @@ optional_policy(`
+@@ -476,6 +476,9 @@ optional_policy(`
  	unconfined_dbus_send(systemd_backlight_t)
  ')
  
@@ -56,7 +56,7 @@ index 5aa424e5f..5649f79af 100644
  #######################################
  #
  # Binfmt local policy
-@@ -686,6 +689,9 @@ udev_read_runtime_files(systemd_generator_t)
+@@ -690,6 +693,9 @@ udev_read_runtime_files(systemd_generator_t)
  # for systemd-getty-generator
  userdom_use_user_ttys(systemd_generator_t)
  
@@ -66,7 +66,7 @@ index 5aa424e5f..5649f79af 100644
  ifdef(`distro_gentoo',`
  	corecmd_shell_entry_type(systemd_generator_t)
  ')
-@@ -1208,6 +1214,9 @@ userdom_relabelto_user_runtime_dirs(systemd_logind_t)
+@@ -1212,6 +1218,9 @@ userdom_relabelto_user_runtime_dirs(systemd_logind_t)
  userdom_setattr_user_ttys(systemd_logind_t)
  userdom_use_user_terminals(systemd_logind_t)
  
@@ -76,7 +76,7 @@ index 5aa424e5f..5649f79af 100644
  # Needed to work around patch not yet merged into the systemd-logind supported on RHEL 7.x
  # The change in systemd by Nicolas Iooss on 02-Feb-2016 with hash 4b51966cf6c06250036e428608da92f8640beb96
  # should fix the problem where user directories in /run/user/$UID/ are not getting the proper context
-@@ -1934,6 +1943,9 @@ udev_read_runtime_files(systemd_rfkill_t)
+@@ -1949,6 +1958,9 @@ udev_read_runtime_files(systemd_rfkill_t)
  
  systemd_log_parse_environment(systemd_rfkill_t)
  
diff --git a/recipes-security/refpolicy/refpolicy/0051-policy-modules-system-logging-add-the-syslogd_t-to-t.patch b/recipes-security/refpolicy/refpolicy/0050-policy-modules-system-logging-add-the-syslogd_t-to-t.patch
similarity index 89%
rename from recipes-security/refpolicy/refpolicy/0051-policy-modules-system-logging-add-the-syslogd_t-to-t.patch
rename to recipes-security/refpolicy/refpolicy/0050-policy-modules-system-logging-add-the-syslogd_t-to-t.patch
index 961f0b4..8027c14 100644
--- a/recipes-security/refpolicy/refpolicy/0051-policy-modules-system-logging-add-the-syslogd_t-to-t.patch
+++ b/recipes-security/refpolicy/refpolicy/0050-policy-modules-system-logging-add-the-syslogd_t-to-t.patch
@@ -1,4 +1,4 @@
-From cc4bae3b5fa0d7c9f98401aa40d9a753503239ca Mon Sep 17 00:00:00 2001
+From 48ce274e3d696199ea98d8b2e389e3824cf08071 Mon Sep 17 00:00:00 2001
 From: Xin Ouyang <Xin.Ouyang@windriver.com>
 Date: Thu, 22 Aug 2013 13:37:23 +0800
 Subject: [PATCH] policy/modules/system/logging: add the syslogd_t to trusted
@@ -18,10 +18,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 3 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index 69b3405b3..63405a193 100644
+index 9200dcbdb..255b831f8 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
-@@ -499,6 +499,9 @@ fs_list_tmpfs(syslogd_t)
+@@ -495,6 +495,9 @@ fs_list_tmpfs(syslogd_t)
  fs_search_auto_mountpoints(syslogd_t)
  
  mls_file_write_all_levels(syslogd_t) # Need to be able to write to /var/run/ and /var/log directories
diff --git a/recipes-security/refpolicy/refpolicy/0052-policy-modules-system-init-make-init_t-MLS-trusted-f.patch b/recipes-security/refpolicy/refpolicy/0051-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
similarity index 91%
rename from recipes-security/refpolicy/refpolicy/0052-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
rename to recipes-security/refpolicy/refpolicy/0051-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
index f737243..daef8c7 100644
--- a/recipes-security/refpolicy/refpolicy/0052-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
+++ b/recipes-security/refpolicy/refpolicy/0051-policy-modules-system-init-make-init_t-MLS-trusted-f.patch
@@ -1,4 +1,4 @@
-From 0786f87a616c9c3fa2c72026180e0e5f375b6ae1 Mon Sep 17 00:00:00 2001
+From da5692ab6d8641e047575ea65273ed5113c87ce2 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Tue, 28 May 2019 16:41:37 +0800
 Subject: [PATCH] policy/modules/system/init: make init_t MLS trusted for
@@ -17,7 +17,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/system/init.te b/policy/modules/system/init.te
-index 43b4789f7..a66b8731b 100644
+index 25b74378a..242ceb78c 100644
 --- a/policy/modules/system/init.te
 +++ b/policy/modules/system/init.te
 @@ -255,6 +255,7 @@ mls_file_write_all_levels(init_t)
diff --git a/recipes-security/refpolicy/refpolicy/0053-policy-modules-system-init-all-init_t-to-read-any-le.patch b/recipes-security/refpolicy/refpolicy/0052-policy-modules-system-init-all-init_t-to-read-any-le.patch
similarity index 92%
rename from recipes-security/refpolicy/refpolicy/0053-policy-modules-system-init-all-init_t-to-read-any-le.patch
rename to recipes-security/refpolicy/refpolicy/0052-policy-modules-system-init-all-init_t-to-read-any-le.patch
index 75fb9a1..161c584 100644
--- a/recipes-security/refpolicy/refpolicy/0053-policy-modules-system-init-all-init_t-to-read-any-le.patch
+++ b/recipes-security/refpolicy/refpolicy/0052-policy-modules-system-init-all-init_t-to-read-any-le.patch
@@ -1,4 +1,4 @@
-From f5e17d4a1eb17a247d33dc68b96ff15326541924 Mon Sep 17 00:00:00 2001
+From 1609f49b78df89b699a26406e795e439dbc33ece Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Wed, 3 Feb 2016 04:16:06 -0500
 Subject: [PATCH] policy/modules/system/init: all init_t to read any level
@@ -22,7 +22,7 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 3 insertions(+)
 
 diff --git a/policy/modules/system/init.te b/policy/modules/system/init.te
-index a66b8731b..15bffd9cf 100644
+index 242ceb78c..8188f8aec 100644
 --- a/policy/modules/system/init.te
 +++ b/policy/modules/system/init.te
 @@ -261,6 +261,9 @@ mls_key_write_all_levels(init_t)
diff --git a/recipes-security/refpolicy/refpolicy/0054-policy-modules-system-logging-allow-auditd_t-to-writ.patch b/recipes-security/refpolicy/refpolicy/0053-policy-modules-system-logging-allow-auditd_t-to-writ.patch
similarity index 88%
rename from recipes-security/refpolicy/refpolicy/0054-policy-modules-system-logging-allow-auditd_t-to-writ.patch
rename to recipes-security/refpolicy/refpolicy/0053-policy-modules-system-logging-allow-auditd_t-to-writ.patch
index b98c750..944d3ae 100644
--- a/recipes-security/refpolicy/refpolicy/0054-policy-modules-system-logging-allow-auditd_t-to-writ.patch
+++ b/recipes-security/refpolicy/refpolicy/0053-policy-modules-system-logging-allow-auditd_t-to-writ.patch
@@ -1,4 +1,4 @@
-From 12b7d2999051ab060d12f3c55287d6f96094e0b2 Mon Sep 17 00:00:00 2001
+From f36eaaf7a0da3f7aec39bac3a1953742a8364155 Mon Sep 17 00:00:00 2001
 From: Wenzong Fan <wenzong.fan@windriver.com>
 Date: Thu, 25 Feb 2016 04:25:08 -0500
 Subject: [PATCH] policy/modules/system/logging: allow auditd_t to write socket
@@ -22,10 +22,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index 63405a193..7ef69524c 100644
+index 255b831f8..1ee634f76 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
-@@ -240,6 +240,8 @@ miscfiles_read_localization(auditd_t)
+@@ -236,6 +236,8 @@ miscfiles_read_localization(auditd_t)
  
  mls_file_read_all_levels(auditd_t)
  mls_file_write_all_levels(auditd_t) # Need to be able to write to /var/run/ directory
diff --git a/recipes-security/refpolicy/refpolicy/0055-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch b/recipes-security/refpolicy/refpolicy/0054-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
similarity index 84%
rename from recipes-security/refpolicy/refpolicy/0055-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
rename to recipes-security/refpolicy/refpolicy/0054-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
index 1767ab8..deceb3d 100644
--- a/recipes-security/refpolicy/refpolicy/0055-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
+++ b/recipes-security/refpolicy/refpolicy/0054-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch
@@ -1,4 +1,4 @@
-From ea9fd03253df275d10a0b7c42f45975078b89a7b Mon Sep 17 00:00:00 2001
+From b09860b6c092539deb05b7d4f0eff1d7505ab289 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Thu, 31 Oct 2019 17:35:59 +0800
 Subject: [PATCH] policy/modules/kernel/kernel: make kernel_t MLS trusted for
@@ -15,10 +15,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+)
 
 diff --git a/policy/modules/kernel/kernel.te b/policy/modules/kernel/kernel.te
-index a1fc34ca8..7ec2aa471 100644
+index 329103506..287b0098f 100644
 --- a/policy/modules/kernel/kernel.te
 +++ b/policy/modules/kernel/kernel.te
-@@ -388,6 +388,7 @@ mls_socket_write_all_levels(kernel_t)
+@@ -396,6 +396,7 @@ mls_socket_write_all_levels(kernel_t)
  mls_fd_use_all_levels(kernel_t)
  # https://bugzilla.redhat.com/show_bug.cgi?id=667370
  mls_file_downgrade(kernel_t)
diff --git a/recipes-security/refpolicy/refpolicy/0056-policy-modules-system-setrans-allow-setrans_t-use-fd.patch b/recipes-security/refpolicy/refpolicy/0055-policy-modules-system-setrans-allow-setrans_t-use-fd.patch
similarity index 93%
rename from recipes-security/refpolicy/refpolicy/0056-policy-modules-system-setrans-allow-setrans_t-use-fd.patch
rename to recipes-security/refpolicy/refpolicy/0055-policy-modules-system-setrans-allow-setrans_t-use-fd.patch
index a7e132c..69025fd 100644
--- a/recipes-security/refpolicy/refpolicy/0056-policy-modules-system-setrans-allow-setrans_t-use-fd.patch
+++ b/recipes-security/refpolicy/refpolicy/0055-policy-modules-system-setrans-allow-setrans_t-use-fd.patch
@@ -1,4 +1,4 @@
-From faae5ef0261d41da137b64e0d99adff300316827 Mon Sep 17 00:00:00 2001
+From 9ee2c564ec3b5e2663356ac78b9b8709d557f4cb Mon Sep 17 00:00:00 2001
 From: Roy Li <rongqing.li@windriver.com>
 Date: Sat, 22 Feb 2014 13:35:38 +0800
 Subject: [PATCH] policy/modules/system/setrans: allow setrans_t use fd at any
diff --git a/recipes-security/refpolicy/refpolicy/0057-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch b/recipes-security/refpolicy/refpolicy/0056-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch
similarity index 88%
rename from recipes-security/refpolicy/refpolicy/0057-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch
rename to recipes-security/refpolicy/refpolicy/0056-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch
index 3203249..9a3d5bf 100644
--- a/recipes-security/refpolicy/refpolicy/0057-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch
+++ b/recipes-security/refpolicy/refpolicy/0056-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch
@@ -1,4 +1,4 @@
-From f639aebeade83c4d3bfe7ab2ec94c3a6321082f4 Mon Sep 17 00:00:00 2001
+From 61869545d8823fbfcbed0bab49838cdb0a5b2a95 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Mon, 22 Feb 2021 11:28:12 +0800
 Subject: [PATCH] policy/modules/system/systemd: make *_systemd_t MLS trusted
@@ -24,10 +24,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 3 insertions(+)
 
 diff --git a/policy/modules/system/systemd.if b/policy/modules/system/systemd.if
-index c9c841a2a..36cba9a19 100644
+index 3a513a17e..4e3ec2bb0 100644
 --- a/policy/modules/system/systemd.if
 +++ b/policy/modules/system/systemd.if
-@@ -266,6 +266,9 @@ template(`systemd_role_template',`
+@@ -267,6 +267,9 @@ template(`systemd_role_template',`
  		xserver_read_xdm_state($1_systemd_t)
  		xserver_use_user_fonts($1_systemd_t)
  	')
diff --git a/recipes-security/refpolicy/refpolicy/0058-policy-modules-system-logging-make-syslogd_runtime_t.patch b/recipes-security/refpolicy/refpolicy/0057-policy-modules-system-logging-make-syslogd_runtime_t.patch
similarity index 90%
rename from recipes-security/refpolicy/refpolicy/0058-policy-modules-system-logging-make-syslogd_runtime_t.patch
rename to recipes-security/refpolicy/refpolicy/0057-policy-modules-system-logging-make-syslogd_runtime_t.patch
index e6db96c..2953fa1 100644
--- a/recipes-security/refpolicy/refpolicy/0058-policy-modules-system-logging-make-syslogd_runtime_t.patch
+++ b/recipes-security/refpolicy/refpolicy/0057-policy-modules-system-logging-make-syslogd_runtime_t.patch
@@ -1,4 +1,4 @@
-From 55fdb65085d3358caf9b142baf2996aa4ae28738 Mon Sep 17 00:00:00 2001
+From b507082584e70abfcf6446e38da92b848f6ae586 Mon Sep 17 00:00:00 2001
 From: Yi Zhao <yi.zhao@windriver.com>
 Date: Sat, 18 Dec 2021 17:31:45 +0800
 Subject: [PATCH] policy/modules/system/logging: make syslogd_runtime_t MLS
@@ -31,10 +31,10 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 2 insertions(+)
 
 diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
-index 7ef69524c..87b4779ff 100644
+index 1ee634f76..75c97645a 100644
 --- a/policy/modules/system/logging.te
 +++ b/policy/modules/system/logging.te
-@@ -463,6 +463,8 @@ allow syslogd_t syslogd_runtime_t:file map;
+@@ -459,6 +459,8 @@ allow syslogd_t syslogd_runtime_t:file map;
  manage_files_pattern(syslogd_t, syslogd_runtime_t, syslogd_runtime_t)
  files_runtime_filetrans(syslogd_t, syslogd_runtime_t, file)
  
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 014714c..d241343 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -48,32 +48,31 @@ SRC_URI += " \
         file://0030-policy-modules-system-logging-fix-auditd-startup-fai.patch \
         file://0031-policy-modules-kernel-terminal-don-t-audit-tty_devic.patch \
         file://0032-policy-modules-system-systemd-enable-support-for-sys.patch \
-        file://0033-policy-modules-system-logging-allow-systemd-tmpfiles.patch \
-        file://0034-policy-modules-system-systemd-systemd-user-fixes.patch \
-        file://0035-policy-modules-system-logging-grant-getpcap-capabili.patch \
-        file://0036-policy-modules-system-allow-services-to-read-tmpfs-u.patch \
-        file://0037-policy-modules-kernel-domain-allow-all-domains-to-co.patch \
-        file://0038-systemd-allow-systemd-logind-to-inherit-fds.patch \
-        file://0039-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch \
-        file://0040-systemd-fix-for-systemd-networkd-and-systemd-rfkill.patch \
-        file://0041-systemd-allow-domain-used-for-login-program-to-conne.patch \
-        file://0042-systemd-add-rules-for-systemd-ssh-issue.patch \
-        file://0043-policy-modules-system-mount-make-mount_t-domain-MLS-.patch \
-        file://0044-policy-modules-roles-sysadm-MLS-sysadm-rw-to-clearan.patch \
-        file://0045-policy-modules-services-rpc-make-nfsd_t-domain-MLS-t.patch \
-        file://0046-policy-modules-admin-dmesg-make-dmesg_t-MLS-trusted-.patch \
-        file://0047-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch \
-        file://0048-policy-modules-system-init-make-init_t-MLS-trusted-f.patch \
-        file://0049-policy-modules-system-systemd-make-systemd-tmpfiles_.patch \
-        file://0050-policy-modules-system-systemd-systemd-make-systemd_-.patch \
-        file://0051-policy-modules-system-logging-add-the-syslogd_t-to-t.patch \
-        file://0052-policy-modules-system-init-make-init_t-MLS-trusted-f.patch \
-        file://0053-policy-modules-system-init-all-init_t-to-read-any-le.patch \
-        file://0054-policy-modules-system-logging-allow-auditd_t-to-writ.patch \
-        file://0055-policy-modules-kernel-kernel-make-kernel_t-MLS-trust.patch \
-        file://0056-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
-        file://0057-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
-        file://0058-policy-modules-system-logging-make-syslogd_runtime_t.patch \
+        file://0033-policy-modules-system-systemd-systemd-user-fixes.patch \
+        file://0034-policy-modules-system-logging-grant-getpcap-capabili.patch \
+        file://0035-policy-modules-system-allow-services-to-read-tmpfs-u.patch \
+        file://0036-policy-modules-kernel-domain-allow-all-domains-to-co.patch \
+        file://0037-systemd-allow-systemd-logind-to-inherit-fds.patch \
+        file://0038-systemd-allow-systemd-tmpfiles-to-read-bin_t-symlink.patch \
+        file://0039-systemd-fix-for-systemd-networkd-and-systemd-rfkill.patch \
+        file://0040-systemd-allow-domain-used-for-login-program-to-conne.patch \
+        file://0041-systemd-add-rules-for-systemd-ssh-issue.patch \
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
 
 S = "${UNPACKDIR}/refpolicy"
diff --git a/recipes-security/refpolicy/refpolicy_git.inc b/recipes-security/refpolicy/refpolicy_git.inc
index 28cc4a3..4d207a2 100644
--- a/recipes-security/refpolicy/refpolicy_git.inc
+++ b/recipes-security/refpolicy/refpolicy_git.inc
@@ -1,8 +1,8 @@
-PV = "2.20260312+git"
+PV = "2.20260616+git"
 
 SRC_URI = "git://github.com/SELinuxProject/refpolicy.git;protocol=https;branch=main;name=refpolicy;destsuffix=refpolicy"
 
-SRCREV_refpolicy = "fbae939176fed7163730506878d92d3b1da433e4"
+SRCREV_refpolicy = "30d3cf5abd1872d3da5dd44de37de4251674f736"
 
 UPSTREAM_CHECK_GITTAGREGEX = "RELEASE_(?P<pver>\d+_\d+)"
 
-- 
2.34.1


