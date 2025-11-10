Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D771DCCF9E3
	for <webhook@archiver.kernel.org>; Mon, 10 Nov 2025 09:44:52 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44748.1762767882598537128
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 10 Nov 2025 01:44:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=c/ralSoD;
 spf=pass (domain: cherry.de, ip: 52.101.70.53, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofjI4QDsyR7JrVap0U6/f9lgYLuvWY5iKd6VuFeKUXontoVDUl/WskowBHJoY5iAhDMDTOVchtNDciqiJEwqbU4KJ2rRG5YKpVqZ/cVhKS6UQ227PyZ7YlwUQWpicEpXd3NtQja5/jiQeB2TFhPApAlAMByGSVRpyn+NFYbQNoTxWrZnz9fJi7AhO+56NOPpjgkkOxvuiLdCMLPnD4aV5F6rVqsRlsdDM3CEe1eThE+89U776vSlolVhZgqnPSTPeq1nnaIcQ7H18k9bO8IMG2tz+wmbVuI/6Nk0D7EYWsgKxYrCBUPIw2fxAOeTvvXiVbODH2xKvVuXelFO7FToSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1XktNnlsrgv2P8HF+gg1MXl3QJZVl+6Yiaw+p21Xfg=;
 b=mN7ke6ne7yQ5WBk235f/CGhQXOUUkfQkvH9bJJNATpC8cpwpWG2W98t/QJN5cwiFKW1Tmhi+aBh34oG3jI86OLnZmS2DvCBXeV3g4NeeogDrrHQMYnig5CcUAI7jbT5+6rj0mUFrBg7C81S3o/05w/bkWcjQ2Xb6fyZm7mDeUbkg35rSgcXRCnK6sgCzfKuZ+iNCjfeG+8TfB+xC7DhvtCJaX1mmXfIrzxNhkRR+9XFRZVk1kfc4V/O2/LQRvp2l9LkGb/xQFqWB5O37HMEMnfvCx5KZjrnbGWagqdHHUce6CDzImE32x4kk5av3rmqdh3qi+O0LEeyO7qcF2CzDRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1XktNnlsrgv2P8HF+gg1MXl3QJZVl+6Yiaw+p21Xfg=;
 b=c/ralSoDygM8azFQZ0B75PkLlYB87tZNZrvEvAiVsv5icbz2gYa5x463BnbQ7zktaOpEwvTIWdy3ItDSuhqECKUFckUSd4pEgNF+K4KpUOqOvHepjUQUqu2u4bdiUlahOH4dtOUivqluvRVzBYvGyO+7VYsivfrxL4YaPVHi8l4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB11928.eurprd04.prod.outlook.com (2603:10a6:10:628::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 09:44:38 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9298.012; Mon, 10 Nov 2025
 09:44:38 +0000
Message-ID: <ceaaab86-4caa-4be6-9e1f-9c688e2d5649@cherry.de>
Date: Mon, 10 Nov 2025 10:44:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH v3] rk3288: use u-boot.img
 as bootloader image
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com, Peter Shkenev <mustela@erminea.space>
References: <20251108225641.171832-1-mustela@erminea.space>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251108225641.171832-1-mustela@erminea.space>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB11928:EE_
X-MS-Office365-Filtering-Correlation-Id: 9302d3b9-ce3c-4b29-c0fb-08de203dc3ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YXRaRzgwK2ozS2g2LzVqaE1qQ1R1V1p2RXkzMGNNTm5VVUNkSVNqekYvcmha?=
 =?utf-8?B?ZUQramQwd2d2RWRZV1RaRTNaQlRhdE9aazNYaWQ5RUxjQ2tSbC80WFNDelo1?=
 =?utf-8?B?NU93U2V1Z1FMTlBra0FlZmc5SDk4OEVEazkvTHJlUHkzMVpvY2dnMW90eXJh?=
 =?utf-8?B?TmNZS0pkSjFZNVdSYjhUZUJkektLMmNuWlUrM2VYV2tGVmxaVzBQZjc3T1U4?=
 =?utf-8?B?Y0lIYVUxZ29PTjY3UnNZM3JQYWJRODR4Mkw2YU9sSzl2LzRURUV1YmlrcGNM?=
 =?utf-8?B?elVINXYva0pEY0NRaFdlampVRDFQUUx3ZWdCQm9DQ1ZNeURZMm9HOFVjZmhB?=
 =?utf-8?B?MWtIa3A3WHE3UkFPdnJqNTVCbXZnVUIwR3ZKVUpYUGt3UWV3VG1HUm1JVHJo?=
 =?utf-8?B?T3VVaVVJZjJpMTErNGxQYk1tMmtkS0lOQnVLM2N5cUF2NmZZbEpGWGd5TUN2?=
 =?utf-8?B?SXppQmNucmJoNCtZLzNkZm5nWE8wdlp6eUdMZjZuc1RlbFZuNHBIRCtQb0x2?=
 =?utf-8?B?cjFlTWwvVWdEd1RNbm4xaENYTHNhWGNlMzlwSDFrTjJ1bTllbG5UZU9CT0sv?=
 =?utf-8?B?RmNxQjFZQko0TUhxcXY1cENML1QzTEt2L3JQekZ4OWpVSzdpUzZQNmJjNEV3?=
 =?utf-8?B?ZXErSW9uSVErd0MyY3NkaHFtTU16dFFKSnlYZGZ6Zm4yZU5ZeWthTVJ2ZVdu?=
 =?utf-8?B?NDVOeGFYazZZNlNCbVZjcjVUcEQ0MVhnamdrS2h0SzAzU1ArVmV0eTVYWjNi?=
 =?utf-8?B?M1lDdmhRc1NFOG5XODNnUFJTNVVUSm5aRFNYQm5WT0d3U0hVNlZwNHFVQVVh?=
 =?utf-8?B?bCt5QUg5ZEZiQlA3cll5R29SWWdCNW8zUDdDMG5LTjhzcFREMXkvUkFYbFU2?=
 =?utf-8?B?K2RFZnNEZmxKVmRMblNJeEV2eE1MMEdjUExYdXd2c3lpeTZMeVgyL2VwU29K?=
 =?utf-8?B?ekQ5clk3dVNPUmZwU2xEcDN5S3Y3aFhWSXBVL0J1cW05ZEpFRGZVcmw1dCsw?=
 =?utf-8?B?R1pLNnNUOVF6VnlHSVVYY3ArRitJV2I1cDZrbWtMVnlXL09BN09vNDJoRGpl?=
 =?utf-8?B?WDdOV0tVUThsNU1pTks2VlpGbEVDUlZQaEY4SUpXTVpRZ0phekwwUFF6bGQy?=
 =?utf-8?B?dFBob1lBNjM3SDEvMVpPYlNjZ1F0VjFxdHplTTA3RTQ4dGZ5T0JUSmZReFF3?=
 =?utf-8?B?V1Q5Y1dBTHdTemJUZWU1UGo2ekxvS20rdjJhRE5XKzVSMnNqVVlBblFXbTcy?=
 =?utf-8?B?SDNTcC84MlVFakJQMjdaZks4cFhLR2tHQlJPNDJxMS9ERDZySWMyWHUzd0Fn?=
 =?utf-8?B?bnlLSlNOTnNyN0hBTjNmdytjbHdid21XK1YzN2ptWDJudE9uUWtreDhPZnhh?=
 =?utf-8?B?OHJDVnd4VEtkMFoyK3BpQVhZNFphQVdnSjJXdEJpbkJUVHUwck1pSXB1bGE4?=
 =?utf-8?B?TlQ3Z2NTNUZCTVh4VjBKbGk1R3lzQVgvRitmYWI0eEFjK3VaR3d5TFZYc2FX?=
 =?utf-8?B?Z01DdHMvdHlLdkdnOFZJWU9pcnBCb2lWdDd4d0RSMGlHdEhNNEY1L0ZDM1VO?=
 =?utf-8?B?dVdaWjB0SzFDQmV5L0dXZ1JkcC9ORk5PN1BBWkJSL3g3dHIxS2dLOE1CbDVM?=
 =?utf-8?B?NHFpekEraDRKQ1BDRFhpb0tHbzNJUzZsTDAxT25rdGR4akc1VEdKNlVVdThl?=
 =?utf-8?B?ZlVYK2ZWVEdjQ3lqa1hpcFpGVjRIbkQ2U0syZVJ6K0lKNi9iWm5ob1ZnYXVa?=
 =?utf-8?B?N3pTUUp3cXZZUngvT21aL0dtd3RLM21VdXJXcXFWK0llNkxDSnhJZ2ZWRUth?=
 =?utf-8?B?bGpmV0pDU2lDSGgxa3JGbGFBRHZycGRoNXo0TDhRQ2lZL0JLRkVabDdTbWth?=
 =?utf-8?B?K2djRFpCNEFTUDcxOSszT1JrZUhKdWVyMWh2b05BSkVRc0lqQ28wQTFweFZU?=
 =?utf-8?Q?niR5VJ0s6RJxuNtkfeDKYz5vaD7NTJye?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eDFOSUppcUVZcVA2aWFNRzNqTGZXa0hBclVXUnVRdVg1SVcyZ3JBYUFORU1E?=
 =?utf-8?B?MnlMNlVlemk5V284MC9QNWxoWUNSSUJEVmJqSFpuUlVBSHJycGF6RnhhMFJU?=
 =?utf-8?B?cmVLNjRNbE1pL1NXK2xEcWZsTFFoSStQSGRYcEJUR0FHMFVFZXUycWdmcVhU?=
 =?utf-8?B?VEI2b01DSTJMbkNZNGEwcWZzak12cGlxeXZoUnFiTW5qWHlveHdXSFI2a05t?=
 =?utf-8?B?b0kxUU5sMDlGcGFDaUxlTVJNTmpBdmRwK2JWQjRrYjlBNHFQTm5aaTlFMGhE?=
 =?utf-8?B?ekVWd2NlQllOajZKbnVPTHFyMXJXSXg4UENXQ2pVeCsvOU9xWTFhMHBIeVNJ?=
 =?utf-8?B?V09YUUNET3BYeUQ3UXQ4NndkYTh2aVNvWDlldExKYUhQNmlxRDRiMEgrb2wy?=
 =?utf-8?B?QVpPTllyNmd1ZHFPR1NKMXhHUUI0S1V1MHNqRWVjUkYxakI4UnIxbWVqTnpl?=
 =?utf-8?B?ZmxhNE1kdGF2ZnVYQXRmaDMxd1lNTHJJTExzYisvZUpwOFhOK2dRTTcvNzEw?=
 =?utf-8?B?TWZ2bXJOeHNIVUZ1VGEvTitqQllZVGlBTTJxb1p0Um11YWxxajJlb1NOL3dC?=
 =?utf-8?B?ek9sK1pENXdTY3hxaStiVFFKejJIekZYQitEU2d0SUtlaWtCYU80OC9JRzZI?=
 =?utf-8?B?Z0FGcGpyWmp3NC8zVE5DMFlwRFlXTm9mTlRJK2g1T2I0Sk4wRDByTUw3enZ6?=
 =?utf-8?B?Zzk1YmpzS2FPRk5oUHdkWjJxNDIxMlI2Y01DOW9IeSsxelRQMHdWeGJ3ZTVH?=
 =?utf-8?B?eit6K2hWK3VFYms0THMySEZxOU1uSTZQRTJHWjBsVWNGQkpVNGY1QWFIek9K?=
 =?utf-8?B?R0V5TWgzSGRaZGtsZkoxTk9wdjNkSDNDYi9ReWh3QWZYWkhycGlyQjhXclJO?=
 =?utf-8?B?dldVcXQ3UmlhcVRoLzNUMmxvODNWa0IzczhvTDNEVXJEVzFycXlwRUNSMFBI?=
 =?utf-8?B?bGEycWJzWWd4Y0dFaGt0YzhsVjlDZW1GK3FIWDJuazdrNXpLcElVeVhGVUFj?=
 =?utf-8?B?Vk14SlFRUHA4cFhnUUh1OFY1cE1yelpNMzZIQXBmREpJZWJkSW9yS3pPNUd6?=
 =?utf-8?B?V3ZrRmdBVDB4Y25NcGlJZVFWTFBnNTBRSHpyZTJsS0puOWZyWlplcUxJZm1j?=
 =?utf-8?B?SW80UkZ5MEtmSzhzRGp0bi9ZZkwzcnVkSHZLbzYwOEtreVFGSktlZ0Npbko5?=
 =?utf-8?B?SmJtQWxMNHBiSWs1VVQ5eUxGWWY1a1ArcFlmV01EZmFEUWZoK0ozQjRKQjc1?=
 =?utf-8?B?elVFcGxKSTVnS0NiT3paOS9XRjdIWU92R015SzQ5azVFNU0wMTFtM0MyMWtl?=
 =?utf-8?B?RzdiSkJpU0kyZXpMc1pYS3hOamFjVzdnT0g0SGpTalNTT0I3ZmdGZGlsdjFX?=
 =?utf-8?B?eWEwQm1aMS9qVUhjYmJ0eUxUZzRUU3Y2S2hKWUxZUk1FanNLSndUQ0NoakVk?=
 =?utf-8?B?K0IzSjVsSDVycnpZMk03RlNGanN5L2xDTzBBQW9XZEs1UWdBbGFXR1dJZWxC?=
 =?utf-8?B?KysyZ3FPd3Jmd2JhTHhMMGhSVEJZdU81bEtPKzZOT0hKTzFueFc1SmV5YmdR?=
 =?utf-8?B?UDRNSmIrbEFJQmZKWUN2bmRSMUpzR2tlMEhCb050dGljRVJHOVk1OFpPVjFY?=
 =?utf-8?B?QlFEeWVBNUxUdlprVUkrRU15WmlEVFdPZEYxbTRBM1pVYmV0SU1hT05EWWVy?=
 =?utf-8?B?S2l1UG1ZMjRmc1JkVExlUVRSRmZ6NThhREtwZ2Zvb1ZpS1lFUFhmRTZ2R3Z5?=
 =?utf-8?B?TUZGK3BGKzhsb2pnclEzNXNmK05VSmxKQ2tscFNIU3FrMFV6RnVNaCtzUDFW?=
 =?utf-8?B?SEJlYjhLZ1NTTGt0SDROTXh6OGw0WGFUMlZtUGdOS3lqa25Db0E2VEVqOWl2?=
 =?utf-8?B?ZDVEd0ROVDQrNzZKQ3JmZlAyQXV4RnVuVm5xMjdkZDI3ejhRQUVselNKOUNW?=
 =?utf-8?B?TVkyQWZ3V2JhN0JRNk9oYXZ4d3J4ekFpQSt1YmxEdXZ5NDJ6SnpMTXBlSmR1?=
 =?utf-8?B?VkxCM1d4WEdtNW9BeGV5YUd1WnJjRi9OaHo0cTBFc1JJeFA3Y0V5YTkwQy9n?=
 =?utf-8?B?VkM0ckk3NUhlb280YW81Q2lmL2VGR1lYM2pEaFhTTjV6bm5rYW85T2sxcFZZ?=
 =?utf-8?B?UlNoMENOOWlXYjJKMXZONzBiaFpUdXFORXgxaTJoMDdRcVIwYWwrZmpmTkN5?=
 =?utf-8?B?VVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9302d3b9-ce3c-4b29-c0fb-08de203dc3ce
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 09:44:38.5610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8N1UdIMS3aMvaLEXHiP3p+zQxFfg0VLqAqrQPEJOoaVmmCnby1sUU9vGesm5edvlrunzIFTOBjFEZdXE02vDQoKERljO3FSwN8QxyvU84c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11928
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 10 Nov 2025 09:44:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2470

Hi Peter,

On 11/8/25 11:56 PM, Peter Shkenev via lists.yoctoproject.org wrote:
> [You don't often get email from mustela=erminea.space@lists.yoctoproject.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Currently, u-boot.bin is used for supported rk3288-based boards. But on
> some boards, such as tinker-board, it can not be loaded, since
> u-boot.bin is raw and those boards have raw image support
> (CONFIG_SPL_RAW_IMAGE_SUPPORT) disabled in favour of FIT images.
> 
> Use u-boot.img which is FIT when FIT support is enabled, and raw
> otherwise.
> 
> Also add a note that u-boot.itb should be used if one wantes to utilize
> OP-TEE.
> 
> Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

