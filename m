Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3674CC4345F
	for <webhook@archiver.kernel.org>; Fri,  3 May 2024 13:23:09 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.114])
 by mx.groups.io with SMTP id smtpd.web10.12512.1714742581610854493
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 03 May 2024 06:23:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=jXFm++mf;
 spf=pass (domain: cherry.de, ip: 40.107.105.114, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7wMZQn2LIZfp5Y5bBFLAKKOBGiJLgJwCC7JJNyD53aNwdBYaSMxSSmPPbfQnwQ2Oaedko7AXhYXIQ9/5WEtKZQZ+lWm1uZOSQZ8kqt5W4wAPiJ7PDEkAX+zY+4RoYNrlRbZi5QxjsDdHYa47lXWoAn6xmn/pEAuJ7e76it9GxSZfCSyw9tDOfkKFjf4LAgFk283zxStufzio14C280J1ZLtKdLt1WKxvsXl+W7id/eKxNnfvkiKbWKmjKG4AimDFEUyAtOj8f9ha97aW0xCFrohLsRParnIx6ab5R2DDf7OKL/7FvaoAzde22uafrDeNn16zSx2YSe8uF+OaUkK4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsj2SGySat97+Iyjeas8px9dLnMZ/lE6fVlFQmL/oss=;
 b=Z9p4+EmZSI4Ig2aCw2QN5ZRLVuMiZWtQAJBE61+q5uJfYCW0asp3tifxwSk1UeRrdiW0cmA56phbo/3tc3rowu/8Qj/7gZnuYsiipdqkg/EPUJS5BYw8pv2aaro8KusZVisID9Yll4Ec7JX87PtGAKwLfAXdToKbwvvH9cSDymim4m9CQyetlxcY9gR4ssIcFvtRhbr1iLBgg4TSyUlEYXkQZqhyba8OQWipEOCXSgL+bRFPd4ZKAJ4QATnhv347IB74CG0Nv1LhFYNGlHCsLi2me/aNqUvJNXnEtReCXBv3Ca9qR3F2qz1eG4viVuWm0WEkDhABb3DDdAv4HWZxpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsj2SGySat97+Iyjeas8px9dLnMZ/lE6fVlFQmL/oss=;
 b=jXFm++mfC0g7lIshEZrqk7PKgYIu6yPyOriawREKUtyiMzIE+Q0hv+Cd5yAyPO/3xfmS55FGDVTxMm64SYyUqe6X31Wcws2Rvw1KyAycTyN8Enak4zigj2Bw4mN4H3j+yR/iIfan0rVmKd9z3kwg/eCaPKepwBaJXozjaQeh6zQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by VI1PR04MB9787.eurprd04.prod.outlook.com (2603:10a6:800:1d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Fri, 3 May
 2024 13:22:56 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::ac08:df46:97bd:4ae6]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::ac08:df46:97bd:4ae6%6]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 13:22:56 +0000
Message-ID: <933c30f5-f6ee-4e8f-a976-70a06e083fcb@cherry.de>
Date: Fri, 3 May 2024 15:22:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v4] enable stored U-Boot
 environment
