Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F404CF9C6F
	for <webhook@archiver.kernel.org>; Mon, 23 Sep 2024 11:00:03 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.69])
 by mx.groups.io with SMTP id smtpd.web11.33934.1727089198675205359
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 23 Sep 2024 03:59:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=HJYeROn5;
 spf=pass (domain: cherry.de, ip: 52.101.70.69, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pmr1iyb8MDKfSbfWp6+pnaMoj+l3CsxX9vnqKf7EnsBh5UKau5E/uCy/Gs4ZoaEOWbPEI7hKK/klBhU0zwfB3r24qHmGq09cPQQt2Up0mkZR2NJtLSGGUIb+UptQCtpLVvWKLB027x/1auxPTrCCaPeuIselEi5XC7vZR2JrhfyNlitJgpn5kovBfYxaptiijzdd9fKVQ/Fjajyj8Sf/+3Qy1DsaTZhnywZA0LYMSojg0upPRctKbZ4Xg3YQIXiNhq3S1n9byISLkg6BqPo2DTs5YlrIKyLx+4f799tptOD/wxxr3+n1qwlu2sPbja5eqputvNNtYrjPLwOZwxWReg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zj8fq9QLYaxPHapDEp8CvLh7byiJN4OK9YqbIaHlkGc=;
 b=QUIh6uVI43cI+K379rXHTYHwuCp+ucSEFpNvETMf4g3eIwtnqyTSO31qkynIcsxA8V55IDVsVuOWzVTJM+JXUj/5ueuYj9KWFvSXhoRCaXT7e0fSEZqCRd7R9JcGQuzeGrZN1VS28FSdhfBQ4FICZu+6X3TX90kONYbYOR8HAuJKC5KK4x6NJdAT7b45SK1aH2kWgY/dSFBh5O+mV+2EbE6/ix5QbbpXe3fw1tWqkeH8MQyFsQcB6OmAnUhMXpOLAej/v9WA1qMdx3pLuf9T07PD/AV4GpoUcMJE70K/IBJNeXEHQ335E52Dw/ifYWEaU/quDms5PJBX2KFBnEohwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zj8fq9QLYaxPHapDEp8CvLh7byiJN4OK9YqbIaHlkGc=;
 b=HJYeROn50W03hOMcmvPJefawiBe8qcr9S/UUZbk0yWQhcMJ53zwL68t7Wj+DQzN/XcObuzknX3qkdRFKs3GDv2sJzeNsc3C2aK3Yd0bA/LQNtGDEnr9NuyqgEzQwf8nurTch7k7b+4MDs8gsi80qMv6PCUE1yxg/Y6LBluX29Yo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by AS8PR04MB8262.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 10:59:45 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%2]) with mapi id 15.20.7918.024; Mon, 23 Sep 2024
 10:59:45 +0000
Message-ID: <540983cd-4655-4248-a3a9-7bfffe1b011a@cherry.de>
Date: Mon, 23 Sep 2024 12:59:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] abd-partition: add runtime
 dependency
