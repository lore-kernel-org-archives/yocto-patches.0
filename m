Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD4AC5321E
	for <webhook@archiver.kernel.org>; Mon, 26 Aug 2024 05:57:18 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.46497.1724651829436449587
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 25 Aug 2024 22:57:09 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=896858a60a=yi.zhao@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47Q5unOK012228;
	Sun, 25 Aug 2024 22:57:08 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 417at31avd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 25 Aug 2024 22:57:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAZnXUZ+DZEdnWP5Cd0dE4TX59rSrjvxxbyBefCtviw43drEaYabWLRw8GaosRn1/E/Dq/QPjB+lJbYYHLEsSxipbCjzOv78nedLqZfDt13HWy+C2ZFyC8OZvhM7QNiDUJkUj9KiKQ2QQIgcLHK4kM88P/jtgAwI3FbJf8IFtFqjmmOlpTkFnmWnnislXVc+0GqA5urqWm5242gnlfXHIs7nD2sv+8K5xjLlgQfnLBZwVIJuKjqnbc5C71ES3s7lEsgeqppybQRmm+RS78o9nf8iE7snPhnHjwKpiyvWsIG2Y5LOG+HFJQeUwkYfD+Rigj9yf53/togdzQ+NXV6/QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BogCQmdWH5xa+3BASQzNs8VCqGx/QrkiBHYKq7DdX7k=;
 b=UUfN2TnGy0GlaPvAM8ac4piPQ1cgbzQXpkE0t6sTOzzXZqn7dhq6gNbUM4fb2doH5a5jBN4dPedvLbT1S9dZuW1pvGXPQM/rCz7nYcZyzPN/RL1+ftV+L+XlpKH73nDbPpCXLit+PzJVo9SSlw9dFb7MMJmZeTbC/CFPlmMiVISwvXsbeU+9LuK1wX2CTQ0LYXCwgminVyS2mictjBxmGdKCZi9ruL4+mDACgxYT9r6JZpIxcA1GOoP3d8dcsWNLEOtA31NqdqKn3YKCkBvZfG/TGh+76Dr7CJMwEnCgnuUAqhkClejNmM7yPxjTOWy3sA7j8WcAkE2XEo6x7Wxe5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 DM4PR11MB6456.namprd11.prod.outlook.com (2603:10b6:8:bc::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.18; Mon, 26 Aug 2024 05:57:06 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%4]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 05:57:06 +0000
From: Yi Zhao <yi.zhao@windriver.com>
To: yocto-patches@lists.yoctoproject.org, joe@deserted.net,
        joe.macdonald@siemens.com
