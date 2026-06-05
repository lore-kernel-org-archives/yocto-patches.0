Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C38CD6E74
	for <webhook@archiver.kernel.org>; Fri,  5 Jun 2026 10:49:48 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.59])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5678.1780656585212524738
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Jun 2026 03:49:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ericsson.com header.s=selector1 header.b=wbU7toJ5;
 spf=pass (domain: ericsson.com, ip: 52.101.65.59, mailfrom: daniel.turull@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K06l6y/L1dHF5CJ2FiKoeLI0CfkFIXOjenQ4KT7ivVIg4lZRiRkVcjv0zPYUqsPlAcD/nEKO1P8TnOzpYgvQdhK7JiHoT3nnkUmM0CPVlFRaIDVBmIQzJH0cIfMOW8zpdQPKG8k4spI9w954aXUg5zSXQa3Zddw+9gOtuAA03cWtykos4zR+0Ld4d6vVl0aFyISfi6oVnxyA8LRcVCdIi1KNTO1RGrXM5K7EMoVtjmxvG4dgSSFzOVNb6XtWDMmrQeJ9CS+KLGUktKoAXlRtFgnUL3vqVr5tmIiE2g0msTnULtDW3RpHoxreYNW6v0EzmaRP8HOXIeEdiYIMY8Nr9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9139dEVJJgEUA8SN0IxKNASjh0bh8xQErw7S2x9Ds4=;
 b=LAa1yqGihLKNGVXEUfbbCNFh6ub2SPooDiJ/a2RcORJ3HsoTGuQOHZm6BHu66w74O2d8TZwYLP/cPEn2IwGsZTEeBFjAvUaRUlbjZq72+Y5ZTWeQoVfJrQNMtTAMiyWAxVE4hKN9a1qZDG4TgsMMsvso9SzgoM58eTUyi55ts0PTGV3ZN786DFZ9K7OvvMQHJh2Ou7S0AXNi8OebYl+EMYgYSz6lkdR1mYCOAHmaqD9nh0H8ESPSi3JJA9QYmFHY+walFcPw4fB+Yr1IImJWfANQsuHkWE4V0fRElvhCAK/5Q+FQWqSxddsn6QuVIEZq0vBgo1iP7iHNMFBbsAFplA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9139dEVJJgEUA8SN0IxKNASjh0bh8xQErw7S2x9Ds4=;
 b=wbU7toJ5ZCK5RyBB6Ex1dfw4YimZyIiA5sUl+Al8SL6RnUmP8BjukFSOxg03FlTBFTkV/O2qXz/+8gJj5EweFpFPnm32ZXk828QZ8HchS1Ml9XEieSSpmjtcjLRA6EP54LrRvT1ae4h2oPKidcoqbjwu34rqF5i2huY1r1kzI0muzFsQCIpfROPEURcoL3aDiCKrOl5s1thAW1nBx17Z6BADjbKWuf6cCPrdkJqPDQqvPnjZ0zuKE/Tlq9TtEdgNZYNuhSYqzm0pJXKMWzvZCNW+UcvRqcUfeg23WFGTOUSy+zE2g6Q4q+0cDXXvygWHQXhEDv375QMzfdk6eQHeoQ==
Received: from DU0PR07MB10740.eurprd07.prod.outlook.com (2603:10a6:10:5a4::19)
 by AS4PR07MB8874.eurprd07.prod.outlook.com (2603:10a6:20b:4f5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 10:49:41 +0000
Received: from DU0PR07MB10740.eurprd07.prod.outlook.com
 ([fe80::eb99:3f8b:e32d:2652]) by DU0PR07MB10740.eurprd07.prod.outlook.com
 ([fe80::eb99:3f8b:e32d:2652%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 10:49:41 +0000
From: Daniel Turull <daniel.turull@ericsson.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>,
	"yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Subject: RE: [yocto-patches] [AUH] [PATCH v2 1/2] upgrade-helper: add state
 module and --incremental mode
Thread-Topic: [yocto-patches] [AUH] [PATCH v2 1/2] upgrade-helper: add state
 module and --incremental mode
Thread-Index: AQHc83CwQKFS4NVCik6omspcGPjilLYvw7XmgAAHSLA=
Date: Fri, 5 Jun 2026 10:49:41 +0000
Message-ID: 
 <DU0PR07MB10740C0366249F0E053B41F688A112@DU0PR07MB10740.eurprd07.prod.outlook.com>
References: <20260603134044.3377639-1-daniel.turull@ericsson.com>
 <18B5DDE619C5A079.3784076@lists.yoctoproject.org>
 <CANNYZj8TpE-SZjbd46G1u9JabeGL_oFK7__CgXg5QkGYg=DVzw@mail.gmail.com>
In-Reply-To: 
 <CANNYZj8TpE-SZjbd46G1u9JabeGL_oFK7__CgXg5QkGYg=DVzw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR07MB10740:EE_|AS4PR07MB8874:EE_
x-ms-office365-filtering-correlation-id: 4c41af02-28f6-4870-e1c2-08dec2f0258d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|22082099003|18002099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: 
 AQLiv3VzNBJDCfPsCK6072d9rPH4m3eEVKLDyCjVVA2zdVIOAPuPxbwcd219GOBi3BquTUQTB/tVfWL9puAvotkl40+HeadXykprmgo6CKuIpSblGmGdtGyVExeH3326op1iN7/PNQIljHEgGfViKiWfv6D6c3lUMyOwBCmZsMkJ0+0DrpfsnVWJmeZ7Nt0PYRGNNStHDlHK5jr7D3yWjk1a4EGE6Iqb/ENAHa15GzedufEcd5XFGtAWhJLpxwVM2Bc0TNjp9b9mj4NrqmvyvWiDaBKg4W/6AazzHVPMikFy/s5iFCwehn9IJ9qJW5BCb11qV10aNfdqp6oDwaSTftcr+KX/FtfNuG2NzP/BcPrZYUU7jGZEd865GmWuDQIN5H7Vvzg+0do7Pwe8ar1dzT7FmO6TdhzpJO0gaFNiwA4/Ca/JkJsrbxkWSZMJ7wikbmFtB3qnouaGUEZGiC8nIToCSpDiklOjdjnI9vGzXOu5xf13TkEjIPwXZ+j9tprxcluDKuZJj6fJaoSnluoCbvrF2fV2qzKEZovhg6T60N4+VodMAE7SAr9WIrGCZovf6mtLOravi+Asj3peL9DmMcbzJtf+TUf56Ed1nUr7Ja2EcaWpgp3gaTRxbHrZkpC7NiqO+mXAw+ozfzE1Eu7VnBeRqrFYHdwOWmo3ue8C7F0FR+yDhTt49a0xgv7kFxIGyhPJdTTaT+g8ItsasixO6f82wlzGqZhKAO5PHThTLq7mt7kGVdXk1OZPwpVxex4g
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR07MB10740.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SWcvRVo5UmVxTmFWaVpobDR4WlNVMXVEY3ByQTIwd1g3Rm9oRGNqcTlYNkJB?=
 =?utf-8?B?QUNRN2RqSFMxTjk0SFVnTW5Ka0NVQXZlRjNrb1QvMm1GalVUdVlVbjgzV3FJ?=
 =?utf-8?B?a0VVSzZ3WWlsU1kzQ2w2eWxpcFd2M29SMFFFelF5NWlabjh3NFVpVzI5T0FC?=
 =?utf-8?B?d2JJOEl3WGRSRCt0RklTMTBGZnlJUUNpYVdTbDZzc29KT3VhL2dsV1NESjJk?=
 =?utf-8?B?U2pLVnBKdWo5bHRoK1ZOVjNxaVlocHR4dDV5S1Q2cjJGck1rck40TWVmWGVo?=
 =?utf-8?B?K2FGaDBoSGpaSUVGTS9jWW9USjNIWndnUStFRVFBckloNjRxbExCRkR0bTQ5?=
 =?utf-8?B?NlZ0cDZ1RmRDbVBZam5yWmNiTWoxSUhmQ1NjVXVVaUZsUWRNTjltMHNQN2wx?=
 =?utf-8?B?bVFXbEs5ZkZBOTFNVEtpbGJyaEhaMEJNM1ZjOHh5TU85cVpyUUszV2tNR0Ry?=
 =?utf-8?B?U1FzdmRHVlNxZzVjd3BUd1Y1NzF0RnlDTytEQjlkaWduN0NxTmZsa2U0WE5q?=
 =?utf-8?B?TmZ4WmE5Y1lPRkZpNWd2MjRVeXFlNFRNZ3JZQ2lUcEJKQlUxL21XSTlpTmxF?=
 =?utf-8?B?MndvY0JtUWg2c3k0RENzTnpCbWN0VHJVODlWc1JyNmVreHpCRysrNTZ4Nzh5?=
 =?utf-8?B?NHdjUUJubGJUN3djaGhXdU5VQVNueThWazJrRExrU2M0UCtGMVYzdGo5bnFr?=
 =?utf-8?B?V2FQNGxBVUlZMittbWI2bVBJN2RadmVVY3hlcm4yTHJ5ZjVlNVVDS25WSVFj?=
 =?utf-8?B?T0paWml4cjdZQ09OTHRFS1JyVkEydEtwd1RHa1VKZUhlNzBEdHE5TzMwcnNM?=
 =?utf-8?B?Ny9TNGNGQlR6K1RPcTR5blRjNlh4b25idzZxTERONkxFRitrTzhENnd3dEw1?=
 =?utf-8?B?TkdHNGh0UGk5UTRGNWVVYUNHbmdlOFRYUUIvM3hHSVA5UFYyM21NeVRaTlpK?=
 =?utf-8?B?QzZvZXk2b25oSGswOVdOWEh5c013VTVnZGhVc1VWbCtpMmNmVkFuaXFpelN2?=
 =?utf-8?B?SDVPWFR4b1Z4M2lkK1NVR2NVUUQrQWl1TnZXc0lWQ1Y1V3JwdjFocm5BRHdC?=
 =?utf-8?B?bC9MWFFLOFVBNlVHaElNZnpKenVVajJROGNZcEpUV2tIaDBFb2pCZDNzclZI?=
 =?utf-8?B?VXVQcmlnaHIzQlBEMTRGZTh5d0wwcS9qblhPUVBCdDlZYU94dW5JbUdYWFJX?=
 =?utf-8?B?MTFpaG5xdTc3WC9lbjA5SklpcktKNldSOGF6NUw0OUZMZXlMZ056ODdYd3RS?=
 =?utf-8?B?MXZxQ0ZkcFhlalZnRlFDR2ZYZnV0SmFTcFN4UVkzTVlXZmVqNGN5RWx4bWNm?=
 =?utf-8?B?ZllzKzdidm1Wb29uc0RMMkI2RFJwU3lxN3pVNm1GVlluUnA4WnIxK3h3Q3JU?=
 =?utf-8?B?T0xBNmJDeFVvQjVabkMvUytrZUl5eWhOb1h2eEdaYk5pN09nc3QzeEUrbHBE?=
 =?utf-8?B?Y09peGN4Nm5WWGxsamlMRFRaZWlGN1JCTTZYMzBhOW9FMDNxTGh6aEx5VHF2?=
 =?utf-8?B?LzBXOHpuRWZDVDAzVTFEQ3RwdVdtejR6aVZVZHQ2YnFHUUx4b0dWME1tbTNp?=
 =?utf-8?B?ZTBnRWpxSXRYK0JKQi9IL2t1VUt6S1Q4S0NhNUxxaEprTTR4YUlDUkhxT1RY?=
 =?utf-8?B?dlpscWJmblpFdE1hUUhpMGVHamFKYndFM2JnQ3cyamU5dWxTQjdtNnl3S2t0?=
 =?utf-8?B?M0NKeGhqR1lDTysybWpkU1FKcUFOYTdXQ0J6NG9hbTh4d1FGNDlKMThqeWxn?=
 =?utf-8?B?cnprMXlqR3NwclI3SU1YT0VIOEpGQzFYMG1TZk5SQURQRzIyamtIZSt0aERp?=
 =?utf-8?B?eWFrd0R6d01McWRGaGtEM3J5Z2x0MXNPZTJ0cVJrbCsrdTlaYTZiN0p2QzZQ?=
 =?utf-8?B?Sm5EcXk0K2JNY3BqNi92cHIrcTIxRS81amx3R0xYeXEwcXU2Q2ROWWZMWnBG?=
 =?utf-8?B?bS9NS0l1ckpnSG9EbVVHd0NWV011MUduQmNyc3hRaElBSXVLYk9nNXpjdGto?=
 =?utf-8?B?RTluTVRBT2FtVDgrUnFPQU5LMGNZdk9CTk1leWtXakQ5VUplUk81allnaDhO?=
 =?utf-8?B?ZVhXd0tTMXAvaGU1UGtzTDNLQ1pXNWphTkcxbDYrYVlwWENzUEhybXB6SS9Q?=
 =?utf-8?B?eWUwVzR1MDJvR2tMd0NsZ3VBZmNwMGk1eWdncVpKalR4ZHdxY3c0U2xzc20r?=
 =?utf-8?B?SVhyR2hXNFM3ejA4NlN4WkhJdi9WTE5mWWRmM2RzR2tUM1BONlIwc05sZ09j?=
 =?utf-8?B?MG4yaTBsVTgrWGhEcjkxc3lPeHRSQy8wNk1nd0JodjNrK2tmakxFdTBRTWkr?=
 =?utf-8?B?M2dEdjV2c0Z5VU5BT2ltRW9NMWhCWlMyelNtNmpLMmtVQ2ZCdnNPZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR07MB10740.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c41af02-28f6-4870-e1c2-08dec2f0258d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 10:49:41.0784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BIElCNURN9WYsLLoJBXZS7924rswpFvFb59SWPJLRVeISWVyF54CS10xXtIIax7JMHoL0Pl0UAWjLTcHzwL85mukEZIpF0DkDCrdRl58jQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8874
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 05 Jun 2026 10:49:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4145

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleGFuZGVyIEthbmF2
aW4gPGFsZXgua2FuYXZpbkBnbWFpbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgNSBKdW5lIDIwMjYg
MTI6MjMNCj4gVG86IHlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZw0KPiBDYzog
RGFuaWVsIFR1cnVsbCA8ZGFuaWVsLnR1cnVsbEBlcmljc3Nvbi5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbeW9jdG8tcGF0Y2hlc10gW0FVSF0gW1BBVENIIHYyIDEvMl0gdXBncmFkZS1oZWxwZXI6IGFk
ZCBzdGF0ZQ0KPiBtb2R1bGUgYW5kIC0taW5jcmVtZW50YWwgbW9kZQ0KPiANCj4gT24gVGh1LCA0
IEp1biAyMDI2IGF0IDEzOjQwLCBBbGV4YW5kZXIgS2FuYXZpbiB2aWENCj4gbGlzdHMueW9jdG9w
cm9qZWN0Lm9yZyA8YWxleC5rYW5hdmluPWdtYWlsLmNvbUBsaXN0cy55b2N0b3Byb2plY3Qub3Jn
Pg0KPiB3cm90ZToNCj4gPiBTbyBJJ2Qgc3VnZ2VzdDoNCj4gPg0KPiA+IHJldHJ5X2ludGVydmFs
IGlzIHJlbmFtZWQgdG8gcmV0cnlfc2FtZV92ZXJzaW9uX2ludGVydmFsDQo+ID4gcmV0cnlfYW55
X3ZlcnNpb25faW50ZXJ2YWwgc2V0dGluZyBpcyBpbnRyb2R1Y2VkDQo+ID4gcmV0cnlfYW55X3Zl
cnNpb25fcmVjaXBlcyBzZXR0aW5nIGlzIGludHJvZHVjZWQsIGFuZCBpcyBhIGxpc3Qgb2YgcmVj
aXBlcw0KPiA+IF9wcnVuZSgpIGlzIGFkanVzdGVkIHRvIGZpcnN0IGNoZWNrIGlmIGEgcmVjaXBl
IGlzIGluIHRoYXQgbGlzdCwgYW5kDQo+ID4gaWYgc28sIGl0J3MgY2hlY2tlZCBhZ2FpbnN0IHJl
dHJ5X2FueV92ZXJzaW9uX2ludGVydmFsLCBhbmQgbm90IGFueQ0KPiA+IG90aGVyIGludGVydmFs
cywgc28gdGhhdCBpdCdzIGd1YXJhbnRlZWQgdG8gYmUgc2tpcHBlZCB1bnRpbCB0aGF0DQo+ID4g
aW50ZXJ2YWwgZWxhcHNlcyAoYW5kIHNraXBfcmVhc29uKCkgc2hvdWxkIGNvbnNpZGVyIHRoYXQg
c2ltaWxhcmx5KQ0KPiA+DQo+ID4gT3RoZXJ3aXNlLCBJIHRoaW5rIHRoaXMgaXMgbW9yZSBvciBs
ZXNzIHJlYWR5IQ0KPiANCj4gQWN0dWFsbHkgbm90IHF1aXRlLiBJJ2QgcmVhbGx5IGxpa2UgdG8g
YXZvaWQgZHVwbGljYXRpbmcgdGltZXN0YW1wDQo+IGxvZ2ljIGluIHNraXBfcmVhc29uIGFuZCBw
cnVuZSgpLCBhbmQgb25seSBpbXBsZW1lbnQgaXQgb25jZSwgc28NCj4gcGVyaGFwcyB0aGUgd2F5
IHRvIGRvIGl0IGlzIHRvIGhhdmUgYSBoZWxwZXIgZnVuY3Rpb24gdGhhdCByZXR1cm5zIGENCj4g
ZGljdDoNCj4gDQo+IHsndmVyZGljdCc6IFRydWUsICdyZWFzb24nIDogImV4cGxhbmF0aW9uIGhl
cmUifQ0KPiANCj4gVGhlbiBmdW5jdGlvbiBjYWxsZXJzIGNhbiBwaWNrIGFuZCB1c2UgdGhlIGVu
dHJpZXMgdGhleSBuZWVkLg0KPiANCg0KT2suIEknbGwgbWFkZSBib3RoIGNoYW5nZXMgaW4gdjMu
DQoNCj4gQWxleA0K

