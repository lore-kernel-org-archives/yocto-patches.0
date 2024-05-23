Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300AEC25B75
	for <webhook@archiver.kernel.org>; Thu, 23 May 2024 12:54:11 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.135])
 by mx.groups.io with SMTP id smtpd.web10.14596.1716468841396694240
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 23 May 2024 05:54:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=bo+YmW/N;
 spf=pass (domain: cherry.de, ip: 40.107.7.135, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oduDHnLCF/qWPWhSmLQRq2Agr/0Uad1+ECsbIh5RJ9taWkBh++Qm4oMgLVMSiyhLfSXtU9QVMG4pJe1bIK1vnBHpZOXaOUy4fC5XwAh2BIoqzBV98BuCrhFtOcoZ/O9fFv9wd1ghVvDepwn1tfpoa0FhffWUGOcn+28NX0RYe1eK0O2+uU7AnBqpRUelI46NuFp/5s3UnSY3LzeDVH5oricm2KWwDTqLVM9QQPEu/Hs/nfjX50b+rto27vF04wLGBusUnlTC6qFr1IBHyxRuHjspiHneQtYzvktBvB0734UkVY7sIojb2Wr07mmCOBY2buADUB6BiDH2UFsfesb9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiHzFAaPXERXBKAKy73bTkiAxwBHSALcW/n1P2X7y18=;
 b=f8UHCJLhloi9ovqjjgQ5SIYgPztBZtvO+rhK/zxKbulOedVVYW53tarN38mNFV6O7Ac9q+IXG/6m3uJM5PL1sfRk379jlMJ4SXtpda70D3w9xq64nHmxS3P/LgB+uRECs7IWjxNevCJvklAE3WMbWKwvEQq41aGG6CFjg3m/uOB99IoHaho9HR+BOkj+8+OHTFvOQ3YhvGg9PckHIuZg+X9wK/k4IoVtJ8821yyjF8IovaQZJinDaLZVF3y+jVykb+FoWSc+iKdyEoMKBUTNIt3CGWETDkdZRaP4a6CJmpdcw3bouzFEMKQoMOR0foe9nOSMqW8jzbuAZUwx+MN+Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiHzFAaPXERXBKAKy73bTkiAxwBHSALcW/n1P2X7y18=;
 b=bo+YmW/NuGJTaRrYH01N23NsV7sMQ8MMpbi1uhuiM2I2URuxF+BEC+GsJGG1XyxxocO128u9pEBjKxbzinXD5TIMQYHDlq+3yzI+0ff60jxPS4qIFnyEZNtYbdgfchph0z8t03+D8WVDo0U1F1rprmPZCtak/VM5U3Hm+cSfuX0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM0PR04MB6578.eurprd04.prod.outlook.com (2603:10a6:208:16e::11)
 by DBBPR04MB7916.eurprd04.prod.outlook.com (2603:10a6:10:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 12:53:56 +0000
Received: from AM0PR04MB6578.eurprd04.prod.outlook.com
 ([fe80::b0f9:e7f8:2613:eefd]) by AM0PR04MB6578.eurprd04.prod.outlook.com
 ([fe80::b0f9:e7f8:2613:eefd%3]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 12:53:56 +0000
Message-ID: <87a55431-aad6-44e5-a897-2b98f9bc77d2@cherry.de>
Date: Thu, 23 May 2024 14:53:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH 4/4] rauc demo: add
To: yocto-patches@lists.yoctoproject.org
References: <20240522230808.14409-1-twoerner@gmail.com>
 <20240522230808.14409-4-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240522230808.14409-4-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0016.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::27) To AM0PR04MB6578.eurprd04.prod.outlook.com
 (2603:10a6:208:16e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6578:EE_|DBBPR04MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: b494199f-556a-4b5e-e2bd-08dc7b276851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eXdFNytWZFoyaFFSUG9TVjhhaElhTnhvNjJ6Tzh1cWh0a3lqZEpmTVFlUllF?=
 =?utf-8?B?ODJLU01VZjIvM1FqS0o4bVh6eDN1Qk8xcGNTY3NCaDZRYnI1TU5ucEx0bXVx?=
 =?utf-8?B?eUgyVFo4bWgyNWgzUzFQVE5FaU51elJyUTlIMHI0OHlQcjVOT0tiY2RLM3pm?=
 =?utf-8?B?bmErRXVQd0VuWUZoY3FCSnJtWVArRHdKaXRRMUl4bjk1Z1o1bzc5dEhDd1Vo?=
 =?utf-8?B?TzVaVnBJa0JhVTdyMnNvU0FaTmdQUzVSQ3NWOTF5YmpNeGZJek5PQmh1bTdQ?=
 =?utf-8?B?MWFHMzBGa2hCdHZKT1FTSWFTOVJjMHhQek9KYy9UMHQvajlmcDBvUVB1dkdy?=
 =?utf-8?B?dE9odStSLzc4ODdObitkVm82ZHpsZE9xTVNtRGx3WWJDTHVReGpkelVqVldX?=
 =?utf-8?B?cEp5UEFILzF5bWppN2hZc0RWcW9wcURYTFFzd2c3RUR2SFJqaDBHUDZOS2NK?=
 =?utf-8?B?eDFxNnRwcjBJVWdWT01BSW5uNWZ6Lzh5SDlTd09uMXRvRk5lbTVCYU9GUi9m?=
 =?utf-8?B?cUxBcUhjTGpwTFpjdFdieWxkVUxzSWN5RTVLUTZGaHdmY1EyaUtjbDQyS1Iv?=
 =?utf-8?B?UW9XUUFtUllUaHBDNEJPck84aHBRd1lPMjJaMVpwNGNLR2ZOQkRHcXV3ZGp3?=
 =?utf-8?B?SWM4M0dma0c4MlpRZnhUanp0TXF3Zkl4cHhwRXh4bDc5aUFKVFUzUHNqZG9M?=
 =?utf-8?B?YWIyRGFQLzUyb3A4b1BlYVVKVnB6T1M1OWdqVTZNNDB5NVRQTEJQb1NHc2Za?=
 =?utf-8?B?RXhoYldiUDhMVFF1TmxodlJGMWs4cmJreXd0K05CVkdEdnF1b2l6aHNBemhZ?=
 =?utf-8?B?TndvT3FYdVhLNVJqa2VFeDQ4NWJRa0xORnhJRE1NeEdTcjJKRVkzY1dPQkVW?=
 =?utf-8?B?bjFIa21rVC9nWFIvOWlNMmNURzY5QWZBOE9SbnBNTk1qdHUzZnVFMjFYeFhG?=
 =?utf-8?B?VDNtZ2s3WHk5SlAzek1uN3ordzJqSzJIVElMcERFNURpanJzZlRvckxRalk2?=
 =?utf-8?B?eHNIa1hyL0dmd1RVTWoyaVljTnE0RWR2RXZHZTBteXVmRkJaQ2dzdW51TTZB?=
 =?utf-8?B?MHp5U09NZFpsMVBIbTdlQllHNzYveU9yMEROSlF0TkhTOFhpTmgvRjNjSXpX?=
 =?utf-8?B?eWI2V2dsRnRybmF6QTI4bXJ1d0hQRElBcDNNVENmZkFUcGtjL2MvajRRZWFw?=
 =?utf-8?B?TXNtU3BlMlQ0ckJDQVF4b1ptcVMyWkpYTERXRjUrWUlJQ3Y2ckd6Z1A3cHd3?=
 =?utf-8?B?VWozOWR3SEkwLzFjMVJXa29tbENXYjZwZW4yNFFWdzhpUU5BTDVadXQ4L0t1?=
 =?utf-8?B?WVZaQXZ3bHh5cG1XODlXalVGaHQwVzFsWkZ4RThDa1FBdE9ReVpGWXlXTW5x?=
 =?utf-8?B?K0ZaWmhuMVF5blJFSEV6dzkwbVVRWVRHRmxuOTlXbkR0SExqYmhCemlCa0VO?=
 =?utf-8?B?UmVoMHlHWWdjTmM4d0ZTV21UclJYbjhIQ1Brd1N0K3Y2VVd6MG1HZXEyc1pK?=
 =?utf-8?B?V01lUEptUDQyTk5tMGg0b3FveDJrVHprb2pIMHhydWZXMkZsUmJFSnNIdGFH?=
 =?utf-8?B?Z0pQT3BmQXpCT3BlL2pMY2lEaFNMUWFxQi9pbVY0OENTamFuM0p0V1hqUktR?=
 =?utf-8?Q?AFUKQhuDR+4CAStX4ee8MaQPHKNAaVhKLZF8FfzGTj3s=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6578.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V1hrZTdjTE55NXlyS3BvRFgwbGlWRDBrSHRLdUZQQVFOVXBJOFU3OUwvdUtD?=
 =?utf-8?B?dGh5ai9Eb1ZGT216MmZ2T3pWVlMzQTZ3Z2lkTmxxKzUxcExDaTNHRUk1ZU9t?=
 =?utf-8?B?KzZOaWVITGFhQllFUEtRZk5mbEhqamdObU1wZC96VlJhTnhOR1ZBbm1tZDJl?=
 =?utf-8?B?Y04vdFMyMG04TzErbUVBcXFJeDI3djN1VnNsY0FRQkpFZkliWFJDaDFnVTZE?=
 =?utf-8?B?UnlZTjgxNGlZWDlqTTJCOThna3pQY3dJc1hhaTBLclRrRmUyZ0NjMWVvZ0Fu?=
 =?utf-8?B?YXJLbms4Z1Q5aHN3NStpMzRpR0ZQd1ppenpscjAzMGxEdWVQUTdjZm43dmFN?=
 =?utf-8?B?Vm9Da0tHbW83S1ZXS05zUU9PVmFqYy8xL28zbkt6MmpCdUtONzljZ3AvKzhw?=
 =?utf-8?B?SE9ZRGlaTWcvSDVSN3pvbElRNmp5RVI1TlRvNERCUmd3WERoUUhwY3drYnV5?=
 =?utf-8?B?NDBLeWJNMVRjSTJnOTB0cm1QcU1STDlXS2QvNDRxOTJSM0RCNVluanJ0eG9T?=
 =?utf-8?B?d1ZDYy82MXBZK1JmUW1vUmMzb01sV1dXVlVyN1dYZVdCZU1xSWVVVVpEWjRn?=
 =?utf-8?B?RUFOVG9mRnFTL055ekorNkFCdDU2ZFhaZGlLMjFYVFIzeXI4SzNHYmFKR1JS?=
 =?utf-8?B?cCswcDJsUGw5bHovWGZQSzhSS0lCYnpwbkhONmFGYmdmMk83MU5IZmhETEVF?=
 =?utf-8?B?aVUvN3RYa29VQzJIcXJQVE1nRitMSEtaaURJUTVJNTY1SU1DdENLa1N1S0ZE?=
 =?utf-8?B?M21xclJUeUtlRWVIMGJHYXlReStGblorbUtlcVN6MmhqWTBDSFVYRENzVTZK?=
 =?utf-8?B?V2x5TGkyWi80eEFXNXdvcE5Cd0U2ejdXVVU1WnZsSmNUaWdZSXNNYTh3ODQr?=
 =?utf-8?B?ekdKbFJlZE1ybExEWHhTYmt2bzZSNWRlemswdXlTQlc1ejdsa1NuVEJvVjd0?=
 =?utf-8?B?MjUyeXhTdzZVRUxGcndtN2hmekEvU2Z6TGNuQVJpaEIydmltS2Y5dy8wbVpv?=
 =?utf-8?B?V1FPK0M4bTY0czROeDdGUnV0RVhXTkFOUWgxWW05OFF1Tm1SbjR3dDYwWUdT?=
 =?utf-8?B?aTcrbjgvWnZsSjQyZkZQdEFSQ0c2REdRK2xFdDhxRmE1bDRha1prcm0xbkFX?=
 =?utf-8?B?ZkhHUnY3TjRVQTdWeXFSMmIvTkNQV1FBK2xmZlJJNjBNbVJGYXhnTHZLODQx?=
 =?utf-8?B?bzFrTUZjWlJ4b3lOK2JFdzhVQWlSU3hVNGpLR3BxYXdQN0R5VGMxMFdITUlZ?=
 =?utf-8?B?Sk5JM1lyOUlXUnRNSjlWMVluL3lad3ordGpZdjBSeWt2Y2dLSGd1MDdmVGlz?=
 =?utf-8?B?NmhWL0FOWjg2NVFwMnU5TzkvbTQ1NkxBRkY1QkIxRDJkVE5rcXoxWEZDUXlt?=
 =?utf-8?B?ZXVjQU9abnVBbXVtL3JNa2UycWVtaDVUZXdYektFMTJvdzhDeS9TVFJVQWxa?=
 =?utf-8?B?eTNMQXBSejBQeEIvL2g3RjI3OVg0aFZlbW5leVdpK0xRakhpSUV6a3ROTjQ0?=
 =?utf-8?B?anFEL2oyUkpDZmZVcXlnMXIwblFIUlRJNlJ3YVBweTNTQ3U2dzQ0RDcrN2tt?=
 =?utf-8?B?TlQxK1lSYVdVZXdJMFphb1dYekxESVI0cXp6c0tkczVudUxGb1g3QzlORmNJ?=
 =?utf-8?B?bkFZVmhsVkR0bllFV1ZRZlh5MWxGSE45RzlkSGwyTDErajczSENtZVNZaDN1?=
 =?utf-8?B?Smc1ZFdaQVMzQUpNcTBySGRJdmFMbXAySko3dWNacmlOV0RoRlFjVjVqcVRy?=
 =?utf-8?B?cnVPc3Avd1hOeHNKY0NCTDRYdGNoN1pjdDBlVjA5dUF2VFVpRE9LOW1iMjcr?=
 =?utf-8?B?cDBpWTlKVjZJdWNvZm9XRFpzZFg1b2hOSm5zbndSVHJhb3JLMzlqWFdNL3VV?=
 =?utf-8?B?RDZNcDVsV3dEb0lYanloS0VqZTFUeXNJRFFuajBpR21CcUxOWGt3ci9neThO?=
 =?utf-8?B?bGFmL3pJV24xaDlYQ1o2WmhmZWNKYkhNbTkwRHZtb1ZUd0xFNDV1WndBN2M0?=
 =?utf-8?B?aVptbTdIczI4Q09JL1gvb2FrSnk3cHA2THNpUlVEbkJLOE9JRTI4ODA4aEZS?=
 =?utf-8?B?cWJkRTJhRzBMWmUyLzB3a0NUejJpaHhBYXVQMjZicG51SnlwYkh1ekU3dk5q?=
 =?utf-8?B?Qm1zaDllY2NWUHE5dDhyWkdhaEovS1prVkcvZDk1M3NSZ2lLLzRZUk9SUzYr?=
 =?utf-8?Q?H4arJn4WyhGXYu3fMzHsYvs=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b494199f-556a-4b5e-e2bd-08dc7b276851
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6578.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 12:53:56.7388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0dVjrqgft6sjO4zzWut+6TIeSOn03MY8bQZyLx/RbJfyFRWVhpzZyatq2o96Gfdw4InhfUHtbI/phTrZm59R8mey47/80ylKxmn55lQ1pM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7916
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 May 2024 12:54:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/178

Hi Trevor,

On 5/23/24 1:08 AM, Trevor Woerner via lists.yoctoproject.org wrote:
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

I think this would be nice to document in the README (or somewhere more 
appropriate?).

> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>   classes-recipe/rk-rauc-demo.bbclass           |  8 ++
>   classes/rk-rauc-demo.bbclass                  |  3 +
>   conf/layer.conf                               |  4 +
>   conf/machine/include/rockchip-wic.inc         |  5 +-
>   .../recipes-bsp/u-boot/files/boot.cmd.in      | 51 ++++++++++++
>   .../recipes-bsp/u-boot/files/uboot-rauc.cfg   |  8 ++
>   .../recipes-bsp/u-boot/u-boot_%.bbappend      | 26 ++++++
>   .../base-files/base-files_%.bbappend          |  6 ++
>   .../recipes-core/base-files/files/fstab       |  7 ++
>   .../rauc-bundles/files/development-1.cert.pem | 80 +++++++++++++++++++
>   .../rauc-bundles/files/development-1.key.pem  | 28 +++++++
>   .../rauc-bundles/rockchip-rauc-bundle.bb      | 14 ++++
>   .../recipes-core/rauc/files/ca.cert.pem       | 80 +++++++++++++++++++
>   .../recipes-core/rauc/files/system.conf.in    | 17 ++++
>   .../recipes-core/rauc/rauc-conf%.bbappend     | 12 +++
>   .../systemd/files/25-rootfsA.conf             |  4 +
>   .../systemd/files/35-rootfsB.conf             |  7 ++
>   .../recipes-core/systemd/files/45-data.conf   |  6 ++
>   .../recipes-core/systemd/systemd_%.bbappend   | 20 +++++
>   19 files changed, 385 insertions(+), 1 deletion(-)
>   create mode 100644 classes-recipe/rk-rauc-demo.bbclass
>   create mode 100644 classes/rk-rauc-demo.bbclass

Please name them differently to not confuse users as to which class is 
used in which context. Are they even both used?

>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-bsp/u-boot/files/boot.cmd.in
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-bsp/u-boot/files/uboot-rauc.cfg
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-bsp/u-boot/u-boot_%.bbappend
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/base-files/base-files_%.bbappend
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/base-files/files/fstab
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/rauc-bundles/files/development-1.cert.pem
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/rauc-bundles/files/development-1.key.pem
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/rauc-bundles/rockchip-rauc-bundle.bb
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/rauc/files/ca.cert.pem
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/rauc/files/system.conf.in
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf%.bbappend
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/25-rootfsA.conf
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/35-rootfsB.conf
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/45-data.conf
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/systemd_%.bbappend
> 
> diff --git a/classes-recipe/rk-rauc-demo.bbclass b/classes-recipe/rk-rauc-demo.bbclass
> new file mode 100644
> index 000000000000..25e105b53d09
> --- /dev/null
> +++ b/classes-recipe/rk-rauc-demo.bbclass
> @@ -0,0 +1,8 @@
> +inherit features_check
> +
> +REQUIRED_DISTRO_FEATURES += "systemd rauc"
> +REQUIRED_MACHINE_FEATURES += "rk-u-boot-env"
> +
> +# 'RK_RAUC_DEMO' indicates the user wants to use the
> +# rauc demo configuration from this layer
> +OVERRIDES .= "${@ ':rk-rauc-demo' if bb.utils.to_boolean(d.getVar('RK_RAUC_DEMO'), False) else ''}"

This very much smells like we should have a DISTRO for this instead no? 
What made you decide to go for a class?

Also, why is here and also in the global class just below? This should 
be in the global class only to apply to all recipes?

> diff --git a/classes/rk-rauc-demo.bbclass b/classes/rk-rauc-demo.bbclass
> new file mode 100644
> index 000000000000..1382b645f96b
> --- /dev/null
> +++ b/classes/rk-rauc-demo.bbclass
> @@ -0,0 +1,3 @@
> +# 'RK_RAUC_DEMO' indicates the user wants to use the
> +# rauc demo configuration from this layer
> +OVERRIDES .= "${@ ':rk-rauc-demo' if bb.utils.to_boolean(d.getVar('RK_RAUC_DEMO'), False) else ''}" > diff --git a/conf/layer.conf b/conf/layer.conf
> index 68205dd7ea4c..03914d2952e1 100644
> --- a/conf/layer.conf
> +++ b/conf/layer.conf
> @@ -21,3 +21,7 @@ BBFILES_DYNAMIC += " \
>       qt5-layer:${LAYERDIR}/dynamic-layers/qt5-layer/*/*/*.bb \
>       qt5-layer:${LAYERDIR}/dynamic-layers/qt5-layer/*/*/*.bbappend \
>   "
> +BBFILES_DYNAMIC += " \
> +    rauc:${LAYERDIR}/dynamic-layers/rk-rauc-demo/*/*/*.bb \
> +    rauc:${LAYERDIR}/dynamic-layers/rk-rauc-demo/*/*/*.bbappend \
> +"
> diff --git a/conf/machine/include/rockchip-wic.inc b/conf/machine/include/rockchip-wic.inc
> index dab61d83ed2c..9e3b62f2a99b 100644
> --- a/conf/machine/include/rockchip-wic.inc
> +++ b/conf/machine/include/rockchip-wic.inc
> @@ -1,11 +1,14 @@
>   # common meta-rockchip wic/wks items
>   
> +inherit rk-rauc-demo
> +
>   require conf/machine/include/rockchip-extlinux.inc
>   require conf/machine/include/rockchip-rk-u-boot-env.inc
>   
>   SPL_BINARY ?= "idbloader.img"
>   
> -IMAGE_FSTYPES += "wic wic.bmap"
> +IMAGE_FSTYPES ?= "wic wic.bmap"
> +IMAGE_FSTYPES:append:rk-rauc-demo = " ext4"

Put this into a separate variable, e.g. RAUC_ROOTFS_TYPE so that 
RAUC_SLOT_rootfs[fstype] can use that variable directly.

EDIT: reading a bit more, a lot more than RAUC_SLOT_rootfs is actually 
assuming ext4, so maybe it isn't THAT useful (at least in the current 
implementation).

>   WKS_FILE ?= "rockchip.wks"
>   WKS_FILE_DEPENDS ?= " \
>   	e2fsprogs-native \
> diff --git a/dynamic-layers/rk-rauc-demo/recipes-bsp/u-boot/files/boot.cmd.in b/dynamic-layers/rk-rauc-demo/recipes-bsp/u-boot/files/boot.cmd.in
> new file mode 100644
> index 000000000000..0887d2b5b812
> --- /dev/null
> +++ b/dynamic-layers/rk-rauc-demo/recipes-bsp/u-boot/files/boot.cmd.in
> @@ -0,0 +1,51 @@
> +echo "devtype: ${devtype}"
> +echo "devnum: ${devnum}"
> +echo "distro_bootpart: ${distro_bootpart}"
> +
> +test -n "${BOOT_ORDER}" || env set BOOT_ORDER "A B"
> +test -n "${BOOT_A_LEFT}" || env set BOOT_A_LEFT 3
> +test -n "${BOOT_B_LEFT}" || env set BOOT_B_LEFT 3
> +test -n "${RAUC_BOOTDEV}" || env set RAUC_BOOTDEV "${devtype} ${devnum}:${distro_bootpart}"
> +
> +env set RAUC_BOOTPART
> +env set RAUC_SLOT
> +
> +echo "BOOT_ORDER: ${BOOT_ORDER}"
> +for RAUC_BOOTSLOT in "${BOOT_ORDER}"; do
> +  if test "x${RAUC_BOOTPART}" != "x"; then
> +    # skip remaining slots
> +  elif test "x${RAUC_BOOTSLOT}" = "xA"; then
> +    if test ${BOOT_A_LEFT} -gt 0; then
> +      echo "using RAUC slot A"
> +      setexpr BOOT_A_LEFT ${BOOT_A_LEFT} - 1
> +      env set RAUC_BOOTPART "PARTLABEL=rootfsA"
> +      env set RAUC_SLOT "A"
> +      env set RAUC_BOOTDEV "${devtype} ${devnum}:${distro_bootpart}"
> +      echo "RAUC_BOOTDEV: ${RAUC_BOOTDEV}"
> +    fi
> +  elif test "x${RAUC_BOOTSLOT}" = "xB"; then
> +    if test ${BOOT_B_LEFT} -gt 0; then
> +      echo "using RAUC slot B"
> +      setexpr BOOT_B_LEFT ${BOOT_B_LEFT} - 1
> +      env set RAUC_BOOTPART "PARTLABEL=rootfsB"
> +      env set RAUC_SLOT "B"
> +      setexpr BOOTPART1 ${distro_bootpart} + 1

This is absolutely not guaranteed to be the case.

I would recommend to use the label of the partition to find out which 
partition index to use in subsequent commands.

 > part number ${devtype} ${devnum} root BOOTPART1

> +      env set RAUC_BOOTDEV "${devtype} ${devnum}:${BOOTPART1}"
> +      echo "RAUC_BOOTDEV: ${RAUC_BOOTDEV}"
> +    fi
> +  fi
> +done
> +

Up to you but you could merge the two if conditions into one:

"""
for RAUC_BOOTSLOT in "${BOOT_ORDER}"; do
     if test "x${RAUC_BOOTPART}" != "x"; then
         # no break; in U-Boot, need to ignore til the end
     else; then
         env set BOOT_LEFT BOOT_${RAUC_BOOTSLOT}_LEFT
         if test ${BOOT_LEFT} -gt 0; then
             echo "using RAUC slot ${RAUC_BOOTSLOT}"
             setexpr BOOT_LEFT ${BOOT_LEFT} - 1
             env set RAUC_BOOTPART "PARTLABEL=rootfs${RAUC_BOOTSLOT}"
             env set RAUC_SLOT ${RAUC_BOOTSLOT}
             part number ${devtype} ${devnum} rootfs${RAUC_BOOTSLOT} 
BOOTPART
             env set RAUC_BOOTDEV "${devtype} ${devnum}:${BOOTPART}"
             echo "RAUC_BOOTDEV: ${RAUC_BOOTDEV}"
         fi
     fi
done
"""

> +if test -n "${RAUC_BOOTPART}"; then
> +  env set bootargs "${bootargsbase} root=${RAUC_BOOTPART} rauc.slot=${RAUC_SLOT}"
> +  env save
> +else
> +  echo "No valid RAUC slot found. Resetting tries to 3"
> +  env set BOOT_A_LEFT 3
> +  env set BOOT_B_LEFT 3
> +  env save
> +  reset
> +fi
> +
> +ext4load ${RAUC_BOOTDEV} ${kernel_addr_r} @@KERNEL_BOOTFILE@@
> +bootm ${kernel_addr_r}

This means we don't support Image/zImage, only fitImages. Is there no 
way to use extlinux for that to make use of the work you've already done 
to merge /boot with /?

It seems that specifying APPEND in extlinux.conf will forcefully 
overwrite the whole bootargs... I'm wondering if putting 
${rauc_bootargs} in extlinux.conf would save us. Then we would need to 
write to rauc_bootargs instead of bootargs. Also, unset 
UBOOT_EXTLINUX_ROOT so that the label won't make it to APPEND.

I haven't tested but I think this would allow us to not have to maintain 
this boot script too much. This would also allows us to have a rootfs 
type different than ext4 without having to care about the content of the 
  bootscript since extlinux will be found by whatever command is 
supposed to find it.

> diff --git a/dynamic-layers/rk-rauc-demo/recipes-bsp/u-boot/files/uboot-rauc.cfg b/dynamic-layers/rk-rauc-demo/recipes-bsp/u-boot/files/uboot-rauc.cfg
> new file mode 100644
> index 000000000000..77b7164e0192
> --- /dev/null
> +++ b/dynamic-layers/rk-rauc-demo/recipes-bsp/u-boot/files/uboot-rauc.cfg
> @@ -0,0 +1,8 @@
> +CONFIG_CMD_BOOTDEV=y
> +CONFIG_CMD_BOOTMETH=y
> +CONFIG_CMD_SETEXPR=y
> +CONFIG_CMD_SETEXPR_FMT=y
> +CONFIG_BOOTSTD_DEFAULTS=n
> +CONFIG_BOOTMETH_EXTLINUX=n
> +CONFIG_BOOTMETH_EXTLINUX_PXE=n
> +CONFIG_BOOTMETH_VBE=n
> diff --git a/dynamic-layers/rk-rauc-demo/recipes-bsp/u-boot/u-boot_%.bbappend b/dynamic-layers/rk-rauc-demo/recipes-bsp/u-boot/u-boot_%.bbappend
> new file mode 100644
> index 000000000000..f075cb9383aa
> --- /dev/null
> +++ b/dynamic-layers/rk-rauc-demo/recipes-bsp/u-boot/u-boot_%.bbappend
> @@ -0,0 +1,26 @@
> +inherit rk-rauc-demo
> +
> +FILESEXTRAPATHS:prepend:rk-rauc-demo := "${THISDIR}/files:"
> +
> +DEPENDS:append:rk-rauc-demo = " u-boot-mkimage-native"
> +SRC_URI:append:rk-rauc-demo = " \
> +	file://uboot-rauc.cfg \
> +	file://boot.cmd.in \
> +	"
> +
> +do_compile:append:rk-rauc-demo() {
> +	# create boot script
> +	sed -e 's|@@KERNEL_BOOTFILE@@|${UBOOT_EXTLINUX_KERNEL_IMAGE}|' \
> +	    "${WORKDIR}/boot.cmd.in" > "${WORKDIR}/boot.cmd"
> +	mkimage -A ${UBOOT_ARCH} -T script -C none -n "Boot script" -d "${WORKDIR}/boot.cmd" ${WORKDIR}/boot.scr
> +
> +	# tweak environment
> +	echo "bootmeths=script extlinux" >> ${B}/u-boot-initial-env
> +	echo "bootargsbase=${UBOOT_EXTLINUX_KERNEL_ARGS} ${UBOOT_EXTLINUX_CONSOLE}" >> ${B}/u-boot-initial-env

Shouldn't those only be done if RK_IMAGE_INCLUDES_UBOOT_ENV is True?

> +}
> +
> +do_install:append:rk-rauc-demo() {
> +	install -d ${D}/boot
> +	install -m 0644 ${WORKDIR}/boot.scr ${D}/boot
> +}

Would it make sense to also deploy this file?

> +FILES:${PN}-extlinux += "/boot/boot.scr"
> diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/base-files/base-files_%.bbappend b/dynamic-layers/rk-rauc-demo/recipes-core/base-files/base-files_%.bbappend
> new file mode 100644
> index 000000000000..88df362b8b23
> --- /dev/null
> +++ b/dynamic-layers/rk-rauc-demo/recipes-core/base-files/base-files_%.bbappend
> @@ -0,0 +1,6 @@
> +inherit rk-rauc-demo
> +
> +FILESEXTRAPATHS:prepend:rk-rauc-demo := "${THISDIR}/files:"
> +
> +# Add a mount point for a shared data partition
> +dirs755 += "/data"
> diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/base-files/files/fstab b/dynamic-layers/rk-rauc-demo/recipes-core/base-files/files/fstab
> new file mode 100644
> index 000000000000..de25bb1e608b
> --- /dev/null
> +++ b/dynamic-layers/rk-rauc-demo/recipes-core/base-files/files/fstab
> @@ -0,0 +1,7 @@
> +/dev/root            /                    auto       x-systemd.growfs                   1  1
> +proc                 /proc                proc       defaults                           0  0
> +devpts               /dev/pts             devpts     mode=0620,ptmxmode=0666,gid=5      0  0
> +tmpfs                /run                 tmpfs      mode=0755,nodev,nosuid,strictatime 0  0
> +tmpfs                /var/volatile        tmpfs      defaults                           0  0
> +
> +LABEL=data  /data  ext4  defaults  0  0

Systemd itself recommends using mount units instead of modifying fstab, 
c.f. 
https://manpages.debian.org/testing/systemd/systemd.mount.5.en.html#FSTAB

"""
In general, configuring mount points through /etc/fstab is the preferred 
approach to manage mounts for humans. For tooling, writing mount units 
should be preferred over editing /etc/fstab.
"""

I guess we could argue which of humans vs tooling we represent here :)

