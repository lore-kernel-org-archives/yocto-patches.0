Return-Path: <yi.zhao@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B03CCA476
	for <webhook@archiver.kernel.org>; Mon, 13 Oct 2025 08:10:17 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.37792.1760343008702862060
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 13 Oct 2025 01:10:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=pTbxpmKr;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=2381c69f7b=yi.zhao@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59D6dcBw1441564;
	Mon, 13 Oct 2025 08:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=Ld8Y4eea5dp+I9x70rgXXpRQfD5quu+16Y9ozPlNP+U=; b=
	pTbxpmKrG84Ly3H5uZQRxrGCOIWzuCxUgkRD0hMrlON5B+gyDGB/X8ha40kGJklG
	cN2h/Ufit3JUkWB32fj48nvKFrFvl6eIPB/G0P3rLUA3UISO+iGWytU02fayO3go
	ESkuWi22OKTASOO1vqZYvFh9rUW+rRW1micUqTlnbpQqmDPFD4Mg26u1VfW3pKBf
	+17dz8O/CyKPI4mX27oxAKvB4kN/6/ZORnWp2Fx/6600b29BcA2nj/UhaELFlVPH
	3RMiKFXkDQz2oKhOJUvtUthWzT7UKeN3C1/6bFTpnYGAniXOgZ8X/Kk1zZJu1irY
	M4VUbzq79N8c61uVys6w0A==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010022.outbound.protection.outlook.com [52.101.61.22])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49qcewhky9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 08:09:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KgLsKYYdi9uyEJsD/rSBckAo8shryILMzHKpzadOYmwUTXhQNfv1qfq6/G3YukXSOQcQqva7DVIorjZ/OxcZ91rZJGRpqFeQda1ASoQpSmddC+o+LR9QYfllHKYbpnc2ai5up+YB2kTejeIwnaBbCirxwR/ziOILiRIcQJzetJwwhpdzdbew+ACcY7J94eCqW0bcpF+mG5xyAo/NgclqHGXCigIG9Hj9d/0/ea2MsdjPYVblYPlT8HPP12udYM8g56d5RuLgZvkEx52Xkr6Qbv8kC3QCuAcf7NW2YM0Qim7l9GQf2fArdQUiDGUAMk72GktvfKoKq2KN/PKIReJVOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ld8Y4eea5dp+I9x70rgXXpRQfD5quu+16Y9ozPlNP+U=;
 b=G69XPvtigfGjs31PDuXs4WKb1gpac/cdsQa1lYrDZ5I9VYAemQ4Hm4L//x6Ym3RUXfxTJ/GOhAxGufD1OVGlhc2px4iBzzAI08iPNSKhHN5dHdnhngh29xiaUytoXiIiTW8PdMViuxFFNm8RijA873b7IsTz5wHAbGBwyzHlAkWQdo8hbygni9q8PUVDargpkjmkwP6BDswc1hsiESUHp+fr/opPY6D7xHglpJJJo+L+Z/bzw17lle6vNThdwn42VQ1vVEFjMWkpKTlMfULME9GkmwKQM8zxBfzBQBeIV8CO/EXIIWLQ9USqRV7dB0SxoPsj4MGHL6J7W8bQnXhWBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) by
 BL3PR11MB6433.namprd11.prod.outlook.com (2603:10b6:208:3b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 08:09:55 +0000
Received: from DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad]) by DS0PR11MB6399.namprd11.prod.outlook.com
 ([fe80::2b44:787c:e7ee:bfad%3]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 08:09:55 +0000
Message-ID: <057def96-36d0-4c38-9376-0ab8e873ed05@windriver.com>
Date: Mon, 13 Oct 2025 16:09:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-selinux][PATCH v2 0/1] initscripts: fix
 incompatibility with read-only-rootfs
