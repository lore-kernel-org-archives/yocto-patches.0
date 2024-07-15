Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F633C3DA4A
	for <webhook@archiver.kernel.org>; Mon, 15 Jul 2024 14:43:09 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.116])
 by mx.groups.io with SMTP id smtpd.web11.39683.1721054585325713857
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Jul 2024 07:43:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=c3Xb7u9m;
 spf=pass (domain: cherry.de, ip: 52.101.70.116, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBPLFMNKzuMMKoGcHFJFl8EgJpLRE9Ddt3o53Z5/X7qYaR8cr4cKslPWNggKTwRRg+0XCOKn8Ft+c5sftF9NC8PfT2BiAYR/H2ry3x1dNJmA91cmA/K5bsNpghrxCA7Y0MqxuNTUw5kkzHN6LzuPkKBZPpPVI3CPQ80CV5VtO+FxNKUcRNB7KNRwZgRzwvFCds9zluKBzc6KEVUxP3U2JftEw3Lktf/fmUfkwUoyjX142sq63PDZ9vF3akwEH4Gw2/5Bmm1I78xyQJHCG5Ipo1VfXx1lo9zRtFe4gJoSwGkkGsD/q6SY880uCBKRzLsXiN0JH+gZaA9tHC0fv8Cg+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVO2D60sep+0ifWTiOJKIfJ7V3y33XMVaP9weWSfsYA=;
 b=qz8WGtKtJU78wjnD+qrC70/ZDJ5ci1GVTgn+qnzAi4h8osP67ULYnvMD4IK98d+7+t8eda+Ie5WKiUscm9a/oXyRNKJwiLtEXPouAzzgc3sTODpOwuhLn3F27Z9td2tuF9FWa+ZcBUcNlOSbccEzs/sM0BEGBYnoKRCbnOrBSto/dIU0fb+bNckZDT2cmtv5sj3pX8ordvmmHOpHyIMROyaQtDZ/xU/Nfh6qBoqggUMr166adSUlo+2NqGvg0281/oXiFip9LHlmBsoW7D2dIqmgDADrtWd5ZCJi94YQnKwSfvpl0m7JngTh85A0VSLr3KPpQbf4WxEVwcN2sP05+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVO2D60sep+0ifWTiOJKIfJ7V3y33XMVaP9weWSfsYA=;
 b=c3Xb7u9mrjh2RKhLtKbIZgX/+ZMzRpgzkm3pEiTT8fLkxsiOLXNl97Ak6vwFy1mdfUIWbOwlGd6Lp5VnbEJ39NUYDpyQJKcE2b6VYXh5HQSc9N67+UtjRTHPzBodnsMwdpoPweSS0J98SFCZhLh2H2pO0955Vi/m3UFzsZ5vc14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by VE1PR04MB7373.eurprd04.prod.outlook.com (2603:10a6:800:1ab::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 14:43:00 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%5]) with mapi id 15.20.7762.025; Mon, 15 Jul 2024
 14:43:00 +0000
Message-ID: <775b8709-dfec-44a1-9fef-d4ba906f147f@cherry.de>
Date: Mon, 15 Jul 2024 16:42:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] linux-torvalds-next:
 ignore TMPDIR issues
