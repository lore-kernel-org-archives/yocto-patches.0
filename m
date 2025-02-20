Return-Path: <douglas.royds@taitcommunications.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465B7C021AD
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 05:53:00 +0000 (UTC)
Received: from SY5PR01CU010.outbound.protection.outlook.com (SY5PR01CU010.outbound.protection.outlook.com [40.107.40.102])
 by mx.groups.io with SMTP id smtpd.web10.43373.1740030768454503892
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Feb 2025 21:52:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@taitcommunications.com header.s=selector1 header.b=s3++WGwd;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: taitcommunications.com, ip: 40.107.40.102, mailfrom: douglas.royds@taitcommunications.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSTJwHmnt0qLGA6K7G+FbW/5NsRpaKjLLl78UovvwL2hPI3tLEIYUi24McRIAmV6eD5uaEnH6c4GsINcojAAaUbiv+ChgrRh9j8AULCQwANM/az0bwAPozPV/g/BDQt/RhTQ3fNNcxxARWM2ABTembCHuXzKG67hiaDt0x/a8vjLEgkHPWqkfplz3JWrvKBc9yAsi8EzJxtnLaxs22aqYW3sFgu1XDHsT/vi0Ko1yLPr5/Dxt7fXlTOPg4rCoFEzOgrzFRfLPbgV8ZBgVgsf3njVM9WmYGvjBudBX1bH4iqhZQ3Dw0kXCKxk+bMVb7FFl664Nda3E25LpuSdkOh4wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bls+6OdJ4cD18t+lfcOoB7Ggwr6R202cYeglisKlgCA=;
 b=TfJc+PPW3KUQdc+U8SRQ1w8aQG6HcLHw1wx6YXcu+of8uDRrvSRv0M17CdOGP4UqPXkI3Q7jnOeHuTEBrSZrv0fRrH7hchQX9MLZiTL8K7ufhkMR3+PVFW76U4Ak0rHRUUHt3izOMkrUZxb0rBgHoQzeMx4QOivz3sapUy0ohdeUBPPzGp8+Gp5OkZJhXW83+x9fyf0bqSTMmLmLj2wfNicYxdCunDdccBMM+2cfjn8s6NeZ+1+HN9I35KSKYkZh+UBenj9P9mqnvqVR++BWPVWsBOdhYIWGKmLVbaDhmzBLvYqgWIjtlJXt1FabJLu+5v/3tVvITf73onu9vV9qGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=taitcommunications.com; dmarc=pass action=none
 header.from=taitcommunications.com; dkim=pass
 header.d=taitcommunications.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=taitcommunications.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bls+6OdJ4cD18t+lfcOoB7Ggwr6R202cYeglisKlgCA=;
 b=s3++WGwdykmmjCPkeYXsRK/NL+VFT+CEvE+9MTxWY7pNsf8UCxj6Rw/xlUouUMD21eo2n+7gUTNiI5NEi89Me6lf/cJkCzJAWqxDqEWB75QQ6uquyHpBigz+SpbcDYl4dd1fbQEPtgFhmqmDj1fz2XQYzpBc6SFyxqSD1lX02HDOUEPvAx/Y1iNHHSIhofvQWFXa+VJBSM9Ys7H0XpC1SgFHWO0ud8ZIyuhARkFyZhkAO9derV8t6mIdd361eV8ofInFO2XuWIX5mfNz0nncRQYqjOgGsV2UkUdzpQbhvCiEwqmUgJoMdXsxgPQeY1MdeuV2cXCCdu7y++auE563KA==
Received: from ME3P282MB2531.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:10c::10)
 by SY2PPF975AE31C9.AUSP282.PROD.OUTLOOK.COM (2603:10c6:18::225) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 05:52:41 +0000
Received: from ME3P282MB2531.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4854:ef86:5be5:d20b]) by ME3P282MB2531.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4854:ef86:5be5:d20b%7]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 05:52:40 +0000
From: Douglas Royds <douglas.royds@taitcommunications.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: Re: [yocto-patches] [meta-java] Issue of cacao
Thread-Topic: [yocto-patches] [meta-java] Issue of cacao
Thread-Index: AduCZ6VoCCyyKLONQkmHYtLFdNLtLwABSX1VADIzU8AACRH9sA==
Date: Thu, 20 Feb 2025 05:52:40 +0000
Message-ID: 
 <ME3P282MB2531BAD8FDFF2BB517D4A73994C42@ME3P282MB2531.AUSP282.PROD.OUTLOOK.COM>
References: 
 <TYWPR01MB118615E9B023329FEAEB33BB4DCC52@TYWPR01MB11861.jpnprd01.prod.outlook.com>
 <ME3P282MB2531E2579509BA59013A585E94C52@ME3P282MB2531.AUSP282.PROD.OUTLOOK.COM>
 <TYCPR01MB11866300AB8ED4CC1ABF35A33DCC42@TYCPR01MB11866.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYCPR01MB11866300AB8ED4CC1ABF35A33DCC42@TYCPR01MB11866.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=taitcommunications.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME3P282MB2531:EE_|SY2PPF975AE31C9:EE_
