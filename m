Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD38BEDEC13
	for <webhook@archiver.kernel.org>; Wed,  4 Mar 2026 05:45:11 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12046.1772603105800139328
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 03 Mar 2026 21:45:07 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=p8r5sEEC;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=7523de4f93=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6244pVWs2202455
	for <yocto-patches@lists.yoctoproject.org>; Tue, 3 Mar 2026 21:45:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=O+KBj9vWcY9Dw8v24iSswoSoGB3akRocf0dOQnWZLE4=; b=p8r5sEECadO7
	K8strFR4O0AF9TKe7lIfWryDASesffn6eHM1YrbqJOi2a6ElI/AN97t2+dJwabtG
	vmpADDFnhjW1JFG49yagplp2zj0SgkJG8pbJ/BBbEm3AZ5F6jCUIy1E9EVnbbPLB
	CUV2drx+qEBNiHy2sq9a+xuTwg27RZVsKzJyNMr/5RKBtZyFX4MukZ2kSKC62fKa
	9PKI8OezQDmTjcIfGQ/ENdDAXtJ1VeT0yGuI3KJfzpJGEx3xXbygWPqEoKyblNE3
	O45MU7LWggIzJT64m+hMStS4hxb51Y2wSQQOb8XXdtNnj0it5GROeHh28kfgTP3+
	OpdE3PaOeA==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010030.outbound.protection.outlook.com [52.101.46.30])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cm0rgm5nm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 03 Mar 2026 21:45:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvz+v+oJcO0W8G1p65093SPMLqCDWL4VEx5fFxNDtUUnqlxOp9eiuhTDXaolbkcBM+MuTHevDistztmID35+yUYpjIgHQUiIXzRSzRj2K/0/2FV3RDX5KYCq2thSzwsqjd4soPJr6tEdzVHBpm6Gas+yMffuXOiQgA/cYR/dmXe+wKAkrDeVN0Tqrf0jwGTGxN05c9lBEhvmRVNE+/4AR5K1NmCMn3Hs2+eah1j84v2JuQK2YG+zu3gCG6yav06xg+F1vvRCckk0arPIzHUwYjjusZE6aN9k0XIpvWawrVFFnn4hmmpZsEai426EE6OAxUpjSjDtbiccScOak93hSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+KBj9vWcY9Dw8v24iSswoSoGB3akRocf0dOQnWZLE4=;
 b=Z3qwlRAe4wtynRuYE04P5Ys9BTYTDTe3qKIoxtUCyRswXjbdyj2eBdDDplrGTyoJUGRNTlfiMzGxGTb+2dn+dKJJceENJzuh5sTj6+3y2gveHzhXsLU75KTGp7jHdIsTDtUE4yr+28iJZiVYiTEfFc0dl9GRYiU6MEUW39ePveDUlik76GzI0DT9JXy3jTB4esSyzPX/bjInxG9Kud+JmRLJLcrXMmvpmbl40XeG9XmstjzPUyWZ+/7xEVVnQw00grK/1u693P912XE3W5rH6pGapEaDWTCJGwj2W3GzZBn7t9VqGYm58xlRvF4beVHZfKxzTmSefI/H03wcyS0c2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20)
 by IA1PR11MB6466.namprd11.prod.outlook.com (2603:10b6:208:3a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 05:45:02 +0000
Received: from PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::c84c:d2c3:1102:cf45]) by PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::c84c:d2c3:1102:cf45%3]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 05:45:02 +0000
Message-ID: <42efff68-16ce-4011-9128-c3ad0b35d49e@windriver.com>
Date: Wed, 4 Mar 2026 13:44:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-tensorflow] tensorflow-lite not buildable
 since 3.14 python upgrade
To: yocto-patches@lists.yoctoproject.org
References: <8087c0ac-48db-4682-a3ff-28da284f351a@cherry.de>
 <ee18df0d-3770-4277-a55c-2dd38e5cc5be@windriver.com>
 <CA+chaQcG8WXk+4YV-iq4i5JvM+vkPb0iCwg8d1y+FhYpqvGq+Q@mail.gmail.com>