To: yocto-patches@lists.yoctoproject.org
References: <20240430202359.12771-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240430202359.12771-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0005.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::28) To DB7PR04MB4842.eurprd04.prod.outlook.com
 (2603:10a6:10:1b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|VI1PR04MB9787:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f18ea51-4663-4798-b4a8-08dc6b742507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bEs4dXV6cmNzbWh1U2xtMkh5Qng3NmVIL3MwdmUyRWs3bjd5SHJiQ3hGNDhX?=
 =?utf-8?B?VjdsWTl2UFlORGc0eU9Ca1FSZ1B4bmNKWXRQYVh0NndiQlhoangyUVEwektT?=
 =?utf-8?B?TURqNitMMC82WDhBaUlJcHJDZC92K1pRWmdIMHpraEZQS3VlVTdUREFVS0ZC?=
 =?utf-8?B?dysyU0diZlVLNXpYeXFrOVZNNUdSbFBXT3FMN09SdmRjS1RnVUdQc2VobDVT?=
 =?utf-8?B?dm1JUTdTUkErUjR5elM1RTN0NFBkQWhqN29VOUFobEUyV3p3Mi9xRzJmS00z?=
 =?utf-8?B?blZYdDhhZlVvUGs3VlJIQzJNNko3OGMrVHdkeXFXaTBSZjB2eGt4UFhKYmlD?=
 =?utf-8?B?d2tvMmdNc3VVaCt6MmExaDQ0b2NKM3ZDQ3lRZnIyV3NJbFJRT09WZFMvQnpW?=
 =?utf-8?B?VGJKbGlnTGFBU2xSZnRodjlNb205VkVZdzYxS096SGRXL015Q3VTYjlrZ1B6?=
 =?utf-8?B?dm4zMVpZWHJOSi9BQWI5ajFGcEFyMjBqR2tYUktXZ2ZrbDF1ZDZvbFQ3L1VH?=
 =?utf-8?B?aHNpZlJnSXZscmFIN0l1UGdOUXV6L2g0OE96eEkwVmNnWnZHYnFUV080V254?=
 =?utf-8?B?Y0dUM1RsbkszNW5nM0Z2OExqWWgyM3pUNVhvREhEVlExV0NmTTRZdkNVMjE3?=
 =?utf-8?B?MVhXUjFTeWNtWmV6ckR5NUdKSWlRdnNPdk45aXRlRTRDNE0zRTNBb3NSNWFs?=
 =?utf-8?B?OFdzQ0p6RW5xd1ltTFd0S0tYdWhNSTVtSlFlYkJ5TnpNbWt2bGpiUFdFWURw?=
 =?utf-8?B?L05CQ3FtaWJ4djN1QzZ0MUx6dXVlejd5SjZneWN4ZTZseU5sV043WkhGakNU?=
 =?utf-8?B?RVh3aG13WWhhaVo2V3M1cG1qNFZmelU4OVAzcHZyWTZnZ01uNkdFWGNPWWVI?=
 =?utf-8?B?ajlVUkgrYzNYU1dnWUx1SVI2dEQrLzg2VXIvQVpXM0FzZlIxUklhUlJ4TnhU?=
 =?utf-8?B?QU0yWHFyTEtTQXdpOG9IaWxJUUpWd1VVeitCWFUzVERFZVFJNTRPOFIxYmxz?=
 =?utf-8?B?d3RSR2dPRm5NVHFEVDFPV3hTejVQeEhxY1N5Z0pINWtKTjZUWTg0dTFqVEMv?=
 =?utf-8?B?NXFuQkI5ODNSNUV2RHNLaFExNDkzZTRpV2UrdkcwSDhSOHU2cGpOMjEyaVA1?=
 =?utf-8?B?SW5URzFVOWo0ajdHanRTQVZhRTBBQW9paUFWbkIwc1pTYnVxcjNheG8yUkhS?=
 =?utf-8?B?QTA4S00zRVFSWFVtZzRMV0wzRTZTRjlSKzEyZzFNSG9Ib0EyQTExNFlObldZ?=
 =?utf-8?B?b0RaSVh5YmU1aXYzSTVQd3JvQ1ZIdDZrNy9nUDVwTHJER1NTeVd1MlJnRnVM?=
 =?utf-8?B?MndqMmZHcWI5S0JTVXZFb2I2YnVBL09Mdms0dERiUzIwc1dkY3FoUWhleEE1?=
 =?utf-8?B?WjBtZ1FKNGNwVmlhTCtBK2kyMGYvblhYallObE5KTTJWRThVcGNCMHZPZE9r?=
 =?utf-8?B?RG5tbHFVMTJaZC9halIvdnhoYlhQblB2OHcxSnE2bkhIS1UvanFHSmFOSGRo?=
 =?utf-8?B?bFpwb3h6Rm5iQWdQdmN2b1JKckRTL0liQjBCM2J1VUl2N1U5Q2JEQ3BNdW5V?=
 =?utf-8?B?ZGRGTS8zdU0rakozUjUxN3ZtOWw2azA1ZERIc1gxWkJ2QjFKL0sxYTRpM0dr?=
 =?utf-8?B?eUx2VnFsSW1CV1lmR1YxNjE2YkJTU283TndnZUhuTWNEM1ZWajR4dXhNUFc4?=
 =?utf-8?B?NjE2dUFreUgyaFQzbmxvMlRHRlIreFFHK2pFZSt6WFZtSzJUcHQwSDZBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4842.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZHJaTFd1OXhkNHNJVmZwRkE2a0F3aHFhWGE2SW5sVlBFZXRPSGZ5VlZ3MXNz?=
 =?utf-8?B?NWZzYU1kdnJrcDRIZzlUUjRRQmlXTnBhZjJpa2lwZ2JaRWFHNnR3QXJSL1BO?=
 =?utf-8?B?RjJhcnZEUHJNZXRPMDFWZER3enJnb09SSSs5WkxwZi9ZbHRIWE80bXlhYmt3?=
 =?utf-8?B?RUd6eFI0enZWMVhKZWtLS0FDZ0RXMVFUUlhsRXQ1VkdKZVlON3BGREROSDlP?=
 =?utf-8?B?K3JUTGoycUtkQUFtL2ZvUW1VMzVTdjBEaC9MYmV2eGNkNlowQ0J1bGQzM0h2?=
 =?utf-8?B?ZWM0U1pRdWFXZzUwOTdjNXY1Ylk4bUk5ZjZWY0QxVGVGNDV2ZXdTSXJaQVQx?=
 =?utf-8?B?bmNHa1kxRHVJVzRzejJGc3hNTHRYeWFMSUFxRGZ6VVp2QUdkN1RFNVFVdHNT?=
 =?utf-8?B?NlE0cm5ZN0s0M0E3TUU1eXJuWExvWFhYd1hwbmRvaXZsRWxKVVRTZG9kQmx6?=
 =?utf-8?B?R1gzSW1BVmxWZlhHODNveStEM3RGTkNqNEQwMjE3bUQ2L0FFYXZBa0dYRFFB?=
 =?utf-8?B?bHdmMjhRRjkrT01NRDlWdWJSUHlSZlR5TEFyb2JtTmQ0SlFhdVJCSTBCQlk1?=
 =?utf-8?B?TXZIWkNocC92U0w1VHdPbnk3Tjd0bWRaUlhXdERCeGdKVVVxM245TmxIQU5W?=
 =?utf-8?B?YnczT0dES0NrYzkyS1NOZVk2ZU5PM1g3czNkRUs0b25ubWduOENtTEZNbVFr?=
 =?utf-8?B?WncwMjJHSzRYNTFSVDJJNVdXbG5SNVppZ3puak1yV20zcVFacCtrTDVpR0g2?=
 =?utf-8?B?SHYwTSs1dEQ4ajM4bHVuR2tlOG1yZCtST0l1QkFoM01WWm5MMzh5cW95R3ZN?=
 =?utf-8?B?ZEd5RlRRUmZRNm4zMnh2aGVpWWRjV2J5bkQvMDlwRW9ucmhUVW9NbDhwYjNw?=
 =?utf-8?B?QTYxOUY5MnlPV0l4ZDhDTmNSd0F1SGNzM1pQRkx1L1N0dEJ5dUdIYnhEMkNN?=
 =?utf-8?B?dFFRN0Rnb0RhQ0VQZkNld0RzdHM5cC9PTVNTRzBkY2plUCtURGJHQ3NjQXJX?=
 =?utf-8?B?TXF3K1Z0RFp0SThjNWY0cjR3cTlLeHJUVFFVRHVydHZrMU1uelBiVEJjaHY4?=
 =?utf-8?B?d042dXhDRGRnWGpERXBXU1pBQkRyVjFDUWx6Zkt3VldhalNRR1M1Tmh1c2JU?=
 =?utf-8?B?OEtZQWNsWjVER1VEN2hVQXlBZjkzUVpjd3ZYRnZnL2tIY0k1TkQ2U1N3Vmd2?=
 =?utf-8?B?eXVEQ2krbUJWb1JrZ3FVT1lNUEE3cUJBOS9KZ2NGTFpCWm9PL0JybjZCdHZJ?=
 =?utf-8?B?bVRaNjNUNVJYbkczK0FWRzFraVlkVlJ6RThCWHFDNVYvT0s4dlVuR0tYNmxI?=
 =?utf-8?B?QmU3VVVJZjlOaFhjZis2eVBMaEkyRUU4TFQrZW4xb2R5QzIzNUlHOU1iNkho?=
 =?utf-8?B?WmdaVnRQUHB5NER1SnhwUDhMYmRBcmhtbC90R0drOXMxd2Z6N1B2aGg1a3lv?=
 =?utf-8?B?SFZUNEw4QzdPQm1JYnlYbXdVd0NSRHpBQmNXa2c2VDh5WVFoMjV5QXNtNkZo?=
 =?utf-8?B?d094Q01lWWFsenR5VHJERWZMVFZ6L20wbWp5a1ZUZnNsdFF6KzA1dDQwKzFq?=
 =?utf-8?B?aG50UnR3UjVZZkFiV25aQldldEplUGd6b0lKZjk3bTJ3aENzcUVPdG5PUEtK?=
 =?utf-8?B?OG5OSHZiUmYvWHpBWmZLR3JoTUpONFhDMEw2aU51OXAwNUpVMzVsU2c3NjU3?=
 =?utf-8?B?K0hLNm5YTGs5Z1l0SXF4V1RNZ2MrV3I3SjNiY2hHck9ZaWZYTnRXQXl3WjBW?=
 =?utf-8?B?UXZsbW9KaCtwZ0tLNWVxNGM4Q0lpOVVpQThDQVArWVFMcHF5a1h6YXBiNXhX?=
 =?utf-8?B?N3J6WmEzbnllTGxTVTMzZjZValZ4NFhGVDdZSGFHTnpIdnR3SWdGU3V5REJP?=
 =?utf-8?B?ZE5XK2d4YjJWemFudW5kRE5hTkRZd3gvU1FiT3NwbFBnb3BMUnU3UEV1Q2FF?=
 =?utf-8?B?a0RtT0tKdThYM0lCTFZqRU5aYU1DWEl2Nk1NRllXZmwzSnRiY29KcnFqQy9I?=
 =?utf-8?B?c1REdWlpK3kwODRtNSs1YjN0NnlEeHJpRGkyWkJsSUNpVW5NVS8yUGMwbFRM?=
 =?utf-8?B?WlJYa29jckRWZlU2R3BWck13dmtRNlB3NUloRjhzbEJiVlUzcG1pSHlOTW1m?=
 =?utf-8?B?S3BPdE54M2FaeXBvMGpQL0JROTdiaUVhNU1DZFY2VmNQZzkwZlpjYTArdmoy?=
 =?utf-8?B?dmc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f18ea51-4663-4798-b4a8-08dc6b742507
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 13:22:56.2553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SlofPJIi5+7nY6WbLlmY0B3B6/hyG82uZNkneY+ntFwz7gUKZ37x32x2QG/FjnQ8xv0m87tNdf2krztOTjEJdh7GzhfpzaeVSgLVeWugKoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9787
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 May 2024 13:23:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/81

Hi Trevor,

On 4/30/24 10:23 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> U-Boot has the ability to store its environment variables to a permanent
> storage device. Whether or not it does so for any one specific device
> depends on whatever settings are enabled in that specific device's
> defconfig. In order to definitively configure U-Boot to be able to store
> its environment into the device from which it boots, for any device
> supported in this BSP, simply add the following to MACHINE_FEATURES:
> 
> 	rk-u-boot-env
> 
> If enabled, there is now a second choice to make: should the build also
> include the U-Boot environment in the image or not? The default environment,
> as generated by U-Boot, can be included in the generated wic image. If it
> is included, then flashing the image will also flash the default U-Boot
> environment variables and settings, wiping out anything that might have been
> there already. If it is not included then your device will either continue
> using whatever environment happens to be there (if valid), or will not use any
> stored environment if the stored environment has not been set or is invalid.
> The variable which governs this behaviour is:
> 
> 	RK_IMAGE_INCLUDES_UBOOT_ENV
> 
> By default this is set to "0", meaning that by default the image does not
> contain the U-Boot environment. To enable this behaviour, enable this
> variable. This variable only takes effect if rk-u-boot-env is listed in
> MACHINE_FEATURES, and has no effect otherwise.
> 
> The script:
> 
> 	scripts/dump-uboot-env-from-yocto-image.sh
> 
> can be used on a rockchip wic image to see the contents of the U-Boot
> environment partition at build time.
> 
> Tested by booting the same image on both eMMC and SDcard with the following
> devices, verifying the ability to read and write the U-Boot environment in
> both U-Boot and Linux user-space, and that changes made in one are seen in the
> other:
> 	rock-3a
> 	rock-5a
> 	rock-5b
> 	rock-pi-4b
> 	rock-pi-e
> 	rock64
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
> v4 changes:
> - sort WICVARS alphabetically
> - tweak dump-uboot-env-from-yocto-image.sh script to not just check for
>    the existence of the user-supplied parameter, but that it is a file
>    specifically
> - u-boot bbappend:
>    - use a do_compile[postfuncs] for generating the fw_env.config instead of
>      a do_compile:append
>    - move the conversion of the U-Boot text-based environment to the
>      require binary representation from a do_deploy:append to the newly-created
>      do_compile[postfuncs] created above, this will allow the user to inject
>      any extra U-Boot environment variables they might wish as part of a
>      do_compile:append and have that occur before the binary is generated
>      so that those additional user-supplied values are included
>    - add a lot of extra checking (instead of assuming various resources exist)
>      before making use of said resources
> 
> v3 changes:
> - switch from using a bbclass so the `rk-u-boot-env` override can be used
>    directly
> - add SPDX header to script
> - drop `inherit deploy` in U-Boot bbappend
> 
> v2 changes:
> - re-word the commit message and README for clarity
> - use bash's built-in math handling instead of depending on `bc`
> - in anticipation of the upcoming feature in U-Boot whereby rockchip
>    devices can automatically select the environment storage device to be
>    the same as the boot device, use a more recent SRCREV for builds that do
>    environment handling, instead of hardcoding the environment storage device
>    by SoC family
> - handle RK_IMAGE_INCLUDES_UBOOT_ENV as a boolean
> ---
>   README                                        | 20 ++++++++++
>   conf/machine/include/rockchip-wic.inc         | 11 +++++
>   .../rockchip-enable-environment-mmc.cfg       |  6 +++
>   recipes-bsp/u-boot/u-boot_%.bbappend          | 40 +++++++++++++++++++
>   scripts/dump-uboot-env-from-yocto-image.sh    | 29 ++++++++++++++
>   wic/rockchip.wks                              |  2 +-
>   6 files changed, 107 insertions(+), 1 deletion(-)
>   create mode 100644 recipes-bsp/u-boot/files/rk-u-boot-env/rockchip-enable-environment-mmc.cfg
>   create mode 100755 scripts/dump-uboot-env-from-yocto-image.sh
> 
> diff --git a/README b/README
> index c76fc9131276..605773d4ecd3 100644
> --- a/README
> +++ b/README
> @@ -67,6 +67,26 @@ Notes:
>   	
>   	in the configuration (e.g. conf/local.conf).
>   
> +U-Boot Environment:
> +------------------
> +	In order to configure U-Boot to be able to store its environment into the
> +	device from which it was booted, for any device supported in this BSP,
> +	simply add the following to MACHINE_FEATURES:
> +
> +		rk-u-boot-env
> +
> +	If enabled, to additionally have the U-Boot environment generated and
> +	stored in the image, also enable the following variable (default: off):
> +
> +		RK_IMAGE_INCLUDES_UBOOT_ENV
> +
> +	The script:
> +
> +		scripts/dump-uboot-env-from-yocto-image.sh
> +
> +	can be used on a rockchip wic image to see the contents of the U-Boot
> +	environment partition at build time.
> +
>   Maintenance:
>   -----------
>   	Please send pull requests, patches, comments, or questions to the
> diff --git a/conf/machine/include/rockchip-wic.inc b/conf/machine/include/rockchip-wic.inc
> index 147a36685d7d..92749b514499 100644
> --- a/conf/machine/include/rockchip-wic.inc
> +++ b/conf/machine/include/rockchip-wic.inc
> @@ -2,6 +2,11 @@
>   
>   require conf/machine/include/rockchip-extlinux.inc
>   
> +# 'rk-u-boot-env' indicates the user wants to be able to save their U-Boot
> +# environment back to the drive from which the device was booted
> +MACHINEOVERRIDES .= "${@bb.utils.contains('MACHINE_FEATURES', 'rk-u-boot-env', ':rk-u-boot-env', '', d)}"
> +IMAGE_INSTALL:append:rk-u-boot-env = " u-boot-fw-utils u-boot-env"
> +
>   SPL_BINARY ?= "idbloader.img"
>   
>   IMAGE_FSTYPES += "wic wic.bmap"
> @@ -11,7 +16,13 @@ WKS_FILE_DEPENDS ?= " \
>   	virtual/bootloader \
>   	"
>   
> +RK_IMAGE_INCLUDES_UBOOT_ENV ?= "no"
> +RK_UBOOT_ENV = " "
> +RK_UBOOT_ENV:rk-u-boot-env = "${@ '--source rawcopy --sourceparams=file=u-boot.env' if \
> +	bb.utils.to_boolean(d.getVar('RK_IMAGE_INCLUDES_UBOOT_ENV'), False) else ' '}"
> +
>   WICVARS:append = " \
> +	RK_UBOOT_ENV \
>   	SPL_BINARY \
>   	UBOOT_SUFFIX \
>   	"
> diff --git a/recipes-bsp/u-boot/files/rk-u-boot-env/rockchip-enable-environment-mmc.cfg b/recipes-bsp/u-boot/files/rk-u-boot-env/rockchip-enable-environment-mmc.cfg
> new file mode 100644
> index 000000000000..778772d27767
> --- /dev/null
> +++ b/recipes-bsp/u-boot/files/rk-u-boot-env/rockchip-enable-environment-mmc.cfg
> @@ -0,0 +1,6 @@
> +CONFIG_ENV_SIZE=0x8000
> +CONFIG_ENV_OFFSET=0x3f8000
> +# CONFIG_ENV_IS_NOWHERE is not set
> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_DM_SEQ_ALIAS=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-boot_%.bbappend
> index a83179a9f007..3dd7f08732c5 100644
> --- a/recipes-bsp/u-boot/u-boot_%.bbappend
> +++ b/recipes-bsp/u-boot/u-boot_%.bbappend
> @@ -1,7 +1,13 @@
> +FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
> +
> +SRC_URI:append:rk-u-boot-env = " file://rockchip-enable-environment-mmc.cfg"
> +SRCREV:rk-u-boot-env = "cdfcc37428e06f4730ab9a17cc084eeb7676ea1a"
> +
>   # various machines require the pyelftools library for parsing dtb files
>   DEPENDS:append = " python3-pyelftools-native"
>   DEPENDS:append:rk3308 = " u-boot-tools-native"
>   DEPENDS:append:rock-pi-4 = " gnutls-native"
> +DEPENDS:append:rk-u-boot-env = " u-boot-mkenvimage-native"
>   
>   EXTRA_OEMAKE:append:px30 = " BL31=${DEPLOY_DIR_IMAGE}/bl31-px30.elf"
>   EXTRA_OEMAKE:append:rk3308 = " \
> @@ -34,3 +40,37 @@ do_compile:append:rock2-square () {
>   		cp ${B}/spl/${SPL_BINARY} ${B}
>   	fi
>   }
> +
> +rk_generate_env() {
> +	if [ ! -f "${B}/.config" ]; then
> +		echo "U-Boot .config not found, can't determine environment size"
> +		return 1
> +	fi
> +	cat ${B}/.config | grep "^CONFIG_ENV_SIZE=" > /dev/null
> +	if [ $? -ne 0 ]; then
> +		echo "can not find CONFIG_ENV_SIZE value in U-Boot .config"
> +		return 1
> +	fi
> +
> +	UBOOT_ENV_SIZE="$(cat ${B}/.config | grep "^CONFIG_ENV_SIZE=" | cut -d'=' -f2)"
> +
> +	# linux user-space U-Boot env config file
> +	echo "/dev/disk/by-partlabel/uboot_env 0x0000 ${UBOOT_ENV_SIZE}" > ${WORKDIR}/fw_env.config
> +
> +	# convert text-based environment to binary suitable for image
> +	if ${@bb.utils.to_boolean(d.getVar('RK_IMAGE_INCLUDES_UBOOT_ENV'), False)}; then
> +		if [ ! -f ${B}/u-boot-initial-env ]; then
> +			echo "initial, text-formatted U-Boot environment file \"${B}/u-boot-initial-env\" not found"
> +			return 1
> +		fi
> +		mkenvimage -s ${UBOOT_ENV_SIZE} ${B}/u-boot-initial-env -o ${WORKDIR}/u-boot.env

Could be put into ${B} instead of ${WORKDIR}, since we generate it? I 
guess since other files we generate are put into WORKDIR, it'd be up to 
you here.

> +	fi
> +}
> +do_compile[postfuncs] += "${@bb.utils.contains('MACHINE_FEATURES', 'rk-u-boot-env', 'rk_generate_env', '', d)}"

