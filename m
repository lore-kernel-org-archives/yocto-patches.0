Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8843C4451C
	for <webhook@archiver.kernel.org>; Tue, 21 Jul 2026 07:52:09 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.9])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17548.1784620321924291674
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 21 Jul 2026 00:52:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ericsson.com header.s=selector2 header.b=c1rewQ8R;
 spf=pass (domain: ericsson.com, ip: 52.101.84.9, mailfrom: daniel.turull@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vcsm0Xc4oZybTJqMfF0v3NUXuE/PuUaJzShmRBe3hVzWWEt79pt+iUAnRLTYBKeGw6Q8UYMBNYNAQVkJbQtGapvo4KYpzjDdXN7COUlGPQqqMNIHLCVUCu18ZI2V92KTgCoSm0DJbAOe+EM471p/FYmbzybwh33uefR6ur2V+cEFc5Gf/GcQLzl8/2ruvcAgo1Mj2c593N64xFnSwPRYbSA8f3ZNcJVBwkIbeluevzFcxxo52A0bv1mDI60u812RUBNGa7s9z6ewJhFuxKE7S83rc1SxRbQ/N9YiG55s7y3azPqGggGBdwa/Knuv2tmC9G4DPfyb7EdjUuXUVwMnFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZqMUf/4BSGVYg4mDp7U0EmZAjSYF+WTThxhwtxvSVE=;
 b=bY1WmN8fHsVUXKZV/5u6jcbB1YwjDb2UbcYSTfh57peUGYKganmskNlJgdkqmV4AIx+5IZM71w4zCQkmTh7di6q1fR+ShBI5YBhxmcxg4WG4nCrzb5f5SqeTKlRdH/ayeaUJkF8Ol9wg8dCnbLE3piEnejCISB/9f6eB35/zxF+08Lv49IMtlZc9PS/bpLfXfhRyWNsgDMHqCmZ7pckCvFwwzi/yBV4Gk9QbpO7DyJ2n7sh5i80gJWYA+dUa+K6kAIevdKpwsoANPDlNfdM6tDbCg+yxYODZ/A+GkmJzGhjQ7wxTYKILOLGk3V8JNMmzmXUnZyfh1VtwlmzeZC/DQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZqMUf/4BSGVYg4mDp7U0EmZAjSYF+WTThxhwtxvSVE=;
 b=c1rewQ8RtZzVW29SrRo8WOd3Jy1QL9tS169tXMkDa6GofjzH6Qn53FGckYJT427GnQ9Y88yH2u11oADOykPUJLsPOda1I89KMid3c5kK0602rIyo3etCUApZM1d7KZ/sdakHR3Ob3VLYMW3rFuxi0Zk8Sb7mPOgDDL/w7KhNm0adf6YwPLStzbSvOdBSA7UIUjHbR0+4lQehUs7b0a/6kEwd9w41p7IeXg41fYdo82LgQM6iPNHTjGAOod4UYQOiDsml6u7c+EmeRZm9AKtBkoaujGrrdJpg6NaqNRF/TQf14o/CtcpfQAn8mur6p7E5BIsnX1JprBl/4jrYDV2kug==
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com (2603:10a6:102:4af::6)
 by PAXPR07MB7757.eurprd07.prod.outlook.com (2603:10a6:102:15c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 07:51:57 +0000
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7]) by PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7%6]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 07:51:57 +0000
From: Daniel Turull <daniel.turull@ericsson.com>
To: "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
CC: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>, "richard.purdie@linuxfoundation.org"
	<richard.purdie@linuxfoundation.org>
Subject: Re: [AUH] [PATCH v3 2/2] steps: include devtool changelog in upgrade
 report
Thread-Topic: [AUH] [PATCH v3 2/2] steps: include devtool changelog in upgrade
 report
Thread-Index: AQHc7eXtGs8K6HqJsUmGk9To9fuLC7Z2ermAgAF1FQA=
Date: Tue, 21 Jul 2026 07:51:57 +0000
Message-ID: <e6f5126115b0626d4cf17c0467b5d2f0f62fde52.camel@ericsson.com>
References: <20260527124827.2486471-1-daniel.turull@ericsson.com>
	 <20260527124827.2486471-2-daniel.turull@ericsson.com>
	 <CANNYZj_a0hSXOGqh_KOVhcmdnGJKqHyBd5xT=97rP9LObhJYsQ@mail.gmail.com>
In-Reply-To: 
 <CANNYZj_a0hSXOGqh_KOVhcmdnGJKqHyBd5xT=97rP9LObhJYsQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR07MB10721:EE_|PAXPR07MB7757:EE_
