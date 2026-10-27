Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13302.1793083149368953451
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Oct 2026 23:39:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ericsson.com header.s=selector2 header.b=mNAHz090;
 spf=pass (domain: ericsson.com, ip: 52.101.65.56, mailfrom: daniel.turull@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y095NuokNiTD/2B1DeMP1rUQPcO8HoUDmX4CJ4fq9BmwoTgjJrQKpCx53/oE4pLCDv0hD1ilf6wUsYi7gUgYECh42PUWKmxPzPJa7K2KH9pFt+w1zHGvpXDXROU4de4wYOcplxZ+TyHJxZBbD+jjF6lZqZOwe0WUXLD+X8bpxiI9ANhL4WASogsnbHH/H06OMochjZerK6DNYSJ824bYT7i+udU5thcbKUpx/VfUIl7zJT0ckdD6fc1h4fwNOBxGJWSFv1YlkC+rtdEM36biVFpkFVmoiKzJwkO/2pn9QYdME3dT70jC/ne4beThjuwCqkramfGjQpTcpwm5V/Z69g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LyOn78n0ltfynoOuBF51eeXMzUNV9nyXMinVoyZSag=;
 b=TTjOmn7herArI+xLkGx1rnW8vEkeTF5OSdjpHU1S9s+99nJbGgbtHHQmty1QSFL8UYpFju44o2/EZqI2Md+XfXE3fIB99mSn9MPc58gGrZoGtQtdmiA24LB2yZQvTNKH4xx1i5NgWuXEJ1K2yk4c9tXQZTam/2bkoDnmKb4miVdeoyXu2PXSNj4A1qcRi9cyWg14AY5cioqYHai8Zvrs/4FrLir0kY10Mhol6OXX4+wlEjC+8cWgrBHuaTCWjZWhP+2pCzWqzHAab28QC8vKSyDZlrir6nWgt5hZeCt7Z1nk36UOvTGEs+dkMKs2XQqefi8hyt4Eq7tx9MumBlPz+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LyOn78n0ltfynoOuBF51eeXMzUNV9nyXMinVoyZSag=;
 b=mNAHz090fOU3LEPUaJ/577THokTfDwsAnct9bhpz9O0DSz4H2jJn6wuGW5rgL67Bj9Jkg6IoLzPM0HWFla3X0CV4O3CAA99Yz3ciHiS2hyBqLaiQpbvgp7kINkp4/XJEZ5fZiBjBuYBEdX2pV8E9qgAlo8tnVKXb+k84yjUAwzwrIu1IErWoVX7ZdLRdhm00DuaFka8yLlIl2Oh/qEEgaOZlItjWHicQNOcf8qbqmwDBt9TZPu4U0nxI+xWb77ygaVdw+9OBVv1TZGpH3nFoZ+Kz7bhFBaoNS5UwKvCJIA0RJcFKEsZurDYQBK4+j31I5Y8WUatrq8ATw5F+GrVb1Q==
Received: from AM7PR07MB6437.eurprd07.prod.outlook.com (2603:10a6:20b:140::11)
 by GV2PR07MB650701.eurprd07.prod.outlook.com (2603:10a6:150:3b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 06:39:05 +0000
Received: from AM7PR07MB6437.eurprd07.prod.outlook.com
 ([fe80::fb9c:237c:ec12:2db0]) by AM7PR07MB6437.eurprd07.prod.outlook.com
 ([fe80::fb9c:237c:ec12:2db0%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 06:39:04 +0000
From: Daniel Turull <daniel.turull@ericsson.com>
To: "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
CC: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: Re: [AUH][PATCH v3 1/2] steps: refactor _get_changelog to update
 pkg_ctx
Thread-Topic: [AUH][PATCH v3 1/2] steps: refactor _get_changelog to update
 pkg_ctx
Thread-Index: AQHdZVGD7W8u7MSsmEajJV2TYvGqILcQFuMAgADaMIA=
Date: Tue, 27 Oct 2026 06:39:04 +0000
Message-ID: <3254ceddc86ebc299f78190d04176be037d1fba9.camel@ericsson.com>
References: <20261026135414.3796371-1-daniel.turull@ericsson.com>
	 <CANNYZj_LbDRhghETUXXVYWfLzvjOLV5GY4ZZ19tXz8J_vFoJyw@mail.gmail.com>
In-Reply-To: <CANNYZj_LbDRhghETUXXVYWfLzvjOLV5GY4ZZ19tXz8J_vFoJyw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR07MB6437:EE_|GV2PR07MB650701:EE_
x-ms-office365-filtering-correlation-id: 045748b8-2cf8-4cf2-5ff3-08df33f4fe9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|10070799003|376014|261022105027099003|10067099003|56012099006|18002099003|22082099003|11063799006|4143699003|261026140227099003|38070700021;
x-microsoft-antispam-message-info: FrCxR0mi8uVWoPRRf2DvPvT1+sbuL5JsAjvD0R5bXMmUt+DX/doqIAoBFFXxMWSPBUFegCEZ5y8wbT9/mVexczvQ+BySKtB4DHrkZriSp3C30rPBV3fCXByhZ3pjF2dLSXv6f9SnEh5gw0O8devYrWWqNB7CIvLW4QGMA0Z92ze2y9e28DKlYG04tfK8YcN+kxUkgaWdCJY0TlwOlbqYXE9UReKFGW0P98vqaVrhgxqD+9kiEUraMRNbqWtHBRX59oFwmOSkGTpsdX2FxJHWdjxa8DIKJA+PONF9jhWqDLGZluQaFUAflkHTvlelpHN23RN8NCYibZcK21BLBVttrE3Jx5ROFFMiMl3JP82ru5l75X7kQvLOMpJ/cCUMPCCNzYY+A1aRsV1Lk6MLldP9LjQsfFOBBgj6CJHBQk/QrbFvWO0Xaxc/xjvKEznTOS/WjKj9/6wU4M1sY0QYsSYhWL5cCqR1Y/yhfi01slFdxXTuV2UsribzBu8FwF/Y6mORjLfJXb29lwyLIkzuhkF3xm+K/4IjPf7+05dwMaVCz0QnU0rCa7wFAcJKrTr8sSX6rdPGHiMF4gzKXCXu2LI25/zKL05Br4Y6adtR6L06yMUBOhw2QoNGuFcwITRQz+czKBcewGqDTnfWiiGn/o60yc9tDt7ug7tVz1zZV+3Ujvp/69Z48iEoyC5lYRmDwKpoq+SWmc5/Fb9XjjA79Ki0H1XFvcAaUSJQUGzXO2YoGDU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR07MB6437.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(10070799003)(376014)(261022105027099003)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006)(4143699003)(261026140227099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVlLT3lIZHVMMzhWbnF1UlN4TG9oOHAvMWNtbUF3dm1aZi9wdUd1VTlRRXhp?=
 =?utf-8?B?NGFvUXo5Z2d1U24wdlhXYlZ6dXlFNVVVdmVRZUQ3V3E3ejcyVDNlYXNFVFhk?=
 =?utf-8?B?TEJ2aEVBN0RvUW5XNXExdjhFR2JpYUg3cE1JMHdKekZmb0VrWjk4dTc3eGQ1?=
 =?utf-8?B?TUx0aFpqWkZrNHBnMUdwZldLdEtFc0xmdTFRQVZhK3JaU01YM1NlVkoyYW9n?=
 =?utf-8?B?ME5lWFhOSGRGZ1ZDdG02aC9WSGFXcDk5dTkzMG9wMStIeUxBUGVKVE16T2xq?=
 =?utf-8?B?Q2p6NkJhWmpGOWxmakdhMGdLTFI2andSOUFJUjRiOGZRTUVnSzlFb3FaTStx?=
 =?utf-8?B?MU13K3l4Ri91enRTNzJXazUyL1FNc0pBYnNYSkFsWDR4dFMxQnd0WVkrVlJk?=
 =?utf-8?B?UmVKdG9FcHBCSUpXZ2hxUGJMM0IrVUw3L080b0p0RjdQTjhPNnVydkQyT3NW?=
 =?utf-8?B?NWtoUjQ4OGZZSlR0ak55dExEamVXeVorNVpVYU50L2RqMVVKYmNReUNMUWlq?=
 =?utf-8?B?Vm9VSjJxQ0FCVVBzY0RJZWdNblQ3ems4d2xEUWJidjFvdlpaNW9RQXorZzQx?=
 =?utf-8?B?MXhxUXhUazlZT3p5OHM0MVo2Vkd2ZTZPRzF3SWs0dW9lRWJhaU5OUlVueXhs?=
 =?utf-8?B?ZSsvVURzTnBYSFMveDBpZlNjeFZ6Q3RkajgwM1RFUTZkR1hqeCt3QlBFMXZ6?=
 =?utf-8?B?MEc3QmNINEZLK2gwTmZoUUpvd1h3Z0txUHNVZklxNjJpZHNET2REaDVWcVRv?=
 =?utf-8?B?Qlg1RDMvU2lwQUpXVDVXaTdkOUlRZDBPVlBPek8wUTNtUnNqcGpIc25MTCt4?=
 =?utf-8?B?WUFEd0Z3b1VQN3dCbHdrRGNzNE1SRFo1Q0FBaUhvMXcvK3lCc2NUZ1RMVy8x?=
 =?utf-8?B?ck9RQno3blZTN01uZ0JQYmROY2VSOWtSQXlOMzdTYkVQa0JXTVB5Q2RqYmJM?=
 =?utf-8?B?UFYvcWF5NVBNejBReGFrN3ZXMjgrZFZ2YkkveCt3QnVMcHFMcTBnODlFY21W?=
 =?utf-8?B?UmgyWi9NVGphcE9QUjcweDVoK0tvSE9mVUhIcmVORE9BOFJydktsWDZNWUNm?=
 =?utf-8?B?VDlCUnJySEx1RVhGNWltNUVtaTdOdmhsaTZBdnRTaXNINTIxdTlhMVJJb29t?=
 =?utf-8?B?R2hFN3BGMXdBcytzaEd5Y3BTSlR5VnlVbk5zcTdGSGRPZzlwcmZGNlNDc3FL?=
 =?utf-8?B?TUkyQzI4RW5wMHB3N01GdEUzNzVvbEduRnJDYmVIOHdBekdzSys3U1cweUdO?=
 =?utf-8?B?MEQwbU4zSDFrWU1UTHVrZUFTN3NkY2VXNW5HaXFHVmlJZkFFYnk0eG1PTjla?=
 =?utf-8?B?d2JJTmtiMFUraEIwUkQwckRIbGVwaXRzYTBiM0dxdUthVlRSYlhRdXZCd01E?=
 =?utf-8?B?eXd4ZUFPZUFmeDR1MG51ZDBxMEg3b3Flb2xaMGp0RkxQMzdZY1d3dG5MWjdE?=
 =?utf-8?B?U3pndmRGSXRiNTZpUm9yZk9zZldxZ0VMWFY5SjMxbHU5NXBQcTdVQndpNDB6?=
 =?utf-8?B?dTNMVHZqYWRuK3kwZjJaZ0JydXgzV3M5NDZpUURKMDVTdjdYTnFPamp3OFlX?=
 =?utf-8?B?Wjd3dm9VaEJyL3JEdmp4a3BwdGhJb1VTMVFVWU5Qa1J0YlV6NUxmOTdMLzRK?=
 =?utf-8?B?Ri9NT05WK3NVT3hNTTdBRWNTaStkTmdEM0hrOXJ0czBLSzlyRnFvL0NWTjln?=
 =?utf-8?B?TU5oMU44WGFFMVA2ajU1bnptUGd2ckliNjNvbkhhLzFCdVprWkNhZ3FpQ2xj?=
 =?utf-8?B?VkhUMThXS2ZmaUh3TVNoK2wwTm96cm5oU1c0c0tsQVZpam5TSGlIdU95WGkx?=
 =?utf-8?B?Z1hSNWlaZEcvVk9zNEJFRlI1VS9rZlhRYkNYelgxUjBLNWQ5SHptNjN5NmY2?=
 =?utf-8?B?ZEJBUlRJL1QyOHBBVTVVOU12OWh6clNhcmpYWkpCaWQvRjgyK0RZSmZ2clBW?=
 =?utf-8?B?M1RsZnFObSt6ZjZVcXkvQmpQSXl5TWtVQWM2WjNlVHQ1UEI0VkdSVGpCa0p0?=
 =?utf-8?B?MTlyTC9wYkZVTnJ4TWV3Y3V4SjA3T3REL0xWN3ZxSUp5VmlNeUxiSE9mS3R2?=
 =?utf-8?B?M3JLZGliQ3cwa21kUXhnUXF2NmJHVkpFUEJhbWJ3a3RZZkt1MjVSK0RlWHZ5?=
 =?utf-8?B?WTNCVUJDVUJGYk45SmJ3NVh4SGZ1L20wUjh2d0RqMnJzL3V5YkpldEtLNFk3?=
 =?utf-8?B?cllrS2JzQm9CUWhJU1pqZ3FOTllpUGlQelI0MUg1ZWxaUkVYY0VBTVFsWmNX?=
 =?utf-8?B?b21QWTZYaGpaMC9wMDV6ZFIzdytVdFE0aGZRWFZCL1NjZnZ3N3M5dldhTDVy?=
 =?utf-8?B?SDVJZlk2ek50QlFXQ2ZaVW4rTW84a3c0NlVDdFRNbE1IZW9XVXZqZ09YMnhU?=
 =?utf-8?Q?hd1lIkChqSBX7De11J5KcDcdrbEEhiY5ng2zOZV1YzNpl?=
x-ms-exchange-antispam-messagedata-1: KW0Zz4YFbLPsPpjxbSl3G/vBvype5W/ZSjI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FFACE2A5D35A942B5E84A6A8542E577@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR07MB6437.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 045748b8-2cf8-4cf2-5ff3-08df33f4fe9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 06:39:04.6429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eXpeEUZ9t9blCVYtU6i8Q7hxNmZoIto+IwyJJ4gy65SS4CMs/QO91AxdYhqcxVE8JdbKK1gIRoNH1QI/5fFQqENG0TpnBbkTzZ5LB2SyBzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB650701
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 27 Oct 2026 06:39:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5161

T24gTW9uLCAyMDI2LTEwLTI2IGF0IDE4OjM4ICswMTAwLCBBbGV4YW5kZXIgS2FuYXZpbiB3cm90
ZToNCj4gPiArZGVmIF9nZXRfY2hhbmdlbG9nKHBrZ19jdHgsIHdvcmtkaXIpOg0KPiA+ICvCoCDC
oCAiIiJDb3B5IHRoZSBjaGFuZ2Vsb2cgZ2VuZXJhdGVkIGJ5IGRldnRvb2wgdXBncmFkZSB0byB3
b3JrZGlyIGFuZA0KPiA+ICvCoCDCoCBzdG9yZSB0aGUgY2hhbmdlbG9nIGRhdGEgaW4gcGtnX2N0
eC4iIiINCj4gPiArwqAgwqAgcG4gPSBwa2dfY3R4WydQTiddDQo+ID4gK8KgIMKgIGJhc2VfcGF0
aCA9IG9zLnBhdGguam9pbihvcy5lbnZpcm9uLmdldCgnQlVJTERESVInLCAnJyksDQo+ID4gK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJ3dvcmtzcGFjZScsICdj
aGFuZ2Vsb2dzJywgcG4pDQo+ID4gK8KgIMKgIGNoYW5nZWxvZ19wYXRoID0gYmFzZV9wYXRoICsg
Jy50eHQnDQo+ID4gwqAgwqAgwqBpZiBvcy5wYXRoLmlzZmlsZShjaGFuZ2Vsb2dfcGF0aCk6DQo+
ID4gwqAgwqAgwqAgwqAgwqB0cnk6DQo+ID4gwqAgwqAgwqAgwqAgwqAgwqAgwqB3aXRoIG9wZW4o
Y2hhbmdlbG9nX3BhdGgsICdyJywgZW5jb2Rpbmc9J3V0Zi04JywgZXJyb3JzPSdyZXBsYWNlJykg
YXMgZjoNCj4gPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHRleHQgPSBmLnJlYWQoKQ0KPiA+
IMKgIMKgIMKgIMKgIMKgIMKgIMKgc2h1dGlsLmNvcHkyKGNoYW5nZWxvZ19wYXRoLCBvcy5wYXRo
LmpvaW4od29ya2RpciwgJ3t9LWNoYW5nZWxvZy50eHQnLmZvcm1hdChwbikpKQ0KPiA+IC3CoCDC
oCDCoCDCoCDCoCDCoCByZXR1cm4gdGV4dA0KPiA+IMKgIMKgIMKgIMKgIMKgZXhjZXB0IE9TRXJy
b3IgYXMgZToNCj4gPiDCoCDCoCDCoCDCoCDCoCDCoCDCoFcoJ0ZhaWxlZCB0byBjb3B5IGNoYW5n
ZWxvZyBmb3Ige306IHt9Jy5mb3JtYXQocG4sIGUpKQ0KPiA+IC3CoCDCoCByZXR1cm4gTm9uZQ0K
PiA+ICvCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4NCj4gPiArwqAgwqAgwqAgwqAgaWYgdGV4dDoN
Cj4gPiArwqAgwqAgwqAgwqAgwqAgwqAgcGtnX2N0eFsnY2hhbmdlbG9nX3RleHQnXSA9IHRleHQN
Cj4gPiANCj4gPiANCj4gDQo+IA0KPiBBcG9sb2dpZXMsIHRoYXQncyBub3QgcXVpdGUgd2hhdCBJ
IGhhZCBpbiBtaW5kLiBUaGUgaW50ZW5kZWQgc3VnZ2VzdGlvbiB3YXMgdG8gcmVhZCB0aGUganNv
biBvbmNlLCBhbmQgYXNzaWduIGFsbCBvZiBpdHMgZmllbGRzIGFzIGEgcHJvcGVydHkgb2YgcGtn
X2N0eC4gVGhlbiB3aGVuIHRoZSBhY3R1YWwgY2hhbmdlbG9nIGNvbnRlbnQgaXMgbmVlZGVkLCBp
dCB3b3VsZCBiZSBvYnRhaW5lZCB0aHJvdWdoIGZpZWxkcyBvZiB0aGF0IHByb3BlcnR5LCBzaW5j
ZSBpdCBhbHJlYWR5IGNvbnRhaW5zIHRoZSBmaWxlbmFtZSBvZiB0aGUgYWN0dWFsIHRleHQuDQo+
IA0KTm8gd29ycmllcy4gSSdsbCBzZW5kIGEgdjQgcmVhZGluZyB0aGUganNvbiBhdCB0aGUgYmVn
aW5pbmcgb2YgcHJvY2Vzc2luZyB0aGUNCnJlY2lwZS4NCg0KRGFuaWVsDQo=