To: yocto-patches@lists.yoctoproject.org
References: <20240715143149.16336-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240715143149.16336-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0045.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::19) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|VE1PR04MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: ea323147-585f-4ef3-52d2-08dca4dc6c61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bGdCaUZDVTlEa3EzODZKaUI2KyswL0twL3RVbk5JRkFFWmdwbVlVTEthNnJU?=
 =?utf-8?B?TUhVRVdMUmNGNDJscnpEVFJTcDA2WWtQV3VjRVdHSkQyT2gvOHZmQUs1T0p0?=
 =?utf-8?B?WUYzekVDdHFwQjd0ZEZsaGllRDRSRDc1N0J0dGdKZmdnUC9ld0oxTVVGekpB?=
 =?utf-8?B?QlhoUXhlY2c2eFhyOWxtRVNQWDAvV1FpNnB3V2N0cmViWWNGTFZNMS85WEVH?=
 =?utf-8?B?RURVSlFySlptTHpFWjhKdkVHa1lhcXhnUWZEZ21JYVY0aHNKbFhlbWFkb09C?=
 =?utf-8?B?bXprekdzVXRmQXgzRGxVMWQ3SWJ1MjAzSEhhM0MreGxucUZxYUExM3BVU3p0?=
 =?utf-8?B?VXlIb1J3WndHK0dxZ3BmWmhkWldvekMzTTJ5dXJUaDNoL1poVzNHaXhNQ2dS?=
 =?utf-8?B?L3JabDhjZnFHQ1hHRmJBbXNYdDhDbnVNQzBDMk1DY25CTGhmSTRERlA3TVhY?=
 =?utf-8?B?M3R5enVURnl5alBGMmtlckNNNFpaVDNCUFZxQ2JyQnd4dEhMS1ZLVmdTaFRj?=
 =?utf-8?B?S2xRb1hVM05lMjJFVUhMeXpsQVlJVUIxb0VrMXJaeE5EOXIrYng4YlZIK203?=
 =?utf-8?B?dGNaSWR3MFpNdmR3eURUQ1JjdGJ3TktJQllLRVhobElUTHZEQkMrMlB3dDdE?=
 =?utf-8?B?cHo3Zm9Ja3JPOGdkRDByRURZWEQwVCtkN1RKTmoxYzdUUVU2c1QyNllmWERv?=
 =?utf-8?B?eWs2RW1tRUx3UTJxelRYWlhZVkZ2TGRDOGRlSnpwbStzVVIreWFDdkc3N0pr?=
 =?utf-8?B?N25mNVN4TW9KbUdPcmVTTGRFTlIwMHpEZDJOU1YvRTdXd2lHUTZ1QVlETXEx?=
 =?utf-8?B?SzhDamF1NE4yQ2ZrZTh1K3ozRDBjcWR6MkhpbDd2RVpZNDZwUVR0YTZUVndo?=
 =?utf-8?B?T1g2TmhTQjlwN1BpV2FFN3poMHN2eFdyWFR0cWdQUjIwcmhGeU1qelpyVCtu?=
 =?utf-8?B?TXlzNCt4U2dZN2JqZDU0cWZJVlVyTUJieHg4S3FOeldWdzM1K3Z6ZHhscjl4?=
 =?utf-8?B?bFlRYkNMS2dVZlc1emhsQTI0RFRBaE42bzFSQzNGTGJkMllkdENhNzlteEI5?=
 =?utf-8?B?d1VZaFQ4RWxKUjhuVkM5Y0pLZnp1U2JWck9DejNNMkY0MHBsbDJrZ1BudFZi?=
 =?utf-8?B?bzRiSE9GSkg1RjMrY2NvY0ZjVnlucG11Y2UxZXZWRnNpZmpVbDFBN3hQVGls?=
 =?utf-8?B?MUdTTXlkUEdEV3JKU1NLaThDNDBVcENtOGJTYlhpVkphckZmNzhZdXlTUWc0?=
 =?utf-8?B?Zms3L3dBOEgxUDNIY1lRMXFwc3JZNTlyN3NaOG9vU1Fac2Y5dEg1VEhsWTdt?=
 =?utf-8?B?SWxjeDdTSUxHSVBvL05NblV4S2JkTVZMa3lRc2U5WFlja1o4eXY0c0xwMThD?=
 =?utf-8?B?eGsycHd0TjJSZmFjdTh5ZzM4bEErUnd5NFo3Nk9aelR0dDVwU1pUblFkLzQ4?=
 =?utf-8?B?L0gxMnlpdHg3elpYNzRPcjY1dUJ0TXFOcVJzR3BETTNPMEo3WHNzdG9yM2FI?=
 =?utf-8?B?YkQ2czhubkp6NGdMeHFJVTZZbktIeUhjUjhVbVJiNXlFVFNkYWFKSENJMG1F?=
 =?utf-8?B?VVNpalBwN2FjZEovSzh3N3FBN2lXVnR0NzFKb2JxYWVjOFJqUXVxTzJoNURO?=
 =?utf-8?B?MU9TTXdlMUFlLytMWjdHNzJlaGZhbFRsZ25ZS0NjRE9PN01XL0lSK2JldkJ3?=
 =?utf-8?B?dXhtUG1SMXBYTlh0ekYzTGJRNTVmRm0yc0NRU3E3VFNPbDZLQlFzM3d6K0ZQ?=
 =?utf-8?Q?4hYYGIUPtF6vnqmBRA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8906.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q01jTVpSZkQrOUp4eUdlZWdtV2plR2xEdnU5MTUwamVpclpoWHF5ZjRLaVUv?=
 =?utf-8?B?OGJtSGoxSk5STWJWbndDMkxmS1hkSUR5WnVPMjE3UFZvSmNXTWxwTGw3Q1RD?=
 =?utf-8?B?RXJWUDNEeGxaVGJyVXZuZVpIdDdOVWZaRTc3QzFRZ0tHdmxZN1NEOGNBL0ww?=
 =?utf-8?B?ZDlMQ2pvR1BQT3ZYVE9kMTlCZTNZcDloaHJFbDFsQS9nUUF6ZCtSbkJFdGNq?=
 =?utf-8?B?MFB0UEo0SnJSVWhQSi92S1huWHoxQlNGZlBiRXNqWWg1Q0JuYnYxNmJXOWVD?=
 =?utf-8?B?NU0wQjRxeTdLcHpjRm1Pb0VUNFVvdTdibFRMVHpueGVteWNhMmJsNHJDNkZi?=
 =?utf-8?B?d0pCWDZORXN1TlQzRjZxTThxamg2UnpZTE8xbU9BOElRWE1TUC82RFJ2MkhW?=
 =?utf-8?B?aGZpUHNKUk93Y1hMWGk1ZzVpWUZrNkxUazhyenNxc1BIZzVvOS9IVlhxUEVp?=
 =?utf-8?B?dFR1ODVXbjJwVFZDcVZjSTA1ZHpNay9aTGFJNGVZYk5HM2wxcW16endCd2l1?=
 =?utf-8?B?eE9SRHhQODVMMjVNTHloQ25kTkxPVnZDYnc2ZTJXVXkydEdMUVNFclA2amd1?=
 =?utf-8?B?RkViRnVSdFo2R3NoU3h5RFVOOWZVaHdBbjQyK3JmM0x3L1hkQ1RVQlhFSHFQ?=
 =?utf-8?B?aHY0UHJ5aWRObWl5cE1sdEczdWxHaDByNU1uNCtBNUhibU9KY3YzM3p2RWsx?=
 =?utf-8?B?TytYNXRJckhFY09SbGFhQzZoSWlWLzdnOWI3OVJDOElNcWFmRkVuVW1rOHd1?=
 =?utf-8?B?OTZYY3k3NlBzbnZ0a240MFJhQWZmUUltOE1ZeXdvN3hmV05IWjMxaW9hRG80?=
 =?utf-8?B?aEQ3SWgvTFgzTlV3eGxwTWdXdnVFQzZxZFI1UUR0WXc1SHM0RFl6RFRWcDEy?=
 =?utf-8?B?dDRmdEk0VW1DYnhKcVlYRENiZzQ1anlOMDVHbU5HcXJsYzNjcGI5elBDNXdx?=
 =?utf-8?B?VlcxMVZtSVhSem96cXNzKzRMdVpkanRQdFp0a0F1NzkyK21XSXNkQmR2bUdM?=
 =?utf-8?B?b2UrcW8yNk45TmJwTjIxWmdWOXZVTG9pTHd5N2dTeVZKR0hFR3JONWpYdHVY?=
 =?utf-8?B?TUwya25ad0EwWXB5bkdPd2l3TGg3bmxoUDU0THJ0YjFmV3R6U0lSTEZuS2lr?=
 =?utf-8?B?ZGlkMkpTSE81bDVKUlUzUjB5blpLNVdZbHFvOFhSYktkd1owYXJJV21CTU8v?=
 =?utf-8?B?N3VHdmQwZE11RGtqWmRRU0d3cXJMeVh0NW5PNHhOdm43TTQzNmF5NVVNVGM0?=
 =?utf-8?B?bGFFY3RqNWd0K3grRXdiblFnU1dUQldxMFp6WmwxbG9nUVQxQ1IzVlYrd2Vi?=
 =?utf-8?B?cTlIU1FzbkFTWk9QU25vUVJsaHk0b0pCMnVXOTFFMnNuUzNBczBLWVBHMjV2?=
 =?utf-8?B?djRnU0ZFM2dMU0FPakpXNlBybklSTUVhekdqWUZIamx1YWZ6c2ZJaTdSempt?=
 =?utf-8?B?THRXU0Zmdis1SE9TdGRFc29ucFl6dWZCMTdsb1lnNkt1ajBJUU9JWVUvbW1T?=
 =?utf-8?B?OGh1dE42aENUZlJGWTBsSm81aHJ2bWc0OWQwRllaUHZxUDhiYStPNHFzZUhj?=
 =?utf-8?B?bSt3cGVrQ2lJTGlmYTE3ZjR3cHZqUFNIc0orMERFaTRxQUxwdjRqb05LY1lI?=
 =?utf-8?B?TkZ4bVVzcHN5NWowdzFsajhqVnAvd053OFVUY3J3RnhoZ3NvWEIyNndzclZE?=
 =?utf-8?B?RUV4UmtBaThqUFpXQXR1d1REOXoxZ3JEYWZhZSt4UmYyOCsrOTlwTlh1QXhF?=
 =?utf-8?B?WHJzVE1lWndRUS9CT25POGJzNm5BbkdYbit4cGk2Tkt5bVdGZzVIK0tNS0kv?=
 =?utf-8?B?VG5jUWdzNmxIeGtDOVExMzNXS1pwR3JJUTI3NG5aOHZQYmQ3NVdzMEVtS05D?=
 =?utf-8?B?WkdjQmdOUE5OWi8zN1gyd0xxdW0wYjlJRENONnYvZ0dRaENHS2tmQnR4eHpr?=
 =?utf-8?B?M2ViQnR6VjVqdnYxQkpzU0cvTjFoQU9aRmozc3lpT0RRREduWHp1WWxocWxM?=
 =?utf-8?B?MmFFVzQ1SXhzL1E5dEdzOHByZVBLek8vYWMwNlVyT1hwb2tLZDRjYlJ1SjV4?=
 =?utf-8?B?czlhL1NZdWFnRks2WXA3RlFLMkRWc2ZjalR5dVpwcmVxUE1rYmhOdkZqYVFL?=
 =?utf-8?B?bkdxWS9YTDk5Vnc3a3Z0MlRDTTc3M1BiUFF2dTFVaitRcjhXWmRKMG93ZVZh?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ea323147-585f-4ef3-52d2-08dca4dc6c61
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 14:43:00.2854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0eM81VrPxXTwf39qzN3WEaW5/cbotc7lOpKR05LkaYapQPFB314uvAgzydxEeO9IvDFZIKXyGyxJ1kkpQbAlnFvOW2A4M2aggww+cjE+89M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7373
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 15 Jul 2024 14:43:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/429

