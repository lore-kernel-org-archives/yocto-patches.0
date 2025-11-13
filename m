Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7253CD6E74
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 14:47:09 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.25665.1763045223291811529
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 06:47:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kgsElKHQ;
 spf=pass (domain: siemens.com, ip: 52.101.72.45, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIDwcpyqFAQ1TXWZsRbcJV2tr++NW0e2M/B8EQPMFc8XrP131s9wy0WWv2Ued4HTisQjsxIwULsSmOrpHK2JE1rjn5aPURd6JWyILG2QATDW56L/lQqEUI5ClJFWt6haRS/5Wb5Wgst2mZbEFrlmhE4n/Tf5cefhbgsaJfgD7Sywp5t5zWdpl/Lzxm8I5xxd2chJKVc3XkwshOA5r3JgJcOMqOqZRTC/WJ84xr3L1Z3TB4hwzuVKQrXeajW5CTrI6J00+STyma3QQWXGeKurgd8912IdLTRaDBEPUgV7rfbgUCyGTI4JsKYAA3UxSZebh13W6ImZgcZ6n7j12P3DJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxNkgAZFggZyqvYx4hFy90R52WC3gTVrxP2x2EDKL8w=;
 b=imQpBgGqwKE+UtRaIMKLnNAFcww+4XfcZWpQxJR8tmrluP0mFFz6hSKSx4dstrQmk56jiWClxsDsJn6e33UjUUaUctrsw+Pk3qZfKscprPHfTOHJI9hyRS0umU8JDxXU1JI1NRvh0hYehW3sU9i3f3gTkLh4kOPTD3iHB9fL2jls9AkrTA1uCWnWwcbLXwOI9i1y/7MfHa7J1yxk1zy4akEbJIp2yha1MP+Ux+Z250/MfCq0bHAGl9rDp9m9NVUcDPpamPQLqvxmQMgsGTUn62Z9TrP5Z11kcpqyOTfipgpRPW8UXYshKDYnyXADk31p0/KTrr+NI0xUA51aWlzOrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxNkgAZFggZyqvYx4hFy90R52WC3gTVrxP2x2EDKL8w=;
 b=kgsElKHQwvjXolBKBPJVABkxP44btr3+8Gn9Jn+EFXxGYcqmBT4vCmoWZyVNH6TM+Svyw5YPaxVfjdJ0PGy66sxLhog5XYZKVBMn9M1AWq3QWp8FEnSniesLsYKPVf5IaQY3BwYOZyUBVGt3vaD8Y5ClDP8CvP8y6tY9xUwcGSmJzyzNxDseQPuacTccVxsilT4/IJb289W56sfOSnhdjX66Vtt8I5j7wwXmklqz/wLgDm/s6lb0ArIVWVIbBBjhPWK1wtQodvBv84OcnhLRjRRSB4xKVXTI9zdO45PUiPWiYJMwXFdDnWFaz5caWUZBqI06mv1+70RgLkk29Jwjhg==
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::20)
 by GVXPR10MB8825.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 14:46:59 +0000
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c68:267b:6fd1:d3f2]) by AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c68:267b:6fd1:d3f2%6]) with mapi id 15.20.9298.015; Thu, 13 Nov 2025
 14:46:59 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: Gyorgy Sarvari <skandigraun@gmail.com>,
	"yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
CC: "jose.quaresma@foundries.io" <jose.quaresma@foundries.io>
Subject: RE: [yocto-patches] [meta-lts-mixins][scarthgap/go][RFC PATCH 33/34]
 readme: update to markdown format
Thread-Topic: [yocto-patches] [meta-lts-mixins][scarthgap/go][RFC PATCH 33/34]
 readme: update to markdown format
Thread-Index: AQHcVJ0KUZrQIIaFD0KK2TxhATMdH7Twk56AgAAbj0A=
Date: Thu, 13 Nov 2025 14:46:59 +0000
Message-ID: 
 <AS1PR10MB56970C7AC53E0D0B84208068FDCDA@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
References: <20251113125712.18914-1-peter.marko@siemens.com>
 <20251113125712.18914-34-peter.marko@siemens.com>
 <15ecd02f-cd2a-41de-9cf8-53ef1ca2da5e@gmail.com>
