Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.23])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43710.1793196401474234218
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Oct 2026 07:06:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ericsson.com header.s=selector2 header.b=BApM0FB9;
 spf=pass (domain: ericsson.com, ip: 52.101.70.23, mailfrom: daniel.turull@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHEsGTCvXFbIVNBl7zOWUjk8HOwOEYnJtqJZbaFPuMqajdFW0gl8+TaDl4olkDrkBhyFES/kH22yb40yR39I6H1Of0fw7opPxJGx97BCWhomiudZvdKtZ5sx2VeAzj4y+EtIg3EJIK7kDN2LgMEgSrIneRmgF+WzPEOBP842nbu0fJQt0VUA/u0pSuhwlSMIjPnnyJPN5u3lRoAqJ1TKwAw0aRkGtHlVMQ/KXHQnCqRez2tSIBZTwD7WfJ1Juc+iibkJ5Qqzsa/RMbBZMG8o7EcMy6fK7DZDKWNIUWjSxQrPYE842lEpUGViurzbDQq7O7oWbOLu8H46s0BvIS96bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHFLkUaAB4zjOpSKu1aB+i/L9sK41DTBWRqsxsQChPQ=;
 b=CjnO6nzkSqa3ZfH9TOU7seeE2ap6IRx8KMkhjCYBvRjUuMu9wbL2i2LOqGw+tMiixWQtU/KKuBbof+cFvgHfAMkpQAT+kd7mAcdlTf3byINNaSzoQ+uytoO+pWwD+obc5SPRft7oyboE/oaUgoQlWJR+9/QhhxxrqTwlohjKjE07mgD1eaZqWZ5AacwCjntGS1LghrnXrQG84UXwjTUmwsZ8mrR0rHhgTUIFXY45ArWBvDkmW6AXlHKLnaoBDwc0d3jAzAQs7APbYEFMZn+sOIgKdzHlPckwt6tkreMaTknshIMIK2pWuc0d4jGrM1lYIFJtrmjlHAIJlN8qvBc+Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHFLkUaAB4zjOpSKu1aB+i/L9sK41DTBWRqsxsQChPQ=;
 b=BApM0FB97desV7hgECF79aZm0MdMB1WoG6nRudDr9Pcexu0h4MGk1zuMXyhYhjiT4+DpY8vpi1P4+xPB8NN0sQH55wYNpSN5kgXYAkpxYKsaFCf9EPybucJD6RBt47sly60OvEzBKoZ184lFGe6kAKngYwVbl4TrNeO85rcJBMg7h7oYnLAKhOBJGocShbAUSZaERGmvwiv9Uvb5Gkf9YC6kvegV4+nGnpjZQ3dbcOH6DiwBdRuIXdcUPh+An/47ayf3u+4LD9G1AOpK0LNNCYKnPWx9RLn9je9OV+dgCmqREAps/vBL//NmiCFNFspQ/LERgktyDPQUlfJynrHm0Q==
Received: from AM7PR07MB6437.eurprd07.prod.outlook.com (2603:10a6:20b:140::11)
 by AMBPR07MB11840.eurprd07.prod.outlook.com (2603:10a6:20b:72d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 14:06:36 +0000
Received: from AM7PR07MB6437.eurprd07.prod.outlook.com
 ([fe80::fb9c:237c:ec12:2db0]) by AM7PR07MB6437.eurprd07.prod.outlook.com
 ([fe80::fb9c:237c:ec12:2db0%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 14:06:36 +0000
From: Daniel Turull <daniel.turull@ericsson.com>
To: "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
CC: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: Re: [AUH][PATCH v4 1/2] steps: read changelog through devtool's
 metadata file
Thread-Topic: [AUH][PATCH v4 1/2] steps: read changelog through devtool's
 metadata file
Thread-Index: AQHdZhduA3zsIslEukOop/Q1kzEUObcSss+AgABMF4A=
Date: Wed, 28 Oct 2026 14:06:36 +0000
Message-ID: <20fe0897866bbbc6315ec0fd4ba5597963b11270.camel@ericsson.com>
References: <20261027133046.300849-1-daniel.turull@ericsson.com>
	 <CANNYZj9rdRkWHnR7VV48_GBJOEfXnwivZoVXvhF=finTXzVn=w@mail.gmail.com>
In-Reply-To: <CANNYZj9rdRkWHnR7VV48_GBJOEfXnwivZoVXvhF=finTXzVn=w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR07MB6437:EE_|AMBPR07MB11840:EE_
x-ms-office365-filtering-correlation-id: 3e884626-8373-4742-7be8-08df34fcae0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|38070700021|4143699003|11063799006|56012099006|261009223027099003|261022105027099003|261026140227099003|261026121527099003|261021121427099003|10067099003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: yFnsLchhWBri8Dwp0k29Dg+HnoWg6XnKJwIZDPHok4eaK5kZ+BywllhD4umjJt2QHAmTmHPqgOSxIdRZ5P2roUjjhK9O7k38XchkYCCCnYKTGLwdeO2daZ41bw0BF27krcoTW3wAI2M+Y85v4KOQC67Po/QIBOTWQsqJ9jExdLQVSkdCLOdYVpEeMmzhMgdElFxfq//5MoFFYflXlg6slbKuxNQZ1uOBxa/9GncnKqsMMQZ9AN70/+fxQ3ENbuK5otY+eEH+2qcnYhF2CyMxgQJce06sLyuStwwUMwwUDIgxPwJmmJvqvR+dQEkgEhjwkgGLkKkrr1v4esesZ7nA7xFDoeQF8kNoVTbjQjRH/IgN44rdMV3RFHbNd/WjnTTsUVd6z9crSY2OtLETFqlM9ghMeMnrqLqSqIgyKf97caH0U2AGKO2OSyWiEohzeHfz1eF3cifECqRERXxUJaTtHgGFPdBAFIL8TNynCq0IIeSvuoZVCKFLleFlT3xWNpwMW1mrMoUY3Wek+e2Vy7+4SQ8xZIOO3Csy2PSugyGHZfWkoXYyC8g/y2MppNNLYSep7fh3aK7gEejy07zFZRLAKvz7Qg3iJTvDQbrZX7RaYf78KkViV/pu85Owqynruo0SfyvM0aGqeGGVF2EaTiRBAxdd4Ni0XHAbwYs46hWU1N0DT5TGZj1Huo6G+tJcwQKpygILVEWsbyiDVjDUlrMMee6ol5tQLW20019BnDjw7Y4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR07MB6437.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(38070700021)(4143699003)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261026140227099003)(261026121527099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlFLSm1XWitxZktWS3EvTk1OZ0MvdkttRmlQZDN6cmptaTlVL0tNZVN3aWgv?=
 =?utf-8?B?WWw5QmoxOFZ5TzAwaXIxL1plWGNWM3JVVHdUamhqWXdyTlpnU2djZWZiR2Ix?=
 =?utf-8?B?czZqRU5NQVM3Q2prQ09nOUpYWVM0TzlIZzZ1bi9vQUF1MWx3VHhQSlVSRjNV?=
 =?utf-8?B?cXJPc1lxeE9PRzlaa0JEclBGLzV6SThqNm91bzZrK0E3aTRWLzBZV3lPRVNn?=
 =?utf-8?B?TFA2a1NKRFBLandPQjQyR3BIekMzQk9XdmErVUdLRHJweXlreFpySGhrZWJT?=
 =?utf-8?B?cWhiU2N2Z1NyaG4wbnlHLzZSMjVObHgycEVsdy9uM2s2ZlJjSXFlbDJPdytY?=
 =?utf-8?B?U0lBeHQ1Unc3cVVCTW1pRVNoRzhuNjhHSWpWOHR3cjQzbEtjUjMwRHEya1Rw?=
 =?utf-8?B?WnFsWHUwcllrNitKRDhnM09MZk5EUzc1N21FbXJWckwwK1FCb1QxenVvNGVX?=
 =?utf-8?B?cS9YY0hhd2hpd2N2VU82MlA0UEllZGtvQWlNcnl3RGhmemF2am9WQmNxU09K?=
 =?utf-8?B?NGZmNnpCTE8wODNPYzc0NCtuNjJLNjY3NDF2MEpzVFJjS0NpWjk5eVhwSExM?=
 =?utf-8?B?d2dVSmsxQmhVL3NML2cwbjZtWFZSbVZHc1pKNFpnTXZhZSs2UHg4YWR2R0tX?=
 =?utf-8?B?WktmL3ViMFFnNzNrQnRMdGNTQ0Jpb0tOSDJReStxZHFRMlIwUXA2K3JtaDRl?=
 =?utf-8?B?VzVRRkdhallXTEVjQ1VSU1g2STQ3RFhwMFpKakxrMTNja05ReXBuTEhEMVUw?=
 =?utf-8?B?U1JvZkorMWFpZjRKWEVBZklzQVh5OGYzbEZ5VGMxY0w0dHV0Tmd5OWlLdUt2?=
 =?utf-8?B?MzJodXU4OVJzWXM4MnZxbk9KS0VUQmRYb1BiNUlFdzEvZVhmNjZVZzJhY2ky?=
 =?utf-8?B?RVMyaElnSlZneTVSUE55elVmeXRxK3grZ0FTUXhpaXRyMk1Takc1WEJSVjl0?=
 =?utf-8?B?L3hUQTF5bTNZdWJoYmNSOXZMVm0wUkNOMjJMd0xGa1BRMGE0SmdYWFZCbWR3?=
 =?utf-8?B?czMvY3RvRnVseGtEa0VnU0treTJ5TjJSdTZjOTFpMDFJRHFRcmN6ckhJUUhP?=
 =?utf-8?B?TkM4T1NtdlpnOWJRV2d2VERBUnY0b2EvWjYzREFHU0Y4OXpvR3N4WTduTjhq?=
 =?utf-8?B?MFZZL0ZIKzNONFU3dXFDdzhmdmxHcHNlQWRIRm9lM0Q3Vk8vOWcwK2xzVUs4?=
 =?utf-8?B?L3kzWUthV3JVK1U4QWFNRVNBVDcwRXcweitjaGtCZHZPWkVUSkx6aG5sSnFB?=
 =?utf-8?B?eWx5VUk5ZzMvRzVMbFNkWmVTazFsbXBhSHpwQ09EZTFUWG1TMEdyUlFFeGti?=
 =?utf-8?B?Y3JEZXowaS9YaTZZcWhxdjBCQjZwMmdMdUFOUTlyRjJ3RkNUS29lS3VWQTc0?=
 =?utf-8?B?d3luNzdLdE9QVDZ2elNRTWVhblVyOWYvZFNmZ2taTTB5S3RMTUVpQi9ZbGhz?=
 =?utf-8?B?WW1WSzhhNVQvbTdkRzg4M3o5ZWF4clU0Tlpoakh6VGxIVXVUc2tudjNHODhh?=
 =?utf-8?B?c3FzS3VBLzdINExaUDM4Wi9veEtvTUVpcXRIYTMyaGZzc3QrQ2VPSEgzTFRC?=
 =?utf-8?B?QjFmTTV1UUlVWTJPSkVWTGp1QVZwYzhLbno2ZkJNc0FKOXpIcWVya0ZrUWpD?=
 =?utf-8?B?cWxPNDBKSzE1bGxCY0IrcklwcjNOOXA3aDRpOSsrUVJEaFdUWFhqMGJaTHVE?=
 =?utf-8?B?Nk9EN2t4OWxWRGRCbnBkcDlZSE9Xcml6b1VySERkN3hmNEVMbjVPY0xHRnV5?=
 =?utf-8?B?eHhqWlE0ajVEWnFtY0FtblpoLytTOVl5cGhzbEY1ellYWFRCby9JUlFGd2xx?=
 =?utf-8?B?TUV4S1FhK1hOLzhtWkFEaXpPWnZ2SWNOTkVvcE5VT0EvRHJRMzhsR000RytI?=
 =?utf-8?B?UVRPbzV3ano4Smh5TFF5UWZWVjNweGd1Sy9JUmNMdnlmOXJ0cUpUZk5Yd2VG?=
 =?utf-8?B?T1l5RGNXUkcyaTJDSWJ0bjdneHZERGFKYjBBWDBxOGNNT1dkOUF0UWhMV3FT?=
 =?utf-8?B?SUdkNDdUL2FJWDkwQVFaSTZXQ2dQWjh3dWNqSWlvVzFCdm9FQlhBZVNpZnRh?=
 =?utf-8?B?eXV4RjZaNk5YUEtKMUI4dkVCcEVIVjFTNTkyMk9BOXdYeU5VaVJoakpvSG4r?=
 =?utf-8?B?ay9yd0ZPRFhTbHRQZlJCNk1EOENQWlJUdXVkTTdTT3dNbHRSRllEUmRBbENY?=
 =?utf-8?B?L0d1eEtIT1VSSTdCTFVzdDVZN2xsZlNTSDN3eXVLMzFReDJLZE1PM0ZEbkd6?=
 =?utf-8?B?UytTTDd3Qkx1dTdwUXZvWHVnWDJlQ0IySmJuWFNmMFNkWTBoZXRVbTRIRVBv?=
 =?utf-8?B?SnNmdjlIUk1xWm5MQm4zODdMbmJ4WjZzSURjbkRvbEJVeStpY3IxUlIwZVlX?=
 =?utf-8?Q?T6d3SyRkWqKi6EV8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8F0C305A7C07C4A9FBED7B67CB0110D@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR07MB6437.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e884626-8373-4742-7be8-08df34fcae0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 14:06:36.6260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6TDzVWubX2vuX+cR8PzRv++3C4fGI9gfVa0n7niNiL6Uh48WvLWUpmkSBg23HQkuBjBDJEipNQk1e98OOE0CkoQ+E2EZ6tqdqEjnVTPfM5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR07MB11840
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Oct 2026 14:07:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5173

T24gV2VkLCAyMDI2LTEwLTI4IGF0IDEwOjM0ICswMTAwLCBBbGV4YW5kZXIgS2FuYXZpbiB3cm90
ZToNCj4gT24gVHVlLCAyNyBPY3QgMjAyNiBhdCAxNDozMSwgPGRhbmllbC50dXJ1bGxAZXJpY3Nz
b24uY29tPiB3cm90ZToNCj4gPiArZGVmIF9nZXRfY2hhbmdlbG9nKHBrZ19jdHgsIHdvcmtkaXIp
Og0KPiA+ICvCoCDCoCAiIiJMb2FkIHRoZSBjaGFuZ2Vsb2cgYW5kIGl0cyBtZXRhZGF0YSB3cml0
dGVuIGJ5IGRldnRvb2wgdXBncmFkZSBpbnRvDQo+ID4gK8KgIMKgIHBrZ19jdHggYW5kIGNvcHkg
dGhlIGNoYW5nZWxvZyB0byB3b3JrZGlyLiIiIg0KPiA+ICvCoCDCoCBwbiA9IHBrZ19jdHhbJ1BO
J10NCj4gPiArwqAgwqAgY2hhbmdlbG9nX2RpciA9IG9zLnBhdGguam9pbihvcy5lbnZpcm9uLmdl
dCgnQlVJTERESVInLCAnJyksDQo+ID4gK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgJ3dvcmtzcGFjZScsICdjaGFuZ2Vsb2dzJykNCj4gPiArwqAgwqAg
bWV0YWRhdGFfcGF0aCA9IG9zLnBhdGguam9pbihjaGFuZ2Vsb2dfZGlyLCAne30uanNvbicuZm9y
bWF0KHBuKSkNCj4gPiArwqAgwqAgdHJ5Og0KPiA+ICvCoCDCoCDCoCDCoCB3aXRoIG9wZW4obWV0
YWRhdGFfcGF0aCwgJ3InLCBlbmNvZGluZz0ndXRmLTgnKSBhcyBmOg0KPiA+ICvCoCDCoCDCoCDC
oCDCoCDCoCBtZXRhZGF0YSA9IGpzb24ubG9hZChmKQ0KPiA+ICvCoCDCoCBleGNlcHQgKE9TRXJy
b3IsIFZhbHVlRXJyb3IpOg0KPiA+ICvCoCDCoCDCoCDCoCAjIGRldnRvb2wgd3JpdGVzIG5vIG1l
dGFkYXRhIHdoZW4gdGhlcmUgaXMgbm8gY2hhbmdlbG9nDQo+ID4gK8KgIMKgIMKgIMKgIHJldHVy
bg0KPiA+ICvCoCDCoCBmb3Iga2V5LCB2YWx1ZSBpbiBtZXRhZGF0YS5pdGVtcygpOg0KPiA+ICvC
oCDCoCDCoCDCoCBwa2dfY3R4WydkZXZ0b29sXycgKyBrZXldID0gdmFsdWUNCj4gPiArwqAgwqAg
Y2hhbmdlbG9nX3BhdGggPSBvcy5wYXRoLmpvaW4oY2hhbmdlbG9nX2RpciwgbWV0YWRhdGFbJ2No
YW5nZWxvZ19maWxlJ10pDQo+ID4gK8KgIMKgIHRyeToNCj4gPiArwqAgwqAgwqAgwqAgd2l0aCBv
cGVuKGNoYW5nZWxvZ19wYXRoLCAncicsIGVuY29kaW5nPSd1dGYtOCcsIGVycm9ycz0ncmVwbGFj
ZScpIGFzIGY6DQo+ID4gK8KgIMKgIMKgIMKgIMKgIMKgIHRleHQgPSBmLnJlYWQoKQ0KPiA+ICvC
oCDCoCDCoCDCoCBzaHV0aWwuY29weTIoY2hhbmdlbG9nX3BhdGgsIG9zLnBhdGguam9pbih3b3Jr
ZGlyLCAne30tY2hhbmdlbG9nLnR4dCcuZm9ybWF0KHBuKSkpDQo+ID4gK8KgIMKgIGV4Y2VwdCBP
U0Vycm9yIGFzIGU6DQo+ID4gK8KgIMKgIMKgIMKgIFcoJ0ZhaWxlZCB0byBjb3B5IGNoYW5nZWxv
ZyBmb3Ige306IHt9Jy5mb3JtYXQocG4sIGUpKQ0KPiA+ICvCoCDCoCDCoCDCoCByZXR1cm4NCj4g
PiArwqAgwqAgaWYgdGV4dDoNCj4gPiArwqAgwqAgwqAgwqAgcGtnX2N0eFsnY2hhbmdlbG9nX3Rl
eHQnXSA9IHRleHQNCj4gPiANCj4gDQo+IA0KPiBUaGlzIGlzIGNsb3NlciB0byB3aGF0IEkgaGFk
IGluIG1pbmQsIGJ1dCBzdGlsbCBub3QgcXVpdGUgdGhlcmUuIENsYXVkZSdzIGNvZGUgb3V0cHV0
IGlzbid0IHBhcnRpY3VsYXJseSBnb29kIGhlcmUsIGF0IHRoaXMgcG9pbnQgSSB3b3VsZCBqdXN0
IHdyaXRlIGl0IGJ5IGhhbmQgaWYgSSB3ZXJlIHlvdS4NCj4gDQo+IDEuIERvbid0IHN1cHByZXNz
IGFic2VudCBmaWxlcyBvciBmaWxlc3lzdGVtIGlzc3VlcyBpbiBleGNlcHRpb25zLiBKc29uIGZp
bGUgc2hvdWxkIGFsd2F5cyBiZSB0aGVyZSAodGhpcyBwcm9iYWJseSByZXF1aXJlcyBhIHR3ZWFr
IHRvIGRldnRvb2wpLCBzbyB0aGF0IHRoZXJlJ3MgYSB0cmFjayBvZiB3aGF0IGhhcHBlbmVkIHdp
dGggY2hhbmdlbG9nIGV4dHJhY3Rpb24uIFNpbWlsYXJseSwgaWYgYW55dGhpbmcgaW4gdGhlIHNl
Y29udCB0cnkuLmV4Y2VwdCBibG9jayBmYWlsZWQsIHRoZW4gaXQgc2hvdWxkIGJlIGEgaGFyZCBl
cnJvci4NCj4gDQoNCkkgd2FudGVkIHRvIGtlZXAgdGhlIGV4aXN0ZW5jZSBvZiB0aGUgbWV0YWRh
dGEgb3B0aW9uYWwgaW4gY2FzZSB3ZSBydW4gaXQgb24NCndyeW5vc2Ugb3Igb2xkZXIgcmVsZWFz
ZXMgdGhhdCBkbyBub3QgZ2VuZXJhdGUgdGhlIGNoYW5nZWxvZ3MuIEknbGwgbGltaXQgdGhlDQp0
cnkvZXhjZXB0IGJsb2Nrcw0KDQo+IDIuIEhhdmUgYSBmdW5jdGlvbiB0aGF0IHJldHVybnMgdGhl
IGpzb24gY29udGVudCwgYW5kIGNhbGwgaXQgdGh1czoNCj4gDQo+IHBrZ19jdHhbJ2RldnRvb2xf
dXBncmFkZV9tZXRhZGF0YSddID0gX2dldF9kZXZ0b29sX2pzb24oLi4uKQ0KPiANCj4gQW5kIHRo
ZW4gd2hlbiBuZWVkZWQ6DQo+IA0KPiBjaGFuZ2Vsb2dfdGV4dCA9IF9nZXRfY2hhbmdlbG9nX3Rl
eHQocGtnX2N0eFsnZGV2dG9vbF91cGdyYWRlX21ldGFkYXRhJ10pDQo+IA0KPiBBbGV4DQoNClN1
cmUuIEknbGwgcmV3cml0ZSB0aGUgZnVuY3Rpb24gaW4gYSB2NS4NCg0KQmVzdCByZWdhcmRzLA0K
DQpEYW5pZWwNCg==
