Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD64CE7D04
	for <webhook@archiver.kernel.org>; Tue,  1 Oct 2024 09:44:08 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.65.27])
 by mx.groups.io with SMTP id smtpd.web11.77489.1727775842274614927
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 01 Oct 2024 02:44:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=JtCB0Veo;
 spf=pass (domain: cherry.de, ip: 52.101.65.27, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXghpdLezqKiXC8ll3mIHEnbv9SN8nPm8e9IjUSaWB/y4GlvzgnrcisLsZn1ZsA91soiPeCnz1fX8die5F0PvHRXfeeX/mEyFHHeKs4xMBb1hE6q609i4I63Ishj7MIrI6SCayDCwgM9glMR24MleT4Uo9sNX9TS296FQIsRlFy9VOt9WOJeR3Vz72cUq9zNP2ojocmxDcIG9wyWFEx38/bmsOn6RJ2xb/8aB2KooPsoCJVn+7hpXIvX5rx7+ZRMW5/pWN3/lxsHpscZQRXnpV+FPgvj3LgYAg7OjnVZZ7EV4yeIXpTHlwwz774B3Re1KYPBo9m9ptzit2VqZwKXQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ds5VOJW8muKHDzBTQBOiL3JmR34eMZlHwidSmdMLWTg=;
 b=vQDN1UtjaR6a3eRHnzogcyHuEa+gIrFwzivrVoQ9ku/7h4Dgs4hVU/LdXo2b5W7Gs8/4sJdnsWP9yaRyzij9v9ZggJrtrPkR49vvdslYM2fGP7hU5sUpVSPWcHt/ImyTWHEQ6dCI/x3yzIvQDQO1C0jCREOUq4V6fagaDIsa28vnD3RL/70DzDt35igtvPKPxhbwSKf+I30cpQ0CBjRDhQChvtJZCi16p92feOwhi239QUWyjYdLnrhAK11HwEKkrPeFM4eELPWC/f/vbJTzFPEcQYkF+8NC7Ppq5p+AlnBrb6ywesinX4+TV2icwG6bWoqWPeC6XACmgfqueH/KmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ds5VOJW8muKHDzBTQBOiL3JmR34eMZlHwidSmdMLWTg=;
 b=JtCB0VeoWaTwFT25Z3QvR7Zbg/x3PdutQ8Pq+yuWY3I90SYqaazLiIPKMfmjZd4fvcXcaAFOcdsR47E3MtUR0TbnxZeRCoiYdAm+GzmUmSN1Thx6ugqBL4M2BIxHZi10hJvAIe666fTJnoE9FbzR0MwANhiAK0dzovtxR33s17Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by AS8PR04MB7832.eurprd04.prod.outlook.com (2603:10a6:20b:2af::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 09:43:59 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%2]) with mapi id 15.20.7918.024; Tue, 1 Oct 2024
 09:43:59 +0000
Message-ID: <92f6a685-fb1f-44ad-af2f-e170a8b1d849@cherry.de>
Date: Tue, 1 Oct 2024 11:43:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-rockchip PATCH 0/2] rk35xx: add support for upstream TF-A
To: Quentin Schulz <foss+yocto@0leil.net>,
 yocto-patches@lists.yoctoproject.org
