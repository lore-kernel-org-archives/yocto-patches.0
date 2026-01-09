Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFCAD16816
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 11:25:17 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.37])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8036.1767957913488221174
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 09 Jan 2026 03:25:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=EIvvCrZi;
 spf=pass (domain: cherry.de, ip: 52.101.72.37, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/Vw7QVdlXlzHb8Nzu/4+YN5W3AbBo+UWc+1ABDn38TZtBB4tzUeQ14Xve44cok0wn7ftK6QmtNrkVS9B8j3NBL9STDIuerNI0EUmvxdV4yz0iGU7X9vyJgdDj1GpV/9dgLnmd6ho0jNdXAu2kLCLjH66aSWhuH46tLaBvDPjAdnYV0WtW0Xea1vc6WfvKA98UYm2yZyUcdYgXkdBZVBPFNyZKTw8WvaiYqtsKCU9Ur85iJ15+4jrBvpqJRWPkdd3gf0kw59jYHYsEZq0noOw2msAATT3R/IgoMa0djLdHyGDGs1MYoTTJrKjlsqy5aPKWhG1aMBc19k08WIYgC1mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXnt5jFHQOvqkZM1ul96O8L68d50t9tM48Zuxk2MhJs=;
 b=X8jOT7VlpmlUhetz4Zy1FJj/E2/rYS/S2q+6dgE0oy0uTi+K3XtzHDtlSwQlKwU9UuyKW7AaKGdBu4a+/5ET2y4Nf0au37UJdficIaK55YwVKEJcmuiqNlNWtS0unN6EplQGLwPgaowf7QhrgQ7refkzl+LwEuDKf/JpUYICoJAwZAX1pUBuubMID4ANJoS/UYN8nE6ZmI9yzjY6bMh5CWgl+knh3hsfDL1RQZus7njODLj/MgHYB2qt/LbIGR8HlKTKo8QyErlftyBnub+cPEjROwUPiobJ6PX62S7wEb6Hj5oBzr2gLJc8zOZh8TVVoI2pyQsaRFtC+64kef7SvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXnt5jFHQOvqkZM1ul96O8L68d50t9tM48Zuxk2MhJs=;
 b=EIvvCrZiIEHAxepd6Vn1JWdOCoShpSaBEUYOMIK39TriXNByJEuOwMAFHZe64irec3ktoQT0vcUuB8YAPUOJ0zagzHrxic1KiLrSYgOUEdGHBkZ8TreNbep+7eESpd3NSpsnNL/qpnScOKshMwfSP9WsUeByZMONQebQU/hKkOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI1PR04MB6846.eurprd04.prod.outlook.com (2603:10a6:803:12f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 11:25:08 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9499.004; Fri, 9 Jan 2026
 11:25:08 +0000
Message-ID: <db3c3b98-b71c-4cc0-b539-e4abe5dd26fe@cherry.de>
Date: Fri, 9 Jan 2026 12:25:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2 4/5] kernel: clean up
 non-rockchip arch removal
To: yocto-patches@lists.yoctoproject.org
References: <20251221004843.31946-1-twoerner@gmail.com>
 <20251221004843.31946-4-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251221004843.31946-4-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::12) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI1PR04MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: 988f7f7d-b3e2-49b8-fe58-08de4f71bee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cGxCYUJzUkxUZ0M2S1NyV2hTN1BOV3d3QmxuN3ljSTNJUWc4dW5KSjRVSUhE?=
 =?utf-8?B?aWk3QzJmMnk2YVpManJwOFp1QS9TZEFxMWZUdE51OXlHWlBYZCtHSTQvZWpY?=
 =?utf-8?B?QklpZlI1QkdVdXJEQ29JcDFPdm1jUFVHUkZ0RnFZbGZqRnJrS3JWY2UzOW9R?=
 =?utf-8?B?ak1ObzhvTm8xa1lERGw1TTlpdm4zQ3lDZkJPb1loRm56QXIxWEgwcUN6Rnhi?=
 =?utf-8?B?L0lHZitSMkF4ZXI1emh1SHFtNC9kTGowR3NLKzAxQVA0WWU2ejE3U01Kdm8z?=
 =?utf-8?B?Z2NBL0JqQzR1ZjlKeWZFaUt1N3RYT2xMUXA0SDNoNnpmZkpsWWtqNFNFTUtW?=
 =?utf-8?B?ZU00cGs2ZEhTWWlFSUNrbDAzMlJ5ZFJEaWlqUmNmQjRMYWNRMkRtVUdjc0E5?=
 =?utf-8?B?R3ZsR2hXZEdjd2s4R2NPK1RvYWR4WnlJK2haN1M2eHBxWUJQWDFCbWVrSnU1?=
 =?utf-8?B?M0kvcWdLTVFlWjRIby9lWWc1aVVRQ2VtTTl4ZkY0eTNYL2JrcW1sYXBiQ1RF?=
 =?utf-8?B?V1p6Y0pBR2tHNXkwbmp2LzZ3QW5yTVZITXl3TThPS0JjWlN3OGZZTWRRU1R3?=
 =?utf-8?B?bHh5cTJJbkVjQnJaNldlcm0xY2JWU1J2SkRyR2dETTE5VkE5Skx6MmJCS1VX?=
 =?utf-8?B?Mzg2aUNFTDNrV2RtWkdOTHhNcXpnbzNHQU5UL0FEcGVNVzBMS2hFZllWZmVt?=
 =?utf-8?B?RVpZcHg1KzQxUDFMNG5LNzdSandqaHRza0FIcVFiOFJNa2VxVHovbTc2ZHFt?=
 =?utf-8?B?Y3BQTDBNcGhESExSK0hpeU9iTkhUUTRRQlp1alNBR050ZjdvWGgwWTcrM3BZ?=
 =?utf-8?B?Ump1REwwVnJrcXZ2NGxwbFBCLzRtamd3S1lZckNwNkdOTEJtS2xMaWlUQjBt?=
 =?utf-8?B?NjJKM1FFYVM5dVBWRnFtT0ViTHlNOXlhcUZmZ0xBcGc2VHQzdW9QTExCR0pm?=
 =?utf-8?B?bE9PQUxaSzhwenRQQUR5SUJKUlNxUCtmdXdqMGVtc1RyaWNXcm5HdEZPYnVy?=
 =?utf-8?B?V1ptV2ViVkQzN2dYTFJjZzJXVUN4bkluZkxaYlRDVlFwYUZwQW50N3J4VHFY?=
 =?utf-8?B?cGJIbTVjSys5dytabDVCeWd4MUdMN3VSMmFWRUdoQkNocTQ2K0FFVnhuUE8w?=
 =?utf-8?B?OXAxbDQwSUFNRFdET3luYzhmMW4zSjVuZnA4Rmw0VlFTTnFrdWpCdTVJTVBE?=
 =?utf-8?B?NHFpWGZiVEJaNTcrNGVHb25Ud0xKS1BFdGgvN3FWVXR3dkg0QzFNUUxrRlkz?=
 =?utf-8?B?ODhRWVFxRHJzNkNOVnpvNTIvbHpxRlFqak4wYjlXbFJ2cXBTdWlZWkhmV3dY?=
 =?utf-8?B?eU5RK3RCd20zSE0wYUk3eEVkMHcxcDJqcENJQkFMQisrYjZvL1NwbkZicHZm?=
 =?utf-8?B?WU5hL3FhQkxISkNNc1U0NU53MzBqeXRyNUxxRDZTbDFXK1ZhWlI5YUhpZGMr?=
 =?utf-8?B?NzcxcGVaWkRlbjlWWXJGK2xOL0NLR1FPZUJGVDVkUXpLb3dqQlN2bjczMWhL?=
 =?utf-8?B?c2FaK2tlb0NGRnFYSnJnd2daYTlXZC9yU1B0bmVWdjNleHhqeFgvSU5KSm5I?=
 =?utf-8?B?eUVpQWVmZ1NtVVUxZFQ0eW90bXlSVW03T1UvOVd1Wmk2cXkzd2RyV3pDQ3g4?=
 =?utf-8?B?YTR6a2xRejIra3M4RjJLRzRGWTRDbzZqZUNVOTZ6RFZyRTUwOTVUdUxucWFE?=
 =?utf-8?B?ODZNanpFNWk1dWx4cHozZ2hhSjJzT00wdDFrNjNvR2xxNGIyK3RkeXNTekJR?=
 =?utf-8?B?SWpKSmVqaWoyazlSWlIzeEc5TFRmaEE4ZWZIeFhjaXpWVFVrTjNrc0tCUFNk?=
 =?utf-8?B?OThvRkpGM2cvTWdURk5mdkxRVVpVT3JFN2cvdk5OTlpIQnF6MldYM0d0bWJG?=
 =?utf-8?B?d2s3MVdETFR2SHZ0R1lBdjYrSWF5WTV4OGYwYjBPRStpQ0JuQ1U1dG9SeXNX?=
 =?utf-8?Q?suF+llO2tpMouQSaisULfv68Jze//Voi?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZVk5Y05ha1JkZVFaelg4eGJNL2hic0xvTHc3NTY3NVBhaFBZc2hLcmsyV1RI?=
 =?utf-8?B?a1paUXllSFBVb0VkSEE3VUdjSkx3ZlpvZGpUVWRNa0w4eXJFU1l5SVI2b3Fr?=
 =?utf-8?B?RytZbjMwbmU2cFJVRTExWkpTZFQ4VmhWdmxva2xkT1Jtc2JqOXdQdzFMS2J2?=
 =?utf-8?B?MU5VR2U2MGQzSmFJS09wREppK3UvR1kxNFJ0VUFROEZiakFRQm1SYXVYQ1Nj?=
 =?utf-8?B?ckVIZzQ2R3A3cUJtOEh4b1Y4SlJOLzlXdlpoUENqZVdXOXpTYWZjZlJEajRG?=
 =?utf-8?B?M0RkMHBCOWxIVlJHeW5sMmREeFlRSUwwbjBsaDNuOTgzOUIweVFhL20xcE1y?=
 =?utf-8?B?cHhZdDk0SWl4K1EwR1N5dVlsZTlCaGpJNUdlYmk2VWFtUVRxd2ZzY3VRNTZm?=
 =?utf-8?B?RStmWG8veHFwZXZBYTdZbTBidDRYNVZRZFVFYWV4c0hPRWsrTU5FcXdQZjd1?=
 =?utf-8?B?VUY5M09BMEdaTXRpZ3RWZ1h4bWI0cFFUMFRwSUNRcTQvWEZjYUJrYXZURURt?=
 =?utf-8?B?ZWFLVkM0K1I5MjYvSTI2cjBFbGh1N1kwZmFQbDVDVkl3Zk5DckQvTFM5UzBE?=
 =?utf-8?B?REJ6U3VNSWtFWCs0R01MREl0Q1FhTWVjKzB4Y2hYM0Zla3UvcTJBdG9ERktq?=
 =?utf-8?B?V0JLaUNuMit3bjI1VlZRZXJPNHptQW5acnc2bFpHYTlPN1dpR281aXh5Q054?=
 =?utf-8?B?emFlNlgyMG5DVDZFbE1wRTJiNnNRV2ZoMkxrcXljM0F4RjY1N1FmZERJSmhN?=
 =?utf-8?B?RklDTFNlVEJSZlJNejlNRGlGUXNUNnNyUDV3NG5VKyt1YnJFWjVac0M2OFVO?=
 =?utf-8?B?bHNES2Z0aDdMeUY5Q1VFeUl0SjhQQ1lvRmFzQUQ0TXQ2aXdTR0pxYWw2ZTB2?=
 =?utf-8?B?QTJLeHBXejh6YW1HbXJYTWt0ZXMwY3hlSi9VdU04REZsN2tKekFtaDlZN21k?=
 =?utf-8?B?NC9RcTB5NzVxTnNnSEJXSjRIVks1dzNHcmphcmJYZ0VRcTMxUTVlSk9wcito?=
 =?utf-8?B?VlpMM2VOcmEvUExyUEpyYVkyVzJpQnVQbVUvRUZOYUZ5Y2E0ZFVQVEtKMUo1?=
 =?utf-8?B?MElRSm9Tc1Z1ZDliTmdwWmxJVU1pK0pwSTZ6b3hhNm1TZEo2Ukd2YXhneExu?=
 =?utf-8?B?SUQ2Nm10ZVdMVURHT004T0tmbVhkc2pJL3lXWnVSbHpBMlFsNDRBMTRrUVBS?=
 =?utf-8?B?UklaMnBuZWVqWWk0SEozbGY4enh5VWV6eThRNFM0ZTVKTVNFZ1pjZ3c0cnFu?=
 =?utf-8?B?bi90aXFEMHRwbHZZT3pRcEs3WVUvWFJkdzRUeTBwM3czanFvTzFCUzYzckp1?=
 =?utf-8?B?YWxrRlhKZGZJVmFiSXFBOEhMQXpYVGQzbmdsalV0SlJlcXR0QkMvWUFiblV3?=
 =?utf-8?B?am1QVjNXSE5jUUtPU3MycE81aS9neVBBMGRXdXAwamdBZ2hBVzhsVndWUDla?=
 =?utf-8?B?YjJyRzlubXQ3OGNxZ2lTWHMwODdoemhlcUtENWI5SlQrNHRuUlFWUnFzUGJJ?=
 =?utf-8?B?UUFzMVdUTVd5eGFzTDJEUEIxd29reW1JSENLdXRRMmNaLzdCZUtrenJzWUFK?=
 =?utf-8?B?RmdhRk95c0szcU5oTXdLeW9rY0djczlRQ3lZUUFTNGtmQ2JmTEgraWM0Z3lZ?=
 =?utf-8?B?S2FDWlA2Y3lNK2Y1Yk5lWXdSR0syZHkzaXo2ektSMHIxdXl1R083ZjkxR3Zu?=
 =?utf-8?B?MkJCVjdsUVVoeTJQMFVDWjNZS2FXdGx5aVhFWHJiVndJclBXelRYaU1kWU5o?=
 =?utf-8?B?akU0c29MS1M1aVkwZmNLaEFkaDJIUHhnQXNpSGU2enRHNk5ZSEZuY1N4SGpu?=
 =?utf-8?B?RnFuWE5uUEdLZWFBczZtYmxSa1B3SUc0dExDenM3ZGRvWnNCaXJiZHBUd0RW?=
 =?utf-8?B?LzBXMloxNTNJWmRFbmFJY25IVld0dTJZcnd4NStFTVZJcndjcnBYWkt2N2Ni?=
 =?utf-8?B?MWZPd1ZvekJ5TUkzdm1sVEhSNFZURHVqZEhKUTlkSTBWVk1BUGhYbU1ZeUlW?=
 =?utf-8?B?MFZjMFFYVFlLMlQ2WWlua1hDOEwwWk5hbzFFdDBrbSt2V3Iza3FUeFpnd1Q3?=
 =?utf-8?B?YjBXaGhpYTEyOEFMeFF1b3BTWWZpa0hwNlZzeDZYRmhJcWN5cGd0T09jZFd0?=
 =?utf-8?B?M01uTFNCS0NNZE14T2Q1dzZrTUlua1FobTcyYWR5ek5YTjY5SE81TXVBSnhY?=
 =?utf-8?B?T2VxM3JQNlJ1eUdIbTJ5QWlwbzQwTU5ZdnN5dFpXSzlneFFDdlJzUGZqNWc3?=
 =?utf-8?B?OEppazJTZWFmMDVDSWtVTG5IeXE5WWxnZTV3am13RE5ZVlQwS2VkdnU3Zk9l?=
 =?utf-8?B?V1NBUG5xWTNyQlp0OFR0ZThKWEpQdWMyenpEOUZPNzNmQ1JOWEZhNjJubyt2?=
 =?utf-8?Q?bXSn/UhUuUyIWLX8=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 988f7f7d-b3e2-49b8-fe58-08de4f71bee6
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 11:25:08.6874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /do8QnzN/0HCbIJxXPCEq2viMrpISipcKz7KCBt91b+UO+GvVgW5kRQgqYFepmKhuAf7fQ+f/rvbth1nV9PI4Im2aQCl1ytUHOcS3Y3BiGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6846
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 09 Jan 2026 11:25:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2922

