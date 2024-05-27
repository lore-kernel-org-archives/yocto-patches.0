Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07BAC25B7D
	for <webhook@archiver.kernel.org>; Mon, 27 May 2024 12:23:12 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.120])
 by mx.groups.io with SMTP id smtpd.web10.26254.1716812588554206782
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 May 2024 05:23:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=nhZ6QlNE;
 spf=pass (domain: cherry.de, ip: 40.107.6.120, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klJYmD+vCwKFXbNQmCdSjZYuv34M2+pbd3FTHSa0nMqiS+ruqJxw7n5OtTymxYNIV3JmkUvhwipwqNac3qD+UTAcYnsFCuWoIHmgUQkSFrXiLO1+PIOYIPNIu2UeCpON7FU/oHz/RNFGq7V5f6LrhL3KG1kmGaGBJF65hX2YsN1K4sGrufKvF/1Ak9uCaFiOH/5DnsK7cJ3GftmkZ2zQ6MjZeWGBG3hbnY2wW1SmkwnuGsVIyKrx3SDh0XmGXF0x/QWvVIPvjnRATt8A2BYBvX9rQ5VVdKlQKY1ZTV8GaUJdkFNpQW4wWY7/x0/iZaVLaQmwEra2WKQesQT6qnwpeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GH3jUniLAIkVV8zEHZRzJxTrfJloOS+DsidEhN481A=;
 b=MZs2eHNH6MGjmVlf/ywfK/7aO8w7jMLa34gygTyr5p8+pkY9mII+xyUEhcEgrOIvfU/fBzL0KuIcqTWlp5kiGuMt9evCuqX6PCMfNvWSnVvM4jUp3SZUBTH2hO5LJaXd5zPTk5qVLipgmw8I72LLs1b0qo0/PkgEJU+zXMvmjtJk+I/AlO553DS4C9dXHnOrQjV8O1RhXBhGVlm776ka/EXhPhHbknLgAT031q5MrV/km6e/bcP8DaQOOSkjVGsEYnIlIv4CmjoiyzsMNwvFTqeDflNMfT8b2E0ePTJeUaGhDmBC9UYxOLbx9if7wvzoGClY07LHMN+qGELv9S1B8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GH3jUniLAIkVV8zEHZRzJxTrfJloOS+DsidEhN481A=;
 b=nhZ6QlNE60/V2Ce9tNoHLvnsFYyrZCOG3Izj/sCwBjpx6WWGB6vjRGRK0R+xCFdK/jGDdN/mhySPkaUb9JudWLIom9k/Zf3aTj0XzAF+nYS8p33nWBWQxAuXi7+8RIiNvckQzgEHln4DvxCDqLKds2x3h+NN6yz9XeTnXqfwQy0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com (2603:10a6:803:128::25)
 by DBAPR04MB7238.eurprd04.prod.outlook.com (2603:10a6:10:1aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 12:23:05 +0000
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31]) by VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31%6]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 12:23:04 +0000
Message-ID: <56b1e90f-3ffa-43b3-88fc-e8e0f1493aeb@cherry.de>
Date: Mon, 27 May 2024 14:23:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] u-boot: updates for
 WORKDIR/UNPACKDIR cleanup
