Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF819D6DDED
	for <webhook@archiver.kernel.org>; Fri, 15 Nov 2024 10:03:01 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.55])
 by mx.groups.io with SMTP id smtpd.web11.17510.1731664973480527440
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 15 Nov 2024 02:02:54 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=FoKcaNMc;
 spf=pass (domain: cherry.de, ip: 40.107.20.55, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXBIIgqLefpaysFArrn1tFHZqWzofz35f7Ay9KHUIGnzr/gT4rlKZaEak8axK2lEF4RWr8ttFRsUWe0jUwnVd8Uu6HN9K7QPvhHHwDgA0JQE5+eNIZZnWrxrVVYkAPPUlXz1OC6zbHr+d7xkOf9IB8BhDA4maGcUq0xnzcs6O1nZ9LQ6qodPqXsLLT6QP2oPeN2FlEu0AWBIJ011eDvxiCqJBVF4bz68sVwNv/mCt0QDHBWNfAMbmTOPR9UV2joIgbohXt+ePAr1Ya0m7iCSEppeHwQomuXJ2dUaH4M54tkOObJNOXEJJRDcSvHCvEOlC3h+IFociIPuM75ogIGdoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3K5Bd+i6gfnzfznK3u1bOeRrPMHwq3OP7GFWoJQRRKk=;
 b=OmmWqIetE3h3i6pMr/GG6Gh9T7aus9KE9AHMViQLrgHMfM9upIIev5lyMAnD0ZTlEAHptUDBKZco9LbfJrokjBHs10gipbv0TLPCk/6ZdFS7lLKhhR0Z6Swp+yWTNsNXuqX+R/T7MtXtT2KiiHz5jXqJgAhv5xpC9z9xEYnSt9qYEHhWmOYE5teZVUIrILWz3OaBuQh8takPlKn3ggeWfi3sCXS/+Wdg94gHILRJocNy7UinsiHRLCtOCEqHawMcReGxeHCHNbSz+0KzIp/6PqSLmgSJdngh5vLoqaFFC714RRHmXA5VKJlDtLb13GyJJ3t/M8/O/PmiWZ5XAv+IfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3K5Bd+i6gfnzfznK3u1bOeRrPMHwq3OP7GFWoJQRRKk=;
 b=FoKcaNMc8ft6KwLd1UrAx/4/khNLp9Hd3m0T9GV2dvyCh7/qk9RZDpXXxiunrtbm6WEl8IdtZKqMUPnoloPgJfE2qRU3RssO4V/fDNXkGUulmr3INAx2pnD+474y70XpIUlpcDNW66MrDfwKR7+vIV1+hyhs0wxoB01/gZs8Oh8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 10:02:49 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 10:02:49 +0000
Message-ID: <fea52645-c3ff-4eb8-80b3-9e95a9002b70@cherry.de>
Date: Fri, 15 Nov 2024 11:02:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH] SOQuartz: add
To: yocto-patches@lists.yoctoproject.org
References: <2f52ba6e-4709-4b66-b23d-838cbf8d9d3e@trifork.com>
 <2664ede8-d88f-446f-9419-6372fda41361@cherry.de>
 <bee5d935-5f5b-4347-90c0-15462e58c4ae@trifork.com>
 <5db30b32-f058-42c9-bde9-418c6a7b6625@cherry.de>
 <527C5D48-F150-40FC-AECF-8B84DBA9EFAA@arm.com>
 <0459b34d-b27e-41ef-a866-8114fe87a2cc@trifork.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <0459b34d-b27e-41ef-a866-8114fe87a2cc@trifork.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: c2850862-8245-4780-2e24-08dd055ca905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?K1cgA5VS8Er2Ab1R3sIotKjclkIf4+k3gCvA9DQKXCmP+DgGNwjQSUhrohbf?=
 =?us-ascii?Q?y56ZIiFK5sEiwG/MCRZml9BE6BvzyrBEDUYxY61ZLiMKuSDFOMmvh+QjmtDQ?=
 =?us-ascii?Q?H9zh0BCI8a7EdZrzOPmmoyjASSxNLHRrzrd3295ls1n2tRAPnLHCJCb1oNQW?=
 =?us-ascii?Q?dSOf4o4PYyRu8vBqZzCdUYbzZXzICHyVRUVxP5hYmJBsninSJMY+HrUxeugU?=
 =?us-ascii?Q?EfyMkq/FYqONMnPOJaK9LU9xAFAmuSqsDyNNdvLrc7gIn7hZRExceQ6MXk/S?=
 =?us-ascii?Q?LBM7FmFpnsQTyR/Zm6m3/8+m5gINO+mA9Lb0K2UL74K8tzn4ibrjKhXjwJG5?=
 =?us-ascii?Q?Aj7WE69Bn1FEvT9eJ4Cqf7vu2S9QJAtY3r0JQhjvJzZgzTzBebGonH7NZeby?=
 =?us-ascii?Q?K7Hmmr17Whq7YdxmufGwEquUAJy011R7KplvbmV8AEtFWQeDXrr6SY8MiM2w?=
 =?us-ascii?Q?3FoCeTqD50BvuyoOP0crXSrGnlhtsVsFDJuXmJk4i20HnC8FjtFRxQ013VKI?=
 =?us-ascii?Q?UQcMDZdXDR3RW0tMrb/DMvCitZxlB9JDigAudW3Fw33P8++HzdOKojkL8kuZ?=
 =?us-ascii?Q?RaQ8LJgs+TjLWH0RfJ75B+MDZIhsJ/4wEW8z22t5A90WzUEyVbULFHkNSlRC?=
 =?us-ascii?Q?uUOmfqg9CkF5qN3sKxl2C9xB3bVMBCkwFzGUhVe69miKdbWpvwyfqdvoMVtk?=
 =?us-ascii?Q?GiEXa+r4NNCCi5r/B5EoMudDNsIBbR0+6quPbEeJtq7zWNYoKd9YpoG3//wM?=
 =?us-ascii?Q?THzj6ePhtJRirYm9C7pYBPG7T4HcR/4ZwCblYm8yVc8f0ErBNYOruk8WUDwL?=
 =?us-ascii?Q?/sKMcObv6dOdROBRC0BZbwaChmNM55d1HcgVazW7dDACzIzVL5WIE9xAUWMt?=
 =?us-ascii?Q?GutWF7b3nnwPr1w0N/fK/kUMZxSnhcsy+UvFedWyUlP+qSSkfxoRI8x+MRP8?=
 =?us-ascii?Q?z6fE0aIr199ErBgK0AKyh0ebJMvtIzpdMixQhaylLDT3zy7nlm578GlwxHoI?=
 =?us-ascii?Q?RYJ/Q3Hb9QhbOFaEQtoJUjr2Y+Q32APwb+A2gI/9JKaIAa5CNdl73yuMMJyQ?=
 =?us-ascii?Q?IzyWRbUXCTz2XPupGhXsy+QxlDHb0uT4P0Mjtnv/47FEaACokEjY3sJXSKLX?=
 =?us-ascii?Q?OSEHGg0iywSXLpAbNVDZOx4B5bLWGPcHzRssfFiAqfzmuRlhCj/h8AAp2LMR?=
 =?us-ascii?Q?250k2xV9OT4hrzMrv7HReKlPqC0T7v7gZg++RzER4aE7IR5tPrgIRGR70UTg?=
 =?us-ascii?Q?JRLLsiODckdLaFE5R4I7?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?E86RRHMxvq4ImildzsnRiDXlwOlb34FtUc+ClyO9Lh1v/4EGp8qMayLJbK0k?=
 =?us-ascii?Q?6RJ03Hl5KP8hzRZCCUkAL5ATPdF8lfm8dJimMOtzd7ZwGe7RdDpb7reLutNA?=
 =?us-ascii?Q?Hhyp10DCToDfdgSVe4mxov/y83cPdKzyCL2j+Bkdo8Yq/LGfyCcPBZRCoChi?=
 =?us-ascii?Q?EIPmSA7kBchIJkfBTJUlYH2L58tulF3gK/1FaBom9DWjp+F38iMOXlYswGbS?=
 =?us-ascii?Q?LbNI2fNGRsKKu7eEcuTVkL2fbSUXBTw1buoKZQVaL8socZoqZwDUB2sxWtzA?=
 =?us-ascii?Q?VkF1NDzaWFkrwqN29O3efCGSHAikq7EgS8fEyOYGmHPRYl7ODZVMC7X7NBb6?=
 =?us-ascii?Q?uStSOo2N80FOairMzq4zN+eO1H4+uyPOpm4KVk26IeRPFig7iTUmg2yonNVz?=
 =?us-ascii?Q?4y/JJooymX2Qgk3drJARba/KdmEt+hWEPlxy8gzB4NMr8V2E1ip0R6L8+JFK?=
 =?us-ascii?Q?R/rN3/crIPn2oNeXrpCHKkBFUDMdUVzzWPxEPktYhDjW7Qrrs1lEedTfibA3?=
 =?us-ascii?Q?zCrGag+0aT2myfeM/ML+0lXE3J1FEiUs2Jb0V9fFv38bUeseyQjsZJkSseXX?=
 =?us-ascii?Q?qsDBlPJhCQk3a5Ry+GWSOwKAzUCmT4jtU9vnmU4dNNhZKCEU0zr+NiUWNqAf?=
 =?us-ascii?Q?72qZzUTokxGNGg5Ub/d5Gtxo4eOzrlFQcJsg1lgI/Gr2N0PDLU55VLqu2LOX?=
 =?us-ascii?Q?LMADMdLoK5g5fBNuFI2TBOFMA2TJWpKWGUdWAgoeBVTXJjjlFLYTS5JT1nX7?=
 =?us-ascii?Q?ZUODMZgEzU1AnkI6VF2gvq/MRk8X2vbmHabc4G5XnUTbc4XmSy2z4Y35Oe1v?=
 =?us-ascii?Q?MC5BYunJRIIcOZGCb7vyQ1NJGbdWhy8/4lG4ZRGjuQaz2ynUKN4bTYI3hyN2?=
 =?us-ascii?Q?4mRN7Ta0buCq9CjeJNt6H98hCd4vnSY/5epvCAXPL00C5zumO+dxW0Ge2ch0?=
 =?us-ascii?Q?QMloDZz41PuTbs4SimgQNw50uSoRvBR1w50IV8xUj4aMbh7aVusLflCWrAf4?=
 =?us-ascii?Q?+5SbYOwNFPTyqEFfOET13khBbbC05dWg/jx6flkJEThHjaLQWUYCPkdx2aqL?=
 =?us-ascii?Q?QqV67R5UFHDgzElQEYdSLp6UkJmZLwrw//+U2f0B/c4Pt+Z6i7b92wELImoG?=
 =?us-ascii?Q?/JlkHGq41Yb6w5b0FIq/ATOAIaa+esi1c436Lu7ThWTVOOGx7y6cQK1UxJ5q?=
 =?us-ascii?Q?EwbpOxhk6RT6Xpawfy3wsowWRwBkZpTwy5aK9ukoF0WrFzhckT7SMxlnduv1?=
 =?us-ascii?Q?PuRrrbd+u3uRTDag7kqm64d5M3fOlG7UtOMYWfqQK2LygULzMO44QsYNL5Yk?=
 =?us-ascii?Q?TZvSW120cuS6GzIR//JTp08HttUvYplDF8I1lmxznWuv9KuK45xZQhqmi/UL?=
 =?us-ascii?Q?ME5CDcjVisOFZ5iSogwIRoCIgDV2+cKoIyzFzy7+XZKDc9TSPTpTN8AaKSS2?=
 =?us-ascii?Q?QP5qZBEMVGBI+lkRAID/U8RSXbBbcZ73rwzxvbkxRJ6iU9qws2slJRDdzJaI?=
 =?us-ascii?Q?W+wEJc6eh0xcV7XkohV7bWhpiZwhPWt2dQSF4PPTf+b1pJnh9K4nh+MldswY?=
 =?us-ascii?Q?fqUXVNVATTFEgQ+scBre3SC+WZFJfsvySM8UW2KN5clbMN9+sy2yC9xnNpwH?=
 =?us-ascii?Q?LQ=3D=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c2850862-8245-4780-2e24-08dd055ca905
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 10:02:48.9577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFhFYrE2gf/0j0vMjsCdKnwndjP8iVMFCUkpCGa6wBkm4OhyZc13ut1+DmDsAhI9EVOtqEAW8XsSdMgWSWjqsARPUFMzUKAWl+x+XriBzIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8254
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 15 Nov 2024 10:03:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/804

