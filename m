Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4E2E7717D
	for <webhook@archiver.kernel.org>; Fri, 13 Dec 2024 13:46:23 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.86])
 by mx.groups.io with SMTP id smtpd.web10.15761.1734097580133628634
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Dec 2024 05:46:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=Iz1bAyIH;
 spf=pass (domain: cherry.de, ip: 40.107.105.86, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NdFreC+wBF18iVz/VOPQdtH6o8qkOm4rP56J588XsIIyOoUFMTO4iKhvcvCBql+u2dZYErX+6xODoUxY35Yy1sYl8GzU6HM8yhwiCJlZpJY+2reiHtloFvkCKVhWBia+Q3xv3tFtWFCYY979PF4ALEY5iw+5Fub5BhFQmUuKf2fFXcXpN5h0hLffTOeldOkg4LAkScyDH30+Ak0AsFNjOjDYy1z+MrFqXJnyKlh/miN+3LnWVLlXM22/BSW7utTI8ZcmyU6HAjucSZLf1vmHyYg+TvkiK/b4oXInhUe8z3L1fBbekYcjc6Hw6HXuzl0VEGW/AWyPFnnuR3H5AN0u/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0lDjuDTJNZ0/FgVc9bbOKMdY//Imsx9SvKeOYhahdA=;
 b=ngthZ9aK2U68fLyq8qrq3sBoxBsa6xtP3tGv7Bw2Y8lauTgqevU6UXprFrql+rju1u4s7+Sujql/zZve6Tl4oetMG4qe/FJbjHJzMwG7TLoA64+gZzu/EVIQN/+SJIJWT7PD0OXcuE/8tMR27tVRukVSm8XGR3v/EU979C8h/+ykIFijzGl+oW8YmnqiXYbKMGQRx5DLjXa28ystJuRIiAOY204zhEaSspeEdjAWhUERp33TabUsL4BfRAkeIDX/sv/HOMmW9SDqwgptD4AfaQPuoVhbdzR/ZgyuMhUNwx+Y/IaG/NBu2CR6ahH0amXIsYLobbYQIVcx4wt6OzwJtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0lDjuDTJNZ0/FgVc9bbOKMdY//Imsx9SvKeOYhahdA=;
 b=Iz1bAyIH2g1+mKYI+GTMpnYDV0w4LfwS2qsIvwebXRrGvBcsQAHbmLE2Ll8uQu1h4cKWF2gtYcrV0GUk0Rc13KQhTWhmjaDNJ1UqgFFK3+OTdZ0ByBBD/vvZ9PCH/xo1RHHJxiDVEU32DCKJk4tdGEYmseN/AB+AcFlgIV4Osrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8958.eurprd04.prod.outlook.com (2603:10a6:102:20d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Fri, 13 Dec
 2024 13:46:15 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 13:46:15 +0000
Message-ID: <28a92ad1-8855-4f9d-97a6-97bd8b512da2@cherry.de>
Date: Fri, 13 Dec 2024 14:46:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip PATCH v2 0/2] bsp: rkbin: bump to
 latest commit in master
To: yocto-patches@lists.yoctoproject.org
References: <20241128-rkbin-bump-v2-0-a194385aad7a@cherry.de>
 <20241212201137.GA26940@localhost>
 <7933e42e-32aa-47f3-a45e-497bf2f3aa40@cherry.de>
 <20241213132509.GA37306@localhost>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241213132509.GA37306@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::11) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8958:EE_
