Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78B1C87FCF
	for <webhook@archiver.kernel.org>; Mon,  4 Aug 2025 12:11:24 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.16277.1754309477632341547
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 04 Aug 2025 05:11:17 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=0311382005=yi.zhao@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 5746GYbD1704364;
	Mon, 4 Aug 2025 12:11:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4899n61hea-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 12:11:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbmPEXWQAA+1AcysdTv+/Hvt1NCbZLS75LFfoF27S6g3jeLbqGUtbtUW1xb45pQswdpdJ4kb2ZkbeuaaiGzUqmXjOzWUbyA+lwWI7LFx40Cx8Kfhy0brfR/MRQo830K7jjaKAKIzOn0tCM33qA6KuOALtDKNyGcukGbNJZmBzR1dZaGmYr2MEutbakAm1ifn1qvi33R3X/Mb16xaYpt/cTTdmx9Ljc8Qh2UA2Hb1nndqN4IseBOWL7MHsmywBSwWELQYDUrghD7hWWzUhPqiMLnPPNqE79UXHs07dOcyiFVPqMO2kxGdAygs5MI+5KAIAsVJbNBrGSV6hu5tmK11oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laFTZQeTyTcHwXeMFkuTL1PlkPnQSyXfvUg3UhqMGhg=;
 b=EIHCJFah3XmXwmgRoNLiCUsNSTGH+QTuy6bopw9FYJMtCfX/6s43/5i8K5Yt2S63mZPj7SluBGCqW+7ugQpovQAEHXzAsEAxjmz7ybah6R0b1JREeUMVtQ61PqIij580H61r7dxjzvJyxPePY8LiLj5R1ptLzKUNBze+SQnGgpYrPONGUiAYtv7uzWnDrbhb9vY5PCeqfu44jbh7CxRkF5gBP0NBHC+ElqNpdOryJp3VZQUsc73oKlDjtDd+/q6mXN6U6U0AmNjcSB756TgqD/J+ifORGlLQG2EMjc5PizvW898EjcbJTizizBC7Jpkrd2VL/jceIBAd9kel8tPobA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 LV3PR11MB8741.namprd11.prod.outlook.com (2603:10b6:408:21d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 12:11:10 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 12:11:10 +0000
Message-ID: <8fd3e86e-b9cb-41c7-9811-2536ceed3c10@windriver.com>
Date: Mon, 4 Aug 2025 20:11:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-selinux][PATCH] openssh: use config snippet instead of file
To: Levi Shafter <levi.shafter@elder-tomes.com>,
        yocto-patches@lists.yoctoproject.org, joe.macdonald@siemens.com
