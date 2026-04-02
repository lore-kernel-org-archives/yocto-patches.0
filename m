Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6A3CC6B33
	for <webhook@archiver.kernel.org>; Thu,  2 Apr 2026 08:32:17 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11148.1775118724086592435
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 Apr 2026 01:32:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=nNK1XZ0T;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=8552b40fc7=yi.zhao@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6325LvA74035362;
	Thu, 2 Apr 2026 01:31:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=sqxiyUL0JExsikr9lscSGKzSZmhOROkuEa0ufQDOxho=; b=
	nNK1XZ0TiL6A6PpN+9Yvr8koVhARTLfRba1W22j9JMwLSgGaIQbDbWep/ixjE9W0
	VHJTSIPmmcN1ZSEOWkDMrERd0tBcTsV8LQ0d7M/j2cxpMJIxGU8yZDzfW9bsPyXs
	uCCpNRJwH+DGpHQ60rRfBk2ubATwWklHD4rpETuOGHo1xQ7Mc+EMaECtRIXI6ZJk
	njlRSXzMqy6bF6B8adGNCH8kyifUiEWMZG0CGkrXygRnHe0UJ38JRT4N8lkSssWd
	aA6ep3RupYKAtPeqFwQtNR/6HGiwuBYLMPPo85gDmpu0s5CZ+9YwBsvCG2uakLBR
	LAXZEiEwEXr0reduiHRv7A==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011040.outbound.protection.outlook.com [52.101.52.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d6egby660-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 01:31:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c++p9PqLhJyaoqkGECzLbi/THjmwNk6ClU4LVpOqaf+QNc8wnXaZ6pHrCuOAKil7ASShZTtZttpSlRfp5D6vgrsXyiy4STaEHsgPZZTtnurKXvZgNQuaKWEwF75h3P9bNYBFQLDKLto0bktWmJsVFbACvqe8HlFDsZ2UIWnUPy3NKTttNCJIGPzfgZK/G+NZSRtXAQYsMswd3QIvsxnAJ39LruhW6eSW7DQQbpt9cmMdjCHGACchuEwaATi02o7zClU0Ha6Lwg3FJnqoBkFQwGayjZsMr0tdmqSRq9JRnKADbuxfNzzC1IA8Ylf+6hRP/7T5Fg4I3kHf19Q5C0e5zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqxiyUL0JExsikr9lscSGKzSZmhOROkuEa0ufQDOxho=;
 b=F5M1mgbhOLW0j3WmI/+anLXiUX+xQ1GhFj5zNtfyGWLe1PL8NCWGPlqyJ0NjEhCHjX0tb2bOW5wnI1AcS/uXX1N1oVLWz2hHY7RkLAXV/spOuF6uKhHy2uQQIqLptSz9vOSpKo2Rp7P55CuN0Aft4xvH54uhGw1PcQwD853p6T/7ZTmAdbWNcmtwa/Dzp27PNG92bzd61BWPS8lgzIRxHkSA6QIW/TUhWpmGnq0UiVePXgFEpT8lIDg3/saXDbOR4xqPM47yK/Nyw7jEloETKQHZ4RknvcEHo15EIOGucHUG0x55F9N5o+ONF884CdrmN07Z0Fs6MtbdUPxAQNC4NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 PH7PR11MB6795.namprd11.prod.outlook.com (2603:10b6:510:1b9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Thu, 2 Apr
 2026 08:31:52 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831%6]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 08:31:52 +0000
Message-ID: <031bf8f6-0b96-4ad1-8f84-8f9ba01acb55@windriver.com>
Date: Thu, 2 Apr 2026 16:31:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-selinux][PATCH]] libsepol: disable LTO to
 fix buildpaths QA failure
