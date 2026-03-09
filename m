Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0882F3C246
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 12:24:05 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12952.1773059037731864281
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Mar 2026 05:23:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=QBb/Zshx;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75285c4c5c=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6296Lb1g4160785
	for <yocto-patches@lists.yoctoproject.org>; Mon, 9 Mar 2026 12:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=bVHLkelp9biOczud19uEMrODMoTY/CRfENfLKKrwiFM=; b=QBb/ZshxzGrJ
	ygJgNXRHrLCdGcnFYkwdHQ0fqh752fJ57a6yKD6OcGwnfkgl140thvaYw1XxjrlN
	QsnNex/Zi1NpeYsaPYgNZ6JHhdImD4d9fmHe+0/Qq8Yx/YmzQyLgWe9LhBNovwEU
	u45i0vwBMrYVWTLZN3SqoXrg1gdRvYl+Jsv3/2YfHpUvU3zd06QF0luf9SDwfDdr
	3lpT8WCvLCxbmigZ+AnV65tbnhmAhq6JLbzyyvEi31XbJ2QQ7KdatRQBPdJCAuSy
	tHnzA01UZv80J3nYt1k/WZmnN5OZ8pd2v1XFg3BK3UgHeW5j4Kk4EUpqhe0JgzrC
	H27RxZjwNw==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010052.outbound.protection.outlook.com [52.101.85.52])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4crb081uc6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 09 Mar 2026 12:23:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrrY/phwyW3AUhcj7o6zC/2mysi1wOWtNZRaZc6W5Tk0laGpDY2lDT0iWGOLiyHdnJmJvilUI4k8tZXrfDscahb+sarJ3GkQvaw7x9JqcO3zSVdCLU5r/ntyMcdhv3nTeeaiIcGJ8eUozg0bsMxGkviDttt/VnppXqb9YvijwJ6IwaU6qL+J8UGrVafPINat4oF62/oR5I6Y8RZFgm9NcZ0ESvtIT7OdmCabfzy79NqWJgMDaNCsXGQq5Q312NyMuV1YScFTJOx3GatLNkLyb5y4476avlea/UOhVsRI7EeCQQTN4tSzPL7Kh9w2jof6Bj0q3o4gbh+OBPJmdVYuSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVHLkelp9biOczud19uEMrODMoTY/CRfENfLKKrwiFM=;
 b=kldjZjzursa8l5bPuGismIrv/E/fhkPsSXcUw8Dpaq9+6lgJd+Xi1VvmvZrCvIXEa6xMWAAfVi4aGDa6HiCJmzd4sAKhhTpLau2eJNd4H9XFqXGd9lormB3oknk297MKebGKgS8OWpW4t2hCTCbdGypottrSfo34ZwCfc+9+qvdve0eib5WdpkzBVBccXC8V5+ke5wk/I0XRrObz/8EuS7lNFMFpOmTYPs2sfuJk4AGY+xaiqECxgcOzarEnXk/HvTMPUD43Gi2r+q4L4VCZ7//46/lAMkl1UdTWt8+zUNnu5NvzTUNc3DtzYqDvinfvNbLM/90uXC4stya5gJVUMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 SN7PR11MB6945.namprd11.prod.outlook.com (2603:10b6:806:2a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 12:23:53 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831%6]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 12:23:53 +0000
Message-ID: <baff51f1-f0d9-4ae3-ba7f-bcbf1c0272c3@windriver.com>
Date: Mon, 9 Mar 2026 20:23:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-selinux][PATCH] Enable SELinux support in
 native packages
