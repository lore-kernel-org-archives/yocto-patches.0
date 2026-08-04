Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93317C55ABA
	for <webhook@archiver.kernel.org>; Tue,  4 Aug 2026 21:56:28 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.25])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.27591.1785880582457132304
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 04 Aug 2026 14:56:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OI/9VRVS;
 spf=pass (domain: siemens.com, ip: 52.101.84.25, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OWM+Ln72rytLzIwZ512dXm7Jfl3EdTDqw+MCMEB6p9act0jds8wURE9uog0dSbvNtiEsukn/BFgbHAzcNY0pq/jzfqsWivpPSlNhkR5sTXXY6v7dXrOm1Ho/lbHDZ9PH1MalnrtDW/9qlEoI/z4BiBDx70T4/9o5W5V7nDhaT6yuJugaTQoiGw+Ux6+XT1bmja2DarwF5dry5ZwFAi0nTrpfUIDoIX/phrmtDeDycRidO3jnKCdkyFHMxeVg2VMPaxAu4qIHElyqBqHaSqLPFjUm9Oh5wNUgnHc+M0Z/gLNNevEyVsrdCIIvBmVQx3EhqcIghO3YvyK5/Nls2m+GAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8sC8PEr7p6mmyc0isYc6pv6hBshGxuGUekbwGS2yCM=;
 b=Vqw03QqwZqMgSgA6ssErG9/I3HKnICeLvvqcBzdKW1uAhffj4MbXJWcSrxaabOdGU+HI4uQv/+qM48mtVUIzCZ3KcAN2ED1a8wuGFbMqI3rIiUrboNVwMgSbU313e0yNiWm/0IpVl46Dm3b12pKlhgruKBqTSNAZ8LwJ/FudVNn+3OnME47IEwrx824gWj9N0zKKT7tlbC5GEAceTVJLqMd7hj3kBAvCtJL8nlNHA6DO1acMYru15UD8/KTHHEv1wajBpEUwTWaFxyso4rO6ht3yOyuXM3ef70WQbVDtvyoybLJRRnTlQf4aenZpRWHWZLMwhD9c9fkaMeL8prJs4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8sC8PEr7p6mmyc0isYc6pv6hBshGxuGUekbwGS2yCM=;
 b=OI/9VRVST7iKrz0IirKJ4RpxeiRhiRK+uQcpW82d44IkOL3234FIwn8lAiOLxuFIipxKcDvHwz3HWxlBg+ymyWdF3JhGBvJlRNi8OaLM/wDEFM0gXriwKyhsQovK1XLfzUt+tLWDt9Lf6THS9QI25Tbe89Xh0jd0xW/s89y6PxlibUK/9u/N+MUTBpegwKKUJaJ9ho4jVW7Zyq1QaKCAAQH3cLA8ewrz4vk8mVvoyB+iOLpldkJH15+NdC4M8qT6WyV3GlUh6OTCEQlzlLD5nj6wxALpL+OjZOxhYbGra9a4ooFl7ysKOuB1oIBpaI/jD9C6q6NBqENtDhfz+MxB0A==
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:420::16)
 by DU0PR10MB6680.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:400::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 21:56:18 +0000
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008]) by AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008%4]) with mapi id 15.21.0292.015; Tue, 4 Aug 2026
 21:56:18 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: Scott Murray <scott.murray@konsulko.com>
CC: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: RE: [yocto-patches] [meta-lts-mixins][scarthgap/rust][PATCH 00/35]
 Update to 1.96.1
Thread-Topic: [yocto-patches] [meta-lts-mixins][scarthgap/rust][PATCH 00/35]
 Update to 1.96.1
Thread-Index: AQHdJFb9Y1jRr0W85EScuAnjbvKy7baObAKA
Date: Tue, 4 Aug 2026 21:56:18 +0000
Message-ID: 
 <AS8PR10MB50733593873B3ED9907CF072FDD42@AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM>
References: <18C75C9B3F4EC7FF.1793795@lists.yoctoproject.org>
 <57b8baa1-9c24-b9b1-fcc7-5f4ff8172fdf@konsulko.com>