To: yocto-patches@lists.yoctoproject.org
Cc: thomas.petazzoni@bootlin.com, Thomas Perrot <thomas.perrot@bootlin.com>
References: <20260328155821.407004-1-thomas.perrot@bootlin.com>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <20260328155821.407004-1-thomas.perrot@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SE2P216CA0108.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c4::7) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|PH7PR11MB6795:EE_
X-MS-Office365-Filtering-Correlation-Id: 058f2525-02ee-4ad1-40de-08de90924a61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	koyVfB1GDU8MYANXcw0Hjpw7k5RtApFIjhoJ+7xucrnwe/n8RStsSzsDaL4rxAVfK9VemJ47ReyktCLLWuq36sgroFFLetju/fSDcAENbFonjJr+hlaqTTDAFwj0Yy0eIasaAulueA5HMf224PEpX86r2R/qpCxWL7XsKC0H6R6AuHZwUUMP+q//vMbfTuDaukPrHwRXO47qHZJgFyaNPu/wGEWjtmGlTi6drKHX1MfgcFdTLvcAhLzxJ6g5c/RKVnHL3e4QIqCPGyiu4rX6NG22Xq7Q46xrFZ3dmrW5mG4vRMfzid68fil//xSd/rRtHo7UfHV0QN59uNuui+mB2v/PUM7u9EcCcOHgpMUDCh6XrBEFwxzC/s7kw9nhkuC5ARwD6i1cL1KSzE4uuO72R004i6yAHcWfb3sdD1kwkOMjHg34xZBe+Ne0a8Gz7xsz+A0/WTJRR24ca9L5u9DdQ8KBKg5Zxq6kAvraJGWiUC7v/l5SmMuV0bVx0m54bOf02ix0+4T6xwkoE1a1YY1qTXSQ8ldt2hv+SMg2XIMR/oOU9qngzZrZoEF8TSjlfoiJlMtQ5vjCqzfMwD6w1um3boKZ9P/1VCpwoZ5mvvgOxxuR6crDZ/FGaZTtJoGdfRIEG9NT1o340/I8onXcPb7duUasDUUZwf/fJOMPHYtoAg+JoaQT0woPEiAC63EAMT9EFLFNDzSPVFlIm7iXUH7+3Dz0m85aGLd5oOA8ErPj4iM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SDBaazNsMTRNOHhNZ0c5SUhUYkVqT2grNTBmNUlraW95VEdxUXBLMWw3SnpK?=
 =?utf-8?B?aER2WGJyd214MEtvRmhad1NRUVY4UU5sUEV4d3ZNYktwaVVRdUhZc1BRSXhY?=
 =?utf-8?B?bVVObHllejFpMXhjTDZlMVVERU16Ri9FaUVLV255VEhUN3U2SW9zR1dBSXdU?=
 =?utf-8?B?MEZNRkFIaG1kOEFjS1Y1TlZzL0NWQlA2VmpGb3F6TnhsYWtjNXBmOG4rQUZB?=
 =?utf-8?B?OXRCMkVTQVdTdzJpU0ZNbXlVNXpmRjVzTXViVS90QTdjTUdUN1I3MzBvdGxM?=
 =?utf-8?B?VzlQUjZid0YzOHpzZzJJeStlTWxZSW5JUmd4blBLM1pHT1VzZUR3MUV5VTkr?=
 =?utf-8?B?MFlKQTdQR245R3d2LzVmanlyekFXeU8rbGxsai9zVlo0TE5LNkliM1J6QlpR?=
 =?utf-8?B?MVc5SWFDdms5UW1YMDVRVVcyRms4SFFla0pmNGNaaFhzSmdyWCs0eStwUkpo?=
 =?utf-8?B?WDIyaVRXaW90akJwTytyUWl1OW9oZEk4dEhjaDVRT3g2S0hhTVVxcnZhamhG?=
 =?utf-8?B?cFlHR3hVUlUrUlNoQTJNV3R4dU0vRjE5VklTNGI1a2tRZHFFTnc5Nlg4N2dG?=
 =?utf-8?B?bnNQNnA2L3F1TjZMWU5MbEppbG5OMWQ2d0hmeDdiK0V5YWxjVHNLRzkrcFFM?=
 =?utf-8?B?ZUhjVFF3Z1N0cENOWWV4V0cvUUZFSFFOS3cxU1FpSE9nb2RmUlMwd0tIM1hk?=
 =?utf-8?B?QWF5Nk9PMDE0Rk1jc0pSeUNpM1RhNXJOVVlBdVBBNHN6V3RyL21zYUdxdWs1?=
 =?utf-8?B?aUR3UlNaWEk3V3V1bHpzUFZhdVdnNmlzd2ZXWVdvOVdjZmdJZUJleE5nM3Zu?=
 =?utf-8?B?VWpRS00vY3A3bzVnMHVoSng0eG5CelQzRzZ1bDNUVkFhMlpZdmNIdlRJcDRt?=
 =?utf-8?B?ZGhJTlY4cmd2aVd1RGlicGRFdU9ZaGJueUpkT3VxZVZiN2ZuQUlrcU1XUEti?=
 =?utf-8?B?MjBmdnF2NEZ0R1R4VjdvUjNoeEtEQmNFbkh2bnZkTFJyZHZTOGNmN0dVaGVP?=
 =?utf-8?B?akRMeEwwMTNna0pSeTJXQUdVYndBWHVPY2RYQ1hseGhKNThmUFdnNUc2Q0s4?=
 =?utf-8?B?a3Q2WmRGVDl1ODEranBjZ29WcG9adjNMakNZRENVSEovWUNENHdlN3JsR1dU?=
 =?utf-8?B?RmxzQnkxL0JKZDVhRVBGcHBHZlFFU1BiaWk4eHhDbWtmTmZMVnNNTzJDWVdQ?=
 =?utf-8?B?Nm50MEptSUYydm8rVTRKMDlSZ1E0cWhHQzZ5Q0R1UHlyZ0hDMlpxQzUrYVZX?=
 =?utf-8?B?NWl3ZGRXaU1kbWpBaDcwaXdtR09kbDdDYXdEVFJZaGpkUGJwMEhvdWdMMFl1?=
 =?utf-8?B?MW9sTmI3VFlmZjgyYWRhSCtabThqcG82SXJMY1UrQUllL081QmFXakg2VHZP?=
 =?utf-8?B?RFVOWjVFak1WUUlMQW9DYlV5V3ZCYnJRcG54aEg4Zm51R1J4bG1jMHZrS29R?=
 =?utf-8?B?UVVkbm5sQWNHUm1laGYvd2QrK3VBN1lRL3JzSzR0NUVWR1pSRE5FNGVYV0ht?=
 =?utf-8?B?SytjN2xUSGZDdGNRME5MdklTZDkzYklVSGVIQUgreGFzMUlGTjhma2VydkFs?=
 =?utf-8?B?UDA1cEptbUdhd3hRV0oxOHo0cHU5NnlDVnF5ZHdCOUtiM2lSRTZPc0xqWnk4?=
 =?utf-8?B?TGJlN29PK2M4QUxFYnNVZVAyWnZ4Vm9oSUczZlphRE45N3hxblpYOHd1Zmpl?=
 =?utf-8?B?cEFqWklMcDdqdkpKSWYrL29BN0oyS3B2Y0FkQjdrYUZSeXpTZGZEaWJ6YlVH?=
 =?utf-8?B?dmpOYno0V0NhN2h2TlUzdis1c29OVHRIRHVsd1NuNngxTERjVWRQWU9rYXhu?=
 =?utf-8?B?c1UwVXlQSlVMTUlJaWEvTExsenM1T1ZvQm9tS0lObWQrUWJpUS9DSWF2cDd6?=
 =?utf-8?B?VlRGczlLcnRFR0cvcU5WbkhmaDZlVWYxUHRoNzdLYU5reFk1QTlxYS96RGR5?=
 =?utf-8?B?bkpFR2JlWjdhWGVmbmROUkFVRy9LUitjREJUYzQwUFp5QzE1M0N6T2xDRUd6?=
 =?utf-8?B?VElKT056MWxYU3dVT3p6ZzZ0TlFOcWdSWUREYW9sKzNsSUY2RU4ya2hCN3dO?=
 =?utf-8?B?UlNmRktlVnQxNFZIRzdwSkhJbFc4Tlh5cTB4eUliMDNsejlVSHRQdURtK2sz?=
 =?utf-8?B?UStyNGJUanVUaXFCbVdZY3BXNnZZNDdQNGs4NWZwQjRFZnB4Syt2SGlacUVE?=
 =?utf-8?B?WmhrbHo5VVloS2hDVVFjY0dHSmRvQW8wN0FJeG5wZGtVZlRYblJraGVLV2pZ?=
 =?utf-8?B?REdRTzRNVDc3cFhzTjVJTzViMkNXeDZqYnJLMm5MM0ZJRWtwTnhBampmcHVG?=
 =?utf-8?B?c1lWYU5KclZjUC8zOUZVYTdKZXpQbGhnd3Z6SE1pSTErK2Yvbk55Zz09?=