To: yocto-patches@lists.yoctoproject.org
References: <20260213154238.4093604-2-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <20260213154238.4093604-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SI2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:194::15) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|SN7PR11MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: 89f9f7a6-a897-4fae-9ec7-08de7dd6b933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	s98C30kAiNKEy9N2g8YwPEIIOyr3z9smszn8ltbnt1NrxhWPhsr5Um9C9Oci+4YexbsSOo1t75PRMCaiwm6J9v/juqTNX52n+KeeEv+domoQsB0I7aJ2cZAsimONhlvlmYS6DuRHVHEXNwJ55+4aL9eC0lFLUH2wIN4xmiYb5EB3drFPvX7VaI+t+PELdH816upgFR+9Ayy0/fx25PFl4KSvgFbMa2MiF2RuxPICgUbgh9d9MFBrDwsCtTbOG8j7nHvXu3uc+wS+kRJMAVWKlub17zNT4SBjCMwBUinhNukQKlgHxXzE+1lyfnvVfJsykGhs7sVt7o8reYjbUCL6fzfWlNEsB74r57Vp85ea+0FHWCvawu3CUZzVRn33a2MrdFZLYdP6IBbbGpDDja74pTbFjNXS9dlDg1nf2KRwNcoWQWCTaqqwvx6ry+2fhAT5F4uJwoW+3cmatXiy9Q53JVfLMEzHrujRrdpcT9NYask+e7jJ+b5mxa4hVznexPCusmj+RqFJ9vs2MEl7Zu/W8Q8wQ253darAVBxJR1GuK3E0y/ooV2LDTmDPPys5jQ3hDtbNcbBF1L8MuJ6sFcI7ovGKxakc+R2x4R7vNdMutlRDZ1hxRVJot4EpWYJq6xm+mYlpGWkzJocX6Qj8yDoLXBom9gGkfVH6eBxuthS+d0VhYkyOptaWLNlLA57YUuK3kadMoTy0jpJ10GJlpyL2YjJ0w8oXvYCfd0sP7TNEFCY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SDJ4TFRNbXJValErWlA4Z0E0Y2Ircy8yZ2w4R09EVmtsSGhzczZtNEJ1d1BI?=
 =?utf-8?B?cGxpSWtJZ2JLTHNVZWVHNzhaRTFWWnZLdWs0aVEyZjlLY3hDcFU4NHNVNVFm?=
 =?utf-8?B?UlNvVVNjeEVNVm8xRStMQ0tVWkdKUXh3V0NUUkU1VCs3TUduL2NDVnQ0RElY?=
 =?utf-8?B?WGcvMklKYmZPNzFucXZHaXJWVVB5YldZRnB1bU9yWjFZNUtMU0Zpc3d3MVVx?=
 =?utf-8?B?ZUVDa29xTXNlVEpEbjZKaGI1SlpqZlhPc0NJRW5EWTJwTVBJbGtOSFFGT1Ir?=
 =?utf-8?B?WEQxK3Q5QlFXMmR4OEdjUkJpcmw0MVQrbGlVNzFuVlBSNUsrL0sxQ0FkaThV?=
 =?utf-8?B?Q0VlMGxuWk5USitDLzVtS3g5LzdrVHpDaVI1cnFaeFVLQWxvVFZpNnZUeFlW?=
 =?utf-8?B?UTVuNjBtK2lyMjJkNkJvRVVOTnF5YVROT1dRcU9JY2taZFlTYUJsTHl2SUp4?=
 =?utf-8?B?OXE1RmxLRW8vUVFIU0o3bWlvdWhvV3V6MWowdlMvc251SHdRZitvb0dRWGp3?=
 =?utf-8?B?Sk5OTzhMSHpFODcxamxXSHp2QVRvV3Fvc0xGVFBlNGZVWjhHaDcwcGN0Vmcz?=
 =?utf-8?B?QkY1cFd5eWswVUdya3JtdUIrcE5iTVFoWVR3SmJ5U0kxUjA5YzE5c2VUc0dk?=
 =?utf-8?B?YVc5VFUrT1ZIaDFvZTl3M1ZER2FJZFVvbkRKaHV0OVNuMzRCTTJwQ0JDL012?=
 =?utf-8?B?V25PVlBNcEY4VGN3UHM3dlNkY2EzcHhHVUxGUGtBci81a3Bnc2lQd21kZGpV?=
 =?utf-8?B?QVBoakR4Q2c2aTY1alY4d0F1My9XMzV1TG93QVVYdFBnU2UwZ1pKeXV6ZUVM?=
 =?utf-8?B?MzlwWEZ1cTVwVjRFbUNiQ0Y0d0ZTakoxMjRBcm1XUVNEZkhROGwvbXkxVzhW?=
 =?utf-8?B?aU9vOHExeU50R3pneHhGTTNrdWdDb0NCT2VtdUtBc2JaSmNoS3Q5dnlJUHk3?=
 =?utf-8?B?S2NGNjRoRzRaUXJzdU9uMWdMd1Frb29hY3BIQWJHMHNsTk9PaGg3Y20wYVpl?=
 =?utf-8?B?Q1hCVEprTmg5ekZqN2N5QjhFanpacDh3SjNCNEUraUJVbDVqbG9xMjMwdGM4?=
 =?utf-8?B?clJMdHB4alRGTUFwR2tQWWVjSXk0RVhqWlgxb042d0R4Q3J3L0VvU3UxaUl1?=
 =?utf-8?B?THB1WjZJcTd3dUdHRE5hbU1jT3F6bmdDNVVPM3FCVUxBZk0xc3djanZydlRp?=
 =?utf-8?B?dzhOY0JmblFOYm93UDJkL3RYcnFvd2d1SkV5eGxicy9CT2VkZXdSajZEQjJD?=
 =?utf-8?B?UlNXdytIbVF2VWVhNkRkbE40YlVpYjgyWEd6aEc4QkhPek5oV0JJV0IwZWJq?=
 =?utf-8?B?WVJydXRGOGxIWFZUQk5XQ29RT3JVQk9SYlRKNURyek1VMlZYb056YzB5WXJw?=
 =?utf-8?B?Z0Q5NEc1NUV4QVI2TTlhM3Vrc1o1bGpWUE5ib3BEbE5ENTdQdGczYnlqTDRG?=
 =?utf-8?B?NDI2SnNiNWNzSm1HTGk3SDZ1RzVScmV4RU9CTTh4cFZkRm9xRjNUQTlEUEpB?=
 =?utf-8?B?QXYvdkxqdFQ2TGxtWG1QRndDUGpaQThzb1pwNFYvKzVKVDNrdmR1RHAzM0Zn?=
 =?utf-8?B?RnlRRWhEWlpjV0ZLeFNXdVdyODhUekRQMTF0OWVFY25Hc1N2S2t0VlBtSlpD?=
 =?utf-8?B?YUpLdmJsTEtrVlorb0VSWm5Lc1JlSjdWQXVHWk8vaE9ORm13OHo4UEdpUFlB?=
 =?utf-8?B?cXY5bGF0UTY2cjhDb0pxZmx2NnpkTzBFUkI4WUZ2ckNaQVJtMHZNZ1hxdThX?=
 =?utf-8?B?YnV1KzY4V1YydURZZ2JDa2xsR1ltbmtxNmJrZzY4WldDL2VnTitnMXFlNXlI?=
 =?utf-8?B?VXpnZFMxeitRTVI3RFFCb1BDYWRxWDVYNFVjUmNQQzR4YlBSWkp6TWpPZHB4?=
 =?utf-8?B?eFdnNDU1N2hJUmM3MmZiZUtSSm1QRUgyNGFoSGM0eXpJYm16bXZIVG1ydmky?=
 =?utf-8?B?bXVFQUVCTHdKTzRCOTBhZWNybCtyV2NHOGtWL09PZU9GZmxDRGVwek5aVjVF?=
 =?utf-8?B?WUhWemFMMXRvUk5rUmRGUE1hWitTWWRKSk9KMktoSGljdzRxYlN6M0RnTkJD?=
 =?utf-8?B?Q1g2TUlwelY0RlVxV1AwRWZCcjBEK1hVdTRDRjE5TTBSNGZDY2tCTFdINFRO?=
 =?utf-8?B?NkVLMVJHR0wrRXFTN1MzNE41bFVCd0ZuVlNBN0w3OTM2UExKT2QxTThLYm1o?=
 =?utf-8?B?MW9oSjlWdVpEMllOb2pja1JlckVCTUV3YUFEdU9WcWNkOEFPc1FhbU9tb3BI?=
 =?utf-8?B?bWE2Znl0c1lsdWh6VlJnckZrNEZ5cFhnNUlTVS9oenBER3R1MFlrenp5UG0w?=
 =?utf-8?B?OVYyYjVrbTJuTTRneEdNYkxHTVNTS0R5K0pLOGhKYlJ5R1dOSThmdz09?=
