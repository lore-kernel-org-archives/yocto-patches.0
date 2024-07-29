Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7EAC3DA61
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 14:39:18 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.57878.1722263956614558348
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Jul 2024 07:39:16 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=8940d18bb4=yi.zhao@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TChGPr009010;
	Mon, 29 Jul 2024 07:39:11 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40mv619q98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 07:39:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/7nxDzztIHY58/HKzMrm3a3FXYLvRPmLs+RufmIQnOOKkm5RKyP5m1MTUlb2BPM/jrhpIje21RI/nvHzHiD5GxcZXy/ujU57ALVbzIaC1ntrEcqekLKdY9Z2mmQcyF08m4/rKiAgooSLUoCA0MpJ0Q78Yvlgd+28Trsd81A5G0+zV3dI/xKiJSXTNkp4DqlN6BW2G7fS8rgmjwIDSQCsN86WcyXXsgjzmPYpJpPkHDS44osc7xlq1FdLZkwkpmAY4+Sj/UrfEo2L65rdyscAI8zQx/puX/+S/r4wu4MuhyStSmpbCN7HxEiiXT1jsTXLJsDI2D/lxodp/sS6g6oCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8D2qlMHM3dckgbkm2PNGo7PYT8l1yd41XwvWVal/fY=;
 b=Uv1dS0g9KMJvVP9+Wd/rMo+oVb2XpVGuwF/daXnrhazUKsklzb8557oMduAhgF/pVaaNE72WMf0vpbTT/R693xFRWilhBKzHGEt/0hmxlhbHQW+IY4SrdFGmV3h9njZ6nhWWH4s39n0viNp1N0cz5Rn4FJHFOQvF7RGBnb/zjp2iGQjDi3NLmM5PZ+Nu1FW6b1Y70wSgx7x9ITVs9K/KIO35x3NyYFuv6nkfGisf/Q0Yr/Cc7jYxs6RjqMyUyNSwZtU2C6pK+Ya+QoD/NyAxhTSaRjrvVWUR4UfZfYCV3QiHZj3wlYHxnGApsygL7Y6DOxokC5uZmuEqsrkNSsI6yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 IA1PR11MB7942.namprd11.prod.outlook.com (2603:10b6:208:3fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 14:39:07 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%4]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 14:39:07 +0000
Message-ID: <ef6ee660-e678-45ef-b7ad-021b88d8616d@windriver.com>
Date: Mon, 29 Jul 2024 22:39:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-selinux][PATCH 1/1] Add SELinux specific
 configuration snippet for busybox.
To: Joe MacDonald <joe@deserted.net>,
        Joe MacDonald <joe.macdonald@siemens.com>
Cc: "Weisser, Pascal" <pascal.weisser.ext@karlstorz.com>,
        yocto-patches@lists.yoctoproject.org
