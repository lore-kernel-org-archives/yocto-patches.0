Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5649EC44506
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 17:12:03 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.61])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16730.1769015515923360181
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 21 Jan 2026 09:11:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=C9sqEWAp;
 spf=pass (domain: cherry.de, ip: 40.107.162.61, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWbd5KzEsebXveBGwvrrE5StdFzDNwiNXxnwg15tTlm1mlVBEYtOM35Ly4dWdLdryIJqiSqj7+wgl4DRaxH8is8ws06SyKpskR3taciTQ0NA1uc5F/EWCkDwtWLzSADRUjhhtHGnMZOZJj2DrOrSK5NRZr7QhY68u4JK5GvHYgFIEUUQ6YavCrJECtmvISG21YnmYCOCK9wa9kLWxB9UujnYBjrEO9oHAWA/eVPXhLFy6twi5fKLXYWhS3W8lv4QSv9jU4GexU49u/jm82SU23ROxoJCNAb1PTLI0LjFZF05Gt6qbkGqYCsuxCUBXXVB0icS2akPkkz8gFFnnSG6og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTRBCFdlocdcHgavU592LbpzeE2dc7sJG+sv1JKW4MM=;
 b=lVKVLqKUJzlrKbP0YEhFqpuGniC6kTJC5OSWKlwjk68kSqg/Zh8kTmCsK7EXjo5xVEEjIq0rQbgE6EXkocZz7+9NEUrnx94VyGAs3P3Q6w7jgeqZ3ykK95oG5yPUACOjCvcrldDUeZrnF/t1vTCy5c3b/XENCkHZSL6enFwQcNDjkxGqG9I2O0+b6mdcNDvsLWZNGKIT8RcaDNKwhau/yIKpUzTxLNU0axprCpaUBVDV8y4FsJ2ixyfwvNzYz3XcwIBMR/h7sgG/JlrwPcjQx3c4mEf9HmhyergMlQGEqwvQDBfo5RuzfgOR2/k5SMvcOUVGn8fxhXpIsYXaaWTskw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTRBCFdlocdcHgavU592LbpzeE2dc7sJG+sv1JKW4MM=;
 b=C9sqEWApQ80UfWs5o4/fzGRaKwtp1G4eD80rEogM27lZS9pjf9/F4cK5k48R2qsYAS93T8JKvzHXHkLTQamxRwGi+KDdpVAfHZ8GA9kX5EYbWDMm1Jwo3KSzd2GsQfuR8j1M0715d3sbKB2DtGaNyVfgaKruI1zSpTSP+PsByKY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AMBPR04MB12184.eurprd04.prod.outlook.com (2603:10a6:20b:758::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 17:11:52 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 17:11:51 +0000
Message-ID: <07c9526d-259f-4ef2-894a-076599bbe045@cherry.de>
Date: Wed, 21 Jan 2026 18:11:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH meta-rockchip] bsp: fix upstream TF-A deploy desync
To: Quentin Schulz <foss+yocto@0leil.net>,
 yocto-patches@lists.yoctoproject.org
Cc: Trevor Woerner <twoerner@gmail.com>, Peter Hoyes <peter.hoyes@arm.com>
References: <20260121-tf-a-fix-v1-1-02f7b61db7f8@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260121-tf-a-fix-v1-1-02f7b61db7f8@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR0P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::16) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AMBPR04MB12184:EE_
X-MS-Office365-Filtering-Correlation-Id: 830ec2a3-c92b-4a4b-65e7-08de59102b7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?R2JZZEREdnFma29tMTZLcnhCQW1GZ3M5QzYwOEM2czJYL2dHTkViM1BPRUhr?=
 =?utf-8?B?UEh1NnJIUzM2V2k2RlpSZXc5VXlZM29Qd2M4OTNTZnljOFRNWWdtSnFCblNy?=
 =?utf-8?B?OXorMFZVekFXMFNhdzUrV09BN24yOXJCVzVQZnFxTXBoSGFQQjREOUoyK1A0?=
 =?utf-8?B?SXBKVThGanpKN2tNaHRJUkVzQmk4MjVHUGpoK3FwNHVpVHZqQUxudUw0ZkNp?=
 =?utf-8?B?RENhcTZPZzBRVU1Ed2szUlBjNWhBOWxGUmpRWlBhL09MOG1UWEl3ZllpdDVv?=
 =?utf-8?B?ZE0rSCsvZHpGTFFMditXdFVPTUJXTFJScnIzb0VCS2Z0OWxGbFk1NjEzR0Va?=
 =?utf-8?B?MzVhOVJSTWt3Yi83b3h3Tk5qaUcxYmpxWngvZXpJVFM2L1AwYit6QmJHL3d6?=
 =?utf-8?B?UFprYnBYbnNGQVlTMlZ6azBiL0N1Yk85THN2d1pQQ0EyZVdPNTJNaFRLUDRV?=
 =?utf-8?B?b2tUbkowUjFZRVFxcXpNR1NtcDhneU54d0YxTkRZQ3pueS9mRENScHExYWhu?=
 =?utf-8?B?ckwxcVo2MmtWYnl2SFQ2K0lyeEdTQzZBcGQ3WTZXNDlQMDNQQjd4TG9tRkd2?=
 =?utf-8?B?aEIra1lHQVRPbEdjdG81ejZZQ0MvaEppV21IaFYrWGdRVVFsSmdxQ1FaV2NQ?=
 =?utf-8?B?aFlYa2g0ZTBkSXdxQ05jRlZNeWdCN096bG95ZFFwcC91RTcyZm81WGtFYmU0?=
 =?utf-8?B?WVZkd3NQU0hGaFdKL2g0Q2drOFRmZ2Q3SEZvQkJrVitnU3ozdFBBSFFxUVE1?=
 =?utf-8?B?bkZFeFNISW5UMGJleDF4emY5QTdhRlNnejEvaDY2Y2IrSzZwbHBWSys2RTdp?=
 =?utf-8?B?RzhWK3ZuYTU2VHVIaVQxU1pHVXBBNzd0YmhVTU1xcERqendxVzliV0dHS1lj?=
 =?utf-8?B?Q2M2aTF5VkRzdU5DN2dhU1RCZ0xZeVdIemVlUENNZHRWSmtTQVZjdEJVdzVt?=
 =?utf-8?B?LzFkdlZ4Qms5dVhtS1dYUW92WHE1YldnVndXRWdaem1OSmZPUFd3SjAyRDUr?=
 =?utf-8?B?MjgyYlozcjBYVklhbTJ4Y0FRa3pmei9mSC9rR25rTFArQzJ4bEJaYlZ1ZWJL?=
 =?utf-8?B?WHlMam91Wk1GS3QrNElqL0MyZ2lEVGhSNmszV2tRenk5UHEyZkVqOW9LVjln?=
 =?utf-8?B?UTM4T0FLZG9TeTdjRHl4QyswRVh1Wm03N2k1WGlKWGpSOC9RSkRSNU02RXht?=
 =?utf-8?B?eTZyLzVaLzJmVUdObUZEdlZKdlQzMlpkR3RmeG5lR05WVGJ6NjJLVlZWK1kw?=
 =?utf-8?B?Yzd3aDNSUTBNTGtKUElyM0JwaUZGdG8vK05teVBDYUM2L0drSHNuQjNEQ3Bx?=
 =?utf-8?B?bUx0b3FRdFRuajhJUk9DUlIvMGtBWElWTmlPZy9hSTUzbnVzdkh4ZndPL3pQ?=
 =?utf-8?B?eWgvTE9lQVNLT1V3VkZGVzZLN05XVXo4VWJ3bzBaUTAvZ3lPVW5tVHlZTjJN?=
 =?utf-8?B?NDlBTlVuSmxRL0ZRdEFYVXNjU0liUUdqS2M2WEMwZVJIL2pPMVVabUtSZWlZ?=
 =?utf-8?B?MUMvd2ZBN0VqTzBBM20zeHVXdGlGOXZFVUhqRWlDUjJWOGVUdW1lem9zdzJo?=
 =?utf-8?B?VnNETXErdU5VQ0FsSlc2bjRSbElSL3c3SGZWTHY3cVpKNU9BVVEva0d4SFY3?=
 =?utf-8?B?RlZwMVordUtDZkRsN2QrczVielZJNmd1YUMvSFpQOGZmaFV4WHIxQ0E1OHVj?=
 =?utf-8?B?SVVzL2VxenptaW9ETE12QWlBZjZjTHZ6TGo0L3ArYVU5ajkvOUY3dW1LbHl6?=
 =?utf-8?B?aThPTkZ6cVlPLzBVblJ4d1FSQmRFenNySWpySUZvWndoUjNra0tpczVlOGdN?=
 =?utf-8?B?Wnd5b3Rxb2l4N2c3WUpoY2VON3YwR3p2VU9PbkdxSE5Ga29GSWdPWUU0bVBG?=
 =?utf-8?B?QlZoblErTlc4U2phNFQ5Z1dnL3FYdnpEZVUxbXVGR2kvMStKMGpPS1ZWaERk?=
 =?utf-8?B?TjVwUEJwaGFTNlpmOGJnT0tXSUVvdHh0bFFISmp1ZjBrTm9kaStJNmhOd2dE?=
 =?utf-8?B?MFlSVm44ZVcyT0wrbEdvdGpTYnJ5Q3dTaTErUGdCcHBxaTRERmFtYTd1a2N6?=
 =?utf-8?B?eDdtTFREV2JCY1ByMkFPaXV0QkdxK3BQd2cwaXNscjFtRHBOVW1CWHdmenox?=
 =?utf-8?Q?e4Bs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WVpEb3hBcmwwZEZpZTJYUHNBaWVJYzZKN2tYSVhlbExLK2lOOXgxanZ4RTlH?=
 =?utf-8?B?Mmt0MWpqL2dUOTFJU3NlYmdrNWloNTNCSmVnb3N0KzZUeDhuNnBSTUthYU1M?=
 =?utf-8?B?M0E4QVJieUZDaHAwYyt1TGw1VlJMTHVWS2pJbnRqc3BQcElGamxySjFLQkNu?=
 =?utf-8?B?cUhmdTY5VUMvbDQydFU4MGQxU3pRdWZzSGhOcmVFcXRlRGUxcFBPVnB2SG1M?=
 =?utf-8?B?aUtVZ2VJVGhiRzFTSzEwQm1vYlBXL3BGR1JTUU85eVJ1UlhRVjhGVmtPWHc3?=
 =?utf-8?B?NE1EOCtoeVRPcXZ2aUFXK3dZNkFpN1JZYWlJbnh5QmYrOGt0UHY5NmlIT1FX?=
 =?utf-8?B?ajJVZGxZVzYvMllvOGtvc1IrOEt1WG9BZHdwa2hIMnpLei9yYlhBYVVRbEdR?=
 =?utf-8?B?cTBTcVB0c3lEdG1DYStpLzdCb2w3Umg1Qk8zSGVwUlpaK0R0UEplVWFVZU0y?=
 =?utf-8?B?WmplK2RXMWNTa1ZXTzN3M0tiRVZXMTZDbGxUY2xkTG4yNjdVWUszS0lYcy9y?=
 =?utf-8?B?S3pVTFEybkpzRUgzTWh0YlZ6WkJjelI2RUMwZTVGWXpPcktDM3RCYk1ZSkI1?=
 =?utf-8?B?N1dpeW1CM3BOWGUrVFg3TFJQaVN1S2M4UmFrTi83alpMUU5pRUg3UE9yREE0?=
 =?utf-8?B?Z3RGV1Q3K0RiVzRSYTVBMlBnSnZ0OEg2V0YzRUw3blFoMlQvbU5HY1BHaW5F?=
 =?utf-8?B?SlNQNEIrWFlBSnNXaHhsa2FJQm1oWjkxMnhUR1RoYi91Z3VBN2tkbHZRMTNj?=
 =?utf-8?B?V3RrTkVlTDM5RkZPMTFlQ21INWhneWdYV3hrUUJqZlhOdVZuQkthOG9sTnhh?=
 =?utf-8?B?bzVlZW9VUGk2QWZvTnlrdFJQcUFPbno4TE8zT3hHVDBJQnptMWVjOE5rV2lx?=
 =?utf-8?B?bzRTbDJ2TmhycEczeEkvaDVsd0J0TGFFNkZNTkVVREVMdDVST3VoMnRtWGNT?=
 =?utf-8?B?MnZoYjR6dlg0Rnh1OHh4ams5SGJNRXZqamNYcDRvRUJYYkNyTXdmZDd4U1hK?=
 =?utf-8?B?TDBoVEpqUzBkd0g4ZktPanF6a25BQ0xKODIyUzdCRkRSdno1dDNGbmo0aFFk?=
 =?utf-8?B?anVHTm9WZG5ISE5xYk0zL2EyRXROdEM1dEVaeWw0WWtXQnN1M2hlTldMUVlN?=
 =?utf-8?B?UnlmaXlPL3RRNlNEeXVSNWtubVVGL1BSUGtGMUF6RXFkRUJaWERuQ2tnMTM2?=
 =?utf-8?B?OGNKNjY5MzBJbGI2STZsMVNVK081bEhMa3dubDRBUTQ4bzRLZUMxTXlRbWkr?=
 =?utf-8?B?SlVzbDZ5UGZNZnV5MVhPSHMvUjliMFZLdmxwZ3Jvbk1yOWo5dUxGb0Rac2VD?=
 =?utf-8?B?ck14V0VSaGNhOTV3MWgyMHBUcmxwY3duWkRPTWZCaHNwQ2Y3WDdtVEhnbW05?=
 =?utf-8?B?THgyZFZZaVlXUDFjQXdDOVduMXNwMmhCOTRqNVhBQm81ZFhPZElrcVNTNzJm?=
 =?utf-8?B?WEVnOHc1cUtOQVpIb1V5VmFPK1Z3OUQ2RGhMQnpUaEF2d1BQM29tcWwrdXpt?=
 =?utf-8?B?b2NWZ0kyU3g3ci8rRU5FcS93a0xGMER1em85emp5Y1Exa1NXNzBWUFJKRzNx?=
 =?utf-8?B?Y0JMYy9OY3NDdjBlT29rdGlKWHhsRUtZUEw2UUNXRUNHTWpHRHU1a3NJU2Z3?=
 =?utf-8?B?ajhzVXZzWm9KVFU2NllDQnE4Z0Rja3ppbURyaDJ4SXlyZnFEVlJXWmZVQW9G?=
 =?utf-8?B?NGpBVXNhRzRHdk1CbGFzcFpVTjAvMkw1ajhLeC9xYVp2UzNZWExnL3E0MXl0?=
 =?utf-8?B?QThISWZGUkpXc25vaFdvby9yWWlHZCtrdHBzanBEVFpsc05PZU15S0QxV2lY?=
 =?utf-8?B?Y3hSTUFKSk5WRzBUSDNXVzZpWGtBY1duaEM2WE5sYWtqWlBvK00wNFg3bWlN?=
 =?utf-8?B?THprS1N2ek53dC9PZFpKWndPYjR5ckF0TzN1Y0xoTGw3cXdkTTJEZ2hFVmpp?=
 =?utf-8?B?ekNJUCtMSU5leDE4UGNBNW84Z05mZ3gxTFV1Q0ovckVBa1lmWEg1TTFXc25j?=
 =?utf-8?B?RE0wbEM1TE5ZM1pxZzg0aXR1R2Z3L3l3d2JnWHdXNjZ5bnVDZzBIRjJNMlpG?=
 =?utf-8?B?bmpiaXdZeVlQZ3NyRzFiMXVWQndBU2N4Y1h5c3Z3R2U4bVRNOHR2VzUrOUsx?=
 =?utf-8?B?ZlduRG5taUtnNVd5S0NlZjM1ZFNVMk1QMy9Nb2ZWelJiYzNGZW5vdGN0c1pv?=
 =?utf-8?B?aXNsdzNhUEtDK09ITG9xWEd1TkE1VTViNHVDNXltM0NCUE9wL0xLN3hSdmJ4?=
 =?utf-8?B?ODhJNm45UUhKeE9TMnB2Rm4zeWFMRlNzcldCUlNLWndqU0tFNzhaKzhBWU9H?=
 =?utf-8?B?c05DZ3BZTjM5S3Q3NjZ2aHdON0lSNlR3ZFFyWS9zRUV3aFc0K2hBaUU0aWI5?=
 =?utf-8?Q?Mx/E6qaKJRPOY1gp89lMWbqx/81A+0MIlsquc?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 830ec2a3-c92b-4a4b-65e7-08de59102b7d
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:11:51.8053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lTR7puDt7lRTH4KN9pKabpD54LHorXL96tEY5bfe3X7E95WwHGg9FO44qYZ45REWAR/YnTqEDg8RrOEbylEWMtVundMnE2cBXzFWCiB0L+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12184
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 21 Jan 2026 17:12:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3045