Subject: [meta-selinux][PATCH 2/2] setools: switch to PEP-517 build backend
Date: Mon, 26 Aug 2024 13:56:55 +0800
Message-Id: <20240826055655.264086-2-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240826055655.264086-1-yi.zhao@windriver.com>
References: <20240826055655.264086-1-yi.zhao@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0105.namprd03.prod.outlook.com
 (2603:10b6:a03:333::20) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|DM4PR11MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: 7091ba66-d89b-44c0-7039-08dcc593ea9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ja8bsAv00L6ccgQGcioQ/b3BDRjlIfTV0Zd42E32CeZs8469VGzpDO8m4Gue?=
 =?us-ascii?Q?yhKN8QGpKYMrPPUQJJqja9A/IIp6Md1ItocbCNFbDXDyyWJ78G+BWhe0TkLY?=
 =?us-ascii?Q?V8pc5n/slDZmbOcb2ERY2NLDzwlqnxR0eEBsH5/041iSx/KorXIa+tNxylhu?=
 =?us-ascii?Q?HbOvE7MF6Yh1heU6rdY6513uvUf/rqXUw0+sSzXA/bjS6Y0vM5Zw5dvxn7OF?=
 =?us-ascii?Q?b732jnlEqPSApw0bz/q82rGnT70+4bcD9Kogb0+cLxSe+ii+hr1rHSXMX+tm?=
 =?us-ascii?Q?8AF0GexJYBSlne9s6/wQJaPOvIS4t6evlTa7lFsvUIF8cU3TJWrk0gyb8QKI?=
 =?us-ascii?Q?0O2xNdeW3jRfgz8Xp6HC9cwyVpcviGW8ODL7JcAGqC+evyuvdfSZoqwXRASb?=
 =?us-ascii?Q?Q5brBDlXcHeae9ocGY3BkYS5JAOGweqC1fBRnFqxjCNeFnvnsgd9r1DAhqJn?=
 =?us-ascii?Q?QruuSGXx6MX/MrQLr2Fc+sFZRLgPyhjQ7dPaeLvRhKME3hGMZYnXAhR/hWuE?=
 =?us-ascii?Q?TLBXF3fJ4wMwCmFI3NpEzLJT+GTmq0cTJ9hjSpAz2mch6kezFQ9t8cCaqBJr?=
 =?us-ascii?Q?NBt/cBbd3kf3SvwLtcOb6RtEoQW2/Twe4W1RyUXXI0StBkU3vAFDPA6Sf8bD?=
 =?us-ascii?Q?ncfrlxjxckj2znzG4U7nUJNU/OBEmXVIrmoAVZyt8aLoLCyfLpVVmwpv4ON5?=
 =?us-ascii?Q?VX0oHQwj9x7gooAwOC1zH11A2W/Sd4KY+rua3oBlXl1Tq5lXI5/+nu4N9LDA?=
 =?us-ascii?Q?4dvFZQehnwHZlvKb4+ghh6+EKBWIqupz7NpNKvNRkib32ssioL3k8F0K8ac5?=
 =?us-ascii?Q?n0hH0JFNJQ7lD67WJI44ucL+wgLmlA4+dAJBdvI5avkhWAxAtCgF94Copaq4?=
 =?us-ascii?Q?GvohZ2kp71yG81cLKHTfNSUvW3enp3uY4dizNHaF+srXqOC8i+8Vi+XOUX2L?=
 =?us-ascii?Q?CTRWmvyq5CUxmppAdvh7uJQJtx+sl82zySxG2bLyGwbMO83JC44Z5ObKK1u1?=
 =?us-ascii?Q?Z64yBszI/dQlQRA2PiG732w6Ech4Fkd452aWXtvZyDfTWDLQ2AZ15q1FovJr?=
 =?us-ascii?Q?+8KUV5vM398z5i5cL6nH33aSI5s6FxAMuHwQHdAnV1tH6tQXOHdf39YjvVAa?=
 =?us-ascii?Q?TTTz8HkggN7pM4nzP8HxRkfT3LZd8zp/Kx6cpxwxLjMQrQOTnyU4+nkSJZpC?=
 =?us-ascii?Q?Egdu47U4hbfI4LumIQkuwBLomOkw0XEWdHTd9dvo9YTPJyoZHNMNltXAKpz5?=
 =?us-ascii?Q?J5RgR/0IiLbMToT8SGFKOmxav4rhh2WIkqq63qcc/snGj+4zPuwCfhi1G5eU?=
 =?us-ascii?Q?Gvk/wdZBK6ez1lps8vrtUzbj6R02UucrFDjviAGcTVU3TF6VhRHYO0OJBpD9?=
 =?us-ascii?Q?9KlLJZNOsyMiKJyypO088g8a8LoHWb2T1pojlJOYNXMQEspi8Q=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?AC03aGpfJi9YyFAuxbtQYeewnmbX2fA474mMM4fNRbEshwlM5l3n+3NAszhl?=
 =?us-ascii?Q?3Es6y5BJhqeSSmZo58tiIKQX261iHJIaZmu4jcfq1oHc2/aeE+otxJBTWZJU?=
 =?us-ascii?Q?63+6RX7JziJm7DVXGs9o3JzHCia53IyNfrMk3LNIKA9zG+W0sLUO/wI+IioS?=
 =?us-ascii?Q?vwySz1Ob4XDEcyO+Rnk+SoLkiVYP0RMnKYGpMIxcV2/zpA5qHJt14kpSjEzZ?=
 =?us-ascii?Q?JKAazOMDn+7VW68AZc8JW73QC9rt0ZnaLif9LYQsMJkNigqYM3MaO7ptl8uN?=
 =?us-ascii?Q?KQJ+Z3GqgmPAA89uXGzdjutRAfjS+cPYLcXLejThOyfGYWIREfERueYFL84o?=
 =?us-ascii?Q?XBHrgpAsQLlEW0I+sAABQPO8cX/Vrry2TK/5OBk6KQDGO0fqI2kd11ha/48+?=
 =?us-ascii?Q?gci7XMRZ9EVhnriEXqpodrQPbcCr7+2W+I1wnhOo8Wz+KhgKEShSlKDqpG8l?=
 =?us-ascii?Q?aJEo6QQjroKt4TvDK7voqKKBipDSQN3EFPxhSW9o/rWvbp7nl/wtePQwyvqg?=
 =?us-ascii?Q?xAhKZUER/vNE9SXbgsweNpQNRGq2WJnE4189vXH0EDnbkDBmiIu4IuuJxdvX?=
 =?us-ascii?Q?NyJjo3zkA84vGGxwMOZkjXlVBiSkhXAblkBPoi9qM29ITKzJJYmIDl/bkMa7?=
 =?us-ascii?Q?rMgK9mY7WtIl/WdQ5Uy3LOAoIa5fcy5ywvHIL5ofhDYGYWSSaOs91bIrhQWc?=
 =?us-ascii?Q?YMGoYrM+/ue9aUl1otk6hBFiLIoYD5M1FdlbXXKdCBT5EyHWhqiZccbHzAnz?=
 =?us-ascii?Q?NTIC2simjHAu6LOvwFXuTxjTHUE5xnlBwjDiOnPoyvcAlV5BMNbH+c11OtXp?=
 =?us-ascii?Q?2iDlpyCR8spjcwt3duHE5/3m9uj6ByL40o4ndV6alaqIFNFTGXdbQV6RZbit?=
 =?us-ascii?Q?udqFtMa1qjipKNVKupsLUG/pchQqGnQ0vbnXAba/7U9oTUIW+RkErEnqSQud?=
 =?us-ascii?Q?6mUMbbgg2zrvZDWwxnmuMVAfSnMLjuUz5UORUd0zrYP0pmAi6dq6uG1DzM5U?=
 =?us-ascii?Q?b7kj0pHh3qQH62pUjqgOMpjaE0it82nIIgxkvY/fiusGrOZnSmjISrEK/z1Y?=
 =?us-ascii?Q?RsWJEJIpq4T8OuH/ZFsbfNFFTgDZk57W6Ao1EUrXcwdus8nLuhC1R/nacKgm?=
 =?us-ascii?Q?ERU/TqFaaFSyXZmwEpYXNhSOF1oLcM9QSUhU46dUQgf6g5hEiLr6VmdomTyi?=
 =?us-ascii?Q?3DcTKEJ/Rda0xSK6UHkjXejV0qS8oyr661B0COXIz5K2j0FSmLcYjzDiA0uQ?=
 =?us-ascii?Q?4Y3KyzeBgsUOTI4stFGe7g7abRm61LDeGLvpvpUrMY+fL8nskBch7bv3215t?=
 =?us-ascii?Q?TwuqtEnJpoTKS5wDkFpiaXSAevN4cFLXJt1rXTIpI5MqKl4M0cx+I5i8wSbA?=
 =?us-ascii?Q?KIMUi303L3BlPATYs6XRjUlXbRxKbNjDEJPo5vqR4eb/79+E1avASHiT13nd?=
 =?us-ascii?Q?muZmcsFKveVGspv1irhtA3qToYpMhW1ApJTlsWdZHP1RPUVIdCDhLUk870u5?=
 =?us-ascii?Q?8V+DfB2q0sIHpQ33j05pIufrdVc1K0dE+2wStIFMnJI6iPSIL24aUKW2dUNM?=
 =?us-ascii?Q?Q0+cpdaEeNhVTPWvQiRYRGKHq1yvXeztdlTo6Gyf?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7091ba66-d89b-44c0-7039-08dcc593ea9a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 05:57:06.9297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y7Pd9N2HyUH1jlU/QK/RFW54eQJpiWtgRohhk4QZlDGp2ZZW1rQUJmBjVr91EjDKfreLlMf3V5f4IiZwRM7WCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6456
