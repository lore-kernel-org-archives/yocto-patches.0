Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35463C27C79
	for <webhook@archiver.kernel.org>; Wed, 19 Jun 2024 14:00:54 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.95])
 by mx.groups.io with SMTP id smtpd.web10.21898.1718805651010651726
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Jun 2024 07:00:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=PRGDEfZi;
 spf=pass (domain: cherry.de, ip: 40.107.20.95, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCmFxMHBbZ8MatRHhfjVtQU1jUtR6zEneiPiFqxouLMQAsQb2KlxyfDj+sikXNSexmUTJe2nTRgi0mquxP1wCkcz0AJj8ZsuDY9szMTyfXc1fpcfhuFWAfAHAua9Cl2qYO3L3UOLtQZjwv1DaQe5a57wOjxwHZCs9qA6QhkKkInDjqJ5guKHLpc+HeHtnhj7fCekuSM403O0L4mY8bUx7hzigYrMx6F9+eUD65HXO5mbBLiqj1iYz678g3qesWOpoEFtLTJYgsL5T1WktcPkWLM7Jh8zUDkV2fJmI7llvFnw+Rjk7MszOCShCDrwJ8OjAdKdo/jFISL9tvVZM4BGXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zkpuFytu98x8zjupo0L59d3oKWEunduPN8rfqN03HE=;
 b=imlaDIKv+qUHUskBArWGWHJ2iWcLSvu95EkN1rJUTxpejk0oiqk2fvLDX5fO0DeCsdY8pbgrByzJHsQAwvhzuZlp7hLIghfWozfPLe13ywT8BGNmGns/DRueXu6FEmFJzwx41t3+kVg69/jm9y7+nwop2MTTRqK95HYwybpf8DvS/Mk0kFessZBzW21fjxcw8C2FbE3nSfmphzSAvuQmO+6sIaJjuP0oqsqtbluhih2HScEVG8H7mWY0PRHoFLqVGqXL46cUIfnFrf3ELToSju/kjANgJJ88koSdBbNZxnUv0XBCKWQdWzqotRJZX0HUVDeBIhtjUX15CtHInWhopw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zkpuFytu98x8zjupo0L59d3oKWEunduPN8rfqN03HE=;
 b=PRGDEfZiVP9aL3Ko1X1ZeiFekAHMZDv3z/nrJ/YlZobOIzNg6NkeZvZBbhywvouQSRx+H28eOZnSRZC/GvyTZigHSmROT5aFu57it1OY2q1YSBlx/4DE6fNfc+VTJ/naVWVn+T+q4UxHpgw5QXXllQgpZBLi4UHnKW9rSgv9Gn4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by VI2PR04MB10642.eurprd04.prod.outlook.com (2603:10a6:800:27f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 14:00:45 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 14:00:45 +0000
Message-ID: <c105533c-82ea-42d0-9291-ae6e43c4fdb7@cherry.de>
Date: Wed, 19 Jun 2024 16:00:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2] rauc demo: add
To: yocto-patches@lists.yoctoproject.org
References: <20240619040722.6225-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240619040722.6225-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0010.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::16) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|VI2PR04MB10642:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d896a24-8fc8-4d58-1e41-08dc9068371f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aml0TEd2VWpFeVBSNU5FenhzK1gySU5YdHZYZ3g0QUZ0eEl3ajZwU3VaVTJp?=
 =?utf-8?B?Q3Z1QXR4a0NQME9ucmFna0FQMHExZkt6VElmdWdGUHBBaDl4RElmMnJiOXU0?=
 =?utf-8?B?YnJqUk9LUGo5dXJBTHNyVXNrbGNZY094REtZUVBOazBQSyttSEFPcFZWK21N?=
 =?utf-8?B?UzJWczgwWG5PMGdTZkV0RktRR1QxeHhQcTZaZmI2djNKNUduVWYra1BQdzBF?=
 =?utf-8?B?cGFDZ2JLcVRvWHJTMWxUc0tiWW5Hb2lHNUo5VHN3NWpZSXNxd0FCUUFWb2ZX?=
 =?utf-8?B?WUFZdjc0b2tRamFwaVBMWDFvNUlUVkkyRERzNWM2Q2Vta0F1b1R2NWZVNXJV?=
 =?utf-8?B?TE8wUmxlbHAyMThaNjgrNERvWklLaEw0MEpTa2VWRlJVTjg4Z0huZG50N1Z0?=
 =?utf-8?B?cWFJZHRFOWlkZGVBV2hEd3BGSlc0UFNDc3dKKzlJcWJnSWcyOW1GbjRJWlBi?=
 =?utf-8?B?MlM1N0k2UExHeHV1SXhVUUt2RHl6R3kvTHJ1bXNJRUdkUFQ0Y0ZuVjdWS043?=
 =?utf-8?B?eXlMZzJLeEtUdTVCUXZxMS9kUkRQbFU0ZFdVNUJjMVgwSDF0LzBHMzNsK25K?=
 =?utf-8?B?L2NHUlcydTNFTE0xTU1zR1MvaEhtdHV4MFBRTXBOdy9mdUNvMnBzVlhmQ2pl?=
 =?utf-8?B?dkYrTmpHalJDeUhwVEhyN2t6NzA5NEpKczV4UmVKZFd3MFR1dGZQM0lsTE5q?=
 =?utf-8?B?RWRPcHhheElaN1NDZi9QalVHSFQzckpQVm1LSTlNZ1hrNjczemZMZlZ2WW5O?=
 =?utf-8?B?c0NUTFN0b3JGSkM4ZWkrM1haMCt2a0orSUU3YUQ3SGMxSEFCZGIxVzA1OGxw?=
 =?utf-8?B?Ym5nalk3aG1qVHl2N3FqaDJCU2srN1U5eDJla1dOVGZLZEJ6dzVmV1hHTy91?=
 =?utf-8?B?SVFQQnplVG5QMUh5dHhxVGdzZ2RabjRmMFdlMUUzWEg1MHd5cU1BQ2wwVHRv?=
 =?utf-8?B?M1dHUGlpU3BQeTljVXZSSmRoVDBUV0k0QjZHWlRIVUs5WlY3b3FaNVR4UGlE?=
 =?utf-8?B?UU1xWkpIekJnL1RZdFQ4TktzT3BKRXFadWhRc0JwWnRwQTN3K3E5Zml0SUc1?=
 =?utf-8?B?bElyVmxuTXJnSkJBeWx6Uk5yVTB1Z2JMNXF6QWNZL2NJdXJyNmhjYkw2dExW?=
 =?utf-8?B?TkY1UGxTQUp3OElPUmVXTUd6NS9CeUs4QURuTkRLM2hlalBRclVzWndZYXpz?=
 =?utf-8?B?S1lFZWV4VFNZMDU3ckRLaFpHSmwvdWdUYmhqS01JTy9PclB5eXIrbjhNZWtk?=
 =?utf-8?B?dVFTdWtLQm0reHFGNmVzZTZQYlZyNngzbU91VnpXS2RPejhkbnZuMER0aUpD?=
 =?utf-8?B?anZSWjdrKzVwYnI5UDZoRGU0WVlyMkpEZnlKajd0YzVqUE15aXZPL3VUWUZM?=
 =?utf-8?B?Y1JiV3FnRG53WW01OS9TcEhoWmYvTmRtem9oNjhzR2o4TWhkd3F3UnZkRnRP?=
 =?utf-8?B?TWdoMVlGZW9YcHFqTzAzbEdxK0M1YlljZi9uVm0wdHU1bkl2Y1pGRHNCaHh0?=
 =?utf-8?B?V1pobVZYVjl3eVV1eHNwZ0ZyUXRwdHVVc2RpTWhQRVc5U3B5d1NrdEYzcmRC?=
 =?utf-8?B?RGdremFjZnJtMXlTb3pkaDhOZ1lRWkxLZ2h2ZXJ2Q0pZZHpTMlBQS3RVTVpJ?=
 =?utf-8?B?QzZlOHdsNlh6d3ZFd0haVkpEWTJCMGZQeEtxYkpqMUZBWEFIYWlKdCtGdndp?=
 =?utf-8?B?dFVycjRvQjVKL3V1RWh4dzJSajBQWVhBNDl6SkpjR2x3RndKNzU5eTZDMDlZ?=
 =?utf-8?Q?rKwvWXi+XkZ44soC1XZIKx2aHcKR1q5KQTSaf/k?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Vlh6cWJUaW1rN2NqclFvbkZvMG1FOFVDUDhXWjN3UmV4aHgzaStVcCtCWk1u?=
 =?utf-8?B?Y2JlMXFvK2ZBTjJyai9KK1ErSlhES0lKR3dlcW9acFRpcFR6NTQ5SEh2c3Fo?=
 =?utf-8?B?OGhQc1NmYk5RQXlENTRBeUttcU5kK3Axa3cvR3c4NFdQZUJNRTdVQVBYKzAz?=
 =?utf-8?B?S3hOcUJJNm5vaVE4b2tvRStvL0pDcUtpNHFHSHhKOFdxSlhTZ2hYdjh4U3R6?=
 =?utf-8?B?Z2RJQUJvV2o1SkFHOWhnUUhxWUpVdi9hNHdBVlVWQ0J6MnowTFlvM1RZM3p2?=
 =?utf-8?B?QkF1eEdBUkhtL0MyVU96dFVVWTlLQkJraUhtaXZUUEk2NFQ0a0lTNG9yUStP?=
 =?utf-8?B?Z05XQzlGUnlIUUxDZkxSajkzOVZOMVFSZkt1WG9ZYUtoQVNjWVJzV3RuL3Np?=
 =?utf-8?B?OXdBTGtwSGFPdENGREZ1azI2TS9jYXUxZVI3VVM0UVZ6NUprNTgzR05lb3JI?=
 =?utf-8?B?TGlXbThyTmxlZ2VYRGFjMHhYRk5YTjdYRHc0bzZ2aVhQSUlzTUJkYU1BYS9k?=
 =?utf-8?B?ZjNPaGJvZHJhZ1dGMDdVb2dWSkxOQjJXSFZpcmJ2SG80emhVa2dYREtkRUg5?=
 =?utf-8?B?d0FqSWNTRXdhQWN4OVRCTlVtZVdsNm4vZDEvdlBNYUxFZEVuSkRrRENzcEFi?=
 =?utf-8?B?TmZuUHFIaEJDVFZrdTZyV3lldG9yQ25JbzgzdHArak9EV1J2L0NJNkI3WW40?=
 =?utf-8?B?VUlXMWoyN3Zyb24zZzNwOWdsRlA0c1pVcXB1Z3cxdHhlcDhtOFRRcDhrNVVk?=
 =?utf-8?B?cTFDUXpiV28wRzk4dWdTZjIrekU1NFBpKy9JeUk1eWxKOWFCNjR6QlJrN1dC?=
 =?utf-8?B?WTkxWlNERWJ4am1ERmtuNWtWbFNyNlN2dlF1RmFoSDk2UDhTZW1CUjdteUNC?=
 =?utf-8?B?dXpyZHMydnVjRk1OVmo1b0hWNFhrTHF2ZVlxeTBoWUk2aU9mTThnSU1VNnow?=
 =?utf-8?B?ZGU4M0hoaUpDNit6dzRiZTFaR1dkcG5mMFl6SUlNMnEyenBVZmREdWdvejdJ?=
 =?utf-8?B?VllIY1hBUUpPNG5DZU5JeWVjM3o0cU9BN1YvOEN3M200SDNyaGpzZVNaZGEw?=
 =?utf-8?B?Snc1My90VERSc0lRQmg2QTVMUzVtdmJ3c28rU2FWNStPNzBubEZwOFFKVTJ4?=
 =?utf-8?B?Yyt1MWRDZ0l6eC9UNTNxRGFIa243WCt2T0g1Vi9OY0NLZ21rbElyTlBtd2F3?=
 =?utf-8?B?RlVWb2tqejRXLzVjcTJzQi84eHpWbEs3dEgzNFZUOFBKcjVLdkxNRHRkWVRF?=
 =?utf-8?B?YmVDbmFpTE1ZWi9zajMzU1JNVnVxUEhsQXNBR1dGREx3WkpaQ1gxL2VWYlZs?=
 =?utf-8?B?bnphSFQxZkhuY1gzTzhGdHc2VllQLy9LSWRuVkJkTDZjS1dxUUlwbUYwNkJa?=
 =?utf-8?B?NWcwbUZrOGN5UjJ1cVFJREp5cXFGSmRZMDFMTks3aDBESm5TOE14alJEdEJ6?=
 =?utf-8?B?azBaNnpjSTM1ZG1LbWxIeTdtaUthTXM2OG01YUg0aEs2SndsOTVXRytEV0t1?=
 =?utf-8?B?WkFDZ3pDMzg5dUIvSkhRdHo5YlBnY3huMUhwT3hlNnY2MSt6YUdwS3VRa2s4?=
 =?utf-8?B?Y3pUZFo2QWQ1dkxuSUJ3ZHJZWEhFMGZ4ZkdySUx0dFBWaTRrNm1ub1QvUUFh?=
 =?utf-8?B?eWpidTdObXRkT1VJMjJFYzRaZFlvVmoyaWZmdE5qMlRWUG5tSkRob25JRXBr?=
 =?utf-8?B?VjkwRDFYaEFkSjltSXJTTE1BaG8vb0JjM1Q1MzdkOGdPZEpqR3JTNGY1d2Vt?=
 =?utf-8?B?NVY3T2F3V2FVbGh2S1BFanhMSUdrZmYyVEVGajdvUlU3T1VFTXpUV2xFTFM5?=
 =?utf-8?B?TWhSZ3ZKQzZJaW12Nk9WQnVPVXZUSHhEaXBzNlowc29qeXpSVUYyZWVGejhW?=
 =?utf-8?B?T1ZCSVB0Tk03QlkwNVpHQmc0L2NENllheTZCL3QzOTJVczVSNmxZS2Fudmt2?=
 =?utf-8?B?ZTQ0R2xkOEpBVFkrVEJmZXZ5aE4yTXMydDBEV3ZRcUt0R1NHQktQN0VlYTB3?=
 =?utf-8?B?NFNUbExFbUtoakQ5MkJsdElSaWdXbG1sQmlLVEtmd1Q0c0ZudTdyYzdaelZv?=
 =?utf-8?B?a2FtVU42cU1OTGFCWURxbFhaOGYrN3pwRDMvUm1iVUN1Q1BjODFWUVhHbkVJ?=
 =?utf-8?B?MTFXVm5ydXlyWTJuYll0SjRacUVpUE5mOXlNNFlmRUdOVTJBVWgzSnhJQ2F1?=
 =?utf-8?Q?4iEfqakeErQ4m7tzypnNymI=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d896a24-8fc8-4d58-1e41-08dc9068371f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 14:00:45.6830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDk5VLUQAYkolnbUFn63R8uAoZUWL96DwmUVgkzrL3wyHuKaU2AqXTtGiEKHpQarHKATU2hjKPWTcBQjV7YtXnOslqBecAcqSTrPrZI8RRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10642
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Jun 2024 14:00:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/355

