Return-Path: <hongxu.jia@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C6AC021A0
	for <webhook@archiver.kernel.org>; Fri, 14 Feb 2025 03:16:16 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.12457.1739502966914985677
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Feb 2025 19:16:06 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=4140ca8725=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E3COLE005621;
	Thu, 13 Feb 2025 19:16:05 -0800
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 44qwy6ktup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 19:16:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRrqO4aokZlpzO3LgEQFIXY7bounYI0lljLhsXcVaglyRgSYNCDpwFnibT/taNKZA3E47iQlv8QQLj9FJw8b7UBa1MT6PRWPinY7cdA6ZIuFCxr/SfhfB0kdj0D7yC52rs+EyIxYNn9d4v7upvwB1YTdL5f1ECcl9vZzKU07lDWDmLshYav7fytzgjgYxBXmPbXMAyv60uzfDMJYJZQ8CVvH/1+w9peFjvgN50A3rdOiOHYRicEZSWEyMTIFcL0TL24k8BErSKCqM9fFX0ht6TqdX4Ua74ayuAK8Kj7ga4Tl6ipk1dmM1mzSg3+LJuaaHOtE/qkaE5t8s2sdr31Qbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEtfj+w2ezFu2MruZmntewOZWzpN0VLpbzY84/QS/Ps=;
 b=rTe9QeXQVcRmBcMwgQma0ovxSu78kwvrJ8OjzuzTbEY7kPOL2ttRzmDbiF5Pq99db0uaTk54jUjCD66cPhPUDWYUgAlqVVQgq41iOm343cUDSZr8DWWz9yhv80ca5otnnUdtpBwqhmQAc/3JtLcmHNcGwlhClp+UDDlOCbNu4DAgqTN92j2Vu9Xt9ETmugG3WYIaOfI9pY0g2ovGl0AGNcTNoGAf+vbE2VE3qjmx/LJ+Pqz2wD0HaDr+uhLHroi82LIkIFRwM1jIFEoHmvsLHiywXApG+QDAZiqqADowEA58R6Ec0nxwbFb0iG9LMKhzsFQLR8rnPhZjlqXedJb39w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20)
 by PH7PR11MB7499.namprd11.prod.outlook.com (2603:10b6:510:278::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 03:16:00 +0000
Received: from PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::ef64:bc9f:eb8c:e6e]) by PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::ef64:bc9f:eb8c:e6e%6]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 03:16:00 +0000
Message-ID: <99f262d4-ae7a-4802-a856-68f91f556dc6@windriver.com>
Date: Fri, 14 Feb 2025 11:15:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-tensorflow][kirkstone][PATCH 2/2]
 tensorflow: refresh and rename the .patch files
To: yocto-patches@lists.yoctoproject.org
Cc: Martin Jansa <martin.jansa@gmail.com>
References: <20250211161516.3084692-1-martin.jansa@gmail.com>
 <20250211161516.3084692-2-martin.jansa@gmail.com>
