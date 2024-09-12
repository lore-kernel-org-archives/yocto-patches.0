Return-Path: <naveen.kumar.saini@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831AEEED613
	for <webhook@archiver.kernel.org>; Thu, 12 Sep 2024 14:59:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mx.groups.io with SMTP id smtpd.web10.49952.1726153190741649271
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Sep 2024 07:59:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=WuWEwT29;
 spf=pass (domain: intel.com, ip: 192.198.163.9, mailfrom: naveen.kumar.saini@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726153190; x=1757689190;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lMxIefSBHpsl8bYAvYuImg9o65HsVy2nWyx6PQEtDXg=;
  b=WuWEwT29IYY5WA71b+CIQzmVgCXSiAAeQARc95u9q4TZeMi4DlwxzzJZ
   Uan0hdX/FbUlSLIzFBWJALPKu6B4OM6BS87ohO02I1nGE3Qfv6a9kPrqI
   jhmoBtBT6oiVVfz90LVKiq1Hnhvwl9BeXyF6sOrcFq1eeNBPjCnsq7KAp
   kKjom7MGcQGTazhM3lns6g3ktmSWq3CMn0RvpLW0OZfKc4ylFYRP2C4BY
   YenurGZ7gwvx4TE46g+KcIfwlbtJFXu7pc9zLVtllrOGMXN0VIVAVu/P/
   nMT+G0JE+Iu4RwzDMI6N09GXz/Dqka1A8cx6voFxcqxxZqhUf3YkBhBZF
   w==;
X-CSE-ConnectionGUID: 0giFj2cqRc6jb6xTBPCTCQ==
X-CSE-MsgGUID: FIWzlf69Rx68nOPePTt+ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="35680584"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="35680584"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 07:59:49 -0700
X-CSE-ConnectionGUID: jZXDlDuXQIex5j8EHRiOFw==
X-CSE-MsgGUID: sZCe9gnzSda9bILXRYf7EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67347366"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2024 07:59:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 07:59:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 07:59:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 12 Sep 2024 07:59:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 07:59:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4O7tKoI3JRaOP7+QrT6n86cZ9ehdL0e+Sv1eG5i6Wv261pX5lpM4rKMWLUhsmuTKtW7FzMij5WZG/komkJYcuWZgx76j+38Qp1rTIROGrTdtP1zfIrbn1RZEDigiDbVAeGOCtz3dA5tDzjVYBLPXDjmyC1VU14CLq4CStOV7qu0TNh1uwYxN4iMYsM7eEtlNZpUXSed0/LNM1qopkhwdTfTXRdQbMuNEUT342f3ztqJ/c9jtHAo2S0SI4C+KbpSsshMS/TNQE2E2YE7s87/r2FnnUewbbq+mR8qdnLJl77CUb/ttop7Hl/RgnP+FetdiUOZo9OHBazFpJS5KIPy1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agAcF41FphInlQjZXmLBiSTkTx58vEE1neanJu1HQ5U=;
 b=jAAXQNpZPM/1fHevq22BvONlVB95v+a3HsLru3QdqsADtUrsabd2TCkS7oRmp2dLw1Klrk98395z4hJBpcV+k8jHA1B7aIyNZkcVJLIbMmGu/DTV+o+PmFnLWvzoauqbVb9zWxvBHdN0FwdTFfcQSme92x19qCx0dP3k3FvaogQ6SFu9/o5DSUslR3RT968tixtZ02pg3cVnxTeeAED+Wvw8PF1V6hEmz3Q2MkVRUWl8b0nZpa7JR7FACKFkuc/785519Q2pb+1RmXxBr7f9kBBAY830iwkXra95hj9lNIhClos376Xkdi8mhCA4RbJlNYV+xIF7Kz7THFju9da0hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5026.namprd11.prod.outlook.com (2603:10b6:303:9c::13)
 by CH3PR11MB7392.namprd11.prod.outlook.com (2603:10b6:610:145::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.33; Thu, 12 Sep
 2024 14:59:42 +0000
Received: from CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::aeb:33f7:57:f7c9]) by CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::aeb:33f7:57:f7c9%5]) with mapi id 15.20.7962.016; Thu, 12 Sep 2024
 14:59:42 +0000
