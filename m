Return-Path: <hongxu.jia@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05F1C36010
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 08:13:37 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.41335.1744013611548864194
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 01:13:31 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=6192bc662b=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5374VAM4005017
	for <yocto-patches@lists.yoctoproject.org>; Mon, 7 Apr 2025 01:13:31 -0700
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45tyt49sqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 01:13:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAlpRR4dOOigqiUfvBywxntvkTujaEa9zBUl3EIGMpWkv6S7DtbIjAZ1MxibxtJ0PbRZ6GJ/czBQQ0g3I7nlAYg5r4fwp8/dFVZUlukKn96Q0Pbr4Ia1cv5v4T5SErOjvUQA6pbmEKrCA2pkclBfE8ZGynhr6lUpK/mcJKlVFv5BR1XdUZgdO7nIm51kHGeanuu9iX4byT4ZmgTGY65BFve4ePFfFMsMWnqm1TFEfoBTl2KE8xTWccL4twxBrY5TZFLbLdgPxGwO7MYdbasFCn5dSI7n2RItPuc+yUE5+luNpT0urDb8Gf4O614K9eF7IrW3xbjTYT1jqIf1Be1usg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kYshy4ypF5SCR3XWdJKjnMN/dp1I5kpi0YrM6eorHM=;
 b=b9Nm4lXIQqxu40/U0jt8/5tPM/e3OGOPv1phWcAbrX5KmXcKHJNajGETUDv+lFIFIj+cF+XFoGrNQyl7PS3eBxhZI5lwYkwWUpRHmJzu1LxErcg2CES31CQyo7nRbJUGp0y9b6pinRSG8YtQjhArDac9nXs9Z+gndoj3LnaT4HU7XNfjbFRa7SAuZkS+P4s8hqeJm0hOLHhGP3VRK0Xa6XG1gkMS2x5iyE/shomVF7Hll/ija+WFS3HLzcKh4PHw4XCzstndfmVidgHv9rt+0CEq6K5WNgeXLyIMcYj1jthx+FneU8j2KjoRcUBLhKi6Zabxy7jiLoZ730GeYFLuUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20)
 by CY8PR11MB7827.namprd11.prod.outlook.com (2603:10b6:930:77::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 08:13:26 +0000
Received: from PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::ef64:bc9f:eb8c:e6e]) by PH7PR11MB7608.namprd11.prod.outlook.com
 ([fe80::ef64:bc9f:eb8c:e6e%6]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 08:13:26 +0000
Message-ID: <272a255c-94db-490b-9362-d641fcfa031d@windriver.com>
Date: Mon, 7 Apr 2025 16:13:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-tensorflow][scarthgap][PATCH]
 tensorflow.inc: add write permission to 2 more directories
To: yocto-patches@lists.yoctoproject.org
References: <20250307075610.2235124-1-martin.jansa@gmail.com>
 <182A7B773A5ECF09.13616@lists.yoctoproject.org>
 <CA+chaQf4K+YGtwnxi6eKQ4vmUFeWWOZScNEfqcKKHa-7xNas_g@mail.gmail.com>
