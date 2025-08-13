Return-Path: <chee.yang.lee@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD668CA0EDC
	for <webhook@archiver.kernel.org>; Wed, 13 Aug 2025 03:05:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mx.groups.io with SMTP id smtpd.web10.92736.1755054329179998002
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 12 Aug 2025 20:05:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=D0pks8Ma;
 spf=pass (domain: intel.com, ip: 198.175.65.9, mailfrom: chee.yang.lee@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755054329; x=1786590329;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=53DuzRvW9srLrPUb1ONl20ST9mFFWvm3PojT0Br5gJg=;
  b=D0pks8Maz4rQpiXXPD08oy2Vo+dOZc5BUERPDaL64t0pWwj96f6G5CtY
   apJn/16DL1KARoww9zdOYLyIsRJLk/pjEVZ8QwTbxJNrsydJg9ybpFyrc
   Er7LNAxpLBl+f4M6X0PHspdC84mzj0R/0zMJCRDL2YHClX3aYQqW2ftn6
   iv4sYiAUxb69W5wF2y5dbxaXQKzxESIdj+1XyKf2GpxnRR1BvMuVsMjaa
   5RygrACPT4TUw7ho+0MtNfGY8Iq4wJPfs3uIrd9ndUE4QYgGHkAFUuZIf
   bHwv4e9Gu9eO4M0DeGQJAdiDwlvAlAKiGtg7UUcJ5pplMovTBYt2Vlwg6
   g==;
X-CSE-ConnectionGUID: FIo12AOuSPCikjSzGoqPiw==
X-CSE-MsgGUID: kJiFbpqdRia/+zbvpOatag==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="79911833"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="79911833"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 20:05:28 -0700
X-CSE-ConnectionGUID: q3PkcCYMQ+2GlDYoNlcbaA==
X-CSE-MsgGUID: 5jnrZiTWTmmGe6JfzgQktg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="170555804"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 20:05:28 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 12 Aug 2025 20:05:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 12 Aug 2025 20:05:27 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.53) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 12 Aug 2025 20:05:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/Hhf/Kgs8ZniP7i1M7rLXZQm9N3rcQpecDDeeSgHRPZHIbTtEy90hw4y0QPxvu/JXf142l9MuPR8kUci8OwX9ouVVHp8DL7GHl1+HPMxjWhQTGytvimsbbA3GRuBO5BTDDpvVBrCvU94lFayOGtmOXkstmvtT0qCauGQ17qm/X1B6HNjYcb51I/zomdZnbpJZ7ounHzJBnYoolJaq1y2DARP6KpIcVkRdOul/+WkJhpKxQJyKJa9iQj+VaLGen7Tn/SuTUZ1I7gMt2qflnkzu20Tk51aYXYxtD2o9eyLwiIVUn8UoHvBzPPTK/0xwHN53zrjgTvXNQUbCSQ49Q2qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeX2D2H+dyFP9wzy6MQorOV2+e2MX4i6t2NskD0m1ng=;
 b=yfE+b3x5ozHfnJpri/zgLkeOX3MldB0fqrQ5v1k0ZymgL2urYMxG9t7vteabadN2cuTXQWWIgmOwsCMHunhki+2Ydw7i5nmMvUonNRzq7XjrVza+FYjZq6em6mC6yrIa1bstBLIUgYcNHIm8CI68j1lrSfCIwPQ5i9IDXswJTkBGSy2ZPBfGBU8bIow6EM7e4LGH0zlg8nDVQ/EeujBjmLEcPqkt2hQ+qgoVGAJx/6mfN8pTP8gT7W1kGicdmXkhIeqN98uHsHInpBulr4AOSw8ofc7fNzyAxedUaTOFmFuF2gR2k5glMvxvhUQr3Gn1t7ohZIQIr1wJ/AdcUIbPWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL4PR11MB8797.namprd11.prod.outlook.com (2603:10b6:208:5a7::8)
 by DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 03:05:24 +0000
Received: from BL4PR11MB8797.namprd11.prod.outlook.com
 ([fe80::311e:565b:ccfd:f4c8]) by BL4PR11MB8797.namprd11.prod.outlook.com
 ([fe80::311e:565b:ccfd:f4c8%5]) with mapi id 15.20.9009.021; Wed, 13 Aug 2025
 03:05:24 +0000
