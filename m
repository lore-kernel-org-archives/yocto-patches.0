Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82659C27C53
	for <webhook@archiver.kernel.org>; Wed, 12 Jun 2024 14:16:11 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.133])
 by mx.groups.io with SMTP id smtpd.web11.12581.1718201769582297063
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 12 Jun 2024 07:16:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=iNGS+/fi;
 spf=pass (domain: cherry.de, ip: 40.107.15.133, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNscMJwRVPhoS5t9qyAi1KH0uajI6L6inDfwa6HsP0EnXaVsMBBJZoPPtvXpMXWqsjyfkbrnBbWjQ390psMLY9E/zvCB/mUPdsYJDKgb9my44pfhmT6k8NDrw1Ou2cMhGxGFkoPUhrNRafyzanq5oINzwyNND3O354JB2k05YNM9A7MiZ5JRHah+8ZbNkMUOOT16LSqQUNYzouUGoGLeIXhbnJnKo8gqsXqJVfCAy5udL5q2XVxM+oGQm5qxjOhr1hpDpODBdDHQPpQYiVRlz5E5qjyRbxBxjS08MDwvC88szVlBisWjmXgq5sksTod1vqu9WE9aOsueRFbnrE8Wcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyY6o4KfbqpX1HcUSdqnSwIeRegOvN5Ql1m9UKkSt+M=;
 b=efLvRfGYbHHTBNkXvwKEMgPjOYffQGvWsjSYJIAbejw2LK5vTaqqsC9IpfQsBAQffvW16OceqjoXfb2ZiH8cCwPEhe5QrUjVySdlR3jbyw43FfEJR6nmbAMZdhZPAEGDQjXTakKngHkSXgn7UXYX3d67302fIjLfKQwRL+3BSYmJrBMag1Dy21VR8Hy3UTi23An+Wp0A/Mq3o8KhEvQkjxOl9PBtKaeoA067z6RBXXRbHvRxYni71YONMc4T/M/ZVcW9+rxC1XTG43bCLAPeKw5IjaRyXW5KphFRn4ONXyMn9t5tJv2USYPGiXCnj5Fm8tbNeZVsl7gbh1WWw1W9Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyY6o4KfbqpX1HcUSdqnSwIeRegOvN5Ql1m9UKkSt+M=;
 b=iNGS+/fiObmYU8/tFEo7H+7VJl5X8SfBEhblXE5PVRQMTC1qnfwCDfM/sRdhRP8o3tJBKScnkOi+IjIP501w+oR7BmqBSLioFqFqtBhyI74/llCW9W1mpG+wvWF4dLKZJj7Ah1EmY/OEKFZcVWym8KBMNfKa5eOf5mga783lWbU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by AM9PR04MB8471.eurprd04.prod.outlook.com (2603:10a6:20b:416::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 14:16:05 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7677.019; Wed, 12 Jun 2024
 14:16:02 +0000
Message-ID: <3ea73183-379b-405b-8316-91ce298e797b@cherry.de>
Date: Wed, 12 Jun 2024 16:16:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] radxa-zero-3e: add
To: yocto-patches@lists.yoctoproject.org
References: <20240612020116.40600-1-twoerner@gmail.com>
 <533c2092-1a89-4355-a679-1ade8a9555aa@cherry.de>
 <20240612133306.GB25815@localhost>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240612133306.GB25815@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0045.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::19) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|AM9PR04MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: fcff6565-944f-4a61-fb19-08dc8aea309b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UG8vY3h3dDJZRUVvSmJvSkhXbVdlcDFDM1ZyVk9kUk1kOUJETkVzOUFLbnJR?=
 =?utf-8?B?NUgwOEk4eEZXS08wbVZEUGtJdktkbU92UzQ5Zy9oSjBaY1Myd0NwRE9YL09Y?=
 =?utf-8?B?UVJoakFCdE01aTEyU09kTTNmRnNoUmpjLzdRYU1wNXNZMjhIMWU0b3FwN0NS?=
 =?utf-8?B?STVXdXNzVW1QYzhCM0xYOEVqWEZMWG41ZlcyZVM0OEFOUkx4Y01PQ3lmYUNk?=
 =?utf-8?B?NjEvamxyaWlBSjF1Y1JWdk82aTVUdW9TMkdsWkhPZ0pVSFFBcldoQ1grUFQ2?=
 =?utf-8?B?ZGdqQ2VkbHUwRlZxR3o2dkRxU2ViZFpkQzNwWGRRK3ZUQXpVYWlmbFZwZEFN?=
 =?utf-8?B?MnNQRHIxRVZ5K2ZiZXIxaFFHTkY0UUh0bkVHLzdrenM2L0wvQ0tKbHVYc0JY?=
 =?utf-8?B?Q1hxTGIxL1RqR0tnOWd1V3BoNFUvTE9hendiWmtyalp3VmpIaVkrSEN1SzA5?=
 =?utf-8?B?dmRMdzZIVGxaRkk1NkQvdjhpZU1IbVNWdHNSM1NTamVqU3R3ZThLZjhNdVdF?=
 =?utf-8?B?R2FuSnY4ekh1SmlWdnJGOTZjTGxrZlZXcE5CRkJESENqVGxFbDU2N2szWk9r?=
 =?utf-8?B?VHdhM0greWZZY0g0a2RvN24wVXJ1ZTYrNFN0MCsyMGV6ci9FbGc2WXdSVVhx?=
 =?utf-8?B?c0hxN21FeVVra0tVc0hEYnJDNUFDK0NLYmZqVWwybnpqR1pWZkpldjNBVVNE?=
 =?utf-8?B?UFhpQjk4R2NSamlFcVczSzZMRWMrVmlrVWlFdWhjdnphV2Fwak00d3JuMWo2?=
 =?utf-8?B?bmtTNHllM1VWeHlxYTA2VGVOTmVVQSt0Yk1GRzVLN3VkbDdNNFlYYks0SFow?=
 =?utf-8?B?a1lVV05neHFha2ZSVWkzN2I0d0dIaUJ3Wkx4S2YzTGVwb215NzkyMFRGMURE?=
 =?utf-8?B?VDU5eXJsNUI1OEVweUhqbURsSWE1Z1JsTndGV01ralh3ZytLMGRCaW1uVHNR?=
 =?utf-8?B?Zlcrckw0ajllRjNBVElRbHdBdXQ1UUU2TVNiRnpUL0lzRmtvd1FyYzU1VDIz?=
 =?utf-8?B?cjBpRm9oSEU0UXphN3RpMEt2UWtWdjl6OHpDU3I4b3JJVHJqRm5YbFNyTDZm?=
 =?utf-8?B?VkxGdmxIbmpVdUV2TmdyYmJXTk43c2hUZ2JOQVd2d2tucGdRdEQ2Z0RLSzZV?=
 =?utf-8?B?Z0lsKzBxTXNTZWw2YlZXZnNMU1RBYW9CTHdKcFRvWjJPVkhSVEtPeDZFWXpQ?=
 =?utf-8?B?MSs1UExtL1lLM1A3Nm5lVWVpL3VIMDczQ3VzempzTUNWSTJuN04rbnZsUkJ0?=
 =?utf-8?B?ek1ZKzFzR1NZVi90eGQ0MUpxMGUxRS93L1g4NGFNbWhZd2laZHhnL0VaOTVG?=
 =?utf-8?B?Z1QrTkxUUnBCenY5WDNNWm0reVFkbHNVY2Z5ZHVxTjEreVNDUmdJQmNCbHlW?=
 =?utf-8?B?ZWVrR1hqUmZMYnp0RWlzL0trWnp0STE2ZWh5QUQvdUtlR3c1cmZWejJYSHRY?=
 =?utf-8?B?dWhYSU5SUzJKbStoemtDcDI3SUhITWppbVZYa092RnBFaUh5WjVDb2U0K1Qw?=
 =?utf-8?B?TzRoeVNlSUJUbXl6Z3FUeCtiekFEZXdyOXAwSlc2eGFHMXNzUmlicUo5a0hx?=
 =?utf-8?B?RFEzOFNZcUpGOU01Nkxmd3cyR2JIS01DR096K1RSV1RTM1daMWJEbHdrQTNS?=
 =?utf-8?B?eHBWMGtzVHhyRS92bS9vMWxSbm1TZ2NLWTMrOTM5MWpjbjlaUVVqeFM5UGd4?=
 =?utf-8?Q?DRXgkG0Bd/C7Q4geE3OL?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cU54bzR5K0krMTNrbEtrU0hnVjBDUENZQWtwQkRERDY1cDZ4RTRoQ2ZwdERZ?=
 =?utf-8?B?RVlvQTJvbXZZU0hoWHdmZWpkSDY0aWhhSVZIaHBFNDdHcFRKQ0ZDbjZVWjIz?=
 =?utf-8?B?UHkwRndMaStiVHBXM2pZMUgrOEhrL0t5TzRlaGRLb2ticFZ4QjRBdFZ0cmJu?=
 =?utf-8?B?Q21wTjNIWHBmazUyNVp0RjgxOGhyTkZadWIzR3VBUFExWXF1cllaNldkUlRU?=
 =?utf-8?B?dDNwbEhURVJqa3ZnR1d6RWZWcTEwMzh3T2I2SytCZTkyM0hvQ2paeE5laGpn?=
 =?utf-8?B?eWU3cHVzSmh0amo2bUVDczFqbHpHR1BTdDgwclZ6WSt4bTQ2NExRVVJ5ZlRS?=
 =?utf-8?B?bWRqd21vcFpPaHhPcnRnTEpnV1IxK2NUMmIxT0hkNHJvdzcxekRGOTI2SjZk?=
 =?utf-8?B?cTduZFBIYjJzTGtVSFNrdi9zRU5OOUxrYVBNWTJmUGlLUlM3dVRWRzR3bCtT?=
 =?utf-8?B?WmNlNE1rRDNicFhjdW5rTStWeHhDVDFDWlltekFvc1AxdDlPcHh4RUVJYWhH?=
 =?utf-8?B?amM2VXRmQklVY3ZFZnlUSldxYkJYeU5YYnM5aXJKbGNXU0Q2TCtWcnNpOWdX?=
 =?utf-8?B?NmttTGYxUkRaTU9MeFBRMDVZb2sya0lzeHk1c1dnUEIvVVdTNXVITjlVRS85?=
 =?utf-8?B?TlYvZjJFQkhSUjNqalpjOCtvSXNsVHllMHVrY1MySXFFV1JWWUpzNU1BNW9H?=
 =?utf-8?B?Q2wzaDFrWWIycktRczBmRVBwd0FGODdkWmNnMERiTHk0SUlqNk8zSDZjbzRT?=
 =?utf-8?B?ZXdhdXU3S3QyM3dXcWpCbVB3bEk0OGw2aXdkc3lLTHNJSXU4R3pVbkNsVFBB?=
 =?utf-8?B?cWc0YTdzeVpGamlDUXlabHpxVmE5c28wWEI0ZFJtdjh6L0RLVkdnWDRoRDJm?=
 =?utf-8?B?T1ZIK2N0Ullpbkl5YVdnSHUvRUphL2JxajFDM1RxWUpwWTVoU0hwV3dpUGZw?=
 =?utf-8?B?TkNVOEZMdVFjZ3VvekJpUGJsdkhxZkZlOVhUaWdyQVhxd0t5c1pucGk0bnQ5?=
 =?utf-8?B?SzRkdnIwdlZUOWk1SzdzTG5oK3p0SkZTeU9TdG9CODkzQllIb2FVc09FY3k3?=
 =?utf-8?B?b3dCWHhNU3dsVjJJOWw3MG9vTWZrek42MDhrUHdHd3ZIVXFiWVd3dVpLdXI1?=
 =?utf-8?B?eERKMWdLb2w2bzZ6VVVpajRpbytEaGtOTkhqVFpyay9wanc5ck1yaEZveHRR?=
 =?utf-8?B?aE1hVlJzaG5sQUlqMlBjM3ZoTnV1akhiNlhLc1UwK2U4eFNWVXhaUE5vY2lQ?=
 =?utf-8?B?c2QyNkI1Y1V2SU9kMGNKVFlQTWFUem9mS3gvL0tPam1HOTVSM3FGTGFnZUEw?=
 =?utf-8?B?N1FqNysxUWF3VnZNTGR3dTRNd1RlS1d5c0FQdklQZ0RLU1VZN041Zjhiam1j?=
 =?utf-8?B?UnV0SGRnMVVlTUljUlNJTXR5ODJhai9EUTd6Z0c1MHlGVHZ5Z0dLNVNjY0c5?=
 =?utf-8?B?anI0czd3ZkF4QmNVNjhzNDdNUmcwb1hlazZ2RDlDc0IybHV6anpmN1dqaXdV?=
 =?utf-8?B?dFZ4WS9zczZSUC9DZTlTMCtubXFLK3BNdkN2WHhxOTZZbDRmTngxSTZ1cE1t?=
 =?utf-8?B?aDQvMkFpWFhrWXpzbGNqUjlhN3FMSEt5SGxHWkNSRFcxYU9ieWZ5VHhnRDU3?=
 =?utf-8?B?bnpZemNTTndid1FJeGozaDd2eFE3WEFUSnNpVVlBTWw1MFZjWlpPUVVSMmtk?=
 =?utf-8?B?eXI5L011bWRaUy9FRCt5RVd1dXFCcXdZY25zY0o1T2N1RkpSOUhLNSthMm5W?=
 =?utf-8?B?ZjZYdDk0ZE1KSG1aZW4rNGpmVFp4c0x1QlpEeXRCWnMwaWMxbkhBelloMzkx?=
 =?utf-8?B?dE40SnZpUndiSXQ3azhnV1JGT3Y5UkV1Mm5zWThER1Z4T1RNVW8vWXZrNldH?=
 =?utf-8?B?QmJadWk3Q0xnTTlmM2JFN0thYjZId2REVkJsejJ1dzRSNGNDbURMZUVlRjNK?=
 =?utf-8?B?d1daTDU1S3BHT2VLUjQ5VkZBOFRWWlZmMExHNjhSMytvMHEvRC9mUnpMUmV4?=
 =?utf-8?B?WnVnZ0NpZUFtRlo4eEtockJCdUR0cWhoUjJ5eTQ2cFkxNnQ3OXpQbEMvVlhG?=
 =?utf-8?B?NWloZHhXTVQ0TERaWUtNTU14SEdvQjM1RXNkZlBGaHVMcEQrUzlFOGdSdmV6?=
 =?utf-8?B?N1hHU0JHREpmYVBNbXdvTmhJWkoyeUtpOTFEdXd6djVqQkdQSTJPWndXaFVo?=
 =?utf-8?B?M0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fcff6565-944f-4a61-fb19-08dc8aea309b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 14:16:02.3828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26SEytKfYXJuSLLf9alZQZ0gKTiwaPRgrknlJCywUOvO6wr8uPp7W8y7BZVbNgRbTtrfqlMYeaRgZ9TcXPONaamrFcNtJ3RWTn5yRmtO26I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8471
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 12 Jun 2024 14:16:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/317

