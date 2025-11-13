Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A00CD5BC8
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 11:17:07 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21550.1763032622142519223
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 03:17:02 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=TH8tK8Cp;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=3412b09296=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD8l3gF895236;
	Thu, 13 Nov 2025 11:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=88pplvQQ7ZvCy7LXo0SaJBT3jkKiHqytLna9S8WEjvc=; b=TH8tK8Cp2YjP
	KB9mGOYbNfPf4oqOnK6MQQ7j9KG106Ov4hd2vTrJjMQvs3HT618/MeT0pmlwZcoM
	ZKXV4NPUKU6xxMTKTGSA94zsCW0rd5TuEjZlkuC6NLthQ2tpsBuhBl3UZ1oT8pnG
	b7vNKWNAIepUpVHmjjScv1sqL/FzAswMklUqCuCZnFQVhpnls8pAJBTxa59s5ew9
	YjdkVwljXYqAqdBDY7HKTmzwrrG+6bU0wQlizMy1m1md26AFejuyAZJ5LmVFXQ+2
	htKMt7Kx5VAEuc2e2tJn2lMpALVuZL597ks/fzDzIm7TxNEACJiRA2upGjht3evv
	C7SW9hDeuQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010033.outbound.protection.outlook.com [52.101.193.33])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4acwphsptn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 11:16:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCX9RFTy/nOQEHKBpSHVS9HdEHr3aJul88IcafdpFDXcHCDThhJ3IBZOngnl6cqg3XeSQ6E+piCMeOZIFgAM0o8IiZ6gjJTsE6VZJDDWBapZg54tsBUajnxJml/NPjPcFj8/4Zl0xdUSKXKYGLoLJooKMIcW8WqA2Chxv/hnzN5Tccs+YJyEcxODx/j7Qfl7UAk8jnZOsOZO2sbvf3IZCpKQaUThwW6FpL4LURo979eI6bg9Vc+2q0HMQNUqOUSVXDhg6gLiXOUvcO+QA3nr7BSW1ZYyXlEFhojjptGE15C3MfhA7ykCp3sBfEpgfWlxjC1Gb/fHf5wrmei3kfjkcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88pplvQQ7ZvCy7LXo0SaJBT3jkKiHqytLna9S8WEjvc=;
 b=LHXzBOI1U0mPC5p0aPmPaXEGrkhwkJG5YLVeFgRCWoDb5JixXynqFrvwhO8p/VcpxHey2dsa80bmMowmywCoFdYWN23wHbGt5DWaMPj07dWAHVupVLZi/Zx3gRmlVSsA3pXkmGhCH2x2kxYACDW+UguEftNOgiXKUAgX7dyKMYKxpKIzo62wl0sW6RCpwHeEfi3xCXqMZsxIL0zd2P7xUfx1030MInKVXySFFVwh3daS0R32D71lbTeEoZXaIk2/dOwFly7flFzo78D9MXLsDEsvsVhK2M23pYam2GOvIjwTYT69YUuIEaNbwFh30EkIVJ/ZSnFjxylk6qLEEdo+Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20)
 by SA2PR11MB4986.namprd11.prod.outlook.com (2603:10b6:806:114::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 11:16:24 +0000
Received: from PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::ef64:bc9f:eb8c:e6e]) by PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::ef64:bc9f:eb8c:e6e%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 11:16:24 +0000
Message-ID: <240e2407-36a5-4266-91cf-5c063d407121@windriver.com>
Date: Thu, 13 Nov 2025 19:16:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [pseudo][PATCH 1/2] pseudo_ipc.h: make 8 byte alignment for
 structure pseudo_msg_t
To: Mark Hatle <mark.hatle@amd.com>, yocto-patches@lists.yoctoproject.org,
        richard.purdie@linuxfoundation.org
References: <20251111135951.2121065-1-hongxu.jia@windriver.com>
 <ff0a842e-cc9e-443f-8f8c-c7206a719dd1@amd.com>
