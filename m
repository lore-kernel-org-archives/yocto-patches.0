Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B837CF9C72
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 17:05:17 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.17])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1640.1763658305599660048
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Nov 2025 09:05:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=nxUP+309;
 spf=pass (domain: cherry.de, ip: 40.107.162.17, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l26JQfK9QmrLBAZGkyysXOPTDV4diKN63kUBONSQ901JLklNX3+Q/D9uKhKKnuF2H9R5/F9k1rJqPYoyCu/JdoU96oD2PQB5wbFdhM8VNPkhNKaKMe9BLCupmhAlaDlkFxvOsVN7QBZlnyp/e//muKozQDG/uJhwxymTYYl2DtsaWeEBqETwJXsQQJR8EQiTb5SgPnEo6MsAXb+XaCUA+zoB0mKit01XxSTfNfWsEV4AQen9SBjI30nGj8fIUn4mfsgVCNlsw8ZohQ49erQcUjD06c16FIEqnEqoWGOZBYRefx3Ns8cLq5YtnH3WbKF5TTNzcGlYJF9jP+bQIVFULg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYAV0z9iTwLnsRS6nG+GFMgaFkGOIN3b8y7c3xl1nyQ=;
 b=ofEQgjnUbuFgS8WuTevLmoYsLxd43IIAGdKucz0THjGJ6rxQbTcoytKEzTxwY8yHlYtnVmY9jW00tlGT8kHPe9ALu0/9mQMJX4BkStoD7rgb0/M+NJGm2ndR/dEjUb91r24JCiOYLYnTzZyqAmFAWDtMKPs4tGn8gDYHAEgHQNAQocAooz4CP+Asr/Jf5V+b1MsFO3nnRaas02j2LEUX2sNj9eOKbpCGm/2A5kBUbrxg/S4oNqDk0tqLkWohDx7BDPcYv/XjzL4MMXuJUxfUY7Tj8U4A9Hi7j85YtD6VY+Lry6YCAVq7Q3GyW93z2af83r0ANgE7bHBXf8X0juJZsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYAV0z9iTwLnsRS6nG+GFMgaFkGOIN3b8y7c3xl1nyQ=;
 b=nxUP+309bma+bGVeJxI70ea5zpUUehpHjY6LapaTzwv240CzPiLruOVKwn+VcJesNsHGMkh5be0F73KhOawZjQCOgaef/j21lL/umJlpPQnLHaaFzu+dNnfB5U4BrTT58n5+z624thgakJF0RtGqnM0RMWRXkBgsnORPCj2g+o8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI0PR04MB10807.eurprd04.prod.outlook.com (2603:10a6:800:25a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 17:04:46 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 17:04:44 +0000
Message-ID: <9dba7e1c-906d-48c7-a8c0-f6348c211834@cherry.de>
Date: Thu, 20 Nov 2025 18:04:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH meta-rockchip] orangepi-3b: add
To: yocto-patches@lists.yoctoproject.org,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: michael.opdenacker@rootcommit.com
References: <1879B0158049C4B6.1423420@lists.yoctoproject.org>
 <f176e971-d19f-47a1-a591-d2a501d16079@rootcommit.com>
 <58102c94-8c32-450a-bccf-1edd16bbad3f@cherry.de>
 <20251120-petite-copper-chupacabra-c70e6e@lemur>
 <ae649aeb-d73d-4d51-8f69-cc6a2c2633fb@rootcommit.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <ae649aeb-d73d-4d51-8f69-cc6a2c2633fb@rootcommit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0201.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:89::7) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI0PR04MB10807:EE_
