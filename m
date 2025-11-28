Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50D6D116F1
	for <webhook@archiver.kernel.org>; Fri, 28 Nov 2025 03:29:16 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8272.1764300553552434241
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Nov 2025 19:29:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=Atn6sAHo;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=3427ccacfe=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AS2dAnt3127853
	for <yocto-patches@lists.yoctoproject.org>; Fri, 28 Nov 2025 03:29:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=oSAgXDCIlSAlnYywR1Ld
	U8OCRAQPzd9D2xGphfBXiDQ=; b=Atn6sAHoFIH24PLETQnnMauh3r5//lmAMKlG
	178OT3LPLyL6URg0NOsn/yXs+/oeozT3z4oNJDWme5DmYGLSPpudN8NKdqpj4eP1
	XBVXo0zBtrxivPYg6Cmf2yJ9ZK1Y9rktLdajkwGIBG9AeGmxQwYG8qjNrSoprLL1
	eGedTrfNqbGBqHpSnF4aHKmAN2heQEVtqMojKKD/OEwCvSSwFWS01E1kqoTSWG36
	eKUQc3fxBb/NTwjw+0vffuS12LnRVgI0HK1CRjytS3Hvvuk4wQg2jjSoJnWcf1OM
	aAUd7QV/Ff3EVJLYr4K1Orv/aeQFzO2/OQHVUtOS6w3CcZxoLw==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ak455pfmk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 28 Nov 2025 03:29:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5vwkl+fm64imW+3v+wvwO04uecCZNmmNtZfQGGNYUafr0iiNBXyGuJFuQpseMhq7xxNn6sr3LTs8mciyPfMwdqNwvevuHiYp+Ig+FW6IpXgy+KZ2ffKpWUxBD8L3zCe41eZIb2TtZTVtJ6Kf/+UWVSxqXS6LGfvjiQUHuaoytyIEadxEvxnGSsbLQ4ofq0gvtfyrl9SzlV8zAHd3bwZpvw1/W7/s99ALJ3ksSDDX055/DqBTPkpjkjLxW2M5gpIMdsKlDouGIgFLV8N09mAkBvCx8xXRnn28WRYe9F2rwehZ02n8DXH4F00mgQDBQ7yDyzZrqnIgqnZKAlw7nIBnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSAgXDCIlSAlnYywR1LdU8OCRAQPzd9D2xGphfBXiDQ=;
 b=CRIRzSSfFQigZY0c/yFGt4hKsAf3WBAQ9AA6zxV8KaYq+o/tHXwtnUvQrAK5loJMITErQIWGhmXyafarB4OllNCDAXFwJmRG5NAc3jNP30buufWewV1d070SpLXH169jlwsmyAgbI4RpHqxL8oi2gAInep48d3glWEXHzzlPdNS5ua0eML6qJj7ohV5KMW0AKjnBRGOAfkKF8gqzRhjNz2g6aBbsXni4D1mNoSYhp8DPU6+0N2bAlQhRJVYynejfAMKCD2TA/Pk/KVhs9QfgKPlrYAAApDi4hmPlhAai9NROOeh4PWTaN6yQrbELbEEhgzJ5bKdxzhFm/XMkkp8qQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 CY8PR11MB6937.namprd11.prod.outlook.com (2603:10b6:930:5b::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.13; Fri, 28 Nov 2025 03:29:09 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 03:29:09 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org, hongxu.jia@windriver.com
Subject: [meta-tensorflow][PATCH 1/3] bazel-native: add UPSTREAM_CHECK_URI
Date: Fri, 28 Nov 2025 11:28:47 +0800
Message-Id: <20251128032849.759822-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|CY8PR11MB6937:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c4715a-1961-4373-f873-08de2e2e4aab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?JK0+vpXC1mDeftWo6H5rHYZxZFgUKL5UDj1nvODhtVh6OxV2jtEn0Ed7Zvrb?=
 =?us-ascii?Q?Gy6N0li+fFyx/28aa+OXBgM+y9vdxW4BaH6TsUn4F2gAOtoqYyy+s9ww+fpn?=
 =?us-ascii?Q?x50sLKEj1Q2nJwVvm/+d7QGLgBQEzu4Gd+0ZivY4Mp/HySry9t4DJcwLVGVi?=
 =?us-ascii?Q?l2unISF6nEObuixkEYuGjSTy4CbRu17ZBqlDFIo/rNl8WqusdWMwH8HmhLY/?=
 =?us-ascii?Q?/VydKzian9Sq1ZmIfPHCKbwSJh5mqOxNaO0NG2x3s7k+bH7TWmzj7WI/Ge69?=
 =?us-ascii?Q?m8hRTlkKKubOr1FHxTQY9AUTuiU1g0x0PO2u5c2iPtdCZZKOY/LXqu5qAjNz?=
 =?us-ascii?Q?eTcr3ihzpcRGxZpq429xEe738b2DXESnilHP+nYDEWNqN7XMhg+r680vHak8?=
 =?us-ascii?Q?PR4H5iwabdh+QUkVnOI/t+X3Sp+wjivRinytkUNt1FvYmMlnQcPhQrxph6XK?=
 =?us-ascii?Q?Mt79e53VnhTnIBU3HB2bSdatmF6AtGEnXYGzsCXS2CdQC4Nf3WUq1phom1TZ?=
 =?us-ascii?Q?T7GbNPn2LXVd4WqD48BIoezgGFCw4ZZ76DJySaGqLrCZUSfrlYyPHIfnIq5S?=
 =?us-ascii?Q?LVOqZs1bjraAtccARqML0RiZ4yqGVR1Heqqc6VoND8brQrX0zTlVvWHvMRaq?=
 =?us-ascii?Q?7ZqMLsSdqVAqyndV8SaSj0LE2+Zs9GYFZNv2dUXbrZXxI8x5CjPDTkwFpTeh?=
 =?us-ascii?Q?+1yevVBgICUgfxeNb6BsL5ZPDSURWSKAWnHMv0E3clzA+yY4TVN0DLwkahVK?=
 =?us-ascii?Q?IIQg7GmQ3vyp11pQQ8uiVNLcgOnmsMdnpB1GvD0jWLgCelDNt3d98MAqP1mp?=
 =?us-ascii?Q?nZcz5iGQfNYsKulkJdmj8325grhVWy4DITrmCSKJelQaV3vnuk1DMnpRna+Q?=
 =?us-ascii?Q?PIHadwU3/XvUD2FsWGzZktjbr/VyT8rXseNtLP32vpg8B6B689zvEav25cxy?=
 =?us-ascii?Q?HnJ9KmnZ6l7zMX7rX93YbZ0tww+D/4m9Ym8KY1qJf8OZCrdsMpRhukm8W66G?=
 =?us-ascii?Q?D6ai82tKdYhm+axEazpDdLMvZHGRZfdccOP/aIVIi/6KFRifBiQ6KOjxj74w?=
 =?us-ascii?Q?MDjBhD2C8ZR5XJMlw+0wAGvRE/O5i/84IriRUOdrPK7rS9GY0n0i7aOgpYdN?=
 =?us-ascii?Q?vc6kUT6O1NM37wVUmuGUYyfll/5nIls6PEIz+MhFVhWv4sQyJ1hJBMsSNcWt?=
 =?us-ascii?Q?w5VFHqSpAG1yOnMSECOpVEk6v1d5L4cm3dNwlxg9VSIhP4wjtgnc1KuXVBX/?=
 =?us-ascii?Q?RaTSoyiSB02YAVEI1Wi71gzhtP4gQ1pcgvYDgFfZ6gzo0POXlRVI9WrR+daI?=
 =?us-ascii?Q?0XZwrw2F36L6QpN+e8K6dfZ7ruw62wmQE0E5lK9b9CmGHg7+iburWnXP07qy?=
 =?us-ascii?Q?dsgJTqLdV7g/klEI0nJwCILYENQYYLFRtSnOTFafZfWshNxgfVSnE7BYW5qS?=
 =?us-ascii?Q?pQc4L6UoBe343RCX32er3E630hgblE+D8V0XfNuyRpo7jv62Hsv3P/F2KyBa?=
 =?us-ascii?Q?KuhQOL2EgFoKjEHpV8p5i0MtCRqRKGN00JjL?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?sXIfxQffRSp6qzHou12WLApRwBCvCtta9MuOVI8kpqf6OvtX9RoZ2J3xDGl3?=
 =?us-ascii?Q?LT2S7rPEYdvUh6502aGBudWxeIf/fC/b4HHCsbiZLpNGMe1yVMMi/0QPMtJx?=
 =?us-ascii?Q?zs/VL49TSBj2ZHbqKP/W8gvmD/3Tv/kw+lytuZMYL9RYAuryP93aKX2K5XTv?=
 =?us-ascii?Q?NP3FfDAo4rTZOXGjF/OjSSvk8T51tNtscqe19unJMU7sShfhZFr2DWMu4WKr?=
 =?us-ascii?Q?BW5W8/zdHzIi+C17KOJOcup9EhCCkHQ/knYJCMDB2pF9OTZiio+SZepS5m3b?=
 =?us-ascii?Q?MhZBbK5fTeJw/DXG+fQ6vkcMrkxc1XHKKKiKCJYbV2+cuo4ZkAl7BqNolFkM?=
 =?us-ascii?Q?/kw4f6kifZUSQCR1ZIUHwt4auPlbohmmixjxkOTk0L5r/ON7B4M1yvIZCUue?=
 =?us-ascii?Q?+WBVR08HYwp0Vg5vylpL5NL8qDL75FX5T/GZXxt2Zv6t1DER6D/Fu1/qr5xE?=
 =?us-ascii?Q?Grk1iqdYUGwjNq7tcEOCitOLp8VfLObzKoBvxgLeetLC8TZx3S8faimfIkau?=
 =?us-ascii?Q?mvBjxOcuFnqst7hAyelODTIuLKS1EFzNrzUIqJkfWXUQQaro9j2iaqoCQgl9?=
 =?us-ascii?Q?D+OTgqIzXm+da92l9OsQYmLcsZjP8W3xRWOgD1Xqml2yKfUXG6CnJC2Z2Hxn?=
 =?us-ascii?Q?84B5B/m5WfQm381Yf/o/qNvD//6vllivXPSvllG1VvPaD3krQJ8FwhyW4uHK?=
 =?us-ascii?Q?PAjm8Ebeoa7GOj+1dJen1DpWXDrbgbKy/nugT70/GhMLQZBQ5I0mHJif5Xmp?=
 =?us-ascii?Q?KHrwE02xtnUuEZ5x6qHCpPexA4UwfpIPQ8QVzLqtzSw+I5/IyObG3Jc8VbuD?=
 =?us-ascii?Q?9pPuom7A197ogxDAn4RYL1Y3WJk6UirFZqwdGeqReLYBM2G5wq/iI4xzPBYk?=
 =?us-ascii?Q?lXxROsa1Zu7EfxgkgN2OXWNzLNuebTcwRLCRl/rdWm2VozHqB4+xH7NoEmSO?=
 =?us-ascii?Q?kdNMNL66RbzOSAN126kBGFHIfR5kNAiPBtWhvJQp7g1+CjC2Uc6SOjUNPPEU?=
 =?us-ascii?Q?WPCC8kWzRzlhdc9P9QX48Bd51A3cR7nx4DrA62I8yagOYPH5r3Zh2gG67TI/?=
 =?us-ascii?Q?SmAHPmdbCbWi5+N2kijAp2k+1+/b0bqIIQRWIQV5uhB/MVl9j15HUfQ6P9HJ?=
 =?us-ascii?Q?XrparmD9hry3pZ2MNqL4jcsAegjEYkA+r3e/nZg/ge4Ea9gKotIiNoCZ6eDr?=
 =?us-ascii?Q?AbPf2ofvp2v3KAifVSQ0oHCV1r45DB9M/X+shoZoOaEWV++XWaZ57+GcpWBS?=
 =?us-ascii?Q?Y1gl7qOQagnTM82eI18HgztSBPw0Bvqr3TZpncvsbe4A/05WfSLWJZ2QBu+g?=
 =?us-ascii?Q?FyJ3fLpYEALostzk/aQmfXNWb/3hykgA3rN6JKx9SmLvzMA2QU5hOTGvVYHd?=
 =?us-ascii?Q?p3QCUiyU+yUfIzqmjKE3WANkTMPT9z4ecNMjUqF45E8dA74hT4XgCJyJnRHC?=
 =?us-ascii?Q?G4Hn6WI3WdUh1kowjPo/bLpOO4J/cMbVTP71v5gQbXPltuICTBO3VVkl6RZb?=
 =?us-ascii?Q?aigvZwAtzhvKq9OBQjhRcqr9r3vI40TdOE8F8ZIw/0/GoA8JFjXJxILUFdTP?=
 =?us-ascii?Q?64mr8MdB5Pc9BCRN/naTwtNHDrQ6Bm8BJfTPHUbr?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c4715a-1961-4373-f873-08de2e2e4aab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 03:29:09.2569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GsrRt3nk2U3JZaqxw8d9EEF2NVwUfySPWDFq++JFlDMkYPipgZPnr41UOGIEZTWzgWe8bY0PWyZQunmCwkCxPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6937
X-Proofpoint-ORIG-GUID: JmhWUWo8z0t6zVTe08Ufx4BIOZqCBLft
X-Proofpoint-GUID: JmhWUWo8z0t6zVTe08Ufx4BIOZqCBLft
X-Authority-Analysis: v=2.4 cv=T6eBjvKQ c=1 sm=1 tr=0 ts=69291708 cx=c_pps
 a=AaT4FrH4hTNSk8p5YcQWtA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=t7CeM3EgAAAA:8 a=msBlKZ8s1PAJo-JRg_EA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI4MDAyNCBTYWx0ZWRfX2SsEfikstP3k
 QS/gjEFBxZh080gc3EkQz6KZ8/yfpAkSiYYOhhOpFRHKxZZat35usBrNbvbMreO521dXlX7TOIJ
 MLViuic83gQJCC1xMwyWp5EHgBpUZaMBG6fP5m4tw3Me7K5Y9fxYul+qWVPVwtvJiLgjWfPtQ3B
 Q8aPh7kx1v1jYAN47mLVtdudIV8REPvq1yATfJBzz6P609d3Q37bprJYpsPy11oQbaReYomV0Uq
 1xtioUI9HutXHja7AuDYYdXxIg8KGMLykie73EI6ICxv2oaqDz/JWHvaa5rHZR+qcWSNudv0j3M
 QIuvsb5Trq00MW+RTyEpoFfVOKBlffJpXQg8+b8FJueCjJW6pGjUncZ7KSq85JRs+uSLmXOUJGB
 rjNwselNLWOrtxT7v0e/JBnR/Y4d9w==
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2726

Add UPSTREAM_CHECK_URI and UPSTREAM_CHECK_REGEX to check the correct
latest stable verison.

Before the patch:
$ devtool latest-version bazel-native
INFO: Current version: 6.0.0
INFO: Latest version:

After the patch:
$ devtool latest-version bazel-native
INFO: Current version: 6.0.0
INFO: Latest version: 7.7.1

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 recipes-devtools/bazel/bazel-native_6.0.0.bb | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/recipes-devtools/bazel/bazel-native_6.0.0.bb b/recipes-devtools/bazel/bazel-native_6.0.0.bb
index 4960358..12351ff 100644
--- a/recipes-devtools/bazel/bazel-native_6.0.0.bb
+++ b/recipes-devtools/bazel/bazel-native_6.0.0.bb
@@ -15,6 +15,9 @@ SRC_URI = "https://github.com/bazelbuild/bazel/releases/download/${PV}/bazel-${P
            file://include_stdint.patch \
 "
 
+UPSTREAM_CHECK_URI = "https://github.com/bazelbuild/bazel/releases/"
+UPSTREAM_CHECK_REGEX = "releases/tag/v?(?P<pver>\d+(\.\d+)+)$"
+
 inherit python3native
 
 INHIBIT_SYSROOT_STRIP = "1"
-- 
2.34.1


