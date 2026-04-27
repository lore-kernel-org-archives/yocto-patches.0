Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18627FF885E
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 12:31:23 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44095.1777293079626535049
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Apr 2026 05:31:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ericsson.com header.s=selector1 header.b=jBRu8WNa;
 spf=pass (domain: ericsson.com, ip: 40.107.130.49, mailfrom: daniel.turull@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gk6DipQqIkoHPl3vwqwNYX8vFxovAwohQ9R6KMoh6dUEGLw6lXdPqZ8ggGf70JFKQOq+etl+yD+KI33HMaCDlJzDFRIDqTxgUceOkhEetdcy9rCStWiKqAmqmZdEqOnXSXPmDv1OupNoZbhvfSctB8Wwgiohb6/j1xbhY8LPU81FqFtRGzcDjEyK1SLOqPaOTIFJBI5u1gVyg4ad+lvgIexfYIzptdRHkYhI5uT+S3+U7udHt8vVyIrM5d2hA+K5xdvDUlJQpP2m/eXv6n/Y2mBoSoURtw1a6ipXZKqwndchSw3r/VT20mYccC2dlki5Qh+1rYDeuc5Qp2YGRrlCxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWsDRCda60g1gM52c75Tbz9+q0r7lAMtg++EoJQvirA=;
 b=b64XmJER2Sr2gTmydjhyABTzacp9nRzYF7z4jTHwhzU82ZUzZkEeI7X9bN+K2AS+vAA5gAQ1MTJygbrHa7axpJkgIY4elV/ikHoEBH4tHodIKyX+fdq0DBTC9ehoyt7CrholM5saLI0gYBTrlOC61tTgq83hlpJXn9SLFc1ZDRVBF3H8GIn/jWrKu2YiZEqIoPuBl3MEUg5kA+C0Ouy3fpePWzgJ/0AjAoitlYtFM71+svkwU7K1FG1/87ISpaD3gza5PqGeTV3I5O562Es5d6g9d9OAsR1xhlQOA387UXfdo9VSs3nfrfkZHiCTXY9MViDlwCR3uKhCJoHxuOAa9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWsDRCda60g1gM52c75Tbz9+q0r7lAMtg++EoJQvirA=;
 b=jBRu8WNa5w2+H2LlUoGc9tBTeajMAVmIRttls5zJ6xZ2RkNznN24COQX06xXjTse2DxCa6yYcloZJLDXFvdd1r+1RKW3KL45U9qj0lamdR9Drsyx3cgOOzkUQeJrj0XxpoFYa5aRm/q2flwp2pxOUvEUSsgCGCNePIMoQHrNCYjNG0sjnsL0qRVBjp194xNI4oo9B7YFVj1cUl3gvlmf0jKslZoPM9vh1F4xc2Duxo9zrFoBvnEDfpYry+Jnc2mQ0Ug2kEudua50l4402QU1wr4RyttfC1eFJ2QXr9TiClZN3Q7cCA3tifypylbvjQs7duSH3NbROKAWIC6DwJmR0Q==
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com (2603:10a6:102:4af::6)
 by VI2PR07MB11055.eurprd07.prod.outlook.com (2603:10a6:800:29e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 12:31:14 +0000
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7]) by PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7%7]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 12:31:14 +0000
From: Daniel Turull <daniel.turull@ericsson.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>, "paul@pbarker.dev"
	<paul@pbarker.dev>, "ross.burton@arm.com" <ross.burton@arm.com>,
	"yoann.congal@smile.fr" <yoann.congal@smile.fr>
Subject: RE: [AUH][PATCH v2 9/9] upgrade-helper.py: Limit number of requests
 to remote servers
Thread-Topic: [AUH][PATCH v2 9/9] upgrade-helper.py: Limit number of requests
 to remote servers
Thread-Index: AQHc09/4ajKMlmo5Nkid+nuFfxwmqLXyu1IAgAADiYA=
Date: Mon, 27 Apr 2026 12:31:14 +0000
Message-ID: 
 <PA3PR07MB10721AE3B885739E9601C2E6A8A362@PA3PR07MB10721.eurprd07.prod.outlook.com>
References: <20260424114603.2444938-1-daniel.turull@ericsson.com>
 <20260424114603.2444938-10-daniel.turull@ericsson.com>
 <CANNYZj8sG7A+o2tmNr2EXVd2td7+CGxRuvB6X9YWPRmWUFAYJQ@mail.gmail.com>
In-Reply-To: 
 <CANNYZj8sG7A+o2tmNr2EXVd2td7+CGxRuvB6X9YWPRmWUFAYJQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR07MB10721:EE_|VI2PR07MB11055:EE_
