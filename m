Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02500CD13DA
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 06:49:49 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.28])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33594.1777963780355454448
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 04 May 2026 23:49:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ericsson.com header.s=selector1 header.b=ggg6EBvh;
 spf=pass (domain: ericsson.com, ip: 52.101.72.28, mailfrom: daniel.turull@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NMRptEwvjCpHKDj5gfUJwGWeI0+8dT8caUT/USXR1sGtRSQByWQ39tozftXH3yrP/SMWRs97rNtDEFc9QFqBV4KFStS6aTnf1P8GnYgDGs41OuYtg5c6zw2w2wjMQQRpDLFcYzdfnBgRqbYEG4zh2QR0y8CrBGTbHIglvvvZniUBW1SkEhnp4xV4RDT826T8FyCcSbgZ+CwthiYREub8VLsD+Vs3vwZxLk7ohncHGenaYOEcTLbtb55Ix+vyU/Qqs7HN1sQbndrp+YNbvCX+OdBWWfMsN+oWxt95/mjKQzhTXRGip58VBGlJ2fbXyPkDc3mEHEyqnUnUsovqMQtpVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0psxKC0dpDE+BtTSFJJkimr4BtSBUSPSqhu/nNWi+A=;
 b=H1Z66rRfD9TFEE5xMMPtxU+Yx10avLQjhLXv5OKny3pmYyoC+Ox7VfiYCcTkH7kdDxEWenWxYzkjl2JEHAPd/OV3qrwv2BUwUtaCWe5anJhnGPDohRqioeQC9sTW7b7GC1Rr64y9KnrlSPGEDNq1/Wf+AresQkWMFTY6+Fr33lwT9C/v/FwjbBjYdM/cTsin+ONe58k47F1x36j8QeVbzXxRmUbqwo2S30vlbXqt0JCDmqi+3rGmftBI5dtq7ydcV4flO3WGKfKiO37yZI2QkRXGRNwGNX+0CIz18C/fi0v5W2SBvI75jxWOOb5ICmrX9RPnluXsZzQ2Lodp/bO5Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0psxKC0dpDE+BtTSFJJkimr4BtSBUSPSqhu/nNWi+A=;
 b=ggg6EBvh9yqudNzdBBVemNEUFJ+1s9EvsIhNbC2BsUe7X+aWT+F4Kim8AAjBCvskcxlceDRXL4prjGia/EfklGdahBeWktPSO0KnNkxBuX2b2UI9rv0wpf5yRILjZQ5CbgYST+LC5YzNU8Jx6RtAj3WnRCe4lGFZqzrOcSKnnVJhQZ3m0N8tupyf2j7E+x7HwI2h0+NWI++DYhqsXdEA5VX44P/eK55aYlG7ydPzJLJkm+10tX9w2jz6FZDF7zgIf5ADUsLbByorKkfAS4T4eVMKYlQY2zmWdO5iMDVKjqBS72qqawj/q06eKp1/nPrHqUtrkL4TPA3iMCPYoJxQxQ==
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com (2603:10a6:102:4af::6)
 by AS5PR07MB10105.eurprd07.prod.outlook.com (2603:10a6:20b:683::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 06:49:36 +0000
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7]) by PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7%7]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 06:49:35 +0000
From: Daniel Turull <daniel.turull@ericsson.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>, "paul@pbarker.dev"
	<paul@pbarker.dev>, "ross.burton@arm.com" <ross.burton@arm.com>,
	"yoann.congal@smile.fr" <yoann.congal@smile.fr>
Subject: RE: [AUH][PATCH v3 4/4] upgrade-helper.py: Add resume option to skip
 already attempted recipes
Thread-Topic: [AUH][PATCH v3 4/4] upgrade-helper.py: Add resume option to skip
 already attempted recipes
