Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63E1CFD376
	for <webhook@archiver.kernel.org>; Fri, 28 Nov 2025 03:29:16 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8273.1764300555938545760
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Nov 2025 19:29:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=crHcmrzw;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=3427ccacfe=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AS3GZdB3190671
	for <yocto-patches@lists.yoctoproject.org>; Fri, 28 Nov 2025 03:29:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=7g8hL5zNPukMHbe3oHwzQimQvbZYOrMNd8OwP2omoF0=; b=crHcmrzwaevp
	TC+C+tDq07pFPtBbvijqx5r2BcoYW4Vb92VQrXDDqNwV/+n1jqQ687dTX0NcYCw/
	VYDehpvwUDhbzitBuZDUF2UmfGcTr86/w2KwzHlHcRGuInVgHjAA9IoqpF76wLLf
	ZMKOhqIPCWe2MlQpZZqlbI1Kg/oRdEBCWnZS4Z+SrzKgo+8IZYUuKnD3SVUDGxFC
	ejsUsQEoUWPWg6PTq19IRn7qUB0H8bxcDXXLxogeOURl+fI1rs01DA1gnzeM8Szv
	/cyivJZjhRMqRA6UU4hrcTVKiJfXQPxO92eFH5GpP4j2pS8/ya0E/KUCJxzXP3lo
	JypP64cHvQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010064.outbound.protection.outlook.com [52.101.56.64])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ak455pfmm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 28 Nov 2025 03:29:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/pBRqtGJm0iE84LttUPY7teETJ7IWE5wOs8Pim78HJouDeYY1Dhld4plKhwQeCUxx0Y6cawvG/TCCuTkzmKElym3GFf5JqjxpKmVH4KcFGW0/3WHf3jWKIaLyghf/nbA5PmhWRz+6uFRLVV3rHxwtmP9H1lSAClQAbsnP3TBj1qIbsCL1HlzqMBW3QGDgYmceX46AzKPJmttGhjoKWtfr3Kbw4R5b/Q1KIcS+exJsG2ZGsNMegjFWWVdkikCJM1PT+pMqmeDTHm6hsgyC/eGNFOSXK28sO2dGFahX8atxYb9NKjul69WZnHDyPG3mt/lr7vms6FxP8/PHdUa536XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7g8hL5zNPukMHbe3oHwzQimQvbZYOrMNd8OwP2omoF0=;
 b=UMYjED1BQJW0TlHa4w+2MDnvTbx0oFjh2C2Q5AL+1l9vhKCjLouY6LNretJTdp27dFJ2iAlkX3wLJ+7uvkExHlEJr/a29ZjkIzU8NDFLhMvhyb5hGID/pGIN4E1TWN50IPig3bRkv4tXUxN5Mk/TE+li4ZBpuOI+qlJX0bWaG7oMkd9/P3TqEN3tPkh61UN+MQC85d+8s0BBMi4GhMYxWd7/GxuNotppMAgB1v3SBUgGgYMsLac02rJVk/iX8hPamaoF4qNgwqqFUUBUOdGwr3BaRBgo3dRZLFCGTo8mefWvvbUDzR3Mc7H9MivTEHAX2rAeQjUs+4WfD5F5eFm+1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 CY8PR11MB6937.namprd11.prod.outlook.com (2603:10b6:930:5b::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.13; Fri, 28 Nov 2025 03:29:12 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 03:29:12 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org, hongxu.jia@windriver.com
Subject: [meta-tensorflow][PATCH 3/3] python3-opt-einsum: add UPSTREAM_CHECK_PYPI_PACKAGE
Date: Fri, 28 Nov 2025 11:28:49 +0800
Message-Id: <20251128032849.759822-3-yi.zhao@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3c8bbaaa-0ee4-46b5-64d3-08de2e2e4cb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?TWxKjz6SOcdwhOiboUFTkwq0LIir6LmbvjzxCJStSWECdaIPZCXKpdLiliew?=
 =?us-ascii?Q?ZZ+PL0r4wg/6gLZKLX4difFbHer7cSuDs6fAJfzI+HtkEdkjLf2aXXkio6Ea?=
 =?us-ascii?Q?vo0dhwX1TkipJTrvVpdRCgXcUqlQ0DW6uxZLyMuCHM47o2ti4cX0ubXcOIQY?=
 =?us-ascii?Q?1Hw1wHzXQlYE8FNyED2rNr6Nm36YLafgqQkGSRQGzylwPpgT/bQLymjrZnQP?=
 =?us-ascii?Q?BP/+BBhB8wKva/dxlcccYS7LXhl2myXbKs0s05uFJCyxX/QRKp+lnqhMMxwA?=
 =?us-ascii?Q?yGqU0g16sy7KGxDWWXX93VvP3Jl9CMxoYUqJD6vgmk4rInG0ypeGoGhuFVe8?=
 =?us-ascii?Q?Dshuj2H1HTmJwP2wyLRiIwLoMw6v5EH0PfvEPYoygV9L8dPCYWNiMOZWoqS3?=
 =?us-ascii?Q?4HSn4/basr3hX+P5+jXLe3Oj6UgcYNVA8oRLbZA4X06BB9avObVkvHBNGKN0?=
 =?us-ascii?Q?SxYPmWVyA3UJzrCBcg2rmqEeycHmURrOoTkdYZFvbTK8+bVdKmT5x5NQjaFF?=
 =?us-ascii?Q?23SY1xMtqLg/PegJGBDoaC0Nm73rLOsoJqZvrml143VULYlkqrpYVymosRFK?=
 =?us-ascii?Q?lwuZ1hyeK7IgoY+309m5TuizDzzbB+OXZOLW61yB+xaRYMGmpX3zYqtqqr8c?=
 =?us-ascii?Q?yDZn4uhXb5aJqW9NxamEroD3/W9o0Hw3xirKgiKOUDfNiBEfL6y7GRJDs95m?=
 =?us-ascii?Q?5gfxjyWQPCGYslbnt3Dcqx1TOZ1SPWctFcyVu27v52GyL95uTwS/G0J8T+1i?=
 =?us-ascii?Q?Ts+fN5lcwjeglFUEpBRsGFNjE/Lc9glRh5bYkUENnlCf/wnMyesVr6rDZc+k?=
 =?us-ascii?Q?2OzOviWlNe6yf7RV4XCoX7kIYotBoh12IO9Yiy/+f9azlsis2myBmfi4uwx5?=
 =?us-ascii?Q?jnKYJHHS3j8s3ZG4LSJaklsr7nyI1MIZCdGKS/Ty0PpNpDLk1cO89lRzHEOn?=
 =?us-ascii?Q?RINHi1lz27Ib9nSVRsxpsUCEt9B7pFfWgmxRGrZiWqspeMRr11btJbhK+MPd?=
 =?us-ascii?Q?PXD1msRK1bImHEmZ7aDE28NzMLI98R/VBNljIXBWruXllH77yKKjQJOqPEga?=
 =?us-ascii?Q?GDUh4431zPiOoTmR0aojWyRnniDO22POshMvy1e3AQ8kjgBVDyHZe3fEgehH?=
 =?us-ascii?Q?Y5OBWUzlQ74rkHOUpgzvTrrp2xqn49Lqe2+4HHcX2Mcbu/EdUakTfFGsLcEC?=
 =?us-ascii?Q?XJEAyk7PZeQAnwXgaHm68UD+CH/VLtz70xu3Ak3rqVZ0juSp2Y9Amdy0wHzN?=
 =?us-ascii?Q?LS+QmXzeLvbHDmUunBD7/md7rf4+zH91Ss/nnNykihAFA7EgQ5zQtxc89ikZ?=
 =?us-ascii?Q?nxdBRaeUZhSOGnS6V9hOEQU5GBUBY7u4+m6w3GhhtVB38SUJqdhbGpTHq+gr?=
 =?us-ascii?Q?i9+jYDwRwORJpgPd4BwGsas+LEuVTmq3oJxShvYCxXQIWVlvRQDv85nfsYkJ?=
 =?us-ascii?Q?fiVR14H/5vQ7G4of9aSwbA6weR8n68S/otCVXpJc5SVCz3mb5uBt2QrbkXDX?=
 =?us-ascii?Q?YxQm4NsKcJWWzT9fUM+GLStF6C7xXmS2gwT4?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZEKp65RSjFckfhi/h7OULNlLhkeCibrZhOg/6iJT3S3BgAvv6+qcwKCstiEN?=
 =?us-ascii?Q?Hx47nVwPmtUyuhtAvm+CbgXTebDiIcLrGki9ED9G1sfClCwjintlE9xbk7f1?=
 =?us-ascii?Q?o2dNCc3XBMuf1GiCsTklyHOzsJiSsbJPFvfjbS3XRIWi9czjpSaAVhjDe7rv?=
 =?us-ascii?Q?xrfDlEIYkrEAaMMN3waBdkQwQAvou4Our+5hsftWPU2oOqEeYEyg6b75wYnt?=
 =?us-ascii?Q?JBREONryNLHcbmF+aHEK6YihdY4clYCUP4cOKTHXidhMyB39G3WOZKgCmvhW?=
 =?us-ascii?Q?SruBS3QH+tPcWpJDLMu9stjBsO9CD2VVjG6CNGAw3ji5y9/c/5ulKTDZ9YQY?=
 =?us-ascii?Q?oyvgBVqogLE/oW5Wnx1nuhMHbAVLfHpyI3FmkfmiGKJ4shYN3ttOEUUtWCnT?=
 =?us-ascii?Q?RWzrdihGDTrByS+Ut46t+DPvGq/FWB9iIceTxQUaqw+2NSwLNrEHEJwJYUeD?=
 =?us-ascii?Q?VXHpK5d/8SBF9s3Bxjc4H9Ib8CUW/G63jIWzRfkT6j6LbrKR92h+nrvG2JzL?=
 =?us-ascii?Q?8va8tmqc9+dghJ9pCtI4tLrLUhVxDkHmfMY69lR1mpeHnVhP9wIJPkVjCBmH?=
 =?us-ascii?Q?BCbMmI+YUURCiMbTijGKAcKYEvuKhYYU4x4Mq/nvjY2c07y5wPwMMHw5Tm/x?=
 =?us-ascii?Q?ps3VWRMpIZC3jBobGWQj9r63+VuM5Zohl9Zvv58jJ9mpHhOa3SIzJeWP1ixp?=
 =?us-ascii?Q?/3rv+cP3rddmNnGKsDkU54aN8yhWsLXOuH3IxNEZl9x0aqdNu1zBaDFAe6nL?=
 =?us-ascii?Q?PQ88L41X3A5wqHAN74wYZbG+MlvGD4Be7CxXRTRwU/G2Ewa6eVRFErgkSptE?=
 =?us-ascii?Q?gUXjwM45ZLhyKE474Ri5SI6OtH8KZh3vcVKiMgyCqMftBM8SQ45Pd3FjcXnb?=
 =?us-ascii?Q?jTEIogknK+GI58YXP04zNHwkESEuowppk0HfmPFgEPWIWDn5jRf12STRNjuL?=
 =?us-ascii?Q?wxxhzZI7S3jzB/HfisJ1HIRdqAa2MjEsbF1/760Lem7i46yJ6y8xblUtiINU?=
 =?us-ascii?Q?xuk1ixgibYAG6DLvetT9TK6VzuRoSmuSpUCulbsuspVnaiizESQIKG1qtblo?=
 =?us-ascii?Q?gn1wPnfxDDu84lu3tHHBaWVCsN7jG/ziRcN8sd4iEx4LEoRch0SRBcBDaaTJ?=
 =?us-ascii?Q?bBIXBNjZxQ3K5hBZG90AwDy6G7sBYlPVP8Wl9OHbXy/N8VAvuIR4l9xZVa5k?=
 =?us-ascii?Q?B/eU9ferJ+AxqOBB9trBF+QAZPajO4TDE8JrgNEGyMpvd6bb15rv9feAA3HW?=
 =?us-ascii?Q?eNBmyMLL2xQ9122JKNInsV4OsqUMkVPlubfAWADEgSBSw1T+wp0pJ3vFRZ/1?=
 =?us-ascii?Q?Zq5VK4W7+aN/DvG7iyjDtVbsYcXdqBFBD61aODA/r2fHPRmSIl04inswFod9?=
 =?us-ascii?Q?gmW+2ulGH3DxyumHtiiexQ4EW2hvc0h+LCYYS8c1LWPdT+lHj0W3c5tn3DmS?=
 =?us-ascii?Q?DY5XHR0jNKUAA30lVjVTLx8VeaZFIDiQ2nDHvcgiFiuSLU9125iln/UDNxIU?=
 =?us-ascii?Q?FTY8v4UAWjG6ZebMMl4I4T01DMgzqcVPxjIK6cgnvUs+2ie5NaSU2YRwGQh3?=
 =?us-ascii?Q?RHREuUbb74+qekBGSBsrrMVQOy1RzYoCUB42/b4b?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8bbaaa-0ee4-46b5-64d3-08de2e2e4cb7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 03:29:12.6588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cuJ0lMiaDdmS5kyLUqcquk4S1FIQi1kn9OPJiYIaFXreI4fqndQXej2VB9n1WgJSkRpKpZutRRLtKwQwv5UgLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6937
X-Proofpoint-ORIG-GUID: o21UY2CwzTPRDm7nGwruZc1zzHp2xbYf
X-Proofpoint-GUID: o21UY2CwzTPRDm7nGwruZc1zzHp2xbYf
X-Authority-Analysis: v=2.4 cv=T6eBjvKQ c=1 sm=1 tr=0 ts=6929170a cx=c_pps
 a=tGbvjRCxuxMasaU8K2d5rg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=HbzeB9StAAAA:8 a=t7CeM3EgAAAA:8 a=4Kc5ueXKMIg3YZxgUycA:9
 a=i9oqPCtDvve8OcjLCTCP:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI4MDAyNCBTYWx0ZWRfX1EmRf2lw9CP+
 enleySKUX3kfhzRV+JvzImN6P/p8gbe6f8B6H1JT8axu/ImQB8M+w5xi96yCwc4DxkZXV1saUlf
 aRwG7c9QW/TUAWImZizBjF33TrMvSU0VwSDAC/jllNMDYK6xDWosRTadpKX4+NbX+gzdBfTj0fR
 c8x+AOcq6E7Mw38UlvnhvKinPz90b6fLCBpU0eAP2acouGVYP4Tj+rYA+TpQoRgF/BUSFETxIWa
 F8SNBq87bRoxqkrt5r0VmaLtXUvIjFfg/GY9w7QSdnO+MqesVhet3eBjcjE70xeIDUhAKuOiNbg
 aZ0sFmnme3Ojx1umzl3yO1h/gCq8EESnVEVqNPveTEX9e0hjlkOF2icegsiwBE4frHponN5SMZQ
 zMWyCnoCdnVzV7aX2Nz4PTg2OHln2w==
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2728

Add UPSTREAM_CHECK_PYPI_PACKAGE to check the correct latest stable
verison.

Before the patch:
$ devtool latest-version python3-opt-einsum
INFO: Current version: 3.3.0
INFO: Latest version:

After the patch:
$ devtool latest-version python3-opt-einsum
INFO: Current version: 3.3.0
INFO: Latest version: 3.4.0

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 recipes-devtools/python/python3-opt-einsum_3.3.0.bb | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/recipes-devtools/python/python3-opt-einsum_3.3.0.bb b/recipes-devtools/python/python3-opt-einsum_3.3.0.bb
index 4aecbba..ea9b29e 100644
--- a/recipes-devtools/python/python3-opt-einsum_3.3.0.bb
+++ b/recipes-devtools/python/python3-opt-einsum_3.3.0.bb
@@ -14,6 +14,9 @@ PYPI_SRC_URI = "https://files.pythonhosted.org/packages/source/o/${PYPI_PACKAGE}
 SRC_URI += " \
     file://0001-Use-ConfigParser-instead-of-SafeConfigParser.patch \
 "
+
+UPSTREAM_CHECK_PYPI_PACKAGE = "opt_einsum"
+
 S = "${UNPACKDIR}/${SRCNAME}-${PV}"
 
 BBCLASSEXTEND = "native"
-- 
2.34.1


