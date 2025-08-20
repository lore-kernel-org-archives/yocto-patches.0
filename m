Return-Path: <chee.yang.lee@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374A4CA0EED
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 08:02:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mx.groups.io with SMTP id smtpd.web10.14765.1755676974748967031
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 20 Aug 2025 01:02:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=jHBGL/Bg;
 spf=pass (domain: intel.com, ip: 198.175.65.19, mailfrom: chee.yang.lee@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755676974; x=1787212974;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=T/ZQGLRlARDzQbknd8eGLU8ULRI28sFlIGTnnHq25qY=;
  b=jHBGL/Bgdrb2efMptA2R292Yf20vm+gI4IOU3uLDjvgh0eufd6a3sZW3
   ISZVRfrE8aMo3vxOZzAeO9j1PezfY+X/OC1cQ5b8yMycmMXGrkVu3cMVx
   VwPHOstOt6PhTYo8ErCS9CPFnIeEbzFGlRlUKazzLbmOAzRm+/WWtCdiO
   LJpal8TIJfvZaErmFdyYt6ZOj3tVrj5Xa9bX9XOvFxZN59Pba/7vwtC2q
   1L8tY/MMxfbzztyPgb/ej4iC3KI7uq46dgoK/4+g4BlAAI8FUbNhpcKfQ
   4JsqJ4pVLaxYUcfSKWhAwLWHyK2lxhd9sIkhv/1h1lEXowFbNn8MtSAoA
   w==;
X-CSE-ConnectionGUID: rql+OeK/TWm2Oi5kg+J4sg==
X-CSE-MsgGUID: GCXHgS7eR4yLHNWJDgaDWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57796809"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57796809"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 01:02:50 -0700
X-CSE-ConnectionGUID: NopLADHITAWqVMUm70YP8w==
X-CSE-MsgGUID: 1QiOev5FTKSgchTDKADndQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="205222313"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 01:02:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 01:02:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 20 Aug 2025 01:02:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.65)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 01:02:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c97cJCZJvYFHDfKHbYJ1IgWp4E49k8CDO4KAVkujKVDM9jVItTm6beKTZtOC37YmPzQCNkcGIJq5wU6TZzArKdICKbu689cSNIhRxZaCEaRmBzSB9AUTLLaRzEi0V+DeyeOeNYl8fppw/szv5jAcsUiCWxQ4jZb+CFFWtU+aiQ4FFxQlYGWOhHM1JImjIKpduVVeowsUlPbrYz/ENPAssID35Xa6Ia4kyEdENLoCyAaXigf6L/5p+vA37/DJbCV9ZRVUihvJKH3qc0j6VimoVXrJREcD/B8RqEpt3Cs3RGj69rTTHyRAvKPVScoboUCF4zO7Rl7TojWwV9ff0S6PWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+JbhTscltMUbikM65f3jD9sS98mBxnR+oXxFETdcFo=;
 b=UeZ0RmY29/fPuPRIGAwgUO4LmhREpKVhF00xvlPiOFwuhftf0Sb6uP3XJesV6I+XRoUU1JK0VWspEWvwcT+gZls0AWwJYDfId0NqmxHKfchLoYauK0nKpWr0m7QuJTZlhTEMv7D8EpLP5VbLQRw8K8+4vNPw0IZYjKYez77ge387fLZoluQ2hw6dUJhIEAmt3sxseu7e2b9mb5I6Yr4s3CjkogoHIo6oasQQsibwGgYpwhbDWfJgyxCATIix6evVNeEP23Q7beecbUqf+sYNA94Do9JbW2jHFqtVbhzL84tadaIMwm7TWWicmkal+PbZvtcS3WiNLWlng4byyfnChw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL4PR11MB8797.namprd11.prod.outlook.com (2603:10b6:208:5a7::8)
 by IA1PR11MB9471.namprd11.prod.outlook.com (2603:10b6:208:5b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 08:02:48 +0000
Received: from BL4PR11MB8797.namprd11.prod.outlook.com
 ([fe80::311e:565b:ccfd:f4c8]) by BL4PR11MB8797.namprd11.prod.outlook.com
 ([fe80::311e:565b:ccfd:f4c8%5]) with mapi id 15.20.9031.024; Wed, 20 Aug 2025
 08:02:47 +0000
From: "Lee, Chee Yang" <chee.yang.lee@intel.com>
To: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>,
	"yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Subject: RE: [meta-zephyr][scarthgap][PATCH v6 10/11] zephyr-kernel: Add rpmsg
 multi services recipe
Thread-Topic: [meta-zephyr][scarthgap][PATCH v6 10/11] zephyr-kernel: Add
 rpmsg multi services recipe
Thread-Index: AQHcEIv79J3EEd9jMUaEHyFwmaj6P7Rq0SGw
Date: Wed, 20 Aug 2025 08:02:47 +0000
Message-ID: <BL4PR11MB879791DA10D548D88531B23DB933A@BL4PR11MB8797.namprd11.prod.outlook.com>
References: <20250818220304.2300436-1-sandeep.gundlupet-raju@amd.com>
 <20250818220304.2300436-11-sandeep.gundlupet-raju@amd.com>
In-Reply-To: <20250818220304.2300436-11-sandeep.gundlupet-raju@amd.com>
Accept-Language: en-SG, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR11MB8797:EE_|IA1PR11MB9471:EE_
x-ms-office365-filtering-correlation-id: 78a5e681-f7c4-4617-1dbc-08dddfbff3d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?e/0861nU75LeZtR3OUCi66f+L2EXcSDwpmaRdRR1VxEDFzd8OlGRvotCa3b9?=
 =?us-ascii?Q?CBnR2npf3wjMiJN5BVPqZwEmSzChvQmYbMzAcVWaPsRGdAqVpntQiTfQLSiA?=
 =?us-ascii?Q?o/fVcw+vKsTiz5OMA5/NrJrwk58UysAnTbbzqMB8hXs/IDQOsc4/J9J47G4Q?=
 =?us-ascii?Q?w5aL6CdrbaJ05IZRDZ/8jxfFTxCJ5meGgR8divCXKia2MZyyCpXKlZ0byw0y?=
 =?us-ascii?Q?VzxNvnop8M/DVUn9DXPOvRfhFG4KUv2qknC718pvXFbbwrl6u0wcAug2groI?=
 =?us-ascii?Q?Ih5fNoE0v6+cjZQDAwVtvkM1kHvzEn3po2TM/YKma3+qK318LN8NgUH/IJ8e?=
 =?us-ascii?Q?m/EBOiJ8YUEGx1FFMKcpkEPCblzs3gRlpiZYWfK5qVWPwCSekGPt+SY1kAGt?=
 =?us-ascii?Q?6KjRmZzUNKCnE86ichw2YY8iFw3XgQ6v10suszI4cposAv6w1hG4v21gfSkp?=
 =?us-ascii?Q?79mTfqpGi4AaAmvWe8vBVmcmDq8Un60wSRBoVkPnndTc57GHQ7j4slGSCk0h?=
 =?us-ascii?Q?VRPjgDYC+lvJGx4JhLYbFHJYA605n3eKf0JvFz0MdSyHw7WnDu0AxPKD1ELe?=
 =?us-ascii?Q?ntYiEe3MiS1/uUo7jP/YW06BQxkuEJcm02Oj1kSztB3Zl/UfiWmtW/KaZkK+?=
 =?us-ascii?Q?/tlarURD98q4tnONXtxWDFGJoZsIAJdT49mYGpM5UomPrJobyWVeNWIdqCNc?=
 =?us-ascii?Q?eHXay7f7wsSMPGUKA9dwk8peuty/I7kDAPYAcBDsdAiQvDL1hMZfwwOQ8iXK?=
 =?us-ascii?Q?Z3FpwnlFtmI7+8J98zR/i9vHwo7IMKcCtfMmdDLdcZ4lytpLYZVR8YhANz/u?=
 =?us-ascii?Q?Frr2MBnClhhI5TKt2mG2+2pdb1me/vHUnU8FA+RTx0snCh5GWsW4dQf/+iEo?=
 =?us-ascii?Q?iuhIKvBBjJZ8dbjZJJ8cBNHT+6nYghxVvMcq92ZnGh8GKOnugT+V1DO8nZ00?=
 =?us-ascii?Q?5tpLkRToW6EcB/OQqIbzroDTC6dMx6sO3Uiz87IG4thxPn9/RHCZbBgElzVW?=
 =?us-ascii?Q?emHfeNVkKq1Gt4KwrF7uOcJsQfmzKawXknffLzDJ+xDxxJLrg7twnUapck96?=
 =?us-ascii?Q?pd74cNokMYRuJF/llTwu1I3Xb1wlNeQzgOfwozq1nFpNZAbOFMeVUTOzuK8K?=
 =?us-ascii?Q?/gbtPSzNr/QEavkIwroTs27cfJx5/qvLcOvqPFg4Vyf/ydVdmk5iFebMpNIB?=
 =?us-ascii?Q?y75jBi3ByfTeWrUsED82LLjUdqSCq4amsV/Tmo2bMRTyE2pG09g8nHhcqI27?=
 =?us-ascii?Q?MiNIxJPEJTEHUaROScs4Bh/MqkZrc70mxsSfXYQ/AKWI0X8Rrstse8W3y4Ym?=
 =?us-ascii?Q?/EKXrR6BVaKmWUjgZcWC2S8yEJkM6OgKY4WLOmG6OT1gdnifC6YHb3B6cDoH?=
 =?us-ascii?Q?H4Wu0fZowT0KEASDFpIEIDOX0G4e3jS/Ju/qTOKt9f9H9EBEkrZGVL+cdrs3?=
 =?us-ascii?Q?M2XNnfvMQwyYeikxUYFf7HRYj2HhkZUEQdgvtXve5qXEnayIP3GQPw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR11MB8797.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QQOj2vBbShPX/D6oKM0tyzBOabf8aEhzl0RUJo8muJiIexK8H10m12vU3dVY?=
 =?us-ascii?Q?+OD38DLzOS5z4E/FTni0m9VEgoRSC65b2C1GwKZlNgfOpjXrV2DJ7cd3m22J?=
 =?us-ascii?Q?vFZIujgf35ybm3k1o1o5oCVZkE5p2frYDyptB1YKBl7yiiFpxv27WgwrRA+w?=
 =?us-ascii?Q?zn+woB1PE70vYy6kSjZxCR1OAcNixFhuoUa+QEIFoYJY3ENmaXgWeeSnTcos?=
 =?us-ascii?Q?4a/2vxHY/vtZ6SaS8KhYYBtkp+HILXxgxoJt6GZWsF1nGOOc67qwlIKoDd66?=
 =?us-ascii?Q?jm6+6ldf8/Hd0B/pS2vT8nTJYfCxpqWiirsfdQB4L5e+UaoasmP4CowU68pb?=
 =?us-ascii?Q?Du2xvwvWA6TRcnBWoJascImgIT5+WpJZ3ISukE41AwbLbHxI0Sw7Zm8hzltx?=
 =?us-ascii?Q?nAzMCkAfznyG3w9B8+Ik7zE46RJ0XpfjfoBJ4M0NzSmqPn9cDfedONSHKh49?=
 =?us-ascii?Q?D17rhl6Z0Tax6Yf5TLa5LmhMbrELw5dhM9xhHK1iqKqY2czb3Es9jAT4EeZs?=
 =?us-ascii?Q?iAFV38dvf27KrgtzYBzrPkcVLi4InlHO85ouGnCR5PCoy2QHsxh7XIyjUw6a?=
 =?us-ascii?Q?GeU8165koS51FCa9mpBFYoCi6466NXKTsHGrLdpjSFJnqqtvYzIZIrjGFG6w?=
 =?us-ascii?Q?d+TuHOHEa0/qVfFUuSSxDGpjnKOBEa5osIunWHWtZ/c2bTfglGPT2ip52n2a?=
 =?us-ascii?Q?gNXr5TJqHWJkijV84ftqt1H03Zj6vqK7bgEmwIBrp+7E+hAuGnm0j0CVdnWP?=
 =?us-ascii?Q?dmfTsFasCKMS7/LYBvkhQgT20DPFWZWrGZDNVlukop8au1sBVSeZoS9dUTK0?=
 =?us-ascii?Q?hZr4dSVRecYU5Cm1tdA3Ta1L7YGyEOX6vrmX6ouhMmNhq/zO/ymsDMu6IqK2?=
 =?us-ascii?Q?Hl9A/vd6PIyQfrpl/x4QdpwQqEAq9HqzVVrzVxg2EYg0mxN3zDk6CGotXYPM?=
 =?us-ascii?Q?oXfR3F7TYiE1ItKnIxCRm4aCqkXrvV6YVw2BFW+KZI9XmmjcnoO3wbLFI386?=
 =?us-ascii?Q?i5GlODRbOTHgVbIbKfmVaNc6dlfIO0S3T2+8syU0v5yEnxsk/myVXNu4Hh97?=
 =?us-ascii?Q?u2FJuBHlhJubyedZ4cYbePPIT7adGrgmczEW7ZtgqG2X14PiUpFoa3ph+nRO?=
 =?us-ascii?Q?trqqgkKouHQomNH+QJvsWO75CiZ2WMUlKhfCzuk+uK4VZI71WJFov2s3rGXI?=
 =?us-ascii?Q?x+STbYxECAkeeYzM3UZnoPJKbKfAgMjTiJUR2gB3NhoxaIOc6QtsxdFi6ish?=
 =?us-ascii?Q?uB0rgYXPjRJAUWnkIAYuesopzgIPQEbPvpkoaGeLzEhO69qaQ5X7ejZ+9C6p?=
 =?us-ascii?Q?CsLyxUkTDoSMCkd4cfsZHfhj1PXtBP/CtZb0LyuoxjfttNN7XAuhOCKTcXAq?=
 =?us-ascii?Q?nlmC4715XtQtKZSMaAyFA8THUH7zUrCRUwkh7xig4JfLR54wIbsJKCRE0o8m?=
 =?us-ascii?Q?uVFHg02YB1rEmse9+TmFSfRofO1ygLG7kq/7fNHOXuRdoUTJY8tHgkY6RxNG?=
 =?us-ascii?Q?v1PYHTxplOofHpkEZkH8kcV1GaLm0obS82p25BJe5jms2Yp8jGYWnin5jC2s?=
 =?us-ascii?Q?bi92ngsc62o76eKTu72j193NUeqWj1NW66V7ZroX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL4PR11MB8797.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a5e681-f7c4-4617-1dbc-08dddfbff3d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 08:02:47.8601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M8FOTilBeT46FvA8WNzbI9u4K6er1ri1mR6p5oGSTjQBVVRrRZqlOTbD4zXheCelGGGnyIeVjOaVQ6yuTGlBxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB9471
X-OriginatorOrg: intel.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 20 Aug 2025 08:02:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2063


I got this error while building the recipe

| /data/scarthgap/poky/build-zephyr/tmp-newlib/work/cortexa9-vfp-yocto-eabi=
/zephyr-openamp-rpmsg-multi-srv/3.7.0+git/git/open-amp-sys-ref/examples/zep=
hyr/rpmsg_multi_services/src/main_remote.c:26:2: error: #error "Sample requ=
ires definition of shared memory for rpmsg"
|    26 | #error "Sample requires definition of shared memory for rpmsg"
|       |  ^~~~~
| In file included from /data/scarthgap/poky/build-zephyr/tmp-newlib/work/c=
ortexa9-vfp-yocto-eabi/zephyr-openamp-rpmsg-multi-srv/3.7.0+git/git/zephyr/=
include/zephyr/toolchain/gcc.h:98,
|                  from /data/scarthgap/poky/build-zephyr/tmp-newlib/work/c=
ortexa9-vfp-yocto-eabi/zephyr-openamp-rpmsg-multi-srv/3.7.0+git/git/zephyr/=
include/zephyr/toolchain.h:50,
|                  from /data/scarthgap/poky/build-zephyr/tmp-newlib/work/c=
ortexa9-vfp-yocto-eabi/zephyr-openamp-rpmsg-multi-srv/3.7.0+git/git/zephyr/=
include/zephyr/kernel_includes.h:23,
|                  from /data/scarthgap/poky/build-zephyr/tmp-newlib/work/c=
ortexa9-vfp-yocto-eabi/zephyr-openamp-rpmsg-multi-srv/3.7.0+git/git/zephyr/=
include/zephyr/kernel.h:17,
|                  from /data/scarthgap/poky/build-zephyr/tmp-newlib/work/c=
ortexa9-vfp-yocto-eabi/zephyr-openamp-rpmsg-multi-srv/3.7.0+git/git/open-am=
p-sys-ref/examples/zephyr/rpmsg_multi_services/src/main_remote.c:7:


Build With=20

meta                 =3D "scarthgap:6f7e929ea6ea557f107c8ccffea69a7d7343959=
1"
meta-oe
meta-python          =3D "scarthgap:c29a18fa39ede952f3f6108ec007c1906e2d9a0=
d"


> -----Original Message-----
> From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
> Sent: Tuesday, 19 August, 2025 6:03 AM
> To: yocto-patches@lists.yoctoproject.org; Lee, Chee Yang
> <chee.yang.lee@intel.com>
> Subject: [meta-zephyr][scarthgap][PATCH v6 10/11] zephyr-kernel: Add
> rpmsg multi services recipe
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
> +    "
> +
> +SRCREV_open-amp-sys-ref =3D
> "d78315763fbacba8a74552d0ad570bd01c42ccf9"
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


