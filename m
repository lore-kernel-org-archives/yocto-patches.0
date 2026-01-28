Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1D7D25B49
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 12:01:02 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11640.1769601652312491728
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Jan 2026 04:00:53 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=gT0BXGAM;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=6488f9fe8e=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SB2cfh763255
	for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Jan 2026 12:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=QnynKvQTLvbNg5W7p+LJrLpu6oRYnxlHt5+eFrLUC3E=; b=gT0BXGAMIcY5
	gUOjVqbmO5cUWe3eWtgcPNSyBU1SmNW8N0QhAmTGZHOslywUZZvlmFm/D3i96oFf
	/KiFK125O09ProO0xbGZZ4zc3wEMIXRfjKqvn9XL7hrUYGuStmdbQ97PdwGw+jln
	tZEtblqh4K9ca3IsL0Kv6wilftEqY882hhdjxx4BSjAvEtGyariQTI4r2WXWMJWB
	yjFUEmTfLqfpcyYeCrvX2NTf+gVe7mWj3ET2ts5e5EwAgvda94f8ON0USGdrF+iF
	m3CtRG/LicZBTm3DJh2TlRFg/XLnk6Jy1khFIVHA04na961K6wv+03JiUUf6VVVZ
	fCfJ1Lxjlw==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012013.outbound.protection.outlook.com [52.101.48.13])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4bvn28cyhu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Jan 2026 12:00:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G90KsTlPfSqU5W8i9MF6B72CGwLe8pTfdd1VUTHiQXrJeluqukNwNfDj1LZCCdYijjMzFPXwA9eRo8lnwuEKcoqo2fw+QdaMzdED+M6DOcQOvhvikeb51n8D8CTWScSOvm3n7uCb2rBqaV91Lf4cc+II157ubaElYOe0UDkLsnboGIa84HSFeU2Eil8JYPq39ATDWrXEi7Wk3lH1QR4xNJAxmkZSO7Ygeb0apuI7Hw1eyvEGIFryG3RVtt7/tJgGUjlK05y5/AmPDOUk7Q7WaB999FkZgOi3wMai8//HHLQtYHLUd5CqDHoov11j6hecjqBIRvmjh0Two8G1O7ARkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnynKvQTLvbNg5W7p+LJrLpu6oRYnxlHt5+eFrLUC3E=;
 b=VyJD7pu4ZOCpeHA6PHhZOPD9V4+ePa61hQoTY9uK93XsiDLi6VU0OYN5vKGclUIg9RrOAei5I1PnkXhxNWJrPys/sU9IucN5+nb9lvhI0Qg7BXqHSMoe0o8kSUzWc/UWdRZsMyliVCdS7N4h4pkAeEsgEp7KldA3lRMQg4hdWTsUVB3IPnQsXff4RXLniiOeBPrORzaLXHAH80ESrvqOD0v7MeOu7fDEFnydG3fns8K1PlntML3qtP38Y8LryyywqmYUKWDDNy5ExdVor/+UCOiy7BdaCI8L2qFjh76MphNX5vy8BO1aJToc7kqiNte8x25U2j2aeCN6O7WDetyRbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 CY8PR11MB7687.namprd11.prod.outlook.com (2603:10b6:930:74::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.15; Wed, 28 Jan 2026 12:00:47 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831%6]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 12:00:47 +0000
Message-ID: <0b4d6f99-36c7-4224-9020-a1e6ad85d0d8@windriver.com>
Date: Wed, 28 Jan 2026 20:00:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-selinux][PATCH] systemd: Explain background
 of creating /var/lib/systemd/backlight
