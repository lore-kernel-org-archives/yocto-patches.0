Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51866C27C5E
	for <webhook@archiver.kernel.org>; Tue, 11 Jun 2024 13:56:57 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.135])
 by mx.groups.io with SMTP id smtpd.web10.10259.1718114209674817067
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Jun 2024 06:56:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=a8JQsOXw;
 spf=pass (domain: cherry.de, ip: 40.107.103.135, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KaQiM2kqx09r/PGnNq9OMihiAL1HQeClw2sHFOkhuQ/tppjnX79zWSgyMDw39kXXfIlQ0WlXjN6MWZ6fHDcbzezwD5jH/zDphqY0c/bZUX3y4hN9XAXC4vY7DERLiDpRaOk2WTuMBcDLkthib9jMyOgX77cKDxd9CQEQW/PfkMjuSI869NLG8zcWpv48rJXroffBINQgiJPWOiP7qovYzUHVp/D1eRZaWrnp/M4UegkNtUr+I4oLziIsa1E2icAT4lbUn++MTpCQ8LSgxEg9NDogpnKBo0j2trVLD68TefGszj84+F474HjcGvGOllzgVXMmz/B2rTxqMzczJo202w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrHjfGfOIAYbQSo+LZDhnHSUS98TJf0zZx4bMCwLFuo=;
 b=k/RZlImr1P7r8jJAcXarZg3fwOHJ5frnHwoIqbbzuyBZ64+Gk0QdYnq+PTwa/ewwQUuAvN0YPNA0hfV/wMw2pblPV/3CWbkxfV7CrwAkOjQ25fKCFflt2NaPOkrELG0O45GCB2lu2xeTTmzSSJo5MDQoWjUB/qKEq8NZaZTuoDbViwuN7Fkmh8LhEuMfd6rsGjkkfK9bpPXHd4u2iRHmg8zB5ZK6AjKj0y5UJ3JbpUOnlAMUab6TcAl5s4z97To6m3gc1aIXSusdVsgyZ8tCFs33HWAoPFOsWQLqc9ssAaPq/pLpZNu4c9pIPesEfgSCwWmdNbtDXuL30lG79I4GSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrHjfGfOIAYbQSo+LZDhnHSUS98TJf0zZx4bMCwLFuo=;
 b=a8JQsOXwPx7uTgfDxpSLupxq83Ech3ScSR/QMoPviJS6QKoh+h8j/OjxVBIFuxDJHldLxSmHdIm3j8AcBtT8nqtf3WAZE4pzJoced8GhAWMpyF5m9BdKqMo8V+LS1tImONrw1ETQEHuBDN9TGyuBJC0rXCryvbYkZ2VumySqWGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by GVXPR04MB9780.eurprd04.prod.outlook.com (2603:10a6:150:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 13:56:43 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 13:56:43 +0000
Message-ID: <52599949-2e68-4ef8-af93-c49df56008a3@cherry.de>
Date: Tue, 11 Jun 2024 15:56:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH meta-rockchip RFC 0/2] add support for
 Panthor
To: Trevor Woerner <twoerner@gmail.com>, yocto-patches@lists.yoctoproject.org
References: <20240531-mesa-panthor-v1-0-8cfb4d17ad3a@cherry.de>
 <20240611134313.GB39107@localhost>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240611134313.GB39107@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: WA1P291CA0017.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::17) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|GVXPR04MB9780:EE_
