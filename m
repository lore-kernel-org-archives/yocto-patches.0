Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B42CA0EE4
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 14:32:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (NAM11-CO1-obe.outbound.protection.outlook.com [40.107.220.51])
 by mx.groups.io with SMTP id smtpd.web11.276.1755700342655854389
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 20 Aug 2025 07:32:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amd.com header.s=selector1 header.b=3Hdi5QFE;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.220.51, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjJe5+jvNJ5rl6buRnSSLBOhnqTRK5+6ROe6XPYoaK4ryXQxquFXBDVNKW0dO/f7yk04N1XaEoBPin9gT2cfHlq5wZGSxpGxILjEWQX3yesi18vcMHod6kcCIf1aO6zlOlg4nFa4pEen+C23YlWNKdy69jX6+M1W7nspeLSSjSu8avQW75LGkezHzuCCsGtP6TDzH+2UU7k1U+HR8Ci4xkXCySr7yDmo6KFiRLlAuNIj9g6z1LaXq7N3O6+x0/pKlWd1NP7X/0EZ8DPN/qvGM1PVIWQcK3P0g9Pwb4L6faiIcOKYaKoTMOB8K8QV7iyTWhXh5cVlJvly563MUSCwog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKUojycTZ2uwIL5Vc2j8bYZiE5zzjwumtjnF0W8MkhU=;
 b=vOBHIc1zgeH0JMNGjfBTUVhNmpx4vOFQzE4kJR7CwSMaOqSBIFA/L5JDpzW3KGoczVNoYvCnytXg/Rbltrzx04waAEEuceT7M7T2tOiS9uwHA5VpxXHEChnGOLHG93yogllYn7HoqaIbN7l+JDKDxsqj1/w7tmBqUE4iXKFrpFXDH8QR3uv6vAa87QySpRrgBYatCklF6Aa0bZ4l05HgvwbIoalxs0neAv4hTnUTq+RkRT+aadj3efFFX431dvSZPqdCs95NXhFWMLW0N6QXZPO9TLggx3d9jUPKUSJDj4pIBsSda9i7bTwx4wTqAznDxh2pp8Dmz43RNivXDdxhKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKUojycTZ2uwIL5Vc2j8bYZiE5zzjwumtjnF0W8MkhU=;
 b=3Hdi5QFEbe+EtHUs8KltFpKpHvN7Xc9L8HPlSBC42tpI5EiyeDakHnxumYUzHubMVmpLMOMisCGcBxA6GiSGH+yohu8vnmwi9FTyebJ+kzZE4NJ8TMo9Dv9YJ/dPXeUGdp+queNl17kSNg2lpyjNAr2WY663cb9mKdatD9pqhHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21)
 by PH7PR12MB6564.namprd12.prod.outlook.com (2603:10b6:510:210::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 14:32:20 +0000
Received: from SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7]) by SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7%6]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 14:32:19 +0000
Message-ID: <61f396d1-33eb-4790-b958-6b3335e0b46e@amd.com>
Date: Wed, 20 Aug 2025 08:32:18 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-zephyr][scarthgap][PATCH v6 11/11]
 zephyr-kernel-common: Add Board extension support
To: yocto-patches@lists.yoctoproject.org
References: <20250818220304.2300436-1-sandeep.gundlupet-raju@amd.com>
 <20250818220304.2300436-12-sandeep.gundlupet-raju@amd.com>
 <BL4PR11MB87974D9CAC1FEACE72D6788BB933A@BL4PR11MB8797.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Gundlupet Raju, Sandeep" <sandeep.gundlupet-raju@amd.com>
