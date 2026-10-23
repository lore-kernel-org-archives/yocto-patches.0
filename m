Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.2])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2434.1792743338562831707
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 23 Oct 2026 01:15:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Whifwccg;
 spf=pass (domain: siemens.com, ip: 52.101.65.2, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DGRfuOMcIZPCR23l8Txu1faHp+u5xum2xpjp2x1/JBjcMcZw4ZlSfobECafVofewyQIPV2VXMsCwUgMbIq7o+8D4ZQ7ypb2npPi/DVfeYhJvxLV3o9T4TDZb+tidIgTLqXSelODRKqzbCcFaCU5ie/JgUagZhl14Pvo24H8KzW0+PupoixHUoaebK/9Qh/McbsY2SWwzjZoksTnUWU8sLiSfTqWyifL8i5Nqc/yJ6oslg3mb+y+Qe6nHEMuA3CoHBszRTkNaUrFoEM9vv/CMjG9io4cs4XDj7OeBunKbW7xCfJRP9nIbV2ZzwzBa1wvZni0li5xBJWBnHIG6SA2hEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5L4QcPf838VM2MSH8R5E0C3Kq8Xlqt3o/mVvQ5nf8vE=;
 b=tFvt6vf+y9VgfqnR4c1NPYTVAoEyy8pMzEKGNk2bagteF6jTyJkVMCNN63+fu03csMpAxayYwySrQZPYsC9eeB2VgnRYKm6WFNlz42nsW0+ijN5mQ38+yBOWCNHYF5Zo+kNU8PR4B5LqKFxhQpBFAmV1NYwC8vVEtdm9UEinpbnMegUJue20ZzDYS0+2TmS5ZWYSDtkrCj6Zfuu1AXBR6O/nMRNQ0QEWYzcxImzWNMNGPGkW8IpUwbVzL+aFTBW6X41LVDKkgF6wDxYCi98VoVvGhv/BkoOAJXq4EgaoS4NFk5ToQ6fBVMc9ZbM3kyXVFsWpbR2gInhqctpxvNwGZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5L4QcPf838VM2MSH8R5E0C3Kq8Xlqt3o/mVvQ5nf8vE=;
 b=WhifwccgQYfrm5jLlSU1XKbjg1PZijVWYbvaBiCC5LY2nc0xRe+cAsZ2rWcfnphL24oapHDARn2RBGxJVwJINTTMqqgIfrMInWMJjEa8PadvnpNJzOok8IFrKpmC2wTIEP7UzdDiAtftNmyfi5UW7EIHJttgUCj9F+H6oIlCI/adygNX1ll9XPHsKBkXCRNaW2fXNv66fRb5NenJXVLp0tvchMBiW5gxNnpNvE8ytHZUofmrmP+PpETmbDJAjGfJvdCN9T62g78o+f2Del4U5QNVSnqog8C6QlFOR9DGOAta7N1taFuGSi3Nle8z50hWJTtaXcNw5Aq3Mc3/UpHeOQ==
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:420::16)
 by PAWPR10MB6831.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:33b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.2; Fri, 23 Oct
 2026 08:15:32 +0000
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008]) by AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008%6]) with mapi id 15.21.0569.002; Fri, 23 Oct 2026
 08:15:32 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: "jose.quaresma@foundries.io" <jose.quaresma@foundries.io>
Subject: RE: [meta-lts-mixins][scarthgap/go][PATCH 3/3] go: upgrade 1.27.2 ->
 1.27.3
Thread-Topic: [meta-lts-mixins][scarthgap/go][PATCH 3/3] go: upgrade 1.27.2 ->
 1.27.3
Thread-Index: AQHdYnNSgxdiwTwvBUa0hbMRuFUvq7cKyGEw
Date: Fri, 23 Oct 2026 08:15:32 +0000
Message-ID: <AS8PR10MB50734FA720E0C47DCC9A0A2CFD642@AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM>
References: <20261022221758.3539336-1-peter.marko@siemens.com>
 <20261022221758.3539336-3-peter.marko@siemens.com>
