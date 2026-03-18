Return-Path: <chee.yang.lee@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE6AFCD0DA
	for <webhook@archiver.kernel.org>; Wed, 18 Mar 2026 08:45:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9395.1773823543197213355
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Mar 2026 01:45:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intel.com header.s=Intel header.b=gfbTeWpu;
 spf=pass (domain: intel.com, ip: 192.198.163.10, mailfrom: chee.yang.lee@intel.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773823543; x=1805359543;
  h=from:to:subject:date:message-id:references:in-reply-to:
   mime-version;
  bh=VqAo+WQeFDZdMTYdQogSrm/Kxgn4FT9aX5iHaVR8Rfs=;
  b=gfbTeWpuQPWKeZG3N+wjaArlYWJi09TrZtZDPKAavxUY3nJXdkQfwMMG
   N2zdN5j09LcLw8LUdAlrW3bejxsvL6uZcn5Wv/FcRvXXj0TnNuL5izvCk
   Y73SYsTuxyxAx508tSIVlK6bfAGgRqixzSruD4yb7nabMJY6laaxtPVk+
   rTn2+G+y3JXersSNgPsDcKAzQni9npz3Lm+SxWkPuvHcQHVmVk73ArS5C
   1yN9je5vFMycKIZ1TZ/ikUglUzEYQPf0D7b/sZmx0aWm9Pht7IUGxuCAY
   Vh3D5qbIxQOgY6C4dgqwchDRIxU3+AYrtX8dJnKuhEVK31P4No+3RzuB9
   Q==;
X-CSE-ConnectionGUID: ypu+W/0FQcSmJ/zPPkzG2w==
X-CSE-MsgGUID: e3ztDkC7Sqa9TRF6WkoZrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="86229713"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208,217";a="86229713"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 01:45:43 -0700
X-CSE-ConnectionGUID: TLd7I+aYQSmy7MHBt1l7MQ==
X-CSE-MsgGUID: dHRUz0qXTQivc4l7ZG8yug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208,217";a="227022934"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 01:45:42 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 01:45:41 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 01:45:41 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.10) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 01:45:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtGXu85G08rISp6HLVvJTm+SXarZ27mf3V40IVxAqvh/jhhC0hJ8waYSOa8MwR92+S5xSjuaGD9xCjBQsiP9Ypf9TzsVB0uygS+qGCwkWTnagwQcP4oSt0xUKbjld1qm67NPyZ699JFgWpV9/pJ+YDW0mkfsh2u0FRZdlT4xt4t+9V5jlRnPAiuEM9/swBI0e/MhcZELXkbI+U+jP5od/z5wVOw1TU5gwgk7Pg5G0rwD+gtF7cpIVRc0ApbCv0n9dIsUCr9QW+aUnVCQhrvILfsvJTwSNopUk6bahgwP4GNB7OLH/E8ULzqetFu0Y9pkwPluveUgaq+3hXGuJUY7jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tHWuZAps2JDaNdtdPsJRUU6coVN5pMKHuu81CaiJQE=;
 b=eC2YcHmnQSC9Ix8PGqPkIyEK4SisablRIN1MS8S2z/S3htdITKk2mwMzxfp47LwYBq3BiVYwn4n6JwXIsNUzc7VzPS0cQ8zGW+FzTNoBurt9UKT2BI6dxoag2moEuLspZMabmQq94gjECmLyu8xBe9IvSOz+o8uyuJ2eA0kNcV/3+PPNvoI5CeoWazHdr0nrde44DKojK1IKNsmICXGhvlIgVHBXQKxJd63/TBo0kxgMJCesc5WF4khlXWTiGWaGJAVJLn8yNhEOn9a9qEJrblwJkJbN5qwaDRTFBbNM4xvA+wpIKcWURrUbtFSUh/N98SCWlHWtvYV/8FZ26V/hTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL4PR11MB8797.namprd11.prod.outlook.com (2603:10b6:208:5a7::8)
 by DS0PR11MB7441.namprd11.prod.outlook.com (2603:10b6:8:141::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.10; Wed, 18 Mar
 2026 08:45:38 +0000
Received: from BL4PR11MB8797.namprd11.prod.outlook.com
 ([fe80::fe4:8775:47fa:b7d9]) by BL4PR11MB8797.namprd11.prod.outlook.com
 ([fe80::fe4:8775:47fa:b7d9%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 08:45:37 +0000
From: "Lee, Chee Yang" <chee.yang.lee@intel.com>
To: "Gundlupet Raju, Sandeep" <sandeep.gundlupet-raju@amd.com>,
	"yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Subject: Re: [yocto-patches][meta-zephyr][scarthgap][PATCH] layer: Fix
 PREFERRED_VERSION for zephyr-sdk-native
Thread-Topic: [yocto-patches][meta-zephyr][scarthgap][PATCH] layer: Fix
 PREFERRED_VERSION for zephyr-sdk-native
Thread-Index: AQHctnNsqCszKTS0kkaxV74QJ5KydLWz+IsQ
Date: Wed, 18 Mar 2026 08:45:37 +0000
Message-ID: <BL4PR11MB87979B27CDFC08572AABD5CDB94EA@BL4PR11MB8797.namprd11.prod.outlook.com>
References: <189A5C41295DB830.2162755@lists.yoctoproject.org>
 <d23273ec-a148-409a-aea6-c0bd544836d8@amd.com>
In-Reply-To: <d23273ec-a148-409a-aea6-c0bd544836d8@amd.com>
Accept-Language: en-SG, en-US
Content-Language: en-SG
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR11MB8797:EE_|DS0PR11MB7441:EE_
x-ms-office365-filtering-correlation-id: 995c4c58-a043-4d0d-7548-08de84caba6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003|38070700021|7053199007|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: gSmPd6at+g1dW0b7VsHD1dHjuTLtl2cHyPk1m6CDeLw3DG/1Gm/+kj6eTewHHDkwMgT5ChZBHfGse7n5k2G3fAGBOmXDVlUTrOUwD7okRJx3ExXu1zEoXuq5sjf8y+vKFd40Z7Vg+MHxqwtJ3r9wsshQmRYZOdATZtfJEZGJN5oAwfm8dy7ALGQNJ13Rq3mG/UUHH0ixf81myoyN/KGJePLQ+KJcPNkS6CU4qBMP2SxHvNs6cP6easR83mDFd3anYFOFUKhGUE0QyWcDS/HKrpyw3nkCcFiYGUsNjG6EUIXCZMH2tjgsnQLYnOkGMbFy5wh86pwvwGm8S0jA93bfWTcU7IJxu2NOjxMmPopXDiUBg15Xwn5+XQltrnshN9xhOaxWjt7ReDyl/jokuUn7cC7PUlMB+bVR0C6XFLTbwXEAYArTeMUjw1DpWVxm4lXwcN0L1l57ZRByoVvNyOsXgUK2wDR/k76Z4YJeyJC5KdFXwwnzwjQycUSVHPRtHlqqI0gNvBbYR/l17T9kwQXUV46g6LsJ9Cs7ax1tr5YXUSb/DCsU+UAxf7EpdxdKBxjsuQjLbv8qyxp8h7vKRMNnb8kPIn6Vqvv13KOCEmGciownnUmocnI028rA3NysL4nACTkEZZk0ftjJLgLQgkzsDoTMnF9GEO84jV3HIrjeA/okgsG8c29+WcdiNid6skLlfoR5SJEmtN2lE38sDDqsPTQ1xcqFQq8Rlzijs0uFWbXLVLLC757FHnuh+F8vmcQNh9tXLe0nPTCeUZ/RZSm6UQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR11MB8797.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(38070700021)(7053199007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MEKCuIc4ze+8viMf+WxhsIrUu3N7x8n0muF9vAhrd7qpx6fOsdflIEOJ52p9?=
 =?us-ascii?Q?BO4wW46mD5JP34Mra/J6HyVuuiAKltVdens1WQlFutSVnTMrLzFFji0teCXg?=
 =?us-ascii?Q?yVzLjhAgVcvgYa02Z3fImZUtSPyKqzs0m60QtnG2Xq1ZzzDG1/ZaiIUUq11R?=
 =?us-ascii?Q?jGFO0Qp13o0HMh7Ky+nM6kSjXFx9+zPPXv4rh0hh/Fxk4QfEbavhXnovcGzv?=
 =?us-ascii?Q?J7X6qrUwDOoBmdyJmEAZLw/9iMNsfXjIJGMlHDdwQ4cm4sZUVNA6n5IB/tsr?=
 =?us-ascii?Q?hPZ52etcx5+zljzs0oubwy+NDNe+qNdtwj4U866BqezDkns5ZWRyjUjn8OFs?=
 =?us-ascii?Q?b6ujR6kt5sBGJWv1nh+lx/oEUF2rW31PklxDks9lxo34z1c94uQ/HUzUcbdm?=
 =?us-ascii?Q?pnbIYxqaZZXLFf8ycPbMguU5HF4j9bibXbtLay9CYkZq2Wsd+4dtnxCxaRmV?=
 =?us-ascii?Q?WwnswjqnsgO+5guJPG0fElHuPCJEFiv/4wURg+GnLsYgPh70JeAkKl+3fAhc?=
 =?us-ascii?Q?Wal59uTb+030IqPM16HkE4vTlBvi2FK40e0hVEeimt1EIS6BYeQGWM4Wnx21?=
 =?us-ascii?Q?Kg4EepmRj8Ty9qQT6C+f11i9Qe6jKPuN1g8coniO6t8upU+zJ/NGf8RQefaq?=
 =?us-ascii?Q?mu+x3pBDTzZX9+SLHDr1gcGHP9e6yCMNjV8Q9lv+7tUu8ANhjPSlfsp/HD0S?=
 =?us-ascii?Q?2sGV8xUcgs03MqX02onRD2938z8LEPgh6GMAViciikt85bH9yzrQQila+/wU?=
 =?us-ascii?Q?F/Yen5i3ecYGkIDRgJ8P4ricPk3OdrYFBFDsuHfpXNUMntUM8p85g8Z0Zx2W?=
 =?us-ascii?Q?ESU13r+6rMNS1H5cDc6hCI2bFpJw5PpuBbi5vFz3lRrje2tRfnRc2ZWA3ixv?=
 =?us-ascii?Q?klUQqjW0k5QmupJfK729SHwsBACroS72YZrDFCvqEx1LfwOnejmiLWNAiNjb?=
 =?us-ascii?Q?GZSqos8qc0tAjwVHAJTkXc9eZxmOv3+e3NcpTqUgsF4jyPMJhoNzjgOUlb/B?=
 =?us-ascii?Q?x+oOhMZHuG6k62U8RVNXklw2HNSgy2lT1UefhLgiDWyUyde+DCaDODtHsBQ9?=
 =?us-ascii?Q?ImjQLj3xvp4mLFuzdr65QpupVovdeKNwnVGXjRCBX7a9c6wQVPF6mDINpwMn?=
 =?us-ascii?Q?EaQMV7ItCzvmTOtAS/utLfKtdvVrWW6saiGncqGmrihzdBptNVdLA7PBEgAm?=
 =?us-ascii?Q?2p+1jMfhBsB+wrudWN1QOQ43zj+ALsVzgeQz5+88CyEjiu0aCw41/13KqSOH?=
 =?us-ascii?Q?m2iz9d5648dgH/HbzFAJqPFx1/bJquhIZO6M4FePtZzok9j/X2/GwO3rbcR7?=
 =?us-ascii?Q?CiuFXzIVYscHJ8NAwItFJcRywrR37kusH06CZPVzMPG3XkcAHjD7al6/FfPT?=
 =?us-ascii?Q?K65bKTXxiBH0wajhtBOdZYIwLGrBdtmGXrEhS2+13d7xZwi+xJ8XybrFvMSx?=
 =?us-ascii?Q?36sDxuYaAjdZnqKNSuWMykD6378vK+8my8ZZAhsJEIiXcBiXYEIU/375O2UX?=
 =?us-ascii?Q?tS8uGbCV4HQV2RBILqrFY0MsOjIVEdPtgsxxpVDvcfGkFz+AGMBjq+OB9UMy?=
 =?us-ascii?Q?qHu2B8cKZLPKEmlKUZ0gtMSQ5Bt0h/8rmD8s4go+evLJJOEEYmGmBDvlrCGy?=
 =?us-ascii?Q?+HkVbx+BhfFG4Za4uCUsLkg2vNUqFiBHvPGl4o3fdz6TKXWkS3dh5jKCAbEm?=
 =?us-ascii?Q?nC2v5q4/hZ+OjAZpGEAdFVzYZvwdrPAtgVEKVoO3L5ncWDoDJUnVl5BLfbhC?=
 =?us-ascii?Q?wlL6rU2xcg=3D=3D?=
Content-Type: multipart/alternative;
	boundary="_000_BL4PR11MB87979B27CDFC08572AABD5CDB94EABL4PR11MB8797namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YwFSdpIGu0XFKVwieyCvrh5rjEkKJ8eMxvLq5US/IVQRt4BDgcktMbUh51DhnEa8D9qpoJqcXAfjb9p0OSNByJFrfnFIfaPO9dSzJKCvijc44PmWKjtk8JDuUp9aYxUfpSjA7w8gL66Ir1nRO0DyqVSJjmLFcdL1Zvm/QrCCfQAHieE/TDKR9XdcZto5/yNgErSXS550Eo1gzZ+NTjmVMlrp300LLtU1EuAvqZw0I4qEa/YmF2kDeiiuU6z7MBpTkQRUSk3grbthl2XYkRoEbfvYPcdT9CODobQDqdiC6YrntuINKhU0YmNw8oWzKzoSMMvfJy3+kWSJMWSF9+/sqA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL4PR11MB8797.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995c4c58-a043-4d0d-7548-08de84caba6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 08:45:37.8178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /6+DZGVv9CTlM7NxhxXDAr0yvIbOY92gdN3VP8as6sZqMdktfJYwrtnRnAXd0EU6k28uR3FEUpgc1ox2VBBC/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7441
X-OriginatorOrg: intel.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Mar 2026 08:45:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3506

--_000_BL4PR11MB87979B27CDFC08572AABD5CDB94EABL4PR11MB8797namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Merged , Thanks for the reminder.
________________________________
From: Gundlupet Raju, Sandeep <sandeep.gundlupet-raju@amd.com>
Sent: Wednesday, 18 March 2026 9:05 am
To: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproject.=
org>
Cc: Lee, Chee Yang <chee.yang.lee@intel.com>
Subject: Re: [yocto-patches][meta-zephyr][scarthgap][PATCH] layer: Fix PREF=
ERRED_VERSION for zephyr-sdk-native

Hi Chee Yang,

Can you merge this patch for scarthgap ?

Thanks,
Sandeep

On 3/6/2026 2:00 PM, Sandeep Gundlupet Raju via lists.yoctoproject.org
wrote:
> zephyr-sdk is a native recipe, So fix PREFERRED_VERSION for
> zephyr-sdk-native.
>
> Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
> ---
>   meta-zephyr-core/conf/layer.conf | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/meta-zephyr-core/conf/layer.conf b/meta-zephyr-core/conf/lay=
er.conf
> index e355b3f..a01657a 100644
> --- a/meta-zephyr-core/conf/layer.conf
> +++ b/meta-zephyr-core/conf/layer.conf
> @@ -23,4 +23,4 @@ addpylib ${LAYERDIR}/lib oeqa
>
>   # Default to a stable version
>   PREFERRED_VERSION_zephyr-kernel ??=3D "3.6.0"
> -PREFERRED_VERSION_zephyr-sdk ??=3D "0.16.9"
> +PREFERRED_VERSION_zephyr-sdk-native ??=3D "0.16.9"

--_000_BL4PR11MB87979B27CDFC08572AABD5CDB94EABL4PR11MB8797namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Merged , Thanks for the reminder.</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Gundlupet Raju, Sande=
ep &lt;sandeep.gundlupet-raju@amd.com&gt;<br>
<b>Sent:</b> Wednesday, 18 March 2026 9:05 am<br>
<b>To:</b> yocto-patches@lists.yoctoproject.org &lt;yocto-patches@lists.yoc=
toproject.org&gt;<br>
<b>Cc:</b> Lee, Chee Yang &lt;chee.yang.lee@intel.com&gt;<br>
<b>Subject:</b> Re: [yocto-patches][meta-zephyr][scarthgap][PATCH] layer: F=
ix PREFERRED_VERSION for zephyr-sdk-native</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Chee Yang,<br>
<br>
Can you merge this patch for scarthgap ?<br>
<br>
Thanks,<br>
Sandeep<br>
<br>
On 3/6/2026 2:00 PM, Sandeep Gundlupet Raju via lists.yoctoproject.org <br>
wrote:<br>
&gt; zephyr-sdk is a native recipe, So fix PREFERRED_VERSION for<br>
&gt; zephyr-sdk-native.<br>
&gt;<br>
&gt; Signed-off-by: Sandeep Gundlupet Raju &lt;sandeep.gundlupet-raju@amd.c=
om&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; meta-zephyr-core/conf/layer.conf | 2 +-<br>
&gt;&nbsp;&nbsp; 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/meta-zephyr-core/conf/layer.conf b/meta-zephyr-core/conf/=
layer.conf<br>
&gt; index e355b3f..a01657a 100644<br>
&gt; --- a/meta-zephyr-core/conf/layer.conf<br>
&gt; +++ b/meta-zephyr-core/conf/layer.conf<br>
&gt; @@ -23,4 +23,4 @@ addpylib ${LAYERDIR}/lib oeqa<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; # Default to a stable version<br>
&gt;&nbsp;&nbsp; PREFERRED_VERSION_zephyr-kernel ??=3D &quot;3.6.0&quot;<br=
>
&gt; -PREFERRED_VERSION_zephyr-sdk ??=3D &quot;0.16.9&quot;<br>
&gt; +PREFERRED_VERSION_zephyr-sdk-native ??=3D &quot;0.16.9&quot;<br>
</div>
</span></font></div>
</body>
</html>

--_000_BL4PR11MB87979B27CDFC08572AABD5CDB94EABL4PR11MB8797namp_--

