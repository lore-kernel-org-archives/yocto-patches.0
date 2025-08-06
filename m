Return-Path: <hongxu.jia@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81960C87FD1
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 06:50:00 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.19214.1754462997663030053
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 05 Aug 2025 23:49:57 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=03131ae2d3=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 5766S0NN3085704;
	Tue, 5 Aug 2025 23:49:56 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48bpy9rhym-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 23:49:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mAuXQE3OfnJazy8xE36hBFoYQHxVpi9ZkZacApaanzpf1ojy8KKAsPOS6Jevk5pVlhiEO5R803ElaJPmzPOuhtdYi5Ua4IaG/EiqFMAC6o89jZWAkReVNt93bkIkfFDVz1JDA8L9JwzuzyMhbwU6hyhao2AtEWJasJn5EDi8bOkUgrzbF3qLB3cOdx08yYxcouqRvZkaA2jrKR1ZQZUHN5GjTHBX5WbLh1UcfaqRGEx2COkUpiqz5PjNqfN6vQx6KAFF0bbWJbeWX1Ngu+bpJXiIHcMWhIpfrDEa3uL8M/ax8d//klnzEUdkgu76NI9wni+wzc/utrwNVgYMRscrxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Kxg4cbf3XetAp86tBnhgkNE6ce1srRZkRP9VFtX4GM=;
 b=GPNVR3He0zdjpJxj1sfomrT/xabvYaGJqUie1jF8P/toPPKz0I+018Fo2Ts19L2K09Ozg4JqEmLkLzP5KTlc6qISyeP3eaP/q54W1S50nw1JEb4rRlv2ZQt0GmUomO30JB5VfQpCEt4NZQLrUBasScgPzrqDMZTTnm+UQcWFkA7Qp+CMrqyPjba3Xb1ow1ZPFkCiNEpk98Ok4y6asr+fVkLsn6wz12Yvlrw9sDubXL3VTM6+WQUUG3v0mtrURAKbjQoqhUL6Ki7sXc0ejr5cY2wLY9lx10mkbEEKlDS7/R/nEn6lYbbaQ24dPnZ+zOAEbp/Nzjimqr2LgA9JOjlQYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20)
 by SA3PR11MB7533.namprd11.prod.outlook.com (2603:10b6:806:306::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Wed, 6 Aug
 2025 06:49:54 +0000
Received: from PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::ef64:bc9f:eb8c:e6e]) by PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::ef64:bc9f:eb8c:e6e%5]) with mapi id 15.20.8989.020; Wed, 6 Aug 2025
 06:49:54 +0000
Content-Type: multipart/alternative;
 boundary="------------rBYzaPu0iaU6auAygj0dv0lL"
Message-ID: <01cd37ad-9fdf-4335-8488-9538bfa83a4f@windriver.com>
Date: Wed, 6 Aug 2025 14:49:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-tensorflow][PATCH 2/3] bazel-native: adapt to UNPACKDIR
 changes - avoid WORKDIR/sources
To: Martin Jansa <martin.jansa@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org
References: <20250708072436.24522-1-martin.jansa@gmail.com>
 <20250708072436.24522-2-martin.jansa@gmail.com>
 <CA+chaQdVAzm8au9RXWgY01gwwWO_qxO6LLM=ThTOwzWU8MrUgQ@mail.gmail.com>
 <519af080-65b3-4e68-928c-a2c5c087a5b6@windriver.com>
 <CA+chaQcakdJhrJMVjpx1pm_KsZ8J3N2cvg25Qc-DL2vLxbwGiA@mail.gmail.com>
 <83eb4dbb-2a6e-491f-a02e-e3ca9bba61bc@windriver.com>
 <CA+chaQc_ci6hdKyt1mintWMH=7bpxNvy_gF5oh+x0j_qqGwErA@mail.gmail.com>
