Return-Path: <yannik.tannhaeuser@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0930AC5AC7A
	for <webhook@archiver.kernel.org>; Fri,  7 Aug 2026 13:30:55 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.42721.1786109450422659840
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 07 Aug 2026 06:30:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Ir8nQQkR;
 spf=pass (domain: gmail.com, ip: 209.85.221.43, mailfrom: yannik.tannhaeuser@gmail.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48000c5d6d3so330634f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 07 Aug 2026 06:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786109449; x=1786714249; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EcmGVxtvLbmeXvs0O78GpU15pAcmUQZOqFJKEDrJOQc=;
        b=Ir8nQQkRcS1+fjdksTZvqr52M2DbzdWUiRDhTIi6m6rhZ02WRqdc7rQAN5NbuKtiPF
         ilzZNNYTrmUUtxPZ8EadiHKsZxmnhQ/nefm+8zEiCior9FP/qQry066ty3nl1eVtpYIk
         hriWr+YH4XJgYLZtyqOcGU3vCL/Mg9AtQmJbGPkRIZitAjCk1zfYuVxGItuZ9Nm+y5yI
         DHicD+nuclSM3nokQICT7KLhoBK8czSWx/tVtsJXeXKjuViyCJTdFskBZiFePjiinFxN
         tp0o6ePWttvCXyJtFMRTh0qnv4wNJMCXR7M+W2LUd2Wkka1tTYGFZOgHd3ACS080K91K
         IacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786109449; x=1786714249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EcmGVxtvLbmeXvs0O78GpU15pAcmUQZOqFJKEDrJOQc=;
        b=XqlDwR/vvAkoURrgbbtPQTP3G0AXUaRTT+WBL9gL6s4txnosFgpkLmubxh5E6DzAOr
         A9+aPI5CnfGbWm+ob4cO5UaTptyzhhDexW0EhUGJY7QMTk93jYSIGFjgz8qfz1t51XKq
         QpDVSa+d/1jQPOndvjWh5JG4FeNh7buPXjm1wwk54pyyCfZ4OvOFJKWr1i362/rZqPOj
         DeNqWvyyqIvpeisKcxi7JP9OBDi7Ms2oLAhuuHE3GfVkjKT1f3s3FKoifApkwzEueKa2
         O5sEuyz0MJg8OnNNpgPb7V/e1qtl9lXcuMBjkCTAduve5/NKRyUI6wFOcYVeqS4kKJUe
         ugKw==
X-Gm-Message-State: AOJu0YxZnJZUEsOhJX1R9wVmIvjez1GbE9mkL+ZyRL1QFjOl+UbX4xG1
	5/yuEQs1ObwO2ZAnsqnHGdSMF/wTv7BV8mcFMjC4K514dPjUUTBTpmgn4Q8yLw==
X-Gm-Gg: AR+sD12Zaf2dPc3bGg7UcHb2A2vRiAGf+UWvBG47BtD40Fn9PepKolXC0vs9YRLhFAp
	K+kxtKtY+qjLNnf5ZnCKLOiwQD2XfB6cEQsd2VBNJut+WnLZW00YXxvMdhaTvPTf7YkawgiGJkF
	OvecfFFBVnQ0YvRMHZLdjnx9MFWC5YCpWruX6TH4DCHrZQq9WtySpDfYEBFXO14Qq3w4cIZa6QM
	pPzeafgppSzUX1JQ8nySDYrwPcA7lcjq+906flY53Yvu9oNXRpm0r4Ofi/rprs743tVFTl31jix
	MiwmiG/nwNq95B30wKtWMpk5DK4zex0sdYHnB/ldH+w+LaAbfRvBe8ZuIz/Z5+u8fntu21fP7yt
	tKIuu9bOEbZK8GZLShkQkb7ZnSAd6flIk0/V4ZQzDgC+2IFHX8tiOPtHepdd+YjkU4Y1nfOUu91
	HtHE0Ns1GHyi4Jwr1xT8fqthLZW9sYw3E1UC79eMu0SDew8l92wLrGgp8lYcsfrAOCEXqvqlzlN
	TIdjzuUkhIK7iJV1uXYvY9JlN5dp94MO7u45PH8d8aTC6jzQUJbJWMFPT4lbRPlgLDgjexAiDm1
	zaolJ3V3AA==
X-Received: by 2002:a05:6000:2583:b0:47f:c3a1:244 with SMTP id ffacd0b85a97d-480026f58d3mr5735962f8f.30.1786109448469;
        Fri, 07 Aug 2026 06:30:48 -0700 (PDT)
Received: from ERL0724PF3HPJ22.global.ul.com (p200300f847017a0099d583c1a3d62c58.dip0.t-ipconnect.de. [2003:f8:4701:7a00:99d5:83c1:a3d6:2c58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4800220ab04sm5334374f8f.37.2026.08.07.06.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:30:48 -0700 (PDT)
From: Yannik Tannhaeuser <yannik.tannhaeuser@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Yannik Tannhaeuser <yannik.tannhaeuser@gmail.com>
Subject: [meta-selinux][master][PATCH] openssh: restore SELinux labels for /var/run/sshd
Date: Fri,  7 Aug 2026 15:30:46 +0200
Message-ID: <20260807133046.423988-1-yannik.tannhaeuser@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 07 Aug 2026 13:30:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4652

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


