Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9252CAC592
	for <webhook@archiver.kernel.org>; Mon, 15 Sep 2025 13:30:21 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.69])
 by mx.groups.io with SMTP id smtpd.web11.33577.1757943012284551391
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Sep 2025 06:30:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=M73/mqJH;
 spf=pass (domain: cherry.de, ip: 40.107.159.69, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OmXZ5vxgIbhNZlx24qv9sFr+gwd2EokJLoctbn4/sdgsIDOwOYo/7SNUKJ5XteQ9eCNVuOVaiAXyUze22wPM2q8gQ5wtpm9n3uBcjPcVv78DYuebhif73k79JIr7K4zlpflAmoqopAGBmh7sWQzm7hzbLS16TAWztMkzWfxSA70m/IhIb0NYLVT9pJXE3wIV0IDxYu+WvycgOU5PFIBIPKK1fZ8VW7Mc6aewJ+f7qoKD4iWqGzV1+v6fSs9IVX4J3CK6ZYZplIf6YYTQq27d635ffyHdpKgpI+cjokorRF3Gm5GVkg0Nc01JTw/gp5E6L7X4hLLdtJkPQpcMO2fYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdG3MYHYGKgUuX5TFRJ/F48GSMjJoUpspylPI7eG5oA=;
 b=ol75yA1+Vk4WHCVaZ7YitwxUFr3cFdkVWqOY9D5rEqePz1Pn7LnBYSHKYaeVYH5SHRWBGAk3b+Ni6Ni+isUh2LCICOJ/w/Rz3HQ2jbltHPNt/ObUPljip4gc3EeqoV+sP1Fe0M2DFxeeIjgz4G2WeqqSZCBHoNcOy+53yZ5T4tJVQFu38wDa1HBeOGZc4JvwFD5kPhjvosP+sYMRfzIf0FSBGFjB4nBZ7tzqwftMmNwgncYAdwr3GDUGE9k7J/Qdsm9gEvnnVPpww5LXpbKF1HET7tjl36WsBSndIf3ZNLt4jFpzOTq7LmN3s0AR8j2BQaW4tZ4q/Xc3ny+ifVK7Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdG3MYHYGKgUuX5TFRJ/F48GSMjJoUpspylPI7eG5oA=;
 b=M73/mqJHkFMSECzZDD75I0YQHmEVJ67I6WxIsJl8ewW8N2rBB3WGB6QtFzi9Jyllkj2PBd1Hp55s9Wie1vcdgNLg6w1F7ub0f5hAdheKntDTEZmxQZYM2/VcqcZmTbXyxmbbPrwM/BKiRxdPXuuMUQFCaTlmWPs0q/fguAfT4mE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB7974.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 13:30:05 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 13:30:05 +0000
Message-ID: <880f00bc-7c10-4721-9091-22d9f046d304@cherry.de>
Date: Mon, 15 Sep 2025 15:30:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH 3/3]
 scripts/run-docs-build: pass version to bitbake docs build
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Antonin Godard <antonin.godard@bootlin.com>
References: <20250915-pass-bitbake-active-releases-v1-0-a5530a97b9ef@bootlin.com>
 <20250915-pass-bitbake-active-releases-v1-3-a5530a97b9ef@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250915-pass-bitbake-active-releases-v1-3-a5530a97b9ef@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0393.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 27927484-d45f-4524-6c68-08ddf45bfb26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TC9GdWpZZlFuR3JiTnBTbjlLTlpSMko3elpHV1N5T0ZrNk9ycFpydE1jL1Zr?=
 =?utf-8?B?U1VENnE4UWpTUWJielZqTnJYQjRheHorb3BjUGs4cElEZjV5Rk5BYndxb3Iy?=
 =?utf-8?B?Z290RkNNRHdyeXNrcWhUUFJWRHc0ZTgyaUYxRjZVWXF1cGxMVjBFMThOUTh2?=
 =?utf-8?B?Rk9lZTlLaVA0R3RoanRrcEpsQkxBWjVzVzRwQ3RRVjA3WUgyc2pEU21NM0tw?=
 =?utf-8?B?L0t5a2szRU1vbDJPekpBWEZGQmtnQ2VVM0pMM1RwN0lrdGJyLzJnZmFHYnZV?=
 =?utf-8?B?TGFmOXlnRDBVUUxUYWtOWnNUcUkrRU5jQjFjTGM1c3RFanhwZE5wUi9uOTZG?=
 =?utf-8?B?YXdaUEVZS1MxczZMMG9TeHN2L1M5YUFNcjBTa3lwR25XLzh5WGZFVzlLcjBp?=
 =?utf-8?B?bUZEYXBDT2RNbFVtejU4bjdBU01zazN5SE5TRWNiREtjeG1BbWlqMEM3Sm5p?=
 =?utf-8?B?Wlk3QTRMRWFZcm95bUtCZXh2ZG96eCtjQ0lIeE5DK2RKT0k5Q0VIY0Q5VFdN?=
 =?utf-8?B?NU5JbDdBNER3cWNkM1oxdDZxTXFEbk1PRHFBUGs2NS96eitGWmRVay9NTU9Q?=
 =?utf-8?B?dFNkd3p3N01rSnpWTnI2eEZCL240SEdjSzdPSEJwR3VCcjZiVlFmNlRCSDhR?=
 =?utf-8?B?cFordFlsZjdzRG13VDY1N0hhR1oyUnMzTU9Rblh0VEk2aXBKczFKMUpaN0gx?=
 =?utf-8?B?dFBUZ0VLbEhEOCs4QTMrSmdQQW1lZ0tiblN4dFdTY29kbk1TUFArUmhSUlBK?=
 =?utf-8?B?YkorbkhKa0lIV2Rab2ZMNG90Zjk2UTFSeTc5bG9ua2ZudVhtS0VVMVI5MEZw?=
 =?utf-8?B?V3VZYUI0bERtVFRndW1jb0Yrby9ZVTE2RjUwSmNNcS9HS3RHQ2xSWHV3VmxI?=
 =?utf-8?B?NWM3c1Faa2JYaGE0ejUxYWY4ZzFoWU5KbGlKdHdKTlhCTG1xamNHRE5uaGxk?=
 =?utf-8?B?ZHdneXVrbktOZmFjU1VvOW1vbzUrQ2tYTmdQNFRxaFdCNFQ3NG13ajV6bUxt?=
 =?utf-8?B?MDc5ZXVxSlVkQ2pXanB6N2t1YmlPbjViNmJDeHNIcU53UTk5Mm9NcExZYU9M?=
 =?utf-8?B?OXZYZVBkcVBtMzFHUUcyVmxHaG5yNFFJOGlIbXVjbkUzaWVnQmJyZ2szMWZk?=
 =?utf-8?B?TFpLRWp3QlN5elBvOThXQklnMGxWRnQyZEVsVzFtcFRrWHRvYkd0RU1vdTVr?=
 =?utf-8?B?NkYwYjF1d0ovU0xlbE1keEl0OUhEL2p3RzVUdktqR0pndm05RGJaa2p5M2Jj?=
 =?utf-8?B?S1BZT3JYZVBLUTBDekw2VWliSmtaWFIxK0s4RTdMMVVsck5VL3o1bm1vd3JZ?=
 =?utf-8?B?eHAvR0tnUjNZQTNycWlOay90U25Pd09ZVW8zcXhydEdISmhnVEx2NnpRaWVp?=
 =?utf-8?B?dlAzRkVYV3NBV250cU1iLytjVjlwNVNNSkc4bWN1bzBvK3B4UHZVenpFRDZz?=
 =?utf-8?B?UDY2bHJRMG9IcjRmclo2bmFVbWg4OXdpTnhtWmlIOFljb0w4eFdJN2pwSmRX?=
 =?utf-8?B?N0hxK1Y1Ty9ZY29xOUpITzV4a2pXeGU1b2xIY0dITmk0c0JIL0QwOUttS0E3?=
 =?utf-8?B?U2VCSXBQQ1ZxbFRsbE13cFhoa1V3eHJGZXhLYmE2SXBIdTJGSmR4Z01HdWlX?=
 =?utf-8?B?dUo2Ym1vQ2Znc01rYnFhOHpSSzd0c0JmZUJCbEZuWWVhOW5pSm5yZnBmNDdj?=
 =?utf-8?B?QTJCWWJBd0tTWUxoRExCU3NycWNEaXd6Q2llUy9OYk5rWDFjRkhPZXU4NkJr?=
 =?utf-8?B?UkVtZFNnNGFrSEFuUEgwTE9aS1dXeUl3eGV1R0lKSmhVa2tvUlZ6THhFUVpa?=
 =?utf-8?B?RUw1QnNTZTFyZGlWMnJYc0Y4STJqVXkxVXZqa1RIOFhHY0k4cklmQi9BV0NN?=
 =?utf-8?B?R2l3L1dPVmFEUGJCUzlISVN3RXlPQmg5VUNOTFF3eTJxVDRmak5oMDR3U2Uw?=
 =?utf-8?Q?lI2IiA6h+xg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y01YOHNhWWZ6bVJEVXRjMy8rcWF6YmVWUU5wZFNkbE1CcWJISzA0am9jRFRB?=
 =?utf-8?B?TUN0QW1sOG5GbGt1dXRRWDR4cldSL2owM3dqNm9SbTYwZlpVazlENlhPUzBl?=
 =?utf-8?B?NEdUbUhybUtVdjQ5bkdQc0R1OTlXYjZlUUw4TXJjMmsxOE05eGFFVnJwcTZD?=
 =?utf-8?B?NDhwR1Q2clZyMEpOMExabHVDK2FFZ2plREtpb1NDV3pqcUI3dTFPY3dHU2VT?=
 =?utf-8?B?Q0N6UnFwdWVRTlRDazIwbVFUanM4NG9rblhFOEhWZkoyb0pXU1dpZTVNZ1l4?=
 =?utf-8?B?b3FUT1FEOHlxVWN6ZURrQjdCWkJjSng0Mm8xRFRFTVNBcHFhMkRWSWpUZThm?=
 =?utf-8?B?Vkh6Y1d0TGVVVHc5WThMTi91OWtUSnhscHhaQ3pENFA5aVYwT1JmSW11WVly?=
 =?utf-8?B?SWhReEU4NW5zazFOc2kyNkdtaHMxMDNFMTdtbDlDMkFUelZHSHlpb3hHMjE3?=
 =?utf-8?B?NlRXM0JYNkN5NU1DQWhOV21EVU1xOWY5bkhLWlZyekRJOHlLdWZKazF6U0wr?=
 =?utf-8?B?NkdCbFE1U3cwblZDNy8yVW5CWDlNVU44OGl1aHpGa0JJbTRMU3ZqOERnakdx?=
 =?utf-8?B?dEFIb2poWDlSc1RaaklKWFIvR2YwbERNaVl6ZHFhZ3NOWktlSmVvMkFaaTE1?=
 =?utf-8?B?U0szcUQ4V1JFcWl1YTFFNWJYdm9KNUdocUt0Q3A1d1dhTW0rUGZlTnhmMVVp?=
 =?utf-8?B?WnZYL011MVRYOUoyOC8vV2VKcDk2ck8vRFdKNmJEV3JKYUNPMDczWnhUMHo0?=
 =?utf-8?B?WEEya25yVlRKTkwzTkRvK1BnQ1dzdjV1WExHeTFzVUV5TmcwMmxYVzQ3YkNH?=
 =?utf-8?B?T0RLaEdqV0NDZ3B1TDViTkxEemhVcjZMakxCMzlnZ2lpRDk0SVNpWGdVcHVV?=
 =?utf-8?B?SGlRRTk5Tnh2ZG5XYm4zUWdMRXc3YWI0c0ZlbUZmQWtGWlhFOHYwbUx3dVZv?=
 =?utf-8?B?YzFrVVhDcDdDcmFaRGZJVytSbmhaY2pjbXhPYWJnekJWekF2SDRnVmtRaVVI?=
 =?utf-8?B?cDRuMXowc25pd1kvUnFMV1IvOFdZZEdhNzFIN2c2KzBBQ1lmeDZhUjJMWGoz?=
 =?utf-8?B?RG1nTGxtcnlFamd3OXl0eFFnckhoUnJHS2Y4WlE5R3VqeHFwL0xJK0w3ejdH?=
 =?utf-8?B?TUVJT1Izak1qaG1PNVZ5VCtkNTl5VG8ydm0rSENLdUszU2YyQlg1N0pIT0ly?=
 =?utf-8?B?cTl4T0wxNVVPa2p0dGZ6RmIyR3pEdkVKdlVOdTBIcHVnRWpNZ3BDQzRjM2R1?=
 =?utf-8?B?Yy91UFNTbkRvWmREUlZXZGZYTGtaT1I2VWxlRm8zaUFEVURYVEk3RFVOVXVw?=
 =?utf-8?B?ZkxyOFNkaVJqNmtXUnVqb3FNM3J2T3MxWE0vK0dWZm1vOVNLNEJpaDhWOVNN?=
 =?utf-8?B?TkNRZWFnN3U1NnI2TlN0YjlYMXVqM2l4Q3NxTEdkWG1lS2JDcGp6QXY2ZVpM?=
 =?utf-8?B?TkExR3dLNWNweVA1S21RL1pPZmdHYmNmNFN6aGU4aE1BNWNpeFlOTmF4eW9Y?=
 =?utf-8?B?VzVNTVVsYmZDSEZRd2xmdUVRRGdVaVpZenR6TlJtMW9GNDBwc2puOU9sK2ZE?=
 =?utf-8?B?b1crZEVnTHRrOVhyOW9HcGFuS0UvdklhekJaVHV5L3hnREREVzlkK3VSZHVE?=
 =?utf-8?B?b3JONktJMTV1czFuc0JlTWVuNDJTNytMZkFnOHZ1WitRcThUbkJvMzVZdW02?=
 =?utf-8?B?czVVdStpN2RDVHRkQ0E0RHd1WmFBbEV1Mm9qVUtROGRXUTBSbjdodlUzS0JW?=
 =?utf-8?B?YjVjMGxaM1grb09UQUY0UHhlMDV1c3F1RkNqSHRYYUJWYzNTenJIUGpXSHRC?=
 =?utf-8?B?SGZKdEhhOC9wakxPNElrRlpXZzkxVXBpSXFKQ1dlbzlBanlFU0xDS3pTTDFy?=
 =?utf-8?B?M2lyWVBSYk5YZ3oxbld6cDVheDdPQ0c5cnRDZUpoelJrWDRHUmtXcElrNUpV?=
 =?utf-8?B?dVRXZGU5dGNvejV5YzhMVk1IeUk2V1FaTGQ5MEEwcENTT0dXSHFFSDFUTVlk?=
 =?utf-8?B?eUlOR0Rkdm1DMlMyOXdYc0JtZkd1blNUY1NSNDcyRCtOT0J5ZE9vMDdadUNm?=
 =?utf-8?B?ZmpBNU9PaGxMeDk4Z2FVZDRXcm45R2pmVGJNdUlHWVVoQnZRdENwZkxQZTVs?=
 =?utf-8?B?UkdtQlZieVFJL2l5Zks2WThqbU5VTUFWbng2MEg0bnRNNW1FS2pZakxqdmhX?=
 =?utf-8?B?bGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 27927484-d45f-4524-6c68-08ddf45bfb26
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:30:05.1352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9v3eYEc7ZtTTdKAaoqzffp0ViuTfftpfug6wTUo73/7kqrBUwVqtixenKSt5XgDvF2uw7iYyyriIv9sZnvc1P8+IZBnKdFHL3thGDi5oM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7974
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 15 Sep 2025 13:30:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2194

