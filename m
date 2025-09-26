Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E022CAC5AC
	for <webhook@archiver.kernel.org>; Fri, 26 Sep 2025 06:11:59 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.11222.1758867113511066976
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Sep 2025 23:11:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=hXNgol8/;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=1364c49c58=yi.zhao@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58Q502Sd1653682;
	Fri, 26 Sep 2025 06:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=ckXlZEjBy
	rEACKObbMFxe4FUnGVWK1Vd6AdxJpuJ19s=; b=hXNgol8/znSOp3jef0Xl5w1/1
	R0Pgnd24UxTZy0/XnHDh/AgncRYIZSPbG7xphPRvybUJWCB6X0V4AnfefRKCcgVN
	Wsh+RhoI3Oh9+v04vyOIPRugGVPEgFB9qYEnmRlwk7N5hurS+Q1rkm8e3msT4wCu
	5puND34ek8FH6UsqaWgPJZO97d2Rge77I4TQMe2xb8Jwg7PjwjoY+8ZzfjAIjLOH
	cjylSZ6BMgSc906Rssr7obvR8VIe2ru9WcV7JALaDY6n15c75nzt6tlmDbmpWUvd
	MOeGlXUqlAqDuj5cLPgSiUwhxNnmdG5q1wBcJ6x2pI/rHrrrapVmxGFLw9u+w==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011062.outbound.protection.outlook.com [52.101.52.62])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49dbsm8ex5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 06:11:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQn/Uaq792alV7iqnPcoAXdWCbaGTfrRACGFSGrFIYtTONjHybrcluKDnZWYmcCGw91XnR/yG8GKHAd2xL/tShJFx3XUglYLNrmWZeSAqO9NGGH+lSkVuaq2Ii0Js/qpZkhZI9pfRhOk9tYTVY/TA+eISxuYJ2y/tYv4Z6VQpsLlt60Nvh3lq1vtNlan4Ae8NMWFHuqlj7E61cAD+c21biVZUDb0k+R7n9kgQEazswVjmpZIy8LqstXTO+IbqDVGTCKSOoEiDvpSYcab3gTH28nylqI/Rd6o3OClvRFNUhy9nYnwJB5n1ZqKRRVU2s0x2FmHVUrXGmwZt7qnQ6QzJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckXlZEjByrEACKObbMFxe4FUnGVWK1Vd6AdxJpuJ19s=;
 b=dFZdQ+KqpJ6JKl67o/cmuWklqxmJcdr/yjBx5XSP+ne2KTi3GhICjoEnv1roloR/cdYbkBauHlIlhamg4L/jWPXA2ADNReQG08GZ6IyLITWq0AiPNeSrhKEqPhzM0wpmtuS2sKs1kgDK3PuB2U+hkEKu4fvOyO1ABt2v5JFFdH5Yz3pwqMG3cddAhZRxa6KhehRemTR+eypkkWyM/Fd5ej71IWkPCG1qeCj1R+9ymUTF6m0RtPlMiHTp+RPBM6gaKZ0FUaN1RNNbu6u8RX7E9U7asspadZMCo0zkwGQ+zWz9DSkjJUAXgOeztbvnpLpul7hoXnlWPd1JOwsNVHfH/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 SJ5PPF44E8B88DF.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::825) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 26 Sep
 2025 06:11:49 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 06:11:49 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org
