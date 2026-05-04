Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFB1CD3423
	for <webhook@archiver.kernel.org>; Mon,  4 May 2026 08:10:44 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.23])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10138.1777882234157413591
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 04 May 2026 01:10:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ericsson.com header.s=selector1 header.b=y9in7Wbl;
 spf=pass (domain: ericsson.com, ip: 52.101.83.23, mailfrom: daniel.turull@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mef1zbgUmTkm2uCLLsTFLEgVnJZHfu90YY0uLntdGiMYSJQ5hak4FhO8LiEd/bIkKrAvHCS3wAwkpj223PiQSIn/tj8qSSM/jrs4rporNyyD9VlgFpTYcZEykSCwon+k9h9YxIVbBPsFiPxnj6StVhaS1cIgYGNETnc+R4KRQFFFGMV8KZQh7UJMeu4sdY1ljpAN9n5PWn8WSkor+Bc6TQr7J2KA0IurwP/1+nADw5q8YFr6zWURFsjhSw2GgdeXXkA+shQWIMYRnB68YQDkrFgmBQGLiIfrFONPrwVZVkpMYZ+UClUCVJYFb5FleUS6mDD6zVPRdTrlt6fES6hodw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6xzexFMtSMWOwbAq0WVysjF2huMrW3SuE3vjZbnv5s=;
 b=OgGXysEiFj3WWTOgHC1JvB6JprPCanf5SMqdX33vyfE9JrbkYcRarxgKMeR//Vtf6nZ2BhlafiZA6G/ZHJ6qN1rbcHRiI7yzrFfvhesFxdFpZ1pv+JRVS4RwHyx/0BmOYvNKnRjbID5hF2HhNM51NxnOllH81kvlYxuUEbL7HRlWk5zUsykQ33Ael8hjmlCD/rpFk2qjkJBno7M9+6xcwRf3VmbYeonbfNiRnFczKqEFr9Z+MAxfmCMzQZQzA46MhNkdCS6QUq83yOMvm+aEqWAresoImdL7dVigZgUJdEUg4NSx3E+j/CAmEt4XwXLLGmBC1LTzs27TzVZNrr2sIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6xzexFMtSMWOwbAq0WVysjF2huMrW3SuE3vjZbnv5s=;
 b=y9in7WblD2V4tFBL6N5bEyEplKNxJS/EP/RorejCenbdhyM9ixZ4ZsI+xNv+qgW0wnvGQCRyM8Xbbn3fPgX7FdjOs31+I0cI+HzB0pLRSbp4REmVZf5v7JR5Ev/A634o8UDgagq8XOyb9++ne6dz+N73lbKvkzZSIUmeAdcJ8q6QrF3yVpjyCjeb6zlg7TDP/bj4ixEsAtjqFMgKZzSOqevGvVV4j8Ocpg+Be4Yl0QEQdzV8z3a9/vnVVnB/d/EKJrHtGnq05EcMFEJ82KNWEigo1U7r3d3of5QYrM/k1fq9Oo0x86iCKCne7NavGE6ckSZy2kAns46lNobwTjYbug==
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com (2603:10a6:102:4af::6)
 by VI0PR07MB12318.eurprd07.prod.outlook.com (2603:10a6:800:343::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 08:10:29 +0000
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7]) by PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7%7]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 08:10:29 +0000
From: Daniel Turull <daniel.turull@ericsson.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>, "paul@pbarker.dev"
	<paul@pbarker.dev>, "ross.burton@arm.com" <ross.burton@arm.com>,
	"yoann.congal@smile.fr" <yoann.congal@smile.fr>, "Qi.Chen@windriver.com"
	<Qi.Chen@windriver.com>
Subject: Re: [AUH][PATCH v3 3/4] upgrade-helper.py: Add stable option for
 patch-only upgrades
Thread-Topic: [AUH][PATCH v3 3/4] upgrade-helper.py: Add stable option for
 patch-only upgrades
