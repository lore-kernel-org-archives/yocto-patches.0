Return-Path: <chee.yang.lee@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC8EC982FA
	for <webhook@archiver.kernel.org>; Tue, 22 Sep 2026 07:33:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4751.1790062411351159088
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 22 Sep 2026 00:33:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=j1rg9EjP;
 spf=pass (domain: intel.com, ip: 192.198.163.8, mailfrom: chee.yang.lee@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790062411; x=1821598411;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=fUYVmVMwRzmzAsxfalAGqA4yj+QBt+bREkVcjO8P+cQ=;
  b=j1rg9EjPYnlRf9MiGNCmh7VGeJgip138hD6KFA7heizcDVbATa4fdxFi
   xmSoM7HXNuShCKa+TDFHHBklsIoPc1N+lmdfzFfc/k8NL8k4CF9t86jBO
   Swogh2mmacjw6PB8+0GgQkkWZIW5+3kEKodhI3vd4ONBsLMx1tnokT4t2
   N6U9XBZkzpxmNfdIelB4t8+S59YerBl2n+s0B0k/M+sB96NKdBcbyy9av
   N4qeduCOTy6a7xvnzR3W3TB89EexrZYbf8A2t+RR877V0eOtwALkfufhp
   HkQ6ARKIgnLIUYH5HUf2/xreB/JSINve2IMFScfVsRacw4zaNwt8K9a03
   g==;
X-CSE-ConnectionGUID: uE4u1VHtRpqLmQhNQFWkTA==
X-CSE-MsgGUID: /D0nWJsTR52ATJrat650xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="108138663"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="108138663"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 00:33:31 -0700
X-CSE-ConnectionGUID: x0rOsvEBQSyJnWXWqY0tSw==
X-CSE-MsgGUID: GMSsm4ILR++hl+WnlROqHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="272215322"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 00:33:31 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 00:33:30 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 00:33:30 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 00:33:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFVH3oy5+AXMVD6Wul9gWvLz+OFjWLdMmdc831/odif99SUlXx3z15pIAtQwF67R7Nkc8TWQGnncXtIezdKZT6PMeNlSmAJdQwCKygq+ndwW6mGM6zIxfZ1lEymKPld6lRZZFdgcWCVdlHGfkfEh5d00RaqDQlEd960NA67kC23yLiPv7KtDt9gI/DkXPbu6DUhQHifexi5+y9F0OBhc/bQ2GA50E38HGPwSOb766zZ191GN7Xx4mGjaUEZp6SAyncukCqQZaq+w5872pCNIlmhRCAzUKz6P4RMZen+mpUoxqZbi5wyCKIuXoh77XadQjKKdnLPk/SeVoY1k8QXwtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBXpJN+t/jBdtWhYiJZUKYOeHYgclaA8lhUfRKZBnow=;
 b=VH05el0g+kbG5v9Ilt6dEMx6G+WCXYa9OxSxAJcXfQNNkBCZWUT17lcWejj7ts5FKG9jttOCJYAB3g3O7XdOVtnB5egJKchgUOr3CCdrSINs6g9ueFDGLLprXFLBp6m8LqiilWbF3+LHCb7Ifc3oPC+NUTfq2oJzwBjZBiNgJAh2WaS6JrRBOHScoiMkMCOHiSep1wSZG6t7cjIpULvdq9L9uoLz/WRPEyOqFMqpJCM1Wh7WrzvRNcQyxhmvzem7mBzIicMvLZoz/hTmJLnj3daC8ZwKwS+vj/J0uH+MSU+6v/poAwcMW+39oe7uGvfWempNI+Yx+et3aO0EOkktdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL4PR11MB8797.namprd11.prod.outlook.com (2603:10b6:208:5a7::8)
 by SA3PR11MB872435.namprd11.prod.outlook.com (2603:10b6:806:593::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 07:33:28 +0000
Received: from BL4PR11MB8797.namprd11.prod.outlook.com
 ([fe80::fe4:8775:47fa:b7d9]) by BL4PR11MB8797.namprd11.prod.outlook.com
 ([fe80::fe4:8775:47fa:b7d9%5]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 07:33:28 +0000
From: "Lee, Chee Yang" <chee.yang.lee@intel.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>, "Gundlupet Raju, Sandeep"
	<sandeep.gundlupet-raju@amd.com>
Subject: Re: [yocto-patches][meta-zephyr][master][blacksail][wrynose][PATCH]
 zephyr-toolchain-zephyr: Unexport Yocto toolchain variables
Thread-Topic: [yocto-patches][meta-zephyr][master][blacksail][wrynose][PATCH]
 zephyr-toolchain-zephyr: Unexport Yocto toolchain variables
Thread-Index: AQHdSe+xMRUJHWZ1I0yuTyP0wbxSZLbaM8ii
Date: Tue, 22 Sep 2026 07:33:28 +0000
Message-ID: <BL4PR11MB8797B15DF85D402C31A27869B9832@BL4PR11MB8797.namprd11.prod.outlook.com>
References: <20260916150036.1839867-1-sandeep.gundlupet-raju@amd.com>
 <ad74d9c7-bb18-48d5-bca9-30405bd9f4ed@amd.com>
In-Reply-To: <ad74d9c7-bb18-48d5-bca9-30405bd9f4ed@amd.com>
Accept-Language: en-SG, en-US
Content-Language: en-SG
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR11MB8797:EE_|SA3PR11MB872435:EE_
x-ms-office365-filtering-correlation-id: a75b58e8-2eac-42dc-4ffb-08df187bcb7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|4022899009|366016|376014|1800799024|23010399003|6133799003|22082099003|18002099003|5023799004|11063799006|10067099003|38070700021|56012099006|4143699003;
x-microsoft-antispam-message-info: gLchx0yk5ruDwY8lgTVIXm05kIB5qG66jChm0DrFdji4Pxi1C9hYc7D5YF4aTWxJLJB6NmY2yEOgtH0kBUXB627ERdafLqC54YnrG/L4PJr6lppT7mXQMpXx16dLpYgP0zWKKmOawu8WUa0P+CeO02rakgfzMLdZvzC+sEFhngqQdDKY4PT7/le8hYga2+Dx2Vljgpu7avlEpOgBbLPT1xnQwRcSKDkt1+NfEmkelm1T516Ek6UYM/RU/JdeiC2K682GXwpk2CItztW1nNrd6Bi8PUSQFC+35zu1xe3qFNg+RcFyGeXvxvpIZLDeNBmEUHSE9hqmzmEQgyt6NYm4vBy/WAvE6xTnD6y7c1DpQdgHujxMsgDwBm8Ty4ZM8QkjZQ1h46VvryCswdxMx+ONZVVTfd7AS+jgZ7rLCjcMhnmFslDy2f3DHOdkm/RAsBaOZ6f24gGxwU5nvouoIS53Jq9TvUuT7rvCWOcLFJYx/yMA1oZruJglBvsTl5HXtxI4QwKf6uExnodl7nzPftGaGdY3kHE5Qkvj3ULEsXRzNJ6SAZdQ0x9e5seLqeYDsRUsa7rqzVJ6MoxvYClbCEPl56GO/+EU8G9r36BMw7Z2bad9Mzc+8fF8J3N09CDPBPgTdDWBYgoLLvl5VEw5iZP5JgSplUNOi95ksooeG3mFEHk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR11MB8797.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(366016)(376014)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(5023799004)(11063799006)(10067099003)(38070700021)(56012099006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aO/cwgc5snVtOA+3ghhEphqm3gL9pkMMjzjY/PSw2Xb4BFxapDhB/dkjQAg2?=
 =?us-ascii?Q?C2QLxdoZ1WR/0rLPu5sxMRxdFLvuKOVk2EmYwSH829eQoyfYuC+0ELlF+/Jg?=
 =?us-ascii?Q?3eY3NrU4dcyt4P6s/3yfVyYA8c/hB6QmCihvQOi04MRfOsJTsk4u4A7IeC9X?=
 =?us-ascii?Q?/Ejma3BoAKKLB9vVOU5Z9Mbw1XFMeZC2rTKmazb83endl3vnhRrK8nvgwnKR?=
 =?us-ascii?Q?GuT0YaAckiEF1ri3lrvEKuwQIK/RM5Ga8mzATiGGf6zfrrFRwhftaq9R8MvP?=
 =?us-ascii?Q?f0YOM701/UxKCX+41vo1PejKtPx59Byj7rCx9M7RFjX3h77SPuVoTk+YsuGm?=
 =?us-ascii?Q?OJCgUOY07comOHsru36+YsV9ADPBxIGMrPsPXWZlq3OBcj9HXR0EI233Ltn8?=
 =?us-ascii?Q?dfRdR9H4bT8UOSNTl17UEji6gfsODbFKlxaKp/y6JEq1dmMEdl/J/7L604CR?=
 =?us-ascii?Q?XXvITsGJ5rMJPHP/yO2/O9jWRl2nCZ2cQ+O6WCVVWS4qK2Y26vvaXwIXB1s3?=
 =?us-ascii?Q?MWs0tkrN4VIWx7qnEVy5tbh0cR797YVJ7fS2c499fJytq0odWYfycxDVucf0?=
 =?us-ascii?Q?OWqjIv/frPG0qxr1N1Iy0TWIejjsqOXaV09ZL4XOyZdQ5i3MMbeCjcprX+UR?=
 =?us-ascii?Q?kjxo5OTE/Apfu11QOB0NfIK/plMumUOX33tKbrXVTPnLykK6U0GlAmjHQaOY?=
 =?us-ascii?Q?8oCIYD4Dm/s25/YPTRM0wKgNs7MoF/YfGQXZMqA9//sC1fzj7slr3DiN2eEM?=
 =?us-ascii?Q?9nv0PNAGHgFbYHak5K+vONUFZuTF1AzgkBWO/sp/R/nz+in6H5vJ3vIUaiVk?=
 =?us-ascii?Q?9DTtyfZpmcq1oUF11EbE3d8F2clGFMkRxgFXH+itl+/l4QdEUezHtGhUrL74?=
 =?us-ascii?Q?H7ilgS5kn+ZQ5gcKu661EprjOYqOvfyNyW5Lz9f85GCO68jprVUNJKFWxzKD?=
 =?us-ascii?Q?mPGgwMMmVkA1ApeXv/ROTWzfH7jyffxS1wp8vRBnPhv4TTJmJdVw4buBCOl9?=
 =?us-ascii?Q?ajRcgKAmfsya/uBdSJ301noqfUk/gBRvpd7xPPY//URHnRV1GGODJLHXAynU?=
 =?us-ascii?Q?8Z2h36a5tpR0DL7ELwfSsiXglIQUohZ/0cpW5IHbWk4b1W3q7DWnyWbTWl3U?=
 =?us-ascii?Q?rVG+DQM0/L9Ara0TZ56FAzDvECUch4lwoNll7PzOKc0dIQpZ9lobMwzVxlCk?=
 =?us-ascii?Q?btX0n2WJomKxWdaxw6kFrAU8NHBp9j1vMCioCPO437vTz8eeDdC64c7f70pa?=
 =?us-ascii?Q?RkOnZnABPX/O5XBP2638MhIq/maVHmiQNM7FEkzx+i3bVB8OMYAnvcNzCIOR?=
 =?us-ascii?Q?hjrjIDxTgGtwerzgkGlRCXX8+v7zkDQ523MrTgA05eoG6EvrORLPtyDOE3nq?=
 =?us-ascii?Q?0eqke/2Zhs2/ZQXLfBhnY2gy0tTrEh6hd2URuaqlmNQ6bthJ788FX+zYom9w?=
 =?us-ascii?Q?kMiP1/IeMvz8iiVBxvyhPdqFe1+DblVQXCg4rUHizMo4G6H3M+qeEbz6DSYJ?=
 =?us-ascii?Q?euwUVa2OsKFasqLHrE0EpTyJAHBugqHLUWdYhiEt2v3xaI4RCiSEnN0DkWvC?=
 =?us-ascii?Q?5Lriy6nLpvHCabNDFAn64Qy1Ei/L7ZpIqqSpbi5XI78kazHR4+RnN3fxtUcJ?=
 =?us-ascii?Q?n8x+ebr1yo2tNjPTpvIg/hMNQdiyeAuE9aQ04e+Y5FALIwYULH0ny2tKV+tY?=
 =?us-ascii?Q?AYPSMceeo4dGygUOC37KFsGjkaMZMBDDLXL7ZiyIHc6ylO5xi19cd05rb0Ct?=
 =?us-ascii?Q?FV7c/twBsA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bbPyHT6l8+VaSz48lTUBvcSo4Ge81Hb4nQr8E+SxJdOVTYj7S8GNiVFzUyJsTJm7q18phWjPRjRU3lSuckU2ItU3oX08w7SL1F+fFNklEYIoBw1fjn/rSfnhvbUeZD7bUoR1vH+kCfbHSYLgqPFmGeGVg8HXu63rmxIlSvGDUZ+uiukUWmD6OSiYIf4dU2vlgCIPK3X6Tt9QmNUKSk1VbejtxobpMCwiJCL3pHY2nBMEb3/Sh67C9/a94qAd7vr8+vsOf7bHMbLuKkqe2ADO+3jn9xpXDtfv0wDcn1j6WAK8OG3sxpy/7QrQBBnLmF9eAKpUe/N6/44Rjhami4cFNg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL4PR11MB8797.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a75b58e8-2eac-42dc-4ffb-08df187bcb7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 07:33:28.3299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: txiOzVoO9IvwXT6FNaysQn/Hi+ppqEf/LyFdxa1nmptmRtJ2M6wUHSYT0T6QCeHycPISon9Z00DdIWjhzTIXpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB872435
X-OriginatorOrg: intel.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 22 Sep 2026 07:33:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4929

Thanks for the reminder, i missed push for wrynose branch. This is now read=
y in wrynose branch .


________________________________________
From: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoprojec=
t.org> on behalf of Sandeep Gundlupet Raju via lists.yoctoproject.org <sand=
eep.gundlupet-raju=3Damd.com@lists.yoctoproject.org>
Sent: Tuesday, 22 September 2026 1:35 am
To: yocto-patches@lists.yoctoproject.org
Cc: Lee, Chee Yang
Subject: Re: [yocto-patches][meta-zephyr][master][blacksail][wrynose][PATCH=
] zephyr-toolchain-zephyr: Unexport Yocto toolchain variables

Hi Chee Yang,

Please merge this patch to wrynose branch as well as this is bug fix.

Thanks,
Sandeep

On 9/16/2026 9:00 AM, Sandeep Gundlupet Raju via lists.yoctoproject.org
wrote:
> When ZEPHYR_TOOLCHAIN_VARIANT is "zephyr", INHIBIT_DEFAULT_DEPS is set
> and no Yocto cross toolchain is built for the recipe. BitBake still
> exports CC, LD, AR and friends into the task environment, where they
> reference aarch64-yocto-elf-* binaries that do not exist.
>
> Zephyr ignores these and uses the SDK, but external module build systems
> invoked from the Zephyr build do not. Trusted Firmware-A is built by its
> own Makefile, which prefers CC/LD/AR from the environment over the
> CROSS_COMPILE value pointing at the Zephyr SDK. Its tool detection then
> fails and expands a multi-line warning macro into the tool identifier
> variable, leaving embedded newlines that break a later conditional:
>
>    lib/libfdt/libfdt.mk:16: *** invalid syntax in conditional.  Stop.
>
> Set the unexport flag on the toolchain variables so they are unset in
> the task environment and TF-A falls back to CROSS_COMPILE.
>
> AI-Generated: GitHub Copilot (Claude Opus 5)
>
> Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
> ---
>   .../zephyr-kernel/zephyr-toolchain-zephyr.inc       | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-toolcha=
in-zephyr.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-toolch=
ain-zephyr.inc
> index e265883..8fa3e09 100644
> --- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-toolchain-zeph=
yr.inc
> +++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-toolchain-zeph=
yr.inc
> @@ -18,5 +18,18 @@ EXTRA_OECMAKE:append =3D " -DUSER_CACHE_DIR=3D${ZEPHYR=
_USER_CACHE_DIR}"
>   INHIBIT_PACKAGE_DEBUG_SPLIT =3D "1"
>   INHIBIT_PACKAGE_STRIP =3D "1"
>
> +# INHIBIT_DEFAULT_DEPS means no Yocto cross toolchain is built for this =
recipe,
> +# so the exported CC/LD/AR/... point at binaries which do not exist. Zep=
hyr
> +# itself ignores them and uses the SDK, but external module build system=
s
> +# invoked by Zephyr (for example Trusted Firmware-A, which is built with=
 its own
> +# Makefile) honour them and fail instead of using the SDK passed through
> +# CROSS_COMPILE. Keep them out of the task environment.
> +ZEPHYR_UNEXPORT_TOOLS =3D "AR AS CC CPP CXX LD NM OBJCOPY OBJDUMP RANLIB=
 STRIP"
> +
> +python () {
> +    for tool in d.getVar("ZEPHYR_UNEXPORT_TOOLS").split():
> +        d.setVarFlag(tool, "unexport", "1")
> +}
> +
>   # Set Zephyr work directory to describe toolchain accurately
>   MULTIMACH_TARGET_SYS =3D "${ZEPHYR_BOARD}-zephyr"


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#4923): https://lists.yoctoproject.org/g/yocto-patches/m=
essage/4923
Mute This Topic: https://lists.yoctoproject.org/mt/121279971/1648606
Group Owner: yocto-patches+owner@lists.yoctoproject.org
Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13233161/=
1648606/629479993/xyzzy [chee.yang.lee@intel.com]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-



