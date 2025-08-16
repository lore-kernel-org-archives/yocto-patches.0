Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32112CA0EE4
	for <webhook@archiver.kernel.org>; Sat, 16 Aug 2025 02:32:30 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (NAM04-MW2-obe.outbound.protection.outlook.com [40.107.101.81])
 by mx.groups.io with SMTP id smtpd.web11.27159.1755311544927793849
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 15 Aug 2025 19:32:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amd.com header.s=selector1 header.b=i2QMh88t;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.101.81, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxipSVJRqa3c4QJlA0Le63w/hDaGoQX3O3MqRQAiDx50NIp6VWJjstV8k5lGjXdQJWWqIrzhYNbOst/gstkLD1TP7rcPzYWGnK1bJooWY1ZX9W8VxNCUtQyZQTekvzmjidD+FyUlcfPoze4fzuea4qh+hgLZOsjueN5nPR6Kftq0KhIUTS7QEtBRkJ3/XT7N+fF1FbkhYmbWalKfIjvayh562J4uyhm7ezWHKd8ys60peOSze8gsspoDzG/v+NWP1L0mpBaYrTaih02LvEjTmOk7EsFMF4TDtpXjYn1xwrCSlmJM/xNTyarp+Kf6OH2jarsXiHG1EH91Xw6Ix9nKjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hScM9QMJPXJk93+wVchTbSKijw0981cU7zlhCSBIXC8=;
 b=iveVFZvjeghBhoakaJBGcpntIEWoON44minTuDZqFyWyhvp/wFuK3vhkYNCBlDuTVhWhvmDY7rRX+I6Q+1BcKvpaQviemw/3K1jtWOoT1UtUOTw0yET/kfu0hXER8wiax5IjMEpSFZpNJ+mtnCWCEKBaWqJFXx44bmoytz0AKOuJN14zDD7VW1koucTwjAsmoxcj/BXcUkOa6PTWdH8WFSYN9bMy3dtbBvkJ1vKIqS0vS07NDGIbSPvrUlr2Cgl5ZdrONJwWvWxOAF6pMosHcE6IQljKBd5DxvmQK2A4p/OWDQK4OCNESVQgDdm8ZiEMspj646H2WpKD2nHXBlrCyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hScM9QMJPXJk93+wVchTbSKijw0981cU7zlhCSBIXC8=;
 b=i2QMh88thgdsAXpHRINp/v5o7aiTmMoGJj2IfuLxzd5vr2mGLdDFQQGnDLmTmIz/ApvVNfFLgce/bt/Qxpuqg66a8DNkB1Z0U0fkR1TGSBad/g+BV3orfcqhJxnljhYZ3WLNdVlU7BGYuP1b3a3goSIZ7gDUsHiAVsqaYwjFRFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21)
 by DS4PR12MB9634.namprd12.prod.outlook.com (2603:10b6:8:280::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Sat, 16 Aug
 2025 02:32:22 +0000
Received: from SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7]) by SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7%6]) with mapi id 15.20.9031.014; Sat, 16 Aug 2025
 02:32:22 +0000
Message-ID: <2fe12dc4-be39-4ade-816d-fed337a65fcd@amd.com>
Date: Fri, 15 Aug 2025 20:32:20 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-zephyr][scarthgap][PATCH v5 4/12]
 zephyr-image: Add image artifacts to output files
To: yocto-patches@lists.yoctoproject.org,
 Lee Chee Yang <chee.yang.lee@intel.com>
References: <20250812174147.130972-1-sandeep.gundlupet-raju@amd.com>
 <20250812174147.130972-5-sandeep.gundlupet-raju@amd.com>
 <BL4PR11MB8797DFA56346369056287E86B92AA@BL4PR11MB8797.namprd11.prod.outlook.com>
 <SN7PR12MB8770AEA28E0566FB714AE8CDDA35A@SN7PR12MB8770.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Gundlupet Raju, Sandeep" <sandeep.gundlupet-raju@amd.com>
In-Reply-To: <SN7PR12MB8770AEA28E0566FB714AE8CDDA35A@SN7PR12MB8770.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0026.prod.exchangelabs.com (2603:10b6:a02:80::39)
 To SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8770:EE_|DS4PR12MB9634:EE_