X-Exchange-RoutingPolicyChecked: 
	sASo9ZOS8TLpS2kEejBuh2yeSiOlZ9I6J5JDpnbuvPkb43vH3cv+sn99brZ3O/AQGh1KvlO8JzJXAugsbFziRVKWNDHbigBnO3uh9UNRweWkkjBzFVQswoOhSJUoHGKOtHa5uyjW0z+UtledyVvyDDghqReYI1wJDYSQOjv9o2Muf1L0pd451aAk5IWm2YvPjbfnWVLZTlfOCIY2x3AOApTAhgKS7ev9SV+fUpXtXzXOMbYteB2A3hLYHm+UgzqK48tIholijom5T8+XV4CU7vHNhpLrBjhL/YPTGx/MsEfY+pwCnrDaNiITvbu4Cpc5n03d49cbol5OGcIpaMo4bQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 058f2525-02ee-4ad1-40de-08de90924a61
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 08:31:52.3398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nraNacpSbWXKqOkZM1qmIVewD3PZN+pGeGgbQDSz9UDCDx+7V75p4PwklV0z8GqwAZoX8F3oP4ZpgnlSgbrnNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6795
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA3NSBTYWx0ZWRfX02VBhAdpwQtX
 bHRwsItfdhTQMb5Lta8bRsiFBB4J8tx+HlAqURSwhg0s0Mkm9q2hQHzi+DF7wNCGR7EOvfIi4i1
 mN7d0yqS8FeSO0Ja3MmCQyOCkSunfrhxk/t7sOb3zz2tWt8J8fJuocvXVG4z5k5rYTTAKas9Wa5
 N2mkFrG3R4L+Ahs/Crss7RWui92si/vUjZhsjJiMu0sXY9srs/4nAkFZQ5+62DfP2V2EPHtSfYh
 5nyDftu+IpV2c3novcSFuA2s9Fiv37DGtZhg8H2w388FmiXydIEy3m6iE188x18DM9Ib8shTAjb
 SwmRaPzY8GZA4ekaZRRHrVZIxwl6/7DhFzdGCzI4baO9ZimN/+zQYa1JhfwsEwzsFODAY1lL6T9
 EZtuXHQ0EFAGSLBD7vEV/wUnEkxxi6hMGFiGe7KRZFO7jP3f98EPaoX2lcT0QZUR3U9fcnrWKkz
 jYkOP1essM3+TS6RhJA==
