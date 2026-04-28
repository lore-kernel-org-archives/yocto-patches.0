Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFE5FF885D
	for <webhook@archiver.kernel.org>; Tue, 28 Apr 2026 11:27:53 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.60])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10816.1777375663870460326
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 Apr 2026 04:27:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ericsson.com header.s=selector1 header.b=wyNjP5k9;
 spf=pass (domain: ericsson.com, ip: 52.101.84.60, mailfrom: daniel.turull@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUsPLNGpUdI2JP71197zAp7hAtxWiL864t4Hlt0DZ7lk69FzybCOMGECyCHkHMmAwkowK2zXHnC81CGqY5tiqeRazjS0KQxH4jU5sG9DN07W1EpF1OWSxJXLlx04RPZx9Tr1sNY3yURaV4DdYjqzxAifjYOaS37HkvvxnRjTTEJO79Oc+jUXpUyHlZqwcXj6O+F2zi9kkkgzoBkc+sjM3XDmuaHHVnRH35RMYOXISNOHqnXDsvDp8mA5p0iPR488wWYXJsTx6/WdGmfygA5TrzYGvUq/GORq2Zj4zZTB1o2kDE1hKvvJPtpXVcQXr66MAKTpfsA3VwZtvnQnjxMozA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pi2miPX4E+Xl2juarWt5INwhqgilBT9GR8CAUIzhij0=;
 b=CZwmbyfKK5yoiEagzaVSSAWvsu0T4PnmpoIUFk+qtbwXNKKqNOM3assU2QI6qdWqqztS77ZWEuc0DDvI8A0sc+bNaT988tpuLAQoO/tzvlLQ6iFJpIFN4Mx2EeL4PUcAf/o1Bl0cZd7ypBk3NtFO2+vpmVhiB1MfsusPl6jJ8teytsdGA08xn899QOqd8UWGak7MjZwYBIrCelvyYqbaFvohP4CaaxY0C1jeHW8UV4bN0KxEKOwtSteEfBPHE741TsrJLscA8nr4UFU07BMgGb5K/N7cx4PvMoULE4RzjssKthWGPBf3UzN4PicB27jqCkGrozqthgUqZkFCdO0Ukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pi2miPX4E+Xl2juarWt5INwhqgilBT9GR8CAUIzhij0=;
 b=wyNjP5k9EZoCdT3lShfxqfuRJxAm5ZuMdX6Sfvn9H3LV41gleM3zEx7SETi7S8d9Z8rjQxVsZRqtdboDGWhnX7N9cJurt3XlzCLc2SyTBK+l9WLALGgo/K+Eo7KAwqKeQn6AnQqwXRfP3WwGEyXgp24Gp26YojDIuErVAXZdRaLXQ/BWplczsbikL+zq9RNfxNzfh2Pz2O0KczubUeC03jICa+WgGDGVD6cwy1CblBb5//FMPQxyJIHD+MpIwtowtUtX6r4YbwUy+axgydBsBXCcq0t+8tj3Y3TfHLpSooFgXDcHOrRa+oF8LsNmLDEI+7qEdnrhOeAM1AobseIOFg==
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com (2603:10a6:102:4af::6)
 by DU4PR07MB10206.eurprd07.prod.outlook.com (2603:10a6:10:585::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 11:27:38 +0000
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7]) by PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7%7]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 11:27:38 +0000
From: Daniel Turull <daniel.turull@ericsson.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>, "paul@pbarker.dev"
	<paul@pbarker.dev>, "ross.burton@arm.com" <ross.burton@arm.com>,
	"yoann.congal@smile.fr" <yoann.congal@smile.fr>
Subject: RE: [AUH][PATCH v2 7/9] upgrade-helper.py: Add prebuild option
Thread-Topic: [AUH][PATCH v2 7/9] upgrade-helper.py: Add prebuild option
Thread-Index: AQHc09/4c7c1MZAjFEG/1GF3qnvlNrXytwGAgAGkfgA=
Date: Tue, 28 Apr 2026 11:27:38 +0000
Message-ID: 
 <PA3PR07MB107210D1242154BB782680D3F8A372@PA3PR07MB10721.eurprd07.prod.outlook.com>
