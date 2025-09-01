Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD63CCA0FFD
	for <webhook@archiver.kernel.org>; Mon,  1 Sep 2025 11:57:09 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.61])
 by mx.groups.io with SMTP id smtpd.web11.49226.1756727827403702164
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Sep 2025 04:57:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=af5nqnqL;
 spf=pass (domain: cherry.de, ip: 40.107.159.61, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ma2xdnCg6FwJzkzXv5ZVL6Lfyf5W/ffTI74Uld58YCH/WBmkEY3/Oag7S9nH2RjrG8qIQmNwj7WRxoDonEFD9YT74UF2hUkqe9vIa7m43hmqcbbYXVGRkwl3KztVZET1TktNKQu+nGd2UiUx3GguRltjMXX+TakgKk8/vfU8aHB6+/+2qIo5xt9P7gg3YA61jbe7oVVbBshc7XEdNWAI2qcH3Ky5QXjnYdUcMMbVwsm/cVZz6wvQSobDa85C0IlBl47pfTgFKpMW6DAZFQLW/DC6foFfqtHRoHQDzDcd1+S9XR4PQCjy2BTTvXCADgD08IQwGQrNQz+bUZ2TgCfmZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vcRTQ4HpRMagv1CGW3nCB+cCr31q5sbRa5bVJp31Kc=;
 b=iiJVvS7SmZ/aI6/SNLw0rVXlbK7BJboF76WicA9dMUpi2JokPUmaD7/JpC+2e9iT/CJVxnBke5d9uFsH8e1SCuP6j/juijR7NYIdZk5/OvkEokV+W7wTNCRM4YT+aCG+9C7nXFelBCpPnDJgqq3neTGePnertPrTR369wydtUUyh7pimWe4uxjbS7TgCqzcgQDaREcqs7HNNZizv96FtvPVf73OczIQ0f7P8M622HKC16g4B1Zl4h6TuuIKbEHFkVdbG8i/2UPGgFiaIz0eP9kWb2ocdj8lOYHAjv1VCZAdkYPOOQsNAxPcxN9nxMZauYg/ApPSHCVWmKGvMAD+6lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vcRTQ4HpRMagv1CGW3nCB+cCr31q5sbRa5bVJp31Kc=;
 b=af5nqnqLlgd7YBAD3xyfaWmyfdin5TAd/CvZeT2NZcXDmGzHBLVe/UCp7jdSMI/nhWErA1poARCb/wD2UczQcAPU18wjFrU2cwg1lZe9oxs5OFP33f4DNRbC4bPoCMLRrl2pEZ/F9CKeA97f9uu9836ZqT4KxRA3xEJeL/hvlFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI1PR04MB7085.eurprd04.prod.outlook.com (2603:10a6:800:122::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Mon, 1 Sep
 2025 11:57:03 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%5]) with mapi id 15.20.9094.015; Mon, 1 Sep 2025
 11:57:02 +0000
Message-ID: <d014198f-ea2a-4e43-a773-3f84be365c0f@cherry.de>
Date: Mon, 1 Sep 2025 13:57:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH 3/4] orangepi-5-plus: use
 non -dev kernel
