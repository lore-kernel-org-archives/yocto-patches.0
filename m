Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71671C61DB2
	for <webhook@archiver.kernel.org>; Fri, 13 Jun 2025 12:32:11 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.28])
 by mx.groups.io with SMTP id smtpd.web10.9234.1749817926447446124
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Jun 2025 05:32:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=DbnJlhHf;
 spf=pass (domain: cherry.de, ip: 52.101.66.28, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJpVGaUjaAltGsItkWb1kpHDSO0Swa79NL9mrfE8SthZy+Pu8SUKkmEec87P7/oGvXNY+iPBrfBh29Y22D1vVd9yB47tENjpR5iyKvM0TX/yw7YwMCKWr6aeUMQLnaLd+u9x2hrXL4zBb50S47X+LhOXrBE3e7ltSCdJU/RwRMQTU3npqOExut7NdXzQZNIwdWcM/TWQYZ7i5Fz/rUtBNUl1W3BzWPvbbByrWcVj5oYk3WyuqsxnNmVWqP50KFm+Bq957K8T0epHK5PynCWgvYddGfihnVZLGLXVGnh4CepWkv8d9JaS/+HD0Ll5g5NXxAfaiohTnmJ1FZ/DJ5a8yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrhSEKzbz7tCCB0DTxyfSduLfQEJQM1jk8LtYwqD6FA=;
 b=i9qY3RRfMYZ2kCmgLxp0dKCp6c4QgPT0zy8+1joVX0/8A60NZIRV3A4Kc/ek/i9eme94PXTeltjCBoVQpU3VKpWkDCsp+2+YBjkIdICmlYZfgN+g+5fl7Qo74vHfCha3H6MTxmhn5OOmDve0w1ONwIFJUYAOyd3+akrblG4DQbXRBMMkhzw/ffbGK7iDk/r09by8G7/+9l/0IwdbGvjrGQGUlrw9q0lSS9LXaZMFkwU1gKMcrcgeF4B7BkrzocxEgIXCSfuZdcHEyI1FEKIL7YnsvUR639iwXXSEt/9PtLy6ePK+cyoYue24f9Sb8XURQ5SiskPZmEWfJchgFDhfeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrhSEKzbz7tCCB0DTxyfSduLfQEJQM1jk8LtYwqD6FA=;
 b=DbnJlhHfUJpW3z154hYGeoS5t25Wr1b8mOb7cRo3Fo94fm4NFOivZpGS1yRFopALmwA0Zdc2RfeyDIziu5jMJPJuKDq4tXkZH5Rq+MV/JjTytUPqj/QLfGHtxtDqyTSZJ3csyA17zUN26GIeaOjmuWWbU2ckR45gH4WygTWEeKg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DBAPR04MB7462.eurprd04.prod.outlook.com (2603:10a6:10:1a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 12:32:02 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 12:32:02 +0000
Message-ID: <10a6a94d-2433-4517-9af5-5e78febfda79@cherry.de>
Date: Fri, 13 Jun 2025 14:32:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH 2/2] fitimage rework
To: yocto-patches@lists.yoctoproject.org
References: <20250613102357.1539-1-twoerner@gmail.com>
 <20250613102357.1539-2-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250613102357.1539-2-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OL1P279CA0026.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:13::13) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DBAPR04MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: f6f0779a-34a8-4ce4-9553-08ddaa764c97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Nk5uN3VGV0pHRVptSFVYbGJMRk53cVdZb3hra2pyTHQ5R0V2RkVhODNISU81?=
 =?utf-8?B?eTBvV1BCK3ZuaDdIMGZZN1VKWmJmNHppZW9yZ3JISktNcFNQWVliNGw0SWpo?=
 =?utf-8?B?TXdsUGlGcG0yTkJxTXROQ1IwWHZhaVZOVnpmUkFvRHFmMllCU3JiektOblkv?=
 =?utf-8?B?SUpvQk1BMlhXVG4rT2FNS095Z3ZCMC82cG01UzVyc1dEWHpxeUFQY1kvWGZ0?=
 =?utf-8?B?RThGK2FyM1ZZWnVnTVMrR1pTT2w3NkVFUzNBN2JCTGRSWHFSMlNkdnF5UDNq?=
 =?utf-8?B?M1owV3psTkZFWS9yanVpTHlTdXJPSjRjVUtNYnlRRDZjOU1MRWpRVkF6bjFt?=
 =?utf-8?B?cVhhSEtySE1XaThHamVadm5XdDUyR2VMZEk2UWhZZ1pOZEF4ZUZXc2d4cnBm?=
 =?utf-8?B?cEhTWm1vb2p5TEQ5OUtEVUhtSWhaRGsyaTM1TUNUcllOV1F1TkNkRlRRYkFP?=
 =?utf-8?B?NGFwQW5EbHQzUkNNMmlFb0tPTGJsTit1d2k3N3FLWHMwM3dqTUhkdkRwVGE5?=
 =?utf-8?B?ZXJtdTJidWIzT3RwZ05mVnFnMXZtaEd5aVpqbk9FVk12WEMwZzZiT0NSUitF?=
 =?utf-8?B?L20yYys2eFZiZFAzRUdoUm1NWlc1SFZRdGFnSnp3bDBqTkZESUxpcTRwcjlq?=
 =?utf-8?B?cW4xSENpNUhNRTFGVTdCWmdMbHpkZVJETzl5VU1NM2gyR1QrU3k2REt6YTFB?=
 =?utf-8?B?Sng1L0ZZQ0kzZGtHd3kxSlAxYStzTzNHVzIrS0RINVU0VUpTT1JJOUFYa3NR?=
 =?utf-8?B?dkd6NU9IVk5SMWthRGJpVm9nMDhHMEEwL1Z0cEZsVEdiaGUzS0xvd09BU1Yz?=
 =?utf-8?B?c3IxMjl1Q0xyc1QxcC9wMEVoNG82dDQ0L0oxcTJSTTZWMng5Qm95Y2JUOGhr?=
 =?utf-8?B?QXNORU0wdHllWnVGclpCTlhvVjZBdjFGNVI5bUhsL05NOU1ISy83eTdsd1ly?=
 =?utf-8?B?OWJQQXJzakxQNzJqTXVWVDdRS0VnTS9rNjBnUmZZMjZyblB3bWFHRU1lMXI0?=
 =?utf-8?B?NWZMQXdPeFZURlUwOS90N055OWZZNGhxaGpnR3VDU2NWRGhHY3VTSU45UU9k?=
 =?utf-8?B?TzhnNlA4Mmgzc2MrVEFlbU5tekppeHNLT3hIbHpNT0NTa0dxZFFoVVBTNWFG?=
 =?utf-8?B?MnZNaVZ1cXAvT2RxYXBlWmxCQ0QxSnlxRHhzejZvcnhIUUJ2VEpWUWExLzgv?=
 =?utf-8?B?Mk9nZTVuWmNLbzBNZzA4cmwwZEZtejYvbGJDemg3bGhOMjloTlJNeFYwWVVp?=
 =?utf-8?B?WHVnTjh4NzBFcW0vRWY2T0RERm9TZURnWVlES0ZFQms2UStSazFkTng4Ty9m?=
 =?utf-8?B?Z2VFOWpaSGZHMDAreGs1cXdIRFB0TXJBRVFjM3FzcUFJa0FncHdVQVRBMU80?=
 =?utf-8?B?MUpuckdpdnlrcjRPTmJ1R1ZvWUJDeW1WMlBPL0hRWEpaVjFrMWZKUjBqMm1F?=
 =?utf-8?B?RWpGTHpGeWtLZWxPWksvQXVsMENmQ0tlaWNwMEl4a200S3AvOTIrdFFLb3Ba?=
 =?utf-8?B?V0ZDVmxONDBCTjBBaThFWDdTa1dFYWF1b2hJeGFhV1UxTmxxVFp0WkNpait4?=
 =?utf-8?B?dUNVU1h1cjBhQ2sxWk5UMVdScy9VNTlLbXpTU0h2NGZJYi9PbkQ5dStOT2pY?=
 =?utf-8?B?WGVFb0VoUVU0MmtHMTlodVVTZXhBMlVGcFA4SmdVSDlIeEJhVGFlbTMzNzAx?=
 =?utf-8?B?Y0t0dmgzQXlFemNLUVorWlExVmpHR2Rack15UHJUR1ZhczdRTzBWbUwzMTNm?=
 =?utf-8?B?NzVWTldUekVNNm9SSVliV1o5WXMxRHNLU2FHTUVPaEpEYWI0bTlNR2h5MzZa?=
 =?utf-8?B?b21pZWw3VVhQZzNwaDhBbkRVMU12ZzJTZEdjS1BVYkxPU0tQWnFtR3J0MlFL?=
 =?utf-8?B?M0gzbnlGV3RvUXc5Q0w5WElyd2ZHTE5DYUNJUnV6ZURIVC9YNkFIWnlkNmFi?=
 =?utf-8?Q?c0TEZygrLV4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dUFTdWErVzdnRFBaSE1ON1VYZU1ZaWt6ZzhtUEdVQnRqUncra3ZXWHh0Q25B?=
 =?utf-8?B?c2NHdU9UQVF2U2JQQ01teitRcHd6SW9wdjVBaWhmSklrZ2QyQkJZUlhsYk8w?=
 =?utf-8?B?WU9QWU96Z0NBN1cwR0FaclpOUENoRkcyb21QUWtlRmIzZ3JzRFZ2T3FESWx4?=
 =?utf-8?B?bE9JZ3lEWEVpN2NqL2pzWmtDME4rYlg1UHRtOHZxWVh5M1RJUlh4S0ZzbDIy?=
 =?utf-8?B?QXpNYzJVdlFjTGswTG9WKytVbFpST3JVRlF5bVJaRXRtUzRUVFR1Z3ZtZndO?=
 =?utf-8?B?dG1pdm13TXJwLzBOankvR0hidXlnNStnL1FnTEtRcCtkVTFUckVrdmpTTDV6?=
 =?utf-8?B?ZmdKQjFjalBLSlVzSUo0cFRuMEt6VURjZ1RFZThBVkl3WWRnUmQ0cnIzdkpO?=
 =?utf-8?B?a0U4SUhPRFNkTCtUODcxcGhpVkJyUWR0cVpKL1VuT0tiZm51RG5yVU0ya3Nq?=
 =?utf-8?B?V1kvZVFsTyt1VlJNb1dIK1JKcmJzcVJjYVJZcVNWRU5XNWdRV0JlT2tYbUNh?=
 =?utf-8?B?MTVLVk84UXprdCtsam9Ha1EwSUM4U0ZsdGtXV1FGc3YvQUVRS0t4ZlhNUllh?=
 =?utf-8?B?QVhFaVpQS2hIZHBGdTVsdEdGWkJsR3gxa1grUG1Ud2tIOEYyUWtITjBadW5p?=
 =?utf-8?B?K1g2OStEMGlwdi80dEJWalRWcGpDaTJOTWNvdzQ4b09rZTJEelhEcEMrTC8y?=
 =?utf-8?B?Vm82bW1TeUZJMjEzQkErRG1FV0syN1ZnUWh0YXhyOEhObE04N2liQmd4TkEz?=
 =?utf-8?B?MWM2ZEpEcVU2Ry9WemIwSm43NTdXbk5nbE5uUURadDVBUHppZkNveVptTXpF?=
 =?utf-8?B?Y3Y2bjB4WmpzcERCQit4QW5qT3lHQjhvRU1IS2VGQ0lUdDNFbVI5ejBOMlJr?=
 =?utf-8?B?SDM5azllV0wySm5rZHFXZ2k2c3o4a0pPUWcySnBibWFuaEtsbkYzV2pLVFNT?=
 =?utf-8?B?SE5ZU2hGdUpYM1huQVJwTGhDaHdiNVBheS85bUs0dUNjc1NmbUdaRWcvM09F?=
 =?utf-8?B?UXE3R3RiY1RGT0RtQzBTSnlaWit6cGMzUVJVN2ZmRW8rZXdLcktBN1h0MWVR?=
 =?utf-8?B?MXljR1BHRW1UUlRxN0I5WlUvdy9LM09KSU1DMGFORXlmQU15WGpucWZjYWtv?=
 =?utf-8?B?QlhEdUg3aTl4S0dLUzdCalNCTG90MFF1eFFLRmNOS2s2RE9jSWRycW1td3Vo?=
 =?utf-8?B?NFJqa2pqWWp5U1lYNkFXVlk4RUpxNWpSMkNZNVJWL2w0RWp5WU1Wam5sWmxO?=
 =?utf-8?B?UTdoMlFYMHJRY0w4L3VsWCtJSENTem1WNXhJSStIMmpBU2pxQnZweXBIbkFC?=
 =?utf-8?B?cjl6RHJLZXpzRVVCSEJLUjJsWnlKOC9BdGJtMm9jMC9WRnUvZ2xSa3ZzMkM4?=
 =?utf-8?B?OUFxbXJJMC9zU1R4bTJNRTJRWmI3ZUNVRXIzZnJLb25XUmova3RRU1E1RDBL?=
 =?utf-8?B?OXJiMlFlMnRtS2Y3VEVHZTZBQy9FckIwdUNUNEtnYVJpc1RkcHVmSXpzQWpX?=
 =?utf-8?B?Q1JLeG0yaEd0Wk0vSjZLbVE4U0kxZFNidnRnaTF6bU9mNWpud0NkaDZVOEFU?=
 =?utf-8?B?OVJvczF5a0taV1pzczZsZkVsMk0zT0pGbnpLRGtwZ0Z0SXBPdk5UQmRlVGFQ?=
 =?utf-8?B?Ny9QR3g3eVF5SXdnc0ZxWWlscjcyZ0ZNSFhzQ3dLNUVTM014bHlYZjhobnBR?=
 =?utf-8?B?cndFWTJJVnJyVGZaOUJwTzRHWkhGZzVSbGdvU1NRYndFRVJIYjRteVJmdmlv?=
 =?utf-8?B?NkdkaWRlUGdPdThMZ1BSSTdRWGdHd1Zsc0pQVHBsRFBiNVRYbUhGYU5manQx?=
 =?utf-8?B?WE9ucHdOSnAycGFaNjJUY2ZUa2t3dTFiMklUSmc2YVJxVHowRnY5Y1FiWnB5?=
 =?utf-8?B?QmFKT1IzdzM2VjJXRlZrRWl2VFJxaEs0MHNCY1NlY3ZQcTM3SWZaWG8yNlJM?=
 =?utf-8?B?dlNsOFlLdVpjMXZsOWxxdWtQRG1VT09CZXpQZ3cyS2ZuOGdUd3BzRlVUQ0Rm?=
 =?utf-8?B?bmlUczAvaW1TUDBhcGhqRDhqYmRVeXIzQmNLSzVQTFBvUzlKT2YyMW5jY0RZ?=
 =?utf-8?B?QXVzamtYY3lXL1praUdxZEYwZ1NLMm1GR1c0MHlQMXhxay9GdXZTZUxYc2p0?=
 =?utf-8?B?ZWVtN3FUNnhhWFdzM0JqT2tkdGdJMlI5VnBUZEVvNFlEMGo0c2lBTkxjWVRH?=
 =?utf-8?B?Znc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f0779a-34a8-4ce4-9553-08ddaa764c97
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 12:32:02.5514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1iDiZQjXmkqrpZD01HKCt0VM9HJGXx71JOZxGOTL4kXJey0cQ31R+1Cxijlr3be6AddvO0J/oKMEd6JOF9vv9Ys5fRqFZgG782oSCzWHNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7462
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Jun 2025 12:32:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1640