Thread-Index: AQHc25BVkoKIR+9+yUGtU7sK2q+J/bX9d9sAgAAA37CAAAX0gIAAA6db
Date: Mon, 4 May 2026 08:10:29 +0000
Message-ID: 
 <PA3PR07MB10721BBBEDB19758D2B399E7B8A312@PA3PR07MB10721.eurprd07.prod.outlook.com>
References: <20260504063614.3831203-1-daniel.turull@ericsson.com>
 <20260504063614.3831203-4-daniel.turull@ericsson.com>
 <CANNYZj9O=uZJ-VvnMP+2TOfqEmzQ18dmDu3VA+19R==XHKPwTg@mail.gmail.com>
 <PA3PR07MB107217FDB43D6E8BF8639C0138A312@PA3PR07MB10721.eurprd07.prod.outlook.com>
 <CANNYZj_4JtdrbCtuBgcDpf3a3gusQJs2_DUMCZyiRO7dRFCWYw@mail.gmail.com>
In-Reply-To: 
 <CANNYZj_4JtdrbCtuBgcDpf3a3gusQJs2_DUMCZyiRO7dRFCWYw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR07MB10721:EE_|VI0PR07MB12318:EE_
x-ms-office365-filtering-correlation-id: de3d5829-f1ce-453b-adb0-08dea9b49b2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|13003099007|22082099003|18002099003|56012099003|8096899003;
x-microsoft-antispam-message-info: 
 Gh5NZ6kfD8/dC1xxgN3vOsgSlI9HNIQVYxZ/w088CzO1OMCLGHuvNiBZ1CdIbIjNDgcL5aqt4GnAi3OF156OQs4etolOX5Xs9uIdhG33qs+aD83fumRRB2H6+DBPdVwJsfq5Me+I7tzvKs1/DW6wI4YkFlBxm1WXUq/yczaXrQnj5KHJG9gb+XwJ7cNtcwI5DOARtOmnduwJKuD+CzNjVHjerjhIHP1Qp4mdAJlNpCQG2nGKCZVZiVD7ZGaBrVRL93ay1ulrn0ZUoEd43tw3opfkjYHKP86SQ6WP7JyZHGGoP5h///+CK2kqcWEr1Jl2yoDd/Tjya7cNU7EmM3yioZ65bwEPFB0yIiwj9XORZ3bAFygBW0ZNBQdEE5AVlClQEJVghC36Rc1gOz2Wd2O/Q+S+qgfm31Yz0OkP6KO9fzVqMEEgYKgf446JygBWIXrfYcoIMfzRkoeKmNwXi9BNS2uAGCv2VVYbEXhMoyxOKqjp2JVtOEa0KTcFvozjXsfPHLtJGputA29GwsWA3HJELpdQHryYANVrHS9pd0M+uPR/+nV8EUV6MAlXIJ/HFDa1/Hcedx05rTBdBY0FVYhSZayFt0qUO0EvzXAd+VeuxaGtSOmCDjPaUTbgeM76KpY+eCwhIvrQp4jgszsrU9pbcSmCS++1OzoL0uSDbvFRLCrN8FnTatX/lyILSq+KWk+kYWeRqKdIHkamB+WTKdjWIQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR07MB10721.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(13003099007)(22082099003)(18002099003)(56012099003)(8096899003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?j+UwVTfnXVkUKUBPRIVJ2LTy+5DkOoJC8ewXsXMhoiv6GWvXmUTbzRH0DPY/?=
 =?us-ascii?Q?HxAlmfjXqf2ooe6wvW5oX4QkL38cZg/agQb2cL4Hs0YvdqZ08eYdNUOAThBv?=
 =?us-ascii?Q?QowJoi/LYpMX5qTHgdJXMXa0mvbv2iul0aMaxZmjBdGEqfhm1lSAEiTo4g9S?=
 =?us-ascii?Q?YJ71EVjGaXQSyP52YaaMxNxrbU39pPOg6eGOLA9OXbYvILwzAF92HWhDv9MK?=
 =?us-ascii?Q?32c9Pe4FoAS8VIl65JxjtIDGHEdhqQ/t/j7cIXTKv4UE+vJkG6RuBoNfeV7n?=
 =?us-ascii?Q?GkqFMi6xZsmeOa/OaeTeJq4fZx6fITzBU/rO2scpgVjALX8BpB5HfqL6yVZQ?=
 =?us-ascii?Q?GC/3U0R/2R9w4tD4+53lUrg+fKL9/yH0wbEJXtVSKDDiwnCOXOYr6IJAZfWa?=
 =?us-ascii?Q?zp+PgUlVhIRYlRcNmTsvQ1IIDvCm0UDgRS9opjCRqcRg+rbCBFl3XOCtBGdF?=
 =?us-ascii?Q?67RDhmerDgf6SHl0/uV988YeQYd6wevewzFblx7ZYAud51KSktFYu4hR1hLw?=
 =?us-ascii?Q?kvDhJtvZcbxWLzNX0o2wQIUvAI7NlEBTWqz2/+1AR0//8yEOFK0fOLoveQT9?=
 =?us-ascii?Q?72TxSZ95zIIcvKYIc/pfyZxa4RfikBtRBIWmVlTenWUbyu6uBRDcOhbjrLFd?=
 =?us-ascii?Q?947GlxoK9AnF/yaX7q2Tm88ekMFybMmSOId+Nj1OVfDoa7V/NKXfXO4kCK1H?=
 =?us-ascii?Q?qHzFJyqo8NHf3vCsYek45CTd2d3XESth7WDo2ZnnvY0wBmg1KR5a7V5L+Qat?=
 =?us-ascii?Q?qHajMizTVeAxBd+j5yZKqV+PJmtd5hnDlrcaPW0EQpJL0XyCAb5Xuu252hLF?=
 =?us-ascii?Q?D104QnNZsEmJE10JXKeIgn87pB4SFZzAmVz3cl3LNGFQz8n1lxT2iLfRibvp?=
 =?us-ascii?Q?bd/AiJus16UYzrVkHyJ/24e29ZjKInK9ldw78GcpxFCOhFaKA7DzwIViOe5t?=
 =?us-ascii?Q?iPwCjkl9ef0NRLbnNBHVXG5GMcXhAhmsT9Olkfja5zklm/dFX0/PSOEuBuap?=
 =?us-ascii?Q?Y0c90Sl5UWfk6Lhl/g1wCSLpQqlajXVCgFNebz5fhl6nQPGDgLaNsjcvuVoR?=
 =?us-ascii?Q?B0mujfWLbT0bJuBJ4bEUWfw2wOWPM9Or9YwKERsVq9uBQsJ5003jSbK2VE02?=
 =?us-ascii?Q?7O1IhW/IYFkNnTJPqgVic+hiWmXZRyidcuRiLloS1lgj156VoJKpmEt2Fs2g?=
 =?us-ascii?Q?hQARykVKgaCzUpKQdTtcRwUacG/8IU+pFHZJQnD4or/MeEZJKh4iuE1rfHhm?=
 =?us-ascii?Q?3Kj+2L31lJuzFSdbvY+ZdKAoEuT8B24mLi/HEnUK5gLakF2AthEueQo7u+iP?=
 =?us-ascii?Q?PDrDmhfMFOgf5Fzp8ben/L9rINgBthJGfiqtZyc17Dr/P6qJ0nWUUDAeZE3R?=
 =?us-ascii?Q?WisbxRxbnjRdt1QZ1Wd5Xv5/EJL0UU7xgF4r/7JW9GyuIvKejry1rkeL2Npe?=
 =?us-ascii?Q?bf78R6/T8GBwl/AFcETcPJMV88l9fxjVOoLI6NBXpkNQvZ/+KbQrUo40362f?=
 =?us-ascii?Q?9L8AdjBhFgp3iDECDaJSNpmz3UwQ3W/NLUDi31IjOOKJlFJgyH5ahO+Pe+q4?=
 =?us-ascii?Q?fW310f+HiXhOjuJMbCJA8pKyA8axdUK9xn0UvgDeGKQX/qXR+ljAeYyfT5oX?=
 =?us-ascii?Q?16myoIWZkpBqUXINT9YczWvZ09BPuicApTvgZSBtJ7+UqQz16Hw0/vrZEWrA?=
 =?us-ascii?Q?tQtoUBqiWQkcTu6Y7uwt3dwOlzOouBTsTtRRX7j3SzeXTbY4SEDzTGHX8cgE?=
 =?us-ascii?Q?dEYzUsslK7BYWkYQxRCBCI0cYS40FGo=3D?=
