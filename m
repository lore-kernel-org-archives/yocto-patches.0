Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FA2C3064D
	for <webhook@archiver.kernel.org>; Tue, 25 Jun 2024 13:35:49 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.173255.1719322547538398760
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 25 Jun 2024 06:35:47 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=6906f46a45=yi.zhao@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45P6PTcF025399;
	Tue, 25 Jun 2024 06:35:44 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ywx4ftjxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 06:35:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bD8E3gAaD7pJoWdKv7Qb2IKq6/GGs6idbsEQeZ8MgOa5fFB9PjgIbOg5bBaf/16tLs8ABjIMA2KaUhRZ0a3n4hHchPt83qzPwtMImmf2/DRyzURVg+fbATASRgzcAKE8GsbP7QO2Y6YaRUHnIeEEOseHcgmtSWnWhodH+WILraqQ6dwq0TyEU1VGb19XF9DQg458aq+q1bG4QJBb0tBsuR60LpSDQ4vsi5IRIJgZ/3CVMe+YVudXjuKgljvk0Jqbs0ECCF24xQ80t/J7TJeRIu8gL62FkK4C24NMuHv/AIXngI1c7KaHGfchJeph30NFTubXvOR9dUBIsBDYLDTlMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgOAKfeCKrKHTs+I0XHCNQCFFE0OAkqVPDxoULI5c+4=;
 b=hQtDQ59b/42r4vUs335bQbrMqR2olSf7lnOZYZF5bYqugetqsGHdkb74PlMnOXlAgjY94ILUKx///X6I/4KLq7M1YFnx2CMx5vvKMmTeXh0gS2/FKw/Jqzi2GU33rnvGFcVGMVbxPtIrMPhR0VGvfCNJRUI+jQirMP+5gPLha1UBnlwqgqdNGRhHzU40RZYdxGud0bozT9eNM3YMdItDSl9SmTYBa9mN7n4yQlhj4B+UXxaUaU9fcEjY+yIXH7f+R//R+KPZ8ns5rncpcdkoHhrzxE2cPzaK559zLRP7BzDR8LzLnMzPNYK62ErminJdAlQF2URBzxtWfS5kM9XuSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 BY1PR11MB8127.namprd11.prod.outlook.com (2603:10b6:a03:531::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Tue, 25 Jun
 2024 13:35:35 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 13:35:35 +0000
Message-ID: <7a42657b-70d3-450d-8e5d-54a44aa5d571@windriver.com>
Date: Tue, 25 Jun 2024 21:35:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-selinux][PATCH 1/1] Add SELinux specific
 configuration snippet for busybox.
