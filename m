Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A712FFF885D
	for <webhook@archiver.kernel.org>; Tue, 28 Apr 2026 10:45:03 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.2])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10470.1777373101881612038
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 Apr 2026 03:45:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ericsson.com header.s=selector1 header.b=ReHErclz;
 spf=pass (domain: ericsson.com, ip: 52.101.69.2, mailfrom: daniel.turull@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6CXkirbYxIC394BFov5ZDxd7G1+WvRpM1nmR01//TnR8r5DFsQ7pYbSNZYqBlmfo8E1m/tiafSLIZWRzCRMOqT3MD/ovUqBCkxVhWO2okLVA8+8/ZVqrBDri48wICfiPhG2yeSRG8AWkJC957ikDdWNTsszWvamagIMw+/kyb7UiDBNfe5KwSPp3UPl0wD0DIY6WC9L4jQxONTt2lmABIh4ccxQ/dFlS+HKpCQVsg4r4q5eSKPQ8i+6I8AEbwNqXvut7YFH9kARez6QqpjQNgXMoj1nHWt8gpJZFA5S+QoLMZwSqUBFFu2DJ2NYiogVDuKWv8K4ODw2eSgjGhEE5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBeJsvNmdIrMG4rygG74iwryLlCXwfDGYBI/mmmUaEE=;
 b=M9+FyCs+SqMtP0eN/kdzT8XffGf9IUxwr5l2ON3zfmhDAGiOtKEqgrVb+XeYzNgsMt33qI5apFDi3r/ifNcq/StY+yBzuVwRAuw4itkKkCtNiJCt22sOvoo0GdiV/cy14AAv/sUSbhc1us+sc3k4oL8JXnPX0OtsCdkmExQ4AMGbhqPytMJGIRmekTfnKXrknsDIf2mBLgGKZId1542yK8OjF6ZzDvh9nS3s+akhYMNAMfHYf1wWxWFTJrt4Cl8u27n026p6byuPD9uktubqyRDa9evepY4Lrn8ov0YSuV8EdfvuLLbR+IAi5LtEEMRL8L8oh4Z4n+wdr+N3qsYD4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBeJsvNmdIrMG4rygG74iwryLlCXwfDGYBI/mmmUaEE=;
 b=ReHErclzHTNjXfZ57QId5ey0LZJrr7kaXG0mCu+FIF8WV8YVLBd6ddXoUY913zvOc+36jmM6RbwiwJ+b50kt5ter4h3PeXIspgiI+qZ3BUz4J568fQEPYRRZH7btMFq0qURM5PUXa5aPcl2ez+VD02Y1pSFwTAfXb2MMT9GnvNRgjvRj4jlVP7MUKKXmUxBnDjz5ylpQ9hmBUBvHLzHmXz6RWg+VGnRzfVnj4+MzP57TcXy2nnTG3KceRdgEj5H1ayb0gxa1ZRubQ29agOlSUZHaFQsJEqbF0WhYR6GbQmPizltCUkjsGx56th2ni3X7DOfJ0pZRr+IuGVcddkvw3g==
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com (2603:10a6:102:4af::6)
 by DU2PR07MB8151.eurprd07.prod.outlook.com (2603:10a6:10:274::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 10:44:57 +0000
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7]) by PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7%7]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 10:44:57 +0000
From: Daniel Turull <daniel.turull@ericsson.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>, "paul@pbarker.dev"
	<paul@pbarker.dev>, "ross.burton@arm.com" <ross.burton@arm.com>,
	"yoann.congal@smile.fr" <yoann.congal@smile.fr>
Subject: RE: [yocto-patches] [AUH][PATCH v2 4/9] upgrade-helper.py: add
 changelog flag
Thread-Topic: [yocto-patches] [AUH][PATCH v2 4/9] upgrade-helper.py: add
 changelog flag
Thread-Index: AQHc09/6hWRQSUvlQ0O3bFSy/GqsGbXyxvTjgAAn+OCAAWDjgIAAAEVQ
Date: Tue, 28 Apr 2026 10:44:57 +0000
Message-ID: 
 <PA3PR07MB10721FAD7013426B6607441268A372@PA3PR07MB10721.eurprd07.prod.outlook.com>
