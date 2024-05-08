Return-Path: <changqing.li@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7A8C10F1A
	for <webhook@archiver.kernel.org>; Wed,  8 May 2024 01:39:10 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.2295.1715132339353654233
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 07 May 2024 18:38:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=K2bcevAk;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=585817ed1e=changqing.li@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4480gJlx010123
	for <yocto-patches@lists.yoctoproject.org>; Wed, 8 May 2024 01:38:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-type:message-id:date:subject:to:cc:references:from
	:in-reply-to:mime-version; s=PPS06212021; bh=W+OrOpEuF/J1beGfimo
	n8jcEAVXSeG5QBiL1OebiYAQ=; b=K2bcevAkUlPbAp+Uf0w8bt0b/ynNAZkUH4Z
	LOpg5UPlYyDZi00NrluBzH+vXN2GMkFERhVnNqRMZxp2YAkNIKnWVadttF3OS82u
	aIhqgTSOKdq51aIe3Bd8sGw7xFVh5Dfdiu3ksSNFbg6a9Sg6xdhJBVSnB6iNkI9s
	s3I5MRDYAuri6bZRgj6TLrExR0WWE7jbTCNDvFLZG5cYdxekb5tcegZoiw9puicu
	iw7hlQIUifYqvnXlseNXAqMTBaZ44XZ0Gau+FoFJNPeeBUD789sVADtRGt8zLt+U
	qtPzJ2NI5FmoMlnEg7vXyA7LsH0MM4JApNm2Zkm+XMDyRoGRgKg==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3xysjxrak9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 01:38:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ya2NCPRT0QZt2H3rKf57+pojO/+Nf5XBOt3M1TnheKuC0MTIbsEdpO9em3wVxItR9aN8clyKDKg9MjsHfZvSKM8fgutyxqFWWa/PXrzSPVcHiBmdMyrvALXACUTf5WFrFPmm6Nh8McuXcuA8nFJDYOT1CysRIE/0lVL7Weh4T828WxnxgTwBAK4KS3jhxJDIQzqsHXOv7l/O8qqlS2EYawrdNwP/l7YdH2N/YkYFfcG2h5O7AH1nso7Mt5+5/ctnVcbjqiRzIqkjKAPzg0oTLi2X06ii/ezb8+IDqKmUBAWSIC4+Nm+T0Nq7Oq8t1gMkfv5HZ4Y9IW54qb/8zJgO/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+OrOpEuF/J1beGfimon8jcEAVXSeG5QBiL1OebiYAQ=;
 b=K0INb43t7GOmCjn5S53DiyNLhre2PpEslsPeRjV+H1vbDPLW+HmMH8gq+6cPWuHSz5EfuinSy7jHIhLQAwKSvO/VJrhUgnWA6i4a6WdhKrrxYNWVotT5rSAZIdlKR+jbEO3eMFSacYunIl3cwvtG+m9nXuvtWwZrXFVCK/m4rTaO5ZfGmIItxXZrj4mgN6UaJLXS77eOhFW5ASdqrACCJbDomBraTYUUNQo759B2crhbA5Dv9LrQxvTwa0lir+aHpLeyfd+7w3QaOq6YaLvvVVZTMVpDblkdwoECPMT+WHb+qDxX8+Vo3VZzrqesn+8/fXi1BoWXfVWSP9STCEq6Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7312.namprd11.prod.outlook.com (2603:10b6:8:11f::18)
 by DS0PR11MB6397.namprd11.prod.outlook.com (2603:10b6:8:ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Wed, 8 May
 2024 01:38:54 +0000
Received: from DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::11a8:330f:c42c:b2d5]) by DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::11a8:330f:c42c:b2d5%4]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 01:38:54 +0000
Content-Type: multipart/alternative;
 boundary="------------D5sk0dLlhgfN0wRvp0h0ydgV"
Message-ID: <d1d75d86-b72d-464e-8405-99d19619c685@windriver.com>
Date: Wed, 8 May 2024 09:38:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [ptest-runner 1/2] utils.c: run-ptests improve
 pseudo-terminal handling
To: yocto-patches@lists.yoctoproject.org
Cc: randy.macleod@windriver.com
References: <17CCF08ED1ED8647.29739@lists.yoctoproject.org>
 <CAOU5ZMuzwmC_BAZGGgG+5+Ejy6O5XvqUuz+07zZMNhwQ0X541g@mail.gmail.com>