Content-Language: en-US
From: Hongxu Jia <hongxu.jia@windriver.com>
In-Reply-To: <ff0a842e-cc9e-443f-8f8c-c7206a719dd1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To PH7PR11MB7608.namprd11.prod.outlook.com
 (2603:10b6:510:269::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7608:EE_|SA2PR11MB4986:EE_
X-MS-Office365-Filtering-Correlation-Id: 3434a5e3-643d-4da0-df14-08de22a614df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UTdvbUVleXdoV2dvTGUyT09ERjRoN0hMcWZTOTIzSjdPTFlRYUpqaXV5S2ZH?=
 =?utf-8?B?ZlZxODc1ZEVtMEQ5MlZWemlxOUt2K3JVT2hjSHVYa1AzUkt6YWF5dGhWa08v?=
 =?utf-8?B?ZUx6YjdYRGNGdytWTHpmS3NGbWF1VEg2TUV1Q0txZDRyOUFTMVhWYmNoa2Fq?=
 =?utf-8?B?K2NsOThYSjVEdUIvdmdndTRhaUVjMGoreVlMUTU1aklBdEFxK1dUcU5LZUJy?=
 =?utf-8?B?b1BPMWdzQUJMVWcxcERBR3hpdWpLbTJBVnV0Y292NUpQdTNZYzVpVE16ZVNI?=
 =?utf-8?B?VVA0RjFCTnRCYnZzbksrd24vSnJVY2k0b1EzbzhWQjhoTE4rTTRkcnBHUXVI?=
 =?utf-8?B?NW41Nmh2TXcvN3NJa1NDaEllSEF1YjBOL0lyckR4TUsrQXdBTGo4UjkwUmdw?=
 =?utf-8?B?blFKbVR4TU0yVEYyQWJrQnRvMm1OWVNXTVhmalM1azhjQUcvWnRlR1hzbTI3?=
 =?utf-8?B?MHpRbSt0UWwwVHZhRTVxUVRYYU5hVldjUmZyWWxmOW9IRkhmVm5uM29HRVE4?=
 =?utf-8?B?QStrc0tGd1pYc3BsUjkwQXFHd21JbG9Sb1hwSCsycmJ0WHNEU0hJSnBtM3dF?=
 =?utf-8?B?OCsrSWNPa1ByNTBKOU1DeVV3aHhjVzVMTDhlQ2JOZ1dnbEI5eWFMbFlpZkdi?=
 =?utf-8?B?NXp6d3ZBT3pYNXFjZHNNNEVFdkpCZEF4NnlYOG4wNVpFZTR2aU5Qb2Fjekpq?=
 =?utf-8?B?VTdMcS9INXB6MjZXQk00YnRUOGxlMHU3RERSNUNlM1g1N2s1amxhRzYzUkxj?=
 =?utf-8?B?ajhuOG1BaUtwQ050Z212TmJZdW13eC96cjJZZGhWR09uR2puY0ViRVZ6a3dW?=
 =?utf-8?B?TlFlMXRINjFKd0V3UFU3RGZCVFZ6YlduNjF3c3Y0YW9TYVZESHdTTVZhQTk1?=
 =?utf-8?B?MHVXN1lQWWswSEJoNUxIMG5oaU44WjVobThjbWtxMnQ0dk1nY1ZwdU5wKzJO?=
 =?utf-8?B?dXJJNTg3Q2t1UFJSUVpvdVhCWlNvRjh0a295am5NZGRBYzUwZ2JvR01xZFdG?=
 =?utf-8?B?aVBJalEvdUM2akFZc21RWkZGaklHdUI4dW1DdERpUXR1dGZBNllSbitUM09C?=
 =?utf-8?B?RVNyTGNpOUpkbVdrZVJXanVpUTFLVjNPa3lRVE1vRzNPT3lQM01tbUh0Tkgy?=
 =?utf-8?B?SHZ3S0NpVnBSLzFacXN5M2lrcHlOOHhhVmMvL0tZODZKSmRVNDgrMVJsdTVy?=
 =?utf-8?B?T2UwZFgzczRuQ2swM3dDMUNGeVdmYmgzbU0rWDVQQ1hqZG4rUU9BR3NPOWdE?=
 =?utf-8?B?SnFjQWhHZ0FZTWdVcHdiV2RLamRBeDg1dlpWRk1OY0VydzFpUmxRdkVYZk5J?=
 =?utf-8?B?d3NoWUJKOEN6ejEzck1zOGpJRFNCQ2g4dUNPMzFIMlF6MEx1bGJIZGpmWHAy?=
 =?utf-8?B?Q0ROdGxsc0pJRjZjR1ZqVWhlYjdzYStSaDN2aDNZWWRjNUpoYWpnaDR1azBo?=
 =?utf-8?B?eFArQStERkFOL3pGVlhRcG45YkJEVXpxdTF4UVF3MjErR0oxbUxBRG9JRXZG?=
 =?utf-8?B?bERCTzNtaXRIb0FjVGRmWDhDczRyNExZMkl0V1RyNzFuZi91YlNpV29PZzl6?=
 =?utf-8?B?cU1ldk1lZE0zVVQ3Y2pqWDg4WG1wVUV1Rm1tZUJXV05BZWdHZjRCODhKNm9H?=
 =?utf-8?B?U0JhRTQrMGFpLzlYOVA5S29JSjBPamd2emlVeE5ISHZ1MUFSbGpzOUVlc0tN?=
 =?utf-8?B?S0RtYTFiY3JBWDFoRGs1TlhtMzRzYm1HRklFY2xOTm9pZlk2bmFaWDRBazlx?=
 =?utf-8?B?Qy83bFlaZmxGbUw2dnk1S2JPSnpzOVlPa0gyQ1ZVSTNEOEpaS2QyUnJtVWNC?=
 =?utf-8?B?VEFPY1YvTUFNRTlIY25BRUl6QkxuaEdMYUUwWUt5NVowaWRqa1Jndi9UUlZm?=
 =?utf-8?B?YkJMZFI0L1R3NE05NEkvdjlVZDZUNXFKdHZKalJFYWpLclNFZVJCOFIwaGdU?=
 =?utf-8?B?cEtnQ25QQmY0MXVUdkRnTjFFeThOaTM3aG9hOERiMUJJRDJSWis4OGhoR1Qy?=
 =?utf-8?B?eFJIY1BpbXB3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7608.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q2MxUVJqc0FiVVJvR3dLRDl0aVhzK3RtRGlKTkxybWVNd0ZuaEQ0VWpuVThG?=
 =?utf-8?B?QnJiNU9Qb0tUK0VVVTl2WkJ6UjRONGdUNmJPSjZ6ckQ1MVJwT0NFbFFWTk1K?=
 =?utf-8?B?Zi84UjlsaklINHpWMExhWTFQeHMvRWxJWGJ5U1hsS1R0dlg2Wm5JbUQ2Wkd2?=
 =?utf-8?B?YytWZXUwWS9UeHNCbDhwdmNMSzBxZkd4dTZtdmhKek9MSlZ2MW96dklEcUVH?=
 =?utf-8?B?aTdmaUZLMzhtVXlDanNEajdVVGZvOXRhZG1MaW1rT1BXTWIrcFdnT2hLL1ZB?=
 =?utf-8?B?RklHYWdLN2tKVjVKNVo0TU96aW1Fdm5KV2FvV3FWaFhESTZzcXF5eWVQWXFB?=
 =?utf-8?B?SFpocmxSUGF5eHkwMng3UDhNZUNlaEY5alFOcy9NOHlldVBScWFDSEpDb0lj?=
 =?utf-8?B?bXc2N0ZCZ2hrUVc2TFdudnUyMWVob3FmU1RKL01mV0xHU1YzVWpjWGQ5dEN1?=
 =?utf-8?B?N0Z4OU1Kd05YU0JoRVNaa25nRS9kejF3V2Y0d1JPUHJXRWFlZnFiS0VqaTZD?=
 =?utf-8?B?WDhQckMxRDR6amloQmF2OXdZRlh2MisrbEhGVGVUUE9LR0hUR3JLSkJCaWdy?=
 =?utf-8?B?NHpJb3EzL1ZacGtCYU91N3p6S3NwcjJWemUwWk9GUHl5Zk9iR3paYytUMVRX?=
 =?utf-8?B?Y3hMOGRnbjM2TTQ0V3B0Yjd1Sjl4cmNqZ3VHSWJLNklBWFVqdzlvZlVINUd1?=
 =?utf-8?B?VUlGQlFsWlFxV2Vjd1hOekRxc2tZUzJuSEM2V3ZwSG85RHh1VVNrcHlVTlc0?=
 =?utf-8?B?akZOWXlqblo0eHZqNGh1MER6RGRRWFZiR25QVkdvY01HSVcyblVZNHFzL01t?=
 =?utf-8?B?NDR1bnpNcHArUlNYTWxLeWp2ZnoyVng5RmlYcUZoZ0NmUy96cHJsK1g1U0Vi?=
 =?utf-8?B?MHFNWEFSK3JDZXNmV2ZBMGZkcWNBODQvVTRMNk9MWGJubWxpRWxTSFlTcm9z?=
 =?utf-8?B?N3I4MTRXckh4bUFNNUphakMzdkFNdHROWDYrb0FXa3RHQU94cExtWU5FQkky?=
 =?utf-8?B?UjVCYzVTSExUVDNWbTZCbU00cG1oYktiaVBoRkdOalNOczhsNG1PcXpZMnV2?=
 =?utf-8?B?aTJLMEVVZWozbVpYbStjdUVKdDFRbEp6a3FnbG5LM2JmZ2hkcERGb2U2R0pP?=
 =?utf-8?B?S1ZLYVNLaDVqck1EaTNBcGlwUUtxV2c5cW1Fci96aU9MamNFVENqSTh3NjdW?=
 =?utf-8?B?bDRCeG41SDBGM0ljUCtGSWFtNy9BbHEyRUZTR2U3UXprbzQ1aThRMEZVbkdw?=
 =?utf-8?B?ajBGQzZEUWFyUGp4QVY3SDBWV3hYVUhxWUR3c2Q4TDV3bFdXMDk3cmNiUVNR?=
 =?utf-8?B?akEvUVhYM211bUs3MEM3b2YvSWxQQ0lrd2xTVXBXb0N1QzA3QytSRzdyRHFL?=
 =?utf-8?B?bXlsK2J6azFxMVJpeTBibTZHbmR6UExmUTk4STMzaEp1cVowcTF2cmd6cUhB?=
 =?utf-8?B?VmRqa0t3bEdyMmhkdGJ2QmRtdkJkRjVrMTdGNmpIeXNLRmU0MmQzdWM0WXRr?=
 =?utf-8?B?NXpiVzJPZUM0N1hJR0cxMlQyeTIya3ErOXBZVEdDVUcvdXJ4SHgwR1NZZ2Zo?=
 =?utf-8?B?Y2g0Vk1xRlhnYlJtWDUvaU5ta1Q3MHgvUFlJNXJKNVhnYmZneG9DZG5CZlZ3?=
 =?utf-8?B?R29Xck1mUHNyRTNwdUZUNStVVEJSQzlGYm00N0pMdHdPTm9SS1k2bEFIRU9m?=
 =?utf-8?B?R3FNWjNOMUlZcE5VWm1HNFdadFZpSkpDTEp3emRxNkMvbG1lRVRuTmRTS3E1?=
 =?utf-8?B?KzhscDB5SXl0S2RQL0ZTdUUwZlpGZzYvV0VLaWl3UEFYUkJhbUhYZUZUbTJC?=
 =?utf-8?B?SjhzcTE5b2ZwOE5JWXgrLzk3dldCV09mWW9OZ0ptQnRYd0VzMkR4TmZUUllQ?=
 =?utf-8?B?MysxSCt2MFRTV0xjZlp2MHEyK2hDYU5HdU53cTdNSnU0SE1Xc2t2dDhta1k0?=
 =?utf-8?B?TTJnYlNBWTNISmN2Z0dZNG10cGZDaGhISWFOM3V2YnVSVVZSQWZDdVRJamk4?=
 =?utf-8?B?bElzZlM3aW96YlUrejVVR1IwVTJRaG11K3haLzRhM05NR1h4cEpGNW9QM3pw?=
 =?utf-8?B?L0phNHIzUzdFbDdmUjc0ZXBVNW5kY3VyZUlVV2FzZHFYc20wRUdadFFCRTAy?=
 =?utf-8?B?VlNOSVlDWi9YM0hQUGpyUmM3QXNkQ1lhR0JpemtoV1lIR0tLSmRVZG9TSnJh?=
 =?utf-8?B?Rnc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3434a5e3-643d-4da0-df14-08de22a614df
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7608.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 11:16:24.5176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXVGb8DS/+UGGfNJa9xoJg7qybgOp8F2U3JHggAmYRRfS8jhQSKroYjCkHDGBIn/bF2ad8FII75ROLTQ2IJkgif65mrulI05aL7bxSpdxyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4986
X-Proofpoint-GUID: J1glXim-CYrj4uyjGOldH2OCtwRjJm0r
X-Proofpoint-ORIG-GUID: J1glXim-CYrj4uyjGOldH2OCtwRjJm0r
X-Authority-Analysis: v=2.4 cv=TKtIilla c=1 sm=1 tr=0 ts=6915be29 cx=c_pps
 a=s4741YMcG+xsu4HPw1GdWw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=c-VF-FKvAAAA:8 a=t7CeM3EgAAAA:8
 a=SRwyaT_q7G7yN0HvUS0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA4MyBTYWx0ZWRfX82/SWRCqFE6d
 mys01vjAR87cAwYqCBdxrB3ef9DRFMmYeEg/QJCN4hCfB0G7FsWxOfjMZe7C4KDndHzJ8mrGL6I
 G6mI5BDtzgV1o1Wdo6fJBWV9nqFPmDi0p6ARkW4XfSt5SIhZJziO5RyiUu4dO7Jnf3ERm0hFiXA
 Buht1PPunSH5Sg0pbrQkAucCi6u3yf5Yo34AtTstI4mSKBtXBvV7HyekYmP1e3bnaA+iQpZkNPy
 Ih6zlpbZmlhBpxwaIhV7ATqE9fT2wgk0ydSO7BJ1kXah701UgR9LvCZSAEN2Kg3iT7eb6mpHKmJ
 IDH8YJQbCAkmdxmxaLV193dd//bXzwBoHYhUTFwN8xmx+3Br7ooYf0J7db4kIq7iieTCXxSHUBN
 aPFpQ7Avaptgnq4lz3m6h8cyrYhWGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_01,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511130083
Content-Transfer-Encoding: base64
X-MIME-Autoconverted: from 8bit to base64 by mx0a-0064b401.pphosted.com id 5AD8l3gF895236
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Nov 2025 11:17:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2502

T24gMTEvMTMvMjUgMDE6NDYsIE1hcmsgSGF0bGUgd3JvdGU6DQo+IENBVVRJT046IFRoaXMg
ZW1haWwgY29tZXMgZnJvbSBhIG5vbiBXaW5kIFJpdmVyIGVtYWlsIGFjY291bnQhDQo+IERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2du
aXplIHRoZSBzZW5kZXIgDQo+IGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+DQo+
IE9uIDExLzExLzI1IDc6NTkgQU0sIEhvbmd4dSBKaWEgd3JvdGU6DQo+PiB0eXBlZGVmIHN0
cnVjdCB7DQo+PiDCoMKgwqDCoCBwc2V1ZG9fbXNnX3R5cGVfdCB0eXBlOw0KPj4gwqDCoMKg
wqAgLi4uDQo+PiDCoMKgwqDCoCBjaGFyIHBhdGhbXTsNCj4+IH0gcHNldWRvX21zZ190Ow0K
Pj4NCj4+IFRoZSBbXSBpdGVtIGF0IHRoZSBlbmQgb2YgdGhlIHN0cnVjdCBpcyBhIEM5OSBm
ZWF0dXJlOg0KPj4gRmxleGlibGUgQXJyYXkgTWVtYmVycyBpbiBhIHN0cnVjdHVyZSBpbiBD
IFsxXS4gVGhlIHNpemUNCj4+IG9mIHBhdGggaW4gc3RydWN0dXJlIHNob3VsZCBiZSAwLg0K
Pj4NCj4+IE9uIDY0LWJpdCBhcmNoLCBzaXplb2YocHNldWRvX21zZ190KSA9IDgwLCBidXQg
UFNFVURPX0hFQURFUl9TSVpFID0NCj4+IG9mZnNldG9mKHBzZXVkb19tc2dfdCwgcGF0aCkg
PSA3NiwgdGhlIHJlYXNvbiBpcyA4IGJ5dGUgYWxpZ25tZW50DQo+PiBpbiA2NC1iaXQgYXJj
aC4NCj4+DQo+PiBUaGUgZGlmZmVyIGJldHdlZW4gc2l6ZW9mKHBzZXVkb19tc2dfdCkgYW5k
IFBTRVVET19IRUFERVJfU0laRQ0KPj4gbWFkZSBtZW1vcnkgb3ZlcmxhYiBpbiBtZW1jcHks
IHN1Y2ggYXMNCj4+DQo+PiDCoMKgIG1lbWNweShvbGRtc2csIG1zZywgUFNFVURPX0hFQURF
Ul9TSVpFKTsNCj4+IMKgwqAgbWVtY3B5KG5ld21zZywgb2xkLCBzaXplb2YocHNldWRvX21z
Z190KSArIG9sZC0+cGF0aGxlbik7DQo+Pg0KPj4gQWRkIDQgY2hhcnMgdG8gc3RydWN0dXJl
IGFzIHJlc2VydmVkIGZvciA4IGJ5dGUgYWxpZ25tZW50LCB0aGVuDQo+PiBQU0VVRE9fSEVB
REVSX1NJWkUgPSBzaXplb2YocHNldWRvX21zZ190KSA9IDgwLg0KPj4NCj4+IFsxXSBodHRw
czovL3d3dy5nZWVrc2ZvcmdlZWtzLm9yZy9jL2ZsZXhpYmxlLWFycmF5LW1lbWJlcnMtc3Ry
dWN0dXJlLWMvDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSG9uZ3h1IEppYSA8aG9uZ3h1Lmpp
YUB3aW5kcml2ZXIuY29tPg0KPj4gLS0tDQo+PiDCoCBwc2V1ZG9faXBjLmggfCAxICsNCj4+
IMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9wc2V1ZG9faXBjLmggYi9wc2V1ZG9faXBjLmgNCj4+IGluZGV4IGQ5NDUyNTcuLjI4MzZj
YzQgMTAwNjQ0DQo+PiAtLS0gYS9wc2V1ZG9faXBjLmgNCj4+ICsrKyBiL3BzZXVkb19pcGMu
aA0KPj4gQEAgLTI2LDYgKzI2LDcgQEAgdHlwZWRlZiBzdHJ1Y3Qgew0KPj4gwqDCoMKgwqDC
oCB1bnNpZ25lZCBpbnQgcGF0aGxlbjsNCj4+IMKgwqDCoMKgwqAgaW50IG5saW5rOw0KPj4g
wqDCoMKgwqDCoCBpbnQgZGVsZXRpbmc7DQo+PiArwqDCoMKgwqAgY2hhciByZXNlcnZlZFs0
XTsNCj4+IMKgwqDCoMKgwqAgY2hhciBwYXRoW107DQo+PiDCoCB9IHBzZXVkb19tc2dfdDsN
Cj4+DQo+DQo+IEkgdGhpbmsgaXQgd291bGQgYmUgYmV0dGVyIHRvIHVzZSB0aGUgYWxpZ25t
ZW50IG9wZXJhdG9yIGluc3RlYWQsIA0KPiBzcGVjaWZpY2FsbHk6DQo+DQo+IMKgwqDCoMKg
wqDCoMKgIHVuc2lnbmVkIGludCBwYXRobGVuOw0KPiDCoMKgwqDCoMKgwqDCoCBpbnQgbmxp
bms7DQo+IMKgwqDCoMKgwqDCoMKgIGludCBkZWxldGluZzsNCj4gwqDCoMKgwqDCoMKgwqAg
Y2hhciBwYXRoW107DQo+IMKgIH0gX19hdHRyaWJ1dGVfXygoYWxpZ25lZCg4KSkpIHBzZXVk
b19tc2dfdDsNCj4NClRoZSBgX19hdHRyaWJ1dGVfXygoYWxpZ25lZCg4KSkpJyBzdGlsbCBt
YWtlIFBTRVVET19IRUFERVJfU0laRSA9IA0Kb2Zmc2V0b2YocHNldWRvX21zZ190LCBwYXRo
KSA9IDcyLA0KDQpQc2V1ZG8gdXNlIFBTRVVET19IRUFERVJfU0laRSBmb3IgaXBjIG1lc3Nh
Z2Ugc2VuZCBhbmQgcmVjZWl2ZQ0KDQpUaGUgUFNFVURPX0hFQURFUl9TSVpFIGlzIHN1cHBv
c2VkIHRvIGJlIGVxdWFsIHRoZSBzaXplIG9mIHN0cnVjdCANCnBzZXVkb19tc2dfdCwgYnV0
IHNpemVvZihwc2V1ZG9fbXNnX3QpID0gODAgd2hpY2ggaXMgMTYgYnl0ZSBhbGlnbm1lbnTC
oCANCmJlY2F1c2Ugb2YgYSBsb25nIGxvbmcgbWVtYmVyICgxNiBieXRlKSBpbiBzdHJ1Y3Qg
cHNldWRvX21zZ190DQoNCi8vSG9uZ3h1DQoNCg0KDQoNCj4gSW4gbXkgdGVzdGluZyB0aGlz
IHJlc3VsdHMgaW4gdGhlIHNhbWUgODAgYnl0ZSBsZW5ndGggZm9yIGJvdGggNjQtYml0IA0K
PiBhbmQgMzItYml0IHN5c3RlbXMuDQo+DQo+IEkgd3JvdGUgYSBxdWljayB0ZXN0IHByb2dy
YW0gZm9yIHRoZSBhZGRyZXNzaW5nOg0KPg0KPiA2NC1iaXQ6DQo+IEFkZHJlc3M6IDB4NDM3
OWQxMDANCj4gwqDCoMKgwqDCoCB0eXBlOiAweDANCj4gwqDCoMKgwqDCoMKgwqAgb3A6IDB4
NA0KPiDCoMKgwqAgcmVzdWx0OiAweDgNCj4gwqDCoMKgIGFjY2VzczogMHhjDQo+IMKgwqDC
oCBjbGllbnQ6IDB4MTANCj4gwqDCoMKgwqDCoMKgwqAgZmQ6IDB4MTQNCj4gwqDCoMKgwqDC
oMKgIGRldjogMHgxOA0KPiDCoMKgwqDCoMKgwqAgaW5vOiAweDIwDQo+IMKgwqDCoMKgwqDC
oCB1aWQ6IDB4MjgNCj4gwqDCoMKgwqDCoMKgIGdpZDogMHgyYw0KPiDCoMKgwqDCoMKgIG1v
ZGU6IDB4MzANCj4gwqDCoMKgwqDCoCByZGV2OiAweDM4DQo+IMKgwqAgcGF0aGxlbjogMHg0
MA0KPiDCoMKgwqDCoCBubGluazogMHg0NA0KPiDCoCBkZWxldGluZzogMHg0OA0KPiDCoMKg
wqDCoMKgIHBhdGg6IDB4NGMNCj4gTGVuZ3RoOiA4MA0KPg0KPiAzMi1iaXQ6DQo+IEFkZHJl
c3M6IDB4ZmZjMmE4MjgNCj4gwqDCoMKgwqDCoCB0eXBlOiAweDANCj4gwqDCoMKgwqDCoMKg
wqAgb3A6IDB4NA0KPiDCoMKgwqAgcmVzdWx0OiAweDgNCj4gwqDCoMKgIGFjY2VzczogMHhj
DQo+IMKgwqDCoCBjbGllbnQ6IDB4MTANCj4gwqDCoMKgwqDCoMKgwqAgZmQ6IDB4MTQNCj4g
wqDCoMKgwqDCoMKgIGRldjogMHgxOA0KPiDCoMKgwqDCoMKgwqAgaW5vOiAweDIwDQo+IMKg
wqDCoMKgwqDCoCB1aWQ6IDB4MjgNCj4gwqDCoMKgwqDCoMKgIGdpZDogMHgyYw0KPiDCoMKg
wqDCoMKgIG1vZGU6IDB4MzANCj4gwqDCoMKgwqDCoCByZGV2OiAweDM4DQo+IMKgwqAgcGF0
aGxlbjogMHg0MA0KPiDCoMKgwqDCoCBubGluazogMHg0NA0KPiDCoCBkZWxldGluZzogMHg0
OA0KPiDCoMKgwqDCoMKgIHBhdGg6IDB4NGMNCj4gTGVuZ3RoOiA4MA0KPg0KPiBUaGlzIHNl
ZW1zIHRvIGFkZHJlc3MgdGhlIGlzc3VlIGFuZCB0aGUgb2Zmc2V0cyB3aXRoaW4gdGhlIHN0
cnVjdHVyZSANCj4gYXJlIG1haW50YWluZWQgYXMgZXhwZWN0ZWQuDQo+DQo+IC0tTWFyaw0K
DQoNCg==