From: "Lee, Chee Yang" <chee.yang.lee@intel.com>
To: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>,
	"yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Subject: [meta-zephyr] RE: [scarthgap][PATCH v5 0/12] 
Thread-Topic: [meta-zephyr] RE: [scarthgap][PATCH v5 0/12] 
Thread-Index: AQHcC7Bu9BbOmNNoxE6WpzP0RYoxO7Rf5tYA
Date: Wed, 13 Aug 2025 03:05:24 +0000
Message-ID: <BL4PR11MB8797F8BB0A6FB4FBFE498DB7B92AA@BL4PR11MB8797.namprd11.prod.outlook.com>
References: <20250812174147.130972-1-sandeep.gundlupet-raju@amd.com>
In-Reply-To: <20250812174147.130972-1-sandeep.gundlupet-raju@amd.com>
Accept-Language: en-SG, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR11MB8797:EE_|DM4PR11MB6020:EE_
x-ms-office365-filtering-correlation-id: 3270c43b-d828-4c5e-76ae-08ddda163f96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?w4K8zgZSjP1xvhLn6D8EtRooajxFW+S5BdsdcCV+nv9Xxi06o3w+9sNKTITT?=
 =?us-ascii?Q?fz9HkOqKgFHeMXOyNgGh79SYXD5a+BJtUsEZGDwO7P2yykpqfs3ZvRx60d/b?=
 =?us-ascii?Q?UrmC7mQbcqDJ15xCQ530Bb6JKHce8hde9kQpI/llZzsIs2uf1vLpZatI1Ho3?=
 =?us-ascii?Q?H9UIC2MAdpFg+kVL1TZBxgenUxcPGL5BnHvO4/J6R4tQHCKfSrEXW3tapthR?=
 =?us-ascii?Q?DLmUojlw3qUPS48gGdw72vAKa7mpmSn1tb2siCxLw7XTuL1nHMweMTc+EPur?=
 =?us-ascii?Q?YgPNDGoEfWgSpYEEqT9cZerNBei1MgBOgUsufFe+sBpXIIYNBdGqsqdZgohn?=
 =?us-ascii?Q?WatraB+rBEEPkSf7BCcIDId5oSRaRug9lwtaFYekkDI5QWaFLFAWgm8nPL7u?=
 =?us-ascii?Q?rxCwUa/MeTFBnHSyVwGuDgUM6jUzGmHFOSXrAyP6btlWX77Q21xSONihRb2/?=
 =?us-ascii?Q?5HTrHif9PUJbpzV8JESHT1kRWzV5XmLsVYGwIA7HnUDZzWrw3SRdIhMf35HF?=
 =?us-ascii?Q?8PnFGsOT/VGEzGa5mJ2QPZcXLgAxGARnlgci7ejCDpskSkfYw964fsw+yB2q?=
 =?us-ascii?Q?+wXTbjKe/7NcorXsfBm9tB7fIe6zENh0+/JZjhZftjLuXTCosUYoGNqahMRY?=
 =?us-ascii?Q?mYSwrRKHtzzrwf0VZ1EcBxN4CLQcgQEl2J7MFGpG3PwjyRRJb9Hfj5gxRiQ3?=
 =?us-ascii?Q?NDZVXDKsz/xBJNk9CtMtyylsqUZ9lXOkjzBYNkv5BkvNUfECmBrt8oemXWkB?=
 =?us-ascii?Q?FkS1omC0wYXuvlHZsVyJ42UgCRceKi7piNLO2I5eCsQAA2waBI1saBH/tTXI?=
 =?us-ascii?Q?TKdL9b07WCx3I3X8igTCw1BrLOJrG3vOHARvHNxSG5wLGFj6yxKLMzesjkOq?=
 =?us-ascii?Q?auoQNLPZe19BnsL4X8/tG5ZgHH9Tjh18bY9F7x7LBZ1+lRHi99o3FEZNtavy?=
 =?us-ascii?Q?F4T48ztnRvLBSs++FwNZWYAlWvxPgbXDASmCrgimQGoLFVIW8xT/6LJm0d1R?=
 =?us-ascii?Q?uogQ5mI9RCAPk8DoTOhgq8EufyP2o+UED2QXzcKmKQ2iZIWYDnQtdy2LR2xd?=
 =?us-ascii?Q?Xtc6h4GirgoRo9MJFTYLEYH6l86dq3vtqUXMYYx/zJWACYLZ1Bz9jXObxb8u?=
 =?us-ascii?Q?+v/A+zeoLsnxLY5D5HsOM9iu4zal55o3aanWzArT+918nb0ETPUzQixdze0Y?=
 =?us-ascii?Q?TWp90TAMZoaGTDunZrOCbAxFn7iRrePUTbmZF3RPV/xpgy/W/fOaIez87dNc?=
 =?us-ascii?Q?5PxMAcJ3dBACi1pzjbRmyCw+WsggBJDAa8tD4ZIBJJgCehWHmjzSTzrXovbs?=
 =?us-ascii?Q?bU8nOFIHlt0ZW37OMgj4Ni9VsHbK6Igf+6uu0TIfd5AaU+/aW+AXVeKdgF+d?=
 =?us-ascii?Q?/cfMfWhMhdWykXv6xLOxUQWEj2mdWyLMMSS0/bWJ6ihkLTCumD0crJfzAii4?=
 =?us-ascii?Q?YZz1QteAe8TkssC7Xs3C5cQtw4cAc8s6ia1FeviBtcBEB+dOL6Sc5g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR11MB8797.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uVf1XVyRm495JapaJdEkdrexUJcM7nmISH1klQj2rcl4lNVwN2ckvo+oOdJK?=
 =?us-ascii?Q?ELmcdDOU3rjlCopYgETB/77tAGTQKhwvccLf1AjGz5bavok86UkqSykoCajT?=
 =?us-ascii?Q?iUU5nBdQzW1XvPtJ0VqDVczbLJumgZnOI7E3VngqkD8FcP7b5AZwkP8oyvEd?=
 =?us-ascii?Q?Wv4mOoNrW2g7BrFbwXfqjewP9p/JzABpSL6onzXfmEdVWPMtU9Y+4lw+fAFf?=
 =?us-ascii?Q?mnBGqjrICYsCiDkhzLVrQtKuUllX+24gnw7iUsFFWl9hUoHliA9YaIeyYOYr?=
 =?us-ascii?Q?gGzFddk3l3FdAwq8pDd4wnB/oL9v0Dc/QPaHq6tKsaTpJeHAFxNLr89d2tKi?=
 =?us-ascii?Q?Yd6lTKtHSWEeS7ibTWNlv1mF0fT9qCmxmygeIxwUvQgrHh+wHAtZvD+05hiB?=
 =?us-ascii?Q?dossWNlAPqPkMIbdefqDMilREeXQXrMQkXtzPN4s6/+0luejN1Lzd3SZH9h5?=
 =?us-ascii?Q?LUppTs7VbNoE7oD5hl56wEc7Rh9vVMutJXvk2oZHipuf21/iiR7n83amSo3f?=
 =?us-ascii?Q?Qn0Dq1LQ1rONwMY1D15vQUP44ruTvb1XeAAiNG7dT0El8aCdq9rEEHa+ea43?=
 =?us-ascii?Q?0hKLpbstfan+bCXQ+MDIxEdRtEr/SNs+9K9/g14CuuemW+rLd+yiy7xPajji?=
 =?us-ascii?Q?1N/lGJqjGP8kesrXkvk7WEQrbdzbqv85LJG7Jcr91SN3uipSuNodkEnd1LWN?=
 =?us-ascii?Q?T9sdcT/tRhDlwNX2mUljeGE4qhC3oWs6BmZIZaMFF15TbOCC3bDJ5lbEQVbo?=
 =?us-ascii?Q?t5Mrx+hXjdnUaE9l9nFQLJEB88BzooBOMPfmmoBsZqYFM+IOBM6Y8SMqdDcV?=
 =?us-ascii?Q?cNPDQrKdM6Uq2c1wyqlSihoYG8KuE/ch9ooD+HkLl0AcVvTwHm8Pyu3CQM9G?=
 =?us-ascii?Q?kdCLjA2snXsB1W5QQLI15QcPGRDk7CPssaiDdyvnmNkZ5bylmdpNTBLn2BRX?=
 =?us-ascii?Q?0tkOVDVXkU1ta/7oY1RTCfjnXg36IZahQHzEEm0jj8LCGM73Q0pxtZOz4bsb?=
 =?us-ascii?Q?qMQW1wpcYwQiwWni3ETXtM/BsB8ZCAraIiH1efCrS05aBq42cFU+oAS3RaBd?=
 =?us-ascii?Q?RIP76bME1E7DFr3384SPUVKtsqjutWxfzAEKwUHiQ+dZo4dVSt/DqpRFHgml?=
 =?us-ascii?Q?IDSqYf2SNBoxEa0MYVJt/z/npMzN2aa0Kj6qutTGW2PcBXNRKL/DyE/VSl+u?=
 =?us-ascii?Q?eAYIrMptJGAjrsIRINN/Qq+JjKg0QRTym0uY/BCtNcguif2KyOl+MAAksBCk?=
 =?us-ascii?Q?RL9Kk5A40j/5p4mFhmzU8sx3SFkrguKQZuXxGJcqNhqV6GdVVAxyUEXwVRv9?=
 =?us-ascii?Q?VSiTV75kxlGdIFD1glGK2VTm+rixAIV/3AXWaJC26sKIb6F9QnfJ4L9cOSRr?=
 =?us-ascii?Q?2BPisM9CGLXeqDIhy1xqzzAhV/cjzxlLFQ2LZuwoC9lXJcd64sViDDm+8pb6?=
 =?us-ascii?Q?AopmkLzfjNg1ImCs/+Pgz7G+Pr0oeq4NnZ0+2GCW2vTg5arzeC7HYeATq1ls?=
 =?us-ascii?Q?pg/n8XS0C9yXTk/un7kpiTmJyI2o7KjzdT86MJJxjprPC6P1R7pQ4JAIPJnM?=
 =?us-ascii?Q?kBMQSB4F2PCWbJ3LG++XVmeVM50+xxJN7UMtF8+x?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL4PR11MB8797.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3270c43b-d828-4c5e-76ae-08ddda163f96
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 03:05:24.6932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yA80O1xTisu8U4Vs970gdE71nM3Tg2QNvJA0VgSkAH+8iesvak4rDaUGhb+G1UGAF/fPnLXPGtZ6WSaNbzclBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6020
X-OriginatorOrg: intel.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 13 Aug 2025 03:05:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1974