Hi Trevor,

On 6/13/25 12:23 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> oe-core has completely re-written the fitImage support starting roughly at
> commit [1], update meta-rockchip to match.
> 

Thanks for looking into that!

> Most of the MACHINEs in meta-rockchip use a fitImage, but some don't. Create
> a boolean variable (RK_FITIMAGE), enabled by default, to keep track of which
> ones do and which ones don't. Use this variable to decide how to configure
> various image-related fields.
> 
> Run tested on the following with RAUC configured:
> 	- nanopi-m4b
> 	- nanopi-r2s
> 	- radxa-zero-3e
> 	- rock-pi-4b
> 	- rock-pi-e
> 	- rock-pi-s
> 
> Run tested on the following without RAUC:
> 	- radxa-zero-3e
> 	- rock-pi-e
> 	- rock-pi-s
> 
> [1] oe-core: 3442d9297dca ("oe-selftest: fitimage: test external dtb")
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>   conf/machine/include/px30.inc              | 3 +--
>   conf/machine/include/rk3066.inc            | 1 +
>   conf/machine/include/rk3188.inc            | 1 +
>   conf/machine/include/rk3288.inc            | 1 +
>   conf/machine/include/rk3308.inc            | 3 +--
>   conf/machine/include/rk3328.inc            | 3 +--
>   conf/machine/include/rk3399.inc            | 3 +--
>   conf/machine/include/rk3566.inc            | 3 +--
>   conf/machine/include/rk3568.inc            | 3 +--
>   conf/machine/include/rk3588s.inc           | 3 +--
>   conf/machine/include/rockchip-defaults.inc | 2 ++
>   conf/machine/include/rockchip-extlinux.inc | 8 ++++----
>   conf/machine/include/rockchip-fitimage.inc | 4 ++++

