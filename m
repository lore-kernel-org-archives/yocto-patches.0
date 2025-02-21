Return-Path: <wangmy@fujitsu.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46FDC021AA
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 03:26:30 +0000 (UTC)
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
 by mx.groups.io with SMTP id smtpd.web11.15389.1740108383393653700
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Feb 2025 19:26:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fujitsu.com header.s=fj1 header.b=inub9pAy;
 spf=neutral (domain: fujitsu.com, ip: 68.232.159.76, mailfrom: wangmy@fujitsu.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1740108383; x=1771644383;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=HGIDDXYBVW8miv97miZl+VpOjf8V7w8jlLjWroAOoOU=;
  b=inub9pAy/XxYlTSahR+zGHg26y6HZ66cw6jBau4728XMaH5ckMtPSPsf
   wXfgvD6FMDrWeGS0jVlPPfFraehfPDzVHHhtydMIwTUd/IObSIikHzlcC
   5hnAovEMdC9zziTdFvVinrXEienTf/zu7qSqOn5cTtdsrxKuDCeUnWrI9
   gKSSAyRVKRgwO62FKI+q8MawOOnXPJ+I6gPvfcPbQwsbSZxlNln7AOttr
   Eusu3VByE9cQ3hTPWfjGYXH05RB9Kfdm4dDR23lxSvgDTS+HqBQ6KfqDM
   J3mEaOSLU6uupDiq/539u/aXajvRhJzHABQ1EPFGyOKa/5GJa2un6Hmah
   A==;
X-CSE-ConnectionGUID: VT35zMVTSvq/nSFqXra+Uw==
X-CSE-MsgGUID: xb/2D08KRBKQukNOXUk0Vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="147603476"
X-IronPort-AV: E=Sophos;i="6.13,303,1732546800"; 
   d="scan'208";a="147603476"
Received: from mail-japanwestazlp17011031.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.31])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 12:26:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FumKhDIJBJAR6HNitzok+s/J0Zvt1iR+kg3j2Ils55Op+DxAtHs6GK0bvL0pAE2Iyo5hiGh/h3qvZaCKBkIkXEO0Ve7DXGGqVBKR4/Ip04b3NmA6fpzHRG+qb9uxbhr2RBpPpboCYZ0lYdbYqRkbQm8EsagH+66IR0G/DckC5Ua+XrnwrpINqqGG4XsQH7K1rKg/aSOO8XC8hyC2DkmaqNcX8jXNYSevWGjrKQuoznr3aVhsGHwb8q3CeQOhYBn9ep44FKSm9LhxtUvG+TBfuoZUZby1wzAoMwexCn9yAiHt8sr9vNoNY7IoyM0KszyFMerrnwtlgTTIYI48PKqvgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGIDDXYBVW8miv97miZl+VpOjf8V7w8jlLjWroAOoOU=;
 b=al5zKQZZjvVKyUvgcSVL0utEJZFQ1Xlk2APZ3Wrq+z2FDfiImzIDnjLPghmhHo8iNfXNv7vX2Mg5x94RJwyz14MQehB5E26LJxSGOFwhJ3JtavCNWROVUvjFhQnYXyhkGEW0XRbTjaEAnUyGN95dC5LlOIKIPHZCqfpmDZ2XYi+8TU4uNfv8GLnOtiSPJ4yBtvjDMWO15xY4gCBZr6dzw6qxF7ggkByFXa98i47Z1hkjjhCvQXkZbUAVOPexj06EhfG80XOdOequ0y4KgfSqMG+V4SdQj4iYgQoJrQwJMBVskRuXN9+tF3/CfYwuTzzo/7gR37o8koa4jS5HvP+PFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB11861.jpnprd01.prod.outlook.com
 (2603:1096:400:3fb::13) by TYCPR01MB11787.jpnprd01.prod.outlook.com
 (2603:1096:400:38c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 03:26:12 +0000
Received: from TYWPR01MB11861.jpnprd01.prod.outlook.com
 ([fe80::e0dd:28e5:6a6e:2342]) by TYWPR01MB11861.jpnprd01.prod.outlook.com
 ([fe80::e0dd:28e5:6a6e:2342%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 03:26:12 +0000
From: "Mingyu Wang (Fujitsu)" <wangmy@fujitsu.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: [yocto-patches] [meta-java] QA Issue: Missing Upstream-Status in
 patch
Thread-Topic: [yocto-patches] [meta-java] QA Issue: Missing Upstream-Status in
 patch
Thread-Index: AduEDy+sEghkbMChQESqJcifNyWPJg==
Date: Fri, 21 Feb 2025 03:26:12 +0000
Message-ID: 
 <TYWPR01MB1186118665B16406BD0571151DCC72@TYWPR01MB11861.jpnprd01.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=ccdd8b98-8251-4666-af10-a1a5d7844089;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2025-02-21T03:17:55Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11861:EE_|TYCPR01MB11787:EE_
x-ms-office365-filtering-correlation-id: 6cd92588-af8c-4d6a-0895-08dd52277db1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|27032699015|1580799027;
x-microsoft-antispam-message-info: 
 =?gb2312?B?bVZyUW5FNmVEVERtaWtCaWVmQlVzV0tsbC9yclBMVDdEbFVyTjBYWlphNGlB?=
 =?gb2312?B?SUhIWC90a1ZLUHJ4d25QN1FqYXFpSlhGVWZRamQxY1FLdVZWWkJtZ01hZEQ1?=
 =?gb2312?B?c3NMMGxXWFJHc0FOVW9JNVcvS3ZzNHRoSFZQMFc2NXN0dDQ5NnJwTjg4VDNt?=
 =?gb2312?B?L2tLS0pYdXZaVU9YZHVLUXVOWjV0bFZpejBVVE1QVXpvU3l0YURqYlNacnpK?=
 =?gb2312?B?aWh5eFdHY2MzT1JUZmZNOVpnc1R6dmZGbWhiaktzSGdWc0lPOGswdkR0L0l2?=
 =?gb2312?B?Slk2VnJvb1VtU0tFcEtKeWViRUI0OUtka2ZCQkljR1BwWGVEYmszOURaTmU5?=
 =?gb2312?B?aDVUOXorOEJQMVgvZDdSRHBHd0pzWWRIOThlV2lRRWl1L29kOC9BVHlrN0ds?=
 =?gb2312?B?ZEVEWDh3a3NlamxoeVpEQWtod2p1VE9Fa3pycDNMdHJnL1pRZWZpWXZINng3?=
 =?gb2312?B?NEU2VkpWczlHaTl6WXoraFFOS0tNcWlpVHd2aVhsTUZwYjRZVTVFV0ZWN3F3?=
 =?gb2312?B?MVlKazVIQUE0bDIycnM5VC82aXlHT2dOSlpCQjZydm8rTFA5S3ppMzJmcXNW?=
 =?gb2312?B?WjJwSmVLRlFycUZkVjJPb2pNdkMxZVFrWmlkQ29wT2FYK2hHVXdiZWJZd0h3?=
 =?gb2312?B?WW9aSTlJd2VJb3BQVWM2WHV0eVZlTGJMSkdpa0ZoV3FhOWZhWjlFMngzQlBr?=
 =?gb2312?B?NFhYSzA2M04yaXZKU1FUa09wMVhpK2dCMno1UGVpSjBrMytCTm11VXFlM05r?=
 =?gb2312?B?ZWdWSmxKZ0J2SnZTOVhGVnkxZElocEhNUFZuTEEyQ2IwdXVDdUQ4M2ZTeFZj?=
 =?gb2312?B?c3RSdVgrRFN5bmM2MFRxejVmYjJIZldpU0tuUy93NGM5N2oxQzlFQTY3cnZs?=
 =?gb2312?B?Q0toWmJHQi9FYUU2cCtFWU9HZndUdTNFQ2tYVXRtS1FkWW5qckhiQjk5NzZR?=
 =?gb2312?B?UWtYMzdzdmJ0Vm1vMVNBdkZ4NmFoWlBRcHlyK1hpbTVUanArSjR2bm1mc2dx?=
 =?gb2312?B?UllUVHFxdnEzWG9rNGR3SE5zbHF5c0hSSyt5cGFQTVczL2tUZE5OWEZYV0cv?=
 =?gb2312?B?YVNNUkdXb0xDL1lFcXlGdGdRb2FvS210elVTelB2VWhMRGwrOUtxdGo5am5X?=
 =?gb2312?B?WU0yUWpQTEdMUVB4YkZsZEZnVUhKdHp6RzFWVFZ2WU16RFJCYjVobE51eVhK?=
 =?gb2312?B?dlo5TkJjbDVycExRanVFZXg4SEQ2UzZFYWRJSTRaZDE1cU91YWhiUmx6cExY?=
 =?gb2312?B?TURyQXZKMTl2RlR6Nk0rMitUUWpwVHVQc3NwZGVWb0NjbS9hK3FzcW5FVXRT?=
 =?gb2312?B?VzN0aktqVWNkTVNEeWRLa1htNG9mQjNtN0xZd0gwbWQ3eXljd25Tb25BY09L?=
 =?gb2312?B?aWFONHFBL3NtVitsaCtBa0s2Z0R4L2p6NUkxZng2RTJrbGFoT0ZKQVBCVmtE?=
 =?gb2312?B?a3htVlZOR1B1T3ltU1dOQzRFd04wODdFTWRFZnQyckw0eCtFellGVTU5VTBz?=
 =?gb2312?B?VTNaaENhWEFhOGUwT1krN1dwZjRueEdOM2RZMjlZS1EvZzZrU2xCeTlQL0NP?=
 =?gb2312?B?WGdsKzViVzNRdU1tV2Rxb29KSUNYZmI2MzJheWJHRkpacEJWSTFtTmhJTVMw?=
 =?gb2312?B?c0ZLU0kxMVAvRWNLZHRwRzN5Rm9qd3NqYzNNL0x0eWUwY3A4L09nNzU3N0hY?=
 =?gb2312?B?TmpleGVKaG9hUmlDbUZTeXQwdmNyaTZrNWRWdlpLaDAxOFRlMGltY1dQa2Ji?=
 =?gb2312?B?U3poT1VwK3krWXRMaGpobndHcTFnRjdRbUVveVA5dXVNWEt3VU1nU2RsUENn?=
 =?gb2312?B?RUtlUDZKL29uZUxsSHhQalZ1UW5UZEEwSXdwcStlN0UwWUJBbW5EWWJyMEdY?=
 =?gb2312?B?aGFrVEM3M1NVbVZEbG9hemkzRE5RblB1TnRyZE1UdklieXVXRnNjR0FWckIx?=
 =?gb2312?B?OXk5TlBpaWVraXBGY2plWWQwVzRveHZ5ODlJclhIY2R6Z3dUWW9BOVgzdnEz?=
 =?gb2312?Q?5Cr3nG+H1aSyz9bFC3WhxTeomM2aOo=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11861.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(27032699015)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?gb2312?B?MnBRSFBxN05xdmRmWTd1UGlsS3hYZ1Ztajg0OEJEL1hURFJzN2JiM0IzNVVD?=
 =?gb2312?B?NkVDNkJHRUNZUDZqalJRZ0ozbmdJbHJhcVFGVVZEbG5Ta1Y0NlB2bWp2QzN4?=
 =?gb2312?B?amZNVHBKNWQ3bWlpZUpJVnRGMXppbWdIN0dWY1VUN3dJKy9Yb2Z2ZlAyVjQv?=
 =?gb2312?B?ejRSUlVTZ0pVVjF3Q3NxL1FldlFaR3pkSnVJaHRDWGpmalFDVVVFRmw5dS91?=
 =?gb2312?B?NFNwQ3dsQ3F2ei90QitrRlJRWVY5R3BqOWE3T2xFS0ZUVXRia0kyanRNc0ly?=
 =?gb2312?B?UWVva0Y3eUUvS0E1M2pKa04xM1AxSkhHYmdqTHRBSno3VFdxbVp6V2Vmelh2?=
 =?gb2312?B?cW5QcjJVcXRsaFIrdlB2akVFOUJvTm9LU01FZWdjZXU3SVVJei9TakU4bExJ?=
 =?gb2312?B?SndtQVpzM0JXU3hjd256L3QvYndiZ2VQWGMwRG5QZlRLbWJXUktiRytBS0FE?=
 =?gb2312?B?aFVsT2R2dTZxcGVvc3JqSEdkT21LYStxNS9QaEd4OEhNaHhacWY0a0pYaklF?=
 =?gb2312?B?dHZEbmVQSHdoS21UenppQ0c2Si9ldUlMMkorbGwreVRXeWdFcXB1K1ArcXJt?=
 =?gb2312?B?NmRmeHVHVytTVXA3QWowQlpsNDA2Unc3ZnNxYm9BS1RrcTdTRnFieHFrRUdZ?=
 =?gb2312?B?QmZ4akVlOGhIU0gzY2lnWlNheFgvc0dIYW1RRjBxWUYyVEZQRTlZaG5rQVFm?=
 =?gb2312?B?L3RkTzJ1NkVoRU95UGFyVmZRa0h2WGRaWFowTUtqbUtzQWdrNEZsbnhrQmhC?=
 =?gb2312?B?Z1VnK0taQ1hGaDQwMnozT0FMVjRpREluWkpvZWk0bDE4b0xiSzZMTUhkVkRG?=
 =?gb2312?B?NDFxemIwbWV3dlg3TzE5UGNnVERkRmFCZ1VrRkpaSWtjTXIrSWp6d2pBa3pF?=
 =?gb2312?B?TmxHLzdvT3dKeW90SlU4WlF0VmpqZEFjd1VRRlpGZmk3T28zWUNxdXBGWjJU?=
 =?gb2312?B?RExINnZPOG5VRk13cCtGOHJYV0w1aUZ2M04vbU1pYUdNa0xjRFMxcmUySkRX?=
 =?gb2312?B?cHZJbmlDRjgrdTVQbE5CZnVCT3ExREwyalRRdVhsVHBiVkVLdmcwNVJUN0k3?=
 =?gb2312?B?NkxiRHBIaWFkSEJrdWVLY3dLTXJsSW52eWcveVVBcWtQSE9PNDRpaUxhYmJ5?=
 =?gb2312?B?S0V3ancxYXpxV0pzT3ZqRGFrWkhnWUl1bHg3MWtacWxXWGZXZXBWK0ZmZHV4?=
 =?gb2312?B?bU8zd2NnWXRuMUtMQ21US2cyM09vOVFqUUg3d1dFQXBNTWpDTnEycDh0OS81?=
 =?gb2312?B?R0RIZ29rbDhWWm9aVWZTai8wb21IZ1pRdUhvSGpvVDNvZ25QVlZNZUVyb1RE?=
 =?gb2312?B?VVdqSG1iM3lOYWtMOTdZME9RVTFHVGxYSDB6S0plc2RGVC9ydWdtakVxWFl0?=
 =?gb2312?B?RXNmTVdqendrb3FXY29mSWJFeWFYQ3Y0L2lDQ0t1R1NjUXhCcjNta1VYajZq?=
 =?gb2312?B?S2tUanVWN1FnVkZnclJnTCtzdVJkQnMrNXJ3UXJrSlM0R0xSNm9LSVoxWGlp?=
 =?gb2312?B?ci9jTURqdStsMGx4OTJYWU1HVHNFQjQ5cmpCcXI2NnpaQjdxanFYU056eEV3?=
 =?gb2312?B?OTREaTgrbUQ4ZEpyRVNjcjhMbHZyUTBudzlRQU5mRVM3RmR6bXcwL3Q0VWNH?=
 =?gb2312?B?Qy9QRVhxZ3RzVUtSNC9Mblk5aHRhTVJGZFdqMEF1K3lWSTdBNEtOVFRmQzdH?=
 =?gb2312?B?Y3lEaXhWTHNkUDRSeE1pZStrbnVzK0prUUJ1V0NrMGVVa3BPNDY1Ykg1MUs5?=
 =?gb2312?B?aW5KWVJSdm9TTGYvOW1yYWJYanNWTEthOHBpdFdjTWtFK1QyNHNkQksxWkNa?=
 =?gb2312?B?ZU9WQVFvdmZMQjlCM2xrTlJ2RTNMeWg3OC9xb0htQi9MbWhMaGluWE5MRERk?=
 =?gb2312?B?MFBwQ0puWUMvTlBONXltMTJNT1NuMVFEUzgweFVlWDVBNzUvaUxsY3YyMGRE?=
 =?gb2312?B?UnpjTjIzQXpJSUJxT21oZkRRelVOUS9BckRXcUdUVVFYS0ozcFVpVmVWVURm?=
 =?gb2312?B?RFdwNzF3NjFDbHFLK2ZzSUpHYVZ6cS9jNUdSZHRRZ2tOZHZnbDhsTTc5N3E2?=
 =?gb2312?B?V2dKaEZqdHowSmw0ZFEvS2s2RG9wVUoyY1NBcGZzTlpKQkVYZ0JEVG9veGVP?=
 =?gb2312?Q?bNMAsovfcTQHRgciqlk8avcc3?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	s2b2L2lE9uJTazDXWMdpLo7agTatJXBOhQ2eFM7PU2GER/cVIiFWkLED/zgfor/fxezemHVz+5vHE3YqGSAU4/pkDjI8RTlByEaI4yoWXoTQreiOK7KM2tWEeB7ckE/ZdFYVsuXff8Xh62h8My2DBbY0FQ57AI2gAh5k1ORrfoyXBO4ToRhsQuSaPunItkk2F/xNLsgoUJoXSUO57nsYxmCSka80Gzxu+8tUmDKp/pl+6Qy0LWwB3gLj2fvirqcwiAuuHZ8/IWASHw4KGP5onsYRFor9Sw6XEHHeWzV02IrPtQMFmkCgNlYEMQNsbUV1kmTZ6u8+5/LezK1R9xuaMV9fyGa3lZdCuJrjG8HCfgy4nbItDGENYgMqJPtYo70k9u29woVfxOyg6+H8+o1fK0QvI43H0pbt5v4VVJSUhSNsbb5j5UUWab9BPiByRBXwXf/rT3DqZfbaz+nCN0MInhBswRtN7CacAtWKx5wp+E37QpTA24jHqAaNwe2edh7LVvAvw+fENjn1mdcJIJ1N4/Ejl5xeg93+eI+8/UDSuBeTrf2WW5M5yDpeqk7snC+Iyiv1MjhFrVUC1NfOigYor6++ztfsneXtfAOIouw72dejA/8VeBVqD2z7twfar0xz
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11861.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd92588-af8c-4d6a-0895-08dd52277db1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 03:26:12.2232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oi0WQJ0SIrukQAA46NUx+mv6ropZ8IPb726L5MFEgRmziqZ8pXhATuEj/+liHE725BffAYCMj2RfnYsSzTnHwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11787
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Feb 2025 03:26:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1108

VGhlcmUncmUgbWFueSBwYXRjaGVzIHRoYXQgaGF2ZSB0aGUgZm9sbG93aW5nIGVycm9yIHdoZW4g
YnVpbGQgdGhlbToNCmRvX3BhdGNoOiBRQSBJc3N1ZTogTWlzc2luZyBVcHN0cmVhbS1TdGF0dXMg
aW4gcGF0Y2gNCg0KU2hvdWxkIEkgZml4IHRoZW0gYnkgYWRkaW5nICJVcHN0cmVtLVN0YXR1cyIg
dG8gdGhlIHBhdGNoIGZpbGUsIA0Kb3IgYWRkICIgRVJST1JfUUE6cmVtb3ZlID0gInBhdGNoLXN0
YXR1cyIgIiB0byBjb25mL2xheWVyLmNvbmYgdG8gaWdub3JlIHRoZSBlcnJvci4NCg0KDQogIC0t
DQpCZXN0IFJlZ2FyZHMNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KV2FuZyBNaW5neXUNCkZVSklUU1UgTkFOSklORyBTT0ZUV0FSRSBURUNITk9M
T0dZIENPLiwgTFRELiAoRk5TVCkNCk5vLjYgV2Vuemh1IFJvYWQsIE5hbmppbmcsIDIxMDAxMiwg
Q2hpbmENClRFTKO6Kzg2KzI1LTg2NjMwNTY2LS04NTY4DQpDT0lOUzogNzk5ODg1NDgNCkZBWDog
Kzg2KzI1LTgzMzE3Njg1DQpNQUlMOiB3YW5nbXlAZnVqaXRzdS5jb20NCg0K

