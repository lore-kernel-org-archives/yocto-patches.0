Return-Path: <ben.cownley@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265FED216B0
	for <webhook@archiver.kernel.org>; Tue, 15 Oct 2024 14:23:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.14891.1729002230594635038
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 15 Oct 2024 07:23:50 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ben.cownley@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63BC2FEC;
	Tue, 15 Oct 2024 07:24:19 -0700 (PDT)
Received: from e125927.manchester.arm.com (e125927.arm.com [10.32.102.160])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAF1E3F71E;
	Tue, 15 Oct 2024 07:23:48 -0700 (PDT)
From: Ben <Ben.Cownley@arm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Ben Cownley <ben.cownley@arm.com>
Subject: [PATCH 2/3] arm-systemready/oeqa: Add unattended installation testcase
Date: Tue, 15 Oct 2024 15:23:34 +0100
Message-Id: <20241015142335.62987-2-Ben.Cownley@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015142335.62987-1-Ben.Cownley@arm.com>
References: <20241015142335.62987-1-Ben.Cownley@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 15 Oct 2024 14:23:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/706

Add test for openSUSE unattended installation

Signed-off-by: Ben Cownley <ben.cownley@arm.com>
---
 .../arm_systemready_opensuse_unattended.py    | 42 +++++++++++++++++++
 .../arm-systemready-linux-distros-opensuse.bb |  2 +
 2 files changed, 44 insertions(+)
 create mode 100644 meta-arm-systemready/lib/oeqa/runtime/cases/arm_syste=
mready_opensuse_unattended.py

diff --git a/meta-arm-systemready/lib/oeqa/runtime/cases/arm_systemready_=
opensuse_unattended.py b/meta-arm-systemready/lib/oeqa/runtime/cases/arm_=
systemready_opensuse_unattended.py
new file mode 100644
index 00000000..aea8df3e
--- /dev/null
+++ b/meta-arm-systemready/lib/oeqa/runtime/cases/arm_systemready_opensus=
e_unattended.py
@@ -0,0 +1,42 @@
+from oeqa.runtime.case import OERuntimeTestCase
+
+class SystemReadyOpenSUSEUnattendedTest(OERuntimeTestCase):
+    def setUp(self):
+        super().setUp()
+        self.console =3D self.target.DEFAULT_CONSOLE
+
+    def test_opensuse_unattended(self):
+        # Turn on the FVP.
+        self.target.transition('on')
+
+        # Timeout value =3D elapsed time * 2; where elapsed time was col=
lected
+        # from the elapsed time in the log.do_testimage for each functio=
n after
+        # the build is finished on the development machine.
+        self.target.expect(self.console,
+                           'Booting `Installation\'',
+                           timeout=3D(2 * 60))
+        bb.plain('Installation status: Loading the kernel, initrd and ba=
sic drivers...')
+
+        self.target.expect(self.console,
+                           'Starting hardware detection...',
+                           timeout=3D(40 * 60))
+        bb.plain('Installation status: Starting hardware detection...')
+
+        self.target.expect(self.console,
+                           'Loading Installation System',
+                           timeout=3D(60 * 60))
+        bb.plain('Installation status: Loading Installation System...')
+
+        self.target.expect(self.console,
+                           'Starting Installer',
+                           timeout=3D(40 * 60))
+        bb.plain('Installation status: Performing Installation...')
+
+        self.target.expect(self.console,
+                           'Finishing Configuration',
+                           timeout=3D(15 * 60 * 60))
+        bb.plain('Installation status: Finishing Configuration...')
+
+        # Waiting till the installation is finished.
+        self.target.expect(self.console, r'.*login: ', timeout=3D(6 * 60=
 * 60))
+        bb.plain('Installation status: openSUSE installation finished su=
ccessfully.')
diff --git a/meta-arm-systemready/recipes-test/arm-systemready-linux-dist=
ros/arm-systemready-linux-distros-opensuse.bb b/meta-arm-systemready/reci=
pes-test/arm-systemready-linux-distros/arm-systemready-linux-distros-open=
suse.bb
index 7d02a258..33f20587 100644
--- a/meta-arm-systemready/recipes-test/arm-systemready-linux-distros/arm=
-systemready-linux-distros-opensuse.bb
+++ b/meta-arm-systemready/recipes-test/arm-systemready-linux-distros/arm=
-systemready-linux-distros-opensuse.bb
@@ -73,6 +73,8 @@ BUILD_NO =3D "491.1"
 SRC_URI =3D "https://download.opensuse.org/distribution/leap/${PV}/iso/o=
penSUSE-Leap-${PV}-${ISO_TYPE}-aarch64-Build${BUILD_NO}-Media.iso;unpack=3D=
0;downloadfilename=3D${ISO_IMAGE_NAME}.iso"
 SRC_URI[sha256sum] =3D "456cc4f99b044429d8a89bd302c06e9e382d6ac4dc590139=
a7096ebb54f5357b"
=20
+TEST_SUITES =3D "${@oe.utils.vartrue("DISTRO_UNATTENDED_INST_TESTS", "ar=
m_systemready_opensuse_unattended", "", d)}"
+
 ISO_LABEL =3D "${@oe.utils.vartrue("DISTRO_UNATTENDED_INST_TESTS", "OEMD=
RV", "", d)}"
 BOOT_CATALOG =3D "${@oe.utils.vartrue("DISTRO_UNATTENDED_INST_TESTS", "b=
oot.catalog", "", d)}"
 BOOT_IMAGE =3D "${@oe.utils.vartrue("DISTRO_UNATTENDED_INST_TESTS", "EFI=
/BOOT/bootaa64.efi", "", d)}"
--=20
2.34.1