To: yocto-patches@lists.yoctoproject.org
Cc: "Weisser, Pascal" <pascal.weisser.ext@karlstorz.com>
References: <20240624090200.1746755-1-pascal.weisser.ext@karlstorz.com>
 <20240624090200.1746755-2-pascal.weisser.ext@karlstorz.com>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <20240624090200.1746755-2-pascal.weisser.ext@karlstorz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|BY1PR11MB8127:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f3ac19e-4943-4776-8a36-08dc951bb13b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?b0RPS1JxNVBsaXNNK3Q4RHYxMjFMRExaT1VMTmwzQU9DUTg2aEZuaS96alFP?=
 =?utf-8?B?SmRGa2I0VmlMZTZUOUhRRGZPK0pWbWJ0cmRtbzJScU1iNy9zMmIrVjh4NzVR?=
 =?utf-8?B?WlRkMjc2UWFkS3Y2d1VFdzZ3ZDJCUjJuYmVianl2Tk83OEZScUhITGlESEx1?=
 =?utf-8?B?a1dtZmNTMHRWcWJSY3pDUHFmYnhDaGRWUEhRbTE2SlY0RkJKdGJRaks2aXlG?=
 =?utf-8?B?V3J2a1lkdWNJWjU4ayt0RXNFbnpTTW5vK0JMWGZtN0FLbURwc1JSaGRlcHJH?=
 =?utf-8?B?U1BIa1JIQ1hJQzl1RlFUMmdJQ0FWQnkxbmFPdWlNcDJTVjNrZ2JaZHdmVEFK?=
 =?utf-8?B?eE93VzNsNHpjNjBnRkI1bVdRUldJbjlxTGhTU0VKVmlJVzNlMEE5K3ZBY0l5?=
 =?utf-8?B?VmlSMW45MDAzUjBPNnpEVGJzblBaTENqWk1ITGRvOHJ4VUtRekRDZThydHlq?=
 =?utf-8?B?WVdOQkZSVUhwWGNmU0FpRytDR1pEalNWZ1o0aFpsaXVUbHAwNlV3ZktvR0RB?=
 =?utf-8?B?b2tRbWpMQzgyMnBqTEJUV0VIdjI5UzBVS3dtY1hZVDlUS21wb0x6d1dpUWFp?=
 =?utf-8?B?MndwS1BZcWZpVzVHa3JqRXgwdUd1QnpNcXF4REpnYW1vaFcxTjk4SWtEcUxS?=
 =?utf-8?B?OG50V3FUZjJ6WU9QbVR6OUFTYzFJdXo4ZWFXTzlKVWVGdG9lajUya3ZGaXl0?=
 =?utf-8?B?RDNzb2lJeGhJeDJ4c0NpeFp0NEZFOFdaYXVmc2FKUlZ5L1V5M0pxZFIvT0ho?=
 =?utf-8?B?cUtLUzI2ZEZlc2tmWFM1dDNRQk80eGQ2cEZGdWdINmwwazlNZmw2NHZqeWhU?=
 =?utf-8?B?QmsvTyttNTFxWWh3VHVjbDZMMEVRUGtYV2N0c2lLZ1VzZzFHUmxJdy8vNHhx?=
 =?utf-8?B?NHg3azhGOG51WWw4ZVgzeW5jbzExSEpUTXdLMHdIYjE1eFA4V2x2WVlFcVpY?=
 =?utf-8?B?eHgwdllQdTVCc1VkNzA1NXliQU5EdFZMQ0djL29jR0p3bWhWSmNsQXBiQThT?=
 =?utf-8?B?dHc1UFhRNEZtU3lDWkFRQnJiM2t5RmJJcXcwaEZEKzlYS0l1RUFFNDg4cCtm?=
 =?utf-8?B?NVpUa05JM3o1Qm5oLzZRMFdYVFpKV0VubmFyVVlVSkxYTlpveHZRMkcxT3hF?=
 =?utf-8?B?UmJwWFBLeUFXUWc5VHlhcHJXM0MweEZqamNRRTFieFFuZFphRjNOckIxb0NL?=
 =?utf-8?B?LzZRSUFOYW5XTU5GMHVDZUFhQjZJRzRIdUR2NURGTzA3RnVGY1N0MlB1ZEwz?=
 =?utf-8?B?eUtQVGROekx2ZG1KRXdQTjc3a2lteTRzdTNQOVlSQlR4ZW0yUnFMMmRLc3RE?=
 =?utf-8?B?VGNVb1pRenRRenVzdkYrbkVlUWUwbFdLU0g4QW5hek5lSWdmbC8wc3dqQUxu?=
 =?utf-8?B?bUUycUk2bEU2dGQrQlhIQ294ZlkrUzgxOUtWQlJ4UXIwZnJ1TFlFd1p2TXBp?=
 =?utf-8?B?TWE0bkJaY0M1M2dHZmRNRVBmbE8yVm91UU1NUFN1ampYbzJHaElLSkJ5UlNM?=
 =?utf-8?B?UzdnTVh1OVhKenllaVpvV3FraWlqRUN4SmxiRVRTOUd1TmpoU1BZNE9kWG43?=
 =?utf-8?B?NU9PNXZENjA0UVhHMHlmYXpHYWNNMmI0NnV0a1grbzVPanJFYmJWUjBORnda?=
 =?utf-8?B?MnI2UjRHa1lPWVJ6eWhTSWJUb2VDc1hpbVpHZzhKYTRtQ1JadFF2citPRHNp?=
 =?utf-8?B?RmtwTEg1TGhVRmMyZXlVRWpQTnNSQ0NZbWlJVW1yeUZYMEtDUG9qcmQ4ZVd0?=
 =?utf-8?Q?/71WMC5nziy1uEEir4Pr6fL7+mFdUVgBUp83ra0?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z0ZKcEFwSC9XZXNRYmlZbkwwWWZlamtzNEc4TUh1dVZxdzYrbHJnL3RmdFMx?=
 =?utf-8?B?VHYzMnRET3RMVlVROHRMQURVMXdWclBZdTJlbFVHS3NVeHZFMW56UmpzOUh2?=
 =?utf-8?B?a3N5N2FUNzlJSXJ5bk14TEJFK3NIaEo4QkIvZkl1aVRDdzNPSThBMk1ybGxn?=
 =?utf-8?B?Z0dzc1JianJwSmVhMGtia1RWK1hOaXpCby9GVUQ2akNOMDlkTVJVL2IwMFBq?=
 =?utf-8?B?bTYxdXZpVmtoLy9WWGxlUktiYUM0bjR1YUI4cmp5bnp0TG83Rk40OTJ4ZElK?=
 =?utf-8?B?Wk9YVytkN3RiQlV5bUNHakZGVmJvNmY1Znh1eVlvcFlLTzFCNFlRb0ljMHJY?=
 =?utf-8?B?NUk5R2lxaCswQ1QwakRTR2FiZ3BBSDlRUXArYUZpSlZqd3JzR2ZVNlI5RE5o?=
 =?utf-8?B?MEVoK3MxbHFlNHU2ZTdBQVdGTGZCZW0vUjdKWXRzbVRWV3VXSVk4Y3JITk04?=
 =?utf-8?B?Nm4rTXlDYWxNSmpzSmNvVTc2VFZIcE1PR2FpRlBzZlBoUDZSaDJGM1YybzRV?=
 =?utf-8?B?QVZ0U20vUXhQRCtseUN0WmoxN2w3b3JEVVBkQTcydXlzUy9Sc3U5NzU1SEtF?=
 =?utf-8?B?OW5UQndlak5CYUEzVkF0d3ZFb2pxbW43ckZJbWZtT010YXJoZjNEUXFGMVVx?=
 =?utf-8?B?N0pqbmNvZk5qTnZSdDY4OE9tMjVUdTZndk9HWUVSYmFhTEtIRHM4RjZ5Tisw?=
 =?utf-8?B?aGhQczBIbTVXYldkV1gxSXdXVjZBaElUOUdKYkZ3UU5mMVRTMEhTVDFpWjRS?=
 =?utf-8?B?NzF5aHVRZml2T1ZpUGxlLzVSWTlIYnF4SU82QmQ4T0JJczNoVEJ2QWtBRW1Q?=
 =?utf-8?B?NU1LZC9mSGludXY5d2FCbUI3ZjhyakhSd3dRcmgrYVBORC8wSXZIMGMrMWhV?=
 =?utf-8?B?WS83NmVoY3FSUU9UK2VnRlB3alNSa0hXb0hXZEl3akpFTEg0bm5HaWx1Wmhm?=
 =?utf-8?B?QyswQks5aEt4RmxDWEJZd0V4VWNNYkROcE9KUitSWk1UR2ZPR3Q4QkJVMHlI?=
 =?utf-8?B?UU9VcUQ3ci9NNGpURmFLVGdPVTc0dWt4L0JqQm5xbXZCTHVvRFYwNzlmOG9m?=
 =?utf-8?B?eGQwTnJTVEw2eGVuc1FSeWNqWjF4a0xVYlFIUHZSWHlnQWc3d3dHenk4eTFK?=
 =?utf-8?B?SjNvdERrWjAxK0FQMGVVcUk4QkFXOU1jMkFhVWc4V01QMW1DM1BOM0ljY2VL?=
 =?utf-8?B?VE05bEExZ2tlQUNtNEhWVCtZVFRQRUpyZ0h1ZDYyd3VXOWhqYTlzdkVFdi80?=
 =?utf-8?B?dEcvUUVYQVpSUUpnKzF3NlBaaDZEWk9kaVpqRHRxZ044dG1aVWV6QkRxVXg2?=
 =?utf-8?B?dGM1QXB6aWlLTXFNQzZKUmpEc25TSTY2cC9NYXNkSS9BbWhESEVlQmI0ZG1K?=
 =?utf-8?B?ajZVQlJSMEpFdjRmWXA4c3Z3M1NkbW9NQmxNeVZFWVlKU2VZS0RRcHRESG9C?=
 =?utf-8?B?b1dRMTQ1S1dyY3FWU24zY2QwWjgwRGxIN0hSYmlzTTROdWpHdDFIVHFQRGl4?=
 =?utf-8?B?d0tCVlRLalowazdZL1B0eHUxSTVmL1FrQ05TZjc1WWdjQ3o0eGVXWmpUZ2dl?=
 =?utf-8?B?SEJYTXplUjFBcnZJcHVCTlVCdWRyajZwYnYzcmkyZmJ0SkVpTkFiRzlTbnNq?=
 =?utf-8?B?RTRkeXlkSGhtTi9QdTJhM1lPcDQ4ekhMVGZ0ZGI2dTNKYjljK2JrcktySTNr?=
 =?utf-8?B?Y1V2K1VjUTc1dWZGamNKMDhKenBBb0tnRTcvVTdya0JBYXAvTW5OMitPWkVk?=
 =?utf-8?B?WE5tOGpsRWFhRkRyb0xkWTZOZlEwb0plRWJFVGdkdGNMNzZBRlc3dE9aSWVV?=
 =?utf-8?B?aG9VUEhITUdhUGptdEgxS1lwaXdLS1pmbklsVDRDQzd6YjNvdnphMkFlVHNt?=
 =?utf-8?B?azBYaTBtbldXd2puWmFZT3R2L2l6dUUwR0NucVlGV0dwZGJOU2xRYkR5K1BS?=
 =?utf-8?B?OFI2TzlybnFrSTJudnQ5bWRtUWJFUEhPM25QOEVwTDJLVW5vckVnWkFkL2JI?=
 =?utf-8?B?OXYwWk4wVFo0Q0I0WVNacmFBSGRwSysydnFDbmorcHlXa3piLyswbkhGWUl6?=
 =?utf-8?B?Q0JPeWpjczBDQ3V6Wk11dEF3ZWY4K0V2blRRenBZY0N2ZEhEU1lrYm5kbUxB?=
 =?utf-8?Q?CIXx8hW/XbLmLwxwmBioiWiT5?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3ac19e-4943-4776-8a36-08dc951bb13b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 13:35:35.3564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LgCV/jk2qKbl6XyZ+hhb11jtUzQVXVH761qdxtr4hribZGd3IeUuSZi9zlRBUEVlpSyLOXJ2c7yEKbbv+z6bmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8127
