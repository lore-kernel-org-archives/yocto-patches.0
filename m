Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE3EFF8862
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 08:18:25 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.68])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.38364.1777277896589011713
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Apr 2026 01:18:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=EizyBdko;
 spf=pass (domain: cherry.de, ip: 52.101.65.68, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pn8UHk8rPUqptG1ZajJmKJSjfXG+5hfyJ5RZUuMWy5ODoNQeevk3pGThamKoEuuqK5CKTldOXhU8eijLGU4qmcsT9+S9qppg/rUg2ee86TvvotsJEt4Lh024g1Y6ZGH1pSs/urS6v5hCWuR9Bg6T5Cp0GZ1KtsJkh28vEmvILMYHX76RHqEm2WyQO52Aq75Ll1IsvoTtuaPF9AaxtYqsKO1oU3tLenR7gdcDyWmjVvFW1dzrNTbJ5AT3M1E/H39PZEuJ1SPeMMIJJ1UdpvW4QA2ZlK5Hlc7yQrl/g8jP+xtGZRDGtRdF7dTSOR+GueR8csH5o6Auth1duJJqcmgvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaRGHLB6ftAaDNBMmcVfB3ssWqJA2IJlXnzNbDyciTw=;
 b=QJH6j4kcVwU3O+rpVh7LTFYkMi2zqCsiXBzyHCv67eNEqUcyNcbKEjSrCEP1ZKlookKyj7KzkzQk7n1MYFhzxib/7Dfe7pzRLoVG9sCAgtU9050j1sg1f1Y1ODGGRykO4Ym3d2yjBZmuxlTsZoFYUs6KJtFonGdv9QKkLqRV59GIjIQ18v/zv2Z3XK2mU6KQOTXzxLye3vozifMwizIai9yR+EYCO98GystkriEk2105JiEEaQFzXl3CRJbe75N4dhOqzWgbR8k/kddOKzhGCjuz97C0AY4H3i3YwVGiSoLr0o6JTMm5Kjc620sp99IqtR6A3u3Qo+UyzWG9YGBLGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaRGHLB6ftAaDNBMmcVfB3ssWqJA2IJlXnzNbDyciTw=;
 b=EizyBdkoaGNwajwJQTlbqNkEo/X9op0tUfeGGOuPtv1w8EwmIPYm8eiAMqgKvGOfGl1Q+JTGXpe7wOQoglMm1BRKEbvUzy+cUQ+y4OV/uhIY647pyKuCkauwQtrNMHhKKUXzOAEv4QpPT4kenH9NuG4Rp0qRtI7Oyx5zDPUWag8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by OSKPR04MB11320.eurprd04.prod.outlook.com (2603:10a6:e10:9c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 08:18:09 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.20.9846.016; Mon, 27 Apr 2026
 08:18:09 +0000
Message-ID: <3a6e4a35-4a9b-43b5-82f9-1e5d25b015e7@cherry.de>
Date: Mon, 27 Apr 2026 10:18:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-rockchip PATCH v2] add support for upstream
 RKNPU/RKNN/Rocket HW AI accelerator
To: Quentin Schulz <foss+yocto@0leil.net>,
 yocto-patches@lists.yoctoproject.org
References: <20260423-rknn-v2-1-b9457a38c140@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260423-rknn-v2-1-b9457a38c140@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: VI1P190CA0033.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::46) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|OSKPR04MB11320:EE_
X-MS-Office365-Filtering-Correlation-Id: e019e5d4-512c-4a32-dfbe-08dea4358445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	8XXfeqTvhaDH0/tNj6wfwobjman0ruKgBtmbKWY7lS98+rQWW69rwO4n/UbXsm6kaA/O3sgL6gZ5EUsflddaxCs3XzddUr09d+EttnMFpq81wExVZQM4rimE1i5t1RBQSL1KgGhz6iNp+supuDyxyXWWEE503RScbAJv2Inq75BymgQErw+I3luyzhx8Vn1eI3YGpbJ0dITIIUy12C2aV5ehWE+rCqsDqc1YW6kOonEigZRcFWJfVX9GjSjj3px29HMG0Dx9J5g27eaagYjD0wLdVXgkIZ8xK62E+2lKkzhY6vcip6Mnr9uI7p0HLsSrs+gB/ZGDf6qsZL7dLXowmIdD47+F1F685BSu9YI5EKqYa/C6M0lVK4yaeFtl5WbmPURN5A5MlSGvfwBFT7AAsl1XJT8APb31tsuwi6Py0S7DlhBAbYZ+tb875ILZYiLHoKI0uBeEywyXWjLCpR0TDuJGye35l1ndrQ6PMH2IerkeE2tYerhGKVhrGmVS2VT8c+IzozW5TvlBHw6DT/IlU294NomxGeL2unaiKO6YJN4Naws7vXHrsmtH1Gp0RPTmWw49YtmnzHupurGJdcfnGAE6KHcJA1O+wRDxULsHdaouXIIW5mNwgqwfPZZOkgAb3Omz89TwOhiRZC4G6tQGbwwcdDp5HHsaU8Li4itCXMg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7743.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TDhQMDUrN1JMT0sveUt2alhSRnJ4UWYwajVBdEFsekQ2L1AwdlJrQlR0c0lr?=
 =?utf-8?B?RDFvbElIR2JDdFJrYjBBUnJjTGc2cUh6OXg0aWlaclp1aWNzTE5XQWJZbVc1?=
 =?utf-8?B?TXQrU0JoR0Rrb2o5STgxNVlzNXRySUFTclk5ejZBcWNuYzZuUXJZMU9QQzQx?=
 =?utf-8?B?Tk9FY2V2WHA0cWVPcEoyMkdTQnJyenhsMnBaUVkvMEJFaWUwSGRsRjd1R2hi?=
 =?utf-8?B?ekc1ai9pN2E0Nld4dmNVN1NBWWxEOWR5U2FGV3BHTEFvYTVaQTU2dTNESkVZ?=
 =?utf-8?B?R2hWdTIvU1pGZmlRZWU1WmFmR29VQlJVdm1SMjFUb2hNKzVpZFY4WE1zNlht?=
 =?utf-8?B?bThxSFVVOXNCazc2KzgxMFNDT2dqKzdPYTJuNnQwU0xxVzV1TmtvZDVFQjNF?=
 =?utf-8?B?R3NCZXVkZWhOS0dzVkVOS245Ny92cG05V2o0d0M1M0RUNUIzQmh3M3NFbnk3?=
 =?utf-8?B?SFNza2gvL3QyODJTeGtnV1c3NVpCVTZoTjAycGVGazNYeGwvdXNwTWlRS0pC?=
 =?utf-8?B?dXRhQ05SVno5bHFFQndlanIwY05RUEdMUzJlZlduTE9qaG1IdnIwSHpEVHhP?=
 =?utf-8?B?dHVzV2lTUjdNTHJnWjRVNmlnR213Y3ByTi9vZ2xNWnBwWUxPRlQySjVpbmRl?=
 =?utf-8?B?UXpoSUZaRmhJY1ZON3JLQWVXM2VrajdBL05JZ2ZUcm51d3IrbW1NSG14VkhV?=
 =?utf-8?B?MkJMZnZSdTBSNmtjM1l3Z3VEWWFZMGtRY0tXZUNFTTB3ZzYzeFViN0RWR05V?=
 =?utf-8?B?MXZaeVllY0tINGFCdmFLejU5WHhQR0FSYkNpNitmV3lDUWp1c1FycUpXdmoy?=
 =?utf-8?B?RzZrRFlNWXlQVDdDS3VoSU1XZUdQYU5BYitIS055eXdCSkJRSUpsY2grdDBB?=
 =?utf-8?B?ZTA0dm5saUtKK1ViSDZsRE5mZEFBdGEwdXB5RjY1RnIrTFFvd083cWhsbkJN?=
 =?utf-8?B?aDJ3OElWVVQ3RlorRENoSXFCQXovaU9mODBnWDBLUVVzU2RYOXEzN3dIZitY?=
 =?utf-8?B?Sjh5Yk10RWY3K3RqaldTamtyVWt6a2N6eFAzaWUxb1M2ZHhoV3J1SnlLdkpj?=
 =?utf-8?B?MGJ6bkEvdEpxbFVzSWdLTHJGK0ppUGhreFZWQVZzUUVaVjMwOGM2OWk2ZFc1?=
 =?utf-8?B?VDhlRERKYWlzMVJMVjZjV3dlTUUveFVCWithbTN4VjZ3OVhqLzd2SktLOWt3?=
 =?utf-8?B?QW41RUNOMFJjakJPVk9kUVd1bEgvd2dEMnJOUzVPNTBDSmt0SldLYzFJT1FC?=
 =?utf-8?B?Y3c5aU4rRlgxNWdJUkpWckJtS3lmbXFMdWRNT1NDMFRCcVZXQTZJaUlLT0lW?=
 =?utf-8?B?K0pONjR2akRkenFXRDZFYzRjbjVRTkppd2VVb1k1ZTNnUEFJVER0OUF2QjRL?=
 =?utf-8?B?a2Q2QU9zRFpSak9sOVowOVF0cU1yd2dLaitIN1dRWlVDSzBSaUJRemc2L3RT?=
 =?utf-8?B?eVNoQ2xVOGxzZ0puQ0JRalVLY3FMamUzWlE3WHdYSFVWNTJ1R1dQZUxjdVlI?=
 =?utf-8?B?aTlpQVF1UllzL0t2NUVMeHJtS3ZMNWRFRHhYV3VqQjhpdTBvYWFDSVpoS0NE?=
 =?utf-8?B?azBxZjdYNURqT2s1d3V3QjJpUjM2Sy9qUU9IVUs2c2JRK3VWejBkNUNwUVdo?=
 =?utf-8?B?QTFnOE9PRXhrZTZPSGJSVmxEbmg5c1FvRjE4clZlTis3L2RWa1BQbzZWWG5P?=
 =?utf-8?B?UU5aalowUjJBVFVRUFpQK2s1cDNhengzVm8zTGc0aEhmc0c0VWFyM0dscjlX?=
 =?utf-8?B?dlhwcjJkcm0zbDdIYlVFNmxkTk14dFdFVEd2bEp5TGlBdDBqeFZkUk5lUDF6?=
 =?utf-8?B?SXpQYkg5NkZha0VYVGphVmFscnd6c3hBT1kxZ3hSclNwMjZlSTVzQWZETUV2?=
 =?utf-8?B?akRLekFULzczNlNaN2dNMGxEQ2g3ZTZZaWVSL0orUW5XQUpMVk5CU0E4ZG5B?=
 =?utf-8?B?L2IvM2U1NEhsUG9UMExWL1NLdVMrMkhsSTVRVERERW9oU25CMG9OMWZKbW9I?=
 =?utf-8?B?OVdsNVZUVVpwMDZUekhpWGhtTWRSbG8rTjdqTExwS0pCYVdSTzhvK3dpZ2FU?=
 =?utf-8?B?Yjk2WkROdTlianNMelhVMDVkWExrb1czRWVwS3A1YVVyYXE1NGxBWFpENmdz?=
 =?utf-8?B?elBVZ1pVL3VwelNzclo4RTU2dFB4NXRNeWtqbnQzemZoTjhDZ0hKVVJJM25s?=
 =?utf-8?B?TWtERGJQOUc4Q200L2FWOGdreTFzZGE1S1Z3TUVxbHN1ZTBNZkhXNHUyRlp4?=
 =?utf-8?B?Z2RCUWhHSFVmeUFmQUl3V3JRV0FDNEFURURldVRQaFZjcGVGRlhxdTkzYzVk?=
 =?utf-8?B?SDdmZm5lSzMvMHNsRlZlcVZGNi9ES21TMXUxWGpYNHhXWTBac3NBdlpha2VN?=
 =?utf-8?Q?Q3W4Y2QoaS6331X+CMrPHKAFMOtpweMo6TZYX?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e019e5d4-512c-4a32-dfbe-08dea4358445
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 08:18:09.5715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bva2Xy3Si36LtaXYUe0LZAt1+GuqitCVkPTwohG1wUhs7D/MOIqJ26HmZK8rLucAopUeY0jj0NVi9mNXFOCNA9jX3uED+I5xVBIxqqqN0ZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11320
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 08:18:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3829

