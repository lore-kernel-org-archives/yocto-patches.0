Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586C7108B916
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 12:23:40 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.23])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11341.1774009418368793413
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Mar 2026 05:23:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=TbCk6Kgd;
 spf=pass (domain: cherry.de, ip: 52.101.69.23, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHbYfLtMP6IvibRN9DBmNdB7/toeVUVq9rDv7OK1wpIwNTp/R6S0M0T+gxVIXl/sQZktFurd/x6WBwmpy6fVLmsy8pQ3L3MGd/4h5SmK4LGZXMGVnxDC1V4OwEiWXP5jlvY5nbAN9bs+GEKXKV3a01sPbMMm+nQAr/tDY65MMgRuw+Z6xSFVidwzbxvsOhnlXQlNpGXdUlwx35JU0cxBMrF1Auutkosx/jrIPr5xQerXWIpnz7zggQlGAqh3Dh2gD45IsyVfck6eUF/srxKtbRprLkuwXYrylQ6W8Lv9/TH3AgOXb6+E+Lcn7d73pLLOMHhDxhD82sGZCnlh6K5mTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44jL56Ev9spZFgvs1UtGU/Rana0/nF6SqBfRfvMHLNg=;
 b=VMSS6b3QqLkTB9ytuh4xqSqlB1ex6Dy+LJBqXtVGky3Vz18o1A6wvOGIz9WpZGJEFtlJZs087OnV4oxGJcCUYoxLznd6SmjpF0et5MJQFgIE89WKGsSxIq3tLLlUe96bLTaIIK4s9KmRChsqJA3DAHVIaROn6hmyD1tuFU0/6mdU6ME13erFCgbjI7IxXiQQbD8s2K0LyCUQKljeukLontb+fGCGymgeT/wgQVf7Fz/ANFkBrcLa1rUa9+9rOSvn9mIXXUF3lntDXt055dJAcqGQyCftWMwopXeA0ib+00668UlaiJMxz+cgOjXsBpbo9+Aj5H+fJW/IEptHvRFXEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44jL56Ev9spZFgvs1UtGU/Rana0/nF6SqBfRfvMHLNg=;
 b=TbCk6KgdXHIOXyuM9ZdhKN13Qb7WjcEJCeZYhtcbt/h45aJXq6zpnDk6G5j3ni3qshTEA5Y5P53LKFkyhCzMRE/8+tQijtgGdXBaMOKIUP0qKEBASGzRnPjLGG8tXFdSJ8bRTALB9WP3bgi+HipOa1EZnojkdKu3i2ECCd9hf40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DU2PR04MB8839.eurprd04.prod.outlook.com (2603:10a6:10:2e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 12:23:24 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 12:23:29 +0000
Message-ID: <136b7630-e68c-4e0e-a3c6-71386e092c24@cherry.de>
Date: Fri, 20 Mar 2026 13:23:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH pseudo 3/3] Add b4 configuration
To: yocto-patches@lists.yoctoproject.org
Cc: Paul Barker <paul@pbarker.dev>
References: <20260320-some-fixes-v1-0-f5ca33dbf180@pbarker.dev>
 <20260320-some-fixes-v1-3-f5ca33dbf180@pbarker.dev>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260320-some-fixes-v1-3-f5ca33dbf180@pbarker.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0390.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::15) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DU2PR04MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: 5901df08-ec13-4571-d6cc-08de867b7e16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	r3IXL2uGwuBnzdx2sUK7DR6L2wUH1mWBHD406hIGbotQ6A+BQRzwRfD3UVuJI542Z/RsPG1fsKALFoI41e5A5xuACqMpBAdY7ZGEL/IUDtJaIn+4cLF4bBqMktzKvDLk+vZVX+Du01agFgebV84QH5kYKnEahKLh+H4lgZJWVOiLwuWsPSyJwJsvrxvDgvRNbdCECipJURyoEtF2hdEtCuagPimZRgMTZCitX38n5J8oL5exNfxxWy1i4l/of2ZcNiEgT17K/zYmwwAUCS1teu7qevThrF1DvCclDjDgmIdyGPmiHlYbErYLkwiDNryQFRCRAe1YEPTyci9JUu1QdjrIpUgoC5v4Ufo8J6P7PhA1aKjp8FMBswYIHk8jJiFCR5Ugm64KSq8CrA6IPuYKLL1iNotbQB4kBiGHp4/7lHHf6YnuilhjziczVhgZOA5VjkWq5qtIoDgIB2NI1TBW4S165MsPOOELoBaex7kk37GkEQERRUf8z+yp+htkDXopL6JgeEfEz4Po89N6d+in1z+QURzl+AibU3vpJe1Yz3tupr7yxEj176xF8HnxS8/FTTpwpQ8fB8z9nS5pB11XtGLQ1w+OWjeDOf8S7vwkEhsCeSpIhBYSc6OnTUKvwC/NHL5/rjs0Y7zObAcIHIHfin/Ki3m4scC8xCmXpIkQLqVX48AJp/y+P2kq6iDPlF/nO1ldcf3MJlUylQD3rOW6V939yQ9Sd+rdrM1aaKmDUgg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RFA3cU90U2lOQnFPaGpzL3hHaXpxaWpHS21NRGg1WmdrTFBhM0ZmcHN2bEp3?=
 =?utf-8?B?bHUvSk1lczZsQUJQMUdsdFNLU0RVY3lpTFBpSFNKeXBNb2JpaWV0MnhmK08x?=
 =?utf-8?B?aHNNVW5hMFpUeDdwemVGZTZJTE9jUXRJNlRneHl5bER6a0l1WDcxM2ZjN09B?=
 =?utf-8?B?TDBXYmlpUFc3NkM4NmZ4ZUhVZXVkM3lzN2NJYkxveGhhMEc2eDRmNzZEd1J3?=
 =?utf-8?B?RVJsdVpqVG8zZ2ZodEI2d0dBWU5nc0UxVzJWR2NPRStIM2tvTUw4UkZ0elFZ?=
 =?utf-8?B?cGNvRWtBa2RNZ2hLd2ZRdmpRVmgyaENrSGpncWpvRzQ2OGUySC9obnVrQ1dz?=
 =?utf-8?B?QlhtNmcyL1RCYkhvT0xPcWxXdDJzNVdKNTJmSVRGZUtrS3JlYkgvQ3RXMnlE?=
 =?utf-8?B?U3dYb3NDSlV1WXpxWnc4Y25TVWhkT0REN3pBdklLL3o1R2VQZVQ5b3dRbzV1?=
 =?utf-8?B?dWI2K1JGUVRRbVJTa2UrdmszRTZjMTd1dXhlckx4bDdDcERYdTJGMGlMdWpX?=
 =?utf-8?B?QVE0VkFrYU42UjkzM3BzZW9WMnFTNXI1OVlkcVlvOEo2ajZPV3ZmSnJPWStP?=
 =?utf-8?B?b3pjazhBSnBsZm1MeDByWTFac1V3dytIYWJ1aXJSNTVnZS9hZVZMWHR0SEo1?=
 =?utf-8?B?amVaejJCOURrMVlveW03WWNZd3kzVXlqNzg2V0xUR010b3lxTVpSK1pYaUhQ?=
 =?utf-8?B?N1pIWFRXcnNMdGRpR1ZkY3Bpc2FQMi9URFN3YWdMYXFsSExvWitlekQwOWVu?=
 =?utf-8?B?ZmhQSG9OQ3l4a3JyZFJ1cksrc25KcmtwQW82WnZ6MS83WjF4T2dqOWJhaXdY?=
 =?utf-8?B?OE9LZkx4bHpqc2d1QzhLRHZhNU1GQTZ1Vnl6L1QwVUpFUFZEcUJtZXR2cGth?=
 =?utf-8?B?YUxVSitxZTJucnFtQlZZL3VjWUY2ZHQrS2JHdTlUMDc1TEg1TXJDSFh0dExT?=
 =?utf-8?B?U29UL3N1UEJhUEovbVlFOGZpbE5pNEZjQVdPVkpBekIyd3hCd2kvZUczNjF5?=
 =?utf-8?B?TkY0NGNYZlVrSTVkRVY5TkJTWTJzU2IvZElVaWdpeWpnNmhhd1kxNUc5WFdG?=
 =?utf-8?B?bnJjWU5COEV2NG1uaUcvNU4yTXZLTE1meSt0Nkg1VFdrTTJDL2o4QlZ0ME5v?=
 =?utf-8?B?WVJ3K1htTXhNTVJTTUkyT3FPbWxKTjlkWEthNERuaGlKK05DZEw0WlEzNlc2?=
 =?utf-8?B?ZlBsK0J1SWNVRG90QW5iU0Vld0VYRXZxMWNab1VxL3JUemVHVnU2OU5TaVls?=
 =?utf-8?B?THFCdFUzOFVsZWp1QXZ1OXZORjRWZXMycDBYQUFJUGtPa0VENE9QZ3o3Qmlp?=
 =?utf-8?B?Y1lNZ203S3Y4SXIyUWtIdHVZbExVWEJOVzFMTDkxUENmd0pDR1dqRm9oZjZp?=
 =?utf-8?B?MWgyUGg3aEgraks2MncwTjhiVGdJeHozT2xQTGpiY2xrRWU2NWVCUmxzMkh5?=
 =?utf-8?B?U0hCdmRhYTFWUmorOSszU2NxU0VJYk03NXdLZ0hQaFc5WlJ6em1KNmpjVDdV?=
 =?utf-8?B?M0VlbkExbFFaRjhwRG40eVBMZ3FLNzdjclZwT3JKblczRTBiYVBQR0xZdVRJ?=
 =?utf-8?B?Nmx5dmt2ZEJqOER1cEJNdkcveFE2eG5zQys2ZmFoVTgwT2tYY24xdU5XZW9V?=
 =?utf-8?B?d0VIQlJxWU9ETTlxaEl6bVBHS3RmUVRRZ1JNUUxIRXBnRmJvVlQ0WWk2TWxI?=
 =?utf-8?B?VzUzMVMyWWZObHg3UE95WUQvb0FOUU1oRzNvMmUyZFE3dHpFNDdYa0xZUUlr?=
 =?utf-8?B?bm9SaktxcTg0UTlaMUFqUHB5RHpReXpSQTNsejRGZG5XNndOMUlTMVhieDdz?=
 =?utf-8?B?WlFnQ3Yzc3oxcTFUd1RJTjhOQVg1RnBGaVpLTTExbks2bXdvRHVuaFdmbmhh?=
 =?utf-8?B?Mmc5MFpGNDNOQ1o5NXQxMVYrR1YwKy9tRjJ6aExFbXdRb3JSRzF1dXc0aDdJ?=
 =?utf-8?B?d2RRdExETnJIWGhIN3pvQ3hzemlWS3hnSzhWOXFRc0VNa08vRGd2dHh5UXdT?=
 =?utf-8?B?cXJXcTY2aGJ3eklCL3R3WWVYWDc1L2hMLzR6dzhJRnBwYVg2R3FLOXRoM1p1?=
 =?utf-8?B?dFFRNk1ITDFBanBsQ0pZekJ2S2g1blpENElCcXVKMVpJb0poMVp1amdVcCt1?=
 =?utf-8?B?OExTS2ozMWh4Mk1HakZkSU1mdW9JbVk5cFZGK20wWlcwZWM4ZEhIdVhsL3Jk?=
 =?utf-8?B?bUtKSGJ2bHgrOWRqbitVeEtvVnV4R2FvYVJpay8zUmI3T3pIR1pvMUNYbm8r?=
 =?utf-8?B?eFRFU3N6TExrNDV2d0oxV0h1R3h2WVZHZTYrSnFjbjE0MDlmSnc3eXJIK1gr?=
 =?utf-8?B?cmNtamNIdFRhRTRMa0ZTQU1Ucm1SMExyMHJNTFo4YzN1MU1mNWpvdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5901df08-ec13-4571-d6cc-08de867b7e16
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 12:23:28.9309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RoR1rMcFbjAcWpWzrWiOI3zHLKUt822OaTL3aB46W3P5ER9A3yo71PCDhqeuybWbOTTh/mOA/44hLffSRgjo/nKRyrOoQ+1U/KrA+Xe0Z4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8839
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Mar 2026 12:23:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3528

Hi Paul,

On 3/20/26 1:01 PM, Paul Barker via lists.yoctoproject.org wrote:
> Make contribution easier by including a .b4-config file, pointing at the
> correct mailing list and prepending [pseudo] to patches.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

