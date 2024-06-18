Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886C7C27C4F
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 09:48:42 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.99])
 by mx.groups.io with SMTP id smtpd.web11.82295.1718704112748550836
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 18 Jun 2024 02:48:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=jklpzCxF;
 spf=pass (domain: cherry.de, ip: 40.107.21.99, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NiWCd+Vmgl4I3YO3+ROSdlKjdcYguYO7q8t1WryDRKuYHNmMXr6XE+jMrbmA2Rd9Lbz/qQN76M+EkmAetZf9nCAW1iX7Oo0Wrtw8ROjSWRPg60/aqeaNQbA3dAB+iCrrrFV9oN6sS0e7LtaN1nlVJpaC6WpkHkmhydo275QWx+DLIpidDkRqja/RaoaERYDGGDcrMY43VA8cxQO3N7RrFd250GxGpQP8cN3w0gLDPZrsd8cUMXO3ZrFLs5FB0SYbDwwvLeFUBK+4peCpZdzMhT8j1Q/kKJhuDfSJ2EY8FjeSzltFR+VRALrF/QGqia21BUojLYc2aeQwNcS/UAuh4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sX9UwQHXaTd/dKYLHHyxlwdGs7Ib+dCueZKOczxokHo=;
 b=EaKghWvyVzjm4d/O7t9TQsBNuL3YXlZPSw87U/4yr8Gc2x9uO5493I22m8grR6SXiLofSnvwdN6VHAa16DpzT4chuAlZgEFVWo7mOMQuWhb44ThyDUhnnBG0P7NlmLgVasnJbsfMfaz57ZGZ0klBsRKsIUoQqM/e05lo3s9bpSrbrMxXmF+rYlKw1+JaVz11SnE8n5SuUP85pdgJgUHNgyNaUYJ/YI84SXDn6LSFDuegfIz1/2yvmuCAoizoB4vDUyjETMQw7f0Czh3hqMtdaANLFyRg0scWSTS3TD44hfOc4cxjCMPg25hNkjXllLDWYYMAK2m6VhzhhKR3YArW1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sX9UwQHXaTd/dKYLHHyxlwdGs7Ib+dCueZKOczxokHo=;
 b=jklpzCxFkjOrVjPqNuS7qOYkQhvP2S0YYhn0qJVGQSat/N9htyeZRMNBXF2zhcwPQb92BGo6FavCH3MxsuUx2M43VdSAzrm9UmLAXsnwBZc1Ks1RZBqbBC4LyM2mTmxlsnizysMiBQ59HerUXX44pyYTLT3yMhaJmPIKEbvV2bI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 09:48:28 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 09:48:28 +0000
Message-ID: <0e12a001-4564-4272-b5d4-af42fe80da1b@cherry.de>
Date: Tue, 18 Jun 2024 11:48:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH] mesa: build panfrost for
 RK3566 boards
To: yocto-patches@lists.yoctoproject.org
Cc: mbober1@gmail.com
References: <20240617200024.389206-1-mbober1@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240617200024.389206-1-mbober1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0012.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::7)
 To PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|AS8PR04MB8898:EE_
