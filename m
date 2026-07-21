Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5632BC44532
	for <webhook@archiver.kernel.org>; Tue, 21 Jul 2026 15:34:46 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.40])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.25887.1784648083472337010
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 21 Jul 2026 08:34:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qBftlFE3;
 spf=pass (domain: siemens.com, ip: 52.101.70.40, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wjuPtUJBHoCeBCH8NvVzvvI/+cuHQVr+dxfeM+7aEWG2dnQzP4exeMAc2YdsYKX0nRVzNKFQHNpYFD05iPDgiJ6odeZLADLJz3IZytJKyaSN9aakrn+XvzgmEdiazQTGDNtmw/ouuSpd0dEIan0IfF2xMWMthTIZTt9n9jbYL2tIZEBSLog6r/cfwoNR55d3/itCafOpEqRAvDu0nk5qnHwuAsxdpEpY/OR/zfjsxUleu+nn16K2OJ4Lz3cxN+oO4riERFnKpQPBUjThxM4jFJkTRfWwqh8L+CABNwDPoiAtLkP1ZN2TA9/pnISjG0f0nyGIs6/58SQnrkd5kWWyeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcCVH+ZKjivaHD9eK1xr421e3Nx3EXFeVDTnPkWALP4=;
 b=MwYD3rmLKHicyH36Z08QeF/B4cj2mTW+PXPkGV2k1x8nZHK5IyYvoFUfUHi8xAueGoRExnhdmu3FKkQhNrmzPej9HqYTClvsoxEIrLcrVt8RBLwGv6zcoaFG+/wuf/To3ry08r7eDigcwMKQujgKO83xKlvytJ6usCxMct9qjpJKaiYRt3nJANODfa7X0nQCpV8Ji5hF+799R1RHTk1c5bhh8leOizJfTPHdOb2b8fWHD38HynQoWsRrpNhhrQ7sya8AcgE1Z9HS2y3cpdt5ZX9y4a2wpFx919h9x4doN608o++CzTudx89ApCCboxiui94q/t/92/COGhVabIHVCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcCVH+ZKjivaHD9eK1xr421e3Nx3EXFeVDTnPkWALP4=;
 b=qBftlFE3Fe86DN5vBnblZDLPXtaK02FdgLz9NID9tGoSelyDFVtlQu8xH31JUeJKkt7wzFODiBRdDLHKBU9Blor/flz3i3GTZ3ss6hbFCNo4H8Xh6wCv3rReXgv3jnfLCA0bG8rIuq+EaaNufzfZJO7Aalk5zhwQG8Hz2xcGX3dzH1cnHpaKiiKNSL9UhhRx/llkvC3k/o3EfQLocyK27hsnq3J+BqC2+Vbb1HBTOW7pHplzkaeeVD28pKKXKH7XSJ9BCz0eAdkRrCw9fRx/Yq/TwAzBjl5MI+A+iVMvSva1V6m9qZXh2TDO72nUbGvcXUdo2nbw5wPAkBarT0jrSw==
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:420::16)
 by DU0PR10MB7531.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 15:34:37 +0000
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008]) by AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008%4]) with mapi id 15.21.0223.015; Tue, 21 Jul 2026
 15:34:37 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: "jose.quaresma@foundries.io" <jose.quaresma@foundries.io>
Subject: RE: [meta-lts-mixins][scarthgap/go][PATCH] go: upgrade 1.26.4 ->
 1.26.5
Thread-Topic: [meta-lts-mixins][scarthgap/go][PATCH] go: upgrade 1.26.4 ->
 1.26.5
Thread-Index: AQHdE71NpbFbjLk3SEeRn2yJSh+XU7Z4JVEg
Date: Tue, 21 Jul 2026 15:34:37 +0000
Message-ID: 
 <AS8PR10MB5073B9FD9DB541497BE1E5CFFDC22@AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM>