x-ms-office365-filtering-correlation-id: 2bd3f6b9-5fc6-45ae-8598-08dd5172c988
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|4022899009|1800799024|38070700018|7053199007|8096899003;
x-microsoft-antispam-message-info: 
 =?gb2312?B?YktTa1lXOU4xL2hwbnpRM3dEby8xYjJRT0xMZk5SaXNobCtxcUFodUV1VHhy?=
 =?gb2312?B?RGNGUU13N0J0R2ROVTRVOGF4bmFCMmY1VmFibm5wdXA2WndCZCs0RU5qZldl?=
 =?gb2312?B?dC9WOGN1ZE8xUVhOaHBKdUhTNjZ4OWJnSktudkhYQ3JNUUNuTFhySGkxdVpR?=
 =?gb2312?B?MldTNkUzWDNqZi9ZSWFVZ3hKRjJyVTRqUlhMd2J4VmplRGxzbVdFUVdGSVhr?=
 =?gb2312?B?eEk3dXFLcnA3TWx0VEU0aXB4KzdZbTJFbWVwckNJQWZTZTVBMVR4elJmaFJl?=
 =?gb2312?B?cFVWc2tQdVo0eFJBWXYvSnJYdktBVG5VdWplRERyNFBpQzU2WE52dTBpVG9T?=
 =?gb2312?B?Y1lMbnJrOHY0T0tzN2I2VUI5ZXJ3eFZEUGFlTmt4ekpqZTEvZi9WZDArK0t0?=
 =?gb2312?B?SjJVcjhrOWhHOE5Bc3R2QUpZeTRRWGR1Vk9vWDBRZWpZV2ZOaWhMMHJCQmlR?=
 =?gb2312?B?NEVEWHB3THQ4a2V5V1RKL1huNGxpYTloay96SGpiUXFkcmpPTFJwQjVjZEth?=
 =?gb2312?B?N21RTkgyajBSRkVUOWtqSmFFK2t2QU12VmpvaGszUkxOSGF6RklIVStKUGd3?=
 =?gb2312?B?aGsraU85WEh5ejlXM1hVL2xibUtqWTNLVURVWk5WNW9DVWJPRGJaRTlvN2Zz?=
 =?gb2312?B?NmdPaXVYUnY4WUtrc1p2SjFXYS9rdjJQbldGV2ZpMXpORGxnK01CZWRTTmxv?=
 =?gb2312?B?ZmJ5WG1wS1NZbC9xZlk0RE9SaUpxaDd6UzIvM1NSd0JvQTBTdTdrVWtzSi9y?=
 =?gb2312?B?aUQ2ZksrRWVySENReHgyZ1M5T3krZUlpUHlvMXdZY0w2V2N3Y3pFUWdTSGlr?=
 =?gb2312?B?eHFLUGJ3ZGdiYklpOERNZE9pRDlNcFcrZnRZSmJnSGpRLy9RRmhyS1lhV3lp?=
 =?gb2312?B?Y2lodUt2T3QyNDdReHdBaFpKOW5oVFQveWtqOU11MUxvazF6RU5TdlZObCs0?=
 =?gb2312?B?TC9ER0tvMUMyQlhiZFhrRWUxTmtKaXlaS09jV3Y1Sy9IZkxxZHVuWHVjalQy?=
 =?gb2312?B?MmFmZEx2Z09zTEhXN1RaQURuVDN0c3BTL0UxY3liN0szZTNPTGtMT0NBUU1s?=
 =?gb2312?B?K2NSaklaVW1oeFlsQUJZS20yd3Z4QUxNcEtGWFJBaGpFQVB3cHBqSUNLYkI4?=
 =?gb2312?B?THJaaWpOc0VWSGowVjFFdlV4ZDc3cVFPYTZvNGU4MGk4SEVWbjZpbTJCWVZ6?=
 =?gb2312?B?UWhGOWFBc2tpK0lCc0I0TFkrQ1NnQTAyb0FJMmcvL3JzVk4xNGtDVXlha24z?=
 =?gb2312?B?SG1tMzRXRVlHc2xaZTV2ak1NdUsxNXltVkE1dlk2OWgya3BLSURHM21uZmFm?=
 =?gb2312?B?YWNMakdnNXhvemJ2ODU0S2lwb1E5bFNicGhRSmdUNFdIakluNlkxZUlDcThx?=
 =?gb2312?B?SW1GejdqNktiOW9IL3gyOFJWMytKY2MrY3Q5WHZQMTk0STRLaDR6Vlp1aVlP?=
 =?gb2312?B?OUM4L3BxMHNvYndqU0IwQUdDMmhiWUZpRGZhbmpseEtPRUJjelg0czhCSHJS?=
 =?gb2312?B?NnRjTTM1ZzZJV1ZuVmppQTBwdEd3Q1UzdFhCVllSdlVOVjh2TWxCVkVBQ3BZ?=
 =?gb2312?B?ZzR5SGJ4ZENxaS93S1BQajBuSCtlZzhHdlM5dm9yUUlOYmFHREVlUTVEVkp3?=
 =?gb2312?B?d2xGNWlNS1J6dW5PTjE4dU9jSnhobkpnRWRRRlh5U0Mxakc5di9HK0haR3Y1?=
 =?gb2312?B?WXBZVEthOWZkbHlreWxMVTUyWWo4cDRUbWluNjdtSW1wSkZIK041WDhHazFJ?=
 =?gb2312?B?STFaNkZ4Wk9JQ0h6T2hpb2V5YUxQT252SFZLQUFKSFRlUStjdDA3eC9pUzdn?=
 =?gb2312?B?MVhYV1JzQ3B3MmpneGRYV1pGYkhIQWtMc285Snc4NndNTEtCcU9Nc3h3Wlhv?=
 =?gb2312?Q?193O02am+5Dn1?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME3P282MB2531.AUSP282.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(4022899009)(1800799024)(38070700018)(7053199007)(8096899003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?gb2312?B?ajBEbUxReVdpVlNBOFI2L1paNjVza0tlS2ZOWGZrZEh4MU5vSEJGbFk5dVZL?=
 =?gb2312?B?UTc5dklvTldIaGtPMFp3Z3Bpd0FUQXB6L0w0K2JuQnJTVzFsUE5IQ3N2UW11?=
 =?gb2312?B?eHMxRGFGejlsSG5BNWQ0MzhmTmpxK0N1VjVQQ2lGMW5EQVJkSGsyVXVlYzd0?=
 =?gb2312?B?M1FXRXJJL1ZSY3l4cXRSRDU1aGpMNDBnZGFvY0owYXJKdW8zTEVoa3ozUHFl?=
 =?gb2312?B?bmwxNFpxdGVtSFMvMHFXcjBwSkp2Vlp0NmxkUkpFK0dpQ1ZUakJEUTgxNjIr?=
 =?gb2312?B?VGw2ZXd2MVdjZ1dxL1IxR3ovVGtjdU5IVlJ5QzlJUlBabnpuWTRkUk5CZkRG?=
 =?gb2312?B?enprcWlqRzM3R2x1V3o5UHJEeWYwN2ZiSnJrNVhXL29HVW5QMmt5NEc4cVhQ?=
 =?gb2312?B?U2drbXhtOG42clZEWGd2S1puSEFkRHNYZ1hOOHh1VzBOeFNBaWpEQ2MwekQr?=
 =?gb2312?B?Sy9KZmovdXdxM1JKek1uOS8zOXpYUXk4OHdxVlpYTzhTT29XSjM4dUlaaW5R?=
 =?gb2312?B?MTJYc3k1ZGVLYXpYRzlQNFNXTzlUeFE3Y0grMTBYd3lZYVZQTjg2alNOTWFn?=
 =?gb2312?B?RTRwd2Q4VTgxaHhMZ21CSXdXWEdaZE1BWjNrTGhjR0JQTFk4bnVJNkl5U1JO?=
 =?gb2312?B?Ty92WUtjSDVUaEJHR0UvVzVvazk2bTBrcTBLa2lZS21xT3Exbzd3ai9sNG9Z?=
 =?gb2312?B?bE05c0RzUEsyUi92ZG9LcFprZlpiQU1KNzlXdy9ZZWNuKzFkU3hYbTExUlRi?=
 =?gb2312?B?c2gwMVV1SEhXVkdCTlpRYjg1STNjcFg1Lys1OWZYMXJtdzJSYWxqNzBKYlJv?=
 =?gb2312?B?K0d1ZTgzV2VFUzRNM2pzWVhZVUhuVmRvM1U4YXQzdkVnQ1BhRVUrQ2FReFow?=
 =?gb2312?B?eWlxMldXZllDR1lTNWFsaWhjOWViaU42eTc5VGl5cnBNTTBDMzk4T1dFNm5h?=
 =?gb2312?B?Y2JrMzVzTjlONDhHWWttV056Zys0QTN3WnRvQjdvQ0dyQXlSNkcxd3JMMTN5?=
 =?gb2312?B?cXJ3dVRvNmxGY2xhRVE4Q2Vmb2wwVVNzdi9OWmtBZlRIeE5iNkE2OFJqdk8z?=
 =?gb2312?B?SXZlTDlna1Y1dUtVbTdNbU5QMCszcXBiOWVqenU0VGp2SEo3K3BkMVJtbndk?=
 =?gb2312?B?UWQrbkFzOXgxQVdXdXVOcFVDM2pJS3Z5TDRxS3hRa3VVcCtyUDQ2RXFSYUlO?=
 =?gb2312?B?ZktScU9TMzZHRzh5NGk4bUFtcWdGZnN6V1ZHbVMyY2xwdkptQythOUVHMWgx?=
 =?gb2312?B?amVUd3FqUDl6aTVsVk1Fbyt5THZiTFpZYys0a0xlYTEvTW5uNkRTRDVJeXBm?=
 =?gb2312?B?Zi85WHNVT3NXZ2I1ckZZWEF4K1g1RnBmazJHeXlITzdrZGp3MnZuNW9xNjUz?=
 =?gb2312?B?emdiMFpERWJudVVrUHJsSURVc1hNMitHL25Kb2VoYldEdXlURm1laGk5cXJ6?=
 =?gb2312?B?THNrTWZvSHQ0T1RYcWFjd1N6OWZvYVNUbkM3azF6d0dyRE8vb3lNcVUyZjRY?=
 =?gb2312?B?Qjc2NVdNendvWkhzbDBXOGdnejQwZ3NSdWt4WlIrSFc5WWtlMTFMM3ltaFBR?=
 =?gb2312?B?RTlYUSttVmdZWEVTcDRlMGtNSGJCQ0I1RmtKZWg4MVZxdFRtZlQ1ZzlvaWZI?=
 =?gb2312?B?eXZXZURWeWYxUEJFSmdVa3o1Q0RtKzBxdWpiY2RHOWMzOE5CSGZSOGY2NnBX?=
 =?gb2312?B?NnZhTWFKRHNLVlJ6cklPdE5sMm53SmdMYnVUREd2OVc0T0dnWkJ6Sm0wQ3o0?=
 =?gb2312?B?QjVYNERsdGJra29GZkdzNkJ6NE16UEozMW5ESkcxY21mOHpFOEx6UGFTaFkz?=
 =?gb2312?B?VWdTK3h0NW5pL2VRS0dqWFBaM3hLL01mQnJjeVlZRk9ycW1RYVM3bWE1Y09p?=
 =?gb2312?B?SmY5NmR6cU5IeVV6SE1uYStkYkNpVVhWTGYxbTgrYW5CSnNwSk9Ra29tUkdQ?=
 =?gb2312?B?Ulk4VW9jZVpFVzVYNlBObDB4bnJUcUJFanBLNG5BR0ZBb0plYWhpb2dhU2RU?=
 =?gb2312?B?bXlUcUlGcmQrZ0hPRVZRMXhrOHdrZXBkVEFSejM0OFlzN3RhbUdvaW05M2Ji?=
 =?gb2312?B?azdtOTVnbW5JV3hxMzZneFlacnBuUHdSVldBbjBJRmo4QVliR3dodjV4OXQ4?=
 =?gb2312?B?aCtkZFJjeWF6WjBYYWhQQWQ0R2lXeXF5UlVJc2FFUUh4S1g1R0JYVzRpSUpL?=
 =?gb2312?B?V2c9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_ME3P282MB2531BAD8FDFF2BB517D4A73994C42ME3P282MB2531AUSP_"
MIME-Version: 1.0
X-OriginatorOrg: taitcommunications.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ME3P282MB2531.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd3f6b9-5fc6-45ae-8598-08dd5172c988
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 05:52:40.5326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b9ac1691-179e-406f-90a3-6d5b9a817466
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fRrG2Nnq99hDeqVt6mUAyqhtEuNsolBiYlHQutk3PJjMojvy2S/YoC6OF7iq2sr4Mv0wUq4ZVB4MYD6dfw9yVZksNQvD+u3AnsVcUF0nmmGYs3u3ZAFIhcyb8VGQGDfI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY2PPF975AE31C9
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Feb 2025 05:53:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1096

--_000_ME3P282MB2531BAD8FDFF2BB517D4A73994C42ME3P282MB2531AUSP_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SSB0aGluayB5b3UgbWVhbiBhdmFsb24tZnJhbWV3b3JrLWFwaS1uYXRpdmU/DQoNCkknbSBzb3Jy
eSB0byByZXBvcnQgdGhhdCBpdCBidWlsZHMganVzdCBmaW5lIG9uIG15IDI0LjA0IGJveCwgc28g
SSBjYW4ndCBoZWxwLg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCkZyb206IHlv
Y3RvLXBhdGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZyA8eW9jdG8tcGF0Y2hlc0BsaXN0cy55
b2N0b3Byb2plY3Qub3JnPiBvbiBiZWhhbGYgb2Ygd2FuZ215IHZpYSBsaXN0cy55b2N0b3Byb2pl
Y3Qub3JnIDx3YW5nbXk9ZnVqaXRzdS5jb21AbGlzdHMueW9jdG9wcm9qZWN0Lm9yZz4NClNlbnQ6
IDIwIEZlYnJ1YXJ5IDIwMjUgMTQ6MzQNClRvOiB5b2N0by1wYXRjaGVzQGxpc3RzLnlvY3RvcHJv
amVjdC5vcmcgPHlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZz4NClN1YmplY3Q6
IFJlOiBbeW9jdG8tcGF0Y2hlc10gW21ldGEtamF2YV0gSXNzdWUgb2YgY2FjYW8NCg0KWW91IGRv
bid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIHdhbmdteT1mdWppdHN1LmNvbUBsaXN0cy55b2N0b3By
b2plY3Qub3JnLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQ8aHR0cHM6Ly9ha2EubXMvTGVh
cm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uPg0KDQpUaGFuayB5b3UgdmVyeSBtdWNoIGZvciBw
cm92aWRpbmcgdGhpcyBwYXRjaC4gQ2FjYW8gaXMgbm93IGZpbmUuIEhvd2V2ZXIsIHRoZXJlIHdh
cyBhbiBpc3N1ZSB3aXRoIHRoZSBidWlsZCBvZiBBdmFsb24tZnJhbWV3b3JrLW5hdGl2ZS4NCg0K
DQoNCk1heSBJIGFzayBpZiB0aGVyZSBpcyBjdXJyZW50bHkgYSBzb2x1dGlvbiB0byB0aGlzIGlz
c3VlPw0KDQoNCg0KVGhlIHNwZWNpZmljIGluZm9ybWF0aW9uIGlzIGFzIGZvbGxvd3M6DQoNCnwg
VGhlIHNlcmlhbGl6YWJsZSBjbGFzcyBQYXJhbWV0ZXJFeGNlcHRpb24gZG9lcyBub3QgZGVjbGFy
ZSBhIHN0YXRpYyBmaW5hbCBzZXJpYWxWZXJzaW9uVUlEIGZpZWxkIG9mIHR5cGUgbG9uZw0KDQp8
IC0tLS0tLS0tLS0NCg0KfCAtLS0tLS0tLS0tDQoNCnwgMTIuIEVSUk9SIGluIHNyYy9qYXZhL29y
Zy9hcGFjaGUvYXZhbG9uL2ZyYW1ld29yay9sb2dnZXIvTG9nZ2FibGUuamF2YSAoYXQgbGluZSAz
NCkNCg0KfCB2b2lkIHNldExvZ2dlciggb3JnLmFwYWNoZS5sb2cuTG9nZ2VyIGxvZ2dlciApOw0K
DQp8ICAgICAgICAgICAgICAgICBeXl5eXl5eXl5eXl5eXg0KDQp8IG9yZy5hcGFjaGUubG9nIGNh
bm5vdCBiZSByZXNvbHZlZCB0byBhIHR5cGUNCg0KDQoNCiAtLQ0KDQpCZXN0IFJlZ2FyZHMNCg0K
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoNCldh
bmcgTWluZ3l1DQoNCkZVSklUU1UgTkFOSklORyBTT0ZUV0FSRSBURUNITk9MT0dZIENPLiwgTFRE
LiAoRk5TVCkNCg0KTm8uNiBXZW56aHUgUm9hZCwgTmFuamluZywgMjEwMDEyLCBDaGluYQ0KDQpU
RUyjuis4NisyNS04NjYzMDU2Ni0tODU2OA0KDQpDT0lOUzogNzk5ODg1NDgNCg0KRkFYOiArODYr
MjUtODMzMTc2ODUNCg0KTUFJTDogd2FuZ215QGZ1aml0c3UuY29tPG1haWx0bzp3YW5nbXlAZnVq
aXRzdS5jb20+DQoNCg0KDQpGcm9tOiB5b2N0by1wYXRjaGVzQGxpc3RzLnlvY3RvcHJvamVjdC5v
cmcgPHlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9mIERv
dWdsYXMgUm95ZHMgdmlhIGxpc3RzLnlvY3RvcHJvamVjdC5vcmcNClNlbnQ6IFdlZG5lc2RheSwg
RmVicnVhcnkgMTksIDIwMjUgOToyNiBBTQ0KVG86IHlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9w
cm9qZWN0Lm9yZw0KU3ViamVjdDogUmU6IFt5b2N0by1wYXRjaGVzXSBbbWV0YS1qYXZhXSBJc3N1
ZSBvZiBjYWNhbw0KDQoNCg0KWWVzLCB5b3Ugd2lsbCBuZWVkIHRoaXMgcGF0Y2gsIHdoaWNoIGhh
c24ndCBmb3VuZCBpdHMgd2F5IGludG8gbWV0YS1qYXZhIHlldDoNCg0KDQoNCiAgW1BBVENIIDIv
Ml0gY2FjYW8tbmF0aXZlOiBwYXRjaCB0byBiZSBidWlsZGFibGUgd2l0aCBnY2MxMzxodHRwczov
L2xpc3RzLm9wZW5lbWJlZGRlZC5vcmcvZy9vcGVuZW1iZWRkZWQtZGV2ZWwvbWVzc2FnZS8xMTM5
MDY+DQoNCg0KDQoNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCg0KRnJvbTog
eW9jdG8tcGF0Y2hlc0BsaXN0cy55b2N0b3Byb2plY3Qub3JnPG1haWx0bzp5b2N0by1wYXRjaGVz
QGxpc3RzLnlvY3RvcHJvamVjdC5vcmc+IDx5b2N0by1wYXRjaGVzQGxpc3RzLnlvY3RvcHJvamVj
dC5vcmc8bWFpbHRvOnlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZz4+IG9uIGJl
aGFsZiBvZiB3YW5nbXkgdmlhIGxpc3RzLnlvY3RvcHJvamVjdC5vcmcgPHdhbmdteT1mdWppdHN1
LmNvbUBsaXN0cy55b2N0b3Byb2plY3Qub3JnPG1haWx0bzp3YW5nbXk9ZnVqaXRzdS5jb21AbGlz
dHMueW9jdG9wcm9qZWN0Lm9yZz4+DQpTZW50OiAxOSBGZWJydWFyeSAyMDI1IDEzOjQ2DQpUbzog
eW9jdG8tcGF0Y2hlc0BsaXN0cy55b2N0b3Byb2plY3Qub3JnPG1haWx0bzp5b2N0by1wYXRjaGVz
QGxpc3RzLnlvY3RvcHJvamVjdC5vcmc+IDx5b2N0by1wYXRjaGVzQGxpc3RzLnlvY3RvcHJvamVj
dC5vcmc8bWFpbHRvOnlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZz4+DQpTdWJq
ZWN0OiBbeW9jdG8tcGF0Y2hlc10gW21ldGEtamF2YV0gSXNzdWUgb2YgY2FjYW8NCg0KDQoNCldo
ZW4gZXhlY3V0aW5nIHRoZSBjb21tYW5kIGJpdGJha2Ugb3Blbmpkay04LCBjYWNhbyBlbmNvdW50
ZXJlZCB0aGUgZm9sbG93aW5nIGVycm9yOg0KDQovdXNyL2luY2x1ZGUvYysrLzEzL2JpdHMvc3Rs
X2xpc3QuaDoyMDMxOjM3OiBlcnJvcjogbm8gbWF0Y2ggZm9yICRCIUYoQm9wZXJhdG9yIT0kQiFH
KEIgKG9wZXJhbmQgdHlwZXMgYXJlICRCIUYoQnN0ZDo6X19jeHgxMTo6X0xpc3RfYmFzZTxicmFu
Y2hfbGFiZWxfcmVmX3QqLCBEdW1wTWVtb3J5QWxsb2NhdG9yPGJyYW5jaF9sYWJlbF9yZWZfdCo+
DQoNCjo6X05vZGVfYWxsb2NfdHlwZSRCIUcoQiB7YWthICRCIUYoQnN0ZDo6YWxsb2NhdG9yX3Ry
YWl0czxEdW1wTWVtb3J5QWxsb2NhdG9yPGJyYW5jaF9sYWJlbF9yZWZfdCo+ID46OnJlYmluZF9h
bGxvYzxzdGQ6Ol9MaXN0X25vZGU8YnJhbmNoX2xhYmVsX3JlZl90Kj4gPiRCIUcoQn0gYW5kICRC
IUYoQmNvbnN0IHN0ZDo6X19jeHgxMTo6X0xpc3RfYmFzZTxicg0KYW5jaF9sYWJlbF9yZWZfdCos
IER1bXBNZW1vcnlBbGxvY2F0b3I8YnJhbmNoX2xhYmVsX3JlZl90Kj4gPjo6X05vZGVfYWxsb2Nf
dHlwZSRCIUcoQiB7YWthICRCIUYoQnN0ZDo6YWxsb2NhdG9yX3RyYWl0czxEdW1wTWVtb3J5QWxs
b2NhdG9yPGJyYW5jaF9sYWJlbF9yZWZfdCo+ID46OnJlYmluZF9hbGxvYzxzdGQ6Ol9MaXN0X25v
ZGU8YnJhDQpuY2hfbGFiZWxfcmVmX3QqPiA+JEIhRyhCfSkNCg0KVGhpcyBpc3N1ZSBvY2N1cnJl
ZCBhZnRlciB1cGdyYWRpbmcgdGhlIGNvbXBpbGF0aW9uIGVudmlyb25tZW50IHRvIFVidW50dSAy
NC4wNC4NClRoZSB1cHN0cmVhbSBvZiBjYWNhbyBoYXMgbm90IGJlZW4gbWFpbnRhaW5lZCBmb3Ig
YSBsb25nIHRpbWUgKHRoZSBsYXN0IHRpbWUgd2FzIGluIDIwMjApLg0KQXJlIHRoZXJlIGFueSBw
bGFucyB0byBtYWtlIG1vZGlmaWNhdGlvbnMgdG8gY2FjYW8gdGhhdCBhcmUgY29tcGF0aWJsZSB3
aXRoIFVidW50dSAyNC4wNCBpbiB0aGUgZnV0dXJlPw0KDQogIC0tDQpCZXN0IFJlZ2FyZHMNCi0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KV2FuZyBN
aW5neXUNCkZVSklUU1UgTkFOSklORyBTT0ZUV0FSRSBURUNITk9MT0dZIENPLiwgTFRELiAoRk5T
VCkNCk5vLjYgV2Vuemh1IFJvYWQsIE5hbmppbmcsIDIxMDAxMiwgQ2hpbmENClRFTCRCIScoQis4
NisyNS04NjYzMDU2Ni0tODU2OA0KQ09JTlM6IDc5OTg4NTQ4DQpGQVg6ICs4NisyNS04MzMxNzY4
NQ0KTUFJTDogd2FuZ215QGZ1aml0c3UuY29tPG1haWx0bzp3YW5nbXlAZnVqaXRzdS5jb20+DQoN
Cl8uXyxfLl8sXw0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCkxpbmtzOg0KDQpZ
b3UgcmVjZWl2ZSBhbGwgbWVzc2FnZXMgc2VudCB0byB0aGlzIGdyb3VwLg0KDQpWaWV3L1JlcGx5
IE9ubGluZSAoIzEwOTUpPGh0dHBzOi8vbGlzdHMueW9jdG9wcm9qZWN0Lm9yZy9nL3lvY3RvLXBh
dGNoZXMvbWVzc2FnZS8xMDk1PiB8IFJlcGx5IHRvIEdyb3VwPG1haWx0bzp5b2N0by1wYXRjaGVz
QGxpc3RzLnlvY3RvcHJvamVjdC5vcmc/c3ViamVjdD1SZTolMjBSZSUzQSUyMCU1QnlvY3RvLXBh
dGNoZXMlNUQlMjAlNUJtZXRhLWphdmElNUQlMjBJc3N1ZSUyMG9mJTIwY2FjYW8+IHwgUmVwbHkg
dG8gU2VuZGVyPG1haWx0bzp3YW5nbXlAZnVqaXRzdS5jb20/c3ViamVjdD1Qcml2YXRlOiUyMFJl
OiUyMFJlJTNBJTIwJTVCeW9jdG8tcGF0Y2hlcyU1RCUyMCU1Qm1ldGEtamF2YSU1RCUyMElzc3Vl
JTIwb2YlMjBjYWNhbz4gfCBNdXRlIFRoaXMgVG9waWM8aHR0cHM6Ly9saXN0cy55b2N0b3Byb2pl
Y3Qub3JnL210LzExMTI2MjI4My82OTMyNDM4PiB8IE5ldyBUb3BpYzxodHRwczovL2xpc3RzLnlv
Y3RvcHJvamVjdC5vcmcvZy95b2N0by1wYXRjaGVzL3Bvc3Q+DQpZb3VyIFN1YnNjcmlwdGlvbjxo
dHRwczovL2xpc3RzLnlvY3RvcHJvamVjdC5vcmcvZy95b2N0by1wYXRjaGVzL2VkaXRzdWIvNjkz
MjQzOD4gfCBDb250YWN0IEdyb3VwIE93bmVyPG1haWx0bzp5b2N0by1wYXRjaGVzK293bmVyQGxp
c3RzLnlvY3RvcHJvamVjdC5vcmc+IHwgVW5zdWJzY3JpYmU8aHR0cHM6Ly9saXN0cy55b2N0b3By
b2plY3Qub3JnL2cveW9jdG8tcGF0Y2hlcy9sZWF2ZS8xMzg4NzQ0Mi82OTMyNDM4LzE0OTE4NTUy
MDkveHl6enk+IFtkb3VnbGFzLnJveWRzQHRhaXRjb21tdW5pY2F0aW9ucy5jb21dDQoNCl8uXyxf
Ll8sXw0K

--_000_ME3P282MB2531BAD8FDFF2BB517D4A73994C42ME3P282MB2531AUSP_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I think you mean avalon-framework-api-native?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I'm sorry to report that it builds just fine on my 24.04 box, so I can't he=
lp.</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> yocto-patches@lists.y=
octoproject.org &lt;yocto-patches@lists.yoctoproject.org&gt; on behalf of w=
angmy via lists.yoctoproject.org &lt;wangmy=3Dfujitsu.com@lists.yoctoprojec=
t.org&gt;<br>
<b>Sent:</b> 20 February 2025 14:34<br>
<b>To:</b> yocto-patches@lists.yoctoproject.org &lt;yocto-patches@lists.yoc=
toproject.org&gt;<br>
<b>Subject:</b> Re: [yocto-patches] [meta-java] Issue of cacao</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"MS Mincho"}
@font-face
	{font-family:=CB=CE=CC=E5}
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:=B5=C8=CF=DF}
@font-face
	{font-family:Calibri}
