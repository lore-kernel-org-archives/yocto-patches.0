Return-Path: <changqing.li@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EB7C5B552
	for <webhook@archiver.kernel.org>; Wed,  4 Jun 2025 07:28:28 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.10609.1749022100801200110
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 04 Jun 2025 00:28:21 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=8250671ff5=changqing.li@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5545mdn1025901;
	Wed, 4 Jun 2025 07:28:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 471g9t23r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 07:28:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ny/YHhQp1yGrlrUPyZkcnt3+PApJVwoeFpAKZ1GwZY9RjUG2RLn23cO/lShk+0uPSlTm2j8rKZ95DvGmBojt1OrAcYLvtuY0NzQDkWmy/4FvxC/fL/2eKxdRG9Hu+UmQOejl+y13BkPnCPY7tINNe1Ffbthzowv3csvEPFu+iha5xbMaOB061yme2v75MmXk1E15VZHEtZ0qmlGwwT2MUMdPCtf4ZIDuwNrqf1ruSkVM0FAVFHbRUsGqxmVPduNRZDMUwju006diZoaQk3p+Ldz4Jwr1eTDS9H196W/Ei6XI81Hz4/JExvACHtZvcYpScteZyixtJb+zkAflCJ6EGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8+vSg12QU1sfXQOfU6O+YrmiUTVlopWNZhTtmmHQvs=;
 b=dKeun/dJA3GC9KbEzUtxTloGzFIOKQn2+3GL99FxL1uStByi+wxeS141waJYM6h7wJshQ2AlZR0GOPMAgaZpRMrblpIuA9R3/UR0dWMVan3mzf+KlTbtt3GK8vSR54vUPNx9qtRaGGe16G1WExQEC0OLWBGuIX5yL3bKtBFlPnw0NETd4IzwHM0hbmIzMOAOfCzWpsaQMpZPUy1LPHpxD6foaG5Xz24CWRU8AoIu/LfnuonoZlH1IG7dp1QlN3O3Np7mY4b2jlGO9b6QNisW3c13I9VmGHxMsy2lRxh1f2Od6rtGQryQdX57luJ0DH9EZgDLiaRt+xhweFKrsiceMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7312.namprd11.prod.outlook.com (2603:10b6:8:11f::18)
 by MN2PR11MB4647.namprd11.prod.outlook.com (2603:10b6:208:262::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Wed, 4 Jun
 2025 07:28:15 +0000
Received: from DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c]) by DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c%4]) with mapi id 15.20.8769.037; Wed, 4 Jun 2025
 07:28:14 +0000
Content-Type: multipart/alternative;
 boundary="------------yML7B0bDogErvFst81Ya5jEi"
Message-ID: <15373846-447e-4b35-b8cb-905f2151683e@windriver.com>
Date: Wed, 4 Jun 2025 15:28:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][PATCH v3] Fix warning : lack of
 whitespace around assignment
