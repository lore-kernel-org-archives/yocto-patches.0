Return-Path: <hongxu.jia@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D32C021AA
	for <webhook@archiver.kernel.org>; Wed, 19 Feb 2025 02:52:00 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.13937.1739933514296764042
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 18 Feb 2025 18:51:54 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=41458e6591=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J1kctd026329
	for <yocto-patches@lists.yoctoproject.org>; Wed, 19 Feb 2025 02:51:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 44w00j8f4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 19 Feb 2025 02:51:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5MkJ2ZGwMPBBlKLdfb3I4wzphpIWBTkgikFia+PZq3+5wMgtkP8HZqS7gYKZWvbVCxuP0yhWzxRCr6RL2aIbsKjJkASkDBBzBN1+g0qnM+JzLbPjFf6A2MZRcyGjn8Ojo/vdX+C+oiEVZqy3vIz4MSgT/WH8DkwL3BasI9F24/JDIOUqSmkTwRvqPps6YNo2DMqbJKwG6fX5tomHe+sr6wcY/ymQ0dw2tAu08rnyeuHO6u/aVS2+Z8k8C6VcDf9kZ1jCcuyJlj7tHGhbwaAGGjrkOcSW+yBLg8Zxz/tZmDFKOm89Zl7LdOLdLOBQRLfVhuUXHXwrUWXshxXQ7oMOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etfW/0XBYrZ0nYdRAp2EmNTDIzy/5WotmG04yKMq1F8=;
 b=j9KaCvRpOuAFLBGwEQ/KxcYZ1EQ7XJ9mZWLgTAke6fqjDUMz5xvTwJXBJdOi2QktxAuXdt3ACHYUgXHhziOZXPaV39Y8tPCTno+y4cOwCPmmbCHTW/ayDtnu0BS9E9/+gukSFfXcOmYBJhNYHsyG4UwJjDCG6rGL8KErWUL1hgAd4o1c/U29oHV8hyV6qxoURHJGrZSouA3sgJ536DWHmAkFvnrh1Z3u9emvFyt8RqWiMQKiT1x9yd9C1YvYgqXkaD2rnUcsNcOqnJCskfgn6d+dhjlxCC2Nw2cbw8vW7bet7KqFVhmzNwGRn28wj6HS7pxI0ardCGmP5mbe3Rqxwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20)
 by SJ0PR11MB5037.namprd11.prod.outlook.com (2603:10b6:a03:2ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 02:51:50 +0000
Received: from PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::ef64:bc9f:eb8c:e6e]) by PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::ef64:bc9f:eb8c:e6e%6]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 02:51:50 +0000
Message-ID: <89e91018-9007-4bd9-bde4-81a44642db1d@windriver.com>
Date: Wed, 19 Feb 2025 10:51:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-tensorflow][mickledore][PATCH 1/3]
 tensorflow: drop Upstream-Status inside third_party .patch files
To: yocto-patches@lists.yoctoproject.org
References: <20250211161500.3077588-1-martin.jansa@gmail.com>
 <d77e1e97-ded6-44bd-8d80-fd855b738b10@windriver.com>
 <CA+chaQfYxzndjbbwTMd6oiraKhknhc_HwhzeXytPqQpuTxX8mg@mail.gmail.com>
