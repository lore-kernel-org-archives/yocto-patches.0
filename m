Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A285C5B552
	for <webhook@archiver.kernel.org>; Mon,  9 Jun 2025 16:00:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (NAM10-DM6-obe.outbound.protection.outlook.com [40.107.93.57])
 by mx.groups.io with SMTP id smtpd.web11.62961.1749484803206239080
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Jun 2025 09:00:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amd.com header.s=selector1 header.b=RbS0Lz49;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.93.57, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRXglSOxSHU9FZhtAvMm5d72YQ8sRWj3KTgVX4W1yq049zkwR0FIpF2SImKx5Of/u62nXu3f1MOOYadGSDpx3IboEhq4rBgEWrGiqdvIP4ilrUzwgQFXe8nLvqjTv2017evIbCYMiEQBNZj1IoVmg3zKeXUAloCrtQ0aqXPxT1hMMVtIcX/ZO0xydZXRs9BCtcEPMzRjsIM/KHYbtVCvYTAQBTBpOhX/nbBJZjDr1E7OsUT8Z48MRzN1dNq3I2V772uSra8Xjy0aGcu+Y2teHelOzuTHuOKbDWK7qPccE2hLsuUwOakKrPyQVDWFyULlN3WA3uD5XQc4LaFhHsCblg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pe/envQ1gM31tDmj/QKNSjc6+HuYHn9xgYaHA5L3NGE=;
 b=Sj31N3Ppg671MiNZv2HLV8uEGVzRsvjhmaBJpw4lqXvIyglzZrN505mlCiFmYbUm7OCU57P1zTW+dEM+2ASZ35rdZQRodtT35DBYmk9OcKl1glNSVeXRkFANVX0R9PQQkRpf8zx8lyX0NLg0/Op795uKMUGRzRZXbZDTrYnWbqfb52F/lCBU5Y/ipUvc+/NnpO9A13oSWqrXvb/ji6kqmgZe33Twp0Tzy6M7xSgrpcqq+OmSIhtUF9XDMMYG90byd4H+EfxrJf8qveisXWAqcz3p5WuuSrhWuySadi3lbmsEJ2FAKYmD1lSjhlAyR3ZjHvfQCclEe+DoB1O86rVvNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pe/envQ1gM31tDmj/QKNSjc6+HuYHn9xgYaHA5L3NGE=;
 b=RbS0Lz495wr78UWd6MM6IldHWgyn3+RgOzArYDF6w+V9r/na8HVL6YHod70gUKLoaZAJYmGJrHULQ0rXOwF69Ygmkfp6BGdUzoygLDO/JmABKCu0PCub4wTou4/TCxJkRdqMD/Y5bHmSzD56bYzIWpMFrbnOsjRCU3TAtWAo4RU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4357.namprd12.prod.outlook.com (2603:10b6:208:262::19)
 by PH7PR12MB7871.namprd12.prod.outlook.com (2603:10b6:510:27d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.38; Mon, 9 Jun
 2025 16:00:00 +0000
Received: from MN2PR12MB4357.namprd12.prod.outlook.com
 ([fe80::fb07:a830:460:38fe]) by MN2PR12MB4357.namprd12.prod.outlook.com
 ([fe80::fb07:a830:460:38fe%7]) with mapi id 15.20.8792.040; Mon, 9 Jun 2025
 15:59:59 +0000
Content-Type: multipart/alternative;
 boundary="------------kYH7QvEIwM0cNRet4dHzhnlp"
Message-ID: <63a0aa22-ccab-4032-a887-54d5e7d73ec2@amd.com>
Date: Mon, 9 Jun 2025 09:59:57 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-zephyr][walnascar,scarthgap,master][PATCH]
 layer.conf: Add LAYERBASE_zephyrcore variable
To: yocto-patches@lists.yoctoproject.org, will.lee@altera.com,
 anuj.mittal@intel.com
References: <20250605032306.3073101-1-sandeep.gundlupet-raju@amd.com>
 <BL4PR11MB8797361F43C6718A631EC6DAB96EA@BL4PR11MB8797.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Gundlupet Raju, Sandeep" <sandeep.gundlupet-raju@amd.com>
