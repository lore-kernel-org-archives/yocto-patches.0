Return-Path: <schonm@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1B2C02183
	for <webhook@archiver.kernel.org>; Sun, 19 Jan 2025 13:04:25 +0000 (UTC)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
 by mx.groups.io with SMTP id smtpd.web11.14762.1737291856621750436
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 19 Jan 2025 05:04:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Ts71WVOm;
 spf=pass (domain: gmail.com, ip: 209.85.222.50, mailfrom: schonm@gmail.com)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-860f0e91121so2519050241.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 19 Jan 2025 05:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737291855; x=1737896655; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Hia4Jm25DzGTiM3oKSoIp04IW2Mbo2TE4F3kNbrs0g=;
        b=Ts71WVOmXnKC2wBpdz6mD9P4/dEY5E5t/amy4/tEHFzbivvopaNxCYKSvk4wg0nBGB
         ux2kHNyKfYqdAkaLOQ17ibe7VCltEipGmUq+Wks5D7WTnZ5fXVsHG6BKhQSLhUX0e0+d
         O6u/YBcA13H2pcFFoSPx5gyM8dF5rbLEbUNLJpJ6OAd0CAAvHyRnbEAFp4Jw3FO82NGS
         sdqJnQxdJVH/poRHxdqM1Ur5MJkE3TBbyZ8+d8DQuBwZ+2B++7A+Xe1kmBfCkLDIL+T+
         jW3Vk7EQOxRLO+dGuNQa6Y4d7cGqNTka5rnmQZP1eR+qEW+CseTYRPUcZo9aLSxjDAYH
         An5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737291855; x=1737896655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Hia4Jm25DzGTiM3oKSoIp04IW2Mbo2TE4F3kNbrs0g=;
        b=wtOfZuVwoufL2qCVHde/qE5Ju6x006DAYkZv6PuIs1QIC88ESEUr8tgDFmLcSHpLf9
         nDn+mKedVZYVhONpjUhgvvcuHIR/Ite/dzTgVbYwnVfMfxS1p5gJmRhSiDsoZ6MlqPqR
         NteowTgbPHnmZV3L1VENYcwwPttQkgiMeUKIQGAcEv0udqjDwQIHnuiDW6p/Xc0yeD2n
         N2wGWBIHNivQy9pS+H6SxDbP038jqVivOQOGas2RsvCW6b4K8wL1ezYhTSpG22GaP9z1
         7mbyKrRBP9uGsgE+V92Tbdqq4BCEFtFimwfuOvjQgfqaTKM/wRffeVEa45kwhh2CggcU
         fH+Q==
X-Gm-Message-State: AOJu0YycK4clTDCDhqGrHZdc6gQ1dndoY4URCeUE/72zx/Ov1ZhnuVlu
	evvibs0uAHncbhiAPPwuKLdmrlHJYUfEz30ZAynnpEfKFej7pv9nJ2cGvxnP
X-Gm-Gg: ASbGncu3wn0FQlTt8DNX3767r/nSWP6gyBUKqu3yxqR5uUZQ688iYdGzkX99oCNP4lG
	yx8HIVMTh/1Acb1sJDgfGtrh3RuL+1Vpl7aE0uwm1bmb5MNbrJlgkMg+Lhgt6mWHxa8Ma1es9PF
	yfKvnyr2Z5/QPfF8tC5b41oGJ1mjvXCr2a4lqrodP+SE+ktm/3ohAw+L0Dw21mo8EOxZ89eAaPM
	STACLZ8p3vcnUmjliox5GdIlYjuM+iLDl4/INvY4GMuszJbacapuREFCJKlAjdDAu299P+aGR4O
	PC3gKtpxCuW3QO6E6uT7JyECdAv/
X-Google-Smtp-Source: AGHT+IHHGEgh4xToqGiITwvQPMKdkYD/8HOPV9qHKPFjfQOfWs/ehXpvZ0bW3bPPPPb3I94KpHf8nw==
X-Received: by 2002:a05:6122:6bb:b0:515:d230:f2c6 with SMTP id 71dfb90a1353d-51cd986af44mr10932514e0c.7.1737291854640;
        Sun, 19 Jan 2025 05:04:14 -0800 (PST)
Received: from localhost.localdomain (71-208-20-57.ftmy.qwest.net. [71.208.20.57])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51cf559fb99sm1048242e0c.16.2025.01.19.05.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 05:04:14 -0800 (PST)
From: Jason Schonberg <schonm@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Jason Schonberg <schonm@gmail.com>
Subject: [meta-java][PATCH] Drop the use of SRC_URI[md5sum] where SRC_URI[sha256sum] is already in use.
Date: Sun, 19 Jan 2025 08:03:59 -0500
Message-ID: <20250119130359.4149-1-schonm@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 19 Jan 2025 13:04:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/984

