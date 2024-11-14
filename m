Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2B2D65C79
	for <webhook@archiver.kernel.org>; Thu, 14 Nov 2024 11:24:18 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.75])
 by mx.groups.io with SMTP id smtpd.web11.35017.1731583449692795519
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 14 Nov 2024 03:24:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=iBdjzDjl;
 spf=pass (domain: cherry.de, ip: 40.107.247.75, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXmXAyLRUh7yBY6p/WCE07ke3Km5VI89QPpSRg08wJksHGvCDQtX+5n28CWULQs/Utq9JJ2MVx5TnqPGk/BtQkZevbYZkW0PC/WGYg7QqYErpcB7jHYC71lzJWX5/O6QMEwuEVnJPD3NcKICsv3aC5rN1SMLTyAVPWPkFbWQgSEjJJ/8wNxcXUMUc7ToAFbYaEPEx+5H7Sdw+MoKkl+6yBbgmASnG/Qhj6TkHT374622zOnQuzSlk4WexnzoVxIvVIzQYpFNPrIRVRbPETl6gPbnpFpCwdZdmSqGaxDrQWDPy0z5uuQhY+kIdSU+nYHRVzXWGjuIErC3bdSZtmxJVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45JwTCxPEvs1DEDiWwUfkdIDDifri26FWRLoDg6LI7E=;
 b=OUem4YBYxEsOU9cgZ8iE7U+0zOKhb1p/cedpR776SnlBewAy7l/7fpQwDFvny/5uUCB7pfBSG17+esPBqzadin3nIM5haa+YTdLb4da2HjAVsJYPe8lFvUa0h8Fksp9AAD6PtXRMUIqRnf2Q4vzh5mNkjHBsEeql6lS24cQGYiZ6ucArA0UCNn15qVe7+kOsTt1uK6WW8WoQIGxGMkZ+7RuQmIt9k/7UcSw1XRGEEKDNKbxXMdqfVJeTD6x7PZSVPECkr6HXNsR9wfH1UEWEvpixXHOm5VmtMCuDD5cxcIDxKlM8heUj6fd0fcpZowO2Fy64L1wWvCNANXE+bT6sGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45JwTCxPEvs1DEDiWwUfkdIDDifri26FWRLoDg6LI7E=;
 b=iBdjzDjlS+wCxGFNwBLG93gQYRYaKufV56U240NsA2uVUNjE03ZE9fBA45oEb4toNGfnKOKyxO3JC4vfSJ1AJe+ihGLc9m2cOLelNVFknc5kLOahQ0OXi1mwV3n//v/dgOIn9DJYNIp2BpMZxXr+bHw33z3qylPR2Wa/Wu/eAC4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI0PR04MB10232.eurprd04.prod.outlook.com (2603:10a6:800:241::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 11:24:06 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 11:24:06 +0000
Message-ID: <d9065ffc-1c09-4153-9452-03d4c815d3e1@cherry.de>
Date: Thu, 14 Nov 2024 12:24:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-rockchip PATCH 0/2] rk35xx: add support for upstream TF-A
To: Quentin Schulz <foss+yocto@0leil.net>,
 yocto-patches@lists.yoctoproject.org
