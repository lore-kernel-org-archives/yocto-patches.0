Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971DEC982ED
	for <webhook@archiver.kernel.org>; Mon, 21 Sep 2026 22:22:24 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.22])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8429.1790029336423232758
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 21 Sep 2026 15:22:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=iRga4PMs;
 spf=pass (domain: siemens.com, ip: 52.101.65.22, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lh1tQmCnEUqY+qEok6lDB6XLYsa8R0Nt2INmXHkmMHOlv6Jvj5Lc+3RQw+n96yzb66pHR4ldooOjCdgKVHtE96SExbPzlJNJYZuGmNdXOvgOTQB/fHCbFTBZ7ytwQ08BTa74DtJ/8vTGeUW8YPy9UoXFxE1/chScTGKw4G+YGMNY21/fvU/f9D2dtZZRCvVAyEIHrHd8A4bcjG2q4qpq340wig4I7PYWGAJxkAZ+XjbmrMjjpkQYfhMQ7eOMkTFLl62wSyZuGNEmvwj1yepkpsu09iSNhYk1nxzdO8irFR73pliQwwbzA6AImhYQYv/+FpzYnPCxgpbPmJNBAHa5ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjtHEfPRwGw4kyFV8tZmVnaPsQ4TvHS/UL3w+jfKeSg=;
 b=jfKVWdt2idtpxDBpnda5eFkhmwWlrYMGF1/apblKFGKgR0iVdDCVIh871ZuB18rrdeX5Xsma+Rv5IrQDzMZMwTB6cgdaw6sQnCvzriMTUchPm6KpuxPBdvp6t4CN6uVMc+wLa6LTDYOuLJ4ARduTyASLfmKduRYJDAmuAAKHsLqf/uDLmOPTw+fNVf2aNusD2fm5zYKh9Kj4Gwx0QYD7edU7sQIPJtjCBykpLvN0inX0UD79wV68Bh6avv5Vwvy7dv+krWkx3ctrKofmqIMO2r4nFrbazKS6v28Ss4ZW8UJq1qBxTg+e5MY+T9uTGiEMcyT+7vrO8TzNWpK4FhMp7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjtHEfPRwGw4kyFV8tZmVnaPsQ4TvHS/UL3w+jfKeSg=;
 b=iRga4PMsaf8PXMi5ImEo4CvTX+NGDieq//XQ4ezA/Fb7w2vLdQLAtfLbtM0XCkkrssPhMvtyUCbfOduD3V6PYpAi6+1BvBvia61JUR9qOrdVxJGRmbPSRNDWFVWBQiptIlUK4PJkHqQwe1fVRcQdVSXPdUzQ8CS01q9vMs1ajMxlq1AnHbfjrLgfgvLS8moQJp/90p1Ktp6IzybZWLEkOLghKUuhgODfJTRXO3oEfERAPuhPf8lC/3zMo0QR5skpfw5uD6nGdYUCQsRpjpfSG95qNPGnB4VQ7MGs7jkmpJqTC2xYrW8qrxoocQbDhthWRpTmYDgQFUvmh4zGYRTR+A==
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:420::16)
 by AM9PR10MB4117.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 22:22:11 +0000
Received: from AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008]) by AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a905:57e5:8858:d008%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 22:22:11 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: RE: [meta-lts-mixins][wrynose/go][PATCH 01/11] Initial commit: add
 license, readme, gitignore and layer config
Thread-Topic: [meta-lts-mixins][wrynose/go][PATCH 01/11] Initial commit: add
 license, readme, gitignore and layer config
Thread-Index: AQHdRH0SBD8Mmtl33USRkTh0pJqR/7bZpjlQ
Date: Mon, 21 Sep 2026 22:22:11 +0000
Message-ID: 
 <AS8PR10MB5073E988E0FF888C7FD337C3FD842@AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM>
