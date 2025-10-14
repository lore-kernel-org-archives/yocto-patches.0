Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00474CCD187
	for <webhook@archiver.kernel.org>; Tue, 14 Oct 2025 08:30:17 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.10341.1760430613752406134
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 14 Oct 2025 01:30:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=Xx4a0JGS;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=2382413dd2=yi.zhao@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59E0qfX61587834;
	Tue, 14 Oct 2025 01:30:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PPS06212021; bh=BnuaQf5cSf68gWF4Jr9Ry8
	TKhIyHRM/ISZBQvYAWe8k=; b=Xx4a0JGSAgj3+xLkCo9vgvxK14/V9bSCJ2UGlI
	Ex50cIunVo0r/Q9bJCSgk0Gv8dhInFRjBdKopm3RP5gfbgtR1JgHja8bXmVLejGR
	jhhHY/H1CudUwpKJ1v2Va1bqbGpZ0b8hvSpEqplJmrcEbqslz462yMXSI6Nw2OmK
	9cg84x3x1+AuwE8AGmYdF/YSE4mopqFV6QOxOOrZseLkfojuOwyOOmd4iq6Zgt8P
	vnQ270/wIEna0ZO61v0AMcTvEMRtvq6Dduypz6lb2ERWtODB3m8lD3M5bpn6/yYN
	7eUCy2hPgl3LnEi8kO0Z3+yAE/jahv3LEnPc4mTVVbHc3IHw==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011053.outbound.protection.outlook.com [52.101.52.53])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49qprdthu9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 01:30:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TdaFWXWUtJGiXfiDcfw7m1UoeYJU/htWboOxh4mo0L5mRNjD6oxpCmcB+ZRh5vREexXucNGBeT4RUzaSDYPODnugqZlrkrun947VBd1fE+JGuuJS/Iu8C5g3JlCdCr7rEHUCJ9FrjolzCk9xG4Pw774NN3/QmalH5fd444JAe7oJOhE7ip3YFpx0uMn/XMmJc3pMzP6pas91fDbeWJ3jMDh9ec6MdA/s2f1InxfEUQGCF9nyv9+eU5wIhm5PBC/4GtVVjNkc6livQndtWkdlaZfyEArM9Ls7vtGwZP73Rt8AxsEzh3vENT0HSkTj1MXvEJQyKH54ZZB8FxDpw5Gkqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnuaQf5cSf68gWF4Jr9Ry8TKhIyHRM/ISZBQvYAWe8k=;
 b=aEE49zkeEHd2bdx1I6/cI95NEiNmbxHODN15kEd2FCcYU74ko2uffCLItaHQ2dQMyqdHRViw2EMkw3UvcPHZrzusq459sG6tVS1V0xt44AZ7b40qmTIGVoVpo0yaHzRuzVEjgYLK15bTrEejcwXNLS1SyBOZxQWx596Xsw3kRNO6su4hX6qyNFqFLC3HAFeggbS3eqUFtfocCQlhrA9ZZs+hQVkiOdLuShO/SsfL781/thtTztAdyej14hZdVfzPjHQ6xQGZJM9DmOdCQWSlD/vr+tvAsdmBJlOI7cpggBPRQX9Mb7XOhuKzG7WgHmuSAJTNaBiZKQfifQy6GQWs2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 08:30:09 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 08:30:09 +0000
Content-Type: multipart/alternative;
 boundary="------------IYZGqH30vx6cV5OEaArjwQZo"
