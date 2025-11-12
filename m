Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD74ECCFA1A
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 07:58:54 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8213.1762934327241253710
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Nov 2025 23:58:48 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=TFBZKWz7;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=3411dc7477=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC4Anuo2275265;
	Wed, 12 Nov 2025 07:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PPS06212021; bh=nb0+h3zV7ioKauyPsv+pK/
	/KYYCf69R8cDXGu/Zs8uM=; b=TFBZKWz7D6S3hYauqy1jqVQ8EXjBCZXQYX6rHP
	KsZqdiqzaQ3KJXc5dHIgdMxgtHViU0xA+V/kgeAAc+4T1cWxWP/3m8v75MsrqKgN
	nUmC/oiayi9k1UvLDFHpXBkzyCrygcEk7gTpmz5Mvh1vfycxzyofChWUfzqWFTDj
	iKA95B/ApywA+7Xx3gasQfpceq5RVG388zzCoTp5w3unQ/W54eYZv2FwvEqP80rD
	iBLg59antRyriC2khrmjgSUm3HDXAX8mwGZNsTphQ6IFBhqnjkolZ3nUNQSmCVxl
	jqFn2yAi5ETudIdTbyRmT0autNKQ+S62rl919xuvxxCIoBEQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012006.outbound.protection.outlook.com [40.107.200.6])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4a9vu94rmu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 07:58:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icjtTWZFGE9Y7TSJ/ybDg9WosxkTU7HJ7jSKnBi47/l0g5GM1tzuGS9CzswU6OlhzivbIg1/NRXb3MuCKIVdNGDGA7d07M/O74HzCuQlubVujq3tA06AxkWWmnE0wggtMiC+Pqn1hwInl69U4rjz0mNHGCh1QXxXOMHtQAEPXtmrGoWn783UGNFHM+5TBoUbSbQXeW3udzHQSaTKlDMfmauqisHK93P/PrHhzE7xNAyjorFXtNyZnTwxcDoMBaBbdjJPsMB7COYm4cXCSTg44ARtTIDTXhKHK8LJVkrvPCB4rhXngYXyxNNVdoxZWS+ye8hYE/vmbOAdc6/Nf3osXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nb0+h3zV7ioKauyPsv+pK//KYYCf69R8cDXGu/Zs8uM=;
 b=QZ8Ds2KpYpYcqU1sfYT/6yImpqHw2XDQNHjvTdoKngfqQpUEcEpP20LdEdwcstfBGQD4GhJJ5UZlhNQamztMrfd6/TdcNbBhgfy//K7Yiejsd57pNMu8DL4wpStzkceKZKo8ceHXGeL5o/1/OxOCwxgfofATOuL5JoqE1npwsi7oeJ+d9ZKsb3GQRhy2H9MgS8qFfncGbMvp+oPPCtT+M7rDK/nBRdBvS1FsHI0ZiVjickSEXfKGWA+nX5K+4oe1+WvSHF+EdIg05t5dH0SZlM2bnRipeqslgyKu/zu/v90u2AWwkH2auFSBylXXEvmhoGk9vYBuO9N+17RWhjbzJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by MW5PR11MB5930.namprd11.prod.outlook.com (2603:10b6:303:1a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Wed, 12 Nov
 2025 07:58:42 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 07:58:42 +0000
Content-Type: multipart/alternative;
 boundary="------------TLEMiy0sEm3Bny5JrK0dkDoO"
Message-ID: <0a46f359-73b6-4f5b-854c-fa742dcfa728@windriver.com>
Date: Wed, 12 Nov 2025 15:58:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-mingw][PATCH V2] meta-mingw: support
 generating Windows SDK with no symlink
To: yocto-patches@lists.yoctoproject.org
Cc: Joshua Watt <jpewhacker@gmail.com>, paul@pbarker.dev
References: <20251103021848.3068540-1-Qi.Chen@windriver.com>
 <CAJdd5GYib3yt92tuSDcr0UQqcDL251EFXpvNuNGHrmrujnpDDg@mail.gmail.com>
 <87e0a761-ad36-44aa-b262-464aaeb97471@windriver.com>
 <CABXoSoW68LaasoHdKFcRV_XHBbixCakN+qq=O1hx7dFTf-pFdw@mail.gmail.com>