Signed-off-by: Jason Schonberg <schonm@gmail.com>
---
 recipes-core/ant-contrib/ant-contrib-native_1.0b3.bb       | 1 -
 recipes-core/ant/ant-native_1.8.1.bb                       | 1 -
 recipes-core/antlr/antlr_2.7.7.bb                          | 1 -
 recipes-core/bcel/bcel_5.2.bb                              | 1 -
 recipes-core/cacao/cacao-initial-native_0.98.bb            | 1 -
 recipes-core/classpath/classpath-initial-native_0.93.bb    | 1 -
 recipes-core/classpath/classpath-native_0.99.bb            | 1 -
 recipes-core/classpath/classpath_0.99.bb                   | 1 -
 recipes-core/classpathx/gnujaf_1.1.1.bb                    | 1 -
 recipes-core/classpathx/gnumail_1.1.2.bb                   | 1 -
 recipes-core/classpathx/inetlib_1.1.1.bb                   | 1 -
 recipes-core/cup/cup_0.10k.bb                              | 1 -
 recipes-core/ecj/libecj-bootstrap-native_3.6.2.bb          | 1 -
 recipes-core/fastjar/fastjar_0.98.bb                       | 1 -
 recipes-core/jacl/jacl_1.4.1.bb                            | 1 -
 recipes-core/jakarta-commons/commons-beanutils_1.8.0.bb    | 1 -
 recipes-core/jakarta-commons/commons-cli_1.1.bb            | 1 -
 recipes-core/jakarta-commons/commons-codec_1.3.bb          | 1 -
 recipes-core/jakarta-commons/commons-collections3_3.2.2.bb | 1 -
 recipes-core/jakarta-commons/commons-collections_2.1.1.bb  | 1 -
 recipes-core/jakarta-commons/commons-digester_1.8.bb       | 1 -
 recipes-core/jakarta-commons/commons-discovery_0.4.bb      | 1 -
 recipes-core/jakarta-commons/commons-el_1.0.bb             | 1 -
 recipes-core/jakarta-commons/commons-fileupload_1.2.1.bb   | 1 -
 recipes-core/jakarta-commons/commons-httpclient_3.1.bb     | 1 -
 recipes-core/jakarta-commons/commons-io_1.4.bb             | 1 -
 recipes-core/jakarta-commons/commons-lang_2.4.bb           | 1 -
 recipes-core/jakarta-commons/commons-logging_1.1.1.bb      | 1 -
 recipes-core/jakarta-commons/commons-net_1.4.1.bb          | 1 -
 recipes-core/jakarta-commons/commons-pool_1.4.bb           | 1 -
 recipes-core/jakarta-libs/bsf_2.4.0.bb                     | 1 -
 recipes-core/jakarta-libs/log4j1.2_1.2.17.bb               | 1 -
 recipes-core/jakarta-libs/logkit_1.2.2.bb                  | 1 -
 recipes-core/jakarta-libs/oro_2.0.8.bb                     | 1 -
 recipes-core/jakarta-libs/poi_3.0.bb                       | 1 -
 recipes-core/jakarta-libs/regexp_1.5.bb                    | 1 -
 recipes-core/jamvm/jamvm-initial-native_1.4.5.bb           | 1 -
 recipes-core/javasqlite/javasqlite_20150419.bb             | 1 -
 recipes-core/jcraft/jsch_0.1.40.bb                         | 1 -
 recipes-core/jcraft/jzlib_1.0.7.bb                         | 1 -
 recipes-core/jikes/jikes_1.22.bb                           | 1 -
 recipes-core/jlex/jlex_1.2.6.bb                            | 1 -
 recipes-core/junit/junit4_4.3.1.bb                         | 1 -
 recipes-core/junit/junit_3.8.2.bb                          | 1 -
 recipes-core/libmatthew/libmatthew_0.8.bb                  | 1 -
 recipes-core/servlet-api/jsp2.0_5.5.26.bb                  | 1 -
 recipes-core/servlet-api/servlet2.3_4.1.37.bb              | 1 -
 recipes-core/servlet-api/servlet2.4_5.5.26.bb              | 1 -
 recipes-core/xerces-j/xerces-j_2.11.0.bb                   | 1 -
 recipes-core/xml-commons/jaxp1.3_1.4.01.bb                 | 1 -
 recipes-core/xml-commons/jdom_1.1.3.bb                     | 1 -
 recipes-core/xml-commons/xml-commons-resolver1.1_1.2.bb    | 1 -
 recipes-core/xml-commons/xpp2_2.1.10.bb                    | 1 -
 recipes-core/xml-commons/xpp3_1.1.3.4.O.bb                 | 1 -
 recipes-extended/dbus/dbus-java_2.7.bb                     | 1 -
 recipes-extended/hsqldb/hsqldb_1.8.0.10.bb                 | 1 -
 recipes-extended/rxtx/rxtx_2.2.0.bb                        | 1 -
 recipes-extended/xmlpull/xmlpull_1.1.3.4c.bb               | 1 -
 58 files changed, 58 deletions(-)

diff --git a/recipes-core/ant-contrib/ant-contrib-native_1.0b3.bb b/recipes-core/ant-contrib/ant-contrib-native_1.0b3.bb
index db79626..e92f28a 100644
--- a/recipes-core/ant-contrib/ant-contrib-native_1.0b3.bb
+++ b/recipes-core/ant-contrib/ant-contrib-native_1.0b3.bb
@@ -16,7 +16,6 @@ inherit java-library native
 
 SRC_URI = "${SOURCEFORGE_MIRROR}/ant-contrib/ant-contrib-${PV}-src.zip"
 
-SRC_URI[md5sum] = "07b23539bef04ec56970c876a33f7665"
 SRC_URI[sha256sum] = "ba3621f397af14d5a19375f391ec9bf2908c46c5558ca0df8365e04fe3ac3633"
 
 S = "${WORKDIR}/ant-contrib"
diff --git a/recipes-core/ant/ant-native_1.8.1.bb b/recipes-core/ant/ant-native_1.8.1.bb
index 8814039..b81f71d 100644
--- a/recipes-core/ant/ant-native_1.8.1.bb
+++ b/recipes-core/ant/ant-native_1.8.1.bb
@@ -62,6 +62,5 @@ do_install:append() {
 	install -m 0755 ${WORKDIR}/ant ${D}${bindir}
 }
 
-SRC_URI[md5sum] = "9e5960bd586d9425c46199cdd20a6fbc"
 SRC_URI[sha256sum] = "4f39057af228663c3cfb6dcfbee603a071a7e3cf48c95c30869ed81c5fcf21c8"
 
diff --git a/recipes-core/antlr/antlr_2.7.7.bb b/recipes-core/antlr/antlr_2.7.7.bb
index d744201..31769c9 100644
--- a/recipes-core/antlr/antlr_2.7.7.bb
+++ b/recipes-core/antlr/antlr_2.7.7.bb
@@ -26,7 +26,6 @@ do_install:class-native() {
     install -m 0755 ${WORKDIR}/runantlr ${D}${bindir}/
 }
 
-SRC_URI[md5sum] = "01cc9a2a454dd33dcd8c856ec89af090"
 SRC_URI[sha256sum] = "853aeb021aef7586bda29e74a6b03006bcb565a755c86b66032d8ec31b67dbb9"
 
 BBCLASSEXTEND = "native"
diff --git a/recipes-core/bcel/bcel_5.2.bb b/recipes-core/bcel/bcel_5.2.bb
index 1fa6d59..7a8f46f 100644
--- a/recipes-core/bcel/bcel_5.2.bb
+++ b/recipes-core/bcel/bcel_5.2.bb
@@ -19,7 +19,6 @@ do_compile() {
   fastjar cf ${JARFILENAME} -C build .
 }
 
-SRC_URI[md5sum] = "905b7e718e30e7ca726530ecf106e532"
 SRC_URI[sha256sum] = "68039d59a38379d7b65ea3fc72276c43ba234776460e14361af35771bcaab295"
 
 BBCLASSEXTEND = "native"
diff --git a/recipes-core/cacao/cacao-initial-native_0.98.bb b/recipes-core/cacao/cacao-initial-native_0.98.bb
index 8432456..60c4d4f 100644
--- a/recipes-core/cacao/cacao-initial-native_0.98.bb
+++ b/recipes-core/cacao/cacao-initial-native_0.98.bb
@@ -40,5 +40,4 @@ do_configure:append() {
   sed -i -e "s|exec cacao \\$|exec cacao-initial \\$|" src/scripts/java.in
 }
 
-SRC_URI[md5sum] = "8b8907c8b925761c9410bcadb9705346"
 SRC_URI[sha256sum] = "cb9363add825cedf77764fc49a223aaf43f0a9f485b711ba8c92f16b13fff188"
diff --git a/recipes-core/classpath/classpath-initial-native_0.93.bb b/recipes-core/classpath/classpath-initial-native_0.93.bb
index 7bb1ca1..6963ef7 100644
--- a/recipes-core/classpath/classpath-initial-native_0.93.bb
+++ b/recipes-core/classpath/classpath-initial-native_0.93.bb
@@ -12,7 +12,6 @@ SRC_URI += " \
 	    file://autotools.patch \
 	    file://miscompilation.patch \
 	   "