@font-face
	{}
@font-face
	{}
@font-face
	{}
@font-face
	{font-family:Aptos}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:=CB=CE=CC=E5}
a:link, span.x_MsoHyperlink
	{color:blue;
	text-decoration:underline}
span.x_EmailStyle20
	{font-family:=B5=C8=CF=DF;
	color:windowtext}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:72.0pt 90.0pt 72.0pt 90.0pt}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"ZH-CN" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:break=
-word">
<table border=3D"0" cellspacing=3D"0" cellpadding=3D"0" width=3D"100%" alig=
n=3D"left" style=3D"background:revert!important; border:revert!important; b=
ottom:revert!important; color:revert!important; direction:revert!important;=
 display:revert!important; font-size:revert!important; height:revert!import=
ant; letter-spacing:revert!important; line-height:revert!important; margin:=
revert!important; opacity:revert!important; order:revert!important; outline=
:revert!important; overflow:revert!important; padding:revert!important; pos=
ition:revert!important; tab-size:revert!important; table-layout:revert!impo=
rtant; text-align:revert!important; text-indent:revert!important; text-orie=
ntation:revert!important; text-overflow:revert!important; text-transform:re=
vert!important; top:revert!important; vertical-align:revert!important; visi=
bility:revert!important; white-space:revert!important; width:revert!importa=
nt; word-break:revert!important; word-spacing:revert!important; writing-mod=
e:revert!important; zoom:revert!important; border:0!important; display:tabl=
e!important; width:100%!important; table-layout:fixed!important; border-col=
lapse:seperate!important; float:none!important; border-spacing:0px 0px!impo=
rtant">
<tbody style=3D"background:revert!important; border:revert!important; botto=
m:revert!important; color:revert!important; direction:revert!important; dis=
play:revert!important; font-size:revert!important; height:revert!important;=
 letter-spacing:revert!important; line-height:revert!important; margin:reve=
