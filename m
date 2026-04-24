Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78967FED3F1
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 16:45:44 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.8])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.26949.1777049134395891660
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Apr 2026 09:45:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=HCLQul77;
 spf=pass (domain: cherry.de, ip: 40.107.162.8, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R94g83JO6gm6Mtwos1xCMLXnCBPlziORv9MJ32Cq+DNTSiJK5d2d8Co7VaZVi5GYEL3cBKsoHA9ip5G/HjNc591eZ9AtyT4TQuFPoRHwag6QN9HVfbRcN6zVNLb1oHPQraKE6dJLtbtLK6o/ENB6P+UofXlSNjAGwwnyrWnrjSiUz7TDgwkx9rK6Pw1Yv9XetQHseVv8Hcty1+4v4wMcJckXYA2XFIMIjGSjtkRBNEGopLf+7Ufk3BFN3KtOoJC5JxXnfRjvLb5ya+bVq9ribSFlM4g7jWC4+60hv1P9y5wJR2aY9PLePkFsohe2vG+opUIsLf1SVfKbWTg9iYIjNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDTpQ41E6pJCJU8vbLpbuHv36Uyj6UBnsWqUiKqEP4g=;
 b=B7WubBYukvUE44YvHemT16Ag29gfQvEWL5Y5eoirEryFeAZI67q5mRNEegEeedgdCikGfx8hwUvLPkXBPHnpkVl4/IfGI68XsV8cQfor4PGtBwo4aSvF3txdE0cM+vy/PXJ3ktOUq1gDyg7bRPccx84ozNSNHIn6M1/z/leQg/KnmEnXUMyppE7tu+ENzUNNj2fi31RUrL+qovZG0Q3EviFd5AdvxUtbxTQ2sBEGMlrYccahMcboe8+q1DAssUgwDUOeIiSK8bAMt0Z43o26/H28t3fP45wGOrOhFOA/Z9CEkvC+Pgj89eLhfmpl9Uij0gjlxRMVChhrqb0c9q7bUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDTpQ41E6pJCJU8vbLpbuHv36Uyj6UBnsWqUiKqEP4g=;
 b=HCLQul77FK0zDTqzFNa8vdy0qhH2IvOCb/8VsSU38BZXtUlU71bcMbDGLRDbWaFoIdMKnc7NyhcK+LFQUPjXYZYrlXLcAZHWXEl2NixwkJKshlTheHOM7LLBYVeEf7D6dBDux73sP4ZZZMEd+7ux+D4oEMVKhyKvr98xP8b/tB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by PAXPR04MB8351.eurprd04.prod.outlook.com (2603:10a6:102:1c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 24 Apr
 2026 16:45:29 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%4]) with mapi id 15.20.9846.017; Fri, 24 Apr 2026
 16:45:29 +0000
