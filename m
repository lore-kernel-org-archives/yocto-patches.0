Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B442CD5BC8
	for <webhook@archiver.kernel.org>; Tue, 26 May 2026 12:55:35 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.36])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.36302.1779800122977735555
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 26 May 2026 05:55:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ericsson.com header.s=selector1 header.b=EtvwdZAb;
 spf=pass (domain: ericsson.com, ip: 52.101.70.36, mailfrom: daniel.turull@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipI9Bazl/odljhNockeppY0Jc+zowaTgCMnteepceMw781ym9dILTbP9If2Vz7douLQVTzEo2AFjks9/NeKCWu9kQCrfOrP+zb/xKPeVm3oKtv7ENR8aKRGoiGEz+JhXSNgCm5zuG4btzkCO5Io5Li1r4cMYcAHVgPYK7Njnx65wePTMVPhp8etGzU25vmPX+HWf+OcY6H1ufVYLr094chTqWxLRdGqLe99eyYDi4f4op2UXa+68WzysmXNLgENdFikPfif+YLdthLn8A3PVb7aW9Y6TxfnbpzDFyanwGvCPVgAiOquMgCBRAMRVQ031n883mL3kP2cszngrA9onPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLPdu1r/x+irrAmLIbvEpplUZZtVoOaHgfmHXT0jeKM=;
 b=iBkn9hZTwcjuWS9vzcbocdCWRjlK3/Y5C2RGcTJ96tM7tm18BvKioXrz4+uDwSt4dwShxTJX2jEvz1D3OPsX/5AwyJtwx0f0BeT5b71s1h1/YETPdynLs3Do/3z4gGzKMyAOqu4qSdN6C+MkqXt67omArOzp5CDG9aNLbALQuaxCyj1YArhVJ7qJ8L/m6zAFrE3y84WGIdJ6lSj5kntoc64lMxNN/1lO4pQT33aAQVoPgFWsX07Rm65dCDkNV0iBWCp5upmCOPeSkGpuLWMHexCeablKY+1waHlWVDJEAuJML7naJ7PnpzamookiRukQpvS8SssqQPyW1ZuMaTLB3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLPdu1r/x+irrAmLIbvEpplUZZtVoOaHgfmHXT0jeKM=;
 b=EtvwdZAbQkKopuhdIeAkGT4DMRIWMN3cMniJkxcHa7El6trNuXwEs4b3pTthXlcMk+eL0OMWrGdGu/Yss2HDjjvbY/ZpzUaTi+laz/nZstD6UKhe/tXLmRrDA4YkDJN0C7vioo3wI6boaqlrYXEwDBI9FEF+a0aonQ31Mc0TlxI0XEo+OyIIwYmc3ScLVjQ2IoGgi3tiM6/QhjDY5O1ZUsEbzPSCG329XFSmSPKxlC2oCosl/lnjmlJmyWL4fueVApB4bm1zPdSsVKUiqp70/ycDQFdqII/o3bMItcu43MHbTRP2KLY2h1bpg8kFcR+v761MZ6FYqBzJe4ETihjCcA==
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com (2603:10a6:102:4af::6)
 by PAXPR07MB8771.eurprd07.prod.outlook.com (2603:10a6:102:246::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 12:55:19 +0000
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7]) by PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7%7]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 12:55:19 +0000
From: Daniel Turull <daniel.turull@ericsson.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>, "Qi.Chen@windriver.com"
	<Qi.Chen@windriver.com>, "richard.purdie@linuxfoundation.org"
	<richard.purdie@linuxfoundation.org>
Subject: RE: [AUH] [PATCH v2 2/2] steps: include devtool changelog in upgrade
 report
Thread-Topic: [AUH] [PATCH v2 2/2] steps: include devtool changelog in upgrade
 report
Thread-Index: AQHc7DhqvLm669SexEW7l/hiNq5KX7YgGgAAgAArNYA=
Date: Tue, 26 May 2026 12:55:18 +0000
Message-ID: 
 <PA3PR07MB10721784EBE5B12A7A36458968A0B2@PA3PR07MB10721.eurprd07.prod.outlook.com>
