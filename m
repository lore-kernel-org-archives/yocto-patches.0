Return-Path: <hongxu.jia@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545A8C83F27
	for <webhook@archiver.kernel.org>; Wed, 16 Jul 2025 07:06:44 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.16140.1752649599685838242
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Jul 2025 00:06:39 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=9292ce061b=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56G1bl8T1044392;
	Wed, 16 Jul 2025 00:06:34 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 47wdvdsk09-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 00:06:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=POM/WhwOeatMthhzqHzUlLf9qLbQZFclM7tSbtsWt+pRP8/+nelBsKtvTPyeote1j8cVH6JmhuM1XaULSqvk508B20vkLnZmRSgpsqcik88ja4kQXIZAkZfja1mMlCBFbEKaXEEIIdN17q8KN7XIMWyFYHjVTKqO15mWZdWRpHUE+yshboMPTzKMfrioZSko4Hh6cEdU4v646xn8Ovjk58sps2Yy/Dqw4iaqqJzj9ErA7Bl/IT6R7jPtFOwMt7ORih2XRg3vNquj3CT/LMQEKzLSOYgXCx2NAzHqRMobwTQRXuZmXHxT3A4F16CA/BwMi2w1knTA183V4rh51aaeYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7biz6Bg1x3q6fyPGPJduWFUqJz7tkZpSVS+NVCGTg0=;
 b=KDRgU4bYfr4oayxLoc4zOsBkbP7cixC9All1FItq92TSl+MUef8Mp95IVVBa/QgHGRmVfShXEtZp39f8pWEzMT0hfGX3tnkV8IuAB7k4A2+JpIjHj4e+va3w4eHMMVZNF9Fof4MwUmtrkJIhlzlyHa7GnOvCBuM01hr82li0NAvGUZbavk1CKEZAcl+e2mAbIP8dgAbnCMdUXQg/A8EzYPBEnmWt1kNhf7Jh9CgARF4+sQdIr6tSwM6kurJjMu//DOKAh7ZUnfNRAwJu7mjH+uWB6WdXjafnIlLrB61r3QPaoGBKFFkdb7SgBkGzapkl1oDCf51Ed2B8my04KDivDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20)
 by CO1PR11MB4788.namprd11.prod.outlook.com (2603:10b6:303:97::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 07:06:31 +0000
Received: from PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::ef64:bc9f:eb8c:e6e]) by PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::ef64:bc9f:eb8c:e6e%6]) with mapi id 15.20.8880.015; Wed, 16 Jul 2025
 07:06:30 +0000
Message-ID: <519af080-65b3-4e68-928c-a2c5c087a5b6@windriver.com>
Date: Wed, 16 Jul 2025 15:06:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-tensorflow][PATCH 2/3] bazel-native: adapt to UNPACKDIR
 changes - avoid WORKDIR/sources
To: Martin Jansa <martin.jansa@gmail.com>,
        yocto-patches@lists.yoctoproject.org
Cc: Martin Jansa <martin2.jansa@lgepartner.com>
References: <20250708072436.24522-1-martin.jansa@gmail.com>
 <20250708072436.24522-2-martin.jansa@gmail.com>
 <CA+chaQdVAzm8au9RXWgY01gwwWO_qxO6LLM=ThTOwzWU8MrUgQ@mail.gmail.com>
