Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E86CA0EF5
	for <webhook@archiver.kernel.org>; Tue, 19 Aug 2025 19:43:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.41])
 by mx.groups.io with SMTP id smtpd.web11.2863.1755632613650781120
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 19 Aug 2025 12:43:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amd.com header.s=selector1 header.b=nnoXewcB;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.243.41, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfc3zrl8SQtGn+p2BqhIqc12Zm/wwG2rV42bzHs7wsGqvnlp0++nDoma9zBG6dTglxjrmF9uYbZOonUFXdp1DH2/3MmS76ZI5VNEkDbKfd4J191OMy815jsIW+gK3WPj+PlYvXX6U1cQCH0JG7ZxLtm/CUDvQTIlmiEOR3+4+DciQ7j0eToh2dzJZ/ln0HY8iqVD5313N828zPK/lRiT7aaOtVfSahq14dADtB+eMpoHF3HAEQq9mMZdL3ZeZev/30n3xDWoTdswpw0tk6T836R5DJJfZ8p0A3vZGBkwRbOW78nsbfwfsl5TkUxPT2XCwaOx/Wdhjf3zOojDu4Addg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZc+ifDLcI6p2+sAeRVS/ycCEFuv8pfoCjcZfRHgPuE=;
 b=jBwTFLBgVBa3TbVhDZjUqueFQNg8r9OFkT0ER7V5//WnvZk5zz3AVrbCLDxlgnxqO5XWZo5cLu7742Ie+ete3L2hUtf6D1IG6uJFk4roAS3/udk0kOjFELUVcJqKythrhNMUHueB157on1pOCl4khBxwdTn/IU48r6xLFxBiuH2BC1hOQkvjnjOVSXsZ1gZfub5d7hKT8FHgMaq/M+yOg+fJK55nijQWiaJ5fsgGqOrB4VQssnFycPkvNDVPiH24E0CJfrllyP2pD9TYOpG9pCLkESlx+BODZ+7+YI1O1knjKwRqaJJ3l81Cjxc3TQPl6gFA3mBg/MYs2TB6aln3FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZc+ifDLcI6p2+sAeRVS/ycCEFuv8pfoCjcZfRHgPuE=;
 b=nnoXewcBDiO7iw5s43WizVF5KHOJ5ummJNXTdO6vfxOGlAkNgO18b+398oOwe3c64/fNI3lenY0b9AthKvf1LotlRFnePjQ50k5TCB6mAFI2nJSiJpZyBKG+Lb8ARPlDtSTllMj63+dI7CqTpSk4WZHSvSoOJI1qdnNdUfZn6cY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21)
 by DS7PR12MB6166.namprd12.prod.outlook.com (2603:10b6:8:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Tue, 19 Aug
 2025 19:43:28 +0000
Received: from SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7]) by SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7%6]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 19:43:27 +0000
Message-ID: <7120910e-591a-4e1f-a105-d089b8f9f3fe@amd.com>
Date: Tue, 19 Aug 2025 13:43:24 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-zephyr][master][PATCH 11/12] zephyr-kernel:
 Add rpmsg multi services recipe
To: yocto-patches@lists.yoctoproject.org
References: <20250815035449.2816001-1-sandeep.gundlupet-raju@amd.com>
 <20250815035449.2816001-12-sandeep.gundlupet-raju@amd.com>
 <BL4PR11MB8797B7EFFB60C164F9E3FD61B930A@BL4PR11MB8797.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Gundlupet Raju, Sandeep" <sandeep.gundlupet-raju@amd.com>
