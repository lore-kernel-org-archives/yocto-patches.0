Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9FCCD342F
	for <webhook@archiver.kernel.org>; Tue,  5 May 2026 08:22:00 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34513.1777969317653158924
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 05 May 2026 01:21:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ericsson.com header.s=selector1 header.b=XqNEa6ZK;
 spf=pass (domain: ericsson.com, ip: 40.107.130.44, mailfrom: daniel.turull@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvwssKIHQfOSd0AXKuJTe+vS93xUPA4ZeMocdKxDslF+tHCzCrjgbjUMIvHASRLsOrrbga5z1jrdtsQnckz8nA49pe+INeQzmn189NOZsf9D4WfW5VAd4mlq33VU4733b2I1g6VnoG6/BhTBNHhyb+/5c6gp53bM3v+2iaoPMrbvRrjtXnWo+JNMVLnS7mt49h0LWFghRaJsk6fF5qEWNAEo88ArgzCJxN2T2KZ5w+f6UJcyYhOnER/VJD18rvlVQVsBeAeTi8+kD3ntAovdpoKDUS5ynWEVTeNPVi05GmrSHC9RGx5aGgyPLzm05KX/Lo3b1LrfTdtUFv0A9Qm+7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWkJcEI/HgbtBtGbm8MHa8MstrFCqITAnUcWg1PqLJM=;
 b=hzy36atFZSn74BlIMwHvhvZv6x2xZscxJA9DdBg92wlLH9ysjGQxpmFogHjWRoKmQE1l7c1siTByRsHIImFnRTdh/MDYbtdx+UGAJN9n3rH6Vgwz6t7/yW5Xg+W+AB2zOSgjqlDHDS5vD19cK285vLDL1FLn9AkPpShcH7jav1XrfcZ3tVkbg8FxOXEnKcae1n+/5alXAnQ8+7lNBIchTDSSPZMMzRHpXtWIkBjRXoIscZwCuqJbKD7dNWQ12qgySxeYTzMmOIX5VHCCWP9rXRNKjxKpbWaHavdX96wLulOMuE4YYc73bfVTYeGzYS5p7oGT4HHoSP3F3KaGM1jr/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWkJcEI/HgbtBtGbm8MHa8MstrFCqITAnUcWg1PqLJM=;
 b=XqNEa6ZKlIXQexM4l7BXdc3KCMFUySswDyqGDyULuRwtKN3uL00Zd0eO5HBaNs51mtxh+0riWWuQ9Pdnykkba8KLV9uXu3lar/Mr2MMvqejDJAPrynwQJU/66DB8rh4wiVn7NUz3W3cb8fYoEfY4+HHuwrJ6DkxG2mA/GyNkewfsURSiImp3OXP8iiVqQV/NinHq+V2Pl3jFvZdLI8IxyScGPlssYTdbmpiZD2h0KCNC7xg+rZuxbA2AOplgFJ5QoeYKot4CUgduNb2rTRpHWcZRbvsdxLvVntet8fhhXtNg5kuWiYpIwqQo0D+uo72Cv5YN+bMT1G7/8y1wDkM24g==
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com (2603:10a6:102:4af::6)
 by MIYPR07MB12230.eurprd07.prod.outlook.com (2603:10a6:290:7a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 08:21:54 +0000
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7]) by PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7%7]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 08:21:53 +0000
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
Thread-Index: AQHc25BWphQJJ8eqaEeUMPgwF9QnwLX9hFCAgAF6hDCAABX/AIAAAvQg
Date: Tue, 5 May 2026 08:21:53 +0000
Message-ID: 
 <PA3PR07MB10721F580DF2B9334EF9975E08A3E2@PA3PR07MB10721.eurprd07.prod.outlook.com>
References: <20260504063614.3831203-1-daniel.turull@ericsson.com>
 <20260504063614.3831203-5-daniel.turull@ericsson.com>
 <CANNYZj_UU10pV=pHBi_GOK5m0NsC5EzLB828k9Q08mG3K-wj=A@mail.gmail.com>
 <PA3PR07MB1072178ACD37973C762EAE17E8A3E2@PA3PR07MB10721.eurprd07.prod.outlook.com>
 <CANNYZj_ogpJFafzS=zXzg+iPZL64qURsHAugwwSvSrrB3wy03Q@mail.gmail.com>
In-Reply-To: 
 <CANNYZj_ogpJFafzS=zXzg+iPZL64qURsHAugwwSvSrrB3wy03Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR07MB10721:EE_|MIYPR07MB12230:EE_
