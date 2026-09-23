Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E4BC982EA
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 09:06:13 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.24])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2777.1790154370162790908
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Sep 2026 02:06:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ericsson.com header.s=selector2 header.b=X1YarUhN;
 spf=pass (domain: ericsson.com, ip: 52.101.70.24, mailfrom: daniel.turull@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jz+SlOI4+DYYXLz+aKCNsyPYWxl/ngUC80g/vTERHEY+yETxZ+tKt6L6Pu+sR/7IUdTkYGfkKjA1DqAqgqmSWHi9Ld8neOtB25YCNDEOE28BOYH+pXnQ1KhspUC8eBPDTi1GdmqAx58PsGLZrssK9/eQK54i64TI0R4ZhVEKcGzSmmKKDF6c4ltqzwzm2hFMtjj5o5bFFuwQRYV3zWK7LXC5H5+Bl1O3ik4XApaB15Y2AFNaoMOEcYjrXLq//Hz1ifOOgZaSTjcXWtMkhVxlt5l7lswjrED0lucGmICsgGzeVFsPMAeBxltoKv+u4MvziLz5xLCqjNN3gK5e7KI6Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBpBBwFAH7fZq+aatCaZoKQmkvIuWYJgh18HDZQ2eJQ=;
 b=H0uVHxzv1+alEEMcwhtd0b56iex+A5tDBGBuVyfEi0jjJRCwhDj2YxsMyT4rklBrqu9jN3Jh/4VklFrbu1SKcYHx8+4K3pN/4Z9FttbV9z/AzJoRVSMWIX3dZKa4cAoEMLt3k3+Lze2H2q08dDll8/X7nN2INpGYhR7v/E3my2nOSCSg5JzfuM2omo8aeH9XglWriz8SbKW8cKhwHq6r+7YR1+rhlgVxFnNe0nSUjnFOM93Whs5ZDrwieb2wuEgdCrrXxlYMtrMx4G1Mfc04KRjgF4M3b8ezgS1OkeAj+5UraMmdZsVjzyNHkDQ2y9u1Kpce76LnDwpeP9Mx/4lqyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBpBBwFAH7fZq+aatCaZoKQmkvIuWYJgh18HDZQ2eJQ=;
 b=X1YarUhNfHbRaf+SBpj8EIxB/u6aXvOZaG5fWqZ1QeiBvLxMWZMYlsK3TvgMukc4taB8bBF0E9amh9udsYVdpC1+WA/1rMN0euD2t7iUb5iD0EB+kbyhYcyepNV7x/5LPRd7Ta6ltJAn/RnRBLKq1wfu/XFAgCdNW4lwaojBGYrZBBLPkgfaNA+gqZyhkCMFaHXE+jaz6JLTERpFK0IM8ZpcpmJs8Zm8fNtk7rBlfRdwIygU3fguiZQQjrLsdyq82YcySXwSztYzvs7aQOxSjr5FnpBfatH+cUI9hmvkNjbXpGbwekatdvV1xfISA8qzviU2cwZF/gvSVg0jpO2Lhg==
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com (2603:10a6:102:4af::6)
 by AS5PR07MB10497.eurprd07.prod.outlook.com (2603:10a6:20b:6c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 09:06:06 +0000
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7]) by PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7%2]) with mapi id 15.21.0428.015; Wed, 23 Sep 2026
 09:06:06 +0000
From: Daniel Turull <daniel.turull@ericsson.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
Subject: Re: [auh][PATCH v2 1/2] steps: skip duplicate changelog for
 shared-source recipes
Thread-Topic: [auh][PATCH v2 1/2] steps: skip duplicate changelog for
 shared-source recipes
