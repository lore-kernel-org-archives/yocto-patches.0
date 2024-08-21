Return-Path: <joerg.sommer@navimatix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F66C52D6F
	for <webhook@archiver.kernel.org>; Wed, 21 Aug 2024 11:35:43 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.67.139])
 by mx.groups.io with SMTP id smtpd.web11.17696.1724240139401996987
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 21 Aug 2024 04:35:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@navimatix.de header.s=selector1 header.b=sTi2HZoa;
 spf=pass (domain: navimatix.de, ip: 52.101.67.139, mailfrom: joerg.sommer@navimatix.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJkIzMZ5s8nPIEqi8Lp0veSvw4qYTFUnzATcLAQElyvaYBySBkcC09SF5cy7zHf8poAkATj9ymoprwnw1aHymfSE6/V4cCMT+BVOkufijAhIq9Ri5+gRgKvh0retUqyqI6oqYUdtM2srFO9UZL/cd0mF5ikCpZ8cq2pQoboMa3MrDmk4EZqX3Dj2XOC7RuefQXYFHxFd2NU4MQx+tzVDcxQCJ+Y/k0CaJENple0SaECggpH/GtPbSC6YJ9wRFRnmJUZn00sWkJ6QWW6KkcY+qKOfF6qUWjTbz8YXDB2FShgqLk9FJ0rOQLHiEHamGKJv5Iyufo/7vg7o/p4NNnOXzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VF1vPBmX3PLjJZ4/Gbc8T/c1R/wrJYYw7SKVEd6BhQ=;
 b=y+TVRYsu7d3vqomdlP7C4QiZH4v3hdd8EygP5Cgu6guPbmAcJnwEcshNavGL2KHun9hnv8ZOQDVE7nUuV1hr5jAHAh014uZVFRyYQ76PtEpDj5jTuu1BrCEoQwNovNTR5Jey2+d0iDBFJ1f4exTDcdCuHQuAYpxXUmb6q0rSaP0flrmQ/+5PLlA+iqibwa3ocMR2htpO7OiwBS1ulx4sm61wcyc7g4Ol9mmdFLmAsAJ8+ZCoaOZ6R3tKLdUlYE7QDwYSUmbqjPFkGUHX7oPn2maUUcM2pwbC3utgx4oRF03fcw5f6T7SeyK9/ir7iKK5w3Z1vfcml5XmcneZWretWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=navimatix.de; dmarc=pass action=none header.from=navimatix.de;
 dkim=pass header.d=navimatix.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navimatix.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VF1vPBmX3PLjJZ4/Gbc8T/c1R/wrJYYw7SKVEd6BhQ=;
 b=sTi2HZoa+IjjXhbYCIPerVS5lELv7+MpGr3WhEyID6Kca6qfxSmrHjpfwbZraFLkxbP5gNYLJYPo4IcJpp/l8LjOSU3dn8wxISDMUhgLkHke+2vS34Vr/RDfYxA2jxwXyiwlUu1G6M6xUQFHvlxC010TIdxqIlVvcbfB9x7+jKs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=navimatix.de;
Received: from DU2PR01MB8293.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:2d4::5) by AM7PR01MB6577.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:1ac::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Wed, 21 Aug
 2024 11:35:36 +0000
