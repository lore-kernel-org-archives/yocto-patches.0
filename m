Return-Path: <yannik.tannhaeuser@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E7CC2A09B
	for <webhook@archiver.kernel.org>; Fri,  7 Aug 2026 12:52:54 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.41795.1786107167990041018
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 07 Aug 2026 05:52:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=jSZxDHrY;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: yannik.tannhaeuser@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so9659765e9.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 07 Aug 2026 05:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786107166; x=1786711966; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EcmGVxtvLbmeXvs0O78GpU15pAcmUQZOqFJKEDrJOQc=;
        b=jSZxDHrYQH39Jj6zP9C9uZThJzm4ugqu6UwMkKpO5KxYoqR1XQjuYaQH4PX79IBOA2
         O79nmKiVXvLBZ7uYwxgipZgVVTrFWc63LHkDEh0HUx5SoLzOezRdWBR80D46VojiiRjo
         kgFNeZjYsF9uSBsBNq4PrbRJ2nEyJKQF3oyUnigDtnooXtcrVrwlSdtCvLjgQXwz7u7m
         dCcpnM44IFU7hbp6PmlirbtCoPjvIPVFQXiKyWDjq/tC4CUyAnNIfCj7/gom2r7KFboy
         2W8nuNvk7/pLMRELrCJEcQKmy4B/J7c7jzDfsS9yau2i2nk2CIFp90ol+i3n+Cy2cZED
         3ztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786107166; x=1786711966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EcmGVxtvLbmeXvs0O78GpU15pAcmUQZOqFJKEDrJOQc=;
        b=CJeCiOyf2eWEpHwPLA72vnZ8vtuOMWJhN5m15VMoYNCoPnb15rHwuG4T4Seuu3k5Rn
         CU0/3qdop59nNchbaf8C4i+qcFSHaUd8zQQLeCiJRSc7ohyNqSlFW4xWZ0D+lc7YTHtc
         2IqYAsps8kFnnwr+cEeqctKdBAbN27SF3qED2VAA0ysfvecR31U2nvjHcgsFdNyAuoz+
         2jfScQWUu4ymb9pR053f2NVZFcdfBEdS1437jdVgHBLtwBRMUIwk2NoXzHOElEt+yeTw
         dOQ8lIlFutznd4twaLH/0uzmEFoV4M7c9KavHgGwLFuPlvEgjLqoFKE4n8YM3ZWJcLVf
         YN6w==
X-Gm-Message-State: AOJu0YzudFAHyrw4vlGV5LN/cGqEXqu+mKjfvrLUWT1qkcEo0f7NTP3y
	ry/W1GyIVcIxHFNUopDuQumQgiO1yd8TVAJiTDZz5AjwnytuTdE+xWz7vmzNsA==
X-Gm-Gg: AR+sD10iKEvFK5E5BEyH37/FFQnL2kA2JTh43W3T0MbCPcrNYYmFOjmFdkYGPPQB4X6
	rA0ZPMRZH3fq7/8P/PKrHoyX+Q53XSj3K/v1Tk7ulziwyWpKd67GRasBN+4ZLJ1+QVyLc+o9CZ7
	ngOJ3mC6cA8d2Klmwxr0zCz8YeJOt0Bh0YTC1LgI0xHnxqZBfZlLOkGxIxNNR1Gj4hgxojziaji
	HUD2ycdZWEQvLiKjFAd/k3o1lm/v8qr9jwgJKCdA3dnk0R59w3GUTJyIPPuh3+skJ6wxNxKPdqc
	6mnIv5KKknBNGURhNo8KWVF/qY37f/t6xUZvQt5ZMj8nEWY/k4XqWEdtyxXYvAaieJOP6nlcKpI
	X9f14xP3S9P4MFmauscyS6L+GoJXMcjKbid3O1SH3vGKlnbMLIREPvV2zaa2HcU4nqHYs0uzoYA
	/wmIss0j6Tp+c4gvidQ/IHX4Qyxt83IN3E+gZDdzXKTAZ3OOTeSgBfaWscQDQGA/vOXK0ME8NUq
	Kp+zg+/mYKLXPX+SfBO93UA0Zpy7UOUihZqCzEANObJade21r4dobvQcBcbiTq1hIrdkhAF7Hf7
	8F+w6mnudQ==
