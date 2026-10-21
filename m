Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9402.1792583192902082546
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 21 Oct 2026 04:46:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ericsson.com header.s=selector2 header.b=m5xRhQUo;
 spf=pass (domain: ericsson.com, ip: 52.101.84.52, mailfrom: daniel.turull@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORGRC5B0kiqtki9v8RuPhlqrAO4ZXw1URhsB+w55Cw5ZPNWlQ2soD7qjOCJPoWs19Ec6avg0+1DQYXhoPGY9xGpp/ULuaskL5qGD/DWErMngoZzw/uhVIEqBuKzUw2iDRkuVGxDOgHsroiPKE4AdKRajUPYcN+BFygh25bpSIsLyJahT2LID58WppdVpdKIlY3/hQKsyK7e9fQh9x8jqqt9lIKQIabrl/2ZL5wQrz7XnJ7XYj4rb8GEP5ylbc6sB3J8B4BwFOjlJaSMA0SqXbA6JBDQ83dsSrSwQWM0tSvzA9v+EtqkfW4mD1oYbp+h6J2EYIcGoNcTmcktHXYf4jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rl1nvyUF3uUj4djOSj6fx2ZUh2y/o4oHjiEmLFV0aWs=;
 b=pnij6pIpjBaroZ01CaOoyQO3eFTN/EFbiXaReZZyi9MbAJPmGo8JuPmUF+hp3q5b0kbAGwJPOFMLw7wQGPZqjJyJ4zPrGu26MRAZJedGLDgr643gzHpVqTxCeA5mxoC/617LRtlg1ea3aX9zGgOBI3h+OVEZJrix40FZVUa5AXFsfk8NeWRlkfRRz+x5GcT6rgkl92dpTkAm74cmHCmp0Wk4F2dcWqzNCU6V0NPavCbByn9VNG4sliVdEpagHIClFfShxYMuPgaCzu1dwOL1w45cYbMpYuwhK3RCueaSWlrxk46Gvg9t+clTs0VDRQvUJCil4wayMdr7Q4XUWd3WRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rl1nvyUF3uUj4djOSj6fx2ZUh2y/o4oHjiEmLFV0aWs=;
 b=m5xRhQUo/WO+h805GVxkPI7njyhtsOU7tJqnf4SeWhO+oPHURR/Pm+pY1GS7jAvhD9rWPX/s6jQlQuecDJQKneHhcTuKOqU8A1GUTbkWrl23u+SRsscMdVGkawNgyVZ6E5B5i9RwT5GV/lrv64RL53R3vtHzVO/+PkRgH5WUFEtNM4OCanP09xCeBSs4lsPpV+3sV1tH1w1Iz6Iml9dfLUYPlbaxW9yy2gCRWDqe4PYomIUunHvoSNhoUo2i3p6eMiTaJjp4zYKxlJB2Bd5WOPEa9PFHge6Mv0TIF/N32d+AToifad/uKsC07NG/DXD01gCB4CW5+baSKVSMkmtzaw==
Received: from AM7PR07MB6437.eurprd07.prod.outlook.com (2603:10a6:20b:140::11)
 by PAVPR07MB9382.eurprd07.prod.outlook.com (2603:10a6:102:310::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 11:46:27 +0000
Received: from AM7PR07MB6437.eurprd07.prod.outlook.com
 ([fe80::fb9c:237c:ec12:2db0]) by AM7PR07MB6437.eurprd07.prod.outlook.com
 ([fe80::fb9c:237c:ec12:2db0%5]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 11:46:27 +0000
From: Daniel Turull <daniel.turull@ericsson.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>, "richard.purdie@linuxfoundation.org"
	<richard.purdie@linuxfoundation.org>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH] auh-config:
 skip changelog in commit message for noisy recipes
Thread-Topic: [yocto-patches] [yocto-autobuilder-helper][PATCH] auh-config:
 skip changelog in commit message for noisy recipes
Thread-Index: AQHdYHK0Hp77FA1gyUuUL89XL95ofrcH0AOAgAACjACAAAQsAIAAAK+AgAALSwA=
Date: Wed, 21 Oct 2026 11:46:27 +0000
Message-ID: <03b68a01d051fec5e2c3697b3035ab85cb1f25e6.camel@ericsson.com>
References: <20261020090917.3132154-1-daniel.turull@ericsson.com>
	 <CANNYZj9P-15TVaO5fb3AD9Xa1mrMpt9aP7GApTDGombuGNe6oA@mail.gmail.com>
	 <f3a03e28b28b60530cc801b66001a3c9e6b11543.camel@ericsson.com>
	 <CANNYZj8n_Xy2jNwttzuaLRg0Hbh70mTFbSQddhXpNA71aTeo5Q@mail.gmail.com>
	 <b3d1b28dec5c150330528ff579d20009845e8e38.camel@linuxfoundation.org>
In-Reply-To: <b3d1b28dec5c150330528ff579d20009845e8e38.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR07MB6437:EE_|PAVPR07MB9382:EE_
x-ms-office365-filtering-correlation-id: 65c478f2-1a02-497b-bf10-08df2f68f0ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|10067099003|18002099003|56012099006|22082099003|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info: P0dRpi5I5X7GcbCOpQzGEAqEhb+br18YcFNzaFxx/ahK/D2JMtDY9sFS8ABFNaYTfycnkwDrc3DlTWmBwu31zbwnQOwppJDxu75mcRUORuLEETzuv5pEclx8GMIeQPAIyR2LFSv6Tprx4Qu4s+Bma9ZDA1pvBuvojxiQMsO5rzovBUE6+bTrpa3FwT7n0EjSjDY1QlHeZ18s3NGko9foVDUm2H4mjwOPcZVR/xE9VNWNd/3+smuXg5EExDokvkwyOeYc2AbcicqO8OhNMBzYqKAlyfKSAXlmMZ1z7K97/bOKhXpn3tvbZ2idDKYDLK0bN3LDplTuC+BKgnzvD6RwD49o+d3W0Cl7ThFoQro9IZhZ3OzK1g5mivGt8kwwu2Izp+VdGdXlTYh05DCr2N4bWKBvLB0IZo8kjFb9aV+pAQRFoGhNcEdvbyZUIK59y533J0W5wyxSMEOZmo+tdu7zSaNZFeuaPICWB9BjsZDSyGJPgDE17ZlbWuhYUM/H3m/eBDsROSR95up86ASnMMw4WEwKe21YX/8HX1nk4kvi5RRzda+D5gpqpEdEnNDsuTKacTsF1O1y3vPwNnyLiDhTEno+dokI9KYj2yITVZf305eiF5POZNIKWQ2Lf8oiDcXg6RfqWfeSs7yfNwNH2D44eSYvOz/NzPrDVeKSq2WCwlwZEjpasvf+YTRxPhXHIVvjz5Twwna9RGs3WGCwNTytrk9SqyD/IVkjQaB6B/iy6tw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR07MB6437.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(18002099003)(56012099006)(22082099003)(4143699003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1ZJeWJQYlZFRm9LM2pYVXp5QTVzRkRac2JNeUtTb1NoSDZrYkh4TkVIMExY?=
 =?utf-8?B?ZWVTUU5BT1RtWEhTQkhHK3UyWkZoYnNaU0JFT3dQVUlyYUpGYzc4c1hzS0ZH?=
 =?utf-8?B?Y01BUDAzZkp1RU10dm5FUnp1YVZFWXFLWjc3ckhiWExFbTZXTUVyaWlXLzVL?=
 =?utf-8?B?d1JpOHBZaWp1NHBnMkZ6UWFETTNBSFpWTjhFcVVCMEtMTVBCcjZWc2VNUDds?=
 =?utf-8?B?c3g2NG5GM3ZvN0x2eG1qM3p2dFBQa0FNNUtuU084SzVxWmZjdUwyMGM4SHF6?=
 =?utf-8?B?dTIyeDdsVnNxUzVPck10cUpaUVlqQkRvY21MZGlBZDFVOWtoSHFhV3lqU1Q2?=
 =?utf-8?B?RUdyR0hRL2txQTFwSkYzeGpmK0IvcEVTNSsyZVlFZm5SZTJlQ0lOaE4rcUVa?=
 =?utf-8?B?eXdPazJnOEkwR1NqZW5ReTZxSXNtdHpGVWg1eXI1RHdpMzBTR05Rbi9LNXho?=
 =?utf-8?B?Z05vejJIYngzUWJXVWF2TVg5WkJDRUNLZlZSbFV2TWo0ZEhrNW93QndpKzND?=
 =?utf-8?B?MGRiY0VtbDZXaHhqb1dtL0VVRFU5SmQyc0hMZ3R2S1JCdjY0UC9iNjVSejE0?=
 =?utf-8?B?MVM1c0ZWTWRnRXNmTUFjSGplRW9OK2s2WFFXK3UzdlE3SGlNZ2lkNk4vTDMy?=
 =?utf-8?B?Mk1hcXhWMCtEWE5sd2Ftc0NUSG9IT0R0dUU4cERsZWR2RVlrWjkwUVM0ZWZr?=
 =?utf-8?B?K0NVblowMjBmcGlzUWFZR3Ird3VOWTUwb0pCekpWNGN3YXI3c3hLelI0aGJ5?=
 =?utf-8?B?eUtuUEJ0VlczUHJlUVkxTHFxNWhMbnhCTm5vSWxJaUc5TlA4SXhheEJXUCtJ?=
 =?utf-8?B?N2hJQTRnTDFMVTYzMDdySjdZU3pDTXV2RG1haitDQWFad3p6WlRKYUtrMFhN?=
 =?utf-8?B?czVsbW5iazB0RXhMOElPYWFvcWMySWJlZW12aEd3SUZ5TUJGN3ZPVkxUbkdr?=
 =?utf-8?B?RHhDcTR5RUlYNDBjR2YzRzJuOWRYNk9NNlRYamtBOVFxckJFMGI3TVZ4cW9h?=
 =?utf-8?B?VWZ6M2JjR2d2Q29qc0FrMGpnalcyR2xnQmxMdzJHTnhUNGZuSjhEenppVXFT?=
 =?utf-8?B?NEwrNzl0ZUsyaWJ3dHovKy8vV1k2NFpKQktpZG8rWTQ2ZUQ5VDYyeWh6ZFl0?=
 =?utf-8?B?YlVTd3pyL0Q1bVVZemdSengzcjVPb2dKU1lDYWtGUUpneTN6T3JYUGNGY09m?=
 =?utf-8?B?TWdiK2kwRk1Sbjg2TXB4T3JUUnhiUnNQR3BKY0xobmRVazM3ZDlzM2JHN3BF?=
 =?utf-8?B?a3VsdUFWQ0ZBajUyaGpPQmg1V0xaQmNOZXEvNzQzK2hWRFhscFdWaXZwcjdG?=
 =?utf-8?B?UWhHNlpWR2VzS0tsdVpZczRJREtrOUY4TVpHRjB6MzVIRFhDVFAzdk5mZTk4?=
 =?utf-8?B?d0ZGOXJadGVTUUFKMXIxOW5wSUtYVXk5bFVzR3RRY1RPWEo3cUFybyt1eGRL?=
 =?utf-8?B?ZDRZWUZSVmplaVRGUGY4RkQxbHcveDJkbGlRdlp4UXh4QnF4cmNESDdSdDdq?=
 =?utf-8?B?YTQ2SkRzbnZDdGM1UWpWc2JmWTQ0NVc1eVVqU1ljRzJSTmk1WnRlWGhnenpt?=
 =?utf-8?B?WlpsMVBmaHRpdHdIVlhwQUowT3ZVRENDaytKY0gwN3plZ21ZRXZGK0VXL0Ny?=
 =?utf-8?B?b0VSblY5R3pVT1pXcVV3VmZwUHVwS0dZYUozR1NkYTAzak5uWVd4TFhMbTR1?=
 =?utf-8?B?V2ZtTzhPbVZDMm9QUUVrSFNVOVZXVDRnMm9iUnJUa3djaGRQM2Y5SnVqS3Bu?=
 =?utf-8?B?T3ZnTWdsZkNaU2oxM1JBUE1IcHAxd0RHbTYvV3NxdUVmUVR2dFdod3pIT1Yr?=
 =?utf-8?B?Wm1qWVhvMTJidXozOHZIZFhQeVgwL0Z4ZkozYld6UUxBVGtYN2hIUTI0ZTUy?=
 =?utf-8?B?TnQ2UTA3QWZJTmx0TmQ0NGQvdEdyZTA3N21GK2Z3TnhQYjBEaXVoRzJpNUNk?=
 =?utf-8?B?SEdPY3RxRnEraHFGQ2pFZGRQQnZ6WkxRc3ZoLzlOSzdoU2lEVHU4OEFwZC8r?=
 =?utf-8?B?Q2hzMVNvVE5xQjFRZ1M2eFZoTklZOHhyK3ZLU0Y4VzVnZnBPZGtiTmNPa2hY?=
 =?utf-8?B?M1lIa0dOWWtNM2dROVlKUkQxV0xRRFNFYWJubWtDVzZiVWV6VS81MDd5RGFW?=
 =?utf-8?B?YnlNRzJhZEwzSzZZNFVpN210WlprREVTYzhKbjhpeEVNQ2ZLK0hHMXhSS1V0?=
 =?utf-8?B?SlowRFN6bE1Zb2JTdDRmdU5yMU9DL1dXNXFCV3h6SGMvOU43RzE0RDJxSkJQ?=
 =?utf-8?B?R1RTTEFrSTlmcEhFZEVnQTZEZTBaUS92Mm9uZ1B1Ym9WWmNyUE11QzZTNUVo?=
 =?utf-8?B?bDMvQ0VNTTJsODJnVkdPSVgrUnlZM2VqNFNEVkRBbng0MXg3QXlJWlRLM1g4?=
 =?utf-8?Q?+uuDVtYBhf1oIihc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B25D19F6BABEA49A4CA1BE9A5CABB84@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR07MB6437.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c478f2-1a02-497b-bf10-08df2f68f0ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 11:46:27.5313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MtjzazMlsiP912Ou+WtFvy+VyjUOTYbckgXatHC9nBbyCM5fjlfyAFUJg13+IF916/PM/tiqOWc9vIDLQbwLOQWhAIpiKy8cdckbmLKnoaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR07MB9382
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 21 Oct 2026 11:46:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5124

T24gV2VkLCAyMDI2LTEwLTIxIGF0IDEyOjA2ICswMTAwLCBSaWNoYXJkIFB1cmRpZSB3cm90ZToN
Cj4gT24gV2VkLCAyMDI2LTEwLTIxIGF0IDEzOjAzICswMjAwLCBBbGV4YW5kZXIgS2FuYXZpbiB2
aWENCj4gbGlzdHMueW9jdG9wcm9qZWN0Lm9yZyB3cm90ZToNCj4gPiBPbiBXZWQsIDIxIE9jdCAy
MDI2IGF0IDEyOjQ4LCBEYW5pZWwgVHVydWxsDQo+ID4gPGRhbmllbC50dXJ1bGxAZXJpY3Nzb24u
Y29tPiB3cm90ZToNCj4gPiA+IE9rLCBJIHdhbnRlZCB0byBhdm9pZCBleHRyYSBsb2dpYyBhbmQg
a2VlcCBpdCBzaW1wbGVyLiBIb3cgb25lDQo+ID4gPiBkZXRlY3RzDQo+ID4gPiBwcm9ncmFtbWF0
aWNhbGx5IGJhZGx5IGZvcm1lZCBjaGFuZ2Vsb2dzPyBidXQgSSBzZWUgeW91ciBwb2ludC7CoA0K
PiA+ID4gDQo+ID4gPiBJIGp1c3QgZm9sbG93ZWQgdGhlIHNhbWUgd2F5IHdhcyBhcyBibGFja2xp
c3QgaXMgZG9uZS4gSXQgaXMgYWxzbw0KPiA+ID4gbWFudWFsbHkNCj4gPiA+IG1haW50YWluZWQu
wqANCj4gPiA+IA0KPiA+IA0KPiA+IA0KPiA+IEJsYWNrbGlzdCBoYXNuJ3QgY2hhbmdlZCBpbiB5
ZWFycyAod2Ugc2hvdWxkIHJlbmFtZSBpdCBieSB0aGUgd2F5IHRvDQo+ID4gc29tZXRoaW5nIHRo
YXQgZG9lcyBub3QgaGF2ZSAnYmxhY2snIGluIGl0KSwgYW5kIGlzIHN1cGVyc2VkZWQgYnkNCj4g
PiBSRUNJUEVfTk9fVVBEQVRFX1JFQVNPTiB2YXJpYWJsZSBpbiByZWNpcGVzLiBUaGlzIGxpc3Qg
aXMgbGlrZWx5IHRvDQo+ID4gYmUgbW9yZSBmbHVpZC4NCj4gPiANCj4gPiBJIHRoaW5rIGEgYmV0
dGVyIGFwcHJvYWNoIGlzIHRvIHB1dCBhIGhpbnQgdmFyaWFibGUgZm9yIGRldnRvb2wNCj4gPiBk
aXJlY3RseSBpbnRvIHJlY2lwZXMsIGFzIHRoaXMgaXMgYSBkZXZ0b29sIHVwZ3JhZGUgc2V0dGlu
ZyByZWFsbHksDQo+ID4gbm90IGFuIEFVSCBzZXR0aW5nLiBEZXZ0b29sIHdvdWxkIGluZGljYXRl
IHRvIEFVSCB2aWEganNvbiB0aGF0IHRoZQ0KPiA+IGNoYW5nZWxvZyBpdCBwcm9kdWNlZCBpcyBs
aWtlbHkgJ2JhZGx5IGZvcm1lZCcsIGFuZCB0aGVuIEFVSCBjYW4NCj4gPiBoYW5kbGUgdGhhdCBm
dXJ0aGVyLiBUaGVuIHJlY2lwZSBtYWludGFpbmVycyBjYW4gaGFuZGxlIGFwcHJvcHJpYXRlDQo+
ID4gc2V0dGluZ3MgZGlyZWN0bHkgdGhyb3VnaCByZWNpcGUgcGF0Y2hlcyB0byBvZS1jb3JlLg0K
PiANCj4gRXZlbiBqdXN0IHNldHRpbmcgdGhlIGxpc3QgaW4gYSB2YXJpYWJsZSBzZXQgaW4gbWFp
bnRhaW5lcnMuaW5jIG1pZ2h0DQo+IGJlIGEgZ29vZCBjb21wcm9taXNlLi4uDQo+IA0KPiBXaWxs
IG1ha2UgaXQgdmlzaWJsZSBhbmQgdXBkYXRhYmxlIHRvIGFueW9uZSBjaGFuZ2luZyBPRS1Db3Jl
IGFuZA0KPiBjdXN0b21pc2FibGUgZnJvbSBvdGhlciBsYXllcnMgdG9vLg0KPiANCkkgY2FuIHdv
cmsgd2l0aCB0aGF0Lg0KDQpJbnN0ZWFkIG9mIHRoZSB5b2N0by1idWlsZGVyLWhlbHBlciB0byBo
YXZlIGl0IGFzIHZhcmlhYmxlIGluIG1haW50YWluZXJzLmluYw0KdGhhdCB0aGVuIEFVSCByZWFk
cyBpdD8gb3Igc2hvdWxkIHdlIGp1c3Qgbm90IHByb2R1Y2UgdGhlIGNoYW5nZWxvZyBmb3IgdGhl
DQpzZWxlY3RlZCByZWNpcGVzPyB0aGF0IHdpbGwgYmUgZXZlbiBzaW1wbGVyLg0KDQpJJ2xsIHRh
cmdldCBvZS1jb3JlIHRoZW4gd2l0aCBhIG5ldyBwYXRjaA0KDQpEYW5pZWwNCj4gQ2hlZXJzLA0K
PiANCj4gUmljaGFyZA0KDQo=
