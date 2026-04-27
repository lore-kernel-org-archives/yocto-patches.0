Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155F4FF8860
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 12:31:03 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.16])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43743.1777293057728127418
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Apr 2026 05:30:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ericsson.com header.s=selector1 header.b=iRJU9EQA;
 spf=pass (domain: ericsson.com, ip: 52.101.83.16, mailfrom: daniel.turull@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HCT7wdCfLCn4QFe+2BZ3Slpf2Rfjl1ZaD4QlERygPfXaiEtYfqSoAmRGitq2cm/wMX6uDUDEh+Zw0LAYofS5KTPJAGnmhEptxh4AG23OZ3iCe1t2peG+lbDY4511gXctNsh06NqypEc54UivRztq2UIEXonC58Q6fhPuL5xCf7RfqBMb2iFY0Q7kxpC4HGFA6pN8xTezvvezpQ4hibCrjYrCn7LXojchFREj7Y6edFnUMDJIyQBADZOTTccVOkLYpet6u+ZDCZMemO/aqQzDT757DBFRLkBnwLjQuyrHQRuPOztb2iS4d3QS/nhG5LdWcY2Y9npap9tIm+muIOvQcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQMpgA3od/bqVT5CX6Eb429L/580KhvplHAFZ9y4SUA=;
 b=Tawc+PqBq2yc0xm+qrNi6HL7FzQ3NzPZ4vvGZPaaf7piL4ubl54EwkQJo2aMFUbSNLPdkv7c1Iq4VZ6zoFcYslr8vwDjVVocdwDjwB/38WLFmAiCoTTLgoEKt3KcNR+cCbPwE8YPk+iJ83bggMb3T5+hKNhOnJ/Esl34Vsyzgf0x7Bfrfgtu0DmagKjonfT6KZwVHMteirtrArUzqI2znDuiupTRnNN41Lg8G8NYyCqVbmvlDs/HzoqfjY9yD+/VrNJocMWRsQZ+2x/rsz+KaHrrk1ZvvyupU8MQzoVKw+LMqBeoX1eZslImSfk0vYTRmFvcXYjrrL9U9TnTCPuKOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQMpgA3od/bqVT5CX6Eb429L/580KhvplHAFZ9y4SUA=;
 b=iRJU9EQA9Qr5DCQayCzDjaF9gaJzhBNcERvz8QGEd8qjBl+WBE9cbhG3gBW2w8d6XydWIrLd/NBOeGSAyrgTA8Qta+q3AzNSDNrv/TEAIQzubtXgWgC9oxrf5FDy35kT5fwUdQLtdFaAPobqWlPpcorUNBCAW/uzapQxznWRlpOWpGARZHMhDj/O/j0nfppKZNstvONJTFWddznszPsf5q4eFN80F63fkC6kS77cL6GATT2HxQOxDqf+sAtQHv5x/vrDonsU0e2ymLMcUtNhHt1RKf0i0c38cH24ygrTjbxLZ/3DRurILEhL2FETWPM57e4uG1KY0FbvhojyPKf8bg==
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com (2603:10a6:102:4af::6)
 by VI2PR07MB11055.eurprd07.prod.outlook.com (2603:10a6:800:29e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 12:30:52 +0000
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7]) by PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7%7]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 12:30:52 +0000
From: Daniel Turull <daniel.turull@ericsson.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>, "paul@pbarker.dev"
	<paul@pbarker.dev>, "ross.burton@arm.com" <ross.burton@arm.com>,
	"yoann.congal@smile.fr" <yoann.congal@smile.fr>
Subject: RE: [AUH][PATCH v2 3/9] upgrade-helper.py: allow to set the git
 directory from layer-dir
Thread-Topic: [AUH][PATCH v2 3/9] upgrade-helper.py: allow to set the git
 directory from layer-dir
Thread-Index: AQHc09/2Yl3aCAfnCE6DbrIJqmTcwLXyryeAgAAA+RA=
Date: Mon, 27 Apr 2026 12:30:52 +0000
Message-ID: 
 <PA3PR07MB1072109B63492CFBDC5E3C6F98A362@PA3PR07MB10721.eurprd07.prod.outlook.com>
