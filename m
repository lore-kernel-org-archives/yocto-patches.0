Return-Path: <naveen.kumar.saini@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBFBEED611
	for <webhook@archiver.kernel.org>; Thu, 12 Sep 2024 14:56:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mx.groups.io with SMTP id smtpd.web10.49888.1726152983401716757
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Sep 2024 07:56:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=QrgT9Liy;
 spf=pass (domain: intel.com, ip: 198.175.65.21, mailfrom: naveen.kumar.saini@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726152984; x=1757688984;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Wd54TBUqN+9sL2C5S0Fy7LpEbPlX2qxD+0hw3var/+k=;
  b=QrgT9LiyJ62ld8wYeqgabSc7rSb2b5LWDqzhTgac7FLmApKcG+P3+NK9
   titskM+SfYyVL+otTRekSAClfFauGN82uZsiB0WyOhYcjr2v21B+6im6m
   1hfTGo2D/s8/bvkY9tWwd/JlMYXW5/DbWDQYEyMOHgYv7Ds5iVjMTQFA3
   b7WNZ5Z4ParEoeWdNfSdzj2u9p3n+JOvyG2QJw3eKO5607zNU2pwLiQ1e
   9ByRumz8sw0jLF07dQstAICw6/zptij+4U5sI6kp4aHE1MUehgg9pYAme
   PUWDk7qguNzJb9jZheW0PgIzWMUN/pYLXy9X2blcVkGWHRxjP2M9m0JCJ
   g==;
X-CSE-ConnectionGUID: IfVJqw2tS5mldN+WK2hDig==
X-CSE-MsgGUID: X7IYmcJYQK2MVW+12jU5yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24950890"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="24950890"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 07:56:16 -0700
X-CSE-ConnectionGUID: kxI7/FKJTnWNSlrN9V6HhA==
X-CSE-MsgGUID: FMR+triQTYCSDyagDg0z8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="72717990"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2024 07:56:14 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 07:56:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 07:56:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 12 Sep 2024 07:56:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 07:56:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YLBLkyaWv8MOMQrjshhpfFanFof4V0L6Xq9+LNjz8T7j/5kfwUAy9gxdI9k5WAFUrZKI4KXOnKvd2IgyB6bM+zcmmJsgLuV6nPIVpE89Sbox5QlzwROIKH8uAszXho3NHpG9JbqB430XSKBm+5b6YDSmibLl1r+tQEGwBt/QyKr+4wjpb5YbfMZSypXoEwFR7ZrgqcEc7t2PRLicyFcQby9lChnE3pAG0xyrP+UnXSKTjDfHlSLAqkiXybJPt/RNYO/DwV5oRkobuB3gDjSm+IIkMrCecLE0Ihk1m0H3c9QKUC/RkYr5Zj6O5b8UJ55FEptBcoi9SkFoiYKDmSSl5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNnB+ary5pCuUFIda28o9Ywo+ke6zH2HPOl3MfP+17g=;
 b=jg6BUiILWHpOMKhBdcBl8sGDxR3BR1LQ2ghe3RqfozHIT+foIEWqr+TQ8JYNefiW/zZEOM9dM9pGhIoLOLdBRqPDW6kPAa/Ij/r0pJxIiZwqK1Rf++xuFrt4u79Iyp7v8PQvuMAyLFnvCmq/o/vN+SuXTg9soGfOkRDv6oKn2XSaS/jkaMUqbg9HjHHWskY4CJ90LMquC7ki7CMU+yrRIDrJKlvjOeB7sOmK/tH/f5Omzh1ISHO8Xej1gbsR5w5F57moOT9WVNj+oYnT0cCLTRnRxtUEeReIqVWG+pAn8xy+9mKXjLYjXhr7wR5Tjfm8mj1KhhN23rpx2xuuQS9iaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5026.namprd11.prod.outlook.com (2603:10b6:303:9c::13)
 by CY5PR11MB6341.namprd11.prod.outlook.com (2603:10b6:930:3e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 12 Sep
 2024 14:56:08 +0000
Received: from CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::aeb:33f7:57:f7c9]) by CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::aeb:33f7:57:f7c9%5]) with mapi id 15.20.7962.016; Thu, 12 Sep 2024
 14:56:08 +0000
From: "Saini, Naveen Kumar" <naveen.kumar.saini@intel.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: "troy_lee@aspeedtech.com" <troy_lee@aspeedtech.com>,
	"jamin_lin@aspeedtech.com" <jamin_lin@aspeedtech.com>,
	"jaminlin1207@gmail.com" <jaminlin1207@gmail.com>,
	"vince_chang@aspeedtech.com" <vince_chang@aspeedtech.com>
Subject: RE: [yocto-patches] [meta-zephyr][PATCH v2 1/2] zephyr-kernel: Add
 source version to support v3.7.0
Thread-Topic: [yocto-patches] [meta-zephyr][PATCH v2 1/2] zephyr-kernel: Add
 source version to support v3.7.0
