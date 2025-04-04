Return-Path: <Nicholas.Lowell@lexmark.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECE8C3601E
	for <webhook@archiver.kernel.org>; Fri,  4 Apr 2025 19:09:45 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.51])
 by mx.groups.io with SMTP id smtpd.web11.5321.1743793779232578356
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 04 Apr 2025 12:09:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@Lexmark.com header.s=selector1 header.b=BfsK50jw;
 spf=pass (domain: lexmark.com, ip: 40.107.244.51, mailfrom: nicholas.lowell@lexmark.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DVpM7DiLpTGHRexj7T+a3ZbK8UctAqaIS2ZXEvr2T8gJ9+6ZPA41jkuUNpAXjehaXEFjAUbpZU7QkUp76F601Ifs9eFYU2pZIhtOdekI66OU93UoEjK0r5QphnkjVWRkbKiZ6zz+UGoylK76n0z+pMGrd+ju7x7RhOwR6ObyAHIKP1RDq0AnjB5Zk3PIU43WAO6SRbJ+vGOTBnK00i6oWVdwkt/86EvWSHSV0Iv4ra/iIc8mp9E9B5a3wrY0ftN6N0DG09VimePvzmkWRKySch8Z83h2JP148IMTcj6SHvmcRvJs77u+BkbRh4O6YLOy7d6+M6rCndK/lMoX5aELnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53XtoehhM7cY5VjKr4ShV/qM9sBbkKaUPGY3LvCyKMw=;
 b=llyIDncDlkLiSrU+W/sfZDZyueJIOcGV3tx7F5AN8IV4/2Q4VBks1gTK0VcqbrucbxVW8WHTzIDR3kE5QFbB6zED2FbKlEqi09yFy3h8hl4GqJETT6Qm6zTQa6ED1LWlY+tTRYZG1LMrUXVlTTnzgq87Pvnq0wlZHcQFc0EMzHHbs/fSrx4hASSqa9H3eeYIt9/XnaeCfEbpYvs1WtkSMjJ/Dvi1d8U3tELF7DiDbLUBqdny2s54iraz3OmcZ0RAmQM10mIic6+QmX1H+Ng4dpo2UXCr+SKEd0jEa6k7QwpF0rSTbJGL7QfyFUSTud9NYrDz/jdX31vP4zOSndEOKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lexmark.com; dmarc=pass action=none header.from=lexmark.com;
 dkim=pass header.d=lexmark.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Lexmark.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53XtoehhM7cY5VjKr4ShV/qM9sBbkKaUPGY3LvCyKMw=;
 b=BfsK50jwYkiCpCwB+JhPrltw2WE4vgewIGtFdINmIVoEKE2JJgJ8LCTMPCY8e49d0HFwf3c47UG8hjjC2TlOiYC55NszMIzzTvHomi52PTJuCJPQfdVbD+RP3lS1z86aCHanybOvEFFmS2LnsFC1GvGd/BzhgzxwZHkuu4NAw16/QlqNzuYHWxPr5Ch51LtR8SUOMFXC/sxz7oLo42SuyjQPvTVwhcRwuj8wqWoxCjSjbtyCrojA+nN6keyP3k1BsDIRpf98VjLlKKmHjotkdGk4Sp7SR8Tqk4JalXE2R9CyFUG0rwGLd4ndhI58EGJ61/ROQc3D1c03ic0Hbm3F+g==
Received: from PH0PR10MB7007.namprd10.prod.outlook.com (2603:10b6:510:282::11)
 by CH0PR10MB5084.namprd10.prod.outlook.com (2603:10b6:610:dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Fri, 4 Apr
 2025 19:09:33 +0000
Received: from PH0PR10MB7007.namprd10.prod.outlook.com
 ([fe80::260:37b5:f3da:7be1]) by PH0PR10MB7007.namprd10.prod.outlook.com
 ([fe80::260:37b5:f3da:7be1%6]) with mapi id 15.20.8583.041; Fri, 4 Apr 2025
 19:09:33 +0000
From: Nicholas Lowell <nicholas.lowell@lexmark.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: [meta-zephyr][PATCH] zephyr-core/zephyr-kernel: specify newlib
 capability with cross-compile toolchain
Thread-Topic: [meta-zephyr][PATCH] zephyr-core/zephyr-kernel: specify newlib
 capability with cross-compile toolchain
Thread-Index: AdullQKnivSUs38QRNuZK8mTAhECmw==
Date: Fri, 4 Apr 2025 19:09:33 +0000
Message-ID: 
 <PH0PR10MB700766691D9D809FDAB3B7BEF3A92@PH0PR10MB7007.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_952b670f-6bee-4e6c-994d-cb4c4ab4436c_ActionId=01ac29c7-8246-4f84-bebd-6444a7abfbe1;MSIP_Label_952b670f-6bee-4e6c-994d-cb4c4ab4436c_ContentBits=0;MSIP_Label_952b670f-6bee-4e6c-994d-cb4c4ab4436c_Enabled=true;MSIP_Label_952b670f-6bee-4e6c-994d-cb4c4ab4436c_Method=Standard;MSIP_Label_952b670f-6bee-4e6c-994d-cb4c4ab4436c_Name=Lexmark
 Confidential;MSIP_Label_952b670f-6bee-4e6c-994d-cb4c4ab4436c_SetDate=2025-04-04T19:08:03Z;MSIP_Label_952b670f-6bee-4e6c-994d-cb4c4ab4436c_SiteId=12709065-6e6c-41c9-9e4d-fb0a436969ce;MSIP_Label_952b670f-6bee-4e6c-994d-cb4c4ab4436c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lexmark.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB7007:EE_|CH0PR10MB5084:EE_
x-ms-office365-filtering-correlation-id: feac425e-28e5-4778-fb35-08dd73ac3c13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?JMteqP9ok346xxiNo9WYPLPHCMTk93DUsYKOQXWto3TxfnzPKetcxvrgWkiW?=
 =?us-ascii?Q?oKFHJznVU5xC4ruyybN7qij2H1xrrPAAPAYNNqzO/7oUQ3zcd1+zu3VmKXHi?=
 =?us-ascii?Q?KtHtmD9UjnRrR7ULITkdwdcGqd1JYcLS5M1UXNJQA4K+5wg3iSeNuCYib0Kn?=
 =?us-ascii?Q?vyWc1CZDC/eeZ/j+A4dJVE3AenHVc/DsD4FucI95ivpxzruUQBPOs7RR+5bf?=
 =?us-ascii?Q?7wVRnuePv1WhOjK60FDhoreBSp608F3fcs/1nw7tE1CUrzyzBEnnz28Z94nF?=
 =?us-ascii?Q?J2h7OfevanKK3HUuzuehi/3TBeGdWmVfTsaYeYrpZYvuIzrKi+hLSXqQPlY3?=
 =?us-ascii?Q?UJW97Om244+bUtLjLeGYyYs3WPjJ9rPZcA7KeLFQbaIHXasJHS5IeqtBcIxV?=
 =?us-ascii?Q?Pq5k4XpHCqjXbyqvi0370ZNeULm/m3O3IWoFTKp0eJUXbj8lN3GBYFn2ybKf?=
 =?us-ascii?Q?04rfCDxXrqL4WPv0jtZ8nPe8j76FOEem7F9yiDDHUOhvTWxiR5XD7gMqjWne?=
 =?us-ascii?Q?Hs0Ji8knW8VpfN562R35RbAuoj1UGo8bZiTdkz2yYK/aLtjEMVD+00jMrTKo?=
 =?us-ascii?Q?5tkGmmvsJabPMg4GeN+1znkxSOpg7Bm6+839vLq4FVmF6jAaxxOUkpp98Q1H?=
 =?us-ascii?Q?uc+0ubA6WsUgfA72hUwD0KjeIuO2pnpw83+ASASDydEG5xiijbIvNvmzlU6M?=
 =?us-ascii?Q?VapwbtvCCDFj/MT9gi4+AuCACJ/lBWr8VnJrDnEICn5iioy2yCPZdDGU9+g9?=
 =?us-ascii?Q?jbJsOpPMguuhSY78ht4uKOiBR8ny6K+ErWZpPf9neEhCHzNfnde0pInWF3X7?=
 =?us-ascii?Q?VsCvSCYUCCKdcz3gUXczO7mOcJW3Jd0RzkHLHb5CynvrkbttY5jqnBwU5C5i?=
 =?us-ascii?Q?PJCFD3gvWp11xUafYC5o7+y71obYhX7y0AlW27f9hdgIUXY9RxdAi3Fv5I2M?=
 =?us-ascii?Q?AQF29dhqHxEhkrX1RCZkYy9aopr5OPgG7m0hCJAxyLhogh9OSM9YvXmV8vCy?=
 =?us-ascii?Q?CLviByOfMy7ym/EyJ9R9WzAouA+WDaA0GxHrkuUh6bpp5Nzw5HGn1fceOKn1?=
 =?us-ascii?Q?eAzypo4VP0XyfHqR5fcJiL6PijWFd87gGMJqmh6n7y7Zi6nXPrHO2aGmcyxY?=
 =?us-ascii?Q?hgV2Y1QLenAfqkssnsCkwa/ono+f9V5Cp0TEYUCLTPxHRSk55+6BB5+afOpC?=
 =?us-ascii?Q?zOnNSaBPAd9cFEuu0Pn41oVLTMfFQruEXmb6fNTRgfuH+DFJO8OFrLraQZTl?=
 =?us-ascii?Q?0+2pvBhnC4JRvm/CJaC1ZP8eI8JVMfs6hSx0z7FD3JFB1Ne8Gl5GmckqgW0i?=
 =?us-ascii?Q?hmsTAsIc0f9X66bouOXrXjdNkUfpi3H53LEpUiqRUBcf8RwbDAuXoLzBaZ80?=
 =?us-ascii?Q?jwlTVGhnL4YhV9+8mEsdjOg3+zez+idomlOkzmbmXOzQCeNbHCTqu7Fhy+VB?=
 =?us-ascii?Q?XRtlCjooIJeXarGbM9LbAFFBIr+E1Pom?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB7007.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?odF9K58M7/UYScgKo2ea3dDJTkDWEonKZHOQkA6FH7rkwrcuendnrzguL/cQ?=
 =?us-ascii?Q?Im1o+vaO5MWAYSakcvR8j3cKJPMPu5vW49Xk46F95+/KIW4RLEunBMJqHEuP?=
 =?us-ascii?Q?wj7PBg5yjK+3I00K+rkrJ8hLgAeraCkPYCKimZTl7xJ2e0hjVYiXgrzx4shb?=
 =?us-ascii?Q?1y8V+e1d3UIeuVOmdKq24yhY/8KxnA71GK/jWzFq3M7W6u+3jyCRo3XiEZYn?=
 =?us-ascii?Q?z8x7hQIFXhidVVXvDSHBkxeioPOkx0GU70KYdWPJqT8FhopRXMVOlBtRERYL?=
 =?us-ascii?Q?sc3EfPbqJ62ncNKmDGsoHQbnndU2B11JxxQAKYVa64lsiTQv7dJmyL0kMj8Q?=
 =?us-ascii?Q?WgnWfvaTZiZ6ykUk0Qjni0fjGe+QnI14qzD6KwQQODXJU3v7+/O/zJ4XgBcG?=
 =?us-ascii?Q?TkyLkNJ7f11xIyOKzunWCmHWBA4pMeyw4mWlXwzjvL5Ld5aDkKR7+riH5A4e?=
 =?us-ascii?Q?vfYee5sG3mLHM3+gWsNoAuuzzizM7Y0fmbAO9Nu/4vBo9Ut83Mc6mJwTFq+I?=
 =?us-ascii?Q?78dpBc2DmvbrNNB9qWj07LhVBdP3jXTY+TMEyEfRf5UZrh68inDWYLUzgWbB?=
 =?us-ascii?Q?Nku9W6MPGQeB6OiFEb4Se5iJ4OGtsLaoLC/I2fJbFKFLAK5YUHRjVOdI8IUM?=
 =?us-ascii?Q?gpfbtlMHBaKPZmm+HZYX+/gGdf04Fy9R4Yt4grMvgbsgaSrog1HCitm+mSav?=
 =?us-ascii?Q?gUZfKmBAPPlHqr6RdUEP4scJiUF4gahg757dU5rlndSUbUYG/VjjyJ0X2Fwd?=
 =?us-ascii?Q?XF87X+MziXLlXJXF6AtQKIG/LFH2Rs3FIyQdy/mf1H0UmHELtD0QNkm9xlYg?=
 =?us-ascii?Q?zGyh0hOgZUHBFOXdObgrhIQ0SxrVpnoHBXMDpfG957KleMNwp6F3LzPICUwt?=
 =?us-ascii?Q?1119fEEaw3/I0RgJ6zZ7zWnah3GBkbv5lS7x7m9nGqrvhEt3wy5bvL7hsZo2?=
 =?us-ascii?Q?CH+6M9I3dF3FWV4Lg0OVbfIpfyHVbcGKIizrHopXwyqz32YlBUvflmxxXxKM?=
 =?us-ascii?Q?b3g7eW00/wQjZuVD7oQemdAKKMWv/C3TqtBOaj6Qzm5pMQKCHf5qbArn8WFh?=
 =?us-ascii?Q?cyQgZw93AnVDeftAsgzbyVy7MuIcVZW2xBwAzvs6MU/vAPaMFaLB5NpPf/Ma?=
 =?us-ascii?Q?ScBnnBJjf9r5FIc5931sVjInTm4CSEnqFMt4U6I3Wj4a/c/G4RiDsBOCdJJM?=
 =?us-ascii?Q?oam80XR3C9lJxn2uxSa0kSw/7MgneEFa+rIWFUnGvUV+h8arM+FQwt3wcsSo?=
 =?us-ascii?Q?ZvGXfzDASMhKgBfrvfpH6U+k2K8E+FSGphB31O+NaipJrUETpYxjpNtYn6DC?=
 =?us-ascii?Q?WZVaaVVTFZQ89jFMmS2vlnk8W1aomYKVTFH+o+YrE25I02vQiK+a7IrOCmaF?=
 =?us-ascii?Q?pkm12hGboFFwpDqj1aIempTSn6u/Lc9G0DbS17tzQm69hPhOmSU9apKjCVlc?=
 =?us-ascii?Q?KCBT8WeM/PnZGw7U3bbggp8hOCRNQAjT/TxYYA0X0AL6j/lIixEGxDyBQnx8?=
 =?us-ascii?Q?JqngmNHhUxp6Qi61jeXCebeAcnRePbMSIGiJqkBiQrOyZ0Eilrnz1zPtGwMW?=
 =?us-ascii?Q?JQpKltr9ZWvVZwpI7HMwGHOpcDO71lJUC0ZxXAxiJGHxz0MoiXL8tRqsgQwU?=
 =?us-ascii?Q?XfCWTiT014hTY0BWcrNx1LbmxVI7km2ivtJhbyPXGuLKw9sjPpaQ0X2+17IZ?=
 =?us-ascii?Q?O6ildw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Lexmark.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB7007.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feac425e-28e5-4778-fb35-08dd73ac3c13
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2025 19:09:33.5788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 12709065-6e6c-41c9-9e4d-fb0a436969ce
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TECLTV8rVpeY/Mt8jzJPrBd5tlgbA1lGjoD9KUANW2617gOKkV7j+rqIonag7w8sDDUM4n4uDt2mcrfRFap7NXYvj/wfb0l3870TLoj9wLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5084
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 04 Apr 2025 19:09:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1283

Zephyr upstream reconfigurations now require either the CMake variable
TOOLCHAIN_HAS_NEWLIB or Kconfig NEWLIB_LIBC_SUPPORTED in order to build
with FULL_LIBC_SUPPORTED and NEWLIB.

This cross-compile toolchain does indeed have full newlib support available
so we need to now specify that so it can be used.

Signed-off-by: Nicholas Lowell <Nicholas.Lowell@lexmark.com>
---
 .../zephyr-kernel/zephyr-toolchain-cross-compile.inc             | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-toolchain=
-cross-compile.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-t=
oolchain-cross-compile.inc
index 2f1ea37..f26683e 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-toolchain-cross-=
compile.inc
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-toolchain-cross-=
compile.inc
@@ -6,6 +6,7 @@ SYSROOT_DIR=3D"${STAGING_DIR_TARGET}"
 EXTRA_OECMAKE:append =3D " \
     -DCROSS_COMPILE=3D${CROSS_COMPILE} \
     -DSYSROOT_DIR=3D${SYSROOT_DIR} \
+    -DTOOLCHAIN_HAS_NEWLIB=3DON \
     "

 OE_TERMINAL_EXPORTS +=3D "CROSS_COMPILE"
--
2.43.0

Lexmark Confidential