X-MS-Office365-Filtering-Correlation-Id: df5e9c87-0121-4a1d-82da-08dc8f7bce2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SDdNYzBtb0dWNXR0VDZGU1k1RUZzTGFFczV3Q3kycUlnY0tOSkVCdFl0OGFm?=
 =?utf-8?B?K2tvNkcwcHdwdTU3Y29WZXZsdjJjRlJkSEtUZ1BnM1J0ZFNEdmJ1S3NJUGlW?=
 =?utf-8?B?a0ZxWEVObGRYWGI4emtKclhMV1VRdEt2TERxTlk1aDRPd00rR1k5bXpMY0pT?=
 =?utf-8?B?UzJEZFd3SWZjQjFsZkZlM29oQ3k2U2ozWFB5dnROWUljMXlHQVhVVnFjUExJ?=
 =?utf-8?B?Sm1DYjZtVXExekx5RTVHM2tHRnJTaHFscnVVK3FQNVErSVJnYW1oQlIxQTBq?=
 =?utf-8?B?Z21PcmdmNHQ3NGR3Z1UyUXNxSFZxREhqcW9PVEQ0VFExRlFvRnVWcDRSUEcr?=
 =?utf-8?B?VUVCZHNST3RvSGNiblpDRWlrb1lMN0FZUXdHRWV1R3FKRUJDcFZDelZrc01L?=
 =?utf-8?B?dEhwSkg1U3Fkd1hraXpFSmFkZFhFUDlHSzhmNTVTdjYwZFh2djloWGw0UmdQ?=
 =?utf-8?B?QnZPaWRFNEJ6eTBxVkx0RHNtRFN3bEdpTzJZeGs4bXNmbXdwVzRCaS9vbXYy?=
 =?utf-8?B?aW1PUlB6RDNiSktJUVF2azY2OCs2cWZINGQyTWJVMVVURXA4Q2NhaTNsOWwy?=
 =?utf-8?B?L1hJVS95eU1WTUdERWZwNDk0TmhVSER5YWZEK3RCRTQwRzF1WDNIV29ENXRi?=
 =?utf-8?B?cGFHbkY4NG42bEtzYWJ2MTRiMUlxRjJDd1M5MFEzRUFCUm9remtvM0xHZEpI?=
 =?utf-8?B?MnNyOFhsSFc3dldLQWlCaVRJU0dmWmwvOUpDMkgxNzZnNTdSUnBNbUwydTJP?=
 =?utf-8?B?S3UxWTF4OTN0bFc5ZG8rbTZXdnh6TU9INVRLVnRJOXd1NXAvTVYwSlB2UVRM?=
 =?utf-8?B?TVRGU2hHbmI3bzlQTklLa2Z2eE5aSlBIbEtGMkFuVGp1RnAvU0l6blJkc3VX?=
 =?utf-8?B?WE1ZYi9CY0RrcVg1ZlVKcnBtYWdLcHVtci9XZWxVdElHT2x0TkxXRXAzNlNs?=
 =?utf-8?B?bjhnWVBLdVlaMWdoRVhEMHpWcmt2TE9KUW5McEVucXdrNTR2cmFsUTZQOWpK?=
 =?utf-8?B?MkhCR3BPL0FHOWRZN2toZUlhRzRTWlNpdzduNlNlcGpuMmFsNG5HR3p6bmdQ?=
 =?utf-8?B?VWZkdjllOU1lY3JkNmdyN0orMXhTclJaaGt2QXp3ZXRkY0tseXFVNE9IWTAz?=
 =?utf-8?B?cHQxU3V2dmlHUWFHL3hpZUJESlcxZ0FnL0o4Z0xhQkxDL1dmS3VBdS9yejZl?=
 =?utf-8?B?QVpjNEJEalFOcy9CUlR6aWJiWVA5TWRNSWhjOWZNWWtyeHh0MUlLa2kwNUNY?=
 =?utf-8?B?RlVFdHF2MTdXczFaUGQ4Ymx5WG12K1FzcEZ6TElJUkdJcWtiMDBHdXJOSDls?=
 =?utf-8?B?eVRwdzVpMllOaFBpNy9lRHB0YnhabmpDN0tUaXhiak9XZ0dTZCtVbURvUkNW?=
 =?utf-8?B?a0k0OXBra3U4RFlZRExzeTZYTXhhVG1wdXlhbnQ0eWlseVZBM0ExU1NyMGxI?=
 =?utf-8?B?b09wRTNYbnAyY1BxRnVQSUczVldyYUc2ZWRZK2dpZ3YxM251TUJOSGtoeTFQ?=
 =?utf-8?B?WlV2NzdoNW1rNjRSTTJoWHkxanRRNFgxNHB1SnRHc1NjQldxUmRGOXBDbEJO?=
 =?utf-8?B?TzBabUhFWERTTFRPbVI0emtOQWJqRzJNTkxEVnFuRzVXQ2FNSzNmWVJjNk1n?=
 =?utf-8?B?bDFzREFBci91OFhielYwOERqT05SRERYOS9hQVdqaFJ0ZGxLMzB5YzBIRTIz?=
 =?utf-8?B?NXI5ZDRUYk1PYWRnUFZLMkM2dVNIRUN0VEloVFNNV2QxY3VoTW1YM3hoN1ZV?=
 =?utf-8?Q?p/ClGNohqulVZ2+OV8fnxXrvRp/lBMcSzEXJtB9?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L1V6QVBDenpxWDJBRDFZcmxoTWdWN3lvajUxSmlzeHhmTVAyR2N2U09tNWc2?=
 =?utf-8?B?V0taaHM0eldaa3Zpc2UyUFJoMEZka3pBSEFaMTdPMktyMEwwbUhqSXBjMmNG?=
 =?utf-8?B?WVNNWDFDdGlyL3IrNmJqb0NtR0s5ZVYySUYrUjB6dGZyTkZ4TVBaeHhKd2M1?=
 =?utf-8?B?K1FHaWwzdHRYTGljQm9qc29BbU5icWl2VlV5RUovZFp1ZVBLeFZabU8vYUpx?=
 =?utf-8?B?ZzJyU2NlSlJTVWZ0bWdZOUppTXY4SHg2WXo4eXJvZmpIWlZkYStXYzI3NU42?=
 =?utf-8?B?VUJJZFo1SElkK0ViQm80ZzUrTUJ5L2lRa2dmQnpyb2JJUk0zNVViTHNkL0hJ?=
 =?utf-8?B?eTErTVdOQkphUmlpQ1lucjNCRmhVRzNtY3dCWjBxNnBNQWVXNzVEZExvL25q?=
 =?utf-8?B?Z1hoN2lZR1J1ZGpRYXRSSTFrZWNRVm02SmhXcjRZY1ZQZVl6L0ZYR1hxazZO?=
 =?utf-8?B?dWt0ZndGQnIvYUN5RmpsQ0tHRWdxc25nU2oxYTdPa0ZWM1lscXhRbkdBZEFY?=
 =?utf-8?B?TW8rZFBLOTZNOHg5WFBZRmp2S1M1OVErc0hIZ3hVV0NVcHIzU2ZjTE5XY0ho?=
 =?utf-8?B?Z3lRSlduSVJOdDFFU2U4MThhUTJtc21Rd1Z1a2dRVFllZ3JsRkFOTXVmcTZO?=
 =?utf-8?B?QUNvNXgzSjVLcWN1RjRvZytkbit5b2RlZ0x1Qk5DS2dhWEMwT040bVAzV3B4?=
 =?utf-8?B?cmxEK25aZUZQaE0rWUx2Y1ZEcEpVOUtnNDdubHRrWVJSbGQ4TDVxQmcxaVM5?=
 =?utf-8?B?eUhva0F1RlF2eWt1Y1NJS3UzRXZ5ZjFnZ1Q1OUZOcjVmQTljQ0NUL3VHcU10?=
 =?utf-8?B?WWh2czZtbFR5WnNRMmxzOW03UFk3RG9WWFhJdy9Ncjh2U0tlOW1sZk5DL00y?=
 =?utf-8?B?SDlneWJUZjJDWU9mYzJjQUFYYytrUlpSVnBuOWlaNGRoSmh0V094TWtYdE5x?=
 =?utf-8?B?YXhLS3hxa3ZxOVFNNmN3dXhwTzRTdGdkWUVROVIrNllyUTBuM2o3RjhPNk9X?=
 =?utf-8?B?RUQrT0s2eUFXQzE2dWNnQ2hmSkNCcVR2N05WNkQ5QVNyZUE0NUNoakZrMGMv?=
 =?utf-8?B?UlpxVWFYeWZEdEI2WTduUEs0TFF4Nm01TjdsNjlIQlNBS2thUVlheEtrVVl5?=
 =?utf-8?B?dEhNVEszanBrQWlMNlBZZW9BQnRWc3hkWHJVSENYS2t5bmhBaFFiZTFtWVFJ?=
 =?utf-8?B?bTNINkZLKzhlejM5ZzlubTVaRUtjcGx1d0FnSTRMZXdFWHdQdzRialRycU9n?=
 =?utf-8?B?emFaUEl3elMrMEMwUVcyNzFhMm9yQktxUmhQQ1pLZTNCQVdWckFGeDZqd0RF?=
 =?utf-8?B?QzZUMUloYVBtTDlPdURhTkZnZzZ6UkNVNzVySEN0RW5XY3I2VjlOQloyRFpt?=
 =?utf-8?B?ZFZRK09XbExCTW1OZFVMV0dBUlM1R20rTGxEVUNMZFQ4dXhxZVJwTmlnOEFN?=
 =?utf-8?B?WURjaDl6UXdDaXFHM0puZExoZlFBWk82eFd6SEQ4RzAxZEtsVWU1WDZ2Uk9S?=
 =?utf-8?B?RWxLb0ZEVzEvQS9EbWo1V3JxVVRqN2NHSWdSRDVzTEtIOStzMkhobzFieGJS?=
 =?utf-8?B?NkgxYUhDMnJtZG1TdElWSTdBSTlzbWUySFdBd0NmN1k2dW4rM3dPRnFqcW15?=
 =?utf-8?B?SnQ4cjlWZm85ZlViTnJpNlEzYW5DM291ektnUTcxd0RhVmY0MEo2eUZiQmtS?=
 =?utf-8?B?VVdLY2k0bXBzVHptdkE1Yit0bEE3bUo3YWMvQnd1M2ZUUXVpUDRWSS81UkRk?=
 =?utf-8?B?N0g2RXEwSXp5UDlBclJnZEhYbkdWdVF1ZGR0MUpPRE1tbS9pOGkvcWRjN0xN?=
 =?utf-8?B?cnE2bEtULzNHbkU1WXRFQW8rV1EzNzdnaHJmUHJ1SkdrYjN4eXRGWklnMkxG?=
 =?utf-8?B?Z0hvK0VpQnFEQ1RTcnJOSEFrL2tnZlNuY2pSaGRiaDBGN2wwRG80dUJTeDJH?=
 =?utf-8?B?Sk10ekdOdnVFQm9MaHlMMlQraDI2NkdQUVRML0dGZDZCRWlrWFVpMUY4UWVq?=
 =?utf-8?B?alJQR0ErNVdUSUtUZjFwSTJLMlRnNVd4T05pbERXTFpVR21WUm8raUI4QU5H?=
 =?utf-8?B?VGVLY2w2RzBQWHZwSTYwZVNSOWM5WjJRTjR3ZEdBNEcyUGU1UzhCa1VrSGhx?=
 =?utf-8?B?MmdZTHlVMSszcWh2S1JPMFdSdnUrQTZkUGZMUGw4MUhZZUpWVGVQaFZDVWR4?=
 =?utf-8?B?dnc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: df5e9c87-0121-4a1d-82da-08dc8f7bce2c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 09:48:28.3901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84hhI1lsUqPeP7vVc+PN4tXJeBGVzqrDYVCy8pjPFOrLhKw2X+KQuuHgnGT1iw7MWqcu9b/xnbskGL1DdVQX8aqlqnHev3HI2L+CO+uGB98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8898
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 18 Jun 2024 09:48:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/336