X-MS-Office365-Filtering-Correlation-Id: 5865dd49-6cf5-4432-acb9-08dddc6d210c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|4022899009|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VFhJeks2OXRzTnFIaXZ3ZnJYcVRUeldqUGtoVG9QamQ2K2JEWmZ0alo5MVc1?=
 =?utf-8?B?Ti80WHU4WXlxMTJrZFl3Tm1QL2ZYKzMwSHE2N0pURitKeHptcGxSQWdNdnMz?=
 =?utf-8?B?bDBOQzdyejFLNHNDK2QvSjVWengrNlFTaFJzNk5ldWZFVUpNRWUvbXpkc2l6?=
 =?utf-8?B?OUljV3AvSTdXYStZakNPNkRvUDNwT2JsTkdLTGNOZlJvcElZdVo2SFVZbUtP?=
 =?utf-8?B?WEt0L0lPcE56ZTlvd0xseGswUGdQQk9LejdsMSs1TkFrbENvMUV1dFhPRDdY?=
 =?utf-8?B?NGNRMldGNUF1WmdZUzJ0L3FpWkVGR2NYS2FMK2NYZk5PUlVXVkt4OEphTDhP?=
 =?utf-8?B?anExUXVaUk5mN3E0dlkyV1UxNTI5cERrSEdCbHhXL2J3ZHdETGVWelE0NTBj?=
 =?utf-8?B?K2crZS9yWURjUCtrYUhwUjBLcEh0M0RkZnJnQStlODhDZ2ZaeWFzcUg4OGxk?=
 =?utf-8?B?VmdZTEh1bDI1WWZQcTVLQUVsU3BpNThDZ1BsaHlTWDI1N292SitHY3NtWVcv?=
 =?utf-8?B?SEVhMWR2RWR5dXNMbTQ4UjhiRDdob0JNQm9Cam5NbXNadFJzTUZHb2pyaVFm?=
 =?utf-8?B?Tzk4Uk5Ody92RzM2VEU4cVVwWWlValQ5OUZNUk55SUVzc3NVWFErUlBRU2xo?=
 =?utf-8?B?WTNpWkQ5QXNHMStuQVZaWXlwNm9SZ3ltTGRReE40d3JDalFpa1d5ZjNVNkZY?=
 =?utf-8?B?MzlzWmR0UWNsWVh1WHdKT3RZL1MwNlhrdzlGdUNvU25RWWJldU1NU2R0bm83?=
 =?utf-8?B?N0I5MDJFdjNRTWdZc0ZENmpOa08yM0NmWTd3SEQvakhIL2VkdGhTb0lUM1V0?=
 =?utf-8?B?dDJSNXR5YTVrbE9TNVc5WURCNVRiUC9xelROenNmZ0VoZ0dhWXQ3RndTOUpy?=
 =?utf-8?B?ME9TeXpGOHVoZTJWSzZLekRtb1BIaU1Vb1V0RE5UL0YveklLYVM0NlZMRWtU?=
 =?utf-8?B?OEpJajc2WXVmcHcza3cvck85V0NWM1ZFUHVhMlRyaUhBZis1TDdINm5MQlBy?=
 =?utf-8?B?NVIzY1NxM3VsTlluVDNzS0VEd1pnZS9oQ0tIdEVkRitDdWsrTGcwd1gxeWpo?=
 =?utf-8?B?dkVOZFd0M2oyK0IrZEN1STlCSkJwWTExRXhhbnpvU2VKREU1MXNsVklSNU1M?=
 =?utf-8?B?UHJnSVNaRTRkUlRKMkNGUmVHVU4zYjgwQVErYnlXMmlrU3lGc0R4eTZOUE5W?=
 =?utf-8?B?dDYvNHl2NjBtWGhHQUtZaVZtSDd5dElaOUkrRkc3VFdQVmpLek9zU0dSMUpO?=
 =?utf-8?B?TGlLNjlndEEvZFJ4QVFWaXpZeXpLWk5Wa3I3cUhoQ1FGZzdmOFdmbC9Qalg0?=
 =?utf-8?B?Rzl0Zi82dU5iMmZ4S0duQmZCbXVFVlYxZWRNYnpaM0lmSHp0c1hoOXRqMHdW?=
 =?utf-8?B?aTE1dExMOXVzSTc3NjNiYnNRRklBbUxsaEVVVVVnQm1iYU0xVU5MQ21ueXdu?=
 =?utf-8?B?SU5RK2tEVk1pMzlzbllXYnROdVpyRzVDUk11eFVxREJScXU0dXlDRHhnTTBk?=
 =?utf-8?B?WmxvQ2J2MzV2b290VUx3RkZLM25IeFplYk5zWWQ3YytZMHhKZVVLVEpzZ1Iy?=
 =?utf-8?B?RGhkek13OHlPR3FoWFhEdU91Sk1ZOVpOWC8rSEdEL2ZlQXhWSW41SzBPQTRa?=
 =?utf-8?B?VEVuQkJ1V0sxc3VGM2tnTk1YK2xUMUY3YjduOUNBSzNsbytCUVJmcEhSVkJG?=
 =?utf-8?B?UUFuOWFvRVZwaTdqaDd2UmNYb0pEQTM1b2phdllRb1VVcGhsbkErVEk4c0t1?=
 =?utf-8?B?V2d0S3ozNnMwaXRSOGRhTmNMMEl3Wm5Fa202a1ZNVmNZeG1WOFFZMmx4SkNk?=
 =?utf-8?Q?k9+ojqhVAPI7e/NCO+itKGGWesSDA5+VKIfdU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8770.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NXozVmVrM1FJMTdyUkprTjd0WFFBUU5MWmx0NW00TGc5YUFhdnBNSXY5U1NP?=
 =?utf-8?B?SElDRGFPeTZ3bmRiZ3RwbndabzA0am5zNDNoYXgxR2FEVFhOZm5USFlJdTJZ?=
 =?utf-8?B?dGdsd1lxVTdINzZacm9hdDZGN1FWalBBbFlJYkFlYzdkb3NlWGQ2Ym1ueEtF?=
 =?utf-8?B?U3RCYnBFd01EM3dJckZVTWVwenFza3Z2bHh3RFJXL21JUGZWcit3aXVYNnhr?=
 =?utf-8?B?elNBa1FBL1MvYlo5VEtEUXVhRVM4ekU1TndkZVBQZEw3M0QxRHp5MlZNaEhN?=
 =?utf-8?B?MTRwMVNtdm9hbFBpeWJUaHJBR1RWSWdncEk1VEc1YXFrQ0prNlRkYmFyWVNK?=
 =?utf-8?B?NUtWOElHK2hoczVCeTAzOSs5akkwcFA2bk1ua3l6Uk9YUnRGMTdDRWo4NVlY?=
 =?utf-8?B?bUdMQmdUYkJETmtWdS81bWFtd3NZMWM3bFVUSzIwcHdsb05ZZ01MVkJTT2Zy?=
 =?utf-8?B?eTVHWjUrTzA5R0JZSjZUYmh3YUxiYnUrTGYxcHFuL1JXOHRQZ1p4UXZ4VVRZ?=
 =?utf-8?B?MG5xZ042bFpXdzRyZ3dzSjU3eHh6YWsxNXUwcXl3Zkd5eklxV3hucklSRHEy?=
 =?utf-8?B?NGJhZ0dTeDZOYTA5eGpLcHVWUVozR2VXbnhkUTV2T0ExSGF2Q0RoWHhxZ3FU?=
 =?utf-8?B?Q05vNEJ4VDIrbjFlOFdSQTYwT0xIZkVUTnlNK25WTjQvTXFqeGlGNmRuZndq?=
 =?utf-8?B?NUxGNlRqOWk0TnkydkdHR1Z0ZHNkNC9aMFl2bDJUK0ZOT2VIelhuWmkrT05B?=
 =?utf-8?B?NHdLMUtWc3EzR3ozMlFicjNDR1Uwa2hFVFFZdU1UUUxhWXk4aFNjc3JUVjNN?=
 =?utf-8?B?ZnZrUHRqd29HQ3V4NktzRWFJL0RnRDRNWkgwRFNjYnZJUUNBbEU2ZTVmSGYy?=
 =?utf-8?B?VjNTNElaOEE4UktqL1BPdTV5VjhZMU5hQ2sxZlB0OWx1R3krVFg5SjFJU2VW?=
 =?utf-8?B?NEgzVlNKUUNkVzM5T3l6TkkzNi9xOHJvOVNRRUNtdU5XOHRzTGVzYkR3RGRB?=
 =?utf-8?B?QU4xa3NqVkMrYXB6Q3MzVEJEOUtaREVVbmovdW5OeHJvQmo1cmxLY2F0SURW?=
 =?utf-8?B?THBMK1l1R1RFcEtsSGI4YTA4NVB1ZjNTQ2hEcGJzenRrQVhXMmU1Q2o3MDRm?=
 =?utf-8?B?OCtQcFRqQTZjWDBWb2JRNWN3SWxzV3o0NDByMDM2bGVHQkhHMVJsZnRXdFdi?=
 =?utf-8?B?aVI0ZHBuUy81MmxwRU1aM0w1NVMvd3NKbmFqR2N6V2tHSXVvR3p0VS9HcEJN?=
 =?utf-8?B?T1l3dHU5ayt4SVNCeVFsRUFPSjZ2SzU5YnE5YitJallGR0RaY0pPUFF5bkNz?=
 =?utf-8?B?aWxjWjVLSE5CSllLMk5BVlJEWEdRYUs2RGhnWForcGxiRzc3MHI2Z2ZZOCtO?=
 =?utf-8?B?bGRTWGgrNDEvSDQvZlUrRGtHeWM5SjJ2V2VDc2crcWlYakpsLzVZYTNRbW8w?=
 =?utf-8?B?ejl4UWxyVWZTREQ5OVNTVEJJYmlKMmR1OTI0MUxENUl6T0YyM0sxMnhyZW9R?=
 =?utf-8?B?WFNnMlJRYXF2YUtaRWpUWkVkdWZlM3ZNWWo2bTQ1aWljTWNUalowWmJrOGRI?=
 =?utf-8?B?RHFpT0NualZrSHM5TUVVZi9kVkFpRGtldTh6bGZXZzBxaWpFUUlNWnFTTm5t?=
 =?utf-8?B?TGVwNXBPYUtnNkRHK0M1UnhxQmR4Wmk1cDJqL2RXYVlFMURKQ2JTSVhoMzJE?=
 =?utf-8?B?elJucE1EWjN3azVPUHp2cS9kYkVPb01WSlhtUHdvbU9temtQUUNJejAxdUcr?=
 =?utf-8?B?aG1iaStTeGMrR1drRkZKam1sZmlqcDRzejhqM29meTc4cXVSTStVSGNIbmx2?=
 =?utf-8?B?Y1dVUDRvQndMMFBocUVoc2JJRUZmSUk4UUsvWUl3bU96RWZWM0duK2xFOFNR?=
 =?utf-8?B?OE5weVh5dk1KZzd1SEdLdXc5cWY3b2o0b2w0cUVHWGRydVFBMk44UlNDNXEr?=
 =?utf-8?B?RkhVR21xeURGT1R0VWNYbXlpbkZiTGVOYnB0RXpLZ0JNUmE3KzdhU2N6d1Jm?=
 =?utf-8?B?eTgzSUFmcUJUN05jMDRLSTMyVGhxSG1lc1dNTGkvTjYwYnU0MTM3bXRDRWtl?=
 =?utf-8?B?TVc4QnNCbjhNSWhZdzdJUExweGtSYTdkMnRmQWh0MVVwU3JSQnNuSjFmeW1y?=
 =?utf-8?Q?a9u+0XBnIDGW8fhjqlcUC3CzR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5865dd49-6cf5-4432-acb9-08dddc6d210c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2025 02:32:22.2145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jW2di8+87uqdNdQIPMONAQSXxCrm+LxA7ynZa8Evp3hpVaLq+gm+/ubeAE+kywWlsZU7kn3+ue/8x3GQHGoiRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9634
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 16 Aug 2025 02:32:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2003


