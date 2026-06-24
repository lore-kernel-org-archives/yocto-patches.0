Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42997CDB479
	for <webhook@archiver.kernel.org>; Wed, 24 Jun 2026 09:07:13 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.66])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2875.1782292024577740195
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 24 Jun 2026 02:07:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=FywsZoJf;
 spf=pass (domain: cherry.de, ip: 52.101.65.66, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5iPeeyoQ4qHEeCWzOKtJTOIW7XmNmvPUcMk5WlLhcn/27IdGAT3t5Y+EX/1wVVgYptgxgd8ZpJoWIv/OhKCRf3qVjGzf+SM6kRgSfLBwDJCV5CnuCH8kf/0H6xgHWEGgZxL++p/vp4uo4sVr1fPkAueSwI2JRXRISX6Cksdxq3LyaamvvjxTJGKJER5aLxdBhr5rKQb1kDZyVof/dH+OPqyOU8UqP0C5wAKywl/NxaNjsB68XNrPcIb/Tru/ck3pOBekVI81H3zgjeFxjUJNvtPSnVI5Dh2JZJyLBCD2RsvFbzRZUGzjMOSMue6rH+69D0+ZEAKV8ZEyJ35lM0nng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/U6N2Kd+SpahO9gkuVJPD+9E7nqVdvnfNmIjhFXt5Nk=;
 b=eDigKkpIDwYolE/kVVgtfFqYLdo9q7ptaZwf0POcRWgq3npooK+o39fVfF/U6862CYsdCF/Xx0KpTqbKhijWT3O7x+GdZaqQW4Dx35HrHDb42IEfeFHcUStWLpIbxfFGDsYIqL3X8fJ81mbufdVK3f92TLWC6hj9+McMDIloiK19T4dLsNMMIxBV7OgRX6uQlwMDBHdvZWw+RQYGO+n1X+6nYpUhntUa0D/9j0reky9GnfptlkMy2QxpK3QzXLJf29y4Wo9v25SdermAD9UwXKCtTR/QzeI0raUsWmDGbRsFw1A3qMvyRVo4/RLE/JYHU6Fofj873yst4UtIDrPK5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/U6N2Kd+SpahO9gkuVJPD+9E7nqVdvnfNmIjhFXt5Nk=;
 b=FywsZoJfnuWs6/MjVzo3E7s7ww2O0V+4CAnkIis1hXaww5Ioa1QXVrvkExkkoxL+S6G4KW9Kok0rOrQOvB4tgMLBMBu+28wOFuCgkQOPMXp4kMlNJzGabm23/IT/HdyXEPOakk7ZGnziiVbTqONKXZt8ROCziqFHwmvLVEJ1vds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AS5PR04MB9798.eurprd04.prod.outlook.com (2603:10a6:20b:654::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Wed, 24 Jun
 2026 09:06:58 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 09:06:58 +0000
Message-ID: <c6641e41-0cfd-44f1-96c9-6021648ebcc2@cherry.de>
Date: Wed, 24 Jun 2026 11:06:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [rockchip][PATCH 2/2] rock-4d: add initial
 support
To: Martin Herren <sputnik@on-the-web.ch>, Trevor Woerner
 <twoerner@gmail.com>, yocto-patches@lists.yoctoproject.org
References: <20260621211915.72650-1-sputnik@on-the-web.ch>
 <20260621211915.72650-3-sputnik@on-the-web.ch>
 <ea1a1238-4662-4be0-a177-8728d01eeeab@cherry.de>
 <fkPPtH1stRXArMl2K_un7dTDIpVqe0Wm0h9oxrPPv1LJFcZima0E_Pl2IDfe-vORdVazaPLAYSQbGrPDiyMnqLRzYb7TL-Fjwr1F-le3Icg=@on-the-web.ch>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <fkPPtH1stRXArMl2K_un7dTDIpVqe0Wm0h9oxrPPv1LJFcZima0E_Pl2IDfe-vORdVazaPLAYSQbGrPDiyMnqLRzYb7TL-Fjwr1F-le3Icg=@on-the-web.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0021.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::34) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AS5PR04MB9798:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cf72e99-3800-4477-7f92-08ded1cff243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|13003099007|3023799007|22082099003|18002099003|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 
	wQs5zr303s6C+MyHDW+AvnIieIqPaDDJPkRmVLiwijXhsx3NJ1BSuRF3MYhgNedqWATmAwhG3JnZHES+X9Xv0xFCgcJJI1fxKWsNfXZLR++mceXfgVZeitoyhsEjWsz4Hz3+DMhAkKC8XvOXJOwYaTd3D+081GShAUWFskxhv3A2ItbZvsYPEC+zUTG9pKiWtKVjbPHUTtKrw7RBxP/Paf4n8cdzITW0jADM4XY2Aj6ilHV1JTUMp1OOzZeJLObRGGtMkG3qbsnxkR285MoUJN1ulULko9AcJ2ZpSoBXW6Oz+t4slhr4ZRyAPpW6cJXXS9l4LDUiWHsvgi8EZW343p49VOqyW76wM1c3rjxk9vdssVmlwkSYAz/PofB0l2Xv9+8cZ6xV5tw7Xak5eaYIdYgtaeKawNoVH0wa2DBENY8am9pKtMXN8yJ1QQ0eM7OrInSagDwLLLsDdiJ6YxLVFsNgbHEKin79DUDo/snX0NI3o7HV9Un5rLRXhiRdDHRDhQy8pIOsYNIgym87xBkSbaggH9LRU082qRTYjVC0LzCacTdIc4PwElWRHDU9I1RTJr/Gl8P5/l7fFxyJ/JfAAZs0+57boxF9r0oZZGkMocECP+DiLJgn/DLAL9IBSEV6wSsZh4Up2FeotNl5h6pieMtJKWOF5sil42DEleLHEYE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7737.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(13003099007)(3023799007)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UXJsQjdaeUNkVUxGbHdNTGNrRFllK2g4U3VXRkVOTzBSQU9pakJ0KzZDVW15?=
 =?utf-8?B?bCtpc1I4UExUdVFTK0ZvQWhES1NaaTEvTm5CbFpTcXlrckFKOG5Fc0ZZNlVn?=
 =?utf-8?B?a2JuLzY2OSsvTGdpUTBWVTYycDZubFZBdXl1dm1FL2lkYzR0S05ySkN0eEQ3?=
 =?utf-8?B?RVM4QUg1YnppbWpQQjJaQm84QkhwYmF1VkRkYUhIOVpzOEo1WElsY0locW83?=
 =?utf-8?B?RnlLYlcrc1NPb1llRzhRU0xWcUZQb0dtOUxFK2tORlFwWjU1eVRMekt5NmJI?=
 =?utf-8?B?NVBheUNKUkh1MG5XMWhiOU91UEdzbkZ3MGg3cWJVaWdEaHpQR3poZUdOMHlq?=
 =?utf-8?B?Z0JVSGVoeUN0YjQrRjJBTGRmd0YxZjRQcDhkRVJjTnNWTEhUaVdMaGlGWFI4?=
 =?utf-8?B?c0dJUk1PTjA1K251cXEvZVRUVkhvUWplVnNtdUxuMWhhZmJ1ZllsMjdaNE9x?=
 =?utf-8?B?Y1BqVmVBRGVtekZ3WkhrZlM2bG9Ub0E5Qk1XOTNEZnF5U3l4Ym1MYWhjb1Uw?=
 =?utf-8?B?dGVBUmVUNUF0WHNDM0JOZENvRExRNS82dldPdDNhTWlocVhiSk5mbGo0Tzc2?=
 =?utf-8?B?ZnNxSjlqMElXVkdJeVRHOE8rZGs2M29PQ0hqTzVHOStSNzdpcUNoTHhVM2hp?=
 =?utf-8?B?VHZxWlpsK0YyTmlJRk9zZW5mMFU2SzdlMStNalhRVnpkS1ZpWlVUZ01rZmRk?=
 =?utf-8?B?Skkwd3VSRFBvMC9Oaml1RmY0aGt4OWJ5N21lcEFLNXlEOVMvdVBzVjdhZCtJ?=
 =?utf-8?B?eDQ4dmlZeW95KzNuczUwVVVoZnlCOXdqYi9IeDBNOHFLSmEzelFYckNmR3R3?=
 =?utf-8?B?NTBYc0toSDJhOCtWL1hPbllJb3BJTmRVR2pVckNNbmszRHkwNjBFeFNwOHU0?=
 =?utf-8?B?R3J5MUNqWGVhWnZOMHZ1aEUwVW9rZXdORDdSTHN0VnRVa2YxbktKUEtHV3hH?=
 =?utf-8?B?RWdBZXkxNWh6MkNXbW1ncDdiSmJHcXZ1NWxkU2NReDlwZFkrdTVoVGlxcHFX?=
 =?utf-8?B?dlpBUzREaUJFUlVoM1IzcXhEOTZjU1AxNTV4U0d1aU4remhjWFJTVVVMRnEr?=
 =?utf-8?B?VGlHRkVBNUJEY0EyVStxcHJUZWtacWxEWkVTL1NRVDRDZ3RzUFFxWTVyYU80?=
 =?utf-8?B?cERoM2xOTTJYQ2MvdUtNM2xGWjlUQStRcVNWK21JMytCb3ZoUks4VitOajBQ?=
 =?utf-8?B?Mm0veHlvUGxqQ3hMQnQ1djUvS3NXYXZpZFNOWnRBK2dOcEJ6c2YxVlpFek05?=
 =?utf-8?B?S2lHZFYrOUdFMDJCbmpmTkc4WWRiZ0JJaG1INERsZlZYL1EzcE14RnQvUlJa?=
 =?utf-8?B?VVJWemxoUjczK0gzOG5vRWNNQXJ2YUkxSTJjN0FtanAyZ1gxZitzSFRxOFNl?=
 =?utf-8?B?MGkvSFNZelF3a29XcVAwWHNrT1NTL0pyK0FDUUdZWGdaY2pXVkF2eDJnL2hz?=
 =?utf-8?B?RERUdUdXcjVwVWc1QmpEelEzcmREZDN6OXFUcWQ5ZjV4eUt4WisveUROZWQ4?=
 =?utf-8?B?cFNTY1lMaURSZkhxWWQwaS84TTlua1RDcHdrUmcwRlFOTEs2dEJkUnZjaVhI?=
 =?utf-8?B?alErTDVYejg4ZE9wREFDMUxka2hmZTZQYU1iVlZXZjJrNmFpaE9nM0hMMlpU?=
 =?utf-8?B?REZ2OWkzVGZjVXQvTjdnQlRuTDFwRUdzNnZNTUxsdkQ2aU4vN0s3T3ZET01i?=
 =?utf-8?B?OUdGYUdwemFYWS9kNUxFc0pZSmtRQ2R5LzRFT1ViZ1hucW53Kzd3aXp1dVV3?=
 =?utf-8?B?NVc2dnFtTmtIZ2k2TFczQnVnbTdDdXVZQ2V3OEErMGFaVzR5VzN6STA4bzBW?=
 =?utf-8?B?NXk5Tk96VERhSExPaDVMZGhXMmhhS1I2TzBxQ0pSTnVuOXo1Z2tpNUZDdDB5?=
 =?utf-8?B?a1YzaWx5QXFGUHVZcEpSam92NHBKWDFmTmM1ekI4b2o3eGQ0ai9kUG1pdHhz?=
 =?utf-8?B?TUdXT3hmbGtZQ1A1ZXRGRmtjL2VBUklmbmp1ZGY5U2J0azJ4d0ZkaURDd0xk?=
 =?utf-8?B?U3RVRzlMa2V0cjV0MHllOHkxOXE1U3k1MHNrRjJodHdEWkJ5R2NLRkN0bytZ?=
 =?utf-8?B?M3BhR01VWGpCalZTeSttMUZ1dCtMR2Z0aTRWbEdybHl6bDY2VE0yTWpYT2xO?=
 =?utf-8?B?MEZ5bEVmYkVFbkVkOFQxamxlTE4yS0g4REY4VHBpVE5QR1hVNGNCbVhZd3V1?=
 =?utf-8?B?OHN4SnMxL3ZPREtGNUVkWFBpZVI2V2sreUFwcTQ2QnJIVWRzVEhzS1JoZmxN?=
 =?utf-8?B?aVpEYytIR3FTRDkyZTdnRXZPMUtGL0trN2pJRnF1MUNWaXdpMWVHdXZwZTMr?=
 =?utf-8?B?M01ob3R6bTdMTnR3dDBwa2JxMEVZdG5rWDhvRWZ6K1BlQ1VTTnE2UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf72e99-3800-4477-7f92-08ded1cff243
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 09:06:58.8087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UFE0MO4pasxaXB+zL7srl2yVyB+lrilXGuqMjIRzOiKqVy6NczwIzQnCtmr/0kNU4o6DEMVO2uhDGx6P3cVy9ggFfDhiimiLxhXweP0Pthg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9798
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 24 Jun 2026 09:07:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4294

Hi Martin,

On 6/24/26 12:20 AM, Martin Herren wrote:
> Hi Quentin,
> 
> On Monday, June 22nd, 2026 at 7:19 PM, Quentin Schulz via lists.yoctoproject.org <quentin.schulz=cherry.de@lists.yoctoproject.org> wrote:
> 
>> Hi Martin,
>>
> 
>> On 6/21/26 11:19 PM, Martin Herren via lists.yoctoproject.org wrote:
>>> From: Martin Herren <sputnik@on-the-web.ch>
>>>
>>> The Radxa ROCK 4D is a compact single-board computer (SBC) featuring
>>> numerous top-tier functions, features, and expansion options.
>>>
>>> Equipped with the Rockchip RK3576 SoC, the ROCK 4D boasts an octa-core
>>> CPU (4x Cortex-A72 + 4x Cortex-A53), Mali-G52 MC3 GPU, and a 6 TOPS NPU,
>>> making it ideal for AI and multimedia tasks.
>>>
>>> 	http://radxa.com/products/rock4/4d
>>>
>>> tech specs:
>>> - Rockchip RK3576 (4x Arm Cortex-A72 + 4x Cortex-A53)
>>> - Arm Mali-G52 MC3 GPU
>>> - DDR5 RAM (2/4/8/16 GB)
>>> - uSD, eMMC/UFS module connector
>>> - GbE
>>> - 1x USB-C (power delivery only)
>>> - USB 3.0: 1x Type-A HOST, 1x Type-A OTG/HOST
>>> - USB 2.0: 2x Type-A HOST
>>> - 1x HDMI 2.1
>>> - 1x MIPI CSI camera port
>>> - 40-pin GPIO (uart, spi, i2c, pcm/i2s, pwm, gpio)
>>>
>>> The ROCK 4D is the only board of the Rock 4 series using the new RK3576
>>> SoC instead of the RK3399 used in the rest of the Rock 4x serie.
>>>
>>> NOTES:
>>> Due to the RK3576 boot ROM limitations, the bootloader cannot be
>>> loaded
>>> from the SD card; it must be extracted from the wic image and
>>> flashed to the SPI flash. The kernel and rootfs then boot from the SD
>>> card. See the "rk3576 booting" note in the README for details.
>>>
>>
> 
>> I'm confused, if it doesn't work, what is the purpose of using Jonas's
>> U-Boot fork?
> 
> With Jonas' fork it works when flashed to the SPI. With upstream it won't work, neither on SD nor SPI.
> 

Jonas explicitly stated he tested SPI booting in the introducing commit: 
https://lore.kernel.org/u-boot/20251019154728.846096-6-jonas@kwiboo.se/ 
so either it got broken since (not impossible), there's a hardware issue 
or misconfiguring/misflashing U-Boot. Can you tell us which binary (how 
you're building it) you're flashing and how (commands, offsets, etc...)? 
At some point you may be able to get better help from the U-Boot 
community directly where we currently have at least two people 
interested in RK3576, either from IRC on #u-boot at libera.chat or on 
the mailing list (rather the latter).

>>> Ethernet is only partially working, mostly in degraded 100 or even 10
>>> Mbps mode or sometimes not at all. Investigations are still ongoing and
>>> if found a fix will be submitted in a future patch.
>>>
>>> Wifi is not yet working, requires an out-of-tree kernel driver. Work on
>>> this will be done on a separate future patch.
>>>
>>> Signed-off-by: Martin Herren <sputnik@on-the-web.ch>
>>> ---
>>>    README                                  | 17 +++++++++++++++++
>>>    conf/machine/rock-4d.conf               | 11 +++++++++++
>>>    recipes-kernel/linux/linux-rockchip.inc |  1 +
>>>    3 files changed, 29 insertions(+)
>>>    create mode 100644 conf/machine/rock-4d.conf
>>>
>>> diff --git a/README b/README
>>> index c2697d1..8192284 100644
>>> --- a/README
>>> +++ b/README
>>> @@ -39,6 +39,7 @@ Status of supported boards:
>>>    			roc-rk3328-cc
>>>    			roc
>>> k-3a
>>>    			rock-4c-plus
>>> +			rock-4d
>>>    			rock-5a
>>>    			rock-5b
>>>    			rock-pi-4a
>>> @@ -122,6 +123,22 @@ Notes:
>>>
>>>    	in the configuration (e.g. conf/local.conf).
>>>
>>> +  rk3576 booting:
>>> +	The RK3576 boot ROM cannot load the bootloader from the SD card.
>>
> 
>> The datasheet claims otherwise.
>>
> 
>> It could simply be that the board doesn't allow you to select booting
>> from SD card first. On RK35xx family, the SARADC channel 0 is used by
>> the BootROM to select which devices to try loading the bootloader from.
>> I'm thinking either you already have something valid on SPI and/or
>> eMMC/UFS and the board starts from there, or the board is configured in
>> such a way that the ADC selects a configuration for which the BootROM
>> will not attempt to load from SD card. I don't have a reference design
>> for the RK3576 and Radxa's schematics for the Rock4D don't provide this
>> table so your guess is as good as mine as to which values select which
>> devices. There's some weird circuitry on Rock4D schematics though on
>> that channel, c.f. page 11.
> 
> Yes it is strange. The board ships with with the vendor's bootloader already flashed in the SPI.
> This is different from like the Rock 5B with a rk3588 where the board comes with empty SPI. Flashing the bootloader is only needed when booting from NVMe for example on the 5B.
> 

I'm assuming you meant booting the Linux kernel here as I don't think 
the RK3588 BootROM supports booting from an NVMe.

> With the 4D the preinstalled vendor bootloader already crashes when parsing the GPT from the Yocto image.

Yeah, Rockchip U-Boot is an absolute joke.

> Erasing the SPI won't boot, neither with the vendor bootloader nor upstream nor Jonas' on the SD card.
> So it seems it can only boot from SPI.
> 

Seems like Jonas agrees with you: 
https://lore.kernel.org/u-boot/20251019154728.846096-6-jonas@kwiboo.se/

"""
ROCK 4D boards with SPI Flash is configured to boot from 
FSPI0->UFS->USB, or directly from USB when the MASKROM button is 
pressed, booting directly from SD-card is not possible on these boards.
"""

Can you please add a small word about this in the README? We should 
probably document this in U-Boot as well.

> Didn't try with an UFS, don't have any. eMMC seems mutualy exclusive with the SPI according to Radxa on their support forum.
> 

Yes, looking at the schematics, the SPI and eMMC signals are routed to 
the same pins on the SoC.

>>> +	For rk3576-based boards (e.g. the rock-4d) the bootloader must be
>>> +	extracted from the wic image and flashed to the SPI flash; the
>>> +	kernel and rootfs then boot from the SD card.
>>> +
>>> +	To extract the SPI bootloader region (first 16 MiB) from a wic
>>> +	image:
>>> +
>>> +		dd if=<image>.wic of=spi.bin bs=1M count=16
>>> +
>>
> 
>> Please just make sure idbloader.img and u-boot.itb are in the deploy
>> directory (or even better, u-boot-rockchip-spi.bin which contains both
>> with u-boot.itb at the right offset already) and tell the user to flash
>> those binaries on SPI at a specific offset. I believe you're also
>> copying the partition table, which doesn't make sense on the SPI flash
>> (at least not that partition table since there's for sure not enough
>> room for the full system on it).
> 
> That's sounds much cleaner, will need to look how to do it. Having a clean u-boot-rockchip-spi.bin would be useful for some other boards like the Rock 5B as wel.
> 

Note that I don't know if the plumbing exists to do such a thing as I 
haven't looked into it yet.

Cheers,
Quentin

