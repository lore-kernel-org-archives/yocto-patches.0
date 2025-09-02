Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1D6CA1005
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 14:01:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (NAM11-BN8-obe.outbound.protection.outlook.com [40.107.236.52])
 by mx.groups.io with SMTP id smtpd.web11.78109.1756821663122639038
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 02 Sep 2025 07:01:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amd.com header.s=selector1 header.b=19zD8gk1;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.236.52, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHr0ESfy1H9aEmPaxpHQXODLZOhui6XhJtGsU6wRun9RoJ+QG2Esw8Bf2EzTAIkv42ow6x4sEHJBwZKSdBezuEXst+HueoWtbtpSVAqkwVQ2pXt9Uis6L15nBHEixMgLylsinOikCL+8DFABq0K9AnqcVxGjp06Jl2ZMXzkgJV+qBlRz16dSHXuePHf+ntnB3iy6E2EUIhcppXzWz9tIgZkXFzikUIRcgYxQEbdKvnKd21nhwVvB1xF3Me3YN4SM05G9RAYm9VwEzzJ0yBp0zVaqA5pxAhWGpd6/25shhBqYlOgYHbSO155QGDKhNTNt8QD67fuVDY8h12BMm6U2Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DC5ujAlBUkJRw66Zodh2BfD9EuUwd5KbyKxIqXQu0yE=;
 b=i8fstQtUwW1fJlJjg7sqfy6m1LQtKPIrJ673DUzDorG8osVFxd/Nt7Y6LnBQ60ja5I4TTg+iaiummAfNFkyGKadkvbJbhXto2wipjKSxoOT1g+TAplvQJ1/ZA9fspr9mY4XBUUPu75q+f3CGJUpA3NC7ZQM6ZF1WGjZlsByN1JL7kM58U7hE50eEG8im7v8klErNXe9LTOH/cbt1pqKCDXzsPhSBYvWVyx0LWra1N7FailjAl3wzmMAIec9HoIEQojzF79IywKbxU6iGpGJwmrJFq53whhnD/fgQvuKs9l1+GdJJ/AL/dB5Esj1MyQHdHgstE/By8DF0jV78zkb5kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DC5ujAlBUkJRw66Zodh2BfD9EuUwd5KbyKxIqXQu0yE=;
 b=19zD8gk1Ot59fLiIyUfCcr4gyDk4/gjTkCZoVDRpOrkpBXh4uUnLIX1pPyln/oA3VW6p6cfLdXTp3fBjs22SHyOjbd0t7xjTdQScFWO70bmaisd8v47XBwTDt+8s/+gflRHNsyaizk4CLx5iuK8ezMV7m01nzDuc48IVANzvBa0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21)
 by CY5PR12MB6646.namprd12.prod.outlook.com (2603:10b6:930:41::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 14:00:59 +0000
Received: from SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7]) by SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7%6]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 14:00:59 +0000
Content-Type: multipart/alternative;
 boundary="------------JZjxSOCGhBELQLEeRjYmV0ZS"
Message-ID: <dcf4fa12-a651-41e4-b84b-7552cbb21bb8@amd.com>
Date: Tue, 2 Sep 2025 08:00:57 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-zephyr][master][PATCH v3 1/1]
 zephyr-kernel: Add rpmsg multi services recipe
To: "Lee, Chee Yang" <chee.yang.lee@intel.com>,
 "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
References: <20250820143951.4033778-1-sandeep.gundlupet-raju@amd.com>
 <BL4PR11MB8797F6E908FBFEF26CBDF6FDB93BA@BL4PR11MB8797.namprd11.prod.outlook.com>
 <61e57828-9a49-4d5d-b622-ef063cf444d7@amd.com>
 <BL4PR11MB87973A5091395D9BBC292047B93AA@BL4PR11MB8797.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Gundlupet Raju, Sandeep" <sandeep.gundlupet-raju@amd.com>
