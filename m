Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E801CCD1BF
	for <webhook@archiver.kernel.org>; Tue, 28 Oct 2025 09:57:47 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.58])
 by mx.groups.io with SMTP id smtpd.web10.7656.1761645456520997454
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 Oct 2025 02:57:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=e5Xum04y;
 spf=pass (domain: cherry.de, ip: 40.107.159.58, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBYCjEyPxhez/TwpiCdVuiipJBU2ndJ6seyruM8IbuaZAD+SVQ6h1I8b5qhAQAziWUnQWl01djzDftnaAa+SfE7/kMDZCHRfh3YenPaFIyJCRWuqGUw8Jq8rj4uLdu0vBVnbPjietMd8eOE33oO4KTs2vjNvOGeGNtMvLek9zyx7+WKv6TZ2rMYhsTUN0ch1t9nxpdJ5WQP7s8YCEy8D3b05yPK/dGdU0EVnXTaL/1FnsrSAkMvws7dV1up8PQHyI8K1IaTcgK6OnDqAGnO+lHSW/xab2OVAwBDtdhkLiunJRoSpix7wIjg+/ColmeMT5USwW2cBpoUWgX9cHeAavQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzmAZtlGGwjknyrPMfZdLfM3EcV2B82+YjGOZFjeYbA=;
 b=XT3OztjukW/ShSRuPlKwyyNct5g6xbPAONahomvU01l5o8RpJbkIiyMJDjpGscBi6G3RQ96d2BTkurtwhjLeyyJtoRq+zu6XriSKUzi7FAH7WOVK7ZP62xc6RmWiJ7HtgtDZA61gypgU+H9Z1wBlNRNWs1F3DP/m1iXloXYl0xrEhFazIaNQL5saivr1QtiXrmCjeYsUw7Dwob4JQEVDC8d7R81mWJDSrScqOOvZxEs62sTv2W7HFOGtj2mp5bESjR1C4mWRKatTCyaPiI8rpnqARsOzSEsymSMjvVGib0u8ye0UsbZdOVuZn386piROtEVNfrCWT/SwxC+di6r7kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzmAZtlGGwjknyrPMfZdLfM3EcV2B82+YjGOZFjeYbA=;
 b=e5Xum04yh5ZpcX9KbYF5NQDb4iJaFRpzUWPAlP05IMwSE8S+sv8fWxOzh0HukfTEXyZ8MIJSdDjK8LhmQ1HvTngXHu+rPu8tAdhQ7PTnyR1oYBH/HsSUCpKeSxBaYxr/ya9xy/Gts8rMcSQSQTX9M7Jz+3OP6kYPd+lmxp8F+k8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.20; Tue, 28 Oct
 2025 09:57:29 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 09:57:29 +0000
Message-ID: <b8375ff1-3d40-4955-8bb8-378d24cfc554@cherry.de>
Date: Tue, 28 Oct 2025 10:57:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH v2] rock-pi-4b-plus: add
To: yocto-patches@lists.yoctoproject.org
References: <20251027230722.524532-1-contact@schnwalter.eu>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251027230722.524532-1-contact@schnwalter.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA4PR04MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b6aeb68-4560-41f0-926f-08de1608680a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ODhKeXJ3Yit1YVN6T0VZTkQwRk5pQmNVRlVQbHIrUDV5c1A2bkxqRHNrQTAr?=
 =?utf-8?B?VlNjOUlrWlh4L2Q3YXhXWDRKbFhQV21rdFlMd2JCVnQrTjRib2VsbEsrTVVm?=
 =?utf-8?B?SlN3YzN1bk42TTJielYrQTBhdzVBT1lLSllScW93T0RVZC91a1BKKzBNeGcv?=
 =?utf-8?B?dXpOcU55ZW12SzRWajZpTHVhU0VQOGtyOHBjZ2ZwMEdZbnFYelNNNXJDNEdm?=
 =?utf-8?B?bVlaLzJ2V2dUNVFGa3B1NS9haTQ4TkNVamM5R0lTTUQxNHYwN3B5Yy9BQzhB?=
 =?utf-8?B?cGpTeGd1Nzd6T1B1Wk02N29rU21wdk9yN21JNU5TVWVlc2ZuVmRtdFhtSnla?=
 =?utf-8?B?b3VjZFprTS9NVmcvdDhvRlNtb2hVSlMxQ04vdGtwa0NJNC9WTE9jeEQ2cGt1?=
 =?utf-8?B?eWNWcmVJbk5sSEVaZ05USmQxRlRKNll6UCtOMU14TVRnazJZOHViVElIK3B6?=
 =?utf-8?B?Ymdrc01RZTk0NXdGTk1ocFVkTWk0eU9DMlBzeUtod1VsT245RkF5Vzd4eTdp?=
 =?utf-8?B?UWhFejBnV3pGRGlNNmtoTEV1K1RZUUp1aTVFT3JVR0p0ZVVPTG9ncjNnMWNL?=
 =?utf-8?B?NUQrc1hQTXVFTGNMcU92dHN3YzdoR01hZ0REN3J6WHRQdVF3ZUpKbWZFT3do?=
 =?utf-8?B?em9CdDAzZkMwRFJHZXdrNngrRmlybGpFd0lnbEprK1VOK3dkc3J3M1dkOXcv?=
 =?utf-8?B?Ty94d2xiZjhtbHkweGtnanp6ci82Z0xUMnhMUjllczNqQy9rdXc5Z3k3Q05w?=
 =?utf-8?B?RSt3VTdXZlA2YlRRM1dacmszbWdLTDYxb1ZxL0NBdTRudWVKOXN0NXAxT2xJ?=
 =?utf-8?B?d2xSR0ppTHU2ZUtFUUFoM2tuT0xTUk5IZ1VnR0wwUEhHRjNpNlZsclh5L1hN?=
 =?utf-8?B?TWE1Y042L2krN0hla2ZLQm03Q0lRUGdOM0UvdGZIQ3NkNS9KN3E5ejl3TXNE?=
 =?utf-8?B?ajRKYk5hMml1YW0yVXpJNmg0T2RLdU5zem55dTRWZHJvSGUvdm54RXdtY01q?=
 =?utf-8?B?UmFPeCsxdzB1cCtDR0VlbDRTaENYK2JLcGJYYm1UaHFWSWUxaUFBNHdkUjJP?=
 =?utf-8?B?dGc0a1hySmNhYmVBbDFTTzVRZFJTcWxGWXYvanJCYWoyc1VRUkh4N0pYT3Q4?=
 =?utf-8?B?b1cyUWZMaXJrQ2h1MXo0OEdoaHF3MnJiL3VRZmdpOE84Ymc2UzY4MGxZaU9h?=
 =?utf-8?B?ZFJBUmY5NE0xVjhmRVVFczU2TmpmcmxJenVTaVhaNkM1S3NMMDdXYjFSSmRF?=
 =?utf-8?B?UzBzRzlOVWRxeWluUXU1a1QvOFdVUjVVeGdTVnpHVXNXQ2RUeTFkSnFRN21h?=
 =?utf-8?B?eGhEV3NvV0hSeDcrWFR3NjljaDZPRyt3b1FzQ25oYmdBN1UyRzA2NUM0ZEts?=
 =?utf-8?B?T1pxZWoza3EvUnJBZ0xUclc4citiZ291T25TNzdHdTZ4c0QxT1FnYVpPRkxj?=
 =?utf-8?B?WmZkU2NPVFdDNFFyS1cyL1JVbDR5TXJubDBvVTZtTmp1S0RSYklnTHQ1eUdX?=
 =?utf-8?B?Q0gzQnZJRE5zS2FIRHRFTW1EOXE4ZXphVENIMm96OGV6Yzhsd3ZGSk9SOGhX?=
 =?utf-8?B?L2FacXorTUlIc1FGWEM1SnREaXYxcUtyOHVhOHZKZDRDNk8yQng3aVB2VHgz?=
 =?utf-8?B?U3ArWkwvWWs3WC92cGpJcGNmZHd2eWc5Skc0aS9FZDloS2crejlDbHZsTUxa?=
 =?utf-8?B?cFh5blF5WTRxMFdhR2V4QzQvNDhKMjcyQU5jNmsyVk9OcU5RNVBBY3k2N3pp?=
 =?utf-8?B?NVlRSzhQQy9YTzcraHhjRDVRVFFwWUlKcXo1SklWTWxHdHBUSVljdnF0Um9k?=
 =?utf-8?B?bWZDeUF6d2w1MllqR1BnaHZ0T3grZVg2RTIxRUVYY2J1OWZoM0ZGanpVOFhz?=
 =?utf-8?B?c1lSRVNxNGpZbmFBK1NlS0xxeHdMbWJueXB4TU9qQ2ZkQkE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K1BPRGtJQUsrM1pFQ2xWVWFqOW0xSzJCYUVzaTdkRFpodEQ3dWtVU1d1ajZm?=
 =?utf-8?B?cFB3Mm05OVhkZGpRQkVCNUNMR0JQaGVROUdOWEtlc1JyVGcwaUkzK0xrZW9n?=
 =?utf-8?B?djlkUzkxMXpHWmk5ZllMdGRYR2IwUUlWdTJQMzN6NGRJamdNY1Z2dkplOTNz?=
 =?utf-8?B?aFo2OVl3Q3JueklKekNQNmMwZ3VxeGRFczhDMFJVQW5MY1dCWmxzVU4yTXgr?=
 =?utf-8?B?V2VRaS9rdU9kMU1WSHNjcW1BZnRvMmlKUjNsSEZsdWs3cHFwZHFaNkY3SzRj?=
 =?utf-8?B?bnBDRUQ2cmViemVDdlRQVld3RzJaTGZRVnUrbU9FRTk3aHIvak1zUzQwUG5O?=
 =?utf-8?B?aytVR0RIMVQyZXJxVnBpYzdtdTR0azBrOUdwenpjVm5ZSnZMOWxVU1F1bDVj?=
 =?utf-8?B?NlFIRTJ0eFRKclc5WWRZbEFIays3QzV2YXlmajNEMXpkQXFIWGczelh6djNC?=
 =?utf-8?B?OUhVV3g3YjMzZ0lRaWpBRzNLcFk4SWlycGF5QkN2S0tCRHdieEpCRUw5QXRu?=
 =?utf-8?B?My82MGZ6VkJaZGVBVDZTeWlRdkl2MC83cHhZcHA3Y1lFRXduekIrOXBSejRj?=
 =?utf-8?B?bWRDcG1xRXFxQmhVNGM5YlJvYUtDSHM1WXVyRkdzWjN5WkNOeUdhY0lBME1i?=
 =?utf-8?B?STVnYVU3bTB1U0JjRWZFTVU5dlN1ZnZ2WXQvaGIwRnluaFk3VVVOSmEyN05G?=
 =?utf-8?B?MU1TMTNGVlpBMWZ0SXNWZm5oMG51RUlRaEFrS3JEbUFkdmU3V3ZMMlZURE9O?=
 =?utf-8?B?VTRlSEZHOW5ZUDBkMkJWOUNvUXVkZzF4WGVSM24rd0ZqbFFhdFNNeGZlNk53?=
 =?utf-8?B?dlpndnJlKzVOU2ZmUWdtcXc3dTQ2MEtoS3IwaVlReHdmbmJtV2gzSnl0UnR5?=
 =?utf-8?B?Qy84WStwMGUzaW03ejJ2RGNmK3VWMlFBZTcxcVJrT1pQUHFoeHd5b0UxU01y?=
 =?utf-8?B?aHlteUVVbEovOW5lUnlHV2ljRGY3OFRKV1dPZll4eGFnYTYvb01uWldvdkxM?=
 =?utf-8?B?NE5COHNFS0J1YS9wS25DNHdFSmhWdDFLUDBha2YrTjNBRGFWU3JBc0MwWXgx?=
 =?utf-8?B?YkpFZVBCalV2QUNxTnZRdmFGRnVPckVJK2phVTUySjB5WDZQdkxDb1hTVW02?=
 =?utf-8?B?ejBtT0Y5TGt1eXFjeU9KUzdnaVNpdUEvYzZDUjNJTTcxLzU4b2szQlVKNE1F?=
 =?utf-8?B?YUgwOEJsM01JM3dXL1UxYngzLy95cXRLRlo4UTJTbVRVMTVMOGQ4VThpUzlm?=
 =?utf-8?B?SlNvV3ZYbEVJM0piN29JK1hxVitoYjZ3cnpVYnVjdGx2MjFmdkpxMWdkZmxT?=
 =?utf-8?B?K0k3Y0J0aWR5SGhqRkJMVUlkdmxhcnA1aTlLbmZOZVdlMHJJaUhxdnV2WmVI?=
 =?utf-8?B?SlBHcGNLVVhMcFkrL0pqL0YwWUlGN05DQXFvSFlkT1oxdXFGanNOcGJBaVFM?=
 =?utf-8?B?MU1VdE5sSWkvUm5hL05YNStpYWJaU0d2MGNCenNITU5lS2kza054bnY3VzRN?=
 =?utf-8?B?RzduNEo4NmNRQlZENGhPOEdqaFhGbjIzT3hMei90QlJmbVZnT3NtcWkxdmIr?=
 =?utf-8?B?TTg1L25wSVgvazQwSGxsVm9RWVV5QW9RS0hHa1NVa2s1L0t5a1Z3WU1MMFUx?=
 =?utf-8?B?VXlrRGlyRnFqNjhQd0o3S2F3NE01REI4OWZlMG1Odnl6TXRKWHU1d1RLR01h?=
 =?utf-8?B?Rk94azNKeTBlZE80MS96UXVTeUJvb2t0Qi9SVnBhbzd6Nzd2cGNxN3ZaSGdB?=
 =?utf-8?B?b2Uvam16Nlc1QjNvRDVTTWFNWTdxcDFHeXdLdVlLd0VOUExGRzdobnJxS3Ix?=
 =?utf-8?B?aC8xc29KZVExUmEybGZmbEY0U2F5SjdQUHF5L251Zk0zRUFOME9IbDcxVFZZ?=
 =?utf-8?B?SllIWWtUYzFaenY2dkE0bnlUcmg2NWdXREZKemlhclB0Q2VhVlVZR0N1MHl0?=
 =?utf-8?B?ZXRrNzFnOWt5cWdTWmF4MEJlQjNsRmRXYmtXWUp2c1NPWFVzQk1FQTBLaThn?=
 =?utf-8?B?UnpKa0VYZHRwb3FNTHh3NmZmN3Z4U1FUZlZobUZQZ051Uys2MklvdnNPKy8w?=
 =?utf-8?B?T0dYL2wyN0NnTXpLNnE5RklTSXl6TnRBTEtSL1RWbUlISGVUYUxLc3JTaUVH?=
 =?utf-8?B?bnI5V1JTdy9QR2tJWndJZGl3NHhUS2JFaThBNlZ2VnJjOEJuY2JEZkYzdzJy?=
 =?utf-8?B?R3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6aeb68-4560-41f0-926f-08de1608680a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 09:57:29.5890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: diYiSqaybIskfSt8QcDCeAvL6M9FxWwJ4C+ozqU/CCJxE+kA5YcYHgkVGk+yR5zkSm2vcAFyfCNYaGx/qqvwp82p/G41eiOFOBc9N/Aiqn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7533
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Oct 2025 09:57:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2398