From: "Saini, Naveen Kumar" <naveen.kumar.saini@intel.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: "troy_lee@aspeedtech.com" <troy_lee@aspeedtech.com>,
	"jamin_lin@aspeedtech.com" <jamin_lin@aspeedtech.com>,
	"jaminlin1207@gmail.com" <jaminlin1207@gmail.com>,
	"vince_chang@aspeedtech.com" <vince_chang@aspeedtech.com>
Subject: RE: [yocto-patches] [meta-zephyr][PATCH v2 2/2] zephyr-kernel:
 support to deploy users customize image
Thread-Topic: [yocto-patches] [meta-zephyr][PATCH v2 2/2] zephyr-kernel:
 support to deploy users customize image
Thread-Index: AQHa/QQYF+rQShlKP0O4xmGdjXqQLbJUTdHA
Date: Thu, 12 Sep 2024 14:59:42 +0000
Message-ID: <CO1PR11MB5026A5A109E365730E9E8D83C4642@CO1PR11MB5026.namprd11.prod.outlook.com>
References: <20240902064733.651635-1-jamin_lin@aspeedtech.com>
 <20240902064733.651635-2-jamin_lin@aspeedtech.com>
In-Reply-To: <20240902064733.651635-2-jamin_lin@aspeedtech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5026:EE_|CH3PR11MB7392:EE_
x-ms-office365-filtering-correlation-id: 51c4d641-0a9f-44d3-e7f2-08dcd33b8840
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|4022899009|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?vi86TrIiqFbTT92mIfb96tVcegZN28z2Lb7i4A6IO2ZrgYYHicKJOLvNtMQg?=
 =?us-ascii?Q?6SxRWEXkJ2szjxw6CXBPp52BZqsMIo62+pL+cd3zWPPpLhkTEXkUolbwAD5L?=
 =?us-ascii?Q?JHTzUwLTTLhgiEx+B/d0rmUPcqvI2IQMQBPYWSN83XPBqPPO1KEYITCW65bp?=
 =?us-ascii?Q?sYolnjUWbTBKzWcxnRLbiOoi1ga0XDf00WpGzKuy2tZL+uvEM7V4Igu7jf5I?=
 =?us-ascii?Q?3hoNSXYktx9KSwRVp0Ep2qFKlBbtkP+d+fgkqoZYzHwmjDYCPtWqA7r3WGgY?=
 =?us-ascii?Q?mlVNSM03TWJUuvGR+1uGIzv2pFdIsVhI5IRpdjsB2+bXLrxOR4Q2mUMLeXD6?=
 =?us-ascii?Q?AnVeawwVNQLspYhmvXJp3A7/Lqo3l5x7SL0ULMtfMsjTAwKf3kZccLzKGGho?=
 =?us-ascii?Q?KJnFEickLFSUtpfwTpMu6DQV9n23AU78QLXMgDAfpO8TQENqDBONvWH/BiUm?=
 =?us-ascii?Q?XnBxF1YGXxQb3Qj9R3LE8JOZ29uYYoh8ltyLY4QQkEQ82mzjtrH/+CRNXCaw?=
 =?us-ascii?Q?lpl6VL1HH7w2DVDsTk9vY75A/J2VZGRq4JW/zjg0iEbtSo3tg5k0ncAR9d3q?=
 =?us-ascii?Q?FKOTjsvwQwCkmQdWB6okF7E6C+FqA5wLgAiKi4WhGTNmAZRzWgU8HPzknZku?=
 =?us-ascii?Q?3Z/8gDJTWeDjKM2kownY11B0I89y+S1Vq55/lKCahPhVTEmbZBprrM9yqi9s?=
 =?us-ascii?Q?l6d6zXMctKBlJ06cREK535C3He899Rl5j8djIfsSn8jfGtEHmguoUyi4KSkP?=
 =?us-ascii?Q?xjgYAqBZWolYCYmcrzNW3cnpWJfUIwoNSuCSZgd7foMV28CbzOoNV10qsQDg?=
 =?us-ascii?Q?LcAaaUm2itZR6RoOIAOIL9eBAB2c2FYAWDdQCTJaT7nF1jQ0ZEOxmqa6AMqk?=
 =?us-ascii?Q?b+29XbN8sBfYEASLBg8cj7HqX5ELa9OO9Kyf8bNtgezHoIP3O+Mxz5P/kzP6?=
 =?us-ascii?Q?xbBexolQ/xXf2p1pZgedehQkRxIoigrT25YrfOVjHF9BH6QEcQaKM6NXEi5X?=
 =?us-ascii?Q?rgvSByP1Sa/AWsQyKZBjA2iMl0u0fBqH8iNAwcSxU3mLGpq9Si4h1yqJfDV3?=
 =?us-ascii?Q?Srezi7N0HwkYJcqzvw1p5MkISk96tYswt3M3dt15Xw5x8FwAgzh+486+LxZN?=
 =?us-ascii?Q?sPHbkU8kVbAID+ucSrIppiN4Mh6e50nS3asc24fdAyhvhgB69T3eIu/rXZdt?=
 =?us-ascii?Q?bBRj0XEe9wNOEMxQ/HhA2HWUEAV5KBQKa40IakTCOhWyuTGsT10o7Yw3l1Ie?=
 =?us-ascii?Q?qW9Jy1ZZRRqf1ureMdvDhfFvB5ZckBtRp0Pa4UEwEqPctqCSmVUscJGZZUnP?=
 =?us-ascii?Q?N4HWGrt0ifK+vQGpg/ZvhBWgiIm4CVjs+89yO8i+XKvTACWmD8FLeQ/nPQvm?=
 =?us-ascii?Q?lLgXy7w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5026.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(4022899009)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cHNWcMPuj7eU95dwN2oVHy/rnrRYTd3Ijkob/qm0ib59suDaY8dZIq+lDG/4?=
 =?us-ascii?Q?+ZHwCDCZt3jCx+SISkPlt/9XD7iP27WrfVYh7ldCGZBv+bYB02b7xqzMap5g?=
 =?us-ascii?Q?Fl5EEb2RHrNrtZn/sAAQnaS1ryDbywWzuOdB30XeIoEf7dmjAgf4ymOP6v6F?=
 =?us-ascii?Q?hM+lHjH76egPlPknFt+OnYZMS07ENBw8EgGMI5enKl/4kgxySf3AU0TmcBWv?=
 =?us-ascii?Q?IRWX3UgC91dspnqsnVAwQzn4hM0R7aULAKLQViZQIB9Zxhi5BxpGXaAaXxBZ?=
 =?us-ascii?Q?39i/GxE495bCzc65n9vQUh2otlPyF8WHufdsdcSL6w91WbPA3disPnPw9J9v?=
 =?us-ascii?Q?wpWFGXCV5sV6zaY9WrcpZFQnl8Dg4nMl9yjX2vlNvBKpNAsa5f+mFsOxt9/M?=
 =?us-ascii?Q?YCHQlknpl7PR5eVeK1cqCA1r6WtWTEefprnjG7o95jx5ckDdffLzFdoA0uAx?=
 =?us-ascii?Q?KNlbNBNv+zEaCpBWm6E1sY6YkPjvDvxJzbAYwSfgujqZnujq/vgESfFLLeBV?=
 =?us-ascii?Q?DskE8Nl7o8RHvdzVlc9boNBPnXWu8dwHWRknCXPZDlPYNqHfX9ymGiifgINU?=
 =?us-ascii?Q?50bbfuzWOirBFrqXdfkSKXuA//t94020RRdt2wkjB6aXNhZkbQFTQeJmJRBv?=
 =?us-ascii?Q?i2jyue6jNGLvntE2hetvscP/bIAxwipJ8fsXYwoOGfHuqxM1GEKsJir4QMB4?=
 =?us-ascii?Q?WeX61fzGn/HNS+O1qsJo8GMilFuwrwOZB9fj8SOXNABhm1hQCPQdM+ukuQ9H?=
 =?us-ascii?Q?gNZPUo6x79ppA0jLLMnSZiH1RkQhbeH6YAcyEoA3xejJlTpq/+83BuxfuB0h?=
 =?us-ascii?Q?abEhLBjOK8XgZOqu+d1GQhqvK634y2su1u3TTHchzBnr/PiRzEq/xUUOQdL+?=
 =?us-ascii?Q?LC0p5IRXnqidpx/On3mAv/hkT2o4DGnlExs4yrJQlH+0rusKh/kFNWrYJBv9?=
 =?us-ascii?Q?VnzN4OLq9izj05SNhP+fXrEoe6MBcqj1aWHnGqBo8Z/OpfV/ktfZJ+sywhwu?=
 =?us-ascii?Q?or/p2YqcO7yIJE3ZjC6Gu39XyDRnOgq0UyVVfDAh/CEuJkU4Rk3mnATFwNKw?=
 =?us-ascii?Q?1FNEYD6lHBMvfdD/dJqN789RxCahQAMk1FgPKqFF/Uv5OCW2COCeK26emca7?=
 =?us-ascii?Q?ewLshgwksH2Um+fXX0XsBWgP+xKp6yN8lBc0pL6r7NtxCSj37cHMh5mRdinZ?=
 =?us-ascii?Q?h98vk42Zz/7YtBsApTolqD9C3fKQWLuCSCFAIz7J9uXSwYQ+TuJtBf/ETvW2?=
 =?us-ascii?Q?Gcr17DSgXncpPBlyAUYb/A+XJzRN1l3D4iFtSDuM37OnaiPHMdoTMa4m1FQv?=
 =?us-ascii?Q?ykXbij1zFuoBqdvFMUByOEtKh8hKsThuXDZlloDotnjynJplw3YyARg5LQQN?=
 =?us-ascii?Q?LQNtV3sGd1pAYaZsZGOlbSemucYF6UWeOgCiGtIYfi1C0KU1yCi8rP6AZpB5?=
 =?us-ascii?Q?j6V0xaG7zvvEzszYfxWL/ijIaN41qhqpxpiIjMpvUb21SB9rIRvyqjuf0lt7?=
 =?us-ascii?Q?zGGePWoFi1axKwskXuIuId6/F9Nh+iMqGuYKrVE+VXoFkMvTh4Y6VcJlZGQk?=
 =?us-ascii?Q?r0OwWjUfID64X7dvKrpKsGV7f9twntA39w1dkjU0Y2g8G2j4vir107ODaZY0?=
 =?us-ascii?Q?2g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5026.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c4d641-0a9f-44d3-e7f2-08dcd33b8840
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 14:59:42.1711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oapm8GK/KP7w5FEBbOQH8zeAD5JJ+zKNvxRoUMsUIIUr97zN9lypzDgVUy7vbmHYXsID4g+ExNzYwRrwAHQ7RaQgUIUzO2LSSAPK189DGbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7392
X-OriginatorOrg: intel.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Sep 2024 14:59:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/649

