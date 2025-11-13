Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE446CD5BD0
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 12:00:37 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22185.1763035233107786440
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 04:00:33 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=KgXqwn9j;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=3412b09296=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADBomvO1196740;
	Thu, 13 Nov 2025 12:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=+96cJCkLHfv+Nbj9lskQ7wE/DZ3FNL75LwQavrduGMg=; b=KgXqwn9j5iZe
	i6WcoRx89Gf6FKxhyNI0VwPoXw5ukCQJHj5tvhwauzmIovY0t3elZLvFkvZr3niK
	7s5YJR71A8RvJOXAVxvHzFXU/Z990Q2kIAhwIAMTDVT3Bnh2p8l7LyqTXgzGTRB8
	6P8mOt8YdBiqm70f4FD89Gt3rxgH50kRkmIKfoTkvXUzrMLDUIvsFDxNKO/jUtVH
	FY5cvzCtXcNuN39oCeWfmN1gVoElims+1UllOtRDkS55ZneLvsTyqDiJkZeH4e1M
	vJZZfeqE2A5aeEfW7UrbNp085VmATPaugkue1cK3vTUrLVHfVSk5RUREaokkc9CK
	N3h3QzX4ow==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012007.outbound.protection.outlook.com [52.101.53.7])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4acwphsrwf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 12:00:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PtlQV7RtkOhs9YXePtq2E2jBnf7AeBMwYW5/7VL5zCCS/ec6lzJDjWZpVUgxPCgYCeBCZ2UNBq6+CuCpJ59Qd41hy9kvGbCeR4EKm2W4gOkXWhVyDhSiywRECNJxKww7kp0M3MyaxTjWVV1tqTU9vwEXBX58CqOZhhDPiJvAf8yk3O1Rd+BHFkVbWgzY6WQQZz5rwOIfHtVvGQGoJy8c3bVmi6lpKwjCBUp3ypGYaxd2+81ntuLh3hvCo35tDBsfa44Xm9Sdk5b/2zhMWZJosV3yIQz3z5o8QYVy1AJ7xnhaFyVR2TfL/wr7alD1SilQbTh9tWUCIU4ggZTFYy3IUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+96cJCkLHfv+Nbj9lskQ7wE/DZ3FNL75LwQavrduGMg=;
 b=AnHdtQ6mS4BQGtAss0t24B64wagl/0vDA+hs7MESbYavxYYVIKZsmLuEawZ/fn9pUwNnJMz2vByC5uasIk3SToLZV1jaHdP8+2DEZ89Tnlba2twW7X0EWfbPuP/csO3PAEbz3iND6wN8cy8lIMoCn55VVuIrRFeTmiOcgyS94Rg7FVmypNExDT4D9wirUDSvbFgM/9lMfX4RFaz3wvZsbbjE7v9wSOsV4HiMh7RBNcOhBxijTW14OSqot1RuKeZ4yITVBrJUkYZk9rq7VeIL5n5wIJQHE7Uz/lLCp8fQA29XVdyt9Oy/I6Lox70auoYuug9ST1BsKoa0k4U0PZh+OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20)
 by BN9PR11MB5273.namprd11.prod.outlook.com (2603:10b6:408:132::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 12:00:27 +0000
Received: from PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::ef64:bc9f:eb8c:e6e]) by PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::ef64:bc9f:eb8c:e6e%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 12:00:27 +0000
Message-ID: <f30b95eb-40d2-49f6-b6a2-87bf2c936272@windriver.com>
Date: Thu, 13 Nov 2025 20:00:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [pseudo][PATCH 1/2] pseudo_ipc.h: make 8 byte
 alignment for structure pseudo_msg_t
To: yocto-patches@lists.yoctoproject.org, Mark Hatle <mark.hatle@amd.com>,
        richard.purdie@linuxfoundation.org
References: <20251111135951.2121065-1-hongxu.jia@windriver.com>
 <ff0a842e-cc9e-443f-8f8c-c7206a719dd1@amd.com>
 <18778CD44C46032A.981615@lists.yoctoproject.org>
