Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315EEFF885E
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 13:34:46 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.9])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.45419.1777296883685280726
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Apr 2026 06:34:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ericsson.com header.s=selector1 header.b=XRYk5In/;
 spf=pass (domain: ericsson.com, ip: 52.101.70.9, mailfrom: daniel.turull@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBhJc69HLe9AyPzHFItXgZH8L9fkqWcDFH71Dkv4RuYkWC8rwltsCYi9OXIcy8IhdDPX7CLi47/v4zzb9haFDa+K0ML5HvZd/dTj6SrMjOar1gKDuiZVelQkfOKcbrNlXkn2lpbiDctjJz3M7+JgF8Ckr1iCLFGmrmuVd/O9N3257F0bmmZpOagVIcAamDeNDUl046JZ9DRyosjgeVOjRI0zqvUfUeZ0NBvxSId2j8YoRy8eRoxMAU8bgrsBGDAxkem0I7jA9X1bU9gKDXmJuWLdIvVgQeMuwZA7LW5LLddgt6s4/UTBi3YlUC3fMynPnE66rjTFoOgvmYEnMMw26g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDOr9CCOra+HOT1IDm0yTzux/DL+vqhyZd/bqrZZdI8=;
 b=YUzQPy0FGbDkDxcnANQkBkiHKjV7cS/Sascns0/2HS3iDlv6vDaxW8zd3RU/ratdo8wJlGGJj53HjjTioZaCo/b0W3qzz9y/zsD2lP+3B+1I6ErcaeJ3jfqFxlqNxq9+lLw9G6PYBly89JsX5UK87HLffevgFZGpUIr/pnspYpW8r+JDYctpsg3j/XkgtG7TjHv6i+GpKWW6+YUuoPHHYrO7EztGHxRbUw0Im+dEdzuE6F51cDXXEMKwAIwobu9wnbY3J7Th2/UQz0hfONuBGs9AP4LqwYeidxiM0y3rvvnOXmtxJhf++e1IqiFj83USzgENn97vGEuJHi4KKVG9zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDOr9CCOra+HOT1IDm0yTzux/DL+vqhyZd/bqrZZdI8=;
 b=XRYk5In/ibADMaBTpQa1T7MhmtVzvS/s/w1/+In3+ato5CuMjUk2qOIw/yYSfeUBlV1qw1xl6+h7UM5hF6C0Izt1mY4OFPfrbUdL6iJQ5YapWcydOgUaM6uWQ/IhuZe1WQjX3wUzZg7U2fIo9/Hv+DpNwRxC8cWbtPht+/O3LwBqTUFcVaUv7iynAwDVhYOlmhNaAk8ix0Nb3TkQ/rTZz53OdXms61OiZTq0dRBtkRRsaslgEv/InDoE20iVuERVBbXvrPlZpV2V3gQu8mHFDnj+c40LjuuhlOmSwTio2dBGvPVwquPbVFCEO9CVP1JkwFqE5HWGsPpo/o1RaKDXaQ==
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com (2603:10a6:102:4af::6)
 by AM7PR07MB6932.eurprd07.prod.outlook.com (2603:10a6:20b:1ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 13:34:39 +0000
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7]) by PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7%7]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 13:34:39 +0000
From: Daniel Turull <daniel.turull@ericsson.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>, "paul@pbarker.dev"
	<paul@pbarker.dev>, "ross.burton@arm.com" <ross.burton@arm.com>,
	"yoann.congal@smile.fr" <yoann.congal@smile.fr>
Subject: RE: [AUH][PATCH v2 1/9] upgrade-helper.py: Add compatibility with
 Yocto scarthgap
Thread-Topic: [AUH][PATCH v2 1/9] upgrade-helper.py: Add compatibility with
 Yocto scarthgap
Thread-Index: AQHc09/5mcVAcVC/vkyBGpJVvnGM4bXywrSAgAAoicA=
Date: Mon, 27 Apr 2026 13:34:39 +0000
Message-ID: 
 <PA3PR07MB1072177B916F8ECCD039083448A362@PA3PR07MB10721.eurprd07.prod.outlook.com>
References: <20260424114603.2444938-1-daniel.turull@ericsson.com>
 <20260424114603.2444938-2-daniel.turull@ericsson.com>
 <CANNYZj9GSyEOPhJW7vV9kXo5atKDquFE-zXdiKNQAEDMa686fA@mail.gmail.com>
In-Reply-To: 
 <CANNYZj9GSyEOPhJW7vV9kXo5atKDquFE-zXdiKNQAEDMa686fA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR07MB10721:EE_|AM7PR07MB6932:EE_