Content-Type: multipart/alternative;
	boundary="_000_PA3PR07MB10721BBBEDB19758D2B399E7B8A312PA3PR07MB10721eu_"
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR07MB10721.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de3d5829-f1ce-453b-adb0-08dea9b49b2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 08:10:29.5829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nDIKc9MsAkQ3H3y/BjvuEoVI6bTO0Hx9GxbXohiu3x5fX4zo6MGmmCnC4HmDJHjrQcoPAjIWrlbnurweHYGQA1HWhUFPHeqmV3xh/RPv/6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB12318
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 04 May 2026 08:10:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3906

--_000_PA3PR07MB10721BBBEDB19758D2B399E7B8A312PA3PR07MB10721eu_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Yes, I can keep the rest locally and wait for the oe/bitbake to get resolve=
d and backported to scarthgap. I believe patch 2 will be needed at some poi=
nt by the other series, so they can build on top.

In the meantime to avoid duplication of efforts I'll focus on the changelog=
 to be integrated with oe-core.

Thanks
Daniel


________________________________
From: Alexander Kanavin <alex.kanavin@gmail.com>
Sent: Monday, May 4, 2026 9:52 AM
To: Daniel Turull <daniel.turull@ericsson.com>
Cc: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproject.=
org>; paul@pbarker.dev <paul@pbarker.dev>; ross.burton@arm.com <ross.burton=
@arm.com>; yoann.congal@smile.fr <yoann.congal@smile.fr>
Subject: Re: [AUH][PATCH v3 3/4] upgrade-helper.py: Add stable option for p=
atch-only upgrades