Content-Language: en-US
From: Hongxu Jia <hongxu.jia@windriver.com>
In-Reply-To: <CA+chaQf4K+YGtwnxi6eKQ4vmUFeWWOZScNEfqcKKHa-7xNas_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SG2P153CA0026.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::13)
 To PH7PR11MB7608.namprd11.prod.outlook.com (2603:10b6:510:269::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7608:EE_|CY8PR11MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 14307615-db74-4ac6-a96c-08dd75ac126e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|4022899009|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OWFMQ1BBQkEzRmVsVXZnamhYZlNMS0F5ZDlFaGNVWjV4QzhRZ3hxcVFIWEVJ?=
 =?utf-8?B?SkZNa0R3ejBoV3pqd0kwV0pXSjRVR2JqY09KU2xraTdDaTlLdFJuZForMDJi?=
 =?utf-8?B?Q2ZhRnZsVXpKYUNsaVV5c01DNUFaUWMyTnRxMVJsa3lPZ0cxZWxnYVo1N1NO?=
 =?utf-8?B?ZGtrOVpjSG04cm9DT3k4V0tWK3ZoQWUzWEdPSnBuYkJpbnhCVGt1Zk5xQzRl?=
 =?utf-8?B?TGtNYjBYVXBoaUw2L0dyd2RVMGxURTRsQU14NXdRaEpvNXl4d1F5OW4wU2tT?=
 =?utf-8?B?REJPSW5Gck5jdmJnaUxZSzF0K2g2a2JIeDNsRHRiQjJrQWRWVlBZN0RGdFRR?=
 =?utf-8?B?UGp2aDloMTQ2RjNWZVJSeUFTYStrVTV0d2lPNzZUVXNHalYzSEpHMmlaVUF0?=
 =?utf-8?B?SGJJcUh3Y2pYdFczSlRXV0dlWml1RVNjNGkyR1JiK2JoTWgzRVFiOHVHa0tR?=
 =?utf-8?B?K0kyVEpEYkY1ekZmeUtHdDdwWWpmMTc4SWdLeHN3aEJCaEpIWUZzZkFINndo?=
 =?utf-8?B?ME5WaWJXUjVBcU13b1BQMXE2N2UyQVhGRWtuSldhc2RVZHE4MjRsTFo4MXVk?=
 =?utf-8?B?TDVLOXFYdVExYUVHQkZJZlNQU2ZtMTFhdGZQNmtrOXFQWU5qWSt5aWhtaTh2?=
 =?utf-8?B?WDdjRnkzekZqSm5ZaDRDMzRmWjZtdkMwZFY3THRDVnMwM2hFZGFqNFhnQ01T?=
 =?utf-8?B?eEFNZ2c1eTZFUjdCR3psemlNVE9sSUFUVUJDcDhBWmlJQWlqQzF5MDFmZ0hZ?=
 =?utf-8?B?L3hDYlM5cGxkOUFZS2ZMZ0FZdkJCQy9TR2h3aStKS05QVVZTK2lrc0VxbDZy?=
 =?utf-8?B?YTQzQ0U3R1lRdDJsRlZXd0xtMy9paytmeXNRTmNLaUtGaFU4Q3p3dUNmTERw?=
 =?utf-8?B?S255VG15TXIzbTF3cVdXc2Z4MEx1QkhzSnNBbnVmYXZZMlFCcS9HNDIzcnFK?=
 =?utf-8?B?eXV2YVpXbGpReUw4WnR2RzgwbzlHZDhUSFhGalNoeG1FRDl5dUlCd2RrUDRU?=
 =?utf-8?B?MjAzc2ZsVE1WOHQvU0RvT3BkZ2doOWEzODBMbFBOVFJVYVN5YmVHblQ2Rm5x?=
 =?utf-8?B?djAzWWYyUXlya1VDa3hFZGI3QS9oWEhqYm01S1RPdUJrYm5TVjBjZ0FEdEph?=
 =?utf-8?B?Q01VaERwR3ZrZHRCT0V1ZEhQTUZnZDRLT0tjK0JlUDdYZFIxYi9WTWFzWjND?=
 =?utf-8?B?NngwR25qbnBVM2Q4blRzWFdnTDU2UnEvS3NzODY3V1pscEJLQ1g1TVFjQzA2?=
 =?utf-8?B?Sk5sWmJXRTdRcjhpa0cxYnMza1lwUXVhUXhKd1ZEZFNZektCaG9tUGRta21z?=
 =?utf-8?B?SStnQzN3Z1pIY1dYL0Q3UVlnSU45OG9Fa3dwbS9IRXFDMHRLU0xrT2ZVZmJZ?=
 =?utf-8?B?RGVzUHYrS2pveWpldnhyek9uRkUzYW1ySDFidDA0enhYd0VhK3UxZTZlVDJR?=
 =?utf-8?B?YUdkOXhOZlRnZC8vZEc5Yk56Qngzc2o3ZDZBR1l5R1VxZHlhS2ExUTh1OUNh?=
 =?utf-8?B?MWNSbWpHbmdXUjQzWm5TNDVwRHpOREx0dDZtbGphT3VmL0dCT0tyaTlrUi9Y?=
 =?utf-8?B?bVhLeUptTG9kaytjaXRCZytidnV3UC94UzBtM1YzM0dWc3pGdmZtY1IxdEFY?=
 =?utf-8?B?Tmprc0xzdHB4SGF5TUJrbmYyYk9OUGMrblBZWkZoSzV6OGFjeWt4enJmOVYz?=
 =?utf-8?B?Vjc4TlBaNi92akZEclFCNEY4MXNGcjdsWFNhajZLT2U5dXo2aUljUmd1RUQ5?=
 =?utf-8?B?TXorcnZkd3A2YlBnSG50L0hQSUt6Y0xMRGZ6bGJha0YxUmgvWW96SEJ2SURC?=
 =?utf-8?B?SEs1WSt6bHY3OHYzazk1Zz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7608.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(4022899009)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cmp1d3ZxSEhVWGRkbkNyVjN2VlE4bktjTDFyRUNBTEpDdnpoTGJHL0Zha25I?=
 =?utf-8?B?SmxHUHp6MzUycTlFWFRoSzh1TC9SbmE5ajM1Zm5reFJodEpEQjE2V0xrSStW?=
 =?utf-8?B?RFlqSlBiUG9FOHFhK3dtL21FS01heDJUZ3pyTENUTE9nUThiVGVETkRzYTVw?=
 =?utf-8?B?TDkzQ3c0Rkt1dVhXOXRiYUt4S3NNTWZBVWlBcmVpb0dqZTErV0JQK1FKbExk?=
 =?utf-8?B?NnFta3I5dGVBdkQxR00wdGZUNzZQRmdsVUNra1QrV202MWxQbVhwdklHL3VI?=
 =?utf-8?B?MW5TS3cwRHkyb3hUOHFMRVNnSFhwdGRNNVQrVmx1NUJCdTRsblNvVHJsK0lq?=
 =?utf-8?B?bkFDZDB1TTVtNjdjM1VYRS9mVU82cGpUWUd0YWVNZ2xUOXN3TFJFVSsvSEZz?=
 =?utf-8?B?TnZaTWFKdXJoKzZ1bkphZFBFSkluWUxzU24rQ0VYVVp3UG91aVR3Ymp3eUVu?=
 =?utf-8?B?eEl1b2t6eHRkSXdjYUtFdVZMVlFmZ0dZT05qdVFPVWdrR0JidkRFaDA3YkZl?=
 =?utf-8?B?SVBLc0xHbUdNMHNaMHZCU09aYVZUK1pOamlYOGJJSlFVZ2Yvakc2UUc2VGZH?=
 =?utf-8?B?R0srWG9xM3hnTmRFb04yNnNZb1ZXRzd1QllBdlJEenl4SWEzTk9DQ0I4eWRy?=
 =?utf-8?B?enhhbnFFb1JJSzlhVDhnUHEvVXd1VXR6UitiWTJEM3EwRy9iKytQZU9UZWU2?=
 =?utf-8?B?TGZKd2JNUlc1aUpoZjZBcHk4ZU85akExMGtXNmJCR1YyYU1NYWk0eWRtbTNV?=
 =?utf-8?B?VVhidE13cEx6V0pydDNiUnNPeUxzMjYxUEJQZDBvNUpkMU1qTHBtRE5jNzkx?=
 =?utf-8?B?ZTVqZlJOK2pGdTZOVzY5WVhncUsvQlpWT2sxMzRMMHVRSU9NaENYTlVRRUs4?=
 =?utf-8?B?M0wvbmFobFFIZ2VLSnRJRHovNk9aWURudnpNMnhqdUVOOS9qeDJZK21MVys1?=
 =?utf-8?B?ZUlmejRxUDZqS3QvQlFoVWpvL1pmYW5xbUpjMUF2eWdNbmRNVmVaTFRtSnVP?=
 =?utf-8?B?czFMdmlSU2NGVE1RblBIZzhhZTNzczM3QnJyNEM1NXZ0azR0a1B6ZWZaZ2Ja?=
 =?utf-8?B?eDBFTnNtUmdiWUVQYm45OXpKTW9sSkNMZ3ZtUE9mMkhoWFlRK2tacG05QjVK?=
 =?utf-8?B?ejVIcGlJNnJBMHh5dWJ5ei9ydTE1VXN2bUgzYi9aRS9JY1NnZGtkQmg0SlRF?=
 =?utf-8?B?b1hoMGdUcldtSm9BaE5veDMraUxRb2EzOEtjY0lVYjJmMTlrK2pxRHkrMjJN?=
 =?utf-8?B?WURPVXBQWjY0bU9MZjhvYVBKOW8yQjJvbERGbE51ZG43TktkYW5LdkNrYmVR?=
 =?utf-8?B?RzhjZDR6bWh1bHkrQ3FubEJRUUZXc0NXUzNGalZFZE5qTDlTNW51czU2dnp5?=
 =?utf-8?B?V2s5T2tPSzBGLzNiNS9qcE8rQTF2cWpjR0V2eXo1ai9kREJBbUZPRDJ4RTFD?=
 =?utf-8?B?UEhyekkwKzZJWEh2WS9RVlpGOVY3bmtaangwN3hOcVZYTHpxYXFMNFlnVVkr?=
 =?utf-8?B?TlZCOGs4NFdDaEpPZmk1MEZYOXJqQXFQSVdja1dxV1RyaWxhbEJtdFFtWGNz?=
 =?utf-8?B?MTRjNElJbS9tQk4wRTY0SFFYYk8vd3l5Y01IM0tyYThYQW1hd3NjeTJhN0xx?=
 =?utf-8?B?Q1NzdStXZzVVUW95U3ZwUXJCeXZDYnJMOWRCMGk2b1ZCbHpJN2lzOW1tcmtF?=
 =?utf-8?B?dndhT0ZidDgrVlhsc0M3Tmp0cE5qS0J1LzM0QkRJNWt1Y3JaNFk4cHNId3pL?=
 =?utf-8?B?Q2hWWHM1YmRuc3kwYVZTdFVudW90TFVXM3VwckoyNFFoSUJ4aGVpOHc5VUp5?=
 =?utf-8?B?SEJQb00xdUFaL09udk5vSDlDdHR4Nm9pdXNJTzVmQ3EvRE9QVGNEaXZyR28z?=
 =?utf-8?B?Z0ZQcTIxU1hkVXNMVXR2Y2JycUZJcEcxRTJEem1pSk5PNkpwZ3kvMkR1cEpi?=
 =?utf-8?B?ZnFHVFhZQ0lGT21hbkRpYWpXaTk4TGZrbzNzeUxDbzlZV05Ha2Y3ckExSE5V?=
 =?utf-8?B?U3lUKzRmaFRSYkdUR2U5dEd1Q3NaanhlUWlzbUNsRDdGanR4V2tQWTgzZEVE?=
 =?utf-8?B?QWhQTUU2QzhreFVnTkJPbDczR3lpbGYvNE5pUitvMWRhclI3MmVWdDBDWnZT?=
 =?utf-8?B?RlF0aGZQeWhad1pSNTRGeUF0NFpBcG0rSGNXR0IvYlhTelhSUmZ5Nkxzc0o2?=
 =?utf-8?B?RlE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14307615-db74-4ac6-a96c-08dd75ac126e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7608.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 08:13:26.1969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xiVkoe3poh1j0w+jAW5PqPSHrZQQiEufKdo+95IlF8GrBLhx+HTzVPi8mLU/ON/YILxPq2L/ytxFVGQ9aGG8uPcDdtM7T6qk/HuZl1+H7fo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7827
X-Proofpoint-ORIG-GUID: nSGDJTVb51j5Z4zCGaOSBPN5wnyRD0bd
X-Authority-Analysis: v=2.4 cv=RMSzH5i+ c=1 sm=1 tr=0 ts=67f3892a cx=c_pps a=r1LLKbupV3Dgd2n8fS09vg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=iGHA9ds3AAAA:8 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8 a=J62WKlJcb4pkVYEW-ykA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: nSGDJTVb51j5Z4zCGaOSBPN5wnyRD0bd
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_02,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504070058
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 5374VAM4005017
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 08:13:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1290

On 4/7/25 15:27, Martin Jansa via lists.yoctoproject.org wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender =
and know the content is safe.
>
> Hi,
>
> in the last patch you've merged the author e-mail is OK now, but there
> is still the notice from Wind River e-mail as well as second From:
>
> meta-tensorflow $ git show -1 9e89de7 --pretty=3Dfuller
> commit 9e89de7d5e4a7e58e3ffa4cf81a3b96f15ec5c30
> Author:     Martin Jansa <martin.jansa@gmail.com>
> AuthorDate: Wed Apr 2 18:00:08 2025 +0200
> Commit:     Hongxu Jia <hongxu.jia@windriver.com>
> CommitDate: Mon Apr 7 10:19:24 2025 +0800
>
>      bazel: add whitespace around assignments
>
>      CAUTION: This email comes from a non Wind River email account!
>      Do not click links or open attachments unless you recognize the
> sender and know the content is safe.

Sorry for the noisy message, it was added by my company's firewall,

I need to clean it up more carefully at next time

//Hongxu

>      From: Martin Jansa <martin.jansa@gmail.com>
>
>      With:
> ....
>
> Regards,
>
> On Fri, Mar 7, 2025 at 10:32=E2=80=AFAM Martin Jansa via
> lists.yoctoproject.org <martin.jansa=3Dgmail.com@lists.yoctoproject.org=
>
> wrote:
>> Hi,
>>
>> thank you for merging both, the way how you're applying the changes
>> from e-mail still mangles the author and commit message.
>>
>> I've tried to add explicit From: in the e-mail body in hope to avoid
>> "via lists.yoctoproject.org
>> <martin.jansa=3Dgmail.com@lists.yoctoproject.org>" but it didn't reall=
y
>> help, instead the From: is still in the merged commit message together
>> with "CAUTION: .." message from your e-mail configuration.
>>
>> meta-tensorflow $ git show -1 --pretty=3Dfuller origin/scarthgap | hea=
d -n 14
>> commit c382865206fe925a02a1cdbdd856e16310bc9dbc
>> Author:     Martin Jansa via lists.yoctoproject.org
>> <martin.jansa=3Dgmail.com@lists.yoctoproject.org>
>> AuthorDate: Fri Mar 7 08:56:10 2025 +0100
>> Commit:     Hongxu Jia <hongxu.jia@windriver.com>
>> CommitDate: Fri Mar 7 16:16:58 2025 +0800
>>
>>      tensorflow.inc: add write permission to 2 more directories
>>
>>      CAUTION: This email comes from a non Wind River email account!
>>      Do not click links or open attachments unless you recognize the
>> sender and know the content is safe.
>>
>>      From: Martin Jansa <martin.jansa@gmail.com>
>>
>>      Missing write permission prevents the WORKDIR to be deleted, e.g.
>> when recipe becomes unreachable
>> ....
>>
>> On Fri, Mar 7, 2025 at 8:56=E2=80=AFAM <martin.jansa@gmail.com> wrote:
>>> From: Martin Jansa <martin.jansa@gmail.com>
>>>
>>> Missing write permission prevents the WORKDIR to be deleted, e.g. whe=
n recipe becames unreachable
>>>
>>> Removing 41 recipes from the core2-64 sysroot: 100% |################=
#########################################################################=
#########################################################################=
########| Time: 0:00:21
>>> Removing 35 recipes from the qemux86_64 sysroot: 100% |##############=
#########################################################################=
#########################################################################=
########| Time: 0:00:00
>>> ERROR: Execution of event handler 'sstate_eventhandler_reachablestamp=
s' failed                                                                =
                                                                         =
        | ETA:  0:00:07
>>> Traceback (most recent call last):
>>>    File "/OE/build/oe-core/openembedded-core/meta/classes-global/ssta=
te.bbclass", line 1293, in sstate_eventhandler_reachablestamps
>>>      bb.utils.remove(workdir, recurse =3D True)
>>>      ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^
>>>    File "/OE/build/oe-core/bitbake/lib/bb/utils.py", line 751, in rem=
ove
>>>      subprocess.check_call(cmd + ['rm', '-rf'] + glob.glob(path))
>>>      ~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>    File "/usr/lib/python3.13/subprocess.py", line 421, in check_call
>>>      raise CalledProcessError(retcode, cmd)
>>> subprocess.CalledProcessError: Command '['rm', '-rf', '/OE/build/oe-c=
ore/tmp/work/x86_64-linux/tensorflow-native/2.17.0']' returned non-zero e=
xit status 1.
>>>
>>> ERROR: Command execution failed: Traceback (most recent call last):
>>>    File "/OE/build/oe-core/bitbake/lib/bb/command.py", line 123, in r=
unAsyncCommand
>>>      self.cooker.updateCache()
>>>      ~~~~~~~~~~~~~~~~~~~~~~~^^
>>>    File "/OE/build/oe-core/bitbake/lib/bb/cooker.py", line 1646, in u=
pdateCache
>>>      bb.event.fire(event, self.databuilder.mcdata[mc])
>>>      ~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>    File "/OE/build/oe-core/bitbake/lib/bb/event.py", line 224, in fir=
e
>>>      fire_class_handlers(event, d)
>>>      ~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
>>>    File "/OE/build/oe-core/bitbake/lib/bb/event.py", line 131, in fir=
e_class_handlers
>>>      execute_handler(name, handler, event, d)
>>>      ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^
>>>    File "/OE/build/oe-core/bitbake/lib/bb/event.py", line 102, in exe=
cute_handler
>>>      ret =3D handler(event, d)
>>>    File "/OE/build/oe-core/openembedded-core/meta/classes-global/ssta=
te.bbclass", line 1293, in sstate_eventhandler_reachablestamps
>>>      bb.utils.remove(workdir, recurse =3D True)
>>>      ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^
>>>    File "/OE/build/oe-core/bitbake/lib/bb/utils.py", line 751, in rem=
ove
>>>      subprocess.check_call(cmd + ['rm', '-rf'] + glob.glob(path))
>>>      ~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>    File "/usr/lib/python3.13/subprocess.py", line 421, in check_call
>>>      raise CalledProcessError(retcode, cmd)
>>> subprocess.CalledProcessError: Command '['rm', '-rf', '/OE/build/oe-c=
ore/tmp/work/x86_64-linux/tensorflow-native/2.17.0']' returned non-zero e=
xit status 1.
>>>
>>> Summary: There were 2 ERROR messages, returning a non-zero exit code.
>>>
>>> OE qemux86-64@ /OE/build/oe-core $ find /OE/build/oe-core/tmp/work/x8=
6_64-linux/tensorflow-native/2.17.0/
>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/
>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l
>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l/output_base
>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l/output_base/execroot
>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l/output_base/execroot/org_tensorflow
>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l/output_base/execroot/org_tensorflow/bazel-out
>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l/output_base/execroot/org_tensorflow/bazel-out/k8-opt
>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin
>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow
>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/lit=
e
>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/lit=
e/python
>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/lit=
e/python/schema_py_srcs_no_include_all
>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/lit=
e/python/schema_py_srcs_no_include_all/schema_generated.py
>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/lit=
e/python/schema_py_srcs_no_include_all/__init__.py
>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/too=
ls
>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/too=
ls/pip_package
>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/too=
ls/pip_package/wheel_house
>>> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/too=
ls/pip_package/wheel_house/tensorflow-2.17.0-cp312-cp312-linux_x86_64.whl
>>>
>>> Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
>>> ---
>>>   recipes-framework/tensorflow/tensorflow.inc | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/recipes-framework/tensorflow/tensorflow.inc b/recipes-fr=
amework/tensorflow/tensorflow.inc
>>> index e48808c..83e2d1a 100644
>>> --- a/recipes-framework/tensorflow/tensorflow.inc
>>> +++ b/recipes-framework/tensorflow/tensorflow.inc
>>> @@ -61,6 +61,9 @@ export TS_DL_DIR
>>>
>>>   do_compile[network] =3D "1"
>>>
>>> +# Missing write permission prevents the WORKDIR to be deleted, e.g. =
when recipe becames unreachable
>>>   do_compile:append() {
>>>       chmod a+w ${BAZEL_DIR}/output_base/execroot/org_tensorflow/baze=
l-out/*/bin/tensorflow/lite/python/conversion_metadata_schema_py_srcs_no_=
include_all || true
>>> +    chmod a+w ${BAZEL_DIR}/output_base/execroot/org_tensorflow/bazel=
-out/*/bin/tensorflow/lite/python/schema_py_srcs_no_include_all || true
>>> +    chmod a+w ${BAZEL_DIR}/output_base/execroot/org_tensorflow/bazel=
-out/*/bin/tensorflow/tools/pip_package/wheel_house || true
>>>   }
>>
>>
>>
>>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1289): https://lists.yoctoproject.org/g/yocto-patch=
es/message/1289
> Mute This Topic: https://lists.yoctoproject.org/mt/111564223/3617049
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13176=
071/3617049/43253763/xyzzy [hongxu.jia@eng.windriver.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>