References: <20260525111845.1018725-1-daniel.turull@ericsson.com>
 <20260525111845.1018725-2-daniel.turull@ericsson.com>
 <CANNYZj8KH+t_XV_0oyDJcKGmLtGMHUqsbTEL7EHPZ+SRU9yCNw@mail.gmail.com>
In-Reply-To: 
 <CANNYZj8KH+t_XV_0oyDJcKGmLtGMHUqsbTEL7EHPZ+SRU9yCNw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR07MB10721:EE_|PAXPR07MB8771:EE_
x-ms-office365-filtering-correlation-id: 36dcb2a2-5e68-4dda-c0bb-08debb260a5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|4143699003|11063799006|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 
 O4QyDMuoUM4Zj2do4yAfY7qFoztlfz3u/L1rqcJuWrrv0mBndI1KlfkHDXx1OMvfSYw6VN0qrRJdelDrrtmmnf22U5GNUBi1lBq8bktlNCf5MjhjP3OBrTpyEeAvqJ6KtmWvLzJ1xHdbDFPNkRHfvTPXSwFObheSlNqj5ye1WOnJ8kzvkyEYqWX6H1Bck2w9hdIRt9fbkLZzlgZmaOafFeq1x3r2AcecZIa5+pkK4fNNJ/ThwrOxwaGgUpUnJqK+y9zo0m3g9lZbu0WtlUHxgQGKBtk6f3Yx8xJE9cJCQcS+cRK1htyoSq2XU7Iy3GZuB/qmR2VX9VrAyOMVgWrUOQ+EuM33y9Zi03+v+Ya+cM0FlheF47H3euOIO6oFYDjCEDfAmCrV7cbsOe8tAXWqXD1JYVydBV7+kjqx+IxRpVYrP4ZGqASkBwp8M/obiGtr7OR5E+Mv98fwYa5nBgDTizTt8uLJgYfQarZoeG5Mpj7g7C3WcN43mNJoTEOdzYX4Uk5VfliFCsFeFSnukA7lETEMoAU3Had7gJH4fykgTaxaSZjmGznhRQ8JCBhVu70hdOaLBArhaLiu75iXrTAbUa2lXc51MMlKOHhsEtcYYRpv8edksEEfS/UrlUtRrKLRQCxDQudhysotzehbiKaXTaBA/cOr7t4OOH+P+wwhjNbfxFcf3fX8T3moCPVRFZcDyW3sH0Fn/+NtqIQ2yarHwrEniuZX6id2G960cAWZNGV4ErmNnftn8y+3a6Avxyvi
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR07MB10721.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(4143699003)(11063799006)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Vko3QmhtUlk2ZG9pU3pON0NPam5MYW9RNjBLZVcvdVQwWi9Qa2ZQbUJrVmtB?=
 =?utf-8?B?UTJZSVdQbWhsdi83aEJ0TlY2bXlvTm44T2VwaGxWK1piWVc5Vnp6UWw4aTZt?=
 =?utf-8?B?ek9McXJZWDFPd0RNZ3B5TzBFRDdMZnc2Y1hWWnJQRnU0UGtjNWM2SXU4RWZC?=
 =?utf-8?B?TExCM0N1RDRMWGlBMUs1TkZDMFBQWG5xR3VhN0ZpcXBlQXpMdUhHWTF4V3J6?=
 =?utf-8?B?R2hHMFphVE41NjJsdGx3anlkSGF6a2g3NElMKzI1YWhZOGlsMkloZVZjZDlz?=
 =?utf-8?B?NDJJUkpxVkJqRjBBSkRZZlQ3ajlQQmdXZ2U2UTI3UnRPSWhEbjVzNDhlY2VG?=
 =?utf-8?B?cVllN2lBdzd3UDZacEtWTWNLcndtMmhYU0Y4VGMxd09HNlJ0T1hOZjVReTFF?=
 =?utf-8?B?TEhJYXBSbTNLNWI2TzdTdGVGcjRhTVdXcDNrVmM0dkVSSzlUUmxBT2huR1hR?=
 =?utf-8?B?RDFIT1ViMlc4WmVpRkR1WWdvakZZWjN2aGFPM21mVFRBWUFlYk9lNml3THV5?=
 =?utf-8?B?RVZhNFg5OXMrWlU5aWE2VW00TnROWGFRUkFFN3FvYSswRDR4NXZJVG5JUjRJ?=
 =?utf-8?B?MmUyT2NqelFpYW50NktmZ3c5Vk5IUEhuR1N0YStOaTFRL2I0djNPUVA2bDFm?=
 =?utf-8?B?enNYT2RsQWx1QUdnS0E4ajU2eEhSYUV6U2NRYjRhSE1KODNBOTRTQmdMSHAx?=
 =?utf-8?B?dmthd095Y29KbVFEWk5UeUNsMXNSUHhNY1EvNFZwZzZUQ1pjU2ZZS0lUVTl1?=
 =?utf-8?B?ZDZNcFVteGNCa1V5d2NTem02NDNoQ2ppS1QvbUlHQ21vdUlLb0VDRWZBbVpD?=
 =?utf-8?B?RG9VVHN1MWNVZmRnY2JyMmVJcktHdWt5Z3hNNDc1VVRqQVFyNEJUUWNHeEYz?=
 =?utf-8?B?aTJIaTdZVE05NGJKdkR1bTg0S3NHMSthVzZZMkFBekhvZHdKR2xwaGVwb1pq?=
 =?utf-8?B?NERxb2ZjTWV3M1dHdktnRUQzamdjbVQvSWlHajltQnpqOHVia3lHRVdlWGY0?=
 =?utf-8?B?d0xuZ2xWMEQ1R09lVzg5Zk9FdjJRZXgwRmRKblV3cTNPaE4xNEJhd1ZOQzBY?=
 =?utf-8?B?K0NvL2JEYkQvYmhLY3BZeitCZHdwbkhEMjhIam1sajU5YVFWTy9Hc2Z6ZHpl?=
 =?utf-8?B?a0t6ejRpK05hM0tZeFMrZXZWZVIzK3ZOZ25iSnVweXBnM3A2MmpTcDg4cERn?=
 =?utf-8?B?WlpaT0JLcm1nendwVWFGdUFUL1RHY3ZUMFRBUXNsc2Nrdzl4WGhGNVR5TFZy?=
 =?utf-8?B?VXI2R09IVXJ6cHF3Zm8xbG11Nzd6ZEhKcXlpN3FvT1Vra3craUFsQ0ZKaU5W?=
 =?utf-8?B?MWdUUmViYW1FUG9oVVFBY0creHRtdmRFenlrZldwVjhsTnYzVzkvRmlhem05?=
 =?utf-8?B?c21naEFmRWpQaVg2UjF3UnI4MmN4cWE5T2pPaTErYUcrTlVqZGx4eHpmNjhI?=
 =?utf-8?B?VU5lSGZoeUpvc1ltdkszUnc5QjU2K2dBYkNHZ2k0QjNtKzVCVitzcUZpdVQ4?=
 =?utf-8?B?NDFqVFBZNDNlVTVGRnNXK1R6Rmg1a2JhZlprRmFnZlNibm9OYS9MWVdNYzlo?=
 =?utf-8?B?VHZUMitjR0pFV0p1amg1bldkWnhqK1lSWXZ3MWtvbW1pbTVMNDdiT0VLUStE?=
 =?utf-8?B?RFo1Vy9iQTRmdnMvTjNlL0FORGdPeG1xWHVkVnVzM0ZXZHhheTFiTE1EUjBV?=
 =?utf-8?B?ZTY1RVYyQXdvRkxScGJuTzVJNWVBM2pQanMzaThWL2hlbnc3cUVKQi9zVEMr?=
 =?utf-8?B?WDlHa1ZSMk9KYW5MVXBxZ0xDN2JxcjVITDN0Ny85SkpJc0lsSVh4YlFWcEQ0?=
 =?utf-8?B?eHhwNVA2SDZMcXRnTnZkdzRrM2l4L1RNZm9id1pOVkd5NGxxWkIxdmZUZk1V?=
 =?utf-8?B?WFc1ZEh5TlZzemFKYlQwQlFidDF6Sk41eXNvVzh5SDhTK1I3b3NNSzJVOHVh?=
 =?utf-8?B?RHlIWEZ0TWJibGRScENpd3NLWjUxZTBJNU1OWEJnRGJDMVFDMDJzckZ3ZjBQ?=
 =?utf-8?B?L0pUYlhDYWJRS2JlZmdkcEJCNXR5VDUvY2I4bGpGQ1d5dnExRms1Q0lpS3d6?=
 =?utf-8?B?SGg4YXVGeUl0RHNnUm9Dd3hmZjIvTGtiNHZMQnJFL1ZVSExXdGdOeHhBbUZX?=
 =?utf-8?B?V2lwTk9hbEdrcUpYNjNaYWswN3A5QXdIQ3FRd1l2NFdsY05JaTdxS1BqZFR2?=
 =?utf-8?B?Qk9pQVhxeG1NTlFLamJvalVCMkxsWWI2Sm02RU1HUnB1VFFsWkxxWjFNMWlZ?=
 =?utf-8?B?aWJDVVQzbnQvcmM3bFQ1c0U0M3gxMzVFTTNpNWhNL2t6RkRhczhjR0ZIc1Aw?=
 =?utf-8?B?OWhIODRTaVkxZDI5cjNlRnJGZmEzN0NkWmxNRlJRcFFtb1NqYWJPQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR07MB10721.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36dcb2a2-5e68-4dda-c0bb-08debb260a5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 12:55:18.9576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BbTHdddHhVy1Bfpo1sv+6tcz2V23ZCdX0ew+5Vc84AX7oB8/VwzYxt4n5J/6S31UAoJWk/3/VxSXXsyMmYb5wVfRL1cseKtMNBk3YReBTTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB8771
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 26 May 2026 12:55:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4056

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleGFuZGVyIEthbmF2
aW4gPGFsZXgua2FuYXZpbkBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIDI2IE1heSAyMDI2
IDEyOjIwDQo+IFRvOiBEYW5pZWwgVHVydWxsIDxkYW5pZWwudHVydWxsQGVyaWNzc29uLmNvbT4N
Cj4gQ2M6IHlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZzsgUWkuQ2hlbkB3aW5k
cml2ZXIuY29tOw0KPiByaWNoYXJkLnB1cmRpZUBsaW51eGZvdW5kYXRpb24ub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbQVVIXSBbUEFUQ0ggdjIgMi8yXSBzdGVwczogaW5jbHVkZSBkZXZ0b29sIGNoYW5n
ZWxvZyBpbiB1cGdyYWRlDQo+IHJlcG9ydA0KPiANCj4gT24gTW9uLCAyNSBNYXkgMjAyNiBhdCAx
MzoxOSwgPGRhbmllbC50dXJ1bGxAZXJpY3Nzb24uY29tPiB3cm90ZToNCj4gPiArICAgICAgICAg
ICAgdGV4dCA9IHRleHRbOm1heF9sZW5dICsgIlxuXG5bLi4uIGNoYW5nZWxvZyB0cnVuY2F0ZWQg
Li4uXSINCj4gDQo+IEkgdGhpbmsgdGhpcyBjb3VsZCBzYXkgbW9yZToNCj4gDQo+IENoYW5nZWxv
ZyB0cnVuY2F0ZWQgYXMgaXQgZXhjZWVkcyB7bWF4X2xlbn0gY2hhcmFjdGVyczsgdGhlIGZ1bGwN
Cj4gY2hhbmdlbG9nIGNhbiBiZSBmb3VuZCBpbiBhbiBhdHRhY2htZW50IHRvIHRoZSBBVUggZW1h
aWwuDQo+IA0KDQpTdXJlLiBJJ2xsIGNoYW5nZSBpdCBpbiBhIHYzIG9mIHRoZSBwYXRjaC4NCj4g
QWxleA0K

