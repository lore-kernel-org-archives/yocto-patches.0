Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710F9E77180
	for <webhook@archiver.kernel.org>; Tue, 10 Dec 2024 13:13:29 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.9946.1733836399732241053
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Dec 2024 05:13:19 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=20745f6cf3=yi.zhao@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA6KQCo008981;
	Tue, 10 Dec 2024 05:13:18 -0800
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cwy1trsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 05:13:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nh+o1IZ0dpysqRy62Pn3wT27v8d+WV9uTlurU5pZFGcegc9Zj/+nY77YJH16D/sDwNQUXZxYpB1gVig9eaKl67s/eKclOQ7ihyO9nPmXYVhfkZhUbG98MCxOUCHtuAuWkN9Dk5ZfbnTBtmtyDOqmjV3TJs/8e92DRsGJf8TdRsu8nkBcw7rNViZGRp+BSNTOdl/w03AqShfUtsbsJUZqbW0DfTsTO0YNY1c/nAZJhGSVl8a+PKk2eofrQZBwwCboMX5TbFPQJfY8puU8cbP4VODoeJDYmejNCCTHXhh4udNrnQ9RJMbkLpEsi5g+RnNNn6i4a94NzQtOsI0fIRQ59A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tx7JQRy/QKCJobl0W+mlfF5OVIwBzBwWOIymEwoPOE8=;
 b=Gyj/aUNwcwm++Or0tKUzLZh5OiTtiiPDb30qj+SHtcIGBMZFbPRpuAFUOKSqJHnmdDdnPOrr9KCvx7R0/UnwSDYpHRyXZ0Z1TFI2NF0B1SyWHOD04QjQML3WsNmLWJZXIn1nyH+3bOpu5bktXxK5hgydiWbhzhG/SdXWgtrSsWkw3m3dZM/C7WMlAgx12XZ8InpZrqdk+m/BEZ4Z6sq+gbG0qvqYKoX5s+Y3r7bvjcUS6IMKUehSx1u8romK5ufp/c6IfP+JMFENiP449CPSolZazoMVz8kPFiv3Zc6qS/m6xwXVPOJumYETdPPXSEncQAElFeS85qIr+OiRUjWN4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 PH0PR11MB7586.namprd11.prod.outlook.com (2603:10b6:510:26e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Tue, 10 Dec
 2024 13:13:15 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%7]) with mapi id 15.20.8207.017; Tue, 10 Dec 2024
 13:13:14 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org, joe@deserted.net,
        joe.macdonald@siemens.com