-SRC_URI[md5sum] = "ffa9e9cac31c5acbf0ea9eff9efa923d"
 SRC_URI[sha256sum] = "df2d093612abd23fe67e9409d89bb2a8e79b1664fe2b2da40e1c8ed693e32945"
 
 EXTRA_OECONF += "\
diff --git a/recipes-core/classpath/classpath-native_0.99.bb b/recipes-core/classpath/classpath-native_0.99.bb
index ecf8c0a..6f37357 100644
--- a/recipes-core/classpath/classpath-native_0.99.bb
+++ b/recipes-core/classpath/classpath-native_0.99.bb
@@ -13,7 +13,6 @@ SRC_URI += " \
            file://0001-Fix-bad-implementation-of-compareTo-in-BigDecimal.patch \
            file://0002-Fix-BigDecimal.stripTrailingZeros-s-handling-of-0.patch \
            "
-SRC_URI[md5sum] = "0ae1571249172acd82488724a3b8acb4"
 SRC_URI[sha256sum] = "f929297f8ae9b613a1a167e231566861893260651d913ad9b6c11933895fecc8"
 
 EXTRA_OECONF += "\
diff --git a/recipes-core/classpath/classpath_0.99.bb b/recipes-core/classpath/classpath_0.99.bb
index f18ad1d..0f805b8 100644
--- a/recipes-core/classpath/classpath_0.99.bb
+++ b/recipes-core/classpath/classpath_0.99.bb
@@ -15,5 +15,4 @@ SRC_URI += " \
             file://aarch64.patch \
            "
 
-SRC_URI[md5sum] = "0ae1571249172acd82488724a3b8acb4"
 SRC_URI[sha256sum] = "f929297f8ae9b613a1a167e231566861893260651d913ad9b6c11933895fecc8"
diff --git a/recipes-core/classpathx/gnujaf_1.1.1.bb b/recipes-core/classpathx/gnujaf_1.1.1.bb
index 0bd8b57..0eacd01 100644
--- a/recipes-core/classpathx/gnujaf_1.1.1.bb
+++ b/recipes-core/classpathx/gnujaf_1.1.1.bb
@@ -30,7 +30,6 @@ do_compile() {
   fastjar cf ${JARFILENAME} -C build .
 }
 
-SRC_URI[md5sum] = "de50d7728e8140eb404f2b4554321f8c"
 SRC_URI[sha256sum] = "b1b5ef560d30fcb11fbf537246857d14110ce4eb2b200d4c54690472305d87b7"
 
 BBCLASSEXTEND = "native"
diff --git a/recipes-core/classpathx/gnumail_1.1.2.bb b/recipes-core/classpathx/gnumail_1.1.2.bb
index 22d0405..86a02b4 100644
--- a/recipes-core/classpathx/gnumail_1.1.2.bb
+++ b/recipes-core/classpathx/gnumail_1.1.2.bb
@@ -33,7 +33,6 @@ do_compile() {
     providers_jar=${P}-providers.jar
 }
 
-SRC_URI[md5sum] = "0a94ff4328ceb6a4131be96946976a33"
 SRC_URI[sha256sum] = "5eb09597a8f81bfc943206e3e0f45b963ba605a646051c353374f1b475bb9f04"
 
 BBCLASSEXTEND = "native"
diff --git a/recipes-core/classpathx/inetlib_1.1.1.bb b/recipes-core/classpathx/inetlib_1.1.1.bb
index 9146c9e..121559f 100644
--- a/recipes-core/classpathx/inetlib_1.1.1.bb
+++ b/recipes-core/classpathx/inetlib_1.1.1.bb
@@ -13,7 +13,6 @@ SRC_URI = "http://ftp.gnu.org/gnu/classpath/${BP}.tar.gz \
            file://datadir_java.patch \
            file://inetlib-missing-dependency-for-util_classes.patch \
           "
-SRC_URI[md5sum] = "aaa24be4bc8d172ac675be8bdfa636ee"
 SRC_URI[sha256sum] = "1b078a39e022f86e4e2c8189b4d2789a5da414e8f1cb285587b7800b950a44de"
 
 DEPENDS = "classpath-initial-native \
diff --git a/recipes-core/cup/cup_0.10k.bb b/recipes-core/cup/cup_0.10k.bb
index ce81453..fcd4ad2 100644
--- a/recipes-core/cup/cup_0.10k.bb
+++ b/recipes-core/cup/cup_0.10k.bb
@@ -41,7 +41,6 @@ PACKAGES = "${PN}"
 
 FILES:${PN} += "${datadir_java}"
 
-SRC_URI[md5sum] = "8b11edfec13c590ea443d0f0ae0da479"
 SRC_URI[sha256sum] = "7e6dc5be74ae56c7e86e69ad0ad88dae3b2847afa9e73a76635918a6b1eb75cd"
 
 BBCLASSEXTEND = "native"
diff --git a/recipes-core/ecj/libecj-bootstrap-native_3.6.2.bb b/recipes-core/ecj/libecj-bootstrap-native_3.6.2.bb
index 51dbca0..b9325f8 100644
--- a/recipes-core/ecj/libecj-bootstrap-native_3.6.2.bb
+++ b/recipes-core/ecj/libecj-bootstrap-native_3.6.2.bb
@@ -4,6 +4,5 @@ PR = "${INC_PR}.0"
 
 SRC_URI = "http://archive.eclipse.org/eclipse/downloads/drops/R-3.6.2-201102101200/ecjsrc-${PV}.zip"
 
-SRC_URI[md5sum] = "3f3ca1973dd7a21780525c9ffba7a263"
 SRC_URI[sha256sum] = "94f2095d38d71b414a593ec56847008bec267a926ec935959fecdde44f98467f"
 
diff --git a/recipes-core/fastjar/fastjar_0.98.bb b/recipes-core/fastjar/fastjar_0.98.bb
index 5b5a403..b4491f7 100644
--- a/recipes-core/fastjar/fastjar_0.98.bb
+++ b/recipes-core/fastjar/fastjar_0.98.bb
@@ -4,6 +4,5 @@ LIC_FILES_CHKSUM = "file://COPYING;md5=59530bdf33659b29e73d4adb9f9f6552"
 
 SRC_URI += "file://jartool.patch"
 
-SRC_URI[md5sum] = "d2d264d343d4d0e1575832cc1023c3bf"
 SRC_URI[sha256sum] = "f156abc5de8658f22ee8f08d7a72c88f9409ebd8c7933e9466b0842afeb2f145"
 
diff --git a/recipes-core/jacl/jacl_1.4.1.bb b/recipes-core/jacl/jacl_1.4.1.bb
index d510cc8..b15991e 100644
--- a/recipes-core/jacl/jacl_1.4.1.bb
+++ b/recipes-core/jacl/jacl_1.4.1.bb
@@ -23,7 +23,6 @@ do_compile() {
   fastjar cf ${JARFILENAME} -C build .
 }
 
