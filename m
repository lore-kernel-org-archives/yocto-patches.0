Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA450C83F27
	for <webhook@archiver.kernel.org>; Tue, 22 Jul 2025 14:07:33 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.14])
 by mx.groups.io with SMTP id smtpd.web10.13576.1753193252748179991
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 22 Jul 2025 07:07:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=TH7yxqMv;
 spf=pass (domain: cherry.de, ip: 52.101.66.14, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owqzXOQLL8AsXvE/yAEHl3BbRrtkGjLc7nBItkKnu16yOKVPVhv2M1JpvHShOQYt4D4+cuDpjIhTtdXmPbAbblALHJRwd3G/A5PX/cqJbUdeQT6rweYhaoDQPp71XiT2wKnSfRYNALMFeMkpXcJTYh8RX0Lj059DiRxcUnoAcu2tdWY+DO5rorGh+ixGiTEjBgJvW+9AmFqJu59rfvmQYZRgeRfqywvlgFwYDJSXp9UkR6Bmkskp/9KHeXaPStnzQiP/eUvULE06LpmBGmrT9E/QsVdI0bAYNIEEajU1gGnh70Is02QV26XCifP89h9emtJbfKHpMRnQxgOzFdo8kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1x1QsE0JVXA91obmP+kQOwMIEKy9hEPwgK995gzw/QY=;
 b=UrW5pzkxvdkR/iJsCecWkDCkJm9iIQZT8tN+4rmcxIpXi1kO+4QGlUig6gbctwX7awThMQPWw2wZJqCNb7yY6GmX40b0Jk+GzcjgSu1GxntoUG8oRp7nh80pmGKnU40wVX3BlOxAoIkZwIW8viFVuJhKegkSZ4OGbcrLeCBvhGCOZICqhRNjeouWhpkHziJ3mc7nE162Sv7GH2RW4ZBSLDJGyS7/ozBSel/CKB+ppk75xfnvrZXnM7LiASDVwwQWlsZOUJAJu75KdXMF21x/P0F3Q8+UF0ZkOqAOohmVZOtu2Te1uo80siPcSm+c8QVuIKkUxsJAQanhJg7dr5jIQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1x1QsE0JVXA91obmP+kQOwMIEKy9hEPwgK995gzw/QY=;
 b=TH7yxqMvyeh30w+Kbcc9P9ouNTTLRsLLplPG5ls2vQpw+VeyDdaFcgMGWFNGdIqYU/EizB6ae4wDw76TCBKoa1DBPvFxSxK9GQxRpGKRcO/CbtZVEEcDzD0YT2CyWkUyt0W97yxpUaj7rjzkV7yeKPI6XiAlbgT6YjL6CRlQQDU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM0PR04MB7138.eurprd04.prod.outlook.com (2603:10a6:208:19e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 14:07:28 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 14:07:28 +0000
Message-ID: <ddad8cff-21a3-4ff7-86ce-7301f36114f6@cherry.de>
Date: Tue, 22 Jul 2025 16:07:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] systemd: repart requires
 fdisk explicitly
To: yocto-patches@lists.yoctoproject.org
References: <20250722135829.25568-1-twoerner@gmail.com>
Content-Language: en-US
Cc: Ross Burton <ross.burton@arm.com>,
 Hiago De Franco <hiago.franco@toradex.com>
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250722135829.25568-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0167.eurprd09.prod.outlook.com
 (2603:10a6:800:120::21) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM0PR04MB7138:EE_
X-MS-Office365-Filtering-Correlation-Id: f80c3080-b532-4f6d-8e48-08ddc92917b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UzNERE00cDl1UGI3RkN2cUZYOEI4K1A3UmQ3WVdYREZKYnNpVkZraVlCVVBN?=
 =?utf-8?B?UTRIY1NpQ2t2UE1Ud0t6QVE5WWllazI5bUVIY3UyZTF5ZkpMaTBBVkFmbEVB?=
 =?utf-8?B?cTlVa0RCQ3JKYmtqL3BieWFWSXVDanFTREIrbjBiYkwvMjh0enZMYlJ0eXYx?=
 =?utf-8?B?Y1cwS0NDZTZrNTRHL2RldXNIenVGUFNyVUNYQ0JnN3dISjJiVXRYaXJUYnZ5?=
 =?utf-8?B?VEdpbk1QODYxaHJvM1hVMVFGS3Y0eWpTN2syZ3pxb0dwaFdJcUdxYkZ5cy9N?=
 =?utf-8?B?Q0pUVUg5K01DSTZaOUF0ajQ4RzF1SCtWanU1eTB2aHA4R3IxQlhPZ1NjMkdn?=
 =?utf-8?B?RFZScmxCNGw0QWczOGFSeCtYMC9XaytBM0wxL21Md2dzMTJ5WElmaytENnIv?=
 =?utf-8?B?L2liNEprWlRoYmxPRTE5UThBeFNyODB3ZjQwTVpPNXdNWFBhSFpCb0RVdlNI?=
 =?utf-8?B?Rkg1YlVlMnVteDBRN3l3ZkxHQmdTNFJXVGIyRFZBVlRQaXpia1orV3RaQjZM?=
 =?utf-8?B?dlhCWDgzYlhWcXNVdGRSTURZSTBoS0dqUnQreVdTYWwxSHU2b0tlK3ZsaWsx?=
 =?utf-8?B?UTZ5S3MrNkxMd25BSnBqQVc1NWZpdmJaaC9IUnRSTGVQVlFUTjk2SlJOc1NW?=
 =?utf-8?B?WTlQZS9vZkhGaXJkc0FncEdQQldwaDZmSFRXVmNRT2lwVXFBUnpHSVlYVSsx?=
 =?utf-8?B?cTArQlVoRjZrd0RhcnF6L2dWNVFjaDRnaHpBM2ZlNDNQK1Q1NmdxMjRNNXpD?=
 =?utf-8?B?d0piSjVoN3FjTWpFVkVTdVVTeElrQzVsNjEyMWR0NllZRDhyTmMxVVYyNU9L?=
 =?utf-8?B?dTRWN2JlTG9sdmh3OHp6VXdONGlGUUw5Y2E2d0l6QzloWXpCN3VKTHd4ZWx3?=
 =?utf-8?B?SStNTnBEOWtYOFNveHRqVGoyMmoxZmh2OW1aeGxkRWp0aUs1WWtwWnA3OHFQ?=
 =?utf-8?B?R2JiSGxNa2NneGVFYVBxcVAzNHlReWVza0lFdnJ4Qm83R2pDekNUVE9XNVRO?=
 =?utf-8?B?QUVYelM3WW42MkszRGJDbGZsWVdyYUU2VUEySS9oaTZLcUlCMlVwaEhYNmNp?=
 =?utf-8?B?dGljWXdFUzNkWG1CbGc2VkZnbEtVcnNHQ2RlajcxOXFXeHM2Ujgwa0pYVS9H?=
 =?utf-8?B?Q0F6cEwrR3ZaTEFNZUhweHBoNm9FWVJoRzNXa1ZFWGd3M3JESE5JOCtEM3Fl?=
 =?utf-8?B?RDltdmZjVTFGUTVwMUgzNVQ1eGJPbmhXYld2ZzRTQWh1ZVV6YWR6M204c0hr?=
 =?utf-8?B?MWhBV2c0dHArZ3FPL1FoTy9Pd0NQRExETk1MM2RtYUQvZkN5b0pRWkZzM21K?=
 =?utf-8?B?SzZqVGpFZXBINEt5TnZ5WnNzMExQU3FidmJHQjFKbkJYQjNUaHpPZExuV3gv?=
 =?utf-8?B?dnBXaklwZVBobnBVQXJCR0c4MnlrSEpORzhOekRGYXFVKzhrbDI3Rkg4Q05s?=
 =?utf-8?B?MUY3R0cwUnBVVnR0ZmdEM3lUYW1zbmFOemE4MGVIL2ZMWTZPR21La0dHRkNm?=
 =?utf-8?B?dklnbVpjQnFTcDZscFdpc2JrazV3YlN2UlZvNWRsSHlhT1VyWGhPU3cxbnJI?=
 =?utf-8?B?M3ZKaEZSMkR4TW5vWGJ3RzhUSStIaXNQUUFremgrTncxRy83OHdyZDFPb053?=
 =?utf-8?B?VDFmd1pBUWU2SEJRbk9yOUhCU3M5L0tUVU1vR0VVMnpka3dSK1ZhSC9ycmw3?=
 =?utf-8?B?QXFHWXRaQnR6U0FidmZBMlpGM3B6ekJMK2YwQzg1aDIrUm42QW5xTjNyemZQ?=
 =?utf-8?B?V1MwYzZtSUhoR0tLNWZJbG5MeVp2RWRJSTRqVHRCUUVuKzF0dzdISk52YSta?=
 =?utf-8?Q?yizZhtWJbG3HscCt5eQsq+93/gjvqoQb+JN5Y=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZlpCdzNzb2xENG9EWXJjTjgyYkxCNXEydDU0cjVmMEd3NUkvQUhFL05XcU55?=
 =?utf-8?B?NEMxbDNOYUlLNDUvdGdFc2JBRnBzK201ZnYrQjMzSDY5NSt4L0RhT2xvSkg0?=
 =?utf-8?B?ejRMc2tZci9EQzU1SGR2dC96V2FCeGUvdDhTeGZGQ2d4OHdDbEQ2ckVyNndM?=
 =?utf-8?B?UVF3WTMzdkNVaE9oVEp1U3JLVDZMOUdzYlRqRnRQS1U2NGdLaU9ZQXNpeWky?=
 =?utf-8?B?NmdwU2M2OE1hTVF5K25KRTBXRzdIVUF5UmpKeHh1SGRyU0p0bDFEc0cvYVAv?=
 =?utf-8?B?NTdiWFcxSXp0WEdMQWVHNjNXUllZOUNhOFY4VmRMTnc5aW44bC9CYjZ1ZzRx?=
 =?utf-8?B?OUJlWUZNTXJieWJZbGtjWXlnNjd1dGkxaVVhR3JGRnFzYWQ3WDh0NXdLczRS?=
 =?utf-8?B?YXJEV2FSb2kvYlVYNjc2eXk5d3FmdDdJbkV6RzdQSjhKc3E5SzU0Snd6aWsy?=
 =?utf-8?B?YXNyakxlS2RjSFphV2NpUHRJVng5ekJsazE3YmgvbG9rcmdaYWhXM3lIM2Fn?=
 =?utf-8?B?UG00em9xbnlRK3RobU5LUlNNUStOaXIvTDRaQWdpT281Sm1mM2s2WTd4YVpv?=
 =?utf-8?B?akZ2WFpKU0U0QWtKMGtoM1dVR2luQm9vMVZYN2JmR1FEejJRSVpCMU5ycVNI?=
 =?utf-8?B?ZHBqTEMvWGxNNjQwRW5KcEt2elpqc0NvV1JISkh3Z3pRN2dLVUo1ck13VHdW?=
 =?utf-8?B?WmJyYlBDSjllOTRCR0ZoQ1FkWkh1azRsVlJZRkdGZ1JacTMxUS9Td2VSWkgw?=
 =?utf-8?B?N0FFdEIrYXdkcWVSVXdxdU03NXNCVlVyaER0ODkxOXREaGZQdDlnWDJwWkNn?=
 =?utf-8?B?TzNRY1VmbVFRbHlXVDM5a2JDMitrWTM1eEpLU3pLaC9lVW4yRTc4U295cmJr?=
 =?utf-8?B?MEZQVWNPZFQzVGwyRWNkVmp4T0Q0STNyeVBnTkx4RytSY2Zsb25tVjB0a2pj?=
 =?utf-8?B?Q3IxWDJmOEFvS1Z0bUhPRHRqTFQ1cHh1Y1FBVDhKTTVQQXgwL0Y3M2FUVTVl?=
 =?utf-8?B?S3FYeG95TExYT3ZrcytZSE84ZGFUQXR4ZWVIWTdGVVM2ODFGTlEvQmU0TE8w?=
 =?utf-8?B?eUxuTk04SWNYem5mem1GQStlQVdDTXR6T2Fpek9pbU5oRGJ5cjNpN0p0WkRq?=
 =?utf-8?B?dDl2K3BRYjFpcDNaemFXZEVWQzVLc3IwbDZxZi9BdFJ3djRTVHdlQnd5Tklm?=
 =?utf-8?B?V0VuVjhvd2NYeFFkUExySHJ0VW5WTS9ZY1had0YyWDZnYmMxUkIvTmhKVVhY?=
 =?utf-8?B?SHJHTFVhdm56U0dId01TVmlZZmRqTWlBYXM4Y1RvYlhFTHpPbXlKZUhoK3JC?=
 =?utf-8?B?em94d0M1QUJlZUx5bVFaQUloRytLcWwxT0FaMUF5dzV0NlBJTlkxTGFtcnpW?=
 =?utf-8?B?YXp5ZU0zdFB6dk9LZE9sUUx2Q3JsSkVNdDNOUVpxOW0xK1U4NVVQZEpZeFow?=
 =?utf-8?B?U1lPanUvSWRnYzhVb2JBMkxHZHNFVlJHb0p1M1NkUzBFN2d4WkFvcVZXSHc0?=
 =?utf-8?B?REdMNHlrUVhOYlBpSVB5dHF4V3JEa3ZoL2hXYWtTUDdLYkplOUpwMmZUY0JD?=
 =?utf-8?B?bEpIVTNCWHUvNnQyQ3h5WktuQWtRSjFrOWphNEk1MEF3Ni8zeGRyVEZWRVln?=
 =?utf-8?B?encxcHgySFZrTmExZnVhTGZHaXV2d1diNnovTFVBNS9CcWRGZEIzdmxpU2tn?=
 =?utf-8?B?SXNCbmFReFYzYXdtZ0llQmtnRXdVWTh3Tkc3NCtoazFneHhTeVdlRXZCZmZn?=
 =?utf-8?B?WENQRDFyTzlTc1BOY250OTJyMTUweWhJTzYzTitLYlRPVjJLVVNIcEk0QzdY?=
 =?utf-8?B?cGlMU00wZ1R1UHhhZWV1WDNva3g3ekoxb1JWUnFmNFovRUxRM0daNklYamhr?=
 =?utf-8?B?OURTTWhOLzIraGZVQUttU1FIYkh4dWt1dEtkVlpxR05id2gyUms0Yk9JV0xY?=
 =?utf-8?B?OXh1YUUvT3plRXBETmRJYTY5QmlNNzFUNlpqUytPa3RDWkpuUDFTUEpmSGFM?=
 =?utf-8?B?V2NENERjT0F4TW8xTExvcTRZWnU3ZHdVMDNCd2poODYzNjZqaEJqMU9yMW5K?=
 =?utf-8?B?RHNicUthVWFyYzNBY1Z3SDVJZm5PRHFxZHN0TlhuT2ZncE1QbzJleENyMkVZ?=
 =?utf-8?B?NkN5eGF0a2F4b1BsMUtjbzl3ZkRpeDgzcy94RjM3ejZyeGxxSkUwRUVWUVN6?=
 =?utf-8?B?bHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f80c3080-b532-4f6d-8e48-08ddc92917b3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 14:07:28.6734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dINu7kRHDJqofGySbVCaWUXJLOa0PjG54ecsUyjvubb+eMzozi1t2k3caHJ7jquk4zKsrL/DDfMgAAw4hBHzSWwx2d0TG9dziDpmUAhBwAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7138
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 22 Jul 2025 14:07:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1822

Hi Trevor,

On 7/22/25 3:58 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> According to [1], upstream meson's default configuration policy defaulted
> to "auto", meaning that it would search as far and wide as it could
> to find things like libraries and header files when deciding which
> options to enable during configuration. Apparently that is no longer the
> case, therefore new PACKAGECONFIG options have been added to systemd to
> explicitly ask for some features.
> 
> systemd's repart mechanism needs fdisk, which was probably being found and
> used implicitly before, but now needs to be enabled explicitly.
> 
> [1] oe-core: 4ec67113e1e7 ("systemd: add libblkid and libfdisk PACKAGECONFIG options")
> 

This is being reverted right now as far as I could tell, see 
https://lore.kernel.org/openembedded-core/20250722124120.3281157-1-ross.burton@arm.com/T/#u

So maybe wait a bit for things to stabilize?

Adding Ross and Hiago in Cc

Cheers,
Quentin

