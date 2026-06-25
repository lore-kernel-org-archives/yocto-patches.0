Return-Path: <randy.macleod@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFD8CDE00B
	for <webhook@archiver.kernel.org>; Thu, 25 Jun 2026 14:34:26 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12762.1782398065760584567
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Jun 2026 07:34:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=soIgLv3X;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=06364edfb8=randy.macleod@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P6bjsU644402
	for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jun 2026 07:34:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PPS06212021; bh=/HyG+v9QiBaONF8yP9Nh0b
	DszIAuC78LPgcIYG0lIpE=; b=soIgLv3X1cPb1cF34sKMOExkMgdTC2bW55DFRn
	O9KrM15FvVJviV7jGM5LJPonb1fcV2dTUR9JSKLge6UK3Usa9NU3rDjHuPT+N9pz
	AJiftK2AC//oF9Czt/6OBjtkdHtTEv1+e3PNJ27auo1S+CRgOw7r7OUMKuzkzM9P
	HhBAJ+pA88xorI2WFTw7j48Ay/CdXPzd4jblbgmBfb/zh72r2wuxwI8tLCssByin
	FSlPpTqJbqeBKdrElxnIMQqSxLrNBgTU2Bot6kZZ513wSWgYTKoNHYiEjN93l7lp
	RlnhdkMvxqvB/bZZD4y/ofpgyrf0Abp/5jpdP14IrzSw9JPw==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012043.outbound.protection.outlook.com [52.101.53.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4f0t06gtax-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jun 2026 07:34:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qAKW6e/oVniWAAq0gH3IFjc0b3CZ5A3C3NsfI5PaYWZpWfsynA0srUt/tdLRO/DypsCl1IIscSNjRNxlfCWLMMWmjEz2b/DxcPIKrTdoS4l25pAYpoU0Fq0dczEx+wB/NRiuUs545Yd89MYO40sPlwhLHmtoYM622NNrd0BnLkm8v3h/sxmIWukMCflEm8Gt1hpyiM+mp/Prr2/AiI8RhwQqRQrWC1Ys8JcfUk9F41lSg7HcJzu7Bh6no74uqmWCeWuvWIP39x0/yRIhrr09sZ8Pusyn9XJKXvZkl39hOsl2ZPvofHxyZj0zJBXkI1GtkdwZKckqv6Q97OasNtEYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HyG+v9QiBaONF8yP9Nh0bDszIAuC78LPgcIYG0lIpE=;
 b=Vsq80/zLrIHuN/U4bq0KLMSKeICWvZ2dJpHShmMGja0IfzcXtGNze7rzDudf++9g01hrLn9aSlBco+n19Tzpje20od1M8r/0y5EGgYdAbojbiZJ5/Brg3FbDd4HL0BqPMkr2dRlnZUTvE44r43W9sC8YB3OVBM/EJQyhLLrU3fNef4uZo1vyFS+Lu+ef5Q9bNjinPRCDHoSZ3ohS7H5T1pNQ6PKuLdhh+g5Ssz05R7kysfMmHM9Z+sE74EMess4bbNvJ36WrcxMG9WEwoF1NZbUj1mIIqiGCYohrDWLxsbxi192Z7A78rJ+Y5y5sjBTqp19yyCEwdQKwvXe4/+Quig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8496.namprd11.prod.outlook.com (2603:10b6:610:1ba::22)
 by DS4PPFE12D62847.namprd11.prod.outlook.com (2603:10b6:f:fc02::58) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Thu, 25 Jun
 2026 14:34:19 +0000
Received: from CH3PR11MB8496.namprd11.prod.outlook.com
 ([fe80::5627:e3a5:cb26:b555]) by CH3PR11MB8496.namprd11.prod.outlook.com
 ([fe80::5627:e3a5:cb26:b555%4]) with mapi id 15.21.0159.012; Thu, 25 Jun 2026
 14:34:18 +0000
Content-Type: multipart/alternative;
 boundary="------------iGzhhPEQMUmKZx9pbUisdmkb"
Message-ID: <b8386479-b575-4efc-8b81-8b45a592029f@windriver.com>
Date: Thu, 25 Jun 2026 10:34:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-security][PATCH 1/1] README: fix broken URLs in
 meta-integrity and ccs-tools