X-MS-Office365-Filtering-Correlation-Id: 1155a107-9bc6-4c81-82ee-08de2856e74f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?d0VScXUrdkVUbllJNWIvRjN2RDJENDVMWGFnM2dpSWNoaWZjUk9JbTJLeEhs?=
 =?utf-8?B?QVRlWncrTTU5WlZQdk9laDVPWTdDNDV2Lzg0NzdKQnFkSzA4WkhIQW5leDB4?=
 =?utf-8?B?TkdZYVN1cGFqc2NwRDFsQ2JJYS85Zi9xUkVTemZHekk1a2FlWmJUL3BUWm9u?=
 =?utf-8?B?cmtRSFI0cW5QRjhsa0RsTE4rcy9idVBVMW5RbjlmOWd5UXZFN3lOU1c5cHBw?=
 =?utf-8?B?NHJ4ajY1QmkzUTBkV0srdEo2aWZxWGRLdElsUllPTk1VYWpKeUJrU0EybHIv?=
 =?utf-8?B?R0NZTTV5UmNoZzJ3am9EY2xXNk9KdzBBOUxMU0l0YmZhaDdsbVNCNEozaVNX?=
 =?utf-8?B?am1SOTJyVGRnVXpFS2k5YjQ1MktPVTZ5SW13V0VnazJKUC92bGE3STc3YlJj?=
 =?utf-8?B?QmltRDVieFBqdC93eHBwSVpVZ1NLZ3lRNzQ1NW93RTRydHhueXlJUkIxVXU3?=
 =?utf-8?B?MzRsRTRWdXNIdFgwZTZCMkpiSm9TZ1UxckhBSHJjUkdjeVlYOGhUaVlscjlO?=
 =?utf-8?B?WU5URlN0V3hSZzZKemY4TzJpcU5TdVhjaENYcFpTUTB6NUhXdjV5T2JMc0xV?=
 =?utf-8?B?L1ZVQzhBbU50cUtielNYWWt1aVd4cm02NkI0QlEvYVFGYTR4eTlxOUdPVWUz?=
 =?utf-8?B?aFpWQUIzMjQ1cmYyOFlid1lGcWJSUSsya2ljWlZNdW4xVzN0Qmh2S1BaL1BJ?=
 =?utf-8?B?N0FQUnhMVW53ckxEdmprcGNQbVU3Z0tST04zUngzN3paSmJDa1oxczF2aTZz?=
 =?utf-8?B?anAvazdIZjM4Wk1la09panU2djBEWVQreUVDTXZlS0Y4U09uelU0NzBnaDRk?=
 =?utf-8?B?WFd4ZVlSL1NmSHZnaGVITXRxR0JXbGFScks0aUNzQ0E1UHJmL290R1kweGZO?=
 =?utf-8?B?eEw1MDRsdmgvTitFUGFPa3RoVTRuVEQ2SDQ5anRiL0l2bUxyZndDYkk3Umwy?=
 =?utf-8?B?TlhYaW0zQXVRSWRyL2xoVTVEeXVqbEh3MEJiL29pWTU2VmZ3ZnYyTUt6VEs0?=
 =?utf-8?B?RHJTbUJ5RG1KQ3kxZEdvNE9Sa3BkOHpjVWdLaEVFeEhzdFI5VzcrVnlocjFm?=
 =?utf-8?B?SUVYbHJTUC9sT0tJTUxNWi9PU3dpNCtjTDBuRThGRUlFVzJHQndGdWZGTXE4?=
 =?utf-8?B?ZUFnRXdFcWVza0lBNnZ3M1lTbnBnNS8rVHJDUlRnV0VVK1FlUU1iTVdqdWpq?=
 =?utf-8?B?bDN2N2d3Zm1sTmE0OG15eWtaVHhBV0haYjZmR0UrMndDMng1LzlCek1QejBO?=
 =?utf-8?B?bkdpVmwvMmpHNGVXcUF2Vkt1MVYrMm5KdEoxS1NnYitDdFZuWEViOWtxOHBs?=
 =?utf-8?B?N0g0U3BEUGNRVG5KNDlBNEVsUWg5MERaVzd2MHU0K1FWQlc1MkNHdUI0OFVJ?=
 =?utf-8?B?eEVqUTNETHJiUEN0RG03L0dsT2R4aktLbjVDSTNnaDUwQUNDVS9tTHE0M3pr?=
 =?utf-8?B?bXMyR0YrcHM1Mmh6SVc0MDRHc0ZrR1R2R3JCYXpGUHBCNmk4T2pZbENIRVZV?=
 =?utf-8?B?WXV6eXQ1UFdEMmZpM01GS2NXM3djdWlBRE1VbFllNGhVRjJJZWZHaVdMeVJ2?=
 =?utf-8?B?NmY1WXRveTZjVC9ZRXhyQTN5WlF6bzVEZGRlQ1VKd1U2anRHa2FLM1E5VWlY?=
 =?utf-8?B?SENhYlZWRFhVS1dVTEFDM2M5YzN0UWhKTVR6QUNZZE1IWHdaV1dlcllpaWQx?=
 =?utf-8?B?RXE5dW9oakVXdWdOTnQwaHhITjE4UXRtdmt4MllpVDFZQ2UrMlhxR0JTdmtj?=
 =?utf-8?B?ZThnb21xWERGU0FtOElySHY5REhaeThTU0tNTWgxL1JDR0pWRGY3NldVcWZo?=
 =?utf-8?B?U2luL01QK3prMHBWWkx3M3dGcGl3UXFvWlI3N2Vxd3pxN1JFUkxHeEVLUVBT?=
 =?utf-8?B?ckZtSVA0dElhcWlXSjVyQ2R3V1pyN3ZoRmRmZjVwdHJwYmdEaFhSUmRvT2J3?=
 =?utf-8?B?djdBZVNjQkVKYU9kTnhPUy9RNE1ybHlJMVE2S3Jiem1GQ3NwYWpnVnJUV0hp?=
 =?utf-8?B?anB4bVROWWdRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SStNK1pUNm15T2IzQ1VGZlpBVzUzcUwrVkxKRE1TNHBvVUZPZVN1NWhkR0I4?=
 =?utf-8?B?c1VKZVZDbE1uMFYxSngydks4WDd2U0VjN2hwcUZTS29HSEMwcFhSOGJrZnlW?=
 =?utf-8?B?NmdVVGl3Y1ZoNnZ4ODlwMmZjdTEwKzdOb1pPd3FPWmRvSy9nYy9oemhYeHQy?=
 =?utf-8?B?U0gwZ3JaNTJYWStjZnVYZzBoYTlYSDY1NlJtekZxVmlQUEFDeEQrTkhYSGRU?=
 =?utf-8?B?aXZMQmRGV04wNERzbkp4eFdla2FZSzdrOElrbVVzVjRVSlEyMlJxOWQ4clAy?=
 =?utf-8?B?dzBUWGZad3p5K0xxVW02VzFNRDl6MzBrZFJ0SlVvWGVxaVY0cnlpTVBPWjU4?=
 =?utf-8?B?T2pvOHV3S1JTdGZrWVJoNTlrWFNGMi9sZ2ZpYzlaM1BMMXlZcElzQUJlYmNk?=
 =?utf-8?B?bmtJeXg5K1FrZDNhQTZuZEZjQm9IWXNReU93VWJlb3ptSy9Xd1FUSVlST0ZQ?=
 =?utf-8?B?TVRWcEk5VitET0k3WG9ERFFrdzFQeVp2RHVlTnRqbk96WldKREJURDZJbklX?=
 =?utf-8?B?RTA0MVJmTzN0WUxyMThIeE9aU3JMWnIzeldpN3NTL2w1N1A1UVJONU10Mzlk?=
 =?utf-8?B?QVN1RUd4cEl3NndNcTVOK2RDY2lqQ2p2MW5xdHJvd2VBQTgwcE5nRFNHTzdu?=
 =?utf-8?B?Vm1xNnVVbjFYcHlXcDdFaEVianRJZzQ4MWFYNFNUcnFLZjNTWkQ5NnBndTVF?=
 =?utf-8?B?RnJSa2VrSzBKM1JraE84cStKSzhsTUZ2ZmQyUFRIMnNKQTRKSVRPOTFsakRw?=
 =?utf-8?B?YzlkNVpubUV0OUlpZmhaZUVpZHdUMVJWQzJ2aVkzcC9YalB1Mm5IRDBKSjJR?=
 =?utf-8?B?WjJHN3JxSzdXZWlsTHNLZFFTU3NrUVpFeEM0SzkyamNPTmVVcWx6WnBxU0NB?=
 =?utf-8?B?MS9wVk4zdXdNaEQwOXRJNk5reXU5djVCUTVsSmRZYXpLeE9KWlJHVXhrVTZN?=
 =?utf-8?B?akx1UU9scEREdmx5YjJ2c0lBZ1d1WHcrSktLZG13RUtsTEpIMTg4NDNCSFdy?=
 =?utf-8?B?d2FMYlNkK0ZRMUN4M3FlUVRvT1lMcjZtTzZoYjRnMFBJaVdHK2hpdDVzNzd2?=
 =?utf-8?B?cmRNT3VqMzZWK1BDR3ZsaWZNRzFBY2RPOVg4enZjOGw1OVo2Skt1L2NmRWx6?=
 =?utf-8?B?NzMyZk5DVFo3NlFKUmZkQlRvcytFS1ZjenlIWGY4M3kzOWluVHZJNVpJaGs2?=
 =?utf-8?B?VHNDR1oyOXo5Q1cxU3NKRUJKQU9xYUVGdktWcGFhdmF4RUwzZDc4ZUZvbE02?=
 =?utf-8?B?SGlxMHE2NGRrSENJTmJraE1rTHVJcDNzWEJWZy9kWEkxeitpdkNneUJNalNC?=
 =?utf-8?B?aCttMjAzUVh1K1BBNERBTmJlbGN2TlBXazRJaGpTSkdJNXFEanFKSFVKUkVV?=
 =?utf-8?B?eHN1Z0g3a2cxZTFkWklUZ3ZBUlNzQkV5aGZ2KzJlMVJDdEp6T0xyeFRiUjY0?=
 =?utf-8?B?b2FzQTlteHRPQUVQOGwrb1oxNlFyZFBLb0FzOUZtSHhoZVRIek10RkhXQkZw?=
 =?utf-8?B?MGVIQitsRi90Nmw0ZmRKdzhtZk1UYU9CZlhsMVNQSGxORHNQMSsrY2FmZmZJ?=
 =?utf-8?B?UG9HOHc0NjYwVTl1ckZRQk9wVkJUbWJabHdTd1lvSWtFWVhFMlN0S1dhVXVP?=
 =?utf-8?B?ZDJRUEVQRDlHSVFJSk42eERkZ0hBYjdGQUEzTk4reUF0V1diQU8rK1lLb3lG?=
 =?utf-8?B?OThnZEJhS0VYblM4MzA0TzZta2xwaVUyK3FvSGFGL1pHSFM2Nm1OYjdtWHVC?=
 =?utf-8?B?THU0byttTkdOcFdtZVJLL2hUcSttYmNsTzZkMitJNFpRaFB5OXpuVG5sRWtq?=
 =?utf-8?B?ZXBkaE5lTTNaU2VJU0hISThhZHRrWlB3dThPektGZVRBT2FBOXB0UjJoSWt0?=
 =?utf-8?B?L3RSNWlUeE4yZGdsS3hFbHBsTDZ4OWFjRklJNmowT3BBbk5yaEVMcXVLTW1J?=
 =?utf-8?B?VmhJTm5pYkFYWkl1TS9KR2JpNmptOUl1SUl6enU3Y1g0NGVJa1NTZHJ2a29I?=
 =?utf-8?B?OGdMZkZYam5xWXhmcWxVM3ZOaTZHeHB1NE56N2hZMzJYcW55Tk9NcURNcEl1?=
 =?utf-8?B?QXBPRTM1OXVERWUvSnQ1dGxjWWZiQVNsbU5WOE52djYxZExLNlV2aWQvU2gz?=
 =?utf-8?B?QVczZ3NWQzVpOUdNRE9JMjBueDVHZDYrc1p4blZmK0pYU3JNNGhCbzNtUkM4?=
 =?utf-8?B?ZXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1155a107-9bc6-4c81-82ee-08de2856e74f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 17:04:44.7873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tb2p4NTPn0pVA0aPI6BdyU0b0NvE/qdat09SWHyBlTbT7qX+coudSvcpbBG2Jv5aMkgDj7flvUepvcBM94ANsAbp6mdg7ERfLy/RvIddfgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10807
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 17:05:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2633

