Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BEAC982EA
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 06:24:08 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.24])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1194.1790144641532596944
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 22 Sep 2026 23:24:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ericsson.com header.s=selector2 header.b=RfYASauv;
 spf=pass (domain: ericsson.com, ip: 52.101.69.24, mailfrom: daniel.turull@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QODKeO0ealZMP4Q0pRMCmWei8UaQIr18DdRkpXafMjb1XyxBK4+/v45YRD9I8jnliNzgLO7HhtKDi1jIyWPHQjL3JHn9ehbuTXKUxLYMnXgdpy8GJk0iJU+IOIVtXDndZ0cxai24RRxKsYJIBcmfwj+ESIvj3bTpPCHlHEbt/q2/M+vS2DQFIaHgF0Ko6t1/+eVQc7h/7OaB0AV6xzG52lXK51mANb9sWixraugtbqddMuhJZeGcosV7PC+GM3hKdO196gy0YC7ep8168nlv1MFbYLn4DT/yEZ0Y8y5FZOyYARWI3x2EvNosOl7SVZKmjKmRMj6M4eHIANeabskVoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iB9YZ5631vE7F9QVszjlt2pHqL+PMH1S+59V5CLGB40=;
 b=W69xc7DD0h7hJzB35k333llpfKXJMTgrCzvPUmsGaWxufGqdhdeTw/ZJWLLI/GxgEv5xsSJX5j0fU9/SD6Gnrud9I3sd+GD4d15YoqITM2TnQ4JAx2oN/9GyCxIKWV70TVKQMIGgtM1UjtZg25monn76GZj9R2laU7/u/zHOFn5jNdKgIc4FeIOn7mn1nLw+3nTZUfzc0gC7XwMxwo9HJbSURpR9hpZ25YTaAEI0OqQgQhlkKvvKi+OH6qtpAAOjsZt6Gkm7ZlYFwxzq/RcrrWVCHiWcLL37hUv7VlylWIJPpRcpzUz0ezDxdzvJwymeueI7+UfhDjJ150I9+b3jgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iB9YZ5631vE7F9QVszjlt2pHqL+PMH1S+59V5CLGB40=;
 b=RfYASauvXcB/oD8qfTK/cdIeHOAMdYVX1vSFhuV0WS4ApaPGJaizy1/4AYtyf9u44kBqPpda3VkaqXvOoL72v2GOR092MDh7Wp1od0fgcfuIgfXN68Jy0wsP6rLgTDHrjzTlxHn1Nc6wkvxDucdyeNbJWqxlmItPuWzNX7uPTaBghGUoYxo1LwTGpPj91SpvBXuHQQqYLzaUBJ6GxEFbj5sw/sU2FVxGqVs4Y8rDNNJ5IICtbHRbscu1RBtM+Uj4kR9sPIx8NhsAVik4CplO7bDyKPfLACeWBPnkSHdUtHDj3ssIXIwKIH890L6QzfBcqUgQVcqZFL3iprleF2x8+g==
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com (2603:10a6:102:4af::6)
 by MIYPR07MB12182.eurprd07.prod.outlook.com (2603:10a6:290:7c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Wed, 23 Sep
 2026 06:23:55 +0000
Received: from PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7]) by PA3PR07MB10721.eurprd07.prod.outlook.com
 ([fe80::afd3:17e5:1663:7ce7%2]) with mapi id 15.21.0428.015; Wed, 23 Sep 2026
 06:23:55 +0000
From: Daniel Turull <daniel.turull@ericsson.com>
To: "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
CC: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: Re: [auh][PATCH 2/4] steps: skip duplicate changelog for
 shared-source variants
Thread-Topic: [auh][PATCH 2/4] steps: skip duplicate changelog for
 shared-source variants
Thread-Index: AQHdR2XHTjT4+7dqik6GzodfTCWblLba4nuAgADW8AA=
Date: Wed, 23 Sep 2026 06:23:55 +0000
Message-ID: <3742d8808333cbbaad6a581d0569a5c72c0c060f.camel@ericsson.com>
References: <20260918120342.772566-1-daniel.turull@ericsson.com>
	 <20260918120342.772566-2-daniel.turull@ericsson.com>
	 <CANNYZj_dBU3QGcjOjfieN+BU2h-r+Tu-6eHeanGbO7MWshTjbA@mail.gmail.com>
