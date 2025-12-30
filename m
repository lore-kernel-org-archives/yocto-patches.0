Return-Path: <Ruiqiang.Hao@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D60E9410A
	for <webhook@archiver.kernel.org>; Tue, 30 Dec 2025 02:54:07 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.57607.1767063241910137005
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Dec 2025 18:54:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=AUSE59qI;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=5459230714=ruiqiang.hao@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BU1KkXI1406313;
	Tue, 30 Dec 2025 02:54:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=MSljmFH59qGbfNVQ/5Wk
	DxTvj+bUYDBiBBMxKelU9F8=; b=AUSE59qIGo2mxjFoB5rtM0KmIZDTafw34bul
	qLP3bBT0zZPYTvXDZ0r2mbY88yzlk6khkGzWJRzm49MwFaStIcAwU4GS09Y6B5Bq
	U78XwvfnGcpyU27HxGpGq8rbrF3ZjzpS6qcHwvqaHV1G6x+ePs+jfPGOWSomuNLj
	l+sl5647SLVBfXcN6MUa3yi7yOlNAKTvs5j/Y/QgCtlXEnsJpc1T5/FD7qIOyvqH
	3ShXBsX8TENii5yXmJ8IWw28eoTmBoFntpnP9BLiitvXv0/BtOuIslQONd8MSsFv
	Wduv8d6mslLZetdkXIhXURrnlIq410FmxqmQwNHPjiiPUvl8Gw==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013045.outbound.protection.outlook.com [40.93.196.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ba4nxtfsf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 30 Dec 2025 02:54:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jh6i1Eb89M8e1JUWV4hEbcWdAKDZ6uusxQT8STz9OAxcGiDp9RlV66GMvcwIho1pdRZioOUx3Hg9cGfESDKN1tKAq/BXicFRvoGip8Es8ZHj0QfoBPehRZg6oN3ZqW7kqdjBi3f1OAtcavALmmEzhzO5Ls7NKUipDeNN6viG2Cz2Fh5JeXGJZiqMS5qLN8a6RjEYJ9L4lC5J/nT9twdhafXPex/xoLWumkc/ViGU/K6so5mYcRo3072j1tffQJGn+hmst0DRzzgBeogxWO+DvdjbzLFl9CbxRMka5AEwtYZnqsAqblEqZh1wtMELMrx0FCLFMcCcNtvGDKvg07yeOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSljmFH59qGbfNVQ/5WkDxTvj+bUYDBiBBMxKelU9F8=;
 b=y9YN5tG2wQEOec0e5G+4GzBVSSy3UkLhF5m/8frShgq9pYy+SQnBPX7XnjTOCDZPc1TzNResKD/WcM9M1WRJkZbl4saznDGJUcp6HuI2i/FHs8yt1taUYT8VRjimSsPoH1WZBD4q9xtzUxkTUQt5+pWoqGtqyFLaxNGryk93ZM4XL7W8pfAUMbbvnGK9kebjNPzWYUXlHObia8o7H3+6mV7wmiFx2qRdZsMv8cfnPYn+athbAdoDRgqM2rWgtgXtnPYRtZ+ze24Q1hfajm9YT8lwCkph+2ZEt1FYXPJRYHQ4ljS5e7c9ZzTBjc8FUOzqy9XpFPWI90jUbRdfIHCQQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN7PR11MB8025.namprd11.prod.outlook.com (2603:10b6:806:2dc::19)
 by MW3PR11MB4713.namprd11.prod.outlook.com (2603:10b6:303:2f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 02:53:58 +0000
Received: from SN7PR11MB8025.namprd11.prod.outlook.com
 ([fe80::a5fe:8f1a:b4b:d00a]) by SN7PR11MB8025.namprd11.prod.outlook.com
 ([fe80::a5fe:8f1a:b4b:d00a%4]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 02:53:58 +0000
From: Ruiqiang Hao <ruiqiang.hao@windriver.com>
To: anuj.mittal@oss.qualcomm.com, yocto-patches@lists.yoctoproject.org
Subject: [meta-dpdk][PATCH v2] dpdk: use v25.11 tag for 25.11.0 recipe
Date: Tue, 30 Dec 2025 10:53:26 +0800
Message-ID: <20251230025326.3155305-1-ruiqiang.hao@windriver.com>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0027.jpnprd01.prod.outlook.com
 (2603:1096:405:2bf::11) To SN7PR11MB8025.namprd11.prod.outlook.com
 (2603:10b6:806:2dc::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB8025:EE_|MW3PR11MB4713:EE_
X-MS-Office365-Filtering-Correlation-Id: ec8afefd-f561-437a-a30a-08de474eada8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+VDULHRf2bvV0gU8aCsYRiH2vPtPCdhx94IsGgLMigVf3xz6wzRExm6268lK?=
 =?us-ascii?Q?DFQqx4mKYkAv+M83gUs4D/J8ZAltSp1Iu/nQKU7yrdEhIln1AX2ODx0ytnQA?=
 =?us-ascii?Q?8D23E4h0SpXmZAU6bbE13XX4CVQ1R74qvoHf1CMzHR7AihIvieDhFt5GZD+E?=
 =?us-ascii?Q?k7XkEEeytDasDgDN38yKVY7GfxVW4XRXPhLe/dkdTsTo4iIZH16dGjOQPOpi?=
 =?us-ascii?Q?xMLZkNK88xBO+cGnGMVzpG7RQiQWpZpIxCe4enGP6WuSEqLUHucDjLbElvza?=
 =?us-ascii?Q?QC4BeNe0tgdH8wfUEhpiGhN4f2zXDnSbpvbbfT1grVII3SIL3RiqtcYgRjMU?=
 =?us-ascii?Q?n1i2S9P1p+zXaVOD+0w5I+4XOum7bu6tBQbgdalldb8UXY+uOVbvIaFgFi/c?=
 =?us-ascii?Q?OUMecPndjFWoPHIqndMX8OkgQFYcJB/M3UVAzpi8HHK35IU1a/TB+bK8YJEc?=
 =?us-ascii?Q?IvwPhg6nwALyBlSPfgu+01MvBPb46gkflUkeFQzV1diWCiWqPo7rF1Ma6K/s?=
 =?us-ascii?Q?/rAAigYCnegdgrlekAYbsu4+S6QAvIq6owXCIE3gOMR2mumeegG5oXI90+KP?=
 =?us-ascii?Q?caifYXCWzIYEJxtWgdyolTu3aNJ/doiFnRHLJBp67U/jw1wGbiyvn3riBN2N?=
 =?us-ascii?Q?lE9dAYmwVlQ8fOaN8677TqMRc97Ed1HHgAB5r9XvfqcyR6jdz5cUCOtcJWnV?=
 =?us-ascii?Q?1dv/5jhaKLlVuATPabbBFejTBoOvxy26UEvQOFS5AxXFuRKFj9H/p+kf0dli?=
 =?us-ascii?Q?1TQ3294YorUcSr1rv2IgZU4Fivsfa1bMeOzsA667wwFwCPr3+51dbIWYnwfL?=
 =?us-ascii?Q?uTI2HIAmg8vf8Zm8uH7iqHOZhDJHpttMq13/dvvLtSN8qPa5M7wLyDBwQvaT?=
 =?us-ascii?Q?sUDsVRB2yNIXiBD3uK0FqX1+uc4kah8HTBRwixQGxpFfO+1fnK2FWNN3pKX7?=
 =?us-ascii?Q?U1IxtQVgxEB+vco685jrjmhCVUQza7QCOqGR3Ht7MsrcmBMtu134gWHGLF/R?=
 =?us-ascii?Q?6CkzWduwiA+gjWjnGAo3OwXBfhyYiEHFrW/EZALY1ss5FPxlY2r/5fOoZCwm?=
 =?us-ascii?Q?k5LSexoWQzmR1T7+bOU2c2MF1UPwZ5RmmXIysqwiyJixciGoOpEUK0E3WFLp?=
 =?us-ascii?Q?CI+q/nTxmiwQaLYJREihX7YUIlrT3ahYjoiRzb05O5Olnd8AuvEHxeXPWXmF?=
 =?us-ascii?Q?Jl8tbvH4hysSpsCj7gRPfYjnt9SL3GVVZSNC8k7gdHoZQ9oIjugCn7N8cVzn?=
 =?us-ascii?Q?Uu4905B+iQ2FvTPRxJsyJlF823Ae3WoWOjXeTsR29ugcaw15oEcskAeB1mKJ?=
 =?us-ascii?Q?O/04rR89XvVhP31whz6UGil4elV5ldB3WJa/g8HNB0TLL2i+thCsLbuJoAsJ?=
 =?us-ascii?Q?s6H4K5Y4zghCFqc/pxvU1Pq3oDTpbEc0XMtjnO8QKJtPe8vzqAFtZg5TERiK?=
 =?us-ascii?Q?jZZMYVM4ztCDj3JSo9BPltlTkL6eUR9ZqrilNv3QVY/hQUF60/JD5FJVLuhs?=
 =?us-ascii?Q?Uq4RViPCcgsl2+Q+S9hAoNDi0TF7aZOx51xU?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8025.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6OjYxv//AaJiSUHv+4SRb68ZiOnHI8d4ER0Uf3dyOutI3IYanjAhVHEZWu91?=
 =?us-ascii?Q?/Riaat/sCQSTfZhDJZoki6UdmkSaZHLZhNAu6cRzAgKhi2C0bsqCYRZ3T71i?=
 =?us-ascii?Q?B7XN+7QWtK5LSLCk+82/csxjqcmB+C4mvSYUUjXvGfki5o+bYOsvyDhj32B7?=
 =?us-ascii?Q?LkCwkqxtmeIlFQBL2C8A+j2hChHNINGyuxX7Z5olIO7OiBL3gvvEuTkSH27Q?=
 =?us-ascii?Q?XQPOFLffDhnO6jxgUAiKpM2S0vMCB8e3aTDzQvbz/AO4g9MzYV+wN1dZyumN?=
 =?us-ascii?Q?xT0CRuoDpW2o3WmSNvzHqvlbjSHQqmjzYpU7nfb5SU5eXGcj1dwlrC6K1N38?=
 =?us-ascii?Q?3K2j7PvFrspPVc2bRqVUAvqYVLfsN+noYVGeavQ8l2S3gDxagUnN2LxpxaZz?=
 =?us-ascii?Q?5lu2zMbBbC4UDpReoOZW1ZtiMmc1dJZd9tKEZEJzE6kiz5NLUl1fDoAXuz+f?=
 =?us-ascii?Q?VGFp0nrPkE135HBDRvArW8cutsyUCQFhgcEP0pxo1IBIvFtmdIHISOk0j4i4?=
 =?us-ascii?Q?UFmK8cpCOzjahP9TKkWp5RLWB1H08ENtfdsC7v+9G7hhh4astjbpJp2b7pRR?=
 =?us-ascii?Q?0oHh5GmHWkoKG0OEso+8yxiqUlQE2uFCKmq+My45Ptdked2IgN79dXx7chkY?=
 =?us-ascii?Q?KvhoQhrJ/TX2owWFRt3IQWWgQgWvg3hbA8NciwrQQ7RyCz4nRDVdTC+TZyjR?=
 =?us-ascii?Q?BSs5ch6GGcez3wUyzEOPMhBAgCeUV3h3LhyBhP2uzm0uy1KRjdJF2bWv4qy9?=
 =?us-ascii?Q?0w0DPI1XXWBEftZdg2uZFMvvszp156sK450bRfutwz0eHeVwe0fT2HkFoaxO?=
 =?us-ascii?Q?TwEDqlUvnH8kffvMVQW6a70nyWKd/wzqus7+R4VEh+TJ+bsyha4HGAMIpu5o?=
 =?us-ascii?Q?PSX2pC7fs1hU2nIoZQx6mxzL9HjF99dn9q19DOyCePvtaUKn3Lcl9r5gdoZs?=
 =?us-ascii?Q?W4sd8H8/vwzmzlm2h2//UVOmLRRrAohsIOOzO+Z1h3Ve1qZkfcCLkwZa7P4F?=
 =?us-ascii?Q?+z0tzLZ/9zw689qqG13LBh5AaNHs93LO83zsa7Z12KvegYebVW625ImAWxC8?=
 =?us-ascii?Q?ZHwggOYMR6q7OkbbkbNo/YKjM7E1WpXdONkoXlzz/GVypLXFaq5Z87dDgmG7?=
 =?us-ascii?Q?GfFEGvbQwAkkSW9m63VT5S0uyQ2kjt9l5OEc5r1iYx6tpW9AwzHOySJYYFb1?=
 =?us-ascii?Q?nlOaWO5uDzeqZMKm0xkwWtFNVlVd0omIFFx8ISMYaukLnp+F3P3ZSToJevdA?=
 =?us-ascii?Q?pCmC74DQu2qgpMeHmQALPzpoHf4fYODLH9KeciAqiy4YmNMYnaXy/7OcUzei?=
 =?us-ascii?Q?77QWtnsb9j4f91/BcywU90KgeqcxA5Ll3B3gAQ274E180+UDYkgm8nOuELhS?=
 =?us-ascii?Q?8qKKdojvmLiEYmrqiXA9vGz+BdWuc/cNyZCX/mJsD957Gx9J6zzRAyQpjR1B?=
 =?us-ascii?Q?1EMKyFp3Hrke/uaOOReeGAT5+vaMxaBfHgF6zJ/pBituAJ18sYAk5Jo3GBW5?=
 =?us-ascii?Q?+TFA5XgB/TLEztNHLHLy9Ltv/KKmX9it+Hzh2P2e21PONaIrP1YoMHu2QKTV?=
 =?us-ascii?Q?k8Gm3ach0fX8ogeJ9mTDoUTks4R6aWlr7U+iAqonFWBHp0yaDHnZyoWEROfp?=
 =?us-ascii?Q?w58JY5RW6ZSiyc6o+Q3mzLISx1xy4SG/wCtE80VfX2uwp7uvqHtIxqR8f5qP?=
 =?us-ascii?Q?0GZgWSgk4HX2EV/VyB6khh1vsx8IIX/FSqzL09As0t4GXFxzF41WN2GR5mLu?=
 =?us-ascii?Q?dCQ9d5f3qAPVnkF9llJu0DhxC8aWROY=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8afefd-f561-437a-a30a-08de474eada8
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8025.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 02:53:58.3021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0io1uu9EAVr/zSZjVeVz151cZ68AfYmiM1L2woUBv/LusXSP+6zm6iZhHgi3IzqWmDFm8n/pcOginCDWObFRghe3CR/nIpHaZdpyOQ6/ONc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4713
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDAyNSBTYWx0ZWRfX0ZHPYyhEbrkQ
 g9Smf2X/xHlAqFJq6ExvxUF2hrikIuNsgPf77ZaVBVd+WzQS3YW77siyf9SzUKCrQVpJXs8CAyn
 Y1u5yLbz/QI8rw7zBb2bdu1DUhQSPk5yzVoABZ8wXOCk/BvlvyRrT79GMho4khV9Y4dnW/2rcJ4
 EHbJWp6HgkiVC/VpjduZCvDb/z9MJBcemaB5POIuGLq+NJ395QzFNqYcVGU7EAmfU2NSp/1yOfn
 AkXdLpcWqBkXPA0iOKXqmo4wL4ZxPM4h3u4xZzYEHL5p6/YIG+kqX5Jh5uCpafVl4GYAimwjFMa
 GVBDp1vx+5jgxd8HTzubZ13i4h8EYqLdqvwClOf+jWdDnfppSK8aIjcUmyhHvdmxNR9l+LDF0y2
 K+kBzYDvcwYa2GSrgYwbNkvcCt1IBg60CXI7Uw1skS5LOXshGVC2r468C1b2xlXrUqErE+qSXkB
 rdTEJTHCr9quBuEPsNg==
X-Proofpoint-GUID: vhUR1liCpYL8ItI2GalCGLcB-n6kRaS3
X-Authority-Analysis: v=2.4 cv=OO0qHCaB c=1 sm=1 tr=0 ts=69533ec8 cx=c_pps
 a=9wPeeuiWglyMylSd9qupQA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=8rWy6zfcAAAA:8 a=LpJnPuV3LDauWIaC66gA:9
 a=FdTzh2GWekK77mhwV6Dw:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: vhUR1liCpYL8ItI2GalCGLcB-n6kRaS3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512300025
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Dec 2025 02:54:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2883

From: Ruiqiang Hao <Ruiqiang.Hao@windriver.com>

Override SRC_URI to use tag=v25.11 instead of tag=v${PV} to match
upstream tag format while maintaining version 25.11.0.

Signed-off-by: Ruiqiang Hao <Ruiqiang.Hao@windriver.com>
---
 recipes-extended/dpdk/dpdk_25.11.0.bb | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-extended/dpdk/dpdk_25.11.0.bb b/recipes-extended/dpdk/dpdk_25.11.0.bb
index 0978004..58fc441 100644
--- a/recipes-extended/dpdk/dpdk_25.11.0.bb
+++ b/recipes-extended/dpdk/dpdk_25.11.0.bb
@@ -1,5 +1,6 @@
 include dpdk.inc
 
+SRC_URI = "git://dpdk.org/git/dpdk${STABLE};protocol=https;branch=${BRANCH};tag=v25.11"
 SRC_URI += " file://0001-config-meson-get-cpu_instruction_set-from-meson-opti.patch"
 
 STABLE = "-stable"
-- 
2.46.2


