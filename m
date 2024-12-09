Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3111E77180
	for <webhook@archiver.kernel.org>; Mon,  9 Dec 2024 15:03:52 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.56])
 by mx.groups.io with SMTP id smtpd.web11.103584.1733756626539415282
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Dec 2024 07:03:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=WWzjxorU;
 spf=pass (domain: cherry.de, ip: 40.107.22.56, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAa5eGNcpY9CS2JBg4YOMQMc8N63q2+fCOLrxRUvkg5uDb3EY+XO3Pm1Pv8CILyQHCzIyL0ckN6wKJMteet2dFaa51dkV4P6Tew5vZQSpq/a7bgtkdkJ2AM+UUbM/2HPCZi3ffhuFoA2cSsnRq3DSD2vVsRqImop/AqNAoEVLaA5YLs/vWWeaTXQCeqnMZy0ot9DbMJaZZvsVDM5tSo83D4ui4W+H/wEHCYVMGOEe8jatopmOyjZ5nmoPZR9lwQfyYRfuzfyueRYJ91wFVBtno3VIh5U9tg7yD8BSV1Xdyfgqw7z2rFcb7Zl4XkXfgaSiTiwiF6SfgaycMO0JwTHUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQN00tJ8cTOAd5LSxz9FKr8LwCkH6sdLhuQDdKVuxvA=;
 b=m/+YTjaXWqjNtsdEz/dif/0mh2sFH8pHOfGu9MV5ImbIW+EIj7MLfLhVqf5eAnZ4pJ2R4m8iCQ7hxzUaRZF3XACFceNzuS0H2Pz7CMM6MCatZMVfbxnLVfHMcVp8L+1Ed02Cm6uPvkfgcOXFnm/tD279BuIkswwMgl1Q4TNRswbG7bg+O7bvQh/ETfp/NHZ2ZK+DssswNcV6Q2if8tWKGYpKMXxvo2uELvcAZMqQw9tYgwBySq8aUHIvmG9zGLV2UfNuitxowegNXtaSkeTeTGuwdrLMBo0y0N9rhhPwQTqF9KuEUbEaIqIkb4930mWpHflqcBLDAIOHGKn20ET0gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQN00tJ8cTOAd5LSxz9FKr8LwCkH6sdLhuQDdKVuxvA=;
 b=WWzjxorUjMhzaXaHziumBo5jsJ/Zla/mwiqzsY8nFpFoh0cafE5mK7gbUeDa9AnLOSTEK00tbq96jA0Wl7lV11ogohEM5Xe7/Me24jOXDagDpXnHi+N152KU74SVnbqQ+o4lwCzH+9ywrAl2YI+XAS77DdDYObqm/dgv+ERP8D0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV1PR04MB10485.eurprd04.prod.outlook.com (2603:10a6:150:1d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 15:03:40 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 15:03:40 +0000
Message-ID: <40544790-d5be-46d9-a420-9a835c1b2c1a@cherry.de>
Date: Mon, 9 Dec 2024 16:03:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] linux-torvalds-next:
 update SRCREV
To: yocto-patches@lists.yoctoproject.org
Cc: Oleksii Kurochko <oleksii.kurochko@gmail.com>,
 Trevor Woerner <twoerner@gmail.com>
References: <20241207153154.9125-1-oleksii.kurochko@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241207153154.9125-1-oleksii.kurochko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV1PR04MB10485:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f9f210b-c454-4677-c9d3-08dd1862aa28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?R0dhOTByd29WMXk0ZTBmempLQktCcEFjaWxjQlRyK3dhTW9NQ2ZRTUNSeG42?=
 =?utf-8?B?dTNTVWRiRjYwN2NydmZBUnpKaWI4Q3hQQmdNTndvMEJmV252dkVGdEozZVl0?=
 =?utf-8?B?Vko0UlpsVW5Lb3JaaFVnMGY3bkFYS2ZSdHBLVkRhelBQVnYxREFIVmMrcHkx?=
 =?utf-8?B?bm40d3NEWG9jSWIyZXByMTg2dGxYbWttVDZOVWYzVFBBd1pMSy9MdlN5UkZ3?=
 =?utf-8?B?YllXMEtKRThKdytQWVJvYXVxVmQzallGeUZ0c1FnOHoyY00vWW5jZVJoaXhv?=
 =?utf-8?B?SHcvS3pFdlVOaEZiVHhOQjVpaVAyM3AzMEEraFZVc2xuSFJ4Umdidks3cUsx?=
 =?utf-8?B?V3Q1eXpXNzY3anloQ1NGSDJDVkl1WFRzc3VOQ2lzVXBmWTZPSndQOHdXYmFq?=
 =?utf-8?B?VUovNW1JYjQzbm43ZmpHMGZReFVKVEJudVcyRTMraG8xbnQrMmJLaURYZ1pu?=
 =?utf-8?B?dFl0dXVJWGFTQjJxRnRVQk1yVUZjck9jRm1iN29lZllWU3lWM2tVcHk2S0hO?=
 =?utf-8?B?V2pXTlNWWEZnc1NHd1AxNkJxdW5mdktRblZuWEJPOHlHN29HeFdUb2NtM2pR?=
 =?utf-8?B?cTFJd2EzRUo0Y2RVQ2tOcHAwcDRzYy9pM01LZms4c0VkRVFoOFo5cGh4L290?=
 =?utf-8?B?b0JIaHFuRHROOWNwK0Q3QU05V3Q0U1RwRGRYbDJmNW1NaVdIZXBCY0t0V3N4?=
 =?utf-8?B?a1BvS0k0cGpUbVNkZHArMkMxWmdNdC9rdlJNZmluRnMzYjROaGM3eFRVRmZE?=
 =?utf-8?B?YU5BS2pXU3RDQUkvVmtleXM5V3ljczZLaC90enJuVVc4SnI4cGZDT3M4MmE4?=
 =?utf-8?B?WkVaSEd2YjU2UVNybzJybXl5QWpVa3hwV0lkNWZsN3VnR0dwMWVneS8wRmtw?=
 =?utf-8?B?QkpwcWtLamZ6M3ZDYnFkcDZLWi9NaXBPc0N6VklGQ1pQV00wVUJFWlJkcTha?=
 =?utf-8?B?MFNDWWFzdGxqNjd5QThmalp5OUdxQmpMdDZMTVhtTW5rZlpIcW1BZy9wNjF1?=
 =?utf-8?B?dE9ZUWNHSEU3T2Q1NU95cFJBQlc0RzR4S1BiOWlyaWFIMUxGWkJYVmc0KzJO?=
 =?utf-8?B?UVpIY3dNdGJuZjZsUnQzMDBzZjA1NWpZaUxGcUlHN1FMdXJtUW1kZTAwblRi?=
 =?utf-8?B?NStqTzNWNW5vc0VHYVBDT1p2c3pOY2U3L25FcjYzUmdqM00zZWpRQkRyZjhp?=
 =?utf-8?B?R3V3aWVqL2RPcTlOYmE5aElKNlp2elE2bnBrU1NTU2ZlN0wwK3N0M3JLa1Fh?=
 =?utf-8?B?OEpUdGdadzUvMjluZVpjbTF0Ui8xMDV5TENneldmaHAxMiszRlFGRWRCTklS?=
 =?utf-8?B?dUJZamx6WUx2cWNpR2JUOUd6aUN3U3YvelJaM1NROWRJUmFaaityMXdpcUsx?=
 =?utf-8?B?eGtQUld2Qk5NcmJiRHdnSUhCeno1WkhxMEwybUdWYzRiWXRjMzhCSWFJSDJs?=
 =?utf-8?B?YmgyYXRxV1JBMFM4M2NrYjB3RFovcmdBOUFZcC9FMXBnMzJueDJSZXVMTVF6?=
 =?utf-8?B?ZmRwdXJUaWZRSVpVQXFpS3d3d2JGbE1ITjFDNHkwL20za3YzN1dPS21TRktG?=
 =?utf-8?B?UUtTTElheEFuU3RlK3ZzOUU3ZkZsTjBrY0pYcnEzOHM0dmwrNENVeVlxeEl6?=
 =?utf-8?B?aU9RQnFWcjc4UUJhbkJ2NXJZQjlwek83UnpaeVZwbkU3V0VBdmtnVzRQV1RE?=
 =?utf-8?B?MTgwMXhwK05RQWplTVNDYnRvbmVRdkI4cGFrN3F3dHB6UC8rdDBqclloY3Ar?=
 =?utf-8?B?dHdxcm1UekdSc3JQYXBuaE11QW45RlYyc3A4cE5LSi9CK1EzcTFYWkVXYk1S?=
 =?utf-8?Q?fTtG/YbPi/thPRP8AVtGJM1U/okZVga2LJ/4U=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VmFrTU5RNkhnV2UvWHFzWW1iZmhhMU1wbnZCS2NPSmx3NkZnUGR5Q1dHSHRk?=
 =?utf-8?B?TGZYTklzWUl4MWZSVVcvOEQ1dHhHSEk4NXhVbjBhK0N6TzRkN1krSDQwZWhS?=
 =?utf-8?B?ZjRrdlJ1M3pxR2pSMDdIU3VvczV6UDV5MVVhNHFFYnpyWXVCTFNON011ak1k?=
 =?utf-8?B?TWZTa3VheS9DSkhyb1pYdXdDYnhvclZlbTUvM29ZTnBmRVZsdU5Kck5sSEd1?=
 =?utf-8?B?dE1HWHgzY0Q4ZnRaRjVZYWs2MzB5T0k5VTRway9tWklxSHpZOXE2eW1TWU9X?=
 =?utf-8?B?cXE1WmVvY1FIQWM2U0NxSVMrWXhLS21vb09uT2tjZ3hmRy9STWFiQ1VNZTJu?=
 =?utf-8?B?MWJqeE1hd3ZTaHprTGhmSkxtRkN3SVMxUDAxWTdUWnhiUVQvbzRKYmh5REg1?=
 =?utf-8?B?ZUYyRHBtWFlCQkE5K1Vha3g5OHk3OGhJcGJvaEdSLzZORk9Db25iQ1MyUHRT?=
 =?utf-8?B?Vk9kREN5QU9PcURKMVBtVEM4TmxVU3oxV2huTTZNeThoQ3h2V2pLSWd5YTNF?=
 =?utf-8?B?akdSOUxWWHIxNzAyak1aanhGcktNaG1vU0ZuRndabmlzSUFSUXJqek1EUVB2?=
 =?utf-8?B?OWdKUUh2dW00dWYrMmRnK05VbDJrU2luV2xWZ0hQMnBFMjA5WFFmNFR0OWEy?=
 =?utf-8?B?Yy9uNlFlRlpFN1VEeGdhQXF5OVR2L2pxWGJUQmxWTUlDYUVwS05tTC8rRWla?=
 =?utf-8?B?Q2t5U1JkODZkNU14VEc2eERiVHk4NmJ5b20zejBvaENZamRHNDdFUjFYaDdy?=
 =?utf-8?B?cVowMWl0dXlwTFlBYUxGbFlZNGxUVVJCVUxqSzBpVnpDR3NQYzV3bGtSQktP?=
 =?utf-8?B?cXpDbDdZSlVIWGdtbWNxWkFYOHJHN0VMYWVwOENMVEczZE40NjAzSGFuV0xC?=
 =?utf-8?B?aElreVZrU3Q5eGJrTFArV3U3ZE1EdGo5ci9rMmpXcm5hVUdhdGlRTjAwTHFE?=
 =?utf-8?B?b0RPd2dxbUx6L0dSVXIxRWlZTkxSNVQrWGovQVp5Qk9iaXVjbjNIR3haeWNK?=
 =?utf-8?B?ZnpuR1NqTFV0Y1BRZStXbVQ4TC9GRWp0NUFiTHdSYS9vbmtpTE5IaFBFZHJz?=
 =?utf-8?B?RENhWkU2ZStLM3NhenUrNGNyWUtPMmdwaCsrb3ZQVkdpWUdGcm1DYzlLeFVY?=
 =?utf-8?B?TTd6ZU1zbkhXVG10eGV4MG5wK1JEN2huUnZJRUpUbDB5ZU9EdU52Yy9nTGdP?=
 =?utf-8?B?NWUybG5zL3NQSW9tbk9TWExCZklqRmhMT2YwTStscEpQY3BrQXJyTjFiazhv?=
 =?utf-8?B?c1hKYTZMQlZHamp6Q2U5TERGOEVKajNORDV2TE84UVZTdllhVEJoejNaSVBm?=
 =?utf-8?B?cTIxSSs2N3lQQ3VUcFgzTy9zL0l1VENDTS9IQjRCdm1jYXNyZHVUaFVBN21z?=
 =?utf-8?B?cHRmaFRhSTYzaVlhWkdtSjR3T2V2aWZlcm1kWTNtb0hMa0hZVHU0QU11ZU9H?=
 =?utf-8?B?SVU5Sjd2dW4wM1VmS1djTVljUnYxMWF5OFZtQVg3VzV0Q1ZUWE44KzhpK3Ix?=
 =?utf-8?B?dzJaYnBpcGZDZVc4amYyRVZXWnppM1dHempYZzAwZTQvUTdHT2xiNHh5Z000?=
 =?utf-8?B?b0hxZHhKUTdrNERzRVRJay9FMVE2eUppenFkNWFtbCtHZnBlV3dRdTBmWHZW?=
 =?utf-8?B?Kzl1Q2ZmWkFnaWJ2Umg5U2p2T0Evdm1zWnFlbnVuR1Boc2lOVlJrb3hudkhs?=
 =?utf-8?B?SzZQcktPRmxMdWlYd0FGbXNCVDIxc0gwZHA4UkJrNjk0TzViRWJKTDBrSU5k?=
 =?utf-8?B?RDFzOUNnNWpVdmxiK29Zd3dSamFKWm1BZHRVQVF1aWVVSFhwMmpBRlRCSFJr?=
 =?utf-8?B?bHlxTlNLRnRoZVowY240MVJuSVo1bHBoaytQMXEvRkxrYVFoZWtjYk5EQVdO?=
 =?utf-8?B?NFlaQzR6bVF1aUp5R3FEVnRoQ2V1aDl1b1Z1MVlPeG1RTlRJNUdNZm9CbkVl?=
 =?utf-8?B?QUtrd1ZhcUJKa1VDZ0I1bDBrSmdHWnFuZWYvT0FORkZMUngrcFF6U2tCcUt5?=
 =?utf-8?B?bGxkajZyNGNHM0xMaDZhajhoaWlNRjlNSXAySU5RUlN4RFFaNjh4b0FGcGV6?=
 =?utf-8?B?VWdFaFFkdS85UGc1UUp3djVVL0lMMEVvVHBJTXdpeE1rWHRxajJrVmhCVUlJ?=
 =?utf-8?B?YVl0eG1ZYXJPSnpDdXZXTnp3MzR5eEJyMjdIVXMyckdldU42OVlNT0FOV2pz?=
 =?utf-8?B?T2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9f210b-c454-4677-c9d3-08dd1862aa28
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 15:03:40.0697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9FVZtXYsJaHW8Hu9ku/E98FdrRrnxKgogtJKUnsUejKES/Onkzqtytvk0LPABNNttCHAzG7Fv44GrFSPzp/ZI2Jwm7xu8SQpt+2PfGYmMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10485
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 09 Dec 2024 15:03:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/872

Hi Oleksii,

On 12/7/24 4:31 PM, Oleksii Kurochko via lists.yoctoproject.org wrote:
> [You don't often get email from oleksii.kurochko=gmail.com@lists.yoctoproject.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> During the fetch process, the following issue occurs:
>   Unable to find revision fdadd93817f124fd0ea6ef251d4a1068b7feceba in branch
>   even from upstream
> 
> This issue arises because the tag next-20240904 and the commit hash
> fdadd93817f124fd0ea6ef251d4a1068b7feceba do not exist. This can be verified
> by running the following commands in
> <yocto>/build/tmp/work-shared/radxa-zero-3e/kernel-source:
>    $ git tag | grep next-20240904
>    $ git branch --contains fdadd93817f124fd0ea6ef251d4a1068b7feceba
>      error: no such commit fdadd93817f124fd0ea6ef251d4a1068b7feceba
> 
> The head commit of v6.11-rc6 is:
>    $ git rev-list -n 1 v6.11-rc6
>      431c1646e1f86b949fa3685efc50b660a364c2b6
> 
> Update the SRCREV to the head commit corresponding to the hash of v6.11-rc6.
> 
> Fixes: 7f91ebf5c17ce ("linux-torvalds-next: bump to next-20240904")
> Signed-off-by: Oleksii Kurochko <oleksii.kurochko@gmail.com>
> ---
>   recipes-kernel/linux/linux-torvalds-next_git.bb | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-kernel/linux/linux-torvalds-next_git.bb b/recipes-kernel/linux/linux-torvalds-next_git.bb
> index b961b14..34bb9d7 100644
> --- a/recipes-kernel/linux/linux-torvalds-next_git.bb
> +++ b/recipes-kernel/linux/linux-torvalds-next_git.bb
> @@ -18,7 +18,7 @@ SRC_URI = " \
>          file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta \
>          "
>   # this is tag 'next-20240904'

The comment needs updating now :)

> -SRCREV = "fdadd93817f124fd0ea6ef251d4a1068b7feceba"
> +SRCREV = "431c1646e1f86b949fa3685efc50b660a364c2b6"
> 

OK so I believe this is going to be a forever issue as it seems tags 
older than three months are removed from linux-next.git. I would 
recommend to just switch the kernel tree to 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git 
where the old next tags seem to still exist, c.f. 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git/commit/?h=next-20240904&id=fdadd93817f124fd0ea6ef251d4a1068b7feceba

Cheers,
Quentin

