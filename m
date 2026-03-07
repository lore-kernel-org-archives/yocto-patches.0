Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D75FC9ECF
	for <webhook@archiver.kernel.org>; Sat,  7 Mar 2026 04:48:00 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com (SA9PR02CU001.outbound.protection.outlook.com [40.93.196.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3346.1772858874378399518
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 06 Mar 2026 20:47:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amd.com header.s=selector1 header.b=i9EsdoyX;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.93.196.41, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSInn0O/HM1+uEucxS1E+wGNE4kcXW9ciQc+oJKE0ZP13E2RcxMVHWWTw53wu1I8CdZpSF+xd4VR80r9uDZHheRoWR1qQwAZQjkls+JQjM6m5GsPnqdTNNcs7RspBybpQZF75jE1qVNRtZytlrr9xtoCGEp6nTn6qLFgVptn2IDG2bBxi45cLze7a5nZZd+yxdO73V80sNAAXTBYBMZ4pAPx5bZC2Lqp5VlAF0Tf/WsSQ4RlGz+trLZLkJzrEix+kVJPLGjEhiQ04wSiRfHB0H00TQGUcIYnLsbnRSsFZjbnNcxLAHH6+2m+0Bu3w+48IJL6gAvOeh2+9jc8F88NPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTvZSB2Eoy3YV8oTfB8PgiB9n62j6AGOMgexzWCY74s=;
 b=Ra8RK17tyLSs1IgJd9UDw4304hhlMAjlILFZXodg+OFCKxpy/eb+zyTLPZA2SJ8ljGZpQJxeJmzRGiH7qj2SKOeGGbW6+Aaon+r1mUsP5G1xaOVQFZFBQGcwj5k09eLqc7dvH5pZ6Blgl3q9guBA6Pwjh+eSbxCfgEXa5dl1DTo2PGEuqYeZPxd5Ilp9LlVLpYPoo8RqWF4Wp2F06FM384UWzR1UHgw7S2XvrPHEyRqDhIC38KpOAH64vMP0UDNIa5KvI283YrhFC8+EGwBNo5sn5BHNbrn+aoiAk/T+S2SVyRzaHmy/a1MbVLHpV7px7HjQFSsUQx/brzsncunGTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTvZSB2Eoy3YV8oTfB8PgiB9n62j6AGOMgexzWCY74s=;
 b=i9EsdoyXqo95crYUzNglc61ZDZn2MOMpvW4CiiP1Fa4XWMKTKe6xPt2ekBR5SGW+ENLyIIYt6JEjeggrKApJRC8yslm5VTJ1QCWu6wAzx8w3SVpiNIXCUvJec2XtH2zNyTDed00N/S5pvxMzjQ7viXMLYhSoKhkUdfyrYEjb144=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB9004.namprd12.prod.outlook.com (2603:10b6:806:388::7)
 by SA5PPFF3CB57EDE.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8eb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Sat, 7 Mar
 2026 04:47:52 +0000
Received: from SA1PR12MB9004.namprd12.prod.outlook.com
 ([fe80::b08b:7d29:b1b2:1cc]) by SA1PR12MB9004.namprd12.prod.outlook.com
 ([fe80::b08b:7d29:b1b2:1cc%6]) with mapi id 15.20.9700.003; Sat, 7 Mar 2026
 04:47:51 +0000
Content-Type: multipart/alternative;
 boundary="------------XahVo0Qi0r1qgQvPRVXYG39h"
Message-ID: <e12d14ed-376d-4790-959f-6d5f6f9d6782@amd.com>
Date: Fri, 6 Mar 2026 21:47:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches][meta-zephyr][master][PATCH 0/9] Update to v4.3.0
To: yocto-patches@lists.yoctoproject.org
Cc: chee.yang.lee@intel.com
References: <20260307044353.1936182-1-sandeep.gundlupet-raju@amd.com>
Content-Language: en-US
From: "Gundlupet Raju, Sandeep" <sandeep.gundlupet-raju@amd.com>
In-Reply-To: <20260307044353.1936182-1-sandeep.gundlupet-raju@amd.com>
X-ClientProxiedBy: CH2PR18CA0007.namprd18.prod.outlook.com
 (2603:10b6:610:4f::17) To SA1PR12MB9004.namprd12.prod.outlook.com
 (2603:10b6:806:388::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB9004:EE_|SA5PPFF3CB57EDE:EE_
X-MS-Office365-Filtering-Correlation-Id: b7c85a1f-74f7-4f71-836f-08de7c04b091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: 
	Rkr9S0ldpYKhs2Ss0sg9NhRC3SQXJVj6Q4vsWTpx4AG4SQRQpFRR4GPo1WOt2W3cLnShRuPiF+m2HPhN+/aqr5iQ3PxQv/N8Ow9kt9ZF/z9zEvGM9dbvKartViSvZjfR4644K5E3Piw/PLxUqMybg0pZY00LBPFCA6VDdKl5Lc7uBh4msvyzfx4JjX93tQOLeUFle3/bBvkemHqwkmF4/xpsB6xd0A7EfZoD7BT0G+RVW42iHdKj3zR4Q8zYB2LOWFTrpfrKqebtmb1FGhLR2whKhzC1WxYUgFCqOsG6La4R8G3n+bdTNy1IizxVBkU/119KFZop00ba3pYNTmqO1Q0qxgDQwP5tuhtQcutxc5FCtR+7rUmJIapWhdaoQx/blZdteWSK1c1q+qjSHh2oNRrvISe12TxhaXh6WbX8gKDDTwJh60Q55zSVOGx5e8l/8+NwB6av9JYmoqcTrsWX5KIerSPGLzuqpMs5ptRlb0miY9yyyWLAiSrJ0+sAkpOOKO1R1T3J6QW3QAW7HC9F1BBykoue56Eg6RWnNtEPbFES9ePT25mBJobE1iEtrpEfHC6z4HvoQEo/zZGsp4uZE38xppPsb1+KpGU0kIv7vEJvbeZRCOtOHQrByxdpKpt7ugFKo9Jvvx2Fcc7mzHVtwaw6RfkGq6OOrKKHh/5TuTQW9MgNB3D+YeOH/sqpQAmKdwe/A8+laIiZ1RiN3O8bIhJPqbbyTsNfA86hEo4znhg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB9004.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(8096899003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SW9BMUFWR2xjc3pvQlBoNndBeDVmVm5WOHZQVVJjLzdhNk9pUVJQS3MzNlMw?=
 =?utf-8?B?YlhldGpId3REYkEwWTZ3dzFYUzZBbmprZ3REdnJ6VThHVktydW5abURvSXRu?=
 =?utf-8?B?MEFZRG5GMTdES3lpbDBBaHhvckc0OGJpZkNGejJGaU9Kb2Z2alR4S2dwRkdm?=
 =?utf-8?B?MjNsNkxudGtoWGRuL244VVVsRmYxNzYwODNieTVDeldVVzVMWVh2YWYzSDhI?=
 =?utf-8?B?VzdvU0VNMHhTTERLSzdrMjdOUEkvQ1VjOWxtKzBzME5ncFEzRW9zSDhiQnVr?=
 =?utf-8?B?aXJmQzVxVmh4Yk1KeHVRUENxbENuREtnMU9qTExBL1RCcjBRS2tEY2E4aisr?=
 =?utf-8?B?c2tGd3c2bU5FM2d4alQ0WHIvbDNGK2ExWFpsdXNWRGsyeW16dW8rSUhFSElF?=
 =?utf-8?B?TUQ3RlJ2dTJ2a3FTUWIzNjBGWEI4SW1icWo2VDNkTmQ2clp5S2cxMnBUcEdq?=
 =?utf-8?B?d1J0MDFOMFJreGErU2w0UzhFZXo4Y09aMGFKYTFaLzIydXpLOTVXYXdpTHVU?=
 =?utf-8?B?RjY0cnFOT1VjNkVLZldzMmhISE1vUE5qTFh1Ry9JY1hGSDFQWlU4MG03ODRE?=
 =?utf-8?B?cU96aDZ6NUlQcldCR3F3TFFRaU9qNkFwZlErWVZqYVNHSWk2YXRuUjNuRkZE?=
 =?utf-8?B?WTBJV1Bkbm12dVIyUTlKdG1BWUF3cnNUWGU3NmFyWjg4VnRJN2paOVRQNDNt?=
 =?utf-8?B?NUZHSXV6M0VyV1VTTjNMQkdvSm5yKzB5TUZ6Nnc2S2dtZnRaanc3OGl2YS93?=
 =?utf-8?B?WHFZT1AwRm1Cd1lzQ3RGWk5jTDBLeTZlOFRuVGJGcFcyZGxIQmtQTU5YTEpQ?=
 =?utf-8?B?SXVuOHdtVkNtRk13bENqWnRzTVlrcHpxK0pQd1VWYnJpaUI2SzNac3BIaE5E?=
 =?utf-8?B?UVJMUitXVFVYQ25PTVV4QThqUkh0Zk9xTWw2ZS83OXdiSDduNTJLdm1COCtx?=
 =?utf-8?B?NFQrVEJJVWJSL0ZYQS9FZjlzWVZWd1NpK3pjaGtlWFNXREhlejZkVzBscVla?=
 =?utf-8?B?ZUVYQ0J5TnplWDZ2YTUvME5uK0ViY2pJMHRnS29WQWN1cjUycldaTkVVL2FU?=
 =?utf-8?B?ZHZWeFNWMERKWVF0dnFqbU5Ha1pGT0tXYXZwSnprKzROVndaTW9mM21ST0NU?=
 =?utf-8?B?d2t1eGJvaTRqd3J0TFFsUW9nTCt4aUsxVTR4Q2VvQTU2VVBHNUNrdTBoUkR6?=
 =?utf-8?B?aFM5OFBla3ZyM0tabWozY1RMOFU5bnhCajk4cGtycHBqaC9ZMUtFUjk5R3dm?=
 =?utf-8?B?bmdFbU9hUkVTVlBzZThBTFZrSEF2MEJ1MERZOFRiZWZUTkdpOW9KTVFiMWlz?=
 =?utf-8?B?MVVqYXl3U2hKb0hCL3lYWTBOdkZHY1lQdjJlajgybmJkNEpzN1kzQW1McExo?=
 =?utf-8?B?Qk9pNGZxa3dldEFsZHlzVHlTbFYyWlJMOVNHVXZ3c0RWU1NwQjVaNHZxd3gy?=
 =?utf-8?B?VnFHQ0tscGJISUViL2NqcllTUUFYZ1VpT0hYYll6aGFlWHpsVFVrVkQwWHVR?=
 =?utf-8?B?SGVpRTlBSHhTeitkeGx3Y0Uzd2djYVNyaVpZNDVic2NidTdDOFdzdkcrejdN?=
 =?utf-8?B?a3JCckRPMVgvaWJ5YlVvUlhkRWt6VE5odVpIRWZxN1RZdHJFSkNHd2N1UHBB?=
 =?utf-8?B?SVE3OHN0ZjltMm00WE9vUHNtWStjUTF5b0ZvNTBMdFdvNFhHeFpoQlp4RytZ?=
 =?utf-8?B?V2toTnhha2tmMU9UTFNhZHBWcTkvb1AvZ3doUy9QL2ZDSldEUkMyY0Zsb0RG?=
 =?utf-8?B?R1BMNFg2d3BDZEFPS2tFWTNudDcwcXNQeTdpNE5DTWJ6YTQvS3B4bkpEeU9P?=
 =?utf-8?B?ZHZBUlFJVDB0QnpXWUErV0pjRU0wWUhBRG8vd1k3ejVaUExKYVV3RnpqWXJp?=
 =?utf-8?B?eEJybzB3MTZGbFhuZ0YwRTNuUXlOKzE1NnVwK2hleG9zTzBhem8vcEZzMUVk?=
 =?utf-8?B?Y3Frd0lnQU5SWWdMRWpzSVEwU1JzQ1p1b3dFU2RUSmtjWVFrUG0rMVU1ZHZN?=
 =?utf-8?B?OXlUQnFVU09yYlF4REhCZ3V6amhkMGd0d1c4NVdnY3hoSTVOZkp5ZGIxVnZo?=
 =?utf-8?B?UGtLSlVGekZJaWpqZjA1NWtaU1A1MzhpR2dVeDZvdWNTbGJsSnZSU2FSc2hE?=
 =?utf-8?B?QThWcGZXWTJLenJpNDVUY1NGc3MrSHNmelRyWmR4STc2SktjRDQ3b01BQ09q?=
 =?utf-8?B?U1oxazNLYXNPVWFzVis3ZWt1SXV3ai81d0Z3bkxsY3ltWkZNOHhMSEpWOWNZ?=
 =?utf-8?B?ZlRiZEZEQkxiOGVtL0FyYTUyS3JaUnpnZ3dyR1FQQjJqVnViZlBKYVJlZTJI?=
 =?utf-8?B?czNHenpORUNpV1dvSEc3ZTQ3a2E1WnNhRlNHeVNKZWJlM05EaU9idz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c85a1f-74f7-4f71-836f-08de7c04b091
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB9004.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2026 04:47:51.8586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVscq/bE34eXpEX7HTRLTDsdO3csKekpYqdmVwAY6be2AiEdaOKp0dF3mnbiNmHvzciUuagWtU0SHUc22JtVTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFF3CB57EDE
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 04:48:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3362

--------------XahVo0Qi0r1qgQvPRVXYG39h
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Missed adding some more testing commands.

$ MACHINE=xenvm bitbake zephyr-synchronization
$ MACHINE=xenvmgicv3 bitbake zephyr-synchronization

QEMU testing:

$ MACHINE=qemu-x86 runqemu zephyr-helloworld $ MACHINE=qemu-cortex-a9 
runqemu zephyr-helloworld ...

On 3/6/2026 9:43 PM, Sandeep Gundlupet Raju via lists.yoctoproject.org 
wrote:
> Testing:
>
> Set ZEPHYR_TOOLCHAIN_VARIANT = "zephyr" in local.conf
>
> $ MACHINE=qemu-x86 bitbake zephyr-helloworld
> $ MACHINE=qemu-cortex-m0 bitbake zephyr-helloworld
> $ MACHINE=qemu-cortex-a9 bitbake zephyr-helloworld
> $ MACHINE=qemu-cortex-a53 bitbake zephyr-helloworld
> $ MACHINE=qemu-cortex-r5 bitbake zephyr-openamp-rpmsg-multi-srv
> $ MACHINE=stm32mp157c-dk2 bitbake zephyr-openamp-rpmsg-multi-srv
>
> Also test zephyr 3.7.0 and 4.2.0 by setting below variables in local.conf
> for above machines.
>
> # 4.2.0
> PREFERRED_VERSION_zephyr-kernel = "4.2.0"
>
> # 3.7.0
> PREFERRED_VERSION_zephyr-kernel = "3.7.0"
> PREFERRED_VERSION_zephyr-sdk = "0.16.9"
>
> Sandeep Gundlupet Raju (9):
>    zephyr: Remove duplicate uninative configuration
>    zephyr-sdk: Add back sdk 0.16.9
>    layer: Fix PREFERRED_VERSION for zephyr-sdk-native
>    generate-version.py: Add verion and help options
>    zephyr-kernel: Add support for v4.3.0
>    zephyr-kernel-src.inc: Conditionally add python3-jsonschema-native
>    zephyr-kernel: Move patch out of zephyr-kernel-src*.inc file
>    machine: Add support for xenvm boards
>    zephyr-kernel: Add rpmsg multi services recipe
>
>   README.md                                     |   2 +-
>   meta-zephyr-bsp/conf/machine/xenvm.conf       |  14 +
>   meta-zephyr-bsp/conf/machine/xenvmgicv3.conf  |  14 +
>   meta-zephyr-core/conf/distro/zephyr.conf      |   3 -
>   meta-zephyr-core/conf/layer.conf              |   4 +-
>   .../zephyr-sdk/zephyr-sdk_0.16.9.bb           |   4 +
>   ...ry-generation-issue-in-cross-compila.patch |  84 +++++
>   .../zephyr-kernel/zephyr-kernel-src-4.2.0.inc |   1 -
>   .../zephyr-kernel/zephyr-kernel-src-4.3.0.inc | 310 ++++++++++++++++++
>   .../zephyr-kernel/zephyr-kernel-src.inc       |  13 +
>   .../zephyr-openamp-rpmsg-multi-srv.bb         |  25 ++
>   meta-zephyr-core/scripts/generate-version.py  |  25 +-
>   12 files changed, 488 insertions(+), 11 deletions(-)
>   create mode 100644 meta-zephyr-bsp/conf/machine/xenvm.conf
>   create mode 100644 meta-zephyr-bsp/conf/machine/xenvmgicv3.conf
>   create mode 100644 meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb
>   create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-v4.3.0-x86-fix-efi-binary-generation-issue-in-cross-compila.patch
>   create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-4.3.0.inc
>   create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rpmsg-multi-srv.bb
>
--------------XahVo0Qi0r1qgQvPRVXYG39h
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Missed adding some more testing commands.<br>
      <br>
      $ MACHINE=xenvm bitbake zephyr-synchronization<br>
      $ MACHINE=xenvmgicv3 bitbake zephyr-synchronization</p>
    <p>QEMU testing:</p>
    <p>$&nbsp;<span style="white-space: pre-wrap">MACHINE=qemu-x86 runqemu </span><span style="white-space: pre-wrap">zephyr-helloworld
</span>$&nbsp;<span style="white-space: pre-wrap">MACHINE=qemu-cortex-a9 runqemu </span><span style="white-space: pre-wrap">zephyr-helloworld
...</span></p>
    <div class="moz-cite-prefix">On 3/6/2026 9:43 PM, Sandeep Gundlupet
      Raju via lists.yoctoproject.org wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260307044353.1936182-1-sandeep.gundlupet-raju@amd.com">
      <pre wrap="" class="moz-quote-pre">Testing:

Set ZEPHYR_TOOLCHAIN_VARIANT = &quot;zephyr&quot; in local.conf

$ MACHINE=qemu-x86 bitbake zephyr-helloworld
$ MACHINE=qemu-cortex-m0 bitbake zephyr-helloworld
$ MACHINE=qemu-cortex-a9 bitbake zephyr-helloworld
$ MACHINE=qemu-cortex-a53 bitbake zephyr-helloworld
$ MACHINE=qemu-cortex-r5 bitbake zephyr-openamp-rpmsg-multi-srv
$ MACHINE=stm32mp157c-dk2 bitbake zephyr-openamp-rpmsg-multi-srv

Also test zephyr 3.7.0 and 4.2.0 by setting below variables in local.conf
for above machines.

# 4.2.0
PREFERRED_VERSION_zephyr-kernel = &quot;4.2.0&quot;

# 3.7.0
PREFERRED_VERSION_zephyr-kernel = &quot;3.7.0&quot;
PREFERRED_VERSION_zephyr-sdk = &quot;0.16.9&quot;

Sandeep Gundlupet Raju (9):
  zephyr: Remove duplicate uninative configuration
  zephyr-sdk: Add back sdk 0.16.9
  layer: Fix PREFERRED_VERSION for zephyr-sdk-native
  generate-version.py: Add verion and help options
  zephyr-kernel: Add support for v4.3.0
  zephyr-kernel-src.inc: Conditionally add python3-jsonschema-native
  zephyr-kernel: Move patch out of zephyr-kernel-src*.inc file
  machine: Add support for xenvm boards
  zephyr-kernel: Add rpmsg multi services recipe

 README.md                                     |   2 +-
 meta-zephyr-bsp/conf/machine/xenvm.conf       |  14 +
 meta-zephyr-bsp/conf/machine/xenvmgicv3.conf  |  14 +
 meta-zephyr-core/conf/distro/zephyr.conf      |   3 -
 meta-zephyr-core/conf/layer.conf              |   4 +-
 .../zephyr-sdk/zephyr-sdk_0.16.9.bb           |   4 +
 ...ry-generation-issue-in-cross-compila.patch |  84 +++++
 .../zephyr-kernel/zephyr-kernel-src-4.2.0.inc |   1 -
 .../zephyr-kernel/zephyr-kernel-src-4.3.0.inc | 310 ++++++++++++++++++
 .../zephyr-kernel/zephyr-kernel-src.inc       |  13 +
 .../zephyr-openamp-rpmsg-multi-srv.bb         |  25 ++
 meta-zephyr-core/scripts/generate-version.py  |  25 +-
 12 files changed, 488 insertions(+), 11 deletions(-)
 create mode 100644 meta-zephyr-bsp/conf/machine/xenvm.conf
 create mode 100644 meta-zephyr-bsp/conf/machine/xenvmgicv3.conf
 create mode 100644 meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb
 create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-v4.3.0-x86-fix-efi-binary-generation-issue-in-cross-compila.patch
 create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-4.3.0.inc
 create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rpmsg-multi-srv.bb

</pre>
    </blockquote>
  </body>
</html>

--------------XahVo0Qi0r1qgQvPRVXYG39h--

