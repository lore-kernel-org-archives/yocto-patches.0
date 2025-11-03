Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77042CCF9E3
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 02:18:16 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11921.1762136286870662061
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 02 Nov 2025 18:18:08 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=cQaLuHdY;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=3402980684=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A30od96619359;
	Sun, 2 Nov 2025 18:18:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PPS06212021; bh=ydWUpNXD+Pc9QBp6+gLrf7
	R7c6LGe+E0WroLHxTG8yE=; b=cQaLuHdYN3QN33oasfXE/wbu5Ct0F1e0kl6keK
	cpcySy3ZWtIB945M3VMDwN0uEX/cF5fNfKEhrp8/vDCDR7tRZzzeD/C+5djUN5Go
	6jIRzki5kdZiOAZvfIakWdvjV2waKGXlxyKoeTDk/DOF9uTybuTtU3VR6zZYZnrC
	n0ZBwJJMeMblxr7vE4pqaSmu/bN5mLQqfyeovkMCnbF4MKs5FA3dTRhycHy/dkyX
	MBpa0kr8S7+dfk+t4dkEdt8goxlbfMW0fW/EbUvuShiJYrA1i30ewnM8qa0R7+uP
	R6b8EHN8PeZkD2j7SoI/zOQFXWR4XEdTsTetMhNtbwMDt0NQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010002.outbound.protection.outlook.com [52.101.201.2])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4a5dfy14t5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 02 Nov 2025 18:18:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+0zvixYcl5ehp+j3AD0ZsmnpBWuFVEG06HTsQhzfABpiBpfget9e3lWHlVX9wkjyWCZWXlJP4aZWWlLAFlqtyr5ZDhnYXO/js4FZG+3cnC/zUAXztp7mNU5DqTSRvvf5KJ5x3igj9Opuw4tq3ZWqXBnAweh+RGXtKQ5LA9M5CeLeb3gWcII7bNVwRJiEVlHqs4m52n6imyzOTK9uwxbY4cbJ9w3ILAT7usP3AdeJM9l2sbJX+UYjTdhHuDIxE2Zb8+m0OaSmceDzP3JSTNgjLYttOCuiYSv2MxsW4FAWElrBr7vHx0lIogviGW7drJvMbznOATfoRpsNnW/JlCTOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydWUpNXD+Pc9QBp6+gLrf7R7c6LGe+E0WroLHxTG8yE=;
 b=lJ6rDD+c0nw9ZgtHjWoUgVQjIgj5KO5nvuxz56i8gFRG6rnETYT5UckfDc19UMaOM347L3bqLdr3HIh1/PUxEcpaQrFzpCTLDtjpkY5Lsch0Q3WEfPj7mwOhhfJ+dLXFJzWc7wX6GyEZo2I4k0R0KZvJIAUe9KNh3uTQUCLEOUBN0lsa/f+Kpn/3g8Ll8BlQQ6NHH9cCubAPxNz2G4bSpvNGhmFhikZmC4YK7ioIFF7BP0gQBwVC5uwILsXjSgBZjfXTxNeQ7C+thJoJxakzgoJBt/LF7tqfLySGAqdAe4cGp6hnh+k3w6lex6wTtGC54zP5oPjFqWHQOAnqQF9HYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by PH7PR11MB8058.namprd11.prod.outlook.com (2603:10b6:510:24d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Mon, 3 Nov
 2025 02:18:02 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 02:18:02 +0000
Content-Type: multipart/alternative;
 boundary="------------2k4jHdEHPPnjpofMJnnowrYO"
Message-ID: <e915e37e-fc6e-46ad-8b8d-5416a5e6b7f8@windriver.com>
Date: Mon, 3 Nov 2025 10:17:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-mingw][PATCH] meta-mingw: support generating Windows SDK
 with no symlink