rt!important; opacity:revert!important; order:revert!important; outline:rev=
ert!important; overflow:revert!important; padding:revert!important; positio=
n:revert!important; tab-size:revert!important; table-layout:revert!importan=
t; text-align:revert!important; text-indent:revert!important; text-orientat=
ion:revert!important; text-overflow:revert!important; text-transform:revert=
!important; top:revert!important; vertical-align:revert!important; visibili=
ty:revert!important; white-space:revert!important; width:revert!important; =
word-break:revert!important; word-spacing:revert!important; writing-mode:re=
vert!important; zoom:revert!important; display:block!important">
<tr style=3D"background:revert!important; border:revert!important; bottom:r=
evert!important; color:revert!important; direction:revert!important; displa=
y:revert!important; font-size:revert!important; height:revert!important; le=
tter-spacing:revert!important; line-height:revert!important; margin:revert!=
important; opacity:revert!important; order:revert!important; outline:revert=
!important; overflow:revert!important; padding:revert!important; position:r=
evert!important; tab-size:revert!important; table-layout:revert!important; =
text-align:revert!important; text-indent:revert!important; text-orientation=
:revert!important; text-overflow:revert!important; text-transform:revert!im=
portant; top:revert!important; vertical-align:revert!important; visibility:=
revert!important; white-space:revert!important; width:revert!important; wor=
d-break:revert!important; word-spacing:revert!important; writing-mode:rever=
t!important; zoom:revert!important">
<td valign=3D"middle" width=3D"1px" bgcolor=3D"#A6A6A6" cellpadding=3D"7px =
2px 7px 2px" style=3D"background:revert!important; border:revert!important;=
 bottom:revert!important; color:revert!important; direction:revert!importan=
