Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43D7FF8860
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 13:22:03 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.34])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.45141.1777296116825508143
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Apr 2026 06:21:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ericsson.com header.s=selector1 header.b=bTS38W2l;
 spf=pass (domain: ericsson.com, ip: 40.107.159.34, mailfrom: daniel.turull@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1/D3gpEUgfnvOvVawygZdmyo6Y98zYKGy/zdz6ZDJvZ/gnvkAMPiZ4mVUOSYvdijUwBr9/G8OQbF+4cy4bpDBaTTf2E7eFH+U1FJR+jJ/efEUGdY6+9QumH1TX+h30+IdIL/Rfiu57SuGYjpM5l12Uu3WXg2aTPS803+T/mLBlQdrMR8BvtejdqV5EY46m5q04V33OhhOT1bvG4HJU+TvlYS/2Y3A6EQ3reZ8H/sUYWRE7lAreY7T3huXVLe8zIiBlVvLeh/OC5LYzCcf0uv4VB0KSjYNz1NY9oFBHRlX90E/EMfGy+Qucz6OcZNHNJfQ4a/QPzkl4OHU29KyIh0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHs8KRonA8u+1f8A/z93E6pCPauFJQrVr/i2aWaeqb8=;
 b=kNhAvuQgwx9JKV6wcAT2kzPDmZ+cjQveWMGOPyoa+UIRZ+YfK90vomaJfoHJi87VtVJ5cvfCeX7QkD2RThiqtK/kJOuS/VFyYxAXr2H9Bsmr5D3pX43u8y/bnRbjic45nEXPdzf7afbp8cLEfqX6xWsXX/orRbz+NAKJiSwEF0CkTYEYHtnujfsnHUws51h28E2jZg8zX+fV3gUe0twxFfCQccpTuXoTMhQBMIYRFW+BgapI1S5/kawSLnv654ppaacSO2KsFijtzgWj3rtMxo2kCYaMrdJBaAOVukk4DmK6OpicvNIbD7mGw195x6JfY9kcBy/qITIzwuR3kB6BiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHs8KRonA8u+1f8A/z93E6pCPauFJQrVr/i2aWaeqb8=;
 b=bTS38W2lksi1NOjkd+NYlM0VRDtauxjTJ29oVU+5W+XrphGXkY2WNM9DWHL6E4Hcvy+E0neiUAwLc3yth+Y8x3UizO0hArfJbObJ3wVgRhGHeGqh41i2MintSHfFWauR8J5xhcZknthNrjvM0sCHIC0TcrdWC/SYQMmOJfKfy4yEwEspfHs8LsComHjAbVbPQWIR3geOiC+n8iuPo+fgZ2PI8K/9AyiIWi7z0bo7jVvciy1E3zgNE5vI94TLINPUJyZh8afKcEI0mTNBg7qROhQImKhfrCGx3IQC9E/KOBtUHiXpVXAh8T0L+YwqaEYtjUtweZp8R01Js9pH+Yelfw==
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com (2603:10a6:102:4af::6)
 by DB9PR07MB7226.eurprd07.prod.outlook.com (2603:10a6:10:21f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Mon, 27 Apr
 2026 13:21:48 +0000
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7]) by PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7%7]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 13:21:48 +0000
From: Daniel Turull <daniel.turull@ericsson.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>, "paul@pbarker.dev"
	<paul@pbarker.dev>, "ross.burton@arm.com" <ross.burton@arm.com>,
	"yoann.congal@smile.fr" <yoann.congal@smile.fr>
Subject: RE: [AUH][PATCH v2 8/9] upgrade-helper.py: Add resume option to skip
 already attempted recipes
Thread-Topic: [AUH][PATCH v2 8/9] upgrade-helper.py: Add resume option to skip
 already attempted recipes
Thread-Index: AQHc09/4nev8mubiek2TMY3rGl2kJrXyvyOAgAAqlCA=
Date: Mon, 27 Apr 2026 13:21:48 +0000
Message-ID: 
 <PA3PR07MB1072177D74510965B707C37378A362@PA3PR07MB10721.eurprd07.prod.outlook.com>
References: <20260424114603.2444938-1-daniel.turull@ericsson.com>
 <20260424114603.2444938-9-daniel.turull@ericsson.com>
 <CANNYZj9k84O+4u9ugAwV1D+S05VT=TGBbx1Bwft9qxG-u=O5bw@mail.gmail.com>
