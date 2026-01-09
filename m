Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38260D16806
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 10:43:57 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7606.1767955434738435262
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 09 Jan 2026 02:43:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=G0xXiMNk;
 spf=pass (domain: cherry.de, ip: 52.101.70.57, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+grOP+YrTEMBDOnR34TYtK3bW3C+F/Oyi1lNWWdy5S4CjSMpayF3FYVh1OOrhnle1Cj3j2VtFUlEvj3stlPc2vuPVPYv/BQoo70Mw1yVGpVP8RRovpXCyfTEYxvKM1N5BVx5bsam0KXuGRRYieLeUoaZhDScxS2FcB6gel+jKF7zEJf060K/gpMUvlCz8U5Pdg3GsWScbC1EAkmFhDKLj7v9PLtE6z2PAR1P1uikfOLfx7FZogiPhpG9l9qPzhBghQUSKkLAYVAm+zcHGzh+C9mdIydfMFngU95y45Ccb6P0e34MjkuxFIasxZveUgygaovNVzyo+OuI1QDzgXJXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tMAJmItd/jD7vJbRvIwKlrDC0jTWSvSXQSwg9Iv4ts=;
 b=v4Km9LeBT1v5TuukPMPzpAUIeW+YJaK0feEfnIBHp7rTXPyzEQ2XFc6YOiQKGXu2lCD4x3YedNYo/WDMNF5kRWfry2ShRtp2kaFt6AfvKJI9fZ59SvxxhKLKEmJmdN7yQ6dr5FIoVZN3P+Odt8AApz3QLpfY4ohk9NrXRjSi8NOrKlyfP9pHHK3jCO/w6768dTwRaNf4imuBEAxAlFBRg+Z5m7VWNuAmWdF30e2n8M8HfxwULIyTWbVhi8lIMB7A7xOcDImQxwlhhqvakv4OBq60F5RoYamd5ryuo8XezIbhTaQEFW/RfKKmtPGnK6C9hlkvnhgIYiWKk84dgIxPmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tMAJmItd/jD7vJbRvIwKlrDC0jTWSvSXQSwg9Iv4ts=;
 b=G0xXiMNk3HzNe8iZQUXVBCXghCf1AXXn7zSImtm0YntQeJgZ77I11yJ1oqhMEknOHnUUDo2HlaJx7mO97tg3rv54ksrT0CMKSDLkeSrosHSzlIxpn9i7oFYTWzHKbWuywsxB8M/UVKWFWuJcTAcbnNerwaIF2FOCiE5V5C4lAlQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DU0PR04MB9694.eurprd04.prod.outlook.com (2603:10a6:10:312::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 10:43:51 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9499.004; Fri, 9 Jan 2026
 10:43:50 +0000
Message-ID: <6252df12-2fa4-4ad9-b1e2-e524bbce27af@cherry.de>
Date: Fri, 9 Jan 2026 11:43:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2 2/5] provide kernel
 *.inc
To: yocto-patches@lists.yoctoproject.org
References: <20251221004843.31946-1-twoerner@gmail.com>
 <20251221004843.31946-2-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251221004843.31946-2-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::20) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DU0PR04MB9694:EE_
