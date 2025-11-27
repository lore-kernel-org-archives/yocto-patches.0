Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D194CCFD2F6
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 10:19:25 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15629.1764238765290571743
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Nov 2025 02:19:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=hp6HzBJT;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=34268059e3=yi.zhao@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AR6dlPV3914443
	for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 02:19:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=xa1R7EG18PnltyzjOWQa
	0HgWFphAb8JD3bVm7vumfl8=; b=hp6HzBJToEyQ5tRg/sE8VEWDHQf+4qiFDQI6
	daTK+TffwZ0vT5fE3E1b0jC/xNg6ZwsYEYmEqEGGWjouxpz2v8i5iKffVo0G5oxR
	hGotRcMdVIchSIc17OiPoPvIT0S0AUj250VbBthkQ5ovqwCe6YA0ZI3dRrPOHt4V
	OkEUi9HJ6rUhyB62GIa7QXS6Bxic01WywkhDzb8BZDDfWjgAooAk6y2JDkQ8XzKs
	4FNlN3MVTxfriI/hZPBIbEth66QbVUWO2vJ9SUOcfgtNE7IdneygjZsBEq89mXCv
	qKib8JFgHi/Qpeu6FFpKTpZPisxn9mkv77lR7DJQHn+xY450JQ==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012025.outbound.protection.outlook.com [52.101.48.25])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4akdjjdb20-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 02:19:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUpRU00WaYctrDDqU/oKcim8fYr1PDWfuSadhpZPBDNxcQksBG932OpRpG4OdvhmCE8O/wTU/f0miMjqx2VMT5pWCby0z0cvpGWrAEKISnRhijC9J6OyrHpZrV15CvP2CbD8EPfzqgfoA3E3axBgxyv/RPlrnRUQFjJA8ufENILCvW0GgYl0kCgQkAkoKiE09oLWCjjahbLyfPjEV5vW+yGSZmr1X8KxX7bfUb5w/+nNPEJVqILhJdgpuDKl9tlWTaU4cXF8kKaZzmj6pGc/N6JSJ+KkpWMrGXWrsal/A1nmMGj7ZqnyLPXIQ0Pd0u2SnRnVOEbwsVxGMR8VA2YqWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xa1R7EG18PnltyzjOWQa0HgWFphAb8JD3bVm7vumfl8=;
 b=gHSvyjWKsSWiQGxkg6FnjpSk5Kytr/V6U2XbZ7cWdsqu8FcvjWgqOGziuToxKqorWDg22kK9CODlcLa0bRBHmDAEUqm+A/HMTd8V/+ibRh5xfVGiQFRvNJ21EjwQKGcnjmqmIDOyA5WtoT/V7YS4ByeBc6MWrs3Cb6gSqRNpA591TZZ+ePuyzVtaMjtIw30XBcuMT27Y//8OrP02L9gi15BuPyjowff9yao/3nBcpvNOKH2SS37O0+pN2SeOjqeNImcT0ewpNirZ4cRvTL3JO9E0xeek0SCwTzUrKmbOtdAf5/7Vqgqeb5f+B6kowoJVzPJyZ2ITnDCFDGDCLvhJZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA1PR11MB6396.namprd11.prod.outlook.com (2603:10b6:208:3ab::10)
 by MN0PR11MB6160.namprd11.prod.outlook.com (2603:10b6:208:3c8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 10:19:22 +0000
Received: from IA1PR11MB6396.namprd11.prod.outlook.com
 ([fe80::79e6:58f0:788d:b45]) by IA1PR11MB6396.namprd11.prod.outlook.com
 ([fe80::79e6:58f0:788d:b45%3]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 10:19:22 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 1/3] libmhash: add UPSTREAM_CHECK_URI
Date: Thu, 27 Nov 2025 18:19:01 +0800
Message-Id: <20251127101903.3512507-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0016.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::21) To IA1PR11MB6396.namprd11.prod.outlook.com
 (2603:10b6:208:3ab::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6396:EE_|MN0PR11MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c41d4ce-6094-4520-876b-08de2d9e6ea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Emqj7NvLwobMYGQjDzZ2jGgBwpxaXnsRKR0BRKGBwqeCWjJDdtbU8JKPAx+Y?=
 =?us-ascii?Q?JpTpollfE+XsbhG7cykax9GUKLWKf7QcPem6NvO/50ElMj+yhTdU0lRY5Zc0?=
 =?us-ascii?Q?jM0LaDMFAp9gEpOtsorqkVdUN+/Z0yLqy5QfZJ/I0p8tDiYaSpjWN73b+TSM?=
 =?us-ascii?Q?iiDPavnytBJM4HFu+cP0uPrt1KGMnKKz4y+OUttCspLKwAwGbBMsUP9ZjAAC?=
 =?us-ascii?Q?NUfQsnSkivWp9KNQl9JR0M0b8KnuNwVwkSSf6lnWLozE5jKF9CAfMlTY2P6a?=
 =?us-ascii?Q?90L2UUw2KWiL0IKz1BCWsL5SKc1W++bBITlMyhu+asmRNBrWlsRWyO8OAlvW?=
 =?us-ascii?Q?jQxrwmsZo4guidaiJxCUMGgJLPz7qgNiq1RmxB1pHuy7ifvXngxrg24QUEbq?=
 =?us-ascii?Q?GLS7gkdO9pGlTLvtRhVGeV96j1yBm2Y3f9fEJXXpwDnhZSBbMjvDC+r7cNoJ?=
 =?us-ascii?Q?kfz6RH+p960X70DXgwBt8bDv5OAZwRDQiVNUffYXXwC57rjw2WtY4tVDFmRo?=
 =?us-ascii?Q?DfbCTLPdUWXvEc7gIXgYrhyo6m++soxsClC2AJSSjDRAg9WEo+yQple2GzFk?=
 =?us-ascii?Q?QQHsDuziTDcTT8Pe+rWXLxCECp4S8G3EgijZ8+OK3IwqbbXraSivpG6u3dtb?=
 =?us-ascii?Q?D/1q/ya7cJQ1S+h0giSyapA1BGMJFAsAShO8MBt3zf8uFuUuS+v6bixBIiFp?=
 =?us-ascii?Q?/ijuvyNu6hdF7W1YtBQrYhBTCO3y5XCMAsoT/fFGlS0KJ6iSSmnSvdYxxVL4?=
 =?us-ascii?Q?1ou7iZbBPJKLGmlt7Mcp0FY6o16Jiu85daVBBV3hV9QBjeS5nORAakPgF0sj?=
 =?us-ascii?Q?WiejZGjfkv8b/CIJkQkWpnesQerfPgZESMO2qZRgoIURQ9X0hyKNbhkMVCTs?=
 =?us-ascii?Q?xWepNiM/CWVWIsg547sU9QRJ8VL4GRZ81VZoOqcplafbu+Y33jwmkOgGRC87?=
 =?us-ascii?Q?a32JTXQvaKVpCO1to7V/ifvcxNFoJMfHnBb1XZ5QGvzvphxD0YuG/2O4KPnQ?=
 =?us-ascii?Q?rg4XIy+MCP+adk5wZ5GhHZvTKZC4/FRJUoUTCgpUgJQWkZAT/K4GSizh37Ri?=
 =?us-ascii?Q?UMCIeMMzRrdYL7ruPPSZPvOaFuq6TQvesT74Uo1pt4fGaPO8t0VUDlODNP97?=
 =?us-ascii?Q?4F0n+bekQ843+ZzKX7ZRhN5efvJW5mSko6JfNm38LTpDX3koXaT9ypi7EBjJ?=
 =?us-ascii?Q?5/n1MTqDzC4QadGfGG0N3ouyM5HnzVmJ5Enwf4DDjCj7MMXX0KY3LBflEONi?=
 =?us-ascii?Q?ySwf8Ujch4p5VMa1ho/hnFa9Syl0fVMYRbExBzo9ekGVD6tPrg7d2LOOcr4Y?=
 =?us-ascii?Q?QFDYCktoyz5BorAAAwxQUlCUncVHBA2eR2Z9uCT23Cwad5/Ti/budAXOjJmQ?=
 =?us-ascii?Q?WMPatB5DO0uAWxunctH+8hDEQbW6fSRG/R7NPpxmxwZ5BH4NGe0mmJQ/yUd9?=
 =?us-ascii?Q?0btOpmS6nLVxLP7eVxXMsVtmEfMm6B/2ow0LYb4yz2dEepehYp4xTBIFS4Y5?=
 =?us-ascii?Q?kfSNfJdc0YN5KVAi1xdfzDzxsnULwyM/pNry?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6396.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1IquGhVZg0wAklGZF2ttS9UF9N/dK4nisRVNyPlokW3cQIAEDyZF0EEw0WCE?=
 =?us-ascii?Q?ZX96/zf4iiiZT1tqCooZgKSkoaB8Bwzda3mKDLaofE27VNaEdVA+1sk0hOBP?=
 =?us-ascii?Q?SZn89tPfT865LQSpEPcAi76zKpxsVq5OiBMDCYJo17IZ5Muh5l7KTNWMttc5?=
 =?us-ascii?Q?pkW3BU1FrLVYWBjm9EHs6mnhwCfGmViyg0QywyBsOyejuXowzG7qRS31r+4v?=
 =?us-ascii?Q?TZdnI5c3jq8GDPJYP+w6AWDK0WJIfk7lQUP7QuPmQe3oatOm7NFv2kueczy0?=
 =?us-ascii?Q?jPM2YdS9gPp5b5H3nf2DumsM7OAH3yKcZleERtlfobz11/F9OsWnL3dCjAun?=
 =?us-ascii?Q?sMXWIacTKBIEwDsjE75ATBrAZTkPuEP3Yc/xaa7NFGsoQSBqEtTnVOaqUI+J?=
 =?us-ascii?Q?pAc7HTShyR0KR2t61wne4KpckSl618X2xygPj0ns63/EmXf1+49CVWEHzAE7?=
 =?us-ascii?Q?td1gg3fA5fSuTjx1k95wRvq+/McNe1XGq6yg+JZzWSR4KnqCIsDPwF2DVwGj?=
 =?us-ascii?Q?pLmVl0aK4HbhBlhLKw1reuWDNcheR0MySlE3B6+qxji6P/0LVvn4GsybXFf+?=
 =?us-ascii?Q?PbStFuAEz5wYuo2t4s9klzq86HcxjS8yJybki/GVJe32lSp8S5Wtjf05gQVS?=
 =?us-ascii?Q?aKLgJZ/iUuXWVTYKsctutmCUwbrIyn/R790vI1IgR7N7UEKulg4hQ5f2C90h?=
 =?us-ascii?Q?U1RJNmKGlgq0PahAzRzG4w/OyIUvuoq+pFYMfpkwu7rzXl9Fnh/mdaLyoOU3?=
 =?us-ascii?Q?wP0qnVxwzLgPhqpuLxTKbTWJ9weQzchzb+pv1LdCa1DgcRU82svalFqm3U0x?=
 =?us-ascii?Q?oFtITQSickKPfgi08kyS8joSSVwZrApPyTXm89rmgwRUcAagaPNqnWbEI0gx?=
 =?us-ascii?Q?mLNsTsqTKgSq4tBRgPwgsxrCHhCusFkNAWm+1zlMQCpmLaA4xpvgVein6eee?=
 =?us-ascii?Q?FyYZchLayAppmCzSXebs3cAxMfY3tad+IHXbEESPaxZJK5Kg4LH41TSfZk+E?=
 =?us-ascii?Q?+j0ZEuB60w4IzUaKlt02+O0ZzCQuFmTz3X7MJpVE2ho1jSu99Yv5y78aPjeS?=
 =?us-ascii?Q?DcArDJu74PPUNrG6bl+MkcbVK04lKdH5cdx8iOrycoRtgOul8qvADliiLxUn?=
 =?us-ascii?Q?ANK10nWYoK5faYyDA2ZfbJuxF69G1J02nfTQ68trQG9Ir9TiLXGm/q3Lwyrs?=
 =?us-ascii?Q?BA30McGIFSnUqiayf/eJR6CFcT6qn4s1TDtsyKBZ+VuAE42cpewBGbYjf23f?=
 =?us-ascii?Q?RDf0HSdvz+Q9yFGsorvI9BT/Fs/ar+Gq2OqwPQTKpKC08VvwnT1ENOMeEDzE?=
 =?us-ascii?Q?8yFjFqnSCqppbCjLB6+tcEUj39Qv48/kKxuCm5TaWp+dvjIZELLbgwGE5mWN?=
 =?us-ascii?Q?q6d6mwgxtb3bBl9GiQ/S2n2+kN/689n4Oupa40g8xKoJfJ9c+QXJUmBQm4j8?=
 =?us-ascii?Q?wPzfwN4OG1xdM9hpjJOPCEO0s6ez7yU9+jEoMJs9S+AAbpQ5lzwuvFYG6/Nf?=
 =?us-ascii?Q?URQ7MM26EJIJaeyx9UPrVhGOP3s+O8t19rOYZ5zwMfUND36F49h/b3DcJlSG?=
 =?us-ascii?Q?ZbX8TWwYH5LhsMG+zMAwGjjErdJJ1sEmtadb1+Hl?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c41d4ce-6094-4520-876b-08de2d9e6ea0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6396.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 10:19:21.9991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HLOSHcAC51uGc4gbBh2Ub/MoeFNqr3vnNxANoZRwlzicYv/Mem9eF82rkh7CpDS0OlHAYX2KyQrNox5AGGF9Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6160
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDA3NSBTYWx0ZWRfXwd7vjre3FmbT
 tW4ivTchvy6O/r6ElHJ8mDO7IKdjQaCUU5OSuWDPprJoJlv8j9DKbynZjNzPC/TgTnb1wuICW1f
 PZvsY3Yk/3Z/rp6TWdRE4Eg5Oa+bbWRW+1BuHmxwgWZHBroExPaey1jbDNIwFowGqhJA2g4C4k5
 FGVPRJuU3iJSWKjQUB8Dgq6Jmnho9Kh8Cx7g6jDpcjfqedMGc1gu2bpg/IpWhCzgQVy1CHhpcOu
 giWZOqdgGEkYWP+eqb07MjIww9065Ur33Nic9ZdKakiHkwb9/XjRWekkeRG8fDx6alc/dekOlqt
 IDSBzJw86va3hnuANyJfMY+oMlgqQOCWjWXkVKjrVEbg++Et6HqsaW81NyvzKe+C+2nGE6+UP9b
 FoA1DA+Rc5wQXbUf0u2afKd/Swf7gw==
X-Proofpoint-ORIG-GUID: vXpAamHKTlPdaJH58MhuRVJF8NprkJsu
X-Authority-Analysis: v=2.4 cv=Wq8m8Nfv c=1 sm=1 tr=0 ts=692825ac cx=c_pps
 a=fLgsFiGMcCN2bMhaTK1NuA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=FP58Ms26AAAA:8 a=t7CeM3EgAAAA:8 a=s-qCe9wGu7Z9lr0FynkA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: vXpAamHKTlPdaJH58MhuRVJF8NprkJsu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511270075
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 10:19:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2713

Add UPSTREAM_CHECK_URI to check the correct latest stable verison.

Before the patch:
$ devtool latest-version libmash
INFO: Current version: 0.9.9.9
INFO: Latest version:

After the patch:
$ devtool latest-version libmash
INFO: Current version: 0.9.9.9
INFO: Latest version: 0.9.9.9

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 recipes-security/libmhash/libmhash_0.9.9.9.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-security/libmhash/libmhash_0.9.9.9.bb b/recipes-security/libmhash/libmhash_0.9.9.9.bb
index 805cf05..7c7fb11 100644
--- a/recipes-security/libmhash/libmhash_0.9.9.9.bb
+++ b/recipes-security/libmhash/libmhash_0.9.9.9.bb
@@ -23,6 +23,8 @@ SRC_URI = "${SOURCEFORGE_MIRROR}/mhash/mhash-${PV}.tar.bz2 \
 SRC_URI[md5sum] = "f91c74f9ccab2b574a98be5bc31eb280"
 SRC_URI[sha256sum] = "56521c52a9033779154432d0ae47ad7198914785265e1f570cee21ab248dfef0"
 
+UPSTREAM_CHECK_URI = "https://sourceforge.net/projects/mhash/files/"
+
 inherit autotools-brokensep ptest multilib_header
 
 CFLAGS += "-std=gnu17"
-- 
2.34.1


