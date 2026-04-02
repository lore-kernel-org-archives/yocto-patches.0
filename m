Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C547CC6B20
	for <webhook@archiver.kernel.org>; Thu,  2 Apr 2026 08:03:37 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10950.1775117010778625905
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 Apr 2026 01:03:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=WVMuzRi6;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=8552b40fc7=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6320kKGH576753;
	Thu, 2 Apr 2026 08:03:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=FqNZR9P3HPy1oPh3BLEZYz4XQsJeeupE9V3Tue3vhzg=; b=WVMuzRi6xgVO
	pwEm2VKkUXjPydpLWEFYK1iGvYg9uQ8weCGAEwzNQO8+6vTxMs1OLwZH7JBcs1WZ
	li06qUuJ50OXFXzLyUZmYQz487+7LTvSQQGPXw/LbJmeyJ0h2GgOmwxRYPXJLb/0
	AbWshn9ryxjkQrhICIJ2qU6/j1lrT28NjKQ46eZPp9ruZ5yKZPCYB2Im4Kx4N1OB
	sCfgRaKOpdOgZ2z6aFzSbbmifO1Qhf2g6xQkiPxzhcWLY6WhOwHNLJgc5RrYRpkt
	KmTUe9geUoDnDko9tmkPQXPwBFjoEvuXV0d/MaGlwxwC3YcdNYx87ISdelcmD3JA
	vk4mFJmdAw==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d65y4ff4q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 08:03:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlHTrkTFyrjwS5qg3PWTQrgQWXjlY8amJfVuvCzGsg7avamdW7ykCNMEe1lBsCL9RV89FKBgf0rNdVI/zznU++vNyK2SkPwor5aZF3FNNxkqNoHwkLK5B4yfD3YqpFADWyouHXRIhoJhXszIiD1d0yeEZBfG/k5hgD/xVvsVO8rzHwmKBUfCZ5gC5QSKJRCSRkVjibbpDdcWOF7FV7ttx+22yN+WHltmj6l2wRvB8yxTop2GC7Am3QRk4A/BvKao35Mp7acHAb/scKPT9s/Yod2/94AetrZaFYQO4+P0GIE0PNkm2sEGRCUVbI8b9/2J9XnXlUp4OLDUpn0BJgTTrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqNZR9P3HPy1oPh3BLEZYz4XQsJeeupE9V3Tue3vhzg=;
 b=aWzLW7wUDQj1e7PHPFwn2d2KFgQG1uKxozVuiAAkG75ic8btUyjcggiQFXdE4OmahfJOTwwbCAkvAo+54AGAXzkD1V5bolJ1GrK4vVfnIKgbM0SZoXfO/3ASrPHGEHA9c5SfocmD6vRI2CIwRJa5wHOHQeTV8xi8u/gyVRMf6PI5yrv2lzcAgD/dq7kF19Gg8EhGd0uMvDnRWqvPr7+iJsj9kbf5atl50+kKhaWlrXCZCMzDYy0ELHqWIcPV5FBFNry/le0QddoEwaK1wOSgsfrZz57s1iy3aUjlaS1Y2AOEUKxOwrzrMf8gjmTa0hvvD8NTRjN0/3zxeLlB0EA7SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 IA0PR11MB7790.namprd11.prod.outlook.com (2603:10b6:208:403::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 08:03:27 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831%6]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 08:03:26 +0000
