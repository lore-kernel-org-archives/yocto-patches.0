Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B49BD1A632
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 14:09:59 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.13])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10816.1767967795331538926
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 09 Jan 2026 06:09:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=Oikh3WI2;
 spf=pass (domain: cherry.de, ip: 40.107.159.13, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pOog19cyvG87DxxXySptIl4Ag2/4cmwSfCvzTfPpXmfbErGhAomlgGgVjnyPEvj+hBiszkylqW32s0Ky2c/Qqe1Hpo16RX4jSfjtSYdOcQBfJogtMtDzMPQaZaLT5ZjBQeCedL3hDUxHB5biJO7I6jYO7CiCys4IIBmfOxMTySHwCNeWOWnp4AiNAUmu4y6FR4Hra9O04Mb+SQyIH8eDGdSJmLJR/jCFM67OBgQH4UXymfuhI7Ga1bntVKDFYsU9GMNog5O15cX4bDjBU2kklDiTermRAb2IaFmzWhmUzeKFBXgW9GvZ3qaYHZVLr3IN7118sIwFO0boPPAp/KGrsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74ccgPqsPszsEKWfeNYRVVyXuTPzNZLBzKhO3xyIoCQ=;
 b=mUIi/7NayC6FyRi6x/9bp7pmAoSr4LhL48SBs0spUWDYkWeEn/0smX44E5YgPyfzDZjPTb7dg/88gORibEFivI811u9LxoXJd2+EF2s3jKnybURy5Gx+YzL40xsKJUEU6/CZz5Cyn622lxJfkNSEluJJdYehm2ZzGnIqSnnN1moELI2xVLyg2Xfb4flxilQKOvNbhS9Ic4NnbZKncWEdrPvO5YP4THphPyusJd8+OWEo69ZLqb6FInPtt1Qz3TC4+g0NllI+jfF058N3ABpUkVEgSBGiWpQYRypwyUbbxJKATbZsqkH7joBLW/fSfA89b+59FA5sjJoRnt+FE1gZPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74ccgPqsPszsEKWfeNYRVVyXuTPzNZLBzKhO3xyIoCQ=;
 b=Oikh3WI2ySeWbtNBGnkp5g5MqwQqP6TjmFaUg8S1TUwSumb2kJBbzHpb0GyuZzm92oXmbJ4RTxhT9F/L7cmDUioth3QRXS19/QomkQbAhVYirAk3jPn5CHocaUZ0h4906nkneHgzSObtO0AzRVQFf6HiyhPe50V0EQN+MonhgEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS8PR04MB7893.eurprd04.prod.outlook.com (2603:10a6:20b:2ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 9 Jan
 2026 14:09:50 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9499.004; Fri, 9 Jan 2026
 14:09:50 +0000
Message-ID: <dd990ccd-a418-45bc-b708-d3b1fc763ea5@cherry.de>
Date: Fri, 9 Jan 2026 15:09:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2 5/5] fix u-boot for tf-a
 firmware
To: yocto-patches@lists.yoctoproject.org
References: <20251221004843.31946-1-twoerner@gmail.com>
 <20251221004843.31946-5-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251221004843.31946-5-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::17) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS8PR04MB7893:EE_