Hi Trevor,

On 6/12/24 3:33 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> On Wed 2024-06-12 @ 11:03:13 AM, Quentin Schulz via lists.yoctoproject.org wrote:
>> Hi Trevor,
>>
>> On 6/12/24 4:01 AM, Trevor Woerner via lists.yoctoproject.org wrote:
[...]
>>> diff --git a/recipes-bsp/rkbin/rockchip-rkbin_git.bb b/recipes-bsp/rkbin/rockchip-rkbin_git.bb
>>> index 7929c6ac3a10..6894558ef70c 100644
>>> --- a/recipes-bsp/rkbin/rockchip-rkbin_git.bb
>>> +++ b/recipes-bsp/rkbin/rockchip-rkbin_git.bb
>>> @@ -4,6 +4,7 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=15faa4a01e7eb0f5d33f9f2bcc7bff62"
>>>    SRC_URI = "git://github.com/rockchip-linux/rkbin;protocol=https;branch=master"
>>>    SRCREV = "b4558da0860ca48bf1a571dd33ccba580b9abe23"
>>> +SRCREV:radxa-zero-3e = "a2a0b89b6c8c612dca5ed9ed8a68db8a07f68bc0"
>>
>> Why not bump the whole rockchip-rkbin recipe? Also is there a reason for
>> bumping it? I already see rk3566 blobs in the current git commit. Not
>> against bumping it, would be nice to explain if there's a reason for it
>> other than "newer is better" (which I am a proponent of :) ).
> 
> We've seen cases where newer wasn't better. The newer blobs for rk3308, for
> example, took away the ability to read the console during this phase. Playing
> it safe I decided to just bump it for the new device and leave the rest the
> same.
> 

