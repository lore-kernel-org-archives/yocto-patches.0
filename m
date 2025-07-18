Return-Path: <hongxu.jia@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C124DC83F1A
	for <webhook@archiver.kernel.org>; Fri, 18 Jul 2025 07:20:10 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.15385.1752823208784142762
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 18 Jul 2025 00:20:09 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=9294d581cf=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56I4t8u32379375;
	Fri, 18 Jul 2025 07:20:02 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 47yby3g8rv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 07:20:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9Bp7N9rtps+m2oaCNk5iBwT0BhtGnRYwO02+C3wtniZJozByW5/gJVTieHdWAAWqg++4pgMi/dOdVjo4a7WjixFiNha27Ca/HVA2R5C0zOrHcNIwDgP3OIAbPYjmB7xVwuoN/jS+AiLBew5w/zFPKTCC+SLJCabc9D6kPRnYZu7//4gMdwIvOiYDgI7Oq/Zkau1uuylAyNLSgKKHbHZuZ8qGNWB1TaorLw290ZLG8nrpckN0tUhlMYAa0jRGk5GypUatDLYo4DMMmgifdBBaeqRep7RmS6l8Z9zgix5O7Qxs/PvmpeZR/FcF9w7kFidsToH2Fl5rKZE0CLiWkkL2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aA14QKHibsPYA35i1C134jYDoPovH+Z/TdicPxa+pmY=;
 b=K5tPX/VYRkYXZJxKGDl4Uda3u7bG24LkqmkacLQCzW8T5zUl/GANjX+EbhnY6YvwSXJwt4e9GYkeotz92Kg4DY9OJxXW/J3nJYuhE7bPv0MckJCzyiZE3JMuUbb6xPRRxPR/D9cjHFAaFJzwVASZkaEMQnPNQJhq3na/hYpSJxBYr8QBPonBB6X8dxIXdf8ChlzDlUA6JToa4MOLX/RoSRqxXvRCU66h21fyRkOi4Xb8YkspwNLCCenWhGiW8netxLVBmNEoOzAg0hPaugU7GdFn+GMuZ2ZugsSxZ6ZUyAKkgWgyvnpf/JZFRr4iW9kfMuPtxUR7PZro79T23epK+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20)
 by IA3PR11MB9112.namprd11.prod.outlook.com (2603:10b6:208:575::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Fri, 18 Jul
 2025 07:20:00 +0000
Received: from PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::ef64:bc9f:eb8c:e6e]) by PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::ef64:bc9f:eb8c:e6e%6]) with mapi id 15.20.8880.015; Fri, 18 Jul 2025
 07:19:59 +0000
Content-Type: multipart/alternative;
 boundary="------------30PTUzN6Izb6S0wfgNDROu0y"
Message-ID: <83eb4dbb-2a6e-491f-a02e-e3ca9bba61bc@windriver.com>
Date: Fri, 18 Jul 2025 15:19:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-tensorflow][PATCH 2/3] bazel-native: adapt to UNPACKDIR
 changes - avoid WORKDIR/sources
To: Martin Jansa <martin.jansa@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org,
        Martin Jansa <martin2.jansa@lgepartner.com>
References: <20250708072436.24522-1-martin.jansa@gmail.com>
 <20250708072436.24522-2-martin.jansa@gmail.com>
 <CA+chaQdVAzm8au9RXWgY01gwwWO_qxO6LLM=ThTOwzWU8MrUgQ@mail.gmail.com>
 <519af080-65b3-4e68-928c-a2c5c087a5b6@windriver.com>
 <CA+chaQcakdJhrJMVjpx1pm_KsZ8J3N2cvg25Qc-DL2vLxbwGiA@mail.gmail.com>