References: <20240624090200.1746755-1-pascal.weisser.ext@karlstorz.com>
 <20240624090200.1746755-2-pascal.weisser.ext@karlstorz.com>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <20240624090200.1746755-2-pascal.weisser.ext@karlstorz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SG2PR01CA0121.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::25) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|IA1PR11MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: 13a33240-a8db-4ed3-096f-08dcafdc3373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RS9kMTJ4RzlzS3o3Z0R2RloyaTZuNnozWHV2UjBMM2g2Z3BtdkJqY0pVZVFW?=
 =?utf-8?B?VUNOV044Uk5Uc0JTaGJqUnFmL3VONTFBWHY0YTNLL0xtblpycWhZNGp2OUZu?=
 =?utf-8?B?QzRZcDB3V3ErWkhJU0owb2k4VDRiTTBQN1cwVDV0bG96NjEzRGNzdjM1R3Ex?=
 =?utf-8?B?WUxpalVIQUNlL2tjdFUvVjJ2TlNvQW1wZ0UvSkxaVVpYVjhmdXdqZnRIbG5z?=
 =?utf-8?B?SkwzVnFKc0F6OWlOL3o4UFk2bmUvVHNhYWZQQ1ZLZlRHbWpwWkc3TU9xS2RC?=
 =?utf-8?B?UWRUT3F6QUlITnNBNytVc1dRMUNldlNuNTZJKzh2eXdXOE5TeW9XZnpFNkdr?=
 =?utf-8?B?cHVRMzdGUm95bmNPYThhUkFCRDQxaG85YjcyUEZDTDBiT2ZPOFFKZE5RSEVR?=
 =?utf-8?B?VDNhamNURGlEeVUrcFduMjFKc1pmSXA4eEhIRDhPRVFOd3FCeklzUGRvQ1Jn?=
 =?utf-8?B?c21nN2NSbG8vYWovUTd5OGFWaFZ3TmNWSmI1RUd4OVdaQ2xTc1d4UU9HZFpF?=
 =?utf-8?B?ajd4YmFWVmNKSXZIUDRIbnFCQ1ZlTXhETWpwMVk2YUMveGUzRm04djgvaXF6?=
 =?utf-8?B?dGc2TjFndXdDYVVHOTVqYm9wZmF1QWFNSGRycnpGc1BjenhyWWxRM0NLenVa?=
 =?utf-8?B?cDJ2R282Ni94Rmk1SDZndEI5Vm9SQlVHdjNPdTdyNHp2YkU0R2cxL2tWRmZZ?=
 =?utf-8?B?MXdiejlUQktRQk1qZVhaTjhDZWE2TlhENW80ejc5LytZazRhNTRNTDRpS2VS?=
 =?utf-8?B?UnNNK0J2Z1pFL3gvZGttZDdpR0JvZnZVV2F0ck9rQllPZzFLY0pSWVZpQ1pt?=
 =?utf-8?B?M20zL3F4RDBmYlNjanN5SXdQaGw0cDAwYWF2NTZxcitld1l3c1cvN093dHJi?=
 =?utf-8?B?QnFBSDgyUGFsYXMyY3NFYjZqWTVxSkR3QXFMdVV6L1FBcTE0VGxnQUZvTFlh?=
 =?utf-8?B?dnlHSU5rTWFvODFlVFhLMldFVTQzUWY3cmdSWTVhVUUraTI2MTBTVXdMM3Nm?=
 =?utf-8?B?aThONThoWnp1SmhMWWdHNkNrd1dBeWp1YlN1VFpNMW0xYVBUbTZONmNLRjZs?=
 =?utf-8?B?c211dFp5cU5UMjBxdVorTDkzNkFEbEpOeloyTHl4SzN3bkVkWFJubVFMbVl4?=
 =?utf-8?B?YTFERmMxdWpPcThRRWR4Q3JLTW03TDVZWVlMUnRCbHB0YWplS3oxeUtNWmVH?=
 =?utf-8?B?ckI1ZllrSGZhVlUwVitML2FBbXR0Z1p5SXhlb0dDL05Sb0FNbHRhS1hVWEJK?=
 =?utf-8?B?OU1FREoxTzhRbjdnRnR4QTVvZ1NOeEtlMVZVR3hNa1pFZTdmbmIzVUZ4UHBu?=
 =?utf-8?B?UUtmZHMycW1iVDRmeTRVekFObmFZY29KaXhqdzgyUkZZeGpxSEtINXFLOUJx?=
 =?utf-8?B?eVBHSjNNcGFKSFZwQTBYNXZLZTR2S25qaGZ4QncyR1J0NHBkWklhQVN5QXdS?=
 =?utf-8?B?MWJoOFp3RDBTWWtRWU9OSllxSU85STBoaFB6bFp5bVBlbjBQcVB1emk3NlI3?=
 =?utf-8?B?ZkcyRnVDYTF5WjI2QnlUdUxvOEdvdUJTeE9pZTBUTHdJb1JsV2dweXpUeHdC?=
 =?utf-8?B?Q3l0V1RoYWVkZmdWQlozQUtZY2RQNmdtQ0x1KzRLMW40dzFJdWE0cmE2bGRr?=
 =?utf-8?B?dGxjbnh1LzhaZEJNZFkyNzdWZVZYdEY4djBZbWRhTm1aWE1Gd24yUXdlR2pX?=
 =?utf-8?B?STNpZk1VZEdYYjNQeGlmaVgwVVoraUhlelVENTZLV0tZc2kwdEFkTVJudHNi?=
 =?utf-8?B?ZzJMMDByN1h3UTliZmR2Y1RvcXFLZThQb2I2aFRoUnhGenlXbkZLOEg5MHFj?=
 =?utf-8?B?L3pRc0VlWHg0L1RxNytRUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z1lkNjdIVzU1TGNnaXA3OFdCcUt0NlRzL2I4aVVodUc1U3JUYjNPTFh2SUxu?=
 =?utf-8?B?UXdkd1ROV3Y2VytxTnhkNXFmZG5WdUIwR21mblR5emFyY0NUUUx5VGlEbXdL?=
 =?utf-8?B?Q2xGSnJFL2prODUrYVBGQTJQZk9FNUdsd0hUS3dPNnVWR0J0Y0c2Y2V6akY2?=
 =?utf-8?B?bDgzSVVNUy9aUE41dS9VK2htQ1ppR05ZQlNNaEJjOW0wK3M4Q29mUGdHVUd2?=
 =?utf-8?B?Wm9WNnExQW55SjU4Q1J2eFZpMlBLZEdpaFc0N2FhcU4xSDhaaXdGSUU4UWI0?=
 =?utf-8?B?cVpqb2NlalB4b3FoWDVyWFVVbmpXWmt0TDJTUTNVeTdOc2Y2VDF0NTYraFcz?=
 =?utf-8?B?aExRN3d2Q0FKZFAxVnNqaldkNERtdVNaSGJzcHNzdDdUdGxFdCtiZ2pPT0JC?=
 =?utf-8?B?S1J3R0VYa3dYMml3cHVtMUJyQjhFZDM5MmE4N0lMWU1qSGliRS9wNytmbmk0?=
 =?utf-8?B?aGtCMzA0MFlNenhPeUIxT3dEaVZQWE5YcUs2TEU3RkRtMURaQndxbXpPcmti?=
 =?utf-8?B?UVJ2dmZZKysxZTdZd044d2FhWWM4UHpFM1c4TlRpUmtzK0RXeVNBRGFhTHlG?=
 =?utf-8?B?dnJWekY1Yyt1NGJ4TEtQQkljb0U3OVZXa1lacDBTVVJrL3R3VnN3ZnhkQnBz?=
 =?utf-8?B?UHErL0Q3TFZuNFYzM2ZSZ0N2U2MzWmZMeEhpRStsWGZTRU9OT2NUSUtDaWI0?=
 =?utf-8?B?bWFTQSsyZ0tJSHY1elVPRlVXd2piK2xuYTE3dG94K2F2WHczUU5UY2xMT3dC?=
 =?utf-8?B?dTEvekcvL0JGbHA2Um0vb09pdU9pVlVmbURiUUZJdkFIN2tvR0lPbmxaWUMx?=
 =?utf-8?B?YUhIUlE1SG5ZSExZU2xkUGMvcEptKzdhSzlDNlN5MlRqTjZkYzZENDNFZTRr?=
 =?utf-8?B?cWxiaWU3NFdDbGt4NnZ3WmgyckVFdlY0elQ4ZUxydnhQSUNDNXlEeE9wNDRh?=
 =?utf-8?B?Z05xZkJwSWVvSXpCMjBncHBseWRVNHg3WTI1cFdXcGl0aXlRL294TGJMakRG?=
 =?utf-8?B?eHVEL2Z2TVhJL2dBR0Q0bU9LYUQwV2Z2NGM2Y25raUVkdUxrNmgvUjAvOFlr?=
 =?utf-8?B?R1BKUHZoMm9EU2dDY2d0WHFXTWhqQkt1bWZLTFo5YVFTMnBhWURleDBVdHBn?=
 =?utf-8?B?Snd6YSszSmt5Y1VQUUQyVVIyeEt2djhNbmJBNjVSMGxJcWZpL0U0V3R1bzk3?=
 =?utf-8?B?RjBRUUpTaE9aYlJFRzVNUkZ3dTdNa2thTXJBSzZqV0FWUXZkVGRyZTdJQ25M?=
 =?utf-8?B?VWdVSjFranNBTWtyMWFHL3JoNHRSOHh5ZkdEbFVBQ2R5TlJneTJPWFFiK2x2?=
 =?utf-8?B?L2VTNlNLTmphb2h5TThrcXZlYkNWdUNFY1FldVVmS0tsZE9neUx6Mjd6d05y?=
 =?utf-8?B?L09ubXZrZ3dVdEUraUV5UzZ5YjBzMkhnYXh2Rm1qWmdXMUdwaVVLaHZiMWYz?=
 =?utf-8?B?UFh5bVZKOGVwL3Q3d2RGWjBLZlpwWERIZVJwc2xUOUw3MTBmQ2JaL0NadUZP?=
 =?utf-8?B?WGhKL1dwVEhOQXMySGhSVHYvOElYL1IzaUVvbDhDcmI2Q0dBMXI4V08xYWsz?=
 =?utf-8?B?WFZOVE02VFJ5NlM0djNzZ2hOM3ZlNHNaUzZwY3JkRVFFdjd3RGZtQmFybGtr?=
 =?utf-8?B?bHZJYVRYYjNHK25EZ0YwZkh2QndDb25CL0FNV0xVckxob3lTV2picEZZWVli?=
 =?utf-8?B?bFNldVhmY1lsdi8waEN3aVo5Z1lPTUpWcHpCb1VPZk5EMXQxMUEwUGRHRzVv?=
 =?utf-8?B?RFE1ZTlVaS9kZXd5UGZpUlcxelY2STg0cllqNVZmeGxaendDNWdEd3UyNktB?=
 =?utf-8?B?T0RDSml5eUJSdEFGY1NDdGsrZm4wL1RDVmRGdDU2RzRRYytnaXowenM5MDNE?=
 =?utf-8?B?M1F3ZFpRMDZsVllXVWJ3Q0hrbUNta1psZFdCb0pEeTNEL1EvRXd3UlNvN2Z6?=
 =?utf-8?B?RkhjWDVpNy9EanpRSWpDc0VkcXFyRVEvaERGM0s0eTlIWWFjcDJRRkZaQlhj?=
 =?utf-8?B?c3dBY1M5N1ZIL0I2RDFwSFNZdUU0TTF4TktraTQzeEY5bzJyRDdrcjIrbWdv?=
 =?utf-8?B?QXU5WE9SbmdEMFFsRklwMFRYdFZxZVZlMEpPTUZzclZIT1hSV2wxOUFtZnUr?=
 =?utf-8?Q?1cYCk3uoRODeEnM7tq8evmixh?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a33240-a8db-4ed3-096f-08dcafdc3373
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 14:39:07.4268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsudW0ynbRjEYrn1s0PUYacwaeJCNtEDll6s7kZoWYNuV927TZ547lZBfR9cER+UQfYMzgsgDeCsSVJEyNFRuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7942
X-Proofpoint-GUID: CLgpHhW6yZZNnsrtAeRXvZAGVVHfsav4
X-Proofpoint-ORIG-GUID: CLgpHhW6yZZNnsrtAeRXvZAGVVHfsav4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_12,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=973
 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2407290098
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 46TChGPr009010
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jul 2024 14:39:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/495

