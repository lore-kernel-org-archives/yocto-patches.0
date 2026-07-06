Return-Path: <randy.macleod@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906D1C43458
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 23:56:47 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.163189.1783382199866048095
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Jul 2026 16:56:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=MsehXWKi;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=1647111843=randy.macleod@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666Njxx6178669;
	Mon, 6 Jul 2026 16:56:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PPS06212021; bh=Id0Rhjj68m6BvYfSfuxP0Z
	WI2VQpLGqGlRdLGcHmqAQ=; b=MsehXWKiOzr9yC8BrYY0FQg+wLDI5UvPrTr3TJ
	dC8Iv5cjzi9OHiVIbb6BO0/cGiwxQUosYnWxOiekGF9tNPN3/2wIlsufz9pdIv2L
	+3aPC/0rJGxGCHaK8p3jsEV+Oj3/uvew1ToB+rPSmf5ocj32TvO7YeQSDi88l+0u
	pqA/lDgYPRbdNF2OUUPiYHLcpMFqX/PVCq/GahIoTBtKx0ZSr/IUniPJRP7cfdeL
	Z5VW3i+WjL4H6L+ftEx0efVwAH/DW89mepzpj6aAC292w1EOiAHOGQkRPcC0RWd/
	5yIybcMsHJ29CoSqHDhxTUNQI3jgtMqVF92vxQFP+Ohekr0A==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4f6wf1b3v5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 16:56:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVJEBSGENdGrEnnQHF/k/kaAfSSXd8tYIbUzy4hBEjABsOTKkiYepkhvtUjQLSnDUCxlhRlMOGsRgvA+5GpmrUaa3rgfMTxZ4GYn95WaJWUjCfYMkIMepBq1vKZOoD72UGaZsYldkC36+nd5EebXMxI3nCVdTRa5Y8ZalqkTxWrFKtV92gJtDTkX6+jtnLfV5W4mlCQNiAyMxIf4m0DaJW3xLpp44VKRT37V1l19wdy54pXo9L2tZvsih9Yr2qCBKCxjigmUuIYlDhNtloXQIw/VvTnZN91ncad51YK+vgoQrD9IvgH17A6Y67DC8YR6jfA/1nMAwPf/4udN8tlBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Id0Rhjj68m6BvYfSfuxP0ZWI2VQpLGqGlRdLGcHmqAQ=;
 b=pGo+LFtJVBtYHDLscsKOvV+1Lag58+31PJFDqAMCyibWe+kCl8oibDTLpR3BrASpIGyY+Tmdj5dces/C6FIwvck7ngNkHMIqPX5Pw6FmyUVm+EF+HwHx2wrdxXvfHI/2Plcw39AwrIeX8bFdP9aPPjjSEmzOla+j+92wtPRZY9Ve+C4mmWEnJHQvub3vcaBFXGctu88eL8URuwWUB6fNAn1zM4sjbI3j8Nvywk1a8qjVG3eWs/vB41beBCgpVjqrpz4eQrhJUamnJAkTwxyvmAV3o+Zhr0CfE4Da67QFt8M+Rbf/Ce6mX/U2QcVXGD+YUjfP95DyK7BO7aCA2+317Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8496.namprd11.prod.outlook.com (2603:10b6:610:1ba::22)
 by DM3PPF341F90799.namprd11.prod.outlook.com (2603:10b6:f:fc00::f19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 23:56:33 +0000
Received: from CH3PR11MB8496.namprd11.prod.outlook.com
 ([fe80::5627:e3a5:cb26:b555]) by CH3PR11MB8496.namprd11.prod.outlook.com
 ([fe80::5627:e3a5:cb26:b555%4]) with mapi id 15.21.0159.018; Mon, 6 Jul 2026
 23:56:33 +0000
Content-Type: multipart/alternative;
 boundary="------------b4JgvTts2nOllwOg6rjB65pY"
Message-ID: <9d0ffd81-0d12-4952-8b61-480070a45974@windriver.com>
Date: Mon, 6 Jul 2026 19:56:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-security][PATCH 1/1] README: fix broken URLs in
 meta-integrity and ccs-tools
To: "J, Sandeep" <Sandeep.J@windriver.com>,
        Scott Murray <scott.murray@konsulko.com>,
        Marta Rybczynska <rybczynska@gmail.com>
Cc: "Komati, Shiva" <Shiva.Komati@windriver.com>,
        "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
References: <20260625051816.1844262-1-Sandeep.J@windriver.com>
 <20260625051816.1844262-2-Sandeep.J@windriver.com>
 <b8386479-b575-4efc-8b81-8b45a592029f@windriver.com>
 <IA0PR11MB7259DB4675595D599ED7592BF7F42@IA0PR11MB7259.namprd11.prod.outlook.com>