To: yocto-patches@lists.yoctoproject.org
Cc: thomas.petazzoni@bootlin.com, joe.macdonald@siemens.com
References: <20250929162057.48553-1-joaomarcos.costa@bootlin.com>
 <b80fe998-eb2d-46e0-bf8f-1299967cc27f@bootlin.com>
 <3d30bc09-fbb0-4d49-b866-be17c5d6270b@bootlin.com>
Content-Language: en-US
From: Yi Zhao <yi.zhao@windriver.com>
In-Reply-To: <3d30bc09-fbb0-4d49-b866-be17c5d6270b@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SG2PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:4:7c::31) To DS0PR11MB6399.namprd11.prod.outlook.com
 (2603:10b6:8:c8::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6399:EE_|BL3PR11MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: f36e430b-ca78-4d21-3eef-08de0a2fe4eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eXJ3TVViNjk0bUlGM2NETzRXcUJWR3NRNXVpb3Z3RmMrcFdSN0QwTnR3SVpV?=
 =?utf-8?B?M25ERmtNRnVuY1cwVjFHbU9aVVJzaFlVMUJVZ0xoSmhURmMwV2xHMStXZzJz?=
 =?utf-8?B?NTMvR0thQnZCZDBtNEhXRVNXYlhhVUVlU0pJZ1ZoS1lDZVR1V2Y1eGJHNnpv?=
 =?utf-8?B?Zjg0NkFOVHpiNGd5aFBaaGE3Y2ZFKzJhQTU4M2ljVm9PdGZ3Q3ZDQWRPZ09u?=
 =?utf-8?B?ME1qMFZ1TXhlZ25lam5HbklaTlJaMGhiVTVJY0Vtd1NDQXhxL3cwL0ZjSU9z?=
 =?utf-8?B?dUs0ZDRnRDkvMDh0ckNaREw3dlNKWmhTeE9aeG93cTQrN0NUdm9nRnNEdHQv?=
 =?utf-8?B?aHJ3MVNuTnh5MWx5d0p3ekFzV2ZqMzRjMkh1cU41d3RwejVUZm9mOHNTK2Ji?=
 =?utf-8?B?YVo1OU9qN2xzZlB0c2FsSDBjN1VjQWFwTWoxNURWNlliSlNtOE9DbHFCamJW?=
 =?utf-8?B?RTYvQmZMZ2hVNXBwQWM3VTF6RDRoeUt0TGRTRnljd2ZYLzNhd3dxWDVLVFh5?=
 =?utf-8?B?RVpGK1lBNU9UODhXVTNTakpIT1BUUkUvTU5lSWpHMXcyaWZUMVN5WFlKdDlS?=
 =?utf-8?B?cVpBcDNFakFiekRvbDQvZkNiMGN6NzlHVkRaYmswTXRQU2pwT3lJSkdFZW81?=
 =?utf-8?B?RFplRW90QWZ6bVpnbTVBOUxjd0s1Z2xUSVpmMDFPTFRGSjN0ZENQbFY1L1Fi?=
 =?utf-8?B?QXh5Mlk4SnY1ZXVLR0JvcTBlclpUYmFBbkJ1bW1XaURrb3c5K2VrMTUycTFP?=
 =?utf-8?B?bmloNjFHVWFCM0V1elFiM2RTVnh3VkR6WmxrS0cvVHFHRDRJRVNwOU5nckxI?=
 =?utf-8?B?WFQyTHZjc0tPSmE3SVg4cmdYYVpwSlQ5VU43UFZhcUhvUmVtYkFhaG1zS0Zt?=
 =?utf-8?B?QVNPK0UwZmhQSjd4YS9GTVo1YUZ1Ti9kZW5PMi95T2U3VVk5d3NuRHllUmk4?=
 =?utf-8?B?Y3FnQ1djeExCOHN1dnhmMmFXejRqU3RxMnJ3RWNqRldWSTN6SWJjTzNOYjRP?=
 =?utf-8?B?RG9TSnpTSmFDODdRT2tNZ080dU8xQ3ZibVFvNyt3c3lBWlM0dXBweXBxMktl?=
 =?utf-8?B?TW5uQ2RjTDNlMWJnM0s0SWhLNHRzeEhJUDNsM1M0N3o0VWE4NnJSYTJYRlR0?=
 =?utf-8?B?ZFpKNGs0dmg3Sm01NnNCb0w1dHQxUlR3UFRZZ3dycGVXL1FPaWF0RGIweE9s?=
 =?utf-8?B?OWNsOUYwejJ1U2huMExpMFora1NKZnZLK09xYnFlK3hIU3BNeW4ya1RNdFQz?=
 =?utf-8?B?d0FXL01IU2JBNTlhc1k3cVpuYU1oVWJNSkZzYkNndC9RQU91UGJMZU1nUXNL?=
 =?utf-8?B?WlZUd24wdmRjYkg3ZzB2eEZEZTdMWFVxckZlTXdQNEdsVUpJQy8vZkFpV3Vy?=
 =?utf-8?B?OWhueEJDYWlOQ3BZd1RRTklaU2kwa1pmVjNxTkl0OEF1QkZjcWx5ZnFnVi9x?=
 =?utf-8?B?bVk4TmlJdlFVTDluS1ZVS09mU3VNYlc3Ulo3UGljS0g5Zk5oS0VyN0VRaE8x?=
 =?utf-8?B?Z2NNRU0wNVFkNHE0U2JJSTQzRmNubFNVM3dVbHNMYU00ajM2ZzRGR0ZoL3pY?=
 =?utf-8?B?dno3SFBtb0U2Nmd3QzlNOTh6OGliYURmdEdDWkdiSUhGYVJsL3RtUWpPYlpv?=
 =?utf-8?B?T3pGV2c3dmJuS0tjc0hWdTdqeWVDc1BkUjBsWlM4MVIvN2Vla092Vk9mT05C?=
 =?utf-8?B?Mk9kZ1FHYUpvT3NQc1JFM3EyUXcwdVFmYm5UOFlOTklOSWRra01ReUZTcmFG?=
 =?utf-8?B?QWpQblF4Rms5T25WYlJIQTVwSFI5UzNQRXlDa1lhWThWak9salVWbUFQb09Z?=
 =?utf-8?B?L2M5TnFlV3IxdXZKVnNScFRYQ00wWjNNNDlVVGlqNTFUbFV1RzRQMUh4OGZZ?=
 =?utf-8?B?RVFXRXAvRGwyVG9QdkJjSm5lRUs5YzhPdzVmWUZpZUxDa1ZuNEJ0a1F1Y2t3?=
 =?utf-8?Q?Jqz2dlktTHaH7vGeyKIsGTjJjB0+pF6J?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6399.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S2JHU011TzFRSTF3T0xJN1JzOFFLMUVMa1BlVmdnYU9TT0Jqa2tZNFRsNGdG?=
 =?utf-8?B?SlUzc3hvMUxLOERwblIzWWtzTDdOK2hYeVFsdEtxV1gwdENPUkdLZStVUHBS?=
 =?utf-8?B?UXl2WU5zd3VSbU9iNW9wcnlLN3hHZWkyUDhHellVeFFxakY4WHhFR0E4Y2d0?=
 =?utf-8?B?OHplWGJaNXI4NGtvV0dyTzhWbjJIbTA4alNjNnhHS01vWVdwcWdCRGZUT2x5?=
 =?utf-8?B?eE9HVU8wUE9xMWNidUcwK3RxYUM2SmFhMFU0Snk4NW9QbUdnSTVIQjBHYWNE?=
 =?utf-8?B?cS9oMXQ2VXdOUDJJdEZjL1UrRzJuWkFWZUVySWJ4aGF2Q0sySTh1cmZrY2Ni?=
 =?utf-8?B?ckQzMUxPdElTQUFTRTNRSHQ4d3NLVHBXYlJkSDB5M3ZIRDFXR1U4MkpJbDlQ?=
 =?utf-8?B?TWUwUEEyZnhNbnlxWld5Z2w1N0ZDN0k2YXE1VnNiamo3Y3pGNC9Yd0tZRjBt?=
 =?utf-8?B?Q1FOeGxHaVBLTTg0WDVrdFN3YUpOZ3pweEdCZWlsN1ZobmUraHdCOHl3SHcy?=
 =?utf-8?B?VDhGT25qNVZWZUhSNEg2SVh3MVc4dVh6SFNzWDBnV04yb21aVVExalFZN3Qw?=
 =?utf-8?B?eUI3STBocjNVeUprWC9LOUU5Vm9IMnorOERzMzYzQlhIbTlXV1hlS3BkQUtF?=
 =?utf-8?B?YWhXMTE0MU5oM1FScWVQeUQzalRxWndyL01ib1AxU20wMTdKN2JOV2xoWjVi?=
 =?utf-8?B?VmJBYWZTUzkxZ3RKaTJnVFlNOWczZW1LdVFXTFZqZjZIODV4akVuTlNqT3pF?=
 =?utf-8?B?RDA3Q2Z3SzdNcUkwUW5HNVVjSFNnNE1QaWFHU3o2anhnNGdkbXVzQit4Zjcv?=
 =?utf-8?B?N0pBZE5FMGtiU0dkdkxQR2VjeVpGSnNjM3F0QmJvbDlZUWdqcGNmMlExRE1h?=
 =?utf-8?B?RWhWK3o4SitqUXc4aXJhMjJDbWxEbWR0c0MydXh3emZTa1RsTEhCODlWSVdk?=
 =?utf-8?B?ZTBYQlB4eUtoSHJZR2JxSzNPWE9sMFd1S0FVVTVpNWdzWGlmV0gwKzU5ajIv?=
 =?utf-8?B?TUsybG1uTTJGWWNZWGoydTRrRzZvQmVMb0pzZ0tEL3o1VW4wZStaNHVDejFp?=
 =?utf-8?B?WlVyc2hZWE0ycEJraDJqZ2duU054RjVtbGxGYTcwUFlHOFJQcTRPbVBHWFlU?=
 =?utf-8?B?RWFoT2IyMVJOalpoZ1l4SFU3WkhTa3ViTU1GdG9NczFtaVRPN2JkaEpxL3Qy?=
 =?utf-8?B?YXZHcS9FSDUvcEpEVmpORExkdHhVMjJ6and6N041bUlGOFdBbEd1TVhQUmJS?=
 =?utf-8?B?Q0JRS3E3S2tCbkZYNmZWclF5L0g2VWx3c3JJTjNWSW4yQmZzZ3MxR2FWTmk2?=
 =?utf-8?B?dXNXMzRiRC9qMUY0RmxNSzBTNHM3MDJ3djdJbVVvbTl0ZE5yYWlMVEF5YllW?=
 =?utf-8?B?YlhmclhFS25heitXK1ZCZDVyRzBNaWlpSkhUdnV2STdSOTdnUzVQQndzVU1k?=
 =?utf-8?B?cnZhT3c3Y0F0Nkl3aTFseUltb3AvT1dHM1pjMXZ1UXRLMGIzRE5xK3k1YXlO?=
 =?utf-8?B?QkZqajJzZ0d1b2FPaE1QRUxOQmx1SkdCNlg5Vm1iRmlxN0tlN1RGQ2ErSzNz?=
 =?utf-8?B?NGVFajRXNUp6VFVPVVFUS1V6SjdIMlJDQVp5QTJMU1RGV2VUNzZNY0Y5RU1P?=
 =?utf-8?B?dE1UejJaSEpwS204NmtjNkoxU1orOVl3VXhCVFF6SWM2MWtRMHJZTE1Keitv?=
 =?utf-8?B?aWdpVmZtTjNzVVlZblVsRldmREFMdEt6U2pOcmdPS1l5dzZCS0JSZnVrQkNq?=
 =?utf-8?B?cW91bEpMZ2U0TnFkNWZWTjhzWnZsS1B1bGd4WCs2U0RLMzIyYTdNMTlwR1Q3?=
 =?utf-8?B?V0srV1FGeXdraHQra3R4Q1FGWm9EKzJZZnl6ZFN6TjE5V2RvZjhjMHFDSkhj?=
 =?utf-8?B?cHZQRXhGZW5oVjYxdkhxcThNZ2VQanc2TmhWY0ZtR0lZYUYzMTNHWEkvMzNh?=
 =?utf-8?B?WFkxMmRvMG11VlN2VXA5ZjNJWkVlSWVGS0hjT3pvelR1TWw1U3RFRVBydXFE?=
 =?utf-8?B?czJHYi9WZUpNOFA3SmZuUXFWMzhJR3g2SkEwODBmaWlVSWhSVjJadUtLUmQ3?=
 =?utf-8?B?L25GZlkrL3dMbWsxbDhSbVEydVJ5eEV2b24yUjhSNUhBWlNPNXA2c093cW53?=
 =?utf-8?Q?GdOhECyx89QS+ZUraUr31QKyh?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f36e430b-ca78-4d21-3eef-08de0a2fe4eb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6399.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 08:09:55.6930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7v4Xr6wuXK3g2maKQsrMFiz3fcAr1HgWKs8vWE6tlW6sbsailcAgKHVCmwTCtNy0yuXzWERjwMSWZFJrU9uJog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6433
X-Proofpoint-GUID: HtvXEAh1XM30sv6XCpZ8CwHs7NomdikU
X-Proofpoint-ORIG-GUID: HtvXEAh1XM30sv6XCpZ8CwHs7NomdikU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAzOSBTYWx0ZWRfX2oGWggNjpcLp
 V8E7MEyq9EN5Lh7I5Y4SRd2vuyADmqj2HWVVuEhdBwHWqnYRrvU6rJF2D7o/T6vwlHlNa8Sjp5E
 cip67NkhtroBGOl6UGED+0iSsx0FXUDzfzEtavPNkeN0n7Yzk7PDuSqnY+LVmet7dbY/eHUwbf2
 AnkCXNGOf/++iifMbpuDddR8ZRhZ4GznBBO7Ya0uNhh8rixrj7WRtitI5Hq/O1zCmZwCv0aB7SP
 0KEjFt4J7B6p7OzNEL8scCP8KRYJ24l77cwo3ge+B2aE1bgbz6yUJUCwZrDBgkIp9ptsqHKrXdr
 N9bgKQZ64buvwYmdv3Y5IwBl4NGpN39bKqlfhLK3oNXPXhVi6D2CFTnjUaYFa+PAn/CxHCMV8FQ
 0iQaXUE63VNZya3UVLM31L9gYDgiiw==
X-Authority-Analysis: v=2.4 cv=M+xA6iws c=1 sm=1 tr=0 ts=68ecb3d7 cx=c_pps
 a=P7Y/ubs9jOqwJofkHNyo7w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=iGHA9ds3AAAA:8
 a=oCvnl8nh1YtOqJU2YSsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=nM-MV4yxpKKO9kiQg6Ot:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510130039
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 59D6dcBw1441564
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 13 Oct 2025 08:10:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2292


On 10/13/25 16:03, Joao Marcos Costa via lists.yoctoproject.org wrote:
> Hello,
>
> On 10/6/25 11:17, Joao Marcos Costa wrote:
>> Hello,
>>
>> On 9/29/25 18:20, Jo=C3=A3o Marcos Costa wrote:
>>> Hello,
>>>
>>> This patch presents a possible fix for a build-time issue whenever th=
e
>>> 'read-only-rootfs' IMAGE_FEATURE is used. I decided to keep the=20
>>> details on the
>>> commit message itself, and to add this cover letter mostly for=20
>>> keeping a
>>> changelog.
>>>
>>> Best regards,
>>> ---
>
> Gentle ping: would there be any updates about this patch?

It has been merged. Thanks.


//Yi


> Thanks!
>