x-ms-office365-filtering-correlation-id: f5af19a9-c0b8-4d15-1876-08deaa7f5d83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: 
 1QOEIyyjJZzDGog5CojkU0eckK/yOyjylXqE8osps0LAPWGrQcuketWTrxALLx/eKwMtn8ljfzPFgYFmha4ZT8HGm3M4zEmOSZv8TD4LKfntB6M7auOUXwChXs/s1FPzMTd9IrGS9IHZTVh6/opqZg62H8AadtsN5cdRLjw6tVB7SnVtOa/XckcDfFMsae7OIg5B8tm/DklzSlstoWTo8X38xNbHWYovwkuB1a4nlmjoHQ10D3jiv+I3KKW16Bs175Ym+yau5vD55VpDiMw2hzj8VQyh0kNIaflToUtQxGcK7/c/0U0x1cae2I1j0/NzJ/ev0Jfz+nvElKbpfhyw89V2yMMw04gI8yuHM0D7/bukr/kc/0W2sT9hUXMu2D91hUsdaWSsITuC2byYHsqw5fe/Ag0/NDEtjQFzx0I/2oa+5XhGlFZFxP6/7Rokuq3MuAfPV+sbaWTcE7/Co0ZC2tntSZ+TAPC/iq5utUsXuoPNk/ZoK7r2hEJWEOxrmZisFfSUiBzBOlA2bGK4XqY6emfYkkj/uXCJ/BhQWSbsEMQbY9kM+qWCuk2lTHqAOc4KVd928pOmWWjkpDEhcpQqU0TKZZqT30MVahJDxZEWDtUOkLb9x42VfMDfniILsHTqRZ1mMj5CMbSd7GV+6W3UYUj6stUVm4WyIi50e0X7wx+7+2/ZxCwn3vDwyD4zFRHmUaLRN18Q9XyzYzrhcgx1oPQ3RggamizMDVKFy9QHbAbxGYULOOZ8A6M5XRxzOqxS
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR07MB10721.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bjFaNHlqQnB2SU9hTS9UOGpOZTYvc1ZtL2lBRjZKYzRwd0F1ZjVkYllXalFU?=
 =?utf-8?B?MTVnTHQvR1pLbDJpL3N5R1FHbmhHTk9BRm45RlQ4Vmk4eE95Q0g5c1BkZWdq?=
 =?utf-8?B?TjI2bjNORkw3dmg4bTdxU2tTM1J3dWhGWitydDZNQU1RelpHOU4vckpoUUZp?=
 =?utf-8?B?ZEZ4Wk01M2hGLzZERE44L2ZhMTBtb2IzZkJsQ041b2hIUjJQa0JRVldrazZM?=
 =?utf-8?B?ZmY4b3hvNEtIb29zM3FFdVNGWk9CdTVXMXRHeXF3endWNVhlakY3cmg4a3Jy?=
 =?utf-8?B?WS9YNTNhcGNBQkRjKzJWR2c4aUE2SC91RkIrdVIvck8wSEJoWGliVm1XTHdR?=
 =?utf-8?B?VzJVOXBLNkF0dlg1TXdCU0wrS3hCSHlMME5ySTJYVExDZnVsUDl2aVBlaDBI?=
 =?utf-8?B?SjJBaFpEeTdiczlpZUVNcVVrUnNSUnpWU2pja1V5U283MnpPZmJoMTlyQ1hl?=
 =?utf-8?B?SmRpRmJ0bDFwOGovUkJHQk9tU2gzNHUxUGtFem9aeE5zRzJkSXZQejR6SG1z?=
 =?utf-8?B?N25BUkxxRFBxN3J2cFVocDgrMEJYRmtXWlhNOWdxYTJnRU5JOTU3bjlzR09Z?=
 =?utf-8?B?QVo5anAvK3M1NHkwR1YzT1NST1hCeHVCWEF3d3NxLzdGbWlZVzZoNEI3enpT?=
 =?utf-8?B?MUxVbHhWd1ZxeVZ6WkowSk16ZDVacExPRENmdkFOOC9JYTFKeG5mVHZEVHZp?=
 =?utf-8?B?VWUwMkRYbkZmL2YvenBLdG4xKytnb09uR2ZJZFlaU0o3TS9GdXRBbElNcVpG?=
 =?utf-8?B?bzVDaDRyZnZhaElRY0g4cHZYbTFzRjJKVmdNZVRuVnBQRDM5ZnZDekVlaVRW?=
 =?utf-8?B?ZlFYUTREYnNlTzhJeHNrRmpBQStjSGFTZmxjK1p4QUFVZ2NDTlFONmlIV1BC?=
 =?utf-8?B?VGtzLytHMDlEaVZjNkk3SWZnU1gyMUxXZzYrbGRqWnFSSGVrcElMYjZ6Y3J4?=
 =?utf-8?B?Q1B1TTNiaGxrbnNOY3p4SlpaRU9LR1paRmxNODlUUnA1L1ZaRUx1WUVTcWc5?=
 =?utf-8?B?dmFRa2J6U204Y2NlV043MnMwMHhZWmV0dXNSejhKMWNrNitodXhlUkcvVWl1?=
 =?utf-8?B?Rnk4MEQySEZnYzlNZTEwSXdtRTRmSFpSTlZBNUIwNENvK2dNcGo2ekxPNEMv?=
 =?utf-8?B?OGpFWXRlV2M4Ymp1eUpYZi9ONmpuci95ajVPUW9uV2Ira1hObHUwZlJpQ0R6?=
 =?utf-8?B?THd1QXMySEJwaUNjanFjR28xa0Y1aG1rMVQyb3FIQ2NuT3FST013UzdlNmJX?=
 =?utf-8?B?aStRNUt1Njh0TVZqaUM3VjBLSkVSa1ZqM2phRmlrVFZJbnVhQUJDenk2Rmkw?=
 =?utf-8?B?bzNuRGxwZzBrNTVjbDZyTHAzSngvbmI3Vmk5ZXZsRXp5UEJzTi9sZGU2RGQw?=
 =?utf-8?B?MGtoZ0FLUndmakd5c0ZnbGIyZUFiVWlmbzdlUFVVNnJPdy80SnlqbWYwdDJD?=
 =?utf-8?B?aTAxUWcvWTY3VkorbUJraGdWdC83Mkp0V25zVW5JYjN2OEVZS2d1Smc4L1pQ?=
 =?utf-8?B?UXJHeXR5S0hwMUFzdndmcEpXdExVSDV6Mk5iT1FqY3dQYTNoeVVSRnlZa0dD?=
 =?utf-8?B?MTkyS09teDdiL1FiUVppU2RKODVXb3BRUERVVEhmcURzSVhUL1RnVXV2SFFD?=
 =?utf-8?B?N0RNRHV1aFcrS2pFKzlnWWQxdVMxNjhLeDNJV0JNbThUV3VreGw5Y3NnTTZp?=
 =?utf-8?B?QUIreDJoUXhSaWdYL0VCZFNaRm0xTGlzR1RvQVRuaWkwU1FWOWdqajU4REMr?=
 =?utf-8?B?U0ZXbmZxQ0MzMll2NFpIeFVWMEZPMFlKYWdPTVh0RjIxUmNlZ0FCQk8wMmxj?=
 =?utf-8?B?VjdiVDV1VEZjK05XaWZOU3Rjejh3YU1FOW1za0FXaHZZN2w3UFBvMGNUbGxt?=
 =?utf-8?B?ZkR3andGYzRTdHRpSGR5ajFrZy96NWN4Zmlwcy9ZdFBrcVRVOUdFNG1YSjlG?=
 =?utf-8?B?MTM0TXdHT1poOGg2U2M2dmJmNFlOQURLRGVUWkhqNHlodTlyZSt0K1B4cElT?=
 =?utf-8?B?ZGJRRzREWGJmRmhrSTBmb2w3YW5hdXhlSERCSXdBSTF5bmtrY3o0N3V2ZDJv?=
 =?utf-8?B?UTVHcEkwQ3d2OUFrWWZ4WEMzdVpxclh5ZzdQSGpVWkZZUncxeWhTVFhTcWdY?=
 =?utf-8?B?VmZZcUFuUHo3YnZnZmRMbHZjZHlEVGFCeFMzT0JoSXhrRUhkR2FwVG9WQ296?=
 =?utf-8?B?TVBLR2E2WGRNUFhmdGtVdzJLbGF4Ukx0UUdJNVZJVWp1SXNtM1NoRitLaVRJ?=
 =?utf-8?B?aEpTMktYM2FwcTg3Skx4ZTIrM0FnaHU3RWRVcTFsM0RHQ3Z1MXVOZ3FVSXRx?=
 =?utf-8?B?ZXFzOUQ2QWRET040dTkvcENuZ3JPc2JwK05DN0NQKzBKVWkxVEo1dEFxeXRC?=
 =?utf-8?Q?NwTpPIxLYKpCZPFRECrvA2gF2N/hFhKd1w6jOSyyO6rqZ?=