Thread-Index: AQHa/QQad1SQL0TpbE2BsgmfWtiVCbJUTV1w
Date: Thu, 12 Sep 2024 14:56:08 +0000
Message-ID: <CO1PR11MB5026711FDEDDF6CCFDFB0D1DC4642@CO1PR11MB5026.namprd11.prod.outlook.com>
References: <20240902064733.651635-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20240902064733.651635-1-jamin_lin@aspeedtech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5026:EE_|CY5PR11MB6341:EE_
x-ms-office365-filtering-correlation-id: fe1f584e-0250-4fdd-8ad8-08dcd33b08a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|4022899009|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?HYXktAyIYcUF4hx7j9OUyyj47WLwwTwALTBTuRvfgjdaQwY8EkUulU7Kvcqq?=
 =?us-ascii?Q?hx7U+Kedh5eCvroyjvDrxlXiraX9NvGTOlZAeeEVPGu+rEgo2V/PewOsvLx7?=
 =?us-ascii?Q?uU2ROptI7Ge1w4yYLaOQP4exq0mu/UKfrixTU/tu3HhoiZ69vKpoEOxxTk71?=
 =?us-ascii?Q?2UfCvvTv6k3w4ZGilIzP37IzD+U/KJoR6GG97hlvlVqlwSnfBVvJggotKYiO?=
 =?us-ascii?Q?uCMmcuq7bDn60XL3i1Yz4m+yegP8rPG7qVrlGe2icZU6rxuLMzZiT9a5wjl8?=
 =?us-ascii?Q?/682Bq4+cNoXebrU6Fo+KyBdNuNRWhMEaGf8D5zqwMPCvN4ZquTrWS81EPMP?=
 =?us-ascii?Q?dNrJtYpuurM06c8QiWObVQWF4SYKervVGGoTq/+4Fa7sOZu8yR+pNhug1L/w?=
 =?us-ascii?Q?6qfw1c1TsvrgnY3qUPTUbdYNToVLYUEK8tgl/31JZt95UoB+sNqK344dzy7/?=
 =?us-ascii?Q?aIdNq7VTFOuLA4sFW4AAyJViDz+fS/eZRERE8sER57v5sNcS1DALxhf0ZiC8?=
 =?us-ascii?Q?OTyBGhZkmwU9/6wl1knOBFr8a3tn+x3tFLmscYw99xMBePwCYgSZcffbxce7?=
 =?us-ascii?Q?992Gya2OK1ik50SgNIbkRr8dukSMs/jVJgUQt4K3iAI406hqC0KhPRul7Y6x?=
 =?us-ascii?Q?2VueNZkvhRHU5w0jP7CePNjo1OeV8Vak//G9NHbEk+/WD2ihXaJMRmy1H4hR?=
 =?us-ascii?Q?7KtUD/5yN5+An0/WU7QK3DNbRH9c/YXe3fh9iyS3H6bxR0JeUcreCGnk8FTB?=
 =?us-ascii?Q?rUopwU4voyvzGiRDvPAK/WwCfrV8GX2d9chExBtcVpGeJ0O9m+aJatjkmO4g?=
 =?us-ascii?Q?cyVTwX/mfTbkuBq8tvIuz3j+nYy9/I3oWPTBo5oqKzXdvX35Knx0FToTRUvM?=
 =?us-ascii?Q?eBPYDlbfOg9rO9JRQkedpJnbIKOs8HsaMN7Mm/8XOVnmkP6lAqAEEI+KWsDv?=
 =?us-ascii?Q?vy4NcsBW8EBQ2fzqPXeA0yTcDKuWD9OVcwohN2OnBgp9JndKswPFaw/9nioQ?=
 =?us-ascii?Q?NAC+exABsXD8jqXiT991tibxXjR4M/wawp87M73IONwaP9vryA8G3h0jHw1f?=
 =?us-ascii?Q?f1cI+mBjm/KLO2Gq5ZL4CnHmuplNp3FOi62I9T8AqwJqaIO7qIm5ZnoLuDBi?=
 =?us-ascii?Q?sK8qoVhAKD7c39AL1Tqf48rD3b3NU0OX7Fo67Ii2l/9cF2B7B4HD/TtwOO24?=
 =?us-ascii?Q?L9vOzyASFxCGX9GiiDd3ey6OpDk82YhPZjxjgNDafZWFaioUnZm5sqJDAd6q?=
 =?us-ascii?Q?GQGr6XShSe+G+DZ7/Z+Dp81w9kUTk4pQHTTkwmLaWk6YwSdZT0W0XYAk2uFp?=
 =?us-ascii?Q?tpuPMjqmnht97cggPAfAgDCAirGLntUcx5j/cPB/SWUgqMjJka1UIUMgMFRU?=
 =?us-ascii?Q?CRovi0k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5026.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(4022899009)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lSaantF4Le8wiMvB9RVQ8yUq7ezo7nk0coO2Vf22+thfD/avGP41lWJ6KZrL?=
 =?us-ascii?Q?edGd9lsUTqzj8LOumSg5sfnBfsSzGO10O7/F7tkU0TnJ13lqQKJboGUwstJt?=
 =?us-ascii?Q?3/DwLIiL3CXIkNDshW8/vKEnc++xwHBMb+ojOuJJ4i0mJE9eVlA856pE3t6y?=
 =?us-ascii?Q?1iVIEukoin/48MQY00NKK48pvX48pnVqatoVDT3Q/HV1+DE8tQ8aBkooBZAC?=
 =?us-ascii?Q?po6xSKMg/wi4BjFIx8lcwGDR/3GnoJsX2U//h0vy5fic+h0I/yW5FsFpTAH4?=
 =?us-ascii?Q?KB/PBdYZ4l2bfRar1gDkmzVv6Ai2jBwfDRCIQISL87uXB+Ios5sTZUs6gVgr?=
 =?us-ascii?Q?DeIZKbO7JZKiFresN+krjj3nKBGfhlDd22at3Qe21ylxrrgUsNrDtCSIPnCw?=
 =?us-ascii?Q?MBGnmPx8mYfx72GffKFlSSl6LhDudIIvYoFLiaWUcsHAkJm/qJ7YIdip9nIn?=
 =?us-ascii?Q?GOdHT1RGMt6Sz/2D/yVvKCrwCE5ZxX8qVPSqJF/jjJi+JE2WD9njXNHaTnhJ?=
 =?us-ascii?Q?sgxF8pLuSKKIA8QvP0MXO8++1zXN9gUMd+cexxQwhk3WKr8fS42rKPf99sI/?=
 =?us-ascii?Q?ls9ZzFhT/h6hlZO7C5JAo3L8sI/jRag8F/Dmjd+ktnqe+1BJK+59AaUMNhwf?=
 =?us-ascii?Q?wPE+9OAC/Sd94tdOfWPA2O4m1+xY3vXQyrDkXn+4HoNDKz92gYBaG25tlNn/?=
 =?us-ascii?Q?3qZQj5jx25PYFqnkDk3WSpPeASFXfxHKoNf9K2CIQxIvgjCJ1C+hHn4HBYba?=
 =?us-ascii?Q?ChCaPUJCS54Ua5h4IrhxojkasG8UhD7vJacA7OOh7ik9lH2DZCqvAox7yfWX?=
 =?us-ascii?Q?/tfC/NVbVNyoiyWHotyT7/zW1+Pe3DP8ISXcfQQbP1jg2UinekkXgP7cF7WD?=
 =?us-ascii?Q?2+/pkFXQOI/sKGSlcuG+cJbtz4hl8242QS4d5ZsWpVB8csew0pn/7kdx4bT4?=
 =?us-ascii?Q?uVi9kVz6MVJcnWu6eW4/jq7TQQYm+/ubnkrHhxD48JO2C4I/vj05IqSH2X2j?=
 =?us-ascii?Q?l0jtIrAgfoAetQqJEIMDJhoDwg/ln8qn2F/xUGyEWGFHjCbMvGFzk4/V1uDH?=
 =?us-ascii?Q?YR6Igwyv9nzj83Qvjv82F5YkitX/i2EGpdgHp/RsSMgkLNJpwb2LtfJK3tIG?=
 =?us-ascii?Q?5PRPV3jSi1MAjNtyf0Hn/6s7sgmHgsCVmgCG686cF0YmfGJZaOblLNCbhuET?=
 =?us-ascii?Q?nB/uHffgfUrvZvLLmRz2clSgKgNBG9+enTX2Qu5upakC1noxmuF5bykjcw9A?=
 =?us-ascii?Q?qsMKDTAqm+83ysk1jNnie6ew7hSFWMd9L+FVL0bJU5O3W5+z0GFCJSDvgNSF?=
 =?us-ascii?Q?EwP4RVfpJMRnBHraMY6407SSGxFT+m8rlWpaZp3rK3rF+1wKdUCWfU4rPwQo?=
 =?us-ascii?Q?0oEAp/xmmABQxgMJQQM5aswP8DCajPj2T1hUoLkhtztywQ8CFtXRkOLDA+nS?=
 =?us-ascii?Q?OEiqJxvUkssBSe2oqac9GHK0QWBaPz40mgi6sXSppsZKhfaQf/bFhDUgvzOl?=
 =?us-ascii?Q?jmWe5PUdcYRqQa972QvxTqyfhFqemWLsTxBaExOQjqIwJtRPHiHBkqNVGDQ/?=
 =?us-ascii?Q?APZZa1PK0gXWoo9Ni52Ypkl/4V5o/Vo+zLou5oeu2jPikUobnAGdKfG8HU9S?=
 =?us-ascii?Q?qg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5026.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1f584e-0250-4fdd-8ad8-08dcd33b08a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 14:56:08.1306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Owa6mjyPaOqlSfArmGL5MAFslzd5YN2KwhgxraphFLPeMn/suvvhYhsNJ35hWdgwpECehzsIqVnt3tvrAhxUOZf2LnwtvR1uoj1hyLX3z58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6341