Content-Language: en-US
From: Hongxu Jia <hongxu.jia@windriver.com>
In-Reply-To: <CA+chaQfYxzndjbbwTMd6oiraKhknhc_HwhzeXytPqQpuTxX8mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: TYCPR01CA0071.jpnprd01.prod.outlook.com
 (2603:1096:405:2::35) To PH7PR11MB7608.namprd11.prod.outlook.com
 (2603:10b6:510:269::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7608:EE_|SJ0PR11MB5037:EE_
X-MS-Office365-Filtering-Correlation-Id: ab31b78d-0139-410a-43c6-08dd50905bb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|4022899009|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?czJHTDF2enFiUE9CTCtrQTBvQi83RHc5TVRxUkx5Z25UcGk3M2pLcG1xWGln?=
 =?utf-8?B?VzVJVHcxQU9kTXNJVFkzM3VueHFMYlhzYm11ZFNlaUtwZzk3RzRLdUFkU095?=
 =?utf-8?B?bnQ3U2xCVFhjSkltZ0ZsOGxBT0hxUkJRUmdvYWN6SE9Td09Oa2VVMnJRS3RP?=
 =?utf-8?B?ZnRMTVhaNzRqeStBSW5scHN0V01MYjZSbzhhMksxRXJaUGs2VEdhMGcyUUxs?=
 =?utf-8?B?VW1FajdRQ3RqZGt0YjZNd1hCbVY5RlZqTE14amxpS2djTnQ4V0NqdVg5aFRm?=
 =?utf-8?B?NDhLUExtMnh6NWxwOFBTdms5RUt1a3ltUXVkMnE5LzlBWFJxVUptaWVGZFFQ?=
 =?utf-8?B?eWhKajY0QjN3bklXWm5CQjAyWGNKSW9jSERrQmZDM2h6bTF0MHZhVmZ1TTRB?=
 =?utf-8?B?YWxBci8zRm5jeUdGVlZtblRBbHNwR0phdmN0QWFObEJTNzNHVkUySXRDRjVY?=
 =?utf-8?B?ZHpmVFBvVFNuN213eURrU0FqNHllZkRwQTFtWiswS1BPVW5qQkNyYW1sWVZm?=
 =?utf-8?B?YUdwUnBhUUtieCtueEM3VVJDWFNEWG5mRC9lcUF4dWRCVTJGS1RmeWVpY3lW?=
 =?utf-8?B?UUw5VC9GN3c3SUN3Ums4MzJYREo4b3J1SHBQWmM1N3NiUkN2S2cyU1g1cDhp?=
 =?utf-8?B?U0l2OElBZklLaUxJT3V6V3RyM28vN0g2eDdnejBESXlZS1BibFlRNUVEQW56?=
 =?utf-8?B?OEZra080NlNQSkVTTXpmdVV5TWZrQWZiYVM5bXlxWWowZ1pjcHI3bW45T2Zj?=
 =?utf-8?B?V3d4M1dRWHJ1YUJhNVVjQkFpbWtISC9WU2pMUFJLVWhWZVFUZ3lGT2Jvd0Q0?=
 =?utf-8?B?M3VHTHE5dHVXaHorcXJzbEo3V2RXeXZxcXRGOTJlR05EZkFxK1BXOWlRVUUy?=
 =?utf-8?B?dDJSRDI2VXBSSXZ6UGhzbWc2UG5zTS9aMkRFaUlrWTBqanc1MmM0WVY2dnVi?=
 =?utf-8?B?OVd1eTVmcGF1MUdocWE1UUl1UGxBT3Ywb3hqWTQxRWRFVUF2Rkp6QWF0NGlQ?=
 =?utf-8?B?SENDQ0Y5Y25LT3o2aHA0cEpTdjJhMmVHNk5jSkVVT2VJRVNKWVNEZ0ZIaEpY?=
 =?utf-8?B?UUZUZDIwM3V2Mk42ZURWejR5eWdTZ2FVVmJ4S2lydjVTa0tYV0RQY0ZwSnFL?=
 =?utf-8?B?TkFnRnFnM0dIRzhLY2xOSElKblRzMGh5YTZCbldOWG1PRjByVDZhQzlHN1RM?=
 =?utf-8?B?VTNWbGlhK0pPclE4TjBuNVFiOHMzNWx2elhDSnNJOVBaeDc5OVNROUlYd3lZ?=
 =?utf-8?B?Tkl0OTZBenpycWpyaEN1ejAxeHR4QUk4TFgxcWMwdGl3L0lBempjNnlJL3E3?=
 =?utf-8?B?MHpIZXlUTjdTbnRMTUFvLytTWkFLL1hEdmpZQXdWUnp1bEZRRlhGcWZlME9p?=
 =?utf-8?B?bWFkQ1c2RFc0TXh6eEUrbUN4OFBCR2FsZFZWNkFaR2sveHNIYVM0MkVSR0lp?=
 =?utf-8?B?c015WFVyZzVlV1ZKVmV3M2pqOTlyTHdKRFNsTXFqTUpWa0NnZ1BjNE5oUUhn?=
 =?utf-8?B?dkszQjJFZk9ETkRRNDZKL2Y4OXBKNk1LdlhNTWVhUER2dUYzV0l5Rzd6VUJt?=
 =?utf-8?B?cjR5aTZ5MlUrN1NnY1h2aDN6TE8yYUU4N3c2bXllUFV2cGNmT2xZL01Gd0tK?=
 =?utf-8?B?cUJwckxnT3ZzNGlQTUpjZW93ZjkybHBRMy9iU0dZT2I4L3M5QmRJUGlBTHc4?=
 =?utf-8?B?UkNXT0RiWWYxdDY1bU82VktWMTdBQUUvSVhETHNrRUpVK2ZxbVcvL3dFN1o4?=
 =?utf-8?B?RFBmcWdjNWI0OVBQYTFDSHpic3pqRzF2TnBkMnpOMHNyV1JBT0dneUFFM0dt?=
 =?utf-8?B?SGI3VEROZHdtNHVQOW9LQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7608.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(4022899009)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bXd4S2pkRHJVeUNYTXdqaUFudkREVnorV0lzdis5Z3c3VDhzQ1dLc0EyaGxk?=
 =?utf-8?B?Y2FyTFJxOVBOSHBYUnlVZkNaOGRwcUtHU2tZcjZwRCszMzJzOGJxUTY0Uk9K?=
 =?utf-8?B?RlUzOGx3K3hGNTBzQ3lvZTROQi9oTFhiZmJ4MlViSmNaTXVnMU5ZbDUxa0Jn?=
 =?utf-8?B?ZkhETHQxajMvQjRQSlIyWmcvR1NUWUg4L2ErL3ZMMUIrakwvZmVpMU1CVTNy?=
 =?utf-8?B?dkUwVWpUaDBKVkpsTjdKaWNjMExQSStZaVVEVGFNTUxpaXZBMWJUUWY5NkI5?=
 =?utf-8?B?OEZXK2NKL2lCdllwR29UczJMREFBd2FjazNlak5ZMW1LQ0R3NERMUDU0OVZj?=
 =?utf-8?B?VTFOOXRyaHhNTlhVc2hxK3M5YTk0eFNGSVZmU2wybjJucWpNZnhCOExhVThD?=
 =?utf-8?B?NkxMZWlJWmQrWGhmV2FxRStjbi9Fbk01ZTNYckcwdmFMOCsxR3NHU1N3dWZT?=
 =?utf-8?B?TVRmTFJubFZnNU5KVW9reE43N3dyTndTanV5UGgwWTl2aDN5M3Jlc2Nibkw4?=
 =?utf-8?B?RjhIeHBuUUNCUU5OM0R3SmRnaEEvd213NkpvZzR1UE45QTBITFEwdWl3QVRk?=
 =?utf-8?B?TENhVmgwY2I4OWhNVVlXRytjREVvTmxma0lpRy9LRCs0MFlTMllESnB5QmJh?=
 =?utf-8?B?NkkxaGVPTGVoVCtuS1o1R240UExGSWRMRGl5VTVpL205VEVTR3k1QVV6bGNm?=
 =?utf-8?B?bUIzczMzdUZzMi9aWk5VbkpKL1l0VDBYSHp6dzNtSHRZWDJ2WGNnUTRLZzlv?=
 =?utf-8?B?cmlzTG9HRGk2OGFRQm1RNEFXZWpiazlMeUVZQlFKS0VGZ1U1cTdSTG5idUdt?=
 =?utf-8?B?dXFoRnlvM2FSS3JIb0QrcWY4dzRLT1pBdlg0UFJsdDMrWXJnOG5sM2Y3RWov?=
 =?utf-8?B?S0dhbUhpMVhmWkpJdkZMQStUSE9nMmwxcGthZjJTMGZVK2JFbDBQYnk3dGMv?=
 =?utf-8?B?enpzNUdtTzJXWjRkeDlsTTRiaE1JcVQwMnkxWmpmVUVyamJyeWZ0NjhFUDBI?=
 =?utf-8?B?WVBFVDAvSXRjZjZwNWQrM29sdXlaYnF5amxYOXFPamJMOThFTHk1YnRsNVdj?=
 =?utf-8?B?NXBlNnI4UDlrc0dTWE14ZUZsbVZYMjRmNzI5UVQ1cEszZVhOYTFRNlE0Umxw?=
 =?utf-8?B?ZlNsT1BFYWhFRll5L3BFRXBMZnJ3WGZFQi8vbUlTSzJKNFJuNUNRUlM4RXUw?=
 =?utf-8?B?QUphSTVjeHJuakZzQ0E1RTluUTNSNSt4K1lsMmRxSkM1c1RBQXluNGpPQ3pR?=
 =?utf-8?B?VGhjZDRRYm1ib1A3L2NndmszaTNRS1ZsQWJYbzFFNEZtaUduNkZTZlF1Snkv?=
 =?utf-8?B?TDNQaGNYbCtZTFpvamdGaUx1bTNFcGx3clUvRm1Pb0srQXFvQ3pyKzRrTzBR?=
 =?utf-8?B?VHlPcXM1N3Q1NWlyK2ZReGhGTmEzc2pTL2VZdmJoTkZzZEFHVWtycUVRc2hL?=
 =?utf-8?B?b0lnUUZxMGE3bDhRY29uaVR6cjJtWGs5ZUxOSTgrQnBKaTR2b28xTWVrNC9i?=
 =?utf-8?B?Vzg4T1F4RUQ0ZVBtNEU0OHJadm1MckdWYno4Y09NTzRNa1RtN2YwdWxrVGc2?=
 =?utf-8?B?RFVJOTY5VUw0SWpHZjBhWHJ4dmw4aDNYbTg4TWhYVU5zaGJpcHViTmpMQnBt?=
 =?utf-8?B?dFB6UlkreVlpWHJPOUFxdlVMYWxqZU9lTzExOURsZGN1UWZKSjBPY1JTTk9x?=
 =?utf-8?B?alFuMFlDd2IxY04wcmVCS2N0QlRzNEJ1MmlzaTh3TXQ0NmdyZ01pL3RLNGVh?=
 =?utf-8?B?MTlWblhIZmVXS2JnRVR4dkVmdlVlS0cyRU0xUTNrV29oN3YyNG5keFU2MUg5?=
 =?utf-8?B?UTA4VkRaOThHVGsySW9TTjFVR0lZM3dXWVRiUURmQXcvcnd2MXZ0ejdtMHF2?=
 =?utf-8?B?RFdpNkRPUmQweDA2L213VWJnVTJWVWxLMTFISGNuNW4raGFtSkoyQ2g3cFJQ?=
 =?utf-8?B?aVRVa0Nnd1Rzelp4clJTTDhmUlNDb0JKMnhPbFh2STc1b1V1aFJvZGoyVHdu?=
 =?utf-8?B?NGJucmZFNGhWZ0dCUjRvb29xd1U5ZDlqbGgwVFNJSkxFKzhnZWQxbk5uRlAr?=
 =?utf-8?B?K0JLQkN1U1VKT2E3MXEreFNSbFJPT1lXaXJha0doRnRGR2YyTnJIMVpJdUc2?=
 =?utf-8?B?NWxmeVVOWmdIVGQvSUJ2Y0IyVXhSSm1YVGtrR25sZFdlUGJza0RvZHdVcTFB?=
 =?utf-8?B?UkE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab31b78d-0139-410a-43c6-08dd50905bb7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7608.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 02:51:50.2689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 462UfKMpKKtSyUKXYXOtGo/UTDyqtpOtY1FMJjOM5j1+XQ4MAEjuD5bZ7wlWrtPOzz4xni3QGixxwcJq3OhZiMq30echNE1qbecEEp326pM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5037
X-Proofpoint-GUID: XJvLDdHD4BRXKaksrFV_gW4PIei1ViV2
X-Authority-Analysis: v=2.4 cv=I4GfRMgg c=1 sm=1 tr=0 ts=67b54749 cx=c_pps a=v3ez6FdVe4RSF1xj2bRqRw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=bRTqI5nwn0kA:10
 a=iGHA9ds3AAAA:8 a=pGLkceISAAAA:8 a=NEAV23lmAAAA:8 a=3g80flMcAAAA:8 a=jPeWQ6RjAAAA:8 a=t7CeM3EgAAAA:8 a=fFlJ8XlAAAAA:8 a=6tzEbtHSsBM5ipSGEoUA:9 a=BhMdqm2Wqc4Q2JL7t0yJfBCtM/Y=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=BUsmWSGLi5UA:10 a=ouV8bqFNGZoA:10
 a=nM-MV4yxpKKO9kiQg6Ot:22 a=3urWGuTZa-U-TZ_dHwj2:22 a=jPTqSWBWhtiCoVT8egAu:22 a=FdTzh2GWekK77mhwV6Dw:22 a=QvtRIehXiRMHk9VhY7Vo:22 a=hjSkjS1EZ2qA4F1bJaUS:22 a=NWVoK91CQySWRX1oVYDe:22 a=lAIPu-TSoPCgWs-2gwLQ:22
X-Proofpoint-ORIG-GUID: XJvLDdHD4BRXKaksrFV_gW4PIei1ViV2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_01,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 suspectscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2502190021
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 51J1kctd026329
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Feb 2025 02:52:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1092

On 2/14/25 15:25, Martin Jansa via lists.yoctoproject.org wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender =
and know the content is safe.
>
> Not sure what happened, but it does apply fine from patchwork (and
> doesn't even mangle my e-mail address with Martin Jansa via
> lists.yoctoproject.org
> <martin.jansa=3Dgmail.com@lists.yoctoproject.org>), see:
>
> HEAD is now at 3d7625d MAINTAINERS.md: fix e-mail address
> martin@jama /OE/layers/meta-tensorflow $ wget
> https://patchwork.yoctoproject.org/project/yocto/patch/20250211161500.3=
077588-1-martin.jansa@gmail.com/mbox/
> -O - | git am
> --2025-02-14 08:20:15--
> https://patchwork.yoctoproject.org/project/yocto/patch/20250211161500.3=
077588-1-martin.jansa@gmail.com/mbox/
> Resolving patchwork.yoctoproject.org... 34.211.161.74, 54.71.59.185,
> 54.191.94.169
> Connecting to patchwork.yoctoproject.org|34.211.161.74|:443... connecte=
d.
> HTTP request sent, awaiting response... 200 OK
> Length: 13812 (13K) [text/plain]
> Saving to: =E2=80=98STDOUT=E2=80=99
>
> -
> 100%[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>]
>   13.49K  --.-KB/s    in 0s
>
> 2025-02-14 08:20:16 (1.94 GB/s) - written to stdout [13812/13812]
>
> Applying: tensorflow: drop Upstream-Status inside third_party .patch fi=
les
> martin@jama /OE/layers/meta-tensorflow $ git show -1 --pretty=3Dfuller =
| head
> commit f26bbd26fc161ebd5a8028348dc612cdd8b0d528
> Author:     Martin Jansa <martin.jansa@gmail.com>
> AuthorDate: Tue Feb 11 17:14:57 2025 +0100
> Commit:     Martin Jansa <martin.jansa@gmail.com>
> CommitDate: Fri Feb 14 08:20:16 2025 +0100
>
>      tensorflow: drop Upstream-Status inside third_party .patch files
>
>      * these patches create:
>        third_party/0001-XNNPACK-support-32-bit-x86.patch
>
> meta-tensorflow $ git show -1 --pretty=3Dfuller g/mickledore | head
> commit 3d7625d7ab0b98859519f9b0ba056b989b7e2a48
> Author:     Martin Jansa via lists.yoctoproject.org
> <martin.jansa=3Dgmail.com@lists.yoctoproject.org>
> AuthorDate: Thu Feb 6 15:29:20 2025 +0100
> Commit:     Hongxu Jia <hongxu.jia@windriver.com>
> CommitDate: Fri Feb 7 10:57:19 2025 +0800
>
>      MAINTAINERS.md: fix e-mail address
>
>      CAUTION: This email comes from a non Wind River email account!
>      Do not click links or open attachments unless you recognize the
> sender and know the content is safe.
>
> Maybe you were fetching/creating "'[yocto-patches]
> [meta-tensorflow][mickledore][PATCH 1_3]tensorflow: drop
> Upstream-Status inside third_party .patch f... -" somewhere else than
> patchwork?
>
> The same changes are also applied in:
> https://github.com/shr-project/meta-tensorflow
> if cherry-picking from there is easier for you.

Done, cherry pick and apply them on master,mickledore,kirkstone and=20
scarthgap branch respectively

//Hongxu


> Regards,
>
> On Fri, Feb 14, 2025 at 4:20=E2=80=AFAM Hongxu Jia <hongxu.jia@windrive=
r.com> wrote:
>> Hi Martin,
>>
>> Apply the patch on mickledore failed
>>
>> $ git branch
>>     hardknott
>>     kirkstone
>>     master
>> * mickledore
>>     thud
>>
>> $ git log
>> commit 3d7625d7ab0b98859519f9b0ba056b989b7e2a48 (HEAD -> mickledore,
>> origin/mickledore)
>> Author: Martin Jansa via lists.yoctoproject.org
>> <martin.jansa=3Dgmail.com@lists.yoctoproject.org>
>> Date:   Thu Feb 6 15:29:20 2025 +0100
>>
>>       MAINTAINERS.md: fix e-mail address
>>
>>       CAUTION: This email comes from a non Wind River email account!
>>       Do not click links or open attachments unless you recognize the
>> sender and know the content is safe.
>>
>>       yocto@yoctoproject.org doesn't exist and yocto-patches is probab=
ly
>> better than
>>       yocto@lists.yoctoproject.org
>>
>>       Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
>>
>> $ git am '[yocto-patches] [meta-tensorflow][mickledore][PATCH 1_3]
>> tensorflow: drop Upstream-Status inside third_party .patch f... -
>> "Martin Jansa via lists.yoctoproj
>> ect.org" <martin.jansa=3Dgmail.com@lists.yoctoproject.org> - 2025-02-1=
2
>> 0014.eml'
>> Applying: tensorflow: drop Upstream-Status inside third_party .patch f=
iles
>> error: patch failed:
>> recipes-framework/tensorflow/files/0001-fix-XNNPACK-build-failure-for-=
qemuarm.patch:28
>> error:
>> recipes-framework/tensorflow/files/0001-fix-XNNPACK-build-failure-for-=
qemuarm.patch:
>> patch does not apply
>> Patch failed at 0001 tensorflow: drop Upstream-Status inside third_par=
ty
>> .patch files
>> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
>> When you have resolved this problem, run "git am --continue".
>> If you prefer to skip this patch, run "git am --skip" instead.
>> To restore the original branch and stop patching, run "git am --abort".
>>
>> //Hongxu
>> On 2/12/25 00:14, Martin Jansa via lists.yoctoproject.org wrote:
>>> CAUTION: This email comes from a non Wind River email account!
>>> Do not click links or open attachments unless you recognize the sende=
r and know the content is safe.
>>>
>>> * these patches create:
>>>     third_party/0001-XNNPACK-support-32-bit-x86.patch
>>>     third_party/0001-cpuinfo-support-32-bit-x86.patch
>>>     third_party/0001-hardcode-go-SDKS.patch
>>>     third_party/eigen3/0001-workaround-ice-failure-while-building-fro=
m-source-wi.patch
>>>
>>>     which aren't applied by do_patch bitbake task but by bazel:
>>>
>>>     tensorflow $ grep patch_file tensorflow/workspace2.bzl | head -n =
2
>>>     tensorflow/workspace2.bzl: patch_file =3D ["//third_party:0001-XN=
NPACK-support-32-bit-x86.patch"],
>>>     tensorflow/workspace2.bzl: patch_file =3D ["//third_party:0001-cp=
uinfo-support-32-bit-x86.patch"],
>>>     tensorflow/workspace2.bzl: patch_file =3D ["//third_party:0001-ha=
rdcode-go-SDKS.patch"],
>>>     third_party/eigen3/workspace.bzl: patch_file =3D ["//third_party/=
eigen3:0001-workaround-ice-failure-while-building-from-source-wi.patch"],
>>>
>>>     so they don't really need Upstream-Status and including it there
>>>     might cause false possitive e.g. in
>>>     0001-fix-XNNPACK-build-failure-for-qemuarm.patch
>>>
>>>     ERROR: tensorflow-lite-2.10.0-r0 do_patch: QA Issue: Malformed Up=
stream-Status in patch
>>>     recipes-framework/tensorflow/tensorflow-lite/0001-fix-XNNPACK-bui=
ld-failure-for-qemuarm.patch
>>>     Please correct according to https://docs.yoctoproject.org/contrib=
utor-guide/recipe-style-guide.html#patch-upstream-status :
>>>      Upstream-Status: Inappropriate [oe specific] [patch-status]
>>>     ERROR: tensorflow-lite-2.10.0-r0 do_patch: Fatal QA errors were f=
ound, failing task.
>>>
>>>     caused by extra space before Upstream-Status
>>>
>>>     Maybe we should drop 0001-fix-XNNPACK-build-failure-for-qemuarm.p=
atch completely
>>>     as it was already dropped from tensorflow in:
>>>     https://git.yoctoproject.org/meta-tensorflow/commit/?h=3Dmickledo=
re&id=3Dbaae9cd6d92f69aa16b874958a332e1d3a362fea
>>>     and from tensorflow-lite in scarthgap branch:
>>>     https://git.yoctoproject.org/meta-tensorflow/commit/?h=3Dscarthga=
p&id=3D29509c97e9009ed0ae99ce6c2554e463575dc10c
>>>
>>>     and is now used only for tensorflow-lite, refresh it to apply
>>>
>>>     It was originally introduced for both in:
>>>     https://git.yoctoproject.org/meta-tensorflow/commit/?h=3Dmickledo=
re&id=3De0efac349f2aac3d65ccbeee20475dbb1ea3dd19
>>>     and refreshed in:
>>>     https://git.yoctoproject.org/meta-tensorflow/commit/?h=3Dmickledo=
re&id=3D30fbec74ea37b646473b08d0ee8d3992ccd56245
>>>
>>> Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
>>> ---
>>>    .../tensorflow/files/0001-hardcode-go-SDKS.patch    |  4 +---
>>>    .../0001-support-32-bit-x64-and-arm-for-yocto.patch |  7 ++-----
>>>    ...y-eigen_archive-workaround-ice-failure-whi.patch |  4 +---
>>>    ...019-fix-XNNPACK-build-failure-for-qemuarm.patch} | 13 ++++-----=
----
>>>    .../tensorflow/tensorflow-lite_2.12.0.bb            |  2 +-
>>>    5 files changed, 9 insertions(+), 21 deletions(-)
>>>    rename recipes-framework/tensorflow/files/{0001-fix-XNNPACK-build-=
failure-for-qemuarm.patch =3D> 0019-fix-XNNPACK-build-failure-for-qemuarm=
.patch} (97%)
>>>
>>> diff --git a/recipes-framework/tensorflow/files/0001-hardcode-go-SDKS=
.patch b/recipes-framework/tensorflow/files/0001-hardcode-go-SDKS.patch
>>> index b705ec7..e365c27 100644
>>> --- a/recipes-framework/tensorflow/files/0001-hardcode-go-SDKS.patch
>>> +++ b/recipes-framework/tensorflow/files/0001-hardcode-go-SDKS.patch
>>> @@ -38,7 +38,7 @@ new file mode 100644
>>>    index 00000000000..b51d7262f4c
>>>    --- /dev/null
>>>    +++ b/third_party/0001-hardcode-go-SDKS.patch
>>> -@@ -0,0 +1,49 @@
>>> +@@ -0,0 +1,47 @@
>>>    +From 34242e73f76eff09ee33152c58c3be650331b7ff Mon Sep 17 00:00:00=
 2001
>>>    +From: Hongxu Jia <hongxu.jia@eng.windriver.com>
>>>    +Date: Thu, 1 Dec 2022 15:07:10 +0000
>>> @@ -53,8 +53,6 @@ index 00000000000..b51d7262f4c
>>>    +downloaded archive, so hardcode go SDKS list files rather than
>>>    +fetch from internet
>>>    +
>>> -+Upstream-Status: Inappropriate [Yocto specific]
>>> -+
>>>    +Signed-off-by: Hongxu Jia <hongxu.jia@eng.windriver.com>
>>>    +---
>>>    + go/private/sdk.bzl | 7 +++++++
>>> diff --git a/recipes-framework/tensorflow/files/0001-support-32-bit-x=
64-and-arm-for-yocto.patch b/recipes-framework/tensorflow/files/0001-supp=
ort-32-bit-x64-and-arm-for-yocto.patch
>>> index a855b30..22bd6c1 100644
>>> --- a/recipes-framework/tensorflow/files/0001-support-32-bit-x64-and-=
arm-for-yocto.patch
>>> +++ b/recipes-framework/tensorflow/files/0001-support-32-bit-x64-and-=
arm-for-yocto.patch
>>> @@ -56,7 +56,7 @@ new file mode 100644
>>>    index 00000000000..2141c37236b
>>>    --- /dev/null
>>>    +++ b/third_party/0001-XNNPACK-support-32-bit-x86.patch
>>> -@@ -0,0 +1,29 @@
>>> +@@ -0,0 +1,27 @@
>>>    +From 2345756776fa09fd95e29f96f781e15e3b18a61b Mon Sep 17 00:00:00=
 2001
>>>    +From: Hongxu Jia <hongxu.jia@windriver.com>
>>>    +Date: Tue, 17 Aug 2021 01:09:53 -0700
>>> @@ -64,8 +64,6 @@ index 00000000000..2141c37236b
>>>    +
>>>    +Use android_x86 as a workaround to support 32 bit x86
>>>    +
>>> -+Upstream-Status: Inappropriate [oe specific]
>>> -+
>>>    +Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
>>>    +---
>>>    + BUILD.bazel | 1 -
>>> @@ -91,7 +89,7 @@ new file mode 100644
>>>    index 00000000000..0c83cf01675
>>>    --- /dev/null
>>>    +++ b/third_party/0001-cpuinfo-support-32-bit-x86.patch
>>> -@@ -0,0 +1,28 @@
>>> +@@ -0,0 +1,27 @@
>>>    +From f5e52b2db5516954dab9026e4f386982c4c3c3a4 Mon Sep 17 00:00:00=
 2001
>>>    +From: Hongxu Jia <hongxu.jia@windriver.com>
>>>    +Date: Mon, 19 Sep 2022 00:10:18 -0700
>>> @@ -99,7 +97,6 @@ index 00000000000..0c83cf01675
>>>    +
>>>    +Use android_x86 as a workaround to support 32 bit x86
>>>    +
>>> -+Upstream-Status: Inappropriate [oe specific]
>>>    +Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
>>>    +---
>>>    + BUILD.bazel | 1 -
>>> diff --git a/recipes-framework/tensorflow/files/0001-third_party-eige=
n_archive-workaround-ice-failure-whi.patch b/recipes-framework/tensorflow=
/files/0001-third_party-eigen_archive-workaround-ice-failure-whi.patch
>>> index b1571ab..2056c20 100644
>>> --- a/recipes-framework/tensorflow/files/0001-third_party-eigen_archi=
ve-workaround-ice-failure-whi.patch
>>> +++ b/recipes-framework/tensorflow/files/0001-third_party-eigen_archi=
ve-workaround-ice-failure-whi.patch
>>> @@ -24,7 +24,7 @@ new file mode 100644
>>>    index 00000000000..436f35fca13
>>>    --- /dev/null
>>>    +++ b/third_party/eigen3/0001-workaround-ice-failure-while-buildin=
g-from-source-wi.patch
>>> -@@ -0,0 +1,69 @@
>>> +@@ -0,0 +1,67 @@
>>>    +From 035fd96026e18d61c19da038ab2b0f7a61e97799 Mon Sep 17 00:00:00=
 2001
>>>    +From: Hongxu Jia <hongxu.jia@windriver.com>
>>>    +Date: Mon, 19 Sep 2022 01:08:18 -0700
>>> @@ -37,8 +37,6 @@ index 00000000000..436f35fca13
>>>    +But we could not patch on native gcc,so try to workaround,
>>>    +Refer: https://github.com/tensorflow/tensorflow/issues/25323
>>>    +
>>> -+Upstream-Status: Inappropriate [wr-installer specific]
>>> -+
>>>    +Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
>>>    +---
>>>    + unsupported/Eigen/CXX11/src/Tensor/TensorImagePatch.h | 3 ++-
>>> diff --git a/recipes-framework/tensorflow/files/0001-fix-XNNPACK-buil=
d-failure-for-qemuarm.patch b/recipes-framework/tensorflow/files/0019-fix=
-XNNPACK-build-failure-for-qemuarm.patch
>>> similarity index 97%
>>> rename from recipes-framework/tensorflow/files/0001-fix-XNNPACK-build=
-failure-for-qemuarm.patch
>>> rename to recipes-framework/tensorflow/files/0019-fix-XNNPACK-build-f=
ailure-for-qemuarm.patch
>>> index dea74d9..1a792ee 100644
>>> --- a/recipes-framework/tensorflow/files/0001-fix-XNNPACK-build-failu=
re-for-qemuarm.patch
>>> +++ b/recipes-framework/tensorflow/files/0019-fix-XNNPACK-build-failu=
re-for-qemuarm.patch
>>> @@ -1,4 +1,4 @@
>>> -From c15caa4d5f133307a23114c41a9c497e5ec9da2c Mon Sep 17 00:00:00 20=
01
>>> +From 2ace7a16a8033169b7ddb71a79956416644ffa3e Mon Sep 17 00:00:00 20=
01
>>>    From: Hongxu Jia <hongxu.jia@windriver.com>
>>>    Date: Thu, 23 Mar 2023 10:28:04 +0800
>>>    Subject: [PATCH] fix XNNPACK build failure for qemuarm
>>> @@ -13,10 +13,10 @@ Signed-off-by: Hongxu Jia <hongxu.jia@windriver.c=
om>
>>>     1 file changed, 209 insertions(+), 7 deletions(-)
>>>
>>>    diff --git a/third_party/0001-XNNPACK-support-32-bit-x86.patch b/t=
hird_party/0001-XNNPACK-support-32-bit-x86.patch
>>> -index 2141c37236b..ca6a38545b1 100644
>>> +index e2c053e6f8c..89ba615a9fe 100644
>>>    --- a/third_party/0001-XNNPACK-support-32-bit-x86.patch
>>>    +++ b/third_party/0001-XNNPACK-support-32-bit-x86.patch
>>> -@@ -1,22 +1,36 @@
>>> +@@ -1,20 +1,34 @@
>>>    -From 2345756776fa09fd95e29f96f781e15e3b18a61b Mon Sep 17 00:00:00=
 2001
>>>    +From 5ba6883121e91a334cc97ee98eea6ef0afb7a314 Mon Sep 17 00:00:00=
 2001
>>>     From: Hongxu Jia <hongxu.jia@windriver.com>
>>> @@ -28,8 +28,6 @@ index 2141c37236b..ca6a38545b1 100644
>>>
>>>    +Does not support 32 bit ARM with Neon DotProduct
>>>    +
>>> - Upstream-Status: Inappropriate [oe specific]
>>> -
>>>     Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
>>>     ---
>>>    - BUILD.bazel | 1 -
>>> @@ -59,7 +57,7 @@ index 2141c37236b..ca6a38545b1 100644
>>>      config_setting(
>>>          name =3D "android_x86",
>>>          values =3D {
>>> -@@ -24,6 +38,194 @@ index 27ab07c9..f223d2ab 100644
>>> +@@ -22,6 +36,194 @@ index 27ab07c9..f223d2ab 100644
>>>              "cpu": "x86",
>>>          },
>>>      )
>>> @@ -255,6 +253,3 @@ index 2141c37236b..ca6a38545b1 100644
>>>    -2.30.2
>>>    +2.27.0
>>>
>>> ---
>>> -2.27.0
>>> -
>>> diff --git a/recipes-framework/tensorflow/tensorflow-lite_2.12.0.bb b=
/recipes-framework/tensorflow/tensorflow-lite_2.12.0.bb
>>> index 83fd12d..e76a09b 100644
>>> --- a/recipes-framework/tensorflow/tensorflow-lite_2.12.0.bb
>>> +++ b/recipes-framework/tensorflow/tensorflow-lite_2.12.0.bb
>>> @@ -15,7 +15,7 @@ SRC_URI +=3D " \
>>>               file://yocto_compiler_configure.bzl \
>>>              "
>>>    SRC_URI:append:arm =3D " \
>>> -           file://0001-fix-XNNPACK-build-failure-for-qemuarm.patch \
>>> +    file://0019-fix-XNNPACK-build-failure-for-qemuarm.patch \
>>>    "
>>>
>>>    SRC_URI +=3D "https://storage.googleapis.com/download.tensorflow.o=
rg/models/inception_v3_2016_08_28_frozen.pb.tar.gz;name=3Dmodel-inv3"
>>> --
>>> 2.48.1
>>>
>>>
>>>
>>>
>>>
>>>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1084): https://lists.yoctoproject.org/g/yocto-patch=
es/message/1084
> Mute This Topic: https://lists.yoctoproject.org/mt/111125079/3617049
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13176=
071/3617049/43253763/xyzzy [hongxu.jia@eng.windriver.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>


