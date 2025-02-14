Return-Path: <hongxu.jia@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F59CC021A0
	for <webhook@archiver.kernel.org>; Fri, 14 Feb 2025 03:20:36 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.12518.1739503230839464457
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Feb 2025 19:20:30 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=4140ca8725=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E2lLdd002586;
	Thu, 13 Feb 2025 19:20:29 -0800
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 44qwy6ktyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 19:20:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+0kCcX3sfznVykpyYUvDRP/kZHpaPo7cbcB81IlRaJA2zm6qB7jnd1MNLUtJ0/94Hqy0xg3wPslPrl6sKw71iNv0xpKSjsWJsLksHKAtwRtI7XsoFPR0mgu3iRlKzznuP320And8T/YebJYyax9/GRw3Cudy1bfz4ruUbeyYw03vz4/cTngxrWkV4EzwybiabKt8ClMga0a0PQipG2iW3XIiKG+nzhnDqNqLU70gNBQite0E6ddCH2BOboHVGtNZKa/QCslJsyuTmCl/+1a9csuEq7bdJJSFhyWE8866tHCPUTLUth3YfCHw6MWuja4eJEprBO77kv82mKaj4NuRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J11HsorBnrpHO6IbaBmiY1RT2oxLE3eEXwN3RHtgvNw=;
 b=bMninZJiDgM55ORPtNrMgbio2j3WBIlvyMVNFpN6OUeNVXxkf5xyTLt3ZYSvIV90IfKFOltvKfgo4xYPUEhdM0f6muhqFExoDz0HuCcS/CmtDuzPgMpMS9bMDM7MEYztHXLsHdsTv0I/5o29L/J14eiA/wevFQC7NA+WeYxhYg+8YcQgjOvp3RlZciWMl3YzItdl8Ad/iosjiBPgo4yswIxQqtY5Ukkp8G3RcvhxkPAd3p7Xw5kKBOFYwTNyf59BU9gq19AHD9qfSonTekDWNozPmTs/ie0YS0wZm9OW/xKM957Tf+L2gK7Y86U3EZUlDtImeWcTfMoGFIs8VHd7XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20)
 by PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 03:20:26 +0000
Received: from PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::ef64:bc9f:eb8c:e6e]) by PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::ef64:bc9f:eb8c:e6e%6]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 03:20:26 +0000
Message-ID: <d77e1e97-ded6-44bd-8d80-fd855b738b10@windriver.com>
Date: Fri, 14 Feb 2025 11:20:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-tensorflow][mickledore][PATCH 1/3]
 tensorflow: drop Upstream-Status inside third_party .patch files
