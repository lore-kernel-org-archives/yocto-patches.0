Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB174CCD195
	for <webhook@archiver.kernel.org>; Fri, 17 Oct 2025 15:56:01 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.19702.1760716554397493891
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 17 Oct 2025 08:55:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=GkOgIrkt;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=238560992c=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59HF1qrp3619957;
	Fri, 17 Oct 2025 15:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=wRE1qk4xSVXl78REzxBbir9hQi1aPtebTv0v6IuDcE4=; b=
	GkOgIrktxpys7N3AnyYTHvYmlE5THR2pK8a8XJf1r2VQByQ7cxAmNGxwP2xMqE8a
	Pb5Uxjz3zAfZ2hiHChhRqOcMMFBBa+JHff2y01Et5+CG+FERE9HKDsD1kJHYX8bn
	9CbJt42uXfpUaTAFRqbuv4G2eCnYd4NjFSHEzQkhOyZWEjIcsL1+FXKREr/5es60
	7EkhdDjhga7EchUIwk9YZUHYF70uZWNJnzS/jKtqWzSZh+eRKpv0NaKcJPzoByD9
	YZLfrEhqwNPwk++IAwgF+xLkEAerFu/KOTqgt3t7w6TkpA8CHtWph/GRcIQW6swz
	MECUaklcKJiIZJUe5bEw0A==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012013.outbound.protection.outlook.com [52.101.53.13])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49sthhcarp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 15:55:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RU1GWvIXLqyYIvbUpoucmlGRXGgC7OVDRfaFu2wpudoxbMZNtoo3XkcvyNkS/BXrau90Oj1R/IkvTfUGzfpoCBrpgJ9U9tOjwMdYKwVAu+TgBT/zbDevusytBhjbr2a3WTjjOPm14ihgYn+xY/ZO22aDTVIu1iMENwuhAjxrUSC+uWLBJ99NL1uvVmpoKzloDiuDRVgakFDYcG8nsh6563YcOF7y4eF5wzk4923bV8KXe4toIXB+vxGofbUtJeeswi++hUh7XTvFSWydRkmqZ9IFt5RnuDRhVc090fYhrSmCj6JggnMGnbNrNcVecXipZt6UurNUX1JTx8G475r8Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRE1qk4xSVXl78REzxBbir9hQi1aPtebTv0v6IuDcE4=;
 b=SHpdj1uQKebJzZQDbarHI875Njp38odbB1z1GbOFUHrrAggK2qajpdetdPnRBk7wfRbhd+INQ1/tpgZkj7sZv4vnjVDTXQ2b7doCzcCMbn63CucnJvYm0uR2DueXLqKC0jRhISgaJxSp5CLLoGrMex13CiFhgBMEh8k022DxSzAjmJOaS9tUOyYiJjZR9rRDGghoAkq3r0HLPagURpTQ8/HY80DqNQjJPM6air2LgAgynKdpnQMiiJT5jqZCTmS2bX2WKguDMoKzm3SmXzfSW0+97nW4bhhIFHUqT6hRVcl5zcKxmujtCD1aAYpsbXyLFszHvXpwMn7XdwaWSlBj2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 MW4PR11MB8266.namprd11.prod.outlook.com (2603:10b6:303:1e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 15:55:50 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 15:55:50 +0000
Message-ID: <63498285-1222-4dd9-b9ae-d706046d065c@windriver.com>
Date: Fri, 17 Oct 2025 23:55:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-selinux][PATCH] refpolicy_common: Skip HLL
 module processing for monolithic policy builds
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
References: <20251017042419.3307354-1-quic_sasikuma@quicinc.com>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <20251017042419.3307354-1-quic_sasikuma@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0353.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::10) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|MW4PR11MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: 26a4cddc-cbbc-478c-84d9-08de0d95a4fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Q2xFWGZMeXpYbVZ6WDhoYjRFUE5nbTREZWxGd3J3TVNyaVBsRjZxV3RYcXE0?=
 =?utf-8?B?V3FCNTF1a2xyc2tTOWF3NmgzRndQTElKak1IQVNRd0Q0OGsyT3ZpMXFweWRr?=
 =?utf-8?B?M2hLSlh5QVhYVElWckxXNllLTVZIdnI5c0gvY3kxb1JJZSt1Q1pLZHFMTU52?=
 =?utf-8?B?c0xYSVphUUxQZXFzRlMrcXJ0WDBsMjJKaUlFZ0IrRFRqVGhQRXNnSmhJK2kr?=
 =?utf-8?B?cVloQ3ZtamE4dEhoM3Vvak1wb2ZnZVNCWk84Z1RqTjM1NXVRMzREdVdnWEFH?=
 =?utf-8?B?aXFDdTcxVzVld0hocDZpUUxEZXFPaHZnVHZTbFN3UWNiZURDRm82aFA1SHpS?=
 =?utf-8?B?K3Jvd2hicjlXV3R6ZzQ0NXNZUkNpdE11bGlpMTdPRWgwYmptd1Ftc253bzF5?=
 =?utf-8?B?YlR0RkpNMHNJNm1nQWJ0aHhVdjByWXlKVFVuaWs4UDh6K3YxVUZtSEpLZS8v?=
 =?utf-8?B?cFYzajIwQ29mckZiMTVDeHFpdndnNUpKUHhoUVBCY1BVSms0TjVkZkVPdFI5?=
 =?utf-8?B?OWtsWFB0NlNUbjVYSlJvd2gySzc3Y1pRVGE1OXpCRFQ4WWgySFdwQ2VOTGN4?=
 =?utf-8?B?a2FUanJTT0VERjFsRFVlTjVWL3p1ZHN5QWw3cGxiWmtNa0Y0ODBQR21qb2p3?=
 =?utf-8?B?cER6elNWeFNGdXpyTjJYUHlacEFqNXJqV1dva0FlazlUYXVCMzN3c3lSbWJy?=
 =?utf-8?B?SmVjR09ZL0M5SVpoa3N1N0UxTUFuUURzRis1Y1N1Ymp6L0RqNXVWTUxnVlNZ?=
 =?utf-8?B?bUpscElub0pSZCs0Q0g1SFBqZVZKNWQyVU1nQ3RYZEpVU3RJL1lIb0tBb0dH?=
 =?utf-8?B?RGlMcFhWNEN5RXZkeERmRW4zV1E5blpRU296bmtjbGY0UWVCdjFSNGdPZHU2?=
 =?utf-8?B?NVdVREZrZThJVzZqY0FEUXZ1NFBSS0IyNVhLc1FmQWRiV2xwMG9tNE0vSDdP?=
 =?utf-8?B?MmZYNDlJWDhEY25YZWVkeGlnWDE0VXNMNWpPVStOZXEzL052N29OaUJyemVM?=
 =?utf-8?B?Z1ZiSzBCb2Z6MXE0UUdoTTdoUkFpeXB2WVNzd0FSRHZNUXpwWUZub1BEMVAw?=
 =?utf-8?B?TldTSVo1U2VzM0dnUlUrd1VOV1VGd3JlY0VoczJqV2JJMzdxT1V5Mm9ydWpC?=
 =?utf-8?B?VVhoTWZpRVFFc0hmbWpHQ3g1TWozSUlSb0FhRU96bDMyVzUzZ0s5aHNLTTVz?=
 =?utf-8?B?QUZ0VElmNHZWQmpmNnZST3ZEREg0b3czSkpRNkp1TFNZbkFjbjc5ZzM4QlR1?=
 =?utf-8?B?WW0zUFVvZ0N2d3k0bDY4UTVYZ1VyQ0ZYc1VxUlRiSjhxQlA1Y1BXWG4ybVhL?=
 =?utf-8?B?K1B1aHcrOGtDaVVJV1plNzVER082bllnTmZQemNGVlZPZXpoeHdGa05kZy9X?=
 =?utf-8?B?OTIxQ2F2VnduSHVQajJWdzAzWjFSaUt4Q0x4SkVpUm5FWm5jZzBWc1VzVGpN?=
 =?utf-8?B?dHk0WEk1UkxSemgvakhtZVpOb1FNUkJyM3hBRmdQaVI1SENaY3J0VVN2OVRV?=
 =?utf-8?B?dG04dGlPSkFWNWcwcXRDM1o5ZDlwa0dEQlZoSHY4Mlk3dVF1cy92c1dUNnhL?=
 =?utf-8?B?T1ZCSGlHNlJncGllL3k2dTZVbVQxL1NxV25OelVhYjFCWmR1QUUwbEh4U3o0?=
 =?utf-8?B?NjBHbSsyTVNyT2Q4RDNtcE1MekJYWi9LK3Fab1hVNWcvNFAvNXI1c1VoWHFR?=
 =?utf-8?B?NHIzR3M2ZGZIbVVMMmx1a3EyYjgyUUc4b05qVjdVMDM3MWVoZlNFZlVJQlAx?=
 =?utf-8?B?eEJBTTFISTZSRHpzaXRGdFZ1eFJwVTFTdlZlOTI1bkpjVEloWjJ4SWt4QTFY?=
 =?utf-8?B?M0N4Y3ZiczErMmtqSEVYUXh6c0dUaWk4Nmp4TkFFOFloeHY5VDlRdE1vOFR6?=
 =?utf-8?B?dzJlQk1CK1gvUjJBdEhuZFBtYjBGaVVXbnFXbUpaUFFoeUt6OW1EQnRtVzlN?=
 =?utf-8?Q?SjqpiCII7wxZktJUN2JNAg2ZSwLojqEJ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?LzRvV3ZhczZIT0hGeUVTQ1ZiNTBFR3NYWlNNUm9yeTk0cEFBcmxrc21oT0pV?=
 =?utf-8?B?V3pJLzVlbmV0eTZ6dzFUeEZJaTNPN2pOOVBKa0tSZzkyYlA4Z0pCQkI3ZURH?=
 =?utf-8?B?ZUVUcUdOeHJ2eUdHbFB6aEoxSjU1Um5wQ25KOVlFbk02bWVGODdoTDdBOVlo?=
 =?utf-8?B?NnExNUFKS0RPTWFUQlZEVEZmZnBXZGp0WDJvU3d1MEc0dm0yNzdWNGZMRHhF?=
 =?utf-8?B?TFdHOXNIek1pWXlJbUs3a2o1M1dBRGRyNUc2ZkZJM080d0tHNFk5WjlhbTU4?=
 =?utf-8?B?U2hpREJvT21qU3ZBNSs3bnVUbTBoSFhEajZQVnphVkJCaDhrOTUydWhxL2xn?=
 =?utf-8?B?K2Rxa2FQWjFzcTFzbkEwTXNKSDJJT29jYTMrMGt5UU1LTDVpRzlwcFdFRjNG?=
 =?utf-8?B?V1FkM0M3Ylk1VGFjeXVnWThnRG0xcjAxbm1tWUdWMWg5Tjh4UW1EZ3hUdGU0?=
 =?utf-8?B?QjU5blFSM0YvQnNjZGVwTGFzR2JLbUtma3lPYkJYUW9SUzZhTHZ3YU1pSVZX?=
 =?utf-8?B?TlNZQW00WEVhakZpTnM4dnRFd1FtVzZUeDU2TFowTlk3TUlwNk1ZdXBGeVFN?=
 =?utf-8?B?SS9WL1pPY3dlTGhCdWlSMUxId292enBkS1prbWJodHhFeU1mWmYrUk9YdFZQ?=
 =?utf-8?B?bitRRzYyZm5mY1hWMmhDSkt5WURpMEk1dGV3bGh5ZjN3Y0FCa3U0T3ZUSnhB?=
 =?utf-8?B?amFEUlZyT2x2bmdXblp3M2E0NVVhdGpLdldGSXpPOXF2czgvTTEycnA4MkZm?=
 =?utf-8?B?Q0xBVEVWUlpOQ3pWL25sUFh1OHRUejcyNnZTbFpRSHZMV3BxZmVIMGYwUnJ4?=
 =?utf-8?B?eGgrdEhvZysxNG0xTjNGM21CY0ZhZmxXbEtIeVhObEtkQ0t0RmJoeEJTbCta?=
 =?utf-8?B?d1BtRjhseUhLbk1QcElxUng4WWRGbzBNQ1I1U3hyOXhsdGdGajFtK1J2aVZt?=
 =?utf-8?B?Vms1cjBKaTVoSlR5MjQyREV6L0pqZUxjdVNSU3oxNXBtM1UrdzZSN1o1V3RV?=
 =?utf-8?B?TFlmTEp2SmszNzRPeXpmWWhIRGlCMG5YRERRUUVnc0pnV2sxUitBaitsT1Mx?=
 =?utf-8?B?eHB5bnNvQVQybXZZS1RRL3JEM1dPTGxJMU1qdG55dS9adEQrcUxLU2FYMW0z?=
 =?utf-8?B?ZjgvVG4rdnl2a0w2QUhWWVZjQWl6Q3pKd3B3RVg0RWZLcVVUYmFLWjVCSldK?=
 =?utf-8?B?dTFoMnVnRFZjOXZyQzNyQm9mYzhDVEppNkpMZFhHUXhQWVNIZVdoWVpyTTBu?=
 =?utf-8?B?blh5ZGxMdGdBbFlMM2tNY1BaZ01VOHZQdHdwYWlKa00xM2FxSTdoeDRZekpv?=
 =?utf-8?B?TmNwY3I1ZE5OWHl1TlpOL2crdU1wa204ZVdYM2IrMzNvNWZDWHIya1N5T3Yw?=
 =?utf-8?B?THRFbXdWYkxhcTVsNDRxNVFkNkdZemxIZkRoV1ByZEJFQTkzV3M1Y28rOXFz?=
 =?utf-8?B?UWhKR1BXdDZGOUVtR29ma3ZHc3NOVTlpZlVOby9oSjRhN0ZiWlNudEozUjZM?=
 =?utf-8?B?MHpkZjI1dGN4K2Nod2cwekE1LzIrWEdJRGJyM2MzRTRid0haK1VJbGpVaUYr?=
 =?utf-8?B?TU5tWnFIbGlwVFlHZW9tdUFEeHlrTURoYjdjeUhYQnlKeGFBem5RTi9ja1la?=
 =?utf-8?B?TlhLRFRtNUkzUjJ2SmQ2bUNkWGxCc2x3TFJmOU9xRDJZOWJoOHNWR2FxWStK?=
 =?utf-8?B?SWpEMlprTjNqSmxWcVVDQXV1d1hWdWQwS2czUGZCK2xSUU9nbDJyWnVEbzZS?=
 =?utf-8?B?L2QyZVFlNWt2ZytqVEwyZmFxRGwralZ6MkJqTVRVamNJbHQrTXJtc2ZnaVZI?=
 =?utf-8?B?bHVweDJJYVN1YUFzODIxV0g0N3QyVHVSd0xvSVpuTUFkYndPeFlHeUZoUkM0?=
 =?utf-8?B?VHMzNTc5L3dqc1pUMzk3cmY0R3A4c0JrTTJaaEQ5WUNxSUV5cjJtaTg0a1Ev?=
 =?utf-8?B?UVVLK2JrTmFlWSt2b0krTUdqNzNCT1ZVQTR3KzFVTWNmT2FBcUFvOEtzOVpC?=
 =?utf-8?B?blliWE9QUlUrZUJ0aE9uOTQySVBKdVQ3UzhBWFdkS2t4emdlQ2FNU0hvajlp?=
 =?utf-8?B?VnprTThkZW85b2dXZVVaa1M4ZC9mNWYzMkNscC9Bd2szUXFKUDNTTGZJZHZV?=
 =?utf-8?Q?U0hDwx2/SZ8xl4jj/18owFCR8?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a4cddc-cbbc-478c-84d9-08de0d95a4fe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 15:55:50.5887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lph36EMIst0mwaAFEPsCMPhqmZti6vdohezJVJU5JQ6FI5tTCzGFLSwu5nzpvyCNKarZC1IV8DEjk6ihh2damg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8266