To: yocto-patches@lists.yoctoproject.org
References: <17F66BD6D408F640.22254@lists.yoctoproject.org>
 <20240921121639.GA23774@localhost>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240921121639.GA23774@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0018.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::25) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|AS8PR04MB8262:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d8bb17-5c3c-4b4d-41c7-08dcdbbed5bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aitQRXh1aElrMTkrcko3UzVWTXVPZVJSMjFrQ0RvbXJsU00vQWRFTTdDd2lD?=
 =?utf-8?B?SXY1elZnQVpYbmp0bTJYdlphNmlnY3NPOWhYeVdmUHhzcFJLd1NPNzFuK1la?=
 =?utf-8?B?eXFpSjF4bGRjTEl0ZjlGemVaVEZMWnc2bWJxNTJwVkdBVDBRY2VJaXBvMjRD?=
 =?utf-8?B?ZEJlZXFCMzlPNmZtQ0NPQnZOaFdGNDFTK3pJMm94ZjJrSllWN1pLOFJWbXdN?=
 =?utf-8?B?U00zVE05YklML0Q2SVRWK0JaSjNiUit0M0N1RkZmY3lKeXZucUREVEo4UEVs?=
 =?utf-8?B?bjlwR2dTYTBTaGl1ZFhkb0lZVkF4YmgwRlFoTjFlNGF1eEVCVWErd0l1dEtk?=
 =?utf-8?B?RGtNdzZUWjRycC95L1BpWmNLLyt2WDQrYW9hTGtjQm9wVWFvTS8yU1lWN0dn?=
 =?utf-8?B?MnJSdzJIeElQOG9COUhleE83TXNhZWlVMkdEemRBZGl5NTV1MUxVTWF0RjRn?=
 =?utf-8?B?bFZhWExqS2FFa0c3dE1nSkI2K1NxZ1g0a0xCZGwwa0crcU9zSmFuWC9mYi8z?=
 =?utf-8?B?SXJnYW8rWGJBQjd6N0U2SHV1TisvMTJuKzJxa00wTmJBZEJnb2dPR0xQcVVw?=
 =?utf-8?B?dU5qekJXN1BKN2l1akZHcHlVbDNkamk2bmhGNW1oazFNNXBmNUNkS1ovTm9y?=
 =?utf-8?B?NGJEd3BMTnN5cGxqZnRBYXFKejRUTlNRN2ZjdVRYb1ZPTm5ZTWQ3YlFWaDVz?=
 =?utf-8?B?alFrV3RBaCtWUHJvWkdZNnprcG9xcnBEWGRxSFp5WkhlK3BDTmI5M1Z5N0p4?=
 =?utf-8?B?a3ZBeHhFaHRlakJHTjR6Vy8zYlU4SitvdlJ4WC82MlVWc0VEWlBPaFNPQ1Vx?=
 =?utf-8?B?Q1poQUhRZjJFTGlHTTgvSHJnVlpyZUEzNUFQQjBSaHlBSFc1N3VQdXREZGkr?=
 =?utf-8?B?T1pCTHQxL0Urc1JqMko5TGF2dVdmSTBrRXJDR2srRzVHcDFsZk83RE5YQmNx?=
 =?utf-8?B?QjIxTnVyZzZ1TlcyaUxSalBydXE4S2hwOHE4bmJLdFRydjYzN2ZEY3pwVllC?=
 =?utf-8?B?NWl0eHhqZm52MzNzZjdKcnNRa0hFWThDWDVxd2N5VFFWakRuNmh5TnlUUk1T?=
 =?utf-8?B?cXEzK2xDUjZ2TG5Cbjc1aW1mLzhHRklsWlhpZmEvYzFvMkMxMkFSbmszNHl2?=
 =?utf-8?B?OTRWWDdQUExvNCtZQkFSZXBOTWlRZXUyVlM3aGNnOWx5OTVGd0xOZHVLODI2?=
 =?utf-8?B?ZWVnMTYxT2NydFVWMk1yRllDM1NFOU9KSU9ZaS9vVTZwcE1maFp3NXlGbm1l?=
 =?utf-8?B?T1FuaFlYa1JFck5idEFBWTRia3llWkZHRUtRMi9NT3NXY3BPMVE1UVdoMGlC?=
 =?utf-8?B?OE9FK1lRelB1YVNqZ01ZaTlKVXhpSFBITTlNOW1TRkhXaDJVOEZVUkx6NzBQ?=
 =?utf-8?B?Z05VSndoUmlzWE1RS09RTWh2V1BQWDhNYWh0YWFWUEdTMFpSck84Vk9EbHBy?=
 =?utf-8?B?dGhPY1BuSVVIRUtjUmp4R3lmdTVUODRiNTBrMEttaHJwVXNpYWhENlFuOVV0?=
 =?utf-8?B?TWMzQWpPWkw3QVRPY0VhdkxiQTdYZnFuWGhkT2xFR1ZyTXYwTFhLZ1VpVys2?=
 =?utf-8?B?MDltZk04dUdTZi9uU3ZnTmQ1OXIvM3NWellOZ21IU0NWeVpPWkJTdjlXZUhH?=
 =?utf-8?B?TEFxOG02UEdubk9MZXh6S0trZkk2QVk2YUl4ODBTZjN6QmNwYi9JRjd3eWdr?=
 =?utf-8?B?UGp4bmlVWE8zRUg0YVlRMUtlT2NQdVZ2cElHTHFScWhIRFRINDRXUmZ3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8906.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eHpmcU1RUVpJOG9kZ0ZveG9HVlc0ZkVycmpkU3lQYVVUazBRYWNHQjBXMVMv?=
 =?utf-8?B?UFJKbldnc25TRVJacXBGQlMxUDNpRXlzU0F0bjVOemVDNU5FWUNGNG1LMjFV?=
 =?utf-8?B?MjJqdW13d1U5K0dTSnBudGNBQmZXaDlVTGVTd2xidWVxTTlTbnh5UUJNSmdC?=
 =?utf-8?B?UGh2OWxQZHFFVmlvYmZ6QmpZZVEzN3BZV3QyK2FHMjFHRndwTjhaWU5kTTNk?=
 =?utf-8?B?bGE5MzJaSFJ2M2JPYjdMV3g2VmtiNGFPa1h3V0t5U1lWcUUxb1N3V3djdlh2?=
 =?utf-8?B?YytJK3M4SXFHL1pFc2JNZ0tyd0lkcFo2M084dVUrRlRVRUVJUUY1QmxEL0JK?=
 =?utf-8?B?RklpcE5PYng4c3NaMFlKNFlzYlIwZnFabUZmMHJkZjNEM3VIR01XcVRONWNO?=
 =?utf-8?B?dU1MRittaVFtb1dVRFBRc0VWb1RyZWw4SlVUS2pYdzBNV1dLNk5rdXZKYXFF?=
 =?utf-8?B?dERha2JFeEJ4Wjk4WDZGZ2c3WWg0eTZ3cWtZZTRZanI4amp3eVJrbHRiWU1i?=
 =?utf-8?B?dUp5MFo3dWpULzVqR2NuVEQ2bkVqYW82NUwxS1ZTcnh5dDk5OW1CMWtNd3Fv?=
 =?utf-8?B?aHVGL3JscjlZRk9MUXlZc0wydzBISTIxRDVHcitZdHUyU3RzcEVCZzZsYWlm?=
 =?utf-8?B?bVVWalRNWWVIUDBJYVJQVUdNelhYM0dmUm5QbFhTQ3NtVU0vVDdrWTdlSGQy?=
 =?utf-8?B?TGsrcXBuSEZpSW56ajY5UGJpb1JJTldwMWlvdHhNdHFoNHIwM0RnUEJOVklZ?=
 =?utf-8?B?RHJJOTR5aG5hNGJmUzRkQ0REY0Yyd1MwZWkyNVk2Ym0zU3RYTDM1UG5CbW1Z?=
 =?utf-8?B?cW53UFoyMTVnOUozQ2hMc240TFN4N09XOW5BcGVRTThZSDVoWG0zS2U0TThk?=
 =?utf-8?B?OXhQMVpFM1pLdGRPNmxoL2JKb1h3SzdQVjhtOXdkRTRwd2FJWVk3MTVRZU01?=
 =?utf-8?B?YTNlSGtPdmNQK21wVjQ0QWduQlN2eEtiRVhGOUxJRE1OUHQ2Z2VESEo4d24y?=
 =?utf-8?B?Vk9aUXVZaGU3QXpOREVXV1hYOXIwSzgvMEplMGlGVDVlYzVzQmt2bDlZdkR4?=
 =?utf-8?B?N1BUdWh2SU5aRkI2TEFJcnNiOU0yT3VZRnc3WkR4c0t5TFd6dXV3RXVsTDc1?=
 =?utf-8?B?WTJoZmVBTDBubUplN01iVzFQNHFJL1k1aGZQKzdQNFAxMWQzQ3ZxOVpObjcy?=
 =?utf-8?B?UDVvR2NkZWQwNThxMjBrdzJYbzJTRjFjSkpXaHdvbnRsV1p0ZDhFTGxuYzd2?=
 =?utf-8?B?RERabFp0K0piNVFmRG5tVnM1M0ZHQWpKZnNqMTZ3UHFqcWdHbm4xbVVhRURX?=
 =?utf-8?B?UDkrZzlSNitZdkRScjEvNlJSSmtQVnpDZUpWcG9qcGtxVDVHblVtbDFKcHVm?=
 =?utf-8?B?L0JoZFZYNFU4MFBoc2Nsd09RcGxyL1lIUlJGVHI4RWJ1dWVyS2tPNGFVejRl?=
 =?utf-8?B?UUhHNk05aTlqazdCdWgvZ3lsWUZkRzdDMC9IeU9qL0R5MDRYcXlqL3hxd09B?=
 =?utf-8?B?WjlVQlFhM0srUzBBY2trMkt2U0xGOVdhaEJUcWJSS1gzaHlGR0dlcDlQd1pN?=
 =?utf-8?B?aTZLZGN2ckRvck1Zb1A2bEFZRXJHQnQ0amp2RXpyemg3Tkx6TGNEbytjREVN?=
 =?utf-8?B?NHBLWUZZSkVIb3NIM2htN1FZQ0FIWW4wRHcwcENmUWJZaWlDa3l3eTFYcTlC?=
 =?utf-8?B?eWtVamNyZHhpdXdCeFJOdFg2eHBoakI0QVdzZmtmbDNLUVYybjFwUExGblhS?=
 =?utf-8?B?ZUJhakxZYm1NalE4aHVJemYvNXF3aUU5MzVIcklTakF5UDJiMXIyMUdtMjUv?=
 =?utf-8?B?R0s4OGFoeVRqQzRkSTVqWTVNekhVV2hrNjlJVW1Wa0p2OVdCcDZnTS91ZE03?=
 =?utf-8?B?dnVLenFuUmp4eDAyMUhmTUg1WXA1L2I1eFlsb1N2b0kxQTVmRldzZTdCcUhZ?=
 =?utf-8?B?SjRUb0dkRkc3VjNLZHhGaW9LWTIyMTFSM3BzV2ljaXlSWGpuSUFyVDlkTEpx?=
 =?utf-8?B?dnRERWdteC9tWmVEMk82Tk5TSWIxZmsrR1Mxbmh6NXM3cG5OTUZVTk9OL3Zq?=
 =?utf-8?B?dE9sSEthdW02TGgzZmhBdTZxV3FTUi9XZFdmTXl4QVZIZkRHZkhYREZPREJU?=
 =?utf-8?B?VThFcGxNU29HeW04L0grZm9lTUhoYU54eUdLSUQrTHRiR3YwSXdJdDhaTXFI?=
 =?utf-8?B?N2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d8bb17-5c3c-4b4d-41c7-08dcdbbed5bf
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 10:59:45.7617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ljna0G0+A/0Nn1O8f6dx/SMQTHc+xcK4Xo+AGzFPqiAgeitTzpejAXvibSTwBEtkd/yD5PDA3uZc/hsZhgD8UdrFSdXvN4UhdVs21WXADVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8262
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 23 Sep 2024 11:00:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/663

Hi Trevor,

On 9/21/24 2:16 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> On Wed 2024-09-18 @ 03:01:06 PM, Trevor Woerner via lists.yoctoproject.org wrote:
>> The rauc demo implementation provided by this layer uses ext4-formatted
>> partitions. Therefore the tool required to format ext4 partitions is required
>> otherwise the repartitioning will fail.
>>

I assume this applies also to the Scarthgap branch?

Cheers,
Quentin