In-Reply-To: <BL4PR11MB87973A5091395D9BBC292047B93AA@BL4PR11MB8797.namprd11.prod.outlook.com>
X-ClientProxiedBy: SA9PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:806:20::21) To SN7PR12MB8770.namprd12.prod.outlook.com
 (2603:10b6:806:34b::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8770:EE_|CY5PR12MB6646:EE_
X-MS-Office365-Filtering-Correlation-Id: eb13b633-b107-4c4e-16db-08ddea292510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bnVrZkJMRVRXdnFUK1g2NzhFYWlnWGlUREhTUVJVaTRQNVRhU2J6V3JBeFBk?=
 =?utf-8?B?bXpCdm5LcmxZSlBKZTZPNEMvL3lIRERiMGdLNklWbnZYY3czU3BTWFpJV29X?=
 =?utf-8?B?WE1tQ0VKK2pDOTg3QTMyNmNjYlhDeGQxZGJ5WGhHNFhBRmxtZEVudXlpa040?=
 =?utf-8?B?UENwRmU2T2x4NE5WTTlkbzFHUEgxR0hBM1hWR2N6emNva1AzSSttTFVZayth?=
 =?utf-8?B?bTd5dm1KUjhEN2tEbzBuc200cW5RbWZTa2hMQkMxUEE3ZU93ZnhaQ1JhRHV2?=
 =?utf-8?B?UmkxVUg5dGdtRHhra2xSKys1T0M4WDJPZjBrTUN6NG1penVKUWo3aVIrLzNL?=
 =?utf-8?B?Y2llTktNLzdIVEJyTkcrcU00NDg1TXJQSzN2UytENEpvN3RqNmxlOVgwVGdx?=
 =?utf-8?B?cFI0YS8zVm1xa3I4LzA4c0drV0k3aTFrYXNPc0hodkhNM21hTEQzMEpjTjZP?=
 =?utf-8?B?OVBSbDlSQkhNd3k4dUpiMEtKdnBvcnpGaHNzWUhta3I5NFpVWnpSMzhCNldj?=
 =?utf-8?B?MW0vazI2S2czbEszZzNFbGpVMGxiWmJTSGdZcjY3ZFk1L29nQkc4cUgwakdm?=
 =?utf-8?B?aUV5dXFreTBmQ0tNdHhRT0wrblNlUFJXZTlSNXkwaU1JamRTLzExVy9taml1?=
 =?utf-8?B?amZ1WGFtaFJvcXhFWmcwaFpMYWpNZ1hhQkhUT1ZUOVE2ZEtFdG5qcDBlS0tL?=
 =?utf-8?B?QjRLT2FFS2VZNHYyYWJDMUh1ZU1NZjZ0b2d0eVhZOU1PcklTYkNEenRDWnVL?=
 =?utf-8?B?eEJFenRVMVB1UUdZdG5NWHFZWFg0Mk1BaThBTUtpT0Jhc3AwWVppY2l1MjFl?=
 =?utf-8?B?d0hZSmdMSUthNXJ0QmxFUVZnOHdjVm1XeGw3U3ZYUW80V2J2TUEwRGpNOFdP?=
 =?utf-8?B?V0g5b0x4VjVqd0U1NFprbFBHbE1yUW1kb0VHTzJ3bllyanNpYVljYXEra3h4?=
 =?utf-8?B?TFJ0blBTTExNU3QyL0FGVlJVM01UUXhlYUZIQWhwU0lxczlVdDkrR1N5MzVX?=
 =?utf-8?B?bFNyaHRtbWdSTlR0UEQvaGlhSEtqQ0hUTXMxdVNjdnFGZHpsL1BLcm56Z3Fa?=
 =?utf-8?B?dTMwNU1HTGE5ZHUzM29JNUFsUkxMZS9VVEtXNHlTWjFJSXVNL1BEQ1djVlZY?=
 =?utf-8?B?aFhnZnorenVqWWJpd1puOGtZTlNGa3kyTnAxQUNab2pCN1JaNXlzMEw5QnQr?=
 =?utf-8?B?UEJwbzVhYnJmSDl6b2pDQlJkZzk1ZHU3ckQ5UEFsdDYyd3lTbmkvRVNPTUNk?=
 =?utf-8?B?SDVvKzFCV3N5WmRrU1VlN054L3JoQzJJY0pPOSs3VldQaUdzM0ZLMkx0Znc4?=
 =?utf-8?B?aUpBUk0rcklMMW9ZUjd0QTJxa2tsOUtjb3p4K1BJNVJ2eXVxejlDK2NhNm4z?=
 =?utf-8?B?Q1NMbVd0Ty84RlRtSkFnNDd4TGpoMDZEajFkbkVOcWg5dnk2U0tvZ2kvRzBm?=
 =?utf-8?B?a1NOem5YZXFLZGNOMTFpZHgyL3NMSUZKakN3RnoyY3JQMWJqMSs1Q2F2empK?=
 =?utf-8?B?Um14d2doQnpqeFBoVXkvVVRFQVlmQ3l4K0xKL2phUnIrR3dRcVRlcEVQU1N6?=
 =?utf-8?B?NXZzUkg4KzBOaGtsV3d1TUhQdENoREM3UU1QZ3ZlKzI4Q3Y1S1EyaTBFWWlm?=
 =?utf-8?B?MXlOOUY2YVJvYzRNMkttTGZrTXZWdERLN2RPcnpmNE5sbndLVXRXQlNYOEc2?=
 =?utf-8?B?ZERsQTZJZ254VGJmZ245QktLTkpUWURxVzJhckRkVEtsK0ZrcHlFajZLM01i?=
 =?utf-8?B?SkREQ05Cem1RNUpBODhxRXFQeGZlNzNVT0pLMzNLMVRpTkplYk9iY2x2d2g5?=
 =?utf-8?B?ZWdzSDhCR1FISTB6Uzc0MlhnNUwwUFNTUkxHaldCL3A5a01mUzFETHBiRDBC?=
 =?utf-8?B?cEh4MFphUW9BNGJNM1p1b1JxZ29mQzVxS29STlp0MlhzMDFEYktQdlZNRWNK?=
 =?utf-8?Q?c6sPb0KU67s=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8770.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(8096899003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?djFHdVkzTW14RlBVWGMrR3lxaCtJSmhRVHVhTEpHMFFGV1BKcnhLSENFWHNz?=
 =?utf-8?B?UEFXcTVwME53Q2x0K2tDSFBpWjUzcWRpTzE0b3dodFdmUTVuZmsyWlBrNmJX?=
 =?utf-8?B?UEtVcW8vcks2ZEVsUTB2bTdrL2JSQ2lKSlVZYVBaTjhKcWcwN09rQzJ4U1py?=
 =?utf-8?B?SmZ5VlVadW5EUFg0aCt1SDJXUjFjSDFobTQ0YUg2QjlYR2dESWM1a3hGNDdM?=
 =?utf-8?B?a29BOHozamNNT21tRnJTR3JKZUlOeUgzVFNFbW5WLzVHRXBBRkUweWlPQXhj?=
 =?utf-8?B?Y3h2QmtFMWNoL3doMmJuNE5DVkRqSmp6VWp4QUp0Tlp0N2MxR0I2MVpEMjdm?=
 =?utf-8?B?dG1UODRRSlcrb1Znd01CSDJrUTQ2aG5nZmlWQmdsVzRENlFMTjV1Q2lZLytm?=
 =?utf-8?B?TE1va1doK01qbExZdWtKanMwTldrS1NvTFNnWTVjQjFGbDAxQnNDK3M2YjZE?=
 =?utf-8?B?L25lWlVGUVlzeXkwRkpLMVp5M0tvYnp2ZjMvR1Z1TVA1RHM4elJaeENIVzlu?=
 =?utf-8?B?RXpaNUI4N2E0ckRab0hmQWQvTUN4d1BjTTBTWDlSS1lDd0krcFJCUnJVb3ZM?=
 =?utf-8?B?azYvQnRudGRMWkhidExuYWxMbm9VZWdQOTExS0RuQVF6d2ViMDBHR2xJZEJX?=
 =?utf-8?B?YW1pMmVuQlhaNmtuRTJpbjkzVEpScjhxYkJqTkxIWTNkMXhZY1ZPRzRMQlZC?=
 =?utf-8?B?Sk0vaENBc1BTMDRaM2VxaTYwU2FiRE1qUkd1ZFVaOXV3QmdwOTRuOFZ4TWkx?=
 =?utf-8?B?K2tUWjhpR3JMbUtPRUFJUXJsaS8yOGIxaThNTGhBdVBodE5ZVHJHQmVKMzhW?=
 =?utf-8?B?QlZHRDV0dngxdHozOUVWdi9XWkYvaXp1NmN3R09JMWdrcEpRWExYalRXRitF?=
 =?utf-8?B?a2dwMVBjQXpvYnM4ci9NOUlIOGRYb0R4TlQxRXhwZW5DNTBVOTM4YTc4RU5y?=
 =?utf-8?B?OHZxckNqci9QbFk3T0NEaS9XUHhCZEQvYXVJdEhKZ2xGZHZtVTVvR3BMallW?=
 =?utf-8?B?UEZTSi9tTlAwT2t5Q2tJcG16M2ZxVTU5Q0JVM3hjdTlnTk81MCs2VWxDSjgr?=
 =?utf-8?B?VTFGM0RMQkRCMGp6ZDlYSVhyZzVUTUVjSVY4Z2d6QmluTG1tcktxbTExc3R2?=
 =?utf-8?B?UHVVeFlqZEZSUEpNS2dLdWJzTGVCNFJDRU1QbFNmQndIVTNmU3R4VDBZaU5L?=
 =?utf-8?B?d1g4bU02UUkxZmdSZm1MbEVjOFVYd3BXZVIwbHZYZG5SUVRnYlc0NHBXQVlK?=
 =?utf-8?B?c3krOHZjQ1pZcFRiR0l2bzdnQVRNRk9aM0JkMkdvbUluOVRvdGtWNFdRUkxJ?=
 =?utf-8?B?ZFRRKzVOc0xoVjd2bkd2S1IrVXIzZFR1QmUrWDM0ZDFyeHByeXAzdkVsK3hv?=
 =?utf-8?B?YjUwQ1RqMFk5U1J2S2dFYUw2WmJrRldTYVRDdHRkRXZYNXZHb3kvNlFlUVZM?=
 =?utf-8?B?L1FDUThLV3VYN0tJQWVhM2t3TEw4QUV6K294ZHd3c1drOWUxajNjdHFIaXd4?=
 =?utf-8?B?V2QrSmZKLzZTRisxajNFeEMzWlE4RkVHandsK0ZOUWxvcGQvU1E1TGU5WGhk?=
 =?utf-8?B?U1NnaTlndkRuWTgyZUtIR3B3R3dleVovMWdSMkdoRWlKRU9iWVVFanB2TlFj?=
 =?utf-8?B?NzZpSG1kN21VbXNSU0s1dkUwSVc4eGJCS1V6RnlPS0V4SWJpZTQwbEVZcWZx?=
 =?utf-8?B?VkZRM0huc1hRT1lhTTZDS1psdWpmOGlzSEYyeTV0aEhkYno3RE1KMmltRE9V?=
 =?utf-8?B?Q2JBUVBBbzJ3U3RPazF0RlB3ckx4R1d2b1NudUtKaVBCdHRhaGpibWdIbUpw?=
 =?utf-8?B?UkpaNFpaN0JMYnR1Vmx2TldqZ2luMEFzdVhqMXNHZ0RpQVRuSTBCUGs3RnJO?=
 =?utf-8?B?UFZqemk4UUs4aEFheUduRVFoWmw1endvWmpxcHNHeGs1cHNyQXAvNk9mUE9G?=
 =?utf-8?B?TldqZklIb051c3RqNThXYk9hZ0gzVGxBc0xRYXFBKzFyZ1Q1QTlYWjEwOXZW?=
 =?utf-8?B?VzRZeUdwdnZZL1R3eWkwdmF5MXM2UUF4N1Q3d292QTVLc0JaVUM5RGEvZzhH?=
 =?utf-8?B?SWcybkVSRkdtNWFmMEt4WmVvQ0FUWHNaZlkrN0NwMG1FMXVOU1pHNW5tcGxB?=
 =?utf-8?Q?mhrUXGycVzgOwUeIBp1Cl/dZw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb13b633-b107-4c4e-16db-08ddea292510
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 14:00:59.5709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wIWOr1KEO2+Kd2EokZ+zWgSwlSK2qU1uawUduZHiCGWt3Kxk1VHe6DI/7wQq3o5ay6OjPNYWoXjRtSQYUOU+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6646
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 02 Sep 2025 14:01:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2116

--------------JZjxSOCGhBELQLEeRjYmV0ZS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/28/2025 7:34 PM, Lee, Chee Yang wrote:
>
> I build with default local.conf from poky with
> DISTRO = "zephyr"
>
> ZEPHYR_TOOLCHAIN_VARIANT = "zephyr"
>
[Sandeep]: Setting ZEPHYR_TOOLCHAIN_VARIANT works for zephyr-helloworld 
without setting CMAKE version.

$ tail -n 5 conf/local.conf
ZEPHYR_TOOLCHAIN_VARIANT = "zephyr"
#PREFERRED_VERSION_zephyr-kernel = "4.2.0"
#PREFERRED_VERSION_zephyr-sdk = "0.16.9"

#EXTRA_OECMAKE:append:pn-zephyr-helloworld = " 
-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
$ time MACHINE=qemu-cortex-r5 bitbake zephyr-helloworld
Loading cache: 100% |                                                   
             | ETA:  --:--:--
Loaded 0 entries from dependency cache.
Parsing recipes: 100% 
|#############################################################################################################################################################################| 
Time: 0:00:06
Parsing of 2643 .bb files complete (0 cached, 2643 parsed). 4709 
targets, 547 skipped, 0 masked, 0 errors.
NOTE: Resolving any missing task queue dependencies

Build Configuration:
BB_VERSION           = "2.15.2"
BUILD_SYS            = "x86_64-linux"
NATIVELSBSTRING      = "ubuntu-22.04"
TARGET_SYS           = "arm-oe-eabi"
MACHINE              = "qemu-cortex-r5"
DISTRO               = "nodistro"
DISTRO_VERSION       = "nodistro.0"
TUNE_FEATURES        = "armv7r vfpv3d16 cortexr5 idiv"
TARGET_FPU           = "softfp"
meta
meta-poky
meta-yocto-bsp       = "master:ee16a5b7c1bfaf05e7d6c1a814fe095172367246"
meta-oe
meta-python          = "master:146473ce0f79f206be34d751dba0f4a11578874e"
meta-zephyr-core
meta-zephyr-bsp      = "master-dev:3efff04359bfb2e628317b5a1d0ecf433a0e682a"

Sstate summary: Wanted 414 Local 0 Mirrors 0 Missed 414 Current 0 (0% 
match, 0% 
complete)######################################################################################### 
                 | ETA:  0:00:00
Initialising tasks: 100% 
|##########################################################################################################################################################################| 
Time: 0:00:00
NOTE: Executing Tasks
NOTE: Tasks Summary: Attempted 1281 tasks of which 0 didn't need to be 
rerun and all succeeded.

real    9m42.268s
user    0m3.887s
sys    0m0.647s
$

>
> It works only when I set
>
> EXTRA_OECMAKE:append:pn-zephyr-openamp-rpmsg-multi-srv = " 
> -DCMAKE_POLICY_VERSION_MINIMUM=3.5 "
>
[Sandeep]: Yes you are right this is required for 4.1 and not for 3.7. I 
will send a updated patch for master.

$ tail -n 6 conf/local.conf
ZEPHYR_TOOLCHAIN_VARIANT = "zephyr"
#PREFERRED_VERSION_zephyr-kernel = "4.2.0"
#PREFERRED_VERSION_zephyr-sdk = "0.16.9"

#EXTRA_OECMAKE:append:pn-zephyr-helloworld = " 
-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
EXTRA_OECMAKE:append:pn-zephyr-openamp-rpmsg-multi-srv = " 
-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
$ time MACHINE=qemu-cortex-r5 bitbake zephyr-openamp-rpmsg-multi-srv
Loading cache: 100% |                                                   
             | ETA:  --:--:--
Loaded 0 entries from dependency cache.
Parsing recipes: 100% 
|#############################################################################################################################################################################| 
Time: 0:00:06
Parsing of 2644 .bb files complete (0 cached, 2644 parsed). 4710 
targets, 547 skipped, 0 masked, 0 errors.
NOTE: Resolving any missing task queue dependencies

Build Configuration:
BB_VERSION           = "2.15.2"
BUILD_SYS            = "x86_64-linux"
NATIVELSBSTRING      = "ubuntu-22.04"
TARGET_SYS           = "arm-oe-eabi"
MACHINE              = "qemu-cortex-r5"
DISTRO               = "nodistro"
DISTRO_VERSION       = "nodistro.0"
TUNE_FEATURES        = "armv7r vfpv3d16 cortexr5 idiv"
TARGET_FPU           = "softfp"
meta
meta-poky
meta-yocto-bsp       = "master:ee16a5b7c1bfaf05e7d6c1a814fe095172367246"
meta-oe
meta-python          = "master:146473ce0f79f206be34d751dba0f4a11578874e"
meta-zephyr-core
meta-zephyr-bsp      = "master-dev:5680dcdfecc5c3d4a6d4c5b5d47ecca0b0f88bba"

Sstate summary: Wanted 414 Local 0 Mirrors 0 Missed 414 Current 0 (0% 
match, 0% 
complete)######################################################################################### 
                 | ETA:  0:00:00
Initialising tasks: 100% 
|##########################################################################################################################################################################| 
Time: 0:00:00
NOTE: Executing Tasks
NOTE: Tasks Summary: Attempted 1281 tasks of which 0 didn't need to be 
rerun and all succeeded.

real    9m40.076s
user    0m3.001s
sys    0m0.521s
$


>
>
> *From:*Gundlupet Raju, Sandeep <sandeep.gundlupet-raju@amd.com>
> *Sent:* Friday, 29 August, 2025 2:18 AM
> *To:* Lee, Chee Yang <chee.yang.lee@intel.com>; 
> yocto-patches@lists.yoctoproject.org
> *Subject:* Re: [yocto-patches] [meta-zephyr][master][PATCH v3 1/1] 
> zephyr-kernel: Add rpmsg multi services recipe
>
> Hi Chee Yang,
>
> On 8/28/2025 2:16 AM, Lee, Chee Yang wrote:
>
>     Hi Sandeep
>
>     Unfortunately, with these I still can't build the recipe. Looks like we need to patch CMakeLists.txt
>
> [Sandeep]: Not just zephyr-openamp-rpmsg-multi-srv app any of the 
> zephyr app(MACHINE=qemu-cortex-r5 bitbake zephyr-helloworld)  is not 
> working for r5 machines unless you set the ZEPHYR_TOOLCHAIN_VARIANT = 
> "zephyr" in local.conf
>
> We need to take a look on this issue. I see this issue in both master 
> and scarthgap as well.
>
> Some machines doesn't build if you don't set ZEPHYR_TOOLCHAIN_VARIANT 
> = "zephyr". Can you try adding this to your local.conf and see if you 
> can build it?
>
> Thanks,
> Sandeep
>
>     meta                 = "master:fb4ebd60536af8672f950376106e0b0500d7007c"
>
>     meta-oe
>
>     meta-python          = "master:714b3adc3a92d42370a0ea57a9744ad2d031db7f"
>
>     meta-zephyr-core
>
>     meta-zephyr-bsp      = "master:5260aea7ef135d3b23f49c8d7bf6c6f78bdc2f50"
>
>     command :
>
>     MACHINE=qemu-cortex-r5 bitbake zephyr-openamp-rpmsg-multi-srv
>
>     | CMake Error at /data/master/poky/build-zephyr/tmp/work/qemu_cortex_r5-zephyr/zephyr-openamp-rpmsg-multi-srv/4.1.0+git/sources/zephyr-openamp-rpmsg-multi-srv-4.1.0+git/modules/hal/libmetal/libme
>
>     tal/CMakeLists.txt:1 (cmake_minimum_required):
>
>     |   Compatibility with CMake < 3.5 has been removed from CMake.
>
>     |
>
>     |   Update the VERSION argument <min> value.  Or, use the <min>...<max> syntax
>
>     |   to tell CMake that the project requires at least <min> but has been updated
>
>     |   to work with policies introduced by <max> or earlier.
>
>     |
>
>     |   Or, add -DCMAKE_POLICY_VERSION_MINIMUM=3.5 to try configuring anyway.
>
--------------JZjxSOCGhBELQLEeRjYmV0ZS
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 8/28/2025 7:34 PM, Lee, Chee Yang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:BL4PR11MB87973A5091395D9BBC292047B93AA@BL4PR11MB8797.namprd11.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:Aptos;}@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0cm;
	font-size:10.0pt;
	font-family:"Courier New";}span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal"><span style="font-size:11.0pt">I build with
            default local.conf from poky with
            <br>
            DISTRO = &quot;zephyr&quot;<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt">ZEPHYR_TOOLCHAIN_VARIANT
            = &quot;zephyr&quot;<br>
          </span></p>
      </div>
    </blockquote>
    <p>[Sandeep]: Setting&nbsp;<span style="font-size:11.0pt">ZEPHYR_TOOLCHAIN_VARIANT
      </span>works for zephyr-helloworld without setting CMAKE version.</p>
    <p>$ tail -n 5 conf/local.conf&nbsp;<br>
      ZEPHYR_TOOLCHAIN_VARIANT = &quot;zephyr&quot;<br>
      #PREFERRED_VERSION_zephyr-kernel = &quot;4.2.0&quot;<br>
      #PREFERRED_VERSION_zephyr-sdk = &quot;0.16.9&quot;<br>
      <br>
      #EXTRA_OECMAKE:append:pn-zephyr-helloworld = &quot;
      -DCMAKE_POLICY_VERSION_MINIMUM=3.5&quot;<br>
      $ time MACHINE=qemu-cortex-r5 bitbake zephyr-helloworld<br>
      Loading cache: 100% |&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |
      ETA:&nbsp; --:--:--<br>
      Loaded 0 entries from dependency cache.<br>
      Parsing recipes: 100%