X-Proofpoint-GUID: DWYCxkNqIqlrReqehM_3om3sPbBg9DAg
X-Proofpoint-ORIG-GUID: DWYCxkNqIqlrReqehM_3om3sPbBg9DAg
X-Authority-Analysis: v=2.4 cv=QLBlhwLL c=1 sm=1 tr=0 ts=68f26709 cx=c_pps
 a=UidE1AiM3qFEYM2TBOftzg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iGHA9ds3AAAA:8 a=COk6AnOGAAAA:8
 a=k3OF_JfcUK2G-7nlJu0A:9 a=QEXdDO2ut3YA:10 a=nM-MV4yxpKKO9kiQg6Ot:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE3MDExOCBTYWx0ZWRfX8R3oKU1BeH3/
 NueT1IcFuGudzza5t/TEVCSYROYUT7z8myEHjK08vpuMWX3gXX8KXea9ZSEyfwACg7q+/uW1eyO
 J0MJlm/IyEvTpb8rHqKxYxeCmt4mAtNj8xL+FZ/KhaU2sp4inS2cRVTocnyp6aRj13AXpCs66o1
 8aTMi2lWVAkd/Z4lN625Bvs8VO3bVNoQ4dtZoxnaflGkdccTf9O2pY9l0xgBFvff7cjZ5gkIk29
 yC4bHJUf0PBSQKqBZ19X0zz2qqPo3rpuXgeIoY9z2cN0X3S2bgIe0VJUpFeo07u9hB2wc11h7b7
 LoHigFkczvS/SJ3GOZQ7qANa228dHX51echYcZCeLV8JKxF1fhQBwkfJOafb5bsfE0mo4OGZjnW
 6PjPRd7fO4Nm/ttNCbmHTemfUSJZhw==
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
 <yocto-patches@lists.yoctoproject.org>; Fri, 17 Oct 2025 15:56:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2351


