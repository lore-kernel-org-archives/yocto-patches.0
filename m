Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4811CD343B
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 18:05:19 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com (PH0PR06CU001.outbound.protection.outlook.com [40.107.208.3])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3572.1762969600110178940
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 12 Nov 2025 09:46:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amd.com header.s=selector1 header.b=oo7UzZZO;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.208.3, mailfrom: mark.hatle@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+pAPImx/ClgbrMwFn4zLWlHjbgztWlEi2rsOhLLWcw6bKIY9iaGwUGc6Rke2rtyHYbbFgSn5oOUjd/bqcqeGWgW+JwumdTZdmigRLIGGeF4Ow86Dw1iHipZZWay9d3JRMn4diLz0AWqaV1jmh1rUr4wJpfBA5rhgCy4KxF+ho+hm4MScT0bURq2UGAx1oWLFHqa98R6YZH/wsUAxHxStn5CQLlE+g9Ac0KsREVmv/pe1o0mR+BGuc9YBK1zx2tMSBEMumFVZInNVJSW5y9FeQ/g//hDWAqS8tfXzx4tQGawu94ak288YEYdX84fRL6gRBZ963l8gTQ6jCv+yZHZ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKk272RN1eTZLO1GRnV+adoqsK1N2bzoUByZexXBSzE=;
 b=AMU1H17FhQG3yoB2AKtUt0JLLtfqu+v3wmKZfayGazox+IZ/9wPOg4nbxwX8lquMVgrTjulWgrXCVDzlclBqiXl11iwwb2+/svisulw5i0zI5I0xOO4D6KKo1OP8uMMz/MT/ab4W6udPA/9U8GJJGqapnqKH4ptVGrgs7NEUzulOUgaMgFITPIscSX2Kzv1/e6mRWCwGePVKrAKfifsg/UvgLWP/TYyaEraqdV7qSc//OGzbur6wXI6kjDI1qV/V14AJstff52TP4nCbwtuGHfzR6ZvsZ9S3Cbd7RfNB3gJ73PMCr0MSP47WxrzFv9t9JTL73R2ORCqBY8Cu7//hEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKk272RN1eTZLO1GRnV+adoqsK1N2bzoUByZexXBSzE=;
 b=oo7UzZZOG4IKnjT+fkVjnpf7uCanjWxglwtwgELz0bJcCI2h/tCXtHyPmOdb+z7gWjrERbD/CR10TegSyeUjvktfazeZkXbwJjZ18xMeCH7xGoiwAMsZxLmbGZ+FD1nTpK0smT70ONPvK/03fQesRV8jf29sO9nzps4WhZ5oQkU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14)
 by SN7PR12MB7935.namprd12.prod.outlook.com (2603:10b6:806:349::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 17:46:38 +0000
Received: from PH7PR12MB7018.namprd12.prod.outlook.com
 ([fe80::e2bd:c56f:ea1d:9a11]) by PH7PR12MB7018.namprd12.prod.outlook.com
 ([fe80::e2bd:c56f:ea1d:9a11%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 17:46:37 +0000
Message-ID: <ff0a842e-cc9e-443f-8f8c-c7206a719dd1@amd.com>
Date: Wed, 12 Nov 2025 11:46:35 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [pseudo][PATCH 1/2] pseudo_ipc.h: make 8 byte alignment for structure pseudo_msg_t
To: Hongxu Jia <hongxu.jia@windriver.com>,
 yocto-patches@lists.yoctoproject.org, richard.purdie@linuxfoundation.org
References: <20251111135951.2121065-1-hongxu.jia@windriver.com>
From: "Mark Hatle" <mark.hatle@amd.com>
In-Reply-To: <20251111135951.2121065-1-hongxu.jia@windriver.com>
X-ClientProxiedBy: YT4PR01CA0286.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::6) To PH7PR12MB7018.namprd12.prod.outlook.com
 (2603:10b6:510:1b8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7018:EE_|SN7PR12MB7935:EE_
X-MS-Office365-Filtering-Correlation-Id: 92f4f445-338a-4962-4e9c-08de22136dd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?T0JmSmd2bjhWR1RnQTVVZDY3a1BDL014MXdWYVlSM2U5MElUZmNDSk90UjBt?=
 =?utf-8?B?TFFvNDZmU0pNdnFPNk1nK2lqK3J1R0JxQmZUTk1EK3pYeHJDLzhCQkdWVU5o?=
 =?utf-8?B?QVMxNVN4QTZPbUFZVXoyVEJFaEtWbUI3ODJQbVNYMUh2eXRsS3Myb1ZZQk9o?=
 =?utf-8?B?ZUZpMmh0N3ByS2FxWDhqY3Q0em51RERmRk8rSmwwR3B1YzRrU2d6clA3L2dy?=
 =?utf-8?B?UmJ3VUhKd0Evajc0VEFwbzlPaFFXZ2tjb1ROanJsY3c3YU96ZjVJRTFRYnJJ?=
 =?utf-8?B?NHJqUGwvaVNIYW0xZm5KaDd1UThnS0tjM2Z4dU5rT0hiTmp5bVRPODFPaDB4?=
 =?utf-8?B?UnZjRTBQWDEwR25sU2hkTXAzQVFPTk5hYWFBOHFBYzNoUHNMZE9hZEsvZ0FY?=
 =?utf-8?B?Q0tieGRReUVlTG9IWkJaWitMVDF2bzljRWNBSnpIN0oyVjNodmtNNTVUT0VQ?=
 =?utf-8?B?VjRmTmFkVTNJLzdlZEx2dGx6b1kxNXExaThYbGpTd2xUSUluM1ZrTmVvYW9s?=
 =?utf-8?B?M0VCQjExanVuK1lHemhoUjFzNWpnRWJZc3JPMjNrL2REK1pwcis1T28zVVBh?=
 =?utf-8?B?eHg5aVRFemFUbm9EZ3U1YVloVDJoUFd6MVlyWHVsek5zUzV5QWVSRlQxUjA2?=
 =?utf-8?B?Ri8vRnVuT3VrVjNGYmE0dTNDQ2tIbHU5ZU9pSi9tWVBTbE1NdFNOdUIycTlz?=
 =?utf-8?B?clZ6R0tsN3FxcXpvb1dOcXlxZGhVSk5KWFQ4T1V4MStsQTZTeHREVmJqdlRx?=
 =?utf-8?B?K3lFeTNpUm5wTWlyNjhVV2x2dEJzaXBJV1AxZ3RlTS9wR2syaXhCd2g1eG5x?=
 =?utf-8?B?aTgzQ2lSemlKb2NJc3FRZjhJM045bktqWGdlUm1iYkE5c0Q0YnZSSW9YaG0r?=
 =?utf-8?B?d2FOR3BJRzhMZzJmMFF5NEFsUy9tRWR4SW9Tc1VCRFdIU1FYbHdLUSsvVllN?=
 =?utf-8?B?a0kybmhnUVFwQmUyY05ab1J2S3ErSTI0dHVlV25ZeXNVc3gzVTVtZkNaaWNy?=
 =?utf-8?B?dEkrZ0NUejhvMWgzWFdhWUtZS3BmRHIwSm4zci9XNWc3ZVlSM2VWbERQRWJO?=
 =?utf-8?B?aG5Ec0NFa2xsb3g0NkNnbzRqN0NPUlFCTmFHbEpZY2QxVXd6TW5lVUh5N3RS?=
 =?utf-8?B?V0Y2WmgvYUtNK250OFBzVzVVTVhqeHl2Q0NKekRSWWJsRWd0VTF4L1pmeStj?=
 =?utf-8?B?dXo1UnREMjZuM05IQzVQU3kwdG1ZZ1craXdZSmFLaDZyYW1tM0Voa3FJZ1Ew?=
 =?utf-8?B?eS9HQ2FtUHFIUnB2NFQ5MFBRTGZWd1pEcHdxK1R1N2xjMERXY1hIRzZtOWl6?=
 =?utf-8?B?TmVqaDh5YWMvNTNsREpuTGwveXJ6MG9WOWVsaURtczFQQkYwZXI2YVNPT1BJ?=
 =?utf-8?B?azRHRXErenFsUDJUeDlUOXlYTUVsNWkxa2JnSExMcXQxVmdoKzVQejdKem5T?=
 =?utf-8?B?YnVOdDJZU2VSK3RoVVVRU254RzRYaDQ1b1FxaURFRExmc1dwckpPckdoNGd5?=
 =?utf-8?B?OHpKQTFHUHV3TUp3cEpVdnZzODljZ1lYOUFwMXJibERQZi9aM0pjeWsyVm5Q?=
 =?utf-8?B?bXlZZlphdnMrU25SZXUrSmVQbjdRNU0xZUNXdHhtVW90TmlWT1VmUzNtbnNU?=
 =?utf-8?B?WUVVWnlWN0dYNHdXZlErRWFrUndocWRnWFVhakdteDlnd3dHNFJJSi9CVUU4?=
 =?utf-8?B?bTc5dVVwT0dscEJpckNweG9pOVMwYTM1RFl1dWNVdTVsc1cyaThkUE5SV2pD?=
 =?utf-8?B?bEtGWHJOLzcxTkJKbncrUm1xMmRvdENSVFY5Q1lMdUMvTzMzWGErNkVobldy?=
 =?utf-8?B?QXFkN1A5Q1dEZlZxUVVKNUNlRG9LVWlxT2tqOUhPZkdUS0wyaFJqWjVBVmpr?=
 =?utf-8?B?eEFBbk5hdHBsaG10ckhvMXh2YmNySG5SS2IwRWkyMmZnazJTMk1sbWVaWlZM?=
 =?utf-8?B?cnl5dG84ZE1HOHd6NTYwTncvdkpXdjhJOEc3MUkxU2FSNkREWlAzMy82Q3lJ?=
 =?utf-8?B?TUt4WG5lWGx3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7018.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VVZWWWZRMlRNandaN0tRRU80TldTYjVRa25kVnZVQ3VLRTFGNFR0Rm9kSXl3?=
 =?utf-8?B?R3gvaE5JZEhjNkxkZklyRW01OWJxRHlKaERheWsyS3lHVU5DRGlWQUNZUlFa?=
 =?utf-8?B?RU5QcjQ4Szc4Qjd2K3FXWVBEa1JSZVNzZVFXblgvNGtHRCtXTnVRRnZzR1VM?=
 =?utf-8?B?V0dkZ21mSHh4a0IvR1dLNWxDbVNIMGtlZHY3QWV0QTNIcnMrWC9uQWVQakFV?=
 =?utf-8?B?eHVHRmtaOE9Ja2xBTllPQWxvZmVndCtoYnlVNThPdmh1cFIwWXJScnJGdnlP?=
 =?utf-8?B?SUV3SlhYejVxKzE1RDdlWjBzZmV1WXBFQm9lWG5iQUU0NlBVUzJ3NTdNV1dy?=
 =?utf-8?B?R0lhVThVWitVUmtVL0FXdk5oQmlWUE9qSWtiMWdBMHdmTEtQY0JvV1dmU291?=
 =?utf-8?B?Y0hMWlFmalJIUmRhYk90VGNiSDdpZE1SSnVDTktNNVFWc3E5MElmK3NnOFg2?=
 =?utf-8?B?Y3piQlUvc3JUYmMwTXBiU1NWM1ppNlFjNjFQYlVqQkFubzNxdUtrSzAvczBt?=
 =?utf-8?B?Q2o1eUoxZmJBMWpWQktITlVTNWFEb2hsaEl5emRPcFQyWmxOZXZLSVA2b3M4?=
 =?utf-8?B?ZWl6NUJONDc3cnlrOHJEdU1HRzd1K0d3RE5xOXh1aDdjVjR4S1AzVlVYYjFC?=
 =?utf-8?B?VEQyaDBIcGNNMmV2WlJFVndtR2ZNaXBSUGdBakx6cjN2QWlaaW53ZFZ6SHVp?=
 =?utf-8?B?QUNjZ1k0VmsxTEtJQXB5dHRpcURCa0NSdkhZREtVSnlFUmlxYnBPMWVtQkZK?=
 =?utf-8?B?N2UvR3krbkd6M2NPL21wMEcxN0lzVW83U1BOLzI0OWNOc01GbmRCNVVwNlI4?=
 =?utf-8?B?OWVhZnd4aVYvekJCU3YrUE1BTDN1Z21jdk5ZWXM1K1JVdlcyV011am1FVzNU?=
 =?utf-8?B?Y3JWV05mRElUL3o5OEZKK3Z0b2t2cHlTaCs1UyswV0RrOGZMcFdjMXAwUEpN?=
 =?utf-8?B?ZmVzNHdsTUNtcWFNWUdFNk9TK091djQraXR2bTc2SGVHazBMWm9Idk0reWI5?=
 =?utf-8?B?OGx1NEtFcEozQWs1Vnl0L0Q2K3dEUXRhalJFRjhEZXJUVXJVcUtOV3lZVmFt?=
 =?utf-8?B?WjdXcU9hV2I0Smh2b3g5ekpLNFFRczJ2QTJCMFlmZnhSelcydlZLZnFDYjJC?=
 =?utf-8?B?VnpzQ3hoOWsxQTFHS3hpSzJ5c25LL2QvRTdFMGtuakphOHRjMGZvUzM5Nmk4?=
 =?utf-8?B?S3R2enlvVURvWDN6ZkhRd0grWW5nUTFhbmhVZWpvbS9QRVZ3OTFSTGNGNEgx?=
 =?utf-8?B?WWFxVzZHRGllU3hJdG9qMy92ZkdCckJ4QVgwaEI0Lyt5YktjTjlPb1cwN3U3?=
 =?utf-8?B?b3JkRnFxTUNhdTFyVVQ2cUxnT2dXdlJ3MmVYSDNSaDRDWWl6cVFFdlQvVkQx?=
 =?utf-8?B?U3Y1YUpNL216SGxXZVF5SFFqTC9pbjZ2YThUR29xN3haa1loR21zbnozeHNm?=
 =?utf-8?B?TlpMaXBiZmNUT0xaanZvOElVZzhTc1hScW5MUkdCUzBIOVRsZmpmLyszMnJR?=
 =?utf-8?B?QzEzMGExWld0QXFiNFhCUmxOT2RVeWVjNlppcXNwOTcyWTZ5c0d4NUMxa3Jz?=
 =?utf-8?B?YVprdjZadGNqV1YyODlkTzJJRjBiU211QkU4YTRCU0NkdnQwQ081VkROWXV6?=
 =?utf-8?B?VkllWCtZRnZvSStzT09xWHhqMCtZNDNpZ1BmeDdzY1dlM1Z1WFBGOVpYcHVU?=
 =?utf-8?B?VUZPb1F2VjNabEtjNlVWaEhVSmhVU0R5N0VDZGN4NklYM2JmSjdnOU43V2Er?=
 =?utf-8?B?YVZIY1VLVU9kYlZabUVQNEN6MURuWHE4bFpTdnpqczgyVE9xeG1vejAzRWVi?=
 =?utf-8?B?aTVPbkVpVG9OYnowZExkMTJINUgwWDBMU2ZsdzRnYkphVkx6My9CV3d2eVBE?=
 =?utf-8?B?aFd3NlpkeDdRSjRrK0JKUFE1ejEya2pKY2xDajVML0pXbDVVbHpsNFVnMGF4?=
 =?utf-8?B?bm4xVnJ3S0FqSjNXdzVzOEU4VndMT2F0L3FFM2ZtLzEydUJERjJrUHZ2MG96?=
 =?utf-8?B?OUw3VmhnTzN6aENyNlVTeUNRVTRXbHQ4dEwxZzhDc25tY3h6VTU0K2NtL25j?=
 =?utf-8?B?YmVDY1pjRUE4d0dCMk0wS1ZKMzdONTA1MDZ2ZDRLREx3T0lqSERpalFjUGFQ?=
 =?utf-8?Q?KSByANBzGnzMP+6lDyXjQKV5y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f4f445-338a-4962-4e9c-08de22136dd2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7018.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 17:46:37.7951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f1sTT9/SKP5zpfXl4YTl6Rfi9epoEFYZU8tGBvZEjWHRAu4zinWlWHXwE00VQJrM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7935
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 12 Nov 2025 18:05:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2496



On 11/11/25 7:59 AM, Hongxu Jia wrote:
> typedef struct {
>      pseudo_msg_type_t type;
>      ...
>      char path[];
> } pseudo_msg_t;
> 
> The [] item at the end of the struct is a C99 feature:
> Flexible Array Members in a structure in C [1]. The size
> of path in structure should be 0.
> 
> On 64-bit arch, sizeof(pseudo_msg_t) = 80, but PSEUDO_HEADER_SIZE =
> offsetof(pseudo_msg_t, path) = 76, the reason is 8 byte alignment
> in 64-bit arch.
> 
> The differ between sizeof(pseudo_msg_t) and PSEUDO_HEADER_SIZE
> made memory overlab in memcpy, such as
> 
>    memcpy(oldmsg, msg, PSEUDO_HEADER_SIZE);
>    memcpy(newmsg, old, sizeof(pseudo_msg_t) + old->pathlen);
> 
> Add 4 chars to structure as reserved for 8 byte alignment, then
> PSEUDO_HEADER_SIZE = sizeof(pseudo_msg_t) = 80.
> 
> [1] https://www.geeksforgeeks.org/c/flexible-array-members-structure-c/
> 
> Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
> ---
>   pseudo_ipc.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/pseudo_ipc.h b/pseudo_ipc.h
> index d945257..2836cc4 100644
> --- a/pseudo_ipc.h
> +++ b/pseudo_ipc.h
> @@ -26,6 +26,7 @@ typedef struct {
>   	unsigned int pathlen;
>   	int nlink;
>   	int deleting;
> +	char reserved[4];
>   	char path[];
>   } pseudo_msg_t;
>   

I think it would be better to use the alignment operator instead, specifically:

         unsigned int pathlen;
         int nlink;
         int deleting;
         char path[];
   } __attribute__((aligned(8))) pseudo_msg_t;

In my testing this results in the same 80 byte length for both 64-bit and 32-bit systems.

I wrote a quick test program for the addressing:

64-bit:
Address: 0x4379d100
       type: 0x0
         op: 0x4
     result: 0x8
     access: 0xc
     client: 0x10
         fd: 0x14
        dev: 0x18
        ino: 0x20
        uid: 0x28
        gid: 0x2c
       mode: 0x30
       rdev: 0x38
    pathlen: 0x40
      nlink: 0x44
   deleting: 0x48
       path: 0x4c
Length: 80

32-bit:
Address: 0xffc2a828
       type: 0x0
         op: 0x4
     result: 0x8
     access: 0xc
     client: 0x10
         fd: 0x14
        dev: 0x18
        ino: 0x20
        uid: 0x28
        gid: 0x2c
       mode: 0x30
       rdev: 0x38
    pathlen: 0x40
      nlink: 0x44
   deleting: 0x48
       path: 0x4c
Length: 80

This seems to address the issue and the offsets within the structure are maintained as expected.

--Mark