x-ms-office365-filtering-correlation-id: 9b7e616f-93da-4e68-20d7-08dea458df6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 
 s2G5G/XKbUYO7GTZX7TneHhMPpcVlS24iSAHYs2dhAzTpPjzzWfF1Oha4maYvYWDfnduj9IEAMdB8HmnYUcYvvu2aRhq0L4xdRjGVfxnfjKMKSEH0yxwyQQtCbYk/p96tFg7eFgU7lK0/rzxfJbhH5AEieVEtlZLHJW2aOrnMP9JeQ+pElijcL+T21vVvKhPdk2sasIYoUXgGNJo/BMHkfmzu2Pbfta67n1x814aYpyXhkkQ/LfuMcXeUWABoqrdh5ALqVnb9OxqeOcjoUBiR+J6TUYhWOF53NvxgOt4MFh5VWIUO5YMyBdoGfjDi89pz/Dn//SrV21y3fQmcKl2VLNMVYXG83KLs0rINnt2Zi/yM3BZ8IaPwwRGk3QgKfuUtw5paXh638/Vv5r2dfhlhsaZsQuGaRUuZL5bvWLv42W9RDX00n2mpWdx0yXqdLgO/huDRaUNyJHkqfK0Wyj3NsRF3YY/xZA6Kl4TOCJ6vxkm2bxL8mSIaFqHVV37funxYmTeIpOPPErtAddIsGUFyihpt3GU3BwyNAlnnaNvEXGOaJbOPHNkG/FbU3xGQ8CeaAuzHazKfozqsMlWzF1S8U/Be2HAZRMUHDFKBLHLCUH43RfnrAkeHT2uc5ODqkKoTkGG0jdnbi7bvZPCaP6qeH7egYtbszV2HqLnmYLlsL9pTgLMGBcoYtMz7h+Mef00bxRMINTioQJujTEg68FblAw1HCuqxyd9Hx3cdls5Uqs8/70OTDYUx9IVGsMCsw+x
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR07MB10721.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?anBMOGlIU21tRmx6cldBdnJWbTRaUi9hMUFxVDZqNTJGRXEwa2dvOTh5cUVk?=
 =?utf-8?B?NUI2T21HZldmeHNaYUdjV1pGMllJVzZUOVl1ZSsxd3A1OUt2VFRsTEZxK1Bj?=
 =?utf-8?B?ZjdQaGR3RWdXZ2xFUFVLQzROc043UWl0S1Bha0pqUE9Rcm5NQzZwUXRvQjZv?=
 =?utf-8?B?MmtvM1BRdXloNTJIdW9PTXAxS1hCcnlXbnM3eHlXRFg0VHZqclhPaFA4Ym92?=
 =?utf-8?B?NFVZbjFGNEd1MjROT2ovZG5wV2dGeWxjK3MyOFZabWlzWE45MEVHTVNTTG1B?=
 =?utf-8?B?NTR0dUpjRTdKc09Ob0F5OStoUC9xTGxZUFVMRC9pVmZuV0l3V1JPN1pZSHJK?=
 =?utf-8?B?UGYwZGZqZkU5d1JKdjdyMDRuUmZkNzA2eHJabGlmQWhnanJEaGw4TmxwSm0w?=
 =?utf-8?B?K0pzQVlGSk5jWXlVYk9tRHU2ZVNIUlJjaXZuZ1pFZWdBamxpOEdiTGdJM2Rr?=
 =?utf-8?B?eUJrMi95eFNteWgwTEhHcXFPMW05Zm9hQ1gxbEVQUmRFazNDSjlkODdsVk44?=
 =?utf-8?B?dGMvZnV3UnpJaWRIeDF3d2hVWDZFaDBPci9HYnBmRnQ3Zk92WmhJQnVtdXNN?=
 =?utf-8?B?Rk5FMVhsZ3d6UXNmVDFaLzRqVTl5cFR2YlRodFYvTGtXTlVTeFA5bUV5WUJW?=
 =?utf-8?B?MjVVYXVXZUluWDgxMGdaNkM3KzEzWFhza2x4V1ZVNE1VWGhDblcxQi9nZjZ4?=
 =?utf-8?B?K0lXYjZyS09TT1hNYVlKY1ROenZPbE1jRkV5NHAvZlhlRXdjdUZwMEdZUWor?=
 =?utf-8?B?bGlHYkZBTnhrVzFOQU1oOTM1TWlPZ0lDQkxKbXBlOGFZSzhWWGpsZHpKcDB1?=
 =?utf-8?B?MmY4QzBTZGVhRWtsSkN4UE9NTGhIMFNyZEUrem9GY3lsN0JaOVJVVkZNZFFx?=
 =?utf-8?B?Y2QwSUhQblRpUlVYOWdPbjA5c2h1K2VQRHJLUEZ6RG5vU1l6RVowL1lSY3lz?=
 =?utf-8?B?TWYxNUVvNHRnS0NEMUswMUxpUGFERm1PSGZJVmsyeHp0VEhKRUlqYjZuMzBm?=
 =?utf-8?B?cmdIU0VMVXhielFWcFhlRjB0RzBWQkZLNEdBUFhwSWorRkxEcXB2anVKSDEx?=
 =?utf-8?B?QmtuUVQ3YllTZE1rTjExbGd6eUpUckgrdHd5eUFwK2VzWlc5SW16bFd5UmFr?=
 =?utf-8?B?SlplaHJzRUhYaTVIcDA3dUZ0U1JHSDFpYkJuR3UxSDBmV3JjZTNBVkpONHQ4?=
 =?utf-8?B?YVRqbllWVjdMTlg1Q0hKZmVPQ0J6ODZRVHBHNUlua2U0aHZ6ZTAxV2x4YXFs?=
 =?utf-8?B?V2pPTmY0a05HRmFvaGk3YmlqV1BWYTkxSHBtaFZucEo2TU1aU3NOSmpvMVp6?=
 =?utf-8?B?NXBpcnM1NDc5Rk04NFowaTlHSFpQQmtnOU90UDB0VjVXMWw3TkM3VW1kcFBJ?=
 =?utf-8?B?c2NtbnEraFRUY1VmbmdsV3RqdnJrR3ovcTZ3ekdLaDYzQjQ0UU5PNUo0QWVZ?=
 =?utf-8?B?ODVlNERBQ3FWeHJoVldGSjRlVWdHV2hiV20vbWZnVHZlclFBL0pKL283Y0ZW?=
 =?utf-8?B?em9hSzVpNjN5T2ZWZ3ZqejJTZDBvd3JMRUZxVitERUpEeWFzd04rQTMvN3Rx?=
 =?utf-8?B?YVlaSXpSNWN4NlFzTFNZVjNBSVdmT0VkSUkveG53RVpvWHh4U3lFdlEyVkQ3?=
 =?utf-8?B?empEdkJMV0dtYjU3cWRINEVlQnEwcEFqYnNPbktyOG1qanFXbTlOdTEvWTJ5?=
 =?utf-8?B?Rm5vUjFncTU3NXBvSVlnaER5aWZXUHVMWFdzOHdMOXgwS25rMmdGVW96dDBz?=
 =?utf-8?B?dUxNVHdGWUtoMHh0SWtkRUFKM1l4Ukh2UGEwTzF2YTdQRHB6N244aWxJV3pF?=
 =?utf-8?B?SnVkdUtxN3VDWGVFdnNRQUlYaWM1dVlEb2FpaHRBWERjaTVzRnRSWXZNZ0Nt?=
 =?utf-8?B?M1FPQzd1eElvaUlmQkV5bkFsdWo4WEV0Y3ZHWCtMcFZjNnc5RUU3VGdDR2FJ?=
 =?utf-8?B?VEZEWCt6OUYrMDZ4bk9FbXRRWU1qTnhtUjN6WjBaeW1tbzFYcWJXZXprSTRs?=
 =?utf-8?B?SEwvOHh1dXg2WWd6SnlDS3NQZkJmZWpxQzRMTTdueS9MM0RsSGs3bnV3ajBY?=
 =?utf-8?B?bnFOSlNWdzNRczg4MXJvQ1VaNFdhUGMwRkFpUER0elkrbTQ1QjFsU2FKckVF?=
 =?utf-8?B?cFZkK2M0N01jU1krSkZlNUhEclFVWlg4WGwzT3RNRFQyUHZGTEp6MVMydXp0?=
 =?utf-8?B?MjNaK2dwLzU2SUVJMDU0Nmh1cVB6dVBGTFBBVE0vbUMxY2gyUyt3MWlWSHhp?=
 =?utf-8?B?d0tVaXZQZjRKV0JlZVJlbkRzSWVpMmJQc1pYdzR2cnQySlVtWlk4SGo5ck9y?=
 =?utf-8?B?Rm5BajdBejBzejh6UHh1UllPcHF5K1owalQ3bFBUclFhajFOQzFZQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR07MB10721.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7e616f-93da-4e68-20d7-08dea458df6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 12:31:14.5146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uB+UlpV2tnkUQd7LNVNbetu9PYvI3vBH5V3IZjZLF15oxKqc5U15ZFVHjc1ocEDHKbH/7SdQtf+hNmIM5wFTzkFdIchYaRKdvX4kHzNNS4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR07MB11055
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 12:31:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3843