X-Authority-Analysis: v=2.4 cv=F4YFdbhN c=1 sm=1 tr=0 ts=66cc1934 cx=c_pps a=smr7v+wKk2SgYJk0SwJNKg==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yoJbH4e0A30A:10 a=bRTqI5nwn0kA:10 a=t7CeM3EgAAAA:8 a=i7oOv3r1ciDNa-W48D8A:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: gGhCxXUwm1HSxe9ulbuSKeATj8B0FrFY
X-Proofpoint-ORIG-GUID: gGhCxXUwm1HSxe9ulbuSKeATj8B0FrFY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_02,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=828
 priorityscore=1501 impostorscore=0 spamscore=0 malwarescore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2408260046
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 Aug 2024 05:57:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/561

Fix QA warning:
WARNING: setools-4.5.1-r0 do_check_backend: QA Issue: inherits
setuptools3 but has pyproject.toml with setuptools.build_meta, use the
correct class [pep517-backend]

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 recipes-security/setools/setools_4.5.1.bb | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/recipes-security/setools/setools_4.5.1.bb b/recipes-security/setools/setools_4.5.1.bb
index 45063cd..9b6745e 100644
--- a/recipes-security/setools/setools_4.5.1.bb
+++ b/recipes-security/setools/setools_4.5.1.bb
@@ -18,19 +18,18 @@ S = "${WORKDIR}/git"
 
 DEPENDS = "python3-cython-native libsepol libselinux"
 
-RDEPENDS:${PN} = "python3-networkx python3-setuptools \
-                  python3-logging libselinux-python"
+RDEPENDS:${PN} = "python3-networkx python3-logging libselinux-python"
 
 RPROVIDES:${PN} = "${PN}-console"
 
-inherit setuptools3
+inherit python_setuptools_build_meta
 
 do_install:prepend() {
     sed -i -e 's:${RECIPE_SYSROOT}::g' ${S}/setools/policyrep.c
 }
 
 do_install:append() {
-    # Need PyQt5 support, disable gui tools
+    # Need PyQt6 support, disable gui tools
     rm -f ${D}${bindir}/apol
     rm -rf ${D}${libdir}/${PYTHON_DIR}/site-packages/setoolsgui
     rm -rf ${D}${libdir}/${PYTHON_DIR}/site-packages/setools/__pycache__
-- 
2.25.1