On Mon, 4 May 2026 at 09:34, Daniel Turull <daniel.turull@ericsson.com> wro=
te:
>
> Sorry, I misunderstood you. I though it was only the changelog going into=
 devtool.
>
> I'll check the bitbake-level. I missed it.

I meant particular this response to a patch from elsewhere that aims
for a similar function:
https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.o=
penembedded.org%2Fg%2Fbitbake-devel%2Fmessage%2F19414&data=3D05%7C02%7Cdani=
el.turull%40ericsson.com%7Ce3d0c1c80f124f1c639d08dea9b21238%7C92e84cebfbfd4=
7abbe52080c6b87953f%7C0%7C0%7C639134779439726477%7CUnknown%7CTWFpbGZsb3d8ey=
JFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsI=
ldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dh0JNlQNZUVuuoe1IReAyBWXaWPNSbtscOLuJCA=
1w20Y%3D&reserved=3D0<https://lists.openembedded.org/g/bitbake-devel/messag=
e/19414>

> So we keep patch 1, 2 and 4? Probably the most important is 2 [PATCH v3 2=
/4] upgrade-helper.py: Add compatibility with Yocto scarthgap, the other tw=
o can be optional.

I have to ask, if 2 is applied, would that be useful without the
ability to pick only stable bugfix-only updates? You'll probably have
to maintain both 2 and 3 privately while the 'stable updates' issue is
resolved properly in oe-core/bitbake master.

1/4 seems fine, the function of 4/4 is fine but I need to review the code.

Alex