X-Proofpoint-GUID: RHzJHyBCBxJonSlEZbfxEDUlB-0lq1FE
X-Proofpoint-ORIG-GUID: RHzJHyBCBxJonSlEZbfxEDUlB-0lq1FE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_08,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2406140001 definitions=main-2406250100
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 25 Jun 2024 13:35:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/371


LGTM.


Thanks,

Yi

On 6/24/24 17:02, Weisser, Pascal.ext via lists.yoctoproject.org wrote:
> This patch adds a SELinux specific configuration snippet for busybox to
> enable SELinux support in busybox out of the box. This is needed to enable
> SELinux specific command line options for certain commands like ps -Z.
>
> Signed-off-by: "Weisser, Pascal" <pascal.weisser.ext@karlstorz.com>
> ---
>   recipes-core/busybox/busybox_selinux.inc | 6 ++++++
>   recipes-core/busybox/files/selinux.cfg   | 1 +
>   2 files changed, 7 insertions(+)
>   create mode 100644 recipes-core/busybox/files/selinux.cfg
>
> diff --git a/recipes-core/busybox/busybox_selinux.inc b/recipes-core/busybox/busybox_selinux.inc
> index 740980f..ade30cf 100644
> --- a/recipes-core/busybox/busybox_selinux.inc
> +++ b/recipes-core/busybox/busybox_selinux.inc
> @@ -1,3 +1,9 @@
> +FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
> +
> +SRC_URI:append = " file://selinux.cfg"
> +
> +DEPENDS:append  = " libselinux"
> +
>   PTEST_BINDIR = "0"
>   
>   FILES:${PN} += "${libdir}/${PN}"
> diff --git a/recipes-core/busybox/files/selinux.cfg b/recipes-core/busybox/files/selinux.cfg
> new file mode 100644
> index 0000000..00aeb51
> --- /dev/null
> +++ b/recipes-core/busybox/files/selinux.cfg
> @@ -0,0 +1 @@
> +CONFIG_SELINUX=y

