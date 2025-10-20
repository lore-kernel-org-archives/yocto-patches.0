Return-Path: <changqing.li@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BC6CCD199
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 08:23:15 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.13411.1760948590954374237
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Oct 2025 01:23:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=HOb1JQqj;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=23889d8e2b=changqing.li@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59K5nFhF4086829;
	Mon, 20 Oct 2025 01:23:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PPS06212021; bh=Te/FP0Tpx6BT1f3Jzl0Xmr
	eRUwvASe1pnmlN1mgxq34=; b=HOb1JQqjLjwYOA98XJr0xuGWgxIyrEbNT8oZvD
	VgONTYV/PrBBjIjdzuSYpFuYOoMB7ZjYO4JtlbMNjq1h7JVJvrdjkp+FxFOt85Xc
	/bMX9uWREPqaayXFledhx17uUcrmh1+DuYqoAi4+15hP1Bxl404PfsQm1GzIOoyD
	Y42g1cLhWXWMrzyG3we1MDdoqNl8ib9ySwpEEgCcglxoX6FBrmvWlP/elfU6DqWF
	klTuJ2SfBnHYXQf1xQBQ9uVQRsHqntBTs6PdMk459omJ9eNVlNVqg3t5Aa6N1uMV
	23D62Vrd9BXfUM8TRaxBX8ybRA57icRpJExLKs2fg5r9vFZg==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010022.outbound.protection.outlook.com [52.101.193.22])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49vadj1a3s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 01:23:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oD76FV1sPE/8ZwlQMLL9WKMUBmEX1kVDDregd4abiXOeaTlnaInww+j4Ha61MKl1BuhO0DPazb4Vi861NorekjWiGQOjX/X0utl3BDEdzzfJxG+SKjjO4HwDRYrbYnYdQFTdUSoGtwpq2gT26M99LXx9tsSXtAQlK9FUo71uQ+Ohdk5lQ4gT6JB9mjvjxS7hrw4wcRp2hKHtzMORmD8OxM24cGbWaiAtPLyCcjzxKpZA7byaPfZOq39nVXyRzOXk9jf8t0yXLu9AbJ5vabsScdNkdBFJX0Xguex9aE+DxKcdFinrXWKKBPBBu40ThANpOKdpEJwdIot8c/Lcm8gZKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Te/FP0Tpx6BT1f3Jzl0XmreRUwvASe1pnmlN1mgxq34=;
 b=fDjgnoOFEEpYGC9G3lM/rx5EpyJyp2jORuVqZJoco4jx0D+tAR867K80IrWrtdmdgvAfpopRKgsWJ04kc72KG4ntgaFnht3HFYbKNzNHLzkRDNcVd7PQFq2UMX5qm5uM7vUHPVMD+Q2zAorkYJCvp7X9d+b8ICJF0+9RqN2RiiFZvw6RBBTXBE6+i07Z1niVaHY7daOxETKAZCf9TuCMXMRkIEfmeKO9xDr7rLDsMuCDL7r7bFj60UzV2T8hs9BatD1NvlBEXnCczwzmXzB3YcYD5ft/IBdWnqQRfBXFz4Vf1zbaZbK+y2LFB6X0oi9hTJVrIYmIlMbLaWuPqYXs8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7312.namprd11.prod.outlook.com (2603:10b6:8:11f::18)
 by SA1PR11MB8475.namprd11.prod.outlook.com (2603:10b6:806:3a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 08:23:06 +0000
Received: from DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c]) by DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 08:23:06 +0000
Content-Type: multipart/alternative;
 boundary="------------sqwCScrtTNwL74nWs2c9wEhh"
