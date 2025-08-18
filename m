Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75A3CA0ED1
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 22:10:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (NAM11-CO1-obe.outbound.protection.outlook.com [40.107.220.42])
 by mx.groups.io with SMTP id smtpd.web11.2899.1755555040079770115
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 18 Aug 2025 15:10:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amd.com header.s=selector1 header.b=kvEIYddd;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.220.42, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U33/8Kh7c3t6lsrq0Dd1ukyCtVKiTJfb2R7UBLPLmZVkzSn7I/q2kCcS1sVo70wClzwxqdcpiTfbYF7eTpS3ZRXhOeuBycNpV2+82k/LMmr7Tk2IaBEZXevaIAYKKQvhacARylEdiUDOe23JdLL1Y65mjPAqYP0gpci+Iu8Bqu/zamNuFGm/7hA81r4NycIvIfe4O2sQG7sXjGEmqcPuriaB1+YKlYVMWwvAjLxrE33gbh3Jw/oVUENYP2h1gEceUZHD8kqyDxPLPnt8FVZPMIm7NII8NxF0wSMiPRl0ivN8MIkEVT5ckpoi7l78QL1rN7S+XuaDLdBIBbx0V96CcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GyYdAmWBNDxH7+8xUSeYeQBo+pGmyHYXMWVZ3hOSWE=;
 b=JUxtOkAl7tLn+a8qfWebwCscob/PYdBXUvxT9LN9FHcauA+v3356BxP+L/AIYCTtiSdUYc7SKd1M5lzBzG6K+lv9BadVqckSwIRt/Pdb+GOmVyL2FzqP8LillJzxVezbDsxtxZLoAVNnz+q+gREHWbzBQNsZCEFj4osTWbT0UIGX3xcL9MY4mSm7j84lfq8obVHeVrhzvakSVg2e2jWIO7E0F7+B9VsbtAh4Z7sbn2izCOrzQgpchq+8wqdpRnlXPbRqQk8slQGApULd3amy+3FOaEdD56uYNp/VceqouFa8wPYkTgoCEosx19eHI57HuEuNVzuNLxY6LwDaf1o1sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GyYdAmWBNDxH7+8xUSeYeQBo+pGmyHYXMWVZ3hOSWE=;
 b=kvEIYdddndDtIVaNvjIgJgLif5rh4NNqmyT9Rniyh/A/mdeybtPK+5j6IFNuUoCDJK2lNosU118EKVr6bXDnZMXSCI36vlK7KSfkt2nxnlfPPiUYnrI9hrlKau4nfJ59tZn+XVWkfuEB41q4Cbt639/E8n6GVUVsgDr50v67TxQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21)
 by DS0PR12MB9059.namprd12.prod.outlook.com (2603:10b6:8:c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 18 Aug
 2025 22:10:37 +0000
Received: from SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7]) by SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7%6]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 22:10:37 +0000
Message-ID: <6567812b-0132-4e42-afb7-ca8217cf2b4b@amd.com>
Date: Mon, 18 Aug 2025 16:10:37 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-zephyr][master][PATCH 08/12] meta-zephyr:
 Update README files
To: yocto-patches@lists.yoctoproject.org, chee.yang.lee@intel.com
References: <20250815035449.2816001-1-sandeep.gundlupet-raju@amd.com>
 <20250815035449.2816001-9-sandeep.gundlupet-raju@amd.com>