x-ms-office365-filtering-correlation-id: 31982ad2-d134-42b3-fefd-08dee6fcf04b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|23010399003|10070799003|376014|38070700021|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: 
 WRHxP7PwJ7sqols/28GeHvJvptOxWLk8zaxE5VJMgjpt3gEmPE1VQZOAmMIkudorUTsSDOcplZZBbLrtqjIhXHNY+MiCYCb0UbYWrPEfbFOGE7vEKUuIKS+SoGxlYjBdy/0cMRTxMcDX78OUPiofhl5uNcxOCP9cIRHKu8s9v8Vwce5glWqGDgkcBg0zODTKwzC+cqtf/swaHwfUR7UBPwQgR+3bQwkg35UPQjB+xdVNyNayq0Ovw2e98BIjI16D8xrDz2WFPrkU2MYOlZqNtxLrMOcWxI7TfnhOUKC+EScut8SlSC+/56Tsvflh94TROe6Tu6zOK5e31h06+P2Z48xMfd9x+AjCjHc47gxNc0IWtljBP8VCS1KLygH4R20rWXw0sSNlG/zTsmZPOGue16EC/UQluy/Vwsn8vk3xEHA+EbZ5mFA0kU2hEnbKu98V96jkhmBO3wUmvzfN1yG551JqmYlCglm3nuAD24Ssic9rA/S8tQNGkE7fE7JEFrr1ZBJ8TzK/xcTs9585XI3xlPc/TfRhYq31bi8d0hQJIALyWJ92XzcZpOa1xJdYKuTEU1vmdlzEHNoh/OVb7DRl5Rshm8BNWR4ShxxOnviHisARLmn0VNzBoZZiwbJjUg64USI2KwLl56mAGaRpeqxPIs8QtjYqjm18rtAP6rCha6KF4lQREMUWXKg1mo8Qio8YDyqtDEz/G0OsJ1NGnFB/uYYb6Qs1WwrN64LMUl2zLm8=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR07MB10721.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(376014)(38070700021)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZU5UMzk5RHNFVjk3VkNBRms5N3ZmYlJ5MXNkSFQzbkN3SDdpcFdMdnhudUM4?=
 =?utf-8?B?K2VIZThqbzdTU2hVMHdUSElPWUNXLytFRGRXbVprcWp3b21MWWxBQXN1em55?=
 =?utf-8?B?MXFBV2p2MStpeG9YNC9vbkN6YUEvbnF4RGY2K05CTWk1bzh2UW5Nb3NicmRG?=
 =?utf-8?B?MW1SUVk5TWU3QXhoakVYQTI1MWNpN2tQNUNlMDNDbXA4SnRPWjVmb1ZydE1q?=
 =?utf-8?B?b2lqTDBWMXFJWEpwREhMS2hxRk5WOUlpQUtScnU3U2hIUStXMmZmUVpoY3Qw?=
 =?utf-8?B?d0c0alMrZ1lONjdwZkVuU0dJclAzeUNXOHhXdWZGZ3FKWUtkNEdrQkVTRFRF?=
 =?utf-8?B?b3dzNmp0bmw4Ui9PUGpRN2hJVjNkbHNTM3RwNURUUmg1bTZyUXc3ZVM4UFdI?=
 =?utf-8?B?MEw0WDR3QXY4dVN4UUg5cEVsVnptSDVnUzN5SlhpTWdTM0JoN2ZOSmdtSHpC?=
 =?utf-8?B?ZGg1YkxMV3hlaUgweFd5clJNOHdnU09EV2MrSjhVM0VUUHVJVk54em9McTRm?=
 =?utf-8?B?UW13OGpsa2g2U3E1TU5QM0hzVzB0ckRDemlJc2M2c1p5eWM5OC9vclk2NWR0?=
 =?utf-8?B?S1FaRU5qWmlRNm5iUktLSDd2SWlNemFEWkdwb0V0WlhYRmtmMk1rZTA0OU4v?=
 =?utf-8?B?TThqTUE1SDBQM1habmNSb092aEgxaElCSFlxTEhVVlpXUUxrK3B5WTRFczg4?=
 =?utf-8?B?bDFhZUs5Slc4eWRpMTgyT1NHUzM5OWhqQ1QwWW9VV1BBMGgveDJsblFOZUVh?=
 =?utf-8?B?QlRDc1hrWmNtczVlTnhtdktndUhJOTNGUjlsMzdmM2RUZGhvSHBydG1HUVNq?=
 =?utf-8?B?Q1dnUkk1WGg1ZDdyWjJzV05Fc0VzalFnYXV5MHJjRmgxSC9za3J2T2tqbmRW?=
 =?utf-8?B?SWFlaDFMczYrZjl3NDRDbFVDelBwUWRyS3h1YlF4eEdBK2U2Qkl2NEtjbmlB?=
 =?utf-8?B?WERoRG1IbGRJRkI1UGlWeWl6RVRqNTlLbXd1THhuMEVRTWpiSDVjQkRHRjEz?=
 =?utf-8?B?cHRqY3M2SmVHdFhvQjViUGp1emhsODlCN3ZnbkU1MUFQLy9SSmFUQnNnc3NF?=
 =?utf-8?B?YjBJVllIRTAzUUdDdkpzVWZScWJMeEUrUEh1b0w2SCtSclFQa3lteFhXY1pt?=
 =?utf-8?B?ZjV0ZUZNWTIzV1Z3bENTbFdHV1NwVWVOeThLQjZldnM1WEFuaTNrZktuR1pP?=
 =?utf-8?B?UVl6cmFackhHaThod015SWNPd3hhblBabm44Y3JQUmJYSzF1dlh5Z2ZrQ1h3?=
 =?utf-8?B?MHZwcTVPVmszNGt4dXJqVVloaS8xWFVkRDVMeVZuaFdsR3lmNHI4WGVtZGtq?=
 =?utf-8?B?RXAwZm1pdXBkVjYwYXBudWIzMjZmSjNSRDJ1Z216RlZ5RlZMcHphcmVQd0U4?=
 =?utf-8?B?Tk50dHRTU3VXSWViaFBJRWhpaE9pT1dydG5YaGI0L3VoOWRFWXQ1Z1dOcmRZ?=
 =?utf-8?B?MUhlS2Q1NXhTM05ybU9QUzVRWXhoem5PZGJGUDNkMVQwZjJZaWZaVStpcWgv?=
 =?utf-8?B?amFIdzZ6bEJLd29wdWdsMmpyNXRyczdkbi9rZ0pKNUl1VDF2c092dHZZMGpk?=
 =?utf-8?B?Q2FEeGlmc1VjTjZZblJSMFJFeU8xRUJ0ZnhNaHFLWDdwa201dGxqL0RTTjVF?=
 =?utf-8?B?cGNEYURGTzRUYm9JMzRxT2ZiVlZZdWloU1FqUUluZlp4RnRjUE5CZmNOTzE0?=
 =?utf-8?B?M0lWNjYwQ0dqdEhER1pFM01sZDR4b1RvdDNuYmNrT0pHTmZZNTVDcDZVdStO?=
 =?utf-8?B?UnNUTG5UNXFWbk1mbThrZ1dBTmFOS2kvTU9hYUMrQldLY0ptWFlLejF2MjV4?=
 =?utf-8?B?dEtRbzNGcnV6OUk5RTRZendESFFFaUtzNXdxaHo2K0Zwc0RtZnZaUEZqejlv?=
 =?utf-8?B?SkZGc3FmcXVvaGRveU5KTEo3T2tMNVVMVHpkcmJ4amx2anRSd0M1YTU2Qzg1?=
 =?utf-8?B?TmxCTU5pOUpaalY3YXFaQnV3dUJhRzNJR3NUcWlYbHlOb3RyNVBjbXlWWHd1?=
 =?utf-8?B?dFdZSDhOQThBUDMyRG1HdFJBcnV4VTFBREFmcVdnRmpINENqZ0xYVUVJR3do?=
 =?utf-8?B?YUorSzQ3d2E2Zzd3ZnZSaDZ3UlpOUlV6VHA5U3I0VUZHeUdWNjNkWUlpYU5S?=
 =?utf-8?B?TDJGTi8rM2NWcFVnK3BFWEM1UExKMm1SZ3lia0NjUWxWejhoczhxekUvdExV?=
 =?utf-8?B?ektZME50QWFCeGk4MEE2WGlHYWprUTYzZCtZQzUxSUhrT1ZqTTNkdVN3Zzgv?=
 =?utf-8?B?OCt6dDlGVTA0cDZneHdpSkdoZWs4Y0FlczBudkFycWh5ZUdsWkpXbzFlL1A4?=
 =?utf-8?B?M3JmWUFheG1DWHlaaGVreW5KZUw1WHcvNVpWb2xLYzFJUDdqRFhFcStKOFky?=
 =?utf-8?Q?/3mNFEPJ0UUlp7KUJLOLRJoWQprbV7E7qJbTBOKqqBFA3?=