Message-ID: <4f8aafff-585f-436a-a986-26d331b8687b@cherry.de>
Date: Fri, 24 Apr 2026 18:45:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip] Backport patches to Whinlatter
To: yocto-patches@lists.yoctoproject.org
CC: Trevor Woerner <twoerner@gmail.com>, Martin Herren <sputnik@on-the-web.ch>
References: <5bj70loXmt_k9cZvIDWvVux-3no88K7lhbMDcRw9jh3ylLLz-YDZhyOr6fM8PeXSnC88wg6wk34A9A3uz8ljvNTE_nEurXpatMj2VxFsw8c=@on-the-web.ch>
 <f458ad76-2eda-41f2-b6a5-1f6bba342752@cherry.de>
 <D_T0vfLiZ7iT-Zdru_yLBe3ZScLI_weV-fDDAFnDD4aJybbieGUfMXTEA-X5vakiZbsQeTAZ3DjRdyJRCZjM2FxdcR1WwxO4rk1cUUCTg7w=@on-the-web.ch>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <D_T0vfLiZ7iT-Zdru_yLBe3ZScLI_weV-fDDAFnDD4aJybbieGUfMXTEA-X5vakiZbsQeTAZ3DjRdyJRCZjM2FxdcR1WwxO4rk1cUUCTg7w=@on-the-web.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::9) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|PAXPR04MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: d86503b0-e382-4942-5a64-08dea220e4c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	wQLn3EsfZa8JAls6N0b8J4uaWO6s/t0RQ7TU/iiAqFB/Oclf5XotLns9GEqHFw5Jn6n4wjMfrFdvxtTlciaAH9y9cbvGvFHAy85dGGPjzueMfO1jtMd+qFwQFQxK1fEDuehlxSNbwm5TJthg1I3GYGH908WIThSVu5cMp/7tn6aE2MElBQMt/gI0QVAApaytTskT8zLTArsTOfMkWg3rt3y8UfefpoaCBOHHPhpMyt9oBnQQbB5KQiBMS2rEcOavLDrEmbqk0dKxv9+w+NoSQ7L2mlVUshgeTXbE6CMhs/xadpmSPcoXxHYie4Q7ZJX7JMvdJUMScFzqegw+/RlDX6IwtY0Q8Uu1wH8BXw28hBL6j5j23efr6iuPjlTgQoUL0NbmYd500419YjuZmRSZpo6bZx7dC6nyuieY6szJdszKoVJeHq7+WqkhmPDzCtQqYZK1ZgoPQgdMZ5G3NdHI2rUMrBtZcgK/pgfiyvjkWUaHu8tw1jY8twYp28i15HZiHovL3ikniayp178T/6b+fzWvGYgBbf4RUH9ExxcC3XM6nUJmBUW2FcZSQcqNBx4XUT6R8wqDltKFtoE+TQIxMaoiEHFEqwTFPXnPSEng0mm3nZvzPjjX9Y20KcniRAALikmiC5HAQ7Rlv2HXLN5nv90a03B6RHV3Xlf2UoeNQppZsgOcnbMx4G3U3QUcA4jYFEV3YSSqASZ/bFt3G1IvPeDbqA/WvxYcSEHU7ltiJxI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7737.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ii6OrCQTQhqYiO7hshKolv0ezmEdUbx0TKrX7OFLRdQfRI4Wxv+YN+DPFHhz?=
 =?us-ascii?Q?OB04GVa9iB5Ik32IxGTBeBXejEgD+I6JLZT9QdDCJbWZEQVdBY/cua/5mh6q?=
 =?us-ascii?Q?PQoPpiOkDTulKY1wB78zDHC4zSPlVRJygxF21bCOb1XdHok2yxs09NF9Nbil?=
 =?us-ascii?Q?n2tD/vs+sSW/qkALY0hF+UzFohPBGdBjtNnSaTO6MziiFOY1Q2tbz1KDM+jo?=
 =?us-ascii?Q?wLCZHRJ/px0U6aPxmdE6C8nBlsovw/ljzsmBwPksm9Jg2uopt+YOrzJJNJb0?=
 =?us-ascii?Q?dASF+PigRK/llEZ69k/77KzhTWwxluIxSGyuu5Vo6DJshpO2gx2SwXv0B+Sb?=
 =?us-ascii?Q?CuKUY6YXjHn5yCHNhjWQGap9iA3zIm8PkCnXZahXQSZTyhVKZBx0oWkhQ7Q3?=
 =?us-ascii?Q?6z1YdgPrz9VGDB9WRQsexUBlU/1zz/hlONhT9jG6gft++nUpFLCF7Ll4RqD1?=
 =?us-ascii?Q?vNBW4pTR5wSV9NzCEy7YiXsSeSVtrur+xP4N5kj6mjzTZk88mQtYT4SNMPIl?=
 =?us-ascii?Q?w/k03K7tlhcau6f5IZ+yM2qkBcG/5a869ImnI5UcjPyJZJStz7EEbeCrD72J?=
 =?us-ascii?Q?KXCjCWuDHhvl8wXs8SZWnGI6rvgi8qQbM+GtcBfeMN2FmOQUB+rcaT0E/EIW?=
 =?us-ascii?Q?driGfsq9VlvrFDgwc+EANIe3TJJ9narR9xZGCQxywf+uI7pwdsVM/leSNPHJ?=
 =?us-ascii?Q?dyawBx7rmrlqcB0IiSWM8jeHNbluVkvpKMMtkD/bMm/a0KPWIlmlXaiJv0uL?=
 =?us-ascii?Q?CEWEys4/UTqZYuU0O74OIRrIttplGfDGVV6BCU2yn9JqT0bT2oIPNQGbf/j1?=
 =?us-ascii?Q?ysDdK6uoYhPk7UhnpRQhmkspMkGtyF92e3PROnq1rx7UoOnstFSx7uANczWG?=
 =?us-ascii?Q?5jqBozoqeHXJd529KvftUEEURZHihV2BZzO3HPn56KxUQEDJZwDCPEqhIyga?=
 =?us-ascii?Q?ONjclS3m0FZNlIuIQTDqKQnlENzIjzFKzCHAEdWVWTwtqgUuTsf2C0U9qKRg?=
 =?us-ascii?Q?uiRmxI9ka3VmYjfP4MDpkOWttoYwvA6B50yQZU4bR37wRsFi8SimPQ0hiuLx?=
 =?us-ascii?Q?OXHWrHVTgUrcvOQouePcn/jR6IHHlhlIjSxOoAVHSyNdWFcuK4auXV4jXOEA?=
 =?us-ascii?Q?ErLhGii4GtUNfQDOL9F1NdVaxXzT47V36apuwFp7OJ21V0As3QFOfHDLomOT?=
 =?us-ascii?Q?7vfY+d7KNnmmDhW29r00g57E760PAMxoSANd+BK2u93d/wtPGDs8U4M9u8dQ?=
 =?us-ascii?Q?0n9YleZroJ6heeAjweCg0FBy3gAFGiLko67ieAMty3kieE28H2oHWNc5VsEm?=
 =?us-ascii?Q?CIoGejPVCj10uK4kVh6lRk0Pjo3jp/sHcYByVQwT+0hNwjETD+tbtZ4kHhr+?=
 =?us-ascii?Q?CYAFgHe//L5PIW8i/Yc/iArh7ACX9/9Cfjv8/iRbk3wc4gIZUv0vTEsrR66n?=
 =?us-ascii?Q?3tcW4GHfkSiNVpBhByUBygxOHgl2HK2Nq0POeOVjoLA2wR71o42poKT2hB09?=
 =?us-ascii?Q?fTbHzDEVXS7oGXlElg7LMA2t+68/SUb6gL34l9RA6P04z7PN1LL+/50HR2zw?=
 =?us-ascii?Q?e1W+umOdYEgsvUv81NSIV+mICVXwSLwxAigdC8VLfvreQ1VS3scPOcowbAyA?=
 =?us-ascii?Q?Uy55lv3QDCGcSxPENazZWQIXEezHFqP6W01FSHc8NIp8qkOCw0H9sqez4Xz4?=
 =?us-ascii?Q?90VXi4iLoHrJsDtbzgLYRbDMlgssr4lXkPfEXjTUomiFv9Drz9J2RQrvT9ha?=
 =?us-ascii?Q?uyAm0+9pHYMp61m8OkjnDTKX7D5f96Q42QYvNoU56EkFl6DKH5Jv?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d86503b0-e382-4942-5a64-08dea220e4c4
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 16:45:29.5199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJV/wkTmD/Q3kzibeNzq8fnme/8663kbMGbA8vkS8iUNDGyIFB6u2AysgiuRLL0SKSA3qUCdFxnQ9xdh9HG3bQeDsKob35/obkoTsXIAoWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8351
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 16:45:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3805