References: <20260424114603.2444938-1-daniel.turull@ericsson.com>
 <20260424114603.2444938-5-daniel.turull@ericsson.com>
 <18AA2E7887D04BD3.1773850@lists.yoctoproject.org>
 <CANNYZj-1u7A9cjE6Uqyah0oaVWKBxcTe0-VLtcSzOwj=JwEV4w@mail.gmail.com>
 <PA3PR07MB10721A91191F9AD24E138AB028A362@PA3PR07MB10721.eurprd07.prod.outlook.com>
 <CANNYZj9-GVM=o4b4XsF_-=g=GdyhV6qe+PZe7bKofG=HZRTgmw@mail.gmail.com>
In-Reply-To: 
 <CANNYZj9-GVM=o4b4XsF_-=g=GdyhV6qe+PZe7bKofG=HZRTgmw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR07MB10721:EE_|DU2PR07MB8151:EE_
x-ms-office365-filtering-correlation-id: 5647a139-870e-41e5-f8e7-08dea51330eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 
 kuVM4mGYT7wadYtfvG+kfnPeWx62wW8l926v/dZL7HC0wIdudscISxOX0EQQjT/TzNzp0LpkyxH+86NOph3o6XpharGVFlDGfyvPykrXLrD6upBmH0BPrDkJJ/VhYr6bO/zrqnC+gZZfCYFX2N3GHsEx4mOtLnkw7WOUJhoX/+D1XqeGbzJgJZV84Bv78G5xm/hCKxyc8ksnZ2iOziYDtjqOgjR7UR8a1cg+3nihtqHea2WnpxzW8EYXnxt7AW6xhJSTfEk2y1CbTm/sIO+XUOXI7BSDR/TGtxkEVgg2taew3vOymTM9ws99xY64zdnYF8aSUoryslujQ25SG3Ym8gLHQnUSpgYGqSgH25rvRZwOsFunA1kfozWfHcJAQLx3VE6Uw1LwiPVVHBVn2KImJEV++UtIn3OAACTgHX4qboz5xtBxWSX7IY8C7xe4IbFKpOLtm9pjnMHgUNxkNGCtX+ILLVl51kCSCQVCXUlkOqd5QRN2KanyRqAcxzRnXRb+NI81DYb4pSzV91RejOiT1Gvxd56tqsHnbA6s+CLBICH0qDWG7Zr9mM9T476PQBqRr02wLE17MAZZyGHlUh9R9Ni6R+voLxCWa06ih35sg3JWye+rYkz5+Dgs1uvXg187y785L3qQshwHiMH8LN87h4q+SIfv1t9v0RYkndd0X5HWvw9ZDnkwhyfE10MFRpi4nYoxzIldFJ/ISTOmgoYSJzj1giijSMDFxxf7Sv9h5qDBb3Flzf2WsghxsWJ4lq6xhdmj4XGlVQG2g2jStwlwMwBLFTtX8aWtdg2yrWxBGRA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR07MB10721.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?V2MzYnVmSTAvdXd6M2NyODZweEd3aWRNSzQxT1NNc3I4UDJnMEp5dHJhcE5K?=
 =?utf-8?B?QzMwV1JqTzFueUVpeEttMVF6U01EVDBTZmVLdldxWWt5cGQ1OXhoMDErdjRR?=
 =?utf-8?B?YmlJNVFlR25tUk05c0Z1TUlZdk90b3ZFcWJqZStVSkEzenBLeEZwQmxaeUYw?=
 =?utf-8?B?VElmam1VVmd3WGZPeXlkWGZZL0YwQjdmc2lrMXpRSzhkMHE4c2MyamJvQ2Zm?=
 =?utf-8?B?R0NSVDR5QUkrYUJiQmZlWFNKVUs0ZVVJNC9rV3JTZmhoVzhlZlNYWXkwVkZr?=
 =?utf-8?B?bWJxVTZSWDdXZjlFQnZkYmNHZ1JRWHlLVjZpL0hKblVadzNVa2x5NUs4ZnEy?=
 =?utf-8?B?MXZTRHVJR25nb0V2ZmtDUVFCVVBna0dDRjVJTkxrbnNXalZKRDAvR2g4bCs2?=
 =?utf-8?B?eVJOUDJhWmtnSjh5ZUY5RlNMc1NlMUFTRmdwQmJHcWZZKzM4d3R2eUtYRjNx?=
 =?utf-8?B?NkVZV2VjNjJObnFBRHdrZVNLUEd0Q2JnN2V5WW1oaEV1Si9RL0N5OURnSXhP?=
 =?utf-8?B?TmZZVDFRYUFOSWUvMUQ5b1k5ZmNMODRWOWdKTDI1eEswREhqUnB3Q1pSRmtG?=
 =?utf-8?B?c21WNkJTclNPQkhGZnhDcEZScFlZNnBYZXVnM2tyZU1zbUQzSmJSWjRDZFB4?=
 =?utf-8?B?amNwOUg2d1Rhc3V0anFWYS8ySkc3YW5oV3ZqbmgxOG5jY05NTlMrdmJMZ0Z1?=
 =?utf-8?B?VUNvQlU0MTRyNG9KUEE0amJrdEladGI0NUpJVW54eTJaVEJEcjUrNUhYdUFh?=
 =?utf-8?B?MVl3ZHFHT1BjYWh1bUZ5ZDMrMGxlS1YrdzY5akxjWVVtcllnZytsR1pmWFNP?=
 =?utf-8?B?OTIyNFBqcnV1VzBuUFg0V1g0aldyM015d1A5NU5hcDM3NzZRbjdpSFAyc3hG?=
 =?utf-8?B?SkFCNEZEUVpMQU8rWUh4ejVRZ0k0dmVXeFAyekpxaXF6dFcybkhVTGo1ZGxs?=
 =?utf-8?B?M2NyTnEyakltK0JmMTNJRUxrYldSY3RKcVdYZDUzTUdRNUlNbndud0k5ZGxm?=
 =?utf-8?B?dVpQcGlsSS9waXRheEQ5Wm1UZ1NzeEJMVUFNQXFObWZ0RGhGdG1UNzluUTdh?=
 =?utf-8?B?eTIrdVkyY1l2VnZ6Ykp5ZmpJTjI4cVBrN0kvVFk5Q2liMWRRVjU0b0Q5RXg0?=
 =?utf-8?B?dFgxaE1yS25lcVhha3FuMi9SZm5VMU1vOHJCK0xoZ3hjcE1MczNSWERRL3NH?=
 =?utf-8?B?TFJ5M01aRiswVVFaN0Q1cVZxWHlhdVhzalVaNWhjOXdPZ3A5ZHo2NEttYW9S?=
 =?utf-8?B?TncvZE1odmtYcEM3VUh1V3RiV0VjYVdvVEduV1pZMFZPNTR6d1pnYmlzTEpV?=
 =?utf-8?B?dHQ4UmxaaTZuRnhSclk4emUyYlY4RjI4bW94eis4anNTeTE4ZCtvREZLMWI4?=
 =?utf-8?B?Qm9zS2s0Wmw2TFgwbjh2RTB2L013T3dtOStqNVZra2d6ZG51alArNjZQNkhl?=
 =?utf-8?B?OUtWSnRXVHRDbjNEaHdjVFN3eHg4eEgwK2x2OStjR2ZkNUxLcDVENnpZY2VH?=
 =?utf-8?B?OGhLQ2tLa0dLcWIxZGN1ei80Q0pKclorTXZWQ2swaDUyOUtQSC9uRXcrRDla?=
 =?utf-8?B?Y1dCc2JkV1dqR1hYMnB0eDRhcDA0Mzhpd3J2TjZYOHRMYVFqMGRQYlhsa0tz?=
 =?utf-8?B?UzhjOFlScUNKVS9tazZYbWdQcHpqMFN2UVIySy9iampRY1JaQk9zbVdmdkpF?=
 =?utf-8?B?T0twVmtjQ1Q0NHFJR0NEWWFBRm9yRDZTNjRpWVdCYUJ6YUJTT01HazE0UVFr?=
 =?utf-8?B?OE13N3N0a1lNd0RXeHFSTTJQQ0VLZGNnK2k2OXRoRjRiZkxjTk82R2dDVEZt?=
 =?utf-8?B?QTNNMFJwTFNQN1gxRUNXYWdtWm9BeDM5ZGdZVGtKVkJiSFdHRnBzZ0NieCsy?=
 =?utf-8?B?WlFLN1U2MWVEZmZNV0NpUEowalBrQTlydjZIZytrdWZLYzRQR2Vna2pGejNO?=
 =?utf-8?B?NG1rdWFwdEF3MW9BMWxHVGtoRTBSelNUNjh3RUZmKytnbi9uWkp2L1NuS01D?=
 =?utf-8?B?SGM4TUpZcnZtcHB4WE5xeEhhV2gyVDh0eURDblIvcHQ4Z05rMmZIV0JDdlpC?=
 =?utf-8?B?SUN1eDUvOVRKSmJaOFBMcDlPckpGMVlvL0kwTFNuLzJVM1hBSDc3WkdLVTgr?=
 =?utf-8?B?aWUyZjVpdm85ZE1NYU5ReGh1QkNIMjR4Vm0vQ1F4Z05UQ0IySDg0RnV5OUYr?=
 =?utf-8?B?N01sR3lENFVtZmtMcld5dFNGcFNFdGNoOXYwL01rWDFlQjRLTWtOWXAwVG9H?=
 =?utf-8?B?QjVHcTA0eTA5RkJhT2t1T1JiUWwxb0ZwRlpMTy80U3lnR2VnV3IzeWJmWGda?=
 =?utf-8?B?RDVoMTIzYkUwQlpEb2pneXI4Y2xTZEsxOTY1OG1LTXNwQTFTRGlPZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR07MB10721.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5647a139-870e-41e5-f8e7-08dea51330eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 10:44:57.6747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uj+Ufuul8OSSIUHklfYpyVkv9lu+lmoPqRg41kRteZk7vyaNA/fl+MMqc++NFEOxKmNyBWSiZ7fTBGWiWb0AzC7QVKZglc2T0Z31nXDNs2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB8151
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Apr 2026 10:45:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3867