This patch is merged. But It does not allow to run runqemu. I have sent a p=
atch to fix it.
https://lists.yoctoproject.org/g/yocto-patches/message/646

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
> Subject: [yocto-patches] [meta-zephyr][PATCH v2 2/2] zephyr-kernel:
> support to deploy users customize image
>=20
> In the previous design, it only deployed zephyr.elf, zephyr.bin and
> zephyr.efi.
> If users want to deploy their customize images, they should update
> do_install task.
> Add to check "ZEPHYR_MAKE_OUTPUT" to deploy users customize images
> and zephyr images.
>=20
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  .../zephyr-kernel/zephyr-image.inc            | 21 +++++++------------
>  .../zephyr-kernel/zephyr-kernel-common.inc    |  8 ++++---
>  .../zephyr-kernel/zephyr-openamp-rsc-table.bb |  8 ++++---
>  3 files changed, 18 insertions(+), 19 deletions(-)
>=20
> diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-
> image.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-
> image.inc
> index d6ee21f..c747095 100644
> --- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
> +++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
> @@ -6,24 +6,19 @@ OECMAKE_SOURCEPATH =3D "${ZEPHYR_SRC_DIR}"
>=20
>  do_install() {
>      install -d ${D}/firmware
> -
> -    install -D ${B}/zephyr/${ZEPHYR_MAKE_OUTPUT}
> ${D}/firmware/${PN}.elf
> -
> -    if [ -f ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT} ]
> -    then
> -      install -D ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT}
> ${D}/firmware/${PN}.bin
> -    fi
> -
> -    if [ -f ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT} ]
> -    then
> -      install -D ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT}
> ${D}/firmware/${PN}.efi
> -    fi
> +
> +    for output in ${ZEPHYR_MAKE_OUTPUT}; do
> +        if [ -f ${B}/zephyr/${output} ];
> +        then
> +          install -D ${B}/zephyr/${output} ${D}/firmware/
> +        fi
> +    done
>  }
>  FILES:${PN} =3D "/firmware"
>  INSANE_SKIP +=3D "ldflags buildpaths"
>  SYSROOT_DIRS +=3D "/firmware"
>=20
>  do_deploy() {
> -    cp ${D}/firmware/${PN}.* ${DEPLOYDIR}/
> +    cp ${D}/firmware/* ${DEPLOYDIR}/
>  }
>  addtask deploy after do_install
> diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-
> common.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-
> kernel-common.inc
> index ba70a29..8a1638d 100644
> --- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-
> common.inc
> +++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-
> common
> +++ .inc
> @@ -10,9 +10,11 @@ IMAGE_NO_MANIFEST =3D "1"
>  ZEPHYR_TOOLCHAIN_VARIANT ?=3D "cross-compile"
>  require zephyr-toolchain-${ZEPHYR_TOOLCHAIN_VARIANT}.inc
>=20
> -ZEPHYR_MAKE_OUTPUT =3D "zephyr.elf"
> -ZEPHYR_MAKE_BIN_OUTPUT =3D "zephyr.bin"
> -ZEPHYR_MAKE_EFI_OUTPUT =3D "zephyr.efi"
> +ZEPHYR_MAKE_OUTPUT ?=3D "\
> +    zephyr.elf \
> +    zephyr.bin \
> +    zephyr.efi \
> +    "
>=20
>  EXTRA_OECMAKE =3D "\
>      -DZEPHYR_BASE=3D${ZEPHYR_BASE} \
> diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-
> openamp-rsc-table.bb b/meta-zephyr-core/recipes-kernel/zephyr-
> kernel/zephyr-openamp-rsc-table.bb
> index 5e51c23..8a95b14 100644
> --- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rsc-
> table.bb
> +++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-
> rsc-t
> +++ able.bb
> @@ -1,9 +1,11 @@
>  include zephyr-sample.inc
>=20
>=20
> -ZEPHYR_MAKE_OUTPUT =3D "zephyr_openamp_rsc_table.elf"
> -ZEPHYR_MAKE_BIN_OUTPUT =3D "zephyr_openamp_rsc_table.bin"
> -ZEPHYR_MAKE_EFI_OUTPUT =3D "zephyr_openamp_rsc_table.efi"
> +ZEPHYR_MAKE_OUTPUT ?=3D " \
> +    zephyr_openamp_rsc_table.elf \
> +    zephyr_openamp_rsc_table.bin \
> +    zephyr_openamp_rsc_table.efi \
> +    "
>=20
>  ZEPHYR_SRC_DIR =3D
> "${ZEPHYR_BASE}/samples/subsys/ipc/openamp_rsc_table"
>=20
> --
> 2.25.1
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#606): https://lists.yoctoproject.org/g/yocto-
> patches/message/606
> Mute This Topic: https://lists.yoctoproject.org/mt/108223015/2015869
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-
> patches/leave/13182003/2015869/177849857/xyzzy
> [naveen.kumar.saini@intel.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