Hi Martin,

On 4/20/26 7:27 PM, Martin Herren via lists.yoctoproject.org wrote:
> Hej,
>=20
>> Hi Martin, Trevor,
>>
>=20
>> On 4/20/26 12:14 PM, Martin Herren wrote:
>>> Dear maintainers,
>>>
>>> May I suggest the following 2 patches from meta-rockchip master to be b=
ack ported to the Whinlatter branch ?
>>>
>>> fitimage rework: fe7cfa748bb132cfbe322c1c6d586f09557dbeb2
>>>
>>
>=20
>> This one is tricky. We shouldn't break existing users but this is a
>> patch that isn't backward compatible as we would require users to set
>> the RK_KERNEL_FITIMAGE variable to match the modifications they made to
>> KERNEL_IMAGETYPE/KERNEL_CLASSES in their own machine configuration file
>> based on the SoC machine include file. Can you tell us more about what
>> is broken before this is backported? Maybe there's another way to
>> implement a fix without breaking backward compatibility.
>=20
> Doing a `bitbake core-image-base` for `MACHINE =3D "rock-5b"` on current =
whinlatter (including all other layers also on whinlatter) without this pat=
ch leads to:
>=20
> ```
> =E2=9D=AF bitbake core-image-base
> Loading cache: 100% |####################################################=
###########################################################################=
########################| Time: 0:00:00
> Loaded 0 entries from dependency cache.
> ERROR: ParseError at /home/martin/dev/yocto/rockchip/layers/openembedded-=
core/meta/classes-recipe/kernel.bbclass:188: Could not inherit file classes=
/kernel-fitimage.bbclass| ETA:  0:00:17
> ERROR: Parsing halted due to errors, see error messages above
>=20
> Summary: There were 2 ERROR messages, returning a non-zero exit code.
> ```
>=20

