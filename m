Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911C0C87FCF
	for <webhook@archiver.kernel.org>; Wed, 13 Aug 2025 19:08:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.65])
 by mx.groups.io with SMTP id smtpd.web10.4670.1755112127424785170
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 13 Aug 2025 12:08:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amd.com header.s=selector1 header.b=yF6XoM1K;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.244.65, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSON6OcTURsfoeOUNNfVx4V3bWyWDWsxtpRiBN8muP38vpmF2VvcJwdiIoKP2mN43Up3NeOH4E5SX2gXafzs2HOlHybp2s3FbkocYSsgfEIVNsBXsUuDG1UzPE8KnGujPev384KIBfHhr7ZfX4WaGgGj4vYFMKQdJeuPqod6CxkYwUBU/B52GRAqTLFfn4U6L2KWfS8OnjHxrYDOv6CvP4voQ1oWa/2uW1TqwuGLOHtztIxEJmhRTxHHhcZXmymzYQOhDfhotXjB+/jpkifvB9Jkrt5qO+veMD4wPc3S0djaMCZhFuud/T1bi8+Wc7S5h2G8V1jRnqAC0iV6bfXc4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1eQVOdapIen4QWPO6iSERc6S3mWEPbOZ+j7q5D3T0I=;
 b=Kd7gn4TRmUGFFuv3lXkXAsRT+at09qRQJ1SPBWUXpi83WJ86bXy8rHe2KV16Jb4bY/8Vi209ofxpqOWKJIWV5VDm33SpIMoep27mpo/t1jIJ5VJ8nsWuryFwXagIEc6lB9K4EG6PgcccGCmAe9V0t1kPth7hG4h2JIYaN+jtDq4jbBVqZXB1t6Z2DqW1V0R1hUHsq5KeYJx65qgwonivBsTyXqKx4REoLyjuuy6eEWfFv9VkHDVIfdBkr65XwhFTG7v2wDzkbbbhCkeiwCBkVL56m0JpeRRjGzLW5PekvFYOULCGFZsGgJzsFcwZStsanl63ltfY64CXp0ZZCNeTmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1eQVOdapIen4QWPO6iSERc6S3mWEPbOZ+j7q5D3T0I=;
 b=yF6XoM1KrPhwnnfrAtIou5n9YBAuBxxZquv7CBSukxmPQo8JILf3Lc6UISz5rFLA1+BMjDyTsmXXqx3TjIyr0JldLx+toB4szErMkdLirNCgj8GxoChPUlXBKgbXRj5bcEzOWWeiohF4cpvNLqgY29ql0rRehd6c/iBuJ6mAgzE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21)
 by SN7PR12MB7024.namprd12.prod.outlook.com (2603:10b6:806:26e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.23; Wed, 13 Aug
 2025 19:08:44 +0000
Received: from SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7]) by SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7%6]) with mapi id 15.20.9009.018; Wed, 13 Aug 2025
 19:08:44 +0000
Message-ID: <f65a72f4-a9c2-44de-b3a2-9add36e59bcd@amd.com>
Date: Wed, 13 Aug 2025 13:08:43 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-zephyr][PATCH 1/2] layer.conf: Update to
 whinlatter release series
To: yocto-patches@lists.yoctoproject.org, chee.yang.lee@intel.com
References: <20250813063904.3141303-1-chee.yang.lee@intel.com>
 <43b396bc-986d-4244-a6dd-61437de53cac@gmail.com>