--_000_PA3PR07MB10721BBBEDB19758D2B399E7B8A312PA3PR07MB10721eu_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
Yes, I can keep the rest locally and wait for the oe/bitbake to get resolve=
d and backported to scarthgap. I believe patch 2 will be needed at some poi=
nt by the other series, so they can build on top.</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
<br>
</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
In the meantime to avoid duplication of efforts I'll focus on the changelog=
 to be integrated with oe-core.</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
<br>
</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
Thanks</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
Daniel&nbsp;</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
<br>
</div>
<div dir=3D"ltr" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-s=
ystem, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0,=
 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_MSFontService, -apple-system, Robot=
o, Arial, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" id=
=3D"ms-outlook-mobile-signature" dir=3D"ltr">
</div>
<div id=3D"mail-editor-reference-message-container" class=3D"ms-outlook-mob=
ile-reference-message">
<div id=3D"mail-editor-reference-message-container">
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-family: Calibri, =
sans-serif;"><b>From:</b>&nbsp;Alexander Kanavin &lt;alex.kanavin@gmail.com=
&gt;<br>
<b>Sent:</b>&nbsp;Monday, May 4, 2026 9:52 AM<br>
<b>To:</b>&nbsp;Daniel Turull &lt;daniel.turull@ericsson.com&gt;<br>
<b>Cc:</b>&nbsp;yocto-patches@lists.yoctoproject.org &lt;yocto-patches@list=
s.yoctoproject.org&gt;; paul@pbarker.dev &lt;paul@pbarker.dev&gt;; ross.bur=
ton@arm.com &lt;ross.burton@arm.com&gt;; yoann.congal@smile.fr &lt;yoann.co=
ngal@smile.fr&gt;<br>
<b>Subject:</b>&nbsp;Re: [AUH][PATCH v3 3/4] upgrade-helper.py: Add stable =
option for patch-only upgrades</span>
<div style=3D"font-family: Calibri, sans-serif;">&nbsp;</div>
</div>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<div class=3D"PlainText" style=3D"font-size: 11pt;">On Mon, 4 May 2026 at 0=
9:34, Daniel Turull &lt;daniel.turull@ericsson.com&gt; wrote:<br>
&gt;<br>
&gt; Sorry, I misunderstood you. I though it was only the changelog going i=
nto devtool.<br>
&gt;<br>
&gt; I'll check the bitbake-level. I missed it.<br>
<br>
I meant particular this response to a patch from elsewhere that aims<br>
for a similar function:<br>
<a href=3D"https://lists.openembedded.org/g/bitbake-devel/message/19414">ht=
tps://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.ope=
nembedded.org%2Fg%2Fbitbake-devel%2Fmessage%2F19414&amp;data=3D05%7C02%7Cda=
niel.turull%40ericsson.com%7Ce3d0c1c80f124f1c639d08dea9b21238%7C92e84cebfbf=
d47abbe52080c6b87953f%7C0%7C0%7C639134779439726477%7CUnknown%7CTWFpbGZsb3d8=
eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCI=
sIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&amp;sdata=3Dh0JNlQNZUVuuoe1IReAyBWXaWPNSbtsc=
OLuJCA1w20Y%3D&amp;reserved=3D0</a><br>
<br>
&gt; So we keep patch 1, 2 and 4? Probably the most important is 2 [PATCH v=
3 2/4] upgrade-helper.py: Add compatibility with Yocto scarthgap, the other=
 two can be optional.<br>
<br>
I have to ask, if 2 is applied, would that be useful without the<br>
ability to pick only stable bugfix-only updates? You'll probably have<br>
to maintain both 2 and 3 privately while the 'stable updates' issue is<br>
resolved properly in oe-core/bitbake master.<br>
<br>
1/4 seems fine, the function of 4/4 is fine but I need to review the code.<=
br>
<br>
Alex<br>
</div>
</div>
</div>
</body>
</html>

--_000_PA3PR07MB10721BBBEDB19758D2B399E7B8A312PA3PR07MB10721eu_--