Content-Language: en-US
From: Hongxu Jia <hongxu.jia@windriver.com>
In-Reply-To: <18778CD44C46032A.981615@lists.yoctoproject.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SG2PR04CA0183.apcprd04.prod.outlook.com
 (2603:1096:4:14::21) To PH7PR11MB7608.namprd11.prod.outlook.com
 (2603:10b6:510:269::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7608:EE_|BN9PR11MB5273:EE_
X-MS-Office365-Filtering-Correlation-Id: 45c97fff-827a-4c7f-a187-08de22ac3bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|4022899009|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZFJlSzVScnA4T3lRZzA0S2xIUXY5QlJyTzBPZ29qeXhOOUhkUHNERjRyOEFJ?=
 =?utf-8?B?VlNYMk1KQUN6U3RJMkhmTHFrSitYSzV1UzVDT21xTDRyT21SV3hZQ2w2OXVR?=
 =?utf-8?B?MzJKS2VlaWhSRnNMMnQwNG4wTmk5aklnQVByTnJtK1YxOEdlbnlCSkVWZFhE?=
 =?utf-8?B?ODBYSzVGUjh6aEZZeHkzYXUrWXdDbE5tN3JwcTRlZDVEMWs0OGxVV1d1WmRC?=
 =?utf-8?B?ZVR6M0dOUWE4SE9jdnJqY0kxd1dFQmgzVExjVDlkVEx1M044TDZQaTVvR0VE?=
 =?utf-8?B?SFJGTmpPeUNpTmZvRmFsd2NOMGlDTWN1eUFmc01WTDBkQlo5a2R4c0YvdnVz?=
 =?utf-8?B?ZEFWVHR6Y2kraThmV3Ywb2YwMlZ6TDkwd3ZCRU9iWEFKQzJrY2I3NjZOeXRS?=
 =?utf-8?B?QjF3bkNNRWs1UWlKM2VSNDhkT3lNWE8zRmNJZzRYaVkxN1pvdU91djBicVNy?=
 =?utf-8?B?MDdFU1RQT1lidEgvZWtuREluUDRjSnB6VmR5UXJxZmtRSmVtTkJxbHNXMVdZ?=
 =?utf-8?B?cmRST00wQk90MzZwNjh0NVIrMFNJaGlnbGJJNHpCWGdJVERFNEg0SktISXB6?=
 =?utf-8?B?V0d5dGxzZEs0ak5ocDZOVzZvdlY0RUdyNHFhMkI3a3BVNWJ5a1ZNREppeEdK?=
 =?utf-8?B?Ry9NYVF1SVU5c05OL0Y1VW0rcUMrR3RsZEVkQk41NEs5LzZreXV3elcrNll0?=
 =?utf-8?B?UXhtS1RvRTFoeTN2WTloRkNad3BuMHU2aE9zSGRlTUpmS2JzV0M2Zjd5RENl?=
 =?utf-8?B?cjJhK1RPeTB2YWF5ZGh6WmpqYXBpQWpLZVl4WG8wTUlPTmFncDBwVkx3VHNx?=
 =?utf-8?B?MTJEckR3TGY5WGpGems0UG4wK01sUXBzMEw3SWZSZnhkcXRjN2lYTGliT1Jk?=
 =?utf-8?B?dGpMNGtTbmlKbjBGUHdtcmJhZmNqNmFqODA5WHA0a04zVHV2Ym9JUFlFeUhH?=
 =?utf-8?B?UWFzcEc3d3doNHlsQUVhMmZYZ1UxREkwUStEb1p1bXh3Z1JacjRIS3dYanNv?=
 =?utf-8?B?Sk0rK01rcmlDdHJYTUMzT0p2SDNlUnphblJpVDZlcGVURE0zWjh2Z3JzK281?=
 =?utf-8?B?UlBoNXJaVnIzL1pSMU10czhVOTVJNTNMTlBIL1pxcXRJK011dENsSFNUQWFr?=
 =?utf-8?B?Nk0ydUNIemlxRGoyY2tCdEhWV3J0Qm5hQjBWTVV3Ump3U2Nnd212UnFTYmJK?=
 =?utf-8?B?Q2FTYktNWlhESlBObWcvdm1zOU1VOFYzVnZ2K2ZvM0pLVGRJU2hXbDkwV0hK?=
 =?utf-8?B?ZEZ5c2g0RElNYWJseWhRL3FvSmxNTWthUFRvalhoNjlQaVllOHF2dlkzbVBu?=
 =?utf-8?B?b0QzOGplMC9kTHkzUVBRcTBDUTlORWxsNUhrYnJzcWRSSDhpSUloc09TQlcv?=
 =?utf-8?B?Qlg0RzNlNVgxODN2Yk1LaDA1dHJMeGRRRGZOT0hzWXZ2L1FMSUNoQUhCVDh4?=
 =?utf-8?B?ekNtL2hRcHBpZkhiRzFacXdsVEYvbWpiSnRsZGhZckducFBOclBKcGcyZnZq?=
 =?utf-8?B?c1JzVG1jdTZ2WVZxb01XT1V4SElTeXVzeVloUkZBRjUxNXVvelU3SmhlNmlI?=
 =?utf-8?B?UEV1RzZCbk5GRGE5azN0N2YyT2RnMVpLbUxFbFEyelZoVThaSFB4d3dQRkY1?=
 =?utf-8?B?cFNONWQ2V3BON3lDVVNGWEpBVnZJTGdxaWUzVE5ubkIrTkVGLzdtLzRWVkE5?=
 =?utf-8?B?UkZKMDNCYjYwdmltR2E2QkZPREdKSk5HUHlZNTZBQXNFa2U0UDlFcmQxVnJv?=
 =?utf-8?B?Vk9wclNxRGFTdkNQM2Nma1BiSytGUzZIZjBVOWFaZ3pSQ0FpQ2VUWVlBVlc1?=
 =?utf-8?B?MkpqUEU4TUhZRXRrMGJlNk5zZ2VlWDZORVBTRFRoVjJnTVEwcVpCVEUyRDJF?=
 =?utf-8?B?SHpMTWJNSnlIUklTWUNab1JUSFgyRU96SEpMMXZrQVphVWc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7608.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cWs3VWF2ZmRvcmUzNForR0pBaUpZYmRFY0JoOEZNNE5SQjdKMGg4ald1cktx?=
 =?utf-8?B?YU0yeGFueWVIMjZldHk1aFh0L2xkcC9SVDM0VktYWTNXaDVDY2ZoOWtpa3RX?=
 =?utf-8?B?TGxESlFPNjVmYStIQTZ2MXZ3b2lwUWVEWFpZZTk5bG1wdDlaTDlnanByeGJw?=
 =?utf-8?B?MnZIMGJsNHRwMUxWTkhHWGNTMW9yQXUxOGZRUzFhM25GeHZKS1p1RnB2eGRT?=
 =?utf-8?B?QTZIRWVNck92WW1JUVBSZkh0UjcwYU5OZCs5cldHQzZlWTBUZVVHUUtpUWdT?=
 =?utf-8?B?aE5HVUJRc21qRmJmcWlDeVhnQS9tNE5LNGYyNlRlcjRDRGNMUzgvYmhUTVVm?=
 =?utf-8?B?LytYaHNQWTYzTVFuRi9QSWhWWnJFNllRMkxYN2hWb2xORk0ySzlJaGlBRXZU?=
 =?utf-8?B?Z0RGVmgvb2loQTRibVhEazRHT3ZkQmgraWNKMnZxZ2NTc3NRa2t3bFVMZ3o0?=
 =?utf-8?B?dHhvTldkWmJZendHZTRnT2h5dWZPbzRDTmdKbG9uN3Y3MG9wRGt6Z2JFbGti?=
 =?utf-8?B?OTZOU0RqbGpnSURsZTdNZ1dNbkFEMW4zSFlJdnlyRzNRUDBabXEzUDRjclJJ?=
 =?utf-8?B?eEtWR3dFbC93dXMxUURjdWdQSkEyK1dvTWgrSUZrUXZkOGNSc0hMM0Qra2o5?=
 =?utf-8?B?ZHZ6Wm9SNE1oRWNCZ0VwWlNzZWorUlNYRG0wcUFSZkNlbWNIbHM5QVhNZW13?=
 =?utf-8?B?amNSdDJhYXhvaCtUUnZXZDNoWlRRUHI3ak92UkFPMGZiS3lSckZYc0d4bjNK?=
 =?utf-8?B?dWZIZjlpS0ZaOVYzN2ROWS9mTDZTSGs5WHkxTkFEaWhrUnRwOGt4di9UTDc4?=
 =?utf-8?B?akNtbHFSYnZwVTQ0VDM1NnlqcHk4QkhZcUsyZDFrYmV3aDdHS3VPM3MwZzZz?=
 =?utf-8?B?R0I5aE93S0VzWWtEVlNlTFhiY3B6M3l1WE15dC9MQVA4L0dveGlBVWF0bGZm?=
 =?utf-8?B?VCs0NTVxY0FKbXRSeEZzVU1hMDBNSnEwQU85ZE93NUJpUHg2TjhReFlSbjhI?=
 =?utf-8?B?NWxpYzJmNVZjR25XUXE5di85YXpzWWtxRDBSWlRhTFBpbVNTU2IvMkZQdUlZ?=
 =?utf-8?B?RDhWVHVjajhZNEw3YWxYd3JHQVRNSS9LTUR1Rmd3K3JEbFd2WnpCT2lpRGUz?=
 =?utf-8?B?dlJnVHRKak5XUDhNNkdxK1NQQW1rVDVjcWd6SGtBTkxibEpQN3NmTHJNMjBk?=
 =?utf-8?B?b2hTR0d3OGlXRUFxL3U1MzZOY1pnZWNscjVoaWJ5Yyt0N3JzMmw1blVBSlBy?=
 =?utf-8?B?a1FKWjh4YkhWZWhYc05KZW40MjZHU1U1Ym9IUW5LRGxJMzRUVjBHVE92LzhV?=
 =?utf-8?B?ajdKZDdST0FRVjlEUjNqNkh6VjhFbXU3NHNVZW9TaVQ1dE9kek1IWHV5bldH?=
 =?utf-8?B?R3JKL1hLYUhhd3dxMDh5OEdNbVpNZXlNV1d5R21JTVpYSDEyY3dENWlPSDlv?=
 =?utf-8?B?VDlaK2ZzaGc1eldibUtDRmd0NTFWSDR5RzdPa2ZMd0NaSWFxVG80V2JtS01G?=
 =?utf-8?B?KzZaK1hsaGgzOTZaeTUrbEpXd2dLRWRRaU8vYzdvOXdCNkprZXdkMjdkTXBY?=
 =?utf-8?B?dmE1RGlDZkZVZkxmNmkyVHZIYzEvdFlSMnc4YjlQYjVSR1Rxcm9maCtrdDAz?=
 =?utf-8?B?bkgxcVU2V0lqQWlMQ2cyMmtuVFVXNHdxTlgwZGVVNGhDUWhqb3pseGlvMUpo?=
 =?utf-8?B?UG93ZTJzYm1DMVMzbGhvM2ZwUUordnFPTzFBRTc3amgybnJ5NEIwVVRCTEZj?=
 =?utf-8?B?aGJxVmIzQWs4eEhENG1wVUM5SnV5QUhIR1BMNFE4QjRMb2FNaTQ0Y0RKZENO?=
 =?utf-8?B?cU1lWlM3NTlvVmJBaTNidE1zMjI5R2IzYW1xRUVxSDgyVjZBcmNIQWxTamJk?=
 =?utf-8?B?bWhFQ3hzTWxuQlpqODB4cTlPZkVRQWJxRlA1RVRGOXJYWUpaaW5pbFRPSWNw?=
 =?utf-8?B?bk15RU9qcy9wcy8xbmFXby93YlZHRm1WdVFMWU9HNDZNeUwzeVlJMG1QeTdB?=
 =?utf-8?B?RXl0cFoyelF4RHhPckcxakpTSHVWZkc1Z3pKSGFodVRKV2Q4TlYyQkl4UVpk?=
 =?utf-8?B?WmlsVEhoRkZ3WTI4WGM3VFBDR1dtN2VkbXN1MzhzcnVFbEkwbmNzRUI1aVNT?=
 =?utf-8?B?QWZNNkd6a2lHVEF2Y3VSbVN5bG1kdFBUR3hkazJVMmdKZ2ExM2IyWjVRMHhE?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c97fff-827a-4c7f-a187-08de22ac3bed
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7608.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 12:00:26.9838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNPn7CL5OEbmlDVtlJW3x8F6ymoncbKqDdTlbuVBxkeO9SpsPlC2b/4bwbyB77hPSU57zlBco9XztG/rLTPItsgDG+VlNGLXbCMdUl/+G4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5273
X-Proofpoint-GUID: 28_9hODiTig52teljPRGLpxaXEfvttFt
X-Proofpoint-ORIG-GUID: 28_9hODiTig52teljPRGLpxaXEfvttFt
X-Authority-Analysis: v=2.4 cv=TKtIilla c=1 sm=1 tr=0 ts=6915c85d cx=c_pps
 a=OViojaO3c1oaidwcGWKC2A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=c-VF-FKvAAAA:8 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8
 a=Pxit7gfDrbB0Lm1fM1EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA5MCBTYWx0ZWRfXxojUmzaZ6TXw
 1RR9QkrNtHLpqbB6mEXVNuWSzTZTgOT6NSXp6bMaqFFMWH9fybaRDTvr4m7kO9F7edmqrxyk0U0
 2QgtChs9ug1k/T8NBJ2wCe8n86JQnxgInBFrGFjmoN3omZGHwvE5GUJNkpvrczCOlg8ntT0bZ9m
 gydDIdOvTCo8sKMnvm33kAx21rTa6IP1WFfCl26GQq8JuBkPId2suUKu6cqYETSREiT1kfejE5N
 +gin+UCqp9YRKfrbWeCv1CqP+EUSfdSX85v1pp4NZsN2A9htlpfPMWa9iygSRRIYsnP0Znm1nUV
 ZaeMToODFcUA/He81t0QGaib9R5sHLaQ7EQH3bsY65tjit2jdH2zrJs1vQBWacajQKcE+z12QCr
 grHk3CjedSBovJHcWKU7cH2P9tlSaw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511130090
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 5ADBomvO1196740
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Nov 2025 12:00:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2504

On 11/13/25 19:16, hongxu via lists.yoctoproject.org wrote:
> On 11/13/25 01:46, Mark Hatle wrote:
>> CAUTION: This email comes from a non Wind River email account!
>> Do not click links or open attachments unless you recognize the=20
>> sender and know the content is safe.
>>
>> On 11/11/25 7:59 AM, Hongxu Jia wrote:
>>> typedef struct {
>>> =C2=A0=C2=A0=C2=A0=C2=A0 pseudo_msg_type_t type;
>>> =C2=A0=C2=A0=C2=A0=C2=A0 ...
>>> =C2=A0=C2=A0=C2=A0=C2=A0 char path[];
>>> } pseudo_msg_t;
>>>
>>> The [] item at the end of the struct is a C99 feature:
>>> Flexible Array Members in a structure in C [1]. The size
>>> of path in structure should be 0.
>>>
>>> On 64-bit arch, sizeof(pseudo_msg_t) =3D 80, but PSEUDO_HEADER_SIZE =3D
>>> offsetof(pseudo_msg_t, path) =3D 76, the reason is 8 byte alignment
>>> in 64-bit arch.
>>>
>>> The differ between sizeof(pseudo_msg_t) and PSEUDO_HEADER_SIZE
>>> made memory overlab in memcpy, such as
>>>
>>> =C2=A0=C2=A0 memcpy(oldmsg, msg, PSEUDO_HEADER_SIZE);
>>> =C2=A0=C2=A0 memcpy(newmsg, old, sizeof(pseudo_msg_t) + old->pathlen)=
;
>>>
>>> Add 4 chars to structure as reserved for 8 byte alignment, then
>>> PSEUDO_HEADER_SIZE =3D sizeof(pseudo_msg_t) =3D 80.
>>>
>>> [1] https://www.geeksforgeeks.org/c/flexible-array-members-structure-=
c/
>>>
>>> Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
>>> ---
>>> =C2=A0 pseudo_ipc.h | 1 +
>>> =C2=A0 1 file changed, 1 insertion(+)
>>>
>>> diff --git a/pseudo_ipc.h b/pseudo_ipc.h
>>> index d945257..2836cc4 100644
>>> --- a/pseudo_ipc.h
>>> +++ b/pseudo_ipc.h
>>> @@ -26,6 +26,7 @@ typedef struct {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int pathlen;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int nlink;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int deleting;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 char reserved[4];
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char path[];
>>> =C2=A0 } pseudo_msg_t;
>>>
>>
>> I think it would be better to use the alignment operator instead,=20
>> specifically:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int pathlen;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int nlink;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int deleting;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char path[];
>> =C2=A0 } __attribute__((aligned(8))) pseudo_msg_t;
>>
> The `__attribute__((aligned(8)))' still make PSEUDO_HEADER_SIZE =3D=20
> offsetof(pseudo_msg_t, path) =3D 72,
>
> Pseudo use PSEUDO_HEADER_SIZE for ipc message send and receive
>
> The PSEUDO_HEADER_SIZE is supposed to be equal the size of struct=20
> pseudo_msg_t, but sizeof(pseudo_msg_t) =3D 80 which is 16 byte=20
> alignment=C2=A0 because of a long long member (16 byte) in struct pseud=
o_msg_t
>
Correct one thing,

The `__attribute__((aligned(8)))' still make PSEUDO_HEADER_SIZE =3D=20
offsetof(pseudo_msg_t, path) =3D 76,