-SRC_URI[md5sum] = "a7ec8300e8933164e854460c73ac6269"
 SRC_URI[sha256sum] = "0edac0a7d2253c29c44ccc92427fa9ad4ee81b6c82142e417f72399a8584b749"
 
 BBCLASSEXTEND = "native"
diff --git a/recipes-core/jakarta-commons/commons-beanutils_1.8.0.bb b/recipes-core/jakarta-commons/commons-beanutils_1.8.0.bb
index 2c5ecc2..4521ed8 100644
--- a/recipes-core/jakarta-commons/commons-beanutils_1.8.0.bb
+++ b/recipes-core/jakarta-commons/commons-beanutils_1.8.0.bb
@@ -11,5 +11,4 @@ RDEPENDS:${PN} = "libcommons-collections3-java libcommons-logging-java"
 
 CP = "commons-collections3 commons-logging"
 
-SRC_URI[md5sum] = "1bce3cfa4ae33c94686422e78abc0792"
 SRC_URI[sha256sum] = "aff3c8c772e4ff32f2d9a37a727a488583372e45535a3d5aad09662691851dcf"
diff --git a/recipes-core/jakarta-commons/commons-cli_1.1.bb b/recipes-core/jakarta-commons/commons-cli_1.1.bb
index a87097b..2b83a03 100644
--- a/recipes-core/jakarta-commons/commons-cli_1.1.bb
+++ b/recipes-core/jakarta-commons/commons-cli_1.1.bb
@@ -7,7 +7,6 @@ SUMMARY = "Java argument parsing helper classes"
 
 SRC_URI = "http://archive.apache.org/dist/commons/cli/source/${BP}-src.tar.gz"
 
-SRC_URI[md5sum] = "ccc1aa194132e2387557bbb7f65391f4"
 SRC_URI[sha256sum] = "929eb140c136673e7f5029cd206c81b3c1f5e66bba0dfdcd021b9dd5596356d2"
 
 BBCLASSEXTEND = "native"
diff --git a/recipes-core/jakarta-commons/commons-codec_1.3.bb b/recipes-core/jakarta-commons/commons-codec_1.3.bb
index fa74f6c..cfaada5 100644
--- a/recipes-core/jakarta-commons/commons-codec_1.3.bb
+++ b/recipes-core/jakarta-commons/commons-codec_1.3.bb
@@ -9,7 +9,6 @@ SRC_URI = "http://archive.apache.org/dist/commons/codec/source/${BP}-src.tar.gz"
 
 S = "${WORKDIR}/${BP}"
 
-SRC_URI[md5sum] = "af3c3acf618de6108d65fcdc92b492e1"
 SRC_URI[sha256sum] = "12effcf3fea025bd34edbfec60a6216ca453fb27e781d8e5783caf75fd33d90e"
 
 BBCLASSEXTEND = "native"
diff --git a/recipes-core/jakarta-commons/commons-collections3_3.2.2.bb b/recipes-core/jakarta-commons/commons-collections3_3.2.2.bb
index 0a53d09..2f23490 100644
--- a/recipes-core/jakarta-commons/commons-collections3_3.2.2.bb
+++ b/recipes-core/jakarta-commons/commons-collections3_3.2.2.bb
@@ -10,5 +10,4 @@ SRC_URI = "http://www.apache.org/dist/commons/collections/source/commons-collect
 S = "${WORKDIR}/commons-collections-${PV}-src"
 
 
-SRC_URI[md5sum] = "776b51a51312c1854ad8f6d344a47cda"
 SRC_URI[sha256sum] = "070d94fe77969d8949bd129a618e6a7bee6b83b5b5db3ef3f983395a5428b914"
diff --git a/recipes-core/jakarta-commons/commons-collections_2.1.1.bb b/recipes-core/jakarta-commons/commons-collections_2.1.1.bb
index 4d100a7..898a7df 100644
--- a/recipes-core/jakarta-commons/commons-collections_2.1.1.bb
+++ b/recipes-core/jakarta-commons/commons-collections_2.1.1.bb
@@ -7,5 +7,4 @@ DESCRIPTION = "A set of abstract data type interfaces and implementations that o
 SRC_URI = "http://archive.apache.org/dist/commons/collections/source/${BP}-src.tar.gz"
 
 
-SRC_URI[md5sum] = "3fc2e8f9d0647074cba992b534ecf6df"
 SRC_URI[sha256sum] = "73eb5907a31c8770480c70f6a6a8d9a9a2ffe602e1b461c045cff51ace4cab2a"
diff --git a/recipes-core/jakarta-commons/commons-digester_1.8.bb b/recipes-core/jakarta-commons/commons-digester_1.8.bb
index de264b8..7e595ee 100644
--- a/recipes-core/jakarta-commons/commons-digester_1.8.bb
+++ b/recipes-core/jakarta-commons/commons-digester_1.8.bb
@@ -13,5 +13,4 @@ CP = "commons-logging commons-beanutils"
 
 FINDARGS = "-name '*.dtd'"
 
-SRC_URI[md5sum] = "689f41905a68c67f7231f9afbb3e2147"
 SRC_URI[sha256sum] = "d9a965c82828a881d2ab6256fba7076f62815a9545b3af9d553dc5271577182b"
diff --git a/recipes-core/jakarta-commons/commons-discovery_0.4.bb b/recipes-core/jakarta-commons/commons-discovery_0.4.bb
index aa87349..60cf683 100644
--- a/recipes-core/jakarta-commons/commons-discovery_0.4.bb
+++ b/recipes-core/jakarta-commons/commons-discovery_0.4.bb
@@ -12,5 +12,4 @@ RDEPENDS:${PN} = "libcommons-logging-java"
 
 CP = "commons-logging"
 
-SRC_URI[md5sum] = "1275ad4c6ce54b9323269e30dc42dd0e"
 SRC_URI[sha256sum] = "596242302be4f0502073f5a934c608289bba6221591e7dbea53ce629f67498a3"
diff --git a/recipes-core/jakarta-commons/commons-el_1.0.bb b/recipes-core/jakarta-commons/commons-el_1.0.bb
index bb4c35b..b93b68f 100644
--- a/recipes-core/jakarta-commons/commons-el_1.0.bb
+++ b/recipes-core/jakarta-commons/commons-el_1.0.bb
@@ -16,5 +16,4 @@ FINDARGS = "\( -name '*.properties' -or -name '*.jj' \)"
 
 
 
-SRC_URI[md5sum] = "25038283a0b5f638db5e891295d20020"
 SRC_URI[sha256sum] = "3c9bdded6073563aaaddc9ad7c7387b242dc03cc385381503026b665a366c2c6"
