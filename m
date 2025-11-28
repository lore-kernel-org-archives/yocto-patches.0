Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE61D116F6
	for <webhook@archiver.kernel.org>; Fri, 28 Nov 2025 03:29:16 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8181.1764300553888398926
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Nov 2025 19:29:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=NrKrCzSm;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=3427ccacfe=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AS2dAnu3127853
	for <yocto-patches@lists.yoctoproject.org>; Fri, 28 Nov 2025 03:29:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=VyGEyGjdNSbWI2RyXCzJRM3XwVZtrcd/SkQ/e6puRbY=; b=NrKrCzSm5xbQ
	+ZAu6kDvRpOaQnMSK5OSUkLYoNYvMdzNdWAcjBGFux5uZTaYGmaiLDJ+KYnJv7nr
	qTpdeGaKVNygYWXXzTFpCpLIQMGe00IlFR9L/I62W7BvnWMLRdVbn7pJUlX3T29U
	7r+7aTXm8jrDoy8SIuJeWEqN8flROR8oz62kGFhuDMBi+ibqFP3U1Kcrn5ensmsk
	Nb3id7VPlxXL8H8HSyFkCAoZqa6QAnZFZdp0+CB5PNLdNzJduziQ5wjJNS2RrmpX
	SfEkKPMyaqB2JxzMma5Y/ni+w2Gu9Ll9tOgdqv9P0ur0BT5XHdi6y40IgokRYLDl
	9DKNg0GRbg==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ak455pfmk-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 28 Nov 2025 03:29:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKgmuPivvz1uT9jVvjK5z2SmU9y0GSOHtuf4LSiRdlZuY5uwKmxAgRxUnCrOmrjtkwH60T09e6AcAAgic+GhqxYnjey1c31CrL27/8Xt/7fuR3LaeE2K9UDVj86zK59TSbq3DilVJl2D1ycW+ACz/LsFnL9tCxzSfuMkiF5dU3IXRPz6rMS7YogW8SPAZvni+XWIX1g8wuRQpwOXzldlo7ab8S1DfW9CoYxiX3rqzYisOHyvXO0e0I5iK8ypCGdxPj91gVMb3byD7D5Xg5hsU+efj81uA+AjsoNF59KzWRmziHfCOWxRDwuFLLX2ZfWSem8brA8s6dgZUPXQXcP8Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VyGEyGjdNSbWI2RyXCzJRM3XwVZtrcd/SkQ/e6puRbY=;
 b=eUB3FO9EV8QLWIMnqizFFrwsRX8DwYvMWd3HBBahtAJDGGyseRSFkS4toW43Zgr2NDQIqSfd+433WYtWWNsZ1yLXI0JTMV6ULmmdulLpXCm4FLjwK7r7Mvf5WfbUATRheq6MNAKoLbf7MEo92aFRKof3f2ji9gyPjrUxyflcajiCIyeKGHYiUUrZ3vN0o7ttFmFzCd14xgIaK6J749ksSgVDtiFIA59aPFX2Vccm0m/aBX8AIXQLaH6i80uthUS7p68LAdWgkH0CkSzuZ6ntjq+/nl8iFEJNdEX7VVJtLrM0bAGuJF1y0YyLkXgXipeqo2rDOG4fn6OSImhG06HFHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 CY8PR11MB6937.namprd11.prod.outlook.com (2603:10b6:930:5b::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.13; Fri, 28 Nov 2025 03:29:11 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 03:29:11 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org, hongxu.jia@windriver.com
Subject: [meta-tensorflow][PATCH 2/3] python3-mldtypes: add UPSTREAM_CHECK_URI
Date: Fri, 28 Nov 2025 11:28:48 +0800
Message-Id: <20251128032849.759822-2-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251128032849.759822-1-yi.zhao@windriver.com>
References: <20251128032849.759822-1-yi.zhao@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|CY8PR11MB6937:EE_
X-MS-Office365-Filtering-Correlation-Id: d86c505f-22b9-43a4-8e5e-08de2e2e4bb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?v4x2LUYmYVf3warQT7O/CxvKCBGL7FzK1Tt9WllM/ijyG8qVeU/t87PCiJ9K?=
 =?us-ascii?Q?Yd3KIMwfZY+AkAFwgITVraJ3kksxuYq3XTBETufZ4bGuXHNJrNU/65TA6Xu3?=
 =?us-ascii?Q?7DmwQj8cD0wQOp8ZwekmmSLMGSafxOoutG9MwvSeTi2usK0QkDo9tO6jHYlU?=
 =?us-ascii?Q?f/u3sdQojX4KrgGovTDc50lnwBeOwe/HaTBMiX7olPGefrg/DzM/msS3Coa9?=
 =?us-ascii?Q?RTHxI816ss6LV7IexAi7PXIRX+vQnS/jHfUVl6DZ+N4YVXl2IeExgpMxKSQj?=
 =?us-ascii?Q?YK8ttXlaXTT7qTpgFh5wNV6G5adMZ28Y7dFqjWTFpc3CYkwzm7WWWoiqkErK?=
 =?us-ascii?Q?RJlHRK68zTO7yJnUrNbvw69lfyj5hqV/E5jaWoOmZcaRYCeLVakRUkybXKXG?=
 =?us-ascii?Q?3/yNzaxF0br6AL8uugNMW8omJ9J/je0yklYtdAH5fGaP9wkhT3hFJr6zPUi3?=
 =?us-ascii?Q?8bPUCTK/kNnIaAF0x7dtBhop//4Vyyw1vUtI6pXn6seESCN1DBfH/komZAT6?=
 =?us-ascii?Q?xXCL1YaJ2qDL2ML6H9D6ErOjk6FULGB0XxPApCh0+oGrWVZkx0WhcoXdlKdA?=
 =?us-ascii?Q?AzfOks1vbK/qJQO+RGNK73s13UFpfAWu9L/Qz56Fg2pEHJ0ZAW9Ydo6DGWbU?=
 =?us-ascii?Q?Kcy03iSo27K5WvgyFiU8/BdFDZ3x9V3YYZkdnRYr5qHlr+ldybbF+w9W2Y1v?=
 =?us-ascii?Q?rpI/Yce5SrQ/DGptYO9riQG76ueXV2O8t1tHI/MPnMW07nHNAX4rs5DpLqOd?=
 =?us-ascii?Q?Fea0nserruebl9DWqYTzgAziLr1tFbHLdyK0RYMDuMe5OcD7zJqBgOWEzy1W?=
 =?us-ascii?Q?yWR1b+jca06rcrEJYTA7tjvQHHh+8DeYeGchG3BKc9ikkOGMNG5Qkh0yuMZq?=
 =?us-ascii?Q?tx6bXI6Hsbxtxxr2OKEapCsqVQtxzruvM7Y3KVWKKc6RpDU1zmq0ISFQmmvC?=
 =?us-ascii?Q?LhOKr8V9p7TW/Cu4DCc6q1aQ60oMoZXxIfv+kDTOlgnn3wq3SsPozpM1rhGd?=
 =?us-ascii?Q?lb1sZzCA3PBW87WSqTo9YFBEu+qTx2u00dRthvrjRqrDzC53WK7mRXdpB+Zn?=
 =?us-ascii?Q?J3LdxkAaITStXpXdykwqH6UQbu/bKyHbLeSEwHzwr72A9E6lMx2uEI7BZV8k?=
 =?us-ascii?Q?5SwauFJENB/AeeRq5e/Kp7CWmRTKwPQ6Obp9GoaRB74PAi89Y1YkxeVW1ffw?=
 =?us-ascii?Q?Vry5ZvHuv+FttCA25P8TOdWd9U4nIAj78hTPsGyiBIOzBZYBGbNgWvU75ixq?=
 =?us-ascii?Q?XlARHqeRQmPgziqaTB+B3SyTZMi2WsiGbt5tpsK77PskNYUp3H5Z0+DS0URx?=
 =?us-ascii?Q?ocK8S6+wtZJU2G7oHA03htaJCOEQ88ircRRknBpD0sz/3QrYQVYixvF6uQ7I?=
 =?us-ascii?Q?CfM0tGws9a6Em0qlx4w8qtPZxs8AfMaao6u/lPLCxEGL1naUVNhkL1Ysak9k?=
 =?us-ascii?Q?T78w3sFYGithIfmv957qoCbrPrlBZmbJpgcvafyDD3ytcAQ5Tpnd/cDX3DCc?=
 =?us-ascii?Q?ETrv4nU2eArn4YTnCQNZT8BXphCPD7TSaUx5?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?pY+jjd/g8Y/9FevJOnnYSSSDkY4On4AoDXRz5ZY4/nGMf3ngt8DokMl/tHlg?=
 =?us-ascii?Q?N8qWoM88t/AdbhDJVaj6n0VqzZSdS05mPtA2f+rjQ6Uu/9CJ/lEni43h6H8w?=
 =?us-ascii?Q?BgnF+mB1oa3j+Kzp74aDieNiNYIaCJ6/jevDbZtZwDQdCuVd6FCKaeq72gOc?=
 =?us-ascii?Q?rq5yJtHBvJXiTDWPJ8gc/+zRPyIpGh203NPqAtqdlhZhertbwynd+AKc38/P?=
 =?us-ascii?Q?yUGo/pmfmJNDKCHJiV500n3URGjwzpvKgA9/hgLoxq9iCWBqSo6+A+5KuysT?=
 =?us-ascii?Q?M68qUzjq6pWO3no0ljh1uzHJJU2e83PDALGC3yEs2XNP/+fzh+JAQ+kwSub6?=
 =?us-ascii?Q?nWmWEWaiJrPz24857i3Ak+YKRpbKYIWzqH4Xb/q9Di670Z30tPUa3n5HC0qd?=
 =?us-ascii?Q?d+03wJUXHiG3DJkmfRCL023mFn7yzKMjmo3LKAwoWQs8OydVk8nmKA5km8yx?=
 =?us-ascii?Q?GBuq7ifUXwIhJ97JHN2smiN+VIKbUa07I2DcSq4qaD1mVhmHDzjkEHq2Gc9J?=
 =?us-ascii?Q?WNxwYRFna9qF9sQSZ/nSosP4HlzxcJrJ0YbzxCM3+mIxsxAqiQaBOb4tj945?=
 =?us-ascii?Q?OpyoM715I//va4XECCCGpYtMnh3ETA6ABO/KW3n96vFdDyBJy551tXXGXn9+?=
 =?us-ascii?Q?wyIwPzM+QnYo/sCGcuvzfxgx6KXET7+Mxpjsj/9rdSVen7UnAw50utYpNjL5?=
 =?us-ascii?Q?CLWFJYa0PqTRh7MDraWdh7/jOzWPg052KaDGv+4GzMrBftB96/TgwGbDXrF2?=
 =?us-ascii?Q?5xwU+5j5M9NtPASxmSpLV2Jbs6Qc0XENmsqvZB3fjmHaqogaSbYQz8GLKJlH?=
 =?us-ascii?Q?5cr3avNSqyDKYRmyNNKz8HrVrXU4WLvkF0l5MgLudWsnD4AQg08Sy+kamJCh?=
 =?us-ascii?Q?e44CHBRHrHMVU/D/xiLrEft5V/xbYQ/HqQtgy2qsuOSrjd5kyAvQ+ghEnGk0?=
 =?us-ascii?Q?849hh1OGqKkz0PNRmCLMDK6KfmcEa6xGhzBbNfN8YFNyuLJsNd7iFhvKHCPu?=
 =?us-ascii?Q?7sW8sg2KbboBKQ85XLVemr0x6XULVt8QoZ8LrhXN2vvCJl/Iojc3Na738lWX?=
 =?us-ascii?Q?B6emRq/OfTJNM9F98qpZI0uv1J50WhnTXRLc+iXkcpmQDysXcViyav4GWOTB?=
 =?us-ascii?Q?cjxp1NRNx8v27CZatBAz5GMiMrMzKc8fG/yDS1gb9UconF3l1SfEv3RxGZ0y?=
 =?us-ascii?Q?BFNKa1SqdXPoQ5jZcyGoOx27pJ7vSMBQF3QLP7YeSayhEtqAb04HgMQWIvg/?=
 =?us-ascii?Q?lWnkSfFQ2a36+ROPVGC9Xq4HgybAZV25jjCZWKy1Kl05SRykeVrUlPegUnmo?=
 =?us-ascii?Q?9bKQLASLIHhF0RRzSF/UhzPT880lIZdMgvmC8S4egaHv31/OwYsPlubFsaT6?=
 =?us-ascii?Q?hXUYuBEegTE8GVIr4qKUwa5c3BuyOTV6vdF5bkEjucylrypER9rIzfSibt8z?=
 =?us-ascii?Q?nEwra1Wfc45bupqMdEkFGE1Mbu8Bl12piyxXtGSOYmPyFzjqFAYmi57vpLMV?=
 =?us-ascii?Q?VAQ4SDCG7s1uIBnbNhHQ219H/gzhxtsHReSZK7JYLl/LxRwDbV/uWAN8xh8N?=
 =?us-ascii?Q?iT7vvRavSxBJhvjtqX6IQ/RvpqfqgZmIB0EopoKI?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86c505f-22b9-43a4-8e5e-08de2e2e4bb0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 03:29:10.9580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jdwif3oqEGvTTYpccDYBg8g/chcnMdyTnCrCU2cX9Uqi+lnDQ9ASVRmNEybu/9H1s/5yWt0C8fiOv8imRt3DgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6937
X-Proofpoint-ORIG-GUID: aIAH5I9og3ltz5-1huh5-ESjli2lsw2n
X-Proofpoint-GUID: aIAH5I9og3ltz5-1huh5-ESjli2lsw2n
X-Authority-Analysis: v=2.4 cv=T6eBjvKQ c=1 sm=1 tr=0 ts=69291708 cx=c_pps
 a=AaT4FrH4hTNSk8p5YcQWtA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=HbzeB9StAAAA:8 a=CckQENj0AAAA:8 a=t7CeM3EgAAAA:8 a=pxweayMD3NBtdaRH13QA:9
 a=i9oqPCtDvve8OcjLCTCP:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI4MDAyNCBTYWx0ZWRfX+S7ift0yHzlG
 aEextQ79bzIMv2FWtUsvP8FDBMljE5H8Aj3ri07MuLZ99NXutcIGiRMf0NqX9ERSOWYoTYwjY3d
 khOWcYJeXdJZMd+MUVpIeMZR7A+Qi/X9YOulGmjQx/BNLWSV3AZLsYkzzQ4wfltS+bwVxrhIKgh
 MTjRNTZU7xkkL87drniWJJnxAzNu+cwzrr8KANB5uqKItU093ic0nXzugAn8AsoBwGuQWD4p9T9
 Wa96vgSIUXN6PB5RsUiY5S8GA9f56H5YmykZEeCWmK81eRgvjDek1doOpqpqo/sYnZDWh20drqR
 SVBiuER2QR2h6v0elRubiLVzGHKBqBeVizXe7SphERmmvibo/u4Jyv9/Y2EWZ/9jcZsEyRmpXPS
 9TxEsPAdWDoy5sZtNrMG9zLwTCGz4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511280024
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 28 Nov 2025 03:29:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2727

Add UPSTREAM_CHECK_URI and UPSTREAM_CHECK_PYPI_PACKAGE to check the
correct latest stable verison.

Before the patch:
$ devtool latest-version python3-mldtypes
INFO: Current version: 0.5.1
INFO: Latest version:

After the patch:
$ devtool latest-version python3-mldtypes
INFO: Current version: 0.5.1
INFO: Latest version: 0.5.4

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 recipes-devtools/python/python3-mldtypes_0.5.1.bb | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/recipes-devtools/python/python3-mldtypes_0.5.1.bb b/recipes-devtools/python/python3-mldtypes_0.5.1.bb
index b3f8b98..9a72066 100644
--- a/recipes-devtools/python/python3-mldtypes_0.5.1.bb
+++ b/recipes-devtools/python/python3-mldtypes_0.5.1.bb
@@ -13,6 +13,9 @@ PYPI_SRC_URI = "https://files.pythonhosted.org/packages/32/49/6e67c334872d2c114d
 SRC_URI += "file://0001-fix-setuptools-missing.patch"
 S = "${UNPACKDIR}/${SRCNAME}-${PV}"
 
+UPSTREAM_CHECK_PYPI_PACKAGE = "ml_dtypes"
+UPSTREAM_CHECK_URI = "https://pypi.org/simple/${UPSTREAM_CHECK_PYPI_PACKAGE}/"
+
 DEPENDS = " \
     python3-pybind11-native \
     python3-numpy-native \
-- 
2.34.1


