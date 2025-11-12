Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D40CD342F
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 18:05:19 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com (DM1PR04CU001.outbound.protection.outlook.com [52.101.61.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3909.1762970328256474716
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 12 Nov 2025 09:58:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amd.com header.s=selector1 header.b=QsqHUHd9;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.61.45, mailfrom: mark.hatle@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oK57Q1bjFRJntVJM6eYLmJsk3Hc2NrfFme6vJHmf/xIXlsWe7jE9RKNlB1nayBxvQLi155t7yIFjfwxJwaIOqMly90LmwaUnTdanI+2l23OPxTiJD+6G70wnbF693KfvGntpjglIDcYz0Rv+L6HnJjjPLRH9s7YsG6AWAM0HJgyVEZDoEw9k7Oqh6DO8KHutlnR3+734N2MYkZHvlAaxqQS5Vcd6SAHmPDnIc5n6lvw7dUSrqIGpiyKQgKsQA3MmRZ+I8/mzOdZWGRLTzuRJfYyvAtURhka2mmcXKTbYlMS1gbtMVSapNkulTd4h6htTmO5IaZy+3B5+VWVg6FUBjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILtJcBNRkA0dsHenI8/Hicd7re8iYkXJZvOBXA0hZ5M=;
 b=tFEC6ii1bJ/5zXISN4wqR/Y7J2XfNMeiPB4jaKyHHWgaa7v623qTlOp2O467/gQ4qu/ZxBZhYUjJlZu0Hzhp62m9GV9/eWhn8SlzgOdU1GBEjIHp5tH4u9tgqJLhsjMaDtOYv8TYkbcs/SejCH6JiBWfxXzSrrxPXrEdw+gjBXiPnXnV7fRgTsVuUWdh2U4UQX3Ibmg/Ybcgi7/ewurrCWVJEiJFeaElbr6pYp0a9JyUx+ynDKoyXMbW4/POPGpQA8BFQ0OAMk2qTQshBnYLIjV5qunwqxBvqwqMu0/JV2gJ2SlYa+tVHuPU2J3M/l8nMippu2iiiYv7VMqGVS69BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILtJcBNRkA0dsHenI8/Hicd7re8iYkXJZvOBXA0hZ5M=;
 b=QsqHUHd94yyLCpWhJXhX8lo4R0MITqlSe7lWvTD/muMXr+MQkjQrGWCPb+WC4Ssvy2h/wg6nEA9/Z33VaOevlwXSF/7rF25TPQtYg4pfKob0UnpchKNeGxf/o6JAzilqMipOGtlVi84aJpFn6vgVZlEpERPmskqpveqgu/H7LD0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14)
 by DM4PR12MB7694.namprd12.prod.outlook.com (2603:10b6:8:102::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 17:58:45 +0000
Received: from PH7PR12MB7018.namprd12.prod.outlook.com
 ([fe80::e2bd:c56f:ea1d:9a11]) by PH7PR12MB7018.namprd12.prod.outlook.com
 ([fe80::e2bd:c56f:ea1d:9a11%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 17:58:45 +0000
Message-ID: <711e5b61-ac32-40fd-b014-1cbdba45dc98@amd.com>
Date: Wed, 12 Nov 2025 11:58:42 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [pseudo][PATCH 2/2] pseudo_db: fix duplicated xattr in rename
To: Hongxu Jia <hongxu.jia@windriver.com>,
 yocto-patches@lists.yoctoproject.org, richard.purdie@linuxfoundation.org
References: <20251111135951.2121065-1-hongxu.jia@windriver.com>
 <20251111135951.2121065-2-hongxu.jia@windriver.com>
From: "Mark Hatle" <mark.hatle@amd.com>
In-Reply-To: <20251111135951.2121065-2-hongxu.jia@windriver.com>
X-ClientProxiedBy: YQBPR0101CA0114.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::17) To PH7PR12MB7018.namprd12.prod.outlook.com
 (2603:10b6:510:1b8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7018:EE_|DM4PR12MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f51adf-e35c-4a58-24c7-08de22151fa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?V1FHNlhoTS9iOW5nb2hYdlBvc1RQcDZyQVdjcWN3MVBZL3E2eEdsdEgzcWlk?=
 =?utf-8?B?bC91aGsyRDFTRENncndkRWlRdmRIRitjNE5TeitWUzF1VHFnOEN2bVpWNE8x?=
 =?utf-8?B?V3V4ZkpHcitLcm80NXcxVkt6bHZMWHIwR3JCMXBzMEVNd1h4cmRKQ2pjVTJa?=
 =?utf-8?B?OHpJZXo2YUt0cnJ6TG1uajQxd0ZYTk1wRzE0aTd0V0VuMGxUMXcvWU9PNVN3?=
 =?utf-8?B?MjZONEplL0dTTXVNaWVzaDZQZVpPRHNYL1gybWE4QUlHUTh3OXJwNTNzQjRp?=
 =?utf-8?B?UWkrQVhFZkg1S3pWUlJ3Q2NVVll4LzY4QjhQQmhXZEZydXN0WEQ0d3duNEM4?=
 =?utf-8?B?ZVRxU1g3MXd2bG8zRHk5anVHODQvQ1g3cGcwd0VrNG1GZllRR1I5SGVheFkw?=
 =?utf-8?B?WmJiai9QZSsxbHA1S2RjdEdnNU9PcnIzTjc4OUtMRk9IaTVjakNySUgxY1Ra?=
 =?utf-8?B?T3ZmZkl0MEJsNHRaTENDbjhXYVJZUDBsZ2dKbmM0RFRHMW9WTVdDbjFESkVF?=
 =?utf-8?B?T2hlTzdCaG5TSHNRZ3JjUFZQRnJOVEhuUlVLRkdTODdSME84NzRUY0tEVWgr?=
 =?utf-8?B?MFZoNm9xN3diRElNVkMxV2FxRzJhQjZLSXM0OVA4cnp1NXpQVHRYNWVndGFH?=
 =?utf-8?B?WnhjTkNDQm5xdW9VMXQ1SE5ocWNHV1ZQWnkrZnRqTUU4UWtPVXMyWUJ0MW9J?=
 =?utf-8?B?ZHROdlZGNWRJbHNNNTVtalpxWlUxTmhzdG1FSW9TV0VBU1E2eW1ZME92NjQ4?=
 =?utf-8?B?b2VPNm82bHl0b2wzc0dMRk90Vk9kbGplUmlXWnVzMU42SFdDdUMxa1lDcWFH?=
 =?utf-8?B?NTZXcTc1TDd3Z3FGV1RweEdLWThZdUNPdmdkRy9XQW55L1lXM1hqTkV4Kzgx?=
 =?utf-8?B?c2VHSXVvS2s5QTgzUHE2aWErUEV3dlBtaSsvbXJGbkRVbXlIYmZWSmNyZ3Zr?=
 =?utf-8?B?RythdndBVkZ5TEpPNjdpQkxpTXp0NzRlREdtcnluMVRJUGhmT2pKdkFoZE1k?=
 =?utf-8?B?MTgwUlBkdUZiQ1o1OFRVd0tTekVBbmQ4blg4MmNlVUZFOU5GbEpSOUlSMGk4?=
 =?utf-8?B?R2VxSWY1Uy9IUkEvaWt6Ri9ZRjN3c29obXNVN25rR3MrNTYwR2N1WFp6aElr?=
 =?utf-8?B?TFFURGFOZk1CWUhLVXpQUW9SLy9oSTlDNjlSL3Bld0YyT2czQitxK3U3dHcw?=
 =?utf-8?B?bExwN0JKc2RvaFFpQVJSYUZJbzNTZE5qajVhbDh1V1BYTzFRenBnTWprUy9o?=
 =?utf-8?B?dHVHdnBsS0Urd3hkMis0cE1FOWlybnkyTTRKS3J0QW41cWFFMkVMeVVmM2E4?=
 =?utf-8?B?cmFqeXZhQ2wvTjFzR1FSajQvK2lkVzhTSGhEYjA1d3RMV3NkSUhzelkrQWNH?=
 =?utf-8?B?Rk1EZktpQWoxbklueXZ0SURwRTR4bTREdklGaURSV25Pb2tLMHg5ajJoSlhM?=
 =?utf-8?B?aE5wNjZGT3ZKZmtKa3ZEYmZsRlZSSlkxN1VrWUM0UFdic1VTNHY3cWFSYVdZ?=
 =?utf-8?B?WHJ4WWl6aU11WVBVQXJMdklYM01UUGdxTFliNUlUZ2NRenJzZmxQWW44Y2JD?=
 =?utf-8?B?WnpEbUpUd2hLeDBOV0xCSW90WHdNR0Q2a29YSnFMcDJqL0FIU25XSDZZV3J2?=
 =?utf-8?B?QzR2b0tLZzlSRUlCK3Znb21hdXc0NWxTMDJ6dlFidThJRTZDZTR3K0RWMFp5?=
 =?utf-8?B?L1B6a3hLbUlVcTBZdEFKNDY4SWZPZFExNEtSbVB3cUdHZjVWMmdNUitYUndS?=
 =?utf-8?B?UVhNclpXN3lUQVl1VlJuRjlPRzBUdG5YQjAvMXF2Z2paMzhmbWpjSkpqUlJM?=
 =?utf-8?B?NkVHdk15TUh0SVZjcTZQak5XRlI2TUx5SmFlRUpkbHkwWDJCdW0rcDhiNW1S?=
 =?utf-8?B?OTNDVFpMaTIwVHJKYmg5aklPTlBXWTIvUzQ2dUVQYStrQnBkSGxGa0RyMzhs?=
 =?utf-8?Q?bUHwbFj1ReKoNsPPKlSQWsIgYeYqNpKL?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7018.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dFpWQzE1bm80cldLQThyOGdUSFByaFFOdm9GR0pvaEg0N29sWmI0b0I4eWhj?=
 =?utf-8?B?eDcxUDE0dW9ZSUF0dytId3I4MTVEZEVxRnAwNXN6SFNzdzNyOHp4VmxSajJ3?=
 =?utf-8?B?KzVmODRPZG8wOUtBOWhKd09hMENEZzhHNElKVzZtSkVjYnU0SGppZE9GRmVr?=
 =?utf-8?B?YkdnSzRBVFdkWERKR2RxUE0yZWlMZjRWcnk4QVlaUm9Pd29KYmFiaXUwKzlI?=
 =?utf-8?B?TGkyM1ZOQzRjaUlobVZSZjE2ZkREdnM3Ukt0ME9rZ1J1TXl6VDR5NitSM1k2?=
 =?utf-8?B?bzJMemVxRnFEOTZjd0hmeWV3eTYrbHhnUEdwRjFhbU5YVXl0TEhVTjJaaU1w?=
 =?utf-8?B?a3ZsZWV2aGJLbElNU0J0eWNBVDV0d0xRVWgvUWVkZk93MEI0NXd3Rmg0cGk5?=
 =?utf-8?B?NjNDd1k5TDFkQUtmU1NtM3g2dUpXKzVQK2o5cHJkbXJzOG9jMTAzK1hFb2Ny?=
 =?utf-8?B?V3VlQmJTcmREeDNFQjhXcUw1djdEZmhFZzJpZzVILzlEd0V6RlhUbE0ybTNu?=
 =?utf-8?B?aWZPTEd4akhZcDAyc2o4R1VldzR5N3lVc20vNVNZbHRRR2IwZ2ZwdjE3OFo0?=
 =?utf-8?B?aWdMdlo3bUVvcGphYTVOZzIrRlJNcSs2S0tpdEovMU5UMktPTGZhQkZlenRD?=
 =?utf-8?B?cjJGUFY4STF4VDdBTlRkQm54YStzQ2JnektkczZsV3Z1bEkzeEw4czFrTjlw?=
 =?utf-8?B?YVZINFhUNmFGUnB1SlZzbmZSNndhUmdXTUR1TTJXZS9CcHNUSnlVcSt5MlFu?=
 =?utf-8?B?WFJUNm1LOVJPL0VwV1MwbStNYWx1OW1oNUszaGlKMlZudkZYanN2cFVKS3Va?=
 =?utf-8?B?eWIwY1RQeUpsRnBFdklBa1ZIa0xtU3I0cGxaR0l0TkRlamQwZ3c4dDdwSFQ2?=
 =?utf-8?B?aWRpSHdxbzVJSWxJRUdwT1FYcCttZ3FRSWUwWmo0NWQ5bDlIb2x5Y2R6WTlM?=
 =?utf-8?B?LzRPcHR1NTc3RXYxb2ZSbFJ0UVJ2QW1xSGd0dE5xZVlXZmFxK0o5NEgwaEtP?=
 =?utf-8?B?SXBHeGVHdk1qOXl3amx1TmtNUTlmVjkxdHNFWjdiTUZxNHdLV1IxQkJIci9r?=
 =?utf-8?B?aEhMaFdTWlZqUEpKaUF4U0R0eEF2Yy9ZbWo1eUd0eVVYUXRpRzc4dDFqZ2dY?=
 =?utf-8?B?bGxPckVBTExkY0poZmlubHphWUxmNjhtU3QzVWM5Rm9uNkdFUk00RjNabnNj?=
 =?utf-8?B?R0lVb0JKRXA2MkdSZ0FTZTRERVR3UEluUEhGU3hxZEpGUFFQUXg1dnowZmxj?=
 =?utf-8?B?Y2daWmprU3NHLzlIbTFiOC83WW8zWU1aV0hORUhRVnNYVnF3M0FpV0l1SjhF?=
 =?utf-8?B?NWRXTzlUUXVXZEF0Z0pLYWxSM2JpWTNzNkVLWHcvWFd0Vm1tZG4wUXBzaGdI?=
 =?utf-8?B?UURoc2tPdXVPSjVPY2c3Ullka2RkWjI4Tlk5K0pPYnkvTG1teFlaTE9xVlds?=
 =?utf-8?B?djJRN3FCVVI2cno1N2VsM0pWUWxMM2w1eGYyOEczVkhNcDNla2VqL05QdGh3?=
 =?utf-8?B?KzRRT2FUQk9QUG5NczZzd0dkU00zcXRxMW8xeDA5NDBvWXQ1UGFjcGM2eGw4?=
 =?utf-8?B?N2hucEZHcXczV3lPSGR1KysvNlpYOVVPcDhlZEJRUXYrWEVjdkI2amlqTXZ0?=
 =?utf-8?B?Z0xUV3NNcW42Z1hGeTB0WkduWitzTDZFbHlQOFdMS3dnUnRaZndtbEF3MXAz?=
 =?utf-8?B?RDhZQU1WcnRsUjAxbTd4OU92RzhzdjdySjFzeUtIRGYyOVRWc1JuSXJIblpl?=
 =?utf-8?B?c0xkaHF6b3kwSDNuN21WNEcwT0NPV1pOWlR6Y2lPcmRuajlCek90YWtXMGJF?=
 =?utf-8?B?dzNUd2EwUFQzbUlNVEJJWmdSRW1rcHRXVlhDYmtvZUVveUQ3L1RrTEhFRjRY?=
 =?utf-8?B?TFZ5OXk5anB2YWMvQ3FHV0RWK1UzNHFWeWdCd09LWGJ0QWVubE9LVCt0N053?=
 =?utf-8?B?YTlTRWpJbXRGMXEyTEtCMHhDaHhNMUlsd2htU09MZlBqRjVzbEhiaU85a3Bp?=
 =?utf-8?B?ZVEwS2k1VXhYYjhXTEpGdVNZcTUwYy9DWEZoMlBQSFFZbVdEWlJRdkNpMFox?=
 =?utf-8?B?NXNWLzJ1UHpjTzYranNER2tlV2RKa3ExYmVIUTRsRTFrTVFZaXFlMUxyVnN3?=
 =?utf-8?Q?W4fDLklp5Khl5Tqvs6mcwInfj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f51adf-e35c-4a58-24c7-08de22151fa5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7018.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 17:58:45.5823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tA48IMNxccspodi556HmWQ1k7NROeg4YvGz+FtkHa29l4vlnZdSNNnQBAhm5k2WL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7694
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 12 Nov 2025 18:05:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2497

I don't completely understand what is going wrong here.  Some comments below to the patch that might help me understand it.

On 11/11/25 7:59 AM, Hongxu Jia wrote:
> In commit [fbaffe9 Handle rename(3) across devices.], it defines function
> pdb_update_inode to change dev/inode for a given path -- used only by
> RENAME for now.
> 
> In commit [58e4171 xattr work: handle deletes and renames], in function
> pdb_update_inode, it defines oldmsg to test the existence of msg->path.
> If yes, copy xattrs from oldmsg to msg. If both of oldmsg and msg have
> the same dev/inode, it caused duplicated xattrs in the given path.
> Here are the reproducible steps:
> 
> 1) Create a file in rootfs
> mkdir -p rootfs; touch rootfs/file
> 
> 2) Use IMA/EVM signing utility to set xattr
> evmctl ima_sign --hashalgo sha256 --key path-to/ima_keys/x509_ima.key --pass=xxx ./rootfs/file
> 
> 3) List xattr, get security.ima
> $ getfattr -d -m ^ -R -- rootfs/
> - rootfs/
> |# file: rootfs//file
> security.ima=0sAwIEOI1nBgEASdQgr4UDRTIYmF7q5SHFsyt3J/TO0Pwwz/hDiV3m4kjWALSKGC0Ea7wel6cZ1CcA/hQQ6gW5e86kswTCFexmM6qdE1MVG1IrP1L9YZcpJ3Ghh5bJS8S7Kb/J2FCaaPW9skGn8vG339CRHUuNz2z6uy6pryjLAVoAyl0jdqDlUTmhzfd7Bq6i1HLGSyBxm9nPwFDe4E5ubpwJlrN11YHUJSWVoAmpMfPLgu2bDalAz/I6tTMFdrEoR7SH0F9LuwKGnq4CAzrpsts/8/islsKWWPmmalv635EGG/k7g7zY0D/cHjc3YyaMYtvd43OWbTu+2j6w8IywmaZXN/YZg4AMgw==
> 
> 4) Rename
> $ mv rootfs/file rootfs/rename_file
> 
> 5) List xattr, found duplicated security.ima
> $ getfattr -d -m ^ -R -- rootfs/
> - rootfs/
> |# file: rootfs//rename_file
> security.ima=0sAwIEOI1nBgEASdQgr4UDRTIYmF7q5SHFsyt3J/TO0Pwwz/hDiV3m4kjWALSKGC0Ea7wel6cZ1CcA/hQQ6gW5e86kswTCFexmM6qdE1MVG1IrP1L9YZcpJ3Ghh5bJS8S7Kb/J2FCaaPW9skGn8vG339CRHUuNz2z6uy6pryjLAVoAyl0jdqDlUTmhzfd7Bq6i1HLGSyBxm9nPwFDe4E5ubpwJlrN11YHUJSWVoAmpMfPLgu2bDalAz/I6tTMFdrEoR7SH0F9LuwKGnq4CAzrpsts/8/islsKWWPmmalv635EGG/k7g7zY0D/cHjc3YyaMYtvd43OWbTu+2j6w8IywmaZXN/YZg4AMgw==
> security.ima=0sAwIEOI1nBgEASdQgr4UDRTIYmF7q5SHFsyt3J/TO0Pwwz/hDiV3m4kjWALSKGC0Ea7wel6cZ1CcA/hQQ6gW5e86kswTCFexmM6qdE1MVG1IrP1L9YZcpJ3Ghh5bJS8S7Kb/J2FCaaPW9skGn8vG339CRHUuNz2z6uy6pryjLAVoAyl0jdqDlUTmhzfd7Bq6i1HLGSyBxm9nPwFDe4E5ubpwJlrN11YHUJSWVoAmpMfPLgu2bDalAz/I6tTMFdrEoR7SH0F9LuwKGnq4CAzrpsts/8/islsKWWPmmalv635EGG/k7g7zY0D/cHjc3YyaMYtvd43OWbTu+2j6w8IywmaZXN/YZg4AMgw==
> 
> This commit:
> 
> - Due to oldmsg is static variable, clean up the memory of oldmsg
>    to avoid dirty data from last call.

