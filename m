Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C19CAC597
	for <webhook@archiver.kernel.org>; Mon, 15 Sep 2025 13:21:12 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.23])
 by mx.groups.io with SMTP id smtpd.web11.33230.1757942466918257871
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Sep 2025 06:21:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=YiCFko3Q;
 spf=pass (domain: cherry.de, ip: 52.101.66.23, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HoMcPL34j6BNkvfqHVj+kd3qxAzgW0LP2h6xSvd7r8fAMrOtRuAq1TLFduI5rfp+CArhJhtmUY5dSQkvWBknSNKm9xx46Fc6EiHHMrq/mXY4NsDAPa7mfKsx2+2WqbHTuhEi+9vI6+WL9tnvXjOyvouWSHsosl48VzMduYT5wH4tkjZl7a9GGuTmC+9ezMBqMioZBbRSNCzoPZBlisKzSFXkODuHu5msjYCRXRvG7H9bUEvQmMkcPzQK8RJ4nHZj59wU1OzR5xqO/zg9j0Tf0MyoUQtC0ma/t6fsGOZn8BtT5UNEZawDrvKqEQ3eAln+AwkU+kktyfavLOSzqPljdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQpwOYmdLHWFo5GDHj23dBuO8p78pgvkRqmv7+QJcHQ=;
 b=rBDbwDd8d3HG8PxMuBW+2lI1SA9HLmQmEI1PPZIENnBm8CxdrrALeZYrRlLuTntcKEeCkV1d8M+MrXMtBQCg6tChSBJ8ctlIh0IIMWyQclsLgauTa0lrHF5onh7MudMCOMWhE5RCDVT6LgR4kgjlqhBh6OmpQlyKKo3U/9E+rGABem0WSLt+euifV9cjadaej6rz9VraUpraEcs5fa+N/WmUM4gNc798wvemNGG+GXx6AgwWvvRZAqBOdQk1ubh1GisY74gV63Ib5g2nPsgYIV2G2Q1nzP5fNDAFM7r8JC2Q5WPR6acLmDjFsB/um5mk+k69qA0qKE+RL4ehavrQUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQpwOYmdLHWFo5GDHj23dBuO8p78pgvkRqmv7+QJcHQ=;
 b=YiCFko3QwDlnoE/OWI77l89qcYtglLqg5BKzHZPfujSVYw/6a8vVT67IyfoRdrhqffGMcUBA0MHgqOXga8qXMJvz3fCLMr+GR0OaWhZ4QR1SG/C+rakDzawFgK+4TE0Xg6zzmp5lkbjLC2o3iAB4lNAReZAzIZe7sMgr4ICqWGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.11; Mon, 15 Sep
 2025 13:21:03 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 13:21:02 +0000
Message-ID: <8a7ec4a7-95cc-4d43-be75-9f88c9ead7e8@cherry.de>
Date: Mon, 15 Sep 2025 15:21:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH 2/3]
 scripts/run-docs-build: pass active releases to bitbake
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Antonin Godard <antonin.godard@bootlin.com>
References: <20250915-pass-bitbake-active-releases-v1-0-a5530a97b9ef@bootlin.com>
 <20250915-pass-bitbake-active-releases-v1-2-a5530a97b9ef@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250915-pass-bitbake-active-releases-v1-2-a5530a97b9ef@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0199.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::7) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB8PR04MB7065:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c467544-4c3e-4e20-0d45-08ddf45ab7ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RmtmVEFmc0tCQklrU0svdU10NWJseXJNdXZGbEI5YjNudnJFMklHZlJmMmZi?=
 =?utf-8?B?RGo4dG9XQjhoT04vMWRaOU1CTXpPaW16RDBFM0l1cm1IY2FFNnU0bXd2c0Va?=
 =?utf-8?B?MHhGSE1IRGY5L1RPUW83d2VvOFEvYm9SZUZBVzlTUjFZL0srMjd0VXFaM3M2?=
 =?utf-8?B?eTY0dmhFb3cxcjRkckM4bkVJcjRieTZFMnFXbFM3THUyWjR4L3A5Nmwvbm5j?=
 =?utf-8?B?T0doYStGY0J3NU9UNVhnK2E4V0xmWXh6TWVyZ3IrWmhTbXowd0lORWY5VVF6?=
 =?utf-8?B?ZTIrbWRIYlg1Z0RubkFkRDZtUXJXOE5WTnFQQzdKYm0zUFdURUNQVWw2cVpj?=
 =?utf-8?B?S1pNSlJuYVcyR213NXZIb29mb2JQRE0vY3ltS0tFWVJzM2xrS3gyaksxNDNm?=
 =?utf-8?B?RXplcWpEa2drN2ZHQkVlNmgwYW1kTlA1MnZ3R1pXZ0hNYzBueWo2TSs3UVZo?=
 =?utf-8?B?alYwUzdGUWdDRHlBOThpS0VkbWF5ZUhZMGtiWmRBY01MZklZV1d2L2tCTGNl?=
 =?utf-8?B?bEhFY1dXTTBsSFVCTXJmSWZnK2F2UHBvcWpFczFld2JzMklPVVFyYjhmTnF5?=
 =?utf-8?B?T1pza2IyZXhDM2hqNUpLMWFKMVVYYmRzVk4xMk92UGw2UW9pbld3ZmlKM1ls?=
 =?utf-8?B?eUlRcU4yei9EbC8rcG9hTEtSS2NNZ3FrRlRxRTdLOCtBenZ6SEFkd1pBYmVm?=
 =?utf-8?B?RnZVa3p5T0dLWHJXSWhrSE9lK2J6UHczTjFyU0l1WmJVb2FlUFNPOTF2SkIv?=
 =?utf-8?B?Q1U2MWZ0WlVtWFVKSThUa1pyRWlNVGErRFZEWXpqNkc0aExna21kdTRKUTkw?=
 =?utf-8?B?dVl1d1N0RzFsZ3grNmU1RWo0azc2VWhyKzlPSGwwaDF6blVYSVk3RndsTFJr?=
 =?utf-8?B?K0ZPZCtUcTZrRFRYSnkwWFhXOTRWcnRObjFUYWdJN2Q2cm9vMmNCQTNUL0Vr?=
 =?utf-8?B?c204Qkhxa081S05jS1ZHUHJ6blh2MzcxVlRCV2VPZWFuOEQ0M0N2NzFVWS9L?=
 =?utf-8?B?NnF4d1pkbkRVTVJQY2NEczQ4VytFWFVLUmgrQWt5UFZTZUtaNmhjMXE0aXdF?=
 =?utf-8?B?VThOQ28zSEVWdTlxVEtRb0tCNEkrZTdJdWpaWHpOTDgwUGxWUXJkTGdicW9U?=
 =?utf-8?B?YzBaSzdtVWNOc1luTHJKZDJxOUpaaTVTV2RuNTZQWXV1Qkt3MVZNRS9ham82?=
 =?utf-8?B?NWplMlJkVlRMLzhRcXF2Wk90Q2k0STZOY2p1T0dndHNIQ0dQWk5pZmpkbXVm?=
 =?utf-8?B?emF3K3l4WXg4b2svUitXNDA5K0dSZUtoWnNFb25PUDdjY2g5MW1oeEp4MjIr?=
 =?utf-8?B?RG9xUG42NnY2S1RVdkw2UXFiY3F3SitQa2xaRWhnUTFYMVdnRFNEQVNTZHJ4?=
 =?utf-8?B?ajRIS2k2ZkZGUFcybmVudTBuZ2M0L0R3QVBQS1hOYUNzZ0UwMko2SU9SR3Bw?=
 =?utf-8?B?Q0NtWmg0UVQ0aDM4ME9nNjhwcHB1VWJvNWUxdU01d1M0ZERqOTJCRFhWdm9j?=
 =?utf-8?B?di9BQjRUMEJDam9DaXQ2MU14NXBJRzZxRjJBdG5mVHlGMElqVGNaSURRNTE2?=
 =?utf-8?B?RGt4bUZUQ3BBUURtbFk5VUdPdlRicEY2dHZEdmYyRzhoeHh2NDRVR2thZ0FJ?=
 =?utf-8?B?NiszQmxGUFpucCtxQ1lIN054cDFmcGYxeVM4eURoM2tSR3JLSXNJMEMzQmNm?=
 =?utf-8?B?OUdSRWNTblUzSDNSMFRBa0tJZU1VUHZnUTZscVRyWEQyRFZnUEZuMHk3aDEy?=
 =?utf-8?B?dHltekpTK2RaWFpDOE54Z09SSGMzNnNPdmNWM0tZYjRienFJVmFmL2IrbXl6?=
 =?utf-8?B?L3BSaGs1UWNlU29QVVJuS0JNWTVHeEdzNVJXQ3JGbFFwbWpGVUxhZXROODRv?=
 =?utf-8?B?UnVuaUxnNVpySVVndnFPcUh4clRRdExveTN4Z3JyeEw0UUt4emxJWEYxbERL?=
 =?utf-8?Q?y5UDaWEk/kk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SHF2MjFIV1RndVIwM3VZMGNzQVdvMXl6T3VwTEdScHVXZUd6cW1SSHIySlhQ?=
 =?utf-8?B?WjFUTE5icnFwM3d6WjZ2d3o0ZXZ0OXNoaTZaWkhRdHgxWlFKQXQ1azkzYVNo?=
 =?utf-8?B?N3dkc2huY2xNMWg5NVlGekF5b0IzZ3l2Y0lxY3BjS3ZnZ0k4MVNLWVhZaC9E?=
 =?utf-8?B?U2hLSWE3eVR2dHRBbUFRaW9PemRvRVJqK0w4ekphMy8xQ3ZmSTlkTVRsZThy?=
 =?utf-8?B?QkJzL3lBWVl0Z0hucVdzVmpRdU9vK01EUUNHK2hpQTJkV3lQSlZpbXBoVWp5?=
 =?utf-8?B?VlhMZStwaWh6Z21MVUZzNTFDYW93Q0ZrdE5VZ3Q1U3VsdlVIaGt6N1VqbVlT?=
 =?utf-8?B?dFJla3JsV0pyMUJ2My9SWU0yOEtVdXNkNVNtR0NNekNnOElyeFpYYVY3R1pO?=
 =?utf-8?B?TkovZGZUNHZWTW5MUGtlNjdKSU12TmdzSmJ2RmM5ZHNlZmFMbFdhRllEOWRK?=
 =?utf-8?B?V0xWbEU1UGVxVDNRVkR1cTZQN21MYlBjdGUwdUFxSzFWK1h6RVJ6djBOY3Vn?=
 =?utf-8?B?Zi9EQTdFOFpDMGFrcnZ0MlkvSU40QWhwMlhnU0lTMEVjUjU0ZFpWRWgyQ1c0?=
 =?utf-8?B?UmsrODlsZ0hkbXl2QlY1cGFBTU10T3ViR1RONExxYlNUazZyYTVuQ0NEdk5p?=
 =?utf-8?B?T3pPdVNQdnlTTXNpbmQ3dExYSFZJYzg1THcwR2ljblhIM1RQNm9YTENQNHQ2?=
 =?utf-8?B?OGRpWTdZWXY5TWozZzJhSzQzcFB3QVE5ek5rMmVwQWoyNVEzbmoyMkREZi92?=
 =?utf-8?B?SHRsaE11a3ZHeWVKV0pMSWFFd3Y1b09lMEhOdUlaUEp4OGxoZC8zQTZRbnJR?=
 =?utf-8?B?RzVUenowWVozZjhIVlBMWlZibDZnQ29hRGZRdE8zR1pwVmFnS096T1Q4UnlS?=
 =?utf-8?B?RDQwY3VUbnkyMnZFZkt3cUtaZ3JmYm55Sm5kQVhVL3hLM3VmNEg3aldiM04y?=
 =?utf-8?B?ekZBSlN2czVRZG1JaDFhb2VocGZhRHpQOG9YcGxmOGpXUzB6WDA5VDVNN3lo?=
 =?utf-8?B?bDM1ZXg2cTV4R3pEMi9KdUdWWWxoYXk2eVR2ZTU5WFZRSitYN09Ob2x4djEz?=
 =?utf-8?B?VmYvbm9qOWJDTGFacFk5eEhlWUM0L0dxM1dIR1V3ZXQ1TlNnbVE5R1l2eGJ0?=
 =?utf-8?B?b0c2ekszNCtQdjhyUHhEczM4NzZ0M09jbHdwcU1nOXlWUGZMb3ZjQVEybTBQ?=
 =?utf-8?B?UmRaQ0NnR2oxaGlVN1hiZW54RksrM2VpOG14NUxtVmEzSG1ZMkVsQXE5ZVRU?=
 =?utf-8?B?eHBxcUR5ZUNveDhub2hPTmxMV3plTnJmSmZ0RWlaSnNsREZ1am9YOWpYamZr?=
 =?utf-8?B?TzB4K1o5SkV6TkEzT2tyUnphaVg2d2puSmNYemxJM0hJVEZpNnB3ZThYYlU1?=
 =?utf-8?B?RFo1SGROK1Y5b3VnMGt1enl6dWlEZmgzZk03T3loT2VyM2o5ZkFMWk5SRVdw?=
 =?utf-8?B?YWJhN3VEU1NCRmVudVVCZkVuRmZld3JNWmNwREhmS2lNOEtJcktnTEtlTFBx?=
 =?utf-8?B?aXpoUG94RERPVGJQVGdXK2Uycm9lSlBCNUtqRzVjQlVQUEZCNnI4S1VuTW9a?=
 =?utf-8?B?ZGRrOEk1S3FtZ0RUOXVCSVJPS0YvdEw4NGdWOEh1cks0OWlUQjZLQkJiVTk2?=
 =?utf-8?B?Rm9zWjlLVGlVOUdDN0lQOFgyNFZEaUt5Y2R4YWVHQ29CYjRzdWcrdUZzMGVx?=
 =?utf-8?B?WWdyVUphcnRlT2ppYmQ3bUdjTnIwaUtiSWk0RDZIRHY0VzFoajJRUDUyeGQ3?=
 =?utf-8?B?dzFQeThHdXdEY3hDckNRQ2xERnJHK2V6MFdnTWdVTlFaazE1bDhjQXd5K05U?=
 =?utf-8?B?c3BuNU9BaXlhdlV4Z0x3L01wV2F3ZVhqYitTZzZ2Z1YzY3l4a0NJZmh0a3Nq?=
 =?utf-8?B?UHE1Z1l3NlM4UnVNVHFVQ0kzWUZXMTNaNG4ydURWTnBZcVJqNFdmTmtoV1hB?=
 =?utf-8?B?bURjM2xEaWV4YWk5T3JYdEFKVDFuZDlPUUpVN3FRS1Rra3JZVVJhajVaT2ZQ?=
 =?utf-8?B?ZDlKV3lvNkpFK2g5UGdCbHVQZkpPaTN1ZlMxZXBjWW9RRkNmNTZtanFGSDJw?=
 =?utf-8?B?eGNMQVBPdDBaRHBkc0lLdmNnVmZHWmc2cUJiNVBMMEZEaEF0NFFHR01YUFB3?=
 =?utf-8?B?RDdQVGFxdFJGYmNhaUc1NzkrcVZpQzBJT09POFVHWVc1NERtbmlibzVxVWNS?=
 =?utf-8?B?M3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c467544-4c3e-4e20-0d45-08ddf45ab7ad
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:21:02.5797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ThKaebd6AVkoMkMdx8yZEcIB1qCbpOQ+wJ71FeLQU4zfzIUVc3wkgIC50MpEimqSZlBWcxGcRLxMoCN3MzqWyXIXXgVnRYMp4gMm3/xbyxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7065
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 15 Sep 2025 13:21:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2193

