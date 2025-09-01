Return-Path: <hongxu.jia@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2108FCA0FF2
	for <webhook@archiver.kernel.org>; Mon,  1 Sep 2025 02:32:27 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.42218.1756693940554744217
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 31 Aug 2025 19:32:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=YmGDqPjd;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=1339ccf3fc=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5811B0Ul3757872;
	Sun, 31 Aug 2025 19:32:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=jks8lRRLwFRQ8NCwHaWayuSQj9A/WzFNXW3gWO07ez4=; b=YmGDqPjdQOtl
	gv4uODDsA66fieystqP1vv5FWMAoawA2xuFTWLAg1gAIEufKLnObJH9eC882UE/B
	2bMddcz7niXGJeRneRhJQJCEAhCqYZ/xE/2WqVkQtUgBWy2qJa4KORXM9Dra7Ljb
	Yy07qsGNpWOSsmNvZVqZBXFxQw+rK2OFkJP2xSmUlyoh0/kjTW49TEdmApl22sE3
	dQb/752iqAXQXMC/8XOpQWI14mAyo/OmSk+lih+LK/71feUIkgwy/mvUvNYCw4pB
	GEa0tLs7xSISKyYjjEXwUHXA6QQuXKTh0/7IVLuEY0NSjcLAni0sJybir2tEiBog
	8oXFkpKVpA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48uvjys38r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 31 Aug 2025 19:32:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uq4t8A9pY8EPY+LJuN5kqWe3/uB9iUW+2PJseCzu4RCVZUVEPopAnzv60y0Qyc9s4mEfijF8GCYCBHZT+rveqpom5TFPS3HPPWTYWTIqAvitBTUKsdwzjp7k/4LA3r3Iy65HSE3FmewA1XsHl1hbFAImF48oc053OLJ2caV8hkBA0i7hFym2RNkGIc0/WOBvsogauPZTuld5fB1dWtHEiQn701Cbko0z9Xl0po8sG+3ke0ioTjJT/thIXRu+mAcqgLHFYgU0ZGwBDiCpH0uC9iM7u2mPPpMTE17Dqj5NzYOQsJlJ34tw9HpNnzkg582hpbxs50c2fOqurzBAq6c9hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jks8lRRLwFRQ8NCwHaWayuSQj9A/WzFNXW3gWO07ez4=;
 b=G0BkfeN6VaSnBDxhrZxVaPvsQ4zJwiJPZH/5d9hMNJxfY6db3BIGFGh2TUQ2Jp2YYeNmWpieTnB3rfBpA5HaJKqB7CnZ0XXuB7f0mZcVZHAnBedzT+1c0TsgnY8lf031njBoMGhuaejrttaPKZ//8bVlOPkPPyVCY2QwuwcHo+DqEA/MiJK2/nBE8ykvdxlg/x4fdzfEmYaO8Ldyb7RRhURC8+cHhLn3NXS20i7IxG069ffeJ9J6iVINHTFxg5PaVm8vDehM8+lbxvTR47Qy/VgbVupzOWCjuqdoKtrs/8YdfBG/AFzwDo/wx2ySbzWOZD2InKelB/g8bjJ5o5np4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20)
 by PH7PR11MB8479.namprd11.prod.outlook.com (2603:10b6:510:30c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 1 Sep
 2025 02:32:15 +0000
Received: from PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::ef64:bc9f:eb8c:e6e]) by PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::ef64:bc9f:eb8c:e6e%5]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 02:32:15 +0000
Message-ID: <14c81919-3cd8-4b17-8be4-2a3bb317610d@windriver.com>
Date: Mon, 1 Sep 2025 10:32:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-tensorflow][master][PATCH] bazel-native:
 fix build with gcc-15
To: Martin Jansa <martin.jansa@gmail.com>,
        yocto-patches@lists.yoctoproject.org
References: <185D236360593879.4571@lists.yoctoproject.org>
 <CA+chaQcBn_=Sz-8nPaC7RNGtR4FLhc6X7DaqMGhCopVq7HWxpQ@mail.gmail.com>
