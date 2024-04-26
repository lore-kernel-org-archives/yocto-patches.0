Return-Path: <changqing.li@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522F2C4345F
	for <webhook@archiver.kernel.org>; Fri, 26 Apr 2024 01:22:12 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.3792.1714094527829943507
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Apr 2024 18:22:07 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=p9H6gMLp;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=4846e70bc5=changqing.li@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43Q1K3DW020985;
	Thu, 25 Apr 2024 18:22:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-type:message-id:date:subject:to:cc:references:from
	:in-reply-to:mime-version; s=PPS06212021; bh=GexMlhNQK5pawfa0v0G
	drUcFUDIe0UXjISDy+vbgYIM=; b=p9H6gMLpDOcxeOYM+y7yzPp1M98ynRxoUw8
	wnqadXzmN7ZwmWfDwhLRC5gW4qgOTnm2bVvFcMh1/BtQluTWsTcqZzjmXlMCnvOJ
	W++Y0OxLyiFjDaiwoWE95g4SMCFBDuHvcLD0fEb25B1bT/DOE7wVtNac2/8RZ6vB
	aTQR/9Ru2gd+B6DmJrdLI5HkwRq1iVgjigu3KKtrFFefJ0iDNUlq23k+BtwHp6pG
	RVJkMZW9fiLJxccv0d0g/3vIWJUz1taxcfSlMBUjSPkf8CbY2QZQibBNXUY36wB/
	Z640uCR4vaoOxyMIlRKMMIDbfObambVL56ffbNX1w8NGmg+2T0g==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3xmd7gp1gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 18:22:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3XNrEGjUh78jyr2tEGmxoj46dRfuSrgGrc/43eF9mpXAM/Mmrtzfte3Bic28Bprnfh+q3iIi3q8QN0zEDK/DnLLvUkpKq7nx0ODLEFybC+FpvuvdkypzkQN2Xxj/my4WzIivGxny4dr9Gq3NXvYjI7Q2oZAiNdQKCniJKePYoYXtxl0gZpBWrYKFXEPHLKzfqjWDxua08hcofL/v6mdasiHHb/qQf0NeD6zYaYEFxkzzTBMqGQN/aT6RqLzStnvhglBR2K4QHHeD6bIGZSXFKnHHq0/ISc32y1jOzNfThHWv7JY/cTpw5ayr3USVnukPSy77bx7VOSaeEnIyMWI5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GexMlhNQK5pawfa0v0GdrUcFUDIe0UXjISDy+vbgYIM=;
 b=ZHrB+MeHYxBQ9Z0nPzGQpxrjl+/oZumxySghyyL6ek9Do8cSW9c+5mXk43D8h6TQs/t2z3YZ0eIznEamvUCWdM+h2sUvZCeuzEKHkvDajY2iNeI9wweL6GOIV6EphHQuxKaK+v0Sr8t08e7LoZybJh5KYoltnWN3nyqEKFwRO9/0EPpiIFKgTk+Qm7eAbwOt4KWKMNG83TfpaY4Kxbmyv5NnGB88RvYPjYjNiM27vkeon3Zg+2Zsq9SeqlW/opdmmymoI/xlHyCkH6sA+VdXD4jbIVwMTNK9WNqW5yaGTB7+WTum5u53svpTw9a+a6cnYJ+7TKA1KVDtEbpQANI+Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7312.namprd11.prod.outlook.com (2603:10b6:8:11f::18)
 by IA1PR11MB6220.namprd11.prod.outlook.com (2603:10b6:208:3e8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Fri, 26 Apr
 2024 01:22:00 +0000
Received: from DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::11a8:330f:c42c:b2d5]) by DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::11a8:330f:c42c:b2d5%4]) with mapi id 15.20.7519.023; Fri, 26 Apr 2024
 01:22:00 +0000
Content-Type: multipart/alternative;
 boundary="------------0NU1Pj1U5P5OQFDQVElWmXAp"
Message-ID: <abab1e79-ca87-4544-a317-931c84738b88@windriver.com>
Date: Fri, 26 Apr 2024 09:21:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] utils.c: fix pty setup
To: Anibal Limon <anibal@limonsoftware.com>
Cc: yocto-patches@lists.yoctoproject.org, randy.macleod@windriver.com
References: <20240425014728.4070856-1-changqing.li@windriver.com>
 <CAOU5ZMue2AZxq_7fJTVn6LEXPPXWrn-D7UFdzX43xvvJV6yQEA@mail.gmail.com>
