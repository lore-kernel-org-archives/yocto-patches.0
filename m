Return-Path: <jamin_lin@aspeedtech.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424C6E77188
	for <webhook@archiver.kernel.org>; Thu, 19 Dec 2024 02:20:40 +0000 (UTC)
Received: from TWMBX01.aspeed.com (TWMBX01.aspeed.com [211.20.114.72])
 by mx.groups.io with SMTP id smtpd.web11.121535.1734574839531163145
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Dec 2024 18:20:39 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: aspeedtech.com, ip: 211.20.114.72, mailfrom: jamin_lin@aspeedtech.com)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 19 Dec
 2024 10:20:36 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 19 Dec 2024 10:20:36 +0800
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <troy_lee@aspeedtech.com>, <vince_chang@aspeedtech.com>,
	<jamin_lin@aspeedtech.com>
Subject: [meta-zephyr][PATCH v1] zephyr-sdk: replace pre-built host tool of zephyr-sdk with Native packages
Date: Thu, 19 Dec 2024 10:20:36 +0800
Message-ID: <20241219022036.561047-1-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 19 Dec 2024 02:20:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/938

It installed pre-built host tool of zephyr-sdk into build environment at th=
e
host side. However, the pre-built host tool of zephyr-sdk linked the
"ld-linux-x86-64.so.2" from the hardcode SDK installation path.

Used "ldd recipe-sysroot-native/usr/zephyr-sdk/sysroots/x86_64-pokysdk-linu=
x/usr/bin/dtc"
command to show the linker information of pre-built dtc tool.

```
/XXX/build/tmp/work/x86_64-linux/zephyr-sdk-native/0.16.9/XXX/build/tmp/wor=
k/x86_64-linux/zephyr-sdk-native/0.16.9/recipe-sysroot-native/usr/zephyr-sd=
k/sysroots/x86_64-pokysdk-linux/lib/ld-linux-x86-64.so.2 =3D> /lib64/ld-lin=
ux-x86-64.so.2
```

The pre-built host dtc tool linked "${D}${ZEPHYR_SDK_DIR}/recipe-sysroot-na=
tive/usr/zephyr-sdk/sysroots/x86_64-pokysdk-linux/lib/ld-linux-x86-64.so.2"
However, the hardcode link path causes the pre-built host tools cannot be
executed if users set sstate-cache build.

How to reproduce it:
1. Setup a new build environment A and build zephyr image by "bitbake zephy=
r-helloworld"
2. Save and copy the "build/sstate-cache" directory to ${HOME} directory.
3. Remove a completely build environment A.
4. Setup a new build environment B and set SSTATE_DIR variable to "${HOME}/=
sstate-cache".
5. Build zephyr image by "bitbake zephyr-helloworld". The pre-built host to=
ol
   from zephyr-sdk cannot be executed.

   ```
   ./recipe-sysroot-native/usr/zephyr-sdk/sysroots/x86_64-pokysdk-linux/usr=
/bin/dtc -h
   No such file or directory
   ```

To fix it, replace pre-built host tool of zephyr-sdk with Yocto Native pack=
ages.
Append "dtc-natvie" in the DEPENDS variable in zephyr-kernel-common.inc.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 .../recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb           | 3 ---
 .../recipes-kernel/zephyr-kernel/zephyr-kernel-common.inc      | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9=
.bb b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb
index 57fe777..3d9e628 100644
--- a/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb
+++ b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb
@@ -28,9 +28,6 @@ ZEPHYR_SDK_DIR =3D "${prefix}/zephyr-sdk"
 do_install() {
     install -d ${D}${prefix}
     cp -r ${UNPACKDIR}/zephyr-sdk-${PV} ${D}${ZEPHYR_SDK_DIR}
-
-    # Install host tools
-    ${D}${ZEPHYR_SDK_DIR}/setup.sh -h
 }
=20
 SYSROOT_DIRS +=3D "${ZEPHYR_SDK_DIR}"
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-co=
mmon.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-comm=
on.inc
index 6544475..77d1cfa 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.in=
c
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.in=
c
@@ -29,7 +29,7 @@ EXTRA_OECMAKE:append =3D "  -DZEPHYR_EXTRA_MODULES=3D${ZE=
PHYR_EXTRA_MODULES}"
=20
 export ZEPHYR_BASE=3D"${S}/zephyr"
=20
-DEPENDS +=3D "gperf-native"
+DEPENDS +=3D "gperf-native dtc-native"
=20
 DEPENDS:append:qemuall =3D " qemu-native qemu-helper-native"
=20
--=20
2.25.1


