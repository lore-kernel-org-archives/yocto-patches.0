Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0B4E7C6E7
	for <webhook@archiver.kernel.org>; Sat, 31 Jan 2026 20:18:40 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16768.1769890718408036649
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 31 Jan 2026 12:18:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OV3YkXbv;
 spf=pass (domain: siemens.com, ip: 52.101.66.31, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VoObXWBYUNQvM00HrL6QiI2Ml6Z8oByCVltQNNSKwf5cyCxMnY6PdKWnnEEs8d8t1+GWTCKdGCeN3DooMKfQUp36woc165blHOdYOkI/MplBtEGNdps5w6wMtxSqvQM74H3PW16Cv+gIaM904ykSy/ENJfG9/1OS1q0MJthP4MDmLTp6eZ5YymjmtOHHTtmjgqOfQsdybxxgxpYeF+joRj3+1HbS8dj7R3NxRohfyPr9Tr9DaJhZ5ZHvB/pbanpYOvPyCW3yQGh7OqG7MKPQgLix2UHeTvngQIWc5gw4p+eea+zv94AAGmsOc3qKQ/vTXnf2xbWFS4ZZNsL2ZdOHzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcWdHVqNcxOnML+shWk5QU4s+1jBGTs2UEplAN3TQf8=;
 b=EDio6fGX6eGoriSeznH5H73SZ570MEs9Yb0HlR6PKTgOQh27ED/1TGeMvKLPNM1IU3zPNn/xD0xQSxofFBjpLUpTqieDpmtKDzr7auNHxx3iKCGjZKeOfZmLNo58QCJNpytGf7ypwI3RLMtEs6as4PkunIkqf+Ii/bONnwOXuk3OD1FINwiGPVzzW1o+1+9FJCz0xXHTmquPKihuknVpYflMIxWrWqH09rsSXgymu/1Y1sOvVeOEtE/5wPMLkN78DecNNJDpbt1HElTbj3C7P7rOcv4HXRofPlymT7uJZAnQQy5JdrplravagTNJuguz4HbhXksLMuaDcxVInUkqMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcWdHVqNcxOnML+shWk5QU4s+1jBGTs2UEplAN3TQf8=;
 b=OV3YkXbvOSPgQ6UO1i1a8dZ9Qps6Kbcn5zQU1PYgvW2/WfonCnhddgDCfnk5Ziq4YMXL2bBsYXpNXRt61WTFxUhuDtGDyrC6W8Tj7qR3MkVl26Jzb8n/pVVeSw6medu0B5hFE0LfZ7xRfCh78m2xFAnz/RqOXgUhRbymjy6E/DvYzk9KopTp7Ggic04bdNzfEAECrMQ0k7WnFWgghBrQhFcc/xYQ3oTQqXjBsNQ8wXRBQwyXVRlnwNAZCZBIEPUCF0GHJIMG3o5seuepHjNWG2861GxOIJJuCPahrxAzzUGPdvP/diARwmaDpDq2FbeUb3ax0X7exh5SlI0+82hIgw==
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::20)
 by PA4PR10MB5705.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Sat, 31 Jan
 2026 20:18:34 +0000
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b54d:255a:1abf:2dc7]) by AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b54d:255a:1abf:2dc7%6]) with mapi id 15.20.9564.006; Sat, 31 Jan 2026
 20:18:33 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: Ross Burton <Ross.Burton@arm.com>, "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
Subject: RE: [yocto-patches] [yocto-metrics][PATCH] patch-status: add
 whinlatter
Thread-Topic: [yocto-patches] [yocto-metrics][PATCH] patch-status: add
 whinlatter
Thread-Index: AQHcjWuAwMxr74XhokudBJW3gjI6XbVkStiAgAh3ZkA=
Date: Sat, 31 Jan 2026 20:18:33 +0000
Message-ID: 
 <AS1PR10MB569754E2254D487C56FCE53DFD9CA@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
References: <20260124195614.1874743-1-peter.marko@siemens.com>
 <F7383EE9-2EE0-44C5-91CC-AF540D574E5C@arm.com>
