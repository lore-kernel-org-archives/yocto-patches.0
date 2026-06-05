Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C6ACD6E79
	for <webhook@archiver.kernel.org>; Fri,  5 Jun 2026 13:56:53 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.60])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8667.1780667811083865951
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Jun 2026 06:56:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ericsson.com header.s=selector1 header.b=S7K5zumn;
 spf=pass (domain: ericsson.com, ip: 52.101.66.60, mailfrom: daniel.turull@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tVfaYIjVC8lXpACekAOF9xe6KIy0sKFYiqvYUD+ZgqszZw1ePjb/KGv6PIZ4uqFxsnpQ5BIsz9a5D9g42pDbjBbGpYtMUf39hiVRwIt4D+Xn8j24uHLRx+FJv2ak7XbTf22QgHHRrH5SX153V9iRvzuoialdF6GyhzLCOhh4VHKyFX8T0DnN9OpeO12tDfF6BNM/Lnx+K/Eu6outkuPJe/Y2suWmiJuAjPJzhUgeQ0rrXoLo68jRgD1JMp2ZEsT8uvB4NzMj65NAUMH5V9rADqXE38/UDreHaDDt+5okZ2v5saepX8wwi+OcyBeSEvkwsrEAU99cd/VSYvuzt+Wv9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSzlttLSAtgNqj0VcNbush/8dwK4kuvzY2ogme4DShM=;
 b=o6qI31yjVLG9EzhANNLHllLcrH0Z0KsAJ3T5zrt1qi++s1LofZ/Jpae6K/8Hwe2ZmsBr0/jyrukAJdAsLYUSv90G0Jukh5FT2kl9O641n+rJyG/DEG1qTsI40eh9TLxW93ZRtNElB2+wnGZrzvAaYyd+H3+ZcE/kof+Owttlf10BOtvZGQ/PNEjXAqq5AbJeHpfq3C3TnsyxxRBPFQl7eL+KhRK+QaDsXT1wn8UNZOaNJIxJ2tEhcKmP0URLqnyCrtWxWiGZTrvv+7H4+QQ1qbwyIlt7UOclGH9vhQrm8E+2VkY1i1ECMDB7y0yoj0dx1KRh9nfQeXGaAy3Qv1BADg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSzlttLSAtgNqj0VcNbush/8dwK4kuvzY2ogme4DShM=;
 b=S7K5zumnHhNeaDYx1rv4M8TnxzW9jzrJ85D9oex7TZGjIwuiWnqVteZFVWQYa4Hb1DmZGBNftq7Grf/PYd9o99nAIQl/fHoDMKLw8EGXukOe6HeRAb4zBbOX0c4YsCOrwgDxjadgLhwu+cXUvzlHiwUlDX4SdVnUrjeboUXfNAhj0uToSkRqBS0bDVRj1YDV+rKQyxq7A745S5PUTrPOXtm96kPTWa8rIZVKA9GjhQuijOEbrMLquORYKdk80VwsykXpshfBhq6U9i4MaV82aEWy5YGRYGDhl6gvXE2qpWrxTOU4oW/uEmgAbTswB9ThWUrRcgFV+23mvpF+UPofmA==
Received: from DU0PR07MB10740.eurprd07.prod.outlook.com (2603:10a6:10:5a4::19)
 by AM4PR07MB11015.eurprd07.prod.outlook.com (2603:10a6:20b:6e7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 13:56:47 +0000
Received: from DU0PR07MB10740.eurprd07.prod.outlook.com
 ([fe80::eb99:3f8b:e32d:2652]) by DU0PR07MB10740.eurprd07.prod.outlook.com
 ([fe80::eb99:3f8b:e32d:2652%3]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 13:56:47 +0000
From: Daniel Turull <daniel.turull@ericsson.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>,
	"yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Subject: RE: [yocto-patches] [AUH] [PATCH v2 1/2] upgrade-helper: add state
 module and --incremental mode
Thread-Topic: [yocto-patches] [AUH] [PATCH v2 1/2] upgrade-helper: add state
 module and --incremental mode
Thread-Index: AQHc83CwQKFS4NVCik6omspcGPjilLYvw7XmgAA7nxA=
Date: Fri, 5 Jun 2026 13:56:47 +0000
Message-ID: 
 <DU0PR07MB1074002AFEBB8B81FF4E7A65E8A112@DU0PR07MB10740.eurprd07.prod.outlook.com>
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
x-ms-traffictypediagnostic: DU0PR07MB10740:EE_|AM4PR07MB11015:EE_
x-ms-office365-filtering-correlation-id: 085e3061-c5ed-41c0-0e6e-08dec30a491b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|18002099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info: 
 zultZbPf4jP7cWPxjo5RC+SdGr3J0y8rDpSarXNYxFCf4v9KA+HbMzyXlaq3ayuyDqbl/nv6Zy1YDrc7anJT6lITQCRmC6BE18oX2CBaPDD+Cx8xVYz44M/bzXKmO8yA1SiE8zusZjg+0k0ybLm/cfctcbCFnuCV1MRwRr9DdfxkNvyk9JQl4cv7mvtp/5BSNmH+PkmH6IzIpbO60EjjNKClR1XokA6UvJnOzs6fPVHjCdFYdru0z8aJs4cKy2Y4d5sSh9z3ZDtQgDfsJIdP+mBGxle4oybogvaaHaupW2wqJsRAAOHuhtJiAHT5445PWd/7+u3aiMeHiBNf1QBcwBklOvVU0ptA5o57c4HOhXImk9xKw2q2nhTSdNVUAL2GauFqLU/Dw//nFnt13MQuDCSFW6vBVDEIhhB+0jrHFnuss7xRg98HKG2B7gmM9pqJDXdw5XVb4f43JJ/J3L54+czVRGtDkP6pf+bQ6kfwi3P9+V4XgUfgxijwniOAhsGf9qwnsrv7vnHMIPPYJbR4EsmLw00QBrFQPOYoAIQKzuhUgJXEFjudPIIVFCDWyjHEjf69vEzCnor0O+0ChtNmCtKdF479G0Kcn6+z6s4Xz4pKb1WImCI+wYwp6UL05gpj5kayTZifdvsudMf4cCHwMgDFj6aauye+n3zop0tI0ZsSiGQcO29ngPC8u1ULItIEBaOy/ZJmdACOi7mvy/G9FjUMmXvbVR//hq28E7JjSZZuJpZlEWeJczbX06sVEoYl
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR07MB10740.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NVVDK2I4ajJqeFpWZnNlRndxb3lCSFZzeWxIWXBDMHAvUjBHMEprS2tFNENG?=
 =?utf-8?B?ZDNXTHh2a3RyNkNyRm0zTFlTMlRwQ3J5a3JlTWpZZXFCd2tCNk5pL3cwS1dS?=
 =?utf-8?B?TkV1UWV3UitJMC81dTg0bTd0cVRRNHZXZVJZNEFXMkVELzRqUThqUWlrb25B?=
 =?utf-8?B?VzFnd0hESFYxQ2JyVXRQVExFT2RMenBMenR4akdsc1B4MW5WWXJsWkFHcHFN?=
 =?utf-8?B?SVhNdmlKSnZ5OXFWN0MrMDBrNFpJY2dwMzdxQS9QaEhEOGFsMzRwZGo4VTJa?=
 =?utf-8?B?TzNJNUlMczdUZ1daUzI1MjExbTRvcTluaVNUbVVhSWV0SGNOaHRncnFUYjF5?=
 =?utf-8?B?cWpoNXhleEg4N3JTMmY0S3lFejdHQ1pxOTRETkNuUEd2ckxmOGFkVU0vTlIw?=
 =?utf-8?B?QVJRMGZpU2Z6Ty9HUWJ0YVZ5NUlCSm0yMzBRNkxjVGZ4TE1kRWltTTdxZW4z?=
 =?utf-8?B?ZExuTzcxRThENjltdGtWNkJGczJ2TVduQjdGQ21OUFp5WHNyNzlTa0VyQXNR?=
 =?utf-8?B?aVAzUGF4Mlp5WmdqRUNxVnBtSTUrNGR3RDZxb2U2cWM2ck1jYjVqalJ6RG9K?=
 =?utf-8?B?TENITjdHYnA4eUMwL2daK3lGOVFwcHRpcitScE5TWGtPRlJrSGt5NDlJc0Fu?=
 =?utf-8?B?K1M4aFdwbEpPOUhFbUJNS1RETCtUZTFuQ3Y3NVd5aEUzVHFOZWlNbUR3OFZ5?=
 =?utf-8?B?NmlEVkdrbWVpNE8zdlR1azc2WEl2WW05MktBeVJWU2hWeDhKQWlUODhmNmUy?=
 =?utf-8?B?UDlGMHVkY0JLRWtUalhyTjVvdFZCQUtObTdrUjdmZTh0bEFKMjBFK0RMa0dX?=
 =?utf-8?B?SW43SDhJQlVzN1RyWmNIQ0NTUklIK3N6VUdITjgxWk0xVUpnK2oxeVRkd2F1?=
 =?utf-8?B?VWhqdmZUSkloMmZiejNVbE9FMkhhV0VYNE15Z0hBekx2RE1YWlpmQzBGbDUw?=
 =?utf-8?B?SU03M0tVaWdsb3BucW1CSDFMRUxOejJlK1g0bk1FNnk4dzBSQ2hKb1RGMnp6?=
 =?utf-8?B?RlBmQlpWWDdzNFJWcW01MEVNbUdhMUtIZDd5akxCOWM4MmVtVVJKRVR3VC9T?=
 =?utf-8?B?V1ljNzhtL21GbDE5bHBrdmMraS90TlVrMnlLQWkvUm5qWDdhdDBvakszZFBw?=
 =?utf-8?B?eWlyRUVlVk9xa0lJSTRKejVrRnZDa2hLdEhsWVdsNHJxWHFuZjNHM0lNd1dJ?=
 =?utf-8?B?bHpoL2JDSjdJQ2hMYUd0WDNLcUlHTC90dTgzVldyYUxnb25HL0hkVEtPdXZv?=
 =?utf-8?B?Y2lDSTVzd1ZacHViSVBMeEU4V0NzL1JIaTVHb0swYi95VllTWXF4Wk9lWndM?=
 =?utf-8?B?ZkF5SU5uWW1VMVYwdjZCN001VTZXTlUzNUpSbkhWQlA4RTZWQ3ZocUg2aTlD?=
 =?utf-8?B?Qk1GMHUzaDRXK01YanNoeVBtcmtFUjV0L25pd21FQzlaUjFUZmsrQVB3SlBF?=
 =?utf-8?B?ckNZNkszY0NYQkVsVnBWdmZsMnZZdjRubmh2TjFzM2RrUEdwSExTN25WcnlN?=
 =?utf-8?B?MWFSRmZETklPYSthM3U5NFZmS0VoOEg5Sm1YbzBzTCtod21MZ3FrMGZRYklX?=
 =?utf-8?B?Ky9aZWxxaXlrL0M1ekNYakdnaStRcVl1VlJISzFMMnR3bzBtdjJzck50dzl1?=
 =?utf-8?B?ckxxMVVQdHBSZnp3ZlJXYXNnT01ENmVXd0NPVEZMRDB0R0ZWR005UkgzRWVn?=
 =?utf-8?B?TmlYN1Vibm1RK0t2aXRDNTY4eWJVMWJvMDVOSjVtT2lIbEsrMWwzTE1ycEtm?=
 =?utf-8?B?emhnSUZGNStkODhGdE1mUVB2bkRSVzFSYlRHb3oydXFsNWJ5d2ltZWdRU1Nm?=
 =?utf-8?B?ZjRqenRDZGZGTmRQZUlSTnd6TjBkR0hKZGlLNVNGZitHWlR5aC83bUVvWUtH?=
 =?utf-8?B?QldKenVGZ3BBaVZCaVRGN2pvSHRBbzhpOUViS0k0Ri8vTklHQzhGejRVYUY2?=
 =?utf-8?B?WG5SbDgyMGZ4SkIrTzlERzFZRVh1TkRSUkY1YjNVeWlHNjhiWXEzQ2F2N3R2?=
 =?utf-8?B?SmRZcVcwQXB3TEFkNHNsSkZ2TTNlVG84RHBGWDNMY2h0K2FKNDROM0pzcFc1?=
 =?utf-8?B?T1RJU2xXbjNtbmxHcU5PbFNzWXVKbTRGSDNMMGVXVWxLOHVXbGttWkl3ZVhv?=
 =?utf-8?B?T3FqdmZiUktyb2QvLzNFVjIyZlBUeEQ1L2huNGF6K1NLUkJQOVlUbnNwc2ho?=
 =?utf-8?B?aHpIQTl0clZHdnV2cWVIbjh4S1l5bjI3WEhQTVQycTFPYVZObVV4QUFBZWNG?=
 =?utf-8?B?Mmo1NTY5QnJuc3FYbzkyM2h2bHZ2RTRoWk14c1k1UmdCa0RYaDlCZ013bERT?=
 =?utf-8?B?eVVCaGorZ2w3WlVBenNLQUVNREt4dlorUjduMjN4eUhxeFNDTkVadz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR07MB10740.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 085e3061-c5ed-41c0-0e6e-08dec30a491b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 13:56:47.6709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sRF3hoHJ08Am2lOXwY+B+PWAB6RpQvxgtuF47ugTlVz8ovoBO8ZGxTmlDEV52SGjS/cBFTiXL7jbFqWXDr0spSxMURSHpzza9/V4LPJjx0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR07MB11015
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 05 Jun 2026 13:56:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4148

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
dHJpZXMgdGhleSBuZWVkLg0KDQpJbiB2MywgdGhlIGxvZyBpczoNCklORk86IHNib20tY3ZlLWNo
ZWNrLXVwZGF0ZS1udmQtbmF0aXZlIDIwMjYuMDYuMDUtMDAwMDA2OiBza2lwcGluZyAocmFwaWQt
ZmlyZTsgbGFzdCBhdHRlbXB0IDIwMjYtMDYtMDUgMTI6MjE6MjIgcmVzdWx0PXN1Y2Nlc3M7IHdp
bGwgcmV0cnkgaW4gNyBkYXkocykpDQoNCj4gDQo+IEFsZXgNCg==