Content-Language: en-CA
From: Randy MacLeod <randy.macleod@windriver.com>
In-Reply-To: <IA0PR11MB7259DB4675595D599ED7592BF7F42@IA0PR11MB7259.namprd11.prod.outlook.com>
X-ClientProxiedBy: YT4PR01CA0196.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::26) To CH3PR11MB8496.namprd11.prod.outlook.com
 (2603:10b6:610:1ba::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8496:EE_|DM3PPF341F90799:EE_
X-MS-Office365-Filtering-Correlation-Id: 30f33365-fc93-48c6-0768-08dedbba3472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|6049299003|7149299003|1800799024|366016|376014|13003099007|4013099003|4053099003|22082099003|18002099003|56012099006|11063799006|4143699003|6133799003|4076899003|8096899003|4133799003;
X-Microsoft-Antispam-Message-Info: 
	ErX6LfYQvi7oi0bu+A6AjTSdjNJditAJYh6xoM4eJQDUzOAlS12qSRhcJnSXkZpR4cPUgUg0I8o004Q4afE4nL4NRJXNr/wHXzGfKZyaGASIq5Vg06e0Ojj2ZbSbajwKlsSpsMrlYkJMU8heAwzhC//Ibst64hzYW5E9hclUONDh2gnEX30RNrhGV18XfAb/JCoYmbfaOU/QQCphFeX2s/wj9m5S/bVNrV5kfLRTHgTnO7ozccw+j/+I5KXADuvKnvxRJXNraZl5WzuAoxmwvt6Cz3+B7+8jjMzki+gGG6sRJ+d37Vnqlr5WWJuyyVsLhCeaZ9Sq+SdOMKZQ37t3nMhT087j49eDMhc+GDoh9EURGw4ONiJteWUaIIRdnHcG1RBHQKsNFJEYNz7r+hunbSDZQo8nAXcKfDMES8+CkX02XGrHd0DR156qoE9+wc/VmOltSWsD/9E0zrpMvEYsSzHzrudzWTq9ynAjez1WAQVxZIa736WlIokJe6QqxF8oG4HVbLE5vn6qMkGcS1fXJhcyg+SojFx6oMpf+TprC9dX53Bq6+y0TRfSe8K2GQkQ6Z+opQX+Wcq0ji08xvwUngwXtQsn2Le/k17SP0wghis=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8496.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(6049299003)(7149299003)(1800799024)(366016)(376014)(13003099007)(4013099003)(4053099003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(6133799003)(4076899003)(8096899003)(4133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Zi9sZEVyek5rN1hqZzM0V0tWeGtXWndRakFIMXQ4U0VlQ3FQNHVwYUlyenhW?=
 =?utf-8?B?c1ZnaDRCQjFSSW5wYVNXTXE0V3pkTTZydDUvZ2NiNml3eHNhMUV0TGRkZ2Z5?=
 =?utf-8?B?UnMwWkVRa2FpeDNxOHUvR1gzN25manR5Q0xLR1RoZ0t4cndRSFl6eWZaYjZJ?=
 =?utf-8?B?a1lvbERJQzIyWGVwUGl4WmRwVHZkQWJSaE1FL3p1c081MUV6RHhBT2J2dzBz?=
 =?utf-8?B?YVQydUk4UVJoTGFRS2RnaTRuZXIyNFhCOW9qVEdPZHcvR1Jua1lxWVdacFFk?=
 =?utf-8?B?a2w4ZE4wYmRqUGFYYlpoZy8vcDVEbUVrVHJiNklLemFrenFzMHFBM0hqU2hp?=
 =?utf-8?B?MzE2TkxVMGdzc2RNVnJzYzNTZ3gzaUJWTUpQeHlLVVMzb1BCUG93TE9mN05k?=
 =?utf-8?B?RUlsUEhnMWxGbDZtbjIxU01oYWlQUkVFWVJRTktqWnZuWGp0amxHcWFOT1o2?=
 =?utf-8?B?RklKd0xjZFJiR0J6SjZiOFpQQWZidUdYS3FCMS9uQlpGQ0hrUUI1QXl5R3E3?=
 =?utf-8?B?NDg5enkvSVk2S1FLOE0rdmpGZmRCcjdienhFa2FCSXVnbENHYmM1a2dLWnVa?=
 =?utf-8?B?emllZW9tR0NJWm8rR2tsakVXSWZmNVRSSjc3WGJwRzRGakFnUlBNQ2Z3eUU1?=
 =?utf-8?B?M2l5SjFRMzlpOU1PSmNUNy9qQjdndEg1UGRpeEdqU0xpQmxubDB6Y0t2c2RZ?=
 =?utf-8?B?ZCs2OHZhYUJlZk96KzN2Wkttby8rTGVFaDlDSGZiYmlQYXZrQUdwaSthV1Nz?=
 =?utf-8?B?OEtMV0grZGwrQWdRRlEzbFVLYUZJT2hJSWg1YXVkUFI2SjBQbzZ2K29JbjFS?=
 =?utf-8?B?TEFlTUZrNDl4MlRCS0NIb2NYOFZZbm5NZnhRODhiL29yUEhMYkRHbW5wcGtC?=
 =?utf-8?B?cHlISWkvRlpHenF1SHBNT0E0UjJZMUZmd1owc1h1TkM5SzcrV1dYVzJGNGw4?=
 =?utf-8?B?Rkt1UDA3SkFsV3FER243Y2xnTDJaeGxwZ2dranNlNFNKcXhuTGRwdXRWZUw4?=
 =?utf-8?B?K0hqODhoRVU5OGQxVmpuNnNwOWxIVVVhRFVudGJITUFwRThLVzRFYnkxVkZj?=
 =?utf-8?B?MERvZ1J5c0xONGltaDJPYk5PMGRkU3ZsSkR4VDBLTFkwUzlCcElYVnVRWnls?=
 =?utf-8?B?cUlKMmtqUjZFbENCSkVoeGE0bXpidjBnbDZBcUh5MUozS1BlMjJKdGk0STQw?=
 =?utf-8?B?MGRNK2RDd0tCRTg0Z3AzUmRhWUdFcGN1THlHKysxWWV4SzR3cVorSjNzVEJQ?=
 =?utf-8?B?a1RHSGllWHUyZ0VEQWJJcTJiNlVaUjhHb3hzVnNmSkRjTlJtOEZoN0FxZXNl?=
 =?utf-8?B?L3lPcU5KVmVxZ0c3MGE0SFJoRG9EREZGbVVncmJrdm41c2I1K1pqcCtxN3RE?=
 =?utf-8?B?ak9PUGV4dFZ0eDQ3M0xyMTRiZ0hvai9IZ2NOZm1OckZyMlZOQXRoNm4zZVFE?=
 =?utf-8?B?bXh1ZUZhWnRPeE9TRmRmWnpudWhuVTlmUDlhRlhLUEc5M3p0UHBFYWd2R2pv?=
 =?utf-8?B?b045dzdBYVQ4dFF0cnFwdjNiYWt4blFBNG9UVnhFbDJ1U1hyTFJCbENJZlFW?=
 =?utf-8?B?dzFucGxnQ0l5QjJPYlhrd29OUTJEWWorRXdnS3I3eGJLMXFobWF2TlVkNGRT?=
 =?utf-8?B?dUdPVWpzcFNGclA3eitsdUovOFR5R3dpN0JGaEV3Rjc1L01Ib1FTWTVtRFVR?=
 =?utf-8?B?WFByZU9TRGllc2pDWnExdEN2aTJMNkZKMzNGaUtGeS9IMXBhYU9UcC9xdVVs?=
 =?utf-8?B?ZUprM2pEK0F0Nm5HSzY1U2RkVWhMZEdjalFYQ1NQVnVqb0xWc2NHSUVsMXhW?=
 =?utf-8?B?UDM4TnpsWHMwc1J4aXBnWHNLY2hPY3dMWlZGTW4xRVB6YTdabWdRWVNFdEow?=
 =?utf-8?B?NGdhakg2WjI3cWkzODlycUZRRXJDcSs4YnQzY2Q0eFJLUks0ekRvSFpFWXFt?=
 =?utf-8?B?L2Q4V1dzY29HRFpSWlFnQ3Q4VkQyY2pUS0dMUFhML1ZabzlidlFQTFZJVERP?=
 =?utf-8?B?NitkazNZRFdvdjc0L1lXTUU3VkFOb05FSzZmcS90SUphcnhGSmVxSzd0R3Q4?=
 =?utf-8?B?ZDRkZmhUUUpBc3doSGFDaWhaZWJEcXNvM095V1hKZDVPeWIxcnZBclVzRC8z?=
 =?utf-8?B?Y2orZFRWU0ViSUxFcERCSWFteGJvZXB4bU11Y3p4dnVKaDZkeFAwWDFReVdL?=
 =?utf-8?B?cmlzNVplVHBKLytvYUNnRXFtOUpRWXJEQmpyOUJOd0JIY0MrSUVNdExWNlYr?=
 =?utf-8?B?QWt6VFg2VGMzbzlyODdtQnJZZkwybjVuNE1sZnd4cVlBOUVEcTBMMjVUeitO?=
 =?utf-8?B?S0krRkhlOUVmeTB1MEUzV3J0RlBzS3RXYTBoVGxVck9IcDRrV3pIcXhVcVJU?=
 =?utf-8?Q?VnHsiiXCj3JE5Nko=3D?=
X-Exchange-RoutingPolicyChecked: 
	b31ckbCSQPRGKhrYKf7ZIIQ0UXM/di/MHuDWjk11UobQregSG15Ejn65veneeH7yFqlCNCwORhqfXdCWdVVjNWiTkwjOMAxCME0BPeSvqZM5Qol6Oh7gJHxtxjw5BcJWPTePhmJMPOkn/uIFXTw+KGN8d9I11IK6Zm8ie/J5DGYbKSewHalYgtF9vorxYIhjBS9UxPTwcO8iEEE1nRXKbfUbKLor29w7/HqpwDr80wuLGljBWDiOwFJqqjQLMXSCcDZ8SanOjhHTktlaYn+uMSrVvxpwF2E4Qqd3g07vIlbSAt+W6R99lyte2Xmx48wy8EBnHaasXxGJC1m9x3t8+w==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f33365-fc93-48c6-0768-08dedbba3472
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8496.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 23:56:33.1656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29/7sXqi8wwyUdxUps871k5CZKYxJxrW3zbC25Jh2krnJBLyjqF8F9aMnGvxg7ln/5jWu0lCiwYiJ7qtFI3XfXKw54AB7twtUOIyuhPgE6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF341F90799
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDI0MSBTYWx0ZWRfX9oe3myNMN0Zd
 lqKCBzZYP4C7QOhiRfTo3VV2JjYkB+wCfUxc0ARBjadB/I1uhBebFeLb6cFB7ExSJUs39ij80Vx
 eouX8BtWqA5n/Upts3DBxWXa5l6eugt+57iuukmfE14CYLvc25bog4Rvs4ZKYo3ovi+1/QB0He7
 E/j4Uf8tySlx/exS69rQQ5LLvylw5mEuHYJY44QEwX2vTmsd+L1+a5npD6m/fCVJdVQLi25pxez
 wT0/GE1EmjCEZNjyVq9jKrqn8Bj05oiY1AgagY0Hw6JUVGOK5sm7PID53uDP7kX0HJe0XawiTpC
 LUxtaP/vKIvvQbpIb3y97M4ZaH/kjJdNOMCewqQUwrck8uvFFJd4vFRhn75M7aQoC4EDZJSZ7aU
 mBDQKYnR82fFPGzIXypd2UysnVfMnX6kuFkNTdoyJITHHAp209QzZ8ma7fwa2iPajK0eQdrXijd
 vRTCw/hb0xQRQjrnTPA==
X-Proofpoint-ORIG-GUID: RHQsiJ8HVxdtebwDHwViQ-YmFItLL7bb
X-Proofpoint-GUID: RHQsiJ8HVxdtebwDHwViQ-YmFItLL7bb
X-Authority-Analysis: v=2.4 cv=cuarVV4i c=1 sm=1 tr=0 ts=6a4c40b4 cx=c_pps
 a=1PQ19NIIScYLh/jfzFkFww==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=Vt2AcnKqAAAA:8
 a=H6WxVz_VAAAA:8 a=t7CeM3EgAAAA:8 a=dnEwNotGAAAA:8 a=FP58Ms26AAAA:8
 a=TSbVqHtbAAAA:8 a=a4NEJbfMAAAA:8 a=iKPLBM1MAAAA:8 a=1XWaLZrsAAAA:8
 a=qxWGVCWjAAAA:8 a=QyXUC8HyAAAA:8 a=iGHA9ds3AAAA:8 a=TPhgZQJrbbcS-WM2MXsA:9
 a=QRzjZtwMIBQA:10 a=PRpDppDLrCsA:10 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=UqCG9HQmAAAA:8 a=5rkMeDS0mZarB3NswqEA:9 a=GU_NAucQp8_yhqRM:21
 a=frz4AuCg-hUA:10 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
 a=ImwWUX5h3JJ3gRE9moBe:22 a=HXjIzolwW10A:10 a=T6a71-JsGAwA:10
 a=v10HlyRyNeVhbzM4Lqgd:22 a=ejRDv7XJuw7nbi7PrmUL:22 a=FdTzh2GWekK77mhwV6Dw:22
 a=NJcUIoPEKLAEIzHnl83t:22 a=SynsAy1IjJfI1QyGdTg5:22 a=s57Xr27pIc281qfTS48n:22
 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDI0MSBTYWx0ZWRfX2+6cWexC/Ra1
 koIw7PkYwL201lr7zBgStQwGrGl/8Ba5mBpVkhO0FyUEVhxEkCv9T64ZMb8ZRTYh0O40G7thboo
 fgXdIJgw5FJr5a1QaeK3pqGppr7pPZeN84eZldCvMQYiM5DWcg9l
X-Proofpoint-Virus-Version: 
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060241
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 23:56:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4449

--------------b4JgvTts2nOllwOg6rjB65pY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 666Njxx6178669

On 2026-07-03 03:47, J, Sandeep wrote:
> Hi=C2=A0Randy,
> I=C2=A0found=C2=A0the=C2=A0exact=C2=A0replacement=C2=A0links=C2=A0for=C2=
=A0both=C2=A0dead=C2=A0gmane.org=C2=A0references.=C2=A0Here=C2=A0is=C2=A0=
how=C2=A0I=C2=A0found=C2=A0them:
> *Approach:*
>
> 1.
>     Used
>     telnet news.gmane.io 119
>     =C2=A0(NNTP)=C2=A0to=C2=A0retrieve=C2=A0the=C2=A0full=C2=A0content=C2=
=A0and=C2=A0Message-IDs=C2=A0of=C2=A0both=C2=A0original=C2=A0messages:
>      *
>         *gmane=C2=A06281 *=E2=86=92=C2=A0Message-ID: |1431459640.5005.4=
21.camel@intel.com|
>      *
>         *gmane=C2=A06275 *=E2=86=92=C2=A0Message-ID: |1431351733.5005.3=
44.camel@intel.com|
> 2.
>     Used=C2=A0these=C2=A0Message-IDs=C2=A0to=C2=A0search *mail-archive.=
com *(
>     |https://www.mail-archive.com/dev@lists.tizen.org/|)=C2=A0and=C2=A0=
found=C2=A0the=C2=A0exact=C2=A0matching=C2=A0messages.
> 3.
>     Verified=C2=A0by=C2=A0confirming=C2=A0both *Message-ID *and *email=C2=
=A0body=C2=A0content
>     *match=C2=A0exactly.
>

Straight out of the 1990s ! ;-)

> 1.
>
>
> *Replacement=C2=A0links:*
> |[1] https:///www.mail-archive.com/dev@lists.tizen.org/msg06106.html/ |
> |[2] https:///www.mail-archive.com/dev@lists.tizen.org/msg06100.html/ |
> *Verification:*
>
>  *
>     msg06106=C2=A0=E2=80=94=C2=A0Patrick=C2=A0Ohly, Re: [Dev] IMA/EVM,=C2=
=A012=C2=A0May=C2=A02015,=C2=A0Message-ID:1431459640.5005.421.camel@intel=
.com - matches=C2=A0gmane=C2=A06281
>   *
>     msg06100=E2=80=94=C2=A0Patrick=C2=A0Ohly, Re: [Dev] IMA/EVM,=C2=A01=
1=C2=A0May=C2=A02015,=C2=A0Message-ID:1431351733.5005.344.camel@intel.com=
 -matches=C2=A0gmane=C2=A06275
>
> Both=C2=A0Message-IDs=C2=A0and=C2=A0email=C2=A0body=C2=A0content=C2=A0a=
re=C2=A0confirmed=C2=A0to=C2=A0match=C2=A0the=C2=A0original=C2=A0messages.
> May=C2=A0I=C2=A0update=C2=A0the=C2=A0patch=C2=A0with=C2=A0these=C2=A0re=
placement=C2=A0links=C2=A0and=C2=A0resend?

Sure, that works for me and might for Scott and Marta who are the layer=20
mantainers.

../Randy

>
> Thanks & Regards,
>
> *Sandeep J*
> Engineer - Sys /=E2=80=93 Bangalore/
>
> //
>
> Wind River <https://www.windriver.com/>
>
> Together for the Future
>
>
> -----------------------------------------------------------------------=
-
> *From:* MacLeod, Randy <Randy.MacLeod@windriver.com>
> *Sent:* Thursday, June 25, 2026 8:04 PM
> *To:* J, Sandeep <Sandeep.J@windriver.com>;=20
> yocto-patches@lists.yoctoproject.org=20
> <yocto-patches@lists.yoctoproject.org>
> *Cc:* Komati, Shiva <Shiva.Komati@windriver.com>
> *Subject:* Re: [meta-security][PATCH 1/1] README: fix broken URLs in=20
> meta-integrity and ccs-tools
> On 2026-06-25 01:18, Sandeep J wrote:
>> Update TOMOYO documentation URL:
>>     http://tomoyo.sourceforge.jp/1.8/index.html.en
>> to:
>>     https://tomoyo.sourceforge.net/1.8/index.html.en
>>
>> Replace dead gmane.org permalink references with Wayback Machine
>> archived copies of the original Tizen dev mailing list thread:
>>     http://permalink.gmane.org/gmane.comp.handhelds.tizen.devel/6281
>> to:
>>     https://web.archive.org/web/20191020122234/https://lists.tizen.org=
/pipermail/dev/2015-May/006399.html
>>
>>     http://permalink.gmane.org/gmane.comp.handhelds.tizen.devel/6275
>> to:
>>     https://web.archive.org/web/20210620014038/https://lists.tizen.org=
/pipermail/dev/2015-May/thread.html
>>
>> Signed-off-by: Sandeep J<Sandeep.J@windriver.com>
>> ---
>>   meta-integrity/README.md     | 4 ++--
>>   recipes-mac/ccs-tools/README | 2 +-
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/meta-integrity/README.md b/meta-integrity/README.md
>> index 92d24f8..9aeac60 100644
>> --- a/meta-integrity/README.md
>> +++ b/meta-integrity/README.md
>> @@ -270,5 +270,5 @@ No package manager is integrated with IMA/EVM. Whe=
n updating packages,
>>   files will end up getting installed without correct IMA/EVM attribut=
es
>>   and thus will not be usable when appraisal is turned on.
>>  =20
>> -[1]http://permalink.gmane.org/gmane.comp.handhelds.tizen.devel/6281
>> -[2]http://permalink.gmane.org/gmane.comp.handhelds.tizen.devel/6275
>> +[1]https://web.archive.org/web/20191020122234/https://lists.tizen.org=
/pipermail/dev/2015-May/006399.html
> Seems right or at least close, but I'd feel better if we could find=20
> the original mirrored content
> and if the message number didn't change or we understood why it did=20
> change.
>> +[2]https://web.archive.org/web/20210620014038/https://lists.tizen.org=
/pipermail/dev/2015-May/thread.html
> This link is not as useful and probably a bad idea to make this change.
>
> Please work on this for another hour or two to find mirrored copies.
> AI can help.
>
> Hint:
> https://news.gmane.io/ <https://news.gmane.io/>
> If you can find an NNTP viewer, that woudl be good - I think=20
> thunderbird has one.
>
>
> My gemini logs:
> https://www.google.com/search?q=3Dpermalink.gmane.org%2Fgmane.comp.hand=
helds.tizen.devel%2F6281&sca_esv=3D4f4e6eb4e747ddd2&hl=3Den&sxsrf=3DAPpeQ=
nt0iPDEqalwKD8T2TqgX8CzQmYhNg%3A1782396917851&fbs=3DABfTbFVyMZGZf1hfvX9uK=
jN_-G8cxpBkeIeqYwoCbfNVc4vKEzfJsZm6euHh2bPtNTAJBYDOov6zpOjT0O1kBN4V557jRm=
7HhIWF6QfZdhVfvcaeZf65iVNh6IqRreAOsl3C3Lgd_tKzdvudVe3dSNVukr4H6pIpgargvwA=
pL0OqF1JFbdYwZbtJM5eEhzfwywuhr_9UaDku7aFS9XUIyFMmdWJChNV1hg&aep=3D1&ntc=3D=
1&sa=3DX&ved=3D2ahUKEwii-Iv5yaKVAxXj78kDHV4rMc0Q2J8OegQIDxAD&biw=3D1773&b=
ih=3D893&dpr=3D1.09&mstk=3DAUtExfDV3udALZ7C14s8vpNSl7ciyW1qt5r3uOyX2LdaeQ=
UkaL-n2LC1wiI9Vx5Guo_RU65I2v67RTaneu7SDlncnkcEdyYDdb7BfvGpC8OgJrs6j93VOMB=
VK0qTyRl0a3mkmdFWqYdb_FyJ2L7U61gUVWf7CqksiaqGjbcL4myrPVvflUi51X71U12_LE-u=
igFD3yLApy8yq7TWDflDcSjuUJubiuW4QtcBdlS2VbzjlMiQSoBbjunIy20m_j35EiBztrAGp=
pMyPdL6hrn0xqEklCtJFo2qskxIBw6XqSIyN1i2yZw3WdNBqKhIcBA-bMxVJKkSwhDoS4sqef=
vQ1rZDu8wUlbZWS0aXOoY6e_qbU5CQdvhhBi8mn0Y&csuir=3D1&mtid=3D_zc9asScMvzjru=
EP2OyNqAM&udm=3D50=20
> <https://www.google.com/search?q=3Dpermalink.gmane.org%2Fgmane.comp.han=
dhelds.tizen.devel%2F6281&sca_esv=3D4f4e6eb4e747ddd2&hl=3Den&sxsrf=3DAPpe=
Qnt0iPDEqalwKD8T2TqgX8CzQmYhNg%3A1782396917851&fbs=3DABfTbFVyMZGZf1hfvX9u=
KjN_-G8cxpBkeIeqYwoCbfNVc4vKEzfJsZm6euHh2bPtNTAJBYDOov6zpOjT0O1kBN4V557jR=
m7HhIWF6QfZdhVfvcaeZf65iVNh6IqRreAOsl3C3Lgd_tKzdvudVe3dSNVukr4H6pIpgargvw=
ApL0OqF1JFbdYwZbtJM5eEhzfwywuhr_9UaDku7aFS9XUIyFMmdWJChNV1hg&aep=3D1&ntc=3D=
1&sa=3DX&ved=3D2ahUKEwii-Iv5yaKVAxXj78kDHV4rMc0Q2J8OegQIDxAD&biw=3D1773&b=
ih=3D893&dpr=3D1.09&mstk=3DAUtExfDV3udALZ7C14s8vpNSl7ciyW1qt5r3uOyX2LdaeQ=
UkaL-n2LC1wiI9Vx5Guo_RU65I2v67RTaneu7SDlncnkcEdyYDdb7BfvGpC8OgJrs6j93VOMB=
VK0qTyRl0a3mkmdFWqYdb_FyJ2L7U61gUVWf7CqksiaqGjbcL4myrPVvflUi51X71U12_LE-u=
igFD3yLApy8yq7TWDflDcSjuUJubiuW4QtcBdlS2VbzjlMiQSoBbjunIy20m_j35EiBztrAGp=
pMyPdL6hrn0xqEklCtJFo2qskxIBw6XqSIyN1i2yZw3WdNBqKhIcBA-bMxVJKkSwhDoS4sqef=
vQ1rZDu8wUlbZWS0aXOoY6e_qbU5CQdvhhBi8mn0Y&csuir=3D1&mtid=3D_zc9asScMvzjru=
EP2OyNqAM&udm=3D50>
>
> https://share.google/aimode/vjuPYowmMCcpBIinG=20
> <https://share.google/aimode/vjuPYowmMCcpBIinG>
>
> https://share.google/aimode/NJ8G2uhAhZskAHVMp=20
> <https://share.google/aimode/NJ8G2uhAhZskAHVMp>
>
> Keep digging,
>
> ../Randy
>
>
>> diff --git a/recipes-mac/ccs-tools/README b/recipes-mac/ccs-tools/READ=
ME
>> index 0381814..dffb933 100644
>> --- a/recipes-mac/ccs-tools/README
>> +++ b/recipes-mac/ccs-tools/README
>> @@ -1,5 +1,5 @@
>>   Documentation:
>> -http://tomoyo.sourceforge.jp/1.8/index.html.en
>> +https://tomoyo.sourceforge.net/1.8/index.html.en
>>  =20
>>  =20
>>   To start via command line add:
>
>
> --=20
> # Randy MacLeod
> # Wind River Linux


--=20
# Randy MacLeod
# Wind River Linux

--------------b4JgvTts2nOllwOg6rjB65pY
Content-Type: multipart/related;
 boundary="------------fZcqiqmDlW8uEtIJnE9xDBj9"

--------------fZcqiqmDlW8uEtIJnE9xDBj9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <head>

   =20
  </head>
  <body>
    <div class=3D"moz-cite-prefix">On 2026-07-03 03:47, J, Sandeep wrote:<b=
r>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:IA0PR11MB7259DB4675595D599ED7592B=
F7F42@IA0PR11MB7259.namprd11.prod.outlook.com">
     =20
      <style type=3D"text/css" style=3D"display:none;">P {margin-top:0;marg=
in-bottom:0;}</style>
      <div class=3D"elementToProof" style=3D"text-align: left; text-indent:=
 0px; margin-top: 1em; margin-bottom: 1em; padding-bottom: 1px; font-family=
: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
        Hi&nbsp;Randy,</div>
      <div class=3D"elementToProof" style=3D"text-align: left; text-indent:=
 0px; margin-top: 1em; margin-bottom: 1em; padding-bottom: 1px; font-family=
: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
I&nbsp;found&nbsp;the&nbsp;exact&nbsp;replacement&nbsp;links&nbsp;for&nbsp;=
both&nbsp;dead&nbsp;gmane.org&nbsp;references.&nbsp;Here&nbsp;is&nbsp;how&n=
bsp;I&nbsp;found&nbsp;them:</div>
      <div class=3D"elementToProof" style=3D"text-align: left; text-indent:=
 0px; margin-top: 1em; margin-bottom: 1em; padding-bottom: 1px; font-family=
: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <b>Approach:</b></div>
      <ol start=3D"1" style=3D"text-align: left; padding-left: 26px;">
        <li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSe=
rvice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
; margin-bottom: 0.4em;">
          <div class=3D"elementToProof" role=3D"presentation" style=3D"marg=
in-top: 1em; margin-bottom: 1em; padding-bottom: 1px;">
            Used&nbsp;</div>
          <pre class=3D"elementToProof" role=3D"presentation" style=3D"marg=
in: 0px; max-width: 100%; display: inline;">telnet news.gmane.io 119</pre>
&nbsp;(NNTP)&nbsp;to&nbsp;retrieve&nbsp;the&nbsp;full&nbsp;content&nbsp;and=
&nbsp;Message-IDs&nbsp;of&nbsp;both&nbsp;original&nbsp;messages:</li>
        <ul style=3D"padding-left: 26px;">
          <li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFont=
Service, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, =
0);">
            <div class=3D"elementToProof" role=3D"presentation" style=3D"ma=
