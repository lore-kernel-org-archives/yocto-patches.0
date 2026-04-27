Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF2FFF885E
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 12:30:53 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.33])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44082.1777293043684378438
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Apr 2026 05:30:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ericsson.com header.s=selector1 header.b=NtDhn9UM;
 spf=pass (domain: ericsson.com, ip: 52.101.65.33, mailfrom: daniel.turull@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKE7n6buvyQybcEPl7rIteiLwJSgWpEkyzK68PHdR2czsQoHl9p5CLzDPC3+So7F4YGj99UTrJjOUYxRapRjrp9clHJaPeNsfvtL05D++4w8pt7GjQzM0Lz2/DxWeLSwBi+qZECtbxZevy5t3HJATrWDv7CofbhX+lLFywqAY2j1erajIYrq0T2W/oljsoYd/EH6lJtLatHH6+8dLuaSI3UptaNc5TGv2d80yDWXMWhlaikzdRLLgsh/9jA+1dPA1VUbg1R6xQeFZB5Weu0f6XUIaVb7f1UCKvMmi1+oTJ7k6WnZliJTGriZkJP2I8jJK7zcZkZvwFGWQYuPj+xPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thIp9m1cHZLsvkFYLuNDThi4K7wCt1zih5CJT8/YoNc=;
 b=MguFdb3esstZ9gL2UHzc7cbYCA3It2IJhNt4K293fa2EHF3Gol1W9qFBizvCcUKyRdsxpOQsfkU8dDMoMK/Ib9Uvp6BhM0hDajE8PPS1cRs4rbl5gezMFE7UC++R/af5qK7iB9MpOfmqJ1BK5lhT0hfGmrVaIvNM7XsYH1Tk6ItwZtaV1N129PUzRoQCqG/gvZJ1Pe+rK2yV84qpH3LRlyWEJ0c+8ajqmzRYGgutJ62E4Hr0JVB/cbRN2ItRGi8/H1I1qLnqC4Euj4dgXzfRICf08WR2lLPToNOU0iWCaiiZvQ5TRKEVkXRexyIvh1HYmbhlH+b3phWjzliVzXfQlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thIp9m1cHZLsvkFYLuNDThi4K7wCt1zih5CJT8/YoNc=;
 b=NtDhn9UMiQVumd1WcgZDsVOuOJaxhCOhu3JGOWpZqIJiyctI9X8jj72rcmB1ZwHaG4+dyqoOk4D9Wv4cgFPECN2NNsXfY9SSq7WjhgwbqVaHEbGnm7DORoXCouKtof3ZLsE9fxZ6IVOoKzjRJBpLkeMPQf7NhGWKsddNX4k5ZJawkgmTKicMB5AQ4rUTdMjI158Dynx7qFu7Ev+qtHjC/aiKaXPSwyIubYQzs/BoKLuOLmsipuva1SHcNMI3HTfkZ6u2/oj3Gt2QmJfffcL83BqEoC1rWrx+p2SSNpo8rx9Jfc7kJQkqZIvtlcBDOxbNfdVQc9+tE7XLUK8LXOQqoQ==
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com (2603:10a6:102:4af::6)
 by VI2PR07MB11055.eurprd07.prod.outlook.com (2603:10a6:800:29e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 12:30:39 +0000
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7]) by PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7%7]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 12:30:39 +0000
From: Daniel Turull <daniel.turull@ericsson.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>, "paul@pbarker.dev"
	<paul@pbarker.dev>, "ross.burton@arm.com" <ross.burton@arm.com>,
	"yoann.congal@smile.fr" <yoann.congal@smile.fr>
Subject: RE: [AUH][PATCH v2 6/9] upgrade-helper.py: Add minor option for minor
 version upgrades
Thread-Topic: [AUH][PATCH v2 6/9] upgrade-helper.py: Add minor option for
 minor version upgrades