Hi Marcin,

On 6/17/24 10:00 PM, Marcin Bober via lists.yoctoproject.org wrote:
> [You don't often get email from mbober1=gmail.com@lists.yoctoproject.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> The RK356x SoC family (of which we currently only support RK3568) has a
> Bifrost GPU that is supported by open-source Panfrost Linux kernel and
> Mesa drivers, therefore let's build mesa with Panfrost support for
> RK3566.
> 
> Signed-off-by: Marcin Bober <mbober1@gmail.com>
> ---
>   recipes-graphics/mesa/mesa_%.bbappend | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/recipes-graphics/mesa/mesa_%.bbappend b/recipes-graphics/mesa/mesa_%.bbappend
> index 2d9ec2e..ca1ad70 100644
> --- a/recipes-graphics/mesa/mesa_%.bbappend
> +++ b/recipes-graphics/mesa/mesa_%.bbappend
> @@ -2,4 +2,5 @@ PACKAGECONFIG:append:rk3288 = " kmsro panfrost"
>   PACKAGECONFIG:append:rk3328 = " kmsro lima"
>   PACKAGECONFIG:append:rk3399 = " kmsro panfrost"
>   PACKAGECONFIG:append:rk3568 = " kmsro panfrost"
> +PACKAGECONFIG:append:rk3566 = " kmsro panfrost"

Maybe re-order alphabetically :) ?

Otherwise looking good to me,

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