rgin-top: 1em; margin-bottom: 1em; padding-bottom: 1px;">
              <b>gmane&nbsp;6281 </b>=E2=86=92&nbsp;Message-ID: <code style=
=3D"display: inline;"><a class=3D"moz-txt-link-abbreviated" href=3D"mailto:=
1431459640.5005.421.camel@intel.com">1431459640.5005.421.camel@intel.com</a=
></code></div>
          </li>
          <li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFont=
Service, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, =
0);">
            <div class=3D"elementToProof" role=3D"presentation" style=3D"ma=
rgin-top: 1em; margin-bottom: 1em; padding-bottom: 1px;">
              <b>gmane&nbsp;6275 </b>=E2=86=92&nbsp;Message-ID: <code style=
=3D"display: inline;"><a class=3D"moz-txt-link-abbreviated" href=3D"mailto:=
1431351733.5005.344.camel@intel.com">1431351733.5005.344.camel@intel.com</a=
></code></div>
          </li>
        </ul>
        <li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSe=
rvice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
; margin-bottom: 0.4em;">
          <div class=3D"elementToProof" role=3D"presentation" style=3D"marg=
in-top: 1em; margin-bottom: 1em; padding-bottom: 1px;">
            Used&nbsp;these&nbsp;Message-IDs&nbsp;to&nbsp;search <b>mail-ar=