References: <20260714181902.5214-1-peter.marko@siemens.com>
In-Reply-To: <20260714181902.5214-1-peter.marko@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=9739fe6a-d58c-4979-b81a-59ca33031ea2;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-07-21T15:34:20Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB5073:EE_|DU0PR10MB7531:EE_
x-ms-office365-filtering-correlation-id: 843e043d-e414-48eb-2aea-08dee73d92d3
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|6133799003|18002099003|22082099003|55112099003|12006099003|38070700021|56012099006|11063799006|10067099003;
x-microsoft-antispam-message-info: 
 jEjABySEUg0kc5D93dG9cvCDR2PPlkx/H3dRWQQwvNqxYLTcoFeASf7DGKpu2Q2E2QlM5MxZkk5jViqOP7jAjY/nEu1ysVwOElMWEA016wDpafFLLU9OeJNwpK+TLsoLHXltH7nStuuvs3AeesFcRYWsvzgSDO8te+PNgZAmETAw3DIEQMHlQ+nVnmSvkswwYxnHPnFV9XLb7PYQdNUoiYSTS/vhkqyGY59Rkcg0ENn8QXNeXfwgoVdHKyASSjTf98l7MaBgCsJWMittgyqo9weMGwX8oCuIBzcbTu+VOCFz74N3iKKIlhs1mRASBIJwxSTeDiLo4Bs0BUK/w/WhK9DJRdwOeEEfqSga4Uzp7Kj4lzB+D7wDZVQemwbjUIvffRjOpihsqCScehRF4Of0v0kfs8GOa5O6kZeHO/sPJiN9NWBgiv0CsYG/SS+CLiMrO3mrhFoT8zaj5JHSOJminqGDq/1uypbj/ay3q0R6D5j8BPt88DcDnuGPNfhbcVoW2jDyxISzsN5e1fAFAqkTpmJSv+3OHCJc5GZYzGf76NIiavE0dhfIlumVmC1pdNoWcEJyvz5IJf5ZsQmCqOnfRCNjS1Hq3qf6NwlS5/PTH3dZZ1oWEoa3T/E9GyzZ3fegLiIVIRR4zaPptu5ggw/5fuu0MHYwwCCOlByngQ2iKZ0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(55112099003)(12006099003)(38070700021)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?isPlFhfSpoWu+9v5i5As36oiswwBU7KyRxfE2Oz/2SkPKzuzLmyZ9EjdGYwW?=
 =?us-ascii?Q?62sPip2w82OJBT33U+iRZNUsNm9zYLFC4E7bF02tX9vs6VgVz4RGR1o0MfPU?=
 =?us-ascii?Q?LL0xpt1Mv2AQoulBk7/bDtlCCO8m7zrR/tznLA2AZI0HtMiUgGqiYQDs00x/?=
 =?us-ascii?Q?vIU0r0CmmZkoIWbKKXG9kcSnIS+7zi1g+HK05StzdZPddTkiHzXlB2dz7zZ1?=
 =?us-ascii?Q?FaBi8GYE0aVxTk4x6gpdXazbbaY16ufO7l1cdQGteobGDBWOAdfwPij88qhM?=
 =?us-ascii?Q?fLy6qWRU7t89BT7b48w59BG4EbuFySZjj4bOVpateiJwmCqxbvv/8SgjytPY?=
 =?us-ascii?Q?rHWM20GH57rq1WLP9Iqh6nJxn0z6nIFgNyqYyyJEaThkF87Lyd5SeCwOEd7Z?=
 =?us-ascii?Q?/71C8MrkG+pyt1aq9/BccH/CK5he0myQdwNz2bAeE/Fls/76srqoz2ddrKdb?=
 =?us-ascii?Q?O6UMS15Ah3hAXzjL0mxLTUT5+HEQBGTiMtdNGu1/9ZA5Cd6ZJfx0CeMFX1hT?=
 =?us-ascii?Q?fSkFORBSNMF7AM4WLCb9EvzFistUQKkdmUjIxxK0QhI0kNOJLdoYxYKmayix?=
 =?us-ascii?Q?dCD9o3vsb7WxiRmwEnlQP7xIsgJ95yLRDFRQDbUJFFjDJz+q/O9Hu72tUKab?=
 =?us-ascii?Q?dRx6BRGpKwiL6eNcFtEHpI7zrtLVvsQ7ljg1yaeGeyJgJaR+1jqJXvhZXQzb?=
 =?us-ascii?Q?KoYts8gSmq/CuqfOZpaVI4gGLKSuQ9l67YLd/h6Jz/QseRpnpSH0Maf0Zllt?=
 =?us-ascii?Q?btB0xmz4xowd4PYu1xdMOmtyX2H13MF7/MaZMWgEFm/DMI9kUzdN2vdsBH3k?=
 =?us-ascii?Q?qmR7X0Btjr7/uCThWiCY7/JSPHMySWDXSZDS6mDT0YezaZfGQeRTKs21Vo8C?=
 =?us-ascii?Q?/vqjQlppaKdH1cmPpThAMByDFOo1aCIg3E36AYuZrUguyV/zJYgZTSBMCc+o?=
 =?us-ascii?Q?jqSlFGkTT/tpU0NMxe3YGUrwPwuJve7+N/hW1TTD9U4sxa2DyZyjg4rwvIri?=
 =?us-ascii?Q?NiIItehwptOxFXWRSk5fX8rF/oMRN0bmel9zUmhA0guqltRqzMFquCQVDEp4?=
 =?us-ascii?Q?q6grZKU3SrrvDy3AJny/eqwjicM4y/KZj0FzusU/Lgp2wvtFpyW8cmBB0A+o?=
 =?us-ascii?Q?z2mxA3hNIwYoIOIIDwBtdYxvE4Z8qHkM7ocCE77OwhWgP/0BPYC6C35Ys0tq?=
 =?us-ascii?Q?3jNnADp4Bix75pOecCKbSJkUB8Cm0o8h2BBP1iOIZllhPigYEBSTfGDoADn2?=
 =?us-ascii?Q?IHp/cJ+ETOvEg2esJqSBTPoq2ghTMD9DRj08cxW/RPAZdzgTYsha+sFgcEtj?=
 =?us-ascii?Q?oHyx7mZnDrDTG2Q5quHKUzSTmG52sXxT6Ywxx7oUVg0lmJROMkkVuDYvwsXM?=
 =?us-ascii?Q?Bh6PSF5BvESXamhPt+8mX7j6A1FVou29vpMfUuFBkXJyb1M9nhPizB4fZxqV?=
 =?us-ascii?Q?4grJB9Dl/alboiN72Lj5R0mDgtHgXugo7xIHb6I7Vd6tDj8RMI9NwNKXJmcE?=
 =?us-ascii?Q?j7ATdq+g/p9FiFzFYFQMx32eJpmTFac7ciDP6/i0qXSn1rJoIItKm+Fys+JA?=
 =?us-ascii?Q?6TFEWUSwOT8Fh/JSrfrBehJp8H9DvnTiBqo+QdrCytpXWZiMcJCAP5arXMcJ?=
 =?us-ascii?Q?5Jw5eGjuVxHa9xOJXGiv5Z8S/WyeZ1ky6ucM2UOd3W9Vp+7HD+Pn1qigG+Zz?=
 =?us-ascii?Q?DbKX0OUkHqIMLK7e80ysPm+sZmE+xwLRURre4pq3TzEr1qQ31YcH6R03BAGV?=
 =?us-ascii?Q?KY/JVTmQfQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 843e043d-e414-48eb-2aea-08dee73d92d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 15:34:37.5241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q87j+ARpgJ0EVhvREAMHPT9EU4kqDOKPnj2Db2+l1tUMW4EFgmtDQ0a1cAEoxT/FsFexzv1Gm/mrtBUIN3UBBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7531
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 21 Jul 2026 15:34:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4525

