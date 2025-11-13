Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC26BCD5BD0
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 11:49:27 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22007.1763034561738137861
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 03:49:21 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=TZqP626B;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=3412b09296=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD8iwFs4111020;
	Thu, 13 Nov 2025 03:49:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=/550qMtaRnDkV+K3Fwz66l5iE6nZwZlboS/+9KPLh8U=; b=TZqP626BKnql
	muOfM53YMQsvfgs9GXiK1Q3geJDiaGt79dAfinvvpytgHtKHLv+eMF6VhkyfBlPg
	El2PaoU59E2Vy+pCwhw5bxbX7rUL2GU+fwQn0/qLM1JbfHz2csqyZfkkTokHo7of
	9OYbnQsxqlePITffufNwvR32AIfuKAxttcMANZZgj3YiwZfT4FmGp+9+fDJVayQK
	BJLtt9YCVtPg9RLSfRBfCI8kPFwknGQlHEo2aeXJ4sMtwN+9by63U+ew9CZ7QyE8
	5kZxb5PD0GmQju2/nrBxG8Ga21qYuUuqJ3Gs9y1PC1BAAe5QmC4NbsvvIHWxfFw+
	5xuPWYdlFg==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013014.outbound.protection.outlook.com [40.93.196.14])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4aa68jq1nm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 03:49:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncs8AAw/6l6wY8VzceY9/pv7SAFiVqusmBMw6rwPxyVoF9Y1uc6RhHVJ+IxZspkGnhYIVhXqP0e1PQMkJQGdTVXHmVN+o1mL3VQoAYQmWCHc4jFJ8s797U4QY7zJcs0oTivd5fvjfXAZjHxpBPGS//nfxzZe5pdJMosLcc07PDYfFieFZ1eyzMNFHjvzzikdlPrd5/3RSyjq2iye4m4ldL07bOXkrxhbTpqYXMTdmLRLwUceniWou9zOl8+e8D4qvh7N6VMfdxOrQZByhvy/dm5Q4dSFaqGFOjzznE0sDlGz4mGzyAZUPqa/xsngJ5prhjDNigr4Sg75ozrorKWkRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/550qMtaRnDkV+K3Fwz66l5iE6nZwZlboS/+9KPLh8U=;
 b=HKxbZdgyh8d7KGLoNraYo7MMd38Ro4ir/CCooVRJTrTAFUJA3V0o3jDl7+uoAxTSUoijPDMmikc7gI8jKW7N9x+wW4LsAmhq1h3eIlqPkec1KlouKbIroj4Hr9ml1wLZSGGgtrWfDtiDQOeM4QUKoryoZkMFy0mfGwKu7PmFfePcoV8dqkqAIMFcY5KKyB2MPgdoCMzPzgH5WjeNiFk8wu7qzsvdUNjSzfVGPQ/8UHqlwWoPZOXhqOl63ssemtMnSSX8zTJBhopaOLBbapRPYip4+pggzPeJt+JjUqqO+PDieeg48tftTfhDmQ6pg2kDWOX7K50cgqbmZEJBvORiIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20)
 by IA1PR11MB7754.namprd11.prod.outlook.com (2603:10b6:208:421::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 11:49:11 +0000
Received: from PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::ef64:bc9f:eb8c:e6e]) by PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::ef64:bc9f:eb8c:e6e%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 11:49:11 +0000
Message-ID: <6a9ceecb-6532-4aa2-a93b-9109864e318f@windriver.com>
Date: Thu, 13 Nov 2025 19:49:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [pseudo][PATCH 2/2] pseudo_db: fix duplicated xattr in rename
To: Mark Hatle <mark.hatle@amd.com>, yocto-patches@lists.yoctoproject.org,
        richard.purdie@linuxfoundation.org
References: <20251111135951.2121065-1-hongxu.jia@windriver.com>
 <20251111135951.2121065-2-hongxu.jia@windriver.com>
 <711e5b61-ac32-40fd-b014-1cbdba45dc98@amd.com>
