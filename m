Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB21C83F26
	for <webhook@archiver.kernel.org>; Thu, 24 Jul 2025 09:41:42 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.8661.1753350098512229644
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 24 Jul 2025 02:41:38 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=9300a2668f=yi.zhao@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56O7oSmO661746;
	Thu, 24 Jul 2025 02:41:37 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4838wx0egv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 02:41:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQPG2zgeQHTdnYX04Vuvz9liuoMJEYjUjQKf8xn6KY34lJRMLefO5T7wzxXdEI6gQqzfdbK2H+dROJLC0F6HO9FDcVJbiNyWHX9G7gGwPSS4lbs9nULlXIA2wCZzIKMEkotXYiyOohe7fMHtdbDPq11cOk/V20Ws06tACYIDIWW8I9jr27fGdOByo5sraendJkcdEKGP+TikTBOug3M2LV+XJ/QU+yyLg4xSFi9tIzlS5JyjNHulBsATh1Ibk+nx2ILf7rnTVi2acJHXLm8bnbXXt8Wo62am4zsfSYWwi7dBsDFsANLr5QjKELaa8XNAfYwTZVNX60w2Aw/vlzzWkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4g1LnCF9tge4tG932BrNtnQr/KajjZV4rWkwPiwaYVM=;
 b=UeZQ+QdlMHm/k8OajQTieImlLY4r/QJIDbCbV3+Wzag0SDY1bpxEg2nc+tJqQmPcbfvfS92ef3vhod9bUSH/3VLThwkV6Wf5fw11VmyjVduHOH74utxx+Ffrw1Dw/J8E1vA4OjTq10FXxnfz8xVkcMA1qaw7ZUJOTJ/WCUVZuv24Fs3CQhZ0B1mje9YrJr01Q748sTLoFMQe1isxoTH/iKG/oKdUTTNqWgB8vYYZIbZxN1V5tkfINh1E8MldedhwDG3uHTAqZN4t0q1o1Mcdfnv+RB2jAII4Y60qB3UfjlKIBeKmKDHLjteti3WXuQJfixzkcyZXWwieIVAslK3uzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 SJ0PR11MB7154.namprd11.prod.outlook.com (2603:10b6:a03:48d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.22; Thu, 24 Jul 2025 09:41:34 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 09:41:34 +0000
Message-ID: <24e6a59f-522c-4ef0-a5fd-29af4c160560@windriver.com>
Date: Thu, 24 Jul 2025 17:41:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-selinux][RFC] refpolicy - add "Yocto" distro upstream
To: Clayton Casciato <majortomtosourcecontrol@gmail.com>,
        joe.macdonald@siemens.com, yocto-patches@lists.yoctoproject.org
References: <9fa9f7cb-b82e-4d7e-83af-8027c39590ea@gmail.com>
 <7b3e26c9-b524-4b0f-ac88-5403e256c5d7@gmail.com>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <7b3e26c9-b524-4b0f-ac88-5403e256c5d7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SE2P216CA0037.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:116::12) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|SJ0PR11MB7154:EE_