diff --git a/recipes-core/jakarta-commons/commons-fileupload_1.2.1.bb b/recipes-core/jakarta-commons/commons-fileupload_1.2.1.bb
index 395fa15..71a866b 100644
--- a/recipes-core/jakarta-commons/commons-fileupload_1.2.1.bb
+++ b/recipes-core/jakarta-commons/commons-fileupload_1.2.1.bb
@@ -16,5 +16,4 @@ CP = "commons-beanutils commons-io servlet-2.3"
 COMPILE_FINDARGS = "-name '*.java' -not -wholename '*portlet*'"
 
 
-SRC_URI[md5sum] = "c2bdb9264aec564e3f4fbbdf4344a844"
 SRC_URI[sha256sum] = "08905cb3a0db4f7fa67f3b579b2c481060334d50d7f913c6974c7513243152f5"
diff --git a/recipes-core/jakarta-commons/commons-httpclient_3.1.bb b/recipes-core/jakarta-commons/commons-httpclient_3.1.bb
index a6fb53b..b4e5e2a 100644
--- a/recipes-core/jakarta-commons/commons-httpclient_3.1.bb
+++ b/recipes-core/jakarta-commons/commons-httpclient_3.1.bb
@@ -15,7 +15,6 @@ RDEPENDS:${PN}:class-native = ""
 
 CP = "commons-logging commons-codec"
 
-SRC_URI[md5sum] = "2c9b0f83ed5890af02c0df1c1776f39b"
 SRC_URI[sha256sum] = "f9a496d3418b0e15894fb351652cd4fa5ca434ebfc3ce3bb8da40defd8b097f2"
 
 BBCLASSEXTEND = "native"
diff --git a/recipes-core/jakarta-commons/commons-io_1.4.bb b/recipes-core/jakarta-commons/commons-io_1.4.bb
index f1dbc88..799a9d4 100644
--- a/recipes-core/jakarta-commons/commons-io_1.4.bb
+++ b/recipes-core/jakarta-commons/commons-io_1.4.bb
@@ -7,5 +7,4 @@ DESCRIPTION = "Java library with utility classes, stream implementations, file f
 
 SRC_URI = "http://archive.apache.org/dist/commons/io/source/${BP}-src.tar.gz"
 
-SRC_URI[md5sum] = "24b228f2d0c40ffed9204cdab015bccf"
 SRC_URI[sha256sum] = "eca986497f7b4d1b1ec41821b1b5df827bb31fc14833e4449cfa8bcd5d7f29bb"
diff --git a/recipes-core/jakarta-commons/commons-lang_2.4.bb b/recipes-core/jakarta-commons/commons-lang_2.4.bb
index 48cc291..e0c3736 100644
--- a/recipes-core/jakarta-commons/commons-lang_2.4.bb
+++ b/recipes-core/jakarta-commons/commons-lang_2.4.bb
@@ -8,5 +8,4 @@ DESCRIPTION = "Set of Java classes that provide helper methods for the standard
 SRC_URI = "http://archive.apache.org/dist/commons/lang/source/${BP}-src.tar.gz"
 
 
-SRC_URI[md5sum] = "625ff5f2f968dd908bca43c9469d6e6b"
 SRC_URI[sha256sum] = "2445238cd0eb167e99a1147394f61325490559f3df7e7e8f628043fb70cbf2f4"
diff --git a/recipes-core/jakarta-commons/commons-logging_1.1.1.bb b/recipes-core/jakarta-commons/commons-logging_1.1.1.bb
index 7aa2372..6de3228 100644
--- a/recipes-core/jakarta-commons/commons-logging_1.1.1.bb
+++ b/recipes-core/jakarta-commons/commons-logging_1.1.1.bb
@@ -12,7 +12,6 @@ CP = "log4j-1.2 servlet-2.3 logkit"
 
 COMPILE_FINDARGS = "-name '*.java' -and -not -name '*Avalon*'"
 
-SRC_URI[md5sum] = "e5cfa8cca13152d7545fde6b1783c60a"
 SRC_URI[sha256sum] = "b49a79fa78ebfae15dc46ae6f0144fee6b94ab608a25518c54609d3419909eb2"
 
 BBCLASSEXTEND = "native"
diff --git a/recipes-core/jakarta-commons/commons-net_1.4.1.bb b/recipes-core/jakarta-commons/commons-net_1.4.1.bb
index ba62ebc..bffbbae 100644
--- a/recipes-core/jakarta-commons/commons-net_1.4.1.bb
+++ b/recipes-core/jakarta-commons/commons-net_1.4.1.bb
@@ -18,7 +18,6 @@ CP = "oro"
 
 MAINSOURCES = "src/java/org"
 
-SRC_URI[md5sum] = "ccbb3f67b55e8a7a676499db4386673c"
 SRC_URI[sha256sum] = "fdea779f261f70b9bbec40121c830b11e3e63b6188f662f95505045ff8d44add"
 
 BBCLASSEXTEND = "native"
diff --git a/recipes-core/jakarta-commons/commons-pool_1.4.bb b/recipes-core/jakarta-commons/commons-pool_1.4.bb
index 95c8cf1..824b772 100644
--- a/recipes-core/jakarta-commons/commons-pool_1.4.bb
+++ b/recipes-core/jakarta-commons/commons-pool_1.4.bb
@@ -7,5 +7,4 @@ SUMMARY = "Java Object-pooling API"
 
 SRC_URI = "http://archive.apache.org/dist/commons/pool/source/${BP}-src.tar.gz"
 
-SRC_URI[md5sum] = "4dc988ee16e1471799af97763297b41b"
 SRC_URI[sha256sum] = "ca4452f2a2ce2daf6eaa1743ded2d3b36013200c48e3f2117b65584ca5cc1d9b"
diff --git a/recipes-core/jakarta-libs/bsf_2.4.0.bb b/recipes-core/jakarta-libs/bsf_2.4.0.bb
index 22d9320..a38c335 100644
--- a/recipes-core/jakarta-libs/bsf_2.4.0.bb
+++ b/recipes-core/jakarta-libs/bsf_2.4.0.bb
@@ -27,7 +27,6 @@ do_compile() {
 }
 
 
-SRC_URI[md5sum] = "7e58b2a009c0f70ab36bbef420b25c07"
 SRC_URI[sha256sum] = "5ab58cf5738c144f4d85a4a442c2f33be2c4c502dca6e29e0c570c2a51ae6ae9"
 
 BBCLASSEXTEND = "native"
diff --git a/recipes-core/jakarta-libs/log4j1.2_1.2.17.bb b/recipes-core/jakarta-libs/log4j1.2_1.2.17.bb
index 2f04e96..bd8c9d8 100644
--- a/recipes-core/jakarta-libs/log4j1.2_1.2.17.bb
+++ b/recipes-core/jakarta-libs/log4j1.2_1.2.17.bb
@@ -29,7 +29,6 @@ do_compile() {
   fastjar cf ${JARFILENAME} -C build .
 }
 
-SRC_URI[md5sum] = "8218714e41ee0c6509dcfeafa2e1f53f"
 SRC_URI[sha256sum] = "a528e3771ee6234661b5eb0fa02e14faee89dfec38de94088c163ddf2a0a8663"
 
 BBCLASSEXTEND = "native"
