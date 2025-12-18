Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2D3D6ACE5
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 10:46:24 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39043.1766054780049207293
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Dec 2025 02:46:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=Tdye4Blh;
 spf=pass (domain: cherry.de, ip: 40.107.130.53, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3o0Nni8WuMWVYGe6bu+eEWywNMQcJBwsmiqOUILAzn0KO+i3qx6i9Q0mL0rqqId2PTmNUG1s/yFyKN1uO5/UQ851naWWV/pbr3IDRMy93aYjyTDyFa4glg4+dPDA8qY4i0CQ12uS1Nf+W1AE1bSa1ZN+hji4hnNq4ABkCKA8CbnpnyhYr1oztwZfaPXdlim0OveSPvSNmKp9HNUI7cvbbYHHMXKZMA3ZJTEPVICBSa4TKdx61s7AE+XsLAVWsp6gSc88Xk8WD7DAoBTU2xZMR9N8zoNaSDRN57fBwo2XNaXzGpAl6DHLU0dL/xhQe/JhftYOtDi2g6PyuG9vRPG5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pL+Tt5ZQEL3VwXCERTKRnoozICXCmGPUteYP1vubC4=;
 b=KoYGPrQVXGdRokJ0I1u3KkM72QpbmoJdW8JUJiNTplEVWotzlcLR77OqZ3mJaXVswrptsJkEcNu4WPd7qTCQAqXldb1kMq3u1xPf0IZwn+Hvc/Kcl85E6YcUcaLD19fckVxe5C1OJChOZMddw8tqKRpcNDkplEn7Sw5ctxFyDZ8/BZBj+ReuYffwkS2z20WuE4YF10JOW923pD254nRzyOXfuKbyqHA4vdxrPwMb6fokO00gZXGp6u45coG67bE8WDKOy4VZKSUDl4K+6VBbrjOog+XxsQNvYAOQ4iZXsP18ErTzzjnV9k3bzHBikYf/oEeGRpdCSzkZISC+Wlerxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pL+Tt5ZQEL3VwXCERTKRnoozICXCmGPUteYP1vubC4=;
 b=Tdye4BlhaJzX2k+5fRKjx3mAtuLxd2gKk31tLGFq4yWDaH/E+VEKynbKE6S1NrL3PxpKjO+hPgvx2Yd3gXZKgy8jRrQhXRhkzjgdnfSOD2CazN7n2gGOHg+jLgI2hdxz1Ko91wPFNudUA8X179oUF5tXcv5VEx0aOilDMBGr7BA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DB8PR04MB7116.eurprd04.prod.outlook.com (2603:10a6:10:127::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Thu, 18 Dec
 2025 10:46:12 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 10:46:11 +0000
Message-ID: <026999a3-ef46-4590-99ab-bbd8fbb0affc@cherry.de>
Date: Thu, 18 Dec 2025 11:46:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH] tinker-board-3: add
To: yocto-patches@lists.yoctoproject.org
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>
References: <20251218060321.2194839-1-michael.opdenacker@rootcommit.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251218060321.2194839-1-michael.opdenacker@rootcommit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0223.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::6) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DB8PR04MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: 2362082b-fbf1-49f1-e963-08de3e22a900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eXk3Qk4rU1RSck0wZFdHZE5HYnhVOGo4OHlkZ2ZPRkJlK3BlWVlXN055L0xJ?=
 =?utf-8?B?Y29GU2NSbTlsNkZ4SDQ3ZXdXUjdQUnVQOEl1YjdLSjhWN3RXaTNnSERjc0hW?=
 =?utf-8?B?QjIzWC9uWFlvWmNkRzZGWGJxQjRnT0psTnZkcVhmSURTTDUxTlNxZkpUaTZE?=
 =?utf-8?B?bUg0VS9MYzZ2dk51bTcwZGtrbGZWT1RtQ2ZLZm9Ca3VUL0xQWG9KOEFIU1FG?=
 =?utf-8?B?MEhGZ2Z6eHM1Q1lKRWxjeUJMdHF2NWNsRVVvdDgxcnJOTThNYTh3MzdLMnEr?=
 =?utf-8?B?SnlNUFNTb1pyQVFjV0xKd2tOZG93OElhSXJ3Mko1cmk3dHNDTlU4YWNpMUZV?=
 =?utf-8?B?NWs1QnJRdEN6TGFnUnA5dS8rQnVaNnRYbnVyYklTK2hHWHM3WmU3Rkl5Y3lI?=
 =?utf-8?B?U3EwcFNuVjMxQU1KT3RPVHF4YUFBVzVDMjY3N0ZmQnA0eFBtRjI5TVRqcThp?=
 =?utf-8?B?TzAxaC9BWitTclltNVgrcFVyNzM1NS9VRStLKy9HVm5ycXhjcm05eWQ2SHlu?=
 =?utf-8?B?QnB4N1JYYkRtL3hHVWFZZXFjRUtsY3hZckd6SER4MWRSNTdnTnA3YXMzNmkz?=
 =?utf-8?B?SEFVTHNSREJncTVJdTgrSnN1cEM2TTdlWWloUVRITWlGYUdnb2UrVWJ1Z05Z?=
 =?utf-8?B?YSsxTEc4YTZQUkdRNFo4MURYUXpVTThSTTliR2diQlJZNG8xY090ZmNST1N3?=
 =?utf-8?B?ZW4wa3BwbEYxV0M3ZFVTRmNEWExVcTNzZUVlaDIxdTMrMDVjaWZydjVmUktq?=
 =?utf-8?B?VVpkalRmalM2azVLV1BIdHZUVFhpTDd1cXVxYjBKWUFUbmY0aWN3QkZtRDVm?=
 =?utf-8?B?ODA2bkMwVlVNZGhZWXgwNWlrbnRPZzZyZTF0N2l2cjJBYjQ1TFF0bXd1OGUy?=
 =?utf-8?B?SEM2WGFCTUZMWjc3NWVFY0JHMGFvWUdlUkpOY2tFbEZwb2VwK0pYclpKWWtF?=
 =?utf-8?B?d25zdElDcitNdWpWWTN3b293eFRZa1dXWkhFR0o1VlhORXdCazBPRVM3U3RD?=
 =?utf-8?B?T25yOE5PeEE2RlY2NUszVHhZandWOEZGZGJGR3VTTEJma2RnL1AvVWpxTUtr?=
 =?utf-8?B?eWFXZzdUeFdrY3pwUWpwNGZ2U21EdFNvUkduamo3VE5GRnJBT2dWbERvems2?=
 =?utf-8?B?SGhOOXNwNlR4YytzQmhteVVrOVpRdHNmRWQ3TmVkMks2L1VzaDYrQmpyZDkz?=
 =?utf-8?B?d3FaZE92dm03RGJWQjJSeEJhWVpmdlNNMnA4Y3RqZWpENHFDOG9wdXk3UnUr?=
 =?utf-8?B?akVJZ2ZabytwUko4clJKN0o3bkd4WmhDMmxHZzYzOVp2cXpLTldsa1ViMUxo?=
 =?utf-8?B?MG5TY0hvUyswaUM1S3JFb2RjaUdYK1ZjY3dWNVR3Vk1SRmpQVmlCZjJBVU5l?=
 =?utf-8?B?THh2czN3Yk1MNjJiTTJhdlZyUEpBQnJCRG9UVGNqZHpVYWM5RStlQkE5UmJ6?=
 =?utf-8?B?MEJWOEY4d1ZQaG1GYzIzTGlhUDRHOEtVTUNYakVPb1hpTVlHYy95Ymp6SW5m?=
 =?utf-8?B?cEZxcGU2c2c2eHB4VUpudlUwaE83ck9tTllWUTZScDR1NnVraXNjNXROM2x4?=
 =?utf-8?B?S3RLMGxTL0Z2TGZwaGNMNmhnOGRIWldmeDJpZkFjeTE2T2xyVGY4bmRkU2Y4?=
 =?utf-8?B?a24vSlR5NUxVcEg4SDdnR3hFam1kWnpDOEV4MGRqSG9tTmIrRGNDQlI3OVVQ?=
 =?utf-8?B?SGtuU1h1SXZ4d1RUU3dyRTcrSlhzcjk5bFRrQnJ1ZkNWUURCQ01mVFo0Y3p4?=
 =?utf-8?B?SEMyS2FvYXc5d1cycmhNVDRMb1VhVkJLRmVGemRmOHhnY2F4T0U0U3hLbGFa?=
 =?utf-8?B?Y1oySjNXTlJIMDBuUnBJVGswWFgzSXpkc1JRSXZnR3MxeDFmS0ZiNm5KQng5?=
 =?utf-8?B?cnFHL1BtSHQ4bEdoaTFtRktWVnZnSEw0ZkRuTU0yUDdBSy9zNmNUNDB6UGdN?=
 =?utf-8?B?T2cwR2d2OHNDOEQ4cHIrVUtWVFlHS1MyTW5ReWNyV3M0OHJ1N1d5cllBa1VO?=
 =?utf-8?B?dlJMSEtIS3dRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YkZOT1UxdXlqYllIY2M5VjhLUFRuWEtPNkU1WkdMYVZBR0ZyQkhxUUFqWnYr?=
 =?utf-8?B?Wk1MQ1IwRElaY0ZPMW9kY091eVZsSDB3Qm5pcVg4SmZUS0ExVnNSaXBFRFhj?=
 =?utf-8?B?T1RzMlJQQWdSdDdXYXluOEVtK0dpOVA4MXlzQ0VCc01UVndTYzRpcTZ3eDZz?=
 =?utf-8?B?bCtlTDgvb0FLRFU3d3Y3eFQvc3FndGU3SGFLeUxpeXNXd0FDL2c2cFpwM3JD?=
 =?utf-8?B?Unh6TUh1QnpjOFVudGJYS1pQSWM2dmt4ZVJCK282cDRlZzYxTVJaQlJ4OHlv?=
 =?utf-8?B?ZlFaUzloL012ZTdVeVBCeEZpUFgzUjB4MVRvcllFOUY5TXFtbmcxbnozN2NB?=
 =?utf-8?B?SDdPb1V3YWYyUFNOZzc3MmFQTjh4V3lnMXVwZzFHYXY5VjFjR3NWTDIxR2V3?=
 =?utf-8?B?WmIzOEFEMFpjdnhtUWZCNlNTZmRiUWxMNWx4L0VOSVBJWk1xU1lORlhJNG1H?=
 =?utf-8?B?TytYMkdhbXg2OG1ueU9kcjM1dFNFdDlzMmM3aUNHeUFNZEQ4QUo0cTF5aG5p?=
 =?utf-8?B?dmJkZkxwQkZEbk9UWVdMSUJNVGY5d09YYy9KeVBlNzkwYnVBbm5aaFBaZ1ZW?=
 =?utf-8?B?MDVhbzc0cjQyTGNaWWV3eXNxS0FiZi9EeldYRUZvcmRxK3gxQVlGTFFUT3ky?=
 =?utf-8?B?WFZwR0hZZkU1NEgrcm1qY3hHOGQ0VVhDc012S2pNK3FUcm5SVjlBT2k3aU1J?=
 =?utf-8?B?ZmJYNnNMZzREaHVxbUloc1U3c0lwcXJWWnNwekM2RWNoVUh3ZUpDaHJqeHhW?=
 =?utf-8?B?UGxjQ3Y0TTJCVXFYRzVqWGV3a25NL1NJcTBEMUxaNjRKUnE3UHNTRFoxbHow?=
 =?utf-8?B?Y1JqUFloSVRnbjZPbzNiVldROWg0LzExWithWGFJZjF2WWU3dkd6cE5NKzUr?=
 =?utf-8?B?RlFPMDBuSFFKZ2dWNFpPM0diWE5SMlFjZDlseVQ2VUlYaXBhYWl1ajcyVDlr?=
 =?utf-8?B?MDVzVk03VjZCdEVrb0ZycUNBVXEydUF3RWlrcXIwbG0yODF1eUUrRmNUTzJq?=
 =?utf-8?B?VmdsRFRhTFRjNUhqTERsYk4rK0dmbmJmMkRtdW9zTVZoZEpLUXlqVXoyaXFR?=
 =?utf-8?B?clp1ZWRsQUVOUXl5MDVjZDBGc3dDUmtLL2xNMUNxSGNVTmFpVi9naUhEaWtU?=
 =?utf-8?B?TmMrcnFjNUFuRXZkcXJiRXk1Q3dFaERaWHdjKzRXTDVPWVJUT0RMZm8yY283?=
 =?utf-8?B?bVlyaW02R2FtNVVyMWltbTdSbEhwMVFiRWQ4U3I1bnNyZHNUL0s3djg3eHNK?=
 =?utf-8?B?ZVNua1htOWxuU3NBUFkyb0txZzdsQW94QjlWUnlMekx6cDNITzlMMXhkSjdw?=
 =?utf-8?B?SU1Cc3VlOFlLYjBwcnM3bnByQlNOUGltUFJ6eDRNcFN6QnptTlgwdFBUWEY4?=
 =?utf-8?B?VklJRzdLZDJkTzRmUkFMSWNCVXJraXJJRE1KQkkramorQVlwWWtIb3ZRNVdF?=
 =?utf-8?B?R1JqMkszMjJhRy9aUGFYMmh6bUxWOFozeFdRcGhwcVc0cDBMM3IvZGk3UVpJ?=
 =?utf-8?B?RmkvS3Y0aUdnaFdtYUxDLzZQa2hPOVBML2YzUnZXL25SYmx5UWxMT1ViQ3d2?=
 =?utf-8?B?U1EzdzdhV3RldENsQ01iMHZBYjRkdWc1dVltQVpoLzVCenFLc1drZk5qcU5j?=
 =?utf-8?B?dGZGYTdiVWtDeUFQRDBjaUlycWFtOW82cFREU2pNMU1lL2VLN3V3MjJMVi8v?=
 =?utf-8?B?THc4ODhEMUNmano3VjdGbldwdmZZUGFPSkozMkJDWit6M2xhTE9PUE1uM0p1?=
 =?utf-8?B?UXBjTU1aUVNHc2RhOUFQaS9ubnVUcXRveWdXYW9FK1hQRDdySHZsWW9POVk1?=
 =?utf-8?B?OHZHd2l2ZkxLY2dsbzhpRmVxL3pJOWU5cDN4bGhjb01VSEJxc2t2Y1JYWkgz?=
 =?utf-8?B?bTRDL2VNWFJxUEJ1WUE2RXZxMlVSV3lYUFZtdGNWVmdQYWdKbHpseitWeUpI?=
 =?utf-8?B?NDVZVm8yS3h3QXJNUGZoSmtweUhTTFFFemdwUTJqRldnMlhkeGczeW5DeGpU?=
 =?utf-8?B?bTVIdnI3QzBRRDgyS2I0UkJuNitHd2wvM3RPOXM4b3ljTDAremNoeE9xY09s?=
 =?utf-8?B?d1RWM3I2Z2p4N0F1c0xWb1ducHRhR1hXaGR6Wit1TStLeGVIWTU4dmsyQmxY?=
 =?utf-8?B?OXlrRXpQbGV0dTcraXY1Rm9ZUnZmWHU1L3U4MmFuSFRGZFZuSW1rTm9yWUFQ?=
 =?utf-8?B?OHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2362082b-fbf1-49f1-e963-08de3e22a900
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 10:46:11.9404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VseFzrykr8aESe3gnkl4LeXccp6V1p1amoblWS7umNAhGDJf9zaaJxPVsqf7OKz5jIMUrrbIEg72dAHmsCe2YMBUuAsB38cm/K2V/5xa3Qk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7116
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 18 Dec 2025 10:46:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2815

