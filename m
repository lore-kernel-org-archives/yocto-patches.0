Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B8AC79F9F
	for <webhook@archiver.kernel.org>; Thu, 10 Sep 2026 07:14:13 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.38])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8275.1789024452191832100
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 10 Sep 2026 00:14:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ericsson.com header.s=selector2 header.b=XoF71Bcl;
 spf=pass (domain: ericsson.com, ip: 40.107.159.38, mailfrom: daniel.turull@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PS78eXv2Siiwz3WfUrz6C4CgtILzC9Cw9NggAitnYNQafEPVPJqqJWtxn7eow+U+HABoRS35RbMb33mWX35M5BGvTXdXStpVRXkrwEQ9JBl6AU10RV0Ia2hvTIF6Rnox6F+iH/RLe974QpGCRi1/BuMiYj+YKYLW/XXLXbE5f/YjKy2gESTEa5wSqZ9wmL5xkVNlw3u31n59shraBYg61YnPtKqTz51CbSnfZ6B2m2M9Ksve+7mbwGhSRgmGaKtMM23bwke29H+HtIYl41hPfszhjAWbdGvmip71WIXUMRvcf4Zvc+eRaG/jzcOsrEBTuHXkE9oXVpwThCSCVmCvwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xV0tHz4GQ0czGVm3fb9Mh9wX0ME75j7FRqjNWg5gXVA=;
 b=Yoy9/i1m4boCAmZ/s4vxKqUnTP2ZGP6tnv0uOsHAXdsOduYELg4Y1eSTbXoHg/NKlAkOTyPSUOvZ/8GFtV6WrSh0g8ssEIvMDcHfg1QL+aSMhTzS4C8z6QauBsx5qwKdPLSBoONGbYcY6VnbiByEMK7Nx7gKrZQIN47UpWEyafzCpILhA7TBg32pRJIlSyaz8jGR25ZH8DbSnSmlDL40TGU2HEjrtEJ0PyhI5bDsef4sADocPdrZDnJARzwivmGAn8vgye76N5uj2yEkQmQVyXgT96/dKobBKFS144GemK7YvpVSRU8FEi85njC9cVsnW2saPahekn9ykuGMbYPX/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xV0tHz4GQ0czGVm3fb9Mh9wX0ME75j7FRqjNWg5gXVA=;
 b=XoF71Bcl4tghnwGmJz80uuaRVDSex7VKc6x7ygf+C6KmYIJbUYPlCubFXbcsSkaj4Pwj2Rrl7uOqAexVTu2fiyLn+OvQHpHh5NCFWrfE5KFuml/gZY0q6AzewU+N86478df2hOkvWhqJEMmJBaeZEBP3ya0GsjhuC05xwlMwieUodCaNPaGxlwHqjg2rvcXUKLStA4otYvSLJVhUinVqM7z/e2LzqOZ5PxvO6JEvjfAbQdrBudQp5grBVOOD4UUh77JiFWpeahyz3WssIy9Cou5t3BStro0peI7WfcsdExJP9TaaTWdWb6f++IPNXIGrxgpDgIF39nu/TGg/0fc6gw==
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com (2603:10a6:102:4af::6)
 by DB9PR07MB9954.eurprd07.prod.outlook.com (2603:10a6:10:4cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 07:14:06 +0000
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7]) by PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7%2]) with mapi id 15.21.0382.014; Thu, 10 Sep 2026
 07:14:06 +0000
From: Daniel Turull <daniel.turull@ericsson.com>
To: "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
CC: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: Re: [auh][PATCH] steps: ignore source in commit msg
Thread-Topic: [auh][PATCH] steps: ignore source in commit msg
Thread-Index: AQHdPsrjK0+nvNPdJUCjfXEEK4VEoLbF8EsAgAF6DIA=
Date: Thu, 10 Sep 2026 07:14:06 +0000
Message-ID: <5ad85174ef25d5389b9f42a53ce3b0e54377b1d1.camel@ericsson.com>
References: <20260907131252.2810926-1-daniel.turull@ericsson.com>
	 <CANNYZj-TeqYEDbrR6XLPv119e38QaPGDoA7RDTDczTnA38d2XA@mail.gmail.com>
In-Reply-To: 
 <CANNYZj-TeqYEDbrR6XLPv119e38QaPGDoA7RDTDczTnA38d2XA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR07MB10721:EE_|DB9PR07MB9954:EE_
