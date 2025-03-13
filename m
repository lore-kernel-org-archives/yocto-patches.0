Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFFCC282DE
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 09:33:39 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.67.44])
 by mx.groups.io with SMTP id smtpd.web11.10377.1741858413918094653
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Mar 2025 02:33:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=Hzx8EiNo;
 spf=pass (domain: cherry.de, ip: 52.101.67.44, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFswlIPU3xl4ivA8RmBY4wdcm0purvkdbabyKajEcSWuHM33VoKivI+etv8Oygt3uwcAqpsuaSUSSO1dFAuLhuKXcCma6Y8NBKIxopHLWsn3QS4QfB27XLHrM7OhH99DP6h6OprKLW4PBl9OpWNRRkf1OU77Ff3mzUI3oFmK8/i42eYc3pQtePXuTuTkXC8WZnOH+Cr0BsUmGyaFj28/X1B42tRsXa39Thzq7lwptQgNWluyQFs9BL0NZW9INsb4M6/VAzLv6F4UkoMmTLIozfayf59ReIRRe1RJc5ADV8kQHgn7925riXtfBizN/IAcVmGTJZaKHWDUvTqZ2zo8zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RLGg97I4QRt9DpRXTT4ndlMhiWu29S7GKmEi24Wa44=;
 b=dEXE58j87CzKjlycHQFvlObE1EuJ/ze8r1vHw3OqQ5n8zFvXIplqNqVNjM7X6IcsAg1LHybx61XzlGTY5z/z9cYAyP+wGaCp4Gg5nKbhVsXnBUu18zrK/M4mpT31bNmwEGzwzJMThTjMw782frD/Y0F34Ac/sINvZuPertdPqjcar4gpP1aAwN7rg60VOQQV0jrxgEqIFDj+5N0Fw6HgEXTO2fTJudnIQfFlAXm7AOQBUr66Pz/jbyqPr3oCyHu6Mm/7tIoxzx9iqr6GAQpSQS6RvaMIsF/VBOOWSodfqbpk8iTC8l5jagZOT4RbLpkg/e3bQFRpOQ6twDCmzqiLVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RLGg97I4QRt9DpRXTT4ndlMhiWu29S7GKmEi24Wa44=;
 b=Hzx8EiNoLeBR2dEAiTr5UzJapJkvDKqLhZHVYFEjHWKwvTHJ+xalHewfPrfxix1uWmJzD0Xdy+MiLXZ0/TIZNOTf+I2olwHCcV6/emNlX3LBgjVBU3NsWC1Q+ulYAySJDxLs8Agq4FFcYikTfuUzB+efO76hO0wxN/k0LiV8gTk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by GVXPR04MB9830.eurprd04.prod.outlook.com (2603:10a6:150:113::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 09:33:29 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 09:33:28 +0000
Message-ID: <a0071ede-5ea2-4900-938d-148e8d626d7c@cherry.de>
Date: Thu, 13 Mar 2025 10:33:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] Kernel and u-boot version selection in
 meta-rockchip
To: yocto-patches@lists.yoctoproject.org
CC: =?UTF-8?B?5YiY6Zm254S2?= <ltrsunny@gmail.com>
References: <CAGNQujsSc1TpF3ZpmoQKpa0cBeqTdnY3tpKFZh9udwaA0ZQomw@mail.gmail.com>
 <20250310154725.GA34977@localhost>
 <CAMKF1sps7Ui3SiER6Ck9S5FjYJfwi0UD3Jpp5hvPC8jRsceSqA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAMKF1sps7Ui3SiER6Ck9S5FjYJfwi0UD3Jpp5hvPC8jRsceSqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0400.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::20) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|GVXPR04MB9830:EE_
