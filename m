Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F3FC982FA
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 10:57:08 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.13])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4364.1790161026513552218
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Sep 2026 03:57:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ericsson.com header.s=selector2 header.b=lg6hJJ83;
 spf=pass (domain: ericsson.com, ip: 52.101.83.13, mailfrom: daniel.turull@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INZSPxjOserIAWJI3zEGu0rt2LTWJ3q87OgAT/nFFuP5XwUJ3MpGXiqHJvyIzfFe4TEI62ud53uy4KzIBd07fLzQPP/fnK0qk71qJeg3QlYHFlBuO5K1Lo3geX1LtqndDpnMdZYOWW76pwyhI8f+XopeNEwmp3bQQnnrvIDDFCMCI5sQetCj0bE6jODjFGhHZxolb1HATj+f7upIyfmQYPiU0JcJwhl4CEccs+L8N4DQPArrpOJtGFF9CRfaz/BfGiGE++zFvEVq8hVeHMf0blzMOobzUl36e7tCgHS+OH7I1WsdUgqbN8ObdSkM+sLGh9WVjQBlLtXKVbClqnkOWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OanoYJLZ0np/Fol9EOMzUItg3LSDvv8HEne2HcgY+Ug=;
 b=VHZhtBTPRV3olbyumb+GUst9waibc/Ol+IAG6jrwMR6/ozN6WjTD62hVVLX9Tg98aBfncMgvSgiR7ZuexztGmihJT/IVTT4eZyueXdfVRX1lR0+3E9ANQjHNyK7OgySGl2NK2FvT+BRuDOQIPjszttc8oxlOrSjhwU1F2fDbEisaxuduacgtA2AZMS3qS3CtGAWuEb8CF/OhnZwmH1xmZ/Pv6hmauXz8cLvGRQ7eiyzNpJ5Fj1O6KdXQ9DFnKtG7iZi6TljL1YLeCESvx7fYorWt8nLPSbEgkz9Siu4/PNKo90z47d3suVZpWigqMOT06N59rVX0xpqFwaChGYyT7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OanoYJLZ0np/Fol9EOMzUItg3LSDvv8HEne2HcgY+Ug=;
 b=lg6hJJ837WVHq1lpuOxl3ZfvKUFcq19g2a4i6dYHlWMWd/SdlaErFxT+mwZZ7eknXSBY/xJXAUYNFR4OXZ74h4s76hNVqfPpksiWTyTIvEUUfGgZFja/Xkkjj0ZZeu2v9/M382AqeROqAHCyomJgXVhL7qzjKzvJCtMuc7yxOwkEByRjNBEdS1PINQrU+pxnveA2iaQLdmtLtWXM/M8KaIUDCXItThJaJWi4hWMG6ynbzFS2faao3udM02neR+Iff755rpL7y6oI1B2jFoBHwq1A5WetJMguGt8Gt69MsZWQOqklrvRn6R7xhw4NAtO0EkGMo58AeIUugXJ6DCx3KQ==
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com (2603:10a6:102:4af::6)
 by VI1PR0701MB6784.eurprd07.prod.outlook.com (2603:10a6:800:19e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 10:57:01 +0000
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7]) by PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7%2]) with mapi id 15.21.0428.015; Wed, 23 Sep 2026
 10:57:01 +0000
From: Daniel Turull <daniel.turull@ericsson.com>
To: "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
CC: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: Re: [auh][PATCH v2 1/2] steps: skip duplicate changelog for
 shared-source recipes
Thread-Topic: [auh][PATCH v2 1/2] steps: skip duplicate changelog for
 shared-source recipes
Thread-Index: AQHdSzlWNyjrfqeBIEKaZAlE9+wef7bb3xSAgAADBICAABv5AA==
Date: Wed, 23 Sep 2026 10:57:01 +0000
Message-ID: <3e6689a46732c1c657491159733ae9c1fd10366c.camel@ericsson.com>
References: <20260923085528.88881-1-daniel.turull@ericsson.com>
	 <cf408d794ae1149af198fa0acb1e9d9d1ac87755.camel@ericsson.com>
	 <CANNYZj_BgVKGcndf=BfuUcBMexPG3Fa-Hvjp8wkVOrf8AkbPHg@mail.gmail.com>