SGksDQoNCkkgd2FzIGV4cGVyaW1lbnRpbmcgdG8gcnVuIGl0IHdpdGggYW4gZWFybHkgdmVyc2lv
biBpZiBzY2FydGhnYXAgYW5kIEdOVV9NSVJST1Igd2FzIG5vdCBjb3JyZWN0ZWQuDQoNCi1HTlVf
TUlSUk9SID0gImh0dHBzOi8vZnRwLmdudS5vcmcvZ251Ig0KK0dOVV9NSVJST1IgPSAiaHR0cHM6
Ly9mdHBtaXJyb3IuZ251Lm9yZy9nbnUiDQoNCldlIGNhbiBwcm9iYWJseSBkcm9wIGl0LCBqdXN0
IHdhbnRlZCB0byBiZSBhIGJpdCBtb3JlIGdlbnRsZSBhZ2FpbnN0IHVwc3RyZWFtIHNlcnZlcnMu
IEknbGwgcmVtb3ZlIGl0IGZyb20gdjMNCg0KRGFuaWVsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogQWxleGFuZGVyIEthbmF2aW4gPGFsZXgua2FuYXZpbkBnbWFpbC5j
b20+DQo+IFNlbnQ6IE1vbmRheSwgMjcgQXByaWwgMjAyNiAxMjozNQ0KPiBUbzogRGFuaWVsIFR1
cnVsbCA8ZGFuaWVsLnR1cnVsbEBlcmljc3Nvbi5jb20+DQo+IENjOiB5b2N0by1wYXRjaGVzQGxp
c3RzLnlvY3RvcHJvamVjdC5vcmc7IHBhdWxAcGJhcmtlci5kZXY7DQo+IHJvc3MuYnVydG9uQGFy
bS5jb207IHlvYW5uLmNvbmdhbEBzbWlsZS5mcg0KPiBTdWJqZWN0OiBSZTogW0FVSF1bUEFUQ0gg
djIgOS85XSB1cGdyYWRlLWhlbHBlci5weTogTGltaXQgbnVtYmVyIG9mDQo+IHJlcXVlc3RzIHRv
IHJlbW90ZSBzZXJ2ZXJzDQo+IA0KPiBPbiBGcmksIDI0IEFwciAyMDI2IGF0IDEzOjQ2LCA8ZGFu
aWVsLnR1cnVsbEBlcmljc3Nvbi5jb20+IHdyb3RlOg0KPiA+ICsgICAgICAgICAgICAgICAgcGtn
Z3JvdXBzX2l0ZXIgPQ0KPiA+ICsgb2UucmVjaXBldXRpbHMuZ2V0X3JlY2lwZV91cGdyYWRlX3N0
YXR1cyhsYXllcl9yZWNpcGVzKQ0KPiANCj4gQW55IHN1Y2ggcmF0ZSBsaW1pdGluZyBuZWVkcyB0
byBiZSBoYW5kbGVkIGluc2lkZSB0aGlzIGZ1bmN0aW9uIGJ5IHBhc3NpbmcgaW4gYQ0KPiBwYXJh
bWV0ZXIsIGFuZCBjZXJ0YWlubHkgbm90IGJ5IGhhY2tpbmcgb2UudXRpbHMuY3B1X2NvdW50LiBB
bHNvLCBJJ20gbm90DQo+IHNlZWluZyB0aGUgaXNzdWUgbG9jYWxseSAoMjU2IGNvcmVzLA0KPiA2
NCB3b3JrZXIgdGhyZWFkcyBpbiAnZGV2dG9vbCBjaGVjay11cGdyYWRlLXN0YXR1cycpLCBhcmUg
eW91IHJlZGlyZWN0ZWQgdG8NCj4gc29tZSBnbnUgbWlycm9yIHdoaWNoIGRvZXMgaXQ/DQo+IA0K
PiBJIHVuZGVyc3RhbmQgdGhhdCB5b3Ugd2FudCB0byBhdXRvbWF0ZSBzY2FydGhnYXAgdXBkYXRl
cywgYW5kIHN1Y2ggdHdlYWtzDQo+IGNhbid0IGJlIGVhc2lseSBiYWNrcG9ydGVkIGluIG9lLWNv
cmUsIGJ1dCBjb2RlIHNob3VsZG4ndCBqdXN0ICdmaXggaXNzdWVzJywgaXQNCj4gYWxzbyBuZWVk
cyB0byBiZSBtYWludGFpbmFibGUgaW4gdGhlIGxvbmcgdGVybS4NCj4gDQo+IEFsZXgNCg==

