Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E8BCD98F2
	for <webhook@archiver.kernel.org>; Mon, 22 Jun 2026 16:31:25 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.38])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1076.1782145884452278024
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Jun 2026 09:31:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=QaZ6gJAd;
 spf=pass (domain: cherry.de, ip: 40.107.159.38, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qs4ixLWPmV86Si9U2MRyZTeEaK1c5DolzI3cMFurmfll5NEqqBB5EPdrZlIYFrtEgdMEcSK/Efmq6dvpwPw2zyPPaS+VUxEsDyFmz0NKIDPqArZiqH5cj8a2NhLuKJsDZqjwZRLAwqKSIHRDNESGxRNbxdmVSmYdPnMx8JVZA3/DoQLsxruOleL3hVHrkaIpAwFqT5j334rczZiJ9Z5tIo/xR5Ic+st3c0uySCNp2X6myA7ZIjWiUxj6kjz+NbYUaUdjEtBcDgUoACOSwhseRYXqKRhxUo3LY4f5W5N/Ptg8OplH8i6+lHGS6VlwcmY+vY1DhKlAILkSLbS9wqcWgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JRKxcjMvuHiFQD/aDtmw336Fcqx7LY/10SFqKQt34I=;
 b=S4DPhypd4/xw7wRdOTTkkathZKYXnt6KWe80z7FpSfBZbLctpy6iGMBHMy1dq9NsWJdyPAuN8ufFv/BOejTdwegIFRpFWbHxsj/6jgtIzCcwNckuJrUpi14NJWg/DmmMbigLNR7tRjsBz+ApC9prITdbSEgKoteE8ut2afW+HPdmNg2YQlnriSssmtmLp0yXNzjvBGx6hgEg8PoPV3iu1X/xmyPqI0Tvjh7EtHN0YC6m7k2BF+o/hiv/r5fcZ9Kl7vs5sMngFE1/x64RtI3pRMxUzOGQu6NsKpfHeuaE9xXzKQ7ZVraiXx4C7cDB4SNaq6fbYhD+5HWitvRKwxocNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JRKxcjMvuHiFQD/aDtmw336Fcqx7LY/10SFqKQt34I=;
 b=QaZ6gJAdFntHl7Tznt2XVmFzQyIhcftAAu9Ihu4m8sTr1fJHDOyc1EZ9RSbHA012BZ/G++0ChDztLPWR/sG4eY1xbqBPBbuM7K/ov59KMo2TU/qic7CdC9BfukI5Pb0Hix2dLu9mdS7OTtyixxNCFljRKkmPSFHEPcQP37ESJ2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM8PR04MB7345.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 16:31:19 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 16:31:19 +0000
Message-ID: <b80dd198-6854-40a5-90d7-72b5d8603424@cherry.de>
Date: Mon, 22 Jun 2026 18:31:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH] u-boot: fix incorrect
 commit reference (radxa-zero-3)