Subject: [meta-selinux][PATCH 1/4] libpam: drop packageconfig for selinux
Date: Tue, 10 Dec 2024 21:12:53 +0800
Message-Id: <20241210131256.2393366-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::18)
 To DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|PH0PR11MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb214d3-c686-4c25-12cf-08dd191c678d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?8gLv38lnNqgdCtjzOBESk6V2qoP4/aXr3qVVT3hBUiEFVz2YiNEFSRFr3pHM?=
 =?us-ascii?Q?WLjdVGxYgKKHlQoxb4zFYmZVAtVq1mu3I6vRRxxa0rRVujA4K3VrdTBYmhiA?=
 =?us-ascii?Q?Lt8S0AYz9il/fS+HcgD3Cc2rQOUIqmynRfTY9TCj7eDYWitaUz1IIvbG+Ywt?=
 =?us-ascii?Q?UGRaKgFrsdtzKe0Ue7IAo33FRZkiQqQzsELWkN/lclOAF1c1YVqKjK7+hcj0?=
 =?us-ascii?Q?UYfjRZhuKdK3EZDCdljoQ6HIT/iUnQA28m899iJihQLcpnSz/btKu2gjvbeG?=
 =?us-ascii?Q?FnUpaMCCEy0m5iATQTF0TrS63myanucb9jeHYZUkE4y3Z8jcV4dViUukx57+?=
 =?us-ascii?Q?RxQ0IMvGyDb7gM6bSfgqGdqYryWcioITR/kJ00/YSkHgOIRtyo7yh8H7jP1h?=
 =?us-ascii?Q?IGI7tAni6Dhy4oWu9L5n6h+vNnIqMD13yz1+QzoBOLUIJUFZRUnR4PT45yxH?=
 =?us-ascii?Q?tF24LiYG/w5OLRSVjQu79sSXIvulvD1x6l1xHHdpzsJ9dyljbM+60D6Pp6W8?=
 =?us-ascii?Q?zXXMSolJpn4c1oe1ohhBKS6EH1H86t5vauOd1JbQLI9eKYfAskktMHeGYWsY?=
 =?us-ascii?Q?Tfo7i1EoeDXeanS8v5q4T8QljP+QRz/sYSLRV9fYbDf/ijhEhDLGKSm1/O6U?=
 =?us-ascii?Q?TerJTOvjIIloLr8aKhajG4A/bCu/1dALBg/7hzPejr7g2/oQz2fSl7sMBRlQ?=
 =?us-ascii?Q?SpV4dOIgzjpuwUNxaoyeoOcww1Ge8MGtHd6ykKsNwBsrGvYqlMNgeoZMVdL0?=
 =?us-ascii?Q?1lVlIi43ZJSnnboMKo5e56BiqWAQWkKZfSngO8QTPLfnH/ARrb6XjEECxiKc?=
 =?us-ascii?Q?J9YGG+hy5qNPsR7QDFuYyniYaXBK2B1uQBx9oKpnW3arPM3P3rMBjiXHeQXC?=
 =?us-ascii?Q?3krJFZAB26+zSwt+XrB0rsHdimaaOSWRun+KliXl9a3nDkY8qUggcew4NLru?=
 =?us-ascii?Q?SWqWGuKRVqkX6L5n+axOwT/yNguZj810c66dXjtQ31xFqL52OIESvn682gr6?=
 =?us-ascii?Q?uzxDPhwTQT5hRFZ1ej6hknUMucpotsDx4M5FzZJHUJ6N9emZR0tbd3YIQmtG?=
 =?us-ascii?Q?2iUuvO5/6MlmVzAw6uDrbFG6+F6OSDPrv00n9IIvPxhX55bjFvtNmsfdSajI?=
 =?us-ascii?Q?TKJyvGnym17P0HMvqek2sza2q0CZ+JWSFj1kq2GUTlDK+SYo3Y8bqIDVrCri?=
 =?us-ascii?Q?sCzDucVMrg/hbMUMeXUL6J37EYRkAQfxSOuTWj7PKV/7Myc0tFdBhHM2CjXM?=
 =?us-ascii?Q?A2MJqbSeyjnDddzYp1EM0o56lYHgdB/RPqni5J5n7pYMj+pig9bv0nKR46V4?=
 =?us-ascii?Q?Lru7RyxgY4xDm1cvCvI1NCKPrdkDJVoYSR/FuUijgTY6A1XQe1EhTVPDVtZW?=
 =?us-ascii?Q?LmsjmMgjcb4fBmgKh1E4w0G8V7O8KMaJzI5yXOIF8+wgeV3CTQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?F61Q20P+LYNnbfDfKEpIsS8BZaZOnKDo96UsaMnhWiN6epC3ay9Pwl8b990/?=
 =?us-ascii?Q?3QY4a2OaTAzUwJzvcbmIfqHW6GoD+P1IqiWb8TMxP3w+HLHn9B2MCCH1PQfV?=
 =?us-ascii?Q?34oNnabDBkY2vn7Eqz2xDhBfhOuHORAhkMK7RtOFbEYC36X8pNrYSiwN8a3R?=
 =?us-ascii?Q?WHCkP9ZeZiM3bBSqrBVOE3LpcmwgzbIHOHNhUdW8nCUEsyS9DDrWvSEHfISh?=
 =?us-ascii?Q?wlFcHDMmULqOMSwCHSGsm4sfQkv15qT7NbHywuOTW1EOxaRDmwOTuYKCmJ9g?=
 =?us-ascii?Q?83th/90LjpfGOcYHoAam4sT9PbjtOkrDhXrLZfIC/KAefR4W7xQvIsssAxU/?=
 =?us-ascii?Q?y0NWhCsqsfH/fMCF8K6yPFRdZhVap+HZitWtp9ynNpJbWFKU+1afjuY764lk?=
 =?us-ascii?Q?1YNl50nV0qdhASro1cv0YwiMjwTSczGAvF3Ndm+H4In8/ly4rMRI25orDO1x?=
 =?us-ascii?Q?MNAEJSJTLgF5a2AJORL+FeBVxNLVVlaAJHOINR8GH3WeHmDIrgO+iBXH36a3?=
 =?us-ascii?Q?/uEI3r+fR7KrAY1LMny8I/S03spVa6z4bA+of6hJNTkKImCWrWrMQrnQplVE?=
 =?us-ascii?Q?UlcvpRtq4Usdk4/VqO+WsQzXMF8vWkMi/N72eCF8VRh3v5GNV/uWm8uR0tTy?=
 =?us-ascii?Q?pXGCLw5XiT7n203KfF296VUBUvTnpjZ4e7XE3chApe5hSsYpoK0VeUX/ns10?=
 =?us-ascii?Q?TPqKr+cFscuY3qkrFUP0DfFRMRtnCQzrJPOSnyHUp4nvt3+FAlcp9g4vG70/?=
 =?us-ascii?Q?SL6VpWE52EcPxeCm73rNWv54Q2QCVx8CrfZkYxrKhW1QnLPw/szOUKFefv6I?=
 =?us-ascii?Q?lMKgrMQVmfsnVBv+jMExfzgyYvjzEU6PXMhP5kQmdZm6w17vmUGXDiEGNM1v?=
 =?us-ascii?Q?rW2neRvygxPlyJLXUYTgT3UxXv6gXFawdetGZP9wMzUCGT9cv4vVcBOUDh75?=
 =?us-ascii?Q?b1h3tRZlCO6wXd3SyxOv/Fe4IBv/dAe7U9gq7VWUIKhM6GbNUcCgkrsnr0Zs?=
 =?us-ascii?Q?ZXuYWl6KNlFVM45e2DE4X56E1hYEqZiA6JEtNK3/xY9iX15RZQePjI8lEgkk?=
 =?us-ascii?Q?J1y6H1NzcZ7I/Nct+zkNrq+4S1lRtKeQYhmmBrbA4+uDYg+xDMbO+sRB0blA?=
 =?us-ascii?Q?jGGF+P4r2CF6rDPXyZz283ttYotTw82pfcxijIfSNcZ0TaA7ze6vtMrEibTu?=
 =?us-ascii?Q?9bzMEoHidePyTxTSI0lHDKfrlCP3h3m49AsNaXkeqKRxKb6k2/7ItveKSUcd?=
 =?us-ascii?Q?kFoDoemPwwyUsY25l3ngo7XpKpTKmFv7BzNDCByqfid+jWBO2T8UBjDCsZV3?=
 =?us-ascii?Q?SILKuHHlfMhO+FwMVbQqmKGndostpLKgfW/CDDPhJVn9sPHNo6E1BcVrVNHd?=
 =?us-ascii?Q?Bglj1kItDNWdQ1LCF4v20v5u1GIEx5VphtKDtzaq5i3kbi+KwV75QwaKiIJ9?=
 =?us-ascii?Q?mleMAoXuWElmxfgPUDUVyAUtxwK6i4ZB6vzKZ/+0LLptoZw1eQfJ5zAzlRpA?=
 =?us-ascii?Q?jBBPD+6VYwCbZWsER1wNX0bYqQ+hSXjqrzgP6dI20hJIUUdN8g6/yVILYSuV?=
 =?us-ascii?Q?PwJjEFc68JmcWlEzIDGCft7v8+bv9H0n+pVwyxxV?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb214d3-c686-4c25-12cf-08dd191c678d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 13:13:14.7190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cw5FGI+mqjVPkerS585qronv3mmPYDibSx5VWJ4YausObhF5gp7rqBlvmS0g5TKuDHznv2XKe5VBVMfsnAN0lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7586
