Return-Path: <changqing.li@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEA8C8303D
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 03:09:04 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.4585.1751598539838879821
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 03 Jul 2025 20:09:00 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=9280b40441=changqing.li@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56438v10030355;
	Fri, 4 Jul 2025 03:08:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 47j5m1ed5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Jul 2025 03:08:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcwRBXlI4GzNZ4lMvn0H/xGiPfJOpb0kfFLGXtY+QbrlHCmb/Y+qn+zv5maYO4zyT6TpT3DeKi2tMHOrZK7cPUgfm4yums1tT94vEHwtiRJAenpWe4Ab0SEO4Ag4V5cBrxKcZH/gXsLeIxLR6vEA1lICRNsE0XGGaw5P8RwgF2X1GZcFbNpC+ueWx3P0G3qgkMRJF93K3ahg28rdJeQEO+Qs4WiFk8wOML8HzcE26ybt1nnV/t7DhE8kWuW3bc0juZVsAMhH29u7q08WS+ER9Mf03FR8EZymkYC1tpCCFChe87nUpnoE+vXa/cPWTvbF1f0cnowbfXCIVtsq7py4eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMu8pSYxoXiXQrqinXDiibQtlUsoKAQ9kav+1rhWriQ=;
 b=HYILPedk7X+DBVnlPnfJ1PTB1fS8JIiMqLUSQmBYuHdYfGNdtufPgJ+jYmYDq3Fs0lOMqjIHutryZmGFrNdxsDUaqI4LKQnwJEmjwLf0BI7fQFFzPxW3SkS94/6+d4VpUUdTz5H22STThjfkwD0R5Rda4hMU5dtsEWAWFFeORDCy6h6l3LL3fT/CHF7Myr7jgxNs2poMzElz/ajfoPwF8BtjKbj3P9KxY4HxgBFehKv3Zh1Qcjs1rozdGzMKy7GF2YlzHhKNA5XPOHnPjdiLgrdk1L5xQ8BOpJ8XL4nI9RD7yWjaR8/ya1cnTN3LXu0V3nqZ01m4nZNEz1fhfBOzLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7312.namprd11.prod.outlook.com (2603:10b6:8:11f::18)
 by BY1PR11MB8005.namprd11.prod.outlook.com (2603:10b6:a03:523::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 03:08:52 +0000
Received: from DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c]) by DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c%4]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 03:08:52 +0000
Content-Type: multipart/alternative;
 boundary="------------rpqfOtWPRtwbrwCyB5kPNdPn"
Message-ID: <4bcf6dad-ec55-4864-92bd-c953bdd2b891@windriver.com>
Date: Fri, 4 Jul 2025 11:09:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][PATCH v3] Fix warning : lack of
 whitespace around assignment
