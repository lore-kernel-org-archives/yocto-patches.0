Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799D6C369DC
	for <webhook@archiver.kernel.org>; Sun,  4 May 2025 16:42:30 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.65.29])
 by mx.groups.io with SMTP id smtpd.web11.32177.1746376939989352245
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 04 May 2025 09:42:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=y8OWgjv8;
 spf=pass (domain: siemens.com, ip: 52.101.65.29, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVOeOdIo4jZoui5jvsNq4Lp4FfbkMMfHyssoBp5yuCtrsL3XxavCOoqdC2wZZbLSbzi2KfQyMpx3Xy84nBJyjyeeGcmvRNF6ntD/+ujlhA3SHaLbdS31Nm03XIbU6Jwmr2Qljo7pbA+DYTYtJH2bYTZi9SoBo2GbLWsZOcAkDjUgsiNXIemiQWFohrmbHgBZ0CnuQfLHrC3UH5Jl5Ov7cRJZfw4DuVd6VFlhlWW4GJiw5s+4frB4HAR5iahpXTzMJ9zrag87EJ9qquMIoCqgciGPPHGvOgH+J4ah3Xgx3ArxNkicgLPZ33KFayx51mhIYYDj5MVkfQIaHmAx5rx2xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lz2cnlkwmwQ8NUjAVi1JbC6FL/BH+oPbPumuSj5q8DA=;
 b=G5pLodeNmcYdEJRJX7+CQ0QW+9Qd1aAIyTbLENBk7d5FQO4JTV0s53SDLO5tQhnoXduambg4IOQXXEpJNaf5vjVsWkOFfhhBbEcb6dYw7PF8NeQ8p1o8tW4yVczChvADBN1e0PjDQuE6XnltpSNe1lpkO1GLJtmUvceeFETur3Uou/vII8xV39MteSTfOtnQZHmFb0ShxIfiifSWUndsua54Q7ilOgMhDw7uMct8P/xCuZzdFgK1C09yAGSkBSEW9NL+N1U3kCZVQH2MjmuIqW9QhemnR0UWwGxx3WeU3vCzH5yWCY+M/c+Gi+8rPz7pmTrnDw6uU57OhmjAbTAb8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lz2cnlkwmwQ8NUjAVi1JbC6FL/BH+oPbPumuSj5q8DA=;
 b=y8OWgjv8+dK83WPNnLASGfrPh5h3dhPDuW5OSRRiv17qIApOARG6Eqcl5i5ymigc6hj5pwpy9V0pkzT5/4A8g3b2K14UGQOD66KYt5qHsYicAUJLfPhQ0nPuAkjlKUU5VrCfjq2ab/NUxRrYEzXN1Co6nq0PE3HvlphzSdESv6btheMUeTyvGPBFmlsSGJNVxjG+nrT3rWGu1bi5hl6GrUzA5Mf+t4ni8D5hyY9XhNdmtKV/k0ZCkBuqXwfD28F2LXA17RbaLvrCLVqbbPvNyUp32K3hk2WvbvhSN3oSNkb5UeD16Ksyq8JITS9jbQKGRjOEA91GNAExnD677BIjDw==
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::20)
 by PR3PR10MB3884.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:28::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Sun, 4 May
 2025 16:42:16 +0000
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c68:267b:6fd1:d3f2]) by AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c68:267b:6fd1:d3f2%4]) with mapi id 15.20.8699.019; Sun, 4 May 2025
 16:42:16 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>, Scott Murray
	<scott.murray@konsulko.com>
Subject: RE: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 19/38]
 cargo: pass PACKAGECONFIG_CONFARGS to cargo build
Thread-Topic: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 19/38]
 cargo: pass PACKAGECONFIG_CONFARGS to cargo build
Thread-Index: AQHbutl9++bmKa+kcky/wvWumDo4kbPCr2kQ
Date: Sun, 4 May 2025 16:42:15 +0000
Message-ID: 
 <AS1PR10MB569727FD0B9979F109D1CD53FD8F2@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1746130391.git.scott.murray@konsulko.com>
 <e5d4f65414368beed7b69e2c94482075aa2a0d81.1746130391.git.scott.murray@konsulko.com>