Hi Joe,


Would you please merge this patch into meta-selinux=C2=A0 layer ?


Thanks,

Yi


On 6/24/24 17:02, Weisser, Pascal.ext via lists.yoctoproject.org wrote:
> This patch adds a SELinux specific configuration snippet for busybox to
> enable SELinux support in busybox out of the box. This is needed to ena=
ble
> SELinux specific command line options for certain commands like ps -Z.
>
> Signed-off-by: "Weisser, Pascal" <pascal.weisser.ext@karlstorz.com>
> ---
>   recipes-core/busybox/busybox_selinux.inc | 6 ++++++
>   recipes-core/busybox/files/selinux.cfg   | 1 +
>   2 files changed, 7 insertions(+)
>   create mode 100644 recipes-core/busybox/files/selinux.cfg
>
> diff --git a/recipes-core/busybox/busybox_selinux.inc b/recipes-core/bu=
sybox/busybox_selinux.inc
> index 740980f..ade30cf 100644
> --- a/recipes-core/busybox/busybox_selinux.inc
> +++ b/recipes-core/busybox/busybox_selinux.inc
> @@ -1,3 +1,9 @@
> +FILESEXTRAPATHS:prepend :=3D "${THISDIR}/files:"
> +
> +SRC_URI:append =3D " file://selinux.cfg"
> +
> +DEPENDS:append  =3D " libselinux"
> +
>   PTEST_BINDIR =3D "0"
>  =20
>   FILES:${PN} +=3D "${libdir}/${PN}"
> diff --git a/recipes-core/busybox/files/selinux.cfg b/recipes-core/busy=
box/files/selinux.cfg
> new file mode 100644
> index 0000000..00aeb51
> --- /dev/null
> +++ b/recipes-core/busybox/files/selinux.cfg
> @@ -0,0 +1 @@
> +CONFIG_SELINUX=3Dy