In-Reply-To: <20261022221758.3539336-3-peter.marko@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=6e22eac3-637b-4466-98cf-194d9ae3d71b;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-10-23T08:15:18Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB5073:EE_|PAWPR10MB6831:EE_
x-ms-office365-filtering-correlation-id: 7b57183c-4b87-4da0-92a5-08df30ddceb9
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|261009223027099003|261021121427099003|261021123027099003|12006099003|10067099003|56012099006|261022105027099003|6133799003|55112099003|18002099003|22082099003|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info: 9RfnDrgJxVLNAPrTxz3/qs7PN7RGbQBP5nJGEj85vmjwJammtu15/HFdRVcS/rJ/D2Ej7b0dWcJntNtOL/qv1nUeowaulNX7pjZsNum6pLNpZ0jAnhPAl5IcBH9YH49CiwR9SsPDIII/C29r19GVCuXIRMSGmR+Sd3ZGXTkPQYF8RgnzSoXIsmNvwnJvjp1dW6U3ubOETFvY0sIdSBSZ6fBRCkZphfcm70bQwlS8Z/k8o3NTJ5MACs8Ueujpng+7KiCcDxQUYpn8irheRUg7H6L88c/E5i6mEoaxVKXZG+fn6E8ARH0FpfuPqEtiYKE2h8jcGqaq7+tb+0leTahqVDFDITo0N/qgmwZeK7mbjfBQ7Y1wS5GUyCuSRM8hIA+h7WyR3Za/qbmYARKS9rYZHq4Nthhwrfo9tu8xLppHXueMQJsmmu9EbaXItEzIuFKcjD7eVYpqApbeycSUUAA0KkeeWMe8zbx0qUrDFS0ELi3Zi3n68nSOKkVphtdT3yX+gMavNEH3KMpkilUvGcVH55tKI68odaOpyWW0OcDaV+PpzR8MCp4o115Hm3b3iq7TNVHXEY3CImSqEXtzPwNK+R6E/3SdezH069FCVZslMQb5Ijl4l1qBVdHmDjnerINk5DtG7X5B/HJgw02q9kXDX56dRe7RoMPsyBTkd9/p8+A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(261009223027099003)(261021121427099003)(261021123027099003)(12006099003)(10067099003)(56012099006)(261022105027099003)(6133799003)(55112099003)(18002099003)(22082099003)(4143699003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IugihwCR+cLKakq0neaSvKF1Wa+8l42xTj1BBJQMC5lMgVhuKKclwmAqyiGu?=
 =?us-ascii?Q?OFdCpUa6xeY1v7V9Hgipsnpza7AINwPAXVhoV4nVtt8SOhcMRwZ4ajc3lZiA?=
 =?us-ascii?Q?4XxrifIB9fhH1v5BY3GsPZczoL+nhcsDaKn6//5YSoQtqSxrH9l5737FRcxW?=
 =?us-ascii?Q?hv1QL71sLsqimGc2Jw6tZ7j0LhgFfmUslh1LtEIV5oBGRtYBV98AqBTE7o6E?=
 =?us-ascii?Q?zf6mNnJTd8/bIifmPCjPiggu+Pt5K+QaWR9FtULahuykF6QiQk1xFo8gQQee?=
 =?us-ascii?Q?nX12yBz7Ghth4VgOcgELOPfExQcvVnitgRKDOL4CaAkb7xND6Zrk6/0f+1VD?=
 =?us-ascii?Q?eKCsZT5FjFMBRhcR7WXBgkfmR4Lb1VF2fiF01kfqURXrq6v1re4GJCtc4ury?=
 =?us-ascii?Q?tbGmtbJBq/wwa9FBGEReq8RtAHiHZhRq0ATwem0u3MogENZFFLabIGIseKKO?=
 =?us-ascii?Q?zMjvu2Mv9I85If+GAZmrJP95sVH9dJ/4JJ7aQWOwjK4yyD+tyGKngWGyKZTU?=
 =?us-ascii?Q?SHfeRESMsk1euY33XPXkZNOPa/uRQNMYMSIUMW/yeC9pZuyqTbiazB9CdVKc?=
 =?us-ascii?Q?cGuo3Md+oiXG1R+k/I9xLxcGT6ambBWB7rwNT+WCeL+zCsI99eyORu/kCDuM?=
 =?us-ascii?Q?+bbsfDPYdXa0WQw4RgId30PY1KJoLgs+3yrnr4sOnQH038eMEkSxZOcJLMc5?=
 =?us-ascii?Q?VrzGE6Jrhs4rU0fpVZT3n4pKKrFBjHwj6KCTntQyX2lnGlurfzvWuaCwyWsK?=
 =?us-ascii?Q?iyg/IhhfolitI1fEkX5S0pVubHzivXGRbGvKJw8ZmNo0LUQDg7PX5O/WnP/3?=
 =?us-ascii?Q?JJHQooh1k1hf+8xrNVadYRe5PnrMD8ktUia6wxwW8V6GlpgT/iaArfZMCMlL?=
 =?us-ascii?Q?DUrNqOCI+aNQ9/MFBJ75aD1pgGN1x/66XZrARBthpXGvmjcmWoTspyel4t24?=
 =?us-ascii?Q?Ds5EyMvB95x7r5F1QqeIItUeszRB7dhjTbhZpxKEm7VQYTG7xCBDyah0eAOB?=
 =?us-ascii?Q?3i8j3jKhrV7KvQIaTUh4+LflAmdWSyEss7Kumt7dxdNMcuBJ9UjmXG5tiQDj?=
 =?us-ascii?Q?FamoGFoxGQXuXbioD76X/zm6v0U6ChCrjux+NEJOcULRQ0p2wkiUkAIclI+R?=
 =?us-ascii?Q?Gqp/3BhFVHTvcsQLyQBRjX2Ewpy8m19p2oYvFqYchjvpR2igkmuKrOVaFouv?=
 =?us-ascii?Q?v4qRwDrm44gc3tom9Zomxr2nI2d8siKXqtGNyJOmZ+tVfQGZ5lmmCFB1phBl?=
 =?us-ascii?Q?N8jhE5AmblIooDvMA1nRsc0IP+XZ60vrJWHlHjYt6EfiMXmbc/ylp2ZNZW6h?=
 =?us-ascii?Q?wvgMCgOA9VLHq+63YIb6kmnxd37ZWcQ0bMRWLlFArmmZJ26uaS2akEIs3BhY?=
 =?us-ascii?Q?H0pNgaOC1Ql5MqS4gstCAxvAaabOEM4rlSuJHMWGsnbDrw/kXPTuV84+IBEG?=
 =?us-ascii?Q?KTQyQ/Vbpqv1rATIkX8aVPUOytu3mGAhWJlfbtGHv9cQbQZcyknbtlhka1Le?=
 =?us-ascii?Q?uaSJr96g72SxzIQ+xMHCQ32MzSv1V9KofGIO3QFJlavhflUj3kl+IjD7xRnK?=
 =?us-ascii?Q?AxvQftv960F+XymrZL6Kku1fhdCpy8kkpkHEjxCwQhYXEtJb5XSrzw6AhIzO?=
 =?us-ascii?Q?XFilocy1T2NRLryjYU8buKUJcicl+6gQrzhNnxloGz42OEoEb5jvLLo68cOU?=
 =?us-ascii?Q?kTgr3INKiI9NZkSe/EgAVQWy0q9iqYKdJWL4OyQ0LAAYt/eb3yw/ahijKzf9?=
 =?us-ascii?Q?lZANlqjQwA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b57183c-4b87-4da0-92a5-08df30ddceb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 08:15:32.3499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 85Q2c6CFc/HO9fzDwRVsbMG/eMg5q8Eg04qsrMa2Jnym9U9Ma5zLk8/0Xcw8iKa7Hy+WfDtZPXbeAhzivyHNNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6831
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Oct 2026 08:15:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5144

This series is now merged

> -----Original Message-----
> From: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> Sent: Friday, October 23, 2026 12:18 AM
> To: yocto-patches@lists.yoctoproject.org
> Cc: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>;
> jose.quaresma@foundries.io
> Subject: [meta-lts-mixins][scarthgap/go][PATCH 3/3] go: upgrade 1.27.2 ->=
 1.27.3
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
> index d4cb9f3..cc4664e 100644
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
