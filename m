Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.19])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2420.1792743328977103412
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 23 Oct 2026 01:15:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=MLtkHgGx;
 spf=pass (domain: siemens.com, ip: 52.101.65.19, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajfA3zvzs4BMtZ8e5PCRXAOZOaQTMgj/nDH5J91yjTqefHRZC7U9qjGnI8oO55zp7vVMIUmssH7S378ulTstnkVo79KqtWIUeG2EU4CA78JUWVoDzO5Z5ALh10xvdu+Nie3eM255kKyUeMMyxO2SY/ziP6QZG/H76lGAiWpqTaZjmZ4+ZqO/K6w+cXSSDRupVz7NOcIGvpNXArF3H0j4u+G+sSFTj3Rlb6Zo3XbZ/nCt/f9cNb8iAzNav64GlqTqFEp4gdOSelI5IQYrrw0FQ7k+Xct22byCzkO5eHhuxexQ7QfUOSBG0kMNhq6f9Rn1/qZDG7ae/BaeLGpwnTjVxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XllMxGXQuPXr5l3h1wZAegXwPuIfrb+UOqGwZSb3bDE=;
 b=RrC+4aCHCD45f1eFH5BoSiDtb+codR9DgjqFan0551SwPLePx2W5iAWJGgV+fCRso/HLrYnqnKalTbI3wCXWXL8b8onUwCjV3gtelomzVnCDm0PmG2yiDxXkKp1IMWm6DJMKTQ2fA+vZ/PQeI6pDUJQF0FQ0V0GwWSMnIQLbNvq+BQguTMdinkoNaHOs63wnEQOScTjE/sbVTKuZKnvAl7E3jKT+xU1LktGkOw0y5HMbGlZuVuxSvv+UKxaGjn6BRMQP2Jv1spE59bhog2wMGCGJ66RJQfL11hCw/aQ3prQji+vDgvokR9uI1W0ELklGrsorrQForMEhMrSQtMW2Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XllMxGXQuPXr5l3h1wZAegXwPuIfrb+UOqGwZSb3bDE=;
 b=MLtkHgGxRU1f3PrI1X76h4OdIhtep+EBxwQYcVNGbXtEUax2lXYRNWMBud+5lBUZ/nuFyMkTWYQa86hLUqXdWeKEliixsG4tC6tZvEwZHn9dPh8Zh/oyR2E4MP0LDZECr2rJwjH5urTttP9eKR2KlA5K/WKRcqD8mA+GHXc09VZN5uFJCoH7GIwZMYoephh1CPRVpqQ5H+inExTKDwJV3qKq+kvrmUx29SFSRRECBTZgBKUqRq8W4qUrSqLInGZlJRGs+WQ6tPXcmiaKMOCSjHWSYuqqRvETddwqKIYDFqd3Gr6t5fJ3QHWK18RIqZo+wCLdQ/SnnD2ckP8JL+l+VQ==
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:420::16)
 by DB4PR10MB7471.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3cd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.3; Fri, 23 Oct
 2026 08:15:24 +0000
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008]) by AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008%6]) with mapi id 15.21.0569.002; Fri, 23 Oct 2026
 08:15:23 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: "jose.quaresma@foundries.io" <jose.quaresma@foundries.io>
Subject: RE: [meta-lts-mixins][wrynose/go][PATCH] go: upgrade 1.27.2 -> 1.27.3
Thread-Topic: [meta-lts-mixins][wrynose/go][PATCH] go: upgrade 1.27.2 ->
 1.27.3
