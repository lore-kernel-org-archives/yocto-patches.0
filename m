Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84730C5AC7D
	for <webhook@archiver.kernel.org>; Thu,  6 Aug 2026 12:42:25 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.61])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18853.1786020133943842754
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 06 Aug 2026 05:42:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=nFZTYe3c;
 spf=pass (domain: cherry.de, ip: 52.101.66.61, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SV1GJ/TfZa307XXb1pK+5/cEr8ddchGp3u2//V4VrcHIWfSVvSS/a9EI34OC7F1HAUYigADKHNdwKaRLvzxWOg2aB34UcS4g45ttDVQVWUvYmrsmOOb/c57t7AIX+gqDLiwsbgei9Mk0fsuBtdXd8QOEMi3g6LY+zdzpBswMhj8yKmjQbVC9N1ehu/j3nVBVjuGb61TL4G3VTRfmBhExBLCaOkquqXpR8gWn3YmcoZsnrOYKzAsOkiVGGr0bWznb5o5SbkwIMxGikTSDLcqFpsJgbK2wemWnJ7YC9tqmtCXJrS3Y1syByrNHroj5L33Fr2e5tEN2yMDDdJXfzSeu+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIpCsnSgsKm2+xPzHEcsQwLPzWWqBiDWN/t73LiARkY=;
 b=OywsG11BDdOhKZunRmZ15f/xyUrB45Bh7MJ239l3EtDylynFzKvRvkWGDNB9gaRbqEWz5F1XdVdNRkcp2lihpey29KkbVh1LwyysEoYxmXVzV4Unp4oGppN9lGdr5MsAIpYYxiNWnQkKxJeIXTjw4qRZQKrWG6vRZgM57zWlQS3Fxni3QP1BrRihf/5FILXdX9AamEKgPBX1M6sBV0ei02OpoFfoHlApqA/0tX8PaTKLsuvNMI//j1kWE5rWhgiOxEKtcWRAnY9H17koNzDAAjjcqWZgAmHBWYZGl47Z/JNw1sES3IRKEH1mE3IuXGcYZMHD9wwIfz2x42YNDOZLxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIpCsnSgsKm2+xPzHEcsQwLPzWWqBiDWN/t73LiARkY=;
 b=nFZTYe3czIotDzpHGhct+338U2T4NfMLbbo1SeUPL+Hgtr/1jhVXHeGZNs9ZnZpfERetYrn0hmO5iRZV6PF+UgCx16HuSNNdzj4xB/oe1uN7Es6o1lh9IzcpBzgtpkZvhQ9FZQpCXY21oQJxiRpUyYIHzuJ76y0WUePaOqokkd8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB7733.eurprd04.prod.outlook.com (2603:10a6:20b:288::18)
 by FRRPR04MB12571.eurprd04.prod.outlook.com (2603:10a6:d10:1cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 12:42:16 +0000
Received: from AS8PR04MB7733.eurprd04.prod.outlook.com
 ([fe80::8f86:fafb:dce7:bcd5]) by AS8PR04MB7733.eurprd04.prod.outlook.com
 ([fe80::8f86:fafb:dce7:bcd5%3]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 12:42:16 +0000
Message-ID: <6c58262c-06bb-43ac-a72c-e930056f71bd@cherry.de>
Date: Thu, 6 Aug 2026 12:10:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH 1/3] bsp: rkbin: use SPDX
 LicenseRef for Rockchip proprietary firmware
To: yocto-patches@lists.yoctoproject.org
Cc: Trevor Woerner <twoerner@gmail.com>, Martin Herren <sputnik@on-the-web.ch>
References: <20260805121327.3946788-1-sputnik@on-the-web.ch>
 <20260805121327.3946788-2-sputnik@on-the-web.ch>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260805121327.3946788-2-sputnik@on-the-web.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0063.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2ca::18) To AS8PR04MB7733.eurprd04.prod.outlook.com
 (2603:10a6:20b:288::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7733:EE_|FRRPR04MB12571:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aba43b7-22a5-4d23-42c0-08def3b825c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|10070799003|376014|366016|56012099006|11063799006|5023799004|10067099003|4143699003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	7FOC/qksbvT0hbw/3wkcscZHIB7uCKEv7k+OGYl0Ht7DipkiMz57OMeEluVaJbrHTdHDpiqVRDrGZaW4KU6OdI68k7hC1v9ld7bkOBeJzmwVAplz4qWQTLGDQD/5P1Y3uBY9Mcu0GRa8Yq/36YGlIHiIVtJhRjGJXilIYViNCFrxiiN8x900QkhwkqMaEo0DD+JQO5N78WgVD4duuWlVs707W6mx2GOB3fh8Uu7PL2IXH26Ek4ZCeCXPRrIvmaYCscBeVINW2bUQvKv9jDegYzyzThTl6paNsGOLduedXnG5IuESd6kJIM8WAFP4PjaXmiYCjInDGXDX9sBNkmGHX0LgDc7pTOvVfvA0vBmcPCn5w7jxXcV1F0LpMX1GL6e7ayTEjXfhfnHil6YI/Hr/x8LsyMgT6inxYG3SvNWs7J+qu4GB1dBHCZtqZL+VQ9ON38NyxkiDoA6dw1mZwKonIC/VtUuzIKqqobxGx5zmDD6P8TM87ee90SP2mWspJmMCUVxd8VdsM1WjgKRRY7abypl5BfbprYcPN2TpivwezTKgTyofMRGKMzt2RZIwmfPO7+ZYIjv8KGyuXjTA7wwtcjrM7NRY01xrqHrMwVaweN1wOo8n0dz4KUfS2/bSEvDpzRUuff1qI2Zvm86nWHCKwixIUjmK0c1HYUTLxhOAb+M=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7733.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(10070799003)(376014)(366016)(56012099006)(11063799006)(5023799004)(10067099003)(4143699003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aVg2UDZNMkc2dzVmMFpCUDB6VTVQclVkRm1lcnhaQW5ocm1teUpVU3ZTK1pu?=
 =?utf-8?B?dFZxbFEzWTdHZ0d6ck16SjMyZ29XV3ZFdm15MllNdzh2RXQxSFBLKzIyKzgr?=
 =?utf-8?B?Z2YxK3M2c29nenV6NHYxNE1nZEp5amFnYlJlczlFeFRETjFHZ1ZXZ2VTa1Bj?=
 =?utf-8?B?aFI2ZE1ia1lBR08rOXhhdGdicUdFSmNxSUZTcnRmUzNiSEUwRkF0ZWsvT25o?=
 =?utf-8?B?aHBiMHBnOVk2T291SFkvM1VBYU9KKzYxTkFBOHhaQi9ETFBKTDZZRkM4M1Zp?=
 =?utf-8?B?TWFXVy81NTdQN2ZCOFVtUDNxYlJyZnU3dUVNMnIzQXc4SnhwRTZzWStHclhI?=
 =?utf-8?B?c2R3b1JCNjFldVpsNVk2aTMrbnUvMWRTUXVhR0EzWFlWN29jTEZ6YnVvUXZn?=
 =?utf-8?B?eUV4WFcyRytkRzhveUJQc2QrMzNnQmEzSE1NOWxzSVp3VW03RGFvSDhweGtM?=
 =?utf-8?B?Z3FlR0hYVUQ0YUVGUXU0am5iNWtWVlhXbXpPS3U3UllBMmJweWlQTWFFdXNj?=
 =?utf-8?B?dkRXMzM3Yll5ZFJRbkVPMTVSMlgrUHdRVlVSdEZRcGxJYUs1cFNFZ2tQQkVn?=
 =?utf-8?B?MDFHTGFVK0ladHQvMXFSeFN4Z1I1alErWXA0OFU1RUhCeWZ4OWcybW9lQ0Rp?=
 =?utf-8?B?cUthNzVEYytTSUR1aFM1alBMV2ZiWUtRSklJL2Q4ZkNnZk1OZVZCdWtGMFRQ?=
 =?utf-8?B?Y2JnTkt1dmJ2RXRqQ0lPSFd1RFFpTC9uY1YzZnpVR1BFTUFtS3c4OUVzRXRE?=
 =?utf-8?B?WkVRVzh5ZWcra0lXZ01hWFFCc3RJOGR3Yk5qZk9neTVHYXJQZWtlSjJjMEF0?=
 =?utf-8?B?R2hoMTk2c1pQT0Q4bll3bUxLNnNKUUhZZ01POVNwMU9KckdGUlgwWnBreWov?=
 =?utf-8?B?VmpvUW1KdmJ1dlNBbUZTS3IweWNqdTA5bzFMRnE1TGc2R2ZIVlBEa1ZpMDYz?=
 =?utf-8?B?aDhaNzU2MkowWWU1QnZ4WGo3NDlUbWlVbWZTWDhOTXdldDdFTTNTemh1TWpm?=
 =?utf-8?B?M2RiTGNlY0JUeVQveVpzNU1UMExpOXpoYSt2TTI0aWVZRWdLeVlVSHY2VnFM?=
 =?utf-8?B?dmU2SHp4cFZ1VDVoVkhPK0JnUGhiZU16QnNDZ0RzZ3NLbWlNb1ZSWW95d3Nj?=
 =?utf-8?B?dDlsTTNqQlNVZDMvZUJtdlplNUNHZUFKT3hPUElzTngwTUErZU9CRTBuV01z?=
 =?utf-8?B?UFdBSFh6d2RDdy9hTGN2UXRjLytBZjNROVpCRFNxR3VVdi8rUkVrc2ZLdUJj?=
 =?utf-8?B?RXZETGR2d2lKb1dPVktFSnNoSjEraUZQU1poOGpROTExbXY3MUpRUkJwUGpC?=
 =?utf-8?B?Q2lkdEhDUExXS3RoUkxtL2tEWWI4alBPZ1d2LzZYYzQ2ZFRFeHc3MFhqTkIz?=
 =?utf-8?B?cWxGcEJGMEE5MlFUeWh6eld3dHA0TkZKT2tyblNOR2l5cWxYSC9mcHVkMCtE?=
 =?utf-8?B?K210bkFpZ2lyZ0RmTjhncmZLb0ZCK3BKaGdMTURZWGNPaDQ1dy9hYkUrbzVR?=
 =?utf-8?B?SnFxbU1pQ1NlNXNJR2UrbC9rcXhPME1Sc1hNTjdjaC9Nd2xiRzVJcGtjSTFQ?=
 =?utf-8?B?TktDU3ZMYmgwdkt1WjV4UkpVZ0U3eGVYMTNpNUgrLzVBOFdmR0N6OEtLN09B?=
 =?utf-8?B?OXRiQ3dsNXVPd05HeHJyck42anlnK3JIak9oeVJ2OHdydDRqMldVZStSR1Ax?=
 =?utf-8?B?MWdQVno5cUFEclBoS3A1R3Q5em04OWl3ZEZJZGZ4d3JKT0dtYVZqaENrZysr?=
 =?utf-8?B?YmQrV2U3M3FMd3BSWXM2blQ5RGdGYWtsbXVYTGY2TWJhQXkrRTBGbGJoRnph?=
 =?utf-8?B?QkIrZld6ZDVpTmVaR2g4NGtNVXN6akJyWU1oamJycXJkcXhxNVp1Y21LNy9G?=
 =?utf-8?B?OHZWNy9ybEpucW1YT1BXNnZFUldoWE5aM3dsQ1kzTytCTnhxNUZnVThLUGxp?=
 =?utf-8?B?SVRaMFlQRUZ0bW9xcHJSa2VwbnlKekg3R0VUUGNrYmhFQmtlckd0VHhRN1Zr?=
 =?utf-8?B?Nm42Yy9xK1Fob2pHSW1pWTJlWExmVDBBQVBxbnpRMytHajZsSlVadExOZGxN?=
 =?utf-8?B?SFEwaHhqS3NMMDlmU3VIR2prQ2x6aHU2REVhV3VnSWVybXBzWlhYL1JqM1R1?=
 =?utf-8?B?ODc5SUlOakhab3RMZnI3SlFaeURBOEQ3MiszNDBxSS9lOUVFcXFQMGhuTDB2?=
 =?utf-8?B?Rk9VYjVqakJUV3M1aGRvSzh3eTc4TnljSmwxZWdtL1QzeXd2Z21ma3Z2Zk1O?=
 =?utf-8?B?b0FWZ21LbnBzV3lUU2Y0OVlVRFM2d2tkMGFFL3hFcG1td2s5RnpSMElLd2dj?=
 =?utf-8?B?R1BCK0pWNjRyRTdCQmFZM1Q1NjBvVTBMT2ZBSTJMRm9ad0lHZW1GWWlRelZS?=
 =?utf-8?Q?KvIkYrX4Qg/Db0n61fWyZRt8b95DvALon4YL3r2TQBMWN?=
X-MS-Exchange-AntiSpam-MessageData-1: Zv2ifzzXvfwMg3N21NA9iM7v+8shbxAR0zw=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aba43b7-22a5-4d23-42c0-08def3b825c3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7733.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 12:42:16.7463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +KbD/O52NywIONnbrJJl8xwqeq+1KD0f1lUobUgm8eWjD8R5tZnur8CZTBL/Wb5nZ7O0OT3IA/KFQK3OSElzEebM0Ok9WHvXoRl3BX0mlN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRRPR04MB12571
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 06 Aug 2026 12:42:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4639

Hi Martin,

I've read on LinkedIn you used AI/LLM for some stuff related to Rockchip 
and was wondering if maybe this series got some of it developed by/with 
AI/LLM. OE-Core and BitBake require to add an

AI-Generated: <AI/LLM used>

in the commit log and I think it could be nice to see it stated for 
meta-rockchip as well. Ultimately, it's up to Trevor to define or 
"enforce" this as he's the sole maintainer of meta-rockchip at the 
moment. See the "Acceptance of AI Generated Code" section in the 
contributor guide (I'm traveling so cannot provide you with a link right 
now) if you want to know more.

On 8/5/26 2:14 PM, Martin Herren via lists.yoctoproject.org wrote:
> From: Martin Herren <sputnik@on-the-web.ch>
> 
> OE-Core now parses LICENSE as an SPDX expression and warns on legacy
> non-SPDX names such as "Proprietary".
> 
> Switch the rkbin family (rockchip-rkbin.inc, used by -ddr, -optee-os and
> -tf-a) to a recipe-specific LicenseRef backed by NO_GENERIC_LICENSE, so
> the SPDX manifest references the real Rockchip LICENSE at the repo root.
> 
> References: oe-core e9d424738d6f ("classes/conf/lib: Parse LICENSE as SPDX Expression")
> 
> Signed-off-by: Martin Herren <sputnik@on-the-web.ch>
> ---
>   recipes-bsp/rkbin/rockchip-rkbin.inc | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-bsp/rkbin/rockchip-rkbin.inc b/recipes-bsp/rkbin/rockchip-rkbin.inc
> index 9ddd54f..d715b44 100644
> --- a/recipes-bsp/rkbin/rockchip-rkbin.inc
> +++ b/recipes-bsp/rkbin/rockchip-rkbin.inc
> @@ -1,7 +1,8 @@
>   SRC_URI = "git://github.com/rockchip-linux/rkbin;protocol=https;branch=master"
>   SRCREV = "f43a462e7a1429a9d407ae52b4745033034a6cf9"
> -LICENSE =
>   "Proprietary"
> +LICENSE = "LicenseRef-Rockchip-rkbin"
>   LIC_FILES_CHKSUM = "file://LICENSE;md5=11e3673115959bf596feaaa6ea7ce9a5"
> +NO_GENERIC_LICENSE[Rockchip-rkbin] = "LICENSE"
>   

This seems to follow what we've done for 
meta/recipes-kernel/linux-firmware/linux-firmware_*.bb so looks good to 
me, thus:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