X-MS-Office365-Filtering-Correlation-Id: 634804f7-7a8f-4f83-7f33-08dd1b7c83b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QkVvY2s2SUdQTytHK3VETkdNdll1VUVEbU1CVHNuSXBDZHVLazVsZExKUk1B?=
 =?utf-8?B?c3NwRE11d1V5L2FpWWdyZkd6eDhuWTg2bHJycUdyektBSFpkbDl3RTlsSWFT?=
 =?utf-8?B?V3VwRkR0dlpIenVIU3ZiTUNpVUI5dDRSM2ZBR2F0eWVFTEt6VU5LUHUramtM?=
 =?utf-8?B?alByYjJ2M0krRDFWS2xHdmtSaXN4T2hXZmlpcC9RbFVQai83cGxVdzUrdFVI?=
 =?utf-8?B?djk5dFcyRXJ6RWpvTDhOeFNZbFFLU2tDMzhBNnFIWENBbGNaVmN5aEFFUXBQ?=
 =?utf-8?B?TWZCa1F5UUtrRC9YN3h2QXh2UW5OK1VjZlRha2tkRTV6QXlKSUlYUkZ6TDY1?=
 =?utf-8?B?YkxFTXg0YzU0M2lOS1pMRDNHcVZUU3pyZTRXWmoxNGNkUzFna1lLZVV2RUNI?=
 =?utf-8?B?TTlVM0d5Q1RkbFJmUDluMnB0SjZId0RScm15eWxBcG5DWWJYUzR6d2NRREpE?=
 =?utf-8?B?S0tWd3M0bkRITVRqSGpsTmIydG1qT0wyY1Q0Y0tJM1VPb29PK2pnUnpZYzhT?=
 =?utf-8?B?THordmpHTStHMjlyUGpJTFJaamhJOVZkcDYxMG1yZDRRSkZZN3diak5jaVNL?=
 =?utf-8?B?b3BoUFU4bHM1OG1iMFIwNWFnNVY0Q3JEbGpCWWplUkcwQ3FJVnRraVNJZHNh?=
 =?utf-8?B?Q2lLSUs1d3pac3RGQ3hVM1R1QkM2ZE5XRDB1NHhyMkVrRW54S1pxYm81czVy?=
 =?utf-8?B?d1FlNEllam9YVzRUNFgraUpQaTNoNzlFdjVpMUdITW5zVjVNWGJxWnV3Nm9E?=
 =?utf-8?B?ZkRuMTlrYU5UMC9mZGdqLzRXUWRrT3psTG9GZVRzK2tqVmJtYWw0eVorT3lq?=
 =?utf-8?B?VEROMGZYTzVIMldpeHVvRG5oNmxLTjBkYzN4clVXNnY3NUZlZE83Mk40NU56?=
 =?utf-8?B?aXRlMVlacjNDWkcvOWZXZlNKQ1RmOVdFYUQ0WmlyUVdmSS85eXhjZjFnY092?=
 =?utf-8?B?NG5XOVZJRitYNzQ5bTZmWVhaVGZuVHNQUXhMc2JVMmQrc2V2b0U0ZHgrVERI?=
 =?utf-8?B?VUNNTUx1V3lsM0F1QzFjVVVTNXJZZlFsNnBZUlJHVjJ6K2lySnFmVVJwcDBO?=
 =?utf-8?B?Mk1teUNZLzJoalZoSytFZnVjakN2cHZtNncycE0yL2docVdkTXBUTHFyRzc4?=
 =?utf-8?B?Z0p1RW83ZUVxNTlWd2JjemdmSUE0MmxuUkhOazBaRjNqcWtFMEZHOGZ4c2hs?=
 =?utf-8?B?WWlSNkYvUnJ4QjlPWFQwNzhSZ0szMVRPWUJTTENqYk5HcGUzNENlRVpoaDZI?=
 =?utf-8?B?TEphV3pMSXFrcE5XcXJ4MmJSQWU2Tms4Z2Z3VDR0VENQdGEvUHZXRjQ4eFV5?=
 =?utf-8?B?bEdjSENYQ3NEVU1ISFVFWWlFYlU3NUtuRGVTVnVJZ1BWa3B1MGhib2Y2Yk1l?=
 =?utf-8?B?WjVaQVI1eUhyN2tTU0svdWQ5dXdwVVdDVTYxOVkxcTBkcEx3UTI2RkNCNmVS?=
 =?utf-8?B?SVZ5YXFxbGR6WDBuOExVcGFURkYxeVJtcE4wR3JOblZJNzc2cFNGVEJ5aGxI?=
 =?utf-8?B?UnNNWDEvdGd5c2kwWk9YbTBoZ3JSOXo3Ly93SWUwMU5ZenFzZlprdzJkZVNy?=
 =?utf-8?B?SFZrWldFcVpscHhvUzAvaTQvbEVQSmsrcWgwTkdUMzlNcjAvbVJKVjM3K0Ra?=
 =?utf-8?B?L0VYNWorZEl4eTBqd3Q4RHRBRG5XV3JWR2UzSSt6bW56T1gvNDE2ZTNjditM?=
 =?utf-8?B?ZDZxVnk2MDRNMWovbWViSEdQMmd3dGdGNmpxM2ZwazVvTmIyOWdhVE1SVmNO?=
 =?utf-8?B?Sk0zTzVHd3JUUjJ6OVRNR1ozcktPM2p4bG05SnM0TUg1bU1YYythaFhXT2ti?=
 =?utf-8?B?U3lJcTNEbW9pMkpoc0hNZ3ZHekExbkYrUFlsTzNNV1dkdmQxZlArTWJuRHY1?=
 =?utf-8?Q?4u23sFQ0NnK7C?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MXZmSHZTc3g0RUN1NEpLTzk0cmNpaEdKeURkNUZUaUZZREZ3ZW5sbGxLUitZ?=
 =?utf-8?B?T2JTY2M5MHFRa212VkJjR0ZJOVlEZC9zS25sSWVOc3ZIekxiMzY0Z1pWYjdo?=
 =?utf-8?B?anN2bGdjbTFEY0YxUlFxN1NhTVBvUFpNUDdjLzNuVWZpSHFDSjFxOVZlaXRq?=
 =?utf-8?B?SDJTdklOM2NBa0VvbVNCcnV3c3dzOEpVODhWZHgrZTJmUjFhb1pINzZ6ZXRX?=
 =?utf-8?B?TzUzOHlpQmRzbmxnREZrRHduS29FMERPb2hIV1A5RVljektyMUFPVkhST1d3?=
 =?utf-8?B?OFlyaDJ1VXpxYVBVYTJ6TGozV2MvTkNUYllZNkVRUm9LTCs0NG1UTHlOb1p4?=
 =?utf-8?B?dkFxYW94bk01cVZJbVM5VGxSQ1BnS0lxcFRaMS9EZkFzQUJyZy9OR05SYXBH?=
 =?utf-8?B?QnhpQkxDYlVFYW0zbWZxSkZETVhLNXA5QmkxbGtuSHhwcFYrUTRrRU1rZDMz?=
 =?utf-8?B?eENiUlNwTldVN0JqeFB1dGN6Wmo0bkhhYzJkenJ1RDhwR1p1b1FsUU1DZzM4?=
 =?utf-8?B?TTBQMThPL3JYUkZzdnNsQUxnRDVJMW9UeTVER2tGZndPR3VUSFJXWTJNOXZO?=
 =?utf-8?B?bjVIbHN3R0RQNTc5UVJHZ3ZJZU5tZklNekVWQXNiSmZNQm9NK0tVN1JzWlh0?=
 =?utf-8?B?L3hLWWpQSFFmcWI2UkNkdFVYaEhYZm82WjM2SWR0RVBJM1I4Vm8vWmk1NG1X?=
 =?utf-8?B?a0lvWW8va3NMWnRFRXFqS2FvNVpsOVp4T3pmUjF3QytrRGZvSE5UaVJtMzhE?=
 =?utf-8?B?S0IyRGZJTURBWjJ4MGlWSjZzRzdqeFdDUUt3NFZhcXZEelR6S3BmOGd0QmI0?=
 =?utf-8?B?Vm1kbHNPYUhTaFJCN1hsWmZBQUo0Uk5COW16aktVd09iaCtBWXZKM0lsR3NI?=
 =?utf-8?B?YzNxZFBlZUg3MWt4djl2NnB5VHY4NmtEcGhFSlFRM2tPN2wrbGdNVGdWV3pl?=
 =?utf-8?B?NzJzanpXS08zY1lPbm4wWGk2a251cHl6OWszTFZLdUdqNU5RVk5MUDFPaWNl?=
 =?utf-8?B?VWJkU01HeStkK0YrQnJhbjc3cTJXa2lDd3lkWGlGb1JDNzVSVWF6K2Fja0tZ?=
 =?utf-8?B?MHQzL01lOTNqVjk2VXJBZU5XOTJiNzZxTXZVSmFpZVl4THhaUnYxV1hjQzdR?=
 =?utf-8?B?VDFmbUJPbXNYOU1pSXZRMXRFc2R0WVlCY0F6b3FWN3ZZTGFBTnFkQzBkN0Zl?=
 =?utf-8?B?MVQwdjBaZDl3OWxlYmMxWU5odEFFWTdVOTlMMU9Ga2RrQlhCYjVCMkE0OW1D?=
 =?utf-8?B?S1RSQmZGeEV6SkFpVGtyRGxZOU5SMFkxcXZQU3JMNHcvcW0yc1pSV1plaG9Y?=
 =?utf-8?B?dlM1MlAyY1dDbG9hZ092dnN0ZUFaSnJxSmJWeWV0RUszTmR3L2RhMWVQQ213?=
 =?utf-8?B?Z3VyMXUvNTFXeks3T0lKN0NscEY1QmpnTGF6L201aEhCTjZWeGk5UVcrdFND?=
 =?utf-8?B?TFVxTXV0TVdEYU5XbFoxWi85OVVwTXFpMEVVMjhxTUdhOG5jOVh4SjVCWVZZ?=
 =?utf-8?B?V1lCTkNHaERTOTBRVzF6bVdRSlhwakExZUFTenBEekd1VGtpYU50TThpWnBW?=
 =?utf-8?B?MEtzYWIwTWMrSDVCSVhhRmIyaXhjai9Ma1htUjZUUmN5Rzd1NWZPTVhERXhm?=
 =?utf-8?B?SkphQ3ZodnNrZWROMXp2MTlPeDE0UTdDSVpSclJLSHdDZDVDN3Z3d3ZCU3ZJ?=
 =?utf-8?B?NzBHV1MwdnBFUnRZa1pQa1RacnNxZ1dQcVcxV1hnZDdiOFQrUVYzK3JtUE1z?=
 =?utf-8?B?K2RpdDhrOVQyOE0rMkd4NGh4WXR4UFpSUDNWSTRVSk1OZEFKeEdwVk5oV3R5?=
 =?utf-8?B?ZXI5K1E0bFRlWHczNXVNMmFicC8wS0hMY2RYQVIrZ2svalB1OTd1d0R5eWo3?=
 =?utf-8?B?cXlVZnZ6ME1tejZiNGZYTzg1UFhzQ1lZMElieTlPbE1FcUdud0pjS0ZhU3Uz?=
 =?utf-8?B?dTBkTU53MWRYZ0hXa0VHR1ErM21PQXpVN2ZIUmpMUTgxVGRpbHBoMFo3SjZS?=
 =?utf-8?B?NVM3c1VuNjlxdmthc0ZEWFRPL0NoVlhWQjFsR3Vza21hdWVuSHAyTFBSeXJi?=
 =?utf-8?B?UU1yeDNKWFBsZEU1WTdtWWNuTmFVMzVkNmYyUUU3V2lRZk1waXpmaTNPNHNk?=
 =?utf-8?B?MzRoSERmaDJ3MEJmT0V5UnR0dTIzdXBKTlBiWW9yS2RhTWdrWVhhamk0dXF6?=
 =?utf-8?B?clE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 634804f7-7a8f-4f83-7f33-08dd1b7c83b1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 13:46:15.7064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3zYdrsqwbBafYw8wuXO70nr1jZqRPMiF3+1qmSiyglgNp3kOl/sVPrYl1P9TdVY1qKlahORZMxdw0+O0zoECh9Iv+BmxhcOcURZ+IpZsm1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8958
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Dec 2024 13:46:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/896