Content-Language: en-US
From: Hongxu Jia <hongxu.jia@windriver.com>
In-Reply-To: <CA+chaQcG8WXk+4YV-iq4i5JvM+vkPb0iCwg8d1y+FhYpqvGq+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To PH7PR11MB7608.namprd11.prod.outlook.com
 (2603:10b6:510:269::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7608:EE_|IA1PR11MB6466:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c2ad8c6-2e01-4405-d824-08de79b12e29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|4022899009;
X-Microsoft-Antispam-Message-Info: 
	/pT+8IsRMg5gx9a/hb+6MC2YKB3FUXiv3HPEwJNPhJB6U1PwmX2Gs5H6b0ldQaXwT7YLwCal7fYo7eBkqvr6yIsaaGwdy4l8Dv2z4Qdy8MtOuLpYHos1NB3kDKDrD6mGCrjX+TlYx1qvad3pgzivr5JUnqoLvfbmffDTC6dUpZaaaBXjSzJ+kOC5pi8cf161FPGqjYHW1ONC1cWlgwbidepm84Ea4/lSxWcyQWtR8/Omn3KYPL4bE+2Pypfp6JRHoqjimQW0P2255Hx1dGt/lN0fYgAcrTGv18uBJUPaHflTyYuSVu8Epl/ZNyH/dUdriXLTouYKVp686kgRf4/bAIZeLFmtw+Ro0DlCMxQaR4V79ncY3tuQigDyN2Hqb+Xfmoxv2cn09IgT0l3CkRXyjZ8EneUor+1gdK538RLz0HHWVvoFEuszW8osK+IhDKuAn14O1GpodDn0dVg+pSu2iEQeAbMw+9yyuYnXqH9v66uiYPOJjL1y1D01rQNgI3HstMarnyN/8XL5i7tPiAaHcZob1jndGbCFNJOy4VJTbewXxatDSXVxPPu5HzwNH3gGP9ngwo3t5RFa+XkYymmTjYHuBUQdf8RXqmBVC8xV2FCy6WdlLAV5tSxxr5v1ZjXNJdHFrOAPAyUKWkGpZQV5RIc/Mr0yafxUAjweoAv/7uCaa/d4C1p9tWB6+6HU5Ca7eJJkTJSGZIXedhndTbCV7RVihbZyQ1feNzYBWv2oAyr2jbhupCaWFBp9H+Y5MAaj
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7608.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(4022899009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eE13dGI3cU90NHlFdlBUN01GVEFyTzQvb0FmUXJWMHZVby9LVFI1V093Skli?=
 =?utf-8?B?YnQvTEo5Z1hOTWRaMUFhSmhNMlJoa1V4SDU1QTlQQ2NZanppUmswS1BabmJh?=
 =?utf-8?B?Z0JCOEk1L21TOUxoU01hN1pGUDA2SExkeDdkNU1HR1F6RkJoYW5hRHJMTkEr?=
 =?utf-8?B?MjlIdWRGbzlyK0YydkFKK1lQcXhrbUVpWGxYQmhYTGszWi91cXNucHNaTE51?=
 =?utf-8?B?akZIYUZwd04yLzZjNFVEcUtGb3VDZ3oyUXNBbW5ueEx3OUQ1QytDSW5leU11?=
 =?utf-8?B?cGpTZTNnS0RSM2lUYzZCQ09xK3M5b3k0b2k3SW1BTXI1SExqT2JQY2J2Zmlw?=
 =?utf-8?B?U3pPSExieGFra1lWV0pFY0ZBVDEwTGpsakhIQU1EdjVjTDRzNlZTNDhLTnpU?=
 =?utf-8?B?RmFYM1BnZE5LVjc5MFE5bmlzWk9rL3BtMHFJb2FQTUNJTExxbzZHTXM0WjQ1?=
 =?utf-8?B?ekhTUlRxZm9DT0JHcWNSK1ZnZE0vemFiWXhNZWhlWmYyUG9qbG4yZWFLNnNT?=
 =?utf-8?B?VGRIbTRZRGo2TzhYUHlLUWhGdmc4WkljMTJ0MXQwRm1uaVYxVG5DdFpaWm83?=
 =?utf-8?B?R252cUQvYVlHRkh5cmxWazQxVDhEblZYVUhlOFBXTnRING9SbW9Qd09YWXVi?=
 =?utf-8?B?S3BmMnA1YldyS1ZjS0VDQm9IM0Z3MmtReDNoMTY2Szd4UzEvR3dHTmZVUXZK?=
 =?utf-8?B?c1d2NXFGc3BJVHJab3h3Sk10dXpDY1p1a3ZrcmMyRElCR0Z5dGdQMTFPYVNk?=
 =?utf-8?B?MlBFU2puT1NONlpQZWF5MVdVNGxFOHFoUGFyVTVDS1BOc1lxZDFwNFY4dEhN?=
 =?utf-8?B?Z2dOeGlDVThWYWhWaW9rQS9IWFBrbnM1MXZhSVRtTDhqNFlRT1VqVTExZkcx?=
 =?utf-8?B?ejYwM0dtK3pZK0J4WFNnKzhvRlZnQlNPcUNSRmNqTXJDd1YzNkMzMGxCL3pw?=
 =?utf-8?B?TzdzY043alpPbVB4RmNKRXpnK3doMFlobFFvKzVlTVZWZlp6UWlLQzRhbFJm?=
 =?utf-8?B?b0g5OXpRaStOVm12QnNEZEV1Qis4STBXUTMwYWlqSXlpWEZuaW8vZkdMbVRJ?=
 =?utf-8?B?dHJrRlRPNWpOY25OamtoUERZU2JVeHQyc3h0anRhalF5QjJrNlh3RnQ0WGpJ?=
 =?utf-8?B?Q2NFTmgvRGxncnZvdjdTRWEzY0RaT1pBbWRCQ3QybjJWQ1M2eVpDMWNVRjNG?=
 =?utf-8?B?dmZIQ0RUekV3Z3BpSWkvVlFic1lueWRKaGxKbkpXWjhLVStHNG52K3VkeFJz?=
 =?utf-8?B?NERVRHdacDNyTEExQWFoMTR2ZU5EbmlZVk0zWmJ1cGhNS3kvalA2dFlSc0JT?=
 =?utf-8?B?ckVOcTlTdzIzdHd5clA5KzhnYnh1VSs4SUNOSFZOTWEwOVphUjhZQVFvYjk4?=
 =?utf-8?B?K3ZXMVRZazZjSkl1d2swemIwYndXUExkeGlWeGVJSmZBOVZaRnlOYWJ0SktX?=
 =?utf-8?B?UzhZbEFSZW9JekZkRkRxVHlYUVNnV1NVbUhpejFoYkp3Q1V4SEJkaFFXdnZS?=
 =?utf-8?B?VktSKzY0OFRyeUtXdVVBOEhIOHJxeFIwM3NRNEh5cFpPZUJMQTlJVGk4NThI?=
 =?utf-8?B?ZEVyMllURllTcnNISERKV1hucHVaZ0MrUEM0V2pvK0pEVXBVeWd4WlR2R0da?=
 =?utf-8?B?eGhGSDRnSFFiWjgvN3J6dHQ1a0tkaGJHSEo2M0lWb1c0WlFoRkN4K3lhZmdz?=
 =?utf-8?B?YTY4VlZmblpqa2ZRQjJKM2JRU3g2UEcwdWUxY25peTRzV2dhZ0NHMTlzdXVu?=
 =?utf-8?B?dEZ1VUVndjFLaXVHekZPMTVpZHRNZUREVEEzdTd6TCtGejB2SlZubkhXWUM1?=
 =?utf-8?B?dFpiNkxqSHVRZE1kdVUxeDVTQ3h0aFlORCtjbzlheGtERU9RMHRRdzBQUEx1?=
 =?utf-8?B?NlQ2Vy9zRDFNKzBHZ1VFY0gwZVZwUjlNb1VDL3hmN1EreTVYNlYwaUdMdFNP?=
 =?utf-8?B?MERDTnpubUJoOFFEV0ppTlJlWmJOdDBCVXgrQVdYSmJJKzgrQ1B1OXc2QThC?=
 =?utf-8?B?d0N6YWFKMDlPakdhQk90WkN6WlFRR21wSmo0ZE9SdUo4MTIvS0hYSm14clRV?=
 =?utf-8?B?LzFvSVNGcFZWSUxZbHJaNUp0K0Vrck1nWVpLQXVMbnJHamJDd2dRMEVZQ2ZT?=
 =?utf-8?B?bUJoV1BxbGNjTDNPUm1lb1RmNHhUc1Z4QjRuSSt1clRhRnVRbitZeHo0ekJ3?=
 =?utf-8?B?WlhNTWlRMnpjNkFHamQ5bUpYV1MyYklYOGc5d2hXTHByK3ZUMmR6MmFSczR2?=
 =?utf-8?B?UzR6MnRQYjFtcmRCRkMvbDVaVVJkMFhDb2NMRG13UzdkYVVJRThFUGVXdUd3?=
 =?utf-8?B?ZUZIUjl3YlNkT2F5cXl2VytVWGdkOGdtVXVjV2hiYW4ralVheFZ1VFdKRVVt?=
 =?utf-8?Q?GD+RHKRMLLjgqy8I=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2ad8c6-2e01-4405-d824-08de79b12e29
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7608.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 05:45:02.6787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRPrph3WQl2E6Ku3uHtr7pDI7lpSmzLugayamrO+Py6jxV1snjKGPNZOLEKH5ALta2emO3uFwaMorAGjjFtJ5knGwTuBS4zRPCH2z+uG/Aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6466
X-Proofpoint-GUID: 8f3jOBT9XX-RioEHHWiHLvIpfe8EefPq
X-Authority-Analysis: v=2.4 cv=Of+VzxTY c=1 sm=1 tr=0 ts=69a7c6e1 cx=c_pps
 a=7sXfYZKWL/+VDStniiEWIQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=NEAV23lmAAAA:8 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8 a=GVKP62EgdZQw3bhSVDYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=nM-MV4yxpKKO9kiQg6Ot:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 8f3jOBT9XX-RioEHHWiHLvIpfe8EefPq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA0NSBTYWx0ZWRfX4JOk+QRj2vMV
 VjcpYz7EbYeUjqvfupaysckZApcnahUbuZq/L7LpnhMpbN4jYzxESXreodgnQ5sRz11lY5bT+Xh
 4LxIFgAq6vsvMvzC4+ys63m0+u1miYE6m9Sxoh6nsGuCAaqqOA+OlHneqwF1RwVR+3POBmX8K6o
 cqTFi791GBYuLnGHqreUQz39tK9iU+zXHj0V7sMfdhtyttjKCN/dhoTlbo8N7wwcLgkXOoYXPFV
 5BrzugZ04syuyDzTQsXpqN5qYDOAgO0c8EdQcf55sXQZdv0Xdeig5zKtmRQpYim6rDxu739jRGr
 HdNUu5GUFetRcoN+9hEeyqRcidrUBvX2NU4zNN0nWVycXcR4h5krlaULZ9cqvETlVV4dcJMd39Z
 C7C10kmX4vJUhyAP0SuwV1MfdDFQQu/srs9lpTCLPbJyabDLt1TY9GaLN7P7vGQ8CtGKE5Cpf4i
 rMCnE+xFuD+L5o/sF7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040045
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 6244pVWs2202455
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 04 Mar 2026 05:45:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3323

On 3/4/26 13:29, Martin Jansa via lists.yoctoproject.org wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender =
and know the content is safe.
>
> There were some changes for supporting 3.14 merged recently e.g.:
> https://github.com/tensorflow/tensorflow/pull/111070
> https://github.com/tensorflow/tensorflow/pull/111421
> do you plan to integrate them in meta-tensorflow instead of the
> python3 downgrade to 3.13 or are you waiting for some official
> tensorflow release which will include them?

Thanks for pointing it out, I will have a investigation on above pull=20
request, I am working on upgrading tensorflow to 2.21 for now,and I will=20
add above new python supporting

//Hongxu


> Cheers,
>
> On Wed, Jan 28, 2026 at 3:21=E2=80=AFAM hongxu via lists.yoctoproject.o=
rg
> <hongxu.jia=3Dwindriver.com@lists.yoctoproject.org> wrote:
>> On 1/28/26 01:29, Quentin Schulz via lists.yoctoproject.org wrote:
>>> CAUTION: This email comes from a non Wind River email account!
>>> Do not click links or open attachments unless you recognize the sende=
r
>>> and know the content is safe.
>>>
>>> Hi,
>>>
>>> Just a heads up that the tensorflow (I tried -lite) recipe(s) doesn't
>>> build since OE-Core moved to Python 3.14.
>>>
>>> There seems to be *some* support upstream (and plenty of people
>>> complaining there is no release with support for 3.14 yet) but it's
>>> still missing a requirements_lock_3_14.txt file which is the first th=
ing
>>> that the recipe complains about.
>>>
>> Thanks for your reporting, we have to wait for upstream to support it =
[1]
>>
>> [1] https://github.com/tensorflow/tensorflow/issues/102890
>>
>> //Hongxu
>>
>>> Cheers,
>>> Quentin
>>>
>>>
>>>
>>>
>>>
>>
>>
>>
>>
>>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3322): https://lists.yoctoproject.org/g/yocto-patch=
es/message/3322
> Mute This Topic: https://lists.yoctoproject.org/mt/117492755/3617049
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13176=
071/3617049/43253763/xyzzy [hongxu.jia@windriver.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>