In-Reply-To: <57b8baa1-9c24-b9b1-fcc7-5f4ff8172fdf@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=8a3057ca-672b-4aaa-8bc3-5b7b6ab2322f;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-08-04T21:43:53Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB5073:EE_|DU0PR10MB6680:EE_
x-ms-office365-filtering-correlation-id: c50f8c62-6e78-47e0-3362-08def273368a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|4022899009|376014|1800799024|23010399003|6133799003|11063799006|3023799007|4143699003|56012099006|55112099003|18002099003|22082099003|10067099003|13003099007|38070700021;
x-microsoft-antispam-message-info: 
 hSGWgiUsOk2tvRMTpJLj2J0J/ZNdrs0AfDh1g7ivVqrOu5rVljac6JjKnXMXT9pktcLotXBtrlTKAbryhZHC4JhlPXqOcgXjDBAKHnvBmwosHDSfs271kb60YV79j9BLFYA9UFBZihBB1DvqJEF4IJUdZfmB7GR38uvkRfuDVNaXmRtpH7g82hgyEtjLgigpMumZt6EPdfW4/mUcWwevXW1qp3H1xpHH+8pUk56W5BEIdcq+QHcHEd1EYPKxJFIFE3LvKrZWdNt3SpTBeniKgIo/u4FwmWvjl60Frp8wt0VzeqO/nNSB4EWZsiob2hydvVg/3UsjTZDsVu30SJqgVnHWNoq7JVGI6X4yMs/2CLnC1YfodaYePCs/41e20UEFPKMoq+gXBLhfdBzLx1zOe45m/4DS6SmWsgGzooUTTi5tVl3dRelCvdp0sjQaMpCWlhKrj39tCCpDnP4+iKOj6bwF2nCzm8JMFrtqpY8gE+I8hgy+JK3adr19M/B4X5SAYFf20gtdN89kcO2gamcu0PhVsr4wdCX6/Wavfs66IdGf84/fkZXEjBdrFNwfM0T/2Tybo+poH5hiCUtrbUX522AdElbjWzykdVHY69P6dXOHCv/4fWDv0kZUzL2EAQBo1OTmRpB96EtJjDeNxTi+bzxxAfibm8RrPvlSq7KpY3TiDXcamcjK0NhNKEPDGDJ5BJCFZO/vzY2BWCiAOfYGjkz76a+HHL8tOYjh31AEqME=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(4022899009)(376014)(1800799024)(23010399003)(6133799003)(11063799006)(3023799007)(4143699003)(56012099006)(55112099003)(18002099003)(22082099003)(10067099003)(13003099007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Cy/fzbKyqV1Pq86518nhlLgVhte0l0tIyf+APThyq0Rj1MpZ+NUT/0gOp5G7?=
 =?us-ascii?Q?x7M+1F/F2BWYihlnG5EElIjZdBgL0MaBYi28g7lkvSfBqTMF8+Nlz/ycI2jX?=
 =?us-ascii?Q?05dN1AB7YvyJW5+JmKOD78eLeMM+xlD3hiRZ3nmBuvC990siwPwImZzvCMsG?=
 =?us-ascii?Q?eOFoGIBVlVgTnf5VQ5O8LiwWL6oc0RW37QEf9Pmtj1HnhIOjoGD1d1LlENuo?=
 =?us-ascii?Q?j0bEzOMTXSlMzAHTKuvqLSbmgeokyorwftduCZaKwaNL2SzYgC4lbIArUlD5?=
 =?us-ascii?Q?7UtusboGLlPUhcR68F3kgn5xXrLTtiDXbYhYCSYYWJDda1VIL1s4CToS/8Zl?=
 =?us-ascii?Q?DYqHSvE5uLJnRGT+ZhxoJGJmwtXI8Y3ZHqYKfNRKrrvEt1y8voZkib9CJscG?=
 =?us-ascii?Q?qBQUP7IC0+7ud/1ZyBNMA7W+wBRubrxv9AOGtrWZ74jR6+Hpc/F9/yoNeCSn?=
 =?us-ascii?Q?0p6iQ6UQPGd/2w8H8foIHcjFldvpRoeLnmtvDy3D9LHTaQjwPt66j2S17m0M?=
 =?us-ascii?Q?ulMyecidmZmsBxqAUacZUFKx0EsvFj3Yg34Vg0SzeKeR4jzVuzwjWb/T3i86?=
 =?us-ascii?Q?rgbvcFrRcZul0iT7cZ9d//NfyQhJ9cxYE67Wxo+5+1WM0HHbVOF5p/x+E+Rm?=
 =?us-ascii?Q?zmNEQSGS3hG0CaPfSWUxu5Q/WodMSDA87vo4+mzgUNrINVN/y5bUh51H4+vj?=
 =?us-ascii?Q?QhBCT5xyipCuc3083t0dV7V+7q8DNLIRCejWl78pIvYwBgCeGkeLVkue2th6?=
 =?us-ascii?Q?XjFCBPfEwHc5d5yOSm/aN1m0Hn4zmJXfM34eJcDHzxxmJ+tE35/N3/YL4+y0?=
 =?us-ascii?Q?jRh3Kh4SYdLjAulkHhpBxMrpR4I+4Zd2vt0EmBCTQcN4r0t/b1bYPmxUXBtt?=
 =?us-ascii?Q?MY+viIsm7+VHHDPBTiN812wPP93tFhAtdNBhIaULGZGqrpZn4/qEkvCp4wZI?=
 =?us-ascii?Q?DCo//KTAlbyP2fRjsXIFoWfra53qbKCPPrzPl56Kx6Di/jgPOI4X8Jk7O1uR?=
 =?us-ascii?Q?aPxh47++tnuynaKJzXi9FiStmfwoIzxtIvLYG3ZqihB8gie0oSpjIQmC+GV8?=
 =?us-ascii?Q?AyWHj6etl6PPveFFxGwjZe4YSwVSO68IZCN5QdsPC5VnSV0Cmugn/HfEA/js?=
 =?us-ascii?Q?CVIBWLVElxuxETshWPdDrGsLnHtda6bRcM0Qtwz0pdTZi6sJxpGdY/trh8mK?=
 =?us-ascii?Q?AhZIBZEQWjAqzHsGzEhCuz8E1y/QgawiI5AwBAsTubnnEOYfArBoVJEQbdjj?=
 =?us-ascii?Q?NzWjI20SMyr61SB0t7QLuQoOZeSRt77DobLFiFygaEQjYTmMSg+6LgTCDyb1?=
 =?us-ascii?Q?7lWke9w5064zwq8Br3mrV8jLKDC4A4Q89GS/N/7Ug4WZMESiJOaYFemosYoX?=
 =?us-ascii?Q?0SNQ5LJb6YTwKYuMGYWaG7ogdwNl5oY4bhKak9Xx6eLj1lBdfzfRDxMcvTCy?=
 =?us-ascii?Q?kZgH87WMESbDJKGdit1zE7k6provG8D4nedg1++5J+A6/9d2nc2FXo23t2qO?=
 =?us-ascii?Q?wFOvJaySltSj5eC5Xi2S2+Tl4r7vKvk2iOgVbk4NEPsZ4o6iKSBvYUWs9D89?=
 =?us-ascii?Q?Z3kge6XGgalQC4x2BsN6SIvdvi12ck8xYy/9L81gakai36k6PtbjqIdnhGme?=
 =?us-ascii?Q?NCBS+WLUSa4v/jY5R7rtZEWh5FHp1eRlkGJJKXQ3r0+G0nerVdmxdYDxY46g?=
 =?us-ascii?Q?4cJKQvhGRltbAv9NqbbQUloLUrC5ZWt/ZKcLzqTYp7UKY7dEJmErxQA/yBB8?=
 =?us-ascii?Q?w5PGNSwoiQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c50f8c62-6e78-47e0-3362-08def273368a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 21:56:18.2998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aX/eatsGofZ4SMPjbKpfgkhuXMszr6C8VNbTpxB69/xJCBAHnzZNxJriM2xAMxZUFy0I0+OJG/aPY2++erGcDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6680
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 04 Aug 2026 21:56:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4626

Hello Scott,

this update puts scarthgap+mixins ahead of wrynose.
I think I'll update to a commit somewhere between the 1.94.1 and 1.95.0 bum=
ps to cap our scarthgap at wrynose level.

Are there any plans for wrynose mixins layer so we don't fall behind there?

Peter

> -----Original Message-----
> From: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproj=
ect.org>
> On Behalf Of Scott Murray via lists.yoctoproject.org
> Sent: Tuesday, August 4, 2026 11:19 PM
> To: yocto-patches@lists.yoctoproject.org
> Subject: Re: [yocto-patches] [meta-lts-mixins][scarthgap/rust][PATCH 00/3=
5] Update
> to 1.96.1
>=20
> On Fri, 31 Jul 2026, Scott Murray via lists.yoctoproject.org wrote:
>=20
> > This patch series for the scarthgap/rust mixin layer backports the
> > recent Rust toolchain changes in oe-core master branch to pull in
> > the 1.92.0 -> 1.96.1 updates and other fixes.  Note that due to
> > scarthgap not having the later clang integration some changes
> > related to an issue with sstate reuse across hosts with different
> > toolchains ([YOCTO #16058]) are not really viable to backport with
> > this mixin.  I have not confirmed whether the issue exists with the
> > rust-llvm toolchain used to build Rust in scarthgap, if you do
> > encounter a similar issue while using the mixin, please let me know.
> >
> > I intend to merge this series to scarthgap/rust by end of day Tuesday
> > (August 4, EST) unless a serious showstopper is pointed out.
>=20
> These have now been merged to scarthgap/rust.
>=20
> Scott
>=20
>=20
> > Changes:
> >
> > Alex Kiernan (1):
> >   rust-target-config: armv8a AArch32 Thumb build fixes
> >
> > Alexander Kanavin (1):
> >   librsvg: upgrade: 2.62.2 -> 2.62.3
> >
> > Changqing Li (1):
> >   librsvg: move symlink file for ptest in package librsvg-ptest
> >
> > Deepesh Varatharajan (9):
> >   cargo-c: update 0.10.19 -> 0.10.20
> >   rust: Upgrade 1.93.0 -> 1.94.0
> >   cargo-c: Move recipe out of rust directory
> >   rust: Drop revert-link-std-statically-in-rustc_driver-feature.patch
> >   rust: Drop oeqa-selftest-Increase-timeout-in-process-sigpipe-ru.patch
> >   rust: Fix flaky assertions in oneshot tests
> >   rust: Upgrade 1.94.0 -> 1.94.1
> >   rust: Upgrade 1.94.1 -> 1.95.0
> >   rust: Upgrade 1.95.0 -> 1.96.0
> >
> > George Refseth (1):
> >   cargo_common.bbclass: add subdir argument to git dependency to let
> >     cargo find crate
> >
> > Harish Sadineni (1):
> >   rust: install Rust library sources for 'make rustavailable' support
> >
> > Hemanth Kumar M D (1):
> >   rust: Upgrade 1.92.0 -> 1.93.0
> >
> > Jesse Van Gavere (1):
> >   rust: export CARGO_BUILD_TARGET
> >
> > Khem Raj (2):
> >   rust: Fix build with llvm-22
> >   rust: Fix loongarch unit test with llvm-22
> >
> > Martin Schwan (2):
> >   cargo-update-recipe-crates: Don't fail for partially empty Cargo.lock
> >   cargo-update-recipe-crates: Properly close target file after writing
> >
> > Peter Marko (2):
> >   cargo: set status of CVE-2023-40030
> >   cargo: set CVE_PRODUCT
> >
> > Peter Tatrai (2):
> >   rust: fix codegen test failure on big-endian targets
> >   rust: backport explicit-tail-calls test skips for unsupported LLVM
> >     targets
> >
> > Ross Burton (9):
> >   librsvg: remove obsolete .la deletion
> >   librsvg: consolidate DEPENDS
> >   librsvg: consolidate PACKAGECONFIG
> >   librsvg: rewrite cross gdk-pixbuf-query-loaders handling
> >   librsvg: remove dependency on liberation-fonts
> >   librsvg: add PACKAGECONFIGs for avif and gdkpixbuf
> >   librsvg: upgrade 2.61.3 -> 2.62.2
> >   classes/cargo: fix indentation
> >   classes/cargo: remove BUILD_MODE, replace with CARGO_PROFILE
> >
> > Sundeep KOKKONDA (1):
> >   rust: Upgrade 1.96.0 -> 1.96.1
> >
> > Taruntej Kanakamalla (1):
> >   cargo_c.bbclass: pass --libdir to cargo cinstall
> >
> >  .../cargo-update-recipe-crates.bbclass        |  19 +-
> >  classes-recipe/cargo.bbclass                  |  22 +-
> >  classes-recipe/cargo_c.bbclass                |   1 +
> >  classes-recipe/cargo_common.bbclass           |   3 +
> >  classes-recipe/rust-target-config.bbclass     |  34 +-
> >  conf/layer.conf                               |   2 +-
> >  lib/oeqa/selftest/cases/rust_mixin.py         |   3 +-
> >  .../{rust =3D> cargo-c}/cargo-c-crates.inc      | 434 +++++++--------
> >  ...Use-libc-SYS_futex_time64-on-riscv32.patch |   0
> >  .../cargo-c_0.10.20+cargo-0.94.0.bb}          |   2 +-
> >  .../rust/{cargo_1.92.0.bb =3D> cargo_1.96.1.bb} |   4 +
> >  ...teps-tool.rs-switch-off-lto-for-rust.patch |   4 +-
> >  ...-build-failure-with-unstable-options.patch |  63 +++
> >  ...xplicit-tail-calls-disable-two-tests.patch |  39 ++
> >  ...lls-ignore-tests-on-unsupported-llvm.patch |  96 ++++
> >  ...crease-timeout-in-process-sigpipe-ru.patch |  31 --
> >  ...d-statically-in-rustc_driver-feature.patch | 229 --------
> >  .../rust/files/rust-oe-selftest.patch         | 115 ++--
> >  ...ibstd-rs_1.92.0.bb =3D> libstd-rs_1.96.1.bb} |   0
> >  recipes-devtools/rust/rust-cross-canadian.inc |   1 +
> >  ....92.0.bb =3D> rust-cross-canadian_1.96.1.bb} |   0
> >  ...-llvm-allow-env-override-of-exe-path.patch |   8 +-
> >  ...ust-llvm_1.92.0.bb =3D> rust-llvm_1.96.1.bb} |   0
> >  recipes-devtools/rust/rust-snapshot.inc       | 102 ++--
> >  recipes-devtools/rust/rust-source.inc         |   7 +-
> >  .../rust/{rust_1.92.0.bb =3D> rust_1.96.1.bb}   |  19 +-
> >  recipes-gnome/librsvg/librsvg-crates.inc      | 498 +++++++++---------
> >  ...ld-do-not-force-disable-gdk-pixbuf-l.patch |  49 --
> >  ...append-RUSTFLAGS-to-rustc-executable.patch |   2 +-
> >  ...e-care-of-deprecated-assert_cmd-Comm.patch |  10 +-
> >  .../{librsvg_2.61.3.bb =3D> librsvg_2.62.3.bb}  |  30 +-
> >  31 files changed, 912 insertions(+), 915 deletions(-)
> >  rename recipes-devtools/{rust =3D> cargo-c}/cargo-c-crates.inc (72%)
> >  rename recipes-devtools/{rust =3D> cargo-c}/cargo-c/0001-parking-lot-U=
se-libc-
> SYS_futex_time64-on-riscv32.patch (100%)
> >  rename recipes-devtools/{rust/cargo-c_0.10.19+cargo-0.93.0.bb =3D> car=
go-c/cargo-
> c_0.10.20+cargo-0.94.0.bb} (87%)
> >  rename recipes-devtools/rust/{cargo_1.92.0.bb =3D> cargo_1.96.1.bb} (9=
7%)
> >  create mode 100644 recipes-devtools/rust/files/0002-Fix-rust-build-fai=
lure-with-
> unstable-options.patch
> >  create mode 100644 recipes-devtools/rust/files/0003-explicit-tail-call=
s-disable-two-
> tests.patch
> >  create mode 100644 recipes-devtools/rust/files/0004-explicit-tail-call=
s-ignore-tests-
> on-unsupported-llvm.patch
> >  delete mode 100644 recipes-devtools/rust/files/oeqa-selftest-Increase-=
timeout-in-
> process-sigpipe-ru.patch
> >  delete mode 100644 recipes-devtools/rust/files/revert-link-std-statica=
lly-in-
> rustc_driver-feature.patch
> >  rename recipes-devtools/rust/{libstd-rs_1.92.0.bb =3D> libstd-rs_1.96.=
1.bb} (100%)
> >  rename recipes-devtools/rust/{rust-cross-canadian_1.92.0.bb =3D> rust-=
cross-
> canadian_1.96.1.bb} (100%)
> >  rename recipes-devtools/rust/{rust-llvm_1.92.0.bb =3D> rust-llvm_1.96.=
1.bb} (100%)
> >  rename recipes-devtools/rust/{rust_1.92.0.bb =3D> rust_1.96.1.bb} (95%=
)
> >  delete mode 100644 recipes-gnome/librsvg/librsvg/0001-Revert-meson.bui=
ld-do-
> not-force-disable-gdk-pixbuf-l.patch
> >  rename recipes-gnome/librsvg/{librsvg_2.61.3.bb =3D> librsvg_2.62.3.bb=
} (79%)
> >
> >
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#4625): https://lists.yoctoproject.org/g/yocto-
> patches/message/4625
> Mute This Topic: https://lists.yoctoproject.org/mt/120532672/4454441
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-
> patches/leave/13703729/4454441/683413657/xyzzy [peter.marko@siemens.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


