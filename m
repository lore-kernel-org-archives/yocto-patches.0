Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CECD2502E
	for <webhook@archiver.kernel.org>; Mon, 12 Jan 2026 02:23:40 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23966.1768184614493514091
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 11 Jan 2026 18:23:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=c0bO5Vbv;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=54725df401=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60C2JKpN220023
	for <yocto-patches@lists.yoctoproject.org>; Sun, 11 Jan 2026 18:23:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=ydUs3Mq5v9Pf0auwL6uri4xQOH5QasX/WUpSbNCMN7E=; b=c0bO5Vbv7MsO
	ynfLV2j+z9PGKHz26zBaFizssigiq1j4no7g7pI7+xXtPvGM9HgwruOeRk778XZt
	MWaoRT7iXMOAkGnjeB8Xq9QO8sIAY/DHv5fdPM6kqP/hOhb+Ssdl/VUbHm2UafeH
	pHy+gRwo9XNi68W+gIGf0ymY6rPirKClRTta5uzU+urplC2D8UfiqhB3M5sOpolG
	c2H4W1J/eCdNc3FKAZEsw+2lpqIlwEfeHY20DrIYU92tWN0G42TafIp88hf51bEC
	Tdf1MlGuADSJEazhJ5ul/gvpstMyiFsB1oA6/qJHH/14HnkJmH1k8sW14zncFYt9
	6jinnTQ4CQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012032.outbound.protection.outlook.com [52.101.43.32])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4bkq5fs0u1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Sun, 11 Jan 2026 18:23:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uchnsh7K7xAlOHVXY+be5p71uO0Tg/f6tNPgjYNEjLdUBLT5Ale2XYQEltK7Yee1HH8iauTgLeirjUXrNEff8FS4MgWvrMmtIGq/TpTX+3JasoaY5Ukpd+c9/RqWG9Xj0PGRSyPqgDhOzth7rfo2hWow6PlIpU8rgjrWZ3Ogz0OsWU6lzcstqnY9k/2ysl+EuH4IpVmMOMIKQLKimTSkXzqcDHbXrWmrPrPKlomc9MGiRqKEaPKFwAt6VDhzVGeKg4V6UZfB4q1PGxezQDhl6UZ+HEG5u87sH78tJsiDYr8BH8ifgttlX2qxw6LNtBzSv183IaJRCP47tyOBGgbKpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydUs3Mq5v9Pf0auwL6uri4xQOH5QasX/WUpSbNCMN7E=;
 b=pH4LEgGoV++bfhhzlyUSSNO8XttkOSy/f9oZGrCLXZK0QqR5ti27315TUFl+jkyUuW2we0jW13vdVV0hjcJL5Lqr1SxLtd8+VIjnPWeZzW1WdbyXMo2L8zqHEuXmbc01XDebDU4JSMij0yYZYqHGww92tq+2/FMP296mK/QNm4k/zAo7ROjieVfge9wS9jeZgSqyhWZYuRCjzYoqkQtUFOvTrOUD7VVZVo/UmKwDuXfK6Nx4FkRB3C7Nun/vUrMcBjte1QnFIh++/Io9iqDKsW9p6in2TOFT3NSPDJR6s1tvvm8HE/DgDFFQo2F/rxvM+hBAvXg+j5Iabh/0NJVlsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by IA1PR11MB7342.namprd11.prod.outlook.com (2603:10b6:208:425::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 02:23:31 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9478.004; Mon, 12 Jan 2026
 02:23:31 +0000
Message-ID: <43695c98-b455-4d5a-bc22-5e93ba9c2292@windriver.com>
Date: Mon, 12 Jan 2026 10:23:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH] config.json:
 add x86-64 multilib SDK build test