In-Reply-To: <BL4PR11MB8797361F43C6718A631EC6DAB96EA@BL4PR11MB8797.namprd11.prod.outlook.com>
X-ClientProxiedBy: SA9P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::13) To MN2PR12MB4357.namprd12.prod.outlook.com
 (2603:10b6:208:262::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4357:EE_|PH7PR12MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f9e80f1-c5f0-4003-74e2-08dda76eafe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|4022899009|7053199007|13003099007|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OXBvRHlzbGtIRDhFUllIc2xVKy8rYzE2bHVmdEtPUmNkV2pGMldJTEltbnV1?=
 =?utf-8?B?b2FvamdtQmdoenNGTUFLTzUrQlZTRXY4Nm8rUWY5Mk1hWHBiaUQ1cjZuRkU1?=
 =?utf-8?B?RU1ucWg5cFJ5RHF0UnVuRzR4U29SMjhqdlE1cTBwTE5PQ2NwZitMWGk3Y3FC?=
 =?utf-8?B?Z3NlcS9PYllpdXVaREM0L0J3MlNzUzF3SE5XazZ6TDREcVh1ZlJzU1I4WFA2?=
 =?utf-8?B?cmMvWkxaSnhUaFk1ZEcyNnFXNG11UytEWDZlUjV0VzNDKzQxRGNsT2RRMmk1?=
 =?utf-8?B?M3V1RGQzTkJPWjRTa0NIcitRaFRwMEEvUTZ3aWZvRXcvRUd3Mi94VFRXdXRR?=
 =?utf-8?B?T0ZCaG1yajRBTitYL0l3VlJRWmQ4UzhoMjJURCtlb0dUWUJFd213ZzBRaURt?=
 =?utf-8?B?Z29RVVdoTFM0Q3R4bDliOXVBZHlKamZUR0g2YXBpUjVCbERuOW40TUc5UzB5?=
 =?utf-8?B?eG5UY0FSTE5VMmdGbVJQRXhXdHNKdGNLaGhhZFhsOWdNelAxMXFYS2UrU0M5?=
 =?utf-8?B?U0VnbUhZL1ZYZjhFbFBXamxyYlJWV2pHaGQ1MURBZzdDUXQvVm1jNzNjZ3Fa?=
 =?utf-8?B?RGhOSE1lOExWY3pRZ1JBYTNEaXNGaVZpOHdiQmY3bkRwWW14amkxYzl3a2dG?=
 =?utf-8?B?RXJFaHFqN0QvOWovWkl1VWYxNU1aNEdwV0k4alIxUzg0R2prZy9SVWhvKzk1?=
 =?utf-8?B?TzhkdUptS0tBMHp2ZHdvME5MQ0o0VUVuQklLQ0srdlRtL2R1WXdzRW9IZE1B?=
 =?utf-8?B?UlJoak1Id3J2Qk9xNC9CVkJLb1NEbHZqMnoyVWk3RG5OWjVNNFhnSGNnNVMy?=
 =?utf-8?B?L2VQVDFNOG1yeU9OWFZ4eDNMZk92MzNRQUErWmc2REo5S0IrWWQrNXRFQlYy?=
 =?utf-8?B?TVVYQUdJZ2hPNGkxTW5VUUoxanlqMG52NDN6cWdqc0ZsTDdIOW96aXdxRGRq?=
 =?utf-8?B?dEIraytXenprNzY0T2RCRU9LWWZxeTN4TVUvYVVSUUt5eFpYYUpId1VWQzdt?=
 =?utf-8?B?SkNVMnUyWlpmSFVQZGRGTTMvVFp1TzhPYUJ5T3JIQnNXRVVOOVpjR3d1bWJ1?=
 =?utf-8?B?dGRZWExiQ1UrUll2cXpualRwUGQzTzYrOE9XQzVUdVYwRDNEemdFTTQ3VXZr?=
 =?utf-8?B?VTlEbXQ5K2IzMmpkK2I3eTcxSHdxOUxKdFdPbi9JYTdJazZ6QUNOTUdQYzN6?=
 =?utf-8?B?eU53eFRjQXFrTjU0Z0dsRXJaSGZ1TGJZWEx6aFBZN2V5cjVwUkEwU1VwNmJu?=
 =?utf-8?B?Vms4ZnNNVWtHZUMvYy8zTDJ0YlhxTzVSbzFBWmRHdnQ5MzBFSGlBaDQ0VE5J?=
 =?utf-8?B?enRFSnU3bi8wTGRmSWFobk9XN1R3Q3NtTjBGRHZsMlZpSnpub0pmRFlsZ0tw?=
 =?utf-8?B?RmIwNmJHTUs4QnMvV2VPVXh1dW92WXRMTG5yOGhjUHZieHc5WmF0dFVpS2hP?=
 =?utf-8?B?Tzk5WHVaZjZ2djZWMlN3Z1BHZWw1T3pSei90ejB2VVd0dWdCanBKbHRkZmV5?=
 =?utf-8?B?bWtJQi9tVFAzaHF6OHBqd3lkNlhLWGxDemJ2Qkk4RndHaGRneXFFWDBOWGFM?=
 =?utf-8?B?VTdzcVB5K3pTOHVKelBrYzBUeXBPOWxVZ0tZcEJtKzI5bSs0eWV4MUZ6QzRv?=
 =?utf-8?B?U0ZhOEkrNTBjeHQ0VlUxYVlFbjVsRVNDZHB4aFFiK3JyM2l5UWlzOXBZNmhr?=
 =?utf-8?B?VXdKZlhJWENpMGFxcWJPVzcxSE1BY0N4cWVWZWJOTEVhbFh2cGFIelhWQnVJ?=
 =?utf-8?B?VDRjWlNuSEluV3VqdmhSUUliNEh4bnhlYURXMUR4WHFlUUNaaHorVkdkeVdz?=
 =?utf-8?B?eUdzNDFvUld3ZGxheTJ1L0tVUkgrKyt1UGlxTWVRZGZKZmwzcTdZRCtwNHRT?=
 =?utf-8?Q?2CjpcTCBH652w?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4357.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(4022899009)(7053199007)(13003099007)(8096899003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UllXK2M2SjhYbm40c1grb2pzSFc2N0xlZDlyRFpiVG9KSGNtazV6a1loc0Zq?=
 =?utf-8?B?ditrOFBzcnRxRTdBSnpJd3lRM2RrZEkzNDdkNUlrS1BtZU5VSHRBenJGOEpo?=
 =?utf-8?B?a01UZGpIenBiRDZzbWkxeVN3emIySXBEaVlLMTZhajhpZmh0VVNQUUJ1T1VX?=
 =?utf-8?B?SVR3cVd2bUh1LzhPSEJqaFZ2Vy8zTmJvRlVSL0FsV29uUmlHeGM1WDAveVly?=
 =?utf-8?B?VktGRzVrTUlIRWNHTVV1dGpkRWt4T20zak43ZS9yMGxGS3A5ZHVtSnE4K1d5?=
 =?utf-8?B?Q3ZwNGFCaXhhN1U0OWo1SUIyUVB4clNoV2dOckhBdnpwd1NCdlh0RHlQMnpm?=
 =?utf-8?B?cTVkU0V3UW44US9ad1ppS3VVNitrN2k3a29iZzJIcUpvQ2UycG1sNWs4Szg1?=
 =?utf-8?B?QTFxMnlYNHZwWGRnSytGUnJrY3VlanFuYm9IWmhydzk3aDFJWFJESG5pK0k1?=
 =?utf-8?B?K0xvWmhBVUdNUmZRVFVtWHQvZ1B2bEwzd2ViYjBrKytTM3gvUFl4bDZQM0lw?=
 =?utf-8?B?MFAxTGRtYXlmUjJmTDBSS0lFVk9oTFFUbDhRZ2ZrcGNvU1NjZ1lmdFZWV0do?=
 =?utf-8?B?dkZtSlZpNmZtYmUwc2ZndHRyTWNwbCt1WG1TUlFlWEpKSEpwNFNTRHZCaEdk?=
 =?utf-8?B?QkxUOW5vZGVadTlBMDMweS9OeHhsMWJOVGtmTnVHL1FQaEpXbmorT3ZvQXlr?=
 =?utf-8?B?QmlTTkpKL0pJUjBUM1Y5UFBoaGcyVHdENVZ2M3IzMS8vVXZibmhuQmt2OHZu?=
 =?utf-8?B?ejZ6THlVMFJPOHNmNk8vNis0cTJOMk1UU3ZWQWQrUHVhbStsbzE4K002dGJO?=
 =?utf-8?B?N1VmM0hsWXJYbEJVTW02aVBld29uY3ZwTmhDSHd2U3dGNFlpaXcvaDZyMCtr?=
 =?utf-8?B?Sk9CMXlKWlZwallTNldKZTdzTzlOMFlDUXlEVlZmNGhOdS9TV3VSYWc5SWVp?=
 =?utf-8?B?SmplbjYwalh1clNuY0FYbUhscUVEeXBwbGZYVFB0QXp2QkF4RWxBQyttYThY?=
 =?utf-8?B?WENYM0tEWHJKTXhla1ROMTNzdytWMzJ5TzFLa0JKUlpNYXlZbEpyVGJycVBG?=
 =?utf-8?B?WVV1dFNYSzZvVWtQWHZjeDlZdUw5aTh1dkxQcHQ4WU90b0dOeVVoME9MWWIv?=
 =?utf-8?B?OXVma3FjZDFSa3E5VXNodW5vQkRXZTBwM1pDZzg4UzhkdGlrdUxGcDVRRWxT?=
 =?utf-8?B?V2xSMXRRUFZkNGhUUVRacGg1T1JNVzQ5eVgxempLdzd4aldOUGRXL2VqM3Fh?=
 =?utf-8?B?dnN2WEZSUERIV0VWV0xWVkNlVEN3YW9OYTI1TlBuaytWQmhLVXFUTUFNdEJX?=
 =?utf-8?B?ejR6dFJWVjVPVUJ6bmJ0dWZaUGZhT2dYV043aGV6cUJKTjRGOGRHSlM1OTVz?=
 =?utf-8?B?SVk3OHErb2FjeDZKdnhzdzNpRkFTdmpUMng3czZmbXVhWndCaU1QbWF0azVm?=
 =?utf-8?B?aERLaEtIMHkvOFlRTm45c3FsclVHUDZObFRMODZ1Z0NwaGNDcnNIVWxETWd0?=
 =?utf-8?B?eEZjbDB1MDNQcmoxWmhWd3JNTWZmSzVWeXh2aDlpdnppQW1GK25BT2k2cERu?=
 =?utf-8?B?SHNVTGJFYTV5a2RrWUxEc3lIazJ0bis2L2lEWTUzTGJGZnh4M1R5OVc5WTlG?=
 =?utf-8?B?Z2d0TXU1Vmc3WjBaeU0zOThjK2xMQlBYYTI4dk9CZEdNU0Q5RS95MDIxQkhk?=
 =?utf-8?B?TWRmTExJeS9qT1lZc3ovb0ZVaHllbjNPQlpEdzAzcHhEZVhEN0R0UkdkTWRO?=
 =?utf-8?B?RC9RMTk2NmQ1REM1ZzZ3LzVybEtvSGVQbDY5U2VHNFE1dUgrY1VXQWI5cE10?=
 =?utf-8?B?Y0c2ejB0Y0VRUEFzNUQ0ZjNQdEs5ZVNhVzFUN3plczkvRjNUem0rNk4xN0dy?=
 =?utf-8?B?M3h5VStNNFJNMUlWSkZ4TlBwQzJVUkMwZnlmNGY3NXkxU2Z6TGNxVGpzSTF4?=
 =?utf-8?B?TkpzZzhGUmtHcW9aQUc4T2VIbmhrT0U0SS9SVGxabzM2c0NCQmdxVlZqekFR?=
 =?utf-8?B?VWRZcEZPR1NFUkFhZ1hvT0FubFZRd0pRZXhGVGgrS3VwMEpDVkdQeGo4WDBM?=
 =?utf-8?B?Skl0Z0tWMTdBM0VjNGErOTUwSVZ0b3FEM0tvaWxIRDJSbkt4a0gxWWhUKzRa?=
 =?utf-8?Q?1PFwp5/H4hwr46p03AoWxJkTS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9e80f1-c5f0-4003-74e2-08dda76eafe0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4357.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 15:59:59.7763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/GAMx+R5yU/QNh2vpoHBxFwWHyZRVw/ruA2WT9wRmsqH6bElAqgFqhxwb1J7a5KMqB8DNIOnlbbJU2jUchLrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7871
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 09 Jun 2025 16:00:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1625

--------------kYH7QvEIwM0cNRet4dHzhnlp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/6/2025 4:59 AM, Lee Chee Yang via lists.yoctoproject.org wrote:
>> -----Original Message-----
>> From:yocto-patches@lists.yoctoproject.org <yocto-
>> patches@lists.yoctoproject.org> On Behalf Of Sandeep Gundlupet Raju via
>> lists.yoctoproject.org
>> Sent: Thursday, 5 June, 2025 11:23 AM
>> To:yocto-patches@lists.yoctoproject.org
>> Cc:naveen.kumar.saini@intel.com
>> Subject: [yocto-patches] [meta-zephyr][walnascar,scarthgap,master][PATCH]
>> layer.conf: Add LAYERBASE_zephyrcore variable
>>
>> Add LAYERBASE_zephyrcore variable so that files from meta-zephyr-core can be
>> accessed from other layers.
>>
>> Signed-off-by: Sandeep Gundlupet Raju<sandeep.gundlupet-raju@amd.com>
>> Signed-off-by: Sandeep Gundlupet Raju<grsandeep85@gmail.com>
>> ---
>>   meta-zephyr-core/conf/layer.conf | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/meta-zephyr-core/conf/layer.conf b/meta-zephyr-core/conf/layer.conf
>> index e1bb263..a4b3555 100644
>> --- a/meta-zephyr-core/conf/layer.conf
>> +++ b/meta-zephyr-core/conf/layer.conf
>> @@ -20,3 +20,6 @@ LAYERSERIES_COMPAT_zephyrcore = "kirkstone scarthgap"
>>   PYTHON3_NATIVE_SITEPACKAGES_DIR =
>> "${libdir_native}/${PYTHON3_DIR}/site-packages"
>>
>>   addpylib ${LAYERDIR}/lib oeqa
>> +
>> +# Allow other layers to find the root of this layer if necessary.
>> +LAYERBASE_zephyrcore = "${LAYERDIR}"[]
>
> can you please further explain the problem and the usage for this variable?
> LAYERBASE doesn't seems like standard variable
[Sandeep]: The problem is I need to access 
https://git.yoctoproject.org/meta-zephyr/tree/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc 
file from vendor layer to manipulate the do_configure:prepend to copy 
files before the zephyr builds are started. Hence I requested to meet 
you guys and walk through some of my proposals for this layer.
>> --
>> 2.34.1
>>
>>
>>
>>
>>
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1621):https://lists.yoctoproject.org/g/yocto-patches/message/1621
> Mute This Topic:https://lists.yoctoproject.org/mt/113479750/8188369
> Group Owner:yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:https://lists.yoctoproject.org/g/yocto-patches/leave/14211927/8188369/518048116/xyzzy [santraju@amd.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>
--------------kYH7QvEIwM0cNRet4dHzhnlp
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 6/6/2025 4:59 AM, Lee Chee Yang via
      lists.yoctoproject.org wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:BL4PR11MB8797361F43C6718A631EC6DAB96EA@BL4PR11MB8797.namprd11.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">-----Original Message-----
From: <a class="moz-txt-link-abbreviated" href="mailto:yocto-patches@lists.yoctoproject.org">yocto-patches@lists.yoctoproject.org</a> &lt;yocto-
<a class="moz-txt-link-abbreviated" href="mailto:patches@lists.yoctoproject.org">patches@lists.yoctoproject.org</a>&gt; On Behalf Of Sandeep Gundlupet Raju via
lists.yoctoproject.org
Sent: Thursday, 5 June, 2025 11:23 AM
To: <a class="moz-txt-link-abbreviated" href="mailto:yocto-patches@lists.yoctoproject.org">yocto-patches@lists.yoctoproject.org</a>
Cc: <a class="moz-txt-link-abbreviated" href="mailto:naveen.kumar.saini@intel.com">naveen.kumar.saini@intel.com</a>
Subject: [yocto-patches] [meta-zephyr][walnascar,scarthgap,master][PATCH]
layer.conf: Add LAYERBASE_zephyrcore variable

Add LAYERBASE_zephyrcore variable so that files from meta-zephyr-core can be
accessed from other layers.

Signed-off-by: Sandeep Gundlupet Raju <a class="moz-txt-link-rfc2396E" href="mailto:sandeep.gundlupet-raju@amd.com">&lt;sandeep.gundlupet-raju@amd.com&gt;</a>
Signed-off-by: Sandeep Gundlupet Raju <a class="moz-txt-link-rfc2396E" href="mailto:grsandeep85@gmail.com">&lt;grsandeep85@gmail.com&gt;</a>
---
 meta-zephyr-core/conf/layer.conf | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/meta-zephyr-core/conf/layer.conf b/meta-zephyr-core/conf/layer.conf
index e1bb263..a4b3555 100644
--- a/meta-zephyr-core/conf/layer.conf
+++ b/meta-zephyr-core/conf/layer.conf
@@ -20,3 +20,6 @@ LAYERSERIES_COMPAT_zephyrcore = &quot;kirkstone scarthgap&quot;
 PYTHON3_NATIVE_SITEPACKAGES_DIR =
&quot;${libdir_native}/${PYTHON3_DIR}/site-packages&quot;

 addpylib ${LAYERDIR}/lib oeqa
+
+# Allow other layers to find the root of this layer if necessary.
+LAYERBASE_zephyrcore = &quot;${LAYERDIR}&quot;[] 
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">

can you please further explain the problem and the usage for this variable? 
LAYERBASE doesn't seems like standard variable</pre>
    </blockquote>
    [Sandeep]: The problem is I need to access <span style="white-space: pre-wrap"><a class="moz-txt-link-freetext" href="https://git.yoctoproject.org/meta-zephyr/tree/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc">https://git.yoctoproject.org/meta-zephyr/tree/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc</a> file from vendor layer to manipulate the do_configure:prepend to copy files before the zephyr builds are started. Hence I requested to meet you guys and walk through some of my proposals for this layer.</span>
    <blockquote type="cite" cite="mid:BL4PR11MB8797361F43C6718A631EC6DAB96EA@BL4PR11MB8797.namprd11.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">--
2.34.1





</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">


-=-=-=-=-=-=-=-=-=-=-=-
Links: You receive all messages sent to this group.
View/Reply Online (#1621): <a class="moz-txt-link-freetext" href="https://lists.yoctoproject.org/g/yocto-patches/message/1621">https://lists.yoctoproject.org/g/yocto-patches/message/1621</a>
Mute This Topic: <a class="moz-txt-link-freetext" href="https://lists.yoctoproject.org/mt/113479750/8188369">https://lists.yoctoproject.org/mt/113479750/8188369</a>
Group Owner: <a class="moz-txt-link-abbreviated" href="mailto:yocto-patches+owner@lists.yoctoproject.org">yocto-patches+owner@lists.yoctoproject.org</a>
Unsubscribe: <a class="moz-txt-link-freetext" href="https://lists.yoctoproject.org/g/yocto-patches/leave/14211927/8188369/518048116/xyzzy">https://lists.yoctoproject.org/g/yocto-patches/leave/14211927/8188369/518048116/xyzzy</a> [<a class="moz-txt-link-abbreviated" href="mailto:santraju@amd.com">santraju@amd.com</a>]
-=-=-=-=-=-=-=-=-=-=-=-


</pre>
    </blockquote>
  </body>
</html>

--------------kYH7QvEIwM0cNRet4dHzhnlp--