Content-Language: en-US
From: Hongxu Jia <hongxu.jia@windriver.com>
In-Reply-To: <CA+chaQdVAzm8au9RXWgY01gwwWO_qxO6LLM=ThTOwzWU8MrUgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SL2P216CA0111.KORP216.PROD.OUTLOOK.COM (2603:1096:101::8)
 To PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7608:EE_|CO1PR11MB4788:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cfc679a-67d2-4186-c202-08ddc4374a26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RlZhTUI4YWFkam9yeDRIQjArbWUyeEhGSEhjR2w3d2lwT2pJWHRZQXhwcngw?=
 =?utf-8?B?U0Z2cGN5RThFQ0hYSko5elJvcXRCR0ZCaWVyY2trNTExbFNWRTRzdGxiYm5L?=
 =?utf-8?B?c1lLYnlQbUlEMzNCYkpCd0tDcjZUeTVZWDBJQ2FXeXU3MU1mOHliTlQvZTRk?=
 =?utf-8?B?eVhYZHU2K0krN0tPanJveXV1ZUIvNHk2b3ZNTVdmSkZwWnd3SFdLbWhuSmNh?=
 =?utf-8?B?OThZMzhmdlRFZlZVdlU3V3hSZFgwUHlHTFFueGxnT1FxTkhGMHlxWHBsTGZY?=
 =?utf-8?B?N1VGWDBSbTRaaitGdEkwcUJIZUtWQlhPUVFtYzFINlh0ZDN4cnIzSG5ubFNs?=
 =?utf-8?B?ODVJRFVnc0RtODlJRXlRZkVXRkY2d29YTEpSRUVTbEdES0xBcEY0N0srcE9G?=
 =?utf-8?B?cTd2d3lmamhadEZyKytiZDhWV3pJL3hWWmtkZ2p1VjhSV29IK0NQVmdqd0dN?=
 =?utf-8?B?UWdGeEh3eUlQeHVSOEEzRGQ2NFk0b0dXdUxHMFJ3djJDeUZpSzVYSzEyUUxs?=
 =?utf-8?B?TkFNMzBsRWsxNkVFRjNYUkJsYUprc1dDRkc2bjlhSWNpWmk3a3pJVU1wbXJx?=
 =?utf-8?B?SVprWXJ0elppR3VSMnY1Rng4TGhyYnBadmExTFA2R3IwdVF4OENHU3YxMEx3?=
 =?utf-8?B?QlYvWHJ5MldnR2krY0FYOEVKWlFFclFWYW9kam9uZjhIL3cyUVNGNlBHeEY1?=
 =?utf-8?B?bVA1UWl6Um5pb0hKamswUkdSWkN1OWNXRjFuN1doVE9URTFmRHlTV09iTW03?=
 =?utf-8?B?Q05GVGdHMFpERlk1eTZWd0tLd25QOFliWVpwSHRMK1Bwd29zOU9HWHZiemJD?=
 =?utf-8?B?RTJxU1NaUGZ3bk9DeTduWFFpakV3QUduYm4zOUNoendlb2oveTBjRzRGQmRB?=
 =?utf-8?B?RHFBdjA5RUxxUTVscnJiSWtSZjhCbkpnQ3E3dHFSRE5HZEFDM3RHMXNxRGZN?=
 =?utf-8?B?UEhRb0QvRDAvTEI1UEh3dzl4VWJLZVVwOVZka0ZOcEM4K2NKNDcrT1JUTUhG?=
 =?utf-8?B?dTE0MFNYV3pSTEVoaFdiL01GRkdCeGFRK3grUTVabHIvQkpYbkE0bGt4ZmxB?=
 =?utf-8?B?THBDbnZYcFZad3pkOXpxS0VLNHRzbTJGa1JsaVkzWXNEYmRzWTArKytmaXZw?=
 =?utf-8?B?WTRQS1NyUGZObTcrYnc1SkZmM2lRSnFsLzMxZ1NNQUlXSkZMYVdLMHRucVlw?=
 =?utf-8?B?VEJhQjFBWWk0SzhUUC9ac0dMMXNlRTBuNS8xdWZhbjZmR2dlRVFyV3NyZ1ha?=
 =?utf-8?B?eWRmcUdhaHRWRkhiTWNlcisvdFdXVjhvZ3JlRzBLVmFLUEVoQVRMem9SZGhO?=
 =?utf-8?B?eFZZdzVqVVVoQ1NoVkgweDlUZGE1Y0ovc0gzeGxScTFNTjFrOFFjcWdWNjZ0?=
 =?utf-8?B?UjhsSHZLSWlCZTU0YmlzaFlTZVFGQVo3dzNyN1V5NTlhY08vOTBBU1cxRVVB?=
 =?utf-8?B?NVZVRmFxKzVnS2hhcGhLN28rcmp1V1pFK0tXM05GWjFLcTl2bGJ5VzR4Qktp?=
 =?utf-8?B?MVRtSnpNOUs0TjhmTUhIeTE1aE8ya29iUE13UXRWT3p6VytabjgrbkloOFFS?=
 =?utf-8?B?dmZaU0dvZjFGcUlHL21Cb2h4cWZyenUrd2VmV21KVk1icW02TFE1QUc5MGpC?=
 =?utf-8?B?OEpURGV0bHZsZkx0YnZPV0VFZnUwNWNvNzEralV2Wkl0WGFJd3VZL0prYjZ2?=
 =?utf-8?B?R3dyOS9Odmo4RVh1SXpnajBoOUx2aWNvRnFObDBkOHp6YmtOSElvQThxbGM3?=
 =?utf-8?B?SmNHUkZhMVpwT3JOZ25HampkQnlGOHdDcHF2T3JtOThuTFpyQlFNVUduN0tJ?=
 =?utf-8?B?U2RVZTYrOVFjQkswbVh1QjdRd040RGNkTHYycUZlckFYOTAvYUI4Q3oyS2Jk?=
 =?utf-8?Q?1YdoygcilFXXB?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7608.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RWFmUzJOSXdhZlBhdC91SnB2SkxJMU0yd29sU29FTXZjZjlXeVdmQkIxNEVG?=
 =?utf-8?B?ZjJLM2VQTXN0UkpSTG5oRWZheVZMN1VZckxlWGtJbWRuZjVhdUdVUmIxbEJO?=
 =?utf-8?B?Z3lDUVhSeHgvbmd3eWczakEwdjQzMk15aTNIVkFEdEpKaGJJaWRqYnpTbjFx?=
 =?utf-8?B?bkh6YTVPb1dyNUpyWklLQjQ0RjlrbUFCOXk1M1lxNnVISjMvenVBY2pMN3d1?=
 =?utf-8?B?S0FNTE1pZ00xMStPV0c3NUJQaHNJVEJzWmJSYlZhWHhPby9ueGZQVWZaaUkv?=
 =?utf-8?B?RWhGblVoY0FDUjRIblM1NTJVSS84Uk40L3RkcGNsK3B0UVdBY0FZNWJreVhi?=
 =?utf-8?B?ZWJnVUFXN1dGaFdZNDBDYzBzVnNPeFNNRlVuMG5GVGhveXJ1ZTNJRkdDWFNP?=
 =?utf-8?B?UjVwY1ErMW1adFBtQjJsSHNBVkxnM1RvVDdrMnVnV3R6Z2k0U01YU3ZJRVRM?=
 =?utf-8?B?dmJaV2JQQllsRDdrR3FlT2wvWS9SbVBRY3pXY2pYeWxxQmN4d1lxclNXcVp4?=
 =?utf-8?B?VUFTZHpySmhTUU1NNm10OFB6dHgvUXMvZXN3YUpkQmRBMEdEWUQ4QkxsNkNp?=
 =?utf-8?B?THVPQ3JhWHJPNDdVZi9LeXNIVGpJaEVnRUF2ZkdSdnNudEVzNUtxYlFub05v?=
 =?utf-8?B?WWZINC9Ua0VZbUo2QVJGWmY4NDEvZnQ3WnhvVDNDeU41cE05N2pxOXlkMGRy?=
 =?utf-8?B?WGNkTVA2M0ZHcW92VktZdkx1SHVjd3RQYnZ6ZVBJU3I5c1E2NitjaUowUTNE?=
 =?utf-8?B?VGlHTUhZV3RHQk02cGJwYWVlampsUytPdWgwY3VlQ1JNTzRCL3VaTFhUSFVn?=
 =?utf-8?B?SUZzU3RTTmFUM28zU3R3aFdYT1JVNVBJcnNrQ1RQN05mZmNFQzRDZnp2SEpl?=
 =?utf-8?B?THVIeXZjRjFjRlowU1lXczVodkw2OVJhSE81M3dJWjlpUkowSS94aGNpU1Rp?=
 =?utf-8?B?OWl5SVZGUGNMT2NKcjQ3WHZCMENsTzFIQWVCOVBGWjUzdXYrQXhIMkZYYmhn?=
 =?utf-8?B?MXF3T0pQWW1VbjM5WGVrZjd1ZGFKbXlxTiswZi9KVWhoZWJFaTJMOWZNU3hL?=
 =?utf-8?B?YWJZQytGUTh1alNaaXlIODN1TzB6SWlsb0lxUzhqWGc5N3J6OSs3VzBLaWI5?=
 =?utf-8?B?R2NsUkd4d0xKNXVTOTdYTjFxK2FxZWhkYk9lVGFVbUErZ0FEMWlkbmhGaUNx?=
 =?utf-8?B?VmMwN0FwaFhqWDVOQmMxWXlJdXZpbVBncjkxSjZaVmhHUTZFaTZjQ25KZEZ5?=
 =?utf-8?B?d1NJallVTXRod1E5OFVrQ1pWOEFOckJqOGFmbTlCdDFsWTVOcU1pTEZXUjdy?=
 =?utf-8?B?Nlp1d3AwakRwTFFZTXJVZDlFaWQ2K0xHUDN5bU1HeHZqTTdQczZsRmFrUlNk?=
 =?utf-8?B?QllhbVQyNmRvSzlEWDlCOVloVWRVY1pTMEhtY2x6dk1uUmpjME02aTlLd2k4?=
 =?utf-8?B?a1Y0cmZ0RVVNV2JQZjdPWlZGUzRoeE0vdmZnQ09abGNWUFpQdHRDQUdNNUEw?=
 =?utf-8?B?SzV3dnRLQjZQVWFaVmlSOWM5bjZ3ajQ0NXJqMlduQXpZRkNnM0RqTXB5eHVU?=
 =?utf-8?B?d3VlQlBxMk9RMk80azgrVnNSQWYyY1Zaa0kyaHhnRk1JUVN6Ly9xOU1lMUxp?=
 =?utf-8?B?V0tRQnlJZzFxMS9pN1lWZG1NU3l3Q2pBeVNYWWt5UE5JMStGeVVxd0piR1gw?=
 =?utf-8?B?UmU1QXhLZXFtSHRENHVrZDlmRTltRGw0c1J4NndnMVNsNldnQXlvTWRWUEpt?=
 =?utf-8?B?amJTNEhlZW04bnBmOExzSkRqWldNSFN0MUN1c20vMDNLanV4OTFRa3ZJSytU?=
 =?utf-8?B?SGd6U2oydjBBOHRCS2pFYjJVTWNKcmdRaHppcDhvVURHWkhUT3VUNW4rTDls?=
 =?utf-8?B?YWtHSm0xRUIxUkt0enpJK3dqTm9OeFJLcTJ5VGlXY3IzWC9NdUZpU1RuRFdp?=
 =?utf-8?B?WWxhLzdwN0x4Y0xLU2FkVzJOMDJ3bm4xejZkQWFuNmR5NjF0K0VlTTVlQnNk?=
 =?utf-8?B?Y0JrK3RJVzlZUVhkMWZDM0tmdEdtbUxlcm1QSHBDUHhBUXNuc1Z1eHV6T1Ro?=
 =?utf-8?B?RmVaNWprbXNQTGF5UzR5T2IrcFNCVzYxRzY5R0RSTTU4SHBvOUl2aXlhanl1?=
 =?utf-8?B?dG1rd2RBbkVvcm5TdXNwZXl5b0Jkdzl6T0xrNHlvNVovUXBjOGpZQkF4Zllz?=
 =?utf-8?B?RlE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cfc679a-67d2-4186-c202-08ddc4374a26
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7608.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:06:30.5072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KOOZO32ltPtSiCKc3F+SzbfS1Q61eslmREToVAEMbYYRc5PC0QHJwmmySD4Mcvjf9vM7FmVBHrrux8mrMNhM6c8mN7e4HGAk8w5u1pS+R5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4788
X-Proofpoint-ORIG-GUID: _SfLwRtt0OnCwHsCC7Vo1zzJctVFFw99
X-Authority-Analysis: v=2.4 cv=JbC8rVKV c=1 sm=1 tr=0 ts=68774f7a cx=c_pps
 a=VOZANKfpuB+U6b2rFtvpMw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=iGHA9ds3AAAA:8 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8
 a=s4JiJgxFAAAA:8 a=uBWcYdIBWqPNKna0ZnEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=nM-MV4yxpKKO9kiQg6Ot:22 a=uu08qe1NGx1XuzmrSQf0:22
