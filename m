Return-Path: <joerg.sommer@navimatix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDADEF3ED51
	for <webhook@archiver.kernel.org>; Sat, 11 Apr 2026 13:26:43 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.111])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.196567.1775913993248011621
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 11 Apr 2026 06:26:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@navimatix.de header.s=selector1 header.b=ZP5IdC48;
 spf=pass (domain: navimatix.de, ip: 52.101.66.111, mailfrom: joerg.sommer@navimatix.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUfhFDFDIf70vWvBYBnDmEX9zPyrqGOGx90In7hdTZPzUg7a4hdj47hA3WiCRAKbF/hsYjV+Ox1FbWSiWag+BZ1bi9Smf+6a96J2nu9wImE0J3S+jcmInI33ESx/L2K1QkQyMnL9+heYyZXowU2QEoNxNZxKABD+6AXAXTEfSmMkwIcG9g1a8Wsn/njL+GX7+BVNj2j9TFF2fploE9NSAgGUbkpFZJgv6gQJ1OjFcyW08Wo9MAShcWKcyi6yVRr4LAPJz89ZgZBN4Usmf9GNUt/fnEsYIn9io+FsXpEWIle4EdgvVCdxbCfKkDlcYZgWnQFqZauIx7e+/EewND9X2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Nk4AG2EhYLTHIrRNkBQFtECpyzs50RKcSkMA8tgV7Q=;
 b=FGnlEOlupt9NKCZhM2A9VfvXIAxEPlmycGGGwSs7v1/NP8LVuMHx9Xcmurd/tGI5TbcoWMMM8yXdXCe+j+kOwM1/unqPMjb6McUBP1NC95tF47DD/cb3YfA4b4nt6W8tcrqy47BfNPk4cY+apOh5MZ+yz84i54DlJv5LkHYr+wFf+lYYJKNgvTDbIHQQra5uuiFm2IMMFW5G2U4CuKJYtN2RoDpNadryAuhD3UPROtzu1YGfYV7hZkk5pA4Io7iOHADo3Ubh6xkIKT+E+kKxgrkIRjj/M5pKHnRYjNc/li0gSGmLPfUzffrO7zX554E00pXarX4cM2XPB3rbT/GDXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=navimatix.de; dmarc=pass action=none header.from=navimatix.de;
 dkim=pass header.d=navimatix.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navimatix.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Nk4AG2EhYLTHIrRNkBQFtECpyzs50RKcSkMA8tgV7Q=;
 b=ZP5IdC48YHyEfyEggTkcgm4D6rqvA9PMO+hK1Y8xzhk3K4Kd3SPlkh+sKkWMnIaPGgeLpA2ZP/Wdp9biCy1wAM8OuYX+NLsfhkwivPeUGvT4u26PbDl7GZ4TqcAy/T4v29cA9G7D351id+aWa9CLfcujHWAERjHt9mOJdme1S5U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=navimatix.de;
Received: from GV2PR01MB11835.eurprd01.prod.exchangelabs.com
 (2603:10a6:150:2cb::8) by DB9PR01MB9248.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:364::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.46; Sat, 11 Apr
 2026 13:26:29 +0000
Received: from GV2PR01MB11835.eurprd01.prod.exchangelabs.com
 ([fe80::d5c3:2dea:3d98:25fd]) by
 GV2PR01MB11835.eurprd01.prod.exchangelabs.com ([fe80::d5c3:2dea:3d98:25fd%3])
 with mapi id 15.20.9769.043; Sat, 11 Apr 2026 13:26:29 +0000
Date: Sat, 11 Apr 2026 15:26:28 +0200
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg.sommer@navimatix.de>
To: yocto-patches@lists.yoctoproject.org, joerg.sommer@navimatix.de
CC: =?utf-8?B?SsO2cmc=?= Sommer <joerg.sommer@navimatix.de>
Subject: [meta-raspberrypi][PATCH v2] rpi-base: Use MACHINE_FEATURES_DEFAULTS
 instead of MACHINE_FEATURES
Message-ID: <ed96182dec829878465b40904c93739be8255ac9.1775913987.git.joerg.sommer@navimatix.de>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7c::10) To GV2PR01MB11835.eurprd01.prod.exchangelabs.com
 (2603:10a6:150:2cb::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR01MB11835:EE_|DB9PR01MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: f85ea9a4-fa2e-411e-b9a7-08de97cdf067
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	pVPPj1f7B/VQbyX7WF5ndnCAgEYu/XR1vPl5DBF+z2NefZ8nqXdyiHZdBIejwrO3WuYvEWDmQ5Kk2DB13+ucIZmk/6J4y24pMU+YBaE1Pw9n/Pw5B2IACPaNbwg3LG1g39bxCf/YaT2XCkN/1MEQnvGvmbXVftFEJbbsR29r4VJ+A/2q5O6dInKquTBjaFqemttIt17ZWkaByzHfS0K2JqEXSKml8NU7pX35K74ZOahrzgmRiydzzdL0LpHJ8Rc8kvrAGLJeIawNCKvl0rOJPHhSKjRa4LMRdRiiNwxuJc5Np6lbZ273f4pn2uF8w25y2KPP58122c6CHmWN1TEIaCYIkROLgWpz1rYLQPzxevE9rYQJX70lFTDshYNLSa6spe6FJIvf2kQ72TFYJMSok8Kvy8jV32KebH7xRojFbzWRIiBVzP1uiUcPqUL94hfy8Tjv2S//JyF/Hyah3Tz3BWNYxpTho+/n10Z4RFF+ZRQChinF/g8OSo91Khji81NoBEODSC6oqDmC5PELBtZl0UN9uzhjhvVZvNoGrxH6oWf2rMUDSZ8OGKHPXD7qm90LkPw0PMfwW07nUM0EMT4lXpZwPUMSVyHFLbxK5EvvDHNwZ99gCkKydR+EMHzk8d2KmrNo5bU658dzoiyDWq0KFbmhyRaGDsZa21NPLP+u1jW8m7MLfAa1qybh9yVw01NvQBR7zsy3HLCDut8adn1CKE9AS52qIot0VCyF0duC8Bw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR01MB11835.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?odF46WchpVOdlXWlNJLrNx/B0i1TRkk2Ed6krNPaWPNfw1CaIfMhkFHER+d4?=
 =?us-ascii?Q?5GrGwbjAHbt/7l4YMAJ8pRE/VwtcYYO8b4H2ZnNLy8ja6VbkOGhk44vLoCXE?=
 =?us-ascii?Q?AxBRZH7w321szFFZzQ84MZj0tjt9Ox1i+ONpMfz58tKgr/B6z/kkF6xZgS7t?=
 =?us-ascii?Q?y4N1ewKoiw1/rg9/eBvltPFFZJMkqDCw/a1H+qlt6j2ksGfIa72gd9iDHk9E?=
 =?us-ascii?Q?T1hr4QMrzrrIYERyygVoCp5Yv0MTzYUrAI9VQOVrrCL1L7fUjajgeNt23jb7?=
 =?us-ascii?Q?+1h50INV0HnjEdAdUZkgrajKjzeXLiCo/hk6uxUbknybkDjTQmpPKiylel0j?=
 =?us-ascii?Q?g4IuJP+9MJIN+cWAJQrskI0/ZmmFk5dSAhPyBrX7q+iGWCptt+y9coKrZhK1?=
 =?us-ascii?Q?kvjECr66jfr0P4VNYn6Z6XF/WNzJs+2PvN4nVz4iqZ37pm0zBDVarDRXVDF1?=
 =?us-ascii?Q?YraMlMGmeDEId/TY3LDpKvuj8VmBEFBvZ7uthGLDsPcjNHpAFOjXBQ0Lwb0Z?=
 =?us-ascii?Q?eTMnmWlZZz21d4ZCbThpwEaJVxah3O6n2idhqcTxMjuWuv8fPXDuxPbeOoqt?=
 =?us-ascii?Q?E4cTBHLw+wI8hp3gREdVSyVpMlWA4SuUEVepz0ImdH9gRhEn048/jqb4Lm4k?=
 =?us-ascii?Q?RkKHcOzt5lOGPRCKkBMMXdQCKgAiq8jdxcbMSNBPPbfefQ6S+M6ZYsXt5rcf?=
 =?us-ascii?Q?/WD2sTMewOi/WOt0MQ1zp1iq9j/82ihZoTOIBVbzANp91ylxvgNE/iJs23v9?=
 =?us-ascii?Q?xV5BQd7ukaYaBwaMP/lvlyPt4X5zRmgeWGhM2+3WiF5XisZvS6PF21gro3Nu?=
 =?us-ascii?Q?5ckjPnA4+kkFAuc/j5EJOaxINySlZm+kOTEsbQQr2/XVOnMGeFZufxE7envM?=
 =?us-ascii?Q?zKlPAquV951dK2zho6ZGGjrY8TxE46Q8MYik6GmAZ18FvmnIFZZyZBWlV/9V?=
 =?us-ascii?Q?sqIS75P71SR8t1Tjxf3EToQB0sxsYbGcace54SSJuQy9AJnlKhkIy5RUmYdc?=
 =?us-ascii?Q?Fin13Qpyy6YopcyeRWWkFOYo8vNNqMyxRTZilqLyGXveC5WzRhu4vLVL8ccT?=
 =?us-ascii?Q?d/sqFJxc8qTsV4kGVBC14BOleRoFq3WBgOoi9co5/9+MqTSuEiryx5bisVpr?=
 =?us-ascii?Q?QB6EHQabfIuPj9pVpyY/+eG9jc3q8craDx1rjxe32sv1OfpPlDvdqdMSdsLF?=
 =?us-ascii?Q?PI5dHVys4C2qSx8NR+sROZ2ny6mT0c+ePFRbyWwqerattdU+DyHg/OtK45Ve?=
 =?us-ascii?Q?b9M85eJuo9Pac3wjiUoySl9HPrkEpcyyQuXwDpp9etmJWZtEM6ts3lSrIipU?=
 =?us-ascii?Q?ZC9byZorj05qR3i47xDs+C91c/H6x5hxxChkXu4XOpz0qNiGrBWBXzgusvd8?=
 =?us-ascii?Q?1wWgIr7k+Eq3Id4E3wMZ8QGcx50InfoCGz956f3XGg6VWRrMnVqAsdmyXUDK?=
 =?us-ascii?Q?4vTMYVtTvRziwIkDBYbr53+f7K3i1k/lv8FryiVPOjk95CylI7zEqhdBaeFM?=
 =?us-ascii?Q?Tb/5f6Ao5b/2U7nSq07EH5G4FmtwZfWenucZmzVjgh1p2MvBgYgVXdE3tauX?=
 =?us-ascii?Q?1majq6oQxLt698XMy2P4hzUpJzRnHAWAaNf/r2NO/yx/SB49XTNvtzKv6n2s?=
 =?us-ascii?Q?0iV5P4ascEsSPkUgybgfe4tx9mFThwFMA3ANCelUkZ6oDfPoGZfy5yUWWYFS?=
 =?us-ascii?Q?E9AmC/1XvPZ7P+JKIItRVWmWE+1wVCjY0B0LbTdiL+L77+SRGVQhGFGFu93c?=
 =?us-ascii?Q?+o4hhoNnQvkCSdsDadSs1Gjb6fui54g=3D?=
X-OriginatorOrg: navimatix.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f85ea9a4-fa2e-411e-b9a7-08de97cdf067
X-MS-Exchange-CrossTenant-AuthSource: GV2PR01MB11835.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2026 13:26:29.1570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c87b4f54-b992-4813-8f3f-4a876324197f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebloXVqD7fAuV9vIgt6RoRp/nygGG5VyPQdkGPFTgr16oomh5KwEnLV8L8p8tPXDyGzUol1dQaMlbXfB6THRbtpQ0U59Tu2ZLOB1p13+RrE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR01MB9248
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 11 Apr 2026 13:26:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3692

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