This is now merged.
Peter

> -----Original Message-----
> From: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> Sent: Tuesday, July 14, 2026 8:19 PM
> To: yocto-patches@lists.yoctoproject.org
> Cc: jose.quaresma@foundries.io; Marko, Peter (FT D EU SK BFS1)
> <Peter.Marko@siemens.com>
> Subject: [meta-lts-mixins][scarthgap/go][PATCH] go: upgrade 1.26.4 -> 1.2=
6.5
>=20
> From: Peter Marko <peter.marko@siemens.com>
>=20
> Upgrade to latest 1.26.x release [1]:
>=20
> $ git --no-pager log --oneline go1.26.4..go1.26.5
> c19862e5f8 (tag: go1.26.5) [release-branch.go1.26] go1.26.5
> f9ef7f5598 [release-branch.go1.26] os: properly handle trailing slashes i=
n paths in
> Root
> ca8ca590cc [release-branch.go1.26] crypto/tls: omit PSK in ECH outer clie=
nt hello
> 7397dd7495 [release-branch.go1.26] net: fix TestLookupCNAME
> 044c995af7 [release-branch.go1.26] runtime: tolerate vendor suffixes in L=
inux kernel
> release strings
> 814591410b [release-branch.go1.26] cmd/compile,sync/atomic: make Add And =
& Or
> SQCST on PPC64
> 2055b1a15d [release-branch.go1.26] syscall: add //go:norace to rawSyscall=
 on