On 8/13/2025 7:02 PM, Sandeep Gundlupet Raju via lists.yoctoproject.org 
wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Thanks,
> Sandeep
>> -----Original Message-----
>> From: yocto-patches@lists.yoctoproject.org <yocto-
>> patches@lists.yoctoproject.org> On Behalf Of Lee Chee Yang via
>> lists.yoctoproject.org
>> Sent: Tuesday, August 12, 2025 9:13 PM
>> To: yocto-patches@lists.yoctoproject.org
>> Subject: Re: [yocto-patches] [meta-zephyr][scarthgap][PATCH v5 4/12] zephyr-
>> image: Add image artifacts to output files
>>
>>
>>
>>> -----Original Message-----
>>> From: yocto-patches@lists.yoctoproject.org <yocto-
>>> patches@lists.yoctoproject.org> On Behalf Of Sandeep Gundlupet Raju
>>> via lists.yoctoproject.org
>>> Sent: Wednesday, 13 August, 2025 1:42 AM
>>> To: yocto-patches@lists.yoctoproject.org; Lee, Chee Yang
>>> <chee.yang.lee@intel.com>
>>> Subject: [yocto-patches] [meta-zephyr][scarthgap][PATCH v5 4/12]
>>> zephyr-
>>> image: Add image artifacts to output files
>>>
>>> Inherit image-artifact-names bbclass in zephyr-image.inc and add image
>>> artifacts to output generated files.
>>>
>>> Before:
>>> zephyr-helloworld.elf
>>>
>>> After:
>>> zephyr-helloworld-{MACHINE}-{DATETIME}.elf
>>>
>>> Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-
>> raju@amd.com>
>>> ---
>>>   .../zephyr-kernel/zephyr-image.inc            | 28 +++++++++++++++----
>>>   1 file changed, 23 insertions(+), 5 deletions(-)
>>>
>>> diff --git
>>> a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
>>> b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
>>> index d6ee21f..93d36b1 100644
>>> --- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
>>> +++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
>>> @@ -1,29 +1,47 @@
>>>   require zephyr-kernel-src.inc
>>>   require zephyr-kernel-common.inc
>>> -inherit deploy
>>> +inherit deploy image-artifact-names
>>>
>>>   OECMAKE_SOURCEPATH = "${ZEPHYR_SRC_DIR}"
>>>
>>> +ZEPHYR_IMAGE_LINK_NAME ?= "${PN}-${MACHINE}"
>>> +ZEPHYR_IMAGE_BASE_NAME ?= "${PN}-
>>> ${MACHINE}${IMAGE_VERSION_SUFFIX}"
>>> +
>>>   do_install() {
>>>       install -d ${D}/firmware
>>>
>>> -    install -D ${B}/zephyr/${ZEPHYR_MAKE_OUTPUT}
>> ${D}/firmware/${PN}.elf
>>
>> Since this is for stable branch, I think we should keep the elf/bin/efi file with
>> old naming. We can deploy both ${PN}.elf and
>> ${ZEPHYR_IMAGE_BASE_NAME}.elf,  ${PN}.elf can be copy of/soft link to
>> latest  ${ZEPHYR_IMAGE_BASE_NAME}.elf, same for .bin and .efi.
>>
> [Sandeep] : Agreed this is for stable branch but to me this seems to be a bug. Deploying ${PN}.elf is not a YP best practice. What do you think?
[Sandeep]: Chee Yang, ping on above question.
>>
>>
>>
>>> +    install -D ${B}/zephyr/${ZEPHYR_MAKE_OUTPUT}
>>> + ${D}/firmware/${ZEPHYR_IMAGE_BASE_NAME}.elf
>>>
>>>       if [ -f ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT} ]
>>>       then
>>> -      install -D ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT}
>>> ${D}/firmware/${PN}.bin
>>> +      install -D ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT}
>>> + ${D}/firmware/${ZEPHYR_IMAGE_BASE_NAME}.bin
>>>       fi
>>>
>>>       if [ -f ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT} ]
>>>       then
>>> -      install -D ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT}
>>> ${D}/firmware/${PN}.efi
>>> +      install -D ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT}
>>> + ${D}/firmware/${ZEPHYR_IMAGE_BASE_NAME}.efi
>>>       fi
>>>   }
>>> +
>>>   FILES:${PN} = "/firmware"
>>>   INSANE_SKIP += "ldflags buildpaths"
>>>   SYSROOT_DIRS += "/firmware"
>>>
>>>   do_deploy() {
>>> -    cp ${D}/firmware/${PN}.* ${DEPLOYDIR}/
>>> +    cp ${B}/zephyr/${ZEPHYR_MAKE_OUTPUT}
>>> ${DEPLOYDIR}/${ZEPHYR_IMAGE_BASE_NAME}.elf
>>> +    ln -sf ${ZEPHYR_IMAGE_BASE_NAME}.elf
>>> + ${DEPLOYDIR}/${ZEPHYR_IMAGE_LINK_NAME}.elf
>>> +
>>> +    if [ -f ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT} ]
>>> +    then
>>> +       cp ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT}
>>> ${DEPLOYDIR}/${ZEPHYR_IMAGE_BASE_NAME}.bin
>>> +       ln -sf ${ZEPHYR_IMAGE_BASE_NAME}.bin
>>> ${DEPLOYDIR}/${ZEPHYR_IMAGE_LINK_NAME}.bin
>>> +    fi
>>> +
>>> +    if [ -f ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT} ]
>>> +    then
>>> +       cp ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT}
>>> ${DEPLOYDIR}/${ZEPHYR_IMAGE_BASE_NAME}.efi
>>> +       ln -sf ${ZEPHYR_IMAGE_BASE_NAME}.efi
>>> ${DEPLOYDIR}/${ZEPHYR_IMAGE_LINK_NAME}.efi
>>> +    fi
>>> +
>>>   }
>>>   addtask deploy after do_install
>>> --
>>> 2.34.1
>>>
>>>
>>>
>>>
>>>
>>
>>
>>
>>
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1986): https://lists.yoctoproject.org/g/yocto-patches/message/1986
> Mute This Topic: https://lists.yoctoproject.org/mt/114670142/8188369
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/14211927/8188369/518048116/xyzzy [santraju@amd.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

