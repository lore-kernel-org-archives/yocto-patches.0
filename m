Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.46882.1795627500783532302
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Nov 2026 09:25:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=L9KBqYbX;
 spf=pass (domain: cherry.de, ip: 52.101.65.39, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7WbcQzkj4N5OJsuvyDjHJKqVE6sN4J9a7kWJvbG2nQZR6UagogzdHLZyoDIuyZRrQWVSVNvSnr41XVWUgpQcBb9vPksK/iNeDfxjb+aaMjMp9FCclUzIDjv+0EBdIkaFKlGvYZ1jr1C4Ya9Dvi0tsCWl0FYQhNUJEtrgmagDekbOGeumKKw9EDyXtngIH17jP1PdXOcy0X2I9W5QGdEoUz6ayfERvJUN82ZRKeK2BM2ZKjJLJYD3R8LAFr4I9TjVsU7rhJMSPaK1dhpYOA5SeVMnvf1UVKv2izhVcqBhTgsfREcKIHlp7HWJd3MyJakMjmJdL5+/oPWeMyczWVFPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yv7fJoTGOvhvObxjnCO4jrTxuQWqrU1sK5/oPhvTotI=;
 b=FNBQKTE9TWJB+2aFF2R/hsRt3RRPIgwGR0XmduOPQvROj6/W8VrFFzKliLsmB8cOY4c95wi9XuMrvrVtSqHvDvJsmP3vn1lpE4n4QE+KFK2pfR4EH2qbr5bZ9Ej8ny3avSn+ObIcnwBO9yXZ9oA+l82wKh7BBA/xJJrH1aPthzw+WoPSwSsAecd8SjsI1dBvZ6wjRDBB4tDstaLhsb71TOKV9CS39HQzXnQjECh08rrqfh7jiLcRMHRgslJAVdvHpyRO9EC8hnlWmWHF5nze9D+6+QZaRhvYAUjW0Due+tcLQB0t0/844DOxrwEU2KZ3Ji8r9vgeXOAURNzJyRcROA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yv7fJoTGOvhvObxjnCO4jrTxuQWqrU1sK5/oPhvTotI=;
 b=L9KBqYbXKnnEvN97b6UMjQmQYzdDCZAY9wB1lsRT3//UuW3w7pp9C/w3X3ngRatKohFzMyzY8Rxmz3Y+TxQdf0Ywzp/nGSbt7U08UE+7jF88GvT7xj95zw6hAOMe4vPGte34gfvcf+1gMoefqsnN/ia501uKdJVbpwdspvi6ChQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by MMZPR04MB684476.eurprd04.prod.outlook.com (2603:10a6:190:103::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 17:24:58 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 17:24:58 +0000
Message-ID: <f199a94f-2fc1-4c03-bec2-f4530efffd3c@cherry.de>
Date: Wed, 25 Nov 2026 18:24:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-rockchip][PATCH v2] nanopc-t4: add
To: Deepak Das <deepakdas.linux@gmail.com>,
 yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com
References: <20261124052240.1121147-1-deepakdas.linux@gmail.com>
 <20261125112632.3177-1-deepakdas.linux@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261125112632.3177-1-deepakdas.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0126.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::24) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