chive.com </b>(
            <code style=3D"display: inline;">
              <a class=3D"moz-txt-link-freetext" href=3D"https://www.mail-a=
rchive.com/dev@lists.tizen.org/">https://www.mail-archive.com/dev@lists.tiz=
en.org/</a></code>)&nbsp;and&nbsp;found&nbsp;the&nbsp;exact&nbsp;matching&n=
bsp;messages.</div>
        </li>
        <li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSe=
rvice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
; margin-bottom: 0.4em;">
          <div class=3D"elementToProof" role=3D"presentation" style=3D"marg=
in-top: 1em; margin-bottom: 1em; padding-bottom: 1px;">
            Verified&nbsp;by&nbsp;confirming&nbsp;both <b>Message-ID </b>an=
d <b>email&nbsp;body&nbsp;content
            </b>match&nbsp;exactly.</div>
        </li>
      </ol>
    </blockquote>
    <p><br>
    </p>
    <p>Straight out of the 1990s ! ;-)</p>
    <blockquote type=3D"cite" cite=3D"mid:IA0PR11MB7259DB4675595D599ED7592B=
F7F42@IA0PR11MB7259.namprd11.prod.outlook.com">
      <ol start=3D"1" style=3D"text-align: left; padding-left: 26px;">
        <li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSe=
