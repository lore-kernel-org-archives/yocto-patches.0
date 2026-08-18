Return-Path: <esa.jaaskela@suomi24.fi>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF3DC5DF81
	for <webhook@archiver.kernel.org>; Tue, 18 Aug 2026 19:34:20 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17122.1787081650941046534
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 18 Aug 2026 12:34:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@suomi24.fi header.s=MBO0001 header.b=Ehzyargd;
 spf=pass (domain: suomi24.fi, ip: 80.241.56.172, mailfrom: esa.jaaskela@suomi24.fi)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hPfyk5h4GzMlQ0;
	Tue, 18 Aug 2026 21:34:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suomi24.fi; s=MBO0001;
	t=1787081646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GrtbWB7EWQl0IqFK98bSQRRQsE5+ET2oiIPHBZQuYpI=;
	b=EhzyargdbGAq+ifEyZrz5I6TF7WG4zv1q0Xym/hcHmxjBQl1ofVBsAEYqsUj4pQUCG0Q8L
	acChbXrmZ87jOfH+lOJdv1k4xKQNhdudrZsQojFMnfZ52lr8/sN2fSHsg/lO+UeNsuE8QQ
	tUYAx4C4am3Ukl9s4lem2iY9JPvhQ0+6DLWZlFFeauHIcgn6Y57x9AeVIeQLSj/7lPlf59
	NySMCK8kMY6iLNLmDkVgGp/cHOXjqUfFaI75x7zpyYvSyXyyed9Hmo7Lbvl+FzxauyGSf5
	iSSYaDVqQ/w0wrvsrxkE7zg3KPw0s/0IkF0LMmamcaduow2Yh8D3jNqiJtv8tQ==
From: Esa Jaaskela <esa.jaaskela@suomi24.fi>
To: yocto-patches@lists.yoctoproject.org
Cc: Esa Jaaskela <esa.jaaskela@suomi24.fi>
Subject: [meta-security][PATCH] aide: Fix unstable install task hash
Date: Tue, 18 Aug 2026 22:33:59 +0300
Message-ID: <20260818193359.1608995-1-esa.jaaskela@suomi24.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 18 Aug 2026 19:34:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4673

The installation task hash for the aide is marked as nostamp. This is
done because the native task installs files outside the sysroot, to the
Aide staging directory. Those files are not captured by
do_populate_sysroot, so they are missing whenever the task is skipped or
restored from sstate.

Install the required native contents to the sysroot, and then customise
and deploy the configuration file in the aide_init_db rootfs postprocess
function that utilizes the files. The configuration file needs to be
reset every time the function is run to avoid using stale
configurations.

Staging the native files through the sysroot makes the nostamp
unnecessary, so remove it along with the unstable task hash it caused.

Signed-off-by: Esa Jaaskela <esa.jaaskela@suomi24.fi>
---
 classes/aide-db-init.bbclass    | 11 +++++++++--
 recipes-ids/aide/aide_0.19.3.bb | 13 ++++---------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/classes/aide-db-init.bbclass b/classes/aide-db-init.bbclass
index 800006f..3fe2c27 100644
--- a/classes/aide-db-init.bbclass
+++ b/classes/aide-db-init.bbclass
@@ -31,6 +31,13 @@
 inherit aide-base=20
=20
 aide_init_db() {
+    install -d ${STAGING_AIDE_DIR}/lib/logs
+    rm -f ${STAGING_AIDE_DIR}/aide.conf ${STAGING_AIDE_DIR}/lib/aide.db =
${STAGING_AIDE_DIR}/lib/aide.db.gz ${STAGING_AIDE_DIR}/lib/logs/aide.log
+    install ${STAGING_DATADIR_NATIVE}/aide/aide.conf ${STAGING_AIDE_DIR}=
/
+
+    sed -i -s "s:\@\@define DBDIR.*:\@\@define DBDIR ${STAGING_AIDE_DIR}=
/lib:" ${STAGING_AIDE_DIR}/aide.conf
+    sed -i -e "s:\@\@define LOGDIR.*:\@\@define LOGDIR ${STAGING_AIDE_DI=
R}/lib/logs:" ${STAGING_AIDE_DIR}/aide.conf
+
     for dir in ${AIDE_INCLUDE_DIRS}; do
         echo "${IMAGE_ROOTFS}${dir} NORMAL" >> ${STAGING_AIDE_DIR}/aide.=
conf
     done
@@ -39,7 +46,7 @@ aide_init_db() {
     done
=20
=20
-    ${STAGING_AIDE_DIR}/bin/aide -c ${STAGING_AIDE_DIR}/aide.conf --init
+    ${STAGING_BINDIR_NATIVE}/aide -c ${STAGING_AIDE_DIR}/aide.conf --ini=
t
     gunzip ${STAGING_AIDE_DIR}/lib/aide.db.gz=20
     # strip out native path
     sed -i -e 's:${IMAGE_ROOTFS}::' ${STAGING_AIDE_DIR}/lib/aide.db
@@ -47,6 +54,6 @@ aide_init_db() {
     cp -f ${STAGING_AIDE_DIR}/lib/aide.db.gz ${IMAGE_ROOTFS}${libdir}/ai=
de
 }
=20
-EXTRA_IMAGEDEPENDS:append =3D " aide-native"
+do_rootfs[depends] +=3D "aide-native:do_populate_sysroot"
=20
 ROOTFS_POSTPROCESS_COMMAND:append =3D " aide_init_db;"
diff --git a/recipes-ids/aide/aide_0.19.3.bb b/recipes-ids/aide/aide_0.19=
.3.bb
index 68e3bfa..5daa295 100644
--- a/recipes-ids/aide/aide_0.19.3.bb
+++ b/recipes-ids/aide/aide_0.19.3.bb
@@ -31,8 +31,6 @@ PACKAGECONFIG[e2fsattrs] =3D "--with-e2fsattrs, --witho=
ut-e2fsattrs, e2fsprogs, e2
 PACKAGECONFIG[capabilities] =3D "--with-capabilities, --without-capabili=
ties, libcap, libcap"
 PACKAGECONFIG[posix-acl] =3D "--with-posix-acl, --without-posix-acl, acl=
, acl"
=20
-do_install[nostamp] =3D "1"
-
 do_install:append () {
     install -d ${D}${libdir}/${PN}/logs  =20
     install -d ${D}${sysconfdir}  =20
@@ -47,14 +45,11 @@ do_install:append () {
 }
=20
 do_install:class-native () {
-    install -d ${STAGING_AIDE_DIR}/bin
-    install -d ${STAGING_AIDE_DIR}/lib/logs
-
-    install ${B}/aide ${STAGING_AIDE_DIR}/bin
-    install ${UNPACKDIR}/aide.conf ${STAGING_AIDE_DIR}/
+    install -d ${D}${bindir}
+    install -d ${D}${datadir}/${BPN}
=20
-    sed -i -s "s:\@\@define DBDIR.*:\@\@define DBDIR ${STAGING_AIDE_DIR}=
/lib:" ${STAGING_AIDE_DIR}/aide.conf
-    sed -i -e "s:\@\@define LOGDIR.*:\@\@define LOGDIR ${STAGING_AIDE_DI=
R}/lib/logs:" ${STAGING_AIDE_DIR}/aide.conf
+    install ${B}/aide ${D}${bindir}
+    install ${UNPACKDIR}/aide.conf ${D}${datadir}/${BPN}/
 }
=20
 CONF_FILE =3D "${sysconfdir}/aide.conf"
--=20
2.47.3