x-ms-exchange-antispam-messagedata-1: lfFLZFHzk28msTUk+Vj888ES+CZIHNiIQHw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR07MB10721.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5af19a9-c0b8-4d15-1876-08deaa7f5d83
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 08:21:53.9338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7tak+FCcGIsiw9nl2Sr7ttvTYvErMyT6swdQLbAzRq1ecXQMWUifwcRmjogwDz6l5ZVNszQRPk+99Hl1V2gCmncHqWrl/Yj8CDF+jwxaLb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIYPR07MB12230
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 05 May 2026 08:22:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3913

WWVzLCBpdCB3YXMgaW50cm9kdWNlZCBieSBBSSBhbmQgSSBtaXNzZWQgdG8gY2F0Y2ggaXQuDQoN
CkkgZGlkIHJldmlldyBpdCBtYW51YWxseSBidXQgY2xlYXJseSBJIG5lZWQgdG8gYmUgbW9yZSBm
b2N1c2VkIHRvIGNhdGNoIHRoZXNlIHR5cGVzIG9mIGlzc3Vlcy4NClRoZSBsYXN0IHRoaW5nIEkg
d2FudCBpcyB0byB3YXN0ZSBtYWludGFpbmVycyB0aW1lLiBZb3UgYXJlIHZlcnkgaW1wb3J0YW50
IGZvciB0aGUgcHJvamVjdC4NCkkgYXBvbG9naXplIGZvciB0aGF0Lg0KDQpCZXN0IHJlZ2FyZHMs
DQpEYW5pZWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4YW5k
ZXIgS2FuYXZpbiA8YWxleC5rYW5hdmluQGdtYWlsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgNSBN
YXkgMjAyNiAxMDowNg0KPiBUbzogRGFuaWVsIFR1cnVsbCA8ZGFuaWVsLnR1cnVsbEBlcmljc3Nv
bi5jb20+DQo+IENjOiB5b2N0by1wYXRjaGVzQGxpc3RzLnlvY3RvcHJvamVjdC5vcmc7IHBhdWxA
cGJhcmtlci5kZXY7DQo+IHJvc3MuYnVydG9uQGFybS5jb207IHlvYW5uLmNvbmdhbEBzbWlsZS5m
cg0KPiBTdWJqZWN0OiBSZTogW0FVSF1bUEFUQ0ggdjMgNC80XSB1cGdyYWRlLWhlbHBlci5weTog
QWRkIHJlc3VtZSBvcHRpb24gdG8NCj4gc2tpcCBhbHJlYWR5IGF0dGVtcHRlZCByZWNpcGVzDQo+
IA0KPiBPbiBUdWUsIDUgTWF5IDIwMjYgYXQgMDg6NDksIERhbmllbCBUdXJ1bGwgPGRhbmllbC50
dXJ1bGxAZXJpY3Nzb24uY29tPg0KPiB3cm90ZToNCj4gPiA+ID4gKyAgICAgICAgICAgIGlmICd3
b3JrZGlyJyBpbiBnOg0KPiA+ID4gPiArICAgICAgICAgICAgICAgIGlmIGFueShnWyduYW1lJ10g
PT0gc1snbmFtZSddIGZvciBzIGluDQo+IHN1Y2NlZWRlZF9wa2dncm91cHNfY3R4KToNCj4gPiA+
DQo+ID4gPiBUaGlzIGlzIG1vcmUgY29tcGxleCB0aGFuIHRoZSBjb25kaXRpb24gaW4gdGhlIHJl
bW92ZWQgYmxvY2sgYmVsb3csDQo+ID4gPiB3aHkgbm90IHVzZSB0aGF0Og0KPiA+ID4gICAgICAg
ICAgICBpZiBnIGluIHN1Y2NlZWRlZF9wa2dncm91cHNfY3R4Og0KPiA+ID4NCj4gPiBJJ2xsIGFk
ZCB5b3VyIHN1Z2dlc3Rpb24uDQo+IA0KPiBQbGVhc2UgYmUgaG9uZXN0LiBEaWQgQUkgaW50cm9k
dWNlIHRoaXMgaW5jb25zaXN0ZW5jeT8gQ2F0Y2hpbmcgYW5kIGNvcnJlY3RpbmcNCj4gc3VjaCB0
aGluZ3MgaXMgb24gQUkgb3BlcmF0b3JzLCBub3Qgb24gcmV2aWV3ZXJzLg0KPiANCj4gQWxleA0K

