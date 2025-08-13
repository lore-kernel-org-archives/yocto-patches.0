Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C85CA0EE0
	for <webhook@archiver.kernel.org>; Wed, 13 Aug 2025 17:41:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.76])
 by mx.groups.io with SMTP id smtpd.web10.2666.1755106864519363696
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 13 Aug 2025 10:41:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amd.com header.s=selector1 header.b=qXtflTFX;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.244.76, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEtfwOxyx0D0BwqAP1MplNHg0D3i8zwz/9aODloy/NEJVJ9RuVP2nykIwVQemLZYQ8F0iLCvlB6TmrVSy6YmVaXKUUKNhzUvrC7mKbCq/xVBDNm69TYcXqhq8MAVplVKIgtoN5Ma82IdrNB7OlP8qi2R/QXKPgxFB0A/eDUmJFvlc0u/ZQEUKcpbW7v/xllBtNW7VH+81UyQD2YUzy+xrlAHBzNbhJRid2joveEMXCwhgKaC/AG5W51HqKmW2i/7ANm9H7kbdl1OCaRplmHyDPpuR+gFi2wPxREKqVN47VSu91Pvw04SCW63eB9hLXPnJA0tla7J6IvnXIzcCd4FYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NppJqoA6sTuUHbYdCsRg/NYlB7/UIa7OzybK7cS2PVY=;
 b=UDTEnb6ot6bpLJ8IiSSg3FJep1SdFEG79qqnlN0DY1mWu+e6px5ulZRwp0kKgU5R4TTXfjIDAak2WLot7Jfs5X+7UzVwGslYcDwFUYnI5GUxOxs4Mn7YBM1jqLR0w4F8Mb/d2TtycrO3sc22sagXkDLUUGtrU0rozyJGBE66aQU3r+DeMZzNFPM4EMPJSDeHprNZVuDKqgKWdYKC7I5GoCiu1Qle0m6dh9pFCKe6hdB+z454NYd/il8dlHg6e2bwDGsxzueGhc0+AggPUb/bgOspoCY5jv7ITOkufNWJ4657v/rLwv/KQzaPrlBd8W8ZF/X8GIjloMP2UGU72r9FNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NppJqoA6sTuUHbYdCsRg/NYlB7/UIa7OzybK7cS2PVY=;
 b=qXtflTFXiF0tRPy8a39Qy7wDfhkhZ981VeU+WYbSqAkQEMZHUfIQJBnjUsMk2PQrw690O5Ucp2kkkM+Lw81uIE2Gxm2flr6/8gPvIh7J+T3rZgrcRmgbALXbXu2VtkFYIApEFCAqowe8qpBBrtST3B4xFW+4yiM2M6wxfBf0QMM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21)
 by CY3PR12MB9630.namprd12.prod.outlook.com (2603:10b6:930:101::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Wed, 13 Aug
 2025 17:41:01 +0000
Received: from SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7]) by SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7%6]) with mapi id 15.20.9009.018; Wed, 13 Aug 2025
 17:41:01 +0000
Message-ID: <b458a2b8-87b8-4503-a1b1-209ac981fd33@amd.com>
Date: Wed, 13 Aug 2025 11:40:59 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-zephyr] RE: [scarthgap][PATCH v5 0/12]
To: yocto-patches@lists.yoctoproject.org
References: <20250812174147.130972-1-sandeep.gundlupet-raju@amd.com>
 <BL4PR11MB8797F8BB0A6FB4FBFE498DB7B92AA@BL4PR11MB8797.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Gundlupet Raju, Sandeep" <sandeep.gundlupet-raju@amd.com>
