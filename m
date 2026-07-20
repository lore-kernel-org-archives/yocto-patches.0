Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBDEC44527
	for <webhook@archiver.kernel.org>; Mon, 20 Jul 2026 10:04:47 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.16])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5666.1784541884684914058
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Jul 2026 03:04:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ericsson.com header.s=selector2 header.b=V7xIyFFy;
 spf=pass (domain: ericsson.com, ip: 40.107.159.16, mailfrom: daniel.turull@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWm/fwg8BIWaFEGfnvtysg2Enh7GhO6VPn2rHqN3RYY5cF8FK91WDRnUI6V4vUP4W0XmkHiHkFcdhE0Ae3G6fIzMpGmgs0VCYbDOprj6QvYAGAlH37wo/Rtiys8S1G15k9FRitAvp6B7DIcH8p4UAxZH3Q9Vf9ynmpLheBVi1m6uLiL/QSH9gPhQgXaxrvVpU3SjDNQ/V/XePBVgjjYeMuq2u/L6S4IGmz2JY/mX5rbLe6HCpMI/FCJUFeLEruaOwEMtcatJa9CjkmxfkqqRw4+ST9itW9oNT+nNINoFhLngVi7+k4NK3er6mTtnq/xoi5yhmKJ+G/+Y7jaXSDBIyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zqW39v2Ou51uMRDik6glmMCnIBqTaKnfdiQVdC0Zv4=;
 b=Uuhi7nZ5W0Qoy6UuwupsYKSC49VxAfxxZExsrSXNgH3mT7d+zixBACrK4VvZ+HofCTgsOaDxjcqwJoo28EVH1uuDCRR+j6vDDgQhsHYsAVvvx36b1wa1+kS0GooneMNDpqq3rCF1GH2Kk0QSydLazzrjo79XqnrjefNYi/0YANXrFE2aoVKtdpAulA6HYDutoz+rs1UoV2hlRjYXyY+71OQkbbWD8F+ayfXf3Y0BYObA9cOfKehcSVvgXdRdXaCmJ8K4ufY9Iq79MEe1UZ3k4GaAaRVkhQHAqbAAANvrg0dmbxZiGoQvgO/MbTEPeyCMwI2Y5YNupPCXYZoQ2kHjnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zqW39v2Ou51uMRDik6glmMCnIBqTaKnfdiQVdC0Zv4=;
 b=V7xIyFFynj1Uq2oIMp5ts6/FsSlk/g0FfR3lBhGxLHwfhVCdP3UsGIna0koaABdahH4bfxFfbt6ouMHJrA/s/J9JkS7YPPkYnzjxdgcWgbINdeqAH6xk1Q9ojBOwlkiILUpBL3gA9JQ8cXgs8j4XLDQvZXyoQfqf8xrxkrCZsPt4ujZ916GedO9WYIRmQkjftzTjPBDnrjbXFwwO1XgzEQ5WIDi4qwuhrr17emIpiW3ghsaCAAfL6QrEYj61saS8rILPZNJMd7HrDVv8AgNE2l5gm93GfYU+Iqf1QeO2OUq2CTL4c8RWu8Xbnz9Qyu52ycmB2WBy8qYr0Ulqi3S1IA==
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com (2603:10a6:102:4af::6)
 by VI1PR07MB6416.eurprd07.prod.outlook.com (2603:10a6:800:13f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Mon, 20 Jul
 2026 10:04:39 +0000
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7]) by PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7%6]) with mapi id 15.21.0245.009; Mon, 20 Jul 2026
 10:04:39 +0000
From: Daniel Turull <daniel.turull@ericsson.com>
To: "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
CC: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>, "richard.purdie@linuxfoundation.org"
	<richard.purdie@linuxfoundation.org>
Subject: Re: [AUH] [PATCH v3 2/2] steps: include devtool changelog in upgrade
 report
Thread-Topic: [AUH] [PATCH v3 2/2] steps: include devtool changelog in upgrade
 report