Missing info in the top README about this new variable I believe?

>   13 files changed, 20 insertions(+), 18 deletions(-)
>   create mode 100644 conf/machine/include/rockchip-fitimage.inc
> 
> diff --git a/conf/machine/include/px30.inc b/conf/machine/include/px30.inc
> index 8173cb19be2c..825c1fae76d7 100644
> --- a/conf/machine/include/px30.inc
> +++ b/conf/machine/include/px30.inc
> @@ -11,8 +11,7 @@ require conf/machine/include/arm/armv8a/tune-cortexa35.inc
>   require conf/machine/include/rockchip-wic.inc
>   
>   KBUILD_DEFCONFIG ?= "defconfig"
> -KERNEL_CLASSES = "kernel-fitimage"
> -KERNEL_IMAGETYPE ?= "fitImage"
> +require conf/machine/include/rockchip-fitimage.inc

question: should this be only included when RK_FITIMAGE = "True"?

some sort of inherit_defer but for require? Or maybe we should set the 
variables in rockchip-fitimage only if RK_FITIMAGE = "True" and leave 
them as is if False?

It seems like SoCs with RK_FITIMAGE = "False" should not inherit 
rockchip-fitimage.inc and those with True should? What happens if you 
have a board outside of meta-rockchip with px30 which you don't want to 
support fitImage by default (that's my case, so I guess I'll need to 
build this to figure it out :) ).