To: yocto-patches@lists.yoctoproject.org
References: <20250831114105.27494-1-twoerner@gmail.com>
 <20250831114105.27494-3-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250831114105.27494-3-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI1PR04MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: b7a38c8c-2876-4a94-d5d2-08dde94ea9ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eGlTRHVISm4rQ3IyNkNEUlhUMkExVGpjaVByYWhmQi90RUlQaUJJY1dUa3p1?=
 =?utf-8?B?cjgrQjFhTzE2a2lGSFBxMkdRUGVtQjZ0V3piRmY0MWJzWWlKalBQaldmbzFO?=
 =?utf-8?B?Rk9EcU9SNW5vVExpa1BscERwR0ZVQm44YjNvQ1ZwblU3Z3orWmxLalZYcmVa?=
 =?utf-8?B?YjNBK0liU2ttTVdFVG4wVWx0dW9CVWlvZjNtMDM1eWE1c0p3NGd2TUxxMXdB?=
 =?utf-8?B?blFRZ3RLUDZVdUhvMytFZGhhWmhlRmVmcU1qZSs1OXhCb05GMHBuOG9zYjFx?=
 =?utf-8?B?TnJaY1ZWdzhRSXVIS3plYkt0aTg5blo5RVlGNW1DbjgrZXBBK29yakRaL2Rk?=
 =?utf-8?B?aEEwWTlibWx6QWRNZk11VWRaRWRUOGo3VHh6bE9jbFQxQWszQ2Y1NWRoN2hw?=
 =?utf-8?B?NFhFSTZ5WGtiTFQ5aWpYVEJvTkNtYmErdEhYTWdrZUZBU3Bybmdwc294TDg2?=
 =?utf-8?B?UUdHTWd2bGpDd20yTUpHZ0hMMGFTb1IvTEJVQk9ibU8xWEwzQUR3R1ZCb1N1?=
 =?utf-8?B?TmxFeXA4cHVzSmFnWGx4RDVDNnZlRE9lMTFOU0NtTlJRY3hhSGl6K3ZXYnJn?=
 =?utf-8?B?TlAza2o2ZXF4cmF1ZHlvSzRycGRXTnFpZWRKdUJBWHUzcTE4SzkwNzZSWjYy?=
 =?utf-8?B?MFFsSVRKSUhaUzdndkZFbUJYd3Y5d2pXckR4aDdqT2VnL1Vmc283OUNvbm9T?=
 =?utf-8?B?RTZmUzhlU0U4dTFHS3hJenJiMkRXVFA5Qy9tK21sTnZhWkxUbFZZSFZWbU12?=
 =?utf-8?B?V2IzK2xxYllhc3doVDdlMk10ZTZFYXJ1aUU2VnZDU2JyVWZNZkN1SDZWQS93?=
 =?utf-8?B?djQ4anVONlRNOGRHTXJaajdGa2ZheG8rN0lGOTlsZE04VVFqMkwvbVZPNjZn?=
 =?utf-8?B?R3pqYUdmMGRaUkNDaWs1TFFZT0VuU0xSZS93enhYTElFWW9qalpYYlV4aDRC?=
 =?utf-8?B?ZHFpNmJJRUp2LzVFZ202UkpPdjZHc3oyK0lFMzhobWc2R00wN1BsaGdhWnJD?=
 =?utf-8?B?bjMvbUhRTXNoK01BUFBOcWVqZzVRNmU5OFA3Ynk2M2RNT3pLZUNaU3A4Y2FM?=
 =?utf-8?B?cU5XTG8rdnNScHNvMlBlV1hrZytLNFhFbkFxM0t2eUlUaWt5V21NTW1NV1d5?=
 =?utf-8?B?QUVaQ2x6SmNhc3pjZG5VSlg5U0NSMkMvOWxqL2t1d1hsUkN4d1h6V0ZNSGEw?=
 =?utf-8?B?a2lXQjJvSUpsaE1kQW1vWkh2Ulg4K0ROUXFXdGQzZGdWUkh5bzU5T1hNT2lm?=
 =?utf-8?B?ZUlrZnFSRHhvcHd2MmYrRTRnaUdNdnQ3bnVhSldLSExaU3BnWW0yRHh0UGFW?=
 =?utf-8?B?bmhLeWdreWQydStIbFBKSExCT2pBWW5jRG1RazFIR2lYbUJnaFNUcG1OSHVI?=
 =?utf-8?B?cHVacXFsckJSMGhPblRXZzA1aTNzUEFjRnF2S3NNTUhNeC9OV2VHMjE1RzZs?=
 =?utf-8?B?ZnRjTlBIMHpGYW13bU0rVjREM0hteGhDNmMwdU5jMFpFbjltVWVUR0VXeGo3?=
 =?utf-8?B?UVNIUU9YeUZzaTBWWml6REI0NmFYNHBmSjdkRklnYzJYclk5UjZCekYxTkcz?=
 =?utf-8?B?ZmRselo5RU45bXQ2TGZPaVBCZ1FVOUlVeXRYOGQxaXVUblRYOC9GN2ZlY1VL?=
 =?utf-8?B?WkM0bDN1OWk2M2ZsQlVaYVhVQzZhWUJHSXJtUGUrei85eWhtS3I2QzhaWDBy?=
 =?utf-8?B?OEVGQmRna3FPbFc1MWVKeFdCeEdBS2cycDRpUDFpNnB4RG40UC9ENlVhb3pG?=
 =?utf-8?B?RlpHYjloT2R5NUxmRUpkcHJCWGptREpCSW5hWFZjUUFzeUZITTduVWVPV3kw?=
 =?utf-8?B?UWRjb2VvdHRON21nTzZGMWxGdy9QaGhWWmpVNlBiSElEVU5CTExobHA5dEU5?=
 =?utf-8?B?VHR1enB1WXMvSWEzWDBncVlXWHprVW5pSzFYQmFjT09WdkhyekQ3N1VrZDJV?=
 =?utf-8?Q?uTBGJR3BpI0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eWEvWWI4QXQwRjBzUk5JV3lsdnA1azhYR3YzYjc1SUdNY1phTHNGWVhpV0Q4?=
 =?utf-8?B?b0tEdDhxcGx2eGdOVklvcm1uWEo1cUxPcHd4TmIxVWtpMGtHK0dWS3ZMczRX?=
 =?utf-8?B?YVl0YnI1SjJYS3NKTzdxc0RKRXZzdU1Na0hUUTNHM3ArME50QWVqc3hsTlZR?=
 =?utf-8?B?aHRTcU1OenIweWtzTXpHV1N6UzNaRmhZSFJBZzBkNHA0bEw1aVZOQVJSTE5o?=
 =?utf-8?B?OTJObG5qMHBLNHBaMElxR0lXNjJpUzBwNm1qTjRrMjdWQm5id0N4VFNEcFZl?=
 =?utf-8?B?YVp4bW13YVFaVHZwem80V3NqNHpkSk5ENlJJdUNwQnMyM1JMSis0bnpQMkpW?=
 =?utf-8?B?UEd2eXY2dHBmR0hRWGZvTFN1VVhrQUc1RlM3QndJblh4RURsUWI5U1d5K3Bv?=
 =?utf-8?B?K1d5a2JNeG5JL0lNOEhjekZvbmczTU5BaVRZeUp1eTVmL3U3UUNLOUtPSVpp?=
 =?utf-8?B?M0Q1QmhtS1MwV0swY21GUDNDclhGYTUzcGhVMUtvTHhMclIyUGJaWDJuUlJi?=
 =?utf-8?B?TE9MSkFIT3hHb2ppVU9HOUVBVkM5S1g4THpnckVHZXg3eUtiRmZUSm0rWEcy?=
 =?utf-8?B?ZEdRMzIxNHlWSkRGdnJFb200VktoU2RPVWl0cU9nSHN2TW1velk2QXVDUDBU?=
 =?utf-8?B?cU9HSW02TFlDemRwT3RyUGZhUXk5VjY5SWpmTWl2a0Vwb1ZKNHZBUnBKb2ZV?=
 =?utf-8?B?UzdwMlUvaUxUa2laSjJOUHozRWJMamtHVE9HdWZnTFB4ZHF0aitsVEErU1FY?=
 =?utf-8?B?b1pCcmVqMmF4RFJGUHBOMEhOUzZId1lCQnBkTEp5UnFvNDlya0MwZzYycWI5?=
 =?utf-8?B?NEczd05NOXliSFVOU3E5ZFJncDNOUzZXY2lHMC9VZHZXSFlGbFFnemFnUkR5?=
 =?utf-8?B?YXdERWZBTWx2QU5lTis4VVp1ZHlUbmFxTzFObWhtalFrTG1vL3lVTnNSZ0x1?=
 =?utf-8?B?RVFGTkhvS2hqVjdPSEZiYmttOHM5SU5MVEMzdzhhMmFYN2JxODBiL29NMDlk?=
 =?utf-8?B?eXdlbVhMOEZJMCt1RXZyaEhLdVk1WThTVGtBZmEvTTM0WTAxT2MvY1lHWC9H?=
 =?utf-8?B?ajBSRDVSWTJPT2FNd2lHSmxMOSswN2lFZUg5MzZFZ3ZveUdnTDM2elMzZkkx?=
 =?utf-8?B?dDRQeHM1QVZ5Q3dYc05iUXZRWnJKbGluTUE4YWxWRU5Eb3JJQjNockI5Zi9v?=
 =?utf-8?B?RnNpeWJJSm5Nb0VIUlpyNWtTZWoyQVNHekF0dmxwT3NrMUw2dENLbmREdnNJ?=
 =?utf-8?B?bXI4R1RNMU9nanpMNFZyLzkwMFI4THpZVUNiT3NkL3VCbEpIbWlSeXMzQkds?=
 =?utf-8?B?ZzI2U3lpdHBGK0F6YWxIQmFhd2xQbzRiMnBqaURIWjZOcVZNYnh4N3ZIcElp?=
 =?utf-8?B?VXlUR3c5UFVKK2Q4b0N4UFc5Sm43K3hPdTJueEpnbmZ1UStTMzBRK3pXY3Yx?=
 =?utf-8?B?YTBzT2dGVFphQyt2UlVpYkFNK3BLZkw2UldpWEx4bHVMRzFlcG40ak5STkds?=
 =?utf-8?B?alY5VEhmNk9SdFJieC9SMU5GRjliU01iWlY3VXNuaFZHaGpWQ1pCaU9VUjFX?=
 =?utf-8?B?VXhSc1gvQWs4VEFDazdEZ2RvTlUyQ1NpZnA0SnpJMUl5c0R0SU1MYjBjS1Ry?=
 =?utf-8?B?dlRkeXRyblJkS1pEZVk0OGFrNUNkdXpTVDJzS1ZhMjVEd2pjQUdoVzk4QXd1?=
 =?utf-8?B?aGJWV1Z1YkJ1c2tINDhRUjVvVGhWRDVNQ294dXo3QnlJbEc3RUg1YTlKTEFC?=
 =?utf-8?B?dUw2RW92S283RC8wTms0alFYYUNtbnVwTW93alZFUUFFckF3cnBqU20wY2pL?=
 =?utf-8?B?NHFIY0RUR1IwMlJpTGc2MjdIRUxWS2l0Q3hhK096VEdyTzRCcmVZS0xwZGV0?=
 =?utf-8?B?am1JZHZkYU9GZHNFdnpmQ0xhOW40dDl4Y2RkVFVISlJmb1VjT1pHc3EvYkkz?=
 =?utf-8?B?bkZKYW1EVDNkVkYvSTZCZTVUVEc5S0RFNXdYZk4vTkpnWFBCRmpMSnpVWlNt?=
 =?utf-8?B?U0EyOUdLUUllZ0k1ck8rb0VnOExzYmhMMEowQ21GY21lZkZkL3k5U1FqRDMr?=
 =?utf-8?B?YmY4dWZsdlBONDVXU09LZkpCVUZ6Rnh5cDNoUE5XNnlJU1dIWUtlbXU1UVcr?=
 =?utf-8?B?NmxtWEg1dEg0SVFKOWhDVmdEVEhjNEFaMk1LUlRGZlZISnZmbWZJYXNnZWNL?=
 =?utf-8?B?OVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a38c8c-2876-4a94-d5d2-08dde94ea9ee
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 11:57:02.6385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJCB8TuyuUWOx5AeaBq+p86Huz/LQInYZeeNz764o/ExeH8xc4Uua5jF7IqgTXds3SLrD4GNgH5kyo0C21+WRrkkAmraY5pNLim6tF+3Rjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7085
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Sep 2025 11:57:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2104

Hi Trevor,

On 8/31/25 1:41 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> Now that 6.16.y is the preferred version of the linux-yocto kernel, the
> orangepi-5-plus machine that had been using the linux-yocto-dev kernel can
> be switched to using the linux-yocto kernel instead.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