Thread-Index: AQHc09/zuG6hlu0Bt02SadCi8eBMjrXyt6aAgAAKReA=
Date: Mon, 27 Apr 2026 12:30:39 +0000
Message-ID: 
 <PA3PR07MB107211FACF80A58913CC8032F8A362@PA3PR07MB10721.eurprd07.prod.outlook.com>
References: <20260424114603.2444938-1-daniel.turull@ericsson.com>
 <20260424114603.2444938-7-daniel.turull@ericsson.com>
 <CANNYZj9xmzFLVb0ECP7LYbvtf09rafXc0CbAz7o31gNdZE6CkQ@mail.gmail.com>
In-Reply-To: 
 <CANNYZj9xmzFLVb0ECP7LYbvtf09rafXc0CbAz7o31gNdZE6CkQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR07MB10721:EE_|VI2PR07MB11055:EE_
x-ms-office365-filtering-correlation-id: 060e82f5-8357-442b-d88d-08dea458ca7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|38070700021|13003099007;
x-microsoft-antispam-message-info: 
 /vc+dF7aCGUq/taXNUmND7RxgifiJvVJsOehhYUcxXIsT5UAepS/xHmZTBbs0cn058qQYJaimezouC3MzJ2XWixYxj8seHSxBAAIEubzwfcrYr3IQ8cSFOa2bYKHzV1zX8CILNgTUF5RpqfOHkrpOu5d5zhdN0Z8nbnvADBCNYYuc+IMQ6sDPBSEZyosh02YYSIBRofJy+nT3Q/6F/N7CAxaeOJW6KdGUXlNlcQiNhwkYsDuEBNNZfIyeVFa051sNN51Pp17UUJbs611naIil2dSKYehysoaNjtMwh+/2lwtXY4j94LT+h5Ba6NTS0ZbeatKZDBo4BUyuI2O030qc3tm5AEx77VYBKmsKQV7xvV+NZ3A/5aI2TCzbEBiPlK2X1/zwuwGJFlBerycmCMeF/4lqyqgUEQ9hDtpOju0dMk7ohBgx8flRDh2PAfTg1USzr/8ZBVWcw2eUxpdwg58mTtZinClBk4snrB9nU0O8Hqh/fB6fTBb6KMKpaHKhwm3O+Y94u8PISe9whV8A+QkDtCl7BCIyhSwYtC+/dVgLDG4nXrw5nwjFPkmMGlPIAFOBt+wcDA41dlk/t6x1aC+3YOk7lrTOdONF3qwJYGoP3k7LJyIt1stEOZ/SeA4zhdc8X3Cvpx6vzfW2GTTePu+ci4as6F/UgEGf55jUevdD07qUtpLM+jgHLQfkiBV7US+Oc17JhDbYEJMkYn6tDVAxsOpKcMKRPvE3vUs5UzVZl9BH9j1wyufPWDXrQkHWVake76eNql+675uRFyskBNJd7zTpZ2DWoSJGhuciD8T3tA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR07MB10721.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(38070700021)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dVJLR3RNYkI1SkZha1QwZ1RpSEc5S0tFVmo5YlVOTHBjdUpyNmtRN0NsSDRD?=
 =?utf-8?B?Nldjb09SL0dSU0dRMWJ4bkJVc0xaVjB4UThOVGdMV2JTUTF3UGJaWEhBTm0z?=
 =?utf-8?B?c3Iwc3hlb0NxMTRvVEJ5Q09ONEtBSjg5S0RzVVkvSVJHbFpnSGtpcFBmbWpx?=
 =?utf-8?B?K3VsY0ZYSEFxU0tJbEtQUktLRVpBUEY2eGxNQnlhVTJBSHVNSHJ5YThhSkE4?=
 =?utf-8?B?c0RXV05MQ0NtTkdzOUdrZVJaVG9LeVBRNklsSUl2VGc3bHByNEZQbk5SZG5S?=
 =?utf-8?B?aklOYktjUVN4akdnZ1h6bms0THdpYlU4NmZleFE4aXB4cTcyY09xZUxGdFU2?=
 =?utf-8?B?d3FRM0hPUGZTbTl0Tlh4dXhCbXhiZ0ZvNU1sWTdGaWZvM2k0THJ5eDA5MEVP?=
 =?utf-8?B?UEZxak9WWjNaU2h5Rmd6YkZwMUV2c055MU44UUhEaE1HSzZQUElpb2k0Rk1z?=
 =?utf-8?B?UWV4VmMwWUNkazJMSDQ1bWhrbFZkcjRqRXo2UXB4b25qeUJxY2dhN3h2WFhy?=
 =?utf-8?B?NWhuK3BMTEl4bEVsQmJIVDRHYWIwVndlMlhIN2MyV1AzUzU1YzlvbS9sL3Fr?=
 =?utf-8?B?R0VWWTlHcWkvNlVMa1hQSUNqdFFKUm1qajg1b1BOdHZyZTVaVW1jaXdldmFa?=
 =?utf-8?B?dXpmL3RCTnIybDBBc2dvQlZRU0x5QnRZWno5M3ZYb3V6cEdoZDdkcjdFRWRD?=
 =?utf-8?B?Vmd2dzRzWnYwU2tTemNqSS9JSU4wVkNrT21OWHNLdmpQR1NLbHI5VTBoOUZw?=
 =?utf-8?B?NFBjWmpFUFRVTjhaYlpjV1lLb2Q0ZzhQVlZlS1gvaE9UN2c3dlc4N2duNVMv?=
 =?utf-8?B?NTVOZFA3emJ5YjV0VkoxM1l3MEVhWnpyS2NwVjhSY3RDR21VTCtkMlk1bHlv?=
 =?utf-8?B?emJPd2M4SXlyMlloWWFESmRaa2U4TnB2Slk2QVZ3R2dqVFc2d1RTSGNid0gy?=
 =?utf-8?B?bGlpTk0veFE3SzBqbEZxdmt4bmJxWFdaaDJHTHlnaUVCOXV6L3RoN2lVMGpO?=
 =?utf-8?B?aUlEWkgyQk9UcHJkOTB0bk5YMUk3U0JvVFBIMU5PZUtOWGJlT1NSTHVDR2ht?=
 =?utf-8?B?bXVSOGdVUkRmb0RRVEN3M1RWcWVPTW90MWVBRDJaZDFkU2IrZ3l6QnZkbjBI?=
 =?utf-8?B?UG9maE1PUmZMVSs4emtmUXJybjAzbFBKUmhwdHg0UStjT2Mxb0ZWR2tqb3Iz?=
 =?utf-8?B?Y3Y5Q0pUZjNUMUpBbHdRMjhzek1HWmo3QnFvWU9Jc0hMNlhReXRuaXM0K01C?=
 =?utf-8?B?TmJnTEJNZWw2dVZvaFNuYXF4LzJzMjB3VGZ1djJzVlRiQ0FrWjNUR3ZiQmNC?=
 =?utf-8?B?WFZMK3Q4TGpZVVlRUm1OMWlpTTdobVJ5SXdUQjN1VHg1L2pia0JieStiV2M3?=
 =?utf-8?B?NlRFeUQvMFM4YkJlaGg1SVNRQXdKSHUwT0I4N3dOaXlKTHU0WE0vZUlXNVdQ?=
 =?utf-8?B?MDc3V1BmYzR1L3ltOUpsSUx1VklNNWFKS1VHb2tudTVaTzJqQnZnUytuOElx?=
 =?utf-8?B?dmM2d3VXdlIrL01ldWozcXJuWGVhby9KTlBNK2lQa1J1WFlFQXNWYzNXc3RJ?=
 =?utf-8?B?QUNpOWRyTHJKQnNXSTJLNWFjMWxja0xkSUVubDQ1d0dXSnBESHlZRllwQVB4?=
 =?utf-8?B?RlAwcFJnNXlFa3FYbE9UZ05LdWhkemllZk5ZcEpOQzZTczFWUnN1dS9SbGhI?=
 =?utf-8?B?Y1g1cDEzNkVtL1JTUHcxYk40WitzNjgreVNybGVHcDl3OFVZbDgzaUJKV2ky?=
 =?utf-8?B?VTRqRzRSRk83U29TVWUvcHBsZDlBdllLMWlyMHAvWWlkUytJY0loOUtVMXp2?=
 =?utf-8?B?K2J3MW02TFNERXQ4U1NpVnE2TTlKU2hKdzUzMWk4OEVyNDBuMzJMY0E2UGF2?=
 =?utf-8?B?NmxhQThUM2lNTFdRTVZpMHlwY1pXL1hZbWhhdmxYZnZQZWZwRk9hVlVnU0pI?=
 =?utf-8?B?U1FSL3RQb3VVcW03MTA2WDBjdUtEWjNtYkI5aXA0THN3TTRwRis4VzBWZGxE?=
 =?utf-8?B?WnU0dmVEOHFlVktpT3JDTVF4QXpRcVB2QTdQZEo5bEFCaHpJUTczMnR5RG92?=
 =?utf-8?B?c0NiWFlVV3NPbWN4WDFWREwzNzhWUS9uYU1xelB2akptY3M2QzFxdURROUNa?=
 =?utf-8?B?MW43Qk5IbUdXbVZqZUdyWllvNitveElDK0hZNmVVTXQ2dGRWRGVMSDNBMUhq?=
 =?utf-8?B?VlQ2RWRoeDkzalVKYWhtVGovK2tXQS9XeTJLVkh2Y0VwLzYvUnFOQ2xFeDNo?=
 =?utf-8?B?NWVsdDRjSDd5UmNMbC9WNnl3aUl0Tm1PMS8wRXErMzJlc002S3llVVQ0RUdZ?=
 =?utf-8?B?VXNIb2VCRjMzUE5VUCtPNzRaYmxFSWdOdEhxVjV6SHFISi95RG1ydz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR07MB10721.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 060e82f5-8357-442b-d88d-08dea458ca7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 12:30:39.3965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ss70/Bjvo9bHGbs83RAOhdjsq8OhqC14R0PW/nvqZNa1y7rO4m94GqZXVTuAt245pm1fL8qMrWSnC6kQKJ2dmbPvrN2uNnnb+k3E2E8c3ms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR07MB11055
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 12:30:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3841

