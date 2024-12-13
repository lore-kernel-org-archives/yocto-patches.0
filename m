Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D70AE77180
	for <webhook@archiver.kernel.org>; Fri, 13 Dec 2024 17:29:08 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.48])
 by mx.groups.io with SMTP id smtpd.web10.1087.1734110946349871232
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Dec 2024 09:29:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=nYpqtZM9;
 spf=pass (domain: cherry.de, ip: 40.107.103.48, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzcRAs8/PCxOT2ZCbWfSaRayueIyz4UPbrTbGsTS8jHPjv86ktgUoE4uaLZ9pc8x7a1exkooFTebmwUYTh5ct8lzEvkAbSeLYKEq6pbAwnpYurSOO5EdVfzthP/dRkc8Ti+NGxq1QJaBeAYID3BZ8KE55/Dmj4zYkX9X2Y/t3f575XCtKYiVPPbjWVEu1/agn4lU81cVrruUcMwbFvG3Mr/HWfDlqHU0A51tGt/KS37FAtPSZkq3PvNzoHmu3tZYju4xInQHEAlPhPoaj+J7SZZLO8dIk2auw1/2reashThp7L1x5VV4rjFUnmB/TapyaYcGtZzuF1qKm9qwYwslrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqyAmT+BxdLgJNwperHvafJEcarpnLz64rFvlTZPqjA=;
 b=otnd/eByldswojwxE6o8qVIoUZX/J55UPdt7QIj4AI0Nfu9h2G/XDiAhTYOb/qF12FIw4usYY26K/tSUyV6yuX0F1qZAnYmJ2H8/IZkuFhg3DeWoDpz7hV19UEVwPhZfbCr2EauPtwcsE5ubKNb5rMXJrMua/b50n5SqUT2QQO1vTbEBHZB6sFNcYDtQHogzDiWQ4fVS5vXb+RQpmUocNLElH0opo8lDNTnNNKHPUYnEcPEAgWOWFlfkEHwu/WNXLHCGujZKpgKKW2Bi7EbL6Pf+qOt1sQBMgci/PrJuQ3IMJ1rpI/ue9/rf4AfHTo9IXxjwdZOyQkU0mgpSOdGu4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqyAmT+BxdLgJNwperHvafJEcarpnLz64rFvlTZPqjA=;
 b=nYpqtZM9wuaxhoNA2mfIS/WKcz+I6+SSLIQBhki1oIGwIsRjOlNSGnAD4ROMNKPUbXbEVUgV06jrx+P1a2vmzW3FYq5eOm6Habu1TzyWOngdEIe0GoVdlOq80j4PtHqK9rRGJz70xwiNYpBb8OBll7GBPwnR9i85CdCs2pO2EEg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by PA2PR04MB10258.eurprd04.prod.outlook.com (2603:10a6:102:404::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 17:29:02 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%5]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 17:29:02 +0000
Message-ID: <bdb9d739-5aa2-44b7-aa1b-c59324f39884@cherry.de>
Date: Fri, 13 Dec 2024 18:29:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2 4/4] rk3308: add
 provider for trusted firmware-a
To: yocto-patches@lists.yoctoproject.org
References: <20241213154843.27592-1-twoerner@gmail.com>
 <20241213154843.27592-4-twoerner@gmail.com>
 <ed3585bd-ad2b-4473-987a-3d366aa3946d@cherry.de>
 <20241213171101.GA1423@localhost>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241213171101.GA1423@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|PA2PR04MB10258:EE_