x-ms-office365-filtering-correlation-id: 02ef998a-fbed-421b-425a-08df0f0b1a24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|38070700021|3023799007|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: 
 FV8Nh5idxE2sM1rHsE0mzeH0WqfQ0rZKSnuvNKrkzzhzfD1LnR4XjfWwRxZz3DpGxuejXs5CiVdm+ALfQZoZH5w/aKzEgPiBkFMtcIOfeH38t4XO2q9Cq6qULWIjbdJtNMebq6G5h1Macz20lEDoVWBSbSQkFrulQMClsLJ1QeeGqQfUbk6na4Sx0/SoDg8zTlg0JIbRDOheTSrMadLVQXBNr09c4uC+CI3gwLsI0v5WVitdCt99vlGDQ9wF9C5q5k53lw390CjC6oX1kVCh9V3P6eSEMkvaR5kdhaOXde8DkogFlBSkdzwo1be9+iiYm9baFa/GpEyjkU4g1PVm+Of3iIAMC5w81k/X0wbxEok2dMSS+upfqIT+SN/bmrU/oFF7hUtmqcbBosq5LpxKCw9o0ctDqE6kNfTQPMKZrcRVDS1mupZtdW3JYs9Lwsww+bE/VifNctJqbMaQDP0XzILCV6ANOCpTGw1+ZZ0tp0KTsGDUWGaqL94vdnPRqRw3xLZNa2sqCBojitxd7TDmtW1Ie9+VqR99sKkbmGNTwjMkmfqCit27KVKMwPWW9zLUSy0p9B6TlYFuvrZgELqZMgbQYhpFVap0v680DGIVy3o2ptO7oMiOj1Gio4DMPnlNFc/k2WcbYN9KwzjY9JXzbWG8qKubupfJ0TDfeZLAUkcPl7t0aiwAgREabLJur+z+matN/KKnHxDD51CoBnAWf/b4iXs2CWlosUKKtzt3viY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR07MB10721.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(3023799007)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TDcxaTVScmd4MlFrQytmQ3gzbzB5aXMwejB4aFduQzNSa1RMKytzMllzMlFQ?=
 =?utf-8?B?eGZ2N2xYNXpGWlpUS0tRb3lBSFJHOFBlUlRxamZBY25TS2pkVFhRRzgyR2RK?=
 =?utf-8?B?bGR5NFplcmVsSXFySmdDK3NhV2NWVTZyMmpvbGc3c2xtRTNQSWl3NkZpL1dr?=
 =?utf-8?B?R0xJUGZaTXZLMUtKQ1Jra1ZkOWVQZGp4ZVZkbVJ4T29wNXNZdTh3UkZYaDBr?=
 =?utf-8?B?RlRPWmJ4SU1NbGd1ZjZ0WG1VR0V5S2dmU01QNUhtb0gwQkczWEdBbjNFUjRn?=
 =?utf-8?B?eDIrNU9BbCtTb0xDNUIzNTFUYW9KZWZ0UHpUekYxQkd1RGlXeVBEb1pvdC84?=
 =?utf-8?B?R2NUaFF6cTNMV21mdThhZTltZjI3MUN5b2ZReTBjNmRBSlpMR2w1YWJvU1k4?=
 =?utf-8?B?ZTJoZTlVeHU2cFhhOWZMQ3hlU3QveGhFOWZ2U25FRHdlYjBxVm5wMFE2N3pW?=
 =?utf-8?B?Q2ZyQTNCZ1ZMdlJleUNSckNtdWNyOU8zWXpESDB4YW83VXVoSXhqWVRnVkRk?=
 =?utf-8?B?MkF1ZFMzRlMvcmxkKzJTVk5VMWxMQ1FoazRsWms0cmViWWR6dUQxUUd6MnRt?=
 =?utf-8?B?UnJPbHFNMmUvT1N6SXNZakFYTVBQSzdxY0ZlR3hBTkN4UjkrSzlJVXNZU09U?=
 =?utf-8?B?K0Y4b0NaME9HTEhad2c5NlQzemNkZnNBWFNRWXUvRForck9mTzhoSWNjb3BI?=
 =?utf-8?B?bkoybnp4aVZEUXhtSjFFZ1A1UmR6c0tCYmJuMmVhUkF4bGM1RllEb3B5dXNs?=
 =?utf-8?B?cFJ4TWFzTG5wMUREYXNZU1VrN3pVRWtZSDNza2dPQkFwSmtaczhVU2tPL1dH?=
 =?utf-8?B?bC9JeU5yTVdjaHdPbnd2YW1Pa253RU9GeGVpNTBsYWFmNGU1NkxDL1BmN3h3?=
 =?utf-8?B?bXRlTGpsUTUyQVdlNkNBMUg3U2NkMlY2S09ZRW96SlRWbGdoWEFLdVkvSXVN?=
 =?utf-8?B?d08reUh2VFRpd0Z0bTh0a2o1bjkwL0lGQUZJUFpIM1lvT1FJNk1RUWx6S29u?=
 =?utf-8?B?K1lmamdVV1duN2NldTNnKzdXRU5CcDltVXNzcjNKWjVIeGQxY05rRXlWVXV6?=
 =?utf-8?B?YUE5MWx1YUkvREZhVjBmdGFDWUgyT2s1WitYYTBZQkZkb09rUWlkazR3a2Z4?=
 =?utf-8?B?SU41VFJGWUFKZ1JZQlpSZFNGQ24yaGp0elZXM2k4aGhyY2Z2WThOUE50VWI5?=
 =?utf-8?B?TU0ybzFENGh1dW9WVXlJR0s2U0duaHFVRCtoOG9UT00vUll2K3dTamNSU2M5?=
 =?utf-8?B?a0dlbEUvS3hlNk5tSm1ueHZVNmhJcE4vK2NFWTUxa3ZzeHpKUVpTekRROG9z?=
 =?utf-8?B?a0pJdkhxbmRoN2RSNFRwRnRpaVR2OTdVWW5YN3hrWmkwWjZRQlBabFpxczVt?=
 =?utf-8?B?ZlVQRWdseVNvWURKb3JXUkhrdWpIbHRnTUxwYmFPU3ZVMkprOGlZeGQrL1V2?=
 =?utf-8?B?NlpRQnc0VHM1K3NPd0lMN28xWStNa0VGY0tsazhvSENzNVJYL05LSjg4dTJq?=
 =?utf-8?B?NzVUbVBKakd4eW00eTJ5M1BiRmRjRnJrT0ZXVVJwckZxYWt4RmVocGsrOHlB?=
 =?utf-8?B?NFV5ZDBRZlNXOTZtc2drbTk0UXN4UDBUZEFaQzdMYURhWStjTzF4TjBXckpG?=
 =?utf-8?B?UjBrZ3VFYVFpSFI3UERySVg4ZmlVQTZsZXNyRFNhK2NTbzJDMDdzdktQNi9l?=
 =?utf-8?B?YWlpbXhRRStxUjgzZVdJN2VIczBrMzRUeGJHcXBNa1dmZWpxMzU3MUdSM2xD?=
 =?utf-8?B?aUhid2lCMHBSTEdvOWVFeUx3Q0dvNzF1b0hFWjFiVXhIN0k2SllQQTd6eHlI?=
 =?utf-8?B?ck0xTHJNbG5aQUpLNVVESzk1UnZSd0N5TFdaSzR3UE4vSG9oQzZwcUk1TjND?=
 =?utf-8?B?eHBkbjExRmZkQnhTRFNOSjRsWTFsVzEvd1lrbktHS0pkOGFpQXBXcVI1anBy?=
 =?utf-8?B?YmpnTmlPUUFWenduVEttWkhGc1k1RFlUbElKQjUvcHZ5WjRDSElCRGdxbFhn?=
 =?utf-8?B?M0ZIZmFBanZBVVc0VVhNckRVM1I1M2ZnR2JacktOQmswR3h6VkhnUVdERk9z?=
 =?utf-8?B?RHA2end6TWVTWktCU1dHRlhOQWt1bHoyZjhMQ3hNMUxlOWc5K3ZpU2c5NWhk?=
 =?utf-8?B?RGtGL0h3ckNlTWtzaitPUG9Qc0QxYVN1Q2dIME9nRXNuaTJZSTFZcDRKSVFi?=
 =?utf-8?B?VXFZbStRSno0bHh6dUxualNCYTNrMWd6M0RyL0UvRzN1cnJVdnB6QlVXaWxm?=
 =?utf-8?B?TXhZYmk5R051ZGo0UVg5UjhQM1pDclFMWVpRTkdLOHIzcnlIYkZSU1oxOWdK?=
 =?utf-8?B?VHhaKzN0Z0JmTkNnY2ZrQmhnUFVOTXBzWk5XR0RaZGJ2Z1BkWFIwb25hdG5y?=
 =?utf-8?Q?L3cuKMqGbuUOOsd8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <549D5AB242A6D244AEB1ACB2E98C8C14@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR07MB10721.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ef998a-fbed-421b-425a-08df0f0b1a24
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2026 07:14:06.6836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7s9vdJwmDbp+uJ1eOLmWjE62ijJ8XcrrHYZQs32F8GiB9RHtY1KXDWbxhTiRyoUHX0aBSXHLZVJiNrPT+piF8J2bmzPbIwybuU9SZAuTao0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9954
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 10 Sep 2026 07:14:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4764