diff --git a/recipes-core/jakarta-libs/logkit_1.2.2.bb b/recipes-core/jakarta-libs/logkit_1.2.2.bb
index 8b4de11..c3d83a5 100644
--- a/recipes-core/jakarta-libs/logkit_1.2.2.bb
+++ b/recipes-core/jakarta-libs/logkit_1.2.2.bb
@@ -26,7 +26,6 @@ do_compile() {
   fastjar cf ${JARFILENAME} -C build .
 }
 
-SRC_URI[md5sum] = "996ee20d6b5785ab71f4692f64d10f9c"
 SRC_URI[sha256sum] = "2c81edc87571fbd05797da7f65515e089c62cbb735bdbd10f93e29bd3aa3ddb8"
 
 BBCLASSEXTEND = "native"
diff --git a/recipes-core/jakarta-libs/oro_2.0.8.bb b/recipes-core/jakarta-libs/oro_2.0.8.bb
index 97e29d0..80efd49 100644
--- a/recipes-core/jakarta-libs/oro_2.0.8.bb
+++ b/recipes-core/jakarta-libs/oro_2.0.8.bb
@@ -18,7 +18,6 @@ do_compile() {
   fastjar cf ${JARFILENAME} -C build org
 }
 
-SRC_URI[md5sum] = "6f7690c6ba9750e3cbb8ebd10078a79a"
 SRC_URI[sha256sum] = "4c4f3c7c479994c3ce09f542d4fbdc03eed58a2d7f320d32f2baf238b5b6f566"
 
 BBCLASSEXTEND = "native"
diff --git a/recipes-core/jakarta-libs/poi_3.0.bb b/recipes-core/jakarta-libs/poi_3.0.bb
index e33f2f2..3733c3c 100644
--- a/recipes-core/jakarta-libs/poi_3.0.bb
+++ b/recipes-core/jakarta-libs/poi_3.0.bb
@@ -26,5 +26,4 @@ do_compile() {
   fastjar -C build -c -f ${JARFILENAME} .
 }
 
-SRC_URI[md5sum] = "1fb488c4061256197a667f1c480ffc33"
 SRC_URI[sha256sum] = "48a5aabb873d4cc654c95acf6576868d7a8a3ee97e1c6418e1d716698b6efa76"
diff --git a/recipes-core/jakarta-libs/regexp_1.5.bb b/recipes-core/jakarta-libs/regexp_1.5.bb
index 614da2a..40dec0a 100644
--- a/recipes-core/jakarta-libs/regexp_1.5.bb
+++ b/recipes-core/jakarta-libs/regexp_1.5.bb
@@ -18,7 +18,6 @@ do_compile() {
   fastjar cf ${JARFILENAME} -C build .
 }
 
-SRC_URI[md5sum] = "b941b8f4de297827f3211c2cb34af199"
 SRC_URI[sha256sum] = "79e80af8cbeb68ddad75a1aa6244d7acd62176bfd69bcdc0640d11177dcde97d"
 
 BBCLASSEXTEND = "native"
diff --git a/recipes-core/jamvm/jamvm-initial-native_1.4.5.bb b/recipes-core/jamvm/jamvm-initial-native_1.4.5.bb
index 7773409..6a34f31 100644
--- a/recipes-core/jamvm/jamvm-initial-native_1.4.5.bb
+++ b/recipes-core/jamvm/jamvm-initial-native_1.4.5.bb
@@ -43,7 +43,6 @@ do_install:append() {
   install -m 0755 ${WORKDIR}/java-initial ${D}${bindir}/
 }
 
-SRC_URI[md5sum] = "3f538bab6e1c77aed331e5e71f754f5b"
 SRC_URI[sha256sum] = "f329d1c8f42c06b53a3e82763d33900b100b8e9acd7afe02f7583c51253fd6e5"
 # shared state for jamvm-native does not work
 # since the paths are hardcoded
diff --git a/recipes-core/javasqlite/javasqlite_20150419.bb b/recipes-core/javasqlite/javasqlite_20150419.bb
index 45262e2..9a6518d 100644
--- a/recipes-core/javasqlite/javasqlite_20150419.bb
+++ b/recipes-core/javasqlite/javasqlite_20150419.bb
@@ -23,7 +23,6 @@ FILES:${PN} +="/usr/share"
 
 PARALLEL_MAKE = "-j 1"
 
-SRC_URI[md5sum] = "242e384c1cd863d6996a35cf8c1c1e97"
 SRC_URI[sha256sum] = "b6b26e2c1a2174f5525d904eb3ff698c3f7089f0d4b4c84cf6121da08c8d801f"
 
 EXTRA_OECONF = " \
diff --git a/recipes-core/jcraft/jsch_0.1.40.bb b/recipes-core/jcraft/jsch_0.1.40.bb
index aeb04b4..7fa8571 100644
--- a/recipes-core/jcraft/jsch_0.1.40.bb
+++ b/recipes-core/jcraft/jsch_0.1.40.bb
@@ -22,7 +22,6 @@ do_compile() {
   fastjar cf ${JARFILENAME} -C build .
 }
 
-SRC_URI[md5sum] = "b59cec19a487e95aed68378976b4b566"
 SRC_URI[sha256sum] = "ca9d2ae08fd7a8983fb00d04f0f0c216a985218a5eb364ff9bee73870f28e097"
 
 CVE_STATUS[CVE-2016-5725] = "not-applicable-platform: Issue only applies on Windows"
diff --git a/recipes-core/jcraft/jzlib_1.0.7.bb b/recipes-core/jcraft/jzlib_1.0.7.bb
index 1e34d2c..65cced8 100644
--- a/recipes-core/jcraft/jzlib_1.0.7.bb
+++ b/recipes-core/jcraft/jzlib_1.0.7.bb
@@ -16,7 +16,6 @@ do_compile() {
   fastjar cf ${JARFILENAME} -C build .
 }
 
-SRC_URI[md5sum] = "3c52a0afb970e8a1fb2d34f30d330a83"
 SRC_URI[sha256sum] = "20923a3f771a14c58c8cddfff2b589d568aff09f8a931919dc63ddaabb32407a"
 
 BBCLASSEXTEND = "native"
diff --git a/recipes-core/jikes/jikes_1.22.bb b/recipes-core/jikes/jikes_1.22.bb
index 3e83ff8..b7fa7fa 100644
--- a/recipes-core/jikes/jikes_1.22.bb
+++ b/recipes-core/jikes/jikes_1.22.bb
@@ -32,5 +32,4 @@ ALTERNATIVE:${PN} = "javac"
 ALTERNATIVE_LINK = "/usr/bin/javac"
 ALTERNATIVE_TARGET = "${bindir}/javac.jikes"
 
-SRC_URI[md5sum] = "cda958c7fef6b43b803e1d1ef9afcb85"
 SRC_URI[sha256sum] = "0cb02c763bc441349f6d38cacd52adf762302cce3a08e269f1f75f726e6e14e3"
