Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABE8C5B543
	for <webhook@archiver.kernel.org>; Fri, 30 May 2025 02:58:49 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.2586.1748573923284170201
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 29 May 2025 19:58:43 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=824540ae1d=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TMDj3D030664;
	Fri, 30 May 2025 02:58:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46u53962u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 May 2025 02:58:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+7HTQqCfC60zqSj8fY2+13MCIUdDz2qFBlWrpwMuKuAfu6YQ7p5NBshA94ZJczhXyHr30XEDrrNn7ljrfVFaX+cWcXbnSF3UIPldM6nbnlU3+B3ZsNEqbjGR8Go59DnHl+o/XfuSHz424yRpBWMJl1zNLRrVwgSFfQMCDk7tVy1anI6J4eYy/zp6Jfvw/I3R+YlF96aJGlFhvw4lhgX0xuiP2FJamXOI22EX2a7gQNcA61gciB2lzzDIuPTM25/fAwogsWlkhVqbjuKZVtusuC/Ys2uTaOMf3q2gUld2Bld/8zuYzG+7p3/VGR0uYru/inJapD8lvMBbeQstDYYUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBRLuLjgLXQRI0q6oK+0W73UMgUWGhp1120ywn2rJN4=;
 b=xhq7jtmJB3WSnjnSOJ1oMOwz94O9SZzQYh/e3m8pG7ulp5TKS2QzYv6NSSnsK07wKBgpvYQz/IDdvqllOpcpFswbCv1Dcvlms+b7P+MBW7Aed0bIn5/65/AL9m2H3sN1O2Ih8y2I2aivHfNtZA1+aqmp2miaXoZfV+NiGgWZolWI8lhKeeLdZ0EmeyOmC1Wiu+HeXP7LxJToXVTh7EMRL/vrRB042q2Bv9dj9OmymFbR6TaZWM72Mb9jZCiiFu3wCKhzq8ZwxhYu90OL2XDV1lU1EorOJ/rkyDwkVNsuWXngJ7CY9mIOwwLS/2dUvq/V15d/JtwC1NR2oGctdYEPrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 CH3PR11MB8441.namprd11.prod.outlook.com (2603:10b6:610:1bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Fri, 30 May
 2025 02:58:35 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%4]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 02:58:35 +0000
Content-Type: multipart/alternative;
 boundary="------------Ty2uXut4RG0FPuu8057PCQIF"
Message-ID: <970c54a3-dd01-49b2-8cb7-2c359cd3a3e5@windriver.com>
Date: Fri, 30 May 2025 10:58:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][PATCH] scap-security-guide:
 disable ptest by default
To: yocto-patches@lists.yoctoproject.org, ccasciato@21sw.us
References: <20250528055417.2527453-1-yi.zhao@windriver.com>
 <445.1748436787375609799@lists.yoctoproject.org>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <445.1748436787375609799@lists.yoctoproject.org>