Content-Language: en-US
From: "Gundlupet Raju, Sandeep" <sandeep.gundlupet-raju@amd.com>
In-Reply-To: <20250815035449.2816001-9-sandeep.gundlupet-raju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::15) To SN7PR12MB8770.namprd12.prod.outlook.com
 (2603:10b6:806:34b::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8770:EE_|DS0PR12MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: a863a8d7-4483-477f-2ec2-08dddea40fb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bDFFM1c0ZVhJcXNzaTd1WlJwK052WWJ3U1dsOEQzK201Y0ZhV1BvSFd5citM?=
 =?utf-8?B?TC9odE1BSFcxaWN0L1ZkSnF5ODVodk1UZGhFMnpWcTZhRzVlMFRrTktPMUxB?=
 =?utf-8?B?aUtONWxTRmUzcVFQWlhpMUlMait5cEFBTmEreFN6bW5YZjhMRG9iRjJwejhz?=
 =?utf-8?B?SFcyT29zQWpvSmhJRStyb29WUTQ0bm9iYWZwQlV3Z2xBNkNqcDN2a0xhblNG?=
 =?utf-8?B?L04zQ29FY1lRVC8yTWI5dFBIaTlvdmZQRFlwUm51U1NOaEhnS3Vvb2RsQUgw?=
 =?utf-8?B?WmcvKzBad2R5Z3F4Uko4aU1nVWxuNGVUeXNlUnluQ0JZOUtsN3Zad2daa0xt?=
 =?utf-8?B?OTlzQUFHOGNKMUhCSlJXUkF0ekRBMmxvOTRqT3kyMHBjSEZwUzArbmo2OUxi?=
 =?utf-8?B?WElLN3JvbGRmQWo4WlZTeXBFaFNYa05sRUdGeDhWOGxIYWVCbko3aDRKWm1l?=
 =?utf-8?B?TkpIaWs3YStKWHhWQnhDd0RmSmdlVFpOV1pnRURXMEN1WkdsbUFyTzMxanRT?=
 =?utf-8?B?cE1VRGJDVkszcmlHOC9BbUtON2dldnZvZVU5S2VJZUhWMnBWSXJVVEZYY2ww?=
 =?utf-8?B?K0JPTGsrOWFVeFZ1TmNlL3UrWG1ycklUeUJ1REVQQmpBb0hWTkpHMk5KSUFB?=
 =?utf-8?B?a0d6SWZyQno2M1dMbFhuU3BUT1pXNkttSXN0OEc5TjNXOGd5WVNQWjBsZkd5?=
 =?utf-8?B?OSt3SU94WUJETHpsZWJKT1ZrVjRuUXZTSzBMMWk5d3hQak8rc2ZncU5aM2Rv?=
 =?utf-8?B?eGh6T0oyNEJhdlQzb2Z1cEJORlp2Y3B1MzR3SjJ1Zzg5cFlXRm1VMjh6SXpK?=
 =?utf-8?B?aUIra0Y2RXl3WGFaQ0N4WWtDOHVrR0dlRmpUcjdTZ0tOL0liOGxWbGdRTXJj?=
 =?utf-8?B?Wm4yZ0VaNlo1WXVoSDBqdVFvU1RzZUgyeEtQYzlPdnduT0wzT2ZUVVYwL0t5?=
 =?utf-8?B?MkMxQkZleDBqVWZudmJLbnZqQngrZDdjZlowUWRwLzd5aDBsNEtHV1dxVnlh?=
 =?utf-8?B?K2ZGeUJ5NlY0VzFDeTFSQkovSUhzMXRJK3NTdWZGNUYrd01tbWg2ZlN4NVJQ?=
 =?utf-8?B?M25zWFN0cVNjVy9DK094TWgvRXdsczM1NGtxSWFzdTBlUXlTbzhIcmtpUVdX?=
 =?utf-8?B?SXI2V3pFNjYyaWdaSHljWFB3NjJqcEt6RjNuUDZyYk84Yzl4VGdLUmpIbnF2?=
 =?utf-8?B?UTFpM1ZuODdSRFp6cVRkdUJkVHYyVW9zUU5DQ3ZWWmU3em9DdVlJZ05lekM4?=
 =?utf-8?B?T3FKQ3FZNkxuUGpLVjlETDh4azhpSkwzTjVnZ25xTDJOekdBSXJyU2RsMVNl?=
 =?utf-8?B?R01XaXZvZHBrSktDS01mb2JjZGVnVXRUMnBzalZ0bWRPZXJJVVRLZjNtYkVR?=
 =?utf-8?B?cG1FUU9ENzhrT29RZ2tTYlBhZkNMejFGdVNMbzhobUJ5M251Um9UWkVhbWZB?=
 =?utf-8?B?T0FOQjF1OHBFZkRhMmFIZUpzam1UcWVvdnVGUWpHdGhJMG9welNHNXYrYSts?=
 =?utf-8?B?TVdjWG1uMFNpWllyRFRhRm5DVGI0c0o5UTBHVFRBbFBmK0diTmNBWU91aXc3?=
 =?utf-8?B?RmxFcEY4S2UxZW9SdmZqMEVucUc1TFkzOXpwT3hPR3lUNENJV3hVRm0yZ255?=
 =?utf-8?B?aUhRbFpOMllYSU5sWXlXSWlGOHBBMG1CeXB3azlJRm8vL0ZaNG5GRDZuUGNG?=
 =?utf-8?B?Qzh5azE3V1VKVUI3NlY5RjhOK1pvM0NUczBRUmJoem5NTjMyRU40aGdDVzh4?=
 =?utf-8?B?U1JkaEJrOG1FQ3p4VWRnbHlaK1dnNXRQRENlR1JDaFBVQy8vdTJUTW9xamJO?=
 =?utf-8?B?eGxKcWhnd21vbHZzUG54U3MwUjlFcUJ6bGlGbDdpS2VZWDJmbXQzVDN5WVR5?=
 =?utf-8?Q?UlZwmSxz6fpYv?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8770.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a3FMbEVMQWZYWUZEeWNCRG14d1A4OUppenlxS0lrWXpLMGJWcUNsVDFJcVlR?=
 =?utf-8?B?cVhlRnQvTTk2dG5NVVZ2TkVjek9taW9oSlpQeVhkRWdMVWNkQ3BQRkVFUTJ6?=
 =?utf-8?B?YnFXM0w3VHEvYnBLSTJ2SDNJNWdqZFZYV3JrbmU3TlQ2c0hVcGpXM2NUZ0Ir?=
 =?utf-8?B?Qm9kRUZZRTVSZjdYTCsxT05iMVg3Qno4RVY2QVU3WVJ4dWliVDc2VGpOcGFk?=
 =?utf-8?B?ckx0c2xoZlcvODQ0NHZXSDRIcG9wbW5HaEJicVJSTjF5eUlqQ1VMZUVOSlE2?=
 =?utf-8?B?TTFBZW0xNmlWYzdHODJJQnd6MFQ4U0lZdTZyVjRFdkZKbHptdUtycmN5THds?=
 =?utf-8?B?VGpHNG8zTTllZTJRSmF5YXUyeXJTRzdoSmk3R2dyVGYvMHJxSGE5SVZ3aVpW?=
 =?utf-8?B?cmRkWVBHRWVTNkoxMFI0b3BIdzczOU9RbHloRStkRm9sNU1VVERrOXBRMUJ6?=
 =?utf-8?B?UVFEeGtsZC9oZlJCTjRuVTB4TUlUQ1hmWFBMRkdieUlOY0huY3NEQVZnWG0w?=
 =?utf-8?B?S1NES1RSTGs1dEdia1AvQkMxa1FDRjhkZUh6NGh2MVg4YXZ3M1lGZlpjZmJI?=
 =?utf-8?B?MVFGZUpHWm5Cc0FOcVBReUhJbzk2OS9TMzhaTXVnR0ZGV2tSK1NHUGIwdmtt?=
 =?utf-8?B?Q2JWOVRLKzlPZG9EakhQUFNjU3g4ajhGcjd6TUE1ZktxckUvMnpCMGRybllJ?=
 =?utf-8?B?SU1SOXVnb0lES3hvMkdWaVVxY2RaUlRWeDEyUjY5UW5zREpHeURSV2xtTUx5?=
 =?utf-8?B?YmNSbXJ4dUcxekZobjRWcHdoSm1IeXc2Q0U2alhSeWJsbjRXendnTXE3Nm5U?=
 =?utf-8?B?bVF0NWljMU9kK1FSOGpLcHp3aXJ6cCtja3ZSVTRHa2JKUXhaY3ZpMzlQNFMr?=
 =?utf-8?B?ZmxXZ2R3RTluWndqdjlMTTI4UTR4SWZaVlVKVEFqZFdXa3NMZ1NnRUVDc1cz?=
 =?utf-8?B?OE5XWnlhKzZlL3krN2Y2NjJacFhDVmtjNjZJeTR4R2ljS3MwWFVuejRzUFNZ?=
 =?utf-8?B?cndiWTVxK3V0bXZieHNtcUc0dC83dkZQYnMwT3VEV1U1MWdrVWJwNCt0TzRE?=
 =?utf-8?B?dDJEeWxnTzFMTDg0TjhkTGZQaFVHQlpUem9MRjNxMlB6ejBTR2x6ZWU3VXQ1?=
 =?utf-8?B?Y055TlVUQWtaU0hjMzl1bE80aWN5aUdmck1xa25UZDNWTTZ5bWlXU25BRnM4?=
 =?utf-8?B?WWI1TmcrZ0dBMXFSVHkvT2ZxMERlTEE2ZzJiYmdtUk9SWE1CQ09jb2VMbkFT?=
 =?utf-8?B?Ym9BOXdmK2ppTHA1TU9UbDZ2aHVtYWlQVUtBY1RmQUkyTFo4RE9EUmNPSzJN?=
 =?utf-8?B?TU96TjBuRVlxMDFiOHFqRFFBNmxFVHcwWXl3bDhjRDFvKzFnMVZlZVptWDly?=
 =?utf-8?B?UlhKUEUxanBJUFcwNTdBN25ib29aN3RYdzRmL3hGOFRFY1dSQkFDK1hKbktG?=
 =?utf-8?B?ZXE3ejQ0NlJGaFA5TG02UXFWU09BMDJUT2RRWTNRNUZiRWlTY0NvN2NLaUlQ?=
 =?utf-8?B?emZRNWFDQUNqRzdkL2czSERCY014UFlGMEVIa0ZzWDVmc1k1bVZDVGh3bU80?=
 =?utf-8?B?dW9XS3lCbURTYUlIWFpKeHlyUXh1c1UzM2s3OXdhM3BjNG9Ia2g1bUE3dVd4?=
 =?utf-8?B?MlJqYjhOWmJzYU5lVU9hdVR6SHRJbWxlei9LOCtwS2xXMkpLTmwxRVRFck16?=
 =?utf-8?B?TmR1RHYweTAvMVRtRFlqYXNqSkRQelB6ZSt3Y2U3ZTBUa1g1WitOWjh2cUZp?=
 =?utf-8?B?bGtoUlJJSHhGVFBxcmlVNlRrTzM3RmVMWjBPVFVmUWxHNS9IN3dLbmpWRkJC?=
 =?utf-8?B?Y2hlWDlLRzV5SXlianl3eGFRUFJDUDFITEdVUnFDbUxndmIzaFI3bmVBUER6?=
 =?utf-8?B?cHpDVm1VWjVNbDhEa2ZKcllZaUtlViswc3lwa251a3I5VndyZVFOQ21OWEZD?=
 =?utf-8?B?TEk5V205SjZydjZ4WGJneTFjTVJMWGdjYzNGd1BiTTR0bkc4QXFRbkJ6Qmhl?=
 =?utf-8?B?UnFaYnNPYnE0VzMvTkNaVDVhcTg1UG4vSzJrc0wvS3d4K1Rsb2ZxLzJlTXpL?=
 =?utf-8?B?RXZJYzA2bVVRR1Q1anhQcjRNWGtHYjZ1amVEUlhTdG5mTkdQeis0ZUQzRE5s?=
 =?utf-8?Q?2Kw/dkl4suXPsqcaAaHCIyy1w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a863a8d7-4483-477f-2ec2-08dddea40fb2
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 22:10:37.7578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Knb3aZR8KrtFa0/fvD4tyWk0mKjvPM8Z7AOgTN2ZsK3IsUnmRJdx77V/cugwWZP05GdMfbgXMhpgqQO+am8bYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9059
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 18 Aug 2025 22:10:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2050

Hi Chee Yang,

This patch is missing in master. Can you please merge it.

Thanks,
Sandeep

On 8/14/2025 9:54 PM, Sandeep Gundlupet Raju via lists.yoctoproject.org 
wrote:
> Update README files with following.
>
>   - Build instructions
>   - Maintainers lists and patch submission
>
> Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
> ---
>   README.txt => README.md     | 163 ++++++++++++++++++++++++------------
>   meta-zephyr-bsp/README.md   |   5 ++
>   meta-zephyr-bsp/README.txt  |   1 -
>   meta-zephyr-core/README.md  |   6 ++
>   meta-zephyr-core/README.txt |   1 -
>   5 files changed, 120 insertions(+), 56 deletions(-)
>   rename README.txt => README.md (60%)
>   create mode 100644 meta-zephyr-bsp/README.md
>   delete mode 100644 meta-zephyr-bsp/README.txt
>   create mode 100644 meta-zephyr-core/README.md
>   delete mode 100644 meta-zephyr-core/README.txt
>
> diff --git a/README.txt b/README.md
> similarity index 60%
> rename from README.txt
> rename to README.md
> index 247c029..e38138a 100644
> --- a/README.txt
> +++ b/README.md
> @@ -1,71 +1,101 @@
> -Building Zephyr Images via bitbake recipes
> -==========================================
> +# meta-zephyr
>   
> -More detailed and up-to-date information can be found here:
> -
> -https://wiki.yoctoproject.org/wiki/TipsAndTricks/BuildingZephyrImages
> +This layer enables building Zephyr using Yocto Project.
>   
> -Prerequisites:
> -==============
> +## Dependencies
>   
>   This layer depends on:
> -    Yocto distro (master)
> -        git://git.yoctoproject.org/poky
> -    Python layer (meta-openembedded/meta-python)
> -        git://git.openembedded.org/meta-openembedded
>   
> -Add "meta-openembedded/meta-oe" to BBLAYERS
> -Add "meta-openembedded/meta-python" to BBLAYERS
> -Add "meta-zephyr-core" and "meta-zephyr-bsp" to BBLAYERS
> +	URI: https://git.yoctoproject.org/poky
> +	layers: meta, meta-poky
> +	branch: scarthgap
> +
> +	URI: https://git.openembedded.org/meta-openembedded
> +	layers: meta-oe, meta-python
> +	branch: scarthgap
> +
> +## Building Zephyr Images via bitbake recipes
> +
> +More detailed and up-to-date information can be found here:
> +
> +https://wiki.yoctoproject.org/wiki/TipsAndTricks/BuildingZephyrImages
>   
> -Building and Running Zephyr Samples
> -===================================
> +> **Pre-requisites:**
> +1. Refer [Yocto Project Quick Build]( https://docs.yoctoproject.org/dev/singleindex.html#yocto-project-quick-build) documentation.
> +
> +2. Clone and add following layers to BBLAYERS
> +    * meta-openembedded/meta-oe
> +    * meta-openembedded/meta-python
> +    * meta-zephyr-core
> +    * meta-zephyr-bsp
> +```
> +    $ mkdir sources
> +    $ git clone -b <release-branch> https://git.yoctoproject.org/poky
> +    $ git clone -b <branch-name> https://git.openembedded.org/meta-openembedded
> +    $ git clone -b <branch-name> https://git.yoctoproject.org/meta-zephyr
> +    $ source poky/oe-init-build-env
> +    $ bitbake-layers add-layer ../meta-openembedded/meta-oe
> +    $ bitbake-layers add-layer ../meta-openembedded/meta-python
> +    $ bitbake-layers add-layer ../meta-zephyr/meta-zephyr-core
> +    $ bitbake-layers add-layer ../meta-zephyr/meta-zephyr-bsp
> +```
> +
> +### Building and Running Zephyr Samples
>   
>   You can build Zephyr samples. There are several sample recipes.
>   
>   To use the Yocto toolchain, modify local conf by adding:
> +```
>       DISTRO = "zephyr"
> +```
>   
>   To use the Zephyr pre-built toolchain, modify local conf by adding:
> +```
>       ZEPHYR_TOOLCHAIN_VARIANT = "zephyr"
> +```
>   
>   For example, to build the Zephyr "philosophers" sample:
> -
> +```
>       $ MACHINE=qemu-x86 bitbake zephyr-philosophers
> -
> -You can then run the created "philosophers" image in qemu:
> +```
>   
> +You can then run the created "philosophers" image in qemu:
> +```
>       $ runqemu qemu-x86
> -
> -The same sample, for ARM image:
> +```
>   
> +The same sample, for ARM image:
> +```
>       $ MACHINE=qemu-cortex-m3 bitbake zephyr-philosophers
>       $ runqemu qemu-cortex-m3
> -
> -The same sample, for Nios2 image:
> +```
>   
> +The same sample, for Nios2 image:
> +```
>       $ MACHINE=qemu-nios2 bitbake zephyr-philosophers
>       $ runqemu qemu-nios2
> +```
>   
> -Flashing
> -=================================
> +### Flashing
>   
>   You can flash Zephyr samples to boards. Currently, the following MACHINEs
>   are supported:
>    * DFU:
> -  - arduino-101-sss
> -  - arduino-101
> -  - arduino-101-ble
> +   * arduino-101-sss
> +   * arduino-101
> +   * arduino-101-ble
>    * pyocd:
> -  - 96b-nitrogen
> +   * 96b-nitrogen
>   
>   To flash the example you built with command e.g.
> -
> +```
>       $ MACHINE=96b-nitrogen bitbake zephyr-philosophers
> +```
>   
>   call similar command with explicit flash_usb command:
> -
> +```
>       $ MACHINE=96b-nitrogen bitbake zephyr-philosophers -c flash_usb
> +```
>   
>   dfu-util and/or pyocd need to be installed in your system. If you observe
>   permission errors or the flashing process seem to hang, follow those instructions:
> @@ -77,28 +107,31 @@ of IDs. Once that is set, the tool will only try to program these IDs. You can
>   query for the IDs by running `pyocd list` on your host while having the probes
>   attached. Besides setting this variable through the build's configuration or
>   metadata, you can also inject its value from command line with something like:
> -
> +```
>       $ PYOCD_FLASH_IDS='<ID1> <ID2> <ID3>' BB_ENV_EXTRAWHITE="$BB_ENV_EXTRAWHITE PYOCD_FLASH_IDS" bitbake <TARGET> -c flash_usb
> +```
> +
> +## Building and Running Zephyr Tests
>   
> -Building and Running Zephyr Tests
> -=================================
>   Presently only toolchains for ARM, x86, IAMCU and Nios2 are supported.
>   (For ARM we use CortexM3 toolchain)
>   
>   To run Zephyr Test using Yocto Image Tests, ensure following in local.conf:
> -
> +```
>       INHERIT += "testimage"
> +```
>   
>   You can build and test an individual existing Zephyr test.
>   This is done by appending the actual test name to the "zephyr-kernel-test",
>   for example:
> -
> +```
>       $ MACHINE=qemu-x86 bitbake zephyr-kernel-test-sleep
>       $ MACHINE=qemu-x86 bitbake zephyr-kernel-test-sleep -c testimage
> +```
>   
>   You can also build and run all Zephyr existing tests (as listed in the file
>   zephyr-kernel-test.inc). For example:
> -
> +```
>       $ MACHINE=qemu-x86 bitbake zephyr-kernel-test-all
>       $ MACHINE=qemu-x86 bitbake zephyr-kernel-test-all -c testimage
>   or
> @@ -107,16 +140,17 @@ or
>   or
>       $ MACHINE=qemu-nios2 bitbake zephyr-kernel-test-all
>       $ MACHINE=qemu-nios2 bitbake zephyr-kernel-test-all -c testimage
> -
> +```
> +
> +## Generating OE Machines based on Zephyr board definitions
>   
> -Generating OE Machines based on Zephyr board definitions
> -========================================================
>   We currently have a recipe called generate-zephry-machines which will go through
>   and attempt to create an OE machine conf file for every board in Zephyr.
>   
>   This is run via:
> -
> +```
>   MACHINE=qemu-x86 bitbake generate-zephyr-machines
> +```
>   
>   The output is then put in the normal deploy dir. This recipe is really only
>   useful for maintainers. There is currently no way to use the Zephyr board
> @@ -125,14 +159,15 @@ you will need to run the above, copy the conf files from the deploy dir to the
>   machine conf directory and then run your build. This shouldn't need to happen
>   often.
>   
> -Generating new Zephyr recipe versions
> -=====================================
> +## Generating new Zephyr recipe versions
> +
>   The script meta-zephyr-core/scripts/generate-version.py is used to generate
>   Yocto configuration for a Zephyr version from the West configuration in the
>   Zephyr repository. It requires the west and jinja2 Python packages to be
>   installed on the host. Run it as follows:
> -
> +```
>       $ ./meta-zephyr-core/scripts/generate-version.py x.x.x
> +```
>   
>   where x.x.x is the Zephyr version.
>   
> @@ -140,17 +175,37 @@ The patch files added to SRC_URI in the generated file should be validated and
>   modified if required.
>   
>   The new version should be committed and submitted to the mailing list as
> -described in "Contributing".
> +described in "Maintainers, Mailing list, Patches".
> +
> +## Maintainers, Mailing list, Patches
> +
> +Please send any patches for this layer to the yocto-patches mailinglists
> +with ['meta-zephyr'] in the subject:
> +
> +	yocto-patches@lists.yoctoproject.org
> +
> +When sending patches, please make sure the email subject line includes
> +`[meta-amd-edf][<BRANCH_NAME>][PATCH]` and cc'ing the maintainers.
> +
> +For more details follow the Yocto Project community patch submission guidelines,
> +as described in:
> +
> +https://docs.yoctoproject.org/dev/contributor-guide/submit-changes.html#
> +
> +`git send-email --to yocto-patches@lists.yoctoproject.org *.patch`
> +
> +> **Note:** When creating patches, please use below format. To follow best practice,
> +> if you have more than one patch use `--cover-letter` option while generating the
> +> patches. Edit the 0000-cover-letter.patch and change the title and top of the
> +> body as appropriate.
>   
> -Contributing
> -============
> +**Syntax:**
> +`git format-patch -s --subject-prefix="meta-zephyr][<BRANCH_NAME>][PATCH" -1`
>   
> -Patches for meta-zephyr should be sent to the yocto-patches@lists.yoctoproject.org
> -mailing list.  See https://lists.yoctoproject.org/g/yocto-patches for subscription
> -details and the list archive.  Please add [meta-zephyr] to the subject so
> -the patches are identifable.
> +**Example:**
> +`git format-patch -s --subject-prefix="meta-zephyr][scarthgap][PATCH" -1`
>   
> -Git can be configured to send mails appropriately when using git send-email:
> +**Maintainers:**
>   
> -$ git config --local sendemail.to yocto-patches@lists.yoctoproject.org
> -$ git config --local format.subjectPrefix meta-zephyr][PATCH
> +    Lee Chee Yang <chee.yang.lee@intel.com>
> +	Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
> diff --git a/meta-zephyr-bsp/README.md b/meta-zephyr-bsp/README.md
> new file mode 100644
> index 0000000..e159015
> --- /dev/null
> +++ b/meta-zephyr-bsp/README.md
> @@ -0,0 +1,5 @@
> +# meta-zephyr-bsp
> +
> +This layer contains machine files for building Zephyr applications.
> +
> +For more details see [Building Instructions](../README.md)
> diff --git a/meta-zephyr-bsp/README.txt b/meta-zephyr-bsp/README.txt
> deleted file mode 100644
> index 2644ed0..0000000
> --- a/meta-zephyr-bsp/README.txt
> +++ /dev/null
> @@ -1 +0,0 @@
> -See ../README.txt
> diff --git a/meta-zephyr-core/README.md b/meta-zephyr-core/README.md
> new file mode 100644
> index 0000000..18db977
> --- /dev/null
> +++ b/meta-zephyr-core/README.md
> @@ -0,0 +1,6 @@
> +# meta-zephyr-core
> +
> +This layer enables Zephyr build metadata such as zephyr scripts, kernel include
> +files, zephyr applications recipes and bitbake class to support qemu boot.
> +
> +For more details see [Building Instructions](../README.md)
> diff --git a/meta-zephyr-core/README.txt b/meta-zephyr-core/README.txt
> deleted file mode 100644
> index 2644ed0..0000000
> --- a/meta-zephyr-core/README.txt
> +++ /dev/null
> @@ -1 +0,0 @@
> -See ../README.txt

