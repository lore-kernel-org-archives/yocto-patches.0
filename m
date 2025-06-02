Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F33C5AD49
	for <webhook@archiver.kernel.org>; Mon,  2 Jun 2025 12:22:26 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.38])
 by mx.groups.io with SMTP id smtpd.web11.48358.1748866939589342643
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 02 Jun 2025 05:22:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=I3F+NmZm;
 spf=pass (domain: cherry.de, ip: 52.101.84.38, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqO3k7Z+OwyMk4XTCFRqNL+gmYnEn/42Fzx+rsCEy2AXsDtbOurcNP4DXNgHPMUM5Wd6Kp6yUfvKrfTCG+XN+0PSQRLa/7pj8h9BqW3qH3tfXTk2chbFWetFFtaAEo63O+TE6Fam22myfwYdhNCycu53x5Y3T8MstI9YCtWUKJrTQ5V0JggAqA65AciTNmdS9sf97LOvMMOG/JbJ4qktYuu/OnFx7z4j8f67MYWs0c9koO8yoRvgK8cAt09U112vklf61AnRZ/ON1cHohCH6349p6L5V8pVFgqMRuYH6VDBpk0H0ZcXHo+JtoPAUdDrM6eW3Fy6GGzLgr04BaJCKkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fv2JX77PRohDe6DRcjN/8Zq5NUh7OsJZXc1QPVfJvfY=;
 b=ryRmO/Qc4zEbrOqTWeyFCghhEiDBZvSFqYUOpt72ZxYtDGcDfVry8HOZ6ugNgaAjZLofc0WoQDjeMsrHX/qxyK0U22aizg1I+rRTDbCQG+xh9sljlsKKNihoPP7mvUKleyEaaRBbNI9gOqGqz/QUUFNpAWRHZ7T7USgHb82+B0DwMwvoMr8KVSSwAIcS1v817ysnvrYvDDHq2qV93zY546ykrISo343lJQ6e+wyjZ68BM+6I+Wq0vqSKP6iU2dP9h3gkrm9Bshm02TFBQrh0jr1a7OgHNEBuwiLv5h7lQfXYnBdMXbAdikB08QRpOFWFnmfw1yXnsF5+wlq4u7f/gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fv2JX77PRohDe6DRcjN/8Zq5NUh7OsJZXc1QPVfJvfY=;
 b=I3F+NmZmn3FemYBK+U1WXA7J7ouR4rWFhNbvMVdC4GSSUE5g0b4Lvgt8oVHm48rgbM8+vcGsMDf+JxOhwH9WEVe9plL3dW7yKhSl2A74Vi3HkV2m8TGzSCK8FIW9t2B0zQ/N/9WRVhXyHovUm1eOKhiyIXFIenytK9JrgTzRFH8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB8721.eurprd04.prod.outlook.com (2603:10a6:20b:428::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.36; Mon, 2 Jun
 2025 12:22:15 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8769.037; Mon, 2 Jun 2025
 12:22:15 +0000
Message-ID: <8db48afc-fe3e-46fc-a733-1673548bb749@cherry.de>
Date: Mon, 2 Jun 2025 14:22:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH 1/3] refactor mesa packageconfig
To: yocto-patches@lists.yoctoproject.org
References: <20250530172156.7199-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250530172156.7199-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9P251CA0013.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:50f::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB8721:EE_
X-MS-Office365-Filtering-Correlation-Id: 47dfb1b7-9285-482a-ed9c-08dda1d01be6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MWlQVE92WE9ubVFab2N4UzJKTVlmM1NzN0tUcy9DRHZ3SHc2WXJUZG8yZFV3?=
 =?utf-8?B?UGRkMDVMNTNEc3JiVm5kRlZSdkVZRjhUd3NNL25ITTZWSjJlM21MSU5ic2tT?=
 =?utf-8?B?NkwzUG0vSFlBOHpnL3pmVFZwVThWWC82alMvdW5RY3diOUZPN1F4cTJFQlow?=
 =?utf-8?B?bXRjSEl6dER5WEEvVnhoRElqZnNtRzdDa1ZOcEcyNXRSQWY5VFNRcjhzNStR?=
 =?utf-8?B?d0VvZGhGbVVLU0IrOG1OQk56NEEzNGc3anBRb0VjdGQ4dDFYdXVQYWk3V2RE?=
 =?utf-8?B?eDRxWHJGcHU2U2VranV2eForcW8vNDNLamIxUWtUUnV6TDZQSVo1T0JqbXhP?=
 =?utf-8?B?dEdTL05FTXZ5eHRZOHd0NFEvMmo0Z3VMOWRrTjdKRnBTTUc3Z3QxQ1N5emRB?=
 =?utf-8?B?ZkUwcXRaZC9tYUpqcEkrLzIzY0tac1JVdndLNHN1S2dhcVlqL0tvcDYzbHNJ?=
 =?utf-8?B?WkVySENHZkZpeFc3a1dpYnJKT2JUVkZxcmxBWk9iRzB2ZXJ5TzJ2YXRWVmpG?=
 =?utf-8?B?YlJIWWhjTG9HMVZNQWNLR2NQZ0RUYUVobjMvaFc5ZCtaMGJPbFp3NStSUVc0?=
 =?utf-8?B?a0dSVFFhMmczd2lBWkt0b1hIM054eUxWclg5TDBXWnlSNDZyVHdFREhaNDF4?=
 =?utf-8?B?OCtUMWN6MlNxdktTVm1YVjBqSGFlc0srVnlGakdXS2FUZ01TWWg5eEFnUzVy?=
 =?utf-8?B?clZ3Rm9ZTGM1N0hQQVdyTFFUN3AzK1RtTnJHYkdSRmNYa2U4SFFPRksyYTVs?=
 =?utf-8?B?R0lEKzhPUTU0dGZMZEcxRXM4dnBYUnNtTXNocEtqL0lkbjhtNHhTSkxpa3RN?=
 =?utf-8?B?VzN3ZnhPMGlOZVk2ZmxJZmlTdml5akJhYzRzL3kwVTVQWHVYYU9CelZncUJa?=
 =?utf-8?B?RGIxYy9lVEdOYisxSTlsTDM2RjRVclRsLytZTUhPd21mWEpTUnJEenJzSlhk?=
 =?utf-8?B?MHl0UWl3bHJ3U3lZVHEvQ0syOXNGcVRlY010STJ0RlhIL0xVcytrbWp6cU9T?=
 =?utf-8?B?ZWhGeXdxTlhtSDI0SUw5cW9ocnFWOTRDc3JjQVhBdDR1MTVBZHNJdGRyY0dt?=
 =?utf-8?B?QVE4Q24xL0FONWNVRTVvWG9PRGZrT0dRMVJQT2hwaDJQMTI4SlpzeWQ1aTJ4?=
 =?utf-8?B?aUdpMG83cHhZUmt0QmNqTlJZdWlCNTBVU29sbnI4TWUydk5CcWVTOE1WQzlo?=
 =?utf-8?B?R0pnbmh0bk1NTEc2b0ZkYmk2SE9PdFFsSFUxRWxsR2xQZ280T1RZUkJmOGJr?=
 =?utf-8?B?M0pocWdTaS80NEhNKzRyeU9WWkFCdzU2elFiZ1RRQVY5UFo5SmZOYkJkLzBR?=
 =?utf-8?B?V0FsRTlvYVVnSXJLMythTFI2eXBPWUQwRzRnWlIxQ1JkNi96UlpCTFJZTnBu?=
 =?utf-8?B?MnlSMTVyWmtOalRBWVJNakMzS0h2cC9ZRmdHYmw0SklQNWdwSVBDWUxnL1du?=
 =?utf-8?B?MzF4b0NCMVhzM0lRN3pUNFRDQVBtaS9LcUE2L2sxbWNIS2dNMXBlZXN0T3BR?=
 =?utf-8?B?RTgwTmlEb1lkZGV5NzBnR3huZjF1UUtXM3RDV0VoYUhrZTFKL3hUMEMzb1pE?=
 =?utf-8?B?SWM4eFpaVWpYMklFK3B0SjJ1UDFVcmFmcFJlRTlRb0RnRGJ6djRpTEFpZnhm?=
 =?utf-8?B?dzYxMFZWb1BzTUluNUxFNmJTVjFJalI0SHVoVEhraW1Hc1VSc3VMUFh6WkFa?=
 =?utf-8?B?dU9CZW9Ob3B5K1VzVWNCRXJEbmMrVmNqazRZL1hnSEdtbkdlTHV5Ti9nZXdH?=
 =?utf-8?B?NjFobWxqbFV1U2MvMFdjRW80U3poUytGbTJhc2JSZjBJaytqRFU2Z1ptMGp5?=
 =?utf-8?B?ajQyZk1zOHZNeFdPSkhxTnZSQzh3QkpBVzQ4MWpLR2FWZW43aURYdFZzVkZs?=
 =?utf-8?B?cVZPbFBpRjdpdEk2WXFSKzM1dVlJSWgzN0FCVW14cFYySEFmaXhadkV1RmpW?=
 =?utf-8?Q?u0b1a470u6s=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cEhZbjZLemVwaDgwZVNhMWhJWFVSemh6eTlHWGZuM255c29CNkhtVGlOMnM4?=
 =?utf-8?B?U09LODRrN0JmVVFBNFFVUWlXWE1hdUtKOWpXdEFBaTNRc0xlY1RoUDVQT08x?=
 =?utf-8?B?MEN5OXMyRkNoT2ZRSzdOUVRtaWd1NGN1dThGbUx0T1FTK1c0NE1oTUU3REo2?=
 =?utf-8?B?VWNPOGJ5ejJ0YjVWV3pxUy9CeThPcmFaUmprTjBDc3FhbTg1UG41UFhNSlpw?=
 =?utf-8?B?bTFuM0JncG9scW1OOWM5cmJsTlVTMGJBNjhadjNmNWhuemxZWjhlaDlBLzJN?=
 =?utf-8?B?R212RE1rSTB3RUw2SnJpeEZFaFVteHkraDBuTFZOUmkvbDBBRC9YM1pwelhx?=
 =?utf-8?B?TGxIY2FVUUNZc2JXWi9ocXJVNVEydUFjSUpXUFVYVG43N200RkhZMkI3My9O?=
 =?utf-8?B?Uy9pYncxRUhKaVlQbEp0Y2wzTFdFRk5aUVJuUFphS242WHBENTVrcDNOZTFQ?=
 =?utf-8?B?bkdPc0VlNFh5TWZoSlB1UnBtQVJiS1ZkbEJhMVZEQnFYM3lKUGZBOEU0bW9E?=
 =?utf-8?B?WU93YldMRTZVYkU2aDhRRG45VGppYXhNbHVHM0NaYUt2YnRzY25wSkdIYkxP?=
 =?utf-8?B?cmhibVB6K3dRVjdEQmRNS1RtNkU5RE9EekFwOFJtV2EzSStmT083dUMvTjQw?=
 =?utf-8?B?REtxYk1MSWdOa0VaOWc2eGVEVGZQUk54c2U2Z0RXZmVYa0Fqd3BxOTV5eWpV?=
 =?utf-8?B?bjZaRUZPTUZZZ1ZqQ053QnYwTXY3VGJac1Z6Sitxb2xBRjBFdXQ3a1U4blJZ?=
 =?utf-8?B?RXIrdERxc0pDUEhoNUMwMmdlUStRUjZ2c1N3WStHTFV1MWF1WHdNTnFhYkJm?=
 =?utf-8?B?b1lhOUhJdVhheWtWdzlrUXdBckRzSjRNK0w2Q3k4NlJVWVJpUHpvRVRKa3RX?=
 =?utf-8?B?TkNFUk12dlpXbUliSUkya1hORTUxQXF1ekVlcDFqTlg4RzlTOHBoTDVubVJk?=
 =?utf-8?B?RE5nOExRZmZpUkRXYUMrNGdpV1Mwb25hRjNUNUZRUURaSlB5YmFzdDRZdENK?=
 =?utf-8?B?b2JaazVSWkgrNnR1VjltRDg0WmlVQlhVWXFYcDVpanVDaXVEMk8vbDFMM3o1?=
 =?utf-8?B?eDVrbmVNQUgwZWlLM1ZzZ3dwY3VvQWdCdDYrdkt1ZFNmQzA5QXQxdEgxbjhr?=
 =?utf-8?B?MlRyamh5REhHajZnSXNKUHZUcWxlNzRPMmtPUnA0YjFFd2hnMmVpclczdkV3?=
 =?utf-8?B?ei9oRFhpOUMwRVN5K1pEVVBtL0pzL1dZSkpPSXVsdTZXNWVPc1F3cHlSaWo4?=
 =?utf-8?B?K1IybzVyS00xeW1HNHNMVlc1RVZ5TjZYOXB5eVEwUUwxZExIWXBXOUxNaDl6?=
 =?utf-8?B?NzEwU2tJdHRVdVFHQTgySlFkTmdpenRiS0F5cmZZWjhWbzJEdHNRalpQaVBY?=
 =?utf-8?B?OXdxd0crblpVaFM2YWdrS3czMTkydUVhYXIrc1IxRXVBWHpORFVYZnpIMUJn?=
 =?utf-8?B?UDF2MnV1MU8xR2RBYzJ4c08xdXVwbEFyUXpGV2hyVXNlTlpRM1dXYVVsSUVB?=
 =?utf-8?B?Y2FYY2l6a0VRd0t6VzF5Znc4UndSY3JKSTB0R21aOEMwTWg2eDVjYVI3YkZo?=
 =?utf-8?B?THBGa2ZWK0pIT2dwOHYweW5uTVZ1aDd6dlROMW1OazNxVXVsWDgrVW0vWFZV?=
 =?utf-8?B?NjJkZTdBSmtBU1pnaFBnWGJqY2JJdjA4ZlRnTEJVVzMvckQ2NG9sQWUzWGtV?=
 =?utf-8?B?VDhHOXR2Z1Q2bTFnelJObjA3bmxZNWFEbjhnOUtzemhOKzhzMEFyTGMrSUhv?=
 =?utf-8?B?SE5nWFdvUmhFTUowR1ErcXJGVTdWSTQrZHRrKzQ3THRIeTFYaW0rbmRXR1NW?=
 =?utf-8?B?dTRtMzgvNmpOanNneVZKcHlaQW83N25TZ2lPNHVkMGNTTS9aaGNIdGNrTHFB?=
 =?utf-8?B?K1daTmI1d2srS05FRXJuZnBZa3kwL1JDVDZ2ZGhESm5RRE1Vd0ZlbXRuSFhT?=
 =?utf-8?B?NDd3czB4S3IrazVqdlZhUmNkV0gxZG94REw3eFlsRlpDckZ2NGhmSGNnRmwx?=
 =?utf-8?B?aHBxUmdEQUt4ejZ5Z1NCNFAvL1B6UzdoWWlFN3BMZ1ZZZUlkbjR5aG5FRUZL?=
 =?utf-8?B?cXdmQUg1U2V1VlFhd1lsQ3UzWHYxVlg2b3ZlTS9JRTU2b1UwenJ4OUo4RmtK?=
 =?utf-8?B?Vk5nUU03Sk5GWUtMNExSQjBYRFpaUWpFT0k3eWJhLy9mRlZOcTJDcm1MUkU2?=
 =?utf-8?B?Tnc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 47dfb1b7-9285-482a-ed9c-08dda1d01be6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 12:22:15.0930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: boqDDFQy3tzs6NSGjnqQI7kd2A7stX8tEl+XJPmckBCDs3blVmfKeC43FkOk4zVK42CkzjfheXxpAgfvflRDiqk6bHgxqc4j1nSeSeNrnSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8721
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 02 Jun 2025 12:22:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1608

Hi Trevor,

On 5/30/25 7:21 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> Add a new variable, RK_MESA_DRIVER, to allow the user to choose which mesa
> "driver" they want to use for their mesa backend. By default set it to either
> "panfrost" or "lima" depending on the SoC family being used.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>   README                              | 5 +++++
>   conf/machine/include/px30.inc       | 1 +
>   conf/machine/include/rk3288.inc     | 1 +
>   conf/machine/include/rk3328.inc     | 1 +
>   conf/machine/include/rk3399.inc     | 1 +
>   conf/machine/include/rk3566.inc     | 1 +
>   conf/machine/include/rk3568.inc     | 1 +
>   conf/machine/include/rk3588s.inc    | 1 +
>   recipes-graphics/mesa/mesa.bbappend | 9 ++-------
>   9 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/README b/README
> index 9672c6ab8d5b..97d06eaefd63 100644
> --- a/README
> +++ b/README
> @@ -159,6 +159,11 @@ Notes:
>   	compatible (see Rockchip Media Process Platform (MPP) and
>   	downstream gstreamer-rockchip plugin for those kernels).
>   
> +  mesa backend
> +	Use the variable RK_MESA_DRIVER to select which mesa backend to use
> +	for mesa. By default it is set to either "panfrost" or "lima"
> +	depending on SoC.
> +

I don't think it makes sense to make it user modifiable. You cannot pick 
which driver you want to use as lima will only work with a specific 
family and panfrost with another one, they don't intersect.

So I wouldn't actually document that at all.

>   U-Boot Environment:
>   ------------------
>   	In order to configure U-Boot to be able to store its environment into the
> diff --git a/conf/machine/include/px30.inc b/conf/machine/include/px30.inc
> index 8173cb19be2c..4918ee45d1ab 100644
> --- a/conf/machine/include/px30.inc
> +++ b/conf/machine/include/px30.inc
> @@ -21,3 +21,4 @@ UBOOT_SUFFIX ?= "itb"
>   UBOOT_ENTRYPOINT ?= "0x06000000"
>   
>   ENABLE_STATELESS_VPU_GST ?= "1"
> +RK_MESA_DRIVER ?= "panfrost"

I would also make it = instead of ?= as there's no reason to override 
it? (and you could anyway if you wanted from a confi machine file 
including this SoC .inc file.

> diff --git a/conf/machine/include/rk3288.inc b/conf/machine/include/rk3288.inc
> index 06fda69a3eb7..0fccae7896aa 100644
> --- a/conf/machine/include/rk3288.inc
> +++ b/conf/machine/include/rk3288.inc
> @@ -16,3 +16,4 @@ KERNEL_IMAGETYPE ?= "zImage"
>   UBOOT_SUFFIX ?= "bin"
>   
>   ENABLE_STATELESS_VPU_GST ?= "1"
> +RK_MESA_DRIVER ?= "panfrost"
> diff --git a/conf/machine/include/rk3328.inc b/conf/machine/include/rk3328.inc
> index e6f810dcd2ca..cdc2e2df2703 100644
> --- a/conf/machine/include/rk3328.inc
> +++ b/conf/machine/include/rk3328.inc
> @@ -22,3 +22,4 @@ UBOOT_SUFFIX ?= "itb"
>   UBOOT_ENTRYPOINT ?= "0x06000000"
>   
>   ENABLE_STATELESS_VPU_GST ?= "1"
> +RK_MESA_DRIVER ?= "lima"
> diff --git a/conf/machine/include/rk3399.inc b/conf/machine/include/rk3399.inc
> index cd1be49064ed..06326946f1e3 100644
> --- a/conf/machine/include/rk3399.inc
> +++ b/conf/machine/include/rk3399.inc
> @@ -22,3 +22,4 @@ UBOOT_SUFFIX ?= "itb"
>   UBOOT_ENTRYPOINT ?= "0x06000000"
>   
>   ENABLE_STATELESS_VPU_GST ?= "1"
> +RK_MESA_DRIVER ?= "panfrost"
> diff --git a/conf/machine/include/rk3566.inc b/conf/machine/include/rk3566.inc
> index 6386ec7eb51c..4d84bf8a11a2 100644
> --- a/conf/machine/include/rk3566.inc
> +++ b/conf/machine/include/rk3566.inc
> @@ -24,3 +24,4 @@ TFA_PLATFORM = "rk3568"
>   TFA_BUILD_TARGET = "bl31"
>   
>   ENABLE_STATELESS_VPU_GST ?= "1"
> +RK_MESA_DRIVER ?= "panfrost"
> diff --git a/conf/machine/include/rk3568.inc b/conf/machine/include/rk3568.inc
> index bcf9dd8b0f44..dedda3b8f47e 100644
> --- a/conf/machine/include/rk3568.inc
> +++ b/conf/machine/include/rk3568.inc
> @@ -24,3 +24,4 @@ TFA_PLATFORM = "rk3568"
>   TFA_BUILD_TARGET = "bl31"
>   
>   ENABLE_STATELESS_VPU_GST ?= "1"
> +RK_MESA_DRIVER ?= "panfrost"
> diff --git a/conf/machine/include/rk3588s.inc b/conf/machine/include/rk3588s.inc
> index 6ec344abae5b..5a085ab29ebc 100644
> --- a/conf/machine/include/rk3588s.inc
> +++ b/conf/machine/include/rk3588s.inc
> @@ -23,3 +23,4 @@ TFA_PLATFORM = "rk3588"
>   TFA_BUILD_TARGET = "bl31"
>   
>   ENABLE_STATELESS_VPU_GST ?= "1"
> +RK_MESA_DRIVER ?= "panfrost"
> diff --git a/recipes-graphics/mesa/mesa.bbappend b/recipes-graphics/mesa/mesa.bbappend
> index f22280754a14..9e9bf9afc4a0 100644
> --- a/recipes-graphics/mesa/mesa.bbappend
> +++ b/recipes-graphics/mesa/mesa.bbappend
> @@ -1,9 +1,4 @@
> -PACKAGECONFIG:append:rk3288 = " panfrost"
> -PACKAGECONFIG:append:rk3328 = " lima"
> -PACKAGECONFIG:append:rk3399 = " panfrost"
> -PACKAGECONFIG:append:rk3566 = " panfrost"
> -PACKAGECONFIG:append:rk3568 = " panfrost"
> -PACKAGECONFIG:append:rk3588s = " panfrost"
> -PACKAGECONFIG:append:px30 = " panfrost"
> +PACKAGECONFIG:append:rockchip = " ${@bb.utils.contains('RK_MESA_DRIVER', 'panfrost', 'panfrost', '', d)}"
> +PACKAGECONFIG:append:rockchip = " ${@bb.utils.contains('RK_MESA_DRIVER', 'lima', 'lima', '', d)}"
>   

This is fine though :)

I'm wondering if we shouldn't simply make panfrost the default for all 
SoCs and only override it to lima for older SoCs (and I believe some 
have some Imagination GPUs too (like the RK3368?)). I guess for GPU-less 
systems we would need to unset the variable. Not sure what's best here :)

Cheers,
Quentin

