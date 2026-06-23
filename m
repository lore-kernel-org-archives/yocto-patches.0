Return-Path: <wangmy@fujitsu.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5B2CDB46B
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 02:35:25 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.66])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12535.1782182116849457058
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Jun 2026 19:35:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fujitsu.com header.s=selector1 header.b=TV8Wi6uU;
 spf=pass (domain: fujitsu.com, ip: 40.107.74.66, mailfrom: wangmy@fujitsu.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lEUmGiNhKCxDAKHMeAH7qSXe69cxsghMzhQi3exTeqT8ga7xk+NAOpJryRihWFK4QkIo5ld/culH/p82OW1yI4wVn0zMkoih3YuXIS+ROuBzQkUbKVomZ62cT1WA7JhZG4qE+B0NSkSA6zY0oUcBUnjmbaUdo6yB5uYQO4ask3fJBMYDbCgndIY192SzmfsljY0GUJOTtqK7Z41VYnNMZKsKl9VbuTuTfjUtl4WjS+A6oAITDpZnkSEhQUKxBA9FdDlEA9gwwV+H5yD/Zb8d2K4kDNXTBF5YbfOo2zfYJkqnWdkbErtBqZFcX7FmnV+uTkWq993LrWlRHTfO5/ztwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLKOPYjbsnprfg4bl0qe0xnJRkqj+4ORAYAYII+Fdkg=;
 b=W7x296CCFyqSHqUIzWNGFDJiw/3TNpnpixAmgw6vX/wvd+bplcvrcskhzJ1t6feYnUI3ymuPv7f33WFs1V1TA9BHZ0NJlU5/L/j5/WS/NM1xLKRmg/i3c2Hl64weaf7IeYO8mM5T39wbjgPx1adJvh0U4e+Es0V/+8J/jjOx2+Jipfi/CfgwPWa5dihL7XZ6fGcosyLHlgS4n3ZzgheXYdLTEYcrGv6NXFkZbW0bC159WMTa9/6pNr5JkiSUuF4td64NPr6y9mHJA3ShjRo2IMc1//zI3jKxuFwUtKg3XtUiCYDRtwi27rVvxqQs7fT/dyZ5pg9baj3ozfmIq3xoZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLKOPYjbsnprfg4bl0qe0xnJRkqj+4ORAYAYII+Fdkg=;
 b=TV8Wi6uUXZ18EnKpn/gH48W8Dg/YeY+s+bbuzGa3pNEhq7vQU5MkLiY3+rtrLgtnjaApldbBFnhN9VmqYGKoYE0ZKleIplTTalIXAxztYmzxQsAVwL9+KzZGkcRpo/pbilgL08xiM1GBkirK3C5Wf24pmrd294IkTwvb4AjJvG1h+l7eyvIGPzrYllXvV+foISzFJL7lgBYR3ONfEq+r782UOllBWlwyrVMofLXYx8p2hKr7YKVBdXOdqwbhFkVJ9yVKFzrX+HiwOe3W4l/2Z738wMvWyeqfQRnxAsvA34T7wEbX76JAyGLjwQR0vvD6C8yqeYFrpDCkOL3Cql0Cyw==
Received: from TYYPR01MB13419.jpnprd01.prod.outlook.com (2603:1096:405:1be::9)
 by TYYPR01MB6828.jpnprd01.prod.outlook.com (2603:1096:400:d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 02:35:11 +0000
Received: from TYYPR01MB13419.jpnprd01.prod.outlook.com
 ([fe80::5408:8c53:d81e:a928]) by TYYPR01MB13419.jpnprd01.prod.outlook.com
 ([fe80::5408:8c53:d81e:a928%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 02:35:11 +0000
From: "Mingyu Wang (Fujitsu)" <wangmy@fujitsu.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: RE: [yocto-patches] [meta-cgl] [PATCH] layer.conf: Add wrynose
Thread-Topic: [yocto-patches] [meta-cgl] [PATCH] layer.conf: Add wrynose
Thread-Index: AQHcw0PPxnlsNmBvHU+7L/Jeh3jsHbZL6v2A
Date: Tue, 23 Jun 2026 02:35:11 +0000
Message-ID: 
 <TYYPR01MB13419CA18EC2DF6EB096534FDDCEE2@TYYPR01MB13419.jpnprd01.prod.outlook.com>
References: <18A2CB707C61701D.732937@lists.yoctoproject.org>
In-Reply-To: <18A2CB707C61701D.732937@lists.yoctoproject.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=43a44853-e1e0-4086-9717-82090e1a91db;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2026-06-23T02:34:05Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB13419:EE_|TYYPR01MB6828:EE_
x-ms-office365-filtering-correlation-id: 3bd0e7bb-4810-4f8e-ba2e-08ded0d00c98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|4022899009|376014|23010399003|1800799024|366016|22082099003|18002099003|38070700021|1580799027|11063799006|56012099006;
x-microsoft-antispam-message-info: 
 6MT56x3eIjbzVVI2sCdFXhtQ5MfxBZJ+Dl0uVpRppublHiYyDp3jQ/EIXUZnYWDOVURAphxB2XJgBe3a2ANIZ1PVvecpVBsljHCmxD1Ke/P1GfC7vUtl1WN6XRh+jc6NdqW1RFnJpTF03cpb1pxgJxVt2fQffkvKq4dJyKqFFKBgU2yZ4oWJ8yhoS/fcfzhEwBlLZ3Ea41KnZt32WLdCJjnCzF6+FNdA94lKtsC2BLjJ+yGIP0uKTT+xk/5zdLDUmbU9kj0TaurPZS2xzD7sjms9UwB1+hKhNByUJ4ka9qfY4C0RF0ptHSZm4PHPhpOabohDw0PYPSgsxOlBr6j3awi0UhK/0GlLMrTdfaSmeLkerHDZkpC7xmVUYcD+MXkdqweNHO2HrH/aMpYsuEy0Er1ohuSaIaUQAyyA5QZ/HjFeGTHUCmJAzThmovn4yZO1BKUJDWam+sm+v8ea1NKFw9MIf7+ZnUBOtQEYQRkDxrfYjr8PhaCP++V180QY1f98zU8lhW7ZxVZdDBGTQcCLkfhLeJL8RqRdANFN2NQwUSkThjZRXIRLfWtafcK5GOEGxDF5+9aqBlGS05q/7TIMBAg3uSDhaMzYAoaJz95HzqtlhkIlPVIJWo7ouTJsJXZgmJIvFdU3zUwaU+nIPgrh1Wt3sq0AwbhxicOjFU+YOg41mnpiaE9xotbuoA8/IVG6on+CaIyP/oTr0SBMYqw/UfZuOOmR3gWuq/3d5f4ArI5QHFlqBjjP+6asTOxrANEJ
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB13419.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(38070700021)(1580799027)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?gb2312?B?RWJGNm5SaTlDT2R5Z1ZCNnp5dGM3TVFiVGp3V1FyWFpsVzE2M3gzbkl0RUtV?=
 =?gb2312?B?QzlOSEt1ZXNWY1VPMmR1dXBoVDJvbWdTRTNGdWdGTG9mQzkwQU9adzJUN3Zq?=
 =?gb2312?B?TGdOOFNwa25PZWNTR3QxclVTcmZNK1NGSS9sY2taR0lvaGhPbEhLRnB0R25E?=
 =?gb2312?B?RGlsMWFYcWVTcythcUxERzZva3dVajJoQm9Oa3BpRVdWUVlRZU91Zi9PejFK?=
 =?gb2312?B?ZWZhck8weWJaUW5zL3JXM1N2bXNDZVlVOGpUc2hKeDhGZEZWZStvTFBtbDlF?=
 =?gb2312?B?OGcyZWsvaFkreVQ3eWRJbHNnTllUSDNIVkh6aUJ3TzAzMytHTUFYZ2JOS3pu?=
 =?gb2312?B?ajFTbXA0RGM2ak1ZWllQQXZNUjUrWGc5eWJPUllJZ2Y1Tk9JSStYZmhkREZX?=
 =?gb2312?B?NnhkZ0R1ZEU4RWZpd2Jxb21CNDhFblFzbFhidHZ5Nmp5SGtkT1FQY0tLOEhM?=
 =?gb2312?B?dkhTMlc0RWxrRHk3aStxL2dBU1d5Tjh5VGZXSDAwSXlvQlJFZTk0TkJ0am02?=
 =?gb2312?B?L3NycjVaZ1Njd3RZNHFQdmx3Z0p4aytEQjh3NXlpL3A5QXFNNk9EODd0eWZq?=
 =?gb2312?B?TlpxQmZCZWpqdWU4OTh6ek5KZFBCZEpzRnRVeGhrTm1ENlV5NEJaRGVGTnZa?=
 =?gb2312?B?N2VuY05LTWF6eGtXVCtmQlZwOHIvY3lxT3ZEOVlqeStSdklxQVJRNkliM2dM?=
 =?gb2312?B?SndqZVhpaUh0UUhYOFVaZlVzVVBwSWo0MVp3c3NwUloySE5pdDZ0N2NsWlp4?=
 =?gb2312?B?ajVDcVc0RE1OYk1XdndvWTFxSm5GWU5qWmlVdmRzOEQ4Z0Y2aG9oa1I0Nk83?=
 =?gb2312?B?NHgxT21ka3d6b1UzeUxmaC9rNmt3aEE2VmxrWVcvTktUN21VUHY2UzB5dFRW?=
 =?gb2312?B?aFpaN0FiN0xTZWdMcXAxVGttOHkva3B3cG53bTd4Q2puRnlGRjdRNmdRcmR6?=
 =?gb2312?B?TXVuU2IzV2l1c0drcU9OWVZPRlIwbkhtYjJCVW1jdEVSMTkrOG83YkE2UXF0?=
 =?gb2312?B?cGJoYlJRZ1VPbU9pQkhrVTQzZjhCTVhLTktYTWRvV3Q2MHREQ1hGb3JkUTBh?=
 =?gb2312?B?cFYwMmdKR0M4Yy9GNWk4Z3JxTEw4UWpyWkxrM0dmTHRCYjYraUxnWUhEbjly?=
 =?gb2312?B?blFqUUt1TGVMaUxEZ29vRkdBMDFGTTJVRHVYYzRlVkFPemRudmhKM3BITVpU?=
 =?gb2312?B?NkhvOCtYYWJ3eEZLamFHbnlvTkhSY3plZjh1UDE5R2luSG1wUWhqdlNBdzdH?=
 =?gb2312?B?SVM1UFRKTjdNMWFhUitndXpKVHdpL09wTU94Rm54cnJ3YmN0TStjN1AwSW5V?=
 =?gb2312?B?Qk9BbHBQYXNhRkp4c2ZoQzNWQ01kWnQ0QmxyYmIwSTArSW8zakxOZk5xQmM1?=
 =?gb2312?B?UEtLMC83dG1OSmRMbTRMZjc0Q2lnVFNmMWZreEp2VlB4NGlpNUdXc0pmdWl5?=
 =?gb2312?B?TlhOT3NQaEVnVXg4cS9MbnozNTNuc0dma0txblFsOXVTR09SenAwb2FNajJn?=
 =?gb2312?B?Smx0K0ZsRDlsclgxREl0VnlrZjNBdHhYd0NZZEZoZk82NVBQVzBKc0tiVnhJ?=
 =?gb2312?B?RzJLaGhUZlZ2Y2RLQUZsV3FBa1JsREF1anBLWnVMNXpkaXppbVdCSjI4eXIz?=
 =?gb2312?B?ZDRQMzFpbHQ3clcvWXJhRUJGRkRXWHdpdGVwWlNRZlFiZHdxRkM3eDdVcmV4?=
 =?gb2312?B?c1pEL3hMN2Fsa0hnRmFNN0lXTFQ1OVYwWEYyYUorcWNseDg1YjUrUW44ZmMv?=
 =?gb2312?B?L3d3WTVMUElMRFVNemxqR0hxTjA5S1dHcndPbExCU1pmWFJXblAyQlBoZWFa?=
 =?gb2312?B?b29nVExWZFVLRE9mSmlZdDhiWWpGK3hJRTE5cmNOd2FKd1FlWk85bDhvUHBT?=
 =?gb2312?B?VlBRSjRyVVJsSzA5L3J3K282WW1iS1ZBYWZ5dVJKNlhSTlc2OCswb256U2dT?=
 =?gb2312?B?K1NmSTdBVG8vK3JPbU42RDZDZVdrWVZRRVZCSGVxT3lZR1poZVBRalVGRktk?=
 =?gb2312?B?NTc5STJkeWw0Zzk4TnNHUm1adzVReThMQzVLY0lBbGFlN3ZyVzlvZE5BaWNO?=
 =?gb2312?B?clV3U0VOWlhZbU1VSWNIaXpZK1M4ejhFN3QrTXJBUnhvWFhYN1BSbmNiWlZB?=
 =?gb2312?B?WlBLVzlKMmhDVVFzOWVPK2JwL3FPVGZheGp1YzllejNQc3BjVzVSVVVBbjND?=
 =?gb2312?B?Q28wWHJ6M0loYll5TzJ6c2ZxQnRmNnFXQllLMzhwS1o0WEZBUHBsYlV2TGp0?=
 =?gb2312?B?SHRTSU4xYzhkN2JuT010b1BTMjZMbmNuU0ZVNzRhN3BTZGtsNTN3SEJiK0Nk?=
 =?gb2312?Q?cXklm0z4PmkzDbq4d6?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	SVKR1GNJBzCH6g13cN4JUxtarxp6B3ZHnSJCLl3UeZ88tztK55BfwiegqizwNeRcbeqQYsycaQH2ffvzh3LyminnOJDK3ylznO7cei7mpwA9lB2ydpxMjpeEuYN0AnexWPGnfEEBV4Sttvjm4Us7zU+DJFxiql8Dwk/DkFhyiTbtZVEqtLbctXDAFRVLH1iDfHMrlr8S4DLzgi+z5VP1fbbIyvybDoDMG3Y6IEraNh+JHC8JIivgalhAFoyby+E+6ZUNG2gJUkOmcxtFZ+D9BxeBfptFoVmpF/sKUMYbPLIKuhdrFX9dCwgO4xx06zQv2B+i2S6IrkUKDhaq7a1VrA==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB13419.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd0e7bb-4810-4f8e-ba2e-08ded0d00c98
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 02:35:11.5979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +OOD5XBiHC0BbHx7ujZ1t6Jo5TC4JMYmYy4dfeTeOEK532Ix27P3w31syA++YpW2LntomPsryGR0G+XQj+Dhxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6828
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 02:35:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4266

VGhlIHBhdGNoIHNpbXBseSB1cGRhdGVzIHRoZSB2ZXJzaW9uIG51bWJlciBpbiB0aGUgY29uZmln
IGZpbGUgdG8gbWF0Y2ggdGhlIGN1cnJlbnQgcG9reSByZWxlYXNlLCB3aGljaCBpcyBuZWNlc3Nh
cnkgdG8gYXZvaWQgYnVpbGQgZmFpbHVyZXMuIA0KDQpJIGhhdmUgYWxyZWFkeSBzZW50IHR3byBw
aW5ncyBidXQgaGF2ZW6hr3QgcmVjZWl2ZWQgYW55IHJlc3BvbnNlIG9yIGFja25vd2xlZGdtZW50
IHNvIGZhci4NCg0KaWYgc29tZW9uZSBjb3VsZCB0YWtlIGEgcXVpY2sgbG9vayBhbmQgbGV0IG1l
IGtub3cgaWYgdGhlcmUgaXMgYW55IGlzc3VlIHdpdGggdGhlIHBhdGNoLCBvciBpZiBpdCBjYW4g
YmUgbWVyZ2VkLiBJoa9tIGhhcHB5IHRvIHJldmlzZSBpdCBpZiBuZWVkZWQuDQoNCiAgLS0NCkJl
c3QgUmVnYXJkcw0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQpXYW5nIE1pbmd5dQ0KRlVKSVRTVSBOQU5KSU5HIFNPRlRXQVJFIFRFQ0hOT0xPR1kg
Q08uLCBMVEQuIChGTlNUKQ0KTm8uNiBXZW56aHUgUm9hZCwgTmFuamluZywgMjEwMDEyLCBDaGlu
YQ0KVEVMo7orODYrMjUtODY2MzA1NjYtLTg1NjgNCkNPSU5TOiA3OTk4ODU0OA0KRkFYOiArODYr
MjUtODMzMTc2ODUNCk1BSUw6IHdhbmdteUBmdWppdHN1LmNvbQ0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IHlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9y
Zw0KPiA8eW9jdG8tcGF0Y2hlc0BsaXN0cy55b2N0b3Byb2plY3Qub3JnPiBPbiBCZWhhbGYgT2Yg
d2FuZ215IHZpYQ0KPiBsaXN0cy55b2N0b3Byb2plY3Qub3JnDQo+IFNlbnQ6IEZyaWRheSwgQXBy
aWwgMywgMjAyNiA0OjI4IFBNDQo+IFRvOiB5b2N0by1wYXRjaGVzQGxpc3RzLnlvY3RvcHJvamVj
dC5vcmcNCj4gQ2M6IFdhbmcsIE1pbmd5dS/N9SDD+eikIDx3YW5nbXlAZnVqaXRzdS5jb20+DQo+
IFN1YmplY3Q6IFt5b2N0by1wYXRjaGVzXSBbbWV0YS1jZ2xdIFtQQVRDSF0gbGF5ZXIuY29uZjog
QWRkIHdyeW5vc2UNCj4gDQo+IEZyb206IFdhbmcgTWluZ3l1IDx3YW5nbXlAZnVqaXRzdS5jb20+
DQo+IA0KPiBMQVlFUlNFUklFU19DT01QQVQ6IGFkZCB3cnlub3NlDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBXYW5nIE1pbmd5dSA8d2FuZ215QGZ1aml0c3UuY29tPg0KPiAtLS0NCj4gIG1ldGEtY2ds
LWNvbW1vbi9jb25mL2xheWVyLmNvbmYgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tZXRhLWNnbC1jb21t
b24vY29uZi9sYXllci5jb25mDQo+IGIvbWV0YS1jZ2wtY29tbW9uL2NvbmYvbGF5ZXIuY29uZiBp
bmRleCA1MjJlMTIxLi44YWMyODFiIDEwMDY0NA0KPiAtLS0gYS9tZXRhLWNnbC1jb21tb24vY29u
Zi9sYXllci5jb25mDQo+ICsrKyBiL21ldGEtY2dsLWNvbW1vbi9jb25mL2xheWVyLmNvbmYNCj4g
QEAgLTExLDYgKzExLDYgQEAgQkJGSUxFX1BSSU9SSVRZX2NnbC1jb21tb24gPSAiNyINCj4gDQo+
ICBMQVlFUkRFUEVORFNfY2dsLWNvbW1vbiA9ICJjb3JlIG9wZW5lbWJlZGRlZC1sYXllciBuZXR3
b3JraW5nLWxheWVyDQo+IHBlcmwtbGF5ZXIgZmlsZXN5c3RlbXMtbGF5ZXIgc2VjdXJpdHkgc2Vs
aW51eCB5b2N0byINCj4gDQo+IC1MQVlFUlNFUklFU19DT01QQVRfY2dsLWNvbW1vbiA9ICJob25p
c3RlciBraXJrc3RvbmUgbGFuZ2RhbGUgbWlja2xlZG9yZQ0KPiBuYW5iaWVsZCBzY2FydGhnYXAg
c3R5aGVhZCB3YWxuYXNjYXIgd2hpbmxhdHRlciINCj4gK0xBWUVSU0VSSUVTX0NPTVBBVF9jZ2wt
Y29tbW9uID0gImhvbmlzdGVyIGtpcmtzdG9uZSBsYW5nZGFsZSBtaWNrbGVkb3JlDQo+IG5hbmJp
ZWxkIHNjYXJ0aGdhcCBzdHloZWFkIHdhbG5hc2NhciB3aGlubGF0dGVyIHdyeW5vc2UiDQo+IA0K
PiAgcmVxdWlyZSBjb25mL2Rpc3Ryby9pbmNsdWRlL2NnbF9jb21tb25fc2VjdXJpdHlfZmxhZ3Mu
aW5jDQo+IC0tDQo+IDIuNDMuMA0KPiANCj4gDQo+IA0KPiAtPS09LT0tPS09LT0tPS09LT0tPS09
LQ0KPiBMaW5rczogWW91IHJlY2VpdmUgYWxsIG1lc3NhZ2VzIHNlbnQgdG8gdGhpcyBncm91cC4N
Cj4gVmlldy9SZXBseSBPbmxpbmUgKCMzNjIzKToNCj4gaHR0cHM6Ly9saXN0cy55b2N0b3Byb2pl
Y3Qub3JnL2cveW9jdG8tcGF0Y2hlcy9tZXNzYWdlLzM2MjMNCj4gTXV0ZSBUaGlzIFRvcGljOiBo
dHRwczovL2xpc3RzLnlvY3RvcHJvamVjdC5vcmcvbXQvMTE4NjQ2Nzg4LzU5NzQ5NDYNCj4gR3Jv
dXAgT3duZXI6IHlvY3RvLXBhdGNoZXMrb3duZXJAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZw0KPiBV
bnN1YnNjcmliZToNCj4gaHR0cHM6Ly9saXN0cy55b2N0b3Byb2plY3Qub3JnL2cveW9jdG8tcGF0
Y2hlcy9sZWF2ZS8xMzYxNDI3MS81OTc0OTQ2LzE5MDI4DQo+IDMxMDY2L3h5enp5IFt3YW5nbXlA
ZnVqaXRzdS5jb21dDQo+IC09LT0tPS09LT0tPS09LT0tPS09LT0tDQo+IA0KDQo=

