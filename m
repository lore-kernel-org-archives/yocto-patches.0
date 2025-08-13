Return-Path: <chee.yang.lee@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFC1CA0EC4
	for <webhook@archiver.kernel.org>; Wed, 13 Aug 2025 03:14:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mx.groups.io with SMTP id smtpd.web11.92199.1755054838724059755
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 12 Aug 2025 20:13:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=SVd3U+N7;
 spf=pass (domain: intel.com, ip: 198.175.65.13, mailfrom: chee.yang.lee@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755054839; x=1786590839;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=V/7UEPn8FdIy35vI6zVwGqIUP6wTp0GHZwtRziKKaVE=;
  b=SVd3U+N723o2oXUdp0u5oS7CeZXBaLHqqbLQ+N2TzxgX9euHNfPjvicX
   FWgXSmo1yR+JjNgheCQqOmlBaai84DPsQf5oGeVeenNB54bUd49fYDj2r
   /WrfNqSFZ4htK0dx57Gzl+hUpO4Pn1TbirxLLujx+UczfaPvtznle17Sy
   7v+v9VL/R2GfAhtInZtGzMjbQah8qWp4aRIUWaX8imPsBZHTBvoAZbwe4
   GTKNYr4Oaw3awS5Jru/f7u19ZOwOBCPiDFFJVsQxn0EBQx5Q772DOi7s3
   Gq3p41zl+BY9AJcuf1BHalFesvRaQvzWz6EKZ/7de557XtwFcde2zRwGW
   g==;
X-CSE-ConnectionGUID: GZ1x+gOmTCmoTl9MmHeeKQ==
X-CSE-MsgGUID: 1rvapPxYSIuGCYRZMV6XCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="68415584"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="68415584"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 20:13:58 -0700
X-CSE-ConnectionGUID: oSxUKa36Qt+5ClOgXPf1lg==
X-CSE-MsgGUID: XKdSqXnrRVihcZ0oJeBXrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="166629219"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 20:13:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 12 Aug 2025 20:13:53 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 12 Aug 2025 20:13:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 12 Aug 2025 20:13:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylXLmRb1q0PixUscndNHc9kboAlVFda71kejTYxVOW4fMPGKZDfWBKVGnNQsjjxfryukyrUXtW2pFU3Z0ImFNdfYw/pH1fGPZ45vZnVRbfPJ4h8mAaUegZNqq3yUeHdXLF88Zv2nOGzDSLFx0RdbzxwYr/wWqaWcsUqcFX8I/k+/LBECG/yAx1vLgMARGPGKePIZFRT9H/BxIDUbie2FTethL05f4ubCNndtj294TztzcMHefD5ihhtnsiQ/1lmAb5ohgGMi5IYpL53o6DNLPiZXFO1i0KpHLvm6/cjm1AgIxL//TJl+1hhn6BcqTjShkVrm6DN8AIKOpOeh6iOCIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SipF8OYNeY0+qXiglvnBRtOSuwYO3eIIXBzYOhpIZA=;
 b=L7FhNIish4E/e6/+tv7E6Ygoht0bZZI95s5r4mX7nw4rZM+Fdqc5Mf3dpMms3WXcuu3MoN5FJlYYY4B4FUqcx508g9ybjvGp/OxsaDVg7esos6gCVHE1adOH9qiLeGx4J5Qz44N2SPEG5l/GT5Z53IONR5snO50STBVw+HnRXXpGmcgdBfZIT+tR5EkQL1zn/I5fpGT/odzdNZdqDU8LCv1v+ztiRSepY8zxifuGghoLjNzYttsI0bxqtFiSXgROOvpOmsrNprAjawHy71+i56Ry63lnMJifSY/yZGbh++vXLCUkc9aC1Czx8NY54BmqPSR+n1mw7OSEVxjZ/ozxmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL4PR11MB8797.namprd11.prod.outlook.com (2603:10b6:208:5a7::8)
 by IA4PR11MB9202.namprd11.prod.outlook.com (2603:10b6:208:56e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 03:13:14 +0000
Received: from BL4PR11MB8797.namprd11.prod.outlook.com
 ([fe80::311e:565b:ccfd:f4c8]) by BL4PR11MB8797.namprd11.prod.outlook.com
 ([fe80::311e:565b:ccfd:f4c8%5]) with mapi id 15.20.9009.021; Wed, 13 Aug 2025
 03:13:14 +0000
From: "Lee, Chee Yang" <chee.yang.lee@intel.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: RE: [yocto-patches] [meta-zephyr][scarthgap][PATCH v5 4/12]
 zephyr-image: Add image artifacts to output files
Thread-Topic: [yocto-patches] [meta-zephyr][scarthgap][PATCH v5 4/12]
 zephyr-image: Add image artifacts to output files
Thread-Index: AQHcC7Bu/DmjA0VRkEG7stLVdXF6erRf5uyg
Date: Wed, 13 Aug 2025 03:13:13 +0000
Message-ID: <BL4PR11MB8797DFA56346369056287E86B92AA@BL4PR11MB8797.namprd11.prod.outlook.com>
References: <20250812174147.130972-1-sandeep.gundlupet-raju@amd.com>
 <20250812174147.130972-5-sandeep.gundlupet-raju@amd.com>
In-Reply-To: <20250812174147.130972-5-sandeep.gundlupet-raju@amd.com>
Accept-Language: en-SG, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR11MB8797:EE_|IA4PR11MB9202:EE_
x-ms-office365-filtering-correlation-id: 5d95d210-2282-4ef8-4b18-08ddda17574f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|4022899009|376014|7053199007|13003099007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?tBxNE1re4vXQV8gRsJ+uzkmEmrDV7hcqb084iqmjYGCU681Xm8RYjV1zFGtP?=
 =?us-ascii?Q?uGW5SG658KxG9qHraTo7PoZ1AqerE9dI6AfNGjEKXHJTizvzpCvjmcuEaqB8?=
 =?us-ascii?Q?99Vbsca0iFs2+VXhLytI2vlcjujnBZ+9+3iITcmHT2yYbm6oBdkcjPUgVg8d?=
 =?us-ascii?Q?w7+ailjUgP45fH+ANI+l1uUcC07utfW+xs+C4uRoS3DdKhmlnZItqcxt6QeL?=
 =?us-ascii?Q?i9bfzqCYHr0XxfRN5G1lWsCIWAAxRVKTQu3aB9U0LkVRo7WDhSw+FhQbtWWm?=
 =?us-ascii?Q?0Y/cXw5pS8Rij0xCe9nRGDzw1YhGKLRoZ85UcsHwnnKcQfqoBRmpkSXiku5y?=
 =?us-ascii?Q?ozGArBWDZ+SJvDIZQfW/uVdV+7U3aqi/hzrl34eAS1yvRfX/sNz5L4a8VFwf?=
 =?us-ascii?Q?IvvwSPP+1ioODiwCq7yWMa7KJIQueME7V1jkdWYCtjk8iWhKy/mUwtJmwG6j?=
 =?us-ascii?Q?kH+wHq1Cby+OTwwmrwUFo60fyBhWbgwJzj/TheNaeAMRnJkpsenw6fe+EhDq?=
 =?us-ascii?Q?HnUgzji3Q/QV5Jnwfpcczk/lPwfzjSqcGpXB1Iakv/j3AROjzqKAlP2v/Zby?=
 =?us-ascii?Q?mP5d3fNwc6f/pQ1fEGWF1O7mD16C80j4PdoHkKL4Mc2X60WUP3VIKxupbz6e?=
 =?us-ascii?Q?VUlS98uiPxpbGXfsiC1nZY1SwTxFAt8didJTv7OiV7cMwpJ9pS4ERoFLbAQb?=
 =?us-ascii?Q?+O5zHeYrotn8F5MhmC0XV6UcoViHKGUqKC5buvvOl5Jb9vEo4Pi0lh+63IYE?=
 =?us-ascii?Q?SW05WhS5zq6eEsE+DPw+z5QtZAqnmX4UZmXZlsxPE0L7eeKqPSxiyixQt+VL?=
 =?us-ascii?Q?dF8U80122Qh/6wejPhMBQuEsX2ukL82Atm1AhFVEZNx+wJnRHkXzVFket4Ed?=
 =?us-ascii?Q?uAC/EqQLz0AHGgoC4mBNRSWH4tLn6aSnBGYKmicssXTv8m6z7quoIP0GEycB?=
 =?us-ascii?Q?X46rxWI5NtkKyEXCHk0y8U559CZTDwxZcb+F/XXAv0LWfm0c4T8pMAddqStZ?=
 =?us-ascii?Q?qv+g1UsF46LZ5vcE4ae+VGOJYbh2+gLivTPg15XDgD1K1+E/gDd3IcY0UHva?=
 =?us-ascii?Q?Vb3Kr2sXk3fXV0i7vg0hdhVyyoO3lzfq8toATcOYEG/uFAfiHYRHUooP6WVw?=
 =?us-ascii?Q?UNB0393JEMPXltC7vTJCwDXhXksM/W5Cjr3bWQgGKyRsB98ahYs3mGErl2fV?=
 =?us-ascii?Q?xsJnA/Up6AZA8hw9k0ucyPJhZ47QQYRAhgp0nXFNK29A3ZaWJuSYRZHDGOG/?=
 =?us-ascii?Q?fGxaIoSbPJR6JZvWHv+52sUa2VbrcGwL2qHnreoigXpN3PacfhfjbGoQb2YW?=
 =?us-ascii?Q?sazhnd1k4qzdyluBE1mbzDSm+u9ek+nxXtVUW/bKuONt2qMQWCpINlr4GpV9?=
 =?us-ascii?Q?GnqSk+3R4kfLTGTh9lATkcRUXPLNFZSW0xbjHC7jneirYEo5Mt5ylMoEr6st?=
 =?us-ascii?Q?r96+6q6u0Dk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR11MB8797.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(4022899009)(376014)(7053199007)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0zbBW2YzVW2YWuc/GsBKGkFzCzuwx4l50TmsvxgXPlH8zYtaNMbr2fw95+RU?=
 =?us-ascii?Q?v9QBNdzgZiXsEdOmB39VcuSgX1tW9t1rNoMxErpokS1RwIaXVveL8uV4zRds?=
 =?us-ascii?Q?H1/llnOXlxQSOkXnG3QTJJl5w4d7HcH2nvyhXF1vd4TnpdwAItTnT+vWG+W/?=
 =?us-ascii?Q?pPxwBJTROP6bDCdimjfCiTwKL2j0+VymiEbZZC+QDgeEhWx3cIievVq5fjHV?=
 =?us-ascii?Q?A5CGiN8RTFlBknDGCT8IeiWhyc6uEfp0LhQ7fqqlR7W/mdi4XNS6whLb3frR?=
 =?us-ascii?Q?m2oHtB9turDrnj37pMI6sJdGl9PYITgRef3xyrr+l5jwvTWKcbvBO69Eem1P?=
 =?us-ascii?Q?w3oYszyVjUCbuk/GTxHrw5b1FDt1e5w9YX0picpNnk/POmeh1uVe8TGdhZ9K?=
 =?us-ascii?Q?JdlLQoLDGQrdzuQOgf2Ma3CMwNeGVvfwVAV89tftEiXroRiCUhRYPT5NqlLS?=
 =?us-ascii?Q?JuFEM29cRrkRxDX3ry9f1mGKuiSoFmTrpMVhY+7IOxmtlfhvWPn0SQZKwkrB?=
 =?us-ascii?Q?yqVITkKOuhHwpWRHO49NZXr9DMPq2zkGk+HYgdqZG4QNIR7Z/s+y/RzV15fN?=
 =?us-ascii?Q?HOJZDegb5/26yXHG+5dFBkOPIe1MmaHmQp1jRRf9OhypLa3hBCqMjPz0+1YO?=
 =?us-ascii?Q?ZYhB1JxJDMdJp0hQmRD0Q5xFPSbcItt4U+jbU5iHhghR+PhEUbNqpB5WB22t?=
 =?us-ascii?Q?JiYrur/sPZvDMkkFZS4prU3YZKKfILBuqdZYF6ExvZEdtDVRH3Itxvfkp5Mb?=
 =?us-ascii?Q?Oq94xqz83HX5BUxHFx0JXEn4uw/dZmN9hlHeXZOiQ3E7PTVwRrP9zR62klW3?=
 =?us-ascii?Q?bDibKsuF+8LeeU4accQHwJgjN7VyZADuurYgiveQO0G0Ct/+lQ2r3LjmMQi9?=
 =?us-ascii?Q?d7YnHJtSPy7EVJOotyuI5SdHFEN0/R25bf9dDkCeU2Bfad9RfHsahYRTZRtX?=
 =?us-ascii?Q?ND5pK2pO24/ZTnaHk01decopcvlFzotLRVbIMBHPJKiBFoJHlLYj81c7pNmG?=
 =?us-ascii?Q?EPD0zsoFm4d7QadO4KvPTZWfzwWM1EFYnFeU+r3rfOhguohhGzPjwRynTpCa?=
 =?us-ascii?Q?izcnglZj8ZJ3WCmiu7BbAomkKx7qDF+G2S8Z/sZvEum1KpYLuV7KHqr7qcgn?=
 =?us-ascii?Q?G9kHCaT5VdS3Oh/dQ83H17WP9hZPk6x4GShFs/c+dVSrMMbYh4BfSP82Mnqz?=
 =?us-ascii?Q?4ENHt2V9zaFFqKqQ0Sp+Xj0MoGkLM2UphMjGBICDAiiduEshzyRE+lOm4xJq?=
 =?us-ascii?Q?jzP74ik57tEtCpgBgfGZ8wC601ecuQzrrBSACqtVxVUPM5cHmLdRnRSF7+Q+?=
 =?us-ascii?Q?ApQIwi4QVzRGeFSL8Vdig7KujhqOBSdxqawiy/s74YMSdznNTYqtR3si2fTl?=
 =?us-ascii?Q?7ZtCipjfaJQs+bIyH91T9mtZiokF2rFaJ+6jqawk5UV7boiXZkmekCZ2TTVo?=
 =?us-ascii?Q?rKPS0Y9ZNjhTPNBA6BG7X3SirZXT3pvdwTEvnpcONo4pN6tqic37op44OLJv?=
 =?us-ascii?Q?suxDOj/hLnZggUIQrLfnQsXTfPgokNlMYAHv82IxQzUPY8p+4/HYpJN5hAkW?=
 =?us-ascii?Q?mCeZB/xoajocFT19/mZxeHi7IrMjE5ALQnS1bBlu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL4PR11MB8797.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d95d210-2282-4ef8-4b18-08ddda17574f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 03:13:13.9825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c44rzI3iKBVb97bJ4y8yv8KQYq2GtAQ/1txwBHo6YYn3JL6lQcPXMVin+jtAAKpKxGryIhpQnagVcY39a3xJgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9202
X-OriginatorOrg: intel.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 13 Aug 2025 03:14:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1975



> -----Original Message-----
> From: yocto-patches@lists.yoctoproject.org <yocto-
> patches@lists.yoctoproject.org> On Behalf Of Sandeep Gundlupet Raju via
> lists.yoctoproject.org
> Sent: Wednesday, 13 August, 2025 1:42 AM
> To: yocto-patches@lists.yoctoproject.org; Lee, Chee Yang
> <chee.yang.lee@intel.com>
> Subject: [yocto-patches] [meta-zephyr][scarthgap][PATCH v5 4/12] zephyr-
> image: Add image artifacts to output files
>=20
> Inherit image-artifact-names bbclass in zephyr-image.inc and add image ar=
tifacts
> to output generated files.
>=20
> Before:
> zephyr-helloworld.elf
>=20
> After:
> zephyr-helloworld-{MACHINE}-{DATETIME}.elf
>=20
> Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
> ---
>  .../zephyr-kernel/zephyr-image.inc            | 28 +++++++++++++++----
>  1 file changed, 23 insertions(+), 5 deletions(-)
>=20
> diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.i=
nc
> b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
> index d6ee21f..93d36b1 100644
> --- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
> +++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
> @@ -1,29 +1,47 @@
>  require zephyr-kernel-src.inc
>  require zephyr-kernel-common.inc
> -inherit deploy
> +inherit deploy image-artifact-names
>=20
>  OECMAKE_SOURCEPATH =3D "${ZEPHYR_SRC_DIR}"
>=20
> +ZEPHYR_IMAGE_LINK_NAME ?=3D "${PN}-${MACHINE}"
> +ZEPHYR_IMAGE_BASE_NAME ?=3D "${PN}-
> ${MACHINE}${IMAGE_VERSION_SUFFIX}"
> +
>  do_install() {
>      install -d ${D}/firmware
>=20
> -    install -D ${B}/zephyr/${ZEPHYR_MAKE_OUTPUT} ${D}/firmware/${PN}.elf

Since this is for stable branch, I think we should keep the elf/bin/efi fil=
e with old naming. We can deploy both ${PN}.elf and ${ZEPHYR_IMAGE_BASE_NAM=
E}.elf,  ${PN}.elf can be copy of/soft link to latest  ${ZEPHYR_IMAGE_BASE_=
NAME}.elf, same for .bin and .efi.





> +    install -D ${B}/zephyr/${ZEPHYR_MAKE_OUTPUT}
> + ${D}/firmware/${ZEPHYR_IMAGE_BASE_NAME}.elf
>=20
>      if [ -f ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT} ]
>      then
> -      install -D ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT}
> ${D}/firmware/${PN}.bin
> +      install -D ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT}
> + ${D}/firmware/${ZEPHYR_IMAGE_BASE_NAME}.bin
>      fi
>=20
>      if [ -f ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT} ]
>      then
> -      install -D ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT}
> ${D}/firmware/${PN}.efi
> +      install -D ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT}
> + ${D}/firmware/${ZEPHYR_IMAGE_BASE_NAME}.efi
>      fi
>  }
> +
>  FILES:${PN} =3D "/firmware"
>  INSANE_SKIP +=3D "ldflags buildpaths"
>  SYSROOT_DIRS +=3D "/firmware"
>=20
>  do_deploy() {
> -    cp ${D}/firmware/${PN}.* ${DEPLOYDIR}/
> +    cp ${B}/zephyr/${ZEPHYR_MAKE_OUTPUT}
> ${DEPLOYDIR}/${ZEPHYR_IMAGE_BASE_NAME}.elf
> +    ln -sf ${ZEPHYR_IMAGE_BASE_NAME}.elf
> + ${DEPLOYDIR}/${ZEPHYR_IMAGE_LINK_NAME}.elf
> +
> +    if [ -f ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT} ]
> +    then
> +       cp ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT}
> ${DEPLOYDIR}/${ZEPHYR_IMAGE_BASE_NAME}.bin
> +       ln -sf ${ZEPHYR_IMAGE_BASE_NAME}.bin
> ${DEPLOYDIR}/${ZEPHYR_IMAGE_LINK_NAME}.bin
> +    fi
> +
> +    if [ -f ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT} ]
> +    then
> +       cp ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT}
> ${DEPLOYDIR}/${ZEPHYR_IMAGE_BASE_NAME}.efi
> +       ln -sf ${ZEPHYR_IMAGE_BASE_NAME}.efi
> ${DEPLOYDIR}/${ZEPHYR_IMAGE_LINK_NAME}.efi
> +    fi
> +
>  }
>  addtask deploy after do_install
> --
> 2.34.1
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1966): https://lists.yoctoproject.org/g/yocto-
> patches/message/1966
> Mute This Topic: https://lists.yoctoproject.org/mt/114670142/1648606
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-
> patches/leave/13233161/1648606/629479993/xyzzy [chee.yang.lee@intel.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