X-MS-Office365-Filtering-Correlation-Id: 4068e3a2-bb00-43d3-8d9a-08dc8a1e537b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OXBvNTc2Q0tJbC80QW1UbWNEdFdNZGFsM05BckdIQ0cyL1dXZ0dPUUdRS0hL?=
 =?utf-8?B?SXd1dW1VM08xNTRnd296bUd6U2RlaHB1Wk52bkluQTdQTURKWWJJVXNzUXhE?=
 =?utf-8?B?YU0xckQ2RVg1cnMxaEZYR3NKcjdldG02OTdMWlJxaDlHeDN4Y01JUFNZYnIv?=
 =?utf-8?B?ZWhQUnozK29CZDVMQlNGa2F0bnA1M1dGTGhITk1tcjE5T0NPVGxGOElvODlX?=
 =?utf-8?B?Q3FMaGIxRGRMb2Y4RVpwZjNKL0FXRGh5aDVjd1J1MStsV3M5RHZIU2IxQXNI?=
 =?utf-8?B?a0FyZEUydUl4ckQ3Qk1taUZNU1pVQkUvMUI5akFUUkwrRzlTV1RXK1VSc01p?=
 =?utf-8?B?WUxHcWczWCtScGYwSzBWZ1ZHZTlyd2dwejNFd3VJSWE1ODN5QVhvc0J5K3ZD?=
 =?utf-8?B?MzRjcUU3TnozcnZlRXR0Q2ZoWEdmV3hYbkpuRm9HUDdxVXQ3alZZcG9xWElM?=
 =?utf-8?B?RXZRcnRESmlSNUdiUVBMd1hGNXRhd2JLTFBNODJVQWJKWEVra2ZmRzVBWTNP?=
 =?utf-8?B?Q0FmTk9WZ2IwVlZmU3BqM1FmRmFkVGlNZVEwZmxzdkxxVWxIZTJXWS9tdFhZ?=
 =?utf-8?B?aThXSTdyMEtDek9Ud1ZpT3NiUi9lWEZhOU5wVmhueXhHQ2g1eGt6NFNTY3h3?=
 =?utf-8?B?L2xjVzY3eWZCM1lMU1FvUnBoUW9HaFMydTBwQ3U2ZEZlOXR4RmhZcGlSb1Ir?=
 =?utf-8?B?cytSdWJLR2NERE5maXdid0Y3ZFN4WkVaQndCbEswcnNXZVRDTG5FYUx4WWh5?=
 =?utf-8?B?dE9vUk5jdHdTWjNHSGFnb082OGxJdEtDQk0zNFRoNHE4blF0WVJOV3JiejMr?=
 =?utf-8?B?dVdEaE1IUytybWRjdEhKNVQyaU1jZGpFWm9iaXBKZGFPQUlvR3Q1SDIzK3ZB?=
 =?utf-8?B?OVBMRkFvYVk2Vi9DazNVcVFkbTRBdzdDUXlTWllRMjNEQXRYMmROOVZlTjdE?=
 =?utf-8?B?akN3S2R1Qi9pZjdQWERFQlF2cG9ycSsyNEh6cUdmOU1KeVJYNG5nUVcyeWlM?=
 =?utf-8?B?ZXV0K0pPbTBjQWtRbkF1V1k1bGpSU0RmK3ZzcFZqWkJVTGxVWi9JWnJRa21W?=
 =?utf-8?B?YlNWc0JFVCt6cGRCeXFiYU9vZ2V3RkVKYk9jUmQxckg2Rmt4ZkZERHlROXl1?=
 =?utf-8?B?eUsrYmE4b2Rna1NIWlB0L3NrN2lwNER3QjNIbVA5bXRDY2hGSW14NE1TdGhB?=
 =?utf-8?B?THRDbkh1ZkY5Mkk0aVdCMDJJZXVQd0pMRjdpY29KVFFyN3p0MEtiRVliRFNV?=
 =?utf-8?B?b3I1ZTF6c0xDRFZqVEdUakU2Q0NQVE9Rak1FOW85blY3dVVJcVdKRTZBTU50?=
 =?utf-8?B?Tjl6U2RBenAvQ2J3dnU3cGxNRVY1V3pHcEJTTHZHQjFZQTJ2M0g5OHJpbURz?=
 =?utf-8?B?TkVPdFM0dTRLK3lSQzhjZUlSWVhvdklxNjBLTGhYRFRtdWFkQnhzMUhFVGJ0?=
 =?utf-8?B?bzJJYldoTVczYTRxNFJJTFdKdzJzN2FBRlRIRWgrZGZENHJOaTE5dnp0UjJO?=
 =?utf-8?B?cXBSa25vWWpyTWZ4OVlMeVNuZFRyZk5pSWw4bW0rM05wbFBvamtLR0RSS2cx?=
 =?utf-8?B?K2hrcVBZMm9xQlo4ZmgxYXQxYlo3S0MxZU51cE5TYVo5bDBBTU5HTW9CMDQ3?=
 =?utf-8?B?Tk85cElUclJoYlRwY0J2Z3J0a1pDWXRIenBudzZESHFiZ2dxTXRjQzIwdDJY?=
 =?utf-8?Q?UKNkupNZShYxqRc308K/?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ODFCWUFMaUxIcVdBM0VQamd6K3VlblZHdmpRUXgxb2NaRkF6Q0pFMEJkaEJL?=
 =?utf-8?B?ZUVzcTRGN3pNNUY0c0RYdEs0a3oyTzF2ZEhQTU1MQW5JQkR0VUNxdUlKWElX?=
 =?utf-8?B?MDZZOTMveWZ6a3Fub1plTWJKRFh0N0VBcGJhTkRZV0g4R01nYUh5eTRENkxl?=
 =?utf-8?B?MkZkNzJ1V2NwYUV1K0pvMk5kL0cxOFZqc1oySEQ2aVNYYkpUTHF6MUN4bzB0?=
 =?utf-8?B?cFhMczBIQ0RMdnFxMWw2cHg3RGlOeVhpbXI5TGE3OWhBTWNqNlZLcit6NnFw?=
 =?utf-8?B?dDlXQ3pEbG5PaTRxRlVycUhzQm15RC83WTNLT2ExTFBnTTdpc0JEM2VUL3Q3?=
 =?utf-8?B?emNQbjc0OHJtcVB1U3VwdVlHQ2RXdFdVWmI4SW0wbE5VK0JHZnkxRC9zajVJ?=
 =?utf-8?B?eFYrcDhRVkQ5MGI1NDkxNzk3aXl0ZnZOcXFhNE4rUUhJWjZYNWgzYndrWVlv?=
 =?utf-8?B?cGlRU2tYbzhqM3NBMjVvbzZrSFc2SFNqNTRLMXRkNmZRNFZPNXFkTkNYV1F6?=
 =?utf-8?B?YXEzMlBjMU85R2FHQXljUzlMc095QlRPSDZacXo3dkZQOU1sSWJzNStEVXUr?=
 =?utf-8?B?MXB3NU1rQzA4UkpMdDZIMUNLNitCWUdzbnBwVXFUVXlrWG1tNnFXY1hzVHh0?=
 =?utf-8?B?MnErbmFsME5tNlBFQ0JrM2NOUHBoS250NEtzZ0xlWVFmejdzRi9kU1pQemlw?=
 =?utf-8?B?YldZMUJuZGFiSU9TMmdXTVVuZTVLamFsVU1FcFNvdkZGM1NXRWJhTjkzNGFo?=
 =?utf-8?B?TFNvNTEwR0xRMUVwMTBCbW5ncTNSS3FOT05MVCtKZDI3R1FXTTZuWDE4MHNx?=
 =?utf-8?B?Q3V6T1p2VGRpTmliTmZ4MVJpOUFad2VaNGtpWnAwR2F0VFVYK0R4bVVNakNX?=
 =?utf-8?B?dWcvelEzMlkwcnk2Tk5idGg4WFQ2cU9mN2FuajJoekViTGMxZCtxOW40eEZy?=
 =?utf-8?B?L1kyUmpMTVVCd0hMREJTZFJERW5ESlhmdC8wQ0tMbnZtMGZNb3FpVDVGc1Vw?=
 =?utf-8?B?M1g0WXM2VTRGcXZadk42M1BMekplanc0ME9STnRLZ1cvcXpNSk1RT1FvRnhW?=
 =?utf-8?B?L3g3WlVQcXlHeFBTRVJxbDNJV0MwaFR2aFpyR2VNM01rcWZjSVNQd0grMzM2?=
 =?utf-8?B?NVJoTXdLbk5tYXpsb2RMNi9Jd2MvWjlKNk9CRkFBZnNnMVVmbDB4UW4zYy9z?=
 =?utf-8?B?L2NybFlCTjFPd2RZdWNYRGRtKzZxQUYrOTVSRDBpemtZOVA3di9JbGZHTGQy?=
 =?utf-8?B?TUN1akJ5dmlET2FjcmtPV2RPMlBzY1VpZ09vZGFoaTZPOUVsY1U3SzhxaXBn?=
 =?utf-8?B?MVBKWGhOcy90WmYvdlJYOVVyY2xSSFhjN213bVdCQzkydmV5SVgwTWgrOTdn?=
 =?utf-8?B?MWIwTU85OHVkbmhCQmVBc0krWWxlaEp6bTVER1N6cjIxNkI0MU5xRnVWc091?=
 =?utf-8?B?Ym51SU5MRjJnWFV2QmxEZGo4UC80d0dJNm9seWMzUjVBaVpCSlhUREZTOWxH?=
 =?utf-8?B?UEI5aEtEU1pFUGJoaGpFY2hTY0QzTTBRV3gvUWNvR055OGNlV2Znc25PZzZ5?=
 =?utf-8?B?KzBmQ3NXNS9vbjlnWWVqU0I1anczQVJNY2p3N1VkdGVFWTVhWC9TOG9CZ01m?=
 =?utf-8?B?SGE3NWNZaUdhbUxwTHRmZVMybXdUSkdkbXpsRk04TUF2cnh6bjFwejJuSTZV?=
 =?utf-8?B?NlFFYU9uQmEwS3MxZElrclhtOTRTUEJRZEdtbUxFeXFlM1RnTGR5S0JzTjFR?=
 =?utf-8?B?aHFidkRCZ1FpRjhoVk1mbTJjVnZORFZwZHo0emFPTDV1RFNlazRIMy9jOFRX?=
 =?utf-8?B?T0wrOUd5MkZhZlVFUDljTFFaMkpSbEFjemcwRU9FOGlPZEhZWVJDeDBKSGhZ?=
 =?utf-8?B?ODdTK0NXVENjOFdxeTFkN3hsZEVHR0p0Q0JNZ0hBeUU1UHJlZ0VjNHZjckg1?=
 =?utf-8?B?bkpoUlc1UnozMmZLQzVWWHQ4R0F3TnZLNmZ4c1BieEJrSUp0Q0hLTkl2azlX?=
 =?utf-8?B?MnA4RVdWWFkrYStRZml6cXp2Wjl6dVBEUnNQUjlVLzNKMjllR2ROQlRFWG5N?=
 =?utf-8?B?UzRqQjEwaXgwYlpyY0ZUb1dpaVdqZm5iWGJjdXo1RS95ZUFsZjYyVjI0YzhK?=
 =?utf-8?B?b1h1cmVmM1hucFNITDJiWXluZ2JzSzYzelcwam5NdHBZSXR1THJXRUZZUW9T?=
 =?utf-8?B?Q2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4068e3a2-bb00-43d3-8d9a-08dc8a1e537b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 13:56:43.5172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PF4KMRKazTMl86JnMA/+1PC9DaXPpm8TwhuMvC94Q/vV01yi0ZysxGO6CdSwTKSK0UEAA8jQJv3hLg3dkciaphWw3CTAn1638MZalDyBOFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9780
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Jun 2024 13:56:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/297