X-MS-Office365-Filtering-Correlation-Id: cf1831e0-8e50-4659-d86f-08dd1b9ba2ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SXlUMGpIelFtRlhVWG04R3VCd0NHU05iS0gwWnRFOU9QS0EvZXFLQmx2NWNS?=
 =?utf-8?B?NnlaeEI0K1Z0Y0dQK0ZDRWZpbkhuell3anZTaGcxRS9JU1ViZ3RxYkQwaTlC?=
 =?utf-8?B?dEhEL25yRVY3UU9PYXZpeTYwRFM1YmlaME1IeTZJbnI3RWk5VjFBYWVYclRz?=
 =?utf-8?B?NlJDRkc3V2pPc09yV1hhNlNwYS9rcWxEYlR3aHdZRjEreVlXQ2h5cFNhRkRu?=
 =?utf-8?B?UzRNc0Z5LzJDYlJRcnJrZVZPSEhHRkxFalgxVUROSFNjRWZtZitjaTVJSXhN?=
 =?utf-8?B?UXFzc1grVHBRdGNaQksvV01teUo5L21rQmNZN3N4R1E3TnFKMS8yUVBPNlY0?=
 =?utf-8?B?TGRHUHFDTnA2T015QVpyWndDL0hmL29LWmsrNGdvTlNLZWpHZ2cydmpINW9k?=
 =?utf-8?B?d2U2bllINmxzQ3EzY2NRR2tqTXh6RHNQZW9CK3JYWGJGWnV6NzN2Z0w4Y0tL?=
 =?utf-8?B?R2w3bXhPOS9IUkpNSERNdWczaDUxYVRNUDJNYmtYN0R1OUpsRndaWWM5RVJM?=
 =?utf-8?B?OXJ1bkZySXY1cUZpaGNCaSsyU1pvZTEwdTEyOW9mdzduVUpVQWlnYzh1ZENv?=
 =?utf-8?B?MUtpRDdORTJCTFM2R2ZVK25NV0xXa3NvOXBURXB3eENxTVRSanZaaGVQU0k3?=
 =?utf-8?B?RVNYWFhvL1daY3pFM1lLVnhjWmdqRnBxQXpsaDRKUzJ1NzdHb2JrVlJ3aTNM?=
 =?utf-8?B?WjlVUGZEdkNpUHZhVlQ1WnNLTHBrMXdWNXpiSFEwTHdUR1dSSzlTWlZMMlNu?=
 =?utf-8?B?SnFBMTFhS1dFQmFEOWJjaXRMSXlWZXFnLzVBWTgzNzEyQTlDTTFWbVI0SnpV?=
 =?utf-8?B?R3NCeldvcXlyWDlXVGlMejBmSjAwZjBkVW9naTQ1ei9ZVVhCbXJ4VnFYKzRC?=
 =?utf-8?B?Mjdpa0Rmc3lGemZxZG1rTHo3SVVlZENsN1dQTStubUduTkxUMjA1c0VDcmlx?=
 =?utf-8?B?OFMrMlhrUVR5L1huY1cxN0luUmNYTTYrOVNENG5rZWFMNkZ0eDh3ZGFRbGMv?=
 =?utf-8?B?VW5vN1E0TUVmbDNpR245RHI5OURFV3cycWNCVnpIZmE4aUlZZUtGdDJkQU4r?=
 =?utf-8?B?amhiajhaK3N0NWd1NlRkRWJsb1ZYb3kzeEJQWVMrd1FEWlZUWldRK2UwSXUx?=
 =?utf-8?B?MG91cGVTVFgrOGNhNWxCOFFYU1cwd2Z0S3prUVV6Mkw3MG13SmExTitHdXpS?=
 =?utf-8?B?ZWJCMGY0UzAzcFRuM2kzUU5ta0tBWWEyTGw0bTE2UlgrSnZzTUNtRkUxR29y?=
 =?utf-8?B?YVdReEVSUndBUUFEeit5RUVwSmdSalB5V3dNNUJ3SlRqSHBVY0lubEEvSnI5?=
 =?utf-8?B?R1dRMHlBZk1idTJHL2trcFhHUzFQdDYrWHYyRTAwRkd4REp0VG1DeWZaWXBT?=
 =?utf-8?B?QVc3V2xjRk92TXRsMjNVd0g0OUtkVE1KM1lDdHltVTdqTUlyWXhzbUFRVnZr?=
 =?utf-8?B?Vm5BYXJ6UjE5S0hzQmJoaytyY2NHb1p2Zy9FVCtZeXJhRXNsUGE1M2Erdi8w?=
 =?utf-8?B?b21IYjh1ZHN4VDZiTmVVNG01MzV0eG8wbS9Sb0gvM0tzejZGNDlOTlRCU1oy?=
 =?utf-8?B?WmZPTWhQY2svOXlZa3RiTVZCYkdId3hUY2lST1pqcFBiYTdzKzRDdDRwYk5l?=
 =?utf-8?B?MEdMeFhWeEVKTzliSWVhR1p3Mk1nc0tlOFExMmRPNVBRRC83T0o3STZhMEpy?=
 =?utf-8?B?SncyQUt0UmFiTlB5MG4rTThRcTA5WnJHRFJZZDNicGhmeHZ1b0JXYW01b0pu?=
 =?utf-8?B?Y1VsaWRDMHlIN0NCQ3dXQ0xFMWk5TUF2WGg2K0ExY0tUUWhQQUpNSGVSZms5?=
 =?utf-8?B?M1JaeXZuUURTQ3FJTjlHUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8906.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aXpzWDZha2ZFYlhPMHBSb1c1U29uTitJL2cvUGJwenRJcGd0ODVkbUVBdWM1?=
 =?utf-8?B?WEpmL1pVdlo5Ty9ZYmhBNHltbURObmUvZ09QUFFCS0Q1bU1RYkFPYTE5aUtM?=
 =?utf-8?B?QzNOTWVaT1J5NzNhaUZhWmxNbDFiMUt3VmVMalNHbjE1ZE9tWkV3bEpQcTNv?=
 =?utf-8?B?U2kxOWswRnU0Z0dXNmRmSHNpWGVBTlBUMy9takJ1MEVjOG1KWkxUTmozWTFu?=
 =?utf-8?B?MnhMN3B1Zmp6WkJOcTlKeldXOXQ5N2JXY0o5alRtaTM1QnlpYjRiWGY4clZY?=
 =?utf-8?B?VDJnbVlMVXlTQUxIQjNZbTZ5VXVLOXlQK0Y1N2VmT1ZzeGFiQlNYOFRlb21j?=
 =?utf-8?B?alNIeHFNLzJteG1XT25Yb3hubXpBem9iaW1kZmFPZW96c2k4SS84UTFuTVpY?=
 =?utf-8?B?QmxndzhGOGZNSmcxMG9EWU5QK2hzVWl2SGpubWMvVU1EcktwK01xa001dnZl?=
 =?utf-8?B?eHZjWkpmWUJXQndTMUhFSWJoR1VKTkVEVCtXVWZFZ2JuZzdMRmhTeVBVYWRY?=
 =?utf-8?B?WitkekpwaHF6UE1VZFRHTDNZc0ZCNVVOQzcveUIwZHNTRWs2QTF2UXhMMTlJ?=
 =?utf-8?B?dk9EVmNIc2lNbUQ5ZFRiRjd1QjR5S2RLZXJFMTBibDhvbnh3MWlnWFI1SFJq?=
 =?utf-8?B?WGF0djR4cVpwNzJlc3NSd01jbGVCZjR6OFJaYVh0RHIwbWNDYnJ3M3AyQVVq?=
 =?utf-8?B?NkVDbk5Mc3BIUjBlbG9zcjBxdkZ3NXF5QzlhdkpiWXZaZ2FGd2xmckF6OHV2?=
 =?utf-8?B?L2t5c0c5UnFqRGVrdG1qOGFYeVRoUkpvUHFWRDl3WTFlazFleGhoQzl3dnZK?=
 =?utf-8?B?c3JVQVh2eEkrOFRteHppOFFQMGd2MmJYMHEwQmxTN0ozRUZaT2hEWWZISml3?=
 =?utf-8?B?eXpKWk5ab2pEOGtzdlpMZGVwaWJpeDE1cWh0VjRuM3licEppdVk5NzU2SEY0?=
 =?utf-8?B?Vm45VVZjZkg3cm83cWJmSGYwemNxdnFUQWdTQmpvenZtZnF3dGNld0pFV1hs?=
 =?utf-8?B?Y3FwNjNXOTdTWjdwQWxMNnNTODJ0TEhLQ3ZFTzJUL1l6ZmYzQndxNCtUUnJX?=
 =?utf-8?B?bFVtNUZsamQ4VWErVnE0NDlla1FKblE5bHdGN05WTmhYclI3Q0VyYTBNTzhK?=
 =?utf-8?B?SVArT1UrNk94MEpEeGJiak8zRTVLLytSeWY0VFdDbEVldkJrZnQyMVNDMmJj?=
 =?utf-8?B?WWdCNlF3MmhodTE3VHNxRkVDZlpmR1BUSjgvc3dVUlkyQVdPYVZEclh2VDAy?=
 =?utf-8?B?eit2cnFIR3FJV3NEMXd5Y0ZuSDNzdzBSaElZQnVSN2lIZmNacCtsN3JTOGsx?=
 =?utf-8?B?ajdhamJtelg2enJOU3hGR0tleGF0RFF6elYya3hzZVJvYWRQRW9XQXJmMDJR?=
 =?utf-8?B?M2pSVGJ2NnJmb3JvRnAzR21PdWphSmMxdnc2SUZmVDRzdXI3RGNCWUdsN1lP?=
 =?utf-8?B?L0JOSkZFa0Zoam1RWlJpaTVuZU1rN2lQQUtsZEhGdDFkRlV1bVV6cXQxT3ha?=
 =?utf-8?B?N2lSSEtqWjZ2SkhCQ09YQzhIdjgyLzl1UkJCT2gyMnVnalUvUThud1Nvbk5M?=
 =?utf-8?B?blNYcDRHOXZ4L3A0aFN4WWlRTVNjVktNWlh2dHVGZThaRkxUWHBlcnBoZU9V?=
 =?utf-8?B?RHc0WDN6TzR5OXZ6T2ZDMHA1eE1qTlVNMno0RW5LZFU2N2UrUDJWTFZPNmJD?=
 =?utf-8?B?VjJ2WG03V0lPalJENENlNTJwbU4yMThUWDFpbkFIMVBMT3B3MHh4SlZFTjJE?=
 =?utf-8?B?VG9xWU0wMHRBY0hkd0RVT2prVWhXeE53RjloT1JuUG91QVBiaTJoMjNIRjc4?=
 =?utf-8?B?bEo0cXRhN3VFeXBzWU0zL1doclA0WFJwaFdMVSt6VnpLeG1ydnNBeTRnUmts?=
 =?utf-8?B?Zkd2anpneGVsTm9jYkxjeWdjay95VTgweGZmWWM5THRsaDZiSWErL0NqOTVU?=
 =?utf-8?B?eUVqNjBTM05PNkI3SXdyVUVlK0hyd1JIY3ozT2U0QlRDaEFWNE9rR1RLWGNH?=
 =?utf-8?B?TUhzQ2pMSkpXMVBMaSs1L3kwbjc0Y3B4SG5qdHU5dDBFZXJrMnlNZmpOaGh0?=
 =?utf-8?B?N09waGY3VEpJZkNBai8rc1d2RzdZSGdEc09VUjlRZ3ptZGs4QWFFMi9hdFVZ?=
 =?utf-8?B?Mk5KNWc0VnpYNlVsU2ZtN29NajRGbDlGZ3IvZTVoT3NwMysxT05BZWFHWXVl?=
 =?utf-8?B?M0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1831e0-8e50-4659-d86f-08dd1b9ba2ce
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 17:29:02.5564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2TZRnJ/MJ7xyE+O7Rs65h9pkmVV02ub5nLeaT8v2y1dJoZaRufEceXCCqfP2jWQT450PPuYoIpMigGfYVnT9MimEFxI2k1TMBaK5Ufgpvso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10258
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Dec 2024 17:29:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/907