In-Reply-To: <15ecd02f-cd2a-41de-9cf8-53ef1ca2da5e@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=441927cf-9989-41e9-b07e-eb89a15a0619;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-11-13T14:45:49Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5697:EE_|GVXPR10MB8825:EE_
x-ms-office365-filtering-correlation-id: 2a283196-d86c-4a88-30ab-08de22c37fe0
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|4022899009|366016|1800799024|13003099007|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?amxkcElEZGtoRnRKM21ZQWREQUdxV3R3ZXJCak9nSW5qZUFJMXd2Tmk1T0k5?=
 =?utf-8?B?NXZqVXlKWitjdklFNzVNRHhqb0oxT3RTMEluSlNZYjBOOVk3T2VhNWsyN0Vs?=
 =?utf-8?B?bEIwQ0hDbjJ5dTBsNk1va0EvUG5LSzAybXFRNjVMd3hDOGhTWTQ0M2M5anJ6?=
 =?utf-8?B?T3ZURGRmME5MUGEwQ2JRTmx1bm5TMzNRaHd1TkxDVU5QMWd4aFJXMkhaRkIy?=
 =?utf-8?B?Q2RGa1o3VnJDVVZ4cUROVnVHY2J2TXFBZTZnWGh6ZW9zTnRRK3QwN21qQUFY?=
 =?utf-8?B?L1hYWCtnT05pVzVHaWVUclBSMkJjNkdhbEhNN284VDVXUGp0Y29uYWY3TUlO?=
 =?utf-8?B?SlhmRVlrSDdiVWQ5OTVJbEV5QVVSRHVWdlZuRE9iVjVHZk9LWFdsMXVaMUM2?=
 =?utf-8?B?V0JVTzIyZkRmMVRWY2pXL21MV1ByK3BYQVRDSUVkLzl3amczLzFGVDltVmpv?=
 =?utf-8?B?UFhtL1VzSDVndkM1TlZSdWRiVTZjUldnYVZsbGhmK0ZwbjNVc1RDM0NWN1NE?=
 =?utf-8?B?VitKbUpBZnhhNFExUWlJZVhqanJKaTFtbU84N2RDYnZUSWRFQnpFVFN4eDJw?=
 =?utf-8?B?ZTRZUExINFgwK3BaQkx6UC9MQUxwZ2c4Q1RzdFlHY2dZZ3N6SXVrR0xKaEUx?=
 =?utf-8?B?ZFQ4UzhhSCtick9wYkt2VmdaYzc2NmU5TTZ2RTNQM1E1clBVYWpsbTA3empu?=
 =?utf-8?B?Zis5Y1V2ZGVIRTRmK1N2NytQVXk2b1FtNjZQVk9BR0Nvd3dSOG0vQnNSc2xH?=
 =?utf-8?B?TlNZaE5MZ1l6aUlOUnYvbkNsMEQzNVVHQXRiRnRGanp2L0Q1OTZYR1ZXVDNy?=
 =?utf-8?B?ei95RXFxRHhXVHJCb2s4VTV2azNrK1lqdktmQW1OU3F3OHNSNGJBNUVENURL?=
 =?utf-8?B?RkFRYThvamZ4YkNHVndPU253U3ZsM2liNHB3MG1zSGVYUDlYbnhiZDI4VGF5?=
 =?utf-8?B?V05mSVBlcEFZa1hDMTRHUXo5cjZsT1Y0N0hoMHhQajFGaUlJYXlBMVRmK3Fh?=
 =?utf-8?B?Ui9NcUNGSFVYOCszV3UyZDNQSC9UL2VtNEc3K0hsTVF2OFQ3aGdZTDc4Wksv?=
 =?utf-8?B?NzRRNmorbDdLTEhyMGlhQ0xkSUNGeFNhOVRGNFFXaXNyejFpc09GdG0yeGs5?=
 =?utf-8?B?R3hXYllOZkVJTFRsNUErKzRwRDlOeEdLbkFMVE9mY3JUV0RmRnJkMFVscTdz?=
 =?utf-8?B?VURVVjg1TFhzTC83SUsvYjUvWGhlSTNIVzNYTVo5OXJ4czQraklYeTBPRWU4?=
 =?utf-8?B?NGdqa0RJbzdoTG4zNGJuNEloc2hlRlYycjdVa05qbDVjdFdiZERSMkNQTHJ6?=
 =?utf-8?B?aEZmT3h1UE9mZERIeng3R2h0UW5UUENGZFk5bkx0WG5ma1VnaXVsNnUzZ3o1?=
 =?utf-8?B?b1hLTjc3VDZUUitBdXE0aGQzVDc0emFvdTJyVWs2VFp0bnp1UjEzWGJySmVs?=
 =?utf-8?B?RXF1dlBtQXBWUjdkUmRBK1FSNnBKQVlWZU8yQjRyZExnbElYbXFvTkRPY3Ri?=
 =?utf-8?B?TFFtbjBoMVhDajZDNGc0dGpqVGt3b0NHb0VNYnJBRzlhUFpCOXNHTUtDQWZx?=
 =?utf-8?B?dWxxeTJOQXMxTnoyZE1xRnUzYjlrbThBUXIxanBTRFZhOFZJbTdZUkN0b2RO?=
 =?utf-8?B?bTNLMSs5eVlIZ3MzS2U0NXZKVnpzVVlHZjYzYXpQOWVORWxBdHloL2JmYkth?=
 =?utf-8?B?WTQ4dHFEYzZyNkE0b1FaL3JzM0s4d1VPWWJldHh2NHdjd0VkSjZEWWY2aG1l?=
 =?utf-8?B?TjVUV3MzZE9WUVhtUnpJOGtUeURvNkZCSlBHa3NUNFlMM3Uxb0RsckpoOFpK?=
 =?utf-8?B?bVJtaXZTanp6MWpqUGJqUCtUOVNmTGlvMU5pSzFwTFA1QXJzZzVISUdlWXc0?=
 =?utf-8?B?ZUZvN3hzekFrYkxYdFJROHpxdFlNelNjd0RldXY5S0NuUjNrN0VDeS9sc2Vx?=
 =?utf-8?B?QVVYZENodllqTDJGMy9mY3JtUHMvMEw3bmJvR1QxczBPNDRJVmxDWUhyeDdn?=
 =?utf-8?B?NnNoV1NUV3pBPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(4022899009)(366016)(1800799024)(13003099007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aDNDSE5tbk5ZMm5YaHgzbTF2dVc3SFJVV0E1eGRZQ0QySGdRRXZSQXJJd2Vu?=
 =?utf-8?B?YU5ubVllbUkxNEt1ZUVsZlJnNm5FTDlVZEllZkQ0STFJTUNZbE9lWHFxc3h0?=
 =?utf-8?B?T3VuZ01La09NUlpXZFlUbVA4TjMzU3RkeHAvYzFvZE96dHdIaFFiRlE1NDZp?=
 =?utf-8?B?WkpCZEtFQ0MrVy9CRDU3d2tPNk9hRjZnWitPNnJ4UlRSczBGL0laSmJScG0x?=
 =?utf-8?B?Z3BOMWRYMjhPU0ZXemhTZkZaV0NoUnR6NEgzVjFVRnhKWTV5M0lIUnhHam1H?=
 =?utf-8?B?N3ZqNHh2aVcwcmpQR3l3Qy9abXJUeHM0KzNzdUNzdVBqZi9tWWRxVUxNYzEx?=
 =?utf-8?B?OFN4Ymtnc2QydEJzTjBVaC83alhacUt1Q3E4bDluVWRMOU9uYTVoLzdyYktl?=
 =?utf-8?B?NFhqemJWMFhvR0RheVloS29TZ1JtNEYzTnc3cW90cUtNTFFBTHJCQlRXTnlF?=
 =?utf-8?B?MWtzRWFWc204SFlvcmZ2dDgzdEFUYldwNmVWNERDbTF1MVNDUFhtREw0YVVM?=
 =?utf-8?B?T2p3VHkybTVIajZqQ0NTUEhQbVNpQ0lmT2JxNkdLd0lXU3VyWTFGQXVIU29h?=
 =?utf-8?B?MG5XUk1TalVDeGFUSWtRRVY3Mm5TZjVZWGNVOHdQYUFYcFpvdzh3Vzk2QWNn?=
 =?utf-8?B?eitnV1hrWUhWVFRYSHFxeUEzT0VtWWNOTUJ3Y01PZXJBaHdCdDlMWG9DZUNH?=
 =?utf-8?B?dW5YWTVGdFFzbWhUYTF0NHNvcVI3WktENHhUaWt6Vk9zaHFHdzdJM0k0R0tM?=
 =?utf-8?B?V25xWWhBdnZSN2ZIbDgyeVlqVFFVc1VnN3JZUXEzN2loN2Y0c2lnT2VUNEJx?=
 =?utf-8?B?THdlWU40V0UrakdwekJ4VHc2YnFVUGphRnBJNkJxMnhSUGJQak9NN3E5cEEx?=
 =?utf-8?B?cGc2bFk2Um5oRHEwWkZjWjJDTUJhQ3FPT3hQRFRqOUJ5ZlVTaHlpV2JOYVd1?=
 =?utf-8?B?VUZPMENSeW1tUXBSc3Q0SnUvSkF4c3JWSlhIWk83MGlEejd0SjR5bnlKUXFt?=
 =?utf-8?B?aVI3WUhuSTNWV28xRUNSUjJObGkxcFJ1MVhuVEUwTUtmSnlqTWZCdWR2SHB3?=
 =?utf-8?B?ejQrd2dWTG1hZFhVZTk5dzhOSTNhOUg5WVJ1RGFZMzc5dU9ZdjBXTFRNK0xi?=
 =?utf-8?B?ZVRhQ1RGYVZCRFE2b3NralBBUHYvRE9wMWhrbEpsUVZiMFNGN2d6NXp1bjg1?=
 =?utf-8?B?M2xjVUt3MGZLcVo4UncvWnFtZnFwQVA1WUlIWXVrM2FFRHdqdVg3T2lLRHUr?=
 =?utf-8?B?UXJYWUE1aWUweDVxY29tRHdnV2FnSWswM1BxTU1uV2xKQVhTUEgwUmI5N1A2?=
 =?utf-8?B?UUhwNDRWQTNsUE1mOEk3S0VGck5Qd0tJeTFGbk1DZ2FhQTBad1JEODlyc0Zi?=
 =?utf-8?B?OVdwTUJsNHIyOTZ1MXFianlpbGpodUcveG95SkVnNk9abWhNb0lUWmR6cjdH?=
 =?utf-8?B?Y1ZKSGt6eWpGbzZ2TXhGZ1dYODNHNXlSQ1N5OUFzdkR1OXdZZm9wNTh6L2tP?=
 =?utf-8?B?cCtFcHcxdVl3a2xBZlJBK3BMRVdDUFJrWjdBVUZqd1BZT1B0bVplVkl1TWpT?=
 =?utf-8?B?S1hRMXNzdzgzcVFURHRUTGhkL1djb1k5THIvUWVqNGVsRGtNSEE2OTRsdFVz?=
 =?utf-8?B?aVNOREVDTFdldTBxYWxxTG1wT0Y3RU1BQndFcm9YVWlMaG5sdHJlUTYzK1Zh?=
 =?utf-8?B?SGs4MGlVenJLcFBhUDlsZFgzQ0JwUERtNG9XeSt5ZkE4YnU2MUNFckZXa1Vt?=
 =?utf-8?B?TDBrRDZMSFUyS0tKT3d1dG5mSG91eFBlS0pXd3ZHT0pMdk9BVXgwNXVyc1RG?=
 =?utf-8?B?TEE5czgzNlQ1SjZCL083L0gxS0tQZFBoeTRIanZYYTIrNGRDWFhmVVJyaDc4?=
 =?utf-8?B?ZS9IZnJIcS9XV0YwUE81MGpnQXJqRmI5cmVrZHpYWVJ2eHRYN1JhQWdrMlo5?=
 =?utf-8?B?MmdzT1dJanV3SUd2SnNxNXBsRTVQTVcyUjVOakxoQk1pQXZHbXVYdktMZEJa?=
 =?utf-8?B?OHVGaVgzL3JrdEVqbURDWFV0eEFFaXhYZ0RiUFg3RStYNDcvMXB4dWVtMmdm?=
 =?utf-8?B?UjUyMktpS29VRGw4aHlOSWFsdUovd1NPRGVhUXY4MWhHc0tGR3Y1YmFmajBp?=
 =?utf-8?Q?U8dD41fXAhje1ZzlsG5D/3wIS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a283196-d86c-4a88-30ab-08de22c37fe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 14:46:59.2122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kjobFrkooSiwzJdrYNgplslRfUA5EewkqdpU9EdjcENkuXV0Ca96rEC2VLXqYzOILnks79inEQ3/TURXBZyW0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8825
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Nov 2025 14:47:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2541

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3lvcmd5IFNhcnZhcmkg
PHNrYW5kaWdyYXVuQGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDEzLCAy
MDI1IDE0OjA3DQo+IFRvOiB5b2N0by1wYXRjaGVzQGxpc3RzLnlvY3RvcHJvamVjdC5vcmcNCj4g
Q2M6IE1hcmtvLCBQZXRlciAoRlQgRCBFVSBTSyBCRlMxKSA8UGV0ZXIuTWFya29Ac2llbWVucy5j
b20+Ow0KPiBqb3NlLnF1YXJlc21hQGZvdW5kcmllcy5pbw0KPiBTdWJqZWN0OiBSZTogW3lvY3Rv
LXBhdGNoZXNdIFttZXRhLWx0cy1taXhpbnNdW3NjYXJ0aGdhcC9nb11bUkZDIFBBVENIIDMzLzM0
XQ0KPiByZWFkbWU6IHVwZGF0ZSB0byBtYXJrZG93biBmb3JtYXQNCj4gDQo+IE9uIDExLzEzLzI1
IDEzOjU3LCBQZXRlciBNYXJrbyB2aWEgbGlzdHMueW9jdG9wcm9qZWN0Lm9yZyB3cm90ZToNCj4g
PiBDaGFuZ2VzIGFyZSBpbnNwaXJlZCBieSBzY2FydGhnYXAvcnVzdCBSRUFETUUubWQgZmlsZS4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBldGVyIE1hcmtvIDxwZXRlci5tYXJrb0BzaWVtZW5z
LmNvbT4NCj4gPiAtLS0NCj4gPiAgUkVBRE1FICAgIHwgMTUgLS0tLS0tLS0tLS0tLS0tDQo+ID4g
IFJFQURNRS5tZCB8IDQzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA0MyBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMo
LSkNCj4gPiAgZGVsZXRlIG1vZGUgMTAwNjQ0IFJFQURNRQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2
NDQgUkVBRE1FLm1kDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvUkVBRE1FIGIvUkVBRE1FDQo+ID4g
ZGVsZXRlZCBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggOWUyNzBmMi4uMDAwMDAwMA0KPiA+
IC0tLSBhL1JFQURNRQ0KPiA+ICsrKyAvZGV2L251bGwNCj4gPiBAQCAtMSwxNSArMCwwIEBADQo+
ID4gLSJNaXhpbiIgbGF5ZXIgZm9yIGFkZGluZyBsYXRlc3QgR28gdG9vbGNoYWluIHZlcnNpb25z
IGludG8gdGhlIFlvY3RvIFByb2plY3QgTFRTLg0KPiA+IC0NCj4gPiAtQXQgdGhlIHRpbWUgS2ly
a3N0b25lIHdhcyByZWxlYXNlZCBpbiBBcHJpbCAyMDI0LCBHbyAxLjIyIHdhcyB0aGUgbGF0ZXN0
IHZlcnNpb24NCj4gPiAtYW5kIG9mZmljaWFsbHkgS2lya3N0b25lIHN1cHBvcnRzIG9ubHkgdGhh
dC4gVGhpcyB0aGluIHNwZWNpYWwtcHVycG9zZSBtaXhpbg0KPiA+IC1sYXllciBpcyBtZWFudCB0
byBhZGRyZXNzIHRoaXMgaXNzdWUgYnkgYmFja3BvcnRpbmcgR28gcmVjaXBlcyBmcm9tIHRoZSBt
YXN0ZXINCj4gPiAtYnJhbmNoIG9mIG9wZW5lbWJlZGRlZC1jb3JlLg0KPiA+IC0NCj4gPiAtVGhl
IHBhdGNoZXMgY2FuIGJlIGJhY2twb3J0IGZyb20gb3BlbmVtYmVkZGVkLWNvcmUgd2l0aDoNCj4g
PiAtDQo+ID4gLSBnaXQgLUMgLi4vb3BlbmVtYmVkZGVkLWNvcmUgZm9ybWF0LXBhdGNoIC0tc3Rk
b3V0IC0xIG9yaWdpbi9tYXN0ZXINCj4gbWV0YS9yZWNpcGVzLWRldnRvb2xzL2dvIHwgXA0KPiA+
IC0gZ2l0IGFtIC0tc2lnbm9mZiAtcDQgLS1kaXJlY3Rvcnk9cmVjaXBlcy1kZXZ0b29scy9nbw0K
PiA+IC0NCj4gPiAtTWFpbnRhaW5lcnM6DQo+ID4gLUpvc2UgUXVhcmVzbWEgPGpvc2UucXVhcmVz
bWFAZm91bmRyaWVzLmlvPg0KPiA+IC1QZXRlciBNYXJrbyA8cGV0ZXIubWFya29Ac2llbWVucy5j
b20+DQo+ID4gZGlmZiAtLWdpdCBhL1JFQURNRS5tZCBiL1JFQURNRS5tZA0KPiA+IG5ldyBmaWxl
IG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMC4uZTMxNmZjNg0KPiA+IC0tLSAvZGV2L251
bGwNCj4gPiArKysgYi9SRUFETUUubWQNCj4gPiBAQCAtMCwwICsxLDQzIEBADQo+ID4gK21ldGEt
bWl4aW5zLWx0cyAtIHNjYXJ0aGdhcC9nbw0KPiA+ICs9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0NCj4gPiArDQo+ID4gKyJNaXhpbiIgbGF5ZXIgZm9yIGFkZGluZyBsYXRlc3QgR28gdG9v
bGNoYWluIHZlcnNpb25zIGludG8gdGhlIFlvY3RvIFByb2plY3QNCj4gTFRTLg0KPiA+ICsNCj4g
PiArQXQgdGhlIHRpbWUgS2lya3N0b25lIHdhcyByZWxlYXNlZCBpbiBBcHJpbCAyMDI0LCBHbyAx
LjIyIHdhcyB0aGUgbGF0ZXN0IHZlcnNpb24NCj4gPiArYW5kIG9mZmljaWFsbHkgS2lya3N0b25l
IHN1cHBvcnRzIG9ubHkgdGhhdC4gVGhpcyB0aGluIHNwZWNpYWwtcHVycG9zZSBtaXhpbg0KPiA+
ICtsYXllciBpcyBtZWFudCB0byBhZGRyZXNzIHRoaXMgaXNzdWUgYnkgYmFja3BvcnRpbmcgR28g
cmVjaXBlcyBmcm9tIHRoZSBtYXN0ZXINCj4gPiArYnJhbmNoIG9mIG9wZW5lbWJlZGRlZC1jb3Jl
Lg0KPiANCj4gVGhlIGFib3ZlIHBhcmFncmFwaCByZWZlcnMgdG8gS2lya3N0b25lIGluc3RlYWQg
b2YgU2NhcnRoZ2FwDQo+IA0KDQpOb3Qgc3VyZSBob3cgdGhpcyBoYXBwZW5lZC4NCkkgcmVtZW1i
ZXIgZGlnZ2luZyBvdXQgbmV3IHZlcnNpb25zIGFuZCBkYXRlcy4uLg0KDQpUaGFua3MgZm9yIG5v
dGljaW5nLCB3aWxsIGJlIGZpeGVkIHdoZW4gSSBzZW5kIHRoZSBuZXh0IGRyYWZ0IG9yIGZpbmFs
IHByb3Bvc2FsLg0KDQo+ID4gKw0KPiA+ICtEZXBlbmRlbmNpZXMNCj4gPiArLS0tLS0tLS0tLS0t
DQo+ID4gKw0KPiA+ICtUaGlzIGxheWVyIGRlcGVuZHMgb246DQo+ID4gKw0KPiA+ICstIFVSSTog
Z2l0Oi8vZ2l0aHViLmNvbS9vcGVuZW1iZWRkZWQvb3BlbmVtYmVkZGVkLWNvcmUuZ2l0DQo+ID4g
KyAgbGF5ZXJzOiBtZXRhDQo+ID4gKyAgYnJhbmNoOiBzY2FydGhnYXANCj4gPiArDQo+ID4gK0Nv
bnRyaWJ1dGluZw0KPiA+ICstLS0tLS0tLS0tLS0NCj4gPiArDQo+ID4gK1RoZSBwYXRjaGVzIGNh
biBiZSBiYWNrcG9ydGVkIGZyb20gb3BlbmVtYmVkZGVkLWNvcmUgd2l0aDoNCj4gPiArDQo+ID4g
KyBnaXQgLUMgLi4vb3BlbmVtYmVkZGVkLWNvcmUgZm9ybWF0LXBhdGNoIC0tc3Rkb3V0IC0xIG9y
aWdpbi9tYXN0ZXINCj4gbWV0YS9yZWNpcGVzLWRldnRvb2xzL2dvIHwgXA0KPiA+ICsgZ2l0IGFt
IC0tc2lnbm9mZiAtcDQgLS1kaXJlY3Rvcnk9cmVjaXBlcy1kZXZ0b29scy9nbw0KPiA+ICsNCj4g
PiArVGhlIHlvY3RvLXBhdGNoZXMgbWFpbGluZ2xpc3QgKHlvY3RvLXBhdGNoZXNAbGlzdHMueW9j
dG9wcm9qZWN0Lm9yZykgaXMgdXNlZA0KPiA+ICtmb3IgcXVlc3Rpb25zLCBjb21tZW50cyBhbmQg
cGF0Y2ggcmV2aWV3LiBJdCBpcyBzdWJzY3JpYmVyIG9ubHksIHNvIHBsZWFzZQ0KPiA+ICtyZWdp
c3RlciBiZWZvcmUgcG9zdGluZy4NCj4gPiArDQo+ID4gK1NlbmQgcHVsbCByZXF1ZXN0cyB0byB5
b2N0by1wYXRjaGVzQGxpc3RzLnlvY3RvcHJvamVjdC5vcmcgd2l0aA0KPiA+ICsnW21ldGEtbHRz
LW1peGluc11bc2NhcnRoZ2FwL3J1c3RdJyBpbiB0aGUgc3ViamVjdC4NCj4gDQo+IHJ1c3QgLT4g
Z28NCj4gDQo+ID4gKw0KPiA+ICtXaGVuIHNlbmRpbmcgc2luZ2xlIHBhdGNoZXMsIHBsZWFzZSB1
c2Ugc29tZXRoaW5nIGxpa2U6DQo+ID4gK2dpdCBzZW5kLWVtYWlsIC1NIC0xIC0tdG89eW9jdG8t
cGF0Y2hlc0BsaXN0cy55b2N0b3Byb2plY3Qub3JnIC0tc3ViamVjdC0NCj4gcHJlZml4PSdtZXRh
LWx0cy1taXhpbnNdW3NjYXJ0aGdhcC9nb11bUEFUQ0gnDQo+ID4gKw0KPiA+ICtNYWludGVuYW5j
ZQ0KPiA+ICstLS0tLS0tLS0tLQ0KPiA+ICsNCj4gPiArTGF5ZXIgbWFpbnRhaW5lcnM6DQo+ID4g
KyogSm9zZSBRdWFyZXNtYSA8am9zZS5xdWFyZXNtYUBmb3VuZHJpZXMuaW8+DQo+ID4gKyogUGV0
ZXIgTWFya28gPHBldGVyLm1hcmtvQHNpZW1lbnMuY29tPg0KPiA+DQo+ID4NCj4gPiAtPS09LT0t
PS09LT0tPS09LT0tPS09LQ0KPiA+IExpbmtzOiBZb3UgcmVjZWl2ZSBhbGwgbWVzc2FnZXMgc2Vu
dCB0byB0aGlzIGdyb3VwLg0KPiA+IFZpZXcvUmVwbHkgT25saW5lICgjMjUzOSk6IGh0dHBzOi8v
bGlzdHMueW9jdG9wcm9qZWN0Lm9yZy9nL3lvY3RvLQ0KPiBwYXRjaGVzL21lc3NhZ2UvMjUzOQ0K
PiA+IE11dGUgVGhpcyBUb3BpYzogaHR0cHM6Ly9saXN0cy55b2N0b3Byb2plY3Qub3JnL210LzEx
NjI3MzQyNi82MDg0NDQ1DQo+ID4gR3JvdXAgT3duZXI6IHlvY3RvLXBhdGNoZXMrb3duZXJAbGlz
dHMueW9jdG9wcm9qZWN0Lm9yZw0KPiA+IFVuc3Vic2NyaWJlOiBodHRwczovL2xpc3RzLnlvY3Rv
cHJvamVjdC5vcmcvZy95b2N0by0NCj4gcGF0Y2hlcy9sZWF2ZS8xNDAzODMwMi82MDg0NDQ1LzEz
NDQ2MDA1MjYveHl6enkgW3NrYW5kaWdyYXVuQGdtYWlsLmNvbV0NCj4gPiAtPS09LT0tPS09LT0t
PS09LT0tPS09LQ0KPiA+DQo+ID4NCg0K