|#############################################################################################################################################################################|
      Time: 0:00:06<br>
      Parsing of 2643 .bb files complete (0 cached, 2643 parsed). 4709
      targets, 547 skipped, 0 masked, 0 errors.<br>
      NOTE: Resolving any missing task queue dependencies<br>
      <br>
      Build Configuration:<br>
      BB_VERSION&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;= &quot;2.15.2&quot;<br>
      BUILD_SYS&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; = &quot;x86_64-linux&quot;<br>
      NATIVELSBSTRING&nbsp; &nbsp; &nbsp; = &quot;ubuntu-22.04&quot;<br>
      TARGET_SYS&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;= &quot;arm-oe-eabi&quot;<br>
      MACHINE&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; = &quot;qemu-cortex-r5&quot;<br>
      DISTRO&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;= &quot;nodistro&quot;<br>
      DISTRO_VERSION&nbsp; &nbsp; &nbsp; &nbsp;= &quot;nodistro.0&quot;<br>
      TUNE_FEATURES&nbsp; &nbsp; &nbsp; &nbsp; = &quot;armv7r vfpv3d16 cortexr5 idiv&quot;<br>
      TARGET_FPU&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;= &quot;softfp&quot;<br>
      meta&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<br>
      meta-poky&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<br>
      meta-yocto-bsp&nbsp; &nbsp; &nbsp; &nbsp;=
      &quot;master:ee16a5b7c1bfaf05e7d6c1a814fe095172367246&quot;<br>
      meta-oe&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<br>
      meta-python&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
      &quot;master:146473ce0f79f206be34d751dba0f4a11578874e&quot;<br>
      meta-zephyr-core&nbsp; &nbsp; &nbsp;<br>
      meta-zephyr-bsp&nbsp; &nbsp; &nbsp; =
      &quot;master-dev:3efff04359bfb2e628317b5a1d0ecf433a0e682a&quot;<br>
      <br>
      Sstate summary: Wanted 414 Local 0 Mirrors 0 Missed 414 Current 0
      (0% match, 0%
complete)#########################################################################################&nbsp;
      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | ETA:&nbsp; 0:00:00<br>
      Initialising tasks: 100%