X-Proofpoint-ORIG-GUID: 3qiXdXnKLFInPre7mMyLR28KAUI0VXBh
X-Authority-Analysis: v=2.4 cv=eePHf6EH c=1 sm=1 tr=0 ts=67583e6e cx=c_pps a=coA4Samo6CBVwaisclppwQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10 a=Q4-j1AaZAAAA:8
 a=t7CeM3EgAAAA:8 a=v6201HjlzFfrNr6R1u4A:9 a=9H3Qd4_ONW2Ztcrla5EB:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 3qiXdXnKLFInPre7mMyLR28KAUI0VXBh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_06,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=744 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412100098
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Dec 2024 13:13:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/877

Remove PACKAGECONFIG[selinux] as it has been added to libpam recipe in
oe-core[1] and updated for meson.

[1] https://git.openembedded.org/openembedded-core/commit/?id=15d0cb7c4b1278e869f440f949f5e9af2d305429

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 recipes-extended/pam/libpam_selinux.inc | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/recipes-extended/pam/libpam_selinux.inc b/recipes-extended/pam/libpam_selinux.inc
index 2f8b945..8c11cac 100644
--- a/recipes-extended/pam/libpam_selinux.inc
+++ b/recipes-extended/pam/libpam_selinux.inc
@@ -1,4 +1 @@
 inherit enable-selinux
-
-PACKAGECONFIG[selinux] = "--enable-selinux,--disable-selinux,libselinux"
-RDEPENDS:${PN}-runtime += "${@target_selinux(d, 'pam-plugin-selinux')}"
-- 
2.25.1


