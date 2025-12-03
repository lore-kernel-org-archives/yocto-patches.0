Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E9AD116F3
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 05:22:44 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8267.1764739361321181615
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 02 Dec 2025 21:22:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=nNbzhMuM;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=4432e9699e=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B35GCHc2544174
	for <yocto-patches@lists.yoctoproject.org>; Wed, 3 Dec 2025 05:22:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=IE4qrV44bhsPir8e/Lnj
	U1ctULeOgnntzn0N2JvwT/Y=; b=nNbzhMuMDFlRYsohl75GZ24clIoGWFLbHbRM
	m+8QG5XtnoJqM9RMd6HsvPsYegrm+z2JWXgs0FZNbDx9ILFdwEJ1kCjKsYiqcYlP
	h74KN4sFA2uaRn+Q7M1BLsM5z+L5fOV/rg+ROHl0iOhFqSuvH9ENFsLNwd+DgFMb
	NFNZOmwM9IejkjEfG22UfrCQxEBRJggxuebLhDWbURiE5XCmufx5n28Eqx7fGT/J
	0aBW8PUom4kKhGozFuROz2uhi/9tFBZHDDLULewoHr4I64y7Pi9ENtDdAjpvwRyv
	kr8X2VL7xAym547Vs7E/mvuX//jrhHxCSdn5d4H5H51hoFRTKw==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012031.outbound.protection.outlook.com [52.101.48.31])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4aqqt6cc4q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 03 Dec 2025 05:22:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O43XpTZw0rQG2MO+GsXJLeJXTWBXQH+OjOGoFx+cuNdmNfE+8eggUC0nwow8m0YmuCynC/QXoSTxOfc/m/yeIjw1TDI8ZWXqA4VmLa9Id2G1Y3/z5xlQBCEwASojJotYuJnog6lN0NzMHaYzm1/AvD2xUp3xdP+5HaB6OsFexrOV0akFKg64MxYl3inVLZWJNTOMTuas95XJux52S5wu3703RcjNwBWYvAotY+/59rtu+yuVdWD3CY8b5KvaHCuoV3rQwLLAztsnJPSRfW82ouG2DbsTQoEfY6HSJGsdFyWlT2WXGynXjSFJ8HJ7NOzz3TTZ50FHmDlW2KgP+LKaNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IE4qrV44bhsPir8e/LnjU1ctULeOgnntzn0N2JvwT/Y=;
 b=WqQsYAkm4dzIOpI9lwL/6WV/4nNRfybphjrLRs34p0wCBnXP47GhyKmUBaBODXETamF2sfqRdspUX0crBg8j2kV7axmxvz2ckFkuyH8VQpqVadFbo1JI8yz9cXn+Vz/56Qu2sgUqXcLYni5mHMgZeyO4ffUpLlJYqLsT9+8I9zI1Us1sZJ21eieGbsT60KbCXgsJW3NSiDqX/0czyWSK1Mtcz7oEocnOHCpARUdB4gnTajqwYHJ9/hQnQmzh/EjY0q1z+yZCBrrWnSBfFhwZV5hSAo4NqKxKLvmzhHJRqTZ05AvfOreAsfkq6Zp4ojUW+NwqI32ymszcPwkbUriHBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by SJ5PPFC15A51B16.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::851) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 05:22:36 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 05:22:36 +0000