It is 8 byte alignment, because of the size of a long long member in=20
struct pseudo_msg_t is 8 byte. Then 76 is aligned to 80

//Hongxu

> //Hongxu
>
>
>
>
>> In my testing this results in the same 80 byte length for both 64-bit=20
>> and 32-bit systems.
>>
>> I wrote a quick test program for the addressing:
>>
>> 64-bit:
>> Address: 0x4379d100
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type: 0x0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op: 0x4
>> =C2=A0=C2=A0=C2=A0 result: 0x8
>> =C2=A0=C2=A0=C2=A0 access: 0xc
>> =C2=A0=C2=A0=C2=A0 client: 0x10
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fd: 0x14
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev: 0x18
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ino: 0x20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uid: 0x28
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gid: 0x2c
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mode: 0x30
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rdev: 0x38
>> =C2=A0=C2=A0 pathlen: 0x40
>> =C2=A0=C2=A0=C2=A0=C2=A0 nlink: 0x44
>> =C2=A0 deleting: 0x48
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path: 0x4c
>> Length: 80
>>
>> 32-bit:
>> Address: 0xffc2a828
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type: 0x0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op: 0x4
>> =C2=A0=C2=A0=C2=A0 result: 0x8
>> =C2=A0=C2=A0=C2=A0 access: 0xc
>> =C2=A0=C2=A0=C2=A0 client: 0x10
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fd: 0x14
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev: 0x18
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ino: 0x20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uid: 0x28
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gid: 0x2c
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mode: 0x30
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rdev: 0x38
>> =C2=A0=C2=A0 pathlen: 0x40
>> =C2=A0=C2=A0=C2=A0=C2=A0 nlink: 0x44
>> =C2=A0 deleting: 0x48
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path: 0x4c
>> Length: 80
>>
>> This seems to address the issue and the offsets within the structure=20
>> are maintained as expected.
>>
>> --Mark
>
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2502):=20
> https://lists.yoctoproject.org/g/yocto-patches/message/2502
> Mute This Topic: https://lists.yoctoproject.org/mt/116238032/3617049
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:=20
> https://lists.yoctoproject.org/g/yocto-patches/leave/13176071/3617049/4=
3253763/xyzzy=20
> [hongxu.jia@windriver.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>


