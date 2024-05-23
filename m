Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32F0C25B75
	for <webhook@archiver.kernel.org>; Thu, 23 May 2024 08:00:09 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.117])
 by mx.groups.io with SMTP id smtpd.web11.11688.1716451206843838745
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 23 May 2024 01:00:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=JnJKfWaB;
 spf=pass (domain: cherry.de, ip: 40.107.7.117, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i74+e3reTUMdyNwcoxNguIosomMACTyOu0UpNyszQuZdoNzyOfUulL8c+GfpfpZgIROT/OmSnFIWZ65KWh39yxpLQ9dFpFzlsIeC2BKSEiM+lrsuzncHw22Zxb+7YRsGdXMRyZs2NuOWBkhmyhmDeN9X+NpuhVeVw8Q+6/1iAQXYFl9w9R9PuVJlQW1v0BvqnGaKDglztCHMhEmoWBUY6Bd8spjSP430XnWYmUonRtoMEXt4Swc8CGI45yNV0CA7Kws/DAL8ZCdFhutubgHWUNSx6O4G+t5t1lPJi3/bBBXsLRgRnE1pqNzus9jMlRTbVa0JnrZ/KRjUWmrQE2QNWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZU3P2XbF8ZMmDxfW2uAHgybtcJz2Aa2QgFUNV8CjaRY=;
 b=a4khbQawbPJFE8nIEwf58McnNXxM8ElfJITP99bKyfwSljrE9w52mWaMjdM9etSLziUyzj4mU/smG2hxfurH1nelCPjkre58fA7TQJHngU1lFhFeO6O0qoMbyqSiP38hiU+I/1+MzBuV0FwheQS6dDRnmRJk7NzcrT+v4dnTxlopwkq+igYuBcPHZAlps1Cw0WeA0WlG7fD79mekk8XBTY4VqbH6enY8F//E6WfVtGWHfaGN1zkewRsZL/+zdB4s9KAurCIbrxn+2CLkcLgqpGa4MyQd6ElPPh4UQDHo1EmiRDF1B+6mXtt4p3gefTWP9et2rADaQ03FR1idpCHI3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZU3P2XbF8ZMmDxfW2uAHgybtcJz2Aa2QgFUNV8CjaRY=;
 b=JnJKfWaBGv+afCfMyRwbXXqGcd8JCOSxm+HAT9hCTVm8bLGP9dL2n1CHYopIITG7I9H9q21ajGbrtJbx/NfTIx3KHP5QLcCvLAbq1B8MWwe2yKmSeEMhMpPZOqqPDOG/JCW/LhRqv5HIf/fBixIXnycE9PgM/tciaSG5Oc3VSws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM0PR04MB6578.eurprd04.prod.outlook.com (2603:10a6:208:16e::11)
 by VE1PR04MB7486.eurprd04.prod.outlook.com (2603:10a6:800:1b2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 07:59:58 +0000
Received: from AM0PR04MB6578.eurprd04.prod.outlook.com
 ([fe80::b0f9:e7f8:2613:eefd]) by AM0PR04MB6578.eurprd04.prod.outlook.com
 ([fe80::b0f9:e7f8:2613:eefd%3]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 07:59:58 +0000
Message-ID: <33348692-1d85-4d29-a36f-ed5c2530b8c2@cherry.de>
Date: Thu, 23 May 2024 09:59:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH 2/4] specify root partition
 type
To: yocto-patches@lists.yoctoproject.org
References: <20240522230808.14409-1-twoerner@gmail.com>
 <20240522230808.14409-2-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240522230808.14409-2-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0038.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::8) To AM0PR04MB6578.eurprd04.prod.outlook.com
 (2603:10a6:208:16e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6578:EE_|VE1PR04MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fc95b1e-2164-4340-9bef-08dc7afe56fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZFZOVDkxUncvNmhnMmZuV3RFemRMNGtTblZ1T1d3eFl0dmE0UElYZS9ocDZu?=
 =?utf-8?B?NUxNdndpOVdubmsrclNLL291a254TWYyVUdNSnVvd2tlOFpzNXpYdTlhZkpx?=
 =?utf-8?B?SHpUS0I2c1FGSzZGbmNHTzFIdlAwWW5NMjk0OU1kSWJkQTlFNk1QQlBVeWQy?=
 =?utf-8?B?QnhMZXJ0UTE4bVpJOTRqZ1U2MS9nVk5yNlNUWFdmcm1oRlJjUnd5T29Td3BD?=
 =?utf-8?B?WlhubFB0cjlrUWF2c0tJNlZINTlYSWF4U2pVNnZaUEZlanhlN2Y3VzVSYzVh?=
 =?utf-8?B?TFpSMlAvbjZDK3FkYlpwcTl5NnVwWk5TMXZTSklJMVcyZVIwTjVBREVJblhr?=
 =?utf-8?B?OVRMUlB1NjZvWTZUcnpScDVYTXFTR3hkY2VUV3NnVGRCb2lmZFF0a21nN09U?=
 =?utf-8?B?SE9GV0RicUtILzRDclJpY3dacVMxVnNxb0FleG5HR25XOVhOSFhrVlBUdGlZ?=
 =?utf-8?B?bTBad1VMU1hveDZSTEZVcGtrb2tONEl1d25aMG5pbWpVcWZZUmcyTTRwMnIv?=
 =?utf-8?B?UkJtK3JwTng1NFAzWUtKcmRWWTAyVUtsRkVpakZtcG11V2JBcE1UWnF5d0NJ?=
 =?utf-8?B?M01SL3dyT1U1SHVKbytpK3h6bGh2b0Z3YWJyYk1yWTZ5TmxHU1YvSFNnczRi?=
 =?utf-8?B?TlQxdTIyVjI5RTlFZ1R3MnhqSFN2UThlcUNLbzdGY2NlM1RiRTVNNVBGSFdG?=
 =?utf-8?B?MFk4ZEpNTE5iQjRnRTR6QlFQV1ZNNWllUjYwajZPZktVN2FCQzZuY2pNYnJk?=
 =?utf-8?B?S3pCYSs3UEtOK3k4Yk9OejlLVjhHdWNMRkR1Z1EyMjlCYnBVNWJXa2lNeVZC?=
 =?utf-8?B?NEFhSDMzdVEvdUF4cXpUbjdWcTJDRlpnVFE4OFNoL2hJMHBFMEdYeEtsaVEv?=
 =?utf-8?B?b1V6OVNEb0dRK0NUaXJEcDh1VG16SWJSMm1lNGNWeWRlZU9pZ3YrenhhZWRV?=
 =?utf-8?B?cXpadkpQaGFSTXlFdUVMOEtYcit0MDJ3bFlWS0hzc3B4VWYweENtaGVySmtU?=
 =?utf-8?B?ZmJzekZWTEdpK2pHNUNDSi8vU0V3WHA5aDZTdGtwTjZQaXdhY1J6RG0rZy8w?=
 =?utf-8?B?aWE4elhZTjR1cFlRZDZMSWYyb1VQTmc2aHlGTDlvdEdCdDd4RUw4SDIxZkNv?=
 =?utf-8?B?QXlPMWNZSDY1NFRPdXVtTHEzUnoySFBvVXN3YW5QZEc5WEV6RkJBV3MzUXBT?=
 =?utf-8?B?WlkvbmVGa0tpUUhWSG9QOTZVem04OTlCR2tySGQyYzV5TU1Hby9nVTFPUUMw?=
 =?utf-8?B?S1BBcEI1RmFyRXhSWkhnaHI5Ri80TTQ1TXQwVmJ3RUlVTXVrclhISEpzUGtR?=
 =?utf-8?B?K0FHdzFtRlJNenArNFZPcmtBcXRHWVEzODQrdkVBODJ1NTZnQ3pFQ0Z2bnZr?=
 =?utf-8?B?ZS9YVnhGS0puYko4R3oyY2NmbzVYOGQydHAwYTdieXcxVEFpZVNidnZHbkxo?=
 =?utf-8?B?Z1d3b05ETUxMNlpiMWYyU0toOFJQRjFxN3RBQ2xXUVlMU1JadmJLTG4yUzBm?=
 =?utf-8?B?dFhJZHVZYytVdFZxYStXdHJ0WGtqR0J5RmZleHpudmVHRVRleXR0VGpJTldN?=
 =?utf-8?B?TTZtTlc4OUtqS3k0K2N4cU5wQkRlNHpONkVXR1VkV2dZUW1weTJCdlQ2MWow?=
 =?utf-8?Q?gcMIDHbhC1G1WY/kaA+nlLQSeemgsXwF5O9shc/Dswvk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6578.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WXN0MUxjbzdlNUJTeTg4aHd1WlZ1YktjdXhjYzVROC92UUpGRWFiMTJHNVhr?=
 =?utf-8?B?Nm8xd0hIREVYQ21ra1BLNlhlTVRrYXkzUEZNaVpqUTNOQ2FJblBpMEFFUlYy?=
 =?utf-8?B?d3JjbjczVVZxeTJlVHFFNjVNYUNYaml2d1pGT1ZBUWEyK1hscmtWSkFuWS9x?=
 =?utf-8?B?dWJMaUl6NWhmaFdjMmFIVkkzZ3ZHbDZZVU9TYXdUaXVUWHBJQjU0MndmVlJW?=
 =?utf-8?B?a2lZbG1RQXhJUUtiYllLTFJ1M3cyb2hSVTd4bUh2RDhuNG4ycThLcFFlcHBJ?=
 =?utf-8?B?VkRpY0R0TDUrUmFQbVFGRVdkWEE4MFBoOE9pN0Zqb1BSZVh1WmxiK3hZZ2M4?=
 =?utf-8?B?eS9pVjI2WitqMnhkRlZGUXQ1dTlqdDFwTWkvRno4YmZGV0VSZU5wSEJZbDBX?=
 =?utf-8?B?NUZ0ZlkvQWtCSnhSTmRzYkFMVDNqZVBwN00rMFRzYTMxS3FaeWJpT25KWmtE?=
 =?utf-8?B?WXFwL2syN1dZVjVZTitJRWJzQjFjZDBMNzFKL09rZDAwdEptRk1lYlZHbDlK?=
 =?utf-8?B?SzdpS2huTnIxRFMrdGNSL1FzWU9EekZEVjY5OGZFOHNyNmY4UE94WThNMEhY?=
 =?utf-8?B?MVJrZU9QUnc5ODJ6bzgwVm5yQlp2SVpVRzVFa05SZm9mM0NYeVJJeGozcEg0?=
 =?utf-8?B?bktkM09IRDVVeHhRd1UzZHVsMENzS2xwZWlSUU9mb1BtVE94aHVSQkhvLzgx?=
 =?utf-8?B?bERWbjQ3dEg2aWNZdGtNUzNOZ09HUjZRWWFUYVF0UzlyaWx0c3ArZmJZeGNV?=
 =?utf-8?B?T2JDcFFlbWllRlBUQWNhbmlNbHdsdFFoUTBBb3htUi9remg1TDRKakQ2aGc0?=
 =?utf-8?B?V0x1N3h6NktUelovWjF4M1MvWDBJSy8wdVlMaDNkKzNPK2hnV3MxYVlBcW93?=
 =?utf-8?B?NFF3SEk0eEU3LzF5RXhvbmRodnRXWkE3Y0I4VWs4aEZYTWJITjRRNjhicFNQ?=
 =?utf-8?B?ZnJPQnFudEVJemdMSFB0WkR1Q2xnTkplWC9CWm0wbU1neDJMQkUrVkVZREZk?=
 =?utf-8?B?RkNqWVJWeXdJbmRiclZEd1lHMERDcTlHSUc5bTlQWUFkSE95c2dwdkdLNkRD?=
 =?utf-8?B?aTZkK2ZzcHg2TkJndmJ1cDJoVlBEVTd6SEw4ejRzWnRTV3ZMOFl3cStuZCtz?=
 =?utf-8?B?b3Jscys0eEJ4YisyanVhb0hZYkE5UUZ3RE4ydlhpUWFUT2xndzhqY3ZIUjJV?=
 =?utf-8?B?ZkgySzhRT0RSdDdnRFg4UW01eUpZdDF5emVJNWlVN3E0VXMybEltS29kaXRi?=
 =?utf-8?B?NUk4NDVZUndIeFVzSUk3N3FDMUhGTUd0M0paVkxjRVVQYnI5VEJGQWhOMFFR?=
 =?utf-8?B?cnVPa2x4YXg4VlJKR3dPN0JPVmF2QjYxYk1IdjA1QklBNys4d0F2SENLUUFI?=
 =?utf-8?B?MXNxWHhNcWl6U3lldWpuNnlxYXliRHIxQndPQU1yZlVIckNVZklQbW9HcmVm?=
 =?utf-8?B?Tk5uUzhrelFUK2F1S25NNjdKRmFGMHROcVZqVFpPSXBmYU5vNFh4Y1E1dHpl?=
 =?utf-8?B?YWR5QzVERTE3ek9jTWUzNjViRmdrbkpXYURRTXZGWUtoN0ZOWUlYaDd5SmpH?=
 =?utf-8?B?WHNuZngrNnZkTDFzQkd0NDdWRUF0czNISFdkUnFNdlRLa2g0NktRRUtjZDI1?=
 =?utf-8?B?bExuNmkwd2xtWCtQRVJRSlc0c0dFcUJ1WXkrM2FxK0diREdvdmZpMmVsM25T?=
 =?utf-8?B?VGtQNGlpWXk5dXdmUWhDYUZrUGdaakRxR3NLd09lTFhVeXhvdGp1N2t4NVE5?=
 =?utf-8?B?ZHJjdm1rTkZKVzVyMU45VUwrQXZCSVk5YmxvQitxa0lqNTV6L2QvUWtpUjJ6?=
 =?utf-8?B?c3R3OXBTTklDUEY3d09LelJiSzFVVzc4VkYzNWN6UVBqTXFNczBMT3V5RGhP?=
 =?utf-8?B?dEk5ODNLVFozajN4UjYrRkVWTmttKy9FTTBCbWZjU1VIQ3BIdi9acjlOV1JW?=
 =?utf-8?B?OTV4UThjc0tjWUFvZXB5VFpDRHUwZStvc1NKMGtDZEdiU1RKY1dCbCtQU2xZ?=
 =?utf-8?B?MUxnNC9Jb1YyRGNLa2JNWm40QnlKVndTNnhmM3NtQmdEUUxabVRlQXN5Rldu?=
 =?utf-8?B?UTJkc05XOHZaMXhuYWZGb2hNMVlZSG95ZXpsdWFnMXpVblBBQjhUVVFaalo4?=
 =?utf-8?B?NHpMUGxPUDlteXAvNHF6VGJhT0dDOTQ1WkM0ek41Ykt3WkZjTTdMLzZaa3ZU?=
 =?utf-8?Q?L6brKT9V8zdGkVmc3P2HbrE=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc95b1e-2164-4340-9bef-08dc7afe56fe
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6578.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 07:59:58.0492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6E6VRsjh7ZLl8MnRGaCU5FQ2P0Z48r5HyY5Kq09jJSkstEIA64StJZoML/fhItVKEGVFD8VHcusTh9Gql7kfrxUFMIXS4flB/5xYSCYxPL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7486
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 May 2024 08:00:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/173

Hi Trevor,

On 5/23/24 1:08 AM, Trevor Woerner via lists.yoctoproject.org wrote:
> Specify the root partition's type according to the Discoverable Partitions
> Specification:
> 
> 	32-bit ARM: 69dad710-2ce4-4e3c-b16c-21a1d49abed3
> 	64-bit ARM: B921B045-1DF0-41C3-AF44-4C6F280D3FAE
> 
> Link: https://uapi-group.org/specifications/specs/discoverable_partitions_specification/
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>   conf/machine/include/rockchip-defaults.inc | 6 ++++++
>   conf/machine/include/rockchip-wic.inc      | 1 +
>   wic/rockchip.wks                           | 2 +-
>   3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/conf/machine/include/rockchip-defaults.inc b/conf/machine/include/rockchip-defaults.inc
> index 2387eb909934..717085b1535c 100644
> --- a/conf/machine/include/rockchip-defaults.inc
> +++ b/conf/machine/include/rockchip-defaults.inc
> @@ -21,3 +21,9 @@ XSERVER = " \
>   SERIAL_CONSOLES ?= "1500000;ttyS2"
>   RK_CONSOLE_BAUD ?= "${@d.getVar('SERIAL_CONSOLES').split(';')[0]}"
>   RK_CONSOLE_DEVICE ?= "${@d.getVar('SERIAL_CONSOLES').split(';')[1].split()[0]}"
> +
> +# Discoverable Partitions Specification (DPS)
> +ROOT_DPS = "B921B045-1DF0-41C3-AF44-4C6F280D3FAE"

The link you posted uses lowercase here as well, maybe match that?

> +ROOT_DPS:rk3066 = "69dad710-2ce4-4e3c-b16c-21a1d49abed3"
> +ROOT_DPS:rk3188 = "69dad710-2ce4-4e3c-b16c-21a1d49abed3"
> +ROOT_DPS:rk3288 = "69dad710-2ce4-4e3c-b16c-21a1d49abed3"

ROOT_DPS:arm = "69dad710-2ce4-4e3c-b16c-21a1d49abed3"
ROOT_DPS:aarch64 = "B921B045-1DF0-41C3-AF44-4C6F280D3FAE"

So we don't have to maintain a list of aarch32 SoCs in there and also 
try to figure out while reading the file why those specific SoCs have 
this specific value instead.

Note that arm OVERRIDES is part of TRANSLATED_TARGET_ARCH which is part 
of OVERRIDES.

Otherwise, looks good to me.

Cheers,
Quentin