Thread-Index: AQHc25BWphQJJ8eqaEeUMPgwF9QnwLX9hFCAgAF6hDA=
Date: Tue, 5 May 2026 06:49:35 +0000
Message-ID: 
 <PA3PR07MB1072178ACD37973C762EAE17E8A3E2@PA3PR07MB10721.eurprd07.prod.outlook.com>
References: <20260504063614.3831203-1-daniel.turull@ericsson.com>
 <20260504063614.3831203-5-daniel.turull@ericsson.com>
 <CANNYZj_UU10pV=pHBi_GOK5m0NsC5EzLB828k9Q08mG3K-wj=A@mail.gmail.com>
In-Reply-To: 
 <CANNYZj_UU10pV=pHBi_GOK5m0NsC5EzLB828k9Q08mG3K-wj=A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR07MB10721:EE_|AS5PR07MB10105:EE_
x-ms-office365-filtering-correlation-id: 438bdede-f2b8-4b04-b068-08deaa727896
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 
 ZD3DWIomkIWjo0DCnb6tWTjUdrP3yDpC5vTB2lYClzcK4deaK7G8oikD/c7Po5zn2QQH/RC7N6skM29ihMT/D1Rdk9JndgASs2xxnZ+d3oAu/X3xSTbfopFyDoJ9Yy8nSP1DmtuYWJrvvweu0NarwL7NbLU4ITCN8gC247vIJtxoWNAGWL1OSQH0beQo4tWi8Jehe8CIY+nmS75Z8f+NUpF5wakGKLD8rezIkVMEr2uwbSDyCaQMo6GZPOhPgUtdQ1WMlpWDMCTPxcDjJAzhJqbWTCWlLj7ia4BRnugQiwieY9hKez7jdrpNDp7Kd2dPb6RRI/pLnsgXaCLqTHzUCNRPpMe7O/HjNEqqC7/ZInz5HouE1EGRvGtJWeN9PnJ/1LW6RWKaOpXYAgccRXU0YisARhFCRl+ZsaeRsRItDzaiMVx+5IlyAnnbYil0skt/UYlKf4uAfM/otwB759e37d+9cnAt1dUdOKtc7RBUSoRiPEQX889ydo8KcVl4WcTswDbZPSiPEpDuaYNVwvxQnsKWFIvTgVYsbQQZgquO0feW6PeUxa6WxQOHinAS0AlTEdF/dsXpfdMQWrNK7UqY9kEtLUvrH1BKbD+mNSTinOc8MNw02AOIUWxMH0sjmUl5K7p3Rx0bYup0AyNh4UJhl00byWsIAaeRWVfpgkAnk6vCBP+RFLa7SemqYL9662p34qk09Nerw7HpYkax7IF4OWkB+5h/AUenA462VlnRbmkDa5MHsV1XjJMD8qo9M2cX
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR07MB10721.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Z2Q4N3VxZEhleWZVR2wzbklPMHNQbkd4N0ZEanhva2dqaGpqOUt2SUxZTkdB?=
 =?utf-8?B?TWZpK0FrUklhdFVzUUtQMnFmTjFLcnBGUmdDVWpDRHYwTUxsUHlOeENha1NS?=
 =?utf-8?B?MzV3YmpNUTIvL1ovdC9VamVYRDhoQVpmdU90UU5Vb0Rxcmd3V0J4NzE0OEFS?=
 =?utf-8?B?TDdiUFhhbGd3TGs3TWw1Rmp2WVhabHdVd1lXeDhrYzA4TE45Uk9jZ2pkRlVT?=
 =?utf-8?B?MzhwY0RUaE5zQ3pLU0lTNEhveWE3UW04RFJNNVRqRk1TZ1EwckdJVHN1RS9X?=
 =?utf-8?B?UHBudDYwZ21kWkxnOFR0QXpHVFJ3NjlZMVFpMjcwM2cvdmVRNGVNTkwrYXR2?=
 =?utf-8?B?aDU0d0FteDJpWUcvUnpGcURDYjNWbndQVEtRQU5FTCt5SkZiVUJ0OWZaYWY4?=
 =?utf-8?B?RFg1UmkxU0dEV1ZyWUNHRHB0akRMT0ZnRUlISnY0K0RGVE1iY1NDaVFOM2pt?=
 =?utf-8?B?eU94NG1NU0YwNnRFM2hZck0xVmhUT1lDWTM2T3ZLRlJrZGlpTCtzYWRDTzdv?=
 =?utf-8?B?L1l1aUhnMHFWL1RWVDQxS2N3L1FrNHFyMEtDS1AxT1BENHE4OGJQMDFQb25i?=
 =?utf-8?B?K2I2RTc1TE5FK1haWFl1TDRGdFN0QkV6N0xZWExhV1g1NmN5ME5zWmxSZHU3?=
 =?utf-8?B?bjgxTFVmbDRYejlxM1dTaDhzc0ZST0xTaW5Bd0xiTFVxbnd2NVMrcTJkV0Qv?=
 =?utf-8?B?RE5wSFNVNGhsc1o4amRpTHRPVzlxQ215UWozWUZ5U0RvUmRwTTZMWGxUUnp2?=
 =?utf-8?B?NEtxOHIwRm5wdzJ5SE44UkxEUldsaU5TZmhlbmF5VExoTjFsL0FDMXltblNW?=
 =?utf-8?B?WVJhOVRvMGIycTBQb0Vmd2ZabThFY1R5ZjE0TEZYQm4wYTVhenBJSGg0TVph?=
 =?utf-8?B?YzhNYWkvVkpIYlpJUSt3RE1WZlB6VGd1R0dzN3Ftb2k5dUx3S01SWGJmdUln?=
 =?utf-8?B?WDMrRFFRRFIvTGRmZEVjTnpkKzJRQUR3d21jQVJjZWJydC9XK2hHeDBSRnVj?=
 =?utf-8?B?cjR0R0N2azBnVzNTb1RKTUtLMHI0WVRPekc4aUJNRkZQWWdiN09Pa1J6RFl3?=
 =?utf-8?B?cUtKNHlUUFpqMmV1RmZIanVEcHkrRWNkd0p3WXZKSUN2UGJheEpxSFg1NEZG?=
 =?utf-8?B?dlNrdW0veGgwRGVIUUhYMW5hL0JoY2VCcmd1SEtEcUJoS2UvNjBmb0dZODRn?=
 =?utf-8?B?YUJlYXlqcEdUaS9XdHlnRUpTY0pCSmMxclQzN0RuOEFSZ1NSODZxMW1BNVNJ?=
 =?utf-8?B?RnN4MGliZnJVeGpZeXc0TE90cVVkOTJ2OUxKREVtQkxEV3FzQzJNUE1UM05C?=
 =?utf-8?B?ODVKRWNsVzRSYzNvK2l0bk9zSTc3TlNuRElVVkROc050d1dxWFIxbTNjV1M0?=
 =?utf-8?B?QVdGbGhob2FseFZxNzAzMDRBWnhqTmpjRjZiZUR5ZlNHRlJROE9KNTlBZTJF?=
 =?utf-8?B?eEhVaFJLd2lUQTdkeDlGZzJ2TGFUbnFaZ0EzRUZnYjFWRTBLeGlUQmdJRno0?=
 =?utf-8?B?K01HRUpNck5VNnFvTGdrelNJL1NSSW5FbUVkMzAyaTJVbGlSRjFaZ1k1cTYx?=
 =?utf-8?B?UXc0SG5LN0x1dWYzSUJudENLeWFLWTltbVhUTVBKMjl1bUcwUmd0cXRRN0lI?=
 =?utf-8?B?RGtkeWN0alBpdEVTblUwdXZ1Rlo4Y1hXUFg3VGRHK0J2NG1nSHpOdDZnYncy?=
 =?utf-8?B?bWtESWgyVnlNbTA5UHEzOW9EVDNON3g3MEFRb0pJVlY1dEo5Rm1nTTBJVmRO?=
 =?utf-8?B?UXNVZUwrOUIvSzhnZUxSTUNmWS9vN1JQSkJHMkF5dFNjUFZ5dXQxbTk0Ylc4?=
 =?utf-8?B?dktRUUNYSmhuUytrbjhUalp4cGdzQ1h0c3ZUV2VHZHcyNmdZSmZ3RjdrQ1k2?=
 =?utf-8?B?Q2JQM2lwWEZIK0svczFUbHJaaGdkcHBTSUN3UjJXVUwrTytiT1g1bXI3OVQ0?=
 =?utf-8?B?MEFqaWxYT2FOUzBjakh4TEFjU3NXcXV0UElsYlVlbmVlcnkxa0pZZHA4am5z?=
 =?utf-8?B?N0FKenNEWUVpQS9yUXRoNTFqYkk4NEcydFBDblZMTTJkNjZib3hpaE1tb3RL?=
 =?utf-8?B?YVZSMmJyYTdsMmJnUi9GNjkwSTB5K3JQMmRvSFhucHc0NlBrSEMzc0ZsSjdu?=
 =?utf-8?B?LzhqWXZMK1N0dE9jcHRyZUlWNE52aW0ySUNQcjduYUwxc2VVd0FweGJBdEJH?=
 =?utf-8?B?Qy8zNUhPajV6SDBXeExIZXhLeDhDMzBVaHdyVXRmc1lvcjREYW82cUs0d3V0?=
 =?utf-8?B?bWFPdnlici9RWW5tZmNydGU1clFIeGgyL0dlZ25qWEM0dXg4bmNvT0VtWTY0?=
 =?utf-8?B?M0Q0b1AzRUVYRlh4L2haUE9iVTZpK04wcG10cDFtdnEreml2Tmg3U0lPenZx?=
 =?utf-8?Q?iV+QXDxQb12ufqU7rVBX8Zmnf/mA9GXtXWoyCvsgq5hDa?=