Cc: scott.murray@konsulko.com, rybczynska@gmail.com
Subject: [meta-security][PATCH] libmhash: fix build with gcc 15
Date: Fri, 26 Sep 2025 14:10:54 +0800
Message-Id: <20250926061054.1868481-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0016.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::17) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|SJ5PPF44E8B88DF:EE_
X-MS-Office365-Filtering-Correlation-Id: 39ec5bdd-51c9-493b-e0ca-08ddfcc39416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?BWzvnSJW5uDdJGCdYMB7AXbbTaLL9AAAAqEq0qfXbmk3TXvO4UAfn56NSHN2?=
 =?us-ascii?Q?Ml6Ji8dlwlei96N8bfXuW47vPM8eeizAjDwsY6p67FJ1yFf0NVAGVqaXBHWl?=
 =?us-ascii?Q?1bgMr+E7yINw2oaG8pWxsoZkKzVFqliZVo8QJkmeqDC5ZkJ4kBvFilCix7AQ?=
 =?us-ascii?Q?cYGaJwQwWuy0wmC5xMV5BZq6RwdWPxByuLzvq+7BBxj38RKifPPi5LYAkroI?=
 =?us-ascii?Q?5JRcnb9Neq/yg7rDnYe3yucsNdv+NsPdaWtJPG9LjNQakLgH+ufxDJ52ugAu?=
 =?us-ascii?Q?2Vi5m7ki/PRJAJ+8Fqsgn9UXLQR5VQynEXOQO33OIdDeO1JrepzRgHEc4DQZ?=
 =?us-ascii?Q?svw1munpH84fM2tlCvF0ot7cTYjxMkH5ImkvFpNAI7PVJqKXYBNpIqeaFWpM?=
 =?us-ascii?Q?ZwDMnp+Hlf04qiSaaIeODA1Kbo8GXq4kfPw//JSmpJNn3tKc8u4PqnCJMTw6?=
 =?us-ascii?Q?g3upaRlGKbO6tfcxqws97LIy/xok0k07jKpMbE33XQUTxVEh+DhQipu7/wOb?=
 =?us-ascii?Q?eTbGFLzQvn+qNLEaA/mNKvQjF6yFmBsn5SOknU/Uvreh7rm1NxFKGEHYodCu?=
 =?us-ascii?Q?Aizeoh2TmljcOaD85r5nEpnh6hImMDkrNZC7MNZHFGtADfViu7bTKEeXoHlD?=
 =?us-ascii?Q?l6hI3/sFgWEzzWy/yivOnq6TGwNKl5Mdm/WM/NBXE2DkiPxRhtfaO/Q2zwij?=
 =?us-ascii?Q?Nuz1fU3g5Fn3kJZFDWN63nM3qOeV8rnY52OD0FoGelfN4ziApCERfV4CUWd4?=
 =?us-ascii?Q?Y2LiCM1xltfZtm+DcCtA8hkm073qT2hPr6D5S79IZrAAkU/lS0nJ/j98mIHr?=
 =?us-ascii?Q?HyHWog3rG5xdyxefouQ0tG4cb2g5ZYpV0EcbVS9ESXOlwqIWYSfmBFNcwuNY?=
 =?us-ascii?Q?bfb5asto+wPDMp1QlfBrPWTORQYghYvFhOYWRnMaIXe+KwvOeUJgOyBeaLVp?=
 =?us-ascii?Q?08Gp4F8eOWfqaDvUVgZu+IN0Ycq46Db5JIYCRLKClERfRRUurX5D+C9kCzZa?=
 =?us-ascii?Q?nuDRMhMQzSzO9aFgjlH9M1Ga/25kQs1QTya49wPv4fH+oEwkM4ZdRwkOQ0a9?=
 =?us-ascii?Q?SwNUyRCQx2d2vURo9NsAWxYD3dvEEg1qwucUEvfLOwqQCbWgG8QdLP4yuNuL?=
 =?us-ascii?Q?skYCIKDbi9g8gQ0pnD2ll40v9I+umjW3NUP8wOrUPmgnytHz/KYZoIpbfcKr?=
 =?us-ascii?Q?++wSWF4MbQHqCrViXIBofiwnag6GvXS96mFeTobMYGLMeuN8jfpVe4O1Qc7w?=
 =?us-ascii?Q?Saig+5N7Zxvj/PxEwFj5w/yEOom99RqNbUQu+QlgFg7Z6y4r5ez9wO14MgCB?=
 =?us-ascii?Q?WOJhAl4yQmqxEbA9y5Z55M7JgbqUoHFudoTPLENfOD4xKKqrJ5588XCXugPI?=
 =?us-ascii?Q?i+TuyAfFAVmPwlaL5Iawsn5JKbp/s6iseayiIemyiy9LzdiTwJHsdAjoxOhc?=
 =?us-ascii?Q?8E4ryZnhZtGYPX4XnwzUwYWTc7dLIAKs+qFV2tUmNXakkkE2h2YUSA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6o1bZfNrkpe9E2jcRudt+jDi3T3HUl+UsnVwDbIJnLlpZ/3cBLjvqn17D48j?=
 =?us-ascii?Q?qj8Cy+0tj35OPaEsqBUoUulsYZnO6DBzChQ4Z2t0MH2jxI0g3ZWfYBzQjiNg?=
 =?us-ascii?Q?MSj+nDdIbccm+phc8S7GwfNLeszrIRYQ1kBukx9FvD4PCRjoz+ZktmtMQqpX?=
 =?us-ascii?Q?4TGAergCpfJ6fRRKIxePrX6bRtPTIFBYXnUMt+FOKRxrOV1LCkCebqqL+VSv?=
 =?us-ascii?Q?OjnIi73qHUfujHT2FlWJl2GleeJOQNy6FlY64lLz4zv8QaJYSEJ4E5ilaIz3?=
 =?us-ascii?Q?NM8Va+wZXJhQF+gJakPWoELdOmWY3xW3o3v0YokUEZy87TD0Os3TLRzysB2M?=
 =?us-ascii?Q?Ryg04M/9NRiWCtdNZsYGmICp813AffhLq1m8Jj2nPswNgGabomh+xMxkyMqc?=
 =?us-ascii?Q?C2PjByYOrbrHvuVCspqxP+NbhM/u8quWv6R5QONhIH0aMeY0LDyjZAc5fOAm?=
 =?us-ascii?Q?+owRbP0fe6uvbjxlTHeOqyG1YSzUOdEYxK1RtnyZFhKpUs1tgINmcQY72cWW?=
 =?us-ascii?Q?1zVj7zFhLVWmVAASaarAyLi2sfVeUge2SdDo8sQAx54zhGJsFTNO4p5clgMu?=
 =?us-ascii?Q?ajMjAF7IEs144vhuIHqv1rvpLeVW03zo0Mcn5Nxqt8kTKquPFUntMk8gzLdK?=
 =?us-ascii?Q?epP5OVhm6R1xf46TNSwGT4DxYzn0uczrJaBBhhFZioZ0hBh39MarNgZJGRij?=
 =?us-ascii?Q?wnjb4n2Kvnzg6+c2qwm5hOH46S2HOlxyxIPlqlyKSQWIkKjMNNMRSQ5mWPL7?=
 =?us-ascii?Q?odj+f0OEIwQPekPOA4zVwqG2pux/631JVCKWZYW5bpx3/hQ6aC5h3d3cwyCn?=
 =?us-ascii?Q?/BJ2z3ax1vXDDALRI1sRfJBNGYrDBUZPz3HCGSQHSaE1Jig0AZluVT0z2Nla?=
 =?us-ascii?Q?PriKFvASaOauhamLqhjaFhw8GL/JOQ1S8QAfdLQLlgeLS9biqI8JMoCCR8di?=
 =?us-ascii?Q?BuiFxtTpk6tAHaw8Zjhb2gEh4N3M7EcICMrFNrexYQ5C0LqChcmD7wTLYoBW?=
 =?us-ascii?Q?dNMX8KcVr6UowDHPG7MolHarUr0UfiV7DNffNAWs9WPXs8Yh/2GJW7iZWn8j?=
 =?us-ascii?Q?aCHKLfVmZAuGyoWeXQYU4aSjz344WRGz0kSqDC1wVASnWV18e/ERUmBTpAKN?=
 =?us-ascii?Q?glMFZju6KbSCGEVmNTiKOVnUnmyfFH7sU9+sOJH26MjQVkUAiGUjihAtOw6/?=
 =?us-ascii?Q?4ex4cw9aTB8vNnsYiKHO/1pR2MWzzUAAGksPeG1zgbiLs0TdGBAfQPewP0t3?=
 =?us-ascii?Q?E074BNG/tJeTjtrETBA/jU1qJBKXJnAduoZuHOWgtcz6gbJhSTd/d9sF25uB?=
 =?us-ascii?Q?l9g/C1lokMf4JIbCBKmEM6egqfJABYLy9fzwCCRlqfOijur4w1jJNCjS1dNe?=
 =?us-ascii?Q?qul4Ff+gKFgOoZBWY9JXNNVOOdUwODNCNAEMUnm+M6+/c2+pBLvmyJQio9im?=
 =?us-ascii?Q?tlTMHnrQbATr3mWgx+NDm91sgd2loo+pKxC1OOMhfe5WsflmAGqk/xLWlEFW?=
 =?us-ascii?Q?2+MEpnB9pXwE6P9IBc6S3Z/kJgD2K0N1BUAVyGkLvgF9z/tIV3VLYCsrywzJ?=
 =?us-ascii?Q?SbbsMHwiHcmb5oTsGWvi23vtYSjZOaVX6HWzSJ9/?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ec5bdd-51c9-493b-e0ca-08ddfcc39416
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 06:11:49.2580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77ZJa0YhA0nGjuGF7gBlrFJjcZh4hFU0hgA9Ydp1R6kMAMXwHHieGOnmc91eYJHS64019wCsFBRhVPIrkB/q9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF44E8B88DF
X-Proofpoint-GUID: 5F42uIxYl4pes7tHG3-DhyKQUzqJiDBC
X-Authority-Analysis: v=2.4 cv=TJhIilla c=1 sm=1 tr=0 ts=68d62ea7 cx=c_pps
 a=hroH2nosuffgF65CSEropA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=t7CeM3EgAAAA:8 a=bmDwqoDiFhyJZlNTYvsA:9
 a=ZXulRonScM0A:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 5F42uIxYl4pes7tHG3-DhyKQUzqJiDBC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDA1NiBTYWx0ZWRfXxe6PJQ65c0ij
 lxRr0QPRwz8FiOrkqh/wH/R7NW2TcrNweA2O7N7sDRYmU1uVYZWd6UmFVtGMVkTWwEumpftYPvV
 M58KODYccmGYZK1SiUC48OZT3UqScuFkRiIcB3GD/pTC9xr1RKe2MGbRXBo21Jf0hs61bhUZxYP
 bR4UoPkCnbIzJad5kSZH6/kes5cM240EtjgICSKWjXR7s6q1Vy1Q4XLFRZe/rVDjpkwzuqlz3cz
 gVRTCY45ppOdKv6ARfaPlqDyHlTATR61BPtscnKAQmt6mJ2mbicPYvjtaT3Zph7oV9xOdKnFgob
 I6/2Lj6uFkQj8Mf7WVfQxPdOaVnfvxQBEpImZU7VARMo8QbSjOphMz2CJWWmX7f5TJL+ZKEhema
 dvQQPk8BkQCPiQ4yvFqnRRPZfQEFtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_01,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2509150000
 definitions=main-2509260056
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 26 Sep 2025 06:11:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2234

GCC 15 switched to C23 by default, which libmhash does not yet support.
So keep using C17.

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 recipes-security/libmhash/libmhash_0.9.9.9.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-security/libmhash/libmhash_0.9.9.9.bb b/recipes-security/libmhash/libmhash_0.9.9.9.bb
index f5518d2..805cf05 100644
--- a/recipes-security/libmhash/libmhash_0.9.9.9.bb
+++ b/recipes-security/libmhash/libmhash_0.9.9.9.bb
@@ -25,6 +25,8 @@ SRC_URI[sha256sum] = "56521c52a9033779154432d0ae47ad7198914785265e1f570cee21ab24
 
 inherit autotools-brokensep ptest multilib_header
 
+CFLAGS += "-std=gnu17"
+
 do_install:append() {
     oe_multilib_header mutils/mhash_config.h
 }
-- 
2.34.1