In-Reply-To: 
 <e5d4f65414368beed7b69e2c94482075aa2a0d81.1746130391.git.scott.murray@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=452002a8-8642-419a-93b8-779601fe321d;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-05-04T16:35:33Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5697:EE_|PR3PR10MB3884:EE_
x-ms-office365-filtering-correlation-id: b9c54d4d-b696-4248-3808-08dd8b2aa0df
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|4022899009|38070700018|13003099007|7053199007;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?8s0s/cEZ8DH+wX3gTJojKd1AqMIJrcr0mGAx3vPxi7RobBaTu240g9FoOWQ1?=
 =?us-ascii?Q?nlXUmssKioeJtMhfeubCpMaBmloNuRWZ16hWsv41ghleomoP0bCUV55VfxcG?=
 =?us-ascii?Q?MGOSROqZ9swxsdiHVnIlZKiNrOjIpYBDIhS3jOrjmEIolrQIB3UzaiL5S6hz?=
 =?us-ascii?Q?EwzQwhcqHPKMjP2ZH5WqY0AGscFCzRMJjLQrCscEDS82X5Bri59rVRu81Oyd?=
 =?us-ascii?Q?1KUbW5YQ0MPaiw2aulz0mzeOWC0pQ0zv3q+hHnYQ4IRKbSFpz1FyCH60DCAc?=
 =?us-ascii?Q?VOYnUrD2CvMTyV515Df/bLpGMLKKcMvobX/avrjN7xjPwDoEPQ8S0rguUm9u?=
 =?us-ascii?Q?PkamKncnMVeY0MAz2V+TymHKyFT3RvhGpXw+DpEnY7x6LzqLgGH0FyMHL5Yu?=
 =?us-ascii?Q?Jn3sBm9a7myQIAnh7RPk3smiMLZd6A/612N7d2vcp0HFxbC7nTvFdf380Zqu?=
 =?us-ascii?Q?DSRFwUdzFWPxvQVTf3Wq9gMe6bBlb+5kUAXLGgH9Btv7ErD3eVB4bV+pK+MA?=
 =?us-ascii?Q?adFfbo/Jg8PP+uj/JUMrxpKwoN0dAdA5jcav5BJug47Ku0pQ1oS7d4y82AxO?=
 =?us-ascii?Q?VsBxilQrjM7ZnHFK2BLbHnhc9sVLbWaWKbqBvXDA9jZzYbtc8Kcy8UZqZA81?=
 =?us-ascii?Q?YTREtAyxi9gsS9Qez+qT7LisrpdioXWNHkNdQaSsyR5IOoAGqwggHmly4/ld?=
 =?us-ascii?Q?nJ7kzs+p7CSEBxDmoMFcCT55MwWB83A2YRBGnEE69VqGiaCexX8qs1iCW6cw?=
 =?us-ascii?Q?Cos/isjqcU0Y/I0F0jJviLahmsKktJH9nJEMr487nbrUuG4W0cy5ZbuaHME0?=
 =?us-ascii?Q?j1suY6wxn5EU1GW4LAevCSTV1SWSeVaRk8vLQyDNhp++T//pF4BVjZScA2n9?=
 =?us-ascii?Q?Un/RAHpB/P/BD/8lnMJE+efdyWnZwXUzsMwzNQ5xlyq1X43LcINt6hf4KbVk?=
 =?us-ascii?Q?1WXpPtnDtsF4tZCqxN4w4ybaUqwn+bivLW37rGMcxNhvPRaGdpKJUNHQoiGO?=
 =?us-ascii?Q?/TkSEbsR8U3JV7zOW0kMboWIAJs4QUUArNDUMDU9nEQ1RUI03orRzDFV5r09?=
 =?us-ascii?Q?aiQUrlNi6wdj1plnxcElQoDyfSphWTH/YslAwUUUArhvfTEIXg3tArs5WO/e?=
 =?us-ascii?Q?EoISq0IXkBZM6NPXsH1WNOI8zS3scDlaIN6moI1QnI2N/NcbNiomWiHbBh20?=
 =?us-ascii?Q?xrUt1e1eiKb0IbLmVRjreEj304rm7F3H5S3hph098I2ZTus35f5gH+p/c8Ad?=
 =?us-ascii?Q?ZtI86kS3dofXM/aa8dV56LWCnuzXuPsDwPMThDYO1IPRbjL8V+RU/WG1ClmW?=
 =?us-ascii?Q?gdH1tOSqEWT6R4nMvCHe4dfTrIXdKqM5CdvqWZH+sw20wtIfVtMalu5XRne5?=
 =?us-ascii?Q?xbq7KiePNtyx/pYKalSZY1yJVmld/OaBVhq/u+o+mPM2p0eC1Cr6md+u4l3N?=
 =?us-ascii?Q?arDfx3FUKN4=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(4022899009)(38070700018)(13003099007)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?yc0KuDa1Iw1cmsh/cp/dBmbD51lXfPldVzMJJYblHye6bTfhZqceYLNApE+u?=
 =?us-ascii?Q?j8dLBfLlYE9DG470Py11/Vpql1ew1Q4Gu299jy1vO7VLEcpAm046/W6bMR+r?=
 =?us-ascii?Q?y0nN8EJaV+m3E1sgCrOR/qk4Spsul2/nBqmD75dEu2OxKJa83LLDtE3PLiYl?=
 =?us-ascii?Q?/zAnGT0Z2B7xhN/wD9oboRs7SR6AVLnyJ48gvE01jn42WxllA8jl+JeUuw5N?=
 =?us-ascii?Q?c+rND1Vr2097zgh+q/zYsVLvnnam57JbnSZNr8Gcskiw/DZ9Yn3SXQfTNQao?=
 =?us-ascii?Q?WzLILUvG3VUsMuTM87dkX+9+E7Sy2BAGg5cArqgfDLi/5WKGdGhKV7XACPeg?=
 =?us-ascii?Q?0J1lbVINabSrzMeulMV2xyjTdQZ2MsPGyVJjGfg9cFSJVXvTRk3y/aMWM6Nj?=
 =?us-ascii?Q?FJeV+bA7/3NVvQb7qSV2K+akIlrlAzPWcigFox+j5JjecwfHmGvwKlOrWMX1?=
 =?us-ascii?Q?hfd6fvCVctJKenHHQDS2xKCKiOZHrpsBT6+tzT1T1HWAeY4uwBQhk/4dPF52?=
 =?us-ascii?Q?Vgmu1+ujiNeDtACYIXMUEqz1YlxZs/sCJ7C8ibCbLKaDs9vICSpJDCKE7izX?=
 =?us-ascii?Q?hTufYQ90Q+tZOgTI70LMVCGLY1KY7D5Z1oIMhomEnKeK4iNrMf7+BDaUUXhq?=
 =?us-ascii?Q?RwhJ2/RLxd8C9tYUYQS3Kqjv6TIaN+mylfNd/TU39104ztXreccxtihhMPGZ?=
 =?us-ascii?Q?Nh228nyVdYZ6k1qXWakV8MJxhNJCrL3+1VUmBbBP5S0qNv34W1a3maoag1D2?=
 =?us-ascii?Q?kBgFdJ1lkwUUcbEgF0t5aqYsIN9m8JrvDEG7iea3euzowM+b5mEiQb6r4a3m?=
 =?us-ascii?Q?7MjsgiiQ5/OoD551zESRs/z1rU4qO2jhdm+01C5q0faCjkCHFWfZuWyz3diy?=
 =?us-ascii?Q?d63Pkd1SjkV7pqWWHl1lKBo4znzFrjiGPprgVT1Z0ri3JyphjPWKYhJwpt5i?=
 =?us-ascii?Q?14zI8pTTYyI7s6n4VZOHMN4enCsJI8YagyhfMhr1h9FnC33F9BxEYYWDqGu2?=
 =?us-ascii?Q?5+FV+8OBPfHiOxCi4c2g0VqNH4RYaDiOT8xTUjrZZ/ZRQSYMgHBWHnr4Pb1S?=
 =?us-ascii?Q?cEGFWRsWfoL4cCpk3qOAadprniq97s00hZs+xar0hK1LEBUsNeobT7ehi1Lm?=
 =?us-ascii?Q?F/Jw3OzpAVMhI9YecxEfYQtQk5G3KIpjFy9A9Brg94avjcrDgqgyWyuBqOEu?=
 =?us-ascii?Q?9ssz83tDd8eQ3s/lAxPFfMrUxRXHVlNwfNivakyhXiiSEai6xm6NlfWdfMY7?=
 =?us-ascii?Q?NahxKKZ35Jmtc8VoOp8RSmR4MKmQdVlsMU1RwerTqsNT5KUl6+nurPeWMCTE?=
 =?us-ascii?Q?YLClMgftVbdzkCJc+32NKrfLin0rVvEUm+HRoAkESOQ9iDjz3A6l4A4rrZ2i?=
 =?us-ascii?Q?AY4GQ/Zivdsks+06xl61/p7QOwlI7hPme00+qVt4hCq5ZJ877Dq1qO1BHpzS?=
 =?us-ascii?Q?DCoWi2DdJNdiZzoeeKfC9v9Tt++a6KxAVXCtNOblQqrCd30MuW2oUtcxSt9s?=
 =?us-ascii?Q?6tQH8xpRo0yA7ZsXIp9EcmQrKlJQtBUsZ/aNZrykMefm8AKZwLtmaoWcYWeB?=
 =?us-ascii?Q?BoMdVqFv3corzkdjGGq9sn0tpHtq/RLsBCq/wtXu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c54d4d-b696-4248-3808-08dd8b2aa0df
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2025 16:42:16.0318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nLYfftohmYV0BcaSySs+Ev90zqpzyTcJW639bnwxWcLBy/Tf3yDyEzcLkV9+1Ts5bYIGzADCqfb5lr0rXn1cmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3884
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 04 May 2025 16:42:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1489

