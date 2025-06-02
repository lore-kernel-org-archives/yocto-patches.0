Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADDAC5AD49
	for <webhook@archiver.kernel.org>; Mon,  2 Jun 2025 12:40:06 +0000 (UTC)
Received: from AS8PR03CU001.outbound.protection.outlook.com (AS8PR03CU001.outbound.protection.outlook.com [52.101.71.57])
 by mx.groups.io with SMTP id smtpd.web11.48745.1748868003082348194
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 02 Jun 2025 05:40:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=PkkLf3Mt;
 spf=pass (domain: cherry.de, ip: 52.101.71.57, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzr43eWR8Db3s+dlLFidhHd2KPM6Cv36UR+6BOrIMmAvmvSIfJMJiUsB5wAD4XIwyzV4TdxOw90KjpqjInE//38Nea2QAv6o8SfCbBkZu5AqjsFR9WJGZpFQZ2aKDTExfTOnzh5SLrYxr58l+8fQHWwJ2oMxbb6+tL7YyG5DMh0H3miyPhp2DxUvMW0vohnRtC55PTXd/S+UKXr91gRMM89iusjHh5ZcHhm6EqQ2rSh5F9EDWKG8N8bgz9XWjDcAwfTwo5+kYkCK2khJE/9J9nHM4IbGCnu0+vkgn7jj4cnlJdHNPRKalN8jDM1YMwJPCW1+PB5lEzkha6+pdNPQSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mo4F9ScuUorqA4Oj/l/cEEtK/yGQS02Qp4+5/FPklgk=;
 b=BemUalTH8Hdpz7J38BY4XMOOEY30IdlBA4VCZVRWro9/dTmxD8Ig+okwE/lA8XhfuYzjcKBcPh+P6h3YrWKPukbamChpJwhGbZ2AShwUKYRBdRozZwWdK5rbTRqCC0OxkMFghA0tqhAo8jmFJeUmVc47BkrWKla6IpX5VndmQjKuVHHkVraHyK1V3yNI4IVnxaOMnkUx54MO11/cnjmPhiixpzMlSRa4jZGcNfu8W804/670bicuq0wK8dpVVcfmH1wP2m5f5Xdxe58s9AlvT+9t7vQsG7nUghOp9ckzdxvCUP+KHni17HtWcr9/AB6mtDcNLhLg6BuaWm33frvZXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mo4F9ScuUorqA4Oj/l/cEEtK/yGQS02Qp4+5/FPklgk=;
 b=PkkLf3MtJwyTTxcs8/gsYdGXGJ00Q8hYXSDSPUbR/RDhh4TDL3aE9rvICKxsWpVT7hUoCssJ90QKMgXLrfZ53pLtZZtCychXUisTmZ1eejIa7dqOBi/O5vesJzuVw6fJDP7VG+myBjnCehVgH2xssCKXt/2TyusYefeVSCXe6gA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB8947.eurprd04.prod.outlook.com (2603:10a6:20b:42e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Mon, 2 Jun
 2025 12:39:59 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8769.037; Mon, 2 Jun 2025
 12:39:59 +0000
Message-ID: <2c631d6e-9296-4c4e-bcf8-13add7ee8ddf@cherry.de>
Date: Mon, 2 Jun 2025 14:39:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH 1/3] refactor mesa packageconfig
To: yocto-patches@lists.yoctoproject.org
References: <20250530172156.7199-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250530172156.7199-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0054.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fc::6) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB8947:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bd73b98-0c19-4dea-0eb7-08dda1d29627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?em1aY0dhQ3NJSXdlL0JaMkFjSWtxM2ppWVQrdGNoKzg2d00vRFptN0NSaytZ?=
 =?utf-8?B?YUhIQWhCdE01K25Fb2U4cjY0KzlGNUZyOXd4a05LTXpTNFhYTjdJdDZGcjhi?=
 =?utf-8?B?a1hTOHFaa2FBemx2SjN5Rmw1anZyOGhLaHMyVjFHYjRKUlhTVHEwd1BlOXFh?=
 =?utf-8?B?RzZTcmI0dXh0RzVDR0xnUU92WlM3NVBldU5YSnZ1Z3RMTHV2Z1kwb2l1SU5m?=
 =?utf-8?B?VW4wTUUvdGt2N0lzandlTkZBaytzV3hONklIZVhLazBBNkYwTzhkVkt1YmlV?=
 =?utf-8?B?RVVVK0gxRSt3U2x0MGN5TzJRbVhkQ3FzSStacVN2RldOV1ZFd01YUldGQWRW?=
 =?utf-8?B?TmY4SUhaWmFCT0NYQ0ErS2VNZVF2bU1ZQlRuSnhYMkVWd21RZHhYT3NKbTQv?=
 =?utf-8?B?V2xsd05lck44d25SaXNFaEJrd2pKTlZ4UVZROTN6dXBnc2M1dGZLTGRZcEV1?=
 =?utf-8?B?cE0rLys4RGZ5SDVpbGt0elh3Y2VQZTlWY2hGNHRaUFlmZkt4ZFhSSFJRSVBT?=
 =?utf-8?B?VitSTHBzRWxXNEx4cTJSYUtOcG9YSzJQb0Fzb3lqbml1cnpJKzlTVkVDQzA0?=
 =?utf-8?B?YjFRTWNmNFN3ekxsS2hKMHRndEFsMHF6KytSeXRoblpSNUo4djIwQXdyMllV?=
 =?utf-8?B?VkFpSjlsakx5TFA0WHdTRmo2d0FSVjZQZC9VSUo5TDlubCt2aGR4OHRjSGlR?=
 =?utf-8?B?eVg0Ti8xZGREMzBjeTR3dHBKRDBtMFdERkVBdE9SdmhiL0RuS1JpQmJVbGpw?=
 =?utf-8?B?UDQ2WTRPa1k3Mm9MQnBQWkMwb05EOHhxZEwxdG5ydyt4cHNJM3ZNZDMxMldL?=
 =?utf-8?B?anFFQ0J5RUtySXg4a0djVis3SW8zWmwvOVVwRzRzTm1MRk1TMVVXbjhOczNl?=
 =?utf-8?B?cXpIYmdCMFFKU3RWWTNLNmVIdTFYK29kME1hMUJQSmxIRTZNb1BSN29wMENu?=
 =?utf-8?B?SHNDLzVIa2VlKy80bzF1eXRUYWJBT0ZhK2EycGFMU2hMYmtDdFM4OXIwa0N0?=
 =?utf-8?B?K1RiR3NlSzRDM0pIdTlROHhpZnNBNWZMM3hGT0NmVEo2dUZRUjJrd0VtY2ow?=
 =?utf-8?B?QWJhUWpYSjduZHJqVktDWWxGenR2S0x1ZjhKdFo4dHg0akJhOU1OOHgra2ZR?=
 =?utf-8?B?bFplZ2hmV0N6cFFHME9FQkJLcVBwTWdWN2l4L01sZkFjQVFlZGRYYkxrbmpk?=
 =?utf-8?B?UTB2VEdiYzBLVGdFaFB1OFFXdnV2cFMrNUlqRjhPMnRnR21rSUFTL1FkMXUx?=
 =?utf-8?B?Q3J3UGxIaWRFczRZSTlla1NwclNDcXg2M0QwNS92dXZzNWFDVlNjc3RBdVdV?=
 =?utf-8?B?UzYxYk4vekJFNnRXR2ZiR2RJUVZVeGFXQ3FxRkhLQzRCcUhjOGl6TEhSMTBn?=
 =?utf-8?B?TjJoV0Iwb2dSUmNDK3l4dzh3RVZDYTl2Qkd5QmV0Sk51cTVySWJPQXEzSVE3?=
 =?utf-8?B?cGJUc3k1c1hsT2FJNzI2NlorYThCS0gvWHhYQml6eThSQUpDNFNKOVd3b0cw?=
 =?utf-8?B?a2tKU2xvR3dNR2YwNHZsUU1lcGxqb1VSUGlFWThRY2tUM2s4ejkxbjY2WTJy?=
 =?utf-8?B?L0lEeksxMWxKalBHN2Z6TkMzZ2lTM1RQcHJpUzRGbnYydUovZ1V5a2pLaDZY?=
 =?utf-8?B?Q01UWmZFdThQaWVPQUQ4U2FHRmxmQ1hscEx2UkpuU1Yrd2RYek9zUEZJejNk?=
 =?utf-8?B?cTdDOE5OQ1N1U1p1dDM2ZE14cWFaRXpQMlJ5cllsV0M4aXQ0TGFHUVFFOHNr?=
 =?utf-8?B?empEdW1IT0ZWeHJFcHlzTUluVTN2aXBNdnlXcm1LaHFOTHAxWXNMN0x1WnQ5?=
 =?utf-8?B?T0RZbGZxS0FIaExtODdmOSt1TzNlMmZSSGh1TWVpQWNNQU5zN3pySDRDREZt?=
 =?utf-8?B?UGdnb0RlRmpjZXloUm9nNmsrYXlha3NlZXFXMXhDQ2ZQanByQlprVzFZYXBz?=
 =?utf-8?Q?old2n2sAiMY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TlBTYUUzQUVFUkZ4SXZkUCtuZzhFL2VoV0hKTGhlWHNpWGR0bVFSVUhQTC9u?=
 =?utf-8?B?WThqeGN4ZEVPSUhkazlBcFpTVVNJZ3N0dkFOOTRMOXMxTm9ZbTdELzBtUTVO?=
 =?utf-8?B?SGxJWVRlNXhnckw3Z3BJRllwVUJZcC9KRDluWHJZOUY5eGw1OEFkcXZ0ZWRj?=
 =?utf-8?B?NFNucjdJRUpXaERoQ01VaHY3NHphd2dOOU43eUpndy9Zd205cE9oMTNOOS9G?=
 =?utf-8?B?VHBDSDhpeHFwem1FL2tOczYzNXFCK3BscTRPZ0tVOWtnNDdBb2lSS292dUFZ?=
 =?utf-8?B?UW4vQ1Z2TU8wYzRXOXVEbjA3cG0xN3ZiUVlZdWhoRkMyQUxDQ2lWK2dJSjdq?=
 =?utf-8?B?dVlFOWVzWmMwZXMxTVhmUjdoWjN4ck45SDJkVUFkZmNvNlNYc0MyUy9OSG14?=
 =?utf-8?B?cW4yTUVtcTlMWGVjVzdRRExmbUtMMnZjbXlXMDRNSmp3VmtNczBCam1PMVdC?=
 =?utf-8?B?U0J4V1MyaHlHNU5pZ3JVY01mT3Nta0x5YUt4YmxUZCt5bVVyMkNJVTNxKzJo?=
 =?utf-8?B?TVBjam1qcDFhbmJ2NlM0VktyL2xFRTUrUnc4Rlo4T0MrYlQwUVp4RU1oNnpX?=
 =?utf-8?B?NUJ0TFYxTDVrY1M5a2d4NkxHRWdpUlA4bDk2NlhPZHBRL3Y5cHZhcCtkOVk2?=
 =?utf-8?B?RldPR0VvZ3QyR3I4QWFZdVpVdnRSa21aL0hJVjNqaGQwSXZ4T2pOQUxHU01O?=
 =?utf-8?B?cnZNbnFqVVByeVNFY21ubWwrcW5Ldkt1dmlRL05JQVc4MEwrVkdwWkNDVnJG?=
 =?utf-8?B?aE81VkFvVS9TWDhESHovTHF6QXNLdTFmWHoxQ3lwSG14NFNrMnF3NEhINmE1?=
 =?utf-8?B?U05OSjd5VE9hUDh0Z1JpNjhMRktHNERTbVV5YkxTRlNXdHdRbURJbEt4dWpx?=
 =?utf-8?B?WURMeVRUWGV1SFc0UzA3SDFXRUlIUGRKa1IxUFBpVGZFNzBCSEQwTnhCaGFK?=
 =?utf-8?B?K1UzenJ2Z1ZtcHNubWw5SEVaZG9MR0NWeXVzaFhHMDBQWTRCWXNycnlzY1ps?=
 =?utf-8?B?NzZFUUp2bTcwaUlEc2lPekhOQzdoYWdMSUxBbGt0YmxMNklqNEY0Z0tib2tU?=
 =?utf-8?B?cEQyT2FYKzhKMnBIM01HK2s1eHZ4Zm9xWEFIWXF3bW9jUmczd0ZDTmk5QlIx?=
 =?utf-8?B?TWRxK1B0QnFDQTJVbTUvZkxUWDZ1Mk0zUFhuUm5WaTAwRnV1bERFZFlsMXVJ?=
 =?utf-8?B?ZWdVK0tadDIrWW9KL3ZPcXl0U2VxMFZ2b0xZb3VsdExKSmVJZy91QXFrMGxx?=
 =?utf-8?B?ZzlpYW53ZzQ0NWtCVDF0Zndld3hDUUpxc0g4Z1YvY3Rwdk4wM3NYcUorUC9n?=
 =?utf-8?B?TEJDdmdEV2lMUmdpbzlRTzBjdmNHalUvNFM5Y3lQcmdxZDV5SjFXT3ZSQTF0?=
 =?utf-8?B?WFpyMEdkK3lhRnZuYkVYVVA0ekVQcXR4aUZJa2tzOTlIOTZhMUd5OHhUZHV1?=
 =?utf-8?B?bjNveEZzZ3pQWDBBcE0vWTJMb1VxWmVZc1hBcHdhTjFjZDNXRE5vOVM3NjJx?=
 =?utf-8?B?cnphV3FENmQ0QlpJdUt1RTc2L2tJVk8reEdPM3NkdnliTFRvN0Z3Mzl1V3dY?=
 =?utf-8?B?YXdvR2txTkZ1QTNLcDFUbmw4U0lZL1RYT0pkVXdyRGVlQTJUc3JsUHRpUWJK?=
 =?utf-8?B?K2JNNVdCYWVLRGQxYm5DanlQcjZaQmYyK25YS1lJRGo2Y080VFB2TDFrVXpN?=
 =?utf-8?B?cWFVWnFZMm1md2M3MVlQb2hmZFZTQlppNGk0aFo3K1pmZktWK1h0QTRNKzU0?=
 =?utf-8?B?anRQT1hwbEpEd1pvOUFWVTVUcXFtYnBpMXVndi9aNyttRCtZN3NMMTFZY3Z3?=
 =?utf-8?B?NWZSTGVYMlp6QWFhTlcrOG5nN0lxZUQyVE9EakJqWGZRN2ZLbDhYYVRSSzV2?=
 =?utf-8?B?K3JRQkFnUjI2Nkt0RjRscUxWeXFnVVJnL0FwOTVnSWNGTGUzNkhQQ3BIY3U5?=
 =?utf-8?B?bVRqQzVLbkFYNXcxSXdzdzNZdjQ1ZmN0L1pBaE9ESU42TVYrSkxsMHJ5L21J?=
 =?utf-8?B?NDhtK1RXeUVSQ0RFOEdna0VyTWFVVzhFR1pMUWd4dzJENG5kZlFiVFo2QkZG?=
 =?utf-8?B?N0g4V2hnNm9xenoycE8xZGxzbkxlYU1lbTkrcjJyTWliZ2FDVUdOU3BodEVS?=
 =?utf-8?B?SHY1Sk5pMyswejZrQzlnU000eEFWQXVDQ3BoK2hCYU9obVRobWErVGFyN0lB?=
 =?utf-8?B?VHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd73b98-0c19-4dea-0eb7-08dda1d29627
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 12:39:59.1952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v8einBnwmiU8b2hzAtyMpC0b1b9YQZ1T4ZWxQnOmwuWhpELjr8/syd2PKBmfPqU91xEuRsA+6Zk4Csniu9jD17PV5IrcgIfJeQ0oQe60U7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8947
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 02 Jun 2025 12:40:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1609