Content-Language: en-US
From: Hongxu Jia <hongxu.jia@windriver.com>
In-Reply-To: <20250211161516.3084692-2-martin.jansa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: TYWPR01CA0008.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::13) To PH7PR11MB7608.namprd11.prod.outlook.com
 (2603:10b6:510:269::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7608:EE_|PH7PR11MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: 17c760ff-7b42-4b83-6e4f-08dd4ca5e7de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|4022899009|366016|376014|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UjdSQzRSem1JbzgzU1UzRUdFbVJWSnFtRzlrV3RpaWtkQVEvV2NlTnFtd09G?=
 =?utf-8?B?L0pycjdxSkErRnlWVEJ5REZuNE1tWWFYbGwyMW9OUkt3eC9uV3ljMVl6NXNF?=
 =?utf-8?B?bFdMKytmK3RDZVAyR2JQL0pub1BVV2NobHQrdVhvRnFOZXJyVkg4Q0NyM3RN?=
 =?utf-8?B?WmgzTUZzVDRCcXNwRmdyUDJWb044NkZxV09VS3BoK1duSnRCRGo4S2d2S2dp?=
 =?utf-8?B?ZTJCSGxkand3a1JMdmFMRmJ0NDFSbUdVTi9sY3dQdEhsc2l4MWRCT2xKTEdP?=
 =?utf-8?B?RmVNa2JQV0dFTVJHZmI3U092UEVpdUlNd3NXZVd1U0kyYXBKbGRrNTBiM1k1?=
 =?utf-8?B?TncydjlIVHdhN0JGT2RoSDVJTmxuUm1VdG9Pekp3UFNDSEVQYlJBaVZvdmhD?=
 =?utf-8?B?S0lHTE04SEcrR3I5ZGRaNG5yaGgzeE5zc0txOVQzYVdXbFc2TkwvMjZCNitk?=
 =?utf-8?B?WjFqNzQvSGhHWmVSY1U2V0QzNDlId2hIcnZicG1XOG16b251aU5TM1ZwQXZJ?=
 =?utf-8?B?NWZFQmh6aVQwWVptWEJDemxOZHEvM2pNaHJmbE4zTWRQSnYrTjBNaDRFS3dZ?=
 =?utf-8?B?WlNEQkNoRWhMR3pLaVRvdHpIcHloejhSQWpkaWRCaTc5VjVnbU80MFB6a2VF?=
 =?utf-8?B?T244WG9xa2hIbVh6VTFZK1NKRUtCT2ZrZFNKc2U4NmNoR05RNWNJWERPdllS?=
 =?utf-8?B?SDVGUi8xNmpJczVEclFCNVJDdWd2dW9IZk9SaEJRWmQ3dlhRYnZOSlpBSUl0?=
 =?utf-8?B?MXN4eXdiOFpJNzA1OUtFTkVxdUE5ZG5LZTZvSTc2YXVIWFVVbmkvNFVaZmNl?=
 =?utf-8?B?cWFHbXBKL0hVSktKVmNoQXFNckUrV3laL0hDZjEwc2Y0WW92Zi8veHR5Rmlm?=
 =?utf-8?B?RW04ZkppWnZnRDBuUEwyQ01JZ3dCMmdkdVR2aDBXbGpkd09pMkFtOXZ0bUNL?=
 =?utf-8?B?VkowRTFQKzdmR3p5SlBhR2I3L0hhS0pKaDZlN1lnOGhMNCszOTMvY3pmRVFC?=
 =?utf-8?B?aVZnQlNudkxMRVROd2RWQ1NtQmRFQTdEN2pJWW05dGdFczlYdXhWTXl4K29W?=
 =?utf-8?B?VVhhY3QyeWk3bVpwc2hpQmZVejZxM3MwMUlVd2lmQlBaQytzaFpDQmVFa000?=
 =?utf-8?B?RC9LUkprUGRBN0xLc3lldC81UktFaGR1Zmh2WEdrTW42WWJQK2R0bnBycVhu?=
 =?utf-8?B?MVlHT0gwNGFHM0VzYkc1UG5GejZPVEVCaXdzbkxRajJCbnBvZkpmYzV4UnZE?=
 =?utf-8?B?VDBtMWI4c1ZoSkxIWHpua0ljOU9uNklrczVQUDdTd0FKTkdEMWZvdUVORUlT?=
 =?utf-8?B?QzhIcHRFcER6Tk1SMzd2S2t2anVKbXowWEJIaUlBVktSZ0tKRzZwTnJ3TWJF?=
 =?utf-8?B?Skw4ZWY2eGpwVHR1WlVtVEdwblFLTmhiYlJIa05qVFRMV21MR1RESHZQMDlh?=
 =?utf-8?B?ZGlYcENOckNBUXJzMm93Q2FxMHA4M1BDS3BPcUIydUdmVzVmTkJVazBURDM4?=
 =?utf-8?B?MVVUYUpTK0h5V2lEV3ExS1NHeEJyK0pQQXFETGJNT3pZUk5pUGZhZUdDOFBP?=
 =?utf-8?B?RWhwT1Y0QXNnZGdNK2xmS2RiNTB6clJJZFRkWGlqQ2MyQVUxVUNHdTVtaWhl?=
 =?utf-8?B?S1N0RXJBRnc5YXAzamZDWm5IRFlwaC9aeUFZVGN2a0M1d3llbGJpMW1xTGQv?=
 =?utf-8?B?ZlpMS0hKckliWUNMdzNjZ0tjbHd6Y05HQ2c0NXczYkdpVGtmWGJRa0NTRSs5?=
 =?utf-8?B?cFN3WXNCQUhoMXIxblkwU2pDbGw3ajhwU05YU0lPNFZjT1pjR2pYS2p1VmZo?=
 =?utf-8?B?RGtlQzVRL2FSQ0hGMk1sZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7608.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(4022899009)(366016)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aHBFZGo1UFBzcnFHbjdZSXhvQkszWFcwSVI0V1ZQbEc4NkZOUGFNc0xmNXE2?=
 =?utf-8?B?TzVCcy8wNjhsbEhKb1gvdmZJNjlCM284cHV3akFqNTlDdDRlb1RQcmM5TStv?=
 =?utf-8?B?UE9QNlpqeGhkMVFad1g4NlVYQ1gwS3JmM1dKTEVJZmpKRTVmck12ZDdBVDBJ?=
 =?utf-8?B?RXN1ZTVvWUZWd0xqWGZsRDRwWUFZWGM5RGw3YkJ4MzB6bXdxTjM3WWdZUDNN?=
 =?utf-8?B?N2xMMXdEakYyZHlNOHVYU2pqRFl5R280c0dmRzAvZHVkRGpUd2o4QjhOOE1y?=
 =?utf-8?B?NXBQZWlQbUh4Y0diRitpeHZQOUpOU0djSWN0WDhHVzBVOVJ3cUZPdG9JRWRU?=
 =?utf-8?B?SXh1RFV2RldnOC9NMmpzcDhMejRDdWwrZ3hTalBNU25uZ2xjUDY1empYdDNQ?=
 =?utf-8?B?dDIvaWp2ajNKUHplUUE1L1JEQU1RNGU3bDNVaXZVRGpEaWFlVEk5LzNyM3c3?=
 =?utf-8?B?RGg4enUrelN6RlpXOStIWFRwNTJEd2pydmVDZ0xPTmQ0YTFkVSt5TjhFOEJY?=
 =?utf-8?B?dVhWZzdISDI1MGdHOXdHcUxkZFNvTDdNMS9Gb093UFZvaDArTXlCVHp3UHl6?=
 =?utf-8?B?aEUzVGt3YjJaMk5WWU00S21ydTM0aDVuMmJndW9QZnB0Tm9UcUFkbk82RlhB?=
 =?utf-8?B?T2JzaUd6Syt4NEZ0NkFKRkowcVdTb20yQWROczFBdDkzNit1TGVOMk83Njl0?=
 =?utf-8?B?bnFRRFpnb3VJdnFsTkhMVVZibm5mMGdOTXZUMHRkUDBRSHNmTEt1Q05mb3pI?=
 =?utf-8?B?aE85TkF4SjI1bkRMakJBaHMrVHhDOEpBbFY5TEMrUUFjOXZMTkUvc3d6Tk9n?=
 =?utf-8?B?ZWhMZGNRNXNzY3ZUK3Npd1JidEpXVm9wVmw2NU5hdlFPeUxqMDAyemJVSEs4?=
 =?utf-8?B?ZC9yVUppOXhvUkM1NWRLbmwyUmJVMXhValFNc0dhb0loKytPNjNaNmxpVGVZ?=
 =?utf-8?B?U0Uxc3QxY1I5SzZyTEdHSHAvaXZzOTg2WVhjRHpMQ1R4aHh4RzhnSTQwMUdX?=
 =?utf-8?B?VVVWUExldU45a256S2M3L0twdVUwbE9hRkdLL29yVm1NSEhrRDFjY2FTYUxl?=
 =?utf-8?B?bzRGSno1L1RKYlQzMkU2OWxOK2RPMy9NNFg5LytBZXJFQ1VsUGE5WWxYRGpR?=
 =?utf-8?B?dmxsVlMrVHVGY3daa3pJVjhZMkt4RTQ5aHlRWEFIL3NPajBGRGpmdU9iZzlr?=
 =?utf-8?B?ZWluY29lVzZCcFJvRjBReDROQWI2T1Z5WkJ1SGRtMlNWK0w3Mm00Kytpa2F5?=
 =?utf-8?B?VW1rYThBdS9Gdm1vbkZ3MHdyejdaaEdMYXRsdGsyRVhEL3VnZ2JTejBqUkg2?=
 =?utf-8?B?STFtVUxSTEdvZzE5MDN0TENmelhvTk9pMk5RYko1OWxLRGgrVm82M3V2MHQ5?=
 =?utf-8?B?ckZzU0V2L0Mrckg2NGp5NjlzZlUyQXN6WC9vYnpCbis4cXZlYmRQTk5WWWN2?=
 =?utf-8?B?UUZ3MTRpb2U5a1hIQW5reDU3ampNazY0ejh0WldjWDR4MjB0NVY3NUdIN2NJ?=
 =?utf-8?B?dUk0SFhvNzlMbHNiaTZLWEtLdlF6K2MyT2NBdHg0aXhyZXNldzBISVU2YnpG?=
 =?utf-8?B?TG5KUkJkNG5iYWxpQTZaQng3YXJGd2F0dVZaWUx2dnliWHFuNWsxUWM5amUx?=
 =?utf-8?B?MnR2cUQzUDJpV3JKSWRkS2tsUWt1U3dvNnNtVTVXb29WOHBtaU5PcHRSVUVz?=
 =?utf-8?B?eEVEQ2JlTGJ0M3VGU0E4ZDl2Lzd6dHBoZW5FMW5KVndQME5BS2k2bEhFa0p4?=
 =?utf-8?B?bTVQYlM2Z3Y3M0NQYnM1RTFneGFyQndwRlpqeHU1dmZjNHh2SXdSaEwwVlZ0?=
 =?utf-8?B?cWJ2RFZzMUdqR1BiN0xoNVFUYnFKdjZISzlBRTVmNnhEYnhtUENTakV3anNE?=
 =?utf-8?B?cUZVWE1qemN3MnZzU1RzOGdWcG9KQUtOUGlmcXppUHZubmpqMkFJV1JCbjVz?=
 =?utf-8?B?YnNTUDN2T0ZvOW1Gc2RSTXljRWl0NHE0dzAzUXMxTHUvNGQ2RkJ6T3VtUXh6?=
 =?utf-8?B?L29aeUgyalFkcWIvYzVtK1llSGVYOUxjVmhpQkR2eHFMdlcvM2VwYlllY2M3?=
 =?utf-8?B?YnRUTFdhMU1SZ0hMR0x4ZnRFT0hDWVA5S1lsR0dsSnVLQ1ZMQU9sRFNtWjRL?=
 =?utf-8?B?emVYTUwxSDZnUFlDWUZ3THJlYnJ1OFRnTmtuVHpXazRGNCswZDRvRUJ6eTYx?=
 =?utf-8?B?RHc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c760ff-7b42-4b83-6e4f-08dd4ca5e7de
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7608.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 03:16:00.2433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aF3xvxiJsKDAGso5LkBeuiWC6+0a1m1x440XYxD+/deZr53b6jKcYm+gRLOwqQ91XXbgcz7aiVKOYzyqUhlhtWHHYNYgNNGp96sM6IMgcyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7499
X-Proofpoint-GUID: QY0Z7vfAhu4XqS-SvIJVOKVO61b7p0S0
X-Proofpoint-ORIG-GUID: QY0Z7vfAhu4XqS-SvIJVOKVO61b7p0S0
X-Authority-Analysis: v=2.4 cv=G8nmE8k5 c=1 sm=1 tr=0 ts=67aeb574 cx=c_pps a=S2IcI55zTQM2EKrhu3zyRw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=bRTqI5nwn0kA:10
 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8 a=3g80flMcAAAA:8 a=jPeWQ6RjAAAA:8 a=iGHA9ds3AAAA:8 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=IpJZQVW2AAAA:8 a=Qxrk1AHqYxzu6Os8ZXgA:9 a=BhMdqm2Wqc4Q2JL7t0yJfBCtM/Y=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ouV8bqFNGZoA:10
 a=3urWGuTZa-U-TZ_dHwj2:22 a=jPTqSWBWhtiCoVT8egAu:22 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22 a=IawgGOuG5U0WyFbmm1f5:22 a=hjSkjS1EZ2qA4F1bJaUS:22 a=NWVoK91CQySWRX1oVYDe:22 a=lAIPu-TSoPCgWs-2gwLQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_01,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 phishscore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2501170000
 definitions=main-2502140022
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 51E3COLE005621
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Feb 2025 03:16:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1082

Hi Martin,

Thanks for the submitting, but it failed to apply the patch, would you=20
please have a look

...
$ git am '[yocto-patches] [meta-tensorflow][scarthgap][PATCH 2_2]=20
tensorflow: refresh and rename the .patch files - "Martin Jansa via=20
lists.yoctoproject.org" <martin.
jansa=3Dgmail.com@lists.yoctoproject.org> - 2025-02-12 0014.eml'
Applying: tensorflow: refresh and rename the .patch files
error: patch failed:=20
recipes-framework/tensorflow/files/0001-use-local-bazel-to-workaround-baz=
el-paralle-issue.patch:24
error:=20
recipes-framework/tensorflow/files/0001-use-local-bazel-to-workaround-baz=
el-paralle-issue.patch:=20
patch does not apply
error: patch failed:=20
recipes-framework/tensorflow/files/0001-third_party-eigen_archive-workaro=
und-ice-failure-whi.patch:104
error:=20
recipes-framework/tensorflow/files/0001-third_party-eigen_archive-workaro=
und-ice-failure-whi.patch:=20
patch does not apply
error: patch failed:=20
recipes-framework/tensorflow/files/0001-drop-bazel_toolchains_repositorie=
s-to-support-offlin.patch:25
error:=20
recipes-framework/tensorflow/files/0001-drop-bazel_toolchains_repositorie=
s-to-support-offlin.patch:=20
patch does not apply
error: recipes-framework/tensorflow/files/0004-drop-v2-config.patch:=20
already exists in working directory
error: patch failed:=20
recipes-framework/tensorflow/files/0002-Replace-distutils.sysconfig.get_p=
ython_lib-with-sysc.patch:1
error:=20
recipes-framework/tensorflow/files/0002-Replace-distutils.sysconfig.get_p=
ython_lib-with-sysc.patch:=20
patch does not apply
error: recipes-framework/tensorflow/files/0001-hardcode-go-SDKS.patch:=20
does not exist in index
error: recipes-framework/tensorflow/files/0001-fix-build-failure.patch:=20
does not exist in index
error:=20
recipes-framework/tensorflow/files/0001-support-hermetic-Python.patch:=20
does not exist in index
error:=20
recipes-framework/tensorflow/files/0001-make-hermetic-python3-support-off=
line-build.patch:=20
does not exist in index
error:=20
recipes-framework/tensorflow/files/0001-Fix-build-with-gcc-12.patch:=20
does not exist in index
error: patch failed:=20
recipes-framework/tensorflow/files/0001-add-yocto-toolchain-to-support-cr=
oss-compiling.patch:1
error:=20
recipes-framework/tensorflow/files/0001-add-yocto-toolchain-to-support-cr=
oss-compiling.patch:=20
patch does not apply
error:=20
recipes-framework/tensorflow/files/0001-disable-avxvnni-for-x86.patch:=20
does not exist in index
error: patch failed:=20
recipes-framework/tensorflow/files/0001-fix-build-tensorflow-lite-example=
s-label_image-label.patch:21
error:=20
recipes-framework/tensorflow/files/0001-fix-build-tensorflow-lite-example=
s-label_image-label.patch:=20
patch does not apply
error: patch failed:=20
recipes-framework/tensorflow/files/0001-label_image-tweak-default-model-l=
ocation.patch:12
error:=20
recipes-framework/tensorflow/files/0001-label_image-tweak-default-model-l=
ocation.patch:=20
patch does not apply
error: patch failed:=20
recipes-framework/tensorflow/files/0001-label_image.lite-tweak-default-mo=
del-location.patch:30
error:=20
recipes-framework/tensorflow/files/0001-label_image.lite-tweak-default-mo=
del-location.patch:=20
patch does not apply
error: patch failed:=20
recipes-framework/tensorflow/files/0001-CheckFeatureOrDie-use-warning-to-=
avoid-die.patch:36
error:=20
recipes-framework/tensorflow/files/0001-CheckFeatureOrDie-use-warning-to-=
avoid-die.patch:=20
patch does not apply
error: patch failed:=20
recipes-framework/tensorflow/files/0001-support-32-bit-x64-and-arm-for-yo=
cto.patch:1
error:=20
recipes-framework/tensorflow/files/0001-support-32-bit-x64-and-arm-for-yo=
cto.patch:=20
patch does not apply
error:=20
recipes-framework/tensorflow/files/0001-build-api_gen_binary_target-as-ho=
st-tools.patch:=20
does not exist in index
error: recipes-framework/tensorflow/tensorflow-lite_2.16.1.bb: does not=20
exist in index
error: recipes-framework/tensorflow/tensorflow-native_2.16.1.bb: does=20
not exist in index
error: recipes-framework/tensorflow/tensorflow.inc: does not match index
error: recipes-framework/tensorflow/tensorflow_2.16.1.bb: does not exist=20
in index
Patch failed at 0001 tensorflow: refresh and rename the .patch files
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
...

The same issue on kirkstone, scarthgap,=C2=A0 mickledore and master branc=
h to=20
apply [PATCH 2_2] tensorflow: refresh and rename the .patch files

//Hongxu

On 2/12/25 00:15, Martin Jansa via lists.yoctoproject.org wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender =
and know the content is safe.
>
> * use --no-signature as devtool does to avoid unnecessary git signature
>    changes
> * rename to have increasing numbers in the order how they should
>    be applied (so they can be all easily applied with single git
>    am call)
>
> Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
> ---
>   .../tensorflow/files/0001-support-musl.patch  |  5 +---
>   ...l-to-workaround-bazel-paralle-issue.patch} |  9 +++----
>   ..._archive-workaround-ice-failure-whi.patch} | 11 +++-----
>   ...config.patch =3D> 0004-drop-v2-config.patch} |  9 +++----
>   ...ains_repositories-to-support-offlin.patch} |  5 +---
>   ....sysconfig.get_python_lib-with-sysc.patch} | 15 +++++------
>   ...oolchain-to-support-cross-compiling.patch} | 13 ++++------
>   ...low-lite-examples-label_image-label.patch} | 11 +++-----
>   ..._image-tweak-default-model-location.patch} |  7 ++---
>   ...e.lite-tweak-default-model-location.patch} |  5 +---
>   ...atureOrDie-use-warning-to-avoid-die.patch} |  5 +---
>   ...upport-32-bit-x64-and-arm-for-yocto.patch} | 17 +++++-------
>   ...ct_host_configuration-false-by-defa.patch} |  9 +++----
>   ...-is-deprecated-in-Python-3.10-51776.patch} |  5 +---
>   .../tensorflow/tensorflow-lite_2.10.0.bb      | 26 +++++++++---------=
-
>   recipes-framework/tensorflow/tensorflow.inc   | 15 +++++------
>   .../tensorflow/tensorflow_2.10.0.bb           | 26 +++++++++---------=
-
>   17 files changed, 75 insertions(+), 118 deletions(-)
>   rename recipes-framework/tensorflow/files/{0001-use-local-bazel-to-wo=
rkaround-bazel-paralle-issue.patch =3D> 0002-use-local-bazel-to-workaroun=
d-bazel-paralle-issue.patch} (79%)
>   rename recipes-framework/tensorflow/files/{0001-third_party-eigen_arc=
hive-workaround-ice-failure-whi.patch =3D> 0003-third_party-eigen_archive=
-workaround-ice-failure-whi.patch} (95%)
>   rename recipes-framework/tensorflow/files/{0001-drop-v2-config.patch =
=3D> 0004-drop-v2-config.patch} (79%)
>   rename recipes-framework/tensorflow/files/{0001-drop-bazel_toolchains=
_repositories-to-support-offlin.patch =3D> 0005-drop-bazel_toolchains_rep=
ositories-to-support-offlin.patch} (94%)
>   rename recipes-framework/tensorflow/files/{0002-Replace-distutils.sys=
config.get_python_lib-with-sysc.patch =3D> 0006-Replace-distutils.sysconf=
ig.get_python_lib-with-sysc.patch} (90%)
>   rename recipes-framework/tensorflow/files/{0001-add-yocto-toolchain-t=
o-support-cross-compiling.patch =3D> 0007-add-yocto-toolchain-to-support-=
cross-compiling.patch} (91%)
>   rename recipes-framework/tensorflow/files/{0001-fix-build-tensorflow-=
lite-examples-label_image-label.patch =3D> 0008-fix-build-tensorflow-lite=
-examples-label_image-label.patch} (85%)
>   rename recipes-framework/tensorflow/files/{0001-label_image-tweak-def=
ault-model-location.patch =3D> 0009-label_image-tweak-default-model-locat=
ion.patch} (95%)
>   rename recipes-framework/tensorflow/files/{0001-label_image.lite-twea=
k-default-model-location.patch =3D> 0010-label_image.lite-tweak-default-m=
odel-location.patch} (94%)
>   rename recipes-framework/tensorflow/files/{0001-CheckFeatureOrDie-use=
-warning-to-avoid-die.patch =3D> 0011-CheckFeatureOrDie-use-warning-to-av=
oid-die.patch} (95%)
>   rename recipes-framework/tensorflow/files/{0001-support-32-bit-x64-an=
d-arm-for-yocto.patch =3D> 0012-support-32-bit-x64-and-arm-for-yocto.patc=
h} (91%)
>   rename recipes-framework/tensorflow/files/{0001-Revert-set-distinct_h=
ost_configuration-false-by-defa.patch =3D> 0013-Revert-set-distinct_host_=
configuration-false-by-defa.patch} (81%)
>   rename recipes-framework/tensorflow/files/{0001-distutils-is-deprecat=
ed-in-Python-3.10-cross.patch =3D> 0014-distutils-is-deprecated-in-Python=
-3.10-51776.patch} (96%)
>
> diff --git a/recipes-framework/tensorflow/files/0001-support-musl.patch=
 b/recipes-framework/tensorflow/files/0001-support-musl.patch