> darwin
> d7c9c818f9 [release-branch.go1.26] runtime: in moveSliceNoCap, round size=
 down to
> a whole multiple of element size
> dc80258a97 [release-branch.go1.26] internal/runtime/gc: require AVX512DQ =
for
> greentea
> 6efcff6602 [release-branch.go1.26] os/signal: make NotifyContext Cause ma=
tch
> context.Canceled
> fe91cea4f2 [release-branch.go1.26] cmd/go: use fsys.ReadDir for
> IsStandardPackage
> ec988a9af1 [release-branch.go1.26] os: notify testlog from (*File).Chdir
>=20
> Fixes CVE-2026-39822 and CVE-2026-42505.
>=20
> Release information: [2]
>=20
> [1] https://github.com/golang/go/compare/go1.26.4...go1.26.5
> [2] https://groups.google.com/g/golang-announce/c/OrmQE_Yp5Sc
>=20
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> (From OE-Core rev: b498f6d6d93e0adb3f0e9439aa55a2abfcb9b063)
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> ---
>  recipes-devtools/go/{go-1.26.4.inc =3D> go-1.26.5.inc}        | 2 +-
>  ...o-binary-native_1.26.4.bb =3D> go-binary-native_1.26.5.bb} | 6 +++---
>  ...cross-canadian_1.26.4.bb =3D> go-cross-canadian_1.26.5.bb} | 0
>  .../go/{go-cross_1.26.4.bb =3D> go-cross_1.26.5.bb}           | 0
>  .../go/{go-crosssdk_1.26.4.bb =3D> go-crosssdk_1.26.5.bb}     | 0
>  .../go/{go-runtime_1.26.4.bb =3D> go-runtime_1.26.5.bb}       | 0
>  recipes-devtools/go/{go_1.26.4.bb =3D> go_1.26.5.bb}          | 0
>  7 files changed, 4 insertions(+), 4 deletions(-)
>  rename recipes-devtools/go/{go-1.26.4.inc =3D> go-1.26.5.inc} (90%)
>  rename recipes-devtools/go/{go-binary-native_1.26.4.bb =3D> go-binary-
> native_1.26.5.bb} (80%)
>  rename recipes-devtools/go/{go-cross-canadian_1.26.4.bb =3D> go-cross-
> canadian_1.26.5.bb} (100%)
>  rename recipes-devtools/go/{go-cross_1.26.4.bb =3D> go-cross_1.26.5.bb} =
(100%)
>  rename recipes-devtools/go/{go-crosssdk_1.26.4.bb =3D> go-crosssdk_1.26.=
5.bb}
> (100%)
>  rename recipes-devtools/go/{go-runtime_1.26.4.bb =3D> go-runtime_1.26.5.=
bb} (100%)
>  rename recipes-devtools/go/{go_1.26.4.bb =3D> go_1.26.5.bb} (100%)
>=20
> diff --git a/recipes-devtools/go/go-1.26.4.inc b/recipes-devtools/go/go-1=
.26.5.inc
> similarity index 90%
> rename from recipes-devtools/go/go-1.26.4.inc
> rename to recipes-devtools/go/go-1.26.5.inc
> index 8bc6f4d..a4302b2 100644
> --- a/recipes-devtools/go/go-1.26.4.inc
> +++ b/recipes-devtools/go/go-1.26.5.inc
> @@ -16,4 +16,4 @@ SRC_URI +=3D "\
>      file://0009-go-Filter-build-paths-on-staticly-linked-arches.patch \
>      file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.pat=
ch \
>  "
> -SRC_URI[main.sha256sum] =3D
> "4f668a32fbfc1132e6a881fb968c2f1dada631492a339211735fbb255a42602d"
> +SRC_URI[main.sha256sum] =3D
> "495be4bc87176ac567392e5b4116abd98466d33d7b49d41e764ccc6976b2dc42"
> diff --git a/recipes-devtools/go/go-binary-native_1.26.4.bb b/recipes-dev=
tools/go/go-
> binary-native_1.26.5.bb
> similarity index 80%
> rename from recipes-devtools/go/go-binary-native_1.26.4.bb
> rename to recipes-devtools/go/go-binary-native_1.26.5.bb
> index 489ea0c..8ba9dd4 100644
> --- a/recipes-devtools/go/go-binary-native_1.26.4.bb
> +++ b/recipes-devtools/go/go-binary-native_1.26.5.bb
> @@ -9,9 +9,9 @@ PROVIDES =3D "go-native"
>=20
>  # Checksums available at https://go.dev/dl/
>  SRC_URI =3D "https://dl.google.com/go/go${PV}.${BUILD_GOOS}-
> ${BUILD_GOARCH}.tar.gz;name=3Dgo_${BUILD_GOTUPLE}"
> -SRC_URI[go_linux_amd64.sha256sum] =3D
> "1153d3d50e0ac764b447adfe05c2bcf08e889d42a02e0fe0259bd47f6733ad7f"
> -SRC_URI[go_linux_arm64.sha256sum] =3D
> "ef758ae7c6cf9267c9c0ef080b8965f453d89ab2d25d9eb22de4405925238768"
> -SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "53f49b8c7eace2d30389327b4a516b13321f90377fdf5929a6b63174609bc22e"
> +SRC_URI[go_linux_amd64.sha256sum] =3D
> "5c2c3b16caefa1d968a94c1daca04a7ca301a496d9b086e17ad77bb81393f053"
> +SRC_URI[go_linux_arm64.sha256sum] =3D
> "fe4789e92b1f33358680864bbe8704289e7bb5fc207d80623c308935bd696d49"
> +SRC_URI[go_linux_ppc64le.sha256sum] =3D
> "c5d60e2b303bb612f20cd82786594b64874e73b35134025e27d3390bf284ae43"
>=20
>  UPSTREAM_CHECK_URI =3D "https://golang.org/dl/"
>  UPSTREAM_CHECK_REGEX =3D "go(?P<pver>\d+(\.\d+)+)\.linux"
> diff --git a/recipes-devtools/go/go-cross-canadian_1.26.4.bb b/recipes-de=
vtools/go/go-
> cross-canadian_1.26.5.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross-canadian_1.26.4.bb
> rename to recipes-devtools/go/go-cross-canadian_1.26.5.bb
> diff --git a/recipes-devtools/go/go-cross_1.26.4.bb b/recipes-devtools/go=
/go-
> cross_1.26.5.bb
> similarity index 100%
> rename from recipes-devtools/go/go-cross_1.26.4.bb
> rename to recipes-devtools/go/go-cross_1.26.5.bb
> diff --git a/recipes-devtools/go/go-crosssdk_1.26.4.bb b/recipes-devtools=
/go/go-
> crosssdk_1.26.5.bb
> similarity index 100%
> rename from recipes-devtools/go/go-crosssdk_1.26.4.bb
> rename to recipes-devtools/go/go-crosssdk_1.26.5.bb
> diff --git a/recipes-devtools/go/go-runtime_1.26.4.bb b/recipes-devtools/=
go/go-
> runtime_1.26.5.bb
> similarity index 100%
> rename from recipes-devtools/go/go-runtime_1.26.4.bb
> rename to recipes-devtools/go/go-runtime_1.26.5.bb
> diff --git a/recipes-devtools/go/go_1.26.4.bb b/recipes-devtools/go/go_1.=
26.5.bb
> similarity index 100%
> rename from recipes-devtools/go/go_1.26.4.bb
> rename to recipes-devtools/go/go_1.26.5.bb

