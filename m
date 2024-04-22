Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900D6C07E8F
	for <webhook@archiver.kernel.org>; Mon, 22 Apr 2024 09:23:51 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.122])
 by mx.groups.io with SMTP id smtpd.web11.14072.1713777821392646723
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Apr 2024 02:23:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@theobroma-systems.com header.s=selector1 header.b=epsSeaSc;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.13.122, mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTwWUlYkYotbtgVu16y8NslbZmYcT+k53nhAy1HIhIqf38GVffRzb/P3pYMzoCrbqeLD+XPPnJNu0/uuJSi3RXggai/27xpJ/6GBCvptOkJra0cBJYNElPWHwhNpQKi8stfSzN7mHrUB/hnZt4a8gqtjfRDTUuWjyfHtvb92pPvBoB0OOCK8BCE0ho5rc/GOqAA/xiFOp07jcypugETr/ErdNKPsjjNMg/69FyumO85QPNKg3diS6pw2CN7j40+HElY9R6wfOq/ZOoQDGvXUuapgTMZDtCBmFfzX3LnrlJ+7GwJOwqaSY0PS3adb25ppxvSsNi0RbZo9C/0o99i+UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnNxKJxdgywlnwsFy9kenNxHnvFU8Ir8GNHtXIY2sPg=;
 b=ah4lAYyxqmMxMSRj/VmtO9prdd7hDZNXKSWGw1JN44tc+5GxR92ulnOuHl6Y0EInRwrIBjvEh3k297ghgkohRRY0XpGFRd2vbQuIHFKkjIY7wq/dGOVIjPaeQayaRwlluQhR04ZrwwdNVYP2X/rRSjePovNi5Rxlzb0wcUVk09s0ceckXi2+9qPSjMoyycXDzuolbNKWIfv61oA44X49j6Mocr9KyckuwfMsYdG6r+jtXpAshOsSq3n9k/8Ge8ctiQMB/4PD58XCmNs3lrfitu4F2IdffWTDWHHhQ2HUstka42/211ZOKA2f41KAnH8g7e6i8e/Bh49iHVX1/zkSiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnNxKJxdgywlnwsFy9kenNxHnvFU8Ir8GNHtXIY2sPg=;
 b=epsSeaScTobtHh5BB/RqJUqmWgfbp277eZGn0CAvnqo54W1AtRIW9p9lLpPoj05APfbqqX/NRWH10AlzCxi9Oc6tyy5RwUU4E6Qjtx3ptugx1cY9kh2U9f1aIEj4is+j11eN8+X22yE2wwDrWmuv8K/qqF3LyhUnevSZb1yC4Xxlm768i5xUqL1ZYAjatXD+9FCJcnhBlogObKIcOLtJtS3J0ykXtnNm7kBdtqMKFcC4uH8IWnKRlI7LqvEOsmq1H/Mclw6UwsyBPuHxTFoC2PWLyLbwY8NNKfsW2CxA9XRMsw+qfRXUv5ENU02mSjVsKylqYnElfVvaRFlQ5olY5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by PA4PR04MB9222.eurprd04.prod.outlook.com (2603:10a6:102:2a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 09:23:34 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 09:23:34 +0000
Message-ID: <7899a171-eb32-464a-8f74-7b730ca38ce1@theobroma-systems.com>
Date: Mon, 22 Apr 2024 11:23:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [Poky] Do install append to mesa does nothing in
 scarthgap
To: yocto-patches@lists.yoctoproject.org
References: <0qeE.1713652756483185891.Q3Ak@lists.yoctoproject.org>
 <9744.1713652881983262652@lists.yoctoproject.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <9744.1713652881983262652@lists.yoctoproject.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0017.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::17) To DB7PR04MB4842.eurprd04.prod.outlook.com
 (2603:10a6:10:1b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|PA4PR04MB9222:EE_
X-MS-Office365-Filtering-Correlation-Id: a16ad441-13d3-44ea-b2c6-08dc62ade1f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VmJYb2pHUXByZGVKSXgzb3dzYUhXNXJSZHlQQkdleXYwKzRQZFdQdkUzQUlJ?=
 =?utf-8?B?cTRSczM4NmlPWFMzc1JiWVpNb001Ni91cEhlTnN1Y3EzTGErQzF4ekN0ZCto?=
 =?utf-8?B?WDJvMmFtcnpYRkpzZlRRQzgwT2lQdHEvL1hpN3FwUkxqTTd3Z1JUMVRRbDBm?=
 =?utf-8?B?NGJ1VWZuSkxMa0w3VU9oaE5NZVJOejZvOHJ2VEtMazJNc1NrMnNqMm5GT2pZ?=
 =?utf-8?B?VUlDemZ0ZDA3YmgxbVkvQjFLdDB6azAza2dNMlNHRGhacStyTkErZUZBbkdI?=
 =?utf-8?B?RldnczloaGlJazFmd3lZemtxejNIUWVScmlkOFg2QjdVRnpDSTlMUXB2RGp2?=
 =?utf-8?B?L0xGTkpscWhaenYvT0syaDNRTkVxSE1sKzRwS3dhVHcwd05IR1phSVU0RXJ6?=
 =?utf-8?B?MHRGWk1vRk9qQ2dvUk1kOTVxUVVpNFUrZWowYzFtNUhDVTRoSzBmSlEwVGhk?=
 =?utf-8?B?M09YdVQ3bGdmK2NMQzcybnFvQW96cGhBRnZCeWMwR01weTR4YTFnQjlGazZN?=
 =?utf-8?B?dk0wL0pjWTR5WVF6dy9zRjVIRTdTcWlYVXV0b1NuSHdJcVNPbGMwL0hQWG45?=
 =?utf-8?B?NHF3VUZrSVlqeURDWjQvSzA5UVBxYkVwNitOS3JmeHQ5cStKeGI4WE1DU0ds?=
 =?utf-8?B?bGx0SHhsQWdnUXJwa2xRbHQzUTVWQ2gwLzlseTQzdzRvTTN4czlIRXZPb3FQ?=
 =?utf-8?B?Y3dFZ1oxTDd6K0s1WHNMcDgzQzdiYkpxY2JLa1NGNU5NUmlmQWlOV1EzTzBW?=
 =?utf-8?B?UGx5N29lNFlsR0puV1kyRklBdzhGNjhoQTUvYnc5UVhEaW1pQTRmM1pTdFEx?=
 =?utf-8?B?MVN0bzNyQVozNUx2RW1wVDRMU0NkY2xkUUNrNGlSV0FJYnc1SEJLQUMzUEIx?=
 =?utf-8?B?MnduaEtGNkxqWkF4ZWd6NnhCOTB4VG5iRldOTEZ3di9zVTJRS29NaUdkdUtj?=
 =?utf-8?B?ZTg0RzYxTWlLRnVHMzNwU01Pbkx1WEVsT1YrcjcvUG9NUlMwVVVpVHpzanRo?=
 =?utf-8?B?ZlFjZzF2VExpWkhRK0RISWNWbUtKL3BKWU9zcVlpeGFla2ZJU3BZbkh1QWEz?=
 =?utf-8?B?ZmxLTFZKaVdEQm56d3F4TW5RUnJqM2EzMGF3eGNIYVY0UmhMRkc2bHIrT29j?=
 =?utf-8?B?YUw4ek4zNnhHaFJjREpSb0pFUmxDU01ZV1k0cGhOL0pYUG9OUjVYZjZWbEhz?=
 =?utf-8?B?YUYzKzRBUkFpSjBMK2dRVTZGekUxVG9rdG9jRnU0THAxSC9EUHpQTW9zSjly?=
 =?utf-8?B?L3RuSENuWWptbVM1dDRZdTRCS0VnWWFsQWF5MmFrUXczbkFKZ1Q1SCtmL25l?=
 =?utf-8?B?UUNHdFB0U2haRmNpY3VDYzQ5YkU0Vjd6bEd3ZmQrOUxiRi8zU3lBRGxKanE5?=
 =?utf-8?B?SDN6ZEswU25QN216WG1TT3hNNk1hMlVmdHp5SFlzamJaQjZyOXRhcXpveXJP?=
 =?utf-8?B?bUtaTmZoUlBhMXQ5UGRuczNEVXJUUGxndE9XdXpPL25Ld05sSkd3RjU3Q2U3?=
 =?utf-8?B?ekVHZG9jcjNFbUJWZi9ZczZ5QjJZMjZ3ZmZPZ1U5ZDFlOXJUN1JrVnJkeG1x?=
 =?utf-8?B?QVhINUdqRHVMaHRhUHVaeUZMbm9INkg3SHhwcU1RbFQvTitUZHJFUGV5VlBP?=
 =?utf-8?Q?vroD4uMfS0uJgdIujE4yiLTNZlGtuihCNBE0jJmpaUmQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4842.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?anJRM0c2KzdRQWFOazhEQ1dCYkFPTE1FSjFKQjVDQkU1aHdqb21YSHBhaGRy?=
 =?utf-8?B?Q1BkQnZkeUtERUNEQ0tLT0p1bnVSUjc0a3lBTFFLMEZtd1UzdzVXWmZmT1Vm?=
 =?utf-8?B?QUp1Z3NFaXhkUDhKN0pOOGtZTlZPUkVYVTVtR1VvdER2T3p2SUJ6ODdPdEQ2?=
 =?utf-8?B?cFNiS0lUQlo4NjNBemY0V3Q0TmNSYTE3K2kxVWFPVVlINnlwTk5takRUakVm?=
 =?utf-8?B?cy94VUVrSFRRbGJncUY0RXpncXFCVE0rSld0QmM3QUliMHcwcGVUV01Qdksy?=
 =?utf-8?B?d3VjVmV4RDgxMWlhdzNtR1drczRqNkVuWnkwMlc5bGR2Tk04eWdtS1hJZ1pQ?=
 =?utf-8?B?V005M096cEtJNmx3WWw4YVBFY2VocWlhL0YwaGdDZ0tOa0VzekQrcXpQVmwx?=
 =?utf-8?B?TFg1dERRTSs1WWcxV205OFFwUDJucVJxZjZBTWtUbktWMUNUeFdtOFhqMDZn?=
 =?utf-8?B?SkNma3VjRGVZY2NGTHpscTJJQ0FidG81V3dEL2F5OTNCU2UrVmIvbHJWK2RV?=
 =?utf-8?B?S2VOYXNmeTJ5Y0lqcDllOU9hdDFTVEg2RWFmQllYaGJaT01Ic3ZhYmc5WGpz?=
 =?utf-8?B?WU03cWU1T0tmOGJBT0hQTFZWVlhDVTBjalNGekJGQlNOWitRTFZBdzg3bHl0?=
 =?utf-8?B?aG1haTdpZnl1Vi9ndHVkaFZWdmFwQlY4WDM3ZnFHc3NobkxwV21ocnpYSGlM?=
 =?utf-8?B?ZkRyRmxpWC9YVWJ2RTBwWUxBUUQ5SFc3L0xkZ052RGZ5OHVCSUpuTUFqNGJw?=
 =?utf-8?B?ZTExZjR5K0ZYUkw5a1JEYlEyQUt1NzdDbU50U1BkcklJWXdzWDFXZ2RtZ3da?=
 =?utf-8?B?SGg3b2x5eWFkcUNEakp5Q0ZZRFlQdmFuZmpvNzRYVzcvbWhjdHFNL0Y5UjBK?=
 =?utf-8?B?VmxEMWp5SjBmTHBJMDNlL3BwNmgxYVY3TWpSNmpsZVB0K3BXamhBWENzaDVZ?=
 =?utf-8?B?cTdYUU03VkYybkdZLy81Nnp3bUVPVlA2TFpyRDR6WW1OVTNtU3NZVnFob0o1?=
 =?utf-8?B?KzB2K0dObTQ1dnBCemgzdnhONThvbWNtaG44bFE1RmFsOEdUTjFGaTVBQlNq?=
 =?utf-8?B?UERSaVBjRnFTbVdhV0Zkb0d3Qk5pSVhjai9ac3c0K0ZqOEN0VFVBdUpXRnU1?=
 =?utf-8?B?aXVXblFnUStFT2YyaDNWem9VUlNSWmdRQ2l0ZDQwc0xFWFA0S0RBM3JycVhj?=
 =?utf-8?B?QWY2a2lTL1kyYW1GcWF0dktnV1RnSEQ0M1lMa1dIMEVWRUdObnZNc0JHRXdz?=
 =?utf-8?B?UytUbWtVODU0ZnBpOSt0VDNyNmcwcTd4Wm5LWDJQYkVJR1dyZm1yZEFaVWc3?=
 =?utf-8?B?TnZNZjhCSkZWSVV6bHZFK3BVL2dubm1PbDVxUXZiWmJLK0VGVlNIK29MbXNI?=
 =?utf-8?B?WS9iYmQ1U2psQkQ5SHNYa0NvVDc5RVVQak5vUXBtMjB3VHdITnJHVUJrV3Zx?=
 =?utf-8?B?VFM2aTI2bXkwV053dHE2dkJPamRtNHR2ODN2QWtNWE5XQnpyODhXd0RvMFIx?=
 =?utf-8?B?TzByTUJXL1FaY3VsM2JJVi9YdVVXZDVZdHgrbFlLREVKcHMzQUdvaXBCdCtk?=
 =?utf-8?B?a09ad0h4MVBrSDF6OVhQSUp3aXJIUHdpUnN4MW5pVFNIRDk0cVVWdVMrQTNS?=
 =?utf-8?B?K28rT3dDU2t6YjRsaWxBK0Y5MGFreE9kaGNrQVVPUHRPb0NSWjFTcmdGM0tE?=
 =?utf-8?B?bE54cHVBOUJBYkJmOUpDYllXTG4yQnhBUzIySDVjVzZ0Rkt2NjQzbGF4M0ds?=
 =?utf-8?B?K3U2UjQ0VlhkZ2l0NThZeEllTzZGK29LS2lQWGFLbXMzWHhDU0tBWlJ3UDVD?=
 =?utf-8?B?MXRLZHpKb2pVeS9TWURKaUtNc0RhRHJ4Z2lCYlIzSnVaZG15YnlXZjFJamsv?=
 =?utf-8?B?UFNzVS90TitaV3RvTUZ6MTZwNDFWUG1zYUQ5aldGSzBzc0hQcVQ1ZldQVk94?=
 =?utf-8?B?OWcwczdFaVRCM09UZ0t4b0pGT3NldGRLNzhXY0FEejlBc003OS9IRUtvd3Zj?=
 =?utf-8?B?dWc3TER2MFl5NExqeGZZb05vNTFRd1JPM1FVbFZOakJtblBYZU84T3NQR0RZ?=
 =?utf-8?B?TmE2QXMvTUF6Z1EwV0s2UFNwU0JDeStkNkhJVzJ3bE56U0ZwNTFPVENSQTh0?=
 =?utf-8?B?NmtMVEJzR1l2dWl0TVNHYzdXc3FNUytVYnV2MmxUb0t3eGJKVS9Ra3ZKMXJU?=
 =?utf-8?Q?oc+cBLPRWCsL2GgY5DlekVw=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16ad441-13d3-44ea-b2c6-08dc62ade1f2
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 09:23:34.0791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2mqTE32QMH8UT2eYDsnnPW3TCO9iNd24zs2R/rGEYs+h2CrsFsIONugPQcZ60yvVeQ7oZWtr7gy2jOidMEp/+HMqqi4ic273pnxjIPxQihhd8WMQF4J+54wB9g82rZTQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9222
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 22 Apr 2024 09:23:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/51
Message-ID: <20240422092332.4LvW9CPvgNB83KuntciatTr0XJoa43xw8qu7TjNiEuY@z>

Hi Joseph,

Good catch, can you please send a patch following our process?

https://docs.yoctoproject.org/contributor-guide/index.html let us know 
if you have questions.

The change seems to be merged into mesa 22.3.0 and 23.0+, c.f. 
https://gitlab.freedesktop.org/mesa/mesa/-/commit/96894e6746c199cb8a5b8356f75c2ee8f28e68b1

So I think this means we should backport this to Mickledore and Nanbield 
as well, according to the versions reported here 
https://layers.openembedded.org/layerindex/recipe/5605/.

Thanks,
Quentin

On 4/21/24 00:41, joseph.mills via lists.yoctoproject.org wrote:
> You don't often get email from joseph.mills=cnhind.com@lists.yoctoproject.org. Learn why this is important<https://aka.ms/LearnAboutSenderIdentification>
> 
> Edit
> 
> 
> 
> Upstream (scarthgap)
> 
> https://gitlab.freedesktop.org/mesa/mesa/-/blob/mesa-24.0.2/include/EGL/eglplatform.h?ref_type=tags#L112
> 
> 
> 
> Upstream (kirkstone'ish)
> 
> https://gitlab.freedesktop.org/mesa/mesa/-/blob/58ad6e52d1983785e951726f6940aa30e46bc462/include/EGL/eglplatform.h#L125
> 
> 
> 
> _._,_._,_
> ________________________________
> Links:
> 
> You receive all messages sent to this group.
> 
> View/Reply Online (#49)<https://lists.yoctoproject.org/g/yocto-patches/message/49> | Reply To Group<mailto:yocto-patches@lists.yoctoproject.org?subject=Re:%20Re%3A%20%5Byocto-patches%5D%20%5BPoky%5D%20Do%20install%20append%20to%20mesa%20does%20nothing%20in%20scarthgap> | Reply To Sender<mailto:joseph.mills@cnhind.com?subject=Private:%20Re:%20Re%3A%20%5Byocto-patches%5D%20%5BPoky%5D%20Do%20install%20append%20to%20mesa%20does%20nothing%20in%20scarthgap> | Mute This Topic<https://lists.yoctoproject.org/mt/105643681/6293953> | New Topic<https://lists.yoctoproject.org/g/yocto-patches/post>
> Your Subscription<https://lists.yoctoproject.org/g/yocto-patches/editsub/6293953> | Contact Group Owner<mailto:yocto-patches+owner@lists.yoctoproject.org> | Unsubscribe<https://lists.yoctoproject.org/g/yocto-patches/leave/13168703/6293953/1843281461/xyzzy> [quentin.schulz@theobroma-systems.com]
> 
> _._,_._,_
> 

