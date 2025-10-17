Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B786FCCD195
	for <webhook@archiver.kernel.org>; Fri, 17 Oct 2025 15:54:11 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.19720.1760716444195934185
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 17 Oct 2025 08:54:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=pCqDFJ+G;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=238560992c=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59HF1cFO3619656;
	Fri, 17 Oct 2025 15:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=RlZth65CyJH2XmDKvMToBmfowcUW8YHopDizd8g+yE8=; b=
	pCqDFJ+GKio0WlmLnY0bx3NBvEU5PDzFDPTMkr/vVK9+FgmELRwZzAmGi2FhPiSK
	+g1Wci3C6uCc2HOxUcwWm8VfDTXqpStIw4vjKGoGqadQ0PQ07dZx6gAF2SIVZj/T
	q9iJOaOserH5U/y2ga+uv3EkAxykoASXp2PSd45tj+HxwHvE5L4wuVnHGj9ZpoLO
	UDi2ryfNrGLppnVp93beEXV+b76b+Htwt5l4qLV0fElyxxeR5qg1TxhzFCUuZk5G
	hJoYGuxAVzHY4BwfuNEaMKmxPQjveWMImv3oeaH3WGg5bnNA2ksXqm5ZIcuMcR7C
	fzMpIErpzz1LYEY3cWZAkQ==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010042.outbound.protection.outlook.com [40.93.198.42])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49sthhcand-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 15:54:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhreL3lwSBTA/Hi3StFhaypmvGDBNyBMXIq3eT6zsu8ZG+geMbBwygjwRib6IXLQgEmcN56W5lCmJjGRN9lKunNZfDUoPuY1Lre1uxBrRlGJW8m4Fieh8j2gMbS3FOxTfsPSEgX9/cQnCwLgHH6Bqsq0bWwFlkJMQENFMVCcQCLWSWZv8vPBfsJnLPG+Bp0KtCxhdbOU29B9UdcUyWrSFkufb3wNEfxrkYgAYyGpBOcbZDq7YIAsFFghgqk+roDVWTIon7U0HIfLnTQglinBD7VEO1sgBxyIK0qGSrjo+Jy8dIEFqKHY4FrjF2jbhUYDXIqsfRhT++wTv08dQ6zEbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlZth65CyJH2XmDKvMToBmfowcUW8YHopDizd8g+yE8=;
 b=EHr7ilYe56RebMf9fVuDn1hcXu/AeXmg+T0EovFgw976PoCZJuS3VroJs/twkb9Cl/jQ5aeoB8BgKFSjhQJRdoEjGwAfwyctcmUOBhPZUTxPCFae1JnR3HgktHtc5x7Id7QzdsDlW5o7JCgAi7272YOOQBVYYaOjPVRdnfhmn34JIqAD32GH+p+r/jpwbLXLS0T5vgYqEf3faslhXnyQSuPuqzzYfmSr9ahXpFYcAEoteksi0I5f9QifTDgtxbSDBbEmJRl4LRaeyPPdPcz1MYSXQsmHZzKKlmf2YTC2GpnBJACJjxE1hAL3Tf5dClm/nZ/6tSg+3xgOY9yR2Gt3aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 MW4PR11MB8266.namprd11.prod.outlook.com (2603:10b6:303:1e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 15:54:00 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 15:53:59 +0000
Message-ID: <22cca177-dc7c-46a5-afa0-327ab71310da@windriver.com>
Date: Fri, 17 Oct 2025 23:53:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-selinux][PATCH] genhomedircon: remove build
 path reference from generated file_context.homedirs header
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
References: <20251017064318.3442718-1-quic_sasikuma@quicinc.com>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <20251017064318.3442718-1-quic_sasikuma@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0357.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::15) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|MW4PR11MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: 086f52c6-41c7-4f87-9054-08de0d956302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YlY1SVRmMWhVeG1YMzR0VFk3aE5MUG9ha1R2clhETzFtejc3Wkh1UGo3YVQy?=
 =?utf-8?B?NG9NdFh5emZLb3psT0t2QnRGUTZsbWhFNmJpV3QzQ1kyKzR4Y0xLTW5tTW5C?=
 =?utf-8?B?SEd5aVptQWdkZXFSSjVTSE5OcG1WTiszQk9DL0tPZVRwa0ZrWndRYmlQYkJ0?=
 =?utf-8?B?OTNJY0xyckFVWWNmMHJZRGhoZW41RHREUUFFeHRQUEVCZmlocGdNMjFGaTBB?=
 =?utf-8?B?dmhWK1F6dE5mZkpKS2dUWURCMkJNL3BkSk15ZnJRWmlCOVFYTkE5eWprK0t0?=
 =?utf-8?B?Q2hsd28yZ3pFZ2YzQVhoUDhPMnBqVE5ibS8xbGU0eFgzbkhyTVN6K0FPQ2RR?=
 =?utf-8?B?ZVZJQkpSNC9qMk5NYXZCczZkOVRLMTBQRWpFZStNUXNtWlQyR2tabUlhR1Ru?=
 =?utf-8?B?Tjd6SFJvME9iTEtDTVNkanFTNGlUWFBEOE5Da1FaWUxhcENMRHRYdFFyRndk?=
 =?utf-8?B?WWU0M21OMW5sK2xJeHFVTUVGeWZleit1QzJadWs0RTZFYkRObldRUEcyY2pQ?=
 =?utf-8?B?S3duWXM1aGFjOXNORVRFYWpnZUhjaEMvMW9yVlBzTTZXOXk0MmFYUW12M3px?=
 =?utf-8?B?dHREcFp6ZnZVSTlkd0lWbE5aVFVaSlpaNVk1aW9TRlhjcE9VNGZiMU9DSVNF?=
 =?utf-8?B?b3hLT3Z1QitKQXpPeFZ0YkQvQXFuVDIyc0ZYbG1ISUhjTVdMNjFCZ1RYa3Fy?=
 =?utf-8?B?K0w2Y0NpeUtnbWp6bXlLdC8zWDc1ekdUS2QzZTFkUmZKODVWYnJGamhXeThV?=
 =?utf-8?B?cS9rK2J0S1lKYytCcHZKRUdtVGlyVmdkajdJVzNMdnFNR0MvVWxsUFZXWi91?=
 =?utf-8?B?eDRKNTdOeFlMa01nMlJOZ29RV0k5ZGNnQklJQkQyYnVpYjRNaFdFQUVXNm9x?=
 =?utf-8?B?TkZnQ1IySkN2eWFBZ3lFQWFCUXVONmFDNTA5QURlUGFvTmVYaHNHVFUwSUVn?=
 =?utf-8?B?L2xROWVmSjQ5ZjF3dm93NEVzb25qeDlZNnhFWnh4WWh3b01ER2ZuZitpanBR?=
 =?utf-8?B?N0p5UG0zZEdGQWFmSXk0bVdlekhrS1llOGEzakRCV1hzRnBZZXVQamp4aDVK?=
 =?utf-8?B?bUpNWkkzZ2lPcVhTRWdkL0JJV3djaW8xbDAxd2FPTGFiVlIyMmNoYWVhQ2x4?=
 =?utf-8?B?bFJxSkxobUdlZ1Buald0NWVSM2VNWHJza01sUTlqOG93TERjRHIxMkNGZ2U5?=
 =?utf-8?B?MHVmY2E1aEFYMFRiV2VKY20rcDE5dithc3NqanY2RWlLSWdRT3FWTXdETXA1?=
 =?utf-8?B?NDZVeHUrZmxWYUI3Z2hXN0hBakpUVTlZakJHNFZlRW5jMnpQbURteHhjUVhh?=
 =?utf-8?B?TGR4ZHJNYkt5QW9vK09EQ2Nib09GSlpncG1ReDBzemFsbzFFSnhXRnJleEJK?=
 =?utf-8?B?akZLSkxGQVdYQ0Y4ZnhjRFJ1K1VNMlRlYWdHejBkN3A0Q3g1MmJTMlU3L0dG?=
 =?utf-8?B?ZVpkTHlPV0tISXp5eGd6R1ZYdkY1SXZYVTFkbTZTUXpHRXdCSDQ4S0IrVjVZ?=
 =?utf-8?B?RFZZTE9TemNCQnhBaHFJU21TeXpDNW9ma3VUYUxPREdtYlppM0lqN3FqQW1v?=
 =?utf-8?B?TjVhSVYzejVXMTZRcmtmMFNGRThxNDVqRk5TQWhsMzRITmx3cVNkTHRVN2ds?=
 =?utf-8?B?MHVmVGNIbnBoZGFzWHFtbVNBa2R1eEc2RzkyY05sL1NNbUY1NnFoL1VBRDlS?=
 =?utf-8?B?T1pYZ1dENUhvL25JUVBQOS9oay8rU0pqYzVFWklqcW93a014ODIzWU5YT0p1?=
 =?utf-8?B?bVNTTFZPb3hpSkFvdVgyYm9DaXdOUGszYWI4MmYzZmI2b0o5R0g5cit0WExI?=
 =?utf-8?B?MHBtTTNJR3VoT29JYVNnTHBLQnhWbEFBVUJOVUFyZDZnTUNHaWxrUndYaUZk?=
 =?utf-8?B?amVKc1E4Mm5QSEEycGkrVUxrWWpMS2JMM0hvVnZVREttRXdESTh2TEVSeHYz?=
 =?utf-8?Q?CMV8FztsxShCrvPejYYUfB1bSevogyMj?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SjA4ZXMweG9MN3ZPV1hUM2M1Vm1LelNNRk9rNGFXVWl1NnlNZFAzUWo0bmNw?=
 =?utf-8?B?cmxqV2VMUVhJTVdNcm1qbkxwcmVQWGdEUWxlS0pPTUxGWGJyQ3FsWXlGZzV3?=
 =?utf-8?B?dWFZSVF4REdIdjFXTnBlRGx2MjdxUTZ3cDA3Z2xEOVYxWjVRZ203ZXh1R0t3?=
 =?utf-8?B?SWRsSVlUR0c1MFdjYTVpRVRCSmRHbStHTG04L1lDU2dRUHNpM2xEenVvNUJo?=
 =?utf-8?B?UXJVMi90SWRYbWgrb2p3VFlINVhMWU5hSUtBV2Z4QkNQeTZ5V3lqVFh2MkVt?=
 =?utf-8?B?S2huenRPUGY2MUo4TFdlTVQ2a1B1L2FLM1pQQmx6Wmh5SlFIc1ViU0dSd1JU?=
 =?utf-8?B?ejdBNWhnVGgyMjZMUU9ITkFHSmRnSGpydmxCanRJcVR4VGdhVFVPdEtTSmdq?=
 =?utf-8?B?bFJocVdzS1pLbDR1S002cklRNjlQcmM1SmRNUEROUVVuRlVtQTRLeU0xc3hC?=
 =?utf-8?B?RWd6bVhFekRzTDFkR3N0aWFMd0JYeitxM1hBcElpdkdCemh0bW9jM3JldDh1?=
 =?utf-8?B?dzM2VURLM2dmbm1rZXg5RktxK2N2LzNkeHdSY0tZVCtXbTdCMjBjamVpbytX?=
 =?utf-8?B?MlEzOGtlL0VmeFFnYzlYeXZKWTVwSkVIT3ZpSFdjV1U5cHlDNXhEVnVMM2R6?=
 =?utf-8?B?VkRiaEQ3ckVvOHNmQkxJZkNrZ1FYaUE5OFk4UWxLZHlKeHRRRnptOUFDcFYv?=
 =?utf-8?B?cVBTVDU3ZUplbkovOFc0elMyaWdweHpQV1EvYUFTeWtKME43UGIzQm5PZDhJ?=
 =?utf-8?B?bWNjTzVMdXlhUFM3emFqdUxiMWhnUlBxWkZTUUhWUXg0Y0M0SlpGVDFCeUpq?=
 =?utf-8?B?aTViakZjSGltQ2JrYW4wUVdtOXFZYlNmbTZ6VCtIVVBjRk5zVm1qaUR0Z0lN?=
 =?utf-8?B?V1VNNXFsWjB1b0tOTk1DWnJhNjhOb0ZnajdlVitnMHdKQ0k0KzZRWlJFL08r?=
 =?utf-8?B?K0NRUDJKelBTYXVPZnU4OURCMlUwL2lDSkwzM3IzSysyK3ZnTE1Eam5wT0t1?=
 =?utf-8?B?K3hnVEhPZXV6ZDZaeVdoa2IraGpkQTZpdzNNN0Jma0tTNDBaTWQ4VHRQOG1J?=
 =?utf-8?B?UEJvczlwSTI3UUdZSURKeUxVRlFmRXBTZkhod2xJaEkyTC9HTThranVPNk9K?=
 =?utf-8?B?TGtoaFlDNjVTMnI2UnBFcXJoaFdGSThKTHpJMDB0YXR3WW9JeCtBYWs1dzJx?=
 =?utf-8?B?aVhsanRYSmVOdUNKTGRoaDVVQ25KcDYweVR3L2YwR0RxRm9Sb1lOOGlNT0Z6?=
 =?utf-8?B?ZGxwSTI0Mm94bm1WSkxLR1VBaWRnZTJrVEtIM08zamFTb1krbjJ5eEoySVJC?=
 =?utf-8?B?Y3B2bitPTnNndUg2anEwNUFVTFpwYVlHWEtGZS85bk03ajdleVhBMDVkVFdY?=
 =?utf-8?B?alBnMlJkUWNNVlcxb1VXdCtPZ2NzK0g0a3MyeHdVSDZPakM3YmREWWlGaGg0?=
 =?utf-8?B?Zk9xUEZOWXFiS2F5UHhxcEsxQmNrT3YySzZMbm9qckU0RzJabG9rN0tRK0lx?=
 =?utf-8?B?dGlpUnBsRzRwemVhK0ZqMER6VXNzNnlDSmUxWmsvTENIb094QmdaK2VYVHRm?=
 =?utf-8?B?Z2FoQ1FHajQvbkNIYm5ZTGVwZWV3elZXT25PTUQ4MkNqbTBkTW51OFdtOFkx?=
 =?utf-8?B?OVNZNlJ3cVRKcVdDWHoxREF3eE53WTNzN0R2d0EyV1JMT2xNN0NHM1IwdzRO?=
 =?utf-8?B?OGNUQVdaZ2pqVjRCbVl5VTVlUk80NmJTU3k1ejkzL3RsbXRFaG5MakVUTHB4?=
 =?utf-8?B?c01YeEF4LzR5T08yNUhLKzQ3cE9GOTR2SC9Kc0lpVDJ5Z1hUeFh4bzkzeURM?=
 =?utf-8?B?aU9lZ0lLODNGNTlUUXZwRW5vNm1tbER0V2JhYmZlMW9XQjJ2OCswSExyUzll?=
 =?utf-8?B?N2JPbGxrZGtZckpWRHJjQXFSSUlzbGVZc1ZhUTMxV1NzYmZGVmtRU2NOdWFj?=
 =?utf-8?B?UWJ5V1lBU1FYcFhGbWgzVjQ2WjdZZmVVT2k3cGFXTWhpekhRWXZTWlQ1M1N4?=
 =?utf-8?B?YnJUTFQzUEdmZEthb1NHS25BSEVmcm9QYlRIa1MyQitoV2NFMXJucXB6MWl1?=
 =?utf-8?B?TXJ6TnBYcGhvRSsrTDlSMXVibGwzK0UweXl6UWZwRURlZ1VaWk9nRUhpc0ha?=
 =?utf-8?Q?Xqt+ZHD3SPZqwoA1V6+SFWlMr?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 086f52c6-41c7-4f87-9054-08de0d956302
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 15:53:59.8404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: exl6e3354MqAIIVNlnrKkxjaNbr8uHTjPFM3slXACr/bWztmIdffK3PiObT23mOxdnNLQ0aEOExslJog8+pfGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8266
X-Proofpoint-GUID: lqz8iLIdo4f1hnwMImlgwjrLYIqZOGot
X-Proofpoint-ORIG-GUID: lqz8iLIdo4f1hnwMImlgwjrLYIqZOGot
X-Authority-Analysis: v=2.4 cv=QLBlhwLL c=1 sm=1 tr=0 ts=68f2669b cx=c_pps
 a=EKn0uP0Y4sICCJyfUD6Zbg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iGHA9ds3AAAA:8 a=COk6AnOGAAAA:8
 a=560_TMv1KZjy7Psni4MA:9 a=QEXdDO2ut3YA:10 a=nM-MV4yxpKKO9kiQg6Ot:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE3MDExOCBTYWx0ZWRfX6YntnAaJzmuu
 WBn88UHqtIdd3dun5Dz1cYzX/H/PxaZPgCOlEBQP9ure1/H5m4EPRBLa2Ojh3beQQ02jh7AbbBk
 b/WAWG5JAYXnSBuUNuW/3CDJ3rRdAzNBU1BtL2TjZGxWEa8dEOUw8wWp/Ta0xLpREuzWA3d6UFM
 VG1oBOAU54u3jfwM52BxGGm7CKGfIEMSQCUKKBLURBts4ubFTinOScTTB+3ddw/5I+O5lyA1DlC
 ySlEeanUMzcGSSVgLek2B6uSkfRUnT286qBr6A8QSReT04hazkqGk+HmFaRZ6y/jFMECTBfXKjY
 dJ3TwgHJ6LP4o2iHW4f5gd6z2qEuhX2EK3i+VGzvGkZxhbNPa+OX63adB6VCbBOlDb7DoYBv8kf
 yn9CnfAt8zV0EQ7iLWiG/+kjlyI48w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510170118
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 17 Oct 2025 15:54:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2350