Hi Michael,

On 12/18/25 7:03 AM, Michael Opdenacker via lists.yoctoproject.org wrote:
> From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> 
> Add basic support for the Asus Tinker Board 3 [1] and 3S [2] SBCs,
> with the Rockchip rk3566 SoC.
> 
> Support for such boards was introduced in the 6.19-rc1 version
> of the Linux kernel:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9f80b3952318d7ef18573a5010f06118602f992e
> 
> Therefore, the https://github.com/betafive/meta-linux-mainline/
> layer is currently a prerequisite to build images for such machines.
> 
> Here are already supported features:
> - Debug UART (/dev/ttyS2)
> - SD card (/dev/mmcblk1)
> - eMMC (/dev/mmcblk0, only on Tinker Board 3S)
> - I2C:
>    - i2c0 (internal bus with a PMIC and regulators)
>    - i2c2 (internal bus with an at24 eeprom and an RTC device)
> - USB 2.0 ports
> - 2 GPIO LEDS
> 
> [1] https://tinker-board.asus.com/series/tinker-board-3.html
> [2] https://tinker-board.asus.com/series/tinker-board-3s.html
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> ---
>   conf/machine/include/tinker-board-3.inc     | 11 +++++++++++
>   conf/machine/tinker-board-3.conf            | 10 ++++++++++
>   conf/machine/tinker-board-3s.conf           | 10 ++++++++++
>   recipes-kernel/linux/linux-yocto_%.bbappend |  2 ++
>   4 files changed, 33 insertions(+)
>   create mode 100644 conf/machine/include/tinker-board-3.inc
>   create mode 100644 conf/machine/tinker-board-3.conf
>   create mode 100644 conf/machine/tinker-board-3s.conf
> 
> diff --git a/conf/machine/include/tinker-board-3.inc b/conf/machine/include/tinker-board-3.inc
> new file mode 100644
> index 0000000..17d0ecc
> --- /dev/null
> +++ b/conf/machine/include/tinker-board-3.inc
> @@ -0,0 +1,11 @@
> +require conf/machine/include/rk3566.inc
> +
> +# Kernel provided by https://github.com/betafive/meta-linux-mainline/
> +PREFERRED_PROVIDER_virtual/kernel = "linux-mainline"
> +PREFERRED_VERSION_virtual/kernel = "6.19-rc1"
> +

