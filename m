Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BD2E77180
	for <webhook@archiver.kernel.org>; Fri, 13 Dec 2024 16:28:54 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.65.6])
 by mx.groups.io with SMTP id smtpd.web11.19808.1734107326835429277
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Dec 2024 08:28:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=bqgvLMZ4;
 spf=pass (domain: cherry.de, ip: 52.101.65.6, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8xTCDbP0ufydI7zvn35KJtihUTgz3XuXLrjQhcrRNZmDmdyvGzSWnR7oaNkt+L67V4ySfFKg/XxECfAYuwrb3ma46KpmoxiviFcequceEs0tgBykc74pD6qWP8K7XinMwV38e1+dllymxsdjezI9E/CCSz5HlOpd6xXL62TBO28s4CQgtTdq9JVJDyJ0At5adEPdZ1oejDLLgeeBt0dRTguxUzB/pu9HMN0YGOLYzF2N04yUgBwaDIDDKhmcJt5WVr1qVSGPzi5AWMj6x2lo+T5z/TKJpUWKv3KmXEnzBtNo+uOxeZir98sMFo1wx2sYF/ObcHP8LawsqPzotGpbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0P4Xb0dswMcCNMgasN25JoCg9P1SUyPsz3rmOqokreQ=;
 b=zOPfSmHJLZMascFJet6ywLB6ucuxycu9uz6I37u0MomL9Til5aRV4M0HYGpf0Um1GocnwlDNj5KuNKVCGQ+2AMKqGLrpqe061+k8+tBr9868+cDNnvkjMDv0p/97hAAObNGnAbArvfw0bXqrFoBhd9hOHUKW6TvnZFsnmJcJevqDnZZ2SPQCu0tRIn0qEuMhOhKB17+JQSDy6gPw9gL61zahWik3ArczH+0RCUoyIsDiGXjr2CJE8oaFvbnCyw1+Um42LJiqiM+T+dc6e3bwcGFt80sAbh+kNcdIL4XGGneTpMl9vdtb3GOHePpXKIn4Sc1bJoBs5BQMYIlLRlwzlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0P4Xb0dswMcCNMgasN25JoCg9P1SUyPsz3rmOqokreQ=;
 b=bqgvLMZ4o8qi4p4o9UCbOfdmqxpv47bMMkHRdqph7XL6fD3XsfgxZneJguk6XSseIUDOXnS2/DlW9wxKr+4V/QXI+q4eE4bLJ0AYJ8QCli3hr4w8gm02Roi6lRWCTT1zI1MyUZqm+cQ62u/nFgCrR0hQKEAO9tIfUEtqzKWY1VI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV1PR04MB9102.eurprd04.prod.outlook.com (2603:10a6:150:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Fri, 13 Dec
 2024 16:28:41 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 16:28:41 +0000
Message-ID: <ed3585bd-ad2b-4473-987a-3d366aa3946d@cherry.de>
Date: Fri, 13 Dec 2024 17:28:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2 4/4] rk3308: add
 provider for trusted firmware-a
To: yocto-patches@lists.yoctoproject.org
References: <20241213154843.27592-1-twoerner@gmail.com>
 <20241213154843.27592-4-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241213154843.27592-4-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0382.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV1PR04MB9102:EE_
X-MS-Office365-Filtering-Correlation-Id: 78cd6919-0c05-4a9f-1386-08dd1b9334a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TkY1U0tYZ3B0c1JZM2N0bjVDTCtwYzg5WTFFV1hlbXo5eitmVGMxMnNRMFFP?=
 =?utf-8?B?RDlJSkd5TlRWS3JIbTFjeVo4b1FNUVpIZ3NVL1l6eHJXZTUwVVF0LzZIbWxJ?=
 =?utf-8?B?TExGaEk0eEhsdUF3QWZUZSt3QXpUV2xlVFNJejRtL2NZUWQvTHVNSmNHdmc3?=
 =?utf-8?B?cGlvTSsrK1JIanBQSXk5WWl1WE9EMldVbE54L0hrTWZJSENiMUV1NkVVNms4?=
 =?utf-8?B?UDlJbFZrdHJuUmN0b0Fxbzg2YklnRytjYUQrUXE0a0RNcW9qQ3o3cVBSQk9p?=
 =?utf-8?B?RWVhU0h3TFgzMzFZRDBvMFV4S1VvdVFESDlvNW9tWDkzYno3bE0vbnJlWnlL?=
 =?utf-8?B?SWl0cnhmaTdMdzdGNlR0SDQ0QnNvYmx1dXQ3ekErT3FPVXJ0NTBQU1JOZkVI?=
 =?utf-8?B?RnJmb1ZmRTE3cmQ1SmdHWWUxOUFGcS9wei8vV1BTQjVzeHBybHdSRVE1TUhQ?=
 =?utf-8?B?a2YzQjA2VGtnV2IxVGQzcjVpSmZKN3Mwd05IeCtsODNlSTIwcUxiR05hMDd1?=
 =?utf-8?B?VlFZSklNVHF5U2s3NXo5WXpJaForNTFOVGlrY1NLK3dlS3d0OCtLM3JhK2Vx?=
 =?utf-8?B?VFBtNmtLM3k3OVNyUjEzcTAwNEU1NTZMNS94aWdJamlvci9aOWRCYVJocU5F?=
 =?utf-8?B?YjdYTVk2Q28zcHdyczBFN3lZNzRYQ1NSclc3NXBtMzZzbjZNTjVMUWpkeEUz?=
 =?utf-8?B?bWFhdDd0encyUDRNbXJ4M3N4clorU0FqaHkycEVqYVFXTXMxeS9DK05XdDFa?=
 =?utf-8?B?WHkyM2NUUHdJbU1GcVhLVitrREt0RUI1MktWeGsxYlFaeVUvWVNvOVFlVEs5?=
 =?utf-8?B?RVNjWWNzb0NCdWZnTmIzNFlYNzR5UDdHNU92U2k1Z3dBTnpVdDd2dExONURR?=
 =?utf-8?B?WHF0ZzhFOUpjQm40bkJyQkRlaWJaalJqSVZYS0JSTk1KaDNSZlJoaElmVExU?=
 =?utf-8?B?eDFOQzdTOGdHd01NZHN1V3Z0RFlXN01VVC9LcUVzandpRFlZODgwZlRFTEd6?=
 =?utf-8?B?ZndqdVBmbXd2SU9zbWk4bWdGdVAvWHhmWUJoZ0RPV1FBN0xLZjZLV0NkS29E?=
 =?utf-8?B?V1l0Z0V0RFN5MlhRdEk1VW5kNmZPNmVLeWtZbFJydXFIbzI3ZnpWWER0MHFp?=
 =?utf-8?B?WjVpUTFpQlJ4Qmp1d0tlRHR4enVEMHJtcGFqSnhBNGJZT29CY0hVN3pyTzlF?=
 =?utf-8?B?c1RFMGduVkhxYVZ2cEJEN2lrZlB5M21zUmVVd1ZDZzkrdWFvVHBPN2VZc0ZJ?=
 =?utf-8?B?UndrNW1vZ0Jrdy9GNHdCSVFmTEw1eXdrVzA3RzNCbVhaYmg4bEJmUDlaL2lq?=
 =?utf-8?B?SmRqNjRYYURQZzhzdzhBM2FYWHNzZWRvSzk1dTZ4UDZtMFZpeCtsY0ZpYi9a?=
 =?utf-8?B?QldQZHdFNVFvd0QrcGxYNmZRc093L3JpSWRTYndHNjJyRnZZWWY2cGl0dEZZ?=
 =?utf-8?B?NkJqekVkeG9TN0lwdEZacEFvV3RiZjFObWo2c1lMd1FLaFlUVWtuajJKTGZl?=
 =?utf-8?B?WExBdXpXd3VkVGhpN3NnUFZnREZ6OTlUQUJnRkFZMm1nN3R5WkQ5UEU5K0Z5?=
 =?utf-8?B?TGxkRTdiMmx2dHo1V2hiYUlCcWZSbWlzcDJHUW5lYWJVR0ZiQVdJYzZ2V3hD?=
 =?utf-8?B?UFZESXozeXB6WmhnRUlBYll0UVFjTzVaWWZSR0xsMEZ2UFp6cmpmMmlUUDI5?=
 =?utf-8?B?M3hrVDZvMnNYSk9iRjEyWG1XTzJOSzJkZUg2MzNMMURFZ0U3RzFWN3EyMk50?=
 =?utf-8?B?dnJIOXlIZ3BaUzdJQU5YMUpKTlZBdis3a3BZR0N2UUxDVG94bnRDTTROQ1Nt?=
 =?utf-8?B?Nloxa05VdnBwNHk2RVZZdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y3N1cjl5OUJYVTFKalJJcUlIWlg5VGNTZDh5V09YME5STjlDVDZHaWhKU1BN?=
 =?utf-8?B?WnprTFdqK3BiaFFKUTVoWDJWd2lkaGxmd0tycEI5clBFWm9FSkJESFZwL2Fh?=
 =?utf-8?B?TzNueFRmanVpMi9TVFhUMXRMb29CVStVUkFjeXl6ejZwakR4OEtMbFJqQStU?=
 =?utf-8?B?N3FWZmxUcklrMi9KbEg4TXlyWjlYRzhlRUFia1pNZG5kcFlMbUZqVythVE1q?=
 =?utf-8?B?VW1vYlVreVVXdHBUSGNwYjFqL2JpZmFSWE80UkVFYUpCV09UWkM2bVgwYW1v?=
 =?utf-8?B?RnRSWjJ4VWNyV0FCRHg2ZFh2R0ZXQzhKakJnMS9vdzVOSXBXdElJWjd4WHZh?=
 =?utf-8?B?TmErMGd0U01iem1LdkhQY2JvUzc4ajd3UkwvRkl3aG1BR2JlYUNyVWkxQk1V?=
 =?utf-8?B?ZTVGb2xtYWRCNlBkT2JUbTBMVlFLQ0hRK09QNXp1bGx4WWwzbG03K3QrMmFl?=
 =?utf-8?B?RFBtUXpvRFVsTGswMFpGTWR3cUpoUFMzTVJPZEpUZVV1RVFuZFFLSzAzZE1p?=
 =?utf-8?B?YmJqcURrQlc2LzRUZkYvNCtvR1VqdEs4eGFBdGtzcXlZNEl5akZkMUgxSURV?=
 =?utf-8?B?SW5heWgvMXlvNWtzYVBhOEdxdS9abmdmNHFUZjF2Rk1uUmExUERkaXd4WWc4?=
 =?utf-8?B?d2xTRitkWjFqbTN2RFk1UDN2ZVd6b25jNFphL0R0VVdsVHVHdHhYSklkcndJ?=
 =?utf-8?B?K0plbUlibFY1bHEvK0pzZno1K2F2Wis4elJENENkSndHdTRJaDdta29kNC82?=
 =?utf-8?B?MERvU0tUWFFPaTY0Nm9SMk5UM0ZOTW1oRWx4OEJVeHZwU3lhUXV5d0R2Nzl1?=
 =?utf-8?B?SThNdm9yTGF6bHA4V0dSMmxuVjFsWWc1V3dhOTQ5TGg4NTh4Z1p5a0w1Vm5h?=
 =?utf-8?B?U0wyTURrSU94K2ZlRmNCR3ZHdVU3alQ4b1NkNVBTbUxOTHU2WjVYVUpzTXhi?=
 =?utf-8?B?WnlMRVMycHZKalN6aDh2VjVVd3BYTkhIRjROWjRZM1MzTXNOOUJpREF0WFBm?=
 =?utf-8?B?VGtCRVZKMXVOSnF4TlVIVTRSSXlmMkVUbmtDYU9WSG9NU2ErVy9NRU0rUjVm?=
 =?utf-8?B?ckljN1V6dHZxdmNNcGYzckh1c3BwZmpnNEtFdGl0Wkp1V2ZXM1NoOEhWbk1W?=
 =?utf-8?B?M0h6aEg2Q3ZMb25qNXNuQ2tLY2NVMW9yVUFYMFlVeHBnckxOVWxFaFJuVDJk?=
 =?utf-8?B?Sk9BN0xNVy9Tc2ZPSFk4WkJpSXVmYi8yNjJ4b21wY1pCNFRLSGVZaEw0OXFD?=
 =?utf-8?B?ektBWVpSZWtkVzBQWmh5RTErMTNMamx6M083NmF3dVFNcVZBL3pzVkEvZTky?=
 =?utf-8?B?Nk1XZVUrdHB3K3IrYTMyZytFOXl2emdYcklkV1hTTkNZWXpWdTYxVHJpaS9X?=
 =?utf-8?B?R0NPa3NJYW15aEtCdlkvMXRyYTdYQU9MZGNuc2pkVE1obXdGdzUwQVRvVmQ4?=
 =?utf-8?B?RzR3cVlkdEMzSTZ3TlZqTld5TU9DRkRMVWtrWkJFeTluTGtDQ3VIejhFczNn?=
 =?utf-8?B?dWtyNDBlcnBnaDFjU2lRWkh2dm5rK1d0MVJ3VHFUUUxsQjJxdFlaMnRBaWhs?=
 =?utf-8?B?N1kvRVY0UjZYUU1SMmFaeGtHR3Q0K3BUYXdubEpwcXdiT3hGUUFRS2NqZ3NO?=
 =?utf-8?B?bUNYSUVYY1p5REljS3FCVXc3bFFueFVITlNnU0FvTzdwQXdJTDFTY1pXbXdi?=
 =?utf-8?B?L3N4SHNLWHVDNGxiQkxjRTRwSC9IZHRRdlJpL3I0cGFBR25ud0t6K2Z3Vlha?=
 =?utf-8?B?N0l1SDNsZjFBWmUyM0ZtMlJ0QUJhL0t2WE5MQ1FMT2R1NEFST21seDBteVBa?=
 =?utf-8?B?UkFIbm1CNmczaVBsMmxqSURmdmxkTjhlalNTZ3RmSmd1UFMyeXI3Qm1mMlUr?=
 =?utf-8?B?eGd6TFg2bVljbzd6WUNqM2R0M2ZOcWk3bC9GMnlPSXR4Y2syWlpMVFoxUzBl?=
 =?utf-8?B?WGw4U0JyUlNzeFdJaTdJOFV5ekJqeVBQSXpCVnNNVkRsK3o3N1FpM1pDV0VW?=
 =?utf-8?B?NjFnSWNOSmR0Rk5yNkdkWUhnSmdVVFlUR2FSOXgzREYxK1dFZ0pBNDVndmhn?=
 =?utf-8?B?a2dTWmdhbU5LcVhiMG5wdXNFVFgxUis5U3p5OFN2WHJlOGZ2Q3NBeFQxQmlx?=
 =?utf-8?B?cmdxdmRFNmt0WWxpaG1BQmduMWMwdDNPTHZlYmFDS29YN0JhOXFwSnVDSDFH?=
 =?utf-8?B?VEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 78cd6919-0c05-4a9f-1386-08dd1b9334a5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 16:28:41.4981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0erf+Bxr2tg2yMeqcyo5ndIpw7K+dbqFKAL3LZlJdGlZ+F8dOR2OTPhImTkk4/5HpNQbfCrsKcItTr/4wQ9s1V8mwnWQHzbsezQc7M/N+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9102
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Dec 2024 16:28:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/905

Hi Trevor,

On 12/13/24 4:48 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> A PREFERRED_PROVIDER entry was missed for rk3308 builds:
> 
> 	NOTE: Multiple providers are available for trusted-firmware-a (rk3308-rkbin, rockchip-rkbin-tf-a)
> 	Consider defining a PREFERRED_PROVIDER entry to match trusted-firmware-a
> 
> This allows the RKBIN_RK3308_LATEST knob to work in all cases again.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
> changes from v1
> - added
> ---
>   conf/machine/include/rk3308.inc | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/conf/machine/include/rk3308.inc b/conf/machine/include/rk3308.inc
> index 1ecf085cd5de..d30901f15b4f 100644
> --- a/conf/machine/include/rk3308.inc
> +++ b/conf/machine/include/rk3308.inc
> @@ -19,6 +19,7 @@ KERNEL_IMAGETYPE ?= "fitImage"
>   UBOOT_SUFFIX ?= "itb"
>   UBOOT_ENTRYPOINT ?= "0x06000000"
>   
> +PREFERRED_PROVIDER_trusted-firmware-a = "${@bb.utils.contains('RKBIN_RK3308_LATEST', '1', 'rockchip-rkbin-tf-a', 'rk3308-rkbin', d)}"

PREFERRED_PROVIDER_trusted-firmware-a = "rockchip-rkbin-tf-a"

Should be enough I believe, and it would be consistent with rk3566, 
rk3568 and rk3588s where we already have that.

Anyone requesting trusted-firmware-a would get rockchip-rkbin-tf-a. When 
that happens, BitBake will check PREFERRED_PROVIDER_rockchip-rkbin-tf-a 
and pick what it should.

By having the suggested implementation, it would technically be possible 
to have someone request trusted-firmware-a to be rk3308-rkbin and 
rockchip-rkbin-tf-a (the provider) be rockchip-rkbin-tf-a (the recipe). 
Basically, we use a knob where there's no need to.

Cheers,
Quentin

