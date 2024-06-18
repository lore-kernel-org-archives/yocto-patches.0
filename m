Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9417C27C4F
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 13:26:03 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.132])
 by mx.groups.io with SMTP id smtpd.web10.86547.1718717161780269980
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 18 Jun 2024 06:26:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=JANSnFtq;
 spf=pass (domain: cherry.de, ip: 40.107.7.132, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3hNH/QhImK8zomMWwQixHyio05lYzAmGTZ6rbRWXhgzc0J5+Nh/uhiKm+mB3UHK4qwqHfEBIQDFMs2oZbeq1sXgNbN2vjsAjEsDKDK5UsHZDtxYnrlvWjFfiObm5LXcfWY535R/LH6xALTTItO2hxg62TQ7fYDgJkCkaQYz9W3oYfB9lArLGYMZ0f2SU74hIOvLxn8C4FyJuMYjF8cMow0/lH1m5OaqAaAMWjNBBne0LrfIwIBRw70M0wlgYleZbbrO27yNDvCVwfB5aROC/E+lxVbJHIzYfe+vcIIewvo3+QrUAxlAz9H1PLEtEJBEqQ/IAF5jO/nTHqOqDWcRXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zIf7tjXsKoenkCbgaSUwbBipLv3qzEfLNSE6NFSdcw=;
 b=ko05icH1q+pXkl/Xmsi/aNHKtv8WD3FvzLqYom/JwvLmpPb6x6RFmnlPiBZMUbpNNA7PJKQOvkOp2xx7FZ0YUzcYBfp/UvuI19tqdVI8Z0DjOUhHYqH3QtJ7aEXXYsLn+n7v4rnBQGQ5iJYmhgbQWmQOL3S2PSqqWpOD2YBIMlh5/9ZKyNopTCkxJcZQ0btRXg26YSimU9YeosnsOJVJqy0EaLiXUPRrS2MzP2WVRinHxsakCqHp0NRu7+pKFGKZTj+bIgD8HOwwha52Cw89XJ/zt4PycCTVkkz7lD7k2uiOc/neC/4ZMGQdDrYo2MR8KkhIifPz27nL/O2cQEvVVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zIf7tjXsKoenkCbgaSUwbBipLv3qzEfLNSE6NFSdcw=;
 b=JANSnFtq72FtJdQubdBDkSpDUSZXYQCJkZ5yN61Xh8c7qDD1rFjr6xb3/aTrzUxDH2LjWp2XV6HaR3jye/ytDC82megmITrVEw7/QBM8nANG1aKgfKIjTSvrfxMayVMf18hJpESFcKyR1RGp30K40wvDkom1rOkOkwFp5x2vdRk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by AS8PR04MB8280.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 13:25:57 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 13:25:57 +0000
Message-ID: <cc5225da-06ef-4717-89f7-a16b1bedbca4@cherry.de>
Date: Tue, 18 Jun 2024 15:25:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] linux-torvalds-next: use
 AUTOREV
To: yocto-patches@lists.yoctoproject.org
References: <20240617230735.13593-1-twoerner@gmail.com>
 <fb7d421b-9db5-461c-b89d-05cb9c5016ee@cherry.de>
 <20240618120822.GA40144@localhost>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240618120822.GA40144@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: WA0P291CA0011.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::23) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|AS8PR04MB8280:EE_