t; display:revert!important; font-size:revert!important; height:revert!impo=
rtant; letter-spacing:revert!important; line-height:revert!important; margi=
n:revert!important; opacity:revert!important; order:revert!important; outli=
ne:revert!important; overflow:revert!important; padding:revert!important; p=
osition:revert!important; tab-size:revert!important; table-layout:revert!im=
portant; text-align:revert!important; text-indent:revert!important; text-or=
ientation:revert!important; text-overflow:revert!important; text-transform:=
revert!important; top:revert!important; vertical-align:revert!important; vi=
sibility:revert!important; white-space:revert!important; width:revert!impor=
tant; word-break:revert!important; word-spacing:revert!important; writing-m=
ode:revert!important; zoom:revert!important; padding:7px 2px 7px 2px!import=
ant; background-color:#A6A6A6!important; width:0px!important">
</td>
<td valign=3D"middle" width=3D"100%" bgcolor=3D"#EAEAEA" cellpadding=3D"7px=
 5px 7px 15px" color=3D"#212121" style=3D"background:revert!important; bord=
er:revert!important; bottom:revert!important; color:revert!important; direc=
tion:revert!important; display:revert!important; font-size:revert!important=
; height:revert!important; letter-spacing:revert!important; line-height:rev=
ert!important; margin:revert!important; opacity:revert!important; order:rev=
ert!important; outline:revert!important; overflow:revert!important; padding=
:revert!important; position:revert!important; tab-size:revert!important; ta=
ble-layout:revert!important; text-align:revert!important; text-indent:rever=
t!important; text-orientation:revert!important; text-overflow:revert!import=
ant; text-transform:revert!important; top:revert!important; vertical-align:=
revert!important; visibility:revert!important; white-space:revert!important=
; width:revert!important; word-break:revert!important; word-spacing:revert!=
important; writing-mode:revert!important; zoom:revert!important; width:100%=
!important; background-color:#EAEAEA!important; padding:7px 5px 7px 15px!im=
portant; font-family:wf_segoe-ui_normal,Segoe UI,Segoe WP,Tahoma,Arial,sans=
-serif!important; font-size:12px!important; font-weight:normal!important; c=
olor:#212121!important; text-align:left!important; word-wrap:break-word!imp=
ortant">
<div style=3D"background:revert!important; border:revert!important; bottom:=
revert!important; color:revert!important; direction:revert!important; displ=
ay:revert!important; font-size:revert!important; height:revert!important; l=
etter-spacing:revert!important; line-height:revert!important; margin:revert=
!important; opacity:revert!important; order:revert!important; outline:rever=
t!important; overflow:revert!important; padding:revert!important; position:=
revert!important; tab-size:revert!important; table-layout:revert!important;=
 text-align:revert!important; text-indent:revert!important; text-orientatio=
