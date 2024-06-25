Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8441DC2BBCA
	for <webhook@archiver.kernel.org>; Tue, 25 Jun 2024 14:33:29 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web10.174897.1719326002284083164
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 25 Jun 2024 07:33:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=BjRsUI5z;
 spf=pass (domain: snapchat.com, ip: 209.85.221.50, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-362bc731810so5059541f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 25 Jun 2024 07:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1719326000; x=1719930800; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5t3ONn3AN54O/KAWrOjsmi5vk4IyUrWIfuzacpJTBqU=;
        b=BjRsUI5zb2o2fBkRkfWMx6kZ6henPk4tVKarU/z3LAmeAMbupOWCpnE6IMJbyEr2hh
         idxS8OJ6rVkGuY3JvguIHSRbVZhYkztceY1A7qDZkMmox/AQH7hE0fW05A61I0sg2LJ9
         MAG3fu5BmbY8dJVcxdIzHlytsGv27DP0KwTPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719326000; x=1719930800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5t3ONn3AN54O/KAWrOjsmi5vk4IyUrWIfuzacpJTBqU=;
        b=t3YtDfJOuoLzzypqnFDLUNsKJWNufznrWeup/RNCcWdNeMfoE3PjHsML7Xea1TzG5j
         95MMl+CYeUtdN7KD0Bhd5Qa3kztoBWxPb0el9QwWayzuvEZSy1zjO7rxErKFE5qEbCzH
         4T83vHy/mFQpElnxtLbsTs/vieLS7XsXmAENOycY9pKHz4xmGbmL8XdrHLTSPKEFqRnd
         +PW3k8zElDP46OgNeVvU1kbTHyzPE9smzlDLjRtLBSprrTiIyIcWthftKd7naORAq4P3
         e8Vsy3LVF4Iqo9yqepBEvI8CbqUFgT/lZf9Bf15y0VxopguBcZIeIfM3bEU6P4INdpkU
         j9hg==
X-Gm-Message-State: AOJu0YxaJsfD9z/ce5Ux1ad7fYpONEtQerrn6Srn130wHDf0pqVs5/Ny
	MHWdQ34S+fRIcr3rY3nGM7ekUC+Eug/cgwkNK+5FWebRsGEZk1xKc42/GgMOkyGrWj5MhI8ODaq
	j9go=
X-Google-Smtp-Source: AGHT+IFIm+kzfsZ2yP+WhqXZC1YDNANEjiOFnEtVm9PIr+/mkHXya3XQTrHGpbzLe1CBx7/zG0aygA==
X-Received: by 2002:a5d:4523:0:b0:362:721a:fa2 with SMTP id ffacd0b85a97d-366e94d4a00mr6095036f8f.30.1719326000344;
        Tue, 25 Jun 2024 07:33:20 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424817a9981sm179837055e9.17.2024.06.25.07.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 07:33:20 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-selinux][scarthgap][PATCH] refpolicy: backport build fix
Date: Tue, 25 Jun 2024 16:33:17 +0200
Message-Id: <20240625143317.1644238-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 25 Jun 2024 14:33:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/372

From: Etienne Cordonnier <ecordonnier@snap.com>

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 ...-selinuxutil-make-policykit-optional.patch | 36 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 37 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0057-selinuxutil-make-policykit-optional.patch

diff --git a/recipes-security/refpolicy/refpolicy/0057-selinuxutil-make-policykit-optional.patch b/recipes-security/refpolicy/refpolicy/0057-selinuxutil-make-policykit-optional.patch
new file mode 100644
index 0000000..62b35d5
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0057-selinuxutil-make-policykit-optional.patch
@@ -0,0 +1,36 @@
+From 0f997a134adb6c68d871a31ec27d63f02297c588 Mon Sep 17 00:00:00 2001
+From: Yi Zhao <yi.zhao@windriver.com>
+Date: Wed, 5 Jun 2024 10:32:34 +0800
+Subject: [PATCH] selinuxutil: make policykit optional
+
+Make policykit optional to avoid a potential build error.
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/c6dd4087def22fa0f3e2b62bce5fc531bbf824a0]
+
+Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
+Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
+---
+ policy/modules/system/selinuxutil.te | 6 ++++--
+ 1 file changed, 4 insertions(+), 2 deletions(-)
+
+diff --git a/policy/modules/system/selinuxutil.te b/policy/modules/system/selinuxutil.te
+index 57c2e0e01..c65d5e8e6 100644
+--- a/policy/modules/system/selinuxutil.te
++++ b/policy/modules/system/selinuxutil.te
+@@ -501,12 +501,14 @@ corecmd_exec_bin(selinux_dbus_t)
+ files_read_etc_symlinks(selinux_dbus_t)
+ files_list_usr(selinux_dbus_t)
+ 
+-policykit_dbus_chat(selinux_dbus_t)
+-
+ miscfiles_read_localization(selinux_dbus_t)
+ 
+ seutil_domtrans_semanage(selinux_dbus_t)
+ 
++optional_policy(`
++	policykit_dbus_chat(selinux_dbus_t)
++')
++
+ ########################################
+ #
+ # semodule local policy
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 6ea1fc2..0f5fe1b 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -72,6 +72,7 @@ SRC_URI += " \
         file://0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
         file://0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
         file://0056-policy-modules-system-logging-make-syslogd_runtime_t.patch \
+        file://0057-selinuxutil-make-policykit-optional.patch \
         "
 
 S = "${WORKDIR}/refpolicy"
-- 
2.36.1.vfs.0.0


