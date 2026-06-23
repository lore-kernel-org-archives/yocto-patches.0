Return-Path: <wangmy@fujitsu.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63EACDB46B
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 02:20:55 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.23])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12408.1782181250371661594
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Jun 2026 19:20:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fujitsu.com header.s=selector1 header.b=LfzQiffu;
 spf=pass (domain: fujitsu.com, ip: 40.107.74.23, mailfrom: wangmy@fujitsu.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZ/suqR7Sj+o1cwvMZW3PEIoOUO9C2Xndj83E/NcsBZyqnBFx8R/eroBmr2nwL/dTaKtNkxudwoKvX6824nRCYfkk+Tt+/pumM5YZORB2H61DAVLLMDwP0xthdmzP0nmary08hagf0iDNFkvP11igUqZL6Ty8HdXWZyuoguR3q5APxaOR1W3/j6tIBKG6g4KuHA0trWly6HfhTkh3UROvZgHsQamSeFAU6aX+DrGIUuPOT2USOWM1fig4zlFWGf93X3CWxGqWk7lehm5FiEhIRNl+plk9IJuu1cHACEibDcOKR5tK+RjbinudTIqXb+3OsqsuvO99pe6gTy5tXt4uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnFt6+e1jiBsQYdurYrhfRq9ROU7hTUtk+dHAeN4CFY=;
 b=rzRKEggE+NjqrPWeJ6wDEJ4V2hxBKzpdpem3xku1DUK6TWcVtwj7Qesd8H5R1mkpaxLXMTQ990LXPrpEh0eWXdHPuAxncgOd2omCajeNYZ9Cex7wuIi5win7WdQOd2ezOrIGlpG5raqgV2UoR8fAClQ7iyn7HxHDsDp8grcXHmKVqbBRj0F4hYIafRYw0iujGH0huZpuLvi8qEc9xCAaTFFNbYUbqXUPQaQP+L+8m1djY0OxgqyFTos7e1XNxG7fAdE8lf6Tp3hqINuXnxtRMUub+ZeRs4XRoeqSMRaleq1kkR6EghglBAVwsws1wk7Pee6xnFxZ5iNAf1xugBZkqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnFt6+e1jiBsQYdurYrhfRq9ROU7hTUtk+dHAeN4CFY=;
 b=LfzQiffusUnPzfmU+an1fQmUyvHHZO94qncyU3qgS+iml7DK6XvUdbiNOxEJmf4BhO4bxTgaIIX3LEq4S0ajL45pz/sI4OzLcRF159dHsm8SycNK5C0eLbwWVrR8zpYzaeLaxfIhVl0YROYu+8fno8WnRPII/mL1V5gKw/BTGi43FAX6OvKAWU2HL/b8oWvlxBlHDAmAau8g1uOyPNP9RprcVfLBI8p4tgbj/jrRbcyyR2t9fXchoCb1h6ailTKAILqOBMwAIxIIWfTyYMJhCQDE14ma6Bq6zDmTQnx0mYlFxWMjxDtSSA+swQJl9xj3nhNzx3uLz4M2nkO+ZSxjSA==
Received: from TYYPR01MB13419.jpnprd01.prod.outlook.com (2603:1096:405:1be::9)
 by OS3PR01MB9303.jpnprd01.prod.outlook.com (2603:1096:604:1c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 02:20:45 +0000
Received: from TYYPR01MB13419.jpnprd01.prod.outlook.com
 ([fe80::5408:8c53:d81e:a928]) by TYYPR01MB13419.jpnprd01.prod.outlook.com
 ([fe80::5408:8c53:d81e:a928%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 02:20:45 +0000
From: "Mingyu Wang (Fujitsu)" <wangmy@fujitsu.com>
To: "Mingyu Wang (Fujitsu)" <wangmy@fujitsu.com>,
	"yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Subject: RE: [yocto-patches] [meta-cgl] [PATCH] layer.conf: Add wrynose
Thread-Topic: [yocto-patches] [meta-cgl] [PATCH] layer.conf: Add wrynose
Thread-Index: AQHcw0PNtZR/xRZT5kKQNT90dFeT77ZL5znw
Date: Tue, 23 Jun 2026 02:20:45 +0000
Message-ID: 
 <TYYPR01MB134198509FB0AB3871B7EA343DCEE2@TYYPR01MB13419.jpnprd01.prod.outlook.com>
References: <20260403082758.1460-1-wangmy@fujitsu.com>
In-Reply-To: <20260403082758.1460-1-wangmy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=9c197aae-a849-4c1a-9ef1-84dbbc8dabed;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2026-06-23T02:20:36Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB13419:EE_|OS3PR01MB9303:EE_
x-ms-office365-filtering-correlation-id: d517c4c9-fae7-49e5-b76f-08ded0ce0841
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|18002099003|22082099003|11063799006|56012099006|1580799027;
x-microsoft-antispam-message-info: 
 L8h/dmT5jnNYEns6zJ0PUX8NuBlmMMuGjD+2i7Pa5jVPrMdf3xeWHNZicFkt1mqPkrGrggIwGyFwIM4Cdgccm/hvhKyy0RSBbNUmAqJgcAQ3Wuuau25a/Bqhq6TxYP8MX8q319uiT8vy6t8YIxVw9dTlTCA0Rl+oHYifAOGPnes07VClrbHfxou29teuyheqm8hNv7Y2jd0XnO/4Qa8etrHJZcXBjpKiUEFrWirVY7JfSRUl3/ZAM0A+HWkgAKa0I72GlbPl6o9nANiqFXWMuWFuiUmhtva1ldzXAOlnEqapBqVSMFVw52EcoVxEB2ZwMJQ5el2kT5593Uh7U2AVa1jxT7MOfInKrUJjgX3mFrzvVin/ewjY0JRantd/8RPyQiGaD/50pKEg8N+D3Noo8MjB2Soelq+7o2OahQKopwZRXxAiXGS4K/BScEhaeLIYxHCNHAr3BPzSaVaAx+4XpVM5YANGzpAZZSlY8b7m4qJIMObeR1GE9n7nxtuL1oiDGedR0mRbcr+sF+wZDwlYzHiyQs+kQUlPguLViE4VzX7JLztSt1Y9JDFMJLpOY5fuebSxy1k2t+oZ3LXFjs+YHDYDTYMwtiT6k40dwgGDccPR8M/TESksX9iYCVXT0jjrwU1Rg4ZpmKRRzAHnFAUKUsi0NQLVHdlQodKPJSoB9NY3DDSSz8BLAxmcPfkPEiiQb2e/6d/t1RX4jNEMOUU0lhIzjY5dREloXqGcNML7kjUCRTh5uvkyWzkBmYkvfL/K
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB13419.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(11063799006)(56012099006)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?gb2312?B?ak9yRGpjd2QwT0l1L0JEWDRiVEdzd1UvSFUvT3pSWEliYW9RZTEvdjFRRUFT?=
 =?gb2312?B?SFB4QnBic1lmRmJzeER0UDlDaW5kWFJkNmtNeWNNdW8zc01laUhNeEU3TVlM?=
 =?gb2312?B?R1ovSVBXNGlCSWJyY1kwbkRybnE1MVRyLzlRWlFsQ01WeVBWV01sNVlVamFO?=
 =?gb2312?B?REpSd0FmOHFwSXdrRXdZOEMyTTh1QTVra1BGWThwR2pxRlExSEc5ejhtc1FL?=
 =?gb2312?B?TDdHamxBMnN3Sk8vVmxJUTRFY1BIYUhseFoxSU9iaTE2TmpRQ0pDbXJHR2FT?=
 =?gb2312?B?UTJTYWtWZUI5anVhbUlPbDQ2UzU5RGVGUVJGMUE1US9Id0d0WEZ0V05PNnRv?=
 =?gb2312?B?T2hSQ01EY1FRbEw5S0xHVmpyNklyN0xnTDhUVEhXUlFiZUhYajlYRm5zZnc2?=
 =?gb2312?B?UlU5ai8wNW5NT0RMc0RZcU5NV0lEc2prT09CVm5xR2FuYkdzWlREN3UxV0NL?=
 =?gb2312?B?alF0NjhnUEhCaWhENkphM2ViNzM2Q2xnd1RJeEE1Mm43aFdDQ3VkV3NzMEYv?=
 =?gb2312?B?QzM3WXZpWHdBWFJTM0pCeFFFSzJSbGxOcXg3UEo2aVlLRkw3dTdlUGVrbkZY?=
 =?gb2312?B?WTZGVXhmNEhmbkJYSDYxYi9DNjZFb3BRQVBlR1FWTjFMYUN6VCt3aXlCTWF5?=
 =?gb2312?B?VUlueWt4Q0NnNUk4c2cwemRqdXNQUC9IMXRqb3BDUU5XN3RPTUFKNDJnSCtG?=
 =?gb2312?B?UEpjeU0vQVFiNEpWZHpPQ1A4MUpMcTRscjBGd3lvVXpHeWtGV2RweTljUkZo?=
 =?gb2312?B?YTVZb3RLUGNDb0FraDFXRzZDQjgzL3JHUWVIdE05VVdINzUxNWFyMW96L2xz?=
 =?gb2312?B?ZTdxcThhaVZyV3kybmhyM3p5NW8wVVNId1BBRnVWV08zaldmVTFQM282Z3Ex?=
 =?gb2312?B?MHdpYk16Vng2emg0Qjh0bThWUXZvMjI2VDZveVFxb3hyeGtLRXVkaGsyeVFq?=
 =?gb2312?B?S2hQbVhPTE0vNkVmZzVRV3JNUWxqM2JYSkpDemxVNERWa0g5eGFDQnltem4v?=
 =?gb2312?B?QlVVdS9hMWZ4ck95MXFIR1Y2UlpIVWVoaU5qM1lGMTMwMDNzbUg2SksvZE5O?=
 =?gb2312?B?MEJ4VzhLQ3VhYVl3ODZtVVdIUVd2OVhwbks3eS8yRG5xRUNXYjhWelBpa1BX?=
 =?gb2312?B?UFlMSU83TFpWd2VGV2xYVGFOcnVFNTROaGNIZGFobWcrRFdwUHZpL05CYTh0?=
 =?gb2312?B?SDFDM2t3L2lEM1B1Um1kMWRFenF5QUNWa09VUmNQdmhhemhSK20vbmtUWWE4?=
 =?gb2312?B?OTEyTUVhN05WaktTbHExYjMzYVlGWUNyNDdLUytmRlNIYVU5VTI0QjJMS2Qv?=
 =?gb2312?B?Tm1LdVVmNXJvR2ZDOHJEeHVsTFB4Rk1UeUhxa2xnS0M0azdLdllnczQrRGl1?=
 =?gb2312?B?YUg4WTJHUkovNW0rY0VhTlIxT0FpYzlRaVliTlBRZjc3eDU1S0hwWVYrVUg2?=
 =?gb2312?B?SnR1S3FubmxHbldlL1BLMHB2NDRmaUhqUUZzZjBUWXgwRHBRb2RYUjQ1N2pS?=
 =?gb2312?B?ZXhFakk1WE5tU1hPZEllbGJpU1NZMko3R0hWT1hUYjdjdTB0ZWRIL3BDTm51?=
 =?gb2312?B?Z2ZjWWtBRjhKenZDeUpxNVBTandzWU9MRkdEcUozS1hrekxta2R0cWtraG5H?=
 =?gb2312?B?NmNFZXN6MFVsTGRzM0pKMlFKaFZCZlRIQVhuZjErbU82anhQNkovdmFQZWFp?=
 =?gb2312?B?clI1VGl6SC9jR0ZvL05RV3cxQTNrK2l5YXhWNmpGUGNpWExucUFqUFB4M0Rl?=
 =?gb2312?B?S1E5VGtZcjNjNFJmc2tYbkpFUnJnbDgxRUdEaUhCT211Zlh5MDRlNDZNYTZy?=
 =?gb2312?B?UUFBSGV0Mkd3Ri9kcE93TFc2SlBJamhLcG9EM1pyaU5LcHNFd1VuZndieFB4?=
 =?gb2312?B?V2IwZVMwQmZrbDNBKy95T2RKWTJrZ0s1Y0JmemFyckkvbU84Z01LMlNtcWk5?=
 =?gb2312?B?MVJxa3BvNHhZaytmams3cUlURWhnV3AvZ2YydnNZQmFySFFyU3lBNXFVWGZB?=
 =?gb2312?B?eXZyMWFQcSsxd3Jhbkx2TjNjV2lpRVdNNTAwVWEvVks4Z0xYbjcyQW9RdWpv?=
 =?gb2312?B?SGYxek5sRHFDekZpbnZGeS9nMUVlWHFNSE5hWkE2UlZ4WUJZWERUa20rTzM5?=
 =?gb2312?B?WGZDMG84V29ZMlM1bThMeFIrelcwRmZVaVRseUpmSFhOc1NpdjExVlJlMDMz?=
 =?gb2312?B?MzVOR0V1WUFIbWF3QzVhcG9pZWVtUUY3eEZFKzF4ck95c2YzU29neFhqeE1X?=
 =?gb2312?B?Ry80bDh1NjUxMDM0eGwrcUxpRDNyazdpcHpjL3hxMytVWTQ5SnpJcjBYRjNp?=
 =?gb2312?Q?efcrLGCrCbOkEmEWfT?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	tAzgQx+QvzrGOEotAIvyPlwdlqrW7f7BPuybeKDiGhL+yu9Nc8ac98ewBXlCxDpLmpNxfhpb8pR/veCghOGOajxJl2i9ykE3u3nOehewfElyx56Llnm2GfUNmY9wYlgsEvifLVvLLB0WGRTsi7KpPFuru0vg07H5OT9SAM301b5h8X1JAv8DMQniXTjl2ou24GOgBLJYhf66bgRMLREl94rKvfkKEaok5UsBrctZ4kn+3BW6lItE2zbN49w1hL3b+7svFGtAifXjogKZHD7WBxbxXb3GEBEHN+6u0C4hq5KuPjjFpORggONAQulWGwLxO6OlUD6XVnmhqYxCi+BknQ==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB13419.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d517c4c9-fae7-49e5-b76f-08ded0ce0841
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 02:20:45.3074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EqUPrWbCmR8k5M7PurQ4R6qVkRnwFfbCEI4eqLR/yPTVrjeKxF9w622jydxoUwU9leamGgxDOSZiGSRPJdN5yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9303
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 02:20:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4265

cGluZw0KDQogIC0tDQpCZXN0IFJlZ2FyZHMNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KV2FuZyBNaW5neXUNCkZVSklUU1UgTkFOSklORyBTT0ZU
V0FSRSBURUNITk9MT0dZIENPLiwgTFRELiAoRk5TVCkNCk5vLjYgV2Vuemh1IFJvYWQsIE5hbmpp
bmcsIDIxMDAxMiwgQ2hpbmENClRFTKO6Kzg2KzI1LTg2NjMwNTY2LS04NTY4DQpDT0lOUzogNzk5
ODg1NDgNCkZBWDogKzg2KzI1LTgzMzE3Njg1DQpNQUlMOiB3YW5nbXlAZnVqaXRzdS5jb20NCg0K
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXYW5nIE1pbmd5dSA8d2FuZ215
QGZ1aml0c3UuY29tPg0KPiBTZW50OiBGcmlkYXksIEFwcmlsIDMsIDIwMjYgNDoyOCBQTQ0KPiBU
bzogeW9jdG8tcGF0Y2hlc0BsaXN0cy55b2N0b3Byb2plY3Qub3JnDQo+IENjOiBXYW5nLCBNaW5n
eXUvzfUgw/nopCA8d2FuZ215QGZ1aml0c3UuY29tPg0KPiBTdWJqZWN0OiBbeW9jdG8tcGF0Y2hl
c10gW21ldGEtY2dsXSBbUEFUQ0hdIGxheWVyLmNvbmY6IEFkZCB3cnlub3NlDQo+IA0KPiBGcm9t
OiBXYW5nIE1pbmd5dSA8d2FuZ215QGZ1aml0c3UuY29tPg0KPiANCj4gTEFZRVJTRVJJRVNfQ09N
UEFUOiBhZGQgd3J5bm9zZQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogV2FuZyBNaW5neXUgPHdhbmdt
eUBmdWppdHN1LmNvbT4NCj4gLS0tDQo+ICBtZXRhLWNnbC1jb21tb24vY29uZi9sYXllci5jb25m
IHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWV0YS1jZ2wtY29tbW9uL2NvbmYvbGF5ZXIuY29uZg0KPiBi
L21ldGEtY2dsLWNvbW1vbi9jb25mL2xheWVyLmNvbmYgaW5kZXggNTIyZTEyMS4uOGFjMjgxYiAx
MDA2NDQNCj4gLS0tIGEvbWV0YS1jZ2wtY29tbW9uL2NvbmYvbGF5ZXIuY29uZg0KPiArKysgYi9t
ZXRhLWNnbC1jb21tb24vY29uZi9sYXllci5jb25mDQo+IEBAIC0xMSw2ICsxMSw2IEBAIEJCRklM
RV9QUklPUklUWV9jZ2wtY29tbW9uID0gIjciDQo+IA0KPiAgTEFZRVJERVBFTkRTX2NnbC1jb21t
b24gPSAiY29yZSBvcGVuZW1iZWRkZWQtbGF5ZXIgbmV0d29ya2luZy1sYXllcg0KPiBwZXJsLWxh
eWVyIGZpbGVzeXN0ZW1zLWxheWVyIHNlY3VyaXR5IHNlbGludXggeW9jdG8iDQo+IA0KPiAtTEFZ
RVJTRVJJRVNfQ09NUEFUX2NnbC1jb21tb24gPSAiaG9uaXN0ZXIga2lya3N0b25lIGxhbmdkYWxl
IG1pY2tsZWRvcmUNCj4gbmFuYmllbGQgc2NhcnRoZ2FwIHN0eWhlYWQgd2FsbmFzY2FyIHdoaW5s
YXR0ZXIiDQo+ICtMQVlFUlNFUklFU19DT01QQVRfY2dsLWNvbW1vbiA9ICJob25pc3RlciBraXJr
c3RvbmUgbGFuZ2RhbGUgbWlja2xlZG9yZQ0KPiBuYW5iaWVsZCBzY2FydGhnYXAgc3R5aGVhZCB3
YWxuYXNjYXIgd2hpbmxhdHRlciB3cnlub3NlIg0KPiANCj4gIHJlcXVpcmUgY29uZi9kaXN0cm8v
aW5jbHVkZS9jZ2xfY29tbW9uX3NlY3VyaXR5X2ZsYWdzLmluYw0KPiAtLQ0KPiAyLjQzLjANCg0K