References: <20240927-rk35-upstream-tf-a-v1-0-e3911342113f@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240927-rk35-upstream-tf-a-v1-0-e3911342113f@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR5P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI0PR04MB10232:EE_
X-MS-Office365-Filtering-Correlation-Id: 8924f067-1887-4f79-eba2-08dd049ed9cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?R1ViT2dpNVNpWmdpM1ZScWhmRHVUd2ZERUFyTjc1ZW1PTVJEL2ZoUVZObmZL?=
 =?utf-8?B?dE95K2tpTFk0cVU3VlFOcFBDZkpWNXFsRlZ6VURnY2tSRFJNT081RjNYT1VS?=
 =?utf-8?B?MUZJV09POVRtNmJSam5MK1NkUHFXc2thYTV2MHNGUkRsN2JKdDJ2T2hEQncz?=
 =?utf-8?B?Ry9ITVIvY2ZiS2Zzc3NQMVo2Wld4ZXZoOUFCOEt1d0tCTDFpcDV0eFR6TTBE?=
 =?utf-8?B?bFlxd3I4Y1ZqR3BhM3BFdW05bHZjWWhEYld4SXNXTFc4U1dweHR6bWxKVDc4?=
 =?utf-8?B?UjNpNDE4ZXlHdmk3bU9jTVVvZEhUei84aWRsMENEc1ZDVDFQY0hkRllQR2hW?=
 =?utf-8?B?dHh5bktDN3BQR0V2b3kyQ0VRdGdhV0owMzY0Y2RVa3pIejQrNzZqb0NaaUpu?=
 =?utf-8?B?VGg4S1BuK3d3MEpvVkNBcEtxb2taSko4QlZYR2pXc2VUdjRObkdlTFE1OVZV?=
 =?utf-8?B?b2U0R1MxdGhZcW9XMUZsdjlMejNkbUdwQUZHaFY3SjRwS3dpTHVJWEMxT2Ri?=
 =?utf-8?B?QzdkbDNnaUdaVXZDVkxNQ1BCRFBiQkR4VTdkYmxhYWt2UlM0Y2FIMHNhNHFW?=
 =?utf-8?B?OUYyUmliZWlKMGxBK1ppOFBGRk5yRGZNOUh3TExVY1NVYUU3NlFwaEQ3Yzc2?=
 =?utf-8?B?VDlQbS9HZXJCeENHOWxVZGxtUjltZjRpdVErR1VudmtkZ0U5NWxhaG1qWVJo?=
 =?utf-8?B?SUJjN1hXS1Q0VU5SdCs3c0h2VTMyYVdxR0svK1VUdUpHUTFFZjFLSGFkOUZ3?=
 =?utf-8?B?bWZDMktndDZ3R2NZRDM5b2JDUW5kTE92ZWtZbGdqU0dhcGVSYmF3ZWI1N29R?=
 =?utf-8?B?aEJJYlVSdldMbFlvWVlUU3BvNVhFTHQ2eUhQbVBmYkZuTlN5ZU9Fd0ZSU2k5?=
 =?utf-8?B?WGc3a0drRWZWbEgzZGdtQ0xGcUlDUXltVXhrOTJiR0tYT1d6dU52a3IwaVc1?=
 =?utf-8?B?YzZNSTF3R1Q2Q3Fpa0UzeFU3Q2NDTjMrVVN4QVFQTzlEempUcks2L2FzRFZU?=
 =?utf-8?B?M1RKRXFGL0tBL0lCbTIzYStlM3lrK3NQeXdJeXBTL2hVcWMvV1FDTzBBMVZM?=
 =?utf-8?B?RVJSWWpSYk44NXJReUxIdVI3cW1wMnhLUWtEV2VOS256MDE3c1IvRkZXbU5J?=
 =?utf-8?B?QklGSi9RS29WQ052bHFJUGhZc3JSL3hwNW1TMUxnbjZlWTRHK1lrWWdoT2th?=
 =?utf-8?B?a3ZNV09nU0JBZjRoTVFYNXVlRkt0L3NvTGY4NlZibUpyQzdsaEJ0MmttaEhB?=
 =?utf-8?B?L3ZUd1JPS0dJQVZSS2NRcXE1R1J4OXd3QUdPU21Wb051ZlQzbmtqNTZqRGxp?=
 =?utf-8?B?Z2ZmZlUvU250YjdJN0F5em5oNzgvWjVjZHVQcFkzNWtubkpsRTJEM1lCakV1?=
 =?utf-8?B?T3M2Y3ZFeTJJNUx0RFo2bXk5Z2pPRGtROUQ4dXM5SWtkSWRpR1lVSmZ5Sm1v?=
 =?utf-8?B?NllMdnROMHAvZFY0TzRJRUxkbnhNcjJmS3cyME55cHBVMG9rWmwwZHUyMTE0?=
 =?utf-8?B?cmJtVGY5T0F3UlZkVE5naHh3Vkk3Z2htMUg3cXhPaFVnUTQxcmd6azhLM2pN?=
 =?utf-8?B?Undzdnd4bTB2S29uVzk5WWppUnZXSUZTVDIzeGNMSkVScmNUYUU1YnlyZFoz?=
 =?utf-8?B?SVVLZllEN2E2WVNqQ0dJYmpXMWxKZ2pHSXNsaFlWODdYVlF6S1F0L2NiRkpx?=
 =?utf-8?B?VTkxS21TU2ZOczY5TDdjK293cThQUFpWcU1Hc3k3Q1B3QVlFSUI1V24va1da?=
 =?utf-8?Q?TfsuliHz1Y84VS4/NR3GudCnf4UBD8F07mMQx1G?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SnhYM2dMdmJrNGNUa3NGTmpDc25QeE42YjRsdTFIYmowTFFSVkJvemZaRjBY?=
 =?utf-8?B?N2xXM1pxYVhUemtlbzR1M1dyQzd5Sm5aRy9UMzlVeVc2dlVIR29kaHdXWFM1?=
 =?utf-8?B?dzZyQ1JtY3dNVVdHOGNaWDc2Rjc1Vnp0WDQzOEpMR0xBUGZzRy9aTGt2RTlp?=
 =?utf-8?B?T3hqamhkU0J1RXVweExzcTVYdk5nNzVYUVEydFJQb3ZoWTNSaEhub2xOOWh0?=
 =?utf-8?B?QUNha1UyT3FZSVFUOSt5MkRIeFdQQU5XTkhtbW5pOVdubjBKWVhCcFUybU4y?=
 =?utf-8?B?bzBEeGE0K0dDZmt0V0NNMnNNeHZDbUx1VDREeEZPcTlZUWdDeDRxOTRHRlUr?=
 =?utf-8?B?Q016TDZDdmxSQWQ0bkxOMTZBZVhvOTdLOE1hN3gvK0IxSEJBem1pL3NDWitw?=
 =?utf-8?B?dXFhN0x0b0dWRW1yT1NwbFZCQXA4c0p5aDJka0pucmxSdHM5bjQyWjhpVTUz?=
 =?utf-8?B?Zkt1NysrV3dTOXZWSk45NGt5R3BhbGtKaFdjcnNKbnlOU3dkN1NOclNZY1lQ?=
 =?utf-8?B?ekgrNmorUXorZHdaakU5VnRpL3FZSlFHM0hVZ2htbjMrc1RJeDkrVDI5U3B1?=
 =?utf-8?B?OG9FYUFDWXNzK2hFSGFJKzJxWGNsaVlmaXQ0cTAwVkFSV3lvcTRWZWZ5VEhC?=
 =?utf-8?B?WXZnZEM1eFlDNk5CaXBjN3A4RVI2OVcvcGoySjkrcTl5cFlWRGhkWHBTUjZz?=
 =?utf-8?B?TGFDRzA3WFVaVUhwNTFEZjM5eXZZVGRJOGNZcEZENU14L3FOLzIyeHZIc2to?=
 =?utf-8?B?RnJDT01DejlXYWxvZUs0Y3B1ektXQ0lFZ0JEV2RUUjRPdEMyWk5DRy9wNUZS?=
 =?utf-8?B?YmdIZXp0RDc0eEhKOUtkdmJ4ajA1ckNuOEpxMEl5empkVTVYRkJnTUpEMmFz?=
 =?utf-8?B?cG9lSjVrajllalRaNzZSMU5rQlA1RGZPUGlWZ094Ly8wdWcwTDlNSDdMeU04?=
 =?utf-8?B?WGZrajJpMDBldDMwT3NtMHRiQm43ZVpBL2tmZmRuWXJVbzlnQ1Nnekl1eXFD?=
 =?utf-8?B?MHZ6NVU3MFBlTU1JM0VlMTJ4cjRKT1FvbXcvZjRIM0NLMVZXQk5GZzBZd0dv?=
 =?utf-8?B?L29ibjNjVWZOVUFDNDdFV1Q1WlRwR0tVTjBzT1lmM2ZGYnRjOW5rd2tQcUlD?=
 =?utf-8?B?RlYrZEg3ME1SMFRhN0pzL3Q4ZFlMTzlJZnA3d3g3QWFHTGE4SXlpbFRqTUlu?=
 =?utf-8?B?QTgxcm1iNlZBVndyU2VRaVFmQkNudHRFZ2l2VExNR0k3eEhia0U3MVAvbzhV?=
 =?utf-8?B?RS9ENGxBZVlNa05iZXRxTGNVTzJjcFQ5ZmpwbW9kUVNaUFkxY3VhclVMSVl1?=
 =?utf-8?B?WlNjRXpkOWk0ZE9ES294cTFTaEVJV2NrR2NuNU5HL1FNUmJjMEFKRkRicTIr?=
 =?utf-8?B?YjVMYTFOL3lvN3VBc25hVTIzdGVkdjN5TzhyVS9WSzRIZ3hZUE9zYkF3M2tz?=
 =?utf-8?B?cG1uZytYaVc0ZDBEbmRNTmNJZExKZEY3ckkyWVBlRVV6ZEgwZk1KUVJNWG84?=
 =?utf-8?B?QllyNTAzWjRWeHpkQ2xkNkVzczg1R0F0UGU1QmxJNlhJUERlY0FIRUdudk50?=
 =?utf-8?B?TmN6YWtiSVB4Q1lyT1JFMXFOaHJQWm9WTit0RHFSV0tsK0J0ZTJtT1kvc0xl?=
 =?utf-8?B?U1JWMlJIMVV6V09BUjJRSGI2QnROZlcydHZ4d1VJb1laS2RMdG9qd1JlMkNh?=
 =?utf-8?B?YlVlcnpiNTlrdUJuTTdXSVRCUzZYMmNnYWU5bVdVRmp4Yzk3MkFsL0dLM0Ny?=
 =?utf-8?B?dXdHRk95UXltZEtOSEJHTW92M1ZmMXdrYXpyczBURnViQlJGN2hTNUk5eWxv?=
 =?utf-8?B?ZkdLQkwveGlZTEFSY3BQK3Vvd0o4bHpqa0YvWjZJS1NVWHpUc3pMKzJQSUw4?=
 =?utf-8?B?R0o3Mm1IQWh3cHl5S1VUUU5kTFlmbnpMVWlibzl4YkxZOEhBWXRneGFUaEJG?=
 =?utf-8?B?VElMZjVISTBheG9OS2lYRTErWmd4WVJZZDhxSWlyK0NTN25ONU9QUWdMZG5G?=
 =?utf-8?B?Z29LQ2dZNG9vNEZBTVloV3hKd3ZHTWVxREdsOWU5RXZnYXJoa01WOUFuU2w5?=
 =?utf-8?B?QStKSUtzK1gxVEJ5UUdLTWdnMkpFS3dYQk9WWnFXb2NCVlVaWnZpNnkwTjZr?=
 =?utf-8?B?ZHFEZzdCc1J0Q3FSTTRqZ1FlT0E2Z2FhOG5scmdwNG1qREx0YmZtVm80ejB2?=
 =?utf-8?B?VVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8924f067-1887-4f79-eba2-08dd049ed9cb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 11:24:06.4828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LBYTlTXfHFI473CYnAZxn9LB5ZdHSEH5VqLnrcwnMN9kH21fHO33ma2R/hDTXqJSJglTuvq2LHS0FsLnvOltSM9Y8K0BJIkI5FiimzJK9m8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10232
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 14 Nov 2024 11:24:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/799

Hi all,

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
> 
> Only the RK3588 support was build and boot tested as I don't own any
> RK356x board.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Just because it's unusual for Trevor to not send a mail saying it was 
merged, I do it myself here: this was merged into master.

Thanks Trevor!
Quentin

