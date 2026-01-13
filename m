Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1257D29DC3
	for <webhook@archiver.kernel.org>; Tue, 13 Jan 2026 02:57:08 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.51021.1768273022263597291
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 12 Jan 2026 18:57:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=J7G9aEQt;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=5473251d22=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D010gu3996799;
	Tue, 13 Jan 2026 02:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=wlo5rz2UtCGk9LxgrO3I06XisMKK5XRJppMp433q7+U=; b=J7G9aEQts4h8
	9Y0l3Rn8bhW8Nv1IeLkS5CqeFcNIKSlrLEo9isDFde7F7W8hT5XQBK1xkgmI1b5U
	yCg/l09yUwCzRG+QfLkZd8Wa0mT66CfvC93JF8Grx4EKI58AhnpZvqm5eOo/yeM5
	kp+1aMH+Rhw/p6JcgeL+I5UX5TNOnRUaPQLmqNVktx2TUAegPWHNW/9mk0Fd6IPe
	OSKdf71B88BwtIAbsR2GlnmZKoqGNosjK33dq1oomEBE/KGjFa0FGX8epd4PigA9
	Y5LFO2yd8dRL/IFgSNbG3D90ea/RPr45tZPqTSaKIBX5A9YlZTS/ehi7lKA1mgN7
	31PmAf3nJw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012016.outbound.protection.outlook.com [40.93.195.16])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4bkdr2jhu7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 02:57:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGP62WmNDQNb21zTGO+RK8pLozFjCB9X8pJnSaWQ5S77+AxJI3VqO4NnbSbAJB14OEOJej983IZoiw94ImeuZTAcw8vf9hGylO6UAiEWjTcil7tr+iYLcq8mI7UyXAiRut5CHyGjZB1zfpbVn7D0JiGmM3kk0uZwUjMMoIILuKdWBfi3+XKYVNpY1afFA1XWDDx2kH9J3FUmtvD+RdvSNGGIskI+JzgghjvEImFincjVlBLpNwe0hVIKMOjiVaLurn09KcXZl5jh5ZboaB/+41o8aTABD1glq2psNxZ3AIx8ylg0smpdt69z96KyxQRB2WIg9dCByeST2yZADI0srg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlo5rz2UtCGk9LxgrO3I06XisMKK5XRJppMp433q7+U=;
 b=m17bOn/aIsFR9muye6863tm5NT8eB5DPdoJnP/In5qAGKjOvPZhRl5y4QQLHifBi1zcGmXVppET7XckUvtZrja2AzNLFgVLVinbkmOkAm4Jtkj2PJkSejT9JANI+T6AJvrvO4JCZrqOtfmrhEAwyozK48BpQI7zNL8BFmHBtBsjRJIsJCn3mg4o3Z998d4vHFIIIKWzxLtKCXt+8mAVKni+kNwnSBLWl+MBxAsba4S77Y3/Bs5jzntR3Ixzz1mZpI5ieZsFGHCgiaD8VTiysx1Um8+CB/gYTFWE4GooLV2GRM4Uyce3KCOBmYGlS8VvIpkHwTuVW/rIIXPIzGvKrIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA1PR11MB6396.namprd11.prod.outlook.com (2603:10b6:208:3ab::10)
 by MW3PR11MB4682.namprd11.prod.outlook.com (2603:10b6:303:2e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 02:56:58 +0000
Received: from IA1PR11MB6396.namprd11.prod.outlook.com
 ([fe80::73cc:6f62:3c66:cef4]) by IA1PR11MB6396.namprd11.prod.outlook.com
 ([fe80::73cc:6f62:3c66:cef4%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 02:56:58 +0000
Message-ID: <e89071f4-e33a-41a9-b271-5ea7bdd49259@windriver.com>
Date: Tue, 13 Jan 2026 10:56:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-selinux,PATCH/V2] systemd: remove creation
 of backlight directory during build
To: yocto-patches@lists.yoctoproject.org,
        Jaihind Yadav <quic_jaihindy@quicinc.com>
References: <20260112053258.3630191-1-quic_jaihindy@quicinc.com>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <20260112053258.3630191-1-quic_jaihindy@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0324.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::12) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6396:EE_|MW3PR11MB4682:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b7cca4-2d90-4112-be05-08de524f6991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|4022899009|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MGRRdDhKN3ExYm1MVTVKcXRRVUovb1NaM0pLcitmY05aaEF1TS9qYUxZTzlY?=
 =?utf-8?B?ME5pSUR3OUhFOXJOeEt4c1RabEUrZEk0WWt1cEhHWXh5UEYyOU5xZ2RISEhZ?=
 =?utf-8?B?ZCtWODJUQ0ZIR3BEblhEblVXNUJac0V0dWsvTHJXNUlmeFdtbXJ6ckY1OVhE?=
 =?utf-8?B?cVFDNUNaZm11bTJpakpITVpPTGVwUTZ3SGZpUkY4TW5reTNuYVVEVGlsRkJM?=
 =?utf-8?B?bkpUWHIxem1yQk0zUHp6bklaU3RoMWM5VHJYbVp2WitmTjdVWWRhbTJLMzgz?=
 =?utf-8?B?SWRPOFhFSmdPZ1NtdGJlRSt0QklkZ0xYa0dmY0tZYkxPQ0YzN1htOUNKRXJl?=
 =?utf-8?B?Z0hFQ1UzT3VOSzBZZGNMMDh4eHBsS3BDd3VoWURJeUxvMHNOenBYdTdlbUNS?=
 =?utf-8?B?MHFNZTdYRFJubkVGSHpJZms3Vmk2Y3QvRktzdnRuSWZyQmFIU3p3U0xLaHo0?=
 =?utf-8?B?cTlDeEpsOVcvc1pzcWFMYUZLNyt2Q3ZjSUJ3d1gyTDlvK0NJb3NtUmFHaUhF?=
 =?utf-8?B?NTFFTFVKMGtCNGVIR2RKMjZ3OFlzOWoyaVZlS2lCSXUxMFUzUjRyZnllamov?=
 =?utf-8?B?SnV1N3diTDJIbXJMNUVMbXBjc1M1UkdPeWRJM1pZMFdtOTFFejlTcVpXSE9M?=
 =?utf-8?B?SkNTcE13dkN5VmdFb2FtR3BaaXN4TlNiVmtRQnNMVmgvOWJyVzJyckVFTUhi?=
 =?utf-8?B?SndOV1dmWGJyZTd3bmkxV1pBaFE0SWJCbUIwSW5zWjJqRU92bVRrcjlGTWMr?=
 =?utf-8?B?Ylo1dGtTOHJpNDZRZG9wUkc1Q1U0bTR6NHNxR2dNMStvdnM2dTNZWmJORXoy?=
 =?utf-8?B?ck9BRWtmMS9NMlNPRnFHVVZHRFhUb2lhN0kvczVHc1kwdmFSR1BBeWpiSTNQ?=
 =?utf-8?B?OUgvL1RMZi9yckU1ZXJtdE94QjNGVUFtQVZsVGNmQ0J2aGI3alU0OHJteEFL?=
 =?utf-8?B?eU9uQTA1TWlsckxNbXVoeGJnMnFGdkZlbXRWTkVBZlViL0NOR1BmUFdMdFdX?=
 =?utf-8?B?bkpaREZ1Zm0yYWptcFFhdzZQS0FmYUlwYStBRWEreWNpN1NvaHpDdHMyU3FB?=
 =?utf-8?B?MUdUVDBMRGUxd1dCYzIybEJucEgyYXJoMUpCQld4SEwzTllRa1pvZHo0dmJ3?=
 =?utf-8?B?M3g5SWs5aDZoWmkyQ1FSY051N3NjYXE5UWRoVHp4NEJUWWpTemZGNlFmT1Z4?=
 =?utf-8?B?MXZJOUNFWXdSTWNKNytrUVduWGFLU0ZMZ2tsRkc0RGFHbG1SQXF3Vno4VFFF?=
 =?utf-8?B?b2VRT1F4amNBMmpYOHlQdVJsaEI4cEppcDFuL1ZrcFJaZUxibTAraGszUFht?=
 =?utf-8?B?Tk9nRkFwRmlERHR3aFNGc0doa2RQSDlpS3pVSXZYbzVtZTdFUDUzZEZkRERN?=
 =?utf-8?B?c0poTTNoRGhPaWFLZ21Ic01iOTNQWHcwbi9rc0syV3VkTVI3SHRja3pxekFs?=
 =?utf-8?B?OEdEVUZCSklLbFJVUnlmb1lGZjNKWEMzbnZnVVB3ZC9LWE5jMWMzamU2N3d6?=
 =?utf-8?B?aG1XV0oxdTdwM0NKdXBTdTU2SkRaWC8rNThseUlVNjBTeWprN3RQU0x5QUR0?=
 =?utf-8?B?WThRMVVOU1F3SVpuWlkzWjJVOXM4M3FRRVZkcUdCNllSMVlRaXBDZjVUSUtp?=
 =?utf-8?B?MWd1S242cnpUQzM4bC9CQ25XZUY4ejhWQ2hvQjlIeHE0VWFyUzFwOUZOVmM0?=
 =?utf-8?B?NHVpdnpnSUM5NDF0RFc5MHluWDNlWld2VGlLOXNaRnRFa3JjRThjT1lubUhv?=
 =?utf-8?B?QW9DRmxFZ2k3Z2ZhcnU0b2JoblA2MlpGUHpaT1VqNS9pRGlFbm5UWTkxc0JQ?=
 =?utf-8?B?M1p3M21MRDNIcFZ6ZXUxT2h3VWZMSGRPVUFaSFVvL2hTZXUxR2V0THl6VHAy?=
 =?utf-8?B?UDkwVW8xUDQ1YVpGNHI0Z09WUkc3R2xudXk2S2IwMHdhb1h2aFoyR2JuQ2xQ?=
 =?utf-8?B?VGJwQlFacEY0UkU3YU5wWFF6TGltQUNLZllIMllsUkc2RSs2bi9BbGdqRTJI?=
 =?utf-8?B?S2kvRHBNcGV3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6396.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(4022899009)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ODF6T1BkNGx2dzQ3dzhybXM4engzRlMra0plWFY3MzdsWElCRFhTTVBrckpG?=
 =?utf-8?B?NUE3K2w1cksranVEUHp5OGI3cjd2a0JJTlVDQzFGMVk0SVU5S2tFem5KVEZY?=
 =?utf-8?B?MVBkTXlNZlFCL0d3aWhRZ1lVZ2s0VFdTNm5YMS9nZEVVRStvK240d3NNZ0RI?=
 =?utf-8?B?NmR4UGJKRFZtSVhseHNQbWc5eVZzL0pGOXI5RmttZy9vN1JUaHhGcmpmME5i?=
 =?utf-8?B?VW16bzczT0REY0lQbWNpUW1QNnZxVjVSbmhkTFJOMk1oMEZZTGFRS1JieUFm?=
 =?utf-8?B?VUUrMnNOcUdsZ0dWeE56Y25rQjdva2FKZ2pjMnk3aldJMW5NelRCTFIyWmpO?=
 =?utf-8?B?VU9RUXM3TWtnUUZPRzhlTmtZMFB3SWMza1NwY1o4M2s0YndlWHhxSGFqNEZv?=
 =?utf-8?B?bTNyeW9EdHBvb3JtelVLeVZIVU9sdFNRVmM1aVVIWmI4MUxJYXQwSEhuV1k3?=
 =?utf-8?B?TUk5a25XWk9veWxBeXlmS2RFZ3JtYTA1YVljRTE2eHZISVlpRGdMT2VZcFF5?=
 =?utf-8?B?bUV0Q2VTMkpHc0lXMmNoTjNKWjZLaENWaFVJTlRCUXlGdVUxb3B3RWI2Vkts?=
 =?utf-8?B?R1AvWnloOEJhWTkyRlNHRlhlaHFvbmhCM2g2R0lqREVqVFhGemJpZCtXWUpW?=
 =?utf-8?B?VHFTYnJqNkdFejcrR0l0MjBYUUpERjlxNGpnSFYweE9Cd28wTlVFMTZzb3Fw?=
 =?utf-8?B?VHl4YjV6SE9pRTlHaU1mOUtjUTBvQ1ZBR1BVRkRRYVo5Nk0wTCtkTXdMYmJQ?=
 =?utf-8?B?Qno0ZGlWWGc4THB4ZjVpL3l3aFVWWTBCQjBSbUp0SmVFMExuQWlSVlBVcUdm?=
 =?utf-8?B?WlFUN2x4NlpzeUFtRmpXL1hGeUkybTM5M1VXZ3BGTVg4R3NuVHlza2tQMkJo?=
 =?utf-8?B?OElKeFBmdi9GaktxVGVsWG5naExnR1ZsUWJScFcydEgzREhScERLRlc1NW01?=
 =?utf-8?B?cGkzYWVuRENKaUZUTkkrUzFyTGVseHgvYzNZZWxJM0NDN0lWQmxXUDB1b0J5?=
 =?utf-8?B?SkRkZkNMbTE4dUEzWTdnQWk2WThjTFFzb0RsNGwvSHYvK1RPMXF4WTIvQ2FP?=
 =?utf-8?B?SUV0TUlzcFZ6VE1pSXNsSFpmdFE3VWxsYlFxMjlYUUEwZGxUczlRUWphYnNm?=
 =?utf-8?B?VGV5aG1FRjlXdzRMOFpjSmJMdm9WR2kxWDNUcVJBTjdpU1IxWERCRzUxQk5J?=
 =?utf-8?B?RzB2aERnc2ZlaVRrZGZGcWZoK24wNnNVRCtmcElFSWZPM2x4SHh1NHNEQTM5?=
 =?utf-8?B?dm9adW9kWHNHUXY0bHJZaVl1UkZ5TElwc0FaUjJ1RkdpUHNtUXVHYk5MS3dY?=
 =?utf-8?B?TlE4R2ZXald6R3dsVUxsUHJCbi8zZjNSMTNPemIrcTRxa3VJM3pXaUZ3bGht?=
 =?utf-8?B?SkJmeXVzM2pKV24vSHdpM0xwWGcwcjlWcWJZT0N4VzN1Q1h4WVJJQWZYN2Jz?=
 =?utf-8?B?VDdkU3A4MFpCcEQvUFZBeDNmQmZWd05aQjJCeDFyWGNYenYyb3ZZUW9wNkVP?=
 =?utf-8?B?UG9iMUk4dEpjb3ZIUnpwcDJCeTBvNjJRRU1WVS9kUjhEaStiWGFLWm50YlRD?=
 =?utf-8?B?NEpEOFpUR0tQUkEzSFpkUXk0bWsvblVkWmFNUDd4UDRZTXp0VFhJbVlaYXBM?=
 =?utf-8?B?UkdCUm9wQVZPZzJFZGVpYU03YmZ2Qm9McUNJc3N4eVNXbkdEazJjVCtTd1BH?=
 =?utf-8?B?RU4wZm92Q0xJRmJKL2RSY2RkamgvNkVLMVJnQXZpdlZoYjVYM05EM2xCdWFY?=
 =?utf-8?B?Vndsa3dDYm5nOXRqUDZTT2gxemxWb0JFb1RIc1czOXEwVVdhdDFkNFNMTEw3?=
 =?utf-8?B?MkNadVlSR2tRYXJsem9KOE9GcUZmMWo2aERlcTNwSjlYd01KdnpaM0V5dml1?=
 =?utf-8?B?QU1SK1JSMHNnSWZyT2orcTAyd1VwMWhlWC95aDJkSkxOVWp4Y0xRbFVCUXRa?=
 =?utf-8?B?eFJzOGE0RkhmbnBQQXhPWWF1dVpwOGYxRUNZR1l5eFBJV0d3d3Vtb0o0NG54?=
 =?utf-8?B?WkhwbHhDQno5S0YrMkQrTkJoK0NxU2R3cEp5YkFWYlBFRXdrNU9SR2pER01V?=
 =?utf-8?B?TDExT1JHa0dQNzRVVWZQdTlYbGcySVk2VVVSRFcwOWZnSXJWUHVIMkVtZGly?=
 =?utf-8?B?R1JPMDFKUlNUK3BiaTVTbVpmUzM5d01jN1ZhYTlVak5FMUFBb1JXMnlBYkVk?=
 =?utf-8?B?a29pUTB1ZUpRWkxsaTk4dkY2SU1SUEhaWFczcnNadG9uQlpsOU1aZFhOV3Bp?=
 =?utf-8?B?UGZsaUtxakx2OHZPNlFqQVlEWUJ3ODFpZnEwZFliRkozQ25udHdTTy9CMEo5?=
 =?utf-8?B?RHBCcGFEbFMwbTQvZXJNZ0JrUjcrZlFyS09OT2VmaGJCdjZDZWpyQT09?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b7cca4-2d90-4112-be05-08de524f6991
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 02:56:57.7049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rr65QyQc18aRTIh53Iu2xwqdi6ku6W/K35iOjedoN4KG2YRTh8seYF1nboL8mJF8lo1vVEu+jReXS478L2pOlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4682
X-Proofpoint-ORIG-GUID: F0PmurnuNYXqSXc323CDY763AdjR4LmU
X-Authority-Analysis: v=2.4 cv=fLo0HJae c=1 sm=1 tr=0 ts=6965b47d cx=c_pps
 a=eebb4ZtE0r8msBY2xobl+w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iGHA9ds3AAAA:8 a=COk6AnOGAAAA:8 a=t7CeM3EgAAAA:8
 a=1VXCtZ5oiIZticidm-0A:9 a=QEXdDO2ut3YA:10 a=tOIqXpxfQm4A:10
 a=nM-MV4yxpKKO9kiQg6Ot:22 a=TjNXssC_j7lpFel5tvFf:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: F0PmurnuNYXqSXc323CDY763AdjR4LmU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDAyMyBTYWx0ZWRfXy+6RhzflLcDx
 NvJtWuHgJFeDfLeSFoUX3i5lPpRsrti9tqkK4AH4q3lGiPoPHbLZFuJOA217AqLaQEts8xeHzXv
 uvCYWqzPlUZvuPSSV0+XH7294HhwY4uhwe0ujd+1qmld14GpujXjiCbKp6LbnMrcn/rqF5inBGz
 hdhxG/Gnbz2A3g+05CNxKTGen2eR/XKTzOQOX54pev7CzhAGsEjOmvFA71mceCas0HvgmeaXrL5
 JKq53rk6BmzOD2HasjoGl6s/GCwqE5/FAtbfhx+ICFVKZsEmUzscor9EJUi1QDO2x1RpHhdBXoC
 Cl8koHL3Xm8ElvKx0TLBsfFY1TbOuOyVAEvzOGMH72lIf6+oW43N7JLp98nf15yZbI9AfoL/gnt
 si39ugGvJlx5AbuusHBOjCHoqsjFLcBw3O6rj49WOk63WrpQOUAFhzTm+Te9nF32kfb1Dmml4M7
 T0piKhWVQymPiAhmU5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_07,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601130023
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 13 Jan 2026 02:57:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2948

Merged. Thanks.


//Yi


On 1/12/26 13:32, quic_jaihindy via lists.yoctoproject.org wrote:
> From: Jaihind Yadav <quic_jaihindy@quicinc.com>
>
> The recipe previously created ${localstatedir}/lib/systemd/backlight at
> build time when PACKAGECONFIG included 'backlight'.I Tested it on myboard
> and can see directory is correctly labeled by SELinux at runtime and the backlight
> service starts successfully without this step. Removing it simplifies
> the install process.
>
> Example SELinux labeling:
> ls -laZ /var/lib/systemd/
> drwxr-xr-x.  2 root root system_u:object_r:systemd_backlight_var_lib_t:s0 backlight
>
> Reference:
> Previous discussion and initial change:
> https://docs.yoctoproject.org/pipermail/yocto/2018-April/040854.html
>
> Signed-off-by: Jaihind Yadav <quic_jaihindy@quicinc.com>
> ---
>   recipes-core/systemd/systemd_%.bbappend  | 2 +-
>   recipes-core/systemd/systemd_selinux.inc | 7 -------
>   2 files changed, 1 insertion(+), 8 deletions(-)
>   delete mode 100644 recipes-core/systemd/systemd_selinux.inc
>
> diff --git a/recipes-core/systemd/systemd_%.bbappend b/recipes-core/systemd/systemd_%.bbappend
> index 7719d3b..7c3a686 100644
> --- a/recipes-core/systemd/systemd_%.bbappend
> +++ b/recipes-core/systemd/systemd_%.bbappend
> @@ -1 +1 @@
> -require ${@bb.utils.contains('DISTRO_FEATURES', 'selinux', '${BPN}_selinux.inc', '', d)}
> +inherit ${@bb.utils.contains('DISTRO_FEATURES', 'selinux', 'enable-selinux enable-audit', '', d)}
> diff --git a/recipes-core/systemd/systemd_selinux.inc b/recipes-core/systemd/systemd_selinux.inc
> deleted file mode 100644
> index 7d466ee..0000000
> --- a/recipes-core/systemd/systemd_selinux.inc
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -inherit enable-selinux enable-audit
> -
> -do_install:append() {
> -	if ${@bb.utils.contains('PACKAGECONFIG', 'backlight', 'true', 'false', d)}; then
> -		install -d ${D}${localstatedir}/lib/systemd/backlight
> -	fi
> -}
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2942): https://lists.yoctoproject.org/g/yocto-patches/message/2942
> Mute This Topic: https://lists.yoctoproject.org/mt/117219553/7283133
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13170635/7283133/1683771902/xyzzy [yi.zhao@eng.windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

