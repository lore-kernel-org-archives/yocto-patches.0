Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6247D11183
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 10:19:35 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15631.1764238766620805148
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Nov 2025 02:19:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=L92aRAgh;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=34268059e3=yi.zhao@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AR5lYpx300912
	for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 02:19:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=goQuFNq6rX2rnYsGkz4wJnfNWe+cEaej23QGQd3CgT0=; b=L92aRAghT1ra
	xhSl86FV2zrj27fff28EGYx1YpBlUC1Ez3KcQN6jwg1hkQBMwediZTF7jWEl/Fin
	9NzpKaQQBGl0DYE9H9RLQSkzfPJNPkikfcW1PXmusIerOwOevuaSU3CUFVMJetm9
	QOndf9AMZKlKjWZdD84fzlKORxO4jVY4K7ZN5zOalhJIVxWxUbQAdnYrs8PDrgJH
	wihI8OrrgjQ046igYoOahgyGHQ6T9UgqNB1VJQ0ep2r+W9D57JECV6hUd8iT4HzL
	hJEcFi27QD3CXK7Jf7LUE8v1FjcaHa5uJ8TF764ZqLAZiWI5IUJ5eQjQlPvguxhg
	LiPS5gAH+Q==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ak9b5dggk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 02:19:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJaOGfaUQ7u3dlsEEQVi8j6V4cvMTFee7SNmLC756zW6YGPFRLX9GOqit90/xJ9N7SlJNC6ZA7a2eRo2/tMMr5w4ZZLZzSwHa5yUls7k8im/vEAPuEe26NMr7k++NsXG+AV0pN91iLWRVJ/JsB4tacaUU7M4vp5wxTwqAjv9JVos922tSZvQIeHOVeXcSFgowj8rKMU2Xx6lQG537CYcCPxxHmvurdQMdgCuRRuBuAnyCwxiVbB+90Fy/wWmN58EqXvnUJtVZqPXGlppRyuUA00ZQBWObN9Hwr/WaWo3mgtaCHmIjgc80oAqHDiBFffpGL0lTImLv5fX8EjWcZdjsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goQuFNq6rX2rnYsGkz4wJnfNWe+cEaej23QGQd3CgT0=;
 b=FfY4NjnquFXMvI0mKWGsbP1L7k+6NF7nS/sQCD2/97koffRgzUWJOyrhCddc4UDhvkWPifs+ur7fdxUPDf7Zevp7LlbfdZi6mdUwExPrcL/ZK1wia1UtMc+yQZU+QzJ0XMi4RAE94/z4hJeDARtplYemNfr4GVPO7r1jlj0nPlhWgFFp32HMIAEl6IuhXu+230bai1rm6eT8/g9pPCtAj5IGSGRP/I/Cmm74ouCTfeNvgURxboVWr3tDwLO+q/rqDEJ5Mql3syhEooNtfGnBe/bscH8SiAeRSh6CxLJ5PocHoG3qW6L/Vh0oo7r0D3yvTQNxMkU3uDWq/ioJ/JHNGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA1PR11MB6396.namprd11.prod.outlook.com (2603:10b6:208:3ab::10)
 by MN0PR11MB6160.namprd11.prod.outlook.com (2603:10b6:208:3c8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 10:19:24 +0000
Received: from IA1PR11MB6396.namprd11.prod.outlook.com
 ([fe80::79e6:58f0:788d:b45]) by IA1PR11MB6396.namprd11.prod.outlook.com
 ([fe80::79e6:58f0:788d:b45%3]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 10:19:24 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 3/3] scap-security-guide: add UPSTREAM_CHECK_GITTAGREGEX
Date: Thu, 27 Nov 2025 18:19:03 +0800
Message-Id: <20251127101903.3512507-3-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251127101903.3512507-1-yi.zhao@windriver.com>
References: <20251127101903.3512507-1-yi.zhao@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0016.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::21) To IA1PR11MB6396.namprd11.prod.outlook.com
 (2603:10b6:208:3ab::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6396:EE_|MN0PR11MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: 7411e439-66b1-423d-ec1a-08de2d9e7044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?3SHCf0+jLMExYxw55i7hgHVXUhHs3/Kf90UnW4D/nZIoIy7cKNClayYKcda7?=
 =?us-ascii?Q?9UDruqiS6nZtzpfep/MQTPbEoTxdTYp4gfyCrviJrAZMYiY17XnYrZdvDh/p?=
 =?us-ascii?Q?++eg4HwZhL0BihdNN1yiJliAUV74oeJ5cbPjDd6A+GB7sMDz5kw0SqIfUx75?=
 =?us-ascii?Q?/b9P+m3QhdTLHJAl7RpDRFlKp0T3eFRNXQDSyBrjNLFlKiNQU7UrbWeFchgA?=
 =?us-ascii?Q?wKBTabpGbRBpzwJsWUirJLzrLzaXLhlwIjamCb417TZuSXAwP+JHWOFGzXQu?=
 =?us-ascii?Q?oMyKIKUsXYc7kjPMUM5P/08bN2+42UgpTM5ICPmu23b4a33jq4XOD/L10TVV?=
 =?us-ascii?Q?XiNLNK18OvDbSRihsgvzwXXbIhd6JZ8hOIaUrcplDE/Dwk8ql8LA3M5DImVD?=
 =?us-ascii?Q?WE4RKoMAx81/t2WgBqozrjbAUwXilcixYiEinHcSw6ng+AFTMDjBI32kd94w?=
 =?us-ascii?Q?DQyA3Xq2keHPOFTYMsofvy02mzq2h2g+ZWqbM7i9vSwZFKX9/fcpVdc9TXrq?=
 =?us-ascii?Q?3F8ukrfZgTcOnoUaH7hV0SsNlrZejhcaOm5lYwayfz6/nj74OlBjkhFUdqo2?=
 =?us-ascii?Q?vb3CfwT5JcCJfxnOQ1nD2DJZg8ICh6QenTmPiVi5zMquEz92Ptz6PaAzi4YG?=
 =?us-ascii?Q?gG3ZPRmuYKiAsITHI5fewgSZzLREjwMGwHmXDafhJ1/9lTlR3dao6Dxw9Aq2?=
 =?us-ascii?Q?EmIFIa+p8skuDr6mR4ZHjHcgxgCaap6BqZMb6+Q1hX/R9NjVtT+zD0NssrsR?=
 =?us-ascii?Q?i+c/ll5qxlo6l1JMO3D8EI7kynd4ov8++zbQP4mHlshQ8fOavr+xanuhkQXX?=
 =?us-ascii?Q?kz4dkmrCOxmjINq3kIW4SHjzlKIliydjWuDPW3WdKMMZx0exusZu3dvVzosE?=
 =?us-ascii?Q?RKMDs8nhasmQ9hvK8FOfEh7FnwgEOFrqUITfbymC9qGrTw04zN6IjH+EgYoZ?=
 =?us-ascii?Q?otya4NTd6CyXulzw+NGGG6MeQ0d+VcPkR3yQuqKqFgt/+rJmzsU0dvRXeknX?=
 =?us-ascii?Q?5cgQr/N7BYQuHcxvbn3KH72ZbA2s15Mf5hi442Nc62v0yR0bMWmD5pgwSHNB?=
 =?us-ascii?Q?JuOkgtYzM0f5zZxAuQ+Bt8bQvGai+PmwdBAGUTuA8+CFAxyTISJXp7S2vf9d?=
 =?us-ascii?Q?dbEcX7l2aSD6hzh2RpsViGDDItBtMzJjqbHZNVvCZGAQvvz3GI0THWJUTtlb?=
 =?us-ascii?Q?mRrZSDV9wZLQi5ObVoqlwlNVGrofNZgAXPHjcbfznHsvxSmEvCFY4R/2qhAZ?=
 =?us-ascii?Q?gZow0nYAGISu6ujmoLeWZsawZLN2FYlig9K+vqsei8uPAxPzQCbnmgD9D3+8?=
 =?us-ascii?Q?gF2nJ2a8dEfE7G740P9ZW2TIxwwLA7qWAripB17LDxRKm+5h7Irf3I7ZLHyg?=
 =?us-ascii?Q?m+by3L4A3kTntvmGg0GlYMA6HfptXbzTvgUfLa67XB3SkZmYE6QybfBmOYAX?=
 =?us-ascii?Q?3kQzM+HVJbC3rsCnDEQSWsBGXfLFrrkXP92a0ocP5FF7QgAUrwAGjtgkUjlF?=
 =?us-ascii?Q?1x4xRq47A+EQmjCnUtDsfOIcvCB0lr40gtcK?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6396.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jmH3HWJj/EUezZppB09sCYby8OnCIwegIHOrHLwE5ffP9FykUA/Xa8QxA1On?=
 =?us-ascii?Q?Ta4ribhhlEXxzzZFscLug4DwX8qbEsDq/mxV/QjuESz6zo5hhi3zNQ4uZWge?=
 =?us-ascii?Q?URklBdgkWMxXPmjIXGYxOqg8W7kMz5acVONTgoryNMG3x4XiUeRFT9gtTKdc?=
 =?us-ascii?Q?T+GhvsyCWfKUPq9s3+78s7zWiQX3gvlgCldhtcnmlqjgWjD/o7e4rikomx5/?=
 =?us-ascii?Q?EciXAvsuMle+Xrd5XZczJGnythZXDWZk11/lqyXJBYgJUoowdVZrq98WBc0G?=
 =?us-ascii?Q?ohjIh6spM5khFlfZ5dr+EkGGGPbNmOH72aVi0WZVidGzjMcp2w6tdWCL61I0?=
 =?us-ascii?Q?bT43uI0vkPe8Osw1dUZT2yTVb/8b4s0Lv//GG1YgnEjOHZr+J7n2MKJmy+XA?=
 =?us-ascii?Q?Y0oV4HC0gihfUmpUqPvuuetbdeZkXiuMccw0s5fQwhXfWCDyqYlMGN38pzEY?=
 =?us-ascii?Q?ZpJOxC3Gp56VyPCscpQzJ2w7gc4nlpRm7sqy5KszaRoa+MPhDDYqrc+5NfyE?=
 =?us-ascii?Q?lbseuQ2x6ARySR+Hfpq3RVj2UEz/HAekfdmeEk9nY+aqJ4wrJNOKeNiNcfMQ?=
 =?us-ascii?Q?UETNxewhFPJGcsIo6tWL+mpGHsl09XITVqXeo03yuUj6E94ZwtW/60m2HwgQ?=
 =?us-ascii?Q?eqrKeZ7/8efxc3Sc5+kUW0RW1L0+NuTVHfqjo4IK4o7KwoDMi3E3Vc0zvqmm?=
 =?us-ascii?Q?t1BiysWLyQMnDIypnCRXvH5sLjUeAnSOC7JojF1Use/Dv6yTjSRYfYES2F2Q?=
 =?us-ascii?Q?SJYgoESXWd8eLmqblrx7JEztsgxn0Cm5rwcRnDY7PlZeb3LYHiu5/SibyfZ2?=
 =?us-ascii?Q?4L0nnGWWthdKTW4lR8ManqBfCQ/Wo/cJ0tjlMY8fUP9oAZ1/jOAJPaIU9qjG?=
 =?us-ascii?Q?NzWEo8gMBa4twqkssTdVg3UQFB5rs83l39w5ihf3lxS1PFhuO7Jc6z8ZyG8C?=
 =?us-ascii?Q?sqdRka2RiGIJsR9FpXbnLq+PIiFoJTzh/ahmkmb4U9JFqPNSL3cDJMUi11fA?=
 =?us-ascii?Q?RZl6ddtv0pU4tewBku59aB1UQOckv/4a7Te18G94KGMTpfQS6/mhOv+qRzdh?=
 =?us-ascii?Q?jbMoOrWfKylizBWmwF2+ixJa/aVC8Mlx4yaeUjTb7pM1EW7jDU7TVJH4la9S?=
 =?us-ascii?Q?djJoaHbk9r3ucxQ9SW/3pUf/m+NEwQ+/H6fN9+AjxLwy8oMxh3yO6+tXEcIe?=
 =?us-ascii?Q?7MCf64IuolRtDKL0dLWKd8YiMNT7tQE+vMWzvy2c1Kt8ZoRLiMD/JU1inVaU?=
 =?us-ascii?Q?fPYTN8tZbJn3AUR2EFx8vU32IxAB4KZDBiCK/ubCBvJtzeMotEz/BGKONrXJ?=
 =?us-ascii?Q?xSzo4CL/jDKqjD4Pdxjt6ZCXqw0luwenOcbDyoWuu5bA5tugtAuj3t7bjCNj?=
 =?us-ascii?Q?Y0vOw15s6q3uccsWYu4N+XoHDe47wS2ztG+7jN2GYfS89T02n3pZQwvqw8e/?=
 =?us-ascii?Q?y7uAGxlhtFdqtLQkeUS6MS0VHzRRYtDjDdjCS7AOXV620I0HyLlvljwa5e8I?=
 =?us-ascii?Q?bMr/BztLy3Ycsv1EqZTqd9QER76jDx+x4b9fulth6ZVUUaB1xzro80Fw/tIp?=
 =?us-ascii?Q?2lZuQ6DXA35HayyZMtCnEsoCiZLX+o7v2lCrEJ8Z?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7411e439-66b1-423d-ec1a-08de2d9e7044
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6396.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 10:19:24.7677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6SgyoR7e/mnt41wwKxG3PtVU5Gv5AmYkirqEzLmwB8P7sJg+v45wC8HFtnmeDIQayiws5vKaVDElQitPhjeGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6160
X-Authority-Analysis: v=2.4 cv=fozRpV4f c=1 sm=1 tr=0 ts=692825ae cx=c_pps
 a=2pTyoxkMaluYXS6DGsynPQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=NEAV23lmAAAA:8 a=d10BF46Z5o56Tql32BQA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDA3NSBTYWx0ZWRfX3knkuXphVQml
 CNy86IqF8n2f2H1cEmCK3deFv48MD0opFCatQfPW+WpEaFy79Bk52OsyIBoygj34iVmKdI8kF+Z
 gSmSLvueHi7L2ud3sdWZhJcIPLyW8gP+lcBKBGDP2U6NtA8U4lKTNuMGd4vpL0eXqTPkpBNKR1s
 XNVCI2EN2keuc/R9KZcXvKzwQjqGo17KmbznfIWuIXWYrcUwD3TdeN54j2Zyzv7RcQo0R3/LsDh
 1jBcPO+F0swV47ZSlriPjsd1ZvdoiJSwx211X/0BuZ/2qpZohlJBNFK9JKs7v8nToUqxiqg2mEW
 Svut4GxvjniFuLzxK+YyAqynPjO7MpJpiAKC1hX/PdekGQo6EhjSIGi18WVvpze7PB0DweE8faS
 hcxetAIpNjC10rUxeRsyvMyZN66PSQ==
X-Proofpoint-GUID: YgZ0vcvYpkv_6onpdxNpwwdkVvsf3Leu
X-Proofpoint-ORIG-GUID: YgZ0vcvYpkv_6onpdxNpwwdkVvsf3Leu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511270075
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 27 Nov 2025 10:19:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2715

Add UPSTREAM_CHECK_GITTAGREGEX to check the correct latest stable
verison.

Before the patch:
$ devtool latest-version scap-security-guide
INFO: Current version: 0.1.78
INFO: Latest version: 0.5.0
INFO: Latest version's commit: b0a1b1c3db40f5fe8610c43cbc391bde92cc78b6

After the patch:
$ devtool latest-version scap-security-guide
INFO: Current version: 0.1.78
INFO: Latest version: 0.1.78
INFO: Latest version's commit: f7d794851971087db77d4be8eeb716944a1aae21

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 .../scap-security-guide/scap-security-guide_0.1.78.bb            | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb
index 8489218..40a677f 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb
@@ -11,6 +11,7 @@ SRC_URI = "git://github.com/ComplianceAsCode/content.git;nobranch=1;protocol=htt
            file://run_eval.sh \
            "
 
+UPSTREAM_CHECK_GITTAGREGEX = "v(?P<pver>\d+(\.\d+)+)$"
 
 DEPENDS = "openscap-native python3-pyyaml-native python3-jinja2-native libxml2-native expat-native coreutils-native"
 
-- 
2.34.1


