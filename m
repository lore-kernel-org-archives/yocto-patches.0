Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA6ED690F5
	for <webhook@archiver.kernel.org>; Thu, 28 Nov 2024 10:29:26 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.46])
 by mx.groups.io with SMTP id smtpd.web10.91494.1732789758901506407
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 28 Nov 2024 02:29:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=UyyRZzQf;
 spf=pass (domain: cherry.de, ip: 40.107.249.46, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+ryLoFCkxWdZ1Bmz2vaCEE/aOiA4QifwVlynF4DopaI3HnH2M8A005ZEfziO4muFvVT/fMuYdEqw35OSsnRNgXmI+dYQe1zF0S2gjM8WCqhknS0UnMnDnlC+qvAsdfzbS+SSOsU3BIElq43I+i9AuvNcp1X5kkXheT6Sq9Dpxko46otWzTwcUzGrU1CKGbq5eagORBeEqHSRkqCq4N5skAu+W1lHN0MDRbcYqTz1PaYoRM1tIUGpxg7dWCS3GnK5T1jussJNbyatBNKOiIj4KrKAkrMeD6fodx88pThMrJZ5XUWLHuLhYoiQhYIBQ/6bBrH/FKOjcmZS1OR50ENOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckufjZ5soq2mGg4YywoxG2B3Ngc+yNWBOGuUtuJVm/c=;
 b=Q57XLsjl19QBp1Q/y6ZXAxsa+LT2725srdIfxij3FjK00lQ9batX21o8/YeCWYqqDhNyaA1igbQ0VPyziinfqrm4QDsO1/6hy4IJEhjs4pAlOrWtBGPGysHTcp0sV3vcDAERu/1zxVRs9tolOL+CkNbsDa4fODzoANwWgjFxC2NcvsoRO4uExZdZoh3vNHaeo0IelhzjuVMsgNrgGy6v+0wCJAT3TEWU/heA0Ip1ZpiLEN+dr00jLNvd8dxoV7oxNPoNx7tCNJ37vhdiF1/sDBdTSuUhF5vGi0oklsbFjRZNfTy7ODHsdYJky6Wg/pVdFcUmmV7Py72PD5VFSkn/Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckufjZ5soq2mGg4YywoxG2B3Ngc+yNWBOGuUtuJVm/c=;
 b=UyyRZzQfOc7i5qUkFOr9ForuVO/e9DIh6xnOOdZXH8EZtaMaVgvfeT1A9OfWOnHInWAx+CVAYuPvQwyuk0gqMO32L5ZjOin9MNHE9Iu6D43NLUoOfJW634kaRTy6720BJVmZie7iSSxytihD2yWVkwTx0YxgDbbAZqpaNJeaqs4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU0PR04MB9276.eurprd04.prod.outlook.com (2603:10a6:10:357::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Thu, 28 Nov
 2024 10:29:16 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 10:29:16 +0000
Message-ID: <c787fd0c-dac4-4681-a9e3-5e09c4018f98@cherry.de>
Date: Thu, 28 Nov 2024 11:29:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip PATCH 2/2] bsp: rkbin: bump to
 latest commit in master branch
To: Trevor Woerner <twoerner@gmail.com>, yocto-patches@lists.yoctoproject.org
References: <20241127-rkbin-bump-v1-0-b90b6c04a88f@cherry.de>
 <20241127-rkbin-bump-v1-2-b90b6c04a88f@cherry.de>
 <20241128010101.GB17984@localhost>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241128010101.GB17984@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0002.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::29) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU0PR04MB9276:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a26148-9130-4c91-53af-08dd0f978280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TG50dnRVcDF4dERFMDRNdk9tS1hFeFlvS2tVTCt6RElOSlptWnUrZVZBOTdQ?=
 =?utf-8?B?WDZ4blpjeW80NEltRTBtemNzZzFLTFZJVHl6dEVENkpJZVVqWGFYcEFwK2xX?=
 =?utf-8?B?aytab2V3MzdFVXpKVlU5YzI4UC96b0ZSZXlTa2MvUTdMQW1ONmdBc29HWW9K?=
 =?utf-8?B?RG1WSEN3TldsS25Xai9JTEpvOTlKc1FrZnEwbTR6eGVaeUtGSjRyWXduRVJH?=
 =?utf-8?B?dEUyV09ZaHViUzNhY2FEVWFhL2hLeEtZZFR2VFpYUktGSmtOYzN1UWplOUdh?=
 =?utf-8?B?aU1CVnBWMVhtQ1k5bHk1TXExbUZhckRoMU13aGsxMzBwalNFWUpSR1RCaUU5?=
 =?utf-8?B?UHVuU3NoY0ZNY091VVgxc0I5OFJZdEwwaEJ5OGxoN2ZXYmNuTmFaMGhWdzNQ?=
 =?utf-8?B?VnlpWVpPY29wcEpaYnNyOEJpd1NpRkpuazc1c04wZEVOallGNkg1aEZsR1RK?=
 =?utf-8?B?aW9ONktGL1pXV0VCNXlibW1UOWUraHhBbGgvRlBFUXEwWVZpU1B5RzQvTFY1?=
 =?utf-8?B?RlU3MVltdGVFb2JDUTluaG14TnhGRnMwZ0dRMjZaRlBsRzNpZ2tHSWJDUEpF?=
 =?utf-8?B?K1hJbmZWdTNvMjBSY2cwbmkvblB3YTI3K0lnazJoZUJiZFUxUmhITzNiNm9R?=
 =?utf-8?B?c3JDeVMrNzdWYmJZZ2E5YkdrblJhMGlEZWt3eUN2bG9yNU9HRWxabzMyK1Na?=
 =?utf-8?B?V0c1bVlsREFkeHRlOGtUN0xNZEc2MVNoV3Y0NEYxTk0wWDFlRUE5Tm1KOExS?=
 =?utf-8?B?bEdaOWVkSWZJYVpaSW1IM0tickxIcUNsK0NFUXBTN09BRUhvUnB5REdRZGtP?=
 =?utf-8?B?elArNXdtcGpZUDUrbFZ6VG5DK1IzL05vVnpyU3doeHlPajBlQ2pvNENXa1Bh?=
 =?utf-8?B?NzdWNVdFOFhRSnFvWXVxaTZyZy9SNENubjFDQmQxNDlZQ0NyZkZZbjJZYkFV?=
 =?utf-8?B?QUZVWld6Yk00Y2dOU1g1bmNZbWlNSXAremcrQlJScTVsc3M3S2RPQjV0KzFE?=
 =?utf-8?B?Z0VONzRXZkh6SUlFZURwUzBYN2tMd09oVTJveVF4b0dJRXRmME9BbXNVZXZH?=
 =?utf-8?B?SS9XTjcyNmIwWklJMXU1alNBY3hhd1RPQjR4N3pMWnRWWXhKSkdzOFJyb2or?=
 =?utf-8?B?UFplamNDdVVsWlFNYWMyVzcwSSs4KzU1ZERBVXJoeU5HOFc2SnBQOS9Lazhr?=
 =?utf-8?B?S0VuajFERThoakFBOC9ETWFRdUkzWlY5WWprVW9sQ2ZDZVNObFM4cWNvVlhP?=
 =?utf-8?B?c2VnbnNlWmYySVpBWWRadjVhU3A5cjVUYTZjd3lZTHFtdzJGT1F6SEQvbVBG?=
 =?utf-8?B?Um51RHpDSHJ2SHlwYVM5eVRFRk9tU3Y2Y0VJMlIrSFRMekUzQURodlg2YVNP?=
 =?utf-8?B?MFQ5bHE4RTF5a1BTY3RHeWh1TkFZSVlKeThJWVpDdHlhUzdhQ3c5Z3JWb1lw?=
 =?utf-8?B?WjFyaDVqWUJSNE9UUitSeWhMWHNZeXFaa3RVUUlQS1E4MjNtOURxRm9xdENx?=
 =?utf-8?B?LzZNMThHdExkdlZqZ1Z4d0UwVGZrcnRWMUZ3eUFaV2FpYXVwS00rSjZvRCta?=
 =?utf-8?B?SVlVRHFhL3pyUG5Sek9BRmNDYWhRYUdENGVveUliRkM3SnQxdEtTRzAwUzBa?=
 =?utf-8?B?L0I5REZpcllyRGRod2hBSUtUWnNSb3FlaEZRcW5ORGYwUHJjOWZJcU5IdDR3?=
 =?utf-8?B?aW9xTXpQQmdMVUxjR3FzMlljc1JGOTFUNkp4S1Uxc0N3VkpwNTQrYmhLVkV5?=
 =?utf-8?B?SmxVOG1MVlZ2T3JOYm55Tkl2WHVDU3ZxZ3BNaVBMV25CdnVmbzk0U0dDVGYr?=
 =?utf-8?B?dlZYNk4yZDNPN1pkZWo1Zz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TncvWHJvTXROd3dMZWtmY1N6aFZPenBFdmhXZGkzblY0RjlkUlloZDJpSkxw?=
 =?utf-8?B?RWpOTXZwQWR4aml0ZGNrZ0xKWk5CWDBNQWdsQzQyQnJHNndkbkUyMnZxK016?=
 =?utf-8?B?K0ZGVWZzSEVZSjB5SzNJdUcvem5lYmxaN2U0RHJvcmZOb1c5MFFvWFNwb1di?=
 =?utf-8?B?UDVodWx3MkFZZ3RETS9tRHRmbkNLMVZicEVTTVoyOEFkZXZPbU95d3RJc3lz?=
 =?utf-8?B?SG0vL3FqR1RkVVVDdXVDOXpNUXpnRm9OYnJxR2NBZEQ0YVdxNkFJOFh0K29I?=
 =?utf-8?B?dk1lR2l6UG1jbDRKa0kzRzBqOTVsbTVLOWpvdlZvSXZ1RE01US9VSEJKNHcz?=
 =?utf-8?B?TURkRWQ3eWRQeHlsT3RrWTltRFhZVktTNVlYM2N5RThjajlJYzByOFFTYUVM?=
 =?utf-8?B?OHozOUdRMUpjRjF6b0tCMENVeThBLy9sdDVXV3ByTjdVQTJLaVowNVd1OXBs?=
 =?utf-8?B?Vm1kMWsxalkzS2JwUUx3VFJ5RGRwZ0RVa1VLdHRNK25QZXFPNzBlb1B1Vko0?=
 =?utf-8?B?SlVldzZuWDN5L2g3WUQrZE8vbzlZOVJkRmtPZEcyWjRGMlEwMUwvR3owUks4?=
 =?utf-8?B?TGo1WWdJYkk5ZVRVNDJuaFhjZkh2YmE2TkVJK3MvSDhJTjI1bmFBckpZMEhO?=
 =?utf-8?B?cWZMbHBMa2ludnhOYmpJbmZuL2JMMjJhTjFlT2gxQ1RqVGNWNDN6ZW1LQjl6?=
 =?utf-8?B?V0JKSE8zRXdyQ1ltVkhDVDN6R2dGZ3BGdld0UzM3UDRMQ05qVXNiOVJMYXFK?=
 =?utf-8?B?ZGVYdjE4WlRFcWxMM0lhSGUzM0JaTjBac0VuTHFza0tmOTZXaUsrb2hWYmU4?=
 =?utf-8?B?RCt2QUdXQkhtMGpvV1ZDT1NBTFhFNXc3Tlh2SGZobWh4QzFXOWZwR3h2Z1pK?=
 =?utf-8?B?TnBOMGlFT2hpNHAxSTZzYXhCdWlxVGpSblhqRGhKVzIyVC92UWNvWEN6OHBF?=
 =?utf-8?B?TU1YejhIT05BaVVCbEo0VEJ2YlNmRGlrMmU2ayt2VFI4a3hxQWY0dlVMY1Bs?=
 =?utf-8?B?NzdUekd2THoyS09pbmFpTmpybUNMV1pHYzU1NVBpalRHUHpvc01ORG5naHBp?=
 =?utf-8?B?NzFyczl4cTFPSC9xTVB1MGlJWEx3UGdDMUZseCsyNjl3YVBqYXRORWxCcG1n?=
 =?utf-8?B?dHVTQXkyaStkU09VYU1NdGNUVjVuRVVEcVhCVGkzMjE3b3BEL3QrUkx0Z1gw?=
 =?utf-8?B?N1pmazlIMFRKdTE0OW1yT0g4Y2pkbWFncFRxVWtRN084elZabG1QM05kZUl2?=
 =?utf-8?B?QnFLZzdQM0RWWGM4ZFhuVjJkV3NxMmdIV0lFQlpNdnpOcG1wWkVYaG1Oa2VW?=
 =?utf-8?B?eHpkYzhyQ0dIREtBdTBZVGNXVU93czRjazZEVlZuQTFnR3lWeXdOQVYxbUth?=
 =?utf-8?B?d2J2Ym9ONmg3THVoY1cvRWVDMExzaGZXYUlRbUZaZElSRFIyZDBuL3k5cjZq?=
 =?utf-8?B?L0x2MmtmSll0L1RVMXJNWmc5Z01mUVpaVWpsWnh3NjY1SzRBMEpzWFl2TXpo?=
 =?utf-8?B?VzNaVjAxcVJmMTdGWUhlUVM1OWVQNm1KVFBiRFFQV3FuWmVIYWFMU08wd2ZT?=
 =?utf-8?B?VHdSeDdWYVJ2S0NEYXdYRFlGbk9QVno2Z0FqYTllOVVHZU51aFJ4U1l2SGdr?=
 =?utf-8?B?QlppUzhtdHFiRkFhVmRGRTE0eWwvd0l6a0VWZ3M1YWVTOUxndXViZjFGVVA0?=
 =?utf-8?B?cHJuSE1EVHJYc2Y0Wm1QUjJEUWdOYnZycWRCY3JubjlqZ2UxL1hLWEI0b0tH?=
 =?utf-8?B?UmYvZjBabGRUSnR4b0thRDI3Zkw3b0FMYVRSTitVUEhpOVdOcmtSMHpXWE5p?=
 =?utf-8?B?RFhra3Z4ckF3b290bEFFaFppeEhIQzhvWXAzUlkyTmpiamlEVkZRYk9ocWov?=
 =?utf-8?B?QmIwUU5CMEFZQmtOSzRVa2lwcEtyNmwzRFVBZlF0Z3JQQXRxUVhBOEovbTE1?=
 =?utf-8?B?aUtCZE9JSDFQQmIwUm43VkEyYUhXcDlGMktpLzBmYjU2OWxXN0Z1NU5yRVhn?=
 =?utf-8?B?eEd1d05jYzA0OWVQbDdsTHJaN2ZWMVByd21ocm1DRS9JUTN2K243dGlLQk9I?=
 =?utf-8?B?ZldiZmRzSUFzc0dOcjRnYVptY2lTU1R0U0Q1R1NUZ09VUm1kL0dzT3AyTUlp?=
 =?utf-8?B?T1ZDT0MwWWVNdXNqUGFJVExaQ2N4Rk5nNU4wTEl0SWxkdHNyYkFlRnNOckJo?=
 =?utf-8?B?ZFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a26148-9130-4c91-53af-08dd0f978280
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 10:29:16.1734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FcLSP0zJfrXPUTp7CkL9rg2HShaoTAfBZEYMlx9W5LoeMba4soxC7BOj0+q/aiLkZiyJuyc+fXGIZVTH80PczBBDDIHuGibbucTQnbD1XFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9276
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 28 Nov 2024 10:29:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/852

Hi Trevor,

On 11/28/24 2:01 AM, Trevor Woerner wrote:
> On Wed 2024-11-27 @ 04:12:59 PM, Quentin Schulz via lists.yoctoproject.org wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> This seems to be fixing random RCU stalls, system hangs or resets while
>> running upstream Linux kernel on RK3588 boards.
> 
> Very interesting! I have a number of boards that I'm actively using in the
> rk3566 (radxa-zero3e), rk3568 (rock-3a), and rk3588 (rock-5a/b) families.
> 
> I'm build testing and will try running them once I have images.
> 

FWIW, we had a "lot" of RCU stalls on some of our RK3588 products with 
DDR bin v1.11 and BL31 v1.38 (that we used outside of Yocto builds), 
much less (but still some) with v1.16/v1.45, but none (at the moment) 
with v1.18/v1.47 (which are the latest publicly available). Note that 
some were working just fine with any of three versions, so it seems to 
depend on some factors (quality of the binning?).

Cheers,
Quentin

