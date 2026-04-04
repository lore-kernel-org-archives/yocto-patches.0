Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329E3D73094
	for <webhook@archiver.kernel.org>; Sat,  4 Apr 2026 15:06:58 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com (BN8PR05CU002.outbound.protection.outlook.com [52.101.57.9])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18030.1775315217027316865
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 04 Apr 2026 08:06:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amd.com header.s=selector1 header.b=jf2jTg1L;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.57.9, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GO8h0nUEn3nAXO4uYfp53tL5p2iW7Yoj4ZUsZ9YrL5FQKn44w4PbIOnul8uza1XHet74p5cTM1G0a3b9U+Xlfc6FAH3uIYQxKZtIBVWXy7wiBa/BoKDZ0ZKkRyhuAJuzOVg/Fx271Lfzxra8spGdw0F2+s4YTD5pLeLJe6X9VAQdHc4aeXXFAPEWaxlA7ASTk/VL6FOwbjp1t/EB+0+qU1ZhK33/+oP07U7WTg1mFvcpKpnWVLBvIAWvTiOgYtN7l4UTVKUpSdzlwF1yGkxnnbLEBhD74CyPARmCLOa7nv8rYOv8D37ajuolkcdR6bInJv5jlpdgBTI1h/uPigqqYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPVIcpm1kSsUhfb8ZtWR/LMha3mRFFqnx9NDRUW5VjI=;
 b=nCwBM1h4bkEgcMaeprTHn4Fb0/BgwKRJ0hi4K/TjR5xcDJpK9b3osxp5ADFmb8DZC9leqcVUaZ2T6vtBgIESQovFEWjaLFSmWx4WomVnxJpK9NNJfxohMCZiCyostnWfnQbrFj5qBTgf/QzOibVVNzCqhNcxrus5JD5kLuIjpkhV11EaepFVVNslEdhuTHHv3UV/srbAksjL7Y281NRM7FFwuc3aHmwL3NVz44+RcQQbaufUSnEExlVe+LpqaljMO5jmO72/ImubKlMAX3gOiOwG9E3wayTqIp5ey3+DmbpZrKSpivd3nmHn4Nu8PVztX4LY+O+qpAJP38xdDDHRQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPVIcpm1kSsUhfb8ZtWR/LMha3mRFFqnx9NDRUW5VjI=;
 b=jf2jTg1L+kdvPvK/aw9Ur5uI337nBFt62EDG/GbVANKaz5DP/7/Vu5AJw4cT2epzTrTI+Yzv6fyn+RSWV22HIu7OicQF9w1/EMaw3+3m+FiIo3whqW6MxOaLCusZTRDCRmYLR4JlB3u/NbwMBY+E+ibFHSDUmuWKL6wW+oV5Qgk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB9007.namprd12.prod.outlook.com (2603:10b6:a03:541::18)
 by DM3PR12MB9415.namprd12.prod.outlook.com (2603:10b6:8:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Sat, 4 Apr
 2026 15:06:54 +0000
Received: from SJ2PR12MB9007.namprd12.prod.outlook.com
 ([fe80::85bb:7053:2b4b:263f]) by SJ2PR12MB9007.namprd12.prod.outlook.com
 ([fe80::85bb:7053:2b4b:263f%3]) with mapi id 15.20.9769.006; Sat, 4 Apr 2026
 15:06:54 +0000
Message-ID: <255de439-49a9-4d39-bb07-9b00af016412@amd.com>
Date: Sat, 4 Apr 2026 09:06:52 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [layerindex-web][PATCH 0/4] Add app dir support
To: yocto-patches@lists.yoctoproject.org
Cc: tim.orling@konsulko.com, mark.hatle@kernel.crashing.org
References: <20260402195112.1369295-1-sandeep.gundlupet-raju@amd.com>
Content-Language: en-US
From: "Gundlupet Raju, Sandeep" <sandeep.gundlupet-raju@amd.com>
In-Reply-To: <20260402195112.1369295-1-sandeep.gundlupet-raju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0259.namprd03.prod.outlook.com
 (2603:10b6:610:e5::24) To SJ2PR12MB9007.namprd12.prod.outlook.com
 (2603:10b6:a03:541::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9007:EE_|DM3PR12MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: 36d7ab1e-ed47-41cb-7ebd-08de925bcea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	JEVqnH6bn5xAlkNVzMCslzjZclxxYhXri+LUIuJspxU572YGHySR3aKObEf7foAwvZeqh85mf+GYVuqq0TEaVyujQcDRmpxG4y5DRhK9Q17WdWWjfhrZie5o3cyYLIoUgCGYVDxs2Cv8LQQZvtV1a47QXWixDIQe6WSjDCgFyFd/1j67qUcUj2BsrxmwKSZOP66DOdmGXELm9OrmGaCLhoLE7HHFXB2jW1GE7/ya8Sa8ewfH58gy233aEtQwMXq9bhboMb5cGws/SSKXYb1xhkOxrVAKY6ZT6hrhnu7RFFDknGY6HjZgB7KhIPKgtopvDf9yCFFKpbjyImn0nunCdNzf5TYeCEMYyVW16f9WOBWpaSarI7pRbXFq2x5wqnmojYjYS6ThVWXIKvV+h7qZbdhapUco996l7SwsTOgckyb5cOx4CyI4eOeWHFO4HQW/mSweubtuJv49+Ag0B3ZHekjUD1kPQ/i83vz/6TMgZJqoPlvwnkT+RAhHMEZjrvAM06uvzV1mzr935Ug4DT5j1QXE9s9FchIGsAuUdPtZrIVws8DoBMcoDjXbUDoZh9oTRS941B3PAO+LH/RvG3R2b9onGAJyLquvoxevy1UoyFDlK10d1YAzQIl+QiM2BwkJmQEzwlXvbsqQTGlwEdTaEtWEZb56TBDzj+zLNETYeQhTOdaCDANaEWcAEexO4QQRy/u2coEpOcva2RaSRQRPgL0V8meHKNoxECXzpx6TgBU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9007.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VndYTGhoSnE4ZFQzMTIyTncyVVZCOS9MZ0pQd0NOdFlKTVZXSy9DMGwzVjRH?=
 =?utf-8?B?UU4vUXhqejdEODNkQ1RRUmFVQ2Y1eFM5RTF5QTlMd2t0R0ZYZ1lxVVhhOHo4?=
 =?utf-8?B?UVdNTmdBKzJIZGd2YmR6bUl6R3BBcG56NG5JTklKUjJ3VXRtQXRndDlueFp6?=
 =?utf-8?B?WU43L1hQbE00Z1VNZklQYjBKdm9HS1dxOWhQVHcxY25PSzFIeVNEYmlkZHR2?=
 =?utf-8?B?UXYxd2xKRUlGQStVb2hjY3Y3aVVxOUxVUXZYdElYUWk4RU9WTHd3ZERZdHpX?=
 =?utf-8?B?UFVqVDVhQk1LUkNtaFdzaGFRZlAwT3dtSHpGNG5GVGpHUlMzT2lkMDlkVkJB?=
 =?utf-8?B?YUJObEw1K1lrenYvVnI4MmlETkFWSFVzQjc1dGZNUXJvMGw0LzJpTTh3UFN2?=
 =?utf-8?B?dXpmT05UZDRYMFdOZ3kwQVg0RUxFQjVnR2srYXVaamNaQzBVSEw0dlRjMEc4?=
 =?utf-8?B?QThBeDhjSEcyYUU4STVXZTExV2JiOEdGTmtSQ1IrS2Y5eHUxYjRJeXI5SjBN?=
 =?utf-8?B?SjlQcXE3eDFRMWxpbHU2WWdLOVNnbHIwV0VYcHBiL3JMUWs0RkxlMjNKUll3?=
 =?utf-8?B?WTdsWm9WREtnblBuSVNlb2I1Q2E4UUNBb3A2eXp3MmVHSjZWZVg4dm5mQTFt?=
 =?utf-8?B?KzZzajNsSktsQjM1VVlrZlVxZHJYSHdERXZkU1h4SmsxNmdGbTJQWmlDb2pU?=
 =?utf-8?B?WWZ0TWh3Yk9VeUlFZzErbUNLb3JBZVFtVkQwVzFHWnpZNytBZVpMbnBGaUJH?=
 =?utf-8?B?R1YrOFkyWUZ6V2JqMHVkNmgxaGFWaUxxdzVXRmJoS01GRTRFK2E3OHIybDJy?=
 =?utf-8?B?Q3h4MWVtLzlnL2VnNHdlYUtZTzFrR2prRGgxOXlOUWowYmtEUU5LNlpsTUkr?=
 =?utf-8?B?K1Zzd2FEMWYyTjdLbDI5bFk3ck5zMk9iNTRVK1diT3VVMmRjSkd6bWVESWph?=
 =?utf-8?B?a0VKTHdIQWZFTkJZd1dheGY3b0hrZ1RUTWZQUGowYXpoY2xHRlJsdGppNkVm?=
 =?utf-8?B?N0xlaEFVVjgvcGFKZFhMaE1YT2p5SG03WTQ0c3FIZGMwVWQ5SkpvSkkyS1dL?=
 =?utf-8?B?ejYwRUpXRGlVVUNyT3FCcG8xVUlta2RHZm9NazRxQzJSdXRwdFR5NW1RSmtn?=
 =?utf-8?B?eVBYTjVwalcxL0llV3g4RjdZMGpaQzhhdEFNdmpzRE55U0pGc1pmclQwNmN1?=
 =?utf-8?B?QjJMejcybWVlWTNKNTloYVVvbU4zcUljems0Vnd0N1pyWkE2ejg5em1ZcUF6?=
 =?utf-8?B?bW9TcTNFN2hPSldjMWwvbVZrMzJmMUY3QzYzeHRvM2RxTjY2ZG1vZHFUWGwv?=
 =?utf-8?B?UGk0b2V3WGtWY1FudkNQd1NPWFJlQldNa1hiRlNsR2Q2V0M2UWRmb2ZjSjRV?=
 =?utf-8?B?MkpBMkdPSmtUeEVYZzBWV1p6d1dvUFB1QnJSQUhHaGNsNmN4WkJmQVFhUHlw?=
 =?utf-8?B?VnIzb1RYMWMyQWUrNkx4cm5WZXhhNk1rRXBuKzBlMDdXSTM3aEdjTGF3TGxX?=
 =?utf-8?B?Nlc3R1ZoUlFDV08rK3NGQnFVYjVxYlBUUmY3VlVQcVlmekUybEpva056Q0Nu?=
 =?utf-8?B?VmxKUWJ1RTZVMGM5YkIyY2g0WE4yUjB6ZFp5SDRYdExsYm5SVk9rRXZ3UVFq?=
 =?utf-8?B?NElFemVkM0RoSUtEa0YzakRnMEFIZUxGT3o0Mmd6dEVCaTNjTVpqQXEzdmQ1?=
 =?utf-8?B?YjA5TnJOK2VaRFI1V0Y0ZXRBR01xV1BkUkhVc2dqeFNEZ3IybDZyeVhhRGdo?=
 =?utf-8?B?Rnhaa2t1ZXQxV09PalcvSytrWmViMnJnWm5OVWZNRHN6SmQ5VW5lYkpNTm12?=
 =?utf-8?B?RXg2Nkd1OXRKRXgxYk4rc2c4dWhxSmRPcDJzUlgvV0t4YzFYaWxCTzFQOWoz?=
 =?utf-8?B?UnF2ZFEyUWV0TEdMck9nTGthcXFNNTg4ZjJTSmh2QUV1MTFwT0FhNmk4UWlv?=
 =?utf-8?B?TU53VEJUcU5WeGVpYnpaR0pHSm52RG5PdlJTdHRybGU0Z2dWZEp1VzlpMk8z?=
 =?utf-8?B?TUhqQWdZMnRRU0k3RGxTYWpXRGlGQXo0elhLQ3NPczl5OEVaMVdwNHZyWE92?=
 =?utf-8?B?Qkx1VWZTeDFScnZMOEgxYk82YU1TZWxKYnd0b2E0NkUvZ3FTcHQ3YVVpdmZx?=
 =?utf-8?B?SVBGU0VXYzhWR1ZiS2FLd0lBUFg4N0xwYkk5SjdUbzhJVGFMWURMNkZTbFNk?=
 =?utf-8?B?ZlZzeEZjVjltUnRVVjk1VUJBd1R4L3FUY24xOWVmWTdwanVGdXRJK3drQ3pt?=
 =?utf-8?B?UzV4Um5oc3RrdTFHTURZZWh2N1VZMk5XUkZyS3VqQXB2VXl6VWhtRkZvOGsv?=
 =?utf-8?B?WmNONVJBeGJoMGJjMktuN3BBOHhydE5zUHNQY3BNd2xNTGNnSTdrUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d7ab1e-ed47-41cb-7ebd-08de925bcea1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2026 15:06:54.1031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sEj7qhipP0S1DaAPTLWAg6Wq8CtJgsO69u2ybsLK+Np2pQMcRIiiBmdU0EZHimCMIZl1kRDrozq+v/yxecFT5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9415
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 04 Apr 2026 15:06:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3640

I found one more bug I will send v2 patch.

Thanks,
Sandeep

On 4/2/2026 1:51 PM, Sandeep Gundlupet Raju via lists.yoctoproject.org 
wrote:
> Description of change:
> 1. Add app dir support for configurable container as default
>     installed directory is /opt.
> 2. Use yoctoproject.org for HTTPS check google.com may be blocked or
>     considered unsafe on some Linux host environments, while
>     yoctoproject.org is a more appropriate and reliable choice for a
>     Yocto/OE layer index deployment.
> 3. Replace deprecated libmariadb-* package in README.devel.
> 4. Document --app-dir option usage with dockersetup script.
>
> Sandeep Gundlupet Raju (4):
>    layerindex: Add app dir support for configurable container
>    connectivity_check.sh: Use yoctoproject.org for HTTPS check
>    README.devel: Replace deprecated libmariadb package
>    README: Document --app-dir option usage
>
>   Dockerfile                   | 24 ++++++-----
>   README                       | 39 ++++++++++++++----
>   README.devel                 |  2 +-
>   docker/connectivity_check.sh |  2 +-
>   docker/migrate.sh            |  2 +-
>   docker/refreshlayers.sh      |  2 +-
>   docker/updatelayers.sh       |  2 +-
>   dockersetup.py               | 79 +++++++++++++++++++++++++++++-------
>   8 files changed, 113 insertions(+), 39 deletions(-)
>