X-MS-Office365-Filtering-Correlation-Id: 96fd4d08-aaec-4926-cb1f-08dd62121ca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?CaFB+6hc3lP+iltRhyk7aTWIHzRHTn+TGK+BH4w+8ACM9Q4OP0dwss2IEbDQ?=
 =?us-ascii?Q?ds4zJL9vR5PCxhZOrlEQLi6EgEZ9NER9LzyJnLrGoHJo0eooChy5zxmMK+YW?=
 =?us-ascii?Q?Np9lIej7wT59Wz3fySudoUGXd5PUhPjiO0RTWcEN+dpj+AqVI0YBeRDp5SD1?=
 =?us-ascii?Q?Vy6DJxx4fYHJQJtXA1cQGqNGyfEMh4bNOVqyApqca+PUlDNPV5i92txVszSe?=
 =?us-ascii?Q?cGWj/Xy7CYynSIgUlXmsSx6UMgvUVcGm1dJe+zOjkScEop81IdtJ+UTM+xh0?=
 =?us-ascii?Q?Ql6Du5FX+OXTjeE6YgjryQavbit1/48bnlC27hFYJZjG7Qx/VDUO517KQtk4?=
 =?us-ascii?Q?4qlc6rZtt8DzoP1jJcsqJZM+cjAmJL5IFSPz7X81bbpMHeWZwO77U0UbG87p?=
 =?us-ascii?Q?MTQcn8bCR3bo0WRJCgGZRCbYOLeHvsnMPbqW05exWGShOO1HuFZZY/luirTT?=
 =?us-ascii?Q?ZWdFhaOgdm7JJ7CDJi6frUL9S2COUJ6DywWqhZQABMG3EcZC7cldpxZ+1nAs?=
 =?us-ascii?Q?CEqhi8OL9I94BKPqTVlEZnazU/ZpfvonP+eCzuWtZ3r47WwL1Ies/alyHeu7?=
 =?us-ascii?Q?KjHpyTDoQHCcWWIwVD/el3hfMORqPXMUuweq93Cm1a1Js0LPfCU2PdHtsG1D?=
 =?us-ascii?Q?zuivy/3uQ24XzuOe2Ytn+L2Pb8xEPqOg+Ft7PqLV56lYeIWKj6ePe6uANYvI?=
 =?us-ascii?Q?cGFS4ofhcXLn3DeW49BGz3nkBm1NoiGEBj+WIGwQaPVAYN3pg2EepttTc+4n?=
 =?us-ascii?Q?6GFZfYRspc6rghLDW44uKR8DuuoESmzH9NagBZFE1epLO62zhRPBg+yDVMC6?=
 =?us-ascii?Q?WPHMeFzWZEh2gygmQksKgtB95riGExthHcHk+/rjFjOlAyqb6WxPVe8Ceb4i?=
 =?us-ascii?Q?wx2XT+9skBAyqC8f7XiAfKak1EmZouGzv2rauNK43L2g1MzPDglYavUxxRGa?=
 =?us-ascii?Q?DyVJkF/iucnCO6QqYgUPXPWMCP1oARxosp5eURlVc0OvS1cYpJdhGmsUrTF9?=
 =?us-ascii?Q?EnoFrNVmDHWGFXmJ5EuklGiEJ/JJJxTFlfMlliYSNz8MIfEevexYOKbJq2U5?=
 =?us-ascii?Q?8Fpu60ApxoBszdMu5v8arayY4BbFjlUq3zGQNZisjIcpbe9jzDzicY2gnr8i?=
 =?us-ascii?Q?KbCfRY8yO9vJ1PQZ/qqD0ypAvEdGfqPvCZgFmvB3+7Cie4d2LmFtN3CIlfUe?=
 =?us-ascii?Q?G9vtKDX/vUEoR/K68Ah/NEgEmyU/pmGdocHYljeVFKRb/sOAgt2p7y9uEs8f?=
 =?us-ascii?Q?RFAgfQGD0vZjX+pd/E5QceSVxTTVWjhWvRR6kSW2CvWJ8UsCujOrTkGGQOlo?=
 =?us-ascii?Q?ZV4nHvlHUmkNuqOIVG8yTkRydiL6opjXqBHtFsrAphhRIg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8906.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hShuj0tPJtKBxQxlH3W59kI/5Cgf3eem9YnnFzkuxD8NjJFoxjr1NrfdQfXf?=
 =?us-ascii?Q?+jqVMj9Q2bpL96YtY5BXaiFnVTwFRcSVCvHXAbQSxMWxvxFUltgH2oIHTdHl?=
 =?us-ascii?Q?M/+JNhaRhFXYGdFNHaftnBQ2tXBsGK/dFeX/dWudKkKbBYB4q7khaS2A8A/z?=
 =?us-ascii?Q?UXf6X5kxSWRUOSLWMjFMXFtHXhPVc3mggw6mucKCKvBr5mTE/XAm6HhQpGu2?=
 =?us-ascii?Q?nFnVf+Mv0LX0W9w8oZa0/FZ1o2nEDZ1M4QrjzvaGZR0GV3MoAW/F3BeiOkPe?=
 =?us-ascii?Q?yG0mHjQ4EymmqPcRwiqxinDWeuqq+SCaJIXLqBvaZ80zaIHQr7hLQZRgSV7u?=
 =?us-ascii?Q?2AJeTEEPfVWkP92xQA3y2uV/NAHTrktSWb+QOlfMYCnRA0gdcHB/EMktqbvL?=
 =?us-ascii?Q?mZYncy/n5NJw03BcqIJnd6pwh1lav+wI535a3gRA5PJsn3uBNkwtp+HZ+el2?=
 =?us-ascii?Q?5pA5yUQFkhNgkUSZExGD17cHnvzOtJbrUqWp2ACe2OwWVtua3us4KcUF4YKm?=
 =?us-ascii?Q?RRNaugHujh6bBuU3U3z8n5d9qSkN+pKdpn6TEDPbPkrC6PAoMkxg2kCA9Tpi?=
 =?us-ascii?Q?KD2e1QHyort7vW9gmBbrXo/HxfkwvWJ4dCqYBeAHeP/6vgveUIGCsu2wWIn+?=
 =?us-ascii?Q?Y6REtz1/vjs0sBo1VVvbWhyp91KEL1P70maiu2B3YepBGLXWzQXZr9NDKDHm?=
 =?us-ascii?Q?8iUO7i+LPLai7KMR+AwnW4TdZTMvsGcf4f0dUVAWnTFN1PDHZSSYleHVm35E?=
 =?us-ascii?Q?ZE4CCSPH9rhD6i40zAYl7WekRwgKXdhlTFxOhPHC8Eg2UVARgM/MhHCTod/S?=
 =?us-ascii?Q?l0N9WcPvqcAERWrM+8fchfmfD3hxflMiivP+sA/vyZMHl4TXHUwLApy/whRV?=
 =?us-ascii?Q?fmE15FMFsxF+B5YAMEg6BnyNkKKTb+lIZpb/L8JYiDQe92Etbo5VvA7wnUVx?=
 =?us-ascii?Q?vaztEZ8I8xaMdEmJ3avU60KnZiSb9yztmvs9OjMYYVRI56F7ok4YdC/7SPPS?=
 =?us-ascii?Q?MjtGcNMGncDoVVaOQPVM+oJV3WaUNZKusEICYAQM++BMW2Frk8+jCnpI+t7q?=
 =?us-ascii?Q?YdyRoJORKrvy3xpTGmuBKRj26JvD5vLq8zH5e2Z9dio6WECr6a9JjdPEztZU?=
 =?us-ascii?Q?CtD57gFeTTLOS6cmoj5W2ceDvBE8jzqdgwP9xlaLnDUY7IxROePoJjoo4Yzb?=
 =?us-ascii?Q?Fu4rmwFguABDAyAmeO8Wo7QrzBWSQD9g9suiN30vhxn1lI/ZriUoAaOB51ik?=
 =?us-ascii?Q?jGzt3qEXsdxvDrdZvajtkij8s+2y0GwsubvNaGG8602ZKULFEQwAXqPjncWV?=
 =?us-ascii?Q?z/EmnIzE7bkE5YwbxJshiWgOPzFymRq70/W+APH6YM4vk2WEVhDNkyXNCD94?=
 =?us-ascii?Q?tn+X1QshgjJKYJKjZ8QkKI/ADSk0IdqHo+bGvDBX1WuWmMbCZRqIHNMgikLf?=
 =?us-ascii?Q?jEbdpdzdEKUN/78BdWplT23K0FYnMQPugAhc43lXoS4Z51M1Ceo3EdS9ymjz?=
 =?us-ascii?Q?kSqz+2+buLBmIyfiXHU5kawS3niEMX8ZTzWDoJJqlo3T1gOPY57CHzVFnhEQ?=
 =?us-ascii?Q?P786nRt1VpklhN2U+dm29Q2fUFgYK17AGIju/vHHA7EzYUr+gc7vRhASYlPJ?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 96fd4d08-aaec-4926-cb1f-08dd62121ca1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 09:33:28.7020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgRtoM+7iGTQ/LAei7fMsNKo74J7+wrNQtIa5FF/HEBts3YOgtKO+645fIwLiRMMCcV0rMbz5yUdyUUebQlN9vc9p+OsalDHKGGst5pEHcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9830
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Mar 2025 09:33:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1199

