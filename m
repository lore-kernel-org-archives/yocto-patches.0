Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C70C27C44
	for <webhook@archiver.kernel.org>; Fri, 31 May 2024 08:50:54 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.128])
 by mx.groups.io with SMTP id smtpd.web11.7201.1717145448792110335
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 May 2024 01:50:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=mg1etIYt;
 spf=pass (domain: cherry.de, ip: 40.107.104.128, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8vS39iY3Me6UDRbspfu0wfneF6bnYoWw1tl3y/9WauBioEHvyRX4Ak7VLZuCDH3lFYHPsSd/BylLbm2WDeEjFYhKDnfsaLX9VjI6IpoA0CDrkHgs/hLlCbRFl5C1bFTs2RN37amelZ+pT7DVoVVf7MKJ0thKwVBp4KUvL3eXVfyUzkyjRg5JisXfy7AofvB9a9/1BxidxhsCKDoH1rE5f9X0KRwdk9Lcv3/DbXWyBjR8AbjQVem8bdxWmZCBdXN87Qr3WEv+C2QDa2I8aHLSuvHjg8oENNhuYc2cMi9dvN1sQrf9iLNsQUI86HH9AmMemN7Sbts2Y6GtpOz5lPutQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4p/e49jMpv4YwyEHn7zFjkeFeIw5EWblahzib6PNjoM=;
 b=Uly8coCN86n7sg5NefXza+LNeEs6L9BEkybfsa++ufoMHuq4jn/7cZorJdlFaIaUhXVk1zVej+tPudG69J2NFbqLvqnWlrAvsiPMbr8ci8jf4gQO2MLwCe+78soSr3pCjqKJBnBFDjwlq+dru+HIpvOzLoVqkA6ouzuELvywU+EBDYpkyF25Qv+eCLxHffh3dsj+gzxtYlbqULU/xNQoNH7V15J/7g4VAPbs2OnG3Q1Q7/z++xHi04rrQQBpivZnWbSQGi3QV1TKL3yfZeKrCoRWjKBjsDOhl0FgfHy6bkjcfY7UzGLj2ksjQMUzCGezah/bqpwvqVS5jLVhSle6QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4p/e49jMpv4YwyEHn7zFjkeFeIw5EWblahzib6PNjoM=;
 b=mg1etIYt3qWJz4DrWprRUriuigOo4W2k95RXXIfNBHNjal8xHsnxA83aAC00l/ikOzFyv/zwmTjmxHKCC01Q8CnB/Qp+8QpZ0vXdWQ9f+sICC3v3XNgn2ua1ZeJ09eoXGzn40YjCNfUCF/JZtjIqSBPfwZJ30H4y75am067H5BU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by PA1PR04MB10359.eurprd04.prod.outlook.com (2603:10a6:102:449::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Fri, 31 May
 2024 08:50:45 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 08:50:45 +0000
Message-ID: <cf4c218b-e40a-4ba2-bef2-318997d4adc1@cherry.de>
Date: Fri, 31 May 2024 10:50:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH meta-rockchip] rockchip-extlinux.inc: fix
 non-fit KERNEL_IMAGETYPE image boot
To: Trevor Woerner <twoerner@gmail.com>, yocto-patches@lists.yoctoproject.org
References: <20240527-non-fit-fdt-boot-v1-1-72bf2530547d@cherry.de>
 <20240530141144.GA23102@localhost>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240530141144.GA23102@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR0P281CA0266.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::11) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|PA1PR04MB10359:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c41688d-ceb6-452b-0366-08dc814ec262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZmpUNk1SYnZ5ZzQwTkZSSFFoTG0xSW1tVVZFTC85VThmS3htUGp4VjBNVWcv?=
 =?utf-8?B?Q0RRbWhUcjFvaWN3Z1RSNER3ejNrR1pKUHVvTWZ0RHlPNlBJM2Z5RTU4WWVT?=
 =?utf-8?B?aE5jZjBpWXhEeFFxNXUzSEhseFBYcVRCTDZFbEJnTXQyeDlQMkFuZXJBQ1Vw?=
 =?utf-8?B?SDlCbFhuSVo3aE5Sclpka1AzdkZVcitsMXFKZC9LR2tSUENzSUNSaHpabTFm?=
 =?utf-8?B?YldRYnE0UkJSaEQwT3gyZUh5NTFDZGpxU1YrQWpNUTNKcmlTZENEemlTSzdE?=
 =?utf-8?B?M2tpMDJTbkJ1VVpBS1dzaHVrZ1AvVGE2WkRZNStsTFRKM2lQSVdWNVNQT2dw?=
 =?utf-8?B?cm9lU3JnNDVmYVQrNEs1dUVTVEp3U1F0NHRoNTE5Q0E4T1NDTlY2RTcrMmZS?=
 =?utf-8?B?VWtLQ3BEci9iOTRndm9PK05kb1B0WlJaS1VyZG9GVUVZRGpwRWhSV05ZZTlB?=
 =?utf-8?B?bTNnajJiNHB1R09UdGtiNm5IZWU5OFcvalpYVFpEaHJURmpybnlLRDlhZkJi?=
 =?utf-8?B?UU8xNWxHOEV2MjdWa25LbTcyay9GS2RjYU8za0pLOW4zYzBXQTNCaDhRMmFZ?=
 =?utf-8?B?OWJUWG9GUy9NWjMyZ1d2czZPRkt0cVZXc2d1dWJuanFnOTRWaFZScExHZ3RR?=
 =?utf-8?B?a29mVDJLMFhxOWpHYnZrVXhmOTNna1JwWm9YVDNqNGs5QlRGNEloVFhaU282?=
 =?utf-8?B?WjA3a1c1WDhVQkRaakFXTUovbUdhK3RSSWN5NGlNZDRPSmJxZnh1VDI2d1hQ?=
 =?utf-8?B?RmRtNDVadW43VUlVMWFDZEFOZEdVcStLU2NveFlmRVd0bzZBRkZtQWszYmkx?=
 =?utf-8?B?N1BuNXRSVEp5dVBkM2ZqR3VSektLRUsyblZyVHY2cndTWDlJeWFTTFpGZlhG?=
 =?utf-8?B?aDJWT1IwM3lxK2puSkRqWEJEdXltVDN0Y0hQQkNmL2lDcXBGYXgxam5rak5V?=
 =?utf-8?B?a29iQlpmWGpqWVRLcWFXTldXQk9Tbmw4U2RPRmljMXpJdTJoUDBCd2tXNFNw?=
 =?utf-8?B?NkxLTXJGVjVEbTFFRzJBQjRDTU1lRVQ1WHEzMFQ0N3B3N1BHUmFPd3RaQmFS?=
 =?utf-8?B?RlROTnNGeEVORTRwaGd4SC80UENHT2lsejhvRlpUTTFTYUtaVzcwd3Q4NHhV?=
 =?utf-8?B?NE9IL0lUOXBkZzVDUHU1Q3Rzc2hpaHpaK2ZpRWp2NkNQNEQvQWZVanpFM0ZP?=
 =?utf-8?B?K2tod2tmYzFobEk2Zzk0bHp5M0w2aWtzaTdmbVNHT21UbDN4VmRqOHdtakJM?=
 =?utf-8?B?LzVtYTdwZmhnMk1ac3JGWVkrSk9HTVliaEJoMUE1L2FHcUZHd2liNmZOZVNh?=
 =?utf-8?B?enBEc0ZiOW1oQXdMeDZLV2R1L0tyeGpVRDJhZEljRlBtUGdXbE1jUVBnNE9K?=
 =?utf-8?B?K3pnQXZEb3Y0OUh0VW5BbmNaQzVtcEJhZmE2NFI2UFliR3ZEYk5JMkdYWUpm?=
 =?utf-8?B?SFRlamJZN2dab1ZkMzlJaDJTTW5QNXlvVGY3YnhwUXcyMlBOZHRpczFkbTA2?=
 =?utf-8?B?SEV2bTRKWUExcW5vSXlPSjhPQlBRcFhMRlV6NFl3TGhXMFhSSGtzcGhVNEoz?=
 =?utf-8?B?bEdtamdERFBWUXdBRUpPeWlRd2I3OWtJek5ZSE9zZk00R2xHZHVkT0I0MUxN?=
 =?utf-8?Q?aiGZxM5SNYjm0RAdlWG+wrks2UMWLAG0tFArBnJ6g/pE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WHNlTldqMXFDUmU1b1ZCRThNZFYrL2dQTXpDTm01ZDdCbGtUWnVCZ0RZYlE5?=
 =?utf-8?B?K3RvcnExVGpjRkFlSTljUG93bGpDVUpob09xOTBockVvR001U00rbk9PZlNs?=
 =?utf-8?B?dmI2YXZaS3ZNMkpsSkFqVVZpSVZISVl4L3FxdHRCbmZqdGcveDM4emtwRENs?=
 =?utf-8?B?Uk5FaVZSMFpKM3oyTk9xa0hhSHdwSWxTVWU1L29CM3kvV2M0NzE2c1dxM2NF?=
 =?utf-8?B?L0xNc2I2bmttSUhiaFdkMWJ6L0U2ZmpzNC9RS25OY0c3R1dLY2tJWjQyMmwx?=
 =?utf-8?B?NDYvK1JZMjZZUEVrclVEZVlNZzl4QjdNRmx1aHZiUVppUG96MmhZZGt3QWNR?=
 =?utf-8?B?YmhwbVVrL2tGaVlWNXNnTnZDbnF3ZlZ5Q2ZJL0pWWEFLSlpSK0M5alduTUd0?=
 =?utf-8?B?SzBqQWlIcnVjVm1nMHBjcjNxcmZlaUNkc2lCOUpUME40S1d6UmFwSDkxOVFk?=
 =?utf-8?B?bXl5OW1OZmFCRUJTR3NUR1Z6U04xL2pjT2x4a0hQclY3Zm92bThUcytiaTAz?=
 =?utf-8?B?K29sMDdROTZBWElhK2doclVTS2N4Y2J6NWJJM3pUOXlYTzU0MWpwaEszeGh5?=
 =?utf-8?B?M01WNis4Wi83aDQxcXF5ZG8wQ0xoUlFaNUlsMDVPMkh1MEFXWlRURDEzVSt1?=
 =?utf-8?B?SmVzL3pMY21qSTQyMHk4MU1POWIwbjdWYmlqQ0JlMXFsVUtiSm42Nkd1RjFu?=
 =?utf-8?B?L1B1bGJmSHRhbEpGblFlZmY0dkRoeUtDelZ2YkZtR1g0UVRySmhFMTN6WTN2?=
 =?utf-8?B?bmRjUUVaVlZIdHV3TE9wRVlFNVduVkFaWFVWWWhYdU9uRzRmNGlFNGtMRFdv?=
 =?utf-8?B?d1p5bGU5YVp3RTRnaXRKYmloL09LNVZnZDg5NGN5YkN2N3lEQUM3eE9aWGxR?=
 =?utf-8?B?YzEzZ1NrSHBsWUpRbmpZckVvSGNaWk05WGtJbENoNWQ0MzM3QTQvUWk1eTMw?=
 =?utf-8?B?ZUVrZHQyaWRjWVFRcS9iSCtDUEdreGtVeTVYQis2eUxsTWRlczFHYUNlNGR5?=
 =?utf-8?B?cG1HYXlzL21Ram41Tm1FcXRTSUJVYWZ4L09qWU9vczhRVlFJUERYMjdJUHV2?=
 =?utf-8?B?WWNIQjExcXFCV3Y3N3pPLzlVMVh1SHNUVTlQQnN0VHRyRGxnelFTTHFtYnJu?=
 =?utf-8?B?U3NILzJSc3c2VUpwR2U1c2gvd3N6UlhWTXlQTzBkZzAxdlB2R0l3QXFXWjY5?=
 =?utf-8?B?VHpJVUNzU3phZEJ0b2RvTnFWa1lQRGlJUWFlNlRsSVlCMUFYMlU3MHJ6NmNM?=
 =?utf-8?B?Yk5ieE5jZ3RnYXE3elZZTlpUaXpDWFdXL1ZNa08xQWRiaGMycXltZXR2RU91?=
 =?utf-8?B?T1lFZFVHeGU4SUprdGdlQTFsUEtiUW5Rc044aWF5cmRkZndkMFJWUzRZUXIw?=
 =?utf-8?B?bUlSTlMwQnR4NUNsaVdHOW8vOG1HaUVuemtHUDYvZE9nc0psenRhSG12T3Nl?=
 =?utf-8?B?WXRFTTBQQ1dUaVBQdXFHWTNyNE05RzFRUmdIZDdZL2JCSXVnOVdFNjhzY1By?=
 =?utf-8?B?c21KUDd1V1I2UkpkZmluazdPdUd6VisxSmZ5YW1td2FWMWRYVDE3WkhzTmNr?=
 =?utf-8?B?MHpPbW14b0RhcEtoVUdoUm9aUG9OS1haRnlYYXpBc0dTYTVEU2tsWG5kN2Jo?=
 =?utf-8?B?VGNsU3FFSnZ4alVPTUVSOFZXZDJmcVdGdk53VEt1TEdKRFdUenRKNVJ2TmdJ?=
 =?utf-8?B?aFJyUHNpWEkrTVNVUmhBZC92Mzl4VHJlS0JGa240K2VsVUFHY2U4alRJU3Br?=
 =?utf-8?B?eWpnbWRDNW5EbUJxSkZZQ3Q2UlhTOWJxT2ZjSEhqWGlOdWpiMmsyOVVmWnQz?=
 =?utf-8?B?ODVOTXhCNU1Ib3pTUDQ1ZURRa0M1TnFBNThyRitsR1k1N3R5MllXUzcrRzZl?=
 =?utf-8?B?aHFPcGZkUlJQa1hmTHJTQkFjZ1JuK3Bmb01Lc250WlkwdVlnejRzWFM1SkVX?=
 =?utf-8?B?T3dyM1BmRDJmSmg4S1lQdjFvaWhBcWFxZk5VeFJoNS9xbnNNbEhmd0dVWitW?=
 =?utf-8?B?c1lQUEpTRUZCdHNZWFl5ODArbG03ck1QaTE1VXMrc3R0anNNZUYyK0dHZzhM?=
 =?utf-8?B?SmZnNXJwQ3pDaER6Q0tNR01FY0E4VkpXdEdEem9GcEM1UkYzVTNTNWlpL0Vm?=
 =?utf-8?B?Yno5d2EyRFJKdVQvSVpDNFJldCtzMVk2dWEwUmpoclhUY0wyOW9tSGc4UUVz?=
 =?utf-8?B?cGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c41688d-ceb6-452b-0366-08dc814ec262
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 08:50:44.9852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5KAWSKY0Q0NUAKNqsQofUlqP/vCFKT8JrotMCjBJ6FYap9IBKXpOSeDaFjoQZo1VxquiMDbT6pA5v/m9BG8Psf0rQNEQylTz1gVhwrjpCJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10359
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 May 2024 08:50:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/250