Thread-Index: AQHdSzlWNyjrfqeBIEKaZAlE9+wef7bb3xSA
Date: Wed, 23 Sep 2026 09:06:06 +0000
Message-ID: <cf408d794ae1149af198fa0acb1e9d9d1ac87755.camel@ericsson.com>
References: <20260923085528.88881-1-daniel.turull@ericsson.com>
In-Reply-To: <20260923085528.88881-1-daniel.turull@ericsson.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR07MB10721:EE_|AS5PR07MB10497:EE_
x-ms-office365-filtering-correlation-id: 31b54fb9-ad2d-41b4-fc66-08df1951e696
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: 
 /quY+KBiQneamR6PWN246QWFJDixFMTne536WavpQoW14WaB/ff92RRMXu98OxrCf1qUwFFb83W9RvZjxGSca0xkY9INzzXk1DQaW6zWBXxuJJOBHuFJJEe7HYmyhzmD3EP9TuV05zU1LKzL8U5jpWbxl9G3kAdTmdCLONRSTx6RwgOzseHC7tMCv0rNm+++tMH5rL+tfgQcUSHgt0cdjDaKAOR/aMS2fKhphO2TL7S0V+DczJjGm59GjKe+ydCWkL+gKEh7oVdUsIQGpMYPu0dAJy326mSwMPXhmW8cxIXo3HUXsnJVLSAfbH1A/MSS4ObJjYmez1bgRy50ankXH34EXzTgnwjMTzHzFtYJ5P/MXganjjjlBUTa1jGRTJrXu6o7Iv684LcRAwHppP+O8Ttp9GttprAIkWRW401L3Z/LMlvnP9K/2/sj2GAjr4uTadQzAHQfvgtW+EETt7xTzu0Lb6D62sbBn8/8DcXwH98ijeEeYiPjyiWnZzjgYzciwOgfBPgYoudgQnoqMJzHDCrZAI4QDQeSwsqBsR6eun+UCmwuk7jFD7Ph0oDsDGKBXXy5olgq0F7VArqMUq+jdQceemBKum02wEaHdUd88zpQRyM6N45UA//u7J9wQqGyk8Z84GV5E76A+ukUGZvzbKwujj4yAOCZEleiRE/JEijWAI/OiLH8M75HhdINY4NYki9Wq93lpZtnA7TMA9X1V3o4QGChbmhRNf7cBVq/vkI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR07MB10721.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aCtIVTlQVWwvWmJnYkluOGRwanZpdXZabHFETU9XYVQyNWhIUW44SjdQZHIx?=
 =?utf-8?B?WmlFcnlsa05lNFlCL0orWGo3aTNrMFZGRnZYRDRqVFFZbk9lUmtieFVsaGlE?=
 =?utf-8?B?Y2ttUlM5SWlLbVZoV01abnJ5UUJhOXNmNloydmVUQVJVTEN3ZkM0dW80Ym1I?=
 =?utf-8?B?alhJTnFKc284WGxUdkNFTFVUdmN1ZTNEWWJrK05UVW1FTjJ6UzdaSk1PbEJB?=
 =?utf-8?B?WWdxckdhY3l1WkFCVk40TXVvRUpWZnpnVGFXdk1UazluV2NBRmR1dEROODgx?=
 =?utf-8?B?MlRKWElJUElkV3pCd3AyYnRMa2RnN1RPcG9PNVBTS1ZRTEFFSWNxbW02cG5m?=
 =?utf-8?B?SzZ6a0MvTk4wVXZ0d2xNNnlqa1FyeVhhanpwdlhqU1ZTNFZGczNNTWhNdk12?=
 =?utf-8?B?WW9CTnd2Y0tNMHAySWNadE9QV3lQM3RvZjZNSGpVQkRrMzBWUzNBWTM3TW1H?=
 =?utf-8?B?WDN4MHJGTWhlTFFCMlVFbFcyQ2NSdmh3UEwyNXArWWRXQ0Y4MSsyMUljZ2dw?=
 =?utf-8?B?ZHlWUkFEU0dTUlJqdGVqK2JkM2hQU2Y1YUs0WCs2YkZwKzU3VG5PUGcvbklJ?=
 =?utf-8?B?dURLOFErMmVqeTRibjIvNmR4Q2RrZ0NkLyt0cm5aTWI5TnlQbEk4VmZQcXhL?=
 =?utf-8?B?WFF5RmVDOER2TGxYNitJMXF2VTRlOExvOGMxakdUclpkWC95b2w1ZDdpK281?=
 =?utf-8?B?dXNzQW5EdmFLZkY4cVRQelZzNnhPLzZHZWl1QUVwRUd0MFhxNjlaZ2xMdkJF?=
 =?utf-8?B?TksrREFaZnhLWlM5c0dvZ3FramRHZTFNMUxuWHdrQzRaVGVWd2JtbFNNUGZk?=
 =?utf-8?B?WmpmcnVIZ1lZVHduUTRXSWI0UXVpUEsxMzl5ei84YTg0eWM2VERNL1JXcUlU?=
 =?utf-8?B?bHR3M2JWT2ErS1l0cVVKRDdpSEFLMUZzVlU3N3MxOXVwMEhzWi9YRGsyTHdZ?=
 =?utf-8?B?c3l3V0dYNDhrdnF1eWp5ZnowdVZqeGdDeTBISzh4aFpxU3czME1ob2tWMWVy?=
 =?utf-8?B?d2VFU2orOEJLaER1UkE1em83V0Q0akI5OHRjTy90MkgwUk5BQytOQjRtK21L?=
 =?utf-8?B?MWRCNmt0UG1wblNxemlxcWdlM1RnZHNHb3doN0xncm16Q1JVSzY5WkxFL3lv?=
 =?utf-8?B?YnJNNHdDc2FNUUtwSExSRElSTjVLcE85UEdoRGdJL2d0K3JtMis2SS9yT2Ev?=
 =?utf-8?B?WkIzckJnYUtUMHh6ZzhDWVJaVldSV2FSeldSdWRCU2dWc01jN0JsSWlsNWI2?=
 =?utf-8?B?TlYwWEorMFRtOFZaa3VsRG0xaHJ0SHE5Y0o0VWRMOUppRGpucHc0RFF6djYr?=
 =?utf-8?B?aGZraW0rWUZFSUhJbTRDbnpuUFpITzhQdllVdWZDZ0hidGxCVTR0M2ZSczdH?=
 =?utf-8?B?Q3hWQnNNeGNwVW81WG1ML1cxVjNvNi9xVFlPUnNhbFFQK3FVVUR6ZVVOOTdl?=
 =?utf-8?B?bGUrN3JuWk1KVzZFc0paL0pzLzQ1N1YyUDJQYXNzUmV1NzVuc3U5cWpNMDlU?=
 =?utf-8?B?OVJ6TENTOWR0M01rQnQzRm5DdTd3L1pxVDdDUGZyV2w1emlLY1dGeW80eHlz?=
 =?utf-8?B?OTl6TXhWUDVBNTVyVWdQTXk5OGR1VXVlbTdZeHpvcm13enY1dVVrRDNJaUN6?=
 =?utf-8?B?U1AzbkVqSzFjaGJRZ2RqQ2J1TldiMEswWXpYS2FPV293TFZITExDa2QrL2d2?=
 =?utf-8?B?bjZoeTRWUGJUdmhZblFVREJ5Vi8vd1BhQUhIaDgrTFhtN1pvVGU1aWQ0cUlL?=
 =?utf-8?B?d2tUVk9hWGlYRkdXV2NtV0hpa2tiK0xsUlJQQ2xBNjVnYWIzRTQ2WWovQTA5?=
 =?utf-8?B?aGlVQ1UrWmxQSk4rZ1dOR1pjaUVuK1FIa05KU3pBMHh5Q1ZBZjM3S2dNKzBn?=
 =?utf-8?B?SzRwaCtOaXlSVEVnUkF1QlRESlNna3Rldyt1ZUIwUVBhelRwZzF1bGlEMlJo?=
 =?utf-8?B?RE5PZGhxa2R6cWRRSEQwdkVQM01raWcveTdpZWZkdnJSZGV0MGVPRTN6R3lG?=
 =?utf-8?B?TCtMY0tqTitYRlZMUWhvZU9aOGhDYUtiOGovMW1DNlZkT2pwazExcHZqNkJI?=
 =?utf-8?B?am1zY3ZoOTg5NDJ0LzJ6SjlObTFMK0VKYlV2VHhrTjREM3pTc3creDZtaXVi?=
 =?utf-8?B?b29BSWNBWGY4dCtIQWdXU3JYNU9UNDQwNHlHeUVXV0FaNHRzUGpjT1VOZ2c5?=
 =?utf-8?B?U0phRmNtWEpBRThJaUh1MEpGNklMakdxUUNyWlVlUVlpSlNkOFZnSVV5ektW?=
 =?utf-8?B?U0xuOXlmU21MNFg4QmNXTW1XbGcrczBKVndxODk5ZlcxT0lFNmRZaHBNbHVw?=
 =?utf-8?B?UGJ5WHRDQlpMYzliTFBjVHVOUDNQTXZMb0JhdDVnN1dXREplSUQwUnZoeVkx?=
 =?utf-8?Q?VP4FPlndua9hdr/g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DFDBE4840ECC94A825A371E897D8F3A@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR07MB10721.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b54fb9-ad2d-41b4-fc66-08df1951e696
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 09:06:06.1237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yn2c3nJRj9UV/PeKjnNKDIUJRGdbl/3F3MeFQoaeJLMfQ+4TpmFudaWguRj3U05vG2Hw+k1SPbh2HpNNmJNIMi0pUTuqu+zbG3HpjB1jK+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB10497
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 09:06:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4938

