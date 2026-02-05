Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B99CECD99F
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 20:13:43 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com (SA9PR02CU001.outbound.protection.outlook.com [40.93.196.34])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.30462.1770322415728652595
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 05 Feb 2026 12:13:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amd.com header.s=selector1 header.b=wiE0A2eB;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.93.196.34, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7IOl+D6/VPC3Rp3anCpqjN/PsN5faJo2L4eKau2rjc0vVC3O0gxib4gnxQBVoGQDC+VgeDxGYMYazZy+RPp8+/jX9phKEDM9jOYHa2+e7ir8lqW2hDb6aqlubVn1jQowj9aZMJZsHhNuv5OUiRQziRsy3Zkra0/yFr85coK2/W4yaqteD/Ay6mNlw74WM0M2oHromJTlblrNtJGalR9rYKk4HIchXZSZInlJpAJQCRLPs4UfzMSwKCXkiHef8nBojeMM2EJnQo7c2GXdV/9m+LYLIAC0tvNBOESXf5z1EpOpmkDXSxIOjCYCwHf0h0rfjgCeh0X6kwgYug/FclAtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2joTAJJ42ZqxNEirQlGA/deIPTYK9dtKDA3tTFLEKM=;
 b=iUJub/jgE9T2o+RJ7IIFuYEa9S6501ffbH1lPqakbLpXn6DilFfJJufp2wC8+R7o+FlvQ4lcfqEho6g8X/KMgXfqGjnUv5O7W2KC7QSfg9ZkcJewnDvVKdwA8kWwa1ILGIXAmrtt+CntrJXuqOmpQxJJNTWNkdq/EeT/73WTC1po+eO+Y3SfQeHsAkl8miMMvztMisESdjGmqdQP0WJXBqY3YLTHDC2NPKaxeYrLUcwcuv5Mb+FslOcYwXr2vNpvIMz6d61PzcA9NyZrA2lMU12QYlwNYzBug9FDevptDNb3V0lrh8Mt1vzM83pEq9P/PwO3Lw3I2loCwOovkkZn5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2joTAJJ42ZqxNEirQlGA/deIPTYK9dtKDA3tTFLEKM=;
 b=wiE0A2eBoHsDAFnG7ehET6COYRBMKKqhFONNPQWD8DAdgv0ctIbCL+A/sBEh6U8sbgjM9xxTAph/fFVBQ5LXgX5R97qFIYVf+e4chxBq7LpVwl0XQJbJrMZ/y0X3MFONrIvLNrdpHvjxICdA91W+lVbjAziPFganHY07pp9YfTw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21)
 by SA1PR12MB7247.namprd12.prod.outlook.com (2603:10b6:806:2bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 20:13:27 +0000
Received: from SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::9fec:220a:a205:ec68]) by SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::9fec:220a:a205:ec68%3]) with mapi id 15.20.9564.016; Thu, 5 Feb 2026
 20:13:27 +0000
Message-ID: <ad9c4d37-1006-4a55-b1bf-4122a6f10e70@amd.com>
Date: Thu, 5 Feb 2026 13:13:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-zephyr][master][PATCH 0/2] qemu-x86: switch
 to generic q35 and document nographic