X-Exchange-RoutingPolicyChecked: 
	qoWSPZKMBeVePdqqLpwkK0ir9YV7/Z2jKzMrw/SHTVF3LmN0has6Z1bNF7ftvEujR4bQ3nqppZRG4H9eB0hk2ZPnXYAXi7noDS9VQFAK+X7R0bG5D56RHe8XvYYBy0YPfKkilc95ieDVrUpOpCH2CfETgF4ARpTURx3o7UJJhv/kDIq5PZQLB1LZWYWQXGCe7/YMsGoDP2mji3bipLpm8G+sxFrR1pspt9ISq9f0IeH+E1d0Gmsy0rGKYpUDi8yy4MzINuKLdZ9sXm3DWSHRn6HyQqlF1K8JcIKHFCg2cMjWsmWcBxFp3BWQlqVBfb9TiHDzpiHlgRFjJQkgjjqKuA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f9f7a6-a897-4fae-9ec7-08de7dd6b933
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 12:23:53.0068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgsYDRIN/GvkDEj4Ny9Kk9x+Cj7LfGR1EbakHV21qU2l46wYkFfZp/oe2JUFdKAlcPeohRhiWJr8qRYhN6zdxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6945
X-Proofpoint-GUID: YPS2RoO4nxy-NBtaGjnkn3c2gIYaf2-4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDExNCBTYWx0ZWRfX+tw9cvBlPWtq
 MEDtOuooIPodw9a8+/j3OxAcNB6GCqq7sbLBTBI9wbeP7pEm1Xx9taO/T6kv9595AAS38Mq9pSl
 rhS3TVGlUNe9vxr2SGT6zTzzKvrmkiWmYg3ZVXABMoJHnIeP4fPAC7tvYdMRU9a513WY/sVlye/
 m4sVRcBrcu71wM/s4tEyK87lIohgkEPqSZXZSrPZYP5xIjFFTYeYaYkf9DGVhepVS9w8jNBWsUt
 5Els81BxmNCGgoEbsR8OFSEe3p0VnMzX+7KKMm0y7wXsWOTwJaBaCYFwHE+1EpFzg9gGSydnqbd
 auSDhN+T6dwdzdR/NMfjCQZxIfxrl+Lru5tI7OSSG5+SaUE76Fo/JH0jOsnw1NvbCFcFxjEYcO1
 i2GTWD62vdULWj6QotOljWRg6Ph7Usdlh/YpIpGVxJAZFQwDiQtPvvWTzHa5phbDn0PkpiFdFtD
 nSdHXY/rcy/v8lqINzA==