X-MS-Office365-Filtering-Correlation-Id: 6408f9e3-2712-403e-10f5-08dc8f9a2fc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eG1XdUxSTWwwUmxvYkFneWJpYjAyQXJMS1psMW1aaWE5cGVJaXgzZmI1dGVw?=
 =?utf-8?B?L3BrdThhTDZUYlpWVUQ5Wk1hR0lKYzlCY0VCN2luYWlocHl6cVBuUUd1M2xx?=
 =?utf-8?B?aWlzdkpvUEU2NVRQQW9uYWxHYUVhanRtSjVCQ1RWRlg0MmtVVERpYkZZWVVt?=
 =?utf-8?B?MjlOTkFNSmU2OE01dzJWNXVZYTRaR2p5NVAxOVpLN250cEdQeXJpcEdydlZx?=
 =?utf-8?B?K0ZkSHJnaktLeGFWK1hCa0JvV1Z5QVZwUUxiNWw0NEt0UHEwc3JaTnVPSlNh?=
 =?utf-8?B?ZURuNmx0Tloxd1dYMUhRSXl1M3h5OUJuckZvMDJjaEFRanpJVTl6VXJyVVdq?=
 =?utf-8?B?Y25nVFpLNG9xT21mM2ZuZm5nUFliT0JGSWpVcENoK1NvVFN2VGR3UGJpQk4z?=
 =?utf-8?B?NEJDYUtUL1B1K1p2cW5qUVIzV2ZycXRyZkNyY1ZwUDlhd0JEcUx1RFljTXBH?=
 =?utf-8?B?Y3BBWkwyQ0tpSlRwcExvZVM4T2NsaldZcnNKcUYwZEJjdDQ2MUYyc2pLdmoz?=
 =?utf-8?B?bU1GSmh4UTZjclJ4YTRlOHJtaG1Fa0NVZmE0d2tUdkNXZ1hLUGlzUHllSXV1?=
 =?utf-8?B?S0NpNVZYeXQ0MERVNkRlazVqQzUvNzZFVVRrNHJUTUtWNnVNUWd0OUxaTE5z?=
 =?utf-8?B?dzNmdHZ5SmFDc3V0dlM3OCtNakdIcGdENTZpelVtZ2lGZWVxZUlrS1g1Zmho?=
 =?utf-8?B?bmtHL0lYNnkvMDJ4QVFraXdmclpHYm51aFpRSzh1M2RrcDR4NllwUm0wd0ZD?=
 =?utf-8?B?czBVK1RnWENISEh1UTRqNnVrMnVtYlFLMVlCSi9GV2ZqVDBYc0NsZFIyT0xr?=
 =?utf-8?B?VVAzUzkrbGtwRzUwR2lvTVgzY3I4N3JXSXdFVy9IZWhMMURNeHB2Q3ZMcWpt?=
 =?utf-8?B?RDZVMnhYUFZqaXEwSXFCSzBVWVZKd3gzVndzalN3WUVZakxqbys5akZCWEVj?=
 =?utf-8?B?enYyTVB1UHFxQ0xmeEZ3a0FueVpGc2lOa2d2Q0V5enRMamM2WkFQazViTktm?=
 =?utf-8?B?YWpZTnVnejBNeHVEVlQxN09Oamx2QXNUOGRDQThhcmMxSUU4TnE2NzRIL3FM?=
 =?utf-8?B?bUg5R1RpUFkvWVFCSlJtREpWRklPWEp0T2pXS0ZzM3BqUzVlMHczR2NTUHhv?=
 =?utf-8?B?S081UGs5Nm1RdWIrNWlQNmxFbUJ1REh2OTl2cXZNYzMvbVFRWkplR3UvVjQz?=
 =?utf-8?B?cTRrS2JTYk50bFFMaGltd29MbVJSSFROMDI0VUhuVTM1b1VoU3FkRUg4S2t6?=
 =?utf-8?B?NWxxbVdWWmRscWZqYnA3Y0FXSWdPOTYwSFI5L3M1RGhDTkFuNnAzNThhWmh3?=
 =?utf-8?B?bFNBK1pOT1VCaFQ4Ri8ycUE5bThKN214bStrdENSOHJqSVlUZXdOR2I5bXJI?=
 =?utf-8?B?SXN2N0hZVFcwbEVNZGIwNTdDQTQwYytEb1V0TnNtTHlBdVdyWkc5ZnRXeFU0?=
 =?utf-8?B?VGxpOG5TQ2xReWh5b3I1QkxVeDBqTGdKODdSMTF3b2UrUWNMVFV4aTNzanhz?=
 =?utf-8?B?dWFvZkRWQjZuVENBeERnVDlMY1RtSWZZRS9Zczc5VWszV1FNVWxxQnMwbmRQ?=
 =?utf-8?B?UXZIdE1QcytCVTJWelBheW5kNkYwM0RRUmNCOC9sSm9QUkc0VEtBSXYyVWkx?=
 =?utf-8?B?eUR3L0YvcHRSRnZyMEJlbnpvYkJyUDllbHp2TURtRXQyQWhEN3hGQmF6eTFL?=
 =?utf-8?Q?BAajdUoyrxFWl3CV6UjQ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dDFXclVlWk9qRUJ4UnJhQnpBTE5YdmhnUHlROGp3eE1LYXpJUXhWS1F6a1BO?=
 =?utf-8?B?TUlreXgzRERHNjBlMDh0UWlIdzloVlBWdjhsYjZKOXVFSHdTK2IwLzY1M2Fr?=
 =?utf-8?B?Q1I4SHpnWThuZXlOYUR6ZzhoS1BDTTA2cmh2WjViQi9KUDBLUnl2cENnL0Jh?=
 =?utf-8?B?VGU5dVRlcE9QYVpxRzhTemcyeWloQjdJeVMzZmg5WkVPREh5enJZRVE1em5T?=
 =?utf-8?B?azdhOTNYekptS3RsQWtVVVFvYWlncjVnSlNKZGZ6TDYvdE5sYkttMGFTeDRS?=
 =?utf-8?B?TzBBOVFjTHMzT0hqenJwWVh6WXU3cDBNbVJHS0NjWkMyc0ZweU5SSjJiWjVD?=
 =?utf-8?B?b3ZFQzlCZ2xocWhlZUN0cWc4dU1YVXIyWVhEdzZEYjhuOXk2a2VWOVpnWlJB?=
 =?utf-8?B?eUJsVnlXTzMydkFIbGxwekpkbWQxdksrdmpSWGhhV0tSdW9ibUxjK3AxamJY?=
 =?utf-8?B?N1VOZHc3a3Q4TGNNYUZJMFBvWElxVTZTZ3NUdlBkUjFVcURTTHpvL2pnaUNZ?=
 =?utf-8?B?elFmRTgrSlpIcTQ2TnIxVGtYbUJtcWd0clBUV01OdGJ0T2FxOG9mZEZYNmFw?=
 =?utf-8?B?VVlQRFRRTkw2ZzdhRUVJckNqR0pyU0NCeVhTZmJZTDh0TWJVV2VqOFEzaWgw?=
 =?utf-8?B?SlJYcklYZ2ZSbFV4ZEZnVzE0bnRuYnJlK011NzBqd2FEYjhKWWtFR3dHZm1a?=
 =?utf-8?B?bC9NVWttdmc2bU9vWjNCcnZUQ0RzYmY2MkFWaXlGSkhWUEMrdWtVb2dNd0pP?=
 =?utf-8?B?UDJtODBodjU0Ymcwcml0RzBXSVY4QUJIS3dKbGorMGs1WlhaeFVoektqVWhK?=
 =?utf-8?B?U3lucHhxZ0VKb1V6ME1HTnN4QmJQT21sNzdycGR5T3pGT1VNVjBpZE8wcGdK?=
 =?utf-8?B?Sk1TdzJkM2l3Rzl4Zjd4VVJLbm1zdWF1R3Z6eUhIeS94VGhYOVhpeUZXS0hr?=
 =?utf-8?B?eUdvd1hJVENnZXByeTRRVHdpNG0wTzkxZkJxQ2lLVjQ1NUlYK05XakxDejBN?=
 =?utf-8?B?T2J6d2tYd2xGU0cwWGlTc3hMREVsbmltVGV6WGhjUEQrdnBWeXFkd0ZBczFK?=
 =?utf-8?B?eUNoWW10WS9sNHdUekdUbm5kQXdtNk84OHJXMDZZYmJMWlptNzlOeDQva2xn?=
 =?utf-8?B?a2tMYUpqYXk2OGVLS3JVdmg1ZnBBM3djeEhvUDYwWVBFQ3lOMWF3dERWa1Yy?=
 =?utf-8?B?K3c2Y0NFOUZ0andTaVJKNEN5RjJyTVJ6TWh2UTR6WGxSSmsvcWQrdEpnL3E5?=
 =?utf-8?B?dW9NZlZQalBiQzhKczREMDBvai9HbDhLbS9MbWh6a3d5czR5MmdoTkQ0Ymw0?=
 =?utf-8?B?cHJ3UXhhMmRLZWwzQWdvMGxOTzM1VG9FKzNiTEw5S0tKSXJvZi9FNm1iV2Rw?=
 =?utf-8?B?cUlqZHY0d2xMbXRnQm9WTTdyWTI3UTBwRm1vY3hlMmNJWHdqMWQwVGllWlV0?=
 =?utf-8?B?NE95cHE4ckhyQ0RwcHV1Z0h5b2Y4YlNUZENOV0tkdCs2QUVHQUx6VGp1WG41?=
 =?utf-8?B?QXRqOUZDZjZ4Rm9ud1cyWUFNMldNT0xnWXlTSlBIRnMwUDFSblB4T0dXa1NO?=
 =?utf-8?B?RkFmSko2WXVsQTF1amNjVGZRWmRmbUZiUWRkcHNBL1FPSWhGeFVpem9vSW12?=
 =?utf-8?B?Q1ZGZW9IWjdVcDdmOUxZNndNYU43VDdSdjFoUGxIMEl2SmFMQktGS1Y3Sm5z?=
 =?utf-8?B?WWZyeElCZDhKaHhUWFVTZXByaWhYMjZEd1JkTEgwNmxKbEdhU2FQMUV5Tm45?=
 =?utf-8?B?ZDI0WVFLRFp1cWxmekszRDMyTGlKT2pPRjVaVDJ4T3NIVmpQL0lpbWszc1Ri?=
 =?utf-8?B?UmE5cm96bjhnbnpndVFCQjVBUlRqL2NwV1hmOHBGWVRMTEI5WGRqcGJBclBu?=
 =?utf-8?B?aU4vNEl6QkZEblR5aE1ialNkQWYxcFd0a0M5UXFoZVU1a2poNFdrcWdGZnE2?=
 =?utf-8?B?d1NMR25LejVVZzdhcnk5VWwzVUU3akRQTnZsa0pmbkgybi9QSk1pT0RPSTNi?=
 =?utf-8?B?NUhZUC8wWmlLVkdVTExWWmVzcDI1MW1pQ1hNTGlnVVh3ZVo1SjJ0bTEwWjI0?=
 =?utf-8?B?MTZ5cFZEQTdsZ1FoTWxTYVYrdXgyVmZ4b0Q4MEgvZ2NRcDFIaUxSK1d2cGZw?=
 =?utf-8?B?RTY3TkV0RkdyZmlIV0pFOENJSXZWS2c4WkFRZ2FPL3h6cjQ4aFg2eUlzaDVk?=
 =?utf-8?B?ZXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6408f9e3-2712-403e-10f5-08dc8f9a2fc9
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 13:25:57.0522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENpzotrseQdt2sXv3a49bmcwirDFeOO6/CpyNCYd7cm5BjdXyjLXq7uxl7VgqYzbUjxJV+TkVk/77gn59VfV7eNWQb9XUBcqml9MMmHXVsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8280
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 18 Jun 2024 13:26:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/341