References: <20240927-rk35-upstream-tf-a-v1-0-e3911342113f@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240927-rk35-upstream-tf-a-v1-0-e3911342113f@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FRYP281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::25)
 To AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|AS8PR04MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: c54105d7-349f-44b7-6e92-08dce1fd934a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aFZLZkVGZmtyeDlZeXFvbWpFY1UwMkxIUExrSkdScWVPaUtQNjk4WHNiRU5s?=
 =?utf-8?B?aWsrL1RoZVZmaGV4Vm9RQmV4ay85b3VpbUZGMGJTaWxuTlZNTkJpR0t1aFRH?=
 =?utf-8?B?aUNMWE5VblE0YkFNUUNNRzY1UjJBOE5jT0xTVkJnbzEwY0pXYUxTZnVsNWh1?=
 =?utf-8?B?cHlsQ1d4TEpjUXJiblpBZW5USzJDVXRXY0JxQituRzJBOGNjUkF4TlFBemN3?=
 =?utf-8?B?NnI5enA2dnU5dXhsYU95R3prb2xrM2V6T3ZKZm93eTBHZGRKa0NjR01sYUo0?=
 =?utf-8?B?Rys5NkRyRmhLaUlkdWwzTVR2NU9qZytsREJTN2ZQRjEvL1NVaDJiSno3aXk1?=
 =?utf-8?B?M0R3OW5BWmFBamZEeEhZUXkwM0Q4RFM0U0l4SStTRWt3dXRNOXNKUjR0U1px?=
 =?utf-8?B?TDNmZ3BwZWxiVkk0YzV5bWVkdHVlbTdNalljaGYyTFdqdzdrWVR2ZjVTdkpF?=
 =?utf-8?B?Z2tmWW9GVlNMbXE2VHhlZy9PdXc2TzdvTks5cEJ4RGIyUmxIOERGZDE5ZlZX?=
 =?utf-8?B?YjY0c3pUQ1REaW5Obk14cWNrQ0RpQUtZeUNCRDZtWDRLYWEvVTR1Ykd5ZUxM?=
 =?utf-8?B?RnNZTTJPdk9XblBkZFM5UEhQUVErM2hLcEdjS0lPMG9IdHFzRTN5eDZCSXI0?=
 =?utf-8?B?Kzc1UTZMS2Z2bVdxZHVPSVAxTkJzdHo1TDZJZzRRRnJ3ZFU0Vm10a2FKUDh5?=
 =?utf-8?B?TWJYR1VsL0ZSOVhXS3dJNGtWbFZtU1k0bVh5Mmp4a3FsckhHRTZkNWlzSnMv?=
 =?utf-8?B?Q1ViS1pWT09Tc0pIR3BaR2R2V2N0b0ZkRHdQcXE3bmVzdGR5K0k1Q0k4NVlZ?=
 =?utf-8?B?a3d3UFlLSTk0dG9kQ21EanhLaDJVNU5hbStMbEkveWo1a2pTbEFxR0R2em5p?=
 =?utf-8?B?UUt5d0NncERpbGFJbVJ0RXNkQnJjU2dWdFlnTE12aytTVDRKVGNHRDkyVkV6?=
 =?utf-8?B?aGhmWnFRSEhqMU15d2ZscXRUNThsTWZZQ09QQk9BRlZnd0tSYzNXWHhIKzJl?=
 =?utf-8?B?QjNHMHpFQnRpSmorWmtzc0dqS1RWS0xIYjRLbzhVL2lvNFFsUm5aWWs0MEFV?=
 =?utf-8?B?QmlsRXR5ZnZlQjEzOWR1MjAxZ0pJRDY0VDFrRmJhZEFRS3g4R0theW5zUmdI?=
 =?utf-8?B?Wml2U2c1cnMvZlFnRWFLMGlrSVhIQzZydXNOeW5Nd0RPbUE3Mk00NXBhb2dx?=
 =?utf-8?B?OXBoS0loWVROYUNON0hISmJ3VzlEMmtUUFZneVRjcUsrMVZnTW4wdFBtUUpI?=
 =?utf-8?B?WW1KcTNqL2w4Y3pLUDNJYzNBYndJYis0ZjdjWEtjKzNFZlBNQzhBMkZXbjky?=
 =?utf-8?B?SlpUeGw5MzZRdjJrRnN5MlpGeFRmZDRjbkdzcG5RdU1FZlRvbExoWUQwT0h1?=
 =?utf-8?B?eTI5SzdYMFBiQkptZzlpaDNYY3ZtUjZsL1Q1OFlpZ0plb1ZUckdPLzJva1ZF?=
 =?utf-8?B?RUtjbWd0VDJodUlKU3ZOSlUwRDUyUk1Gd0xpb29QOEFDOW1VZngxL1J0WVNo?=
 =?utf-8?B?c0hmdDNFWGVKR05TWi9GQVdxSkltVjJtUlVhOEJ6UFpwL01Lc2pNQm9ROWc2?=
 =?utf-8?B?TDhZUlJhZWczMjNiaTBZQTI3TVNpSUNqMlE4NzVEMUU4b1VSellKREN3ajZE?=
 =?utf-8?B?dmJ6RTdYZ1lJTFNoeGVIOWhvb1MycGtTZ09ndWVjeUxOblZNR2tkdkh6Smt5?=
 =?utf-8?B?N0xXdkF6QVRud0RMVHM1TjdyUVMwSUFab0pjMGRuNUcxcmdZWDdMMnljR3FR?=
 =?utf-8?Q?KJKJYDYPRZfzlasVj4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8906.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UTlMSWRTN2E1QmR3RHdmZms3a0h6VkI4SEc2RHM1c3UzNVRCY3NtOGlyNjdj?=
 =?utf-8?B?ajFQeGJZbEdaSi8wNCtoUVBlejBVUE1nU241Q3hzUXZNM0ZOQTUybGtTTUs1?=
 =?utf-8?B?Y2ZsWUF6ZWVXblI0RktaRGFLbXVZeVYrSzNYWGJ0anBnSzR6VC8xRXFpUnpN?=
 =?utf-8?B?ajJyOEQxWHZ1ZW5xZVBLVFdkaThDRjAzbWlKUmZ5bHZtVDEzTlppak9UMjNX?=
 =?utf-8?B?K0wycXFkelF1eC8wRVZ0T3IxRkhRZXJwS3NxcjZJcnhWMnFUVWtxM3FPc0pM?=
 =?utf-8?B?b0tRcm5WWExNMTZTWEYxbTFwekxXWDMyQVE4ckpLQm10WGJ6d0VPbzZURXJI?=
 =?utf-8?B?L3AwaEtSeTduZjZCdWc0UWR6TlEzRDJ1dkpKNUNhVFM4Z2YwVi9YRnJYdVc3?=
 =?utf-8?B?WG9VVmZKcytRWjRyclNza0drODJDR28rVUtQdGhxYTlscGI0TnRsdnUwQ0tX?=
 =?utf-8?B?MDhlbUhuN2t1SlNXK3B4QTVqejlJRGUrUjNjMHJlQ1BWSDdWSHNtc0c0SzM1?=
 =?utf-8?B?a2NoZjNSZDZ4M1A2L2lHQS8zaWtZcHhGekdHUEhwOVlrbU5xcUVNTyt4QVdt?=
 =?utf-8?B?K3YrOHpDVHM2K0lvUjZFdDY1YnNtbEsrc2paNDZURnVSWlQvZkI0K1hqRmNL?=
 =?utf-8?B?bU00cTUvMGZVb3UrSDkzS0ZyVVcySWFJTEhzQmFHWGZ5M1pjdit4MUpGYlNu?=
 =?utf-8?B?cWd4a3J2aFNEY1FZWDdUandiQXluVkhad2hac3Vya3I1R2RQYmduNms2eTQy?=
 =?utf-8?B?ZWIveGNyNDRudVNlbUw4MmZuQXNWbFlNcUROcDdadG1vNVpLd0R1UUhMY0lK?=
 =?utf-8?B?MWZ2UFIxQ0toVkNxSmlEK002d213bDVxcFZoYkJsc0FGbGNYYmc3d0VZL1ZR?=
 =?utf-8?B?SStTbFMrbURFdmU1VFFucFprdiswSXN1eWNGWG5JRnJRMWJpeElhQmkrNk5G?=
 =?utf-8?B?U0RVSG13V0tuR05LZGNPb0dpLzlwMU96RE9YRzZWUWtOWWFmcDBPenpPYkpN?=
 =?utf-8?B?MnhFdXp2bUZuZEU5MWhMSEFtend1MUpka3ZCMU50by9JVUhWV2NhanFTMUdD?=
 =?utf-8?B?ZFZXNDNDaXR2YmtRT1ZUZlNzeXpLdEtVTjFxV0ZBSWhKREJRUm5qZDJaK2Fz?=
 =?utf-8?B?L3RtTDBBRUdYdFp3UW1JNjJmazh3T2tIcG9YUFJsdjRGblJwS2lrWkhHRVFT?=
 =?utf-8?B?RXZQZ1oxdHdwU3RCZGZPaUYvU2lJWTMzejVxekFCOHJOYnhpejk2NldaU1d4?=
 =?utf-8?B?bFh5LzIxMHk1Z09QTnlLNDFLVllwMzlGR3Z5YWJqc01kTnFxSGJ4NGxCckRP?=
 =?utf-8?B?RU1yTGJ2em9GWDNEbis3S1FhRWUranNaZ1UzMko2NTR6NnF2T3JRV1JxL1Aw?=
 =?utf-8?B?Q2orYndaS3VwOENYWGV4MEJoZXZ0MFN2RGM4amE0OGljNmc1T3NiOXQzT1Z2?=
 =?utf-8?B?WTJzbGpCdVBvenZNK21Pc29semFqMXpDUklLTmZVR3puVHVBUytZZ0NObi9v?=
 =?utf-8?B?KzdzT1VSWklDak1UUHhRWm9jdGJoeC9abG01RWFIQzArdUljT3cvVitqaHZq?=
 =?utf-8?B?RFNPcXVKWFFMMTJIRG1GZ0VJR2E2cE14OFpObFhMYlgvaWVwZERJNW9RWity?=
 =?utf-8?B?cEJYdFVaN2hJcTZhMlBTNDhiakJwdVhGVTJvVGpRZGpTeFNpdGJpeDg1YUNl?=
 =?utf-8?B?RnpaME9uTFZIZVdqeTI0ZXlLTVdpVkpoNWxROW5VRVBWSUxsSjhxNEs1SG44?=
 =?utf-8?B?MG9EL2JpVWxjZFQ4eGtNSFBDL2VLc2dFZFBQWmlYVzFMcjVhbG1mc2xKTFY2?=
 =?utf-8?B?c2xCUm1idzdMbktQOWp4eDl4eFh5aHA5dk1udFBnK1NyUndROFR2WXptdzdw?=
 =?utf-8?B?RXZVTWZoRHhtWGMyS2hybVQxa3JWTEU4SVFmVWhOYlRFK1kzamhLY0VNbzQr?=
 =?utf-8?B?UTE2WnZxYXdYZTN6RTEzYkVKcGFYSXI4R25VV01pQTlwbkxsVlo2MFZocjlQ?=
 =?utf-8?B?OFJSbWd4RGZYdFJLbUlJMGlkTStMS3VxQTRxZ0xyMjJBSUtFZlZZb1gvM1Rz?=
 =?utf-8?B?S0NtenNiV1BTaVBZRHhwTnNUMXNqWHZZOE04L0JhWTI0RFBJRHZ6dHpYMCtG?=
 =?utf-8?B?QzBxUDkxUmRobUxNYVpxSzRjalVRSzdTckFnTzdoV0lrays3SHYveDBTL01U?=
 =?utf-8?B?Q2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c54105d7-349f-44b7-6e92-08dce1fd934a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 09:43:59.4929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: US/DJJRZTsWsdDa8ZbMW7xyYsU73ry/DjNNpixGMUDD6ixL+b9aIVNtNooPGcVMJj/HJJfUbyZOubqRLkfQnuTiXesdRmwtJNSQf2tXTzEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7832
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 01 Oct 2024 09:44:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/685



On 9/27/24 2:59 PM, Quentin Schulz wrote:
> Upstream TF-A (> 2.11; no release yet) has gained initial support for
> the RK356x and RK3588 so one may be interested in using it.
> 
> The default still is to use the downstream blob but the option is now
> given to the user who can simply change the value of
> PREFERRED_PROVIDER_trusted-firmware-a in their own configuration file in
> order to use upstream TF-A.
> 
> This depends on two different patch series that have yet to be merged:
> - https://lore.kernel.org/yocto-patches/20240927-rkbin-split-recipes-v1-0-0f4a9b0cbf56@cherry.de/
>    for meta-rockchip
> - https://lore.kernel.org/yocto-meta-arm/20240927-tf-a-master-v1-1-733c925c80e4@cherry.de/
>    for meta-arm

For your information, this one's been merged into styhead and master 
branch already.

I forgot to mention that RK356x support is known to be incomplete, c.f. 
https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/31265 for 
fixes that hopefully will make it in time for v2.12 :)

Cheers,
Quentin