Received: from DU2PR01MB8293.eurprd01.prod.exchangelabs.com
 ([fe80::d520:1b9e:a30e:69a7]) by DU2PR01MB8293.eurprd01.prod.exchangelabs.com
 ([fe80::d520:1b9e:a30e:69a7%4]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 11:35:35 +0000
Date: Wed, 21 Aug 2024 13:35:34 +0200
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg.sommer@navimatix.de>
To: yocto-patches@lists.yoctoproject.org, joerg.sommer@navimatix.de
CC: =?utf-8?B?SsO2cmc=?= Sommer <joerg.sommer@navimatix.de>
Subject: [ptest-runner][PATCH] README: Update mailing list address for
 patches + add git command
Message-ID: <23f3f3e4c8010e7f1b2322976ded709912863ca9.1724240133.git.joerg.sommer@navimatix.de>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0320.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:87::10) To DU2PR01MB8293.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:2d4::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR01MB8293:EE_|AM7PR01MB6577:EE_
X-MS-Office365-Filtering-Correlation-Id: ee0b6884-32e0-40aa-c2fe-08dcc1d55fad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?domQjTZkwxn7UGde7diekUmnfw0MuNmiN4QjsOt+iwLURV2KXTrOLvp0yMZ3?=
 =?us-ascii?Q?0qh68JDFuyw8FZsVWeZQSmSKkB5UbgUBRkxQIkCoCFBeQqaWj1E6mW7j9u3v?=
 =?us-ascii?Q?iaWt9JC+hSiAstglXeLg7jN54E2J0qq49CLsXwbCfZgN1EBhSPV5Zl9MDZXV?=
 =?us-ascii?Q?H7R/0xILv6sL7JiGV18FjgO0traCVQaG9eNnCnIWqrQlJQ87eylD3VuEV8G0?=
 =?us-ascii?Q?ecLyz2c3Xojw6Emq9hmWSYXm4nCdRHpj7XNOB9uhlO84F/3AZP8TRiNjTk85?=
 =?us-ascii?Q?paA2fakKiKbeFLeueMBmzHxTHF3/BcrT9Fsxup+qzB0OleazdeHyxVTWZmNL?=
 =?us-ascii?Q?TDgD+mHl0pQ/kFuxrdFuKToCT6X3zu6K312jFNPnTmTJzjtfpyHRb+ZId3mF?=
 =?us-ascii?Q?qGxcz2Kc9SDKab4yQB2VT59/IRy5+t1igoZ57Yd5WOfeKkf8zWw03tZgPVKT?=
 =?us-ascii?Q?bs9tGrZih2T/jjuN0TAt75ITwEr7TO93XuhSl4o6anm6sBpoID5kcYAfH3Dv?=
 =?us-ascii?Q?kJ72LglN4PevMDvcs2AY8mzto7hyNGPin7H91Z3vsSzDi97fhHQ2jtfZ2Ex8?=
 =?us-ascii?Q?j7EZLvILlwJ/QyGck+Rxm2KONEPp5wJZV9XCfSHyQ6PgNTswFDdKzq39u9zO?=
 =?us-ascii?Q?wDJXX1PwTH+pmIrghuRgJTmxSlGMtN7Q3kH8AWU8BEDzDRPXSNAamSMK/Q7d?=
 =?us-ascii?Q?nX63NfbSEUjpgopsCj0fZSTLVZ2wWF9E3zhFw3o0Vv+C1335BMYiGhUsUZ/F?=
 =?us-ascii?Q?/yDRbO98fEXxBeq92THSptqx5xpIwJrfMxqTAyT4A2IvOhp29SHtro2ff7At?=
 =?us-ascii?Q?qmC64MZK1MRaJdOPa9Ljn/0oP04D3PkKphQMP7WjL3vBLux3GXGj/wNmqQ4C?=
 =?us-ascii?Q?o8htEiU+qklWZ/BJr5jofmUF+c3O1+yEqeM1wHG+jj8SKaUXcmlMRw2sMuOE?=
 =?us-ascii?Q?tAiLc//TJCuTT7STFDp1S1K4ahP+w3yP6Oe61+bw5+Qm0oaLu1/tEXxRKmE8?=
 =?us-ascii?Q?lhQBnaJ28Kp+MPWg+Mpf5MLfF/vZG0Mlgh/ZUoFElXN77NlvNbL9F/MYHuz+?=
 =?us-ascii?Q?DqliQrio5VNqkA1VtObG2FRi1UGL8h4rltCDZf0UEOz/0b5iVaMGwPo/mKXh?=
 =?us-ascii?Q?7bn+ksRmQAzR6evNYhMRq0yBL80OdxMqTBLznkpFyjpDZnf4Oals6siInso2?=
 =?us-ascii?Q?Uj1cjzFvLKVpW50xve4AQTj7DYztnJA6covg/mDf0KZYK7uKK/VfLkPeZ6v2?=
 =?us-ascii?Q?8GNWuwCH/YlBuHGAxSKj2x1HsFx2szDbQ7ZzP61YYW/5xsJ0R7b8dbC2ubGK?=
 =?us-ascii?Q?poQGRHf2sQk38AJBOemuGUgWsjV3GFmd236i9Lgg2NBW4A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR01MB8293.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hQzkF7BFdfSIaq2yhx2WCrZFwyxW/jICe/Wwbx8993aVJsElaDZydS0QEpb1?=
 =?us-ascii?Q?2TYq8S1diVOgHMTG0KSYx150uYX7nlj3OTLABSPmBGJ1+qgsQ9kJEKSZ5t4v?=
 =?us-ascii?Q?UUDdOPk5XEf+kRiw0zmE+CEO7xPtoT71Z24eMsVxnI+Z3Bg16AoTeAQLonez?=
 =?us-ascii?Q?UJFqU6f2M9Jqek1CEaq3neejgTTdWsb4FVDmwiDKq8zFf9EgDVuqA+dB0hpP?=
 =?us-ascii?Q?ZFVoERmD/QblgbzN0mNj/c7M58/tPJrbcYHJQGKB3Qz4C9x0cKz/DoYbp2ee?=
 =?us-ascii?Q?4EMwgqCYV8Ei3UcO0O1QroqstYDd9gIGQGcO1l+Jj0T3Y4xLJCtt1+SQQnTW?=
 =?us-ascii?Q?D0ANa5z8kdSaeWRsSJv48e6gHg0yho7XUks/SoAhizjcTCzIsKi6UxIOpN7g?=
 =?us-ascii?Q?ArkJXyUVBgdiZS89HbH8+pUKOC1jSH7QKA2lncgYraq2Upnl0qlxwHGWs8WC?=
 =?us-ascii?Q?ruc+pmvsqVnScsZHUWYqv7fKhr8S7dOeYzNM3c21+vnxxeRb7plogmQU26TD?=
 =?us-ascii?Q?UrWXSgsMc08Y23jornrfmRCXtQYsEqYDbiAyTiX/s/9yzZ6a4GhEWsyweRxO?=
 =?us-ascii?Q?DIhIOHf0w9FFZ4Xshkm35uUKEe6DtelWeHjzDGf8y4JnBT5MZIOrfysmVaXu?=
 =?us-ascii?Q?kv1//xFu0tVAXyFO1L6PMiwgcqNRLWHBMK5cSCMIPmQ3dmgnkQuxsDHVlQJ6?=
 =?us-ascii?Q?lfYbTMnetcbW7oxj4xXl7Xmhc1djype6y2xYx0rt1Kfc41KI4d3BqRsCCLAe?=
 =?us-ascii?Q?ANGwdM0+0h85vf8F3QskbzGjI3GJDAWzNPo4UgRz9lm/k/lnJHJJlxUEzqdQ?=
 =?us-ascii?Q?9iPHSQO1Q8QlNju2E9btTkOseIGDsD/ehckBM6Z+tmyytvp6HPPtA4v5/xg6?=
 =?us-ascii?Q?auknP8GOF8p28ShLR9cY1WuEZRFmDJOjWDncHshjkFSbtxftL/5Qnw9YQoQx?=
 =?us-ascii?Q?Ea0tfvRJ4OlBfYzwd1/2GqYDFoEILeg4jEXEw/5KiLly4krLnO1rMQzymXyy?=
 =?us-ascii?Q?eHw7xvfXLLYDOi0igAAGJbuS/fpmq3wD9uokxU6NCyeEyYQguM48jnOMwcyI?=
 =?us-ascii?Q?N0ZwC9wJ1UHY/y6uAiRFDxCdpa9UUsnvisFVIGp2MC5xM5jAzgACJd+hlH8O?=
 =?us-ascii?Q?2TfsTdayAq+NJBx4+jL5UVHJQrcadYv19Ux7V97E1hj8UsI7wr4R1rQeCy6T?=
 =?us-ascii?Q?1ZXKhXk8S7J7CDyQBXvmlPQ1NIrtO4kXwjkzNx2UHMT0iOQ2mK6ggijxNPLi?=
 =?us-ascii?Q?NK9TvDqcDnrWeQv47/dVesIRMRtuCpx5mdyHzSsGfWmnRVBjmyS35TcGeSC+?=
 =?us-ascii?Q?yrCD+8jpHGxDlAEZ1Ncs5FKU+aa1Vu+3d0wHxyVPtjwjdkFw1gfUCR3LoyqY?=
 =?us-ascii?Q?OKIbcqshBIVymB4BAdUG0aEW2POwa/yMkuG5+2ZenAM77xjjR39CizX3DHW5?=
 =?us-ascii?Q?0RDv/T9h5k/YJM06CcwlO/zB+R4/ABgqqy3xPuP3X1ZBE4Y/oEAh7D6wvllj?=
 =?us-ascii?Q?3RlS2xrKpPbp4rRhECIxk6kXYdnVyznM3bTdtYkV3bcWDEn0r+9Z5FVd6Xyi?=
 =?us-ascii?Q?N/UWeKBSX7VRZI97Pr0zta6OTu9dPxBMntmYywGY8odxZMFJuRoK3ChTKLEy?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: navimatix.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0b6884-32e0-40aa-c2fe-08dcc1d55fad
