Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF07C5AD49
	for <webhook@archiver.kernel.org>; Mon,  2 Jun 2025 10:26:55 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.14])
 by mx.groups.io with SMTP id smtpd.web10.46467.1748860009684630561
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 02 Jun 2025 03:26:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=D7mXNrrr;
 spf=pass (domain: cherry.de, ip: 40.107.162.14, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5E0Sgbtng1XvZ1nMJd8rEY8AVqsmTWM6Gerf0ArtFLaZQbP3b4F6R7dOcQKYLY2LNeMOfIG/C23KuHO2R4PcxPEtl0pIL2jiMIu9uXl4eZmZMx324sws+z0zoxXuJ3C43k7Ste9UBKWinZ2kzt3pCxRlxNq7zY7TX5IIPS8sXwaNtrrSke9npVvT891199dthJyjlrbfmkiJewoUmncBPeRrsJHvhxr5iNxD8AYRIpRdaEPKOVvWZ7dcC3yRrePdwK/F/k+YP0PXTmfZRdg1MpQbMIG5cz2sE3YA1MwciPnNPJgbyxqq5zo3t0pet/30BV03DkMc2IVcpGCiHvVxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCgEmGNdg1TndpjTj7fzbbVLnISLxU31SzEikDcCej4=;
 b=G6d9ah3B312Hr+f6ppPJwlmhvwrNllmgv+8CJT/FQRSHbNX+ZvDxk8zKlyKN8gthdzP/apuV6QsCp0VQ+v35p7TfmfUB7sRiTc6YAdYgLk8nqyYGj/xhCqBFoFrP9KAt3GOPM6vIXp4K0Niepvj7rlDO382osytzqC3AsRRkiTAUEAd/rmpZh35KSZ/MjfVUDxiqdTeJAROIuktpW82eEk4/CyaJ5AT4ayPJQ2B6gBJOHB+Fe3MgwAVW2fFGHS8to0+me20gxeNFSM5noLywUgZ1/CsbYnnDahqd2nMKR1NEfzaa35kRZpc8eQjuVXIvU6Ul2gxLyBCi1+GRLcsqbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCgEmGNdg1TndpjTj7fzbbVLnISLxU31SzEikDcCej4=;
 b=D7mXNrrrlKjGCRp/PivjPHf2VFrgkGZ0Ngx8QY/gvjCyqBotBUsT30SnfHazt9/vn0qpwFRdJlfGvKOqcowdemLnxYXW//E4N9cKnzKbRa/ACNQVY4fMh/QGd+MIbyvXKgPisczsGXHtrThZmmPC5d9soqpHUoSfjgMShf+/Ngo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB7537.eurprd04.prod.outlook.com (2603:10a6:20b:282::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 10:26:46 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8769.037; Mon, 2 Jun 2025
 10:26:46 +0000
Message-ID: <7f4205a2-49b8-40a8-9819-0047f891f8fa@cherry.de>
Date: Mon, 2 Jun 2025 12:26:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][scarthgap][PATCH 1/2] rauc-conf:
 adjust PACKAGE_ARCH only when using the demo