Hi Trevor,

On 6/18/24 2:08 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> On Tue 2024-06-18 @ 12:04:48 PM, Quentin Schulz via lists.yoctoproject.org wrote:
>> Hi Trevor,
>>
>> On 6/18/24 1:07 AM, Trevor Woerner via lists.yoctoproject.org wrote:
>>> Already the SRCREV that was used for -next has been rebased out of existence.
>>
>> Mmmm, no. It's still there, just not in the master branch.
>>
>>> Also that tag that was originally proposed no longer exists. With a repository
>>
>> It still exists. https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?h=next-20240611
> 
> Yesterday at noon my time I cloned the linux-next repository on a machine I
> had never done this build on and that tag and commit ID were not there, and
> this is still true:
> 
> 	$ git tag

This lists your local tags only.

You want to use:

git ls-remote --tags 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

instead I believe.

I just did that AND a clone locally, and both show me the tag AND the 
commit exists.

This... is odd. Maybe worth contacting the IT of the Linux Foundation to 
figure out if there's some inconsistencies between mirrors used for load 
balancing or performance (closer to your place) somehow? Or something 
else, this doesn't smell good that stuff is "disappearing".

> 	...
> 	next-20230310
> 	next-20230314
> 	next-20230315
> 	next-20230316
> 	next-20230317
> 	next-20230829
> 	next-20240613
> 	v2.6.11
> 	v2.6.11-tree
> 	v2.6.12
> 	v2.6.12-rc2
> 	...
> 
> 	$ git show a957267fa7e9159d3d2ee1421359ebf228570c68
> 	fatal: bad object a957267fa7e9159d3d2ee1421359ebf228570c68
> 
> 	$ git pull
> 	...
> 
> 	$ git tag
> 	...
> 	next-20230829
> 	next-20240613
> 	next-20240617
> 	v2.6.11
> 	v2.6.11-tree
> 	v2.6.12
> 	v2.6.12-rc2
> 	...
> 
> 	$ git show a957267fa7e9159d3d2ee1421359ebf228570c68
> 	fatal: bad object a957267fa7e9159d3d2ee1421359ebf228570c68
> 
>>> that is rebased so regularly, the only thing we can safely use to hope for
>>> valid builds that don't need to be tweaked every few days is AUTOREV.
>>>
>>
>> Or... use ;tag=next-20240611 in the git fetcher and force people to use the
>> network for radxa-zero-e boards.
>>
>> I personally would vote for using the tag instead of AUTOREV. Kernel
>> maintainers rarely (have they ever done it?) move tags around so that should
>> be fine. Whereas using AUTOREV on linux-next is basically hoping that
>> nothing breaks from a development branch, maybe too much to ask for right
>> now?
> 
> When I click on the commit of the link you provided earlier it says: "Notice:
> this object is not reachable from any branch". If the tag is not accessible
> from any branch then I can't specify a branch to the fetcher. If I don't

I was under the impression that a branch may not be needed if a tag is 
passed, but that is probably incorrect. From the docs, it seems we would 
need to pass nobranch=1 in addition to ;tag. I'm not sure why this would 
be required though, the tag should be enough no?

> specify the branch to the fetcher then I get flooded with "...you didn't
> specify a branch, and we're going to make this mandatory soon..." messages,
> flooded!
> 

This may be a false positive if passing a tag without a branch to the 
git fetcher works.

> I also got an email from someone yesterday who had tried the radxa-zero-3w
> build and it failed for them. When I do the builds on my machine that I've
> been using for development, the build succeeds (because the repository
> predates the assumed rebasing). If I then go to the ${DL_DIR}/git2/ directory
> and delete the linux-next repository, then retry the build, it fails.
> 
> When I try the build on a machine that has never done this build, it fails.
> 
> I started my change yesterday by using the "tag=next-20240611" addition to the
> fetcher and was surprised when the build failed on a different build machine.
> 
> I think AUTOREV is that safest bet here.
> 

Up to you. I still think contacting the LF IT makes sense, at least so 
they know something odd's happening somewhere (maybe not on their side 
but still).

Cheers,
Quentin