Message-ID: <d18add79-d279-4f2a-9e18-6b879439df7c@windriver.com>
Date: Thu, 2 Apr 2026 16:03:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-selinux][PATCH] refpolicy: backport fix from upstream
 (PR#1096)
To: "Abhilasha Manna (Temp)" <amanna@qti.qualcomm.com>,
        "yocto-patches@lists.yoctoproject.org"
 <yocto-patches@lists.yoctoproject.org>,
        "joe.macdonald@siemens.com" <joe.macdonald@siemens.com>
References: <20260401064624.2548716-2-amanna@qti.qualcomm.com>
 <IA0PR02MB9662973B0F9D0FA602857EADFE51A@IA0PR02MB9662.namprd02.prod.outlook.com>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <IA0PR02MB9662973B0F9D0FA602857EADFE51A@IA0PR02MB9662.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SEWP216CA0094.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bf::11) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|IA0PR11MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: c37f71c2-c602-4faa-1f49-08de908e51bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	/0lPkpRT4CyYYPgPrGYlOLaaj5vL558VReKP5g3DRxLpAC2XMijGED44VSMH/LIBmLkq0HzMn9Rzto0wDAVgcx8uShiL0O1Ci+jgfoAq4QUxefOhUH0eRyge1Gtara2gPwCtSc48lshl03IsalZrVzcQA+FnaEn7WntNnclTcRXHd0YaDn7vdMIY58i/JmmGiRFot2fmBK1UlJV4N7oJhHK+jxoBofVYyfHdd7NWDvm0DFv/eXUFdATlGRAqzDcDj8PO8/jswt73JBKtScrOlEvrfenS7OcK2BLwaVUNtaFLlrt19IBXdyN7CIXgg3rqB0vyIJMN/Q8LlVTpeRnDqv46tic0pugHx1nq+KvPiXA2S0zr6ZwW4NEfnkiWoUKIpcUlTbqmD6a0yQ8b0jEN+JJymGSGgVaiupKkpCwmwLgcHvsWZSDh2fkGYp3nqe3QT5nzKvjB+nrD94qy5Iimd762EvWCxBloNkDYk1rDbiCBXchsR9E8rs0I8wAE3k3OuP72yvUwgaEejr3eSqMx9n1f7nuU4BupYfF86XOj213vninFTvHzjWHsdoMpniuCClwNoAxTuo058EcK8b1YkV399ikHNtB5jKkR3ODi6Q7kBXTgwsaoB+ScOWY4kp8Ukhf5SPPi3YPFTpAoBq9kLqbpLckP6f2rDU5nBQK0DBFaLle6JuWM5lNKw+o8bAAH
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZlhKdWsrdVZFN25GSlBZbGREMTN0Sm80ZDBpbmdzUnp5QloxdVpNV25DamFm?=
 =?utf-8?B?TW5EdXh0ekFDOTRIU2xQQ1ZSNzgzVi9IRlBiVm1xU1ZpaFFUakdLRHJDTUNu?=
 =?utf-8?B?N1Zuekl5NU1yU2JxdVpFMjJsY05XRWhhN3ZON1BSbkNZZmxYcHNDOXIxdjM4?=
 =?utf-8?B?WUpvS1poMlpMNXFxOWM1VGxhakdrMGZ5L2lMNFBEWjNHZ0toNWZtRFBmUkk1?=
 =?utf-8?B?Z1FFOXZuNTl2d2lsaXZXdDFlci9LV1FwK004d3Nxa0NaRHVSM0w0SUxNdzJN?=
 =?utf-8?B?TFZ1eE1vNXdBUjQ4dVhlUGtReXBxNzNSOU1zWU5qaS9KcUxrUGVuK1orUm1o?=
 =?utf-8?B?UkFHTzFlVDhIQjhaZUxCVDhEWDQ3TkszSUgvMDYxdkxDaVhDcEJveUdFL2gz?=
 =?utf-8?B?ZWRwZGNRNEZHck9TYmVOTzhKWk1iQzdHdGs4QUtkdXM2TUk5eEo1a1lueUl2?=
 =?utf-8?B?R1FFRTRkdExYc0gxVitTc21qaFd5eVJPWVNLOFJqVjllY2wzMTFxd1A5ZzVL?=
 =?utf-8?B?cTA4dHRROTZZQithYWorQ3FqaFVSQ3lGemZSYXBCWkE3MlFocmJ1MVoycUQ3?=
 =?utf-8?B?bitXUXNSOXBrWG9aZXVuS2tqdUoxVjdlTXNEeWtjYkc0V2loZzFhNXJuQm1X?=
 =?utf-8?B?dWNraGhiVm5Tb3hpTVdnR2pTT3lVb2hQNEpUbGFWSkdJUGJwNTZlRGh4Q3NO?=
 =?utf-8?B?UXZHWGpZaWp6NUtvb2pxcUtJN2c1SEIyanlCc2pMUjgzRGRzNTF1NEJ4cWFJ?=
 =?utf-8?B?THFxY1hSZ1ViSHMvNFB6RldyeG5IcDluZ2J1MHg3ZVhDTk5ncjJtVmluNk9K?=
 =?utf-8?B?bmZXNVRCNE5qejAyaTJoR2dzaVZMWGRmUmI0UjFXbWlILzdSbHF5WkNmVUw4?=
 =?utf-8?B?UUlhdXJwazBKRmRFUTJLczRGSUxGOUdJbE00dnBQT0lnY1dYREdWWmNBaGl2?=
 =?utf-8?B?eHBmZkdiQ0pUNzJ3UmNBcWtYRVRoN0xUNmt1Snl3Yk9ZRENBVy9vTTMvZUNS?=
 =?utf-8?B?TnBpOGpqZzhteWRmT3J3Nk5wdWZoNktLKzZGTWpOWThUSWtXUWt5My9mSXZL?=
 =?utf-8?B?Zm5xSHF4Mkp0b3ZuUDBMY1hnN2lYdkxYcE1VVFhabk5UczIyNUFpemEvY2wv?=
 =?utf-8?B?d24yT2dXQjdoc0pSMG5CWFo3TkZqVUdCdWtPZmNNYnlPblNHNkhGRU40VVVp?=
 =?utf-8?B?ejZjZ1diVDk4dWtaWlc3VzU0NW1UWjU3UXFaeEw1c251V3ZLVm9WTVFLTjk4?=
 =?utf-8?B?cllGSWxxa2lvcGJna1dYTGJUcW5HRkRLKzVicVN1b2RBNWxZMk45eFE2Smc2?=
 =?utf-8?B?K1ZUU29RZFJldm5vR2dYdTBIUVY2ZUY2Q1B4aDJUbnAwQlBLYWlpazFteFZV?=
 =?utf-8?B?Y25BYjVvWnN3bENpMVFUUmZpUHlHNUxyVXdhbWFtY2J6czl0WGJkMVM0K3JF?=
 =?utf-8?B?ZHg5Y25UendZV0lqZDZBV2NQWjJ5TkdJU0JOaU45dDJobFpWbUZSVFRUc2dS?=
 =?utf-8?B?OGxnUXN2bzlFTm15VmFoZkI1MXppNFlyOUJWYVN6UlRWUVZZd3ZSL3JYYXN6?=
 =?utf-8?B?NXBTaGFBeHBlREQvY3BSY3lncE44R3NUQnp3NElGNVdsT09HVjM5a1lxYnNL?=
 =?utf-8?B?Nys1aDJpSnFDQWlEZjVCbE92M1NwMkJkNVFzRVMvekp1eldtOVA3VXRnQkEz?=
 =?utf-8?B?dHVBQlFqTWloRElUamwyZEZwa0xTQmlKNmFYcExtL3pUOGdRaTBCa05wNnZR?=
 =?utf-8?B?Njd3M2JvL3NKVGJmaCsySlZ0NGpKMUdPSjhkZVlyZTcrL2EvVHQ5anppUDRr?=
 =?utf-8?B?RUNhcFNuWWt6YXpLWGpiMm54MkFqc2hJNFlNd0lZSGptZFRES1QzandRejAv?=
 =?utf-8?B?TG5MM2RwOWFXNzVTUTJGU1o4MDhUMTVsM3FOR1U5dUE4UzU0OFlhLzJoMG9G?=
 =?utf-8?B?Qm9oWkxlTHBwZ3pJWkpYV2tVakNMcWpkNlp0MFNETDZWMTI4dkNLMnZmN3R1?=
 =?utf-8?B?S2QvZWRDRWpFT2hlMHNXYmlvUkQvTFNnelVZdUJXTU9TWXcrcnAyVlBnK09t?=
 =?utf-8?B?UUlqQzllREYzeUllWC9PQ3JhV2ZSUkhJRlIwV0VvdTZ3QnpncWE3cyswcXNB?=
 =?utf-8?B?RWN0TzNUY0hSL1JRdGlJVU1hU29tRnVtdVFheStXU0hEbndOazgwTkZpMzJ2?=
 =?utf-8?B?a3lOVE1EcFBma2M4c2VBSm1oQzdVc0tyTDVITHp1emlFUHR6KzdTL1FZbU5y?=
 =?utf-8?B?S2pMZEhhbkFBT0xCYWlOeFg5dnJuLzFLT3ZNK3ZjcjZBNmtGdTZJbzVHSTEy?=
 =?utf-8?B?UDFwZGU5OWJONFNBb2lvZ1ZDdWdhYXovT3NOOWRhOFZlR2lOT004UT09?=
