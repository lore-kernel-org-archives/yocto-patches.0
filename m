Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87ED4C27C4F
	for <webhook@archiver.kernel.org>; Sat, 29 Jun 2024 13:37:00 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.6023.1719668216025852728
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 29 Jun 2024 06:36:56 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=791001afd4=yi.zhao@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45TCoTYd013097;
	Sat, 29 Jun 2024 13:36:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4027fx8csc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 13:36:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlZ0wrAVs4fgSx8yAn3mU4OHUHy4L4Slv5vP0MHE8mgD6Yw0a4P/x3Se0fSyyE82Z9XpyJU71hiWBonqzMu9laoe6lGpnSkOEd6hNRBGHfN4vbtPtZYrOlYeR3EINqBiG7KlSLKlKfDy/kiXj0G4N8faWJ+Nu+1vJ85knbHAqrfA4t0PPH+rKVm1fXKLfDNq1TGADzfQshCGAZE0T11k0IXbFAFjPnfUzTy8cY88MUVPg/KyJ5n7u6a7/IL1TmEDPHg4dMF6IVgwEkWjsJ7JU2tXKzWkM3IXbYViV+7gZseLuaz1jCcOILlsrJeEMFKA19JJUsUEoCSPxsL0M9Gwcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEhdXqn9QAbDrQ2MWb2Tn9SxAzfhG5Q65vJlf6S+P5A=;
 b=inisxLsTSmcqZHYQKTAle5PSVRI3BZmU8LzWbYvdZrc1Jc3hYFwRvWmWeL4f0Uf4GBHU7W3u3cHFtL5MnsBsunvWv9RhiauSRqeuLZ3Sc0l2whykWxFnb48GJ7165xiLfvzpIUgqAWbeUl2uU6+RO9mB+GWC0QXVvdafdY0JjyVFGkpYjOiRfHiUOTdr3uSmmZZKLIJPscJ1t8rMG4qKzOhtrqKGgZL5I8KJOkHQFesHWAGrLR6lsdCWeP9kChxriBoq1oAKLNO7ArIvq6d8UCh9QO4mz9ZV0x5s7dFUm/TZLcXB1lfk5Os42Op300AMt7KPX9CoAsxbvUxdschv4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 DM4PR11MB7207.namprd11.prod.outlook.com (2603:10b6:8:111::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.26; Sat, 29 Jun 2024 13:36:53 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.7698.033; Sat, 29 Jun 2024
 13:36:53 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org, joe@deserted.net
Subject: [meta-selinux][PATCH 2/2] setools: upgrade 4.4.4 -> 4.5.1
Date: Sat, 29 Jun 2024 21:36:40 +0800
Message-Id: <20240629133640.2377943-2-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240629133640.2377943-1-yi.zhao@windriver.com>
References: <20240629133640.2377943-1-yi.zhao@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|DM4PR11MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c72f68f-9960-413c-9950-08dc9840897a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?BFPKX5Wkipt+3/MD0Q7PnhVeaRdRoMvsXevqkbyEwWhkZ7XWctkx4DTgplS8?=
 =?us-ascii?Q?Gq8KGD9ZWlrlgjRAkhfHobZLnzkA6GBBFnLCRIkLNh1AH6mjJlBYGXB3Vb5M?=
 =?us-ascii?Q?Ufz9nVk4qsne9YWS20vU+C2k915r0m/W8ytKJBNfAv6Owkfp6H4wFHI/R1Mq?=
 =?us-ascii?Q?puv/YIqPcA6u6CQOH5yu8qrn3yBGqmVQGAGM+kYmQR8zMXlaEe4t/jqQT+sp?=
 =?us-ascii?Q?Snr6AE6kEuj1F3BtijT9IxRrVBKabJAISnKDHxIEJCfcj+KpYCzfsXQTCq3g?=
 =?us-ascii?Q?Nouvj7Yfd6piPZo6nmrEKdjoBXREiROzDwddoAxHT8nGvaSNwHyeZbaiNnBD?=
 =?us-ascii?Q?Ee4CJZ35T+LMxkzDnX4wIcoYluRYM+8oR5VO5WUobBs+2j64nc8U7uev1Wn0?=
 =?us-ascii?Q?X5gKrCh9qm+3Lu2WWtAWS8yYju+EWls/qeXHlOD3/KZKfgDwggQJmCE4DjXw?=
 =?us-ascii?Q?e7O1/9bTkmfYNSk8JQDAKPk4gnp28lDrTD6Zw0p9Nic0jGOnSHuyvNsaGyJK?=
 =?us-ascii?Q?jo4LMLxqqtHVKH9irsuWhloZc9qQ62gBuHEJx+oBhxgEb7DQ6XQqc2oDKqEs?=
 =?us-ascii?Q?kDlS/9x9np7/tUEbOkxhf8Tnn5X5ungW/leEYh6iVZPuSBKoJuv+Tsl/puH+?=
 =?us-ascii?Q?O7TX9UwpkCh9onsHOG743NfHiqgobtVMlUf3YoqssG93iqk5plNfRONDS2+T?=
 =?us-ascii?Q?9gFLoNb2SU3v8J8xnJUSM6mSn+3WNPJ8Y452TerVxJzVbHg7ykDiolwYyiGJ?=
 =?us-ascii?Q?VmdFXaYp+NrZ1OujGhc0TSf92iZOGdShbXmMBB1WEnVgse0hPa5xHW+gnJL/?=
 =?us-ascii?Q?53O1TM3BtAJfVNCjD3fdaq0UPDHUN8Z+ZoNYi+cwsiIAzIf09hTBSq/Okbjw?=
 =?us-ascii?Q?6q/8O8gM786CvDUIo7dBNM7vV0lCD9JL40C/vy6s6qO7BYb0XefzMqSMpCmG?=
 =?us-ascii?Q?oZa1LyqwAzRfK6tqCBX87xhk8A7ROEvwWoANy3R1PhGgKzlqIyTZBLVVByWv?=
 =?us-ascii?Q?5mAUTwj+8Bj5QAjUJ+j30eTHrlz+rn9VuIPCaKavNjQhBe2gNDBeHsTulkSg?=
 =?us-ascii?Q?VPo4RNCnnJIhchWQiy7q13sQasz2YmXry2vmmjG/Dw9Wl7jc5rQ0p2gA6qnp?=
 =?us-ascii?Q?oFT9L1wlsJS/r0FY4Cv+sv+vncSFUdZvK1lL7wn/aI57W2IKIoBKEwHygfha?=
 =?us-ascii?Q?SFKMTYqkpqavUG/wZAzMhJf233ch0+54OkotaYRbTKQhzt9QHvQD6AzL/4Hc?=
 =?us-ascii?Q?swM5Y+LtlGvXDV94YkccIcu/WQxDcX57hsb2r6PFzreiVgTgNT8IUwLnE6i6?=
 =?us-ascii?Q?Q4kAuLzrnaXnk626AfQUqk0AWrRQ5NHXAf0hwdpyWl0mjmDrVPtzzhvBZWZO?=
 =?us-ascii?Q?I6hnjFc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MwHBHvHbIIQmbRW3+9rttvgo5B3pykPYAdB9d+Ug6wLiXTSPIYtMpl/vcrsS?=
 =?us-ascii?Q?6o8neytiv/l5v27a+l+7LXPcbm3rxFjsNm2+bQQKNu9Sz1uTqypK5wiZOgHI?=
 =?us-ascii?Q?mKEAdh3TP46NFZMH9GCIta7SMSIneFS1hhSghDNtiDNZTJXPqqp3qA88X3O9?=
 =?us-ascii?Q?SKexz9QdVLJz9sKtQFSjr1sIIZ9KspBbY2gJ5gLs1/El3dycRiMSob1LBIQ2?=
 =?us-ascii?Q?TTEp3TWhjRkJrBspiB54+lf0KVWHZ2vtMjErzGzh0TLx64jlUmw8XFtD4f9f?=
 =?us-ascii?Q?cWg4QwxUlvwwW08BRRTvK3apG0Stod0mZO39zzZ3z/Ir7X1DidDUqkDWLYAc?=
 =?us-ascii?Q?1l875k9yIMBFmoCQNXglKcyCAsU7k6RLKvOJxEe7ChuhJwwbBorGtxCOCNKD?=
 =?us-ascii?Q?ydP1pqglYrWwsFd7mHCU+sOM1gqNAGOxStgwyiEjjKNZuJryTqNJGv+v0aWB?=
 =?us-ascii?Q?XPDxAyf2urEOlC9rDY8KDZ+OoA11aNtRtNHhAxz3pvavKMC6rsw+z61hWovx?=
 =?us-ascii?Q?GsD9T0yNxtbXJRQgGZyulEdU8ogx1IONUxNg6uh4LbUMNAvQg3sVJiDNW7k8?=
 =?us-ascii?Q?zh65xsZexy6LDOUM+qWZ/u02zSLcK/P2TdFOgHL5G/WJYSOUpVcT6q1+llBT?=
 =?us-ascii?Q?rNddP5zA4OBh9ZdrR1LgAgCjGDfQFG70qF+CvCvn6GL50yF1qT/tIR2yQXJY?=
 =?us-ascii?Q?vH5vZCyxDUtN0UkJ1iE460oxXuDrd+LoCq5zSrUKXS8T4uwz89x0uHE6CeWj?=
 =?us-ascii?Q?+3mF6CvwVLRK5pDPRA8DNdSHnemgOWSOjmfnNo/IZluw4HSWsSQ0Wnl+IMky?=
 =?us-ascii?Q?c98h26WtWOSpb0ZCWYp4Tlod3EwFS00A7Nei9TTWjCiZ/wWrXyfgRLrB/3iE?=
 =?us-ascii?Q?Gr1iE6ENl7hHzFAWjed9Oqz06lnjFiAn0yK1PNeeOPEF3BHS8TqAB6gnnJ3P?=
 =?us-ascii?Q?MymML+lUDS8btUTFToQLuEhVPl73QppvA37YnXTAQJiW5ccFOgiTeVL/sJTr?=
 =?us-ascii?Q?jRKkwSySBqeZ5HDFmDdDsBYzmJN6/N/HlQr0eQC6SiwjY4akU39NDmgrlPwQ?=
 =?us-ascii?Q?FlMO0LfEaHDV21KIMTdw1J5aN9olKDtXxmQpvsjnPkQHsN3vzg9BK935XWEo?=
 =?us-ascii?Q?VEMRd0+aORkuILzFWRpG6f4QcNmKsd2Ub7UhoKMXGbLdIv8LZ1ORSvnUzZ9X?=
 =?us-ascii?Q?jVJY+ZfPykt0HrMTxVxzVAIuO5vMCt9uW7r6G4FlK2oPcQnptVgR7iHSgjXb?=
 =?us-ascii?Q?OAFpoPQ0uRj5TqOTXXKJVg9PJIzthjeGbZgLCKWmV0+H9+a7TJbEmeVdgoHa?=
 =?us-ascii?Q?3a0V+CIXxmL6TfBrY0A//YRm6ZfN70sRBZkLjySEMDY6lSdtIX+00AbLpvvJ?=
 =?us-ascii?Q?mhjW4dw4G5gviaUq+cdstH0qU5whqbcXJ4Yx3KjEmHREDsJrD5/6Vof17Rn3?=
 =?us-ascii?Q?9f3iqRKf/42EoHMLEqRl3lAdvqbHNB/EPgex5EDV5W8q+m6xZkXj+YB1o/mU?=
 =?us-ascii?Q?D7DKCwqDHbomYo+HqLZxRp06NLC82qyAuiAv52rROAU6KTOBLj4b/DWYQ/pE?=
 =?us-ascii?Q?jeoakJC5jonD9WAFDorIa0QAh5DpQl2Ouf8ZP4CS?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c72f68f-9960-413c-9950-08dc9840897a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2024 13:36:53.3204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8ZxLgZC8omxETO8XMaJQ8DdrQCUoU3qme7jwAsNDSFs3aTT9YIst3vO79ZDLfuB9R1UYSBHxUyl/BkBFX+sEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7207
X-Proofpoint-ORIG-GUID: emBFpyuNaETLLTi-R-skizqljbNu7oKq
X-Proofpoint-GUID: emBFpyuNaETLLTi-R-skizqljbNu7oKq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-29_04,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxscore=0 impostorscore=0 phishscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 spamscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2406140001 definitions=main-2406290095
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 29 Jun 2024 13:37:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/393

ChangeLog:
https://github.com/SELinuxProject/setools/releases/tag/4.5.0
https://github.com/SELinuxProject/setools/releases/tag/4.5.1

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../setools/{setools_4.4.4.bb => setools_4.5.1.bb}            | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename recipes-security/setools/{setools_4.4.4.bb => setools_4.5.1.bb} (91%)

diff --git a/recipes-security/setools/setools_4.4.4.bb b/recipes-security/setools/setools_4.5.1.bb
similarity index 91%
rename from recipes-security/setools/setools_4.4.4.bb
rename to recipes-security/setools/setools_4.5.1.bb
index 37bb86a..45063cd 100644
--- a/recipes-security/setools/setools_4.4.4.bb
+++ b/recipes-security/setools/setools_4.5.1.bb
@@ -5,10 +5,10 @@ libraries designed to facilitate SELinux policy analysis."
 SECTION = "base"
 LICENSE = "GPL-2.0-only & LGPL-2.1-only"
 
-SRC_URI = "git://github.com/SELinuxProject/${BPN}.git;branch=4.4;protocol=https \
+SRC_URI = "git://github.com/SELinuxProject/${BPN}.git;branch=4.5;protocol=https \
            file://setools4-fixes-for-cross-compiling.patch \
           "
-SRCREV = "a04b015459512d0460ff6bc50f28d746861f4a0b"
+SRCREV = "659ec47aba0126e3a198362ed1659bf600c067eb"
 
 LIC_FILES_CHKSUM = "file://${S}/COPYING;md5=69a7b68f0a4a570d7c0c43465333ecbc \
                     file://${S}/COPYING.GPL;md5=b234ee4d69f5fce4486a80fdaf4a4263 \
-- 
2.25.1


