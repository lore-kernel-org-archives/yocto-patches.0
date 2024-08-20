Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF78FC3DA4A
	for <webhook@archiver.kernel.org>; Tue, 20 Aug 2024 13:24:31 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.60])
 by mx.groups.io with SMTP id smtpd.web11.19412.1724160261958403501
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 20 Aug 2024 06:24:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=OLJpzAba;
 spf=pass (domain: cherry.de, ip: 40.107.249.60, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vxND10KEhk1639ekWv/nv5ZCh2Qz/lNyT9eRj32Omwl7RdFzjxbB2MVks67YarloWqiF+CFg3YPV92asN5LLmZGOvB5X6D+vzAJeJNJB5cTUjKdCw/d8ijKGCqXy+UtZsw2mk/HrPAEmGowYzDLYuCmIi9fBP1f3llJser1maHbisK15g1/8DQK8qfqwi6t3jwfPXzmF3mOkVUY2y6ywDzcm4hhuqcc2WDaI9s1NH5AltXVYj2zhLYzgWUjI27TCeUbcgEk9SERGsaNkDTd5ubjlrm7DUeuw3R7ITCaIJCpG+oxC9AnFCmt4kYFdxKVrdcj2w9TDF3VRl2KRqvaklQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTICOKPXMtiu7m94ADvseXdhTp51hflJGAkqNcgzfNk=;
 b=Dtc8vbKukkaL3rDiG2F2ecAxa7kM2QNPBUJQ5w6vQHP8EyL27frVXOAHdQXmaQ4tHvPkSOWhhsic1+M42thaIHCfcbdhA6lKiQZ/tVVDSRXxJ0aE5E9M4Q1NIw5XeCyUkl14FyznKyCDQfaI+sXU2arvIhyz5dzztkvY51V89UFWAsMKah4HME4RaOJHh1uGmoyIk8naBvP6p4qYYtkOfxeN8h5XSj+dmMiUFcQtxOz9JdmzaB/6uoZZ2KY0UdKNq82gsKDqVjESXPsZp0CUkrWD7bfMKWp9QGrMOa/L8rZZLSjCJy/Jh/+tC/GS66aOBcE6tvQkAVDkSjg4qYH5Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTICOKPXMtiu7m94ADvseXdhTp51hflJGAkqNcgzfNk=;
 b=OLJpzAbauZsi6jwMG75lQl7oehN1c2QGKhGWUrr0R643FNSR6Y72WirgPxj8tz0fTEEb0e/oQiAuCASO40jLN3QN3YWDjoskv8RuTWv96rFIcOWl2ClVp2LoYl01/JRoZwA/yxCzxjaGd4uFEkZyheNPwXqw/bwjQmQmIuCRD1U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB10706.eurprd04.prod.outlook.com (2603:10a6:150:219::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 20 Aug
 2024 13:24:16 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 13:24:15 +0000
Message-ID: <63194cf4-0111-4c4f-9342-1c947725b185@cherry.de>
Date: Tue, 20 Aug 2024 15:24:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-rockchip PATCH 0/9] enable v4l2codecs gstreamer plugin for
 VPU decoding
To: Quentin Schulz <foss+yocto@0leil.net>,
 yocto-patches@lists.yoctoproject.org
References: <20240820-gst-hantro-v1-0-335c4eaf8e8b@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240820-gst-hantro-v1-0-335c4eaf8e8b@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0247.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB10706:EE_
X-MS-Office365-Filtering-Correlation-Id: caa7614d-0ceb-4013-442d-08dcc11b6350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?U0U4MHpOTXliMlBxQzQ1aXVXNEtnUHpOeUR5RUkvWi9QTEd2NDYwaWVsZzV2?=
 =?utf-8?B?M29ZR083c0xIcFNSTzAzUHNWemptakFDMmJaVzRNWFhCUDI2NmhVd1ZoM1Bp?=
 =?utf-8?B?RUJpYWZaLzZQVFFUQTJjMVNJNzE5Rm9RVUQ2TTRoeDFickhiUHhqVWZ1VDRx?=
 =?utf-8?B?VTJtYWplNFU3K3F6TDlhb25HWmRQOWVKZEFURU5nbHQ1bzhpYW9HNzVQeXhZ?=
 =?utf-8?B?UkJVVlgyS2x1T3UzTU5aanBEQmZzV3BSdlVjbnlpNXhHNmFCemVETmZWUGNX?=
 =?utf-8?B?OWJZWU53MWRVK2gwajhlemRmZStESWJ2NE5yVTljRldPK3M5SUkxbnVjTG80?=
 =?utf-8?B?T3YwYUZ3bHRJaTNNOEpvSEovYkRvQ1g1RVY1b09XeFJQdm95MmNQazFZYzdC?=
 =?utf-8?B?K2N4S3l0M1NoWWtHQzdtbTVSRmlEOCtJN0lLNDR0RGl4SW9xdGJ4Z2k1WXUv?=
 =?utf-8?B?WU1NK045V2JnRngyL1JWOFZDZjU2TkpLbkY1MFFnOVlrTXp1OEt1MWhaMXVV?=
 =?utf-8?B?MWtyN2F1a2I2b2o1VWxQa25xcXVOQXdqTlk0LzRUKzRVMHJwakFCMkNrQmdk?=
 =?utf-8?B?VFVYTUZlMGRlWkhFWVJkRTdvTDM4YytFYnpPQldKcG9jdnZ4ZTFsWUlRdUo0?=
 =?utf-8?B?bVNJWmdGSGFYVEN5MEdJeVFPOEFvUzc4L3phR3hqVllraTlVNmRudGR5cUNP?=
 =?utf-8?B?VGw4TFEyNEdUOVhZRE8wR1Fma1JWMW9aNDM1THVVZXIrcUxwUVozNnlXRmxC?=
 =?utf-8?B?bnNGZUc4OG9XL2JYdUZ0dWw4V2ZlQVBhS0dadEgyWWxEVnJYdkwvcHpwWm1z?=
 =?utf-8?B?a1lmNWIxK0JOUFZLYnBKRFRDVWVFK3g3amVDSWZ2cllSRkRuVGh6VFQzMDRo?=
 =?utf-8?B?ZTFmMjJoVVFpN3QySlBsVzdwb0dKenZiNzlhTHo0T29wbGgweDdZczlOYmsw?=
 =?utf-8?B?NnpWSDVLUWFXT1pISzAweDhsUkhpV3hhbW1OUHJqd3psV3Z3bkwwK1NkcmpE?=
 =?utf-8?B?UTlEQXFHa25ZVnBFZW9GOXQyRFJtT2lLVTNJOWJXSHRDd1JZRXJWRWdvSElS?=
 =?utf-8?B?K0RjOU45T2JGSVhNRGZ5V21KWlRDR1BUejhSdSsvT2NGWllHUW9EdWlEbXFE?=
 =?utf-8?B?bDIyc0t6aHpBSUNIK2xqaVFFSE5WNVBJdDkvbUN3SUxGaGZwMW9lbUhPMEIx?=
 =?utf-8?B?NmZ1ZUVvTlR4aGs3Z05veitDc0YwSTBLYXJDeWttTUhvVkIvQ3VOckdkS295?=
 =?utf-8?B?TGdQN2ZqN05zSWdvK0FZMmVzNjZRaEFkMmhpRmJiSEsyRnBqUERZcEtRMHc5?=
 =?utf-8?B?Z09lcThWdStZcXhTaDVnUHpKdTRvZmpZYllJRG0zVHhpR1hEdXl4ZU5UY20r?=
 =?utf-8?B?N2xGaGQ1eUNPbCt4dHFSUjlla1g0UlFlT0tKcFZkUEgvTFdBZFNNTEZ3ZnFC?=
 =?utf-8?B?a0VHS29lUkc3T1luY3p5SzJuNTg4N0FucEZXaGtTY3NtbWJaN1pZQ3dRc2tF?=
 =?utf-8?B?M3Rab1ZERHZNRGxYdDBxM3JNVUZMYm51NlVJODNMTHRQWWFRUnZCSnVMVk92?=
 =?utf-8?B?K3lRK0dKRm16aEhOSVpzQUY0OXd2WXNHaGhkaHlVNFNuK2pxNUVMSm9tcEts?=
 =?utf-8?B?MnVMdTRzeldkOFVXZkdoV2czREM3aW9lUXFkZ3MzVWY1SGFqVHEyMWY4dnZK?=
 =?utf-8?B?TnlnUkczWDV1cVEwUGlHMnNGSW9ycHQwNlIvc3NmdlcxNEFITndmaFYwbTl4?=
 =?utf-8?B?eGF1a2lRWnlVaTlCbTZVcklFZlkwdjNId0QwQk9lZ3UvUkFBdHVKak9Tck5V?=
 =?utf-8?B?N3NQc0k4azYzYmpMOTdpZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QUVEbi9xUEc2RGxLSERyTUJIbm5GcWNMdCtucG5QcjQrc1E3NmxETzk2NGsx?=
 =?utf-8?B?RW1vM3Fqc1pxYzl3b0lzaXlLRHRQR1l4VWowNUpkK2k4MnRkVjUzZjdoS2hI?=
 =?utf-8?B?STYzT08wZUN6Vk44M2FiNkI3aDM2TytSbE1XdjNYbXFYd3BNZXF5SVkrbHpk?=
 =?utf-8?B?UTRHOUxmbzY1R0dkUjhIdlIzdlBuM3hsenBSc2k4NFFwZnNXY1RtK25jVi9m?=
 =?utf-8?B?Tkl5dVR6ejdYNEhEZWJHR0tmUVdDTjU2dkJuM0xlUzBia0Vmd0RScWdWbU0w?=
 =?utf-8?B?bi9KL2h1bEZSNWlMaTl6WWY1aE5OQkFSbDcyZ2JuS3g0ODZyRFBqTGFsdFJM?=
 =?utf-8?B?M2txdEdBVllIUjBURmNmRUkxSERpaTBYOVdnc256RXovOTRBNjEyS1JOWWZU?=
 =?utf-8?B?TU53RWY1YnNkZHZUeCtIZ2g3UW5zTk5VNlZLMS9STnc2aXdlanBGM2o1Qjdw?=
 =?utf-8?B?dHdmRENBUzFFK3dIVkk3QWxSVWU2UURwQzJhTzFHN0VaNXl3WFFMVzN0ZEJC?=
 =?utf-8?B?SVNld1VaOTBWSnpCdGJvNlA3TDVGbnppZnRhOXVhMnlPaFZOb0t6cTg4RUw4?=
 =?utf-8?B?Z0VVU0VrU1hqSXNwQWJOam85SlppN2pRT0lFTEpzeGpyUWEzVkErdkxLYjNY?=
 =?utf-8?B?Q2RGdjhPSE9TYmRRaU5aZXovZVV6YlNkVStzV2FYb0ExTGNpcmYrODR5amdO?=
 =?utf-8?B?Mk9YdDJ0dzZ4bDBORWZ2UkhOTUxaMFNyNjFnNUpLSTNIaXMvOWNSdmVwenZq?=
 =?utf-8?B?NG81clRHNkp6WTBheTFhUkU4OGs3M0hvWlRvTXFjczRjL3U1RmQ0SlN4OU9S?=
 =?utf-8?B?U2U2K0VaL0Z4WDFML3B2Z3krZnByaDJrS29HaXR6ZGwrNm9LdDFscDQwTzFT?=
 =?utf-8?B?eGJlYUk3QnhVWnF6ZUxDZzVoaEtSc1g4QkNndGtUMHdwMVNSV1dlNk1nb0tW?=
 =?utf-8?B?V1hCQnFCVnVjcVBzRW1CbXQ1U2RFdGhRakVObldxd0FQMEZrOW02NllvaDkx?=
 =?utf-8?B?cmp5VGxCaWd3ckFFRDdMMU5BeEhLS3FXcVlYTWhZcXRNeXZzWCtZUE5yME83?=
 =?utf-8?B?WHFDUkxZcVFoOXFCT0J4OGV1NkVkcFZHZmJpcndXT0xNbU9oU0wyNXJvcmxi?=
 =?utf-8?B?azY5YXB5ZTE4NkFVRDUzbGJ0dVdaT01QU2k3S0Qyc2VaME40azVYWXMvZFNQ?=
 =?utf-8?B?OEQ4M0NWakZpY2hWZ1Z2MDFIODFlQzNJSEU4bTcrdWRJS2VNbkhoclU4SHZt?=
 =?utf-8?B?bHhlUDMyNHhTdWZsUkdYWnZVK0J5S0dHRlJIMFgyUDdWTHFIMk5sbmprT2Fo?=
 =?utf-8?B?RXZKMEFPRlVLZjdubThvLzJGKzVZWURlUm1ZcUpNaEp5SnU3YjE0VHRXSll6?=
 =?utf-8?B?eDF5MkdsZnlxcmhPdS9xam80U3puUmYrQ2Nxcjcyd0R2UFkybWR2RW0wUmYy?=
 =?utf-8?B?N0hSajRvRmJhV2FFQUxwbDFDOVZpcmhhb2hTcEdrMFU5VmhSWXovbG9nMmhn?=
 =?utf-8?B?TndzSjVhT25NR0hVL3E1SWFSZ2ZacDR1eUUvd0xERVR2dlhldXp5dW9CRmY0?=
 =?utf-8?B?VG40a2pOdXcxaHQzWWxMQm80KzJkVnVDdnFSUHNRNzV1Y204cVJQUmU3OUFL?=
 =?utf-8?B?N29nUDk2Q0p4REIyU0M0UGxwa2p2eFE0YzJ1NTBnMVA5cENYVlZkTHdhQ1lz?=
 =?utf-8?B?MG9ZMERJN1JKclBqdTZqNlRXbDZUTjV6eUs5WUEvVXZnQ1F1RU1qNjVEZ2JI?=
 =?utf-8?B?Si9ZSW9FYUdTdnJmK0lkdnpDQlZva3E4LzQvRFJKRk5HNm81aEpXRTVxWEdw?=
 =?utf-8?B?SStLM1lOYnlsMjQ1UVo1ak1SNUlxMFMxYWVaLzJjdXpkdHg2ZkpVbmV1U2NS?=
 =?utf-8?B?QXBIVVlBU09yV2pGRVN2VncxaGhpT2t5Yk9BZnFhT1R3VHcyM2xNejRianRj?=
 =?utf-8?B?cHpUcDRLNzQxOEsrQ3I1MFB3UVF2UjB2RTF1OXorNy9NNDBmTnBkVEhFT25z?=
 =?utf-8?B?TjNyWU5Uc0dScFkvbGJxS1BLejZPc0dQcVRwQnd0aUs3SWE2U2dBcWw5c21N?=
 =?utf-8?B?SVVwc0Fmc3Y4YzZWUExaUVlRTnljNVo2Vm1UUGUvV3NVYkx5Q2ZxbEZ1R2FX?=
 =?utf-8?B?aTgvWTd2S1RjRnF0Mk1YSWhDT2RFUUlmZVFhMVY0TnN5eENCdnVESGFkU05a?=
 =?utf-8?B?akE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: caa7614d-0ceb-4013-442d-08dcc11b6350
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 13:24:15.5709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lONS4wbfZF8clqknDTlh0+70LtFGHE7Ng8L14raO90s1iXSml8n3gRlRTsDzUUM/Ikn6tNCzYIHZH6FGJNFFvRp5+q9/p/omjCK0lXRR8S0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10706
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 20 Aug 2024 13:24:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/533

Hi all,

On 8/20/24 2:56 PM, Quentin Schulz wrote:
> (Most) Rockchip SoCs have a VPU that can be used with v4l2codecs plugin
> from gstreamer. In the kernel this VPU is supported by the Hantro driver
> which does both stateless HW video encoding and decoding, however
> gstreamer only supports decoding for now, see [1] for encoding support.
> 
> All Rockchip SoCs supported in this layer to the exception of the RK3308
> have a Hantro VPU according to the compatible list in the Linux kernel,
> so all SoC includes (except the one for the RK3308) now set HAS_HANTRO
> value to enable VPU decoding via gstreamer.
> 
> This was only tested on RK3399 Puma and PX30 Ringneck with Haikou (+
> Haikou Video Demo adapter for Ringneck) on Scarthgap 5.0.2.
> 
> Note that RK3588 upstream Linux kernel only supports AV1 decoding right
> now. Also, there's currently no video output support, so this was tested
> on a private downstream branch supporting DSI on RK3588 Tiger with
> Haikou + Haikou Video Demo adapter).
> 
> Note that Gstreamer v4l2codecs only added support for av1 decoding in
> 1.23.1, so RK3588 commit doesn't necessarily make sense to be backported
> right now to other branches (e.g. scarthgap or kirkstone), at the very
> least until more than AV1 decoding is supported (which will probably
> land this year or the next).
> 

Note that this cannot be backported to scarthgap as is as the "rockchip" 
OVERRIDES doesn't exist in that branch (yet?). I'll try to not forget 
sending a series for scarthgap if this gets merged (I am only planning 
to do so for RK3399 and PX30 as those are the only SoCs I can test and 
that can work with Gstreamer from scarthgap).

Cheers,
Quentin

