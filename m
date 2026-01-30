Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BC6D73EB7
	for <webhook@archiver.kernel.org>; Fri, 30 Jan 2026 03:22:26 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2696.1769743339571180738
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 29 Jan 2026 19:22:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=O0turTLv;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=6490fa592d=yi.zhao@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60U0W8pP3301225;
	Thu, 29 Jan 2026 19:22:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=fRlMImqgAS3SQVivjJRv4rNHIgjPzc9MNzogBgac38Q=; b=
	O0turTLvq7e+EG7wLGTNjowbjlxCYdkudb1jLfK4XyCDxfu939exh2m8qab7JYUr
	/ql+XG8mhPUdiPBRKZpIxINVd+aBvZP3qlX4R39fNEQ3dJNi8/oUrOrSqYTa6I2E
	fApTDJGh2u5HPkv748afIsbMen5rE/9RedzBxHuY/KVkbb+SLScctM9zqkOcx/ye
	yqXxpL7EVX35zEF+ShJ3dErmJE63s9HB1hde0byRktAN8eoX81tQcE1PGD9fwUKK
	THLmMKeTAN7PitV/XSIq+T0RBGCi+SSHbZm+4HJD7xkzzRHNaui2LV2rbLq+V+Z+
	TUphf/V+2ck1NBm4kwpccA==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4bywwrhpnd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 19:22:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X9KOyRJXMBlb/hFp9guYmYBKI0fpw0CHb0SbgGsDEiMnqasdr+v0IvSS9BKfb9Dtsk+4wdIw5KSlPXeC9MfsO/yNs6TYEHM52izLT/tcTg1QCCmiScqzlyURrENzHhI/mCGMT9ZY79tCR6A1//PSo2r/myztLNNMpqAGifK22VTQP5mY3dbxsbhGpA7eXF4I4mCRBH9URutFKYYjLC0Rkx4G7kHGrekIcHEmp7elJVeQlplvpkQFfQsmCEKyc6HyCB8oxtmQTlEDqhhPZuATm2qcgj0cw40feaZbEg8YJcZDfys3hPqzRhHSoiDWM2s1mjY7gxKf05lVDUETN+KHEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRlMImqgAS3SQVivjJRv4rNHIgjPzc9MNzogBgac38Q=;
 b=oISZ8Ms5pj4U6y9a6l85bvOOv5iHjQBmjGxvKn50RpH7fx39TyjxPEy9BH8ukxm1Gsw/dfz/44G9/EGVTqyOhg7Ej+uz6/ueqBmTsSqeJD8JuxpMw86CzXNj5a9AdoIxbkNtS5lmnemARUAlUAr2wKjZLiT7W2gfA31/bkJtsHSqLdwoGkeV+3g9AXzlSB6Fo8AmGW1Sp6WmQGg8SrFHPLlC1yGSVa9AMQb7fZWk0rtaz255RYTpwwunqx8H9tf5mC/TEvr/VHcXKvUCcLVZim9tsTTAn1dmUDHym+Qpd8nqeooTVXKqJT6BmmUNOHLH2igJV3Y8Gd19qpaZM2zyKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 DM3PPF1CFCD9AEC.namprd11.prod.outlook.com (2603:10b6:f:fc00::f11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Fri, 30 Jan
 2026 03:22:16 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831%6]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 03:22:16 +0000
Message-ID: <aae1b4af-225b-4c7b-a573-ccb3f8a04c1e@windriver.com>
Date: Fri, 30 Jan 2026 11:22:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [meta-selinux][master][PATCH] refpolicy: brctl - add
 changes to access devpts