Hi Antonin,

On 9/15/25 2:19 PM, Antonin Godard via lists.yoctoproject.org wrote:
> Bitbake's conf does is not aware of the current version it is building.
> Pass the information, which is read from bitbake/doc/conf.py. We have to
> checkout conf.py from master in additions to this, so this change
> applied on all branches.
> 
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
>   scripts/run-docs-build | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/run-docs-build b/scripts/run-docs-build
> index 549032f..654b401 100755
> --- a/scripts/run-docs-build
> +++ b/scripts/run-docs-build
> @@ -138,7 +138,11 @@ for branch in 1.46 $(git branch --remote --contains "$first_sphinx_commit" --for
>       git checkout $branch
>       git reset --hard
>       git clean -ffdx
> -    git checkout origin/master releases.rst set_versions.py sphinx-static/switchers.js.in Makefile
> +    git checkout origin/master releases.rst set_versions.py sphinx-static/switchers.js.in Makefile conf.py

I don't think that's a good idea.

This forces us to never update any plugin conf.py uses otherwise we may 
not be able to build earlier versions of the docs.

I would suggest to follow what we've done for yocto-docs which is to 
have conf.py read an autogenerated poky.yaml (we can call it 
bitbake.yaml if we want) which sets the version of the docs to build.
How about current releases which are forced to "dev"? We patch them the 
same way we did for the yocto-docs, see patches in 
scripts/docs-build-patches.

> +
> +    # Pass this information to Bitbake so the docs gets built on the proper
> +    # version. See bitbake/doc/conf.py.
> +    export BITBAKE_CURRENT_VERSION="$branch"
>   
>       (
>           . $builddir/buildtools/environment-setup*
> @@ -213,7 +217,7 @@ for branch in "$ypdocsbranch" dunfell $(git branch --remote --contains "$first_s
>           git am "${scriptdir}/docs-build-patches/${branch}/"000*
>       fi
>   
> -    git checkout origin/master sphinx-static/switchers.js.in set_versions.py
> +    git checkout tmp sphinx-static/switchers.js.in set_versions.py Makefile

tmp?

Cheers,
Quentin