To: Cleiton Bueno <cleiton.bueno@b2open.com>
Cc: yocto-patches@lists.yoctoproject.org
References: <20260622134626.3616736-1-cleiton.bueno@b2open.com>
 <9edde087-11b6-4377-b74e-7637883c0d52@cherry.de>
 <CAA-i2LwP13YUZ8cnN7G8h3XuYESC36PPHSyvnTp6Oyd+PnXA7g@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAA-i2LwP13YUZ8cnN7G8h3XuYESC36PPHSyvnTp6Oyd+PnXA7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0072.eurprd02.prod.outlook.com
 (2603:10a6:802:14::43) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM8PR04MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ff0359-0e6f-4354-217e-08ded07bb058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 
	KCXigZTjydcDB+BKq2geum4VRB7Ik2sYzGePG5rL2/strVrJ7UXaCovCjNQjTC8kxmwO6KuV8QsRlNZ1cdj5hEnrDmjKkTXdcGeX/yiYk2FmQ8moVGF6noDefiwPMz0dvbAuqD8mjVMAR5vsiwxJi8WY4bSaesLGrxNH0hyTfDnyDiNKvGnYWRvyjHenfhYlWUuavEfgFfRig7qCzw+ws+x/YZ9IR75umHocHO/MfpkCtR/7uKx9eoecL9n/Z8OekKMC0nBetDi01Ej4V3XJ3c8FQ3PDl9GBsZK+9y4RbBOs+BS/YxTNCjLOjughS2suunnFxI5yIA3qe7qJW6R+57f1V89knD3hnrS+8k8tsc/QW69sLNF9Gi1pZlB8fqKuRWOkehSNTAwCxlHINa7A8BtKPrajMu66bX//XQMVTF6RuRba+Rw194UOQA8nAgQ1IBGM8eGe+YeU7vOz0px0EgrybNrfpEm+5XOF3bHiPJARuFIQiPp6R6r9C65Imt1ZN8p/U0uQFdWY/s/3cCmAL0rK7NPH/0JcTQ2Dv+Hwb8N0KzylOLnzYD38ExWHN+hLNHWiuLHTcwWj4xmsTHIkxQjqijqkFquYCK7f7UNjT5NNYQPMU18Lb9/Mav0OkGctuIr+jXYLTBjxFFVyu2j95Pdl6jkwDM6kCTpsddubFuk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7737.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MjBrbVpYTzgwMkxFYzJUQVN3SnFNd011M0U2eXRINHZlTE00NG1jODU4ZVVy?=
 =?utf-8?B?aGtXbFBsWHlVSDIwbzFhbjY1YmVoYzV2OVlQODhpWUxJK2J2ZldYaDdmQXh2?=
 =?utf-8?B?djM5dC9ab3h2Lzk5eVo3VHpxUUFJeVlEaGcrQm9waHJSQWt0RnZadE1LZlpm?=
 =?utf-8?B?bnBVOFNER2dqY2FML3ppV0ZkUmxTY1REbjJjYTlNQWJZanFsR0d3UkplQ0lM?=
 =?utf-8?B?TFZoNmJzb3dkdEFsbnd2NC8zMG4ybWlqRC80eTZGOW1FcGFTdGNyd2pnVWp4?=
 =?utf-8?B?aC9WYUpRS2s4amNnYmVRYVVqS09sb2docVBoYmRxTW50eUJJVG4xc1gyd2xL?=
 =?utf-8?B?MTMyNVhJQU1XVy9lZTlVcDNUZ1VOWVVIbWIrYzVsRDZleEpqL295WFp2Q3hu?=
 =?utf-8?B?Uk1LOHFBWjJxbjFoQWRGTGJ5eUNBSmZ1ajJHcnlNdmx5ZjFTc3dveGZ0VXF2?=
 =?utf-8?B?K2xyRUJha1NISVF3TEFIbFZRa01iaDMzODlGOHorWElGZ09tMU1EM1N6TVpD?=
 =?utf-8?B?ZzRhb0NxMlVtOW1ZZThBNTc3emQ5LzhZK1dSL1lLNzQ3Zk1FTW1xNVBYdmk3?=
 =?utf-8?B?WFBtRXBnbkFpR0xIdUF6T3Vocm9lT0J2dU1wRjJ4dXZwRkNOblJUU0ZFWHNS?=
 =?utf-8?B?Z2VtZ2F6c1hqR3Y5NkhDQjRGdVkvQTdkQ2o5OGlVSUM2U3AxUmRnOTNVSDlG?=
 =?utf-8?B?SXhUaElwUmxENTdTKy9Wbk4zUGlvNEVEZDlPTm4rWnU0Y0xGc2ZOU2hiZ3M2?=
 =?utf-8?B?ZERGTHJ3MGJlUGRiMVdYNitUem4vQWgwMDJSdUJoKy9OMjVtMEZsTk96angx?=
 =?utf-8?B?T3ZIN296eFJhWS9LTGYzelV2ZmVsc0JrTXNiWkNza2xPVEdGT3pJY1lFUjg2?=
 =?utf-8?B?citJRXlYekdja2tHNDJzUFZ2Z2NQTEFmdGRZLzdIMkgwNmJac1I5TE5MWCtR?=
 =?utf-8?B?RDB3UktYb3dHb2c1WWcyVlEzeGhmTnQ2SC9RRmFzYy85b1NtL0xyM0ZucGdJ?=
 =?utf-8?B?WHhpcVhLTDhJZWJmMDdhR0ViWDAwNnNvRmI3Q2lZay9wVk5aanZWMG5LUU5k?=
 =?utf-8?B?YW90dTNqQUxVcUVaZ3VGelhVSWNPQTZzbnhOV3l6bnZnc0p5ZlU1LzdkenJO?=
 =?utf-8?B?c29iU2NnTDg4SzZ5VzJuL2UxS05GWTRtMVJZNDVXS3oxNW5FbVQweXlYNnBT?=
 =?utf-8?B?emh1dnZCWi9jQkRYQUZKalU3blkzWDgyNzlvU3pUM3VOdGlzRllqajc1VTRH?=
 =?utf-8?B?U1lTY3ZyT2p0RDV0Ym4yTkdaekNZWGRPTVREeDlsME84b0t1a3VOQWoxWU15?=
 =?utf-8?B?YkZLZWhmOHNSSjFXYW9STG9RN1FrVHNVNGNBR0VYSU54TDVGbTFwb1dMQ2lh?=
 =?utf-8?B?TGg4d1M1VC9SQ2UranFhUEcwaktiUnFEZm1YdjFyaU1odXRiMkRFbG9zWEZK?=
 =?utf-8?B?SVZSWE9LbjlXT1kvOElYeFM3TzRqZGpJTGVGQkoxM0poU0tWRWpIZWdVZEdv?=
 =?utf-8?B?dytJS1RKa0N1MDdpY01nbE5QdzA0VnVXa2N3cmlXdFRiY1Y4SGRHNGtVYzhw?=
 =?utf-8?B?YUk4dGxiOEFVNnlyZWtRWEJ1WkIzanN5QnBwb09uaU1ZL0JRWmtoQzFFTENK?=
 =?utf-8?B?bzFEejBZN0JVRkt6Nk5FdnI1M2F0Z0JFaW9VVE5LTDNFYnhIdEhmNjRwemZa?=
 =?utf-8?B?anppMy9RMnFVY2tFT0YvQ0hzbHg1UGpFVmlrR3YzTTIxQThrZ0Nib1RZb3Zh?=
 =?utf-8?B?NE1rSUJZRnhaRjl5ejZKaVMrZFNKOEtuNFAybWpEMWNCMU1mWkZxbVRxMnE2?=
 =?utf-8?B?YUZmbERWbjltMjAwN3FkUTg4U1J5dDc0L3Z0QzBMcE15a1JTTzZKTVZ4VmxD?=
 =?utf-8?B?Sy8yeVMrVS9Ybkp6eEhTQzdkNkhGWERwVUJ0RnlnV0hLbmJTV0pkWEQyQlo4?=
 =?utf-8?B?RE45ckRMMUdzNGRoenJpaFdBTGpSbGxTbWJOWkY0VndVRDlwZTl5dTllVEFQ?=
 =?utf-8?B?VVdmalVaQmp6aFloaXRxTDcyQ0E2RFZ4My9SSnZSNytRZUl3cjFqOUpjSkFY?=
 =?utf-8?B?bmNXMmVNWmJiQlNjOHdZc0xJNi9yMzRucHpobWdZWUpaWHZYK01rRWM4bDhq?=
 =?utf-8?B?WUVLenRaaWU5cXZHMGY3aVVoamRsZjBxeFZTM1I2Ky9QZXZFMGJrRE9pM1M3?=
 =?utf-8?B?b1g2NHBqbVpPaDBscFVPRTA5cUV3S2p5UWMxeTlBOHpOaTRpN256VVRudHkz?=
 =?utf-8?B?VGpnYlZ2K2tBeDNWeUZYWXhqNXlwTlpmakY3aXJNT2UvZkVtRU9YWXBRZDJj?=
 =?utf-8?B?VzZjSjV2VlRwWEZTTnlrTUxWd1ZsbUR5dm5SS3R4bk5kUTBoaE5LUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ff0359-0e6f-4354-217e-08ded07bb058
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 16:31:19.3863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6mQVHa3YYzuxmHi4iQ44jzNPc8KdP6gv0ektHCiPcU9Wn/+MFNqUXjFwZqptV/HUPmSuZPh/GPkRoR47upb+TbLegkab+9jghWOEyNSYHVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7345
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 22 Jun 2026 16:31:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4260

Hi Cleiton,

On 6/22/26 6:06 PM, Cleiton Bueno wrote:
> Understood!
> 
> I'll move u-boot upstream and test it. If it works, I'll send a patch with
> this modification to radxa-zero-3w as soon as it's working.
> 

I think it works given commit 1cdcb4960374 ("u-boot: use upstream for 
radxa-zero-3{e|w}").

Please have a separate recipe though, we don't want to only change the 
SRCREV in this u-boot_%.bbappend.

Cheers,
Quentin

