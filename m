Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1B7CA0EC4
	for <webhook@archiver.kernel.org>; Tue, 12 Aug 2025 13:53:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.42])
 by mx.groups.io with SMTP id smtpd.web10.75372.1755006816456984593
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 12 Aug 2025 06:53:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amd.com header.s=selector1 header.b=VgKQpK3b;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.243.42, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lltXws4TC3jO6esypM04x60kGrisiCS+CB8hAefunO9The2pM0XwVNlkk1OqFc8QKenHjVttbs9K5gcPm3hYAnf9n7etqj+UAR+TF43duN0C9jMj0s9KeltsPIkIMml4jWczKIQOl0YJMIdMCB1tLYJNxhm+7q/EbFtlD6CstVIIO4P5HJUP3f9SPFPvcb7f/1803OO1wDGlQxqGzE8HO3jNTgnVMbsK4ACKeQBhNyfCODVOWlEBX3ZQNS1e9QypcvkIS5ltTnS8WCYdQf7mQyLvNl4C0Yp97oKeLeRrnGlaRlk3GkLd7bQxI8depQD7yFFXJYE3PwtKh/bgVO1okQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRvel7g9dZRxtaiVdfbe6gX6N41Vup3IM7cfW1YYwu0=;
 b=sKSwFo3lqsGbCCh/sgJHJwEZwaBWe2qud0gjCMBmhtAcbBWlP5uXOmP4B2H8XGfOMYHtE863lfrvKXzYa8AIom5Yg/DN0SNumG4C+I7Q+3dxweg27zQ3u0XTnz1L1RaIdz77T49qbso8Na6aQ9VrMSSPeoLLT6ryO7Ofjkv5tyJObWGRmsnPdswTWPmVVY6ffAcd2Gnrs0A67c8SQKOo6fim5UQCe/aMELrKnme7d8W/D1/CAN/NSXR2egxSdTxg9Y0ms2HlMYQg9qQQdy37cDZ+Js8fVQSpA4Z2mzV2E4qQ6opCWo+l1wGv//N/4VvqY9C7EK768xKCBWDmDKuugg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRvel7g9dZRxtaiVdfbe6gX6N41Vup3IM7cfW1YYwu0=;
 b=VgKQpK3bqXqeF1PAJt82vbxhVjg4mRTJqf7AIettQWtvHeAUf/8jsUBaLrwTO6wHHPkzWYFyyzIBxg208OtcDEgKg9mVp9g3KAgB9CX4W2PI8vTRSzhtyuOHzj17ynf9p+CLPRHeTOK+cQmidHNZA6YgnqMD4pPm7iRQD5eRtSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21)
 by SA3PR12MB8809.namprd12.prod.outlook.com (2603:10b6:806:31f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 13:53:32 +0000
Received: from SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7]) by SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7%6]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 13:53:32 +0000
Message-ID: <db290852-5f21-4901-a475-82dfc13bf680@amd.com>
Date: Tue, 12 Aug 2025 07:53:30 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-zephyr][scarthgap][PATCH v4 12/13]
 zephyr-kernel: Add rpmsg multi services recipe
To: yocto-patches@lists.yoctoproject.org, chee.yang.lee@intel.com
References: <20250811194646.3408854-1-sandeep.gundlupet-raju@amd.com>
 <20250811194646.3408854-13-sandeep.gundlupet-raju@amd.com>
 <9f78b4c5-9a45-4161-890c-a37e5ace6f95@gmail.com>