References: <20260424114603.2444938-1-daniel.turull@ericsson.com>
 <20260424114603.2444938-8-daniel.turull@ericsson.com>
 <CANNYZj_e0Ms7DhyaxUT2Jx_ijkarVGSzuHW+NPpf1Q2ikPCOoQ@mail.gmail.com>
In-Reply-To: 
 <CANNYZj_e0Ms7DhyaxUT2Jx_ijkarVGSzuHW+NPpf1Q2ikPCOoQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR07MB10721:EE_|DU4PR07MB10206:EE_
x-ms-office365-filtering-correlation-id: 3eed071b-4075-4659-688d-08dea519273a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 
 MHng3mXDfNeMELWN+EazMmBTYYXD/lp/q3vHqjR2IzPgJr0I8nDetbEgM/s23lsaDw545X5Loixlq5MOXNf8PwUS8UJB5DpPXYFu6bHuZTAshQdj2zJrBF0CQEi/hAWCxRCsyPOdsbJY1yV4ZXtMgGwq1h1HoPAQYGb++1A3a38XYW3ndnmFei74ds9SomIZNSrPV3v5nj7n2FLEt5i9UDknisrrU+osyw/RqBS2qmiQre7sCWmL6m1FSnKDwKoEB/6DKA3B2p4f7TPRCa0PoKctyIQlGicWf2JsXKHd/MSsaxiv4ZpmhStcb61jzrz7Sq2DVG6P+uyHauMRSnLAUXtQW3nKxQjuYRpFCG/pURwKnk6cpf0qdUSkINELD9QZpUdTuo75LOsdYB3bF3MT3w+2i3n6JXIznijKZiiEzUsEr1fz4A/MDbu6UBVPhE4jgy8T4AH+ypg280FWT18f32jzIyvt9MJKpAUZkA82Gh17QaR4EoxgdHVXxqJbLI1daSddohXpuOwWBj+pbyh1UGLOuuFE3Vbn9hyy7e5C6LsRuSVBxSqzCCwMweSfP9y3XcA5WyXQ9fe7hcy1OPzz5h7pDMjF4hmcuKguni5Bhnw+3J7kPHJz7O6LiTW08bigay5zISfBOMtyFGhFB+y2B+Hict+Uj8AtbR8He9kVsWNTwbOTrqH5h4L7OWEbfRV3aNlLVZ2WT9lITkPQb7N/Zu5rR/Dtkkd9MukLPC9e04Z6cNCIezsywsP6f53QrlhJmCnqXrIMlgBNxzDjuyE2gbXicfViFOY9t0wuaENI9BA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR07MB10721.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?a0tOMUkvZjJTZmtTUEtjQ0RydHZESS9yRW1TMExpZjBoQVoyUTROa1NEYlNO?=
 =?utf-8?B?b0pma1VKRmY2eHlSMHlXa0czenJJaVM2VFdDNlhNdzdBU1NoSkxHUTEzTUo3?=
 =?utf-8?B?azJPVW4yY0p6ZTFZdTRCRFd4SC9kZTlORStSSzlVVDhvK29GeHRDUlN2TUlG?=
 =?utf-8?B?R2xWcnEyNVRUdW02RW1ZNUQvTDRlY1lnNVg3eTUrTkpvaExZOGR1MnFWMWhx?=
 =?utf-8?B?OGZiTHhoY2pSTU1wVno4ejBPRXlJV0xiYkNPSXFSZWd1MDR4ZUZ4SmdnWWZE?=
 =?utf-8?B?OVVzN1UvbDMyQ1U2WlJGUmozdDNkZ0ZkL0dFT1IvYUZjeWhRNjZhM01qd1NB?=
 =?utf-8?B?RjJnaGNtQVRyVHl2My9sd1c5WmpRZ2hUOERSZTUzVGtocE9vT2dHRm4xaG5T?=
 =?utf-8?B?Y25LcWRwZStLQkxjV3JydXhYQkdEcmVNTlF0QUtmWU9jekZMMng3Y2RXaUlW?=
 =?utf-8?B?ckNSTnErczVTay94TVk0R00rN01saTlWQks3MjN2d05qbnZyMmduSTNublNn?=
 =?utf-8?B?OHg1aUFidXljUG9Na0lsaEJDaUhxSUdzbDBUM0puYzFrdmVBeFBsWCs2bEt3?=
 =?utf-8?B?aHRkZG8vZEJFSGdMUWtQUlFZRm5Jdy8wT2JEamd1SitYSHhUWndpa2podUdr?=
 =?utf-8?B?d3k4WDQ4dks3eW8vTE9EUkF4SkJyTjF3ZmVRYmJGdFpIVGR3K3c4UXIxRjVt?=
 =?utf-8?B?d0hpSlh3R0tjVVA4Wm1vNmhVVGRmL1RXOWlRRDdXZE5FTUhhLytBUVBXRnRQ?=
 =?utf-8?B?TTJaS1ZXQng1b05USVlHeG94OUhIR3JFQ3ZkUmtteGdiZkRZWTJub0RjWE9p?=
 =?utf-8?B?SFVneURiTnM3dFk1dHA1ZHIrTElucDBiS3lKZmdCbVY5Y2lRWmQySzdHWjF4?=
 =?utf-8?B?NGh2Qk4vbnJCV1VydktXSlMwZFc0NGs4K3BDbmZDdnhTVDRTZGErWjhGcXo0?=
 =?utf-8?B?TlBUZ3MzZEtWV0duaXp0RDRPeEpTeHVpM0JvQ1ZvWFFmN1JRazd6SFljVUR4?=
 =?utf-8?B?dFhCZC91RHZ1bHAyQ2l2TzJOd3o0bHZPVm83d3BqZHNyS2hWSkJjTXhGMysy?=
 =?utf-8?B?VFVuVTNoNVRRYW9TRStOdDVkc3NSMFZkQy9zUEUzYTJjOUJwa1FoZVF0WlJn?=
 =?utf-8?B?SlYyZEIwL0xHWVFZNTZvWlBka1gvVSt3dWRlNWQ3aVVzZVVyWmJKU3FqeWFI?=
 =?utf-8?B?RGFyL1JBd0Q1TXc2VVJHT0dsNUNrWmN3UHVVanJnME9IbWlqK1dUMzQwZmJh?=
 =?utf-8?B?R0lYeitwWHdXUFFrTTU4NlpTS1hhTWhhL2k2WU9Rdll0SnVyYVVTNzZxVHBn?=
 =?utf-8?B?dnRINHd3bG9haUZmbTUwWDZaWWowclJzeGtseXZFYWNBbjBqcTQzVldoS0hT?=
 =?utf-8?B?N2w4WUFEOGdReERsVitmOVJsUEhyeGRKaFVPTnZNTVFYRTFmMXZRdDBXQ1RJ?=
 =?utf-8?B?bGE3SENraDNYSERRbk12Zk9PZU1YS3g1V0RyVVI2S2toSldGZVNVMnJMZmpi?=
 =?utf-8?B?M1l6dXM1VTJsZW16L29LK3hMK0VNL0VicDY1Y2EySm5TMC9hV0pTT2lrTzI5?=
 =?utf-8?B?YkdnNFRiTTZybW1zRmd5K2xZZk90TzlDT1hQOStvaWF5S21TUmllbDNmeFRR?=
 =?utf-8?B?K3FZOVNuZ3FTS2hnSy9HdWNjYWMrTWRNY1VsSENsREdNRlpOdGYyZ3lNdjEr?=
 =?utf-8?B?SHJDQ0IvZFpkRzVIWTRDL05oRG5uNitHYXFRaVJoREkrNjQ4a3FZNEhxNWZr?=
 =?utf-8?B?eUVUc3MzZjJXZUd5T1o3V0xQNkVFZkcybmk5VkNLRlZkY09YaWpRRVEyc3cy?=
 =?utf-8?B?aWlWVSttMGpQaE5FM1pHdlUveWJHcHQrRGlmZFZlSlJwNFBCRE8zNFhTNTFY?=
 =?utf-8?B?aUEyZWxhRGNFbk1WS3VFNFZuWkUva0Zwek9MbEg2V0xja21Kd0lmQTRwSEtB?=
 =?utf-8?B?b2o3dHlUWkFva1YvcENjSDQ1RXBKWlBlUWRtVGtEbzRaU3RQUGpyc2ZyeTh2?=
 =?utf-8?B?SEFkUHdrQ2lScWFVNFlwN0VTcmt3MmVPTW5ZZkd6VDJ6UWZVdExFVEFrWG9F?=
 =?utf-8?B?aWR2UE1zUTc4MVpiL1lRZlE1SFN5WTYzYTZ3S1plTExPU2dkallxWFFRbU03?=
 =?utf-8?B?V2pJNWg3RmhyM0s1UmhFU0RMVWJzVHByQVo3SUJ4cGpLNFhoUHVvb3BrNEVo?=
 =?utf-8?B?OXJmd0J6Rk9IRnhRbkRTVzcwS2J2TzMvdnRSREdGNVRyTnpOR0liYXU2Rmtp?=
 =?utf-8?B?L0RMM2Q4RlV6Wk8wZ1VVaTFJUDEzNCtaemg2WEVYYTdlUFd2MFJaMHI4U2oy?=
 =?utf-8?B?RTloNjMzRk9jS2dCWlkybldaOGtHMmV2ZC9ELzNIMXRmMW5uRFZ5UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR07MB10721.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eed071b-4075-4659-688d-08dea519273a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 11:27:38.3559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5uMMPomyHZiT2RFznLv9hX7oRxWimjzVzOHFyUoUmhdfP0SE6fhopTeeUSmdKW6Lb+i3JbSSt5hfriMgpTBdnZrmsBOFPKh6B6EgsGLubH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR07MB10206
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Apr 2026 11:27:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3868

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleGFuZGVyIEthbmF2
aW4gPGFsZXgua2FuYXZpbkBnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgMjcgQXByaWwgMjAy
NiAxMjoyMA0KPiBUbzogRGFuaWVsIFR1cnVsbCA8ZGFuaWVsLnR1cnVsbEBlcmljc3Nvbi5jb20+
DQo+IENjOiB5b2N0by1wYXRjaGVzQGxpc3RzLnlvY3RvcHJvamVjdC5vcmc7IHBhdWxAcGJhcmtl
ci5kZXY7DQo+IHJvc3MuYnVydG9uQGFybS5jb207IHlvYW5uLmNvbmdhbEBzbWlsZS5mcg0KPiBT
dWJqZWN0OiBSZTogW0FVSF1bUEFUQ0ggdjIgNy85XSB1cGdyYWRlLWhlbHBlci5weTogQWRkIHBy
ZWJ1aWxkIG9wdGlvbg0KPiANCj4gVGhlcmUncyBhbHJlYWR5IGEgYnVpbGRoaXN0b3J5IG9wdGlv
biB3aGljaCBkb2VzIHN1Y2ggYSBwcmUtYnVpbGQgYW5kIHNpemUNCj4gY29tcGFyaXNvbj8gUGVy
aGFwcyB5b3UgY2FuIGV4dGVuZCBidWlsZGhpc3Rvcnkgd2l0aCBob29rcyBpbnRvIGFkZGl0aW9u
YWwNCj4gZXh0ZXJuYWwgY2hlY2tzPw0KDQpJIG1pc3NlZCB0aGUgYnVpbGRoaXN0b3J5IHdvcmsu
IEknbGwgZHJvcCB0aGUgcGF0Y2guIEknbGwgaW52ZXN0aWdhdGUgYWJvdXQgdGhlIGhvb2sgZm9y
IGV4dGVybmFsIGNoZWNrcy4NCg0KRGFuaWVsDQo=

