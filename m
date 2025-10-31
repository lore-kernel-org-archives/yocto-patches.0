Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B21CCF9EE
	for <webhook@archiver.kernel.org>; Fri, 31 Oct 2025 08:05:16 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.10105.1761897906709290973
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Oct 2025 01:05:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=R/l9SMH4;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=33993df286=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V5Mevb2452710;
	Fri, 31 Oct 2025 01:05:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=lRoktwERE
	afQ8leAubOQy+qZ0LPBJwAkXC3wirRWYts=; b=R/l9SMH4avtfrplexK71tG4IG
	BVZxZV+4M3M7iMTR3vXwtKd6mmb4DPZvfRCLGXkwpMTazPyibeLCbftJspGaNjhT
	BXmcUXgmeTkgtAJfmjNVXO7Zz4X+ahNp/hMSCg+GKJbik1a0lqTCNIjOQ4EARA5X
	t0/DRKBJnZEHIJSaOtSXOEbpUiSGQa6KX9+JJQgBVX5QivkN020UgBTJXE1HTlOQ
	kQAJPoUtC0b7vaHF4WKCD0hBAmg/CH0h+xZXS5Pt/yzAJt9gVQ6PnBsWTdDKUq6x
	vS+reBGFN7sKlyNgKNtx9bYZw1VGSCm7geXxBvdsqFKlrD4Qbia5+ILaY8qmg==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012016.outbound.protection.outlook.com [52.101.48.16])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4a3wa1sngq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 01:05:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+cDFHPki8AakztSNVW7mrpNJEDST40LtzyRwNNFYMSjN3b6SDBCx4pB1N10ZAGEaxNY8wWciFQpxRYmtk2DC0NWYltuPt4KjMZ5xEypGzbjMtvxfyEYiEhuxhs5JqTaZ1GDUn2tU1fPBksqym6qjNTGFgJ3Ef3qbq4txgc9OxQV1Tom10GP+EJGWm4MijLO/YysFG+JQWc0qXmvVAEIvjotlVS7i0JzPGbQ2EWRm1FW0X3PHXMzqSVOfHQeXooKOrGlnxg0Ju6Ck6tb33APi//T8JMPH2ZuCt1PkIDi/yQvruChSxKPMTtX8JcshCD+ZUTfA2ohI3c9zleRHrn2aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRoktwEREafQ8leAubOQy+qZ0LPBJwAkXC3wirRWYts=;
 b=Gg4KZXqETTM5DCTelC7nbXvr1yINaczGIo2Tu4fCjq/qS+VpOhlbZ2ZhPS6NI6UTDqNS+fQqpsTKcOCkk2YIKm8jF71reXefAoGctKUP8UMZj+mr2BZpwR7fACOnXgkmcL7GZGC+X5Kb3GNeI5girl0AUc6ibDHiBkMEKAkNn6ucaONLEf/SVlGcKeOSrAhc2XoAI8Z7rUf8Ysf04ChIVAHuEY/SiEHZKSYDbJ/cenEnxA6YujF849nqEBUuo6gUxAZui+ESNfR26CKWrC5Ls28m187QA5huC4X2bhiYiAntWn+BEy/mBuzj6pTJSPqcygDP+52DKczEbA3BREQ13g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by SA1PR11MB8326.namprd11.prod.outlook.com (2603:10b6:806:379::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 08:05:03 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 08:05:02 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com, qi.chen@windriver.com
Subject: [meta-mingw][PATCH] meta-mingw: support generating Windows SDK with no symlink
Date: Fri, 31 Oct 2025 16:04:47 +0800
Message-Id: <20251031080447.2751414-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|SA1PR11MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 4126f199-3304-4818-4dcf-08de185431ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?06hrZVxzzM3IB4kcuaCnGThEHp2vGr48FHiZVTOYr5dLtEgBf69pAbvpwi8q?=
 =?us-ascii?Q?e+O/C75ORmP625IFET2JqgA6+MNXpLBP011WHxgwhuj6QyAZT3VjbYc4keoa?=
 =?us-ascii?Q?yp6e1fKr3Eeyz2SNMrF1rnl/tvLFfTyzkTFPRehk1UJy5pCv4sOlBYWDoKrj?=
 =?us-ascii?Q?sW2ptHsQZPyqC4iyd2QNj9bVusueROf8RdbNyyNbSArCl2GrJGZBrSmtDJAL?=
 =?us-ascii?Q?+euSyhcz0JRBQErrNq1mhjWWkesiWG8N6Plh8tfsRLLKx4xLPY9huO81GH9Q?=
 =?us-ascii?Q?l/IotaOyLyu6V3nUD7jQJrgu99U6+6mdzqsRDLeoictX6hrawcWS3aci9tAa?=
 =?us-ascii?Q?gT/8SWufE/FrC2fG5p8PNz7nuS5VuJdEV/Rczf6K89vqD8ZyW4+xmHeNAdzI?=
 =?us-ascii?Q?dKeoq1tAZ4EBFdlg5vu+i/ICSbECWt7FOnxx87G6jv2g3JDImz/PO3WlxYq4?=
 =?us-ascii?Q?qmHjZUykTCyuhugXti2mPu1ZlSqDNM6KsHbVdtAq6UPmIPRgWPF06ykwfz4y?=
 =?us-ascii?Q?kQjN5e7YugzBm1DRxxW+SU8pwuWYAMwbXyEUAvjacdD/VWMOhGjTEa+6rytt?=
 =?us-ascii?Q?fXqNUjGgryCbT+WkpHSamvBX3351SVj/6ajHNfaG5KyxMDuzyF78JNu/JtSp?=
 =?us-ascii?Q?9Jherr6n1liH611EdVml58y35dpggBrwvwQFPLc1Fhcr0c88dZ3xXQHPIuJK?=
 =?us-ascii?Q?j0ZL2LITmqwQE4m5IvvdYxN995qstSgI1iEiFThnoKJtJAqhoaINHspd46iK?=
 =?us-ascii?Q?ZK9htg3Zla1J77XI+6aj3T8W9WZfkbWAUXuHOpjvA21L1wd3POb95KVHFweq?=
 =?us-ascii?Q?UUsrljeA952eEF90Dw55Dbp5Y/43ACL3rxq3yTn36EZ9PhkBbFSTxZDaGCcL?=
 =?us-ascii?Q?q5AMqT4dMqemMvrs4Pntl8Ka9W6mVepLuEqk0mz/r23u481vAi/df+QFDrwD?=
 =?us-ascii?Q?+G9iRZDfL90qJMTpHyZY8COKkADQx5k/QK0t6xq7rJPJe1kZ5/0I7RQD9Zru?=
 =?us-ascii?Q?DdHgggjvhw3a7QQJOQQjjhcsl91DO4GSqtRFH+dXT8tZlLzQwEXO4+kLfmJh?=
 =?us-ascii?Q?UXiVXjGu/f8HYrVgjGIRld1YODeupEoj848kISTtY1k96ijjuxfsp7Axsjrx?=
 =?us-ascii?Q?XT0//79Dw+nnFwZE2bX2YC8x/WczI2WsXhQCWtTmbXj6G9TpDmpw4QVszEoQ?=
 =?us-ascii?Q?IZ+rhSXg8LuRtH6OutEoH275h/WLIbW0YnIKmnDaV9kqD4PXRtOi1XxoZvK9?=
 =?us-ascii?Q?ewoj38e5Pwvt1edkqDieXnLVsCWeZtLtsL52l4cMEBoMhhEngfbALOe6jXQz?=
 =?us-ascii?Q?VG4icVcHCo97pqA4CTG9h4/OnMxIdX/T40gbZSoE09g3PpjHAxz3aHp3AU6G?=
 =?us-ascii?Q?3SpQveSdiPyVm7vkOZHE6vd3UYN4NbUAzxxRevjgbh4kTC+OwRsolLGoAd2T?=
 =?us-ascii?Q?FmgZIwJKLDL2I9wY6hKpF6COgFoWuclcdOZ6hKVNcPmLb1xo3sTatnVaM3Ed?=
 =?us-ascii?Q?pq3OfGQTm4huDpAYtvRCF91X6iqGkU7UZdAJ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ON5hQMz1Ri9F1QLn8Z/Sx7RJemoa/RrcFF7iIGJBZ2aa373DU3BAfSLDX+RM?=
 =?us-ascii?Q?Oac+KtMrqPQgs8fIcqow71C/G26YFPqVcF2l7GJqURuO0LoM+YpO3VokfUjP?=
 =?us-ascii?Q?q1MVLyCJYqzGP37pwDikbQ5DLxGr7G+a+bLJEE/fWwII1SQhOQdiuoyaAiF8?=
 =?us-ascii?Q?Jedq8SpHt3ZQ84Ha0oGqN2NiMtQDJ3pv9vNYcnWkKj09iEOhD09g4e9s/OJ9?=
 =?us-ascii?Q?Z++j4MSAf3JCaCVnmGqaEGJY9U2I06CIFMyKAd5ZqClrWoBmikPCJD2jCRZR?=
 =?us-ascii?Q?Lj39RlK2rEm4KXLjTVw71i54Jy6MEKG2e5o2nfK09W8Bi9FArYHtFBs1/Wda?=
 =?us-ascii?Q?GND7DOVUDh6XLI55fahGifIHQaNPUUxuIUoTtgVSmISMBBFg4YjM3wISzSeL?=
 =?us-ascii?Q?++kHhLh5djztBI+JKonfJUrxfDIX9NW2B71cJ8c4fs3lpEGMvoeqi5m/NxDT?=
 =?us-ascii?Q?gh3drXUGORtipul+M3bDxKzuqv42KAfwv2EhVWtmq9XAQER6bGAR3ykbHIzA?=
 =?us-ascii?Q?sy38AbnXtzz6fsopSreCFRyxofHZ52eY+i/WxbdJexw063U1aoz7Tmseilh0?=
 =?us-ascii?Q?EH6/UVAUS0b2TaYsTl/4Cr4uiXTHrLOC+YifW3nZ82WjerQ4ylQ8fiKaZLsC?=
 =?us-ascii?Q?gEUp+UqOytAPN1q08LnhzLxsEnFXiD+kl0n1PnzKIfgY4sKWn5MIlTgWRuLb?=
 =?us-ascii?Q?p4v9iuLODfxXcxKpXge7pIxmTqKEvjomQKL1VdcExZwoRXgRyAzJEHWWjAlP?=
 =?us-ascii?Q?RaGjcRUIHYKI1mP1+0ysJ+HFf/yNAUuiK2i7FTk0JTDVMbmQSNEJ2zByWsvc?=
 =?us-ascii?Q?x6TbmlHXg14fiHZwutWG/wRDU5a1jx5vCb0TNdPvS7586WjbNxvGtUDTj8Ls?=
 =?us-ascii?Q?qlOoeS6EsTagqpUEc9iX/qJBk38Eg9WwXk54FbNLkZGRUHKbe62+uwo3UB2H?=
 =?us-ascii?Q?jZAMEU2U9L+VX4UYa2OTQtb7j/npFGR4BCvG9mByHnpwBOPuxGv4YZsONCjJ?=
 =?us-ascii?Q?rWPEGKjsUR5YzBbX6yO9qAw3fvn1dyhiaw6edrMxYfcOKmAcIuFSo7cY2xu1?=
 =?us-ascii?Q?bDW4CoL60yu+C3jSXXSj7buol8NbADMjUde0R/AzkRnHYGSjERhI8ygAw5Qq?=
 =?us-ascii?Q?yIu/NyCUMC33ZMwmtMNKsex8vR1/2T6SCjnzGTgxQHNxGEggU2KfUzmv8IYk?=
 =?us-ascii?Q?1fzlCHVyZ4gZ4mXMwgMLXtUzznmMmbNfk4thWnKvPDFzpSRLVm3/hVbc5i5f?=
 =?us-ascii?Q?tQLrqpkzEPFF1xagHm+4Wm33cK7jHUKZ6seDhhWnvDmGPdnD19ax1QILH3v/?=
 =?us-ascii?Q?PKeDj/WTFNBOHpy1pGrwwG71THz8Dl+gQtLlBOjQsse/j5OqByNH6eWpDRnd?=
 =?us-ascii?Q?f64EyXbLWf/mSUte+N+28V2O/VHiNY611ySM4cgxBffXOSwfnofTgla1rBUK?=
 =?us-ascii?Q?Ohy4jvYRddNeRhRnsJZ8WxS5zbqNx0AiyPkezK4wlNcdfEZj8h0G8z5jJY5z?=
 =?us-ascii?Q?wVwZJ32/LzukLbmSicCUb3rCp/ZHx1m565NqhkNzN7rBlSIN3KSRFBv78mbo?=
 =?us-ascii?Q?8vWafJnd6NBo5G4tXtWpT0Ov+vzZkNrLz1cfPaKU?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4126f199-3304-4818-4dcf-08de185431ef
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 08:05:02.9151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MCSzjmITlqyEPuboj6e1aO3U/WbmWMTvdjDf7QIsxwzRpfmuFO2xDGGi0HihnV/juEeP+q+7pJDDfx4Lfua9vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8326
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA3MiBTYWx0ZWRfXydwriDuxaeVI
 aLLnXNRHuCSigFLh3B75JLEBRRFhEhUt0nNzQcuRGqjuA0YHqfp5rtiuM226KdEgQDlpHV+1Qm3
 FOuVR7HG9tcDTdK4jA28Z+Z1mGT0EntUXzWip2tvgKk/F00pp61z257VFxrYIWd7QOhgMpSsaIh
 miwwvYFVPPE3gxS24VajCoMRRUzgK1omkXV1Zz1BUSYD3LC6+vTIbLnwLLqL3M6inHEk/27FRaP
 x6awEEps+D/HPYPy5xLjPjyx9n/XcKQ7tkIczSlfopimeOJ1CnvzUPDBVf55gRZMbLPlmD6sWMJ
 19kDKyMEzWq3Q+qUNmMARDY/+wx5R4yZPqGgwBueToap7UfuT/XykTRTWS7864dcM/4unBQMteW
 U2lr7XQtyfyZt04HIKzt432mdiLj0w==
X-Authority-Analysis: v=2.4 cv=HODO14tv c=1 sm=1 tr=0 ts=69046db0 cx=c_pps
 a=V6LhDW2JNEJwPIi/f6b7qA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=LtwcJJPwdmsIudEpcK8A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 108rV-Fq9v-T2QnKlA2pVBZEKhCssjqA
X-Proofpoint-ORIG-GUID: 108rV-Fq9v-T2QnKlA2pVBZEKhCssjqA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1011 spamscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310072
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Oct 2025 08:05:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2405

From: Chen Qi <Qi.Chen@windriver.com>

On some Windows systems, symlinks are now allowed due to IT policy.
We need to be able to generate Windows SDK without symlinks.

To do this, a new variable, WINSDK_NO_SYMLINK, and a new bbclass,
mingw_sdk_handle_symlink.bbclass, are introduced to achieve this.

By default, things work as before; when setting WINSDK_NO_SYMLINK
to "1", SDK will replace all symlinks with the actual contents.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 classes/mingw_sdk_handle_symlink.bbclass    | 25 +++++++++++++++++++++
 conf/machine-sdk/include/mingw32-common.inc |  3 +++
 2 files changed, 28 insertions(+)
 create mode 100644 classes/mingw_sdk_handle_symlink.bbclass

diff --git a/classes/mingw_sdk_handle_symlink.bbclass b/classes/mingw_sdk_handle_symlink.bbclass
new file mode 100644
index 0000000..2f6dbe6
--- /dev/null
+++ b/classes/mingw_sdk_handle_symlink.bbclass
@@ -0,0 +1,25 @@
+WINSDK_NO_SYMLINK ?= "0"
+
+archive_sdk:prepend:sdkmingw32 () {
+	if [ "${WINSDK_NO_SYMLINK}" = "1" ]; then
+		for parse_type in "file" "directory"; do
+			find "${SDK_OUTPUT}/${SDKPATH}" -type l -print0 | while IFS= read -r -d '' symlink; do
+				target=$(readlink -f "$symlink" || echo "NOTVALID")
+				if [ "$target" = "NOTVALID" ]; then
+					continue
+				fi
+				if [ ! -e "$target" ]; then
+					continue
+				elif [ -d "$target" ]; then
+					if [ "$parse_type" = "directory" ]; then
+						rm "$symlink" && cp -r "$target" "$symlink"
+					fi
+				else
+					if [ "$parse_type" = "file" ]; then
+						rm "$symlink" && cp "$target" "$symlink"
+					fi
+				fi
+			done
+		done
+	fi
+}
diff --git a/conf/machine-sdk/include/mingw32-common.inc b/conf/machine-sdk/include/mingw32-common.inc
index 56b8052..bf3f14e 100644
--- a/conf/machine-sdk/include/mingw32-common.inc
+++ b/conf/machine-sdk/include/mingw32-common.inc
@@ -59,3 +59,6 @@ GCCPIE:mingw32 = ""
 
 # wine and wineserver are required to test MinGW SDKs
 HOSTTOOLS_NONFATAL += "wine wineserver"
+
+# handle symlinks
+INHERIT += "mingw_sdk_handle_symlink"
-- 
2.34.1


