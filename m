Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC0DC27C4F
	for <webhook@archiver.kernel.org>; Thu, 13 Jun 2024 14:03:43 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.98])
 by mx.groups.io with SMTP id smtpd.web11.9575.1718287418126569564
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Jun 2024 07:03:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=k5GKH4pw;
 spf=pass (domain: cherry.de, ip: 40.107.6.98, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbtu35T9WUgPMYOqimYhPqNH1DRgq7zgGlW5KqfN/80NbES2eSSpUtiE8FqvPhGs7GO1OFLl0LSFT+S73tLfLI5O78wcAB5Jk8N7dWDFmj+RBMw91ZMUnzPda7H2vyUvXE8h6wAWV4qvsqRYQQewWJZDIpakJkzC/T9drhOc1sXOr98Aak3AlNBUO4YNHE8esUEANUrpwnW97ZBBKmt5oEQBkhb2nfm6L7y6dhlCE8u7tqgKxzW2czg7B1i0q9PG0DMqodDtU7iZyiwssPYL1++avGBbeyBOjQ/TqqIRBbogfkzBhqzxt+0BwjhQxrNXX83aWOI2GwVs8z1BdWKAMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBmRR6WhfecoLcexBjNT7yunDoFr5j9+f16q+WsVGMA=;
 b=lV/yv2BHbMbVsM19DWG0IAB/gHxlSfyhIl7W1Dr/rvQ9cG+H/Tj+KGzYhSOcOmAq6BLXQ92wWx4NbO8rSina7Jdu7we9WjCrqtVL5UhdXS7Fa/WngF+7pjYlSoXr2Z/X8lOFyaFI+pzYUdVjkyRTfjaZMedVnpnvTmQJwFgbqldtuxOMV3cM9C/lf1c5fEWLJQigkiK/WjKCHMTndXiG+ZR6u0HYYLdzeEd2LSvD2iCaBcU0l0RXKg01ktGdJFaQYl3EcxitqMJ+Gjc5Ae1mKvqt2b0K909RRVBznDaJ8NQ+cdQZ9GUUmhZ8m3SPoOyRGzek89Zxx+qIdP8ZoaTtEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBmRR6WhfecoLcexBjNT7yunDoFr5j9+f16q+WsVGMA=;
 b=k5GKH4pw8Rw78XOEg0TuyW/smmFEP+HiGiZhU4fLd8fY56zms/zdS43ByO/c0kvocos6k02Bx+bqYrpMG4DudoXv7jo0YLwACcguXx/033VspnOIe0wRrnv//P+ObhcQkxF7w8O0CuPWhNUZYLIPYWB8JJU1iytX32Sk/E8saJQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by DB9PR04MB8364.eurprd04.prod.outlook.com (2603:10a6:10:24c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Thu, 13 Jun
 2024 14:03:33 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7677.019; Thu, 13 Jun 2024
 14:03:33 +0000
Message-ID: <2983eb83-61b6-4ac3-b20e-41660885796d@cherry.de>
Date: Thu, 13 Jun 2024 16:03:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2 1/2] rockchip-rkbin:
 bump SRCREV