To: Joshua Watt <jpewhacker@gmail.com>, Paul Barker <paul@pbarker.dev>
Cc: yocto-patches@lists.yoctoproject.org
References: <20251031080447.2751414-1-Qi.Chen@windriver.com>
 <f61d5e8fdb8bfe0e01824520c3dfbd3221c84e6f.camel@pbarker.dev>
 <CAJdd5GbxVAVDq01o-m=vMQb45Jns5Z+EyZArjc1jF2JL06HOOg@mail.gmail.com>
Content-Language: en-US
From: ChenQi <Qi.Chen@windriver.com>
In-Reply-To: <CAJdd5GbxVAVDq01o-m=vMQb45Jns5Z+EyZArjc1jF2JL06HOOg@mail.gmail.com>
X-ClientProxiedBy: SI2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:194::15) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|PH7PR11MB8058:EE_
X-MS-Office365-Filtering-Correlation-Id: c97a5b41-d348-4fd9-f995-08de1a7f374c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?czFoR1A1Tmp3N2RYQy9KRjE4cVFaKzE2MnlyWWRpVGxBY0lvZzFDd2xzQ0Ux?=
 =?utf-8?B?djNoeXFDaXJxTEp2T3N1RlpUZlp6MjgxR3h6QVoveEV0Zk5WbGE2b2hOb1Jx?=
 =?utf-8?B?K0VTNCtzVEYvSU5kVWQwb0Vua2pvRkY3a2pxSTR4cEtrdG9QaDVRcCt0YldT?=
 =?utf-8?B?bHhDV2pnUnhwOFhwZS9GdkNBamdoZmtnOERtakZFeGdDQWd4TGg5VEovNDN5?=
 =?utf-8?B?RzFaZHBOaW83K2k0MXI1UFlZT0g3dFhWZDhwUWF5Qm1BNEo5U3N3WnpFMnE0?=
 =?utf-8?B?Q0tRbWpaMFdaYVFFakFoVEpqcXRCNDhnMFkvZm5SR0FFZ0FSUzVLdEMwZHJB?=
 =?utf-8?B?ZndMR2I0ejdFNStXSWFtNXltc0NTZkJJTEpseTlpYXdTVjU1Sk9CWmJCeUJ4?=
 =?utf-8?B?cmJIYkN5UFlPZ0UzdnQ3czZ4SnluSEdpSDhCa29CZ1UrNjFSM1ZYcGNvZG1T?=
 =?utf-8?B?WTZYVitNMGFua1JBSU5ReHVXV3htOVNRcGdxQjduaEdpOXJjZXpQMU5tT1Yr?=
 =?utf-8?B?S3IrQUxmdm5SMStVQnM5b0NkQWJXQnBSNnhqWWM4UmtFYTFQTFJVNGI4RFIr?=
 =?utf-8?B?OEY3OTA5STRndGtYZUZqRzR0bGFocTdXL0t6MUZGY21XYU9XMDNBc3hTdU5u?=
 =?utf-8?B?YzVuK2x4eUNhNHNQSTN1bkJvSjF1ZFQxUmJqUnd2UmYxcGpSenZjZnFXaGhH?=
 =?utf-8?B?ditPTUZvU0pudXBKemdneUllM2xveCs0dDVYeUNpSGcvMmp4V2Z1SDFrWGtY?=
 =?utf-8?B?Q1cvZjN2TE9UNG5DbzJDSjdxUjFkTDMvSHpYWEdMallPQUFVNnA4MlhkcUtI?=
 =?utf-8?B?SlVuaVNqaFFqRVdreFpHMkFmUGVHMzMwWUowdjRVR2hkWXFTbE1DdHRCQmRw?=
 =?utf-8?B?MHNRbitrZ2hJN1BOMzE2clp2eFpnZXdvMHJESGwzMmRiMkVRemNEVnUxdW1w?=
 =?utf-8?B?RENGa0Y5MWhKS2xCbCtYN1JnWUx6T0cxMEgvMFJ6d0o1Q2xsY3FLSUxDdW9Z?=
 =?utf-8?B?OWRKTy9wRGdVL3VJKzZYOFE1RzVaNk1JelRTNkVjRjI5a3owbDRKb0RiempT?=
 =?utf-8?B?RVlIaVA2VTdITXY1ZFc1cW1SUnd5ZDhMM21vMG9JSjhGR1Rsb0wvaUVOWDAx?=
 =?utf-8?B?TWx2SFYzeHlqL3cxQStOdFNUZ1k3UWdNRlIyVzRjWTBiRjljUUQ2b0tRUkdE?=
 =?utf-8?B?QnVFNkVPVXAyclJrMUdZT1pzQ20rc2w0ci9JUk1kaEI1dTZBaHlreHpOdHVa?=
 =?utf-8?B?WGx3eUFYaHRRL0tnL05mVmp5cVduV1hrRk9XaFRMUjlXSGRGSHl0bmt1NjBy?=
 =?utf-8?B?R2ZVbWtSVGFRQ0J1OG1sOFc2a1p4UGEyZDUyanRSQUtqdEFURnQxMTJNUURv?=
 =?utf-8?B?cm1idGxEamwwQWZQS0k1dTBQZEZ1U2J1MFg3TEtYSWpCT3dZZkdKVURjNjdK?=
 =?utf-8?B?RGtpZ3VCOG1qK0Z2M3ZmWklBZzlLMDg5QnhUL2xVOGZRbHpLM2owSURYSmF6?=
 =?utf-8?B?TXhXdGliRTUyM1JmMFVxN1oxUVhBTEJXMWVYWXc2L1RLZFViVy9IZTN1UnJB?=
 =?utf-8?B?NEl0OTViQ3lvU0Z6ZXdiZVd6OHFqK0xFb2xsdTZ4bmdObHFpMk9vZVNJRStC?=
 =?utf-8?B?T1ZQSUp0SFVwOFFzMU5leXlreWgxQWk4aHoxREk3SkFKS1dlS1ZrRUJqV3JY?=
 =?utf-8?B?c0xFajVSeGRJS2tLalBSZlhNdzhYRkhmTytLRVNOMmUzN3pBbHFKbW9HenZT?=
 =?utf-8?B?ZG4zZUMyY0xVNXprNXdTeGpxOHlFMkI4eGh0OFR3SWN3eUJsa3BaVVdqNnVo?=
 =?utf-8?B?UjlLT3NJMHdYOEpRY0dMWVhaTThPSGwxU0xyS0pkb3NzaVlpdDhtVW1TM29X?=
 =?utf-8?B?bVpqU2VEclFieGdPN0E4Qi9pWDRnUUxTSm5nTlA1dng5UG5pVks3ZG0vazdB?=
 =?utf-8?Q?00c+kzwgQ5YIEWRCjgWj+owSzUniQEL0?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(8096899003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WGhhemE4UXdMbTlQeWgveTBpZGl1TlczY3F1cnpEU1dlclJYczlTT1drejFK?=
 =?utf-8?B?Um5uL2paalhERlZ6NExzak5qL0V4ZS9ZUHBCSnFmbm9xK1NTN1hYTGlVYXha?=
 =?utf-8?B?NmtlSkhML1dkV1JrSisyQndRblVGR1ZQTDFjcGpRckZjdVFFSjYyR0pWeDND?=
 =?utf-8?B?S0FpZ3ZtSHhFZTJpL1R4Wk95TlViSUJrUjdSMVdJRjd2MndPYWdZOHZvVDdz?=
 =?utf-8?B?UzZGenVXRlpYUUNyblFycHdsdXpwZnFXdXFsV09ZYTlyRXp6Y1FPK0wwbmht?=
 =?utf-8?B?SW9FM1FoVEErQ3A5QXlIVVB0N1Z4ckxOZ1lJYlZBQVhwVmFLRTF2eVVJZXQw?=
 =?utf-8?B?T2Q5QjYxZVRvb21JcHZaUW9DT2krQ1k4cDN2MW1aMDVFaGorbHhnSUV1Q1hG?=
 =?utf-8?B?eHpFR2pQUWIycm1EYStRaHdHYnlEV3RTVWFUaTM3WS8zZ0UwaWN3dCs1VTh2?=
 =?utf-8?B?TTBtK2JpdXI5cVBrd3Z6UjF5MXorODN5SThndUJKWFZCQk44U2d2aFpvOGRJ?=
 =?utf-8?B?NFI2clRVODV3Sk44YnU0YkxuVlBKd3N4LzJ2endHL21PaWMrZVdDaWRZSmtN?=
 =?utf-8?B?R0ZKeUxYWmpUVXJ6ZGpVaDBwczlRKy9YNkRHMUNuVGJCZWxuVE5aQjJmakxt?=
 =?utf-8?B?azgvRHlPdnRRMDQ3ckxaOU1UZUVyZ05EZlpNMVZRUTlzK2VIRGJZdithakpG?=
 =?utf-8?B?NjlhMnNuVjdQdlQ3U1AvNkhjTlhURHdPM1ZEMGV3bWFHZXFyaGNGQUVNdms0?=
 =?utf-8?B?OGI5ZDdTaVE5R1BFYmQ4bTB5S3hWM1c4RTRvdVpBWTFwK0N4d1FJa0tZTnpQ?=
 =?utf-8?B?MWhCU3hwU3UzYnNSR2FzeTRDMFRpVEVOdHBzQVlDOStjTjNiNE81R3pYSG1w?=
 =?utf-8?B?cTV3bEVRakxpWTNGVWlKM1RmNE9MeU41K1lKYXgyb292bnNSQjZKS3FUaWs3?=
 =?utf-8?B?WHZJUldxZzVlUmI4VG5idHFqTTNleURNVDJqZithOWpwVE1qMkcvTVJxT2M1?=
 =?utf-8?B?VHhFaWIxWkl2cnJnNGIwbE0vWVhOM3lUbExmTFNTcllMaXBVbmRWTERJL0lJ?=
 =?utf-8?B?SG1OV0psS1E0TFVQKzc2MmFmWGtMNnp2NzlBSy9LKzlJcmdkd1ZFaEowM2RP?=
 =?utf-8?B?L3BabWxWaU1mNkZ4eGlEdGdLOWh0TkxhR0U1TklyQlpZTDlRbjlvS0hTQkxQ?=
 =?utf-8?B?NTRCdWFRZWZOSy83NUFWbjNXYjVNdHdKb2dhNDQ0NGh2aS95bmszOER0QXQz?=
 =?utf-8?B?ZGkwYXZWRHVSN2piRm9pYlhqY2haZlk2RVpIWmFOeFJZclRoSS9kRGs2ZUEy?=
 =?utf-8?B?OTdvQUNEaFJkTUI0RTlDVEJidE5MaGRLd1B4d2VOR2EybDE4cjBiU1dzNXRn?=
 =?utf-8?B?Wjg2UE1OcFpTUlErNXpWSkxhMEN5cFZ5ODZFNWtiVkNnY3dyb3l5QmkwS1kw?=
 =?utf-8?B?dlNrMC8rNlBxZ2lURzZSUmZOa04xaE91TGRxeDRSSVFGelloamhHaDEyeENJ?=
 =?utf-8?B?bGtXYVJhYkl3bFhGeUNIb1pFM0RlYXJGTDRMVTFwN2ZMd1g3d0VBSVZ4b2R2?=
 =?utf-8?B?OERGS2MvRlFJU0l6cy9MQzFWTTJDYlB2T2I4NWQ1dHhNT1ZNTi9GZmFrWnps?=
 =?utf-8?B?dUJPc2ljTEVSNlRlL3Y0eFVzV0xTSUE2SkMyd2IwTElxeTFNbnpaM0hpcm0y?=
 =?utf-8?B?bGJhdzdCbUxUL2dyV0VVRXAxTXErKzBBNEVLLzVkQzNaa3k3ZnVmcTgxMmpK?=
 =?utf-8?B?RzBtQXA1RHFkS0o0ekpTODJlSE9EYU12L0hKWmtwK3ZXRURQVk9VTTFkdmMy?=
 =?utf-8?B?amxvL0g4L0JRaWR5VlVQTmNRWUU4bndmYmxIZk9jcFYzaXRLRHA1OEZhRFhs?=
 =?utf-8?B?d2FNVytrNE1FeEY0NGdkK3pEMWFLVThPZFdkOE4vaENobGpSM1I5dm1WKzBK?=
 =?utf-8?B?UHdCRkYra3hQNFdSdVVWYXQ3UmtHK0xVdTlEMDA1OUpRNElIWFZFZmJsU0tR?=
 =?utf-8?B?U0tQRlZTbkFCMy9mZjRzbVJzTUpPUWl6L1dneDJubkVHWkkzUm92cEhjcUhS?=
 =?utf-8?B?NmJRUXQyL094NjB4T1JjWFB0eFFHNTdsdGdKZzkrdXpWZFIvRGQxZkpWdDJG?=
 =?utf-8?Q?32J8AhooToow9r7TjI7Ht1LEs?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c97a5b41-d348-4fd9-f995-08de1a7f374c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 02:18:02.6393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lo6upRVgXJEi+FpFQPqJv96e0KPvLdjuRunUFfqRkB/zGPvTVC369qsy4v3vvHFDcR8dtokS/2+xUbQOEHxGKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8058
X-Authority-Analysis: v=2.4 cv=G5QR0tk5 c=1 sm=1 tr=0 ts=690810dd cx=c_pps
 a=N6h9FcIU3O7PIE8+NyeJww==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t7CeM3EgAAAA:8 a=Rf8hYniGJ3e6ZCIWytIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pGLkceISAAAA:8 a=nqmF8vDowcSgSUMn6nUA:9 a=ZJUIjOyCc-DquZKj:21
 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: Y1Ogq81QK7w3ZB6X5sNcFDvtHE2jlnuu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDAxOSBTYWx0ZWRfX9yP3cYeCbytr
 DGkouDTVC2BkOcPWIpZyf8nrGAzXRQ+uZJ5eYQEhAs0fXU39J6rWvv3qrNlzuqnhv0J1d2H6dvY
 nO3VEzFrbcVmZbUsevFjErYPyppUpXX3Lpkl9/urPZQ18F8Khl73J867nR4G+yLgR3Hsq4oQIzM
 yVwPj8ta5tIQJWJ4B5NrO5vAVFqHMNOpl0j9Y1hxoMAWAQ+Z1eEI6x8JBgoWo8AwnS23x0sLWSz
 oa9Ob6CkJHuKwvVXm8ZMxv3VwzI1vu64eIt4cYXEU14OV18RObafaOPTZ6GjB7BRD6lf1bkNH2K
 ZwFeqebYQVxsCTAeIMJjhDNTmeubCXqGhiyZpQC7ZFieRHOTaD+3RnuYYpSjA0Q4iYmMoBcPNRv
 sTMSD1lKPc5iCOKWx1/5TWgK6Txh6Q==
X-Proofpoint-GUID: Y1Ogq81QK7w3ZB6X5sNcFDvtHE2jlnuu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511030019
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 03 Nov 2025 02:18:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2410

--------------2k4jHdEHPPnjpofMJnnowrYO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 5A30od96619359

On 11/3/25 01:59, Joshua Watt wrote:
>
>
> On Sat, Nov 1, 2025, 8:27=E2=80=AFAM Paul Barker <paul@pbarker.dev> wro=
te:
>
>     On Fri, 2025-10-31 at 16:04 +0800, Qi.Chen@windriver.com wrote:
>     > From: Chen Qi <Qi.Chen@windriver.com>
>     >
>     > On some Windows systems, symlinks are now allowed due to IT polic=
y.
>
>     Do you mean "not allowed" here?
>
Hi Paul,

Yes, I mean 'not allowed'. Thanks for spotting this.

>
> IIRC,=C2=A0 Symlinks on windows have to be enabled by group policy, whi=
ch=20
> can be restricted by the domain admins. Unfortunately I think it is=20
> (or was) disabled by default, so depending on how strict your IT=20
> department is, it might not be possible to enable it yourself

Hi Joshua,

I mean 'not allowed'. Sorry about the typo. I'll fix the commit message=20
and send out V2.

A little more additional explanation on this patch:
By default, the Win SDK is still generated as before, which depends on=20
symlinks to ensure things work; when WINSDK_NO_SYMLINK is set to "1",=20
Win SDK is generated with no symlinks, which mean normal user can also=20
use the SDK.

Regards,
Qi

>
>     Thanks,
>
>     --=20
>     Paul Barker
>

--------------2k4jHdEHPPnjpofMJnnowrYO
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 5A30od96619359

<!DOCTYPE html><html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body>
    <div class=3D"moz-cite-prefix">On 11/3/25 01:59, Joshua Watt wrote:<b=
r>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:CAJdd5GbxVAVDq01o-m=3DvMQb45Jns=
5Z+EyZArjc1jF2JL06HOOg@mail.gmail.com">
     =20
      <div dir=3D"auto">
        <div><br>
          <br>
          <div class=3D"gmail_quote gmail_quote_container">
            <div dir=3D"ltr" class=3D"gmail_attr">On Sat, Nov 1, 2025,
              8:27=E2=80=AFAM Paul Barker &lt;<a href=3D"mailto:paul@pbar=
ker.dev" moz-do-not-send=3D"true" class=3D"moz-txt-link-freetext">paul@pb=
arker.dev</a>&gt;
              wrote:<br>
            </div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">On
              Fri, 2025-10-31 at 16:04 +0800, <a href=3D"mailto:Qi.Chen@w=
indriver.com" target=3D"_blank" rel=3D"noreferrer" moz-do-not-send=3D"tru=
e" class=3D"moz-txt-link-freetext">Qi.Chen@windriver.com</a>
              wrote:<br>
              &gt; From: Chen Qi &lt;<a href=3D"mailto:Qi.Chen@windriver.=
com" target=3D"_blank" rel=3D"noreferrer" moz-do-not-send=3D"true" class=3D=
"moz-txt-link-freetext">Qi.Chen@windriver.com</a>&gt;<br>
              &gt; <br>
              &gt; On some Windows systems, symlinks are now allowed due
              to IT policy.<br>
              <br>
              Do you mean &quot;not allowed&quot; here?<br>
            </blockquote>
          </div>
        </div>
      </div>
    </blockquote>
    <p>Hi Paul,</p>
    <p>Yes, I mean 'not allowed'. Thanks for spotting this.<br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:CAJdd5GbxVAVDq01o-m=3DvMQb45Jns=
5Z+EyZArjc1jF2JL06HOOg@mail.gmail.com">
      <div dir=3D"auto">
        <div dir=3D"auto"><br>
        </div>
        <div dir=3D"auto">IIRC,&nbsp; Symlinks on windows have to be enab=
led by
          group policy, which can be restricted by the domain admins.
          Unfortunately I think it is (or was) disabled by default, so
          depending on how strict your IT department is, it might not be
          possible to enable it yourself <br>
        </div>
      </div>
    </blockquote>
    <p>Hi Joshua,<br>
    </p>
    <p>I mean 'not allowed'. Sorry about the typo. I'll fix the commit
      message and send out V2.</p>
    <p>A little more additional explanation on this patch:<br>
      By default, the Win SDK is still generated as before, which
      depends on symlinks to ensure things work; when WINSDK_NO_SYMLINK
      is set to &quot;1&quot;, Win SDK is generated with no symlinks, whi=
ch mean
      normal user can also use the SDK.</p>
    <p>Regards,<br>
      Qi<br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:CAJdd5GbxVAVDq01o-m=3DvMQb45Jns=
5Z+EyZArjc1jF2JL06HOOg@mail.gmail.com">
      <div dir=3D"auto">
        <div dir=3D"auto">
          <div class=3D"gmail_quote gmail_quote_container">
            <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">
              <br>
              Thanks,<br>
              <br>
              -- <br>
              Paul Barker<br>
            </blockquote>
          </div>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------2k4jHdEHPPnjpofMJnnowrYO--

