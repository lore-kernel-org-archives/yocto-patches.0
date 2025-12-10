Return-Path: <kai.kang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6882FD3B9A9
	for <webhook@archiver.kernel.org>; Wed, 10 Dec 2025 07:01:00 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9770.1765350053831878134
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Dec 2025 23:00:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=ZQUIZvio;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=4439c25f58=kai.kang@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BA45uE91198311
	for <yocto-patches@lists.yoctoproject.org>; Tue, 9 Dec 2025 23:00:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=cb79MbFBWw09DfIt9t8hI618VQv0Kp/QRNj2+NAOEdA=; b=ZQUIZvio0H8a
	ZYTsOzt6lp8E+ZPngcpZtfrLjIZ+VuGH1RgLew+C1AuXNtQFoBYen72ivKqVhDFr
	2gfDp6BjaARXL1gfkycRU3VdPbsi14iGIypaqIslMCV2nH6jxnfW2zJZofamfAqY
	16HbT45So3hEF5w/epZEBdtuVKg2cDDf5jfJ80DT+PYAT5oa/2aOVE5d2n70Lxua
	TUBmDBdmBizE0Q1h+KJieGrIv8B3Gkl6Wx9snqjsS4fZSSzF3LMdRt4SjZPWYTI+
	WUUSNwjAjuch3/pH2tqiSlJ1VvccmsxQ9jenmKKIvIMpkzP9WJk1btKrXdO8URsK
	vwLzdsbA6A==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ay07u06vd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Dec 2025 23:00:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YhUuJbIMXdpPzk55KDN0rckgSbqfWU1kogjW7E9LgiaaoSgeePEOSirTaWCZ02/PQLKIZs+5inkUpo7Kkdm4KSLDWGtcGfMGT3FXThHtQZvLpy72b61MJGrX8A/AYnjULT/vGxwrbAlZjWjjikHyo5i8qZFotKsgMNkBMiGsPqLmxakEOGuBsACHnT7rqDdzdH9vVH4lrPT6b2XMj2AsTNzUDHMeCl+nFmhWAy6MvAv/AuKPWGvHjm4L4ktdnR+C7Jmxyq6rNmSybELVmvJFqvNyP7spXDANW0BvD9PLeq9OUKPKvTabvcelnQiEnh1gPZxnOgctv/221t+8YaOdgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cb79MbFBWw09DfIt9t8hI618VQv0Kp/QRNj2+NAOEdA=;
 b=gekbN2D6uLP+M3sApltuLYyvBPuBjPmZKNKHA/to/fWNL04j18ZgOSow6qJEFNyynKWyFPXoG0yEkx0r5pOUEPfVmua3YWhwyrEBc2kltc0dMZJwkTzeTbw4CQZPBNxAXw9INuJQJgxqyLiPAm2JkwEnfpIxZDBlDssSHW6O78UVC++bYDRt63yiGrGKnJnZxIcz8jVxnucwvwjV5Ctl3M4Vuwoj0d5Hw1D0yBucLAJmOAHso75E0FuDTKHfh+pbwzCfLIrIQZV/bRjY/cvM8tTfXgEb7CG07MWayvLC+B0hqUmUzu50u/Ubj0IaXgoURzVmymjta/6BPYR8rWA3Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB4904.namprd11.prod.outlook.com (2603:10b6:510:40::10)
 by IA1PR11MB6443.namprd11.prod.outlook.com (2603:10b6:208:3a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 07:00:50 +0000
Received: from PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::c7ea:ab4f:35f9:9b07]) by PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::c7ea:ab4f:35f9:9b07%2]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 07:00:49 +0000
Message-ID: <75815e1b-7d08-4981-b596-91e008cd2e24@windriver.com>
Date: Wed, 10 Dec 2025 15:00:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-anaconda][PATCH] systemd-serialgetty.bbappend: fix S
 setting in case of anaconda