Hi Paul,

Please send the new patch as a separate mail (v2 here) so people who=20
aren't directly included in the discussion can follow and know which=20
diff is the latest and greatest :) Since I'm going to make feedback for=20
a v3, please do that for the v3 whenever it's ready, thanks! Let us know=20
if you need help with that.

On 11/14/24 3:15 PM, Paul M. Bendixen via lists.yoctoproject.org wrote:
> [You don't often get email from pbe=3Dtrifork.com@lists.yoctoproject.org.=
 Learn why this is important at https://aka.ms/LearnAboutSenderIdentificati=
on ]
>=20
> On 13.11.2024 11.40, Ross Burton via lists.yoctoproject.org wrote:
>> On 13 Nov 2024, at 10:08, Quentin Schulz via lists.yoctoproject.org <que=
ntin.schulz=3Dcherry.de@lists.yoctoproject.org> wrote:
>>> The thing is... I'm not entirely sure it makes sense to have a SOQuartz=
 SoM machine config file.
>>>
>>> My company sells modules with one baseboard. Considering that most peop=
le building their own baseboard won't upstream it, they will need different=
 kernel and U-Boot recipes, with different configs and DTBs which is essent=
ially the whole content of the machine configuration file.
>> FWIW, I agree that there=E2=80=99s no real point in having a _machine co=
nfiguration_ for a SoM.  A common .inc file (and potentially, a machine ove=
rride) so that it=E2=80=99s trivial to write a machine makes more sense.
>=20
> Ok, I've tried to incorporate the feedback into the following, this
> could possibly serve as a starting point for someone else,
> but otherwise it could also just be dropped.
>=20
> I've moved the SOQuartz to an .inc file and added the model-a baseboard
> as a machine
>=20
>> Ross
>> IMPORTANT NOTICE: The contents of this email and any attachments are con=
fidential and may also be privileged. If you are not the intended recipient=
, please notify the sender immediately and do not disclose the contents to =
any other person, use it for any purpose, or store or copy the information =
in any medium. Thank you.
>>
>>
>>
>>
>>
> ----
>=20
> The SOQuartz is a RK3566 based compute module and parts of Quartz64 serie=
s
> The Model-A base board is one possible board that supports it
>=20
> Website:
>       https://pine64.org/devices/soquartz/
> Wiki:
>       https://wiki.pine64.org/wiki/SOQuartz
>=20
> Specs:
> - Rockchip RK3566 Quad-core ARM Cortex-A55@1.8GHz
> - Mali-G52 2EE Bifrost GPU@800MHz
> - Raspberry Pi 4 CM form factor
> - RAM Memory Variants: 2GB, 4GB, 8GB LPDDR4.
> - optional eMMC from 8GB to 128GB
> - optional 128Mb SPI Flash
> - 10/100/1000Mbps Ethernet
> - WiFi 802.11 b/g/n/ac with Bluetooth 5.0
>=20
> Exposed preripherals:
> - 1x HDMI
> - 2x DSI
> - 1x eDP
> - 1x LVDS
> - 1x CSI 4-line
> - 1x Ethernet
> - 1x USB 2.0 OTG
> - 1x SD
> - 1x PCIe 1-line
> - 28x GPIO
>=20
> Model-A baseboard:
> - 1x microSD - bootable
> - 1x HDMI Port
> - 2x USB A 2.0 Host
> - 1x USB C 2.0 Host
> - 1x 5 pin USB expansion
> - 1x Ethernet w. PoE
> - 1x 40 pole Pi2 compatible GPIO
> - 1x MiPi-CSI 2 lanes
> - 1x MiPi-CSI 4 lanes
> - 1x MiPi-DSI 2 lanes
> - 1x MiPi-DSI 4 lanes
> - 1x PCIe open ended
>=20
> Signed-off-by: Paul M. B. Bendixen <pbe@trifork.com>
> ---
>    README                                      |=C2=A0 1 +
>    conf/machine/include/soquartz.inc           | 14 ++++++++++++++
>    conf/machine/soquartz-model-a.conf          | 12 ++++++++++++
>    recipes-kernel/linux/linux-yocto_%.bbappend |=C2=A0 1 +
>    4 files changed, 28 insertions(+)
>    create mode 100644 conf/machine/include/soquartz.inc
>    create mode 100644 conf/machine/soquartz-model-a.conf
>=20
> diff --git a/README b/README
> index 09f8691..85ab2ec 100644
> --- a/README
> +++ b/README
> @@ -45,6 +45,7 @@ Status of supported boards:
>                rock-pi-e
>                rock-pi-s
>                rock64
> +            soquartz (on model A base board)
>=20
>        builds:
>            32-bit:
> diff --git a/conf/machine/include/soquartz.inc
> b/conf/machine/include/soquartz.inc
> new file mode 100644
> index 0000000..bb6f3fc
> --- /dev/null
> +++ b/conf/machine/include/soquartz.inc
> @@ -0,0 +1,14 @@
> +#Copyright (C) Trifork A/S 2024
> +# Released under the MIT license (see COPYING.MIT for the terms)
> +
> +# Common override for basing a SOQuartz design on
> +
> +MACHINEOVERRIDES =3D. "soquartz:"
> +
> +require conf/machine/include/rk3566.inc
> +
> +
> +UBOOT_MACHINE ?=3D "soquartz-cm4-rk3566_defconfig"
> +KERNEL_DEVICETREE ?=3D "rockchip/rk3566-soquartz-cm4.dtb"
> +