Hi Sandeep

Thank you for the patches.
I think some of the refactoring patches ( 5, 9, 10 ) and patch 11 which add=
 new recipe should apply to master first before backport to stable branch.
There is conflict when applying the same patches to master branch, would yo=
u be sending updated patch for master branch ?=20

Chee Yang

> -----Original Message-----
> From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
> Sent: Wednesday, 13 August, 2025 1:42 AM
> To: yocto-patches@lists.yoctoproject.org; Lee, Chee Yang
> <chee.yang.lee@intel.com>
> Subject: [scarthgap][PATCH v5 0/12]
>=20
> Changes in v5:
>    - Fix typo in zephyr-openamp-rpmsg-multi-srv recipe.
>    - Merge below commits into single commit.
>      [meta-zephyr][scarthgap][PATCH v4 3/13] zephyr-kernel-src: Remove
> PREFERRED_VERSION_zephyr-kernel
>      [meta-zephyr][scarthgap][PATCH v4 4/13] layer: Set PREFERRED_VERSION
> for kernel and sdk
>=20
> Changes in v4:
>    -  Fix below patch commit message typo.
>       zephyr-kernel-src: Remove PREFERRED_VERSION_zephyr-kernel
>=20
> Changes in v3:
>    - Add Board extension support variables.
>=20
> Changes in v2:
>    - Move classes to match bbclass scope functionality.
>    - Use relative path to follow best practice.
>    - Convert zephyr-sample inc file to bbclass so that it can
>      be inherited from custom layers to support out-of-tree
>      zephyr applications.
>=20
> Description of change:
> 1. Fix runqemu errors for qemu-cortex-a9 machine.
> 2. Add new inc file and update to 0.16.9 version for scathgap 3. Remove
> PREFERRED_VERSION_zephyr-kernel from zephyr-kernel-src and
>    move to layer.conf
> 4. Add image artifacts to output files and use these files for qemuimage.
> 5. Add Zephyr LTS3.7.0 support for scarthgap release.
> 6. Update README files.
> 7. Move classes to match bbclass scope functionality.
> 8. Use relative path to follow best practice.
> 9. Convert zephyr-sample inc file to bbclass so that it can
>    be inherited from custom layers to support out-of-tree
>    zephyr applications.
> 10. Add rpmsg multi services recipe for openamp.
> 11. Add Board extension support.
>=20
> Testing:
> Run the following commands.
>=20
> $ MACHINE=3D<machine-name> bitbake zephyr-helloworld
> $ MACHINE=3D<machine-name> runqemu nographic
>=20
> CI Build Information:
> MACHINE:
> BOARD:
> BOARD_VARIANT:
> IMAGE:
> PLNX_BUILD:
>=20
> Summary of changes:
>=20
> meta-zephyr (scarthgap):
> Sandeep Gundlupet Raju
>     zephyr-kernel-common: Add Board extension support Sandeep Gundlupet
> Raju
>     zephyr-kernel: Add rpmsg multi services recipe Sandeep Gundlupet Raju
>     classes-recipe: Convert zephyr-sample inc file to bbclass Sandeep Gun=
dlupet
> Raju
>     zephyr-kernel: Use relative path
> Sandeep Gundlupet Raju
>     meta-zephyr: Update README files
> Sandeep Gundlupet Raju
>     zephyr-kernel: Add Zephyr LTS3.7.0 support Sandeep Gundlupet Raju
>     zephyr-qemuboot: Use image artifact file in qemuimage Sandeep Gundlup=
et
> Raju
>     classes: Move classes to match bbclass scope functionality Sandeep
> Gundlupet Raju
>     zephyr-image: Add image artifacts to output files Sandeep Gundlupet R=
aju
>     zephyr-kernel-src: Remove PREFERRED_VERSION_zephyr-kernel Sandeep
> Gundlupet Raju
>     zephyr-sdk: Add new inc file and update to 0.16.9 version Sandeep
> Gundlupet Raju
>     qemu-cortex-a9: Fix runqemu errors
>=20
>  b/README.md                                                             =
                                                  |  163