n:revert!important; text-overflow:revert!important; text-transform:revert!i=
mportant; top:revert!important; vertical-align:revert!important; visibility=
:revert!important; white-space:revert!important; width:revert!important; wo=
rd-break:revert!important; word-spacing:revert!important; writing-mode:reve=
rt!important; zoom:revert!important">
You don't often get email from wangmy=3Dfujitsu.com@lists.yoctoproject.org.=
 <a href=3D"https://aka.ms/LearnAboutSenderIdentification" style=3D"backgro=
und:revert!important; color:revert!important; direction:revert!important; d=
isplay:revert!important; font-size:revert!important; opacity:revert!importa=
nt; visibility:revert!important">
Learn why this is important</a> </div>
</td>
<td valign=3D"middle" align=3D"left" width=3D"75px" bgcolor=3D"#EAEAEA" cel=
lpadding=3D"7px 5px 7px 5px" color=3D"#212121" style=3D"background:revert!i=
mportant; border:revert!important; bottom:revert!important; color:revert!im=
portant; direction:revert!important; display:revert!important; font-size:re=
vert!important; height:revert!important; letter-spacing:revert!important; l=
ine-height:revert!important; margin:revert!important; opacity:revert!import=
ant; order:revert!important; outline:revert!important; overflow:revert!impo=
rtant; padding:revert!important; position:revert!important; tab-size:revert=
!important; table-layout:revert!important; text-align:revert!important; tex=
t-indent:revert!important; text-orientation:revert!important; text-overflow=
:revert!important; text-transform:revert!important; top:revert!important; v=
ertical-align:revert!important; visibility:revert!important; white-space:re=
vert!important; width:revert!important; word-break:revert!important; word-s=
pacing:revert!important; writing-mode:revert!important; zoom:revert!importa=
nt; width:75px!important; background-color:#EAEAEA!important; padding:7px 5=
px 7px 5px!important; font-family:wf_segoe-ui_normal,Segoe UI,Segoe WP,Taho=
ma,Arial,sans-serif!important; font-size:12px!important; font-weight:normal=
!important; color:#212121!important; text-align:left!important; word-wrap:b=
reak-word!important">
</td>
</tr>
</tbody>
</table>
<div>
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt; fo=
nt-family:=B5=C8=CF=DF">Thank you very much for providing this patch. Cacao=
 is now fine. However, there was an issue with the build of Avalon-framewor=