X-MS-Office365-Filtering-Correlation-Id: edd1cb2c-fb98-4642-cd61-08de4f88c103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VDRtWjdGQTlEYXdOY0psYTVqQ2hCRnp1a2pNRjl4TzljVmNiMjlXNlA3VWpm?=
 =?utf-8?B?SE5XWFhiV3dHMHFLTmpvWnB3Z3hqc3h3RHJkMXQvQ2kvajFzUmVuQ1V5d0R4?=
 =?utf-8?B?VkJBakJOanBSb05qUVZsZWIzcGJhNDFKUitJRjM0WkZoaVVreVN0bEF6bUZw?=
 =?utf-8?B?R1kyMG9zUjR4aTdOTXFhL2ZPQkV4eFRzUmFQNnlWTG1SUnRGYWo0RXFyWC82?=
 =?utf-8?B?eTF2a1ZmMklscGdPVGFkRW40eG52L2JQKzVXTWw4VkVhdWZ5V1I5VHpocVVS?=
 =?utf-8?B?YlNIaXRKeUNRVGlLb3FGdEg4Qi9KdE53a3lPcXlQUlRrZnh5QUZTanJ5N3dz?=
 =?utf-8?B?eEQ2MjFJbXNBSytxYVNWaUVKRURyWnpsSFNtWEZtUFJrem9SU0Vrc091Rm43?=
 =?utf-8?B?SjBYSzRIVVZDWUxoOTVCZEpwMEJMaXh3VzF0T3NLUFI4NXVqN281ZzJRajM1?=
 =?utf-8?B?Nk9BNW1RWnpCUkxOVkt0c0xWWWR0TlZLM2tQT3lVYUxuWVJXazgvMTE4eFlJ?=
 =?utf-8?B?czlGdmprR0hVQ3JpRk4xSGJ6Rm0ydFMwU1BaUG45aFhSVXV6Q2JzZm81Y1NP?=
 =?utf-8?B?OTl3dTFwRlg4dUNFdWgrbWk3WFBlNndIOW0xNHBXY3FzUVY4WWk5S3VZazlu?=
 =?utf-8?B?UDlvczF3Nm5vL0VpSnBySFdUd2NJSDY3MnM5ejBsQ2RpZWxnTGtndVh2SUw4?=
 =?utf-8?B?bmIveUl2d201dmZTZjYxSFRiaTEzRkFzRExwNndhbm1yTTRQT0E1anJpTW9v?=
 =?utf-8?B?TzFBZThqUzZmNVJzdDBKZTlrWU9zeW5oNm1vTHQvb0N4T3Z0VTZmbkI5UVBP?=
 =?utf-8?B?Q1JYME81UE9ycjk0TlI5ZnJFeFFwYjVaYzlaTzBsVklzNnFEV1o3eWw3N1NO?=
 =?utf-8?B?TDhJL2ZXNlhsL1hUcjM3N1JqbmEwOW9HS1oyZnkzcjVRRGhvbHhTKzlBSVdC?=
 =?utf-8?B?ZTVGN0hzN1dDY1VESk90U3RzTTZjWUJvWTNNaU8zQWl2QjBvMVZHZWdFODk0?=
 =?utf-8?B?TVBlRjdKYmlFejc1cFhUNytzV3pIcno0Z2VqODFPSnRGczAzeEdMVnBybW5I?=
 =?utf-8?B?L3lnZU9BeEgzWndONTZCSHM3dk5GZ0FYYXVUMFIyTkwrODkxTzNIbFN5MHNn?=
 =?utf-8?B?ZlkxMlJGcmt0THNtNDhZUFJyMjNtVEh1UlpMOE9jNUtxWkZrL1d6OVphaG14?=
 =?utf-8?B?b2ZzVndzemlCTVlITUhoZ0dRTDZGdWFCNkFOaHIrbktnV1J1a25uSi9wUDYw?=
 =?utf-8?B?M2FEN05LSEJFZVl6eUdCZW9sZFVFYlhZQ3E5a3VPRndjeE9TTGx4ZHh0bXgr?=
 =?utf-8?B?bUpFeFZhaEFibEFlUGlmWDFVZCtDOGhjeFRtSEFFRG5YRmZYdko1d3NyRlY2?=
 =?utf-8?B?V3g1MldpSklWWFR4Q0FUZnQzd25zZEpwZnpEQWRpS0JYaWFvVEJscksyZE1D?=
 =?utf-8?B?akNhLzZUeVRwL3h5YlE5NlRROEJRcTRpTXJSdGx3T0hIdTFaNSt5N01rVC9P?=
 =?utf-8?B?ZXhOOEE4MHJlWU9WS0s3QmZCazErVnNLZVg1c0thQmlEdjFjaTBLN0tDV21T?=
 =?utf-8?B?elN3cldaNm1Za3pCek1aZ1YyMnMyNmdmUlIya2owZ2lmYTRhNWc4bHZzSVl5?=
 =?utf-8?B?cWEvZHEzS2RneUF2R0RyZU5BTUJBbGtPeXE5OWhFdnRkOHZNcHdUcVdBUWZV?=
 =?utf-8?B?NjIwQnJkNUlOYlNzN2d3K2Z1cUhzVXdBcEZzdDdSMkFoM2tsVmRNYS91ZE9V?=
 =?utf-8?B?ZDE5ZWEzcStVWjVkYzFPNTMvcytTN3NlUjVDQ1JyU3ZmUFBBeTdSNTBtRUox?=
 =?utf-8?B?VllJVkNOeENzTlZVWlNsTlMwUFFoSGt0RzdVc3c2bk9kbTQzT1FwNm82NVI2?=
 =?utf-8?B?a2JobzllTldUVDN6c2lnbEV6dnpRb0Q3UkloZlc1NXllakVkVXhmZ0E2WDR5?=
 =?utf-8?Q?r73JWfm2sJoDzK4JpncSoIOWQFyXZVht?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d08rSWtGaXhPTWZaMkdDZVRDU3ZDQ2RhcEx6VWRPL2VQR0YxNW5ISHVqU3Ru?=
 =?utf-8?B?MlgrVXM1WGdxYmRkU0cvamR0V3ZZNzV0NEwxdVc1TVdrT2U5bTNDUExzZmV0?=
 =?utf-8?B?UnZVelJJTTJ3UHVYSXFZUklUSE41SHRsMCtJdm5pVm0ybkx1aWE5UGhiZXA3?=
 =?utf-8?B?SWVoTDIzcXRzNlJXNnJmdEFXSzE0S1N5czJZRHhDN01uWHBYVThpRVZYUVFD?=
 =?utf-8?B?WjI5S3NzSUh3Sm5ka0JvaDBHbnVUbzNtck04OE1adXlERHlHUFZ2OWZIVGhF?=
 =?utf-8?B?SE96bGZPa2JtM3YzUktRMFNBUnpncWUwRisrV09JVy9IOFh6L2VrTU5oTjF5?=
 =?utf-8?B?VGF4d3JXNnFRUmxxL3VsTm5wV2l2NzA4bVVMZ1RmYU1tMU5QS0xvZEYwUHRn?=
 =?utf-8?B?VHJYNFFqTUZ1c2piV0R2cHFjNUZvUFVrclVzSnBZdGpsdUNabEVOZ0N2eVpP?=
 =?utf-8?B?UkNNMkZWNGkzSFJybGo3MTBoQ1Nsa25CUllzQWtaeFlTOFpxOHRHV3lxU3NF?=
 =?utf-8?B?NFVZSlExQk1Pd0loaEpJaEtzMWhud29BUFJKYmRkS3NOZlBJMGRVcmwzR3NY?=
 =?utf-8?B?aUw4cjlsc0UxTmlEN0QrRXJwcHc1T215ckl5akRWQ3NNbUt2VDNNSVFLWHNk?=
 =?utf-8?B?KzlHbHo1bEtnQXkvQWhHMHdBVFR6WVFqRXplUy8xcDJkTzVSd2VkNEd2Skk1?=
 =?utf-8?B?dkhjUUxkbTdCTlh6Qm82WVVKTFN6Z3VmRUdHMXhDOGdVN0RPSVpaQXdPdDhp?=
 =?utf-8?B?OUtISDdRQXc2czhqMDdETk92dzJUazJDNWN4dkRuRFJxeFZFUW9aZW1qc1Az?=
 =?utf-8?B?cGtWaEo1dFYyNXpsNHp3SkdXZ3g3SFJoVk1wVS9vR2tSUTczeThoZGp6bEpi?=
 =?utf-8?B?TkcyMXQ2Q1VFaUgvb08xLzJEU1l4V09hakhINFkwdGt6MURVc2kwR0pJNHpE?=
 =?utf-8?B?VEVrbUJMNHQyV1d6T0hOcktlMXozSUhlZTJSTnZ4WWhnZUVTcTFUMUJ1cDlZ?=
 =?utf-8?B?ZjVGam0yZjdZZUZKR2E5SGNtSCtWdGg2RU9OU2JTb0V6ZXpVc25DQzdINHJm?=
 =?utf-8?B?ODdBZDVVZE1HalRwVHFmQXM0SGJveFRBNXpNU2MwaXF6eFRob3hpcGUvbW5y?=
 =?utf-8?B?RVFnUEpSaW5lL3VSV3BPcVBHZitRZmRyU1VlR3lLeHpXeWIzODhybGVQSUN2?=
 =?utf-8?B?WnhnRnlpZ0RkclJNQ3J4OS82OCtvdU02amxlQnBSUEtBeFhhempkNG9hVlpC?=
 =?utf-8?B?TWpYZUFxQjQvS1p3YmRoelphK0w4Mlo1SklEUndXSFo3UGJRQTVHV2dvKzVE?=
 =?utf-8?B?c0NOdUUra24xMDYzNUR4aVdRU3pGRE81K2FUTnZZUmUwK2srcnUya09XbERm?=
 =?utf-8?B?ZU5aSmtzZktRcmpHdTZQV1haZk5uRFRudFZsakx0K1cwd01xL2kyeVRXTk42?=
 =?utf-8?B?aGRSV1hxR25aZzU0aHZWQ2tkbXU1b0QwSGlXT0xsa0dZc1RVT1pHVDQxRHpX?=
 =?utf-8?B?dzhuWjlON08xeUt4RDBIOGEvQVpQb3RjZ211WStaY0sxN1JhMnB3NHp2aURE?=
 =?utf-8?B?WGNoZ2dDVHpZeUJmblpValVKVGtwMGtzQzE0eHRUM1BvdDdEbjdpdlo3cnFE?=
 =?utf-8?B?NDJINnMvWGZUTjNKWjZGUEd1YXhpRFJHbnA2ZENMRm50N1JKeHlYMXJVS0lS?=
 =?utf-8?B?VDBiWVhwcUJ1bXR0N1VDMXNDaHh0cnpjTjkzNE9GeGQzSjc4ZUNvRnpzaFlt?=
 =?utf-8?B?NkRlYm5EcHVsM1FYVGJ3UDY5Z0F6SEZxeDJIeXZKTjQxTFVqZEhLSDE2aDZI?=
 =?utf-8?B?U1NFUTgrVU5LbXVtUEY1ck5EVTRJZ29sOVFGa3dLMzErS2VlbUtQaEtGdDZZ?=
 =?utf-8?B?b3h1QnVmZGtvaVN2S2Y3YkdoeHF0dXdxMUNEUDR4bDVIR3Z4bUptTUtKNkVO?=
 =?utf-8?B?eEs0Vk94NjNSZkVNdndrOTNKV3MxeU9KWGllWGJmWDZWZWhOWmxLV1Z0L1Yz?=
 =?utf-8?B?MU1rcFpGNmVIVmNtdVZ4Y0FTbWN3c3lVQi9xTDFyNlBCbHFzNTgrL2tneXlx?=
 =?utf-8?B?WmkrcjNRVUQ3S3l4TlcxNjhmU3BBR0Q4WExqdlI3dnA4aEpNNUwvQjY0THQ5?=
 =?utf-8?B?VVVaT0lwdFZUbGtaem5INzNpV0xtV0ZyUlM2TkFLejdtb0pmM2RwWmFJSzBI?=
 =?utf-8?B?MUg5Q3dxNHBRamhSckhiVDJ3YUZmSldrMDEvcHZYMUtpUHNkSCtsc01LOHFV?=
 =?utf-8?B?UUJJOWpvRXRFenk4WURMWUczL0ZLNDRscUtNaS81cU4vWktiSlFRNzNpcS9s?=
 =?utf-8?B?OUtERFZIRUs0cHR3bkNNSVArcGlNa0d5TDJPM1hsZSsyditGM2hKU1NJL0I3?=
 =?utf-8?Q?nceRQSjND7KLrgz4=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: edd1cb2c-fb98-4642-cd61-08de4f88c103
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 14:09:50.6417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/4+YiAJj2qoavaJC3qXzYxPWbVJS6+gd7vuuemCH+v4VTvYtX4csYvq7uDdRKjwIiAyzaVk5bnrkhMtYAM+MroQKPLXUNQYXKclQFQYc6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7893
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 09 Jan 2026 14:09:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2926

Hi Trevor,

On 12/21/25 1:48 AM, Trevor Woerner via lists.yoctoproject.org wrote:
> A change was made in the location and name of the bl31 artifact for
> device firmware built with trusted-firmware-a. Update the build to match
> so these devices continue to build successfully.
> 

Thanks for pinging me in private on this. And thanks for the quick 
band-aid patch to fix the build :)

This patch is probably not enough. I believe all SoCs are impacted by 
this issue.

I think this is due to 7bce36a2c64b ("arm/trusted-firmware-a: Use 
firmware.bbclass") in meta-arm which now uses firmware.bbclass, which 
deploys in a per-recipe directory in DEPLOY_IMAGE_DIR instead of dumping 
stuff directly there.

Checking now... ping me next week if I haven't answered here or sent a 
patch to fix it.

Cheers,
Quentin