X-OriginatorOrg: intel.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Sep 2024 14:56:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/648

I have fixed x86 patch and merged. Thanks for the patch.
https://git.yoctoproject.org/meta-zephyr/commit/?id=3Daa00f54e4344fa67d8969=
311650252e596ce99e4

Regards,
Naveen

> -----Original Message-----
> From: yocto-patches@lists.yoctoproject.org <yocto-
> patches@lists.yoctoproject.org> On Behalf Of Jamin Lin via
> lists.yoctoproject.org
> Sent: Monday, September 2, 2024 2:48 PM
> To: yocto-patches@lists.yoctoproject.org
> Cc: troy_lee@aspeedtech.com; jamin_lin@aspeedtech.com;
> jaminlin1207@gmail.com; vince_chang@aspeedtech.com
> Subject: [yocto-patches] [meta-zephyr][PATCH v2 1/2] zephyr-kernel: Add
> source version to support v3.7.0
>=20
> This inc file is created by generate-version.py The generate-version.py d=
id
> not create a 0001-3.7-x86-fix-efi-binary-generation-issue-in-cross-
> compila.patch,
> , set SRC_URI_PATCHES empty.
>=20
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  .../zephyr-kernel/zephyr-kernel-src-3.7.0.inc | 273 ++++++++++++++++++
>  1 file changed, 273 insertions(+)
>  create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-
> kernel/zephyr-kernel-src-3.7.0.inc
>=20
> diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-
> src-3.7.0.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-
> kernel-src-3.7.0.inc
> new file mode 100644
> index 0000000..00436f9
> --- /dev/null
> +++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-3.
> +++ 7.0.inc
> @@ -0,0 +1,273 @@
> +# Auto-generated from zephyr-kernel-src.inc.jinja
> +
> +SRCREV_FORMAT =3D "default"
> +
> +SRCREV_default =3D "36940db938a8f4a1e919496793ed439850a221c2"
> +SRCREV_acpica =3D "8d24867bc9c9d81c81eeac59391cda59333affd4"
> +SRCREV_bsim =3D "9351ae1ad44864a49c351f9704f65f43046abeb0"
> +SRCREV_babblesim_base =3D
> "4bd907be0b2abec3b31a23fd8ca98db2a07209d2"
> +SRCREV_babblesim_ext_2G4_libPhyComv1 =3D
> "93f5eba512c438b0c9ebc1b1a947517c865b3643"
> +SRCREV_babblesim_ext_2G4_phy_v1 =3D
> "04eeb3c3794444122fbeeb3715f4233b0b50cfbb"
> +SRCREV_babblesim_ext_2G4_channel_NtNcable =3D
> "20a38c997f507b0aa53817aab3d73a462fff7af1"
> +SRCREV_babblesim_ext_2G4_channel_multiatt =3D
> "bde72a57384dde7a4310bcf3843469401be93074"
> +SRCREV_babblesim_ext_2G4_modem_magic =3D
> "edfcda2d3937a74be0a59d6cd47e0f50183453da"
> +SRCREV_babblesim_ext_2G4_modem_BLE_simple =3D
> "a38d2d24b04a6f970a225d1316047256ebf5a539"
> +SRCREV_babblesim_ext_2G4_device_burst_interferer =3D
> "5b5339351d6e6a2368c686c734dc8b2fc65698fc"
> +SRCREV_babblesim_ext_2G4_device_WLAN_actmod =3D
> "9cb6d8e72695f6b785e57443f0629a18069d6ce4"
> +SRCREV_babblesim_ext_2G4_device_playback =3D
> "abb48cd71ddd4e2a9022f4bf49b2712524c483e8"
> +SRCREV_babblesim_ext_libCryptov1 =3D
> "eed6d7038e839153e340bd333bc43541cb90ba64"
> +SRCREV_cmsis =3D "4b96cbb174678dcd3ca86e11e1f24bc5f8726da0"
> +SRCREV_cmsis-dsp =3D "6489e771e9c405f1763b52d64a3f17a1ec488ace"
> +SRCREV_cmsis-nn =3D "ea987c1ca661be723de83bd159aed815d6cbd430"
> +SRCREV_edtt =3D "8d7b543d4d2f2be0f78481e4e1d8d73a88024803"
> +SRCREV_fatfs =3D "427159bf95ea49b7680facffaa29ad506b42709b"
> +SRCREV_hal_adi =3D "dee9a7b1eff13a9da0560daf8842d61657f9d61e"
> +SRCREV_hal_altera =3D "4fe4df959d4593ce66e676aeba0b57f546dba0fe"
> +SRCREV_hal_ambiq =3D "e25327f026df1ee08f1bf01a4bbfeb5e5f4026f1"
> +SRCREV_hal_atmel =3D "56d60ebc909ad065bf6554cee73487969857614b"
> +SRCREV_hal_espressif =3D "87e7902d7184a8280b4d13bce79801a723f4ddd8"
> +SRCREV_hal_ethos_u =3D "8e2cf756b474eff9a32a9bdf1775d9620f1eadcf"
> +SRCREV_hal_gigadevice =3D "2994b7dde8b0b0fa9b9c0ccb13474b6a486cddc3"
> +SRCREV_hal_infineon =3D "f25734a72c585f6675e8254a382e80e78a3cd03a"
> +SRCREV_hal_intel =3D "0905a528623de56b1bedf817536321bcdbc0efae"
> +SRCREV_hal_microchip =3D "71eba057c0cb7fc11b6f33eb40a82f1ebe2c571c"
> +SRCREV_hal_nordic =3D "ab5cb2e2faeb1edfad7a25286dcb513929ae55da"
> +SRCREV_hal_nuvoton =3D "466c3eed9c98453fb23953bf0e0427fea01924be"
> +SRCREV_hal_nxp =3D "862e001504bd6e0a4feade6a718e9f973116849c"
> +SRCREV_hal_openisa =3D "eabd530a64d71de91d907bad257cd61aacf607bc"
> +SRCREV_hal_quicklogic =3D "bad894440fe72c814864798c8e3a76d13edffb6c"
> +SRCREV_hal_renesas =3D "af77d7cdfeeff290593e7e99f54f0c1e2a3f91e6"
> +SRCREV_hal_rpi_pico =3D "fba7162cc7bee06d0149622bbcaac4e41062d368"
> +SRCREV_hal_silabs =3D "a09dd1b82b24aa3060e162c0dfa40026c0dba450"
> +SRCREV_hal_st =3D "b77157f6bc4395e398d90ab02a7d2cbc01ab2ce7"
> +SRCREV_hal_stm32 =3D "f1317150eac951fdd8259337a47cbbc4c2e6d335"
> +SRCREV_hal_telink =3D "4226c7fc17d5a34e557d026d428fc766191a0800"
> +SRCREV_hal_ti =3D "b85f86e51fc4d47c4c383d320d64d52d4d371ae4"
> +SRCREV_hal_wurthelektronik =3D
> "e5bcb2eac1bb9639ce13b4dafc78eb254e014342"
> +SRCREV_hal_xtensa =3D "a2d658525b16c57bea8dd565f5bd5167e4b9f1ee"
> +SRCREV_hostap =3D "a90df86d7c596a5367ff70c2b50c7f599e6636f3"
> +SRCREV_libmetal =3D "a6851ba6dba8c9e87d00c42f171a822f7a29639b"
> +SRCREV_liblc3 =3D "1a5938ebaca4f13fe79ce074f5dee079783aa29f"
> +SRCREV_littlefs =3D "408c16a909dd6cf128874a76f21c793798c9e423"
> +SRCREV_loramac-node =3D "fb00b383072518c918e2258b0916c996f2d4eebe"
> +SRCREV_lvgl =3D "2b498e6f36d6b82ae1da12c8b7742e318624ecf5"
> +SRCREV_mbedtls =3D "2f24831ee13d399ce019c4632b0bcd440a713f7c"
> +SRCREV_mcuboot =3D "fb2cf0ec3da3687b93f28e556ab682bdd4b85223"
> +SRCREV_mipi-sys-t =3D "71ace1f5caa03e56c8740a09863e685efb4b2360"
> +SRCREV_net-tools =3D "7c7a856814d7f27509c8511fef14cec21f7d0c30"
> +SRCREV_nrf_hw_models =3D "6c389b9b5fa0a079cd4502e69d375da4c0c289b7"
> +SRCREV_open-amp =3D "76d2168bcdfcd23a9a7dce8c21f2083b90a1e60a"
> +SRCREV_openthread =3D "3873c6fcd5a8a9dd01b71e8efe32ef5dc7923bb1"
> +SRCREV_percepio =3D "a49e5f3947faad0dd654eddd5a750127fb81e50d"
> +SRCREV_picolibc =3D "764ef4e401a8f4c6a86ab723533841f072885a5b"
> +SRCREV_segger =3D "b011c45b585e097d95d9cf93edf4f2e01588d3cd"
> +SRCREV_tinycrypt =3D "1012a3ebee18c15ede5efc8332ee2fc37817670f"
> +SRCREV_trusted-firmware-m =3D
> "069455be098383bf96eab73e3ff8e0c66c60fa5a"
> +SRCREV_trusted-firmware-a =3D
> "713ffbf96c5bcbdeab757423f10f73eb304eff07"
> +SRCREV_uoscore-uedhoc =3D "84ef879a46d7bfd9a423fbfb502b04289861f9ea"
> +SRCREV_zcbor =3D "75d088037eb237b18e7ec1f47c9ce494b9b95aab"
> +
> +SRC_URI_ZEPHYR ?=3D "git://github.com/zephyrproject-
> rtos/zephyr.git;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_ACPICA ?=3D "git://github.com/zephyrproject-
> rtos/acpica;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_BSIM ?=3D "git://github.com/zephyrproject-
> rtos/babblesim-manifest;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_BABBLESIM_BASE ?=3D
> "git://github.com/BabbleSim/base;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_LIBPHYCOMV1 ?=3D
> "git://github.com/BabbleSim/ext_2G4_libPhyComv1;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_PHY_V1 ?=3D
> "git://github.com/BabbleSim/ext_2G4_phy_v1;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_NTNCABLE ?=3D
> "git://github.com/BabbleSim/ext_2G4_channel_NtNcable;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_MULTIATT ?=3D
> "git://github.com/BabbleSim/ext_2G4_channel_multiatt;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_MAGIC ?=3D
> "git://github.com/BabbleSim/ext_2G4_modem_magic;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_BLE_SIMPLE ?=3D
> "git://github.com/BabbleSim/ext_2G4_modem_BLE_simple;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_BURST_INTERFERER ?=3D
> "git://github.com/BabbleSim/ext_2G4_device_burst_interferer;protocol=3Dht
> tps"
> +SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_WLAN_ACTMOD ?=3D
> "git://github.com/BabbleSim/ext_2G4_device_WLAN_actmod;protocol=3Dhtt
> ps"
> +SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_PLAYBACK ?=3D
> "git://github.com/BabbleSim/ext_2G4_device_playback;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_BABBLESIM_EXT_LIBCRYPTOV1 ?=3D
> "git://github.com/BabbleSim/ext_libCryptov1;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_CMSIS ?=3D "git://github.com/zephyrproject-
> rtos/cmsis;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_CMSIS_DSP ?=3D "git://github.com/zephyrproject-
> rtos/cmsis-dsp;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_CMSIS_NN ?=3D "git://github.com/zephyrproject-
> rtos/cmsis-nn;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_EDTT ?=3D "git://github.com/zephyrproject-
> rtos/edtt;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_FATFS ?=3D "git://github.com/zephyrproject-
> rtos/fatfs;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_HAL_ADI ?=3D "git://github.com/zephyrproject-
> rtos/hal_adi;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_HAL_ALTERA ?=3D "git://github.com/zephyrproject-
> rtos/hal_altera;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_HAL_AMBIQ ?=3D "git://github.com/zephyrproject-
> rtos/hal_ambiq;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_HAL_ATMEL ?=3D "git://github.com/zephyrproject-
> rtos/hal_atmel;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_HAL_ESPRESSIF ?=3D "git://github.com/zephyrproject-
> rtos/hal_espressif;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_HAL_ETHOS_U ?=3D "git://github.com/zephyrproject-
> rtos/hal_ethos_u;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_HAL_GIGADEVICE ?=3D "git://github.com/zephyrproject-
> rtos/hal_gigadevice;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_HAL_INFINEON ?=3D "git://github.com/zephyrproject-
> rtos/hal_infineon;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_HAL_INTEL ?=3D "git://github.com/zephyrproject-
> rtos/hal_intel;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_HAL_MICROCHIP ?=3D "git://github.com/zephyrproject-
> rtos/hal_microchip;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_HAL_NORDIC ?=3D "git://github.com/zephyrproject-
> rtos/hal_nordic;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_HAL_NUVOTON ?=3D "git://github.com/zephyrproject-
> rtos/hal_nuvoton;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_HAL_NXP ?=3D "git://github.com/zephyrproject-
> rtos/hal_nxp;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_HAL_OPENISA ?=3D "git://github.com/zephyrproject-
> rtos/hal_openisa;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_HAL_QUICKLOGIC ?=3D "git://github.com/zephyrproject-
> rtos/hal_quicklogic;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_HAL_RENESAS ?=3D "git://github.com/zephyrproject-
> rtos/hal_renesas;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_HAL_RPI_PICO ?=3D "git://github.com/zephyrproject-
> rtos/hal_rpi_pico;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_HAL_SILABS ?=3D "git://github.com/zephyrproject-
> rtos/hal_silabs;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_HAL_ST ?=3D "git://github.com/zephyrproject-
> rtos/hal_st;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_HAL_STM32 ?=3D "git://github.com/zephyrproject-
> rtos/hal_stm32;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_HAL_TELINK ?=3D "git://github.com/zephyrproject-
> rtos/hal_telink;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_HAL_TI ?=3D "git://github.com/zephyrproject-
> rtos/hal_ti;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_HAL_WURTHELEKTRONIK ?=3D
> "git://github.com/zephyrproject-rtos/hal_wurthelektronik;protocol=3Dhttps=
"
> +SRC_URI_ZEPHYR_HAL_XTENSA ?=3D "git://github.com/zephyrproject-
> rtos/hal_xtensa;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_HOSTAP ?=3D "git://github.com/zephyrproject-
> rtos/hostap;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_LIBMETAL ?=3D "git://github.com/zephyrproject-
> rtos/libmetal;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_LIBLC3 ?=3D "git://github.com/zephyrproject-
> rtos/liblc3;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_LITTLEFS ?=3D "git://github.com/zephyrproject-
> rtos/littlefs;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_LORAMAC_NODE ?=3D "git://github.com/zephyrproject-
> rtos/loramac-node;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_LVGL ?=3D "git://github.com/zephyrproject-
> rtos/lvgl;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_MBEDTLS ?=3D "git://github.com/zephyrproject-
> rtos/mbedtls;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_MCUBOOT ?=3D "git://github.com/zephyrproject-
> rtos/mcuboot;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_MIPI_SYS_T ?=3D "git://github.com/zephyrproject-
> rtos/mipi-sys-t;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_NET_TOOLS ?=3D "git://github.com/zephyrproject-
> rtos/net-tools;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_NRF_HW_MODELS ?=3D "git://github.com/zephyrproject-
> rtos/nrf_hw_models;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_OPEN_AMP ?=3D "git://github.com/zephyrproject-
> rtos/open-amp;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_OPENTHREAD ?=3D "git://github.com/zephyrproject-
> rtos/openthread;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_PERCEPIO ?=3D "git://github.com/zephyrproject-
> rtos/percepio;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_PICOLIBC ?=3D "git://github.com/zephyrproject-
> rtos/picolibc;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_SEGGER ?=3D "git://github.com/zephyrproject-
> rtos/segger;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_TINYCRYPT ?=3D "git://github.com/zephyrproject-
> rtos/tinycrypt;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_M ?=3D
> "git://github.com/zephyrproject-rtos/trusted-firmware-m;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_A ?=3D
> "git://github.com/zephyrproject-rtos/trusted-firmware-a;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_UOSCORE_UEDHOC ?=3D "git://github.com/zephyrproject-
> rtos/uoscore-uedhoc;protocol=3Dhttps"
> +SRC_URI_ZEPHYR_ZCBOR ?=3D "git://github.com/zephyrproject-
> rtos/zcbor;protocol=3Dhttps"
> +
> +SRC_URI_PATCHES ?=3D "\
> +"
> +
> +SRC_URI =3D "\
> +
> ${SRC_URI_ZEPHYR};branch=3D${ZEPHYR_BRANCH};name=3Ddefault;destsuffix=3D
> git/zephyr \
> +
> ${SRC_URI_ZEPHYR_ACPICA};name=3Dacpica;nobranch=3D1;destsuffix=3Dgit/modu
> les/lib/acpica \
> +
> ${SRC_URI_ZEPHYR_BSIM};name=3Dbsim;nobranch=3D1;destsuffix=3Dgit/tools/bs=
i
> m \
> +
> ${SRC_URI_ZEPHYR_BABBLESIM_BASE};name=3Dbabblesim_base;nobranch=3D1;
> destsuffix=3Dgit/tools/bsim/components \
> +
> ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_LIBPHYCOMV1};name=3Dbabblesi
> m_ext_2G4_libPhyComv1;nobranch=3D1;destsuffix=3Dgit/tools/bsim/componen
> ts/ext_2G4_libPhyComv1 \
> +
> ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_PHY_V1};name=3Dbabblesim_ext_
> 2G4_phy_v1;nobranch=3D1;destsuffix=3Dgit/tools/bsim/components/ext_2G4_p
> hy_v1 \
> +
> ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_NTNCABLE};name=3Dba
> bblesim_ext_2G4_channel_NtNcable;nobranch=3D1;destsuffix=3Dgit/tools/bsim
> /components/ext_2G4_channel_NtNcable \
> +
> ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_CHANNEL_MULTIATT};name=3Dba
> bblesim_ext_2G4_channel_multiatt;nobranch=3D1;destsuffix=3Dgit/tools/bsim=
/c
> omponents/ext_2G4_channel_multiatt \
> +
> ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_MAGIC};name=3Dbabble
> sim_ext_2G4_modem_magic;nobranch=3D1;destsuffix=3Dgit/tools/bsim/compo
> nents/ext_2G4_modem_magic \
> +
> ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_MODEM_BLE_SIMPLE};name=3Dba
> bblesim_ext_2G4_modem_BLE_simple;nobranch=3D1;destsuffix=3Dgit/tools/bsi
> m/components/ext_2G4_modem_BLE_simple \
> +
> ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_BURST_INTERFERER};na
> me=3Dbabblesim_ext_2G4_device_burst_interferer;nobranch=3D1;destsuffix=3D=
gi
> t/tools/bsim/components/ext_2G4_device_burst_interferer \
> +
> ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_WLAN_ACTMOD};name
> =3Dbabblesim_ext_2G4_device_WLAN_actmod;nobranch=3D1;destsuffix=3Dgit/to
> ols/bsim/components/ext_2G4_device_WLAN_actmod \
> +
> ${SRC_URI_ZEPHYR_BABBLESIM_EXT_2G4_DEVICE_PLAYBACK};name=3Dbabbl
> esim_ext_2G4_device_playback;nobranch=3D1;destsuffix=3Dgit/tools/bsim/com
> ponents/ext_2G4_device_playback \
> +
> ${SRC_URI_ZEPHYR_BABBLESIM_EXT_LIBCRYPTOV1};name=3Dbabblesim_ext_
> libCryptov1;nobranch=3D1;destsuffix=3Dgit/tools/bsim/components/ext_libCr=
ypt
> ov1 \
> +
> ${SRC_URI_ZEPHYR_CMSIS};name=3Dcmsis;nobranch=3D1;destsuffix=3Dgit/module
> s/hal/cmsis \
> +    ${SRC_URI_ZEPHYR_CMSIS_DSP};name=3Dcmsis-
> dsp;nobranch=3D1;destsuffix=3Dgit/modules/lib/cmsis-dsp \
> +    ${SRC_URI_ZEPHYR_CMSIS_NN};name=3Dcmsis-
> nn;nobranch=3D1;destsuffix=3Dgit/modules/lib/cmsis-nn \
> +
> ${SRC_URI_ZEPHYR_EDTT};name=3Dedtt;nobranch=3D1;destsuffix=3Dgit/tools/ed=
tt
> \
> +
> ${SRC_URI_ZEPHYR_FATFS};name=3Dfatfs;nobranch=3D1;destsuffix=3Dgit/module=
s
> /fs/fatfs \
> +
> ${SRC_URI_ZEPHYR_HAL_ADI};name=3Dhal_adi;nobranch=3D1;destsuffix=3Dgit/mo
> dules/hal/adi \
> +
> ${SRC_URI_ZEPHYR_HAL_ALTERA};name=3Dhal_altera;nobranch=3D1;destsuffix=3D
> git/modules/hal/altera \
> +
> ${SRC_URI_ZEPHYR_HAL_AMBIQ};name=3Dhal_ambiq;nobranch=3D1;destsuffix=3D
> git/modules/hal/ambiq \
> +
> ${SRC_URI_ZEPHYR_HAL_ATMEL};name=3Dhal_atmel;nobranch=3D1;destsuffix=3D
> git/modules/hal/atmel \
> +
> ${SRC_URI_ZEPHYR_HAL_ESPRESSIF};name=3Dhal_espressif;nobranch=3D1;dests
> uffix=3Dgit/modules/hal/espressif \
> +
> ${SRC_URI_ZEPHYR_HAL_ETHOS_U};name=3Dhal_ethos_u;nobranch=3D1;destsu
> ffix=3Dgit/modules/hal/ethos_u \
> +
> ${SRC_URI_ZEPHYR_HAL_GIGADEVICE};name=3Dhal_gigadevice;nobranch=3D1;d
> estsuffix=3Dgit/modules/hal/gigadevice \
> +
> ${SRC_URI_ZEPHYR_HAL_INFINEON};name=3Dhal_infineon;nobranch=3D1;dests
> uffix=3Dgit/modules/hal/infineon \
> +
> ${SRC_URI_ZEPHYR_HAL_INTEL};name=3Dhal_intel;nobranch=3D1;destsuffix=3Dgi=
t/
> modules/hal/intel \
> +
> ${SRC_URI_ZEPHYR_HAL_MICROCHIP};name=3Dhal_microchip;nobranch=3D1;de
> stsuffix=3Dgit/modules/hal/microchip \
> +
> ${SRC_URI_ZEPHYR_HAL_NORDIC};name=3Dhal_nordic;nobranch=3D1;destsuffix
> =3Dgit/modules/hal/nordic \
> +
> ${SRC_URI_ZEPHYR_HAL_NUVOTON};name=3Dhal_nuvoton;nobranch=3D1;dests
> uffix=3Dgit/modules/hal/nuvoton \
> +
> ${SRC_URI_ZEPHYR_HAL_NXP};name=3Dhal_nxp;nobranch=3D1;destsuffix=3Dgit/m
> odules/hal/nxp \
> +
> ${SRC_URI_ZEPHYR_HAL_OPENISA};name=3Dhal_openisa;nobranch=3D1;destsuf
> fix=3Dgit/modules/hal/openisa \
> +
> ${SRC_URI_ZEPHYR_HAL_QUICKLOGIC};name=3Dhal_quicklogic;nobranch=3D1;d
> estsuffix=3Dgit/modules/hal/quicklogic \
> +
> ${SRC_URI_ZEPHYR_HAL_RENESAS};name=3Dhal_renesas;nobranch=3D1;destsuf
> fix=3Dgit/modules/hal/renesas \
> +
> ${SRC_URI_ZEPHYR_HAL_RPI_PICO};name=3Dhal_rpi_pico;nobranch=3D1;destsu
> ffix=3Dgit/modules/hal/rpi_pico \
> +
> ${SRC_URI_ZEPHYR_HAL_SILABS};name=3Dhal_silabs;nobranch=3D1;destsuffix=3D=
g
> it/modules/hal/silabs \
> +
> ${SRC_URI_ZEPHYR_HAL_ST};name=3Dhal_st;nobranch=3D1;destsuffix=3Dgit/modu
> les/hal/st \
> +
> ${SRC_URI_ZEPHYR_HAL_STM32};name=3Dhal_stm32;nobranch=3D1;destsuffix=3D
> git/modules/hal/stm32 \
> +
> ${SRC_URI_ZEPHYR_HAL_TELINK};name=3Dhal_telink;nobranch=3D1;destsuffix=3D=
g
> it/modules/hal/telink \
> +
> ${SRC_URI_ZEPHYR_HAL_TI};name=3Dhal_ti;nobranch=3D1;destsuffix=3Dgit/modu=
l
> es/hal/ti \
> +
> ${SRC_URI_ZEPHYR_HAL_WURTHELEKTRONIK};name=3Dhal_wurthelektronik;n
> obranch=3D1;destsuffix=3Dgit/modules/hal/wurthelektronik \
> +
> ${SRC_URI_ZEPHYR_HAL_XTENSA};name=3Dhal_xtensa;nobranch=3D1;destsuffix
> =3Dgit/modules/hal/xtensa \
> +
> ${SRC_URI_ZEPHYR_HOSTAP};name=3Dhostap;nobranch=3D1;destsuffix=3Dgit/mod
> ules/lib/hostap \
> +
> ${SRC_URI_ZEPHYR_LIBMETAL};name=3Dlibmetal;nobranch=3D1;destsuffix=3Dgit/
> modules/hal/libmetal \
> +
> ${SRC_URI_ZEPHYR_LIBLC3};name=3Dliblc3;nobranch=3D1;destsuffix=3Dgit/modu=
le
> s/lib/liblc3 \
> +
> ${SRC_URI_ZEPHYR_LITTLEFS};name=3Dlittlefs;nobranch=3D1;destsuffix=3Dgit/=
mod
> ules/fs/littlefs \
> +    ${SRC_URI_ZEPHYR_LORAMAC_NODE};name=3Dloramac-
> node;nobranch=3D1;destsuffix=3Dgit/modules/lib/loramac-node \
> +
> ${SRC_URI_ZEPHYR_LVGL};name=3Dlvgl;nobranch=3D1;destsuffix=3Dgit/modules/=
li
> b/gui/lvgl \
> +
> ${SRC_URI_ZEPHYR_MBEDTLS};name=3Dmbedtls;nobranch=3D1;destsuffix=3Dgit/m
> odules/crypto/mbedtls \
> +
> ${SRC_URI_ZEPHYR_MCUBOOT};name=3Dmcuboot;nobranch=3D1;destsuffix=3Dgit
> /bootloader/mcuboot \
> +    ${SRC_URI_ZEPHYR_MIPI_SYS_T};name=3Dmipi-sys-
> t;nobranch=3D1;destsuffix=3Dgit/modules/debug/mipi-sys-t \
> +    ${SRC_URI_ZEPHYR_NET_TOOLS};name=3Dnet-
> tools;nobranch=3D1;destsuffix=3Dgit/tools/net-tools \
> +
> ${SRC_URI_ZEPHYR_NRF_HW_MODELS};name=3Dnrf_hw_models;nobranch=3D1
> ;destsuffix=3Dgit/modules/bsim_hw_models/nrf_hw_models \
> +    ${SRC_URI_ZEPHYR_OPEN_AMP};name=3Dopen-
> amp;nobranch=3D1;destsuffix=3Dgit/modules/lib/open-amp \
> +
> ${SRC_URI_ZEPHYR_OPENTHREAD};name=3Dopenthread;nobranch=3D1;destsuff
> ix=3Dgit/modules/lib/openthread \
> +
> ${SRC_URI_ZEPHYR_PERCEPIO};name=3Dpercepio;nobranch=3D1;destsuffix=3Dgit/
> modules/debug/percepio \
> +
> ${SRC_URI_ZEPHYR_PICOLIBC};name=3Dpicolibc;nobranch=3D1;destsuffix=3Dgit/=
m
> odules/lib/picolibc \
> +
> ${SRC_URI_ZEPHYR_SEGGER};name=3Dsegger;nobranch=3D1;destsuffix=3Dgit/mod
> ules/debug/segger \
> +
> ${SRC_URI_ZEPHYR_TINYCRYPT};name=3Dtinycrypt;nobranch=3D1;destsuffix=3Dgi=
t/
> modules/crypto/tinycrypt \
> +    ${SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_M};name=3Dtrusted-firmware-
> m;nobranch=3D1;destsuffix=3Dgit/modules/tee/tf-m/trusted-firmware-m \
> +    ${SRC_URI_ZEPHYR_TRUSTED_FIRMWARE_A};name=3Dtrusted-firmware-
> a;nobranch=3D1;destsuffix=3Dgit/modules/tee/tf-a/trusted-firmware-a \
> +    ${SRC_URI_ZEPHYR_UOSCORE_UEDHOC};name=3Duoscore-
> uedhoc;nobranch=3D1;destsuffix=3Dgit/modules/lib/uoscore-uedhoc \
> +
> ${SRC_URI_ZEPHYR_ZCBOR};name=3Dzcbor;nobranch=3D1;destsuffix=3Dgit/modul
> es/lib/zcbor \
> +    ${SRC_URI_PATCHES} \
> +"
> +
> +ZEPHYR_MODULES =3D "\
> +${S}/modules/lib/acpica\;\
> +${S}/tools/bsim\;\
> +${S}/tools/bsim/components\;\
> +${S}/tools/bsim/components/ext_2G4_libPhyComv1\;\
> +${S}/tools/bsim/components/ext_2G4_phy_v1\;\
> +${S}/tools/bsim/components/ext_2G4_channel_NtNcable\;\
> +${S}/tools/bsim/components/ext_2G4_channel_multiatt\;\
> +${S}/tools/bsim/components/ext_2G4_modem_magic\;\
> +${S}/tools/bsim/components/ext_2G4_modem_BLE_simple\;\
> +${S}/tools/bsim/components/ext_2G4_device_burst_interferer\;\
> +${S}/tools/bsim/components/ext_2G4_device_WLAN_actmod\;\
> +${S}/tools/bsim/components/ext_2G4_device_playback\;\
> +${S}/tools/bsim/components/ext_libCryptov1\;\
> +${S}/modules/hal/cmsis\;\
> +${S}/modules/lib/cmsis-dsp\;\
> +${S}/modules/lib/cmsis-nn\;\
> +${S}/tools/edtt\;\
> +${S}/modules/fs/fatfs\;\
> +${S}/modules/hal/adi\;\
> +${S}/modules/hal/altera\;\
> +${S}/modules/hal/ambiq\;\
> +${S}/modules/hal/atmel\;\
> +${S}/modules/hal/espressif\;\
> +${S}/modules/hal/ethos_u\;\
> +${S}/modules/hal/gigadevice\;\
> +${S}/modules/hal/infineon\;\
> +${S}/modules/hal/intel\;\
> +${S}/modules/hal/microchip\;\
> +${S}/modules/hal/nordic\;\
> +${S}/modules/hal/nuvoton\;\
> +${S}/modules/hal/nxp\;\
> +${S}/modules/hal/openisa\;\
> +${S}/modules/hal/quicklogic\;\
> +${S}/modules/hal/renesas\;\
> +${S}/modules/hal/rpi_pico\;\
> +${S}/modules/hal/silabs\;\
> +${S}/modules/hal/st\;\
> +${S}/modules/hal/stm32\;\
> +${S}/modules/hal/telink\;\
> +${S}/modules/hal/ti\;\
> +${S}/modules/hal/wurthelektronik\;\
> +${S}/modules/hal/xtensa\;\
> +${S}/modules/lib/hostap\;\
> +${S}/modules/hal/libmetal\;\
> +${S}/modules/lib/liblc3\;\
> +${S}/modules/fs/littlefs\;\
> +${S}/modules/lib/loramac-node\;\
> +${S}/modules/lib/gui/lvgl\;\
> +${S}/modules/crypto/mbedtls\;\
> +${S}/bootloader/mcuboot\;\
> +${S}/modules/debug/mipi-sys-t\;\
> +${S}/tools/net-tools\;\
> +${S}/modules/bsim_hw_models/nrf_hw_models\;\
> +${S}/modules/lib/open-amp\;\
> +${S}/modules/lib/openthread\;\
> +${S}/modules/debug/percepio\;\
> +${S}/modules/lib/picolibc\;\
> +${S}/modules/debug/segger\;\
> +${S}/modules/crypto/tinycrypt\;\
> +${S}/modules/tee/tf-m/trusted-firmware-m\;\
> +${S}/modules/tee/tf-a/trusted-firmware-a\;\
> +${S}/modules/lib/uoscore-uedhoc\;\
> +${S}/modules/lib/zcbor\;\
> +"
> +
> +ZEPHYR_BRANCH =3D "v3.7-branch"
> +PV =3D "3.7.0+git${SRCPV}"
> --
> 2.25.1
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#605): https://lists.yoctoproject.org/g/yocto-
> patches/message/605
> Mute This Topic: https://lists.yoctoproject.org/mt/108223014/2015869
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-
> patches/leave/13182003/2015869/177849857/xyzzy
> [naveen.kumar.saini@intel.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


