Return-Path: <jamin_lin@aspeedtech.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05B2EEE27F
	for <webhook@archiver.kernel.org>; Fri, 13 Sep 2024 02:06:46 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (APC01-PSA-obe.outbound.protection.outlook.com [40.107.255.110])
 by mx.groups.io with SMTP id smtpd.web11.64323.1726193197059672889
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Sep 2024 19:06:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@aspeedtech.com header.s=selector2 header.b=nLVA070b;
 spf=pass (domain: aspeedtech.com, ip: 40.107.255.110, mailfrom: jamin_lin@aspeedtech.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cIhsOeVQFbTPeowsniaDYmPNBDGuwwXRzN5dhEUrMGNd7ieT1DgQGU16QvvmErUdqn9bdiIeu47exKr/IKjiabQhfmoFhT1UTZw8TU4hlP8DPJbL88tScD3EuVlr25tIP63cOYmcWwPSmE3rPS8htwYSGnZ/5v7RD1mt+gOylofg+/2PrVU+X+Tant35cnN9AHgEPW8jj6gHrdgYL7uYIahJpNOSfC3B4M68WOZo/dKVCdGAwGXSPn7SJqDWTmiT5iUuWGRrF12berTKprWanusiSuBpXXXbKv2rNA1yhyZ8WaFmga21Im7FS7Ua+qXDUsPLrNBtU2L5SyDTR7KYig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QWObmgAMk4D8RzYC9I4adMgSRvQD6RqfV/f8YSCHvA=;
 b=rt/cx1Ex2p9RZw9TMnxIVYy0rcwAjhc1/6YdWnbHaI9KbMBuy2nA/oE1ogzLe/fBzRyaE5VGEn47VYUT6Wx29llVxWC+oiwFQYdidmvYStDMzIG6fpKPmu6uO9bwO4y5rrXCe6jUcl+FIWak9/LtgNYRdz4JYqR3AgFyCHRoH1JhOQJENF9er4aZ6kUKXT4DPh6HhTk2JTR4yK7Kyf6PY0RbYvaCcPR0/Jt3qQerYHu57+lWFaej6DJlyjQFkqPUQkqmcxl1FXRDythUGK7XB0KNrF166/l/Jr5LbZIc0SR+kioMyXSt6pJQ1wr2KtmmTcuzl7WhUWnP6hwQ0K0+lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QWObmgAMk4D8RzYC9I4adMgSRvQD6RqfV/f8YSCHvA=;
 b=nLVA070bpYUl/OdJd/3mrVg81/cc/RuekZ2m/2IEuvvFs4psMJrTr3KmWAzewIXtUIhpZseyF44L3puuNSqq10PfNMN5T0IybmEp9xZNgfdDHqKvzvdVlFMAS2lMMTAGHgzvyZINVSd/7gCBSpDcWoMlOtah+s9jUf/YppVdq4zPWQgXUGbgPr2/S1TEBfYTDAbMRG15zi08RT14tloHxE/MUAlRyZZnBQAeaJapcwFSZ6OhdKj71Yi2ztPlkOYwA42qly+GmfT/hnjmEpkg1esFhQDFp7+sip+JGeTcytSqeGN5SgRkBEGtOJ04WeOjhIZuUduDckCUG0+0lmEMnw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 KL1PR06MB5884.apcprd06.prod.outlook.com (2603:1096:820:dd::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Fri, 13 Sep 2024 02:06:32 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.7939.022; Fri, 13 Sep 2024
 02:06:32 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "jaminlin1207@gmail.com"
	<jaminlin1207@gmail.com>, Vince Chang <vince_chang@aspeedtech.com>
Subject: RE: [yocto-patches] [meta-zephyr][PATCH v2 2/2] zephyr-kernel:
 support to deploy users customize image
Thread-Topic: [yocto-patches] [meta-zephyr][PATCH v2 2/2] zephyr-kernel:
 support to deploy users customize image
Thread-Index: AQHa/QQBDcVWqTOOOU6QfCVk69WDPbJUTsMAgAC6GMA=
Date: Fri, 13 Sep 2024 02:06:32 +0000
Message-ID: 
 <SI2PR06MB50413CE80269761BA56B9E84FC652@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240902064733.651635-1-jamin_lin@aspeedtech.com>
 <20240902064733.651635-2-jamin_lin@aspeedtech.com>
 <CO1PR11MB5026A5A109E365730E9E8D83C4642@CO1PR11MB5026.namprd11.prod.outlook.com>
In-Reply-To: 
 <CO1PR11MB5026A5A109E365730E9E8D83C4642@CO1PR11MB5026.namprd11.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|KL1PR06MB5884:EE_
x-ms-office365-filtering-correlation-id: 4ec28add-9198-4d57-4d38-08dcd398b06b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|4022899009|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?4psSn8nSUq7R6N8mCYVOipNGor6MCG0UKhYqE0cfmMfdQ7hlW5Sk6Rq3yTE5?=
 =?us-ascii?Q?JlWmO8kXRZe8egnZjVoji5yRb6NxaHY8n9yNsp/KiC6bcfcVdlmxMx/g6Fg/?=
 =?us-ascii?Q?i5c7BljoUos5kwM8U2CatQdsFyac5loPnCRLjG3W+nyG4uSkb2jK1c4wXDW1?=
 =?us-ascii?Q?QHbFqgdbp+zTGm8G6L9iReqEDzAuS6+OU50IVqSaponHn1xGSNP2voTZqrPk?=
 =?us-ascii?Q?ZTb9T/wMaB7EmDUBaqFjqXUXuZ4/Z0cZ3+xYp6hEHG5BsYgO7VD+06OllsHJ?=
 =?us-ascii?Q?Qwjjy4PmZrvQLP+u5Ah7arOCta+Zeyxhqu2o9hueiEkgm3er3O32pV2oIJCh?=
 =?us-ascii?Q?0ErjaAuqrEO27pRQ1Qytf8rAK7JAlZCTpLr7Pputy5OJdGdZlW0GnWA7PVhV?=
 =?us-ascii?Q?UZrJR47wazEnECkPbBJGYu/QZvpM3Vm20Ru9F2IsQTONjc6pZtk8+lDLekZC?=
 =?us-ascii?Q?FBA1nJ8lmhYBdoOGm3Yoe6MzpXZBezWPh1Gq9zjc2ltYNt3DsbWVjjVDn6eF?=
 =?us-ascii?Q?BHonu+G0I5QrrY6sUlzeNkGyYBE/HKGhfn5zd82/IiX/209XeiBwUHxnepT+?=
 =?us-ascii?Q?kTe/yiHAfAVOmPGtLo6/n1zQOBSvNfmjUlPdKUnxYN9CRZTKFJxK9NPHXeTt?=
 =?us-ascii?Q?kolLseewZ500JDoNuo7AK6Ak9dVPVrOU/ne4EI5Xga2WAA0Q3wCcdFf9eS7x?=
 =?us-ascii?Q?BnEHMt2TgF7A4Xyob8kVLyC1flIq3BnPWxo/DfzfTlhLPT9xUxNjCanhpH6J?=
 =?us-ascii?Q?9YZ6PRPlRkHuLlngv4o0/l85uEGa5oUA2LH6C02O8LHWWDdThvVB1nRK759h?=
 =?us-ascii?Q?P5rdZxqCbb978nmF6kTV5dl9gEBMw9eDGpWeUcM1Y/751/ht2T+ureuwQu45?=
 =?us-ascii?Q?5wHsa1LcCWUHixUDZWMY8IzTj9B9aU4qwIwRa3e6QvVG87mFyqsIpXuTw8Wt?=
 =?us-ascii?Q?i5ckFrlH25GVGegu7xUv2JoWMXG31gsV1WZ09qfTpWwEQBnf4+ug36sqm9iy?=
 =?us-ascii?Q?TuWjtu1AIXCivsxPtr47rlkj0rmbdS7x/Btn/f+FN1nHjfc8N4E7iUoXaJBP?=
 =?us-ascii?Q?UzYLKfc9wkISVdJQY3evCbXbTd5cXwnmm/pi79Z/60YsmS79jR/o6+HdCuKJ?=
 =?us-ascii?Q?tPK1ya/sI1QatPU74tHTq23sigH6/CqCaH2G/2yDx4t4EtpEAqYXIczwRspc?=
 =?us-ascii?Q?g0fY5T0EbdBwMPTBC4cRLpQLNVjxRW+QWtukJFVlP9n+eFFFdA0/yjWZ3XIl?=
 =?us-ascii?Q?CoY21NTVjpOr88zjifM5gDLzgxXqfvxkjVc1zyD9QLpkmyxFnX1Q8yipzePv?=
 =?us-ascii?Q?26EnX5eIk3GB2if8z1IDwWX2lgYi3TZMQ0sIQyQvW0qScA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5041.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(4022899009)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?XhDn+eTlnnN1ofv9f9ezxBkJO2UI/YpRDohVa8/OBi1fSz4xSN7be4VG4oVY?=
 =?us-ascii?Q?41JPDqsEMVqm48BXmPLdQwIP/UFPxlhKai+3ubcbK7bDL/GGXKrK4oM1Hi/Y?=
 =?us-ascii?Q?rO92wxWbLW2Ev9I84KjsKdmXqt7UOvzl5MkpZ5YfEeouix39mcMDBkM+uiPT?=
 =?us-ascii?Q?kD+2VX2FrWmfyaUPClixQz+mm8H3bIm1a99h2acXpH8DVjiDisjhHtSF4TxS?=
 =?us-ascii?Q?CKH/3KN9lvigqUkallULd+ePO7m+Jhv0HmUgJQwFGjOnqbAr/ZEqMLMos7b5?=
 =?us-ascii?Q?+iUV33AijvCFTjeRI2B3ELf94mPSEy8Wevg4cHBa0Cc1mKtH8H4C9zpTQrj/?=
 =?us-ascii?Q?p0yvbSB9+KgT6cfcDAnktg8mQPuBuKkb7DYNixGJi7/A1/scgZvR/p6Jvv70?=
 =?us-ascii?Q?CW8ZnJybwkTDwaYg6TTwqL4JwmswPUdtgt6xTGy7alysPnoMYsxz++pdZN5v?=
 =?us-ascii?Q?+n1aHuTrK9GMWPX5f3uyWeet+CuTFhz1/QsAaOOE+6SWGfQMHcIFXnwuNUpd?=
 =?us-ascii?Q?wInnNK1TWLRinjcU2S+F40XroH9ripo1cyocNb1jMa61UMKoXbBdzjKjVPcs?=
 =?us-ascii?Q?pOo2FZXrM0izkM2DuZYd2SxsZqpzG9cehhzKqIc2SkZMCWsNuqPflWCw4EzF?=
 =?us-ascii?Q?t7Wfy47Z1/IYjLxAnV0M/DQNiiP3kMnQrZvpnr+UrKwqu6M6mHYRHVOX/WzJ?=
 =?us-ascii?Q?77Pi4amXrW5odzauq2cD1k2SgWb7wt2qiXOZE/YSYv93wRp8OFLeJlYfqgL5?=
 =?us-ascii?Q?nMS4VREtkH7NVI8+IkYdOzoUNUzrhzEdIz5fuwDUaLtSk6N6Fa3NvYvUXizQ?=
 =?us-ascii?Q?sXaD/joH+ggkk7ntTg/AW+X7pdIZl1R/M1SGAbhpdNym9eCJZ7q6+i5DIEFs?=
 =?us-ascii?Q?SwfHMXRcAI+LapJqvMPWKMk7Es8AtdK/uYQNwgTmFIRFaXkvvT0/+DDUMgye?=
 =?us-ascii?Q?thkFwHkX+2Vh2qzGzD375rK4wrkZnyDPPd2K0X27GunFE4g04O4hg7GEpspt?=
 =?us-ascii?Q?4EAKvAAcHyaXfPGEjI/YQjmN0cOONLww9QqbN8ZNokJE9fMCSw/yxb2sNvxd?=
 =?us-ascii?Q?sBEhlXEekDR9H6BvTpSbz2O0pgOGq6qzbopWuGH7EUR5BkbVHePuC7q6y4fq?=
 =?us-ascii?Q?hLIlT6HAqX6Gg4zdIHSmaG7QUV4+81U8pgZjss9J1isYNWZ4FEGEsWY29J3S?=
 =?us-ascii?Q?gwbHvW2WqiTp2jPnmwe/lsXJKFT1SfjtneDJgmsZfsHThgqIgAG3HoHIv08u?=
 =?us-ascii?Q?xVTi1wm8aRoGzbuL5wBrfuBM2kZd3Mz3Om3prLk9gSOYuwZy7SNQjzdtUM5c?=
 =?us-ascii?Q?m7oNDDBEGETYqT4YXJAM/Avkjs05Hb8zOW51ANmhEOOn9B3O+M0sg8HOC+gc?=
 =?us-ascii?Q?kic1tQxSxMRotAKHR5A6pixP8qedJ85eWd0JuKAjsKJHlLfd2Jxllqh+lshs?=
 =?us-ascii?Q?iFMcgns+uRFvkJOpXa4KHmW5aU8+jGirN3norR4GE/4M4JW00a/G13s2EaN/?=
 =?us-ascii?Q?h5X2rzxvAh1JFGaFIlLR+OSPyeF+gTaSfUBqiBh8R9aV2Zcwiy5giXdJlYJJ?=
 =?us-ascii?Q?VhDKrPbmaNGl1IqT01EmuCzNeNca0/wQLmPun4cP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec28add-9198-4d57-4d38-08dcd398b06b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2024 02:06:32.7461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rtO0FiG02ZUS5f8tenRpYwXa1RHD7KUoNVJHOrr3/phm0ATFIdvfzAvz9Qn0Oqp356jpzgNINCnHiTzjZQ8VD12QL1ecay6o2NA/D5brAtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB5884
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Sep 2024 02:06:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/654

Hi Naveen,

> -----Original Message-----
> From: yocto-patches@lists.yoctoproject.org
> <yocto-patches@lists.yoctoproject.org> On Behalf Of Naveen Saini via
> lists.yoctoproject.org
> Sent: Thursday, September 12, 2024 11:00 PM
> To: yocto-patches@lists.yoctoproject.org
> Cc: Troy Lee <troy_lee@aspeedtech.com>; Jamin Lin
> <jamin_lin@aspeedtech.com>; jaminlin1207@gmail.com; Vince Chang
> <vince_chang@aspeedtech.com>
> Subject: Re: [yocto-patches] [meta-zephyr][PATCH v2 2/2] zephyr-kernel:
> support to deploy users customize image
>=20
> This patch is merged. But It does not allow to run runqemu. I have sent a=
 patch
> to fix it.
> https://lists.yoctoproject.org/g/yocto-patches/message/646
>=20


Thanks for your kindly support.
Jamin

> Regards,
> Naveen
>=20
> > -----Original Message-----
> > From: yocto-patches@lists.yoctoproject.org <yocto-
> > patches@lists.yoctoproject.org> On Behalf Of Jamin Lin via
> > lists.yoctoproject.org
> > Sent: Monday, September 2, 2024 2:48 PM
> > To: yocto-patches@lists.yoctoproject.org
> > Cc: troy_lee@aspeedtech.com; jamin_lin@aspeedtech.com;
> > jaminlin1207@gmail.com; vince_chang@aspeedtech.com
> > Subject: [yocto-patches] [meta-zephyr][PATCH v2 2/2] zephyr-kernel:
> > support to deploy users customize image
> >
> > In the previous design, it only deployed zephyr.elf, zephyr.bin and
> > zephyr.efi.
> > If users want to deploy their customize images, they should update
> > do_install task.
> > Add to check "ZEPHYR_MAKE_OUTPUT" to deploy users customize images
> and
> > zephyr images.
> >
> > Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> > ---
> >  .../zephyr-kernel/zephyr-image.inc            | 21 +++++++------------
> >  .../zephyr-kernel/zephyr-kernel-common.inc    |  8 ++++---
> >  .../zephyr-kernel/zephyr-openamp-rsc-table.bb |  8 ++++---
> >  3 files changed, 18 insertions(+), 19 deletions(-)
> >
> > diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-
> > image.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-
> > image.inc
> > index d6ee21f..c747095 100644
> > --- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
> > +++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
> > @@ -6,24 +6,19 @@ OECMAKE_SOURCEPATH =3D "${ZEPHYR_SRC_DIR}"
> >
> >  do_install() {
> >      install -d ${D}/firmware
> > -
> > -    install -D ${B}/zephyr/${ZEPHYR_MAKE_OUTPUT}
> > ${D}/firmware/${PN}.elf
> > -
> > -    if [ -f ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT} ]
> > -    then
> > -      install -D ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT}
> > ${D}/firmware/${PN}.bin
> > -    fi
> > -
> > -    if [ -f ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT} ]
> > -    then
> > -      install -D ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT}
> > ${D}/firmware/${PN}.efi
> > -    fi
> > +
> > +    for output in ${ZEPHYR_MAKE_OUTPUT}; do
> > +        if [ -f ${B}/zephyr/${output} ];
> > +        then
> > +          install -D ${B}/zephyr/${output} ${D}/firmware/
> > +        fi
> > +    done
> >  }
> >  FILES:${PN} =3D "/firmware"
> >  INSANE_SKIP +=3D "ldflags buildpaths"
> >  SYSROOT_DIRS +=3D "/firmware"
> >
> >  do_deploy() {
> > -    cp ${D}/firmware/${PN}.* ${DEPLOYDIR}/
> > +    cp ${D}/firmware/* ${DEPLOYDIR}/
> >  }
> >  addtask deploy after do_install
> > diff --git
> > a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-
> > common.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-
> > kernel-common.inc
> > index ba70a29..8a1638d 100644
> > --- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-
> > common.inc
> > +++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-
> > common
> > +++ .inc
> > @@ -10,9 +10,11 @@ IMAGE_NO_MANIFEST =3D "1"
> >  ZEPHYR_TOOLCHAIN_VARIANT ?=3D "cross-compile"
> >  require zephyr-toolchain-${ZEPHYR_TOOLCHAIN_VARIANT}.inc
> >
> > -ZEPHYR_MAKE_OUTPUT =3D "zephyr.elf"
> > -ZEPHYR_MAKE_BIN_OUTPUT =3D "zephyr.bin"
> > -ZEPHYR_MAKE_EFI_OUTPUT =3D "zephyr.efi"
> > +ZEPHYR_MAKE_OUTPUT ?=3D "\
> > +    zephyr.elf \
> > +    zephyr.bin \
> > +    zephyr.efi \
> > +    "
> >
> >  EXTRA_OECMAKE =3D "\
> >      -DZEPHYR_BASE=3D${ZEPHYR_BASE} \
> > diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-
> > openamp-rsc-table.bb b/meta-zephyr-core/recipes-kernel/zephyr-
> > kernel/zephyr-openamp-rsc-table.bb
> > index 5e51c23..8a95b14 100644
> > ---
> > a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rsc-
> > table.bb
> > +++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-
> > rsc-t
> > +++ able.bb
> > @@ -1,9 +1,11 @@
> >  include zephyr-sample.inc
> >
> >
> > -ZEPHYR_MAKE_OUTPUT =3D "zephyr_openamp_rsc_table.elf"
> > -ZEPHYR_MAKE_BIN_OUTPUT =3D "zephyr_openamp_rsc_table.bin"
> > -ZEPHYR_MAKE_EFI_OUTPUT =3D "zephyr_openamp_rsc_table.efi"
> > +ZEPHYR_MAKE_OUTPUT ?=3D " \
> > +    zephyr_openamp_rsc_table.elf \
> > +    zephyr_openamp_rsc_table.bin \
> > +    zephyr_openamp_rsc_table.efi \
> > +    "
> >
> >  ZEPHYR_SRC_DIR =3D
> > "${ZEPHYR_BASE}/samples/subsys/ipc/openamp_rsc_table"
> >
> > --
> > 2.25.1
> >
> >
> >
> >
> >
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#649):
> https://lists.yoctoproject.org/g/yocto-patches/message/649
> Mute This Topic: https://lists.yoctoproject.org/mt/108223015/7579112
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13568748/7579112/810=
16
> 6759/xyzzy [jamin_lin@aspeedtech.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