Content-Language: en-US
From: Hongxu Jia <hongxu.jia@windriver.com>
In-Reply-To: <CA+chaQc_ci6hdKyt1mintWMH=7bpxNvy_gF5oh+x0j_qqGwErA@mail.gmail.com>
X-ClientProxiedBy: SI2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:195::9) To PH7PR11MB7608.namprd11.prod.outlook.com
 (2603:10b6:510:269::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7608:EE_|SA3PR11MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: e8635638-154b-4558-29ef-08ddd4b572cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|8096899003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SHpKN0Q4dDBEeVdUUTJSZTNYbHIvbEhzcWdZU3ZudnFteHJFM0ZRK2xHYmdm?=
 =?utf-8?B?RHRpejJpSUl4dHFJRjZ4NTVpYnRJYzRsMDNqcmRoeCtvMGVsaVJEbGtFS1Q4?=
 =?utf-8?B?dHFYVlhGMGJMdXowdTVDNkdMcWw1cnNGQm54akllQWJpTmRnZllvT3JmNmoy?=
 =?utf-8?B?VGNwTEExQkdpajNBZ2tFSHV3V0FTdGxZWmRMMGc5MEYrNlhHWFhQMzNNNm1T?=
 =?utf-8?B?YTI3R3RWNzlnc0JkZnlZUWdDSHNzZUJWV3BZVFZ5VTl6Qzl1VlB1V3hQMk5i?=
 =?utf-8?B?cURTeWZhaW95Ym5jckoyUDVzWFJwZ25hTDB6VzBvK3VlbDQwWDZUSlJ1N2FS?=
 =?utf-8?B?MzEza1JsZ2Q4cEI5OElKa1czMDdLRDltU0VVekRxNnczUDB3MU5DSXplQmhk?=
 =?utf-8?B?TGQxdlN5dHA4RUg0Z1lTbEdaOWFlZTlNbnM3UmZYQUNMTG04ejl6NzVEd2to?=
 =?utf-8?B?eElVT3ZtbXZ4TlgxK2NiQTQ2bXVibURGNXFoQ25EMm0wYklLb2RNYmZVRGRT?=
 =?utf-8?B?NVIyMzVZajU0eDN0V2xra09OcytWNWJ0OXM5NmFuM0RvRzl2RTJ3Nm1aR3pN?=
 =?utf-8?B?S1N2OGM4OFZVc1VPbTFJSG4vQzRqUVBZcVVmNEh4a3p3WllkYWJlTGFtRFlC?=
 =?utf-8?B?SStSVW84VlVpN3poS0xqLzFKdXdJbjF6RE1GUThVbnlSKzQvM3Z1Ukl3eHlC?=
 =?utf-8?B?MzZZOThEZ3lSWHN6cllJazlucXFTRE0zUld4L2tqWjVBcmpVOVc1aU1JZ0kv?=
 =?utf-8?B?M0VQMDJVSllTWnlDeGd0bVpZdzVXMGRBZVZVbEV1d3VzVkR3aDlkckFpUjZ4?=
 =?utf-8?B?aVNyNFlHQUpLSDB1Qjd3dkNMUUtydWlHeExRT2diV2VXV1ZHbllFbTYwLzQ1?=
 =?utf-8?B?bnNhVThrZUE1eFFhbVJDM1BsRjRUWjZhQnJXYWo5TytuNkVBNFphTzR4MGpj?=
 =?utf-8?B?ZStuWXdaM3hRaVp0MVZCT1FBb21vVk1pWXJ1d1RsVyszeFdJSTlQMjZMYStj?=
 =?utf-8?B?RDlFWmJUMUNvUXRDSFlvREpSa2lMQnEwYkNTVW5va1VnRGFtenV1bVVOZDF0?=
 =?utf-8?B?SW05RG5mNlNoaFM3eDBuVDZxbnEvUDJCUXErWHNHS3ZsNXpubG9xMDJsY1BH?=
 =?utf-8?B?TVUzYVRlV0Q5QVY0MmdwRGxrMUV4bGZvWXFEaFB4MSsxUEJHNDJ5UWZaR0kr?=
 =?utf-8?B?UFFUU1dBSDV0RVdEcHBiTDRyT2ZVVlplUjdzaHBtd2M2Ni9iblB1Q2puZVhK?=
 =?utf-8?B?UGU5dnRGcjBlZHNoa0JjTnVmYnp5bitENDIvYmkxV1RmNm5BTVJQWktNSTRM?=
 =?utf-8?B?UzV1cHNHRTQxSGRWbFJDSFJFWDdBdXBWLzc2UWQvZDJXMFNLYjZSZmt5Y1lF?=
 =?utf-8?B?ZEdEdDFQcWIxRk5qNCtDMyt1YUU3czBIL2R3SzB2MWVZdkNMM3BVTEczUFJq?=
 =?utf-8?B?SHByOGFUUFIvSE9saHBmVU1pYlpXZWQyNmVRR2xLMnpjdTdiSDM5RWZxZnJj?=
 =?utf-8?B?bUdoVjM3MmRqem13a2N2UVJJc0E0b3VkdjhhSVhRQlZVWFpwN0IweVZmY0xJ?=
 =?utf-8?B?c0V1L0QvUlR0cWZkdWVmSy95OWRRVFplWUVSaTRIamVFblA3eWZGdGNFeWo5?=
 =?utf-8?B?eGdqS3Y5TVVsbjlOVlk3NFdLKzF6MTZmYXo0dlBJcEE5RVdSQklyY0NvQkdV?=
 =?utf-8?B?RlNTVk51VWI4bDJkbkpCMTJMMlRtcmZQTlFDSGNydUFkRDJxUFRUYzNMT1Zs?=
 =?utf-8?B?Ui9mVnRTTERrRFl4UHBRYS83blpxa0pCOXlCTnhTRTBQQXJLWm1TcVEydENq?=
 =?utf-8?Q?T5t2C7Nl09ODNCq5MnRrykt0BzBhPo5KZSU+A=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7608.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Mm5VRVFPdjE3U0NYZ3F4RlVyMHNHSDRlY1YyS1lLNXFHelQzRGFGRWNIcFdk?=
 =?utf-8?B?WXlHK1VNKzYyUHFlRmVmTEtqYnpOaTBkUjkvcmY3KzczL1JIaWhXbnNvc1cv?=
 =?utf-8?B?dVQzRUVkdkxISFdkMG1uMEx4RXIwSkprbVFkcUpmdExUUTJHZDhJQzNHbDc2?=
 =?utf-8?B?WElIbFhqKzJlVXRRUDk5UGw3VDg5OW5YWDFGVlBmTG9JNXBnY2d5RDV4a1p6?=
 =?utf-8?B?SjVvMlBlZlZMdldXWHAxN1ZRcWVpQitqaEFqVXBFUlYwVzUxcVV3SXVEdDhM?=
 =?utf-8?B?TEtxVzF2aEllYkdOVWJmdHpGZTQ4bzZWVXY5M0lSK25nQ3drYWtSc08wUkZ3?=
 =?utf-8?B?UFdPSHd3dzBIbGRwQTdRWS9xOFBRRVpkcUZ0ejZ0V0x3d05EQnBDY01GeENM?=
 =?utf-8?B?V25wbnpPNUczNXpJeG1pUjdRSnhjeGxUYmZYQlpQUzJpTnFuczBlVCtKcy9W?=
 =?utf-8?B?dUNRUDZnQUkvbktLQkpadnJqSnRSaGR5SnlzMlQ0alZ4S25FZ3hDdWRRelc0?=
 =?utf-8?B?QmxhekNxQTBEeUlLL1JDb255NlU4eDZ4Q2tLZW5xM0xKRU4waGx5MGZTdnRp?=
 =?utf-8?B?VDRjV0dEN2FqdXhIMjBjVUxWeEx3Z0I4aTVhZE1YTUprY1NKNWJWcmdvZkdN?=
 =?utf-8?B?VEFnUFB6SkJJK3JId0UxelVFY2lGd3VDV0twTFRPYU10ZG4zQTZUbWxPdzRI?=
 =?utf-8?B?OEhER0thYW52UUw4WkMxN2F3NHJKS1NBcGxub0ltRzMxZEdZWjZhelZmVXQy?=
 =?utf-8?B?aEsrQ0MvZ2ZZWCsrczk1ems2dlBvbEExYWlPZXFWam0yb0NkMkJSaVl3REho?=
 =?utf-8?B?a3BCeTk1QVZjSnlHZVVyNmcyUzRwcnF5WG0wcHpoajR2K0ZlQWpNY2JoWHhx?=
 =?utf-8?B?eFA1bWFSV0xESDFjVnRaL2dzY29Ib3ptdU9ia0JhclZFQ3BYMFNiNE1vUXBF?=
 =?utf-8?B?MXJTQldkT2hKN2VuRloyWFpkc29WTUo1RUJaRG5JR1JqdFFGVjVNRnhSdTJU?=
 =?utf-8?B?NTJDa0Z0U1JxTkFtdUo2OXJrcnBBcStmRXFxci92V3VOMUV5c3Izb21FSGNq?=
 =?utf-8?B?TndwUi95MFBXQmFhTUw5SSthSkZHYU9kV0ZGN2FTRStMUU1CQ1oyYi9XQ2RT?=
 =?utf-8?B?ZmdtaHNhSTE4dkkxc2s0dzVidE1vM0pwNEsrTWFKVHd3R0thVnRacmZqQXRC?=
 =?utf-8?B?YWNyay9tSUkzdXREaXRoSmZtV2NsNWppbHVmdWNYY2NjL09mMzNJYWRZVW02?=
 =?utf-8?B?VmV2Tnlrb2xWalFYaVdtSUN3SzU5ODA4SGZLeGFkQmtiT09iRGk2VnJIQzhR?=
 =?utf-8?B?UlEzemhMQllxSytnSHI3MzJWbVNLaDZ2TlluYkJPcHYwTFZhblJ1YVBoTVJC?=
 =?utf-8?B?Z0tjRlUxOFBHNVhvYTc4dEJ0RlMwUjZ4aUFFaS9BVjR3N0c4bTRFZ09zYTNV?=
 =?utf-8?B?MjIyS1dJckY5Mjcvd3NlNUZQT0RoMCt6YnVPVktvdlBwRngwcDF5T1hQbWVJ?=
 =?utf-8?B?ejV6RU9FbUIwSEM0RndlclVXQUc0b0lGSXNDVFU1SDdCSCs0Vno4ZjEvYmpE?=
 =?utf-8?B?RjlmNmxJRFVpU2RmbjQwUlhWYVNZZEYwNjlTa3l2ckRhK0QwS3M5L2wvQkJ2?=
 =?utf-8?B?c0ZNREpoTVVrTmR0bWRKM0FkTGU4WHFQREVzQUpBR0grL2Q0a0hTUWNjbDI4?=
 =?utf-8?B?cXpqL3d2VXFoeUZta0g5c04wWUNkaldneUVWTGdXMVBWRDhwaCs3NjNQYnlL?=
 =?utf-8?B?YS9odTgyTWxLRWtSVTdsNWFQK0ZxZE5IcHJrbEk0VmtLcE1RVTN0QmJkNUNC?=
 =?utf-8?B?UnVCMThyK1pVL3paUFQ5NmJ1N1pSZlcvd0s3NXBQNDl3eGM2S1hXTTYvM2Ja?=
 =?utf-8?B?ODdMRjlIaklveW5TU3NXbzFnUGw3VklITU5LWHZ0c1NIdUg5V2xYYnZoUXdM?=
 =?utf-8?B?SjR6RmFJLzF5V1ZQY0w3aVdwUzM1aDJCeElUY2FwQWwyKzVLOWM0SlVnUk1M?=
 =?utf-8?B?eUp2VkFTM1dHZ1JVR2htOXNMRVFERlduS0krTm05ZWthM1F4c0lHZlJoM0hR?=
 =?utf-8?B?QUcybFJkd1RLTkpCTlp1Sys3SjZETnpEZHJXdXQrTXlFZjI4SFp5UVFGZUc1?=
 =?utf-8?B?WmthODFXZ3JOS3N3dSs3U2lZVVNmZDBzc2g4dUx3amlBWWFIU0o1Y2RidU0r?=
 =?utf-8?B?RHc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8635638-154b-4558-29ef-08ddd4b572cf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7608.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 06:49:53.9779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tkvuHd3MGkSbHvu54HkKUwN2HCmuMCEERFJ+fdv17/iOh2vfKzSbf5FGjmcQn62LFpvHo3kPaD091lOLDURHBtP7q4gNa4xALTdoes7miXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7533
X-Authority-Analysis: v=2.4 cv=AbaxH2XG c=1 sm=1 tr=0 ts=6892fb14 cx=c_pps
 a=TRH5P6HyeEnkyzWJPw2o8A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8
 a=Pxit7gfDrbB0Lm1fM1EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pGLkceISAAAA:8
 a=UBFVfQAFWYhimOpKR3UA:9 a=yNM0xOwM9urM6ZGd:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: j-ycem_csHrwgHktMQXLJCVF7O3yWIty
X-Proofpoint-ORIG-GUID: j-ycem_csHrwgHktMQXLJCVF7O3yWIty
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA0MCBTYWx0ZWRfX+37AmHmvxApy
 K/XirRSCENS1wu9uA2lhk+sWgQ7f/3ZpUN9Qj/7pneNuaNfDqoTsUD5Bbavg8B8ZDxPtkKH9tH/
 xVBXK7qRm8bLfjWAzXKxedZw1DtbabbsoYAO3qd4cMmCA6xcz52usLoDrujizqxlzsY+m5TWYL+
 aCQY8YIs9iDEtXIuAT9EOGZpoMYt45tGt6kPrC0DkAGFnWLg5EvkiK47Ep8OPl4nyxhIImP4xFj
 2B+w1ubgqgBUQytmqLx6RxykZaAmto4APiBEyZGkYIbth8jVTNdHemMNgbxdBkiUAto6NNdyeJn
 SlwnscSlSYEEHM6xwTQ5EdemFP5r5JYsQ9CunWGVUPGn5DBsYBLF1v5n/QotL0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_01,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 06 Aug 2025 06:50:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1889

--------------rBYzaPu0iaU6auAygj0dv0lL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 5766S0NN3085704

On 8/6/25 14:36, Martin Jansa wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender =
and know the content is safe.
>
> Hi,
> can you check whinlatter branch? It's out of sync with master branch
> 27237386b61 classes/bazel.bbclass: remove PSEUDO_IGNORE_PATHS
> was now removed in whinlatter branch (as it was previously removed
> from master branch and then restored).
>
> Fetching origin
> Fromhttps://git.yoctoproject.org/meta-tensorflow
>     2723738..38cfa43  master     -> origin/master
>     024c8dd..5865dad  walnascar  -> origin/walnascar
>   + 2723738...f1e0f9d whinlatter -> origin/whinlatter  (forced update)

Sorry for the out of sync, I've manually sync whinlatter and master

//Hongxu

> docker-lge @ ~/layers/meta-tensorflow $ git log --oneline 2723738..38cf=
a43
> 38cfa43 (origin/master, origin/HEAD, g/master, g/HEAD) tensorflow.inc:
> fix compile fail with DEBUG_BUILD =3D "1" for cortexa53
> docker-lge @ ~/layers/meta-tensorflow $ git log --oneline 024c8dd..5865=
dad
> 5865dad (origin/walnascar, g/walnascar) tensorflow.inc: fix compile
> fail with DEBUG_BUILD =3D "1" for cortexa53
> docker-lge @ ~/layers/meta-tensorflow $ git log --oneline 2723738...f1e=
0f9d
> f1e0f9d (origin/whinlatter, g/whinlatter) tensorflow.inc: fix compile
> fail with DEBUG_BUILD =3D "1" for cortexa53
> 2723738 (HEAD -> jansa/master, contrib/jansa/master, master)
> classes/bazel.bbclass: remove PSEUDO_IGNORE_PATHS
>
> docker-lge @ ~/layers/meta-tensorflow $ git log --oneline
> origin/master  | head -n 3
> 38cfa43 tensorflow.inc: fix compile fail with DEBUG_BUILD =3D "1" for c=
ortexa53
> 2723738 classes/bazel.bbclass: remove PSEUDO_IGNORE_PATHS
> eb5054c layer.conf: Update to whinlatter release series
>
> docker-lge @ ~/layers/meta-tensorflow $ git log --oneline
> origin/whinlatter  | head -n 3
> f1e0f9d tensorflow.inc: fix compile fail with DEBUG_BUILD =3D "1" for c=
ortexa53
> eb5054c layer.conf: Update to whinlatter release series
> 90d52e2 bazel-native: set S from UNPACKDIR in recipes that use only loc=
al files
>
> docker-lge @ ~/layers/meta-tensorflow $ git diff origin/master origin/w=
hinlatter
> diff --git a/classes/bazel.bbclass b/classes/bazel.bbclass
> index f6585e0..8fca205 100644
> --- a/classes/bazel.bbclass
> +++ b/classes/bazel.bbclass
> @@ -149,6 +149,8 @@ EOF
>
>   EXPORT_FUNCTIONS do_configure
>
> +PSEUDO_IGNORE_PATHS .=3D ",${WORKDIR}/bazel"
> +
>   inherit unsupportarch
>
>   export YOCTO_NATIVE_SYSROOT =3D
> "${BAZEL_OUTPUTBASE_DIR}/external/yocto_compiler/recipe-sysroot-native"
>
> On Fri, Jul 18, 2025 at 9:20=E2=80=AFAM Hongxu Jia<hongxu.jia@windriver=
.com>  wrote:
>> On 7/18/25 15:12, Martin Jansa wrote:
>>
>> CAUTION: This email comes from a non Wind River email account!
>> Do not click links or open attachments unless you recognize the sender=
 and know the content is safe.
>>
>> On Wed, Jul 16, 2025 at 9:06=E2=80=AFAM Hongxu Jia<hongxu.jia@windrive=
r.com>  wrote:
>>
>> On 7/16/25 14:49, Martin Jansa wrote:
>>
>> CAUTION: This email comes from a non Wind River email account!
>> Do not click links or open attachments unless you recognize the sender=
 and know the content is safe.
>>
>> Hongxu Jia looks like you've created very similar commits for
>> whinlatter compatibility recently.
>>
>> Do you monitor this ML for meta-tensorflow changes?
>>
>> Sorry for the missing, I will take care of it next time
>>
>> OK, will try to remember to Cc you directly if I'm sending some
>> meta-tensorflow patches in future.
>>
>> Can you please check what happened with master branch? there was
>> 27237386b61 classes/bazel.bbclass: remove PSEUDO_IGNORE_PATHS
>> around 2 days ago and now it's gone, did you remove it and
>> force-pushed master (please don't do that, pushing new revert commit
>> instead would be appreciated) or did it disappear due to some syncing
>> issues in infrastructure?
>>
>> I have noticed because our CI is failing either to fetch 27237386b61
>> or trying to "upgrade" from 27237386b61 to previous eb5054ccf48
>> without any git log between them.
>>
>> Got [27237386b61 classes/bazel.bbclass: remove PSEUDO_IGNORE_PATHS] ba=
ck, there is a web hook in github to sync withhttps://git.yoctoproject.or=
g/meta-tensorflow
>>
>> You could git pull to latest
>>
>> //Hongxu


--------------rBYzaPu0iaU6auAygj0dv0lL
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 5766S0NN3085704

<!DOCTYPE html><html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body>
    <div class=3D"moz-cite-prefix">On 8/6/25 14:36, Martin Jansa wrote:<b=
r>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:CA+chaQc_ci6hdKyt1mintWMH=3D7bp=
xNvy_gF5oh+x0j_qqGwErA@mail.gmail.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">CAUTION: This email comes fr=
om a non Wind River email account!
Do not click links or open attachments unless you recognize the sender an=
d know the content is safe.

Hi,
can you check whinlatter branch? It's out of sync with master branch
27237386b61 classes/bazel.bbclass: remove PSEUDO_IGNORE_PATHS
was now removed in whinlatter branch (as it was previously removed
from master branch and then restored).

Fetching origin
From <a class=3D"moz-txt-link-freetext" href=3D"https://git.yoctoproject.=
org/meta-tensorflow">https://git.yoctoproject.org/meta-tensorflow</a>
   2723738..38cfa43  master     -&gt; origin/master
   024c8dd..5865dad  walnascar  -&gt; origin/walnascar
 + 2723738...f1e0f9d whinlatter -&gt; origin/whinlatter  (forced update)
</pre>
    </blockquote>
    <p>Sorry for the out of sync, I've manually sync <span style=3D"white=
-space: pre-wrap">whinlatter</span> and master</p>
    <p>//Hongxu<br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:CA+chaQc_ci6hdKyt1mintWMH=3D7bp=
xNvy_gF5oh+x0j_qqGwErA@mail.gmail.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">
docker-lge @ ~/layers/meta-tensorflow $ git log --oneline 2723738..38cfa4=
3
38cfa43 (origin/master, origin/HEAD, g/master, g/HEAD) tensorflow.inc:
fix compile fail with DEBUG_BUILD =3D &quot;1&quot; for cortexa53
docker-lge @ ~/layers/meta-tensorflow $ git log --oneline 024c8dd..5865da=
d
5865dad (origin/walnascar, g/walnascar) tensorflow.inc: fix compile
fail with DEBUG_BUILD =3D &quot;1&quot; for cortexa53
docker-lge @ ~/layers/meta-tensorflow $ git log --oneline 2723738...f1e0f=
9d
f1e0f9d (origin/whinlatter, g/whinlatter) tensorflow.inc: fix compile
fail with DEBUG_BUILD =3D &quot;1&quot; for cortexa53
2723738 (HEAD -&gt; jansa/master, contrib/jansa/master, master)
classes/bazel.bbclass: remove PSEUDO_IGNORE_PATHS

docker-lge @ ~/layers/meta-tensorflow $ git log --oneline
origin/master  | head -n 3
38cfa43 tensorflow.inc: fix compile fail with DEBUG_BUILD =3D &quot;1&quo=
t; for cortexa53
2723738 classes/bazel.bbclass: remove PSEUDO_IGNORE_PATHS
eb5054c layer.conf: Update to whinlatter release series

docker-lge @ ~/layers/meta-tensorflow $ git log --oneline
origin/whinlatter  | head -n 3
f1e0f9d tensorflow.inc: fix compile fail with DEBUG_BUILD =3D &quot;1&quo=
t; for cortexa53
eb5054c layer.conf: Update to whinlatter release series
90d52e2 bazel-native: set S from UNPACKDIR in recipes that use only local=
 files

docker-lge @ ~/layers/meta-tensorflow $ git diff origin/master origin/whi=
nlatter
diff --git a/classes/bazel.bbclass b/classes/bazel.bbclass
index f6585e0..8fca205 100644
--- a/classes/bazel.bbclass
+++ b/classes/bazel.bbclass
@@ -149,6 +149,8 @@ EOF

 EXPORT_FUNCTIONS do_configure

+PSEUDO_IGNORE_PATHS .=3D &quot;,${WORKDIR}/bazel&quot;
+
 inherit unsupportarch

 export YOCTO_NATIVE_SYSROOT =3D
&quot;${BAZEL_OUTPUTBASE_DIR}/external/yocto_compiler/recipe-sysroot-nati=
ve&quot;

On Fri, Jul 18, 2025 at 9:20=E2=80=AFAM Hongxu Jia <a class=3D"moz-txt-li=
nk-rfc2396E" href=3D"mailto:hongxu.jia@windriver.com">&lt;hongxu.jia@wind=
river.com&gt;</a> wrote:
</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">
On 7/18/25 15:12, Martin Jansa wrote:

CAUTION: This email comes from a non Wind River email account!
Do not click links or open attachments unless you recognize the sender an=
d know the content is safe.

On Wed, Jul 16, 2025 at 9:06=E2=80=AFAM Hongxu Jia <a class=3D"moz-txt-li=
nk-rfc2396E" href=3D"mailto:hongxu.jia@windriver.com">&lt;hongxu.jia@wind=
river.com&gt;</a> wrote:

On 7/16/25 14:49, Martin Jansa wrote:

CAUTION: This email comes from a non Wind River email account!
Do not click links or open attachments unless you recognize the sender an=
d know the content is safe.

Hongxu Jia looks like you've created very similar commits for
whinlatter compatibility recently.

Do you monitor this ML for meta-tensorflow changes?

Sorry for the missing, I will take care of it next time

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

Got [27237386b61 classes/bazel.bbclass: remove PSEUDO_IGNORE_PATHS] back,=
 there is a web hook in github to sync with <a class=3D"moz-txt-link-free=
text" href=3D"https://git.yoctoproject.org/meta-tensorflow">https://git.y=
octoproject.org/meta-tensorflow</a>

You could git pull to latest

//Hongxu
</pre>
      </blockquote>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------rBYzaPu0iaU6auAygj0dv0lL--