To: Wei Deng <wei.deng@oss.qualcomm.com>, yocto-patches@lists.yoctoproject.org
Cc: cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        quic_mohamull@quicinc.com
References: <20260128150814.2273926-1-wei.deng@oss.qualcomm.com>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <20260128150814.2273926-1-wei.deng@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0064.jpnprd01.prod.outlook.com
 (2603:1096:405:2::28) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|DM3PPF1CFCD9AEC:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c46c8ca-cd4c-476b-90d3-08de5faec4c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?V256VjNudlA4TFl1MzJmeWxiL2cyTUtVQUhhYTYrMytPMFlyN3Q1UVhya0lw?=
 =?utf-8?B?WHU0c2NKNFViMTBUdk5TYzI3WEVyQ29hUEZ0MXFPelFvWDZlVnRPV0RXMGRx?=
 =?utf-8?B?a0MrZXRpN09ZZVcwZWc3VGthWjMyVXF4NFRPY0Z2Q2laOVRCa1M3NUJXbHNx?=
 =?utf-8?B?ZFZvZkFCY1FmQjdvaU4wUjhibnNiRGZNb3hleWVlTzg0MDM2ZUtUaGdiMDA0?=
 =?utf-8?B?a1VtaDJmbEVkSWJpd3RQTm95OVZDZE9Gelhhb3FrOG1YaWluVnRkZVVFWjQ0?=
 =?utf-8?B?NWc4WDZiZXpIKytMOTFZK3RMWkc3TWlnSXh6dzNwTlh3aGtDQldERGFodmlS?=
 =?utf-8?B?RGhPS1JFWEZJZmFxUkZyL0xEdFlWRHJDUVgzVU1xSUJLVituUGFSa1UrazJD?=
 =?utf-8?B?UVhCSm4zQ0FTQ3BmYXA4eWdWUWgzcDZVRVR6eDJ5N0pGak5ncENVVU1MVkVU?=
 =?utf-8?B?UHNIUW1XSG1yUGxaOXk4eHJ2anpkR3VNK1lta2FLVE43YzExT3ZqSlJZQ1lm?=
 =?utf-8?B?NG1KUVkvOC9JSXl2VjFnYXdlK1RPUk14RitIUkUrNmplYndXaHE0ckdjTFlv?=
 =?utf-8?B?NGZmV21vT2krVlMzVWdqZWRsdzlsWGc3WHVCQ3ZVdjlrWHQyTXZaQjRpRGZn?=
 =?utf-8?B?Z0lNaDhVV1dBWVVaNG05QUhWZlZ0bDRYdkNNMHNnQzNtUlVxN2lnVjhiZy94?=
 =?utf-8?B?WXlaNWhrZkNYbEtJV3g0U2hMeDByc0RiTFZpV21CSHNZaTZsTlNwUndSdFpF?=
 =?utf-8?B?bUtqMlh1dXB2aDZQeC9Ga0k2SDdtay9pYmk4MndRbFkyRkJodkRraHB4K0kr?=
 =?utf-8?B?N1BSMU1JTGhZaG9OdEZ4cWlKRFZiNFN5QitCbGNZdEljc0IrRzNQM1dhckoy?=
 =?utf-8?B?NHFwc2xuVWhXZ2xaczRkVlZ3N0dKUGZvaDhYUmd2UGtzVlJNaFE4azM2RXZD?=
 =?utf-8?B?S1VyT1lTQ1k4elVtWU9Vcnp6ZFZwcFB0RlltZUwxM25LcEhPOTd6NWJ5Y2pC?=
 =?utf-8?B?YTA2c29HTFRLaEhnN0t3bFkwL3BhSDUvcytMTGMyd2xIMWJUQjBvZlBWL2Ro?=
 =?utf-8?B?ZHBiUDRtbTR5M1ZiK0d2YTgreG8yOUEvZS93QU1IYmRQMWpXcm9YQ1B2WlJW?=
 =?utf-8?B?UkUxUUlZYlo1RXIxTkVyMk1GTU16Uk5uN0Q1cnZqK2VYSHQzR0o1TnY3MzB6?=
 =?utf-8?B?M2NJUENKeWl1UVdzajEzaXhoZWkzUXNiVFVaZ0RCMCtMSDVKbnVBZkNDOTZE?=
 =?utf-8?B?TWVCbS9LSzhsc0ZCK1J3N1l3SHJpNHZ4RnNpMEEzS1c1UzRFZGlCMThKT2h2?=
 =?utf-8?B?YVlEV0l3L2kyWjlsQTFEMnpkVk96ck9SeUpFUVRBQi85N05pZU13bzVnOUVz?=
 =?utf-8?B?TmprT3Z6bE1mSzBQeWdVYlQxTXVQZDJNWTZOWjdYUjBkSWdRcDQ0d2ZDbmdX?=
 =?utf-8?B?UlJRUGJONmF0OEVjcFBuZDRLdmV2TGZvaTUrMGlYMEFlbzZwNGVXUGVodGwy?=
 =?utf-8?B?NDE1S1RnL21OM0ZoTEpVNTlmL0gzekZMeTdxczAxMmRPZDZaVGc2WW9JcE50?=
 =?utf-8?B?cW8vR0tFK0E5bzhNaXJ1ZThMTG9WUGRQaDJ5VW1CZjRWNnViNjRSTHpHT1Ry?=
 =?utf-8?B?RWYxTm9MKy9HMTY0K2djUHcrSkFRMnA1UG83TkhNT3YyVTVPazAxMlByTkJo?=
 =?utf-8?B?anhwZm8ySk80cnpFMkNtTVNIb08zS1NtaUFqckQ0T0ZpVGZBZDJqZ3BmQzM2?=
 =?utf-8?B?R3p3aTNYVG5xMmQ5bk9PemFrWTFidkhXVGFLTkhFOWxPV0ZzKyswSWZhTytJ?=
 =?utf-8?B?Z0JOeUQzRHI5RFYyQ1Q4SlRaZ0VEK0xZeDNlbGdBZUVhTlBad1hKaDA3bE9W?=
 =?utf-8?B?RmpGWTFvODdrQmlYK0tmTHYrYWwyV2YrdlgwRjE3eS9YYUk4WkJva3ZKMnd5?=
 =?utf-8?B?Y0s5aVFLQTdRVW5sV2RQS2l5SjFYK2hrZWhNMXdtU3hObDIxRG9qWEhobUlB?=
 =?utf-8?B?ckpZUXZyTzlTbms5TlBFZWZRTFl0NlVUSGFVeGFYOFhEd1NhMWsvYkRZM1Ar?=
 =?utf-8?B?MVRrUEdnYTVnR2RVeFVLajlvaElERlpaWWtKR0F6SnMxb3FJdnV6Q0ZpcHF4?=
 =?utf-8?Q?s2h/y50XX99UHnm1cNnnfQYck?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YzZyNURjeGJCYU9LdnhVYUExT1l1OTFJNEk3emQwTWhyWUZsSE43cktSVXRn?=
 =?utf-8?B?K2dIYXlMeWp3bGlKZmx5MHlmMnhCbWtxYThlUWE4N29TMVhJdklsTFR1cWli?=
 =?utf-8?B?ZkFGU3RwbytIeE1YcTZFUU10NXZFdmQ4cUZvZlN5L0RUMlQ1eHpGQ0x3bUtM?=
 =?utf-8?B?V3dQaFhMNnNhaFFQOUdXU1p0UU1iZmxySjhSYU93RTJoTHNyU2lRaVpYbzJo?=
 =?utf-8?B?aC91RGlpenV2cVd2TWdLTnVINTJTWEt4cXRWRG1kU3IyRVhoSjRVRE1NRGZm?=
 =?utf-8?B?blpESEdGZU44Z0N4VE5NZ0dRcVZvZGNoSERTQ1FQUHF5VURmTDl1YXlpQmhO?=
 =?utf-8?B?TUFGV0c2Z1habmQyZWJqVFJncnFXWVdLb05rZzJ6bkpPTVFqUGhINTdDZGtQ?=
 =?utf-8?B?eTA1TDhvMVNxRU9vMzJ4bVEzUmo5Q0g4S1lDZjVQdjE1WWRGT2NkZGk5WFNS?=
 =?utf-8?B?dy9HYUNyRnRDOXlQMWgzVW5BK1BwYTRnUjA5NURmaEQvZ1VNMSsyaWxTc24w?=
 =?utf-8?B?L3p4ZmZWdFJ6YnNMUEZEbWltZC9vNmVkSWFlazRXYTVKbkp3TDZkZHkrNDha?=
 =?utf-8?B?TUV5RTBuZmFGVzFEOGpLVFRnYzJ1TjZVY0tyNDJWK2xlUk4yZGdKMGh3bVR3?=
 =?utf-8?B?MnByZGRwN2swL3BUV1JyckRzdm85YkxFRVB2VXdWNjN3WXladFh2bjlXNG00?=
 =?utf-8?B?TWNST0NWTTZwZ0M1R1dUZXo3aEU3d3FCZlhJeldpbnRlNmo4RzZENW9COHJh?=
 =?utf-8?B?S1ZScEhSRW41Q1ZaZ0kyUXI0enEwUWJNZ0YyaFhQUlpFMklEd3dyNWhCWTkv?=
 =?utf-8?B?UWFPUVdjdzBHTGl6Z2FXUmJJQVUxQXBsTXJKdGovUmxTZHRkTitmWXNickJH?=
 =?utf-8?B?MnI0VXJ0L2hGNEVkREY3NzJNdGxvdnMyd1BBcE01Q2VwdytsWnZ5OS9RVWw5?=
 =?utf-8?B?azl2d1pYWnpMdVVFRWFIWXA0WWZOR2dyRGVvTUI0ZHFEMWR3dUx6MHNaeS9J?=
 =?utf-8?B?dUl3M3dKTmc0akNsZDdtVjYwMzNyWmY1MURVRWlORVIvNldGZXRvMENMdkF2?=
 =?utf-8?B?WVkzNjNVK0NUN2VvblVmdlFGTDBGWWdmNFZ3ajZEMGM2Y2JCRlFBa0k1bGpP?=
 =?utf-8?B?N1k3dE5wTDRzVFYyWGF3UGFueTdIbEg4eUpyUFN4aUpRMm5oREs2ajlLNlFN?=
 =?utf-8?B?VHMrVzN1cW8zUVFPYmY1emVSTXhxaDJnalduVzg1Tk9vODBXUzRNOWhlTEdD?=
 =?utf-8?B?ZDNPYmhzMmRrU21FQ2l5WVloUEFJUVcwMmRoWUU2REtUU2lmdDVkeWNsYmlO?=
 =?utf-8?B?RTliSmV1S2Q0OHFJZ1lmS0d1VGt2V0J6OHFZRHRXZmtOU05VMnVhcGJKdXN2?=
 =?utf-8?B?Rk1QZk1MYTFUQkJJLyt1aFhiaXZiZFlOaCtQRmtKWWJ2bFp4Zm5RRUdScW9S?=
 =?utf-8?B?TGpWdWRPMHF5ektLUFR3SGEwZkl4YU5tU1ZGTjFacXhxYk9DUmxxUlFZVjk3?=
 =?utf-8?B?MFFwSEdqMkwvbFB0YU52Z0pSWEJwVWIva01oYXRTT0kxeEUySElidmpFSGpm?=
 =?utf-8?B?L1F1U1dRL0ROSFBFTFEvNzNQamc4SXdSUkhKR091NW5JQlJCb2ZmbkVEM0I3?=
 =?utf-8?B?UGVVVHhoQ2ZjaHRxdGNET3lqb1VpdmxBSVhaZWRIcmVKaFRNUTNMNFhkbytt?=
 =?utf-8?B?cmRvMUhERUsrRTBEbk95TWtQVGV6cXh3aTJ1SjhiNVc0ckJsYTFnajVWbHlG?=
 =?utf-8?B?cHpkeXFyb24xMTd6akx6VzdOTkpMSktNVkZ0VDB4d3ZzdktiTW9JWDRMa1pU?=
 =?utf-8?B?aU0xK3g1aXFFT3c1L2F3SDNwY1VYNFBVcS9LRHU3eTh1REw5RWQ5ZFNmQTBK?=
 =?utf-8?B?MnR2RjdwQ08zWjVQbEtrRTZRRktPcGNsSnlKelNpY282STRSRGVFc1U4UGpx?=
 =?utf-8?B?a2M2NkZSblQ1dHZKUVN2QkJmNXVIL2VzYm9kcUd3V0h2OFRqbFNwZHBiV0d6?=
 =?utf-8?B?Y3FDSUlDNno3RlpYNGhKUFJYWW1kWCtKQU9IV0djcFpwdDk2MFp1WkJOTHp3?=
 =?utf-8?B?OGFFbEYvSDNpRGMwSkFoQ2xOTzBSSDBoNFdLWUlNdjNEZmFuU3ZyUUlWa1h2?=
 =?utf-8?B?WXN5TDR1K25TL3ovM0VzTFlhUGtpMWJzNUZhWG1BL2FocCtLWHhuaXFSeVFm?=
 =?utf-8?B?S2REdGtvUFFUUjkwaytSZllHVHMxTTJZdDNQM0JWNXRKRllDc1pnQ3JNR0Qx?=
 =?utf-8?B?bE8xdnFVL0k5bGNrcFh3NnQ2U2poWEtwRjk1REwrNjI2b3JvVVNzNHI0bXJE?=
 =?utf-8?B?M1lhemF6LzJGcVRqZi9OTDh1Mkd5cFJxUGhaZC83YWpmdU9mZzExQT09?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c46c8ca-cd4c-476b-90d3-08de5faec4c6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 03:22:16.4829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2X7xmsb9ad7il6Bs0GMO060xBRWsBBVh4D3KQjrVS3jdLHR60N5ETNpmzjtTjNew2dTsNVZW7obERVllR2WbgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF1CFCD9AEC
