Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCDBE77188
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 13:13:15 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.77])
 by mx.groups.io with SMTP id smtpd.web10.105137.1734527585561981341
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Dec 2024 05:13:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=UcnD2LzX;
 spf=pass (domain: cherry.de, ip: 40.107.103.77, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYvrJkkqJhCZfc6eEBUBzFD1iRWhFo6csjRqAJtniUN2D+D+mGiGTd3KPcsKDZ5kZ2IhF1nJhDM5WdJnnJ3d9LY8OrR70becw0mV+0NaunypKGH9bTgzkpbN1g8p15KLlX5RVawQhLXYXbjS2QPdhXo3R6Gw94QX0vE3QaLkzWoO2WYHG4CftkLmNOsfa80HuWXdIjfbAJhAEuqw6HpZopyEz5BsliYCm5mRHpYR6IUSod0+DFXi9df0K5hazlvcOsvOOJWS/I86ADA4eo4T8mMRVpMe1i8Y9zwZfZsJachhQrkoJHBqwBcCYQqcgYrJoelwT+m+66CfSHgsyH+mtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miudBX7tmngvbGNVq9eBU3YgPIB9eVtwQBKSfWEYxps=;
 b=wOpwvQhFEIW2mIj3FyB3Qw0ESxT2MvsPuJTe+qQU7riCaOhn1E2ljWE0WCm6yE4L5uLGwQGrTnKr76+JcyjW2Tulke4oS970g7TBSEDHYq3+fxvWWOIp0cQZL9TIPdN2Gzeqis/UVruT/AbIKUsB1EElEX9EAw1KVk+RuT8XHadwgJ3By7s5v6Cwvongph/A+8ZkNA3wvJdsKSGErzZvUB8FkFl2nPLRJ0Fl/FX5futSrPFjywTnEDYAGtPu0m8izbxRa/0PYV7aAhUki/LNE4w7G0mmtPzah2gjVammKdxKF/oXiOwpslB/CN/euqdIYmcJZlK2r0EbM1ksXkIniQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miudBX7tmngvbGNVq9eBU3YgPIB9eVtwQBKSfWEYxps=;
 b=UcnD2LzX4HkM1SWLj30IdNnkuypSXRH0F5Vihuae/D8tGBD+g4Bxb9zMqCuaqsHORBrB9hYVjR2065gwX+ewM6rgA3dOqyLRGDUNfaKEARkmaMcC9sAz+532ROlGD9BX274QKNJuEcK7QIsMHjb/CRjjI6FwNM7q/ZKBvMJeMxM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB8771.eurprd04.prod.outlook.com (2603:10a6:20b:42c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 13:13:02 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8272.013; Wed, 18 Dec 2024
 13:13:02 +0000
Message-ID: <1a946f27-35cb-43bc-b644-04b79722703f@cherry.de>
Date: Wed, 18 Dec 2024 14:13:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH] add radxa-cm3
To: yocto-patches@lists.yoctoproject.org
Cc: piotr.krol@3mdeb.com, maciej.pijanowski@3mdeb.com, twoerner@gmail.com
References: <20241218103904.43032-1-daniil.klimuk@3mdeb.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241218103904.43032-1-daniil.klimuk@3mdeb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::16) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f35309-27fc-49fb-e8f7-08dd1f65b387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?a1lQY2IxNXg1cHo4VGdtZ1dmaXZUMFhNbk1WeHNrVFp1cTZjeUNSY0haZjdr?=
 =?utf-8?B?OUxUZHJOd3VsYzZhelp3Skx4by9oVnhkWVM1RkFaeVdSSVNqTWFFVmZzMDJQ?=
 =?utf-8?B?UFM5UlYwYjNDUXdORy95MUVjWUVQSVFkcnlsWG1WamFDUEtJd3U5amI1Mm9s?=
 =?utf-8?B?bHR4T3NaSFVsTldxMU9UQ2NsOXluLy81Q0Fid1JMeWhHTHd4aUJHNHA5cG1I?=
 =?utf-8?B?NEM1dWVVNVQ3OWRqZGY4dFpXclJrNE5HSzR6Y012MW5jdngzK2p4WHQvcmd3?=
 =?utf-8?B?ZUtiMVVjd2IwMjFwVXBVTURwRlZLWG9hM291cGNPMHVsM0xxZlpSM2ZuTTYr?=
 =?utf-8?B?VXFKQXlyRi9aNk9PWm1xZUlWRVJlS0l2SHlJd2hvdWpkcWpTQTIrMlhDNXkr?=
 =?utf-8?B?eWpKWkVFZExuVHdNSEtiOFAweC94MjRHQlJsbXdRUG9nSWcyYVAwQThMdnhD?=
 =?utf-8?B?c2hUdEhTYUQ5K1ZiM3I5N3ZVZkVRenVhZ0VRS294eGxDZHAreVE4SnRlREpw?=
 =?utf-8?B?SWNhK0tuMGhubXg3SnhmaW1kaUN0TDhuUDVScXp0R3JFekRYekFPbXp6UDZm?=
 =?utf-8?B?bkUxUTdzcWtNb2F4SlZZa1VNU1IwcmFCSFRaMldiMUh3Z1pQVC80dmpjT2Yy?=
 =?utf-8?B?ZjlKbVJvKy9uaXlHeDdGcDFOR0NFZmltZ0tTS2F4L1dIY2dDcUVjZXhaS0h0?=
 =?utf-8?B?RHN0VnpGNzhCWnV6V0xsdG10S0w1Y21UZnlhNndKS1pqL0JWcEdXNXVic25a?=
 =?utf-8?B?M3NiTmFoenFRVHdYYzBCSXh6aStKWVNBbWdXbmNjRE9aNW00a0R1UG1VbUdj?=
 =?utf-8?B?eTJsSzIyaGE4R0s2U3pudUFCdjJHcm5scTRFRTdMMVZvdWI2ZjY0SFA5VE9U?=
 =?utf-8?B?Q3k4ZVZCYW9rMFhLSEh4T0pxcTdhMUpDOU10ODcvakpOMHNnTXBva3pxWFQr?=
 =?utf-8?B?c2NtUGdDU0NVZzQ3c1lqRjZaZW9HbG5EMUwyYUF0Y0tOMXZlMkVQekZLSmx5?=
 =?utf-8?B?Q2tiZThjK3p3dzdrOC9UVjQ3S2tMRytyTkh4d2RGNk83Q29LbENLUERiVjVj?=
 =?utf-8?B?RXR2K1JrSmRiS2V0L3JMWC9tWUNHeG1rUW1aZUR4dTFOODRObUNQT0xDUEhr?=
 =?utf-8?B?SHBhZWNGcmpjOGJTZVQ2MUg0QWFFZVUxeDkrSmhsR3g4NVVZakhRVjl5VTlM?=
 =?utf-8?B?UElKd1pjcTM0MDNxWUpoVU04RHBRbmR3L24xdVYrNGtKL2VFYVllMm1DU0k4?=
 =?utf-8?B?Vm5GVzlraVgzRm5TRXVxcGIrdXZScFd3ZC9idGcyZjR5YWVuSm5HMEIxTXlG?=
 =?utf-8?B?NzBvbmNvbUx3VWJrdVpUNTI1RmJpMVVJcGF2OGQ4cDZXdmpvL0t5dG9tV2pC?=
 =?utf-8?B?OHFjSFU2VlJ0TnlQSkJSZlNxVWRrVldYUXRHYTRMM2lzK2ZPNTBWVWltOVZP?=
 =?utf-8?B?a0g1VWRqMm8rbkRYUkY4cmkxa056L21VT0lXMHIvdTZUR3c5aHBtRm85eW90?=
 =?utf-8?B?VVhpTjJtdEpGWlZ5UGFCb3pIcXdhQU9GZXRGTmdGSGRTUUpLOTVSQ3oxY0do?=
 =?utf-8?B?UVZER3lVYlAydi9KM3Y3WFJYNUdPYU9tYloyemJMdWc3YytGbS9VcGk3QWxP?=
 =?utf-8?B?TlZTbjI1aUNMcUlaWndzaFpIRUpZQnloWkRsNVI4QnphVGhNdkFEM0VxRGta?=
 =?utf-8?B?WW80ejBGTmV5YnF1SUlWbGpHVENoaDVwY1NWSXZxRndBMEI3blI3aFh4NW1k?=
 =?utf-8?B?cmdhR1k4UEtYVlovTm5HcSsxM2N3WmxjVkhaakVxVEs0aWpUSHNMa3NjN2NL?=
 =?utf-8?B?bjJWeDlaTUhSRElvaDlMa2dtSG16K3VoOGdteXp0Vk5jaENReHlSSVZFYVJp?=
 =?utf-8?Q?A9KdRHqiFwdTN?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M2NzL2xHNVEra3pod0xRckdMaXdMdmR5ZnZtTFc4NldGY3JlWmtHU2J4ck91?=
 =?utf-8?B?Uk5EVElMVGxPZGNUV1BROElnNE5GYUE3QWxlOHJSZ0ZQOFpZZ0lJMkEyVzM0?=
 =?utf-8?B?UHlHb3JXMWtsTVo3ZU80VGxPWHRNRGNSa2hmRWk1ZXBLWkJhdmVNV1VXNkJR?=
 =?utf-8?B?VkdBdTlRd2pxangxRWdjZVJFbmhMbHhYeGdPZW1JWnc2T0lCZkxKTXpzUHEy?=
 =?utf-8?B?WXlDbzBWSTFYcFZ3aWZTd01JQTA0aFpiWGR2OVlVMnJ0NVl5YjZnck1BTVFw?=
 =?utf-8?B?WHF0b1h6L2Fma2hNc3N2RkdYZkxIRy9KSGVFcmZnYlhWa3FLLzhNN2xrRHpW?=
 =?utf-8?B?RGowbjg1by91d3BSUDBWOHlCT1JsNE83YnlnUmNiTE51OVRIUEcySTg3V3Fq?=
 =?utf-8?B?NVoybE5mV09uZ3ZxVVpCVDJRYTRyWUZoTEpNeDlIdk9vbExTOEVCMFZJRCtn?=
 =?utf-8?B?SENvRUdpTkNCRjZuT0drQ0o1NGdaYlFJUllzdnB5Z1NYTTJ3RkdTU2dxKzJN?=
 =?utf-8?B?VlZwYXIwUmxnVmlsVU5EYU1uZUV6bEJMYlhoeWUxT3M4Z2hKQTIwa29VMnlU?=
 =?utf-8?B?VDlJY3RwdWRZNzB5TDFXTUprZ2NFSnRJVnMvQUpGdTA4c3pid25oSGFYcjB1?=
 =?utf-8?B?bjdtTGJMZzBxSU1QNjhzaUFvS21nSlN3SFR2MU15eGZvWkVsVGt5VlVuMU5G?=
 =?utf-8?B?VHZiajdWUEc4bHJnVDlOTXhZOWNIRy90OGRSODRGcXkyQTdsdFMxSm1rb2Nn?=
 =?utf-8?B?UW1Sek9acUZaMmFSd3FVeTdXdkhFNE0zTExrc1lpcDVvMk1KTGsvZ0VVc3JZ?=
 =?utf-8?B?djRGTDJRc0JvMjFzall6UFp6ZzVLSWhyL0ZVSldKKzZuUUdLNnVRaWZrdmk5?=
 =?utf-8?B?RDJkNitPMXhVTlBDZENNdmhuTlhod1k3cTJyY09oS2xZV0hjYlZlTWZPSXdy?=
 =?utf-8?B?bm9COXhCUFdVUHgwd1FjTnRwMHcvMDZqMFlqWWQxWTZvNDlUdE85bVpIWUJQ?=
 =?utf-8?B?NE1nYzhTOUxvb2tvNUhIMFNQbEF2OVdmcDRlVkNKUkUrUHpRVGJuOUxhT0Rz?=
 =?utf-8?B?QXN3QTJsQlI1WXIvMHp6UW1sYkFKWCtDVWZGN0luSmJsUUtDZHJiQlA2ZWNi?=
 =?utf-8?B?YWRWYTQvVHAybkhJSE9TcFIxMUpMNU9uaVFrS3NhT3ViWDAxRVhydWtjMko0?=
 =?utf-8?B?SWY3MWhmaC82a0VBSlM0eGs0ZDNCWTVxbTBXZ2x2cjd6NUJUd1VHRnhBZlhT?=
 =?utf-8?B?eDZiUU5CdE02MHI3L0RKYVgxdzNjWlpHTGVQd2dzVHBHR1RVYWdrMXdLVnhB?=
 =?utf-8?B?VE1CNTl5ZmNKb05BVXJkTTlkMCtTOTIwei9jUmRTRVUvWjlxejZiTUwxYzBo?=
 =?utf-8?B?bzc5bi8xYzRsdEdFbDM3Tllxc2hpeDdSaE44MGk1SllscUd5MWxwaDBJV1ds?=
 =?utf-8?B?Wm1MUVRhNExLZUc5Z0k0dXNlcGFFZWs4ME1YYmh6d3F4ZGFPNytMY044VFlJ?=
 =?utf-8?B?Q2VwTkxPd0p1TGZRTU9ZcTlQU0tyRW9lcVVySjF4aDNnQXlyclRJM3U0QlU0?=
 =?utf-8?B?ZnozWG1vM2xuRmMwTWNha0pMWU9VQ2dNVnIvckQ4NlhBYnM0alM1ZUU3TGh6?=
 =?utf-8?B?cGRwWFhhcW9STU1QS2lWTklaK01mT3htaDdWV21FV2tZQzdvdk5SS3BhbUlw?=
 =?utf-8?B?em9NMEZZb0NiM1NsMmwvTFUzUFBIUjFxSUk3R2NncEYzY3JRQ1ZmbkpGSG5L?=
 =?utf-8?B?ZEY2YlR5dm43SEcxb3l2dmkwOW1HY2g3Z21MeGZhM1E5T2dkWGxPTFRPcFpR?=
 =?utf-8?B?eXJ1MzFDVGUzTmYrQkhwUTJNKzhZcVFJWHczT3NMMm5YZnAwTkZLWERnS21m?=
 =?utf-8?B?dnNieUNzN216azdnMmdkZGVxNkpGblo5TEVZbmYrRFZYMVdKWUUzbHRaUXls?=
 =?utf-8?B?b2lXdzJrWi9ZRWxNMjJqSmcyYTI5Tmg3cytadjBoTFJMeEcrQVRWa3Y3L1lj?=
 =?utf-8?B?RTBrZ3FRMU1kcmkxSklLQ2UxKzJKZmxPSHFxK2t6S1NGdEJkdi9adEU5L00w?=
 =?utf-8?B?Yk5PYnF6bndtdTdUVFlmb2NYK2xtTzBZTWVTRnZqRXhVN0xweXBaL0EyVDli?=
 =?utf-8?B?SC9tdm00VmV6TE13V3pOSXNDSzZ3SzdtY1gxbm1JTUpDamVMb2RKNVVuMzY0?=
 =?utf-8?B?bmc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f35309-27fc-49fb-e8f7-08dd1f65b387
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 13:13:02.2459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2Lk6o8Bsr5I/z0USyidZxNJhqW5nsMzCiC3csoBCbkUYdXNkxUYEUVZrunnyJ170MA45aBH7z2qxN0OBCz8D7W07YW2Sb4I52/L8ZU+eZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8771
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Dec 2024 13:13:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/937

Hi Danik,

On 12/18/24 11:39 AM, Danik via lists.yoctoproject.org wrote:
> [You don't often get email from daniil.klimuk=3mdeb.com@lists.yoctoproject.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Add Radxa Compute Module 3 support.
> 

This is actually rather adding support for the Radxa CM3 IO board which 
is based on the Radxa CM3 SoM.

Maybe we should rather have the same mechanism we have for SOQuartz? An 
include file for SOQuartz (respectively Radxa CM3) and a machine conf 
file for SOQuartz Model-A baseboard (respectively Radxa CM3 IO). So that 
users with a different baseboard could simply require the include file 
in their machine configuration file.

The support seems fine to me otherwise, so just splitting this into two 
files (and following what we have for soquartz with the comments and 
MACHINEOVERRIDES) should be enough :)

Cheers,
Quentin