T24gV2VkLCAyMDI2LTA5LTIzIGF0IDEwOjU1ICswMjAwLCBkYW5pZWwudHVydWxsQGVyaWNzc29u
LmNvbSB3cm90ZToNCj4gRnJvbTogRGFuaWVsIFR1cnVsbCA8ZGFuaWVsLnR1cnVsbEBlcmljc3Nv
bi5jb20+DQo+IA0KPiAtIEdyb3VwcyBjYW4gbWl4IHJlY2lwZXMgZnJvbSBkaWZmZXJlbnQgc291
cmNlcyAoZS5nLiBnc3RyZWFtZXINCj4gICBwbHVnaW5zKSwgc28gZmV0Y2ggZWFjaCByZWNpcGUn
cyBjaGFuZ2Vsb2csIG5vdCBqdXN0IHRoZSBmaXJzdC4NCj4gLSBSZWNpcGVzIHNoYXJpbmcgYSBz
b3VyY2UgKGUuZy4gbWVzYSwgbWVzYS1uYXRpdmUpIHByb2R1Y2UgaWRlbnRpY2FsDQo+ICAgY2hh
bmdlbG9nczsgb25seSBhcHBlbmQgcHJvdmVuIGR1cGxpY2F0ZXMgb25jZSB0byB0aGUgY29tbWl0
IG1lc3NhZ2UuDQo+IA0KPiBBc3Npc3RlZC1ieToga2lybzpjbGF1ZGUtc29ubmV0LTUNCj4gU2ln
bmVkLW9mZi1ieTogRGFuaWVsIFR1cnVsbCA8ZGFuaWVsLnR1cnVsbEBlcmljc3Nvbi5jb20+DQo+
IA0KPiAtLS0NCj4gdjI6IGNoYW5nZSBsb2dpYyB0byBmaW5kIGR1cGxpY2F0ZXMgYW5kIG9ubHkg
YWRkIGlmIHRoZSBjaGFuZ2Vsb2cgaXMNCj4gbm90IHNlZW4gYmVmb3JlDQo+IC0tLQ0KPiAgbW9k
dWxlcy9zdGVwcy5weSB8IDYgKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25z
KCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbW9kdWxlcy9zdGVwcy5weSBiL21vZHVsZXMvc3RlcHMu
cHkNCj4gaW5kZXggODM1Y2I2MC4uZTY3OGE0YiAxMDA2NDQNCj4gLS0tIGEvbW9kdWxlcy9zdGVw
cy5weQ0KPiArKysgYi9tb2R1bGVzL3N0ZXBzLnB5DQo+IEBAIC05OCwxMCArOTgsMTYgQEAgZGVm
IF9nZXRfY2hhbmdlbG9nKHBuLCB3b3JrZGlyKToNCj4gIA0KPiAgZGVmIF9hcHBlbmRfY2hhbmdl
bG9nX3RvX2NvbW1pdF9tc2coZ3JvdXAsIG9wdHMpOg0KPiAgICAgIG1heF9sZW4gPSBpbnQob3B0
c1snY2hhbmdlbG9nX21heF9sZW4nXSkNCj4gKyAgICBzZWVuID0gc2V0KCkNCj4gICAgICBmb3Ig
cCBpbiBncm91cFsncGtncyddOg0KPiAgICAgICAgICBpZiAnY2hhbmdlbG9nX3RleHQnIG5vdCBp
biBwOg0KPiAgICAgICAgICAgICAgY29udGludWUNCj4gICAgICAgICAgdGV4dCA9IHBbJ2NoYW5n
ZWxvZ190ZXh0J10uc3RyaXAoKQ0KPiArICAgICAgICAjIEdyb3VwIHJlY2lwZXMgbWF5IHNoYXJl
IGEgc291cmNlIGFuZCBwcm9kdWNlIGlkZW50aWNhbCBjaGFuZ2Vsb2dzDQo+ICsgICAgICAgICMg
KGUuZy4gbWVzYSwgbWVzYS1uYXRpdmUpOyBza2lwIHByb3ZlbiBkdXBsaWNhdGVzLCBrZWVwIHRo
ZSByZXN0Lg0KPiArICAgICAgICBpZiB0ZXh0IGluIHNlZW46DQo+ICsgICAgICAgICAgICBjb250
aW51ZQ0KPiArICAgICAgICBzZWVuLmFkZCh0ZXh0KQ0KPiAgICAgICAgICBpZiBsZW4odGV4dCkg
PiBtYXhfbGVuOg0KPiAgICAgICAgICAgICAgdGV4dCA9ICh0ZXh0WzptYXhfbGVuXSArICJcblxu
W0NoYW5nZWxvZyB0cnVuY2F0ZWQgYXMgaXQgZXhjZWVkcyB7fSBjaGFyYWN0ZXJzOyBcbiINCj4g
ICAgICAgICAgICAgICAgICAgICAgInRoZSBmdWxsIGNoYW5nZWxvZyBjYW4gYmUgZm91bmQgaW4g
YW4gYXR0YWNobWVudCB0byB0aGUgQVVIIGVtYWlsXSIuZm9ybWF0KG1heF9sZW4pKQ0KDQpUaGUg
cGF0Y2ggd2lsbCB3b3JrIHdoZW4gdGhlIG9lLQ0KcGF0Y2jCoGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL29wZW5lbWJlZGRlZC1jb3JlLzIwMjYwOTE4MTIwMTI1Ljc3MDYwNC0xLWRhbmllbC50dXJ1
bGxAZXJpY3Nzb24uY29tLw0KDQp0aGF0IEkgc2VuZCB0byBjcmVhdGUgdGhlIG1ldGFkYXRhIGlz
IG1lcmdlZC4gVW50aWwgdGhlbiB0aGUgZmlsZXMgYXJlIHNsaWdodGx5DQpkaWZmZXJlbnQgd2l0
aCB0aGUgY2hhbmdlbG9nIHNpbmNlIHRoZSByZWNpcGUgaXMgb24gaXQuDQoNCkRhbmllbA0K