X-MS-Office365-Filtering-Correlation-Id: a616f6c9-424a-45ba-b61b-08ddca9646d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?d1FYaXBYN1dQVlRiOVM2RUM2cTcwSTh3ckVtQ0JpUUZ0Z1RDeWRCbzU4YnZN?=
 =?utf-8?B?UUtYR1diN0d3Zk9tWm1veXZUS2hSWW1QbklYZWFVYlg0dU9vUEVsTXJ0ZTgr?=
 =?utf-8?B?R1ZYWVhweW9MUXZjSDVCZC92b1l1SGxMQ1BGbmhWUDFPb0VhVWMrTjhac2xh?=
 =?utf-8?B?UTFabnV4YVc1M2pEZzhGajNIdWNJd2U5dkU3UmdMTlhPR3poNmtBeHV5L2Rp?=
 =?utf-8?B?UjR6M3FVSkJ6aVlteStXYUcvZjBRUlBRZFlJQUVPNnJLNUF6dlBYcnM2cjhY?=
 =?utf-8?B?SmpLNnR6cHJMRVFmbTRXdnJUdmtWU3dqdmZQVlVxMmM0M2w1MkhWZ2RqUFow?=
 =?utf-8?B?c0xId05remF5WEtQcDdORHBUdXVTYXIxMEM4SnlOdDdHbHJVVDVZdkhxVXN1?=
 =?utf-8?B?N0FmNmJMWWNmcUlKY0hwZWpRWVlIY1hKREZad3lhTmg1ZVhCMUxtMlRzZ1Vn?=
 =?utf-8?B?ajlYM1ZrRndkYUNZakRzMmxSNk8zTFk0VnVTQ0ZoUVdQdGc3SXQ0RkFEaitD?=
 =?utf-8?B?cTBMMzNnaXNDdW92c3pZdEIzYnpZdWl3SmVFN3NhOEZ3bGU4R0hUNEFlYW5u?=
 =?utf-8?B?NTlLWms1ZFY1S0pxakY0MXpwUE02QmNJMFc4YmtydEdFUkJseElBUUwrRUhT?=
 =?utf-8?B?Vm1PaW5WV0lqV1hGZ2I1N2dEam9HemNuRXJLaVpGUkhXNy9SMVJORDdCR2M5?=
 =?utf-8?B?N0VWMVJ4V0Q0ZDVKNlJqWXY5am9XMWdzQkJ1bEdCOEcxclZtNHRpOXBWTGtH?=
 =?utf-8?B?aC8wc0RKalVMdUFVNTNCaFNVSytQbDRaVXZDTnpvRVVSbmI5UkF5azVna1JU?=
 =?utf-8?B?NDlTM3kzZGZ6c1ZOVDI5VGgzaEZGWThBU2YxNXFJelBXZTlMV3NpMy9HNjlp?=
 =?utf-8?B?c1ZvbWl2dWR2K1U0OU1ONXNJRHVoZE1OZm9PYWpBKzBIOWI0aGxNZHo2MVVu?=
 =?utf-8?B?U05JUlVFYTZjWjZDWEF0Z1k2L2YxbHNqWmhvdndkejF6aWJKc3VzMWYxcXFw?=
 =?utf-8?B?RGN6YWZmaWJOaCtheExqL0RhZTlzNUZSRzB4WnNiZDgyanQvWmhuaGZ4ME5s?=
 =?utf-8?B?bmQvYWpwZFZKR0I5ZkN6bmNGODZaQWxKMFFVdnl0WWkzU2poTk9GTlcvVDFx?=
 =?utf-8?B?WGNjRVRqMmE5SHNCVkhML3c5cFZDc1BLd1pBSnZQV0F5cnZCQXRYdWVneno0?=
 =?utf-8?B?UEZHSlM1OThSTFR4NDFPNGlxdTFiN2JFOEZVZEVOWkxVWWw0aW16dVJkYWhJ?=
 =?utf-8?B?T3p2RDdiUUpXRjN0SlhXblVGOWthdTVjbXphVzYwaFRtSEJXYkVzcittVWtR?=
 =?utf-8?B?UklYKy9MWG1qRXJONWRRU2o2VXBnVWhsZG9KQm1ZaGl1WFRsb2lmUGdvOWFa?=
 =?utf-8?B?UkdlV09yeGx1MDFBQjh3OEsyWFltdnpESVhmMEFib2hRWWo4dXQ2Qk1nZHd0?=
 =?utf-8?B?VVlvZXpTN2tTQmY3cyswQ0Y5TDRhNGZWTGdkTEN4cSt4dnR4bS9HYUozWlo2?=
 =?utf-8?B?Mmpnc1dXcExvU0xoYmhvZk5FdlBoS0MzRDF5cmJaV01iNkc2cU82eCtOb0xp?=
 =?utf-8?B?V1BqMHFKSmFXNTAwWE1Hcno4Vmo1L1NBZ1p2VzRwcnREZjBiVDBrbnlBN1Vp?=
 =?utf-8?B?Mi9hWkVRdExBbzR1bXVEWFVVVVdmSVpUU2hwYkt6K3NJSlh0d1FnMkpwcEh3?=
 =?utf-8?B?dUZLU1FRSVp2NEtsaDk3RzVHYTN4bmJEVFdoMXlCdTZ4dVJ0MEt4YWNMM0Iy?=
 =?utf-8?B?VnRmcFV2Szk4dVpOc3NBZkNqQ09pclpmNXFWSjF2K09FQVpqNVhxeWZpN3dq?=
 =?utf-8?B?dkI0cFpaTGZrQ0o4WE45SkJYbTRBaXNnOE41YU1GM0RQS1FGN2dHR2VDOC8x?=
 =?utf-8?B?d2piVVZqWTZ6RGMweFBXU0ZtQ1J5dWZSUFc4WUUvSnUrYXc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NFRLcCthWUVLaU5GeVM0WUl2T3pibUVRejJKeWZUcEc4Sml2NEhLZ1RaTEVT?=
 =?utf-8?B?Z1NLYVlWQWF4N0daalhlU29KTHNndWhQZktUaThMNTcwYWZBNE9la2J3OVEy?=
 =?utf-8?B?Z1dDSU4rZjBOK3BadGlFS3JMV0VTL1JSTjZhWjBaK2NMaGlGMzJTSjFYQlp3?=
 =?utf-8?B?OUxpU0xzZFd2M1IvR2FZVGZmellNUjQyWlFQNlNqdjBUQ2h3eHNER21LanlJ?=
 =?utf-8?B?UU5wQUZkWDhkdWxNbHFGY1VXQkpka09rc3hhL204QklrMXNTRTlCc3k2ZDVO?=
 =?utf-8?B?LzQwZXUvRVY1cFZvNStOenk5YTRraE9USzBDRTJoZWs2NDJLRkxWT0xIWFdo?=
 =?utf-8?B?ZytybklZVUwwZmQ3T2pLRktmQ3Q0Ui95RVRHWXhKeTRCVjBwWFFlUWJUSnlG?=
 =?utf-8?B?N0FqT2ZCQ1IzdnQreXgxWTBnK293cGltckl5SFRZWHZHczVSU0ptSVhZcjZT?=
 =?utf-8?B?V1BITG9IdndTTVFOMExWc3JNMlJjQzFISEk5b0RoNVFIV01QM1dqOWd5MGtn?=
 =?utf-8?B?aWRGVGNyOFE0bTd2QS9VRVliV2tpMENVa0d1eFFtZERKUEluMTdKL00wUU5j?=
 =?utf-8?B?N29SUG8zcitScHFKVjFpVzUzVjFzaVR6UHMxdUNGeUlSa0JnNEtBWC85ZERL?=
 =?utf-8?B?ZlpWSTV6R2xvcDJFcXd1QU5MTm1LQVFtYkNqdEFSUXM1SFNBM2hyMG1RRldK?=
 =?utf-8?B?SVI5bGlWTXE2SGtaVDNCK2lUNnlmTS9WUnhERUVlZWNRbnEyRTFYbHl4Y0pZ?=
 =?utf-8?B?RlhCdXIraTM3aXlIS21uWTNLcHZ2VTFJUmM4MW1IYkQ0WWdSL2ZDb0ZWR3F0?=
 =?utf-8?B?YXZudUliVE93M3lzaWt5dGdBZVJCZ2ttU3F2Zy9xOHQvb2hCdnZ6TTZtZldp?=
 =?utf-8?B?b0x0Y3NZb0cvMUx6WnJYUFFzbmcyQnlOQWJ6Z0NjaVJmcE8wdm1GNkwvVFcw?=
 =?utf-8?B?MEVkL25FUFFyeWthWVJNRGNwMTJja3B2ZjJiN25uZCsreUZlTUc3NTM2NjNm?=
 =?utf-8?B?WEp6OGhGUU02am4veEdYMThQenI0cTRHRUJxR3JhRHVRMHJNY3lRWDA4c0pD?=
 =?utf-8?B?aW56TW8rVmYyd2JPQmpzUWx1ZCthV0kzZU1pNGhrN2xFOW1ZUituNnhaRXVl?=
 =?utf-8?B?S01hZDA4TnhJRWZxQW9vaHJEeC9IYVBHY0p6UDFFQytpREpXQWlpa1dPalBs?=
 =?utf-8?B?blF0RTJoNWJaSzhHRGdUMjdPbmQ2UkNMSDRDNzFvZGQ2TWNHYnk5RGVCMXl4?=
 =?utf-8?B?bDIvd05IbUl3L2k4VWtZeFl4dHFzcXU4SFBoQ1pIUGpvcUF5bURaazVrYkV6?=
 =?utf-8?B?eWlDbEppNGNBNDZBL2ZNa3NBT2xDdm91MEVsU3lGU05TZmhBSytzak1xYzR0?=
 =?utf-8?B?d05GUEhtN3F6NXZ4aE11N2ZIRjcxbVF1Q3FvN01pR2hINituQ0NtUWE1cEhO?=
 =?utf-8?B?ZnJ1YlViakppUzF4aHBpR2g0bnVEd1VwYXI0N0NYM1BSY09DdEVsTjJnSDhu?=
 =?utf-8?B?YkVCODlPM0VUb3A1ZHR2RTIwdG01cnBobTVTY2VITHZuVFVSaTdSOVROT01r?=
 =?utf-8?B?bGtMdVhUMG00ZENIbi9RazNncHVPZnU1OXY3S29YbzZSbjIyQVJVKysvdzRM?=
 =?utf-8?B?SHVVUllzcmhHNnZJN3RaR3hxK1dOK29JTmU1amV4YjgrRGJnZlFwMkxhQTFI?=
 =?utf-8?B?a3RJV21hL09FZ1BxYWQ1U253a0JoZ3JGZVpBUFBORW05UWdjS0hkMktzOEp0?=
 =?utf-8?B?aVFJS0hxd3FJUmJVWG9pazd0bnE4Q3E5WWJ5ak1ROWJDYXZsNFVhV3RlUEd0?=
 =?utf-8?B?SWtZdlE3Wnl6TlF3VklXR05uNitld2JhSXN5YVRIOU5IZ290YUtvdDFtcCt3?=
 =?utf-8?B?TGg2M2c4dzM4aWUrTFYyZzJTeHlDa2VHY0lSMzBYYzlSMHFlL0hET2tXKzlX?=
 =?utf-8?B?RlRha2dRN25wemRMN2ZCYWlpOUxRTGpjL1BIUTRvUVltTCtRNlhpUEYxazdB?=
 =?utf-8?B?N0RUUHZtUFF3OFZTZVZOSjZWLzRBQlAwNDJJb003UnU4eDI5SHo5ZEh5K0xM?=
 =?utf-8?B?N0tOZ2d0ODRGNU0wR0l1czY2SldYWXZFVit2Rmt6UEhSKy9qZVFsM3dCbVVz?=
 =?utf-8?Q?XllvAMc/u3Z07xUk6npjQvoyQ?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a616f6c9-424a-45ba-b61b-08ddca9646d3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 09:41:34.1666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QptRBEW01XhWBfLZMl4wWjcfV81Kz1Fc7riQZw/OG0E7CRa0gWS50xu5a3Q+ijVKexNVmzaUuFn93Uh+6Xva7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7154
