Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A7ED5CC97
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 09:39:24 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18713.1765877954352220369
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 16 Dec 2025 01:39:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=DmUgqiYa;
 spf=pass (domain: cherry.de, ip: 52.101.83.52, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8iYjDyIBMjtfbrCIN9uycKLrIrO0bNEps5M2GUf6ZeeoWbdxUmYgiF7ac1mQaAfzecyGfwGG5NALIdyWfzP0hyAJ6y6BxKiSeblx3Wkrysbb1kBn4JPDm9SPx7xW9SS+7kT9uqhviMhVZkuvNNhUU3Xwl1Ib2EGTPfDi/fIf+SmTkAbasvNrS1S2/5MFYy9F8att54b/UHDh/QcN0Z3sDoxJYVyLudyuFczU/5FV/oMalO0MMI+CsZ+QBIvNQ/UTv4nvgA/pSXSh5Sv8SI03x0ng/JMFVfIDk4zorK8nVG7J3ZsPi43pm0dVuhiZkCS/xmYb8NeEtApqHXbQi45eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zc96/BNQ6DDTcfE7g5pYBpvSwlGCKuAsX61LthXDck=;
 b=lbxo4pKEJMuCMhgStBB9BaScbApJKThRWablOfRduE20sISEKMiKmeG5tatzMyZZCvd40yRcnMqDgv2WHjUoNS8OjZ2bnj+wLfjWyFndI1/QqVum37D/dSqGJzvBZVzNoU+g7TfmLUCzz1Ce1f+jLoJOJo1aBNswDOm2UOEwpPly6J8bO62pplSVI2kr+eBwl6Vob4R/jUayeKatWUujtbcFsA1E2iMz3o7lflUbJkNAmORncMCItFiSTknrfF3VABYuhX9Aj3dd15kHh4Gu06mDEV+Ig/UbidEpYEmBEMb7wjyUDY3zB+e3QdQhmxT+uE0lKYe2sl316yRJIPVUfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zc96/BNQ6DDTcfE7g5pYBpvSwlGCKuAsX61LthXDck=;
 b=DmUgqiYaDCTwIk3S8VGtmEI4jVxzF2GjTjcBURG2NeMt091H3xecOnMoUO03ZMO5cXn/YpT27CrufP4nCm7XNqxw9SJ9Ae6wNw5LaAae4HaFGqdnXXK7CN1a1YxM77ftgOZvlYFcS/ToWTYhRU0bEqjCfqGlX5OGWc1hPurFqTM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PAXPR04MB8319.eurprd04.prod.outlook.com (2603:10a6:102:1c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 09:39:09 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 09:39:09 +0000
Message-ID: <c9e558db-8aa1-4d0b-bba1-451d038edbf1@cherry.de>
Date: Tue, 16 Dec 2025 10:38:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-dpdk][PATCH] README: change mailing list
 for patch contribution
To: yocto-patches@lists.yoctoproject.org, meta-intel@lists.yoctoproject.org
References: <20251216021516.2600042-1-anuj.mittal@oss.qualcomm.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251216021516.2600042-1-anuj.mittal@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::10) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PAXPR04MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b66c00e-e5f5-4988-0ff5-08de3c86f6bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Ym4yL2F2bDFXQ1hkODdhNFUxV002aWJQU1U0N2tMMHgwSWxUTUI0WG0vTlZu?=
 =?utf-8?B?bmRTWUF2c0NWeTA4dEhpWjU4U1dBc0ROazlveEQ3d1BBc3FEV0JsN0hWZ3VK?=
 =?utf-8?B?ZTBTVjJQQk5heG9pZ2pIbGNNWkM0VlNVQURZRm52ZzhHNTN5cWttaE1XVDNo?=
 =?utf-8?B?ZkZ2bXJXMStFUHZwRFJxUnhib0JsOVFHbkViUEpaYk8waWhFSWVKTi9CNzd5?=
 =?utf-8?B?dVBaQ2plQ2FqMnZ3TEFlL1B3U2dFRGxsVHB5cVZlejc0MzNJZ0NyODFhLzI0?=
 =?utf-8?B?U0lvK0FzOWFET01obGc4TnNObzZrUFJrOGhtVi9yR0RxVFRVckJTQmhvV2RR?=
 =?utf-8?B?b2hZK042SmkvZ1Y0QzIxYVVMWjJzT1BsRFZEdDdPSHM0N3JEd2FtWTVFSmhm?=
 =?utf-8?B?dExEVzRNUHYvcktjOGMybTJJQUxZQThnUC9aaDNPKzhVa2toakRnZFl4ZFRD?=
 =?utf-8?B?OTRtU1AyN1c1YUtyVUwzN054b3F5UkJNeEwzVWppUmJPbVU4ZHN3c2dyN2NH?=
 =?utf-8?B?dmZHaCtUVVhDTjIwTGp1RGZGWWhwNDRmbTdvZTRlNm85NDI5T2xLb2JuMDFk?=
 =?utf-8?B?QUNvYXBBT3Mwb0VuNHJIbmk5TWltUzRGempsM2xaUi9qcURTaG1sYnB2clRK?=
 =?utf-8?B?S2JZYjkvaG4xQmt0THpBM08rS0lMaGNaUkZkK0FWd3RGK28vUHVWOHRtZTdn?=
 =?utf-8?B?WlgwNHJFNFZaUlViR2x4eHhNRHg4S1ZGTTU3b1VnL0tDdHZyVENxSC9RZlV4?=
 =?utf-8?B?aDRQNmNMVlpFZEFnZVhTdUFxZHhIUy9LNU14SWJISEgxbXo4b1BLa2dzek95?=
 =?utf-8?B?Vkh1N2o1eG1PK0hIWmdHVHpIL3pJb0tSb2gvNkVQeTUxVGlMRlFVMDJXZGpy?=
 =?utf-8?B?aU5PZDlZRmIwaWJiTGJqSUgvQ01tTk5PVlBKcTA1eGttb3NjOFVOQXBCR2JP?=
 =?utf-8?B?NkkxRWtNRnlHaHVCazEvUTFZZ2tzZW0wM0YxN2VPNDlFdi85c29GNW9WMWhS?=
 =?utf-8?B?cHMzazBsL0xCSDVwVmF0Qk8vL3Jtb21xYm5TSVhqRXdlZ01wZnBYVDErc3pL?=
 =?utf-8?B?ckZzUncyU3JIdXByVnZIZXBpN2dQSkcwNTVlVmxxZEcvekRrWmpQYXEwQnpv?=
 =?utf-8?B?cEZPUkVyUmgzNTQvSFhpWnl2WENhZEliME1VNjhnVk1HUm9ZY1NXNTlNZGM4?=
 =?utf-8?B?bkJPTlp3UURQcmZVS3I2SmpvQzFGWHJueVBFMnFEL2VJQ21yVld0WFRGN3cz?=
 =?utf-8?B?S0FyRTlPTnppKzhjYUNaUVhjT2RDYmgyTld1blJ0RzB6cWxlZmF2V0gxSWpB?=
 =?utf-8?B?amd3b0NxeTNJcHZBQ1R4ZUxsYng1OUxxTE1MdGtseTRleW9jd1NGT2FjOGZO?=
 =?utf-8?B?bUthYWRHOEZWeDB5T1B5ak03WTBES3NvNGNub1lpckhLMkNDNTdVV1dZWnky?=
 =?utf-8?B?NERzYzViL0J0bVZ3eGVWOVgzZ2dpM3BZZERmY2F1Vjhwd1V2R2E1aXkybW1s?=
 =?utf-8?B?UFRSbm4ydE9KUGMvUnZSUXhRSERYM2NsUmUvSHRBajRyNHdMdTY4Y25mdUZJ?=
 =?utf-8?B?SVZpdEY1Q0dxY20xRWRpQ2NUZ05vQ2JlczlJKzFBd2hkVm5pTVd0b2JLZlp2?=
 =?utf-8?B?dDRFUURzUEh3M2JJQ05VWDhUcGpwTFdDN2xlbFFuZitISlFBTlFBTG5hYUtj?=
 =?utf-8?B?Z2NYWjB1MXdORTVHQmxxRVpRMDMwVm9lS1duQ214NEhpb09BSXgySC9UVGRB?=
 =?utf-8?B?WDh5N3BjTXl4VUtBOUZBdy9RWmhjdlZoTFlxaVBOZ2Rlcjl0Nk5oUTJTck1h?=
 =?utf-8?B?b2piaGdoYlhkd0lmSEQ3ejFGeDRLQUMwRTg1eFlYckZ5ZkZqdEkzeDU4S2RC?=
 =?utf-8?B?RnFDTjZsTHpCQ3lZUGhHYWltR1Iwc2d3R0JRMjNneEsyaWc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V0h4d25NckY5SnF4VEVEMWEzaWNyd3F1MGpNdUYwaFpJdFFxK2lNcGtCWEdn?=
 =?utf-8?B?bjJwcVUxUjRuQ0tJbTYyUFhxOTByN0pHWG0vbUpSVndpYllrQzJPTW5kVTBI?=
 =?utf-8?B?YS9QdUtyLytXVTRtMkgzQTg1YXhOOXhBS1pSMFdjZmJXbjFQcG5BOTJDQUg0?=
 =?utf-8?B?WGpJSmhBUVZLUGtQVlV2bUxNMTBvWHBsVmFZMTZXSkhDckEzRDI0alBRdGRo?=
 =?utf-8?B?MExyR2sxZUsralYwTWdHalUrTkdReFU2WTlQQTFSank0dHYzZVl0RjdOV1Vz?=
 =?utf-8?B?RU4vUUE0ZnJVOFRVbzJ2WFNsWnZWSEJLKytCWXY1cGtRL2RSQzFBZG5NWDRO?=
 =?utf-8?B?a2NYa1ErZWZROENnMkR2U0dhbDR0akYza2hOeWtVTW1mbzZ5dkJjcGpqS3lI?=
 =?utf-8?B?aFFycEpydDlUQ0lheXhlY2RlVHc1QU9ZRmtEcmdDbnlRMC9ScnpHVzZLVU92?=
 =?utf-8?B?MGdYd0dUNWZwbmt0cDY5S3JKblJqUjhFaGpFQTEwZ0ZCcFJjcDdackdoVENz?=
 =?utf-8?B?cG1ZNmdtM0VBTC9aMS9YNDl6NGJwVFVrSG9IYXljZ3pwcHlhVnprMk5YNG90?=
 =?utf-8?B?bHIwdjhQOWhnM3F1ODBtTVY5NzNkR0h6V2JYa3VlbkgzUE5NNXJXV2I2UnRK?=
 =?utf-8?B?VUx6WGUrK0s0Q3UxQUYra3VZaEJ4bGdRYUdCS1BwQmQyUnJzbTBiN05XMm96?=
 =?utf-8?B?SzZXbTlhMWpJcW5wUU5POWQ2dklua3JLeU9icy9XdGFPMW4yYzZkQVFha2Zw?=
 =?utf-8?B?SjgrdFhSVnJud3Ezam14N3dObk5DZXN2RlpSb2R0WHdTWEtRRkhWdVlaZkhu?=
 =?utf-8?B?ZU5PTm5CM2tNUk1xcEorNVhUamlVUFBTUWxHNGl3TzZPdjNxd0NWNld1NUoz?=
 =?utf-8?B?aEpDYS9EY20xRkFYckhwaVhCcG9xWCs1S29mcDVJd24vc0E1WksrcFJFc2h4?=
 =?utf-8?B?cytzQ1cvMkNWRXJJbzUzN1h6RjJmZTNzSk5PcnBXR21xVkhPSmZBbVduK1N4?=
 =?utf-8?B?TTdCSzYvd3M1dWpzQ2dkZ2N5dXltK29KaGd4bndUYUw2VjVZZDBkVWNkN3h2?=
 =?utf-8?B?czhSVXZheFA1WkdGamFJbjk4UURQYlBMUWNMNXNZREJXY1FHNXAreVFtZEU0?=
 =?utf-8?B?aXJha1p6OTFHY1NFVXMvS1c3aWpoWWJvL3lNY0UwdDE2a2dueDRLNmVGWEJv?=
 =?utf-8?B?NzJFYUhSL3ZIQXNwNm1MU1JzRlMrdnp4ajIwbU5jWFdNL0k4OWF3UU1MWXdq?=
 =?utf-8?B?UW94U0hwMEpuN3l6TWJNamgyLzZKdm1MSjdXMWVqaTduS2g1MDkrUkJqREpv?=
 =?utf-8?B?dDhqeUFWUXZyNkE5dFlSa0lmQnQrREdRUnRySzdRbUwybGdiMzVUa2xraE9J?=
 =?utf-8?B?cVFRMkkwYUE1T1dHV2ZWZzBWdlJjM0JKZXY0N3pWT2M2UGxvaHhieE5wbWVR?=
 =?utf-8?B?VFpyTTh5eFZ1MXRUUHYrc0tGS0lLZm1nRXpwREJpUmpjTGxwYVdhbktpeStU?=
 =?utf-8?B?Nm82WWlMeHM5b0pHcStVZUdkdTJBVlg0UHFwOG1hUThnNUhtMGpXMzRaNG4v?=
 =?utf-8?B?eEg0UzFEa2YybXR3VGNaUkJ0dTc2enI3dHBJOGhNVVQxVTI2WndMM1Iwa21K?=
 =?utf-8?B?ZTc5TnZQcXd0UUNwVVpobGxFYjFsMWtHaTdVTDUvckUyQ1o0MGdjZzZBRG9D?=
 =?utf-8?B?L1F2ZmwwU1ozVlNIMC9WUE5zK1puaEF1Mm9LeURFVmRtRTRxLzdkMXVyaFVV?=
 =?utf-8?B?Ky9jQS9Ia3Jxa3RVOHRJWSt5VXppbEYya0VwMXNOdkZ2cnJYdlNoWDFaL3Fx?=
 =?utf-8?B?NkdObWtSSVhWUmhzTEdQOW9yOUoxRklLRTJnMm4yZUpUNk9VSmVYem5UUllQ?=
 =?utf-8?B?UWhoeGtHd1pCUGQ5SW5uR1BhN1lkRktTOTlhZ3JubFlYb0o2SDVsKzdaWDJS?=
 =?utf-8?B?OTJZakNpVWNuRmpDTE1qdVEydXZUa3RUVm03ZmVUY0taeVZGQXA2SC9GMy8y?=
 =?utf-8?B?SGVKNUpWRkI2Y2lTc2hSMnRaL3pUaWNoR2J3K0swOWhqQXVaeUNLRExibGNh?=
 =?utf-8?B?VEZTYmVEeFZ5UDM3Q0phU2djUGZ3VFppNE1zT09ua1duYlFQVkxqTlp4aU9Q?=
 =?utf-8?B?QUJmQzlyTFA1R3luRDBXczA0ZVVBVDRpSGREeWxvN25sa2lqa1RtRkxOZ2lX?=
 =?utf-8?Q?l2JVQvDZwje4uqDvzX7Vk6c=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b66c00e-e5f5-4988-0ff5-08de3c86f6bc
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 09:39:09.6759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGs4EIvrjolGlbnSi/9sqEM7lkaVBTktEyaEo/qnMMGxoXlONdVHGunhpRLehBtXQDCY3vZ03MThfEPnERKXol9EMs6dmluivF3W32AREjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8319
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 16 Dec 2025 09:39:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2798

Hi Anuj,

On 12/16/25 3:15 AM, Anuj Mittal via lists.yoctoproject.org wrote:
> [You don't often get email from anuj.mittal=oss.qualcomm.com@lists.yoctoproject.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
> 
> yocto-patches is a more appropriate list for meta-dpdk since this is not
> Intel specific.
> 

I don't see any mention of adding [meta-dpdk] subject (and how to do it) 
so that a patch sent to the ML is known to be applied to that tree? See 
https://git.yoctoproject.org/meta-rockchip/tree/README#n251 for an example.

You may want to add a .b4-config, see 
https://git.yoctoproject.org/meta-rockchip/tree/.b4-config for an 
example. See https://b4.docs.kernel.org/ for documentation on that tool :)

Cheers,
Quentin