On 10/17/25 14:43, Sasi Kumar Maddineni (QUIC) via 
lists.yoctoproject.org wrote:
> The heading() function in genhomedircon.py included a comment referencing the
> absolute path to the local.users file, which resides under TMPDIR during Yocto
> builds. This caused the package QA check 'buildpaths' to fail due to the presence
> of build-time paths in the final packaged output.
>
> Reference:
> The below commented lines are in filecontexts.homedirs file as a header,
> which contains TMPDIR path. So, do_package_qa is flagging this issue in
> case of MONOLITHIC design.
>
> To resolve this, the line generating the comment with the full path was removed,
> preventing unnecessary QA errors and ensuring cleaner policy files.


We can simply use 'sed' to filter TMPDIR. For example, add the following 
line in do_install:append():

sed -i -e 's|${D}||' 
${D}${sysconfdir}/selinux/${POLICY_NAME}/contexts/files/file_contexts.homedirs


//Yi


>
> Signed-off-by: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
> ---
>   ...move-build-path-reference-from-gener.patch | 36 +++++++++++++++++++
>   .../refpolicy/refpolicy_common.inc            |  3 +-
>   2 files changed, 38 insertions(+), 1 deletion(-)
>   create mode 100644 recipes-security/refpolicy/refpolicy/0057-genhomedircon-remove-build-path-reference-from-gener.patch
>
> diff --git a/recipes-security/refpolicy/refpolicy/0057-genhomedircon-remove-build-path-reference-from-gener.patch b/recipes-security/refpolicy/refpolicy/0057-genhomedircon-remove-build-path-reference-from-gener.patch
> new file mode 100644
> index 0000000..af9bba3
> --- /dev/null
> +++ b/recipes-security/refpolicy/refpolicy/0057-genhomedircon-remove-build-path-reference-from-gener.patch
> @@ -0,0 +1,36 @@
> +From f584d80dc13f63119af53618350fd8262f17fe63 Mon Sep 17 00:00:00 2001
> +From: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
> +Date: Fri, 17 Oct 2025 11:51:15 +0530
> +Subject: [PATCH] genhomedircon: remove build path reference from generated
> + file_context.homedirs header
> +
> +The heading() function in genhomedircon.py included a comment referencing the
> +absolute path to the local.users file, which resides under TMPDIR during Yocto
> +builds. This caused the package QA check 'buildpaths' to fail due to the presence
> +of build-time paths in the final packaged output.
> +
> +To resolve this, the line generating the comment with the full path was removed,
> +preventing unnecessary QA errors and ensuring cleaner policy files.
> +
> +Upstream-Status: Pending
> +
> +Signed-off-by: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
> +---
> + support/genhomedircon.py | 1 -
> + 1 file changed, 1 deletion(-)
> +
> +diff --git a/support/genhomedircon.py b/support/genhomedircon.py
> +index b865a07c8..e7685545f 100644
> +--- a/support/genhomedircon.py
> ++++ b/support/genhomedircon.py
> +@@ -157,7 +157,6 @@ class selinuxConfig:
> +
> + 	def heading(self):
> + 		ret = "\n#\n#\n# User-specific file contexts, generated via %s\n" % sys.argv[0]
> +-		ret += "# edit %s to change file_context\n#\n#\n" % self.getUsersFile()
> + 		return ret
> +
> + 	def getUsers(self):
> +--
> +2.34.1
> +
> diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
> index cf32723..aa782ca 100644
> --- a/recipes-security/refpolicy/refpolicy_common.inc
> +++ b/recipes-security/refpolicy/refpolicy_common.inc
> @@ -72,7 +72,8 @@ SRC_URI += " \
>           file://0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
>           file://0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
>           file://0056-policy-modules-system-logging-make-syslogd_runtime_t.patch \
> -        "
> +        file://0057-genhomedircon-remove-build-path-reference-from-gener.patch \
> +	"
>   
>   S = "${UNPACKDIR}/refpolicy"
>   

