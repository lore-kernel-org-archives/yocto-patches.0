Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47214C3DA61
	for <webhook@archiver.kernel.org>; Wed, 24 Jul 2024 14:13:50 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.11676.1721830428102514185
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 24 Jul 2024 07:13:48 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=793573a770=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OAnfoT008769;
	Wed, 24 Jul 2024 14:13:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40jw8kraa1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 14:13:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VmV1jJMjNThYrVf2GFJLSlXy5EAw6/Wxtw18JkzKLekVmmNKOJAmpwyFJLHmxWTf8n+STq/0n/+V3wZmy1jx1ekBGbO8EqFkVEQjYdCL//gZbBZ8cFLHsEi2riHIvXicVygXmUgznye3iw46GqujDKS1WWMmyvxZKy3l5izgF5WKPw98I6bwx6gRnXFVyr2i6FfOKwpFmTUH/Nt4hcyfyCzlnFJeEy7ibkwoV05xUqT1G70iYEy8Qbi7j6WW4daOBGTCGj07c5tt41KVzjKks6CAFjU0A/2Zwli02UMQCampA/eTBFpYfS1yMKpC3+sMr/f6IgmlpMKShxV8nOOgBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTPRObi/cg3aPWE1vnz1ZYy8tvFcuXfDRr0yJeaT2UU=;
 b=e7B00ST8uLBhW3W57e37gV0jOv6DFSMOUx3APuRJVx3zAzB6DDC8BX0Snqa8qDuhxR7ATHMyc7k9lCuFaUzF5wdXflCLtlry7jeVMuvS80ouwxyYeyhSoPL8xX8n7L//YSEOetwEwPQ7AND8lroImMLS3SFFoQn2AtcR7/sI+YggrUrqZnxji60hzEw0QOIxBJQiEMgTCwswQUSCj6KrhXGb6H5VzRafpCmZ7n6Gt7wjPVni8G8bwOt+04U3wNf5ShXFyRjE1yRWfyF3ARMbfsFSUN/Qutr/6f5zwXKDD8mFT2P1xrV82NBBSd2/22/Ls1HVf0XWlWFfHxvu1es7/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 PH7PR11MB6377.namprd11.prod.outlook.com (2603:10b6:510:1fb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 14:13:41 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.7784.016; Wed, 24 Jul 2024
 14:13:39 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org, joe@deserted.net,
        joe.macdonald@siemens.com