To: yocto-patches@lists.yoctoproject.org, scott.murray@konsulko.com
Cc: Jason Schonberg <schonm@gmail.com>
References: <20250415022440.549142-1-schonm@gmail.com>
Content-Language: en-US
From: Changqing Li <changqing.li@windriver.com>
In-Reply-To: <20250415022440.549142-1-schonm@gmail.com>
X-ClientProxiedBy: SL2P216CA0131.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1::10) To DS0PR11MB7312.namprd11.prod.outlook.com
 (2603:10b6:8:11f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7312:EE_|BY1PR11MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: b19f9412-96a6-4a76-9467-08ddbaa81ad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|4022899009|376014|8096899003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bDFsSm8yWmRBRnNMRlBLV2hDR2RDWTVLdlBVOTNpaXdzejZKUGxocjJBbXRF?=
 =?utf-8?B?M3pTTUFqQTVUTEJVWE4zTUlYc1MvZmY5cHJkWnpuYmo2aWs2Z05tVURNbWU0?=
 =?utf-8?B?TDY2RGVGWGZ2MFYyOGlMUTdwQ1RiamdhYVhrMW9aVFI3ZGhnczNHUnJaL0RT?=
 =?utf-8?B?ZTRCODNDT3RHT1lzb1Y4MkY1ejAxclIxSGhDMEJPNDd5bjBHeDBvS1JqSW9V?=
 =?utf-8?B?RUdFSk14RzJZY0ZlYS9Fc0lQUk9jNE1WUmpwYitoN3RYYUVrK0FqMWNNWnlH?=
 =?utf-8?B?SW9yYk01eU9ISU5JSXUwV2FjYlBVb1RLaXltZmZzZ3lzMTZaZlF2dVZrS3lo?=
 =?utf-8?B?WjhQeFRDRFFoaXdSNkNRaTkvL2o5SzI1NHlkVExQcWp2bzQwYnA4dWlJaW9t?=
 =?utf-8?B?Sk03eUE3YnNwVmc1ajRxcFdrWEhWTGkwTE1UWkUyQThHZUl6Q242ekVDWVN3?=
 =?utf-8?B?dFRtL292YmFWb0tON3h0L2hvRURjejFncUpQRzU3ekZobTlGdldJL28rTEJh?=
 =?utf-8?B?QmxjQWw1bXBTODhuTmZtemt2Y2VDeG16NThKZ0xBY3RLZGhkTUhxWnF1cXF2?=
 =?utf-8?B?enZYYXZ6L2oxbzBteFVDVk5rWEhUTFl2MFV2THlZc3VEUWxDaVhnbGh6eDZM?=
 =?utf-8?B?NlRTVEpOTGtjSmxWTEE4QW03RjZuanhWT0RSUmUxVXJBZnhxN0JEZmNrSDZG?=
 =?utf-8?B?c0JLZEFxdVdDdHZ0ajZKbzlRSUFza1VHWTcrNzVwbkJleWx1eWtvUlZDZDRo?=
 =?utf-8?B?bDkvQUNFYmpsZUJBazNkc09LT2EzblpaN21nNks0dzRwZ1RIWlE5NTNkRm0v?=
 =?utf-8?B?d1RiQXpEUDVTMWVVUjJnTGQ0WXFTOC9RQ1NPaXhIaEFWemZUN2tlNFZFS1Vl?=
 =?utf-8?B?Nm9iZGxXRHUzU2M0RUNkVGJ0ZHlTdjRQL1llUTV4L2ZUcXpRRDV4eGlrc0Uy?=
 =?utf-8?B?cDJnaTJOSmdqaldKWTlFenpuUjFvdUpaRWl2RXZ1RVNJK1dFUmt5ZmJQbVk4?=
 =?utf-8?B?RTJRdlY3VzNCSk9tM2ZWcXZJRUl3VzBBM2kvT2pMSEFwZ2FqRlBuZmYzdGdp?=
 =?utf-8?B?bEExVUNySEVKMEdlekkvakhKdk1LM3Z6Z3JOVzVmVW0vY1NJSDJGY3J6OWp2?=
 =?utf-8?B?WUVuRkJqeDZhN1VxdHp4YUh5cnlaSHF2ZWJ4cXEvRnJLV09KVytYWFdTSkNz?=
 =?utf-8?B?OTZHNS9pbEJOZFVEUFZid2M0QndWcTNHeFVrYlM1RmMrdGdMMVE5RVVRVjFp?=
 =?utf-8?B?Q0pSYTFISFFoWW02b0JyUHNlRWNxekNNMGdwUE9lMkFuTWx6dGI2S0JNQnZm?=
 =?utf-8?B?dW1HKzh2ZVdGQnpUakpzd2NOL1YyOHlEMi9acWdKdDhlbFprUzgxTkMxcDBR?=
 =?utf-8?B?WERRZ05iYjc4VDU4akVxWnFPcW8xNUdqdkMyellMRmR6a2UwOW8rbFRpd2F6?=
 =?utf-8?B?UDd2ZWIrRUc0cFR0MWpaNGpCWmRLbHZsQXlTMEtWNXNqS3JyaDhkS3EwYlJy?=
 =?utf-8?B?SlRvYnNldjdhSXNvUlpDMHMwemNYbHcwZm9jMjVQWThIM3ZSUkpBekxBRFVB?=
 =?utf-8?B?QktPZGMwbWxVdnoyVTFJdjNOUUNMNmxTSlRpVmRnMjFKS21sR3FsS1BDalpx?=
 =?utf-8?B?TXdZbHhnTXNvYVhCZElGWHpTT21hZG81TDZpT2RRbzdUdHZmd0MwZlpub2xx?=
 =?utf-8?B?eHp2TlQ2MW8ycEFLV0o0ZUpVcHp5UUZpcWxFU2JGbVN2MjNGNGZkM00xd2Fk?=
 =?utf-8?B?S3R0ZktGQWEyY01tMXlTVE5oNUFPb3lVS2U3RFUrSmdZeklTc2gwQU1udUdZ?=
 =?utf-8?Q?9p+SOs+nc6crOLlqHWKA20rNg0bslh6+3qs98=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7312.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(4022899009)(376014)(8096899003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dW5YTTNWNlVEWHFQRDRqSUJyaHhSWk5Oc2t3R1UzajlyZFBVSXNWYXBhbno1?=
 =?utf-8?B?Uk5SSDhhYjhUek5tSDNBWFRmck51RjhST2RheDRNd1gxNmpibnord1Baeita?=
 =?utf-8?B?WjJXaThNMXd6bWZOZjJjNGtEWS9WNXZGVUdxbTZkUGNDV2xyWW5QS1F5SHBW?=
 =?utf-8?B?YkVYdHVTQk52TERsQWZJV2E0dFpFcGhkM0c0Vmw4U2pnQXJWdFkwTVJtRG5s?=
 =?utf-8?B?aXl0QVlLbEJaS2VRVEFpZGxKdm1zTFc3UWVHQTN5Ky9vVkZBVlpyNDhyNTFV?=
 =?utf-8?B?NER4TUNOVFczNnRXREVlYk44YS8wd290N0dPYTJnYVVrQXNLSUM2MDZCa1kx?=
 =?utf-8?B?NHQvNTU1OC8yRlI1ZWlMb09zVW90WWZHbjA5MFFvRnVqN3BWMTVjanR0azlH?=
 =?utf-8?B?UVFJK2VDaUpqQmVSWDVCSjZ1YUpvN2pIOTdvR2dzcHRWbnNsTFF5N095bUFT?=
 =?utf-8?B?dDI3aEViRDJ2OTNZYzJuKzYvdTZEWXcyalNGSTdkMXRXanBCa21KRlRVUHll?=
 =?utf-8?B?WXppY2pFZWJJc1pSNW9RVUo2aUhHcittU0hqK0RiQ0JhZjFiSUowWW5Ma0pY?=
 =?utf-8?B?dUttR1ltc2RGYldGZVZ4Rm80RHNhRVpZbk16YjAxWDdYUEpwQ0t6cGRzTjdD?=
 =?utf-8?B?b1dGTEQ4N1EyTE5RSUsvZUxNZHNVRkI3T3lTcVFKMU1XbHVtMGtSLzVwSDRt?=
 =?utf-8?B?aUpKQlRtM0NGS1h5L0hrUjZLWG44Y2wxdUJDRFVKSnBzWWRLNk5EYy9oVlNm?=
 =?utf-8?B?ak1UeHRjRjg3cjN5WlNXS25rMDllMTBra2hna093WDRlQmdLWnJmNEt2SUVa?=
 =?utf-8?B?TXlLWUswWlpVK3krQXdaN3hycXorbnhTMjNiMTJqbkltUklybnpWQncxanhW?=
 =?utf-8?B?SWxjdTdVajdMV3BjZklESWlWazR4eVBYejI5SVlCak1mdHgxcVRJa1Rja3I3?=
 =?utf-8?B?d3A1Sk0vS0UrRFhGSUxrd2c0ZDR1UXQwdG55a1VvOHFIdlFjVVJicVFIVXdO?=
 =?utf-8?B?clVmVjhhY0lJcHpRblJsUWxBWnRsL29OZ3dwOGcvUUpNaWpGc1ZMblB6ZHkr?=
 =?utf-8?B?RWxXSFhPWVBIQkpBQkxsSmNWUit6WVRHOEczK3dKUmtjYkx5cFJzLzBRa2FX?=
 =?utf-8?B?Skw2YnJtQUUvV3RJQisvaGR0STR0WnV0eDBoS1lVVDh0T01CS2hJNmhtSDJO?=
 =?utf-8?B?dk5Yb3dSZ1FpQ2U3UnNaSFZBZGdxakJaTm5hbDZWTEtzQ0YzeUhjajdoeCtz?=
 =?utf-8?B?emptYjc5YXdSWVl3VUhYeUhtenl0K0NLQVVpS1pDRHpidHVYWTNaV0pLWUhj?=
 =?utf-8?B?dnBCY2VJOUpJZjEwZlhJVTdDbGE5aCtXanRUUEZnaWdnc1laSHNuY0JxRzJY?=
 =?utf-8?B?OXcwaHJTMGtOTzRYNlZycDVyc3hxRTlnLzgrSnZBVld3Z2pQbDliT29Sd1Nr?=
 =?utf-8?B?WnppblJyNFJONlBMa2ZpNjNpdCtrOG1aQWhPcHdzWTRqS0prTGZOVXF2NFRX?=
 =?utf-8?B?MWFaemw3MDNLdWZ0WWMvbG81OEthbmdubnZmQlFtQml2MXNCMzBqYXAxSTc2?=
 =?utf-8?B?b29lWXpibE56R05EeXdtZkNtK2hnQm9rRTg4VEVVNERDeldkT0czWE1zQXpR?=
 =?utf-8?B?MlMxeHJaME9ielhvbXRVU0NVTWk5ODRXWVk5MVZQaVFhL2IvelFDZ3M1dXZq?=
 =?utf-8?B?RVhETWJ6V01EOEJxNDU3WlRLaHN0WTJrMVM1Z0lIZlBWWmdtK0h1WW9NUis2?=
 =?utf-8?B?NGFHbUlOUUd5SEdzUmNhZ2tnUy9wV0dSRmQveng5cW5IVTRtT2oyc1hEODJI?=
 =?utf-8?B?cWtEeU1ieGtjL21UaEUrMGlKczhHZW5lSTZzN1Z2SCs1MW4wNzA4TTlmWTY1?=
 =?utf-8?B?OFdXS2RQTDZVL2xabjA5SEZzMWhyT2U1L3loNkFOc1ZvNUx4M2F2clJjc0Ra?=
 =?utf-8?B?a1VoL0NrdlNJd0tkWXJkcVp5d0V0K1ZwVEM2VzluWHpkakp1VSsvUzl5K0c2?=
 =?utf-8?B?YURHU3Y4SUllSC9OSzl2dnFrZk43VGJOS2V3aUVBNW1TaDR4NVdscjhmRjFS?=
 =?utf-8?B?ODdrT28xUk5hY1o1dWdQeExQQWRUL0JkWmNiNmVBWERxa3lGaSt0RVE5T24w?=
 =?utf-8?B?RUg2OVRqZXpYR0p5N09Na0RKR2NrYzF6VmdnVWk1RkNIOEJ4N05Tb3EzUXJM?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b19f9412-96a6-4a76-9467-08ddbaa81ad4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 03:08:52.7457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IvN3U4O53oxcWoU52Le3/WJIGWzv2blH2mpRYq4cygn1sTB7CsfbUj1SXy9V5sQsTuDbBsfdx6F8tFy9D3E32//UJg7lwt/fJnNjwqdtfB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8005
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDAyMyBTYWx0ZWRfX3GbwPrdDTzAP NY+crLOV5lOJYrieJ8FUW9SmOIIryLFH0b/xDfhs2XKlef8/a2PcwbUMTDl5HOD9xybN4BRaUQW +F2862wamybWnydaRQgdYOLjkrRTSH1+/zVxywLO+EQbgG9phsgbmdgM0rQHFPLBgImAqWwgVyT
 RmzUMIFO/y5fJtP+QzW+v80CdCv6hany8caXdLQZQ8C3W9UYwoJRREkeBuY/YjwH0UA/WAEclax BvYc5TUv+nR5EeE3rpJnKj2o0fXUytLuAf0pNzBhO7lT8I1NKR5dzfP2A+PX+0R763+OnIk7n6s Sch+htUp536rMkvjMyV7PxPYuD5ZyZz2wfNlj3LgWsnzKNTfCNGCC6/1EU8OG1KHV32J6+vMg9f
 VADsIeSV8o7fRgxIR/UQFZ7L7fTjZ5/D7QItE+M81Yc0OLJnlpLmsNL5J9NzrQQ6MsfbzRN4
X-Authority-Analysis: v=2.4 cv=IOsCChvG c=1 sm=1 tr=0 ts=686745c9 cx=c_pps a=03yO52JTp2ka5dcFpzYbVQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=NEAV23lmAAAA:8 a=FP58Ms26AAAA:8 a=XkRKQH6RAAAA:8 a=LfvH3UrpAAAA:8 a=iGHA9ds3AAAA:8 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=-o9ofTc8XaOiX0qcq28A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=estwG2eNYqAOIwiJ3NUA:9
 a=6FhTQDnE54SvIBQs:21 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10 a=1gUyE30hU_ULiMxJiLUW:22 a=n7Al05T9dhkPszCtvm82:22 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 313hSYYfoa9sDAukjOYT5j0WycG0Q2LX
X-Proofpoint-ORIG-GUID: 313hSYYfoa9sDAukjOYT5j0WycG0Q2LX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_01,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2505280000
 definitions=main-2507040023
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 03:09:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1750

--------------rpqfOtWPRtwbrwCyB5kPNdPn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 56438v10030355

Kindly ping

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
--------------rpqfOtWPRtwbrwCyB5kPNdPn
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 56438v10030355

<!DOCTYPE html><html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body text=3D"#000000" bgcolor=3D"#cceed0">
    <p>Kindly ping <br>
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

--------------rpqfOtWPRtwbrwCyB5kPNdPn--