References: <20260424114603.2444938-1-daniel.turull@ericsson.com>
 <20260424114603.2444938-4-daniel.turull@ericsson.com>
 <CANNYZj9hfFoUiGQP+AxDFd2Y6g24h3O4aHGLBOAJCJCmCcgwyA@mail.gmail.com>
In-Reply-To: 
 <CANNYZj9hfFoUiGQP+AxDFd2Y6g24h3O4aHGLBOAJCJCmCcgwyA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR07MB10721:EE_|VI2PR07MB11055:EE_
x-ms-office365-filtering-correlation-id: 4fa8ef21-0159-4e25-f892-08dea458d251
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 
 uv/rbzREEhaO/5RhiwRXtdSucHMNGq1nMtVN4ff2Fc1dXw9Cy5cPxZm8xkR9uKT67F6m5PZTL2IlZCmf9pN+Fb/jm1/4x7s7n4R4yzDUD4/BksswIzjnZiU6sYKPtQEOrX6fJJlmdO2r3hVwbF9oOFn067e2mINbrYdDYqnlnQDv7VT8YrYb5wHabrWbfCJiwyiwvdH1154HT9K3ZPI6HpGTT7cqpr7uOXEcKt9PTvTRsCaTeO+xkbJpiSRjiXRTxSU64sd0Iy7FPoL1YVh3wt7kkggZyzYKGm+N+sGrJG5QqUKkSTQEU0h79JdOiIcterrEg4li1Uwszm+TCjK+2QeWyZtmvLOnKQXIEcfcdThJyrZEEB1H/18YbB9Mh7FVXrKRdxDmr66Pq1o4TRSKKJ1YU/ALMGuIaTGL00TpiwPO475bGdxgBdNEgGae2XtKx9co2luzHWm3X7bRFA1khqDuFEySdj7LAdJUsC+lZ2EQXgwBuCftUW197kEXiEkE4oxn89a4+tqC5AHg/2ZzLEbC1tqVof5Sd2CSWBDnsRKmb+6Kch2PkIt9xmVsCMHQQzbHo//S2mFmyt9HVHANvAOd3qtbIYjJENxgyIl3LkayNraqrOJdMVT7LXQL1KJiUMez4zMuZuESw8VL9dSSrzKfFAS9zY9vH5Ggn8Qq3uJCELSvnxrDgQIQy1vgQQ3zfLkDRDUJ80RaaX00wCSuKYXq0huO2FYDyuZpP19WsUcKYfujgb2V2KTCtVUIsqJKKUtmkfCAVcCDTke56a+3rlVpuNW9rxHbGvzuad6uFA8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR07MB10721.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?L1F4aVRLajhRMVVhL2dBRCtaY0hUWmdSSERNa3ozc29uQmtWWk1KVXpxWENz?=
 =?utf-8?B?K3dNeEZ1R20rN1p2OUZHdFNXLzViQ3krSm5MajdkbitueHNFMy9lNCtwbzBP?=
 =?utf-8?B?LzdjWnpsWFZ4bURxVHNzcnNPcE5iUjNiN1lTaUp5MDk0Uk9OUmN6VmxxbmhQ?=
 =?utf-8?B?akYrQlNlQ0NhZU1wYVhrdDNoaVlNenhoeVk3UkxKWWRjR1MwaWFFOHZMcmZy?=
 =?utf-8?B?RFNzNmp3T1JvREhMYnV2NXYxRUc0YmsrUXkwWUt6WlVhc2NuWFdBNWtiMXd0?=
 =?utf-8?B?alhPRHp2Q3FnN1hDek9RWGFObEdvZTNjNjVrZVhxNHgrSTZua0JWSVlZWkxF?=
 =?utf-8?B?ajZIM3A2U3R1TXhEODQ4dytJQ1Ixa3ppQnpGRVJ5V3hua0UrTFEyL0g4K29X?=
 =?utf-8?B?UW1BZ0Rxdk9XS1ZtdXVKRmpOL0xBTEsvdk5POTlmRHZnNDJKL2dDRWRid0hS?=
 =?utf-8?B?LzR5aE9PV3REb3ZiSTQ2SjJ2OSsxajBrQVR4T285OE1PeXhVSVhJL3FkSlBy?=
 =?utf-8?B?RytXdjduMFhCa1pyaHNDa2NPK2ZKTnVIaUNvRXNoakZBRjNBQnJtdXdpVnNq?=
 =?utf-8?B?cW5WVzZkWmpXZENaWHBUWUluSnpOZG9WU1hhbkNyVURFd0lJazU2SWVVRDgx?=
 =?utf-8?B?Y2YrMkdiQzlBbDJoVVNnUVg1U2k0cmp5cllBZUljbC9CZDRFcTA0eis5TXVX?=
 =?utf-8?B?cjl5U0p4RmlrTEwzWG5aSWxEYmE5bmgrRVZweEs4TWcxT2tYWWk0d2wzUDE4?=
 =?utf-8?B?UGpqM2hLMTVvSFo1L0hjKzROT3VjaHhGVmV3ZThua0FWSTlyZjlIZmFWRDhT?=
 =?utf-8?B?RzA0M0ZwUGFLRFZHWG4xQ1hNN1NZeE5vQVArZEtKV05CRm4vNDFJY09YUThh?=
 =?utf-8?B?UzR0aFoxRDdTYjRuNGFQc2Zwd1JxUEd2K0sxZ0FKT2QwNTUvMGtyVVVBNVIy?=
 =?utf-8?B?d2lRUjEzL3Q3dmUxdEQ0UEJRejJUOGRUNjgyUzdTaFIrZE5MVW1nWXBkMEFs?=
 =?utf-8?B?dmEwdDNFckFXT2FZaDJMS2tFc1JrNThmRlZQZWcvWlY1RnBieHl5a2hLQnhL?=
 =?utf-8?B?bnBjYkNrbWg5YTBlQ1RMOVdQS2t4NFdyVjhjazdSVGYvZDVSdDI0WURVQ3dr?=
 =?utf-8?B?M21nOWF0bzROb2dsR0xiMUNJQWovakRObXFBWHc1YjNUWmlMbWtSODllMFZa?=
 =?utf-8?B?em9WaUZzZ0ZNZXE1SjJYVXFvNVFWRlhaajBOemZ5QURVdndhcGRGZVBQZWw2?=
 =?utf-8?B?aVVhRVFjUGNqTEltSTNqWEZ5QTFMc3lSQUxKOFVnVDFQYlBtcjMyYy80S005?=
 =?utf-8?B?T0plNXN5dE1WdkdvL0tXNjVuT2Z4RjFBSTRPZ0dVUlFFT2NZeWp3VXJ6aitj?=
 =?utf-8?B?UURqRFpUbUxmMnZieENWZWJPSGl5WHZBaFRIUDl6K2lyT2t3TTJUU09NY3g0?=
 =?utf-8?B?a0wyUVpFbkhDWFdLeDJVZXdjc29GQUN4SnE2QWtFRjJiajdieFo4ZUdFc3Ru?=
 =?utf-8?B?T0Z2U3NtU0hmRy8vbVBRWnN1aU5pclpJUjBwM1ZXdjMzeU8rdVdJcC9nWko0?=
 =?utf-8?B?L2laN3FsQmUyVXZLY3Z0cXNBQVNHWEQyOTNzblpCQUFuTmVOSlE1YTZCSDdW?=
 =?utf-8?B?YkVzemRZRG01NmxPdHErcGs0RVovc0tqSnZRc3A1Q3hFS1YrVHNVemVUbnZV?=
 =?utf-8?B?S1lBaTIxTDRzTUYyaU51NjlpT1c1elFhdVdBUzBkS1czSUt6cWNWT0Y5dHox?=
 =?utf-8?B?R1VmdkMzU0ZEK0tnZTFsZktEaDkwWXpuN2dXbmdyNmZ2L0pGckExZGhGM2dW?=
 =?utf-8?B?b0ZHQ1RlL3ZTeWpDWUNzaWUva05oUnU2MExnc0lhZGxFQk83TU50dEMvUFo3?=
 =?utf-8?B?M2I0OTNGcUk2dGc5aENrVTROOFphWFBHeDFHZWVSSGVpVUNpQWU3YzJFblZw?=
 =?utf-8?B?NlJSTW1NWUVKTnRFdDhWanVkdVJUNXlqb21xVGlWSzJMQXRKR01HNzhTRHpH?=
 =?utf-8?B?bGRVOHpCeGw5TGIzTU1JY0t4RHY3TGZ0Z0lzS29rRnE1bnBYTjZKMlFQV3hv?=
 =?utf-8?B?d0xGeTY4T2VwN2FMa2VCckY0MXpsWTh3SGJKUEFndkU2Q0M2L096REErc3dK?=
 =?utf-8?B?SDROcVRTM0hGSkNCOGIycXA1cFJGK3JoTDB0dmJlRXprbVRaemJxSWlXNDA2?=
 =?utf-8?B?YXZXWjdMMVVUUFRQS0lEMExRdTk0VFhwNHpKalE1dnhTRnY5Wm9jejVaOGlI?=
 =?utf-8?B?cUZsNTF6ejJrSTNxTWRKUHNBM1dPY1dsM1pKZVdheTM3eFg4Mll1L2dEbC9S?=
 =?utf-8?B?N2p1U2dZNXlPbWF4dVNjQ1ZXRk42Z1FjUmh3c1BMNU9kSEFCdlZxQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR07MB10721.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa8ef21-0159-4e25-f892-08dea458d251
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 12:30:52.5767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XDsJFKTj+AzEf2F1DqHfO3dV1gSGLgJfwIAaPlPnYEXL7SC+Kx1hMgQhRB0e3PHKAUDHqVqtFfemH5sWpHgTAekLSE5/sGje2zYlL3upXzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR07MB11055
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 12:31:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3842