The nice thing about using mount units is that this could be a separate 
package recipe and not modify base-files and maybe even allow people to 
extend this to support systemd-less systems for the demo?

> diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/rauc-bundles/files/development-1.cert.pem b/dynamic-layers/rk-rauc-demo/recipes-core/rauc-bundles/files/development-1.cert.pem
> new file mode 100644
> index 000000000000..92e71125d22f
> --- /dev/null
> +++ b/dynamic-layers/rk-rauc-demo/recipes-core/rauc-bundles/files/development-1.cert.pem
> @@ -0,0 +1,80 @@
> +Certificate:
> +    Data:
> +        Version: 3 (0x2)
> +        Serial Number: 2 (0x2)
> +        Signature Algorithm: sha256WithRSAEncryption
> +        Issuer: O=Test Org, CN=Test Org rauc CA Development
> +        Validity
> +            Not Before: Jan  1 00:00:00 1970 GMT
> +            Not After : Dec 31 23:59:59 9999 GMT
> +        Subject: O=Test Org, CN=Test Org Development-1
> +        Subject Public Key Info:
> +            Public Key Algorithm: rsaEncryption
> +                RSA Public-Key: (2048 bit)
> +                Modulus:
> +                    00:ac:2b:0f:05:02:d0:bb:b0:47:05:36:71:3c:20:
> +                    0e:a7:76:8d:75:c1:23:5e:6c:7a:2d:94:ff:3c:17:
> +                    d8:0b:44:48:2a:82:03:92:c5:fd:33:76:0c:42:cf:
> +                    4d:8a:c9:47:7f:af:52:7c:15:6c:3b:e7:60:d1:04:
> +                    97:24:7b:07:1f:56:7d:6c:3f:31:e8:f9:36:7b:33:
> +                    5b:cf:54:ea:37:98:a6:b1:9a:1d:da:96:a1:07:14:
> +                    9c:15:80:4d:db:0c:03:86:ce:c7:3d:72:57:a2:da:
> +                    a0:c0:8c:b2:9a:a0:6a:e5:b8:5f:52:d2:f6:27:ca:
> +                    48:f4:e3:86:eb:be:24:93:6a:af:60:68:7f:09:3b:
> +                    81:96:ce:85:0c:63:93:d8:fa:91:dc:50:2e:77:bb:
> +                    bc:38:42:e9:86:d8:ac:33:dd:e6:d4:37:69:e3:01:
> +                    8d:21:8f:a9:4a:7f:15:a5:aa:a9:be:fc:36:93:a4:
> +                    10:0c:18:33:30:06:7f:1c:13:b3:a9:c6:57:d7:6b:
> +                    96:45:15:e7:f5:8f:3d:48:e0:08:46:4f:7f:ef:14:
> +                    77:95:25:25:9b:14:21:84:25:eb:37:0b:01:48:e6:
> +                    f5:c1:8b:61:c6:cb:8c:6b:a7:d8:d2:f9:31:e3:80:
> +                    3f:78:ea:6a:41:6c:5d:4d:83:a6:54:0d:5b:c2:0e:
> +                    f6:ef
> +                Exponent: 65537 (0x10001)
> +        X509v3 extensions:
> +            X509v3 Subject Key Identifier:
> +                89:4C:FE:8A:60:4D:C9:6D:F7:A8:C0:04:49:7F:AA:05:92:29:17:FB
> +            X509v3 Authority Key Identifier:
> +                keyid:44:0C:AF:4A:74:B4:C7:65:02:B2:95:F1:91:7C:A3:CC:E6:3E:99:E8
> +                DirName:/O=Test Org/CN=Test Org rauc CA Development
> +                serial:01
> +
> +            X509v3 Basic Constraints:
> +                CA:FALSE
> +    Signature Algorithm: sha256WithRSAEncryption
> +         2c:d2:30:68:f5:84:52:1e:cf:ed:0d:fc:e7:02:69:0b:3b:f6:
> +         c3:77:00:12:1d:2d:d0:8f:49:9e:5c:f1:00:7b:1d:4f:d5:a9:
> +         46:a5:df:54:90:50:b4:8f:8e:ba:4b:2d:82:74:eb:5b:a8:f5:
> +         45:7b:77:73:b1:9b:32:93:15:c0:5c:02:2a:ed:b0:1e:bb:d8:
> +         4e:41:17:20:af:04:46:21:20:7b:86:9f:32:ab:54:71:26:e8:
> +         0b:75:12:9c:63:53:4f:54:db:a7:f9:b2:fa:e9:ee:4a:9d:80:
> +         ba:ae:3f:eb:ef:10:11:2d:4f:5a:34:fb:8b:45:10:63:0b:f8:
> +         af:f3:8b:24:21:2a:e0:0b:44:38:44:b5:9d:6e:8a:ff:1f:bf:
> +         6e:44:21:22:ec:8a:8d:73:63:e5:df:1a:ec:2a:64:1f:97:f9:
> +         5c:3a:25:7f:03:80:4c:db:99:5e:f9:7d:2b:f1:d0:97:4d:95:
> +         6f:29:47:7b:3f:29:e3:96:25:b0:1c:f1:0b:8b:8b:ba:de:3b:
> +         3f:40:2e:bd:31:68:ea:a9:8f:dc:c9:09:22:df:76:69:08:5d:
> +         5d:a4:09:62:80:20:83:9e:bd:d4:a6:35:ee:97:50:66:39:62:
> +         66:1b:2e:75:f2:6d:e7:06:ae:67:5f:4b:63:5c:52:e7:5d:dd:
> +         c9:0c:86:2b
> +-----BEGIN CERTIFICATE-----
> +MIIDfTCCAmWgAwIBAgIBAjANBgkqhkiG9w0BAQsFADA6MREwDwYDVQQKDAhUZXN0
> +IE9yZzElMCMGA1UEAwwcVGVzdCBPcmcgcmF1YyBDQSBEZXZlbG9wbWVudDAgFw03
> +MDAxMDEwMDAwMDBaGA85OTk5MTIzMTIzNTk1OVowNDERMA8GA1UECgwIVGVzdCBP
> +cmcxHzAdBgNVBAMMFlRlc3QgT3JnIERldmVsb3BtZW50LTEwggEiMA0GCSqGSIb3
> +DQEBAQUAA4IBDwAwggEKAoIBAQCsKw8FAtC7sEcFNnE8IA6ndo11wSNebHotlP88
> +F9gLREgqggOSxf0zdgxCz02KyUd/r1J8FWw752DRBJckewcfVn1sPzHo+TZ7M1vP
> +VOo3mKaxmh3alqEHFJwVgE3bDAOGzsc9clei2qDAjLKaoGrluF9S0vYnykj044br
> +viSTaq9gaH8JO4GWzoUMY5PY+pHcUC53u7w4QumG2Kwz3ebUN2njAY0hj6lKfxWl
> +qqm+/DaTpBAMGDMwBn8cE7OpxlfXa5ZFFef1jz1I4AhGT3/vFHeVJSWbFCGEJes3
> +CwFI5vXBi2HGy4xrp9jS+THjgD946mpBbF1Ng6ZUDVvCDvbvAgMBAAGjgZEwgY4w
> +HQYDVR0OBBYEFIlM/opgTclt96jABEl/qgWSKRf7MGIGA1UdIwRbMFmAFEQMr0p0
> +tMdlArKV8ZF8o8zmPpnooT6kPDA6MREwDwYDVQQKDAhUZXN0IE9yZzElMCMGA1UE
> +AwwcVGVzdCBPcmcgcmF1YyBDQSBEZXZlbG9wbWVudIIBATAJBgNVHRMEAjAAMA0G
> +CSqGSIb3DQEBCwUAA4IBAQAs0jBo9YRSHs/tDfznAmkLO/bDdwASHS3Qj0meXPEA
> +ex1P1alGpd9UkFC0j466Sy2CdOtbqPVFe3dzsZsykxXAXAIq7bAeu9hOQRcgrwRG
> +ISB7hp8yq1RxJugLdRKcY1NPVNun+bL66e5KnYC6rj/r7xARLU9aNPuLRRBjC/iv
> +84skISrgC0Q4RLWdbor/H79uRCEi7IqNc2Pl3xrsKmQfl/lcOiV/A4BM25le+X0r
> +8dCXTZVvKUd7PynjliWwHPELi4u63js/QC69MWjqqY/cyQki33ZpCF1dpAligCCD
> +nr3UpjXul1BmOWJmGy518m3nBq5nX0tjXFLnXd3JDIYr
> +-----END CERTIFICATE-----
> diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/rauc-bundles/files/development-1.key.pem b/dynamic-layers/rk-rauc-demo/recipes-core/rauc-bundles/files/development-1.key.pem
> new file mode 100644
> index 000000000000..80305f8291b1
> --- /dev/null
> +++ b/dynamic-layers/rk-rauc-demo/recipes-core/rauc-bundles/files/development-1.key.pem
> @@ -0,0 +1,28 @@
> +-----BEGIN PRIVATE KEY-----
> +MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCsKw8FAtC7sEcF
> +NnE8IA6ndo11wSNebHotlP88F9gLREgqggOSxf0zdgxCz02KyUd/r1J8FWw752DR
> +BJckewcfVn1sPzHo+TZ7M1vPVOo3mKaxmh3alqEHFJwVgE3bDAOGzsc9clei2qDA
> +jLKaoGrluF9S0vYnykj044brviSTaq9gaH8JO4GWzoUMY5PY+pHcUC53u7w4QumG
> +2Kwz3ebUN2njAY0hj6lKfxWlqqm+/DaTpBAMGDMwBn8cE7OpxlfXa5ZFFef1jz1I
> +4AhGT3/vFHeVJSWbFCGEJes3CwFI5vXBi2HGy4xrp9jS+THjgD946mpBbF1Ng6ZU
> +DVvCDvbvAgMBAAECggEASphBYq9sltVyf/ytpRpSnxYLhmiPFXs0mIlE6Nl/3qnQ
> +BrLcL3yfDuvntg6xjx9UXistNtvlUDMYzJcLkV/InzhPEVZ0HnfTth9zeOpWrI30
> +M2EN7EZ1MGcqlVpI4U5cPM1cn+/proLBQYv0WnCEwFFY477JrkXDxG7MZ1mz6TaL
> +IGcCCIUu1BxECngQ344eaKrSR5F2MtlxAl19Pt5QSPfmuMdmElrK6RtBjnKrDu1K
> +fe6DCfObZ3nbG2fhFV4uTxhlTC9lUmfTQMKR79rLmHNKnbMx74kFNvy3XlT2l35I
> +ZVfRMLPWph7yMom9v/Im3Q70uhJ1lxyqbbl/DFZVmQKBgQDVo19SqR/QeDIxPIPn
> +XvVWzo5ml3KO/dVxA8sok6twr+G7yUeIUnuauYFA/tX/FS32azFRa/7GjUfoTx3q
> +GHK43TBCMyEt0we6WwZb+FkWa/b/RBoyD/audrpmgDDi1+fXPs8bBvoO8/oju20D
> +I6wOjSovcIMaeLo/+u3U6ShNQwKBgQDOTpoGMsQzXchZfDmxL61h3j4Gtjrl4BpU
> +WhAkJ9U2BRpL8NSZLErn5ik8MwgK2ut+YdU7aogI0D6Gc+4zZoJDEbhhmPD9cprv
> +LMyfAKoisR01OyU57mMSGQq0dfjmK6PfYJdX5sQJGkMFptNAJLTDoYtmXItSICoY
> +1j5KTvwe5QKBgGytxmErjfakHoxzh3pdERuOylwgMPPS5xCt6FyE+pLBtmisFQqh
> +QyXLtpgUy1IPOSmBED6mXJ4u4uSn0sTymPG3+8PBdOB12RmREqQYq2E/nQ/wWg8b
> +ldbcqShZkATl5pfV6M+L9gtDS/1/bA5LyExCvbISX29I+R5xDSnhTlI3AoGBAJRK
> +VVXtOa/+UhtYOpPMxGCbgZQLemxvWB2XmxCR/SRWKJ+7XOU4vCLSAoO93qMG1szB
> +/6Y0ndFP9hFo1SfnH+ybmR+18ksLDKisV+xWavSCwI7Zk5l/a4C/tT0fqyeu6JyQ
> +bliFjBVK5i/yyNfLSo9v16ZdENuYOQofPSjmezytAoGBALhwvtzgqvqGSXID2w5N
> +ullK8ny3WRa1o5DLXuMV19CvknmrN/zmmjQLblKkdp9VBb7uo8czon+qL1ZZyywC
> +W2BmHfGMPUyQHux4btsdJhlWcS7z7aYXM9QWiKlI+EKLHLILYk+LPIEf85sUcOZV
> +eCBpViT7fv2iv/0L+mzjWtLA
> +-----END PRIVATE KEY-----
> diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/rauc-bundles/rockchip-rauc-bundle.bb b/dynamic-layers/rk-rauc-demo/recipes-core/rauc-bundles/rockchip-rauc-bundle.bb
> new file mode 100644
> index 000000000000..23eac4d3c4f5
> --- /dev/null
> +++ b/dynamic-layers/rk-rauc-demo/recipes-core/rauc-bundles/rockchip-rauc-bundle.bb
> @@ -0,0 +1,14 @@
> +DESCRIPTION = "Rockchip RAUC bundle generator"
> +
> +inherit bundle
> +
> +RAUC_BUNDLE_COMPATIBLE = "${MACHINE}"
> +RAUC_BUNDLE_VERSION = "v20240512"
> +RAUC_BUNDLE_DESCRIPTION = "RAUC Demo Bundle"
> +RAUC_BUNDLE_FORMAT = "verity"
> +RAUC_BUNDLE_SLOTS = "rootfs"
> +RAUC_SLOT_rootfs = "core-image-base"
> +RAUC_SLOT_rootfs[fstype] = "ext4"
> +
> +RAUC_KEY_FILE = "${THISDIR}/files/development-1.key.pem"
> +RAUC_CERT_FILE = "${THISDIR}/files/development-1.cert.pem"