k-native.
</span></p>
<p class=3D"x_MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt; fo=
nt-family:=B5=C8=CF=DF">&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt; fo=
nt-family:=B5=C8=CF=DF">May I ask if there is currently a solution to this =
issue?</span></p>
<p class=3D"x_MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt; fo=
nt-family:=B5=C8=CF=DF">&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt; fo=
nt-family:=B5=C8=CF=DF">The specific information is as follows:</span></p>
<p class=3D"x_MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt; fo=
nt-family:=B5=C8=CF=DF">| The serializable class ParameterException does no=
t declare a static final serialVersionUID field of type long</span></p>
<p class=3D"x_MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt; fo=
nt-family:=B5=C8=CF=DF">| ----------</span></p>
<p class=3D"x_MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt; fo=
nt-family:=B5=C8=CF=DF">| ----------</span></p>
<p class=3D"x_MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt; fo=
nt-family:=B5=C8=CF=DF">| 12. ERROR in src/java/org/apache/avalon/framework=
/logger/Loggable.java (at line 34)</span></p>
<p class=3D"x_MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt; fo=
nt-family:=B5=C8=CF=DF">| void setLogger( org.apache.log.Logger logger );</=
span></p>
<p class=3D"x_MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt; fo=
nt-family:=B5=C8=CF=DF">|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^^^^^^^^^^^^^^</span></p>
<p class=3D"x_MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt; fo=
nt-family:=B5=C8=CF=DF">| org.apache.log cannot be resolved to a type</span=
></p>
<p class=3D"x_MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt; fo=
nt-family:=B5=C8=CF=DF">&nbsp;</span></p>
<div>
<p class=3D"x_MsoNormal" style=3D"text-align:justify; text-justify:inter-id=
eograph"><span lang=3D"EN-US" style=3D"font-size:10.5pt; font-family:&quot;=
MS Mincho&quot;">&nbsp;--</span></p>
<p class=3D"x_MsoNormal" style=3D"text-align:justify; text-justify:inter-id=
eograph"><span lang=3D"EN-US" style=3D"font-size:10.5pt; font-family:&quot;=
MS Mincho&quot;">Best Regards</span></p>
<p class=3D"x_MsoNormal" style=3D"text-align:justify; text-justify:inter-id=
eograph"><span lang=3D"EN-US" style=3D"font-size:10.5pt; font-family:&quot;=
MS Mincho&quot;">---------------------------------------------------</span>=
</p>
<p class=3D"x_MsoNormal" style=3D"text-align:justify; text-justify:inter-id=
eograph"><span lang=3D"EN-US" style=3D"font-size:10.5pt; font-family:&quot;=
MS Mincho&quot;">Wang Mingyu</span></p>
<p class=3D"x_MsoNormal" style=3D"text-align:justify; text-justify:inter-id=
eograph"><span lang=3D"EN-US" style=3D"font-size:10.5pt; font-family:&quot;=
MS Mincho&quot;">FUJITSU NANJING SOFTWARE TECHNOLOGY CO., LTD. (FNST)</span=
></p>
<p class=3D"x_MsoNormal" style=3D"text-align:justify; text-justify:inter-id=
eograph"><span lang=3D"EN-US" style=3D"font-size:10.5pt; font-family:&quot;=
MS Mincho&quot;">No.6 Wenzhu Road, Nanjing, 210012, China</span></p>
<p class=3D"x_MsoNormal" style=3D"text-align:justify; text-justify:inter-id=
eograph"><span lang=3D"EN-US" style=3D"font-size:10.5pt; font-family:&quot;=
MS Mincho&quot;">TEL</span><span style=3D"font-size:10.5pt; font-family:&qu=
ot;MS Mincho&quot;">=A3=BA<span lang=3D"EN-US">+86+25-86630566--8568</span>=
</span></p>
<p class=3D"x_MsoNormal" style=3D"text-align:justify; text-justify:inter-id=
eograph"><span lang=3D"EN-US" style=3D"font-size:10.5pt; font-family:&quot;=
MS Mincho&quot;">COINS: 79988548</span></p>
<p class=3D"x_MsoNormal" style=3D"text-align:justify; text-justify:inter-id=
eograph"><span lang=3D"EN-US" style=3D"font-size:10.5pt; font-family:&quot;=
MS Mincho&quot;">FAX: +86+25-83317685</span></p>
<p class=3D"x_MsoNormal" style=3D"text-align:justify; text-justify:inter-id=
eograph"><span lang=3D"EN-US" style=3D"font-size:10.5pt; font-family:&quot;=
MS Mincho&quot;">MAIL:
<a href=3D"mailto:wangmy@fujitsu.com"><span style=3D"color:#0563C1">wangmy@=
fujitsu.com</span></a></span></p>
</div>
<p class=3D"x_MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt; fo=
nt-family:=B5=C8=CF=DF">&nbsp;</span></p>
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0c=
m 0cm 0cm">
<p class=3D"x_MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;=
 font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span lang=3D"=
EN-US" style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-seri=
f"> yocto-patches@lists.yoctoproject.org &lt;yocto-patches@lists.yoctoproje=
ct.org&gt;
<b>On Behalf Of </b>Douglas Royds via lists.yoctoproject.org<br>
<b>Sent:</b> Wednesday, February 19, 2025 9:26 AM<br>
<b>To:</b> yocto-patches@lists.yoctoproject.org<br>
<b>Subject:</b> Re: [yocto-patches] [meta-java] Issue of cacao</span></p>
</div>
</div>
<p class=3D"x_MsoNormal"><span lang=3D"EN-US">&nbsp;</span></p>
<div>
<p class=3D"x_MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Ap=
tos&quot;,sans-serif; color:black">Yes, you will need this patch, which has=
n't found its way into meta-java yet:</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Ap=
tos&quot;,sans-serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Ap=
tos&quot;,sans-serif; color:black">&nbsp;
<a href=3D"https://lists.openembedded.org/g/openembedded-devel/message/1139=
06" originalsrc=3D"https://lists.openembedded.org/g/openembedded-devel/mess=
age/113906" shash=3D"rpELcBBC+rfG407kYwXunyMVI7x0uFfKUrnT2zXoAjH5E5nktDsA11=
IeMK/QwZQzMa6GXTddnthk4FBauJPt6VmNROQqIPjAIF9VOvumPIcmswNNEpF0AAXyxcjdhfIp7=
vq2vLIPLRCm0r8cJu6hRifPFFAgp5Eqe/s7ktW8/m0=3D" title=3D"https://lists.opene=
mbedded.org/g/openembedded-devel/message/113906">
[PATCH 2/2] cacao-native: patch to be buildable with gcc13</a></span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Ap=
tos&quot;,sans-serif; color:black">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Ap=
tos&quot;,sans-serif; color:black">&nbsp;</span></p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center"><sp=
an lang=3D"EN-US">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;=
 font-family:&quot;Calibri&quot;,sans-serif; color:black">From:</span></b><=
span lang=3D"EN-US" style=3D"font-size:11.0pt; font-family:&quot;Calibri&qu=
ot;,sans-serif; color:black">&nbsp;<a href=3D"mailto:yocto-patches@lists.yo=
ctoproject.org">yocto-patches@lists.yoctoproject.org</a>
 &lt;<a href=3D"mailto:yocto-patches@lists.yoctoproject.org">yocto-patches@=
lists.yoctoproject.org</a>&gt; on behalf of wangmy via lists.yoctoproject.o=
rg &lt;<a href=3D"mailto:wangmy=3Dfujitsu.com@lists.yoctoproject.org">wangm=
y=3Dfujitsu.com@lists.yoctoproject.org</a>&gt;<br>
<b>Sent:</b>&nbsp;19 February 2025 13:46<br>
<b>To:</b>&nbsp;<a href=3D"mailto:yocto-patches@lists.yoctoproject.org">yoc=
to-patches@lists.yoctoproject.org</a> &lt;<a href=3D"mailto:yocto-patches@l=
ists.yoctoproject.org">yocto-patches@lists.yoctoproject.org</a>&gt;<br>
<b>Subject:</b>&nbsp;[yocto-patches] [meta-java] Issue of cacao</span><span=
 lang=3D"EN-US">