In-Reply-To: 
 <CANNYZj_BgVKGcndf=BfuUcBMexPG3Fa-Hvjp8wkVOrf8AkbPHg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR07MB10721:EE_|VI1PR0701MB6784:EE_
x-ms-office365-filtering-correlation-id: c5627d0e-b0d0-4e73-4286-08df19616573
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|38070700021|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 PRNFm5hmD7G0+brc6nypq9v4ifPuh7y+n9u29CsUz5CvLmwda9IIUqyez8cLOT/R5Ju3eB/GAwcfJALSNNP0OhVfNW16ts/n6Hpc2A8lzPJKxWvq9OQyEn5gLQ5HTEwwfXKsINyM2dwPYyYrK8dfcPq7rMDkwnJo7rSFpfz52HIMIBs4WkzDQ8Pt8ao6EXshvcezx8LuUQ4pf3a6GrqL6WBj/H1md+vWAOzbqIyL+3s8s0lDNgQ3sobYYUdDQONTI09IMeSzzSVXIgbW1Jnlpqo8bpKxAZwv0YjhA+Lnb/dI9gipuM2SMxIDNm0QpJqoEq6NX0rUpDakPKfVflD7g9AyQMpR2MJd9wLuGF/UYoP2CjyWxvB5vNI4Pp+jyikY1neAxQ7kpxq+nUVIuASw0yUjyYAml7RhPZ2IoU/204uBfTIzc78b3yV569sjuFjRFiFdZxLBlBZ1biSHe6QCKtj1vkQUjP4wGX0jRLnEAzu/hRABiRwH+N1qiieasnJjev8FideUfHlQXn5DHZXGCe8GCnP4mkRTi9XeVdKEaSErmQtEsOEfLe03TWMgoDUoKpIBW3598iSQJ1KyvS0Nh8wReBVMTzsYy9wtVT2gscfFBlI9XAp7tFcay7umnAyonlGlQB/3tcg9XvwvLxOv5k/qhgLh+dmWtTC/BLkpYXU=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR07MB10721.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QTlQMm9MUlRMNUM2NXNPYzhITnNucWxhaCtxSEtHb2p4YTh2SDFmNitkVTE4?=
 =?utf-8?B?Mlg0cExpeCtuZHI0WW9nazlyc3prNkFRN1RRR2d3c3dHc2U3VG5CUHcxKzZa?=
 =?utf-8?B?bW1YZmpMa3lUT1gxS2JaNEpXSzJycEN5SUhKbkRMeitLK2cvcjJBWkRrN1ls?=
 =?utf-8?B?c0Nwdlp2bUs3SUthdDNTTTdJNGVxR0ZwMVRIcmhsaDlsamk0YnN1cm9VWFpF?=
 =?utf-8?B?c1IxM3RlTWlFN0F0Z2hoeEpCOWtvY0NnTGhMUHpOQ2RlclBOY3hQSktlb09E?=
 =?utf-8?B?UG1wTkVqQ1VFbUR2Tnlsdy8rOENoaEY0VXZ6bTJYZGYzV1hLQkFiZ0Z5aVRV?=
 =?utf-8?B?dVhrdGlJSEZjTVNlSWt2WWpPY3UrVjkxWG9uVVFOVUF5N0lxWHE4N1VwWkNh?=
 =?utf-8?B?b3dvMkNSbHBQU1ZvekUrS2h2RXMrbTVKc1FHZWlycUI5VjlTd1dJcE02UjRT?=
 =?utf-8?B?VjF3U1pTU1VDUmdjSDNCSmlualV3WXp6QVIzd2RxQ081N0RUN0NIWHlscFNj?=
 =?utf-8?B?Y3dQelh2OGpXcWdtb0VCUWFId28yUW1wOHowUC95bXk5UjRTSjVGV1Vrb0Yv?=
 =?utf-8?B?bGdaclBSMGZjZjFxK2ZHbldJMVkxV1J4a0xib2hNY1RCVXJ3NHpLZUIvcW5B?=
 =?utf-8?B?ZEUrcGQyTGlTMjZFVEJHc2s5Y3d2UnRGVjkrSll4UXNzcytkQWtibEdjamRh?=
 =?utf-8?B?aDN5VmJDdmN2UHlTSnpIUlJPV0lDVm1oeHM4NnRjS1RYRDQrR2RSN3pCc0ZY?=
 =?utf-8?B?UmMydHpVemJ5N2dUbWR2elFiUU9DOHE2SWtJZWZWQ3lSMnVidmR5WXM5ZHhy?=
 =?utf-8?B?NnRrNkJkK1FneDczU0NoSjRvOFBKb2lFVkVhdGh4cVVkYmVwT29jN3hDUjha?=
 =?utf-8?B?aDIrb2ozd1hTUUFLa2VjUFdhOGIzNjBnYmg3d3pVUURScnhIcFlVNWhEOHUv?=
 =?utf-8?B?aUE1UHdZNnRmdUxwaEVtZk9icnFORTEvVTdYdG10SHpnMFdSUTBnUDVFN2Zs?=
 =?utf-8?B?NU41SFIyVFUydFZROUhKMjU1UlRhN3dnaGpORExaZ1VIZVQ2VWZKNk94dUxt?=
 =?utf-8?B?dXBkRHJzenQrckZ3WHZsc2V1aFJBN2hBTGI4UGt4VDBEak95cklVWjVYM2or?=
 =?utf-8?B?S2J0eEY4R3ZHQjNLaHNNd1g4MitlOEErTkpHMm1qQUgzVzBZMXhLc3BmU0JF?=
 =?utf-8?B?dFR3TEdyTHowR05MVno4YWl1dURRMlpzVlIrSWUvWHlUcUYxb0dFREJBVXNu?=
 =?utf-8?B?eDlCWi92V2hZQ1pvR0NFQUluQ1FrbXpSTW40clRQQ0hVM1dVQWpNbmtRWmc1?=
 =?utf-8?B?ZDNDeTVDcSsvamlRRXh1b0FWKzBYMFNYdEsrSzUvS1ZsMkRVS21HRmJDZndl?=
 =?utf-8?B?RGViZXNnM1VqUjlvY0hQa0orZzhLOC9VdHdvOG5ZMXVOdzZSbXpJSjZNakQ1?=
 =?utf-8?B?ZGtxRlREcHE2WlNMWllZcUVFVEFZYkV4NnVJVkxqVmxzclRadHV0R0h1anZL?=
 =?utf-8?B?MmZpV1k4WUplbTdVZzArTmszU01mcERCcXBhUzVzRW1UZ2tQOTBhYWRpaUpp?=
 =?utf-8?B?MDJubGpoSWcyR0YvYkdtZUwyV0xkN2JPOVVDUFh5S3NhZVJXTnJmQWY3KzF4?=
 =?utf-8?B?dXNvTFVwN0p1Wkg4YyttNXZmak56eXp4UUlXSTRLaVhQdDYrSTY3dytZelBU?=
 =?utf-8?B?RkVlODdRbXdOdEpSZ3BRZmY2NEdiL2hrd2ppZzNjUVBXb2JQSmJRL2FCSHdj?=
 =?utf-8?B?bVo1cU1LY2svNTduekR6QlNWN3pTWDNSV2FRYmkrelo1U0xMQTYxOW5MZC9E?=
 =?utf-8?B?M3BObXZXRDVPcEpwaDh6YkhIbzI1M2djTjVjSUxEY2hTcjhZeDlEL0pXS29Y?=
 =?utf-8?B?dFZsRFBiU1EvWS9XVlpNTGtTc1AwdmNEQ2lGYVJuajk3d1RDZXlhU1BBL2tl?=
 =?utf-8?B?bHhLblZSVjdzSjA1bThnRXliZkhEd0VyV05keithSlpyQlV6eXErVlJBUXBF?=
 =?utf-8?B?T2xsWnFiUjJrSkgzbkdObkFHWFlrWEVkRjlDVDRBS2F4RGFsOU55cEUrVHQ1?=
 =?utf-8?B?QjlqRzhrOVZGUklrQ1J1am5veUVkWm1jTmhmOVZ3Z01TZFA0cWEyc2hiNWxT?=
 =?utf-8?B?QnZvSTAyOTZlV1p1VEQxSWN6RXUwSnk5dWJRWkhUNmZkVVJVUnIwdTI2SzYx?=
 =?utf-8?B?M3UrbmJYMkYxT0dnRU9MWXJ4bkJxa3hnUlhUcWtXM29YSk01V2QxaVFVenBl?=
 =?utf-8?B?NnpDRkNNSVk4cmhPbnVwWjQ4TG05MmYrZm1TbmtiM0g1SWpzUUJqZ1hIaTB0?=
 =?utf-8?B?Ti9TVVJUWmFJWWJNQU1Ga3kxc0plQnF3a0ZNQVJMOExQSnI2UHNvODBLeVVn?=
 =?utf-8?Q?Eu6g79HoC6W0a4C8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74E9EEBEC602E4459BE48273D3674279@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR07MB10721.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5627d0e-b0d0-4e73-4286-08df19616573
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 10:57:01.4197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2x3mQ2Fpbrtt5a1jHyQu7Q9MpKRsLTn9Gp3M3zAjZD7qSGYlwNqqos2zpa/hmGVk0HFqENCMJ/RS0Z87U0+t5xJ+syUJb/UfH2d0ZHDRviQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6784
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 10:57:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4940