In-Reply-To: 
 <CANNYZj9k84O+4u9ugAwV1D+S05VT=TGBbx1Bwft9qxG-u=O5bw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR07MB10721:EE_|DB9PR07MB7226:EE_
x-ms-office365-filtering-correlation-id: c12c3e89-03b3-4fc2-8277-08dea45fef86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|56012099003|18096099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 iXzjGt4Tn7g85xZxiu0uOYTqEzeYcX4ILkLTG/cwnE5fkmVJfpNaM24EWMEkA/RCn31FbHr6+5jEsb3xV3MNdm3iUTXU5XqTG3VnnrKrCGpmuc6vEz7RerwiyIw3tm38klnDcu2R8gRK66iAkiZPCP5QqLTSa6tnimOyl1MxjurJp2YHEI8PW8cKVayTlLUXEx5MGMhdmsGFH+APpIwTPYpQ4g4xOnYRXhoLoB7JguJ1HBYexU3ebpXS7jJM06SNjzFOM7wqMcLvLsgtqk3KxHn1TANnWwr9JWBP4XK4a9A3KOG+gYUyym+l/Y1EStO7tdFt0ijS1nFFcuJ5KBMyPZ1mslvIWTaJ0uMUh/zuZ8srn4WNNnXhb5zzDxMvxa351T1nUesVaMUt2pYacau8pqVy9mQ9p5rAYJfM+3VZxow7HTZ6qOfnDbzSDPmw0Tp2Bx/ldJVIOYNpqlsoyXNALKl0Ig5rv/znW/HhxC/g/Y0h4DYLRGTFX0hlvYv04TpgAgor4QFI2lbEnrBKVM+1Z37v6YI59DhQvJVnsBTiWglwWSK1hsakuUN+2IUsHTvp1Pa6KSGfBprDShQnsY8ba/zHeQwEZaJVYX0k096ofwbCdPTVpgA1K1NAyobxlaoeeSZpjByQN+f1hIv+JCfJlGTYFVPiAK5ZWDiCVlyMSUyj5O9OWqa3ogtdLVUSNPvrWYZMUEv7hO9+/sVEqXpL2kUPyVnYCalq9PcznbjNQjs1JsBZcXlLF3AGXquUStfkXIY6bhng3SoTjp4l9VLLEnsZa4kJy7PDiSgVKqf+Bxs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR07MB10721.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(18096099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VHVBYllIcnJoT0dPdE5EMDVIZFBNZUY4cjNzTDZQck5NK1d4S2ZJYkZIZ25m?=
 =?utf-8?B?SFBQU3BISGRQRXNxTmkxZlYzNUIxUWdNMGlUS3l4MW9VbkRVcUViUUF4QVRk?=
 =?utf-8?B?bU5CbVNQM3F5NHUwRDlqeWRRYS9SUmJGQ25SRS8rcTZuUEJvdFE3cnpTM3Vh?=
 =?utf-8?B?Y0g0QjNXKytoRDlORS9mZkVRNm9JbHdHNnR6YUE4bWtwUUlZMUE4VTBEUmFE?=
 =?utf-8?B?RU5zeE9YYnRjQU5YU2ZRbDZaTTQ4alB2d2oxZUNac3pjd1prOFQwNE43bjBn?=
 =?utf-8?B?NERsWGEreFViNGhuQ3VCZUNJa2RmVDZ6NzJPZDZwTGJWNjg1ZnllQ2pLYlNm?=
 =?utf-8?B?MVBPV2VDQTJvUHBFMm5DWjRoNk1xbnVHd0wra3JzbSswc1dnNW1WTC9aMnQz?=
 =?utf-8?B?OGNyYWJwdlhZZ2kvTGkrS1FocXBYc00rdGJSYytWNEZQYVN4aFlRbitjcmFx?=
 =?utf-8?B?Y1NFWHNJbCtDREc5cjdkb0trMER5YXF6S0F6TDFJa1pUNGZxRVEyMy9JYnpP?=
 =?utf-8?B?bjlTZ0FXR3NqZ0YwMmUvQnNldFZXM25NaFFTUnJJMHJkTEgzQkNDcGpoSmtV?=
 =?utf-8?B?SU8zeEN3c2lkZmNkV2lrUWhlU0VBTW11N2VVZnRhUjVOQmVSU2JiRGpNYm9x?=
 =?utf-8?B?Sjh6c3VaMTB5MTFQd3hRQjB0amxGYmNTeWR5NHpaUmdyTVVHbUYrMytKbU5O?=
 =?utf-8?B?c1ZCSVJVQ0ZrYXRVMUxTWUE4VFRyR09SM2ZJSFhTREIyRmhlcDQ2c0pTTkgr?=
 =?utf-8?B?NWpTbVMyOEN4aDZTRWh0bU16YngwdG5ZL2ZmS01rSVBlcTFENWNRZEg2RHpB?=
 =?utf-8?B?cG9sZnRPOXhLZGtRYUdHOWs0aFZ0U0ZYZEtad2t6SUNTNzE0dlNIcUV3ZVpE?=
 =?utf-8?B?SFUzanpaUCszSGxYY1B4dy8zb1M2TmxYWUNObUxBcTRvSXNXZ2JKUllXWW1j?=
 =?utf-8?B?WFhsaG5EYWVKbE1lbC9yRWNTVERtdDYzTnVDaCtveW1mdEt4MjlqTXFPSVpx?=
 =?utf-8?B?VEZkbzJsSjF3cXM0MlRFU29IWGE5TG5lMUYyL1A3aEhYakNUV3ZpTVNHSWhl?=
 =?utf-8?B?Tll5ZXBDWExxaGFOeWRmWUNjdFZ5VkxxK3JNd3lmQVV2dUVab2lZMWxHTDdP?=
 =?utf-8?B?ekJlVnJJYXlpNXdhU3YvbDVCZXJWTDFRQk5scUdRZUg5bGVxWGYxTEl4WHhE?=
 =?utf-8?B?UEFvdHJDMG9FNG92RDZURUQ0VTlVZTRySE5jUjZGdXF3TGh2UkRTc3owNjgx?=
 =?utf-8?B?SXRsVHE0emJqSWU0b2pRdzZZUkVKVThBaFVuUzZLNmplazdFOUM3c2s5OGdD?=
 =?utf-8?B?RVRpcGMzWmRkUUJVRmhScHBjZUhnSFZzaTVRSGRET3hJb3dmTDJYWHJaa0Fa?=
 =?utf-8?B?K0NJRUpIc25ZWHRIU1pRM3hIdGRldEFBWW5FS21HejVyT3NrZDF0eHNxbFB0?=
 =?utf-8?B?czNhSmRQc3RBWEFmOHpxYkxsSWJ4SWlPRlJkMy9TRVpobEd5YzRCQm9xdGhv?=
 =?utf-8?B?VkJoL3FTVWhGNmhxaDdLaEhxVTB2cW0vQktPMzYyeTM4QyttUThnb2xqOXpI?=
 =?utf-8?B?dFlSQk0weTQzKzMzTWE5UGlOOHJtcXh2MGszWjVJYTd0YURhUDU1ejVxTXhY?=
 =?utf-8?B?cjlBRFZxR0lWbHZVT3BvUjFoYTFIZHBBM2xwTlJkd3Yyeks5OC81NGdKcGps?=
 =?utf-8?B?TFRxMHFnQlltbnltTWlGTE1TSnpaK3NCbEg1RVMzZHcxZnF0b3VITDZKdFNq?=
 =?utf-8?B?Z1pEMjhGSG1NMklFdVZQSEFuSHgrb1VOV2dXdTluODFmeWxsRzhucVpXZEZz?=
 =?utf-8?B?Yjl5eHZLRHhobjd3TFFwcmxQb3htYmhOcHI2bWxiT2FOYWdnVXZCa0psWFVo?=
 =?utf-8?B?a0wyL3dkdGh6dUtDc2UyTEpMZC9pbENzSmQ0Q3ZmUjNleERsUHBXNGxDZ1dm?=
 =?utf-8?B?c0F4Vy8xMWN4aXg5K2tKN3BIR3cvOCszd2FpRG1ybEE5V3dMWEZGc3J4ZEVD?=
 =?utf-8?B?WDV5eEpQdTBxRWk0ZEpEUFdHakxTSGNLYnkzdXhQV2JmUmUyK2xmRTFYTmtI?=
 =?utf-8?B?OGVHVEpXMUtUZEtPS1hHaFY0N0twMnpSWGpwWXIyY2VIdFdQemdka0F3SXRP?=
 =?utf-8?B?VU0wZ1RleWk4MjFDRGEvOXdEa2Jndll6dVZ5ZStqYWlmQlV6Q3B6ZCtYay8y?=
 =?utf-8?B?Uk5UZlcyVVZ6emw3eTE5dGF5Q0hkeU4reDNBNjNwSW8wemtzVER2RGJrbnlZ?=
 =?utf-8?B?L1ZmcExneGZDZC9WaDJtaDlIWlRFdnBPeEV0VEYxL21wcEljaXgvRkhheDBF?=
 =?utf-8?B?M0FGbXVYRWdaZEM4RmRjbEMrekhNQzhXbnpvVW5obTFFWitsY25wZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR07MB10721.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c12c3e89-03b3-4fc2-8277-08dea45fef86
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 13:21:48.0539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4y2B1RBvfbbvqk93+Eetit/yYcACc6XKLBfWrw5lvF6Vq0rMXGWV/dJn1JjNbE06V/NUAwL5HPC65O7REkx75d9/lITdoLdiMOl60tyR8Kw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7226
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 13:22:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3846

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleGFuZGVyIEthbmF2
aW4gPGFsZXgua2FuYXZpbkBnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgMjcgQXByaWwgMjAy
NiAxMjo0OQ0KPiBUbzogRGFuaWVsIFR1cnVsbCA8ZGFuaWVsLnR1cnVsbEBlcmljc3Nvbi5jb20+
DQo+IENjOiB5b2N0by1wYXRjaGVzQGxpc3RzLnlvY3RvcHJvamVjdC5vcmc7IHBhdWxAcGJhcmtl
ci5kZXY7DQo+IHJvc3MuYnVydG9uQGFybS5jb207IHlvYW5uLmNvbmdhbEBzbWlsZS5mcg0KPiBT
dWJqZWN0OiBSZTogW0FVSF1bUEFUQ0ggdjIgOC85XSB1cGdyYWRlLWhlbHBlci5weTogQWRkIHJl
c3VtZSBvcHRpb24gdG8NCj4gc2tpcCBhbHJlYWR5IGF0dGVtcHRlZCByZWNpcGVzDQo+IA0KPiBP
biBGcmksIDI0IEFwciAyMDI2IGF0IDEzOjQ2LCA8ZGFuaWVsLnR1cnVsbEBlcmljc3Nvbi5jb20+
IHdyb3RlOg0KPiA+IFRoZSBza2lwIHNldCBpcyBidWlsdCBieSBwYXJzaW5nICdVcGdyYWRpbmcg
dG8nIGFuZCAnUHJlLWJ1aWxkIEZBSUxFRCcNCj4gPiBsaW5lcyBmcm9tIHRoZSBwcmV2aW91cyBy
dW4ncyB1cGdyYWRlLWhlbHBlci5sb2cuDQo+IA0KPiBJIHdvbmRlciBpZiB0aGlzIGNvdWxkIGJl
IGxlc3MgYnJpdHRsZT8gRm9yIGluc3RhbmNlIHRoZSBza2lwIHNldCBjb3VsZCBiZSBidWlsdA0K
PiBieSBjaGVja2luZyBpZiB0aGUgdXBncmFkZSBvdXRwdXQgaXMgc3ltbGlua2VkIGluIGZhaWxl
ZC8gb3Igc3VjY2VlZGVkLy4NCj4gQ3VycmVudGx5IHRob3NlIHN5bWxpbmtzIGFyZSBjcmVhdGVk
IGFmdGVyIGV2ZXJ5dGhpbmcgaXMgZmluaXNoZWQsIGJ1dCBpdCBjb3VsZA0KPiBiZSBkb25lIGRp
cmVjdGx5IGFmdGVyIGVhY2ggcGFydGljdWxhciB1cGRhdGUuDQoNCkdvb2QgaWRlYS4gSSdsbCBy
ZWRvIHRoZSBwYXRjaCBhcyB5b3Ugc3VnZ2VzdGVkIGluIHYzLg0K