Message-ID: <b2259b41-dbef-4f89-8cca-a87b261f4e76@windriver.com>
Date: Mon, 20 Oct 2025 16:23:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-mingw][PATCH] mingw-w64.inc: replace
 WORKDIR with UNPACKDIR
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
References: <186EEAF1C5A5442C.8420@lists.yoctoproject.org>
Content-Language: en-US
From: Changqing Li <changqing.li@windriver.com>
In-Reply-To: <186EEAF1C5A5442C.8420@lists.yoctoproject.org>
X-ClientProxiedBy: TYCP301CA0067.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::20) To DS0PR11MB7312.namprd11.prod.outlook.com
 (2603:10b6:8:11f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7312:EE_|SA1PR11MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: 78feb304-cf7a-4bab-864d-08de0fb1e4f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dVF0NFUxSmdSY2xWbS9TSCtaL0tIcU8vaThRbmVFTThyeGNlTXI5L1ozeHBw?=
 =?utf-8?B?TG5zRGZjVTRtRzVjWHltclZ0SVFLT3Y2Ny9aWkZVZzNpbWxiMmlEZjNTUG9p?=
 =?utf-8?B?Y0ovMVBXay9FN0ZuWlZ4M1dWWWJjeVJrZmZuWGhEYUJkZnlKRCtOaXZPMjNh?=
 =?utf-8?B?ejFyOVZ2UTRrZVJpVWN1cWRVdnBvMHZwQWhIS0VYbkl4QXEyMXllU0tZK2Rr?=
 =?utf-8?B?bXBhRnBZOTlnVDg3WVBZekFwa2NVTzVVSWU5Q01jVzJZS0c0a2EycnRsZTlt?=
 =?utf-8?B?a1QzUHVYVmtiNktERDdGblhqZnNJaXhlVFU3aWg0aGVWRFFSZWhROFN4ZUpZ?=
 =?utf-8?B?aGFYMG1NYnVRckhqS0RUOHZXd1hEcU9NNVBsb0JKcThlSzBRa1JmbEVleFh0?=
 =?utf-8?B?L054VGJ5eFl0VmwvUXNndGR0SnRmWTRTVno1RXlyTFRUcmQzSEptVUpSQVJR?=
 =?utf-8?B?YlBuRDV0WGtoRUV2UXhDQUhHZWhYbml2YW5pbGtMTXNLbWRPaXh2Y3hoYnJu?=
 =?utf-8?B?blhxN2hGczJGWDM1VlpwMkdwaUpnVDE1VmdIR0l4OHp3YjFpdG1HTU1UNm9O?=
 =?utf-8?B?QnJTQTFnRGsxQTI5emhGZTR2Szd5ZDV0TG9QdDF2eE8rMDYzSnlHL0V3ZGFD?=
 =?utf-8?B?alNvY3JsMmlicXRUa09vSHY3cjVZd0NxbTMrbzkxQTF4M3lFTnBvMnpHRXln?=
 =?utf-8?B?TWUrdTJHZDFmMkxmNW4zU1FPSVdOb0RiTVpCMUsyOHJNdCtpMTNQNXlFMVV3?=
 =?utf-8?B?TUJUYVdIaCtqNjB2T2NUVFo0U1BxRzJ0QksxbkZYY1IvTVQrZUlScmdXcFdr?=
 =?utf-8?B?M3NjVG5OVnVCWm5GTmtMWEtvYlExRU5TZVd5MndKRis4SlRWM2JDNm1ZMGVp?=
 =?utf-8?B?YUp4YlFLSGZtQ2dlcURjaDd0WExKd1hrbjEwQ0J4eGlNNnBSQmswWGF1RVk5?=
 =?utf-8?B?cGlaZmJVdFYza094WVp5MEIzYXpkMnpKZk5HVllhSVRnaFpoYVBNS1BYSVl0?=
 =?utf-8?B?MTJ0K0xPNnU2bjIzc052b1VMdmVyQ3BLb0ZrTC9BT0ZNRU45NmRiSGF6aGlh?=
 =?utf-8?B?eHVERmZkRG94SGZJTlgzYmlRRnRBazdhTG52dHJYa1hVa2cyNVNjNEtiQSt5?=
 =?utf-8?B?R3BYc0NQNG5sU2RyYWJ6YVN1aGtrV3Y4R0NYOE5tWW5xUjNjclVlTld3ZWU2?=
 =?utf-8?B?STZ1cm5nWmZGczE4UVBkWitZb2VyZ1NSQ21WTjRhblByR3dqMzI0WHo2T0JR?=
 =?utf-8?B?S2hVeU9pMTAzZDB0eXFkNTRuWVNub1kwY2NWSE9CdUlqNVlpUWhmV29aM0lU?=
 =?utf-8?B?dVZXZ09JVXljSmJSUFpjSjU4VGtxQ21HTlVlTzdTZUlxd1dSLzRaeDZmd0l1?=
 =?utf-8?B?eHhOd2N1YlNia0RXTDA0bmMyU3o4WVBaQVpqem82dDVlMnc4cmNHR2lNZG9o?=
 =?utf-8?B?Zm9SS2ZtM0JTTnoxVE9ZdXhKeCtMOWpkYUxxS1VPcmVWaHMxcnEyVWNjQmlU?=
 =?utf-8?B?MU5XS1Uwck9abmxZdFM0REZiL0JvR0N5cFlnR3ZKZlFlR1lacXh5S2toVEwv?=
 =?utf-8?B?T2dRS1dTRTBHcHZXVjRtQmNXS1VRLzNldTJvSjdudEpoaXBYeEwrakUvbC9z?=
 =?utf-8?B?OU5XeWE5aExEU01LNzJ5ekNSSlJ0eTRMcWl3ZE1BWmNoRldTdGdwOEhGd2gx?=
 =?utf-8?B?WDZCSFZZT0pPNDJoMk9jb082TlNScDlmcFp4UDI5K2g1MlQ1d21nSEg4N080?=
 =?utf-8?B?SXdSbzFIa3ozNDUvY1JYK3JaSXNFd1BDZXAwRzhDTmtkemtsQU9kbnZ6bWl2?=
 =?utf-8?B?RkxvTnZhbHl2RXByMm9MMmRKQXBFUGF3S0h5NGMxQnlhWjBJdDdUd3lBNTFz?=
 =?utf-8?B?Rkp5bVYvektWeVFpSzFqd01Rdk9Ld0N2LzhZdXRhc0FtV1U4dEVKOGtYaWZ2?=
 =?utf-8?Q?mSi92XaQn1rr93CvVxU9TPSnnGfbFg14?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7312.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(8096899003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K09mZ3lXVmZFNTNiZGNLK1F2UXFZNG1KUHRRdHd6TzJKM0RXcFdoKzBmOUx0?=
 =?utf-8?B?b0Izc1RqREs3U3d6bER4Ym10d1NRZTc1N3UvZUozZ2NkTHZSNDdYYVFnQ1lx?=
 =?utf-8?B?L0oyY3F5c0t0SDd2TnVVVXVPVmZ1TVI5TmpwbWhQRXlTcTBMWkFoQWpFd1ZK?=
 =?utf-8?B?TDJONVJid2hueFVIL0g4VjI5ZWY3dXpmRkxWQzh1ajF6NlhXdGRKK05KZnlV?=
 =?utf-8?B?Ti9pQmNkTkFsNXEyOU41bkhQRFhQUm95MmR6dUVXNVV3ZGJFL204azUrUkY3?=
 =?utf-8?B?YVlKK1N3YkFwZC9Bdzhxby8yNzM0SVMxM211eEV1MDc4dUVvdXcwWDk2eGFR?=
 =?utf-8?B?M25uVVVmeEtsVEJjNldTaGJyLy9VVTJ2QXhpK2NlUlNGRjFHTDZHQTBlOTBt?=
 =?utf-8?B?RWtPS2h3UjNqWk9CTVF0RjdYTjI3VlFaaHdHSXRJdzBaQUlDSUYzeldacE5v?=
 =?utf-8?B?cHhhM1dZYmdkSHR3cURweFFDSUxZSHdyb1ZCM1FDWHhsSkliYklBOXJRWEZY?=
 =?utf-8?B?R3lWbWtKUkkwTllPWUVTNWU0UjFsOG1NNTgzazNZVEV1YTlNeHh4K00vcTc1?=
 =?utf-8?B?RFczY05ETGFoSFEzUjM1NzI3ZXpEbk8weXlKZnZKS3NRUlFPZjFQVklyM0hI?=
 =?utf-8?B?S280d3RYQUt6eklHa0Z2cytrODFkYzlFcTYxcmE1YStGSTk2dDlHeUpmK3Mv?=
 =?utf-8?B?Uk1mMnN2ajhRdWo4aVBTQUw5cVBtZkFGYVpVa1RHbUxVSE9Tdnl3dlNGd2FT?=
 =?utf-8?B?QnFFeEtnY0NsdDgrcGZCUytoUnRvckREY3ZPQUVwYytEZkUzWEc0ME82cnNh?=
 =?utf-8?B?MHNCWnd1QmV1QndJcy80L3RPdGlRbm03YlhBTEptZWhSSjlyM0hmZ3Qrajlq?=
 =?utf-8?B?QUlzUU5IT256T2VIc0ozU3Y1amFHNlZqaDd3VlhvODNQTFVCZ1NhOXpvZm1P?=
 =?utf-8?B?YXM5L1BrRHo5QktzUk1NUmNyWUM1N1Rib3FpK2I3dGJVYjgxeEltVFlBYTlm?=
 =?utf-8?B?VDNKWHFySHVESi9GeVpvQXY3eDYyNE5ZZEtsSE5ya3gweEtLaUM2akwxU2RO?=
 =?utf-8?B?UThna0lLaUpnbjMyeHhTc21CMTVLRHhORklXdFpKRU9rL3hWbXdBY2kzczJ3?=
 =?utf-8?B?Z1pSRXlGL2Fyd3hvMDdZMlJmK0p2QUxpbnZNRHBGUmRXTjJFL09ITnBoK3VW?=
 =?utf-8?B?TDU5eEQ4Snc3NmVNSGl1aUNySnVxSmgxa2M4N1l6OWtFSVB0dmY2alhoZGt0?=
 =?utf-8?B?RU5wRnh5SXNkZGxlYUx2WEw2VFYyV3BSaE1BVWFyNU8xU2VQSlI4aVUvbDJj?=
 =?utf-8?B?b1B5dnlmSDJhamdwcTF2SDF1ampSeUJHdk1ZWENWU0srOU52M3R2SkZveHFT?=
 =?utf-8?B?QWlWUTl4WnNTRTZDL1dtR3VMUnhRczA0R0kvNkNITVRoNlJZdjNBejNGVWlq?=
 =?utf-8?B?SkthMVhubFdSeHM2Q2gwQmowR1hlQ1B3dkViTUQvbU11SU5FcmMrWHIwOUE0?=
 =?utf-8?B?b0Y4bUZEODVxNFdiSXJ5VkozRDcxbjNxN0RmbkpjWGFoVWpYRDdiNUc3Tm84?=
 =?utf-8?B?VjI3bXMwcE83UlNZNE9PczR4eXJDWXBUamRYZ0tGVzlYamZJYU01SWlQdzUz?=
 =?utf-8?B?V3EwQ082bGo5TE8rOElRMmxQTEJNY3VZYWNvcnNZclcxa1BZcFBJdDVwMUFu?=
 =?utf-8?B?Q0ZrTzZMdzB1TG95dzh4SnpwZDg0dmdEMlNadXYxRlJFVy81M3VTY3hrNUdO?=
 =?utf-8?B?OWorZmJWbTFna2l4MStzSlAzKyswQ28veWRWdEZDeGxZVkRPV2xVV2oydmlI?=
 =?utf-8?B?VVJsTU11S3RtZUVVV0ZSMW1VMVI5aTZhZld5NEJSa2ZUeWdGTDBtbTdodFRO?=
 =?utf-8?B?bTh2N1JPSDNpKzhKdXlFYThreENPUml0TlBKbjJXLzRqaGluMkpDSzlsbWpm?=
 =?utf-8?B?MUR3cUo5UmdVSEdPU3N4czh3S2VyOVlxV3FNRjZIUUZiZDQyYzZmbDVodVV0?=
 =?utf-8?B?Q0laUnBZSFJPTFhiSU1DN0VFSHJ5NVZ3RDc2ekJWbk1JWlhzSHV6anBVdTl6?=
 =?utf-8?B?SUhJbG1qeS9yN0hab0ZlQnM2WjdGZUs1dFdCdWl4cVo0YlRmQXBsR0pjWS9Z?=
 =?utf-8?B?ZzBUdWRBbUVlbElQQTNFVmMyZy9QY291YnJRcTd2UW1RZ3hXdms4YkJMSVNW?=
 =?utf-8?B?V1E9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78feb304-cf7a-4bab-864d-08de0fb1e4f1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 08:23:06.0823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1VqK8iwtluFAO+kgQqQ7yhy1CSaGn0SBsXYXZb/sd5eng7A0hqzgZnvAGz41SA48zWqNW5G68uVNG1AY8IVIx5+gBn3NwqR9ep/k5itiSIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8475
X-Proofpoint-ORIG-GUID: BnEMpl1IEzlq9DUE0WzsyKAmL6uiCiin
X-Authority-Analysis: v=2.4 cv=K+4v3iWI c=1 sm=1 tr=0 ts=68f5f16d cx=c_pps
 a=vOU3FABhAvw2ezUnG/KEAA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8 a=P6VRIj8pWYM_-7s9apIA:9 a=QEXdDO2ut3YA:10
 a=tOP5DRdRxDct86-DbFAA:9 a=0IqfbRiK25X5Bf5r:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDA2NyBTYWx0ZWRfXwyEkcCdNJn/t
 y+8X3NNa1PU4FHm2bFMn3i+Dt5JGvYQqGuy9HPkYWlyNLDh/avBnriHIbJ1Ofua8vyUB/uK6ELx
 eMQ8c9/f60Hr96Uwr+9VDEXUp7IxEqjvw4zCs+lEaPfgA4tA3CHMWsn4ZxUNf+RpobYjDgdDrhS
 rRxAtg7GQIlJeiM0rm89T4FBsruaKUCb12Prrj51K+SCeNN0O3uutcHyIdwQeJL8gBdUdtqWnoZ
 m8/bR5rB0M0UVqocJ5klkqcGXtLpSdBNQ1j/oYX7XI9p6kBNDdT2hsps9V9C3MbCKZM3wqQX2GU
 r8Znr2ZoHZbadJTkZAFQBy6inxhTwVZt4gzyHquHBGfOcsMHLZm8Qeq+qAEeHNcSetzinE2aHey
 YGrz3ObCiG9TiuA6EcibdtPWZ4Pw9Q==
X-Proofpoint-GUID: BnEMpl1IEzlq9DUE0WzsyKAmL6uiCiin
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510200067
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 08:23:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2357

--------------sqwCScrtTNwL74nWs2c9wEhh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Please ignore this patch, just find that there is already a patch for 
this on master-next

//Changqing

On 10/16/25 16:20, Changqing Li via lists.yoctoproject.org wrote:
> From: Changqing Li<changqing.li@windriver.com>
>
> Sources already moved under UNPACKDIR, fix failure:
> ERROR: nativesdk-mingw-w64-headers-12.0.0-r0 do_populate_lic: QA Issue:
> nativesdk-mingw-w64-headers: LIC_FILES_CHKSUM points to an invalid file:
> /build/tmp/work/x86_64-nativesdk-mingw32-w64-mingw32/nativesdk-mingw-w64-headers/12.0.0/mingw-w64-v12.0.0/COPYING
> [license-checksum]
>
> Signed-off-by: Changqing Li<changqing.li@windriver.com>
> ---
>   recipes-devtools/mingw-w64/mingw-w64.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/recipes-devtools/mingw-w64/mingw-w64.inc b/recipes-devtools/mingw-w64/mingw-w64.inc
> index 97315f4..a24e96c 100644
> --- a/recipes-devtools/mingw-w64/mingw-w64.inc
> +++ b/recipes-devtools/mingw-w64/mingw-w64.inc
> @@ -1,5 +1,5 @@
>   LICENSE = "ZPL-2.1"
> -LIC_FILES_CHKSUM ="file://${WORKDIR}/mingw-w64-v${PV}/COPYING;md5=bb936f0e04d8f1e19ad545100cee9654"
> +LIC_FILES_CHKSUM ="file://${UNPACKDIR}/mingw-w64-v${PV}/COPYING;md5=bb936f0e04d8f1e19ad545100cee9654"
>   
>   COMPATIBLE_HOST = ".*-mingw.*"
>   
--------------sqwCScrtTNwL74nWs2c9wEhh
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#cceed0">
    <p>Please ignore this patch, just find that there is already a patch
      for this on master-next</p>
    <p>//Changqing<br>
    </p>
    <div class="moz-cite-prefix">On 10/16/25 16:20, Changqing Li via
      lists.yoctoproject.org wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:186EEAF1C5A5442C.8420@lists.yoctoproject.org">
      <pre wrap="" class="moz-quote-pre">From: Changqing Li <a class="moz-txt-link-rfc2396E" href="mailto:changqing.li@windriver.com">&lt;changqing.li@windriver.com&gt;</a>

Sources already moved under UNPACKDIR, fix failure:
ERROR: nativesdk-mingw-w64-headers-12.0.0-r0 do_populate_lic: QA Issue:
nativesdk-mingw-w64-headers: LIC_FILES_CHKSUM points to an invalid file:
/build/tmp/work/x86_64-nativesdk-mingw32-w64-mingw32/nativesdk-mingw-w64-headers/12.0.0/mingw-w64-v12.0.0/COPYING
[license-checksum]

Signed-off-by: Changqing Li <a class="moz-txt-link-rfc2396E" href="mailto:changqing.li@windriver.com">&lt;changqing.li@windriver.com&gt;</a>
---
 recipes-devtools/mingw-w64/mingw-w64.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-devtools/mingw-w64/mingw-w64.inc b/recipes-devtools/mingw-w64/mingw-w64.inc
index 97315f4..a24e96c 100644
--- a/recipes-devtools/mingw-w64/mingw-w64.inc
+++ b/recipes-devtools/mingw-w64/mingw-w64.inc
@@ -1,5 +1,5 @@
 LICENSE = &quot;ZPL-2.1&quot;
-LIC_FILES_CHKSUM = <a class="moz-txt-link-rfc2396E" href="file://${WORKDIR}/mingw-w64-v${PV}/COPYING;md5=bb936f0e04d8f1e19ad545100cee9654">&quot;file://${WORKDIR}/mingw-w64-v${PV}/COPYING;md5=bb936f0e04d8f1e19ad545100cee9654&quot;</a>
+LIC_FILES_CHKSUM = <a class="moz-txt-link-rfc2396E" href="file://${UNPACKDIR}/mingw-w64-v${PV}/COPYING;md5=bb936f0e04d8f1e19ad545100cee9654">&quot;file://${UNPACKDIR}/mingw-w64-v${PV}/COPYING;md5=bb936f0e04d8f1e19ad545100cee9654&quot;</a>
 
 COMPATIBLE_HOST = &quot;.*-mingw.*&quot;
 
</pre>
    </blockquote>
  </body>
</html>

--------------sqwCScrtTNwL74nWs2c9wEhh--