SGkgQWxleCwNCg0KVGhlIHdvcmtmbG93IGlzOiB3aGVuIHJ1bm5pbmcgQVVIIGFnYWluc3QgYSBz
dGFibGUgYnJhbmNoIChlLmcuIHNjYXJ0aGdhcCksIHlvdSB0eXBpY2FsbHkgZG9uJ3Qgd2FudCB0
byBwdWxsIGluIG1ham9yIHZlcnNpb24gYnVtcHMuIC0tc3RhYmxlIHJlc3RyaWN0cyB1cGdyYWRl
cyB0byBwYXRjaC1vbmx5ICgxLjIuMyDihpIgMS4yLjQpLCBhbmQgLS1taW5vciByZWxheGVzIHRo
YXQgdG8gc2FtZS1tYWpvciAoMS4yLjMg4oaSIDEuMy4wKS4NCg0KSW4gcHJhY3RpY2UsIHRoZSBy
aWdodCBwb2xpY3kgZGVwZW5kcyBvbiB0aGUgY29tcG9uZW50LiBGcm9tIG91ciB0ZXN0IHJ1bnMg
b24gc2NhcnRoZ2FwIHdpdGggLS1wcmVidWlsZCBhbmQgQUJJIGNoZWNraW5nIChtZXRhLWJpbmFy
eWF1ZGl0IFsxXSksIGV2ZW4gcGF0Y2gtbGV2ZWwgdXBncmFkZXMgY2FuIGJyZWFrIEFCSS4gRm9y
IGV4YW1wbGUsIGxpYm5vdGlmeSAwLjguMyDihpIgMC44LjggaXMgYSBwYXRjaCBidW1wLCBidXQg
YWJpZGlmZiByZXBvcnRzIElOQ09NUEFUSUJMRV9DSEFOR0U6IDIgcmVtb3ZlZCBmdW5jdGlvbnMs
IDQgYWRkZWQgKGEgYnJlYWtpbmcgQUJJIGNoYW5nZSBoaWRkZW4gYmVoaW5kIGEgcGF0Y2ggdmVy
c2lvbiBidW1wKQ0KDQpPbiB0aGUgb3RoZXIgaGFuZCwgbWFueSBtaW5vci1sZXZlbCB1cGdyYWRl
cyBsaWtlIGN1cmwsIGxpYnhtbDIsIGFuZCBlMmZzcHJvZ3Mgc3VjY2VlZCB3aXRob3V0IGFueSBB
QkkgaXNzdWVzLg0KDQpTbyBpZGVhbGx5IHlvdSdkIHVzZSAtLW1pbm9yIGZvciBzb21lIHJlY2lw
ZXMgYW5kIC0tc3RhYmxlIGZvciBvdGhlcnMuIFJpZ2h0IG5vdyB0aGUgQ0xJIGZsYWdzIGFwcGx5
IGdsb2JhbGx5LCB3aGljaCBtZWFucyB5b3UgZWl0aGVyIHJ1biAtLXN0YWJsZSBmb3IgYWxsLCBv
ciBsaXN0IHNwZWNpZmljIHJlY2lwZXMgd2l0aCAtLW1pbm9yLiBUaGF0IHdvcmtzIGJ1dCBpc24n
dCBpZGVhbC4NCg0KSSBhZ3JlZSB0aGF0IHB1dHRpbmcgdGhpcyBpbmZvcm1hdGlvbiBpbiB0aGUg
cmVjaXBlIGlzIHRoZSBiZXR0ZXIgbG9uZy10ZXJtIGFwcHJvYWNoLiBTb21ldGhpbmcgbGlrZToN
Cg0KQVVIX1VQR1JBREVfUE9MSUNZID0gInBhdGNoIiAgICMgb3IgIm1pbm9yIiBvciAibm9uZSIN
Cg0KZGVmYXVsdGluZyB0byAicGF0Y2giIGZvciBjb25zZXJ2YXRpdmUgYmVoYXZpb3IuIFRoYXQg
d2F5IG1haW50YWluZXJzIGNhbiBzZXQgIm1pbm9yIiBvbiByZWNpcGVzIHdoZXJlIGl0J3Mgc2Fm
ZSwgd2l0aG91dCBuZWVkaW5nIHRvIG1vZGlmeSBBVUgncyBjb21tYW5kIGxpbmUuDQoNClRoYXQg
c2FpZCwgYWRkaW5nIHJlY2lwZSB2YXJpYWJsZXMgdG8gYWxyZWFkeS1yZWxlYXNlZCBicmFuY2hl
cyAoc2NhcnRoZ2FwKSBtZWFucyBiYWNrcG9ydGluZyBtZXRhZGF0YSBjaGFuZ2VzLiBUaGUgQ0xJ
IGZsYWdzIHdvcmsgdG9kYXkgd2l0aG91dCB0b3VjaGluZyBhbnkgcmVjaXBlcywgd2hpY2ggaXMg
d2h5IEkgc3RhcnRlZCB0aGVyZS4NCg0KV291bGQgeW91IHByZWZlciBJIHJld29yayB0aGlzIGFz
IGEgcmVjaXBlIHZhcmlhYmxlIGZvciB0aGUgbmV4dCB2ZXJzaW9uLCBvciBrZWVwIHRoZSBDTEkg
ZmxhZ3MgYXMgYSBmaXJzdCBzdGVwPyBJIG1lYW4gb25seSBvbmUgb3B0aW9uICgtLXN0YWJsZSkg
dGhhdCBjYW4gcmVhZCBBVUhfVVBHUkFERV9QT0xJQ1kgaWYgcHJlc2VudCBvdGhlcndpc2UgZGVm
YXVsdCB0byBwYXRjaD8NCg0KWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9Ob3JkaXgvbWV0YS1iaW5h
cnlhdWRpdCAoaHR0cHM6Ly9naXRodWIuY29tL05vcmRpeC9tZXRhLWJpbmFyeWF1ZGl0KQ0KDQpE
YW5pZWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4YW5kZXIg
S2FuYXZpbiA8YWxleC5rYW5hdmluQGdtYWlsLmNvbT4NCj4gU2VudDogTW9uZGF5LCAyNyBBcHJp
bCAyMDI2IDEyOjIyDQo+IFRvOiBEYW5pZWwgVHVydWxsIDxkYW5pZWwudHVydWxsQGVyaWNzc29u
LmNvbT4NCj4gQ2M6IHlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZzsgcGF1bEBw
YmFya2VyLmRldjsNCj4gcm9zcy5idXJ0b25AYXJtLmNvbTsgeW9hbm4uY29uZ2FsQHNtaWxlLmZy
DQo+IFN1YmplY3Q6IFJlOiBbQVVIXVtQQVRDSCB2MiA2LzldIHVwZ3JhZGUtaGVscGVyLnB5OiBB
ZGQgbWlub3Igb3B0aW9uIGZvcg0KPiBtaW5vciB2ZXJzaW9uIHVwZ3JhZGVzDQo+IA0KPiBPbiBG
cmksIDI0IEFwciAyMDI2IGF0IDEzOjQ2LCA8ZGFuaWVsLnR1cnVsbEBlcmljc3Nvbi5jb20+IHdy
b3RlOg0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICBoZWxwPSJleHRyYWN0IGNoYW5nZWxv
ZyBiZXR3ZWVuIG9sZCBhbmQgbmV3IHZlcnNpb25zLA0KPiBoaWdobGlnaHRpbmcgQ1ZFcyIpDQo+
ID4gICAgICBwYXJzZXIuYWRkX2FyZ3VtZW50KCItLXN0YWJsZSIsIGFjdGlvbj0ic3RvcmVfdHJ1
ZSIsIGRlZmF1bHQ9RmFsc2UsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgIGhlbHA9Im9u
bHkgdXBncmFkZSB0byB0aGUgbmV4dCBwYXRjaCB2ZXJzaW9uDQo+ID4gd2l0aGluIHRoZSBzdGFi
bGUgYnJhbmNoIChlLmcuIDEuMi4zIC0+IDEuMi40KSIpDQo+ID4gKyAgICBwYXJzZXIuYWRkX2Fy
Z3VtZW50KCItLW1pbm9yIiwgYWN0aW9uPSJzdG9yZV90cnVlIiwgZGVmYXVsdD1GYWxzZSwNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgaGVscD0iYWxsb3cgdXBncmFkZXMgd2l0aGluIHRo
ZSBzYW1lIG1ham9yDQo+ID4gKyB2ZXJzaW9uIChlLmcuIDMuNS4yIC0+IDMuNi4wLCAzLjk5LjAp
IikNCj4gDQo+IEknbSBzb21ld2hhdCBjb25mdXNlZC4gV2hlbiBhbmQgaG93IG9uZSB3b3VsZCBi
ZSB1c2luZyBlaXRoZXIgb2YgdGhlc2UNCj4gb3B0aW9ucz8gV2hhdCdzIHRoZSB3b3JrZmxvdyBm
b3IgdGhlbT8NCj4gDQo+IEkgc3RpbGwgdGhpbmsgaXQncyBiZXR0ZXIgdG8gcGxhY2Ugc3RhYmxl
IG1haW50ZW5hbmNlIGluZm9ybWF0aW9uIGRpcmVjdGx5IGludG8NCj4gcmVjaXBlcy4NCj4gDQo+
IEFsZXgNCg==

