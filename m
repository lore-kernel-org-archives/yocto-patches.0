Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6877EC982ED
	for <webhook@archiver.kernel.org>; Mon, 21 Sep 2026 17:36:04 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com (SA9PR02CU001.outbound.protection.outlook.com [40.93.196.70])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1978.1790012156105650844
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 21 Sep 2026 10:35:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amd.com header.s=selector1 header.b=b6aKJInF;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.93.196.70, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHR4tamn2EjdmKbRItBLmlyNHC6zGDlkRIRQQjxjTCwmV3UW89sjK4HnYQFNhOYOTPLpNOI1wsqdB0viGSQ9umLFhU8kkhB4tm6po27+yg6y9S0bBK0/62Px7fqQxRF+ZR6OLKnbiDDPuCWLaHr/wdXI61FvjmMfs/RASwKpJmeL29TTZZcVKl40N2uYkljv3tbCkynpH4xwlbblJyuwcSR/xn614wPZ+QJc3UkJARfNIgH7xlL6dT2ezTq1jVAt4bwKwJ/LLvuB08JE9ddzyVOQ0N/8fUQ0sF9uCbw69PDWLCaDKekAU9iZ6DGzORMdCdOKHHyglyCs57nCQ49pIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yH3QVKWfifGS0PhstisltxTXpqgNyL3PJjBJUjFY4Mo=;
 b=WOi/2RdJbkLCcpoS+z6mz2asXL24DwMP7kr7j8TUkH5NFtiqtCE153QM6wZNxG6fAiEzm6o5JhImE+JabvFJN3h7mAfVVU7JUFBPMV1EBENwQKro7kgNcqWRnco1RD34mWiEkcjFEJlZXFUc/qnw/in1KLxpAVWfjtWP1ReKt/8Dp/T5+rlQEMETZu0FNaslkMupTHfhPJv3NqyGTMTbMkqlO0llcwW/54gAHCcLYJCfKkauO139fHrXyuiNfoERRk3FLM7odHWjfr5CGWgUubcCdrM9a90K6ncKrtE8cn7c/0fKZuiMrpKvrqpyz3OjWsY7cEFTLwMUo793GXjKPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yH3QVKWfifGS0PhstisltxTXpqgNyL3PJjBJUjFY4Mo=;
 b=b6aKJInFylpvfzA3pgElQpxEPGc78MeBNpcrrWXAr2iNtNFpB75GZpgUwMd3mbUCO3OpDSH7gR75GYAW0/bK7jxKcqXVm4TMMy2WctZfKDP8VjoHutFf6Sa4MqIQQ2uM44xR3xGDB87JAUJzSjap64FOXtBlrZ+iYv5OeiS4JPQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB9004.namprd12.prod.outlook.com (2603:10b6:806:388::7)
 by PH7PR12MB9126.namprd12.prod.outlook.com (2603:10b6:510:2f0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Mon, 21 Sep
 2026 17:35:44 +0000
Received: from SA1PR12MB9004.namprd12.prod.outlook.com
 ([fe80::b08b:7d29:b1b2:1cc]) by SA1PR12MB9004.namprd12.prod.outlook.com
 ([fe80::b08b:7d29:b1b2:1cc%5]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 17:35:43 +0000
Message-ID: <ad74d9c7-bb18-48d5-bca9-30405bd9f4ed@amd.com>
Date: Mon, 21 Sep 2026 11:35:41 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches][meta-zephyr][master][blacksail][wrynose][PATCH]
 zephyr-toolchain-zephyr: Unexport Yocto toolchain variables
To: yocto-patches@lists.yoctoproject.org
Cc: chee.yang.lee@intel.com
References: <20260916150036.1839867-1-sandeep.gundlupet-raju@amd.com>
Content-Language: en-US
From: "Gundlupet Raju, Sandeep" <sandeep.gundlupet-raju@amd.com>
In-Reply-To: <20260916150036.1839867-1-sandeep.gundlupet-raju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0024.namprd10.prod.outlook.com
 (2603:10b6:a03:255::29) To SA1PR12MB9004.namprd12.prod.outlook.com
 (2603:10b6:806:388::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB9004:EE_|PH7PR12MB9126:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ce1f3e-b43c-48f5-b2f7-08df1806c349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|22082099003|18002099003|56012099006|11063799006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info: 
	IiT2I1o2YEO+wHiDQjiajzkpYMMWcflOzg4+qx9y2ohwltk5SDLRuaxsOKKDkRmxrrkMn3lEuftWwXJONkJ5PTY/nCmxSiDxZekEQ68tfCIv6SGoA+L5Zv3fPMQ2DfJotp9qhmnydgWKxnNO4zccveuBYi09TUGj3oLtNKfuMF4hPVr2r/YsSVHU7aiEpQqFOjXmZn3I0EtfStFaGOObQbtxr+RkBushxj/DqEEFZyAO/L+krBd3/YSaPdHZarGXpMDfIwoWsYzgoETzMl/pj8v0lFymK6doqDHtPtn3e6LSfr4ZAB8yS9M3CVhwGUNXpqkSk15KyOHLC/r+20TsVwd+V3+/mrOfC87vNYr1coqSaVjqdZZRjabrQYQBPZQxrpIUQcakoheH8u8RXopfsJ10iYOPB9+bcS834RKhQjmkVs+ORWucJSD6trBA9DnP7Gy4nEA5rCA5q1BThVJgnalYdiqBER9Z9Pj3nXVq7MJC9DHctIjEIB0vjed3gJvBLQiGFWlIQOi279+W7TEysFNuNamdw82eT8ywNrWSYUMYdf6G3gHOqJ/MqmHGPWNV6yG0v22y28vU/dCz48rfH3UFQApYwcT7h0L46f9oU/ZLmTT8SXsNAlDxPZzuIlzVrumeEIbWT2eYOosoEqQP7F3HMOsVta/+qVusn9rgjKY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB9004.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UE9CNFlOeGg0QWFQeTB3dExWdlV1dWpvcmNaR3d0Ync0Zi9IL1NHT1l4aFMz?=
 =?utf-8?B?eGMySUR0MklKNXdsSGp3cEVQM0NySU1hUTNaT3c3UWZ0bW1YQzJJWXJTMW5k?=
 =?utf-8?B?UHlnN29RNmxQcEpIZHYyYW9ISTNQWkpxcWtiMng0M1lDVlZJMVVVcCtqSHdP?=
 =?utf-8?B?ZFZyVmQ2UDZoTDA1elRQU1o3Y0RGTFgwdGZkYkllTE4vODRDK2MraVhCOENN?=
 =?utf-8?B?WUJsWEFVRGJMcGxuVXU5Si9VSXJOVS9tVWMyZzBjL3hTL0lXaUFrVkNZNFlD?=
 =?utf-8?B?QllXMnRHWEowTUFteStaKzQ4ak1FZ3czcVZmQmZRRlJTRXEyRFl0cGp6c3dI?=
 =?utf-8?B?NjhSNkdaR1dqR3NwUVNuTDhRNmEzVTZ5MDZOblNYRUc5aEJueVBLZzJVcDZS?=
 =?utf-8?B?UC91Y0U5N3dSN25YZ2lwRzBpUlc5NVdWcmthaUx4T3lwajJLbTlYNXc1bkw5?=
 =?utf-8?B?SzU0TkhOaVJ4aW5JOHF1WUd3NTQ5RXQ0RS9IUGtEVytTZHkvbGtjY1oyOVRp?=
 =?utf-8?B?YVVweGp3TWVYeFAxWk82MndqbEVnWnpkdnJIemNncDFNTXZLb2dPSncxR1lO?=
 =?utf-8?B?dlU1WS9ZY2hrTE1UV0JQMTlGUWVIdFMzY3Z3WmpTTU9LZXliUVFqMFFmQmln?=
 =?utf-8?B?Z0ZvQ1dlSDE1ZllPK3Y4aVNONk4xMm1mSGJzV1JVVTFaNXVoOUlaTUQvZ2pq?=
 =?utf-8?B?M2ZtU0Z6dzlTTmtLcGFrRDRtNVJRazBOemR5bkdVWDVEZWFnR0EyWFFTcUdP?=
 =?utf-8?B?RE9UU1JmS1RyK2lBR3FrTHB4cHhyWDg4RC9vdGd3OEozaDRIc1ZlNm1TbWE5?=
 =?utf-8?B?WHVrTWdkUGJMb1BDUG9HdUxRbXBmWFNrTzVaVFNSZ3lrZnFhcm5JSDhTcmh0?=
 =?utf-8?B?NWFzcUJHVUJIZENIWGdRajFwZGJSS3YrMzZ2eVlCOWg5OTNOYlN0WHZpd0wx?=
 =?utf-8?B?MHYyVnY3ejMvbTdLbENCMFF5eUg2WnIvUmlaQnRqWHVVYko2RE42UExiWGZI?=
 =?utf-8?B?azdzN0hiUTdCRmU5U0hiZ3RVSUlOeTkwc1BIUFc5cXc5MkVVZ2EvS3dOQ3Rr?=
 =?utf-8?B?QU11VEcvdFYrU2tIRlRlTjdyWlhTWStNeG93dkE3aFFzWTh0bENaYjJxc1pp?=
 =?utf-8?B?R2FJeHViNDZDbTV1bVF3QXlpNlg2bjl6VDFqMUJCa0RpSlBicDVRbloyR2Ur?=
 =?utf-8?B?L2Q4dUFaV2FQRVJKSnJnbThSNnJReTZjVkJsc3FaN2V5ZnJsRlpKMTFTU3ZQ?=
 =?utf-8?B?OGtmeVAzMmdJbjRVSFQ1bDhqRXFMZzVpVlYzYUdVT1VUcmJQOUZMc1RCN2R5?=
 =?utf-8?B?NCtxa2Mza2ZQaFA5OFdqRjl3RFUzSDVuSGgrSmdDSFlMczVaNUI2NmlaTTBK?=
 =?utf-8?B?NFNSem9CSy8wZkFmRjFzMkpvRUR2TUtQTlhVTjBWZWNqZGhBRENtc2hZNjl3?=
 =?utf-8?B?M1BGRnoxYmFZYW5ZS3BYRHlNL045U0xiWXlvOXRkVEhCZEZmb1FXQk01Wk1J?=
 =?utf-8?B?bCs4MDdZNjNkMmNtcUFwbU9UMGVmckRHTHl6bzZGSWYwMU12dU1qTndxTDdq?=
 =?utf-8?B?amN4REdoQ0lCak5UMHpESEJpSG0wR241TnhyaS94Ky9vcDN3dEFFK3I0Tm9E?=
 =?utf-8?B?N1lvSGIrdlF1aDFaaWV2bnNCOFVmL2Z5UXAwT2V6ZGhYQXQyZTlYVGxGcmJv?=
 =?utf-8?B?SnZEdXFBNDJOSWYxRnoxQ2FRVTV5bXIxTE84d0FaSXNQTDhvOC9LaXo4N2xK?=
 =?utf-8?B?UXVVZGdiVHpBaU9XRDBGM2FQZmNiaU9EMzRyUC9xM3ZBZ0dNLzY2QmVDZkJG?=
 =?utf-8?B?cC9WVmRQcU1TYWtuNTNsZnhqS1dPUSs3SXg5OENuR3FHQUNjNlAvMGZyTnFX?=
 =?utf-8?B?eXp3cnZVWjhKNXVJMWFKRmlWcDFkSDRGbEFrS2ovRktLL2NmTWVOZUV1VUpq?=
 =?utf-8?B?cnh0cFhiZDBYNEdtaUtvSVkxMEh1Wk5jOEpNTHFqOTY0OWh3MkJWYThjWWQ2?=
 =?utf-8?B?Y0w4b0g0dE1jUVI0NDJEem53Z21VZU1LNWhDN0YrK0JOTVFtSUJpKzhrU0JP?=
 =?utf-8?B?eFRhSjUyV0crMkZmWVcvWEQ3QjlRVlJETU1qM3VGMDlLbzY2V2lVNWs2dTgw?=
 =?utf-8?B?N3E3RWtkQnVjZzlhU3pLcHJvUXRFNHRwMzQrUjhPcmZjOUZJbDRIdlE3TEFp?=
 =?utf-8?B?VFhuczIvbytsV0IvaGhmSW5qQ01oaGRXNFlLYU00aWptSzNTbG83Mm9ITW1Y?=
 =?utf-8?B?ZS9IU0plZmlwOVFSZmczMTlTbTdmZTNwSmlZVVBBZjVqM09NSWdnOVJyY3pC?=
 =?utf-8?B?VkhmUkdWS0NWK29CNVNGTlZoaTIvbENTZFhtTTZHemN1ZllkUi9LZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ce1f3e-b43c-48f5-b2f7-08df1806c349
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB9004.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 17:35:43.7523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pj5iF/m5QLviG65DpYWk6TGX4fvw88/3jeCYK6Ud+GpxZFfqfi7x8S3khE1KJagahJWoAHSmsYzRrt77oC/arQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9126
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 21 Sep 2026 17:36:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4923

Hi Chee Yang,

Please merge this patch to wrynose branch as well as this is bug fix.

Thanks,
Sandeep

On 9/16/2026 9:00 AM, Sandeep Gundlupet Raju via lists.yoctoproject.org 
wrote:
> When ZEPHYR_TOOLCHAIN_VARIANT is "zephyr", INHIBIT_DEFAULT_DEPS is set
> and no Yocto cross toolchain is built for the recipe. BitBake still
> exports CC, LD, AR and friends into the task environment, where they
> reference aarch64-yocto-elf-* binaries that do not exist.
>
> Zephyr ignores these and uses the SDK, but external module build systems
> invoked from the Zephyr build do not. Trusted Firmware-A is built by its
> own Makefile, which prefers CC/LD/AR from the environment over the
> CROSS_COMPILE value pointing at the Zephyr SDK. Its tool detection then
> fails and expands a multi-line warning macro into the tool identifier
> variable, leaving embedded newlines that break a later conditional:
>
>    lib/libfdt/libfdt.mk:16: *** invalid syntax in conditional.  Stop.
>
> Set the unexport flag on the toolchain variables so they are unset in
> the task environment and TF-A falls back to CROSS_COMPILE.
>
> AI-Generated: GitHub Copilot (Claude Opus 5)
>
> Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
> ---
>   .../zephyr-kernel/zephyr-toolchain-zephyr.inc       | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-toolchain-zephyr.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-toolchain-zephyr.inc
> index e265883..8fa3e09 100644
> --- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-toolchain-zephyr.inc
> +++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-toolchain-zephyr.inc
> @@ -18,5 +18,18 @@ EXTRA_OECMAKE:append = " -DUSER_CACHE_DIR=${ZEPHYR_USER_CACHE_DIR}"
>   INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
>   INHIBIT_PACKAGE_STRIP = "1"
>   
> +# INHIBIT_DEFAULT_DEPS means no Yocto cross toolchain is built for this recipe,
> +# so the exported CC/LD/AR/... point at binaries which do not exist. Zephyr
> +# itself ignores them and uses the SDK, but external module build systems
> +# invoked by Zephyr (for example Trusted Firmware-A, which is built with its own
> +# Makefile) honour them and fail instead of using the SDK passed through
> +# CROSS_COMPILE. Keep them out of the task environment.
> +ZEPHYR_UNEXPORT_TOOLS = "AR AS CC CPP CXX LD NM OBJCOPY OBJDUMP RANLIB STRIP"
> +
> +python () {
> +    for tool in d.getVar("ZEPHYR_UNEXPORT_TOOLS").split():
> +        d.setVarFlag(tool, "unexport", "1")
> +}
> +
>   # Set Zephyr work directory to describe toolchain accurately
>   MULTIMACH_TARGET_SYS = "${ZEPHYR_BOARD}-zephyr"