>   
>   TFA_PLATFORM = "px30"
>   TFA_BUILD_TARGET = "bl31"
> diff --git a/conf/machine/include/rk3066.inc b/conf/machine/include/rk3066.inc
> index a898309bbf88..dc0c7734812c 100644
> --- a/conf/machine/include/rk3066.inc
> +++ b/conf/machine/include/rk3066.inc
> @@ -9,6 +9,7 @@ require conf/machine/include/arm/armv7a/tune-cortexa9.inc
>   
>   SERIAL_CONSOLES = "115200;ttyS2"
>   
> +RK_FITIMAGE = "False"
>   KBUILD_DEFCONFIG = "multi_v7_defconfig"
>   KERNEL_FEATURES:append:rk3066 = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
>   KERNEL_IMAGETYPE ?= "zImage"
> diff --git a/conf/machine/include/rk3188.inc b/conf/machine/include/rk3188.inc
> index 554d4f1c904d..3e1fc7e70822 100644
> --- a/conf/machine/include/rk3188.inc
> +++ b/conf/machine/include/rk3188.inc
> @@ -9,6 +9,7 @@ require conf/machine/include/arm/armv7a/tune-cortexa9.inc
>   
>   SERIAL_CONSOLES = "115200;ttyFIQ0"
>   
> +RK_FITIMAGE = "False"
>   KBUILD_DEFCONFIG = "multi_v7_defconfig"
>   KERNEL_FEATURES:append:rk3188 = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
>   KERNEL_IMAGETYPE ?= "zImage"
> diff --git a/conf/machine/include/rk3288.inc b/conf/machine/include/rk3288.inc
> index 06fda69a3eb7..5cc117e633fc 100644
> --- a/conf/machine/include/rk3288.inc
> +++ b/conf/machine/include/rk3288.inc
> @@ -9,6 +9,7 @@ require conf/machine/include/arm/armv7a/tune-cortexa17.inc
>   
>   SERIAL_CONSOLES = "115200;ttyS2"
>   
> +RK_FITIMAGE = "False"
>   KBUILD_DEFCONFIG ?= "multi_v7_defconfig"
>   KERNEL_FEATURES:append:rk3288 = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
>   KERNEL_IMAGETYPE ?= "zImage"
> diff --git a/conf/machine/include/rk3308.inc b/conf/machine/include/rk3308.inc
> index d30901f15b4f..ce1cebee1aac 100644
> --- a/conf/machine/include/rk3308.inc
> +++ b/conf/machine/include/rk3308.inc
> @@ -13,8 +13,7 @@ SERIAL_CONSOLES = "1500000;ttyS0"
>   
>   KBUILD_DEFCONFIG ?= "defconfig"
>   KERNEL_FEATURES:append:rk3308 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
> -KERNEL_CLASSES = "kernel-fitimage"
> -KERNEL_IMAGETYPE ?= "fitImage"
> +require conf/machine/include/rockchip-fitimage.inc
>   
>   UBOOT_SUFFIX ?= "itb"
>   UBOOT_ENTRYPOINT ?= "0x06000000"
> diff --git a/conf/machine/include/rk3328.inc b/conf/machine/include/rk3328.inc
> index e6f810dcd2ca..4924b06f030a 100644
> --- a/conf/machine/include/rk3328.inc
> +++ b/conf/machine/include/rk3328.inc
> @@ -12,8 +12,7 @@ require conf/machine/include/rockchip-wic.inc
>   
>   KBUILD_DEFCONFIG ?= "defconfig"
>   KERNEL_FEATURES:append:rk3328 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
> -KERNEL_CLASSES = "kernel-fitimage"
> -KERNEL_IMAGETYPE ?= "fitImage"
> +require conf/machine/include/rockchip-fitimage.inc
>   
>   TFA_PLATFORM = "rk3328"
>   TFA_BUILD_TARGET = "bl31"
> diff --git a/conf/machine/include/rk3399.inc b/conf/machine/include/rk3399.inc
> index cd1be49064ed..eb23f49370fc 100644
> --- a/conf/machine/include/rk3399.inc
> +++ b/conf/machine/include/rk3399.inc
> @@ -12,8 +12,7 @@ require conf/machine/include/rockchip-wic.inc
>   
>   KBUILD_DEFCONFIG ?= "defconfig"
>   KERNEL_FEATURES:append:rk3399 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
> -KERNEL_CLASSES = "kernel-fitimage"
> -KERNEL_IMAGETYPE ?= "fitImage"
> +require conf/machine/include/rockchip-fitimage.inc
>   
>   TFA_PLATFORM = "rk3399"
>   TFA_BUILD_TARGET = "bl31"
> diff --git a/conf/machine/include/rk3566.inc b/conf/machine/include/rk3566.inc
> index 6386ec7eb51c..c9647a66aa42 100644
> --- a/conf/machine/include/rk3566.inc
> +++ b/conf/machine/include/rk3566.inc
> @@ -11,8 +11,7 @@ require conf/machine/include/rockchip-wic.inc
>   
>   KBUILD_DEFCONFIG ?= "defconfig"
>   KERNEL_FEATURES:append:rk3566 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
> -KERNEL_CLASSES = "kernel-fitimage"
> -KERNEL_IMAGETYPE ?= "fitImage"
> +require conf/machine/include/rockchip-fitimage.inc
>   
>   PREFERRED_PROVIDER_trusted-firmware-a = "rockchip-rkbin-tf-a"
>   PREFERRED_PROVIDER_optee-os = "rockchip-rkbin-optee-os"
> diff --git a/conf/machine/include/rk3568.inc b/conf/machine/include/rk3568.inc
> index bcf9dd8b0f44..e89aa388951a 100644
> --- a/conf/machine/include/rk3568.inc
> +++ b/conf/machine/include/rk3568.inc
> @@ -11,8 +11,7 @@ require conf/machine/include/rockchip-wic.inc
>   
>   KBUILD_DEFCONFIG ?= "defconfig"
>   KERNEL_FEATURES:append:rk3568 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
> -KERNEL_CLASSES = "kernel-fitimage"
> -KERNEL_IMAGETYPE ?= "fitImage"
> +require conf/machine/include/rockchip-fitimage.inc
>   
>   PREFERRED_PROVIDER_trusted-firmware-a = "rockchip-rkbin-tf-a"
>   PREFERRED_PROVIDER_optee-os = "rockchip-rkbin-optee-os"
> diff --git a/conf/machine/include/rk3588s.inc b/conf/machine/include/rk3588s.inc
> index 6ec344abae5b..265244753b5a 100644
> --- a/conf/machine/include/rk3588s.inc
> +++ b/conf/machine/include/rk3588s.inc
> @@ -10,8 +10,7 @@ require conf/machine/include/rockchip-wic.inc
>   
>   KBUILD_DEFCONFIG ?= "defconfig"
>   KERNEL_FEATURES:append:rk3588s = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
> -KERNEL_CLASSES = "kernel-fitimage"
> -KERNEL_IMAGETYPE ?= "fitImage"
> +require conf/machine/include/rockchip-fitimage.inc
>   
>   PREFERRED_PROVIDER_trusted-firmware-a = "rockchip-rkbin-tf-a"
>   PREFERRED_PROVIDER_optee-os = "rockchip-rkbin-optee-os"
> diff --git a/conf/machine/include/rockchip-defaults.inc b/conf/machine/include/rockchip-defaults.inc
> index 85ec7b944d1d..3835408ed8d2 100644
> --- a/conf/machine/include/rockchip-defaults.inc
> +++ b/conf/machine/include/rockchip-defaults.inc
> @@ -1,7 +1,9 @@
>   # meta-rockchip default settings
>   MACHINEOVERRIDES =. "${@bb.utils.contains('ROCKCHIP_CLOSED_TPL', '1', 'closed-tpl:', '', d)}"
>   MACHINEOVERRIDES =. "rockchip:"
> +
>   # kernel
> +RK_FITIMAGE ?= "True"

