Return-Path: <naveen.kumar.saini@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A1EE7717F
	for <webhook@archiver.kernel.org>; Fri, 13 Dec 2024 12:48:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mx.groups.io with SMTP id smtpd.web10.14434.1734094126845902377
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Dec 2024 04:48:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=XqBSjfNG;
 spf=pass (domain: intel.com, ip: 192.198.163.7, mailfrom: naveen.kumar.saini@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734094127; x=1765630127;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=WUFYo4ix+G0OwwcsNoUhGI0yWFfvgxyPva0Z/c4geKU=;
  b=XqBSjfNGw4KaDkd8vsQczdLSjEhaHkhYM/SNAhY64VUzqOcAlHTDykXN
   FC8bkq95YOs93KUsLwAuZbsEWv0iqNFtERCOJPHqo6qiD10tlZs7cyzAC
   /wE4fgYddopIl8HNhyQAvgreWnRi65agPHW3Ug8KMxNGxo+wybCcAWHGC
   nAJohLHp95lash42D5u4BVzPVHU5Mn9LkgxBSv+E6jI+Du2V3e8u6bz9Z
   a1211lHoZ7/0aImo/6OXGIgGUiY0lIfz23QLMKb726zsdfzqTkqMkZ5iN
   1KND1WrxGX/yHtcVu06F3AinoYP5/qli1Cmv4bztmuvsrMdUq+kgFC3Of
   Q==;
X-CSE-ConnectionGUID: fCBGT5hIQTq6sAUrS9WDLw==
X-CSE-MsgGUID: dGBvztSIRQ2903TxwPzcmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="59940684"
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="59940684"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 04:48:46 -0800
X-CSE-ConnectionGUID: A4FHGJzBSgebQQMjoi9ZWg==
X-CSE-MsgGUID: 1/hi8iybSzGlmQSBHoPamg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="101542619"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2024 04:48:46 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 13 Dec 2024 04:48:45 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 13 Dec 2024 04:48:45 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 13 Dec 2024 04:48:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRPfzzp0PhVuYI9Ec+UdxzaA6CpU00awQp5tyOmqDjQAwkI4tirKGECxPRFY+C2sE0QIwDzWETouy8w1tyFrCWsvtouOv7GB08rqrta8jP9370UZUqUp9OSyZbDgRJ21YJ3Kd8iNYo6Mu2EW4h6xSlS/PGtmUikpsExiw4nBHkItbN871cz8xb/goaLV5y4CCc3YSgujG5dY/omqo0/KUZ1uwvtNfBLXn+Qlt3XACEd6dek3P+DzZ/3cSNNkd2oZgJv/zm8gd5bfmaZXVfoJk4bLrQswEfzoK3SCe+Ay/xe8CRnFxt3zUJvATPBBJzMvhXvzOHCRUHfbW3IOzRy7nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xj/pSqOfWZlKQnvHfMokoHSicNa0dOXFcwUpP0jUpT8=;
 b=gCrc897pdOOk3iqbNhW2OOaaiLwCNyuk3XmpMX09gzGUxhMw+Ot6CTWCCOKpItAsFHNLzBjnsSwIyroMbqkJtPRHKr/jgYFbvrwQH1TrOBfTEW0qOgGhqHoWkx/5K4WloZ543Z//zF5RGifs10LdP3AmL1t9JYWKU+yU+put+YZzZMDMXsBN7QH1ehnKeKRJXdx1Ny9iypDVTw7H3t9q/o3pqILMvN7wSxYwMi+FT3yHtsgNK7kgbV4lAaQZ+Ea0culYKMwIJqoEbg3vqK6lu+1zW8seOVgLfTaAIfWaiZcGgU7bHOv6+6NH+chUyFPvYXS5qdrFZxXEoPVj28fIXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5026.namprd11.prod.outlook.com (2603:10b6:303:9c::13)
 by CY5PR11MB6114.namprd11.prod.outlook.com (2603:10b6:930:2d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 12:47:57 +0000
Received: from CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::aeb:33f7:57:f7c9]) by CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::aeb:33f7:57:f7c9%7]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 12:47:57 +0000
From: "Saini, Naveen Kumar" <naveen.kumar.saini@intel.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: RE: [yocto-patches] [meta-zephyr][PATCH] zephyr-sdk: fix
 COMPATIBLE_HOST build failure