Hi Trevor,


Missing [meta-rockchip] in the subject :)

On 5/30/25 7:21 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> Add a new variable, RK_MESA_DRIVER, to allow the user to choose which mesa
> "driver" they want to use for their mesa backend. By default set it to either
> "panfrost" or "lima" depending on the SoC family being used.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>   README                              | 5 +++++
>   conf/machine/include/px30.inc       | 1 +
>   conf/machine/include/rk3288.inc     | 1 +
>   conf/machine/include/rk3328.inc     | 1 +
>   conf/machine/include/rk3399.inc     | 1 +
>   conf/machine/include/rk3566.inc     | 1 +
>   conf/machine/include/rk3568.inc     | 1 +
>   conf/machine/include/rk3588s.inc    | 1 +
>   recipes-graphics/mesa/mesa.bbappend | 9 ++-------
>   9 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/README b/README
> index 9672c6ab8d5b..97d06eaefd63 100644
> --- a/README
> +++ b/README
> @@ -159,6 +159,11 @@ Notes:
>   	compatible (see Rockchip Media Process Platform (MPP) and
>   	downstream gstreamer-rockchip plugin for those kernels).
>   
> +  mesa backend
> +	Use the variable RK_MESA_DRIVER to select which mesa backend to use
> +	for mesa. By default it is set to either "panfrost" or "lima"
> +	depending on SoC.
> +
>   U-Boot Environment:
>   ------------------
>   	In order to configure U-Boot to be able to store its environment into the
> diff --git a/conf/machine/include/px30.inc b/conf/machine/include/px30.inc
> index 8173cb19be2c..4918ee45d1ab 100644
> --- a/conf/machine/include/px30.inc
> +++ b/conf/machine/include/px30.inc
> @@ -21,3 +21,4 @@ UBOOT_SUFFIX ?= "itb"
>   UBOOT_ENTRYPOINT ?= "0x06000000"
>   
>   ENABLE_STATELESS_VPU_GST ?= "1"
> +RK_MESA_DRIVER ?= "panfrost"
> diff --git a/conf/machine/include/rk3288.inc b/conf/machine/include/rk3288.inc
> index 06fda69a3eb7..0fccae7896aa 100644
> --- a/conf/machine/include/rk3288.inc
> +++ b/conf/machine/include/rk3288.inc
> @@ -16,3 +16,4 @@ KERNEL_IMAGETYPE ?= "zImage"
>   UBOOT_SUFFIX ?= "bin"
>   
>   ENABLE_STATELESS_VPU_GST ?= "1"
> +RK_MESA_DRIVER ?= "panfrost"
> diff --git a/conf/machine/include/rk3328.inc b/conf/machine/include/rk3328.inc
> index e6f810dcd2ca..cdc2e2df2703 100644
> --- a/conf/machine/include/rk3328.inc
> +++ b/conf/machine/include/rk3328.inc
> @@ -22,3 +22,4 @@ UBOOT_SUFFIX ?= "itb"
>   UBOOT_ENTRYPOINT ?= "0x06000000"
>   
>   ENABLE_STATELESS_VPU_GST ?= "1"
> +RK_MESA_DRIVER ?= "lima"
> diff --git a/conf/machine/include/rk3399.inc b/conf/machine/include/rk3399.inc
> index cd1be49064ed..06326946f1e3 100644
> --- a/conf/machine/include/rk3399.inc
> +++ b/conf/machine/include/rk3399.inc
> @@ -22,3 +22,4 @@ UBOOT_SUFFIX ?= "itb"
>   UBOOT_ENTRYPOINT ?= "0x06000000"
>   
>   ENABLE_STATELESS_VPU_GST ?= "1"
> +RK_MESA_DRIVER ?= "panfrost"
> diff --git a/conf/machine/include/rk3566.inc b/conf/machine/include/rk3566.inc
> index 6386ec7eb51c..4d84bf8a11a2 100644
> --- a/conf/machine/include/rk3566.inc
> +++ b/conf/machine/include/rk3566.inc
> @@ -24,3 +24,4 @@ TFA_PLATFORM = "rk3568"
>   TFA_BUILD_TARGET = "bl31"
>   
>   ENABLE_STATELESS_VPU_GST ?= "1"
> +RK_MESA_DRIVER ?= "panfrost"
> diff --git a/conf/machine/include/rk3568.inc b/conf/machine/include/rk3568.inc
> index bcf9dd8b0f44..dedda3b8f47e 100644
> --- a/conf/machine/include/rk3568.inc
> +++ b/conf/machine/include/rk3568.inc
> @@ -24,3 +24,4 @@ TFA_PLATFORM = "rk3568"
>   TFA_BUILD_TARGET = "bl31"
>   
>   ENABLE_STATELESS_VPU_GST ?= "1"
> +RK_MESA_DRIVER ?= "panfrost"
> diff --git a/conf/machine/include/rk3588s.inc b/conf/machine/include/rk3588s.inc
> index 6ec344abae5b..5a085ab29ebc 100644
> --- a/conf/machine/include/rk3588s.inc
> +++ b/conf/machine/include/rk3588s.inc
> @@ -23,3 +23,4 @@ TFA_PLATFORM = "rk3588"
>   TFA_BUILD_TARGET = "bl31"
>   
>   ENABLE_STATELESS_VPU_GST ?= "1"
> +RK_MESA_DRIVER ?= "panfrost"
> diff --git a/recipes-graphics/mesa/mesa.bbappend b/recipes-graphics/mesa/mesa.bbappend
> index f22280754a14..9e9bf9afc4a0 100644
> --- a/recipes-graphics/mesa/mesa.bbappend
> +++ b/recipes-graphics/mesa/mesa.bbappend
> @@ -1,9 +1,4 @@
> -PACKAGECONFIG:append:rk3288 = " panfrost"
> -PACKAGECONFIG:append:rk3328 = " lima"
> -PACKAGECONFIG:append:rk3399 = " panfrost"
> -PACKAGECONFIG:append:rk3566 = " panfrost"
> -PACKAGECONFIG:append:rk3568 = " panfrost"
> -PACKAGECONFIG:append:rk3588s = " panfrost"

It seems like this is based on my Panthor patch series but it isn't 
explicitly listed in the dependency of this patch series? I'm fine if 
you want to take over my patch series, but I guess it'd make sense to 
have the patches (even reworked/squashed/fixed up) as part of this patch 
series now?

Cheers,
Quentin