</span></p>
<div>
<p class=3D"x_MsoNormal"><span lang=3D"EN-US">&nbsp;</span></p>
</div>
</div>
<div>
<p class=3D"x_MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Wh=
en executing the command bitbake openjdk-8, cacao encountered the following=
 error:</span></p>
</div>
<div>
<p class=3D"x_MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><b=
r>
/usr/include/c++/13/bits/stl_list.h:2031:37: error: no match for $B!F(Boper=
ator!=3D$B!G(B (operand types are $B!F(Bstd::__cxx11::_List_base&lt;branch_=
label_ref_t*, DumpMemoryAllocator&lt;branch_label_ref_t*&gt;<br>
<br>
::_Node_alloc_type$B!G(B {aka $B!F(Bstd::allocator_traits&lt;DumpMemoryAllo=
cator&lt;branch_label_ref_t*&gt; &gt;::rebind_alloc&lt;std::_List_node&lt;b=
ranch_label_ref_t*&gt; &gt;$B!G(B} and $B!F(Bconst std::__cxx11::_List_base=
&lt;br<br>
anch_label_ref_t*, DumpMemoryAllocator&lt;branch_label_ref_t*&gt; &gt;::_No=
de_alloc_type$B!G(B {aka $B!F(Bstd::allocator_traits&lt;DumpMemoryAllocator=
&lt;branch_label_ref_t*&gt; &gt;::rebind_alloc&lt;std::_List_node&lt;bra<br=
>
nch_label_ref_t*&gt; &gt;$B!G(B})<br>
<br>
This issue occurred after upgrading the compilation environment to Ubuntu 2=
4.04.<br>
The upstream of cacao has not been maintained for a long time (the last tim=
e was in 2020).<br>
Are there any plans to make modifications to cacao that are compatible with=
 Ubuntu 24.04 in the future?<br>
<br>
&nbsp; --<br>
Best Regards<br>
---------------------------------------------------<br>
Wang Mingyu<br>
FUJITSU NANJING SOFTWARE TECHNOLOGY CO., LTD. (FNST)<br>
No.6 Wenzhu Road, Nanjing, 210012, China<br>
TEL$B!'(B+86+25-86630566--8568<br>
COINS: 79988548<br>
FAX: +86+25-83317685<br>
MAIL: <a href=3D"mailto:wangmy@fujitsu.com">wangmy@fujitsu.com</a></span></=
p>
</div>
<div>
<p class=3D"x_MsoNormal"></p>
</div>
</div>
<div width=3D"1" style=3D"color:white; clear:both">_._,_._,_</div>
<hr>
Links:
<p>You receive all messages sent to this group. </p>
<p><a target=3D"_blank" href=3D"https://lists.yoctoproject.org/g/yocto-patc=
hes/message/1095" originalsrc=3D"https://lists.yoctoproject.org/g/yocto-pat=
ches/message/1095" shash=3D"G1B2toISnSQvMqSNZP2hFQmRMZrxU4h1LhLQ7vAwPu0Dp1v=
ljsdGO9ffJG0iWXBzl3U6XZmVIaG0grYERDk7ezbL+vfyKUoeqeo6xSwTzcOFNSNz8Jx5vjqkA7=
EjTZtP1wkkymP9T4K2G5PUKmqnBMm9Mtz/WS+ksKPgGJrYsp0=3D">View/Reply
 Online (#1095)</a> | <a target=3D"_blank" href=3D"mailto:yocto-patches@lis=
ts.yoctoproject.org?subject=3DRe:%20Re%3A%20%5Byocto-patches%5D%20%5Bmeta-j=
ava%5D%20Issue%20of%20cacao">
Reply to Group</a> | <a target=3D"_blank" href=3D"mailto:wangmy@fujitsu.com=
?subject=3DPrivate:%20Re:%20Re%3A%20%5Byocto-patches%5D%20%5Bmeta-java%5D%2=
0Issue%20of%20cacao">
Reply to Sender</a> | <a target=3D"_blank" href=3D"https://lists.yoctoproje=
ct.org/mt/111262283/6932438" originalsrc=3D"https://lists.yoctoproject.org/=
mt/111262283/6932438" shash=3D"r8EMJfciMz1jezPXQ0Gw+GAkirHfSwvUGYe9qCTxz6sL=
poo3UM+et+BpnhyK+MWuiekoaKVmrO4odgpJ/FzVK8lDHpassndXGzhpBl3T5RPvVQb/LvSNTzm=
u/JpQiGCiVIr6yBPJsLUKkiMxCPCn+5ByOFy1PxtrpoIgoDhFVrk=3D">
Mute This Topic</a> | <a href=3D"https://lists.yoctoproject.org/g/yocto-pat=
ches/post" originalsrc=3D"https://lists.yoctoproject.org/g/yocto-patches/po=
st" shash=3D"GYlPql/FMkpyB7sHfpJOG2JwWI4kgZ6khDSlv6rGhA4UxOpz5a8QOOTIBHl8Yw=
NWZHu4UubYxbmYjpF0682yIIJ4tcHGu5pJqjGSrNgoq551A8AvJSx2fJhxeJsv4qBc4g/jwmJhE=
qz7H9BaCgYcuO2Rjm43v8MqPXcT6yFTXuw=3D">
New Topic</a> <br>
<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/editsub/6932438" =
originalsrc=3D"https://lists.yoctoproject.org/g/yocto-patches/editsub/69324=
38" shash=3D"UdSMf0xpWSsgUXh9Jcfrn/9QG+uQYX0VZIaB9hJA2kGFjfasDxkqEMUncwKItC=
o8NTmPwkF/bmCAgASPVpNBhDkRb+H6NtGA609KE2DFwaXGvWDOHPAGXvSii3GLdFG5HAMt9vazU=
j+aWf5rHxo9Z1uecoWxjuZIkT/3DOvNr+c=3D">Your
 Subscription</a> | <a href=3D"mailto:yocto-patches+owner@lists.yoctoprojec=
t.org">Contact Group Owner</a> |
<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leave/13887442/69=
32438/1491855209/xyzzy" originalsrc=3D"https://lists.yoctoproject.org/g/yoc=
to-patches/leave/13887442/6932438/1491855209/xyzzy" shash=3D"hLUbqyN82k4sDx=
PH/0MfgA2Gp+P/54yTKG9UfJfyyBYMJBxaDlpfdzU3pTwW+agxbHSgb6aEfPYFb2c4T+KiAXPTD=
+KQLyZJir9Zmk3vaUxtjjIQU/7kvoVkVa14mk8jU/mpb41JHYBnpVbAoCK1HuzKusRESixNfQRk=
Jbzmb1s=3D">
Unsubscribe</a> [douglas.royds@taitcommunications.com]<br>
</p>
<div width=3D"1" style=3D"color:white; clear:both">_._,_._,_</div>
</div>
</div>
</body>
</html>

--_000_ME3P282MB2531BAD8FDFF2BB517D4A73994C42ME3P282MB2531AUSP_--