To: yocto-patches@lists.yoctoproject.org
Cc: Charles Dias <charlesdias.cd@outlook.com>
References: <20260203143506.119483-1-charles.embedded@gmail.com>
Content-Language: en-US
From: "Gundlupet Raju, Sandeep" <sandeep.gundlupet-raju@amd.com>
In-Reply-To: <20260203143506.119483-1-charles.embedded@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:930:8::35) To SN7PR12MB8770.namprd12.prod.outlook.com
 (2603:10b6:806:34b::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8770:EE_|SA1PR12MB7247:EE_
X-MS-Office365-Filtering-Correlation-Id: f7c5b3ec-36bb-47a2-197c-08de64f305fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|4022899009|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dkNHYjZrZW14ZHJUNG1UcCtQQzlDdUlmSSt6akdCTHBGbERwQys2VnlkYnFm?=
 =?utf-8?B?dnRBZ3N0MjBxWitrS0QrMFluU1FiMVVSYUQ3MmxqdkdwSC9QN3pJellObW8y?=
 =?utf-8?B?QjE2R0NmS25SaHV6SGwzc2RpeXVEUk1YNVM2TlFPNHhObkVlb0FNM2F5M0Qy?=
 =?utf-8?B?b0hHL1Mzc242ODlIZmlWNmdkOW8zQWNEUDcxVVBzcDBSTEpMbk82b3pWNXZr?=
 =?utf-8?B?MlBKTUxSTmNSVGd3S2I5U0cvK0tHZ0NibXlTK2lmanJ0VW43dVRXS0kvYkNj?=
 =?utf-8?B?TjlrYWt3bWhHbzhMTlVpcjJrWHB6OVJYVWl3L1RacEpOOXhMWDFVb0w2ZUht?=
 =?utf-8?B?VzQ2ZFpCTGtlT1FKUEcxVStEbzE0cDcreVcyQVppZENPL1RXai8xSGpLQ1Jj?=
 =?utf-8?B?aC9Xd3ZydnVORzJUa2VOaTdUakhaWVJGbC9LNmswbGpWc1d3ZHF6eFk4RElK?=
 =?utf-8?B?enV2M04yOEtCNE5sUGtlZFBXRnVnRUlvcWlTaEhCMHp0VjgyOVEreTZCSnNk?=
 =?utf-8?B?ZTJid0p6aWUrZTNYd20zUGlRVDIyZlNFZ3p4a2p6R0RENWxzaXY0emNxcDhG?=
 =?utf-8?B?dVRBUWpEK2RZUUprU2M0MmVTVEkwbm9vL2t5YzNoSU9DeXR1RFJTN09WNDVK?=
 =?utf-8?B?a3V2bTJTZHhPS2VldFJRNWhOQUd6Z1VueEQzUEhKQW8ycHVNblo0bGVpaTVr?=
 =?utf-8?B?ZE8xNGtIN1dPYjZDV1BZVWZkdXhkbVluRWxNcWtaa1pzTi9wZ2xtNUlhYUNM?=
 =?utf-8?B?UTA2Q0FpemE3L2RDVW5UTmMwMVh1c292MTJqUW9kMFpOUVpwSVJYWmcwRW1z?=
 =?utf-8?B?ZDliMS84THpXMG5IamRiZHNIbUl1R2VjV0huc0tTVkJJTFRRempPMFdUWkhk?=
 =?utf-8?B?MFFadkUzaXZORXJZL3ViOEZyckMzaVdVL3RyeTdFbVFSRXB5bGZFemd3c2Jh?=
 =?utf-8?B?RXQ3ejdGZ21NNU9WM1ROdC9RWWxCNjg4ZVBmV2Z6bERtemlJUlBkOFM0TitE?=
 =?utf-8?B?N0owK0ttRXEwSnk3TlNrYTdTSWtHTmZoYjdEMHR6QzlFNytKV2J1bUxnbVQ5?=
 =?utf-8?B?K1h6TWs4VG1oUWxzYTVzUEV6aXBtQWZFcm95M3JRZXhXd1pkNGduNGxLbTds?=
 =?utf-8?B?c0hUZWVFSDF6MjQxeGQwRHRrd2hFRlNqU0pSWExYbzczaDhHVjZPbUtNWExI?=
 =?utf-8?B?MkdRQ252bHd6TGt3cld5MWN3blB4ZGlGM0RmSmV2TkVCVk9JRGJaNFRpSi9E?=
 =?utf-8?B?ZHBWWTJvRXRkQisxSUVPd3ZDcHlMOXBOeUZ1VEhiYzZkNER6SXY3TFBqaWlT?=
 =?utf-8?B?OVc2SzE0TS94VnFaMlVKNSsvS0RlSXRXMEJQN2tqNUNsR1VKN1JheEJDamhu?=
 =?utf-8?B?RzdnRU5mSTdPcEVxQjcyZisra2ZLdVpOdW1WTFkvMTBLZEFiMlpacjc3RllO?=
 =?utf-8?B?Q1I3ZkVJdWFVZHNGUC9NWGtQYS9WaU5qNjJPOXhtMDgxUWMvbHFQY3dyWVFH?=
 =?utf-8?B?WUlJZEFDZElTbDgvN2lTMGpsbUhMRitwWXowWmxoNWZncm5TUklvaklrb2Qx?=
 =?utf-8?B?dEFVRGtJMlV1V1g1NzR2NDBWWDE4dnNrTDFyNEdKWloxeW1MQm04TDVZRXZK?=
 =?utf-8?B?MVIxUDNlc3lEcEhMd25SeTk5MExkRXByUGVoQ1NaZGdmNWI3dTBIcEtpTmpI?=
 =?utf-8?B?MHpyL1pVc1B5dm44Ymh1TU9CbHBxNFpaSXh2VnVUdjMwbm00ZnNyemVITGZK?=
 =?utf-8?B?cnBmZ2ozRTJFcGw5RzFqSEhaVk1POFJDbFpGaUpEYVFZS2hzaElrbUtralJQ?=
 =?utf-8?B?QmdKM0dOUnRtTm5PYjlkdFV1NnJ3dW1Lb3hJK0ZyU2Fhcmdpb2pES0daUlFE?=
 =?utf-8?B?QW9HU0JBR29nZlpDcW1lMmN4NXhQUFc4bWJPeDBVVzM4NTc0c1pwWUZISE55?=
 =?utf-8?B?bmpzZlV2S1diQmtjWHFRUXYyeEVPZXpJc3g3dGo0dlRTbUZCYURWNnJrajM4?=
 =?utf-8?B?N0YwUGZBdTAzNWZ1ODU3cHNRYTQxVk5IVlp5VlpmNm5QeEs4UElobjU3L0Yz?=
 =?utf-8?Q?CEGHaY?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8770.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(4022899009)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Zy9GYURNZy84NlU4OWJST21hWWhNOFJTWnlOazlkVHAzUHNnNGlzb2tUVU9N?=
 =?utf-8?B?ZGtRMlRWUFVORUJudGlmbVRUclplMHdhV1g5bUFLWHNudUxXMFdod1NQZXhx?=
 =?utf-8?B?QU9CaEF1T1lia2pDWVIyNEtUWkxjQ1RjeVFaKys1UDl2bXhjZzBkcG9GSkVV?=
 =?utf-8?B?d2hIS0tvQXAwZC95cnJWRno1VlU3NG9BaWRaZmZHcW51TGFPTXhzM0piNW90?=
 =?utf-8?B?MHRuaG1DM1JJbmh2RnptNXdQV3hLS1Q4b0RiT2U1d2l2c043aFh2aCtuRkxr?=
 =?utf-8?B?L2FhVFdsblBzdE9GVGlRZ3VzZnprd3NoV25UTis2T0pBYUVXR0FYYWUwd1FW?=
 =?utf-8?B?Yzh5MHJpaW5Hbm1rQXNPcDBpSi9jQWx2UWppR2QvbTZjYjhhMnBqME1rSnp5?=
 =?utf-8?B?TjNOSldWSHlEd0M5OHMwSWxtbGNWYjlHL2NCVEdyK2dOQ2U5SVBXOXJobVVO?=
 =?utf-8?B?elc5N1ZqSUNHTm1XT1ZwOVFhc01NUkI5bnpoaEdGVnV3UTY5ckE1WFQ3UEw4?=
 =?utf-8?B?d2lMU0VlSFREVlBsUVkyejhBSkx1Z0ZZQmdXNXJZSy9DallWNEFzUTVtUGRv?=
 =?utf-8?B?M3QydlBPeUVwTGtxR1hOeFU2cXpyck9WTnVacmhuMjJ2dEFlODFzdGFFNkZP?=
 =?utf-8?B?TGw4RUprSzN3MHFHWEU5aTFaMDVRUGdRbTdGeTZmdytNZUNMaGxZaUdDSUtH?=
 =?utf-8?B?QjZnekw2c0cyNVRnVnpIL2lGZy9vLzFjdVQ4ZVpNY0NrQjVlMXFNWG1jWDB4?=
 =?utf-8?B?VDNlbW52K2hVM1BTaEZxaTRjWnRhZURiZFhrb2lVUWRseWxjR1RMOTZoWkNH?=
 =?utf-8?B?c0diRDltZVVWeUlVd2N6NzNWM0FST0lLY2RUMVJSbEh6VkFBQnFISnRZMW9u?=
 =?utf-8?B?VXgwenF0djhSNDNxNUR5b2hJVUVIRi8wMkxvRS8wS1RjWk5ZcUlhV1J2akpl?=
 =?utf-8?B?TzcxUjJncVZwcG9rRWRKQ2xRYS9rcVBZaTV5ZDBqR0l0bHJ3clM4c0VoazFp?=
 =?utf-8?B?SDN6WlFEaGJhcUJRWFErcm9HUWVhSWx0cTF4VlZVSVRoNnNQZ1EweERSMG9M?=
 =?utf-8?B?UDBGNHU1ZHJDajV6NTNEM0t4bE9VWXFRc3ZtKzhFc0pCTDUxTkV2TVBhMkcv?=
 =?utf-8?B?WlkyclFnZGczNU93UEZYRjhReEN0RmphNVhiR2hIa2dtM1ZQU0Njc1dNcUNI?=
 =?utf-8?B?RWhmaThNQXpJQzhPZGllRlFCejJhSTgzSG0vbk9lbWt3d0dhdGpFNG4raGZH?=
 =?utf-8?B?cWYrdEpZTVQrN2dDSDBVVHdGS3p4T3lyOCtlcTF0NXdhbmdhZFZhRDJuS3pQ?=
 =?utf-8?B?LzNrZ0lERnZMY1VkeUh4N0ZhVUEvOGNqMmJmVFdpR1MwcE5QMnRMZFhOSm5M?=
 =?utf-8?B?UkhReGhYSU1XcGlXTnh3MVRyVlQzMUVZZ1dha1dybGVnTHc1anFEM0dCaDhV?=
 =?utf-8?B?YmYyb2xBbGRUNE9meTl0ZW55OUN2cjRGdUVjZ043bjZKcEJVUVFrUXFzaDE3?=
 =?utf-8?B?SVc3Si8yWitySzRaM0I1T0Jkd1BPQm00THRSdHVhYUJwc3licTNRYzJvanBj?=
 =?utf-8?B?MXhVZmNQR210NHp4aEIzWkV1VU9Fc2NCUTF2OW1CcVUxSzNCQ1pEUHphdW5l?=
 =?utf-8?B?Tm8zc3M3bmdtQmJTeHk0emM2YWZPQUFSMm9FYlhWeUxIMXYvWmV4TlZ6cStj?=
 =?utf-8?B?cGtvTWZXYXBOR1BqRkZrMXNNdjZaa0JqVCs4OWppZXpjTVlUN0dFY3F5SFJX?=
 =?utf-8?B?QmxINExHN05GcXFjTVg0WGRJczUzenhVRU9ubVo4WHBHU3hOOVdaNE1nRGJU?=
 =?utf-8?B?aGR5RFBldzd0YlUrdjFBTmVDTnZmMllnVjBOVXhCYXpySDJ3OGdOT3A1TEpy?=
 =?utf-8?B?SXdSUnlmTWxYU2ZlbmkzQytEbFRYazBLUFkrZTZIb0d4emVjRVdmNk9RUEtH?=
 =?utf-8?B?bDlxMUF4YzE4MGI5dFZaM05Ga2Q1QjZJeGgwVU1NdktscXc0UUM4R1kwQnBC?=
 =?utf-8?B?M2RUWHYvTUpoYmVkRk92QkZncW5oWWwwaGNSUWZNaXJabkdTdzNyRWhVbTFi?=
 =?utf-8?B?MUtTeTdZejdXL3RvSkVWOSs1cmhBeEhINW9RdEEzcGhDSjhmelJVMnk4Sys5?=
 =?utf-8?B?Y0tEOUtLQ3Qzb3kxNjBzSGRCZ245encvSDJvd25JMC9SZkNINGYyMHBNelU1?=
 =?utf-8?B?dktyVU0rM3ZYZVI1N3c1MGIvMzh3dW9TUEYzT3RxUVBiejRWSzl0My9OZXhO?=
 =?utf-8?B?dXZDdWhWTDlBWlVVR243MkhoSzNJNjllQlYyKzlLL1pXVW1HK2NQY1UvREpT?=
 =?utf-8?B?Ukh2L0RvZWhYZUR4dklMQkVJWDluZUo1Y1lLUFc2cHNJV1k4VU83Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c5b3ec-36bb-47a2-197c-08de64f305fe
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 20:13:27.5412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kok94Ulz2THC0WMJOBEgllz5suWiw1cCLBbmGvBFkH5dIxQGzeO1sDm2p9aIk6B5NYn8hH8WRn8AD6Atjm6/Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7247
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 05 Feb 2026 20:13:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3195

Patch looks good to me.

Reviewed-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>

On 2/3/2026 7:35 AM, Charles Dias via lists.yoctoproject.org wrote:
> From: Charles Dias <charlesdias.cd@outlook.com>
>
> This small series updates qemu-x86 to use the generic q35 machine type and
> documents how to request a terminal-only console via runqemu.
>
> Context: https://lists.openembedded.org/g/openembedded-core/topic/patch_runqemu_parse/117568097
>
> Charles Dias (2):
>    qemu-x86: update QEMU configuration
>    README: mention runqemu nographic
>
>   README.md                                  | 5 ++++-
>   meta-zephyr-bsp/conf/machine/qemu-x86.conf | 3 +--
>   2 files changed, 5 insertions(+), 3 deletions(-)
>
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3175): https://lists.yoctoproject.org/g/yocto-patches/message/3175
> Mute This Topic: https://lists.yoctoproject.org/mt/117616207/3619217
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/14411013/3619217/657730681/xyzzy [sandeep.gundlupet-raju@amd.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