Content-Language: en-US
From: Hongxu Jia <hongxu.jia@windriver.com>
In-Reply-To: <CA+chaQcakdJhrJMVjpx1pm_KsZ8J3N2cvg25Qc-DL2vLxbwGiA@mail.gmail.com>
X-ClientProxiedBy: SEWP216CA0076.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bc::18) To PH7PR11MB7608.namprd11.prod.outlook.com
 (2603:10b6:510:269::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7608:EE_|IA3PR11MB9112:EE_
X-MS-Office365-Filtering-Correlation-Id: bb32a9b9-5184-487f-ec18-08ddc5cb810b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|8096899003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?R0htRmhQRkpGOXZyWC9IMWV5NHJJbDdwdHJvMm14R0RhbEJMeXNzZnl6cEY2?=
 =?utf-8?B?a1FoaUgzL25vWjkvbVdYZ0FNWEFmdWJpeWJ2T1NWSEVtTEtQbE9nTXlFWUNJ?=
 =?utf-8?B?UTY1YWRnSjdNRCswRjJZL1BsSGNPY3ZMRk5xU3hQYkVzTENscmlmdk5XclpK?=
 =?utf-8?B?NjUxaHlkUTNlNGxwYTFReDhhVkNDN1RIVkdBc3h1dnJ1RDdNQVlYVHBFNGpM?=
 =?utf-8?B?b0s0cjVEdFlhYWFUak9zeXBROEFtWkwyRlVSWnNKUmhuMmRMeHY2R25JMkJ1?=
 =?utf-8?B?SGN1ZmR4ZTJrOGZvdWNZUXd1QUFpY28wVkgyNTVFTFZ2VG5iR2gvamh4aFo5?=
 =?utf-8?B?MUxmeWc2bWgzWU9vUGNnK1Fsekk4RWRXc0hQY3BobmJoWDVIMkhmNlJUdFZN?=
 =?utf-8?B?Tlh1MjJuYlBab0NYb0dRL2RzV2tOVXNhQTZ0WDAvNmRVQ1lHcnpiMjg1ZWwr?=
 =?utf-8?B?a3pldkdSTXgyUjRsVFZlRVRKbFg4QkJnTUJnanh1NklMUG1pY01GZjBhQitH?=
 =?utf-8?B?TFJWUWpRWHUxc3lzdGpFY2hGZTBpWHF3M2tlc0xvQllqY01KL3R6ZHhYYW9V?=
 =?utf-8?B?LytwL095Wk9wSzNyM0s4SlhEYjJIYWR3bndBWVJBdXFVbmUyT1F4SVp5SUcz?=
 =?utf-8?B?N3h6bGlWNVVNN0k5a2JUS3ZDV1RtSTZXRE91aS9TdHdmRm12ZGJRcDZqaWFh?=
 =?utf-8?B?RERlM0tDM0lUWlRPTmpqREFNY1l4ZS9TVUwxMllCOXpRRi9TSlNmcDhKV0JH?=
 =?utf-8?B?bzUvUWJBQXRWWjZyNS9pNWlPbjJaV0paclllRWpOMUl1dHJWS1RBbjZPQnFF?=
 =?utf-8?B?VWF6S0E4OWNZZmYxT3NkRDk2MkFWNXYza2k2VEtMc3hRY2dRbEl3VTg3RDYr?=
 =?utf-8?B?Z3BhTWlHRWtXc3dVcmNvdGhxeXphN1hPazdQaXBsc0E2UTZlYlhrdmJ0czJm?=
 =?utf-8?B?YWF1RlFWdWZMV1BIVW5kZFdnMjQxZUYxdXd0VHg4YkUvMDRiRCt3aEFhU2FH?=
 =?utf-8?B?Sml2My9LTjYxdXpXSDJtSXdid3VBQW95emowb2tJdEl0N1hiUXZvYWR2SUto?=
 =?utf-8?B?cG1JY2cxRmdXUmxmTkgzTzYrNHY1ZzVYbng1N1ZqMnZHYUNOaXdJcURzbTFC?=
 =?utf-8?B?eHRkK3FkSHNSaVNxZlhlT0g3eU9WbVlsbkR4QXk2bFlMc3ppTXBHSkJzVWpC?=
 =?utf-8?B?QkhiY3NzM0lRNTNRa2pCc0R0NEhyTkc5MXJ4Vm9SZ0RENWJ0WEtOWHAreGFI?=
 =?utf-8?B?UjNCdnRaMzFGVTFORFhGL3pEUCt6WjlIdXNIU0FpSjlySlZUMEVQeDliaDBj?=
 =?utf-8?B?OHFUTHZMYUxsVHJZaTl5dTFEelg2NE9EM2EvcUVLU0VpT0ZXWXBUL0ovZUFv?=
 =?utf-8?B?TkNrTm5udWtBMU9OWmt2Wllnd2lRaVBQWnZTL1dxbm5pbCtZMkxWcU9EaTFX?=
 =?utf-8?B?cmlrMFBxTVRPTDZhL1pYY3pqbTdXakdtQXk3NEFJZnZzYnNnWHVzNGtzVkh6?=
 =?utf-8?B?dzdxMkJRYW9TTUI0Y0FGNVFNcjNDUWdmSEJqbTJNc2RVSGNNY3lGNDNucFZx?=
 =?utf-8?B?U2Q1QTgwTHFFYlJocjY5aUtTMy9FZHZWaWZNRGpGR2lpU0RKOE93WU9Xek54?=
 =?utf-8?B?eG9nK0dYWkpsY2JIWGVZaEpITVVPS3hkWGszRlF4UzJpcWhtUzhBQ0Z3MThI?=
 =?utf-8?B?THFyVGMrWGpmWWVSbHQ4S0xkVExHbHJyQ3VUcmRLcmR1MnNTUjRSWlBITFNE?=
 =?utf-8?B?ZjRXMFl0UWtWdEdPVWcwMTZKZmk4Rm9xRXNBMURIR2htRzVuQTQydHIwRm5K?=
 =?utf-8?Q?d900C5TMXKt0wgYIhsNq12ZL+bZIGNQzlyX+I=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7608.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V0NZNkM2RkthNVVGLytLVms3cHVnSzh2MisvMG1Yb1lEZFVjcHp3OTdMcXFC?=
 =?utf-8?B?NnBVYmV4b09RVGM4SXVQOW5WL0Z2ME9BQ1dzdWJERjlzVnNETGtkUE5SVFdS?=
 =?utf-8?B?d25ocmpiVFJhVzFvZ1pnSEpnMjhKcEg3Wk5vdlRZWUc3aFdjSVNoREI1aXBq?=
 =?utf-8?B?R2RXUHhPK3BycDQvQmh6dnhQL0J0UC9HQWdIaUdCWEt0eEtISzErWnAwTVdo?=
 =?utf-8?B?S0hkQjEzc0NvOTU3eWNxdVkrSDU1Z29Oc29JTnhqcG1GZHhyWDZ2T085cXlv?=
 =?utf-8?B?WnZ3K0hCWW9wTjJrazhXanZkTFBPbmZMdVpRc0JseExKVnozYlZ4R1FqL2tV?=
 =?utf-8?B?LzZyVTdIY2VodjNLY0JETE9sKzV3NXVRSFRjRGdPb3VaV0dmK2tDdkdNa3B1?=
 =?utf-8?B?VVpCNGZNU0NIaEpOeUc5VTQ3VkpPRUNZL0F0aWwrN2dtMk8zdHNtZFlkdVhY?=
 =?utf-8?B?ZG5oZCs0b2NTa0wyMFkrbUQ5aFhZSDdEdTZ1T29JVDRDcytZK2cxZER3RzVG?=
 =?utf-8?B?M2xwREtTeHVJK2JBcXoyNnVnaU40clJrWTFkQlZIUkU4M202SVRxb2RGOXp4?=
 =?utf-8?B?bmllWi9UVlRCWTBWN0pLaStHZDNzbEkraC96NnpJeFNyU0JETjJEQ0xISFhZ?=
 =?utf-8?B?aGlIKzVUSGpldkttUkxKRWxhSnFlTVRUSmJ4UFdqUnlCK2kvdlM4ZFVoc3FJ?=
 =?utf-8?B?UjVkczU3ZHlzYVp1VDl0VnpWK3NqVVFrdWdiNVU1Z2FkbWdydGpUc1N3NUNV?=
 =?utf-8?B?SVdPZW1qTHhpK2FkbVo3a2dmNnNPWXZ1aGlmdmxRNHhORFpTQmUvRkhUdE9r?=
 =?utf-8?B?MllVRDhQNEtnOUswbTVLTDljUHJjTTZGV1JRRHBOODhTbHlaMjUzc2Rtd1Vr?=
 =?utf-8?B?NHFtb3JGV2tuY1pSVTZNT0VWOGFhcXVGNWliSGFhKzFROElmWGZYKzdNVWpj?=
 =?utf-8?B?cDhzTE52R3MvNVRvL2NBbXBOMGZVZktKNXY4a0NYeWFnWTRnMytEajkrekRF?=
 =?utf-8?B?Tm9vYlJMRElEUnZITEMwbm1pSFEydHJENFo3OU9vUFBzditic1JQbEdiQjZj?=
 =?utf-8?B?cXdHUlozRE5DUXg5ODc4Vjk2bFZjOFdzYllrRDhadStQVDJ4R1dYR0RJbWV6?=
 =?utf-8?B?RVNOSElZQUtGcWxLek1oUnJoY3JXTUdBRk1nTkdNY0dsY0kzbVZNMy81MW15?=
 =?utf-8?B?RmQ3akFIU1doUVNCNlU5WXYzQk1KQ1lWSm9UL0h5eDFlenQ5TUJ5MkN5eVVD?=
 =?utf-8?B?UEZGZjBqcGF5THhycWZETzFwSnI5aElkVzRUbEFsbzZhNHBHNktPV2hlU2la?=
 =?utf-8?B?UVA2MHlCMTduUHdKMTBYRUNWTnlXem1IcktZWGRrUnpRd083TTRzOHpCNk9J?=
 =?utf-8?B?VFUrckNwbEsvZTRnUW1CWjFweXE0Z2RpWEI0Z1VOTlVBMENPTW05RGxVaFFo?=
 =?utf-8?B?MFBqeGUyTVQzSHYwRkRWN1Z3OGc3TWhOVXJYTW5FNXVRV0l0bUhycGJkam5j?=
 =?utf-8?B?bHdrZWZ0K3dKeDN5SXBTKzZiUTlnTis5eDlTc09RaWJCV3dSZU9WRzd1TlhB?=
 =?utf-8?B?Z0gxaVFraWFEYXljenllbDJUYU9iSkVXdVlpY0JlamJKTTh1dWhRNlZ2cXNV?=
 =?utf-8?B?KzFnV1lIN2FNcVArRXprUll4dnJiTUNFQWpMYVFVcEF5ZW1iNlVhWEdocmsw?=
 =?utf-8?B?ajU1SE1uSWFlNlcwSkJRTzRmSUNhOEdZNm4wb0wzOHBWa0tjTEZmaE9pWnEv?=
 =?utf-8?B?UEpYaGVaeEJrLzdXMFQrcnlIV2drTkJZSWhBc3ZLbHEwbmxHQmxVcXBSQmJX?=
 =?utf-8?B?WFFacGo1WnpJSHk2akdpMVE5eWhwdW1yU21CWUVnc1pJaUkzUmxieldQQ3Z1?=
 =?utf-8?B?bFNneXZ5MmtuV24rWTNKR2JMUzZ3SDA3Q1c3RVdWUGFsSVRtMFdUdExiLzRY?=
 =?utf-8?B?MmtiWnVPWTAyQUJBRFlQS2pOaUhWT09JYXpiTFZ1YjUxeWtKNkUwTXNodU1D?=
 =?utf-8?B?S3hYc3FzNDRJRHg3SDZYMngvMTBEMTloZ1craVZySjZTb2QvOGlWYWpQOGhH?=
 =?utf-8?B?T0hMMXJnUzRrV0RrZzZPNlIvNkJ3YWZqNmF6QkJpMmFvTlU0ck95NFUvS3Va?=
 =?utf-8?B?MDRIdnFBOGxsSnRYYkVObE8zbHFkMW9QQ1htSzdtSU9DUVRIdEVEU1hhdkdj?=
 =?utf-8?B?OHc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb32a9b9-5184-487f-ec18-08ddc5cb810b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7608.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 07:19:59.2709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55y6MOwhmuBNd2mf3gfzORDWom86WQWiKqQHDnf22f3AxbCeYP0O0Gw5ifY5UxeQyrqZKPwjl/PzDwXt5yTGAAS+ncOa9T+6QHx1p8rS1ms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9112
X-Authority-Analysis: v=2.4 cv=BfbY0qt2 c=1 sm=1 tr=0 ts=6879f5a2 cx=c_pps
 a=QqSBEdqS7BUxypinyQlWrQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8 a=8YJVmSgVRgQCGhplgdoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pGLkceISAAAA:8 a=wvPkM9v7g1_ikmSEda4A:9
 a=wbbcaOkhBgTv6H8j:21 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: OhLgV5j3aepotOnXzv72ihmOUU_TMt-7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDAwMiBTYWx0ZWRfX7hkzHMP7Bu8M
 oKrYC3QwQdcI3gfaK0Efr9P33KDcybz08dEgoHmWUegNTk8cd3ayyJP2iDVv3afml63ipqVOSNR
 /33MB0Jyn2iWR2WHyGy8y2lOS1FaV9nbgRsYHzqY4M6HN/bGeKQe/n+iifzUjBxhB01zMS1k08L
 ycKAPKpTbctjOFvJVNNVy5rKPI6xN6e3Z+HJdK8yFh3fjFZ4DgXJ8eBk+FookMqOP3f/MhS7wAj
 U/FS9oBy7UDKEhV2Ik46F1S7lLtx2El7lY0thHXboVunyaxwLiL8u0lGXVgXgTNFlxHO23kvgK7
 u+h/rDTNgyV372mEcPCrSCKPdi57r5ABGkfm1KZC3x9SwEEioVWy/FfJf7/ClycdxhK8e9A7xqu
 WtWxJ7D/
X-Proofpoint-ORIG-GUID: OhLgV5j3aepotOnXzv72ihmOUU_TMt-7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 phishscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2507180002
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 18 Jul 2025 07:20:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1810

--------------30PTUzN6Izb6S0wfgNDROu0y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 56I4t8u32379375

On 7/18/25 15:12, Martin Jansa wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender =
and know the content is safe.
>
> On Wed, Jul 16, 2025 at 9:06=E2=80=AFAM Hongxu Jia<hongxu.jia@windriver=
.com>  wrote:
>> On 7/16/25 14:49, Martin Jansa wrote:
>>> CAUTION: This email comes from a non Wind River email account!
>>> Do not click links or open attachments unless you recognize the sende=
r and know the content is safe.
>>>
>>> Hongxu Jia looks like you've created very similar commits for
>>> whinlatter compatibility recently.
>>>
>>> Do you monitor this ML for meta-tensorflow changes?
>> Sorry for the missing, I will take care of it next time
> OK, will try to remember to Cc you directly if I'm sending some
> meta-tensorflow patches in future.
>
> Can you please check what happened with master branch? there was
> 27237386b61 classes/bazel.bbclass: remove PSEUDO_IGNORE_PATHS
> around 2 days ago and now it's gone, did you remove it and
> force-pushed master (please don't do that, pushing new revert commit
> instead would be appreciated) or did it disappear due to some syncing
> issues in infrastructure?
>
> I have noticed because our CI is failing either to fetch 27237386b61
> or trying to "upgrade" from 27237386b61 to previous eb5054ccf48
> without any git log between them.

Got [27237386b61 classes/bazel.bbclass: remove PSEUDO_IGNORE_PATHS]=20
back, there is a web hook in github to sync with=20
https://git.yoctoproject.org/meta-tensorflow

You could git pull to latest

//Hongxu

--------------30PTUzN6Izb6S0wfgNDROu0y
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 56I4t8u32379375

<!DOCTYPE html><html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body>
    <div class=3D"moz-cite-prefix">On 7/18/25 15:12, Martin Jansa wrote:<=
br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:CA+chaQcakdJhrJMVjpx1pm_KsZ8J3N=
2cvg25Qc-DL2vLxbwGiA@mail.gmail.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">CAUTION: This email comes fr=
om a non Wind River email account!
Do not click links or open attachments unless you recognize the sender an=
d know the content is safe.

On Wed, Jul 16, 2025 at 9:06=E2=80=AFAM Hongxu Jia <a class=3D"moz-txt-li=
nk-rfc2396E" href=3D"mailto:hongxu.jia@windriver.com">&lt;hongxu.jia@wind=
river.com&gt;</a> wrote:
</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">
On 7/16/25 14:49, Martin Jansa wrote:
</pre>
        <blockquote type=3D"cite">
          <pre class=3D"moz-quote-pre" wrap=3D"">CAUTION: This email come=
s from a non Wind River email account!
Do not click links or open attachments unless you recognize the sender an=
d know the content is safe.

Hongxu Jia looks like you've created very similar commits for
whinlatter compatibility recently.

Do you monitor this ML for meta-tensorflow changes?
</pre>
        </blockquote>
        <pre class=3D"moz-quote-pre" wrap=3D"">
Sorry for the missing, I will take care of it next time
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
OK, will try to remember to Cc you directly if I'm sending some
meta-tensorflow patches in future.

Can you please check what happened with master branch? there was
27237386b61 classes/bazel.bbclass: remove PSEUDO_IGNORE_PATHS
around 2 days ago and now it's gone, did you remove it and
force-pushed master (please don't do that, pushing new revert commit
instead would be appreciated) or did it disappear due to some syncing
issues in infrastructure?

I have noticed because our CI is failing either to fetch 27237386b61
or trying to &quot;upgrade&quot; from 27237386b61 to previous eb5054ccf48
without any git log between them.
</pre>
    </blockquote>
    <p>Got [<span style=3D"white-space: pre-wrap">27237386b61 classes/baz=
el.bbclass: remove PSEUDO_IGNORE_PATHS</span>]
      back, there is a web hook in github to sync with <a rel=3D"vcs-git"=
 href=3D"https://git.yoctoproject.org/meta-tensorflow" title=3D"meta-tens=
orflow Git repository" class=3D"moz-txt-link-freetext">https://git.yoctop=
roject.org/meta-tensorflow</a></p>
    <p>You could git pull to latest<br>
    </p>
    <p>//Hongxu<br>
    </p>
  </body>
</html>

--------------30PTUzN6Izb6S0wfgNDROu0y--

