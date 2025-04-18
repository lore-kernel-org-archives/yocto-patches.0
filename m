Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D5FC369AB
	for <webhook@archiver.kernel.org>; Fri, 18 Apr 2025 13:09:47 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.11222.1744981782129958913
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 18 Apr 2025 06:09:42 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=6203b7563d=yi.zhao@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53IAo3aB017824;
	Fri, 18 Apr 2025 13:09:20 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45ydd1qnu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Apr 2025 13:09:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=of5FtZGqyIpgDUX60+FGgoE/SBoH88ajjILR65tHXWs77ylJ47aKfbFlKKJuUorMRWhdDgUEE0W5EBBQKDiudOUFJnNG9t/8W41GwoBsbCL/VhimCGG34urMADJGfr9lgcBitxxTXkJ62fj2V4bLsMx+53vXrApwiWdJ+4kX8myKehXDrYZ7vYRBv0g+19zgmbz1Nki1DFpIlekAJEUsme3VUGKTLpsLSMm9F58vAgK2YG1eiV120LIbj9vXjUmhYdxyGhs3QYrhL5eHVJ7YScFSbSCoGpcAiTeiEY3OaV2fhMONM/8yz7EDi7ip5AfHKRJWTxF4tenR614WqCHgug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXVcWxhamwFbnC0ZAA/LoWFkl/69xx71mEKyUh01RXM=;
 b=jhoR7qa+CI3zS0+bgVRuO0dIG6EhLjtlRXP0X1dXSR3lDyAYPkU7isMfQp79G8ny4WDe6ouZ75IUDITBd/IdoCYEvuTVtWWVrCG9lEuf3ct1M5u4eKZW6K4lHdoFgxYBGP5uwhPP/pI3x++1dxx6tMIFkrJWPV6GC2pvbThzWWIoXw1j0DsntMieH1DPJwlyth+RtOA6hfYiWeCk0lYc3PQHlVbbKQo8wzLWJGpz10CWDOAlZ89hmdJ8pgl5fONVsWIliZpeKDS6bXQxh2FvQNg2ZvQj3DxTVOqNTQeKYMlTWkpU7Hg/ECDdqaAFSIykfcKfTRqY64/lsfjLhYKBvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.32; Fri, 18 Apr 2025 13:09:16 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%4]) with mapi id 15.20.8655.025; Fri, 18 Apr 2025
 13:09:16 +0000
Message-ID: <0157a70d-bd73-4e23-8f56-a1fe080ced68@windriver.com>
Date: Fri, 18 Apr 2025 21:09:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][PATCH] scap-security-guide:
 disable ptest by default
To: yocto-patches@lists.yoctoproject.org,
        Gyorgy Sarvari <skandigraun@gmail.com>