On 12/13/24 2:25 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> On Fri 2024-12-13 @ 11:10:31 AM, Quentin Schulz via lists.yoctoproject.org wrote:
>> Hi Trevor,
>>
>> On 12/12/24 9:11 PM, Trevor Woerner via lists.yoctoproject.org wrote:
>>> On Thu 2024-11-28 @ 04:58:48 PM, Quentin Schulz via lists.yoctoproject.org wrote:
>>>> We've been hit by random RCU stalls, system hangs or resets on some (not
>>>> all) of our RK3588-based products running some old BL31/DDR init
>>>> binaries.
>>>>
>>>> Upgrading to latest commit in master branch seems to mitigate those
>>>> issues, so let's do that.
>>>>
>>>> Only build tested.
>>>
>>> I have finally gotten around to testing before and after images of your
>>> patchset. This was complicated by the fact that the u-boot and kernel for the
>>> radxa-zero-3 stopped working recently, so I needed updates for that in order
>>> to test everything.
>>>
>>> I was able to confirm all of the changes work on hardware except for the
>>> rk3308.
>>>
>>> 	in order to test		i have a
>>> 	^^^^^^^^^^^^^^^^		^^^^^^^^
>>> 	rk3308				rock-pi-s
>>> 	rk3566				radxa-zero-3e
>>> 	rk3568				rock-3a
>>> 	rk3588s				rock-5a
>>> 	rk3588				rock-5b
>>>
>>> In all cases but the rk3308 I have nice before and after captures, clearly
>>> showing the old version numbers then the new version numbers.
>>>
>>> In the case of the rk3308 this patch set is moving from v2.07 to v2.10, but
>>> here's what the before looks like on the rock-pi-s:
>>>
>>>
>>> 	DDR Version V1.26
>>> 	REGFB: 0x00000032, 0x00000032
>>> 	In
>>> 	589MHz
>>> 	DDR3
>>> 	 Col=10 Bank=8 Row=14 Size=256MB
>>> 	msch:1
>>> 	Returning to boot ROM...
>>>
>>> 	U-Boot SPL 2024.04 (Apr 03 2024 - 02:37:23 +0000)
>>> 	Trying to boot from MMC2
>>>
>>>
>>> 	U-Boot 2024.04 (Apr 03 2024 - 02:37:23 +0000)
>>>
>>> 	Model: Radxa ROCK Pi S
>>> 	DRAM:  256 MiB (effective 254 MiB)
>>> 	Core:  281 devices, 21 uclasses, devicetree: separate
>>> 	MMC:   mmc@ff480000: 1, mmc@ff490000: 0, mmc@ff4a0000: 2
>>> 	Loading Environment from MMC... OK
>>>
>>> and the after:
>>>
>>>
>>> 	DDR Version V1.26
>>> 	REGFB: 0x00000032, 0x00000033
>>> 	In
>>> 	589MHz
>>> 	DDR3
>>> 	 Col=10 Bank=8 Row=14 Size=256MB
>>> 	msch:1
>>> 	Returning to boot ROM...
>>>
>>> 	U-Boot SPL 2024.10-dirty (Oct 07 2024 - 14:54:35 +0000)
>>> 	Trying to boot from MMC2
>>> 	## Checking hash(es) for config config-1 ... OK
>>> 	## Checking hash(es) for Image atf-1 ... sha256+ OK
>>> 	## Checking hash(es) for Image u-boot ... sha256+ OK
>>> 	## Checking hash(es) for Image fdt-1 ... sha256+ OK
>>> 	## Checking hash(es) for Image atf-2 ... sha256+ OK
>>>
>>>
>>> 	U-Boot 2024.10-dirty (Oct 07 2024 - 14:54:35 +0000)
>>>
>>> 	Model: Radxa ROCK Pi S
>>> 	DRAM:  256 MiB (effective 254 MiB)
>>> 	Core:  293 devices, 30 uclasses, devicetree: separate
>>> 	MMC:   mmc@ff480000: 1, mmc@ff490000: 0, mmc@ff4a0000: 2
>>> 	Loading Environment from MMC... Reading from MMC(1)... OK
>>>
>>> So I'm not sure what's going on here. But I'm happy with the patchset
>>> otherwise.
>>>
>>
>> What's going on is that we have an rkbin recipe specifically for the rk3308
>> which is selected by default :)
>>
>> I have not updated it as it was specifically done because the UART
>> console/mux for one of your devices didn't exist in newer versions of rkbin,
>> so I assume this is still the case?
>>
>> If you were to set RKBIN_RK3308_LATEST to 1, this should work (albeit
>> nothing on the UART anymore).
>>
>> Does reality match my expectations?
> 
> Enabling RKBIN_RK3308_LATEST causes the build to fail. But it's not failing
> because of your recent patches, something prior already broke it.
> 

Probably the switch to separate recipes for ddrbin, op-tee and tf-a.

Do you have the logs somewhere I could have a look at?

Cheers,
Quentin

