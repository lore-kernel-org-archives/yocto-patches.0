Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BFCCD3427
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 08:40:33 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.0])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7303.1778143231952632501
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 07 May 2026 01:40:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=p55GI1Fz;
 spf=pass (domain: siemens.com, ip: 52.101.70.0, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hV6HM1V6/jmZtVrpdrf9uojn+zEcYOJHHqSFrFHu7ulF8pZ51onz99RUgETzuOLYNI/pNmLO3GQ/M7OSXbOMAS6Gro8VSuJ6VZQ2Vw6AY32l7UtfzBRPTf7iZUoLjHqzYPZdJxKDuPIs5eOhuGMfALIWl+AJsaJWTg4JBNZ9Jxlrchdhc8Iqbybi6COqJPGg8TV+tM082bj3dnrQF6LTGssmUqAURXZI0SWjTU9FLc0EphOfFjXaVcr2zi6tRpseC1nI/oxIzuJrsDeDxDAksrg3xRQa3goIaa6/FmEeI2uxwC5EqmqUsO22Oc+OSOTPJWamH1+3vBXpzjaUgIAyoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1y2x8p4AGtfnccPoJpNCl3V2BPO9+OgtLkqf/OkQmQ=;
 b=UCn0Qwt6YK+PdHrT5FnJ3Lt8PGiXh/6HYiLG8QyqRabGEAk03m2NxwTjSFmVUavUTVr02k7qIAzv3rI2sXw3QOV519IoQy3wMqRfAXYzNTp1TQGrxW4gVGGvD+K6RUGQ3CwT4KBPKlnAJ8RI/YDRU6cbYQhTPqAAlZcZvsg3PH3Pn7wIwbpeG79voJ0ygtb/PHaa4akQX2UnEMpVRvH9WEZVSEmAuag4paYE/7U2J5TXgBbVyzFybmaBFCYVkNBQ5Dka7xw5hIwGqN3DyTS5MFBSfVCY47iAgCX24E2A4/Df4fpw2PQeqPb+8qgveRMyWBHSgL5YF8flRzAXD5cgGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1y2x8p4AGtfnccPoJpNCl3V2BPO9+OgtLkqf/OkQmQ=;
 b=p55GI1FzMIuqvpS37Tk12TsCg58PQtgNjGuuB8uWEGxZSVYJxbmXxivolCSyPQnd8wH8qg4uGOLKRXMcwXOkzHT5OvMkE6Ghkab9C+94YTsca8rSAbftnjykP4y8EKrWAqAP4siQ1rrr8g/75GLTrK+fCDtl+o6B+iXSfLlvLV6y8/meqNvCB6IRVK4ZbIQ24dFS9r4FsSj8KFRRRqjwdUMUTW8gMG8dpZxHj1ItvI6VpvSHFJ3uyAATnSp7r5jRmBsesvCQIIgXV64Jd9tNaEiz+I8dA6i/ToISwp2wmHKl/r/ULk1mdb3YbSRLynuYZVmLB7cF7rSI5QfL0Gh7Vg==
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::20)
 by PAWPR10MB8092.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:390::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 08:40:27 +0000
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b54d:255a:1abf:2dc7]) by AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b54d:255a:1abf:2dc7%4]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 08:40:26 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: RE: [meta-security][PATCH] tpm2-tools: make efivar optional
Thread-Topic: [meta-security][PATCH] tpm2-tools: make efivar optional
Thread-Index: AQHc3f0A8rjB4dnWqUOita/Mw1TmQrYCPjGw
Date: Thu, 7 May 2026 08:40:26 +0000
Message-ID: 
 <AS1PR10MB5697C4F0B87EC1F4278927CFFD3C2@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