X-Proofpoint-GUID: _SfLwRtt0OnCwHsCC7Vo1zzJctVFFw99
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDAxNyBTYWx0ZWRfX1s6/eVcEKELR
 IpeYUtpQHKlu1zD8Q14wKwz3huN6MX47FnVHzEtPezsfPyArc0gXxikZrhfwdy6gL/PB9sZA3i9
 mT5Oywmm3/Uu+M0IOq08hGrAZchVQuI8vtVPMGJQwFpUT8RHQmAtAdFlorHnElClsBSbn41waYq
 C02kyQoRoGR/gu4vQIUqih80hjvB+AB4dYnPJsLumw9Z9emA+QpO5e9CyQdK77xmMDQv15AuFV9
 bdJ5SOCgZRNekYAdJCdXjc0IvUEc3NXQrL4GG71zcYh97wj2egQmjmX+cCN3A+Gmjqmnep/ADlL
 eFjdoTKZpaJPRDrCS/TqecjslZr/rlkRZaBqV1MaQV9ROsgXva0Fmf9Vp+lJsvhYqevDdYAigLf
 fVatKJLJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 phishscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2507150017
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 56G1bl8T1044392
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Jul 2025 07:06:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1804

On 7/16/25 14:49, Martin Jansa wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender =
and know the content is safe.
>
> Hongxu Jia looks like you've created very similar commits for
> whinlatter compatibility recently.
>
> Do you monitor this ML for meta-tensorflow changes?