Thread-Topic: [yocto-patches] [meta-zephyr][PATCH] zephyr-sdk: fix
 COMPATIBLE_HOST build failure
Thread-Index: AQHbTS4HRTMKObIIsUyRcQ6t15accbLkH55w
Date: Fri, 13 Dec 2024 12:47:57 +0000
Message-ID: <CO1PR11MB5026141B53F894B4B4CDAE85C4382@CO1PR11MB5026.namprd11.prod.outlook.com>
References: <1810AAE9C134099D.31077@lists.yoctoproject.org>
In-Reply-To: <1810AAE9C134099D.31077@lists.yoctoproject.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5026:EE_|CY5PR11MB6114:EE_
x-ms-office365-filtering-correlation-id: 9cbd8165-5c2d-4121-7b88-08dd1b745e8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|4022899009|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?43RvpKIGlwlIxmMtXek0mNxMrqAQK7tYLV4WFyaoxrEMMELRnskaMI39eQeL?=
 =?us-ascii?Q?UxUcZ3drV3LTFE2DSkCB0Ut4e6YzSkIkJBsGY7XgSXkNbjE0KlZdAOaiHoLS?=
 =?us-ascii?Q?YlhpS1WHI+88YnJ3lXmWWuZAV88Q4xNZh09cNhZoj0eI0UixQYrOKHzKSG4D?=
 =?us-ascii?Q?yQVDO3Oy27kC7UBL5Yab5h+JRg2FCyKgXj/cSPz4R3LDrmQPTzkiCxHtMSvl?=
 =?us-ascii?Q?AnrlksdmtxbG2paJ1LGhtk1ldWfULUB/IGFCokC1+ARkNpo0tYW0R4LnWQVv?=
 =?us-ascii?Q?2EWFL1sYU1q8jioY0VJA+bNFsQu2QO7gR9Apc01Gkk0ZaKGzsvRoshCsL9zG?=
 =?us-ascii?Q?1aYq/cFy20BuuxqTiawnVk+qIpcM3jmmMmQbcyaR+8PvcBfzYtumjVq1rucs?=
 =?us-ascii?Q?7QSLtzJrk55sB2x/8Xkd1/Xlc28+xwjg0r3ZOM5HpETq1bjWdtfB/8Cnhu6a?=
 =?us-ascii?Q?xDeth0nHae31ptbvv8ZUvFBWCpAuf0T9vyv8KJ2abbYcRECWKM5J4+Y8MwTh?=
 =?us-ascii?Q?7WOhUVGb6P/U8P4hnYDUCAvNAGiwrI8VNxUH0u89rBCqhUnA9/TuHvYWTE1w?=
 =?us-ascii?Q?27WMkwN/hm2mYmqVHtsKq4FyaAUVxj701+9tMcNKn5L+x9eGjj4247UJELGW?=
 =?us-ascii?Q?TtXgULJq1FKrKK1pLmeL9MXCdTuEWE6wV2bXOGwihKwnZVF05IeqwLoJ56dt?=
 =?us-ascii?Q?rbtsrzxiIdggluYk0L8JpraXp7ChjadKhY3+6ow9iXhPdq10rBJzlTk5lzV8?=
 =?us-ascii?Q?SMfLIzfB880IFX+gEqEOPZoEhrMQDo4A8B9WIDvW4CcZUZ4jvenOv0jyqpNb?=
 =?us-ascii?Q?mu7qwJfwMpuMPQPuMatZJ5mXxEQXBOoqjlyF42MHLl2/YB3WAhiOl++24Kw2?=
 =?us-ascii?Q?VRDkh/lLrP+KF3b0q1gRQfhl00fO0Me/3x4gsAmFmD0qfcLqWZS4VeOaWEVA?=
 =?us-ascii?Q?eKvH16X++zouG2SaNqMQNnElzCBK8/wPNuPbaFKtWbCy/1rlZzyZ4KcZ/zmA?=
 =?us-ascii?Q?iKREnKU4z7RC/7gh2zL9tH5waiZToQbMGBcVqbuAzsrYQxtXiMoFuGDdYETl?=
 =?us-ascii?Q?Hj1LgVjr+pham8W8IWsOMlTDKZAe3Y5dSK/Bi/MhOKR989Z09FWGcPPiOl6j?=
 =?us-ascii?Q?KXnk6j7MfKLp6E7/cTjbbttDwqT6A4+VfGd5FA+ruU8OfSAp8/ie8E4GilKI?=
 =?us-ascii?Q?l/1zgnQyOmvCJzWynM1mdhRjr3h8Ku4Qceo7Y3e8SMKcUG9C2y9v3KKieSx2?=
 =?us-ascii?Q?4yTJk6W2tpYAcv5dmZADoBbBFL2hk8lDCNw6a7kZtk60eaP0GmbVSQjD01/G?=
 =?us-ascii?Q?DQ3ibolMbw5qzOydjCUP3qUMtadv0v3Y3UTE7aGI2yYKi8/CJZjvKGEZaeY2?=
 =?us-ascii?Q?+Jhkx4g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5026.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(4022899009)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SL3tQS0JCYAWygDPmafaTQn+2i/KJaCNuXPnuQW7AKVs4GM8/5CGpyAn50oG?=
 =?us-ascii?Q?Bdo5YqRkdNLtC2nTdLSdv0QOUjER1f6tvcCgVcMRleaCpTPLtLZ+EZJp80ZW?=
 =?us-ascii?Q?TYgGC0SuTrD5OUMR9nPSsWOGmuKSwPn8p0r5g2j+INjQ9Jmt2h/cwb+Y27HX?=
 =?us-ascii?Q?kK+bnnJMgAVVgiVwUfVFA40Yrbg9jSeBIMkKPNS64kVodz28sdXDq2XpIT9y?=
 =?us-ascii?Q?+5KauJkPTTxTZi+VuvslANE5cM9KLLrOdwvfzZEGXK+8Ey8aLG5mbp52/fEG?=
 =?us-ascii?Q?heShZL3TXXr5EVuF/OuF+FOHnBSyYFBtQX1iZkyNxFdIl/80hXJaUwLHDZ4e?=
 =?us-ascii?Q?tttop+z6BqrZX4uJX+4pRowfhpkZI43hc+FpYrqWVB86c+i7U4baaqVa5OSu?=
 =?us-ascii?Q?anfOtMNgbTpNAw1t6OHQVIktG40O0/oiN+A2aK2T+JLqw9r/HN4sa7beyK+6?=
 =?us-ascii?Q?0tlgT12xQ7f3/7vmnveFbkfIyxppRwjUmx+xLE3I+IYEb0s5ZNH+LQRKFfgF?=
 =?us-ascii?Q?YwQYUNReXUbDvWLeYk5p+FrLV0BdrPPF34O+1p2Oe2VlRJ4znls2W63a6Zsd?=
 =?us-ascii?Q?pI6j5mATl5zsvMUxu94jegTRGUOZdMowaUxjfZAi1eSGmI2wwR+6JVU1KZMg?=
 =?us-ascii?Q?RFJu5oeQmrEqVmZcPkaqeofnj74IzBXgqxuMEOiXgv2RmXl1lRy5eoI/8Ti0?=
 =?us-ascii?Q?fLJnP3rL++/C0/PUQHEj1YEFkDWu3WKJFOp0DQZiQbwbnMs4Ok4sqRc5tQOs?=
 =?us-ascii?Q?o4B4hvHbdna53HUE6z1dgo/NLSJ26326tudsqRECyz5QvKtQakrmXglWd5aP?=
 =?us-ascii?Q?y0dEACVBXl/51VB3DEk++zXBqhY8qE/Gx/804b/JVK20OtpqguzLObmSJTgF?=
 =?us-ascii?Q?rOF6TZcHBeBzoDwtkZTSCoSH5KslhAHW3NmnSvxGnOCy/w33/T9Ij0cDB7OV?=
 =?us-ascii?Q?43sk4nHZLGrJ6Zek07gFNH15Ya0tYKkb36z3LrmOhfMTjgf0ZYBgjgf85m9n?=
 =?us-ascii?Q?q/qZUsNRldnsmqCqbEekQE1zgMRs6sNPg0MqBldEM1mddwiJI5P9/dwziF7q?=
 =?us-ascii?Q?wjyvWrlgh+XZJUUvwIJA+tNB5QtHXKNmzVLf6HuyqvEGJ1BIjK8Qh6lVLuAJ?=
 =?us-ascii?Q?Q6EYBdzjXBc47Ao8X+kYiVXJ0qdFj6N5VXN+KZADDPQ9yIp2Au13ngIn9Gpm?=
 =?us-ascii?Q?PGdvFI5TxTVQorT+nlxpqyAwU9MCwokwxd2PGpfuKTSIHkiRg6mJUJ62PPY2?=
 =?us-ascii?Q?VvE0faKM2S2/KQtg1ptTsa524ktDt4kRrBlTiU8OTNZABogAzdU/cj0K2w3l?=
 =?us-ascii?Q?iH2NkLdv0UHPEOmjYKY2i07/HeVZNui/wqK/SjnnmCD9RmoNER65uCLgEfzo?=
 =?us-ascii?Q?I9jnhbHq38yqVlWp3J1Ted9dbrDmvF08u8KLutt0Lkfl8JeF87wEaOAfPpvt?=
 =?us-ascii?Q?SRT29ZRei2ZEif/KQj1/pcynrMNSnPvmmVNOWSu7ma2RlE9tzZ67pOKCEfQL?=
 =?us-ascii?Q?EMoL04Z8IOYL9bLm2o5bSBoi2CRE5lSx3h25eATEiYUY4s1b8SM6u0AHiuzG?=
 =?us-ascii?Q?zOexb+3R8Ur4H+hIdyl7s4SRtXXeA3QzGJW9UKrgOjc3i5mYTE85tIuWT0qA?=
 =?us-ascii?Q?8Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5026.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cbd8165-5c2d-4121-7b88-08dd1b745e8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 12:47:57.2210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jpgQQnrnR9LGART7Jpb8iXKe0Ri/FQ5sfi07b0a4C/UIAMV0+Rb71WoUb24V1fUv+nQ/FIJ8YOJEbQilDvmknH+uiQE4TmnSOk6ovTvUGs4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6114