To: yocto-patches@lists.yoctoproject.org
References: <20250530172234.7393-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250530172234.7393-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0050.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: 751cd7d1-7c3b-4f17-651d-08dda1bff9de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VkpySVhJcllxb0ZSaGphTTFsdVRXSWJ0RTVkNU15UjE2NGdHdkpmbExlVjZk?=
 =?utf-8?B?YmJmd3JBNjdIeEhqd3VnSzZhbW02a2Q2UDhONzhXNzcxY0dBK2NSamxFdjh2?=
 =?utf-8?B?OUp4TE9VM2I0dzdSTHMzbWo3YmRkNmxzT1VKR2xLV2paSHJGMkJDZ0h1YW1R?=
 =?utf-8?B?UzBIVWlJM2M3aTArMlY3SUxzTXRpb3lOYzdZWENkUDhJK3R2RThINDlzVzFl?=
 =?utf-8?B?WFJEODZpajdVelVFSkdPM1ZwbVhGSTVDSmdNUGFIZXZVb0ZUOEo1NDNra0Nw?=
 =?utf-8?B?STZlNlRRcSt3Rloxa3k0SENuOXlxeFpkUE1PcHNjUnp0NVBlbms0TEtCa2oz?=
 =?utf-8?B?TkQvYTNRT2JZZjRBL1FobW9QZlUxa2JyZWk0MnNjSWRjUEhoeTZNQ095SzRp?=
 =?utf-8?B?UGVrMDNqSE9ieG93aGp6TFJjanRoNkdqWHhiYVhGdmUyY3A0WkVBZGMyMG5M?=
 =?utf-8?B?K0dzbUZPNkJqUmNSZVpKdW1Xb1pqMXZnbmZqUkFWV0Q4QU9mSEpMc3FzaUNm?=
 =?utf-8?B?SmVVU0xkRC9WaEh5RUE0dTNqK1N3TnFhdmprdzBKc0FObS9WK1VIcExrS1Zl?=
 =?utf-8?B?M0p2aXZ3cGloZW9UN1pOWkhOT3IxNDBDemtzTTlwemlBZVNhY1phRVozbkd0?=
 =?utf-8?B?cnFLYXp5bVhFcnhnN25aMHVVWHN4WGQ1TytVN09sTHZPSGM1Z3pLK0YyY3pn?=
 =?utf-8?B?L21SczRUWTFaMDUycmRGb2RGeElGVTlQRCtESXBaZ1dlMEs4Y3RYT2RTU3ln?=
 =?utf-8?B?T1U2cDA2eE45L1VhV0thdDZlc2xPeEo2V2hab0Q1QXRvdjlpVk1XdmQrL3o1?=
 =?utf-8?B?MHBSRHNLTHZmcjM5NS9sZnZ4azJ2blFzZnVHUExlQzRsdG1MZmE0OXo3ajJ0?=
 =?utf-8?B?V1E1aFExUVBWaitvYUJWZTJ0QjdxMXdNaEV6dDJ6R0o0ZkRDN2YwVXFRWWhm?=
 =?utf-8?B?OGFIU1pmYy9RRGgyR2piaG9EZEdQa09FampzcWtvSzVMSHo1bHRiL2gvRWlU?=
 =?utf-8?B?aXU4R2dubi9ta3dPb1EwS3NKblRHQy9rVTdhNVBUT2tESFQ0WHdZczZXSTdv?=
 =?utf-8?B?czI1b0hRdkVVWWUwTzJlTVBGa3E1YnBiTjZ1Yjc1d2JDNFBvZFlSN1FjMXNp?=
 =?utf-8?B?RlN3Z0RBalpWOUpJR2RFMkRFNjNuS0pkaWFDcDBSNmpDYXJEYzBWbVBNaDUx?=
 =?utf-8?B?eG5OL0d2cW9Mc2hkUjFlMXVoWnJGaE4vVHJqZGIrQ21tY05HWkNJMWYzd3Fz?=
 =?utf-8?B?OCtRa0RJb3hpTFdJb05uUWNHMFhYYy9xTTR2RFRGaTI5MDRub01YUTVQSVY1?=
 =?utf-8?B?V0hveHdDZDU2RUJaL1Q3RGt4RUIvZmJ4czhGdld1ZGpuNnpXUVVlMmx1WWZ2?=
 =?utf-8?B?WWR1ZWxGTWFTUy9RdjNudy82dTdEZ1VQNkZRZFZTOTYrSGtEa0k1VFZGbkhE?=
 =?utf-8?B?Z29WZjZNTTdJdVR6VXgzU2Q4ako4eW1iTDZFMmsvbUxhZGRTTEM3WEJtMW5L?=
 =?utf-8?B?YitmdGhIVTZFVCt5VGVqdWwzbTViV1k5RzR3Ry9jVVRtbEZSTXpHVmNBK0hR?=
 =?utf-8?B?REFnd0VVNGRRMFR3djk3dDJCOXVPTVRrd213M1h3REtFcHhSU0xDcHk0YWNn?=
 =?utf-8?B?SXFCeE1pSjRpUlhmaGF1cGowNmpGdGtqQVNxRGJUb092dExZVkhuRDhpelBV?=
 =?utf-8?B?SVN0N1Eza0EzdVVFT3U0ZjFaelRMQmhrRlQzZ2U1MU5TSDNCQ0l0VFhpZkVL?=
 =?utf-8?B?ZC9oWE94c2dlUmZYUFZHcUExNElmcU1JOGRaL1FPRUozUEVOVWNVcGtTODB6?=
 =?utf-8?B?bEx5WFpiTDB5NWJSZU1MRW95UEZOcllDMVhZREM0T2NPQitqajVIUUZYSWlD?=
 =?utf-8?B?ZEtSZXFrOFJoK280aTRYNXFRN2NvSFZpQ1ZKRjJxam1Temd0RkU1d0hiczBm?=
 =?utf-8?Q?R45p3qVb8rg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S0dCMWYwSjdoS2dVSHEyci83THpEcTY0ZGMrWldSL0hnMll1Vkd4cnRHeWtM?=
 =?utf-8?B?MytlSkJzYnNjUVNMOERsZG54UmdWRnJldUJ3U0lSTjUrd3NkVUU4SG5aUDli?=
 =?utf-8?B?ejRudVBJV2wvelpRNWZkWnNkTkZ5T1NKQ1NIakowZzdtWVRickZZYXQ4OTBQ?=
 =?utf-8?B?THBrRklQTWVwVXZra3pyNjZCR1ZHTXZSMU1iMEViNmRVQ0VOc1Bib1ZmbWxj?=
 =?utf-8?B?Vm16T05VOWcxRzQ0eUhkeUhlb0NrYSsxU3hwbWtQY1MzbXkyanVwZjFPSWt5?=
 =?utf-8?B?K2FQNUhSUTM1TjVleXI3dFRodi9aTVZVQVNnOWtXZTYxSUFOdlJGUWk5cjY3?=
 =?utf-8?B?UHJaTmpFYit0WU55K2NNaUJIVWJhakVBcVZiUkU0eSszdTZQUW1YZk51STFK?=
 =?utf-8?B?U3pDTTRwSlovVyszUy9TbWh0bUtyS1JraHBCbmNnZjVzdnhhMitSZy95UzNn?=
 =?utf-8?B?QmZwZGZRU0RGdStvaVB6Q2p4QWpYOC95a0VuTkNUbGUvKzZjb2dpMkUzRlVw?=
 =?utf-8?B?ejBiUFl5Ukh5OHEvQlFPV1NmTEVDVTc4YmtpdjFvTXRCWnZ2SVBIdEowSTBV?=
 =?utf-8?B?Mm5Zb0dyWHZodHpNbjdpR2JxdjdBclpFOE0rSlJ5QWhOekZWUnduL0d3dHo1?=
 =?utf-8?B?eTZvNUxFVTNhNDJEMDl1U3ZobFpjelFUQVYrMzhrekEybzIrWEZLZkZjWVpQ?=
 =?utf-8?B?Vk81dkpOV1lZVE9TaEl5V2VmY1haQlYySjhFY202OGdPeU4wZ0Z2QTRoUndX?=
 =?utf-8?B?cUNLeTlGaHEzS0Y0UFA4RE5JQU1XZUI1RS9mMjB2TTdsTkxrNkxROUxZcEpZ?=
 =?utf-8?B?YWJTZCt5bURVVkhWVDlQdDNVUXUvc0lTMzNkaEk3RVpIUkxWMG11bzVOd2p5?=
 =?utf-8?B?S0E1ZFhIOXN3SC9ISHlzMWJhemkxRlZyQ2NmODdPVy9pdVZoZ0hMWlNLN3Uw?=
 =?utf-8?B?ZFpwbDVaNkFlRUFEZEQrT0RKMjB6N0N5eTlSQXNPQko5QXNnR0lZd0ZqRWMz?=
 =?utf-8?B?WGpFWVR5N2ZBV2JsRzByMjNJdUVoTEg2VHd3ZlJxaWlXYk9Kd1NQR3VmUHJK?=
 =?utf-8?B?bTNlZWtMdUhGQlBmQWcvaCtWeUhGVE1jY0lmTTlvb0VReXlya1pRdWV5Q3Ju?=
 =?utf-8?B?Z3NZOHZ4cmxsaEV5WDNad0ZwYkpSWXE1QVByUXcvQmFMK1RuUTRqNkNoYkVN?=
 =?utf-8?B?ckZvZVBKN1FkMUh3SjZMWlV5MDJTQnNQYUIyNXBCZUsrRUZ4M3NCTmg2S0My?=
 =?utf-8?B?dmlKWk42WGtxY3BlcU1ndlRJdTFUUHVNZTJkRmNJUUMrbS8xeGJsMXZOZTFF?=
 =?utf-8?B?UmJaV0tWc1FSa0J3RXg4TXMrd3dwa1QwbVp1Skd4TVdmTzcrVFdhaVUya05i?=
 =?utf-8?B?d3VmWmdzNlpTZzRmUWdBOERYRkRyRmZnb080UEszVzJTY2RIcmRPdGJJMzlY?=
 =?utf-8?B?Vmc0eDNZYWNyc1hLamZnV3h3N09oc3hWdEJITEhJUWY1WnFXU0RBTmk4YUlC?=
 =?utf-8?B?RjNsd3hkTlAyMnZxeGJCOE9Ob3pGTnN1QVFCcXc2b2dxM3ZOYkZucVV3RUFt?=
 =?utf-8?B?WElFZFFTbEw1RUgxRkhOYTRPU2J5TVU5cW5GUzNILzFxbG1XcnIvNENSL0Fp?=
 =?utf-8?B?OTVPemxpb044akw1MStrNEQ5RG9MckhLK3ZpTmFEUDBwalFhY1VoRC9zSWZ4?=
 =?utf-8?B?cmw3eVd5d3o4Z2N0U1pPZi9qTm1pRTFPVE9uTWNJVFJpcnJTNlhpeU1Yb2ds?=
 =?utf-8?B?dCtUL2w3T1ZGdVNOTUdUbkxQdmNGejRIVFNyaUZjR2FXQTMvZ0xPZUQ2MktW?=
 =?utf-8?B?c2tIbjhmcHBVZks3eUVTdWVHK1dFWGRpU3dBS0ZtQjljSHV6aUpWd09jYnNx?=
 =?utf-8?B?THhGTDZoN2ljRG5PU284cmhCWUc1dVJZUUVlZTg2VzlZUjZDSFZWS0lWZUxj?=
 =?utf-8?B?RUtnYXMxYXVMSDFNSE1FdllRdEo5clBSbzVsNDZ3NmRNYVhyT0Q0ejlpb3ly?=
 =?utf-8?B?WWJDWGZObUhBTVdhSURXSWI0YitDbk14aHZvMEVnZVo2Qkp1RCttOEpVS1ZP?=
 =?utf-8?B?dEplbTQyMTFOc0J6dFdvdzBBS0JQUEdNOExoeS9nK3V6Q3VkQjh2OGxMZzB0?=
 =?utf-8?B?U1hkd01FdVBFOEJ5T3YwdVJab0F1bUZHYkNzOE84clVRV2lvdFJPR3pMcWZY?=
 =?utf-8?B?cXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 751cd7d1-7c3b-4f17-651d-08dda1bff9de
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 10:26:46.0918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0LNrJ7BsdoYyj9i2tVO6pz/dILoq4TT+PPQNBLtcbitun8vqj+9jNpWo6K6LxTxcWxSjWyaEjnLd+/+Y19smZauvMIoqxJ+pxXXdzJyZsko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7537
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 02 Jun 2025 10:26:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1607

Hi Trevor,

On 5/30/25 7:22 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> Make setting the PACKAGE_ARCH occur only when the user has enabled the
> rk-rauc-demo feature.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