To: Sandeep J <Sandeep.J@windriver.com>, yocto-patches@lists.yoctoproject.org
Cc: Shiva.Komati@windriver.com
References: <20260625051816.1844262-1-Sandeep.J@windriver.com>
 <20260625051816.1844262-2-Sandeep.J@windriver.com>
Content-Language: en-CA
From: Randy MacLeod <randy.macleod@windriver.com>
In-Reply-To: <20260625051816.1844262-2-Sandeep.J@windriver.com>
X-ClientProxiedBy: YT4PR01CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::27) To CH3PR11MB8496.namprd11.prod.outlook.com
 (2603:10b6:610:1ba::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8496:EE_|DS4PPFE12D62847:EE_
X-MS-Office365-Filtering-Correlation-Id: de8a4e43-907d-42b5-ed9b-08ded2c6d6f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|8096899003|18002099003|6133799003|13003099007|22082099003|4133799003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	V+fPeq7M6mJmy+pQhF1D8u98wRlcUGuT/RqS7fBAqWeLFZY1CPsDLEMKv/3++8UT1mvOCrSGwbmFEv23f/sE8bW5hSB7zIwduwYuyIP9HaI75sUbxY05eskYZSKPEhtijDgN4pV2PXo4TT11Sm/9eUb5xS9JG+sMiOHcU5SWQaKTUGAc1QDZxScN6cILRz2/yAsoZPVat4qmANwwC/HYq6hkBG5rVQMVN2N51osmuxVQd59gIXDtAjhA96t57EJPJ70A7FNDKRYRAgwtcHkN+V1uByFIjVhz+b3IBh9Tqhyk80s0P0zy+y3PmW+qMRW1K+AdjoakUFARcc0NuZlsorx6jIXXtqNf65N3bfgG4WjiMUIEjFMxtngKYQWwUSRLcCcgDfOfO4sxoW6WkSXJqvRXPAHEi8y4uMlqhJS7oyHeY2pchtGz4Kq6XSu5z+LjbPV3FCRwtC0E+Fli0tRRFnhpHz8SHlyLb6qLc5O6OZH75el28aKGWYYqAKxdwi8vXV8rextIYJohIW9GZPPFb4SPdqUk5nXSMFljbkJYyscUMueOU8d1HqUH3x3S4+DUzAKUH3goTTi8rH4vyo9g5rwtI5IynF5dKWhckpb/B+0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8496.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(8096899003)(18002099003)(6133799003)(13003099007)(22082099003)(4133799003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TlFqeGNJTmp3OTFIQ1loMUVrV29hZU5XdnhmLzZoQTdKb0lyTTJUSXpoMExS?=
 =?utf-8?B?SU9SUEZyWFBKdWp2Q3pPS3MrbTg4UmI5VHJNMHdHaFdjWWtUZDZ1SzFqcll1?=
 =?utf-8?B?c3ZiR1JoSUpKM3FILzBldDFYMldmQjZkRUFlNWZPYitEa1lKZTRoQ0t2eUZ5?=
 =?utf-8?B?MUJQUldXQzVEdlhpTTJ3QkZjTXZnYlp1TlZYMVhWT3hZWWlZU3NYTDB5dDBP?=
 =?utf-8?B?OGs4UGtyVStKWUxjbmRlcDR4R0tub01kbCs0ajlZV21Rc2l4UVY5dFFDVGly?=
 =?utf-8?B?ZjNKYnIzQlBGWi9KT2FjRnR2MjVrOFh5SVU0MCt0azFQRTNSd2l2Z3dSU3Bt?=
 =?utf-8?B?TlkzS2dDWTRGTjJiT3ZtMmhMV000ODBxdGlFRFlYMkZRNWd0Q1dIVUdBZUJp?=
 =?utf-8?B?SGxCY3paVVBydHZpOU92QXVEY0dlV2E0TE13b25VbkhNVU15WWU0VUVqdlhm?=
 =?utf-8?B?ZlNqbzFnbnBvTGdheEhzZXVyUFNpZzNkK2V1cm9meEE5dGZCTXMrV3VuU2tw?=
 =?utf-8?B?YTI4K2gxL1B2RlpmUmxoOXdBa2NJdmxFR2RxQWJYS3BJY2pDQTdQTTFYTFJE?=
 =?utf-8?B?U0NyYXRHb2xlS2lmbUJLTVhhZ2gyTnFLcjBkSDB3QVFydU81NlU1YS9oalRt?=
 =?utf-8?B?N3FMR1QydEpNb2prSzQycm9FeDl0Q0t1ajNEdENnVloybUtpZzRIeVNCekQ4?=
 =?utf-8?B?eDJUbUZlR09Od3hrUEZjL1BGT2JBN2l2TUx6VU1wd2FGMGdtQjFQMTBLMUtQ?=
 =?utf-8?B?dVprSTB2NWRDUnFHb3lYNmpCVk1sSW96Wkd6b1FBRjZCU2dsNmlZbFhsTk14?=
 =?utf-8?B?MjRIbWhsNHhpWXBIVXZ4ZG5xZWtUN1FvTnV1NkxybU55dFF1aVk0eGNLZWZr?=
 =?utf-8?B?NTJvcmJidUVQNFVYRUFuVzhYd3lHZlkrZVZsM0prSTFvV0xlUVVQc1cwY3BG?=
 =?utf-8?B?VCttWTFHVDRnM1BTTU1TTURacHRQYjdvYVlNU0NyNzB3Vm9YQVJCNjMrYjNF?=
 =?utf-8?B?R3BHbVA3L0NyR3dpWllSU1dmNVFWZk9md1RwVi94aGNkVlNzeURQY3I0UlAr?=
 =?utf-8?B?RzVvZnlSck9yUXFMM1QrMGVmS2VFUU9pd2JMK1BGcFlpbUFsM2xSV0FZY3A2?=
 =?utf-8?B?enNZb3pBWFBJdm0vaktEREtpcXJ0V0ZxeGFWcTR4ODNVQkhaMVVGODI3Q1Jt?=
 =?utf-8?B?ZDQ3aUgrVHQrUEZmL0gvR01pVHVKaEJ4ZG1IUk55WXVOamxiRTZDMzJ0a216?=
 =?utf-8?B?NGJEcGJsYlhSS2QreTZmOS9QQkd1dGJKYzNrdFhzb08rWXhXQVZtTW1qZ1g1?=
 =?utf-8?B?azNyTDNWdDdaZXVMSTQ0TVVUVUI3KytWSktuRmsrcFY0NTB1Qm1qb2pYWU9Q?=
 =?utf-8?B?dFZTTVpscUszazZYb2MzaDZxRXg1a3l0cDdWUWFhaVJXRVpwUnRXTlhkbVlP?=
 =?utf-8?B?RGtJYkZYY000MkRlTG5kT3Z3cWxIY1B0S1VWK3NzTytDSHN0N1pSWXVBdjV2?=
 =?utf-8?B?STA5dG40a3VpYUdBOE13eDhBTXV2bzVYbGtjcitUdVZCYWpXRGZNN0d4czF5?=
 =?utf-8?B?Ni9UbDErTzR5NzVNNGRmeTRjT3YrR3RSYVE0b3JraWZvQzZ0dzhuZVNKZStB?=
 =?utf-8?B?bWUzRjFWcy9ha0tEem1LMFd5Ykk2SFN5cXJwOEEyelpqN0N1YUtSYzBva1pG?=
 =?utf-8?B?WXozczdZZ01wRGg1S0xBZXJBb3NOdEhkUUlsVVBXbS9WNzFRNWJsVVhzVVgr?=
 =?utf-8?B?Z1J1S2k0WHZZRGtVRjNmaHRZc3B5bTdQWHVqdWI3Zk1BRjBkSWlTUzl5YzVu?=
 =?utf-8?B?WlJlcEVJMDh0NW8xY011SlFJRHI2QjNYa09TeE1LdDZkMWw5NGt4ZmRPTkhQ?=
 =?utf-8?B?YkQ3b2had3p6T1hoTEJ3NS9oWTJmdGEreDZJa1ZlZTJ6Sks2WWlJVjJQUjU2?=
 =?utf-8?B?bkpEaDBKY2tmQUhQNThQbDdJMXhEZEc1WlNFWGYwRk1jWHFGYjZ3MVNoSWVY?=
 =?utf-8?B?dWJPdHV3TGdoWnhHdTA0Y002OURXS0dKcTd4a1o5Q1diZXRqWldDeUdLQU5Y?=
 =?utf-8?B?eU5JZ3YvOXYvSnVaQVFlY2FOM3RjaGM1bHRLTkNabnRWY1JBVHFsc3NxcEZ0?=
 =?utf-8?B?QzZrTFArWnJRRjByVUNEMXhLVEwxN3RLRzBaMVl1SkVjanF1b0hsZXZ3NXBl?=
 =?utf-8?B?a2tYWXB2Zlo0ZXN5S1k1RWUyYnptTVRhMTFRQkJ6OExGSERGL1lpNXRqcFpp?=
 =?utf-8?B?RkRqcUVlZTV4ZHNhck5OSm1EL3g5N1pxRit6L1JhQmVwRndmcjhQKy9LemZp?=
 =?utf-8?B?aUFkOVBjMXVnMWtiOEFueno5NWE3ZHNPWGN1RGlKS3k0SE8wcjB6eS8wS1N6?=
 =?utf-8?Q?a3t2oLQ2mrU3AtAo=3D?=
X-Exchange-RoutingPolicyChecked: 
	GAb+KoZ1bOSNJ6RiNwNcZe11jUBqXgtWBo5IJ3xCAUOcl1EhM2FfLFVOlrHFErmBPEHqfj7wINJokkdH83uysnnq4kra0jx6i3YDeKNVCph/K9ByCrV6R2mMbvBso+buWCTMpKPKYATfMEegs4pa5DPBCVF+X59Pwnwo3/MmZEufxDK7EgE/e2G0Rpp8hrBGtdpL12QOUqNrzoKyHtfIrqct++Civ/rFYbAOcePv9ChwVCB+6aaHo3EtHMVj4Ch26OYGwsz/KnfMjkrtrt3exje5Ffw/tQf1/k9g2zoTHFJOtPzXVHCLNqEGAsaky3K2E8ERbqqYT4OsE1DrHHyvqA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de8a4e43-907d-42b5-ed9b-08ded2c6d6f4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8496.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 14:34:18.6219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ssMw+mX93gCVPigH8fTXdKLD45zrsstI9tApwmx7ky5lNO7sqnW4wINOkkAWuVCdcrqWc3Zztn2ZW3rpGZ5kJr/PvKLlkr5lJavzDT8SAOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFE12D62847
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyNSBTYWx0ZWRfX+peTt5K480k+
 69AIesoM/W5orxZvwwyzokslnOoa60+3SC38A8dCyeuANp6rh8J0Q5kVQasg3T5Sd8TCOvco9si
 pMT0CW3Jeftx+vrsYblb0Q1zqo5XCt6N6uaH9/7sm5TNu234/CbB
X-Proofpoint-ORIG-GUID: 8RJfmtuyxfurnW5i4ibD3ZAoVQTsaI0V
X-Authority-Analysis: v=2.4 cv=M6t97Sws c=1 sm=1 tr=0 ts=6a3d3c70 cx=c_pps
 a=gBbgJzl4OEn/1oy4V0Rvig==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=dnEwNotGAAAA:8
 a=FP58Ms26AAAA:8 a=TSbVqHtbAAAA:8 a=a4NEJbfMAAAA:8 a=H6WxVz_VAAAA:8
 a=iKPLBM1MAAAA:8 a=1XWaLZrsAAAA:8 a=qxWGVCWjAAAA:8 a=t7CeM3EgAAAA:8
 a=eTUyEuTBjxHN-u0AwYkA:9 a=QRzjZtwMIBQA:10 a=QEXdDO2ut3YA:10
 a=v3jDNnfkhO3XjQ9l6csA:9 a=uKUJsYj9pbdSZGOh:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10 a=NJcUIoPEKLAEIzHnl83t:22 a=ejRDv7XJuw7nbi7PrmUL:22
 a=SynsAy1IjJfI1QyGdTg5:22 a=s57Xr27pIc281qfTS48n:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 8RJfmtuyxfurnW5i4ibD3ZAoVQTsaI0V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyNSBTYWx0ZWRfX2BQPTzYUZwii
 XM9oHm/Mh3siXd5mWeqZE4VZSlXbrIU8sccIAUeJtMXcKldD41yuUWaMbgcbXU6U2w/H7NAs9bv
 lwfmRXaGfQuq1Yuv0U992c2iEbRL0J4PgENDt6nPx+FEmfmGx8jBgJUGd+PVgUdVglVoLRroBHD
 bklS0ohTXJjTIidWf5ThF4KTIiNak+slFaaJ9HucNa3PSf/JEIfzC/aiGig/RcpF2eEkBgnwPcd
 ya+d6w4UOCswAotpPdGCs+7ocOPT8oaAgZOIAiU84yM3bQTLYJ5iulOlXKYQdu9RJD7yXevsCPa
 fysct7YKsAwVF79d5q6cK2XG+Zboo/jtU44DtxTpwXmE8GMKA/GuVW3CN0ZTqFT8Tv5f0hGtGZW
 n8dvVx1K87jG1sxD82ZW6AZZtdgwt9pKcsIRsIvcgfWoE76Fm/1pxW/+KMHmgR7hazm+OiKCLv5
 0u97opL+FZDOaDV1gDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 adultscore=0 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250125
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jun 2026 14:34:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4304

--------------iGzhhPEQMUmKZx9pbUisdmkb
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-06-25 01:18, Sandeep J wrote:
> Update TOMOYO documentation URL:
>     http://tomoyo.sourceforge.jp/1.8/index.html.en
> to:
>     https://tomoyo.sourceforge.net/1.8/index.html.en
>
> Replace dead gmane.org permalink references with Wayback Machine
> archived copies of the original Tizen dev mailing list thread:
>     http://permalink.gmane.org/gmane.comp.handhelds.tizen.devel/6281
> to:
>     https://web.archive.org/web/20191020122234/https://lists.tizen.org/pipermail/dev/2015-May/006399.html
>
>     http://permalink.gmane.org/gmane.comp.handhelds.tizen.devel/6275
> to:
>     https://web.archive.org/web/20210620014038/https://lists.tizen.org/pipermail/dev/2015-May/thread.html
>
> Signed-off-by: Sandeep J<Sandeep.J@windriver.com>
> ---
>   meta-integrity/README.md     | 4 ++--
>   recipes-mac/ccs-tools/README | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/meta-integrity/README.md b/meta-integrity/README.md
> index 92d24f8..9aeac60 100644
> --- a/meta-integrity/README.md
> +++ b/meta-integrity/README.md
> @@ -270,5 +270,5 @@ No package manager is integrated with IMA/EVM. When updating packages,
>   files will end up getting installed without correct IMA/EVM attributes
>   and thus will not be usable when appraisal is turned on.
>   
> -[1]http://permalink.gmane.org/gmane.comp.handhelds.tizen.devel/6281
> -[2]http://permalink.gmane.org/gmane.comp.handhelds.tizen.devel/6275
> +[1]https://web.archive.org/web/20191020122234/https://lists.tizen.org/pipermail/dev/2015-May/006399.html
Seems right or at least close, but I'd feel better if we could find the 
original mirrored content
and if the message number didn't change or we understood why it did change.
> +[2]https://web.archive.org/web/20210620014038/https://lists.tizen.org/pipermail/dev/2015-May/thread.html
This link is not as useful and probably a bad idea to make this change.

Please work on this for another hour or two to find mirrored copies.
AI can help.

Hint:
https://news.gmane.io/
If you can find an NNTP viewer, that woudl be good - I think thunderbird 
has one.


My gemini logs:
https://www.google.com/search?q=permalink.gmane.org%2Fgmane.comp.handhelds.tizen.devel%2F6281&sca_esv=4f4e6eb4e747ddd2&hl=en&sxsrf=APpeQnt0iPDEqalwKD8T2TqgX8CzQmYhNg%3A1782396917851&fbs=ABfTbFVyMZGZf1hfvX9uKjN_-G8cxpBkeIeqYwoCbfNVc4vKEzfJsZm6euHh2bPtNTAJBYDOov6zpOjT0O1kBN4V557jRm7HhIWF6QfZdhVfvcaeZf65iVNh6IqRreAOsl3C3Lgd_tKzdvudVe3dSNVukr4H6pIpgargvwApL0OqF1JFbdYwZbtJM5eEhzfwywuhr_9UaDku7aFS9XUIyFMmdWJChNV1hg&aep=1&ntc=1&sa=X&ved=2ahUKEwii-Iv5yaKVAxXj78kDHV4rMc0Q2J8OegQIDxAD&biw=1773&bih=893&dpr=1.09&mstk=AUtExfDV3udALZ7C14s8vpNSl7ciyW1qt5r3uOyX2LdaeQUkaL-n2LC1wiI9Vx5Guo_RU65I2v67RTaneu7SDlncnkcEdyYDdb7BfvGpC8OgJrs6j93VOMBVK0qTyRl0a3mkmdFWqYdb_FyJ2L7U61gUVWf7CqksiaqGjbcL4myrPVvflUi51X71U12_LE-uigFD3yLApy8yq7TWDflDcSjuUJubiuW4QtcBdlS2VbzjlMiQSoBbjunIy20m_j35EiBztrAGppMyPdL6hrn0xqEklCtJFo2qskxIBw6XqSIyN1i2yZw3WdNBqKhIcBA-bMxVJKkSwhDoS4sqefvQ1rZDu8wUlbZWS0aXOoY6e_qbU5CQdvhhBi8mn0Y&csuir=1&mtid=_zc9asScMvzjruEP2OyNqAM&udm=50

https://share.google/aimode/vjuPYowmMCcpBIinG

https://share.google/aimode/NJ8G2uhAhZskAHVMp

Keep digging,

../Randy


> diff --git a/recipes-mac/ccs-tools/README b/recipes-mac/ccs-tools/README
> index 0381814..dffb933 100644
> --- a/recipes-mac/ccs-tools/README
> +++ b/recipes-mac/ccs-tools/README
> @@ -1,5 +1,5 @@
>   Documentation:
> -http://tomoyo.sourceforge.jp/1.8/index.html.en
> +https://tomoyo.sourceforge.net/1.8/index.html.en
>   
>   
>   To start via command line add:


-- 
# Randy MacLeod
# Wind River Linux

--------------iGzhhPEQMUmKZx9pbUisdmkb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <head>

   =20
  </head>
  <body>
    <div class=3D"moz-cite-prefix">On 2026-06-25 01:18, Sandeep J wrote:<br=
>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:20260625051816.1844262-2-Sandeep.=
J@windriver.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">Update TOMOYO documentation UR=
L:
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
    Seems right or at least close, but I'd feel better if we could find
    the original mirrored content<br>
    and if the message number didn't change or we understood why it did
    change.
    <blockquote type=3D"cite" cite=3D"mid:20260625051816.1844262-2-Sandeep.=
J@windriver.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">
+[2] <a class=3D"moz-txt-link-freetext" href=3D"https://web.archive.org/web=
/20210620014038/https://lists.tizen.org/pipermail/dev/2015-May/thread.html"=
>https://web.archive.org/web/20210620014038/https://lists.tizen.org/piperma=
il/dev/2015-May/thread.html</a></pre>
    </blockquote>
    This link is not as useful and probably a bad idea to make this
    change.<br>
    <br>
    Please work on this for another hour or two to find mirrored copies.<br=
>
    AI can help.<br>
    <br>
    Hint:<br>
    <a class=3D"moz-txt-link-freetext" href=3D"https://news.gmane.io/">http=
s://news.gmane.io/</a><br>
    If you can find an NNTP viewer, that woudl be good - I think
    thunderbird has one.<br>
    <br>
    <br>
    My gemini logs:<br>
<a class=3D"moz-txt-link-freetext" href=3D"https://www.google.com/search?q=
=3Dpermalink.gmane.org%2Fgmane.comp.handhelds.tizen.devel%2F6281&amp;sca_es=
v=3D4f4e6eb4e747ddd2&amp;hl=3Den&amp;sxsrf=3DAPpeQnt0iPDEqalwKD8T2TqgX8CzQm=
YhNg%3A1782396917851&amp;fbs=3DABfTbFVyMZGZf1hfvX9uKjN_-G8cxpBkeIeqYwoCbfNV=
c4vKEzfJsZm6euHh2bPtNTAJBYDOov6zpOjT0O1kBN4V557jRm7HhIWF6QfZdhVfvcaeZf65iVN=
h6IqRreAOsl3C3Lgd_tKzdvudVe3dSNVukr4H6pIpgargvwApL0OqF1JFbdYwZbtJM5eEhzfwyw=
uhr_9UaDku7aFS9XUIyFMmdWJChNV1hg&amp;aep=3D1&amp;ntc=3D1&amp;sa=3DX&amp;ved=
=3D2ahUKEwii-Iv5yaKVAxXj78kDHV4rMc0Q2J8OegQIDxAD&amp;biw=3D1773&amp;bih=3D8=
93&amp;dpr=3D1.09&amp;mstk=3DAUtExfDV3udALZ7C14s8vpNSl7ciyW1qt5r3uOyX2LdaeQ=
UkaL-n2LC1wiI9Vx5Guo_RU65I2v67RTaneu7SDlncnkcEdyYDdb7BfvGpC8OgJrs6j93VOMBVK=
0qTyRl0a3mkmdFWqYdb_FyJ2L7U61gUVWf7CqksiaqGjbcL4myrPVvflUi51X71U12_LE-uigFD=
3yLApy8yq7TWDflDcSjuUJubiuW4QtcBdlS2VbzjlMiQSoBbjunIy20m_j35EiBztrAGppMyPdL=
6hrn0xqEklCtJFo2qskxIBw6XqSIyN1i2yZw3WdNBqKhIcBA-bMxVJKkSwhDoS4sqefvQ1rZDu8=
wUlbZWS0aXOoY6e_qbU5CQdvhhBi8mn0Y&amp;csuir=3D1&amp;mtid=3D_zc9asScMvzjruEP=
2OyNqAM&amp;udm=3D50">https://www.google.com/search?q=3Dpermalink.gmane.org=
%2Fgmane.comp.handhelds.tizen.devel%2F6281&amp;sca_esv=3D4f4e6eb4e747ddd2&a=
mp;hl=3Den&amp;sxsrf=3DAPpeQnt0iPDEqalwKD8T2TqgX8CzQmYhNg%3A1782396917851&a=
mp;fbs=3DABfTbFVyMZGZf1hfvX9uKjN_-G8cxpBkeIeqYwoCbfNVc4vKEzfJsZm6euHh2bPtNT=
AJBYDOov6zpOjT0O1kBN4V557jRm7HhIWF6QfZdhVfvcaeZf65iVNh6IqRreAOsl3C3Lgd_tKzd=
vudVe3dSNVukr4H6pIpgargvwApL0OqF1JFbdYwZbtJM5eEhzfwywuhr_9UaDku7aFS9XUIyFMm=
dWJChNV1hg&amp;aep=3D1&amp;ntc=3D1&amp;sa=3DX&amp;ved=3D2ahUKEwii-Iv5yaKVAx=
Xj78kDHV4rMc0Q2J8OegQIDxAD&amp;biw=3D1773&amp;bih=3D893&amp;dpr=3D1.09&amp;=
mstk=3DAUtExfDV3udALZ7C14s8vpNSl7ciyW1qt5r3uOyX2LdaeQUkaL-n2LC1wiI9Vx5Guo_R=
U65I2v67RTaneu7SDlncnkcEdyYDdb7BfvGpC8OgJrs6j93VOMBVK0qTyRl0a3mkmdFWqYdb_Fy=
J2L7U61gUVWf7CqksiaqGjbcL4myrPVvflUi51X71U12_LE-uigFD3yLApy8yq7TWDflDcSjuUJ=
ubiuW4QtcBdlS2VbzjlMiQSoBbjunIy20m_j35EiBztrAGppMyPdL6hrn0xqEklCtJFo2qskxIB=
w6XqSIyN1i2yZw3WdNBqKhIcBA-bMxVJKkSwhDoS4sqefvQ1rZDu8wUlbZWS0aXOoY6e_qbU5CQ=
dvhhBi8mn0Y&amp;csuir=3D1&amp;mtid=3D_zc9asScMvzjruEP2OyNqAM&amp;udm=3D50</=
a><br>
    <br>
    <a class=3D"moz-txt-link-freetext" href=3D"https://share.google/aimode/=
vjuPYowmMCcpBIinG">https://share.google/aimode/vjuPYowmMCcpBIinG</a><br>
    <br>
    <a class=3D"moz-txt-link-freetext" href=3D"https://share.google/aimode/=
NJ8G2uhAhZskAHVMp">https://share.google/aimode/NJ8G2uhAhZskAHVMp</a><br>
    <br>
    <p>Keep digging,</p>
    <p>../Randy</p>
    <p><br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:20260625051816.1844262-2-Sandeep.=
J@windriver.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">
diff --git a/recipes-mac/ccs-tools/README b/recipes-mac/ccs-tools/README
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
    <pre class=3D"moz-signature" cols=3D"72">--=20
# Randy MacLeod
# Wind River Linux</pre>
  </body>
</html>

--------------iGzhhPEQMUmKZx9pbUisdmkb--

