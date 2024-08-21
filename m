Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7E5C52D7C
	for <webhook@archiver.kernel.org>; Wed, 21 Aug 2024 15:34:15 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.70])
 by mx.groups.io with SMTP id smtpd.web11.23001.1724254448735432491
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 21 Aug 2024 08:34:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=VciYt/K4;
 spf=pass (domain: cherry.de, ip: 52.101.70.70, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5NnNElVNzfb8MqC1tSmVfA/MyzRwoFASswyVjIYbMPUEXtjua21FAemU4vF+J5rh4xN3W+tLcGQyzDQ3fHYwDRD+FcO03ge9+hjjwA6K7i9UEx3BrKUEhGCDOANdkEOeXrKJRfLuxUNxzgAwr5k/y5AYQ9o6Pp5RUhvPKXDRroHc4bkB/NW05JaaKcUeu5LhOczxBGu1FEqOTBzLmwHm541Q0kMbWqHRE41DqfZcAEqWyebZtxpc+9kq5j1gD4RcjRFxKOZVE2C77yPiOO9N6jKEZMekbayh7nFZhr0tE42cuFuU/Tr2kHZtVWSk1vF6BZtLQuHlp/uXExc60peHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TSEvob47iy5nG6Wh2nXLbXb/L+EbAHDVcn8gt8Z5iM=;
 b=DU0sXK91f534cHSn9C8XnBZIhdwoCCBu+t27YO6Wg11zzHdJG0x0VYreZ+VxIBMeoT11IJGK1VKdx4w8zQJuoYNlSdxPk8/sV3Je7KtGsoPYpcLRxCmIYCFnHubLbdkNOhJLKMzjXVkiUAaN7ZYB7f+CXFDGcUZH6G1W9WHyvwSxdJcgZz+iUUV+7mVYdeiMCI6DiJgTio9S96Yrz93LtzXegbAhU/IvSfYPy8gfyKr5XoJnkxmvmxAJZelWv0IFN0MI3K0sGRZEZQWQVmVJFEPG6XFM01oe/iR1W4r6GFK83rbUHCA1ANi7IxP+/mvUkmVSflkozV1FF7lTLj4DdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TSEvob47iy5nG6Wh2nXLbXb/L+EbAHDVcn8gt8Z5iM=;
 b=VciYt/K4ZOWhuJz/wR20SDgeLt+vkwCP5C3+qOH29lz3t/00j0HAKjpO+o1PmzLtoEx3hi9BU9WNl5vaolcOrNViweZ1OS2fJgG0VXnJlkPtaWKiKbIM64SV4pSAKkb0d7AgUR/awLWFK3O2gOQwTx44+Ql5edDULdSOW4JlRRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB8279.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Wed, 21 Aug
 2024 15:34:04 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 15:34:04 +0000
Message-ID: <1f84dd9c-bdef-4099-9dba-04b445a7ee0a@cherry.de>
Date: Wed, 21 Aug 2024 17:34:02 +0200
User-Agent: Mozilla Thunderbird
From: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [meta-rockchip PATCH 0/9] enable v4l2codecs gstreamer plugin for
 VPU decoding
To: Quentin Schulz <foss+yocto@0leil.net>,
 yocto-patches@lists.yoctoproject.org
References: <20240820-gst-hantro-v1-0-335c4eaf8e8b@cherry.de>
Content-Language: en-US
In-Reply-To: <20240820-gst-hantro-v1-0-335c4eaf8e8b@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: WA2P291CA0024.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: a0bc732e-4a12-474d-7c55-08dcc1f6b060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WUpKbE1zbWJEMHdESllWTktQd1BOQ1ZkVjZsTVhBVW90c2VXYWNhZ2VNU2Ro?=
 =?utf-8?B?Ulg2VlV4c2psNTFqeGl0U2JRbnI4U05LY20wbnFlTS9sbXJiVkZWc3BsaHhl?=
 =?utf-8?B?MVlmN3BIY09adVJEMVdaU2hoV3Z1TXo3ZElsK1pRdjgrV0s3RWZlalFTR1pM?=
 =?utf-8?B?UlhwTUJ0RHVNd2NkVFEzR3gvTklldXdlbk5hcFJVVHVzSUJlRmFkbjdWOWZY?=
 =?utf-8?B?MFZRNldLclk2TG1CTTB4azJHSWVnTmhLV2F6S05icUxUOExxZWo1VjRSdHQr?=
 =?utf-8?B?eW9seExUNVJoWCt1cW1NS2hJVWwrcEZZWlFnVVBZcnRjcHo5QThROStLUWhW?=
 =?utf-8?B?TVV4TnlHSTByTGo3VExhRnN1V3RybVQwOE1pb29vaXkrNDlHNlZFR2R6TjNG?=
 =?utf-8?B?Q3ZSbzZ4MFd6bGt1NE5MNkxyNHVsRGx2b1dWeE8rMmdZYlNmUjhiQm1xYVl0?=
 =?utf-8?B?b3NzazJ6RHRSZXVhWTRjUFhrbVVHZ0pBd0NUc1BxK3MrQ3J2cDdCb2VUaG0w?=
 =?utf-8?B?M0FWKzY1aDBOdjlxWDVPd2VpUm5NbzBzOUpHa3p1NVM1d3h1OGhENEUxV2FZ?=
 =?utf-8?B?RU5Td2RVNGJDWC9XYmxFQU1qdklBNXRrL3ozUUFONUE3amdVdmNxaks2emI1?=
 =?utf-8?B?dFFSc0R1ZG82bkdpamFMZUg0SGRMVkg3L0xwdGlhYmp6WFFMdlZmV0ZObjNa?=
 =?utf-8?B?SE5rVDBnaTNTRmxjamdxY0xzMUdSYWpnM2FvQXY2RFYzQnQrWkg2d0ZrcFQw?=
 =?utf-8?B?ZDRjRmJ2ekQrbTdMaTZnRGRUZG5DVXVoSFhMMFRocTZSQzdpQzNHekZocVlJ?=
 =?utf-8?B?RlFwekFQNmRxTXpFMVg3QnlReVhWOVEyaGtGOVowN3ZqeXYyVERxRXNvellU?=
 =?utf-8?B?NzBuVk4vMCtHY2o1U1c5M0dEMjk2eXg4Nno4QkthaHRFNUlkMFhTaEFUQXJQ?=
 =?utf-8?B?YkhMalIwa3lYQ2FFakU4V2VKYzFua3NxOHpMNlJNSFZYNWdYVzdFbkxMQWd1?=
 =?utf-8?B?VzlzajlETG1wdXJwM24xdWVzVkpXaVJXVWtrNTJxTVNDUWJlZ3F4MWkyVE9n?=
 =?utf-8?B?QU1rRnVoWVNBbFNCSnYyWnErNnM3ZUFyVkJTNTlENWlkUGlxRzlJRHpkdjEy?=
 =?utf-8?B?cVR5eEdyL1ppLzA1S0RhNU5FUnlJMk12Z3F1amZFY0FvU0ptZEZsbzNGMVkw?=
 =?utf-8?B?dWJtZVBZVjNFaEE5RUIyaWJLOGZJN1hkbFhiK0dpQ2RFNlRxRzRhVjM2N0pV?=
 =?utf-8?B?c2dxU3I0cWxvNklUTGZmM1hrRWJkOXdLOEJNYnpXQlNIRjZhMTZFQ0tEYTRD?=
 =?utf-8?B?Mk5aZDNRcFpTUWgyTUVQVE1MdVpnYnV4cVY3aUlVVWxDOC9WUHhSOHhnOENS?=
 =?utf-8?B?cFZUZmdCaE5rNkdST2NqWVJ1YXBGQnNZblQxOEh2Nmt3WTloOEhTNnhkejZZ?=
 =?utf-8?B?UElIcnlSQjJFd2J6T2JZOHN0ZlFMM0p3Wk1LQWpnQ1Y3WUNnRlNQcU8zNnZS?=
 =?utf-8?B?RnB0alRVTCt3b1FUUUk5VFg2QWp3QVo1enRtakVPNldrbXBvY0piM21oQ0Vy?=
 =?utf-8?B?cmtFY2J5TjlwbE02N1VQdVp1RGRxS2ZKdXQwaW44Uk8wTUFRV0dUbjIrVmFF?=
 =?utf-8?B?dHF6Nlpsd3FiYWhvUnRPWkNOY04vOUYrZWd5aXhvODYra1dCY2VGaDF3TEZT?=
 =?utf-8?B?OStZQ0dYdHllNmRBV1R5S09hTnZjM0orY3JXYURkMTV6ZDh3KzdsZmtXZlNO?=
 =?utf-8?Q?rzZ6taHxONIXk1kgqM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q1JQVlh4MkZKY0JBV0E4WEdNc3lKZTJNVTB4SHA2RHk2NmZNRmo4akY1M0Na?=
 =?utf-8?B?Uk5Lb2JzMTkrYTZLMmlIL0hUZjc1MU05Uk1Md1o5aFBBVjRPdjdHNEhMczho?=
 =?utf-8?B?TjdaTnl3Sk1qYVRrREtFTXFRVWZWZzdLVHNHS0tyTFo4bnU5dTVkbEcwdEty?=
 =?utf-8?B?eUlpaU1QeTdqdUF1Tm0wMVhBTVRTbmgyL2Vlb2JPQXVaM3BRRVlsOUp3MjBk?=
 =?utf-8?B?Mm1WYWU3OFpYV0tPRzdqT0pKSVY1R3ZaVjFLOEhMRERDM1FrZlRPa2E5WFhS?=
 =?utf-8?B?ZWNmOERoM1dJRW1EK3BoU256OXViUDhQOFBpWFJqVTE0RVM4NnN0cEZsczlr?=
 =?utf-8?B?Zjd0OTVGMWdHVVJlYTJ5T0hEODZONU9mUzdUTWpxdTRYdlBvUEErTGM3UHVs?=
 =?utf-8?B?UjFUTUpjRkQyWGtFK0hFdTlwazVTYVNuVm9yUS93R3E4ZVl3T28xaUE1b3cr?=
 =?utf-8?B?enhlTzA2NlVkZmhtRWJ5Vm9xUDNma0ZQMTZXZTFpVVovWTRqdGNIanJTUFU4?=
 =?utf-8?B?Q0NCUUJkZ1B1ZU1pc3pnZUI5VXpkbmNrUllqRndFMjRqdmdQdmVHZy9oMjNn?=
 =?utf-8?B?ZGlGbVpkZHJxRkpSa3JxWlFVcmpSVzl1MkZoMmxJQjVmQnJlcDEzZEdSNlo3?=
 =?utf-8?B?alZCRFYwT0hibjdJV2JCa0liYk9paWsxMEl4eHYxNi92d2dFcE82N1RGelM2?=
 =?utf-8?B?eUhONU16aWRXbWl5U3ptRi93ek4wc29VUGw4U0pCTnJMQktIMUpEUEVKditH?=
 =?utf-8?B?REF6YUFXQ3p6VVZQTHpvNTVXZWpMVnlpMFBXb3B5MUtrcnBWZTFtaDlHRU1t?=
 =?utf-8?B?MWNMZGRTd2JoaDYxTEpBeVRJUW1BTVc4czdDeWtvMnRkakhPbE5mWGFFc2xr?=
 =?utf-8?B?MFdsVm44TDFna0h2T1ZtenJaOGNnMTNTK01SNnhsQ0RRS2dXRkpVMjdQWERt?=
 =?utf-8?B?UVJnUFc0MlNKQjJEdGFPM2U4M1QwNFpwQUdMWG9Wd3VXS0tWOHY3Mlg5UVFj?=
 =?utf-8?B?clE2YlZ4UVhNMEF6dWdwN1VUdzFhMjEzTlh4QWhyYWR0aDhJU01xd3dhSC9z?=
 =?utf-8?B?N3ViNXdRNXlDRERqNlhQTmhOc2x0d3d6dGlpWVBWTGo5YTg2aVlwZHJEVkNC?=
 =?utf-8?B?MDNqVXBheFNsUnphL1FXNkFEcHgwNlNBd2hXWTF0UHlxNXZ0UzRLVXEweHNz?=
 =?utf-8?B?STBLVUI3RlEyL2pYRGdraXR4MFdiUHNiWDJkRkJkYTY1OXFDQzJic3QxSnk5?=
 =?utf-8?B?TzdmRDJ3Wm1QUVhpU3F3dGV0ZUpEdFl5YU5GQnl6N2x5aDRTTExCVzdjVDNH?=
 =?utf-8?B?bE16UWl4QTZ1OGhMQTV0UWVzQ1YvOWpCa3Y4SE9tRVJEZlZia0s0b2lmN1Vn?=
 =?utf-8?B?UHhsSkN0OURNRGJoVlBjMFBHQXN5T3hkd1lXanVOQnBjQkEwSlp0eHFEOWQx?=
 =?utf-8?B?S1o0dEJKVTd0bXRoalFUSVVnMHJuN2tJaWRqckl4ejFzWXhMelZpRno2aEd2?=
 =?utf-8?B?eklWOFNodm9tSXU1cGVxMDgydzBtMSs5dHRTM2VYOHJNWGw0d1JVNko4Nkho?=
 =?utf-8?B?dWFacmgwNzVsWW9IblkvWk04bmNaS09GSUNHd052RmwySXRzUmZjQlZySkVV?=
 =?utf-8?B?NTlCSGwvSXdsOXFhUlFPNUt3ZEtlZ1hvQUNGRUhHWkRTYzVPQWp3bGlJNFNZ?=
 =?utf-8?B?YlRzZXhDUldvaVduRER1cjA1RXpIaWdmY2dsQlFDUnpiTUpvbm5neVhEYkt3?=
 =?utf-8?B?QnB5bnNucmZGSU42T2R6T3lGMGk3Yk5HNVAwdXpJNENKK2dqRDZyajZxTHJX?=
 =?utf-8?B?Skk1a1QxVkszT2tsZmFXcXRuTzZaVWJUQWx6eTJDcnE1Q3hOL0VLR09Jd1hk?=
 =?utf-8?B?SGpSOGk2KzB5ZWRvN2NjcTRwZVB3Z1BGU2o3aXUxZ2kwenVJa0ZnaUZqQ3Nq?=
 =?utf-8?B?OVF0MUJKMVdQSGtmVWtzZFFxeDNPWkgrZmFIenpvcDQxRzdnOFBRbHhTQmVs?=
 =?utf-8?B?REFod2JVdmZlVEU4UFRHcmZNK09aM3ZXVXo5d1U3NHhKa2lTeWhZRUVlczR4?=
 =?utf-8?B?MnRadXBtd3hmdzdqNTJ1TkQvZWNPUU12L3Vxay9GRlVOUFRLcm1yai94RTdp?=
 =?utf-8?B?UjNVM0xWaU92QnFOcGlacWlFNUVLbWlMV3hRcXNpMmRWWGprNDlNTWdEQmpE?=
 =?utf-8?B?QlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a0bc732e-4a12-474d-7c55-08dcc1f6b060
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 15:34:04.6299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+bW4UMdX8ssEeMKhUuj2kS6GsIna2QCFTQ2b3SImrs+wd+IumsNwk8cpB3HVwpaviu5OtDgPGNclm92ltbNiJtTXBOibLZqkvKk+nQZgpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8279
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 21 Aug 2024 15:34:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/542

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

Ok, so I had leftovers from previous debugging sessions where I had an 
old version of weston (10.0.2) instead of the one from Scarthgap 
(13.0.x). Note that the color is off (red on RK3399, "negative"-like 
filter on PX30) when using weston from Scarthgap. This is apparently a 
known issue, c.f. 
https://gitlab.freedesktop.org/wayland/weston/-/issues/839. Note that 
Robert said it would be fixed in gstreamer 1.22 but the linked patch 
only made it to 1.23 (Scarthgap has 1.22, Styhead 1.24).

With Styhead, RK3399 and PX30 are working fine with weston. Considering 
what Robert said in the link above, I assume people using another 
compositor than weston may be fine on Scarthgap, so I would suggest to 
backport the patches I submitted in this series to scarthgap anyway? One 
is not forced to use weston to do VPU decoding.
FYI, I gave ~30min at backporting the gstreamer patches to 1.22.11 but 
this is above my skill set today.

Cheers,
Quentin

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
> [1] https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/5676
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Quentin Schulz (9):
>        gstreamer-plugins-bad: build v4l2codecs if SoC has a VPU
>        px30: enable gstreamer v4l2codecs support
>        rk3399: enable gstreamer v4l2codecs support
>        rk3066: enable gstreamer v4l2codecs support
>        rk3188: enable gstreamer v4l2codecs support
>        rk3288: enable gstreamer v4l2codecs support
>        rk3328: enable gstreamer v4l2codecs support
>        rk356x: enable gstreamer v4l2codecs support
>        rk3588(s): enable gstreamer v4l2codecs support
> 
>   conf/machine/include/px30.inc                                    | 2 ++
>   conf/machine/include/rk3066.inc                                  | 2 ++
>   conf/machine/include/rk3188.inc                                  | 2 ++
>   conf/machine/include/rk3288.inc                                  | 2 ++
>   conf/machine/include/rk3328.inc                                  | 2 ++
>   conf/machine/include/rk3399.inc                                  | 2 ++
>   conf/machine/include/rk3566.inc                                  | 2 ++
>   conf/machine/include/rk3568.inc                                  | 2 ++
>   conf/machine/include/rk3588s.inc                                 | 2 ++
>   recipes-multimedia/gstreamer/gstreamer1.0-plugins-bad_%.bbappend | 1 +
>   10 files changed, 19 insertions(+)
> ---
> base-commit: d9566c54b72fd83f1a953fb691ad61f1144544a6
> change-id: 20240813-gst-hantro-be7a2abd839f
> 
> Best regards,