rvice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
; margin-bottom: 0.4em;"><br>
        </li>
      </ol>
      <div class=3D"elementToProof" style=3D"text-align: left; text-indent:=
 0px; margin-top: 1em; margin-bottom: 1em; padding-bottom: 1px; font-family=
: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <b>Replacement&nbsp;links:</b></div>
      <div class=3D"elementToProof" style=3D"text-align: left; text-indent:=
 0px; margin-top: 1em; margin-bottom: 1em; padding-bottom: 1px; font-family=
: &quot;Droid Sans Mono&quot;, monospace; font-size: 12pt; color: rgb(0, 0,=
 0);">
        <code style=3D"font-family: &quot;Droid Sans Mono&quot;, monospace;=
">[1]
          https:<i>//www.mail-archive.com/dev@lists.tizen.org/msg06106.html=
</i>
        </code></div>
      <div class=3D"elementToProof" style=3D"text-align: left; text-indent:=
 0px; margin-top: 1em; margin-bottom: 1em; padding-bottom: 1px; font-family=
: &quot;Droid Sans Mono&quot;, monospace; font-size: 12pt; color: rgb(0, 0,=
 0);">
        <code style=3D"font-family: &quot;Droid Sans Mono&quot;, monospace;=
">[2]
          https:<i>//www.mail-archive.com/dev@lists.tizen.org/msg06100.html=