In-Reply-To: 
 <CANNYZj_dBU3QGcjOjfieN+BU2h-r+Tu-6eHeanGbO7MWshTjbA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR07MB10721:EE_|MIYPR07MB12182:EE_
x-ms-office365-filtering-correlation-id: 9c41a348-1d26-43ff-030a-08df193b3e7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|23010399003|10070799003|366016|18002099003|22082099003|4143699003|11063799006|56012099006|10067099003|38070700021|3023799007;
x-microsoft-antispam-message-info: 
 8jwL6bcnnMt5C4OFmZTI/LSBPV+WvnBrXEOZihho9hIemTwqEDt2WgMCpb8t/ZgBWuVpskSA6JKGT6aSd3b2EVzEiZEhJVY+utNZ2Rd/ktulnuwp3uX8D8hyHbcsqPt4JZpukhWN1herYmqPn4DuSibFr3ZFKUySiwecKAw2GqWkUaNS3oBKa4UG1dGXC8Ehgrx19vRhiHzUDG2KMNNyqYcC6dssMiNGo/ZKoJRYfRa1OZkZi7AoyhD5MyIuqxHRejeiIFATKhqPVb38rW06o2mWy4nkWyGC4l+HPrBLlkWbaoHynPoGtQsKjUXypD8ge+mKAbC+kkEflda+3u8LDwSXc43ERb/NPz8hEVZv2Z+LhSpwa5VTI3bUe8SlWD1OPwZ4gEJKAOLCvQ/O1T03arrakP43NkeY5xt60UhkogKBd4rwiDx4+Kak+FvoXBCydXwxSIhFdE78cutwUXrxi+fZLRxS9vrZqmx6Fmgmi069+W2tnZ2IjfPsJvhThmaG4WMx0n9y8aiMAHHeoxF/rayJv6sY3nlZHgtcdOXpniZsZPE4KYq0Yz76z+cesAYqAjspV9wQ1LlUpr9XtLhvRwdV/o6i0VYqk2hoUB/9Cpnor7b8a7CwXk9xAKID160w959CnHHRi2KsoZSAM7bQlxptt+yQoXLLLgfc48sgj9CDlgP3ErMWtjuvA5a/ARahkQ6x3Mc5s+yCAWOhfWePm591ToMtQBJToGpcvnbgi/0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR07MB10721.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(10070799003)(366016)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(10067099003)(38070700021)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eXNUN0paa0xCVFBUT2JOZXhjMjZCY1BqWE5UTUVsTE5DMHJUMTM2MW9WRkJq?=
 =?utf-8?B?TEhnZTlRT2ZvcGUyaXFlSXZDTHdtMSt6dVB0a1UzSmJpSGI4cHlnSFREQlBm?=
 =?utf-8?B?SzZVTEVrMVpHc2MvYnNUVWM3L1RVSTlCbFFuQk1lRFRkQmtZcWZUaW9zMzFo?=
 =?utf-8?B?SHlCbm5uWFNSaWZmTDBuRzVLUHp4SmNaQWg4TDVWMmhyU0ZBT3ovQnRYSUFh?=
 =?utf-8?B?WGh1TmFTWkFuL1ZSajlYbEJSRHIzbGZuaTR0MWJNVXJSb1RpOUR0cmc0c0hN?=
 =?utf-8?B?OWRJaDRKMktnWUVxZEFUVFhUQTBCbzdXUHpGaE5QV3VPM280QkM5M0lJMElM?=
 =?utf-8?B?dHh3cnA1RUd5QUZOWGRJeW5neFE1MVNlNGI2TjZ1REJENlBOSnBuWnQrUEpY?=
 =?utf-8?B?Q3o3N0pxczVlRlMrTVNxZ2dwRHpHcGs0OHFUb2pNWTAwVzdTTGNSRGRlR3JO?=
 =?utf-8?B?REFiMGpmTVlpYmdMOW9MeWpQRXBZYkVGYkhCTmsvYlJtWGFIQTdGQnlkUFZn?=
 =?utf-8?B?bldoZEVudCtYTm4zNjRhV2NQcEF2MzBWWTFjYStDZ3Fkc3c1SFBoaUFXRkoz?=
 =?utf-8?B?NTRPN2s1aUhGY21XOXoyb0hPNnFzV1doV1gwV0FDd0UvcW9FbDlHMkxpb2Fj?=
 =?utf-8?B?emZ3d3Z0WlFhZUVBWUtycjVvZ01CVHF2NUMvYnNXWkNOdnVRVHZpTTdFTEJW?=
 =?utf-8?B?MkhUaHJGc2daQ1MrTXlLQW9OT0Zub0JFeGxxQldIQk9GMVlRcEZ1UCtOSXkv?=
 =?utf-8?B?dkRpdEY5VWRPLzlxcHZuM2FYbHVTTi9Oc05ZeEY2S3lhNk5ZVUlTRWVLYmM3?=
 =?utf-8?B?ODE1K2VRUHJ3d29kTE55ZXNZeERSanBqYWxxM2x4c0pZNDFudFUxaHM1VGxV?=
 =?utf-8?B?eFRqb1pEeW4wcG53dEtIUDd0Q3lJTi9zOGc3bVV3K0lvSGJBS3pPcTBVUzZU?=
 =?utf-8?B?MUFjc3h0TnlvbEIxYU04OEFuQ0U1WTJSckhpN0pGN1ovazdpY0dKR2lBNVhG?=
 =?utf-8?B?UURlUTRJemREc0NNZ2oyT2x1b3hEVkxQb3VCamt0d0E4SHNHVGdyYmsyQUJj?=
 =?utf-8?B?RTV5bjNENGIzUk5CLy9NeXU0VCtIczgxd2NXMTYyUmxiR0ZLdHY1akw4YjFa?=
 =?utf-8?B?cmxpOFh5TjYrcFd6MWJSbDBmVk1MSjlIK1ladmZiclBRWHVEWWdVVWJhWXNw?=
 =?utf-8?B?bkM3MXE4UXlUcS9JK2o4S2xHYnRSWURCYUJKNi9sU3ZEK1FKTzlYRGJzdk1Q?=
 =?utf-8?B?VWlzRU4xeXJmcWhIaXBWMWptNmY0VkI4dTdyZmUzZFEvS2RsajZWSG1XelZM?=
 =?utf-8?B?bkM1K3lpY1puSWJIU1o1ckM5Tmt0TGJGeUs1Mm1qZFNtUTRpc3g2aTkrYnVJ?=
 =?utf-8?B?T2dFcUpQZFdoZGtOeFlPcFdGWkZIc2lVY1Q0RzFRdnlXaWVITTlvaTlLWndt?=
 =?utf-8?B?bVloRlRmR0xUWkVrVTZRSmg3RlB2cDRMM0w0ZEwvRXJhRnRzSS9QdUVOSDRj?=
 =?utf-8?B?bnlScXNZMWYrTjJDaldiRnd3ZmVqQWlDZzlXbWJDQXVscnNBWVBkSnVoWk9B?=
 =?utf-8?B?M292aWluWVhodCtNek9DbW03cGNXdTVNNkxIck5VRU5VYmdsb3ZRVmdBRUg4?=
 =?utf-8?B?OHlSbW5GajBJQ1E5aTA3K05INFcyVHJlMDRRK3luWSthR0NWY3NsZXhGQWRD?=
 =?utf-8?B?ZmpFRHkzakpKY0xlZmtpUXZqcVJzMzJ2MjBQVm5KR3lQZFZac2Z2ekZXTmRR?=
 =?utf-8?B?c01wQ0hncENHdE9mSE9GUmxFaWRmMzVuWUkvdXFsQ3dMWWVoK3R5a01UV3Rp?=
 =?utf-8?B?aFI3SS9lY0RvUkR2a3BrdXpPZVNIaTB6bmhLbkR1NEpMRkcwaXd5c09qcmE5?=
 =?utf-8?B?eFNRSUdmNk1rZ0ZIbHVxY0F1bllrNkdXQlUveXNzclUzTGdyRnJqS1JoT05V?=
 =?utf-8?B?VHBSc3pjT2JCWWFOczI4VXdDNnpKZmQ5akFycTNzSFVORXdMa1NVSVhJaE9S?=
 =?utf-8?B?TTduNk43NlhGbm5vSlVOSm93NWVJMEZVUStacEF2OHlZSjBXY0NPc05VVlhY?=
 =?utf-8?B?VUFwU3NDNFAybHhuMlFXTE9OQkluRWxZd3FpeHRubWtWdHhtUUxoN0dyZFJz?=
 =?utf-8?B?S3owTjJHQlBZYm95bTJtV0NBcyt5blUxOGVVeDhjZTBKT0V4NERCb3Y0b2JL?=
 =?utf-8?B?cGRYbmtGb1BEL1Rmb29YZ25GbUc2L0hoKzMweEtSWEoxWDFleG1OQ1JxRnlr?=
 =?utf-8?B?bHN4ZWozeVVpaUtmeFZkWk55Qitqa3NDY1lNRFlvSnFQRUdXaEpwWEJwL2FU?=
 =?utf-8?B?Z3Q4QURKcERTU3FSbGc3UmlxLzRwc2pKaGRlUmF2eXBvUzRROFM5TTBpWlB2?=
 =?utf-8?Q?ME2dJSqfLYuzGWAldpKDWNsSvp7dYKxqHSf8uS0nBXrRG?=