Hi Antonin,

On 9/15/25 2:19 PM, Antonin Godard via lists.yoctoproject.org wrote:
> BitBake's doc now supports setting the active releases in the switchers
> menu from an environment variable. Pass the active releases from the
> list in yocto-docs/documentation/set_versions.py. This way we only have
> to maintain active releases from the yocto-docs location.
> 
> The latest_branch information is retrieved from it, otherwise we land on
> the in-development branch (2.14) instead of the latest stable one
> (2.12) - at the time of writing this commit message.
> 
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
>   scripts/run-docs-build | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/run-docs-build b/scripts/run-docs-build
> index aa1847d..549032f 100755
> --- a/scripts/run-docs-build
> +++ b/scripts/run-docs-build
> @@ -111,6 +111,11 @@ tar --exclude=eclipse -xJf ${docbookarchive_localpath}
>   
>   $scriptdir/docs_add_banner.py
>   
> +# Retrieve the active bitbake releases from the yocto active releases, by using
> +# set_versions.py from yocto-docs
> +BITBAKE_ACTIVE_RELEASES=$("$ypdocs"/set_versions.py bitbake-active-releases)
> +export BITBAKE_ACTIVE_RELEASES
> +
>   cd $bbdocs
>   mkdir -p $outputdir/bitbake
>   
> @@ -121,7 +126,8 @@ mkdir -p $outputdir/bitbake
>   # see the latest releases.
>   first_sphinx_commit=84ccba0f4aff91528f764523fe1205a354c889ed
>   
> -latest_branch=$(git branch --remote --contains "$first_sphinx_commit" --format '%(refname:lstrip=3)' --sort='-version:refname' | grep --max-count=1 "[0-9]*\.[0-9]*")
> +# Get the latest branch from the active releases in BITBAKE_ACTIVE_RELEASES
> +latest_branch="$(echo "$BITBAKE_ACTIVE_RELEASES" | cut -d',' -f1 | sort -V | tail -n 1)"

I see... Bitbake development differs from YP's. BitBake already has a 
branch named after the next release, while YP only branches off soon 
before merging?

Another option could be to simply list the tags, and the take the 
numerically highest one and extract the first two numbers.

git tag --contains "$first_sphinx_commit" --sort='-version:refname' 
'[0-9]*.[0-9]*' | grep --max-count=1 -o "^[0-9]\+\.[0-9]\+"

will return the branch, provided it's also one number dot one number for 
the branch from which we have a tag named one number dot one number dot 
one number (which may be 0).

This avoids to rely on a script from outside of the bitbake repo or an 
environment variable.

Cheers,
Quentin