X-Received: by 2002:a05:600c:4e94:b0:497:ff73:68d5 with SMTP id 5b1f17b1804b1-4994e6c5eafmr286539005e9.0.1786107166106;
        Fri, 07 Aug 2026 05:52:46 -0700 (PDT)
Received: from ERL0724PF3HPJ22.global.ul.com (p200300f847017a0099d583c1a3d62c58.dip0.t-ipconnect.de. [2003:f8:4701:7a00:99d5:83c1:a3d6:2c58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145589sm6133442f8f.1.2026.08.07.05.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 05:52:45 -0700 (PDT)
From: Yannik Tannhaeuser <yannik.tannhaeuser@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Yannik Tannhaeuser <yannik.tannhaeuser@gmail.com>
Subject: [meta-selinux][wrynose][PATCH] openssh: restore SELinux labels for /var/run/sshd
Date: Fri,  7 Aug 2026 14:52:19 +0200
Message-ID: <20260807125219.420529-1-yannik.tannhaeuser@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 07 Aug 2026 12:52:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4649

Since /var/run/sshd is in most deployments a tmpfs, we need to call
restorecon to set the correct SELinux labels each time.

Signed-off-by: Yannik Tannhaeuser <yannik.tannhaeuser@gmail.com>
---
 .../openssh/files/var-run-sshd-restorecon.conf              | 2 ++
 recipes-connectivity/openssh/openssh_selinux.inc            | 6 ++++++
 2 files changed, 8 insertions(+)
 create mode 100644 recipes-connectivity/openssh/files/var-run-sshd-restorecon.conf

diff --git a/recipes-connectivity/openssh/files/var-run-sshd-restorecon.conf b/recipes-connectivity/openssh/files/var-run-sshd-restorecon.conf
new file mode 100644
index 0000000..250dc4f
--- /dev/null
+++ b/recipes-connectivity/openssh/files/var-run-sshd-restorecon.conf
@@ -0,0 +1,2 @@
+[Socket]
+ExecStartPre=/sbin/restorecon /var/run/sshd
diff --git a/recipes-connectivity/openssh/openssh_selinux.inc b/recipes-connectivity/openssh/openssh_selinux.inc
index 119ce63..6fb105d 100644
--- a/recipes-connectivity/openssh/openssh_selinux.inc
+++ b/recipes-connectivity/openssh/openssh_selinux.inc
@@ -4,15 +4,21 @@ FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
 
 SRC_URI += " \
     file://50-selinux.conf \
+    file://var-run-sshd-restorecon.conf \
 "
 
 do_install:append() {
     install -d ${D}${sysconfdir}/ssh/sshd_config.d
     install -m 0644 ${UNPACKDIR}/50-selinux.conf \
         ${D}${sysconfdir}/ssh/sshd_config.d/50-selinux.conf
+
+    install -d ${D}${systemd_system_unitdir}/sshd.socket.d
+    install -m 0644 ${UNPACKDIR}/var-run-sshd-restorecon.conf \
+        ${D}${systemd_system_unitdir}/sshd.socket.d/var-run-sshd-restorecon.conf
 }
 
 FILES:${PN}-sshd:append = " ${sysconfdir}/ssh/sshd_config.d/50-selinux.conf"
+FILES:${PN}-sshd:append = " ${systemd_system_unitdir}/sshd.socket.d/var-run-sshd-restorecon.conf"
 
 PACKAGECONFIG[selinux] = "--with-selinux,--without-selinux,libselinux"
 PACKAGECONFIG[audit] = "--with-audit=linux,--without-audit,audit"
-- 
2.43.0