Please always use the walrus operator when THISDIR is used.

> diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/rauc/files/ca.cert.pem b/dynamic-layers/rk-rauc-demo/recipes-core/rauc/files/ca.cert.pem
> new file mode 100644
> index 000000000000..46944a99df22
> --- /dev/null
> +++ b/dynamic-layers/rk-rauc-demo/recipes-core/rauc/files/ca.cert.pem
> @@ -0,0 +1,80 @@
> +Certificate:
> +    Data:
> +        Version: 3 (0x2)
> +        Serial Number: 1 (0x1)
> +        Signature Algorithm: sha256WithRSAEncryption
> +        Issuer: O=Test Org, CN=Test Org rauc CA Development
> +        Validity
> +            Not Before: Jan  1 00:00:00 1970 GMT
> +            Not After : Dec 31 23:59:59 9999 GMT
> +        Subject: O=Test Org, CN=Test Org rauc CA Development
> +        Subject Public Key Info:
> +            Public Key Algorithm: rsaEncryption
> +                RSA Public-Key: (2048 bit)
> +                Modulus:
> +                    00:c0:fe:7b:6c:c3:e3:47:cc:d4:15:e1:0c:b2:1c:
> +                    c9:f7:61:3e:42:d7:f1:a4:30:f2:db:0e:49:95:49:
> +                    70:ee:97:6d:fe:48:5d:b9:22:63:47:e0:be:63:d7:
> +                    68:9b:38:04:7d:7f:d9:65:ef:1d:6c:26:cb:05:7f:
> +                    59:45:15:9d:76:59:c4:8d:59:a0:38:a0:25:fa:86:
> +                    1b:f4:85:ff:cf:7c:c7:57:a3:7e:56:71:7d:69:c3:
> +                    69:a7:fb:e6:8e:bc:f9:49:e2:f5:9a:97:e5:2d:75:
> +                    ef:f9:76:29:5f:76:11:1b:70:6f:4d:26:4f:e0:06:
> +                    9b:8c:e3:76:91:81:4a:4e:98:5d:2e:f4:bd:23:4d:
> +                    e7:5d:9b:ea:68:4d:03:9e:35:90:c5:f2:8d:ae:ed:
> +                    44:4f:f3:50:dc:2b:ef:ae:44:35:79:78:3d:65:4b:
> +                    d9:16:98:aa:be:08:47:25:af:68:1c:0b:8e:c1:aa:
> +                    02:a7:61:4f:4d:15:1b:07:3c:4e:60:b3:9a:d5:c1:
> +                    39:34:4e:8e:e7:93:46:f1:75:95:aa:16:9a:1d:e6:
> +                    49:15:a5:ae:06:8a:45:16:a9:af:59:60:9b:c6:6d:
> +                    3d:19:57:5d:de:31:d5:dc:96:0e:a4:25:fe:7a:07:
> +                    71:c5:40:c0:a3:d0:d5:84:47:14:7a:5a:f1:07:75:
> +                    79:35
> +                Exponent: 65537 (0x10001)
> +        X509v3 extensions:
> +            X509v3 Subject Key Identifier:
> +                44:0C:AF:4A:74:B4:C7:65:02:B2:95:F1:91:7C:A3:CC:E6:3E:99:E8
> +            X509v3 Authority Key Identifier:
> +                keyid:44:0C:AF:4A:74:B4:C7:65:02:B2:95:F1:91:7C:A3:CC:E6:3E:99:E8
> +                DirName:/O=Test Org/CN=Test Org rauc CA Development
> +                serial:01
> +
> +            X509v3 Basic Constraints:
> +                CA:TRUE
> +    Signature Algorithm: sha256WithRSAEncryption
> +         30:07:51:4d:d6:2c:0c:2f:3e:6c:5c:34:1f:07:21:8d:50:77:
> +         9a:a6:81:75:62:f0:fe:ff:3b:5b:d0:7c:d1:45:e7:e2:67:d4:
> +         23:cb:af:9a:8b:f4:2b:d2:33:3d:45:bb:a7:7d:b4:9b:41:db:
> +         fb:62:ac:83:fc:41:ae:e5:dc:2d:df:7d:72:7e:df:34:01:60:
> +         94:7f:15:78:84:87:f0:23:e4:8e:b8:dc:71:cb:84:4b:25:bb:
> +         62:8f:fd:7f:d3:3c:1d:85:45:fb:03:7c:a2:bc:c4:a8:fa:2b:
> +         ec:79:67:8d:f4:5f:37:a8:5a:54:bc:b3:78:11:0b:8b:29:90:
> +         8b:48:4a:d7:87:93:96:97:72:10:1d:70:29:f8:e4:c3:81:6d:
> +         7d:c3:6e:d4:c8:1b:0b:0d:f9:c0:b9:7b:11:54:e2:af:8b:a0:
> +         45:de:c2:67:81:8c:0c:9d:ba:a1:31:8b:f2:cc:da:c7:cc:6d:
> +         21:92:2a:57:29:9c:48:92:75:d9:1a:6e:d3:ee:53:66:83:2e:
> +         08:74:09:5d:78:13:99:34:7d:16:8c:ba:29:75:80:20:8b:ca:
> +         91:19:29:64:ef:64:37:de:5b:22:18:99:5b:63:69:9a:a2:44:
> +         21:70:30:41:f2:58:27:ab:4f:5c:d0:e1:94:5d:d1:5b:8d:fd:
> +         bf:8f:a9:99
> +-----BEGIN CERTIFICATE-----
> +MIIDhjCCAm6gAwIBAgIBATANBgkqhkiG9w0BAQsFADA6MREwDwYDVQQKDAhUZXN0
> +IE9yZzElMCMGA1UEAwwcVGVzdCBPcmcgcmF1YyBDQSBEZXZlbG9wbWVudDAgFw03
> +MDAxMDEwMDAwMDBaGA85OTk5MTIzMTIzNTk1OVowOjERMA8GA1UECgwIVGVzdCBP
> +cmcxJTAjBgNVBAMMHFRlc3QgT3JnIHJhdWMgQ0EgRGV2ZWxvcG1lbnQwggEiMA0G
> +CSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDA/ntsw+NHzNQV4QyyHMn3YT5C1/Gk
> +MPLbDkmVSXDul23+SF25ImNH4L5j12ibOAR9f9ll7x1sJssFf1lFFZ12WcSNWaA4
> +oCX6hhv0hf/PfMdXo35WcX1pw2mn++aOvPlJ4vWal+Utde/5dilfdhEbcG9NJk/g
> +BpuM43aRgUpOmF0u9L0jTeddm+poTQOeNZDF8o2u7URP81DcK++uRDV5eD1lS9kW
> +mKq+CEclr2gcC47BqgKnYU9NFRsHPE5gs5rVwTk0To7nk0bxdZWqFpod5kkVpa4G
> +ikUWqa9ZYJvGbT0ZV13eMdXclg6kJf56B3HFQMCj0NWERxR6WvEHdXk1AgMBAAGj
> +gZQwgZEwHQYDVR0OBBYEFEQMr0p0tMdlArKV8ZF8o8zmPpnoMGIGA1UdIwRbMFmA
> +FEQMr0p0tMdlArKV8ZF8o8zmPpnooT6kPDA6MREwDwYDVQQKDAhUZXN0IE9yZzEl
> +MCMGA1UEAwwcVGVzdCBPcmcgcmF1YyBDQSBEZXZlbG9wbWVudIIBATAMBgNVHRME
> +BTADAQH/MA0GCSqGSIb3DQEBCwUAA4IBAQAwB1FN1iwMLz5sXDQfByGNUHeapoF1
> +YvD+/ztb0HzRRefiZ9Qjy6+ai/Qr0jM9RbunfbSbQdv7YqyD/EGu5dwt331yft80
> +AWCUfxV4hIfwI+SOuNxxy4RLJbtij/1/0zwdhUX7A3yivMSo+ivseWeN9F83qFpU
> +vLN4EQuLKZCLSErXh5OWl3IQHXAp+OTDgW19w27UyBsLDfnAuXsRVOKvi6BF3sJn
> +gYwMnbqhMYvyzNrHzG0hkipXKZxIknXZGm7T7lNmgy4IdAldeBOZNH0WjLopdYAg
> +i8qRGSlk72Q33lsiGJlbY2maokQhcDBB8lgnq09c0OGUXdFbjf2/j6mZ
> +-----END CERTIFICATE-----
> diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/rauc/files/system.conf.in b/dynamic-layers/rk-rauc-demo/recipes-core/rauc/files/system.conf.in
> new file mode 100644
> index 000000000000..4945c67345c4
> --- /dev/null
> +++ b/dynamic-layers/rk-rauc-demo/recipes-core/rauc/files/system.conf.in
> @@ -0,0 +1,17 @@
> +[system]
> +compatible=@MACHINE@
> +bootloader=uboot
> +data-directory=/data/
> +
> +[keyring]
> +path=/etc/rauc/ca.cert.pem
> +
> +[slot.rootfs.0]
> +device=/dev/disk/by-partlabel/rootfsA
> +type=ext4
> +bootname=A
> +
> +[slot.rootfs.1]
> +device=/dev/disk/by-partlabel/rootfsB
> +type=ext4
> +bootname=B
> diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf%.bbappend b/dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf%.bbappend
> new file mode 100644
> index 000000000000..b65e9be2afaf
> --- /dev/null
> +++ b/dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf%.bbappend

