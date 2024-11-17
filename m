Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FD3D10F2B
	for <webhook@archiver.kernel.org>; Sun, 17 Nov 2024 20:41:52 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web10.25499.1731876110974451435
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 17 Nov 2024 12:41:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lZ+WFXzq;
 spf=pass (domain: gmail.com, ip: 209.85.221.42, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37ece998fe6so250142f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 17 Nov 2024 12:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731876108; x=1732480908; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=immcWI+mq4cRRuxjKMcWPv9jStLxl/iDIb/SnEpefCg=;
        b=lZ+WFXzql27mIQ13cREQ4hG4Ye+AteLx4dAajyQaEcvfkWH8mrWqsQm2zBfXywWk7Y
         5klDvimGRhAAvD7rEOvv/mXxyr88NHWyv1vSyZ0sUTPo4g+V33vSFYW0k3FEK0e1EvCs
         zE91ZErO3weTleDBTwQQl8UY3Tgd5o6jHqGHfLL+qDpJXiK2pTXSpwh0oNJ8vnCCVpzb
         jxzoYQ9Imw9Q42ZYeD+4Pmvvaiye6Tn8zXCZ1dYcU84fr0IqhahykhA9xPmU3LE6bXC/
         svCllAGpeokLVic6Bd1qIPgQ7U7w2cU95aXPQrXUWIrVVTtE9nc5jui35Qa2+8bB4n/5
         uqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731876108; x=1732480908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=immcWI+mq4cRRuxjKMcWPv9jStLxl/iDIb/SnEpefCg=;
        b=M+0vEdtllacYeCpjGtQ8wjnv7ZRk5dH8HoGXsFCddxGPUv2a4icgYQ4hnkjhbzAJsR
         XxHrBiWMhTZ5EiBRY1vI2iDmaAUu1A0ha5LiiGOFW3NDjhP8uA9G61i2UxEwcAuNOl0H
         MFeciGEFjocpwLrMTnyUdJdr6KY6FmVjwIvQQ6or1otpdleERMJEwMltF+yqv9f6Et9t
         9TZqKoy2EBY7RbTkEIy1AVz2UTjVIwrO8Hsx0Y0F8GHQkIqgYgJPitOpoRhY3nWeBXVY
         qRID+hwl+Fa0SSHw0VlkanMNMqyvvJGvIHxvrql7zw/9rxRBMyDhXwB70ykYu5bV/jLU
         UZUA==
X-Gm-Message-State: AOJu0YxWyksmuxi6RrTYVqIwsJMy0itbzySmoYyRpn//EjSBJeBBZLE1
	I6l4PDa3mM+QrVu+YhXDfuFq8aDXVKjcTUmNoiofllw4l0/YKTz3uhF6ZpjR
X-Gm-Gg: ASbGnctYrNcpoiYiXQ5T/nQ95DcjccUflCwxdAEboP7f5aO97DVMPqZ1svbsL75lZly
	smy0vFY9e3Izd0/Df/EUXjAPtXhNunwXNm+mtuWhf0dtDs09RxRKj0eh8YE3AHjyYsIwz2l5zJe
	9OqEDUdfR4VUzKphRkfC06T2vlkOqbTqyIm2zCBSuT0iwpLZ5mnpz9iEHZz67KU+5YButw9yj8T
	UTYo4PFq7uudelVJVkBPxuVC9sdpBgQ0z3XUaSnt1lm5zhqOIfD5j+vLovQ
X-Google-Smtp-Source: AGHT+IExgiryOabVpxACTltKzuGtYVadTYhBJprNMYURSv9KYPuWQe6itfB62yDFA8xfkRIQ3hjOIw==
X-Received: by 2002:a05:600c:4f06:b0:42c:c0d8:bf49 with SMTP id 5b1f17b1804b1-432df677e91mr36068315e9.0.1731876108299;
        Sun, 17 Nov 2024 12:41:48 -0800 (PST)
Received: from archlinux.. ([2a01:e0a:ce:f2f0:2a6b:35ff:feb8:77d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da2658a8sm136607955e9.9.2024.11.17.12.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 12:41:47 -0800 (PST)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Eil=C3=ADs=20=27pidge=27=20N=C3=AD=20Fhlannag=C3=A1in?= <pidge@baylibre.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Thibaud Dufour <thibaudd@rtone.fr>,
	=?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [poky] [kirkstone] [BACKPORT 2/3] useradd: Fix issues with useradd dependencies
Date: Sun, 17 Nov 2024 21:41:17 +0100
Message-ID: <20241117204118.3405309-3-gael.portay+rtone@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241117204118.3405309-1-gael.portay+rtone@gmail.com>
References: <20241117204118.3405309-1-gael.portay+rtone@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 17 Nov 2024 20:41:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/813

From: Eilís 'pidge' Ní Fhlannagáin <pidge@baylibre.com>

If recipe A requires the useradd actions of recipe B we need to
ensure that recipe B is part of the recipe A dependancy chain. In
order to do that, we introduce USERADD_DEPENDS. This makes sure
that the do_populate_sysroot_setscene of recipe B exists for
recipe A in case of a missing TMPDIR. This requires changes made in
runqueue.py by RP.

This commit along with the runqueue fixes effects:
Bug 13419 - recipes that add users to groups cannot rely on other recipes creating those groups (when population from sstate happens)
Bug 13904 - do_prepare_recipe_sysroot: postinst-useradd-* does not run in order of dependency and sometimes fails
Bug 13279 - Make sure users/groups exist for package_write_* tasks
Bug 15084 - For some reason using of same user in two recipes does not work properly

I've included the start of self-testing for useradd by adding tests for
13419 (which ends up testing 13904, 13279, 15084 by virtue of them all
      having the same root cause)

(From OE-Core rev: b47f2352376bd16b7e7087b4dab143403e67e094)

Signed-off-by: Eilís 'pidge' Ní Fhlannagáin <pidge@baylibre.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Thibaud Dufour <thibaudd@rtone.fr>
Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
---
 .../selftest-users/creategroup1.bb            | 32 ++++++++++++++++++
 .../selftest-users/creategroup2.bb            | 33 +++++++++++++++++++
 meta/classes/useradd.bbclass                  |  4 ++-
 .../lib/oeqa/selftest/cases/usergrouptests.py | 17 ++++++++++
 4 files changed, 85 insertions(+), 1 deletion(-)
 create mode 100644 meta-selftest/recipes-test/selftest-users/creategroup1.bb
 create mode 100644 meta-selftest/recipes-test/selftest-users/creategroup2.bb
 create mode 100644 meta/lib/oeqa/selftest/cases/usergrouptests.py

diff --git a/meta-selftest/recipes-test/selftest-users/creategroup1.bb b/meta-selftest/recipes-test/selftest-users/creategroup1.bb
new file mode 100644
index 0000000000..ebbbfaa83d
--- /dev/null
+++ b/meta-selftest/recipes-test/selftest-users/creategroup1.bb
@@ -0,0 +1,32 @@
+SUMMARY = "creategroup pt 1"
+LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
+
+LICENSE = "MIT"
+
+DEPENDS = "coreutils-native"
+
+S = "${WORKDIR}"
+
+inherit useradd allarch
+
+USERADD_PACKAGES = "${PN}"
+USERADD_PARAM:${PN} = "-u 5555 --gid grouptest gt1"
+GROUPADD_PARAM:${PN} = "-r grouptest"
+
+TESTDIR = "${D}${sysconfdir}/creategroup"
+
+do_install() {
+	install -d   ${TESTDIR}
+	install -d   ${TESTDIR}/dir
+	touch        ${TESTDIR}/file
+	ln -s ./file ${TESTDIR}/symlink
+	install -d   ${TESTDIR}/fifotest
+	mkfifo       ${TESTDIR}/fifotest/fifo
+
+	chown    gt1:grouptest ${TESTDIR}/file
+	chown -R gt1:grouptest ${TESTDIR}/dir
+	chown -h gt1:grouptest ${TESTDIR}/symlink
+	chown -R gt1:grouptest ${TESTDIR}/fifotest
+}
+
+FILES:${PN} = "${sysconfdir}/creategroup/*"
diff --git a/meta-selftest/recipes-test/selftest-users/creategroup2.bb b/meta-selftest/recipes-test/selftest-users/creategroup2.bb
new file mode 100644
index 0000000000..ef697f09b4
--- /dev/null
+++ b/meta-selftest/recipes-test/selftest-users/creategroup2.bb
@@ -0,0 +1,33 @@
+SUMMARY = "creategroup pt 2"
+LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
+
+LICENSE = "MIT"
+
+DEPENDS = "coreutils-native"
+USERADD_DEPENDS = "creategroup1"
+
+S = "${WORKDIR}"
+
+inherit useradd allarch
+
+USERADD_PACKAGES = "${PN}"
+USERADD_PARAM:${PN} = "-u 5556 --gid grouptest gt2"
+
+TESTDIR = "${D}${sysconfdir}/creategroup"
+
+do_install() {
+	install -d   ${TESTDIR}
+	install -d   ${TESTDIR}/dir
+	touch        ${TESTDIR}/file
+	ln -s ./file ${TESTDIR}/symlink
+	install -d   ${TESTDIR}/fifotest
+	mkfifo       ${TESTDIR}/fifotest/fifo
+
+	chown    gt2:grouptest ${TESTDIR}/file
+	chown -R gt2:grouptest ${TESTDIR}/dir
+	chown -h gt2:grouptest ${TESTDIR}/symlink
+	chown -R gt2:grouptest ${TESTDIR}/fifotest
+}
+
+FILES:${PN} = "${sysconfdir}/creategroup/*"
+
diff --git a/meta/classes/useradd.bbclass b/meta/classes/useradd.bbclass
index 20771a0ce5..e179c1039b 100644
--- a/meta/classes/useradd.bbclass
+++ b/meta/classes/useradd.bbclass
@@ -171,9 +171,11 @@ SYSROOT_PREPROCESS_FUNCS += "${SYSROOTFUNC}"
 
 SSTATEPREINSTFUNCS:append:class-target = " useradd_sysroot_sstate"
 
+USERADD_DEPENDS ??= ""
+DEPENDS += "${USERADD_DEPENDS}"
 do_package_setscene[depends] += "${USERADDSETSCENEDEPS}"
 do_populate_sysroot_setscene[depends] += "${USERADDSETSCENEDEPS}"
-USERADDSETSCENEDEPS:class-target = "${MLPREFIX}base-passwd:do_populate_sysroot_setscene pseudo-native:do_populate_sysroot_setscene shadow-native:do_populate_sysroot_setscene ${MLPREFIX}shadow-sysroot:do_populate_sysroot_setscene"
+USERADDSETSCENEDEPS:class-target = "${MLPREFIX}base-passwd:do_populate_sysroot_setscene pseudo-native:do_populate_sysroot_setscene shadow-native:do_populate_sysroot_setscene ${MLPREFIX}shadow-sysroot:do_populate_sysroot_setscene ${@' '.join(['%s:do_populate_sysroot_setscene' % pkg for pkg in d.getVar("USERADD_DEPENDS").split()])}"
 USERADDSETSCENEDEPS = ""
 
 # Recipe parse-time sanity checks
diff --git a/meta/lib/oeqa/selftest/cases/usergrouptests.py b/meta/lib/oeqa/selftest/cases/usergrouptests.py
new file mode 100644
index 0000000000..98e8102590
--- /dev/null
+++ b/meta/lib/oeqa/selftest/cases/usergrouptests.py
@@ -0,0 +1,17 @@
+#
+# Copyright OpenEmbedded Contributors
+#
+# SPDX-License-Identifier: MIT
+#
+
+from oeqa.selftest.case import OESelftestTestCase
+from oeqa.utils.commands import bitbake
+
+class UserGroupTests(OESelftestTestCase):
+    def test_group_from_dep_package(self):
+        self.logger.info("Building creategroup2")
+        bitbake(' creategroup2 creategroup1')
+        bitbake(' creategroup2 creategroup1 -c clean')
+        self.logger.info("Packaging creategroup2")
+        self.assertTrue(bitbake(' creategroup2 -c package'))
+
-- 
2.47.0