To: yocto-patches@lists.yoctoproject.org
References: <20260126153729.2758442-2-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <20260126153729.2758442-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SGBP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::18)
 To DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|CY8PR11MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: 93daffd3-7791-4476-3807-08de5e64df69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Z0dBa0V4RDhIQkx0bHdGSTBNcmo0NDhoZHN3MUVKbFZTS01kRWJISVFSbWxk?=
 =?utf-8?B?bmxGTWNyQXlwUE5oY04zaEtBODdFNldmT1IxL1VURWRtYWJLdDd5V1psZnh0?=
 =?utf-8?B?ZjMwaEtvcnhrSGtobVA2RnVYZXRaM2NZdThiOEJhT0N6SmFSdEg5dTRZejl4?=
 =?utf-8?B?azBlY2NPZk1mWjlRVFU1d3FjYktlUEt2OUpmNWhKV2pBU1RzdlBJZi9mZW5o?=
 =?utf-8?B?STQyNHhHK0NaRVhHazYvMUcvUGV6TlBLTXFsUyt2SVdYY2xuY3haMWpla1JY?=
 =?utf-8?B?dWdxb3ZWaURIZ3c3T3YzN3ZGV2pIcXpZYVJMVTBDczJWajFIRzJ4K0hYQlVW?=
 =?utf-8?B?aDVzWXNJeDZmQ3ZlY2xtR1QzQ2RqMzlScTlUalhzUW5LSFdROU93R1NwM2Y4?=
 =?utf-8?B?dFhmM1pzSlRKUEQ3VS8rVFNoS3c0ZFJVSmJrTTA1MFQ3VTRXbkIwdlROcDVi?=
 =?utf-8?B?b0hOc2xrOFZDQTlkSTRRN3FFN3ZqQW13c1pnWldoQ1FDTFl3SHRkTTMxMkdN?=
 =?utf-8?B?VGZqR1RCa1FFN01Pb0lFMjkySjZ5TXYyZ0JKSFFPQnZIMjhMdXdqTjZZTENX?=
 =?utf-8?B?Sm9ibzRacVdOVlZyRng3OVd0TmFRRXpoWkR5eHhnd1c1RXBxN0F5STZsc2Rk?=
 =?utf-8?B?Wk1tN1haNDBXVzlIb0hRNHR2UnQ1U1dhT2hLMUI5dVlKQXlNUS9VZ01tYXZH?=
 =?utf-8?B?OGhXdEZHb3grMzdTSktMWEF3UVV6dTN0dUlxaGsxNjErd1NSQkVIOWh1TGla?=
 =?utf-8?B?YmRIR0Nna1lETFpTRW5QK3ByS054ampFOWwvZDQ2aktDUEdpWGZScklJL1pi?=
 =?utf-8?B?VEtaMGJySldYbHczeFlaaGsyaC9tQm1hcmprTGR5OXQrYkw2b3pmWG5CZ0c1?=
 =?utf-8?B?alQ3Y2tQNTBSOGJodVRsMWFkYVMvbTFrRjlmUUcrNkNJL3VFQW1CSzk0Q2ln?=
 =?utf-8?B?dWNGa0hDT3FOZnpEMDdsMDVyN1p3T21wWm5yeUFTTzljM25mNUNJZ1phckxx?=
 =?utf-8?B?elo2cmxlZ1lzbGIwOVVnT3FrNGhrR2lsSzdnNDZhcFBCek5FN0N4dlhxRCtO?=
 =?utf-8?B?ZXVuQ0w5YjNtVEJackQ5WU1TZ1Z4Rlc1aG83N0tia29kRUdGUm1GNzZlN0pJ?=
 =?utf-8?B?VUZCQ0NXcEtwNEYza2ZsenVGbFJ0VXBNN0VmV3ZaakFlMmUxT2liSDhFYXZQ?=
 =?utf-8?B?RUY5QktFblFTWktPRjkzeGRZTWlVYml1dWtkYlFteGluZVVCYUhxaUI5YkZK?=
 =?utf-8?B?T2FOdWozL3NpOGY3SmlKY3cxMjlBcVFIN3RjMzJkeUZvNUVpVm9mNksrc1Z4?=
 =?utf-8?B?eWFsc0E2cUYvMVZBMkVLaFh4Mm1iMityWHFzQkN4cjZkZXVSQmU0SkMxSHMz?=
 =?utf-8?B?R2tpK2tON1hvWjdGY01FdGZWRGJsblBDMVlMdVJiYXBzeXYwLy81TTVidjh4?=
 =?utf-8?B?V0tTVFgyNWlwUVhYY2dMRzRyZDNJbzBRTUh1T1JPQlBqMDB4QUxKYXBwaElk?=
 =?utf-8?B?VVBqM05DWU1QWmVtbjF2WXZaMXl1V2ZuSlQwbG1GQjFwcGU2TEFnRU51Y3pG?=
 =?utf-8?B?U25ST0M3cGY1eEQ5MFNGcjRnT0VFTDVCT0dwa2RrNWtZN042cFFPMEdUT0lj?=
 =?utf-8?B?cWdIakhJVjFUaE9rN3dVeEM2bHNFelIrcE5zZDJkMkJDV01vZ2gxSXRhS1I1?=
 =?utf-8?B?RUtValZGVms4Zm8zN1hDNDdVWm11bHZwVUdrbVNic3Rwd01jWmxxOHk5ZzN5?=
 =?utf-8?B?cTRaN2o1L0tJVU02cmp0enpNakxKMGpyTi9nOFR3MGZqTWd3ZDdaaUtBSkR5?=
 =?utf-8?B?WUxvaGdvU0pDMSs4UjBlVUc2YXgwOGE2eTM1UTQ2bjVCQXFKRUpoNEgwQWN0?=
 =?utf-8?B?QytLaFBjaDJLZ0lVYXpwZXB0eVJyVU45VVV0WU5EQkY5d1hiSHMyVWVLb3Jy?=
 =?utf-8?B?N0ZHcUt0Y0tqQmIwUDBTVlExaUFVN1l6RGhTU3Y0b3RXT1kxZ2RjYllPKzJx?=
 =?utf-8?B?bjd0MnFxSVgxZHB5dHkyOWEzV1hEeWREaENRK0FibzdJaEdrR2dUc2MwZ2g5?=
 =?utf-8?B?MVpxcUNpQ2x1N0VnaWRJUHRzcDJjaU5hWklLZjE5eUQyUnBaeTJFaW5GMFND?=
 =?utf-8?Q?pIF0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K3FZRmtiZi9PcC9WNDByaEc1dXVtZjVxTmFZL2xibEpsOUxwTzVVNUJHNUkz?=
 =?utf-8?B?eitZbEF5ZWZ4MWR3dDhNQy9GZ1JDdkh5RVUvRC92VnVBVXIzSjk3QlhibjBP?=
 =?utf-8?B?T2xnQ1RnQk5Gb3lIWStHd2dqMFVaelBqa1I3ekhaSUFzdnJReURnUTJrRjVY?=
 =?utf-8?B?bE5vMk1oK0FWc09BYjNzaU1sV1RhRGRYSHJ3UFZOOXg4Y3NoU1ArQ013dkZp?=
 =?utf-8?B?SWJad0Y4V3VjZzF3NUVBNjJ0TDdmR0pmSzJXUitZSFA1VVYxZ0gwemFEV2ha?=
 =?utf-8?B?UFZmajVZT2twc0RsWEhQY1pjbkk0d20vbnlPRjBSVDhvNVcwN2pSY1d4ZlB6?=
 =?utf-8?B?Nm9PN2xld1RKRGhFUGtFMlJzdlg1K0YwdWlJci9wL2djVUsyWVV1VFhtNmxK?=
 =?utf-8?B?N2wwekNkRGd4MkZMQ2wwcElLQzM3cW9QSCtseHFBaUZvTCtURGtZRHVuNVJn?=
 =?utf-8?B?aXFuOENJK3E3OUloTERpdUE3ZkZRaTFmYTBpWmpWeGlZU0FGY3pucVlEVDMv?=
 =?utf-8?B?ZUFVWlVodVBRcFJwUXJDKzVqOGI0Q3hlbVV2MElVemRrN01Qdk8xOGYycm1P?=
 =?utf-8?B?ZUZMWURORHB2MGl6bUIzN1ZhUnF0VnE1TGJKVmRtTEsrRWRPam8rWEdEeUdF?=
 =?utf-8?B?MGFXQUQ1UkViODZyR3E1VjFvV3pZc0ZmK2I3bG5MMkNpTVNrMmZ5dEhSdTJn?=
 =?utf-8?B?dWlHcXpjQ1pxREJNbmFmSEFzdWxaSCtLeFhEODFKaU5MWHpCTTZncEp5ME0r?=
 =?utf-8?B?VlpyZHBRWndiUzFNSU9FUjhGNWRURUlMZFhvVVBrNzlQUWRuaGExVE1FWFhD?=
 =?utf-8?B?UGkxMGpCK3ZXeCt4NEpFZjVSUkxqVXBrQ01EaHNpNGkvcTBNZWxrbm5aeWJz?=
 =?utf-8?B?S1V4bmN1amM0T1NwalhmS0ZIaS9tb24zMEdwNlFGbXRpZTAyV21tTGFxOXZi?=
 =?utf-8?B?bGZIOU1ocE02WW1ONGNzVDJtQUhMQ0NKejhTSU9JU1J0UkpKQnUzRDVxWk9w?=
 =?utf-8?B?OXBzdzA3bGpOalRNb0h1WTVGWnVHanhBTkZJQldUNVBSVkFEREhKSy8vTVhw?=
 =?utf-8?B?UCtqc2tBd2tuOVgwSzJISGxBVUVxbDJwaVp5RjRISnp2ZUhrcW1lZmdsMHpD?=
 =?utf-8?B?TTZ3VXlRM2tPaDgwMjhRb0dmYThNaU5LWnNleXk2cEpuS1dkbjcwZTl1TmVZ?=
 =?utf-8?B?cU03YnNLVnZTU1hYdzFVTFRzeGs5SjBWV0NFMU56bHpCZ0xXNWgwaFNIOEVP?=
 =?utf-8?B?dDF4QlZSNW9tNjZRUDVJTXR0YVg4Z2sxdXZRYlkrdWhWOUd5QUxTMEVUOHJJ?=
 =?utf-8?B?MloxSFdsSnBZanBRMWl4Sm5PdFFPQmRxNFltM01tV3UzRE1EUzg4QjNZc21l?=
 =?utf-8?B?NTAwZlI1NlRLdVN4WURKdzlEcWZYb1FhbmZ1RDN2c2h2OGtOV3R6WUhUQlBY?=
 =?utf-8?B?ZnRxNWdJVkJmT1BNcitISHhGa3dHWDMraVdBYlJ1NnRtcDN1REVMT2lHTVUy?=
 =?utf-8?B?SHJvQzFqTDlBT09IUS9naExjQ1Rqa0ZGaHV6SnFYaURpRTZWMjNYWWcvVUx4?=
 =?utf-8?B?WkhhYzZyK3Mwb3J3alNDWW43YnlaTlphVnpIaGloaU90aDdlYzJvbUQ1M2pJ?=
 =?utf-8?B?OWpDdjA1VmpsVkFmQ3JCTVdvWEh0b1pPWDFXTWI3bUJaNjRUd1VnOWV2VlBP?=
 =?utf-8?B?cW5SS0Vwb1VJUDZNSDgrbFZPMlcrcE55SkdSVG5GQ28wRDB4QUhPMnd1RGpo?=
 =?utf-8?B?dnQwMWZDUi95bkZpOTgxNlJtNjdrZnJHUUxlRXJGUkcwL3U4enR3ZkdzVUtE?=
 =?utf-8?B?Sk1SRjJqVkZHWTZyaFloSVJOcVh4YWJ4VXFjSWRHOTVNcjdFMEo5LzlHNzJB?=
 =?utf-8?B?SG5XU05xOHhDcXVsY1hNWjBTYWYyZ3Y3MWFBMGpkc2l2a1BlYS85ZTh0VnB3?=
 =?utf-8?B?a3gzbkNFcGNDVXd4OWY2ZWRvc2NDMWxTbG1yRGt5dkk4OU9ocUFaQzdLRHll?=
 =?utf-8?B?TjFIV3llK3lFTW9GTUVncVB3M2JoTmdLb2ZVM0FZZ1lrL2QxYzB2VDJPMHV6?=
 =?utf-8?B?R1JWVUdQTWpmak9iUU52ZlQxMDZzMFdXN3Q3NmljWVdGZy9SNnlMdHg4RWgr?=
 =?utf-8?B?ZXU4UTVWK0ZDWTBNZ2lHWFNFSXFlT2kybVFBMUxEeVdxMFVnUWtWamNxSWJx?=
 =?utf-8?B?VEpFT005dXl2dWpsUVZIVk1NVHpHV1RLSkVRUnZwVCs5Q011dDM1bEVQQy8r?=
 =?utf-8?B?RnRVb3NRV2JhYTVkNHY0dFdxK2NHWUlWKzFaUjBUdXVtcUNxakxrTVBqbGI3?=
 =?utf-8?B?bmx6UzNSOFl5TlBvTC9YTm9kTTFTRThNUTV6STJPWk5NV05VRmNxdz09?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93daffd3-7791-4476-3807-08de5e64df69
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 12:00:47.4270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQ7EiZsZUks4GaHzyoqO+5N/6W+q/U/ZtiGn6L9yDxguaqUtu2bi/UPi/9acwEvHDPVDdqz8fswmp81C4TRLqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7687
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA5OCBTYWx0ZWRfX0yvpVpMpTr0m
 xhQ/h85dBrSwf9GBdjjMv7e/OD8eC9eirZQANi0dCBhWlZvPPktsBQh4KLcC96dj8GOpHFKCma7
 6pgxNKI20mC5GOej4S1TyrllxLNlzBOCybFf+wm2Z22gc9lncN1aks6+oUwbp9yQcUxKOlDigqs
 D64qiDrfARt31KQWpLWl5yTAiQkqsE/vilc7ggHjb4u0dgudivkor46VQFStP2wM9rMkrJj/pE7
 i8djw593iUc1l14UYMQxODMVWKSj6lNRML3A51cA8oXB+xMQasrN1/7arOqMUrWKhlHH9ypE+HA
 /Fbi2QO2B0OprQdc8sutLu44VR48bwt5Pky2oYbs09QyDtU8YVYL1uSq7/Zpxi8k0jpq1Zgkrhj
 R1yV+oLSd6sq8gY5izNBWrQO++7F6MK8bxWdo+pcroZwI6PiFzSBnm3yVCq5QYwG662wGxcYE/N
 5mTXvud+lP6yhq+5txQ==