Sorry for the missing, I will take care of it next time

//Hongxu


> On Tue, Jul 8, 2025 at 9:24=E2=80=AFAM <martin.jansa@gmail.com> wrote:
>> From: Martin Jansa <martin2.jansa@lgepartner.com>
>>
>> Please see
>> https://git.yoctoproject.org/poky/commit/?id=3D4dd321f8b83afecd9623931=
01b2a6861275b5265
>> for what changes are needed, and sed commands that can be used to make=
 them en masse.
>>
>> Signed-off-by: Martin Jansa <martin2.jansa@lgepartner.com>
>> ---
>>   recipes-devtools/bazel/bazel-native_6.0.0.bb | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/recipes-devtools/bazel/bazel-native_6.0.0.bb b/recipes-de=
vtools/bazel/bazel-native_6.0.0.bb
>> index 19b411b..ef9dfba 100644
>> --- a/recipes-devtools/bazel/bazel-native_6.0.0.bb
>> +++ b/recipes-devtools/bazel/bazel-native_6.0.0.bb
>> @@ -5,7 +5,8 @@ LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3D3b83ef96387=
f14655fc854ddc3c6bd57"
>>   SRC_URI[md5sum] =3D "f79f57d82795b591e95f9f7fa0f9a8da"
>>   SRC_URI[sha256sum] =3D "7bc0c5145c19a56d82a08fce6908c5e1a0e75e4fbfb3=
b6f12b4deae7f4b38cbc"
>>
>> -SRC_URI =3D "https://github.com/bazelbuild/bazel/releases/download/${=
PV}/bazel-${PV}-dist.zip \
>> +# bazel-${PV}-dist.zip doesn't have top-level directory, use subdir
>> +SRC_URI =3D "https://github.com/bazelbuild/bazel/releases/download/${=
PV}/bazel-${PV}-dist.zip;subdir=3D${BP} \
>>              file://0001-HttpDownloader-save-download-tarball-to-distd=
ir.patch \
>>              file://0001-fix-unzip-command-not-found.patch \
>>              file://0001-add-Yocto-native-sysroot-dir-to-the-default-B=
azel-to.patch \
>> @@ -25,9 +26,6 @@ DEPENDS =3D "coreutils-native \
>>              openjdk-11-native \
>>             "
>>
>> -S =3D "${WORKDIR}/sources"
>> -UNPACKDIR =3D "${S}"
>> -
>>   inherit bazel-base
>>
>>   EXTRA_BAZEL_ARGS =3D " \



