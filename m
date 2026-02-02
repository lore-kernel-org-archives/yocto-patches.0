Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FB1E73147
	for <webhook@archiver.kernel.org>; Mon,  2 Feb 2026 08:48:56 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48634.1770022135283570813
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 02 Feb 2026 00:48:55 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=khnq1oND;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=649358f35e=yi.zhao@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6124vKsx2225996;
	Mon, 2 Feb 2026 08:48:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=A5q4zWtbrlDG3VsUT0sx3zUxiZWHYnWFpaIAQVWBoZg=; b=
	khnq1oNDl8kaIDBgYO8rixxOBLxgaCseQoHw3cPpeg9286oHVx6wSapNlaEes/Ra
	l5KZWzwPAA89rfvUL78zCHz14wG6K/81qqvLnUsjXsJr342apDZWv8sv6XgnPEy4
	Z79FYMmuC5vTZjxiIey6xgjmdsYtXiK6y+z2Xu8mQfzWqf0b3dbbYqJRXP+yuRxM
	T6Q5Q+ZRuO2xs+rCoPJg+Mnhft3H80dxH6c5HZqC4SA/1nN3hn7X241h9O0Vr4qc
	2lDhrPIHFSgJu9s5gwHetv8dLc7X7Eb5GfWWggof8RbcgfzctlTkUYFkiWoV0/84
	8Q38Zh4HjpnkPyFSAlA0pA==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013053.outbound.protection.outlook.com [40.107.201.53])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4c188jst83-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 08:48:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTbmzEAa/7d3MMuFutwjnjggHNTnZQUP2ZlZlOY2rFBlYl6ggv1Xiwjmr6cPYXsvblPQh88z+SZvcwk7N+WVWmWO66RG39jvQoxU1f4MwlkJ95JOkMOOrHanfoM+Rvs9qrAGyR5MI2GjVfSO3uMJzhYM0Pd8hCGc+mGUp5GqGFvM0ePGBUNT9elnP9vmUwCeFhQbqmpvt96F2TdMGpurggTkpCBfxblxL5steJD0yDefhyWBHMmuX0TU/6g4mi9vfbOob0tSVAOQDQgReLay1aSZuDr8nSTnJXJejOTqkMVmukBQNfNSLdtdCGyl2DcoVNHxG9KLaSWDkp5rUlqKtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5q4zWtbrlDG3VsUT0sx3zUxiZWHYnWFpaIAQVWBoZg=;
 b=j2/xBURCQnw0Mvo4/wqTHXgGpBRPAYKtw5U3FBkz9ZCGuZj8vU9Ot1FEg9Zt3IB/LJd/IcJHytZKPutYC8zZuijtjDn3zP9Jfd6yOc1JT3JxMKjA2CLBm8AVYnmhMmmqgRmLmOhb8IgY65QzuchpiDF1dTrMqL09cnRgBSP8dJjDWcv8/RZ7CWpIccKXHj0+8IykPxbAERDSjRjicRxl6pdq/vkL/fgeg3sdZFTjEE+EjfQN8u05emXaR+9zC/WE5apkwdbrrRPDP27fn6VU98wO7qprpcOeJF0CSkNLK4ogaHpZul2amygXNbweehVmq5nJIzQGlHFydHz7iVJwqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 SJ0PR11MB5789.namprd11.prod.outlook.com (2603:10b6:a03:424::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 08:48:51 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::3432:2eb3:d0a5:7831%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 08:48:50 +0000
Message-ID: <00839a86-21d3-4de4-bad8-f301f6aaa050@windriver.com>
Date: Mon, 2 Feb 2026 16:48:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-selinux][PATCH] pd-mapper: Introduce
 SELinux domain for pd-mapper
To: Gangabhavani Yenugula <gyenugul@qti.qualcomm.com>
Cc: "yocto-patches@lists.yoctoproject.org"
 <yocto-patches@lists.yoctoproject.org>