Don't you want rauc-conf.bbappend here to avoid matching 
rauc-conf-mycustomrecipe.bb from other layers?

> @@ -0,0 +1,12 @@
> +inherit rk-rauc-demo
> +
> +FILESEXTRAPATHS:prepend:rk-rauc-demo := "${THISDIR}/files:"
> +SRC_URI:append:rk-rauc-demo := "  \
> +	file://system.conf.in \
> +	file://ca.cert.pem \

This is not needed, RAUC_KEYRING_FILE is already set to ca.cert.pem and 
SRC_URI has RAUC_KEYRING_URI (which is file://RAUC_KEYRING_FILE) in 
there, so it'll be found with only FILESEXTRAPATHS:prepend:rk-rauc-demo.

> +	"
> +
> +do_install:append:rk-rauc-demo() {
> +	install -d ${D}${sysconfdir}/rauc
> +	sed -e 's!@MACHINE@!${MACHINE}!g' ${WORKDIR}/system.conf.in > ${D}${sysconfdir}/rauc/system.conf
> +}

I would suggest to run:

sed -e 's!@MACHINE@!${MACHINE}!g' ${WORKDIR}/system.conf.in > 
${WORKDIR}/system.conf

in a do_install:prepend, and let the do_instal from rauc-conf do the 
rest for you.

Similarly, you could actually name system.conf.in directly system.conf 
to avoid having to specify it in SRC_URI:append as it's already included 
in SRC_URI of the main recipe.

> diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/25-rootfsA.conf b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/25-rootfsA.conf
> new file mode 100644
> index 000000000000..dba01e1ff863
> --- /dev/null
> +++ b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/25-rootfsA.conf
> @@ -0,0 +1,4 @@
> +[Partition]
> +Type=root
> +Weight=250
> +SizeMaxBytes=5G

Why no

Label=rootfsA
Format=ext4
GrowFileSystem=yes

in this one?

> diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/35-rootfsB.conf b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/35-rootfsB.conf
> new file mode 100644
> index 000000000000..31a7c06c17ff
> --- /dev/null
> +++ b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/35-rootfsB.conf
> @@ -0,0 +1,7 @@
> +[Partition]
> +Type=root
> +Label=rootfsB
> +Weight=250
> +SizeMaxBytes=5G
> +Format=ext4
> +GrowFileSystem=yes
> diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/45-data.conf b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/45-data.conf
> new file mode 100644
> index 000000000000..1aac59addc26
> --- /dev/null
> +++ b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/45-data.conf
> @@ -0,0 +1,6 @@
> +[Partition]
> +Type=root-secondary
> +Label=data
> +Weight=500
> +Format=ext4
> +GrowFileSystem=yes
> diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/systemd/systemd_%.bbappend b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/systemd_%.bbappend
> new file mode 100644
> index 000000000000..2b9da514749e
> --- /dev/null
> +++ b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/systemd_%.bbappend
> @@ -0,0 +1,20 @@
> +inherit rk-rauc-demo
> +
> +FILESEXTRAPATHS:prepend:rk-rauc-demo := "${THISDIR}/files:"
> +
> +SRC_URI:append:rk-rauc-demo = " \
> +	file://25-rootfsA.conf \
> +	file://35-rootfsB.conf \
> +	file://45-data.conf \
> +	"
> +
> +PACKAGECONFIG:append:rk-rauc-demo = " repart openssl"
> +
> +do_install:append:rk-rauc-demo() {
> +	install -d ${D}${sysconfdir}/repart.d/
> +	install -m 0644 ${WORKDIR}/25-rootfsA.conf ${D}${sysconfdir}/repart.d/
> +	install -m 0644 ${WORKDIR}/35-rootfsB.conf ${D}${sysconfdir}/repart.d/
> +	install -m 0644 ${WORKDIR}/45-data.conf ${D}${sysconfdir}/repart.d/
> +}
> +
> +FILES:${PN}:append:rk-rauc-demo = " ${sysconfdir}/repart.d/"

I have a feeling the files should be done in another package recipe, we 
don't want to rebuild systemd if we change the files in here I think.

Cheers,
Quentin