To: yocto-patches@lists.yoctoproject.org
Cc: Martin Jansa <martin.jansa@gmail.com>
References: <20250211161500.3077588-1-martin.jansa@gmail.com>
Content-Language: en-US
From: Hongxu Jia <hongxu.jia@windriver.com>
In-Reply-To: <20250211161500.3077588-1-martin.jansa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: TYCP286CA0303.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::11) To PH7PR11MB7608.namprd11.prod.outlook.com
 (2603:10b6:510:269::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7608:EE_|PH7PR11MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: 37db998d-c985-402d-da11-08dd4ca6868c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|4022899009|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QnEwZEJXWGI4N1RlTW5ZY3BzOHZMdkNIUkRSYndiMmV1M2tTeDlEaWpVRGNa?=
 =?utf-8?B?bUZBcEw3cEVQb2xkM1VXZGUxZE05Zy9lNVFOMjNKRGJzNkJveGc3K2VsaXQy?=
 =?utf-8?B?aUdCZ2FVa1ZzVzZvSWdSRGhUN1IyK0o5Y0t1UDAvbFZaZzlnMmdZV1RwSEw1?=
 =?utf-8?B?TkJRRExmN2hMcG5oaGMwWjc5K2EweE5kQldlSkFGYWJZYnZxSVRlUGhRMjBz?=
 =?utf-8?B?VEh2Y3Q0OHdVSUtYZVFQMHBiTGppZlgzMkVBdDFOaXRiOUZ6bU11M1dKZ3c4?=
 =?utf-8?B?b2x3dmlLYU5aWnVrOHBjazFWbCtvWHFiNEF3UXJRQi9pSFhVMi9GS25HQzgr?=
 =?utf-8?B?V3Bhd2lEcllRR04yeDR2V1N5SUh1a1hCQkRWeXh1YVpPeWhTSVN6dVBnSDNP?=
 =?utf-8?B?bWhNSUUxU1gzNlFJTk1oUTl4cFg1eXg3QWVLaXg5ZlVQK2NnUmNLTktEcm9B?=
 =?utf-8?B?VFFuR1c0cFVJM0xTeUNYQS9jT3N3RWx1TS9LdzAyZ25jMXNLMVB0QzdmclB2?=
 =?utf-8?B?MlVoYkN3RjM1eTFNMENVYzBqa2V2T3FSOTBMU0VTMU9FQldyMEIydUt4YmR0?=
 =?utf-8?B?eGdGWnArSGNQSDEvTEQrQlN1VEY3eDlYNnQvVjFHT1M3c1NucktsTGgzbTBq?=
 =?utf-8?B?Qi8zUjJ5d2hKUk9CMDBIYlNBWUg1TEZYM2dzMmF3WVN0L3lzblhicFhUV09s?=
 =?utf-8?B?N2UvS3FRb0FJZ3NhV2NRN3hBSG9GSEhCdVVYMG9zbmlpN2d6RDZGZFM0MmYr?=
 =?utf-8?B?NzN6R1NwbXlPOFhoMWVZU2FRVTBwdEtzSjdkLzNoa0g0M0UrTG03dldETnRB?=
 =?utf-8?B?NW1xbitqUzBBdXRwcng4N2RKcXpUeUdOc0VPKzQ5MVNiY3VPZUdoZk01REhq?=
 =?utf-8?B?ZlJKY212N0xrdmdFOEhBVHZqZjAxd3hxRFp0bFh1UHI2UTdyejgxOWRram5n?=
 =?utf-8?B?QS8rcGVPaWUxR0Y3NkFSVWY2S2pIaUtxNVAwRmdVekNnZVFmSFhxUnA1d3hQ?=
 =?utf-8?B?QUlwRWVuNXo4R0ppRE5iQ2RmdW5kMGZmdFlxR2p0RDVjVjVyeVN2TDAvQkRP?=
 =?utf-8?B?Sk9FVll2ZXhnMmNmZS9jZlp4L3JpaENPTVI0TTliTjc0RDQ1eC9zUUNKTjRh?=
 =?utf-8?B?SnpyZ1dtREtVZm5rd25RQlZ2dnRudUtaYm0zZGxUeHBBQnJ4U05MSTFWa3NE?=
 =?utf-8?B?aldLdFM4NmRmL3lXdmtjSWFVM3lISTMvZ2FPekhMS0xYaVVTd28zbVpQMENu?=
 =?utf-8?B?RVF2Z0xjQTd6QjQzdThmTStOWVZJWjI4T0hDenIwem53NkljWnVUbXhPcEVr?=
 =?utf-8?B?eDRnYUF0d1ppSjdsQk5tZ3RWelhMOXZ0QlVFR2Q3UXhMNzVBeWhFRm9QSTZt?=
 =?utf-8?B?d3h3K2NNUmgwZ09qR2FteVVXeWQ5L2RxYnlndVh3VWhPZ2hMRlVVUXdSNXlO?=
 =?utf-8?B?VzNBRHhXNUd5UzlFVGtzMTFHcVdmb29YckxNYURBdGNaVjdqVDdYeEpFZGZl?=
 =?utf-8?B?REpJVUg5czBjZEhCRXlZS1U3NUc4RlZicmlYM3RGMDV0d2JWMklTUlZSUDB2?=
 =?utf-8?B?c1R1NEE2cnNISS9MaFhDd2tNamF2U0E2cGZ6QnA2UlVjemU4ck13OG5DbjhS?=
 =?utf-8?B?OFRaVVFycXZKS3F2M1JsV3V3clI0U0tKUFFmRmN4QUlPeWZ3d1d3d1pCWXJ4?=
 =?utf-8?B?c3Rya2tGUXpSbXJzTTVtcnk1QnpQYm5BY0Jaem44c081UEM3RFFRRk9oelZn?=
 =?utf-8?B?V2F6c0dMSGVrOHFDM1J5a2hPVjNOVFdBcTBtbTRaS284NS9uOUNnVWxGQzQ1?=
 =?utf-8?B?VnZVOW0yZWRFTnQ4SW5tQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7608.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(4022899009)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cmdwK0hTSkxvK05OcmFTRUsyN3dQeTJkUEZla09lSXYrUUdISnZrZEZ2QzVr?=
 =?utf-8?B?cEYxOUVJRmNCQlluc0dZS3Q5UzhrTkNtM3RhWXNDSTRCWkhiUCt5RStEdWZy?=
 =?utf-8?B?Si9qamlHb2ZsSHlUaWh4OVYxUlhJUGxYSEI3a0gvR00yWlBiWmFjeStwOVdU?=
 =?utf-8?B?QkhlNWZFUjFWclhwZE9xMEI2dGVwaFg4NTJxQmw0RFJORDRIK1J6d1VJRmNB?=
 =?utf-8?B?YzRMemlXSWgvVVZ4MEFUbk9uZDRjVmVmcmZYSVFVT3RhcGdqVURiYVdpOGZL?=
 =?utf-8?B?MG9POXcwQmpycmwzOEtYRjJVekhlV2ErTnlIb0FxUmdMUE5SRUthWVU5TDdl?=
 =?utf-8?B?NXhKbEh4U0doNEFBZFNSZnNrWk9Kb2grS2VyQzB5T1NNTFhEWTFOdmliSXM2?=
 =?utf-8?B?eEpDUEpCQ0xoRjVGc3ZGakNBOW9WRXVtbHdkQk52TWcxbVZYYXlNS2RlSklL?=
 =?utf-8?B?aXdteExQNXNaZjlpdThWMW5aL1pCSTRyQUVsN0s0RXJNc0JYS3RHMEp0RFVC?=
 =?utf-8?B?dm1uSmFMRitpTjc0dzJmTDc0c3RXWXZqYyswZERJU0U3WnJ6WnlRUzQ5QVdi?=
 =?utf-8?B?YW9hVldPNWxUVjBTZUVPYmVQc2JTRVVSQUtlSVk4UnZJazFVZVo3bXl5VUls?=
 =?utf-8?B?dnJadXhjK3orMkZWZFZkVmxNbTVMbmdmVVlwL0xyT1pEb1p2ZmpZOUoydExj?=
 =?utf-8?B?UG90b3NkaXdVTXE5N09ha3F1ZEpFWFNYdWh6V1VXbzVuTDRMNHp6QWRkRjJl?=
 =?utf-8?B?WlZRR3lQWEptWEZsRnJCY1pVNWsrRGczQTV5VnFiNERESjFwK0V4NlBqMWEy?=
 =?utf-8?B?dzRjaTVORjQxY3poL2s1MVhLVVdUdS92SWZVMHRLa2RmZTkxdHdmdVd1SlMr?=
 =?utf-8?B?bTNhY0FjVXVPNDMyM2NRaEJmZldIWG9XSzdhTUJVZnhVNTRuYUEwNjFMSmp4?=
 =?utf-8?B?R1lDL0NJSCtKcXpzMW9SWVBDRHh1TlVMRk1NSlpSNVRQc2Foby9qV1VwWEl1?=
 =?utf-8?B?V0hKVlNvZ1kzdGFUMmtqSHE2S3ppSUI1WG9Zc0hPR0RTNE5yRVNCUzBMZjlF?=
 =?utf-8?B?cGlaUi93RENYc0dBSm0zZ01MSWFzR2ptQW9NczNwSHpSRU51dE5iWk5qblVD?=
 =?utf-8?B?VlJ1TkRUWUExOFMrMkNaZ21MR0k1RWRDWHdiWlc5ZVBzUUd0Z2l1RWNWMHVl?=
 =?utf-8?B?dHdmbUxqSGtXYXFjZW5oeXBCSDRMNHl1YVhBeVA3VnZQcXlEeHM0MWt6T0F5?=
 =?utf-8?B?MS9TZy9COG54Um41enpXNG5JZ2FEdVV6S05PM0lxdExXelB0UE5yNHYwc1pl?=
 =?utf-8?B?Sy9KWmE5UVRVWWJGZk1vYXVPS1NPd1pOajQxYnFUL2hCYXIxeWcxZDFsK0xC?=
 =?utf-8?B?NkFuS1k3akcwdVBVekZ5YWR5bHRvaU5DdnJwWFBUVVpoSVd3UTJQSGJpSDdO?=
 =?utf-8?B?dW9iVk5ZS1prTFZCZU1jazA3ZTFzMGMvT00rckRnYUlaMkRLTHdpU3dJMFpq?=
 =?utf-8?B?L2tpejRqWHU3SVArc25keno3VjJUdndsa0xKbUppYXQ4ZllodURHVHBNQllt?=
 =?utf-8?B?SGI1ZmFLdWpXZC9qVEVjSWRkOGY4OXRnZFJDR2RTZmMyWGlCMnNxZkt3Zy9p?=
 =?utf-8?B?U21vcjlFcjVIWDIvR0cxMkQ5M3hSYmhjMmUvZ21vZWVOZUpUUUp1SEJrbnZv?=
 =?utf-8?B?K2ErRERlR21xTnZCd0NtTm0xQlcxa0hHMFQ3UVl3TXc4b3dtUHQ1U1hJQlNa?=
 =?utf-8?B?MDgzYlRScFBFU0hrTGlxTzBIeWpiOVdqVUVQeFlyTW5kUHlqZkZDT2VOUWNS?=
 =?utf-8?B?b0d4WGVESGRRM1hSRHAwTXJwdGpLZmEzRWZSeGZFUkl3V2Z2c1RNR09nWVFG?=
 =?utf-8?B?THJqMFkwZmxDZVNNNGRkYVRHcTlBMlRqbndFb0dTbEdIMEhiUHZZN09XTlF4?=
 =?utf-8?B?SlMxNk9sN3dnU2VCdURnamhQNjcxZEt0SVdONWg2cktwOXptSFByeWVINHh2?=
 =?utf-8?B?WEpvMDYvVWlDRmVTZzVsMWhUdytGSGFLalVTTVVPQ2owOFhTek9VZzlQdHoy?=
 =?utf-8?B?Nmg0UXNTWDduSjBvcDBHQmR1QVQzZHpxSnA3SEZnWlBuRHhWVnJrY3I5N1Mv?=
 =?utf-8?B?R2FkZDhkQTRDdFErbHYvT09aWGdHK3FzTE9GZmIwbG01cEFRanc2VkFaVkFV?=
 =?utf-8?B?Y1E9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37db998d-c985-402d-da11-08dd4ca6868c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7608.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 03:20:26.4261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVXrmt31DeCZYmINV2PFy2SBYJtgQIjAOIffSSsSHwzKtG3wUVb6OT8/mYWhtwbN2p7+uCGhjnU8SKltI+HXi/aYwur8HIT0rRJrcRIOgM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7499
X-Proofpoint-GUID: gll-EewFza3SXfuq9SdeVf7QbmFEm_kN
X-Proofpoint-ORIG-GUID: gll-EewFza3SXfuq9SdeVf7QbmFEm_kN
X-Authority-Analysis: v=2.4 cv=G8nmE8k5 c=1 sm=1 tr=0 ts=67aeb67d cx=c_pps a=zz2QubYGG/9FVtTd3zWqHQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=bRTqI5nwn0kA:10
 a=iGHA9ds3AAAA:8 a=NEAV23lmAAAA:8 a=3g80flMcAAAA:8 a=jPeWQ6RjAAAA:8 a=pGLkceISAAAA:8 a=fFlJ8XlAAAAA:8 a=t7CeM3EgAAAA:8 a=2n6VocSDZuZ6qHl8rXsA:9 a=BhMdqm2Wqc4Q2JL7t0yJfBCtM/Y=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=BUsmWSGLi5UA:10 a=ouV8bqFNGZoA:10
 a=nM-MV4yxpKKO9kiQg6Ot:22 a=3urWGuTZa-U-TZ_dHwj2:22 a=jPTqSWBWhtiCoVT8egAu:22 a=QvtRIehXiRMHk9VhY7Vo:22 a=FdTzh2GWekK77mhwV6Dw:22 a=hjSkjS1EZ2qA4F1bJaUS:22 a=NWVoK91CQySWRX1oVYDe:22 a=lAIPu-TSoPCgWs-2gwLQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_01,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 phishscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2501170000
 definitions=main-2502140023
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 51E2lLdd002586
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Feb 2025 03:20:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1083

Hi Martin,

Apply the patch on mickledore failed

$ git branch
 =C2=A0 hardknott
 =C2=A0 kirkstone
 =C2=A0 master
* mickledore
 =C2=A0 thud

$ git log
commit 3d7625d7ab0b98859519f9b0ba056b989b7e2a48 (HEAD -> mickledore,=20
origin/mickledore)
Author: Martin Jansa via lists.yoctoproject.org=20
<martin.jansa=3Dgmail.com@lists.yoctoproject.org>
Date:=C2=A0=C2=A0 Thu Feb 6 15:29:20 2025 +0100

 =C2=A0=C2=A0=C2=A0 MAINTAINERS.md: fix e-mail address

 =C2=A0=C2=A0=C2=A0 CAUTION: This email comes from a non Wind River email=
 account!
 =C2=A0=C2=A0=C2=A0 Do not click links or open attachments unless you rec=
ognize the=20
sender and know the content is safe.

 =C2=A0=C2=A0=C2=A0 yocto@yoctoproject.org doesn't exist and yocto-patche=
s is probably=20
better than
 =C2=A0=C2=A0=C2=A0 yocto@lists.yoctoproject.org

 =C2=A0=C2=A0=C2=A0 Signed-off-by: Martin Jansa <martin.jansa@gmail.com>

$ git am '[yocto-patches] [meta-tensorflow][mickledore][PATCH 1_3]=20
tensorflow: drop Upstream-Status inside third_party .patch f... -=20
"Martin Jansa via lists.yoctoproj
ect.org" <martin.jansa=3Dgmail.com@lists.yoctoproject.org> - 2025-02-12=20
0014.eml'
Applying: tensorflow: drop Upstream-Status inside third_party .patch file=
s
error: patch failed:=20
recipes-framework/tensorflow/files/0001-fix-XNNPACK-build-failure-for-qem=
uarm.patch:28
error:=20
recipes-framework/tensorflow/files/0001-fix-XNNPACK-build-failure-for-qem=
uarm.patch:=20
patch does not apply
Patch failed at 0001 tensorflow: drop Upstream-Status inside third_party=20
.patch files
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

//Hongxu
On 2/12/25 00:14, Martin Jansa via lists.yoctoproject.org wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender =
and know the content is safe.
>
> * these patches create:
>    third_party/0001-XNNPACK-support-32-bit-x86.patch
>    third_party/0001-cpuinfo-support-32-bit-x86.patch
>    third_party/0001-hardcode-go-SDKS.patch
>    third_party/eigen3/0001-workaround-ice-failure-while-building-from-s=
ource-wi.patch
>
>    which aren't applied by do_patch bitbake task but by bazel:
>
>    tensorflow $ grep patch_file tensorflow/workspace2.bzl | head -n 2
>    tensorflow/workspace2.bzl: patch_file =3D ["//third_party:0001-XNNPA=
CK-support-32-bit-x86.patch"],
>    tensorflow/workspace2.bzl: patch_file =3D ["//third_party:0001-cpuin=
fo-support-32-bit-x86.patch"],
>    tensorflow/workspace2.bzl: patch_file =3D ["//third_party:0001-hardc=
ode-go-SDKS.patch"],
>    third_party/eigen3/workspace.bzl: patch_file =3D ["//third_party/eig=
en3:0001-workaround-ice-failure-while-building-from-source-wi.patch"],
>
>    so they don't really need Upstream-Status and including it there
>    might cause false possitive e.g. in
>    0001-fix-XNNPACK-build-failure-for-qemuarm.patch
>
>    ERROR: tensorflow-lite-2.10.0-r0 do_patch: QA Issue: Malformed Upstr=
eam-Status in patch
>    recipes-framework/tensorflow/tensorflow-lite/0001-fix-XNNPACK-build-=
failure-for-qemuarm.patch
>    Please correct according to https://docs.yoctoproject.org/contributo=
r-guide/recipe-style-guide.html#patch-upstream-status :
>     Upstream-Status: Inappropriate [oe specific] [patch-status]
>    ERROR: tensorflow-lite-2.10.0-r0 do_patch: Fatal QA errors were foun=
d, failing task.
>
>    caused by extra space before Upstream-Status
>
>    Maybe we should drop 0001-fix-XNNPACK-build-failure-for-qemuarm.patc=
h completely
>    as it was already dropped from tensorflow in:
>    https://git.yoctoproject.org/meta-tensorflow/commit/?h=3Dmickledore&=
id=3Dbaae9cd6d92f69aa16b874958a332e1d3a362fea
>    and from tensorflow-lite in scarthgap branch:
>    https://git.yoctoproject.org/meta-tensorflow/commit/?h=3Dscarthgap&i=
d=3D29509c97e9009ed0ae99ce6c2554e463575dc10c
>
>    and is now used only for tensorflow-lite, refresh it to apply
>
>    It was originally introduced for both in:
>    https://git.yoctoproject.org/meta-tensorflow/commit/?h=3Dmickledore&=
id=3De0efac349f2aac3d65ccbeee20475dbb1ea3dd19
>    and refreshed in:
>    https://git.yoctoproject.org/meta-tensorflow/commit/?h=3Dmickledore&=
id=3D30fbec74ea37b646473b08d0ee8d3992ccd56245
>
> Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
> ---
>   .../tensorflow/files/0001-hardcode-go-SDKS.patch    |  4 +---
>   .../0001-support-32-bit-x64-and-arm-for-yocto.patch |  7 ++-----
>   ...y-eigen_archive-workaround-ice-failure-whi.patch |  4 +---
>   ...019-fix-XNNPACK-build-failure-for-qemuarm.patch} | 13 ++++--------=
-
>   .../tensorflow/tensorflow-lite_2.12.0.bb            |  2 +-
>   5 files changed, 9 insertions(+), 21 deletions(-)
>   rename recipes-framework/tensorflow/files/{0001-fix-XNNPACK-build-fai=
lure-for-qemuarm.patch =3D> 0019-fix-XNNPACK-build-failure-for-qemuarm.pa=
tch} (97%)
>
> diff --git a/recipes-framework/tensorflow/files/0001-hardcode-go-SDKS.p=
atch b/recipes-framework/tensorflow/files/0001-hardcode-go-SDKS.patch
> index b705ec7..e365c27 100644
> --- a/recipes-framework/tensorflow/files/0001-hardcode-go-SDKS.patch
> +++ b/recipes-framework/tensorflow/files/0001-hardcode-go-SDKS.patch
> @@ -38,7 +38,7 @@ new file mode 100644
>   index 00000000000..b51d7262f4c
>   --- /dev/null
>   +++ b/third_party/0001-hardcode-go-SDKS.patch
> -@@ -0,0 +1,49 @@
> +@@ -0,0 +1,47 @@
>   +From 34242e73f76eff09ee33152c58c3be650331b7ff Mon Sep 17 00:00:00 20=
01
>   +From: Hongxu Jia <hongxu.jia@eng.windriver.com>
>   +Date: Thu, 1 Dec 2022 15:07:10 +0000
> @@ -53,8 +53,6 @@ index 00000000000..b51d7262f4c
>   +downloaded archive, so hardcode go SDKS list files rather than
>   +fetch from internet
>   +
> -+Upstream-Status: Inappropriate [Yocto specific]
> -+
>   +Signed-off-by: Hongxu Jia <hongxu.jia@eng.windriver.com>
>   +---
>   + go/private/sdk.bzl | 7 +++++++
> diff --git a/recipes-framework/tensorflow/files/0001-support-32-bit-x64=
-and-arm-for-yocto.patch b/recipes-framework/tensorflow/files/0001-suppor=
t-32-bit-x64-and-arm-for-yocto.patch
> index a855b30..22bd6c1 100644
> --- a/recipes-framework/tensorflow/files/0001-support-32-bit-x64-and-ar=
m-for-yocto.patch
> +++ b/recipes-framework/tensorflow/files/0001-support-32-bit-x64-and-ar=
m-for-yocto.patch
> @@ -56,7 +56,7 @@ new file mode 100644
>   index 00000000000..2141c37236b
>   --- /dev/null
>   +++ b/third_party/0001-XNNPACK-support-32-bit-x86.patch
> -@@ -0,0 +1,29 @@
> +@@ -0,0 +1,27 @@
>   +From 2345756776fa09fd95e29f96f781e15e3b18a61b Mon Sep 17 00:00:00 20=
01
>   +From: Hongxu Jia <hongxu.jia@windriver.com>
>   +Date: Tue, 17 Aug 2021 01:09:53 -0700
> @@ -64,8 +64,6 @@ index 00000000000..2141c37236b
>   +
>   +Use android_x86 as a workaround to support 32 bit x86
>   +
> -+Upstream-Status: Inappropriate [oe specific]
> -+
>   +Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
>   +---
>   + BUILD.bazel | 1 -
> @@ -91,7 +89,7 @@ new file mode 100644
>   index 00000000000..0c83cf01675
>   --- /dev/null
>   +++ b/third_party/0001-cpuinfo-support-32-bit-x86.patch
> -@@ -0,0 +1,28 @@
> +@@ -0,0 +1,27 @@
>   +From f5e52b2db5516954dab9026e4f386982c4c3c3a4 Mon Sep 17 00:00:00 20=
01
>   +From: Hongxu Jia <hongxu.jia@windriver.com>
>   +Date: Mon, 19 Sep 2022 00:10:18 -0700
> @@ -99,7 +97,6 @@ index 00000000000..0c83cf01675
>   +
>   +Use android_x86 as a workaround to support 32 bit x86
>   +
> -+Upstream-Status: Inappropriate [oe specific]
>   +Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
>   +---
>   + BUILD.bazel | 1 -
> diff --git a/recipes-framework/tensorflow/files/0001-third_party-eigen_=
archive-workaround-ice-failure-whi.patch b/recipes-framework/tensorflow/f=
iles/0001-third_party-eigen_archive-workaround-ice-failure-whi.patch
> index b1571ab..2056c20 100644
> --- a/recipes-framework/tensorflow/files/0001-third_party-eigen_archive=
-workaround-ice-failure-whi.patch
> +++ b/recipes-framework/tensorflow/files/0001-third_party-eigen_archive=
-workaround-ice-failure-whi.patch
> @@ -24,7 +24,7 @@ new file mode 100644
>   index 00000000000..436f35fca13
>   --- /dev/null
>   +++ b/third_party/eigen3/0001-workaround-ice-failure-while-building-f=
rom-source-wi.patch
> -@@ -0,0 +1,69 @@
> +@@ -0,0 +1,67 @@
>   +From 035fd96026e18d61c19da038ab2b0f7a61e97799 Mon Sep 17 00:00:00 20=
01
>   +From: Hongxu Jia <hongxu.jia@windriver.com>
>   +Date: Mon, 19 Sep 2022 01:08:18 -0700
> @@ -37,8 +37,6 @@ index 00000000000..436f35fca13
>   +But we could not patch on native gcc,so try to workaround,
>   +Refer: https://github.com/tensorflow/tensorflow/issues/25323
>   +
> -+Upstream-Status: Inappropriate [wr-installer specific]
> -+
>   +Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
>   +---
>   + unsupported/Eigen/CXX11/src/Tensor/TensorImagePatch.h | 3 ++-
> diff --git a/recipes-framework/tensorflow/files/0001-fix-XNNPACK-build-=
failure-for-qemuarm.patch b/recipes-framework/tensorflow/files/0019-fix-X=
NNPACK-build-failure-for-qemuarm.patch
> similarity index 97%
> rename from recipes-framework/tensorflow/files/0001-fix-XNNPACK-build-f=
ailure-for-qemuarm.patch
> rename to recipes-framework/tensorflow/files/0019-fix-XNNPACK-build-fai=
lure-for-qemuarm.patch
> index dea74d9..1a792ee 100644
> --- a/recipes-framework/tensorflow/files/0001-fix-XNNPACK-build-failure=
-for-qemuarm.patch
> +++ b/recipes-framework/tensorflow/files/0019-fix-XNNPACK-build-failure=
-for-qemuarm.patch
> @@ -1,4 +1,4 @@
> -From c15caa4d5f133307a23114c41a9c497e5ec9da2c Mon Sep 17 00:00:00 2001
> +From 2ace7a16a8033169b7ddb71a79956416644ffa3e Mon Sep 17 00:00:00 2001
>   From: Hongxu Jia <hongxu.jia@windriver.com>
>   Date: Thu, 23 Mar 2023 10:28:04 +0800
>   Subject: [PATCH] fix XNNPACK build failure for qemuarm
> @@ -13,10 +13,10 @@ Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com=
>
>    1 file changed, 209 insertions(+), 7 deletions(-)
>
>   diff --git a/third_party/0001-XNNPACK-support-32-bit-x86.patch b/thir=
d_party/0001-XNNPACK-support-32-bit-x86.patch
> -index 2141c37236b..ca6a38545b1 100644
> +index e2c053e6f8c..89ba615a9fe 100644
>   --- a/third_party/0001-XNNPACK-support-32-bit-x86.patch
>   +++ b/third_party/0001-XNNPACK-support-32-bit-x86.patch
> -@@ -1,22 +1,36 @@
> +@@ -1,20 +1,34 @@
>   -From 2345756776fa09fd95e29f96f781e15e3b18a61b Mon Sep 17 00:00:00 20=
01
>   +From 5ba6883121e91a334cc97ee98eea6ef0afb7a314 Mon Sep 17 00:00:00 20=
01
>    From: Hongxu Jia <hongxu.jia@windriver.com>
> @@ -28,8 +28,6 @@ index 2141c37236b..ca6a38545b1 100644
>
>   +Does not support 32 bit ARM with Neon DotProduct
>   +
> - Upstream-Status: Inappropriate [oe specific]
> -
>    Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
>    ---
>   - BUILD.bazel | 1 -
> @@ -59,7 +57,7 @@ index 2141c37236b..ca6a38545b1 100644
>     config_setting(
>         name =3D "android_x86",
>         values =3D {
> -@@ -24,6 +38,194 @@ index 27ab07c9..f223d2ab 100644
> +@@ -22,6 +36,194 @@ index 27ab07c9..f223d2ab 100644
>             "cpu": "x86",
>         },
>     )
> @@ -255,6 +253,3 @@ index 2141c37236b..ca6a38545b1 100644
>   -2.30.2
>   +2.27.0
>
> ---
> -2.27.0
> -
> diff --git a/recipes-framework/tensorflow/tensorflow-lite_2.12.0.bb b/r=
ecipes-framework/tensorflow/tensorflow-lite_2.12.0.bb
> index 83fd12d..e76a09b 100644
> --- a/recipes-framework/tensorflow/tensorflow-lite_2.12.0.bb
> +++ b/recipes-framework/tensorflow/tensorflow-lite_2.12.0.bb
> @@ -15,7 +15,7 @@ SRC_URI +=3D " \
>              file://yocto_compiler_configure.bzl \
>             "
>   SRC_URI:append:arm =3D " \
> -           file://0001-fix-XNNPACK-build-failure-for-qemuarm.patch \
> +    file://0019-fix-XNNPACK-build-failure-for-qemuarm.patch \
>   "
>
>   SRC_URI +=3D "https://storage.googleapis.com/download.tensorflow.org/=
models/inception_v3_2016_08_28_frozen.pb.tar.gz;name=3Dmodel-inv3"
> --
> 2.48.1
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1061): https://lists.yoctoproject.org/g/yocto-patch=
es/message/1061
> Mute This Topic: https://lists.yoctoproject.org/mt/111125079/3617049
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13176=
071/3617049/43253763/xyzzy [hongxu.jia@eng.windriver.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>