X-OriginatorOrg: intel.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Dec 2024 12:48:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/894

Please ignore this wrong patch.=20

Regards,
Naveen

> -----Original Message-----
> From: yocto-patches@lists.yoctoproject.org <yocto-
> patches@lists.yoctoproject.org> On Behalf Of Naveen Saini via
> lists.yoctoproject.org
> Sent: Friday, December 13, 2024 2:21 PM
> To: yocto-patches@lists.yoctoproject.org
> Subject: [yocto-patches] [meta-zephyr][PATCH] zephyr-sdk: fix
> COMPATIBLE_HOST build failure
>=20
> ERROR: Nothing PROVIDES 'zephyr-sdk'
> zephyr-sdk was skipped: incompatible with host i586-yocto-elf (not in
> COMPATIBLE_HOST)
>=20
> Signed-off-by: Naveen Saini <naveen.kumar.saini@intel.com>
> ---
>  .../recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb            | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-
> sdk_0.16.9.bb b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-
> sdk_0.16.9.bb
> index 57fe777..da30b17 100644
> --- a/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb
> +++ b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-
> sdk_0.16.9.bb
> @@ -1,7 +1,7 @@
>  SUMMARY =3D "Zephyr SDK Bundle"
>  DESCRIPTION =3D "Official SDK built using crosstool-ng, distributed by t=
he \
> Zephyr project"
> -COMPATIBLE_HOST =3D "(x86_64|aarch64).*-linux"
> +COMPATIBLE_HOST =3D "(x86_64|aarch64).*-(linux|elf)"
>=20
>  LICENSE =3D "Apache-2.0"
>  LIC_FILES_CHKSUM =3D "file://${COMMON_LICENSE_DIR}/Apache-
> 2.0;md5=3D89aea4e17d99a7cacdbeed46a0096b10"
> --
> 2.37.3
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#892): https://lists.yoctoproject.org/g/yocto-
> patches/message/892
> Mute This Topic: https://lists.yoctoproject.org/mt/110094051/2015869
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-
> patches/leave/13182003/2015869/177849857/xyzzy
> [naveen.kumar.saini@intel.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


