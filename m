Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD73EC2BD09
	for <webhook@archiver.kernel.org>; Thu, 27 Jun 2024 11:48:02 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.102])
 by mx.groups.io with SMTP id smtpd.web10.6009.1719488872648670239
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Jun 2024 04:47:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=QzON+l1g;
 spf=pass (domain: cherry.de, ip: 40.107.103.102, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NeMOixwU+J+0+k9C7ewhoC/O/FcTgx6rH7LSkl1h/nJNpYb01cJJ6VZuD5ZNjceGu2fdd5QlPvs0m7PbyV6eqLUNvdQCMJVtXChZThx4VC/WTPXHz6lpuOcOWeOtaJdmjOY/ox+a4eHGUQPVF02tmimKUrxuU7DOmZe0jlvUXn1fLFnibFVRQpwIPZuaH2fs+Mjorzg3blszxWMBHHbk0B6UD7lRCLfXPY5dc3Ypq29wV3u/K7p9f0SneXlP3FcupQK5jNTulmAJM0MWNvPdYg64mxipxLCxTLPJSAeDHhDqzITDa3qoKk62kPn7j+YJ5YhAPpgMGdRZUiSt2GIzIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/h1cVr6qLt8vaSuQcJUi8GWh6hagafF58EBUQH3Axc=;
 b=IG4zPbCjxU1ysgpMbGybes96NjJtbRqKI6akv+B/V9vGjQSG8s6Khp87z9VtYhFS8RMR9ci4JMKFVePM9yVr+fbIpDLd5XQMCRlVUtyoBfhB8Iy5wjHgdrerjrBmWQb3CvPEObO5kRdcdAPpo3dvjKnhLwvMrF5Q9yLfc3hZsMa23K46wQtOcgO9MjN5LoxbwVAwDISdomGwiq85UYn1RpiYNbDPvBaKePpRiIYH/r1PXrHxD2ocRNFRCtQfbcUiPRagMqVsIl/RnRcxbycA8KXA136ZUzZyuVnQWx2XiAvZQvz3jPiVOUKREwkxSAblioN4xMngaP07U/duln5dMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/h1cVr6qLt8vaSuQcJUi8GWh6hagafF58EBUQH3Axc=;
 b=QzON+l1gI+A55a0vQX45j9mIm9ZBilTP5NbeQkSGiwOp73iHbkSmfucydLxEBrqfYCUnsMykxRfVCFt/7S/qrxGYygjQj4ErPt2K84aACyNIHBnpfKE/mH9SuSqt1AkVnN5/iNNSpps4xzhXy3R8W8CI/2PzmE6j+HtSX6KXP8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by PAXPR04MB8925.eurprd04.prod.outlook.com (2603:10a6:102:20c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 11:47:48 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:47:48 +0000
Message-ID: <912826d9-a007-41fe-8338-a70d552e0b61@cherry.de>
Date: Thu, 27 Jun 2024 13:47:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v4] rauc demo: add
To: yocto-patches@lists.yoctoproject.org
References: <20240626213536.12343-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240626213536.12343-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0012.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::27) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|PAXPR04MB8925:EE_
X-MS-Office365-Filtering-Correlation-Id: 0971017b-2a20-499d-c9ca-08dc969ef764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RG94eEpqN1g2Ty9Tck1kVWVBbmJWdUxxL2dieWpGOEZhblhFcFNzV1lXY0U5?=
 =?utf-8?B?Vk1vYWhJREUzcXozbmxEb3FEZWQxZThqdHg5elFGY29qS1RYaVo5Z0NqbC91?=
 =?utf-8?B?RmtsSFFwd0tScldVNUgvdlVJQTFHNjUvcU9lVzhsV2s1VDEyM2k5QXdLTkU5?=
 =?utf-8?B?cG9SZDB0SjRyZ3NqWGxOUHZKajJHb0VyZ2RkTjk0WXg1MGRPb21waHBoaFVI?=
 =?utf-8?B?THVEenk3ZGVRQmd6UENQN3hKd3FPWnl4WU9UTm5ZZXVnNmJWYk1KSmtCZDFB?=
 =?utf-8?B?d1M1bU82L2h3SFZIYU9tZGVXN2h0VDhtdWlzRlZFZHV0NlkxSzZrVEt6cmZR?=
 =?utf-8?B?QXp6QlFRMHlKU1NSYitNZWlyNjByQldHRVpTTHJpektCTmZnSEh3UlpqS1BI?=
 =?utf-8?B?NFBZMk0yb2N4NlRzVEVoeXZ2RFUzYnN1cWx2YkJMWVpHOVJRVktoQXNubndy?=
 =?utf-8?B?RzNTU2ZwdWVxbWExWklvcjJMczNieFpCWnBEeUVvMEVla0tqSWR0MVMxRXZo?=
 =?utf-8?B?R1lwOGhMcEk2NW5pWDYyZDlMcGZKZE1OS3Uyb3BvZXVCOWIyUkdVVjJOYk1s?=
 =?utf-8?B?andrdFh2MVJtR0daeW5HeVZ0LyszZ2F3MTAvamhQNzY5ZmhoSUVwby9nTFht?=
 =?utf-8?B?ZFQxZVhpSnNxVmhDZzlzYldBaGN5TmRGQnJwT1RKVVUvblJWSjhKdlVuQ2hN?=
 =?utf-8?B?aksxR1V2MmdScE5sRXFabzV3MG1FbW5GSmdGSnpKaFVaTGxoZEQ1eTFEbGpE?=
 =?utf-8?B?MndhVmZ4NEZycGt3NkVTT0VVY3hvMkh0VVNwclZMWElrT09zdHg0Wm54L0kz?=
 =?utf-8?B?MkpWL3EyN29OSkFVZGJSaU0vdVczdjhOeXFUSWg2UnI0NWxHQmZZb2poQVVt?=
 =?utf-8?B?dFhXQitYMG9pbVFCWVd6WmdyODhRVWxUOVJZbWc2OWM0NE1Zbld6WERpV01o?=
 =?utf-8?B?UThtNGg1UWdQRUxwa2RNa0VnQnBRV0lDQzVwNDV0bEh5amlqQ2htTXkrOUZv?=
 =?utf-8?B?em55NFZ2RlNDd0Q3aFNDWTRKNmZSdW81OGtDYmlhaXhBVlppNjdqVVdCNlhn?=
 =?utf-8?B?TFlRNzFIZloyR2ZLYzBtNkZCb1o5eXE3RmpSV3Y0ZTF2WmVtaDQvKzEyclI2?=
 =?utf-8?B?TkRBZlFtZ3cyOFpaRzhLSzk2a1NNUEYrT25SUnNrWDBMYXllWGd5cjFPOUZ1?=
 =?utf-8?B?dklCaVlkdGJnMDBieWlCOHR5MnNqVU1MNGowVFUwN25qY2NrQWc1RVBScDlF?=
 =?utf-8?B?ZW1YZVVUZmxoTk9PZkx0RUtpNUpqUnBkVEVtaWpsdGhJY012MUcvLzYvVFF5?=
 =?utf-8?B?YmtiN0hDSEFYTFFDL2ZMYTIyTmZQUWdhbGhkZ1hpZkduSGIrbmxobDFQbVJa?=
 =?utf-8?B?MWs0VUV6TGVDTjJGUm9heFBENzZISnpKRzA2LzBySGVhb2RkeHpUaStxUSs3?=
 =?utf-8?B?R1hvWlBRazZFbm9VZ1hmNUFzTlVtUE02cFhTOWNZcldoRVp3ZFB2Nmd5akd3?=
 =?utf-8?B?WDhKVFdkTk1NYVZRb2xVbCtWZkRLUlllcWM3aVBKbG5xTDhxa1dRbjFxb3g2?=
 =?utf-8?B?Mm9tdXRRKzJ6SUlzM3JGbW5wQ0dURHZveWFUUmtCUGJ5c3pIRWZORC9RcEhs?=
 =?utf-8?B?cXJLMS9STVlIOVdNWUlMQ0w0VmowN2w3K1EwRGVuenVoV01RK3Q1TUtKdGhC?=
 =?utf-8?B?MTU0ZWhGeGJHY3Vvb09DeFRLS1lzMVlmd3BzdGxOZnA5RU5SdUljZFl5dDFO?=
 =?utf-8?Q?2SeOUsUTLuN/KiLrA0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QmZoeDZ5Qml3RHIyMmpSZFllanRDVzBkaGZtM2xvamdjNjdZa0tCYzJtOTVk?=
 =?utf-8?B?dnVaYTVUb250Y3Y3TmN2NU05V2tyQzNITmZ6UXRYZHJnZEUrMW9GeS9xOHdX?=
 =?utf-8?B?cWY4dTBKSFVRa0lPYW1hTHNJTnA0R2dyNXdodXNYM3YyUEkrMmh3QkdsMW1Q?=
 =?utf-8?B?L0FJUi9zVEZUdWlEbFZSaWRTSVRJeGM1bnVYNVBCRTdUdHB2VmtsTnFuMUNK?=
 =?utf-8?B?YTk4NTA4cnhuVnc2K0daQ1N3ZG5scWNGRlNjU3JOdFoxVHVBcEZ0d0pHancw?=
 =?utf-8?B?dHpiMHU5YXZNTjhlQTJwYUsvNlU5eTl2bEhNUXdJL3kxM2M2UUZpMVRsMUdX?=
 =?utf-8?B?bUVzTkZQUktCdVlmOGFuUnFhdXFLMVRma0dKNm9xVTNseU9sZXlNU1ROc0s4?=
 =?utf-8?B?clBIMDdPQ2tIQlJhVnV3Y1hZT0Q3OEw0QzVKRStaSU9Tb1l0WHBrMGg0c1po?=
 =?utf-8?B?cHFoM0lVbkl4T3ptbVJTRzVqY2FnU01vRzR6ekJML3FuM3hueUVHb25Ydkdz?=
 =?utf-8?B?U0FjcWRGMnlJekYrSDAralQxaXFoUENjUXhneEllQk0vajA2SXNUN0hkZ0wv?=
 =?utf-8?B?STRJMWo4Z04wQktpVkcycUJHVzRyMVArNjdlUXI2VkF1Y1ZURHlqTEVZdktz?=
 =?utf-8?B?YjdkNlNaR2FKU0daZTVmSXFPWGRCalh5bnFZbk5wdmQ3YnBhSkNwRkVCeEpo?=
 =?utf-8?B?M2NKK3BZc2FybE1hK3JEYkYrNUFyZ0JheVBuQ1ZPaDlCa3hybEdxcElZTzVH?=
 =?utf-8?B?QVFYdmVLTWVCMlpuRlVSY2FmVG16MkVhZW9vMmF1SGFHWVVyU1JIN0pHcWl6?=
 =?utf-8?B?T2dENk1QQXJLMlI4Y1BTYUF2Y3ZUWWcxdFBCUGs3M0dxaUJBQ3AwNFBPdlFX?=
 =?utf-8?B?TnNUK3huMFhYdDVmWGY5TmdUVHV3QWNCeEJoam5zUUEvNGZRZHk1RkU3S1J1?=
 =?utf-8?B?YnFjOFRuZTQvTHhZK1FDM09FMXhmemtKSlJDeFFTWitDTUtmdmNFZlNiTWtQ?=
 =?utf-8?B?dE11RmprWjNaYksvc1BSUitsajVYYmxJWDJEaHlvR3lMTXh6YWNRUE5CMTR5?=
 =?utf-8?B?RVZuRjlpRW5nZGgyaGZJRDZKUUlOYnFGTEJFYnRmbjBha3JSVTlJeXVEZmw5?=
 =?utf-8?B?ZWFydHNwN1M3bTRIa2U3NUpUc05tV1BNUUdTemM2Rzc2V2MwQzVhcFhRVE9C?=
 =?utf-8?B?TGQxeW9VdVhPRHJ6Z3poaHBzc0lVcjM5Zk1UUHpwUFQ4Z2dNWTlRbFRlblNC?=
 =?utf-8?B?Q0FwVkFOd2tqU053RzE0OTFWY2FWdENQNEpKSVJqZXNib2h6cUIwR0hSU3dx?=
 =?utf-8?B?aDhlSGgyM0E0VWdESTgwZGR3d3Y3VEw2ZzJTWlZOVWtUODJkZXdyKzl2M2VH?=
 =?utf-8?B?Z01ROHdBUTNFNjNwWm5ham4rMWc1c0V1cnZFeUZhNmpDM1FYeUZ6ZldYcUR2?=
 =?utf-8?B?UUd0a1hKWDBJMTZwamMwWlJpTXN3eXEwbHRHSjhTaE9ZRlErMnE0cWNXbHpk?=
 =?utf-8?B?a3cyQWZGWHIwN1p4V2RHU3p3dXJtQ1cvSmF0SGVKU2dmT2VSV3dPYkw5VFV3?=
 =?utf-8?B?dVZONFZzSTVsMHQzYVl2MGFxOWduZzF3RVdmcU5mZFlHSTJqbE1vd0lrSkg0?=
 =?utf-8?B?a045MG9SK2k5bDlQVHhWZGN6WWJKajZuRHJscXFCZUo0elhIWVBNQUJtSEJR?=
 =?utf-8?B?ZFpMZHk2VU5sOHZIWHluU1h6ckNmNUg2ZldvV2V4K0tmbnlWblpmbnBxTWV2?=
 =?utf-8?B?S0xJU3c2Qk9BMkwrUDZCb3A0eGZZc2dpTmo1UHNMVTJaNnd4MjJQYmtPVUdV?=
 =?utf-8?B?NURhOG0vSUpjeVVhSGNuWmhEdG11UlB3OTVRQUZhMjU4NkUzblNkckl6UlBJ?=
 =?utf-8?B?dlMyWktoS0t0VGZOZXRQSmdxbXh1RjhMTGFUZ2VZTis1TFdRNXNvTnRXTExq?=
 =?utf-8?B?WXk1M2F2cmJuTW9YWW10bzZQcHBydnhnMkpOemE4S0lTTkw2R2tHWURLaExI?=
 =?utf-8?B?YzJ2VkZzQkpyS2srT3Z3Y0JvZjcwQTNaMFNpVEhXeWRsVnYzM1h0TVZDNnd0?=
 =?utf-8?B?RlJaVGErb3oyR0l4OGQxZllZRU5rV1cwYzZOYVp4TnYwYi9Tejh4ekFDenJV?=
 =?utf-8?B?Wk8xU2NML2k3cXJNU25DTDVWcXdUZkt5aUtuOHY2b21JMW1uRGpQMGtPYy8r?=
 =?utf-8?B?ZGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0971017b-2a20-499d-c9ca-08dc969ef764
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:47:48.1133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LuSFmEgk1M6t6i9YdDwWFzRJYNGWGToobKu9mk6rKqvEVHv8RK9YIkK5NDbvNcBdeCb6lL2OyIJKBkeozx7ZIrm4x8utTxxPwxs06XmglpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8925
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 27 Jun 2024 11:48:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/388

Hi Trevor,

On 6/26/24 11:35 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> Add an example of implementing rauc on a rockchip board. Adding the meta-rauc
> layer, adding 'rauc' to DISTRO_FEATURES, and enabling RK_RAUC_DEMO will build
> an image using the example provided in dynamic-layers/rk-rauc-demo.
> 
> This example uses a simple A/B + D scheme (i.e. two root partitions and a
> non-updated /data partition). Repartitioning occurs automatically on first
> boot thanks to systemd's 'repart' mechanism.
> 
> NOTE:
> - this example only works with systemd
> 
> If you wish to provide your own implementation, simply add the meta-rauc
> layer, add 'rauc' to DISTRO_FEATURES, don't enable RK_RAUC_DEMO, and provide
> your own implementation in a separate layer.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>

I think it's fine now :)

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

BTW, I found https://www.konsulko.com/rauc-on-rockchip yesterday. Is 
this something we want to discuss with Leon to see if he has some 
feedback or if he plans on using this feature here?

Thanks!
Quentin