|##########################################################################################################################################################################|
      Time: 0:00:00<br>
      NOTE: Executing Tasks<br>
      NOTE: Tasks Summary: Attempted 1281 tasks of which 0 didn't need
      to be rerun and all succeeded.<br>
      <br>
      real&nbsp; &nbsp; 9m42.268s<br>
      user&nbsp; &nbsp; 0m3.887s<br>
      sys&nbsp; &nbsp; 0m0.647s<br>
      $&nbsp;<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:BL4PR11MB87973A5091395D9BBC292047B93AA@BL4PR11MB8797.namprd11.prod.outlook.com">
      <div class="WordSection1">
        <p class="MsoNormal"><span style="font-size:11.0pt"><br>
            It works only when I set <o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt">EXTRA_OECMAKE:append:pn-zephyr-openamp-rpmsg-multi-srv
            = &quot; -DCMAKE_POLICY_VERSION_MINIMUM=3.5 &quot;</span></p>
      </div>
    </blockquote>
    <p>[Sandeep]: Yes you are right this is required for 4.1 and not for
      3.7. I will send a updated patch for master.</p>
    <p>$ tail -n 6 conf/local.conf&nbsp;<br>
      ZEPHYR_TOOLCHAIN_VARIANT = &quot;zephyr&quot;<br>
      #PREFERRED_VERSION_zephyr-kernel = &quot;4.2.0&quot;<br>
      #PREFERRED_VERSION_zephyr-sdk = &quot;0.16.9&quot;<br>
      <br>
      #EXTRA_OECMAKE:append:pn-zephyr-helloworld = &quot;
      -DCMAKE_POLICY_VERSION_MINIMUM=3.5&quot;<br>
      EXTRA_OECMAKE:append:pn-zephyr-openamp-rpmsg-multi-srv = &quot;
      -DCMAKE_POLICY_VERSION_MINIMUM=3.5&quot;<br>
      $ time MACHINE=qemu-cortex-r5 bitbake
      zephyr-openamp-rpmsg-multi-srv<br>
      Loading cache: 100% |&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |
      ETA:&nbsp; --:--:--<br>
      Loaded 0 entries from dependency cache.<br>
      Parsing recipes: 100%