Fair. Still waiting for Rockchip to release an open-source version of 
this ddrbin_tool to be able to change a few params of the binary. I was 
told "they agree to release an opensource version of ddrbin_tool in near 
future" a month and a half ago. Maybe one day :)

> I'll bump it for all, but I'll have to test on all the ones I care about
> before submitting.
> 

Better err on the side of caution indeed.

[...]

>>> diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-boot_%.bbappend
>>> index 1f5f63459627..dca43d2a4de0 100644
>>> --- a/recipes-bsp/u-boot/u-boot_%.bbappend
>>> +++ b/recipes-bsp/u-boot/u-boot_%.bbappend
>>> @@ -2,6 +2,11 @@ require u-boot-rockchip.inc
>>>    FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
>>> +SRC_URI:radxa-zero-3e = "git://github.com/Kwiboo/u-boot-rockchip.git;protocol=https;branch=rk3xxx-2024.07;name=Kwiboo"
>>> +SRC_URI[Kwiboo.sha256sum] = "5d102a658262f6d2d4ea0664fe58b77db4a9eb1ebc89dbd8d6f5e75c9e563810"
>>> +SRCREV:radxa-zero-3e = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
>>> +SRCREV:radxa-zero-3e:rk-u-boot-env = "8cdf606e616baa36751f3b4adcfaefc781126c8c"
>>> +
>>
>> I think a separate recipe here is wiser? They are essentially different
>> sources from a different repo. Although, maybe the generic target is good
>> enough in which case we wouldn't need that at all?
> 
> I tried that originally, but the build requires u-boot-extlinux, which can't
> be satisfied with a new u-boot-kwiboo (?) recipe. I figured the loops to jump
> through to provide u-boot-extlinux with a new recipe wasn't worth the effort
> (unless there's some trick I haven't seen before).
> 