Message-ID: <a5ad7b6e-3a31-4fa5-83f8-918744c6c32e@windriver.com>
Date: Tue, 14 Oct 2025 16:30:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: meta-selinux][PATCH - Do not look HLL files when
 POLICY_MONOLITHIC=y is configured
To: "Sasi Kumar Maddineni (QUIC)" <quic_sasikuma@quicinc.com>,
        "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
References: <BL3PR02MB89865DB6BD360CBD532D749AE8EAA@BL3PR02MB8986.namprd02.prod.outlook.com>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <BL3PR02MB89865DB6BD360CBD532D749AE8EAA@BL3PR02MB8986.namprd02.prod.outlook.com>
X-ClientProxiedBy: SL2P216CA0079.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2::12) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|IA1PR11MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e1371ee-a358-404c-d2e9-08de0afbe309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bExVNEVKVWdwMHZickpDdjRobms2QjlhK0Z2YTMxOGJoNDM4SUU1QW1Md3Jx?=
 =?utf-8?B?WWZheGVFN1hSN2pNZXR3SUh3SjJYTWxwR2hkY2ZxeEI3Y3k5UTFKSWVSVFE2?=
 =?utf-8?B?bVRIZnZ4NXFwOHNnWkx1d0dzMVlzSTRkZnhFbWFnT1NmL0xMUkQrM2QyMTFa?=
 =?utf-8?B?VnNNeVhoMm1mZ2E1aWRzTVZjeEU4L2FvNmUxRTlkaUFjZ0lFTVA1amJXZnhB?=
 =?utf-8?B?REVGZWRjcFJsRW1pR1dMZGF2a2NaMFVxaFlXM05mU2xFZGEwNVZjUzJvZFI1?=
 =?utf-8?B?UTlUVkpFNUUvamg4QWRVVXc0Qi92cGl2VkFwN1cyazJ4ZExQSHQ2S3lYcnB3?=
 =?utf-8?B?WXVneEtLT01sWVpHZExQOU9EWTFWc2JOcXR1N0t2TU9HUHE1TnhueGZrVTdZ?=
 =?utf-8?B?SExJTXpKbi9vZE9TQlR2cGtDeUJvTFZldTdkWXZYbVIwTEZNVW5TcXpmRVVP?=
 =?utf-8?B?Z0Fla0I3d1dRQTFjaVFjTUlMVlE5ZVFIWi9JY0xBTGR2Uml5MytzVk9lWHJS?=
 =?utf-8?B?cFRaUnp6SFdxSTVPRjJyYmVxUGN0NTlrTGJleVFQWVE5bGd4SlUwT1hpYkdK?=
 =?utf-8?B?TUU4aktTYUpFV0JaSnZnYjBZVzRlcWhOTFNVei9xU2p0UHlDekoxOFZzb1FI?=
 =?utf-8?B?RmdsZnl4Ly8yUTR4K1lmMUJkSE9PZ2FIZk1STERocDlPN25TYjVXYlFRZjAw?=
 =?utf-8?B?bzM5K3JNNVUwRHkrcm13NUFaM2FQNlBwRStjTC9VYXA4cytVbnFZWXllT1pT?=
 =?utf-8?B?QmdKVVU1YzgvRXo4TzdWdHY1cXJWcU1BNWxybDVQTGRtaU8yNjBiR3RNV2d1?=
 =?utf-8?B?TVIyYWpTWlJnYUhDRW95ejY5bjVYZ2xIMTg2ZW16QzFJUHVHR1owTjlHVFEv?=
 =?utf-8?B?OTlkNGp1VHNRR2ExVExEZlE0SFFTdFQzbDU1UmdSVUd1aHBiNzZkN3ZOaHRo?=
 =?utf-8?B?Vjg3bHZkamFSWjk3QWJrUmxBTGtKT3dDT2tWVGxGdzFUUGRrcmpZdFh5UkZ5?=
 =?utf-8?B?dEVGaFE1eHRaRmRhT25qTENuKy95TFBhWllXQUFwb1ZwNVl3bkh5aWp2S3NE?=
 =?utf-8?B?ais3T1BpRlJzeVhhRWxXallYNFR1bVRpUHBvc1ZvQmEyVFgzZmZZaWtpZzJM?=
 =?utf-8?B?a3pxMFBIVTJKL1dIUmlsd1A1ZS9SVXU2b0t6d2VYU2o1L25SbWE0eGZxcUIv?=
 =?utf-8?B?RzlXWGJsN21oeFJienVCdzRQN0F6L0dveUJKMjRmNnozbUYzQWZRelRvNERF?=
 =?utf-8?B?V1FDMVlXSE5CM2ZORVU1M1BpSDk1YkpPWDdFRXZFTklrb2ZKOFJTb2hNdEFn?=
 =?utf-8?B?NTEzTUcwUkxYNjV3eEF0QkMyYm1wTXRhOVFkOW9OSmo1UWFURjlLZ2YwQkFN?=
 =?utf-8?B?cXUxbnFMclpBY2lEUDhua29YcSt3VzR0V1pUaVJaVm5icGVHUlVqU01zVnBD?=
 =?utf-8?B?YVovUFFranBmbWxWYWQwMkZJSktIdDhtWFhLeUU2aDBlQW5XdWlGd0plejJq?=
 =?utf-8?B?OTU3SkczMFZEeVlueGNsaXZjam9KK250YXFnSU9aaXdLdi9ybEZPTEhVa2Yw?=
 =?utf-8?B?aGNDdmFYWjBFai9uU09pVElpZ01LT0VoY2Zlb1RZSkNkNjRNcm1zOWZjSVNw?=
 =?utf-8?B?SThVK1Rkc21TR0VSb3k1TiszWUNPYnExNkhYb2cxNk9YeitwT1dPZm1XYWcr?=
 =?utf-8?B?Y3dRdHVjbm5xSjFVSGdTcmNXY0wzQ0pKZnVvUmJZWlNKNysvMGNQTURGSjhz?=
 =?utf-8?B?QWduU3IwNEx4YUxVRUJqRUNiQndFWTEvYi90a3JWU0FkQmZuNVJQTDlBMHhk?=
 =?utf-8?B?SlhKanduTlRnM1EvbDV6bmFuSEV4ZVU1NEsvZnlDVmlNYVhzam5HWndmR1RD?=
 =?utf-8?B?T044dEhJODNtdXVQUTlDSjBIb0I2UG4yUE5JQUtWSVhZMzdvWFpJM25sRU15?=
 =?utf-8?Q?hJT0VQnbb2Yw1uiQTvCKFwLTdZLXFEYg?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(8096899003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dXNzZy90NHV3NG9LSERVaGx6L2J5R3AxdkdZSWJLT3o2ZHpDRituNExzSVBn?=
 =?utf-8?B?TEtrWkViaTE1YW1HVWdGYlpEZFV6WXNxdTZhTkhXWTM3QXdsWEhuSE9Udzhz?=
 =?utf-8?B?K0VRcGpqcDBnMDk2RlUvS29UTENaWTBJdVBsaCswMFRPM09NVWtFTzFpL1pM?=
 =?utf-8?B?RG5DSmphV1dnZlhqMVBINEFxUlZBbm1XRUQ1SUlRWlhiM1E1U05WbjNWeTVz?=
 =?utf-8?B?Y0thMEwvOTlhbTk2VVlQYWd6eGswQU5UZzJDL213UWJ6MG5NWm9hc09BRVFq?=
 =?utf-8?B?N2pDZWNaYVBpOFhWZkhXdytlUnpaU1lEZFV4RnRKUkZubGpqVDV6VldZWk9S?=
 =?utf-8?B?MGM1NGRpZExDMHRmMnlLN0xUeU91RFQ0a0pUSlFLTzBqcWhpOXR3TkFmQ09L?=
 =?utf-8?B?RUc1VzY1bXhueGRqb09kVnRsbUNMNDZhNkNiYnNQemRiQnFpSS9STWErY2RD?=
 =?utf-8?B?NDlEWE1QVHQ5WGhZczFDOXJTZ0FnWVE3NVNqVmtHNXhBWmVMZW81V0wzSUxj?=
 =?utf-8?B?NXJuUnh5MG5TekVtai9uVXJNRlFKcGI0S2llZjhNQ204US9pNGJkaVFVSllE?=
 =?utf-8?B?NUx0Y096Um44RTNnNjVucGZtT0sxbHN3N3dXZTFlWG9xVWhHN3htSWdyQlJm?=
 =?utf-8?B?SnpYSDM4b1ZVcTdtbkhCcjdFSHBON3AvQnFnVklkWDBYMW5wQ2ZyMFZickRj?=
 =?utf-8?B?VHZ4YVF3Yy9zYzJuNjZOQjNSUCtvV1Z4czNOdzA4UXkrRzRoa0c0UUhUeFg0?=
 =?utf-8?B?Z1dSTHFXL1p3Y254eE1Ud3E3UWsveHNRQXJoUENXVWJzVmxjMW9WVkhTMW55?=
 =?utf-8?B?TDdPV3RvUHJiUm1PMnErTDRWYzlGVXVQd0RIb1BvWDVmRG9FYTFLaGlBMEFU?=
 =?utf-8?B?WEEyWjZxNk9NdUtsRWJ4aE56c1BpdDU3cUxRVys1UkJCMjJiZlh5QUVPcjJI?=
 =?utf-8?B?UGF1YzVvOW56cHZCOXZmNFk4ZjJ5NjR1VXN0TW93d1B6QXpNZkZ0WDZaWjJu?=
 =?utf-8?B?R1VWYzlZTVdsVzVEeGNXRW5LekxuaWRKamFnK2lqRnRoVk8xMDU3dGRmMmdm?=
 =?utf-8?B?Z0l4Q01vU2VjdUYyN1dDcjF0VndrQkxtOTEzbWdnU01uRm5ua21mdkgwL0pu?=
 =?utf-8?B?UnJ0aERBcEVrNXNLVWc1NzZJRjF3Y2hlTjY0aG04dG8yWldHUUVYRUpGN3Mw?=
 =?utf-8?B?bnM2M1JCYURHa2FPZ3BRdW1SeXRBeUpMNVBUNi9HZkxIejZEZTk2b0ZrNHdw?=
 =?utf-8?B?TmEwVjlCbU1lSWVkdWdMcnltZ3NENUVaYkRFREU4ZXJyQ1p0cGlTQ0Z1d1VX?=
 =?utf-8?B?dkNWTS9WV0VPdWoxQVMxTXdjNlZuR3VQNFlIcHY1V0pISWhnKy95aU8vVEVn?=
 =?utf-8?B?ZFpDOWJxYXNUTXpOUmM3d0I0TTloY2lFTkhQOXpER1Jpc1dJVVVGQms2SVpw?=
 =?utf-8?B?SEIzUlc2UG9EaU1vREU3VU1maVdTVnZvU1lNM0xoOVVVWEpUK1BXK1A0U0E5?=
 =?utf-8?B?SFpZM0pXUkJOK1NpenY1V3o5TVhjYkV1NlduY3k4UjBLUzFuZDRjdzFUK1lJ?=
 =?utf-8?B?RldSZUQ1WGtVYXhncXVidFd6V0p0ajBjZzRkTGNESlhjRjJDUU9rU2gzOU5a?=
 =?utf-8?B?ekJOR3BzOTJVWUJUUjdEbjRRWjJYQkhxTmRicEd1dU5qZVMyZG5yS2p4WnBM?=
 =?utf-8?B?N2xNVHNZZmNqUnFtcElQVG42MFJtckVsekxIMEZLM254eWpJWW1sM0tTUEZG?=
 =?utf-8?B?TWhQK0xDc3ppTXNFOFlJZEdnTnhyWCtSTTlNcEJKVnZ0eVNFYUNCbEVpZnRs?=
 =?utf-8?B?NUcvcFlnd2pjVWRuVjhIRExrMEQ0UWxsSXJLdWRLT2JkYS80Rk92MHlWOEt5?=
 =?utf-8?B?a21pdnlNVFpmUkE0aFcwdHJBTlBXYXR1RDRYSGI5Rkp3dE5TWTFESDhmd3dM?=
 =?utf-8?B?NEphYnRnQ1UxYi9DNDhhc3lYR1djS1FNU1BtZkI0Ly8weDhVNk5Za0VEYlYy?=
 =?utf-8?B?ZGNMNlR0YS91Rkp5OFpwRVdDcG9zTjF0NjRRbVR5MUFzM0hXWlpROVlRN1RK?=
 =?utf-8?B?MDQ2RjdQK2dlTU1oTUUvcVoyUThzN243STVlS2tnSnMwWGM0dXhYNFE5NUph?=
 =?utf-8?Q?q+laAwfIJ5LUfCIBMWgRTcjg2?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1371ee-a358-404c-d2e9-08de0afbe309
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 08:30:09.6698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ddeCBobNfklm1FXK3Z6fFsgJgS9TR56zAibm5BqOayr7JlvWQF3rWMGYKENf+O1D0LrS5axktYeuvvC5z9xuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7200
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDA2NiBTYWx0ZWRfX8Bxrs4IQWLHS
 LT0OjgkDE4/rinqTFkAIQ86HbxpwPKxN9atewRDw3s/SzDzmRu+HdhzM4PGKTrF1EwFmCZ4keuu
 hhdQUpcZlI4PLgG5Af0KM30LauO2YNXgYiWUwl+R4+mY4+TgjGrsHxx90oOYLR3nAs1VsddC3YB
 BizAz3IXIGf7LfDWSZbbV7ygyUJuKJf9VEWuPzRoBV1E/x3C8iAi61bsx65wbthVMfWsa+0xm7l
 IDgnQoR0xQ7rcmhBuBAojzq3FhSpmrE8ApQ+TKCEcVryLLJhBCsw74jolm/rp38KNNaMHJaWr5v
 BeVu+waBp1dleUwiQEGVJNaJhUncDSZMTJNG/HTb602oIV2Wd7yVmnvqbLjlr9wrZFlkxd23EzK
 BpaXe0Xe5oc8cjTHxsGTFn1bAREPjg==
X-Proofpoint-GUID: K0Bk_a5ZGp_k5OQcmJ6x3wDxqVpmaRXz
X-Authority-Analysis: v=2.4 cv=JaKxbEKV c=1 sm=1 tr=0 ts=68ee0a15 cx=c_pps
 a=H9d2Io+6O/etw3jU54J+0Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=-dT0QnE2iS6KnDUOq5YA:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
 a=UqCG9HQmAAAA:8 a=jHKlwqafRrtJeVwnhqoA:9 a=JJQFZ7ObQZkwMD1G:21
 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10 a=_W_S_7VecoQA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: K0Bk_a5ZGp_k5OQcmJ6x3wDxqVpmaRXz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 clxscore=1011
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510140066
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 14 Oct 2025 08:30:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2298

--------------IYZGqH30vx6cV5OEaArjwQZo
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sasi,

On 10/13/25 18:59, Sasi Kumar Maddineni (QUIC) wrote:
>
> Hi @Yi Zhao <mailto:yi.zhao@windriver.com>,
>
> I tried configuring POLICY_MONOLITHIC=y for our consumer embedded 
> devices platform.
>
> The recipe is looking HLL(.pp) files in case of MONOLITHIC as well and 
> build is failing, which it should not be doing.
>
> So, I raised a patch with the fix and shared the attachment.
>
> Please review provide your valuable comments.
>

Thank you for your patch. I found that even with this patch applied, 
building refpolicy still failed when POLICY_MONOLITHIC=y. So it looks 
like more changes are needed.


//Yi

> Regards,
>
> Sasi Kumar Maddineni,
>
> Qualcomm Innovation Center.
>
--------------IYZGqH30vx6cV5OEaArjwQZo
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi Sasi,<br>
    </p>
    <div class="moz-cite-prefix">On 10/13/25 18:59, Sasi Kumar Maddineni
      (QUIC) wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:BL3PR02MB89865DB6BD360CBD532D749AE8EAA@BL3PR02MB8986.namprd02.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:Aptos;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal">Hi <a id="OWAAMD1F1AEE518A641D18477FC9978CA9D0C" href="mailto:yi.zhao@windriver.com" moz-do-not-send="true">
            <span style="font-family:&quot;Aptos&quot;,sans-serif;text-decoration:none">@Yi
              Zhao</span></a>,<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">I tried configuring POLICY_MONOLITHIC=y for
          our consumer embedded devices platform.
          <o:p></o:p></p>
        <p class="MsoNormal">The recipe is looking HLL(.pp) files in
          case of MONOLITHIC as well and build is failing, which it
          should not be doing.<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">So, I raised a patch with the fix and
          shared the attachment.<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">Please review provide your valuable
          comments.</p>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>Thank you for your patch. I found that even with this patch
      applied, building refpolicy still failed when POLICY_MONOLITHIC=y.
      So it looks like more changes are needed.<br>
      <br>
    </p>
    <p><br>
    </p>
    <p>//Yi<br>
    </p>
    <blockquote type="cite" cite="mid:BL3PR02MB89865DB6BD360CBD532D749AE8EAA@BL3PR02MB8986.namprd02.prod.outlook.com">
      <div class="WordSection1">
        <p class="MsoNormal"><o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">Regards,<o:p></o:p></p>
        <p class="MsoNormal">Sasi Kumar Maddineni,<o:p></o:p></p>
        <p class="MsoNormal">Qualcomm Innovation Center.<o:p></o:p></p>
      </div>
    </blockquote>
  </body>
</html>

--------------IYZGqH30vx6cV5OEaArjwQZo--