Hi Trevor,

On 6/19/24 6:07 AM, Trevor Woerner via lists.yoctoproject.org wrote:
[...]
> diff --git a/classes-recipe/rk-rauc-demo-features-check.bbclass b/classes-recipe/rk-rauc-demo-features-check.bbclass
> new file mode 100644
> index 000000000000..25e105b53d09
> --- /dev/null
> +++ b/classes-recipe/rk-rauc-demo-features-check.bbclass
> @@ -0,0 +1,8 @@
> +inherit features_check
> +
> +REQUIRED_DISTRO_FEATURES += "systemd rauc"
> +REQUIRED_MACHINE_FEATURES += "rk-u-boot-env"
> +

This isn't correct. If you inherit this class in any recipe, it'll now 
depend on systemd, rauc and rk-u-boot-env even if RK_RAUC_DEMO isn't set.

Two options here:

"""
REQUIRED_DISTRO_FEATURES:append:rk-rauc-demo = " systemd rauc"
REQUIRED_MACHINE_FEATURES:append:rk-rauc-demo = " rk-u-boot-env"
"""

or in each recipe

"""
inherit_defer ${'rk-rauc-demo-features-check' if 
bb.utils.to_boolean(d.getVar('RK_RAUC_DEMO'), False) else ''}
"""