In-Reply-To: <BL4PR11MB8797F8BB0A6FB4FBFE498DB7B92AA@BL4PR11MB8797.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR14CA0064.namprd14.prod.outlook.com
 (2603:10b6:5:18f::41) To SN7PR12MB8770.namprd12.prod.outlook.com
 (2603:10b6:806:34b::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8770:EE_|CY3PR12MB9630:EE_
X-MS-Office365-Filtering-Correlation-Id: 96d1eb59-bdde-4987-1537-08ddda9091e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|4022899009|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eFNsK3NETmVUclJzaG1NV3dOUlorK2dQcHBPNThxZWN0NGZKcStNMUFUQWNL?=
 =?utf-8?B?UUZPcVhIQjNVa0d5T2FGYzQ0QVUwVithclIxNjNDWkhIUHNQdVFWUUZBaDRp?=
 =?utf-8?B?RUlFRzVjQ1lhM3NhSUtTZ0RRSVZEKzVqMzc2NkpZYTErbzNzNmQ3UHlrek5o?=
 =?utf-8?B?QXVNa3E3UEtMWW1QMDlqaWJVVlJvTU5JaFRaZFQ4VVh1eEQwMkxKUE5hWnkz?=
 =?utf-8?B?SEVXUmpKWFV1a3piNUhIbWo3bThqSEJGdnBxd213RFc4bnRrOG4wekNsQWdD?=
 =?utf-8?B?VWltK0ZFYXVsYU00dkpiYUllWWNYcmhKZmNHaEdUSklrWjNRcmN1a083dEx5?=
 =?utf-8?B?R24vd3Nyb2FvZkh2SlhDdHBZQXZlK0hCK2VEeG5JVmViMkVVUFlyUEh6UjF5?=
 =?utf-8?B?TnYvR0E0NmRDaDBCcUJ3VFhULy92VDBqNWVGUU93S05GSmhKaVJvVldOKzRP?=
 =?utf-8?B?eEh4blNVSVlqSy9EUmNmczdESWI2VS9yVnhzUExBVWVhS202R29jdXVoZXQ0?=
 =?utf-8?B?YjczNUJmU3Z5YmwxdGxMM0MyYm1nV0pvUVVXVEdVdG5iczRzZzlZOE8wS2Yv?=
 =?utf-8?B?ZXFnNWo4eUV6VnprM0hMM1YvcUk5NEV3eENtTVZPUUtuR1p0ZW9VSGtnZGtC?=
 =?utf-8?B?dFJnVGdBbURTc1pFdWxlY3owdTl3YkpoTE5BYW9ncklVOFU0YU44Yk5SSGhJ?=
 =?utf-8?B?MFA5V2tjNG5UT2pheThta1lKOERrY3dLRHNQdVNwYWRSRkkyb3RXMmN5bzdH?=
 =?utf-8?B?YmFGNDBlWDFucm43UGI1KzlHbElLcjJPQ3kvM1Urd28zRGVmTXFDdWsyRDkw?=
 =?utf-8?B?NXBqMHNBTUFwNnVjRlh3c2oya0lMbGdsSURybEtPdS9abUFYclRycVJVL0pW?=
 =?utf-8?B?M3B1VzJodzlHbkw5ZUl5UDNxTlljM29Nam53a1JpcW1RbFNhRE1Bb3dEYS83?=
 =?utf-8?B?RHd6R282emlVSitoajBqWUVmQ3M1TXVvTjVMSFF0MXgvWUc4d010MmF1S3hZ?=
 =?utf-8?B?MlVaR0ErQ0NrVGcxNlJwNTZzaHRBZTZYWnNpaDZ4MjNMZmRua0IzN05vTlAv?=
 =?utf-8?B?NlhHTEMzT2NIWC9xdnY1UzZBYVV0Z2NsTWVnclZ4ZlZQNDRWUW0xK1dtQjl6?=
 =?utf-8?B?YzNrMEFRbnZpcDc5OHJEU3JKYWg2MldES2FOYU8zalRsUlEwMDBHTGVTaThi?=
 =?utf-8?B?Mjk1RzNYSG1uZi9aOThVQTV3cnR3MDkzOTQ1YlgyVnZGL3NNbkF3VFdkc0Nh?=
 =?utf-8?B?d044OTk3NG5CWi8wdGUxQ0JuZHJQbm9JSHk5bnd1YzByYWlhRnNBMFV6Y2ht?=
 =?utf-8?B?OXBQek8wZjd1b1ZwS0g0aWpIcVJ5NnpFYTVHU1V6ZGNqWGxsUHdwSTJVZ00v?=
 =?utf-8?B?b3pPeklKZWdIVTBwcHM1WjlMNU9iNzJvbzNUNW4rK1BLUzhlL1FVcE5uQ1BK?=
 =?utf-8?B?R3UyQmxMNkRPUDNhRXQ3aDNEZkhkSGFVZGxUS0FoRURaQ0dpRkVsTUFsMG52?=
 =?utf-8?B?UVI0MkFqSmhTNzdpdUVFOG9DVmw4SXBGUk0yeVVXdmtMdnluME1hYUxtb3pn?=
 =?utf-8?B?WldaMFduSU1xN3FUWHFuL0lvdnlocm9ONlJkdkRyUjg1Zys1NUhZVjZFTGo5?=
 =?utf-8?B?bGtEelBCajU1ajM2ZkdwS2RpZzZwNlFOekR5bGpQZWZuME11V1NQNHRYOSth?=
 =?utf-8?B?RWk4SVY4MCtQci9jb0VyTWZaVGZTN1ZEZHFIREhmMlpUTkVpTWlKVGlCcENn?=
 =?utf-8?B?K29VNTdZVjMyazQ5RnVJV1ZYWmFtSitJa01IL2JzY3A2RmNTZVppZnlGc1Rm?=
 =?utf-8?Q?lz+Q6gCbodGySEJ+tHZAphWOwPhzOcra+ht+8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8770.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(4022899009)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?blJvby9YdVBsbU5WTlU4aWRqQ3UwN1lSc3EzYy9pMldPTnFxOE96U3FaY2JR?=
 =?utf-8?B?L2NRby84QVJrMXo4RHNsZVlaQW9IcStwRE5EUXBWUXBJV1pkamRFSWpzWjRY?=
 =?utf-8?B?b3VJVCtjT1hNME0wTlVZVVMxd3l4UGI3Vng1aUtpVU1GUEhsQkMwZTNXcGMy?=
 =?utf-8?B?cUJHb0ZaSXd3MEZ0eWpBTUJwUEVFbHp0UkxXdUR5SFZ1dnc4MU1mRXAwbmdP?=
 =?utf-8?B?RVBhWUQ3ei8wTjRicUhIblgzWEhTdmNNTnh1QThVL2lHc2s1aFlheE90NGZV?=
 =?utf-8?B?b0JQa2JkVEZNUk1KL1lEQ2ZRR3AxVHFXa1BKVGFra1lvZm5CajR4ejhLVlhD?=
 =?utf-8?B?TUxKbit4aTJGRkhmVWtUdUJ4VTlOaVFHazJZbjBLSThqYWFkcFpzR2VSS0Jh?=
 =?utf-8?B?dEt5TDFCTjM3YnBFNnZHNm1KWUVRQStiVEwwbExySXpGQ0lmZU9wdFRlaG9S?=
 =?utf-8?B?QVdnSkNYSHduZ3pJL2gvd0ZheXJ0RURIdHE1bGRCSVRJVmRCamtMYTZWNzIz?=
 =?utf-8?B?VDY1a0dpOXI4YVE1L1ZGRGZrcnJoM0tVTGlXL3lrQzI2WlVvNmJjYXEySVFN?=
 =?utf-8?B?SGxSbDFDcUZyTkdHdUZ2VnF3MXZFK0tsT2FQYTVOZDdWeVB0MWRyMmJTYndq?=
 =?utf-8?B?Qm1IS2V2YkRmTEFkeHArMjNacVk5WDUzaWtXcXJtdGVvNEFyR3Y3S1I2MVdY?=
 =?utf-8?B?MzBQenB5UERrNjFQVTBBMndhbmhBRVd0RVlhKzloc0hWK01OVVN6bVRyeUJo?=
 =?utf-8?B?Ym15YzRxeDRxa05VeG1tRlNpRFRNWWhnZjlndFh4S1FLbGFXb25waUVMYTUy?=
 =?utf-8?B?YU9PY2FQSWh6Zll1a2hDUGl6UnRNNld5MGxTNnJaYVBUWG1KU1RFMU5LSUti?=
 =?utf-8?B?UVpEN21Pc28rUWVvSC9lRklDdlcrRysrNDFMYVNML2Z4Q1pWRWFqSERjVmVC?=
 =?utf-8?B?NnJlK1dCZW44T2RaTTNPdE1yRk1UWXQ5WXNTSnJIcklMRWE3OEdQZHJnektz?=
 =?utf-8?B?QUxFaWdvMVRVaUZ1RDhVUzVNd1FONVhFY0tDZ2hLRTJrTzVmbWpHQ2Erc3pi?=
 =?utf-8?B?MW1uOHNjQjJGUzFNWUQ5N05MSjFqV2dZU0x1cE5UZi85aFk0SnQ2UFRjRjNx?=
 =?utf-8?B?RDRBZm5yOTExYm9IVUtZR1Y5R1ludW1vSi9ZeFZyZjJON1pVRHV4c3pSOVRS?=
 =?utf-8?B?bWhGdlM4VUh5TXRiU3p1U001OXdwcXpaN1Zka3dHS05RREFwN1lLWm9UMm4v?=
 =?utf-8?B?YmxDWkhkcWRlYmh1djl0cEVtY2dvamkxWjgreEM1UGE0dEEza3JJeENFeUhV?=
 =?utf-8?B?bmg5cHgrSlo0aXlYUEVkdEYwMFpoU3F6dmJwZVBNVW9SL3NBSkZzRnVLczFW?=
 =?utf-8?B?d3lJZU9mT3B2WmdwME9zcXA5bm5qZTJwQWJscXpJQTNKeTI4OEU2M0o5UmRV?=
 =?utf-8?B?QTVibnZ4MGtXTHEvcThxczcyT0c2aHV6TXpUSlZOa2ZEK0tsV1BWY2cxYks5?=
 =?utf-8?B?YUlXbG45WFN4VHFmNmR5dGMyREFqL1VTNHphM3ExdXp0cnJqanNudVpwa0Fh?=
 =?utf-8?B?U29xYjZReHdFdVpkN2tDWW1mZStCWFVlWHlxdjRPNG1NNzllZkpwdlV3c1hH?=
 =?utf-8?B?Q1RxZGNjYnZtdE5XVHJsUSt1NXdWK2tVWTBXZjdHRENGRmpUMEVPZjNwWm1F?=
 =?utf-8?B?TTdxcDZ4NGdRUGduYm9Pa2dXalBScC8xVlVsRjR4S3g3ZlhBZU8raS9NSDJa?=
 =?utf-8?B?UEtTZzVBUmQ1bkxacUQ1K0tmNTJ0NHpabW1rUGpSTzVxMVZ6d2RNSVRTT2ps?=
 =?utf-8?B?eDVQd05kQW04MDhZdTVSaEprOTFzMWUydU5yVzB2bmRBcmNJc09pZGtFYlBr?=
 =?utf-8?B?Y3J0aG53RGJhazJWdTJ6d3BkdkY1TFVHS2NZdElGL0h1NkxmVXJwWFl0eUtZ?=
 =?utf-8?B?TEVxQU42b0lxTjlsNmwxVkV5WmdGN25jSSthZ0VSZFNoV2ZrWG1vRVRaNy9t?=
 =?utf-8?B?Y1Nvd3dKZGtZbFNrSGsyY0VaVWRRYzE3SjVTckkzTXhjbHVUbTh6U2dDMjRq?=
 =?utf-8?B?SlRkVnpCNGxYV0VYVEFvSTdMTi9PS0RIdVdNS2hQWXRxeHQ4TFQ3TmdEK1pj?=
 =?utf-8?Q?Ayv1J5EoyM7aQ8VE1lmdiuJ4a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d1eb59-bdde-4987-1537-08ddda9091e4
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 17:41:01.5972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PbNhSZvlIyE8lZWl7MqP9UdwOudFUhH+JHUDU0Ging3Obh7M3mgTRmMEeAyzzfE1H08YkttDDpM2tSGBFEiRsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9630
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 13 Aug 2025 17:41:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1984


On 8/12/2025 9:05 PM, Lee Chee Yang via lists.yoctoproject.org wrote:
> Hi Sandeep
>
> Thank you for the patches.
> I think some of the refactoring patches ( 5, 9, 10 ) and patch 11 which add new recipe should apply to master first before backport to stable branch.
> There is conflict when applying the same patches to master branch, would you be sending updated patch for master branch ?
[Sandeep]: Yes I can send the patches for master and then we can 
backport to scarthgap.
>
> Chee Yang
>
>> -----Original Message-----
>> From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
>> Sent: Wednesday, 13 August, 2025 1:42 AM
>> To: yocto-patches@lists.yoctoproject.org; Lee, Chee Yang
>> <chee.yang.lee@intel.com>
>> Subject: [scarthgap][PATCH v5 0/12]
>>
>> Changes in v5:
>>     - Fix typo in zephyr-openamp-rpmsg-multi-srv recipe.
>>     - Merge below commits into single commit.
>>       [meta-zephyr][scarthgap][PATCH v4 3/13] zephyr-kernel-src: Remove
>> PREFERRED_VERSION_zephyr-kernel
>>       [meta-zephyr][scarthgap][PATCH v4 4/13] layer: Set PREFERRED_VERSION
>> for kernel and sdk
>>
>> Changes in v4:
>>     -  Fix below patch commit message typo.
>>        zephyr-kernel-src: Remove PREFERRED_VERSION_zephyr-kernel
>>
>> Changes in v3:
>>     - Add Board extension support variables.
>>
>> Changes in v2:
>>     - Move classes to match bbclass scope functionality.
>>     - Use relative path to follow best practice.
>>     - Convert zephyr-sample inc file to bbclass so that it can
>>       be inherited from custom layers to support out-of-tree
>>       zephyr applications.
>>
>> Description of change:
>> 1. Fix runqemu errors for qemu-cortex-a9 machine.
>> 2. Add new inc file and update to 0.16.9 version for scathgap 3. Remove
>> PREFERRED_VERSION_zephyr-kernel from zephyr-kernel-src and
>>     move to layer.conf
>> 4. Add image artifacts to output files and use these files for qemuimage.
>> 5. Add Zephyr LTS3.7.0 support for scarthgap release.
>> 6. Update README files.
>> 7. Move classes to match bbclass scope functionality.
>> 8. Use relative path to follow best practice.
>> 9. Convert zephyr-sample inc file to bbclass so that it can
>>     be inherited from custom layers to support out-of-tree
>>     zephyr applications.
>> 10. Add rpmsg multi services recipe for openamp.
>> 11. Add Board extension support.
>>
>> Testing:
>> Run the following commands.
>>
>> $ MACHINE=<machine-name> bitbake zephyr-helloworld
>> $ MACHINE=<machine-name> runqemu nographic
>>
>> CI Build Information:
>> MACHINE:
>> BOARD:
>> BOARD_VARIANT:
>> IMAGE:
>> PLNX_BUILD:
>>
>> Summary of changes:
>>
>> meta-zephyr (scarthgap):
>> Sandeep Gundlupet Raju
>>      zephyr-kernel-common: Add Board extension support Sandeep Gundlupet
>> Raju
>>      zephyr-kernel: Add rpmsg multi services recipe Sandeep Gundlupet Raju
>>      classes-recipe: Convert zephyr-sample inc file to bbclass Sandeep Gundlupet
>> Raju
>>      zephyr-kernel: Use relative path
>> Sandeep Gundlupet Raju
>>      meta-zephyr: Update README files
>> Sandeep Gundlupet Raju
>>      zephyr-kernel: Add Zephyr LTS3.7.0 support Sandeep Gundlupet Raju
>>      zephyr-qemuboot: Use image artifact file in qemuimage Sandeep Gundlupet
>> Raju
>>      classes: Move classes to match bbclass scope functionality Sandeep
>> Gundlupet Raju
>>      zephyr-image: Add image artifacts to output files Sandeep Gundlupet Raju
>>      zephyr-kernel-src: Remove PREFERRED_VERSION_zephyr-kernel Sandeep
>> Gundlupet Raju
>>      zephyr-sdk: Add new inc file and update to 0.16.9 version Sandeep
>> Gundlupet Raju
>>      qemu-cortex-a9: Fix runqemu errors
>>
>>   b/README.md                                                                                                               |  163
>> +++--
>>   b/meta-zephyr-bsp/README.md
>> |    5
>>   b/meta-zephyr-bsp/conf/machine/qemu-cortex-a9.conf
>> |    1
>>   b/meta-zephyr-bsp/recipes-meta/meta/generate-zephyr-machines.bb
>> |    4
>>   b/meta-zephyr-core/README.md
>> |    6
>>   b/meta-zephyr-core/classes-recipe/zephyr-qemuboot.bbclass
>> |    6
>>   b/meta-zephyr-core/classes-recipe/zephyr-sample.bbclass
>> |   10
>>   b/meta-zephyr-core/classes-recipe/zephyrtest.bbclass
>> |    1
>>   b/meta-zephyr-core/conf/layer.conf
>> |    4
>>   b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk.inc
>> |    3
>>   b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb
>> |    4
>>   b/meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-3.7-x86-fix-efi-
>> binary-generation-issue-in-cross-compila.patch |  106 +++
>>   b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-blinky.bb
>> |    2
>>   b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-coap-client.bb
>> |    2
>>   b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-coap-server.bb
>> |    2
>>   b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-echo-client.bb
>> |    2
>>   b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-hci-uart.bb
>> |    2
>>   b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-helloworld.bb
>> |    2
>>   b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-http-client.bb
>> |    2
>>   b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
>> |   28 -
>>   b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.inc
>> |    2
>>   b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-3.7.0.inc
>> |  274 ++++++++++
>>   b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc
>> |    2
>>   b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test-all.bb
>> |    2
>>   b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test.bb
>> |    4
>>   b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-lvgl.bb
>> |    2
>>   b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-mqtt-publisher.bb
>> |    2
>>   b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rpmsg-
>> multi-srv.bb                                         |   23
>>   b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rsc-
>> table.bb                                               |    2
>>   b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openthread-echo-
>> client.bb                                          |    2
>>   b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openthread-rcp.bb
>> |    2
>>   b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-peripheral-esp.bb
>> |    2
>>   b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-peripheral-hr.bb
>> |    2
>>   b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-philosophers.bb
>> |    2
>>   b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-synchronization.bb
>> |    2
>>   b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-websocket-
>> client.bb                                                |    2
>>   meta-zephyr-bsp/README.txt
>> |    1
>>   meta-zephyr-core/README.txt
>> |    1
>>   meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
>> |    4
>>   meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.inc
>> |    5
>>   meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-sample.inc
>> |    1
>>   41 files changed, 599 insertions(+), 95 deletions(-)
>> ---
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1974): https://lists.yoctoproject.org/g/yocto-patches/message/1974
> Mute This Topic: https://lists.yoctoproject.org/mt/114678017/3619217
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/14411013/3619217/657730681/xyzzy [sandeep.gundlupet-raju@amd.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

