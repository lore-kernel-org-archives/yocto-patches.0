Return-Path: <naveen.kumar.saini@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE3AD206AB
	for <webhook@archiver.kernel.org>; Wed, 16 Oct 2024 07:36:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mx.groups.io with SMTP id smtpd.web11.17970.1729064210876399817
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Oct 2024 00:36:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=EnsUjxJh;
 spf=pass (domain: intel.com, ip: 192.198.163.17, mailfrom: naveen.kumar.saini@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729064211; x=1760600211;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=udOB0D9dEbKJe0jhbJyM7ISgmYpp8OrsfuS4guujSAY=;
  b=EnsUjxJhG0JMH1CgLBaXYS9W+629C7SfY24LY39jA2d+Kv28L3oBqjno
   EtvoXZa24bbszMbMoD53CocGbIveUVKfBYZGcRMkdKmBKqIT1rRfNyno9
   /hE9IfQnzanSNcLNiO9w4MbTI48w5jCMMuMVDQAX3/HCywx/feTOYQYyo
   60pvzEnpgFaZREpGEbk5xku5zQmzVB7x6W5LEYMRK6pXN0ESJtdD8MeRV
   6ZoiqYUr+7fGQAp5ewuDasSX6cPLGlZJk8NUNI2djzsvirblrGWmn+eNt
   AHpMwrVXLjvYJtVISX5Vo+dp7CLDrQaJCCC8+ulTuaQInMU1Dex2c1XgZ
   w==;
X-CSE-ConnectionGUID: 2VMBBZg6TM+0AxhVzUvZGA==
X-CSE-MsgGUID: vzpzkZnHQKG/CHjzcYr2rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28374094"
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="28374094"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 00:36:50 -0700
X-CSE-ConnectionGUID: UUJrr7yCSteva5C//YKI3A==
X-CSE-MsgGUID: gLST+Bb0Tsuu1p3nDIUGHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="108884612"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2024 00:36:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 00:36:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 16 Oct 2024 00:36:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 00:36:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7HQD0A4OfTKWUsWJuJsrc8BvBCHYT6MJ48iOh9NXtj0KBq3yUrYu7I/EvVx9JTq7TVWdSsvtBYSBnFfTfRaO48ulfiNIzs1ml26wL+nzEKurT1KXcibPh6owXBNm/zt1lNJXlKGcgugyrHw7OOb9o1vaJrHQ1ZEgQ3so/Ps/QaBiqkn4KqMi0XWxbLsqY6JTn/xwfDdP/OlDWbX2iyA8pZ4j698zPMWK2KUmxD2tEK8S0KYUskhmK/ra/bHdGqIQjxh7HVJgMXEv3vvPhLYrH9IYIEFaSWTbOzlOcbdfJA/5+huX34aKpRGOeDSmWBRyKO3KPvar8IKBiZqNXeK/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icg+ptUZzsS5BmwCH33TSQl9uLi5F4xq9DWfZvMZNL4=;
 b=fUYx33zvrMSVNMFY3H40qxjpb/P4euUUiZOyuloXV+hhguaS9w2piiOxC//FmY0draGY3uQRaQvkm5pJeXA6HdUWC+o9R/LX7dkrw/m6DfU+q6GeCvIp88+H4IIgUBNi91+VWntJJsllzBlG5YkYhnTW/GdwTyECwty8av0k8wY7Nfc9Tr/FXHHP/qD8Hz4vz/D8762z0QSoPY6i89gIJDJn+GVk0F7OdFD6NOL8epkWwfa2nqcP4+iN22FXycQu5utXGEGC0FsHdhxWnvgp696PGYc3kELqYOx5DExm47D2PLS8TWY2TJIU222oKgRvkoh+j8atQDMuPls53hyoqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5026.namprd11.prod.outlook.com (2603:10b6:303:9c::13)
 by MN0PR11MB6110.namprd11.prod.outlook.com (2603:10b6:208:3ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 07:36:43 +0000
Received: from CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::aeb:33f7:57:f7c9]) by CO1PR11MB5026.namprd11.prod.outlook.com
 ([fe80::aeb:33f7:57:f7c9%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 07:36:42 +0000
From: "Saini, Naveen Kumar" <naveen.kumar.saini@intel.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: Ben Cownley <ben.cownley@arm.com>, Jon Mason <jon.mason@arm.com>
Subject: RE: [yocto-patches] [meta-zephyr][PATCH 1/2]
 topics/baicow01/zephyr-ARCH-remove: Remove ARCH from meta-zephyr
Thread-Topic: [yocto-patches] [meta-zephyr][PATCH 1/2]
 topics/baicow01/zephyr-ARCH-remove: Remove ARCH from meta-zephyr
Thread-Index: AQHbDzJ/AQh4x6ojpkCXzaKfUTWEm7KJGntQ
Date: Wed, 16 Oct 2024 07:36:42 +0000
Message-ID: <CO1PR11MB5026C4AF87F23C156D2A3724C4462@CO1PR11MB5026.namprd11.prod.outlook.com>
References: <20240925093640.17353-1-Ben.Cownley@arm.com>
In-Reply-To: <20240925093640.17353-1-Ben.Cownley@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5026:EE_|MN0PR11MB6110:EE_
x-ms-office365-filtering-correlation-id: 10922215-fd66-4f7f-cf9b-08dcedb547ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|4022899009|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?+nE0rPX1+eWe20XnIqk/4bL7tI8ESltfBs7ERMqUCETcMhQjkUZOr4o6B76b?=
 =?us-ascii?Q?H7Vh4baVX68KT1STmVjXsbbrHYnWVKdE0GFGThVv9rGpzi9PAjTo/GFkZLQr?=
 =?us-ascii?Q?Z5xYYejuEGNgioo8VF99y2o43lKugMcDK74d7JQE0AsW4IVVBUjySeVjByNw?=
 =?us-ascii?Q?SLKFl8OrOnhzYNBoi7KNC9lNe9s7Jr9Tn8aUPMO6M3xp33WHvF5/tqnath/A?=
 =?us-ascii?Q?LuiarubKBuOsQ3XjzYW27pIcZj3FuoJmVBENmvGGKR8uFokjhGHA8CVwjyXX?=
 =?us-ascii?Q?iwK3b8RYrF/ruYYhYOqvADIPyoamQi+D6dv5qoSHlSNI9LwzcbLSFpRrzBc2?=
 =?us-ascii?Q?ObhsGK5J5STVwtrWlpDeY6q6Vrab/J15d5DGjha3grxp/xN8jaZdMJVjkRrR?=
 =?us-ascii?Q?+IWk+udhLexhXm3zEwPyCuJz/qG2lmz2R8hTuA8J9aHEFOWqrLLF9lsovcck?=
 =?us-ascii?Q?rim/QzLF8lNBYE6VRQY3dCD1dspSPtxbYSe1FCEenWDU+bjS8/ix8fgMhne3?=
 =?us-ascii?Q?ZuvEQxDCBcl9LtfjFXgKYBHq6OQEO9fY4cJKE0y3HfUbUHvR9UK5q+lSUXPi?=
 =?us-ascii?Q?1/RncgdUoSRbTSGKBEZUEOOzETONVdqf5NMH283OFpbklhWLVTb4RUuh92jw?=
 =?us-ascii?Q?DhuvoaQ4h/8bPhBwJtSi9eJXvL9TZ746ataVw4M5rJ8vKOjHCnkwOvfOHVxe?=
 =?us-ascii?Q?Nn1tnX3ZpLrw7Rw1Q43Ca6JRt9E7bvgDuRVRGO9DbV88yKbOuNQ1fCaL/SXv?=
 =?us-ascii?Q?gSLpFUBEpBtNUekJ9seC3qzaxdF75DkN9thRPTJ3is7yoY2Wx/2AYFaV7mnw?=
 =?us-ascii?Q?aG9TV9NU/UWPualZ6dzplBcsH9/ggX4YbM4Vpcyy8AEt7XL/WSFgbdOkqiDt?=
 =?us-ascii?Q?zORPu06trjqzEuRhlieG1U6DWBwyg9wD35/wgD2rYqvjLUY0n+8QCAtMPoWs?=
 =?us-ascii?Q?o7MJxV1WA0krCE+lAU2F2yGgK4DJ9TBPWoyNW/FcpDtyZBK8UbQm8a7Fd/tp?=
 =?us-ascii?Q?4gJNDdVIwVJcmXT2khQVdzY3ueR2SRxxlzsd7Bd+4jJU9Pz93JWvjIIXzqMQ?=
 =?us-ascii?Q?teo5z6xuDkC9uCBM/VpNpMpXU805lNK5nE8l55gMaOa70DWwmVzC+gtkCXa+?=
 =?us-ascii?Q?/RruxWPXLcSqKFWvPNCl8p5zkkNERHAt+4p9KeVylcarZeyaLS4Jr9K+gENg?=
 =?us-ascii?Q?EAU5OciQzolg1bW6x6rLxUBus1Hyad58XJ3R2za5nutHmQeoaZgcev5zC0aJ?=
 =?us-ascii?Q?e9G5uguE7ato+oG40MS1+rSF9XPp60NY4AQcrHta1YhD/qvOemTeVT5ZVAmx?=
 =?us-ascii?Q?15s=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5026.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(4022899009)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cTeJ1JEBRra0/l1w3gLleivZLuLgUed5jeqQjGwNrESVaVpVO5Nelk085G1H?=
 =?us-ascii?Q?nIIXtof3Ihsir2j054zKYBgk5+WXrNw1IcTkksHDOb/OBi1EKoD22JtiPnF9?=
 =?us-ascii?Q?SWdg1HJl2YxN2X8QnFKMoTGi3iHzURC+TB4zHFRZcBKYR0eRZWYfY0I458yo?=
 =?us-ascii?Q?BQdx3f1x0M07MVyNX9/3wtAYbyi3jq+Lao5WNAovEHopU+UXNFVJ8UcPQ568?=
 =?us-ascii?Q?2MHHOho2vK55YhmkKqPro6AjYzD6vZRXB+wrFra16Ob3umK9Jrsnbf5Zdnxl?=
 =?us-ascii?Q?t0+2m8pvg+imNMlaApGlzKTOicdaL1ynnvQ8IHivx0ZiO44Lca8OZLPFTT+K?=
 =?us-ascii?Q?6Cg0Wh9OkB4hjxv5BC322/G2jKhPXPopum81XeRsYhxntaFksZzfdUdcW1i/?=
 =?us-ascii?Q?LQC8hpgxSMgh41nJl3DoeALUOjYBJM+8YyA0z5745O1nCesudRA1o2XQqe0i?=
 =?us-ascii?Q?0s1uYzv95wgY1B+qtXp4XBYEp148SrrJLAdzElnWMEPSDcmcSML4g4tLKSaO?=
 =?us-ascii?Q?olgR1MIQQcOy1riRtPDy9JCpwB766FyCnnK0ZT+YHPyLDGiINAMINarPSKyY?=
 =?us-ascii?Q?lvxMw8utwrhz8mZY9iR70H+ZaBoaXJG51GpknRXNAm7drn9zoij57G84Rpyo?=
 =?us-ascii?Q?a959/mcVppzJcSqaOb+PgeFGuZPzQWj6rNrO7aBiJWfJ2ayJPw7J8gZtXKGe?=
 =?us-ascii?Q?RLXcSaHdE8C1wtQpzXBiMcdOzq7nagxD3dQLRvUh5k/C9/yedZWCULHIA4q0?=
 =?us-ascii?Q?eP69YMS/OsW5XusOsX5jVxPbbXxswrPGFApIa3nM3NYANAf/Vvb1b6jYnMUb?=
 =?us-ascii?Q?XstIiFPAA1CodU7HCmcxo2U1z6ocQ1VdHppJPN1Xqv/QLn4pgwEhNLVGbycc?=
 =?us-ascii?Q?L4R7OFi2S//0a7hRVZJAV+fwSkoiPb5HS2TffIIGYTF8ebfR64jjwAsCtazV?=
 =?us-ascii?Q?AIOypt6PFuuX6mhE6wnLy1/Jkdka4JGjvx6g+6CbufcdiwvwY8r8tri9w7JG?=
 =?us-ascii?Q?pmLkZW009z6sNbkqrO4/GUgDv3UbK+2hEh3S8zO6B665fQoApas+BljT0ims?=
 =?us-ascii?Q?utUWKquuuS1WeaqSXpb/JvJ50HyZlsGmlZAKBCtEWbsPz4y2wOsVfXmygluG?=
 =?us-ascii?Q?0ox9fRflq06aa5Vw7YujtnKn9hjfc94GC07qR+AsHTkg0fOBQHgWo1Xdmqib?=
 =?us-ascii?Q?EvO6U6wmwPBsbBjMItM4NeLtxEyGDVYq08DQlZXgxZdqY2Vmb4O4+O9Q4ZIK?=
 =?us-ascii?Q?h69tPNiTqXgN0XE1a9u+ju6WEeEuszDxoM/18TTKnS8oyUmK+WFq8y/c+NLF?=
 =?us-ascii?Q?xdMqOfmujanJbTfjiiAIlflvIsylEeWPWgf1Jp+Ug7z5bj22l8LN07DqMHrU?=
 =?us-ascii?Q?hQiKLh4P2HUq0t1CZykEOGIO6IE8loN489acTi1RCmDtyK8TFIgCxD7Aj/OT?=
 =?us-ascii?Q?1lUMe3QvXG8KFyUvL1j2U5B7peTtvf/mRQqK5yL3aRvuX7K7xRvzwNDTmHeK?=
 =?us-ascii?Q?vUkvYnmphFhrY+gYboByMh0n8CAgvbi10kOZJQqHAueYDKcTslJEtKmZ75Os?=
 =?us-ascii?Q?NBKWi4D/ko4njapkPiivcvGWKw9k4RJH49+TmgGZBU6HgJMKBmqDIeUFxF5i?=
 =?us-ascii?Q?eQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5026.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10922215-fd66-4f7f-cf9b-08dcedb547ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 07:36:42.6980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AqVc3kb5S3woQ3ze82IFGp5N6ucsRs3BEQTTgPd+PYc3p6dBDf3o8X+TlkaT8daV6qagkLin7hddop1Ql4OM/r+OFOvYpB6PzPw94NnDF1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6110
X-OriginatorOrg: intel.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Oct 2024 07:36:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/717

Hi Ben Cownley,

With latest zephyr 3.7.0 on meta-zephyr, qemu fails to run hello-world appl=
ication with 'qemu-cortex-m3' and 'qemu-cortex-m0' machines. Would you able=
 to help to fix issues with those arm machines !

runqemu - INFO - Running .. build/tmp/work/x86_64-linux/qemu-helper-native/=
1.0/recipe-sysroot-native/usr/bin/qemu-system-arm -nic none   -icount shift=
=3D6,align=3Doff,sleep=3Doff -rtc clock=3Dvm  -machine lm3s6965evb -cpu cor=
tex-m3  -m 256 -serial mon:stdio -serial null -nographic -nographic -vga no=
ne -kernel  ..build/tmp/deploy/images/qemu-cortex-m3/zephyr-helloworld.elf =
-append '  mem=3D256M swiotlb=3D0 '

runqemu - INFO - Host uptime: 5023.59

*** Booting Zephyr OS build v3.7.0 ***
<< No hello world logs here >>

Regards,
Naveen

> -----Original Message-----
> From: yocto-patches@lists.yoctoproject.org <yocto-
> patches@lists.yoctoproject.org> On Behalf Of Ben Cownley
> Sent: Wednesday, September 25, 2024 5:37 PM
> To: yocto-patches@lists.yoctoproject.org
> Cc: Ben Cownley <ben.cownley@arm.com>
> Subject: [yocto-patches] [meta-zephyr][PATCH 1/2]
> topics/baicow01/zephyr-ARCH-remove: Remove ARCH from meta-zephyr
>=20
> meta-zephyr current passes an ARCH variable to the CMake build It's widel=
y
> believed this is no longer necessary as it is inferred from the BOARD var=
iable
>=20
> Signed-off-by: Ben Cownley <ben.cownley@arm.com>
> ---
>  meta-zephyr-bsp/conf/machine/96b-avenger96.conf                  | 1 -
>  meta-zephyr-bsp/conf/machine/96b-nitrogen.conf                   | 1 -
>  meta-zephyr-bsp/conf/machine/arduino-nano-33-ble.conf            | 1 -
>  meta-zephyr-bsp/conf/machine/frdm-kw41z.conf                     | 1 -
>  meta-zephyr-bsp/conf/machine/intel-x86-64.conf                   | 1 -
>  meta-zephyr-bsp/conf/machine/mps2-an385.conf                     | 1 -
>  meta-zephyr-bsp/conf/machine/mps2-an521.conf                     | 1 -
>  meta-zephyr-bsp/conf/machine/mps3-an547.conf                     | 1 -
>  meta-zephyr-bsp/conf/machine/nrf52840-mdk-usb-dongle.conf        | 1 -
>  meta-zephyr-bsp/conf/machine/nrf52840dk-nrf52840.conf            | 1 -
>  meta-zephyr-bsp/conf/machine/qemu-cortex-a53.conf                | 1 -
>  meta-zephyr-bsp/conf/machine/qemu-cortex-a9.conf                 | 1 -
>  meta-zephyr-bsp/conf/machine/qemu-cortex-m0.conf                 | 1 -
>  meta-zephyr-bsp/conf/machine/qemu-cortex-m3.conf                 | 1 -
>  meta-zephyr-bsp/conf/machine/qemu-cortex-r5.conf                 | 1 -
>  meta-zephyr-bsp/conf/machine/qemu-nios2.conf                     | 1 -
>  meta-zephyr-bsp/conf/machine/qemu-x86.conf                       | 1 -
>  meta-zephyr-bsp/conf/machine/stm32mp157c-dk2.conf                | 1 -
>  meta-zephyr-bsp/conf/machine/v2m-beetle.conf                     | 1 -
>  meta-zephyr-bsp/conf/machine/v2m-musca-b1.conf                   | 1 -
>  meta-zephyr-bsp/conf/machine/v2m-musca-s1.conf                   | 1 -
>  .../recipes-kernel/zephyr-kernel/zephyr-kernel-common.inc        | 1 -
>  22 files changed, 22 deletions(-)
>=20
> diff --git a/meta-zephyr-bsp/conf/machine/96b-avenger96.conf b/meta-
> zephyr-bsp/conf/machine/96b-avenger96.conf
> index ae6f972..5c493b1 100644
> --- a/meta-zephyr-bsp/conf/machine/96b-avenger96.conf
> +++ b/meta-zephyr-bsp/conf/machine/96b-avenger96.conf
> @@ -5,4 +5,3 @@
>=20
>  require conf/machine/include/stm32mp1-cortex-m4.inc
>=20
> -ARCH:96b-avenger96 =3D "arm"
> diff --git a/meta-zephyr-bsp/conf/machine/96b-nitrogen.conf b/meta-
> zephyr-bsp/conf/machine/96b-nitrogen.conf
> index affe9eb..65bdfbf 100644
> --- a/meta-zephyr-bsp/conf/machine/96b-nitrogen.conf
> +++ b/meta-zephyr-bsp/conf/machine/96b-nitrogen.conf
> @@ -5,4 +5,3 @@
>=20
>  require conf/machine/include/nrf52.inc
>  ZEPHYR_INHERIT_CLASSES +=3D "zephyr-flash-pyocd"
> -ARCH:96b-nitrogen =3D "arm"
> diff --git a/meta-zephyr-bsp/conf/machine/arduino-nano-33-ble.conf
> b/meta-zephyr-bsp/conf/machine/arduino-nano-33-ble.conf
> index ebf4155..c6ffa67 100644
> --- a/meta-zephyr-bsp/conf/machine/arduino-nano-33-ble.conf
> +++ b/meta-zephyr-bsp/conf/machine/arduino-nano-33-ble.conf
> @@ -5,5 +5,4 @@
>=20
>  require conf/machine/include/nrf52.inc
>  ZEPHYR_INHERIT_CLASSES +=3D "zephyr-flash-bossac"
> -ARCH:arduino-nano-33-ble =3D "arm"
>=20
> diff --git a/meta-zephyr-bsp/conf/machine/frdm-kw41z.conf b/meta-
> zephyr-bsp/conf/machine/frdm-kw41z.conf
> index 464e83a..46b1e0e 100755
> --- a/meta-zephyr-bsp/conf/machine/frdm-kw41z.conf
> +++ b/meta-zephyr-bsp/conf/machine/frdm-kw41z.conf
> @@ -6,6 +6,5 @@
>=20
>  require conf/machine/include/arm/armv6m/tune-cortexm0plus.inc
>=20
> -ARCH:frdm-kw41z =3D "arm"
>=20
>  DEFAULTUNE ?=3D "cortexm0plus"
> diff --git a/meta-zephyr-bsp/conf/machine/intel-x86-64.conf b/meta-
> zephyr-bsp/conf/machine/intel-x86-64.conf
> index 5112f28..4bda0cd 100644
> --- a/meta-zephyr-bsp/conf/machine/intel-x86-64.conf
> +++ b/meta-zephyr-bsp/conf/machine/intel-x86-64.conf
> @@ -4,7 +4,6 @@
>=20
>  require conf/machine/include/tune-corei7-common.inc
>=20
> -ARCH:intel-x86-64 =3D "x86"
>=20
>  # Supported Boards:
>  # ZEPHYR_BOARD ?=3D "acrn"
> diff --git a/meta-zephyr-bsp/conf/machine/mps2-an385.conf b/meta-
> zephyr-bsp/conf/machine/mps2-an385.conf
> index 159e1bd..bb67972 100644
> --- a/meta-zephyr-bsp/conf/machine/mps2-an385.conf
> +++ b/meta-zephyr-bsp/conf/machine/mps2-an385.conf
> @@ -16,4 +16,3 @@ QB_OPT_APPEND =3D "-icount shift=3D7,align=3Doff,sleep=
=3Doff
> -rtc clock=3Dvm"
>=20
>  # Zephyr RTOS settings
>  ZEPHYR_INHERIT_CLASSES +=3D "zephyr-qemuboot"
> -ARCH:mps2-an385 =3D "arm"
> diff --git a/meta-zephyr-bsp/conf/machine/mps2-an521.conf b/meta-
> zephyr-bsp/conf/machine/mps2-an521.conf
> index acd02be..fb763ea 100644
> --- a/meta-zephyr-bsp/conf/machine/mps2-an521.conf
> +++ b/meta-zephyr-bsp/conf/machine/mps2-an521.conf
> @@ -18,4 +18,3 @@ QB_OPT_APPEND =3D "-icount shift=3D7,align=3Doff,sleep=
=3Doff
> -rtc clock=3Dvm"
>=20
>  # Zephyr RTOS settings
>  ZEPHYR_INHERIT_CLASSES +=3D "zephyr-qemuboot"
> -ARCH:mps2-an521 =3D "arm"
> diff --git a/meta-zephyr-bsp/conf/machine/mps3-an547.conf b/meta-
> zephyr-bsp/conf/machine/mps3-an547.conf
> index 185c425..c3ebd2c 100644
> --- a/meta-zephyr-bsp/conf/machine/mps3-an547.conf
> +++ b/meta-zephyr-bsp/conf/machine/mps3-an547.conf
> @@ -17,4 +17,3 @@ QB_OPT_APPEND =3D "-icount shift=3D7,align=3Doff,sleep=
=3Doff
> -rtc clock=3Dvm"
>=20
>  # Zephyr RTOS settings
>  ZEPHYR_INHERIT_CLASSES +=3D "zephyr-qemuboot"
> -ARCH:mps3-an547 =3D "arm"
> diff --git a/meta-zephyr-bsp/conf/machine/nrf52840-mdk-usb-dongle.conf
> b/meta-zephyr-bsp/conf/machine/nrf52840-mdk-usb-dongle.conf
> index 67e407a..448f1ed 100644
> --- a/meta-zephyr-bsp/conf/machine/nrf52840-mdk-usb-dongle.conf
> +++ b/meta-zephyr-bsp/conf/machine/nrf52840-mdk-usb-dongle.conf
> @@ -4,4 +4,3 @@
>  #@DESCRIPTION: Machine configuration for makerdiary's nrf52840-mdk-
> usb-dongle
>=20
>  require conf/machine/include/nrf52.inc
> -ARCH:nrf52840-mdk-usb-dongle =3D "arm"
> diff --git a/meta-zephyr-bsp/conf/machine/nrf52840dk-nrf52840.conf
> b/meta-zephyr-bsp/conf/machine/nrf52840dk-nrf52840.conf
> index 258aa7a..bd99878 100644
> --- a/meta-zephyr-bsp/conf/machine/nrf52840dk-nrf52840.conf
> +++ b/meta-zephyr-bsp/conf/machine/nrf52840dk-nrf52840.conf
> @@ -5,4 +5,3 @@
>=20
>  require conf/machine/include/nrf52.inc
>  ZEPHYR_INHERIT_CLASSES +=3D "zephyr-flash-pyocd"
> -ARCH:nrf52840dk-nrf52840 =3D "arm"
> diff --git a/meta-zephyr-bsp/conf/machine/qemu-cortex-a53.conf b/meta-
> zephyr-bsp/conf/machine/qemu-cortex-a53.conf
> index e21f3da..4a511f9 100644
> --- a/meta-zephyr-bsp/conf/machine/qemu-cortex-a53.conf
> +++ b/meta-zephyr-bsp/conf/machine/qemu-cortex-a53.conf
> @@ -17,4 +17,3 @@ QB_OPT_APPEND =3D "-icount shift=3D4,align=3Doff,sleep=
=3Don
> -rtc clock=3Dvm"
>  # Zephyr RTOS settings
>  ZEPHYR_BOARD =3D "qemu_cortex_a53"
>  ZEPHYR_INHERIT_CLASSES +=3D "zephyr-qemuboot"
> -ARCH:qemu-cortex-a53 =3D "aarch64"
> diff --git a/meta-zephyr-bsp/conf/machine/qemu-cortex-a9.conf b/meta-
> zephyr-bsp/conf/machine/qemu-cortex-a9.conf
> index 9dfee42..4ce6e56 100644
> --- a/meta-zephyr-bsp/conf/machine/qemu-cortex-a9.conf
> +++ b/meta-zephyr-bsp/conf/machine/qemu-cortex-a9.conf
> @@ -17,4 +17,3 @@ QB_OPT_APPEND =3D "-icount shift=3D3,align=3Doff,sleep=
=3Doff
> -rtc clock=3Dvm"
>=20
>  # Zephyr RTOS settings
>  ZEPHYR_INHERIT_CLASSES +=3D "zephyr-qemuboot"
> -ARCH:qemu-cortex-a9 =3D "arm"
> diff --git a/meta-zephyr-bsp/conf/machine/qemu-cortex-m0.conf b/meta-
> zephyr-bsp/conf/machine/qemu-cortex-m0.conf
> index 736579e..9a01efd 100644
> --- a/meta-zephyr-bsp/conf/machine/qemu-cortex-m0.conf
> +++ b/meta-zephyr-bsp/conf/machine/qemu-cortex-m0.conf
> @@ -21,4 +21,3 @@ QB_OPT_APPEND =3D "-icount shift=3D6,align=3Doff,sleep=
=3Doff
> -rtc clock=3Dvm"
>  # Zephyr RTOS settings
>  ZEPHYR_BOARD =3D "qemu_cortex_m0"
>  ZEPHYR_INHERIT_CLASSES +=3D "zephyr-qemuboot"
> -ARCH:qemu-cortex-m0 =3D "arm"
> diff --git a/meta-zephyr-bsp/conf/machine/qemu-cortex-m3.conf b/meta-
> zephyr-bsp/conf/machine/qemu-cortex-m3.conf
> index 904a79b..2314dc5 100644
> --- a/meta-zephyr-bsp/conf/machine/qemu-cortex-m3.conf
> +++ b/meta-zephyr-bsp/conf/machine/qemu-cortex-m3.conf
> @@ -15,4 +15,3 @@ QB_CPU =3D "-cpu cortex-m3"
>  QB_RNG =3D ""
>  QB_OPT_APPEND =3D "-icount shift=3D6,align=3Doff,sleep=3Doff -rtc clock=
=3Dvm"
>=20
> -ARCH:qemu-cortex-m3 =3D "arm"
> diff --git a/meta-zephyr-bsp/conf/machine/qemu-cortex-r5.conf b/meta-
> zephyr-bsp/conf/machine/qemu-cortex-r5.conf
> index 5a0ea69..e85a42c 100644
> --- a/meta-zephyr-bsp/conf/machine/qemu-cortex-r5.conf
> +++ b/meta-zephyr-bsp/conf/machine/qemu-cortex-r5.conf
> @@ -19,4 +19,3 @@ QB_RNG =3D ""
>  # Zephyr RTOS settings
>  ZEPHYR_BOARD =3D "qemu_cortex_r5"
>  ZEPHYR_INHERIT_CLASSES +=3D "zephyr-qemuboot"
> -ARCH:qemu-cortex-r5 =3D "arm"
> diff --git a/meta-zephyr-bsp/conf/machine/qemu-nios2.conf b/meta-
> zephyr-bsp/conf/machine/qemu-nios2.conf
> index c41f505..e9420b5 100644
> --- a/meta-zephyr-bsp/conf/machine/qemu-nios2.conf
> +++ b/meta-zephyr-bsp/conf/machine/qemu-nios2.conf
> @@ -13,6 +13,5 @@ QB_MACHINE =3D "-machine altera_10m50_zephyr"
>  QB_OPT_APPEND =3D "-nographic"
>  QB_CPU =3D "-cpu nios2"
>=20
> -ARCH:qemu-nios2 =3D "nios2"
>=20
>  TCLIBC =3D "glibc"
> diff --git a/meta-zephyr-bsp/conf/machine/qemu-x86.conf b/meta-zephyr-
> bsp/conf/machine/qemu-x86.conf
> index d21de35..3535a4c 100644
> --- a/meta-zephyr-bsp/conf/machine/qemu-x86.conf
> +++ b/meta-zephyr-bsp/conf/machine/qemu-x86.conf
> @@ -14,4 +14,3 @@ QB_GRAPHICS =3D "-nographic -no-acpi"
>  QB_CPU:x86 =3D "-cpu qemu32,+nx,+pae"
>  QB_CPU_KVM:x86 =3D "-cpu kvm32"
>=20
> -ARCH:qemu-x86 =3D "x86"
> diff --git a/meta-zephyr-bsp/conf/machine/stm32mp157c-dk2.conf b/meta-
> zephyr-bsp/conf/machine/stm32mp157c-dk2.conf
> index 52c1819..c81b30e 100644
> --- a/meta-zephyr-bsp/conf/machine/stm32mp157c-dk2.conf
> +++ b/meta-zephyr-bsp/conf/machine/stm32mp157c-dk2.conf
> @@ -5,4 +5,3 @@
>=20
>  require conf/machine/include/stm32mp1-cortex-m4.inc
>=20
> -ARCH:stm32mp157c-dk2 =3D "arm"
> diff --git a/meta-zephyr-bsp/conf/machine/v2m-beetle.conf b/meta-
> zephyr-bsp/conf/machine/v2m-beetle.conf
> index 37895c6..4065496 100644
> --- a/meta-zephyr-bsp/conf/machine/v2m-beetle.conf
> +++ b/meta-zephyr-bsp/conf/machine/v2m-beetle.conf
> @@ -9,4 +9,3 @@ require conf/machine/include/arm/armv7m/tune-
> cortexm3.inc
>  # GLIBC will not work with Cortex-M.
>  TCLIBC =3D "newlib"
>=20
> -ARCH:beetle =3D "arm"
> diff --git a/meta-zephyr-bsp/conf/machine/v2m-musca-b1.conf b/meta-
> zephyr-bsp/conf/machine/v2m-musca-b1.conf
> index 171e899..af5ae5e 100644
> --- a/meta-zephyr-bsp/conf/machine/v2m-musca-b1.conf
> +++ b/meta-zephyr-bsp/conf/machine/v2m-musca-b1.conf
> @@ -22,4 +22,3 @@ QB_MEM =3D "512k"
>  # Zephyr RTOS settings
>  ZEPHYR_BOARD =3D "v2m_musca_b1"
>  ZEPHYR_INHERIT_CLASSES +=3D "zephyr-qemuboot"
> -ARCH:musca-b1 =3D "arm"
> diff --git a/meta-zephyr-bsp/conf/machine/v2m-musca-s1.conf b/meta-
> zephyr-bsp/conf/machine/v2m-musca-s1.conf
> index c43d560..be7a42b 100644
> --- a/meta-zephyr-bsp/conf/machine/v2m-musca-s1.conf
> +++ b/meta-zephyr-bsp/conf/machine/v2m-musca-s1.conf
> @@ -20,4 +20,3 @@ QB_MEM =3D "512k"
>=20
>  # Zephyr RTOS settings
>  ZEPHYR_INHERIT_CLASSES +=3D "zephyr-qemuboot"
> -ARCH:musca-s1 =3D "arm"
> diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-
> common.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-
> kernel-common.inc
> index 8a1638d..6544475 100644
> --- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-
> common.inc
> +++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-
> common
> +++ .inc
> @@ -19,7 +19,6 @@ ZEPHYR_MAKE_OUTPUT ?=3D "\  EXTRA_OECMAKE =3D "\
>      -DZEPHYR_BASE=3D${ZEPHYR_BASE} \
>      -DBOARD=3D${BOARD} \
> -    -DARCH=3D${ARCH} \
>      -DZEPHYR_TOOLCHAIN_VARIANT=3D${ZEPHYR_TOOLCHAIN_VARIANT} \
>      -DZEPHYR_MODULES=3D${ZEPHYR_MODULES} \
>      "
> --
> 2.34.1
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D
> Links: You receive all messages sent to this group.
> View/Reply Online (#671): https://lists.yoctoproject.org/g/yocto-
> patches/message/671
> Mute This Topic: https://lists.yoctoproject.org/mt/108644928/2015869
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-
> patches/leave/13182003/2015869/177849857/xyzzy
> [naveen.kumar.saini@intel.com]
> -=3D-=3D-=3D-=3D-=3D-=3D
>=20