Not tested.

> +# 'RK_RAUC_DEMO' indicates the user wants to use the
> +# rauc demo configuration from this layer
> +OVERRIDES .= "${@ ':rk-rauc-demo' if bb.utils.to_boolean(d.getVar('RK_RAUC_DEMO'), False) else ''}"

I don't understand why this override is in this class. OVERRIDES are 
generally set in conf files. Is there a usecase for which we want one 
recipe to have RK_RAUC_DEMO set and not another? Because that's the only 
scenario I could think of that would justify having an OVERRIDES set in 
a recipe class.

[...]
> diff --git a/dynamic-layers/rk-rauc-demo/recipes-bsp/u-boot/u-boot_%.bbappend b/dynamic-layers/rk-rauc-demo/recipes-bsp/u-boot/u-boot_%.bbappend
> new file mode 100644
> index 000000000000..433ddf65d2d7
> --- /dev/null
> +++ b/dynamic-layers/rk-rauc-demo/recipes-bsp/u-boot/u-boot_%.bbappend
> @@ -0,0 +1,27 @@
> +inherit rk-rauc-demo-override

Why this override in a recipe? If a conf file sets RK_RAUC_DEMO then the 
OVERRIDES would be set on all metadata if the machine conf file inherit 
rk-rauc-demo-override?