Content-Language: en-US
From: Hongxu Jia <hongxu.jia@windriver.com>
In-Reply-To: <CA+chaQcBn_=Sz-8nPaC7RNGtR4FLhc6X7DaqMGhCopVq7HWxpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To PH7PR11MB7608.namprd11.prod.outlook.com
 (2603:10b6:510:269::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7608:EE_|PH7PR11MB8479:EE_
X-MS-Office365-Filtering-Correlation-Id: bc674d03-34f3-4128-0055-08dde8ffc365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|4022899009|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?b2dhSVR6cUEwUUVNWFBiM1RGSGlNSnV5NGdCcW1hakJTNEdwa1V1NVgvLzdG?=
 =?utf-8?B?S3FTUk5uQmtNaHhZQkJ2ZEFjZVF2cXpaYUtHSmhGd29ma09waUNubTlpRTdu?=
 =?utf-8?B?ZWI4MWJkazdmcWpLZHRTSkUyOENnM0ZOTGZtMjJpcy9VNVkydkt1N1hwVW0z?=
 =?utf-8?B?bWxZU2RndTMvWmxISHVmY1B4b0U4TmRTNXVFRkVSeEkrc3hBbEd0MTRxZ1kv?=
 =?utf-8?B?aW5CWXRQTHFCb2IxdnQ5Nm12VDlVR2JrbjhEMGd4ejZvQTJSbGkrUmdoVVVo?=
 =?utf-8?B?MGE2RU1kTTk3T3BzRnZDSEdIbDViUW5LRlBaQVh6Nk5TRHF2bzZVbW9kbnkr?=
 =?utf-8?B?MnJLY2hFdnQ4R0tGYXRoWEZLQUVGU1MyTERKUDlxekZtbjBwSUd1aERJUmNR?=
 =?utf-8?B?TU9RT09UMmVsMTJPRHo5dGd5eWlxazRpcGdrRHk5SlBUdjd0czRsaGlQN1I0?=
 =?utf-8?B?a1NObE0yQkVZM0k1akMwa3hieHdOemFDYzlOQUpPYXFFci95N2dURkNyN1Y5?=
 =?utf-8?B?eDM1ZEFXZS84NUFIZFp0UUpsa25JaW1penkzNjg5QWhJRFVwbXhkcGZqYUZZ?=
 =?utf-8?B?TVB6WFJYellSb3FFTFF6WDQ4MzZERWFDaDFucWJZaUZYZlFOcjYweGlwVVVw?=
 =?utf-8?B?a3NFK0VSUC9EZE5tRmdHczB5dEZhcmY2cm1GRGV0Qlo5MllDWHo4aW9CZWhN?=
 =?utf-8?B?U2lCM1lRU3dyV090T1dWbzIxK1Z4WEdteHV5RHZLQnBDd0RkZC81MVpSbnJT?=
 =?utf-8?B?aUUvbzk4OHR6MTd5MEhSZ3FIUEtROGJLTjQzQWZBSWQwTDdDb1BQUHQ5TXJL?=
 =?utf-8?B?ZERDMmtJdGRoQjNPWWNTejl4RE1YOTVLMEZMREdaVSs5RkViTFc3TDlOU3hm?=
 =?utf-8?B?ZkhNRHBRNEVQYmNhbjNQd1JrU01TVE5iT2EwVmF2UzNZaE9Cc0xjN091N2xz?=
 =?utf-8?B?akdteDVaLzdRcVF5TDlza3hTZnJ1NFZyR2FvMi9mTFdlU1pvMXlYOFZ3cmJW?=
 =?utf-8?B?THBZUXJ6VDUxNmZMWWFnZGd6VFV6dDV6d3F5NGRPdzFCODFlWFIyRkVkR1l1?=
 =?utf-8?B?aFhyZkJTd1pOeStnWWk1aE1RWVREZ2xacDlNSUE1ZGluK1FvcGlsVkFYekM1?=
 =?utf-8?B?ZENrYlR6Q1hiRHFGazlJa2VjMWtsLzFhb0E4SmkvZHhxNk1GaW04V2U1a1Rs?=
 =?utf-8?B?WTk4SHhWVmNTajBFTys2VTdEMWZUUmNkY1lCYXI4UFdQL1VWTVpCdzR6TEZM?=
 =?utf-8?B?OUdPd3phZkhRdHM0d0JYYjBQMlFGbS9SR0RKV3Q0Yjc3Tkl3Y3RVejFzaWkr?=
 =?utf-8?B?YmMzaWpwaStBMzNoMWdpWXR4MkJtUDlJQ2RiU2w4cXVNWkVScGExbEFRelBN?=
 =?utf-8?B?QzVuZExneU13L05GenR4Y1NxZmtTRTFMMWEzSnE0eWt6ZDYzQzY0Qjd3dFhK?=
 =?utf-8?B?UzM1UXZ4Y1dHdmxTYWdlUXJGcFhPTTJoOGRFNFFEZm5sejJmcWdvT0FhWFY3?=
 =?utf-8?B?VytybGpDbHpEMVpkQjZESTFtQVAyUVZvOEVzRnNPL1BBQ2dWZjZuUHBqZE00?=
 =?utf-8?B?dWg0SENiU3RqV09xTzkxa3ZZVGt0b1U0dFN4NzVwVlZPdTFXR2tUZVVyanM3?=
 =?utf-8?B?TW4wdU55MmZpcldOdHJvZDZMZGFkbktLVytjWGpuclkvVjg4cktpaFgvL2NS?=
 =?utf-8?B?ZHE4WXQ5MktCUzF5M24raElrUFdjZUoxQmdGa0tlZTcySTNwUTVweHpNV3Aw?=
 =?utf-8?B?V2ErWVFqYnJHdjJNZ0hKNGZiU0tyOGJORUtZQ200QkM2TDZmc0xNRDlYTkI4?=
 =?utf-8?B?aGl2YzlLdi9OeTBsTEtMM3RyaFhHUGlCQVlpTjQ0UklyZG16bWFJMVVOUnFh?=
 =?utf-8?Q?4XnQGj5xkMU48?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7608.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(4022899009)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K1dDc2lSazNraUdnd2F4czc4cDRrWWMxbzA3YWRmUktXNVZnZTd4YTVSRWFJ?=
 =?utf-8?B?azQ4RUsyemdFd1ZUS3VMWWJ5aFJoQUdRc0NqY0hFemc2TExpQmhrUWFXaXdo?=
 =?utf-8?B?YUx0NStXb3BldGxHcVY4V1gwUldpbHlkdTE1WmJWejZqby8wUmxWblpjbzIx?=
 =?utf-8?B?YzFDVUJQUklDRURoSHhJTFo5SXJKRkZzVnpVbGRSNkUvbkdsajFic3pUcWI2?=
 =?utf-8?B?RUFoYy9wcW1xdzhpMXFWZ1JWQzhvUmdhOU1hRG1XWURQWlEvNUVCMCt4RXlw?=
 =?utf-8?B?am55UkJROElBQ3VBdmhqMjFCM1ZMQ3R3YzhJaHNiOU5kdWFsN0E3ZGQ5VUlj?=
 =?utf-8?B?UTQvMlJIWXpzTU1pM3VyL0trcWgxRjE4dituRElBWGxlNXEvdnFQcHVhcGpI?=
 =?utf-8?B?NGV2eExyVDlUbG1EU2tia3ZjQndCYVpXWnArakhLOW1QZnFwREh3Ylh6ZEgv?=
 =?utf-8?B?YnY3NUtZSUFaSHpRc2dmY1dqb1RReGRyV2hHNW9NbG5DNitEN2ZXRHZReUNu?=
 =?utf-8?B?aHA0SWFGaFUxeFp5SVk3YVcrbkY2V2NFdDZqMS9xT1djNWlIZ29rbG1zUXRV?=
 =?utf-8?B?Q0FsUU9yY0xla3Y3QVZyZE9kWGExMEFWUjh1Ty9ZcTJlY01LWW5YVHA4bWN3?=
 =?utf-8?B?M01GcDlack9MU2FzekZJQmpRQTB5M09oMUs5ZitnRklUSlZrWlQ2UjN3SDcr?=
 =?utf-8?B?MkpiejhGMGVzOVRsWEJKOE14cWVvSTdKR2lGb3MvZ0EzTStmNGtqSm9TSGY3?=
 =?utf-8?B?ZWE4K0UzMHNxc0pZd0psZzYxYUxVWm0xb2JmbTBBdGxqZ1ZVNDdNRk9xTjFn?=
 =?utf-8?B?Y1puTVcxTDRDSEpqTEJSdHV4VmxOd0lreEVXbzd1dWVmYXJrRnB6K29yckdL?=
 =?utf-8?B?OUVzczZMWUxrVHRXK1Q3Mlc0MFJPTkV2NWE5aGI1ZHA1cFhQb3UrWnkxeG9E?=
 =?utf-8?B?TElaVWxFMHJXUElzTWU3TkpOQ2xkUGdnaFhkYWoyTnU2V2Zjc0dsYjF5bnhT?=
 =?utf-8?B?U1NldVJoS0VZL2pSVzV3di9MZUkxSzhrak5aMU1EcTJNREtyZFNEc3pRUVpZ?=
 =?utf-8?B?QUNmZXowbXBCZUQ5SERLL0tScE44RWJDelY4a3M3WiszekVkZDZtbUR5VnN6?=
 =?utf-8?B?MCtISFRXdkFiTSt1NTQwczZ6NGd0ZGlUaWk1UUkzSUg5WTFybk1lcTM4eDRk?=
 =?utf-8?B?dW1YVlNUSDg1RUs4OU9EVHRZbUNkWDRRVlpzL0U2NGYxbHYrVHcxMUdIZ3FZ?=
 =?utf-8?B?YjEzMUJvZllTQUpLOUlSdDBZVHhqQmRWcUZuT3VzYUVEUDVDdGZ6b2p6bU5a?=
 =?utf-8?B?TnIrVzZUYmQ4NFZXRi8wc1M3Zkpwb2JMcm5LNEV2dWpGam1tWFpTOElhUmwz?=
 =?utf-8?B?NnZWWE9nVTBodUFvNjd3OHFlV003MGdqVjJhanJWL0dKL0ZjUFpXMVYwRElp?=
 =?utf-8?B?dHBHb1pyQ0FFU3JGRjN2V1ErV3VlbkhLZ1c3NTh3ZUR4eFFvSWlWZCtiV25n?=
 =?utf-8?B?bXdOS2p5Z3V3bzJXYW1GMTVHNkhBNTlMY1d2cVVtajl0aDdDTzNEZlBHd3Ra?=
 =?utf-8?B?Wm5ibExoamlRbWN0SVp1OFFNVXY5SkFoTFpwRllxY2tNMi94VU8vT3NuMndY?=
 =?utf-8?B?NStQQkpXOTZUZDBKWitxQktNNWRNVGFlM2ZXSFV5bUhmTFcrSVJJdlh3SkIz?=
 =?utf-8?B?Q0NKR1BPVW1TTXlDMG5nTVNXUUpMVE9mcnVRZUVFSjVOaC9KQ0JWMDBkdTc0?=
 =?utf-8?B?azQ5ZWorQUR3TE5mK0lYUWFyQVBSSFhtTmpOUWRXMUc3NVFVb2hkOFJJclNo?=
 =?utf-8?B?ZlpqbUplNDRCRy9Ta0svUVdUYmZodHhUS1d6SS9Ua0dJV2h3Nk9neGNNK3hw?=
 =?utf-8?B?SnY4ZVhBeGphNmRVdEZhUnRxR3VwUGJKQmlVeHVUbUQ1Z3VTN0dlemFLT0Nz?=
 =?utf-8?B?Z2c5Q1hBYWV1bWZGSGtsZ2dDaVBONE40ZXQ2TEw3SEtYY0YzL3BubVU2TTdE?=
 =?utf-8?B?aGcwNXM2bW1Cckh3azdZcm9tbzFXZ2dubFhRMEZzc3hUd2dITWlOeno1QnZ3?=
 =?utf-8?B?T2NHK2lqTnY5RVpzazF6WFE1T2ppV0Q2NjBJYW5OZk1iNW9WUUplTnRlWVhM?=
 =?utf-8?B?cDZYTzhGdVl0L0xyOUhEaGhJWTRSRnlhQmk5aU5UNjduT3VPcHVaWFFBUkly?=
 =?utf-8?B?Z3c9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc674d03-34f3-4128-0055-08dde8ffc365
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7608.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 02:32:15.2630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uf7RitFuKD4WvDqkbUEUUqrhrNH8htNOx0KQxdF2idKeL4KUOM9+MK6tj216KjwTiWix/5hi/qqK0hJt91BUEeqB4IhyPSSgYSbNbuV30qc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8479
X-Authority-Analysis: v=2.4 cv=K8wiHzWI c=1 sm=1 tr=0 ts=68b505b2 cx=c_pps
 a=EEbzfBuTrpn0kuaIXlprqg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=NEAV23lmAAAA:8
 a=iGHA9ds3AAAA:8 a=pGLkceISAAAA:8 a=VtfK8tnSK1RsHKa6bQQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-GUID: q2TsP3auYc7fsLhiuG0Nh_UTJWaRUIdN
X-Proofpoint-ORIG-GUID: q2TsP3auYc7fsLhiuG0Nh_UTJWaRUIdN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDAyNiBTYWx0ZWRfX+14uInIQG3GE
 wNYHc4+AkKj2B40wLgEjaOHDVlZm2y3Wz9tJwqMCvMk3i1Rfu8g/Q9i2tlmtpren25BzFJI1ap7
 gF70wSk55OJQwgJlDPwoqQH58SJ69gTSkR5tQT9vswg3WHIO3+d9TkRhIKkVG3iV7E5DXyOAFSh
 t01gjx+fqmBnUg3i18c7PQx7CTrot4wzdpzxKuY6rKrabm6DJ3XZBpCyF0A9UZGyJWJV7PD+ixm
 bt3pifWqe8Q5JIMF+L/6tK0Pib1H5WPbe9+DsqGo7ku/D433yL6+FAhAnvgwP2gJvRK22DBg3sp
 SXUTTcTjv2nYWdNR8+S9oK4MaJknj5iyGDxKwMiA4GPtoNCNvFNpAU8e+fPy8M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 5811B0Ul3757872
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Sep 2025 02:32:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2097

On 8/27/25 18:04, Martin Jansa wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender =
and know the content is safe.
>
> Hi,
>
> this time you didn't forget the "From:" in the body, but the Author is
> still mangled.
>
> Are you applying the patches manually instead of "git am"?

I used `git am' of course, the firewall of our company has changed the=20
content, so I have to update it manually each time :(

//Hongxu

> Also ping for the same change for walnascar.
>
> Cheers,
>
> On Tue, Aug 19, 2025 at 12:12=E2=80=AFPM Martin Jansa via
> lists.yoctoproject.org <martin.jansa=3Dgmail.com@lists.yoctoproject.org=
>
> wrote:
>> From: Martin Jansa <martin.jansa@gmail.com>
>>
>> Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
>> ---
>>   recipes-devtools/bazel/bazel-native_6.0.0.bb  |  1 +
>>   .../bazel/files/include_stdint.patch          | 28 +++++++++++++++++=
++
>>   2 files changed, 29 insertions(+)
>>   create mode 100644 recipes-devtools/bazel/files/include_stdint.patch
>>
>> diff --git a/recipes-devtools/bazel/bazel-native_6.0.0.bb b/recipes-de=
vtools/bazel/bazel-native_6.0.0.bb
>> index bc63430..4960358 100644
>> --- a/recipes-devtools/bazel/bazel-native_6.0.0.bb
>> +++ b/recipes-devtools/bazel/bazel-native_6.0.0.bb
>> @@ -12,6 +12,7 @@ SRC_URI =3D "https://github.com/bazelbuild/bazel/rel=
eases/download/${PV}/bazel-${P
>>              file://0001-cutsomize-native-toolchains-for-Yocto.patch \
>>              file://0001-fix-compile-failure-on-gcc-13.patch \
>>              file://1f2b3ed4ac717b814d02a0d125f160ddabe78003.patch \
>> +           file://include_stdint.patch \
>>   "
>>
>>   inherit python3native
>> diff --git a/recipes-devtools/bazel/files/include_stdint.patch b/recip=
es-devtools/bazel/files/include_stdint.patch
>> new file mode 100644
>> index 0000000..35c57c2
>> --- /dev/null
>> +++ b/recipes-devtools/bazel/files/include_stdint.patch
>> @@ -0,0 +1,28 @@
>> +https://github.com/lihaohong6/COPR/blob/bf48c5450a909cf8358e3cbd81cdd=
e26df426e12/bazel7/include_stdint.patch
>> +
>> +Upstream-Status: Submitted [https://github.com/bazelbuild/bazel/issue=
s/25514]
>> +
>> +diff --git a/src/main/cpp/archive_utils.h b/src/main/cpp/archive_util=
s.h
>> +index 18856ab..5298a36 100644
>> +--- a/src/main/cpp/archive_utils.h
>> ++++ b/src/main/cpp/archive_utils.h
>> +@@ -15,6 +15,7 @@
>> + #ifndef BAZEL_SRC_MAIN_CPP_ARCHIVE_UTILS_H_
>> + #define BAZEL_SRC_MAIN_CPP_ARCHIVE_UTILS_H_
>> +
>> ++#include <cstdint>
>> + #include <string>
>> + #include <vector>
>> +
>> +diff --git a/src/main/cpp/util/logging.h b/src/main/cpp/util/logging.=
h
>> +index b2cd459..7bf5a00 100644
>> +--- a/src/main/cpp/util/logging.h
>> ++++ b/src/main/cpp/util/logging.h
>> +@@ -14,6 +14,7 @@
>> + #ifndef BAZEL_SRC_MAIN_CPP_LOGGING_H_
>> + #define BAZEL_SRC_MAIN_CPP_LOGGING_H_
>> +
>> ++#include <cstdint>
>> + #include <memory>
>> + #include <sstream>
>> + #include <string>
>>
>>
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#2054): https://lists.yoctoproject.org/g/yocto-patc=
hes/message/2054
>> Mute This Topic: https://lists.yoctoproject.org/mt/114778714/3617156
>> Group Owner: yocto-patches+owner@lists.yoctoproject.org
>> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1338=
8836/3617156/66960823/xyzzy [martin.jansa@gmail.com]
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>
>>