From: Qi.Chen@windriver.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH] config.json: add x86-64 multilib SDK build test
Date: Wed,  3 Dec 2025 13:22:23 +0800
Message-Id: <20251203052223.3251326-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0060.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::15) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|SJ5PPFC15A51B16:EE_
X-MS-Office365-Filtering-Correlation-Id: b209efe4-bc8d-49b7-7ed1-08de322bf84b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1fqZgBctWvCk6F4SmAqbGaN3YF/RyWnuzdELBHrQNxswem2uu3sGni7Yw1t/?=
 =?us-ascii?Q?K0cqqX/Y432EYuZEK3TL1yC6k6xY+7qursBcj59Nqvr0wF7amRvkFKMwGfd+?=
 =?us-ascii?Q?2G5cKtAm1H1ZC9nzSYMC76Ot41WQNv/KHfVy4eY8s7KWhpjX7PWsQVPJdvjR?=
 =?us-ascii?Q?cNWQZTpewDAWRlvIPoXsLyKnvv/V4r+jUmR+KVEp6LEP4OxKWlosp+KgN3OW?=
 =?us-ascii?Q?8CvzjVBXoZuV7f8EzjZzoI9kCkEZPxkahaLB0mO2VX+MwISJLq8UCNmU9tXa?=
 =?us-ascii?Q?SXG3LOl3Zm9OXumyoXrORgFxqcmkErOhLuKWMEBvrv37SGd2i521MBjgYo7V?=
 =?us-ascii?Q?aXX40CaJV+mUidIWcjEM8sv8TsTwKxfanzZYxJhTB9p4F4yp01j9eYmrIIb2?=
 =?us-ascii?Q?DYkTKCQcZfyutOBf7tFo65F9a92tNLm6JvDF6m8IrUTsYdMSW0TIW0VRz2Hg?=
 =?us-ascii?Q?lEveE2KwqbEfZfMlXtCnK+aBmJ0cdAIoS4an8LMnHAIP9Qcigqx1uEWLYkzf?=
 =?us-ascii?Q?V07IC0l+c/e6YvNxcrnYinYMbf0C4Pi0uCpSWFffkO550TG2xkkddBLGcTV6?=
 =?us-ascii?Q?PSSjrqS6c6dWp0HCLLmN6RWaLvUEdHA5fP1dXJQZMPn5dasRpH8bwRuA1kF2?=
 =?us-ascii?Q?3AR+qg7+W69nQxmRUh9AA3mlXLmSZ238TwKv2DVhto+UjlSxrEVo1L9UjlkV?=
 =?us-ascii?Q?bICxm8SdcvzZ7P7DbNK9bJOacD6nvr2Dvg5oUZ6gAAMnEsjJprEj3qqcEneY?=
 =?us-ascii?Q?jUHYORlUE3kv69YX1vVkQON/Tmg83QUyoZi5map2e2UgN3aSjisgpUmDNvm/?=
 =?us-ascii?Q?a+EpIDlmQ8YGbRCbST+hBr7C9M4EwCl5ZQfFpd6diaWdoS8+JgXzadPmYNv/?=
 =?us-ascii?Q?nq+mFS8OQuvS5cwJdYGOX3IiG8DOdK2cts2DpMbW85pzyYV0Ifx/vCN03x7L?=
 =?us-ascii?Q?sTkmG2JvBMCO1Z9d/3OOgx3ahAk2M00woeIP5lJs6C4jWxWluuEW/pmYQwbR?=
 =?us-ascii?Q?2BvzujZrP8e9e795SXpbjC03GLRkfwLSqPPWCWD6DpmIQrr/TmJeGO8JtTzI?=
 =?us-ascii?Q?40jsLUrZyDvDEG35/wvRZ5+EzrFd4hrgeOTVpc32BPRI45WQ5d5TW/5EW9gB?=
 =?us-ascii?Q?IuqoTAKzz3dixRXn9g3NtD4y8jbB/uWW/Sn04nreGPxYg2IOLZvbk7OE+JGV?=
 =?us-ascii?Q?bvYcTwmNIHOIVa66vPAV9ckwsxp8rOJ7rXHr9NP3DBVY/FeHz/uXeQWZTFDd?=
 =?us-ascii?Q?rxggZ5eoR4LMP0JCx54lc5kYnPWmNJchF35KZasEV1ls5ZztzuQNtF1rH6hs?=
 =?us-ascii?Q?M3Z9WfP6pjiuv/0Uj8K5XTGJJWA2PKdffQuBPrukKvhg1ZfsOot051nmHrwz?=
 =?us-ascii?Q?1evz4OVoQLnxvNfIIEc0RwNxz+jlVz9MtVly0bYmCDciE3Cip3DcwTbPwSHC?=
 =?us-ascii?Q?NiuYOlCV5fImpuPh7xkk9hWOjeRn2Qk18WWsyykt1XLdrGmo1dHOppXNm4Uu?=
 =?us-ascii?Q?W1roKGABO4jS+rL/ooUM2D4C2HULaKnfXVY7?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KqaHAHWbsoveIizvrtEjCGS3tuPbkldebOcgEqaOVgqxwZtZwvEwrrgT/WQk?=
 =?us-ascii?Q?emQJ/xIUvG6cEA7pNlj0rj7vX7qSvrb/Grb0UQFr7ZpGXXlpjAWllRByWl69?=
 =?us-ascii?Q?xBvxXii4oC+5rXSl4k6yxYveMojVf8UrjXLfwLOKPgeA03d+7HIeRH0m91io?=
 =?us-ascii?Q?ORG8rSutBw6JY3K+PDguuwz7ux4to4CcvDUcWvfu+eKykp/Gs00tXCzzBIX1?=
 =?us-ascii?Q?P/ZMdfa3OAyEK0ohksQzJKG/17JnN5+wmoQVUzLsJYkKnsop9pWzJCMEhW6k?=
 =?us-ascii?Q?7fsStApy4ebTlz8U7Vpm4v/lWqRbR3V6ZQ3Lzf1i/lNIptSnVdF8VVs024C0?=
 =?us-ascii?Q?Q0hApdayftFCaYs5zvxvwVmCxBlMaK3AttO8T1xHzDkcNbjHFZG6hpvCgtqY?=
 =?us-ascii?Q?dEN1Pbgub6teo5oj+psmXx5DjC4+KXiTMCpy/wHF7t7Oq2Kd4qZqYPXAWut/?=
 =?us-ascii?Q?POxusPmQ/2XSdwSA/DPXmfAyNJ9hkHXNqKXpf1Zjjno5R2YkGCdT9b2B9IEO?=
 =?us-ascii?Q?lZGMr+wWngaqHyiMKIMoamIxaPlK4C9a9SpcZ/t2nPn8rRBEtdJMLwAp88YW?=
 =?us-ascii?Q?zewOSKYNva4IwKLcls+47kFZjvlwN9F/GpjD/5YbFaO4SvCIUYo8GRnJWLWN?=
 =?us-ascii?Q?Po1jHC4G+Vt0ch8SjYfFnsyyyONxULuhYBNX3FCq98VRRhM2RyVkABqJ/gPc?=
 =?us-ascii?Q?LCsaDJQJshjAY+95pgmRcqnFzDaopEi6YkNUCVjwitq3my2I8MkCZ9h/7pg5?=
 =?us-ascii?Q?ZWVwC3aPuasBzciMt+8yC+nXJViKDFcTn7WOXGdNRvC+QJD/lejSOIF7ipOu?=
 =?us-ascii?Q?zufetrDAJ4IHH1MGYUz4hs+XzrR1RRWQnVf7PXD2DVTr+aDmnx41lI5N3EXW?=
 =?us-ascii?Q?dNYismy1WtP3+GfltwbxsobhpOn8CTPJ52Heop/Hmpk1B+l8Trj5dBnYfhcD?=
 =?us-ascii?Q?Im7ZIuYhveGAhH+tuBaqqlA752W7EFsKaA+z8ukNO2W8TXlFoOvQgmM4D46D?=
 =?us-ascii?Q?qsxdMQOEbcnmjVpB1MdoK3vH4M8JMhL3rA7NEo9kdp/yZZjdti1It1HNi63r?=
 =?us-ascii?Q?j/eTui8bLIiGOiMN5jZnOkR3YlpJLQiinWABPizkxNo48w6wqmqZLdX1swO3?=
 =?us-ascii?Q?w+mjGu/mxnUNRFEwCYM18dJ7UmCtNVRLOsqw2AYkzNv46pxOX4IpcddYWoYs?=
 =?us-ascii?Q?AMpdqkTQZGNv18qvAc0a5CC6Q1rH1Xkn10NnZTUYXe+ljhslY8M3qQRG95xP?=
 =?us-ascii?Q?KdxfaRU3/pUljSimkdxb8a/8oqKo4/wcizpHCRB7Z12M/TGdE9JIo57/Kzj5?=
 =?us-ascii?Q?+H9kfoiuHVYF2+swDBK/EqGAAbA9+zSGpZx/NxHmJp33OC1T+VP8oSIuZnp4?=
 =?us-ascii?Q?V7GCTM+vj/0GI5gL3FpvQW4H8AUpoORVan3x4obvTGx8DkwJCNCVGN7xwVkr?=
 =?us-ascii?Q?mcV4U8qNWT+dlhoPbBplh+JFexo3vPte5SalDVVV8dbJ5FKv8C0ksXyLsAJ8?=
 =?us-ascii?Q?YpNpiiIGfKzrZUueKyZHV5vQwSi2IUsU9Qw4kpZfVUwLAqvbEkZlhqFPiPie?=
 =?us-ascii?Q?PgKbw+MG5+q7rbr8b+56gyTk3UxKj3c3cWpckTAC?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b209efe4-bc8d-49b7-7ed1-08de322bf84b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 05:22:36.6588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Cr/rpYb9suGC/U5l8aDWlro+qDBuXGEvja24nKAXI13vjlS+RlJlO/GIP8HCf5lx9hawjNzUhgwPoQYdbnHEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFC15A51B16
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDAzOSBTYWx0ZWRfXya1zx9o4YnHB
 HskZ3E0t2l9GgArXmeoGGne26RzWlCz+sBiI0+DKzs40gO7fZdISanuFY8mvCQBxLRuYQ9eO4kn
 ddP0OueWNBVKWwYTdijWRZ0OPGnOpd4EU2P1WSbEZ9MP/1X8ytEF10meS8PMKmMqrTFGQi9cTen
 +ilK9h9UgKymIX+pNGRZtiiy9S0yfPV9Vml41TdYC0BSYOHn7AtrGtYB+8EeEJ7w/+f/kESqw2M
 MfOls/7QdbMohgxWM89dVc80g9UXAQ6R1kk4CXsC+35S3NZtjzv25q/d0mokXJcCJgAlri6Pw+B
 OuyEA2TdzMJRIhDh17tvLFpEfls8JFvQTSl4sx7H1ZbPyIj8CBiho4Pmykrizf9mr2pLiDXIqwn
 Mzu+ywn8CSLQz3elaZB6MdEY6PLihg==