The two lines above don't make sense for a SoM so please don't define=20
them. You may want to add them as comment and explain that to add=20
support for a new baseboard, typically setting only those two variables=20
would be necessary.

> +MACHINE_EXTRA_RRECOMMENDS +=3D "kernel-modules"
> diff --git a/conf/machine/soquartz-model-a.conf
> b/conf/machine/soquartz-model-a.conf
> new file mode 100644
> index 0000000..0b2802c
> --- /dev/null
> +++ b/conf/machine/soquartz-model-a.conf
> @@ -0,0 +1,12 @@
> +#Copyright (C) Trifork A/S 2024
> +# Released under the MIT license (see COPYING.MIT for the terms)
> +
> +#@TYPE: Machine
> +#@NAME: SOQuartz on Model A base board
> +#@DESCRIPTION: SOQuartz is a series of Compute Module by Pine64, the
> Model-A baseboard provides standard connectors for the compute module
> +#https://https://wiki.pine64.org/wiki/SOQuartz

I think one "https://" should be enough :)

I would here post the link to the Modell-A baseboard section, e.g.
https://wiki.pine64.org/wiki/SOQuartz#SOQuartz_Model-A_Baseboard_Features

and move https://wiki.pine64.org/wiki/SOQuartz link to the SoM's .inc?

Looks good to me otherwise!

Cheers,
Quentin

