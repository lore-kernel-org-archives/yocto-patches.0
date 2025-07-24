Return-Path: <Yash.Shinde@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89830C83F26
	for <webhook@archiver.kernel.org>; Thu, 24 Jul 2025 12:02:23 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.10745.1753358542551277885
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 24 Jul 2025 05:02:22 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=93002d3b3d=yash.shinde@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56OBU2nC1026605;
	Thu, 24 Jul 2025 05:02:20 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4838wx0hxy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 05:02:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNww4GRKcWF7YaHxI3TqY5/SosOE2JIT+w2KNt1IFxHMB3RAy7a09ipFJpIbHEpX74eZ+Lqn5pFswPMekHOcvPnXaYmUekAZKQYCDwugaCRbvD0krGjOOqTSNfQmJXzdi+Rpdef5wSnBmTP49hPzD+IKqm1sienZTDIqcX/X62N4YL80o8bcSTSDfwz9UoYkKZYibO3GSflXVRzMdtw7IwlKv11OL4mw4vqiSMS6Aond0HYI6lLRuXe2SIirvOcQ/pOs3n/gkGl4qT8VTP5YY1QAyES7o/lT2spXLp0tLLzIID0cqoXM/J1ddYjti1MXUQnnOEX7Avd+bFHvsT/oXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwVDQlD1z0A8/+S50aWHvBlxTctzd3ncBOxWipiiPIA=;
 b=oqctJfqzj89paaseYrT934bgRvR6+QXVlNqvyeVyGPiczkUaPAVKQuviJBVzNbmjsAVk3l9BbOstwCM2VLIW9S0cPghKJ1fXjpTblrq8i4NirLsj9gO3fOuHCkNGjOmi2eeLqjjggo02wRH3Lke7DAiIlxuwYjvr6oWwYXsx4eOY66RJoYbXMP3wDVLAtZX2jU1TH57Kc+IhHvAvAyDU3B0NI+a3Ox2n8pdDGFVZ7ZtOUeoUUEg6tmFZ6weBI3IYyrQRYRdb7A4mHIeZ8pIt9vtDqT7bRfg+1uT9GUp0GzZEom1boY0OcDSK4zR2fjsBlYIqRJWnsTLMFwhzA/Fgpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB7593.namprd11.prod.outlook.com (2603:10b6:510:27f::9)
 by DS7PR11MB8781.namprd11.prod.outlook.com (2603:10b6:8:256::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 12:02:15 +0000
Received: from PH7PR11MB7593.namprd11.prod.outlook.com
 ([fe80::2688:e731:421b:5ebc]) by PH7PR11MB7593.namprd11.prod.outlook.com
 ([fe80::2688:e731:421b:5ebc%5]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 12:02:15 +0000
Message-ID: <eb816505-bd9f-4fad-92fa-65948a7700e0@windriver.com>
Date: Thu, 24 Jul 2025 17:32:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-lts-mixins][kirkstone/rust][PATCH] rust: Fix DEBUG build
 segfault with p384 crate on Rust <= 1.85.1
To: Scott Murray <scott.murray@konsulko.com>
Cc: Randy MacLeod <randy.macleod@windriver.com>,
        yocto-patches@lists.yoctoproject.org, Sundeep.Kokkonda@windriver.com
References: <20250709072014.1978605-1-Yash.Shinde@windriver.com>
 <a2703f2b-0c6f-4180-9395-e0e9c60cd0da@windriver.com>
 <1fde4016-2fa0-2b91-4024-7f84caa430fd@konsulko.com>
 <c387043c-e304-43f7-83a2-40b64ce301ab@windriver.com>
 <d52d7d4e-aa65-a4d0-840d-db8e4ec4465d@konsulko.com>
Content-Language: en-US
From: Yash Shinde <Yash.Shinde@windriver.com>
In-Reply-To: <d52d7d4e-aa65-a4d0-840d-db8e4ec4465d@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0157.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::27) To PH7PR11MB7593.namprd11.prod.outlook.com
 (2603:10b6:510:27f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7593:EE_|DS7PR11MB8781:EE_
X-MS-Office365-Filtering-Correlation-Id: c5e164f8-710b-4700-99b6-08ddcaa9ee29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SWpjTEhaYzVLQnByTWFOVHgxZ0Q1UEtQQVY0OEl6WkVNUFNKZ0s4SElTNlJy?=
 =?utf-8?B?dzM2cys5N0UrTXdvV2p5WUF1RlBVdUJ6SXhldkRqUWZsTHdoU0N1QnJrUGZ0?=
 =?utf-8?B?RWVtVnZlU1ljWWlXcXAyd1MwTjM2MmlxTmFRQ0hlQTNNbEErakpGYSt5dC9B?=
 =?utf-8?B?ME03U3Q0Q0FVUlBvSitoUkFtNjNLTFo5YnZhVjc0c2U3TEFoQ3FKOGpVcjRw?=
 =?utf-8?B?NXVEaGljdmdRNzN1ZjR6OStxUFVFYThHbnFVU0VKQVpVMUZYVWw5NGVHVW9O?=
 =?utf-8?B?WDBzMzhQSjRrUWRGajBzcVF1TCtMbWRmUUs2NkRiRzRpKy90YkFpSkV1ajl3?=
 =?utf-8?B?ZVpwOVI0U2FmUjRuOW8rSXcwTHhPTXoyOXVxbVdkVnVuT3pkbkc5aE1DRS9u?=
 =?utf-8?B?UnJ1c0h4N1VJcnpqdU1OOHdySTRvcy9wamxjREVwY0pSdHVqZlN5TkJRcE4y?=
 =?utf-8?B?OFpxMGN0RXdDa0dReUVnM0Q1bk1EcVJsUkZtVmJhQ3ZoWVFKWTNORElOeGY5?=
 =?utf-8?B?d0toUmRDVkJlNStjT1AreDZMd3BnZ3BFdWVocUYzWHV0QlBDVDAwVnlyMk1J?=
 =?utf-8?B?T2Q1bFdDNUFDWGRicUd6MUVzekQ4bytPZGRIak9kL0x1TDE5UFFPbEliaWQ2?=
 =?utf-8?B?Q2NIZkNYTUMzRHFvY3NrVnVMUGQrVTJjazNSVm9DOG1STkhTZ2JlQlB2UXlJ?=
 =?utf-8?B?Nk50NlRyUlZkZEpxRndvZjkwMkdYQWN2bysrcGdWcFhxWStxVXoyV01xdWFE?=
 =?utf-8?B?RzRsRzlOQnQ4YW9WQ0ZpMkNHdklDcXYyUWFvcHRkTmxZZll3bjhTdTl5OE8y?=
 =?utf-8?B?V0x1MDFldGl6b3RPcnRwMkJMRGhnUXlzRGZXdEZ0bkNmWXNHNE8zMjgwNGhN?=
 =?utf-8?B?THNvVytlcWM3Q2R4bjFYRTArVzlrUkNLQW1WVm9GS3lJbEd0YjZ4ZVBqR3M5?=
 =?utf-8?B?MGpody81YVVxYkpSR2s5WG1lRWtoOXk4RDVZTjhZTHh4RndaNjIrNkdsNDNR?=
 =?utf-8?B?cU03WnN2cXR0Z01jV2xIdzhCWjJvRVlDQTZiZm8rTTJ2dUtvamhCZ0psUGg4?=
 =?utf-8?B?OFBUck40allIUnN1Tzc4dHNta3diZERTUnBCM1o5NllIM05lRFV1U0lyZElR?=
 =?utf-8?B?MG05VGZBNW9vMlJ0Q05ia0syMnUyNTZDVWNRangzaUFnbGZ3VGk2Mmp3RlpU?=
 =?utf-8?B?akFrRmR5OXVvR0xTQmtlM2hFalZ3cE5wTGZHTEEwUlNmK3BRYXQ4Mjc0S1ll?=
 =?utf-8?B?dzRtZ2szYm5hOHdjM3RUaHdhWW9TTVI2TVFqK3hvUWZUQ2NiK1Jrd0lOaVl3?=
 =?utf-8?B?OTdxNVIvMGg1MC9ySkdaMVhNYWg3SlRQZGt5VDkxQ0Uydm5Od0Fjc2pTSTE1?=
 =?utf-8?B?U0pvbFl3bmhlaE9RS01VOVZUcmxWSklpUUUyeVdOZ0xicXhiVUpkc0UxUFg0?=
 =?utf-8?B?V0ZieXNuRUdZSlFUTEJnY0xMU05vUzRTRXpPOExBb1RMVFNiSnR6dlFjZEJs?=
 =?utf-8?B?c2NxbjNGd3NQNmNjQW4zamxPc213TjNvbTVtSE5YMERad2NCRi9NcGhQdFRM?=
 =?utf-8?B?dFNRVEJQSmNvNjJMVGErUDZmYno3cU1OLzEvbnZWU2ZDT0pxNzN0ZG01SGlZ?=
 =?utf-8?B?V2I0UlJDSHFQU3AwYlVNY1JsamNUSkVzSEI4Ykx4TlZoeXltR25BdGZRMm5Q?=
 =?utf-8?B?NGZzb0xMU09yanBWL1E3Qytka1Y4UHpFd2R3STV1eWZPNlRlb2RhdUtLcFM2?=
 =?utf-8?B?VGJVUFFtdmhYai9GRTFHd0k3T1F3ZUZ5YzR4UVErYk9laTF3U2hhYkVLczYr?=
 =?utf-8?Q?sejolimgVTaXT9AqOmJge2o5+FXBPt74DSoMI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7593.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NGNheFM5eTBRQ2tGYnUycElsYmFyamlFdFZuNnpZUisxMDBOWlBvbjZqcVNP?=
 =?utf-8?B?b01BcmsvQ3Nhc2V2SXREcURja25CbFFPb0MrTEJ0RWNnVEZ5N0wybFFLdm9j?=
 =?utf-8?B?VVpCRGwyVSt6VU0xV1NDOGhQeG1UaS9wYys0RnB0L1lVbjBqc1V3NXpwY0dt?=
 =?utf-8?B?ampDdXoxckR0cFRlVnd6YkpYZnNvT3BYaXRHMlhOZ0luZm05RC84TlplM0Js?=
 =?utf-8?B?RER4cEdvb0VrU1drNlYwQ0t3WEMvQ0R5ZGp6aXBVR2xiajllVnIxNXZYa0JF?=
 =?utf-8?B?aW8rLzlVK3ZJOUVZdTRhM2VvTjVOTWN5eTBjem01dGV4ZkJDR25sYStNY1Vj?=
 =?utf-8?B?S0xhbWVoVmFKdnlPMlJYcmFGNGF1TTlta0hqU0ZETEVyVUJ6Ukk4YllnZ29N?=
 =?utf-8?B?NVFlL2FRbkQyTE4xOUc0UEVlY2FJZVpzaE10ZFNDMnhFTU5XWDBGYjdZd3RC?=
 =?utf-8?B?aXkzSmJzYXA0RlpiVDEyRTNIbkg3M0hyVElOTGJURHFGQUVHOWY2TVd6Vmpk?=
 =?utf-8?B?WDVOVEY4K0N0MEg1RUgrUjNxZTZ0RTc1R2Q2WjNHM3gyOFNZMEIrc2NFdGRI?=
 =?utf-8?B?MHo4TWNlZStrT2xQbllTMzIwNnV2N0pGbEQ1L21OTThOMTNBZi82cWJYSTNh?=
 =?utf-8?B?NUttR0VnRmdPei93cU1meGZaWFV3ZzBsQk9HK0ExMEpqZmZLd3RuV0lGVHRK?=
 =?utf-8?B?c1oxYzhvWTNHM0dCa3BueE43angwWVlUZUpDU3c0YnYzTTFOQTNwMU95UGhT?=
 =?utf-8?B?VFNKQzlXQVMramhzc1QzS3JhVVpKY0pKZ0NTTjlXeitaY25oS0w1MFNHUEgw?=
 =?utf-8?B?d2JyYjhOOEtQSGtvWVk2U3lKcHlzdjdKUDZoS3VwYUxDZDFoSWR0eFpUUDNR?=
 =?utf-8?B?amNFSTY2bnVBMUZYSmcwenlLM0laa0Fsb1Azdkl2SHR6MlJNenJsQ3RIYW1L?=
 =?utf-8?B?RmZkSkhGMmszT21mS0s2cllMZkRCV0EvWGFLWEU0MTRjczdpSFV5MjJlUTNl?=
 =?utf-8?B?OS90dk4wVmFxaHo4NGJsUmpiQkJUQmtlMTN5S3djQjR0ZU9oWjBKVTlkRW9T?=
 =?utf-8?B?S0xSQjAwTkNGbmZqN3YzSDVjMnZPR0RRMExFbk1odzNEMlJ5Sm9vTG1sVHgz?=
 =?utf-8?B?aGZOOXowTTVRYmpFMWF3SWsxMkRiZGtpM1VUZVIxc2hIa0xpaGFQSEZzQnpZ?=
 =?utf-8?B?SmpTZTBtaVRRdVpnd2RLTXFzNlZOUFRiM215ZSs1ZUtOOStlQmh0SzJHSnh3?=
 =?utf-8?B?Z0tiNWwvaGFkNjZLZmZFNDR5aWxYS0pUYTlKcSsvUmlqQWpLOS9PT3R3cmRE?=
 =?utf-8?B?VlZsRnJzbS9VUGdQUzNmTkMzTEo1Z2ZnTnh0S1AySFE2UUc0enl3eC94U0pR?=
 =?utf-8?B?a1o5OHJuV01yNjRlZ1ZvdjRIYllrTzFXaGw2NnJ3ZUFRUVFoa0RFc1haTmF6?=
 =?utf-8?B?MUI4YXp2NXFKa0ZXdnF0Mm5lTVg2OGpKNkkvZlRUMGw1NmFIZFFGcTJNdm50?=
 =?utf-8?B?WCtHV0lTTlQ3emNHSERWWHY2a2lSR2tsS3Q4VGppZHNaMHRLT0F2VkFuUjZS?=
 =?utf-8?B?VDRsZ2ZZNDEwTkxtNlMzL2VqQVl5Yy8yd1dLbmJnZTZyeUFsV0hlc2o0UWZD?=
 =?utf-8?B?L0wxT2FyTzdpL01WV3pudXBud1hNcFVmR3p5eS80bmMwSVJKQlovdnRId1Jx?=
 =?utf-8?B?bWZxYVVEN0VKK2VzeE5sT3BmY2tJaUR2Tm93akVaWWZXZ2IxQmZRUHNvYm5K?=
 =?utf-8?B?WDIxZlFPTEthd05TcmtXNzZEaVFMU1llQ25UaGlUMzZQOHpoWTRHVEFzMW5m?=
 =?utf-8?B?L3NBNUhydERRQkJrczl6aTNnRVRhbGd2eGNpdkZYOE9iY0FHV3RKTkxKc1RN?=
 =?utf-8?B?dTZ5d08yeEtWdFY4b3Q4VFhVSnNuSzFWNDdYSjV6eG90UHZxdE12K3BSczdI?=
 =?utf-8?B?RnY1RmdMK0F1d3FNNDZnL2RxWkhzaVVqc0pkTkxFRUJ4dkN5ZWpzNlN0dXlw?=
 =?utf-8?B?SXp6b0ZzU2R3c3J2c2VtYnN2N01YNm42Q1dyYVI1TllGYnhzNVVZV2NPSVBj?=
 =?utf-8?B?ZUZkbmZ1WTB6azk4U0xsYjhtL1FpWVNRVXJXTjNwd1hoWlNaNWh4MzdkTjlG?=
 =?utf-8?B?OTI1cjg4Vk9JazBzbEJpK3YyUnV2WGpqUG00d3h1eWcxMTdCYlo2dGNtOEtT?=
 =?utf-8?B?bFE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e164f8-710b-4700-99b6-08ddcaa9ee29
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7593.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 12:02:15.3826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUIvA9bD3HvrQut6qFlZN043uYWerfjVNspaOzs6Q7VzD1o9Bb1P0+ar4xSwM3UD4MQLuyjlHo9Jks2Y896Uka3L7F/D95VikbtQ/wmdJQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8781
X-Proofpoint-ORIG-GUID: XW4D_dATXQ325AI09MFNCDix9q99NAbf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA5MSBTYWx0ZWRfX/CH3GYMnBxBJ
 jWjtgpxePm7I8MxLIcgQEao4JxTs+l3R2V7UiDFg16w0vePGnJkv8RjXRgxcwKyqNx+a4IqWZ40
 6MQrRlAAiRnPhth+xRu246FgMITbknQkHtjb7a8H+TkOIYPFAH1xr4tjF+HHEJ7J9itRobuqJek
 X+BcEo/9iZblbbsmDYgCHmkEkrw2fsY6EJMbRptFbJv6V03RIwi3aDenak04eaXIGyvM/lBGQA0
 +0ximM/mn6K8f+pMEtRwbMwFsnvCqlNKONOhtmHzy8v7dnhrESdBlbmADh4JTxsIVk9IvYhhvHX
 WCHzgemozUTVvCXkouHisXKkSgoNwOkXlopSB6d68wecfWViRR2dLVLeCvk9efyM3TH4we6Na9u
 70MJuBmD
X-Authority-Analysis: v=2.4 cv=Gq5C+l1C c=1 sm=1 tr=0 ts=688220cc cx=c_pps
 a=G/f7CVs2BYO5tXAmRrmQYQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8 a=DSPEhs5zvSOYu9N4esMA:9
 a=QEXdDO2ut3YA:10 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: XW4D_dATXQ325AI09MFNCDix9q99NAbf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507210000 definitions=main-2507230196
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 24 Jul 2025 12:02:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1868


On 24-07-2025 00:40, Scott Murray wrote:
>
> On Thu, 10 Jul 2025, Yash Shinde wrote:
>
>> On 09-07-2025 21:18, Scott Murray wrote:
>>>
>>> On Wed, 9 Jul 2025, Randy MacLeod wrote:
>>>
>>>> On 2025-07-09 3:20 a.m., Yash.Shinde@windriver.com wrote:
>>>>> From: Yash Shinde<Yash.Shinde@windriver.com>
>>>>>
>>>>> Backport a fix to address a segmentation fault in DEBUG builds when
>>>>> compiling\
>>>> No, too much of a change.
>>>>
>>>>
>>>> Sorry that I wasn't clear, I wanted you to provide the two line
>>>> change that changed the debug build into a release build.
>>>>
>>>> Scott,
>>>>
>>>> Will you take that?
>>> I prefer to take changes that are straight backports from master, but
>>> I'd consider a less intrusive patch (i.e. the 2-liner you mention) if you
>>> have a real hard requirement of supporting 1.85.1 with it versus being
>>> able to go to 1.86+.
>>>
>>>> At some point, we'd update to a version of rust that has this fix - 1.86,
>>>> right Yash?
>> Yes, right.
>> I have sent the 2-liner patch
>> https://lists.yoctoproject.org/g/yocto-patches/message/1799.
>>
>>> I've been a bit busy, but plan to try backporting the 1.86 and 1.87
>>> upgrades to the mixins next week when I'm back from an AGL event.
>>> If you're okay with waiting another week or two for 1.86, that does
>>> seem a better approach.
>> Thanks for the info Scott.
>> It would nice to have rust 1.86 and/or 1.87 in meta-lts-lixin layer which
>> comes with fix.
>> Meanwhile, we can apply the 2-liner patch.
> My apologies for the delay, I have just sent a patch series to go to 1.87,
> once it gets merged (plan is tomorrow) please let me know if it does not
> resolve the issue.
Thank you for the v1.87 upgrade. This should resolve the issue.
I will verify after the merge and let you know if the issue persists.


Regards,
Yash
> Scott
>
-- 
Regards,
Yash Shinde