X-MS-Office365-Filtering-Correlation-Id: bd37f162-27e7-4735-48e0-08de4f6bf9e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RFdOczM1WHJnekhBN0g0TFErNGJtYXdlU3hyZGs0ejlNTlNCMmROT09MRjJv?=
 =?utf-8?B?UzZHVWJHaTQ0Umg1eGUvWkk1NVNuWXExUkFHaGV6b3h4QmpCaElTV2lIUXdm?=
 =?utf-8?B?TmNzc0ZPZVZlL2hTZVAwc2Z3VGI5NHQwTXoyVFNKU1pkbFdKL0ppUUU2d0FU?=
 =?utf-8?B?NEVWYmJHRmd3eTVnSVk3UzhISEwvWFlleW9xV3BnWkVUcXNRdXB3d3phY2lI?=
 =?utf-8?B?TG03VkVlMTE3djFPL0JkVTRoZjdVSUt1c1pjWllCTHQzcmlPRGNJbnpjZ1NR?=
 =?utf-8?B?L2dLRVhocHdWakRmSis2a2YvckVSWkxoOFdKSG0yUWZ6emZITzJTclJOMG1R?=
 =?utf-8?B?aWlucWtlLzhzNGV4czBFeUEvVDYvWmhWQytUbEIwZkFEcTN6K3JoazBGRndN?=
 =?utf-8?B?MmtpbVdoUU1IVWI0THJEM2FhTUdJVzNYSEoyT3VRSTE1b2dFcGpzUWpESVF3?=
 =?utf-8?B?UmJKZ2EySkxTQzlYMkhSb1kyanhFVTFGR3ErRk9zajRaZlhCS1RjOXU4REZQ?=
 =?utf-8?B?TDBJNklXNXJRMjAvNTk4ZE14U0pseFFIZ0RsQ0k4ekFVWEc5U3lWTmxub1F5?=
 =?utf-8?B?OFZhbDNuMVZpMHdaWW1VMGJtOFRCVEkwWnhhWk9US1czUXFQdXc1VGVoVVY2?=
 =?utf-8?B?TjlIb3NhMXZla1EvVDNyL1VsU1k5VzZPRkQ1VFhLZGNmeDF5dHJTK3ZHWEp0?=
 =?utf-8?B?VVN1eVQybmxrYmtWeGlOcks5OTlickJVcWRpQVV2ZDRBU05rVUlYOFl4cFc1?=
 =?utf-8?B?OFU5SExCSzJkVzdmU3k2V0U3bTY1cENMRWl1VUlsaVU1L3AvYjhIbVpwUVlF?=
 =?utf-8?B?RnZIV25mRCtBVkdaY3pHRHNDWkxHU1JOUDNxdFJTNERXajF5eU5qVE5FcThX?=
 =?utf-8?B?VUhhd0o4TW9KY0MxdldSUkxWUDZEMCtUenVoajdyMzJwYXM2WDRzMzI1SkFi?=
 =?utf-8?B?U0pUbCttZEw0YXlPeGdBZDFDVU9oS2lpNlk2Vzk2NnhHUStDbWwvemdKRlZx?=
 =?utf-8?B?M3F5aytzaVhSdTRQRVMxZ3NQVy8yR2QzQXM5Y2QvWUptc0VqYW5nLzNiSlhv?=
 =?utf-8?B?TjNHZHYzQVg3Y1ZRTHkxNnZzRVIwRmNQUlJ6M2hYek8vMVM5K1AvUG5UOGwr?=
 =?utf-8?B?YXhvL3VwLzhycWduNTdnNHBGbkkwa0M0bW5hOW5HUWVwNGdMbkdDbFQ4VS81?=
 =?utf-8?B?NnM4Q091VUYvMEszTFlQajdHNHdKVDZGb2hpL0lxNzViRWtKTnlvWjBnN2Rp?=
 =?utf-8?B?czhMR2thYzhwZThZblRERTVibGdoNDB0ZldOQkhjRlZHM1gzTEQ2NkU4aEhD?=
 =?utf-8?B?bHgzUEJabjFjZTdXdTI5QkNsb2Q4VE94MElDWmw1NTh4OVBITkdxSmNTWjNr?=
 =?utf-8?B?U0M1dmcyYnErNDA3Sm9hTk5yUmc0aWJCd2c3MjdrYzRVaFQzOTVRaXNjY290?=
 =?utf-8?B?TUdMSGh3UjJGSXpzSnVzZ1REcXNmWHZUQTFmbXlpUzAvMGtvaE02Y3BxaDFM?=
 =?utf-8?B?OXB5YXp5NlRzSWNKaTUrVUM3LzZzbjJKQzZETXVDL21lMDVtZkl5dmQzNmVX?=
 =?utf-8?B?Zjc3djlKWDltZHl3Y0d4SWU4MFJhM20zRTRyd1k2R0E4djMycGZxWG5Ca1BI?=
 =?utf-8?B?cVA4QVlVM2NNeWpzZTdYOEd3NHltU1N2WUhBSERpMlFJclQ0YUYyU2hEQU45?=
 =?utf-8?B?R1k3cGt6eTllL1RSaSt2M2pzZVFJbEI0dXJFZTdEK2FVVnNtaG15cU1FSHh3?=
 =?utf-8?B?SnlyaUY5NHJNQUFqeTk1cW44OEVSV1dodjBvTkhhSnl3cnpPQUhmekpPQTJG?=
 =?utf-8?B?Q0lMLytsNi80K0R3azd3ZlFtamxYTlFVZ0NOYkZ0SktIMzNaTmtQdk9JNTVu?=
 =?utf-8?B?UnBLNjV2V3cxallINCtkU0UySkdSNXB3RStrcURDelhYMkRQa21CUjhkNHVD?=
 =?utf-8?Q?Jvf2155i2zYkU+f4ZKA2Xbz8xJzRgA+N?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MWhsYW5jUTF5NEYydHRQbzVtQ05zRkpGTXVRcllLUzVZWVJKRXlkckwrSExB?=
 =?utf-8?B?Y09YVHhQUWM0SWFKakNITy9HakxVdzFvVDVTRHErSHF6WldZc2tqSVpYQ1dO?=
 =?utf-8?B?bTk2ejlScXZTcjhTV0F5RTI0T2QwZVVDUXYvV2FJV2tZVnpNaHhBS2NGWk5y?=
 =?utf-8?B?Q2l1dUZsOXJmSzhKcVBNd0Q0dkJPRTJmQ0VNMEdUeXZMMnZGbnlQbVRvVys0?=
 =?utf-8?B?aG5tWUNydGhNbCt0Q1QvWTU4eUFTcnpCNkN6UGhNR3d6RUdXNHVIM29ZdUY5?=
 =?utf-8?B?ZlFLbEtUZlc3ajh2RDMwM1NCcG51VVhlaUdpN0JBSERsM0gvTkVLaURJejln?=
 =?utf-8?B?OFExUEwvaWp5Mk8xMEpsMncwU2JpRkhsa29KMy84RzlTemNGaUMwdzJtNVhN?=
 =?utf-8?B?NGFWUFVOREwvR3p4ZUdsaXIxUFN2WHdCSTJWTDBLM28rbDdlYWVEM2UzVExR?=
 =?utf-8?B?ZWZDK2JPYzBLb29xRFIyNytnamU4N2ZmQzFOcW91TWF1bmYxdXVYTHA4azNZ?=
 =?utf-8?B?bVpWLzFwTTcySEhRQXNmNFN3ZnZnN1ZUVTE1Ylo4bG1rQ3NGV1NqM3lmQjFi?=
 =?utf-8?B?ajd3ZUJZYytiZE9oZ05IemU5TFRleVhGbWZDejVKRDhxQ3VyWXhvR2czRi9T?=
 =?utf-8?B?RjhiYXFML21iTE5Tejd6cjZUeGsvb2lja2Z2L3dUa1QyQUl1MWxoa1h2ZGlM?=
 =?utf-8?B?T0s1V2NMVUFkTFFGWUFsVGxhZEV1NkVvSldZRzFrMkVYdE02M0dxY1V1Ully?=
 =?utf-8?B?NTlKQlJkdVFsZkFDdDRLSjdBZXgwYWVYSklxRitOTHhkMmN3QnpGVEswM1ZS?=
 =?utf-8?B?b2JET05LWElncERJVFF1bENUTmNqM3V3TjN4a1ROL0ZKOVJYc3lubXR6cUFN?=
 =?utf-8?B?aFBNM1dNeFlPbDlXMkxaRCs4T0dmNDRkSWJlRm5mQVdqd3Z3dVRYUWhKSFN6?=
 =?utf-8?B?Sm5sRW1NaDVOT24ySFlhVjhvVU5Iam5mMGRWR0wxMXNKenVoZDdEajlwQXJW?=
 =?utf-8?B?eVgzSnIvcDZzSmVUTG5HRDd1SUVDUWVTUHNGcWp0cVFRY0dDckFWYlU3dlY5?=
 =?utf-8?B?SjEyaUFkTEdRdHVQT2pxUHBRYXA0VDdwWGFCdG9nRnJXajVVU0tCVG5sSndV?=
 =?utf-8?B?RTNCQVJWeGJnNlZXNGVPS1JZNGRkN3FLM0szTG5rNUVVQjYrd3pLWVhSMDh3?=
 =?utf-8?B?dXdhTkJHZWV6QnpOU1BXZU1xcldHZ3kxTzF4eExFVkE0a1U3QlNtdWVNT1Vq?=
 =?utf-8?B?NmQyZWNXa3lOQWF1OG52Qyt6TWhOUlR2L2JKK2ZrTDVxMS9SazZhdzVlbFZP?=
 =?utf-8?B?UHdQdnZma0FSc0dwcktoRVV2S1hwZU9zZ1VSMmcwK05hRXh2aU1TeFJpNWlZ?=
 =?utf-8?B?L0ljUHpZeE5HSkI1alFCTGlWVWNJd1NvVlNuOVhyVUl6b0p1QWdyeHlNc3Ry?=
 =?utf-8?B?dXJadkQ1Qm5IMFJkUFQ0eVR3NENJTWpINTMvMGR4TmVTQ3Y2WXJpaHBvaWt4?=
 =?utf-8?B?Umk4TS9iRHdRdEtSOEp1RFp6K0lmV1VvalN6QjNCNEgyeUdhd0lacG4xMlhz?=
 =?utf-8?B?RWxYVlpvcWphWDFQN1hDNHJMbm9Sd01uRVArdGkyamVKYUpTd1JJNk9zVHdL?=
 =?utf-8?B?UVJIL09tZGpiTVo5OEUxcGpaOUUwdXZrOTZROG90T2RnbEF6V2c5aXpMeUdY?=
 =?utf-8?B?V3diVDAyenkrYjB1N1p6TGFidjlpVGhZYVpVcjBNb0hUVnc4dm9EOVFpbXdv?=
 =?utf-8?B?UHBOMEc2ZFRUclNHWTZkMzdIbjl5QXU3VUhkV3J3T0RPMlJvRW5vdTdhNTBK?=
 =?utf-8?B?WnRQcTJXQ1JOUEVpS0xRODB2Nnh1bHRRenFsd3JDMnhKeWVkYnJ3RlZPWDlP?=
 =?utf-8?B?Z2Zxb25GcHhtNlA4Y3FUbW5mYjhYaUxIQmhhZStXMndtVUt1Y0pHUFpyTnNL?=
 =?utf-8?B?Nm92dVlUVUF2clM0WFBvTXlhTHpXNFlUVzBTOEk0eUlZRG9Xb2x3RFVFUVZW?=
 =?utf-8?B?TGhYQ0F5cC92MkpBRzdSOE1UVHpTTFlRV2gwMGtyd1FMQlVSOTluNTE4WEdZ?=
 =?utf-8?B?MWVoS3BoL01QRGQxdEhTNUdac0R3ZVQ3Nlk2UWI4aUdhRTFuaklwazBVTnF5?=
 =?utf-8?B?NGliSlArTG5KL0REejFseU9QMlVHaGExWE1NeWxUbHBleXlRMk8wejRUWkU4?=
 =?utf-8?B?UURaRXQwcE81SnpDeTliTVNQQ1hLKzkrcFZ0N3RsN1lKM1VFWk9MQ1ZrNU00?=
 =?utf-8?B?QjZxRmR4WWt6SVE5Wm11YytEdldKUlNTbFozSG5YUHA1WmkyTERMVmk5dkp1?=
 =?utf-8?B?WTVhZUtqV2s1cm9ZMFE5K1JBM0hvcDZLaEhUSmx5eENYWWxWQldOUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bd37f162-27e7-4735-48e0-08de4f6bf9e1
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 10:43:50.6565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+orVc44aI+mAJVEuYMN3RrIvfvmhu5zDN+EB2Rixha4kDveT8SN/oBduqPOiFvVgTAIXAAlLe7Yyp51OMVMV06g5wXOvLw6AEGXrKlbaXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9694
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 09 Jan 2026 10:43:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2920

Hi Trevor,

On 12/21/25 1:48 AM, Trevor Woerner via lists.yoctoproject.org wrote:
[...]
> diff --git a/recipes-kernel/linux/linux-yocto-dev.bbappend b/recipes-kernel/linux/linux-yocto-dev.bbappend
> deleted file mode 100644
> index 81d2b6d693c4..000000000000
> --- a/recipes-kernel/linux/linux-yocto-dev.bbappend
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -FILESEXTRAPATHS:prepend := "${THISDIR}/linux-rockchip:"
> -
> -SRC_URI:append:rockchip = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"

Don't you want to keep a linux-yocto-dev_%.bbappend with require 
linux-rockchip.inc in there? Or would you rather not have it as to not 
give ideas to people to try linux-yocto-dev instead of linux-yocto?

Cheers,
Quentin

