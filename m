Return-Path: <joerg.sommer@navimatix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75CCF3ED4E
	for <webhook@archiver.kernel.org>; Sat, 11 Apr 2026 13:12:33 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.120])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.195329.1775913151657234633
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 11 Apr 2026 06:12:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@navimatix.de header.s=selector1 header.b=lXJxiSHT;
 spf=pass (domain: navimatix.de, ip: 52.101.70.120, mailfrom: joerg.sommer@navimatix.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HkNSlFUTi0Tms+iKGBK9UKTgYU2zYNOZYU9L0LC65NRWoRNyQf5E1eT1vmUmWmTJLyrVcke7961tfkZbSOEvEQ14d7oSToZIUpc0Rk/ShRx969HDUx75gD2wKgZwmtxXzE3kcFf08v/yKu2VQdeyLDWg2Om5H2490HZ9lpF6gGWwk8Pc5BaJyytcPWjmnO9XKI+Gv5R6uQvKZcdMOJa3nWaFif0gacIrZ76+fJBXG6BnxF70/35+Nc4ftHBcN1wmLx32YUDAG9nxnrGhIa33UMmjl25Wm5g/8j0vyockpf26L3rKQH0vCXw4ZdDdJ3psVGDuSov8FIlVKGJT8NWh1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Nk4AG2EhYLTHIrRNkBQFtECpyzs50RKcSkMA8tgV7Q=;
 b=Lx+sZdsUiO84KFcKv/emgS0Dj4FWRa73gSWj9ndNNlYOyqQm3xxitgAkR8GVuA+kA13gX+MW7s/mL/JrYfL2zSQrseQsf9C+PgPzeLYTRL8JPWsI/qQWTZg88RS4Sya1PehgvHukQ9AraE50IZT7P1T4rMVy3ufOnqw7H0c7ji6ceqNsmWvUuxM0EFCNBD3bEGQTf/mzu6N/wmyE1Xuga9P8usNnDK97Xi8mPA2GeJCeP0pWt71iBCl5kEcUYgGaTrVLV6b/4FiplZaBwapa5cFKHOhPa8rRY73XwmRDjDNO/UTRkfokf+tMrMW/PEcwDCfnOfVVCCZau9rfGYLkIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=navimatix.de; dmarc=pass action=none header.from=navimatix.de;
 dkim=pass header.d=navimatix.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navimatix.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Nk4AG2EhYLTHIrRNkBQFtECpyzs50RKcSkMA8tgV7Q=;
 b=lXJxiSHTKAif47pHqs78LFpuwei7246pTH4NRDiWMeuo6iRAh+m75/Xlrxe7XQTmHa0PGM1YySGaPfRm3CIsEuYIIgBKvRhieGV0Xs1EUfIsUrYgygbL6zu0lRL6Y9YoaX6u/Nm8Yken9I3fyHy77ldwhpq6U314d5ynZYVlcx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=navimatix.de;
Received: from GV2PR01MB11835.eurprd01.prod.exchangelabs.com
 (2603:10a6:150:2cb::8) by PAXPR01MB8153.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:1d8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.46; Sat, 11 Apr
 2026 13:12:27 +0000
Received: from GV2PR01MB11835.eurprd01.prod.exchangelabs.com
 ([fe80::d5c3:2dea:3d98:25fd]) by
 GV2PR01MB11835.eurprd01.prod.exchangelabs.com ([fe80::d5c3:2dea:3d98:25fd%3])
 with mapi id 15.20.9769.043; Sat, 11 Apr 2026 13:12:27 +0000
Date: Sat, 11 Apr 2026 15:12:25 +0200
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg.sommer@navimatix.de>
To: yocto-patches@lists.yoctoproject.org, joerg.sommer@navimatix.de
CC: =?utf-8?B?SsO2cmc=?= Sommer <joerg.sommer@navimatix.de>
Subject: [PATCH] rpi-base: Use MACHINE_FEATURES_DEFAULT instead of
 MACHINE_FEATURES
Message-ID: <7e86f488699b3427e72591044f78d8d3b4fb053b.1775913144.git.joerg.sommer@navimatix.de>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::19) To GV2PR01MB11835.eurprd01.prod.exchangelabs.com
 (2603:10a6:150:2cb::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR01MB11835:EE_|PAXPR01MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 54880a96-f620-4a85-b8f5-08de97cbfaaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	Ea70iyfbVPKwQrIj8Dc/DOPSyqe5R+xnSdZINiFQxFTLON5YX9ZkTZ/yEKjKMuBearjwwNetV4/dq9BUFe8aeYBiGlFwmrWcC8nUWGpIVJsUiqqn/dRFafT+V9A/RGFNKTgyy0/CpKmkhwnjR9BTqvqNr+E+NXtpaXkTeojQ7/lOYMUdxYX+ylHhqWsEa49/AsLfbsixSqEeWdazqYP8nk/Lc3Oxsw/VTFvi0lbgH/JrzfIlV9oT1Bmte0URy94S+xuRZuCkwiY5MwLQlgPRzMN0d6thVMzyn5dKmbIJi1urCEzM6Wj4BVEbVdbbJWeFpQaS3CzNGuIRAgIcTZX6YIIigCXFJC6pud2uSY70yA7xhhiCf+EYlFYgK6u/JuLzrVz/Vk4I42o/rNKRcs2plwtBwUvjkcDewq3RPtpqL8cNFPHES7R+9Sdpfm1X9YmK58lAcOJTmTqc1JmHLpxYpVEb+OA/BkTg4ESTa2wALLOFQ9c6sBQ7K5U3EKMV7xdFAiP5v0UBlk7pLZgFE5PvrAiJ5KQeKtGPA+gKywmfU00dMe97TkHrK3tC6voVSSC222EClNQwP2AadiNkIOyNnKmIjve4jd5AvpTT5v685KXbpLSzHpN6lOtZRRK26yx5Lpq8ydVcFj7PWkAXzbz0yhZ2vqKeAyZo5w3AH8bXpv+K6YIrtuj5IRFnNkl1m1C30YuD89JvNEYrItBfmcZ0vB+GtZnO0M5SHXbRGTC0Gvo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR01MB11835.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WkJCXoSfA2WolPWiu3WZRjWFMkVXNtI5PgPlvWo59mU7aVD70MuY4yFR7rhn?=
 =?us-ascii?Q?+tbSVTKY0yYHqbEt34UItGuv1FzOjTmmkF0KnGhQ62XFJX26PYuOVWKvvpYX?=
 =?us-ascii?Q?+ZifuUFcRJ7mORDPA/42HOmZm2HuEzDF98aTHmyRPoVekKmV0ZfcBn2HuWWb?=
 =?us-ascii?Q?De9v6xeRL8sqQD+l0juVR7vmt2pJMT2mv6+vBhcnwj+EiAh3sBD+glpe1Fnm?=
 =?us-ascii?Q?UOLV6v1dZxESQYafvEdZBdEZcdzVSJbMzz4rMrGy47BaGoelw1QKJO3mlXSu?=
 =?us-ascii?Q?yGZ0GksUVrMtIr9rDOxHFoimVrHsFqccVVngVS7GOzZitdKO87HeVAXZYB6d?=
 =?us-ascii?Q?vb483D3XMj8mI4lNKeoedTB7imnqwL5zQZgit5KWeGe1t9peVAAPNYQB4BEV?=
 =?us-ascii?Q?dyrBU5fVe4yeVAnqzpbw7eYPFcU2Af+5UntXLldsI5p02vn0caOholgZCSNx?=
 =?us-ascii?Q?TcSVbaoqHKcP+/kh8fKeY/7VQuNEMT/i62D/cyvzs/NX1p8oJLNz65+eKXbq?=
 =?us-ascii?Q?Vkv+3k1XYz8yRDJxkg4hf3XtObpk6mYE9PXMIytzx6qwOdJqYMHis7Py1zgg?=
 =?us-ascii?Q?zgS2Y3BysNBkND56CuD5R0o0FZaMoSXQntOXU+C3sF1GFh8hrOE1+LeDkAkS?=
 =?us-ascii?Q?SKm19OmjfNn2G1v0ejbyKqKfKq6v9XFk5SpfeAQKV2wjO2tGyMrOH8ppleIR?=
 =?us-ascii?Q?jxYZanpnFj+4iYT8SMMYKTIt3cY44S+in/RNBcM0BfbkCV3TG1fKJ0Ky2dCh?=
 =?us-ascii?Q?kEUkpDQvNviF6QhlUW+oyGuzHTajsq2DM6hsWyLdUxX2Qu0PTVto3EiHai4B?=
 =?us-ascii?Q?DN+3mt1U+Ua546Ezjbl16ne4mRnj6rcKJxeTLP2FJBVsr/T+ov20AwEDIt5M?=
 =?us-ascii?Q?k5B8kwdPAq35oQtrYDf9RM3aB/hZnadREUuQw16OS5c5uQy6aSAgfDhRHaZt?=
 =?us-ascii?Q?NvPTXZ+Nv8yDVqobw7P/RQVR/3+2Kx5LNSVF4/ItUaI6DAgPu0xxs246Is6u?=
 =?us-ascii?Q?znMLGwZ/eA65Cg/u34twqQt5naoO4NXYDcozHWKcfDtzxUza36xjz6kJy6Aq?=
 =?us-ascii?Q?mfRnmtmlNgPhabdHcS+hPObDG4a5AI3GTuhSUaeF8ziv/gI1x5/VvigCLjpC?=
 =?us-ascii?Q?XewnyO1T38xbNgKiDZcnNHcPGFNkCB9Eh2iOEKLgxSNApa+cIFvPdxD2umkV?=
 =?us-ascii?Q?cfaXgRIazSyLgHIjeW+nSmKpnjC7HXN63iUhA6KKOd6sMJxKLsL/3KiH3gDb?=
 =?us-ascii?Q?Sy6nCxSVKnj+nhA6/lZ8FHAaxZZHsyxnYIEEZNPYmPonXJ+WZttRUMBBcmVk?=
 =?us-ascii?Q?7xKZDtfst6dlJ8KgV9GDTkRwuFsV15FU2rSDFW81+pcpS9FM2fBC9/YTw+C/?=
 =?us-ascii?Q?HoGiagLo9ERIKgfy82mEqNve2frbqvsnOAr2J0ctOQ7glsMV94I40s/g//3z?=
 =?us-ascii?Q?Ap9hADfDKiTr9HrRn4b6P0thQcXUGX48o31rf9n6jLQfqTrTFYuo2+enDV4J?=
 =?us-ascii?Q?6Nli3aiMAPG3Y14XtBvptvWS6taaioLutKoRdoRUvgKCRGpx1fEyOGiwh0V/?=
 =?us-ascii?Q?RDmv6ZfJiTjXySIWBSDnRqWrLBJzR9KtVkz0cWpYNG/JLNjm6FAOOXnhcW0M?=
 =?us-ascii?Q?+P1gDMZFJ4Ft3au5bXF9uYRbVWg3ZQ+WJj5K6h+fFByEZ2F+yb4OoYiRDF+x?=
 =?us-ascii?Q?rsVQYZ6dd4VuJfzH5jdvAqivu43cisTXKhftfP2wBsu62fzyEkh/yJxZ7ZbX?=
 =?us-ascii?Q?jG+vWxIYEmQW20784j4Vl0ZqTn6AHFo=3D?=
X-OriginatorOrg: navimatix.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 54880a96-f620-4a85-b8f5-08de97cbfaaa
X-MS-Exchange-CrossTenant-AuthSource: GV2PR01MB11835.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2026 13:12:27.4194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c87b4f54-b992-4813-8f3f-4a876324197f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPXOX0fQfFkQg51+79bYsHTFb3f7dWgzEq+4BOq0pa3N8OxH8TNXoZcOIC4lcnqK3qKs+8rLtyWeMkLNw8xMgzwb/7CswI8LKI2iLG302f0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR01MB8153
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 11 Apr 2026 13:12:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3691

From: J=F6rg Sommer <joerg.sommer@navimatix.de>

This allows the users to opt out from some features like wifi or alsa, if
they don't use it.

Signed-off-by: J=F6rg Sommer <joerg.sommer@navimatix.de>
---
 conf/machine/include/rpi-base.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/machine/include/rpi-base.inc b/conf/machine/include/rpi-b=
ase.inc
index db0bbcc..7a38ab8 100644
--- a/conf/machine/include/rpi-base.inc
+++ b/conf/machine/include/rpi-base.inc
@@ -126,7 +126,7 @@ KERNEL_IMAGETYPE_DIRECT ??=3D "zImage"
 KERNEL_IMAGETYPE ?=3D "${@bb.utils.contains('RPI_USE_U_BOOT', '1', \
         '${KERNEL_IMAGETYPE_UBOOT}', '${KERNEL_IMAGETYPE_DIRECT}', d)}"
=20
-MACHINE_FEATURES +=3D "apm usbhost keyboard vfat ext2 screen touchscreen a=
lsa bluetooth wifi sdio ${@bb.utils.contains('DISABLE_VC4GRAPHICS', '1', ''=
, 'vc4graphics', d)}"
+MACHINE_FEATURES_DEFAULTS:append =3D " apm usbhost keyboard vfat ext2 scre=
en touchscreen alsa bluetooth wifi sdio ${@bb.utils.contains('DISABLE_VC4GR=
APHICS', '1', '', 'vc4graphics', d)}"
=20
 # Raspberry Pi has no hardware clock
 MACHINE_FEATURES_OPTED_OUT:append =3D " rtc"
--=20
2.53.0


