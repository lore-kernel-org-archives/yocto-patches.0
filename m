Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CD4CA0ED1
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 14:32:48 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (NAM10-MW2-obe.outbound.protection.outlook.com [40.107.94.62])
 by mx.groups.io with SMTP id smtpd.web11.76625.1755527562008864117
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 18 Aug 2025 07:32:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amd.com header.s=selector1 header.b=elY/Jlzp;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.94.62, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZLXxFNqIvptsLTpZAdI3J/uasrymQiL6/n7kqeLZCrZuVjJ0fRY8/+mkqTLcj151VVRJ9zPTLlLB9Lnzxv8CwyOLaiOA2hJtB8IcFPHriFaq4AAFmk/gDT5uV5hMqoZYtIFLQ+HTX+scAryTzcfZCA2DpfAQjP74YA+JQC0sL17Zv1sxYM189X3xy5anEbK/ILTO+np2Na2doWdU+ywHmGzxeq4EnqSofhvb5balimlmZgnfgvc+xMdU/LrY/uSpwQDPGtLJGXHCoKaWx9+mSuhL2p6idWYCkYZ/YOpv6sBIl2VculQu+W/I58oDiPZcVUZJ43zT/sYdoneL/7vU1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkD+VUVlnle+xipKJzNdIYiBOXxHsTSj9xqI4cdoQKg=;
 b=F9aB84/BzRmroNck7o1MWOWP50gNVIJ5/QKMhkHgNl9vhq1D2LXGn8Y6MgAFJDiIlYbShWS2vE9MgcveqhrdfB0Au9W5Es9063GDVPf8806c+wnyNS+gkvmGpTsoRSRjejhUhjGkR6qTYOtodjFFCYkdxCYVfdqZ52PuvWqoQ7otOF+XkfMToUfrymfGQG0M4kEXud/YlK7v+2vZw6t3GtsVIoIGqwmkTIpJfyb+CgzGd3hoyBFEwl1goAup049qSZn4P2DSx8PhKDY+ujLZB7TgyKtwE4eMDoIDuBtVm/i5ALEub1m935Eu+qVJ4TrPj1IX0Hzas9eH93dFxt3VqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkD+VUVlnle+xipKJzNdIYiBOXxHsTSj9xqI4cdoQKg=;
 b=elY/JlzpTDvL+Hlg2UKZQVfQ8oRxk5Wddm5gXRjOGGjEP9l1GTK4dy6LN+NpGktHtmwIQrJLeAiCKjYaHpUvOBY4BTfu0e4LHiCHDcePvDV1Ed0VpHX3qUQsKwFzECvKvmREjPTsgjNcrwuZRVi5XimJ8gn8AK1WJpmniBAnBFs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21)
 by CH3PR12MB9028.namprd12.prod.outlook.com (2603:10b6:610:123::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 14:32:38 +0000
Received: from SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7]) by SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7%6]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 14:32:38 +0000
Message-ID: <a2dbebfc-8ca8-4290-a405-ece0cea3bb45@amd.com>
Date: Mon, 18 Aug 2025 08:32:37 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-zephyr][scarthgap][PATCH v5 4/12]
 zephyr-image: Add image artifacts to output files
To: yocto-patches@lists.yoctoproject.org
References: <20250812174147.130972-1-sandeep.gundlupet-raju@amd.com>
 <20250812174147.130972-5-sandeep.gundlupet-raju@amd.com>
 <BL4PR11MB8797DFA56346369056287E86B92AA@BL4PR11MB8797.namprd11.prod.outlook.com>
 <SN7PR12MB8770AEA28E0566FB714AE8CDDA35A@SN7PR12MB8770.namprd12.prod.outlook.com>
 <2fe12dc4-be39-4ade-816d-fed337a65fcd@amd.com>
 <BL4PR11MB879701F9E70B3BBA7A74EFCCB931A@BL4PR11MB8797.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Gundlupet Raju, Sandeep" <sandeep.gundlupet-raju@amd.com>
