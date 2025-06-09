Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E198C61CE8
	for <webhook@archiver.kernel.org>; Mon,  9 Jun 2025 16:14:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (NAM10-MW2-obe.outbound.protection.outlook.com [40.107.94.75])
 by mx.groups.io with SMTP id smtpd.web10.64021.1749485643968963537
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Jun 2025 09:14:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amd.com header.s=selector1 header.b=opOzFNkZ;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.94.75, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=spz1Z6b2R2kmC9OrimU3Jwp79KD6mRaf2j2P78two4Xl8aZY6Rcl8Lo26LPoKaggPeS+c2ffzkss3SMynK7Cc+UaE2SyEJQswsHUPWT7a7Tz/vVnIUh5PSKfxKy6SxywH5ttkU2bQ8V/vnF6YR9mUM3H+u969ZFsq9wdijNumJ7o7qjXeJj1u/dLxVnpF04GUC4Fag1yiKpxmeutCX4t7wAgZhv/w10UQbtt9o4uPZIEsBq5ec2aPRL8Vlti3xonknmyRRbdDKV5YkIrjViJI3hlpFPAd/egS44vdkfO6Ct0XmsxFnw5aDRle73owjxRhBH75nVUnvYL4xL+VRaIVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lpFe1wDFBYfcatViNZPvbH+DO+SiHEUjkih2K6re/Q=;
 b=dQTNDDRrtRKzEsJD852Xk3HA/TqCZpanxpifN0zjXspkVkUuGgI3srDqCabvVDk62Z1VA4g5mw7M6v8ZqLLUb1O4ERl/PBo9q8qQTIQmD/HtCTxFKqjU6WdUrooKzOdUFOmRHf9Htt4S4aNHes6LOOsZND4s5sdXMxWBqe7ZzO5l9hE85OVTUh+Q+LCPTN4jJkOQAUodn9mOu3JPA1FZx2Ir403ZAC8kcUo7udP1/g0ANsKI0FrM6OeKPCu4pVCFAQN7ZiiVQwgIkV6IvhDvAloMHLvlZJG/vcteYohqEKVD1MNhqiGwaBMeqZwKM4sKiL6fD0ZZDxpoc+mWzeejag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lpFe1wDFBYfcatViNZPvbH+DO+SiHEUjkih2K6re/Q=;
 b=opOzFNkZ+TzDqFm0zWH9a3cd1idGxBlEMjYh+T4loVimpenyCYcFxYy30FVf5vIL9kEV55+2+n1ayqEFimcI7/PZiFl2jC+eaS6a+vSG1usZYAkyuuZhsL66asYrDnMRFVk2G11ShWp8QZp4QQBqFNFhekbi3BmDM92QVrhlnD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4357.namprd12.prod.outlook.com (2603:10b6:208:262::19)
 by DS7PR12MB6359.namprd12.prod.outlook.com (2603:10b6:8:94::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 16:14:00 +0000
Received: from MN2PR12MB4357.namprd12.prod.outlook.com
 ([fe80::fb07:a830:460:38fe]) by MN2PR12MB4357.namprd12.prod.outlook.com
 ([fe80::fb07:a830:460:38fe%7]) with mapi id 15.20.8792.040; Mon, 9 Jun 2025
 16:14:00 +0000
Message-ID: <ed8169c5-c79a-44b4-821c-9afde28a681c@amd.com>
Date: Mon, 9 Jun 2025 10:13:58 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-zephyr][walnascar,master][PATCH] README:
 Update instructions to fix warning
To: "yocto-patches@lists.yoctoproject.org"
 <yocto-patches@lists.yoctoproject.org>, anuj.mittal@intel.com,
 will.lee@altera.com