X-Exchange-RoutingPolicyChecked: 
	YAzFNpOka3leHQnt+1c1fg8q6nXxR+Br4Qr/D9s7ysOZk/6oSK01R9tg1JslQX8PelHmdJjWhjtbCD8cQRRKI8eRmo3CVG1R+IMSMqDFBgyOybssKiOXujV23SjjUKFmy41CSLeaxMBFXzIbCpTVS0j+Ckk03ydQMNe2JWKRBgb2Wjx4SoV5CRWBBxyNJeBxPsQ5SgJOa0Ct2WnKPdiV52xVcB4k9/1+7dYL4H8C5nMU8fGRUVEVgoXAWEdbIb9GhyOBuPwmBSUmDPz/HHtahFHAiLb+FpR4nqLOdqp0ki20hEcQsJUHapTyFMQ/lvQT0oiG7U6eNgmKEqkMmRx0yQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c37f71c2-c602-4faa-1f49-08de908e51bf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 08:03:26.7673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mF0+WzpOtVkfFy4PJ6qJn+51ccJs3k4038Cf2uKioe0L/0RlRHKLJdrYExOzwlNhVdvCKU1ACcaaB4zkyVOrKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7790
X-Authority-Analysis: v=2.4 cv=QaZrf8bv c=1 sm=1 tr=0 ts=69ce22d1 cx=c_pps
 a=CgODY3tvNtn0KPtxrBvszw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=iGHA9ds3AAAA:8 a=mPVi0UATEp-I1CtdPJUA:9
 a=QEXdDO2ut3YA:10 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA3MCBTYWx0ZWRfX8suDwEDpNnXO
 2aMVomo88UkALpwdr5p5CG0+DOFhAn5l0njFMt9mlyPr5RgYku1sACj1qGPteEJtBmqprpK83h7
 oIOlnwTdDif2KEeaJAf/PF4K3BfwZizCGkst+aIQslCmvHJE67wHxbaWs/wdzLPcHjN4SwPxHkr
 mzg7coWnSdzSTNcUWJIxM0QfIw9t4qwdcWYv707Rw7M3ve8ispgKW8hCeX3iutckBxYVfVeIJgp
 mefejrIQPJ/LK5rmUPvkSZzzGp/vSM2LnJy9+yM+B54U9MosEEfsB1Avn4Ve22qXJGfeq5pk2y7
 aK/p6SqV+wUoW/x3AKtSLcvnAVr4++1KAsLokWKwAp/YsFAKiwpaSedHVaRqbM/Q5huyCX6GBD9
 VhYT9odqfhBhfHfF5v7iS8sEBoB/s72sDL5AJBunpZINeXKpx1cehBCCTULfysmeldqLjgcdflb
 W2tJIe0o44H06p96rng==
