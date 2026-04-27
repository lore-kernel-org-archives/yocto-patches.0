Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFA8FF8850
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 02:26:33 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33936.1777256780982057753
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 26 Apr 2026 19:26:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=TyWtvIPN;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=857747364e=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R1G8uF3042191;
	Sun, 26 Apr 2026 19:26:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=LB8yA9miqV5XPDR9KVRqiG29JnZTpbgtLaqQWz1wM/k=; b=
	TyWtvIPNF+/lajwreQ0s/eZcrg5Xq/PimH4OHH7yxNzySSPW9wPHOFh2QfO4Zmge
	nyrTjad1azoZ7If261226uuscRHNijkQ1zju9jjmGBnSLXJctolUK5Dk1ta904of
	izdLmKtNEIli/9eF3TGmfAHPbNf2nAAzUPPjpWGax/Sk6ksis+cdy83Ys3J8Nupn
	adf41dA/75IJHULvWi0DX4gsoAz8WD/cJa0Iqca2cCdnG9wHrMBVGMppUwMJI54N
	cx3AJfLDuKanYTxrnDRGFQenjSRTEdBHM4GysjUI7qL8ainMVjF7U/vU+4q7W05I
	+FxhXkGZtZa9MUhSrRfpOg==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010058.outbound.protection.outlook.com [52.101.56.58])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4drw4j14n0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 26 Apr 2026 19:26:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdNbJAVRDgn3ZlPnB1ji3NyQ5KpVKPU1lDMhURq4PNDfWK/Cdi0XZx9Ca5LS+Fnp5rSsckZIWENFYL5e3VcKSJliWYTXryIesZQzro1nsBUAGWVwx28qxJDQNvn4gRnKmtw430o1+RnhQeuvnn3VsbqTHgthvtBGfPtqPP0qCUOfegcsEfxH1IfhOviC4995R+mYcaFsTpWTNKIesi4+D9LahLDR1aN0/4I/dfbRFsUVHw0/vOzM/91+m2pVlqfmKp2+ChkmmLf+OQGDcjxYOLmeOvGX71TLCRFkQ9pmP+Vhj1AeyUbcqfrHyw+KXTmb1P3h34fMo31dxKN5xOglww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LB8yA9miqV5XPDR9KVRqiG29JnZTpbgtLaqQWz1wM/k=;
 b=cjJ/UryAIUVDDTEInuVpQP8YeST2OM8jwGDnQBshw3HaBySFIT+26OZrpysKfkKk3NvwvqyyyNpneWoSlXwyIiSDMK3FB/9RaH+rpWQhfygP6A+CWIUI5lbqklVkItBoG6xVANjBAcSHNPLJ1CvJ3OFsqmoTOKqbHb0wJm+1qcW9mNpTq+NuIVL8WAGVHvLqslEN6IguS8qEcPThAUDH6HjosBVSN97nLB5Zi6Lc/EAC2e+99+ZLc9+WqIKK3TMqxeWdeDAV0nAfpLSkpYb7X4vpL9i0KakhCbHArjwOJILBfwZqGcpJjuWe+YZ7l0UjTcmbxrq3Dbmune/Fno8prA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7621.namprd11.prod.outlook.com (2603:10b6:8:143::16)
 by CH3PR11MB8705.namprd11.prod.outlook.com (2603:10b6:610:1cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 02:26:11 +0000
Received: from DS0PR11MB7621.namprd11.prod.outlook.com
 ([fe80::b070:218b:b122:bf1a]) by DS0PR11MB7621.namprd11.prod.outlook.com
 ([fe80::b070:218b:b122:bf1a%6]) with mapi id 15.20.9870.012; Mon, 27 Apr 2026
 02:26:11 +0000
Message-ID: <03180b6a-7ac0-4045-8168-7acd808b2a1a@windriver.com>
Date: Mon, 27 Apr 2026 10:26:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH meta-tensorflow 0/3] remove tensorflow
 DISTRO_FEATURES and Python version check
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
References: <20260423-python3-14-tflite-v1-0-68bca178a550@cherry.de>
Content-Language: en-US
From: Hongxu Jia <hongxu.jia@windriver.com>
In-Reply-To: <20260423-python3-14-tflite-v1-0-68bca178a550@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To DS0PR11MB7621.namprd11.prod.outlook.com
 (2603:10b6:8:143::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7621:EE_|CH3PR11MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: 66928cb3-a52d-47a6-bb2d-08dea40458fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|4022899009|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	dy9m3MywKfpgp71pRkhMmhCExz9pzB3vxSGnFABaQJs4rqNEW6d4tIh0an7zAEhfaecUNalOP1J3LFcnSsWqZqo6xvmYQ7Niz1Mfp3aoUFV5rzCF1psCFyo3x5yLkqQHLVrSBX4c6Ovsq2LveV1IX2CUwXd40vv5egnbN/QfvoJnV1MYmtn0vM/Bn3pxRpMKfnqxkYawqf71x3kgk+hjd/ZfdbdQTAHU95qZYxw6MxUu6NkvgoT4/FT43lKpSTEsHMNI5ihWOLnPDyavkSgbXZkv25YQVFpnkrtyufN+eTiUkUyl6YXnvJ7LE5BxoyFDFkkCkpnxVZhdq1XApp4EvqpDLp8nuEmVCnl92ovOzb6h2X/aXlTmN75xqlxadStmjHG/KnERZI8NSlXU5ufh7Q3yfmXMBw43AEBv/oHkjnrmdAqiMztE52LjduuCgN2e/1+kZRmIjt4PFgv3rJTu94tlrJinn9MhkR1p/KhR/XTISqrEADWaQ4DZM05na/Wej3K0gaSCr3vpN8xPWZvLvhqMsVepkmm8I+w/rx6FmR1JghXirGuYil1g9FlZloNGx1i0NPxg92+tvpaVm5X/Jqu6jJ9o9F/Q0GDZVzOI6Z7hWZsNbvvcaxmX4nXU8fqxxT9dvr2nkPrUscRHtxmTMQrcMdVzVruyVhL2+FuE/l0+3yPUz2CC2XWKUu0jN8fN
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7621.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(4022899009)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dlk0RW1QL0dQdmJGamVDajRMRTlLbmZmMzZibVByN1BPQ0I4Z0FYS0VObDl1?=
 =?utf-8?B?Qll2K05tL1RXaGlxZjV3dUs0VFZCaGRoeDQxN1E0ejRybnpDOE5ZMDNYY1Ay?=
 =?utf-8?B?NXdJQlhrTW9sRXlmbExCUkx1akZQWm8wd2h5cUZVbTVQQkgySC9HNDZ2T2lR?=
 =?utf-8?B?RWpRNXJwaC9tQTNFMjlURXJObTR5b3puTFlsVXZDSHVOU2VJeGRJRGJUZElY?=
 =?utf-8?B?VVZiRlprb3luNVo0NCsxa0liL1JPWXJ3OHRIZk11cjh2UWJHTURHdlYrZ04y?=
 =?utf-8?B?SEJmbVd2R0p1NGVESUNjQmp5STNsUDkyVTZCb2F3Q0hpZnpQdy9UZkdxLzcv?=
 =?utf-8?B?UmZkMGdBTFRXQmgwY3BlelF0SllXdjFLM1EvNWY0STB0VFR4RFpaL0tZTWdJ?=
 =?utf-8?B?bnRRaHJ5Y1B5NHVUd0Zjb2tTZGlINVcvMHlJb1NWNm5sOXpvTitPQ1RBR1hp?=
 =?utf-8?B?RXo4aVhBMFpycFVlMmNFNUwwU2R0Q0h5cVV5NkZtMVJnUnNXR1lmYm9EcHdG?=
 =?utf-8?B?clB6aHlCNURjeVdmZTRCS3YwVklvYy9wekFSUFRXYk00bDFla1dRL2tlSGUr?=
 =?utf-8?B?UnplS3FxU1ZKNmx5Nm8yRnBrMk5udjZ6Q1MzNmt0UGw4UDR1YmJGenFOS21R?=
 =?utf-8?B?TVJvNStqT09hUGVaL0tnR0Z5dzJhQ2VYZTdtck9CMUg3MENmV3dEbzVkZEpX?=
 =?utf-8?B?QUUwbVdHVVFNREFRMC8vM3U1elBoUURxUWdsYUE5a1psL091KysrajgxYm1y?=
 =?utf-8?B?NUhIcG1UOFFldzFVMFczT0JqajJIWkRVcm8yRVM5WGF2b216bDZNN0RzTmtG?=
 =?utf-8?B?MXNST1I3WUw4dTVwUUp6YVBpcXQySG9WbkFlUWxmcUdQVHJWUldKQmo5TVBw?=
 =?utf-8?B?MDFFV0x4Wk5mM2ZCS3hqTWNzdS9ES29vT25iYTltZ2VGemtURE9yMW44VHE1?=
 =?utf-8?B?Z09mTkt5S0FkM1ZDVVYxdGNsdFlraXhIcUtxYlo2TjhCVDFsZlRwaExmMkpz?=
 =?utf-8?B?OU1WUExMSGVKQkxpYUVIMlJVWUNDYkNpUi9oNjRud1NybTM5WDJOcVNQaHky?=
 =?utf-8?B?RDN1YXR2cnpld3RuUDJZUHhEYjBkN2ZDWklZdmtQdzNXVnF5WFpTTVdkUVFP?=
 =?utf-8?B?K2IzMDQ1RldFNTdGK0pVdFZYeCtRdUx2eTFHMmtxQUs0a1B6QUxrM3k1QStk?=
 =?utf-8?B?VUgyOFp5dlVMaU9sWm1INjk3cW9tQWJZb1RGcTVVaWVqZWo2eDlTOTYzVlJP?=
 =?utf-8?B?THFBdjM2WXFUdXJKdmJoVERUVTlQc3A3L0VOUVVQR1Uvb2M4WitWandsQjdv?=
 =?utf-8?B?VitjT0VMcllsRUZMWUVOMHVRdG1YQXk5d0ZUekpyaG9zaW52YmlEZ1ZnOWRk?=
 =?utf-8?B?cGxqdEtBbHhVYjBvUEtkV3g1b0JUc0g5cSs1N1ZKdm9oaGcwOUl3QzZkcWYx?=
 =?utf-8?B?ZjQwQ1ZaQU83bEJlK2l4andlWEJZcmZYS05wWmRtWUhpYTMxK29Xd1p2blpr?=
 =?utf-8?B?UkxsREdzdXFXditrbjcwMWdqKy9TbjlHc2hmK1lRM1h5L3FxbkM0SGhiMy9z?=
 =?utf-8?B?UFEvbEZxc0hQb1QveE15cEM5SXltTEJYbTNmZ1VQSThjd0luSENDampxN3Qw?=
 =?utf-8?B?c2NVaEtlT0M4eUF2VEU1bE5jNVpHSVN5enVETFpqU3VGUkhmdW9pMkkyaVJP?=
 =?utf-8?B?ZndmZjVBUkNGbU8zVHZSR0xiU0cyZmxaSUxyTVI4YWgweHA5ZW9kdTYya3Jl?=
 =?utf-8?B?YXFETmpLblh4VWdjT25PZklHNENLUVVmRWZlYlJsRDRJVWFEU2xJVFIxUUJm?=
 =?utf-8?B?VUpzeHlKU0pUenMvSjFrWUVpVHRtT2tYai85Ly9ZT3JFSU81b09UMU5pYmZj?=
 =?utf-8?B?U2NOWnNNTXc2bWdGZUE5TENNbU5TYm1PV2Z1UjgxajV4aVNDZnNyVXFFa0I3?=
 =?utf-8?B?d1RWc1E2WUtFUGpqN1A5TElTekxmM3VmWEsrM0ZtaXpGTWczS1Y3elRrTEVl?=
 =?utf-8?B?VERNbW5UYm5SLzlKeHpKYXB2YzdDS3JlcXRQVmxCdFdtQlExSWgwSTRNR0g5?=
 =?utf-8?B?Nlk2L1hnMWhnR1Jic1VUSzRqQzVCN0pwMit4UHJrbmwvMGZPU2RrUHdOT1hS?=
 =?utf-8?B?elN2aWZISEVWWVVkMEVCWGdyL3JjMW12R2llVjV2U25jU0Q0c3pSeTRJMmFD?=
 =?utf-8?B?eDZZSUNxUGJnM2sxZS9zaURoRXM1WEM3aTF5SmQ3WTUrWUxCcXVpall0U0Nr?=
 =?utf-8?B?VmhvdFd2TVBJdEN3UEdjWlcwT2RnQzl0Zm1GbnRrUGo2MGNNeFFDVnpBMHU5?=
 =?utf-8?B?dU1GZmlzZWxDMWEvYXBrZTlBSGRDVysrbC90MldjaUI1dDlkb0Y0QT09?=
X-Exchange-RoutingPolicyChecked: 
	RpyFl15OWpdCjz7YmkverO1oHPeUdlqHtFsSVX6gmsKTLD7YW8mltyAJpsCe0gjyXwWlvULBI3uDvVSi+sYDMpyqvjpXTFS0Oj4WSCvUPGbmiQ8UvmmLULfGbXrzZAXJ+DZFypIqXK4e01C2D69uuyQoGGsBbhe99ZkDMs7yb894SfxMm3kDhbw/7uCnv2bOm8kArx9g0WWkIceCXJdKEZ7lsUD7PfP7aWKwe/sUibpwAXW8lvjBHAqr72O8Ap4pb54Gohq0hZa4SeVD4NnXP0EvcBwHszrQHGqqhWFqb9k8iNlGkfuLE0OzrACURpUUje4/0Ec01pUYY6xeItz+EA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66928cb3-a52d-47a6-bb2d-08dea40458fb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7621.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 02:26:11.7769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNKxCG727qWdOT3Qhl7H/nq/BPft1dxkcgtMdlBlpArpij9iEdPQArGf7w92f7we6S6onfh+Ffkz8QZn3rsS3f4GbwIZ78gC+FV6TSdkX0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8705
X-Proofpoint-GUID: 3t1xKP5lkWZSVPLdBVVlsYz-dNmUpyJ6
X-Proofpoint-ORIG-GUID: 3t1xKP5lkWZSVPLdBVVlsYz-dNmUpyJ6
X-Authority-Analysis: v=2.4 cv=Iroutr/g c=1 sm=1 tr=0 ts=69eec946 cx=c_pps
 a=0NiyxO+pn7gKe2yT6URb/w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8 a=aBNCUoye5K0rlxotjyAA:9 a=QEXdDO2ut3YA:10
 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDAyMyBTYWx0ZWRfX39/USMCpcsjX
 ZpAUiZ9jUskbcbvmur6UFG++PxkYXsoBRZT11I7m/ghY7MpDm/vlV7dRzFwdq+2Lq/+5g1DvzEC
 Caqqxv7xTGeQlopaRHrR3laf0+Gj6KHY1kdW3J8DE8KTEHFagpU8cstf5ybDkYshDm4EMG6fpBW
 yszFd3D6zx5AiaxdnO6y/NJ4T5dr17cHHFJ8Jt5OGiLI1845e4ac6qR07B5d/Zt54PfNvqPv4dP
 qUri8P5tzbtAYWBGR7PlpsUh0XempOTdi3Ai2cRu3pmVcsWaPpONYjXrHmrUIfC1iiXVnOKPu9L
 AjYNmTwL5Z5NchcQqmM8iER0FfxU2ZvXl5xhIh8CvaZreRRcdgeRVnqiSDFgtuPrTqZTyUTziFI
 cDZBVgLYxTcC/bifsEYH9RSR7FKmnRuwfu387NZx04TLNQlEVV3EfKEOL22xsfQ3Tmh4UKvDDsH
 1n4E4tabDus89dZtkYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-26_07,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 clxscore=1011
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270023
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 02:26:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3821

On 4/23/26 22:53, Quentin Schulz via lists.yoctoproject.org wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> tflite used to not be able to compile on Python 3.14 that is in OE-Core
> and required to use the backported 3.13 Python recipe. Since, tflite has
> been updated and now supports 3.14 therefore the work-around isn't
> needed anymore. Some cleanup was done but not entirely, this cleans up
> the remaining parts.
>
> Add b4 config file so contribution is easy with b4.

Thanks for your contribution, merged

//Hongxu

> Fix mailing list address in MAINTAINERS.md.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Quentin Schulz (3):
>        add basic b4 config file
>        MAINTAINERS.md: fix mailing list address
>        fully remove unneeded python3 work-around for tflite
>
>   .b4-config                     |  3 +++
>   BUILD.md                       |  3 ---
>   MAINTAINERS.md                 |  2 +-
>   classes/tensorflow_ver.bbclass | 20 --------------------
>   4 files changed, 4 insertions(+), 24 deletions(-)
> ---
> base-commit: 078ed7b791faa38553ecf8e93048bd463f6edc8f
> change-id: 20260423-python3-14-tflite-9ba5640a0c42
>
> Best regards,
> --
> Quentin Schulz <quentin.schulz@cherry.de>
>
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3779): https://lists.yoctoproject.org/g/yocto-patches/message/3779
> Mute This Topic: https://lists.yoctoproject.org/mt/118972926/3617049
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13176071/3617049/43253763/xyzzy [hongxu.jia@windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>