X-ClientProxiedBy: SG2PR01CA0136.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::16) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|CH3PR11MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: 775e0b45-56c3-48f6-80c7-08dd9f25de95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|4022899009|7053199007|8096899003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eDAwbFhvTFRMaTF5YnEzVVpuNEJBT2JDbVREcERWNTFYWlBQWUQ3eWZCS1NL?=
 =?utf-8?B?eTRPcWo5dXk5b3VTRzA0aURlR2xNNlZxTEtqT3BNSWR5WWVMMXBlNFA4NjQz?=
 =?utf-8?B?Y044OWRxM3RhZjhmMGZxbDRTbVNUV3hCWkFJMksrOWFDN0lFOEI3d05xNUM2?=
 =?utf-8?B?OEwxR1MrMlVIeCt1UGJJSm5XOUlHczBLRkRWdjN1RThzT3AxSGZ1N0Q1TXoy?=
 =?utf-8?B?S3hRTWRFVzhCK2dzWGx5MjJ3YlBNS2VEYUpSbnZoSWM3Y3JYYy83akNhbUxD?=
 =?utf-8?B?dXRmekRrbFRaNTNlaW1pelpaa1F4bTNPcFJHakhXRFpMSjBSZDlHNHMvU2ZE?=
 =?utf-8?B?Y0VaY0RVQ3k2VEIzZU9SOHR3MkVTUUd6d29ROTBzRTJQM2kxRHhzOXhWYzNn?=
 =?utf-8?B?S01qdU5DRERtU1hpSWRmWmsvcGp3VURoUC9vT0tiK05EbkYvRlNoa3JoZHl5?=
 =?utf-8?B?L1BrUUJ2Q25sVHFLalo5N0hCZmRWUTBJZURTR285QXhjR05wZndhRURLdkpk?=
 =?utf-8?B?WndIeU1BRkVHSnFxazNPZFNwRkhVRFo0NHpHMHBtYzNFbENZT3YreWk0RWw1?=
 =?utf-8?B?MlFIaUxvclhwaDRvRTBHamhxMTlmQ0F0a0dmeHZnYjJXT1Zlb2d3RStiOXhz?=
 =?utf-8?B?cEUvemh5bG1XMHJpSGNxdTR0TjUwZjZMaFNhQjRKVTRDcEdmbVNSdS9BaHpx?=
 =?utf-8?B?ZjRJTW5rRU5OZzNGT2ROenI0UmZ4S2I5RmFla1VuV09ydUVta3ovYStCTG1r?=
 =?utf-8?B?N1MxUzE3UnZENXliZjVNU3VMcytnTFZlSnNDMkZsR2ZFbE10aThGTko0RnA1?=
 =?utf-8?B?ckRiNEtVUytNbmlDQkZlSVFad1hBWjRnRm5HUnZIUGdlc2JtZTJ6cnNudzVB?=
 =?utf-8?B?bU9MU2dNa3ZraUxtcE4xZEpDRzFlZFRtcFViQ2w5dk93L0xvV3F5U041bzN6?=
 =?utf-8?B?TlFDOTJTRHkxMUZ0TmdFQ0hDUzJnSGZyeTMwcUU3N09YY3N4ank1SGVYUy8z?=
 =?utf-8?B?dHF2c0prbTZZeEk1WU9lNTZ5YzFWdHBVNkVqVTNPSm9qZkR5ZGtVSUladjA0?=
 =?utf-8?B?Z2NZTVVhV015MWhrY3UzVEF2bmNPM2Vyb3FmTTNvNnVpVG5oM2pzdEhVYUts?=
 =?utf-8?B?UlVmMG5aeGRUNE5reFFOUlRlWE1pZjB6VDh2RXQ0WVRiUmxFZ0FHSFZpTTgr?=
 =?utf-8?B?WjZzS2ZhS3FpTnd5VFRSK25lMFNRaWJ6US8xbzJldzJrMG5GZzdGaFM5S1FQ?=
 =?utf-8?B?Tm0vRDhWRUVyZVhPVVBnNXYrNWliNzVMcjFDNGdodjQzWGpIditqVk9IL2Jx?=
 =?utf-8?B?aytSbFFXR0Y1WDJwaVZDM1ZwYVlCTkNtT0hLalVNY2dqR1NTekpZVnk1Nkd4?=
 =?utf-8?B?ekwydEYvZjJrZmpUOC9wRGpzQUg5TUtaK01qSHVhM0pVeHRhbGY2QmgydUtB?=
 =?utf-8?B?ZkZSV2I4SS9ieW1haHFBaFYrM2pPcXplaU5xWWtPL1UvQzc5bitZR240NzY2?=
 =?utf-8?B?UUxWNU9waHBTTUszSi94K2pvQ0xIUjAxVHVodnNsdnk3dVY1dDkwaUlhU0sr?=
 =?utf-8?B?dUcweWpQNjBodCtHbS91aFM0RGNyY2hQZ1E1eHVyRFN1dmlDN3BiVnh3RFVy?=
 =?utf-8?B?aU4rUVFydlFCL2tFZGNwSUsxb3FMRzhtRXZDaWVNc1AyL2tUSDdxcFJqOG5K?=
 =?utf-8?B?NmFrTExZMkU4ZHl5SUd2SDA1dmhETk5QZG9XZitmOXN0VzZwb0JCUC9Pa0ZE?=
 =?utf-8?B?MUhiZEpCQjBueTcrNHVUc2x3a1hhZGQrejlIaE1QZkNDVVpsV245K1REdEYw?=
 =?utf-8?Q?84X51KD8+Kn/gwLceZXPA/SHTDTbk81tkxgP8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(4022899009)(7053199007)(8096899003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U0xsdUM0bXAvUGFHM0xRWEZnYWg3UWttNzlpVnVVQjg2aG5FaW41bG5QTUhE?=
 =?utf-8?B?di9Iamp6N0JkR3pYRlNoVU9lbE8xdTFXT0UzSEdHZlVsT1drZGN6NEZXQUhE?=
 =?utf-8?B?b1l0bllqWWp1UGFxejJWalo3SEo3K0YvN21wc2t6UHBlb1k2d3ErL0JkZnZT?=
 =?utf-8?B?WW82VUM1R0FQZWwxdWpDREgxd1dwU2xYcHpaM2dGUlBtVklhOVZDdkIxVS85?=
 =?utf-8?B?YXZRbm1VcmFwcmpjRk9QU2FrSlpEMHZEaDdQOTVJZlVOZCtJWTZNWS9BWEtz?=
 =?utf-8?B?Ymtkc1dGTGEyT254U3pSeXZDK29Jei9DT21oeFVhRE1QeDE2bithSnhKVUJK?=
 =?utf-8?B?YjFUeTAxMlhpT1FNdGN0TVJyZ0pVOHk2MXpPcWlibVhHZnlvRXZTblpqQ1JK?=
 =?utf-8?B?MnNwU2t6UHBpODJ1d2RQNUJGaHQxY21EOHBuTEtxenNvenFtYnFicHphTFFQ?=
 =?utf-8?B?TnVWZEdWNGdwWldkeFNib1VHdnc5anZMb3NZZThBRFVWcnQxWks0U05UU3cx?=
 =?utf-8?B?L0tKWkNVaEFpV1BUcWljaVZ0R2JHa0p4ZmtRSzNKZ0R4bEYrVW1PUjhMY1la?=
 =?utf-8?B?UVAzV0tTOFFvWmFXTGtWUE5UZG5SaTJrM2VEbEJDT3I5RFFkekZ5bjRGRkl2?=
 =?utf-8?B?TGVMNHhrYk5HbFh5NEZZdXprY2swZ0pxbkp5cTN1NmRVR21jdU5ycE9pNUN3?=
 =?utf-8?B?L2NHTTBwQXVqVE5hT29YODlqM0hyaEFmOHNzR2Z5bTZzRC9Uai9iRkNlSldT?=
 =?utf-8?B?U0wvSllWWHdLM0ZWbzJCZW9mNVlEY3BXK3ptUmxaa3BITFduVWQwb29UL3Ir?=
 =?utf-8?B?dnF3ME5ZZFJOd3ZtaVhaRURNU3JMeUR2SHQrRjdIYUNsM1NUYUY2aEZtMHRN?=
 =?utf-8?B?WGQ2Q1FITWJqNEVVSUlSODZiSnN0R0tXblBHR1ZWZkV6ZlNPMHoxSjlySkVx?=
 =?utf-8?B?VWh4UDc1Zk1jcHI2RVMyeDduRnVFNkwvc0FHU3BHRE4yOWhuUE5Cc0g5TlRw?=
 =?utf-8?B?MjMrTlhqMkx4dUJxa25renR4amVYZllwR25Mcit4MkYrNTBWS0pTcDNrNTUz?=
 =?utf-8?B?YUdaYmo0Vm15TENGdFRHVWhnc05TYVdKdDBIbFpVL0hYalczZzhPMTQ5YWNG?=
 =?utf-8?B?cndUM042ZU40Y1RKS292MTNORFlLVGF2ZUVIMlphQ3o2UUNONDJlaFYxcUgy?=
 =?utf-8?B?ZVZqeEJacHEraEwxa3dsalVCZFpYUm9xRS93ZFJwclVBR3l2bTdVK2J3RHJY?=
 =?utf-8?B?M2VQUlkwRWdoeEtBdWs0bUVIV3hIUm8vTTErMmFLOUZxSkZJUGNDd1dQMXRp?=
 =?utf-8?B?TmgxZDlGdno3eUtURndNa0YxMVRIYk5IS3l0MGFvRWVDWGRBV3RKOWtCWXRh?=
 =?utf-8?B?QUNvUDQ3ZFdFY2IvbmtHMFF3ZWdDZm9uYWEvT1VWZ1U4SCtPckR6WXpIMVc2?=
 =?utf-8?B?SnZtNFZ4NklyQitHVWR2ajB5c25MTlVKd0EwNkE0YnlkdVFZK3Zsdkk0Qlgx?=
 =?utf-8?B?TGY3N1cvSVlCRTNmbjg2bW1oa0lSMmtDTHNEL1ZZVjl1dFBHY3ZVL2ptT3hs?=
 =?utf-8?B?UVgvK0VZaHZONDNGY3hjUm02RjBRS2dVd1REbHBOV0tUdmh3RVRXT0hXZU1U?=
 =?utf-8?B?djJHNkZYcnlJbXViemk3TitwK25DeTIyVTJyUmxHbm82UStXVXdyU0I2Q1J3?=
 =?utf-8?B?V3BjUC9xeVc0Q214OC83bFM4MklVTkZBUUVYSzZ1NTZqYzhicWl4anpMcEtC?=
 =?utf-8?B?QS93czFaMEx0RE9nL1FYbjljNURZT1RUWXBYd2x5NkcvbWNyWU9WYWVKTy8w?=
 =?utf-8?B?YTg3WTZNdmxWWDRxRTFUYnFlR0lDVWJDZ3pSZm9ONDVYdjZ2a0JmUjV5RWxh?=
 =?utf-8?B?d0ZjQUVIc045WDhYQ3JGTUd2ZzU0VkUwQ3FrV2NZaWhIMzUzWGx3SXRESnNP?=
 =?utf-8?B?eXNtUzlmakVNbTh6V0R0TmlnY0J6NDFjWmQ2czNCcEhGZUVBNnkvM09mSGhG?=
 =?utf-8?B?NkNJOVpzUWNoYkZ0bHIvSHlxOEN0MUpHYXlZekJLQXVFYmVSbUVGSlZ2d2sy?=
 =?utf-8?B?d3hGaERUekQvSFNPRENXMkhJeGFQNFBHRTcvc25wVDAzWVo1U0E3MHE2TmtB?=
 =?utf-8?Q?KluF0sJ9SgQV1f7WoF9HBGdo1?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 775e0b45-56c3-48f6-80c7-08dd9f25de95
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 02:58:35.6798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OJ9sLEK93IcLN11zSyx0fqWXmwcY85erU4G7+VmRbO9cB4LGzDdXoLJEw0VZQmALYbQCV/PfzCYnkK0gLCy7sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8441
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDAyNCBTYWx0ZWRfX/w+bujN+xqVt eBDq66HJ6HGDX3DZr6GVcLzENVIVYRBPqT1f2aXFC9x5yva7qARIKmu6fnH02L4oWSxnfWSUrlM 6KJVyLPYddSTAwdxBfXqN+Rwy6y/BabdKCQDvJdHaxjFUD4uFyJ16YAhUsuOYZpUHIqz+CPfDby
 nS6Ks85rxBwEzpb98sb3Ud9sEWD8LYeFrH4Ge8m4mrK9ij+/rS/poB8nk5Pi7rquWNjemizCZ7u o3XEanEl+4RRXfU8nkzJJaElohL3yv11T4AEBABSxTa+S/WWIlja7YwqRK6Z01ucrIokMjj8gMo Dzl2t0jFkmsoVxezSQgyGYk/Mf+RRSB8SuIzaBlngdtRONFnJyY37wNH32FSV0C9W79IZoPpNpJ
 RQBnH+YhrDePgYTecE4Y2vSl5HcSDpOjYOoIaSqsdHmuQ4OZcpbwz4LIMEHhs8FsrhhrL31g
X-Authority-Analysis: v=2.4 cv=NsDRc9dJ c=1 sm=1 tr=0 ts=68391edf cx=c_pps a=ySBmDkUCmEx7wxu+BikqxA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=Q4-j1AaZAAAA:8 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8 a=p2L6Qt3ZuG95-QMQbCMA:9 a=QEXdDO2ut3YA:10 a=W-XOd6F52eEJk0iPp_EA:9 a=5tBsYfftAse7obvr:21 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10 a=9H3Qd4_ONW2Ztcrla5EB:22
 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: -SB0JdUofN5GR1eoBa2OBhgKrcqYvTwR
X-Proofpoint-GUID: -SB0JdUofN5GR1eoBa2OBhgKrcqYvTwR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_01,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505160000
 definitions=main-2505300024
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 30 May 2025 02:58:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1599

--------------Ty2uXut4RG0FPuu8057PCQIF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/28/25 20:53, Clayton Casciato wrote:
> Hi, Yi!
> Should this use inherit_defer due to the conditional?

Hi Clayton,


I've tested this. But setting SSG_PTEST_ENABLED to 1 in the recipe or 
setting it in local.conf has no effect when using inherit_defer.

Here are my changes:

-inherit cmake pkgconfig python3native python3targetconfig ptest
+inherit cmake pkgconfig python3native python3targetconfig
+
+inherit_defer ${@bb.utils.contains('SSG_PTEST_ENABLED', '1', 'ptest', 
'', d)}
+
+SSG_PTEST_ENABLED ?= "0"


//Yi

> Sample:
> https://git.openembedded.org/meta-openembedded/commit/meta-networking/recipes-support/chrony?id=63df976d8eec0fa714e8da30f4333f8af23c57d3 
> <https://urldefense.com/v3/__https://git.openembedded.org/meta-openembedded/commit/meta-networking/recipes-support/chrony?id=63df976d8eec0fa714e8da30f4333f8af23c57d3__;!!AjveYdw8EvQ!ba2hNq8NE_kzvVH4c1lBFhfj4diFk3IrBD1lplXX2KiwaE-G4Mc-OD_ftdFbuWzU6JPHItBy-J1VIuHeKzGUJxqe1Q$>
> Thank you!
> --
> Clayton Casciato
> _._,_._,_
> ------------------------------------------------------------------------
> Links:
>
> You receive all messages sent to this group.
>
> View/Reply Online (#1583) 
> <https://urldefense.com/v3/__https://lists.yoctoproject.org/g/yocto-patches/message/1583__;!!AjveYdw8EvQ!ba2hNq8NE_kzvVH4c1lBFhfj4diFk3IrBD1lplXX2KiwaE-G4Mc-OD_ftdFbuWzU6JPHItBy-J1VIuHeKzF7GJrksA$> 
> | Reply to Group 
> <mailto:yocto-patches@lists.yoctoproject.org?subject=Re:%20Re%3A%20%5Byocto-patches%5D%20%5Bmeta-security%5D%5BPATCH%5D%20scap-security-guide%3A%20disable%20ptest%20by%20default> 
> | Reply to Sender 
> <mailto:ccasciato@21sw.us?subject=Private:%20Re:%20Re%3A%20%5Byocto-patches%5D%20%5Bmeta-security%5D%5BPATCH%5D%20scap-security-guide%3A%20disable%20ptest%20by%20default> 
> | Mute This Topic 
> <https://urldefense.com/v3/__https://lists.yoctoproject.org/mt/113339598/7283133__;!!AjveYdw8EvQ!ba2hNq8NE_kzvVH4c1lBFhfj4diFk3IrBD1lplXX2KiwaE-G4Mc-OD_ftdFbuWzU6JPHItBy-J1VIuHeKzEyysYlsw$> 
> | New Topic 
> <https://urldefense.com/v3/__https://lists.yoctoproject.org/g/yocto-patches/post__;!!AjveYdw8EvQ!ba2hNq8NE_kzvVH4c1lBFhfj4diFk3IrBD1lplXX2KiwaE-G4Mc-OD_ftdFbuWzU6JPHItBy-J1VIuHeKzE2PLdrJw$> 
>
> Your Subscription 
> <https://urldefense.com/v3/__https://lists.yoctoproject.org/g/yocto-patches/editsub/7283133__;!!AjveYdw8EvQ!ba2hNq8NE_kzvVH4c1lBFhfj4diFk3IrBD1lplXX2KiwaE-G4Mc-OD_ftdFbuWzU6JPHItBy-J1VIuHeKzF7FBOd0g$> 
> | Contact Group Owner 
> <mailto:yocto-patches+owner@lists.yoctoproject.org> | Unsubscribe 
> <https://urldefense.com/v3/__https://lists.yoctoproject.org/g/yocto-patches/leave/13170635/7283133/1683771902/xyzzy__;!!AjveYdw8EvQ!ba2hNq8NE_kzvVH4c1lBFhfj4diFk3IrBD1lplXX2KiwaE-G4Mc-OD_ftdFbuWzU6JPHItBy-J1VIuHeKzF3pMBRvw$> 
> [yi.zhao@eng.windriver.com]
>
> _._,_._,_
--------------Ty2uXut4RG0FPuu8057PCQIF
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 5/28/25 20:53, Clayton Casciato
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:445.1748436787375609799@lists.yoctoproject.org">
      
      <div>Hi, Yi!</div>
      <div>&nbsp;</div>
      <div>Should this use inherit_defer due to the conditional?</div>
    </blockquote>
    <p>Hi Clayton,</p>
    <p><br>
    </p>
    <p>I've tested this. But setting SSG_PTEST_ENABLED to 1 in the
      recipe or setting it in local.conf has no effect when using
      inherit_defer.<br>
      <br>
      Here are my changes:<br>
      <br>
      -inherit cmake pkgconfig python3native python3targetconfig ptest<br>
      +inherit cmake pkgconfig python3native python3targetconfig<br>
      +<br>
      +inherit_defer ${@bb.utils.contains('SSG_PTEST_ENABLED', '1',
      'ptest', '', d)}<br>
      +<br>
      +SSG_PTEST_ENABLED ?= &quot;0&quot;<br>
      <br>
      <br>
    </p>
    <p>//Yi<br>
    </p>
    <blockquote type="cite" cite="mid:445.1748436787375609799@lists.yoctoproject.org">
      <div>&nbsp;</div>
      <div>Sample:</div>
      <div><a href="https://urldefense.com/v3/__https://git.openembedded.org/meta-openembedded/commit/meta-networking/recipes-support/chrony?id=63df976d8eec0fa714e8da30f4333f8af23c57d3__;!!AjveYdw8EvQ!ba2hNq8NE_kzvVH4c1lBFhfj4diFk3IrBD1lplXX2KiwaE-G4Mc-OD_ftdFbuWzU6JPHItBy-J1VIuHeKzGUJxqe1Q$" target="_blank" rel="noopener" moz-do-not-send="true">https://git.openembedded.org/meta-openembedded/commit/meta-networking/recipes-support/chrony?id=63df976d8eec0fa714e8da30f4333f8af23c57d3</a></div>
      <div>&nbsp;</div>
      <div>Thank you!</div>
      <div>&nbsp;</div>
      <div>--</div>
      <div>Clayton Casciato</div>
      <div width="1" style="color:white;clear:both">_._,_._,_</div>
      <hr>
      Links:
      <p> You receive all messages sent to this group. </p>
      <p>
        <a target="_blank" href="https://urldefense.com/v3/__https://lists.yoctoproject.org/g/yocto-patches/message/1583__;!!AjveYdw8EvQ!ba2hNq8NE_kzvVH4c1lBFhfj4diFk3IrBD1lplXX2KiwaE-G4Mc-OD_ftdFbuWzU6JPHItBy-J1VIuHeKzF7GJrksA$" moz-do-not-send="true">View/Reply Online (#1583)</a> | <a target="_blank" href="mailto:yocto-patches@lists.yoctoproject.org?subject=Re:%20Re%3A%20%5Byocto-patches%5D%20%5Bmeta-security%5D%5BPATCH%5D%20scap-security-guide%3A%20disable%20ptest%20by%20default" moz-do-not-send="true">Reply to Group</a> | <a target="_blank" href="mailto:ccasciato@21sw.us?subject=Private:%20Re:%20Re%3A%20%5Byocto-patches%5D%20%5Bmeta-security%5D%5BPATCH%5D%20scap-security-guide%3A%20disable%20ptest%20by%20default" moz-do-not-send="true">Reply to Sender</a> | <a target="_blank" href="https://urldefense.com/v3/__https://lists.yoctoproject.org/mt/113339598/7283133__;!!AjveYdw8EvQ!ba2hNq8NE_kzvVH4c1lBFhfj4diFk3IrBD1lplXX2KiwaE-G4Mc-OD_ftdFbuWzU6JPHItBy-J1VIuHeKzEyysYlsw$" moz-do-not-send="true">Mute This Topic</a>
        | <a href="https://urldefense.com/v3/__https://lists.yoctoproject.org/g/yocto-patches/post__;!!AjveYdw8EvQ!ba2hNq8NE_kzvVH4c1lBFhfj4diFk3IrBD1lplXX2KiwaE-G4Mc-OD_ftdFbuWzU6JPHItBy-J1VIuHeKzE2PLdrJw$" moz-do-not-send="true">New Topic</a>
        <br>
        <a href="https://urldefense.com/v3/__https://lists.yoctoproject.org/g/yocto-patches/editsub/7283133__;!!AjveYdw8EvQ!ba2hNq8NE_kzvVH4c1lBFhfj4diFk3IrBD1lplXX2KiwaE-G4Mc-OD_ftdFbuWzU6JPHItBy-J1VIuHeKzF7FBOd0g$" moz-do-not-send="true">Your Subscription</a> |
        <a href="mailto:yocto-patches+owner@lists.yoctoproject.org" moz-do-not-send="true">Contact Group Owner</a> |
        <a href="https://urldefense.com/v3/__https://lists.yoctoproject.org/g/yocto-patches/leave/13170635/7283133/1683771902/xyzzy__;!!AjveYdw8EvQ!ba2hNq8NE_kzvVH4c1lBFhfj4diFk3IrBD1lplXX2KiwaE-G4Mc-OD_ftdFbuWzU6JPHItBy-J1VIuHeKzF3pMBRvw$" moz-do-not-send="true">Unsubscribe</a>
        [<a class="moz-txt-link-abbreviated" href="mailto:yi.zhao@eng.windriver.com">yi.zhao@eng.windriver.com</a>]<br>
      </p>
      <div width="1" style="color:white;clear:both">_._,_._,_</div>
    </blockquote>
  </body>
</html>

--------------Ty2uXut4RG0FPuu8057PCQIF--