X-Proofpoint-ORIG-GUID: AqgfJfg5W5j1hFIalNQ677YcqLQZHvhU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA3MSBTYWx0ZWRfXxO34gg3wxdYm
 2TWU1YDAgO4lNrh2rEqUzs96IOw2y2uwHbCBSCNqQDFR4w/8I7+cQR/CtmlvuR8LGHZHYAmcxVc
 qDfikoD8mi1I8No1DAR5oJIOuV5U2YekKL5MMp5OQfbh+VbUTxyVOE1jUcrhDFZJ5EcU/4K2Rsq
 znKkEMQbYxE8aU7V014exOd4g1+6RfqHtBQP8Qj2epeLwPIHEUzJjgp7aAgBTMvDiIFRUudu2Rp
 N6C8AQoh349JLmiMeLP5zvf8KqIXdLDz56xW4mjwcjQmsIvUZlUn2yrS24gvZkRS+kT5PeS17tw
 KAbdcV2nlg6rsrw2aaHmT2hxYC4ldk1NI9L4C+Bf46V5gp/Igvx43P6RqpySByPGTS+z2i4HyQL
 jIcB1xm6
X-Authority-Analysis: v=2.4 cv=Gq5C+l1C c=1 sm=1 tr=0 ts=6881ffd1 cx=c_pps
 a=Q/Wut8DCZm/BU1iMwo/3iA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=QUBneihdnslBDRZ8CFUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: AqgfJfg5W5j1hFIalNQ677YcqLQZHvhU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 phishscore=0 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507210000 definitions=main-2507230196
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 24 Jul 2025 09:41:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1866


On 7/23/25 10:42, Clayton Casciato wrote:
> >From the upstream maintainer, Chris PeBenito:
> "I'm not opposed to this, as long as meta-selinux maintainers are
> willing to maintain/contribute to distro-yocto sections."
>
> Are the maintainers and wider community open to this?

Hi Clayton,


Thanks for your work. I have no objection. I think it is a good thing 
for both upstream and meta-selinux.


//Yi

>
> Thanks!
>
> --
> Clayton Casciato