Thread-Index: AQHc7eXtGs8K6HqJsUmGk9To9fuLC7Z2ermAgAAH1YA=
Date: Mon, 20 Jul 2026 10:04:39 +0000
Message-ID: <7a3a6644e40edd4669b2dcacdc13b49fd7b8ab57.camel@ericsson.com>
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
x-ms-traffictypediagnostic: PA3PR07MB10721:EE_|VI1PR07MB6416:EE_
x-ms-office365-filtering-correlation-id: 66b60394-9f7b-407e-489d-08dee6464ffb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|376014|10070799003|1800799024|366016|38070700021|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 aN7+Bo1DkzMe9KCCAzwN/8WPQFmbDKJUY40KGryFPeU3d5I3+cS1vO29km9OfNux4OQSR8LS5a01PwM8LdAlGMf6j+cziCC4MCJkqqOMR25MrejuGBYRNWAE+uRDnejHNmqxJ/e8529Z3Wut2BbMlm6nWFiKEtxHSb3BG/hwIPqKGGCQ755tPsESs0GQ4XoR1nTWid/UzK1vd/sLMBqZnUtDL+aJJHj44NkOzLtogGwvQA+iYvCQlx9YM5DW/K8znW8TQC/MA3HJXtCOJkyO03iRrg+VQKosJlhdVjzFqh0QbJpG2jRR1+Cs429BGQRaXl5hvUuDMR1KzbvlzoHECGwnN/07P6OJ1Xddc6DiI8XbMhNLxzaoEX12nLb4zjDO5wBDMud02YBwH/tPmE5kelR2q6BPYLu8jVCaamSkG0AedwSejZaL8XmUO8Bn4UoMjutty3DBYKPeYoq+7ZZBphgniVBJad7oGrtFJt+hyiudBib9WyeLGaC5voxOB3j/hzpDp1KKUCL65h7vMFXO4HeBhrbqio/wC9lTU/rK9TX3W3QXkhUxLt+/OD3EjwIuLs/DYV9AaUX6uWBThFNgqh9IN0Sdd+czL8BJmnWd6kSRzKnb3tjilGmehbndv4TwV6cbDb85W/N82wvbRHTFgpXWovxR2JeaFxQ9thnMe5uEOh2GaajyfXlC+lDKk5DU4w7fRa5Ck//GYVnikHnM9MOFFEU3pmHXYpJlFE55eeM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR07MB10721.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(10070799003)(1800799024)(366016)(38070700021)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?T0lob01mREJRV3dnZzQ5R1V5SjBHa09JT3d0cFZuMDBaanlVdjlQUS90SHdw?=
 =?utf-8?B?cTZHU0VmUkpWQXgwNmpTNi8vMHk3dDEwYndCaElvN2cvSXo5dDJnWHR1eit0?=
 =?utf-8?B?NjdCS0d6NzNKT0x2SlpyQ0F5eHp0THRzb0g4dG42QXp3UnNkM1N5NjAxR1dH?=
 =?utf-8?B?Z3NLRE1SQVVNMlBJeHdZNjN3a3NnT2pDb3JpQjZuYjJmcC9xNFlWdkovcktv?=
 =?utf-8?B?dElsbXFMT01kRmtEdXVGalpuSUN4RFhDTlpndDFSSHZnQVM3YVdnUmxsWDNS?=
 =?utf-8?B?MGlsMmRNTFFsbEllWmNuNXAvcmxGOHQxKzdwUm9Va3N1RmdEeEt4SFFRRHdH?=
 =?utf-8?B?a1JhSlRFNS9qMmJYaklXNjA5UjNUR0NRTlJJZ2pzRFhwMDhYUVpRYTJaQkc3?=
 =?utf-8?B?dU5zV2t5Vjc5UitERWlYY1FpR2JiZTU5TTc4MEJDc3psaUtHWFVFTVMwZlNo?=
 =?utf-8?B?SDl0WHBwQnVpZjJHUzU0WFcvUHhmbUgxWlpxOEVicjc2c1dnR0Z0VE5RSmJ5?=
 =?utf-8?B?NzJXNis4TjVoSFYwRDh1bEVwRHB0ajZIRkJ0dXdLU1lHeDh5cjlBRTVFUTRC?=
 =?utf-8?B?L1hZb0pLdXdYaEx3RlJkcUxyS0pkeUQwbStiSk5KQWdpdHozaUtYUmtGL2Jr?=
 =?utf-8?B?LzE1NEhOdXhhY1hRVU1zRWNQcmkwLzVkWVpRYnFreXU0K1pJR1NrK0ZZREsy?=
 =?utf-8?B?ZzJPNVU4NWN3Q0MyZ2hGS2daZk1YYzl2Z3h5Rms3cTE2eXFJSkRaVzlhMW1u?=
 =?utf-8?B?enVXRnR1YmVpWG83cG1vVHlQZTJWT2RtRmIvS1Z0Y1RUZXBSc0VNZitZTkZ3?=
 =?utf-8?B?SnNaZ3BLUGtzdkxaeEdSczdUcXFpVWNkRlpPQ29tWFJ1MElML2hhNmFEL1Vk?=
 =?utf-8?B?bit4aFBhWjNHTGRlTHZJVkZrMkgzSk1mTy9JM3VqNU51QUFsbEtzcmRIQ0kr?=
 =?utf-8?B?SEloc1phd2lObmRIaldpSXVhOU4rRXgrdW9FTGtLRE5Ccnk1aTFqb2hPd2xp?=
 =?utf-8?B?L3E5WjJqYnJmdzRVTjBJLytYZ3VoY2x1ZkpoMzkyK3R5ODRrQnpMc3QzVXJX?=
 =?utf-8?B?UU1TU1JBbkJCZUpMOWlMVHhBblB2cWd0OTNLZ0ZvRXZSYWJPQ1p2a2t1U0Vw?=
 =?utf-8?B?cWVNSVloQ2N2cWptUnBGZmprcm1FTXFxR2JYK3daaWhFK2d4dnQyWEdFNWNS?=
 =?utf-8?B?Q1NpQnNmYU9FNDRqNmtsZDdwM1VUcXNWR2REOTMwZDZhd3o5Q0FSc0QvQUF2?=
 =?utf-8?B?VGR2Q2YzbHRWZ3VaRmtRMW1rM1Jmd0d3UExKUHlFdEp6dGNySzJTYjdPaTRh?=
 =?utf-8?B?eW9DTmJrbmo5SWQ5aW9wVGtqZXVnTzNkZ0JaSmYya2hFR0tIdEwrdTdkQU5Y?=
 =?utf-8?B?ZTNiSFUyK3RMVVNoTGpOa3pHUFNOSnhsY0kxRnZNOEdsUVhSVkdOaVo5dVZn?=
 =?utf-8?B?Vlk2bUZOTk5KM0dJZnlQY3U2VmIzMkpNTzhvTU1aUG1DbjNsM0dKZTdZTjA0?=
 =?utf-8?B?NmUvRWk2WEtsckR5ZGdpY0ZheW8rZTlSQXJ3SjlBZ1BydndrTjdadGtLN1A4?=
 =?utf-8?B?VTBKZTdqVVZmd01Gc3l5SWVOM3BHTzhjSnVzcGdHaEV3S3RoMXFOdWRtelA2?=
 =?utf-8?B?dHJIN0pXV1pVRDl1TEpQY0hDM2pZZ2F3UmUrajRiaktaTHdYRzdZVTNyeWtz?=
 =?utf-8?B?b1dERVFNUU5oa1JwRGNHVkgwM1JXWXBBTktvOWx0dlFGSU12SXhwYVhMSE1v?=
 =?utf-8?B?K1V4UCtSNzJPWU05U3NQQ1NIZU1GeGh6T0E0YktockszY3JpRHhrWGRQb0NZ?=
 =?utf-8?B?MHpzUnI4and4SG1jSGNJak15NnlZZ0dmWDFpM1pCbXVaMFRoWkRhcFMzdG5L?=
 =?utf-8?B?UFNLWUV3R2xJRklaUmNSNnVuV08xZ0IycHNGMUJpSnlCamlhNjJLLzlpSFVS?=
 =?utf-8?B?V3ZzdUthM3h6WEs5UHl4cG9sOFJaSHh4OUFiRHN5SlBwY2pkbFl1ZkhMY3pk?=
 =?utf-8?B?TytQelFtMStEdHV2NTVHa2ViaVFMTzBDeUxlODlmRXgxUmROSWNKcU9YVllx?=
 =?utf-8?B?U213MjVDV3ZER01ZUmRyUUZoeTFRUC8xL0hkN1E5OHUxYkVtUnJ0K1BKUGQ3?=
 =?utf-8?B?Nlc4czNWL2VnbnlJN0I2MGVjSTI3VmRWaFZrZlBEWm56WUxOVjZpV1NIM3kr?=
 =?utf-8?B?cGYvVG1SS2tBdzNXRThBOGZZbFkzV1AzUkhKaVkwS2Fvc1hhWFZmM1VUajE1?=
 =?utf-8?B?ajFIUG1qdnB6azMxNm9oVWxTOE0wWkpqNElNMXdLV0RSNndDbDM3K2J3S1lB?=
 =?utf-8?B?Ujc2dlAyUE1ZcFhiNDEzWjlsT3B0TDllUC82UlNvbCtzRHBuL2ZwR0paNVU4?=
 =?utf-8?Q?ejC8JmJjdHvo7o2tbOT4irsogcMxlJg9Z2TY81QJ5ZVPy?=
x-ms-exchange-antispam-messagedata-1: ARR6i/qi1t2pY3HORBe13ytzrI2Nbf6ejLc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B7B8BE5E0F7774F92F6978380987E13@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR07MB10721.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b60394-9f7b-407e-489d-08dee6464ffb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 10:04:39.6912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tM7IAgiOebioJJ91ISw+1RonvKClXT4rIlat2QnLvDocz9tzwy40pne/5YgHvl1TsR7N4UzPR2tOETZtGYkRbxzx4TA8HFeSHiK1WNmdu1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6416
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Jul 2026 10:04:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4517

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
Cj4geW91J3JlIGF2YWlsYWJsZSBhZ2FpbiA6KQ0KDQpUaGFua3MgZm9yIHdhaXRpbmcgdG8gbXkg
cmV0dXJuLiBTdXJlIEknbGwga2VlcCBhbiBleWUNCg0KRGFuaWVsDQo+IA0KPiBBbGV4DQoNCg==