SGkgQWxleCwNCg0KSSB3ZW50IGJhY2sgYW5kIGNoZWNrZWQuIHNjcmlwdHNfcGF0aCBhbHJlYWR5
IHVzZXMgb3MucGF0aC5yZWFscGF0aCwgd2hpY2ggcmVzb2x2ZXMgc3ltbGlua3MgY29ycmVjdGx5
LiBJIHJldmVydGVkIHRoZSBwYXRjaCBhbmQgSSBjYW5ub3QgcmVwcm9kdWNlIGl0Lg0KDQpNeSBs
YXlvdXQgdXNlcyBzdGFuZGFsb25lIG9lLWNvcmUgd2l0aCBzeW1saW5rczoNCg0KICB5b2N0by1z
Y2FydGhnYXAvDQotICBzY3JpcHRzIC0+IG9wZW5lbWJlZGRlZC1jb3JlL3NjcmlwdHMvDQotICBv
ZS1pbml0LWJ1aWxkLWVudiAtPiBvcGVuZW1iZWRkZWQtY29yZS9vZS1pbml0LWJ1aWxkLWVudg0K
LSBvcGVuZW1iZWRkZWQtY29yZS8gICAgICAgICAgKGdpdCByZXBvKQ0KLSBtZXRhLW9wZW5lbWJl
ZGRlZC8gICAgICAgIChnaXQgcmVwbykNCg0KVGhlIGVycm9yIEkgZGVzY3JpYmVkIGluIHRoZSBj
b21taXQgbWVzc2FnZSBtdXN0IGhhdmUgYmVlbiBjYXVzZWQgYnkgc29tZXRoaW5nIGVsc2UgaW4g
bXkgZW52aXJvbm1lbnQgYXQgdGhlIHRpbWUuIEknbGwgZHJvcCB0aGlzIHBhdGNoIGluIHYzLg0K
DQpUaGFua3MsDQpEYW5pZWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBBbGV4YW5kZXIgS2FuYXZpbiA8YWxleC5rYW5hdmluQGdtYWlsLmNvbT4NCj4gU2VudDogTW9u
ZGF5LCAyNyBBcHJpbCAyMDI2IDExOjUyDQo+IFRvOiBEYW5pZWwgVHVydWxsIDxkYW5pZWwudHVy
dWxsQGVyaWNzc29uLmNvbT4NCj4gQ2M6IHlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0
Lm9yZzsgcGF1bEBwYmFya2VyLmRldjsNCj4gcm9zcy5idXJ0b25AYXJtLmNvbTsgeW9hbm4uY29u
Z2FsQHNtaWxlLmZyDQo+IFN1YmplY3Q6IFJlOiBbQVVIXVtQQVRDSCB2MiAzLzldIHVwZ3JhZGUt
aGVscGVyLnB5OiBhbGxvdyB0byBzZXQgdGhlIGdpdA0KPiBkaXJlY3RvcnkgZnJvbSBsYXllci1k
aXINCj4gDQo+IE9uIEZyaSwgMjQgQXByIDIwMjYgYXQgMTM6NDYsIDxkYW5pZWwudHVydWxsQGVy
aWNzc29uLmNvbT4gd3JvdGU6DQo+IA0KPiA+ICAgICAgICAgICAgICBzZWxmLmdpdCA9IEdpdChz
ZWxmLm9wdHNbJ2xheWVyX2RpciddKQ0KPiA+ICsgICAgICAgIGVsaWYgc2V0dGluZ3MuZ2V0KCds
YXllcl9kaXInKToNCj4gPiArICAgICAgICAgICAgIyBhbGxvdyB0byBzZXQgdGhlIGdpdCByZXBv
IGRpcmVjdG9yeSB3aXRob3V0IGVuYWJsaW5nIGxheWVyX21vZGUNCj4gPiArICAgICAgICAgICAg
c2VsZi5naXQgPSBHaXQoc2V0dGluZ3MuZ2V0KCdsYXllcl9kaXInKSkNCj4gPiAgICAgICAgICBl
bHNlOg0KPiA+ICAgICAgICAgICAgICAjIHVzZSBzY3JpcHRzX3BhdGggdG8gZ2V0IG9lLWNvcmUg
ZGlyZWN0b3J5DQo+ID4gICAgICAgICAgICAgIHNlbGYuZ2l0ID0gR2l0KG9zLnBhdGguZGlybmFt
ZShzY3JpcHRzX3BhdGgpKQ0KPiANCj4gSSBkb24ndCB1bmRlcnN0YW5kLiBzY3JpcHRzX3BhdGgg
aXMgc2V0IHRodXNseToNCj4gDQo+IHNjcmlwdHNfcGF0aCA9DQo+IG9zLnBhdGgucmVhbHBhdGgo
b3MucGF0aC5hYnNwYXRoKG9zLnBhdGguZGlybmFtZShzaHV0aWwud2hpY2goImRldnRvb2wiKSkp
KQ0KPiANCj4gV2hhdCBpcyB0aGUgbGF5ZXIgbGF5b3V0IHRoYXQgY2F1c2VzIHRoZSAnd3Jvbmcn
IHBhdGggdG8gYmUgcGlja2VkIGJ5IHRoaXM/DQo+IEVpdGhlciB5b3UgdXNlIGludGVncmF0ZWQg
cG9reSByZXBvIHdpdGhvdXQgb2UtY29yZSwgb3IgeW91IHVzZSBvZS1jb3JlDQo+IHdpdGhvdXQg
aW50ZWdyYXRlZCBwb2t5LCBidXQgeW91IHNob3VsZG4ndCBiZSB1c2luZyBib3RoLg0KPiANCj4g
QWxleA0KPiANCj4gT24gRnJpLCAyNCBBcHIgMjAyNiBhdCAxMzo0NiwgPGRhbmllbC50dXJ1bGxA
ZXJpY3Nzb24uY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IERhbmllbCBUdXJ1bGwgPGRhbmll
bC50dXJ1bGxAZXJpY3Nzb24uY29tPg0KPiA+DQo+ID4gUmVwbGFjZSB0aGUgYXNzdW1wdGlvbiB0
aGF0IHRoZSBwb2t5IGRpcmVjdG9yeSBpcyB0aGUgZmlyc3QgUEFUSCBlbnRyeQ0KPiA+IGFuZCBy
ZXVzZSAtLWxheWVyLWRpciB0byBzZXR1cCBkaXJlY3RvcnkgZm9yIGdpdCByZXBvLg0KPiA+DQo+
ID4gVGhpcyBpcyB1c2VmdWwgd2hlbiBub3QgdXNpbmcgcG9reSBhbmQgZWFjaCBtZXRhLWxheWVy
IGlzIGl0cyBvd24gZ2l0Lg0KPiA+IFdpdGhvdXQgdGhpcyBmaXgsIGNvbW1pdF9jaGFuZ2VzIGZh
aWxzIGluIG5vbi1wb2t5IGxheW91dHM6DQo+ID4NCj4gPiAgIGdpdCBhZGQgLi4uL29wZW5lbWJl
ZGRlZC1jb3JlL21ldGEvcmVjaXBlcy1zdXBwb3J0L2dudXBnDQo+ID4gICBmYXRhbDogJy4uLi9v
cGVuZW1iZWRkZWQtY29yZS9tZXRhL3JlY2lwZXMtc3VwcG9ydC9nbnVwZycNCj4gPiAgIGlzIG91
dHNpZGUgcmVwb3NpdG9yeSBhdCAnLi4uL3lvY3RvLXNjYXJ0aGdhcCcNCj4gPg0KPiA+IEFzc2lz
dGVkLWJ5OiBDbGF1ZGUsIEFudGhyb3BpYw0KPiA+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBUdXJ1
bGwgPGRhbmllbC50dXJ1bGxAZXJpY3Nzb24uY29tPg0KPiA+IC0tLQ0KPiA+ICB1cGdyYWRlLWhl
bHBlci5weSB8IDMgKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS91cGdyYWRlLWhlbHBlci5weSBiL3VwZ3JhZGUtaGVscGVyLnB5
IGluZGV4DQo+ID4gOTgzOTFmMy4uZGY5MjdkMSAxMDA3NTUNCj4gPiAtLS0gYS91cGdyYWRlLWhl
bHBlci5weQ0KPiA+ICsrKyBiL3VwZ3JhZGUtaGVscGVyLnB5DQo+ID4gQEAgLTE4NCw2ICsxODQs
OSBAQCBjbGFzcyBVcGRhdGVyKG9iamVjdCk6DQo+ID4gICAgICAgICAgICAgICAgICAgICAgX2xh
eWVyX3NldHRpbmdzX2Vycm9yKHMpDQo+ID4NCj4gPiAgICAgICAgICAgICAgc2VsZi5naXQgPSBH
aXQoc2VsZi5vcHRzWydsYXllcl9kaXInXSkNCj4gPiArICAgICAgICBlbGlmIHNldHRpbmdzLmdl
dCgnbGF5ZXJfZGlyJyk6DQo+ID4gKyAgICAgICAgICAgICMgYWxsb3cgdG8gc2V0IHRoZSBnaXQg
cmVwbyBkaXJlY3Rvcnkgd2l0aG91dCBlbmFibGluZyBsYXllcl9tb2RlDQo+ID4gKyAgICAgICAg
ICAgIHNlbGYuZ2l0ID0gR2l0KHNldHRpbmdzLmdldCgnbGF5ZXJfZGlyJykpDQo+ID4gICAgICAg
ICAgZWxzZToNCj4gPiAgICAgICAgICAgICAgIyB1c2Ugc2NyaXB0c19wYXRoIHRvIGdldCBvZS1j
b3JlIGRpcmVjdG9yeQ0KPiA+ICAgICAgICAgICAgICBzZWxmLmdpdCA9IEdpdChvcy5wYXRoLmRp
cm5hbWUoc2NyaXB0c19wYXRoKSkNCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo=