References: <bb24ee8c-b074-4b54-be64-2d1a09e5359f@elder-tomes.com>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <bb24ee8c-b074-4b54-be64-2d1a09e5359f@elder-tomes.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0235.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::13) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|LV3PR11MB8741:EE_
X-MS-Office365-Filtering-Correlation-Id: 4963515f-b8fd-4280-c0da-08ddd34fffb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VU1FaXFvWmNCRk52Uk5SS1A4bnl6UUtZRExaKzdnVURYMWY5TnlvUnB4aUJT?=
 =?utf-8?B?UlpsVEIzVE5pK3ZUUjBnZTEzdkZGZmFhelJXU2pRbEd6ckZUdFVIMFJUSXps?=
 =?utf-8?B?N29pN0EwMHFzcHFZTWV0Q3pQVDRQRlJraG95OGxzdUNUSVJsL2w3M2NoNzV5?=
 =?utf-8?B?dGRQNGEwcGhIdkdhRWxSUVRSR3l4dk80ZUR2Y1BOTEt4M0taZFBES3ZFbitC?=
 =?utf-8?B?NnBKcjdMUEJkUk9UUHdWNzZZcXlBODRxeWRwSU8zUXorMUFKcGQ1bWhrK0xS?=
 =?utf-8?B?cXNXd1RZM2g1NUFHT3JMZzcrMXgzVSszRlVKVEZrQ0pHU0krNlZmdUlBZHJH?=
 =?utf-8?B?ZXhMTm1BQzJ4bkpjcDBnYklzWm95NDNodDJlQlBhTDBrd1FFRVRvSjNsUys3?=
 =?utf-8?B?OUE0RXdwWEtkSXl0Mmw3ckFYR2ViQU8wbktiTzRBRUcyL1dOVmZYQnRvVEY4?=
 =?utf-8?B?b0s4T2hWcElMQlRuMlh6OHIwVWw1ZDJjb3RSTUhGTnA2VXVOV21zVzJwTXVK?=
 =?utf-8?B?aUFPWWtXaWY2TjF4ZXhUYUpGUHRITFU1enBkVjNrZUZGVXJBL1ZETFZOTjFV?=
 =?utf-8?B?U1JURHM0TUE1OWt4bmxWS3lRYzhrcXUvMW1XRGZyUExMSFhEUm1EUnk0YTBw?=
 =?utf-8?B?bDUwZDZWRmpsOStqeDU1Vncyb081S3g4YkVhcC9uQmhOUFliZVVDQjFwc2or?=
 =?utf-8?B?eHFIVXR4L2RzekxWejJReW05QXVOMGpxcHF4S0ltbFMwU0V1b00wenpNYUZr?=
 =?utf-8?B?bE1GaE4wSytKWGQxR2RMREpWeXNRemVyZDhndER6UFlrcUxXUFpWb0NIZnBp?=
 =?utf-8?B?SFZsQnNxSldQRVdKUG5XUFJ0UWIyQmJlemtXUmhjMTk3b2NSdERPM2xmYkJD?=
 =?utf-8?B?d0VKbWJNODA2N0Y3QkhkbDZ3M1Y2VWlpNmtIMFBtNVVqS3hvSHJubzh6eUhH?=
 =?utf-8?B?bVd0cy9oYUNGU3FUc2MxemdqMUEvYlJmemU5cEtLbWRDdmRObmwzU1FnNFVj?=
 =?utf-8?B?S2JUNkw0WTlXY3dEMk1FR25GbHJNWFJ5cjQ4eG8yTTk2N0hMSzdXaW01Z3o4?=
 =?utf-8?B?TEptV3R1OWZIZkVZM0RkcWRXbXFFcXA5UjN0OVE2QXY2ZEhISGRkclVDZGRG?=
 =?utf-8?B?TEVvOGdKK3hQL1dmUlVVQVM4YnFqS2hWQ3k5S3FiVENYYUFoUzdwS3NEVXVL?=
 =?utf-8?B?QXhCY2hYUVJzSnVnWFFaanBBMzRmbDAvelgyaGhoa1VtMjd3R1d5NWd6NERl?=
 =?utf-8?B?eTk0V2FpNFRMQ3poeHh5NGxPTHdhWStvVm1ha3gxSzBlZGhUZ3pYOUdKNStr?=
 =?utf-8?B?Z28zQmhONkJrSjBCeXgzZDdqWkJZY3JqVXRMZjFlcVFBY25ac2hpNVlvTTFI?=
 =?utf-8?B?QjNOTm1JbllaZFlpWmRTNWo3NUhjdGhFVkdtNmY3NUx0aUhjL1hYeEFRay9M?=
 =?utf-8?B?cGp2UitacjNmV3paeUVybGtGV0I0UkJPSFlkelpXTUNRS3ZQaFBiRlhjWnBz?=
 =?utf-8?B?NjEvUUVncS9OWFdiVjNPNzFLUWdJQWRQUEovNU15WUdMWE15dnQzbTl3Qk1s?=
 =?utf-8?B?SDhRN041YjI4WkF5UUk0RWxpS1U1UFMxQ0s5OFRRbFdneHRSOXFjOUNrVFBp?=
 =?utf-8?B?RXJlSFJiZUQ5a2loN0V6UWRuMVE0YkFCWWlSLy9HSmVOKzFJZTc5TWJMZnJJ?=
 =?utf-8?B?VTdXYnN0alZ6WXUyc0o0dnN3R0FSUStVUVU4dEZJTmpxMnFzWTV0MG5lSU9l?=
 =?utf-8?B?UzgxSHZrelNTUHJ4anptalcrbVdBM2NTVjVmSEdJdmQwMEpYNWNzcEwxOVg3?=
 =?utf-8?Q?cK+UKCukdAk0IuMW2yxuHvgqIs0B10tYET2jM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dFE1QmhMcllYazA1a1o0dEp0SGpYcGpmOFFEdGcyblVtYkJGdlhWaituSEdW?=
 =?utf-8?B?cGFRY2pvNnkyOTRZNjl0eG5sZXRzdW4yUGlHcVdPSWZEM3o5bTNrOTNrS3pO?=
 =?utf-8?B?cThqV0NhYjEyUHYra1RhYitCMDlka3h5NTRRUGJzM0ZES1BxQ2VoblVsSGkw?=
 =?utf-8?B?b1NkZzlpWXV5VDE4OWxzVFpsZXIxVUphZTROeDd5cjEyWk05Tnl4LzRqRWNE?=
 =?utf-8?B?ZGxnS0hDNzZ6Mlh6aFU2azFrellaTkx0a3htbkdGZWNXU3piam1kem9nMG1S?=
 =?utf-8?B?a3R0MFRtMUFiUGhzTmdGcDZncVRoOWpjMzZKWFhOMmJVSGQ5M2h6cDIxZzYy?=
 =?utf-8?B?NVFqSzN1cFR4ZzRtSE1tZGNzejBqRndsdHFrNG00dUU3S3dBME1VcU9LZUNZ?=
 =?utf-8?B?ZzBYSUZ1Z1lhMU50VFNwUWJuRFZKbnloSnpnWk9GUkVjb2htL0JRUzByalVL?=
 =?utf-8?B?ZnUwSkZtM2FLL2xKY3Y5M0VHSVNkUFk0c0NCdGpFWkl1OU5mbDh4ak92cnRp?=
 =?utf-8?B?czFQOVplNWV6eWdVeFU1SkE3d0N3LzY4WWdseFR2SGd6LzVMMFpSTng2SC9j?=
 =?utf-8?B?Qk45NXZtc2Q1UlFNSmQzZlh4WVFTUi9pdFlyVkpVM1VDR2FpSXcvL2FRM05E?=
 =?utf-8?B?ZEsvVzdIRjZRVnUyd1MvMTQ3RFBsZnUvdEZUT3hiZ1ZkdThCU09Jc1krUFpO?=
 =?utf-8?B?Zm5EYVhMenJsVTJOSHhhaUswZk9EQ1FWMEw3UUo1SER1U3VWdUFQRG9ZblJh?=
 =?utf-8?B?Uyt1VXUwWlpSYjludVpYMkt4YzVtQm83SnJxaFdRbHhSZ3hVbkkyR09NTS9F?=
 =?utf-8?B?d2xTcTBwLzV5YzVrUmNVeU1YaVUxM0o5OVovMWlQeXl4UUUva052dG9PTGtq?=
 =?utf-8?B?cVR5WmhXWU5SeXpFWUNQN25KT2szNUNVemFubEdRc3ZVSzIvZlo0K3pQNVVZ?=
 =?utf-8?B?WTREMFlUWms0dnN1Zm85cEdMZnBIUlRyanNqTms1b1IvNGc4dkpyODVLaGNh?=
 =?utf-8?B?VThHY3ZQWklTWTg3K3Fhek9QdGVjTVZIQnNVRElPbG9FVUo1ZkpKcGxvczUx?=
 =?utf-8?B?TGR6dGdGcWJaTEs1SVlFUjQ2aFJYWm93RVkyMlhuYVk4Y205dkJTd1EzTmZV?=
 =?utf-8?B?L3hFQ2pUTS9yc2JlbVBIaHZtR2cxSlc3ZFN1cXRCM21xRk80Vk5JUDdVWTdR?=
 =?utf-8?B?N3FFVTRWSVc2ODl1SmJxaTBCYXNZV0diSUEybER5K0l3c0V3RUVzZ29hZHli?=
 =?utf-8?B?UE83MnVUYXdrK3Q5N2cwMWJqWTRWTnQ5dThUbE9UT05jSkVna3hTQ2VZWk1F?=
 =?utf-8?B?WDluT0dBMFkrYkhveDI3OTJLWXFKVFdSSGYyVmI3RWxjRDdLMzF5UGJSZDAx?=
 =?utf-8?B?NFd5ZllnWE4ybUM0Y2xodTR4RGJnSnkwZnlVTzNKSlZPeWZsbjcyTDVYcWVQ?=
 =?utf-8?B?QW83b2Y3dkgwNmhicE9UNjVnVno2dVplOG84b3RnYU81UjFDRUI0dEVUdFV1?=
 =?utf-8?B?NVE4QmVGaEI3MFQrb0xoRzNQVERsaDZ1STJndHYrci91QjhYcDJYMEdDUWxF?=
 =?utf-8?B?dUNsUUM1OHMrb2NBRzlqZFZHT1cyYk5OcytkRzVDbjR3d3VzVWFjOEhaeFVj?=
 =?utf-8?B?MXM0OVBKNXNmZU1MeVNyaHh5MHl3aFlmQWszclg1MmZFcnB6ZWx6VWNCUlpp?=
 =?utf-8?B?N2lVeGI1alQyNnN6RTI2U0c5ait0OWNkT2hyWDMxejBDcjlzVnpFTWpEZ2U5?=
 =?utf-8?B?akhvN1E1c0ZVWDlCdjh0eTcwdE96eE95bnlMa0VMdi9RN1RCUzBvZ0VKd2Vl?=
 =?utf-8?B?L1czRzhBZDNJZDB5eHh2aEFtMUFhZGZONjU3S0F5VHNRaUpUT3lqcFljLzls?=
 =?utf-8?B?dTJaRDNLWlgrRzA3MnhzNklhazN4MEZXUzZIUzFUSzFpcmZ5Yzl1QkZTVm04?=
 =?utf-8?B?dHhha29uZzZkVGUrZ0xCRFZvWVFXUVVWSkR0UkMrN1pIVFhWYXB0UXJJYWQ2?=
 =?utf-8?B?WlRxTUx2RFhsY1NlaEc1NWEzcGdhQVJidkxlRlpyVStPYnhLVE9TNXlCMVNh?=
 =?utf-8?B?U1ZGVGhIc05OSjdNTjFWWnVCN2RmQVk3UDY0bUMxLzFrSHlqTVBJbW5NUUZa?=
 =?utf-8?Q?XDdOD4PephRWcIA3ADHsgsX+/?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4963515f-b8fd-4280-c0da-08ddd34fffb7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 12:11:10.5685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O7Es40h7kEHh/rAfqEDgVvQ+yLueLOw70fx4CDuXhU7LNILHizDPmSagWzV8BXY7KcrzpdUCKXz6e5UMJAY0gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8741