T2ssIEknbGwgd29yayB0byBoYXZlIHNvbWV0aGluZyBmb3Igb2UtY29yZSBhbmQgZHJvcCB0aGUg
Y2hhbmdlbG9nIHBhdGNoIGZyb20gdGhlIHNlcmllcw0KDQpEYW5pZWwNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4YW5kZXIgS2FuYXZpbiA8YWxleC5rYW5hdmlu
QGdtYWlsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgMjggQXByaWwgMjAyNiAxMjo0Mw0KPiBUbzog
RGFuaWVsIFR1cnVsbCA8ZGFuaWVsLnR1cnVsbEBlcmljc3Nvbi5jb20+DQo+IENjOiB5b2N0by1w
YXRjaGVzQGxpc3RzLnlvY3RvcHJvamVjdC5vcmc7IHBhdWxAcGJhcmtlci5kZXY7DQo+IHJvc3Mu
YnVydG9uQGFybS5jb207IHlvYW5uLmNvbmdhbEBzbWlsZS5mcg0KPiBTdWJqZWN0OiBSZTogW3lv
Y3RvLXBhdGNoZXNdIFtBVUhdW1BBVENIIHYyIDQvOV0gdXBncmFkZS1oZWxwZXIucHk6IGFkZA0K
PiBjaGFuZ2Vsb2cgZmxhZw0KPiANCj4gT24gTW9uLCAyNyBBcHIgMjAyNiBhdCAxNTo1NiwgRGFu
aWVsIFR1cnVsbCA8ZGFuaWVsLnR1cnVsbEBlcmljc3Nvbi5jb20+IHdyb3RlOg0KPiA+IEZvciBu
b3csIGtlZXBpbmcgaXQgaW4gQVVIIGxldHMgdXMgaXRlcmF0ZSBvbiB0aGUgZXh0cmFjdGlvbiBs
b2dpYw0KPiA+IHdpdGhvdXQgcmVxdWlyaW5nIG9lLWNvcmUgY2hhbmdlcy4gSWYgeW91IHByZWZl
ciB0aGUgZGV2dG9vbCBwYXRoLCB3ZQ0KPiA+IGNhbiBwdXQgdGhlIGNoYW5nZWxvZyBwYXRoIG9u
IGhvbGQNCj4gDQo+IEkgYWJzb2x1dGVseSBkbywgeWVzLiBEZXZ0b29sIGhhbmRsZXMgaW5kaXZp
ZHVhbCByZWNpcGUgdXBncmFkZXMsIGFuZCBleHRyYWN0aW5nDQo+IGNoYW5nZWxvZ3MgaXMgYSBw
YXJ0IG9mIHRoYXQuIEl0IGFsc28gaGFzIGFjdHVhbCB0ZXN0cywgd2hpY2ggbWFzc2l2ZWx5IGhl
bHBzIHdpdGgNCj4gaGF2aW5nIGNvbmZpZGVuY2UgaW4gYWRkaW5nIGNvbXBsZXgsIGVhc2lseSBi
cmVha2FibGUgY29kZS4NCj4gDQo+IFdlIHNob3VsZG4ndCBiZSBhZGRpbmcgZmVhdHVyZXMgdG8g
QVVIIGp1c3QgdG8gd29yayBhcm91bmQgb2UtY29yZQ0KPiBtYWludGVuYW5jZSBwb2xpY2llcy4g
SXQgbmVlZHMgdG8gcmVtYWluIHNob3J0IGFuZCBzaW1wbGUuDQo+IA0KPiBBbGV4DQo=