diff --git a/recipes-core/jlex/jlex_1.2.6.bb b/recipes-core/jlex/jlex_1.2.6.bb
index 48ec357..5c8d9ee 100644
--- a/recipes-core/jlex/jlex_1.2.6.bb
+++ b/recipes-core/jlex/jlex_1.2.6.bb
@@ -44,7 +44,6 @@ PACKAGES = "${PN}"
 
 FILES:${PN} += "${datadir_java}"
 
-SRC_URI[md5sum] = "fe0cff5db3e2f0f5d67a153cf6c783af"
 SRC_URI[sha256sum] = "aeebaece3b3a53972bb0ba0f810540386c267070ee9dca6ffa43c6ff74a54bd7"
 
 BBCLASSEXTEND = "native"
diff --git a/recipes-core/junit/junit4_4.3.1.bb b/recipes-core/junit/junit4_4.3.1.bb
index b2cd4d9..89517cb 100644
--- a/recipes-core/junit/junit4_4.3.1.bb
+++ b/recipes-core/junit/junit4_4.3.1.bb
@@ -23,7 +23,6 @@ do_compile() {
   fastjar -C build -c -f ${JARFILENAME} .
 }
 
-SRC_URI[md5sum] = "170f9645a41398388e8553b32ff5f630"
 SRC_URI[sha256sum] = "57d1e49ee3fd0dbdc0a68a852925c973af5c30b1725b6aa63bfb42df6f7c3349"
 
 BBCLASSEXTEND = "native"
diff --git a/recipes-core/junit/junit_3.8.2.bb b/recipes-core/junit/junit_3.8.2.bb
index 57dd459..988101f 100644
--- a/recipes-core/junit/junit_3.8.2.bb
+++ b/recipes-core/junit/junit_3.8.2.bb
@@ -36,7 +36,6 @@ do_compile() {
   fastjar cf ${JARFILENAME} -C build .
 }
 
-SRC_URI[md5sum] = "9b8963ba2147a64bd5f1574b6fd289cb"
 SRC_URI[sha256sum] = "aae23d20e6f4dc45b4bf0b10fedcbd209c100342a0cafce1aa07d2da6da1f24a"
 
 BBCLASSEXTEND = "native"
diff --git a/recipes-core/libmatthew/libmatthew_0.8.bb b/recipes-core/libmatthew/libmatthew_0.8.bb
index c4ace08..1cf50c7 100644
--- a/recipes-core/libmatthew/libmatthew_0.8.bb
+++ b/recipes-core/libmatthew/libmatthew_0.8.bb
@@ -7,6 +7,5 @@ LIC_FILES_CHKSUM = "file://COPYING;md5=48a42f2f9747f02bf40a0bce2655b509"
 SRC_URI = "http://pkgs.fedoraproject.org/repo/pkgs/libmatthew-java/libmatthew-java-0.8.tar.gz/8455b8751083ce25c99c2840609271f5/libmatthew-java-${PV}.tar.gz \
           "
 #           file://Makefile-0.7.patch"
-SRC_URI[md5sum] = "8455b8751083ce25c99c2840609271f5"
 SRC_URI[sha256sum] = "05d1d3d9b5e33bd3642102aae10bba904e296c5c01a10854200ad4df349c8dfa"
 
diff --git a/recipes-core/servlet-api/jsp2.0_5.5.26.bb b/recipes-core/servlet-api/jsp2.0_5.5.26.bb
index ac8617c..3d9f4da 100644
--- a/recipes-core/servlet-api/jsp2.0_5.5.26.bb
+++ b/recipes-core/servlet-api/jsp2.0_5.5.26.bb
@@ -43,5 +43,4 @@ do_compile() {
   fastjar -C build -c -m src/etc/manifest -f ${JARFILENAME} .
 }
 
-SRC_URI[md5sum] = "642b6526354cb18c5b5d77ebef8109ae"
 SRC_URI[sha256sum] = "ddc677d7391c438e6102d0b3e9653eaca661344ef74b0260c1f488340d660395"
diff --git a/recipes-core/servlet-api/servlet2.3_4.1.37.bb b/recipes-core/servlet-api/servlet2.3_4.1.37.bb
index 996f93b..dceece6 100644
--- a/recipes-core/servlet-api/servlet2.3_4.1.37.bb
+++ b/recipes-core/servlet-api/servlet2.3_4.1.37.bb
@@ -43,7 +43,6 @@ do_compile() {
   fastjar cfm ${JARFILENAME} src/etc/manifest -C build .
 }
 
-SRC_URI[md5sum] = "fe50177a25a084ad1abf4a201d08c2a6"
 SRC_URI[sha256sum] = "65e4cc9d3ea4a7f30044bfd6c660c772adb75ac152d775342deb6049a0d19d74"
 
 BBCLASSEXTEND = "native"
diff --git a/recipes-core/servlet-api/servlet2.4_5.5.26.bb b/recipes-core/servlet-api/servlet2.4_5.5.26.bb
index 7424673..eb2f769 100644
--- a/recipes-core/servlet-api/servlet2.4_5.5.26.bb
+++ b/recipes-core/servlet-api/servlet2.4_5.5.26.bb
@@ -39,5 +39,4 @@ do_compile() {
   fastjar -C build -c -m src/etc/manifest -f ${JARFILENAME} .
 }
 
-SRC_URI[md5sum] = "642b6526354cb18c5b5d77ebef8109ae"
 SRC_URI[sha256sum] = "ddc677d7391c438e6102d0b3e9653eaca661344ef74b0260c1f488340d660395"
diff --git a/recipes-core/xerces-j/xerces-j_2.11.0.bb b/recipes-core/xerces-j/xerces-j_2.11.0.bb
index 45d3c43..56ffe97 100644
--- a/recipes-core/xerces-j/xerces-j_2.11.0.bb
+++ b/recipes-core/xerces-j/xerces-j_2.11.0.bb
@@ -63,7 +63,6 @@ do_compile() {
 
 }
 
-SRC_URI[md5sum] = "d01fc11eacbe43b45681cb85ac112ebf"
 SRC_URI[sha256sum] = "f59a5ef7b51bd883f2e9bda37a9360692e6c5e439b98d9b6ac1953e1f98b0680"
 
 BBCLASSEXTEND = "native"
diff --git a/recipes-core/xml-commons/jaxp1.3_1.4.01.bb b/recipes-core/xml-commons/jaxp1.3_1.4.01.bb
index 98cb077..7965bb8 100644
--- a/recipes-core/xml-commons/jaxp1.3_1.4.01.bb
+++ b/recipes-core/xml-commons/jaxp1.3_1.4.01.bb
@@ -27,7 +27,6 @@ do_compile() {
   fastjar cfm ${JARFILENAME} manifest.commons -C build .
 }
 