Content-Language: en-US
From: Hongxu Jia <hongxu.jia@windriver.com>
In-Reply-To: <711e5b61-ac32-40fd-b014-1cbdba45dc98@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SG2PR01CA0193.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::18) To PH7PR11MB7608.namprd11.prod.outlook.com
 (2603:10b6:510:269::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7608:EE_|IA1PR11MB7754:EE_
X-MS-Office365-Filtering-Correlation-Id: 257beecf-f6fb-4bb4-70d3-08de22aaa959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?L2srVE44L0VPVTlzQ2ZNQXkyTVAveHNXcllXbnFWVHFmRklvclcrWGtsUFMw?=
 =?utf-8?B?YjczSDNKQ095UnJCK0d3cWwrYng3dUhVRlVSamJrUnVwclFsQjg1elJUZ2Qr?=
 =?utf-8?B?eTl2cVRHZm4vOGVaeHNrOXNaQ0Q2dUFNZHBoTHZPMXpYNGw2ZURBaWFUYjdR?=
 =?utf-8?B?QVE0QVQwSnJUWGYyYTZiMEQrbEp3THlyMHp3T1VzajNicldaU1FzdGZtbFd2?=
 =?utf-8?B?T0lTS05WMDBLSTZFZ1RrdytURFFQNGZWdHFQMDhDUkVuMlp6OHI0VXdmVnJZ?=
 =?utf-8?B?ZkJzcm1JN0ttWXB2Wkw3UlEyalJDUkFwbWhhY1ZFdC9DOXJLUUpPZ2pyeEhW?=
 =?utf-8?B?ZWI0ZHN2U0tDMXhEY2REZ0l5V2JPa1FQamUxVitTdFJVdHhuUUovQTNXM3ND?=
 =?utf-8?B?RlRkVUVqOFdDUm5RaHVGTUNyRVdVWFdad3hVZ28zVGxuOWVKU3RLZ3F4MlBJ?=
 =?utf-8?B?YXViVXhiYThuR21NUjdEdXZ5UzVRN1VvcGQ0dUFJR0tSWG9vV3NqUEd5QTMy?=
 =?utf-8?B?ZVE2MDcwaG1oN20ySHI2ZFZrb1ZEZ0VwUW1GODZrZGwzMzdFV3oxb2k0R3Rq?=
 =?utf-8?B?VFJrME8ybWI2bXZQUGMyT2pJaitRTlFKUFhvZUdJMVRxVWNiT2tTdHVGWVcw?=
 =?utf-8?B?TUdHY2dHdkFoOTJZdG5kUjExZmFCRkh5T3dsOHZCRk12SThsbFR6MExyWS9h?=
 =?utf-8?B?Tjk0TlQ0THhZRWtDQkZ4YUY2MnlXZDloOG9DZS9hYUVGZ2xNMTJSaHBGRnBa?=
 =?utf-8?B?L3JxV1dHb0ZYTVBVNTZKT01IUllwckcrWkhqSS9HU0lkaFBqV0IrdEwxMTJk?=
 =?utf-8?B?VG11ZytvVFhLcVlCQXRvY0ZtaTJPQ0M1cDlBTEJWbnBzQTJseGZiSVVPcm5W?=
 =?utf-8?B?R1RGSUlxNkhXOVFIN0J5UDNibUtFZmFpVk1QejFPZzVnWXBWYWhHUDFMdGND?=
 =?utf-8?B?WDF5eDF0K2dVR2QxbVJXblZLbzJCZWRqYnZXcFRTYlJubGt6ZklsZmVCSFhZ?=
 =?utf-8?B?Z3JpaG1UZVpuamlIandnbFpGOWphOWFHL3hsZWh0Z25IbmQyZUcwYTMwUDNR?=
 =?utf-8?B?aTI2bHQ3dFJqZ1cwam0xbGtBekE1dTlGSmdRbmVQaWJqaEtSait5b2Fnc25i?=
 =?utf-8?B?RGoxTUh4UThKTW5EcFdpZFB3bHdCa1ZuOTd5bXloNDVXRGRIdU1UNG9SbmdW?=
 =?utf-8?B?MGIycnE3bjB6bnhOUzhRQkdhWVJiVzYzNDdnUVJuWlRxTXM0Y3d3QnR6a01y?=
 =?utf-8?B?R1N4cGpnR2Q2OE1GRU91S1hmVldiblArYk41MzlaRlhvTk1YR3pnMk9ZWnZN?=
 =?utf-8?B?SlNkR2QrbHFYOUhGKzBNZDZhUzlxWThiSlRiUUZlMUNnSUpXZGJDSnp3ek53?=
 =?utf-8?B?a2E1dHE1ay9yYjk3aWNtell0Y1VoUWNZU3R4b2hsQWUzWk9Jb25SbytYQWpz?=
 =?utf-8?B?dkxLeXh6Ry9xeUdmSW1Sb29DWUlJYlluVm15eTZmZGpTaDVJdjJZNjJsTk0x?=
 =?utf-8?B?MVFJUjJseWdmRkkrSXpPL1F6WkR4TUZ3eXhWRHM1SERLZEhKd3ZyTE1wU09F?=
 =?utf-8?B?T1RFWExCR3ZENGVjbE9iT1lsM2VYeW9BQ25mWFppZXZOeCsrQ0RIdjNqUTJs?=
 =?utf-8?B?OEJxYWRHTGlPZGNvcUhSNlJ0NzIrZW9nSzYwRWswb3ZOV3pFSGpFY0hSb3Ez?=
 =?utf-8?B?amdIalhpOGZPWnhmYUx1VittcnhsT0FveGdtQSs0UWpyMzdBMlMyQWN2M2Y0?=
 =?utf-8?B?U1g3OHZJV20xT2FveVBlSXBKaHE0eXZpTkRqUEx2QUY5UWYxVFpwVkdzTGll?=
 =?utf-8?B?NHJqSmxURkNmd1oxOWRnYW1SUlF6aU5YcDU4QXRDZEw3bC9vMDAvTkhtS3JE?=
 =?utf-8?B?NWk4Z0ZEMWZWdVBraUlzZUtEQlQ0MlJWYkUzNVFaZ3RCRElldnVxT2VYcFpP?=
 =?utf-8?Q?BQsdPhhYf/fgB9C86Nyx7HrEbOldDfcd?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7608.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TTRDM2d2VVoyY2s1Z2hiUmdMOHREeFE2emloN3BMSWJYR29SSkxEazNRMlRQ?=
 =?utf-8?B?TElMMlVEM2JDNkU2RS9zUkdwNk1MRWx4OE5RMXFwSkxoQjZqdXdqc1BHaDFK?=
 =?utf-8?B?WGY3QnFNdEk4YzR6NVVZc1ltZlpzMGpRZEpqVm9qWFBVd0E0Z21VMjRvaC9F?=
 =?utf-8?B?S0JySyt1QUxvQXVFcjdYVERYbzNMRFhsL09FQ0pqa3BZVUVqOUlEWnFadXQv?=
 =?utf-8?B?NTI0SnpWK0xGMmN4aVpmckU4L3B2U3Z0VGJ0dlJyMnFERFdPT0pHY1M0dWdD?=
 =?utf-8?B?OGp6c20zY3doOERLMVFKY3VROEdLU3JINjAzZk9pWExRNmRTcnVRZUNubGRi?=
 =?utf-8?B?WXJaMHFIM3lhRE1XUXNHLzV6Q24wck9DVEN4enFMclNXUjBraURwNWtCYlFi?=
 =?utf-8?B?K2U4WVZpWVR0YXU0dE5HZnNLTkhxWE1FbXFqTGxic1NrODBtdTRRclBxVTNw?=
 =?utf-8?B?KzhsUlZCQTJxMDcxMzZaWWRMbnVONGp2S29sQlRCcTVmL3F5TUlabFBVL0l2?=
 =?utf-8?B?STNXWWRKK1N4VGNlY2VHU0doazBiT0pMQ0lFdk9GTGdGeUkwbXFKMjdXY2Zk?=
 =?utf-8?B?bkZHVVJkQmN5ZndVR3dSYVIxaGpPSFdIWGt0bEFzUW03MTJBRUhnc2ZIeXRU?=
 =?utf-8?B?dFVvdm1ZaXJlWFZqTVUxeWNFOVdGM0RQQUIrVVVZWEhzNFVsQUJrZ3g2UGV3?=
 =?utf-8?B?aFNDOHR0K2pwbC91WEZkQVZSZnJIRW9rdjV2cjJPcWdvb3hKODVqTlhYQlZC?=
 =?utf-8?B?cCtsRmg5T29qaktuRmJDSEJydG9FTFIzQnQyaGE3NmZ3Q3VkV3hleFV2K2Rl?=
 =?utf-8?B?QnJ4d0xKcTVWVGd3SlpXbnU4OFZmVGk4T3F2QTFvejJkMmF5NGVoekJxZXZS?=
 =?utf-8?B?MStFYXJrQzlQVGE3T0w0KzhneW5Dc05SMnZFd3o1YURRUXpuLzRNSFh5N2Jh?=
 =?utf-8?B?QnZiUFVxVi9STmNaWmxmQ214eXE4ZUFXTE4wN1lkeVFYM3QxZFk3M0JLNWpD?=
 =?utf-8?B?NTE2WnNUd1pRajFDL3drZWs4QzdaZDg4bnNEK3BxOTNtWnB1WTFUdmdzNnJo?=
 =?utf-8?B?UDBtTWQxQVZkL0ZFTEhHdHhBMjdyK3c4WXJGc2dFMkNVMzJycTE3S0kra0hG?=
 =?utf-8?B?T0ZwbkxwMGpLVTM2RmZVM1BDdU9EQ0V2ZE0zZnJIYXNIOTRUTUdWOTJDWkJi?=
 =?utf-8?B?WStDZFA0T3RrbDFHb3N4Y1JkYkU1OFFpOTZiVHNzeWNLYXpTK0VUaGxraWpm?=
 =?utf-8?B?MVZLM2ovSkJURXg0b3VNR3A3djRNUEdkdlBYbk51MEdwaCs1L1dINjJ4d0tw?=
 =?utf-8?B?RWtsZVJMcUdIT2hmRVRhZUtybkNIb24wNEF6MWwvVE9scFlxakQ2NzJIZkJi?=
 =?utf-8?B?aGE0UlVXRVlkUWFTYmtwVXdsd1MxSVQ3dkFiMmYrMlFpcm5CU2NlaVVVdUUx?=
 =?utf-8?B?UktXaUdCaXJ5QzFpYkhzUk85SGZucUZKenp6M3RhNnM3ODR6bTlTR1hObndY?=
 =?utf-8?B?cS9nNGp2K0NQNTgvVzBOdFh2OXh6dVJTWHpNMksySDV2VGJqMU44VzVxV1Nv?=
 =?utf-8?B?N085cGgzNWo4dyttYlBibHE5VzFMMWtjSGs3dWdESWRkc0tMUHJ1NTcram90?=
 =?utf-8?B?TnRGV2hEK3lOeUc5MEp6TWtoaUxrYTFZeStMeWpMOVprc29aaWkrcitZdzdo?=
 =?utf-8?B?RmJGdEFGdjBNRngxL3NoMVp4NkNpSUpoRTdhUFlxT25COEZJVGdlcGxBWlUr?=
 =?utf-8?B?K2FUYmZ5aUNNMlJXNEtla0lMcHdKcDRuNnVXZGF3N2lQdDlmZ0hLbHJST3pu?=
 =?utf-8?B?WVVhUGhnbWxhZ213T0hyOTBPS1FwS1NOZ0VNNWtCUzdUbjlnTXl6bXFNL1hz?=
 =?utf-8?B?RERwL2hrcWdCeDFMSlFiUlYvcFhsOWRMWUdvbzdYM2RBbmpXRmErQ2lTY2g1?=
 =?utf-8?B?djA2SzRzWjlIUXNQamU4RHJZK3BYOTkxeUVNVWw1Y2JNOWVpUlBIR1ppdjMy?=
 =?utf-8?B?Y2JnY1JYVEUzUzl6Y3MzQmNJTnVRRTUzYWd3TzB0RktxMHoxYkZmWEN1UVJq?=
 =?utf-8?B?a1dlL0Z3M2JOQTc2QlBrYlMzYmlGQnZ2bm5SQnovM1hRT3NxVk1SR1pmMzVM?=
 =?utf-8?B?WjdVZXQzVlE2WkxuMzNOMmlZS2VOTG9XNEl6SWNLWTBjNVZERThOYkhDVUcr?=
 =?utf-8?B?U2c9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 257beecf-f6fb-4bb4-70d3-08de22aaa959
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7608.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 11:49:11.6937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OXAxBeuoWngElIpHd0OgalKrEERan1B0Dy9oT1uBb2pVFmpyKLof9v2UsPWOMBi8UcTBPb8m2zvIRuPtumi3TFCpCX2dNZgJFeLDHATzmeg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7754
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA4OCBTYWx0ZWRfX5lMZnny5Ax11
 +i+QZA2cDzbhTxY/KvDDRiaj/YAWaNxtkETmIc73Rj+h+ZVPzqGVhtOVeaYYmpz5Go+nYxJllno
 qb5VbZazaCeZrg8juIWgbIC9JZjlejXRnTgBD6GxZbePHkKIWnDOMH/NhzDOSHpJ4t1Dl2recd2
 WR+7mrzVpeRxxmKbicF1CYLXWRGSOzm9rFPOe95ILQNXrl/1SnP5JOQvfqiuoFrkyfamDbNTSg6
 fuDFkm/7xKgt/C2B32NshodCPdL2SK7TQnDnebIlHI1RxEKCQRzp/LU1GeJn3f3uY/mGIOvLEVY
 IcyJA8k+0L0xLuR+D50MTpiTY316DwK2oVZ82ogFet5c3o3oQ0PHmjQzrOTWVkxG4D3PiBsHqAl
 CxV1ma2N2jcotQB42I5UVzRDI/8/4w==
X-Proofpoint-GUID: LKAixOiqfcoggd-_iKCTcGQ5PYwa3ue8
X-Proofpoint-ORIG-GUID: LKAixOiqfcoggd-_iKCTcGQ5PYwa3ue8
X-Authority-Analysis: v=2.4 cv=ef0wvrEH c=1 sm=1 tr=0 ts=6915c5bc cx=c_pps
 a=hwAR686YzpmZ7aH69gEPcA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8 a=QOv_3ZxwquGyl8YQAjAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130088
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 5AD8iwFs4111020
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Nov 2025 11:49:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2503

On 11/13/25 01:58, Mark Hatle wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender=20
> and know the content is safe.
>
> I don't completely understand what is going wrong here.=C2=A0 Some comm=
ents=20
> below to the patch that might help me understand it.
>
> On 11/11/25 7:59 AM, Hongxu Jia wrote:
>> In commit [fbaffe9 Handle rename(3) across devices.], it defines=20
>> function
>> pdb_update_inode to change dev/inode for a given path -- used only by
>> RENAME for now.
>>
>> In commit [58e4171 xattr work: handle deletes and renames], in functio=
n
>> pdb_update_inode, it defines oldmsg to test the existence of msg->path.
>> If yes, copy xattrs from oldmsg to msg. If both of oldmsg and msg have
>> the same dev/inode, it caused duplicated xattrs in the given path.
>> Here are the reproducible steps:
>>
>> 1) Create a file in rootfs
>> mkdir -p rootfs; touch rootfs/file
>>
>> 2) Use IMA/EVM signing utility to set xattr
>> evmctl ima_sign --hashalgo sha256 --key path-to/ima_keys/x509_ima.key=20
>> --pass=3Dxxx ./rootfs/file
>>
>> 3) List xattr, get security.ima
>> $ getfattr -d -m ^ -R -- rootfs/
>> - rootfs/
>> |# file: rootfs//file
>> security.ima=3D0sAwIEOI1nBgEASdQgr4UDRTIYmF7q5SHFsyt3J/TO0Pwwz/hDiV3m4=
kjWALSKGC0Ea7wel6cZ1CcA/hQQ6gW5e86kswTCFexmM6qdE1MVG1IrP1L9YZcpJ3Ghh5bJS8=
S7Kb/J2FCaaPW9skGn8vG339CRHUuNz2z6uy6pryjLAVoAyl0jdqDlUTmhzfd7Bq6i1HLGSyB=
xm9nPwFDe4E5ubpwJlrN11YHUJSWVoAmpMfPLgu2bDalAz/I6tTMFdrEoR7SH0F9LuwKGnq4C=
Azrpsts/8/islsKWWPmmalv635EGG/k7g7zY0D/cHjc3YyaMYtvd43OWbTu+2j6w8IywmaZXN=
/YZg4AMgw=3D=3D=20
>>
>>
>> 4) Rename
>> $ mv rootfs/file rootfs/rename_file
>>
>> 5) List xattr, found duplicated security.ima
>> $ getfattr -d -m ^ -R -- rootfs/
>> - rootfs/
>> |# file: rootfs//rename_file
>> security.ima=3D0sAwIEOI1nBgEASdQgr4UDRTIYmF7q5SHFsyt3J/TO0Pwwz/hDiV3m4=
kjWALSKGC0Ea7wel6cZ1CcA/hQQ6gW5e86kswTCFexmM6qdE1MVG1IrP1L9YZcpJ3Ghh5bJS8=
S7Kb/J2FCaaPW9skGn8vG339CRHUuNz2z6uy6pryjLAVoAyl0jdqDlUTmhzfd7Bq6i1HLGSyB=
xm9nPwFDe4E5ubpwJlrN11YHUJSWVoAmpMfPLgu2bDalAz/I6tTMFdrEoR7SH0F9LuwKGnq4C=
Azrpsts/8/islsKWWPmmalv635EGG/k7g7zY0D/cHjc3YyaMYtvd43OWbTu+2j6w8IywmaZXN=
/YZg4AMgw=3D=3D=20
>>
>> security.ima=3D0sAwIEOI1nBgEASdQgr4UDRTIYmF7q5SHFsyt3J/TO0Pwwz/hDiV3m4=
kjWALSKGC0Ea7wel6cZ1CcA/hQQ6gW5e86kswTCFexmM6qdE1MVG1IrP1L9YZcpJ3Ghh5bJS8=
S7Kb/J2FCaaPW9skGn8vG339CRHUuNz2z6uy6pryjLAVoAyl0jdqDlUTmhzfd7Bq6i1HLGSyB=
xm9nPwFDe4E5ubpwJlrN11YHUJSWVoAmpMfPLgu2bDalAz/I6tTMFdrEoR7SH0F9LuwKGnq4C=
Azrpsts/8/islsKWWPmmalv635EGG/k7g7zY0D/cHjc3YyaMYtvd43OWbTu+2j6w8IywmaZXN=
/YZg4AMgw=3D=3D=20
>>
>>
>> This commit:
>>
>> - Due to oldmsg is static variable, clean up the memory of oldmsg
>> =C2=A0=C2=A0 to avoid dirty data from last call.
>
> See below, but the memcpy of the new msg should both setup the oldmsg=20
> and clear any old data.=C2=A0 It was expected that subsequent calls wou=
ld=20
> clear any specific data we didn't want preserved (for whatever reason)=20
> -- See below.
>
I am afraid the memcpy of new to=C2=A0old msg could not completely clean =
up=C2=A0=20
the path buffer, such as