X-Proofpoint-ORIG-GUID: YPS2RoO4nxy-NBtaGjnkn3c2gIYaf2-4
X-Authority-Analysis: v=2.4 cv=UahciaSN c=1 sm=1 tr=0 ts=69aebbdc cx=c_pps
 a=F2A7jaVQFOduNxX/8CKReg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22
 a=POU_gbibthNhdhzfzfYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090114
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 6296Lb1g4160785
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 09 Mar 2026 12:24:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3384


On 2/13/26 23:42, "Uwe Kleine-K=C3=B6nig wrote:
> With SELinux enabled for the target it makes sense to have SELinux
> support enabled for the native tools, too.
>
> Note that for native packages DISTRO_FEATURES is filtered, thus up to n=
ow
> it never contained "selinux". Append to DISTRO_FEATURES_FILTER_NATIVE t=
o
> make "selinux" propagate also to DISTRO_FEATURES for native packages.
> ---
> Hello,
>
> I use this on scarthgap, but the patch applies fine to master, too.
>
> During a debug session it took me quite a while to find out why
>
> 	ls -lZ "${IMAGE_ROOTFS}
>
> at the end of selinux_set_labels() didn't show the labels added by
> setfiles.
>
> Best regards
> Uwe
>
>   classes/enable-selinux.bbclass | 2 +-
>   conf/layer.conf                | 4 ++++
>   2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/classes/enable-selinux.bbclass b/classes/enable-selinux.bb=
class
> index 3dc61d6931ff..0c9f52e74cec 100644
> --- a/classes/enable-selinux.bbclass
> +++ b/classes/enable-selinux.bbclass
> @@ -1,3 +1,3 @@
>   inherit selinux
>  =20
> -PACKAGECONFIG:append =3D " ${@target_selinux(d, 'selinux')}"
> +PACKAGECONFIG:append =3D " ${@bb.utils.filter('DISTRO_FEATURES', 'seli=
nux', d)}"
> diff --git a/conf/layer.conf b/conf/layer.conf
> index 4e04e5cc7e6a..ca981db57019 100644
> --- a/conf/layer.conf
> +++ b/conf/layer.conf
> @@ -25,3 +25,7 @@ LAYERDEPENDS_selinux =3D " \
>   "
>  =20
>   PREFERRED_PROVIDER_virtual/refpolicy ??=3D "refpolicy-targeted"
> +
> +# With target support for SELinux it is very helpful during debug when=
 the
> +# native tools support SELinux, too.
> +DISTRO_FEATURES_FILTER_NATIVE:append =3D " selinux"

Can we add this to the doc (e.g. README) instead of enabling it directly=20
in layer.conf? Since we haven't directly enabled DISTRO_FEATURES =3D=20
"selinux" in layer.conf either.


Thanks,

Yi


>
> base-commit: 536df5a4fbce3c9fd63f51580f43d248a0d1b0ef