In-Reply-To: <BL4PR11MB8797B7EFFB60C164F9E3FD61B930A@BL4PR11MB8797.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0026.namprd12.prod.outlook.com
 (2603:10b6:610:57::36) To SN7PR12MB8770.namprd12.prod.outlook.com
 (2603:10b6:806:34b::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8770:EE_|DS7PR12MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: 2023a40f-2290-40e0-c1f2-08dddf58aa99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|4022899009|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZGxaRHgwbHR1U05IUS94TTZIMmxpa3FUR0NQaFJQSzRvdWV0bTY1emZMeHVN?=
 =?utf-8?B?OUdJVE1WODZiYVdDanFJYjQxWmxMWXN3SXZiWUpEWFZ3Y21BajhGZGhLcnQy?=
 =?utf-8?B?U3lCNDhZMjlKSE05eG1pT21IcVdqNW5SeUlTVVZiemVQc1hjdCswN0tQUzFZ?=
 =?utf-8?B?U0JUU0JyMS9kaTR6c3FIczdGSE9zUERKTjNDMjZQenpQTndzUm0wemtlVDhW?=
 =?utf-8?B?OTBSMmhBYk95K0MzbXJDOS85c25ZNEZYZTAxWVhiLy8wcERUV01lcWw2T3NK?=
 =?utf-8?B?dnRjV0JaMGtrM0pEM3ZQTS9ZblZaUEpVcDdxQmkvNHVCWm56akVIY01PRUVy?=
 =?utf-8?B?WXRZREdlamVMaGhncnc0VldvR3haaWxoek1sV3ppRlNGRVY3YmYvRHBSTXFp?=
 =?utf-8?B?OVdWZnBGWTJqWm5kbkZYZkRoaDROR25yMjgybit0c3c2a1RWb1psRlZ6RUp4?=
 =?utf-8?B?Q0hpYkozWkQ1UW41M0VDSWJWMkhmV1lGMmlQcTdGb2R2SWEwaFRaaW5PTGo2?=
 =?utf-8?B?MUJDa09pOFBUa0pjeks2emhsNFhQeG5wd1NDOFMrVHRBd2EvQ3dRa1I2Ym9p?=
 =?utf-8?B?S3dxUWNhSGlLMWo3MVpvM0dvZUpyWkVGUEVtSWZzSCtlN0MyQ1dscGNQazhB?=
 =?utf-8?B?d1F6NVpSR1BnZ1JBQVc4ZFc1R1FoTGU2dUs1Z1BOSjgyaEpnT1dXV0FuelR6?=
 =?utf-8?B?aHVwQXB6eWRWcC9qbEgzSFNiaUlVUU5YalgweTM0bHdhd1A3b0o2eDNCc0VG?=
 =?utf-8?B?bnhZc1NGY1RzMWFzcmJaMjBQdklRdnhOOStjM1BNR1psdWZrZUhMcTZPaklV?=
 =?utf-8?B?M2Uyc3BPS2VsSGIzc0I4WVljN1lmeE5FSU5UTkF3a1BYRWhUMlM4cmllWk5W?=
 =?utf-8?B?U3FydzV4T05FMGRNSTVFOTlHckM5TmFtT2RpSjFHQ0ljM3pJckFYa3F3UEI4?=
 =?utf-8?B?S1R1Q20zREJmN1R4bFhQNHcvMjlxTTVLUytYK2t2UjlVQ1JOTUU4Z3Jlc0I2?=
 =?utf-8?B?VkgwYzVHUFl6L3ZpcytIOHIvVG5RbWRQdFdGckhnQ0U1dXUrQTU2KzFVa3d6?=
 =?utf-8?B?amx6VU1sOGNVNTVFZExVd3drM3oyMWR4SFdrNGI4aUg0QStucmVBUnRNeFgz?=
 =?utf-8?B?WHZ0VGpkdXpmRUNGQ1FlNUo4YndVbG9YeXhwbmhqUE5vN2JRT3ZYQUg2UFlt?=
 =?utf-8?B?MDA4cEE4Z1BCb2lZY2ZHSFRiSnl4YTUwaG0xVzYxVS9oL2RFRHlvS1RaVmRv?=
 =?utf-8?B?Qm0rZkp2a2srU0xNYUt4OUdob2tidk9mUDFmNnRMSEp4UWlsSFcyek1KaEtD?=
 =?utf-8?B?NUFub3RVclBLbmg4cVpCMU93a3N2dzRtRDViV2dGeTdQd00vN0E4UWsxMk5Y?=
 =?utf-8?B?TnNDWHpQNXkrbnZOVVFQQzZlaC91MHd3VFZ5RFhJTGx2cHVWSkVsV3dKTlNj?=
 =?utf-8?B?V1V1WHVRRTVXcUJ4OXFtUWJ1K05MeGxZUHVPTmRqR2gyRTRZUVI3eElzekor?=
 =?utf-8?B?RFJGN1YzUU1GL09GZVB0UHNmWlY0K1IybWxEb0hhdStHaFlDNTBzM0RLaUF1?=
 =?utf-8?B?NUFYcEIzV2pwYjI4MmNpOFFITnZsdVZIT0FCOCtEMzZJaHVkR3ZJREJmb1JE?=
 =?utf-8?B?SHRDS294VE5rWXZtdUlnV2dmWVVWQWR6V0ZEZjZBNldLQ0hFdUlPQlpwWmMw?=
 =?utf-8?B?MGZxNkJIZ3JwUWdCNXJXc0dqaTRKc1RuSjBhQWpTRjkvb2x5aU5GR3VzZWky?=
 =?utf-8?B?UHBqWEVLOVhEdm5CY09JVVE2OFVlOTRHcjJRdGJZRlh3L1dkZmJBUTRaUjRF?=
 =?utf-8?Q?XfBfiOdcrkJJCo6H1AbB8Q8O9E+6BCNeCUWTY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8770.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(4022899009)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eFRPbzFITWhhclBkQkZncU54YXluYWdzY0x3WnAzNlBBNFJBdE1MRFpWTkxK?=
 =?utf-8?B?TG13RERuMzlZSmpldHdwTHNweXVJTFhNdEtYZDRPeExkWW51Y2IxdVE2STlq?=
 =?utf-8?B?WFNxRENyRjliRHZ2L3Q2SlJTNUNrd3U5OENUZUhFNGlLRlZxZlIrQ0NPYnpj?=
 =?utf-8?B?MHBpTnhSekphclVac1RkQTM4cUhRRzBzWmNyWEsrL1l4cjBWSGdvQ1lIVmU3?=
 =?utf-8?B?M3c0bkZZVVcvUmRxTzMxWEl6ZUh5a3h1aFVhc2VOaGNacFZzZjlCd2IyTU9B?=
 =?utf-8?B?RDRPeW5pR091MlE5cU9EL1Y1OFk5VThQM0Eyc1NEb2lTRys4M0pvd3NHeVFX?=
 =?utf-8?B?Umh6Z0hrNkVWemhSOUJ4OGVCdDNIZDB2T3NxZEl0aW5FV2pYaVVEMTd0Wml4?=
 =?utf-8?B?TDd1bkdjSElteGhkSFlQa0lLL1dqZ0Z2RzIxU0dxc0x2MnJOM3VaV1BMRGJ4?=
 =?utf-8?B?d1Rwd0hiTUs2MHVJcXV2dUM0UE5XdHdwd2ZJNlNqNXlZSXRkdFF3QUdxa2tr?=
 =?utf-8?B?ZXFtMnJ5QmVyOXc3VnRPeDdCbG9aaWswTXlhM2FpNjBoc0xsZDJYSzV4dmQ5?=
 =?utf-8?B?TnVxU2ZPY2N5TElySEhaTUZkQ1Zud1FkNFN6eU9XWXJDYlhKcklUYk1aMFhU?=
 =?utf-8?B?SHVNSWJsdW1udGJySDhSMlczdmJINHJhMmVJeFF0aXJXU2VscVZnUnhVNU85?=
 =?utf-8?B?anNGd3lvSG9yNW1ZbllKaEQ0dkF2WU4vTEdzc09nQnR2aHVUN3RUSk1ZcVFx?=
 =?utf-8?B?am1LSFJEUCt2VUJFclVZc2RyZ0VsOFE2Zk5hdEhVTVlSdm1lS2hlREdKQVFZ?=
 =?utf-8?B?Q3hXbFlBTk1VY1p3elJYQkVHc2YrMmVyV3FiUkJIRlhKUHNKbEN6dytiTkVC?=
 =?utf-8?B?eDJJclNWMnQweFVybUZEbFA5SkhyOG5xTzFoQnFIVjlJMnhFM1pHRCtsdisy?=
 =?utf-8?B?RkhEWXN5MjFpRmh6akFxQkJOZVhKaEdObGgrNmJOY3c0ZnZINksvRTdjKzBz?=
 =?utf-8?B?bW45L0VsdWdBYzlvc2huT3dXN0c4ZVhxUDJKb3VHR1l3NzB4citMcy9VbFUr?=
 =?utf-8?B?cVRlYnZpdDFLaUxSVXE2UUVJbHNnNUNZSjJlTGZyWHFoT3FMeExiUU1oUDEy?=
 =?utf-8?B?ZHprRmpEYWZISEhYMzZock5jR000ZW1SdXJSZTdQTmdnM1liSjNIOWpyM2Jq?=
 =?utf-8?B?eC82a3VRSDR5NjFmUFZiLzdpbHNaemJqQUZzdjl5NUM3WXJSdDRzUUtXOHY2?=
 =?utf-8?B?ZFFIa3NHVy9BenBITFZ1c3hsc1RVM3dERTdwbEtNK0tZbXRldFp4WWFtTW5s?=
 =?utf-8?B?RXFyY0dubG1ETWFiTkY4WVFXV0RWemFXMnZXSC9WMUtEZzdXWEFRN21HQUR6?=
 =?utf-8?B?dFRjTXlJbGtaUjBaZ2J2SXdVSjFkSmY1THVlclpoVjB5eHk1YkVXRlBES3Zj?=
 =?utf-8?B?QVIxQm5lRDdSaFh6QVptRjYxQ245cDdxQ2IyQjVqcjcrdXMrYmhhU2ZvTzVI?=
 =?utf-8?B?VXFJV3NzeUtVRFUxTkV1ZCtLazVUbHpIRWJFZWlnUXpLK1ZFSWVsMmovOENR?=
 =?utf-8?B?bVJnVFdBVGcwVEJvajloVUVrRllkWnAxSGRLZDUyRHhRcE9qNmRjYUF0bTdC?=
 =?utf-8?B?OEtHTThnbk9VQzF4VnpPUU40NWNkc1JvcjIwMU5GNHhGQSs1S2RlWWZkUWR1?=
 =?utf-8?B?UUU5SHE0SUVMeU56S2FuSTRFU0hmcG1RcVBWeFN0UFB2T2xoaTl1a0RxWFpM?=
 =?utf-8?B?UDV4emlpS2ljOWJjNEFTTVgyODdFdXY0dkZEb01BdlpYL3hXSGI2TDBOcDJ5?=
 =?utf-8?B?eENTMGxuUXJPS0hRYXhsdW4wNEZnNkhBQTA4WHFnQnd6L1E2UkZJM29wY0oy?=
 =?utf-8?B?TE9JRVBHQnZsQm5Fcmk5ckNqbnl2TEREYzNweGUzZm5BM1h2V0ZhL0E5NFdt?=
 =?utf-8?B?bjM1MXNFY09jRXkvSFp5SDdXMXJpMG15b0phdlZ6bVVxMkxiaFFUWEREdldC?=
 =?utf-8?B?NzJqVU94OHpmQXJac0I0QnJZSG01RDl4eDF0M0lKK3ZGYzBUcDFQMDJUSSsw?=
 =?utf-8?B?aUhnbWQzdWNEZldJVjdocC93MHJXNytZVTJTOHgzZ1NuYUJkVThYOVkvMy83?=
 =?utf-8?Q?1Wp1//9n2743/YDQ0jzzf9Ivz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2023a40f-2290-40e0-c1f2-08dddf58aa99
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 19:43:27.0237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdPevjeWxXcLGqU6prNXzeKvKOFugU9Z53et0Sr3eYVTOdHAda4swpEXEZBL84IXq0icbQO1ZpgOdjebSGbqvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6166
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 19 Aug 2025 19:43:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2059


On 8/18/2025 8:02 PM, Lee Chee Yang via lists.yoctoproject.org wrote:
>
>> -----Original Message-----
>> From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
>> Sent: Friday, 15 August, 2025 11:55 AM
>> To: yocto-patches@lists.yoctoproject.org; Lee, Chee Yang
>> <chee.yang.lee@intel.com>
>> Subject: [meta-zephyr][master][PATCH 11/12] zephyr-kernel: Add rpmsg
>> multi services recipe
>>
>> Add zephyr-openamp-rpmsg-mulit-services recipe to build out of tree
>> openamp-system-reference example applications.
>>
>> Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-
>> raju@amd.com>
>> ---
>>   .../zephyr-openamp-rpmsg-multi-srv.bb         | 23 +++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>   create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-
>> openamp-rpmsg-multi-srv.bb
>>
>> diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-
>> rpmsg-multi-srv.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-
>> openamp-rpmsg-multi-srv.bb
>> new file mode 100644
>> index 0000000..222ed2b
>> --- /dev/null
>> +++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-
>> rpmsg
>> +++ -multi-srv.bb
>> @@ -0,0 +1,23 @@
>> +SUMMARY = "Open AMP rpmsg multi services"
>> +DESCRIPTION = "Open AMP rpmsg multi services"
>> +
>> +inherit zephyr-sample
>> +
>> +SRC_URI_ZEPHYR_OPEN_AMP_SYS_REF ?=
>> "git://github.com/OpenAMP/openamp-system-reference;protocol=https"
>> +
>> +BRANCH ?= "v2024.05"
>> +BRANCHARG = "${@['nobranch=1',
>> 'branch=${BRANCH}'][d.getVar('BRANCH', True) != '']}"
>> +
>> +SRC_URI:append = " \
>> +    ${SRC_URI_ZEPHYR_OPEN_AMP_SYS_REF};name=open-amp-sys-
>> ref;${BRANCHARG};destsuffix=git/open-amp-sys-ref \
> should be " destsuffix=${P}/open-amp-sys-ref " for master branch
>
> I was facing error while building this recipe
>
> CMake Error at /data/master/poky/build-zephyr/tmp/work/qemu-cortex-a9-zephyr/zephyr-openamp-rpmsg-multi-srv/4.1.0+git/sources/zephyr-openamp-rpmsg-multi-srv-4.1.0+git/modules/hal/libmetal/libmetal/CMakeLists.txt:1 (cmake_minimum_required):
>    Compatibility with CMake < 3.5 has been removed from CMake.
[Sandeep]: Let me check why I didn't see this issue. and send a v2 patch.
>
>
>
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2053): https://lists.yoctoproject.org/g/yocto-patches/message/2053
> Mute This Topic: https://lists.yoctoproject.org/mt/114713062/8188369
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/14211927/8188369/518048116/xyzzy [santraju@amd.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