X-Proofpoint-GUID: K4twPhYbaYogLX2Umq-D5qhP8QkjF-rM
X-Proofpoint-ORIG-GUID: K4twPhYbaYogLX2Umq-D5qhP8QkjF-rM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020070
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Apr 2026 08:03:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3610

Hi Abhi


On 4/2/26 14:02, Abhilasha Manna (Temp) wrote:
> Hi Joe & Yi
>
> Requesting to review the patch.

Given the recent requests to merge backported patches, I will upgrade 
refpolicy to latest git revision.


//YI

>
> Thanks
> Abhi
>
> -----Original Message-----
> From: Abhilasha Manna (Temp) <amanna@qti.qualcomm.com>
> Sent: Wednesday, April 1, 2026 12:16 PM
> To: yocto-patches@lists.yoctoproject.org
> Cc: Abhilasha Manna (Temp) <amanna@qti.qualcomm.com>
> Subject: [meta-selinux][PATCH] refpolicy: backport fix from upstream (PR#1096)
>
> Backport upstream SELinux refpolicy change from:
>
>     https://github.com/SELinuxProject/refpolicy/pull/1096/changes/2aad2d57fa7e6873d3e59e6bc2848623713e46f0
>
> This change is required to keep meta-selinux in sync with upstream refpolicy and to fix issues observed when building or running SELinux-enabled images.
>
> No functional changes beyond the upstream fix.
>
> Signed-off-by: Abhilasha Manna <amanna@qti.qualcomm.com>
> ---
>   .../refpolicy/refpolicy-targeted_git.bb       |   1 +
>   ...l_read_transparent_hugepage_sysfs-in.patch | 103 ++++++++++++++++++
>   2 files changed, 104 insertions(+)
>   create mode 100644 recipes-security/refpolicy/refpolicy/0079-kernel-add-kernel_read_transparent_hugepage_sysfs-in.patch
>
> diff --git a/recipes-security/refpolicy/refpolicy-targeted_git.bb b/recipes-security/refpolicy/refpolicy-targeted_git.bb
> index de81d46..9d23e84 100644
> --- a/recipes-security/refpolicy/refpolicy-targeted_git.bb
> +++ b/recipes-security/refpolicy/refpolicy-targeted_git.bb
> @@ -14,4 +14,5 @@ include refpolicy_${PV}.inc
>   
>   SRC_URI += " \
>           file://0001-refpolicy-targeted-make-unconfined_u-the-default-sel.patch \
> +		
> +file://0079-kernel-add-kernel_read_transparent_hugepage_sysfs-in.patch
> +\
>           "
> diff --git a/recipes-security/refpolicy/refpolicy/0079-kernel-add-kernel_read_transparent_hugepage_sysfs-in.patch b/recipes-security/refpolicy/refpolicy/0079-kernel-add-kernel_read_transparent_hugepage_sysfs-in.patch
> new file mode 100644
> index 0000000..463fc17
> --- /dev/null
> +++ b/recipes-security/refpolicy/refpolicy/0079-kernel-add-kernel_read_t
> +++ ransparent_hugepage_sysfs-in.patch
> @@ -0,0 +1,103 @@
> +From fbf9e9a5c3086b53f46f9f07378af5466d7a6ee9 Mon Sep 17 00:00:00 2001
> +From: Abhilasha Manna <amanna@qti.qualcomm.com>
> +Date: Wed, 25 Mar 2026 14:49:46 +0530
> +Subject: [PATCH] kernel: add kernel_read_transparent_hugepage_sysfs
> +interface
> +
> +Add a new interface kernel_read_transparent_hugepage_sysfs() to allow
> +specific domains to read sysfs files under the transparent hugepage
> +path (/sys/kernel/mm/transparent_hugepage).
> +
> +Introduce sysfs_transparent_hugepage_t as a dedicated type for the
> +transparent hugepage sysfs path, replacing the use of the generic
> +sysfs_t.
> +
> +Upstream-Status: Inappropriate [meta-qcom specific]
> +
> +Signed-off-by: Abhilasha Manna <amanna@qti.qualcomm.com>
> +---
> + policy/modules/kernel/domain.te |  3 +++
> +policy/modules/kernel/kernel.if | 37 +++++++++++++++++++++++++++++++++
> +policy/modules/kernel/kernel.te |  8 +++++++
> + 3 files changed, 48 insertions(+)
> +
> +diff --git a/policy/modules/kernel/domain.te
> +b/policy/modules/kernel/domain.te index 0f38015b6..7c7fe8f32 100644
> +--- a/policy/modules/kernel/domain.te
> ++++ b/policy/modules/kernel/domain.te
> +@@ -120,6 +120,9 @@ allow domain self:lockdown { confidentiality
> +integrity };  # glibc get_nprocs requires read access to
> +/sys/devices/system/cpu/online
> + dev_read_cpu_online(domain)
> +
> ++# read and search access to sys/kernel/mm/transparent_hugepage
> ++kernel_read_transparent_hugepage_sysfs(domain)
> ++
> + # Use trusted objects in /dev
> + dev_rw_null(domain)
> + dev_rw_zero(domain)
> +diff --git a/policy/modules/kernel/kernel.if
> +b/policy/modules/kernel/kernel.if index 01a06eb37..84d76dc3a 100644
> +--- a/policy/modules/kernel/kernel.if
> ++++ b/policy/modules/kernel/kernel.if
> +@@ -4108,3 +4108,40 @@
> +interface(`kernel_ib_manage_subnet_unlabeled_endports',`
> +
> + 	allow $1 unlabeled_t:infiniband_endport manage_subnet;
> + ')
> ++
> ++########################################
> ++## <summary>
> ++##      Search the transparent hugepage sysfs directory.
> ++## </summary>
> ++## <param name="domain">
> ++##      <summary>
> ++##      Domain allowed access.
> ++##      </summary>
> ++## </param>
> ++#
> ++interface(`kernel_search_transparent_hugepage_sysfs',`
> ++        gen_require(`
> ++                type sysfs_transparent_hugepage_t;
> ++        ')
> ++
> ++        allow $1 sysfs_transparent_hugepage_t:dir search;
> ++')
> ++
> ++########################################
> ++## <summary>
> ++##      Read transparent hugepage sysfs files.
> ++## </summary>
> ++## <param name="domain">
> ++##      <summary>
> ++##      Domain allowed access.
> ++##      </summary>
> ++## </param>
> ++#
> ++interface(`kernel_read_transparent_hugepage_sysfs',`
> ++        gen_require(`
> ++                type sysfs_transparent_hugepage_t;
> ++        ')
> ++
> ++        allow $1 sysfs_transparent_hugepage_t:file read_file_perms;
> ++        kernel_search_transparent_hugepage_sysfs($1)
> ++')
> +diff --git a/policy/modules/kernel/kernel.te
> +b/policy/modules/kernel/kernel.te index 26578a26d..57aa13fb0 100644
> +--- a/policy/modules/kernel/kernel.te
> ++++ b/policy/modules/kernel/kernel.te
> +@@ -69,6 +69,14 @@ type kvmfs_t;
> + fs_type(kvmfs_t)
> + genfscon kvmfs / gen_context(system_u:object_r:kvmfs_t,s0)
> +
> ++#
> ++#transparent_hugepage
> ++#
> ++
> ++type sysfs_transparent_hugepage_t;
> ++files_type(sysfs_transparent_hugepage_t)
> ++genfscon sysfs /kernel/mm/transparent_hugepage
> ++gen_context(system_u:object_r:sysfs_transparent_hugepage_t,s0)
> ++
> + #
> + # Procfs types
> + #
> +--
> +2.43.0
> +
> --
> 2.43.0
>