OK. So... The issue is that we don't know what third-party layers do.=20
They may very well include rk3588s.inc or extend rock-5b.conf and modify=20
KERNEL_CLASSES and KERNEL_IMAGETYPE to not use fitImage. I couldn't=20
think of a way to not break them. The issue being that KERNEL_CLASSES=20
cannot contain kernel-fitimage so we cannot check for its presence, and=20
KERNEL_IMAGETYPE cannot contain fitImage anymore as well, so we also=20
cannot check for its presence. Do you have an idea maybe?

I'm tempted to say "wait for wrynose" which now should be 2-3 weeks=20
away. The fact that nobody complained about this issue before is either=20
because nobody uses the whinlatter branch (I don't for example) or=20
because they already adapted their third-party layer to accommodate. The=20
former isn't an issue, the latter is (well, wrt backporting this commit).

I haven't tested but I'm suspecting you could use the content of=20
conf/machine/include/rockchip-fitimage.inc and add it to your layer in=20
your machine conf file after the other includes. Replace ?=3D with =3D,=20
replace the +=3D with an =3D. Adapt in that same file the UBOOT_EXTLINUX_*=
=20
variables to use the value as if KERNEL_IMAGETYPE was set to fitImage=20
(and use =3D instead of ?=3D). From a cursory look, that may be enough.

> Applying this patch goes further:
>=20
> ```
> ERROR: rockchip-rkbin-tf-a-git-r0 do_unpack: Recipes that set S =3D "${WO=
RKDIR}/git" or S =3D "${UNPACKDIR}/git" should remove that assignment, as S=
 set by bitbake.conf in oe-core now works.
> ERROR: Logfile of failure stored in: /home/martin/dev/yocto/rockchip/laye=
rs/build/tmp/work/rock_5b-oe-linux/rockchip-rkbin-tf-a/git/temp/log.do_unpa=
ck.34439
> ERROR: Task (/home/martin/dev/yocto/rockchip/layers/meta-rockchip/recipes=
-bsp/rkbin/rockchip-rkbin-tf-a_git.bb:do_unpack) failed with exit code '1'
> ERROR: rockchip-rkbin-ddr-git-r0 do_unpack: Recipes that set S =3D "${WOR=
KDIR}/git" or S =3D "${UNPACKDIR}/git" should remove that assignment, as S =
set by bitbake.conf in oe-core now works.
> ERROR: Logfile of failure stored in: /home/martin/dev/yocto/rockchip/laye=
rs/build/tmp/work/rock_5b-oe-linux/rockchip-rkbin-ddr/git/temp/log.do_unpac=
k.34438
> ERROR: Task (/home/martin/dev/yocto/rockchip/layers/meta-rockchip/recipes=
-bsp/rkbin/rockchip-rkbin-ddr_git.bb:do_unpack) failed with exit code '1'
> ```
>=20
> Thus the 2nd suggested backport.
>=20

We would also need 61505560d494 ("bsp: rkbin-native: fix build since=20
${WORKDIR} isn't allowed in S anymore") for completeness.

Cheers,
Quentin