https://git.embedded.cherry.de/yocto-layers/meta-cherry-es.git/commit/meta-bsp/recipes-bsp/u-boot/u-boot-cherry-es.inc?id=b2a57b4a767a7e77ba430eb2255db79e0aad9996 
this is what I did in my tree for my own recipe of downstream U-Boot 
(you wouldn't need everything, just the anonymous function if I remember 
correctly).

>>>    SRC_URI:append:rk-u-boot-env = " file://rockchip-enable-environment-mmc.cfg"
>>>    SRCREV:rk-u-boot-env = "cdfcc37428e06f4730ab9a17cc084eeb7676ea1a"
>>> diff --git a/recipes-kernel/linux/linux-torvalds-next_git.bb b/recipes-kernel/linux/linux-torvalds-next_git.bb
>>> new file mode 100644
>>> index 000000000000..bbe4689922a7
>>> --- /dev/null
>>> +++ b/recipes-kernel/linux/linux-torvalds-next_git.bb
>>> @@ -0,0 +1,22 @@
>>> +inherit kernel
>>> +inherit kernel-yocto
>>> +require recipes-kernel/linux/linux-yocto.inc
>>> +
>>> +FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
>>> +
>>> +DESCRIPTION = "Linux Kernel"
>>> +SECTION = "kernel"
>>> +LICENSE = "GPLv2"
>>
>> Deprecated, should be
>> GPL-2.0-only
>>
>>> +LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"
>>> +
>>
>> This is usually at the top of the recipe?
>>
>>> +
>>> +LINUX_VERSION = "6.10"
>>
>> Isn't it supposed to be 6.11?
> 
> It's actually 6.10-rc3, according to the Makefile.
> 