</i>
        </code></div>
      <div class=3D"elementToProof" style=3D"text-align: left; text-indent:=
 0px; margin-top: 1em; margin-bottom: 1em; padding-bottom: 1px; font-family=
: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <b>Verification:</b></div>
      <ul style=3D"text-align: left; padding-left: 26px;">
        <li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSe=
rvice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
; margin-bottom: 0.4em;">
          <pre class=3D"elementToProof" role=3D"presentation" style=3D"marg=
in: 0px; max-width: 100%; display: inline;">msg06106&nbsp;=E2=80=94&nbsp;Pa=
trick&nbsp;Ohly, Re: [Dev] IMA/EVM,&nbsp;12&nbsp;May&nbsp;2015,&nbsp;Messag=
e-ID: <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:1431459640.5005.=
421.camel@intel.com">1431459640.5005.421.camel@intel.com</a> - matches&nbsp=
;gmane&nbsp;6281</pre>
        </li>
        <li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontSe=
rvice, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
; margin-bottom: 0.4em;">
          <pre class=3D"elementToProof" role=3D"presentation" style=3D"marg=
in: 0px; max-width: 100%; display: inline;">msg06100=E2=80=94&nbsp;Patrick&=
nbsp;Ohly, Re: [Dev] IMA/EVM,&nbsp;11&nbsp;May&nbsp;2015,&nbsp;Message-ID: =
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:1431351733.5005.344.ca=
mel@intel.com">1431351733.5005.344.camel@intel.com</a> -matches&nbsp;gmane&=
nbsp;6275</pre>
        </li>
      </ul>
      <div class=3D"elementToProof" style=3D"text-align: left; text-indent:=
 0px; margin-top: 1em; margin-bottom: 1em; padding-bottom: 1px; font-family=
: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
Both&nbsp;Message-IDs&nbsp;and&nbsp;email&nbsp;body&nbsp;content&nbsp;are&n=
bsp;confirmed&nbsp;to&nbsp;match&nbsp;the&nbsp;original&nbsp;messages.</div=
>
      <div class=3D"elementToProof" style=3D"text-align: left; text-indent:=
 0px; margin-top: 1em; margin-bottom: 1em; padding-bottom: 1px; font-family=
: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
        May&nbsp;I&nbsp;update&nbsp;the&nbsp;patch&nbsp;with&nbsp;these&nbs=
p;replacement&nbsp;links&nbsp;and&nbsp;resend?</div>
    </blockquote>
    <p>Sure, that works for me and might for Scott and Marta who are the
      layer mantainers.<br>
      <br>
    </p>
    <p>../Randy</p>
    <blockquote type=3D"cite" cite=3D"mid:IA0PR11MB7259DB4675595D599ED7592B=
F7F42@IA0PR11MB7259.namprd11.prod.outlook.com">
      <div class=3D"elementToProof" style=3D"text-align: left; text-indent:=
 0px; margin-top: 1em; margin-bottom: 1em; padding-bottom: 1px; font-family=
: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-=
serif; font-size: 12pt; color: rgb(0, 0, 0);">
        <br>
      </div>
      <div id=3D"Signature" class=3D"elementToProof">
        <p class=3D"elementToProof" style=3D"line-height: 20px; margin-top:=
 1em; margin-bottom: 15pt;">
          <span style=3D"font-family: &quot;Segoe UI&quot;; font-size: 14px=
; color: rgb(0, 0, 0);">Thanks
            &amp; Regards,</span></p>
        <div class=3D"elementToProof" style=3D"line-height: 20px; margin-to=
p: 1em; margin-bottom: 15pt;">
          <span style=3D"font-family: Helvetica, sans-serif; font-size: 12p=
t; color: rgb(0, 173, 164);"><b>Sandeep
              J</b></span><span style=3D"font-family: Helvetica, sans-serif=
; font-size: 10.5pt; color: rgb(21, 21, 21);"><br>
          </span><span style=3D"font-family: &quot;Segoe UI&quot;; font-siz=
e: 14px; color: rgb(0, 0, 0);">Engineer
            - Sys
          </span><span style=3D"font-family: Helvetica, sans-serif; font-si=
ze: 10pt; color: rgb(21, 21, 21);"><i>=E2=80=93
              Bangalore</i></span></div>
        <p class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom=
: 15pt;"><span style=3D"font-family: Helvetica, sans-serif; font-size: 10.5=
pt; color: rgb(21, 21, 21);"><i><img id=3D"x_x__x0000_i1027" width=3D"160" =
height=3D"8" style=3D"width: 1.6736in; height: 0.0902in; max-width: 648px; =
min-width: auto; min-height: auto; margin-top: 0px; margin-bottom: 0px;" si=
ze=3D"156" data-outlook-trace=3D"F:1|T:1" src=3D"cid:part1.mh4XCxgy.sQFUFH4=
0@windriver.com" class=3D""></i></span></p>
        <p class=3D"elementToProof" style=3D"margin: 1em 0in 9pt;"><span st=
yle=3D"font-family: &quot;Times New Roman&quot;, serif; font-size: 13.5pt; =
color: blue;"><a href=3D"https://www.windriver.com/" target=3D"_blank" id=
=3D"OWAbfc7e61a-3374-06dc-05a2-a2d821a53257" class=3D"OWAAutoLink" title=3D=
"https://www.windriver.com/" rel=3D"noopener noreferrer" style=3D"color: bl=
ue; margin-top: 0px; margin-bottom: 0px;" moz-do-not-send=3D"true"><img alt=
=3D"Wind River" id=3D"x_x_Picture_x0020_1" width=3D"148" height=3D"25" styl=
e=3D"width: 1.5486in; height: 0.2638in; max-width: 648px; min-width: auto; =
min-height: auto; margin-top: 0px; margin-bottom: 0px;" size=3D"10124" data=
-outlook-trace=3D"F:1|T:1" src=3D"cid:part2.U7BFGiLO.P08e1vls@windriver.com=
" class=3D""></a></span></p>
        <p class=3D"elementToProof" style=3D"margin-top: 1em; margin-bottom=
