Return-Path: <chee.yang.lee@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FCDC5AD49
	for <webhook@archiver.kernel.org>; Fri,  6 Jun 2025 10:59:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mx.groups.io with SMTP id smtpd.web11.30886.1749207558191658986
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 06 Jun 2025 03:59:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=hp9I2cyO;
 spf=pass (domain: intel.com, ip: 198.175.65.19, mailfrom: chee.yang.lee@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749207558; x=1780743558;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aJG2RTbfwI1q+hcFsq0thOgUeR/h9FWPq7mjHk7mXwg=;
  b=hp9I2cyOvVfFm3VRpYR0J8+SsbxtTvUpHkJHVjRY/nh7Zydw68eG+hNF
   eGVDFz94Sxgzlxt++GXKf/ZDkJza/Lr3UyqU4Wtiv5uJOnA/pcIBpWRK7
   ugDArjiACBmvDHaQZMNG5zK+JggHLiNyd3uPNtyys7JsmIsz9cqGnNt9I
   TmYyQ7Y64SpCUgxp7t1HbFWInYAL6mLkFvMry4r/WIr9qdOZmXJP/xD4c
   RKXLOVfskJXJFzNrqdGzopMUfhrCu2TnpoI4zbN9knrojeYeTl/yBHThA
   zUAmRWxQ44DJDmfnoRL0eM7O5/qkcE/UjjrZTGQOhsphUKOvURJQRzAjL
   Q==;
X-CSE-ConnectionGUID: BNVfO4xoT5e97Y4/rlNumg==
X-CSE-MsgGUID: U+mfB2gTQqepZZsPYX4sZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="51234229"
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208";a="51234229"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 03:59:17 -0700
X-CSE-ConnectionGUID: i4rYLyNKTmClRfa6CPlr7A==
X-CSE-MsgGUID: +3vc68RMSF2eS1LrqugJFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208";a="168979125"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 03:59:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 6 Jun 2025 03:59:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 6 Jun 2025 03:59:16 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.55) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 6 Jun 2025 03:59:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cT7IPuRW3iqKlyKiQgRA8fdMg1hO4hbJ1Kf4goYgLfHBVwN42AD2avPu8CrvtZUdgbTIfo0VRC8Dk+O53oYKzqMCANzG2D0HPg8EOemruXN6okYhoNTikKdmtm1dumCz4qJ8wupQEb+pHgK/mIUeDwbkv19BL8bi0TLVGpuqd6+Ur32THz9Phz2jLM1ZFBBU+0ByPyZjdFIoFTOhdixfIf6Uj3amr0NB3tLtlbogyqGJYeAZdFEjWBgS1RsTF/2aQ0dxri0B7a2w05M4RLhFJ+tpjyHRtSsFd/sS6q3d917BIwzL+8w8+2wK5Y/Dejd4fRCXQ6dOMYUTPQQsp4IKCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiWpao+wibtw/Zn4kZ8Judz56gzrNXJUjVjreg5dqaM=;
 b=GSZinfRrX0Nblk3SMdFRhCiFCw+zakLVgCuRdoerVNkWq5/q8BRaYu+mbYpSQ9XUxcDMVWNMzx2Lp3LD0+SO265tA6xHTqFCi6LkKS0dSrlEJ+CjB87kfFaA2Y0E7DWmceDF4zx2Xm1PIjKXgVqBAz5l6uF/5+avJIghsK6wM/FqkzPyin/Da/ObAP5sddZwbcDOXPGl5OsqsnRscVQ/OEgTKZhB+kIKltn1x//L0eYkFUY6j2mdIJMUzJ7e5ogpiJJkVSq70UJRZGI912aCQt739lia8mGzDHP1cmdyiBIsXuxgtqBzAIB7+m3KcXDNB3oGyf31Jj+pgO4U3jnk7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL4PR11MB8797.namprd11.prod.outlook.com (2603:10b6:208:5a7::8)
 by SJ0PR11MB7154.namprd11.prod.outlook.com (2603:10b6:a03:48d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 10:59:08 +0000
Received: from BL4PR11MB8797.namprd11.prod.outlook.com
 ([fe80::311e:565b:ccfd:f4c8]) by BL4PR11MB8797.namprd11.prod.outlook.com
 ([fe80::311e:565b:ccfd:f4c8%7]) with mapi id 15.20.8792.034; Fri, 6 Jun 2025
 10:59:08 +0000
From: "Lee, Chee Yang" <chee.yang.lee@intel.com>
To: "sandeep.gundlupet-raju@amd.com" <sandeep.gundlupet-raju@amd.com>
CC: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: RE: [yocto-patches] [meta-zephyr][walnascar,scarthgap,master][PATCH]
 layer.conf: Add LAYERBASE_zephyrcore variable
Thread-Topic: [yocto-patches] [meta-zephyr][walnascar,scarthgap,master][PATCH]
 layer.conf: Add LAYERBASE_zephyrcore variable
Thread-Index: AQHb1ck3vLZOXtfxikqrfO2wOsPksbP18Fqg
Date: Fri, 6 Jun 2025 10:59:08 +0000
Message-ID: <BL4PR11MB8797361F43C6718A631EC6DAB96EA@BL4PR11MB8797.namprd11.prod.outlook.com>
References: <20250605032306.3073101-1-sandeep.gundlupet-raju@amd.com>
In-Reply-To: <20250605032306.3073101-1-sandeep.gundlupet-raju@amd.com>
Accept-Language: en-SG, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR11MB8797:EE_|SJ0PR11MB7154:EE_
x-ms-office365-filtering-correlation-id: 93730c0b-775f-4b62-ed87-08dda4e9293d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|4022899009|13003099007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?JLNY9WanlWonXfAOv+hookyLCRl59jfgEIINEyh5BWXUQWrsmzr3If2DUQk5?=
 =?us-ascii?Q?Ch/g74IY6xY2ttEr8Z11DMHM3iKQpGPIM+S280oN3XDwRMD5caohpOM2wr5x?=
 =?us-ascii?Q?zjP9gfewPp4lE5U1oQ6nIRPZXiU0Amq+DS0F26Rve46pFJ2uOweHKWw0IiU9?=
 =?us-ascii?Q?sol8YtgkaMV/MhPiH9WGYzh4J0l+XhCJaHEGJp3ogX5OBxF+ijYTBIAlNSqR?=
 =?us-ascii?Q?PnOHWnpysDiCH5QZpW+cewjFvuDYbBRMu8D7iaV0yB6G+9BdLUvmZXVRnR2Z?=
 =?us-ascii?Q?H45HxXnwLLHMjW9c9r7Ty0ZqXWd2B/22JlXm5u8Vx6FcL5FkiRAYgtpYBTSz?=
 =?us-ascii?Q?8ffqQCk6mqUnCFY8O2HC5WLWcVGSWVTTLMehNlbCdVyp48ReG/tjQsSD9S1F?=
 =?us-ascii?Q?qKruF7WLeXSD4P1dMXf1RF92xuFQhjuntj43is+ZZ3w3CN0OHI7HSIutNAPt?=
 =?us-ascii?Q?inEuU8uTnkDwkWMQJaVAKZR8msRZgKjUoy8LxZjai6prS0JpMgsd6owDfYZD?=
 =?us-ascii?Q?CdB2JOBCzEeDTkkqASmUY7Q4kkk6qRO0Ic3ZMaTRQNf1gr7zTP1hr9fkut1q?=
 =?us-ascii?Q?JKJNSxACWbdJet+/adbuyb/zA2i941TzSCZmwaerhY1o8UmrQ+eWTkEhWTIZ?=
 =?us-ascii?Q?QkPwGQZC8OaZy0p9pkYiGTFt/lSqGPtKbxwptcTOc2pb9qIykXNuoLidtW5a?=
 =?us-ascii?Q?mqs/f0dSovLZKNLg/ei6ElPy+G56yvzg5gngWYjZVSYcXmflzvtOXFzHrjlE?=
 =?us-ascii?Q?t0kIi5cznWbOJq9xljwFMJlVFxLDcCduJooL4cUsRhbVa8WNDMX50WTW6vEE?=
 =?us-ascii?Q?M848RSPkFdhHtgqA739z5Oc9WdXi4V8gaJgS8iXmSWdvT46/4Tw/GjvhBJKE?=
 =?us-ascii?Q?bIBJvUpsn0obS4L2FAMZSIkQLaWRtA6oJxs5gjoRKHTFUoX2QMVcKHsId0vR?=
 =?us-ascii?Q?6DhAdZaUjUJ4qXViHYoTbA2+YtD4IP8xKDMjPavK6WtpuRskv5HOg0d+Qemb?=
 =?us-ascii?Q?hiBLjEOK/LZ3BES2fpRL8/rXEhjOvF/WpLAz1lu7UX55w2amoO2m9LLU1QFk?=
 =?us-ascii?Q?Vxn5BPVqXD7yn4y4JB58pbobYE4/txS8WQUM8H1I72hUP1yVoer1BaBIG+qt?=
 =?us-ascii?Q?rNlBXujUbGZ76Qj9lnemI+6H2FJi1kJQit/Wz02MavGkWpdblJMTH4QTFS9b?=
 =?us-ascii?Q?7sLuykAlB5jDUO32VKwiT6dSKMEcSnSI3Gff4MtoncxDpZDAk+09UuzVHx9B?=
 =?us-ascii?Q?JeZae2ydveFvBZobonZtHL43b3Gu9JwcyC8enqi4xfFiwYw1nbZHN1vl+hO/?=
 =?us-ascii?Q?aT39jGPMchxuy5PofPL4RKHjDC21HrqawxcQLChVuzYE42HK3fZE76k1+TCm?=
 =?us-ascii?Q?eS/qW/VY1mXtURiDyCTJACvN5zp8AGLoj+4LRdjSa1XSvSB6Z3HGE+21P473?=
 =?us-ascii?Q?uBwpl25OXCo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR11MB8797.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(4022899009)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+TGuV7SxR3YrFVmzfW0e0YsWS9BV7lFLCkjapWKmtInBOxYkcEUS3VVe41A8?=
 =?us-ascii?Q?iCgFQ1cyprWtdIZkE1wJzA0jVqwle4tQTmW5Oiq4UvAv6hFkL2PtuRJYo9I2?=
 =?us-ascii?Q?0zfT4p3tn9RUTL8kgRvrOfvasJwz0RmT8lxSCPznSsUQK/w2iPxTVCqsOd0v?=
 =?us-ascii?Q?wonFhs/BeuoRBhb8Jjn1rwTdeS/RoHx7lN17V0dust1aJycTtrnidjb4qOhy?=
 =?us-ascii?Q?/Ueoxhdn3QDG5qZx/dAPiKqrzkSvKun3jnMkiiajTbapNGPXHmjcF99M6lru?=
 =?us-ascii?Q?T8WIxmioMZhcFh+J1eud/0KSh9KiyNY7mBlbCA0v7/oB8Apv7H4t06NK4PEU?=
 =?us-ascii?Q?GPIdTUVUB/z8cOu9OKILnWvnfxUmziyLZLb3HcXmIYqvL12yjbKJOY7S/yo/?=
 =?us-ascii?Q?WUH9SXIYVW0JaEEmnWoRhYxpNn96Taxa2NimLMGoRlg4pfRAKMMSIB5PQPma?=
 =?us-ascii?Q?QEkPN2+dLgVP/0pGRw+NGlCpn5rKYrZx079/nO24QLVFrYOI0r5aWS05s1ej?=
 =?us-ascii?Q?5LMxk0F7MJr+p//k4TH90kTwFABXyVig/SuzKCgq2ki0S03zTPT0PNWIYjFd?=
 =?us-ascii?Q?9Y6A4R3RTxBtWLV0TFn6/7DGCfCIbJi+6uKtYSWuRmLn4mCRYAqs+GtuWr2v?=
 =?us-ascii?Q?d4IG1uAY1VKSD2ozXTyaJVF8NlYeN40QAiFN1R5YuUG3BmiYt5e0wmRi5rrW?=
 =?us-ascii?Q?BAe73Alhb90WfMeVQr3mRuAdmO5w3mLxPjgOrhXFaqJ79Qp4gaCjG60PdYYA?=
 =?us-ascii?Q?TQ9tXdaiyLr8IaYoiPc4NuLKrDbmFET7z6wJJZV3Q+XioAx4X5J1l17eAnZJ?=
 =?us-ascii?Q?FlTzzpuHQaGZjdmFUKqEX1Kr7NvoqxgKGNz+c2C0FjwoqxwUvHVqbdtbWkbb?=
 =?us-ascii?Q?2jkOuGiNukWDGoLIjyvlGhnMVlemC+5sX0zmD0I0XrE2v9LjRpwZF1vUK7zl?=
 =?us-ascii?Q?8EQ3HM/6lhmKOMIL6wqzQhu/5XeR209pNQevpnPbTPLzcDF6x17QoTMueVxE?=
 =?us-ascii?Q?0KM0CxxI5ci4ylsh62DN9cEut55mh1XM+vZm/mB2aTOMcFpRUfuEnoRnhUgt?=
 =?us-ascii?Q?1GMYaUXSFfnahKgz0IMU1qwlUFXPE90zKRTvZfLQB6l2tXUfONv7sCYLvnbt?=
 =?us-ascii?Q?b9BhGhEPqbLkgfj93+iSr7xCXaQz6W+2bX0J07K5hrj3Dw/do6P65SmITDS1?=
 =?us-ascii?Q?TVRQSCuAWPU3wHfNbaYT3WB7Q7P63IC7mFbZTpyYhAK39ELjHQSj0ZR6JbJJ?=
 =?us-ascii?Q?gPVOk4wWUJE65rYt0dS04Se4cSFFx56n5+/5hxW2YEf8d9UIKDuCbiu5nuaA?=
 =?us-ascii?Q?UBKAdu+APBlZJ39+NnVu5DSOzVlK9HXRlxvEtj+BZJVmEQTXHCIlh4c/wD7U?=
 =?us-ascii?Q?skZYD83oEYgoivMauO+b3iYvikEVR4wzdkjqLxwt1VGmlB3P2AW+1qHZX8E3?=
 =?us-ascii?Q?SczMSZBQFtq4rWe1u4W40VYsThfij4XHpfAMj55QCn3EPEcC2/ZYjQq2eG8J?=
 =?us-ascii?Q?ILGdqY41LuH9qoT0rykNYYBPOlHYNRLgKSIFywZL6IImxRBveRnAg80hla8e?=
 =?us-ascii?Q?U2qpQ63AGeV4DbZWB7J/+6TZIXQbszSER6lnSxzh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL4PR11MB8797.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93730c0b-775f-4b62-ed87-08dda4e9293d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 10:59:08.2566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ocVz5fyPvBb2JxrVHrwcz5m5PxTCu3l+dPzJTybc6FOdt3U0pHHTF2GXJtFTh/0ai9o0pZT5PkM+p2LKjSxDsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7154
X-OriginatorOrg: intel.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 06 Jun 2025 10:59:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1621


> -----Original Message-----
> From: yocto-patches@lists.yoctoproject.org <yocto-
> patches@lists.yoctoproject.org> On Behalf Of Sandeep Gundlupet Raju via
> lists.yoctoproject.org
> Sent: Thursday, 5 June, 2025 11:23 AM
> To: yocto-patches@lists.yoctoproject.org
> Cc: naveen.kumar.saini@intel.com
> Subject: [yocto-patches] [meta-zephyr][walnascar,scarthgap,master][PATCH]
> layer.conf: Add LAYERBASE_zephyrcore variable
>=20
> Add LAYERBASE_zephyrcore variable so that files from meta-zephyr-core can=
 be
> accessed from other layers.
>=20
> Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
> Signed-off-by: Sandeep Gundlupet Raju <grsandeep85@gmail.com>
> ---
>  meta-zephyr-core/conf/layer.conf | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/meta-zephyr-core/conf/layer.conf b/meta-zephyr-core/conf/lay=
er.conf
> index e1bb263..a4b3555 100644
> --- a/meta-zephyr-core/conf/layer.conf
> +++ b/meta-zephyr-core/conf/layer.conf
> @@ -20,3 +20,6 @@ LAYERSERIES_COMPAT_zephyrcore =3D "kirkstone scarthgap"
>  PYTHON3_NATIVE_SITEPACKAGES_DIR =3D
> "${libdir_native}/${PYTHON3_DIR}/site-packages"
>=20
>  addpylib ${LAYERDIR}/lib oeqa
> +
> +# Allow other layers to find the root of this layer if necessary.
> +LAYERBASE_zephyrcore =3D "${LAYERDIR}"[]=20


can you please further explain the problem and the usage for this variable?=
=20
LAYERBASE doesn't seems like standard variable

> --
> 2.34.1
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1617): https://lists.yoctoproject.org/g/yocto-
> patches/message/1617
> Mute This Topic: https://lists.yoctoproject.org/mt/113479750/1648606
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-
> patches/leave/13233161/1648606/629479993/xyzzy [chee.yang.lee@intel.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