Return-Path: quentin.schulz@cherry.de
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|MMZPR04MB684476:EE_
X-MS-Office365-Filtering-Correlation-Id: a3ccb980-c3b2-445d-ec4e-08df4b190780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|56012099006|4143699003|11063799006|261021121427099003|261102123227099003|261028144727099003|261022075727099003|261026121527099003|261022105027099003|261009223027099003|261022115727099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info: p8YEEuQ8C76ntI2p/VtQOWOE0odbhlTL5zNDGIfrTpnIcUC5T8bL8vwnyaWb0H+OrNA4Ufvco353VDKDn7vqu6GluRU8z0ksVmpQuXgzxYq4JxgCKGoG4NUEPYFH149l22XcfxQW5gXXfikce93YpvaHD+tpRkM0I1QDDSSOtLoes+/18huxZVqKnIYyivW/av3zvdRr2gaBdy9oKO0It20H5RT6OCO1gV9msdegS/0G79i+IULzH5rwJ1pBiR8CgxVGjYNKOV2MjL/12kXUPyNAk7nODs7dNhs3NvN0UCRd/3xf6yMoqJX7vn9Cyz++vuQH7j5lG/OTrFu/QhDpwYNd7fAKRjs3YNN+OGfOzyUDuqe8bOP06jNv4Zo3LvAVdJnK9+/xiSoWmVndRhfQ1KWzZ9l9wsz3Ox5+u6FF8iJuU1hsT/0K9gidPKxdQr+MVqpqDJ41IrzNfFY6saYSp4AA73Nc++VNfk7lxAD9a8HzRcWycMOPcNLnhQo9DsWM2srsL5H6IJB9Alxs9vzf/fMbZ3txpcLybzNwv2ltCYsI/2c+/1pnwrJEzG0ahSxYyA0WAVwLrvorP9r3hmrgB1+Lj/bMDIqc4zXaTj7ISZE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11153.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(261021121427099003)(261102123227099003)(261028144727099003)(261022075727099003)(261026121527099003)(261022105027099003)(261009223027099003)(261022115727099003)(261026140227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTBDTGttVzFzYitXb0lMY2E2OU5USFdrRFJBSmEwMllXRm5mYktxdGNOaFVI?=
 =?utf-8?B?aWtsT3NacURRZ2dwbEhKZnVkNHJpdzdlOXB2L09HdUlSNFFPR1dJWUJDY1Rx?=
 =?utf-8?B?TXE2S1RnWkxRMkpIeWJHQnFTbkU0Unhyakg3QTBZQ2M0QU9SaHAxQUNCU3A0?=
 =?utf-8?B?aVlQSWY3eWxCdHlPbHVvNzRCOWNUOFZqZ0cvK3lKOEVPVUhITkNGcVliSGEw?=
 =?utf-8?B?RTBzZDFNWXJEZXJTLzc5UVc0VjBuZjVFdmFielZPY1o3L09qUC9JVHd3NWtT?=
 =?utf-8?B?MStKT3pEeVo5bFFXVm5QbWhVYjZiR2tnZTJrc1pSRVNETldFOEpwS2FpKzdH?=
 =?utf-8?B?ei80eXRIMFQ1d2lTVDdXMWRPdlEwVTd0bUJ6K1NKLzFwbzEzZU5FV0hLYWpG?=
 =?utf-8?B?dWwwL3JMdlBzWEQ1TDZ6SEd1bTF1YzFycEo4alZYQmphZUgxRWI5TWFaZWpR?=
 =?utf-8?B?L2VLVHVJOGtONUtxT0g4WEhGVEZnT2dqaTg0SUZ2U2FoUlQxUHIrN2ZZVC9X?=
 =?utf-8?B?aFJxSVVreUZDZWJIbDV4WmU5ZjQ4ZlNKWlNObFZ5c3g2dzNhcGljeXI4eURD?=
 =?utf-8?B?V2RTYXQzTjByQkEyMkZhdnRhOW5NS0xmZit4elk2Lzd1NTZrN0JKN3hQbWxD?=
 =?utf-8?B?QlVpaGF4SGJrZWIrdk9zL0ZZbllFOUtUL3hFTFFERDJvQVVZaURYTmRDRnJh?=
 =?utf-8?B?WDkxS3JvTkYrQlJXY3ZQVlNzUWh5ck5CRmlPK3dtMXRMeUJFVjgrZUF4RTFi?=
 =?utf-8?B?RklQeG1UQ0JMOCtFMDFOa1V3WGNsYlZaa21VOTJsVTkwOTdVbWJyQmNINmNM?=
 =?utf-8?B?M3d5ZkoweitHbWVvbWtOMWg2TEdHTzRuMXlSVXlnbjBNbFJ4d0xzSTl6bitz?=
 =?utf-8?B?cndXMG8xTk4wZEcxVFdaMTlVYlR6TVEzK0hGdnBuNTIwejFXUXdFOTh4YmV1?=
 =?utf-8?B?b3QrY05CVFlDQzlhTHF3Tm9YSThZQzJ4c0dOdnNyMUVSOVg1akFFbzZYeURB?=
 =?utf-8?B?UElTZXozQ2FEQ1pEa0szZEZMeEVmeEkzQyt4UGd3WjIvdlVwQ2l5ekVFa3B6?=
 =?utf-8?B?Z1B4UzdSOCtqT0lZYXBqcTh6TTBENW10VkdWcUkwTGh1SFdYc2JldThzMmpE?=
 =?utf-8?B?a2M4OGhhMFJuekowbkVSb3YrWkVDd0tXRVpiN3dLaDYvVVI2SmtTUDQ1Y0Ir?=
 =?utf-8?B?NXBaRHFXYVUyUGFTWEFwZGZreFBuMTFJNUx6RmVLYS9hcUU2blg3ak9lZVBL?=
 =?utf-8?B?TmlWWVNoVnFxamNxMU9JaW1EbHJpTDd1dVdDenpoamlhQk1CS1lWYnpxSldJ?=
 =?utf-8?B?WUZxTkdmN1hIUkJ1cUF5djBtck1JZXV3UFc0NmJ1bTZaZE9oQXk1UFR4NzU1?=
 =?utf-8?B?S3NDUXZvSGwxTWgvRFJTeFMwWmVvbFZ2eXZibUpSNStubVZNcUtwbE9TSGg2?=
 =?utf-8?B?V1hXSXZiWWYvSXorT2pxQ042T1FjMy9JdlVMNlhtazJRdFFCQi9rMHJRL3h4?=
 =?utf-8?B?NUZFb0pkOHV5SHp0Z1VyTUJ1Mnl1UkpSdE0zbUNTSDFZUzNxMHU4R2RVRUd4?=
 =?utf-8?B?alh2N0F1d1NmWFRQdVk5QVJEVDl4QVg2MGt4c01hN3dLUWJ0K0dteUt3bDMr?=
 =?utf-8?B?QzIrUjl1aWNJckRMUzdReFIxQ0x0UWlhMDV2VTFyYlBPckg4Qk04c3BVSUpR?=
 =?utf-8?B?d2hKQ1FCdnM4SWoyUmwrWXF3bVkzTmxmanorOUkvK2k2WVNIVWRjeGZNQ2VP?=
 =?utf-8?B?a1VHMDBiWGlpa2VqT3YwdEdtTVV2RGdDN05VY29RQ05tNStlNFg3N0xLeWx4?=
 =?utf-8?B?OWd1dnVKQzAyVC9QMTNldG1xY2ZFTFFUYzZ0M3BuWlM5UlplKy8wTXptb0JF?=
 =?utf-8?B?UUpjUTROdUJZZHRDNlBTZjVucWgzNlRQVVZkRkRiUHVKeWFoWHN6dHBSZXRh?=
 =?utf-8?B?R2dVWS9tUGpoMk5USFRSaFIzcmNnM0MvWWFzRm5QSlBhN2p5cUovYXJqL3dI?=
 =?utf-8?B?RE5sUGNla2xhTllzYTRyTHpkUjRhMUpNcjNxQjFNY0xKTTAweFQ2THlIcmx1?=
 =?utf-8?B?b0gxTzlYOHZZZkNPSmlqWHdlYWZKWXpsM1FSdGVxdjlmeGlSNGdnd1lnV3Az?=
 =?utf-8?B?K3JTcVVKUXF5M1A3c2sybzd5YVA2UXhhNVY0TXhqNXJ3RDFTWjVWT0FVd1NM?=
 =?utf-8?B?bjBjdG54MlJSc291Q1N2c215VVNuNlRiL25VVUM4UXlRNnhJd1RwRkhZSDZH?=
 =?utf-8?B?bVgwTWxXeXJOYXRvQklvRFFCVWtjaDU4M2NIU2VDVkc3bSt1ODUrS3lqN2Fq?=
 =?utf-8?B?UWl3ZTNiS0FQdXlmRUwzTVdZcmhPYUx2NCtHTThMaEV2KzArZXFodz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ccb980-c3b2-445d-ec4e-08df4b190780
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:24:58.3401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2kSR2Tb2QA03kWx6N4kFl55izZqWn6cXzL9Ti7/3/TlmOOAmHKCnIDZmFFuMPfEv6SaaSh1LkPADSsQmecIpHaK6d/nH3+f36AoEsDNg08Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR04MB684476
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 17:25:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5518

Hi Deepak,

On 11/25/26 12:26 PM, Deepak Das wrote:
> The FriendlyElec NanoPC-T4 is an RK3399 SBC with 4GB LPDDR3 RAM and
> 16GB onboard eMMC.
> 
> Documentation page:
> https://wiki.friendlyelec.com/wiki/index.php/NanoPC-T4
> 
> Specs:
> - Rockchip RK3399
> - Dual-Core Arm Cortex-A72 + Quad-Core Arm Cortex-A53
> - Arm Mali T860MP4 GPU
> - 4GB LPDDR3 RAM
> - 16GB eMMC
> - 1x Micro SD Card Slot
> - 1x M.2 M-Key (4-lane PCIe 2.1)
> - 1x Gigabit Ethernet
> - 802.11ac WiFi and Bluetooth
> - 1x USB3 Type-C, 2x USB3 HOST, 1x USB2 HOST
> - 1x HDMI 2.0, 1x eDP, 1x MIPI DSI, 2x MIPI CSI
> - 40-pin GPIO header
> - Debug UART at 1500000 baud
> - 12V DC input
> 
> Upstream U-Boot (nanopc-t4-rk3399_defconfig) and the upstream kernel
> device tree (rk3399-nanopc-t4.dts) are used.
> 
> Tested by building core-image-base on master and booting the wic
> image from the SD card to a login prompt.
> 
> AI-Generated: Claude Code, Opus 5.5
> Signed-off-by: Deepak Das <deepakdas.linux@gmail.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
