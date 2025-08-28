Return-Path: <chee.yang.lee@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AED9CA0EED
	for <webhook@archiver.kernel.org>; Thu, 28 Aug 2025 08:16:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mx.groups.io with SMTP id smtpd.web10.15813.1756369009853108369
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 28 Aug 2025 01:16:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=gOObx4M1;
 spf=pass (domain: intel.com, ip: 192.198.163.11, mailfrom: chee.yang.lee@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756369010; x=1787905010;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=7YMbcqJjSAHGwr8uP/Kpsu4Fuf1XFtNf1KaFV36h1cg=;
  b=gOObx4M1XcTL1JHqPBb2TB8YVeeFCTNl78ADTUvstWs7+MmIviJ5gS1p
   xPl5OGNBG/hpwNiXVk2Scw3rAWa3Muv+MDaoSBEHc2Jx750cZKOBaweKo
   +IZGgv4SIG79iCgmIhAbkL9/3fKpdl3G5uYj/rLVlUWlOZWwwVLRqF+WI
   roTM72/Yjv8eOZLvA8aQXT70yfgndc9hgGxjRmYkiz8YjjYX/L3d3S9os
   VcdZyvOMb3Xg5psIwwwz4tEXL9aG7R6bjfCNIsMG91X8wEG0FnVvV1VVB
   Ou1X7ittgXMvUMuHNDWKyt9g3QHjhMxkRQouUXstN2zF/UNhFxmWAMZDL
   A==;
X-CSE-ConnectionGUID: 6MsZ0vrWQFSTL8rsAdP6wA==
X-CSE-MsgGUID: d+6Q7+m0Tf6MqT4u0pHz8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="69223950"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="69223950"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:16:50 -0700
X-CSE-ConnectionGUID: NlvjlT3yQDaE54J6tL1TZQ==
X-CSE-MsgGUID: xxCUf95gSTK/cGVmdAMiPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="174440331"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:16:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 01:16:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 01:16:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.83)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 01:16:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=klML6I0mwVn756WGgpTN32YpZEig2ycm/eYwi/TLFsOUrmv07vnwZFJfr9H43bVvrGBNiv0SrqDX92EbqwnFH5XAgXlie/pq6O7LUEG4iW3Owsp0lMXg9afTvQFEbQTb9jZbM5KHxIyEuAOS8joqFPx/Oz44tD3ia14xVDWgAIwtsj17dWdqOu7RWwvvYhLkvwTKwnaDC6Rr7YO5/j1r9ZsAggN2MvdEExZaufRwiu8X9vK898pVo9cKbPgMvi7/v2/ZtvbnhHtfRbxf+7yrhPsMj4iEYis8WXUINjULShqYM5ACjdORAY8oYQDf/NWdPrhY82/g05qpyzTc2B+0Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrZrMyin9+8FiT2//NjkzSUTxsVVfvCQac0OaoO1z9s=;
 b=UhnHIbqtqL+cTiedgvVqbQEkJdLSD3Aa7/Qf+IaBgSnhF7B9s40gRai1J5Omrj8odeGmQvPr+O4WgXEOPC5k+dAkCtZNcfFY3UOuTkeOLFgLio4udRapsd1QhtZ0BgQzoWHHrhApScqb3kCRcDWonpTZ+yRbORHS9kV3K2mUcjl0lvSCg3OMPkgB5nLAWbxYTaLBNJiIc+5QxCrOj8p5GMm1WUWAUmoQELN0795ggKAjbrcMN7RzxGlN73Z/VcoyPwYkA/NfSW4GjcXkBETsxFw0jwsAzfj8CQE3V07wCK62nhheQ1B6ox6hcCtdvLeUqpkAmC24dXvXkSndIG1+qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL4PR11MB8797.namprd11.prod.outlook.com (2603:10b6:208:5a7::8)
 by DM6PR11MB4515.namprd11.prod.outlook.com (2603:10b6:5:2a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Thu, 28 Aug
 2025 08:16:45 +0000
Received: from BL4PR11MB8797.namprd11.prod.outlook.com
 ([fe80::311e:565b:ccfd:f4c8]) by BL4PR11MB8797.namprd11.prod.outlook.com
 ([fe80::311e:565b:ccfd:f4c8%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 08:16:45 +0000
From: "Lee, Chee Yang" <chee.yang.lee@intel.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>, "Gundlupet Raju, Sandeep"
	<sandeep.gundlupet-raju@amd.com>
Subject: RE: [yocto-patches] [meta-zephyr][master][PATCH v3 1/1]
 zephyr-kernel: Add rpmsg multi services recipe
Thread-Topic: [yocto-patches] [meta-zephyr][master][PATCH v3 1/1]
 zephyr-kernel: Add rpmsg multi services recipe
Thread-Index: AQHcEeBXNDrevSHTmEKHz3JnwWyJw7R1CMEQ
Date: Thu, 28 Aug 2025 08:16:45 +0000
Message-ID: <BL4PR11MB8797F6E908FBFEF26CBDF6FDB93BA@BL4PR11MB8797.namprd11.prod.outlook.com>
References: <20250820143951.4033778-1-sandeep.gundlupet-raju@amd.com>
In-Reply-To: <20250820143951.4033778-1-sandeep.gundlupet-raju@amd.com>
Accept-Language: en-SG, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR11MB8797:EE_|DM6PR11MB4515:EE_
x-ms-office365-filtering-correlation-id: b37c0c56-5aac-4e76-dcd9-08dde60b3a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|4022899009|7053199007|13003099007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?8aQaCva1QD8E9TabhD2eqai76/aZ/L7aEV1ehzHPaMT1LfJkR1vJUAPT/NKE?=
 =?us-ascii?Q?BxteJ7Xd/DxFfBg2cNg0sfxo3ZyAqSKb/S0divyGKG0WP38j5wSVDIN6H3f+?=
 =?us-ascii?Q?Tz2/lCDFv32j80bHJSrNZ7NdE4NwqQ7y42zRPR2TBxdQJhtN4YPEhmaZqujN?=
 =?us-ascii?Q?iTG9tybxoe+YZbuva5vxPbIvOJ2oFZBTdTaQrHJOjz/UY+mMpOKVppcy1TsZ?=
 =?us-ascii?Q?Kf9KloVrdn40v28olKWf/eqMvulpbJwgymBb5SKaWWVZRvf6kgQCCKZyr8ed?=
 =?us-ascii?Q?AWtVH/c0ZTMT/NLfmF/W87RoGr8Nx0Np8Zd/2LmYDwFgjMKaza7OFZQnPn32?=
 =?us-ascii?Q?b7/hdwMMeCgDhC1ZCkDl7pArfw4t5DPXV+XwtHhrovLTgU83guOGHdooNe9l?=
 =?us-ascii?Q?Uxsd3DJuu50i73/Xr8vy/migXaSDv0HPfAkPalIoI3NonuX8G4YA74xZZCvg?=
 =?us-ascii?Q?PMuhnDdhoZfGOFe/3QllchSdW8SO+afiuhKtKGsN9XlML/fNes9xBW/8l7Tb?=
 =?us-ascii?Q?LniPkUS7RN7uNG5ERzlXve5KVHZIleB0bHSPNK8cSumGNqACt8OlhSXv2o96?=
 =?us-ascii?Q?K53o044VVH7Sl+R1e/GsCM2jKWutGa1sSj5nvdc+a8x+dQBcFSQXP2WSi+EG?=
 =?us-ascii?Q?UJwEuM9Dtg3tXR+/RrqoZsgp5R2kgJE+IGn55JcdnuWCLH3Ae4cDgQHBOKdR?=
 =?us-ascii?Q?riHx3CE75SNJSGz3vBeMCyEewJ2Zest8P6OiiB3jAkJODRvFrepTUio/SNjf?=
 =?us-ascii?Q?xs8KQYlqcbef+2HviDXu5J1JXeewkGcautePynlj1diOmUKXMC5aWuITZtXQ?=
 =?us-ascii?Q?pKw/42qfv2Iy6G9GNO0uECU5qDzuumCOL2U6v/e9oyBiS0vL/riWnyJ7GJqp?=
 =?us-ascii?Q?lrHg1rFBLEkKPMERXrUPRsW9y5/lgPQ8taki0pWDKoY+ikbhcK89GOT4kg9N?=
 =?us-ascii?Q?WCiWbo6rfLZg6Xnz38nD+/khy8kG9CpgEILKU21Y8GJ7UqJcFpBh5m5uIBOu?=
 =?us-ascii?Q?IXTYRRHCV0sC9QMNO/Yg+c3YajA7cSSYy3Rf5PYEhhnYQ7ZcFV9qGcKXmiLv?=
 =?us-ascii?Q?dMd7SJBgh8EVRNrWexqQ4yGzcsVSpyyYCpUPmsZ8jIR9RGQVanyL/d+h7Ii8?=
 =?us-ascii?Q?CgBVuariY+B9TCVurRc0+RCz2zL3EBehrb/sGQB+bayx6AvntVhZ3K43V4AP?=
 =?us-ascii?Q?sF6nszZyytJTDOTiYEmF+GPpvNVV8QSlIYAUqggJuIjjvlOrLVYcdBobkQpP?=
 =?us-ascii?Q?3ZcYxawMfnlqwOnCq0K13n4lvyx8nw9rdrhgUGlivjeyTFMgf/PNdg4d7ipU?=
 =?us-ascii?Q?/P9jo/ctnBOTBIFJrwBV/7hD1/STNlwdoHA/0tCcOy3Siue1IFdeP0m3vBkj?=
 =?us-ascii?Q?BWsoBRsA+DI/cIuLKosZaFQV4wxRn+hSkgGXSbrOA8pLCEozB/EmzcNHWcR1?=
 =?us-ascii?Q?Hdm6s/jYStg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR11MB8797.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(4022899009)(7053199007)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SMeqRyiOCMtFaZoMKQ3+MS4MLe21akkvtwMfvnWxdSxE8yWYEGZXA/zZcpJS?=
 =?us-ascii?Q?8T5nA5y0hsg3+XvwA3kHO1SWxa2huS/HtKhg6du1S72mpAtzxz9WFIme+PN5?=
 =?us-ascii?Q?H7HYPTBKw5imFnIsgVjF80+F8NJYYP6ImBs7OPSKvTzPScFbKSy1ru1UyW/g?=
 =?us-ascii?Q?cP4JJzT/0uKFt4htSpoHJaPfERZ4puMAv7ygYdd2zHUMWPDpCVApnOu5F52a?=
 =?us-ascii?Q?W4onBXO6NWiV5fPNZxW+YKJ//G8BaMrMs0gidRvEZeaM0HCr1O/4PWhlwP3Y?=
 =?us-ascii?Q?vR99SgrRe1LIQSBLnNdQZFtNq03yDlYS+MgUxx2a6tSk5zm0cSH0uNmRUs9V?=
 =?us-ascii?Q?svr7x8/iG1AfB2wKsm1nGuQLo9YqmaMU0jrES2FIDyc/y5m2c6h3vimfUR+T?=
 =?us-ascii?Q?Z5VwtRFcTGt2FR/xjzGNTeDGka9nLJsdDCvqsmLFxTpulQxYdXSrK04CQhho?=
 =?us-ascii?Q?JMJHae5Tb/fIGqDpsx/ECXM6s/Dc10dgqSpK8ihZrbTPwOfeNoTz4JuE9Z0h?=
 =?us-ascii?Q?c5UBPv0Bsovtmqx1Z10IqFTXB/Z+YadMWdRrj73KjXcB4oRV/bQ0Xp4O0GYc?=
 =?us-ascii?Q?0EfToBhDSaLFVN79dL4/Nc+6WHRZHOA4E5TC2CLrxDeEmv4UF9ZjKNslyS7D?=
 =?us-ascii?Q?59Pvv5StFKw9+i4k9klV4475j2ThIWmha7+2so8uxTnteJl5INMS/y1r9pWt?=
 =?us-ascii?Q?8ASKPjgEiWA4esDLP4wskDBJ86f5w8DM0V25wCoy6rXRrwY5af8qCiPOKir8?=
 =?us-ascii?Q?gZfmDuoxaf+D5tPePt/DG/NmgWghm6AK2to9DVOVxa/Qcp2MutY3Puz5c01r?=
 =?us-ascii?Q?vhaCLq5zGMRcerRRQPfY0wvC8qbxz7sBfwH85mL9lLBLQFKX9KKeuEinGf9i?=
 =?us-ascii?Q?p7Qrs72Rsp7qqYAAxCN3OcSQ0Cm+rI0bM/gM70CA5XFoUMXUCCO+o3Y7Ukbe?=
 =?us-ascii?Q?fGZd2C1M88YPwFC7EiegMuHj8ixsi3P7ZXwTYDaPw3uUXsLY++sgisRYUwH+?=
 =?us-ascii?Q?tErTlYvWI3/o80n7pCmGvh5dsJq8oCelBUF/QMBccInnriRw+twudqJmQqrz?=
 =?us-ascii?Q?EIPKMbUBMH2RLzfEYUtkJezIh0RwSYs0b276tsasTH+Kdozpsa7SLSGV5i0x?=
 =?us-ascii?Q?0gIFd2OM5TD+xovIBwSNCK74RDIVz1sXucH21HVi/nYS3X7du7tl6Ec9wXP7?=
 =?us-ascii?Q?ANnSc8sJnJvLUeB+NmO42qsEMl1DOzXRMZ0Sfu60gZYYW6WzpE3dOi0IIc81?=
 =?us-ascii?Q?a2e8M2NF20rVoTjjPQ4XIIo3p9auWUFlY2wcIN18iPXjNNX8gxrpT6U3krGM?=
 =?us-ascii?Q?YSv6BCkUKVQFa7BMVtCgDOKm2V3sCMJRg4kdfu2Q7DPNYyfee1V85tTw/egU?=
 =?us-ascii?Q?gCj6JbzCuVmZ/XTbKkKe7H4KlW8lWJWLMaS5qbWaYdthHLP/xDk2/D+L8uVY?=
 =?us-ascii?Q?eOPQqc6MdUUxOemA+9qydiPrwHHLsFR5yfTMV0/DkdmVGawTqXxccWFlv7CZ?=
 =?us-ascii?Q?r6SgsVBcfoU5mzLscCBqtMilOkOol6BM99UQdBOeFOteYfUb7m2plzTIjoYv?=
 =?us-ascii?Q?G6w8nb1zHtEjbkH6Qdp87dzgsYa/G0mHfCnOh/F2G1PjQ63KXFnrYBJc0WkK?=
 =?us-ascii?Q?0+WkBNryQhKayuMl1YK6JyCqEdr9K/e/gnaMP5g/1Xx8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL4PR11MB8797.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37c0c56-5aac-4e76-dcd9-08dde60b3a4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 08:16:45.2998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DqLvXbfJiFwjJ5cTxWDwNbXXyvzouo2i8ok1xvOvIGWpx8knqw8jW8//MvQ+mHnDi/HkNRFQnVP5EFouDl1Jlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4515
X-OriginatorOrg: intel.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 28 Aug 2025 08:16:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2086

Hi Sandeep
Unfortunately, with these I still can't build the recipe. Looks like we nee=
d to patch CMakeLists.txt


meta                 =3D "master:fb4ebd60536af8672f950376106e0b0500d7007c"
meta-oe
meta-python          =3D "master:714b3adc3a92d42370a0ea57a9744ad2d031db7f"
meta-zephyr-core
meta-zephyr-bsp      =3D "master:5260aea7ef135d3b23f49c8d7bf6c6f78bdc2f50"


command :
MACHINE=3Dqemu-cortex-r5 bitbake zephyr-openamp-rpmsg-multi-srv


| CMake Error at /data/master/poky/build-zephyr/tmp/work/qemu_cortex_r5-zep=
hyr/zephyr-openamp-rpmsg-multi-srv/4.1.0+git/sources/zephyr-openamp-rpmsg-m=
ulti-srv-4.1.0+git/modules/hal/libmetal/libme
tal/CMakeLists.txt:1 (cmake_minimum_required):
|   Compatibility with CMake < 3.5 has been removed from CMake.
|
|   Update the VERSION argument <min> value.  Or, use the <min>...<max> syn=
tax
|   to tell CMake that the project requires at least <min> but has been upd=
ated
|   to work with policies introduced by <max> or earlier.
|
|   Or, add -DCMAKE_POLICY_VERSION_MINIMUM=3D3.5 to try configuring anyway.


> -----Original Message-----
> From: yocto-patches@lists.yoctoproject.org <yocto-
> patches@lists.yoctoproject.org> On Behalf Of Sandeep Gundlupet Raju via
> lists.yoctoproject.org
> Sent: Wednesday, 20 August, 2025 10:40 PM
> To: yocto-patches@lists.yoctoproject.org; Lee, Chee Yang
> <chee.yang.lee@intel.com>
> Subject: [yocto-patches] [meta-zephyr][master][PATCH v3 1/1] zephyr-kerne=
l:
> Add rpmsg multi services recipe
>=20
> Add zephyr-openamp-rpmsg-mulit-services recipe to build out of tree opena=
mp-
> system-reference example applications.
>=20
> Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
> ---
> Changes in v3:
>    - Add machine compatible for qemu-cortex-r5 and stm32mp157c-dk2
>      machines only.
>=20
> Testing:
>=20
> $ MACHINE=3Dqemu-cortex-r5 bitbake zephyr-openamp-rpmsg-multi-srv
> $ MACHINE=3Dstm32mp157c-dk2 bitbake zephyr-openamp-rpmsg-multi-srv
> ---
>  .../zephyr-openamp-rpmsg-multi-srv.bb         | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-
> openamp-rpmsg-multi-srv.bb
>=20
> diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp=
-
> rpmsg-multi-srv.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr=
-
> openamp-rpmsg-multi-srv.bb
> new file mode 100644
> index 0000000..dca3b9b
> --- /dev/null
> +++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rpmsg
> +++ -multi-srv.bb
> @@ -0,0 +1,25 @@
> +SUMMARY =3D "Open AMP rpmsg multi services"
> +DESCRIPTION =3D "Open AMP rpmsg multi services"
> +
> +inherit zephyr-sample
> +
> +SRC_URI_ZEPHYR_OPEN_AMP_SYS_REF ?=3D
> "git://github.com/OpenAMP/openamp-system-reference;protocol=3Dhttps"
> +
> +BRANCH ?=3D "v2024.05"
> +BRANCHARG =3D "${@['nobranch=3D1', 'branch=3D${BRANCH}'][d.getVar('BRANC=
H',
> True) !=3D '']}"
> +
> +SRC_URI:append =3D " \
> +    ${SRC_URI_ZEPHYR_OPEN_AMP_SYS_REF};name=3Dopen-amp-sys-
> ref;${BRANCHARG};destsuffix=3D${P}/open-amp-sys-ref \
> +    "
> +
> +SRCREV_open-amp-sys-ref =3D "d78315763fbacba8a74552d0ad570bd01c42ccf9"
> +
> +COMPATIBLE_MACHINE =3D "(qemu-cortex-r5|stm32mp157c-dk2)"
> +
> +ZEPHYR_SRC_DIR =3D "${ZEPHYR_BASE}/../open-amp-sys-
> ref/examples/zephyr/rpmsg_multi_services"
> +
> +ZEPHYR_MAKE_OUTPUT =3D "rpmsg_multi_services.elf"
> +
> +EXTRA_OECMAKE +=3D " \
> +    -DCONF_FILE=3D"prj.conf" \
> +    "
> --
> 2.34.1
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2073): https://lists.yoctoproject.org/g/yocto-
> patches/message/2073
> Mute This Topic: https://lists.yoctoproject.org/mt/114800427/1648606
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-
> patches/leave/13233161/1648606/629479993/xyzzy [chee.yang.lee@intel.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