OK, kind of a blurry line here as it is some in-between version which is 
supposed to become v6.11 one day but is currently just freely based on 
master branch, whose Makefile version if v6.10-rc<something>.

[...]

>>> +KERNEL_VERSION_SANITY_SKIP = "1"
>>> +SRCREV = "next-20240611"
>>
>> Please use commit hashes and not tags
> 
> I know that's the convention, but is there an explanation for why? A commit
> hash tells me nothing, but a tag that says "next-20240611" gives me several
> pieces of information. If it works and it provides useful information, why
> not use the tag?
> 

1) I am surprised this even worked, I was under the impression that only 
full hashes could be used in SRCREV, but 
https://docs.yoctoproject.org/ref-manual/variables.html#term-SRCREV only 
warns you to NOT do it

2) tags are movable git objects, so if it moves after someone has pulled 
it locally, another person will fetch other sources without even 
knowing. But the first person rebuilding will never get the new sources.

3) You're supposed to use the ;tag= parameter in the git fetcher for 
that. This will handle tags moving around so you're sure that if it 
moves around, you get the new sources, and everybody does. The issue is 
that it requires network access for every build.

Tags moving around aren't theoretical issues. I worked in a company that 
has done this multiple times in the few years I worked for them. Yocto 
Project/OE itself has done this a few times already.

Cheers,
Quentin

