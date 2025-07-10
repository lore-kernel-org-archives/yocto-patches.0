Return-Path: <Yash.Shinde@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52858C83F1B
	for <webhook@archiver.kernel.org>; Thu, 10 Jul 2025 14:46:14 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.10587.1752158773538333114
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 10 Jul 2025 07:46:13 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=92864f0a6c=yash.shinde@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AAPSme028897;
	Thu, 10 Jul 2025 14:46:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 47pu19ncu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 14:46:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GfarzBlLFjldFeyAzHJcJV86WHA5Cp6OLbtO+dtIXkYF3ZOlULbm6QuVyU3W/MjvvkKcW56eCaOYRAzCtJZWpTPu3cg66TiDYixEhxMiSkHK2WGPDuBmYBDiasU6WiYQ4Hbqh3mUyAOzS/mO3JyLrsNUEUBUmZTi0fx6D8iAiO/JKgD4RZqOY1PQumwxQKhINl5VuAm00Xi8tuREljAaquI5uVTeTzu/sSIIcQGgFhLoYH0OCR3hVZfoI53BkLGyTGRVCDPDiUClAXnYrJY2HkJ3t6qr/Z5p8FSxraz5XCXFrarUyTBTQNxCDV2o7QwmZ8Z1VnZOWGeaf3RpP3xuoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtZx/F2aJ3GUpDntzp+AmzXcA8reAovbVlPQharqSP4=;
 b=x8LFXzzja7RQRy2zV6POfuqOckbKHND1Up/Jw0HfhUHTKpczzLTuyTX23ISla9r3ot5lFwTtZdld2weVfYl40Hz9XHUPWMohLpDdp7S5dIj3TF5EFL0Whwa+w6acJR6cSkLFZFRnWu2xlvthqGoogcW3i8nJP94DbdhWYzn6wYlXVC7zpkbcySINJUbR7GLXj8IeKZWYD4zptismjUxxHAGV5uhqFn3tdjxew0HnlQMOrK0kGlcYXe1zVgMN1fDKbDm2KzzF6y/vCRlYakXtKMJdfVYW4rYI+SHeqYFZ6KJ9NNG4qkke01fYJNgyfVQnv58uhB5LdfYvopZaweqZFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB7593.namprd11.prod.outlook.com (2603:10b6:510:27f::9)
 by PH8PR11MB6998.namprd11.prod.outlook.com (2603:10b6:510:222::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 14:46:08 +0000
Received: from PH7PR11MB7593.namprd11.prod.outlook.com
 ([fe80::2688:e731:421b:5ebc]) by PH7PR11MB7593.namprd11.prod.outlook.com
 ([fe80::2688:e731:421b:5ebc%7]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 14:46:08 +0000
Message-ID: <c387043c-e304-43f7-83a2-40b64ce301ab@windriver.com>
Date: Thu, 10 Jul 2025 20:16:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-lts-mixins][kirkstone/rust][PATCH] rust: Fix DEBUG build
 segfault with p384 crate on Rust <= 1.85.1
To: Scott Murray <scott.murray@konsulko.com>,
        Randy MacLeod <randy.macleod@windriver.com>
Cc: yocto-patches@lists.yoctoproject.org, Sundeep.Kokkonda@windriver.com
References: <20250709072014.1978605-1-Yash.Shinde@windriver.com>
 <a2703f2b-0c6f-4180-9395-e0e9c60cd0da@windriver.com>
 <1fde4016-2fa0-2b91-4024-7f84caa430fd@konsulko.com>
Content-Language: en-US
From: Yash Shinde <Yash.Shinde@windriver.com>
In-Reply-To: <1fde4016-2fa0-2b91-4024-7f84caa430fd@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::17) To PH7PR11MB7593.namprd11.prod.outlook.com
 (2603:10b6:510:27f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7593:EE_|PH8PR11MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: be18fd89-4c5e-4fdd-d978-08ddbfc08159
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RVd3a20wNUpjVWE5UGtub21yc2xWQ1VQUTBJWXc5NzVNbnVjQ0N5NE53Y3RT?=
 =?utf-8?B?UURROTJFaUQrKzFQaCtTRmZRb091QlA4WTg4bGhlNWgyaXZFK2xQaUZFNGRj?=
 =?utf-8?B?b2dxZXVONlorWWUvMnpWUTVDZDgxRUx5SDFodnlaek45WXlpaDJwamhoVDJ5?=
 =?utf-8?B?c2VUbnAyd3B1ZEpISkxMYWI4Y0hCTFcrV21hZy9MaXA3V0RtTERNVGdmb0J3?=
 =?utf-8?B?N3VWTjhkQWJFZ0dKdU05NXZmbkJRb2JLeVhENzRFK3Z0YVdRazUzd1ZISk95?=
 =?utf-8?B?cGFXWXNlTDRzem9xM2lKYlY5eS9PUTc2b3ljZHBIY3BYajZzQnBEbUt3SVo2?=
 =?utf-8?B?WEhtVG0wdDZ1eU11SUMxdmJOWFY5NmxSQTZIUCtHNzdqMXQrbGVLRmN2VTBs?=
 =?utf-8?B?TlZmbVh5OEZQM05RQlpCb0phaEw0REg5RFkwbEVwRmpRTmJqR1lXRGhVYjNB?=
 =?utf-8?B?L3pVV0traldhbnZzR0twRlBrRlc1TXptMnAvTFZyajdiZUkzRVdOdWJLZ2pw?=
 =?utf-8?B?S1pQdlBNNm9YWUNzUit5L2pTQ1ZHNGlpdFlMcWJ2VTJwbUxTNzJQMzQyaTJj?=
 =?utf-8?B?LzNhdUpCMStKOVRwczk2TWliTnptZ1RJQTdoNjFBNUFEVEVkZXJuTUtEd3Bz?=
 =?utf-8?B?ZnVYYnYwOEZkcTF4c3hndDZ4c0IycWxyYmc3V2Z0NHNCVHM1YUc0ZG1qU1pt?=
 =?utf-8?B?SEg4UTFlTS9Bc3h3a0NSZE45MmY2M3FxQ2ZqYUFsaTJuNERWUnJjMldIRmxu?=
 =?utf-8?B?M3NSZDBKNUt0WE8xMWN2QWFTZmtMb2FJUS9ZNmtDdmlqQnI0a0RMZVdCcWtU?=
 =?utf-8?B?NmxISVQrU0czR0xlUFNLcGZNaHdXRzBTM0JLZkUyazFWWDVzeE5TOFRGVmNB?=
 =?utf-8?B?MXExdDY1SmJWZk1BSmJZeDBJWWROWVJLUllMT05ac0g2ZGJwN2wyWjJ6YVJK?=
 =?utf-8?B?UkwzcnBNRDZ2Z1VMVFdsWVY3MlBVQ1A4WUtMcXhlbmxkczZLamozVHRKQUJs?=
 =?utf-8?B?NytVZmgyWmx3NnRhWjZ1V1BqQzRZTGxUN2w5MkdoQ2FwTy82VWFpTGt2QnJj?=
 =?utf-8?B?T0RUUEoxTHN4aFVvcSsvUGtyRFJ2OVZNK3h2eFpkZXVSc3pCTCtFcDVzWkZh?=
 =?utf-8?B?ZU40bzQ4TlZFVVAycXp4d0lmVjdDdEFtUWlmRkNnYmFhZGNWbDE3WkVFdXdy?=
 =?utf-8?B?aDhGQWdna1kzQnNlTDFqUW4yRUY1ZVdxdHhzZlY2UUV1ZnE3SndiSXZUbDdm?=
 =?utf-8?B?OXN6YkRNMVNWRTBMMDJRR1RvUDJ5VllKU05TdWZxUlpqNnlGc0JsMTlLd2ZI?=
 =?utf-8?B?UGNMTzdXMFV2bGhGN3dvMEYxODBMdXFBMmpibE55eFNvOGRJSVhnYjI4YnM5?=
 =?utf-8?B?UnNpaC9IdWU4R1ZmVkFBSDdyYitpOHFEOE1pcC9nSUtXL0ovUE1KM0xRUlhO?=
 =?utf-8?B?MnV1MStnMlplR3psM2Vrd1V1a1pGUFlnN2dKclpjZ25WdUUyR3NsTmRqSlQ4?=
 =?utf-8?B?UUV1aGw5bDZ1ZXVINzR0YjRna3ZmSDJrU25KRWlzbkZQSDN3eFh3SlVGN1c2?=
 =?utf-8?B?MW16TzYvQmozUTF3N3h3VFV2L1VPZjZIRS9CVzQ2NFBXcWhjMVlLRGZtN3Bh?=
 =?utf-8?B?cFVZdFFlbjJ4NFozazh4dVdXcHZHSmYvSHRUemNpVVVJbkZmYmx6QnNSeXNz?=
 =?utf-8?B?MWwweCtpUmtZbWpXOHphVGdlc3Y4TmRMMUtqTUozN3RSN1FhNlpvS1VxcWVa?=
 =?utf-8?B?SHEwWjYwcEJoQkdXYVdlSUtVTVVlU0swQm81ZWZOdUVySmo4dzZ2ZjZtYXcr?=
 =?utf-8?Q?GsDrYWjktpQ7OLqwPGk7Ea+yWWod0GxUp/HOc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7593.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RjBOcFlwUVcyelNHSzFoVjkyKzN5MnJzMTN4MWNmaDg1VW5jNkR5d2ZPd0VE?=
 =?utf-8?B?di9ONmpiY29LMjMzUFkrVnNhWE9BNlZ0bHJMWHpGajhBVmhMTTNOcnZSQWFh?=
 =?utf-8?B?UUhNY1FodEttRUdCNHkwMW5jcHdaTWxxUnFsMThqaVJ5eXgzNGQ4aUYrYWlQ?=
 =?utf-8?B?ZTh6b01vV0lYZVI5dkFRSEt3STZkaCs5OVNrVmUyeUhCbWFZUStCckxqYzIr?=
 =?utf-8?B?TitZWDMrU1ZxR0NwRWhVbzZsbHlKTkIyRU1QOTFCOW1xNy84VGpqMGVOdnlu?=
 =?utf-8?B?ODEzaEZZZHUzR1V6WWljRExmUURWZ05hMTdUZ215aTdZeWZ2bXVPS3llSzRV?=
 =?utf-8?B?TzZJcUJTT0V1SjcwYmJENGNKcjVQMU8vUEtHQzRSWTBQenVPMElvOW1TUEV4?=
 =?utf-8?B?a0c0NURlSXk0dHpTeS9nU3FvUkVkVFg0dGJnS2podVV1c3U4dEdlUmh2cXBo?=
 =?utf-8?B?dW5ieVVYQktRY3RVcURPZkhoNlBXcmlkck80NWNSOWtzTHNwM0YwZjMvMXVI?=
 =?utf-8?B?YjYvbkhheEtyZFRPYmZucGNFV0R6U05QQ3BWNURNajlmTjRpaFdJRHRVaERG?=
 =?utf-8?B?Wi9SSHpPYmdJcnpKQjFFazFLWTBYaGRSME82SkJ6NkhXQ0xEYThYUGRPbkpr?=
 =?utf-8?B?UUtNZ2IwQVpRRm5ubFZ4aTk0YTluTFAxMFlsSnlSWWdxOTl4ckkvKzFsbjQ1?=
 =?utf-8?B?N2VDQnhhNzZmbmZVbVh2M1hFcjRSZ0pqaGVrRWxSek1hRUdyTXAyd1FEOGwz?=
 =?utf-8?B?MGliVFd4bStjK2ZLTVhyWHBIZzdUd2k4YjdnR1RNV1JlVzZjZGhsTS83NkZp?=
 =?utf-8?B?RjBWZ0xibkE1Wk8wMzFoT0xiYWlWeVNueFhxOFNIak83cDhnUmRqbnJuenFr?=
 =?utf-8?B?UE5OK0xmVDM5OG94bFVPTU9PbUF1Nk56NXlGeCtZWUQxNjN4RnIzeEJ3SXBy?=
 =?utf-8?B?a2RFQjdEcGpuTHVWZEJYd2dsV05CaHh5a21SbUI0d0IzeVdDS2YxOTJib283?=
 =?utf-8?B?dEFsUXBKb1hwR2JINTdPL1dwTlYzU0R4YnNTTVNOSzIvWkUyYkFGOWI5b1la?=
 =?utf-8?B?TkQyUGMvZlhmaFBlSm5WK0djVERlUXUveHFiR2p2NEZmZ0dDUDVuaTNwZ1ly?=
 =?utf-8?B?YTBkSmMxeWhZVCtTUVpqU25HYlVJVDFqb1pHSmt4SE1aM2JsR0NvVXRCWisx?=
 =?utf-8?B?bU92TzIwKzdDQTltQm44T3M4N3NYclJPZ1pidWFiNE5uTjREV3JVblpGYlNz?=
 =?utf-8?B?UGxqRlRjMlQwMlFZWVJzWlA4Mm5Ub3JEcmN2VmVZUEdSeGNBTW9pendJZm5H?=
 =?utf-8?B?NEozczZULzlhZWdwcEV0Sy9oeEM3QVprcmZHQXJwdGlFbEZvN3U0ZkRFeHdv?=
 =?utf-8?B?aFhXWnRjU3Ezd1BXZU9yb0w1cnFvVVYxMVJ4WlJrRjU4WEhiRnd4TVgxckxY?=
 =?utf-8?B?a0lKUFJLSDlXRithMEl1SnpyL0FOK1Z2NlRxN1UyeFNpR3NvSDU2R1I0MWY2?=
 =?utf-8?B?bjV0VEE3c01LQVdmRWltNVArVi9XK1JrR0g3dmpNQ1I0ZWlXVHRabzZMUzhw?=
 =?utf-8?B?Vm1PRU5pMnlNRFVsSzRpbVJwaFZzcDIvbzdTSTYrYjlncFJLWi9objRTUHBU?=
 =?utf-8?B?UEpyS3UvVkg2T3RucjgzT1BoYTBrNHlRWGZjTThNMnN6a0x2OHhvUWZZSDEv?=
 =?utf-8?B?TXRxc3NDekZYTklvQThlSm53cTZINVJ3UFArS0Rva0twR1VSYi9ZV2U4aWhw?=
 =?utf-8?B?Y2JjRHpLeEM1RGdjeVBkT2NWRUI3clJ3alV2cHBvSHBVYzBtODhDM2RrNzlh?=
 =?utf-8?B?MndmOW1rc2lPS2hraDRVbFJXOExmdDkwWXpjeC9hUGdMbXlRb3NQTWNZckFp?=
 =?utf-8?B?RUpuN1J4UHlVeTR1TEJ6SUdQcmVwanc1eEplYVRpMnV2dktlaVJSVVlGK3FU?=
 =?utf-8?B?L0dQRXoxalFLRkd2L3RraWJ2cFJZb0wxOXYxQjhFZDhzZ0pFT0NLbGtwU3BP?=
 =?utf-8?B?ZjZTSTRNbmNYWWdlSVNVejlhRVFwSHBta1FHQW83RVhEUVNaNzMzdCtEenZv?=
 =?utf-8?B?Tk1zWGVoOXdJYkxkTXFOVzJKQjBZYzI3aStmTjZLV1BBVVlSNkMwbFlaZFNz?=
 =?utf-8?B?bnl2K1Y0S0hWN2F2c1BoZ2tYMVVoVEIycWdnY1Z4ZFpjek5EMVEwa3QxeVdT?=
 =?utf-8?B?bHc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be18fd89-4c5e-4fdd-d978-08ddbfc08159
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7593.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 14:46:08.6011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ydu9BycYfOYCDlRugwOCH3mPmwf7Rupifvzkql2nxHrATJHWNbxKQE8bFQRhfM9jKz56q+1UbiLUp3u1RoXGmALP16dhaWkSnmiEo4c1JNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6998
X-Proofpoint-ORIG-GUID: 7MTmSHW9H40_uONdh2mD8fe-Wz5gN3ae
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE5OCBTYWx0ZWRfX+cRiPtkDRZK+ 6KU8gqdtYbeb3/skDoyPtk+VAVykJrbxI74pQ0BoRdVWZFIOacifjrwbvgcNTBviA0OXzdogLPv PZFGKJKkNBgc3Mj+6XIPZmJf4OXfsKKEy5KDWoqLluukZHjoZBDlJw/40zJvXe7ZPMGW+wNZTG/
 XN1xtTY6tPfcUuNIQ+BPZdN2XmRosaSIbdm/QH82SU36ibfx29XA2IupKxDmyZMtLmB4usaRxDB kqAdn46QRmX3wYfOS/CgoGFlM9NV5RiDX7mdRhHXszgdCEdAm2qXFiX5fDxU+G0szl57qkrgimF tf4mR+DDGbX2QEMfeR8gMZHeN08nFrGMHno1CeCsMfpzrA+Cmk6xjLy5fpGD+lVx3QuQDO5sZPh pJdrU+NI
X-Authority-Analysis: v=2.4 cv=ZrntK87G c=1 sm=1 tr=0 ts=686fd233 cx=c_pps a=w03VZMKSO2wUmkC+UK+mIA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8 a=D4XlLsZJszSXCoAy3mMA:9 a=QEXdDO2ut3YA:10 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 7MTmSHW9H40_uONdh2mD8fe-Wz5gN3ae
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.21.0-2505280000 definitions=main-2507080198
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 10 Jul 2025 14:46:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1800


On 09-07-2025 21:18, Scott Murray wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Wed, 9 Jul 2025, Randy MacLeod wrote:
>
>> On 2025-07-09 3:20 a.m., Yash.Shinde@windriver.com wrote:
>>> From: Yash Shinde<Yash.Shinde@windriver.com>
>>>
>>> Backport a fix to address a segmentation fault in DEBUG builds when
>>> compiling\
>> No, too much of a change.
>>
>>
>> Sorry that I wasn't clear, I wanted you to provide the two line
>> change that changed the debug build into a release build.
>>
>> Scott,
>>
>> Will you take that?
> I prefer to take changes that are straight backports from master, but
> I'd consider a less intrusive patch (i.e. the 2-liner you mention) if you
> have a real hard requirement of supporting 1.85.1 with it versus being
> able to go to 1.86+.
>
>> At some point, we'd update to a version of rust that has this fix - 1.86,
>> right Yash?
Yes, right.
I have sent the 2-liner patch 
https://lists.yoctoproject.org/g/yocto-patches/message/1799.

> I've been a bit busy, but plan to try backporting the 1.86 and 1.87
> upgrades to the mixins next week when I'm back from an AGL event.
> If you're okay with waiting another week or two for 1.86, that does
> seem a better approach.

Thanks for the info Scott.
It would nice to have rust 1.86 and/or 1.87 in meta-lts-lixin layer 
which comes with fix.
Meanwhile, we can apply the 2-liner patch.


Regards,
Yash.

>
> Scott
>
> [snip]

-- 
Regards,
Yash Shinde