Content-Language: en-US
From: Changqing Li <changqing.li@windriver.com>
In-Reply-To: <CAOU5ZMue2AZxq_7fJTVn6LEXPPXWrn-D7UFdzX43xvvJV6yQEA@mail.gmail.com>
X-ClientProxiedBy: TYCP286CA0025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::16) To DS0PR11MB7312.namprd11.prod.outlook.com
 (2603:10b6:8:11f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7312:EE_|IA1PR11MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ad8e76-a50b-4b21-b347-08dc658f4577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UDc4UEFuK2FrWG5FQjZFSis3ZnZ2aVo5Wis1eitpcTd4T0RwSE4zVWdPbk16?=
 =?utf-8?B?OVhoNThQaUh5WHZORVVMREI5Y2V3UmptZ2FPams5RjVxNXVjK0d0ejcwK2FQ?=
 =?utf-8?B?eHk0ZThyYjBnaXFDTUNGOUk2NUYzc1VWUVkvaGF2VnRqT1BxZDlScVBOM3Mz?=
 =?utf-8?B?V2F3N0ptc1BTSTEvdFZDNWorZzVkcm9TU2pvTXdWNThwS1VsWmV3eEp6T21l?=
 =?utf-8?B?Q2VjN2N4RlFhM3NjYlZJcmI4dTV1MUxDVlpURG1yYktHVTR4QnhyWWdtT0hB?=
 =?utf-8?B?SWw4Uit1NXgwYUU0QjJoYlF5RXFjRVhLK0M4YXZCYm55a3ZGUVNOaFpoTjYy?=
 =?utf-8?B?bFd0Z1RMb0NtMHI2V0M2eUhIcHBmVkhqejhWbkQzeGxqVWZtL0ErR3NGdlM3?=
 =?utf-8?B?TXAwVUtQbk1oT1lXczBNamdrRTdURXhNWEF4a3RkREQ5aEljeEl0aGJnU2tC?=
 =?utf-8?B?YVBsUGJEUWwvZmd5YWlnS3pNczFnZktvRHZFMzJ6cjV3NFE0bFNvaGhkQ0Zy?=
 =?utf-8?B?Ly80K2krQ0VRc0NZdnN1TzZMRjlNTWJYdmxGS2Z2M21adFFBNm90bVZGVWtB?=
 =?utf-8?B?TnZNQVF6cTNLVHRRb3N1MTdSQnNlaUpCb2tkdmxJMDFQTEtRaVpnaEFWUHRL?=
 =?utf-8?B?QmR3dkxXb3Z2QmlwQXZ3cW1lMzFJMWJmTWZNeHFwNm40V3VjWHZWdFBqckhv?=
 =?utf-8?B?dWthNXo4L2c3Vkg1TCs1M1U0d1hpYWNRaldseDB2c2QxZG4vTTVsWFBWc052?=
 =?utf-8?B?U3pzMXFNZmNrcVZsSGRrc3RTUmRudUp1RGwyVE5JcjllWngzVTVhRzlaaDB1?=
 =?utf-8?B?cThYQThwem45SXVNaVZVNE12YUJzb0NWUVBvMXVHbGk5OFFOQ2R3eGVXV0do?=
 =?utf-8?B?dzRnak8xblBnV3RCNmxkL2RQNkZyWDZ4M0xISEJablF0WkNkVEg3R21BcExU?=
 =?utf-8?B?SWZVa3RmWG1jNjhkY3dtLzdaWHBLenliblJjSHVlNXljeXdlalo1NnhzZXR0?=
 =?utf-8?B?ODdLczhIMTNESzU3UHFEQjlobUFCOGV2NU82ZmdaWFIwbkNIbkkxSE5Xa0lu?=
 =?utf-8?B?ak4yU0VPQjFEQ2dNRWZheTJHeDBKVmdkT1VJTzh1VjJpdm9RQ0NxY3dDTVJ5?=
 =?utf-8?B?a1lDVWo0Y3BIUnNFSlF4bVpQRXp0TGpiOGQxSm5UY1lyS0FmM2NRN1JnQ3NN?=
 =?utf-8?B?YWJLSm1rQUFUL3lURmU2c2hVenU1cHovZUgvUG52WEhrMlFwb3Jua2JwcDgz?=
 =?utf-8?B?Wm1oUjA4Z0VmazNwdnJTa2Q4NDM2TFRONndKVUE1NXJ4NlAyM1FyTlBYd0xn?=
 =?utf-8?B?OE52cnk3UDhiNHA4bTVUUzJHb3FZcnhHU01EdHdBdGE2N25BTEdIQStXdkJO?=
 =?utf-8?B?ekxLK2FQdlJZNDZNNlgxVWs4Qm16Rk9pdFlCSExiWCswQ3BjUFl2Qyt3NVBE?=
 =?utf-8?B?djdVek43ZU12clpYQWxmK3UyekErN015NDFweVYrTFJZa3BjTXUvVzRnRytk?=
 =?utf-8?B?NHhtclpoZ25vRWEzcHQxSkZJdlg1ZEVNbE5oaC9FVDI4aWdoUzVHR0tMNDJG?=
 =?utf-8?B?bFhkUUdqenhESWJHRjNCTWM0aHVXTCtnanNaQmlJb2NmWTBYZWRMT3JNclky?=
 =?utf-8?B?aEN0SGxScWFFNVNONHBwR0R6OVdHTEJ5U3JxZ082bHNQc1BEYzE1VFRCWkdi?=
 =?utf-8?B?U1VJWlFhSEp0a2NZNTc0UXloWGtJakVBaVFZdkhPemhwRm1TazQzNHl3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7312.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eGV0Q0x5cjUzZjF3bFliR2xQYTk3a1k4Mjh5ZUtlU2FkcWRwWTZFT0hoWUpE?=
 =?utf-8?B?Y09tVDJaUUdaMmhvNUkyNlpKMC9BanBTWnRhLy9NNk1VTWdCOXJFRU5va1Y1?=
 =?utf-8?B?QjZtbE5xdFYrbDMvME9zNWt5aGgvK3JNdTVvNFVxcFJaZVgraXdhSWl4WGtP?=
 =?utf-8?B?WXBrZHNWa0FaZFdLSlNJNVZPM2ZSMVA2WGQrM2xPTmFzMFcxM1RQTnFMakFL?=
 =?utf-8?B?ZGgrdkt0Q0tzdHoyMTNxNGEyQlhwZnFyVkFFazB0SU5DTnRDTGlVekdFTW14?=
 =?utf-8?B?ekZ0Wm02b0xMRHMwMWFyT0lvU0l0azMvbHozajBjZnB3K0VKSDVPY1NPZGsr?=
 =?utf-8?B?QlR4MXA2SmVJVjlrYndJbDlRTG9xck9pSmpUUWVwVlZRVzltMGlGZ0ZsWlhj?=
 =?utf-8?B?UGhjdjU1SFdjcGpZTDVaL0ZwSG5NMzBPSHFUVlppYmRTZnoxWW9qU1lXaFEv?=
 =?utf-8?B?Nlp5cGprSjRvbFBINW44Wjc0V1hNNXdPaHZMb1plOXpoOFh6cGd6Sll0SExG?=
 =?utf-8?B?bTNMUU9pbmhkYTgvUDU0d2xFa3huTFBWTjhDYkxVaG02aDhLaGhwd1Jmd3RT?=
 =?utf-8?B?UXp3eURCZUhqdW04cDBIb01La0V3bG9rd1JPWXFYUTVURGRUamlCdTcwMHE4?=
 =?utf-8?B?UVRrSGJaQ2t0NGllcUYycit5L3BIcjhETlF6WXY1Tkp0K1dlL2Nhbm5LV0I0?=
 =?utf-8?B?cWlBYllWdjBFeGtJY0RYeElRMm5FL3VWa0FkSEN4cjkzWVBUNzcrY2dCS0ZS?=
 =?utf-8?B?TXJjMFJCd1BNVXhkTlk3bkNsMUNJTjl6T215RGtZSm9WenZERGFnOUVkTHZL?=
 =?utf-8?B?azd6cjVOL3hHS1pXbTNmSjNtYjFmdUh5WWlzSFBOblpNQi9zSHNuTXlYNGRO?=
 =?utf-8?B?eUdQY0NhZy9maWNUVXZ5S3NMc2d1Szk4SjR3V3NERVlFaDhyNTJWTVMxczBP?=
 =?utf-8?B?ako2ZlNyZVRXNW5XQWxCMndEVENWZEZNc3NkaDlTZ2dETmtPM01Db3h1UDl4?=
 =?utf-8?B?YWwvV3p6SmlvVk9qalZjMGFXOExrMWNQS1AvRzlwWVFRWFNwYWtUa3h4VmV1?=
 =?utf-8?B?QjU0eHFHQXAxYTlNeXQxb2JKUy9nVllXV0J5RWxyZFVRWXJZeUF1eHd2OHdO?=
 =?utf-8?B?ejU5YktsVjFCakVFdVFpUmNmUWQ5em9WeDViekQwWVJnK3NjQlhsSGdpK2Nu?=
 =?utf-8?B?amFFUUkydG1YZVZZNlp6STM1RW1nR282ek4vVWNPMlRyVzIycW9yL1FkTlpO?=
 =?utf-8?B?TjA3OXJVbHFZRTZvQWNVdFczclV3U2ZPYXF4TllRTC96VG5aK3BaNUtSQlph?=
 =?utf-8?B?bTlRTXU5TmdtbFliajl2aTE3YW80OXIzOEc5bzFaQTRIYkRyaXEzN01WUFU0?=
 =?utf-8?B?aHZoVzdCQUIzUERsdzA4RkpySE9GM1dqODdWcUFMczgzRDZReWJyWVJZWHBX?=
 =?utf-8?B?YzM4dy9HdzhMcFdHTTJiVTZQaERORmdOVmk3T01VMDkzSmZ6dmxPbDBWUnJm?=
 =?utf-8?B?YmtpMWUrazNIMXNCMW40dE5DY3g4UVREVEdZU0FhVUlOZjZLdEE4aEUwMEE0?=
 =?utf-8?B?Yll2SmdtazVUV1BtdG9YRDRpQ1BBUUwyTTQxQzI5OVNEa2JNcndIUlNDNWw4?=
 =?utf-8?B?UUdaaXk3Sk1oaUZoTWtyRTN2RE1ZbVlMWmhwRmNFMUVzK3FmS3ZCUStEOSsr?=
 =?utf-8?B?dGk0SjFrL2gwYXl0Y3VlNHdDSGhIVjV5R0ZFWmMxQmFBZWJud0Q4aW9LZHlZ?=
 =?utf-8?B?dG42UytEcGdtZUw1TFY3NkNhUzhGNWFDYTFPU0ZKOXp6bUE4ME5Gak5jZmFk?=
 =?utf-8?B?eHc0cnFudHgzelRiaUpud1VVdWRFVmxFQTlRSlkyVm5DNXNoUTNwOXBjditr?=
 =?utf-8?B?RnNKU1lzcFAvMTJTVVFsZmtLRWJMd0lQY3JTRUhRU0Q5V2JFVjlYazlTek5o?=
 =?utf-8?B?dDAwY29sSUh3QWFlM0cwVC8vN001TjhNc0RLbHNSQnc5QVpCd2NVMDZjTFFC?=
 =?utf-8?B?ZThqdTJqSDk1Mno1bWI0VndiTFFlOXRXN1pJWlpuZEhBUzRHUVAwU0pkVmF0?=
 =?utf-8?B?M25pUThFeVhaRlJ1K2RSdU1WcC83d0srb1A2eEFGS1RSeFRzTy9MVTgxbEhh?=
 =?utf-8?B?WU5uOHpDV3MzU2QvVXNObEkxYU9BdnR1d1ZzdGdDejduUFBuWEJDOTlUYWF4?=
 =?utf-8?B?aFE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ad8e76-a50b-4b21-b347-08dc658f4577
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 01:22:00.2887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fmMjff0Ve6LIrNmwW9zqJa1TU270SAYPjPepqytTX8PeCW0XbZwjZWYE6kQjlbXtt3Z48qprIYtCfcznbSTQKAh4hlgKAbRdsumUqBAPHjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6220
X-Proofpoint-ORIG-GUID: BvQYSBXUe7ZeSrKC4Cr9bbd1o7AuVbvG
X-Proofpoint-GUID: BvQYSBXUe7ZeSrKC4Cr9bbd1o7AuVbvG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_23,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404260007
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 26 Apr 2024 01:22:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/68

--------------0NU1Pj1U5P5OQFDQVElWmXAp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-MIME-Autoconverted: from 8bit to base64 by mx0a-0064b401.pphosted.com id 43Q1K3DW020985

DQpPbiA0LzI2LzI0IDA1OjU5LCBBbmliYWwgTGltb24gd3JvdGU6DQo+ICoqDQo+ICpDQVVU
SU9OOiBUaGlzIGVtYWlsIGNvbWVzIGZyb20gYSBub24gV2luZCBSaXZlciBlbWFpbCBhY2Nv
dW50ISoNCj4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciANCj4gYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMg
c2FmZS4NCj4gQ29tbWVudHMgYmVsb3csDQo+DQo+IFRoYW5rcyEsDQo+IEFuaWJhbA0KPg0K
PiBPbiBXZWQsIEFwciAyNCwgMjAyNCBhdCA3OjQ34oCvUE0gPGNoYW5ncWluZy5saUB3aW5k
cml2ZXIuY29tPiB3cm90ZToNCj4NCj4gICAgIEZyb206IENoYW5ncWluZyBMaSA8Y2hhbmdx
aW5nLmxpQHdpbmRyaXZlci5jb20+DQo+DQo+ICAgICBzdWJjYXNlIHRlc3RfdGV2ZW50X3Ry
YWNlIHdpbGwgZmFpbCBpZiBydW4gbGlidGV2ZW50LXB0ZXN0IHdpdGgNCj4gICAgIHB0ZXN0
LXJ1bm5lciwgYnV0IGlmIHJ1biBkaXJlY3RseSwgdGhlIHN1YmNhc2UgY2FuIHN1Y2Nlc3Nm
dWxseS4NCj4NCj4gICAgIFRoZSBmYWlsdXJlIHJlbGF0ZWQgdG8gaG93IHB0eSBpcyBzZXR1
cDoNCj4gICAgIEluIGNoaWxkIHByb2dyZXNzLCBhZnRlciBjbG9zZSgwKSwgdGhlIG1hc3Rl
ciBwdHkgd2lsbCB1c2UgMCBhcyBmaWxlDQo+ICAgICBkZXNjcmlwdG9ycywgYW5kIHRoZW4g
bWFzdGVyIHB0eSBpcyBhdHRjaGVkIGFzIGNoaWxkIHN0ZGluLCBhbmQgc2xhdmUNCj4gICAg
IHB0eSB3aWxsIGFsc28gYmUgY2xvc2VkIGJ5IGZ1bmMgY2xvc2VfZmRzLiBUaGlzIHdpbGwg
bWFrZSBlcG9sbF93YWl0DQo+ICAgICB3aWxsIGdldCBzaWduYWwgRVBPTExIVVAsIHRoZW4g
dGVzdCBmYWlsZWQuDQo+DQo+ICAgICBSZWZlcjoNCj4gICAgIGVwb2xsX3dhaXQoMywgW3tl
dmVudHM9RVBPTExPVVR8RVBPTExIVVAsIGRhdGE9e3UzMj0yNjI1ODgzNjQ4LA0KPiAgICAg
dTY0PTk0NDk2MjAxMzYyOTQ0fX1dLCAxLCAzMDAwMCkgPSAxDQo+DQo+ICAgICBscnd4LS0t
LS0tIDEgcm9vdCByb290IDY0IEFwciAyMyAwMTowOCAwIC0+IC9kZXYvcHRteA0KPiAgICAg
bC13eC0tLS0tLSAxIHJvb3Qgcm9vdCA2NCBBcHIgMjMgMDE6MDggMSAtPiAncGlwZTpbNDI2
MV0nDQo+ICAgICBsLXd4LS0tLS0tIDEgcm9vdCByb290IDY0IEFwciAyMyAwMTowOCAyIC0+
ICdwaXBlOls0MjYxXScNCj4NCj4gICAgIFRvIGZpeCB0aGlzOg0KPiAgICAgMS4gT3BlbiBt
YXN0ZXIgcHR5IGluIHBhcmVudCBwcm9jZXNzDQo+ICAgICAyLiBBdHRhY2ggc2xhdmUgcHR5
IHRvIGNoaWxkIHN0ZGluDQo+ICAgICAzLiBSZW1vdmUgZGV0YWNoaW5nIGNvbnRyb2xsaW5n
IHR0eSBmcm9tIHBhcmVudCBwcm9jZXNzDQo+ICAgICA0LiBSZW1vdmUgc2V0aW5nIHByb2Nl
c3MgZ3JvdXBpZCBmb3IgY2hpbGQgcHJvY2Vzcw0KPg0KPiAgICAgUmVmZXI6DQo+ICAgICBs
cnd4LS0tLS0tIDEgcm9vdCByb290IDY0IEFwciAyMyAwNzozNSAwIC0+IC9kZXYvcHRzLzAN
Cj4gICAgIGwtd3gtLS0tLS0gMSByb290IHJvb3QgNjQgQXByIDIzIDA3OjM1IDEgLT4gJ3Bp
cGU6WzM3MDAxXScNCj4gICAgIGwtd3gtLS0tLS0gMSByb290IHJvb3QgNjQgQXByIDIzIDA3
OjM1IDIgLT4gJ3BpcGU6WzM3MDAxXScNCj4NCj4gICAgIFNpZ25lZC1vZmYtYnk6IENoYW5n
cWluZyBMaSA8Y2hhbmdxaW5nLmxpQHdpbmRyaXZlci5jb20+DQo+ICAgICAtLS0NCj4gICAg
IMKgdXRpbHMuYyB8IDY3DQo+ICAgICArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICAgIMKgMSBmaWxlIGNoYW5nZWQsIDM4
IGluc2VydGlvbnMoKyksIDI5IGRlbGV0aW9ucygtKQ0KPg0KPiAgICAgZGlmZiAtLWdpdCBh
L3V0aWxzLmMgYi91dGlscy5jDQo+ICAgICBpbmRleCA0NjkxOGY0Li42YjNhNDkyIDEwMDY0
NA0KPiAgICAgLS0tIGEvdXRpbHMuYw0KPiAgICAgKysrIGIvdXRpbHMuYw0KPiAgICAgQEAg
LTM0MSwyNSArMzQxLDMxIEBAIHJ1bl9jaGlsZChjaGFyICpydW5fcHRlc3QsIGludCBmZF9z
dGRvdXQsDQo+ICAgICBpbnQgZmRfc3RkZXJyKQ0KPiAgICAgwqAgwqAgwqAgwqAgLyogZXhp
dCgxKTsgbm90IG5lZWRlZD8gKi8NCj4gICAgIMKgfQ0KPg0KPiAgICAgKy8qIFJldHVybnMg
YW4gaW50ZWdlci4NCj4gICAgICsgKiBJZiBpdCByZXR1cm5zIDwgMCwgYW4gZXJyb3IgaGFz
IG9jY3VycmVkLg0KPiAgICAgKyAqIE90aGVyd2lzZSwgcmV0dXJuIDAgbWVhbnMgc3VjY2Vz
c2Z1bGx5DQo+ICAgICArICogZnAgc2hvdWxkIGJlIHdyaXRhYmxlLCBsaWtlbHkgc3Rkb3V0
L2Vyci4NCj4gICAgICsgKi8NCj4gICAgICtzdGF0aWMgaW50DQo+ICAgICArc2V0dXBfbWFz
dGVyX3B0eShpbnQqIHB0eV9tYXN0ZXIsIGludCogcHR5X3NsYXZlLCBjaGFyKnB0eV9uYW1l
LA0KPiAgICAgRklMRSAqZnApIHsNCj4gICAgICvCoCDCoCDCoCDCoGlmIChvcGVucHR5KHB0
eV9tYXN0ZXIsIHB0eV9zbGF2ZSwgcHR5X25hbWUsIE5VTEwsIE5VTEwpIDwNCj4gICAgIDAp
IHsNCj4gICAgICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZwcmludGYoZnAsICJFUlJPUjog
b3BlbnB0eSgpIGZhaWxlZCB3aXRoOiAlcy5cbiIsDQo+ICAgICBzdHJlcnJvcihlcnJubykp
Ow0KPiAgICAgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC0xOw0KPiAgICAgK8Kg
IMKgIMKgIMKgfQ0KPiAgICAgK8KgIMKgIMKgIMKgcmV0dXJuIDA7DQo+ICAgICArfQ0KPiAg
ICAgKw0KPiAgICAgwqAvKiBSZXR1cm5zIGFuIGludGVnZXIgZmlsZSBkZXNjcmlwdG9yLg0K
PiAgICAgwqAgKiBJZiBpdCByZXR1cm5zIDwgMCwgYW4gZXJyb3IgaGFzIG9jY3VycmVkLg0K
PiAgICAgwqAgKiBPdGhlcndpc2UsIGl0IGhhcyByZXR1cm5lZCB0aGUgc2xhdmUgcHR5IGZp
bGUgZGVzY3JpcHRvci4NCj4gICAgIMKgICogZnAgc2hvdWxkIGJlIHdyaXRhYmxlLCBsaWtl
bHkgc3Rkb3V0L2Vyci4NCj4gICAgIMKgICovDQo+ICAgICDCoHN0YXRpYyBpbnQNCj4gICAg
IC1zZXR1cF9zbGF2ZV9wdHkoRklMRSAqZnApIHsNCj4gICAgIC3CoCDCoCDCoCDCoGludCBw
dHlfbWFzdGVyID0gLTE7DQo+ICAgICAtwqAgwqAgwqAgwqBpbnQgcHR5X3NsYXZlID0gLTE7
DQo+ICAgICAtwqAgwqAgwqAgwqBjaGFyIHB0eV9uYW1lWzI1Nl07DQo+ICAgICArc2V0dXBf
c2xhdmVfcHR5KGNoYXIqIHB0eV9uYW1lLCBGSUxFICpmcCkgew0KPiAgICAgwqAgwqAgwqAg
wqAgc3RydWN0IGdyb3VwICpncHRyOw0KPiAgICAgwqAgwqAgwqAgwqAgZ2lkX3QgZ2lkOw0K
PiAgICAgwqAgwqAgwqAgwqAgaW50IHNsYXZlID0gLTE7DQo+DQo+ICAgICAtwqAgwqAgwqAg
wqBpZiAob3BlbnB0eSgmcHR5X21hc3RlciwgJnB0eV9zbGF2ZSwgcHR5X25hbWUsIE5VTEws
IE5VTEwpDQo+ICAgICA8IDApIHsNCj4gICAgIC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZw
cmludGYoZnAsICJFUlJPUjogb3BlbnB0eSgpIGZhaWxlZCB3aXRoOiAlcy5cbiIsDQo+ICAg
ICBzdHJlcnJvcihlcnJubykpOw0KPiAgICAgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0
dXJuIC0xOw0KPiAgICAgLcKgIMKgIMKgIMKgfQ0KPiAgICAgLQ0KPiAgICAgwqAgwqAgwqAg
wqAgaWYgKChncHRyID0gZ2V0Z3JuYW0ocHR5X25hbWUpKSAhPSAwKSB7DQo+ICAgICDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBnaWQgPSBncHRyLT5ncl9naWQ7DQo+ICAgICDCoCDCoCDC
oCDCoCB9IGVsc2Ugew0KPiAgICAgQEAgLTM4NCw5ICszOTAsOSBAQCBzZXR1cF9zbGF2ZV9w
dHkoRklMRSAqZnApIHsNCj4gICAgIMKgIMKgIMKgIMKgIGlmICgoc2xhdmUgPSBvcGVuKHB0
eV9uYW1lLCBPX1JEV1IpKSA9PSAtMSkgew0KPiAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgZnByaW50ZihmcCwgIkVSUk9SOiBvcGVuKCkgZmFpbGVkIHdpdGg6ICVzLlxuIiwNCj4g
ICAgIHN0cmVycm9yKGVycm5vKSk7DQo+ICAgICDCoCDCoCDCoCDCoCB9DQo+ICAgICAtwqAg
wqAgwqAgwqByZXR1cm4gKHNsYXZlKTsNCj4gICAgIC19DQo+DQo+ICAgICArwqAgwqAgwqAg
wqByZXR1cm4gc2xhdmU7DQo+ICAgICArfQ0KPg0KPiAgICAgwqBpbnQNCj4gICAgIMKgcnVu
X3B0ZXN0cyhzdHJ1Y3QgcHRlc3RfbGlzdCAqaGVhZCwgY29uc3Qgc3RydWN0IHB0ZXN0X29w
dGlvbnMgb3B0cywNCj4gICAgIEBAIC00MDYsMTYgKzQxMiwxMyBAQCBydW5fcHRlc3RzKHN0
cnVjdCBwdGVzdF9saXN0ICpoZWFkLCBjb25zdA0KPiAgICAgc3RydWN0IHB0ZXN0X29wdGlv
bnMgb3B0cywNCj4NCj4gICAgIMKgIMKgIMKgIMKgIGRvDQo+ICAgICDCoCDCoCDCoCDCoCB7
DQo+ICAgICAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoaXNhdHR5KDApICYmIGlvY3Rs
KDAsIFRJT0NOT1RUWSkgPT0gLTEpIHsNCj4gICAgIC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGZwcmludGYoZnAsICJFUlJPUjogVW5hYmxlIHRvIGRldGFjaCBmcm9t
DQo+ICAgICBjb250cm9sbGluZyB0dHksICVzXG4iLCBzdHJlcnJvcihlcnJubykpOw0KPiAg
ICAgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfQ0KPiAgICAgLQ0KPiAgICAgLQ0KPiAgICAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZnByaW50ZihmcCwgIlNUQVJUOiAlc1xuIiwgcHJv
Z25hbWUpOw0KPiAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUFRFU1RfTElTVF9JVEVS
QVRFX1NUQVJUKGhlYWQsIHApDQo+ICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBpbnQgcGlwZWZkX3N0ZG91dFsyXSA9IHstMSwgLTF9Ow0KPiAgICAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaW50IHBpcGVmZF9zdGRlcnJbMl0gPSB7
LTEsIC0xfTsNCj4gICAgIC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlu
dCBwZ2lkID0gLTE7DQo+ICAgICArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBpbnQgcHR5X21hc3RlciA9IC0xOw0KPiAgICAgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgaW50IHB0eV9zbGF2ZSA9IC0xOw0KPiAgICAgK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgY2hhciBwdHlfbmFtZVsyNTZdID0gezB9Ow0KPg0KPiAg
ICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKHBpcGUyKHBpcGVm
ZF9zdGRvdXQsIDApID09IC0xKSB7DQo+ICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByYyA9IC0xOw0KPiAgICAgQEAgLTQzNSw4ICs0Mzgs
OSBAQCBydW5fcHRlc3RzKHN0cnVjdCBwdGVzdF9saXN0ICpoZWFkLCBjb25zdA0KPiAgICAg
c3RydWN0IHB0ZXN0X29wdGlvbnMgb3B0cywNCj4gICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIH0NCj4gICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIGRpcm5hbWUocHRlc3RfZGlyKTsNCj4NCj4gICAgIC3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGlmICgocGdpZCA9IGdldHBnaWQoMCkpID09IC0xKSB7DQo+
ICAgICAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBm
cHJpbnRmKGZwLCAiRVJST1I6IGdldHBnaWQoKQ0KPiAgICAgZmFpbGVkLCAlc1xuIiwgc3Ry
ZXJyb3IoZXJybm8pKTsNCj4NCj4NCj4gVGhpcyBjb21lcyBmcm9tIFJhbmR5IHBhdGNoIHRv
IGVuc3VyZSBjaGlsZCB0ZXN0cyBhcmUgaW4gdGhlIHNhbWUgDQo+IHByb2Nlc3MgZ3JvdXAg
dGhhbiB0aGUgcHRlc3QtcnVubmVyLMKgNTkzODFhNjQuIEFueSBzcGVjaWZpYyByZWFzb24g
dG8gDQo+IHJlbW92ZSB0aGlzPy4NClNlZSBibG93IGNvbW1lbnRzIHdoZXJlIHBnaWQgaXMg
dXNlZC4NCj4NCj4gICAgICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlm
IChzZXR1cF9tYXN0ZXJfcHR5KCZwdHlfbWFzdGVyLA0KPiAgICAgJnB0eV9zbGF2ZSwgcHR5
X25hbWUsIGZwKSA8IDApIHsNCj4gICAgICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGZwcmludGYoZnAsICJFUlJPUjoNCj4gICAgIHNldHVwX21h
c3Rlcl9wdHkgZmFpbGVkLCAlc1xuIiwgc3RyZXJyb3IoZXJybm8pKTsNCj4gICAgICvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOw0KPiAg
ICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfQ0KPg0KPiAgICAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcGlkX3QgY2hpbGQgPSBmb3JrKCk7
DQo+ICAgICBAQCAtNDQ3LDI1ICs0NTEsMzIgQEAgcnVuX3B0ZXN0cyhzdHJ1Y3QgcHRlc3Rf
bGlzdCAqaGVhZCwgY29uc3QNCj4gICAgIHN0cnVjdCBwdGVzdF9vcHRpb25zIG9wdHMsDQo+
ICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9IGVsc2UgaWYgKGNo
aWxkID09IDApIHsNCj4gICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIGludCBzbGF2ZTsNCj4NCj4gICAgIC3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNsb3NlKDApOw0KPiAgICAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogQ2xvc2UgcmVhZCBl
bmRzIG9mIHRoZSBwaXBlICovDQo+ICAgICBkb19jbG9zZSgmcGlwZWZkX3N0ZG91dFtQSVBF
X1JFQURdKTsNCj4gICAgIGRvX2Nsb3NlKCZwaXBlZmRfc3RkZXJyW1BJUEVfUkVBRF0pOw0K
PiAgICAgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
ZG9fY2xvc2UoJnB0eV9tYXN0ZXIpOw0KPg0KPiAgICAgLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKChzbGF2ZSA9IHNldHVwX3NsYXZlX3B0
eShmcCkpDQo+ICAgICA8IDApIHsNCj4gICAgICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICgoc2xhdmUgPQ0KPiAgICAgc2V0dXBfc2xhdmVf
cHR5KHB0eV9uYW1lLCBmcCkpIDwgMCkgew0KPiAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZnByaW50ZihmcCwgIkVS
Uk9SOiBjb3VsZA0KPiAgICAgbm90IHNldHVwIHB0eSAoJWQpLiIsIHNsYXZlKTsNCj4gICAg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH0NCj4g
ICAgIC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlm
IChzZXRwZ2lkKDAscGdpZCkgPT0gLTEpIHsNCj4gICAgIC3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZwcmludGYoZnAsICJF
UlJPUjoNCj4gICAgIHNldHBnaWQoKSBmYWlsZWQsICVzXG4iLCBzdHJlcnJvcihlcnJubykp
Ow0KPiAgICAgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgfQ0KPg0KVGhlIHBnaWQgaXMgdXNlZCB0byBzZXQgY2hpbGQgcHJvY2VzcyB0byBqb2lu
IHRoZSBzYW1lIHByb2dyZXNzIGdyb3VwIGFzIA0KcGFyZW50Lg0KDQpCdXQgbmV4dCBsaW5l
LMKgIHdlIHdpbGwgbWFrZSBjaGlsZCBhcyBzZXNzaW9uIGxlYWRlcizCoCB0aGVuIHRoZSBj
aGlsZCANCndpbGwgYWxzbyBiZSBpbiB0aGUgbmV3IHByb2dyZXNzIGdyb3VwLg0KDQpTbyBh
Ym92ZSBzZXRwZ2lkIGFjdHVhbGx5IG5vdCBuZWVkLsKgIEhlcmUgaXMgdGhlIHByb2Nlc3Mg
c3RhdCB3aXRoIA0KcHRlc3QtcnVubmVyKHdpdGhvdXQgdGhpcyBwYXRjaCk6DQoNCnJvb3RA
cWVtdXg4Ni02NDp+IyBjYXQgL3Byb2MvNDU1L3N0YXQNCjQ1NSAocHRlc3QtcnVubmVyKSBT
IDQyMiAqNDU1KiAyODMgMCAtMSA0MTk0MzA0IDEwOSAwIDAgMCAwIDIgMCAwIDIwIDAgMSAN
CjAgNjIwMDkgMjQ0MTIxNiAzNTIgMTg0NDY3NDQwNzM3MDk1NTE2MTUgOTQyNTgxNTQzNjQ5
MjggOTQyNTgxNTQzNzM1ODUgDQoxNDA3MjIzMjAyMzI4NDggMCAwIDAgMCAwIDAgMSAwIDAg
MTcgMCAwIDAgMCAwIDAgOTQyNTgxNTQzODQzODQgDQo5NDI1ODE1NDM4NTQyNCA5NDI1ODE1
NDM4OTUwNCAxNDA3MjIzMjAyNDAxNTUgMTQwNzIyMzIwMjQwMTc4IA0KMTQwNzIyMzIwMjQw
MTc4IDE0MDcyMjMyMDI0MDYxMCAwDQpyb290QHFlbXV4ODYtNjQ6fiMgY2F0IC9wcm9jLzQ1
Ni9zdGF0DQo0NTYgKHJ1bi1wdGVzdCkgUyA0NTUgKjQ1NiogNDU2IDM0ODE3IDQ1NiA0MTk0
NTYwIDI0MiAwIDAgMCAwIDAgMCAwIDIwIDAgDQoxIDAgNjIwNjUgMzgxMzM3NiA2NDAgMTg0
NDY3NDQwNzM3MDk1NTE2MTUgOTQ2MTI0MDAyMDk5MjAgOTQ2MTI0MDA5MDMyMjUgDQoxNDA3
MjQ2NzI4NDMyNDggMCAwIDAgNjU1MzYgNCA2NTUzOCAxIDAgMCAxNyAxIDAgMCAwIDAgMCA5
NDYxMjQwMTE1MDY3MiANCjk0NjEyNDAxMTk4MzcyIDk0NjEyNDAxMjQ2MjA4IDE0MDcyNDY3
Mjg1MTQ0NiAxNDA3MjQ2NzI4NTE0OTEgDQoxNDA3MjQ2NzI4NTE0OTEgMTQwNzI0NjcyODUx
OTIzIDANCnJvb3RAcWVtdXg4Ni02NDp+Iw0KDQpXZSBjYW4gc2VlLMKgIGFsdGhvdWdowqBz
ZXRwZ2lkLMKgIGJ1dCBmaW5hbGx5LMKgIHdlIHBnaWQgb2YgY2hpbGQgd2lsbCBiZSANCnRo
ZSBjaGlsZCBwaWQuDQoNCj4NCj4gICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIGlmIChzZXRzaWQoKSA9PcKgIC0xKSB7DQo+ICAgICDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBmcHJpbnRmKGZwLCAiRVJST1I6DQo+ICAgICBzZXRzaWQoKSBmYWlsZWQsICVzXG4iLCBz
dHJlcnJvcihlcnJubykpOw0KPiAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgfQ0KPg0KPiAgICAgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGlvY3RsKDAsIFRJT0NTQ1RUWSwgTlVMTCkg
PT0gLTEpIHsNCj4gICAgICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGlmIChpb2N0bChzbGF2ZSwgVElPQ1NDVFRZLCBOVUxMKQ0KPiAgICAgPT0g
LTEpIHsNCj4gICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIGZwcmludGYoZnAsICJFUlJPUjogVW5hYmxlDQo+ICAgICB0
byBhdHRhY2ggdG8gY29udHJvbGxpbmcgdHR5LCAlc1xuIiwgc3RyZXJyb3IoZXJybm8pKTsN
Cj4gICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IH0gDQo+DQo+ICAgICArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBpZiAoc2xhdmUgPiAyKSB7DQo+ICAgICArwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjbG9zZShzbGF2ZSk7DQo+
ICAgICArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9
DQo+ICAgICArDQo+ICAgICArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBpZiAoZHVwMihwdHlfc2xhdmUsIFNURElOX0ZJTEVOTykNCj4gICAgIDwg
MCkgew0KPiAgICAgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgZnByaW50ZihmcCwgIkVSUk9SOiBVbmFibGUNCj4gICAgIHRv
IGR1cCBzbGF2ZSBwdHkgdG8gc3RkaW4sICVzXG4iLCBzdHJlcnJvcihlcnJubykpOw0KPiAg
ICAgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfQ0K
PiAgICAgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
aWYgKHB0eV9zbGF2ZSA+IDIpIHsNCj4gICAgICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNsb3NlKHB0eV9zbGF2ZSk7DQo+
ICAgICArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9
DQo+DQo+IFdoaWNoIGlzIHRoZSByZWFzb24gdG8gbWFrZSBpdCB0d2ljZT8sIGFuZCBhbHNv
IGNsb3Npbmcgd2l0aCBzbGF2ZSA+IDIuDQoNCmZpcnN0LMKgIGFjY29yZGluZ8KgIHRvIGN1
cnJlbnQgY29kZSBsb2dpYyzCoCB0aGUgc2xhdmUvcHR5X3NsYXZlIHNob3VsZCANCmFsd2F5
cyA+IDIswqAgdGhlIGlmIGNoZWNraW5nIGp1c3QgZm9yIGVuc3VyZSBpdCBpcy4NCg0KcHR5
X3NsYXZlIGFuZCBzbGF2ZSBhcmUgcG9pbnQgdG8gc2xhdmUgcHR5LMKgIGJ1dCB0aGV5IGhh
dmUgZGlmZmVyZW50IA0KZmQuwqAgU28gSSBuZWVkIHRvIGNsb3NlIHRoZW0gYm90aCBhZnRl
ciBkdXAgc2xhdmUgcHR5IHRvIHN0ZGluLg0KDQo+DQo+ICAgICDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoY2hkaXIocHRlc3RfZGlyKSA9
PSAtMSkgew0KPiAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgZnByaW50ZihmcCwgIkVSUk9SOiBVbmFibGUNCj4gICAg
IHRvIGNoZGlyKCVzKSwgJXNcbiIsIHB0ZXN0X2Rpciwgc3RyZXJyb3IoZXJybm8pKTsNCj4g
ICAgIEBAIC00ODEsMTAgKzQ5Miw2IEBAIHJ1bl9wdGVzdHMoc3RydWN0IHB0ZXN0X2xpc3Qg
KmhlYWQsIGNvbnN0DQo+ICAgICBzdHJ1Y3QgcHRlc3Rfb3B0aW9ucyBvcHRzLA0KPiAgICAg
ZG9fY2xvc2UoJnBpcGVmZF9zdGRvdXRbUElQRV9XUklURV0pOw0KPiAgICAgZG9fY2xvc2Uo
JnBpcGVmZF9zdGRlcnJbUElQRV9XUklURV0pOw0KPg0KPiAgICAgLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHNldHBnaWQoY2hpbGQsIHBn
aWQpID09IC0xKSB7DQo+ICAgICAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmcHJpbnRmKGZwLCAiRVJST1I6DQo+ICAgICBz
ZXRwZ2lkKCkgZmFpbGVkLCAlc1xuIiwgc3RyZXJyb3IoZXJybm8pKTsNCj4gICAgIC3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH0NCj4gICAgIC0N
Cj4NCj4gUmVtb3ZhbCBjb21tZW50IHVwLg0KDQpTYW1lIGFzIHdoYXQgSSBjb21tZW50cyBh
Ym92ZSzCoCBjaGlsZCBpcyBpbiBhbm90aGVyIHNlc3Npb24swqAgc28gdGhpcyBpcyANCm5v
dCBuZWVkZWQuDQoNCg0KUmVnYXJkcw0KDQpDaGFuZ3FpbmcNCg0KPiAgICAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdGltZV90IHN0YXJ0X3Rp
bWU9IHRpbWUoTlVMTCk7DQo+ICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBmcHJpbnRmKGZwLCAiJXNcbiIsDQo+ICAgICBnZXRfc3RpbWUo
c3RpbWUsIEdFVF9TVElNRV9CVUZfU0laRSwgc3RhcnRfdGltZSkpOw0KPiAgICAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZnByaW50ZihmcCwg
IkJFR0lOOiAlc1xuIiwgcHRlc3RfZGlyKTsNCj4gICAgIEBAIC02MDgsNiArNjE1LDggQEAg
cnVuX3B0ZXN0cyhzdHJ1Y3QgcHRlc3RfbGlzdCAqaGVhZCwgY29uc3QNCj4gICAgIHN0cnVj
dCBwdGVzdF9vcHRpb25zIG9wdHMsDQo+ICAgICBkb19jbG9zZSgmcGlwZWZkX3N0ZG91dFtQ
SVBFX1dSSVRFXSk7DQo+ICAgICBkb19jbG9zZSgmcGlwZWZkX3N0ZGVycltQSVBFX1JFQURd
KTsNCj4gICAgIGRvX2Nsb3NlKCZwaXBlZmRfc3RkZXJyW1BJUEVfV1JJVEVdKTsNCj4gICAg
ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRvX2Nsb3NlKCZwdHlfbWFz
dGVyKTsNCj4gICAgICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRvX2Ns
b3NlKCZwdHlfc2xhdmUpOw0KPg0KPiAgICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgZmZsdXNoKGZwKTsNCj4gICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIGZmbHVzaChmcF9zdGRlcnIpOw0KPiAgICAgLS0gDQo+ICAgICAyLjI1LjEN
Cj4=
--------------0NU1Pj1U5P5OQFDQVElWmXAp
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 43Q1K3DW020985

<!DOCTYPE html><html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 4/26/24 05:59, Anibal Limon wrote:<=
br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:CAOU5ZMue2AZxq_7fJTVn6LEXPPXWrn=
-D7UFdzX43xvvJV6yQEA@mail.gmail.com">
     =20
      <strong>
      </strong>
      <div style=3D"border:solid #9c6500 1pt;padding:2pt;background:#fcfc=
03"><strong><class=3D"msonormal" style=3D"line-height:11pt"><span style=3D=
"font-size:11pt;color:#000">CAUTION: This email
              comes from a non Wind River email account!</span></class=3D=
"msonormal"></strong><br>
        <class=3D"msonormal" style=3D"line-height:10pt3"><span style=3D"f=
ont-size:10pt;color:#000">Do not click links or open
            attachments unless you recognize the sender and know the
            content is safe.</span><br>
        </class=3D"msonormal"></div>
      <div>
        <div dir=3D"ltr">
          <div dir=3D"ltr">Comments below,</div>
          <div dir=3D"ltr"><br>
          </div>
          <div>Thanks!,</div>
          <div>Anibal</div>
          <br>
          <div class=3D"gmail_quote">
            <div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 24, 2024 at
              7:47=E2=80=AFPM &lt;<a href=3D"mailto:changqing.li@windrive=
r.com" moz-do-not-send=3D"true" class=3D"moz-txt-link-freetext">changqing=
.li@windriver.com</a>&gt;
              wrote:<br>
            </div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              From: Changqing Li &lt;<a href=3D"mailto:changqing.li@windr=
iver.com" target=3D"_blank" moz-do-not-send=3D"true" class=3D"moz-txt-lin=
k-freetext">changqing.li@windriver.com</a>&gt;<br>
              <br>
              subcase test_tevent_trace will fail if run libtevent-ptest
              with<br>
              ptest-runner, but if run directly, the subcase can
              successfully.<br>
              <br>
              The failure related to how pty is setup:<br>
              In child progress, after close(0), the master pty will use
              0 as file<br>
              descriptors, and then master pty is attched as child
              stdin, and slave<br>
              pty will also be closed by func close_fds. This will make
              epoll_wait<br>
              will get signal EPOLLHUP, then test failed.<br>
              <br>
              Refer:<br>
              epoll_wait(3, [{events=3DEPOLLOUT|EPOLLHUP,
              data=3D{u32=3D2625883648, u64=3D94496201362944}}], 1, 30000=
) =3D 1<br>
              <br>
              lrwx------ 1 root root 64 Apr 23 01:08 0 -&gt; /dev/ptmx<br=
>
              l-wx------ 1 root root 64 Apr 23 01:08 1 -&gt;
              'pipe:[4261]'<br>
              l-wx------ 1 root root 64 Apr 23 01:08 2 -&gt;
              'pipe:[4261]'<br>
              <br>
              To fix this:<br>
              1. Open master pty in parent process<br>
              2. Attach slave pty to child stdin<br>
              3. Remove detaching controlling tty from parent process<br>
              4. Remove seting process groupid for child process<br>
              <br>
              Refer:<br>
              lrwx------ 1 root root 64 Apr 23 07:35 0 -&gt; /dev/pts/0<b=
r>
              l-wx------ 1 root root 64 Apr 23 07:35 1 -&gt;
              'pipe:[37001]'<br>
              l-wx------ 1 root root 64 Apr 23 07:35 2 -&gt;
              'pipe:[37001]'<br>
              <br>
              Signed-off-by: Changqing Li &lt;<a href=3D"mailto:changqing=
.li@windriver.com" target=3D"_blank" moz-do-not-send=3D"true" class=3D"mo=
z-txt-link-freetext">changqing.li@windriver.com</a>&gt;<br>
              ---<br>
              &nbsp;utils.c | 67
              ++++++++++++++++++++++++++++++++-------------------------<b=
r>
              &nbsp;1 file changed, 38 insertions(+), 29 deletions(-)<br>
              <br>
              diff --git a/utils.c b/utils.c<br>
              index 46918f4..6b3a492 100644<br>
              --- a/utils.c<br>
              +++ b/utils.c<br>
              @@ -341,25 +341,31 @@ run_child(char *run_ptest, int
              fd_stdout, int fd_stderr)<br>
              &nbsp; &nbsp; &nbsp; &nbsp; /* exit(1); not needed? */<br>
              &nbsp;}<br>
              <br>
              +/* Returns an integer.<br>
              + * If it returns &lt; 0, an error has occurred.<br>
              + * Otherwise, return 0 means successfully<br>
              + * fp should be writable, likely stdout/err.<br>
              + */<br>
              +static int<br>
              +setup_master_pty(int* pty_master, int* pty_slave,
              char*pty_name, FILE *fp) {<br>
              +&nbsp; &nbsp; &nbsp; &nbsp;if (openpty(pty_master, pty_sla=
ve, pty_name, NULL,
              NULL) &lt; 0) {<br>
              +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;fpr=
intf(fp, &quot;ERROR: openpty() failed with:
              %s.\n&quot;, strerror(errno));<br>
              +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ret=
urn -1;<br>
              +&nbsp; &nbsp; &nbsp; &nbsp;}<br>
              +&nbsp; &nbsp; &nbsp; &nbsp;return 0;<br>
              +}<br>
              +<br>
              &nbsp;/* Returns an integer file descriptor.<br>
              &nbsp; * If it returns &lt; 0, an error has occurred.<br>
              &nbsp; * Otherwise, it has returned the slave pty file
              descriptor.<br>
              &nbsp; * fp should be writable, likely stdout/err.<br>
              &nbsp; */<br>
              &nbsp;static int<br>
              -setup_slave_pty(FILE *fp) {<br>
              -&nbsp; &nbsp; &nbsp; &nbsp;int pty_master =3D -1;<br>
              -&nbsp; &nbsp; &nbsp; &nbsp;int pty_slave =3D -1;<br>
              -&nbsp; &nbsp; &nbsp; &nbsp;char pty_name[256];<br>
              +setup_slave_pty(char* pty_name, FILE *fp) {<br>
              &nbsp; &nbsp; &nbsp; &nbsp; struct group *gptr;<br>
              &nbsp; &nbsp; &nbsp; &nbsp; gid_t gid;<br>
              &nbsp; &nbsp; &nbsp; &nbsp; int slave =3D -1;<br>
              <br>
              -&nbsp; &nbsp; &nbsp; &nbsp;if (openpty(&amp;pty_master, &a=
mp;pty_slave,
              pty_name, NULL, NULL) &lt; 0) {<br>
              -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;fpr=
intf(fp, &quot;ERROR: openpty() failed with:
              %s.\n&quot;, strerror(errno));<br>
              -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ret=
urn -1;<br>
              -&nbsp; &nbsp; &nbsp; &nbsp;}<br>
              -<br>
              &nbsp; &nbsp; &nbsp; &nbsp; if ((gptr =3D getgrnam(pty_name=
)) !=3D 0) {<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; gid=
 =3D gptr-&gt;gr_gid;<br>
              &nbsp; &nbsp; &nbsp; &nbsp; } else {<br>
              @@ -384,9 +390,9 @@ setup_slave_pty(FILE *fp) {<br>
              &nbsp; &nbsp; &nbsp; &nbsp; if ((slave =3D open(pty_name, O=
_RDWR)) =3D=3D -1) {<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fpr=
intf(fp, &quot;ERROR: open() failed with:
              %s.\n&quot;, strerror(errno));<br>
              &nbsp; &nbsp; &nbsp; &nbsp; }<br>
              -&nbsp; &nbsp; &nbsp; &nbsp;return (slave);<br>
              -}<br>
              <br>
              +&nbsp; &nbsp; &nbsp; &nbsp;return slave;<br>
              +}<br>
              <br>
              &nbsp;int<br>
              &nbsp;run_ptests(struct ptest_list *head, const struct
              ptest_options opts,<br>
              @@ -406,16 +412,13 @@ run_ptests(struct ptest_list *head,
              const struct ptest_options opts,<br>
              <br>
              &nbsp; &nbsp; &nbsp; &nbsp; do<br>
              &nbsp; &nbsp; &nbsp; &nbsp; {<br>
              -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if =
(isatty(0) &amp;&amp; ioctl(0,
              TIOCNOTTY) =3D=3D -1) {<br>
              -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp;fprintf(fp, &quot;ERROR: Unable to
              detach from controlling tty, %s\n&quot;, strerror(errno));<=
br>
              -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<b=
r>
              -<br>
              -<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fpr=
intf(fp, &quot;START: %s\n&quot;, progname);<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; PTE=
ST_LIST_ITERATE_START(head, p)<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; int pipefd_stdout[2] =3D {-1, -1};<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; int pipefd_stderr[2] =3D {-1, -1};<br>
              -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp;int pgid =3D -1;<br>
              +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp;int pty_master =3D -1;<br>
              +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp;int pty_slave =3D -1;<br>
              +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp;char pty_name[256] =3D {0};<br>
              <br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; if (pipe2(pipefd_stdout, 0) =3D=3D -1)
              {<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; rc =3D -1;<br>
              @@ -435,8 +438,9 @@ run_ptests(struct ptest_list *head,
              const struct ptest_options opts,<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; }<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; dirname(ptest_dir);<br>
              <br>
              -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp;if ((pgid =3D getpgid(0)) =3D=3D -1) {<br>
              -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;fprintf(fp, &quot;ER=
ROR:
              getpgid() failed, %s\n&quot;, strerror(errno));<br>
            </blockquote>
            <div><br>
            </div>
            <div>This comes from Randy patch to ensure child tests are
              in the same process group than the ptest-runner,&nbsp;59381=
a64.
              Any specific reason to remove this?. <br>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    See blow comments where pgid is used.<br>
    <blockquote type=3D"cite" cite=3D"mid:CAOU5ZMue2AZxq_7fJTVn6LEXPPXWrn=
-D7UFdzX43xvvJV6yQEA@mail.gmail.com">
      <div>
        <div dir=3D"ltr">
          <div class=3D"gmail_quote">
            <div>&nbsp;</div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp;if
              (setup_master_pty(&amp;pty_master, &amp;pty_slave,
              pty_name, fp) &lt; 0) {<br>
              +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;fprintf(fp, &quot;ER=
ROR:
              setup_master_pty failed, %s\n&quot;, strerror(errno));<br>
              +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;break;<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; }<br>
              <br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; pid_t child =3D fork();<br>
              @@ -447,25 +451,32 @@ run_ptests(struct ptest_list *head,
              const struct ptest_options opts,<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; } else if (child =3D=3D 0) {<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; int slave;<br>
              <br>
              -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;close(0);<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* Close read ends o=
f the
              pipe */<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              do_close(&amp;pipefd_stdout[PIPE_READ]);<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              do_close(&amp;pipefd_stderr[PIPE_READ]);<br>
              +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;do_close(&amp;pty_ma=
ster);<br>
              <br>
              -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if ((slave =3D
              setup_slave_pty(fp)) &lt; 0) {<br>
              +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if ((slave =3D
              setup_slave_pty(pty_name, fp)) &lt; 0) {<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; fprintf(fp,
              &quot;ERROR: could not setup pty (%d).&quot;, slave);<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
              -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (setpgid(0,pgid) =
=3D=3D -1)
              {<br>
              -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;fprintf(fp,
              &quot;ERROR: setpgid() failed, %s\n&quot;, strerror(errno))=
;<br>
              -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
            </blockquote>
          </div>
        </div>
      </div>
    </blockquote>
    <p>The pgid is used to set child process to join the same progress
      group as parent.</p>
    <p>But next line,&nbsp; we will make child as session leader,&nbsp; t=
hen the
      child will also be in the new progress group.&nbsp; <br>
    </p>
    <p>So above setpgid actually not need.&nbsp; Here is the process stat
      with ptest-runner(without this patch):</p>
    <p>root@qemux86-64:~# cat /proc/455/stat<br>
      455 (ptest-runner) S 422 <b>455</b> 283 0 -1 4194304 109 0 0 0 0
      2 0 0 20 0 1 0 62009 2441216 352 18446744073709551615
      94258154364928 94258154373585 140722320232848 0 0 0 0 0 0 1 0 0 17
      0 0 0 0 0 0 94258154384384 94258154385424 94258154389504
      140722320240155 140722320240178 140722320240178 140722320240610 0<b=
r>
      root@qemux86-64:~# cat /proc/456/stat<br>
      456 (run-ptest) S 455 <b>456</b> 456 34817 456 4194560 242 0 0 0
      0 0 0 0 20 0 1 0 62065 3813376 640 18446744073709551615
      94612400209920 94612400903225 140724672843248 0 0 0 65536 4 65538
      1 0 0 17 1 0 0 0 0 0 94612401150672 94612401198372 94612401246208
      140724672851446 140724672851491 140724672851491 140724672851923 0<b=
r>
      root@qemux86-64:~# <br>
    </p>
    <p>We can see,&nbsp; although&nbsp;setpgid,&nbsp; but finally,&nbsp; =
we pgid of child
      will be the child pid. </p>
    <blockquote type=3D"cite" cite=3D"mid:CAOU5ZMue2AZxq_7fJTVn6LEXPPXWrn=
-D7UFdzX43xvvJV6yQEA@mail.gmail.com">
      <div>
        <div dir=3D"ltr">
          <div class=3D"gmail_quote">
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              <br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (setsid() =3D=3D&=
nbsp; -1) {<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; fprintf(fp,
              &quot;ERROR: setsid() failed, %s\n&quot;, strerror(errno));=
<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
              <br>
              -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (ioctl(0, TIOCSCT=
TY,
              NULL) =3D=3D -1) {<br>
              +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (ioctl(slave,
              TIOCSCTTY, NULL) =3D=3D -1) {<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; fprintf(fp,
              &quot;ERROR: Unable to attach to controlling tty, %s\n&quot=
;,
              strerror(errno));<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }&nbsp;</blockquote>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (slave &gt; 2) {<=
br>
              +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;close(slave);<br>
              +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
              +<br>
              +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (dup2(pty_slave,
              STDIN_FILENO) &lt; 0) {<br>
              +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;fprintf(fp,
              &quot;ERROR: Unable to dup slave pty to stdin, %s\n&quot;,
              strerror(errno));<br>
              +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
              +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (pty_slave &gt; 2=
) {<br>
              +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;close(pty_slave);<br>
              +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
            </blockquote>
            <div>Which is the reason to make it twice?, and also closing
              with slave &gt; 2.<br>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <p>first,&nbsp; according&nbsp; to current code logic,&nbsp; the slav=
e/pty_slave
      should always &gt; 2,&nbsp; the if checking just for ensure it is.<=
/p>
    <p>pty_slave and slave are point to slave pty,&nbsp; but they have
      different fd.&nbsp; So I need to close them both after dup slave pt=
y to
      stdin.</p>
    <blockquote type=3D"cite" cite=3D"mid:CAOU5ZMue2AZxq_7fJTVn6LEXPPXWrn=
-D7UFdzX43xvvJV6yQEA@mail.gmail.com">
      <div>
        <div dir=3D"ltr">
          <div class=3D"gmail_quote">
            <div>
            </div>
            <div>&nbsp;</div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              <br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (chdir(ptest_dir)=
 =3D=3D
              -1) {<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; fprintf(fp,
              &quot;ERROR: Unable to chdir(%s), %s\n&quot;, ptest_dir,
              strerror(errno));<br>
              @@ -481,10 +492,6 @@ run_ptests(struct ptest_list *head,
              const struct ptest_options opts,<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              do_close(&amp;pipefd_stdout[PIPE_WRITE]);<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
              do_close(&amp;pipefd_stderr[PIPE_WRITE]);<br>
              <br>
              -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (setpgid(child, p=
gid)
              =3D=3D -1) {<br>
              -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;fprintf(fp,
              &quot;ERROR: setpgid() failed, %s\n&quot;, strerror(errno))=
;<br>
              -&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
              -<br>
            </blockquote>
            <div>Removal comment up.</div>
          </div>
        </div>
      </div>
    </blockquote>
    <p>Same as what I comments above,&nbsp; child is in another session,&=
nbsp; so
      this is not needed.</p>
    <p><br>
    </p>
    <p>Regards</p>
    <p>Changqing<br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:CAOU5ZMue2AZxq_7fJTVn6LEXPPXWrn=
-D7UFdzX43xvvJV6yQEA@mail.gmail.com">
      <div>
        <div dir=3D"ltr">
          <div class=3D"gmail_quote">
            <div>&nbsp;</div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; time_t start_time=3D
              time(NULL);<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fprintf(fp, &quot;%s=
\n&quot;,
              get_stime(stime, GET_STIME_BUF_SIZE, start_time));<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fprintf(fp, &quot;BE=
GIN: %s\n&quot;,
              ptest_dir);<br>
              @@ -608,6 +615,8 @@ run_ptests(struct ptest_list *head,
              const struct ptest_options opts,<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp;
              do_close(&amp;pipefd_stdout[PIPE_WRITE]);<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp;
              do_close(&amp;pipefd_stderr[PIPE_READ]);<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp;
              do_close(&amp;pipefd_stderr[PIPE_WRITE]);<br>
              +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp;do_close(&amp;pty_master);<br>
              +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp;do_close(&amp;pty_slave);<br>
              <br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; fflush(fp);<br>
              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; fflush(fp_stderr);<br>
              -- <br>
              2.25.1<br>
              <br>
            </blockquote>
          </div>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------0NU1Pj1U5P5OQFDQVElWmXAp--