Content-Language: en-US
From: Changqing Li <changqing.li@windriver.com>
In-Reply-To: <CAOU5ZMuzwmC_BAZGGgG+5+Ejy6O5XvqUuz+07zZMNhwQ0X541g@mail.gmail.com>
X-ClientProxiedBy: TYCPR01CA0137.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::13) To DS0PR11MB7312.namprd11.prod.outlook.com
 (2603:10b6:8:11f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7312:EE_|DS0PR11MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: 00cb9a7a-e793-4d5d-10d9-08dc6eff9ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UUROd0k0amkyUDI1OW1BUTdvaWhkSndYci8vZ1JMaWFRTndvMzExb3Zqb2l3?=
 =?utf-8?B?V2FGUkgyVGIvZWdpTVQvSzA1WFhqSmIvRndKU080L1U5QmljbFV2RFZMeWpJ?=
 =?utf-8?B?VHFmR0NjRUlnSjZhbzJndXNwdVZUV3lPVzUvQXhrZ1V5Tm1XYWRVTXdIZFdK?=
 =?utf-8?B?MjJ4MnN3RENSWE0zZmFnS09vbUZlQkxZNFhmS0V6RVBiYTJDcGI3bUJnSTZh?=
 =?utf-8?B?dGNZbVp5REx1cDcvVnRrU1kvRjMzZ2VCOUxZN2VPOFhJd0hTZ0s1am43U1Zm?=
 =?utf-8?B?ay9kTm9VZmoyS2xzS0ZreXdqcy96clBGZ3B4Y1VLaVUzRXpGWFZtUnp0c1Zq?=
 =?utf-8?B?akJZdFhwc3VJRE9BWklGbFRRb0V6d29DMVN2dU1SMmxVRDRNb25xQUg3NnpW?=
 =?utf-8?B?NVlmMnNmNmlmcU1tdlhWMmZ5MEN3Wk9zWVM2eTJGRXl5QjF5Q1ZvN3JlVWky?=
 =?utf-8?B?d256bmJsYVIxdTVKZkdEQjFwaTZONUpSOTdGaU1RU3RMU0x4cGczNHdpQTB0?=
 =?utf-8?B?YWJhOStuQVk2NHFiYkRDU2hEWnVOTFNBQ1pydG5pSFZJTlN1R0NwZkR1bkVC?=
 =?utf-8?B?MTd1TGFQTXFyZDc2emtKcEFpbUp4cTIvZkNaeFFKcE5xUEJuQnY4bEUwb1Y0?=
 =?utf-8?B?aFhkbU80b0FGb3RSeStudlk0Rm9ETjdNRExDWXhDZGtVS0NERVc4T2c0R0RG?=
 =?utf-8?B?SnA3WEJHbzNjOXpOQVVlMFZGckRKejFNdVJlUEVHS21kTWhrL1BsTFFFRHZ0?=
 =?utf-8?B?dmZSTXpGK2JmaDJORG5ReG1hRVBDUTFQNDFBQWk5TFYxdmhCT1RlaVh3NktU?=
 =?utf-8?B?TjZBaUVKZENsRDQxaWY5dmtQTjVxM0d2SC9Oa0pILzlxelhGNDR3N3k5L2lV?=
 =?utf-8?B?OHd0Q2k5OXpZR0s0d1BaaGV2TmpTNW9rbVJYcHpYUVdQRjAzd3VzZUNjVXQz?=
 =?utf-8?B?NFJNN3lES1Nlclk4bmcvQ3MzNTE3Uk5tMnVkWWJ1dlBMd3hoTXlpbnF4eVZB?=
 =?utf-8?B?NDBqdENycVFGanBrNTJ3RXI3dWlnVGVjdWV4K3BCNlB6TFR4aG9LeDI5ZVVi?=
 =?utf-8?B?cnZmZ3JRMWxzM0lUeUJmYmhpNVAwSlpneFhJcFlONWZyT1V0UUI3bEJZRHJp?=
 =?utf-8?B?L21sVG1TZld3YXE2U0QrL1lTR0JCakNnejBxRG1hSkdueVE4b1drOHYvQ0Vj?=
 =?utf-8?B?MXZUTzBFckV1OE5DQzRzSXVLOW1HeVlFa3RlQzFtQjEwL1huSWl5eGJsNUVU?=
 =?utf-8?B?cDdNcE1ob3lVWXA2TWphOURCa2k5djFBZUZLdThucU5OZTkwR3B1NTlSdmhL?=
 =?utf-8?B?dURpL3RqZHVEUHhOZEdmeTNwOHZlTmhBNCtZV3d2eTNVNGR1NlpuMmY0cWRO?=
 =?utf-8?B?TVd5V3Q0RW5uQ0l1R00wNk8vbys3YXJ4NGcwMFJmY08wWWVDS2JHeUlydE1V?=
 =?utf-8?B?UEdSYWtpVHlMYmt2YnBWZkxmZmVxM2NackdwZXczUXdqcytQc0VDb2Y4b3JQ?=
 =?utf-8?B?VWhHUjVpSjFvdjkwRTdsOFhVN3VKVmJsQ3lCb1E3a1NoOE0xNWp1aGE0aXpK?=
 =?utf-8?B?N2tkWGZqSlJiSm1wdnhxWTNJTkZxMWJmL0c0eGkveFl5RkkvaFJmQWYrdm9S?=
 =?utf-8?B?TlVTK05sWkdtT0FaUW9veGhmL3ZsYVE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7312.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SmM4N3ZtbTZtTTMxOGo4M1hZNjhmOFE3dWpvVDB2cytsM2FYVEovRGJ6NWpB?=
 =?utf-8?B?QW9OOEc2Q2ZVZFNjNURQS1JEdG1HYWRwVGhnRUIwSytGOTNxOW42Sy84N1Fm?=
 =?utf-8?B?MjJ5M3ZsOG9EWnJDM2N6dEdoelFrZ2dUdFlVYTBxL2w5RDl6TXZ2WlFKRERl?=
 =?utf-8?B?TG1BMXNDNG41aEs1U3ZHb0tNU1pnekdHV2VTR0hvS1BRb000akNZMTVKZlh6?=
 =?utf-8?B?WWhsb0M2SU43MkZPL3ZzVThlZkdtcHliaWUxWS81Vms5NVNuWHZRaEpYazFy?=
 =?utf-8?B?a0JieTdIS05kRkJ4citrZkZRMnMvZGZXd1NpSXNIOEFMMERBeDFRVU1IZzBJ?=
 =?utf-8?B?WTFPR1NEZ1N6cjMxTWc4bGlhczFzR3RSKzRaRytPSXh5VkM5SWcva1VnREJY?=
 =?utf-8?B?L1JqL0h0RlZINm1KTXFmSE14cE9NTEdnOUxhMSsxYUtTQmJTeGRIT1VKR3N2?=
 =?utf-8?B?VzRka3BoYjRrR0VJVVRPNXYrTTFJenZTRjlXTmJncGJsQXdZVGlONWZiSUFk?=
 =?utf-8?B?c3Qray81UFkrazlWSDU2c2lWdTlQN1MrTVJOYUtJUldnNExCTTNmelhKNlFO?=
 =?utf-8?B?a3dYVitQM1ZrYjI5a3o0MUtWenBOdkZqS0NrTFRBYjh2VTdtOUlYZUVMM0RO?=
 =?utf-8?B?aHRYYmxKL2t1TUppNlc4VlFKbmNWWEJaeWVmY3lwVjJjajV3bVZreXZ6bXlk?=
 =?utf-8?B?Tk1UMTVZVXc4bXJxelVmVlo1YU9ydTVDRU4wb0FnU01DUmFCZnlMdGZvUW94?=
 =?utf-8?B?RkR4UTlhTXh5VHpTYzlSdDdVWEp5RkhFZ2NGY2hUMzlySzRLbEFoWlpKSDBR?=
 =?utf-8?B?QU1IMFNsbnNseE11cGhmQXFjdm5lRFdiQkltbmV4ZHltWnFUbDJIV3kxVElD?=
 =?utf-8?B?TVNwTmxCVThPVTJKM2J6QVlYR2xXbWlJWmNPRURGN0VBQUJTNkd5d2UzMEJt?=
 =?utf-8?B?enN4dytPZjZVQzJKT0hhaDFNRFJmZzc1N20valY2aUd3eklpSkMzQi9zM1l2?=
 =?utf-8?B?akNPSzRnMFZWdG1NVnNIYU9ZZTJoYXlJdVcyN1R0RFlIWUlJTFpBQ2dlNmJR?=
 =?utf-8?B?K0txSXBHK2g4TnNVZm8xMjRnYjlXSEZUblhUeStpekczMVdrellWVjF3L0s3?=
 =?utf-8?B?OWxqU3dKbDFvOTAvOEhpUnc5aC9TTllpU0F3eHZIUnRIT05PQVZqT2N5Ri84?=
 =?utf-8?B?bVlJZ3F4SGtTRDdOYVdVVHNrK1VHQXRodjZoWUdYVmwzUUZFbTVqcktvcDAw?=
 =?utf-8?B?TnNwbnFEcjVlTlZWeUF3Q3dWb1hLaEtDNElVUFBLVmdyRkN1WlZvKzdvbENq?=
 =?utf-8?B?d3VGY0cwOWREM21lZENmM2JIclE0ZGhvc0RFWXRxNng0VHdJS2YxTktpR3ZJ?=
 =?utf-8?B?K3ZiWXZLd0MwUUFrZVhuODZxZ2NlOVE0dnRSblU5RDRsQzF6Ny8vZ0p1NXZD?=
 =?utf-8?B?SlA2U3E0aFUrWHVJUm1jNlZFdUdvYmFQY040WUlVOWlCQ2pHaDNHSEZwcWMz?=
 =?utf-8?B?Z3hOekRoZkdUQzBjWGdiQ3hjS0dZU3hTUlpMOU9SMVRnUUMzbUpNMFMyYjZG?=
 =?utf-8?B?Z1BJOFVBYlo1blJaOGJvaXBsaE5Lc1pReHAweWtHTHBtdlFmcHdNazAxc2hr?=
 =?utf-8?B?RWxaZ0hkUDZYZ0M4NHk3UVZGQ0dNVDJZRUExUlhVYlNKL0xhdDM0SVRMSnNY?=
 =?utf-8?B?Vjk1bWthbWNCNEVRZHBtK3dpT2s3ZzVWTWxTT2dJQTd6c2lmazFaTnFkakM5?=
 =?utf-8?B?NUVlSzkweTFhdUZlaDZ3ODVjWVV4U0w4aEhXZlFWa2s3ajhFcGlrOFhodkw5?=
 =?utf-8?B?NU9TUUNBbDh0RFhBOEVTOWx3bmkrUDJnc2xlT1dTUWRtZXhQb0lXUW1Yd00r?=
 =?utf-8?B?VEhzc2FzMDg2RUErQkZzejlEbUM0Y3hHbFUwQjRlYWdvT0gxbytNd21GQjRN?=
 =?utf-8?B?L1ppZXBhUXlVUHRtLzJVQkJVL0I0dVlkT05Ud2daTHlWMFhZaUhzM2dlbkpL?=
 =?utf-8?B?T3hhQ0FGb3ByaDFaWUEvNmVXNzBYaGdHTjRTTUxMYlZIWUdhRit5L2FsNm91?=
 =?utf-8?B?THVqT3I2V1J3ekhROXZnZlpEM3JRdHpGNDJKdHRMNTcyc1VyMEtlWncySU82?=
 =?utf-8?B?Z0t6endMcjZwZ0JCNGdzK2ZEQ3ZTWWNZL0lwcFk1T25iNldWSVlMNWtNWXVt?=
 =?utf-8?B?MHc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00cb9a7a-e793-4d5d-10d9-08dc6eff9ec1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 01:38:54.1392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ic+YKO9O1zSnmqtulA42MTQUTZxiHZbi1pqgVqwlD6bYWNjG0Y/2Uk1/Lr44LNAC6hLg4JZjaDkvNOSCv8eRpboHcOpAV5+KNzd4DTd798Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6397
X-Proofpoint-GUID: oR89kpc71ZlRhmo9o_kiRzj1AbXF7hrr
X-Proofpoint-ORIG-GUID: oR89kpc71ZlRhmo9o_kiRzj1AbXF7hrr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_16,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405080009
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 01:39:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/88

--------------D5sk0dLlhgfN0wRvp0h0ydgV
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-MIME-Autoconverted: from 8bit to base64 by mx0a-0064b401.pphosted.com id 4480gJlx010123

DQpPbiA1LzYvMjQgMjM6NDQsIEFuaWJhbCBMaW1vbiB3cm90ZToNCj4gKioNCj4gKkNBVVRJ
T046IFRoaXMgZW1haWwgY29tZXMgZnJvbSBhIG5vbiBXaW5kIFJpdmVyIGVtYWlsIGFjY291
bnQhKg0KPiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIA0KPiBhbmQga25vdyB0aGUgY29udGVudCBpcyBz
YWZlLg0KPiBIaSBDaGFuZ3FpbmcsDQo+DQo+IEkgc3BlbnQgc29tZSB0aW1lIHJldmlld2lu
ZyB0aGUgcGF0Y2ggYW5kIHRoaXMgaXMgYSByZWR1Y2VkIHZlcnNpb24gb2YgaXQsDQo+DQo+
IElmIHRoZSBwYXJlbnQgc2V0IHVwIGEgcHR5IGFuZCB0aGVuIHNldCB1cCB0aGUgY2hpbGQg
YXMgc3RkaW4sIEl0IGFsbCANCj4gbmVlZHMgdG8gY292ZXIgeW91ciBjYXNlIGFuZCBwcmV2
aW91cyBjYXNlcyByYWlzZWQgYnkgUmFuZHkuDQo+DQo+IEkgdGVzdGVkIHRoZSBsaWJ0ZXZl
bnQgcHRlc3QgYW5kIHBhc3NlZCB0aGUgMyB0ZXN0cyB3aXRoIHRoaXMgcGF0Y2guDQo+DQo+
IFJlZ2FyZHMhLA0KPiBBbmliYWwNCg0KSGksIEFuaWJhbA0KDQpJIGFtIGZpbmUgd2l0aCB0
aGlzIGNoYW5nZSwgYWxzbyB0cnkgdG8gcnVuIHB0ZXN0IGZvciBsaWJ0ZXZlbnQgYW5kIA0K
YmFzaCwgd29ya3MgYXMgZXhwZWN0Lg0KDQpSZWdhcmRzDQoNCkNoYW5ncWluZw0KDQo+DQo+
IE9uIE1vbiwgTWF5IDYsIDIwMjQgYXQgOTo0MOKAr0FNIEFuaWJhbCBMaW1vbiB2aWEgbGlz
dHMueW9jdG9wcm9qZWN0Lm9yZyANCj4gPGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19o
dHRwOi8vbGlzdHMueW9jdG9wcm9qZWN0Lm9yZ19fOyEhQWp2ZVlkdzhFdlEhZVZiWlhHUkNw
NGJrXzE1bklnekR2MFByWC1USkp6NGlxeXpvYUJCa2VNYmlFZE1KcUdSWkNYSGVyeTM2a01Z
VmJhSEpFd1ltUkZfSXRoLWNNMzVVNmtNZ19leWkkPiANCj4gPGFuaWJhbD1saW1vbnNvZnR3
YXJlLmNvbUBsaXN0cy55b2N0b3Byb2plY3Qub3JnPiB3cm90ZToNCj4NCj4gICAgIFNldHVw
IG1hc3RlciBhbmQgc2xhdmUgcHR5IGJlZm9yZSBydW4gcHRlc3QsIG9uIGNoaWxkIGF0dGFj
aCB0byB0aGUNCj4gICAgIHNsYXZlIHB0eSBhbmQgc2V0IGl0IGFzIGNvbnRyb2xsaW5nIHR0
eSBhbmQgc3RkaW4uDQo+DQo+ICAgICBTZWUgcmV2IDU5MzgxYTY0M2UxZmNjZTliNjkyMGNi
NTlhZjk0MDJkZDVlYjBkZmIgLg0KPg0KPiAgICAgQ28tYXV0aG9yZWQtYnk6IENoYW5ncWlu
ZyBMaSA8Y2hhbmdxaW5nLmxpQHdpbmRyaXZlci5jb20+DQo+ICAgICBTaWduZWQtb2ZmLWJ5
OiBBbmliYWwgTGltb24gPGFuaWJhbEBsaW1vbnNvZnR3YXJlLmNvbT4NCj4gICAgIC0tLQ0K
PiAgICAgwqB1dGlscy5jIHwgOTANCj4gICAgICsrKysrKysrKysrKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgICAgwqAxIGZpbGUgY2hhbmdl
ZCwgMTkgaW5zZXJ0aW9ucygrKSwgNzEgZGVsZXRpb25zKC0pDQo+DQo+ICAgICBkaWZmIC0t
Z2l0IGEvdXRpbHMuYyBiL3V0aWxzLmMNCj4gICAgIGluZGV4IDQ2OTE4ZjQuLjNhMzUzMTMg
MTAwNjQ0DQo+ICAgICAtLS0gYS91dGlscy5jDQo+ICAgICArKysgYi91dGlscy5jDQo+ICAg
ICBAQCAtMzQxLDUzICszNDEsNiBAQCBydW5fY2hpbGQoY2hhciAqcnVuX3B0ZXN0LCBpbnQg
ZmRfc3Rkb3V0LCBpbnQNCj4gICAgIGZkX3N0ZGVycikNCj4gICAgIMKgIMKgIMKgIMKgIC8q
IGV4aXQoMSk7IG5vdCBuZWVkZWQ/ICovDQo+ICAgICDCoH0NCj4NCj4gICAgIC0vKiBSZXR1
cm5zIGFuIGludGVnZXIgZmlsZSBkZXNjcmlwdG9yLg0KPiAgICAgLSAqIElmIGl0IHJldHVy
bnMgPCAwLCBhbiBlcnJvciBoYXMgb2NjdXJyZWQuDQo+ICAgICAtICogT3RoZXJ3aXNlLCBp
dCBoYXMgcmV0dXJuZWQgdGhlIHNsYXZlIHB0eSBmaWxlIGRlc2NyaXB0b3IuDQo+ICAgICAt
ICogZnAgc2hvdWxkIGJlIHdyaXRhYmxlLCBsaWtlbHkgc3Rkb3V0L2Vyci4NCj4gICAgIC0g
Ki8NCj4gICAgIC1zdGF0aWMgaW50DQo+ICAgICAtc2V0dXBfc2xhdmVfcHR5KEZJTEUgKmZw
KSB7DQo+ICAgICAtwqAgwqAgwqAgwqBpbnQgcHR5X21hc3RlciA9IC0xOw0KPiAgICAgLcKg
IMKgIMKgIMKgaW50IHB0eV9zbGF2ZSA9IC0xOw0KPiAgICAgLcKgIMKgIMKgIMKgY2hhciBw
dHlfbmFtZVsyNTZdOw0KPiAgICAgLcKgIMKgIMKgIMKgc3RydWN0IGdyb3VwICpncHRyOw0K
PiAgICAgLcKgIMKgIMKgIMKgZ2lkX3QgZ2lkOw0KPiAgICAgLcKgIMKgIMKgIMKgaW50IHNs
YXZlID0gLTE7DQo+ICAgICAtDQo+ICAgICAtwqAgwqAgwqAgwqBpZiAob3BlbnB0eSgmcHR5
X21hc3RlciwgJnB0eV9zbGF2ZSwgcHR5X25hbWUsIE5VTEwsIE5VTEwpDQo+ICAgICA8IDAp
IHsNCj4gICAgIC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZwcmludGYoZnAsICJFUlJPUjog
b3BlbnB0eSgpIGZhaWxlZCB3aXRoOiAlcy5cbiIsDQo+ICAgICBzdHJlcnJvcihlcnJubykp
Ow0KPiAgICAgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC0xOw0KPiAgICAgLcKg
IMKgIMKgIMKgfQ0KPiAgICAgLQ0KPiAgICAgLcKgIMKgIMKgIMKgaWYgKChncHRyID0gZ2V0
Z3JuYW0ocHR5X25hbWUpKSAhPSAwKSB7DQo+ICAgICAtwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBnaWQgPSBncHRyLT5ncl9naWQ7DQo+ICAgICAtwqAgwqAgwqAgwqB9IGVsc2Ugew0KPiAg
ICAgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogSWYgdGhlIHR0eSBncm91cCBkb2VzIG5v
dCBleGlzdCwgZG9uJ3QgY2hhbmdlIHRoZQ0KPiAgICAgLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgICogZ3JvdXAgb24gdGhlIHNsYXZlIHB0eSwgb25seSB0aGUgb3duZXINCj4gICAgIC3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAqLw0KPiAgICAgLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgZ2lkID0gKGdpZF90KS0xOw0KPiAgICAgLcKgIMKgIMKgIMKgfQ0KPiAgICAgLQ0KPiAg
ICAgLcKgIMKgIMKgIMKgLyogY2hvd24vY2htb2QgdGhlIGNvcnJlc3BvbmRpbmcgcHR5LCBp
ZiBwb3NzaWJsZS4NCj4gICAgIC3CoCDCoCDCoCDCoCAqIFRoaXMgd2lsbCBvbmx5IHdvcmsg
aWYgdGhlIHByb2Nlc3MgaGFzIHJvb3QgcGVybWlzc2lvbnMuDQo+ICAgICAtwqAgwqAgwqAg
wqAgKi8NCj4gICAgIC3CoCDCoCDCoCDCoGlmIChjaG93bihwdHlfbmFtZSwgZ2V0dWlkKCks
IGdpZCkgIT0gMCkgew0KPiAgICAgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnByaW50Zihm
cCwgIkVSUk9SOyBjaG93bigpIGZhaWxlZCB3aXRoOiAlcy5cbiIsDQo+ICAgICBzdHJlcnJv
cihlcnJubykpOw0KPiAgICAgLcKgIMKgIMKgIMKgfQ0KPiAgICAgLQ0KPiAgICAgLcKgIMKg
IMKgIMKgLyogTWFrZXMgdGhlIHNsYXZlIHJlYWQvd3JpdGVhYmxlIGZvciB0aGUgdXNlci4g
Ki8NCj4gICAgIC3CoCDCoCDCoCDCoGlmIChjaG1vZChwdHlfbmFtZSwgU19JUlVTUnxTX0lX
VVNSKSAhPSAwKSB7DQo+ICAgICAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmcHJpbnRmKGZw
LCAiRVJST1I6IGNobW9kKCkgZmFpbGVkIHdpdGg6ICVzLlxuIiwNCj4gICAgIHN0cmVycm9y
KGVycm5vKSk7DQo+ICAgICAtwqAgwqAgwqAgwqB9DQo+ICAgICAtDQo+ICAgICAtwqAgwqAg
wqAgwqBpZiAoKHNsYXZlID0gb3BlbihwdHlfbmFtZSwgT19SRFdSKSkgPT0gLTEpIHsNCj4g
ICAgIC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZwcmludGYoZnAsICJFUlJPUjogb3Blbigp
IGZhaWxlZCB3aXRoOiAlcy5cbiIsDQo+ICAgICBzdHJlcnJvcihlcnJubykpOw0KPiAgICAg
LcKgIMKgIMKgIMKgfQ0KPiAgICAgLcKgIMKgIMKgIMKgcmV0dXJuIChzbGF2ZSk7DQo+ICAg
ICAtfQ0KPiAgICAgLQ0KPiAgICAgLQ0KPiAgICAgwqBpbnQNCj4gICAgIMKgcnVuX3B0ZXN0
cyhzdHJ1Y3QgcHRlc3RfbGlzdCAqaGVhZCwgY29uc3Qgc3RydWN0IHB0ZXN0X29wdGlvbnMg
b3B0cywNCj4gICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNvbnN0IGNoYXIgKnByb2du
YW1lLCBGSUxFICpmcCwgRklMRSAqZnBfc3RkZXJyKQ0KPiAgICAgQEAgLTQwNiwxNiArMzU5
LDEyIEBAIHJ1bl9wdGVzdHMoc3RydWN0IHB0ZXN0X2xpc3QgKmhlYWQsIGNvbnN0DQo+ICAg
ICBzdHJ1Y3QgcHRlc3Rfb3B0aW9ucyBvcHRzLA0KPg0KPiAgICAgwqAgwqAgwqAgwqAgZG8N
Cj4gICAgIMKgIMKgIMKgIMKgIHsNCj4gICAgIC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlm
IChpc2F0dHkoMCkgJiYgaW9jdGwoMCwgVElPQ05PVFRZKSA9PSAtMSkgew0KPiAgICAgLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnByaW50ZihmcCwgIkVSUk9SOiBV
bmFibGUgdG8gZGV0YWNoIGZyb20NCj4gICAgIGNvbnRyb2xsaW5nIHR0eSwgJXNcbiIsIHN0
cmVycm9yKGVycm5vKSk7DQo+ICAgICAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9DQo+ICAg
ICAtDQo+DQo+ICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmcHJpbnRmKGZwLCAiU1RB
UlQ6ICVzXG4iLCBwcm9nbmFtZSk7DQo+ICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBQ
VEVTVF9MSVNUX0lURVJBVEVfU1RBUlQoaGVhZCwgcCkNCj4gICAgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGludCBwaXBlZmRfc3Rkb3V0WzJdID0gey0xLCAtMX07
DQo+ICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpbnQgcGlwZWZk
X3N0ZGVyclsyXSA9IHstMSwgLTF9Ow0KPiAgICAgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgaW50IHBnaWQgPSAtMTsNCj4gICAgICvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGludCBwdHlbMl0gPSB7LTEsIC0xfTsNCj4NCj4gICAgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChwaXBlMihwaXBlZmRfc3Rkb3V0
LCAwKSA9PSAtMSkgew0KPiAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgcmMgPSAtMTsNCj4gICAgIEBAIC00MjgsNiArMzc3LDE2IEBAIHJ1
bl9wdGVzdHMoc3RydWN0IHB0ZXN0X2xpc3QgKmhlYWQsIGNvbnN0DQo+ICAgICBzdHJ1Y3Qg
cHRlc3Rfb3B0aW9ucyBvcHRzLA0KPiAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgYnJlYWs7DQo+ICAgICDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCB9DQo+DQo+ICAgICArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBpZiAob3BlbnB0eSgmcHR5WzBdLCAmcHR5WzFdLCBOVUxMLCBOVUxMLA0K
PiAgICAgTlVMTCkgPCAwKSB7DQo+ICAgICArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBmcHJpbnRmKGZwLCAiRVJST1I6IG9wZW5wdHkoKQ0KPiAg
ICAgZmFpbGVkIHdpdGg6ICVzLlxuIiwgc3RyZXJyb3IoZXJybm8pKTsNCj4gICAgICsgwqBj
bG9zZShwaXBlZmRfc3RkZXJyW1BJUEVfUkVBRF0pOw0KPiAgICAgKyDCoGNsb3NlKHBpcGVm
ZF9zdGRlcnJbUElQRV9XUklURV0pOw0KPiAgICAgKyDCoGNsb3NlKHBpcGVmZF9zdGRvdXRb
UElQRV9SRUFEXSk7DQo+ICAgICArIMKgY2xvc2UocGlwZWZkX3N0ZG91dFtQSVBFX1dSSVRF
XSk7DQo+ICAgICArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqByYyA9IC0xOw0KPiAgICAgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgYnJlYWs7DQo+ICAgICArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqB9DQo+ICAgICArDQo+ICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBjaGFyICpwdGVzdF9kaXIgPSBzdHJkdXAocC0+cnVuX3B0ZXN0KTsNCj4g
ICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChwdGVzdF9kaXIg
PT0gTlVMTCkgew0KPiAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgcmMgPSAtMTsNCj4gICAgIEBAIC00MzUsMzggKzM5NCwzMSBAQCBydW5f
cHRlc3RzKHN0cnVjdCBwdGVzdF9saXN0ICpoZWFkLCBjb25zdA0KPiAgICAgc3RydWN0IHB0
ZXN0X29wdGlvbnMgb3B0cywNCj4gICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIH0NCj4gICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGRp
cm5hbWUocHRlc3RfZGlyKTsNCj4NCj4gICAgIC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGlmICgocGdpZCA9IGdldHBnaWQoMCkpID09IC0xKSB7DQo+ICAgICAtwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmcHJpbnRmKGZw
LCAiRVJST1I6IGdldHBnaWQoKQ0KPiAgICAgZmFpbGVkLCAlc1xuIiwgc3RyZXJyb3IoZXJy
bm8pKTsNCj4gICAgIC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH0NCj4g
ICAgIC0NCj4gICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHBpZF90
IGNoaWxkID0gZm9yaygpOw0KPiAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgaWYgKGNoaWxkID09IC0xKSB7DQo+ICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmcHJpbnRmKGZwLCAiRVJST1I6IEZvcmsgJXNc
biIsDQo+ICAgICBzdHJlcnJvcihlcnJubykpOw0KPiAgICAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmMgPSAtMTsNCj4gICAgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGJyZWFrOw0KPiAgICAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfSBlbHNlIGlmIChjaGlsZCA9
PSAwKSB7DQo+ICAgICAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBpbnQgc2xhdmU7DQo+ICAgICAtDQo+ICAgICAtwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjbG9zZSgwKTsNCj4gICAgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIENsb3NlIHJlYWQg
ZW5kcyBvZiB0aGUgcGlwZSAqLw0KPiAgICAgZG9fY2xvc2UoJnBpcGVmZF9zdGRvdXRbUElQ
RV9SRUFEXSk7DQo+ICAgICBkb19jbG9zZSgmcGlwZWZkX3N0ZGVycltQSVBFX1JFQURdKTsN
Cj4NCj4gICAgIC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGlmICgoc2xhdmUgPSBzZXR1cF9zbGF2ZV9wdHkoZnApKQ0KPiAgICAgPCAwKSB7DQo+
ICAgICAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBmcHJpbnRmKGZwLCAiRVJST1I6IGNvdWxkDQo+ICAgICBub3Qgc2V0dXAg
cHR5ICglZCkuIiwgc2xhdmUpOw0KPiAgICAgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgfQ0KPiAgICAgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHNldHBnaWQoMCxwZ2lkKSA9PSAtMSkgew0K
PiAgICAgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgZnByaW50ZihmcCwgIkVSUk9SOg0KPiAgICAgc2V0cGdpZCgpIGZhaWxl
ZCwgJXNcbiIsIHN0cmVycm9yKGVycm5vKSk7DQo+ICAgICAtwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9DQo+ICAgICArwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBDbG9zZSBtYXN0ZXIgcHR5IGFu
ZCBzZXQgc2xhdmUNCj4gICAgIHB0eSBhcyBzdGRpbiAqLw0KPiAgICAgK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZG9fY2xvc2UoJnB0eVswXSk7
DQo+DQo+ICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBpZiAoc2V0c2lkKCkgPT3CoCAtMSkgew0KPiAgICAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZnByaW50ZihmcCwg
IkVSUk9SOg0KPiAgICAgc2V0c2lkKCkgZmFpbGVkLCAlc1xuIiwgc3RyZXJyb3IoZXJybm8p
KTsNCj4gICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIH0NCj4gICAgIC0NCj4gICAgIC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGlmIChpb2N0bCgwLCBUSU9DU0NUVFksIE5VTEwpID09IC0xKSB7
DQo+ICAgICArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBpZiAoaW9jdGwocHR5WzFdLCBUSU9DU0NUVFksIE5VTEwpDQo+ICAgICA9PSAtMSkgew0K
PiAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgZnByaW50ZihmcCwgIkVSUk9SOiBVbmFibGUNCj4gICAgIHRvIGF0dGFj
aCB0byBjb250cm9sbGluZyB0dHksICVzXG4iLCBzdHJlcnJvcihlcnJubykpOw0KPiAgICAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfQ0KPg0K
PiAgICAgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
aWYgKGR1cDIocHR5WzFdLCBTVERJTl9GSUxFTk8pIDwgMCkgew0KPiAgICAgK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnBy
aW50ZihmcCwgIkVSUk9SOiBVbmFibGUNCj4gICAgIHRvIGR1cCBzbGF2ZSBwdHkgdG8gc3Rk
aW4sICVzXG4iLCBzdHJlcnJvcihlcnJubykpOw0KPiAgICAgK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfQ0KPiAgICAgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZG9fY2xvc2UoJnB0eVsxXSk7DQo+
ICAgICArDQo+ICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBpZiAoY2hkaXIocHRlc3RfZGlyKSA9PSAtMSkgew0KPiAgICAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZnBy
aW50ZihmcCwgIkVSUk9SOiBVbmFibGUNCj4gICAgIHRvIGNoZGlyKCVzKSwgJXNcbiIsIHB0
ZXN0X2Rpciwgc3RyZXJyb3IoZXJybm8pKTsNCj4gICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH0gZWxzZSB7DQo+ICAgICBAQCAtNDgxLDEw
ICs0MzMsNiBAQCBydW5fcHRlc3RzKHN0cnVjdCBwdGVzdF9saXN0ICpoZWFkLCBjb25zdA0K
PiAgICAgc3RydWN0IHB0ZXN0X29wdGlvbnMgb3B0cywNCj4gICAgIGRvX2Nsb3NlKCZwaXBl
ZmRfc3Rkb3V0W1BJUEVfV1JJVEVdKTsNCj4gICAgIGRvX2Nsb3NlKCZwaXBlZmRfc3RkZXJy
W1BJUEVfV1JJVEVdKTsNCj4NCj4gICAgIC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGlmIChzZXRwZ2lkKGNoaWxkLCBwZ2lkKSA9PSAtMSkgew0K
PiAgICAgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgZnByaW50ZihmcCwgIkVSUk9SOg0KPiAgICAgc2V0cGdpZCgpIGZhaWxl
ZCwgJXNcbiIsIHN0cmVycm9yKGVycm5vKSk7DQo+ICAgICAtwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9DQo+ICAgICAtDQo+ICAgICDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB0aW1lX3Qgc3RhcnRf
dGltZT0gdGltZShOVUxMKTsNCj4gICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIGZwcmludGYoZnAsICIlc1xuIiwNCj4gICAgIGdldF9zdGlt
ZShzdGltZSwgR0VUX1NUSU1FX0JVRl9TSVpFLCBzdGFydF90aW1lKSk7DQo+ICAgICDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmcHJpbnRmKGZw
LCAiQkVHSU46ICVzXG4iLCBwdGVzdF9kaXIpOw0KPiAgICAgLS0gDQo+ICAgICAyLjQzLjAN
Cj4NCj4NCj4NCj4NCj4NCj4NCj4gXy5fLF8uXyxfDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
PiBMaW5rczoNCj4NCj4gWW91IHJlY2VpdmUgYWxsIG1lc3NhZ2VzIHNlbnQgdG8gdGhpcyBn
cm91cC4NCj4NCj4gVmlldy9SZXBseSBPbmxpbmUgKCM4NikgDQo+IDxodHRwczovL3VybGRl
ZmVuc2UuY29tL3YzL19faHR0cHM6Ly9saXN0cy55b2N0b3Byb2plY3Qub3JnL2cveW9jdG8t
cGF0Y2hlcy9tZXNzYWdlLzg2X187ISFBanZlWWR3OEV2USFlVmJaWEdSQ3A0YmtfMTVuSWd6
RHYwUHJYLVRKSno0aXF5em9hQkJrZU1iaUVkTUpxR1JaQ1hIZXJ5MzZrTVlWYmFISkV3WW1S
Rl9JdGgtY00zNVU2Z1JtOG1yTiQ+IA0KPiB8IFJlcGx5IFRvIEdyb3VwIA0KPiA8bWFpbHRv
OnlvY3RvLXBhdGNoZXNAbGlzdHMueW9jdG9wcm9qZWN0Lm9yZz9zdWJqZWN0PVJlOiUyMFJl
JTNBJTIwJTVCeW9jdG8tcGF0Y2hlcyU1RCUyMCU1QnB0ZXN0LXJ1bm5lciUyMDElMkYyJTVE
JTIwdXRpbHMuYyUzQSUyMHJ1bi1wdGVzdHMlMjBpbXByb3ZlJTIwcHNldWRvLXRlcm1pbmFs
JTIwaGFuZGxpbmc+IA0KPiB8IFJlcGx5IFRvIFNlbmRlciANCj4gPG1haWx0bzphbmliYWxA
bGltb25zb2Z0d2FyZS5jb20/c3ViamVjdD1Qcml2YXRlOiUyMFJlOiUyMFJlJTNBJTIwJTVC
eW9jdG8tcGF0Y2hlcyU1RCUyMCU1QnB0ZXN0LXJ1bm5lciUyMDElMkYyJTVEJTIwdXRpbHMu
YyUzQSUyMHJ1bi1wdGVzdHMlMjBpbXByb3ZlJTIwcHNldWRvLXRlcm1pbmFsJTIwaGFuZGxp
bmc+IA0KPiB8IE11dGUgVGhpcyBUb3BpYyANCj4gPGh0dHBzOi8vdXJsZGVmZW5zZS5jb20v
djMvX19odHRwczovL2xpc3RzLnlvY3RvcHJvamVjdC5vcmcvbXQvMTA1OTQxOTE3LzM2MTY4
NzNfXzshIUFqdmVZZHc4RXZRIWVWYlpYR1JDcDRia18xNW5JZ3pEdjBQclgtVEpKejRpcXl6
b2FCQmtlTWJpRWRNSnFHUlpDWEhlcnkzNmtNWVZiYUhKRXdZbVJGX0l0aC1jTTM1VTZtN0wz
QlAyJD4gDQo+IHwgTmV3IFRvcGljIA0KPiA8aHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9f
X2h0dHBzOi8vbGlzdHMueW9jdG9wcm9qZWN0Lm9yZy9nL3lvY3RvLXBhdGNoZXMvcG9zdF9f
OyEhQWp2ZVlkdzhFdlEhZVZiWlhHUkNwNGJrXzE1bklnekR2MFByWC1USkp6NGlxeXpvYUJC
a2VNYmlFZE1KcUdSWkNYSGVyeTM2a01ZVmJhSEpFd1ltUkZfSXRoLWNNMzVVNmtob2VUY2sk
PiANCj4NCj4gWW91ciBTdWJzY3JpcHRpb24gDQo+IDxodHRwczovL3VybGRlZmVuc2UuY29t
L3YzL19faHR0cHM6Ly9saXN0cy55b2N0b3Byb2plY3Qub3JnL2cveW9jdG8tcGF0Y2hlcy9l
ZGl0c3ViLzM2MTY4NzNfXzshIUFqdmVZZHc4RXZRIWVWYlpYR1JDcDRia18xNW5JZ3pEdjBQ
clgtVEpKejRpcXl6b2FCQmtlTWJpRWRNSnFHUlpDWEhlcnkzNmtNWVZiYUhKRXdZbVJGX0l0
aC1jTTM1VTZoak1lYXRXJD4gDQo+IHwgQ29udGFjdCBHcm91cCBPd25lciANCj4gPG1haWx0
bzp5b2N0by1wYXRjaGVzK293bmVyQGxpc3RzLnlvY3RvcHJvamVjdC5vcmc+IHwgVW5zdWJz
Y3JpYmUgDQo+IDxodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9saXN0cy55
b2N0b3Byb2plY3Qub3JnL2cveW9jdG8tcGF0Y2hlcy9sZWF2ZS8xMzE3MDcyMy8zNjE2ODcz
LzQ3NjkyNzY3MC94eXp6eV9fOyEhQWp2ZVlkdzhFdlEhZVZiWlhHUkNwNGJrXzE1bklnekR2
MFByWC1USkp6NGlxeXpvYUJCa2VNYmlFZE1KcUdSWkNYSGVyeTM2a01ZVmJhSEpFd1ltUkZf
SXRoLWNNMzVVNnZfSVh2TWQkPiANCj4gW2NoYW5ncWluZy5saUBlbmcud2luZHJpdmVyLmNv
bV0NCj4NCj4gXy5fLF8uXyxf
--------------D5sk0dLlhgfN0wRvp0h0ydgV
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 4480gJlx010123

<!DOCTYPE html><html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body text=3D"#000000" bgcolor=3D"#cceed0">
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 5/6/24 23:44, Anibal Limon wrote:<b=
r>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:CAOU5ZMuzwmC_BAZGGgG+5+Ejy6O5Xv=
qUuz+07zZMNhwQ0X541g@mail.gmail.com">
     =20
      <strong>
      </strong>
      <div style=3D"border:solid #9c6500 1pt;padding:2pt;background:#fcfc=
03"><strong><class=3D"msonormal" style=3D"line-height:11pt"><span style=3D=
"font-size:11pt;color:#000">CAUTION: This email
              comes from a non Wind River email account!</span></class=3D=
"msonormal"></strong><br>
        <class=3D"msonormal" style=3D"line-height:10pt3"><span style=3D"f=
ont-size:10pt;color:#000">Do not click links or open
            attachments unless you recognize the sender and know the
            content is safe.</span><br>
        </class=3D"msonormal"></div>
      <div>
        <div dir=3D"ltr">Hi Changqing,
          <div><br>
          </div>
          <div>I spent some time reviewing the patch and this is a
            reduced version of it,</div>
          <div><br>
          </div>
          <div>If the parent set up a pty and then set up the child as
            stdin, It all needs to cover your case and previous cases
            raised by Randy.</div>
          <div><br>
          </div>
          <div>I tested the libtevent ptest and passed the 3 tests with
            this patch.</div>
          <div><br>
          </div>
          <div>Regards!,</div>
          <div>Anibal</div>
        </div>
      </div>
    </blockquote>
    <p>Hi, Anibal</p>
    <p>I am fine with this change, also try to run ptest for libtevent
      and bash, works as expect.</p>
    <p>Regards</p>
    <p>Changqing<br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:CAOU5ZMuzwmC_BAZGGgG+5+Ejy6O5Xv=
qUuz+07zZMNhwQ0X541g@mail.gmail.com">
      <div>
        <div dir=3D"ltr">
        </div>
        <br>
        <div class=3D"gmail_quote">
          <div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 6, 2024 at
            9:40=E2=80=AFAM Anibal Limon via
            <a href=3D"https://urldefense.com/v3/__http://lists.yoctoproj=
ect.org__;!!AjveYdw8EvQ!eVbZXGRCp4bk_15nIgzDv0PrX-TJJz4iqyzoaBBkeMbiEdMJq=
GRZCXHery36kMYVbaHJEwYmRF_Ith-cM35U6kMg_eyi$" moz-do-not-send=3D"true">
              lists.yoctoproject.org</a> &lt;anibal=3D<a href=3D"mailto:l=
imonsoftware.com@lists.yoctoproject.org" moz-do-not-send=3D"true" class=3D=
"moz-txt-link-freetext">limonsoftware.com@lists.yoctoproject.org</a>&gt;
            wrote:<br>
          </div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            Setup master and slave pty before run ptest, on child attach
            to the<br>
            slave pty and set it as controlling tty and stdin.<br>
            <br>
            See rev 59381a643e1fcce9b6920cb59af9402dd5eb0dfb .<br>
            <br>
            Co-authored-by: Changqing Li &lt;<a href=3D"mailto:changqing.=
li@windriver.com" target=3D"_blank" moz-do-not-send=3D"true" class=3D"moz=
-txt-link-freetext">changqing.li@windriver.com</a>&gt;<br>
            Signed-off-by: Anibal Limon &lt;<a href=3D"mailto:anibal@limo=
nsoftware.com" target=3D"_blank" moz-do-not-send=3D"true" class=3D"moz-tx=
t-link-freetext">anibal@limonsoftware.com</a>&gt;<br>
            ---<br>
            &nbsp;utils.c | 90
            ++++++++++++---------------------------------------------<br>
            &nbsp;1 file changed, 19 insertions(+), 71 deletions(-)<br>
            <br>
            diff --git a/utils.c b/utils.c<br>
            index 46918f4..3a35313 100644<br>
            --- a/utils.c<br>
            +++ b/utils.c<br>
            @@ -341,53 +341,6 @@ run_child(char *run_ptest, int
            fd_stdout, int fd_stderr)<br>
            &nbsp; &nbsp; &nbsp; &nbsp; /* exit(1); not needed? */<br>
            &nbsp;}<br>
            <br>
            -/* Returns an integer file descriptor.<br>
            - * If it returns &lt; 0, an error has occurred.<br>
            - * Otherwise, it has returned the slave pty file
            descriptor.<br>
            - * fp should be writable, likely stdout/err.<br>
            - */<br>
            -static int<br>
            -setup_slave_pty(FILE *fp) {<br>
            -&nbsp; &nbsp; &nbsp; &nbsp;int pty_master =3D -1;<br>
            -&nbsp; &nbsp; &nbsp; &nbsp;int pty_slave =3D -1;<br>
            -&nbsp; &nbsp; &nbsp; &nbsp;char pty_name[256];<br>
            -&nbsp; &nbsp; &nbsp; &nbsp;struct group *gptr;<br>
            -&nbsp; &nbsp; &nbsp; &nbsp;gid_t gid;<br>
            -&nbsp; &nbsp; &nbsp; &nbsp;int slave =3D -1;<br>
            -<br>
            -&nbsp; &nbsp; &nbsp; &nbsp;if (openpty(&amp;pty_master, &amp=
;pty_slave,
            pty_name, NULL, NULL) &lt; 0) {<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;fprin=
tf(fp, &quot;ERROR: openpty() failed with:
            %s.\n&quot;, strerror(errno));<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;retur=
n -1;<br>
            -&nbsp; &nbsp; &nbsp; &nbsp;}<br>
            -<br>
            -&nbsp; &nbsp; &nbsp; &nbsp;if ((gptr =3D getgrnam(pty_name))=
 !=3D 0) {<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;gid =3D=
 gptr-&gt;gr_gid;<br>
            -&nbsp; &nbsp; &nbsp; &nbsp;} else {<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* If=
 the tty group does not exist, don't
            change the<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * gr=
oup on the slave pty, only the owner<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; */<b=
r>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;gid =3D=
 (gid_t)-1;<br>
            -&nbsp; &nbsp; &nbsp; &nbsp;}<br>
            -<br>
            -&nbsp; &nbsp; &nbsp; &nbsp;/* chown/chmod the corresponding =
pty, if possible.<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; * This will only work if the pro=
cess has root
            permissions.<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; */<br>
            -&nbsp; &nbsp; &nbsp; &nbsp;if (chown(pty_name, getuid(), gid=
) !=3D 0) {<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;fprin=
tf(fp, &quot;ERROR; chown() failed with:
            %s.\n&quot;, strerror(errno));<br>
            -&nbsp; &nbsp; &nbsp; &nbsp;}<br>
            -<br>
            -&nbsp; &nbsp; &nbsp; &nbsp;/* Makes the slave read/writeable=
 for the user. */<br>
            -&nbsp; &nbsp; &nbsp; &nbsp;if (chmod(pty_name, S_IRUSR|S_IWU=
SR) !=3D 0) {<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;fprin=
tf(fp, &quot;ERROR: chmod() failed with:
            %s.\n&quot;, strerror(errno));<br>
            -&nbsp; &nbsp; &nbsp; &nbsp;}<br>
            -<br>
            -&nbsp; &nbsp; &nbsp; &nbsp;if ((slave =3D open(pty_name, O_R=
DWR)) =3D=3D -1) {<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;fprin=
tf(fp, &quot;ERROR: open() failed with:
            %s.\n&quot;, strerror(errno));<br>
            -&nbsp; &nbsp; &nbsp; &nbsp;}<br>
            -&nbsp; &nbsp; &nbsp; &nbsp;return (slave);<br>
            -}<br>
            -<br>
            -<br>
            &nbsp;int<br>
            &nbsp;run_ptests(struct ptest_list *head, const struct
            ptest_options opts,<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; const=
 char *progname, FILE *fp, FILE
            *fp_stderr)<br>
            @@ -406,16 +359,12 @@ run_ptests(struct ptest_list *head,
            const struct ptest_options opts,<br>
            <br>
            &nbsp; &nbsp; &nbsp; &nbsp; do<br>
            &nbsp; &nbsp; &nbsp; &nbsp; {<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (i=
satty(0) &amp;&amp; ioctl(0, TIOCNOTTY)
            =3D=3D -1) {<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp;fprintf(fp, &quot;ERROR: Unable to detach
            from controlling tty, %s\n&quot;, strerror(errno));<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
            -<br>
            <br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fprin=
tf(fp, &quot;START: %s\n&quot;, progname);<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; PTEST=
_LIST_ITERATE_START(head, p)<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; int pipefd_stdout[2] =3D {-1, -1};<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; int pipefd_stderr[2] =3D {-1, -1};<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp;int pgid =3D -1;<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp;int pty[2] =3D {-1, -1};<br>
            <br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; if (pipe2(pipefd_stdout, 0) =3D=3D -1) {<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; rc =3D -1;<br>
            @@ -428,6 +377,16 @@ run_ptests(struct ptest_list *head,
            const struct ptest_options opts,<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; break;<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; }<br>
            <br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp;if (openpty(&amp;pty[0],
            &amp;pty[1], NULL, NULL, NULL) &lt; 0) {<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;fprintf(fp, &quot;ERRO=
R:
            openpty() failed with: %s.\n&quot;, strerror(errno));<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp;close(pipefd_stderr[PIPE_READ]);<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp;close(pipefd_stderr[PIPE_WRITE]);<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp;close(pipefd_stdout[PIPE_READ]);<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp;close(pipefd_stdout[PIPE_WRITE]);<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;rc =3D -1;<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;break;<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp;}<br>
            +<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; char *ptest_dir =3D
            strdup(p-&gt;run_ptest);<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; if (ptest_dir =3D=3D NULL) {<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; rc =3D -1;<br>
            @@ -435,38 +394,31 @@ run_ptests(struct ptest_list *head,
            const struct ptest_options opts,<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; }<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; dirname(ptest_dir);<br>
            <br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp;if ((pgid =3D getpgid(0)) =3D=3D -1) {<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;fprintf(fp, &quot;ERRO=
R:
            getpgid() failed, %s\n&quot;, strerror(errno));<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp;}<br>
            -<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; pid_t child =3D fork();<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; if (child =3D=3D -1) {<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fprintf(fp, &quot;ERRO=
R: Fork
            %s\n&quot;, strerror(errno));<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; rc =3D -1;<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; break;<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; } else if (child =3D=3D 0) {<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;int slave;<br>
            -<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;close(0);<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* Close read ends of =
the
            pipe */<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            do_close(&amp;pipefd_stdout[PIPE_READ]);<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            do_close(&amp;pipefd_stderr[PIPE_READ]);<br>
            <br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if ((slave =3D
            setup_slave_pty(fp)) &lt; 0) {<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;fprintf(fp, &quot;ERROR:
            could not setup pty (%d).&quot;, slave);<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (setpgid(0,pgid) =3D=
=3D -1) {<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;fprintf(fp, &quot;ERROR:
            setpgid() failed, %s\n&quot;, strerror(errno));<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* Close master pty an=
d set
            slave pty as stdin */<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;do_close(&amp;pty[0]);=
<br>
            <br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (setsid() =3D=3D&nb=
sp; -1) {<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; fprintf(fp, &quot;ERROR:
            setsid() failed, %s\n&quot;, strerror(errno));<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
            -<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (ioctl(0, TIOCSCTTY=
,
            NULL) =3D=3D -1) {<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (ioctl(pty[1], TIOC=
SCTTY,
            NULL) =3D=3D -1) {<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; fprintf(fp, &quot;ERROR:
            Unable to attach to controlling tty, %s\n&quot;,
            strerror(errno));<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
            <br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (dup2(pty[1],
            STDIN_FILENO) &lt; 0) {<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;fprintf(fp, &quot;ERROR:
            Unable to dup slave pty to stdin, %s\n&quot;, strerror(errno)=
);<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;do_close(&amp;pty[1]);=
<br>
            +<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (chdir(ptest_dir) =3D=
=3D -1)
            {<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; fprintf(fp, &quot;ERROR:
            Unable to chdir(%s), %s\n&quot;, ptest_dir, strerror(errno));=
<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; } else {<br>
            @@ -481,10 +433,6 @@ run_ptests(struct ptest_list *head,
            const struct ptest_options opts,<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            do_close(&amp;pipefd_stdout[PIPE_WRITE]);<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            do_close(&amp;pipefd_stderr[PIPE_WRITE]);<br>
            <br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (setpgid(child, pgi=
d) =3D=3D
            -1) {<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;fprintf(fp, &quot;ERROR:
            setpgid() failed, %s\n&quot;, strerror(errno));<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
            -<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; time_t start_time=3D
            time(NULL);<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fprintf(fp, &quot;%s\n=
&quot;,
            get_stime(stime, GET_STIME_BUF_SIZE, start_time));<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fprintf(fp, &quot;BEGI=
N: %s\n&quot;,
            ptest_dir);<br>
            -- <br>
            2.43.0<br>
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
        <p>You receive all messages sent to this group. </p>
        <p><a target=3D"_blank" href=3D"https://urldefense.com/v3/__https=
://lists.yoctoproject.org/g/yocto-patches/message/86__;!!AjveYdw8EvQ!eVbZ=
XGRCp4bk_15nIgzDv0PrX-TJJz4iqyzoaBBkeMbiEdMJqGRZCXHery36kMYVbaHJEwYmRF_It=
h-cM35U6gRm8mrN$" moz-do-not-send=3D"true">View/Reply Online (#86)</a> |
          <a target=3D"_blank" href=3D"mailto:yocto-patches@lists.yoctopr=
oject.org?subject=3DRe:%20Re%3A%20%5Byocto-patches%5D%20%5Bptest-runner%2=
01%2F2%5D%20utils.c%3A%20run-ptests%20improve%20pseudo-terminal%20handlin=
g" moz-do-not-send=3D"true">
            Reply To Group</a> | <a target=3D"_blank" href=3D"mailto:anib=
al@limonsoftware.com?subject=3DPrivate:%20Re:%20Re%3A%20%5Byocto-patches%=
5D%20%5Bptest-runner%201%2F2%5D%20utils.c%3A%20run-ptests%20improve%20pse=
udo-terminal%20handling" moz-do-not-send=3D"true">
            Reply To Sender</a> | <a target=3D"_blank" href=3D"https://ur=
ldefense.com/v3/__https://lists.yoctoproject.org/mt/105941917/3616873__;!=
!AjveYdw8EvQ!eVbZXGRCp4bk_15nIgzDv0PrX-TJJz4iqyzoaBBkeMbiEdMJqGRZCXHery36=
kMYVbaHJEwYmRF_Ith-cM35U6m7L3BP2$" moz-do-not-send=3D"true">
            Mute This Topic</a> | <a href=3D"https://urldefense.com/v3/__=
https://lists.yoctoproject.org/g/yocto-patches/post__;!!AjveYdw8EvQ!eVbZX=
GRCp4bk_15nIgzDv0PrX-TJJz4iqyzoaBBkeMbiEdMJqGRZCXHery36kMYVbaHJEwYmRF_Ith=
-cM35U6khoeTck$" moz-do-not-send=3D"true">
            New Topic</a> <br>
          <a href=3D"https://urldefense.com/v3/__https://lists.yoctoproje=
ct.org/g/yocto-patches/editsub/3616873__;!!AjveYdw8EvQ!eVbZXGRCp4bk_15nIg=
zDv0PrX-TJJz4iqyzoaBBkeMbiEdMJqGRZCXHery36kMYVbaHJEwYmRF_Ith-cM35U6hjMeat=
W$" moz-do-not-send=3D"true">Your Subscription</a> |
          <a href=3D"mailto:yocto-patches+owner@lists.yoctoproject.org" m=
oz-do-not-send=3D"true">Contact Group Owner</a> |
          <a href=3D"https://urldefense.com/v3/__https://lists.yoctoproje=
ct.org/g/yocto-patches/leave/13170723/3616873/476927670/xyzzy__;!!AjveYdw=
8EvQ!eVbZXGRCp4bk_15nIgzDv0PrX-TJJz4iqyzoaBBkeMbiEdMJqGRZCXHery36kMYVbaHJ=
EwYmRF_Ith-cM35U6v_IXvMd$" moz-do-not-send=3D"true">
            Unsubscribe</a> [<a class=3D"moz-txt-link-abbreviated" href=3D=
"mailto:changqing.li@eng.windriver.com">changqing.li@eng.windriver.com</a=
>]<br>
        </p>
        <div width=3D"1" style=3D"color:white;clear:both">_._,_._,_</div>
      </div>
    </blockquote>
  </body>
</html>

--------------D5sk0dLlhgfN0wRvp0h0ydgV--