Hi Trevor,

On 7/15/24 4:31 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> oe-core has raised the status of some checks from warnings to errors. Ignore
> the "...contains references to TMPDIR..." error when building the
> torvalds-next kernel.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>   recipes-kernel/linux/linux-torvalds-next_git.bb | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/recipes-kernel/linux/linux-torvalds-next_git.bb b/recipes-kernel/linux/linux-torvalds-next_git.bb
> index c0ac1de22005..6f3db7c61bdf 100644
> --- a/recipes-kernel/linux/linux-torvalds-next_git.bb
> +++ b/recipes-kernel/linux/linux-torvalds-next_git.bb
> @@ -5,6 +5,7 @@ SECTION = "kernel"
>   LICENSE = "GPL-2.0-only"
>   LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"
>   
> +ERROR_QA:remove = "buildpaths"

I think I've had those as warnings already and I've patched the files 
triggering those in my downstream tree, and Bruce as well I think in 
linux-yocto. We should really at least notify upstream to check if there 
isn't anything we can do about it to avoid silencing warnings/errors or 
carrying patches.

https://git.theobroma-systems.com/jaguar-linux.git/commit/?id=55b4a6e969981d21b320a90a6ba1b8f89cda80f0
https://git.theobroma-systems.com/jaguar-linux.git/commit/?id=01a5c521907b714dc9bbde9dc6a8e06b1894d019

In any case,

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