: 1em;"><span style=3D"font-family: &quot;Times New Roman&quot;, serif; fon=
t-size: 13.5pt; color: black;"><img alt=3D"Together for the Future" id=3D"x=
_x_Picture_x0020_3" width=3D"349" height=3D"96" style=3D"width: 3.6458in; h=
eight: 1in; max-width: 648px; min-width: auto; min-height: auto; margin-top=
: 0px; margin-bottom: 0px;" size=3D"24559" data-outlook-trace=3D"F:1|T:1" s=
rc=3D"cid:part3.4qYFp89I.WTVyiM0I@windriver.com" class=3D""></span></p>
        <div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_Em=
beddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size:=
 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
      </div>
      <hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
      <div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-ser=
if" style=3D"font-size:11pt" color=3D"#000000"><b>From:</b> MacLeod,
          Randy <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:Randy.Mac=
Leod@windriver.com">&lt;Randy.MacLeod@windriver.com&gt;</a><br>
          <b>Sent:</b> Thursday, June 25, 2026 8:04 PM<br>
          <b>To:</b> J, Sandeep <a class=3D"moz-txt-link-rfc2396E" href=3D"=
mailto:Sandeep.J@windriver.com">&lt;Sandeep.J@windriver.com&gt;</a>;
          <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:yocto-patche=
s@lists.yoctoproject.org">yocto-patches@lists.yoctoproject.org</a>
          <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:yocto-patches@l=
ists.yoctoproject.org">&lt;yocto-patches@lists.yoctoproject.org&gt;</a><br>
          <b>Cc:</b> Komati, Shiva <a class=3D"moz-txt-link-rfc2396E" href=
=3D"mailto:Shiva.Komati@windriver.com">&lt;Shiva.Komati@windriver.com&gt;</=
a><br>
          <b>Subject:</b> Re: [meta-security][PATCH 1/1] README: fix
          broken URLs in meta-integrity and ccs-tools</font>
        <div>&nbsp;</div>
      </div>
      <div>
        <div class=3D"x_moz-cite-prefix">On 2026-06-25 01:18, Sandeep J
          wrote:<br>
        </div>
        <blockquote type=3D"cite">
          <pre class=3D"x_moz-quote-pre">Update TOMOYO documentation URL:
   <a class=3D"moz-txt-link-freetext" href=3D"http://tomoyo.sourceforge.jp/=
1.8/index.html.en">http://tomoyo.sourceforge.jp/1.8/index.html.en</a>
to:
   <a class=3D"moz-txt-link-freetext" href=3D"https://tomoyo.sourceforge.ne=
t/1.8/index.html.en">https://tomoyo.sourceforge.net/1.8/index.html.en</a>

Replace dead gmane.org permalink references with Wayback Machine
archived copies of the original Tizen dev mailing list thread:
   <a class=3D"moz-txt-link-freetext" href=3D"http://permalink.gmane.org/gm=
ane.comp.handhelds.tizen.devel/6281">http://permalink.gmane.org/gmane.comp.=
handhelds.tizen.devel/6281</a>
to:
   <a class=3D"moz-txt-link-freetext" href=3D"https://web.archive.org/web/2=
0191020122234/https://lists.tizen.org/pipermail/dev/2015-May/006399.html">h=
ttps://web.archive.org/web/20191020122234/https://lists.tizen.org/pipermail=
/dev/2015-May/006399.html</a>

   <a class=3D"moz-txt-link-freetext" href=3D"http://permalink.gmane.org/gm=
ane.comp.handhelds.tizen.devel/6275">http://permalink.gmane.org/gmane.comp.=
handhelds.tizen.devel/6275</a>
to:
   <a class=3D"moz-txt-link-freetext" href=3D"https://web.archive.org/web/2=
0210620014038/https://lists.tizen.org/pipermail/dev/2015-May/thread.html">h=
ttps://web.archive.org/web/20210620014038/https://lists.tizen.org/pipermail=
/dev/2015-May/thread.html</a>

Signed-off-by: Sandeep J <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:=
Sandeep.J@windriver.com">&lt;Sandeep.J@windriver.com&gt;</a>
---
 meta-integrity/README.md     | 4 ++--
 recipes-mac/ccs-tools/README | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/meta-integrity/README.md b/meta-integrity/README.md
index 92d24f8..9aeac60 100644
--- a/meta-integrity/README.md
+++ b/meta-integrity/README.md
@@ -270,5 +270,5 @@ No package manager is integrated with IMA/EVM. When upd=
ating packages,
 files will end up getting installed without correct IMA/EVM attributes
 and thus will not be usable when appraisal is turned on.
=20
-[1] <a class=3D"moz-txt-link-freetext" href=3D"http://permalink.gmane.org/=
gmane.comp.handhelds.tizen.devel/6281">http://permalink.gmane.org/gmane.com=
p.handhelds.tizen.devel/6281</a>
-[2] <a class=3D"moz-txt-link-freetext" href=3D"http://permalink.gmane.org/=
gmane.comp.handhelds.tizen.devel/6275">http://permalink.gmane.org/gmane.com=
p.handhelds.tizen.devel/6275</a>
+[1] <a class=3D"moz-txt-link-freetext" href=3D"https://web.archive.org/web=
/20191020122234/https://lists.tizen.org/pipermail/dev/2015-May/006399.html"=
>https://web.archive.org/web/20191020122234/https://lists.tizen.org/piperma=
il/dev/2015-May/006399.html</a></pre>
        </blockquote>
        Seems right or at least close, but I'd feel better if we could
        find the original mirrored content<br>
        and if the message number didn't change or we understood why it
        did change.
        <blockquote type=3D"cite">
          <pre class=3D"x_moz-quote-pre">+[2] <a class=3D"moz-txt-link-free=
text" href=3D"https://web.archive.org/web/20210620014038/https://lists.tize=
n.org/pipermail/dev/2015-May/thread.html">https://web.archive.org/web/20210=
620014038/https://lists.tizen.org/pipermail/dev/2015-May/thread.html</a></p=
re>
        </blockquote>
        This link is not as useful and probably a bad idea to make this
        change.<br>
        <br>
        Please work on this for another hour or two to find mirrored
        copies.<br>
        AI can help.<br>
        <br>
        Hint:<br>
        <a class=3D"x_moz-txt-link-freetext moz-txt-link-freetext" href=3D"=
https://news.gmane.io/" moz-do-not-send=3D"true">https://news.gmane.io/</a>=
<br>
        If you can find an NNTP viewer, that woudl be good - I think
        thunderbird has one.<br>
        <br>
        <br>
        My gemini logs:<br>
        <a class=3D"x_moz-txt-link-freetext" href=3D"https://www.google.com=