> index 355b0cb..76d5e2f 100644
> --- a/recipes-framework/tensorflow/files/0001-support-musl.patch
> +++ b/recipes-framework/tensorflow/files/0001-support-musl.patch
> @@ -1,4 +1,4 @@
> -From a37010bee0ef08a2b42c10fc6ca1f3bd793b0e6a Mon Sep 17 00:00:00 2001
> +From 80ff19bdafd336108779bf110dea4ee2d115242c Mon Sep 17 00:00:00 2001
>   From: Hongxu Jia <hongxu.jia@windriver.com>
>   Date: Tue, 8 Dec 2020 17:06:52 +0800
>   Subject: [PATCH] support musl
> @@ -45,6 +45,3 @@ index 70fcdc27042..f38fe71c917 100644
>    #define TF_GENERATE_STACKTRACE
>    #endif
>
> ---
> -2.18.2
> -
> diff --git a/recipes-framework/tensorflow/files/0001-use-local-bazel-to=
-workaround-bazel-paralle-issue.patch b/recipes-framework/tensorflow/file=
s/0002-use-local-bazel-to-workaround-bazel-paralle-issue.patch
> similarity index 79%
> rename from recipes-framework/tensorflow/files/0001-use-local-bazel-to-=
workaround-bazel-paralle-issue.patch
> rename to recipes-framework/tensorflow/files/0002-use-local-bazel-to-wo=
rkaround-bazel-paralle-issue.patch
> index 8a17700..04396fa 100644
> --- a/recipes-framework/tensorflow/files/0001-use-local-bazel-to-workar=
ound-bazel-paralle-issue.patch
> +++ b/recipes-framework/tensorflow/files/0002-use-local-bazel-to-workar=
ound-bazel-paralle-issue.patch
> @@ -1,4 +1,4 @@
> -From bbdf1bbca17f8bce98e32b25aa9bfadc8f465f24 Mon Sep 17 00:00:00 2001
> +From 856e20e86e771224963d5791d57c8f6e802b1450 Mon Sep 17 00:00:00 2001
>   From: Hongxu Jia <hongxu.jia@windriver.com>
>   Date: Sun, 15 May 2022 23:59:17 -0700
>   Subject: [PATCH] use local bazel to workaround bazel paralle issue
> @@ -12,10 +12,10 @@ Signed-off-by: Julien STEPHAN <jstephan@baylibre.co=
m>
>    1 file changed, 1 insertion(+), 1 deletion(-)
>
>   diff --git a/configure.py b/configure.py
> -index dae3dce89d3..979f00f3633 100644
> +index bf338bdda22..034e7c7c67f 100644
>   --- a/configure.py
>   +++ b/configure.py
> -@@ -475,7 +475,7 @@ def check_bazel_version(min_version, max_version):
> +@@ -420,7 +420,7 @@ def retrieve_bazel_version():
>      Returns:
>        The bazel version detected.
>      """
> @@ -24,6 +24,3 @@ index dae3dce89d3..979f00f3633 100644
>      if bazel_executable is None:
>        bazel_executable =3D which('bazelisk')
>        if bazel_executable is None:
> ---
> -2.36.0
> -
> diff --git a/recipes-framework/tensorflow/files/0001-third_party-eigen_=
archive-workaround-ice-failure-whi.patch b/recipes-framework/tensorflow/f=
iles/0003-third_party-eigen_archive-workaround-ice-failure-whi.patch
> similarity index 95%
> rename from recipes-framework/tensorflow/files/0001-third_party-eigen_a=
rchive-workaround-ice-failure-whi.patch
> rename to recipes-framework/tensorflow/files/0003-third_party-eigen_arc=
hive-workaround-ice-failure-whi.patch
> index 2056c20..821f31f 100644
> --- a/recipes-framework/tensorflow/files/0001-third_party-eigen_archive=
-workaround-ice-failure-whi.patch
> +++ b/recipes-framework/tensorflow/files/0003-third_party-eigen_archive=
-workaround-ice-failure-whi.patch
> @@ -1,4 +1,4 @@
> -From 385074d9300c18293a42c9d8ca9fb12cbffccb80 Mon Sep 17 00:00:00 2001
> +From ce9fd298ef95a3399d66fb8b9c3c15ff975d2e64 Mon Sep 17 00:00:00 2001
>   From: Hongxu Jia <hongxu.jia@windriver.com>
>   Date: Mon, 16 May 2022 23:15:47 -0700
>   Subject: [PATCH] third_party/eigen_archive:workaround ice failure whi=
le
> @@ -14,14 +14,14 @@ Upstream-Status: Inappropriate [wr-installer specif=
ic]
>
>   Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
>   ---
> - ...ailure-while-building-from-source-wi.patch | 69 ++++++++++++++++++=
+
> + ...ailure-while-building-from-source-wi.patch | 67 ++++++++++++++++++=
+
>    third_party/eigen3/workspace.bzl              |  1 +
> - 2 files changed, 70 insertions(+)
> + 2 files changed, 68 insertions(+)
>    create mode 100644 third_party/eigen3/0001-workaround-ice-failure-wh=
ile-building-from-source-wi.patch
>
>   diff --git a/third_party/eigen3/0001-workaround-ice-failure-while-bui=
lding-from-source-wi.patch b/third_party/eigen3/0001-workaround-ice-failu=
re-while-building-from-source-wi.patch
>   new file mode 100644
> -index 00000000000..436f35fca13
> +index 00000000000..6032258ed82
>   --- /dev/null
>   +++ b/third_party/eigen3/0001-workaround-ice-failure-while-building-f=
rom-source-wi.patch
>   @@ -0,0 +1,67 @@
> @@ -104,6 +104,3 @@ index 1380722ee67..722cfbece83 100644
>            sha256 =3D EIGEN_SHA256,
>            strip_prefix =3D "eigen-{commit}".format(commit =3D EIGEN_CO=
MMIT),
>            urls =3D tf_mirror_urls("https://gitlab.com/libeigen/eigen/-=
/archive/{commit}/eigen-{commit}.tar.gz".format(commit =3D EIGEN_COMMIT))=
,
> ---
> -2.37.1
> -
> diff --git a/recipes-framework/tensorflow/files/0001-drop-v2-config.pat=
ch b/recipes-framework/tensorflow/files/0004-drop-v2-config.patch
> similarity index 79%
> rename from recipes-framework/tensorflow/files/0001-drop-v2-config.patc=
h
> rename to recipes-framework/tensorflow/files/0004-drop-v2-config.patch
> index ff74a3c..63f5b67 100644
> --- a/recipes-framework/tensorflow/files/0001-drop-v2-config.patch
> +++ b/recipes-framework/tensorflow/files/0004-drop-v2-config.patch
> @@ -1,4 +1,4 @@
> -From 104224b8b30f74dabed893aa057f400ad7cd2695 Mon Sep 17 00:00:00 2001
> +From 938ce13d91b6d0cbf6bc5199094629ab26431129 Mon Sep 17 00:00:00 2001
>   From: Hongxu Jia <hongxu.jia@windriver.com>
>   Date: Mon, 16 May 2022 00:10:55 -0700
>   Subject: [PATCH] drop v2 config
> @@ -11,10 +11,10 @@ Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com=
>
>    1 file changed, 3 deletions(-)
>
>   diff --git a/.bazelrc b/.bazelrc
> -index b6a72c1e5d3..a71ade6950f 100644
> +index 9cc8c84673b..4d46f9b2a85 100644
>   --- a/.bazelrc
>   +++ b/.bazelrc
> -@@ -138,9 +138,6 @@ build --define=3Dwith_xla_support=3Dtrue
> +@@ -134,9 +134,6 @@ build --define=3Dwith_xla_support=3Dtrue
>    # TODO(mihaimaruseac): Document this option or remove if no longer n=
eeded
>    build --config=3Dshort_logs
>
> @@ -24,6 +24,3 @@ index b6a72c1e5d3..a71ade6950f 100644
>    # Disable AWS/HDFS support by default
>    build --define=3Dno_aws_support=3Dtrue
>    build --define=3Dno_hdfs_support=3Dtrue
> ---
> -2.36.0
> -
> diff --git a/recipes-framework/tensorflow/files/0001-drop-bazel_toolcha=
ins_repositories-to-support-offlin.patch b/recipes-framework/tensorflow/f=
iles/0005-drop-bazel_toolchains_repositories-to-support-offlin.patch
> similarity index 94%
> rename from recipes-framework/tensorflow/files/0001-drop-bazel_toolchai=
ns_repositories-to-support-offlin.patch
> rename to recipes-framework/tensorflow/files/0005-drop-bazel_toolchains=
_repositories-to-support-offlin.patch
> index 730f2c2..59b2e60 100644
> --- a/recipes-framework/tensorflow/files/0001-drop-bazel_toolchains_rep=
ositories-to-support-offlin.patch
> +++ b/recipes-framework/tensorflow/files/0005-drop-bazel_toolchains_rep=
ositories-to-support-offlin.patch
> @@ -1,4 +1,4 @@
> -From 6bb9c02aae20996a6e4edd8fe743a90ce8d677aa Mon Sep 17 00:00:00 2001
> +From f3ccd400246a3bf2ef3656b3d5e12b5d99172815 Mon Sep 17 00:00:00 2001
>   From: Hongxu Jia <hongxu.jia@windriver.com>
>   Date: Sun, 18 Sep 2022 23:52:34 -0700
>   Subject: [PATCH] drop bazel_toolchains_repositories to support offlin=
e build
> @@ -34,6 +34,3 @@ index c3c081b19ef..445de71bb13 100644
>        # Apple rules for Bazel. https://github.com/bazelbuild/rules_app=
le.
>        # Note: We add this to fix Kokoro builds.
>        # The rules below call into `rules_proto` but the hash has chang=
ed and
> ---
> -2.37.1
> -
> diff --git a/recipes-framework/tensorflow/files/0002-Replace-distutils.=
sysconfig.get_python_lib-with-sysc.patch b/recipes-framework/tensorflow/f=
iles/0006-Replace-distutils.sysconfig.get_python_lib-with-sysc.patch
> similarity index 90%
> rename from recipes-framework/tensorflow/files/0002-Replace-distutils.s=
ysconfig.get_python_lib-with-sysc.patch
> rename to recipes-framework/tensorflow/files/0006-Replace-distutils.sys=
config.get_python_lib-with-sysc.patch
> index 9ce46ee..9eb170d 100644
> --- a/recipes-framework/tensorflow/files/0002-Replace-distutils.sysconf=
ig.get_python_lib-with-sysc.patch
> +++ b/recipes-framework/tensorflow/files/0006-Replace-distutils.sysconf=
ig.get_python_lib-with-sysc.patch
> @@ -1,7 +1,7 @@
> -From 5dc007d64a9928d379851a6524a376bfdb819c6d Mon Sep 17 00:00:00 2001
> +From 8eeeb59072d85ea2bdffc71ca0c7f1664140f1a1 Mon Sep 17 00:00:00 2001
>   From: Hongxu Jia <hongxu.jia@windriver.com>
>   Date: Mon, 16 May 2022 00:17:02 -0700
> -Subject: [PATCH] Replace distutils.sysconfig.get_python_lib() with
> +Subject: [PATCH] Replace distutils.sysconfig.get_python_lib() with
>    sysconfig.get_path('purelib') - python 3.10 support
>
>   This is part of the effort for 51776 to get python 3.10 support.
> @@ -21,7 +21,7 @@ Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
>    2 files changed, 4 insertions(+), 6 deletions(-)
>
>   diff --git a/tensorflow/api_template.__init__.py b/tensorflow/api_tem=
plate.__init__.py
> -index 1ed97439b06..58904070e62 100644
> +index 3bb0bb91ba6..7de533deee1 100644
>   --- a/tensorflow/api_template.__init__.py
>   +++ b/tensorflow/api_template.__init__.py
>   @@ -26,7 +26,7 @@ only a placeholder to enable test cases to run. The=
 TensorFlow build replaces
> @@ -33,7 +33,7 @@ index 1ed97439b06..58904070e62 100644
>    import inspect as _inspect
>    import logging as _logging
>    import os as _os
> -@@ -122,8 +122,7 @@ _site_packages_dirs +=3D [_p for _p in _sys.path i=
f 'site-packages' in _p]
> +@@ -117,8 +117,7 @@ _site_packages_dirs +=3D [_p for _p in _sys.path i=
f 'site-packages' in _p]
>    if 'getsitepackages' in dir(_site):
>      _site_packages_dirs +=3D _site.getsitepackages()
>
> @@ -44,7 +44,7 @@ index 1ed97439b06..58904070e62 100644
>    _site_packages_dirs =3D list(set(_site_packages_dirs))
>
>   diff --git a/tensorflow/api_template_v1.__init__.py b/tensorflow/api_=
template_v1.__init__.py
> -index 87d9bc1f204..70e0fd70c34 100644
> +index f11fedce109..f21296e7528 100644
>   --- a/tensorflow/api_template_v1.__init__.py
>   +++ b/tensorflow/api_template_v1.__init__.py
>   @@ -14,7 +14,7 @@
> @@ -56,7 +56,7 @@ index 87d9bc1f204..70e0fd70c34 100644
>    import inspect as _inspect
>    import os as _os
>    import site as _site
> -@@ -163,8 +163,7 @@ _site_packages_dirs +=3D [_p for _p in _sys.path i=
f 'site-packages' in _p]
> +@@ -158,8 +158,7 @@ _site_packages_dirs +=3D [_p for _p in _sys.path i=
f 'site-packages' in _p]
>    if 'getsitepackages' in dir(_site):
>      _site_packages_dirs +=3D _site.getsitepackages()
>
> @@ -66,6 +66,3 @@ index 87d9bc1f204..70e0fd70c34 100644
>
>    _site_packages_dirs =3D list(set(_site_packages_dirs))
>
> ---
> -2.36.0
> -
> diff --git a/recipes-framework/tensorflow/files/0001-add-yocto-toolchai=
n-to-support-cross-compiling.patch b/recipes-framework/tensorflow/files/0=
007-add-yocto-toolchain-to-support-cross-compiling.patch
> similarity index 91%
> rename from recipes-framework/tensorflow/files/0001-add-yocto-toolchain=
-to-support-cross-compiling.patch
> rename to recipes-framework/tensorflow/files/0007-add-yocto-toolchain-t=
o-support-cross-compiling.patch
> index 62804ec..3515ae6 100644
> --- a/recipes-framework/tensorflow/files/0001-add-yocto-toolchain-to-su=
pport-cross-compiling.patch
> +++ b/recipes-framework/tensorflow/files/0007-add-yocto-toolchain-to-su=
pport-cross-compiling.patch
> @@ -1,4 +1,4 @@
> -From 2bc17fd2dfa2e4d6b0cbedf692a31b56e02cf6e6 Mon Sep 17 00:00:00 2001
> +From b3759f094bc1bfcb74b0c828f2f6c4637364cb9f Mon Sep 17 00:00:00 2001
>   From: Hongxu Jia <hongxu.jia@windriver.com>
>   Date: Mon, 16 May 2022 00:31:42 -0700
>   Subject: [PATCH] add yocto toolchain to support cross compiling
> @@ -27,10 +27,10 @@ index 1286ef9ac03..3ed96c1052d 100644
>   +    build_file =3D "//:BUILD.yocto_compiler",
>   +)
>   diff --git a/tensorflow/BUILD b/tensorflow/BUILD
> -index 92e11a68e8d..7ae7fc79356 100644
> +index 19ee8000206..d01b55aaa92 100644
>   --- a/tensorflow/BUILD
>   +++ b/tensorflow/BUILD
> -@@ -207,6 +207,15 @@ config_setting(
> +@@ -259,6 +259,15 @@ config_setting(
>        visibility =3D ["//visibility:public"],
>    )
>
> @@ -47,7 +47,7 @@ index 92e11a68e8d..7ae7fc79356 100644
>        name =3D "android_arm",
>        flag_values =3D if_google(
>   diff --git a/tensorflow/workspace2.bzl b/tensorflow/workspace2.bzl
> -index 77c76aa6e20..f5c323174d5 100644
> +index e255103df98..a49aeeb7434 100644
>   --- a/tensorflow/workspace2.bzl
>   +++ b/tensorflow/workspace2.bzl
>   @@ -10,6 +10,7 @@ load("//third_party/git:git_configure.bzl", "git_co=
nfigure")
> @@ -58,7 +58,7 @@ index 77c76aa6e20..f5c323174d5 100644
>    load("//tensorflow/tools/toolchains/embedded/arm-linux:arm_linux_too=
lchain_configure.bzl", "arm_linux_toolchain_configure")
>    load("//third_party:repo.bzl", "tf_http_archive", "tf_mirror_urls")
>    load("//third_party/clang_toolchain:cc_configure_clang.bzl", "cc_dow=
nload_clang_toolchain")
> -@@ -114,6 +115,13 @@ def _tf_toolchains():
> +@@ -109,6 +110,13 @@ def _tf_toolchains():
>            remote_config_repo_aarch64 =3D "../aarch64_compiler",
>        )
>
> @@ -72,6 +72,3 @@ index 77c76aa6e20..f5c323174d5 100644
>        # TFLite crossbuild toolchain for embeddeds Linux
>        arm_linux_toolchain_configure(
>            name =3D "local_config_embedded_arm",
> ---
> -2.36.0
> -
> diff --git a/recipes-framework/tensorflow/files/0001-fix-build-tensorfl=
ow-lite-examples-label_image-label.patch b/recipes-framework/tensorflow/f=
iles/0008-fix-build-tensorflow-lite-examples-label_image-label.patch
> similarity index 85%
> rename from recipes-framework/tensorflow/files/0001-fix-build-tensorflo=
w-lite-examples-label_image-label.patch
> rename to recipes-framework/tensorflow/files/0008-fix-build-tensorflow-=
lite-examples-label_image-label.patch
> index 0502c5b..490c49b 100644
> --- a/recipes-framework/tensorflow/files/0001-fix-build-tensorflow-lite=
-examples-label_image-label.patch
> +++ b/recipes-framework/tensorflow/files/0008-fix-build-tensorflow-lite=
-examples-label_image-label.patch
> @@ -1,4 +1,4 @@
> -From 1af9e2180f680c1b0c94fbeeaee9dc522f353d07 Mon Sep 17 00:00:00 2001
> +From 26aa60bece56d2d9ffbd387b2e4f079cd1effa6d Mon Sep 17 00:00:00 2001
>   From: Hongxu Jia <hongxu.jia@windriver.com>
>   Date: Tue, 17 Aug 2021 16:00:24 +0800
>   Subject: [PATCH] fix build //tensorflow/lite/examples/label_image:lab=
el_image
> @@ -21,10 +21,10 @@ Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com=
>
>    1 file changed, 8 insertions(+)
>
>   diff --git a/tensorflow/lite/kernels/internal/BUILD b/tensorflow/lite=
/kernels/internal/BUILD
> -index 8c714fc282d..6ea96e4f103 100644
> +index 095c75c626e..744d7a6e82b 100644
>   --- a/tensorflow/lite/kernels/internal/BUILD
>   +++ b/tensorflow/lite/kernels/internal/BUILD
> -@@ -112,6 +112,13 @@ config_setting(
> +@@ -114,6 +114,13 @@ config_setting(
>        },
>    )
>
> @@ -38,7 +38,7 @@ index 8c714fc282d..6ea96e4f103 100644
>    config_setting(
>        name =3D "haswell",
>        values =3D {
> -@@ -235,6 +242,7 @@ selects.config_setting_group(
> +@@ -244,6 +251,7 @@ selects.config_setting_group(
>            ":arm",
>            ":arm64-v8a",
>            ":armeabi-v7a",
> @@ -46,6 +46,3 @@ index 8c714fc282d..6ea96e4f103 100644
>            ":armhf",
>            ":armv7a",
>            ":ios_armv7",
> ---
> -2.27.0
> -
> diff --git a/recipes-framework/tensorflow/files/0001-label_image-tweak-=
default-model-location.patch b/recipes-framework/tensorflow/files/0009-la=
bel_image-tweak-default-model-location.patch
> similarity index 95%
> rename from recipes-framework/tensorflow/files/0001-label_image-tweak-d=
efault-model-location.patch
> rename to recipes-framework/tensorflow/files/0009-label_image-tweak-def=
ault-model-location.patch
> index 5962c90..0a6d581 100644
> --- a/recipes-framework/tensorflow/files/0001-label_image-tweak-default=
-model-location.patch
> +++ b/recipes-framework/tensorflow/files/0009-label_image-tweak-default=
-model-location.patch
> @@ -1,4 +1,4 @@
> -From 17e03724c925f8d0b11c8f14699646aa498af798 Mon Sep 17 00:00:00 2001
> +From 2d65aad61ad4c349e39aa67fd379d21e54818b64 Mon Sep 17 00:00:00 2001
>   From: Hongxu Jia <hongxu.jia@windriver.com>
>   Date: Mon, 16 May 2022 00:36:00 -0700
>   Subject: [PATCH] label_image: tweak default model location
> @@ -30,7 +30,7 @@ index 3e4bc1ddaab..83558251d77 100644
>      input_width =3D 299
>      input_mean =3D 0
>   diff --git a/tensorflow/examples/label_image/main.cc b/tensorflow/exa=
mples/label_image/main.cc
> -index 13bb5980276..38935a57dd4 100644
> +index 3a5d44eb669..fcf8dcb7644 100644
>   --- a/tensorflow/examples/label_image/main.cc
>   +++ b/tensorflow/examples/label_image/main.cc
>   @@ -279,11 +279,11 @@ int main(int argc, char* argv[]) {
> @@ -48,6 +48,3 @@ index 13bb5980276..38935a57dd4 100644
>      int32_t input_width =3D 299;
>      int32_t input_height =3D 299;
>      float input_mean =3D 0;
> ---
> -2.36.0
> -
> diff --git a/recipes-framework/tensorflow/files/0001-label_image.lite-t=
weak-default-model-location.patch b/recipes-framework/tensorflow/files/00=
10-label_image.lite-tweak-default-model-location.patch
> similarity index 94%
> rename from recipes-framework/tensorflow/files/0001-label_image.lite-tw=
eak-default-model-location.patch
> rename to recipes-framework/tensorflow/files/0010-label_image.lite-twea=
k-default-model-location.patch
> index 597021a..f4f7cf4 100644
> --- a/recipes-framework/tensorflow/files/0001-label_image.lite-tweak-de=
fault-model-location.patch
> +++ b/recipes-framework/tensorflow/files/0010-label_image.lite-tweak-de=
fault-model-location.patch
> @@ -1,4 +1,4 @@
> -From dd73bef88a23d29299bc6e2f3c892ed81d65a86c Mon Sep 17 00:00:00 2001
> +From 7fb242d6ecefb6c8749d18ec64af24cfee257207 Mon Sep 17 00:00:00 2001
>   From: Hongxu Jia <hongxu.jia@windriver.com>
>   Date: Wed, 9 Dec 2020 09:53:30 +0800
>   Subject: [PATCH] label_image.lite: tweak default model location
> @@ -30,6 +30,3 @@ index 1c00edb6558..a5bcf8c64d8 100644
>      int number_of_threads =3D 4;
>      int number_of_results =3D 5;
>      int max_profiling_buffer_entries =3D 1024;
> ---
> -2.18.2
> -
> diff --git a/recipes-framework/tensorflow/files/0001-CheckFeatureOrDie-=
use-warning-to-avoid-die.patch b/recipes-framework/tensorflow/files/0011-=
CheckFeatureOrDie-use-warning-to-avoid-die.patch
> similarity index 95%
> rename from recipes-framework/tensorflow/files/0001-CheckFeatureOrDie-u=
se-warning-to-avoid-die.patch
> rename to recipes-framework/tensorflow/files/0011-CheckFeatureOrDie-use=
-warning-to-avoid-die.patch
> index 7bde666..404910c 100644
> --- a/recipes-framework/tensorflow/files/0001-CheckFeatureOrDie-use-war=
ning-to-avoid-die.patch
> +++ b/recipes-framework/tensorflow/files/0011-CheckFeatureOrDie-use-war=
ning-to-avoid-die.patch
> @@ -1,4 +1,4 @@
> -From 1455cd4232f382b73cb4ff6dfa6ccc7bd5197428 Mon Sep 17 00:00:00 2001
> +From d038e1a80360361369b5e0f6c92a0bea611ddd9d Mon Sep 17 00:00:00 2001
>   From: Hongxu Jia <hongxu.jia@windriver.com>
>   Date: Mon, 16 May 2022 00:39:33 -0700
>   Subject: [PATCH] CheckFeatureOrDie: use warning to avoid die
> @@ -36,6 +36,3 @@ index 11a438925c1..9874ed34793 100644
>      }
>    }
>
> ---
> -2.36.0
> -
> diff --git a/recipes-framework/tensorflow/files/0001-support-32-bit-x64=
-and-arm-for-yocto.patch b/recipes-framework/tensorflow/files/0012-suppor=
t-32-bit-x64-and-arm-for-yocto.patch
> similarity index 91%
> rename from recipes-framework/tensorflow/files/0001-support-32-bit-x64-=
and-arm-for-yocto.patch
> rename to recipes-framework/tensorflow/files/0012-support-32-bit-x64-an=
d-arm-for-yocto.patch
> index 5eae2fd..8a192d3 100644
> --- a/recipes-framework/tensorflow/files/0001-support-32-bit-x64-and-ar=
m-for-yocto.patch
> +++ b/recipes-framework/tensorflow/files/0012-support-32-bit-x64-and-ar=
m-for-yocto.patch
> @@ -1,4 +1,4 @@
> -From 73fffc29b6384c2695fa221fac9067c9661af4de Mon Sep 17 00:00:00 2001
> +From 294bf761d1fee1771b5b1636f00910659d6ba38a Mon Sep 17 00:00:00 2001
>   From: Hongxu Jia <hongxu.jia@windriver.com>
>   Date: Mon, 19 Sep 2022 00:02:14 -0700
>   Subject: [PATCH] support 32 bit x64 and arm for yocto
> @@ -8,11 +8,11 @@ Upstream-Status: Inappropriate [oe specific]
>   Rebase to 2.10.0
>   Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
>   ---
> - tensorflow/BUILD                              |  3 --
> + tensorflow/BUILD                              |  3 ---
>    tensorflow/workspace2.bzl                     |  2 ++
> - .../0001-XNNPACK-support-32-bit-x86.patch     | 29 ++++++++++++++++++=
+
> - .../0001-cpuinfo-support-32-bit-x86.patch     | 28 ++++++++++++++++++
> - 4 files changed, 59 insertions(+), 3 deletions(-)
> + .../0001-XNNPACK-support-32-bit-x86.patch     | 27 ++++++++++++++++++=
+
> + .../0001-cpuinfo-support-32-bit-x86.patch     | 27 ++++++++++++++++++=
+
> + 4 files changed, 56 insertions(+), 3 deletions(-)
>    create mode 100644 third_party/0001-XNNPACK-support-32-bit-x86.patch
>    create mode 100644 third_party/0001-cpuinfo-support-32-bit-x86.patch
>
> @@ -52,7 +52,7 @@ index a49aeeb7434..c1d90686dcb 100644
>        )
>   diff --git a/third_party/0001-XNNPACK-support-32-bit-x86.patch b/thir=
d_party/0001-XNNPACK-support-32-bit-x86.patch
>   new file mode 100644
> -index 00000000000..2141c37236b
> +index 00000000000..e2c053e6f8c
>   --- /dev/null
>   +++ b/third_party/0001-XNNPACK-support-32-bit-x86.patch
>   @@ -0,0 +1,27 @@
> @@ -85,7 +85,7 @@ index 00000000000..2141c37236b
>   +
>   diff --git a/third_party/0001-cpuinfo-support-32-bit-x86.patch b/thir=
d_party/0001-cpuinfo-support-32-bit-x86.patch
>   new file mode 100644
> -index 00000000000..0c83cf01675
> +index 00000000000..cd6b27eaea3
>   --- /dev/null
>   +++ b/third_party/0001-cpuinfo-support-32-bit-x86.patch
>   @@ -0,0 +1,27 @@
> @@ -116,6 +116,3 @@ index 00000000000..0c83cf01675
>   +--
>   +2.37.1
>   +
> ---
> -2.37.1
> -
> diff --git a/recipes-framework/tensorflow/files/0001-Revert-set-distinc=
t_host_configuration-false-by-defa.patch b/recipes-framework/tensorflow/f=
iles/0013-Revert-set-distinct_host_configuration-false-by-defa.patch
> similarity index 81%
> rename from recipes-framework/tensorflow/files/0001-Revert-set-distinct=
_host_configuration-false-by-defa.patch
> rename to recipes-framework/tensorflow/files/0013-Revert-set-distinct_h=
ost_configuration-false-by-defa.patch
> index adc4661..68a3dd6 100644
> --- a/recipes-framework/tensorflow/files/0001-Revert-set-distinct_host_=
configuration-false-by-defa.patch
> +++ b/recipes-framework/tensorflow/files/0013-Revert-set-distinct_host_=
configuration-false-by-defa.patch
> @@ -1,4 +1,4 @@
> -From 0076b9b52016c7a22c4418d25945ebc893a67b12 Mon Sep 17 00:00:00 2001
> +From 46c5b23f136efbf61a29576bb30bcf79fc703a8c Mon Sep 17 00:00:00 2001
>   From: Hongxu Jia <hongxu.jia@windriver.com>
>   Date: Mon, 16 May 2022 00:53:00 -0700
>   Subject: [PATCH] Revert "set --distinct_host_configuration=3Dfalse by=
 default
> @@ -16,10 +16,10 @@ Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com=
>
>    1 file changed, 2 deletions(-)
>
>   diff --git a/.bazelrc b/.bazelrc
> -index a71ade6950f..9f7627bb7c6 100644
> +index 4d46f9b2a85..cf8d2c2b028 100644
>   --- a/.bazelrc
>   +++ b/.bazelrc
> -@@ -355,8 +355,6 @@ build:windows --features=3Dcompiler_param_file
> +@@ -374,8 +374,6 @@ build:windows --features=3Dcompiler_param_file
>
>    # On windows, we never cross compile
>    build:windows --distinct_host_configuration=3Dfalse
> @@ -28,6 +28,3 @@ index a71ade6950f..9f7627bb7c6 100644
>
>    # Do not risk cache corruption. See:
>    # https://github.com/bazelbuild/bazel/issues/3360
> ---
> -2.36.0
> -
> diff --git a/recipes-framework/tensorflow/files/0001-distutils-is-depre=
cated-in-Python-3.10-cross.patch b/recipes-framework/tensorflow/files/001=
4-distutils-is-deprecated-in-Python-3.10-51776.patch
> similarity index 96%
> rename from recipes-framework/tensorflow/files/0001-distutils-is-deprec=
ated-in-Python-3.10-cross.patch
> rename to recipes-framework/tensorflow/files/0014-distutils-is-deprecat=
ed-in-Python-3.10-51776.patch
> index e79fc24..6c628e1 100644
> --- a/recipes-framework/tensorflow/files/0001-distutils-is-deprecated-i=
n-Python-3.10-cross.patch
> +++ b/recipes-framework/tensorflow/files/0014-distutils-is-deprecated-i=
n-Python-3.10-51776.patch
> @@ -1,4 +1,4 @@
> -From 79bd5c1e597ffd877822297a48d9eaa9ca3a317d Mon Sep 17 00:00:00 2001
> +From 4b869ac19a6192df34e5ed41ab7a3f5ff3db8438 Mon Sep 17 00:00:00 2001
>   From: Hongxu Jia <hongxu.jia@windriver.com>
>   Date: Mon, 16 May 2022 01:18:43 -0700
>   Subject: [PATCH] `distutils` is deprecated in Python 3.10 #51776
> @@ -47,6 +47,3 @@ index 300cbfb6c71..e57af9f9dc9 100644
>
>    def _get_python_import_lib_name(repository_ctx, python_bin):
>        """Get Python import library name (pythonXY.lib) on Windows."""
> ---
> -2.36.0
> -
> diff --git a/recipes-framework/tensorflow/tensorflow-lite_2.10.0.bb b/r=
ecipes-framework/tensorflow/tensorflow-lite_2.10.0.bb
> index 12ea7a6..8ecc048 100644
> --- a/recipes-framework/tensorflow/tensorflow-lite_2.10.0.bb
> +++ b/recipes-framework/tensorflow/tensorflow-lite_2.10.0.bb
> @@ -1,19 +1,19 @@
>   include tensorflow.inc
>
>   SRC_URI +=3D " \
> -           file://0001-add-yocto-toolchain-to-support-cross-compiling.=
patch \
> -           file://0001-fix-build-tensorflow-lite-examples-label_image-=
label.patch \
> -           file://0001-label_image-tweak-default-model-location.patch =
\
> -           file://0001-label_image.lite-tweak-default-model-location.p=
atch \
> -           file://0001-CheckFeatureOrDie-use-warning-to-avoid-die.patc=
h \
> -           file://0001-support-32-bit-x64-and-arm-for-yocto.patch \
> -           file://0001-Revert-set-distinct_host_configuration-false-by=
-defa.patch \
> -           file://0001-distutils-is-deprecated-in-Python-3.10-cross.pa=
tch \
> -           file://BUILD.in \
> -           file://BUILD.yocto_compiler \
> -           file://cc_config.bzl.tpl \
> -           file://yocto_compiler_configure.bzl \
> -          "
> +    file://0007-add-yocto-toolchain-to-support-cross-compiling.patch \
> +    file://0008-fix-build-tensorflow-lite-examples-label_image-label.p=
atch \
> +    file://0009-label_image-tweak-default-model-location.patch \
> +    file://0010-label_image.lite-tweak-default-model-location.patch \
> +    file://0011-CheckFeatureOrDie-use-warning-to-avoid-die.patch \
> +    file://0012-support-32-bit-x64-and-arm-for-yocto.patch \
> +    file://0013-Revert-set-distinct_host_configuration-false-by-defa.p=
atch \
> +    file://0014-distutils-is-deprecated-in-Python-3.10-51776.patch \
> +    file://BUILD.in \
> +    file://BUILD.yocto_compiler \
> +    file://cc_config.bzl.tpl \
> +    file://yocto_compiler_configure.bzl \
> +"
>
>   SRC_URI +=3D "https://storage.googleapis.com/download.tensorflow.org/=
models/inception_v3_2016_08_28_frozen.pb.tar.gz;name=3Dmodel-inv3"
>   SRC_URI[model-inv3.md5sum] =3D "a904ddf15593d03c7dd786d552e22d73"
> diff --git a/recipes-framework/tensorflow/tensorflow.inc b/recipes-fram=
ework/tensorflow/tensorflow.inc
> index e63cb8e..386fc3e 100644
> --- a/recipes-framework/tensorflow/tensorflow.inc
> +++ b/recipes-framework/tensorflow/tensorflow.inc
> @@ -5,14 +5,13 @@ LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3D4158a261ca=
7f2525513e31ba9c50ae98"
>   DEPENDS =3D "bazel-native protobuf-native util-linux-native protobuf"
>   SRCREV =3D "359c3cdfc5fabac82b3c70b3b6de2b0a8c16874f"
>   SRC_URI =3D "git://github.com/tensorflow/tensorflow.git;branch=3Dr2.1=
0;protocol=3Dhttps \
> -           file://0001-support-musl.patch \
> -           file://0001-use-local-bazel-to-workaround-bazel-paralle-iss=
ue.patch \
> -           file://0001-third_party-eigen_archive-workaround-ice-failur=
e-whi.patch \
> -           file://0001-drop-bazel_toolchains_repositories-to-support-o=
fflin.patch \
> -           file://0001-drop-v2-config.patch \
> -           file://0002-Replace-distutils.sysconfig.get_python_lib-with=
-sysc.patch \
> -          "
> -
> +    file://0001-support-musl.patch \
> +    file://0002-use-local-bazel-to-workaround-bazel-paralle-issue.patc=
h \
> +    file://0003-third_party-eigen_archive-workaround-ice-failure-whi.p=
atch \
> +    file://0004-drop-v2-config.patch \
> +    file://0005-drop-bazel_toolchains_repositories-to-support-offlin.p=
atch \
> +    file://0006-Replace-distutils.sysconfig.get_python_lib-with-sysc.p=
atch \
> +"
>   S =3D "${WORKDIR}/git"
>
>   DEPENDS +=3D " \
> diff --git a/recipes-framework/tensorflow/tensorflow_2.10.0.bb b/recipe=
s-framework/tensorflow/tensorflow_2.10.0.bb
> index a0e75ee..3957737 100644
> --- a/recipes-framework/tensorflow/tensorflow_2.10.0.bb
> +++ b/recipes-framework/tensorflow/tensorflow_2.10.0.bb
> @@ -1,19 +1,19 @@
>   include tensorflow.inc
>
>   SRC_URI +=3D " \
> -           file://0001-add-yocto-toolchain-to-support-cross-compiling.=
patch \
> -           file://0001-fix-build-tensorflow-lite-examples-label_image-=
label.patch \
> -           file://0001-label_image-tweak-default-model-location.patch =
\
> -           file://0001-label_image.lite-tweak-default-model-location.p=
atch \
> -           file://0001-CheckFeatureOrDie-use-warning-to-avoid-die.patc=
h \
> -           file://0001-support-32-bit-x64-and-arm-for-yocto.patch \
> -           file://0001-Revert-set-distinct_host_configuration-false-by=
-defa.patch \
> -           file://0001-distutils-is-deprecated-in-Python-3.10-cross.pa=
tch \
> -           file://BUILD.in \
> -           file://BUILD.yocto_compiler \
> -           file://cc_config.bzl.tpl \
> -           file://yocto_compiler_configure.bzl \
> -          "
> +    file://0007-add-yocto-toolchain-to-support-cross-compiling.patch \
> +    file://0008-fix-build-tensorflow-lite-examples-label_image-label.p=
atch \
> +    file://0009-label_image-tweak-default-model-location.patch \
> +    file://0010-label_image.lite-tweak-default-model-location.patch \
> +    file://0011-CheckFeatureOrDie-use-warning-to-avoid-die.patch \
> +    file://0012-support-32-bit-x64-and-arm-for-yocto.patch \
> +    file://0013-Revert-set-distinct_host_configuration-false-by-defa.p=
atch \
> +    file://0014-distutils-is-deprecated-in-Python-3.10-51776.patch \
> +    file://BUILD.in \
> +    file://BUILD.yocto_compiler \
> +    file://cc_config.bzl.tpl \
> +    file://yocto_compiler_configure.bzl \
> +"
>
>   SRC_URI +=3D "https://storage.googleapis.com/download.tensorflow.org/=
models/inception_v3_2016_08_28_frozen.pb.tar.gz;name=3Dmodel-inv3"
>   SRC_URI[model-inv3.md5sum] =3D "a904ddf15593d03c7dd786d552e22d73"
> --
> 2.48.1
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1065): https://lists.yoctoproject.org/g/yocto-patch=
es/message/1065
> Mute This Topic: https://lists.yoctoproject.org/mt/111125120/3617049
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13176=
071/3617049/43253763/xyzzy [hongxu.jia@eng.windriver.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>


