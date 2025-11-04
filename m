Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF08CCCF9E3
	for <webhook@archiver.kernel.org>; Tue,  4 Nov 2025 13:24:22 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.24])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17544.1762262653401279345
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 04 Nov 2025 05:24:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=HSqJiMO1;
 spf=pass (domain: cherry.de, ip: 52.101.69.24, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KS0TnElpeajlY5e7NuoOMRpdtlmDasLMjQAV00NlwtZFfrUvTPX3EVSguCsMLNODmL2lldJFe8pvsGAuEgOZoSvm4Qzy6w4bjmN9yrl4+gmzH6Mok4susvhns1SQthyIY2pr9MHnAVeLhWDLklYMx+t8lewsvW1m9Ovrp0SCDJP9hQGf2goZnqk1mz/PtPo70phjmrdmgo1qqZyjCpw3HTnfWv8PeQTNEe881qqnp8VojpoxIT3Wdi1YLRQIqN9AIcnOKuqwPem20q9BcwFuZ8mVtsEK8ZdVmq3YB2ThGnzZ57JDR1arbJvkolrNdDFoyZxnzb9zAtQWR/IbsMCaog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PsWBSC13ntvdZPc4PaukJG/TO660smJmW9Mqza1J7Dc=;
 b=saHa1rtBq/fUZaMv6vGJHpErMwhCLLsiYBzaF9dgb2pCmPatw9WEW98o77bhgQ8yu2dohlQWKymRDIgBpQWkp5l9OKaoYfg5nscf42laqkI5yLGjqu5NPB8pz2aFqDGBik7J8F6dh8u4iqRM1aYDTQWRzltvUgjalyp53Lo0/OtmIBE9HeTSsg4APSspd3Zn0PSUV4krazBu2DljUDRq8x1hpGyO3a0RxnHSaVMbshf/trjTh5A/4SH+iNjI96PdyiBIVKWoXfLehfiqrvzViO3aAQwhZjww98QBn58T+8djhbuqsbLY7KUrJHr7YOEJHEdTpKHpbk2l2gozlQUtQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsWBSC13ntvdZPc4PaukJG/TO660smJmW9Mqza1J7Dc=;
 b=HSqJiMO1RL6BBw6uwcQP50byTAZJxLg5RqpUM9K5whRaqEfYLJjDBTT+weGqNe1eHCp7Kr4mqAxsJJ9769hFgemO7exyzayBcYi94BA/aRD2HF4MAlL3wW+DhjTXgUDrDGOJ3VmnQRzmamdH/n3fNz/x15gDS/O8YL3pijtjRyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM8PR04MB7795.eurprd04.prod.outlook.com (2603:10a6:20b:24f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 13:24:09 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 13:24:09 +0000
Message-ID: <efad37da-acf8-43e3-8006-4963c95bbaf6@cherry.de>
Date: Tue, 4 Nov 2025 14:24:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH] rk3288: use u-boot.itb as
 bootloader image
To: yocto-patches@lists.yoctoproject.org
References: <20251102132931.228967-1-mustela@erminea.space>
 <1c51d67c-1c7e-4934-91c8-21a214027d1d@cherry.de>
 <DDZXDAXPCG6V.3V4XOU5IS7E2E@erminea.space>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <DDZXDAXPCG6V.3V4XOU5IS7E2E@erminea.space>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM8PR04MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: 238fcf0c-3eec-4b05-a0a4-08de1ba56fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Vi9Md3FURk9jQTgwSGQzYXN4cnpDUHZlM0FTSGV0T1NheGVvRUhjMFZwQ0xV?=
 =?utf-8?B?M2dlMjF5dHFhNk9GaXJhL2t5NDhRNkZ2OTY1YVpRQTRDUkpsdkMzUzBJNFlE?=
 =?utf-8?B?UDZEUFNUakRTajA5ODA0OSt0VVhGM0dpVXRXNzBOWThCaXhEZ054cXNFQVZN?=
 =?utf-8?B?ZVBsTVhxUlliTEJpRENhYjZQbDNoeTV2YUR2VW1UQ2JMN2doVDZ4WENqV2Vq?=
 =?utf-8?B?citOcEU4OWRNbTd2d29LWmZKdC9QZmdqeUZjS2VXbC9qVzRkY0NhdHBiQVA2?=
 =?utf-8?B?VkV2amlITHIvTFVrQUtTeU9HK2FEVVdqNTRXUE1RTWVFMlJDVmk5MW94N243?=
 =?utf-8?B?RjZUWnhSRmlNbVlsY3lUQTdZYXJiUGlVdzJ4eFQ3Q0ZWNVdQWlc0djdQeGNV?=
 =?utf-8?B?aE1hQ3VOeHM3M3p5SjBPWkFTdVorVUVCWUZrSUhsYlRtRk5DNm9wK1lwOUdG?=
 =?utf-8?B?RlVMMzdVckpBZE8wMm9wRW52a1A2QU1QYTNEb282VmV2TUxYbThQYmpaY3N0?=
 =?utf-8?B?WVJMSGNETjNabWhjOVlpZHpnTFJGQklvWi92VWJNSzBPOEUrQ1VpaEZTU1BV?=
 =?utf-8?B?V3IvYTlESjRJRk1pRDhtU0l2eXZIZTZTNmZDdEFycEpRMWNtaVBzN1V0OTZU?=
 =?utf-8?B?SzQrYmxKcmdtcVJrejNjYVZITE5qYnF4QnEwemJabHlHbHUxZ0FyLzNWQ203?=
 =?utf-8?B?ek1QK0lKdnNKY1FpWE9vbUlFTDJiQzkrUkwyeDhVSFphbE94QVh5ZWREUjhT?=
 =?utf-8?B?d0xmTWhPaTkxbjkwWDZsYm1GM251aWRUanhMVExJdXIwZWhjdXJTbmJyMjd3?=
 =?utf-8?B?ekltOEQ0ZXlYMFlCeVlHQUpZdUF4Tzl1Ylh4S0txOHA4STJvZFo3RkVIbnox?=
 =?utf-8?B?SHlSMmlib0FGZWZqVGYyWncvM3p0OHhoeS9PdXlwZ0VXODZNTFdsMWN6ODdH?=
 =?utf-8?B?a3l0dDg4K2ZNQWZVaGJXV3lnWjA5WUZMQlh4V0h4RmxoUzg2dnB4WHRxeHRC?=
 =?utf-8?B?c21vR3pHOHhjalRPaXFJQ2lsNk04Si8xUENmTGloQ0pDUmhKbHJ1U2tSajFv?=
 =?utf-8?B?Y2FjTWpxUzF4cmdML0dXRVczNWl3NGY2d2h4SFNRcFhzQUZvNk1xWGMrdnpQ?=
 =?utf-8?B?ZXpWNk5PRDFwa25RYXEwc0NPck96cVVuRlJEbnljblZlUTFvNlZ2bERoWTc2?=
 =?utf-8?B?K2tHazFnL0NqZUhIdEZ6aHJkL29wYVVub0gzcFdLOHViL2ZmTk1SeDc0b01P?=
 =?utf-8?B?amJMeTNCTk4reVpFMmg2MVNJV1JiYVVTaWQ2OGZBVU9ZVnNvaFVEYzh1NjFQ?=
 =?utf-8?B?cXhWQStpeWFIWlFRcExqY2JUdWxRdmphd1Q4ZnFKRU4vTWRoUXhhZXlMcGIw?=
 =?utf-8?B?cEF4cGlEQld3eXNpSmV1cm01YjFwajQxZTdSNDJmaEVReDdrSFpHd0Myd1ow?=
 =?utf-8?B?OEZPYUlxYnB6Y2VLTTB6V2pNT1pGNXowVm12UTFqanBhWW9rc2JSMnN5RGF2?=
 =?utf-8?B?RHZFSHF3RUVlYWZTc3VDYndweHNLWEpEdDZnbzJJK00xY0h3MUoxbkpPL2JB?=
 =?utf-8?B?OTh4V3YwQkNhb1NVcm5YdEhNbmd3TElBNmw2REJRYzJGU045c3hRSHlUU29l?=
 =?utf-8?B?WnU4b0F4TlhiL2pVTlRaNVF3K3VPcG5DT3A3NTFNcEhTUlJENEQ0TWNTZmZw?=
 =?utf-8?B?OG1KdEEycGc0aElSKzF2SlBYd1VSVjhLOTQ2TCtnOVR4ZEs3ay9oN1J4aVdQ?=
 =?utf-8?B?QkxmMXVVOW0wRUhpQjJUeXUvWk8yclFEODRUOWFwL0F4dnpDV3NMZDRFYnpo?=
 =?utf-8?B?c25BKzhWVUR1WER2c0NabkVramtZcm5jOVR1TDFNelI3dVRlQUdSR3RMQmR5?=
 =?utf-8?B?V1FHZG5IaWFaZ0kwWkdEUDh0R3orSzJXdXRLMmRoYlJJYjlaWUtoZHlDUTVn?=
 =?utf-8?Q?oCtwJIieB+KFjMGLT7tWeK8f4iGnb/dA?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MXdlektKT2E1T2swSXQrY2JvNk01MlltMCtnM2VJeElZYXJwSkh0MVFqTTNj?=
 =?utf-8?B?dDE2RHc3cEd4aElTZEJGVkVtMVRTVUI3SlZvbUhTZldxUnhZMzl2dHVLNXhH?=
 =?utf-8?B?emo2c3YwQjNOM092NUpSM01IS0Y1dm5ld0ZqR1dKa01SRml3ay9hNHV3OG9v?=
 =?utf-8?B?MnAybFI1ejM3MEtLWEp0dVN0ZjJnWjFNM1pRNjJreVJ2YlphN1c4Yjk1dkwv?=
 =?utf-8?B?d3dRdjlIdVM1THlSRTZKNzF6aS9LcVoxQ3drUERmeXJZeGlTV1E1SElDZHU1?=
 =?utf-8?B?VXNrQmplUTBhRjFrSTBMWnV6WjFDM3lkczd1M0N3NjFrZENSSE9FUjJPOVlW?=
 =?utf-8?B?bkc3VExpZHlNLzJYWnp1OTFiOTE1bS9RWDNxeWpKcnN0cjZvR3ZCWGx4UmJR?=
 =?utf-8?B?V0pPQlFjWlU4U1k0RjRUVEYxTHl2UzB6YXo3dUtnZmhEQ011c0dERWhhNk9O?=
 =?utf-8?B?bmhqQkN1NUdEVFQ0U0dZblF2ZWFCQlJQS2RhMDF5NXowWVFpYjFaalltZWJG?=
 =?utf-8?B?TVY1UHRMRjhtRTZQU0NGdVNSOW1MUjNkMDhOVjZWVVNJTmQxT3U4S1FxRU9C?=
 =?utf-8?B?LzBwOS82aFhDRGZUYnYwd084Y1V1c05KVlNvMWFoNEFMWTJRaldMYnRQT1hm?=
 =?utf-8?B?cEhaeGxRSTdkcVNEUXBnbzRLdm9GMjBITUs4WE9ZbkJpcllMQTlKZFg2aGt0?=
 =?utf-8?B?c1FwbUtBSDl3OTlnTi96OVArK3BHU2RnMEw1Zm8xZXIxUDZsenM5ZENKWUpw?=
 =?utf-8?B?a2dtVzlhOEI0WWJjSG9SamlzYXd1NFRNZWpmQWZFdVJLUDQwY3hnTGt2azdn?=
 =?utf-8?B?ZUVyK3lpQVkwRTFCNlpsbGI4dFJCNkJPVFZoZTZKT0YzRkRJdlROaUNwQ3pP?=
 =?utf-8?B?ZkJVQ0o1NVEzSTdJajFiTWdXOGsxb3kzajJoVTA1OWVqN2xlTUZlZkJRbkxy?=
 =?utf-8?B?RTRCL2o3bElMais5RUdKbnphVW9OaFdHNXJlbGVLQVN5OGxnTnNVVlE4WW8v?=
 =?utf-8?B?Y2ZnR3M4d2gvTnJZazVUZGlqU1UxQ1RoZXE1WmV3dENFMUp6S1BwRy93QlJz?=
 =?utf-8?B?Z3EwQld6TEVsNGVBVFpRNk0rUk5kdS83amI1MjhlekNJOU5pcXFkTXAwYkRm?=
 =?utf-8?B?Yzd6cnZaVm5uS2REbXdveFhOZzl4YzhRNXZacnhaTU1mRkVoZ3ZIT3dFM2FS?=
 =?utf-8?B?U3JGT3dKc3l4aHE4aXVOKzJQVFpTdFhLVVZDNTZZa3hhSzVqMlVKOEVtbm4r?=
 =?utf-8?B?MHlYZWhPNFJKeW1YU1J2TDZmczU3QzkxeFBjNnhkaDRTQmxtSG5QOERiZlNk?=
 =?utf-8?B?bkVDMVpBYmpQa1JZeXVkZktSak03Ujc4ejdNQy8zVHlZUlVlR0tPaXpDZ1J0?=
 =?utf-8?B?NmpxYUdQaDdBTXFqaFQ5YjA4M0VtanROZFJtY3dEWE1QYkF0ZStTSmxvb1N1?=
 =?utf-8?B?TDRubVBMVXllbXJMcGhnbU4xZnk5cnNIMHdDV3c2eUw4N3ZWTGFnQzBWU3RX?=
 =?utf-8?B?STVIeDdTQjBSVHRGZ0dBWkdNZ2JvZlJzT05seVpVODdkempaL2xLZ2dpVEly?=
 =?utf-8?B?V001VTYwMHM2cVUrY2U3c0lwbWEyeGlpcEhYNXV0SU93T09uU3l1eXRWd01K?=
 =?utf-8?B?ZjZjT2R1VTVDdGp3cGNqbVhCZDBHUVF5dWo3MmNHakJ2ZFJkYzNGbXRjTEZr?=
 =?utf-8?B?U2lGcXNyLzVuQkVGRFF4TkZaVVpCOXlBbXVyM3d6TFFtcWZ5Rk81L3pLekZ2?=
 =?utf-8?B?aWV6di9IMTV1ZEREdFQ2aWlaVFZvTUJsZzlIZFBoL2hwbzhOOEk5MndQYXp2?=
 =?utf-8?B?V0d4Mm4zSERCdWRJMEU2bW5yMEhWOTc0YUowZzhhbFFCYUkvSnF3QkZ4QmMx?=
 =?utf-8?B?b1A4UTc3b3pUeGRuYlYvdzIrVTdmOHNNS3l5ZzhQUy9jbG9GWTdkQXljOFc1?=
 =?utf-8?B?R3RXcC95TnRvQ29rdVBoeEY1NXc5RDlGU25hSmJzVVRhZUo5RldVU09xeU1r?=
 =?utf-8?B?eVE0ZUhsMVprK1dQU2loZWk2djVMY2UvSHdTQm1jakhyejBtTzM5QTh3b0N1?=
 =?utf-8?B?UjNyeENQWHdVL0wvNXZmZFZVTlBwcS9iWVB6OXQ3aTJaVGdoL1d5emhJSXp5?=
 =?utf-8?Q?RkQFrxL7925N+b9oMkltxfGvg?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 238fcf0c-3eec-4b05-a0a4-08de1ba56fc5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 13:24:09.7595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z8six4ZDgMyHxzVjRY2ev7GEoar1cKOD3Adgz1CKB3QVSbxnjOSezUrGAwg40FhsM+PVAFi19unbh0PMd+1qBf/T86GAOspOy1FA2076zFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7795
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 04 Nov 2025 13:24:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2415

Hi Peter,

On 11/4/25 1:55 PM, Peter Shkenev via lists.yoctoproject.org wrote:
> [You don't often get email from mustela=erminea.space@lists.yoctoproject.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hello,
> 
> Thank you for the review!
> 
> On Mon Nov 3, 2025 at 4:31 PM MSK, Quentin Schulz via lists.yoctoproject.org wrote:
>> rock2_defconfig used for the rock2-square machine doesn't build (nor
>> supports booting U-Boot proper from) a FIT image. Same can be said for
>> the Amarula Vyasa RK3288, so this would break the build for them.
>>
>> Please build U-Boot for all RK3288 to see if it works (I didn't, but
>> reading their defconfig was enough to know this will be an issue).
>>
>> This change *could* be fine if it was accompanied by the necessary
>> changes for the boards that cannot boot the .itb image to change their
>> UBOOT_SUFFIX as well, to .img as thats what we build now (c.f.
>> u-boot-img node instead of fit in arch/arm/dts/rockchip-u-boot.dtsi, and
>> tools/binman/entries.rst).
> 
> I have checked. Turns out defconfigs for all boards supported by
> meta-rockchip do not build .itb, but they build .img and .bin. So I

Indeed, I misread ROCKCHIP_RK322x as supporting RK3288 where 
SPL_OPTEE_IMAGE is selected whenever SPL_FIT is selected (which is 
selected when SPL_FIT_SIGNATURE is set, which is the case for firefly 
rk3288 and tinker boards).

> guess I should have set UBOOT_SUFFIX to img by default and set it to bin
> for rock2-square and vyasa.
> 

Please use .img everywhere. rock2-square and vyasa generate the .img as 
well. If they cannot use it, we need to fix their defconfig or 
arch/arm/dts/rockchip-u-boot.dtsi so that the generated image can 
actually be used.

>> You can also add a comment stating this needs to be itb if
>> SPL_OPTEE_IMAGE and SPL_FIT are set in the .config, otherwise img.
> 
> Will do.
> 
>> On a side note, I think it should be possible to migrate away from
>> classes/rockchip-gpt-img.bbclass to wks/wic and upstream U-Boot. Not
>> something you need to do though.
> 
> Can we discuss that (either here, or in private, or on IRC)?
> 

OK so I looked a bit more into it. Seems like only the Rock2 square is 
not supported by wic, c.f. commits 
6732e8b981e24ec82a853a1fd3965877a75a694b and 
5e963499996d8c7735f6ed012af6f0b05f1e6c29. I checked upstream and it's 
still not using TPL, though I don't think it should matter anymore since 
we migrated to binman, which will generate an idbloader.img even if 
there's only SPL and no TPL. It warrants making sure the whole thing 
still works as expected and neither of us own this board so I would 
rather not spend time on this.

Cheers,
Quentin