Content-Language: en-US
From: "Gundlupet Raju, Sandeep" <sandeep.gundlupet-raju@amd.com>
In-Reply-To: <43b396bc-986d-4244-a6dd-61437de53cac@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CYXPR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:930:d0::11) To SN7PR12MB8770.namprd12.prod.outlook.com
 (2603:10b6:806:34b::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8770:EE_|SN7PR12MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: 128c2181-7264-4145-1c01-08ddda9cd316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|4022899009|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?K3ZSSUJjeU1jWlRiVit1dTlCWFlkQW4va2kyU2tLd2lhTmpzbEZ0TitwZXhQ?=
 =?utf-8?B?ZEZDbjF5L3Y2cm01QzQzQmxtWmlkVFNXMmZRUnRqZkhYcHF5MU0vMStMVG9s?=
 =?utf-8?B?QmR3WGxpRVB3Z1NjV3d1cjl0ZDNHQ1lxTDJQSEQ4RHRMT3pyRFhySDZwNnVi?=
 =?utf-8?B?bW44eDJVOGRVN204ZGNsRmh3K0svd1RrZGxhWUNBSlRLRzFMbWx5TE8yTHdC?=
 =?utf-8?B?YXg4akZHY0ZwckUrNFpDTzhyNWpJOHo3cmtYdnJySTI1UDJ4dzVscHJtOHdG?=
 =?utf-8?B?dEd4d2JZL1VxU3FHMG5aaVhwMVlBMW1yM05icGZjWFAwZjhkVkRpMXBaZW5X?=
 =?utf-8?B?ZCtVU3JqTnQzaXlHNWRqd2ZneXRwRnQvODNBUTZvMkhXKzExTW9SOXovMWp3?=
 =?utf-8?B?T3BsNWR3d1d4NVRYeUNNNkF4dTFHemZTMFI4OElCK29wSW9DdVNUd1UrQkdN?=
 =?utf-8?B?TEVTM0h1bEpGTkc5dmhzd3d0SFFVV3dZRURtYXkzOVhIU1BiUVhTQUNLNC96?=
 =?utf-8?B?dTdKSlA4WjFaMytHdTJvRnpFZnRKRmJXdGZjTllxVHh5ZXFjQWp2dDJCcTdw?=
 =?utf-8?B?VHdJa2xneGE4MU5kOUIyOXU0NEszanlHNnEwb0tCcDIrcVJKNytMVXhNeHNM?=
 =?utf-8?B?Y0p4Z2RoVVd2T3BHcnhqOVVMVmM4UjVLcjZCRlJxbkFCb3BCVHRyS0VmZDIr?=
 =?utf-8?B?QzN6MlpINFZyZTZwTUxwTi9lUjkwSE1Ia2lSQ2E0T2RFUWtFUjZORTk0clMv?=
 =?utf-8?B?dlhTSE5SU1ZwdDNjU3pqT1pmQzhnU2tmOVZlZVV6K2dGWmJzVU1DOFFlYkk2?=
 =?utf-8?B?eHdKSmFjbnRCeDRWeTlxYU5Ud2tzcnBla1E2WEZlNEQ4Sk1jWGozZkpESnAv?=
 =?utf-8?B?dU9Sc2c2OWZuMEVoM0FPRjVyRG9RdExjdm13OXkzMHJZSVVVdUJrZklWMXBE?=
 =?utf-8?B?TktoRTZNRm41UXNMekFhZDArTk4xc0ZLRHg2Tkhtd09QaW9sZ2Rvd2JvTFRC?=
 =?utf-8?B?REVWdElDWWF3c1RkbVkySW56OGt4OTZ4TVNudnBlRDJ6aG1UblNHcjc3cmwy?=
 =?utf-8?B?aGN0TlZ4QkNCRVYzQmQvSDI3MXI5TXVEcGNucVlZazJvV2tORGN0TVBmd1g3?=
 =?utf-8?B?Z3YvcGpScC82cFRUMnFFOGVVRnR2ZDZhN3pSZlhQQ1JCeFRxbDVuU1RaeFc1?=
 =?utf-8?B?UHhydVF3ODBuV0QxVmRtQzh1NGEwd2NibTdIZEpKdlJSYXJjUmw3U3FwUlJa?=
 =?utf-8?B?UHFPY0gxc0s0RDNGSWJndzBHT2phQmxhSWtPV1Z2dHM3K3FGSnZnTGU4RFdZ?=
 =?utf-8?B?Ukt2THlQejU2SnhPZ2pxUzZ6VkFZaEFCamMyMEkxbTlaTHRyc2VLNjZvMm5o?=
 =?utf-8?B?bXJjczc4VU9QbVBSdWFJSFl6S0tMa25yY0s4TXorb0tzTEhoQkQ5U21ON2Zy?=
 =?utf-8?B?T1dKSUtiVnZpdzFTVU5vbjhRZmdsbnA2cHMwTUxNSVlVdTNBU1ZRUVJpanJJ?=
 =?utf-8?B?clY2aW5rZ0lvZzFpbFFCb0xoTmJDQUtQV1czS1hwKzBVeTZPZGhkczJSdmR3?=
 =?utf-8?B?TmNLZ2tRcmZoNFRIblkzNzBIN1FuanVhTXRFNUJ2RUJEVURVZDYwMDJzTGNl?=
 =?utf-8?B?TlJBUGtlYjFXVVpPVktGL3kyczQzc04vM1NiYnZnWFhLc2x3OWp3MitaQzRZ?=
 =?utf-8?B?cXpTd1Rodm10TmQvMVorK1ZlQmw0NCs5K29qRGpCMjJiR0NDMGVYRkVrc203?=
 =?utf-8?B?UFE4am9yQS9yZCtvWERRc0o4d3VsNUNtMTZtanJpUkw0ZTl1V1VEbStGNUZi?=
 =?utf-8?Q?ynM/8pINZqAY2Uo32U/NTS05b1jm4GySEtaco=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8770.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(4022899009)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZUFnbmtmUGFnWUM3T0VwVWFtd2xBajNjRHA5OFUwcWpabUNOTlphMUZnT2gr?=
 =?utf-8?B?enlna3lObEtoUmUyTW9talJ5akFIWE9FWlhkL2hJQXRuYzNXTDZKVHQydVBj?=
 =?utf-8?B?RndwbUZ4YkVncXVmeDRvcTJSNjRORjBIbC94M2dUcWdWdkNleURPVUJ5b0Fj?=
 =?utf-8?B?MjlJaXdvMi9VMEdLdkNnNXNHN2tUT1R3Q256MlF0aFowK2wxYTFSV0NtSkdC?=
 =?utf-8?B?djVMeHRXSmQzUzYvdk5XSWZyYllQTXJEOVZmaHV5VCsrTDRXUjFKdzMrYlVk?=
 =?utf-8?B?NFRjMExmTnBHVGJRNDJ0bUlxMzhwQ2FZU3lRazRyaDBsb1Y3c3dxVWdiMVNI?=
 =?utf-8?B?dCtNZkhlYXIzM0YvWkVHamsyT1hTVDUvN0Y1QmZsUW1GYUU0WVVFQ3pIT2F5?=
 =?utf-8?B?U01LaWcxMmI3QkxxNjhDSXpqdGVRMG9TZ0Fac1pJT3I1eVlpT3dvaGZhaWF1?=
 =?utf-8?B?QUl6eklpc091SWpWY2p5MWdvem0xVFdob2lGdlhwaFdJQThHczMrMVFGWTN3?=
 =?utf-8?B?aDVmNjZvT3ppUm1YY0V1Z1BITWhnaGdxRVdDeHpGQkhWaFF5aWVsRFB3ZDdS?=
 =?utf-8?B?bG94UGFVYzVDY2NJQnJwQ2tMb0xNM0NoRUNCMEIwa3RtRnphbjN4eXZOQTZJ?=
 =?utf-8?B?blRjdGVBT1NBTFVOTnRDdmJISHQ3dzdwYkRMM1FjclpycklLK3Y2VWw5Mk9B?=
 =?utf-8?B?QTYxVmswTnlNS2JUNVBod3M1cWYxZmxrbUpwUDBHSmlhOU5JWlArL1d6WTQr?=
 =?utf-8?B?S2ZBUGg5cDhqZ0N2Q1lFL0kwQ1hSSlM5NC9TYTlQWWhzcWQ5L1V5N2NaL0J3?=
 =?utf-8?B?YnVaSXowVFoxRmY4NHlDOVJHbjJJRFhIUGNpM2dUQmc3K0VoRTN4YmI0Z2lR?=
 =?utf-8?B?MWZtMTJ0VWt1Q2VXMk1WMVp5S0pjZkVVU0NuUXlCWmpuYm5tMitIY2Ivd3NI?=
 =?utf-8?B?VEo1QmxQU1JqN2pMR3dHelBBSmZRZFlnZmZ0dzFvcU9LRjRSVXhUTExuTDZN?=
 =?utf-8?B?UXorS1l2ZUtGUVJaaDkxdkZzN0JBSlZueW1XUXcwci9henpHRHc1VWJIZUZj?=
 =?utf-8?B?cURpT3JXdVhQbTVuc25GZTdWcTZBenFucXlFNU1wMHdNaXVUYkNaYXI2UDJh?=
 =?utf-8?B?YTRZYllDMUQ1azRpU0ttbHBIb3pId1JqT0FYU0dSL1NxQkhxREhneThtdWpi?=
 =?utf-8?B?ZFBIQ2pzQU1TYjRpMkc5dENrWWQ0SHcvaGFjUmNSb2ZqRXFtWlQ3bE5mWFBn?=
 =?utf-8?B?ZXBacGZNQjhKeHp1M01tT3p0Yzh4eUNBRURxYkZOVE43aUl0bVBEWmVZd3F1?=
 =?utf-8?B?UWE0YzVKMWNXaEN2S3YzQTU1NVZMOW4vbXhXSWtBaDFtKzRNQjNRUXROT2RG?=
 =?utf-8?B?YXAxdW82WTFGRk10bitURWhzS2gxNHVrUjFYV3ZjY3JzU3UvTk1WRDFNM21v?=
 =?utf-8?B?ME9mQUxUUWovOWJzV3RweEE3U0hkcGV4SGszbmVkUkRCR1p4dkxtdHhMdHhs?=
 =?utf-8?B?QlZaY05ieU4zRmJkZlozdVNZVEJrQ2hyWE5ZbUxZR2ZQVndaZEZmdjFMRW1l?=
 =?utf-8?B?bStoQ1drQ21wNFAyN3R1ZUgwSlFSRjIraUtqUlVlc3JPdHBEbDAvdHJLbVNj?=
 =?utf-8?B?RlpmRzl1MDY0ZEFvRUNpMndET0hQVVJ2b3JSVE0vdE9aVXdqZndiSzFVUzFW?=
 =?utf-8?B?ZSt6ckNaZU5obFhZaktvUjdrTjlWNEFJYlRxVThyZGZJZTBHWjMxUFQzS1NI?=
 =?utf-8?B?YTNPa3B5Z0p5NE14cFA0M2xidllzeTlML2ZMeFBZL2QvMFpSYjVsWFRzUTdI?=
 =?utf-8?B?NDAxTTBWQ1ExdThNZlMvMjVndDQ2ZWRDYUw2UnYyZk5vekxGczdNR2RpVTRk?=
 =?utf-8?B?Q3RxWjNUNWNNNTFpS0FyL1NZaEVUYlVMaFlvbTNnUWJ0WTJ5ZVVkUmZ0RlJT?=
 =?utf-8?B?OEJoQ2NkZTF6QnhmbVJxWXdMbnNLWlRTSU92eUVnZzRrcERJT21pRk5iYVdE?=
 =?utf-8?B?SWxpMkNBL2MvbXpPclhUMU5ucVVpK2kvcEtLemxDNFVnbkFMNktxN2tHM0Zi?=
 =?utf-8?B?eVJudzE2MnlHTWZOSHA1NFFnRVE2NjF0ellmSHhXMGdReFZsRnVDTjhIZVM5?=
 =?utf-8?Q?1OQKv9Zd/tjXCeAy1Up1IU4uD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 128c2181-7264-4145-1c01-08ddda9cd316
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 19:08:44.8871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aM2AiAb4s8UUxK1gniTNe4MOcFVqIsg1Ykt82rxQ2bo19fZTfFukbLB4ZSgUmqZmmFxVu5mYDwvda+HHPxApoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7024
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 13 Aug 2025 19:08:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1985


On 8/13/2025 2:00 AM, Gyorgy Sarvari via lists.yoctoproject.org wrote:
> On 8/13/25 08:39, Lee Chee Yang via lists.yoctoproject.org wrote:
>> From: Lee Chee Yang <chee.yang.lee@intel.com>
>>
>> Signed-off-by: Lee Chee Yang <chee.yang.lee@intel.com>
>> ---
>>   meta-zephyr-bsp/conf/layer.conf  | 2 +-
>>   meta-zephyr-core/conf/layer.conf | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/meta-zephyr-bsp/conf/layer.conf b/meta-zephyr-bsp/conf/layer.conf
>> index 60a0a80..52d9938 100644
>> --- a/meta-zephyr-bsp/conf/layer.conf
>> +++ b/meta-zephyr-bsp/conf/layer.conf
>> @@ -15,4 +15,4 @@ LAYERVERSION_zephyrbsp = "1"
>>   
>>   LAYERDEPENDS_zephyrbsp = "zephyrcore core meta-python"
>>   
>> -LAYERSERIES_COMPAT_zephyrbsp = "scarthgap styhead walnascar"
>> +LAYERSERIES_COMPAT_zephyrbsp = "scarthgap whinlatter"
>> diff --git a/meta-zephyr-core/conf/layer.conf b/meta-zephyr-core/conf/layer.conf
>> index 3482c6f..11a5bbd 100644
>> --- a/meta-zephyr-core/conf/layer.conf
>> +++ b/meta-zephyr-core/conf/layer.conf
>> @@ -15,7 +15,7 @@ LAYERVERSION_zephyrcore = "1"
>>   
>>   LAYERDEPENDS_zephyrcore = "core meta-python"
>>   
>> -LAYERSERIES_COMPAT_zephyrcore = "scarthgap styhead walnascar"
>> +LAYERSERIES_COMPAT_zephyrcore = "scarthgap whinlatter"
> The second patch in this series (S/UNPACKDIR fix) makes the core layer
> incompatible with Scarthgap, should be Whinlatter only.
[Sandeep]: +1, UNPACKDIR variable is not available in scarthgap, Chee 
Yang, I've already staged these patches in my master work along with the 
scarthgap patches which I sent. I can send the patches or you can push 
your patches to master then I will rebase with other patches. Either way 
works for me.
>
>>   
>>   PYTHON3_NATIVE_SITEPACKAGES_DIR = "${libdir_native}/${PYTHON3_DIR}/site-packages"
>>   
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1981): https://lists.yoctoproject.org/g/yocto-patches/message/1981
> Mute This Topic: https://lists.yoctoproject.org/mt/114679802/3619217
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/14411013/3619217/657730681/xyzzy [sandeep.gundlupet-raju@amd.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