x-ms-exchange-antispam-messagedata-1: 6ldP5H4T0CfPEsEviV3mqnwuotU9SM9LXq8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6718E305D0DDC47AC2420E0CD481239@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR07MB10721.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c41a348-1d26-43ff-030a-08df193b3e7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 06:23:55.1460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IrBCheGOz0v9jFwwFokEH4Ply7yZp/5D+iL6kkQCoELMDWzLK/5Z5RWmYSAuZsEig8vABLCmdhmnv2v/Jc666MeuAGOHsnH+85Ii293liH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIYPR07MB12182
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 06:24:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4933

T24gVHVlLCAyMDI2LTA5LTIyIGF0IDE5OjM0ICswMjAwLCBBbGV4YW5kZXIgS2FuYXZpbiB3cm90
ZToNCj4gDQo+IA0KPiANCj4gT24gRnJpLCAxOCBTZXB0IDIwMjYgYXQgMTQ6MDMsIDxkYW5pZWwu
dHVydWxsQGVyaWNzc29uLmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gPiDCoGRlZiBkZXZ0b29sX3Vw
Z3JhZGUoZGV2dG9vbCwgYmIsIGdpdCwgb3B0cywgZ3JvdXApOg0KPiA+IC3CoCDCoCBmb3IgcCBp
biBncm91cFsncGtncyddOg0KPiA+IC3CoCDCoCDCoCDCoCBfZGV2dG9vbF91cGdyYWRlKGRldnRv
b2wsIGJiLCBnaXQsIG9wdHMsIHAsIGdyb3VwWyd3b3JrZGlyJ10pDQo+ID4gK8KgIMKgIGZvciBp
LCBwIGluIGVudW1lcmF0ZShncm91cFsncGtncyddKToNCj4gPiArwqAgwqAgwqAgwqAgX2RldnRv
b2xfdXBncmFkZShkZXZ0b29sLCBiYiwgZ2l0LCBvcHRzLCBwLCBncm91cFsnd29ya2RpciddLCBp
ID09IDApDQo+ID4gwqAgwqAgwqBfYXBwZW5kX2NoYW5nZWxvZ190b19jb21taXRfbXNnKGdyb3Vw
LCBvcHRzKQ0KPiA+IA0KPiANCj4gDQo+IEkgdGhpbmsgdGhpcyBpcyBub3QgcXVpdGUgY29ycmVj
dC4gUmVjaXBlcyBpbiBhIGdyb3VwIG1heSBhbGwgcHJvZHVjZSBkaWZmZXJlbnQgY2hhbmdlbG9n
cywgYW5kIGluIHRoYXQgY2FzZSB0aGV5IHNob3VsZCBiZSBhbGwgaW5jbHVkZWQuIFRoZSBpZGVh
IGlzIHRvIHJlbW92ZSBwcm92ZW4gZHVwbGljYXRlcywgbm90IGp1c3QgYWRkIHRoZSBmaXJzdCBj
aGFuZ2Vsb2cgaW4gYSBncm91cC4NCj4gDQpPay4gSSBoYWQgdGhlIHdyb25nIGFzc3VtcHRpb24g
dGhhdCBhbGwgY2FtZSBmcm9tIHRoZSBzYW1lIHJlY2lwZS4gSSdsbCBzZW5kIGENCnYyIHRoYXQg
Y2hlY2tzIGFuZCByZW1vdmVzIGR1cGxpY2F0ZXMuDQoNCkNoZWVycywNCkRhbmllbA0KDQoNCg==