x-ms-office365-filtering-correlation-id: 40045346-61f0-4821-a759-08dea461bb4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 
 19l9EaBUt+1J0U+/p9rHHRCNVic9yZPtIHLjAO+wQcmXPs9GWTCRU6ooT9Vc9Ljvrga+ciq8ifbjfhIielSsb5FXpoPpg6tbeaIPSRP0Y8p9dSdvD5QJRp4ZUVpsLIoTtmIRwhkJQEC8u9GHSPCpaJnlS+i4EUNb9NF1Xk2FgGMCOTq2WQtH2Xv217tGrv7X2c7yPe+h5bWTcOHTr66pp1ZMEJoEdlVrxzK/lHbbWRIL2tVlC9j7jRbJoKOwYWoo7JROvx2TMBNHRuNXExle6gNdKmpOyRn9jku0Bo3euuscCnLOZd7SRCLvUeM413g9XK5L8frmAQZSiGH0iS9QRbuw04p58xOZmUN2wERNCzRV7bdyBINrlynt/bUUDsgMlh6eVYLgS7fzBKpAkJbd4L57SUgha76a+FxsVIcbFnmT1UjogY8ZqtXicjR0SIj/3r3wtdEmQ2bHlyM/ty8SzyAUttZip0ydXzBMoFruYTNvs17ub7ZW9OifosNtXYnadhGIKu+asJi81d/4PFeXY/eWQmWQ7qgineBIGyUoSbhTfWYrCiTj9+TYsKz+bpweV0iwlce90bw28NH0sPDhdNnsYn1onHXlgPWT/FtCeDP+524MXKged4Tpsji3KgniuJ8fM4DlmqKBMl/VdLiWHqlsodNKUSEQA8ssNbav7De6M3+4D7htbzRIxVUaO8b5GkwdIQQsH0WXDqqahXUqrwNM2erR9FZoW7roa/TH/oW/rk93JukA4Xj8PH4LYwUqNIzgVv610+tM8QWP5y8NO6oA6GOhWPZd+ufklwh5ZOk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR07MB10721.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Q1g2MHovemQwVTczUmlQMVYyTnl5NDcrcDFnaWNWY0lGM3pWNUdMRzVJVUpj?=
 =?utf-8?B?d1g0b0lzM0ZsYWVBQlEzeWhHTERyS1NodVBhN3FLckZ1TGlPcGFPdlNoZ2F5?=
 =?utf-8?B?QmZGQU53M0E0dEdTL1lpRkNJTERwUDVHNW5GSWpWRGdrRTBkNWVUY1FFeUE2?=
 =?utf-8?B?REFNZm02RFdtZ0l2Wm9aSGVicHc2WlRNZ2dEN2hYbS9TN0ZrMEo0SUFjNXJy?=
 =?utf-8?B?L2kyZDVKS211YkdrK3NESElRWXdvRjBzTjJ5cEZkeTNDenZMTlJqRExOemEr?=
 =?utf-8?B?eDZrbHhKRllHZkJINExOZ2s5SHByU0ZjS3BFdldtakJsVVBycjJrQkhtaER2?=
 =?utf-8?B?ZlU3QzkwdE1CcldNNlRBeS8vZ1M2enRRM0ZIT3AvajRBb3pSTkxkQnp1Uk5x?=
 =?utf-8?B?QnA4Q2lCaFBHN1V3d3dQay90aFp1Tlg2NmtrajdhR2dKRkFCMkFkWDA2MnhO?=
 =?utf-8?B?Q2F5Zit5SG1XNEVhRTNJRyttS01CRDJXbVM2UlNqcW55N3p1STA0ZmU4VUdN?=
 =?utf-8?B?blZTRCtLMDlCNDNBdVVXZVZ0WWpqTjMzZ2NCL3BVbnFPNGptellnb1dZUWY2?=
 =?utf-8?B?VUZ1cldRSEh4Qm5wYVpZWlh1UTZ1cW5hMFFEZjIvZk1yQWU3dW9mMVRxS1BP?=
 =?utf-8?B?elQrSWNqdlJrMXk5UnJMRU9wWWVQQ2pwSHJGWW5rOHZIZ3NraW1qdTlqZCtF?=
 =?utf-8?B?ZG9Zb1poNGFIS0Z4UTV4elNPSEZSNUtLQkprMERocUlNQTlvbkdiQVpGVGlr?=
 =?utf-8?B?WkZqTWpCazhKcE1tSWhKUG1MNDZsbFZOQVpRaElRSjVRQ1E2TmRSTDR1Um1h?=
 =?utf-8?B?NDRnaC9UMk4zL29ENWg3VG9vYklrSEpuTlpmMWtMRElzQUc1QXBXVGxkdnBr?=
 =?utf-8?B?Z3FZNDd1ZUNhRnE3cndrRHZNYVNwRWQrU0dxS1kvVm5NNlp2Mnd5MC8xMVBP?=
 =?utf-8?B?ankrdDFDV0VxSUZadmZCMTA1N0V4MXVWZXZ6VWZSbTQwVStkalQ5N3g4eWtm?=
 =?utf-8?B?TDJmeGprS2lZaENCMnFEb2RuM2ZDcE9iOHdpcXVYb2ovVDM0dE5GK2R4ZlVY?=
 =?utf-8?B?SE9DajV5TThPMWwyMTFNOEFiOXhGdXVUVXdiNlJBdC81M2FMUmhETEZiTHI0?=
 =?utf-8?B?TlFGWmJ6ZUp1WjJoWGZQcTY3Q1pOTGNkRlZkZTNCWDhiY2hmbUZyc2tCdGc5?=
 =?utf-8?B?RlFpUjVJNTk0OFFkQWZjNnVBaXYvNXd2U3c3a1VpTFQyWW1lLy84bjhZSWFF?=
 =?utf-8?B?L24rUGZ4cWZLdHVldld1Qms5cFZOVXM1ZGhaZk1iSjlTRWxXeGRCaVovTFdW?=
 =?utf-8?B?YytjRzUvUlNzWlQ1SzMrOFdwaUlPcHNqSW84eFk5SUlWSUJkeFF5NzhReFBr?=
 =?utf-8?B?ZVc1T0tRSVF4eGRCTEJuQWVQR1kydVFLTk5iaEgrSlpFUzZiTzU2UVVwZVdW?=
 =?utf-8?B?b2R2US9yM2JndzMvellEcWtCam5pTmRJL1hwaTM3M3ptT1paakRpUU9XRFgw?=
 =?utf-8?B?QWYya1E3RXRISy9WZmdKQVREZGZSUGZuZW5RNjJzOWR1bjNCVW1GR0pFM21m?=
 =?utf-8?B?Qy9QUnJKc3dvNUZNelJ1NEFqVUxIRDhxUkVGeHo3M2VqSzl6Nlc1dXQ5TGdS?=
 =?utf-8?B?T1dJK0tWSnhVZndlbVg3aXFMV0l6NjV3RnZZOEN6NHFDZVl6UytyY09TaDFq?=
 =?utf-8?B?Zllid3E5ekNpQUMxcENUZGlKeENMMklXL3BYbEZYQkptbWtRTWZUU0dxK09G?=
 =?utf-8?B?cHdxZVE2RzlmWFdxb3dQeGgrVzRKVm1hOVYyUlNPSnJoTFVDTHREMkM1K25B?=
 =?utf-8?B?SElIUzFTa09oWHIwM21oc053Y0JpTjdwUzcybkEzTk9lRUlaaWhxTnU0bVNU?=
 =?utf-8?B?SHhTczBxc0liSS9yZFc2QnZCYzdVSnBmVjJvbFJ1VVJXY3pYaG1UdjdFQ2Vz?=
 =?utf-8?B?R1R0cy9DR1YxUmo0QzhyYVZVQnhrWXI0NHk0Kzg2L29jajE0L3FkKzN5akJu?=
 =?utf-8?B?eGd4WW94QWpDa0RxOVVlM1JlS1ZMZHFLVDBCSjAwMjVrdzdqaE5wU2JqeTVT?=
 =?utf-8?B?OVc0VHdjZEd2QUxhQ0IrS0laSmRSQ2V2T1FjOThUbnZoQkRJMCtJY0tqNUcz?=
 =?utf-8?B?cXBoczR5M3lSeXRBeml2RTllVklXVWlFMFhZWmVJcjVDdjh6Nm82ampxbVkv?=
 =?utf-8?B?ZWhNaTJzUElFdDdTWkVnUHNVUEx2U3V1YTlIOU1ZL0hpNVhTcTNmQU5LaEhw?=
 =?utf-8?B?aWI3TGxoMlZiZk1UU2ZaVjQxdlJONVVMOUJHNVQ5REJiNFNSU0R2SFJCbk5z?=
 =?utf-8?B?aURJbmZWaDVMUGJMU0pSQUd6YlNoekwzUTh5ZmZFa1h5U2l6aEswZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR07MB10721.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40045346-61f0-4821-a759-08dea461bb4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 13:34:39.4320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ijIqza/lEHsBdDtnPnU5sd49Ue09ZPkeOAL0Dm/+stLwnykYQ8vpb06a7KsVwe6b2db+YvhKiI+nIJwbjjWd56lLwtzE4LPc7zJjK330A3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6932
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 13:34:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3847

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFsZXhhbmRlciBLYW5hdmlu
IDxhbGV4LmthbmF2aW5AZ21haWwuY29tPg0KPiBTZW50OiBNb25kYXksIDI3IEFwcmlsIDIwMjYg
MTM6MDINCj4gVG86IERhbmllbCBUdXJ1bGwgPGRhbmllbC50dXJ1bGxAZXJpY3Nzb24uY29tPg0K
PiBDYzogeW9jdG8tcGF0Y2hlc0BsaXN0cy55b2N0b3Byb2plY3Qub3JnOyBwYXVsQHBiYXJrZXIu
ZGV2Ow0KPiByb3NzLmJ1cnRvbkBhcm0uY29tOyB5b2Fubi5jb25nYWxAc21pbGUuZnINCj4gU3Vi
amVjdDogUmU6IFtBVUhdW1BBVENIIHYyIDEvOV0gdXBncmFkZS1oZWxwZXIucHk6IEFkZCBjb21w
YXRpYmlsaXR5IHdpdGgNCj4gWW9jdG8gc2NhcnRoZ2FwDQo+IA0KPiBPbiBGcmksIDI0IEFwciAy
MDI2IGF0IDEzOjQ2LCA8ZGFuaWVsLnR1cnVsbEBlcmljc3Nvbi5jb20+IHdyb3RlOg0KPiA+IC0g
ICAgICAgIHBrZ19jdHhbJ3JlY2lwZV9kaXInXSA9IG9zLnBhdGguZGlybmFtZShwa2dfY3R4Wydl
bnYnXVsnRklMRSddKQ0KPiA+ICsgICAgICAgIHBrZ19jdHhbJ3JlY2lwZV9kaXInXSA9DQo+ID4g
KyBvcy5wYXRoLnJlYWxwYXRoKG9zLnBhdGguZGlybmFtZShwa2dfY3R4WydlbnYnXVsnRklMRSdd
KSkNCj4gDQo+IFRoaXMgbmVlZHMgdG8gYmUgZnVydGhlciBleHBsYWluZWQuDQoNCkluIG91ciBs
YXlvdXQsIG1ldGEgaXMgYSBzeW1saW5rIChtZXRhIC0+IG9wZW5lbWJlZGRlZC1jb3JlL21ldGEp
LCBzbyBwa2dfY3R4WydlbnYnXVsnRklMRSddIHJldHVybnMgYSBwYXRoIHRocm91Z2ggdGhlIHN5
bWxpbmsuIExhdGVyLCBnaXQgYWRkIG9uIHRoYXQgcGF0aCBmYWlscyBiZWNhdXNlIHRoZSBnaXQg
cmVwbyBpcyBhdCB0aGUgcmVzb2x2ZWQgb3BlbmVtYmVkZGVkLWNvcmUvIHBhdGguIEknbGwgZXhw
YW5kIHRoZSBjb21taXQgbWVzc2FnZSB0byBleHBsYWluIHRoaXMuDQo+IA0KPiA+IC0gICAgICAg
IGJiLnByb2Nlc3MucnVuKCJiaXRiYWtlLWNvbmZpZy1idWlsZCBlbmFibGUtZnJhZ21lbnQNCj4g
bWFjaGluZS97fSIuZm9ybWF0KG1hY2hpbmUpKQ0KPiA+IC0gICAgICAgIHJldHVybiBzZWxmLl9j
bWQocmVjaXBlLCBlbnZfdmFyPWVudikNCj4gPiArICAgICAgICB0cnk6DQo+ID4gKyAgICAgICAg
ICAgIGJiLnByb2Nlc3MucnVuKCJiaXRiYWtlLWNvbmZpZy1idWlsZCBlbmFibGUtZnJhZ21lbnQN
Cj4gbWFjaGluZS97fSIuZm9ybWF0KG1hY2hpbmUpKQ0KPiA+ICsgICAgICAgIGV4Y2VwdCBiYi5w
cm9jZXNzLkV4ZWN1dGlvbkVycm9yOg0KPiA+ICsgICAgICAgICAgICAjIGJpdGJha2UtY29uZmln
LWJ1aWxkIG5vdCBhdmFpbGFibGUgKGUuZy4gc2NhcnRoZ2FwKSwgdXNlIE1BQ0hJTkUNCj4gZW52
IHZhcg0KPiA+ICsgICAgICAgICAgICBlbnYgPSAiTUFDSElORT17fSB7fSIuZm9ybWF0KG1hY2hp
bmUsIGVudikuc3RyaXAoKQ0KPiA+ICsgICAgICAgIHJldHVybiBzZWxmLl9jbWQocmVjaXBlLCBl
bnZfdmFyPWVudiBpZiBlbnYgZWxzZSBOb25lKQ0KPiANCj4gVGhlIGNvbmRpdGlvbiBuZWVkcyB0
byBiZSAnYml0YmFrZS1jb25maWctYnVpbGQgZG9lc24ndCBleGlzdCcsIG5vdCB0aGF0IGl0DQo+
IGZhaWxlZCB0byBleGVjdXRlIChlLmcuIHJldHVybmVkIGEgbm9uLXplcm8pLg0KDQpJJ2xsIGNo
YW5nZSBpdCB0byBjaGVjayBzaHV0aWwud2hpY2goJ2JpdGJha2UtY29uZmlnLWJ1aWxkJykgaW5z
dGVhZCBvZiBjYXRjaGluZyBFeGVjdXRpb25FcnJvci4NCg0KPiANCj4gPiAgICAgICAgICAgICAg
Zm9yIGdyb3VwIGluIHBrZ2dyb3VwczoNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgICAjIFNj
YXJ0aGdhcCByZXR1cm5zIGZsYXQgdHVwbGVzOyBub3JtYWxpemUgdG8gbGlzdC1vZi1kaWN0cw0K
PiA+ICsgICAgICAgICAgICAgICAgIyBzbyB0aGUgZXhpc3RpbmcgbG9vcCBoYW5kbGVzIGJvdGgg
Zm9ybWF0cy4NCj4gPiArICAgICAgICAgICAgICAgIGlmIG5vdCBpc2luc3RhbmNlKGdyb3VwLCAo
bGlzdCwgdHVwbGUpKSBvciBub3QgZ3JvdXAgb3Igbm90DQo+IGlzaW5zdGFuY2UoZ3JvdXBbMF0s
IGRpY3QpOg0KPiA+ICsgICAgICAgICAgICAgICAgICAgIHBuLCBzdGF0dXMsIGN1cl92ZXIsIG5l
eHRfdmVyLCBtYWludGFpbmVyLCByZXZpc2lvbiwNCj4gbm9fdXBncmFkZV9yZWFzb24gPSBncm91
cA0KPiA+ICsgICAgICAgICAgICAgICAgICAgIGdyb3VwID0gW3sncG4nOiBwbiwgJ3N0YXR1cyc6
IHN0YXR1cywgJ2N1cl92ZXInOiBjdXJfdmVyLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAnbmV4dF92ZXInOiBuZXh0X3ZlciwgJ21haW50YWluZXInOiBtYWludGFpbmVyLA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAncmV2aXNpb24nOiByZXZpc2lvbiwN
Cj4gPiArICdub191cGdyYWRlX3JlYXNvbic6IG5vX3VwZ3JhZGVfcmVhc29ufV0NCj4gDQo+IENh
biB0aGUgY29uZGl0aW9uIGJlIGludmVydGVkLCBlLmcuIGJlIGNoZWNrZWQgZm9yIHRoZSAnb2xk
JyBmb3JtYXQ/DQo+IEknbSBub3Qgc3VyZSBJIHVuZGVyc3RhbmQgd2h5ICdvbGQnIGZvcm1hdCBp
cyBkZXRlcm1pbmVkIGJ5IGFueSBvZiB0aHJlZQ0KPiBkaWZmZXJlbnQgY29uZGl0aW9ucyBiZWlu
ZyB0cnVlLCBlc3BlY2lhbGx5ICdub3QgZ3JvdXAnIGxvb2tzIGluY29ycmVjdC4NCg0KU3VyZSwg
U2NhcnRoZ2FwJ3MgX2dldF9yZWNpcGVfdXBncmFkZV9zdGF0dXMgcmV0dXJucyBhIGZsYXQgdHVw
bGUgb2YgNyBlbGVtZW50cywgd2hpbGUgbWFzdGVyIHJldHVybnMgYSBsaXN0IG9mIGRpY3RzLiBJ
J2xsIHNpbXBsaWZ5IGl0Lg0KPiANCj4gQWxleA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4g
SSdsbCB1cGRhdGVkIGluIHYzDQoNCkRhbmllbA0K