x-ms-exchange-antispam-messagedata-1: Emj5qS1UKOYSNUnqa+BhQaYCIF13zCvEhAg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR07MB10721.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 438bdede-f2b8-4b04-b068-08deaa727896
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 06:49:35.8915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LvIFiw6BE9afKOv8nwq4lBcE9zKhdvkhkarX647MbTyviSlgtCxIo70IvPrV1+Kndzn8KLE6+7gcvQ/jBmtEhmN8jhecwWhYMoy93T2QGjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB10105
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 05 May 2026 06:49:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3911

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleGFuZGVyIEthbmF2
aW4gPGFsZXgua2FuYXZpbkBnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgNCBNYXkgMjAyNiAx
MDoxMg0KPiBUbzogRGFuaWVsIFR1cnVsbCA8ZGFuaWVsLnR1cnVsbEBlcmljc3Nvbi5jb20+DQo+
IENjOiB5b2N0by1wYXRjaGVzQGxpc3RzLnlvY3RvcHJvamVjdC5vcmc7IHBhdWxAcGJhcmtlci5k
ZXY7DQo+IHJvc3MuYnVydG9uQGFybS5jb207IHlvYW5uLmNvbmdhbEBzbWlsZS5mcg0KPiBTdWJq
ZWN0OiBSZTogW0FVSF1bUEFUQ0ggdjMgNC80XSB1cGdyYWRlLWhlbHBlci5weTogQWRkIHJlc3Vt
ZSBvcHRpb24gdG8NCj4gc2tpcCBhbHJlYWR5IGF0dGVtcHRlZCByZWNpcGVzDQo+IA0KPiBPbiBN
b24sIDQgTWF5IDIwMjYgYXQgMDg6MzYsIDxkYW5pZWwudHVydWxsQGVyaWNzc29uLmNvbT4gd3Jv
dGU6DQo+ID4gKyAgICAgICAgICAgIHByZXZfcnVucyA9IHNvcnRlZChnbG9iLmdsb2Iob3MucGF0
aC5qb2luKHNlbGYudWhfZGlyLCAiMjAqIikpKQ0KPiA+ICsgICAgICAgICAgICBwcmV2X3J1bnMg
PSBbciBmb3IgciBpbiBwcmV2X3J1bnMgaWYgciAhPSBzZWxmLnVoX3dvcmtfZGlyXQ0KPiA+ICsg
ICAgICAgICAgICBpZiBwcmV2X3J1bnM6DQo+ID4gKyAgICAgICAgICAgICAgICBwcmV2X2RpciA9
IHByZXZfcnVuc1stMV0NCj4gDQo+IFRoaXMgbWFrZXMgbWUgd29uZGVyLCBpZiBBVUggd2FzIGlu
dGVycnVwdGVkIGluIGl0cyBzZWNvbmQgcnVuLCBhbmQgd2UNCj4gbmVlZCB0byByZXN1bWUgZm9y
IHRoZSBzZWNvbmQgdGltZSwgdGhlbiBBVUggc2hvdWxkIGNvbWJpbmUgZXZlcnl0aGluZw0KPiBm
cm9tIGFsbCBwcmV2aW91cyBydW5zIGludG8gdGhlIHNraXAgc2V0LCBub3QganVzdCByZWNpcGVz
IGZyb20gdGhlIGxhdGVzdCBvbmUsDQo+IHJpZ2h0Pw0KPiANCg0KWWVzLCB5b3UgYXJlIHJpZ2h0
LiBJJ2xsIGZpeCBpdCBpbiBhIG5ldyB2ZXJzaW9uLg0KDQo+ID4gKyAgICAgICAgICAgIGlmICd3
b3JrZGlyJyBpbiBnOg0KPiA+ICsgICAgICAgICAgICAgICAgaWYgYW55KGdbJ25hbWUnXSA9PSBz
WyduYW1lJ10gZm9yIHMgaW4gc3VjY2VlZGVkX3BrZ2dyb3Vwc19jdHgpOg0KPiANCj4gVGhpcyBp
cyBtb3JlIGNvbXBsZXggdGhhbiB0aGUgY29uZGl0aW9uIGluIHRoZSByZW1vdmVkIGJsb2NrIGJl
bG93LCB3aHkgbm90DQo+IHVzZSB0aGF0Og0KPiAgICAgICAgICAgIGlmIGcgaW4gc3VjY2VlZGVk
X3BrZ2dyb3Vwc19jdHg6DQo+IA0KSSdsbCBhZGQgeW91ciBzdWdnZXN0aW9uLg0KDQo+ID4gKyAg
ICAgICAgICAgICAgICBpZiBub3Qgb3MucGF0aC5leGlzdHMobGluayk6DQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgb3Muc3ltbGluayhnWyd3b3JrZGlyJ10sIGxpbmspDQo+IA0KPiBXaHkgaXMg
dGhlIGV4aXN0ZW5jZSBndWFyZCBuZWVkZWQ/IFRoZSByZW1vdmVkIGNvZGUgYmxvY2sgZG9lc24n
dCBoYXZlIGl0Lg0KPiANCg0KSXQncyBub3QuIEl0IHdhcyBzb21lIHRyYW5zaWVudCBlcnJvciB0
aGF0IEkgaGFkIGJ1dCBub3cgSSBjYW5ub3QgcmVwcm9kdWNlIGl0Lg0KRWFjaCBydW4gY3JlYXRl
cyBhIGZyZXNoIHRpbWVzdGFtcGVkIGRpcmVjdG9yeSBzbyBzeW1saW5rcyBjYW4ndCBhbHJlYWR5
IGV4aXN0LiBSZW1vdmVkDQoNClRoYW5rcw0KRGFuaWVsDQo=