|#############################################################################################################################################################################|
      Time: 0:00:06<br>
      Parsing of 2644 .bb files complete (0 cached, 2644 parsed). 4710
      targets, 547 skipped, 0 masked, 0 errors.<br>
      NOTE: Resolving any missing task queue dependencies<br>
      <br>
      Build Configuration:<br>
      BB_VERSION&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;= &quot;2.15.2&quot;<br>
      BUILD_SYS&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; = &quot;x86_64-linux&quot;<br>
      NATIVELSBSTRING&nbsp; &nbsp; &nbsp; = &quot;ubuntu-22.04&quot;<br>
      TARGET_SYS&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;= &quot;arm-oe-eabi&quot;<br>
      MACHINE&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; = &quot;qemu-cortex-r5&quot;<br>
      DISTRO&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;= &quot;nodistro&quot;<br>
      DISTRO_VERSION&nbsp; &nbsp; &nbsp; &nbsp;= &quot;nodistro.0&quot;<br>
      TUNE_FEATURES&nbsp; &nbsp; &nbsp; &nbsp; = &quot;armv7r vfpv3d16 cortexr5 idiv&quot;<br>
      TARGET_FPU&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;= &quot;softfp&quot;<br>
      meta&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<br>
      meta-poky&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<br>
      meta-yocto-bsp&nbsp; &nbsp; &nbsp; &nbsp;=
      &quot;master:ee16a5b7c1bfaf05e7d6c1a814fe095172367246&quot;<br>
      meta-oe&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<br>
      meta-python&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
      &quot;master:146473ce0f79f206be34d751dba0f4a11578874e&quot;<br>
      meta-zephyr-core&nbsp; &nbsp; &nbsp;<br>
      meta-zephyr-bsp&nbsp; &nbsp; &nbsp; =
      &quot;master-dev:5680dcdfecc5c3d4a6d4c5b5d47ecca0b0f88bba&quot;<br>
      <br>
      Sstate summary: Wanted 414 Local 0 Mirrors 0 Missed 414 Current 0
      (0% match, 0%
complete)#########################################################################################&nbsp;
      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | ETA:&nbsp; 0:00:00<br>
      Initialising tasks: 100%