To: yocto-patches@lists.yoctoproject.org
References: <20251203052223.3251326-1-Qi.Chen@windriver.com>
Content-Language: en-US
From: ChenQi <Qi.Chen@windriver.com>
In-Reply-To: <20251203052223.3251326-1-Qi.Chen@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0284.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::15) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|IA1PR11MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 74fad9f8-fd30-4118-a493-08de5181943e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eUdPRVgzbmhoZjJ6dVQ1V0RUN25RMEtuRktIOUhFclFmQWI1RW5oVUU2MnZZ?=
 =?utf-8?B?ZG9pVVNqdE1hQTd0NXJIazBXN0p2MXI4QVd0NVZONmIzRFFxWXJPM08wb25H?=
 =?utf-8?B?d3JVNHRNRkNvRVdCaDFTZ1E3RmNwb2laSDdOZXdzQU1hblFiUVgrQ0dSc1dY?=
 =?utf-8?B?UnFjdStUWEJ1MExvUFVlYUZVR0dOWlo3V2lVaTJCVTFyM3dDNGJSSmRXK3N1?=
 =?utf-8?B?ayt4ZWF1d1lBRmd0YnlaM1VERnkydG1mc1pDeHEzT3RJY2JXV3JhVlQ4eWFj?=
 =?utf-8?B?MFdUN0FPWmZPVTllUmJob2tZQ0RRVHlXSjhUZDFBV25TcHh2SDgrOTJYUWtS?=
 =?utf-8?B?eDRxdVhwK0hQcXgxc2d1bXJVV3dOV2MvZlVrUjV6bFNsQm9EcUlhb3NvOUh4?=
 =?utf-8?B?Y0hPTCtkK2lsWmdIOXVQenBzVFMrNEZ5QjdmUXFoK3J3dVc3dk4xSldKMnQ3?=
 =?utf-8?B?QlFLYUMrbDlmWlRVZGdWaUdrN1RnUFRHNkxYUEE2QVpqMFgzUU9nUlp2enpo?=
 =?utf-8?B?U3Q2eTFRQ0UxbUVnMjluNXprcEpXRVM1ZCs0V1lyRWlRWjI4YXA0RVNJdXRq?=
 =?utf-8?B?R1Eya1laSzJTckhpZXQ5cG9hSHBReGw5TG41alQ0bnNTTFdyQjJiL2Frek50?=
 =?utf-8?B?dkxWamZNMUk2eUYvS3NjWGo5eklFSG1lTHkyK2hYMmp0KzFNcktyeTVxM2dh?=
 =?utf-8?B?KzdHb3lmV0hla0lWb0R2dzNlMjcrcVZxNUttL0ZoQ2lDRkIzU3pOTmxWRTRP?=
 =?utf-8?B?RjdzdFZaQ2FxQnd6eFIzcnJEeVhjWDR4NGptZzZKdW9KNS9JYk4rV3llNVp1?=
 =?utf-8?B?TmpoQW0rSmZLR0NSYWxEYjkvSU9KK0dsTkxRVDd4TGJra2JkUkFJUFA3U0Rs?=
 =?utf-8?B?bkxnQkIwL0FRTVZ6ZlpoMzNjSHBJc09NK0hmalF2bmxJUFlLWE9YOTFubk9Q?=
 =?utf-8?B?dHhUT3FCb3I1MHVRQUR1YTEwWGdCbHZBeWlDTXVpaWY5YmFqUlVLSWUvREZG?=
 =?utf-8?B?Z3AySlBNeTdML3RER0NoOUtETkNxMnBZcUxEZkVlY2NLb3l3R1ZpZUliQUdk?=
 =?utf-8?B?dGdMNUJiZXdXaUFrOC9LTWNERWdnODMxcjdmNUlXanJERlIrcUFKZWhCby9r?=
 =?utf-8?B?NVA0UTlTZmZPQ0t3WFVleDZERFFzU21JelZDVXk4S3lDUjhycUNvYUdLYWRH?=
 =?utf-8?B?U0VqWWMyK25uTEFXbmZpTnBvbHdmcVcybWlyUjNsZExRTzBmQ3ROQnN1d2p2?=
 =?utf-8?B?SmRjcnQ1ODBpRUNlbWpZcWo5eGJISUx4cXU0TU1udTByc2E0RVFTRjYyQlVw?=
 =?utf-8?B?SW9yR0JWYTJyTnNEOGUwV3FQSGNnZHRhekFzRm83TTRJZWptYkE0SkZkYWVH?=
 =?utf-8?B?Z3VWQXZjUE13SDUvUjNwTXFvdTc4T0FRZWx1U056UGx3MjJFVnJLN2dEN0VU?=
 =?utf-8?B?ajI2b1FjYldETzhxU1FWdTh1ZHRhOGd4MW1tOGpwa2ZFQ25IdTZndE1BY0ww?=
 =?utf-8?B?MXRkSHRBdnJHdGRsOStid3lsa1VvY2FEanFLSzV2M1ZhVDcvT3puT1BuY1RH?=
 =?utf-8?B?bUxFeEZjcFhuYXlVcTNLWCtNakQwK013L0JKUlJjREQwMHFSNGZZdnNtY01k?=
 =?utf-8?B?NSt1dHd6WkZGOWZVck55VU1EaTluNWMxMzB3NHBkTVp3UVFWdWsydTVNM1Zx?=
 =?utf-8?B?VDdCZWpuNDlqY0czSkljcHU2THVYd2lFdlFnVm5OaXdOV0Nab0pua0dPSjJN?=
 =?utf-8?B?RklCbEJxTDc5TG5kTlhYVURXOERRcGFxT0Y3ZW5zclRTYVg1dEhGdFRBNkRC?=
 =?utf-8?B?VG1sQmxJLzFCaDRZMi9vVHFvenRFT3pVTlN6OTFTS2lETW1oMEJTMWZzeDd5?=
 =?utf-8?B?ODNwY29DLzFPNXQ0dDFUN1ZWOTZvcSttVjBwZytaaFBYdnpRRk5MTE5ZZXA2?=
 =?utf-8?Q?o8WPCHicQFBcxkKRnhfD+cjWBxqWdsyb?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UHpjcVRaK0ZlM2kzREp1SmxhTXo1YmVqL0VXQTBQV1FvSkwyU0l5dFEyR3Jy?=
 =?utf-8?B?ZlpZSjdvTmhySDdYZjY0Mk5WN29mQW1uQzdCREwwL3ZzRTByYmlBM2JWMEVZ?=
 =?utf-8?B?SEVOT3FlcDBtb05zdGtsWHRrTUxSdXY5NnYvTjBOT2dBMjNkYzA3YXhLR0hv?=
 =?utf-8?B?Z3BVS1o3dlU1dlByY2UxajJQSFZVVUhabVFnYmdpT1VUU09VZk43ait6MWFz?=
 =?utf-8?B?ZjQyMjZpZzZqWFFHK2JxcFgyVlh3VkpMNUcyOFVMcnNkMXVobFRCczEybW1U?=
 =?utf-8?B?N3dvUklHT3pwN256UkNGQmR5RFQ0c0JPeUpVRDllRVpBN3IyQXlmM3I2aUhM?=
 =?utf-8?B?Q05BR0RranZRTEJjVGNKU3FIUDNVM0JDMEo3azhXd0p5MHhhNy93d1ltaGNE?=
 =?utf-8?B?MVJrenNXWWVQTlh3TGZJSTVNYkRKUGxxYmM5ejJaMjhtaUQwNDVXZXV5dUFV?=
 =?utf-8?B?L0ZhNGlEaWZ3ZWZFYmFXL0ZRaFhYZ0RVNzJIWWMzOTAzV1RyYjlncmtwY0RU?=
 =?utf-8?B?NlZFS1JrdmNKOGtzQ3dLYm9VbWEvQjgvdUVlOHVYV05PYVRVdmN5UnhsYjlx?=
 =?utf-8?B?M25RU0NFY3VidCtBL1dpR3k3SlF6ZjdPWjAxbzZJRjNrZ0oxNFc1bmZEWFQy?=
 =?utf-8?B?c1Vsei9rU2szbk5Ea0RVOE9vcHNBUXRCelZ4OWhWQzc4NnR6MzNxRElRdEdM?=
 =?utf-8?B?NzlZamlZTHBZTGFxc0lQS2dCMHc5a2tmYWtZTW9QdGpLcHJwRjhxWG5pbWEy?=
 =?utf-8?B?Wks2WVJzRFl5YjUrMk4rT1lNTit6NEV1dlYvMGNpUFBGa3MzRXZYWDlXRnp0?=
 =?utf-8?B?MkVlSG4rMHJmNHZ4cDBMb1hFRndab3ovSHRJWHVPYVJYWUJEZ2tXWmkwK1ll?=
 =?utf-8?B?R3F1VURZNDV6emd4R21XRk1LTU5FeVdzQWRBNXRPejVMcWRGSDc4NFhaY0F3?=
 =?utf-8?B?WTJEazNUZVVRRm9EbDZ4aENOMUhpTitHUWkvWXcveGhPY3FXVkxJQnphS0VH?=
 =?utf-8?B?aUsxejRjcnJCTHRFbmFjczZ2UFF6S3k4bnBDSWpBOWJFN0xadlN5OEcyaFBD?=
 =?utf-8?B?dTV0NWdDd3Z1UDc5ZnB6cVdiMXY0TmJBblVGZ1VpRUMxVW5EK1prek5yVTIy?=
 =?utf-8?B?RnFBZmRMR2t0bnBSVFFYMmgwSStGM0lFd0FXMnNqZkhvTzVDNlNQS0RoRS9I?=
 =?utf-8?B?ZlVDSm94ampYY0ZuNVl3LzNtdi9ONVpRMlg5eXlobmN5UHExeHF3RWxLbFlH?=
 =?utf-8?B?N3ZidjRURXhoczQvWTlBdVNDclkwUmh2b1NaeUw4RS9wNllCVFJLaklzSUtn?=
 =?utf-8?B?VVNkVW8rS3pCa1UvRDRSTzBsRXFFaXoyQnVTZDR1RklQd3RLTk5LR0h3SlRD?=
 =?utf-8?B?WG1MTmlsdzNYblAxV1BSa2N6VnpsbXo4N09hc1R0UVR6TnR5Yy9WMU83TnZi?=
 =?utf-8?B?aXlYUlhnNlByaU00NlRUMDNQV3I3SVVJL0JFaXBwaEd3Y2IvUncxYnhqN2ZI?=
 =?utf-8?B?TlZpWG1YcHFMQ25vZUVZcExXWGh6WXRkNGZCYkdmcHQ1ckNycUFWazhWUHJa?=
 =?utf-8?B?Y2xrVkxRWHR0NkFzdGI3TlNIT0RIY0pGSmZ1WXJFQVJobytPcVRqWVdsTXRm?=
 =?utf-8?B?SkxaMGJ3ZlhnWVVVWTRBT1V1amk0N3Jac0k4bGlpVlMwWnVvSk14MStqVUZj?=
 =?utf-8?B?TlZaNG0yU0QyMjNwa2F4UHd6UlZEOVlaWnJXZ0tyR21YQVNOdndHOXdaWFRE?=
 =?utf-8?B?T0FJOUIyUnNEVzBKTDJsK3VSczB3WnJFK2VPZ0hrRVFtYldxU2dRbVA2NUo0?=
 =?utf-8?B?NHF4M0k5TTF3NTJ2TEpZbU0wNmJRZjRpSk0rQUFSZjdaRi9heG9Hb2tSZDY4?=
 =?utf-8?B?d0dtU3k3NmRwcW9sdVptQldPZEUrUUhlNEZ0enNHYUF0bDNZRGx1TC9SdFlh?=
 =?utf-8?B?eWtDM0hRMG1lTW1RQ0tuc1hLZ0NSaTRKd0hwMVlaMGFFS2J3K2xEc3ZOOHdx?=
 =?utf-8?B?cXVpUjgwNVBwcUp0aUMzSkFpaW02SWc0RVEwWTZ2UjMvYlgxaUhIY3kvTEFY?=
 =?utf-8?B?M0pqc1l1VUpwbWJTL0NyQnZDbmUxeElnY2xobC9oZXppbFVEbTFtbEhHaCtz?=
 =?utf-8?B?TVVBcjlXQ2w0d2s5bGpra3NBSWE0RCtlVmlkTWEyTkdPWENKS0I5dXFDdytZ?=
 =?utf-8?B?YklJeGV1cDh4Qm52WXFPaEpmaWZ1L0d1TVRtaS8wTGlqWmR6VVk2RktkdW5L?=
 =?utf-8?B?d3hCRmRoYXFESGY1THFSV0pwdWkvRVhpSWFUZFVCSTYvTnY4ZW92cEJ1V3Rj?=
 =?utf-8?B?UTNvVm9LYmdwbng5cGFxYjFKSVplM0c3R0RlVDZMcXlTeTVuSzRKUT09?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74fad9f8-fd30-4118-a493-08de5181943e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 02:23:31.5499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSvMGCziuvECposOulJb3sUQmeokAD78rgsyGqD/EJuZZHyH4wcI6wyGIEV9VuAkngWdCG3zHgef4qp3phUWew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7342