Not sure we really want to do this. Maybe wait for linux-yocto-dev to 
hit v6.19*? We used to do this for some Radxa board in the past I believe.

> +MACHINE_EXTRA_RRECOMMENDS += "kernel-modules"
> +
> +# U-Boot doesn't support Tinker Board 3 so far
> +# but boots fine when configured for a similar SBC
> +UBOOT_MACHINE = "soquartz-model-a-rk3566_defconfig"

Can you maybe try generic-rk3568_defconfig instead?

> diff --git a/conf/machine/tinker-board-3.conf b/conf/machine/tinker-board-3.conf
> new file mode 100644
> index 0000000..d6400f3
> --- /dev/null
> +++ b/conf/machine/tinker-board-3.conf
> @@ -0,0 +1,10 @@
> +# Copyright (C) 2025 Michael Opdenacker <michael.opdenacker@rootcommit.com>
> +# Released under the MIT license (see COPYING.MIT for the terms)
> +
> +#@TYPE: Machine
> +#@NAME: Tinker Board 3 RK3566
> +#@DESCRIPTION: ASUS Tinker Board 3 is a Raspberry Pi like SBC based on Rockchip RK3566 Processor.
> +
> +require conf/machine/include/tinker-board-3.inc
> +
> +KERNEL_DEVICETREE = "rockchip/rk3566-tinker-board-3.dtb"
> diff --git a/conf/machine/tinker-board-3s.conf b/conf/machine/tinker-board-3s.conf
> new file mode 100644
> index 0000000..e23dc8b
> --- /dev/null
> +++ b/conf/machine/tinker-board-3s.conf
> @@ -0,0 +1,10 @@
> +# Copyright (C) 2025 Michael Opdenacker <michael.opdenacker@rootcommit.com>
> +# Released under the MIT license (see COPYING.MIT for the terms)
> +
> +#@TYPE: Machine
> +#@NAME: Tinker Board 3S RK3566
> +#@DESCRIPTION: ASUS Tinker Board 3 is a Raspberry Pi like SBC based on Rockchip RK3566 Processor.

