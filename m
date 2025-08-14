Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E76C87FCF
	for <webhook@archiver.kernel.org>; Thu, 14 Aug 2025 01:02:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (NAM10-DM6-obe.outbound.protection.outlook.com [40.107.93.82])
 by mx.groups.io with SMTP id smtpd.web10.12253.1755133336401853298
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 13 Aug 2025 18:02:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amd.com header.s=selector1 header.b=j8oYBWZP;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.93.82, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+csbptulGw51QBUp6QBKlhbD8oHlFXsupRO6YIHHSQKDUuS5aRVE9AjAiOtGuvbHMzlbjTcxUTaz+ZjYyRfSFdhdvUY3zdveCw6vxdXm98Iarf4fmvp5sMIwOxJ+4xDuTR4f4Tf12eozeCR5dIjSnLh5m1HOjQHL1sOvC/391E7G8SNKIzl3XDsqgamA2SbjWLVeyrpGtvnlEH8EKZV3/b6JZDnUplhgO7+1CDv6dT4FfpL1lpXjiTHXfzZEdDOAocP1XVruOjNZKmYvameM1HVPgD8MyqzUgSqG5hnc11gTzaXgbEDaMA9dj7Dod/E8UIShSLLuaTd9Pq0i5biIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8TdAtos9ksWr1vmnrbhJ5nDRj7DdnjVpkKsIe3PLrc=;
 b=SWE9bkHHgq4tq17ljHIy0P3kPAW1j/r+CffuN+JW02FZ1Jjh9FmVJVq1eK3tOcWZCfaC8wDTHQH/YZq+JDuPi51rhxiuzVPnF9AjWZJCN/o0Q1ETBB1IyrjrzWmIh3zu1+i8WXjusl5ObPX8LSulW2Xiz1Jd9jnes7uAEv5KnrXJ2QQ/rvIN5YWkPMUlCZqtt1zXGn9Ax7xsRl39KbGKMzzmN6XzgP5NGTnzn9orm+id1QG6HHFV6e89ti9cyX1wKy1xaWS/cdXl8UoGR2lZFt2+KuaMkCVz32PF8khjL9HaiARCgAQvlGuVd6pz5tq8wCYUfiPoNuhLLzSJYqVjtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8TdAtos9ksWr1vmnrbhJ5nDRj7DdnjVpkKsIe3PLrc=;
 b=j8oYBWZPF5uYBRfpTpHOpgZbw1w+trHJBbAcUlLbM9P1O0JZIP+6U2HOXxeQB6au2i7EZ9kb+Vvb5VRah8noiOnVwo7Ke6yfCjfZUJWWFP02RGqiKttuJD3rIaQxDyNnPeNzRh3jQS2AY7ZDBR5eub6vSCbQOsxJwfiTXz1W3/M=