X-Authority-Analysis: v=2.4 cv=EP0G00ZC c=1 sm=1 tr=0 ts=6890a363 cx=c_pps
 a=GSyeEiZtCXJC2m8NNe+Eew==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=iGHA9ds3AAAA:8
 a=pGLkceISAAAA:8 a=Q90LdCruLpZQ6fdvymkA:9 a=QEXdDO2ut3YA:10
 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-ORIG-GUID: IahoiQtlNr2OWQ_XNYKk0XsBPUOZEWZK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA2NiBTYWx0ZWRfXwcMk+WsJPlDk
 ib8Vth9glcUadoc7ZjA5V+UaH2kob/Z1enIXfI9lz6cZ4N7irmwJNhfdG/u/7aRKauujEn1PelW
 bgW8Lm5h5/hbKWSs3WrNstrD4DR7Tj2Tub3Yl1iAAW4u82sBqhbJJat9nwAHiqibt1yYuAuz91m
 9sUfGNPHlqr073PBV/f+etX7V7uB/BuhpdfmfXb1I/bRpekNfeoxfkxWSF6u7ARO2QhD6QrlEvE
 9eljgfEvOX3nHkxYobVeXKpLfwy8GCwY+ST6FKeVTT3zKMP5qE/MyNER4svsQk6bRANRoVDitWe
 KVh9+Sh9jHCSJn3Zw2mh1y11PeP2nSrZr4dYq3rXwhQkOnXuEKLVrci1y1xdd9C5WehJTEbgSFB
 HdjJJWR8