I can suggest:

"""
rk_generate_env() {
     :
}

rk_generate_env:rk-u-boot-env() {
    [...]
}

do_compile[postfuncs] += "rk_generate_env;"
"""

Which is a bit more readable for the do_compile[postfuncs] part. Up to you.

> +
> +do_deploy:append:rk-u-boot-env() {
> +	if [ -f ${WORKDIR}/u-boot.env ]; then

This is an issue. If one builds with RK_IMAGE_INCLUDES_UBOOT_ENV = 1 and 
then RK_IMAGE_INCLUDES_UBOOT_ENV = 0, the file will still be in WORKDIR 
(because it is never cleaned). I suggest to test for 
RK_IMAGE_INCLUDES_UBOOT_ENV = true/1/yes/whatever instead (or in addition).

I am not entirely sure the migration to UNPACKDIR would fix this 
(haven't read anything about the consequences of it, e.g. I'm not sure 
it's cleaned by any task). I'm also a bit puzzled by master still having 
some bits using WORKDIR in the u-boot recipe. Not sure what's going on here.

> +		install -d ${DEPLOYDIR}
> +		install -m 0644 ${WORKDIR}/u-boot.env ${DEPLOYDIR}
> +	fi
> +}

We probably need to adapt this now that master uses UNPACKDIR instead of 
WORKDIR. This will require us to fork a branch for scarthgap now, which 
still uses WORKDIR but for the master branch, we need to use UNPACKDIR here.

Outside from the blocker in do_deploy, and the questions around 
UNPACKDIR/WORKDIR, I think it's looking good right now?

Cheers,
Quentin