X-Proofpoint-ORIG-GUID: unFYDXGxHPnkVvSJ175L9MocXrHpgaJS
X-Authority-Analysis: v=2.4 cv=KMVXzVFo c=1 sm=1 tr=0 ts=697c23ea cx=c_pps
 a=gjcLB77VbSPYcqvaeYBpgA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=Phnk5uOYO_c7CsD4PCUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDAyNSBTYWx0ZWRfX6838hS/r76mn
 kOX+IJ/VGGcH3OsOoBr7kX3DPAXdHLyHR8vFNphHIHCHeMSwGin3RdtUtW6zZN67K/M0x06LYKM
 4p3ut/+9+5MKeX2vmGe3bHEUiU0DLDuYQM7qbCz7GfZTPV+ph2p1B/AaxE4u3sEuP8ghAdvrUV6
 BV1mbFCeLYkaI4omFBcAom8LelzpgzCGf0Rh/lb8HQuCc6JO3Pr5DJOlsasITKYLltH1xf5U790
 XhYKmcytZ8q06Az37x912ZHIAwhiejDiRd+rnp24iS4pKWURfsI3C2O0CzD4Illy84UbVNN8p30
 nc5fskcPS9kQBzQnhA0ycYSvC2DkkyiL6Pb8kjr4/1XVNWoY+Dlgpd0EnyvKT2O+PC7elB/pVFy
 Ebtd8iNtW1GVEC2JGj+1XmRnaYz+LFYRnhwExsfIx+7Skgwi17yzO8SSCRKNhpOV4LjJBxIbPyV
 4xmtKYhrOMi7fKMkM8Q==
