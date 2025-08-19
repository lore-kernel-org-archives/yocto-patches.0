Return-Path: <chee.yang.lee@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF40CA0EF5
	for <webhook@archiver.kernel.org>; Tue, 19 Aug 2025 02:02:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mx.groups.io with SMTP id smtpd.web11.4298.1755568923930196980
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 18 Aug 2025 19:02:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=VPv4aar8;
 spf=pass (domain: intel.com, ip: 198.175.65.19, mailfrom: chee.yang.lee@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755568924; x=1787104924;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=RbdrdB76PLrF91+izlnkDP09RmilMZuEHS2EukEOXn8=;
  b=VPv4aar8hr6tMU96DvOFcQpLeNVY5NPPTwau9TPXYMscyjySpkIuBmXk
   jMMmpRQ/FVKstUnUgSCT9vqh2NnmYMhpOs7/jS4T6uprlcq+WcHGnyzCS
   hIreB2YJzSBzMpO9glzmujT6Tw4wmBAX9GXYTN7wslDl7LyDaP4IRWyPI
   W1gL0J76Cf44Uew8MOdCoXJKi4jL+z7M3zPRt0fR8a4ubSKBSk/AclGYG
   UVngeato79M93hgcbYJiWKqj4mTfpQLqFJqe+rRrCubmExVf7p3N5ekqj
   0svlPuMkv2y6lgvqqfVn0VKIDEMwRC6RJ/QANf/BRprp1PzSMWiY5i06f
   w==;
X-CSE-ConnectionGUID: zygkbKmFQ5aMR8/0u0ETfA==
X-CSE-MsgGUID: 7YwI+1PbQ++cVNfHhXMfdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="57660225"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="57660225"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 19:02:03 -0700
X-CSE-ConnectionGUID: 5IwGO6/lRpWOn7rx2XyA1w==
X-CSE-MsgGUID: +i7l5MWySUubMYNOKtiRrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="167954668"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 19:02:03 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 19:02:02 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 18 Aug 2025 19:02:02 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.71)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 19:02:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBXfdxzqFJpm6s8olDZJPkZtFYsdpqVAMyZEQd/SzOfAARLaRZfuTFULtvAoTvQ3Uq4gyb25b6xcvOjC2z9e7zIr2nVxv8f9uJEyPCXePznl3uWWbrmjVto0+eW8QUeXUOtzPMl7LUkmd2VSd9i/7xvLMZbMmstgkibNyLi2VivFlxjdi1NLCJ3af6zhFf68QAlr4B9KBOAajGLykdZnBarTsNvYePMIXJB5AvDLhA5s5Y/zWDtu2Uc7LJp/4o0uiTAVy56kxVDiXjOvlfBP8fy3BACFdC7xutOytyDEHesGhB0hGYGI69X4WSo+lrn0Ydhj9JJdXqSCaJZoJV1teQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxsQObYu3Pn+uckHs+8Ig2A2gjQwWOo/9otHhIuPjrA=;
 b=lsIL0wJ2sfnCqT2kNG2RJ2svyJMLjuO5Vc+aMUClrGbAuoSOhl9jkBuWBL6NG8DytM3/Ardz7vUUMTn3pCfKocg6ji9wzbE0ZhV/hgWF7znBOUFSiV7P0khm180PDVmC9QOUDBD5uORHJNSkJ+u/pniCfpaSMD0hDAcZ5L7xj9OOtGoMuufeVvD9lGrMcZpVJkcL9BzFRfW9qzRWUVOqIyffxbvM6Er29Mbr1TguxA5MYwyBzkl8e1HZzQdrqTCvO1AeUC3XVToofEg3qWQuTAAuR18Q1Ct/85WIHrRek8zyHhkok2xR380JCKZxlyfdnKU2BAE7YJoTqXNkn9tFTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL4PR11MB8797.namprd11.prod.outlook.com (2603:10b6:208:5a7::8)
 by DS7PR11MB7885.namprd11.prod.outlook.com (2603:10b6:8:d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 02:02:00 +0000
Received: from BL4PR11MB8797.namprd11.prod.outlook.com
 ([fe80::311e:565b:ccfd:f4c8]) by BL4PR11MB8797.namprd11.prod.outlook.com
 ([fe80::311e:565b:ccfd:f4c8%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 02:02:00 +0000
From: "Lee, Chee Yang" <chee.yang.lee@intel.com>
To: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>,
	"yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Subject: RE: [meta-zephyr][master][PATCH 11/12] zephyr-kernel: Add rpmsg multi
 services recipe
Thread-Topic: [meta-zephyr][master][PATCH 11/12] zephyr-kernel: Add rpmsg
 multi services recipe
Thread-Index: AQHcDZhjPk78Rq0SJ0aX6sj3qBckqrRoKm6Q
Date: Tue, 19 Aug 2025 02:02:00 +0000
Message-ID: <BL4PR11MB8797B7EFFB60C164F9E3FD61B930A@BL4PR11MB8797.namprd11.prod.outlook.com>
References: <20250815035449.2816001-1-sandeep.gundlupet-raju@amd.com>
 <20250815035449.2816001-12-sandeep.gundlupet-raju@amd.com>
In-Reply-To: <20250815035449.2816001-12-sandeep.gundlupet-raju@amd.com>
Accept-Language: en-SG, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR11MB8797:EE_|DS7PR11MB7885:EE_
x-ms-office365-filtering-correlation-id: de21ffb9-6614-4194-6121-08dddec46270
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?IljJqL1ydD6dJhsVLfYinBZ1RUKZEJdDSsBGaoZjiS1rn8f85vaPsniWVRLh?=
 =?us-ascii?Q?8TH/KVIB9JxtqCF5it8cE8Y8rzxHnpZ5hDtdW+1d74IHrT3h7H/6kF7q4Jrl?=
 =?us-ascii?Q?JsZ4hpQyr/55ZZlmJoss2ZfkKvadGmZ08xQ5iAnFCLkdCgL2nKUuZps94bYN?=
 =?us-ascii?Q?ShfjrdqT+LXHLXvXT39A5YT4kAjg4aJjZyrmLpzcwNNcvj5CGWp+vJ4U1lhU?=
 =?us-ascii?Q?SE4RG435LGXQem2cuksenG+uDTenh61RY37VnkoZd7w4MaZ+7iyO/Gz8eex1?=
 =?us-ascii?Q?yY3czI6gEBDKVD+/8MuLt1Um+w9XMyOwxPBA348294C3ujGqFFgiDq6I4tQS?=
 =?us-ascii?Q?3vrYN2yzbsYLNyghdyq/mnXScj6+hrpi93avoOX1gRQdNcgDwry+xoZTbAm3?=
 =?us-ascii?Q?mk8vxiDPx/cce3sfUzdKu5Ka3pgDigC7DPUVcFUvYQE1KffZgLCKPZYfHKSQ?=
 =?us-ascii?Q?1MyBsPHV0tosAwBfU1/X7q4fLg/L89aXCwR8mJyzTfXgnUTryBWx7iIjtZd8?=
 =?us-ascii?Q?9SGZO+lo0j+PoLSvZngKn/pIdnPmzpjRGrdMruRqD6f/92Vm1+JOX+/PmKhZ?=
 =?us-ascii?Q?MB+qfON1d9q/ciMYZYRrGShtq98HPhxcA/yF3nSnH+T/T8+n6Vo7EkJ55+H5?=
 =?us-ascii?Q?6akCUamjkolzC2iqQ3CPwXTNQBpY0vErOj/NUygovS7qsfKwAHcsU0MKPLsh?=
 =?us-ascii?Q?nVX7XASl03DwcSMkUfVlBDwHXN5mTg3aHHU9oN24Z1TYj1CE/hkYiu1lnApd?=
 =?us-ascii?Q?uzT14H/YSjwslMeXOBx1bb+0os26kmudzFwOZIiEmJ9bIwsTQXMvl0pAbCdI?=
 =?us-ascii?Q?rIkYXyqeRxhky4esKe7kQOiX0WWKLeff3JTapoFIP+TfRr8s8+/m0NRJXiQ2?=
 =?us-ascii?Q?LmGQSxk3PcfBwmLVvvOslmDPjkAnI4pcXRSzhtmSyqmVT3JhnDOWrOgBuysS?=
 =?us-ascii?Q?7bwbk2+7ptPHz1uSzCOdogMGm87azJKalRfbs0VRpNEIanc+AMjGbywTJfzj?=
 =?us-ascii?Q?l40e9sm1emdpSTAujms7/tyC4PSIAdxaJYeoV8AYlnh6MI3yG+B4BC0g+INK?=
 =?us-ascii?Q?/oXPPXg7nNiZRp6xHCCk+abrWjs8dZ53T+8xqAs4ZdTwmlmNCiQTCi4yJJCs?=
 =?us-ascii?Q?be5zGDPZ2Xmj6kcIORkz9qmvRSuh5/vBOwyNl5QIso261HgnT3CDat8aRYmA?=
 =?us-ascii?Q?LMMnGI1ONVRlId5OSN9E+6u5ENqSGjhu3aO5ntlJEFRxu2PgQ+XdbyqN0WHZ?=
 =?us-ascii?Q?GTI5rSIzny6eQXugMysnuBMtyN6oRh08ZvZ2Ywz3HhBdrcHwv+fgH3WYYZZ0?=
 =?us-ascii?Q?a/FgVa6PzuvVLfy5qHC33JcTFyRhP11ZFtED/Ye4K+n9d9i7TteXPwwx+CeP?=
 =?us-ascii?Q?NxsIBGGyXWt0k4ZSTglBUkXYNSVx9QFwaTK7qLXAM5GAP5f4tRIktPLw/stf?=
 =?us-ascii?Q?eDbfmmkFJgCjQRQmIUlV5YQdQWqeOP0uh8rjyg8lJQRkmUdQkP1qhg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR11MB8797.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V4glQTa5yVN+3ar11G0ru4ZH+d2B1+lXvhPfkRRVc2Mj0H6Kzz3DDOXBKO+M?=
 =?us-ascii?Q?j2mvoosJqwFHvhugBU2ZVkTpr9m08Aty7Fvr+BqxOszDgbgk6ebT6Pf4avQO?=
 =?us-ascii?Q?QRKVIuQbrcPnCkla3Bfl1lMuNVEmoJByFwQ7bL4Xm5v5yYUibfle1bVNjxoa?=
 =?us-ascii?Q?1Z8gcBLEDSZQWrDidPl/T9Lhra1ERAbrUaIh5t/NGLnCwXxfz88FDNt2Oz93?=
 =?us-ascii?Q?DjnXhcv2boVSzJ4k04gziEYf3BXXbW9Ugtrqj76gdipwQ6p9jZ1d9Xgwtq9z?=
 =?us-ascii?Q?P+Uom/vAZQownUBQP0NeqW3DgEHoZ22MwSPpyG/6LhljzKWFdxpraiiq9WSt?=
 =?us-ascii?Q?Rp9KG4lUO4zKeBAaH/cifRXmMmPSfGdl2mChfUFHBOr0/W5n2C2cxPExPj4n?=
 =?us-ascii?Q?65Fw6RMWcg5lrYR+a7TX1azlB+2G6dgl0eVlbJPHX2ME04xFhjVue3IVT8f0?=
 =?us-ascii?Q?YAy92s8vw9MveRggqglWkJtcMmu+/xcDJXwsAb1GZqLFEwxno00j9vitl0AP?=
 =?us-ascii?Q?kgXn5GAUSvsn/flZNWu4/YLh3G3fqrKFr09n445yBLfI79lzKB0rPbfRbwqs?=
 =?us-ascii?Q?R704OZLrRCIpdpOLrnlfn2auum2RB5Tp7VRko1dzHuOqYHm8gJceMulvGyls?=
 =?us-ascii?Q?NXsEX+UhwqTCGoY6hnRorbWIvJKRfQ0dp4s8Cy9qgPn/eBsRurShS5cUPaeE?=
 =?us-ascii?Q?CRlBPy7OjaNzeJNeF+dU9LC77BMmjM7IFP9IUocW86XVENGysQg7CHK6yPpx?=
 =?us-ascii?Q?ziSdDaK2XypJGXibARmYjQIDMhXXiwbStGsPakSSJrLryeuvLUkoNSFE+8WJ?=
 =?us-ascii?Q?qAKVp9Gr8i+zHt0x4CYO/Sng9lUJ3bZ/VtdjrWgIk+I0szTq0CZ8Uc5DbPJq?=
 =?us-ascii?Q?6aEUam9Z13ffRhNB1gSjVL6JY9l+kTCfT+b8bQAvXN+xK2dLwhSn2pNPV7tB?=
 =?us-ascii?Q?KADw+onw7jYQ58lTWe/ntN4a0jhX+AnjLdAPzPr1JO+LvHqkt6xBLaoaHsFt?=
 =?us-ascii?Q?7Rmf/0QD5zzTmbDlaC3ablkNEhS2HbI4wi0vEakOLCFdjZdxrgYXKHyEva+c?=
 =?us-ascii?Q?FzYVs8LuWBhKowfT0R9iRsaC9E1QwRhHB+MIfOysMWLiroM6KvXw0KeptPUa?=
 =?us-ascii?Q?CIMZkeOoCiMnlPrsH/oe/U9Jmf+nPDfWhW1WtDg4aco1REcRmyhrHMF/qriz?=
 =?us-ascii?Q?Wmothu12KkoAV3FW4z61WPP3aUu+9C2L25JXV8hoNGdc1WEtI+7i28AZb4jL?=
 =?us-ascii?Q?Ds33Kn80N2Z6bb/sHYKwS78KKd0wjw1WZ9m6+ZqwsMNPY8xAnstdlHFrUiB/?=
 =?us-ascii?Q?gtbRUHEvKPkmoXVSOm/GuQmViNnb+vUiqOHP6UcMXTUfH1TUKDwTIDidZg9A?=
 =?us-ascii?Q?n65waFbYSc8LpQD8+SBX/KjE0b0+Di1xrJFG/Xko8XxGQJEm8hq6CnQ0oG44?=
 =?us-ascii?Q?XYICQSFxnR4XZHtU6dKRs4BUn/edHJAKmxR/bo6XdzPuqX2Fh5FAEOAEkbJy?=
 =?us-ascii?Q?RrI/cEdHMX/5eiB0Krv7J2DOjLx5y3ZktVdekDXxLUgOhVqT9+a/ueyVvdSG?=
 =?us-ascii?Q?DUh9no2ZY3F0aQYsK5aXWSmrU6WpqSnS/CvcQP85?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL4PR11MB8797.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de21ffb9-6614-4194-6121-08dddec46270
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 02:02:00.2940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 15WOUjrtPou94A/Ip8n1WyIBRvpPKHWrF/GRYlUIkEdToIVFvxAReEEf9TNIzsA03y2FASs9ec8mF4m1M8JmZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7885
X-OriginatorOrg: intel.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 19 Aug 2025 02:02:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2053



> -----Original Message-----
> From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
> Sent: Friday, 15 August, 2025 11:55 AM
> To: yocto-patches@lists.yoctoproject.org; Lee, Chee Yang
> <chee.yang.lee@intel.com>
> Subject: [meta-zephyr][master][PATCH 11/12] zephyr-kernel: Add rpmsg
> multi services recipe
>=20
> Add zephyr-openamp-rpmsg-mulit-services recipe to build out of tree
> openamp-system-reference example applications.
>=20
> Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-
> raju@amd.com>
> ---
>  .../zephyr-openamp-rpmsg-multi-srv.bb         | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-
> openamp-rpmsg-multi-srv.bb
>=20
> diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp=
-
> rpmsg-multi-srv.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr=
-
> openamp-rpmsg-multi-srv.bb
> new file mode 100644
> index 0000000..222ed2b
> --- /dev/null
> +++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-
> rpmsg
> +++ -multi-srv.bb
> @@ -0,0 +1,23 @@
> +SUMMARY =3D "Open AMP rpmsg multi services"
> +DESCRIPTION =3D "Open AMP rpmsg multi services"
> +
> +inherit zephyr-sample
> +
> +SRC_URI_ZEPHYR_OPEN_AMP_SYS_REF ?=3D
> "git://github.com/OpenAMP/openamp-system-reference;protocol=3Dhttps"
> +
> +BRANCH ?=3D "v2024.05"
> +BRANCHARG =3D "${@['nobranch=3D1',
> 'branch=3D${BRANCH}'][d.getVar('BRANCH', True) !=3D '']}"
> +
> +SRC_URI:append =3D " \
> +    ${SRC_URI_ZEPHYR_OPEN_AMP_SYS_REF};name=3Dopen-amp-sys-
> ref;${BRANCHARG};destsuffix=3Dgit/open-amp-sys-ref \

should be " destsuffix=3D${P}/open-amp-sys-ref " for master branch

I was facing error while building this recipe

CMake Error at /data/master/poky/build-zephyr/tmp/work/qemu-cortex-a9-zephy=
r/zephyr-openamp-rpmsg-multi-srv/4.1.0+git/sources/zephyr-openamp-rpmsg-mul=
ti-srv-4.1.0+git/modules/hal/libmetal/libmetal/CMakeLists.txt:1 (cmake_mini=
mum_required):
  Compatibility with CMake < 3.5 has been removed from CMake.