References: <20260914191240.1066469-1-peter.marko@siemens.com>
In-Reply-To: <20260914191240.1066469-1-peter.marko@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=5bd8d478-9a2a-41dc-aa2b-012c10b0ac2b;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-09-21T22:21:51Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB5073:EE_|AM9PR10MB4117:EE_
x-ms-office365-filtering-correlation-id: 1dbd7cfb-8544-49db-f425-08df182ec84c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|22082099003|18002099003|55112099003|38070700021|11063799006|56012099006|10067099003|3023799007;
x-microsoft-antispam-message-info: 
 m5Nq6miwMQLLddvtS4Hz6ULO/EH0gXWwELjroKzADnaW3xvMAD30AOv8DYC6I3J1u4ZJf1qU/DgSKM0bY9EyC07EK+4CUuYROjhEv1aUlmYji9GLRftdXfmjUmNNuORXgbit4nYjVLi7s2r9e9/YPdlQLkYGPuxQiShAL4dTRiZTzXUrsyG8cpBAJvBQUw2r5UTDdmmVpD/EGP0o+pm3WhJ2a8AUH51nL45h+abSTtDdWh9Cvz/PsrwOcbpRJztr7n8Y4xX8VNAS7eWhvVcoxGo2zBkfe5rI6X0l0WTh5Z2iI7sQuB6EJh7jVE1KSRZGEmYXYRa5EI/Tjo9DsuzHsLkzm1hxstcBlX3TtJyCNB3LhvEpznekXp2Q3hew8S5lK2S2gPlnhSSOF9nnkgELZAFD5453aGnYoFTsGOhOHab4Ef3yd9KW9IfMueGkaYgCWe/xB6h0zq+B3r2qJAyQJZMxA+NZUIjhIDPNSrc1uBmXyImCBGhrbKScFEsQXWE6qmH3jpjcgE/bUrETJEZZ5WBuw2BFDhyC38fn3YJ4m2JGPTz7QEVKNOgZIGOVwdY6g/VEtFcsv94G3/29/hltt3w/4b0vRDX3M/rkDBUpX+2/sDMbfxyAtgdaQd/D6hewG4TR1qAIO0gP2K5D5kk3HGVyhuLVthgYM0g62p4794tsBjLKJZBj1wU3wB2rTWV1QQ3tMDRKeJFpqX7QcHQtoFd5bx/bLxFGax+LhQR37l0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(55112099003)(38070700021)(11063799006)(56012099006)(10067099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?hmpWhB/lPqApbUIGU+npvRk2oSzbWmIbl2QvEpcdMJgs7C9RK4VchUWTTU7D?=
 =?us-ascii?Q?HKkKeelXhKQDBGT3IYSClDImoanXdbCUOvGHI/62WjOrgGYqu4BxevkB/qvu?=
 =?us-ascii?Q?IKt4GnFMixZXT3tYjQ90xvmtPlas15yT78wUKO1ARveLg72wiHWovZD7huuR?=
 =?us-ascii?Q?DdyG2Tys6tqwAECXkM9O/Ghlg3GnpaLAz/QUjmwNQC2vcVIzhwGNh7QYiE/m?=
 =?us-ascii?Q?06vFoCGfi24n3IEC9ttwgvirH2XubmLe/Pyou+ZhO8nWQvt+Ss8vc9naO39B?=
 =?us-ascii?Q?QTE1/WRkcHvSseNQzNMyrHEwvQK4E28CkCrGM+u/J7VEs9oL2pbAUhN3qliv?=
 =?us-ascii?Q?ukDZXBUCLePIEjowZCtRsRlZwgmdkGwuq3jFil+odPlIe+LRGrxrovFnMubx?=
 =?us-ascii?Q?VfC70ktFJSG02QXN1tZOLfyQyW1jxWlTYqS1oL4RkAEtgH2oeXhtYyXHcptL?=
 =?us-ascii?Q?70nkhps97aRYQVmZCNRmQhwdmOjfE+Iw0C28Q6lDbp1F0utfXOXgdrp3DD2/?=
 =?us-ascii?Q?TP5S3bYfJQZLo202T1o7qKQSIo2k68K+nNO7z7kADybGLsK8DgKGF0AvCtAw?=
 =?us-ascii?Q?2XaeEhAox0l3rPaK+TF47kjeZFE7o3+gGTtoCYfs89Yo9S/+3HXdTffU9bxz?=
 =?us-ascii?Q?cwS2unqtbt+suTFcWr3OkWdqbRSfKtwzt43DbV3pFZtmuaiwpWSFEY+VWwFd?=
 =?us-ascii?Q?NuK7mR/cTWJWFSe8S7KY5khEIEjztI7fr94wvNKznIUO9zXYCgii/mp3I2F9?=
 =?us-ascii?Q?9t3+EM0Hyqh3H2vXKbvwHpOqQAH5Nc1RC0/nB/YdiQzQpSVaHETQGon4xIb2?=
 =?us-ascii?Q?IodLHDPz2Q485fqJOZbOGM5U47Eb8RHErp2WkIDzU9LNIdE6bwDjKWMdKktj?=
 =?us-ascii?Q?iPNkfEb8mhYu5xP1dtuRhLUjjOPEdiNGe/66rQg0tZzclwHSQzLWMd5V/W2e?=
 =?us-ascii?Q?N61YvJfyH4kxmmKDfG054BAxqC5Xbn5vZUmjx5cALqSodtDLJnrRsseWMN4v?=
 =?us-ascii?Q?6sE82Ox9TGBHkAY8/2yxE1JL0vrjIzdJxToG5+X5ME028kgxg10G8XX1wG3P?=
 =?us-ascii?Q?GwtrI/C/phFzenpYFUKIZa1dpmQ/IeKXambvn4mc5nTB1T8TkCK5AwCGna2U?=
 =?us-ascii?Q?t9ssSf9Zg67KSQ3MaC5pC72ULR3iP3yF6wKi0bVDxDyQ/gfuNjNchu0NIy1B?=
 =?us-ascii?Q?qHn3G2WDDp/ByRI0uajx3VILu3Fjw56CThSNIkulzNsYHeBV/WFzP62l5V3g?=
 =?us-ascii?Q?5aGmEHsLISM8A07+6lCLhYncwHZuXA5Ais6rheRK3lBdYtPSvk4Y1E3nFoDN?=
 =?us-ascii?Q?9R7Y7N7eTEEBUhXQQVssBEP7PMNA46yCEIjlAd5X8GJuPeUrWqx/h5qLJJpf?=
 =?us-ascii?Q?np1k/siLjyAszoVvpq2ebDEOjs5lQ9qesbvx1HHGGrfkc9nVmAmKuQRfBwYk?=
 =?us-ascii?Q?nXg6xk0dvcXQ8O3m78dB6eYRySlDtQgXSxOrgXsMhlGyiX/DS7ikS3rsCl2G?=
 =?us-ascii?Q?+sV3fbrwlgQVn+H8hTG27NsvOkoIqGcrW2z/3n2OF3G7zGiizi+FCnK3HQcX?=
 =?us-ascii?Q?YsG8P7ptvBOjaYakNRZoeRQCVaKSbOadgLwA4GaeHdKFos/uaeUHWz4cksic?=
 =?us-ascii?Q?7XCWb2EoDPfb1NajiLQFPp8X7ocYrz+mIXsvi1OVSGhWKwwXWxC3MZYcVCVq?=
 =?us-ascii?Q?7yStx6qZ/JENmxwNQ0f5cQBctrQDiPc53J/UuHu+zU7yWpxD6KzSnJQrp8c2?=
 =?us-ascii?Q?dOpvxs9yYA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dbd7cfb-8544-49db-f425-08df182ec84c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 22:22:11.7382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H0hpmv4X8NeFeQyoA9J+iTf0T52QJxrexwizgCP8YjHH4N29cAqMQmTh8Cz6zU7vANJdYyPwAesKA3StAZ1/JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4117
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 21 Sep 2026 22:22:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4925

This series is now merged.

-----Original Message-----
From: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>=20
Sent: Monday, September 14, 2026 9:13 PM
To: yocto-patches@lists.yoctoproject.org
Cc: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>; jose.quaresma=
@foundries.io
Subject: [meta-lts-mixins][wrynose/go][PATCH 01/11] Initial commit: add lic=
ense, readme, gitignore and layer config

From: Peter Marko <peter.marko@siemens.com>

This is a copy of these files from scarthgap/go branch modified for
wrynose release:
* switch scarthgap to wrynose
* drop extra configurations fro layer.conf

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 .gitignore      |  1 +
 COPYING.MIT     | 17 ++++++++++
 README.md       | 86 +++++++++++++++++++++++++++++++++++++++++++++++++
 conf/layer.conf | 15 +++++++++
 4 files changed, 119 insertions(+)
 create mode 100644 .gitignore
 create mode 100644 COPYING.MIT
 create mode 100644 README.md
 create mode 100644 conf/layer.conf

diff --git a/.gitignore b/.gitignore
new file mode 100644
index 0000000..0d20b64
--- /dev/null
+++ b/.gitignore
@@ -0,0 +1 @@
+*.pyc
diff --git a/COPYING.MIT b/COPYING.MIT
new file mode 100644
index 0000000..fb950dc
--- /dev/null
+++ b/COPYING.MIT
@@ -0,0 +1,17 @@
+Permission is hereby granted, free of charge, to any person obtaining a co=
py=20
+of this software and associated documentation files (the "Software"), to d=
eal=20
+in the Software without restriction, including without limitation the righ=
ts=20
+to use, copy, modify, merge, publish, distribute, sublicense, and/or sell=
=20
+copies of the Software, and to permit persons to whom the Software is=20
+furnished to do so, subject to the following conditions:
+
+The above copyright notice and this permission notice shall be included in=
=20
+all copies or substantial portions of the Software.
+
+THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR=
=20
+IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,=20
+FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL TH=
E=20
+AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER=20
+LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FR=
OM,=20
+OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN=
=20
+THE SOFTWARE.
diff --git a/README.md b/README.md
new file mode 100644
index 0000000..7330b8c
--- /dev/null
+++ b/README.md
@@ -0,0 +1,86 @@
+meta-mixins-lts - wrynose/go
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+
+"Mixin" layer for adding latest Go toolchain versions into the Yocto Proje=
ct LTS.
+
+At the time Wrynose was released in April 2026, Go 1.26 was the latest ver=
sion
+and officially Wrynose supports only that. This thin special-purpose mixin
+layer is meant to address this issue by backporting Go recipes from the ma=
ster
+branch of openembedded-core.
+
+Dependencies
+------------
+
+This layer depends on:
+
+- URI: git://github.com/openembedded/openembedded-core.git =20
+  layers: meta =20
+  branch: wrynose
+
+Contributing
+------------
+
+The patches can be backported from openembedded-core with:
+
+ git -C ../openembedded-core format-patch --stdout -1 origin/master meta/r=
ecipes-devtools/go | \
+ git am --signoff -p4 --directory=3Drecipes-devtools/go
+
+The yocto-patches mailinglist (yocto-patches@lists.yoctoproject.org) is us=
ed
+for questions, comments and patch review. It is subscriber only, so please
+register before posting.
+
+Send pull requests to yocto-patches@lists.yoctoproject.org with
+'[meta-lts-mixins][wrynose/go]' in the subject.
+
+When sending single patches, please use something like:
+git send-email -M -1 --to=3Dyocto-patches@lists.yoctoproject.org --subject=
-prefix=3D'meta-lts-mixins][wrynose/go][PATCH'
+
+Maintenance
+-----------
+
+Layer maintainers:
+* Jose Quaresma <jose.quaresma@foundries.io>
+* Peter Marko <peter.marko@siemens.com>
+
+Quality Assurance
+-----------------
+
+QA tests are using original openembedded-core testsuites.
+Current plan is to backport QA test changes to openembedded-core wrynose b=
ranch.
+When that is no longer possible, changes will picked here.
+
+Automated tests to verify go toolchain functionality are being executed wi=
th following configurations and commands:
+
+* OEQA runtime
+
+    ```
+    IMAGE_INSTALL:append =3D " cgo-helloworld go-helloworld packagegroup-g=
o-sdk-target"
+    IMAGE_CLASSES +=3D "testimage"
+    TEST_SUITES:append =3D " go go_mixin"
+    ```
+
+    ```
+    bitbake core-image-ptest-go && bitbake core-image-ptest-go:do_testimag=
e
+    ```
+
+* OEQA SDK
+
+    ```
+    IMAGE_CLASSES +=3D "testimage"
+    SDK_TOOLCHAIN_LANGS =3D "go"
+    TESTSDK_SUITES =3D "go"
+    ```
+
+    ```
+    bitbake core-image-minimal:do_populate_sdk && bitbake core-image-minim=
al:do_testsdk
+    ```
+
+* OEQA selftest
+
+    ```
+    SANITY_TESTED_DISTROS =3D ""
+    ```
+
+    ```
+    oe-selftest -r gotoolchain -j $(grep -c ^processor /proc/cpuinfo)
+    ```
diff --git a/conf/layer.conf b/conf/layer.conf
new file mode 100644
index 0000000..9215c91
--- /dev/null
+++ b/conf/layer.conf
@@ -0,0 +1,15 @@
+# We have a conf and classes directory, append to BBPATH
+BBPATH .=3D ":${LAYERDIR}"
+
+# We have a recipes directory, add to BBFILES
+BBFILES +=3D "${LAYERDIR}/recipes*/*/*.bb ${LAYERDIR}/recipes*/*/*.bbappen=
d"
+
+BBFILE_COLLECTIONS +=3D "lts-go-mixin"
+BBFILE_PATTERN_lts-go-mixin :=3D "^${LAYERDIR}/"
+BBFILE_PRIORITY_lts-go-mixin =3D "6"
+
+LAYERSERIES_COMPAT_lts-go-mixin =3D "wrynose"
+
+LAYERDEPENDS_lts-go-mixin =3D " \
+    core \
+"