Hi all,

On 4/23/26 6:19 PM, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> This adds support for the NPU (Neural Processing Unit) found on the
> RK3588(S).
> 
> The NPU is supported by a kernel driver (CONFIG_DRM_ACCEL_ROCKET),
> Device Tree nodes (so not all RK3588 devices supported upstream
> necessarily have the NPU declared properly!) and a userspace driver in
> mesa (teflon delegate with rocket gallium driver).
> 
> This adds a config fragment for linux-rockchip kernels such that the
> disabled-by-default Rocket driver is built and enables the Rocket
> gallium mesa driver with the teflon delegate, but only when the user
> requests its support.
> 
> This was tested by running the following:
> 
> """
> wget https://gitlab.freedesktop.org/mesa/mesa/-/raw/main/src/gallium/frontends/teflon/tests/classification.py
> 
> TEFLON_DEBUG=verbose python3 classification.py \
> 	     -i /usr/share/label_image/grace_hopper.bmp \
> 	     -m /usr/share/label_image/mobilenet_v1_1.0_224_quant.tflite \
> 	     -l /usr/share/label_image/labels_mobilenet_quant_v1_224.txt \
> 	     -e /usr/lib/libteflon.so
> """
> 
> from an image built with meta-tensorflow's tensorflow-lite, mesa's
> libteflon, meta-openembedded's python3-pillow and OE-Core's
> python3-numpy packages.
> 
> Note that the Aarch64 RK35xx SoCs all have an NPU, but only RK3588's is
> currently supported in the kernel.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> This was tested on RK3588 Jaguar with linux-yocto 6.18 +
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=843b912c7241ed0259f6234243da05e10ce67c0f
> 
> Note this (lightly) depends on
> https://lore.kernel.org/yocto-patches/20260423-python3-14-tflite-v1-3-68bca178a550@cherry.de/
> being merged in meta-tensorflow. Another option is to simply add

This has now merged in meta-tensorflow.

Cheers,
Quentin