See below, but the memcpy of the new msg should both setup the oldmsg and clear any old data.  It was expected that subsequent calls would clear any specific data we didn't want preserved (for whatever reason) -- See below.

> - Other than copy the whole msg to oldmsg, only copy path and
>    pathlen from msg to oldmsg, use function pdb_find_file_path
>    to fill oldmsg->dev and oldmsg->ino if it existed
> 
> - Copy xattr only if the existed oldmsg have different dev/inode
>    with msg to avoid duplicated xattr for the same dev/indoe
> 
> Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
> ---
>   pseudo_db.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/pseudo_db.c b/pseudo_db.c
> index 8b23938..d6ae1d3 100644
> --- a/pseudo_db.c
> +++ b/pseudo_db.c
> @@ -2188,10 +2188,13 @@ pdb_update_inode(pseudo_msg_t *msg) {
>   		pseudo_diag("Can't update the inode of a file without its path.\n");
>   		return 1;
>   	}
> -	memcpy(oldmsg, msg, sizeof(*msg) + msg->pathlen);
> +	memset(oldmsg, 0, sizeof(*msg) + pseudo_path_max());

Originally we did NOT memset this, as we expected the memcpy to overwrite any existing memory.  This is why the memcpy was the entire old msg to the new msg entry.

> +	/* Copy path and pathlen from msg to oldmsg */
> +	memcpy(oldmsg->path, msg->path, msg->pathlen);
> +	oldmsg->pathlen = msg->pathlen;
>   	found_existing = !pdb_find_file_path(oldmsg);

The function above (pdb_find_file_path) was supposed to clear items from oldmsg (as necessary), basically resetting the dev/ino and any other stuff that this function cares about.  (That may no longer be true, I'm really not sure!)

I'm not against memset and then partial copy, but do we need any of the other fields?  This is the part I'm really unclear about.  (Especially uid/gid/mode and op.)

> -	if (found_existing) {
> -		/* we have an existing file entry */
> +	if (found_existing && (msg->dev!=oldmsg->dev || msg->ino!=oldmsg->ino)) {
> +		/* we have an existing file entry with different dev/inode */

The above change looks correct to me.  I'm not sure why this wasn't done original, maybe an oversight.

>   		pdb_copy_xattrs(oldmsg, msg);
>   	}

if you don't do the xattr copy then is the issue that we have 'junk' in the 'oldmsg' that needs to be cleared?  Or are there other fields in oldmsg that are the concern?

Unless there is a specific reason, I would rather copy of the msg -> oldmsg and then clear just the items we do not want.  This should clear old data and give us a known starting point for the "new" oldmsg.  We can then sanitize/memset/clear whatever fields we don't care about.

>   	sqlite3_bind_int(update, 1, msg->dev);