Hi Trevor,

On 1/21/26 6:06 PM, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Since commit 7bce36a2c64b ("arm/trusted-firmware-a: Use
> firmware.bbclass") in meta-arm, the BL31 firmware is deployed in a
> subdirectory named trusted-firmware-a and the binary is simply called
> bl31.elf without any other string.
> 
> This differs from what it used to be by the use of the subdirectory and
> the name of the file itself. This is an issue for us because the U-Boot
> recipe is given the path to the BL31 binary in deploy directory and that
> now was wrong.
> 
> The second issue is that we want rockchip-rkbin-tf-a to be a drop-in
> replacement for the upstream recipe and have nothing to change in other
> recipes dependent on *an* implementation of TF-A (such as the U-Boot
> recipe).
> 
> We can either fixup the path like was done in 2a13a49da4af ("fix u-boot
> for tf-a firmware") but we'll need to do that for all current and future
> SoCs (and also wasn't a complete fix as for example px30 didn't have the
> fixup applied). Or we can simply adapt the rockchip-rkbin-tf-a recipe to
> deploy the same way that the upstream trusted-firmware-a recipe does by
> installing in a trusted-firmware-a subdirectory, simply name the binary
> bl31.elf and update the BL31 environment variable in the U-Boot recipe
> to use the new path.
> 
> Because RKBIN_DEPLOY_FILENAME now contains a directory in it, we need to
> make sure the directory is created (with install -D).
> 
> This was tested with upstream+downstream TF-A for RK3588, upstream TF-A
> for RK3399 and PX30.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> This is a follow-up to
> https://lore.kernel.org/yocto-meta-arm/28377373-a3e8-4416-aa7f-488cdfdbcf55@cherry.de/T/#m76f7d4b56849cc28fe80a76953f4e6e61ff0f7cc
> and
> https://lore.kernel.org/yocto-patches/dd990ccd-a418-45bc-b708-d3b1fc763ea5@cherry.de/

Forgot to say, but I think you want to branch off a whinlatter branch 
*before* this patch as the meta-arm commit that broke us is only in 
master and not whinlatter.

Cheers,
Quentin