Subject: [meta-selinux][PATCH] shadow: comment out pam_lastlog line in login pam file
Date: Wed, 24 Jul 2024 22:13:29 +0800
Message-Id: <20240724141329.3326073-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:610:32::19) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|PH7PR11MB6377:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab47387-02fa-41c9-eba2-08dcabead078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?rvudD9QAJutNE6V9C9cZie0tiUdusI7p06qA4BWt5ayRpOdb5w02h9bbMRaH?=
 =?us-ascii?Q?6+fvdsmiG1kobh+ZUCEoEzgRHFeM6kTJoeKq95NRU5ytJcJiz09w+FedT4XX?=
 =?us-ascii?Q?tlnc1Myy2656dP3P6ms22AcJ/xzDBgbD3l1iQp08PIN3qJHX1TJL4NgI/YYG?=
 =?us-ascii?Q?0srwIZIF07+jJnvG6/3owvFoRfDUgPAVyfbAOz7n7KZ3FRoL7GK4I7ULPgFx?=
 =?us-ascii?Q?7sCB0oa07V560/WZT+h62mdRt/W3YLgVrXqVWtIzcePG3Oqp5PmznPcywR6D?=
 =?us-ascii?Q?FovqYf64eFZepmWr4r29NcGdMvnUkv5xRsjum2kf0zwgjjJ60P5/zzVRr+I6?=
 =?us-ascii?Q?SJjuJSiRWEfIwGDW5lHcnpwZgwCWA9J5NQPOww/GkArsVXV/fCbhc+ScJaI0?=
 =?us-ascii?Q?e9W92fXOwVNo4JGKXeKy8VfXxBJzDd3L3TlkdjGyfpoSV+4mPKipJIfKSiBX?=
 =?us-ascii?Q?gGoNUv0WaeGZnSbs9nOCGIK+1+oRy4wRnuDi78mvHEn1XEZtalkmeJAwDI+6?=
 =?us-ascii?Q?t8TfdfCAQZpyawEiS5sr6aNF8m2pPXsc7eCbsD/2NAe1v+RhHXtWk1RU1Jee?=
 =?us-ascii?Q?1bHl513yC+RFFTF0tyHg6HTpcXxZ/56lTyOAInhOnu79TKx8vSPGGg/B3NEY?=
 =?us-ascii?Q?QQPEW8Kw4J/d1QRba0E2+eJOQYQ9X+kyyzDfozHhfPOxNrRIdNWBqN1orDqj?=
 =?us-ascii?Q?uU2QJfJXLEhyVZcxGxe9zYvz5TEMdVYMS41IfbAc9kvyXTJKFh4XsRJ22JG7?=
 =?us-ascii?Q?tTAEU4MHrGUQNOxqUZwAclQINajDn4kVw5+pyARnd0Lmy6A0+n12ZpFQ6wPv?=
 =?us-ascii?Q?8S2hvAMZsMmHgOs9NmBfaDy8ye4BqzVfNBaSjdf4do/TxCNLLhqmoJrmzn+3?=
 =?us-ascii?Q?MGK+rMc1nPoX8cEnXBtQnbdzkiYs83Dj/cu02xg7JqXuZYB0s3TLkfkQDE/D?=
 =?us-ascii?Q?nKBzseU/RKK3Fw3K6bjSUZmWM1TbipGTGrs1hiVTPYW+L5Xoelx5uL5CG/9B?=
 =?us-ascii?Q?vI/nMaKhEjidXVBdvt8jUZKphJzBKw/h7tGpgc605BEKOML3Xww6stf61kdg?=
 =?us-ascii?Q?cJLo96Lfo04CQY2g7L4zAErPY+ljvLDNPo/xSIcQfL6rUqL4ks0AddNST+GC?=
 =?us-ascii?Q?nNjlyB+aYGCkLBqxbxfffbtwsjj+QX8yyZxbiy7zdqzMVzv6VpE8iZgAEFHh?=
 =?us-ascii?Q?/kMnV3RXj0NUWEZYWYGPtL7B66CjNo/VaVduQ9vSsLxVu/KyRgiGUVbDF+T/?=
 =?us-ascii?Q?RILZQlZXfuTEhEiU7m3jMfdiif+DT7pLflxECgJfSNIKVgCwlEyq8iYmgIWv?=
 =?us-ascii?Q?lNx81wYAbrdmT+JN5KrZ7V62FIKjM4/x6Z5GUtCC6wYu60T4Dgk9HAjwm1lA?=
 =?us-ascii?Q?8rV7zZw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Jgcn9zX5x8exdgyNUEyqBR6f+/q/AmoOO8y0ZEdWNrIFQbt6HncxGVyH156A?=
 =?us-ascii?Q?uW+YYTSsVQj6FwYV+pymI3nl2ruQ0lu6yLqe/dvmh3g4525owkwMdK7Hi1Fv?=
 =?us-ascii?Q?JIXp/wVnno8C0cDoSJlzrJrG7T50p3SbCqYtjzJ2WodLdIerJYcOsw/gf6Qq?=
 =?us-ascii?Q?AgMH6RW9tZQXCpjTF2TC6LofoJcucHFOrE2o4FvuOC3/Gizi4N3puGj6eYrd?=
 =?us-ascii?Q?g5MNHC9PIbHQGRr7VcQzEcDooV46v/AYM7HHDZCvudIYpneDeYdiQx88y0xZ?=
 =?us-ascii?Q?7DUUZMs4daG77hNco+AJR63qIV00sbgOZGji0qF+Kl9jc+Y0+pHSciDTapa1?=
 =?us-ascii?Q?rfao33OgTuKtomrDMZ+o8zE5Zeg7YkPDFtidPwIOh4qx7ZE71/IdvFnS6JBb?=
 =?us-ascii?Q?7rw3OKJ/sQsd7iJ0EkTrPH+IQovd4Gj0nJ6V8h/E5hgbvwIjEPaXyJnluI7n?=
 =?us-ascii?Q?V5xmx/hCUP5W96UIaPygdeKDSxKYNgGk1P3lOxaqTwQWDpbqmaUME3iml3A4?=
 =?us-ascii?Q?jQPOEI16J+cgxY8H4dqP/NL4tedkJ4J4/ZBjWBKjX8NfaGOZH1vyyUeParfk?=
 =?us-ascii?Q?vRhu7BvEVwVcg9M/1Z5hR11pMeu1HN9aiUexxKqlSQY8ytuoE0HB9kG4SNNL?=
 =?us-ascii?Q?ZvFYbUCzIENZRFSBF6r9dYObe6xCH8qXrVzxS2SWW6B4FODL6Ew+VZzK2n83?=
 =?us-ascii?Q?H0yC05M4Gv+rKxcJSO3f+mQux7l8x75lHhWwe3GG14QV7QIurKLil8MdkwC1?=
 =?us-ascii?Q?wUuBTbZMFw85+EJ7k84wuv01rY7L1bc7u8ztxSx4k7z+QH2Qs7orvs7Imj04?=
 =?us-ascii?Q?4ReTMZqCSzw5GFnTaBGTfGRpOHwR0GZ+bjLpccWBLa8GUa/S3JfmlbiRXS3i?=
 =?us-ascii?Q?FYFhWWcGoBgmSnnQIBNYoeOsYUYMpHOUQzZranPmCFdG+tlEVYudA+0qbh9P?=
 =?us-ascii?Q?MqKQTskHD2kvIA05SoeGCytOdFYe7GW8a951BvG6djJOPo2YFL8C4WzdLO4J?=
 =?us-ascii?Q?9vN5hXX7GTK7Cl3Lc9vdsUKFHRRiddbfx0maKHiuXKS6yEb9HjBHMuKjIWWR?=
 =?us-ascii?Q?LrOpFnTjE5oqUf6bNcLXaTraSMo73Cb2w0FDqfpGY3aeC1TYu7vRSlDUP8CQ?=
 =?us-ascii?Q?84bZNNV0zfaVdlPSjBRUNrw3YhXjKCjV6V3GIQLoGs/MOj/7il2EafNSLbZg?=
 =?us-ascii?Q?l58uz7MR03gPenXq2WmGP6Al7GJUv+G/GTK6l/LvdezKmQnH93i6on2E+wR2?=
 =?us-ascii?Q?PhwOWQRTlq7KfRZAPorjuRPv38gFokYX493Nolsbl4JQYU+BntAr5+OLTG0+?=
 =?us-ascii?Q?TPJXd9JtvTyfeSexuwjVK2z1jYI/mBbQgy2Ksy8+/cGWfu/nWSVwpq8CCstV?=
 =?us-ascii?Q?BackY7luc3vW0j0hRBBgzkH8ARprzU1AZrCq9tL/D918TPkWzVIE3+WNV9HR?=
 =?us-ascii?Q?NCB0ih1MRR2Mhgc8s9iprndzmiknnTDIvIjUmpMVRIo4z/AIfiVXG1ujS8og?=
 =?us-ascii?Q?oxtEym5RhmjmKLLibw883ser5cQUarNlmbpDN4VsL3i5CCeVZpPyil5DldkC?=
 =?us-ascii?Q?SZXLt7P5AEAd9UzEGT06IccAbGlgvaHXAatEzG1S?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab47387-02fa-41c9-eba2-08dcabead078
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 14:13:39.1098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LokhnssQAWEu5mJTwu7hLZJTdFRM8Tgr7u2AI/MMI/p6CRx9EieU2UAa2bG/zTwc+7X7Z7mCKl2+HBADHqoZng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6377
X-Proofpoint-GUID: nbthV7jc6qPqzMjj4YJk8_kYaspnsvX9
X-Proofpoint-ORIG-GUID: nbthV7jc6qPqzMjj4YJk8_kYaspnsvX9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_13,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2407240105
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 24 Jul 2024 14:13:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/450

The pam_lastlog module is deprecated and disabled by default in
linux-pam since 1.5.3[1]. Comment out this line to avoid loading
pam_lastlog module by default. Users can use lastlog2 provided by
util-linux as an alternative[2].

[1] https://github.com/linux-pam/linux-pam/commit/357a4ddbe9b4b10ebd805d2af3e32f3ead5b8816
[2] https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/commit/?id=c2e299d0acb2fa4ad1691452fa0eae76520bbdb0

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 recipes-extended/shadow/files/pam.d/login | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-extended/shadow/files/pam.d/login b/recipes-extended/shadow/files/pam.d/login
index ec5bba9..eb43f3b 100644
--- a/recipes-extended/shadow/files/pam.d/login
+++ b/recipes-extended/shadow/files/pam.d/login
@@ -66,7 +66,7 @@ session    required   pam_limits.so
 
 # Prints the last login info upon succesful login
 # (Replaces the `LASTLOG_ENAB' option from login.defs)
-session    optional   pam_lastlog.so
+#session    optional   pam_lastlog.so
 
 # Prints the motd upon succesful login
 # (Replaces the `MOTD_FILE' option in login.defs)
-- 
2.25.1