X-Proofpoint-GUID: unFYDXGxHPnkVvSJ175L9MocXrHpgaJS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1011
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300025
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 30 Jan 2026 03:22:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3147

Thanks for your patch. I won't merge it at this time because I am 
currently working on updating refpolicy, and this backport patch will be 
included in the updated version.


//Yi

On 1/28/26 23:08, Wei Deng wrote:
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
> ---
>   ...cy-modules-admin-brctl-access-devpts.patch | 39 +++++++++++++++++++
>   .../refpolicy/refpolicy_common.inc            |  1 +
>   2 files changed, 40 insertions(+)
>   create mode 100644 recipes-security/refpolicy/refpolicy/0057-policy-modules-admin-brctl-access-devpts.patch
>
> diff --git a/recipes-security/refpolicy/refpolicy/0057-policy-modules-admin-brctl-access-devpts.patch b/recipes-security/refpolicy/refpolicy/0057-policy-modules-admin-brctl-access-devpts.patch
> new file mode 100644
> index 0000000..cc6abd1
> --- /dev/null
> +++ b/recipes-security/refpolicy/refpolicy/0057-policy-modules-admin-brctl-access-devpts.patch
> @@ -0,0 +1,39 @@
> +From 43ef3db9bc4247222d773bb24da71352bf84f4e5 Mon Sep 17 00:00:00 2001
> +From: Wei Deng <wei.deng@oss.qualcomm.com>
> +Date: Tue, 20 Jan 2026 08:28:45 +0530
> +Subject: [PATCH] Sepolicy changes for brctl to access devpts
> +
> +Resolve selinux permission for brctl tool failed to launch in adb mode
> +with enforcing mode enabled.
> +
> +Below avc denials that are fixed with this patch -
> +
> +avc:  denied  { read write } for  pid=1407 comm="brctl"
> +path="/dev/pts/0" dev="devpts" ino=3
> +scontext=system_u:system_r:brctl_t:s0
> +tcontext=system_u:object_r:initrc_devpts_t:s0 tclass=chr_file
> +permissive=0
> +
> +Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/43ef3db9bc4247222d773bb24da71352bf84f4e5]
> +
> +Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
> +---
> + policy/modules/admin/brctl.te | 2 ++
> + 1 file changed, 2 insertions(+)
> +
> +diff --git a/policy/modules/admin/brctl.te b/policy/modules/admin/brctl.te
> +index 026b0002d..45ca94c60 100644
> +--- a/policy/modules/admin/brctl.te
> ++++ b/policy/modules/admin/brctl.te
> +@@ -23,6 +23,8 @@ allow brctl_t self:unix_stream_socket create_stream_socket_perms;
> + allow brctl_t self:unix_dgram_socket create_socket_perms;
> + allow brctl_t self:tcp_socket create_socket_perms;
> +
> ++init_use_script_ptys(brctl_t)
> ++
> + kernel_request_load_module(brctl_t)
> + kernel_read_network_state(brctl_t)
> + kernel_read_sysctl(brctl_t)
> +--
> +2.25.1
> +
> diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
> index 59dfecd..4af7f43 100644
> --- a/recipes-security/refpolicy/refpolicy_common.inc
> +++ b/recipes-security/refpolicy/refpolicy_common.inc
> @@ -72,6 +72,7 @@ SRC_URI += " \
>           file://0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
>           file://0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
>           file://0056-policy-modules-system-logging-make-syslogd_runtime_t.patch \
> +        file://0057-policy-modules-admin-brctl-access-devpts.patch \
>           "
>   
>   S = "${UNPACKDIR}/refpolicy"

