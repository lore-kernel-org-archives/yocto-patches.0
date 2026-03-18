Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE2310854CE
	for <webhook@archiver.kernel.org>; Wed, 18 Mar 2026 02:18:14 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5472.1773800286925698855
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Mar 2026 19:18:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=pspxWhjh;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=7537b50398=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I1246M3294866;
	Tue, 17 Mar 2026 19:17:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=cjwlD3LmA47Cs+yoCOfsPrDgazdjX7SDY+gM2ogKAfI=; b=
	pspxWhjhOL12sydhD2l9ezh/mlTghaQVMI1SM2feefJ73lgyk29DNvoJOaAmt1nx
	91+lElpQ4OQOVG8Q/iFwC4oHQMqaSnHz8f8aq34atrg0DH/WHUnQLAp58ZXuKSof
	i0/gC7U5Lxl/UMXw2ANgAbxyfnOiQSwfUNGW20dEF2qvIYfD54Uome+Hto8uJctL
	SOkz1FP4yYueNcAe86j3xyEzYxqSczgcfBsoPus5T3z4LYWMvfBXhasvJDshkvuO
	oRUNbzXCLesT4GYXc9G8QKm0O5/v/d6lDKo5jY59+v0QSpQt2QW15ljQRPU0ftNh
	SAkaWfBm7eL64Hy+52twQw==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012006.outbound.protection.outlook.com [52.101.48.6])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cw2y14426-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 19:17:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4Jti5Im6JO0si68HE51CdyVW1QVBPpXKP8T+gATAtEspysqCax+Ty9Zc8Ivl+eUS+Prt1XnQNq1LY3SNqyq5dVwW9McTvLdSduCgIbdsjt3uPuTJbo+Q5gmT10QyhPd/P9MnTBdOLHchfH+giiY/QYSiTRXho+IInIA9vS7AWQh0cRVcBqyjeNBxorX5XEugF3d47hGIViO5B9ehIHY5T15L5zFxPeK6xyx7UbpR5tPXalglaYhzLJF2OtVlEmdHTgcMRyKhQrXZKlNa3sRdi0+P9rwKvZcJifL5pf4Dka0hb+fKF7sIvbuXSp6rYqLkaJu1PdD6L6gHiH3yrChDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjwlD3LmA47Cs+yoCOfsPrDgazdjX7SDY+gM2ogKAfI=;
 b=eUR37rLzGu3t0422uFaEQ0ZZNEZ9TXFDHlBixnRmvZarHgy5qBwNtkFKB7nyAtCQmnoS5Js/Ewj7LwaumnSD6GhunK6HZp5LqUDlxLG10x9AbfwsOGowGIubBGw/NCtGpvjP0gdemEx3a6KM050+sRBqMHggSP2zlImd2nodhFxYt9wAIdaFEezxLJG9tKxeJRbosiYRsTEo4WCNNn8BfYiadfqO9N8lUk8PeHUCCQ3xnCOMc/JtqXL6uqRr11HsG7eOsy5YKq8+rByIHRX87OMKRmZnhp/Do5lOq+Z5p2/0eM9W/R3YrV3tdiLUj6ppga6Blr9CHNcJ24mPH5N5qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20)
 by MN2PR11MB4709.namprd11.prod.outlook.com (2603:10b6:208:267::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 02:17:55 +0000
Received: from PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::c84c:d2c3:1102:cf45]) by PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::c84c:d2c3:1102:cf45%3]) with mapi id 15.20.9723.014; Wed, 18 Mar 2026
 02:17:54 +0000
Message-ID: <0f16f102-75aa-4839-b69f-ded2f443f8ad@windriver.com>
Date: Wed, 18 Mar 2026 10:17:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Openembedded-architecture] Running Large Language Models Locally
 -- Contribute meta-ollama to Yocto
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        Michael Halstead <mhalstead@linuxfoundation.org>,
        yocto-patches@lists.yoctoproject.org, Khem Raj <raj.khem@gmail.com>,
        Alexander Kanavin <alex.kanavin@gmail.com>,
        openembedded-architecture <openembedded-architecture@lists.openembedded.org>
Cc: "Yang, Zhangle (Eric)" <Zhangle.Yang@windriver.com>,
        Robert Yang <liezhi.yang@windriver.com>,
        Randy MacLeod <Randy.MacLeod@windriver.com>,
        Mark Asselstine <mark.asselstine@windriver.com>,
        "Holmberg, Tomas" <Tomas.Holmberg@windriver.com>,
        "Chen, Qi" <Qi.Chen@windriver.com>
References: <34111501-e543-417a-b933-e3830a3cdf64@windriver.com>
 <e5929265c4fa4b29e6af838976f2a145f5ed19bc.camel@linuxfoundation.org>