References: <20250522210754.4006865-1-sandeep.gundlupet-raju@amd.com>
Content-Language: en-US
From: "Gundlupet Raju, Sandeep" <sandeep.gundlupet-raju@amd.com>
In-Reply-To: <20250522210754.4006865-1-sandeep.gundlupet-raju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::12) To MN2PR12MB4357.namprd12.prod.outlook.com
 (2603:10b6:208:262::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4357:EE_|DS7PR12MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fb62a31-9522-434c-b127-08dda770a4e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?d2NOZkFUVUJnVmlUVUp4TzUyd1pMbFRCMDZSemlJckFldDhCcDhyNWVZcm1k?=
 =?utf-8?B?U29XVzU4ZmFZZHpMRHQzb3FheXN5UlB3ZnE0em9YS3ZaY2JQa1FGRjNFZDVD?=
 =?utf-8?B?MkFOdlRPYkIzR0tHZ01tcWRCa2NSR3VmM1doa2ZjWTd5WUR0WGgrVXNxSWMy?=
 =?utf-8?B?K3l4RTVBdHFCM2ZUcTBHVlZYWHRQR0JlOGE4bjdlMFMxTlhHZEpqUEJwcWFM?=
 =?utf-8?B?VHd0aHN1ejc4UmNQNFJXVWU4bUsyektqdEllTHA5Uzh1aTdlYlBjOXlFK2xr?=
 =?utf-8?B?YnpKeWY0QmNmSVdFcGRHM28ySzh2aW5XQ0M2WW53YjFkam8vci9odnEzcUpN?=
 =?utf-8?B?U2RlTzZtMjFkeDhLQmsvaXZveUNIM2w2Y2pIcS9HaGgvb0RldUlSQitKVkMy?=
 =?utf-8?B?VkdKZitVWmRiU3R6MTRMMjZjVU9OS0NpakhwbzBMZnBsdVhXdjRlT29FNjJH?=
 =?utf-8?B?c0hQaUpXQ09BWVJEL3FTWnA4aUtFaGZkUE1PSkRZUG1uQmxCSzdrOWw3Z1I4?=
 =?utf-8?B?WkFDNlhJNC9JSlg5MjZmUUkxSkRPbVg4VmhDZXVqSDY1N0VhOS9mK1hwRUts?=
 =?utf-8?B?MzE4eVpFZjYxRlRHTTJKOEpWVDZ1YWkweStaNnZIOW80YnBiTWRXV3AxbEdj?=
 =?utf-8?B?SUh3VUlUZTFrK1RlSEw5cXc4bWkrbVc3K1JhMWFKdHZXQUpKQXhvSlE5Z2Z2?=
 =?utf-8?B?TWFCbHRZYkFhZDh2MG1Ia1ZTcDVuYWQvNncxYUluTDJTUFhQcEV4dys1K21C?=
 =?utf-8?B?LzZQUmdKT0xIQUJweFh2clZ2QU56OHZ4cDdYYkRtUXRVRWEyWmRDRmc0VENN?=
 =?utf-8?B?dGgrMWFmZ3R1bG95V2JzZFZ4NWM4M2VyVFRjSG5Qd2FjNzRyQVdGUW14RTky?=
 =?utf-8?B?TEtUNFNDcENWQlFDcW5mTWt1VlUva1BzUU1sdHNvSDA1b2pJVzlNaitSd2xO?=
 =?utf-8?B?UmtmZnFFWVptL3Q5aFc0VWowc1d1VnhWTkM4WC9mejdvVmNkQmVrQkU1eE1O?=
 =?utf-8?B?WUZXWHBoeHBoU0hPZzFSTmtIUnVKL25zVVBVbGVNTTBES1BJWmVZZFBZRXlM?=
 =?utf-8?B?c09SS2FOSDZDWHFSTERvUGdvbVEvTFR2enBWUnNDZHR0bU9wSVN3VjNYZ3p6?=
 =?utf-8?B?b0dWZEl4SlRZMG4vMHByR21kMjFpa0VnVXZzclY0RktGOG5lS1h2Tm1lTTZU?=
 =?utf-8?B?SjNCRmJiL1UwN29SeVNLeW5jS1ZtaXZIckxxV2hKemZEekNVTS9rcDN3WTND?=
 =?utf-8?B?VEsrSG90VkE2cTY2Wis0dWpWZkRXQjhVMGN3ZjZFYlRTT3YvZ2JKWTdpd25Z?=
 =?utf-8?B?MDU4VHh1QlJ1YUwvUUJBMXlWUDhRV2E5cVZBbmUyUWpYWWQ1emtGWVYrNFZx?=
 =?utf-8?B?R0NrOTNCWUZXbEZQbmJaRTdDK2pzWWQrbG03NTJpSHBMbVlHUWUvc2tRRFNt?=
 =?utf-8?B?WXRUc0lzdmxXeC9xb0poNEJNOFNKQTdOVW9jdFA4OEtkdUlSQVZHYVVFNS9U?=
 =?utf-8?B?ZS8vb2xDYkc2bGNUTGh0aDdqa1hjUDczZ3NJN2FVOHFFVTZLcUYrd3Z5UnZs?=
 =?utf-8?B?U0ZHMHgwV1pMTWhnbTJBUDNXU1JjTTE4WWxoQkZHVmF0VkhhM3Rndy85LzJ0?=
 =?utf-8?B?aG03UERhb2tPcXZlOGR4R09pMlpvTmVXSVBSNldMVVM2Q205N1RIcXhKTEdn?=
 =?utf-8?B?d2gwd2hNQ1VZNzU5OGlJZ2RndGhCbVhCRm92MkZIc2gwSDNmNXlPOFNFa0NL?=
 =?utf-8?B?cU5tRFF1WFVtOFp5MEZCdkFNaTRqMU9oa3J6ZHRPSlA2d2xjTCttamppVWsv?=
 =?utf-8?B?dWJLU2gxUTRmRFdyd2hMcEI4d2FadVo4OEIxTElpSGNuNXFXM0FBNUxVckxh?=
 =?utf-8?B?U0F3QVk2UENwblRUZVEzVGk0ZXhYYTZBZEthRXlLVUhiVWFob21IRjlkN2xn?=
 =?utf-8?Q?7VAiUNS1g3Q=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4357.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d3ZZUzlXQ1lvU3NmTXVlR3ZjVVp1ejZ2YVR3eUJKWnMvbHVjN1A5QjRBRmk5?=
 =?utf-8?B?MmtEeHNDWXI2bTNnNjQ5V2VsQ1lHUjFRSVUzdFk1Z2M4S3VlbEhNT012VXRH?=
 =?utf-8?B?am55VjQwUEtqd1NJS0FRTkVYSlU4ZmZocXRQYjhhaVArVHI2OXFNUGFGUkVn?=
 =?utf-8?B?RjNlQXBYV2hwVW1NNTY3OG5xbTJPdStDODlWNmZKYjBoaENKbnVGS0VZZ0dE?=
 =?utf-8?B?b21rd3BKd1JYdndGSllZQlBSQ0hrNzd0OENiSkh0aHcvc3VvT0loYmpJNjFy?=
 =?utf-8?B?V1ZITnFnTjhLOSt0Sk1LcDZycFRhNWRBRlB5ZVgvelVnMXFiWEJEMFlUR3c3?=
 =?utf-8?B?eTFqUEFITlNSOVk3aGpwdlovTEVUZXhleXZJQkJIanhyS3JzUlFnblQzdHVW?=
 =?utf-8?B?dkZhZ21kV2FtVVJrRllKSFhPbTFlZ0dMUUlCQ2loQXJvODkvMjB5cDVCc2gw?=
 =?utf-8?B?bnA5eC84MGdiNzdlNlFCYldvQzRhK3RSaFZPMFVUVHgwYXYwcGRQeDBzK0V5?=
 =?utf-8?B?dFA0TlJiUkdXaVZRbkQ1WFIxaUNGeUFXZnA2Z2NoclpCdmRaK2Zqc294ekRE?=
 =?utf-8?B?R1VuT0YrOVZLKzFOK1psNmlkSTBIUFBIakg0dmt4QzE5RktPQ3BCREsyN3R0?=
 =?utf-8?B?WkV6WVUxYm1hOW9WTi9GL2FNNDZtS3k3TUJPSng5VmNzOG80UUV5dWg0bzBL?=
 =?utf-8?B?bUNGajFqaDY0cUxIaGw1d2lYcFpRRmp2OU8wV1B0WGtpYTBJNUV6QU44eXJE?=
 =?utf-8?B?R0tReWJjeHhmcE12MTNMMk5lbW9JNHh0TzErTktnYU5lQmZyVlBnRmN0U25D?=
 =?utf-8?B?aWY0OXNZSWRJaXNWVGRzaldiWVhTRXdIWHBUOFpvNDNXQ0E2L0VIakRxNmRi?=
 =?utf-8?B?eUlGL2dxcCs5WlhibFBpWUM2dmhCOE5MRld2OXduNVlmUW54SXBrZHM1ZXd1?=
 =?utf-8?B?WnBzM0c0YzZiUEpYdERKY1VhMXhnSHIvMDJ0aTVBVVhHc3RSUEtuc1BEajkv?=
 =?utf-8?B?Mkt4bDIrKzAvbGJVa0lucnhIaWZGWm8vT0E0RkVMYTh6MFh6eG9ZK0FZSUxN?=
 =?utf-8?B?ZnVMZnBYS0k5MkgrOVlrR2NYV3doSk5BNEw3QnJvTEg1cDBrSk9lRkllaGND?=
 =?utf-8?B?WWEybzFkYWIxV2xySjZJNWR4b1dXZksxMXljTGx2bUNsUnZXY0xaYzlIdTkr?=
 =?utf-8?B?TXBZQXdUOUFnRzRraGJiNnQzQ2toZ29mNEJuK3c2eUsyREEwdzFxRFF6d2VK?=
 =?utf-8?B?ZTg3TTVCUHlyd1NKY0c4K2tqRjJYWTRqYXc5bERrQ2tnSHM5TXR5TVJlSWNO?=
 =?utf-8?B?UjdXdisvVTFMRzVoNmk0d1l4Z1pLb1E2TEZoYVlXbkd6MElCQVBDS3cwc1BS?=
 =?utf-8?B?MGZDWjR2UHo2Qmd2QUd4ZTlSdVFLYnQyMVVTMGx0NlAxZUdFeWMxbGFsSHJw?=
 =?utf-8?B?cUR1c293SEErcVhlWjlyR21OM0gxUTJqajR3eVU5TXl0SU4yNHpyQWttN3dG?=
 =?utf-8?B?bW1DUnFMOHNRQTQzZjRIVHZkQ0VLOWlxYVlXTGNxNXl1YVd4OXBIWHhrN0hL?=
 =?utf-8?B?YUxkQ0xUVE5JQVdnS0pFOWJHTmJ1bEZoQmNtWGVsNVZaY2JoaHc0cEp1TTZx?=
 =?utf-8?B?MWhYMm9remRNcEUwNmZUMkRBbTROYU5tS1RweURJUGJkMFRzYWFib3cxZVRt?=
 =?utf-8?B?WnNJZDRvc0FxTVR3WG9POEJnYytUMzdXRGFpZzB1WWkwM2tDZ3JRdmlYUGVB?=
 =?utf-8?B?d2V2T01PSDVZOC9pWlhPOUxEb1VxaGk5TXRLWE1OVnI3ekpCNko4TzN5MlFU?=
 =?utf-8?B?WEdzWjU0RlNJRllESTdYOVhnRFM2SFRoWlpqMUJBbE40cHJpU2xFZElFTkJM?=
 =?utf-8?B?WkR1YmxMcXdBMEtUb2ljdU5xQ0oyczdBem1kT0NVbXRnS2NSS1BkSytodXE2?=
 =?utf-8?B?eEhyQkhZMmx5NmdtdERrYXJkVm9RY3NiZ2RNOGRZc0pVT3ZCdzhtYW94K0k1?=
 =?utf-8?B?NDRjV0tjM0pqaXhwbXR3MlNCcm42Sm9IRXdDbEcrdWZhVUxPd2R5am94MzZI?=
 =?utf-8?B?OGVPNzFDNzVGK2QxSmNYdWJGQmtTMnJaTzNDdHI4SnprNnBLT01DcER2TEw2?=
 =?utf-8?Q?ZMSVXeUJtK5LBZ2/6CfueJ3H7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb62a31-9522-434c-b127-08dda770a4e7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4357.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 16:14:00.3454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xSVuLwEI8nxd5pAmHjwiyNTsNDKyEDj4o9qzmi+7UyxtVOPE7VdC3RUW7INtS7FIRd5ogKhzejHKebq1vm0uSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6359
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 09 Jun 2025 16:14:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1626

+ Anuj and Chee Yang.

On 5/22/2025 3:07 PM, Sandeep Gundlupet Raju via lists.yoctoproject.org 
wrote:
> In README instructions DISTRO variable assigment doesn't have
> whitespace, due to this bitbake throws the warning messages as
> shown below.
>
> WARNING: /scratch/sandeep/yocto/yp-master/build-zep/conf/local.conf:291 has a lack of whitespace around the assignment: 'DISTRO="zephyr"'
>
> Hence update instructions to fix warning messages.
>
> Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
> ---
>   README.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/README.txt b/README.txt
> index d3694a6..247c029 100644
> --- a/README.txt
> +++ b/README.txt
> @@ -24,7 +24,7 @@ Building and Running Zephyr Samples
>   You can build Zephyr samples. There are several sample recipes.
>   
>   To use the Yocto toolchain, modify local conf by adding:
> -    DISTRO="zephyr"
> +    DISTRO = "zephyr"
>   
>   To use the Zephyr pre-built toolchain, modify local conf by adding:
>       ZEPHYR_TOOLCHAIN_VARIANT = "zephyr"