-SRC_URI[md5sum] = "2fea8e97a5d4d1a24bd05f5f62f3e04e"
 SRC_URI[sha256sum] = "d34bd88dc89c5c1ed2545ec5c61e4606fc28beb200a6fecf8c3ed17694181866"
 
 BBCLASSEXTEND = "native"
diff --git a/recipes-core/xml-commons/jdom_1.1.3.bb b/recipes-core/xml-commons/jdom_1.1.3.bb
index acd2ae1..c7b42f1 100644
--- a/recipes-core/xml-commons/jdom_1.1.3.bb
+++ b/recipes-core/xml-commons/jdom_1.1.3.bb
@@ -9,7 +9,6 @@ HOMEPAGE = "http://jdom.org/"
 DEPENDS = "fastjar-native virtual/javac-native jaxen"
 
 SRC_URI = "http://www.jdom.org/dist/source/archive/jdom-${PV}.tar.gz"
-SRC_URI[md5sum] = "dc8391e84cfdb170fcd8279aa370019f"
 SRC_URI[sha256sum] = "d471718c4ac7a1a2f10715b93cb3fcd2ecbab60384b73ad1c089712e47bd8d1f"
 
 PACKAGE_ARCH = "${TUNE_PKGARCH}"
diff --git a/recipes-core/xml-commons/xml-commons-resolver1.1_1.2.bb b/recipes-core/xml-commons/xml-commons-resolver1.1_1.2.bb
index 42ce703..0fafcea 100644
--- a/recipes-core/xml-commons/xml-commons-resolver1.1_1.2.bb
+++ b/recipes-core/xml-commons/xml-commons-resolver1.1_1.2.bb
@@ -36,7 +36,6 @@ do_compile() {
   fastjar cfm ${JARFILENAME} src/manifest.resolver -C build  org
 }
 
-SRC_URI[md5sum] = "46d52acdb67ba60f0156043f30108766"
 SRC_URI[sha256sum] = "55dbe7bd56452c175320ce9a97b752252c5537427221323c72e9b9c1ac221efe"
 
 BBCLASSEXTEND = "native"
diff --git a/recipes-core/xml-commons/xpp2_2.1.10.bb b/recipes-core/xml-commons/xpp2_2.1.10.bb
index a76cc4e..170f4ff 100644
--- a/recipes-core/xml-commons/xpp2_2.1.10.bb
+++ b/recipes-core/xml-commons/xpp2_2.1.10.bb
@@ -30,5 +30,4 @@ do_compile() {
     fastjar -C build-oe -c -f ${JARFILENAME} .
 }
 
-SRC_URI[md5sum] = "865ca4e2496c215d301b57450137626f"
 SRC_URI[sha256sum] = "ad82569b809e29c19b8223feaa12923f97bb4bbc942ff985857f9d853db489cf"
diff --git a/recipes-core/xml-commons/xpp3_1.1.3.4.O.bb b/recipes-core/xml-commons/xpp3_1.1.3.4.O.bb
index 09ef1f1..ce344c4 100644
--- a/recipes-core/xml-commons/xpp3_1.1.3.4.O.bb
+++ b/recipes-core/xml-commons/xpp3_1.1.3.4.O.bb
@@ -46,5 +46,4 @@ do_install:append() {
 FILES:libxpp3-xpath-java = "${datadir}/java/xpp3-xpath*"
 
 
-SRC_URI[md5sum] = "e1b6aeaad1cd06e64568aae1a507d5c6"
 SRC_URI[sha256sum] = "404c0cd332f54ecf9807dc86d365c17dcffab669994c9dcbbad31fbc4b59f811"
diff --git a/recipes-extended/dbus/dbus-java_2.7.bb b/recipes-extended/dbus/dbus-java_2.7.bb
index 0e5ae92..fc42bcd 100644
--- a/recipes-extended/dbus/dbus-java_2.7.bb
+++ b/recipes-extended/dbus/dbus-java_2.7.bb
@@ -18,7 +18,6 @@ PACKAGE_ARCH = "${TUNE_PKGARCH}"
 LIC_FILES_CHKSUM = "file://COPYING;md5=72cc739fb93ae32741edbae802490e92"
 SRC_URI = "http://dbus.freedesktop.org/releases/dbus-java/dbus-java-${PV}.tar.gz"
 
-SRC_URI[md5sum] = "8b8470db5cd657591bac245e3b6e18e4"
 SRC_URI[sha256sum] = "be404ea36284d938646192d0ee42e146853064217d4e3aaf89b56bd351ebca33"
 
 S = "${WORKDIR}/dbus-java-${PV}"
diff --git a/recipes-extended/hsqldb/hsqldb_1.8.0.10.bb b/recipes-extended/hsqldb/hsqldb_1.8.0.10.bb
index 6c34106..b1769f8 100644
--- a/recipes-extended/hsqldb/hsqldb_1.8.0.10.bb
+++ b/recipes-extended/hsqldb/hsqldb_1.8.0.10.bb
@@ -36,6 +36,5 @@ do_compile() {
     fastjar -C classes -c -f ${JARFILENAME} .
 }
 
-SRC_URI[md5sum] = "17410483b5b5f267aa18b7e00b65e6e0"
 SRC_URI[sha256sum] = "d30b13f4ba2e3b6a2d4f020c0dee0a9fb9fc6fbcc2d561f36b78da4bf3802370"
 
diff --git a/recipes-extended/rxtx/rxtx_2.2.0.bb b/recipes-extended/rxtx/rxtx_2.2.0.bb
index 27935bc..ade4b96 100644
--- a/recipes-extended/rxtx/rxtx_2.2.0.bb
+++ b/recipes-extended/rxtx/rxtx_2.2.0.bb
@@ -22,7 +22,6 @@ SRC_URI = "http://rxtx.qbang.org/pub/rxtx/rxtx-2.2pre2.zip \
            file://0001-Support-Freescale-i.MX-serial-ports.patch \
            file://javapath.patch"
 
-SRC_URI[md5sum] = "7eedb18e3f33a427e2b0e9be8ce3f94c"
 SRC_URI[sha256sum] = "3c30373e760f444def3650c76c5a00ae12fb1d860ec008750d084f4880495b03"
 
 S = "${WORKDIR}/rxtx-2.2pre2"
diff --git a/recipes-extended/xmlpull/xmlpull_1.1.3.4c.bb b/recipes-extended/xmlpull/xmlpull_1.1.3.4c.bb
index 4f8c9f8..85e970c 100644
--- a/recipes-extended/xmlpull/xmlpull_1.1.3.4c.bb
+++ b/recipes-extended/xmlpull/xmlpull_1.1.3.4c.bb
@@ -25,6 +25,5 @@ do_install() {
     cp build/lib/${PN}_1_1_3_4c.jar ${JAR}
 }
 
-SRC_URI[md5sum] = "34c8a093e5678dd633411dfea88f8558"
 SRC_URI[sha256sum] = "e17aa1a26119966258a3656a262bbba0f0b036eecb6d9bf192cf4b497686f4c3"
 
-- 
2.43.0


