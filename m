Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.28])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8661.1792579723639993692
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 21 Oct 2026 03:48:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ericsson.com header.s=selector2 header.b=SMYwP0Ky;
 spf=pass (domain: ericsson.com, ip: 52.101.65.28, mailfrom: daniel.turull@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K88ZYDonrMOxW9oedn1rJJi7bTh7HjZiuJzG4YmX3Beacz6cCGSuwmeQz3K27dDZWnJoJJp9O1BFQRNK/3qsm0tyGTaus13u2P9AKS/B/wp4yxizBfm8tgbkHX8g/a+dll0z2e8EVpHvrxyd0tLi9hsrFCzYUalYwng5MsaEfp1mlSnyY75qk34fjcOkykXbIMsRTEZ1isUFlgI4IasVDDU8E6MKpOLsOsFR6zLiBulGb7STvFxnV6bbqUkSAOpBjyj7xLbVTvJY9YjYLr7owvudhdwhoQZJYNYMysXiUDucKjAvN81CLVAxUjLuxcgmXO5I4BZtN4oJd2GQH8EzFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmpII+Ubwm+ljgnmeJ/TPU8BX9s1OwQ9gBe0qLcsnPs=;
 b=DQU9LUqhFw716THSz3NaL0vs0ta/7W5dxHkz2tcqAewiXKihSdXw7571QtAMoVg2MqMeK9VC2b/KrIM2wmiqKAQlx0yIC1+dETp8ViMH/OI75T1Bnu3oQ47ReYsqzGHH24w8LWxIYLsSfRgdzwkWsLHGyXvd1JvtgH9Q+11HxHMOypsVLrNax9xtOtEiiPqEV7U2WnW2aETO1SKg6EPRCcXt9RB2y+SXPkzRSeWpjTiuyKIpstV/Lcc3UXwcL2zHqJ0mr8QfKLVTibzW8dqgZe9Miq3eBNPA6CnI+VWXqQ5lnOo9MqmdFYDAavFaIFkw80I8uDOFUVwrDlSVpJ5Slw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmpII+Ubwm+ljgnmeJ/TPU8BX9s1OwQ9gBe0qLcsnPs=;
 b=SMYwP0Kyz9wt0AA0OUamXkDT5TKYsCxnilc7s6rQP0JdBD8iK78dK+kWfkkCaTSJFM+x3Z7Xyr8GlcqNK5wjvQs6/+1/SLc54oVgvqJLgp+GOAPpZkOdEFhdecZ7SiYzvYTs7gbcj6oVHAfkUfOAVg1iWVjtNmqWW69zQoknYhTNy87trGpOwBjSv5O16Kcq+P2ogn12e8Feb8gGvbtUmCZ95QVuGpFILKETbTKdfT/go0eHM/2OTfxv18dW0GviZ/KaLClBMkXzJx5zxsDh13srUZgvXvcVSte0BwSq61tUHSgSZwM0IMxCUq8LdZ6XLF61OSui2wYAlVhrfyrt2g==
Received: from AM7PR07MB6437.eurprd07.prod.outlook.com (2603:10a6:20b:140::11)
 by BESPR07MB772700.eurprd07.prod.outlook.com (2603:10a6:b10:144::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 10:48:39 +0000
Received: from AM7PR07MB6437.eurprd07.prod.outlook.com
 ([fe80::fb9c:237c:ec12:2db0]) by AM7PR07MB6437.eurprd07.prod.outlook.com
 ([fe80::fb9c:237c:ec12:2db0%5]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 10:48:39 +0000
From: Daniel Turull <daniel.turull@ericsson.com>
To: "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
CC: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: Re: [yocto-autobuilder-helper][PATCH] auh-config: skip changelog in
 commit message for noisy recipes
Thread-Topic: [yocto-autobuilder-helper][PATCH] auh-config: skip changelog in
 commit message for noisy recipes
Thread-Index: AQHdYHK0Hp77FA1gyUuUL89XL95ofrcH0AOAgAACjAA=
Date: Wed, 21 Oct 2026 10:48:39 +0000
Message-ID: <f3a03e28b28b60530cc801b66001a3c9e6b11543.camel@ericsson.com>
References: <20261020090917.3132154-1-daniel.turull@ericsson.com>
	 <CANNYZj9P-15TVaO5fb3AD9Xa1mrMpt9aP7GApTDGombuGNe6oA@mail.gmail.com>
In-Reply-To: <CANNYZj9P-15TVaO5fb3AD9Xa1mrMpt9aP7GApTDGombuGNe6oA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR07MB6437:EE_|BESPR07MB772700:EE_
x-ms-office365-filtering-correlation-id: ad8c21a9-06cb-4c22-fd1d-08df2f60dd96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: ptn6zSFc6gs6znvj1ZXXUK/JVb7ysTGfpgiINCT/Ag8yt1FxrfGCumBupUyXCzC2D9UIyibZcEQtgsD5JbLPwSCIqeneBK7KNhA+pGlP0sZwYnx1GMgWfgAgfTyVMj/9CcoK+J+lhL3h7T7RRbil6yYICkiP2UUPleAsrV1MNcJy9l4QSLKCyU6wwjFJqRHgunmN/JZamjUVsWs15+AIBjF68q4M0cwKuTFxUiAxH7kRgYdwHwMcXtwCJl9hwAIGMbTSa13WSogOegbUhlV8pe+Rjaaw80bweLuSl+JOjBYfcHfcXVKEerKEYTTwm93aviSB6Jdpq/0qHGJtKlANt+z4+fWvl4S3NV3y3CXNvT5r4x8I0rDGuDVbqQ9VYWVDZNA3SO1ShBYIqwCQtJXoCjvyDnKSGBaLwheedtXiapqmSyHUejp1gvvm1xPfAfKHI7fKTNqSzTlMAE+YI8yPnb5Xx5cg4YJdQFdvpWp5A2GZ8uz8MxhE7oZRSrWYodqtib4VsYnbnvd4r3ZdElMVwqKPHcMKV+DD+aAyDUY50yLFh7FtycQHoDgzzRvcuLAYA7s8oI/1HJXS6V9v3tdg4/963GA52UepBOFOVx8xE8HiTh3K0bwWLDVC8HXxQZmchVZXYo+xaMHa9WWCVQe59s7PIwq9ag92pm5b+1h8GM3vuZVhDLbhYKCl4jlM6fSHFhtz2+uwSqowVkmByZ4Cq97ry5NJv6GwYHiGdeQYN6k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR07MB6437.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFBUb0ZpbE1JZktTQ05vamFpWjlNeVVOWGdENW0rWDNxZGw3SDZTMC9odXY5?=
 =?utf-8?B?V3JheE1mZWM0Q2tVMEY3NnRzUktnazdFUkRxMzdIdUlPTFp6ZStRV3RKblVj?=
 =?utf-8?B?ajhyT0pRT1ovOHVTclQ2UHZEU3FYRFdTNTlnNFNQQnN1Nkl1NlkrTUlVZGdN?=
 =?utf-8?B?eEtoQTd0dzVoYUVTYllMeDZLNVRiNEY1YlhnZDlRYzZhU1BiaElXbk4ycnJP?=
 =?utf-8?B?TGJYWUxEbFlFZzhuTVB3cUVxUitnaFlicWxHM3VGTTkrbFN1bXRGaXJORjZo?=
 =?utf-8?B?ZkpLU2xibTFuU2lpbHhYdXc5b0tScXRlQis4clh5TWt2Q3J4UVphVW1iWmh0?=
 =?utf-8?B?ZGFNSkEyTUJVbDhJUTZIc2NOZnV5MnRHWGVDbjd1OEJEYnVGeWlPS1NnK3lH?=
 =?utf-8?B?MTJUbmRUN2JwN0o4d0VSY2hoL1g2NDBBWWZua1JRcDlLZ3FXZGxndUtkWXBp?=
 =?utf-8?B?YnpxbTA2MC9RT1FETi96Riswb2k1TFc0MEsyMkZBaU1weW83YmdmaDRMNDJx?=
 =?utf-8?B?MWF6NXp1TUVaeWhUdmNiVnJYdm9jeUg5SzNwdStwSy8vZFBOUjd3RkExR05B?=
 =?utf-8?B?OUN2ek1URVE1K0FkZWdiZ01DNUxuV3lJbXNtNTdIVy9yWnJGMEdhOU5DTjdW?=
 =?utf-8?B?QVVvTzdhNDlOa0lFQXRqMUIzT0tSRDlsSGlsVFpvQ2JOdGxNeHB1a2NBNXJX?=
 =?utf-8?B?RlFaS0l2bmlETVFmcHBTbzV6ZURMWEIxWDRBa3VPTnJlY2g0SUZYbTVFT1dT?=
 =?utf-8?B?cFcycS85UWpCMWR0bUQwM3ZWYmFOVG9YeFlqb2FWK3ZXQVprcWlkZmNzVXhI?=
 =?utf-8?B?ZDVHZGdhNVJyV1diY2pmWlRzejBnc0NaZWJoY215cllwdWI2T0lTZVdXZFIx?=
 =?utf-8?B?NERUVXNqOHhhWnV0MU9WckNaTThGQ1d1SVNJSWhhdXptazAzYVlwZVhHcHdV?=
 =?utf-8?B?WEtieW5hVWJiWjNIOEJPcHJWY1hZWlI5QmsySWtIRDVBck9YV2N3NlJsVHM2?=
 =?utf-8?B?T2J6MThHdHJVUHB0d2dINy9LMzRIYURtN011U2ZPbmh2RVE2L0NKcnlFOUZv?=
 =?utf-8?B?QXhLZnBBYXRRdlRjQkpsZDREeFUxSUtYcSs1ZVlaRWoxbkpWYlpqMEhwYkNV?=
 =?utf-8?B?RHpQbzY4N2NYdllvdUF1bmZKaytqdlNDanJkY0N0cHFRYzFxUmFzS1ZyQXB5?=
 =?utf-8?B?cTVnRHY1OFhabVpwRUI4clVpOWNOY2RCN0NkVEc5K3pJVjB5SjQ4WFVENzVq?=
 =?utf-8?B?VmJqaERRa2owWEE4ZFlQSk9ZOGxuVXlIaGdGdGtySE1CbHFURVJ1VlkvQlNO?=
 =?utf-8?B?dUNxS0VJV0pJOTZ6T095bjdRT1ExRDFIZ3VWVVd4cXJORWpNNkdjYk43eW9k?=
 =?utf-8?B?ZUdOWjY4UGpBUXIvRkpNQVdlQ0Z6OE9vaWJkNEF5TFBTT1NQNjArdlRzVTNi?=
 =?utf-8?B?ZXAzOUZ2S29zZFRQWWt6SVIwVk15QTJSaHJzbitEZHBDRjVyUEJaYVR3N2dQ?=
 =?utf-8?B?amlRcVVrUDM4TGFJOENZZGNFZjVFZGxLSFlVNHZ4UXFWakFzaVdSNHAreDJY?=
 =?utf-8?B?QXQvWWFNYkMxbnlWU0k3N0ZpT2g5ZkNoT0hNL0RWQUZjV2FLdjF5MXU5RVp0?=
 =?utf-8?B?a2tQdDBEbnBrWjUzVW1GNWFKcnZrQm9SZzZnNjhMdUNDbFE4T1hPNHJOU1dr?=
 =?utf-8?B?cTJySXhoekJRUDJmb2hKa1NHeEhJRDk2cDA1L3VDVi9Yd0E0Z1FvRXJmaUtl?=
 =?utf-8?B?OEFwUDJ3UVl3MUV5V2tMSkJvSThNUjM4TGIzdnFmVThJNGFCOVM1ZW9zWGlT?=
 =?utf-8?B?eWxObTIzWUNsT0VnU2pQeHJTN1JQRUVlNUFaT3YyRDVYMHNWbEJybjR1N1dX?=
 =?utf-8?B?WUFDMkRZRC9VWlV6ZlBFVDJjWThJTGd3My9GclNtdi9TM0lJMmZHYkJQazFk?=
 =?utf-8?B?VjZBT3RwdE43dWt1S0ZCa0hES1U2Sk1aVnZxdmZ4TXE4emtDZTNiYTZsVHBm?=
 =?utf-8?B?UXErbjYyc3d6RlV0Zmg2N1Fjc2dHcGU2T0FGSHlPK0pKQllkWkYwSllqTk9G?=
 =?utf-8?B?dG5OdHF2UVdKVTRYQjFCYTJnTzdhdzZacEJGSlk1NzZ6dWFtZUdOSkFHbkxh?=
 =?utf-8?B?UW9lM0RxSDlnRXBneDk4K2dTV2xSM25hbVQ0TUtzUjlBKzNCRDZDN1ErckNx?=
 =?utf-8?B?ZVAxajY4dGU3eUxiVDlZM1pBb1RlRnRwdHNMWjlpVDhaa1dxTU5CYU9DS0RM?=
 =?utf-8?B?S0p1UGJ4VkttTHFTVk4yRWMrSXpQZ0t4R2VtSDNpTGt1NHlZT0thWHZpNlZ5?=
 =?utf-8?B?K1BkbUxkYVRZcnljQTNiaDMwRmRPSTdwYXNmU3NpZlBNVW14V0lIY0tSb05U?=
 =?utf-8?Q?TLRqwwznKwMpNsf4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47ADAE0BAFBBA7429C13F27065698994@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR07MB6437.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8c21a9-06cb-4c22-fd1d-08df2f60dd96
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 10:48:39.0387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vbE2SpxpHXXBfbkFovLA3NwZdWRE+DFUAw0v4NspovkbDK4wc+u0YYspzhH+BDsChjMzvM4riTOjdrltg1XovyN3p4gZdMiRIiDVPSGAfp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR07MB772700
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 21 Oct 2026 10:48:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5121

T24gV2VkLCAyMDI2LTEwLTIxIGF0IDEyOjM5ICswMjAwLCBBbGV4YW5kZXIgS2FuYXZpbiB3cm90
ZToNCj4gT24gVHVlLCAyMCBPY3QgMjAyNiBhdCAxMTowOSwgPGRhbmllbC50dXJ1bGxAZXJpY3Nz
b24uY29tPiB3cm90ZToNCj4gPiBUaGVzZSByZWNpcGVzIHByb2R1Y2UgY2hhbmdlbG9ncyB0aGF0
IGFyZSBiYWRseSBmb3JtZWQgZm9yIGEgY29tbWl0DQo+ID4gbWVzc2FnZTogd2hvbGUgcmVsZWFz
ZSBub3RlcyBkb2N1bWVudHMgKG1lc2EsIGdzdHJlYW1lciwgY21ha2UsDQo+ID4gcHl0aG9uMyks
IHJhdyBnaXQgbG9nIGR1bXBzICh1LWJvb3QsIG9wZW5zc2gsIGFjcGljYSwgZnJlZXR5cGUsDQo+
ID4gdnVsa2FuLXZhbGlkYXRpb24tbGF5ZXJzLCBwYXJ0ZWQpIG9yIG1hcmt1cCBiYW5uZXJzIChl
eHBhdCkuDQo+ID4gDQo+IA0KPiANCj4gVGhpcyBjcmVhdGVzIGFuIGFkZGl0aW9uYWwgbWFpbnRl
bmFuY2UgYnVyZGVuLiBTb21lb25lIGhhcyB0byBtYW5hZ2UgdGhpcyBsaXN0LCBhZGRpbmcgYW5k
IHJlbW92aW5nIGVudHJpZXMuDQo+IA0KPiBJJ2QgcmF0aGVyIGZpZ3VyZSBvdXQgYSB3YXkgdG8g
ZGV0ZWN0ICdiYWRseSBmb3JtZWQnIGNoYW5nZWxvZ3MgcHJvZ3JhbW1hdGljYWxseSBpbiBkZXZ0
b29sLg0KPiANCg0KT2ssIEkgd2FudGVkIHRvIGF2b2lkIGV4dHJhIGxvZ2ljIGFuZCBrZWVwIGl0
IHNpbXBsZXIuIEhvdyBvbmUgZGV0ZWN0cw0KcHJvZ3JhbW1hdGljYWxseSBiYWRseSBmb3JtZWQg
Y2hhbmdlbG9ncz8gYnV0IEkgc2VlIHlvdXIgcG9pbnQuwqANCg0KSSBqdXN0IGZvbGxvd2VkIHRo
ZSBzYW1lIHdheSB3YXMgYXMgYmxhY2tsaXN0IGlzIGRvbmUuIEl0IGlzIGFsc28gbWFudWFsbHkN
Cm1haW50YWluZWQuwqANCg0KSSBzZWUgaXQgYXMgbG93IHJpc2suIFdvcnN0IGNhc2UgdGhlIGNv
bXBvbmVudHMgaW4gdGhlIGxpc3QgbmVlZHMgZG8gbm90IGdldCB0aGUNCmNoYW5nZWxvZyBhdXRv
bWF0aWNhbGx5IGluIHRoZSBjb21taXQgbWVzc2FnZSBidXQgdGhlIGluZm9ybWF0aW9uIGlzIHN0
aWxsIGluDQp0aGUgZW1haWwsIHNvIHRoZSBzdWJtaXR0ZXIgY2FuIGFsd2F5cyBhZGRlZCBpdC4N
Cg0KVGhlbiB3ZSBjYW4gaWRlbnRpZnkgd2hpY2ggcmVjaXBlcyBuZWVkcyBtb3JlIGF0dGVudGlv
biB0byBjb3ZlciB0aGUgY29ybmVyDQpjYXNlcy4NCg0KQmVzdCByZWdhcmRzLA0KRGFuaWVsDQoN
Cj4gQWxleMKgDQoNCg==
