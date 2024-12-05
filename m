Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8719E77170
	for <webhook@archiver.kernel.org>; Thu,  5 Dec 2024 17:21:44 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.87])
 by mx.groups.io with SMTP id smtpd.web11.17238.1733419298684157632
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 05 Dec 2024 09:21:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=LVnmSkBB;
 spf=pass (domain: cherry.de, ip: 40.107.22.87, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPwSnN+/smGK4MfvHbKLQ7bmTdrxv/rfWlJZjli8zJk5IMXG1Yy3BFwkkFbAWcIeJ2F6l3Vvpf77ihdbg7aLs1kdwVaDzmOq60z9NajMym2HNZi6ZDP5548uxsEaimbthHxWwn3zg7u7l92Fjn/CzWz18qOa77hPAG7jDbz+aXoZL+M44PmTiruZwmELnHx3IIIJ7N6scSiR7x1UOHv+/buupt8Yg68S4J7uZG1SbuqVyqJUtoHexA1eC8s+JRhOBSHenNsRF9FurTUDiN25zMWxdN7F6HrRiIjC5jvbcER6/s+BBgV0U5xbnmG1/aSqPaSZUPp1+O5V1jEX9pU4iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVhkc9RirxD6uufNxfaxUbL8Rw6TX9660hMePsx7Hj4=;
 b=lMUuApDWlco/JcWS51fCpzhdnZV5Yo460MnPKF4iSqWqVsee7KqwzLg5Zv1OBWgvf/AQuwKYPGQJOsxRQlshPRPpd14lpRyjGSYfMtPDTuubF4l5QKmVbXJ4sx2FmbBHUmWa7wCqwJHjIT77XGD9DHlS2xSuRMtvX8fP8It1vU7e6fzdl+5i6T8oI8IAs9qGqKAvxDDR9uXQrS7wAseXcSqsAlyi+WPW+epX4X/k63m3zmseqIMCfn5fzwBtCJPxZdLgicM6jx3Wh+bhYY+gz5E1LFx7rgrbziVH+9zRcZZr1iVTgIms+vAsdric4FSVmdPaznXJKN9zLX6bWwGfVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVhkc9RirxD6uufNxfaxUbL8Rw6TX9660hMePsx7Hj4=;
 b=LVnmSkBB34xpn73qoEuLcuUhj/sCLNIjh0MxuRwGg+1dqSAOAvApS/HIfH1PjfB2xbITxdknNWNYLWgqy70DP0AWg2zrBZCVFjVZfgoeaocIfEPcUr7TNXowuhi1nC/RYXHA1KRApYGBKyTinCBBYAngVY/9LBeCzsRparrY7KE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM8PR04MB7810.eurprd04.prod.outlook.com (2603:10a6:20b:237::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 17:21:34 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 17:21:31 +0000
Message-ID: <828fb7e7-fa5c-479c-a452-0c1e5d7d13ee@cherry.de>
Date: Thu, 5 Dec 2024 18:21:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip PATCH v2 0/2] bsp: rkbin: bump to
 latest commit in master
To: Trevor Woerner <twoerner@gmail.com>, yocto-patches@lists.yoctoproject.org
References: <20241128-rkbin-bump-v2-0-a194385aad7a@cherry.de>
 <20241205170956.GA13285@localhost>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241205170956.GA13285@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::11) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM8PR04MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: c049bdc9-4d7e-493c-27c0-08dd1551428a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?R2Mxbk1Jd3lWN2loRGFZd09COThKZE0vT1hBbU5Jem1NY0F5MlhHVlBwYS9x?=
 =?utf-8?B?LzE1QlE1ZEt1bGRhVDRNRi8wVGtSYXBEYU42bmtBRXJnRnNXaHdaVlFPUWFr?=
 =?utf-8?B?Q1JhdzFaZ2Erbkd0M05wcGVpUlBhWVNWSHdweVF1dDQzaUZPN1VBdUtVczhH?=
 =?utf-8?B?NzFwWnRPUUdWQ21JdTJvZVB4NGFIRGV3QTFQanluL3I3ZFF1VW5yb1lnbnov?=
 =?utf-8?B?cTQ4R2VmSWpVK0t1b29WV3RvMVp0Zjhheno3UEFkWlJJMzlEM2JzckllTkIy?=
 =?utf-8?B?UWdSc2RyUExmZURQa2poeVZ6Wnc0bjJtU05xQ29XVGh4eHk0NWU1d09ZTzdB?=
 =?utf-8?B?Y0hwd0lXNzFiQmZDbEltQy9IQVhkSVpyelVHNXkvcHRMak1lY3pidEdOdTBi?=
 =?utf-8?B?SHJKb3FZdzc0a2VsMHZ0bnVOcGZSTlloaGVwTXZORkdEN2RuNllrT3pBZUZP?=
 =?utf-8?B?OXhGdFIyYVAyN1UxcGhOeGV3cFU1QVRCZHdBRVRnWnBYajNuVkV2ZjMwUVJn?=
 =?utf-8?B?VFkrQkg2SFFWY3NrZitDR01oenhvM2cyUE5lTlBtMEJLUXNmMGk4Z29sbk5L?=
 =?utf-8?B?OGFYVUIyazZxN2lNWXMvcGpmSmxtSklhWFhpS0xBcTJmblhmQml5NEN1Z0xE?=
 =?utf-8?B?aTA1Y1ZicStRWkNSSmk0MWtRZENhSGlyMmlrUXlQZUduVGZtN1d0YW5QVzFv?=
 =?utf-8?B?NGZwWXlWYWF0NWZYMHVFUmdKS2VTK3FMQkdJY2JPV3pBQnBxdUFrMkhVQjIx?=
 =?utf-8?B?TlErQklNUVJOdHg5ZTdzRFp4SkxQcGxnVG9CNFhMRnBvd09va1Y0cEFKVGdP?=
 =?utf-8?B?ajJraWZqa0N6NXJzMmZObW8rOE1jdzhIQ204ZzF4WGxtbndwZHV4dnJkN2Rz?=
 =?utf-8?B?aDJKWUtFbmEwdVM0T3RjaDFuM2E3eVhBa0VwM1BwbDczMTQyT1hXb0tjdDc4?=
 =?utf-8?B?ckdWSWh5YVRjdlpOQ3NOSGJaMFpQV0d6QkhNaWptdkpTWm82Y0FWTHd0ejZX?=
 =?utf-8?B?WlpWSXhscjhkd2lnUjBQSHFaSEljVXhyR00xbFA2Vk1YbXZKZ0Q4cUhjcC8r?=
 =?utf-8?B?aVlYUENITVJhS0VVclhGT2laK2lvdW9BVU1LR0crKzRBSVlNK1pZRGFmOHdN?=
 =?utf-8?B?SGNKdzFNUk1vZkJUbE85QVpsdVU2M3BYUU5ZRHFtcWI5UklRUFNMOUNoNkZC?=
 =?utf-8?B?cnVwUG5QeU1yNnM3V2hFQUpyajU4WVMyeS9acTBxaEtvS1J5V1JZMld4ZFN2?=
 =?utf-8?B?R3MySGRUeG5TN25TM2Z2YytKQnpDUFJ0MUY2SFJpMG1HV3g1Qi9qMlJERmdn?=
 =?utf-8?B?bytkVHU3TnZEYXg1RlJsYkh1NFBET25hTnJCNGJjSFJxNU5WSHlraWkwa2c0?=
 =?utf-8?B?L3hpWGJ6aWJuaVVBMTQ4QnVLOFJyTHI4Kys1U0l6N3VDRVphVlFUaThRMlpP?=
 =?utf-8?B?RVBLV2h5bXRmczNoejhjNnpIdkVNUklJYzVubVk5YVp4TGhUcDVTNkZ4Rkp5?=
 =?utf-8?B?QnBlZTNkVDBFV0NvZ2t6S2xhdDF4cVVEcndaSHdOZ0lObW8wYi83ZWdnbHlr?=
 =?utf-8?B?UldYUFpBYkJxV2xDYXBkUFp4OXFLeE5KaSt0WnI2WWZHRlBtOUx0VFZyTHNO?=
 =?utf-8?B?ZlZYMUFzS1ZnT1daQTZ1OWFMMlBvcEdBUDhDT1hEaTVVY1JBcFZncXRjUU5S?=
 =?utf-8?B?VndvaWpjNVZMNStXOVpIcE8zSG5aMGhybEpjK1gxYkxqV0YrclB5S3V3QytC?=
 =?utf-8?B?NjJLZ2dFUWhsMEt0d25Edit4UlowTzBoOC80MDVvKys1dHY0NjJmTDRwQ0hJ?=
 =?utf-8?B?VXg4UkQ4SW1KbExQZE9pZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NDBrVjh5VXBGeDJRK0VHb0VvZEs3bXZsaklDRHllZHVybUUwRktseUpkVTlX?=
 =?utf-8?B?d1R0L1FqK0xvOFhSbC83Z0ZRZnVUYWZONDEzM0VlM3FOMGk3bVZzSmkyU0ho?=
 =?utf-8?B?K1plUmNsK2pnZjZFTGduYVFVYyswOUllQnlVYlptdnQ1b1BoQ3NpUG9IVk9m?=
 =?utf-8?B?cEx2aTUyKzluUDVMc2NDYkgvNm5PWmtYa0ZUcndNMUpPQ1pJMERaL3dwK3FB?=
 =?utf-8?B?enZ4azI1UjkxUk9MOW1ENzc5cTU4WXZWWEtyejN4TCt5ZnRSWUs5blJDcW9V?=
 =?utf-8?B?ZERSeHpvRDg2dnN3aU5DYkd6OS9nKzJwZVZjdFJyNk5nUmdmclhFSVk3cU41?=
 =?utf-8?B?WmJwb0hkdlM4NjJMYVdWR1ZQMkZ4emJDdzdDaUx6OU5KUEJZdGsrTFlQV0Vh?=
 =?utf-8?B?bmJGcVVqR0hYRnllN21nNlExR0NPd1pmaStBOG5NUHBVL2crbE5YdnB0Ujl2?=
 =?utf-8?B?NGFEU1ZlV2c0b2VHNjR1Yzd1QXpja0Y3RzFVY3NCN0hlTVhQOUJyYkhlQVZv?=
 =?utf-8?B?QWQvN1NjcXRlaW5tT1E5UVdCK1prZDZzZlZCN0ppdk9PczJ1L2dlODlOVHdI?=
 =?utf-8?B?a0ZMNWh1NDdRUDZ1T28xM0dEWndUenRnRFk2M2Uvb1R3Ky9SdTJlVWFVUEdE?=
 =?utf-8?B?MWlWTEtGcFF6OFEwY3haNVFDY1FZUzhmMTNZcEFRLzN3ejREbjlmTUMyL1Vy?=
 =?utf-8?B?c0o5TjNQbFBIWTB3YmMycElMejRJdHc2ci8zQnpJN01Zb0xKb0U5azQxeENS?=
 =?utf-8?B?eEU5aEkxU3hQYVZIemN6cXhPamt0czdrV0ZtUlNtZld5ZXFzeVNDNnJ5c0lB?=
 =?utf-8?B?VHFNYVFjNk1jRXAxbTltS2JyTWJtUHRmQ1VSdElCVlNxcVl1U1VHMmhFRVFJ?=
 =?utf-8?B?MzliaEFNMFBKTHJLV1ZZbXVsUy9aVUdRWVU4MFY3UWF2bHhERTZTamthN0JN?=
 =?utf-8?B?VzdQeU9yRHNzblcxUndOamRrcEc1RkJQSGc4N2srSXVKei9ac3ovMVVTMnFI?=
 =?utf-8?B?OGllMWFwNlltVkYyOGZsYjRyWXdVbEhLUnZvWi9lOXJOMmdnUEw4bitjN3Nr?=
 =?utf-8?B?V0tnOUVuZ2crcWNiYkpaaTI3QTdtdmpBSHJxek5rRG1HTVYwOTAvNC96NGtn?=
 =?utf-8?B?MXFOWEd1L2FUaGhNK3ZaditJY2JhOW84ajNySE5iZE5lYnNMUkJEV3dZMEhp?=
 =?utf-8?B?MWNjM3h1VWYwcXdMMHg5SXAzU0VSSVJpMENYQS9xeDdFNWJBQlJDWFhROURM?=
 =?utf-8?B?cWRwSUpYM2h3bUVSdThUc2wwSGZnbGQrUzRQTTRTUjV5M3lIZmNHS2ZEdHFY?=
 =?utf-8?B?ZjdCK2Y0U1p0Zzloc205cWcyRXhLSjE5RFVvRVFtZXZDTXV0WXpwczlxMkZJ?=
 =?utf-8?B?ZUZrUDB0ZnU4RE9UUGh1Slo0cHBMYWlPNmpkc3NBNHJKdDVIM2FhY0g2TGl4?=
 =?utf-8?B?amlEWGhtSFhwZy9OZGREWG41TDBJMUtPOFJvTVI3SG1LRXp4NVJvalI5dGk3?=
 =?utf-8?B?a0hYNFJKQlYzWkV2bTRkcWZJSFNOWlBNbU5uT1VUdHAvNmxIcStIc3RvRGxq?=
 =?utf-8?B?Y0VRRFh1UWV2NVRxTTBDZll1Wkc4R0czMHpNZTZJaHUvazdraG9UdVZibHQy?=
 =?utf-8?B?RVlPT0ViQ1VvMzVna1ZiQlB4SWFtZkNqMXRwOXlIMlRUZXRHaWIvQUhNTWlW?=
 =?utf-8?B?bTNsb1VKZDV0anRpak12cjBWSGNPMllKQzZDZTNNZFhiQ2NKQUhmSzJVNGdz?=
 =?utf-8?B?SkV0Ui9DcHhadEhHdGlXVHFwYmpDcEZKcC9TdmQxWlpHVkNTSDAydkY2WC9F?=
 =?utf-8?B?WHdzcTdrckNyME1SbkxlV2ZzZUlsODhodHIyMVEybUpIL3M4bi9pVDRpMTN3?=
 =?utf-8?B?REZLWXkzV1ZXdWtPWWw3WlNucy9OQ3d5SGFmWFgySUtPdTRiakx3UUx2K0pF?=
 =?utf-8?B?SURTQnV5eXpKU2VYVElvK0FpREFVQm55MXFUeGV5eHIwS0hVV3d0eTZvWlFl?=
 =?utf-8?B?UFFuZkVrSllDcGlyNVhpN1QyT0tqajFpL0hqU3QxbXJHeit3cGhyTjZOT0hL?=
 =?utf-8?B?aTFyeENIclpMbndoYUord3pXYTQvWUIvS3BxK1Z2WTZ2TjNiZUxxK1hESUJ2?=
 =?utf-8?B?N2RhZThUWHIrSExydzJTL2ZrZXhjWlBSSWhnZnRJREpWYWhtb0MrQ0ZMRlU4?=
 =?utf-8?B?a3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c049bdc9-4d7e-493c-27c0-08dd1551428a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 17:21:31.0855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDCpP8oB1OZ/HDsX4zxKdO757G63FXXeAQRXOzw4rJfZIvePxhnWSWlizkbvsDCGTeLi+j0WpzEdGKdD/i8Tb3xj83OyDELUMtUMBGLHQz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7810
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 05 Dec 2024 17:21:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/863

Hi Trevor,

On 12/5/24 6:09 PM, Trevor Woerner wrote:
> On Thu 2024-11-28 @ 04:58:48 PM, Quentin Schulz via lists.yoctoproject.org wrote:
>> We've been hit by random RCU stalls, system hangs or resets on some (not
>> all) of our RK3588-based products running some old BL31/DDR init
>> binaries.
>>
>> Upgrading to latest commit in master branch seems to mitigate those
>> issues, so let's do that.
>>
>> Only build tested.
> 
> If I wanted to test on boards without having to yank the SDcard and re-image,
> I would only need to update the idbloader.img in /dev/disk/by-partlabel/ ?
> 

As far as I remember, idbloader.img only includes the DDR bin (DRAM 
init), u-boot.itb contains the BL31 (TF-A/ATF) and BL32 (OP-TEE OS) as 
well as U-Boot proper and scripts if you have some.

So depending on what you want to test, you may need to update both.

Cheers,
Quentin

