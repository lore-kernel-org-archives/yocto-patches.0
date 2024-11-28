Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F907D69112
	for <webhook@archiver.kernel.org>; Thu, 28 Nov 2024 14:00:28 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.80])
 by mx.groups.io with SMTP id smtpd.web11.95444.1732802422108157227
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 28 Nov 2024 06:00:24 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=FbHfOsA8;
 spf=pass (domain: cherry.de, ip: 40.107.103.80, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDACWUVbf/NBzb93FY7sEDwQF21QV9LiYoHgTvnCjghVDPrp/ochEe2kTEvYhLH78dREp45gPN08NEC9JcMxHHVPZnePjYMvD80ll17L2oz/YBVLFuwOEzemdHkEi9smp3yJXl0mU9eqoN3Ojb3c1gZ9sRtRVkJa4OW8trF9pR/8BuRB+wrD9wp9l2/sbkkDiEubopdeLsreVnGIbsRGkXnIHexXm0N1nmUuWgGp1GLnrRZAvTMBnKv1dbitSdnuSXZ8V3vvj+qkKXrxmblV4Ncizt1a1EgDM4eSR1A+omz1DBvNqCISNYzUsDx8Y7skikEyzrOmJlBNi7bihrDj9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmnOOBIDw1kzONVeeApc0UfSPedrmGZmu5/coAHEJm0=;
 b=TxaExfEJSub2Jm9mtUg2H774oQe3gDIlPpFlctMK35qyj80D4VPlylpGHMxQLNSNCW61FzoFOPKXj25JpxbN4YN5iRGgxl2TOfdWTAFU4VGRZteL5wSaAjMot0bz96W1DNSBWugc4P3r8ZOZ9g8EziqmGSqGyMEl1RBAcJaJu5Q8culjADaIKTMpsa92MyRqNtQpsgswlEe7KkE1rbm3g/Tx1vYhAkYSzD9BUXxy87XzFSrRO8gFqlJUaPGGRqnOkxeKkQtQIE8a/N3VAX291MCj/4OJMqz/Z6PgH+KyfqFCa2vJTqduEAwZ8nKIXGBHq32i8flsWweg+6+C1YqtYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmnOOBIDw1kzONVeeApc0UfSPedrmGZmu5/coAHEJm0=;
 b=FbHfOsA85qc5l57VO4EIqgXu6DrKyu2YFVWwt8Y/nnHNczNXmP5QO/Y+ySTJc+DUeve50XMLU+f++07A1AU8WxdIdqTU2Ihg/KFyLIm4nXzC6tc6u9/bmYTIVLToe6CaU+h9U/I6qViYrH3UZc1gU7W9Z74MQc/3s6bfkEb6IVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV1PR04MB10428.eurprd04.prod.outlook.com (2603:10a6:150:1d4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.22; Thu, 28 Nov
 2024 14:00:13 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 14:00:13 +0000
Message-ID: <46943cd2-1a08-4357-a32d-eeaba34194b8@cherry.de>
Date: Thu, 28 Nov 2024 15:00:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip PATCH 1/2] bsp: rkbin: rkbin-ddr:
 use glob pattern for finding DDR init
To: Trevor Woerner <twoerner@gmail.com>
CC: yocto-patches@lists.yoctoproject.org
References: <20241127-rkbin-bump-v1-0-b90b6c04a88f@cherry.de>
 <20241127-rkbin-bump-v1-1-b90b6c04a88f@cherry.de>
 <20241128005526.GA17984@localhost>
 <cc7d79bf-e199-4478-a290-c4926b21e27e@cherry.de>
 <CAHUNapRvAB5OPtvApDmzM31727KGXnCO3TUe30ZTnELKqZ7YPg@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAHUNapRvAB5OPtvApDmzM31727KGXnCO3TUe30ZTnELKqZ7YPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV1PR04MB10428:EE_
X-MS-Office365-Filtering-Correlation-Id: 923fb3c5-a4b0-4499-93d0-08dd0fb4fad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?HTox9Td/HGpprz4ZkPpxRGLOKJ7a4u+tZYbaDiIy3mik6rlV1N+rCb9CrYp/?=
 =?us-ascii?Q?S4G9FrPiDkRI7Um3zQuoZqmBusW1Nns2gYbULka1Zm/NN4qPQZ5glz02XiNO?=
 =?us-ascii?Q?mviOzKZ5whVjRpbBmfGQx9zugxEW2YKFGzhReq1EiEUIw5hnUy5lKq+kbHYW?=
 =?us-ascii?Q?a/QOKkR60Bf3pXqRmng1TP/ZCsze20JfTAKwzJe+hoOxO+rJlD4XI0sYvuga?=
 =?us-ascii?Q?h/z1RKDsaCqbLugBy+6LBvW14KrjCObM11DIbkdFYTznzixqqBX3E4/Gi/zH?=
 =?us-ascii?Q?zjnBhsf4S9RJUzJrTRcuppAsFgy56H0OOiddO/F2xoS9l5lAfc0nUtgpn05C?=
 =?us-ascii?Q?iRRy40x2N/Q2KhRwFo2ltKosLw1dXVa+Bcln0XK0ccmRe2GFXZ/9ya2Z1Dx7?=
 =?us-ascii?Q?+q5Djqt2/eeIHb0DvrBU4tuyj4B/3bagGjYHEdd2FNT9gd6aNuyfoke0xtU2?=
 =?us-ascii?Q?teLH2CZ5KtbIOOCdD/6TOiYmjX0mRTtmjjgVdjEYBcPWpiQF9XMe9nZOZx/j?=
 =?us-ascii?Q?stv2GuxPvsv0AnNpqBexo0/n/+pVaRIppQkouSb/HXUAWnfyupO9BXsPhqnq?=
 =?us-ascii?Q?wYoiosLVze3PjSzEDLGMAr07D8xmWC2YpDjjbkUlLYnlAgi6XwZKuaJJrKc0?=
 =?us-ascii?Q?5wIFthdfdgnCegbkq9cuL7iRA7wB39pL60YF430FDusFBARIAWIciDn+zfQc?=
 =?us-ascii?Q?6jXlbhR84RA9lonsLab+AeLXoRTxKfHZX1o3yIHFtgUvSSkFqlnw+qlKgB8h?=
 =?us-ascii?Q?gqfNHWGFQ0TukjM8+ib4y3uM/og3WlHHaFKK4hMCZaaVTCVKGpg+WQ/bzpHq?=
 =?us-ascii?Q?0FA6StqtpnWw+gb2l4kGMmIKw3nvWAxNj7wzLjh+zqMgqhAR8kKJCqZ7cTut?=
 =?us-ascii?Q?LO/Ue3hOG9D58DlWfw8zrGgDCC03hmf8oV6JF1HH8WQMaCJjtHAPRGuX8yP6?=
 =?us-ascii?Q?08GA9jCGYOtZbyLvvWG0n26Lx/NSpds6P9A3H50GBJT5O+djO9+L0VqTDQvC?=
 =?us-ascii?Q?T7q7neCj7xJjDT0GVADyff8YDoaTwfJphclwn+nctYP3h+KasNZKrrFAVQZt?=
 =?us-ascii?Q?OPwU0VBojhDs3TKgkI5y69Us67aVM75Aj33Mu9DzQ6hCK5UXCuYh8D/kx1zQ?=
 =?us-ascii?Q?hq6QAtFiU1gZ+9MbyCuzDEC6lFejr2mggCEqeN957syAkTigzliCWEBg2f94?=
 =?us-ascii?Q?KoT2FO/FUvNLIo4sx+Ul526gabckmLhp1hKfvRcF5xov8ZnPdh9d+mlbRdai?=
 =?us-ascii?Q?9JNgMhB1zVWNsFf7a62xqCpQ41C9W73jj1ndvDRmuuRUBdi4+UAPI06U1e02?=
 =?us-ascii?Q?6ayEgIWk9wcZibLPg38II2sCfyKKVREW/I9rRhW4Djy6aw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4OdKKKUTK2sII5SZGJYDZheBQwXrgPqAaKDPziJFkdaobrW8ATORNAqLNuW8?=
 =?us-ascii?Q?nrFSyz+oDiX+TcplSFoB7/abctdXqShFJ0ajnou+MwldQo1pgruWkG3Ycr6m?=
 =?us-ascii?Q?tUf2lSk8Jnvr7d92eY7cnu2B0X6LqBJHp7NGCdFHakyOb9T2V3zL1tKz1TEs?=
 =?us-ascii?Q?+1G7YpJ3KdA2Bi/X2COTS3UxMypLhBmJLgP+m0+wG0iFj/Y9/ckIokyW9I5+?=
 =?us-ascii?Q?o0J18Zum+t2UmDE6aqm4NYQAHb+4Z9zyabOQRzh6xa3cj1IQlnCvOP6jFdMA?=
 =?us-ascii?Q?8qm6eGUHqcF6SygLu3UMPxBaF1wJ+Hq1ML6/83lylMSSl7N+1faC2JaRbED7?=
 =?us-ascii?Q?4gLq0wZ1ihNJxP38CoN/sZ4kVa57Rba1ezVkCIYT13oRjUqm9JaOE97iEVwp?=
 =?us-ascii?Q?RHx5KZB6fIJLBEhAVvvYJkN03B6iNKuTXJJSs3Kys8JWCQnG5itNnDB5SUfG?=
 =?us-ascii?Q?YoP301ct+4D6QBPHR0+yc3uyKlVrCG5aoRUqVBpBeDeXTDQpnCRRNuioe89k?=
 =?us-ascii?Q?8txNhsNMm9CWUV919D7/CTmkVdOaLHnhIb/NOo6x4bPKcVqpT3rK/Rbg4uX9?=
 =?us-ascii?Q?ZuJ0lZz2NgxcrDU148ojtBCUeITmQvN0XzNF6y8/aqyiJEC1ne2hrs71VFu+?=
 =?us-ascii?Q?qbyXCNacNEpzCCpQ7/pntC77RxaR76VZLXKKmT+IQ/Xc7L2ACt63k8bNIurE?=
 =?us-ascii?Q?bXuZqPsVdmdDkNh3NYU8OKAdmEcBuXxRLdNsLftyuvwrgQrzH4mGW+Dele8t?=
 =?us-ascii?Q?7m7dUBVG7NhnAMYE1I1wYqs+E5P6sVEgPUQVN7M6keOZZ1MNsMwdW7XKSlM6?=
 =?us-ascii?Q?RC15n9MVitKw4vJw5rpSbjSdu62Mrng32qOjAfGI3YCtNk2gFPvFkX1Mt0Ty?=
 =?us-ascii?Q?1joLjcMoCAYcqYIGCzdMxOQZocN9lY21mkq1k+bzmo25xHCGiYSMWVPhplpg?=
 =?us-ascii?Q?EmCYJffLayFNrWdTbzR/riaLPxKK8dt1Doh2UTQ+tkvRJf+6TgJbwQlMva6C?=
 =?us-ascii?Q?HTC9CNhjCeJDWcUEITjGcypfCybj+0qay0j+Njne4trYQZn8S2tnZhPQokh3?=
 =?us-ascii?Q?AwAVdFwQAupsVSMeFpbStnaRSxNgXBAmKFYVqsjMF9rOT8zSFH3pVCOIXUhE?=
 =?us-ascii?Q?liFOnMVyCzR2nkDANJttDeccuNesojRf6hDsolh+rfeddcq7Y4w8CggCcAHt?=
 =?us-ascii?Q?xiJUAcxG8YHNtdxD+aiRmEMIP9i5L9JXXmZmMwooeVB//55z1kPIrliXnnwP?=
 =?us-ascii?Q?P9mxTE14nj4nwiR6GxKNAwcQwH8maGvYRSLiAijWyd22I/HCKXQOAok2z421?=
 =?us-ascii?Q?YQe4QGy4+AD8jV7py507hrMuJyOiRJnkb5ve1tdkNM8nscITJwxJeTstyBT6?=
 =?us-ascii?Q?aAZ6k1fSNueV0sRBAGB1Rbvcadxym4iphUnfPtPHLSixLx88G5kLNbzETK3R?=
 =?us-ascii?Q?fzb85qDK8WdjqRJBhN0MBvkpph/xhMeF6MR5NC/UlnErMEQPbmEC75jdJevv?=
 =?us-ascii?Q?Y8u8OdnM3SOynRZUguAzcsKtruYrvr3ymJ2wqqhc9WF5zj0duGEzpPpgXFhw?=
 =?us-ascii?Q?Jwoy/WgtfwYGMapB3iDcpOHGcP8OvkpUJ7HcL6tERqgrYvDu75EPXB3ReJ5k?=
 =?us-ascii?Q?eA=3D=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 923fb3c5-a4b0-4499-93d0-08dd0fb4fad6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 14:00:13.4838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0S+FaQo5vwDL3efsmY6J9NegLsTBLq1KLiIvgh9s97pVP8pQaW2lIGKPk+ptCd8KNrrzNrY4nIuMCJRcorCK2Fl4ekw1xyVJU/vYUQaM6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10428
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 28 Nov 2024 14:00:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/854

Hi Trevor,

On 11/28/24 2:51 PM, Trevor Woerner wrote:
> How about a variable to hold the version e.g. 1.18 (or whatever)?
>=20

Considering the filename has changed already for RK3588, I would suggest=20
the whole filename?

Or two variables?

DDRBIN_VER:rk3588s ?=3D "v1.18"
DDRBIN_FILE:rk3588s ?=3D=20
"rk3588_ddr_lp4_2112MHz_lp5_2400MHz_${DDRBIN_VER}.bin"

So that in most cases you only need to update DDRBIN_VER but it would be=20
possible to change also the whole filename. This could be useful if you=20
want to use the eyescan one for some reason, e.g. rk3308 has many=20
possible frequencies for DDR with different uarts as well.

> On Thu, Nov 28, 2024 at 5:23=E2=80=AFAM Quentin Schulz <quentin.schulz@ch=
erry.de>
> wrote:
>=20
>> Hi Trevor,
>>
>> On 11/28/24 1:55 AM, Trevor Woerner wrote:
>>> On Wed 2024-11-27 @ 04:12:58 PM, Quentin Schulz via
>> lists.yoctoproject.org wrote:
>>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>>
>>>> To avoid both having to modify this file every time the
>>>> rockchip-rbin.inc SRCREV is bumped and also having to override it were
>>>> a user to have to mix and match versions for different products, let's
>>>> just use a glob pattern.
>>>>
>>>> Note that the glob pattern should only match one path, which is the ca=
se
>>>> right now.
>>>
>>> I'm not overly fond of the glob method. It was only back in June of thi=
s
>>> year that I pushed a patch to move away from globs to using full
>> filenames
>>> explicitly. The savings seem pretty thin compared to the potential
>> surprise
>>> factor when, one day, multiple files might be selected.
>>>
>>> Do you feel strongly about switching back to the glob?
>>>
>>
>> I feel strongly against the status quo :)
>>
>> We can add a check that only one file is matched by the glob pattern if
>> necessary and fail otherwise with bbfatal/bberror for example.
>>
>> If we don't use globs, I need to override the do_deploy:<soc> to replace
>> the path if I'm building a different version.
>>
>> Here's what I needed to do on Scarthgap for example in my own layer:
>>
>> """
>> diff --git a/meta-bsp/recipes-bsp/rkbin/rockchip-rkbin_git.bbappend
>> b/meta-bsp/recipes-bsp/rkbin/rockchip-rkbin_git.bbappend
>> index
>> 9d381a6afadf7dd66855f6635b5f1f053eecba15..299bb2ac476bf9d988925cbd983a66=
158a8bdf4c
>>
>> 100644
>> --- a/meta-bsp/recipes-bsp/rkbin/rockchip-rkbin_git.bbappend
>> +++ b/meta-bsp/recipes-bsp/rkbin/rockchip-rkbin_git.bbappend
>> @@ -1,5 +1,12 @@
>>    FILESEXTRAPATHS:prepend :=3D "${THISDIR}/${PN}:"
>>
>> +# Remove once the following series is merged and backported:
>> +#
>>
>> https://lore.kernel.org/yocto-patches/20241127-rkbin-bump-v1-0-b90b6c04a=
88f@cherry.de/
>> +SRCREV:tiger-haikou
>> <https://lore.kernel.org/yocto-patches/20241127-rkbin-bump-v1-0-b90b6c04=
a88f@cherry.de/+SRCREV:tiger-haikou>
>> =3D "7c35e21a8529b3758d1f051d1a5dc62aae934b2b"
>> +SRCREV:jaguar =3D "7c35e21a8529b3758d1f051d1a5dc62aae934b2b"
>> +LIC_FILES_CHKSUM:tiger-haikou =3D
>> "file://LICENSE;md5=3D11e3673115959bf596feaaa6ea7ce9a5"
>> +LIC_FILES_CHKSUM:jaguar =3D
>> "file://LICENSE;md5=3D11e3673115959bf596feaaa6ea7ce9a5"
>> +
>>    # The files are created locally by running:
>>    #   ./tools/ddrbin_tool tools/ddrbin_param.txt RKBIN
>>    #
>> @@ -24,3 +35,14 @@ do_deploy:append:rk3588s() {
>>            fi
>>        fi
>>    }
>> +
>> +# Can be removed once the following patch is merged and backported
>> +#
>>
>> https://lore.kernel.org/yocto-patches/20241127-rkbin-bump-v1-1-b90b6c04a=
88f@cherry.de/
>> +do_deploy:rk3588s(
>> <https://lore.kernel.org/yocto-patches/20241127-rkbin-bump-v1-1-b90b6c04=
a88f@cherry.de/+do_deploy:rk3588s(>)
>> {
>> +    # Prebuilt TF-A
>> +    install -m 644 ${S}/bin/rk35/rk3588_bl31_v*.elf
>> ${DEPLOYDIR}/bl31-rk3588.elf
>> +    # Prebuilt OPTEE-OS
>> +    install -m 644 ${S}/bin/rk35/rk3588_bl32_v*.bin
>> ${DEPLOYDIR}/tee-rk3588.bin
>> +    # Prebuilt U-Boot TPL (DDR init)
>> +    install -m 644
>> ${S}/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v*.bin
>> ${DEPLOYDIR}/ddr-rk3588.bin
>> +}
>> """
>>
>> The last part of the diff shouldn't be needed.
>>
>> If you don't want a glob pattern, we could maybe use a variable to store
>> the path to match so that it can be overridden in bbappends?
>>
>> What do you think?
>>
>> Cheers,
>> Quentin
>>
>=20


