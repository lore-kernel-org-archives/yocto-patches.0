Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE81D73EBC
	for <webhook@archiver.kernel.org>; Fri, 30 Jan 2026 05:21:07 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4480.1769750461216177859
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 29 Jan 2026 21:21:01 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=L9s55G37;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=649081a404=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60U1vSsd3583741;
	Thu, 29 Jan 2026 21:20:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=5OjjKX84I
	n/rzhYjAE4q+zAKIUv3rySP7iDAn/Ol6Ws=; b=L9s55G37vlopAvf3XXsak7qUD
	nevsl71VTZTUpl+NITOYOvoKUhlCPF2KbfpyZF7F8EZ9eWFS2bOuO7XihG6z41wb
	cfoDdn/ahQTKhuC7lO2TIorKVRueAfBq+MeYBiUzQ5tYubf9agIwQG590/4+oBRs
	daQgEF2JVsvSg3jWmVXJPIRWlNUvSTAWYv2rOABST+sdxnOcNTyPRqEJeE9/oEfI
	vaZSuv0jWltHHkLxHdFssc71e1qH0wvKWRak3VeqaBL8Lomoo1Mg+XfzLgF5mBOI
	GD95jQj6eLKu8r925QcG7gls/GYBEan/ynEjNgydoS7DWAnsZzlEyBDR9r6xg==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012059.outbound.protection.outlook.com [40.107.200.59])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4byx2t9tg8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 21:20:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cU+SqH1PIycS+P7pqFFSjIShH2BaIfQoiElLy41z2dHXjFnt2miXoQU78yfFbHW5YD0dJSvExCInYvg3cygsHaFato3DAqCoNZ7MOQfzfNVfd6ZP7fTcxjoMXbbd645v651bDTn4PFI6wOc2P1T7ja7/9KF4q/09k9sJJFSV+CCCj8z2cl5q/MhUr8qLAfBJWRgu3Shz/kMWs/jZbf1Ewbz8NKjutvSr2fzMsInBT1ou1xWtDqF6k0gKpnauhUG/T46++msyms7Nu3EOsDnc3aAWAMHHbPbZ3pLAsIjTJf8M2n/OOnzDR+S8X3xcpBJVtwd/1U3xWX5Xt1CVfHYw4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OjjKX84In/rzhYjAE4q+zAKIUv3rySP7iDAn/Ol6Ws=;
 b=B4XaePvs4A7z34tMdWLbw+nMnKazlilbX9biLvQxZEyqVUAeirrXkCvg6pdpxcfc8X7LQ9sZQWm5ELrO8ku00PMx4zUKUbBqLs3imUaZW/m0iUIWJ9XcjYoxkCnaQttBFD1eA+OEJlK9sl33/XJrSemAkfhA947dwrCwrBIJGybp7cR0oetYWPIESF/uQr8TNl/rL+3GPFHo3BRoXzle1kmqipQJ8YIlHnThmUIdLTPEOVgpJCRcaylts9OirqRlPRk66R8uRkXwJae9KHCfX4yInLWupLkCWLHK3AGosNfoo3zMC0iIWrA9BQFnGOytrbDhfU+FJALkKXhk60KIVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN7PR11MB7601.namprd11.prod.outlook.com (2603:10b6:806:34a::16)
 by IA1PR11MB6348.namprd11.prod.outlook.com (2603:10b6:208:3af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 05:20:54 +0000
Received: from SN7PR11MB7601.namprd11.prod.outlook.com
 ([fe80::b3c9:47a7:4653:5a6]) by SN7PR11MB7601.namprd11.prod.outlook.com
 ([fe80::b3c9:47a7:4653:5a6%5]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 05:20:54 +0000
Message-ID: <34111501-e543-417a-b933-e3830a3cdf64@windriver.com>
Date: Fri, 30 Jan 2026 13:20:42 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        Michael Halstead <mhalstead@linuxfoundation.org>,
        yocto-patches@lists.yoctoproject.org, Khem Raj <raj.khem@gmail.com>,
        Alexander Kanavin <alex.kanavin@gmail.com>,
        openembedded-architecture <openembedded-architecture@lists.openembedded.org>
From: Hongxu Jia <hongxu.jia@windriver.com>
Cc: "Yang, Zhangle (Eric)" <Zhangle.Yang@windriver.com>,
        Robert Yang <liezhi.yang@windriver.com>,
        Randy MacLeod <Randy.MacLeod@windriver.com>,
        Mark Asselstine <mark.asselstine@windriver.com>,
        "Holmberg, Tomas" <Tomas.Holmberg@windriver.com>,
        "Chen, Qi" <Qi.Chen@windriver.com>
Subject: Running Large Language Models Locally -- Contribute meta-ollama to
 Yocto
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: TYCP286CA0269.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::20) To SN7PR11MB7601.namprd11.prod.outlook.com
 (2603:10b6:806:34a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7601:EE_|IA1PR11MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: 001a854c-72af-4983-2ffd-08de5fbf5743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QkZUZXJVbW5uN2FvYjhrNnYzSzRUc3VIRDYzWlduTlJCWXZDeVV2bldoNjUx?=
 =?utf-8?B?bGRrSWx4L29Rdk0yY0NQcW1JNVRzMysrR1NBTlgydW1pcEZ4MTZ5d2hzUzM3?=
 =?utf-8?B?VytKeTJKTHhFTUNNVG4zdGpZUlJrVk52SE5KMHRJenBNZGJqWTN1ZWFaTmxW?=
 =?utf-8?B?NlJ1UXRIY1lQMjFqQlBZU0pST3M2TUx0ZHROZFN0OTloNkVvNkRlTzN0SVBS?=
 =?utf-8?B?QVN5VzJaaWdBYU4vT1RPMU0zNGZMVmdOOXZqbzRWY3pYVW11U0VlRzVibGk3?=
 =?utf-8?B?c1dpWFNWRWNZK3RnS1lQTkRWeWZ0bkpFVVh6RnhUYVVnT0JOcWFhQXJWc1Js?=
 =?utf-8?B?UGlGdUpWWW1nakJGWHhmOU1BN2padks5THdIVWpYVVNON2JlbnFBWkhqTktD?=
 =?utf-8?B?M3lhRzlQeWhsSW5JUVNRRmd2MUtIUFQwc0s2dmxFZ2xGc2VxL2h3bHFGdk1v?=
 =?utf-8?B?ZCtmMCtTcG5xSUxuOVNXandSMEhYT2N1UHhFNmovUllMOUlkajlFU2ZhZWNa?=
 =?utf-8?B?eG11Qm1aVTA0anpicmpKR2dFS2FURlpBK21COHNsdmVPVzhkdWhRdUlJUjZ5?=
 =?utf-8?B?cXRVZGpvd1JHbHNWazhSUHdZTkR0ajJZYzR0Mjl1aGxhMCs1SStORjgzR3E4?=
 =?utf-8?B?V2grOXB4R21sZEtPR0tVWFFtSk14MEJpUGd5RVQwdldFTkpVbU5UYzlocWVk?=
 =?utf-8?B?WGo4d2h5Yi9WSTFBYVZ3MVcvRVhXa0h1ZXdsTm5MR1ZFWG5sMXhUTEhlRWUw?=
 =?utf-8?B?WHYrZnh6d0ZGRUlBak04cjB3SGp6Vm9YZ1A5czdxRTR4RFgrOXBLeHpORDlL?=
 =?utf-8?B?eEZNbHZUZ1lvdUo5ZjJRemhCZzM5OTV4bHZyQjQ4OWZVbnRXVkwrY0JhTW82?=
 =?utf-8?B?aW0rSC9NYnFqbmpEVmRnM0ZIajdkVXV4TG9pYmNoKzcyWlBkVXc5ekgzcXZV?=
 =?utf-8?B?ZHNGWUljQXdxNFA0M2liWGVuYk1xaklhNW9NSXJONUowaDJaTDdPbUplcUI2?=
 =?utf-8?B?MVhCeUtzZVZNQ2hRTVNJeWNudEFEbXJzdnl0VkxXREFjUnNHU3NnYVdBMmFH?=
 =?utf-8?B?MmFJb0lXUk0zOTFZRm1hd1dzZWowMWY5SzVEODg4YjRzd0l0S3NqSUREQjhW?=
 =?utf-8?B?RHBjRVJJWGtjd0t4ZyswZXNia2J4SktrSTRtK1JIejl1QmdYVUlMTzFLR2Y1?=
 =?utf-8?B?Y2tOMU92VC9kYnNhOVY0d3RlQkZpeHYva2dRdm9lREJPcnJtcWc3ZnpDK0s1?=
 =?utf-8?B?VUFYMDBpdDF6bjdnVExhZE1ab0xhTlB2dlNQbjJCK2JibklISXJXaGhVclhW?=
 =?utf-8?B?R251a1MxbmRyRk1jdk9IbjBxN0tRWUV3Y2FxSUJBVEhXVDYzb1JoMVltWFBM?=
 =?utf-8?B?MDVJMjI2RFdpSERsTkZCbU42WWZnZWgxTGZ2aFFNdGYxeG1wc2RTTkJHejVV?=
 =?utf-8?B?c1NRcWlxaFc5LzR3eDhNcjNPYldOeUxCWm5KbFRUUG8wVmR5K2NIZS9QdUJI?=
 =?utf-8?B?OFRGYnFJVDgrb2Y4NVNxYStOTG9XcE9reXIzeWlscjFoM2cvSWVzUThwZ1pJ?=
 =?utf-8?B?R3NmQ1ExMm5mbUt4bllhN0tGUCtvTVBXalNKRWJjcVlnUkRScmorWk83emFP?=
 =?utf-8?B?YVFBaDBLLzZ3elhTaU9XaFBGN3ZVcW0rOS8rT3RHV1VNa2lyYlhTQ3VjRi96?=
 =?utf-8?B?c2RKdFlCS3hmNzQ5cGNCTGNIUWI5VDFRb3RyMU8vbWxMK3FGSWdOS0haWWl6?=
 =?utf-8?B?ek0zSlZORWJpN09RZEc2VS9VMk0xb0k0RzFJWkV1TWpIZ0FYbUxKSFFXSzVM?=
 =?utf-8?B?WWNMZTM4TlYwc1dRTzkyMzZid0tMRTgxYmg2bHQyNHE1UGZtdHEwbDhFUnpZ?=
 =?utf-8?B?dTlEbElJRWJzWmNUSXYyZEtaNDg3c0NVZ0UwNjFRVy95b3J0NmNkMVZOaFc4?=
 =?utf-8?B?NkhMMGE2YWJFTVFaV1Jucm9HT1QvZTVuZEgybGhZUDE2QzFZOUpJeTh4QURw?=
 =?utf-8?B?UC8xS0k0YmpuQ1BnTnNkRFgrbmh4OXROZDBNcXF2a3dtUDZjNG5qclFuRlow?=
 =?utf-8?Q?iEoTvF?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7601.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TGMzemtsNUZFUEJJeDVZZm5EQ3NzZVVzdlNCRWRBR295U3UxSU9XSzAwZ2Ju?=
 =?utf-8?B?N21BSEVGa1BiS3lhTENRM20vWEdWWFdUZUpjM2NOcC9NWEhFK284Q2l5Y2Ix?=
 =?utf-8?B?ZEtBMHlUai9tMTIzT2loOGFyVVIvZzBoVjJldXZVWkdkODN0ajM3RVVQSkho?=
 =?utf-8?B?SDQ2VkJFQzFMNWFXcWxDZllmTExZVHZkb0FzTVp3TGxxVlRLNXM5ZzA0SVBB?=
 =?utf-8?B?VEVicG9iL3RiQ2J6NGVBM2hXaVB3ckJ1ZDc0M2NVbTcxK2lDYjQrR1QwSG9n?=
 =?utf-8?B?SUJkTEZjYVJmNUZERFB3M3VacnhBS09DTmxwdE8zZWxHbTlXbU0vWlVKcFow?=
 =?utf-8?B?bzRiNE5uYWpKVVJSRVJ3WW9uMU5uS01JYTY1d1FneFU2ZGxmSDdLaFBPZWoy?=
 =?utf-8?B?dm1SRFgwc0RaYmYwcGwraW9pcDk3VExsZWZsSlR3Y2FmMktETmRDLysxbENv?=
 =?utf-8?B?QndXSDBvTlUwbUFrNWhVOWxVaUVLRzNCYlg5cVRMREp0d3VjZGdhV3VLUTI5?=
 =?utf-8?B?TTQwb2FMTUFPNmFPSlFMT2JlNlNuWEF6SUpOQ0s2R0NYd2VKcWt5UVZXd2lU?=
 =?utf-8?B?V3l2WU1yTnB3d2hUQ1BsQm52RzYyNTlzN0kraUhFbUJyeVpXSTlhdWVacjFt?=
 =?utf-8?B?eXF4d0cxQ1lQU2sweTlmZklwcEIybnFGU1FveXVmaWp3TUhYYWxmNHowek1P?=
 =?utf-8?B?YzRkMmhyTUMvaTZEQVBnQ0YvTXlOUTYyMmVqSnV0YXVsZ2ZlYUhXRmhVZTIr?=
 =?utf-8?B?V1Q5OEx3WmRiRzlaaWpzU3hwbGRyTkhBM1RlS0NpYUIzajNPRlFQUzRsMFBp?=
 =?utf-8?B?WDUzU3J2di9aNTBSTUF3Q256YXNPOE9DaGdRemlBazMrdFI2Y2lHak9rcE8r?=
 =?utf-8?B?Q0xkODVlOWl5Nm52WlE1cTdRRUFsd3Vna1czRzdlTmlIamthWkladXVwRkdV?=
 =?utf-8?B?ZjM3Q0JRZXM3OGk4akYxZTlhYk1ZN1FVMTZwZDk0MG5JS1JMNkhtN2ZLUGNR?=
 =?utf-8?B?Y0NhdHB6R3dGL0Z1Nis5Z1cvaU9kczNGM3BiTkY1QTBoQXVzbTdWUTB2YzQz?=
 =?utf-8?B?RWxuZTJ2My85MEJpWDc5S3dEM1R3dzlMaFBTSzNDR09WY213b3VCZkpxZTNo?=
 =?utf-8?B?YjUwZjc1ZWxSWVMxOEQwZ3dpazdlZG1EdEE3ck9PSkVOYTA4S3ZnWjJ4TERm?=
 =?utf-8?B?aVdrVjNZdHkvTDhSMCsyQ1pJUWpTVHQzOFJjYUM2UFlVSk5sTmVzN0k5WE1C?=
 =?utf-8?B?YXFIODQ3R29NZHh5d01XM0N3TXpWNW5SSHVzZ0Jwb05PSlBQdk9sZG55c1V1?=
 =?utf-8?B?VllJUTVlTW0xRjF1Y2dqVmdackgySGhnaE1NNzZobnc4ZzZmc3VTb2NNYlFy?=
 =?utf-8?B?eVAva3NhRlJsT0FDb2NBQ0Nia1ZaVUJLRXNjWXpLaHRjR0VMNmF1SzlPaWs4?=
 =?utf-8?B?RVpvd2FFU0IxMlBBZXJnVy9hcWVXV2g2YXJ5NjJvQVg1alBOWEVMUEpZdXRt?=
 =?utf-8?B?R0hkMDhpWXhQaytuUU8zNXpzbFN5cTVzOGUrcE5tMzdLQmZYNWs3UWFnbWt6?=
 =?utf-8?B?MWtmWEJkU2JQbWFoZEZZQWxDblhuYklFSEdtVU53UEdsV280aHRXTnBrNjgv?=
 =?utf-8?B?Z1M2clNSeUs1eXpUeWlOeVR0S3pGdE52SmtaUkthZlE1TEJZV3BKWGY4bFJi?=
 =?utf-8?B?bGl2bmw4UzBoSUJteU0wUnRsdDRvK2piVHJ5NTNndE1xQnRIeWcxTjlQd05a?=
 =?utf-8?B?TzZYMTRZUWdaa2Fwc3Ftam5sbk5IYjU4YzdKdUk2RjdibExPZWI0Z2Irc3Zo?=
 =?utf-8?B?SmlxSWh0T2pJdm55dXp2Vk43Q1N3Q1JFRzVqUDJrdTR1QThBYmNRMWcwbzIw?=
 =?utf-8?B?VGhNcnNuem41azhiOVBZQ0tOSGJLUlp2MFU2bzV2V0g5cEliMllkWVpHd2po?=
 =?utf-8?B?TFRwbFZmUnVFK0xpL3BBK3FJa3lvTExaZldyVHdSWGZOV0UzRDNvZzZiVi93?=
 =?utf-8?B?eFdkdkJEYzI1dWxkK0xibHpoNWVXRjVOZHdoRkZSdk1wTXhqTC9MMXMvZUhv?=
 =?utf-8?B?bytqRE1VQTROOHp6RFhET1Z5YXNkd2tWTWlHZ3BDYkNFKzh2Q2tkMEZncStI?=
 =?utf-8?B?Rnc5dnVyb2ZkWTdhNlpsRGZxTG5RRXpzbW1JUmhpYkNXUkIvSktYU3dHb3Zx?=
 =?utf-8?B?bVhvL3pLUE43MlpuNHExQm1QVGdIMzQveFJ6WXZVOUhEczA4ZWhGQVlTQ09j?=
 =?utf-8?B?czhVbzN3TWlhYzFCV2FpY1gyQW9UWXp3OXZBbTU4TkI2UUdzTUhwL1gvTytP?=
 =?utf-8?B?b0FlMHVoQk1BZ1VBU0Zpb3dSN0V5T0ZWdERWb3JUK3VpZkZ6bit3Zz09?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 001a854c-72af-4983-2ffd-08de5fbf5743
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7601.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 05:20:54.3907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7I7Fq9v6eVEmuA6coKtBGryeGMHLCJEcnNpbjvkMov0/fOT/Rz3lfr5ni9xaYz66JDUgLiqfzTz1eF18qL7EG/CJ+yc/zEKSbDnPLmA7MY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6348
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 8eeF09AhMPEY9tOXjZXCRl_7tu7dLlz-
X-Proofpoint-GUID: ON9hqfQF6SIVkiEIaKgKPTzYuO7tN33a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDA0MCBTYWx0ZWRfX8QqyVMoRt1yO
 t0EOQHmtYWVuZhlDRk6UZkpd86tfTpUSsBDC38aiNKARzp0x9gxODh02/rhCtS2f+cgwSWamua6
 MvuQogzTYsaaGh0Sxo8STkrVydMEKcXOeDugz4h61RutniBKhgjhP04lh8m3xcuImoNU8rMx3lO
 00wQu6tuiVBefSBzN4XKgm9VNlJQ0WzuCeAHc/Llx5ADb0H6eAB1nbLwBCB9pP7hkS2mT6F832i
 kWsSZo+zj02owTxvf9uDeqdReMaJpi2dEhGBmGg0CYU0CkAQAIAZMhcanV+4qCKLeMoWlfEp6u0
 6RW7pcet7aKGthctJeQvV3zCyxR3Yt9n6ncuoN4Ph76WeuoHjePfYlaVVsl0Qd/i3btzsUvO+aA
 idMdIt1cJ5tjiizwNaj7Nel5PlnjLFezx/432vDZFs3014Gwk064zO16lXA/q2dMTqiimP84g1N
 xbJlyAV9hhGUMKq2Xng==
X-Authority-Analysis: v=2.4 cv=NcDrFmD4 c=1 sm=1 tr=0 ts=697c3fb9 cx=c_pps
 a=+/t0CT+QaJpOasvqRK9qOg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iGHA9ds3AAAA:8 a=-BdCj9j9AAAA:8 a=mh9WM59iAAAA:8
 a=THNDZdH3AAAA:8 a=NEAV23lmAAAA:8 a=j0GEES8IAAAA:20 a=Ikd4Dj_1AAAA:8
 a=AKH3N6QVQlWoEQExnlAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=nM-MV4yxpKKO9kiQg6Ot:22 a=q2PKn5jL56lZ5O96TxEF:22 a=_i8H4QOFLrvd8LLna9FN:22
 a=et1GZjlipxOlxTZWj6hD:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 clxscore=1011 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300040
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 60U1vSsd3583741
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 30 Jan 2026 05:21:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3148

Hi all,

ChatGPT[1] has been popular for several years, perhaps you also know=20
Deepseek[2]
which is an open-source language model and run locally.

The local runner to run Deepseek is Ollama[3]. It lets you download and r=
un
large language models (LLMs) on your own machine, without relying on
cloud-hosted services.

That is good for Yocto, so I integrate ollama to Yocto-based Linux system=
,
build from source, offline install and deploy.

For the convenience of review, show it on my github [4] temporary,
- The BUILD.md [5] provides the steps to build and run on CPU by default,
- The BUILD-cuda-x86-64.md [6] provides the steps to build and run on=20
NVIDIA GPU
 =C2=A0 with CUDA for x86-64

And now contribute meta-ollama to Yocto, the layer provides:

- Recipe ollama: provides application ollama.
 =C2=A0 It supports to run on CPU by default. And optional on NVIDIA GPU =
with=20
CUDA

- Recipe llama3.2-1b and llama3.2-3b: the large language model by Meta [7=
]

- Recipe gemma2-9b and gemma2-2b: the large language model by Google [8]

- Recipe deepseek-r1-7b and deepseek-r1-1dot5b, the large language model=20
by Deepseek [9]

- Recipe nvidia-open-gpu-kernel-module: the kernel module for NVIDIA GPU

- Recipe nvidia-driver-x86-64: provides firmware for NVIDIA kernel module=
,
 =C2=A0 CUDA library and application nvidia-smi for x86-64 BSP. NOTE, no =
sources,
 =C2=A0 only binaries from NVIDIA [10], license is Proprietary [11]

- dynamic-layers/meta-tegra: customize meta-tegra to support CUDA for x86=
-64

Hi Richard,

Would you please approve to add this layer to=20
https://git.yoctoproject.org/, I will maintain
meta-ollama for recipe uprev and bug fix


[1] https://chatgpt.com/
[2] https://www.deepseek.com/
[3] https://ollama.com/
[4] https://github.com/hongxu-jia/meta-ollama
[5] https://github.com/hongxu-jia/meta-ollama/blob/main/BUILD.md
[6] https://github.com/hongxu-jia/meta-ollama/blob/main/BUILD-cuda-x86-64=
.md
[7] https://ollama.com/library/llama3.2
[8] https://ollama.com/library/gemma2
[9] https://ollama.com/library/deepseek-r1
[10]=20
https://developer.download.nvidia.com/compute/nvidia-driver/redist/nvidia=
_driver/linux-x86_64/
[11]=20
https://developer.download.nvidia.com/compute/nvidia-driver/redist/redist=
rib_590.48.01.json

//Hongxu