References: <20260130102853.2437991-1-gyenugul@qti.qualcomm.com>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <20260130102853.2437991-1-gyenugul@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: TY1PR01CA0206.jpnprd01.prod.outlook.com (2603:1096:403::36)
 To DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|SJ0PR11MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: c834d204-f2db-4a16-e37e-08de6237e312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TlNLYVhVSVRZZVJFSkhLSXNXM2pXbW5VVk9VNDAvaU1tekgzSEgxSk94ZTJF?=
 =?utf-8?B?WFRSeXJOL2s0d2Raekx3bDAzL05TdWM5bENzQW8weDZxdUM4SzR6OXE1cGxC?=
 =?utf-8?B?cWFlc3VaRFc5eDFSUnVSeHVrZnBqRk5oWEFPRTk4U0hMZ0dqR0M5QjVUWWgv?=
 =?utf-8?B?dmluVU1qUGViRUJJcElseVZ6YnNYcWE1aUpXRXVqSUhwVGIxMm9MeTh5cmow?=
 =?utf-8?B?VG9EZ1pEdUdiNDVyMjd3K1JHcWZNekkvbExKOE1YcWY5S3VPSXpSOWJWN3BK?=
 =?utf-8?B?RWdZd2pLSktCbFluSmo3VmJ0WHVxY0ovZEtoRzlUQ3NXL2ozNzc4R29SeWxX?=
 =?utf-8?B?NkVCbE9MQ2NhT1ljVlQ0dlQ4dVpaZml2VHFmNlppUkpwc0Y1cFpWZmROVW9W?=
 =?utf-8?B?Zk9XUElKOUNReTg0N3lwYzN2V2ZuYVRiSjFxMjVOVlh3QWhwSUFySkoyWEps?=
 =?utf-8?B?SlF1QjFtanVjUXBNSkIweTJKM3NIZGk4WUNhRmRoRm0xTWhVeHhpVklkbVE5?=
 =?utf-8?B?RDAzZjF3L0cvRkF5Q1RVczFmZ2R5N0hSd0p1UUNvZFVFdlV3SEx4bEowYW44?=
 =?utf-8?B?bGw4a3ZRSUlXRVFSdmdpejdjd2g2SDBpOGZPamZuTmVFSlVXSTVUd054UnVZ?=
 =?utf-8?B?d3VXZnZsTDAxb3N1c2ZnZ2NPZ1hWOHBjOUFES3MzQjZMZ2R5RzRSQTVTdlRF?=
 =?utf-8?B?V2xSNXVENjlXY0FNNi9ZVzFSSjl1ZERNRW1OY0E4V3ZnUkcraFBEWEFHL2tl?=
 =?utf-8?B?aE42dG9QZDNHU1VjNVl2L052N1FYakpmMkVWSG9iZlhsZUcxdGRSKythM3Az?=
 =?utf-8?B?aEJWYWpEZmlBY3liNm1QZGlvSTEyNHhhVjUxWm5VaUczL29rZHBWa1ByTUlV?=
 =?utf-8?B?KzZlTXd3YlRHcjNiamd5OUxYRVVmMHNFeW9hRUxTcHlXdHc2MlJXNXdqYlk3?=
 =?utf-8?B?dHBIUzhBMWRLRklsOVNTN214ZlhqWkVQbUx1ZVhMVWt4eUZiMWJZY24yemtR?=
 =?utf-8?B?YzV6V2dKMVQvdnp2Ui9KNnFWVlA3aGFTcVlJcS8vd25XOFFVeWd1aGZ6ZUlU?=
 =?utf-8?B?ajRMd3dDWWpmNytrTGxNcmdyMm03UVNXQXBpV3pRTVBsS3paSjc5anJhejJm?=
 =?utf-8?B?TFZ0ZEZRMkpMcVNLVmJNc0pGZlhycjdNSFBLQkJKU1J5cmt4bEI0T1drKzE3?=
 =?utf-8?B?TzYvT3pGeS8rTHViWTh3cHJIMDRDT04rd1o1Sk0zbHIxUG5yU1ZQbkxOQlJC?=
 =?utf-8?B?VGhQNmtGYzI2RGNDSUZrMXBXUEhVUEg5Z0UvTkoySGVxSlZmb2duVVU5V20r?=
 =?utf-8?B?M3dSYWwrQ1g1RWtQT3p1M0RnalBvcml0TjUxL0JpWnNqS3kyL2tHVmRtYnoz?=
 =?utf-8?B?b3JMUy9SdFgrbnh5aWQycjRqMks3WkpRY2pNWXRFNVZjWXJnVHM3ekRsdGJj?=
 =?utf-8?B?VCt0NENFWjFBd0NackNoNlNGQzNiVkhnMjBQWUgvNjM0cnZIOUlRd3ZrejFo?=
 =?utf-8?B?WmpqZllqNGdZZ2pRQTIzd3RSbEZET1RXR3diQ2lyeEloSXhIbHhXaVQvNGF3?=
 =?utf-8?B?blJHN0VIa1RWUEJKbHJkcUxBNHpUQXRjSDRuZ0xoTE8yd2wwb0ZIVmkzM3FG?=
 =?utf-8?B?NmwvSVRiZk9US3FyY2Z6blg2cFhiZFhJanVDV1BrVG0vV3RuL2JuZi9mckwv?=
 =?utf-8?B?WlZQZDRlUkhuOWp1bjh1SGVtUnRzL1pidzE3Q1p4V2dQcFFvTVZuRFpiYXJQ?=
 =?utf-8?B?aURtc3A0RWhxNFZzYnJUVXlVZktOeVZWemhndzdRdHhTbEVQcVFoVVpLQjBq?=
 =?utf-8?B?MDRSODRiUmZTRkVwZVMyMXJTYVFpYnNjRk04bENhalN4c1I3c2NFQ0o0ZGlR?=
 =?utf-8?B?WTRqNG1hSzFGYkRsS25mRk03aitGa21tOEcwZWYrdW84UWtrM0V0cXUzUjBF?=
 =?utf-8?B?eFVjS1lDWVZSUlNIOFkxSUZPSkFwZWhYbkgzR1BVSVdUTU9mazBDbnJyVkVM?=
 =?utf-8?B?NXRJRmdHS1oxUWJCMWRRc1doaVJ6U0RkUkdWdDVIQmJsUlhjak0xYmg0aERI?=
 =?utf-8?Q?2vdi1k?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?THcwQVRaWXlhVDBDbnBIWFFoc0h4RUNQbkZXR0IxaU81ZytxVWFTRGh0MS9U?=
 =?utf-8?B?RGhmeGU0WlV5WTlLSnN1b015YjlZViswbml2NThhb0E4YTgvaXdzTHZRSXBG?=
 =?utf-8?B?TFJjWmdIT000OEh5T2Jic3hsckMwZlNQZG1kMFJ3SzBCZnN2R3NkZnlnM3Ir?=
 =?utf-8?B?K3pTNkFDT2dvdlhCS1o5clZXWHlPN2pQQXlpOXVJSHV6YkdNL0hxR3labDFw?=
 =?utf-8?B?QnNKT3V5OXVjVEVWUGxUUnlDcS9JSE9MSytFSC9qei9jcjZEd2pNcDRNRTdS?=
 =?utf-8?B?NEp4OUJqVGZLelVtdml6YXVPZEV2TEQ5ZFJ6UlVNdmFtY2pjVFpDTm1pOWVq?=
 =?utf-8?B?YThWaE91dU1oRUJEOTJ5OW9oNjFibGJkWERwYXBDVnN2UEFsMFJTOWhudmlC?=
 =?utf-8?B?WW91TlNXN1M1M0orMXo3aThzTUFMWVVyVE5wdENPbHpLVlJNSTZnaFVoSjNx?=
 =?utf-8?B?ZDFrRmJNaUM4ODRQY3lDTTZBMk04dGxibS9iMTdTKzVlWFdyWXRWdkhoZnhw?=
 =?utf-8?B?bWdra2o0RytWeHRKZkpkb3c2a08zQ2xpWS80YnNpcm1WMm1JWUtvY2VuMm5V?=
 =?utf-8?B?c1p6TEZ4THM0ZkVlRVJ6Z3Z6SmQ3d0lCRmVJYnYybzBrR1pmRUVtcjhrMkJN?=
 =?utf-8?B?UTRyZXBEZjJRVVlJbWxVMEJPa3dUMkNoaDVIQlhOdkJpcEhYYURYOGVpNVVB?=
 =?utf-8?B?REV5VGViVFBEdElwRi9yeVdPOERwUjlnUGhJdkxRRU0xTzhXNVFoREM4NHZp?=
 =?utf-8?B?Tlh4MFBzUGU2UEVVQ0VZeGVUbDhUaUUvNDl2cTNDUFBWZWR5RjlSZ0VSamJh?=
 =?utf-8?B?cHdBR0hRVU1RSDk2TmNEMUhJUE1DaVNQRG1hcUpZVjhwMDBGUVR5YSsrbHlD?=
 =?utf-8?B?SFIxOVpES0V0bWhQUlF4emVydjdkT2RTWjVFNFVTMGhEOGlTZ3J4S0hRa2Q2?=
 =?utf-8?B?VEZLR1dtQmY2WjRLR2xHMEJWdkV6SHMwMmxUaFB0RTNMUnFXMk5xdHdXRml3?=
 =?utf-8?B?ZmZtbU1wQk5EVFJLbjRIUlpUaUI3UThrVkZMSGZLR2hycWpjU1htWHJYUmQ2?=
 =?utf-8?B?Z3ZjMEMwdWcwMzBBSW9SS0FIb041Tm8vTHRVRFdudzZBdnJxeW5zM2xPekl5?=
 =?utf-8?B?UE1MZlJRV2UwdTBpbkw3Rm9VT2xNRXNmdFd5ZVFqNEJmWTZXNFl6M3EvQkIy?=
 =?utf-8?B?czhSMWdlSHc5aGlnZWhTMlllbGVxUlJpRGhvbnlsVFZ5QmVNeThSVCtvODgy?=
 =?utf-8?B?bERSeEZMYkM4RE9leEhBUElPK3ovekI1NzRCUE1xci9CeGJkOUJRMkUxNzc4?=
 =?utf-8?B?UDBKSS90ZnNQbUoybU9aaUxDcjlGaDZJWHg4MHlhRis3K2VDYUw3bHNYL3U2?=
 =?utf-8?B?eTlveG05TUg2MXY5WXpDeExMWndsUEFRbWI0ZVlkdGFGZXl2MWdyT1RMVGFh?=
 =?utf-8?B?V0dJTnc5NWJZeHVQbVl0ZFpTMzBYMGdkU3E5SnUyY3JZVzJOeU5LYk9KYVVp?=
 =?utf-8?B?SWcwc1dWQkJoNFBmek54SVlDMXFUdHphSTh1Qk5Wb2EzNVJZRUN5UVVlT1Nq?=
 =?utf-8?B?M3VEZGV5SkRwTk5sb2pvL2ZleGdaR2Ztc1o5L0ZMd2dXTGdLb25YNlNmZ2Z2?=
 =?utf-8?B?NHBabGRKdFZZYVBGdkc2Y2FSVHp2eXlERmVvd0FaQlpsZHVJbEZJemtZOFl6?=
 =?utf-8?B?NjJSYmVISitQeHN6WDdTSW1vSmd2K2dYUEhUYVZlYmFlNTNwVU1NWmFQbGw4?=
 =?utf-8?B?N2xOSnJiQnJWZWFBWGNFTmVtUWRKTEhIcWwvTDB4MU9PbGVYQlR5Z2ZZaWFa?=
 =?utf-8?B?VzBVN3dzVFFKTE9ySzZXcEZnZGw3ZEJNbWpseGFnUmxMYmN2VHdRNEN1ZEFx?=
 =?utf-8?B?NEhoSlBhZ3NkK2F0b3Q4QWlPS29paklSaittQVhKL0JtOGNPVnhhLzc1Y2pH?=
 =?utf-8?B?d0VkTi90TXBtTVVPcUhCZDdBZzN1Tzc5S2l3SjNibmFQa1F2aWlwUGZiaHFz?=
 =?utf-8?B?eitCTnVGbHpsUHEvSHMvNFBSd2NvQURjVWFXU3h6b2t5UTNsZjd1eHZKUWdw?=
 =?utf-8?B?RGI3ZFd4ZU41cXJsUU93WTc3Sk0xdXRKbGR6bFlvcnlmdHJjNUJKdVRocnVO?=
 =?utf-8?B?UFJHRzFRc3NpL0t1dXFrWjhHSWZZeEYvMTd4a1I1MlMwOHhRUWVqcVgrdFY4?=
 =?utf-8?B?TzJmZmswUklReFVYQnJxNnA1ZzJZb1BRUks4anRqV3pLbTZXUmZmbFEzYzRX?=
 =?utf-8?B?S0I4U2dKQWswVGNJR0lQMUo0dzJNMHM1MkhQS2huekFUVGVMZGlidEl0OWZy?=
 =?utf-8?B?N2JJVGNoUGQ5NUF5MjdnY29WM1kxSWt5MXNvQzFISnM0bWpvWXluUT09?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c834d204-f2db-4a16-e37e-08de6237e312
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 08:48:50.7168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFnuVEVruM+8bEHPNhs5/mnIzVN/xl8ZJ/m30Uc8s5mTVtC1pXK2jC1ZsH6zGNhOEfDTXtPcjO42JRMmf9LYsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5789
X-Proofpoint-GUID: 1PVgil7FBlRUeXCcdn8JaB0SDxvIN5nx
X-Authority-Analysis: v=2.4 cv=JqL8bc4C c=1 sm=1 tr=0 ts=698064f6 cx=c_pps
 a=5+LGht9gDMVyy/gYI/Qwww==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=iGHA9ds3AAAA:8 a=EUspDBNiAAAA:8
 a=aNy1ewBffa6aY2lXQ1IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA3NCBTYWx0ZWRfX+nmtGOfeernh
 WvhADvF787uDsDnx+UT//POTsjk4dK6eIA0r9glLfEqI66Lf4GvEmzt5DukG00Nv6W7WJIV1gG2
 YeQQsK+TD+7utOu3Xep262Rw9wpCv3tJ7pK5c9khaKN48725jpwG30QSVdi7FtMgEWPcfhw+2Z9
 o+agshQT/CrqUdhTU2YkKnCuBgW/aUQClfGRbW4RZoEIhuYvFLhLl1bPSFsI5A3vvCrdUCURrh5
 WOa1SWwOkA/ucGf5541WZTQUlX2caHNYTqcWcUTF3K3MwVRrzm0mGjD+bSZsaBd0820W4w9U3mL
 sx/Ug1WYcJgZpvWC/NhnlsHeYqCA5sq/3Y3nCFdNl2jH2zNTP8ZzXx1qQMvnQJr538v725mLMj6
 +JFpu2D0W6WmqFy8KvusTxaGQ4ylvWVABHwuUcDUyvl63EsNJ+8Ebu84Yqudo3fgr6GdnnS4VAU
 zziQan3rTPZvonwn+Zg==