Hi Trevor,

On 6/11/24 3:43 PM, Trevor Woerner wrote:
> On Fri 2024-05-31 @ 05:30:24 PM, Quentin Schulz via lists.yoctoproject.org wrote:
>> Panthor is the open-source implementation for the Arm GPU Valhall series
>> both in the Linux kernel and Mesa userspace. In the latter, the panfrost
>> "driver" is actually handling this version of the Arm GPU. One therefore
>> needs to enable kmsro and panfrost in PACKAGECONFIG to be able to use
>> this open-source implementation.
>>
>> The open-source implementation still requires a proprietary blob which
>> is running on the GPU: mali_csffw.bin. Note that the closed-source
>> implementation (libmali and vendor kernel drivers) also require this
>> blob.
>>
>> Right now, we're still missing a linux-yocto v6.10+ to be able to test
>> this with everything upstream in Yocto/OE, but I was able to
>> successfully test this with kmscube on a downstream kernel (6.6 +
>> backported patches for GPU and custom patches for DSI support) on an
>> RK3588 Tiger.
>>
>> Additionally, the following patch series is required from OE-Core:
>> https://lore.kernel.org/openembedded-core/20240531-panthor-v1-0-1a76fd752c1b@cherry.de/T/#t
> 
> I would prefer to commit a working patch rather than pieces.
> 
> I.e. if you want to add the necessary patches indicated above into
> meta-rockchip so that a working image can be generated without any additional
> dependencies on other layers.
> 
> Would that be possible?

Yes, but I don't want to :)

Basically, this was just if someone wanted to tinker before it was 
merged into OE-Core.

I don't think it makes sense to add the necessary patches/bbappends in 
meta-rockchip for the master branch, it's duplicating efforts. However, 
I plan on backporting the mesa recipe to scarthgap once it's merged 
upstream, that would probably have its place in meta-rockchip (and if 
not, I'll have it in my layer anyway :) ).

The issue right now is that the mesa bump is just not something I can 
achieve without substantial effort as I know nothing about meson, mesa 
and graphical stuff and the issues I encountered were a bit too hairy 
for me :/ I hope someone can have a look at it, but for now I'll have to 
stop here. I will likely have to do this by the end of the 
year/beginning of next year when we migrate our customer base to 
upstream kernel, but I hope that we'll have this bumped by someone else 
before.

Basically, you can ignore this until I send another version :)

Cheers,
Quentin