T24gV2VkLCAyMDI2LTA5LTIzIGF0IDExOjE2ICswMjAwLCBBbGV4YW5kZXIgS2FuYXZpbiB3cm90
ZToNCj4gDQo+IE9uIFdlZCwgMjMgU2VwdCAyMDI2IGF0IDExOjA2LCBEYW5pZWwgVHVydWxsIDxk
YW5pZWwudHVydWxsQGVyaWNzc29uLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gVGhlIHBhdGNoIHdp
bGwgd29yayB3aGVuIHRoZSBvZS0NCj4gPiBwYXRjaMKgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
b3BlbmVtYmVkZGVkLWNvcmUvMjAyNjA5MTgxMjAxMjUuNzcwNjA0LTEtZGFuaWVsLnR1cnVsbEBl
cmljc3Nvbi5jb20vDQo+ID4gDQo+ID4gdGhhdCBJIHNlbmQgdG8gY3JlYXRlIHRoZSBtZXRhZGF0
YSBpcyBtZXJnZWQuIFVudGlsIHRoZW4gdGhlIGZpbGVzIGFyZSBzbGlnaHRseQ0KPiA+IGRpZmZl
cmVudCB3aXRoIHRoZSBjaGFuZ2Vsb2cgc2luY2UgdGhlIHJlY2lwZSBpcyBvbiBpdC4NCj4gPiAN
Cj4gDQo+IFRoYXQgcGF0Y2ggaXMgYWxyZWFkeSBtZXJnZWQ/DQo+IGh0dHBzOi8vZ2l0Lm9wZW5l
bWJlZGRlZC5vcmcvb3BlbmVtYmVkZGVkLWNvcmUvbG9nLw0KPiANCg0KWWVzLiBJIGRpZCBjaGVj
ayB0byBxdWlja2x5IHdpdGhvdXQgcHVsbGluZyBvZS1jb3JlDQoNCkRhbmllbA0KPiBBbGV4DQoN
Cg==