On 10/17/25 12:24, Sasi Kumar Maddineni (QUIC) via 
lists.yoctoproject.org wrote:
> Avoid processing and copying high-level language (.pp) modules during do_install
> when MONOLITHIC=y is set. This prevents build failures due to missing files in
> /usr/share/selinux/targeted, which are not generated in monolithic mode.
>
> Fixes error:
>    cp: cannot stat '/usr/share/selinux/targeted/*.*': No such file or directory
>
> Signed-off-by: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
> ---
>   .../refpolicy/refpolicy_common.inc            | 33 ++++++++++---------
>   1 file changed, 17 insertions(+), 16 deletions(-)
>
> diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
> index fd41f8a..27aac44 100644
> --- a/recipes-security/refpolicy/refpolicy_common.inc
> +++ b/recipes-security/refpolicy/refpolicy_common.inc
> @@ -173,22 +173,23 @@ prepare_policy_store() {
>       # Get hll type from suffix on base policy module
>       HLL_TYPE=$(echo ${POL_SRC}/base.* | awk -F . '{if (NF>1) {print $NF}}')
>       HLL_BIN=${STAGING_DIR_NATIVE}${prefix}/libexec/selinux/hll/${HLL_TYPE}
> -
> -    for i in ${POL_SRC}/*.${HLL_TYPE}; do
> -        MOD_NAME=$(basename $i | sed "s/\.${HLL_TYPE}$//")
> -        MOD_DIR=${POL_ACTIVE_MODS}/${MOD_NAME}
> -        mkdir -p ${MOD_DIR}
> -        echo -n "${HLL_TYPE}" > ${MOD_DIR}/lang_ext
> -        if ! bzip2 -t $i >/dev/null 2>&1; then
> -            ${HLL_BIN} $i | bzip2 --stdout > ${MOD_DIR}/cil
> -            bzip2 -f $i && mv -f $i.bz2 $i
> -        else
> -            bunzip2 --stdout $i | \
> -                ${HLL_BIN} | \
> -                bzip2 --stdout > ${MOD_DIR}/cil
> -        fi
> -        cp $i ${MOD_DIR}/hll
> -    done
> +    if [ "${POLICY_MONOLITHIC}" != "y" ]; then


Please add this change to refpolicy-minimum_git.bb as well, since the 
prepare_policy_store() function in that recipe is overwritten.


//Yi


> +        for i in ${POL_SRC}/*.${HLL_TYPE}; do
> +            MOD_NAME=$(basename $i | sed "s/\.${HLL_TYPE}$//")
> +            MOD_DIR=${POL_ACTIVE_MODS}/${MOD_NAME}
> +            mkdir -p ${MOD_DIR}
> +            echo -n "${HLL_TYPE}" > ${MOD_DIR}/lang_ext
> +            if ! bzip2 -t $i >/dev/null 2>&1; then
> +                ${HLL_BIN} $i | bzip2 --stdout > ${MOD_DIR}/cil
> +                bzip2 -f $i && mv -f $i.bz2 $i
> +            else
> +                bunzip2 --stdout $i | \
> +                    ${HLL_BIN} | \
> +                    bzip2 --stdout > ${MOD_DIR}/cil
> +            fi
> +            cp $i ${MOD_DIR}/hll
> +        done
> +    fi
>   }
>   
>   rebuild_policy() {