In-Reply-To: <F7383EE9-2EE0-44C5-91CC-AF540D574E5C@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=4633944f-af9f-4e92-95d7-ba9b8dd53bc4;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-01-31T20:16:54Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5697:EE_|PA4PR10MB5705:EE_
x-ms-office365-filtering-correlation-id: f7ba9731-a7f7-4f2e-8ecc-08de6105e8aa
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|4022899009|13003099007|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?NGpXY1kzZ3BsZWN0UStiT2NaV1B6RG5GNHFLd0FUQXNKQ0pIWFJaNEJKODNO?=
 =?utf-8?B?dXloS3lnUXJwV0dwSGpTcnBBSXd1TGlvaHdkMWdybTZicDJja3gwclZ4TnZh?=
 =?utf-8?B?V0UvNTJKbktoWFBuSTQ4dmpkQUdkSkRMeWtIc1pPL0c2Z2kxQ1Jvc3h6U01r?=
 =?utf-8?B?dUdmS1hjbjlNM1hRWW9Sb0JHVi9DOXV4L01OYnBHeGphOXIzNExMR21mbjJX?=
 =?utf-8?B?aHhNQkNxT1MyVTlUUmJ5MUpmWFJsRDlyYVgyZXgvdXdiQlpFeCtpcm5ua2VI?=
 =?utf-8?B?Q1dmYitBaURLTUFldFA5WTE4OHJBbUJLbXltUGQ2aDZSai9NbEdWM0cxS0dX?=
 =?utf-8?B?YkxnWnEvbWIvekxhUnJIWWk1MFFCeFN6dlRJR2QzQXJEcENjWmhuTTZYUkhU?=
 =?utf-8?B?K0J2QVBaRDZBbi9DdWRqTDlNYitPbmovWFFMQ01takZ0Vnl6dzBCNHZOM2Fy?=
 =?utf-8?B?cWtBempkaVhVQ1dSYmNpc2daTEtJN3RTek9zRmpDYUkvQVFSaXFISmw4TUs3?=
 =?utf-8?B?RHU3ZVhWWnFQRkZRdXpvekNkeDAwK0xHWEt3QUNnU0RZc0dCU0d6Zm8rbEp5?=
 =?utf-8?B?YVY5Q0twMERHL0JBbGJMREJwR2VnVEhFSVJtSmpKQmNlNDZNcVdXVzNlT2xn?=
 =?utf-8?B?dlJKSFh3cTRNOVhzaDIzWDBRSUtpOGljdzVjZFl6ZW5hUDcycGlxaUVKZkpP?=
 =?utf-8?B?YmJCSGRBdm5udVFmR0N4R2NoTUNYTFlvcGlNM243WTFEdFBJQVcvM3F4VGV1?=
 =?utf-8?B?eDl6NDhXdk1JbFFrVUdHUjJKNG01V3J6c2Q1SCtjSFVWTkFjWEVNL2YxUk10?=
 =?utf-8?B?cDdFL05HdnVyMTQ1UEh5OFhDVlJUOVJydVhhM0ZwdFN6RkJndVBDSnZXak4y?=
 =?utf-8?B?MndwOTI2NHRaOTNVeTRpOVFFYkFUVXZpWURIR1A2cGtLZTVFMUpHNUEvd2Ey?=
 =?utf-8?B?eUd5d0xCMG1FaGJhenlDVXVqVkoraGJpOFlVQlg1RVpQaHNmMytPUHl0Slcz?=
 =?utf-8?B?THVrN1ZiQ3BUdXJtcDB2TGRzclE4NFVkK0FNL3ZaMVYyWTNaME85Rk9HUGRq?=
 =?utf-8?B?Y1RrdWlxWVZMYXRtRlRMeStiV3F4UXpnQ3RoQUs5N3ZUN2ZIZGkvVHVzZzg5?=
 =?utf-8?B?M1J1T1ROTllRSUJEKzVJd2FRVU9lK1RrQkRvYkI4NE1oQ2hvNjRYY29aYnhx?=
 =?utf-8?B?THlVek5lSlVoQ25KMmxiRnEzWmQ3UjdvY0pxT2E2TDhUUTUrY2RCNmFGN3A0?=
 =?utf-8?B?NFQzWTJSTUlFZ0ZocnBKQVpBUzFkT05sWmQxanl5Wm5IVmxHQ0d4L1BHRk55?=
 =?utf-8?B?YU1DRUk5MTU3dytpQVVJbHFEcGdsZmpPMVkxeXZ4c1VMbTROckpqRGtLNVZ0?=
 =?utf-8?B?dmpxNFRMVEpqNUNmcEV4eFB5YklWQjh6VUhZbW5BQ3c0RklhQ0lhL25ncTc2?=
 =?utf-8?B?dk1XeXkrWDNnRTc2ZU05WlkvWDlsQWVVTkdqRFlzbXo3WkRUVk1USlpxNVF5?=
 =?utf-8?B?emZtbHEyNmNGM0xseTJXZGxabExSVVFhbnlQeXN1T0dreHdVbUNwdkx6dGgy?=
 =?utf-8?B?Um1RTjhiS2c0TXJOUXZpWkJ1K0VobDJkRjRsOTZjUVpVdVdrKzMxQk5aZExy?=
 =?utf-8?B?ZEo3RVRRbnVENy9IUHhUZVB0c2YzMlhiMnBPMWxzYnZDbG4wNEU0a0prRXB0?=
 =?utf-8?B?bFJqVTRPUXY2eExRMHFGWjJyVkFSRjRKUkpESkJyZVhUZllsZkpEUFRKdzJ6?=
 =?utf-8?B?TExvNEtNd0hGZDA0bkx0SHQyc1ZGQTZ2RUszQlpldCs3SitpQ1lqbHU4dnU2?=
 =?utf-8?B?aERXZXlqY0kza0g5ei9xTUQzTG9yS2QyWVc3bGRMTU5ReUErcmN0bEJPT0d4?=
 =?utf-8?B?cDF4V0VFQ0JlbThtM3FNbnA3OHdMQ2VxSVc0aUVLNVpGOEx3aHZrRHREYmJ4?=
 =?utf-8?B?a01uT2xnSEF3aGJ1bE4ydzlkNW9JVVNPUlU3RnZaQmhDaElXVWJtTUNXUXpM?=
 =?utf-8?B?LytTRVcrU0RxbkNsOENmSG9VK1ZYZmwyU2kwdHU3cDMxNmFhWjRDRFNzQU5y?=
 =?utf-8?B?eGNzRFVGZTV3YTFqSVIwVFJUZlBwUnFONkFBVTdudVRSRmg2ajZBK0lyL3lS?=
 =?utf-8?Q?TE9Y=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(4022899009)(13003099007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZTdsMThmcFB0bjg3TjE0ZHBMMVZWdkVxNjFDcTBDd2tPVzFGeWN1REpRZ2RF?=
 =?utf-8?B?SFdlTGs1Y0t3Q2krVzZGL2ZRVmNHSWFhTXIybTJZRnVGVmJ4ZWwrQnU2b2I4?=
 =?utf-8?B?TjhVRnp6MElQR1N1ZkRPUjZqMDJYS2p2MjQyZk1aSUhiMFlDNjFQVVVjejIv?=
 =?utf-8?B?ZGFFcjhIak5adUZUZkNLTWp5NzZEQUY4dUFqL0RQaWRzVVFuSHJ3d2ROdkhO?=
 =?utf-8?B?cyt4TW5RTFpIZmpZZm9oQnZvN3lFR2tHbkZtNUxqbEFidzhOSzJyNk1wUTQr?=
 =?utf-8?B?K0tBRXo5dG9pRlA4UEJiQWFaYmZhMy9MUmlXZlZXcElzQzRKOElpWmhUMlg1?=
 =?utf-8?B?OTVrUXdFQmRMS1IwTnZCOEJyWjMyb0Yvb1ZKREEwYUVJek92NFNtdUtiTkFi?=
 =?utf-8?B?dGFOeml1MDNLdmF6b1hwcFhhbUJzKytpcVE2Nlc2b1hrOTFRaUlCOFE5eFd2?=
 =?utf-8?B?cVg0VGZxTUdPdWdrcTRsa1NTWnFVY0hmR3gwZXBnMWI1SEVXSWJGcks1RDFF?=
 =?utf-8?B?bjI5MVNvU1kzUVh6R3NmN05vZndpTTVBUkRGWHBEeXNML01MUktrWkVRY0w3?=
 =?utf-8?B?bjkvN3JmZlpuYW5rM3NQQWRvQmhidnEvcUhxNWFlM3BEK09uTGpuSytIVjRL?=
 =?utf-8?B?SC8rRFVZTCtoVC9RRjZhSWQrZFVkVjNDNjhDbEtJV3liNGh1Y2RaOVJVMkp6?=
 =?utf-8?B?bkJ0Vk1yc0NDTUpQZHRqNjB0TlhPWU1yTjhTbTl6cXhKL3lydW4rOHlaYnl0?=
 =?utf-8?B?ckg2Wnc0VExiaEVTUWEyNlNIQ1BQYjVRNWpoa0QrUy82WmlNVXlFc05pODRS?=
 =?utf-8?B?RW9IOGtUcGZsVWppTW9YZlBRb0gzRWtOMkIyWEZkdlpTcHBWWm00MVNHYkY3?=
 =?utf-8?B?cTk4SDZJZEFneVJZNC9zcFRISnNXR1pHNzdBYjdUKzY5UnYxRkdrOERUSDlW?=
 =?utf-8?B?RGlBWUg3YmNMQ1FDWmVJRFJWVG5DVzRzcThMYVRFQXhlL25VN0pibERzd2h6?=
 =?utf-8?B?SWFyL2MzRVkzVmFVNHlsUW1kSW5qRzlYRDg5WGFJdkk0bkt0eis0OTN6a3g3?=
 =?utf-8?B?S3FiY1V3YmdjZHlJVHhLbFAyT3pENURMVWU5cWxBd3d2UGNEQVpHWkNtNHJu?=
 =?utf-8?B?VDBoa0R6TTFjM0RKSVE3SnZIaEhEQzZqek0zcjJCWDFMem9mNy9qejZCQ2ZB?=
 =?utf-8?B?a1J0SmEwU2ovUnZyWnpMdlc0VERJQlRnSHBWUDlqVmVYZXl0RlZTbkV2R1dW?=
 =?utf-8?B?NytqbFhGVjZBQUs1UGxRVnpjZ3ZQQU9CZVFackpDWGxmc0JmUDNpb3ZHclYw?=
 =?utf-8?B?bUt6VGVtYXUvVW5JSVVVWlp4b0VlL1VvQVRBYnRyemw1NWthNi9xaTNwcTVa?=
 =?utf-8?B?N0xLakUyMW5sdUlZS3UrcEFPSURmRHhJa2RXb0R5Q2hpSjlaNmhSbzcwQ0NQ?=
 =?utf-8?B?b1MwRmxxL1hCRUYwTmJ4ZFczaktWMVFuRmJqS0kvNDY1TEI2cU5xTzZlQ3ZL?=
 =?utf-8?B?bzBpTXdmd1UxcVhIcXh5QkJodUJad0VWRWtUMkhEQkY5dnl4SXRkRVBneXl5?=
 =?utf-8?B?eU95eVhOL09oclg4U1hHL3R2L0RxYzJnbys3eEJDMVNGYWJRMFdienZ2TlZ0?=
 =?utf-8?B?b1kwbWdwKzE1UGhmdy9SVDlwV1VPRzBscmE4cmhjYjkwSVdEZGJzU0NrbHFo?=
 =?utf-8?B?SXg4WXFRVGlOOWIrNUw3OHJwdVZJZW0yUHVXK3JUa0JKei9mTWE0dnFmY0xq?=
 =?utf-8?B?ZlduSDVxR2t6c0RsY3VEWXh6aXp2eXFvVlRwcnRtRWZkZTF3U0k5WDh5TFcw?=
 =?utf-8?B?NFU5bXVaSWloeE11ZHRPZGo3WmRCblR0VVM4ekQzb2tvdVF0VlVFUFp6dU5C?=
 =?utf-8?B?TjFsMTUzanE0bHovY0MraVc2elByMHlkSjZLL2RwTGRycXpLbnA5ZGZtWnY3?=
 =?utf-8?B?MlhIelloYmJKQVdUTUtCbG9EVm85eWhkWWd4YzZiNlZWVTl2cmY1NkpjNWFj?=
 =?utf-8?B?OUI5b2JLNlp4TDAzM0pUMmtlNjdWQ1FWYVUzZTBmOU5QRWdRbmxrb2ZPd0px?=
 =?utf-8?B?YnZhdmFKVnRRUy9xR3UxdVF5QVpjaUMyaGY3Qk1QQk9SZUJlcXRYd0dobE5W?=
 =?utf-8?B?UTBwYys0Sy9OeGRlQVBCWEM2ZUNRQUY1cVBrWXBxY0NGQU1FdXMwT3VhME5O?=
 =?utf-8?B?Z0ZaeVNzZ0dnN20yT0RuM3JjZlpMSVlQdWluT0lGbmlYZGJDQld5TnJKRjZI?=
 =?utf-8?B?S1MyWWZic29RcUVmVzFTbG5Wblc1a0VMcVJkWklrNXdoQk9tQUI0ZmQ5Zngx?=
 =?utf-8?B?VEFiQTVveVk3Vkt6Z2xsdEI1dHJpeUo3WkZzblo0QW1qOG96dHNTdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ba9731-a7f7-4f2e-8ecc-08de6105e8aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2026 20:18:33.8978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KFsHkyCrTDH6KQqjs7Pd7LMqiUQ+Re9w7P3rWnNwF3oFPrJT1hUyol0oIAL6sd0RswUN/ki5PO3JhTVwwUDIVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5705
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 31 Jan 2026 20:18:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3157

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvc3MgQnVydG9uIDxSb3Nz
LkJ1cnRvbkBhcm0uY29tPg0KPiBTZW50OiBNb25kYXksIEphbnVhcnkgMjYsIDIwMjYgMTE6NTkN
Cj4gVG86IHlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZw0KPiBDYzogTWFya28s
IFBldGVyIChGVCBEIEVVIFNLIEJGUzEpIDxQZXRlci5NYXJrb0BzaWVtZW5zLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFt5b2N0by1wYXRjaGVzXSBbeW9jdG8tbWV0cmljc11bUEFUQ0hdIHBhdGNoLXN0
YXR1czogYWRkIHdoaW5sYXR0ZXINCj4gDQo+IEkgYWN0dWFsbHkgaGF2ZSBhIHBhdGNoIHRvIGRy
b3AgdGhlIGhhcmRjb2RlZCBuYW1lcyBlbnRpcmVseSBhbmQgdXNlIHRoZSBleGlzdGluZw0KPiBy
ZWxlYXNlcy5qc29uIGZpbGUsIGJ1dCB0aGF0IHdhcyBwZW5kaW5nIG9uIHNvbWUgcGF0Y2hlcyB0
aGF0IEkgYmVsaWV2ZSBoYXZlIGp1c3QNCj4gbWVyZ2VkLiAgSWYgaXTigJlzIGdvb2QgSeKAmWxs
IHBvc3Qgd2hhdCBJIGhhdmUgYW5kIHNlZSBpZiBJIG1pc3NlZCBhbnl0aGluZyBmcm9tIHlvdXIN
Cj4gcGF0Y2hlcyAoSSBkaWRu4oCZdCBkbyBtZXRhLW9lLCBmb3Igb25lKS4NCg0KTG9va3MgbGlr
ZSBhIGdlbmVyaWMgcGF0Y2ggd2lsbCB0YWtlIGEgd2hpbGUuDQpDb3VsZCB3ZSBtZXJnZSB0aGlz
IG1lYW53aGlsZSB0byBmaW5hbGx5IHNob3cgd2hpbmxhdHRlciBpbiBtZXRyaWNzPw0KDQpQZXRl
cg0KDQo+IA0KPiBSb3NzDQo+IA0KPiA+IE9uIDI0IEphbiAyMDI2LCBhdCAxOTo1NiwgUGV0ZXIg
TWFya28gdmlhIGxpc3RzLnlvY3RvcHJvamVjdC5vcmcNCj4gPHBldGVyLm1hcmtvPXNpZW1lbnMu
Y29tQGxpc3RzLnlvY3RvcHJvamVjdC5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogUGV0ZXIg
TWFya28gPHBldGVyLm1hcmtvQHNpZW1lbnMuY29tPg0KPiA+DQo+ID4gU2VlIGh0dHBzOi8vbGlz
dHMueW9jdG9wcm9qZWN0Lm9yZy9nL3lvY3RvLWFubm91bmNlL21lc3NhZ2UvMzY2DQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBNYXJrbyA8cGV0ZXIubWFya29Ac2llbWVucy5jb20+DQo+
ID4gLS0tDQo+ID4gcGF0Y2gtc3RhdHVzL2luZGV4Lmh0bWwgICB8IDEyICsrKysrKysrKysrLQ0K
PiA+IHBhdGNoLXN0YXR1cy9yZWxlYXNlcy5jc3YgfCAgMSArDQo+ID4gMiBmaWxlcyBjaGFuZ2Vk
LCAxMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
cGF0Y2gtc3RhdHVzL2luZGV4Lmh0bWwgYi9wYXRjaC1zdGF0dXMvaW5kZXguaHRtbA0KPiA+IGlu
ZGV4IDliZGNkNDc4Li5kZDQwNzUwMiAxMDA2NDQNCj4gPiAtLS0gYS9wYXRjaC1zdGF0dXMvaW5k
ZXguaHRtbA0KPiA+ICsrKyBiL3BhdGNoLXN0YXR1cy9pbmRleC5odG1sDQo+ID4gQEAgLTE3MCw2
ICsxNzAsMTAgQEAgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IE1JVA0KPiA+ICAgICAgICAgICA8
c3VtbWFyeT5tYXN0ZXI8L3N1bW1hcnk+DQo+ID4gICAgICAgICAgIDxkaXYgaWQ9ImN2ZV9zdGF0
dXNfbWFzdGVyIj48L2Rpdj4NCj4gPiAgICAgICAgIDwvZGV0YWlscz4NCj4gPiArICAgICAgICA8
ZGV0YWlscz4NCj4gPiArICAgICAgICAgIDxzdW1tYXJ5PndoaW5sYXR0ZXI8L3N1bW1hcnk+DQo+
ID4gKyAgICAgICAgICA8ZGl2IGlkPSJjdmVfc3RhdHVzX3doaW5sYXR0ZXIiPjwvZGl2Pg0KPiA+
ICsgICAgICAgIDwvZGV0YWlscz4NCj4gPiAgICAgICAgIDxkZXRhaWxzPg0KPiA+ICAgICAgICAg
ICA8c3VtbWFyeT53YWxuYXNjYXI8L3N1bW1hcnk+DQo+ID4gICAgICAgICAgIDxkaXYgaWQ9ImN2
ZV9zdGF0dXNfd2FsbmFzY2FyIj48L2Rpdj4NCj4gPiBAQCAtMzY5LDYgKzM3MywxMiBAQCBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogTUlUDQo+ID4gICAgICAgICBjcmVhdGVDVkVMaXN0KCdjdmVf
c3RhdHVzX21hc3RlcicsIGRhdGEpOw0KPiA+ICAgICAgIH0pDQo+ID4NCj4gPiArICAgIGZldGNo
KCdjdmUtc3RhdHVzLXdoaW5sYXR0ZXIudHh0JykNCj4gPiArICAgICAgLnRoZW4ocmVzcG9uc2Ug
PT4gcmVzcG9uc2UudGV4dCgpKQ0KPiA+ICsgICAgICAudGhlbihkYXRhID0+IHsNCj4gPiArICAg
ICAgICBjcmVhdGVDVkVMaXN0KCdjdmVfc3RhdHVzX3doaW5sYXR0ZXInLCBkYXRhKTsNCj4gPiAr
ICAgICAgfSkNCj4gPiArDQo+ID4gICAgIGZldGNoKCdjdmUtc3RhdHVzLXdhbG5hc2Nhci50eHQn
KQ0KPiA+ICAgICAgIC50aGVuKHJlc3BvbnNlID0+IHJlc3BvbnNlLnRleHQoKSkNCj4gPiAgICAg
ICAudGhlbihkYXRhID0+IHsNCj4gPiBAQCAtNDUxLDcgKzQ2MSw3IEBAIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiBNSVQNCj4gPiAgICAgICB1cHN0cmVhbV9zdGF0dXM6ICdNYWxmb3JtZWQgVXBz
dHJlYW0tU3RhdHVzJywNCj4gPiAgICAgICBpbmFjdGl2ZV91cHN0cmVhbTogJ0luYWN0aXZlLVVw
c3RyZWFtJw0KPiA+ICAgICB9Ow0KPiA+IC0gICAgY29uc3QgYnJhbmNoZXMgPSBbJ21hc3Rlcics
ICd3YWxuYXNjYXInLCAnc3R5aGVhZCcsICdzY2FydGhnYXAnLCAnbmFuYmllbGQnLA0KPiAnbWlj
a2xlZG9yZScsICdsYW5nZGFsZScsICdraXJrc3RvbmUnLCAnaG9uaXN0ZXInLCAnaGFyZGtub3R0
JywgJ2dhdGVzZ2FydGgnLCAnZHVuZmVsbCddDQo+ID4gKyAgICBjb25zdCBicmFuY2hlcyA9IFsn
bWFzdGVyJywgJ3doaW5sYXR0ZXInLCAnd2FsbmFzY2FyJywgJ3N0eWhlYWQnLCAnc2NhcnRoZ2Fw
JywNCj4gJ25hbmJpZWxkJywgJ21pY2tsZWRvcmUnLCAnbGFuZ2RhbGUnLCAna2lya3N0b25lJywg
J2hvbmlzdGVyJywgJ2hhcmRrbm90dCcsICdnYXRlc2dhcnRoJywNCj4gJ2R1bmZlbGwnXQ0KPiA+
DQo+ID4gICAgIGNvbnN0IGdlbmVyYWxfb3B0aW9ucyA9IHsNCj4gPiAgICAgICB0b29sdGlwOiB7
DQo+ID4gZGlmZiAtLWdpdCBhL3BhdGNoLXN0YXR1cy9yZWxlYXNlcy5jc3YgYi9wYXRjaC1zdGF0
dXMvcmVsZWFzZXMuY3N2DQo+ID4gaW5kZXggOTFiOTRiZDkuLjFlOGQ5NWYzIDEwMDY0NA0KPiA+
IC0tLSBhL3BhdGNoLXN0YXR1cy9yZWxlYXNlcy5jc3YNCj4gPiArKysgYi9wYXRjaC1zdGF0dXMv
cmVsZWFzZXMuY3N2DQo+ID4gQEAgLTEsNCArMSw1IEBADQo+ID4gTmFtZSxEYXRlDQo+ID4gKzUu
MyAoV2hpbmxhdHRlciksMjAyNS0xMi0xNg0KPiA+IDUuMiAoV2FsbmFzY2FyKSwyMDI1LTA1LTA4
DQo+ID4gNS4xIChTdHloZWFkKSwyMDI0LTEwLTE3DQo+ID4gNS4wIChTY2FydGhnYXApLDIwMjQt
MDQtMzANCj4gPg0KPiA+DQo+ID4gLT0tPS09LT0tPS09LT0tPS09LT0tPS0NCj4gPiBMaW5rczog
WW91IHJlY2VpdmUgYWxsIG1lc3NhZ2VzIHNlbnQgdG8gdGhpcyBncm91cC4NCj4gPiBWaWV3L1Jl
cGx5IE9ubGluZSAoIzMwNzApOiBodHRwczovL2xpc3RzLnlvY3RvcHJvamVjdC5vcmcvZy95b2N0
by0NCj4gcGF0Y2hlcy9tZXNzYWdlLzMwNzANCj4gPiBNdXRlIFRoaXMgVG9waWM6IGh0dHBzOi8v
bGlzdHMueW9jdG9wcm9qZWN0Lm9yZy9tdC8xMTc0NDA4MjYvNjg3NTg4OA0KPiA+IEdyb3VwIE93
bmVyOiB5b2N0by1wYXRjaGVzK293bmVyQGxpc3RzLnlvY3RvcHJvamVjdC5vcmcNCj4gPiBVbnN1
YnNjcmliZTogaHR0cHM6Ly9saXN0cy55b2N0b3Byb2plY3Qub3JnL2cveW9jdG8tDQo+IHBhdGNo
ZXMvbGVhdmUvMTMxNjIyMTEvNjg3NTg4OC8xMzM5NzQ1MjQveHl6enkgW3Jvc3MuYnVydG9uQGFy
bS5jb21dDQo+ID4gLT0tPS09LT0tPS09LT0tPS09LT0tPS0NCj4gPg0KPiA+DQo+IA0KPiBJTVBP
UlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1l
bnRzIGFyZQ0KPiBjb25maWRlbnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZpbGVnZWQuIElmIHlv
dSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsDQo+IHBsZWFzZSBub3RpZnkgdGhlIHNl
bmRlciBpbW1lZGlhdGVseSBhbmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBjb250ZW50cyB0byBhbnkg
b3RoZXINCj4gcGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBjb3B5
IHRoZSBpbmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVtLg0KPiBUaGFuayB5b3UuDQo=