X-Proofpoint-ORIG-GUID: 1PVgil7FBlRUeXCcdn8JaB0SDxvIN5nx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020074
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 6124vKsx2225996
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 02 Feb 2026 08:48:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3164

Thanks for your patch. I won't merge it at this time because I am=20
currently working on updating refpolicy, and this backport patch will be=20
included in the updated version.


//Yi

On 1/30/26 18:28, Ganga Bhavani Yenugula via lists.yoctoproject.org wrote=
:
> From: Gangabhavani Yenugula <gyenugul@qti.qualcomm.com>
>
> Define a dedicated domain (`pd_mapper_t`) to confine pd-mapper service,=
 ensuring
> it operates in a restricted environment isolated from other init proces=
ses.
>
> Grant the necessary permissions to resolve AVC denials observed during
> the transition to enforcing mode:
>
>   - Filesystem: Authorize read access to `/sys`.
>   - Socket: Allow creation and basic use of qipcrtr_socket
>
> Signed-off-by: Gangabhavani Yenugula <gyenugul@qti.qualcomm.com>
> ---
>   ...troduce-SELinux-domain-for-pd-mapper.patch | 73 ++++++++++++++++++=
+
>   .../refpolicy/refpolicy_common.inc            |  1 +
>   2 files changed, 74 insertions(+)
>   create mode 100644 recipes-security/refpolicy/refpolicy/0057-pd-mappe=
r-Introduce-SELinux-domain-for-pd-mapper.patch
>
> diff --git a/recipes-security/refpolicy/refpolicy/0057-pd-mapper-Introd=
uce-SELinux-domain-for-pd-mapper.patch b/recipes-security/refpolicy/refpo=
licy/0057-pd-mapper-Introduce-SELinux-domain-for-pd-mapper.patch
> new file mode 100644
> index 0000000..ec89ca9
> --- /dev/null
> +++ b/recipes-security/refpolicy/refpolicy/0057-pd-mapper-Introduce-SEL=
inux-domain-for-pd-mapper.patch
> @@ -0,0 +1,73 @@
> +From 29630f1034ebaaccdf10366f23616367ae138f1e Mon Sep 17 00:00:00 2001
> +From: Gangabhavani Yenugula <gyenugul@qti.qualcomm.com>
> +Date: Thu, 22 Jan 2026 16:14:50 +0530
> +Subject: [PATCH] pd-mapper: Introduce SELinux domain for pd-mapper
> +
> +Define a dedicated domain (`pd_mapper_t`) to confine pd-mapper service=
, ensuring
> +it operates in a restricted environment isolated from other init proce=
sses.
> +
> +Grant the necessary permissions to resolve AVC denials observed during
> +the transition to enforcing mode:
> +
> + - Filesystem: Authorize read access to `/sys`.
> + - Socket: Allow creation and basic use of qipcrtr_socket
> +
> +Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy=
/pull/1070/changes/c8aef7c55e8768378c6adeda7e8edfaeecb9fa28]
> +
> +Signed-off-by: Gangabhavani Yenugula <gyenugul@qti.qualcomm.com>
> +---
> + policy/modules/services/pd_mapper.fc |  1 +
> + policy/modules/services/pd_mapper.if | 10 ++++++++++
> + policy/modules/services/pd_mapper.te | 15 +++++++++++++++
> + 3 files changed, 26 insertions(+)
> + create mode 100644 policy/modules/services/pd_mapper.fc
> + create mode 100644 policy/modules/services/pd_mapper.if
> + create mode 100644 policy/modules/services/pd_mapper.te
> +
> +diff --git a/policy/modules/services/pd_mapper.fc b/policy/modules/ser=
vices/pd_mapper.fc
> +new file mode 100644
> +index 000000000..3d83d46b1
> +--- /dev/null
> ++++ b/policy/modules/services/pd_mapper.fc
> +@@ -0,0 +1 @@
> ++/usr/bin/pd-mapper      --      gen_context(system_u:object_r:pd_mapp=
er_exec_t,s0)
> +diff --git a/policy/modules/services/pd_mapper.if b/policy/modules/ser=
vices/pd_mapper.if
> +new file mode 100644
> +index 000000000..34da5143f
> +--- /dev/null
> ++++ b/policy/modules/services/pd_mapper.if
> +@@ -0,0 +1,10 @@
> ++## <summary>pd-mapper</summary>
> ++#
> ++## <desc>
> ++## Qualcomm=E2=80=99s pd=E2=80=91mapper service is the userspace Prot=
ection Domain mapper
> ++## that enables applications to access remote processors
> ++## (Wi=E2=80=91Fi, modem, sensors, etc.)
> ++## on Qualcomm SoCs via the QRTR protocol.
> ++##
> ++## https://github.com/linux-msm/pd-mapper
> ++## </desc>
> +diff --git a/policy/modules/services/pd_mapper.te b/policy/modules/ser=
vices/pd_mapper.te
> +new file mode 100644
> +index 000000000..34a8d6bcc
> +--- /dev/null
> ++++ b/policy/modules/services/pd_mapper.te
> +@@ -0,0 +1,15 @@
> ++policy_module(pd_mapper)
> ++
> ++########################################
> ++#
> ++# Declarations
> ++#
> ++
> ++type pd_mapper_t;
> ++type pd_mapper_exec_t;
> ++init_daemon_domain(pd_mapper_t, pd_mapper_exec_t)
> ++
> ++allow pd_mapper_t self:qipcrtr_socket connected_socket_perms;
> ++
> ++# Read /sys/devices/platform/soc@0/2a300000.remoteproc/remoteproc/rem=
oteproc2/firmware
> ++dev_read_sysfs(pd_mapper_t)
> +--
> +2.34.1
> +
> diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-=
security/refpolicy/refpolicy_common.inc
> index 59dfecd..9d74c85 100644
> --- a/recipes-security/refpolicy/refpolicy_common.inc
> +++ b/recipes-security/refpolicy/refpolicy_common.inc
> @@ -72,6 +72,7 @@ SRC_URI +=3D " \
>           file://0054-policy-modules-system-setrans-allow-setrans_t-use=
-fd.patch \
>           file://0055-policy-modules-system-systemd-make-_systemd_t-MLS=
-tr.patch \
>           file://0056-policy-modules-system-logging-make-syslogd_runtim=
e_t.patch \
> +        file://0057-pd-mapper-Introduce-SELinux-domain-for-pd-mapper.p=
atch \
>           "
>  =20
>   S =3D "${UNPACKDIR}/refpolicy"