At 1st call, if msg->path =3D "abcde", msg->pathlen =3D 5, then oldmsg->p=
ath=20
=3D "abcde", oldmsg->pathlen =3D 5;

At 2ed call, if msg->path =3D "efg", msg->pathlen =3D 3; if we use memcpy=
,=C2=A0=20
then oldmsg->path =3D "efgde", oldmsg->pathlen =3D 3; and then input oldm=
sg=20
to function pdb_find_file_path, only msg->path is used for=20
sqlite3_bind_text,

it search "efgde", other than expected "efg"


>> - Other than copy the whole msg to oldmsg, only copy path and
>> =C2=A0=C2=A0 pathlen from msg to oldmsg, use function pdb_find_file_pa=
th
>> =C2=A0=C2=A0 to fill oldmsg->dev and oldmsg->ino if it existed
>>
>> - Copy xattr only if the existed oldmsg have different dev/inode
>> =C2=A0=C2=A0 with msg to avoid duplicated xattr for the same dev/indoe
>>
>> Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
>> ---
>> =C2=A0 pseudo_db.c | 9 ++++++---
>> =C2=A0 1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/pseudo_db.c b/pseudo_db.c
>> index 8b23938..d6ae1d3 100644
>> --- a/pseudo_db.c
>> +++ b/pseudo_db.c
>> @@ -2188,10 +2188,13 @@ pdb_update_inode(pseudo_msg_t *msg) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 pseudo_diag("Can't update the inode of a file without=20
>> its path.\n");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(oldmsg, msg, sizeof(*msg) + msg->path=
len);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 memset(oldmsg, 0, sizeof(*msg) + pseudo_path=
_max());
>
> Originally we did NOT memset this, as we expected the memcpy to=20
> overwrite any existing memory.=C2=A0 This is why the memcpy was the ent=
ire=20
> old msg to the new msg entry.
>
See my above comments
>> +=C2=A0=C2=A0=C2=A0=C2=A0 /* Copy path and pathlen from msg to oldmsg =
*/
>> +=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(oldmsg->path, msg->path, msg->pathlen=
);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 oldmsg->pathlen =3D msg->pathlen;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 found_existing =3D !pdb_find_file_path(=
oldmsg);
>
> The function above (pdb_find_file_path) was supposed to clear items=20
> from oldmsg (as necessary), basically resetting the dev/ino and any=20
> other stuff that this function cares about.=C2=A0 (That may no longer b=
e=20
> true, I'm really not sure!)
>
The reason why I explicitly operate oldmsg->path and oldmsg->pathlen is=20
tell developer only them are used by pdb_find_file_path as input,

and pdb_find_file_path will fill dev/ino if true, and dev/ino will be=20
empty if=C2=A0pdb_find_file_path return false

> I'm not against memset and then partial copy, but do we need any of=20
> the other fields?=C2=A0 This is the part I'm really unclear about.=20
> (Especially uid/gid/mode and op.)
>
In table xattr of sqlite, it defines dev, ino, name, value, so dev and=20
ino of msg is used, and uid/gid/mode are not


>> -=C2=A0=C2=A0=C2=A0=C2=A0 if (found_existing) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* we have an existing file entry */
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (found_existing && (msg->dev!=3Doldmsg->d=
ev ||=20
>> msg->ino!=3Doldmsg->ino)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* we have an existing file entry with different=20
>> dev/inode */
>
> The above change looks correct to me.=C2=A0 I'm not sure why this wasn'=
t=20
> done original, maybe an oversight.
>
The issue was found after commit [d1db9c2 pseudo_db.c: Fix xattr memory=20
allocation] in which make the logic works.


>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 pdb_copy_xattrs(oldmsg, msg);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
> if you don't do the xattr copy then is the issue that we have 'junk'=20
> in the 'oldmsg' that needs to be cleared?=C2=A0 Or are there other fiel=
ds=20
> in oldmsg that are the concern?

I think we should not do the xattr copy, but I respect the design of=20
original author, so I just add the filter condition=20
(msg->dev!=3Doldmsg->dev || msg->ino!=3Doldmsg->ino)

I have no idea on what situation for a given path, the dev/inode will be=20
changed, for file rename operation, usually a given dev/inode, the path=20
changed


>
> Unless there is a specific reason, I would rather copy of the msg ->=20
> oldmsg and then clear just the items we do not want.=C2=A0 This should=20
> clear old data and give us a known starting point for the "new"=20
> oldmsg.=C2=A0 We can then sanitize/memset/clear whatever fields we don'=
t=20
> care about.
>
Only memcpy is not sufficient for oldmsg, the oldmsg->path buffer, see=20
my above comments

//Hongxu

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sqlite3_bind_int(update, 1, msg->dev);
>