X-MS-Exchange-CrossTenant-AuthSource: DU2PR01MB8293.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 11:35:35.8279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c87b4f54-b992-4813-8f3f-4a876324197f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gk3Hj9T+RbkajQdcKEjVxg0On7ABxTWrziWBoa3/n46Onh5mncl877LjsukK27GG5ZpSSNHJ86KFRUJrZy5JP0jhvNV7Oo6415zVA/j7tts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR01MB6577
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 21 Aug 2024 11:35:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/540

From: J=F6rg Sommer <joerg.sommer@navimatix.de>

Signed-off-by: J=F6rg Sommer <joerg.sommer@navimatix.de>
---
 README.md | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/README.md b/README.md
index e6f548e..8afb161 100644
--- a/README.md
+++ b/README.md
@@ -48,8 +48,12 @@ $ mtrace ./ptest-runner $MALLOC_TRACE
=20
 ## Contributions
=20
-For contribute please send a patch with subject prefix "[ptest-runner]" to=
=20
-yocto@lists.yoctoproject.org.
+For contribute please send a patch with subject prefix "[ptest-runner]" to
+yocto-patches@lists.yoctoproject.org.
+
+```
+git send-email --to=3Dyocto-patches@lists.yoctoproject.org --subject-prefi=
x=3D'ptest-runner][PATCH' ...
+```
=20
 ## Links
=20
--=20
2.34.1