s/Tinker Board 3/Tinker Board 3S.

> +
> +require conf/machine/include/tinker-board-3.inc
> +
> +KERNEL_DEVICETREE = "rockchip/rk3566-tinker-board-3s.dtb"

Do you know if Asus has provided a way to know at runtime which of the 
Tinker 3/3S is currently running the software? E.g. via a GPIO or an ADC 
channel with different voltage values?

This would help us only have one machine for supporting both. In U-Boot, 
you'd do the auto-detection and load the appropriate device tree based 
on that.

We also need an entry in the README for this newly supported board.

> diff --git a/recipes-kernel/linux/linux-yocto_%.bbappend b/recipes-kernel/linux/linux-yocto_%.bbappend
> index 2dba3d7..684d33a 100644
> --- a/recipes-kernel/linux/linux-yocto_%.bbappend
> +++ b/recipes-kernel/linux/linux-yocto_%.bbappend
> @@ -30,6 +30,8 @@ COMPATIBLE_MACHINE:rock-pi-e = "rock-pi-e"
>   COMPATIBLE_MACHINE:rock-pi-s = "rock-pi-s"
>   COMPATIBLE_MACHINE:rock64 = "rock64"
>   COMPATIBLE_MACHINE:soquartz = "soquartz"
> +COMPATIBLE_MACHINE:tinker-board-3 = "tinker-board-3"
> +COMPATIBLE_MACHINE:tinker-board-3s = "tinker-board-3s"
>   

NACK, it isn't supported, you said it yourself.

Cheers,
Quentin