X-Proofpoint-GUID: IahoiQtlNr2OWQ_XNYKk0XsBPUOZEWZK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 clxscore=1011 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507210000 definitions=main-2508020017
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 04 Aug 2025 12:11:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1883


On 7/31/25 04:43, Levi Shafter wrote:
> Config snippets should be used over file overrides since targeted
> changes may be required in multiple recipes.
>
> Since the oe-core sshd_config file now includes
> /etc/ssh/sshd_config.d/*.conf, the meta-selinux configuration snippet
> does not require the following:
>
> * ChallengeResponseAutnetication: Replaced by
>    KbdInteractiveAuthentication and set to "no" by default
>
> * Override default of no subsystems: This is already present
>
> * Compression, ClientAliveInterval, and ClientAliveCountMax: No changes
>    required due to identical requirements of meta-selinux
>
> Testing process:
>
> * Pulled modified meta-selinux layer into Poky and included openssh
>
> * Built core-image-sato and ran via qemu
>
> * Verified /etc/ssh was as expected with an ssh_config.d directory with
>    the new selinux config snippet inside
>
> * Verified system was including selinux config modification by running
>    sshd -T
>
> Suggested-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
> Signed-off-by: Levi Shafter <lshafter@21sw.us>
> ---
> Sponsor: 21SoftWare LLC
>
> v2: Install config snippet to sshd_config.d
> v1: https://lists.yoctoproject.org/g/yocto-patches/message/1818
>
>   .../openssh/files/sshd_config                 | 118 ------------------
>   .../files/sshd_config.d/50-selinux.conf       |  15 +++
>   .../openssh/openssh_selinux.inc               |  12 ++
>   3 files changed, 27 insertions(+), 118 deletions(-)
>   delete mode 100644 recipes-connectivity/openssh/files/sshd_config
>   create mode 100644
> recipes-connectivity/openssh/files/sshd_config.d/50-selinux.conf
>
> diff --git a/recipes-connectivity/openssh/files/sshd_config
> b/recipes-connectivity/openssh/files/sshd_config
> deleted file mode 100644
> index 1c33ad0..0000000
> --- a/recipes-connectivity/openssh/files/sshd_config
> +++ /dev/null
> @@ -1,118 +0,0 @@
> -#	$OpenBSD: sshd_config,v 1.102 2018/02/16 02:32:40 djm Exp $
> -
> -# This is the sshd server system-wide configuration file.  See
> -# sshd_config(5) for more information.
> -
> -# This sshd was compiled with PATH=/usr/bin:/bin:/usr/sbin:/sbin
> -
> -# The strategy used for options in the default sshd_config shipped with
> -# OpenSSH is to specify options with their default value where
> -# possible, but leave them commented.  Uncommented options override the
> -# default value.
> -
> -#Port 22
> -#AddressFamily any
> -#ListenAddress 0.0.0.0
> -#ListenAddress ::
> -
> -#HostKey /etc/ssh/ssh_host_rsa_key
> -#HostKey /etc/ssh/ssh_host_ecdsa_key
> -#HostKey /etc/ssh/ssh_host_ed25519_key
> -
> -# Ciphers and keying
> -#RekeyLimit default none
> -
> -# Logging
> -#SyslogFacility AUTH
> -#LogLevel INFO
> -
> -# Authentication:
> -
> -#LoginGraceTime 2m
> -#PermitRootLogin prohibit-password
> -#StrictModes yes
> -#MaxAuthTries 6
> -#MaxSessions 10
> -
> -#PubkeyAuthentication yes
> -
> -# The default is to check both .ssh/authorized_keys and
> .ssh/authorized_keys2
> -# but this is overridden so installations will only check
> .ssh/authorized_keys
> -#AuthorizedKeysFile	.ssh/authorized_keys
> -
> -#AuthorizedPrincipalsFile none
> -
> -#AuthorizedKeysCommand none
> -#AuthorizedKeysCommandUser nobody
> -
> -# For this to work you will also need host keys in /etc/ssh/ssh_known_hosts
> -#HostbasedAuthentication no
> -# Change to yes if you don't trust ~/.ssh/known_hosts for
> -# HostbasedAuthentication
> -#IgnoreUserKnownHosts no
> -# Don't read the user's ~/.rhosts and ~/.shosts files
> -#IgnoreRhosts yes
> -
> -# To disable tunneled clear text passwords, change to no here!
> -#PasswordAuthentication yes
> -#PermitEmptyPasswords no
> -
> -# Change to yes to enable challenge-response passwords (beware issues with
> -# some PAM modules and threads)
> -ChallengeResponseAuthentication no
> -
> -# Kerberos options
> -#KerberosAuthentication no
> -#KerberosOrLocalPasswd yes
> -#KerberosTicketCleanup yes
> -#KerberosGetAFSToken no
> -
> -# GSSAPI options
> -#GSSAPIAuthentication no
> -#GSSAPICleanupCredentials yes
> -
> -# Set this to 'yes' to enable PAM authentication, account processing,
> -# and session processing. If this is enabled, PAM authentication will
> -# be allowed through the ChallengeResponseAuthentication and
> -# PasswordAuthentication.  Depending on your PAM configuration,
> -# PAM authentication via ChallengeResponseAuthentication may bypass
> -# the setting of "PermitRootLogin without-password".
> -# If you just want the PAM account and session checks to run without
> -# PAM authentication, then enable this but set PasswordAuthentication
> -# and ChallengeResponseAuthentication to 'no'.
> -UsePAM yes
> -
> -#AllowAgentForwarding yes
> -#AllowTcpForwarding yes
> -#GatewayPorts no
> -#X11Forwarding no
> -#X11DisplayOffset 10
> -#X11UseLocalhost yes
> -#PermitTTY yes
> -#PrintMotd yes
> -#PrintLastLog yes
> -#TCPKeepAlive yes
> -#UseLogin no
> -#PermitUserEnvironment no
> -Compression no
> -ClientAliveInterval 15
> -ClientAliveCountMax 4
> -#UseDNS no
> -#PidFile /var/run/sshd.pid
> -#MaxStartups 10:30:100
> -#PermitTunnel no
> -#ChrootDirectory none
> -#VersionAddendum none
> -
> -# no default banner path
> -#Banner none
> -
> -# override default of no subsystems
> -Subsystem	sftp	/usr/libexec/sftp-server
> -
> -# Example of overriding settings on a per-user basis
> -#Match User anoncvs
> -#	X11Forwarding no
> -#	AllowTcpForwarding no
> -#	PermitTTY no
> -#	ForceCommand cvs server
> diff --git
> a/recipes-connectivity/openssh/files/sshd_config.d/50-selinux.conf
> b/recipes-connectivity/openssh/files/sshd_config.d/50-selinux.conf
> new file mode 100644
> index 0000000..775a24d
> --- /dev/null
> +++ b/recipes-connectivity/openssh/files/sshd_config.d/50-selinux.conf

There's no need to create a sshd_config.d subdirectory. Simply place 
50-selinux.conf in the files directory.

> @@ -0,0 +1,15 @@
> +# 50-selinux.conf
> +#
> +# SELinux-specific SSHD configuration overrides
> +# Managed by the meta-selinux layer in OpenEmbedded
> +
> +# Set this to 'yes' to enable PAM authentication, account processing,
> +# and session processing. If this is enabled, PAM authentication will
> +# be allowed through the ChallengeResponseAuthentication and
> +# PasswordAuthentication.  Depending on your PAM configuration,
> +# PAM authentication via ChallengeResponseAuthentication may bypass
> +# the setting of "PermitRootLogin without-password".
> +# If you just want the PAM account and session checks to run without
> +# PAM authentication, then enable this but set PasswordAuthentication
> +# and ChallengeResponseAuthentication to 'no'.
> +UsePAM yes
> diff --git a/recipes-connectivity/openssh/openssh_selinux.inc
> b/recipes-connectivity/openssh/openssh_selinux.inc
> index 07c25c5..259753d 100644
> --- a/recipes-connectivity/openssh/openssh_selinux.inc
> +++ b/recipes-connectivity/openssh/openssh_selinux.inc
> @@ -2,5 +2,17 @@ inherit enable-selinux enable-audit
>
>   FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
>
> +SRC_URI += " \
> +    file://50-selinux.conf \
> +"
> +
> +do_install:append() {
> +    install -d ${D}${sysconfdir}/ssh/sshd_config.d
> +    install -m 0644 ${WORKDIR}/sources-unpack/50-selinux.conf \
Use ${UNPACKDIR} instead of ${WORKDIR}/sources-unpack.

> +        ${D}${sysconfdir}/ssh/sshd_config.d/
> +}
> +
> +FILES:${PN} += "${sysconfdir}/ssh/sshd_config.d/50-selinux.conf"

This file should be packaged into ${PN}-sshd instead of ${PN}.


//Yi

> +
>   PACKAGECONFIG[selinux] = "--with-selinux,--without-selinux,libselinux"
>   PACKAGECONFIG[audit] = "--with-audit=linux,--without-audit,audit"