X-Authority-Analysis: v=2.4 cv=CpCys34D c=1 sm=1 tr=0 ts=6979fa72 cx=c_pps
 a=xOYz1KraVtwoi73AohHYLg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iGHA9ds3AAAA:8 a=I1k7tfx8jKYhpOTj2UgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-ORIG-GUID: qVPQXRPcSTFTiilBh9t_9WfU6-vdrFOh
X-Proofpoint-GUID: qVPQXRPcSTFTiilBh9t_9WfU6-vdrFOh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_02,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601280098
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 60SB2cfh763255
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Jan 2026 12:01:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3130


On 1/26/26 23:37, "Uwe Kleine-K=C3=B6nig wrote:
> The reasoning is taken from commit 5d203f903979 ("systemd: create
> /var/lib/systemd/backlight in advance").
> ---
>   recipes-core/systemd/systemd_selinux.inc | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/recipes-core/systemd/systemd_selinux.inc b/recipes-core/sy=
stemd/systemd_selinux.inc
> index 7d466ee608c8..4eb7194444d2 100644
> --- a/recipes-core/systemd/systemd_selinux.inc
> +++ b/recipes-core/systemd/systemd_selinux.inc
> @@ -1,5 +1,11 @@
>   inherit enable-selinux enable-audit
>  =20
> +# The systemd-backlight@.service which is called after selinux-init.se=
rvice
> +# will create /var/lib/systemd/backlight with incorrect security label=
s,
> +# this causes the systemd-backlight service to fail to start and to st=
op.
> +#
> +# Creating /var/lib/systemd/backlight in advance to make sure it could
> +# always be relabelled by selinux-init while first booting.
>   do_install:append() {
>   	if ${@bb.utils.contains('PACKAGECONFIG', 'backlight', 'true', 'false=
', d)}; then
>   		install -d ${D}${localstatedir}/lib/systemd/backlight

This file has been removed in commit:=20
https://git.yoctoproject.org/meta-selinux/commit/?id=3D4507f3ad747c750761=
1d718d10c7da8bd602660e


//Yi

>
> base-commit: 1db6bf1b573b9c908752602c1e2b6a30368da3b7

