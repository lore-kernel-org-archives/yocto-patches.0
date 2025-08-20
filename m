Return-Path: <chee.yang.lee@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C80DCA0EED
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 08:04:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mx.groups.io with SMTP id smtpd.web11.14906.1755677038974685708
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 20 Aug 2025 01:03:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=S3k9BH2w;
 spf=pass (domain: intel.com, ip: 198.175.65.15, mailfrom: chee.yang.lee@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755677039; x=1787213039;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=9NMxZR1MVIbsbaw08ct8NdvKJlCJakTcR+GoIk/dCf8=;
  b=S3k9BH2w9U5788WjohLdacruxgFRUIhf3Ytp0NdXTpMA7baMQhdJjASt
   GB8JKYLgDqymNM5XVYxvv86HBtGk4MbUE1peVMZMgRIQAeonm1FPpbpwt
   Fn7sNOY9o+CHcLUQ5xthGR9Puq5sO0Tr1u07cubxAjhw+w6z93VXXmr2Y
   EERbPB163y7H9fVTCbKIyuL7SSXZukPx2BvOsRuFH2YtSXYzoEhuZnbvh
   3lgukcR9VqaZsb93ouE0Yz1PDWiL1IfeYCltBi4k8SDGO71ZRedYkikCZ
   xjXLm+8NyU/B/IGeU3uJWDZIpjZB1rf4M3hDsH69Pq4F22HV2n4qJRGYh
   Q==;
X-CSE-ConnectionGUID: jRYZrnINQDO/wVtAbmAtTQ==
X-CSE-MsgGUID: 1V4ShPLnQhq4Lnt2yGhleg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="61573034"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="61573034"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 01:03:59 -0700
X-CSE-ConnectionGUID: Ehe+05FgQqm0uCjDO71gCw==
X-CSE-MsgGUID: dmPgIFLWQK6pel4v9TAY3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="167251039"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 01:03:58 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 01:03:57 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 20 Aug 2025 01:03:57 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.56)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 01:03:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIy4f54H6+YPaGQy5cCvSPK3WPkaTJEZvsx7zJOkCqRYa2YJZS4Y7j3ePekUW44+b4+BUYO42oax13D6uEHcP5ksbxF8UPjsR4TXofodTfU0XsoPz6CxXZcfQzsDM3hKKuM6XO/hqTIjgWIMCkF6eF7Qv02IUrsxe/sVssZ3wf1cWZCmPfSOF/1sS6b5DQmQI5kFIKXF7cdWlD8LsUr0qCjnD66gPj1zyg5mqPzRJe0Pt4W7vzqu9O09WwXSE1Q2GPC8riv6MVIa8KVWLu4+hsJwfpzHxsJCIJeROm6Lgiw30PbahqdMAlA9ZOO+COVu14epdKBWLGw6IpROGfGBSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJ18J4+RKQGIGpV0g2KEUCdAIXQg8owCvt19CjlQhVw=;
 b=j0c7+FuZQgmE3Fq5MM2p2bYBv6SPipXzKIu8rt5+KkNG3Dr01ebkJEGgkNxC1MgGWCuBmVeiUbdawgqB55QORSb0HjsK9ZCKn0fhBXLWVg2PtTv8OgT/VmgjReHtIgCbkQSUgTNFJu4jQ+auMyKQmsNVO1dV+AomeKTnRYc3usbWuG7LiulmRrdFkE7gbaCKhHr5ImwDRMnJKX6zLUQr/ofKe8BicdXDAZ0AB11zdgCdAm8XnHx4yP5u2CY4HfxZh07xox3xfw7HSgRUUgoK4P6T8Oop/BM8ZKRijGDBNCvyck/sNRSxUgUimm9UkmXSN75amenF9juVJwEhZx288w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL4PR11MB8797.namprd11.prod.outlook.com (2603:10b6:208:5a7::8)
 by IA1PR11MB9471.namprd11.prod.outlook.com (2603:10b6:208:5b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 08:03:56 +0000
Received: from BL4PR11MB8797.namprd11.prod.outlook.com
 ([fe80::311e:565b:ccfd:f4c8]) by BL4PR11MB8797.namprd11.prod.outlook.com
 ([fe80::311e:565b:ccfd:f4c8%5]) with mapi id 15.20.9031.024; Wed, 20 Aug 2025
 08:03:56 +0000
From: "Lee, Chee Yang" <chee.yang.lee@intel.com>
To: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>,
	"yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Subject: RE: [meta-zephyr][scarthgap][PATCH v6 11/11] zephyr-kernel-common:
 Add Board extension support
Thread-Topic: [meta-zephyr][scarthgap][PATCH v6 11/11] zephyr-kernel-common:
 Add Board extension support
Thread-Index: AQHcEIv/6qu7xAni5k6rNyXwHgUb/7Rqx6gg
Date: Wed, 20 Aug 2025 08:03:56 +0000
Message-ID: <BL4PR11MB87974D9CAC1FEACE72D6788BB933A@BL4PR11MB8797.namprd11.prod.outlook.com>
References: <20250818220304.2300436-1-sandeep.gundlupet-raju@amd.com>
 <20250818220304.2300436-12-sandeep.gundlupet-raju@amd.com>
In-Reply-To: <20250818220304.2300436-12-sandeep.gundlupet-raju@amd.com>
Accept-Language: en-SG, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR11MB8797:EE_|IA1PR11MB9471:EE_
x-ms-office365-filtering-correlation-id: ede766f7-9c15-4583-70e1-08dddfc01c8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?mgT0dDa2h9P4Q6SQ9n6C7Yeoeb+naRPXkn9fr3hDmjg8obAuDe+j4qWPQxGy?=
 =?us-ascii?Q?SjcpSEsWixD615OxW+XjMPoCW+cOUx0U3EnocoC8s1Z2uZMTIiFOwfafhMJH?=
 =?us-ascii?Q?7ox69PAa0Su5OI/xGe57I2NVHzj0KVy42mwXPJ2zBSn6s8plYUdPgf8eQ9KW?=
 =?us-ascii?Q?rx7FU5MJbBiUG1ncTTclaVV0hPOk38QxfEF0BmNtesUcV5jNwXwjPQHzjKxs?=
 =?us-ascii?Q?gXMM63jRFbV2/OX62dyHreEWRAO8RVnvzhQeDvi79Qn7rjt94ASEFY734PoA?=
 =?us-ascii?Q?B5XTahjskH+jF+C15vpDTuGqVwAuBO9F9bYyoNaEGKJj3Tly5ralzxkNW/NM?=
 =?us-ascii?Q?YddIczn0dfQuF7CgPSIwg+aXrRu3sXUoODQFZ1a2yyw7z/uEC5M5xt0UHDcn?=
 =?us-ascii?Q?AqpZ9N6Rh2Wuy3wRhnwH3X6/qa0uWXTnIPp9559QpI6cqbT10uJAG2Ib6ED0?=
 =?us-ascii?Q?ynV1G2a6gjr6p18d41UVl/EUN5GMAyZ7tLVnbI46deLBmfCQjBFJHePh0f2W?=
 =?us-ascii?Q?QjcR5cMHrXIWfSL0wZdt9IvUTW3L1d6zrLZVlLVJR7cSGgkx/iGqKct77CVk?=
 =?us-ascii?Q?+celv/hQC4q5QSNmXGy6Eoo88Cxgi4mvcmFkhHtUtCJsJn9GPPTE+JgW6H7X?=
 =?us-ascii?Q?zF+sZDHOTI23Mrmc1bUyO9dRNUJB89kGyc0whKsDbTdMEeK1ahOi7TyPObjB?=
 =?us-ascii?Q?3FqVADxOMv5/RYK3N050k9gsXwLXoPL458INiDvd52bGun+YGBeucTt6uiIa?=
 =?us-ascii?Q?1m8lmUpsDS/Z1z857qr11IhUOtcrkb8c1T/tlzbvyTB7lS3u4mt1Ub2Tm5Uf?=
 =?us-ascii?Q?D2pMxsHTtAghEWwtKAPa01kmjX+xB53xELf3lkvevpuakEOTWCWHbS7w+dLb?=
 =?us-ascii?Q?Jx+yaq0eNz0TznBhPBkSDYP5nr6Ekba0eSJZR37gdym+/q7JInA99HhTQXe1?=
 =?us-ascii?Q?2JBCPWrTVCGtgH+PzqLmCJ3jY734yk+uIRk3XzEoZabfYAHKI6uhTfR/zzyU?=
 =?us-ascii?Q?F8veqOOM5lPxa4/mj6WbW6AS8GXUQbPmEE4EoR6L7f85Le0lmsW0ynQ7xiHp?=
 =?us-ascii?Q?1LE9xm/Xc2iEH27UZxewt5rWzkOcKjwoiKWvBtAH0VpiCnWh97lZlJ7eLJUf?=
 =?us-ascii?Q?TWxEQ3SJQ1+ch4K8hZ++Nxnjv2204pmRmq3WOQmwvXB8iuV1nUTFRGvyiYSu?=
 =?us-ascii?Q?G7T1YW4o1MveLRtO3b/xo0SYJ54QNrr/kSDQwypCea69QmSLlDvadwHjiQI6?=
 =?us-ascii?Q?+FtP8vI+KQfNgeEZ4AZjU4FYeSZhjVBIQJXSPJKA8VTpnypkuWXtNefounwG?=
 =?us-ascii?Q?Q0Op1JHu5P4VBdt6s9lqR4C3UrZd1xVv/bYeJlsDhYY6RVn7Y6S1OA8j8X44?=
 =?us-ascii?Q?cJWK8Jmrpq0bCx5x4T/BbU8+G96VU5U6Op7L5dhWQcZ+PMlHMirlz4FI/u+X?=
 =?us-ascii?Q?9NAaWKhjGjF0LaChEh5fbOtnDtw2OOqX9wuyyKNOZi9pbFVdrYPvfg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR11MB8797.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?maIJYEcH7WFYM29sFfDlb+PsueiC1oPnBLSk+5nieasoN2/FKfRz8+vJoRz2?=
 =?us-ascii?Q?g8snI5+3RhePYGvoEmUVExiXBkxtMLfe9FQo8LGh4hsjR/jrEmVO8mpLyqq+?=
 =?us-ascii?Q?qYecEa65syBZlps2WnD/mFLQkiV7IXcK15Df/rsjRpSUaQqsUBByjGRO2D80?=
 =?us-ascii?Q?e0E+yJ/G8jv2Dw/62YPpbYgPk+fG7c05pN1Atzzm/W/GDnEqUmQvw6eiOagx?=
 =?us-ascii?Q?SgycdiSvmArkloRJsqjZeDF2HnXc4guDrfboajo//ZmwB7wxc5mcuVzr28Hx?=
 =?us-ascii?Q?InwK1hbWFEhuqTw3ZtxBwCoQES5bGmRCQTk8RJlqiU3dClNfoxVX4QX+HoWO?=
 =?us-ascii?Q?pDGWjUVDj1/fAem5t3SAKiS8tw8Vt6Ha8VqTE4cgOK3mdRL/jE3xQxy+foRl?=
 =?us-ascii?Q?ZawmW+iTrR++FRxBezOKNucxXbdBS1Tz9vHANjyDW03/Wl9EP3H84YSLcDqj?=
 =?us-ascii?Q?SLcPz5IkXUXaE9i6ocxVYoGqbv/i7ChZub5QUsAYXYTdGseLW8MvDSbdSxEM?=
 =?us-ascii?Q?93xdOtSRQ9MAGovFV+8dCUB40Py6yWkrMY77qwWLIkcSTZa+Rea8Ci+oXaWh?=
 =?us-ascii?Q?2tbWtxYMhjQidj8C69ic64CQBnsX8PXJMGFAZ9Y36DaXWAn5M10v3bvrLRt+?=
 =?us-ascii?Q?RNPNKomQYjrMP93Rs0LAgw53q2oWEOUCcV1tRAPAOs2CtD+QHD0k9blwvJTe?=
 =?us-ascii?Q?XhQaj7RmD9rEVl0tDvja7h2suonlJXLeBu/kF3fIWAQLXWzbJmkxnPD7d2yY?=
 =?us-ascii?Q?x8mn8eyEQa3fsbLUdRM5Wud92H+6D9n5E4uwXbGqaDBEQA1PTh/IgI+9xZJs?=
 =?us-ascii?Q?Glfdfnj5JDerc58m37GDKc8PFZ20IY4QzDjqX2FDFZq/nZonBkpt8wYdue6K?=
 =?us-ascii?Q?LwFkwW9NPXRUBfuIE3rBXxSDEUVXNzOCvh1Ct5SwP8iu8MDl2ClN2DBp2kD8?=
 =?us-ascii?Q?LEJtWCr9Jfe2T95BUpKDeSh/Xgh4eScv7dpCAZOu0gOFPFvF1HBsQA0rBV4p?=
 =?us-ascii?Q?6QU2XwU4aW4kwVzDJQt1zttz3YXisxaM6vrsRIcBZNw3V+PP9LVzskaYZyQa?=
 =?us-ascii?Q?nZWg8Gh1gaPlIKuYFbAeEYDwkBqLks7LHJDIfXHMIR20qJZUjo6Ax6jl74xi?=
 =?us-ascii?Q?D64gcXFXZsqnrNOwo0H7GHZxOGO0TV2UN+vWS+dCekzge4t4OpVY96W+kTrB?=
 =?us-ascii?Q?B21lBqa5WKyxHK5+fFem3Qo4W3DXZdQqST889nD+B8hpneQE1zoPE8jLn4y+?=
 =?us-ascii?Q?opdG12hxqyCt3xpS1XqAUTkqaN3YCYEG1RF49jzZ0z3y3f094z7t62fP34MK?=
 =?us-ascii?Q?G1fDTsC/EsJJl81vTKbaVrs2C03eXCKSURK8ahBAzOrsnpJPUrcgDtPdl1h+?=
 =?us-ascii?Q?Cid8f1UlY8iLzNtvaLIydF0OnbhuugCkHdvlCnCASQx6HAvtgfAdDFn+aVkj?=
 =?us-ascii?Q?6rerFv937EVjA9OdPBWnZsONa5pdVHY++0njf6z4UIEqWYd0caLLehoQfObV?=
 =?us-ascii?Q?YrED+zXRUFCiqR9RVtBJBbm9kFs8d3Dd1/PkQ+D7vT8W4AtbGVvoyFZ+a2Xw?=
 =?us-ascii?Q?I42FXbfHsgAAYXXDQ19aHaTIl+f5YkOkTWrTY9zB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL4PR11MB8797.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ede766f7-9c15-4583-70e1-08dddfc01c8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 08:03:56.1786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ChPDaFUFHyDLcYE1J8om8MWQ2BMJteMqU4p90FCGFoXwltNos87vrpsH62bNHIELUZqTLH7GyJK+JpIHrisoIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB9471
X-OriginatorOrg: intel.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 20 Aug 2025 08:04:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2064


I think this cause build error with zephyr kernel 3.6.0. This works with ze=
phyr kernel 3.7.0

| CMake Error at /data/scarthgap/poky/build-zephyr/tmp-newlib/work/cortexa9=
-vfp-yocto-eabi/zephyr-philosophers/3.6.0+git/git/zephyr/cmake/modules/boar=
ds.cmake:167 (message):
|   Invalid BOARD; see above.



> -----Original Message-----
> From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
> Sent: Tuesday, 19 August, 2025 6:03 AM
> To: yocto-patches@lists.yoctoproject.org; Lee, Chee Yang
> <chee.yang.lee@intel.com>
> Subject: [meta-zephyr][scarthgap][PATCH v6 11/11] zephyr-kernel-common:
> Add Board extension support
>=20
> Add board extension support variables where user can specify the
> BOARD_ROOT variable for out-of-tree custom boards.
>=20
> Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-
> raju@amd.com>
> ---
>  .../recipes-kernel/zephyr-kernel/zephyr-kernel-common.inc    | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-
> common.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-
> common.inc
> index 5191b9a..579fd6c 100644
> --- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-
> common.inc
> +++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-
> common
> +++ .inc
> @@ -18,6 +18,11 @@ EXTRA_OECMAKE =3D "\
>      -DZEPHYR_BASE=3D${ZEPHYR_BASE} \
>      -DBOARD=3D${BOARD} \
>      -DARCH=3D${ARCH} \
> +    -DBOARD_DIR=3D${BOARD_DIR} \
> +    -DARCH_DIR=3D${ARCH_DIR} \
> +    -DBOARD_ROOT=3D${BOARD_ROOT} \
> +    -DBOARD_EXTENSION_DIRS=3D${BOARD_EXTENSION_DIRS} \
> +    -DSOC_ROOT=3D${SOC_ROOT} \
>      -DZEPHYR_TOOLCHAIN_VARIANT=3D${ZEPHYR_TOOLCHAIN_VARIANT} \
>      -DZEPHYR_MODULES=3D${ZEPHYR_MODULES} \
>      "
> --
> 2.34.1