Hi Trevor,

On 5/30/24 4:11 PM, Trevor Woerner wrote:
> On Mon 2024-05-27 @ 03:48:24 PM, Quentin Schulz via lists.yoctoproject.org wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> On systems where KERNEL_IMAGETYPE is not set to fitImage, one needs to
>> either pass an DTB or a path to a directory where DTBs are located on
>> the rootfs.
>>
>> When FDT property in extlinux is provided, FDTDIR isn't used (and
>> actually u-boot-extlinux-config doesn't even write it to the
>> configuration file).
>>
>> When relative paths are used, they are relative to the directory where
>> extlinux.conf is stored[1]. Since the DTBs are stored in /boot, just
>> providing the filename of the DTB won't work because extlinux in U-Boot
>> will search for it in /boot/extlinux. We should therefore either use ../
>> prefix for relative paths or use /boot to make it absolute. /boot is
>> more explicit and easily parseable, so let's use the latter.
>>
>> [1] https://wiki.syslinux.org/wiki/index.php?title=Config#Working_directory
>>
>> Fixes: d80fa46c42f2 ("rockchip-extlinux.inc: handle multiple DTs in KERNEL_DEVICETREE")
>> Fixes: 3b51866f2251 ("remove /boot partition")
>> Fixes: 13316b796814 ("KERNEL_DEVICETREE: 32-bit re-org")
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>>   conf/machine/include/rockchip-extlinux.inc | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Trevor Woerner <twoerner@gmail.com>
> Applied to meta-rockchip, master branch. Thanks!

Thanks!

Can we backport this to scarthgap too? How do you want to proceed? I 
send a new patch with [scarthgap] in the title?

Cheers,
Quentin