In-Reply-To: <BL4PR11MB879701F9E70B3BBA7A74EFCCB931A@BL4PR11MB8797.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:610:e6::17) To SN7PR12MB8770.namprd12.prod.outlook.com
 (2603:10b6:806:34b::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8770:EE_|CH3PR12MB9028:EE_
X-MS-Office365-Filtering-Correlation-Id: 02935656-20af-4a33-4aef-08ddde6414ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|4022899009|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bS92YktaelhBTElFMVN0aS94K08rTTRvbEdSZEtwM3cwRjlkQWpWYzJ3ZWlW?=
 =?utf-8?B?dlFBUHM5ZWtDMEdWb3AzclFJaTg3WUNrTTNiT1BtVFRBbUlpY2dJSy9YSWNl?=
 =?utf-8?B?alBqMGY5WUt0SktwYzFKb050dDRyTGFBRDJKS2NKeXZvOTRKWW9KL2ZJcC9M?=
 =?utf-8?B?bEl6MmduMGlEWktFbitJazA2MGFNd0NOYjdobmJNRmlCYXJBNm1pR1ByRmpC?=
 =?utf-8?B?Ry9tRTFEMCsrcHd3RCt0aUtlczc0Qnd6azVsNStNbmZLUEVod2JrOXhXbk0y?=
 =?utf-8?B?NW92QytoUm5DbXVPUForVEFnVDJZNXRXTHlQTzE0dTA4SHhna29UdVh2L2tr?=
 =?utf-8?B?RDBTVVBsb2VWb3psZ1cwZHBYOFhITnRzSGprT1FWSHhIV1FwTEpUSWExM1l6?=
 =?utf-8?B?Y3BLK2F5clJyTStZSjl0Mysya0xENXlST1ZuRjFXOHo5NW5wcXpka3RQUkti?=
 =?utf-8?B?U2N6TlVLeWZ1M0I2dkNDQ05WTUFBRTFFdERKaFJsWm9STVpMdjEzRXJvTHJ5?=
 =?utf-8?B?M2ZtOFhIR1NFeEdhLzBmYnBUTmtzZ0VyenBQUTVaWFljV1NHUmdTckRlQlNr?=
 =?utf-8?B?RTRBaHp0NW15N201TlhKeGd6NjAwa0lMWVJCRmxaUGdXYkVsUndBNFp3NDRG?=
 =?utf-8?B?Y1lsYmZ3WmFDcDRZSis1OHl3Q055TC8vT1oxY3FYa1U0N1RIQ1RmMWNTUjNp?=
 =?utf-8?B?S2F3Y2lVU25KNTVHMzh1SjFIWUZEUjBJbjBjRGloRUM0T0hZTS9hUlgycGd2?=
 =?utf-8?B?MWQxSFRkaG9RQ3pKejVpR2xMbFo1bnIrRUQrM0xHL2NBQWh4aGdTVGRWczQx?=
 =?utf-8?B?Mm9iRm5qY3JrZkVSRU1EVWwwLzZGTEdzM1F2cExGaWlOd0x2SXlEYjgya3Bp?=
 =?utf-8?B?ODdpYWlwN1Raa1YyRWhRK01JaTFtMDJTVDFVYnp3WTFENS9EVG1QS1FDdGxO?=
 =?utf-8?B?MnpRbVl4bHUwaktYUTBldHlUWUlYQUZ2aU4rS1EyMGJnOHF4Z282UmJxb1N3?=
 =?utf-8?B?SzM4VHhsY1JITFZaSnVKbTc4d1NuS08zVkg3VER1N1QrRkRwR0Myc1B3TGhK?=
 =?utf-8?B?UTZEaG1tUzlROHBUOXJoVHNVL0ROVjFzY09RTTBBOWtJODFwWURpUlp3dEcw?=
 =?utf-8?B?eGFpa2FWaGp1bHR0dHpvSDhMYU5LYkxhc1VncldRcnhzaWlzNFZtWEZrNXBJ?=
 =?utf-8?B?N2FKWWtONUZSQm5LZ1hXN2FQbnFReTBTamVoclNpWmlKQnlOSEhzK2xqR21Y?=
 =?utf-8?B?RjEwdzJDNG0yUmRBV2Y3ZzQrVkFXelFLVGpVMWI5WERpQXgrMFBQU2szUlNC?=
 =?utf-8?B?M0dXdkdlNExBMHM3MWkxYjZyTjBJeXFxSkFrUSsyTUdCMldzUlhic1NyUTh3?=
 =?utf-8?B?OHRBYnFDWU9hMVFvOFViRURiVEFsQVVTZlJwelZwWDNTbE50MzI4Y3N2MU5p?=
 =?utf-8?B?QUNhZkEyUWtVZ2R6WHBvN2IwR2FOTERHL2k0dk5JNkt3UlI5YVJ4NXp0Slhl?=
 =?utf-8?B?OExhM3NzWnB0d3J5WlBqTmQ2MmI4YU5pQmM1b3pLQlhJOVVuaHZGbVI5ajNL?=
 =?utf-8?B?cG54L2MxSnUzOERCYXZ5TTJrV05MZ2FHYzhxcDFDZXkyNnZJM2JKb3JUOWYv?=
 =?utf-8?B?UUVjUDAwTDdJdHZtckFIY3laN3BnbW5OOTBnTG4rdVA3Nit0VVJZQnV2QjFx?=
 =?utf-8?B?eDJIUTdaZVJGYlFVOXI3cTBqZ3ZMSWQ3Tk16ajNXdGxxemxNN29lTEVlZjI4?=
 =?utf-8?B?dUVmT3NFa2J6LzFURVpCOUZJZ1BneTkzdlQ5R1dRTzFlZFV5Rjl6cVZ5NXU0?=
 =?utf-8?Q?ZHGtp8nzH/UFzVNmOZ/ZsA1RDRndI9Ji9avyE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8770.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(4022899009)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dy9SbTBzVjZpeGFPVFBKb1JzcExOS2FmaVZvSDQzNEx5OEtFS3ZMRXdRL2R1?=
 =?utf-8?B?bnc0SXJqMUErK1d1OHZkcDVqeHlpRGVEZGJhY3BFRDFqOEtPSE5NbmVtWDZ2?=
 =?utf-8?B?emV1MVNNZXdiaGFVQ3ZvRE82N0t1VWU3NllEQ3pyTEJUR09DVHQvRHhzTU1s?=
 =?utf-8?B?cEtnT1BSVjRWNnRPdFBsSllYUmJMa05XektheFNoZEhPbVRjVkhMem1VNnNC?=
 =?utf-8?B?UVU5ek9hcWNoUkZHaW5jRDh6Y2VQTGZoUnZBdDdXTkFKQXZlcmkzOVZBVklO?=
 =?utf-8?B?Q3dnQW54cGdUTjQwby9qaGh2MTBzUERqd2l1NmxpdGgxVHRuVjNmV2RkY0NH?=
 =?utf-8?B?TkNJc1Q2dllwazc3eGhxZmxPQ1ZSWkFqaDdMOHhQM2hkUzJkUjhDVVE4VUkx?=
 =?utf-8?B?Zk9uZHhzWnhxZW15a3hObE4yT3R5V243VmFic0p5cGVuSkYrdHByN2dXTkVW?=
 =?utf-8?B?eThMVG85YllSdjFpZk9QUHpTcGJPRGFPaWRIOXpBQVpjeGJRTnJObXdwQnVp?=
 =?utf-8?B?UUF0U25aUGF3azBpR1pxL2g4MXI0MzV5bzg1bERJZHFRMGR6ZjJPVjF0b2l6?=
 =?utf-8?B?UEUvSTl0Q0RNNXNSNDZJVjUzSUpPT1BqT0U3QmEvT2pwVS9tU0g4a05neDgx?=
 =?utf-8?B?VU1ka2szUjdUTXlCVG9JcFNPUUFvVEJPOG5YaThLak1heUk1b2pZdm1oajdJ?=
 =?utf-8?B?ellhSGkraEJ2enY1SXpzcTZOU3pyT2M4cDE1TlVIcTVNdUh1enhNdXB0ZnhW?=
 =?utf-8?B?NmpSUXhrV3hZZmJ6aFhVOXVGOGVMM245aFV4MWFvVG9TZHJMWlNjbUNrcXov?=
 =?utf-8?B?aTRvZENmblg4K3BUVTdlY3phbjJyT05OSENZWEhyd3ZOZThvVmlJUlNKVHhz?=
 =?utf-8?B?endlc0NlSUIrNlVqUGVFbW1Ra2IxZklzNmgxczkxSzcrSGZwdXNETklKQ3ZF?=
 =?utf-8?B?dVIxM29wWFRtUklBVXRoZ1lNSlVNaW5wWWRubisrblpOU3VJRWZYK3N6ODdF?=
 =?utf-8?B?L1BGenBmU0loMnJBbVJVejJjM091TVFXZEZ0T0lyd0xuT1Q4c1RidTY3Rmgy?=
 =?utf-8?B?VUhxYVR3TFZzUWIvNlNqTDhLdVhRbWdINk9LbWpGV0dXQVI3Ymhud0RTYXpV?=
 =?utf-8?B?UTYvcmxlSTl4UEp6Y3E5OG1RTFVuMGlKRkFqZU9VVFMrbHVoMkhHSW92aWRh?=
 =?utf-8?B?aUdjWGF4NE80Ykd4OHZvQjZJWk9EWHUrZkk0S092Z2hMQTJ1dE5uNXVZU3pJ?=
 =?utf-8?B?ZG4zQ3hrVTI4QmZIOTZSR21zam4wTVUzS2x6b2VoTzEreGU0enlxUjR1WitR?=
 =?utf-8?B?UG5PMkxiZHM4bzdYQ2hlei9RbWJ4VitKOFp3enpBSFNNUnBYZm05YVUrTGEx?=
 =?utf-8?B?MHlOR1I1T3F4RjJORlZCTnVibHEyQzBINm9IN2pMWWUwcTJXSEZ4TXNuVHAw?=
 =?utf-8?B?aExwajBxajZEMk5MVHFBdFJLaTRJanZWMWRqd0RRNmp4Y2MycEI3N0VranI4?=
 =?utf-8?B?WnJKNzQzbWRjUkhkK1hKS0VTUTdTNmpPSUZyUDF2VDNXWXJCT091RzFmandR?=
 =?utf-8?B?K1lBN3ZUUzhIVEpIVWZITHJONjNwalIwNTZBMEV6ZE96cjhKUGVHclBCL1dV?=
 =?utf-8?B?RmNQSXRoQTFsT0dyUW9FYmFibmhzTEV1bmVoMGdQaXFmMVlaWTNMUFRKUTh5?=
 =?utf-8?B?Ky9ZMm1QNWJ6SkRzWjZzakd3M2dYczNQYWYwNmJKbGtSRFJvNXlLQjJScHVU?=
 =?utf-8?B?U2NFS0Fnc21ySTFrWjFyZzNpZmtnTTNwRmhnZ3BiRGlBRE91UDRKRGZjL0gz?=
 =?utf-8?B?YndlSzNPMjM1UXdPODJLYXBaYXQ1dkRTQUN4Yjk3eTMzRGMyR3g2Tjl5bStz?=
 =?utf-8?B?dFhhUG11UU1CMXpiVG1Ob2h0TEMySVNlaDU2SFRkOGdyU1MzM3IrL3RBQWZV?=
 =?utf-8?B?VlVoN1h5RFEyVXZaY2krMnJpSXRPVzVkSm1rYkNMcG1LaGVadWpQSDBHM1dX?=
 =?utf-8?B?NjVQNWhCa0RWVkJ0S2JWQXk5RTlTSkFkbkxFSWE4V3FWNHJQc0h3N3ZMRVpP?=
 =?utf-8?B?WFhFalRpZjBHRjltWTNPeVBCS0JVQ1FFdENaY3pWNXlDdk81ZEtyajE2TkVr?=
 =?utf-8?Q?Hyw7VjrvZyaOsrkyBnbR5Ga2m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02935656-20af-4a33-4aef-08ddde6414ed
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 14:32:38.6889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tDO8tg2Wfx6qp+uBO2uNOYkNg2trdgowfjdCgW70z3qvPmi3X0gg8EcFS2hDvBKqqvwYylHNGUKwCEorcW464A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9028
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 18 Aug 2025 14:32:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2034


On 8/17/2025 9:51 PM, Lee Chee Yang via lists.yoctoproject.org wrote:
>
>> -----Original Message-----
>> From: Gundlupet Raju, Sandeep <sandeep.gundlupet-raju@amd.com>
>> Sent: Saturday, 16 August, 2025 10:32 AM
>> To: yocto-patches@lists.yoctoproject.org; Lee, Chee Yang
>> <chee.yang.lee@intel.com>
>> Subject: Re: [yocto-patches] [meta-zephyr][scarthgap][PATCH v5 4/12] zephyr-
>> image: Add image artifacts to output files
>>
>>
>> On 8/13/2025 7:02 PM, Sandeep Gundlupet Raju via lists.yoctoproject.org
>> wrote:
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>> Thanks,
>>> Sandeep
>>>> -----Original Message-----
>>>> From: yocto-patches@lists.yoctoproject.org <yocto-
>>>> patches@lists.yoctoproject.org> On Behalf Of Lee Chee Yang via
>>>> lists.yoctoproject.org
>>>> Sent: Tuesday, August 12, 2025 9:13 PM
>>>> To: yocto-patches@lists.yoctoproject.org
>>>> Subject: Re: [yocto-patches] [meta-zephyr][scarthgap][PATCH v5 4/12]
>>>> zephyr-
>>>> image: Add image artifacts to output files
>>>>
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: yocto-patches@lists.yoctoproject.org <yocto-
>>>>> patches@lists.yoctoproject.org> On Behalf Of Sandeep Gundlupet Raju
>>>>> via lists.yoctoproject.org
>>>>> Sent: Wednesday, 13 August, 2025 1:42 AM
>>>>> To: yocto-patches@lists.yoctoproject.org; Lee, Chee Yang
>>>>> <chee.yang.lee@intel.com>
>>>>> Subject: [yocto-patches] [meta-zephyr][scarthgap][PATCH v5 4/12]
>>>>> zephyr-
>>>>> image: Add image artifacts to output files
>>>>>
>>>>> Inherit image-artifact-names bbclass in zephyr-image.inc and add
>>>>> image artifacts to output generated files.
>>>>>
>>>>> Before:
>>>>> zephyr-helloworld.elf
>>>>>
>>>>> After:
>>>>> zephyr-helloworld-{MACHINE}-{DATETIME}.elf
>>>>>
>>>>> Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-
>>>> raju@amd.com>
>>>>> ---
>>>>>    .../zephyr-kernel/zephyr-image.inc            | 28 +++++++++++++++----
>>>>>    1 file changed, 23 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git
>>>>> a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
>>>>> b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
>>>>> index d6ee21f..93d36b1 100644
>>>>> --- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
>>>>> +++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
>>>>> @@ -1,29 +1,47 @@
>>>>>    require zephyr-kernel-src.inc
>>>>>    require zephyr-kernel-common.inc
>>>>> -inherit deploy
>>>>> +inherit deploy image-artifact-names
>>>>>
>>>>>    OECMAKE_SOURCEPATH = "${ZEPHYR_SRC_DIR}"
>>>>>
>>>>> +ZEPHYR_IMAGE_LINK_NAME ?= "${PN}-${MACHINE}"
>>>>> +ZEPHYR_IMAGE_BASE_NAME ?= "${PN}-
>>>>> ${MACHINE}${IMAGE_VERSION_SUFFIX}"
>>>>> +
>>>>>    do_install() {
>>>>>        install -d ${D}/firmware
>>>>>
>>>>> -    install -D ${B}/zephyr/${ZEPHYR_MAKE_OUTPUT}
>>>> ${D}/firmware/${PN}.elf
>>>>
>>>> Since this is for stable branch, I think we should keep the
>>>> elf/bin/efi file with old naming. We can deploy both ${PN}.elf and
>>>> ${ZEPHYR_IMAGE_BASE_NAME}.elf,  ${PN}.elf can be copy of/soft link to
>>>> latest  ${ZEPHYR_IMAGE_BASE_NAME}.elf, same for .bin and .efi.
>>>>
>>> [Sandeep] : Agreed this is for stable branch but to me this seems to be a bug.
>> Deploying ${PN}.elf is not a YP best practice. What do you think?
>> [Sandeep]: Chee Yang, ping on above question.[]
> This has been default behaviour for long time, I think some existing build might have expected latest build deploy with ${PN}.elf. Agree that we can drop ${PN}.elf for master.
[Sandeep]: Ok sounds good I will put it back.
>
>
>>>>
>>>>
>>>>> +    install -D ${B}/zephyr/${ZEPHYR_MAKE_OUTPUT}
>>>>> + ${D}/firmware/${ZEPHYR_IMAGE_BASE_NAME}.elf
>>>>>
>>>>>        if [ -f ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT} ]
>>>>>        then
>>>>> -      install -D ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT}
>>>>> ${D}/firmware/${PN}.bin
>>>>> +      install -D ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT}
>>>>> + ${D}/firmware/${ZEPHYR_IMAGE_BASE_NAME}.bin
>>>>>        fi
>>>>>
>>>>>        if [ -f ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT} ]
>>>>>        then
>>>>> -      install -D ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT}
>>>>> ${D}/firmware/${PN}.efi
>>>>> +      install -D ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT}
>>>>> + ${D}/firmware/${ZEPHYR_IMAGE_BASE_NAME}.efi
>>>>>        fi
>>>>>    }
>>>>> +
>>>>>    FILES:${PN} = "/firmware"
>>>>>    INSANE_SKIP += "ldflags buildpaths"
>>>>>    SYSROOT_DIRS += "/firmware"
>>>>>
>>>>>    do_deploy() {
>>>>> -    cp ${D}/firmware/${PN}.* ${DEPLOYDIR}/
>>>>> +    cp ${B}/zephyr/${ZEPHYR_MAKE_OUTPUT}
>>>>> ${DEPLOYDIR}/${ZEPHYR_IMAGE_BASE_NAME}.elf
>>>>> +    ln -sf ${ZEPHYR_IMAGE_BASE_NAME}.elf
>>>>> + ${DEPLOYDIR}/${ZEPHYR_IMAGE_LINK_NAME}.elf
>>>>> +
>>>>> +    if [ -f ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT} ]
>>>>> +    then
>>>>> +       cp ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT}
>>>>> ${DEPLOYDIR}/${ZEPHYR_IMAGE_BASE_NAME}.bin
>>>>> +       ln -sf ${ZEPHYR_IMAGE_BASE_NAME}.bin
>>>>> ${DEPLOYDIR}/${ZEPHYR_IMAGE_LINK_NAME}.bin
>>>>> +    fi
>>>>> +
>>>>> +    if [ -f ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT} ]
>>>>> +    then
>>>>> +       cp ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT}
>>>>> ${DEPLOYDIR}/${ZEPHYR_IMAGE_BASE_NAME}.efi
>>>>> +       ln -sf ${ZEPHYR_IMAGE_BASE_NAME}.efi
>>>>> ${DEPLOYDIR}/${ZEPHYR_IMAGE_LINK_NAME}.efi
>>>>> +    fi
>>>>> +
>>>>>    }
>>>>>    addtask deploy after do_install
>>>>> --
>>>>> 2.34.1
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>
>>>>
>>>>
>>>
>>>
>>>
>>>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2032): https://lists.yoctoproject.org/g/yocto-patches/message/2032
> Mute This Topic: https://lists.yoctoproject.org/mt/114670142/3619217
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/14411013/3619217/657730681/xyzzy [sandeep.gundlupet-raju@amd.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