What about using a more typical 0/1 like we do for other variables? 
ENABLE_STATELESS_VPU_GST or RKBIN_DDR_RECONFIGURE for example?

>   PREFERRED_PROVIDER_virtual/kernel ?= "linux-yocto"
>   KCONFIG_MODE ?= "alldefconfig"
>   
> diff --git a/conf/machine/include/rockchip-extlinux.inc b/conf/machine/include/rockchip-extlinux.inc
> index fddab735bbf7..95a38d4dad0c 100644
> --- a/conf/machine/include/rockchip-extlinux.inc
> +++ b/conf/machine/include/rockchip-extlinux.inc
> @@ -13,13 +13,13 @@ NONFITDT ?= "${@d.getVar('KERNEL_DEVICETREE').split()[0].split('/')[1]}"
>   
>   UBOOT_EXTLINUX ?= "1"
>   UBOOT_EXTLINUX_ROOT ?= "root=PARTLABEL=rootfsA"
> -UBOOT_EXTLINUX_FDTDIR ?= "${@bb.utils.contains('KERNEL_IMAGETYPE', 'fitImage', '', '/boot', d)}"
> -UBOOT_EXTLINUX_FDT ?= "${@bb.utils.contains('KERNEL_IMAGETYPE', 'fitImage', '', '/boot/${NONFITDT}', d)}"
> +UBOOT_EXTLINUX_FDTDIR ?= "${@ '' if bb.utils.to_boolean(d.getVar('RK_FITIMAGE'),False) else '/boot'}"
> +UBOOT_EXTLINUX_FDT ?= "${@ '' if bb.utils.to_boolean(d.getVar('RK_FITIMAGE'),False) else '/boot/${NONFITDT}'}"