In-Reply-To: <BL4PR11MB87974D9CAC1FEACE72D6788BB933A@BL4PR11MB8797.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0023.namprd08.prod.outlook.com
 (2603:10b6:610:5a::33) To SN7PR12MB8770.namprd12.prod.outlook.com
 (2603:10b6:806:34b::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8770:EE_|PH7PR12MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ecaa7f6-e34a-40f9-5d7b-08dddff65e66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|4022899009|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cWtIcnAvaUhUNjFsUkQxRkdyNlZRTHNXTFQ3Vk83Y1RrNFZ2T1EzUXhoaUw2?=
 =?utf-8?B?aHV0SnR3ZEd3akpYWVMzVThZTS9BeDYzSXg3dFdORG9DSzZrM1dxQTJjTFRM?=
 =?utf-8?B?aTNzdmcvREtsbUdoNjcyem04MTNqS2ZKRUc4RzFvSWtrcCtQazVUMkExZmk5?=
 =?utf-8?B?TGQrbThvcTRqNHpYNHo5dFg1OHVWWVhsMFNyYlNTNVpQOUJ2ZXhiR05zRWZl?=
 =?utf-8?B?cFdrSCtndFJEQnpQTTJyeFRjZ1FSbGdORndjd3BaQytMdU82L1RhaFVmWGQ2?=
 =?utf-8?B?RThnakFqNmhYSUhXb2FMeWwyN1QvQU9Rb0hyWEpVNVhZdkNkbXp1TE95SmdG?=
 =?utf-8?B?REc1ZGp5b200RGtjSWRhTzRKZmpMQ29HZlh3ZTFvY2dqejdpZG5vUnNsd0d4?=
 =?utf-8?B?TkJna000V1RCQ3ZHNjc5c2FoclVncmNKWjVUcFBtaEpmNzRQWHRxbHhzSmhU?=
 =?utf-8?B?SjFSMWVNc0FuR2ZSQ0Q0NEFwc2lpNnNzVDR0a2pYL2V0Y2ZJUWZnZWhwb2l0?=
 =?utf-8?B?clpmN1JoczZxYS9va1RHbkxpWnNkRGpvSHhPZ3h6dGE3bWt0ZWFVTG9odkYv?=
 =?utf-8?B?MG1Mdjlyb3lkcmt3SU03c1lvT3VTZVhaOEdMUXEwTWNoNlh2UlNaT3B4TnMw?=
 =?utf-8?B?YktZYklzS2xlaEFDQjFuRGlrbkVzdGZ0RlJqVkFvREduUzRxaGdHczdLU2Z6?=
 =?utf-8?B?TWs3aDhpRFl5d0xmK0x2RzAySkVOZUFSNlgrYW5qVzBKMkh3eEtnTmxxN3VN?=
 =?utf-8?B?MkFSUDJqWm5BaTNweGNqUlFTK2NVdE9HcjJSNS9RMmt1SktaSDNwR3hUYUhu?=
 =?utf-8?B?WHJJOGY3OE5EZGJtdC9aNnpTUDQ1d1ZZZWtSaU91YXVwUVZCV1c1WG1ZbUtk?=
 =?utf-8?B?SHZGeGhNZlRpeERhRThHQUlPNzdDQXNBa1ppaHAraW1xSFZZQzFYWnluOVVM?=
 =?utf-8?B?WXFNbnFNaXZJUVg4UmlaVllucE1MMld4TGxHMXdyWFpZcVFDZVJjd3BIUHdk?=
 =?utf-8?B?ckxwM2QvbHY1WTZ0dE1PUWxhL1BJc1l4M2ZoVng3UFBPQnFkUHdBbklTNXlq?=
 =?utf-8?B?djhhdDJlT01DbWk3S0VGRFYxQmpMWVp3YmprbHdhajhSZjNXaDRWajFkRWdj?=
 =?utf-8?B?eE5mZDlqZXlsVUw1QTZsM09nMjRvUzd5VSt1M0N1OUNQWXQ4VTFGazdvbW9r?=
 =?utf-8?B?WElJVnp5Z05UTmxueEU4cjBzRU9sNnJSc0xVSHJqeUxucTlCM0JKeEJxVUFp?=
 =?utf-8?B?VFVHQUxJSGVSWVgveUYrcUlGZm4yVEVkd1YyaWlRNFZoeGJ2T1AySHRvK0dI?=
 =?utf-8?B?ZTBMckpNWEFVSElsblFGQTlrSW9Jekdod3IwbjM2Z21YakE0ajZaZWNSUEU3?=
 =?utf-8?B?azc4U25zRnBmODRGNDdZelRrcHRhb2NUREZkUDF0NlZ3YUJRVy9ablYzdVB2?=
 =?utf-8?B?YVc1N2ZkbU9rNWNJWDFEQTFYaU9xMVZhQ0hOa2pDV094YkIzN08wK21VTFAw?=
 =?utf-8?B?VXIwR0NjaFlFSmVqTENxbGg2YkpxTXBrWGdYUlRKSDhZNHVmaGU2NWVWTHRX?=
 =?utf-8?B?NjlwTmNjdjk0anVGZ2NvS003NWdTLzIvcmQ0REg3eldzMGhiZXNxeURhS1Z3?=
 =?utf-8?B?d2QvRTZnY2ZQZjRIVVptOVR3aGZOVVZHZUp3Z1oyK0lFOWFxeUIyeUlVNzQy?=
 =?utf-8?B?dngveXZzRitCeWx2UUZmM09NMFNDQXVqN1JMc2UxYlo2ejRjY0p1aU5tUHRC?=
 =?utf-8?B?bUk5Q0laSkpXdXIveTV3a1E1WmIyaDJSeHdjWmM2LzR6SjhFeERIWExYeHBG?=
 =?utf-8?Q?rvgIlmAxrIzpTMUyrjinWvX4WgBbY1sy3H6hU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8770.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(4022899009)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NklDTS9wWHNSaERWc0pIazByWlh4U2cxYVZwSlYzZEpPS2hBMVdUbGVhRm41?=
 =?utf-8?B?U1U0QnM1SGhyTVRsdHg5b25zMXVNMjR3dkpOa3EzaHRkcUZrSHgvUEx3RXZS?=
 =?utf-8?B?MmZvUFVZNENSaC9kTVVEVy93eVNEcXZmQVBsOHVFODUvL3lCWmlaMWlUU3pi?=
 =?utf-8?B?djdIYkFUSXBDNWsxQ1o2UnpOV0JNczlaemxuTk1ITVZoSk02cUxPWDRSNTZE?=
 =?utf-8?B?d1VRb0txcGphNW45TU9aUktBeTNxTmdvczZwZFZBMW1KYzRwQ3lyc0Y4Mmw3?=
 =?utf-8?B?NEF1c1NsSTdXL1NiZkJxNUFHRVM4R2tpSHpnSHgxaGlIZVExd2QrTTlLUmtZ?=
 =?utf-8?B?VXE0WmlIek1neHNralJvMUlCQlFEZ3BwQnRmOUROK0NidEJzZlFBODlqWVhj?=
 =?utf-8?B?RjRTNVN0ZXNYMGpaYlZPV2FwZjdDU0YwcTdWZitOWEFKZkx5YjRZaEd3eXYv?=
 =?utf-8?B?KzlzcG42bmxsWDRWOFF6Smg3eHBOR3Yvc29RQ2ZCVlFDejQ0YTVpRGVDUFlX?=
 =?utf-8?B?ZW15RVErZGRjdFppTHpBMzU0VXhSaVlJSzRXNGRWbktlSEFyU3VJTEdKQW9k?=
 =?utf-8?B?TktHTk5WemtjSHFhR2diVjAwQjI0MklFQUgyVnZtbEZiZFpWL0ZyZFFoZ2lu?=
 =?utf-8?B?TmNnVHpIVEpsQnBCZ1NUd2YydXF4QjB0UzZjNjdnUEw5QmxlcWlZc2FhQkdv?=
 =?utf-8?B?SzFLYng5aUJyZS9ERllSbS81WlplRmNkSTBOY0V2UGt3YVVUU08rck5DcnR5?=
 =?utf-8?B?Y2x1WlBNdkM1WVUyUU9ySVlmTE9iNWFyVG10eTB6UnhGK3NIS3d5QWFnY01O?=
 =?utf-8?B?SVdJS2UyaTM1MUd0ZFZnajhiU0JuOVZqUGp4VzV4am5JWGhqUnBlZkpCTzJo?=
 =?utf-8?B?SUJHMVpFQ01vWVBna2JXd3BNSkYxZEliRm1RSWREU2Y1YUt3S2xpUERjT0ZE?=
 =?utf-8?B?cStDRWQ0U25iZEtWK240ZDFCR1Y5ZFRWSi80OUloUkpyNkZReU5NbFpnMDlM?=
 =?utf-8?B?ZkdKZ294NHY2Qlo0dTRUV0ZLeHV5U1ZFNjNCYTF2RVhwbmw4Q2FyZDR0NzdH?=
 =?utf-8?B?aXZwVUM2WjAvN0c2L3hYMGNWZGtyY2tOV2lrdGhRMDUxenFxMkVxVkh3eGEy?=
 =?utf-8?B?WDhkRTgvVWtZQUpDMTFyRlArcW56MnE1dFp3cDBobGxuU08vNzJ1YVZ6djRI?=
 =?utf-8?B?NG5QVlJPSEh6VzZ0Z0h6RUhIMnRwV1RnSTcyUno3dDFJMHBoSlJiOHJJTEFD?=
 =?utf-8?B?dm0vUkR0cEpUNXVuYzlMczlFQmo4MnNjWmpEYmVUamFZSklpK2loUmkzN0t5?=
 =?utf-8?B?OENxa0NWNHNSRUN0ZVhmR2dwWTNubHZsZWRlR1BzWFVYVGRKN3FSa2o2RFVE?=
 =?utf-8?B?b0t1L2tGOVRWQ2h5UkN3WkhPazc5bG9IeEgvQkhvc0RycysxODdlbEZzRmI1?=
 =?utf-8?B?UWZZVXg2ZUpQRTZGVVJlQlFOSXV5c1RGZjZINHo5NTI5Z3lyS0kvY1NaV3pG?=
 =?utf-8?B?THBTSmVFUUFhRk9QR2I4M0NBS0l2SXp4QzlwdDBnMDAyQ1BscnVDdWZDRUxs?=
 =?utf-8?B?VlFiTnh0dXZJVmYySDVOd0dhcVdBOENmd0hrbHpPZDQ5UjE4UXN5SUl5OXRV?=
 =?utf-8?B?YnFhSHJRai9iYWNYdWpIeWxERW5wekZVSUozSm92VFZMSEJtek5QN2l6cVUy?=
 =?utf-8?B?ZmNxamZibUJ0bTJiMi9BSzR0NzBzVTlod3ZpVjFsWlFOcVpxUmk2Wmp0QWtk?=
 =?utf-8?B?QUg0U1NTUXpXWFRYdVBMelBhdUhrL2xkKy9sdVpzWlcyN2oraitIcE1hMDA4?=
 =?utf-8?B?RmVlcGRHN3BlRkh3bmYzajhQd2ttZnVacUxwVzhsM01KaXhIbFUzWHk0ZEJJ?=
 =?utf-8?B?b1Z3c1JjVkQ5cG0xWHV0cnZLdUNTOElXcks0TGE5bHRDamhVemU0UzRwajZP?=
 =?utf-8?B?U2lzUjVPT0JLbnZIWWFBTXhVKy9odkM1ajZVU3VpYXppU1I2dytRTmNUZUJJ?=
 =?utf-8?B?WmRPUmhiakZrRXBtYWNQS0R5UUx3eTF5SE5BdlRTME9sRWpTczNncUEwQ2J5?=
 =?utf-8?B?NVY2cGw3L0lJSi9tUHJUZTN0cmxxRHdpVmpBOVd1SWVMcHhHOUN6ZkErTXdH?=
 =?utf-8?Q?R92z/wcGHBJz0npDZTMZhH26T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ecaa7f6-e34a-40f9-5d7b-08dddff65e66
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 14:32:19.6779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UE9uxH47naOWTarmagtn1Gr9oEyN+fMSbfUGIotf64VTGMWyhHR2MoZN65mkPfJxV2KffBWlsiA5VVotzJZRRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6564
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 20 Aug 2025 14:32:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2072


On 8/20/2025 2:03 AM, Lee Chee Yang via lists.yoctoproject.org wrote:
> I think this cause build error with zephyr kernel 3.6.0. This works with zephyr kernel 3.7.0
>
> | CMake Error at /data/scarthgap/poky/build-zephyr/tmp-newlib/work/cortexa9-vfp-yocto-eabi/zephyr-philosophers/3.6.0+git/git/zephyr/cmake/modules/boards.cmake:167 (message):
> |   Invalid BOARD; see above.
[Sandeep]: I see this is supported in 3.6 Branch 
https://github.com/zephyrproject-rtos/zephyr/blob/v3.6-branch/cmake/modules/boards.cmake#L24-L30 
but not sure why it is failing can you provide the reproducibility steps?
>
>> -----Original Message-----
>> From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
>> Sent: Tuesday, 19 August, 2025 6:03 AM
>> To: yocto-patches@lists.yoctoproject.org; Lee, Chee Yang
>> <chee.yang.lee@intel.com>
>> Subject: [meta-zephyr][scarthgap][PATCH v6 11/11] zephyr-kernel-common:
>> Add Board extension support
>>
>> Add board extension support variables where user can specify the
>> BOARD_ROOT variable for out-of-tree custom boards.
>>
>> Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-
>> raju@amd.com>
>> ---
>>   .../recipes-kernel/zephyr-kernel/zephyr-kernel-common.inc    | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-
>> common.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-
>> common.inc
>> index 5191b9a..579fd6c 100644
>> --- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-
>> common.inc
>> +++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-
>> common
>> +++ .inc
>> @@ -18,6 +18,11 @@ EXTRA_OECMAKE = "\
>>       -DZEPHYR_BASE=${ZEPHYR_BASE} \
>>       -DBOARD=${BOARD} \
>>       -DARCH=${ARCH} \
>> +    -DBOARD_DIR=${BOARD_DIR} \
>> +    -DARCH_DIR=${ARCH_DIR} \
>> +    -DBOARD_ROOT=${BOARD_ROOT} \
>> +    -DBOARD_EXTENSION_DIRS=${BOARD_EXTENSION_DIRS} \
>> +    -DSOC_ROOT=${SOC_ROOT} \
>>       -DZEPHYR_TOOLCHAIN_VARIANT=${ZEPHYR_TOOLCHAIN_VARIANT} \
>>       -DZEPHYR_MODULES=${ZEPHYR_MODULES} \
>>       "
>> --
>> 2.34.1
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2064): https://lists.yoctoproject.org/g/yocto-patches/message/2064
> Mute This Topic: https://lists.yoctoproject.org/mt/114772375/8188369
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/14211927/8188369/518048116/xyzzy [santraju@amd.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