To: yocto-patches@lists.yoctoproject.org
References: <20240613133544.21164-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240613133544.21164-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0136.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::20) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|DB9PR04MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: f2189a44-3098-4fea-d10c-08dc8bb19c94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|376009;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bWtManhjWStnRHB2R3ArYzZuclVTcEhaM3p1TmEydXJrdXFMOTlNQmg5akYw?=
 =?utf-8?B?TjJvZzNDOENCejRMc20xOWJSUkR4UCtYNk8wNXZiSkhaNktDOFNLMlg0RGhy?=
 =?utf-8?B?YTgwbHRIeVdrWmZyOEVVcW5EUFdDOGtsVEc4VnVDZlI3aDJmejAxYWl0YjV1?=
 =?utf-8?B?SkkxQ0Exb3k3VXRBUkJFMk1iVWVWbTVVb0NlVkRkZ0c5SWp6ZnVsRDhnYnkv?=
 =?utf-8?B?OEM2Y3RxaFQvN2wvTjFWSXoxNUc3K2JLTGI1WFlvRUZjY2QvTjJIOHBhMmRq?=
 =?utf-8?B?SEJSQWhsWktENzlFTDZZcWVXTmNZaDArWjNPc3ZkMWZIV3JaSkw4LzRHbDVv?=
 =?utf-8?B?aU5IYm5PS0tTQlZCbFRTMnEzeC9hU2JlcU9MK1drMmZLckRzK1NxWkJQalh5?=
 =?utf-8?B?Q2V5YnZSZFRuY0JSRnhDbmJGNVhLa3Rmd3k0MU1tK0JkK0JZZit0ZktHK0dG?=
 =?utf-8?B?Q3pZbDJSb0JWUGlJSXJ4b2MxdzY5T3JxbUJZVWREVE5LeWxYTnhUOHpxZUl0?=
 =?utf-8?B?L0VNQnc2L3I1QzIrc09tNnZoWEtmdnplTHRaTDNXbU1jdmdDNVFJV01NZ0tq?=
 =?utf-8?B?bjl1L1lueXBIT2gyU0JGUVFyZTZEVkdaWFFDMkYyU2tZc2Z4QzZxOVFpYXE3?=
 =?utf-8?B?SjhDVWI4d3dOQnBGSzBnbDFyM1NmcXNsaU44YllXQTJaV2p5emxUS2tvOFBu?=
 =?utf-8?B?bmFqS1Z5WkROUWs1UXB2dmN2R0dwVksyTTVTVU14bVM3NU9ycklEYTJuWUMv?=
 =?utf-8?B?eXA4Mnc4WFNwSysrb1NzSmJLejdNRm9CWE9CQnVlZzBya2NudUJsV1FGN0F3?=
 =?utf-8?B?Q2xDMTBxL1dxNXJueGovK0IxNU1IMmhhZk5QY0IyS3FGNjFLNFpObS84WFIx?=
 =?utf-8?B?d1FBY0x4Y2tIKzNJWnAzZjk3amlDM2JIOEZvL293djBlZjBGVUM1dnFCQmZQ?=
 =?utf-8?B?MFBtdWx0TFp6T3V2aEM5SEYxR2Fqb3dXS0k3QXJDaHRVRUY4c3V2V1dIdmpt?=
 =?utf-8?B?ekVMUGdpUVExcTdFNFUwbUs2T0poTHdzYU9Za1RySmxxeVJOWXR0b0NsRjlp?=
 =?utf-8?B?MjNBa3NRMGlaQ3lSTVBqMWhFNWYvVHZybVh3Z2F1UW9VYlBQV1JPSjIwYXlQ?=
 =?utf-8?B?empkeWs2dGg2WmV1UlRJcStTUjVhQTBpLzZ5QmRlblp1VFd1aTRWeG00Tm4z?=
 =?utf-8?B?TnB0QVBwV2dHWU5kNHJ0bjJRRzNEWjJhd3E5bDBWdC9yc0tNd2hieU5XNHZy?=
 =?utf-8?B?RTVRTUdVQ0loV1ZTS3Y5VmpMb2pKTktKaUpQMlFIamNZMHJ6UVBIdGtzTE9F?=
 =?utf-8?B?aURKbXRhTmMzRHJCMUFXaEdxZGtVR1FmYjZib1pSYmtZSEU4ek9UT2NZNlBG?=
 =?utf-8?B?dkZqRnBPQlVoWDNybDVYTHhMMDdTT3ZML0NjR3hHQmVMWHVBZEc0eGxuRkZC?=
 =?utf-8?B?STVaem13NG0xWFA4RkpWaHo0RmoxN2E1a3hoZ3drS0xQb0MzcUJYM2dpK3Qr?=
 =?utf-8?B?ZVFqVkNBNE51QjRxU1BWajRNVFdlM0xMd2lVSWRsY3ZHR1RleWVVbkhEOS9v?=
 =?utf-8?B?bVlzZ0lSRThyL3dxRkxqZEZUVGF1aS9idWoybHNBR3lzZjNoaXBpSW5mUTNE?=
 =?utf-8?B?bWthdmRFTmVzSmw5bzZWMnV6dFpPUWJDL0g1NmhTd1RjaVh3WFZVaFhhckdn?=
 =?utf-8?B?WUNZc2t6UUNic1dJbW1hekxKTlJldzhtRmJKUlVIMnFNekJhVm9YK1B6Zk5E?=
 =?utf-8?Q?1qzsM4l/gtIX8EjPTT7KXgNKO4iH6ZKp9iAsIr6?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VFRwUXhOU1AxMjhVWjc2bHFPMXFhQkRsUi9tL3prVnlJdkdRVEQ3TDVsYk81?=
 =?utf-8?B?S3RSaHh2MkFpM2x0R1VSRU94dnFmVEVObHVyenVzWlV1bmRyUU9yVkJMR05w?=
 =?utf-8?B?UW9GNHM2Q0R6TEduV21ja3FmVXRIZDlaMDd2UmcrRXRpYW9acndIbkNUU1o1?=
 =?utf-8?B?czRCeWZnM25heDRUTnJqU3d0TjhFNVlXMjZUTmhTbEJYeWlTZVdQaDQxZ282?=
 =?utf-8?B?WlVUU0hYOFJ5OVlvNk5LQ0lBV2lGYWRPajBycUViN3VrZnVMWjdLM2F5Tnd0?=
 =?utf-8?B?UXVKMzRVWTNJRzVaMW85WXFiM3h3TFdSRnlEK29nck1XRWJMKzd3cTJqbGVw?=
 =?utf-8?B?Tm5RaFRpL0ptYUQ2SkYwNUxwdmorbWp2Nm5ZNFhlbmlzdm5DSlhWbEJzZmQz?=
 =?utf-8?B?dURhcCs2YU8xTEp1QWxIRGc4all1a3JxNlFwZ2R6U28zRTZhaEU4RGVaVVNi?=
 =?utf-8?B?a3dwcWVPOHloQ3Ayb25tQTJBWjIwTTNOdHhjcnowTUhqS0JZTi9YQTBIQUVt?=
 =?utf-8?B?STdNY2l3T1Rsb2ZKbEhtV3VxUkpmT1ZiNnh6VVNuMmFnMnhwM29yckx1dmM1?=
 =?utf-8?B?Ym5ZY3RlU2RWdFRqWlR2K09XR3FlSVo0a1Erbi92VWRzamk1bmN2aGNyOXVs?=
 =?utf-8?B?RFU5aEJTU1NFT0FEbllaOUFYTndtTm1YSlV0eFpVaHZWRjB4NnRJeS9TZ0pz?=
 =?utf-8?B?c1JLRVh2UGw5Wjg3cGJLcFRtOE1hUzd2bUxINGpCK2c1SmJjRGRRTGRqT0Nv?=
 =?utf-8?B?QmFGNnFaMDZTVXBUbDN0aXA1K0dnWFQ3K1NSWHZZSGhIck03Ti9TM3NJNXI3?=
 =?utf-8?B?b2VCejRpSVh3eGhnUERsQStwMHl3dGcwRkJqM1RaMnFLQW1xcHg2d3BFZGpB?=
 =?utf-8?B?WnZpOHh6eWZZZ0UxbXloUGdPdlJvVkNmdzZqREZlV0swVW9VUzZFWU82VEVK?=
 =?utf-8?B?aTRlU25YcmJVd1NBVjVSSSs2T2xaVG5IY3pjSkFRQzlGOE1KTG5iakJyK2Yw?=
 =?utf-8?B?WjBXZkRqUmxnNGUvOXZCSS96dCtzTU5lejRCZ0FQNDkxU2YwMjBFcFJwQWJZ?=
 =?utf-8?B?Z1lvdWhHdnMwK2E3RlJ1NW9LWFFkQXJOSkRCNHVTUXhPSnlLY0dQTlczRVY4?=
 =?utf-8?B?eVFOamVINWdTUVd2a001UmNZb2ptbzZ6UFVjUXhCN1RFQU9OWWpRTGo2YkhS?=
 =?utf-8?B?TkNFMTV5RlhCYkdTUEtDdS9UL1B6UUNvd0hkemxWNUFNT1grejdYaWpnYjNJ?=
 =?utf-8?B?VWJoRVFlbHNJazlEREsvcDRWTzUySkNTc0N5a0lBVXI4d3NTVklnK084SXpF?=
 =?utf-8?B?bmEvWHNEQmw4WGFxdDdNVVhNUEV6bEtvOFVwcXA5V21TT096cDQwdDZBcExR?=
 =?utf-8?B?SEpSYUwwdUVBS2hoYUZRUnRyNkhZeWd3VUw0cktjNndBY0N0aUlBeXZneXVY?=
 =?utf-8?B?WTBKTGpSMkNjMDFOd0tLYWQzQTFwSk9yQjZXczMxLzRmVDZzVytrTHBiVHEy?=
 =?utf-8?B?WVNLRm5aZGdxTG1sQlM5UFFSQVJTWE1HaTZNV054Z3BieVcrZ1ZmRTdrYitm?=
 =?utf-8?B?UDZyTGtIZjM5ZUpTeWNIVFNVRG9TQUU4dFlVT3NST0ttV29ROFFRZjRuTDVi?=
 =?utf-8?B?c29HNmRIK1gyb3ZYYlk5RzdGVHNYYlhFS2cydjlOeVAwZGFveXlpQzAreStj?=
 =?utf-8?B?blMyeUtBOEgxanFQVGxhYnJqeVBFODY5RkxiZThZRFVoVU1nMWdnMnZxQVhi?=
 =?utf-8?B?NnB2aVFQUStaOGFheDBJejJsYkQybnpEMlFCSU9xalVGOUZuZVJyUW5FMXZX?=
 =?utf-8?B?azRJcVFyczJtTC9MR0wybnVnSHZVUTZBTzh2alJFQnVROFoyV2RaeUZEWVNn?=
 =?utf-8?B?dXBJVVBMK0N4TVByc3hPRy9ENHl2U1JBM3FxKzNROU9uOGpCWGdQdVhlYWRJ?=
 =?utf-8?B?ZWJDRmJLYjJSb0RGcUJqcnBTbFovYitEbVc0TFJKY0hZQUtwMWJxT0hJVC8y?=
 =?utf-8?B?U2d5alBQWmFVenV1eFFBUHhydW9sWHVRSWFLODFiSnR3aExDclM0MEdBbnFN?=
 =?utf-8?B?KzEvUW5CbXhuV1NDUlBnRmNESlNPTWgxUm5GMHZvdjhBSjFLRkl4YzEzMXMz?=
 =?utf-8?B?V2dmV1htbVNVT1lYRktpWkZueVRIN0NzaEROZnlLbHFOd0N4Q2lhYm9IeEFI?=
 =?utf-8?B?Wmc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f2189a44-3098-4fea-d10c-08dc8bb19c94
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 14:03:33.3607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZUvsRGYODn6YGCZ88sIKcLf/AcknFs6P2PelQyubPyLLbHf5E7N1eEv9yAhnSjt4FkhGWX44rUSQVxXAQPP49C4ClGdOtBr39tyyd0BjZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8364
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Jun 2024 14:03:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/320