This feedback applies to all recipes/bbappends in this patch.
[...]

> diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/systemd/abd-partition.bb b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/abd-partition.bb
> new file mode 100644
> index 000000000000..663260315cc5
> --- /dev/null
> +++ b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/abd-partition.bb
> @@ -0,0 +1,25 @@
> +SUMMARY = "A/B+D partition definition for systemd's repart mechanism"
> +LICENSE = "OSL-3.0"
> +LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/OSL-3.0;md5=438ec6d864bbb958a49df939a56511cf"
> +
> +inherit rk-rauc-demo-override
> +inherit rk-rauc-demo-features-check
> +
> +FILESEXTRAPATHS:prepend:rk-rauc-demo := "${THISDIR}/files:"
> +

This is already in FILESPATH considering this is a recipe, so it's 
redundant and can be removed.

> +S = "${UNPACKDIR}"
> +
> +SRC_URI:append:rk-rauc-demo = " \
> +	file://25-rootfsA.conf \
> +	file://35-rootfsB.conf \
> +	file://45-data.conf \
> +	"
> +
> +do_install:append:rk-rauc-demo() {
> +	install -d ${D}${sysconfdir}/repart.d/
> +	install -m 0644 ${UNPACKDIR}/25-rootfsA.conf ${D}${sysconfdir}/repart.d/
> +	install -m 0644 ${UNPACKDIR}/35-rootfsB.conf ${D}${sysconfdir}/repart.d/
> +	install -m 0644 ${UNPACKDIR}/45-data.conf ${D}${sysconfdir}/repart.d/
> +}
> +
> +FILES:${PN}:append:rk-rauc-demo = " ${sysconfdir}/repart.d/"

If I'm not mistaken, this should be unnecessary since

meta/conf/bitbake.conf has:
FILES:${PN} = "
[...]
${sysconfdir}"
?

Doesn't hurt in any case.

For the whole recipe, I'm not sure we need to use rk-rauc-demo override?

Cheers,
Quentin