References: <20250418051738.2928980-1-yi.zhao@windriver.com>
 <3211d1e0-2bc7-4fe0-9db5-12a534c3d09c@gmail.com>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <3211d1e0-2bc7-4fe0-9db5-12a534c3d09c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0172.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::10) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|SJ0PR11MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: b632a85c-ddbd-487a-3bda-08dd7e7a38b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|4022899009;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TGc3blFFaG9TclVjdGZxS1FDNFRlSWVxZDBoak5rZDUyRU9zcW13ZmovSEJv?=
 =?utf-8?B?NytPb2svUy9NaWdFU1ZMQTN1cUM0YzBlb1kyaDZ3cVJXeC9nVXBYUWVEck1a?=
 =?utf-8?B?aitqT0RXWGlhUUlqTXJTdHc3Ukk2TWhvbjJxTlcvYTc2M1F3Wlg4dE1TdkFZ?=
 =?utf-8?B?RVF4TXMzNlZLWTJUbmtnYnErS3Bpd0duQXphZ2czTzM0UUZSNnF4MDhNOWQ3?=
 =?utf-8?B?aFdmSUV6bkZ5RTVneE0yQlJHaVZWQUpwMk15WFA4NElRVXFLUjczMWFsOTdh?=
 =?utf-8?B?MkppTC81dEVvLy8raFgwYmtTdDhyVEJGTW9XdWxxdG1pQkdMRU5EY29vd29n?=
 =?utf-8?B?amIrWXJDNGJFS1pIWnd4dEh5bEdLdDl0ZlRBVTR2Y3lpMy9Yc1NDb0VkQkZQ?=
 =?utf-8?B?SmJSZmtNQ25kNks4Y1g3NTFPRzE2clkvRHpzRHFVR1ZWZWhYRysvQS81Q3ZW?=
 =?utf-8?B?aW81VXNOWVlpRVNDaldDNkgwWndwalQybWpFYm5QYUpia212YkhtcWZDT1V5?=
 =?utf-8?B?UlNHV3FkZGpKZUZuQmVJOVNVMlhlUU5PbzRLRnc5R042MHdyY0YzNkJZMHpi?=
 =?utf-8?B?Nk0vSXdTVXRqZXFwOHBvYjJUYzdxeCtXdjN2bXdsNU5NV1RSRFRweXozVkY4?=
 =?utf-8?B?K2ZOK3J1enVTUWthMDVIMzR0a2RMZXRPWi9BVlBCMXpXc3R2WUkzaU9pNXZP?=
 =?utf-8?B?YkdwU2k1K2VOS1ZFRkFZR1NmeGYwaE9EZmRpeTNNVmNDbUVCelg0TzlpWTlw?=
 =?utf-8?B?WS9wMGQvZkRhV3QvZW9LckxudHdma1o2cnA0Wk9Mazl4eGRMdDlmS0s2a2c2?=
 =?utf-8?B?ajNYRFFuZkw0emhNVGRGSU81ZVJHOFd0UmVuVjAyZmNNQWRHdE1ta0xmRlpi?=
 =?utf-8?B?VWlLcWNDcDhnQjRNb0hnbWF1azF0YjdSMEVHaTVuVyt5b2pDcUIxTStIRHpm?=
 =?utf-8?B?WDNIRE5vQ1JnZWNXQVNWTkxvaXBrNm83N2d2Sm40ZTh6V04xeFNHUVZ1cmQx?=
 =?utf-8?B?YlBPZWp2RHpZbXBqQUZabHFLb1ZtOGxpSWJSMkd2QW94S01lR1VseU5xWHBq?=
 =?utf-8?B?STh0bGx3MlpsQjBFeldZN1dMTVNSdW14aEhESVNacWFjZFJmUTdLTmxuclI5?=
 =?utf-8?B?a3Z3U0dsbWFXcjlzWFJ0RjgycUtoYW5xYktnSUtDTmNPOGM5M2gySFp5OGFW?=
 =?utf-8?B?ZTFJSEFQSUZLdzRJUjhQUitQWGNVOWptcGZyT3pKTTRvRGNxSm43RHV2K21Y?=
 =?utf-8?B?d1BYMXhxNUgxOG1WbnZJcGFidmYyTlBQZFpDZS9MaGJvTW82U3hjaHZXYjVj?=
 =?utf-8?B?akVIZmx4Wk9jRXowM2tEb09EWlFWL0w3cXRnRDBTTFJBMmxhZVFHMkEzVGpC?=
 =?utf-8?B?ajBuSkdyVFRvUGcxckRkWHZwMUM0WnFjUkVTR2VsOHo4dXB2aUJhMWxEOXZT?=
 =?utf-8?B?U1M4cUkzcDdmekovVVNUYm1DNVFSUFVQdEY3d0daTlp1bGdvcEJudWR6VU9j?=
 =?utf-8?B?SkNPMzJxb0ZvUmRIb29JTkpvbi9YUlFybEpOcUwrRW00RWZkYWpXL0hLQ25m?=
 =?utf-8?B?MEZMc0oxdHVlem56UWgxSG05UlRCUzNXVTNteXQ2RXJTQzBIRkw1Q0FNSmgr?=
 =?utf-8?B?V0U5YzdaL2tGMXVsekVVSExQdjkycnZQU2pMNmpxRjFnVzFtdi94bjE1QnJt?=
 =?utf-8?B?MVNpL0wwQjI5dkc2VmRmNjRPMDBkd2dPZzBGL0I0dTJ5dWRMdWdZUXltUE1t?=
 =?utf-8?B?ZXFZV3ZLeGE2bU9JNGl3VWtRV1QxL1ErQ3orZm5OUG40QitkRTFBZVlPQ0Nw?=
 =?utf-8?B?L3ZSbTA0ODVTT3RIaDhnOHhqS1FzclRXMVBNZFJLR2RValhkSFhYUWluaTQ0?=
 =?utf-8?Q?kMn1qax7QwjwA?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(4022899009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TXh4d0ZrOFByNlp5SmpjbzRRcWJwNzAwR2VmWVZyU0hIZ1ZiV1FpL25ES3Zy?=
 =?utf-8?B?ckE0TytHdVZiMDdhTnNVWm55cTEyZVFiYm5zVDBKaUovMWQyTU9LNkNqcmhH?=
 =?utf-8?B?anBOTkZNbzhObUkrTmZ0ZHIvSVE4Z3JaZVNiUzQyV1R3M3JYWmdrdU1MTjhK?=
 =?utf-8?B?WVl1OTFwdGQxMGZDZkZVeDFOWXF6clhDWGNqMHlRYW9MNXF4cFRtYnZNZVV1?=
 =?utf-8?B?SGZQY2pEclNETWM2S2JNSnZOOUJCcWMzcVJ3ZWFNQjRxMXJlM21TYkxWZWZl?=
 =?utf-8?B?MTcvOFlTZW5uSTZRbTVUVkpreWZDQm9rRS9IcWc3WHk1M1NCcnQ2bElSL2t3?=
 =?utf-8?B?OXE0UHBLcEpNRlV5em5pSXQ2ZVBWdTF4R2VnSTZYU1pYdVZpTG5rNnNrSDlx?=
 =?utf-8?B?Mk03YWpiQkF6eVUwZStNSzUyaHRHMVliL2U3OWJSc3dUV2pod3VEZXU3RDdE?=
 =?utf-8?B?cGx4VXZkQlhEQ044R0praUxBeE1DdUtUdEJtN1Y2MDRTeklFQkVtRTl0VFRJ?=
 =?utf-8?B?KzlrMzhWa1NxUlpreEMva2d3U3FlY3BmSVREcHJESFkrUXozUFlTWGxGbjd6?=
 =?utf-8?B?amV3eVM1YXQvQkZoWFc5eHF4SnN3cHQyczk2d3VwdnlDYjZHa2U4anpjQ0xL?=
 =?utf-8?B?Y0ZYMndiL05MZnJjZVB0UU4rWmJyZzNZTGlIb3EvUXdFc2VZN1NYNXZKZTNP?=
 =?utf-8?B?Qk0ybWFqSkV2YlMvU3hNMGJNdEtIOTdEWUxjZ2d3Q1laSnl4NUlrbS8vWW5F?=
 =?utf-8?B?UDRGUkRMMncyRHJZeVFHNVZOVDF3NlZzY3I1RG1oYzluSkFMa3Q1TkZXQkJO?=
 =?utf-8?B?cWVlUGJXOFYyNm02cmRjOGF1WUFFSkJ2LzNyU0xBcjU3Sm9td0pzMnYybFBS?=
 =?utf-8?B?VzBHWnM4dm9heHo1eTVxMmxMRnB6UVE5MmR0amdEMXlMWGNzVi8xaE40VWRF?=
 =?utf-8?B?S01Cb25WNGVSaVBuZ3psU1F0Q052amFBbFRsdjY1TTN0QUNsQWhtVnNBdU5Q?=
 =?utf-8?B?b0cyNmEyelFhOWlpZ0JpR3JZYlMrVkwySXQ1R0lZWnl6NDBoZGo3TGZqeS9v?=
 =?utf-8?B?WndKdmcwUWR3WnFMR0pYZmRtWTdLS0djdXk0Y0VBWERCMGZIRmdOSkhnK3lj?=
 =?utf-8?B?azlEdlE2cm1XU01uSkdncWNTZDRUK1N5d1pmZVBhVUQ2b3hVcklLbjkrTjZl?=
 =?utf-8?B?SjJJUURjS2RzQTMyODk4dVhjVEo1M3lSRjdRZHphd0xwVjFrd1F3ZkQ1VkhO?=
 =?utf-8?B?YysvZzI2Z21KSk02dHplOHJTV3MwK2xHcFgxbmEwWGFmMlVYcnI0N21Od0JW?=
 =?utf-8?B?N0dxQldWazJ6ei8rbHJJRGxkZ1JJTGt1WDczT050R3QxbzVzUVh4RXkvN0cw?=
 =?utf-8?B?NU1xOXQzM2Z4cURGdEN1b1RSRVVid3ZFTUFIK3BYZ0RKMDNjdmk0dk91cXBT?=
 =?utf-8?B?TGdKVDJ4MExJd0VRR2dWZHpHMFErbzJCUStXM3RITmVKUXdPTGdYU3ZzYjNk?=
 =?utf-8?B?TGZSaUJPZElYb0o4QnBSVXYvN2FwSFZTbGlQcmNmSUhJRmpzQWFCeGNtZlh6?=
 =?utf-8?B?TmozZHhVbEFwZ3hLbzVxSVVKbHYzbGwzWnUxOG40Nmd1UjdwUDlkK0Fab3Jh?=
 =?utf-8?B?Z2llT3drOWtlRCs3aFI4cEtZU3Mrcm9iZ2VMWEdQZVBVZ0VWZk95SzRUckJ6?=
 =?utf-8?B?U2hyNkF4S1hhYzdXaEhQMWw1YmRjU2lSTStuand0THlrczFEQktZZ3MxYTZm?=
 =?utf-8?B?TG54QU1kM0g0Vnh4ZEcwaFF0aUxaYkRYaDlNb1diN05GQnJ3YzV6aTlxQ0Rr?=
 =?utf-8?B?TGZpbysveUFUczduZ2FNUU4xODM2T09DV1RhMkk2Ti9RYkFhMGxMNm51TEd1?=
 =?utf-8?B?aTdlWTZuTUhVYXgxSDdYSThUcU1LTndnVkdsbHo3K3Q2eWdzb3phcWthOTZp?=
 =?utf-8?B?L2dGUEFnSWZUeEtMUmVmNzBVM3JET09RL2dtUWQ0elJtZ3VFSStYK2tCaUhz?=
 =?utf-8?B?d2Q5SklXcVJLSWJFUFB4QjgrZWFwa3UvVStiOEI2Z0FRa2VuVzZ0TFlhQW1V?=
 =?utf-8?B?dmIzVzdIREVlZ0VYVXBUTGdjbXVYcGtqSUE5RXhlT3RCeWVpdk8rS3p5V01y?=
 =?utf-8?Q?jJ5QNW4TBEeMa7pPpVAxoOPIa?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b632a85c-ddbd-487a-3bda-08dd7e7a38b8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 13:09:16.0734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KL+q5+JbdXlCpNnBAkeIjGrdGciKIQmrFuHS6d4TXvyHeT5MNWrZnj95OjNvQro5loVD8oH2+PXr/MxRiJDRjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7704
X-Proofpoint-ORIG-GUID: 4TOcoum-hqdiizlYexJA_hWjjBYMUcMC
X-Proofpoint-GUID: 4TOcoum-hqdiizlYexJA_hWjjBYMUcMC
X-Authority-Analysis: v=2.4 cv=HecUTjE8 c=1 sm=1 tr=0 ts=68024f00 cx=c_pps a=E4Q64eWPmlOcdHW0GAz4hQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8 a=D--cc_5GbZqzY8PhnQwA:9 a=QEXdDO2ut3YA:10 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_04,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 mlxlogscore=875 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504180097
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 18 Apr 2025 13:09:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1384


On 4/18/25 18:42, Gyorgy Sarvari via lists.yoctoproject.org wrote:
> On 4/18/25 07:17, Yi Zhao via lists.yoctoproject.org wrote:
>> +SSG_PTEST_ENABLED = "0"
> Wouldn't "?=" be better, so it could be modified easier from local.conf
> (&co) and env vars also, instead of only bbappend?

Thanks, I will send v2.


//Yi



>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1383): https://lists.yoctoproject.org/g/yocto-patches/message/1383
> Mute This Topic: https://lists.yoctoproject.org/mt/112326886/7283133
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13170635/7283133/1683771902/xyzzy [yi.zhao@eng.windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