Hi Trevor, Khem,

On 3/10/25 11:07 PM, Khem Raj via lists.yoctoproject.org wrote:
> On Mon, Mar 10, 2025 at 8:47=E2=80=AFAM Trevor Woerner via
> lists.yoctoproject.org <twoerner=3Dgmail.com@lists.yoctoproject.org>
> wrote:
>>
>> Hi Taoran,
>>
>> On Mon 2025-03-10 @ 11:10:31 AM, =E5=88=98=E9=99=B6=E7=84=B6 wrote:
>>> Hi Trevor,
>>> I'm trying to build the scarthgap branch for meta-rockchip and got erro=
rs
>>> in kernel and u-boot.
>>> I noticed it is because of the receipts in the branch. Just like
>>> https://git.yoctoproject.org/meta-rockchip/tree/recipes-kernel/linux/li=
nux-torvalds-next_git.bb?h=3Dscarthgap
>>>
>>> it's using next-20240904 from linux-torvalds-next
>>> <https://git.yoctoproject.org/meta-rockchip/tree/recipes-kernel/linux/l=
inux-torvalds-next_git.bb?h=3Dscarthgap>,
>>> but the branches in this repository are expired very frequently.
>>>
>>> For the LTS version like scarthgap, when the version is frozen, it shou=
ld
>>> be set to stable(better to be LTS) versions of kernel and u-boot, isn't=
 it?