Hi Trevor,

On 12/13/24 6:11 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> On Fri 2024-12-13 @ 05:28:40 PM, Quentin Schulz via lists.yoctoproject.org wrote:
>> Hi Trevor,
>>
>> On 12/13/24 4:48 PM, Trevor Woerner via lists.yoctoproject.org wrote:
>>> A PREFERRED_PROVIDER entry was missed for rk3308 builds:
>>>
>>> 	NOTE: Multiple providers are available for trusted-firmware-a (rk3308-rkbin, rockchip-rkbin-tf-a)
>>> 	Consider defining a PREFERRED_PROVIDER entry to match trusted-firmware-a
>>>
>>> This allows the RKBIN_RK3308_LATEST knob to work in all cases again.
>>>
>>> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
>>> ---
>>> changes from v1
>>> - added
>>> ---
>>>    conf/machine/include/rk3308.inc | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/conf/machine/include/rk3308.inc b/conf/machine/include/rk3308.inc
>>> index 1ecf085cd5de..d30901f15b4f 100644
>>> --- a/conf/machine/include/rk3308.inc
>>> +++ b/conf/machine/include/rk3308.inc
>>> @@ -19,6 +19,7 @@ KERNEL_IMAGETYPE ?= "fitImage"
>>>    UBOOT_SUFFIX ?= "itb"
>>>    UBOOT_ENTRYPOINT ?= "0x06000000"
>>> +PREFERRED_PROVIDER_trusted-firmware-a = "${@bb.utils.contains('RKBIN_RK3308_LATEST', '1', 'rockchip-rkbin-tf-a', 'rk3308-rkbin', d)}"
>>
>> PREFERRED_PROVIDER_trusted-firmware-a = "rockchip-rkbin-tf-a"
>>
>> Should be enough I believe, and it would be consistent with rk3566, rk3568
>> and rk3588s where we already have that.
> 
> This fails when RKBIN_RK3308_LATEST is not defined:
> 
> 	ERROR: Multiple .bb files are due to be built which each provide rockchip-rkbin-tf-a
> 	  /scratch/trevor/oe/builds/meta-rockchip/layers/meta-rockchip/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb
> 	  /scratch/trevor/oe/builds/meta-rockchip/layers/meta-rockchip/recipes-bsp/rkbin/rk3308-rkbin_git.bb
> 	A list of tasks depending on these providers is shown and may help explain where the dependency comes from.
> 	/scratch/trevor/oe/builds/meta-rockchip/layers/meta-rockchip/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb has unique dependees:
> 
> 	/scratch/trevor/oe/builds/meta-rockchip/layers/meta-rockchip/recipes-bsp/rkbin/rk3308-rkbin_git.bb has unique dependees:
> 
> 	It could be that one recipe provides something the other doesn't and should. The following provider and runtime provider differences may be helpful.
> 	/scratch/trevor/oe/builds/meta-rockchip/layers/meta-rockchip/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb has unique provides:
> 
> 	/scratch/trevor/oe/builds/meta-rockchip/layers/meta-rockchip/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb has unique rprovides:
> 	  ^rockchip-rkbin-tf-a-locale-.*
> 	  rockchip-rkbin-tf-a
> 	/scratch/trevor/oe/builds/meta-rockchip/layers/meta-rockchip/recipes-bsp/rkbin/rk3308-rkbin_git.bb has unique provides:
> 	  rockchip-rkbin-optee-os
> 	  rk3308-rkbin
> 	  rockchip-rkbin-ddr
> 	  optee-os
> 	/scratch/trevor/oe/builds/meta-rockchip/layers/meta-rockchip/recipes-bsp/rkbin/rk3308-rkbin_git.bb has unique rprovides:
> 	  rk3308-rkbin
> 	  ^rk3308-rkbin-locale-.*
> 	ERROR: Multiple .bb files are due to be built which each provide trusted-firmware-a:
> 	  /scratch/trevor/oe/builds/meta-rockchip/layers/meta-rockchip/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb
> 	  /scratch/trevor/oe/builds/meta-rockchip/layers/meta-rockchip/recipes-bsp/rkbin/rk3308-rkbin_git.bb
> 	A list of tasks depending on these providers is shown and may help explain where the dependency comes from.
> 	/scratch/trevor/oe/builds/meta-rockchip/layers/meta-rockchip/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb has unique dependees:
> 
> 	/scratch/trevor/oe/builds/meta-rockchip/layers/meta-rockchip/recipes-bsp/rkbin/rk3308-rkbin_git.bb has unique dependees:
> 
> 	It could be that one recipe provides something the other doesn't and should. The following provider and runtime provider differences may be helpful.
> 	/scratch/trevor/oe/builds/meta-rockchip/layers/meta-rockchip/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb has unique provides:
> 
> 	/scratch/trevor/oe/builds/meta-rockchip/layers/meta-rockchip/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb has unique rprovides:
> 	  ^rockchip-rkbin-tf-a-locale-.*
> 	  rockchip-rkbin-tf-a
> 	/scratch/trevor/oe/builds/meta-rockchip/layers/meta-rockchip/recipes-bsp/rkbin/rk3308-rkbin_git.bb has unique provides:
> 	  rockchip-rkbin-optee-os
> 	  rk3308-rkbin
> 	  rockchip-rkbin-ddr
> 	  optee-os
> 	/scratch/trevor/oe/builds/meta-rockchip/layers/meta-rockchip/recipes-bsp/rkbin/rk3308-rkbin_git.bb has unique rprovides:
> 	  rk3308-rkbin
> 	  ^rk3308-rkbin-locale-.*
> 
> 
> The way I suggested builds in all cases, and runs fine both ways too.
> 

Wondering if the righthand of PREFERRED_PROVIDER is pointing to a 
recipe? We have kind a special case with a virtual provider matching a 
recipe, maybe that's tripping some code.

I'm wondering whether we shouldn't merge rk3308-rkbin with the other 
ones and have RKBIN_RK3308_LATEST handled in the recipes directly.

In any case, not necessary for now.

Thus, since it fixes the actual issue this patch seems fine:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