References: <20260507083901.39472-1-peter.marko@siemens.com>
In-Reply-To: <20260507083901.39472-1-peter.marko@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=f5e8f937-0efb-47bf-9eff-21de831d6445;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-05-07T08:39:57Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5697:EE_|PAWPR10MB8092:EE_
x-ms-office365-filtering-correlation-id: 6f266d1f-8dfb-4ee3-5bb9-08deac1449bc
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|55112099003|13003099007|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: 
 FK2ixV0CW/Vew3m4UPFvoduxl14Tint7WBnAxNn21DuXG9yyCN4w/HwsYYCV8kSUR1VEWX07TJyogheX+rab7xFXohjwFNEpicGLvM+AgY2R2SsP48p/Ed1eWKA4JWm++UUO3NDRAffyLaETy9wQwBq0qOwXkvlOqzWzGYTz9tcZyVUxwa9SHyVQwl55xDZzBKjLE4/cnH1v15OZ+fDqaoFf4+hJ08lFty32i2KCoRn9lwoU0eIvpiYm6f+nHiWI91c9vrzg9RtdaRpP/MMjk05WkqLFZBCACXasEetqpk5PrwVAyhopIy7j11ZaRD7iHzjIgmeNPo7uhvHjfZ9qemzC1xaoaWg1HckP4B47c0k1ldSK4v0PcX4t1dL+0mTEyJlZphKt73cBsFizUHAEzWQEffbx5+baO2Tx92VHJnBx+o3Ot+/ogdt3pdDZ8FLanE/hxq4zeG6RaREe1jBTQJaOdZuvfMXbISieBNK67ysEtTaj4zWXh87HVZPdtYrsrt6TVD/6QfE1sPmOoH7hDVvtAMZ7AImp4J4cfbKQfnnGc2XbuqPxM2I3euwnjz+zMR4cCFoKdiHeZ+4M5E2ep7EFEk5nCi4OPkF5A3Xx6SQ+tdm2F62P7Nau/Wiuwj9/LmkNU77pGdKqJkUbvG7bFZVVk6lrmb0huNp2xCBG3Tuk0W4v9sUReukaDoUkYYlIojCg6blJvNCxyWf/srR4IG0JfFu1I8jfke+lsLsMfVspjnbgxzqJagwNAx7cPbf3
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(13003099007)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?PR9vGiw1Ao2sCDeL+l9C7Tj/AEHmS78isQ9pvHJnykVl9OiHfa92Q11Vrwrs?=
 =?us-ascii?Q?3FLKVplicxYDKV3PAHRl8vkTMVzf5+L5xinikBVxwmJhZyYDfIz26SSuAVRb?=
 =?us-ascii?Q?l+OfRaaJ+/cGdqFQeHYnzWK+m8YzXwDs7tMGdGx4w2wYrbVt0hYeRt3nBcZf?=
 =?us-ascii?Q?AlZcREMJ5VynrRvNOAZ01gMLomOD7yYN0VBJB+yqsJNshaC5HE51oIOkoKg3?=
 =?us-ascii?Q?+s75JCdq0ujut7l58pDkvWjxwjW1kpZ6qB28NEKDosvL2rp7K+K216Ljd15a?=
 =?us-ascii?Q?wDCrlTZZEne+DtCavYbUJ+uCSzaB3todiuZLRHp1rzSSDbLfvdq5hRQ/cx5Z?=
 =?us-ascii?Q?5yCE6jQ6bfkuj8WsIK/vho6y+On1ilpzDbSfpFEv97nCztwXLfnoM6jtWSJV?=
 =?us-ascii?Q?dqOn2lWlGJIwBq+vzbkVztIqabra5IcXhBVKmHqQ3W7pXUQvnwc2gE/PFJy+?=
 =?us-ascii?Q?oTLDI5E5e7W0jB8FIRXr8KjeHSDYsGlqN3MEGXmtDPCsm1uC0YKQj6+RzGvX?=
 =?us-ascii?Q?5yEnU8KofoqBsBc/XAlYuwLmT+NV5OCzyE69fz1DXFa+tQPzH/V2sJ/spuhT?=
 =?us-ascii?Q?u8eA4yeoJlxta5kkWXIFucm4Q9UlMBnxC0S2Wv62+0BsgH/nL2pX0y1X9GRV?=
 =?us-ascii?Q?A3V5VTicjwTejk8qlQDqOFlXe6bg+URZfvwxr5+0itm8fro7k1LlOQr8a7iI?=
 =?us-ascii?Q?gZ17fO5S/DGK7E3hf9DFuy0uZ9G21g5qxVHNgujk2oqmGI7ppWcy+9ECZRau?=
 =?us-ascii?Q?P+L+o4Cmm7kGUG3s/NKpi5QKnVo4Psmv1lTCRPwP6yZ24by+Rvwu2ToG0x0P?=
 =?us-ascii?Q?1gM+p34SVfmSEiSq9vHF1QRWRJ/fJF7KtgKFpEW2pGrSGgZv/wj64X2dPjj+?=
 =?us-ascii?Q?/ReMZykc8U5yPVUHQBmhxYOd0epKLaxxw1msbcOL/c+RL4HjfHGn3t4Rxkns?=
 =?us-ascii?Q?ppTU3CbRhDGTrJ46eYSrvKrbkBUf2zK+ecLTJUm4Fkyq6uT7goFamaXcDuwr?=
 =?us-ascii?Q?ceMgejeR5Gw+7yTbyCQky5rrIRaFQy3kym+8AjfovNCbUBDP1CjkrFJ7aaJ4?=
 =?us-ascii?Q?bLh9uB6VyDRbsCgdeQvBGdZo+YqUiaKfJ1s6X9Z0TWsAJev5sUh7MZ3DnfM6?=
 =?us-ascii?Q?9zhopVVAnZ2bGVN2mNygQvOfSG5F5tcbnAn4Q2Jyie8Pi/CkenpbFC4yaXfU?=
 =?us-ascii?Q?FjZznyAcEhKE3NJiQeH8nDKxpF7SwWyz3CKhG997xi1Z5tPGBzB6o2nSvLvN?=
 =?us-ascii?Q?mujUykwespSSLEucIfhmGmhz8ugZW3cMco0GlQaAX9GRelfEFxE/WNt8jGrI?=
 =?us-ascii?Q?K3tdHo96Ju/cSLZU9mQLZS0SADk1r0WbRD9HpEQ4l3UROAg4zAZpTCJhLGBO?=
 =?us-ascii?Q?Pfh0T7fxUvarxnWdfgKsy2s536mwTyIkeAZ1kWWRlyyHf2w9CJT1BZv+aEEy?=
 =?us-ascii?Q?Ef9fWpzQrLT6kOQ9cJnz1RRFTVktoKFBC+HnHbwKiVS6vpr9qBw8PXrnLpaz?=
 =?us-ascii?Q?2reKsRNMbEU59H0ylnqREgmB6GIbGIUSqhZvMWVcosp0GdAt/qbD8RILk1Th?=
 =?us-ascii?Q?Imdueco963B58NP6JJPvfmDG8Ynh6vjL8QzyOE8aTVRFyQVWD7WPtm+hq4W2?=
 =?us-ascii?Q?3BM/DASEF3Xslm77ckbw107DtX+tEIUQQ6ppD5T1wBTkXz/mcMrXjbM86UB9?=
 =?us-ascii?Q?zD27HpSmFqmb45mFWUELHXvEUBUQUVJnLGMfHhr9gs1JCg/Kqzse5bCP0ZTK?=
 =?us-ascii?Q?tAnvUIcpxw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f266d1f-8dfb-4ee3-5bb9-08deac1449bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 08:40:26.9033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bs7uE5GQDCRbkKJi+ZFTfRx/AM4j7L3pvLKBYVI6nQT5geuVnd3Ekz2sokLYXy1711y/Vykx9DRC9s7k+Bgf7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8092
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 07 May 2026 08:40:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3932