>>
>> Yes it should, and it does... when it can.
>>
>> Yocto scarthgap is based on linux-6.6.y. All of the machines in
>> meta-rockchip's scarthgap branch use oe-core's linux-yocto_6.6, except t=
he
>> radxa zero 3 machines and the orangepi-5-plus. The reason for this is be=
cause
>> linux-6.6.y does not support these devices.
>>
>> oe-core scarthgap also provides a linux-yocto-dev kernel based on linux-=
6.9.y.
>> This supports the orangepi-5-plus machine (so this machine uses that ker=
nel in
>> scarthgap) but linux-6.9.y still does not have support for the radxa zer=
o 3
>> devices.
>>
>> Yocto master currently supports linux-6.12.y with linux-yocto and linux-=
6.14.y
>> with linux-yocto-dev. linux-6.12.y supports both the radxa zero 3 device=
s and
>> the orangepi-5-plus (which reminds me, I should update those machines si=
nce
>> they're still using linux-yocto-dev).
>>
>> So I assume you're probably using scarthgap to build for a radxa zero 3
>> device since your comments are only true for that device. During the
>> time-frame of scarthgap I was eager to be able to build for the radxa ze=
ro 3
>> since I had one and wanted to use it for a project. So I had to pull in =
what
>> was (at that time) very experimental code to get it to work.
>=20
> I think it would be nice to mark which machines are stable/mature vs
> experimental
> at the time this could convey the message, as the releases are frozen
> in time this
> problem is bound to happen.
>=20
>>
>> I could back-port oe-core master's linux-yocto to scarthgap in order to
>> support the radxa zero 3 in a more stable way. But perhaps a better solu=
tion
>> would be to remove radxa zero 3 support from scarthgap and simply ask th=
at
>> master be used for this device.
>>
>> Thoughts?
>=20
> If you want to stay close to stable policies then yes, but BSP layers hav=
e taken
> kernel roadmap as it fits the given family of SOCs so I would not discour=
age you
> from considering backport if there is a need for it in the given BSP
> layer community.
>=20

Considering we also have a very custom U-Boot for that board, I would=20
simply recommend dropping support for it entirely from the scarthgap=20
branch? Haven't checked styhead, but maybe from that one as well?

Support for that board was added before we could use fully upstream=20
recipes, so I guess it's bound to happen again for other boards (e.g.=20
RK3576-based). Therefore I guess Khem's suggestion of listing the state=20
of support for boards would be nice indeed. Essentially, anything that=20
cannot use the upstream recipes (kernel, u-boot, ...) with the upstream=20
source code with a couple of patches should be deemed=20
"early/alpha/unstable support" and once upstream OE-Core has recipes=20
that can be used with the aforementioned limitation, list it in the=20
"supported" section or something like that. It'd probably be nice to say=20
what we mean by "supported", I don't know exactly what and how you are=20
testing so keeping people's expectations in check with the meta-rockchip=20
layer would be nice.

Cheers,
Quentin