x-ms-exchange-antispam-messagedata-1: 7PYIsUP2EIN+Qk+zPIrYg35DaT+Wwj7oUG8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F298995AA803B54E9617DEC738DF2709@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR07MB10721.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31982ad2-d134-42b3-fefd-08dee6fcf04b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 07:51:57.0580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rXkJoOfus41SLNXvmbS3Rjsagwxps9w5593te94OejeaIaeSNIDdF+9jt11xYJgc8CwnV+2njISAcORh2lj2f1etgiNCBUo/b5rb1VTNUMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB7757
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 21 Jul 2026 07:52:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4524

T24gTW9uLCAyMDI2LTA3LTIwIGF0IDExOjM2ICswMjAwLCBBbGV4YW5kZXIgS2FuYXZpbiB3cm90
ZToNCj4gT24gV2VkLCAyNyBNYXkgMjAyNiBhdCAxNjozNCwgPGRhbmllbC50dXJ1bGxAZXJpY3Nz
b24uY29tPiB3cm90ZToNCj4gPiBDb3B5IHRoZSBjaGFuZ2Vsb2cgZmlsZSBnZW5lcmF0ZWQgYnkg
J2RldnRvb2wgdXBncmFkZScgaW50byB0aGUNCj4gPiBwYWNrYWdlIHdvcmtkaXIgc28gaXQgaXMg
aW5jbHVkZWQgYXMgYW4gZW1haWwgYXR0YWNobWVudCBpbiB0aGUNCj4gPiB1cGdyYWRlIHJlcG9y
dC4gVGhpcyBnaXZlcyBtYWludGFpbmVycyBpbW1lZGlhdGUgdmlzaWJpbGl0eSBpbnRvDQo+ID4g
d2hhdCBjaGFuZ2VkIHVwc3RyZWFtIHdpdGhvdXQgbmVlZGluZyB0byBsb29rIGl0IHVwIG1hbnVh
bGx5Lg0KPiANCj4gVGhpcyBoYXMgYmVlbiBub3cgcHVzaGVkIHRvIG1hc3RlciwgdGhhbmtzIQ0K
PiANCj4gSSdkIGxpa2UgdG8gYXNrIHlvdSBEYW5pZWwgdG8ga2VlcCBhbiBleWUgb24gdGhlIGRh
aWx5IGluY3JlbWVudGFsDQo+IHVwZGF0ZXMgdGhhdCBhdWggd2lsbCBiZSBzZW5kaW5nIHRvIG9l
LWNvcmUsIGp1c3QgaW4gY2FzZSB0aGVyZSBpcw0KPiB3ZWlyZG5lc3MsIGNyYXNoZXMsIG9yIHBv
c3NpYmxlIHR3ZWFrcyB0aGF0IGltcHJvdmUgdGhlIGNoYW5nZWxvZw0KPiBleHRyYWN0aW9uIGFu
ZCBwcmVzZW50YXRpb24uIEkgcHVycG9zZWx5IGhlbGQgb2ZmIHRoZSBwYXRjaGVzIHNvIHRoYXQN
Cj4geW91J3JlIGF2YWlsYWJsZSBhZ2FpbiA6KQ0KPiANCj4gQWxleA0KDQpGaXJzdCBkYXkgYW5k
IGZpcnN0IGlzc3VlIHdpdGggcGVybC4gVGhlIHBhdHRlcm4gbWF0Y2hpbmcgaXMgdG9vDQphZ2dy
ZXNzaXZlIGFuZCBpZiB0aGVyZSBhcmUgZW1iZWRkZWQgY29tcG9uZW50cyBpdCB3aWxsIHBpY2sg
dGhlbS4NCg0KSSdsbCB0YWtlIGEgbG9vaw0KDQpDaGFuZ2Vsb2cgZm9yIHBlcmw6IDUuNDIuMiAt
PiA1LjQ0LjANClNvdXJjZTogZGlzdC9BdHRyaWJ1dGUtSGFuZGxlcnMvQ2hhbmdlcw0KDQpSZXZp
c2lvbiBoaXN0b3J5IGZvciBQZXJsIGV4dGVuc2lvbiBBdHRyaWJ1dGUtSGFuZGxlcnMNCjEuMDMg
MjAyMi0xMC0xNyAocGVybCBjb3JlIG9ubHkpDQogIC0gcmVkdWNlIGhvdyBtdWNoIGNvZGUgaXMg
aW4gYSBzdHJpbmcgZXZhbCwgdG8gbWFrZSBkZWJ1Z2dpbmcgc2ltcGxlcg0KMS4wMiAyMDIyLTAy
LTI1IChwZXJsIGNvcmUgb25seSkNCiAgLSBmaXggX19DQUxMRVJfXyBoYW5kbGluZyBpbiBBdHRy
aWJ1dGU6OkhhbmRsZXJzDQogIC0gd3JhcCBhbnkgZXhpc3RpbmcgaW1wb3J0IGluIHRoZSBBdHRy
aWJ1dGU6OkhhbmRsZXJzIGltcG9ydA0KMS4wMSAyMDE3LTA5LTEyIChwZXJsIGNvcmUgb25seSkN
Ci4uLi4NCg0KRGFuaWVsDQo=