Hi Trevor,

On 6/13/24 3:35 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> Update to a newer release.
> 
> Boot tested on:
> - rock-3a
> - rock-5a
> - rock-5b
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
> v2 changes:
> - added
> - break out the SRCREV bump and make it applicable to all builds/boards
> ---
>   recipes-bsp/rkbin/rockchip-rkbin_git.bb | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/recipes-bsp/rkbin/rockchip-rkbin_git.bb b/recipes-bsp/rkbin/rockchip-rkbin_git.bb
> index 7929c6ac3a10..f9724ddd5cd5 100644
> --- a/recipes-bsp/rkbin/rockchip-rkbin_git.bb
> +++ b/recipes-bsp/rkbin/rockchip-rkbin_git.bb
> @@ -3,7 +3,7 @@ LICENSE = "Proprietary"
>   LIC_FILES_CHKSUM = "file://LICENSE;md5=15faa4a01e7eb0f5d33f9f2bcc7bff62"
>   
>   SRC_URI = "git://github.com/rockchip-linux/rkbin;protocol=https;branch=master"
> -SRCREV = "b4558da0860ca48bf1a571dd33ccba580b9abe23"
> +SRCREV = "a2a0b89b6c8c612dca5ed9ed8a68db8a07f68bc0"
>   
>   PROVIDES += "trusted-firmware-a"
>   PROVIDES += "optee-os"
> @@ -42,7 +42,7 @@ do_deploy:rk3568() {
>   	# Prebuilt OPTEE-OS
>   	install -m 644 ${S}/bin/rk35/rk3568_bl32_v*.bin ${DEPLOYDIR}/tee-rk3568.bin
>   	# Prebuilt U-Boot TPL (DDR init)
> -	install -m 644 ${S}/bin/rk35/rk3568_ddr_1560MHz_v1.18.bin ${DEPLOYDIR}/ddr-rk3568.bin
> +	install -m 644 ${S}/bin/rk35/rk3568_ddr_1560MHz_v1.21.bin ${DEPLOYDIR}/ddr-rk3568.bin

What about using '*' like the others? e.g.

install -m 644 ${S}/bin/rk35/rk3568_ddr_1560MHz_v*.bin 
${DEPLOYDIR}/ddr-rk3568.bin

>   }
>   
>   do_deploy:rk3588s() {
> @@ -51,7 +51,7 @@ do_deploy:rk3588s() {
>   	# Prebuilt OPTEE-OS
>   	install -m 644 ${S}/bin/rk35/rk3588_bl32_v*.bin ${DEPLOYDIR}/tee-rk3588.bin
>   	# Prebuilt U-Boot TPL (DDR init)
> -	install -m 644 ${S}/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2736MHz_v*.bin ${DEPLOYDIR}/ddr-rk3588.bin
> +	install -m 644 ${S}/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.16.bin ${DEPLOYDIR}/ddr-rk3588.bin

Same here, maybe we want to keep '*' in there?

It'd be nice to put in the commit log that the binary prefix changed in 
commit 
https://github.com/rockchip-linux/rkbin/commit/f02d10e468d8c783c45137d230ff33d42ca670b4 
where they changed the frequency of LPDDR5 to 2400MHz to "improve 
stability" as justification in the commit log.

Otherwise, looks good to me.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Tested myself with master U-Boot on RK3588 Jaguar, compiled by hand 
outside of Yocto.

Tested-by: Quentin Schulz <quentin.schulz@cherry.de> #RK3588 Jaguar, 
manual U-Boot compilation

Thanks!
Quentin