/search?q=3Dpermalink.gmane.org%2Fgmane.comp.handhelds.tizen.devel%2F6281&a=
mp;sca_esv=3D4f4e6eb4e747ddd2&amp;hl=3Den&amp;sxsrf=3DAPpeQnt0iPDEqalwKD8T2=
TqgX8CzQmYhNg%3A1782396917851&amp;fbs=3DABfTbFVyMZGZf1hfvX9uKjN_-G8cxpBkeIe=
qYwoCbfNVc4vKEzfJsZm6euHh2bPtNTAJBYDOov6zpOjT0O1kBN4V557jRm7HhIWF6QfZdhVfvc=
aeZf65iVNh6IqRreAOsl3C3Lgd_tKzdvudVe3dSNVukr4H6pIpgargvwApL0OqF1JFbdYwZbtJM=
5eEhzfwywuhr_9UaDku7aFS9XUIyFMmdWJChNV1hg&amp;aep=3D1&amp;ntc=3D1&amp;sa=3D=
X&amp;ved=3D2ahUKEwii-Iv5yaKVAxXj78kDHV4rMc0Q2J8OegQIDxAD&amp;biw=3D1773&am=
p;bih=3D893&amp;dpr=3D1.09&amp;mstk=3DAUtExfDV3udALZ7C14s8vpNSl7ciyW1qt5r3u=
OyX2LdaeQUkaL-n2LC1wiI9Vx5Guo_RU65I2v67RTaneu7SDlncnkcEdyYDdb7BfvGpC8OgJrs6=
j93VOMBVK0qTyRl0a3mkmdFWqYdb_FyJ2L7U61gUVWf7CqksiaqGjbcL4myrPVvflUi51X71U12=
_LE-uigFD3yLApy8yq7TWDflDcSjuUJubiuW4QtcBdlS2VbzjlMiQSoBbjunIy20m_j35EiBztr=
AGppMyPdL6hrn0xqEklCtJFo2qskxIBw6XqSIyN1i2yZw3WdNBqKhIcBA-bMxVJKkSwhDoS4sqe=
fvQ1rZDu8wUlbZWS0aXOoY6e_qbU5CQdvhhBi8mn0Y&amp;csuir=3D1&amp;mtid=3D_zc9asS=
cMvzjruEP2OyNqAM&amp;udm=3D50" moz-do-not-send=3D"true">https://www.google.=
com/search?q=3Dpermalink.gmane.org%2Fgmane.comp.handhelds.tizen.devel%2F628=
1&amp;sca_esv=3D4f4e6eb4e747ddd2&amp;hl=3Den&amp;sxsrf=3DAPpeQnt0iPDEqalwKD=
8T2TqgX8CzQmYhNg%3A1782396917851&amp;fbs=3DABfTbFVyMZGZf1hfvX9uKjN_-G8cxpBk=
eIeqYwoCbfNVc4vKEzfJsZm6euHh2bPtNTAJBYDOov6zpOjT0O1kBN4V557jRm7HhIWF6QfZdhV=
fvcaeZf65iVNh6IqRreAOsl3C3Lgd_tKzdvudVe3dSNVukr4H6pIpgargvwApL0OqF1JFbdYwZb=
tJM5eEhzfwywuhr_9UaDku7aFS9XUIyFMmdWJChNV1hg&amp;aep=3D1&amp;ntc=3D1&amp;sa=
=3DX&amp;ved=3D2ahUKEwii-Iv5yaKVAxXj78kDHV4rMc0Q2J8OegQIDxAD&amp;biw=3D1773=
&amp;bih=3D893&amp;dpr=3D1.09&amp;mstk=3DAUtExfDV3udALZ7C14s8vpNSl7ciyW1qt5=
r3uOyX2LdaeQUkaL-n2LC1wiI9Vx5Guo_RU65I2v67RTaneu7SDlncnkcEdyYDdb7BfvGpC8OgJ=
rs6j93VOMBVK0qTyRl0a3mkmdFWqYdb_FyJ2L7U61gUVWf7CqksiaqGjbcL4myrPVvflUi51X71=
U12_LE-uigFD3yLApy8yq7TWDflDcSjuUJubiuW4QtcBdlS2VbzjlMiQSoBbjunIy20m_j35EiB=
ztrAGppMyPdL6hrn0xqEklCtJFo2qskxIBw6XqSIyN1i2yZw3WdNBqKhIcBA-bMxVJKkSwhDoS4=
sqefvQ1rZDu8wUlbZWS0aXOoY6e_qbU5CQdvhhBi8mn0Y&amp;csuir=3D1&amp;mtid=3D_zc9=
asScMvzjruEP2OyNqAM&amp;udm=3D50</a><br>
        <br>
        <a class=3D"x_moz-txt-link-freetext moz-txt-link-freetext" href=3D"=
https://share.google/aimode/vjuPYowmMCcpBIinG" moz-do-not-send=3D"true">htt=
ps://share.google/aimode/vjuPYowmMCcpBIinG</a><br>
        <br>
        <a class=3D"x_moz-txt-link-freetext moz-txt-link-freetext" href=3D"=
https://share.google/aimode/NJ8G2uhAhZskAHVMp" moz-do-not-send=3D"true">htt=
ps://share.google/aimode/NJ8G2uhAhZskAHVMp</a><br>
        <br>
        <p>Keep digging,</p>
        <p>../Randy</p>
        <p><br>
        </p>
        <blockquote type=3D"cite">
          <pre class=3D"x_moz-quote-pre">diff --git a/recipes-mac/ccs-tools=
/README b/recipes-mac/ccs-tools/README
index 0381814..dffb933 100644
--- a/recipes-mac/ccs-tools/README
+++ b/recipes-mac/ccs-tools/README
@@ -1,5 +1,5 @@
 Documentation:
-http://tomoyo.sourceforge.jp/1.8/index.html.en
+https://tomoyo.sourceforge.net/1.8/index.html.en
=20
=20
 To start via command line add:
</pre>
        </blockquote>
        <p><br>
        </p>
        <pre class=3D"x_moz-signature" cols=3D"72">--=20
# Randy MacLeod
# Wind River Linux</pre>
      </div>
    </blockquote>
    <p><br>
    </p>
    <pre class=3D"moz-signature" cols=3D"72">--=20
# Randy MacLeod
# Wind River Linux</pre>
  </body>
</html>=

--------------fZcqiqmDlW8uEtIJnE9xDBj9
Content-Type: image/png; name="image.png"
Content-Disposition: inline; filename="image.png"
Content-Id: <part1.mh4XCxgy.sQFUFH40@windriver.com>
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAAHYAAAAHCAYAAADd2bl1AAAAR0lEQVRIS2P8DwQMo2DYhQDjaMQO
uzgFe2g0YodnvI5G7DCNV0TEMm5ZPlz9OKL89d8nErUoHo3Y4RH/GBE7PLw16gtYCAAAzA4h7A+W
ZKkAAAAQZGVCRzM4RDJGQTZGRUEwNjhFN0QW5jcAAAAAAElFTkSuQmCC

--------------fZcqiqmDlW8uEtIJnE9xDBj9
Content-Type: image/png; name="image.png"
Content-Disposition: inline; filename="image.png"
Content-Id: <part2.U7BFGiLO.P08e1vls@windriver.com>
Content-Transfer-Encoding: base64

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

--------------fZcqiqmDlW8uEtIJnE9xDBj9
Content-Type: image/png; name="image.png"
Content-Disposition: inline; filename="image.png"
Content-Id: <part3.4qYFp89I.WTVyiM0I@windriver.com>
Content-Transfer-Encoding: base64

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

--------------fZcqiqmDlW8uEtIJnE9xDBj9--

--------------b4JgvTts2nOllwOg6rjB65pY--