X-Proofpoint-ORIG-GUID: g9_mqc66vRvbRLZ-tp84yP2ulNGLq8NI
X-Proofpoint-GUID: g9_mqc66vRvbRLZ-tp84yP2ulNGLq8NI
X-Authority-Analysis: v=2.4 cv=fvrRpV4f c=1 sm=1 tr=0 ts=69ce297b cx=c_pps
 a=u7dnV0yUwpVRNDUrCOcuvQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=iGHA9ds3AAAA:8 a=P-IC7800AAAA:8 a=wxPIa0pddvBYW32E4lcA:9 a=QEXdDO2ut3YA:10
 a=nM-MV4yxpKKO9kiQg6Ot:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1011 impostorscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020075
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Apr 2026 08:32:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3611

Hi Thomas,


Could you please provide the build steps to reproduce this QA failure? I 
can not reproduce the issue, even without applying this patch.


Thanks,

Yi

On 3/28/26 23:58, Thomas Perrot via lists.yoctoproject.org wrote:
> From: Thomas Perrot <thomas.perrot@bootlin.com>
>
> Fat LTO objects in the static library embed original source paths in
> .gnu.lto_* IR sections. Unlike DWARF output, these sections are not
> affected by -ffile-prefix-map, causing TMPDIR references to survive
> into the installed libsepol-staticdev package.
>
> Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
> ---
>   recipes-security/selinux/libsepol_3.10.bb | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/recipes-security/selinux/libsepol_3.10.bb b/recipes-security/selinux/libsepol_3.10.bb
> index 0423a2a6ea31..0a51aba28ee8 100644
> --- a/recipes-security/selinux/libsepol_3.10.bb
> +++ b/recipes-security/selinux/libsepol_3.10.bb
> @@ -13,4 +13,8 @@ inherit lib_package
>   
>   DEPENDS = "flex-native"
>   
> +# LTO fat objects in static library embed original source paths in .gnu.lto_* IR
> +# sections which are not affected by -ffile-prefix-map, causing buildpaths QA failure
> +LTO = ""
> +
>   BBCLASSEXTEND = "native"