Hi Walter,

On 10/28/25 12:06 AM, Walter Werner SCHNEIDER via lists.yoctoproject.org 
wrote:
> [You don't often get email from contact=schnwalter.eu@lists.yoctoproject.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Signed-off-by: Walter Werner SCHNEIDER <contact@schnwalter.eu>
> ---
>   conf/machine/rock-pi-4b-plus.conf | 9 +++++++++
>   1 file changed, 9 insertions(+)
>   create mode 100644 conf/machine/rock-pi-4b-plus.conf
> 
> diff --git a/conf/machine/rock-pi-4b-plus.conf b/conf/machine/rock-pi-4b-plus.conf
> new file mode 100644
> index 0000000..9a5117b
> --- /dev/null
> +++ b/conf/machine/rock-pi-4b-plus.conf
> @@ -0,0 +1,9 @@
> +#@TYPE: Machine
> +#@NAME: Radxa Rock 4B+ RK3399

It's an OP1, not an RK3399 :) (essentially an "overclocked" RK3399)

> +#@DESCRIPTION: An RK3399 SBC with Wi-Fi 5 & BT 5 and PoE Support.

Ditto.

> +#https://docs.radxa.com/en/rock4/rock4ab-se
> +
> +require conf/machine/include/rock-pi-4.inc
> +
> +KERNEL_DEVICETREE = "rockchip/rk3399-rock-pi-4b-plus.dtb"
> +UBOOT_MACHINE = "rock-pi-4-rk3399_defconfig"
> 

This configures U-Boot for the Rock 4A actually, c.f. 
https://elixir.bootlin.com/u-boot/v2025.10/source/configs/rock-4c-plus-rk3399_defconfig#L8 
and 
https://elixir.bootlin.com/u-boot/v2025.10/source/configs/rock-pi-4-rk3399_defconfig

Considering the only differences (according to the Linux kernel device 
tree) are the presence of a WiFi+BT combo chip and being based on an OP1 
rather than an RK3399 (OPPs differ, the rest stays the same apparently; 
doesn't matter to U-Boot), and that Rock 4B is supported the same way in 
conf/machine/rock-pi-4b.conf, I guess this is fine :)

It would have been nice if we could detect which board of the Rock 4 
series we are running U-Boot on at runtime so only one Yocto machine 
would be needed to support all... But checking the SARADC on 4A, 4A+, 4B 
and 4B+, they cannot be identified like that sadly.

Can you please update the supported list in the README to add this new 
board?

With that,

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