To: yocto-patches@lists.yoctoproject.org
Cc: Jason Schonberg <schonm@gmail.com>, akuster808 <akuster808@gmail.com>
References: <20250415022440.549142-1-schonm@gmail.com>
Content-Language: en-US
From: Changqing Li <changqing.li@windriver.com>
In-Reply-To: <20250415022440.549142-1-schonm@gmail.com>
X-ClientProxiedBy: SG2PR02CA0119.apcprd02.prod.outlook.com
 (2603:1096:4:92::35) To DS0PR11MB7312.namprd11.prod.outlook.com
 (2603:10b6:8:11f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7312:EE_|MN2PR11MB4647:EE_
X-MS-Office365-Filtering-Correlation-Id: 0be8a67d-8258-40a2-a35b-08dda3395dc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|4022899009|1800799024|376014|366016|8096899003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZCtFOXJEcW9yODg5MkRiaCtEa3M1RFYyS3k4SEg4NUROcVhodGJvanA3NDFM?=
 =?utf-8?B?aGJRR0h6dWlLU3puVHVNSzNjU2pOK3hRNU82eXNqUThPcWd4QTE0Z2lLM2lW?=
 =?utf-8?B?V0pzbUxiTmdTQ3hkejIxVjJxcGd5c3NxV1FuSjFuN0d6SzF1VVJrNS8rUGNG?=
 =?utf-8?B?aTd1Zy9sMWp5TmJvdU0zN0s5MXhHcXBNWUxJSXh1VCs1bzd4QlRBbmUwdGNW?=
 =?utf-8?B?SUUyNzNKaDc3aFd3SlBRRnE1WHdsbnB5dWEwY1RvdDNmNXFqa1lUZFBxTTdj?=
 =?utf-8?B?T3IvTGt6OWlrNDBKbkVHbmV6Wm5sb3ZKL3RXTExHL3lrd2ZSS0ExczFLOHVl?=
 =?utf-8?B?QjNWWVppS1B6MXFBK3JZcDJZZGQzT2lJQ0MrUTVJeEVCelhsQnJUMnF0N0Vq?=
 =?utf-8?B?UkI2UWJuMk9Wc202YUZaSVc3YUVmU2FCN0k4eEhsR3lBaUloN2IxYW9NV0FV?=
 =?utf-8?B?eFgxSTkrNHRNbGIrdFlvUzVjTXYrdE5yMWVVSkNzbTdBSS9OdFNnUlRuQlh0?=
 =?utf-8?B?Vm5CbE9TT0VKWjU5TysvQVgxTFR2RzFjUFZ4cWpnZW1MNEg0amQ1T3dLU1ZU?=
 =?utf-8?B?LzJacVd0TlZXNkpGaXZGZWx0Um5xMWs5d0lqay81SEF6K1BjbDYyckYvUHB3?=
 =?utf-8?B?cWM3ZHBnVUo4M1JHVGxrUDdiN2Y4Q0h0TitTMGFGb2x3UDhRd1ZlYmZGZEV1?=
 =?utf-8?B?WkxDWFdQR3ltTnZRUkxSUjRXWXVCSVpMSDdVNVpIYkpZR3lUaGwyak1LRjAw?=
 =?utf-8?B?c3BzRnA3R25YQ0JGZW5GbFpoN2JFZkppU29uK2ZnVlYyNjhFTmtRVGw2Rkxk?=
 =?utf-8?B?WDVsTUowVjZQMk5wZlZnSkR0Vnh5QnNQaWNYSnRqd0lCK0pCWTBraSt5bzds?=
 =?utf-8?B?L3lHdjhzdG82WEFDZVdFbFVIZ3FnRDZwckovMno1VVRVcit3Ym9DeUVaL2dS?=
 =?utf-8?B?YUtoV0VySFp6V2tqZm9jYXpGTGtjWUlrWEEvYXpGc3IvUDZOdzhmcW9IcDE0?=
 =?utf-8?B?QndkWHBJeCszVExyYk8rV1ZJMlBxamVXQjJ1UmJXRE5lMTY3ZXpDdnU0QVpN?=
 =?utf-8?B?eUdIQ3BQZnc0QzYxT2gxdjRHbFpkL3pyelhhMlIyWktnbjY1ODRmaThLN0Jo?=
 =?utf-8?B?dVFUaVpxT2JUWlo1L2ZrdkIxZmhQT3QzbytaQVJUN1lFZWVRMkRBcHFCd1Mx?=
 =?utf-8?B?UFZxc1pXMVlBbEIrT0Y5OWNvMTFULyttZ21uMzNFMGJrR09hUjdkajdhbHhT?=
 =?utf-8?B?VXQwMm5GdkpNOGZJUUdkSmVCY1ozKzdLMEZoUURaZW9za3hDd3hIaEFBelkx?=
 =?utf-8?B?aGZ4bzhRaGprakhqT2lqNUMzK0xqOEpIeCtFclU4Wk5vRHpjS3NkTGU5TXJt?=
 =?utf-8?B?YUQ0SUE4UVJDQWEzWmswN3hqWks5T3cwd01VV25PR01VV3NMU2MvT3l5WXB3?=
 =?utf-8?B?bVU5RDBHOXlycEduNDdmRytPVm9sMXhuK3dhUXdhWFVsa3lRRzFORk1ab2s3?=
 =?utf-8?B?dERjU0FkcU9BMzBOK1diSGpKQWtlR0p4aGNienFUWHQ3Q2JaSXo4Z2s2K0c3?=
 =?utf-8?B?aGIyWFBOVm80UjFoZ2RiWHZDYmMveWpja3BybGk3SittYUhKcCtrcG1jN0o4?=
 =?utf-8?B?dHhwTVhGTjNja0F6REpyL2JnTEwxTkZpdUlMN0tEeFk5cng0aDJ1YkNmWUcw?=
 =?utf-8?B?U0M3YlNjRk01cHBReTBZNXpFN3RqSVowTEtvSlEza3dpL2ZsTlVaT280djRJ?=
 =?utf-8?B?OUxsZjV3MmFtL21mNE1INjgwTFpjT0hlSU1RZEZYU3VMTG9CVzE4cHJxdzh3?=
 =?utf-8?Q?ZKb/UC/ES4XlrMHoXXRn5+9pq2viUAupd7Pog=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7312.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(1800799024)(376014)(366016)(8096899003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZURnK3VzcU1ZVG8zWHE5a3YyMHFSalAvaVpuekNNbXFHUDFLZ1RUS09qZi9M?=
 =?utf-8?B?TGVaRnU5S0Uyc0NXci84d2FIRUNrNVFhWklndm9PdGpCL2w3czJWamhBMGwz?=
 =?utf-8?B?Z2Exd0pDdDhUS1J0dVlhUVU1LzJMWmJRVzgwQ1UxakNZdDJtNkZSbzYzdEVE?=
 =?utf-8?B?cWZNMWVQRyt0OFVOTHlzbGR3OHBScGNqQlVvNUVLcm9Rei91eW1GWW13QlFn?=
 =?utf-8?B?Q0JVM2p1OUlZOE9wR2pzblBnU2tNb25RQ1NmQ3cyMUg3bWtIVXdMbXRta2kw?=
 =?utf-8?B?dFlxS2E4U05WZUdOdGRmdlFHNWcwOWdic1NSYmx5VGVGTDJmZmErQlMyd0o2?=
 =?utf-8?B?SEFtem1hZUdwT0p3RzV6d0x6WUFEdmFTZm1WQW9YbHZWbDlyU0RUWUZyejh5?=
 =?utf-8?B?a21uY2JvdTRlV3U4NExkU0NaWkMreHZrMnZxQjFycm9wSTNhWTdNZmR2N3cy?=
 =?utf-8?B?MGVQT0FEcHZrN3c2V1psNGtWTWJZeUt2U3Bwc3J5d0o4MGZZK0xPK3BNT0dF?=
 =?utf-8?B?cDBPMkd3TXZJOW53a3dqdG5KbzRGUmxvVmt3TUpJa0pTMjd1NVlDOG9Yems1?=
 =?utf-8?B?MGxWb0VJdVVBdUZPKzBpdlFmT2UySGk4bUF5RitvMnF0UG5hODdQWVl1SlNV?=
 =?utf-8?B?bTlMOVkwOHNabEpDMGZBMWNSTWRia05iVnQ1WkpQUjB2UjhMemtraUhBeStD?=
 =?utf-8?B?OGZZK0pDYXhUdDIrYUZoMWxaNkk2NGJxejMzYld3dyt3Z1p5eUROUFRxbEFT?=
 =?utf-8?B?OUlNeGtqYy9kZURHS0ZNY1NaOXBIZDdiRll2NW9WV0p1QnhqN0FrOC9lRWJa?=
 =?utf-8?B?Umt5SUppSkwrWEZJRnA0YmRnY1RmWXFoUkJnMWtFMnNtdHVKMHZlYVBOWXYw?=
 =?utf-8?B?b3hqZnRkeFljVjMwbUlUQTFzeHhJaGEwbVYvK0EyOE42cGxuK05ESmdWVlJq?=
 =?utf-8?B?RDc5SkVncVZocE1OdmFydW1VVXpib09JblAzRW1EWk5JWnRXd1d0M0RJVUdl?=
 =?utf-8?B?cW8rYW1obUM4ajJlNzFtVHpkNU0xd05OY2UrR0ZEVmZ0aE0yZC96amxUa2lk?=
 =?utf-8?B?NHBSVHQyamZCVlRXM3V4NHM5VVREaC9mOHVvUFYxV0VZa0U4WW1WUXFBalFm?=
 =?utf-8?B?aDI1UGJCeVM0QWRwNHhQbkFFSGo4eVJXUEhtRU1JMmIvR3ZtYmJMa1hCbC9O?=
 =?utf-8?B?dVFqWUNLSGhsT21rN3lJVmZYWnYzRnJLeUhJelBSSGJoZzZWT25URTJ5TFpw?=
 =?utf-8?B?enFvbElsTGZ4SXRsdmM0SDBKVE9TcW9OOWVCcjRucEM5eGplSm9tR3RjZ0tV?=
 =?utf-8?B?eGFhVGlqZkRtVnI4SG4yRGZ3SGo4L2xEdEVSczhERTFMY1BzM3ppbHF4OG5a?=
 =?utf-8?B?TCtRR0JlbGRPT2pKOTJjeE9IQkhYT2dTSlRXLzRnQ3ovTzgyL3lmdFJqNDU4?=
 =?utf-8?B?WE9MTzJGNStiOUQ2TzlTZXNCNGJSTU9qQ3JsMWFaRGx6N3Qxdm90anlvU29w?=
 =?utf-8?B?bjBDcUhVd0RKTEdHWmFxanBZY05VV2haZTducGwrVnBnNllvc1llTUVWTTdJ?=
 =?utf-8?B?RGRXQ0VOSmxDeFd3VVYyMmpWREpaYllwZWIxWllkK0ZrcXFkZE4rZEpmWTIw?=
 =?utf-8?B?ZnA0Mm1VZEYxbEdreElpbUhIRFFUbFlsTWFtcjFLWG9mVk5SM0UwM1lpbG4y?=
 =?utf-8?B?Y3pUMzduQzZMMnZNcXNhTmF0R3VQN2J1MmhneEozbW5UWjhVSGI0aGEwdU43?=
 =?utf-8?B?a2lZQU1yTDBGNDN5RHdJN2hIY3ZObjRNVzN0S200MmJBeXNEQkJRb21COWlr?=
 =?utf-8?B?ZC9RdWhyd1B1SlI0d0ozUk0reTF3RVI2Y2hMOTZFYlNNMEFaN1VnT1RPMFdG?=
 =?utf-8?B?QzlRektSUlJZNmU0OVZzczNzQU1vdGsvUERERVNzUVBHRDBFWVdubGhXZjlz?=
 =?utf-8?B?YkhvYUljcDI5aXh0aW5wZHBqNlFBSExwQ0VENGxaeFR2THFLNzNLdkhPazhu?=
 =?utf-8?B?TDFKWFNzcXR2bmFDVUpGLzFoQ2oyaURNRXV0WGpUOXFnZnVyZysrWFlCbGtI?=
 =?utf-8?B?OG8wT0hOR2dSd09QNGZuNjNoVlpQUVl6Ulg5UlNaOXN6SUhIWDJ6RW0yR1hF?=
 =?utf-8?B?TzFQdUl1Z2VFZi9JQVVYQUhzQkZtVi8waTV4YUtqOVF4K2FXd0UxQURxWFBM?=
 =?utf-8?B?QWc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be8a67d-8258-40a2-a35b-08dda3395dc8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 07:28:14.2432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eScZwYPSoYBXboIbgYH5p1fWgYdGwe8+zXR7VVKwn7HnGJxDjPL5AXB9XpETAQu3tqGQ6Uit18iBMHihSTPedd1kmu/g56lI6PBAjTn8rIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4647
X-Proofpoint-ORIG-GUID: 0vp6o00OUkXSAFVS6qwfcdEYPSBSEPvL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA2MCBTYWx0ZWRfX7xUwG9Mb077o hz65NqbICqn0kuJROXguajE/Zz2XJoBjTWM6zpXlU/GK8nds0uv5O4L3NRVfGgAGmOBNxO9Zwvi m7REpZfTKEMtNeg8b+wLWdvCRwgAp/6oe7eAjkfqdEyoSZa4stRrw2g/fmnvq84ERXvCOCFNuX3
 EABdkYrB1MaM0j9FDS5yaevTCC1x3DP+KJFG0c9M3KmfcdELMcdfrUAf+UAmXWmDA2W+JtKuix0 wR9tmZL0X6Lt5beekJZ5NndVa/TpK/b3c3ytrffe3IXuHNoOq8iO+4HkoJDN/FUtU5ot8u6mrnP Xxj/jRbfvUJtuKXMAxmcfGJToR9Y2rQXPJQY9pUSdxbZih4odPUWIKV0I+DK3yRsHFob1bhxwue
 xOXGtf/cd8J4oIs/ChbHOdH3x7lMJ1QJjEa9K2QOcy7bBkUbjStOHuVHUx2PsFT1018xJr8O
X-Proofpoint-GUID: 0vp6o00OUkXSAFVS6qwfcdEYPSBSEPvL
X-Authority-Analysis: v=2.4 cv=Q4DS452a c=1 sm=1 tr=0 ts=683ff593 cx=c_pps a=SzVIhQP/G3AuXdMMEvt//w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=NEAV23lmAAAA:8 a=FP58Ms26AAAA:8 a=XkRKQH6RAAAA:8 a=LfvH3UrpAAAA:8 a=iGHA9ds3AAAA:8 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=-o9ofTc8XaOiX0qcq28A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=estwG2eNYqAOIwiJ3NUA:9
 a=6FhTQDnE54SvIBQs:21 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10 a=1gUyE30hU_ULiMxJiLUW:22 a=n7Al05T9dhkPszCtvm82:22 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 suspectscore=0 bulkscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2505280000
 definitions=main-2506040060
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 04 Jun 2025 07:28:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1616

--------------yML7B0bDogErvFst81Ya5jEi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 5545mdn1025901

Kindly ping

//Changqing

On 4/15/25 10:24, J. S. via lists.yoctoproject.org wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender =
and know the content is safe.
>
> v2 : also fix some typos while we are here.
> v3 : add fixes for isic and checksecurity
>
> Signed-off-by: Jason Schonberg<schonm@gmail.com>
> ---
>   .../recipes-scanners/checksecurity/checksecurity_2.0.16.bb  | 2 +-
>   .../recipes-devtools/python/python3-json2html_1.3.0.bb      | 2 +-
>   .../recipes-devtools/python/python3-xmldiff_2.7.0.bb        | 2 +-
>   .../recipes-devtools/python/python3-yamlpath_3.8.2.bb       | 2 +-
>   .../scap-security-guide/scap-security-guide_0.1.76.bb       | 6 +++--=
-
>   recipes-ids/aide/aide_0.18.8.bb                             | 2 +-
>   recipes-ids/ossec/ossec-hids_3.7.0.bb                       | 2 +-
>   recipes-ids/tripwire/tripwire_2.4.3.7.bb                    | 2 +-
>   recipes-kernel/lkrg/lkrg-module_0.9.7.bb                    | 2 +-
>   recipes-mac/ccs-tools/ccs-tools_1.8.9.bb                    | 4 ++--
>   recipes-perl/perl/libwhisker2-perl_2.5.bb                   | 2 +-
>   recipes-scanners/checksec/checksec_2.6.0.bb                 | 2 +-
>   recipes-security/cryptmount/cryptmount_6.2.0.bb             | 2 +-
>   recipes-security/isic/isic_0.07.bb                          | 2 +-
>   recipes-security/sshguard/sshguard_2.4.3.bb                 | 4 ++--
>   15 files changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/dynamic-layers/meta-perl/recipes-scanners/checksecurity/ch=
ecksecurity_2.0.16.bb b/dynamic-layers/meta-perl/recipes-scanners/checkse=
curity/checksecurity_2.0.16.bb
> index 8006c9f..bc146a9 100644
> --- a/dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecu=
rity_2.0.16.bb
> +++ b/dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecu=
rity_2.0.16.bb
> @@ -14,7 +14,7 @@ S =3D "${WORKDIR}/checksecurity-${PV}+nmu1"
>
>
>   # allow for anylocal, no need to patch
> -LOGDIR=3D"/etc/checksecurity"
> +LOGDIR =3D "/etc/checksecurity"
>
>   do_compile() {
>       sed -i -e "s;LOGDIR=3D/var/log/setuid;LOGDIR=3D${LOGDIR};g" ${B}/=
etc/check-setuid.conf
> diff --git a/dynamic-layers/meta-python/recipes-devtools/python/python3=
-json2html_1.3.0.bb b/dynamic-layers/meta-python/recipes-devtools/python/=
python3-json2html_1.3.0.bb
> index 3d7e897..baf3156 100644
> --- a/dynamic-layers/meta-python/recipes-devtools/python/python3-json2h=
tml_1.3.0.bb
> +++ b/dynamic-layers/meta-python/recipes-devtools/python/python3-json2h=
tml_1.3.0.bb
> @@ -1,4 +1,4 @@
> -DESCRIPTION=3D"Python wrapper to convert JSON into a human readable HT=
ML Table representation."
> +DESCRIPTION =3D "Python wrapper to convert JSON into a human readable =
HTML Table representation."
>   LICENSE =3D "MIT"
>   LIC_FILES_CHKSUM =3D"file://LICENSE.txt;md5=3D8065590663ea0c10aa13184=
1ea806767"
>
> diff --git a/dynamic-layers/meta-python/recipes-devtools/python/python3=
-xmldiff_2.7.0.bb b/dynamic-layers/meta-python/recipes-devtools/python/py=
thon3-xmldiff_2.7.0.bb
> index 9d38065..a81c252 100644
> --- a/dynamic-layers/meta-python/recipes-devtools/python/python3-xmldif=
f_2.7.0.bb
> +++ b/dynamic-layers/meta-python/recipes-devtools/python/python3-xmldif=
f_2.7.0.bb
> @@ -1,4 +1,4 @@
> -DESCRIPTION=3D"Creates diffs of XML files"
> +DESCRIPTION =3D "Creates diffs of XML files"
>   LICENSE =3D "MIT"
>   LIC_FILES_CHKSUM =3D"file://LICENSE.txt;md5=3D0d0e9e3949e163c3edd1e09=
7b8b0ed62"
>
> diff --git a/dynamic-layers/meta-python/recipes-devtools/python/python3=
-yamlpath_3.8.2.bb b/dynamic-layers/meta-python/recipes-devtools/python/p=
ython3-yamlpath_3.8.2.bb
> index e2d95ae..d496e67 100644
> --- a/dynamic-layers/meta-python/recipes-devtools/python/python3-yamlpa=
th_3.8.2.bb
> +++ b/dynamic-layers/meta-python/recipes-devtools/python/python3-yamlpa=
th_3.8.2.bb
> @@ -1,4 +1,4 @@
> -DESCRIPTION=3D"YAML Path and Command-Line Tools"
> +DESCRIPTION =3D "YAML Path and Command-Line Tools"
>   LICENSE =3D "ISC"
>   LIC_FILES_CHKSUM =3D"file://LICENSE;md5=3D5abda174c5040dd12ed2b225e3a=
096f0"
>
> diff --git a/recipes-compliance/scap-security-guide/scap-security-guide=
_0.1.76.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0=
.1.76.bb
> index 73bd576..25309c7 100644
> --- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76=
.bb
> +++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76=
.bb
> @@ -21,9 +21,9 @@ B =3D "${S}/build"
>   inherit cmake pkgconfig python3native python3targetconfig ptest
>
>   STAGING_OSCAP_BUILDDIR =3D "${TMPDIR}/work-shared/openscap/oscap-buil=
d-artifacts"
> -export OSCAP_CPE_PATH=3D"${STAGING_OSCAP_BUILDDIR}${datadir_native}/op=
enscap/cpe"
> -export OSCAP_SCHEMA_PATH=3D"${STAGING_OSCAP_BUILDDIR}${datadir_native}=
/openscap/schemas"
> -export OSCAP_XSLT_PATH=3D"${STAGING_OSCAP_BUILDDIR}${datadir_native}/o=
penscap/xsl"
> +export OSCAP_CPE_PATH =3D "${STAGING_OSCAP_BUILDDIR}${datadir_native}/=
openscap/cpe"
> +export OSCAP_SCHEMA_PATH =3D "${STAGING_OSCAP_BUILDDIR}${datadir_nativ=
e}/openscap/schemas"
> +export OSCAP_XSLT_PATH =3D "${STAGING_OSCAP_BUILDDIR}${datadir_native}=
/openscap/xsl"
>
>   OECMAKE_GENERATOR =3D "Unix Makefiles"
>
> diff --git a/recipes-ids/aide/aide_0.18.8.bb b/recipes-ids/aide/aide_0.=
18.8.bb
> index e2014a1..2912cb2 100644
> --- a/recipes-ids/aide/aide_0.18.8.bb
> +++ b/recipes-ids/aide/aide_0.18.8.bb
> @@ -16,7 +16,7 @@ UPSTREAM_CHECK_URI =3D"https://github.com/${BPN}/${BP=
N}/releases"
>
>   inherit autotools pkgconfig aide-base
>
> -PACKAGECONFIG ??=3D" gcrypt zlib e2fsattrs posix capabilities curl pth=
read \
> +PACKAGECONFIG ??=3D " gcrypt zlib e2fsattrs posix capabilities curl pt=
hread \
>                    ${@bb.utils.contains('DISTRO_FEATURES', 'selinux', '=
selinux audit', '', d)} \
>                    ${@bb.utils.contains('DISTRO_FEATURES', 'xattr', 'xa=
ttr', '', d)} \
>                    "
> diff --git a/recipes-ids/ossec/ossec-hids_3.7.0.bb b/recipes-ids/ossec/=
ossec-hids_3.7.0.bb
> index fbd1294..d9f5121 100644
> --- a/recipes-ids/ossec/ossec-hids_3.7.0.bb
> +++ b/recipes-ids/ossec/ossec-hids_3.7.0.bb
> @@ -18,7 +18,7 @@ inherit autotools-brokensep  useradd
>   S =3D "${UNPACKDIR}/git"
>
>
> -OSSEC_DIR=3D"/var/ossec"
> +OSSEC_DIR =3D "/var/ossec"
>   OSSEC_UID ?=3D "ossec"
>   OSSEC_RUID ?=3D "ossecr"
>   OSSEC_GID ?=3D "ossec"
> diff --git a/recipes-ids/tripwire/tripwire_2.4.3.7.bb b/recipes-ids/tri=
pwire/tripwire_2.4.3.7.bb
> index e67d3c7..3c85027 100644
> --- a/recipes-ids/tripwire/tripwire_2.4.3.7.bb
> +++ b/recipes-ids/tripwire/tripwire_2.4.3.7.bb
> @@ -1,7 +1,7 @@
>   SUMMARY =3D "Tripwire: A system integrity assessment tool (IDS)"
>   DESCRIPTION =3D "Open Source Tripwire=C2=AE software is a security an=
d data \
>   integrity tool useful for monitoring and alerting on specific file ch=
ange(s) on a range of systems"
> -HOMEPAGE=3D"http://sourceforge.net/projects/tripwire"
> +HOMEPAGE =3D"http://sourceforge.net/projects/tripwire"
>   SECTION =3D "security Monitor/Admin"
>   LICENSE =3D "GPL-2.0-only"
>   LIC_FILES_CHKSUM =3D"file://COPYING;md5=3D1c069be8dbbe48e89b580ab4ed8=
6c127"
> diff --git a/recipes-kernel/lkrg/lkrg-module_0.9.7.bb b/recipes-kernel/=
lkrg/lkrg-module_0.9.7.bb
> index 751c045..20982a8 100644
> --- a/recipes-kernel/lkrg/lkrg-module_0.9.7.bb
> +++ b/recipes-kernel/lkrg/lkrg-module_0.9.7.bb
> @@ -1,5 +1,5 @@
>   SUMMARY =3D "Linux Kernel Runtime Guard"
> -DESCRIPTION=3D"LKRG performs runtime integrity checking of the Linux \
> +DESCRIPTION =3D "LKRG performs runtime integrity checking of the Linux=
 \
>   kernel and detection of security vulnerability exploits against the k=
ernel."
>   SECTION =3D "security"
>   HOMEPAGE =3D"https://www.openwall.com/lkrg/"
> diff --git a/recipes-mac/ccs-tools/ccs-tools_1.8.9.bb b/recipes-mac/ccs=
-tools/ccs-tools_1.8.9.bb
> index a746c56..3f754e9 100644
> --- a/recipes-mac/ccs-tools/ccs-tools_1.8.9.bb
> +++ b/recipes-mac/ccs-tools/ccs-tools_1.8.9.bb
> @@ -26,7 +26,7 @@ do_install(){
>       oe_runmake INSTALLDIR=3D${D}  USRLIBDIR=3D${libdir} SBINDIR=3D${s=
bindir} install
>   }
>
> -PACKAGE=3D"${PN} ${PN}-dbg ${PN}-doc"
> +PACKAGES =3D "${PN} ${PN}-dbg ${PN}-doc"
>
>   FILES:${PN} =3D "\
>       ${sbindir}/* \
> @@ -46,4 +46,4 @@ FILES:${PN}-dbg =3D "\
>       /usr/src/debug/* \
>   "
>
> -REQUIRED_DISTRO_FEATURES ?=3D" tomoyo"
> +REQUIRED_DISTRO_FEATURES ?=3D " tomoyo"
> diff --git a/recipes-perl/perl/libwhisker2-perl_2.5.bb b/recipes-perl/p=
erl/libwhisker2-perl_2.5.bb
> index 2c32bfc..e16e5f2 100644
> --- a/recipes-perl/perl/libwhisker2-perl_2.5.bb
> +++ b/recipes-perl/perl/libwhisker2-perl_2.5.bb
> @@ -15,7 +15,7 @@ S =3D "${UNPACKDIR}/libwhisker2-2.5"
>
>   inherit cpan-base
>
> -PACKAGEGROUP ??=3D""
> +PACKAGEGROUP ??=3D ""
>   PACKAGEGROUP[ssl] =3D ", , libnet-ssleay-perl, libnet-ssleay-perl"
>
>   do_install() {
> diff --git a/recipes-scanners/checksec/checksec_2.6.0.bb b/recipes-scan=
ners/checksec/checksec_2.6.0.bb
> index 3712e68..4767239 100644
> --- a/recipes-scanners/checksec/checksec_2.6.0.bb
> +++ b/recipes-scanners/checksec/checksec_2.6.0.bb
> @@ -2,7 +2,7 @@ SUMMARY =3D "Linux system security checks"
>   DESCRIPTION =3D "The checksec script is designed to test what standar=
d Linux OS and PaX security features are being used."
>   SECTION =3D "security"
>   LICENSE =3D "BSD-3-Clause"
> -HOMEPAGE=3D"https://github.com/slimm609/checksec.sh"
> +HOMEPAGE =3D"https://github.com/slimm609/checksec.sh"
>
>   LIC_FILES_CHKSUM =3D"file://LICENSE.txt;md5=3D879b2147c754bc040c29e9c=
3b84da836"
>
> diff --git a/recipes-security/cryptmount/cryptmount_6.2.0.bb b/recipes-=
security/cryptmount/cryptmount_6.2.0.bb
> index d69d88b..424ff56 100644
> --- a/recipes-security/cryptmount/cryptmount_6.2.0.bb
> +++ b/recipes-security/cryptmount/cryptmount_6.2.0.bb
> @@ -10,7 +10,7 @@ inherit autotools-brokensep gettext pkgconfig systemd
>
>   EXTRA_OECONF =3D " --enable-cswap --enable-fsck --enable-argv0switch"
>
> -PACKAGECONFIG ?=3D"intl luks gcrypt nls"
> +PACKAGECONFIG ?=3D "intl luks gcrypt nls"
>   PACKAGECONFIG:append =3D " ${@bb.utils.contains('DISTRO_FEATURES', 's=
ystemd', 'systemd', '', d)}"
>
>   PACKAGECONFIG[systemd] =3D "--with-systemd, --without-systemd, system=
d"
> diff --git a/recipes-security/isic/isic_0.07.bb b/recipes-security/isic=
/isic_0.07.bb
> index d39184e..8e0f5ce 100644
> --- a/recipes-security/isic/isic_0.07.bb
> +++ b/recipes-security/isic/isic_0.07.bb
> @@ -17,7 +17,7 @@ SRC_URI =3D"http://prdownloads.sourceforge.net/isic/$=
{BPN}-${PV}.tgz \=20
> SRC_URI[md5sum] =3D "29f70c9bde9aa9128b8f7e66a315f9a4"
>   SRC_URI[sha256sum] =3D "e033c53e03e26a4c72b723e2a5a1c433ee70eb4d23a1b=
a0d7d7e14ee1a80429d"
>
> -S=3D"${UNPACKDIR}/${BPN}-${PV}"
> +S =3D "${UNPACKDIR}/${BPN}-${PV}"
>
>   inherit autotools-brokensep
>
> diff --git a/recipes-security/sshguard/sshguard_2.4.3.bb b/recipes-secu=
rity/sshguard/sshguard_2.4.3.bb
> index 37b414e..de3d856 100644
> --- a/recipes-security/sshguard/sshguard_2.4.3.bb
> +++ b/recipes-security/sshguard/sshguard_2.4.3.bb
> @@ -1,10 +1,10 @@
> -SUMARRY=3D" Intelligently block brute-force attacks by aggregating sys=
tem logs "
> +SUMMARY =3D " Intelligently block brute-force attacks by aggregating s=
ystem logs "
>   HOMEPAGE =3D"https://www.sshguard.net/"
>   LIC_FILES_CHKSUM =3D"file://COPYING;md5=3D47a33fc98cd20713882c4d822a5=
7bf4d"
>   LICENSE =3D "BSD-1-Clause"
>
>
> -SRC_URI=3D"https://sourceforge.net/projects/sshguard/files/sshguard/${=
PV}/sshguard-${PV}.tar.gz"
> +SRC_URI =3D"https://sourceforge.net/projects/sshguard/files/sshguard/$=
{PV}/sshguard-${PV}.tar.gz"
>
>   SRC_URI[sha256sum] =3D "64029deff6de90fdeefb1f497d414f0e4045076693a91=
da1a70eb7595e97efeb"
>
> --
> 2.43.0
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1366):https://lists.yoctoproject.org/g/yocto-patche=
s/message/1366
> Mute This Topic:https://lists.yoctoproject.org/mt/112270358/3616873
> Group Owner:yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:https://lists.yoctoproject.org/g/yocto-patches/leave/131707=
23/3616873/476927670/xyzzy  [changqing.li@windriver.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
--------------yML7B0bDogErvFst81Ya5jEi
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 5545mdn1025901

<!DOCTYPE html><html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body text=3D"#000000" bgcolor=3D"#cceed0">
    <p>Kindly ping</p>
    <p>//Changqing<br>
    </p>
    <div class=3D"moz-cite-prefix">On 4/15/25 10:24, J. S. via
      lists.yoctoproject.org wrote:<br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:20250415022440.549142-1-schonm@=
gmail.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">CAUTION: This email comes fr=
om a non Wind River email account!
Do not click links or open attachments unless you recognize the sender an=
d know the content is safe.

v2 : also fix some typos while we are here.
v3 : add fixes for isic and checksecurity

Signed-off-by: Jason Schonberg <a class=3D"moz-txt-link-rfc2396E" href=3D=
"mailto:schonm@gmail.com">&lt;schonm@gmail.com&gt;</a>
---
 .../recipes-scanners/checksecurity/checksecurity_2.0.16.bb  | 2 +-
 .../recipes-devtools/python/python3-json2html_1.3.0.bb      | 2 +-
 .../recipes-devtools/python/python3-xmldiff_2.7.0.bb        | 2 +-
 .../recipes-devtools/python/python3-yamlpath_3.8.2.bb       | 2 +-
 .../scap-security-guide/scap-security-guide_0.1.76.bb       | 6 +++---
 recipes-ids/aide/aide_0.18.8.bb                             | 2 +-
 recipes-ids/ossec/ossec-hids_3.7.0.bb                       | 2 +-
 recipes-ids/tripwire/tripwire_2.4.3.7.bb                    | 2 +-
 recipes-kernel/lkrg/lkrg-module_0.9.7.bb                    | 2 +-
 recipes-mac/ccs-tools/ccs-tools_1.8.9.bb                    | 4 ++--
 recipes-perl/perl/libwhisker2-perl_2.5.bb                   | 2 +-
 recipes-scanners/checksec/checksec_2.6.0.bb                 | 2 +-
 recipes-security/cryptmount/cryptmount_6.2.0.bb             | 2 +-
 recipes-security/isic/isic_0.07.bb                          | 2 +-
 recipes-security/sshguard/sshguard_2.4.3.bb                 | 4 ++--
 15 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/dynamic-layers/meta-perl/recipes-scanners/checksecurity/chec=
ksecurity_2.0.16.bb b/dynamic-layers/meta-perl/recipes-scanners/checksecu=
rity/checksecurity_2.0.16.bb
index 8006c9f..bc146a9 100644
--- a/dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecuri=
ty_2.0.16.bb
+++ b/dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecuri=
ty_2.0.16.bb
@@ -14,7 +14,7 @@ S =3D &quot;${WORKDIR}/checksecurity-${PV}+nmu1&quot;


 # allow for anylocal, no need to patch
-LOGDIR=3D&quot;/etc/checksecurity&quot;
+LOGDIR =3D &quot;/etc/checksecurity&quot;

 do_compile() {
     sed -i -e &quot;s;LOGDIR=3D/var/log/setuid;LOGDIR=3D${LOGDIR};g&quot=
; ${B}/etc/check-setuid.conf
diff --git a/dynamic-layers/meta-python/recipes-devtools/python/python3-j=
son2html_1.3.0.bb b/dynamic-layers/meta-python/recipes-devtools/python/py=
thon3-json2html_1.3.0.bb
index 3d7e897..baf3156 100644
--- a/dynamic-layers/meta-python/recipes-devtools/python/python3-json2htm=
l_1.3.0.bb
+++ b/dynamic-layers/meta-python/recipes-devtools/python/python3-json2htm=
l_1.3.0.bb
@@ -1,4 +1,4 @@
-DESCRIPTION=3D&quot;Python wrapper to convert JSON into a human readable=
 HTML Table representation.&quot;
+DESCRIPTION =3D &quot;Python wrapper to convert JSON into a human readab=
le HTML Table representation.&quot;
 LICENSE =3D &quot;MIT&quot;
 LIC_FILES_CHKSUM =3D <a class=3D"moz-txt-link-rfc2396E" href=3D"file://L=
ICENSE.txt;md5=3D8065590663ea0c10aa131841ea806767">&quot;file://LICENSE.t=
xt;md5=3D8065590663ea0c10aa131841ea806767&quot;</a>

diff --git a/dynamic-layers/meta-python/recipes-devtools/python/python3-x=
mldiff_2.7.0.bb b/dynamic-layers/meta-python/recipes-devtools/python/pyth=
on3-xmldiff_2.7.0.bb
index 9d38065..a81c252 100644
--- a/dynamic-layers/meta-python/recipes-devtools/python/python3-xmldiff_=
2.7.0.bb
+++ b/dynamic-layers/meta-python/recipes-devtools/python/python3-xmldiff_=
2.7.0.bb
@@ -1,4 +1,4 @@
-DESCRIPTION=3D&quot;Creates diffs of XML files&quot;
+DESCRIPTION =3D &quot;Creates diffs of XML files&quot;
 LICENSE =3D &quot;MIT&quot;
 LIC_FILES_CHKSUM =3D <a class=3D"moz-txt-link-rfc2396E" href=3D"file://L=
ICENSE.txt;md5=3D0d0e9e3949e163c3edd1e097b8b0ed62">&quot;file://LICENSE.t=
xt;md5=3D0d0e9e3949e163c3edd1e097b8b0ed62&quot;</a>

diff --git a/dynamic-layers/meta-python/recipes-devtools/python/python3-y=
amlpath_3.8.2.bb b/dynamic-layers/meta-python/recipes-devtools/python/pyt=
hon3-yamlpath_3.8.2.bb
index e2d95ae..d496e67 100644
--- a/dynamic-layers/meta-python/recipes-devtools/python/python3-yamlpath=
_3.8.2.bb
+++ b/dynamic-layers/meta-python/recipes-devtools/python/python3-yamlpath=
_3.8.2.bb
@@ -1,4 +1,4 @@
-DESCRIPTION=3D&quot;YAML Path and Command-Line Tools&quot;
+DESCRIPTION =3D &quot;YAML Path and Command-Line Tools&quot;
 LICENSE =3D &quot;ISC&quot;
 LIC_FILES_CHKSUM =3D <a class=3D"moz-txt-link-rfc2396E" href=3D"file://L=
ICENSE;md5=3D5abda174c5040dd12ed2b225e3a096f0">&quot;file://LICENSE;md5=3D=
5abda174c5040dd12ed2b225e3a096f0&quot;</a>

diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0=
.1.76.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1=
.76.bb
index 73bd576..25309c7 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.b=
b
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.b=
b
@@ -21,9 +21,9 @@ B =3D &quot;${S}/build&quot;
 inherit cmake pkgconfig python3native python3targetconfig ptest

 STAGING_OSCAP_BUILDDIR =3D &quot;${TMPDIR}/work-shared/openscap/oscap-bu=
ild-artifacts&quot;
-export OSCAP_CPE_PATH=3D&quot;${STAGING_OSCAP_BUILDDIR}${datadir_native}=
/openscap/cpe&quot;
-export OSCAP_SCHEMA_PATH=3D&quot;${STAGING_OSCAP_BUILDDIR}${datadir_nati=
ve}/openscap/schemas&quot;
-export OSCAP_XSLT_PATH=3D&quot;${STAGING_OSCAP_BUILDDIR}${datadir_native=
}/openscap/xsl&quot;
+export OSCAP_CPE_PATH =3D &quot;${STAGING_OSCAP_BUILDDIR}${datadir_nativ=
e}/openscap/cpe&quot;
+export OSCAP_SCHEMA_PATH =3D &quot;${STAGING_OSCAP_BUILDDIR}${datadir_na=
tive}/openscap/schemas&quot;
+export OSCAP_XSLT_PATH =3D &quot;${STAGING_OSCAP_BUILDDIR}${datadir_nati=
ve}/openscap/xsl&quot;

 OECMAKE_GENERATOR =3D &quot;Unix Makefiles&quot;

diff --git a/recipes-ids/aide/aide_0.18.8.bb b/recipes-ids/aide/aide_0.18=
.8.bb
index e2014a1..2912cb2 100644
--- a/recipes-ids/aide/aide_0.18.8.bb
+++ b/recipes-ids/aide/aide_0.18.8.bb
@@ -16,7 +16,7 @@ UPSTREAM_CHECK_URI =3D <a class=3D"moz-txt-link-rfc2396=
E" href=3D"https://github.com/${BPN}/${BPN}/releases">&quot;https://githu=
b.com/${BPN}/${BPN}/releases&quot;</a>

 inherit autotools pkgconfig aide-base

-PACKAGECONFIG ??=3D&quot; gcrypt zlib e2fsattrs posix capabilities curl =
pthread \
+PACKAGECONFIG ??=3D &quot; gcrypt zlib e2fsattrs posix capabilities curl=
 pthread \
                  ${@bb.utils.contains('DISTRO_FEATURES', 'selinux', 'sel=
inux audit', '', d)} \
                  ${@bb.utils.contains('DISTRO_FEATURES', 'xattr', 'xattr=
', '', d)} \
                  &quot;
diff --git a/recipes-ids/ossec/ossec-hids_3.7.0.bb b/recipes-ids/ossec/os=
sec-hids_3.7.0.bb
index fbd1294..d9f5121 100644
--- a/recipes-ids/ossec/ossec-hids_3.7.0.bb
+++ b/recipes-ids/ossec/ossec-hids_3.7.0.bb
@@ -18,7 +18,7 @@ inherit autotools-brokensep  useradd
 S =3D &quot;${UNPACKDIR}/git&quot;


-OSSEC_DIR=3D&quot;/var/ossec&quot;
+OSSEC_DIR =3D &quot;/var/ossec&quot;
 OSSEC_UID ?=3D &quot;ossec&quot;
 OSSEC_RUID ?=3D &quot;ossecr&quot;
 OSSEC_GID ?=3D &quot;ossec&quot;
diff --git a/recipes-ids/tripwire/tripwire_2.4.3.7.bb b/recipes-ids/tripw=
ire/tripwire_2.4.3.7.bb
index e67d3c7..3c85027 100644
--- a/recipes-ids/tripwire/tripwire_2.4.3.7.bb
+++ b/recipes-ids/tripwire/tripwire_2.4.3.7.bb
@@ -1,7 +1,7 @@
 SUMMARY =3D &quot;Tripwire: A system integrity assessment tool (IDS)&quo=
t;
 DESCRIPTION =3D &quot;Open Source Tripwire=C2=AE software is a security =
and data \
 integrity tool useful for monitoring and alerting on specific file chang=
e(s) on a range of systems&quot;
-HOMEPAGE=3D<a class=3D"moz-txt-link-rfc2396E" href=3D"http://sourceforge=
.net/projects/tripwire">&quot;http://sourceforge.net/projects/tripwire&qu=
ot;</a>
+HOMEPAGE =3D <a class=3D"moz-txt-link-rfc2396E" href=3D"http://sourcefor=
ge.net/projects/tripwire">&quot;http://sourceforge.net/projects/tripwire&=
quot;</a>
 SECTION =3D &quot;security Monitor/Admin&quot;
 LICENSE =3D &quot;GPL-2.0-only&quot;
 LIC_FILES_CHKSUM =3D <a class=3D"moz-txt-link-rfc2396E" href=3D"file://C=
OPYING;md5=3D1c069be8dbbe48e89b580ab4ed86c127">&quot;file://COPYING;md5=3D=
1c069be8dbbe48e89b580ab4ed86c127&quot;</a>
diff --git a/recipes-kernel/lkrg/lkrg-module_0.9.7.bb b/recipes-kernel/lk=
rg/lkrg-module_0.9.7.bb
index 751c045..20982a8 100644
--- a/recipes-kernel/lkrg/lkrg-module_0.9.7.bb
+++ b/recipes-kernel/lkrg/lkrg-module_0.9.7.bb
@@ -1,5 +1,5 @@
 SUMMARY =3D &quot;Linux Kernel Runtime Guard&quot;
-DESCRIPTION=3D&quot;LKRG performs runtime integrity checking of the Linu=
x \
+DESCRIPTION =3D &quot;LKRG performs runtime integrity checking of the Li=
nux \
 kernel and detection of security vulnerability exploits against the kern=
el.&quot;
 SECTION =3D &quot;security&quot;
 HOMEPAGE =3D <a class=3D"moz-txt-link-rfc2396E" href=3D"https://www.open=
wall.com/lkrg/">&quot;https://www.openwall.com/lkrg/&quot;</a>
diff --git a/recipes-mac/ccs-tools/ccs-tools_1.8.9.bb b/recipes-mac/ccs-t=
ools/ccs-tools_1.8.9.bb
index a746c56..3f754e9 100644
--- a/recipes-mac/ccs-tools/ccs-tools_1.8.9.bb
+++ b/recipes-mac/ccs-tools/ccs-tools_1.8.9.bb
@@ -26,7 +26,7 @@ do_install(){
     oe_runmake INSTALLDIR=3D${D}  USRLIBDIR=3D${libdir} SBINDIR=3D${sbin=
dir} install
 }

-PACKAGE=3D&quot;${PN} ${PN}-dbg ${PN}-doc&quot;
+PACKAGES =3D &quot;${PN} ${PN}-dbg ${PN}-doc&quot;

 FILES:${PN} =3D &quot;\
     ${sbindir}/* \
@@ -46,4 +46,4 @@ FILES:${PN}-dbg =3D &quot;\
     /usr/src/debug/* \
 &quot;

-REQUIRED_DISTRO_FEATURES ?=3D&quot; tomoyo&quot;
+REQUIRED_DISTRO_FEATURES ?=3D &quot; tomoyo&quot;
diff --git a/recipes-perl/perl/libwhisker2-perl_2.5.bb b/recipes-perl/per=
l/libwhisker2-perl_2.5.bb
index 2c32bfc..e16e5f2 100644
--- a/recipes-perl/perl/libwhisker2-perl_2.5.bb
+++ b/recipes-perl/perl/libwhisker2-perl_2.5.bb
@@ -15,7 +15,7 @@ S =3D &quot;${UNPACKDIR}/libwhisker2-2.5&quot;

 inherit cpan-base

-PACKAGEGROUP ??=3D&quot;&quot;
+PACKAGEGROUP ??=3D &quot;&quot;
 PACKAGEGROUP[ssl] =3D &quot;, , libnet-ssleay-perl, libnet-ssleay-perl&q=
uot;

 do_install() {
diff --git a/recipes-scanners/checksec/checksec_2.6.0.bb b/recipes-scanne=
rs/checksec/checksec_2.6.0.bb
index 3712e68..4767239 100644
--- a/recipes-scanners/checksec/checksec_2.6.0.bb
+++ b/recipes-scanners/checksec/checksec_2.6.0.bb
@@ -2,7 +2,7 @@ SUMMARY =3D &quot;Linux system security checks&quot;
 DESCRIPTION =3D &quot;The checksec script is designed to test what stand=
ard Linux OS and PaX security features are being used.&quot;
 SECTION =3D &quot;security&quot;
 LICENSE =3D &quot;BSD-3-Clause&quot;
-HOMEPAGE=3D<a class=3D"moz-txt-link-rfc2396E" href=3D"https://github.com=
/slimm609/checksec.sh">&quot;https://github.com/slimm609/checksec.sh&quot=
;</a>
+HOMEPAGE =3D <a class=3D"moz-txt-link-rfc2396E" href=3D"https://github.c=
om/slimm609/checksec.sh">&quot;https://github.com/slimm609/checksec.sh&qu=
ot;</a>

 LIC_FILES_CHKSUM =3D <a class=3D"moz-txt-link-rfc2396E" href=3D"file://L=
ICENSE.txt;md5=3D879b2147c754bc040c29e9c3b84da836">&quot;file://LICENSE.t=
xt;md5=3D879b2147c754bc040c29e9c3b84da836&quot;</a>

diff --git a/recipes-security/cryptmount/cryptmount_6.2.0.bb b/recipes-se=
curity/cryptmount/cryptmount_6.2.0.bb
index d69d88b..424ff56 100644
--- a/recipes-security/cryptmount/cryptmount_6.2.0.bb
+++ b/recipes-security/cryptmount/cryptmount_6.2.0.bb
@@ -10,7 +10,7 @@ inherit autotools-brokensep gettext pkgconfig systemd

 EXTRA_OECONF =3D &quot; --enable-cswap --enable-fsck --enable-argv0switc=
h&quot;

-PACKAGECONFIG ?=3D&quot;intl luks gcrypt nls&quot;
+PACKAGECONFIG ?=3D &quot;intl luks gcrypt nls&quot;
 PACKAGECONFIG:append =3D &quot; ${@bb.utils.contains('DISTRO_FEATURES', =
'systemd', 'systemd', '', d)}&quot;

 PACKAGECONFIG[systemd] =3D &quot;--with-systemd, --without-systemd, syst=
emd&quot;
diff --git a/recipes-security/isic/isic_0.07.bb b/recipes-security/isic/i=
sic_0.07.bb
index d39184e..8e0f5ce 100644
--- a/recipes-security/isic/isic_0.07.bb
+++ b/recipes-security/isic/isic_0.07.bb
@@ -17,7 +17,7 @@ SRC_URI =3D <a class=3D"moz-txt-link-rfc2396E" href=3D"=
http://prdownloads.sourceforge.net/isic/${BPN}-${PV}.tgz\SRC_URI[md5sum]=3D=
">&quot;http://prdownloads.sourceforge.net/isic/${BPN}-${PV}.tgz \
 SRC_URI[md5sum] =3D &quot;</a>29f70c9bde9aa9128b8f7e66a315f9a4&quot;
 SRC_URI[sha256sum] =3D &quot;e033c53e03e26a4c72b723e2a5a1c433ee70eb4d23a=
1ba0d7d7e14ee1a80429d&quot;

-S=3D&quot;${UNPACKDIR}/${BPN}-${PV}&quot;
+S =3D &quot;${UNPACKDIR}/${BPN}-${PV}&quot;

 inherit autotools-brokensep

diff --git a/recipes-security/sshguard/sshguard_2.4.3.bb b/recipes-securi=
ty/sshguard/sshguard_2.4.3.bb
index 37b414e..de3d856 100644
--- a/recipes-security/sshguard/sshguard_2.4.3.bb
+++ b/recipes-security/sshguard/sshguard_2.4.3.bb
@@ -1,10 +1,10 @@
-SUMARRY=3D&quot; Intelligently block brute-force attacks by aggregating =
system logs &quot;
+SUMMARY =3D &quot; Intelligently block brute-force attacks by aggregatin=
g system logs &quot;
 HOMEPAGE =3D <a class=3D"moz-txt-link-rfc2396E" href=3D"https://www.sshg=
uard.net/">&quot;https://www.sshguard.net/&quot;</a>
 LIC_FILES_CHKSUM =3D <a class=3D"moz-txt-link-rfc2396E" href=3D"file://C=
OPYING;md5=3D47a33fc98cd20713882c4d822a57bf4d">&quot;file://COPYING;md5=3D=
47a33fc98cd20713882c4d822a57bf4d&quot;</a>
 LICENSE =3D &quot;BSD-1-Clause&quot;


-SRC_URI=3D<a class=3D"moz-txt-link-rfc2396E" href=3D"https://sourceforge=
.net/projects/sshguard/files/sshguard/${PV}/sshguard-${PV}.tar.gz">&quot;=
https://sourceforge.net/projects/sshguard/files/sshguard/${PV}/sshguard-$=
{PV}.tar.gz&quot;</a>
+SRC_URI =3D <a class=3D"moz-txt-link-rfc2396E" href=3D"https://sourcefor=
ge.net/projects/sshguard/files/sshguard/${PV}/sshguard-${PV}.tar.gz">&quo=
t;https://sourceforge.net/projects/sshguard/files/sshguard/${PV}/sshguard=
-${PV}.tar.gz&quot;</a>

 SRC_URI[sha256sum] =3D &quot;64029deff6de90fdeefb1f497d414f0e4045076693a=
91da1a70eb7595e97efeb&quot;

--
2.43.0



-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#1366): <a class=3D"moz-txt-link-freetext" href=3D"htt=
ps://lists.yoctoproject.org/g/yocto-patches/message/1366">https://lists.y=
octoproject.org/g/yocto-patches/message/1366</a>
Mute This Topic: <a class=3D"moz-txt-link-freetext" href=3D"https://lists=
.yoctoproject.org/mt/112270358/3616873">https://lists.yoctoproject.org/mt=
/112270358/3616873</a>
Group Owner: <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:yocto-p=
atches+owner@lists.yoctoproject.org">yocto-patches+owner@lists.yoctoproje=
ct.org</a>
Unsubscribe: <a class=3D"moz-txt-link-freetext" href=3D"https://lists.yoc=
toproject.org/g/yocto-patches/leave/13170723/3616873/476927670/xyzzy">htt=
ps://lists.yoctoproject.org/g/yocto-patches/leave/13170723/3616873/476927=
670/xyzzy</a> [<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:chang=
qing.li@windriver.com">changqing.li@windriver.com</a>]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


</pre>
    </blockquote>
  </body>
</html>

--------------yML7B0bDogErvFst81Ya5jEi--