To: Qi.Chen@windriver.com, yocto-patches@lists.yoctoproject.org
References: <20251209064855.543981-1-Qi.Chen@windriver.com>
Content-Language: en-US
From: Kai <kai.kang@windriver.com>
In-Reply-To: <20251209064855.543981-1-Qi.Chen@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0105.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::15) To PH0PR11MB4904.namprd11.prod.outlook.com
 (2603:10b6:510:40::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4904:EE_|IA1PR11MB6443:EE_
X-MS-Office365-Filtering-Correlation-Id: 37343f6b-f941-4708-140e-08de37b9d9d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|42112799006;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZmxrRTZ0M3htL29YOE01WEZjWUVHR3dYS2R4elpsRjNUVXNReFUwQk5HNytM?=
 =?utf-8?B?eUlYdzRDRXM4M21zTW9oVHlYSmNZbFhBa0h1UXo3REpXejh4TmF4STNhcWRv?=
 =?utf-8?B?NnNrZG5oaUtCTnVyQ1lQMlNnQUpQYUYxQUE3OC9La3BSS0hRb2wwd25CVVlB?=
 =?utf-8?B?MWJRTDd4SDZxejlVNFordEVZNGRyNkpDbXIzQVJyMmlBamRCRUtkMVpjd0Rx?=
 =?utf-8?B?alg0M2pxUG8vZzNUZlNqTjFxekxkY1NwQlJ6MDRrTFlYYlk3cFUvcGJ2Wld3?=
 =?utf-8?B?cXNBbnNSZGVsUUtLNkNzajJIVGQ1STh5Y2p3WFdFWlZqNi9pOHhadlF1cUdP?=
 =?utf-8?B?ZGM2bGN5NEgrR3lTUlc1L0dIcFF3OXVuZjVOQXlqYytuK0tQL0d3MDQ5dG4w?=
 =?utf-8?B?UTh5YXVnOFF3SlkrNWY1NWxwUVc5bFRsS0x4OWlWSzhXRTBqdGE0bEVnZW81?=
 =?utf-8?B?MkdmcTN5LzJCaHE2VFNrZGgrd1FmakhMTlNrcnYzT1dQN2RiZVlJOGwvZlFH?=
 =?utf-8?B?QXc3d0lzMDJCM09NcFZ5Nlg0b3ZTOVpoTnl3cS95SWh3Y1ZNL0huTFc4algz?=
 =?utf-8?B?aFJVdmduUnBVNDd4TGdvNDNGWFE0NVIxSXNFTU1xTzdmTXdwV0o5ZEhjRVhx?=
 =?utf-8?B?Zmhvejk2MEJVNmROREJLemxqTE5mclZUbGVUNTB1TUpDbDMwVDJRTjVOZ3py?=
 =?utf-8?B?bm9KNHVUSko3cDRVK3pZMW9DWWlZd0E2cW9xN3N2NDB6bFRhcnBtRmUydWwy?=
 =?utf-8?B?OHVBMUl2MVczckY1SU9WaXZ0UFlGN1A3MDhKRTR3OHBZcEZMSFU4U3c3UU5x?=
 =?utf-8?B?UG5tWHlLZWVic0FHbG1yQ29idnZDL2Z5WXduWG02elNIWXljNnhWaEtiUXd0?=
 =?utf-8?B?cjFwSFJnUnNFWk9sZy9yU2F2VTVxVjg0Vnd5U2VoQzBIS2F2R3ZZWjRyM2tI?=
 =?utf-8?B?VVhtZlBSMDZXL2h6ajlYUklZR285WUVmR1ZUeWRrTGFTVUt0dG5CSlVsb3pw?=
 =?utf-8?B?VFpTN3pSdlhRWjkxNWtHUWtGRmltTU5UbDN3dE0xZGxjZ2h1VWc2WmtuNnkz?=
 =?utf-8?B?cnl1dWlkZ2ZUWEZIRDJIU3gzYUIrWWdJeXVOM1hYb3FjNENoM3VPeUREdTdk?=
 =?utf-8?B?RnN0cExycnJROXhla29MMFZWaWpUVHB6SElxb0RyVjIrYUhFQ2x5NUxETmgx?=
 =?utf-8?B?ZGR5NXdRWVpzZ3d2Z0Y3Qnh6eTVUVXZNdVhjWGdLMzZxb3NFN0daV0IvRjJO?=
 =?utf-8?B?czAyQ0cyeU9oT2pkNkdkbWRZY0U5R1ZZQ0kvdU42b3hEc3VSZ25qWWdMbDRh?=
 =?utf-8?B?N084VHZEY21EaU01NTViVXJOaTBSek8rM2svWVpOWm1EK1hoYUh0TUpGaXUw?=
 =?utf-8?B?RTdOcGl6S2U4SmxQcTBuWGdXMUtMeWZKNFFTSEoxU0Frc1BJSzZJN3ZkdlI0?=
 =?utf-8?B?NGhLSG9hK3RJYjZTRThPM2JuSGF2VEQ1ZFRLcUw4MSs4bFV3SGZ3MnFwTXlC?=
 =?utf-8?B?Y1p2eGJJeHdQMm9mRWlnTnFXanFldzVSRGMxbVFFZ1ZSMDJ4cnRZZ0laWnBv?=
 =?utf-8?B?TmhhUVlZYktYL2QxQ0ZuRmlvS1UrL3FielNuRjJ5bzMyVG1xMzVlUTZIYk1M?=
 =?utf-8?B?NENtVTkvTXFjZEl1R3ZoeEhqQldKdHJ6dk1OWlFoaEIvbnFIbHJYcUtrMkt2?=
 =?utf-8?B?QVkzNGU4NnFONHNkcWhkYXJmNFlYeUVhbHAwUkp5QjlvVTFVaHNsbU1leERp?=
 =?utf-8?B?aENaQTN2ZHdlc2pPSzIrZWlQWmk4enlFWGNKeGVIaHJQazY3RmdSR3VFUlhG?=
 =?utf-8?B?Zy9NZHVRbHhFT1RTSzA5QUpkZFZ2bElQTVFzaU84bXRhNFpDMjdzR0xzQm1y?=
 =?utf-8?B?NktxOTVxdVdjMXg0TkNLcHpTWFIzeExGdnU1RDVxT0Q2czBKU1VGY3hCSWlz?=
 =?utf-8?Q?vCgJSFAuKueRKyiigR+rH/69lCaqj++L?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4904.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(42112799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MFRpQXNkcWNKaGZ1VWpxMTdaUnRTUVlINklBaWpkbWxvTmkrSEZQVWd3ZFMr?=
 =?utf-8?B?VVBMcEtrdm1uY2crWW9pbUY0ZWdJMWJnWW5kMFNsLzNvV3VOandGYTNJaFgr?=
 =?utf-8?B?QUZidWdCV0toQ2tzZjRzUVk1ZkVBMlp5U0tLQkczNjJ6OEhoRkJQYXlwZmM3?=
 =?utf-8?B?T1hJMEdtQUlsZHk5QmdWZDY4cmVPMzJ3MmFIdnFCQ1c2b29PVGhRNUlZZ1h6?=
 =?utf-8?B?ZEJnM2RDS0F6YWxicEdUK1I3RXF4OU9zZFh5MHVUbFc4aEdjclNRd2pPRVdV?=
 =?utf-8?B?ekNUOG9jeldmQ0dFeWdzU2FaQUNOSkoyU0lLNjBPb094eXpVUlV6ME9PellZ?=
 =?utf-8?B?VDE2NjlabXg2WDBoTnlHMHZ6NlYxUDVpdUQxVlBQeFFLMG1RU0RXNmJHNENj?=
 =?utf-8?B?N1ZLVzlCTlNVQzJhaEplcGdudzlwbjgvOXU3WXQrNlhCMU9iSURXdDBHVUVC?=
 =?utf-8?B?UUtoTGxzOTh3NGZrV2xPVUtXN0ZpS0x2R1pYTUVkd0JMRUwxUERsTlYrV1A1?=
 =?utf-8?B?c0VuWEJaN2xGOVY2V0VZWlpUdkZlc3hxa0M5RWZQVml0bUZRRUFDOGhvQ1pz?=
 =?utf-8?B?ZTlleW9BalFyQnhUcGVHbWVQaWIwcEF0amovaFd2YmNORlp5N2RldmJBMlRo?=
 =?utf-8?B?QXBlUzUyQUhwa2dkSHJNOUdMSm1LN1plYVhxNUJLR1ZCVlExME5qZVl0cW1F?=
 =?utf-8?B?QkkwMW9kaDFWRWxjVVhxdFczVU8vUktBeUdtcEZGM2hOQjl3RzBIRjNhMjdG?=
 =?utf-8?B?dEJOVDVPYzdjbWw3U2JyNVUyWWNJTCt2SmE4WCtOOTNTR3RsSDhXMHROVFRF?=
 =?utf-8?B?dmdRdVd0WXlKUnZnYVlUeWc4cmZKL29TbUgyNTlBa3BxaGk5N2RxYmRmd2lY?=
 =?utf-8?B?TGdTdDFVd0VPQmdsR0JVWTNiK3ZVTkgwTitVSmliUU0wRkxoRGEwdGkvaWlj?=
 =?utf-8?B?emNrQS8rbEhFVXFlTHhGY1luVzY4eFkxVmpKYmtoUU11N2FPb3AxcHJCSFhR?=
 =?utf-8?B?VG56WCt4b1htT1E3N0pFNE5TcTZBQVVROXhYNmpnQlk4Y1U2TUFadzNtRXFs?=
 =?utf-8?B?WmsvRTdwOWp4eERtVVdYTE5WVkpKMTJtbERKTVZjUExKWEMrenVQbS80S3Zx?=
 =?utf-8?B?SCtWMVlKaGZNcHZNTkRuOUlUQVhWenVOZGpuallLalI1eDFVNkxCNnNkNlFQ?=
 =?utf-8?B?VXlpTzBvK1JydGM0RDhnV1RDam1QQWc3N3BNL0d2QTZaU3hhUWp3cWVyaUpi?=
 =?utf-8?B?NkxoMVVtNUZ2ZUJ3UjhlalFEZk1BV2tNb2NQd0JUcEJzVHZMU2lKN3V1OXN3?=
 =?utf-8?B?ditXM1lzd3g5RmdDbGxnRVZPRGhMbTJETjhUUTFkVEFIMnVRUHVGRWJvbVpy?=
 =?utf-8?B?SWlEdG5zbndQSnZzalJ3bEwzbnFKK25iTGxuYzNhd3BQbDNaZm1uTm9XSGdm?=
 =?utf-8?B?VzVoQ1hucE1KZ0RGTU9qNzZSQzVhMDRyR2E0YmhsbEdNYkZLT2x3ZVpJczR6?=
 =?utf-8?B?cVpTaTNIRE9HRnpnV1llVCtBdXViamxFTmtraG52UVVJRk8zd0w0WlkrQnpn?=
 =?utf-8?B?T2IwOVNtZjVOOEYwWkhRMnJqNFNLcnhUd0FORUgyYmdSUEJhYVRDVkZMUUJF?=
 =?utf-8?B?Q3h2cnFHOGl6RnJDTEpwRUVlWldoVFlRSmRRQ25tbXpBcjcweHlEOE9JTmts?=
 =?utf-8?B?OHRpQ2hBMWJlWUFLNVFaMndiTEN0MUhWTGcwaVFRNTRtRWNXU0hTd0tjRUd2?=
 =?utf-8?B?djh1YU9XZXh0T2ppUlAzVUxhcFdCWXZDMHFTYVZueEVkaUxqRUt6TlppTWwr?=
 =?utf-8?B?WndZUmlzQVhrQy9PRGpJdHZnN0g3U0tjZ0thSExrOVFoRjg1ZVdPNXZPQVVM?=
 =?utf-8?B?eXpNMHlnUVdZY3lLM0dVQTJtN0NoMlArck9DU1p4S0VUQlIwYmhFOFBOMkNC?=
 =?utf-8?B?WDdVYUxzbXVJNEdCQ0plVlNQUmFNckRzTnBFVkJXMHRTTFFBeGk0bis4dUYr?=
 =?utf-8?B?eHo4dENqc1FQbFBndDRVWWo3aFUwV0RUVHBjVjRvNnVYN3orVHcvWVhWUkht?=
 =?utf-8?B?c0IxVWc0Y3I1OVNkWXl3cFJSMDJGZUphOW1aN0t4cnV5eWErcllwaTh0bTdY?=
 =?utf-8?Q?YibwXO6NbLIXEc8jKNMrkHia9?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37343f6b-f941-4708-140e-08de37b9d9d7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4904.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:00:49.9041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUoYI4i2LG/XkSG5IsHyLv7BMgav+1rbhj3KiD11T76+p74pgC+7aDDp9a6OxoEGR3ZUZYzbcTJa3CgqQZbGtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6443
X-Proofpoint-ORIG-GUID: P6NjpDNXsiW2Zf9Q9MRp_Pfs47zZYKRS
X-Authority-Analysis: v=2.4 cv=Cb0FJbrl c=1 sm=1 tr=0 ts=69391aa5 cx=c_pps
 a=boTDQTO5XcRoDQ12XycLVw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8 a=bJvAB_yzunFYv25AXYgA:9
 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: P6NjpDNXsiW2Zf9Q9MRp_Pfs47zZYKRS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDA1OSBTYWx0ZWRfX9GQ4vyA8PJkw
 LieBmt6XeL55eSMJaWxEQSXd/9gyBRwLBuiUQTJ8FnbrDEtzHcWGVqXZhz9hqEirLSd+AuhKXIZ
 9x5YyPst/1+Za2eFQxfJ11xLPiWVvyhv66321m5hGNssnBC7BgY+MDXB4bFeb7lff4ZCtNyHgkn
 kcOLOlNBf73IVZoaNVuPjDiTkRhyRBBIaUPIy73HwzFubD/ZRlwT2o7G8Ek19AlegXAzrTAzksB
 mnaqf51gd7tFLlyHkAvfnkSAsBgwP+sTkWk1sxcKUD4/QNFWLt8j0T+S31wysaY/8AJ2JeWFfT9
 YNPDheKEDryCiUWd1k6YOxROA7bgzzHGG16xRuwzDZCR4KMBHkEQlmbv8ODNFT0KWuSwvJm+Aim
 tSv13XsxBi8bacTpuV9pV1jUx9MhZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1011 malwarescore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512100059
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 10 Dec 2025 07:01:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2760

On 12/9/25 14:48, Qi.Chen@windriver.com wrote:
> From: Chen Qi <Qi.Chen@windriver.com>
>
> Due to the above SRC_URI:append:anaconda setting, we have to set
> S to ${UNPACKDIR} explicitly to avoid the following warning:
>
>    WARNING: systemd-serialgetty: the directory ${UNPACKDIR}/${BP}
>             pointed to by the S variable doesn't exist
>
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---
>   recipes-core/systemd/systemd-serialgetty.bbappend | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/recipes-core/systemd/systemd-serialgetty.bbappend b/recipes-core/systemd/systemd-serialgetty.bbappend
> index c69ad4e..8395ff4 100644
> --- a/recipes-core/systemd/systemd-serialgetty.bbappend
> +++ b/recipes-core/systemd/systemd-serialgetty.bbappend
> @@ -4,6 +4,8 @@ SRC_URI:append:anaconda = " \
>       ${@bb.utils.contains('INSTALLER_SERIAL', '1', 'file://serial-screen-anaconda.sh', '', d)} \
>   "
>   
> +S:anaconda = "${UNPACKDIR}"
> +
>   do_install:append:anaconda() {
>   	if [ "${INSTALLER_SERIAL}" = "1" ]; then
>   		install -d ${D}${sysconfdir}/profile.d

Merged.

Thanks,

-- 
Kai Kang
Wind River Linux