This commit creates discrepancy between cargo.bbclass (from mixins) and pte=
st-cargo.bbclass (from oe-core)
It needs https://git.openembedded.org/openembedded-core/commit/?id=3D98d03d=
31de4010534b1a00d29409d3486a0ab0b9
Same is true for scarthgap/rust (which triggered me to send that patch when=
 testing last scarthgap/rust update).
We probably need to copy ptest-cargo.bbclass into mixins to apply that chan=
ge.

Peter

> -----Original Message-----
> From: yocto-patches@lists.yoctoproject.org <yocto-
> patches@lists.yoctoproject.org> On Behalf Of Scott Murray via
> lists.yoctoproject.org
> Sent: Thursday, May 1, 2025 22:40
> To: yocto-patches@lists.yoctoproject.org
> Subject: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 19/38] c=
argo:
> pass PACKAGECONFIG_CONFARGS to cargo build
>=20
> From: Jean-Pierre Geslin <jarsoper@gmail.com>
>=20
> In order to allow rust packages to define PACKAGECONFIG options, append
> the contents of PACKAGECONFIG_CONFARGS to the build command.
> This patch was already submitted by Bartosz Golaszewski on older
> version but was never merged. It will be really usefull for Rust recipes.
>=20
> Signed-off-by: Jean-Pierre Geslin <jarsoper@gmail.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> (adapted from oe-core commit 16745b20452de60ae2474433cc1a2fb1ed9f6a64)
> Signed-off-by: Scott Murray <scott.murray@konsulko.com>
> ---
>  classes/cargo.bbclass | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/classes/cargo.bbclass b/classes/cargo.bbclass
> index 76a3966..461d100 100644
> --- a/classes/cargo.bbclass
> +++ b/classes/cargo.bbclass
> @@ -48,7 +48,7 @@ oe_cargo_build () {
>  	bbnote "Using rust targets from ${RUST_TARGET_PATH}"
>  	bbnote "cargo =3D $(which ${CARGO})"
>  	bbnote "${CARGO} build ${CARGO_BUILD_FLAGS} $@"
> -	"${CARGO}" build ${CARGO_BUILD_FLAGS} "$@"
> +	"${CARGO}" build ${CARGO_BUILD_FLAGS}
> ${PACKAGECONFIG_CONFARGS} "$@"
>  }
>=20
>  do_compile[progress] =3D "outof:\s+(\d+)/(\d+)"
> --
> 2.49.0
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1446): https://lists.yoctoproject.org/g/yocto-
> patches/message/1446
> Mute This Topic: https://lists.yoctoproject.org/mt/112569359/4454441
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-
> patches/leave/13703729/4454441/683413657/xyzzy [peter.marko@siemens.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