X-Authority-Analysis: v=2.4 cv=d/z4CBjE c=1 sm=1 tr=0 ts=69645b26 cx=c_pps
 a=KOMCkPMYLpCa0saNKAKAdQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8
 a=saKp0ULWVzwHQOh2VYUA:9 a=QEXdDO2ut3YA:10 a=nM-MV4yxpKKO9kiQg6Ot:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDAxOCBTYWx0ZWRfX/sPvTNQfONMf
 kiHJIUJ6yvPqC4iWsRVhuvhqHqtlXs2QhYgrNLnKZge+IXsIs3uzF4B9+96gA+L1lWYnpWFYbqw
 187Q+cA+yeAUpmTZ39H13qsU+ALr5qVnjwgpbjPRO2lV94WXuoMtHlqRd6kbwrrntuBDHL53u7P
 YJedY5y3OtboBydGVrBtRbZ8AJkmw+ElfK4fYs5FqD4jAvE6ulOK+WOE51O8E0g/Wo+QWgbDpT3
 rkKFVXoGUxRBDGf2DxSiLuzPEm21V7ccuy9uszbePPk+4GEWB/QX4mw6u8pl2O8t7mfu2gatLq9
 B4gpxBCSg/lV1Lh7jYKANqW8HN+oYBFPF+70bvZl3ij6wyOr5GiYN7dHriZWYh+CXmoZZABUaO2
 QhFwajmkFzNwmrNDyPQGEdZTWEcACyvVkx4DLZquDpPS6ZiFJmIRIHJAi5a/jQTTnxMO86s/3Ew
 dkDrXBsZwhCUOORMGxw==