On 11/20/25 5:54 PM, Michael Opdenacker via lists.yoctoproject.org wrote:
> Hi Konstantin
> 
> On 11/20/25 17:38, Konstantin Ryabitsev wrote:
>> On Thu, Nov 20, 2025 at 11:40:05AM +0100, Quentin Schulz wrote:
>>> On 11/20/25 11:34 AM, Michael Opdenacker via lists.yoctoproject.org 
>>> wrote:
>>>> Oops, it seems b4 messed up the subject line.
>>>> It should contain "[meta-rockchip][PATCH]"
>>>>
>>> All my patches sent by b4 have the same pattern as yours. Glancing at 
>>> b4's
>>> code, I believe this is how it's intended to work, c.f.
>>> get_rebuilt_subject() in src/b4/__init__.py
>> I just accepted some patches into current master that should deal with
>> [presubject] the way Yocto lists expect that to happen. Please try 
>> them out if
>> you can.
> 
> Do you mean meta-rockchip? I believe I have the latest changes and I'm 
> using Quentin's .b4-config file from last year...


https://git.kernel.org/pub/scm/utils/b4/b4.git/commit/?id=d7232f5db2e4

Konstantin meant b4 added support for this in master.

I don't know if we can have send-prefixes as a fallback to 
send-presubject in .b4-config for versions of b4 that predates the 
support of send-presubject.

Essentially:
b4 < current master
    send-prefixes
b4 >= current master
    send-presubject

I (a contributor) would rather have a slightly "wrong" subject with 
combined PATCH and prefixes than having no prefix/presubject at all.

Cheers,
Quentin