Thread-Index: AQHdYnNF9hzvwt+oIEKeyVk2/nfDS7cKyFZA
Date: Fri, 23 Oct 2026 08:15:23 +0000
Message-ID: <AS8PR10MB5073B183ADADAF384FD29892FD642@AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM>
References: <20261022221813.3539445-1-peter.marko@siemens.com>
In-Reply-To: <20261022221813.3539445-1-peter.marko@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=c4dd1fb6-df2e-4384-ac61-92e1c539ee8a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-10-23T08:15:09Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB5073:EE_|DB4PR10MB7471:EE_
x-ms-office365-filtering-correlation-id: 915ae1b4-beb0-4fa9-e291-08df30ddc9aa
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|261009223027099003|261021123027099003|261022105027099003|261021121427099003|10067099003|56012099006|6133799003|12006099003|22082099003|18002099003|55112099003|11063799006|38070700021;
x-microsoft-antispam-message-info: PjAEACIQnjHsyHN/RU8iYwXV8vSLEz/9zl4Zp0JMOaQe6S2PbdthBWo4OlwLQVDRVTjuESpiMlF90yL+1+CSRcTnEh4XPp/3o4j09uCKVe9oMmBg6yiJUBPW2tXHVBl+/Me+bAGJhxnA3Io9U26EUTVFR4HyuaBUrm+Dlj1zEy+WETS16pOC8s3sTz030iu8u8NoRu+lPAZOsGe+/z6qYX/g+PMtDdyDQftsmzUDhZYx3Yv+wKxfcIh7GOFAXNdK0b0LnzLJLuDCG8Pam8uSnyzyu428rgVaZTz9X8HoyK7re1XXaxBsxzSKiMLlSumoAze7Rf6rvK2BDTqsRedfgzbI5VT48G8coklVs8+s72K+LMoGiHYPjtpBgDg38CbMdCaqaCp1nDE5FNAljsfloqBy+9UwUGfJIiIt+s1N9UABEXYIlPkWBj6au/wJyXc0anEzE6cRrVsxvopPtYilNp0vqn1cMzm95Jk4zs8Vt/X5/ffsaKDXgUfDIHLhMbGXmZM8kPzsY40WQbMxTiYd3EsDA+1NtnJL3EtH8kz04aSWjakIfwDWC4I3nftdN1pHrvLP9N03q9JUSUAjDUoMoJvhv9R/pDQuMEUrQjQomFp26aifav5S+eZsas6hXfLNuXF+bpzNMm4PrSJN+6HXO7104pMmLqnkTWIqEqgbHjI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261009223027099003)(261021123027099003)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(6133799003)(12006099003)(22082099003)(18002099003)(55112099003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OLKxh3+FvIqlFrkbl11HQbcvMDpR4zA7xijkdCneWM5lMkwys2MCUuPyyRLp?=
 =?us-ascii?Q?wT9o9pOZGdzdXcbZAcUflfp5wq9GGETQ/Zpxipc4ZYyDk5iPFlGHWZqnben9?=
 =?us-ascii?Q?rehDce8Pvfu2EC95wNpbW3QMaUXzGcMxnJsf5TDqDn8HvtbwTyVodXnrRIeC?=
 =?us-ascii?Q?H6Cw7u0m8wBN6kDEYD19wUvqGfYk+iQWA9/cBTtuDJeuHgUI5h3OhXw6thmB?=
 =?us-ascii?Q?J9nCrsoYRRw8uzoxARI3o7g8I49URG/7U6AygaxBqmwBw41yreuLPNBSHSvC?=
 =?us-ascii?Q?wPz4y6+Be0mREcpsbKFeDtqurex2OkmiRBGdgOsXbbnBG9Q0AzCUmpW9wcgj?=
 =?us-ascii?Q?zYWFP8XtM1QPHIjBOHbYOxyrKF9bHc59lAsTtL3LGe63w6C5o/RnHslNiqMC?=
 =?us-ascii?Q?mnYjcojdDBXqG0K5AxYRW65YAofXndsZOjfHZcQaFIMaL8juyi+SMlyyFwmI?=
 =?us-ascii?Q?RjG8GZj0Voz2sm9bUWft2/HUKLlzqVEdCLXzJc9KzGGzUhqeOjWrz44MJm21?=
 =?us-ascii?Q?IqcZKy26D/CDhdxhIdYKzbHQTW3B1rh5Pgdio6AFRAmLyXhXWH2JjXExCCqx?=
 =?us-ascii?Q?DYcf6yJ1CSo6HS8A1tAzbcoMrWYAVw3c6iMf6ykoHwyXDeqSFVn7irWuNFhr?=
 =?us-ascii?Q?tgnvf7P1RhruSPe5OV45fcaDaUXTIfIM7q355VyXiSBVLFLqenTY/cbfieON?=
 =?us-ascii?Q?EVptoPdHDPVdiie0wB04MTHORF7L0WlM0ytStnEPplK0RAW5kfUF8/ggyz9u?=
 =?us-ascii?Q?N8a2X8/ML620yL6eN9n6LKUAApD4tqFJyRB3lchqctpFJy4tq4JK7PABfQ3C?=
 =?us-ascii?Q?f6qOix0ENMdIZ7qG3hW8vlztxyU4Q0Z4UlGd60A++Fvr6VyZ82U8njtYYtQn?=
 =?us-ascii?Q?Gl/Xl1f//6bfSESxkxaVn6IRgQB8AWUhQiH1oOOeevJzrsshf4WW0VJy+5Oz?=
 =?us-ascii?Q?KPW4ySdYwnPn/tJvan3czUtl0Yf/fHAdc8VYA4vRbg1r9RH8wiQ7yvxG9+rs?=
 =?us-ascii?Q?EcIjswXV5ikJgRSjz0TqeciVSd8DIn7fbcb+9/dTxDN+fD5ddUJlu4+t3OBe?=
 =?us-ascii?Q?xFMQFie9DCriwx/a0vQCSm8plulwhVvn6P0dam+rBumq5A6F8kr6EY3XKhT+?=
 =?us-ascii?Q?tBWZSbiggPrHxSNIK2nMn0DfBQe9Mjtr54eTU8DJvpCUp5QfO1PLlmtEwsKY?=
 =?us-ascii?Q?Fh9wMvR805yvPMFqS2Drw+FwdQZEhAx9ulFAjjWaGSDpPYSBYDW2FCk/+2ry?=
 =?us-ascii?Q?vqRy/AZd/j2sxd+EzA38gJC6d7yQalIgAVyJgRFU9L46uTJ/andKoXCnADhl?=
 =?us-ascii?Q?vHB8kP+sD+jspswoy69aaJ+MWxHAJ6q5mzsNL6U287cvVZFTc7v71hj+QgK8?=
 =?us-ascii?Q?h7V4hQqW43H9/zqP7gpfz6N0FcGczgU4nQPvj1Qjms2JSzSZSGAcoSZ80LrT?=
 =?us-ascii?Q?Rtn76KCUIHPRZsNjx1UOU49WJNY0/jn5TBUBxwtsuewsCWV8VYcj1QLU9oZ4?=
 =?us-ascii?Q?i4aU/5/+mYyCggxqP1xoaSObnbKxKSBm7ymmcW+DBhiJuudrGL/TYNOa8JWx?=
 =?us-ascii?Q?8e8S7u/plPZZFL/H0v/hDiQzThgTnaOQYs9+/ICPa/ZCLh8BOx/k1MYq9vkE?=
 =?us-ascii?Q?26uxFz4HoOV1OSDuaQA3+7x0Ooj3h1/gU9s9l7FeuV0/L+C6Z6M+yT0yWiqZ?=
 =?us-ascii?Q?ksY+geOzK5PKQVAjrevTad5Ja5elEIDVn/i4pCTx/wR5ToeOe9x2cE8+ERRf?=
 =?us-ascii?Q?76khmutydA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 915ae1b4-beb0-4fa9-e291-08df30ddc9aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 08:15:23.8616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zdTtpUSwS4EuMJevJwuMRQGkHdG1wPmB6aWmiuenKYb1q+AkZAPkXJkdgOFSw09a0o41PN1w2PrXpU9DkeKR/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7471
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Oct 2026 08:15:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5143

This is now merged

> -----Original Message-----
> From: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> Sent: Friday, October 23, 2026 12:18 AM
> To: yocto-patches@lists.yoctoproject.org
> Cc: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>;
> jose.quaresma@foundries.io
> Subject: [meta-lts-mixins][wrynose/go][PATCH] go: upgrade 1.27.2 -> 1.27.=
3
>=20
> From: Peter Marko <peter.marko@siemens.com>
>=20
> Upgrade to latest 1.27.x release [1]:
>=20
> $ git --no-pager log --oneline go1.27.2..go1.27.3
> 2aae1000ea (tag: go1.27.3) [release-branch.go1.27] go1.27.3
> 90617fb7ce [release-branch.go1.27] crypto/x509: distrust a handful of
> intermediates
>=20
> Fixes CVE-2026-111943
>=20
> Release information: [2]
>=20
> [1] https://github.com/golang/go/compare/go1.27.2...go1.27.3
> [2] https://groups.google.com/g/golang-announce/c/66pojueaQek
>=20
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> (From OE-Core rev: c21ed25472ea3b29dc10d4c5500d880c36477c3e)
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> ---
>  recipes-devtools/go/{go-1.27.2.inc =3D> go-1.27.3.inc}        | 2 +-
>  ...o-binary-native_1.27.2.bb =3D> go-binary-native_1.27.3.bb} | 6 +++---
>  ...cross-canadian_1.27.2.bb =3D> go-cross-canadian_1.27.3.bb} | 0
>  .../go/{go-cross_1.27.2.bb =3D> go-cross_1.27.3.bb}           | 0
>  .../go/{go-crosssdk_1.27.2.bb =3D> go-crosssdk_1.27.3.bb}     | 0
>  .../go/{go-runtime_1.27.2.bb =3D> go-runtime_1.27.3.bb}       | 0
>  recipes-devtools/go/{go_1.27.2.bb =3D> go_1.27.3.bb}          | 0
>  7 files changed, 4 insertions(+), 4 deletions(-)
>  rename recipes-devtools/go/{go-1.27.2.inc =3D> go-1.27.3.inc} (91%)
>  rename recipes-devtools/go/{go-binary-native_1.27.2.bb =3D> go-binary-
> native_1.27.3.bb} (80%)
>  rename recipes-devtools/go/{go-cross-canadian_1.27.2.bb =3D> go-cross-
> canadian_1.27.3.bb} (100%)
>  rename recipes-devtools/go/{go-cross_1.27.2.bb =3D> go-cross_1.27.3.bb} =
(100%)
>  rename recipes-devtools/go/{go-crosssdk_1.27.2.bb =3D> go-crosssdk_1.27.=
3.bb}
> (100%)
>  rename recipes-devtools/go/{go-runtime_1.27.2.bb =3D> go-runtime_1.27.3.=
bb}
> (100%)
>  rename recipes-devtools/go/{go_1.27.2.bb =3D> go_1.27.3.bb} (100%)
>=20
> diff --git a/recipes-devtools/go/go-1.27.2.inc b/recipes-devtools/go/go-1=
.27.3.inc
> similarity index 91%
> rename from recipes-devtools/go/go-1.27.2.inc
> rename to recipes-devtools/go/go-1.27.3.inc
> index 86598ad..7c906e8 100644
> --- a/recipes-devtools/go/go-1.27.2.inc
> +++ b/recipes-devtools/go/go-1.27.3.inc
> @@ -17,4 +17,4 @@ SRC_URI +=3D "\
>      file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.pat=
ch \
>      file://0011-internal-cgrouptest-skip-when-cpu.max-is-not-availab.pat=
ch \
>  "
> -SRC_URI[main.sha256sum] =3D
> "03495da2ba64894d40f5c4992e49454fa78b50690604ff92b6afff5081b76e62"
> +SRC_URI[main.sha256sum] =3D
> "6e7749035cf360f06b2575d162ea79df9fda8ef671889e5c375f8e50777f26bb"
> diff --git a/recipes-devtools/go/go-binary-native_1.27.2.bb b/recipes-
> devtools/go/go-binary-native_1.27.3.bb
> similarity index 80%
> rename from recipes-devtools/go/go-binary-native_1.27.2.bb
> rename to recipes-devtools/go/go-binary-native_1.27.3.bb
> index 19482f7..c245af8 100644
> --- a/recipes-devtools/go/go-binary-native_1.27.2.bb
> +++ b/recipes-devtools/go/go-binary-native_1.27.3.bb
> @@ -9,9 +9,9 @@ PROVIDES =3D "go-native"
>=20
>  # Checksums available at https://go.dev/dl/
>  SRC_URI =3D "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-
> ${BUILD_GOARCH}.tar.gz;name=3Dgo_${BUILD_GOTUPLE}"
> -SRC_URI[go_linux_amd64.sha256sum] =3D
> "ecbadb99091a3f46e31f5f934b068b1864eafa7995211b39eaddf76996045fe5"
> -SRC_URI[go_linux_arm64.sha256sum] =3D
> "94f3e30b8e374bc285e7dadc11e0865726b9bc6e85b841ccceaabc0214c6b7c8"
> -SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "059d5f01b1607a724ea5ae87c5589041a51c577a6f3f20099e49d00f31c803fa"
> +SRC_URI[go_linux_amd64.sha256sum] =3D
> "65efbc80fdc1fa2cd2631cad5b481777a68e8725f34e89f50fc6ac714e379b40"
> +SRC_URI[go_linux_arm64.sha256sum] =3D
> "a06e99309dbcbdca1a8ccd2282c3ee146e55930886e26b4f1193269587165f49"
> +SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "f180f01943865b7942ab3b4acbab6da6f0f669b61da999d004d16c537a49f7b5"
>=20
>  UPSTREAM_CHECK_URI =3D "https://golang.org/dl/"
>  UPSTREAM_CHECK_REGEX =3D "go(?P<pver>\d+(\.\d+)+)\.linux"
> diff --git a/recipes-devtools/go/go-cross-canadian_1.27.2.bb b/recipes-
> devtools/go/go-cross-canadian_1.27.3.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross-canadian_1.27.2.bb
> rename to recipes-devtools/go/go-cross-canadian_1.27.3.bb
> diff --git a/recipes-devtools/go/go-cross_1.27.2.bb b/recipes-devtools/go=
/go-
> cross_1.27.3.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross_1.27.2.bb
> rename to recipes-devtools/go/go-cross_1.27.3.bb
> diff --git a/recipes-devtools/go/go-crosssdk_1.27.2.bb b/recipes-devtools=
/go/go-
> crosssdk_1.27.3.bb
> similarity index 100%
> rename from recipes-devtools/go/go-crosssdk_1.27.2.bb
> rename to recipes-devtools/go/go-crosssdk_1.27.3.bb
> diff --git a/recipes-devtools/go/go-runtime_1.27.2.bb b/recipes-devtools/=
go/go-
> runtime_1.27.3.bb
> similarity index 100%
> rename from recipes-devtools/go/go-runtime_1.27.2.bb
> rename to recipes-devtools/go/go-runtime_1.27.3.bb
> diff --git a/recipes-devtools/go/go_1.27.2.bb b/recipes-devtools/go/go_1.=
27.3.bb
> similarity index 100%
> rename from recipes-devtools/go/go_1.27.2.bb
> rename to recipes-devtools/go/go_1.27.3.bb