To: yocto-patches@lists.yoctoproject.org
References: <20240526010209.33012-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240526010209.33012-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0096.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::25) To VE1PR04MB6589.eurprd04.prod.outlook.com
 (2603:10a6:803:128::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6589:EE_|DBAPR04MB7238:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c4ec1e-f357-4df2-db0c-08dc7e47c1f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TkozNmxpbmh2N202VjlRbDhNT1NFUENKTlRHZnMzb1NLSnpPUm94YjgvdWlJ?=
 =?utf-8?B?b0c2NlVndG5PamI1eVNuRGZpZUYwcGJNa3F3ckVtcm5ON2RaRkpubEpBa0Vi?=
 =?utf-8?B?Z2NwNTZqWnhjVCswcHZlWnA0ZVdVWGFYNWg3anpWalI0WkRicTNwVFlBMHBo?=
 =?utf-8?B?MHVrVTV6cFFxQldmbzFKUWpEM3pCa0pZazg4L2lsNnNXNytZY1RaMCt5RENr?=
 =?utf-8?B?TWRZOExpTHdrNzFLbC81Z2FXeW5NQUQwM2R3QWlvVmlrQmJVeGRpN1JIWGNw?=
 =?utf-8?B?R1RQT3k2R3N4ZVhFcVFwVzlBU29uOXJwSWh6eWZoaGdlVkEyS2tnZnAxYi9Z?=
 =?utf-8?B?a1lmWFhxdldickxYNndvb3d2WVN6TnhvU1llNFBhTXpSVmo2S2dXNFhmWi9U?=
 =?utf-8?B?WTE0K1g3aFRZQnQ1YzNWR1kzZkhrRit0K1BTQ3M4Y0VSMTNGNWtoS1NpZFMr?=
 =?utf-8?B?WGJlUHFsVEttK2hiMThWT0hZN0N1QUpkVWVKU1NUdHhkcVlya2IvTThuNVAw?=
 =?utf-8?B?a2V5YmlJU2lWcVdGdThuc0JUYjVVdVgrYkFzMW1TWmtLRUJ2M2ZIQmhyUzlQ?=
 =?utf-8?B?OEphd0FoS1VYUkdJTmNCRUUrRVB5YVhybHlxR045TlZnNkNUclNPVzhUN0lx?=
 =?utf-8?B?RXJFZy8vYWRGcTlpQzR3cS9zaTg4elVpOVBSZXFxUmRGVEt3dFNQT1ptaVE1?=
 =?utf-8?B?VVFkMklnVGloOEN3dHhINldGU0dYOGVTM2k1R1pHZzB6ZUFydkhhV09DdjhN?=
 =?utf-8?B?NTlpbGdtUXhJUk9tV3dIL20zT0E4c0lCeXE2OUxXbXdyL05uemprM0NIcU45?=
 =?utf-8?B?TmVnemZTZGl5dStZdW5JYlY4bysyejJHSHVkSzR2NFhvTWNFcXJCbzFTOFdG?=
 =?utf-8?B?R29PQmZSbG1MSXFJOU14U01ZZS80RWkyUThrcDRPcFZoNVA5VE5ZL21pT1Rl?=
 =?utf-8?B?SW5GUDJMYTJDMVNkVC9zcTk5UXJ1OHI4cWdMc3MwbDIrdzdWeDhEeVpzUXI0?=
 =?utf-8?B?N3BuT0tTaXdBNm40YkliRE4zWWZjemxPUFRhbzR6WmdWdC8yRU4xSk1KU3R5?=
 =?utf-8?B?K2RKQ3dHTDkrOWczYWdldzludW5pUnFoYk40dDhzYUZuaGJ5UHR3SGQ4TDF1?=
 =?utf-8?B?bXdaNEF4K2haNHYyVUJ0cHlvZ25xMFFnWW1BN3Q5VTJHV1N3aFlvb0syL0Zq?=
 =?utf-8?B?NUVkRTdZSm5CMXFEWnRhQVpnb1FyTTBHYkZVSzN4dlhzeVBZR0tFT05XWXNE?=
 =?utf-8?B?WlZpQmNOQ0hYZkMybFBSMG5tYUxGODhHOWlwZnpNek9pWGIrWmU4SGZkakFu?=
 =?utf-8?B?Sis5dEpvdnF0bTRVNDdHaUMwQjBxa1FtRzNGWS81MFJ0ZTd3STUweEwrVFcv?=
 =?utf-8?B?SnFJbVJxODRsWDZ6VE96RVVacFNtSHdEQkJFZ2IvMWdNd0tFdEFGTWkrYmJs?=
 =?utf-8?B?MWI2eVI5aUY4WldGaUJQZ1F1YThVNEl3YjIxMWNrUzBQcnIxQ1RDKzBOb1R2?=
 =?utf-8?B?VHZVd25rTlF5OEh3bWZFZ3FXQzg3eGVoSHA5elNCeUg2Vkg5elpPckxMekp1?=
 =?utf-8?B?TU0wRys4TndObnpFS3hKZ2hWZWxNUnF2eEhaby9lSmlpUXJvMTFURElrT0RS?=
 =?utf-8?B?aTJmRWdYZ2I0cWptN1FicDlZZ1kzeStvaXlHTzBISTh3NUZVMDlyV3piSERO?=
 =?utf-8?B?VW1zcytVMmVleDExODVMM1VsYWZyTTRWcEZNZWVoaEZKRFYzTDVTTFdRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6589.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dmwyZTZHSzJmYmIvT0RUNGptSGFnNUJuYS96TDUvK1cwRlBLTkZOV0dpTXZu?=
 =?utf-8?B?MGdCajAzS1Y0bkRnRlhkVC9JMkc4Um9ISkd5SU8wd2tFWUpTOWZyRkIxSk5m?=
 =?utf-8?B?L21DZitVbk9Ea2tQY1Npa2xLaGtxSjFLb3lIQUNXaFJYQkZzZ3d0aVNNYjd2?=
 =?utf-8?B?QnJtc1NrdTVHKzY0NGZhckxZNUdrWkpnUUFCVWRoeDU2bjVUYnZVdHFHY2k0?=
 =?utf-8?B?eGYvNzkvWkJONWV0RTBJa3NLOTcyV1FXVGJvRFFTNmd3Um5RSS9jOWRuOE1H?=
 =?utf-8?B?ZFpLbjdzRWVaZWY1Tk1Va2Z6azh5b2FBYS9WYjloL2E4S0FNdFRRVkZvMkk1?=
 =?utf-8?B?Wis0bTZzU1E5dXFRcEZMend6QWdmc0g5LytPejVaUzhqVXBKdmJwcEZxT1d5?=
 =?utf-8?B?cFlEWnFxWHFRMjYxOHJZaDdVYzVCYUNNMi9kMm1qNGVkdUc4VFJrTngxZktL?=
 =?utf-8?B?SjRNTTNhU2xjR0l6cTZOUjhJQUQrcnR4N00xN2xSODQwajNxWjlKODBVcytF?=
 =?utf-8?B?R3BhQjB2U29NWmR1ZVlqSFhPdmVpY1pIdllhdkI2MFRMR09YNktLdHZ1NnN6?=
 =?utf-8?B?MGgrV0VjVHVYd1JVWEdJME5qQi83cHRINHMzOG9oc2o0bnZibVRYZUZyTllU?=
 =?utf-8?B?dExla3k5aklWQTBRdVpWbVpmcFpqNHd4MnlOYUQxNTRQRXg1UWE4QXF1VzFx?=
 =?utf-8?B?Y0hYd3U1T216T2ExSlhmM2x4ekoxTEN3MDVUaDRXS3M2VGg0THJEaWpWYlNk?=
 =?utf-8?B?K0NPZkk0QkFNcGY5SEFaNW1kWFhoNHc2T0MxUHFGdW9vRTZhL1J3RE5jb0VP?=
 =?utf-8?B?YTdWNFJUME5sNlBUKzhPYnlzRXZ2cjY5QkdOZTVsSGNKcU0vNmxRYVAxMHZU?=
 =?utf-8?B?UzN0M1E2Q1d5SFEwYjQ1R2ZOK0VYSVEzMis1d3lsbFRzYWhERXJtT2VhYUtN?=
 =?utf-8?B?TzQvdSszZUs4N3lWNkpFNU8waEdoS2MxdFVwMEtTUU1va2MwRjZBZklndkRW?=
 =?utf-8?B?R1M1UTZYajFNMHB2RjFhcHFnVE5MZ0x2WUtrZlJVTW9aNGpqVVpPZ3RIZE5x?=
 =?utf-8?B?MTU5VTU4ayt6dGxuRFlKZVU1RmJFRGY3c05ScGZuaFVDdEhicDBSUEw2YjZ3?=
 =?utf-8?B?azdvM0N2MzBuanh0R3ZrWE82dHl5ajNLMDRUS3hlek5aanoyUEhIVXdKUkIv?=
 =?utf-8?B?akdKbkpCLzZDcVZtZVJxTVhxTWg1anNRSkdReTMvSDBLMWRMaWlvSGdGUVBF?=
 =?utf-8?B?THJxVEYzQ1ZiMWIvNFE5cjd3a1hHdVFkTzZCdVVCbm50OUdGZnlIMWhDYml5?=
 =?utf-8?B?bjFrNlNoSGdhcGhiTnFSSHltOURmejl5VWwwdjJ6Z29WYk55VTZFeG80Smt3?=
 =?utf-8?B?V0dScG9Lb3RSSlJnb1NIRWJKQlJzTEVyUUNTckQ0eE16aWJTRVJCNFhrU1JX?=
 =?utf-8?B?cXZaaE9mZDR5N2ROQ2VVYlgybmxtSFR1eis1dHkzVEMxYnQwYXJqYXJQMjl0?=
 =?utf-8?B?Q2xOcnB2WGlJdFZ4aDhIY3BCTkdFZ2MrYjZ5ZmJZU0RGczlBM0QrdmNOdjNs?=
 =?utf-8?B?UW8vN2h5SmNoM0c2OS8rRXBqRFBsa0FBNE9Uakd0a1Z6b0IvcXozNGhFZURp?=
 =?utf-8?B?bzNYdWpBM3lkZllEQTVXWGdzMzFJZ3dHLzNVcE92bW1ibDZmRzZvZWJTTzdy?=
 =?utf-8?B?UEN1K3NnbVgwaVF3MW9VUlJQSWswaXBXZlhnSHppcndZWGNVckVoOC9rWFY0?=
 =?utf-8?B?UWdmVTdIZmFHN0wvMEJPWUNTQ2hrYzRueWo3anNWUWlCM3NIZEtvdVVQN0Jr?=
 =?utf-8?B?U1JaR3B4RGc1NWg2VmxKdWhoUzNvSG5IMDZ1OWlnTDZpM0NOVmdhd1NmN2Ur?=
 =?utf-8?B?Z1lSUlU5SzNTVkIxdFZqU1l1eDdkank0NDBPM2k5MjA4cGNHTFU4ajdENnUy?=
 =?utf-8?B?NmNrQ3NlWm1TcGhKY0E0KzBBV2lEVFFlMzRNU2crSE9kU1hQaVppWWNFaUJK?=
 =?utf-8?B?Y29PZjdkNktXbi9KWnZESDZPd2JFUkVTZWV1ME8vemt0eTB0a0xhTWNVVklB?=
 =?utf-8?B?dlU1Y2dicHVKb1hSc2ZmVC9KcDNjUElhaUF0cG8zVlZ3STI5aEo5QUtxbk9u?=
 =?utf-8?B?TkNRYmRkRmdGdDVPejZ2N0xHTzFrbWUrWWpLdHJmakhiOElteXpUdTA4RHJS?=
 =?utf-8?B?MlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c4ec1e-f357-4df2-db0c-08dc7e47c1f0
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6589.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 12:23:04.7513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +JAt/Nm48joCw5dWkYQCFYSXzWUxClyBx1ydOv0Zg5izabWbY1h/RkKM51c3SzI6CAwV8F0qbeY2YwU552ouKQ9UdDJw3Xfh3XJ/b6X/pXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7238
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 12:23:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/210

Hi Trevor,

On 5/26/24 3:02 AM, Trevor Woerner via lists.yoctoproject.org wrote:
> Builds no longer work if artifacts are placed in WORKDIR.
> 
> oe-core: b84eec5c4cbf ("base: Switch UNPACKDIR to a subdir of WORKDIR")
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>

Note that this isn't compatible with Scarthgap, so we need to branch off 
master into scarthgap in meta-rockchip before merging this?

Except if OE-Core is planning on backporting an 
UNPACKDIR="something-reasonable" to scarthgap? Are you aware of such a plan?

For the change itself:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

I also saw that we still have WORKDIR used in 
classes/rockchip-gpt-img.bbclass, probably some changes to be made there 
as well?

Thanks!
Quentin