I guess you can avoid the ,False part as the default is None, which 
should fail your if condition. Just a matter of taste though.

>   UBOOT_EXTLINUX_CONSOLE ?= "earlycon console=tty1 console=${RK_CONSOLE_DEVICE},${RK_CONSOLE_BAUD}n8"
>   UBOOT_EXTLINUX_KERNEL_ARGS ?= "rootwait rw rootfstype=ext4"
> -UBOOT_EXTLINUX_KERNEL_IMAGE ?= "/boot/${KERNEL_IMAGETYPE}"
> +UBOOT_EXTLINUX_KERNEL_IMAGE ?= "/boot/${@ 'fitImage' if bb.utils.to_boolean(d.getVar('RK_FITIMAGE'),False) else '${KERNEL_IMAGETYPE}'}"

Ditto.

>   UBOOT_EXTLINUX_LABELS ?= "default"
>   UBOOT_EXTLINUX_MENU_DESCRIPTION:default ?= "${MACHINE}"
>   
>   MACHINE_ESSENTIAL_EXTRA_RDEPENDS += "u-boot-extlinux"
> -MACHINE_ESSENTIAL_EXTRA_RDEPENDS += "kernel-image ${@bb.utils.contains('KERNEL_IMAGETYPE', 'fitImage', '', 'kernel-devicetree', d)}"
> +MACHINE_ESSENTIAL_EXTRA_RDEPENDS += "${@ 'linux-yocto-fitimage' if bb.utils.to_boolean(d.getVar('RK_FITIMAGE'),False) else 'kernel-devicetree'}"
> diff --git a/conf/machine/include/rockchip-fitimage.inc b/conf/machine/include/rockchip-fitimage.inc
> new file mode 100644
> index 000000000000..e275faf70349
> --- /dev/null
> +++ b/conf/machine/include/rockchip-fitimage.inc
> @@ -0,0 +1,4 @@
> +KERNEL_CLASSES += "kernel-fit-extra-artifacts"
> +KERNEL_IMAGETYPE = "Image"
> +RRECOMMENDS:${KERNEL_PACKAGE_NAME}-base = ""
> +KERNEL_DEPLOY_DEPEND = "linux-yocto-fitimage:do_deploy"

Should this be a ?= so that we can easily override/change it?

Looks ok to me otherwise, I have px30, rk3399 and rk3588 boards which do 
not use fit images so I'll try to check this next week. Considering 
meta-rockchip doesn't build at all anymore, I guess you may want to fix 
this ASAP your way and I can figure out a way to fix it up "further" for 
non-fitimages scenario?).

Cheers,
Quentin