Please also apply to wrynose branch.

Thank you,
  Peter

> -----Original Message-----
> From: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> Sent: Thursday, May 7, 2026 10:39 AM
> To: yocto-patches@lists.yoctoproject.org
> Cc: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> Subject: [meta-security][PATCH] tpm2-tools: make efivar optional
>=20
> From: Peter Marko <peter.marko@siemens.com>
>=20
> Previous commit made this a hard dependency because it's autodetected.
> Instead of that, make it configurable so it can be disabled (roughtly
> equivalent to behavior before that commit).
>=20
> Signed-off-by: Peter Marko <peter.marko@siemens.com>
> ---
>  meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb b/meta-
> tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
> index fec5e1c..e1a0c5d 100644
> --- a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
> +++ b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
> @@ -4,7 +4,7 @@ LICENSE =3D "BSD-3-Clause"
>  LIC_FILES_CHKSUM =3D
> "file://docs/LICENSE;md5=3Da846608d090aa64494c45fc147cc12e3"
>  SECTION =3D "tpm"
>=20
> -DEPENDS =3D "tpm2-tss openssl curl efivar"
> +DEPENDS =3D "tpm2-tss openssl curl"
>=20
>  SRC_URI =3D "https://github.com/tpm2-
> software/${BPN}/releases/download/${PV}/${BPN}-${PV}.tar.gz"
>=20
> @@ -14,4 +14,7 @@ UPSTREAM_CHECK_URI =3D "https://github.com/tpm2-
> software/${BPN}/releases"
>=20
>  inherit autotools pkgconfig bash-completion
>=20
> +PACKAGECONGIG ??=3D "efivar"
> +PACKAGECONFIG[efivar] =3D "--with-efivar,--without-efivar,efivar"
> +
>  BBCLASSEXTEND =3D "native nativesdk"