Received: from SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21)
 by CY8PR12MB8340.namprd12.prod.outlook.com (2603:10b6:930:7a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Thu, 14 Aug
 2025 01:02:13 +0000
Received: from SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7]) by SN7PR12MB8770.namprd12.prod.outlook.com
 ([fe80::52a8:e59e:e6dd:daa7%6]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 01:02:13 +0000
From: "Gundlupet Raju, Sandeep" <sandeep.gundlupet-raju@amd.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: RE: [yocto-patches] [meta-zephyr][scarthgap][PATCH v5 4/12]
 zephyr-image: Add image artifacts to output files
Thread-Topic: [yocto-patches] [meta-zephyr][scarthgap][PATCH v5 4/12]
 zephyr-image: Add image artifacts to output files
Thread-Index: AQHcC7BtV9zlqduNYkOWXOgMxBYyuLRf6QeAgAFtAkA=
Date: Thu, 14 Aug 2025 01:02:13 +0000
Message-ID: 
 <SN7PR12MB8770AEA28E0566FB714AE8CDDA35A@SN7PR12MB8770.namprd12.prod.outlook.com>
References: <20250812174147.130972-1-sandeep.gundlupet-raju@amd.com>
 <20250812174147.130972-5-sandeep.gundlupet-raju@amd.com>
 <BL4PR11MB8797DFA56346369056287E86B92AA@BL4PR11MB8797.namprd11.prod.outlook.com>
In-Reply-To: 
 <BL4PR11MB8797DFA56346369056287E86B92AA@BL4PR11MB8797.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-14T00:59:37.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8770:EE_|CY8PR12MB8340:EE_
x-ms-office365-filtering-correlation-id: 6fd4aee9-9bb0-46cd-2bc3-08dddace3447
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|4022899009|376014|366016|1800799024|13003099007|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?RHhcJsFfiw2Q07N+VP+eMLAENRJtS2cPwu4OYcNly1Ox6CCI8qmeZ/IDFdHs?=
 =?us-ascii?Q?p0c3DyIO4Sm5VEKXlQxLyYyosX7qMkEQi62ahd7qXiAIZlyYlSwCT4rZhZaZ?=
 =?us-ascii?Q?CyhfrfO9Vx9DLc8+8WMSUrsURfBiuYvqWOL+E2xy9JcAHBq4rtHNKJ1+iTC7?=
 =?us-ascii?Q?OP42/UbkhID/v/iKsmE1GNv/AaJgAu0actQnuIoOvbN8raa2zFBNDrkdYTd6?=
 =?us-ascii?Q?jMoYLVIFsng1D0NTK7Oglk1RmFf+6aV0agsixIj58dg6edyUSwxh9h80Qe4d?=
 =?us-ascii?Q?BnwY8OCLnD1cM854t0Q0/vMQ8cHQzEmn4+8zUU05FzS+XcSjkbEVP5Ow/29j?=
 =?us-ascii?Q?jAk2wk17FbGxBLpcu2qHQjlFZmPOdqSrf5mpNuTElFa6JlYXhEkqYKSVyxKE?=
 =?us-ascii?Q?I+jhOkbufs8xfOg/19W6Sf6656LaWD8UUUOkoqpC8kNmy97u3FEEjaQt8V9g?=
 =?us-ascii?Q?5XNLiArW6ko9+9600PIlqOB+eDJNWfVNdKkSQ0VtjFcmXlMn0dAHYlx8aOg/?=
 =?us-ascii?Q?D0VPBGfeVW7U7F2bNYmlGQHvifG+WYX6kw3TujDXI35MaFlMVIeity5iTOPj?=
 =?us-ascii?Q?Rp0htSHm4N+BSKO4hHYl5kULYMBhjdmwT1/ON3Rp3pw3Yw7qK2ZYJa2h8xEc?=
 =?us-ascii?Q?S4NBFKLVUa1ItLXxQ8S/1H5FvyZIpIIbI6w+5Ml2njcAtcwubBcB2rn6422g?=
 =?us-ascii?Q?oqydGNkkWjPKEFj5nbJrLiqGKZJIs4T9VI+HDIQyoAechGo86FIg3emz/z7y?=
 =?us-ascii?Q?UDx5m566ZhKgV2QPeXMvQeEHOutTyjlBnKANEk1fyBzE2pNOYD9T/F6/Vq1U?=
 =?us-ascii?Q?vPKqySQF3zVhZQX/bzGdAG0/5jTRRand9q29EvZUfGfYUWwEr5tewi3/zudn?=
 =?us-ascii?Q?zNpRJyQAeHFGhfl1h3kqY5cdyg++hYUoO4AlxFBQSrh05zPGQK4Vt1v16riR?=
 =?us-ascii?Q?POBgCnAO4R2IxSwJ4alMYC4yS6ezy3vfaETN/8HIHIMREc/DLI26QFKiZgHK?=
 =?us-ascii?Q?aA3E5LETQrTWRJIeGgdPQmWB6Vy+GzRoNBk3u2EJ8q9EnBIHCJzJeWcyH1E3?=
 =?us-ascii?Q?FA8fLwwwNYVwIoqcm6Rppv0SYuf6o2hD40Bi6Ch06pXLCVKDf+kTBZDOFdvd?=
 =?us-ascii?Q?/YoXpJAxMjQFVsv0QCVVqVQR4BcfAHfRTmJYMmkAZXT5E8aoQvGJXNyN+LPT?=
 =?us-ascii?Q?ssHL0DpGXep7rHJ25joMr7GtWbOGKZKYjrXy2h/lxjmviBKkIH9t/HMcA0ga?=
 =?us-ascii?Q?z4HPjiEX3vG/d5FVyk0GHR12W1Rf4MeZr7vttGo7mitwaPXyNfR2ELbNEY8P?=
 =?us-ascii?Q?EXVKrVsBiQhgq5vLRJY8yUZEoKqIxU5/9Gt8S9UqLg1ylDR1kvJY9jbAJdSQ?=
 =?us-ascii?Q?jOGXGlR2ItDWDDSgDyR4NxugaBYeabsiAsLMSM2cb4rMDOXdTd8zX70pLAS3?=
 =?us-ascii?Q?4GTxnhqBe5A=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8770.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(376014)(366016)(1800799024)(13003099007)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?MstsjyN0sRmfROXtZAvR5HTgRbH+pqMl6hm//i5DDuGVahZryRtg02I763v3?=
 =?us-ascii?Q?xSnHJO3ht8RGYPB/f8FOAQrW60wtb4dAeDoUx5tMMA+Y5j9EHneJMbaITbma?=
 =?us-ascii?Q?tkttB7SiQOEjfMJuS2cReQuQH2pujMn0nVRlXbfEYgpObXLL3w5/IA8c1iPC?=
 =?us-ascii?Q?YXBMHDbidlx8Otv2MLFt+gbC9zuk4HxlYa03esS/C4iKpr1qwOhqiZfBS6et?=
 =?us-ascii?Q?JbOluXWoPOnXO2NWvz02uy/YWdjx0XbVIlmIh73PAeZNJ0h1ANAvnWUcnvcS?=
 =?us-ascii?Q?vi2NEbe6vK7ACY4UJJWnpc9Jqj1cnwIdD/uOvBfLgXVwO9p+jAE+SqvRlxH5?=
 =?us-ascii?Q?jcPHQzY5KsAukLgY6vXuyIAozGIVht4r5090Jl493IRz3jHIkIBoY2Z79aE8?=
 =?us-ascii?Q?eOr1Eeml9RIXAf/UCwuqXzuN3eHAeBqq5nwuDxlaZUzL69Zrz4bdCjSFCuby?=
 =?us-ascii?Q?MCRPseuOU3awXcTxzXD3c45PrNoTKgrJglLfgxXX3kNt0xZL3J/oU5cvhKDw?=
 =?us-ascii?Q?ZKlS89tF3Ink8Sm1YPQYeFalOgWIcvrmdF7mkZ1PM88v5Xs0WsDGvUMst0cF?=
 =?us-ascii?Q?l8EuYi0imXVvZhPnKwwlAJ7C/zefye+Ovuy7c4yQ8aHj4rq+Ql9Fh5dIDfLV?=
 =?us-ascii?Q?LTGMJePkTvKXX/D26aiAAQicKSR2beFJexXzx97PhzdfNPtgco3J5uXftrYe?=
 =?us-ascii?Q?oNKLujk9wxuw0jbFaBcUw4r7KtONBiDJ2z6hvrOesxEtbWcC5iqzDGNatZqV?=
 =?us-ascii?Q?UHLD2t5y1LkmTIBvADCAAfO7E+T8l9FzOg8jeRYWOz/IjJb9IEB/vX/lHDCl?=
 =?us-ascii?Q?umGUqHixOOpFHU7PFxqRDWJhwqr53uLQeDg/nlV3RRHYrF69wlAdcle6wyzK?=
 =?us-ascii?Q?y2+fukn+v5lQwTWg6jOkz6HB/FCdpL0aILFCd/2xnmsNvFiQVpnkf8/ZOhwS?=
 =?us-ascii?Q?lh0s+lTKxrierBNWivGYFP3s/NzkRBt9bVRdJsyx95gBmxofoAQhwzaxJF1d?=
 =?us-ascii?Q?x8fZ2+7SzqepzQ9e/PKumYl0fR3FBbF/iseE5Y03zQqcyI0FxJB4fAZWoHT/?=
 =?us-ascii?Q?sgvC2ZyVkkfHg7b1vQp3wIk4y5YNx6tCKLU19UJUfHjTO9SiiIQ6o8eog2ne?=
 =?us-ascii?Q?Dh+uSFqgoL7Yrdnai0UdpPFghwmriEaFEVGlfohdGrvXYOYwpXcVC13nu/th?=
 =?us-ascii?Q?+zKugWa7BCXHUDralxf23wbibbK0AfjB8YOEL5OGqCD1UzoMwFG700lZj8dC?=
 =?us-ascii?Q?g67GCFkD3qAsz1DpLr5YDuZVBprfCyZdwafm2yZjJ/P5j4yc4Y1Y2K9OutKS?=
 =?us-ascii?Q?Gq5AAnfq6KNjYJrnrvqB9MWF4tRLQA8c3EJfnorbauEpIuD+7mWsYVkr00X+?=
 =?us-ascii?Q?lTUFrE5bt7BMEUET2ToopbSleXUwCfknHqMU5maB5PeDGfr6SFMm9N2FNUxI?=
 =?us-ascii?Q?cqlp131D00SwI8o9BC9xstFc3excrgGhdgbrP+I3V81nS3rEAtB0OCNlkkUn?=
 =?us-ascii?Q?vnMlETk+pSPBrGDaPI2Be6SBAwKFpoNOoYNR1U/7L6xfF7s3KxG9h/+qnABw?=
 =?us-ascii?Q?uuxhlMobqEchLiGSe3o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd4aee9-9bb0-46cd-2bc3-08dddace3447
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2025 01:02:13.1272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4EvLvtI1HFRfriMD7vET0JBwjAT3FotjKL4+nbT3oXccqCsg6GyOX6QiVLqsZPPNzWT38DKvjHY8DcXMRuQzIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8340
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 14 Aug 2025 01:02:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1986

[AMD Official Use Only - AMD Internal Distribution Only]

Thanks,
Sandeep
> -----Original Message-----
> From: yocto-patches@lists.yoctoproject.org <yocto-
> patches@lists.yoctoproject.org> On Behalf Of Lee Chee Yang via
> lists.yoctoproject.org
> Sent: Tuesday, August 12, 2025 9:13 PM
> To: yocto-patches@lists.yoctoproject.org
> Subject: Re: [yocto-patches] [meta-zephyr][scarthgap][PATCH v5 4/12] zeph=
yr-
> image: Add image artifacts to output files
>
>
>
> > -----Original Message-----
> > From: yocto-patches@lists.yoctoproject.org <yocto-
> > patches@lists.yoctoproject.org> On Behalf Of Sandeep Gundlupet Raju
> > via lists.yoctoproject.org
> > Sent: Wednesday, 13 August, 2025 1:42 AM
> > To: yocto-patches@lists.yoctoproject.org; Lee, Chee Yang
> > <chee.yang.lee@intel.com>
> > Subject: [yocto-patches] [meta-zephyr][scarthgap][PATCH v5 4/12]
> > zephyr-
> > image: Add image artifacts to output files
> >
> > Inherit image-artifact-names bbclass in zephyr-image.inc and add image
> > artifacts to output generated files.
> >
> > Before:
> > zephyr-helloworld.elf
> >
> > After:
> > zephyr-helloworld-{MACHINE}-{DATETIME}.elf
> >
> > Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-
> raju@amd.com>
> > ---
> >  .../zephyr-kernel/zephyr-image.inc            | 28 +++++++++++++++----
> >  1 file changed, 23 insertions(+), 5 deletions(-)
> >
> > diff --git
> > a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
> > b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
> > index d6ee21f..93d36b1 100644
> > --- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
> > +++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
> > @@ -1,29 +1,47 @@
> >  require zephyr-kernel-src.inc
> >  require zephyr-kernel-common.inc
> > -inherit deploy
> > +inherit deploy image-artifact-names
> >
> >  OECMAKE_SOURCEPATH =3D "${ZEPHYR_SRC_DIR}"
> >
> > +ZEPHYR_IMAGE_LINK_NAME ?=3D "${PN}-${MACHINE}"
> > +ZEPHYR_IMAGE_BASE_NAME ?=3D "${PN}-
> > ${MACHINE}${IMAGE_VERSION_SUFFIX}"
> > +
> >  do_install() {
> >      install -d ${D}/firmware
> >
> > -    install -D ${B}/zephyr/${ZEPHYR_MAKE_OUTPUT}
> ${D}/firmware/${PN}.elf
>
> Since this is for stable branch, I think we should keep the elf/bin/efi f=
ile with
> old naming. We can deploy both ${PN}.elf and
> ${ZEPHYR_IMAGE_BASE_NAME}.elf,  ${PN}.elf can be copy of/soft link to
> latest  ${ZEPHYR_IMAGE_BASE_NAME}.elf, same for .bin and .efi.
>
[Sandeep] : Agreed this is for stable branch but to me this seems to be a b=
ug. Deploying ${PN}.elf is not a YP best practice. What do you think?
>
>
>
>
> > +    install -D ${B}/zephyr/${ZEPHYR_MAKE_OUTPUT}
> > + ${D}/firmware/${ZEPHYR_IMAGE_BASE_NAME}.elf
> >
> >      if [ -f ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT} ]
> >      then
> > -      install -D ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT}
> > ${D}/firmware/${PN}.bin
> > +      install -D ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT}
> > + ${D}/firmware/${ZEPHYR_IMAGE_BASE_NAME}.bin
> >      fi
> >
> >      if [ -f ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT} ]
> >      then
> > -      install -D ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT}
> > ${D}/firmware/${PN}.efi
> > +      install -D ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT}
> > + ${D}/firmware/${ZEPHYR_IMAGE_BASE_NAME}.efi
> >      fi
> >  }
> > +
> >  FILES:${PN} =3D "/firmware"
> >  INSANE_SKIP +=3D "ldflags buildpaths"
> >  SYSROOT_DIRS +=3D "/firmware"
> >
> >  do_deploy() {
> > -    cp ${D}/firmware/${PN}.* ${DEPLOYDIR}/
> > +    cp ${B}/zephyr/${ZEPHYR_MAKE_OUTPUT}
> > ${DEPLOYDIR}/${ZEPHYR_IMAGE_BASE_NAME}.elf
> > +    ln -sf ${ZEPHYR_IMAGE_BASE_NAME}.elf
> > + ${DEPLOYDIR}/${ZEPHYR_IMAGE_LINK_NAME}.elf
> > +
> > +    if [ -f ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT} ]
> > +    then
> > +       cp ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT}
> > ${DEPLOYDIR}/${ZEPHYR_IMAGE_BASE_NAME}.bin
> > +       ln -sf ${ZEPHYR_IMAGE_BASE_NAME}.bin
> > ${DEPLOYDIR}/${ZEPHYR_IMAGE_LINK_NAME}.bin
> > +    fi
> > +
> > +    if [ -f ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT} ]
> > +    then
> > +       cp ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT}
> > ${DEPLOYDIR}/${ZEPHYR_IMAGE_BASE_NAME}.efi
> > +       ln -sf ${ZEPHYR_IMAGE_BASE_NAME}.efi
> > ${DEPLOYDIR}/${ZEPHYR_IMAGE_LINK_NAME}.efi
> > +    fi
> > +
> >  }
> >  addtask deploy after do_install
> > --
> > 2.34.1
> >
> >
> >
> >
> >
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1975): https://lists.yoctoproject.org/g/yocto-
> patches/message/1975
> Mute This Topic: https://lists.yoctoproject.org/mt/114670142/3619217
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-
> patches/leave/14411013/3619217/657730681/xyzzy [sandeep.gundlupet-
> raju@amd.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>