Content-Language: en-US
From: ChenQi <Qi.Chen@windriver.com>
In-Reply-To: <CABXoSoW68LaasoHdKFcRV_XHBbixCakN+qq=O1hx7dFTf-pFdw@mail.gmail.com>
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|MW5PR11MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: 387eac54-575c-49a1-ddab-08de21c14bbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|4022899009|366016|376014|13003099007|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?djlUS0JQRVVsR0JqMzBEQlNzQlZ3VWF5NlJtM0s3ZElvM2JNYlB3Q1pnS3dX?=
 =?utf-8?B?RkJCREl6czQzWktCVUdCV1BIaE5SbGZ5Ty8yeXBlbTZsbWpqWlBzUEh0Z3Zl?=
 =?utf-8?B?cVJGMnEvcG51Zkh6MGJQZHFhek94N29BU2t0ZmRmSUV1VUp2QnlRZWZzWGI3?=
 =?utf-8?B?KzlNZmJhV09RWVJ1TnhrY1dBNTRJZWh3cUxLT0tNOVZVdGx0dmp5eWlONGhq?=
 =?utf-8?B?ZHY2UWx0VWtUeDljK3JNTDFDN0RUMTBVT2cwSHp0NWdHcUdnTzZIa2dtdmNZ?=
 =?utf-8?B?M3JMMjEzR0thWDN4aytCTUpXd3lyY1VPLy9uTmw2dmZHc3dTcnFaeEFNRTkw?=
 =?utf-8?B?QU9WSTFSeWtQTmJEbDdpNFYxR3JOMDg2dFhGRERPQ3JmSndBYzVET0tyS0RJ?=
 =?utf-8?B?byt4Z3NQYnlDeGNmT29sY09RUlNkWXltU0J3aC8zUzNwOFBQUHNDajRpeW9w?=
 =?utf-8?B?OXdlUXZYM1ZHTFd2M0tkNkZvZSs2RHFBMm5XN2xsU3dHQlNIZnhCcm9OZURH?=
 =?utf-8?B?NFpLMG1HREdiaVlpbzlONFAwUVZ6SStaaWhVbW9kV0kzb0w1Uk5QZmY4OG1i?=
 =?utf-8?B?SlI2aldhNnovRU1HOWlPT2pFclkzTHdVbVZaL0V4WUVEVEZ3cUxMN2pjY3V3?=
 =?utf-8?B?Vk9za1V0NElnZVRFS1lOM1huZUwvQXc0QVlZMlZqQnd3TUttL2hLbjNRd2w2?=
 =?utf-8?B?Q2FHVnVRclUxRHVkaHVncVJrVy9aUzVQcUZHNGxEdXowL0pjQlBWS2E0cy9Z?=
 =?utf-8?B?VTVtd2xtNDdtaDVwbXRZQUVZTnhGQUI2VU9zSGI0QlM3ZkNraXJzbWxvaTVs?=
 =?utf-8?B?NlNaMmI1YW9OM3ZDMnoyYUdJUTZzQVRmTlRrY2pmVUNMWWtHK1hrRmhBK3Bv?=
 =?utf-8?B?MktjbkM4eTFRTW5JbzBWU1hRUGppOVVDVENiU1NFN0dQR0JqZ3cwQWV0eXR0?=
 =?utf-8?B?TjFteWlOVkxXbVEzNkhNM3RHWWovbDhiM1NRN0ZKdUlMQUVsS0hNTHM0Sk9R?=
 =?utf-8?B?NTNGbmFCREErZTUrK09ZbzQ1alpTZFpOa1FPVHpKL0JSaHVaY2Y2RjhyWnFy?=
 =?utf-8?B?U1Z6OUhLQVhFaUphOEtBQ3NiUHJHWWMwdzc3b2kzNWtwQXVBdzRuaVVzMEFE?=
 =?utf-8?B?OFl5NnV5OFdhNWpLQ3FtS2ozN2xza3c3Z1F2eGVBTnJVTU50V0U2dFFzcGF4?=
 =?utf-8?B?aUl2VnZEQUpPZy9Ua0lQbEpubVB3ekUyL2pJR3VqNm1XRnFNNms3TEZGLzNH?=
 =?utf-8?B?eFBsSFN0WnBSb3RHbk5rbHZwdDg3dmlVZ1AzdklRcDY1N3R0aFJiQU5SUW8y?=
 =?utf-8?B?ZFE5U0JMbmhwVVV2R3FkandyUHN2ejhNNGlpeDJiOCtONXBidWpxS3Rrc01H?=
 =?utf-8?B?Q1FHczBYSmowYjNQbXJMOS96MHNacU9DcjI1SlFKMlkyYzBnVk5qcUpJME5B?=
 =?utf-8?B?OWt0cTlSS3ZjUlBJZDB1OVBQcW5DWDM1T1dTWEhpaWJERUVMckFMeXBxMDZj?=
 =?utf-8?B?L3dhS1RCb2IxYTFPUkdCOCthaU1zbERiaWY1K2YxYVdnZEZSQ1kyV01PYStG?=
 =?utf-8?B?bXdnVlZmSk5MelNVd1Ayb2ZRaXRoMmViWmtIMG1tdWliejlQMzJnN2EwV2xj?=
 =?utf-8?B?eEdORDF2RDdNTjduMzY4TlovK3lrZURmVXBvRkpmdnE3Skc1c0t2N05Tdy8v?=
 =?utf-8?B?MTkwSEFrNmhPUDYycFFmZitJOGZqNHhJbFRhbWt3RkJQWXN0a29GNmRCdmZt?=
 =?utf-8?B?WDlZNW9YWmczeTZoL1FjZHdEZk5NNis1cG51VlNtZXp1L0ZLdWpIOTdQZEUy?=
 =?utf-8?B?SlVPVWFaZUlJYkVJOGxBU0lhQUdDZi92bjNQNHJqbklxbmo0VnlBUllsYnZw?=
 =?utf-8?B?MndZckNseVVNcHA5eXM5dW42N2dNRXRJZjlvWnNSVU1ZblE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(4022899009)(366016)(376014)(13003099007)(8096899003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TTE0WUJFNDQ4OUtmLzhGUXoweUdWRzhsb1o1Y2d2dFJGc2gxeGlYWTExMytL?=
 =?utf-8?B?eUxiWnBRa2x3RnArTVNkQTlUVVNoZHVCNXlTdjMraFErWHZHdFNXZS92Nnpl?=
 =?utf-8?B?L0pzOUtuRHREVGtJZUN2bHNsTjBBZkFwZTBBeUlpNk5PNzBPYTZ2Q3FXWUEz?=
 =?utf-8?B?OFZoMW9TcXFLV29ydCtWYzNsdDBUV3hHNHl0cUdUMExjaVg5aEl4Y0pMNzVa?=
 =?utf-8?B?UDd4RlRYVEFoMmU5dVVOYjJheEdweThJbkh6TmRSVm9yOThhWU9uR0cycm5k?=
 =?utf-8?B?Y2dZOVh6RzdhM2FOWUl5NWlpNVU2WVcxZjQweEFSWGplZzN6TkpuNFZmc1lE?=
 =?utf-8?B?a2FZS3hEcHpmQWVIdkVZUUNyTURrNTYvOUIwV0EvbjQwcVVHKzE5M0tVWWRs?=
 =?utf-8?B?ZSs3bkpCUmdlN28xTDhqSWhXMGVKc0xpOHF2Zk5hbk5ncURCTkxleW1Eb0No?=
 =?utf-8?B?K0p4RTJrM2x1ODZ3UCtUaXAyY1c0azV3ZnBuWk02UHZHQ3FXM1FyaXdLTkhT?=
 =?utf-8?B?UStjSzA2bGRHZHRheWVHMWFITndaZHFxUDdhTDFwd1V6VkpaeWp4NnJWS3JQ?=
 =?utf-8?B?cE5BQmV3OHBVNmQ1NjFsQlFEb1NYTDVWOUVaZXBGNUhPM3RiRk1lSk8yZytu?=
 =?utf-8?B?bWFlYTZDdDdIblZaaTFSVFBrV1lZRy9reHk0MDNiZ2JlMWdWZlcvRnVGMVZH?=
 =?utf-8?B?M01aTktJQnBKazM0VDJFUU1nWEZFSlpQaTFEcVE5ME9zcnhyd1MybVFGSlNC?=
 =?utf-8?B?eTFFbGZCZjMvZUxsRE4wWFMzbEtEV215Uy9hU0c1MW5oeFNhZ3k4ZXU2YUlz?=
 =?utf-8?B?MGZVVndGY0pDampuK3hEY29pQTFkKytDK09DSmpER0U4QnVWSWhWNWt6bjBp?=
 =?utf-8?B?TnM5NUdlLzBpZVFNMVVnSUtZaVdOa2RZdDZVWGxBU3BweCtic252MVkxbi9n?=
 =?utf-8?B?V2ZGMUxKRE9TYjVpeEVlU0xraUFjeUVXbW1pQTJpL0c2RHRQaGwyUFVPelFm?=
 =?utf-8?B?OXMySjRQOStRODVvakU1MGlqU0JNdlpNaDg3RkdINEZQemJFOUFubDYwTmt1?=
 =?utf-8?B?RHhjZC9RNlZzeitrcUF4VnErUUJPbmpEV256M3NkbEw2N0MzMnhDU3ZiVHo3?=
 =?utf-8?B?K1R4WTNoZTdxMkN5OUN6bGpOcUhBaFFibm8xTzdJZXVpbGJvSmM1eWxxRjR5?=
 =?utf-8?B?dDN1RWVXbXk2UXg4K0E4M2ROTFo5TXd2MzNJNW9Jd2gzcHNid1drcG9uVlFP?=
 =?utf-8?B?eFdCK1RGK09xTzRySU8zOGJQRWUvRXpCb0xNUTE4RHhvMi9Ga1RLd2cwR1gr?=
 =?utf-8?B?SG5jTzVEOG1MNHpleTVZVHJOVXo3WlBiVnBaRG9PNjI1QUpybldwcXpxTHk5?=
 =?utf-8?B?NDloMGMvV0c5RFozVGYrVW9kS3RwYTVjOFV1b21iN0d0S3BQM3ErM001TVhQ?=
 =?utf-8?B?cXhrRlYrMUpFOGl6Z2ZTV0VMMGlhaitRWWpZUzRmNkdLMTBTRUhrdlBobndI?=
 =?utf-8?B?NCs3NHM3NVNjRUVHV1BHNFpjSEhOTDZkK1dlZVdvc1VGNlNyMUI0Rm1NRDUy?=
 =?utf-8?B?TkxxSkg2QUJxRCs2VGJpLzg3WkpyY0YvNWRpNEZlL2NuTVlGb0h2UDdqVUNF?=
 =?utf-8?B?V1QxVGRnODZjUkZHM0o3Qlo1RjhVVWRpTHZtYWVyS2xia3ExY2VSNmhwUlUx?=
 =?utf-8?B?Z2hSbDk0c2Y4TTZ1dnpKa0MrVXZZb3pydDZYcjg3b0tvWGdDKzhhbTNkTXVx?=
 =?utf-8?B?dnNxRnM0VHUxNHpsREV3SXNMK1NyT1B2d1UxOUgyTEtCdnNRSzUweUdTWUdR?=
 =?utf-8?B?Wm1vbDR6TTFGRjE2RkNzSmEwSnMvU2pXdWNmdVJlK0JGQTdUa0txaElEQ1o0?=
 =?utf-8?B?QVB6dTg2MFpzSE5WQWZaTGJDYnBpcjZ0RHk5RjYwZ0E3UUVDenRnbGFsV2NX?=
 =?utf-8?B?b0I3eSthMU1JVExaVEkvV2xZRmF6Z296bm05dy8rL0pOTkNJOFB5UkdJZXJa?=
 =?utf-8?B?MXdUQ3FOUGdGMWU1bDErS3puUzBlVVk5U0VwVTBQbVJYTm9rN1RYMm9zL3JF?=
 =?utf-8?B?bEFuYTlub0N3bUREYjZQVUVtb25tQzdaenNrVmg1UzNNTXE0cm50MWlOcHNi?=
 =?utf-8?Q?qOr7M5gcsxYNh7QE5RhWEBOJb?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 387eac54-575c-49a1-ddab-08de21c14bbc
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 07:58:42.1046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0b90SSJqe8VzPoNLlQkhx326PN+opVwRZjnloMevfTnxNYdDI47zLthHg5o6ZERRw03Kj40+iozHpP8ATKBMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5930
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA2MyBTYWx0ZWRfX2cbLCozo1CSh
 jKg2oYTeRDSMix8EGqvesEq3IFtv6sxMrJZvty9R5nhhFcA4pbcCDA1XPoXSzGH1MHO2xqJ8eTZ
 ylDJZPQ0etVfY73LOavLmu7dMFzN0qMESNOzbMjOxytCUDr6Jz+FoWJUnQEnycsB44qzDja26zN
 980Cj8OIEOaM5S86CpTBJyF6lXOqqLgq5KwzrtQrsr8v5W4yQmDHwezI2MVfYO0IB41ioP6k1nI
 c8fO8VEEvBlO71Ci/xVorJfnf/TvvJq15TS0E1R0f+Tie3Q5MvcAuUC7Falzzbz766olfqXI0eI
 V87GBOieI4wfR4ROnRhVG6pW6HWoC9lt+xXdcW9Tj8LBdnkHc4EAsKEPy9pMiktlLgSBMcT8nOK
 87v9MOgmMehAiuCDM2WxE0QAMD03mw==
X-Proofpoint-GUID: A_iYr6nL53Et750_OM1a-Mh98Tv0ttZQ
X-Proofpoint-ORIG-GUID: A_iYr6nL53Et750_OM1a-Mh98Tv0ttZQ
X-Authority-Analysis: v=2.4 cv=CMknnBrD c=1 sm=1 tr=0 ts=69143e35 cx=c_pps
 a=wcVwjJSTJ+Ev3TLsT0vURw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iGHA9ds3AAAA:8 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=lxEWtBMArU6aNcZvPCsA:9
 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ltsVsjNxyn08V2SGbzQA:9 a=VvHwodcdPuhPAagu:21 a=_W_S_7VecoQA:10
 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_02,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120063
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 12 Nov 2025 07:58:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2492

--------------TLEMiy0sEm3Bny5JrK0dkDoO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 5AC4Anuo2275265

On 11/12/25 15:39, Samuli Piippo via lists.yoctoproject.org wrote:
> Would it make more sense to leave out the INHERIT and=C2=A0WINSDK_NO_SY=
MLINK.
> Instead, if you need this, you can inherit the class in your recipe or=20
> local.conf
>
> -samuli

 From my experience, users will usually prefer a variable setting when=20
it's possible.

Take this case as an example, they could put this setting in their=20
<distro>.conf, site.conf or local.conf, then no matter meta-mingw is=20
included or not, 'bitbake <something>' still works.

Regards,
Qi

>
> On Wed, 12 Nov 2025 at 07:35, Chen Qi via lists.yoctoproject.org=20
> <http://lists.yoctoproject.org>=20
> <Qi.Chen=3Dwindriver.com@lists.yoctoproject.org> wrote:
>
>     On 11/11/25 23:25, Joshua Watt wrote:
>     > On Sun, Nov 2, 2025 at 7:19=E2=80=AFPM <Qi.Chen@windriver.com> wr=
ote:
>     >> From: Chen Qi <Qi.Chen@windriver.com>
>     >>
>     >> On some Windows systems, symlinks are not allowed due to IT poli=
cy.
>     >> We need to be able to generate Windows SDK without symlinks.
>     >>
>     >> To do this, a new variable, WINSDK_NO_SYMLINK, and a new bbclass=
,
>     >> mingw_sdk_handle_symlink.bbclass, are introduced to achieve this.
>     >>
>     >> By default, things work as before; when setting WINSDK_NO_SYMLIN=
K
>     >> to "1", SDK will replace all symlinks with the actual contents.
>     >>
>     >> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
>     >> ---
>     >>=C2=A0 =C2=A0classes/mingw_sdk_handle_symlink.bbclass=C2=A0 =C2=A0=
 | 25
>     +++++++++++++++++++++
>     >>=C2=A0 =C2=A0conf/machine-sdk/include/mingw32-common.inc |=C2=A0 =
3 +++
>     >>=C2=A0 =C2=A02 files changed, 28 insertions(+)
>     >>=C2=A0 =C2=A0create mode 100644 classes/mingw_sdk_handle_symlink.=
bbclass
>     >>
>     >> diff --git a/classes/mingw_sdk_handle_symlink.bbclass
>     b/classes/mingw_sdk_handle_symlink.bbclass
>     >> new file mode 100644
>     >> index 0000000..2f6dbe6
>     >> --- /dev/null
>     >> +++ b/classes/mingw_sdk_handle_symlink.bbclass
>     >> @@ -0,0 +1,25 @@
>     >> +WINSDK_NO_SYMLINK ?=3D "0"
>     >> +
>     >> +archive_sdk:prepend:sdkmingw32 () {
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0if [ "${WINSDK_NO_SYMLINK}" =3D "1" =
]; then
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for pars=
e_type in "file" "directory"; do
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0find "${SDK_OUTPUT}/${SDKPATH}" -type l
>     -print0 | while IFS=3D read -r -d '' symlink; do
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target=3D$(readlink -f "$=
symlink"
>     || echo "NOTVALID")
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if [ "$target" =3D "NOTVA=
LID" ]; then
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0continue
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if [ ! -e "$target" ]; th=
en
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0continue
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elif [ -d "$target" ]; th=
en
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if [ "$parse_type" =3D
>     "directory" ]; then
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rm "$symlink"
>     && cp -r "$target" "$symlink"
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0fi
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if [ "$parse_type" =3D
>     "file" ]; then
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rm "$symlink"
>     && cp "$target" "$symlink"
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0fi
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0done
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0done
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0fi
>     >> +}
>     >> diff --git a/conf/machine-sdk/include/mingw32-common.inc
>     b/conf/machine-sdk/include/mingw32-common.inc
>     >> index 56b8052..bf3f14e 100644
>     >> --- a/conf/machine-sdk/include/mingw32-common.inc
>     >> +++ b/conf/machine-sdk/include/mingw32-common.inc
>     >> @@ -59,3 +59,6 @@ GCCPIE:mingw32 =3D ""
>     >>
>     >>=C2=A0 =C2=A0# wine and wineserver are required to test MinGW SDK=
s
>     >>=C2=A0 =C2=A0HOSTTOOLS_NONFATAL +=3D "wine wineserver"
>     >> +
>     >> +# handle symlinks
>     >> +INHERIT +=3D "mingw_sdk_handle_symlink"
>     > Does this need to be unconditional? I'd prefer something like
>     > INHERIT:mingw32 instead if that works
>
>     Hi Joshua,
>
>     I just tried it out. Using INHERIT:append:sdkmingw32 works.
>     We have to use :append instead of "+=3D" to avoid overriding settin=
gs.
>
>     I'll send out V3.
>
>     Regards,
>     Qi
>
>     >
>     >> --
>     >> 2.34.1
>     >>
>
>
>
>
>
>
> _._,_._,_
> -----------------------------------------------------------------------=
-
> Links:
>
> You receive all messages sent to this group.
>
> View/Reply Online (#2490)=20
> <https://lists.yoctoproject.org/g/yocto-patches/message/2490> | Reply=20
> to Group=20
> <mailto:yocto-patches@lists.yoctoproject.org?subject=3DRe:%20Re%3A%20%5=
Byocto-patches%5D%20%5Bmeta-mingw%5D%5BPATCH%20V2%5D%20meta-mingw%3A%20su=
pport%20generating%20Windows%20SDK%20with%20no%20symlink>=20
> | Reply to Sender=20
> <mailto:samuli.piippo@gmail.com?subject=3DPrivate:%20Re:%20Re%3A%20%5By=
octo-patches%5D%20%5Bmeta-mingw%5D%5BPATCH%20V2%5D%20meta-mingw%3A%20supp=
ort%20generating%20Windows%20SDK%20with%20no%20symlink>=20
> | Mute This Topic=20
> <https://lists.yoctoproject.org/mt/116091557/7304865> | New Topic=20
> <https://lists.yoctoproject.org/g/yocto-patches/post>
> Your Subscription=20
> <https://lists.yoctoproject.org/g/yocto-patches/editsub/7304865> |=20
> Contact Group Owner=20
> <mailto:yocto-patches+owner@lists.yoctoproject.org> | Unsubscribe=20
> <https://lists.yoctoproject.org/g/yocto-patches/leave/13175947/7304865/=
1848005690/xyzzy>=20
> [Qi.Chen@eng.windriver.com]
>
> _._,_._,_


--------------TLEMiy0sEm3Bny5JrK0dkDoO
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 5AC4Anuo2275265

<!DOCTYPE html><html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body>
    <div class=3D"moz-cite-prefix">On 11/12/25 15:39, Samuli Piippo via
      lists.yoctoproject.org wrote:<br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:CABXoSoW68LaasoHdKFcRV_XHBbixCa=
kN+qq=3DO1hx7dFTf-pFdw@mail.gmail.com">
     =20
      <div dir=3D"ltr">
        <div>Would it make more sense to leave out the INHERIT
          and&nbsp;WINSDK_NO_SYMLINK.</div>
        <div>Instead, if you need this, you can inherit the class in
          your recipe or local.conf</div>
        <div><br>
        </div>
        <div>-samuli</div>
      </div>
    </blockquote>
    <p>From my experience, users will usually prefer a variable setting
      when it's possible.<br>
    </p>
    <p>Take this case as an example, they could put this setting in
      their &lt;distro&gt;.conf, site.conf or local.conf, then no matter
      meta-mingw is included or not, 'bitbake &lt;something&gt;' still
      works.<br>
    </p>
    <p>Regards,<br>
      Qi<br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:CABXoSoW68LaasoHdKFcRV_XHBbixCa=
kN+qq=3DO1hx7dFTf-pFdw@mail.gmail.com"><br>
      <div class=3D"gmail_quote gmail_quote_container">
        <div dir=3D"ltr" class=3D"gmail_attr">On Wed, 12 Nov 2025 at 07:3=
5,
          Chen Qi via <a href=3D"http://lists.yoctoproject.org" moz-do-no=
t-send=3D"true">lists.yoctoproject.org</a>
          &lt;Qi.Chen=3D<a href=3D"mailto:windriver.com@lists.yoctoprojec=
t.org" moz-do-not-send=3D"true" class=3D"moz-txt-link-freetext">windriver=
.com@lists.yoctoproject.org</a>&gt;
          wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On
          11/11/25 23:25, Joshua Watt wrote:<br>
          &gt; On Sun, Nov 2, 2025 at 7:19=E2=80=AFPM &lt;<a href=3D"mail=
to:Qi.Chen@windriver.com" target=3D"_blank" moz-do-not-send=3D"true" clas=
s=3D"moz-txt-link-freetext">Qi.Chen@windriver.com</a>&gt;
          wrote:<br>
          &gt;&gt; From: Chen Qi &lt;<a href=3D"mailto:Qi.Chen@windriver.=
com" target=3D"_blank" moz-do-not-send=3D"true" class=3D"moz-txt-link-fre=
etext">Qi.Chen@windriver.com</a>&gt;<br>
          &gt;&gt;<br>
          &gt;&gt; On some Windows systems, symlinks are not allowed due
          to IT policy.<br>
          &gt;&gt; We need to be able to generate Windows SDK without
          symlinks.<br>
          &gt;&gt;<br>
          &gt;&gt; To do this, a new variable, WINSDK_NO_SYMLINK, and a
          new bbclass,<br>
          &gt;&gt; mingw_sdk_handle_symlink.bbclass, are introduced to
          achieve this.<br>
          &gt;&gt;<br>
          &gt;&gt; By default, things work as before; when setting
          WINSDK_NO_SYMLINK<br>
          &gt;&gt; to &quot;1&quot;, SDK will replace all symlinks with t=
he actual
          contents.<br>
          &gt;&gt;<br>
          &gt;&gt; Signed-off-by: Chen Qi &lt;<a href=3D"mailto:Qi.Chen@w=
indriver.com" target=3D"_blank" moz-do-not-send=3D"true" class=3D"moz-txt=
-link-freetext">Qi.Chen@windriver.com</a>&gt;<br>
          &gt;&gt; ---<br>
          &gt;&gt;&nbsp; &nbsp;classes/mingw_sdk_handle_symlink.bbclass&n=
bsp; &nbsp; | 25
          +++++++++++++++++++++<br>
          &gt;&gt;&nbsp; &nbsp;conf/machine-sdk/include/mingw32-common.in=
c |&nbsp; 3
          +++<br>
          &gt;&gt;&nbsp; &nbsp;2 files changed, 28 insertions(+)<br>
          &gt;&gt;&nbsp; &nbsp;create mode 100644
          classes/mingw_sdk_handle_symlink.bbclass<br>
          &gt;&gt;<br>
          &gt;&gt; diff --git a/classes/mingw_sdk_handle_symlink.bbclass
          b/classes/mingw_sdk_handle_symlink.bbclass<br>
          &gt;&gt; new file mode 100644<br>
          &gt;&gt; index 0000000..2f6dbe6<br>
          &gt;&gt; --- /dev/null<br>
          &gt;&gt; +++ b/classes/mingw_sdk_handle_symlink.bbclass<br>
          &gt;&gt; @@ -0,0 +1,25 @@<br>
          &gt;&gt; +WINSDK_NO_SYMLINK ?=3D &quot;0&quot;<br>
          &gt;&gt; +<br>
          &gt;&gt; +archive_sdk:prepend:sdkmingw32 () {<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp;if [ &quot;${WINSDK_NO_SYM=
LINK}&quot; =3D &quot;1&quot; ]; then<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p;for parse_type in &quot;file&quot; &quot;directory&quot;;
          do<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp;find
          &quot;${SDK_OUTPUT}/${SDKPATH}&quot; -type l -print0 | while IF=
S=3D read
          -r -d '' symlink; do<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;target=3D$(read=
link -f
          &quot;$symlink&quot; || echo &quot;NOTVALID&quot;)<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if [ &quot;$tar=
get&quot; =3D
          &quot;NOTVALID&quot; ]; then<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;continue<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;fi<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if [ ! -e &quot=
;$target&quot;
          ]; then<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;continue<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;elif [ -d &quot=
;$target&quot;
          ]; then<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;if [
          &quot;$parse_type&quot; =3D &quot;directory&quot; ]; then<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;rm
          &quot;$symlink&quot; &amp;&amp; cp -r &quot;$target&quot; &quot=
;$symlink&quot;<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;fi<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;else<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;if [
          &quot;$parse_type&quot; =3D &quot;file&quot; ]; then<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;rm
          &quot;$symlink&quot; &amp;&amp; cp &quot;$target&quot; &quot;$s=
ymlink&quot;<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;fi<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;fi<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp;done<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p;done<br>
          &gt;&gt; +&nbsp; &nbsp; &nbsp; &nbsp;fi<br>
          &gt;&gt; +}<br>
          &gt;&gt; diff --git
          a/conf/machine-sdk/include/mingw32-common.inc
          b/conf/machine-sdk/include/mingw32-common.inc<br>
          &gt;&gt; index 56b8052..bf3f14e 100644<br>
          &gt;&gt; --- a/conf/machine-sdk/include/mingw32-common.inc<br>
          &gt;&gt; +++ b/conf/machine-sdk/include/mingw32-common.inc<br>
          &gt;&gt; @@ -59,3 +59,6 @@ GCCPIE:mingw32 =3D &quot;&quot;<br>
          &gt;&gt;<br>
          &gt;&gt;&nbsp; &nbsp;# wine and wineserver are required to test=
 MinGW
          SDKs<br>
          &gt;&gt;&nbsp; &nbsp;HOSTTOOLS_NONFATAL +=3D &quot;wine wineser=
ver&quot;<br>
          &gt;&gt; +<br>
          &gt;&gt; +# handle symlinks<br>
          &gt;&gt; +INHERIT +=3D &quot;mingw_sdk_handle_symlink&quot;<br>
          &gt; Does this need to be unconditional? I'd prefer something
          like<br>
          &gt; INHERIT:mingw32 instead if that works<br>
          <br>
          Hi Joshua,<br>
          <br>
          I just tried it out. Using INHERIT:append:sdkmingw32 works.<br>
          We have to use :append instead of &quot;+=3D&quot; to avoid ove=
rriding
          settings.<br>
          <br>
          I'll send out V3.<br>
          <br>
          Regards,<br>
          Qi<br>
          <br>
          &gt;<br>
          &gt;&gt; --<br>
          &gt;&gt; 2.34.1<br>
          &gt;&gt;<br>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br>
        </blockquote>
      </div>
      <div width=3D"1" style=3D"color:white;clear:both">_._,_._,_</div>
      <hr>
      Links:
      <p> You receive all messages sent to this group. </p>
      <p>
        <a target=3D"_blank" href=3D"https://lists.yoctoproject.org/g/yoc=
to-patches/message/2490" moz-do-not-send=3D"true">View/Reply Online (#249=
0)</a> | <a target=3D"_blank" href=3D"mailto:yocto-patches@lists.yoctopro=
ject.org?subject=3DRe:%20Re%3A%20%5Byocto-patches%5D%20%5Bmeta-mingw%5D%5=
BPATCH%20V2%5D%20meta-mingw%3A%20support%20generating%20Windows%20SDK%20w=
ith%20no%20symlink" moz-do-not-send=3D"true">Reply to Group</a> | <a targ=
et=3D"_blank" href=3D"mailto:samuli.piippo@gmail.com?subject=3DPrivate:%2=
0Re:%20Re%3A%20%5Byocto-patches%5D%20%5Bmeta-mingw%5D%5BPATCH%20V2%5D%20m=
eta-mingw%3A%20support%20generating%20Windows%20SDK%20with%20no%20symlink=
" moz-do-not-send=3D"true">Reply to Sender</a> | <a target=3D"_blank" hre=
f=3D"https://lists.yoctoproject.org/mt/116091557/7304865" moz-do-not-send=
=3D"true">Mute This Topic</a>
        | <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/post"=
 moz-do-not-send=3D"true">New Topic</a>
        <br>
        <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/editsub=
/7304865" moz-do-not-send=3D"true">Your Subscription</a> |
        <a href=3D"mailto:yocto-patches+owner@lists.yoctoproject.org" moz=
-do-not-send=3D"true">Contact Group Owner</a> |
        <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leave/1=
3175947/7304865/1848005690/xyzzy" moz-do-not-send=3D"true">Unsubscribe</a=
>
        [<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Qi.Chen@eng=
.windriver.com">Qi.Chen@eng.windriver.com</a>]<br>
      </p>
      <div width=3D"1" style=3D"color:white;clear:both">_._,_._,_</div>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------TLEMiy0sEm3Bny5JrK0dkDoO--