|##########################################################################################################################################################################|
      Time: 0:00:00<br>
      NOTE: Executing Tasks<br>
      NOTE: Tasks Summary: Attempted 1281 tasks of which 0 didn't need
      to be rerun and all succeeded.<br>
      <br>
      real&nbsp; &nbsp; 9m40.076s<br>
      user&nbsp; &nbsp; 0m3.001s<br>
      sys&nbsp; &nbsp; 0m0.521s<br>
      $</p>
    <br>
    <blockquote type="cite" cite="mid:BL4PR11MB87973A5091395D9BBC292047B93AA@BL4PR11MB8797.namprd11.prod.outlook.com">
      <div class="WordSection1">
        <p class="MsoNormal"><span style="font-size:11.0pt"><o:p></o:p></span></p>
        <p class="MsoNormal"><span style="font-size:11.0pt"><br>
            <br>
            <o:p></o:p></span></p>
        <div style="border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm 4.0pt">
          <div>
            <div style="border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm 0cm 0cm">
              <p class="MsoNormal"><b><span lang="EN-US" style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span lang="EN-US" style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                  Gundlupet Raju, Sandeep
                  <a class="moz-txt-link-rfc2396E" href="mailto:sandeep.gundlupet-raju@amd.com">&lt;sandeep.gundlupet-raju@amd.com&gt;</a>
                  <br>
                  <b>Sent:</b> Friday, 29 August, 2025 2:18 AM<br>
                  <b>To:</b> Lee, Chee Yang
                  <a class="moz-txt-link-rfc2396E" href="mailto:chee.yang.lee@intel.com">&lt;chee.yang.lee@intel.com&gt;</a>;
                  <a class="moz-txt-link-abbreviated" href="mailto:yocto-patches@lists.yoctoproject.org">yocto-patches@lists.yoctoproject.org</a><br>
                  <b>Subject:</b> Re: [yocto-patches]
                  [meta-zephyr][master][PATCH v3 1/1] zephyr-kernel: Add
                  rpmsg multi services recipe<o:p></o:p></span></p>
            </div>
          </div>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <p>Hi Chee Yang,<o:p></o:p></p>
          <div>
            <p class="MsoNormal">On 8/28/2025 2:16 AM, Lee, Chee Yang
              wrote:<o:p></o:p></p>
          </div>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <pre>Hi Sandeep<o:p></o:p></pre>
            <pre>Unfortunately, with these I still can't build the recipe. Looks like we need to patch CMakeLists.txt<o:p></o:p></pre>
          </blockquote>
          <p>[Sandeep]: Not just&nbsp;zephyr-openamp-rpmsg-multi-srv app any
            of the zephyr app(MACHINE=qemu-cortex-r5 bitbake
            zephyr-helloworld)&nbsp; is not working for r5 machines unless
            you set the ZEPHYR_TOOLCHAIN_VARIANT = &quot;zephyr&quot; in
            local.conf<o:p></o:p></p>
          <p>We need to take a look on this issue. I see this issue in
            both master and scarthgap as well.<o:p></o:p></p>
          <p>Some machines doesn't build if you don't set
            ZEPHYR_TOOLCHAIN_VARIANT = &quot;zephyr&quot;. Can you try adding this
            to your local.conf and see if you can build it?<o:p></o:p></p>
          <p>Thanks,<br>
            Sandeep<o:p></o:p></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <pre><o:p>&nbsp;</o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>meta&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = &quot;master:fb4ebd60536af8672f950376106e0b0500d7007c&quot;<o:p></o:p></pre>
            <pre>meta-oe<o:p></o:p></pre>
            <pre>meta-python&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = &quot;master:714b3adc3a92d42370a0ea57a9744ad2d031db7f&quot;<o:p></o:p></pre>
            <pre>meta-zephyr-core<o:p></o:p></pre>
            <pre>meta-zephyr-bsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = &quot;master:5260aea7ef135d3b23f49c8d7bf6c6f78bdc2f50&quot;<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>command :<o:p></o:p></pre>
            <pre>MACHINE=qemu-cortex-r5 bitbake zephyr-openamp-rpmsg-multi-srv<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre>| CMake Error at /data/master/poky/build-zephyr/tmp/work/qemu_cortex_r5-zephyr/zephyr-openamp-rpmsg-multi-srv/4.1.0+git/sources/zephyr-openamp-rpmsg-multi-srv-4.1.0+git/modules/hal/libmetal/libme<o:p></o:p></pre>
            <pre>tal/CMakeLists.txt:1 (cmake_minimum_required):<o:p></o:p></pre>
            <pre>|&nbsp;&nbsp; Compatibility with CMake &lt; 3.5 has been removed from CMake.<o:p></o:p></pre>
            <pre>|<o:p></o:p></pre>
            <pre>|&nbsp;&nbsp; Update the VERSION argument &lt;min&gt; value.&nbsp; Or, use the &lt;min&gt;...&lt;max&gt; syntax<o:p></o:p></pre>
            <pre>|&nbsp;&nbsp; to tell CMake that the project requires at least &lt;min&gt; but has been updated<o:p></o:p></pre>
            <pre>|&nbsp;&nbsp; to work with policies introduced by &lt;max&gt; or earlier.<o:p></o:p></pre>
            <pre>|<o:p></o:p></pre>
            <pre>|&nbsp;&nbsp; Or, add -DCMAKE_POLICY_VERSION_MINIMUM=3.5 to try configuring anyway.<o:p></o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
            <pre><o:p>&nbsp;</o:p></pre>
          </blockquote>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------JZjxSOCGhBELQLEeRjYmV0ZS--