Content-Language: en-US
From: Hongxu Jia <hongxu.jia@windriver.com>
In-Reply-To: <e5929265c4fa4b29e6af838976f2a145f5ed19bc.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SE2P216CA0025.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::19) To PH7PR11MB7608.namprd11.prod.outlook.com
 (2603:10b6:510:269::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7608:EE_|MN2PR11MB4709:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b8c2bb6-cc53-47c3-876a-08de84949066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	of8y9S8d1NxmOhP9j3p/Is8byKnBCqAlCVuX28J1qMsxiW7L+GKT1PS7iniin+3GMTqdgJychpxnbpL9oxX9eTZk7ldmhZVSSM3TwmHrZ2gBUZqsTcMAbE1CDXooK3O4poOfevVbAnropM8wtzJ2G+cVIHF0EQmsaW5XAPn/02KQ7pEZL//bX0Je+cvKZNb4DiXhlaXQ4RSY4NgHWZCl7a7aV1JkgIZSeBhTCsOxsNLQLR1wgZ21Jk90U5vzXZAvks7yCeJYeJzPZiwPDnhWmpHURc4leZ3G3VuJLwpqY24/Tuo52ncVrq9gn/4rONj85qpDLDX4S8kJPCxhfhV/taLQ5DgWzlxv09iJztnLEtXLLG6AO6jorWnqxeYZHns0RkBbo7zFu5OxtGRJQhgzezYsyzo9ScSpO4u4T17bJiRUfZSOfil0eDp48g9zzPcKahse19ChqPvClzri/lHw7kebVQ4/TVmS6stAiRf6lrp9RNuF0CXYxJ5xLTU6T6kQk7EroXoMjP7ih3KOSn666OqR0jU7i1XaziGEz79aqgHQpvylEJaGJSTIaDwn8Xeyp9IM4YU2QqOxl5N2YlczrB1jbf2XmWGmgNGl4KiZa59h0f5Sq6+4+GHGLREc/bHyffK+nKGQ9pyClF5aC9WUKnlCl4Dez14DNg92Ajj8LfkCGZc0b3YKoCm0Q0DnBMtXkRyRhZ3ghyTUodpFQtv+koA7xS9i/YwuFr5+NZQ5YS4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7608.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q1cyK0NEc0NDWUlKdHROM084UzJQaWF1cXpTZ2w3UEh1THk0NzFqU1RzOURh?=
 =?utf-8?B?V3BRNW5XdEwxMU9wZXJQQ3dLaU9ja2cyK29pbmxJVGM3aFFtOFB5OTJnVEs0?=
 =?utf-8?B?djdNdDBXOUlFWmUwTjJoNGdlZkdmUllYSE5MMCt0ZXBMUlh5WWlyampEL3VU?=
 =?utf-8?B?WWtWaDN2SW1kTkl1cVJmaDNDK0xzWmYzZlkvMVB3dk5tTFE0UHdDcVdHMHBU?=
 =?utf-8?B?K1hDSFRWcUJLSGFRdkRLMGk5SS95cnRYbi9MVUE3ZVhHV0l5QW95RitDSWtV?=
 =?utf-8?B?VW1NcThsU25lMkxOMFY3U3IrdEk0aHl3NWxtSlVHWlU3WEN5K3JncHNNWVMr?=
 =?utf-8?B?MExPWG9nVTJGTERNbFVYL1p6RlByMzNabmpQL1BRRWNwNzUxQUExSjNRRHhH?=
 =?utf-8?B?Uy94cFNaVDJsVVFReDBRSGV1RHFTVEpmbzZmU1c2SUM0clRXVjNXaDUzdmtt?=
 =?utf-8?B?UEZHZ09MWEY5dUwvVU85THkveUhTUkg4bW1ObzhNOWYrblhQT3d2YmZBSTVr?=
 =?utf-8?B?MG9ybDFzWDZ2T3hOTS8yMm9ocGFEemMvTGd5aXdrQjlVbzNpOHlZUFJOaDB1?=
 =?utf-8?B?NnZEVGExK0hCMk4ySW8yUjg2K2o5TTlmRlVQcG1LeWlnMkZJRW56UkNqRHhw?=
 =?utf-8?B?TUpRekpwUlpPdUxWd0U1b1hYc0RJSU50MDFXdTFjNEszbHRQdVpvbUlYNEVG?=
 =?utf-8?B?TytPSFMzeDhCWWE1cFIzenJzVnZ0bEo0QmpiUE9FWUpWc05qY1RwUEpJWGFU?=
 =?utf-8?B?RmVJekVjRDdxYUpkeVFTWFlwb2lySmJSNGxmQU5pSE4rOExYcGNxbmc5TzVI?=
 =?utf-8?B?endkSHROdU9ZK2NUMElhbm5QWWRhNDBYSDh2bFNTUzNzWlRoSWtocWgvdHU1?=
 =?utf-8?B?QkswZnZsMFRiQ1c2M0VDYVltMHBFM3hZT1dkZzlkamtSZlp1RHZ4dFE4dDc2?=
 =?utf-8?B?blAwZk5ZSFN2U0tXd3dpOHcvZ0hseHF5VFd5cFlma0lzWCtmWFgvaWtWMGVH?=
 =?utf-8?B?dGxXOE5GNUxZb3VPdlB1MDhTSzdaWlZyODlzdHRkK2VtQ1JqcGJWT3BhRkND?=
 =?utf-8?B?dXhJN1VVb2VWM0hnejJ1Y20xeVpDRzAzR0tsNUswZnlZcE5rR045MmxnMUti?=
 =?utf-8?B?T3Rxb0E5UFpTYk13RmVGbnJlV29VbEJEZG0zRnZyN3BNTEJUVDRKaUczMVNp?=
 =?utf-8?B?eVlhMkd1ay8yblBjejdpZi80QyttUzl3ZkhFT0FrbUhaVWpEc2NDcExDeHBW?=
 =?utf-8?B?L0MvaFNKeWhWVkpMVld3bnV6WmVPWjdRSXp5N1d0Mk12eU5Tb2VlVEJRdkZP?=
 =?utf-8?B?T0pOV2d2Mk5DNmdRZ0N0SXRid3FWejJyWnJ3NlY3cWdhV2w0UHFHZkM0S3Uw?=
 =?utf-8?B?ditqUFl4a0xpc1ZNV2lCNExDYVRTTk1KRGxabzI5SFoxSmQwYytlWjIxejFC?=
 =?utf-8?B?ZVVUOHN4aU9tRXNpRWV0a1BSN1Z2ZDJPWCt4KzIzM1RlR1RHQkRST2QzRkpO?=
 =?utf-8?B?d2VJT0lqMEVyNnVpckMwRkVOeWZmY0k4clJOcXVaRkZiS2RzczUrL3Y5anlo?=
 =?utf-8?B?UE5MSTNJU25UYlRic3JIZFd4aFVydDZWZ1A3RE0yT1dVcmJHbnJTakJtNXVB?=
 =?utf-8?B?YWhucG9XY05VQ2tpTmpWTTRuaGFvNHFpYk4vMmE2ZU1oUmtYdlg2SUNpMllr?=
 =?utf-8?B?cHhWS0xqckNqZWp2Z2RmdWNtdTdWVmNDa3NSd2F4L2cwZzFHNExGZG05bUJs?=
 =?utf-8?B?bDVKK3ZtZ3kxcUdyTmVJSS9OY0RBQWtvSWhtOWJZUHBoYXgwZDBUUXVJZCtn?=
 =?utf-8?B?eFVtaGxKK2hCMzZUWEpRMDR2N0o1ZzVsazlncjViL0xkUStLYVQxVjRCZndQ?=
 =?utf-8?B?eGNDTkU2MHgyakpCWVQ3dFltUVVVU1JDUGM2cGgzVDFUZHAvN1ZROUpaVXYv?=
 =?utf-8?B?S0RzY1VoMzd3N1l0R0lBekpYYlRWKzREdUlMNHhkRG1kMnRmcXJGSk92ZVdt?=
 =?utf-8?B?MUpQeVF1N0hoYUZRRVJiVnVrZ0xxbktrWjlRYTBnYS8xSUJwT0tGc3NNYXpj?=
 =?utf-8?B?L1lpa3g4ZDZxTDlxdzZxMUZvMWVtZHd1SEF4U2tOQWxDaDdmL3E1RFFvYVV4?=
 =?utf-8?B?MFp1Q3dGZWZoVEVkTHhydlNyaktsb0xyUEJZS1RYYTdDb25FaW1Db2hUN2hn?=
 =?utf-8?B?anUvc3ZJNUt1KzNpUTNIUWRqdWtYeWJmWDNDOURhKzcxd1ExRTU2RDhmR3d4?=
 =?utf-8?B?SDZiai9tdXJpVGtjYXZSb1FPYWZKeloxN09mY1lhYjhKN0tSdmpia3prd3A2?=
 =?utf-8?B?Mms4cXhPaDVnVlNxVGlMSTIwaFVqaEhGQzhGcGZKa1FyYmxHekxFUT09?=
X-Exchange-RoutingPolicyChecked: 
	Kq2SB/pRfdG8tUxxYhXCJIabP8sa99WnS+iahlMyTonPBW4w5AjUTgyvisYWPHsv8XU9mi0gXAcp5aGwaytlxEOssQoYPcslntFlzDoE+te+yZIYIOLSSLCzhQrkSMdv+kGwsG9OVQi6DzgKnkVRnkkvWOpUF/fkBFE9Mc+30hDlCJqm5bq8PXr4bcp8q3f6YAEgma5R2oZIZrngjrF/TsSu5/a+oLEbKl/t1gHegw6ONkR/oGx0lHvCAMmkuA42HlgUPlZJ+7UiI09VDPJD4TcKS00me5EXhsE+HGkRrteomFaWx22rvKYFKV/WEYcAuPYJt3lB8BSNx3v5x55P+A==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8c2bb6-cc53-47c3-876a-08de84949066
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7608.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 02:17:54.9116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3w0HfMUkVgGOLIaznAIDfz/nu9i2H3qir0WuD23DxzacaHXaZxENA2AwNMrp5/pgTyNrAR8ibydBnF6fDn5ZKTiEVIxbp0a+qPffBu2yW4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4709
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CekFJbrl c=1 sm=1 tr=0 ts=69ba0b56 cx=c_pps
 a=UC7P8Ip5M4jKPNRdwLma8g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22
 a=Q4-j1AaZAAAA:8 a=iGHA9ds3AAAA:8 a=Unune0qEhJ1q7BVGnvgA:9 a=QEXdDO2ut3YA:10
 a=9H3Qd4_ONW2Ztcrla5EB:22 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDAxOCBTYWx0ZWRfX0o+4pUCE7z0Z
 YJZx0ScNLHBH+vnp8rjxGfsu67Qqed1+5SfpipEJrEEQzSLCKQMzeaZIWs17womO5VvR1QLWRRC
 VBY2FdteoJ2VDw8Ei+p/qnA6SAX6DRvVzqziKWouJM2hYGOKjOcsuv+eDPXHN5rAbxeOzU7s5An
 GGyICrRg5mB4zSIZMWQyufJjAStL5zMEjJe7y+Lqsgi2iR2DkV/KDPDd5eizKLI0USdsTi/MFQq
 bciGdu1w9ITjg0DVNqYt5ANQb/3lIXAv+4D/Yfe9uaT/CMML5J82IN2ohPQwPZIrj0Ac+sox8X6
 U+DAAHYNI2cVwttL+6+P0jOqG9jzqsuJL9n9FikpBJKUSkhKJ/fZY1u7k986B80aEReaLCNxp9I
 F5rWXa3BwG9yTFNznRU0jx5gUkSlxN8DWVOCAvWLjv85UcZ1soDK2Cku+6BBAtYNph3ehokWXNx
 cCO9F1MYttiLgxz9DUQ==
X-Proofpoint-GUID: RLJE1xV4ah1B0bd2CF-e9Ot-ZwLxuuv6
X-Proofpoint-ORIG-GUID: u0kbxyuZ0EcBVg9dSkYYWKjbhSwWo-gz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 adultscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180018
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Mar 2026 02:18:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3502

On 3/17/26 01:58, Richard Purdie wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Fri, 2026-01-30 at 13:20 +0800, hongxu via lists.openembedded.org wrote:
>> ChatGPT[1] has been popular for several years, perhaps you also know
>> Deepseek[2] which is an open-source language model and run locally.
>>
>> The local runner to run Deepseek is Ollama[3]. It lets you download
>> and run large language models (LLMs) on your own machine, without
>> relying on cloud-hosted services.
>>
>> That is good for Yocto, so I integrate ollama to Yocto-based Linux
>> system, build from source, offline install and deploy.
>>
>> For the convenience of review, show it on my github [4] temporary,
>> - The BUILD.md [5] provides the steps to build and run on CPU by
>> default, - The BUILD-cuda-x86-64.md [6] provides the steps to build
>> and run on NVIDIA GPU    with CUDA for x86-64
> I appreciate there was a lot of discussion on this, I'm not going to
> try and respond to all the points individually.
>
> The TSC discussed this a few times and is not convinced that either
> this or the proposed meta-ai is the right way to proceed with this at
> this time.
>
> We are keen not to repeat the past and create a "catch all" layer like
> meta-openembedded where it is unclear what is needed/used/tested and in
> which combinations. Equally, a focused layer that is target to one
> specific use is also not appealing. We're aware that the rate of change
> in this space is extremely high and that will further compound the
> problem.
>
> We would suggest that people work on their layers outside of
> git.yoctoproject.org and that as things get established, it should be
> clearer what the best solution is and we'd be in a better position to
> make decisions once there is more consensus and we can help focus
> development and adoption.
>
> We can see the potential for a common "meta-ai-support" type layer
> where the common dependencies used by the integrations could be shared,
> but this is not what is currently being proposed.

Understood, thanks for replying

//Hongxu

> Cheers,
>
> Richard (channelling the YP TSC's discussion)
>
>