> +++--
>  b/meta-zephyr-bsp/README.md
> |    5
>  b/meta-zephyr-bsp/conf/machine/qemu-cortex-a9.conf
> |    1
>  b/meta-zephyr-bsp/recipes-meta/meta/generate-zephyr-machines.bb
> |    4
>  b/meta-zephyr-core/README.md
> |    6
>  b/meta-zephyr-core/classes-recipe/zephyr-qemuboot.bbclass
> |    6
>  b/meta-zephyr-core/classes-recipe/zephyr-sample.bbclass
> |   10
>  b/meta-zephyr-core/classes-recipe/zephyrtest.bbclass
> |    1
>  b/meta-zephyr-core/conf/layer.conf
> |    4
>  b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk.inc
> |    3
>  b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb
> |    4
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/files/0001-3.7-x86-fix-e=
fi-
> binary-generation-issue-in-cross-compila.patch |  106 +++
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-blinky.bb
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-coap-client.bb
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-coap-server.bb
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-echo-client.bb
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-hci-uart.bb
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-helloworld.bb
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-http-client.bb
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
> |   28 -
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.inc
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-3.7.0.=
inc
> |  274 ++++++++++
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test-all.b=
b
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test.bb
> |    4
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-lvgl.bb
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-mqtt-publisher.bb
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rpmsg-
> multi-srv.bb                                         |   23
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rsc-
> table.bb                                               |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openthread-echo-
> client.bb                                          |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openthread-rcp.bb
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-peripheral-esp.bb
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-peripheral-hr.bb
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-philosophers.bb
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-synchronization.b=
b
> |    2
>  b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-websocket-
> client.bb                                                |    2
>  meta-zephyr-bsp/README.txt
> |    1
>  meta-zephyr-core/README.txt
> |    1
>  meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
> |    4
>  meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.inc
> |    5
>  meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-sample.inc
> |    1
>  41 files changed, 599 insertions(+), 95 deletions(-)
> ---