X-Proofpoint-ORIG-GUID: niOMAVkxrPCPtDJ9SxOURD6wvWD-SCut
X-Proofpoint-GUID: niOMAVkxrPCPtDJ9SxOURD6wvWD-SCut
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-11_09,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601120018
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 12 Jan 2026 02:23:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2940

ping

On 12/3/25 13:22, Chen Qi via lists.yoctoproject.org wrote:
> From: Chen Qi <Qi.Chen@windriver.com>
>
> Add multilib SDK test to autobuilder.
>
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---
>   config.json | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/config.json b/config.json
> index 0cce282..15bb6be 100644
> --- a/config.json
> +++ b/config.json
> @@ -925,6 +925,17 @@
>                   "extravars" : [
>                       "OE_FRAGMENTS += 'core/yocto-autobuilder/multilib-x86-lib64'"
>                   ]
> +            },
> +            "step6" : {
> +                "shortname" : "x86-64 lib32-sdk",
> +                "description" : "x86-64 sdk with 32bit multilib enabled",
> +                "MACHINE" : "qemux86-64",
> +                "SDKMACHINE" : "x86_64",
> +                "BBTARGETS" : "core-image-full-cmdline:do_populate_sdk",
> +                "SANITYTARGETS" : "core-image-full-cmdline:do_testsdk",
> +                "extravars" : [
> +                    "OE_FRAGMENTS += 'core/yocto-autobuilder/multilib-x86-lib32'"
> +                ]
>               }
>           },
>           "pkgman-non-rpm" : {