X-Authority-Analysis: v=2.4 cv=Adq83nXG c=1 sm=1 tr=0 ts=692fc920 cx=c_pps
 a=fQjKmEXVym7+EbnoMZdWAQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=_dNeB2_mOrZ-VkhNxWsA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: -drB2Ada_lujv2Wjw5dq9nRiT6lXpcOY
X-Proofpoint-GUID: -drB2Ada_lujv2Wjw5dq9nRiT6lXpcOY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1031
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512030039
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 03 Dec 2025 05:22:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2734

From: Chen Qi <Qi.Chen@windriver.com>

Add multilib SDK test to autobuilder.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 config.json | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/config.json b/config.json
index 0cce282..15bb6be 100644
--- a/config.json
+++ b/config.json
@@ -925,6 +925,17 @@
                 "extravars" : [
                     "OE_FRAGMENTS += 'core/yocto-autobuilder/multilib-x86-lib64'"
                 ]
+            },
+            "step6" : {
+                "shortname" : "x86-64 lib32-sdk",
+                "description" : "x86-64 sdk with 32bit multilib enabled",
+                "MACHINE" : "qemux86-64",
+                "SDKMACHINE" : "x86_64",
+                "BBTARGETS" : "core-image-full-cmdline:do_populate_sdk",
+                "SANITYTARGETS" : "core-image-full-cmdline:do_testsdk",
+                "extravars" : [
+                    "OE_FRAGMENTS += 'core/yocto-autobuilder/multilib-x86-lib32'"
+                ]
             }
         },
         "pkgman-non-rpm" : {
-- 
2.34.1