Content-Language: en-US
From: "Gundlupet Raju, Sandeep" <sandeep.gundlupet-raju@amd.com>
In-Reply-To: <9f78b4c5-9a45-4161-890c-a37e5ace6f95@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0083.namprd07.prod.outlook.com
 (2603:10b6:4:ad::48) To SN7PR12MB8770.namprd12.prod.outlook.com
 (2603:10b6:806:34b::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8770:EE_|SA3PR12MB8809:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f3c0d7f-5a91-417d-6f39-08ddd9a79fdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|4022899009|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?M0RMZktJTTJ0VnVOZGlwK1pCc0Z6UTg3S2NtY3hlWFBDaUx1MGJPek8veVhK?=
 =?utf-8?B?NVBSaDBJcGRjeEYrbTJHMTdkRDB5SENKN01sWktGQlUwMWNKd3JJUTFPcmZT?=
 =?utf-8?B?T3NUOFVMMDhZWGFlUTlEamhPeTV2ODdRT2x5M3pISWdGSEZBNm81dHRmb1Qw?=
 =?utf-8?B?WTIxa3JrTGRoQTY1K2pCWmZwMkYydWNiRHB4Y204RlZWdmU0ZHRTeC8wODZK?=
 =?utf-8?B?QVZTQy8xcHlvSjBoZnQ1Z3NzMGpKdGNjbXphQmtPRURiNjlYZHFnd3hXRUZi?=
 =?utf-8?B?VkVjNHQyY0s1ais5YzJhaWdmY3h1aktkUVFVMG5zRTVxWXJqYzI2YkxGTWVk?=
 =?utf-8?B?T1lhazB3M2hpaC9aTTNCY3VaTlJPVjFZY05UUUQ3cTB0b0VQQjhyRlVveGZz?=
 =?utf-8?B?TStIUzNqcEs3MkdVTGwzUGRoM29iUUtBTENGTTNjMGdFMXdHa1B2alFETXIy?=
 =?utf-8?B?NzBla0grQ3dnbWNNYkVIWXAyNGNmMnA4WTlBVnJVZHA3QkI0NlpmTjgrOFlH?=
 =?utf-8?B?K3ZCajJmR3V0MkR3R2NHdlVSQURDZm5iN1ZQS2tqOGhTTUpjMmpvVVdxUlRo?=
 =?utf-8?B?MjFjbEpqaFBobTQzbGc0L012R3FvMm5Oclp0akozZ3dQNnF0ZW9la2J6R2hO?=
 =?utf-8?B?MGltNktpSXNTL09lN0dNTlBwK3FNNFY4Y2JGbEpmRHlqb3FySjdSanRLWnls?=
 =?utf-8?B?SUw3eDVTdzZtK0szSklmemErcnVDdFRtS3JqZFNBMnQvOVVSNEtEeUVQdk5w?=
 =?utf-8?B?N2ZRWHc0MU53RSs1MnhiVUEwdEV3SmRmRTdBOUdmaTJwWktScWpoMzRDTUJQ?=
 =?utf-8?B?SHdCbGFqN0JqRytadlBKajJhUFdnR1NmeGJTNitZM3ZhWU9jeGlvanpiOGtU?=
 =?utf-8?B?QjZmU1l6aEZnUnF6SmxFQW5iZ2laV1pTQmhDa3RRYXAwYzQ2ZjNFZzhNNE0z?=
 =?utf-8?B?NUFteUFiZ0NVTEpFL283amZ5T3VCOHNCVUorVU0vNjBSUks4R29UMlhYZ25t?=
 =?utf-8?B?ZU1OSmVIMHJGMFdnMkE3NXlOUG1oa3JlK3VHMGg0Z2oyNjlTcWJwR1hkbnZh?=
 =?utf-8?B?d1I1Q1RBRmVhOTJIZXljUTlTY2U5SUo0dDZlamZ5empscTcvRm5BR0I1Uzdv?=
 =?utf-8?B?OFFEWm5PN3VVZU8vOHR0QlNJTkFtT2N2dDVmYUdIam0xTllCSmM3VnJobnVI?=
 =?utf-8?B?Z2NpTHRRbHNqa0ZFczdpRERPVzk5dnJpWVhRSXJBb2lZOVVOUFRCVC9GeUE5?=
 =?utf-8?B?eXVtTUVkZThuMFlQYmY4UmJTUUg2RlhtR2d1RHgwSFlTODJrK1R5UjkybFJ0?=
 =?utf-8?B?ckZDbitpMVIyVERBVEtCUWl5c0NlaVI0WHBpVCtDSEcxUW80UGtDem1vaVEz?=
 =?utf-8?B?MnVVeGwyeHBhdmJvVkVUN1Y5TzBPSXlMQWxXL25DcGR0MmZJcHN2RlFSN040?=
 =?utf-8?B?NlBkYzdyaUlrK0xsUkxrSzRmRmxNOXZCZ2NYWUZUbHo0ejRHV3QycVVOekF6?=
 =?utf-8?B?S0tMQkREWm5hSk9mWGRZUkwyYy83ZUVSak00a1VuTTNYcGJRckFkYjYrUFE5?=
 =?utf-8?B?aGxqYWEvNmRYUTAzZmtGNFJvdXlxbkZXd0h1YXBzRWJrb3hLU3oyUGpCbXFL?=
 =?utf-8?B?blhsVXJVdnBrSHJZS2p6b2ZBYkFod25qbkNQcXRTQW5ldGtOczVHaWZIM0JE?=
 =?utf-8?B?NVFxZXFqWHNGRU9VYVlBWVJ3b21zSnhGSWc1RFRoTWRCZW1IaE9mUm1NYkVL?=
 =?utf-8?B?WTdjbnlrRkxKUVQ5NWFJMFZOc0FkU3JxTmZrTWhhR0Z5SkRtUjdyUGV3RGJY?=
 =?utf-8?Q?p3tAdrnzZf/PoNxjGU9QeTYbujkVZalOZLI1g=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8770.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(4022899009)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d3R2U1VSR0hnOFVLVUQyZUN1ZjZnQjZOU2ZuZzhHTkIxampIRFpTdmJsSGVj?=
 =?utf-8?B?cnRSeUdqcGIxUWJ6RW85T2d0dFZENndoY1VUZGJndnA5YnVsK2JTSTlDRkxn?=
 =?utf-8?B?TmIzMmxYVHZJQVhYcWM1OGNQMGpoRUVGdXJkTXJzbXB2eC9iU2xEMnpqTHZB?=
 =?utf-8?B?L2ova2dJT0FjWkRPVHNGRVRXU1h5anF3cXV5amJyMEFYL3lIT0IrZGNlR0VI?=
 =?utf-8?B?MVRNdjFoSnNhY0pxMmZ4VnFUS09mY2VMQWc2WmlWZW45aVNHdGtTMFp4cmN6?=
 =?utf-8?B?QlBqNWM5QXY4aWp4WUNONjlFVHdHUmdmc09TMVhHU2dzdlk3NFYraDEwMXlD?=
 =?utf-8?B?VHdLTkJWdW1nNFd2RDFTd2hwQVhPTnJ5RXhhc1J2OEUrcFQ0c3RLS0xKS1pp?=
 =?utf-8?B?VTVDTCtZUitNeDdnQ0Vtc1ZLeFFFcHhueVU0YnBuK3pWZWxvbTd2eWNjWUN1?=
 =?utf-8?B?NVFpMXpINmYwY2hBRWIvR2RoRkRGOXhPUFVtUXVFRTRKcTVNTlNrdHZyUWtF?=
 =?utf-8?B?TEthTmducjM1QWhOMTJpTXdTU3pYb0NkWkNBMkJieDRRT2VwbndSREROYy9n?=
 =?utf-8?B?UU5tU1NmbFdNZ1FXZTk4Nkg5eVF6SkJCMHZEMC96ckl5MXplcUFSeEZ6TUg3?=
 =?utf-8?B?dTlGcTlKMG1iZnROcEcwSHU1TTVmcHpiNHMwNUVCOHR0eW1rWDFyN0lFOXY4?=
 =?utf-8?B?OHd1T1kvbmoyS0lpWnJsaGo4Ty9mTW9tMG1HdWdXdURSRkp3c3dRSTVwNnU0?=
 =?utf-8?B?MXpLbEVQSW1KUU9NM05FYmcvR3hmQ3lXeGtmdk1EZjVsRmhueU1RKzVSVkJR?=
 =?utf-8?B?eGdIczZEclYwakoyR3pqallLRkFtVzNnYlFLN1dEOTAxejBlR0FxWEQ2UzRZ?=
 =?utf-8?B?YmZJV05ENEF6cGRJdFZjTUh3UDNKcWRWM2Naai9aYkEySSsxTlBSc1NkWERB?=
 =?utf-8?B?V2xUZVVJQXZVdTZ2ZWQ3TDNLakxzQWtkL2hWanRkejRXTjBNbklaQWloRkRS?=
 =?utf-8?B?ajZMVlB3blRqN2hRVzlSV2F2Vi92cER0VEJNQUdTME1PQnRVNE14Z29Lclkz?=
 =?utf-8?B?YU9tSzZxSGhnZk1KZHc4cEw4dmc2bmd1ZEdQSk56UlFnWGlraHlqSzJneUg2?=
 =?utf-8?B?ZlVGb3lRWmdGMEUvRWlabFJSM0JkMGtESzliTXRNZHkyMVNWaDhFV21NeVFr?=
 =?utf-8?B?cVpzYys5M0RHczM5c2JUOVh5eGNDbjFtSEtPUXNYWDJnZHNsWlE0ZTJvbTl4?=
 =?utf-8?B?SzNCMTdJeVlldmp4dk5MOFZlYk51L2UrbnVUSzdEV3kzN3FvMFI4Q01HRlds?=
 =?utf-8?B?d1A2ZGs3NUV2Qm80cGtlS1NWSG51R244czhoRXZCYnJ6S2NjS2o1VmpNTG94?=
 =?utf-8?B?ZUl6bCt1ZHBJSDJOcUNIRk9KLzdHNDhUT09Vazc5dFVIbjlEYXl0dFIybmRH?=
 =?utf-8?B?bE8xbUc3SUQzM1J5bWZDemxmSEVyeTdqd2ZweC81ZnZOdVkvR2RUV29uUDZL?=
 =?utf-8?B?emdIYWdkL1BtUlNHM3pMRUZuVEFPbzB5Uzl4YXRqZzRrODIzNDlYeXVRNWx6?=
 =?utf-8?B?ZVUwVDloVjUzd2FpbUhPR0JndU5LdDlPUm5EZ3c4Q2FmakliU0pCdlM4V1pn?=
 =?utf-8?B?cFFGTG04N1hLUytFa3l6eWJKbEVURllNWld2MmJ0c0pUbFFDMlZsZ3VvQ1pw?=
 =?utf-8?B?SWxlTGRMdzhUSlZndUV1TEw2SmJXRHdUUHZ0SmpJNXlGTVlLaUhuYSsrZndT?=
 =?utf-8?B?MG1UcXVHanpQNUZSN3krTXoveDNsQ0ZLUVlCdFRNQWJQQlVvZ2UxelNNWHNT?=
 =?utf-8?B?aUF5Z0doTktqOFI1alJQaDJSZmJsNG5WbEx0OU1LOGhVVFlFNlZBVHV2NzFT?=
 =?utf-8?B?WkVtWHpMQldNOWNYYWhzM3VRbG1ybFlScDVSZ1lvdU1PaHZUbHdpQ2JjTXgr?=
 =?utf-8?B?Tis2cHRxRkFUTHBYN3B2TlNKUmxOdFFQcWxwdlZWa2creXlaN0dOWWpXTHdx?=
 =?utf-8?B?RUM1K213OHRtcmNrVUE1UWh2dlh4U2lxbDJLZUNpRFRPbk1tWFdsN1pKcTdW?=
 =?utf-8?B?T2ZSWEkxcWhHZVR3cm9lUmVZckFWWFZWSStzUmlVL3NVNFBVcnhtUFNnOFpC?=
 =?utf-8?Q?QF+EW8i895dF8j7gSkTCV/17X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3c0d7f-5a91-417d-6f39-08ddd9a79fdc
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 13:53:32.2667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pg8HnsNZkF0McwhPYq1F3QucYwoBxKLO+wJvW7rPcm4zRRIhIZmHGb3FmSnDu/cSexu3WlpW2kQlC7moZaVKSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8809
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 12 Aug 2025 13:53:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1959


On 8/12/2025 2:43 AM, Gyorgy Sarvari via lists.yoctoproject.org wrote:
> On 8/11/25 21:46, Sandeep Gundlupet Raju via lists.yoctoproject.org wrote:
>> Add zephyr-openamp-rpmsg-mulit-services recipe to build out of tree
>> openamp-system-reference example applications.
>>
>> Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
>> ---
>>   .../zephyr-openamp-rpmsg-multi-srv.bb         | 23 +++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>   create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rpmsg-multi-srv.bb
>>
>> diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rpmsg-multi-srv.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rpmsg-multi-srv.bb
>> new file mode 100644
>> index 0000000..51152e5
>> --- /dev/null
>> +++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rpmsg-multi-srv.bb
>> @@ -0,0 +1,23 @@
>> +SUMMARY = "Open AMP rpmsg mulit services"
>> +DESCRIPTION = "Open AMP rpmsg mulit services"
> Typo in summary and description: mulit vs multi
[Sandeep]: Good catch I will get it fixed in next version of patch.
>
>> +
>> +inherit zephyr-sample
>> +
>> +SRC_URI_ZEPHYR_OPEN_AMP_SYS_REF ?= "git:///github.com/OpenAMP/openamp-system-reference;protocol=https"
> Typo in src_uri: there is an extra slash after the "git://" protocol.
>
>> +
>> +BRANCH ?= "v2024.05"
>> +BRANCHARG = "${@['nobranch=1', 'branch=${BRANCH}'][d.getVar('BRANCH', True) != '']}"
>> +
>> +SRC_URI:append = " \
>> +    ${SRC_URI_ZEPHYR_OPEN_AMP_SYS_REF};name=open-amp-sys-ref;${BRANCHARG};destsuffix=git/open-amp-sys-ref \
>> +    "
>> +
>> +SRCREV_open-amp-sys-ref = "d78315763fbacba8a74552d0ad570bd01c42ccf9"
>> +
>> +ZEPHYR_SRC_DIR = "${ZEPHYR_BASE}/../open-amp-sys-ref/examples/zephyr/rpmsg_multi_services"
>> +
>> +ZEPHYR_MAKE_OUTPUT = "rpmsg_multi_services.elf"
>> +
>> +EXTRA_OECMAKE += " \
>> +    -DCONF_FILE="prj.conf" \
>> +    "
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1958): https://lists.yoctoproject.org/g/yocto-patches/message/1958
> Mute This Topic: https://lists.yoctoproject.org/mt/114654181/3619217
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/14411013/3619217/657730681/xyzzy [sandeep.gundlupet-raju@amd.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