T24gV2VkLCAyMDI2LTA5LTA5IGF0IDEwOjQxICswMjAwLCBBbGV4YW5kZXIgS2FuYXZpbiB3cm90
ZToNCj4gT24gTW9uLCA3IFNlcHQgMjAyNiBhdCAxNToxNCwgPGRhbmllbC50dXJ1bGxAZXJpY3Nz
b24uY29tPiB3cm90ZToNCj4gPiBAQCAtMTAzLDYgKzEwMyw4IEBAIGRlZiBfYXBwZW5kX2NoYW5n
ZWxvZ190b19jb21taXRfbXNnKGdyb3VwLCBvcHRzKToNCj4gPiDCoMKgwqDCoMKgwqDCoMKgIHRl
eHQgPSBwWydjaGFuZ2Vsb2dfdGV4dCddLnN0cmlwKCkNCj4gPiDCoMKgwqDCoMKgwqDCoMKgIGlm
IHRleHQuc3RhcnRzd2l0aCgnQ2hhbmdlbG9nIGZvciAnKToNCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgdGV4dCA9IHRleHRbdGV4dC5pbmRleCgnXG4nKSArIDE6XS5zdHJpcCgpDQo+ID4g
K8KgwqDCoMKgwqDCoMKgIGlmIHRleHQuc3RhcnRzd2l0aCgnU291cmNlOiAnKSBhbmQgbm90IHRl
eHQuc3RhcnRzd2l0aCgnU291cmNlOg0KPiA+IGh0dHAnKToNCj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB0ZXh0ID0gdGV4dFt0ZXh0LmluZGV4KCdcbicpICsgMTpdLnN0cmlwKCkNCj4gPiDC
oMKgwqDCoMKgwqDCoMKgIGlmIGxlbih0ZXh0KSA+IG1heF9sZW46DQo+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHRleHQgPSAodGV4dFs6bWF4X2xlbl0gKyAiXG5cbltDaGFuZ2Vsb2cgdHJ1
bmNhdGVkIGFzIGl0DQo+ID4gZXhjZWVkcyB7fSBjaGFyYWN0ZXJzOyBcbiINCj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJ0aGUgZnVsbCBjaGFuZ2Vsb2cgY2Fu
IGJlIGZvdW5kIGluIGFuIGF0dGFjaG1lbnQgdG8NCj4gPiB0aGUgQVVIIGVtYWlsXSIuZm9ybWF0
KG1heF9sZW4pKQ0KPiANCj4gVGhpcyBjb2RlIGJsb2NrIHJlbGllcyBvbiBicml0dGxlIHBhcnRp
Y3VsYXJpdGllcyBvZiBob3cgZGV2dG9vbA0KPiB3cml0ZXMgb3V0IHRoZSBjaGFuZ2Vsb2cgZmls
ZS4gSSB3b25kZXIgaWYgd2UgY2FuIHJhdGhlciBtYWtlIGl0IG1vcmUNCj4gc3RydWN0dXJlZCwg
ZS5nLiBkZXZ0b29sIHdyaXRlcyBvdXQgYSBqc29uIHdpdGggYWxsIHRoZSBtZXRhZGF0YQ0KPiBp
bmNsdWRpbmcgdGhlIHBvaW50ZXIgKGZpbGVuYW1lKSB3aGVyZSB0aGUgYWN0dWFsIGNoYW5nZWxv
ZyB0ZXh0IGlzLA0KPiBhbmQgdGhlbiBhdWggY2FuIHBpY2sgYW5kIGZvcm1hdCBwaWVjZXMgdGhl
IHdheSBpdCB3YW50cz8NCj4gDQo+IEFsZXgNCg0KSGksDQoNClNob3VsZCB3ZSBoYXZlIHRoZSBt
ZXRhZGF0YSBpbiBhIHNlcGFyYXRlIGZpbGUgYW5kIGtlZXAgYSBwdXJlIHRleHQgd2l0aCBvbmx5
DQp0aGUgY2hhbmdlbG9nPyBvdGhlcndpc2UgaXQgbWF5IGJlIGxlc3MgaHVtYW4gZnJpZW5kbHkg
Zm9yIHBlb3BsZSB1c2luZyB0aGUNCmNoYW5nZWxvZyB0ZXh0IHdpdGhvdXQgdGhlIEFVSC4NCg0K
bWV0YWRhdGE6DQogLSBwYWNrZ2FnZQ0KIC0gb2xkIHZlcnNpb24NCiAtIG5ldyB2ZXJzaW9uDQog
LSBmaWxlbmFtZSBvZiB0aGUgY2hhbmdlbG9nDQogLSBjaGFuZ2Vsb2cgdGV4dCBvciBmaWxlbmFt
ZSB3aXRoIHRoZSBjaGFuZ2Vsb2cgdGV4dA0KDQpDaGVlcnMNCkRhbmllbA0KDQoNCg0K