Hi Trevor,

On 12/21/25 1:48 AM, Trevor Woerner via lists.yoctoproject.org wrote:
> Over time more architectures are supported by the linux kernel (both
> 32-bit and 64-bit), and others are dropped; architectures unrelated to
> rockchip. Clean up these non-rockchip architectures from the kernel
> config to help keep its size small.
> 

How do you generate this list? I'm wondering if we cannot patch it on 
the go via a new task?

For Aarch64, I think it could be as simple as:

grep -P 'config ARCH_(?!ROCKCHIP)' arch/arm64/Kconfig.platforms | sed 
's/.* \(ARCH_\w*\)$/CONFIG_\1=n/'

which will return all config ARCH_ and menuconfig ARCH_ lines which 
don't contain ROCKCHIP, then strip the config/menuconfig part, add 
CONFIG_ in front of the symbol and add =n to unselect them.

For Aarch32, it's a bit more involved.

grep -P 'config ARCH_(?!ROCKCHIP|MULTI_.*V7)' arch/arm/Kconfig.platforms 
arch/arm/mach-*/Kconfig | sed 's/.* \(ARCH_\w*\)$/CONFIG_\1=n/'

Same logic as for Aarch64, except that we need ARCH_MULTI_V7 (and 
ARCH_MULTI_V6_V7 which is selected by ARCH_MULTI_V7) otherwise we cannot 
select ARCH_ROCKCHIP.

But then we need to add ARCH_LPC18XX=n, ARCH_MPS2=n and ARCH_ACORN=n 
from arch/arm/Kconfig if we really wanted to be pedantic.

Disclaimer: I have not tested if those command lines lead to a usable 
kernel.

What I am wondering is how you handle the multiple linux-yocto recipe 
versions? I'm assuming you're only building the latest one (the 
default), and not older versions. But considering you said some new 
architectures are added and some dropped, can we really use the same 
.cfg for all linux-yocto recipe versions?

Also, if the plan is to support other kernel recipes (e.g. 
linux-mainline) with this config fragment, we also do not know what 
kernel version those will be running.

Hence I'm wondering if we should try being smart or if it's too much 
risk in getting things wrong?

What do you think? (I do not run linux-yocto or linux-mainline on my 
devices... so these are more question for you as a maintainer in terms 
of what you're comfortable supporting and debugging :) ).

Cheers,
Quentin

