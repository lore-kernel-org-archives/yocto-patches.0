Return-Path: <levi.shafter@elder-tomes.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500C9C83F26
	for <webhook@archiver.kernel.org>; Wed, 30 Jul 2025 20:43:54 +0000 (UTC)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
 by mx.groups.io with SMTP id smtpd.web11.46049.1753908225712111559
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 30 Jul 2025 13:43:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@elder-tomes-com.20230601.gappssmtp.com header.s=20230601 header.b=gmVukIwE;
 spf=pass (domain: elder-tomes.com, ip: 209.85.166.174, mailfrom: levi.shafter@elder-tomes.com)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3e3d31a9ac7so986845ab.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 30 Jul 2025 13:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elder-tomes-com.20230601.gappssmtp.com; s=20230601; t=1753908224; x=1754513024; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciHJY6xuLXWAmavwLxdroR4PE67hvLXjhY6fsoEhk08=;
        b=gmVukIwENUuLioGkM9KS5F7VBIE9T0ZgNppHxQ3sO9rKF2vc6gqHUw60VSRYQ9ZzEF
         nR1VgDL3qIII65DcR9eBLGlsx/Nl3NSSh8I03Whk5T36T022wXLkjnCchgF8NenVNqoE
         tsaoaVWoJYZcYsIGNtg+fibKdSKQD7yqZOn/pVEon56yO2wBb9tiwYvw8UlQc2NhYqFo
         feokyG66wx9sZ0HZJA7gzrX9QYZdH5/S9JZnbl8Cmpjg07hUCfh6VpUGQBHwC7Np8xLo
         NX3OLuAmH39hruz0XpB0Jrcscfetkk3GWVU2l4TqrlHKpDFGeRi2x2KtFyvosGFp+RBD
         YrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753908224; x=1754513024;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ciHJY6xuLXWAmavwLxdroR4PE67hvLXjhY6fsoEhk08=;
        b=K7Q4HcsHlDEqfnTN0ixCbF4DCXqzOGbaaaf49TH0MVpyhcQS5M9r0LGmo2xNnMuhYK
         yVyEsnoJnCin5is81rdoSu+s6KpmywHWxBXtvc4AHctHViA1N2nYNXx3lrYSMNWE9n8p
         NabK9zrTTYLsp078wr42dCPrD+hJjdV5uUYM3XyQLYL889dsNIg+DODc255bw3T8lRr1
         tLZeuTaUmf4m9pLMl13Frk+Ux5fTdR4v5fG5DO1MLt0OqhsTVrE6TxY6Yk7/aOzU1Rl6
         UERPBmGTFzqFRhbTkY2XH2mO146esIWu9Af9JJsAhtd3+4XSlN0EurMAeX2wRvSasWmv
         rNog==
X-Gm-Message-State: AOJu0YzTKf/XLWBrGG1b18DSGFo9QQSA75deb6UvFIJ0MxHODeHPDPm+
	IWlqQlrxjD0f8v1p/POd553qX0LxZOqME4yj92mRayUJWWW0keleOoNdo8FNU+fEBt+rXpzXfPx
	Y+Sgx6Yk=
X-Gm-Gg: ASbGncu71NiZq+N28KClThDlg9BJb88EXSiLu994cq8MpstQka5TsuauB4F8eSg1Xw1
	GMddbFLFThkD9lfDqo3Ev38rupIYuDWHoJaKG5veFRSgIhr5zlEeCLJ7513jwbTOf32jyaJorWr
	dTMvbqxzCzcpgz/tcjA6sumortzl+vauT54kwJ/CIlJSC6qCGpqe/5xaD6em9tYUoRrdeRf6Htt
	Dk69+RBwrdrgZVu2IyVQyX7TYelu+JoeWQ5K3pA6RUA0NUFRta8KhCma9jdyvDPvW7RSZljvsRE
	PmC9NRHvoxTeDOQBwqJgELrNVDyXBZcycbtueT1QbppRXgtl4BoZOra1SCm8M69QBt6uCEHok8y
	nEYETEbKd9QbH20atGi3lnlSIe4QrrgCs08QwOPpeIguYGzxYKf7j+6942A6vzwAXQaz339Q=
X-Google-Smtp-Source: AGHT+IF6jnCUXSKE9wAzbWgfm2AZSsZf/Mc53hwGmm9IUk+B2e5AJ7ldy4hAfpFsi8Tio3vm+eRS4g==
X-Received: by 2002:a05:6e02:156c:b0:3e3:f7f8:fbc9 with SMTP id e9e14a558f8ab-3e3f7f8fc5emr72657595ab.12.1753908224234;
        Wed, 30 Jul 2025 13:43:44 -0700 (PDT)
Received: from [192.168.1.8] (c-75-70-150-54.hsd1.co.comcast.net. [75.70.150.54])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e402aca49fsm594345ab.36.2025.07.30.13.43.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 13:43:43 -0700 (PDT)
Message-ID: <bb24ee8c-b074-4b54-be64-2d1a09e5359f@elder-tomes.com>
Date: Wed, 30 Jul 2025 14:43:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org, yi.zhao@windriver.com,
 joe.macdonald@siemens.com
From: Levi Shafter <levi.shafter@elder-tomes.com>
Subject: [meta-selinux][PATCH] openssh: use config snippet instead of file
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 30 Jul 2025 20:43:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1878

Config snippets should be used over file overrides since targeted
changes may be required in multiple recipes.

Since the oe-core sshd_config file now includes
/etc/ssh/sshd_config.d/*.conf, the meta-selinux configuration snippet
does not require the following:

* ChallengeResponseAutnetication: Replaced by
  KbdInteractiveAuthentication and set to "no" by default

* Override default of no subsystems: This is already present

* Compression, ClientAliveInterval, and ClientAliveCountMax: No changes
  required due to identical requirements of meta-selinux

Testing process:

* Pulled modified meta-selinux layer into Poky and included openssh

* Built core-image-sato and ran via qemu

* Verified /etc/ssh was as expected with an ssh_config.d directory with
  the new selinux config snippet inside

* Verified system was including selinux config modification by running
  sshd -T

Suggested-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Signed-off-by: Levi Shafter <lshafter@21sw.us>
---
Sponsor: 21SoftWare LLC

v2: Install config snippet to sshd_config.d
v1: https://lists.yoctoproject.org/g/yocto-patches/message/1818

 .../openssh/files/sshd_config                 | 118 ------------------
 .../files/sshd_config.d/50-selinux.conf       |  15 +++
 .../openssh/openssh_selinux.inc               |  12 ++
 3 files changed, 27 insertions(+), 118 deletions(-)
 delete mode 100644 recipes-connectivity/openssh/files/sshd_config
 create mode 100644
recipes-connectivity/openssh/files/sshd_config.d/50-selinux.conf

diff --git a/recipes-connectivity/openssh/files/sshd_config
b/recipes-connectivity/openssh/files/sshd_config
deleted file mode 100644
index 1c33ad0..0000000
--- a/recipes-connectivity/openssh/files/sshd_config
+++ /dev/null
@@ -1,118 +0,0 @@
-#	$OpenBSD: sshd_config,v 1.102 2018/02/16 02:32:40 djm Exp $
-
-# This is the sshd server system-wide configuration file.  See
-# sshd_config(5) for more information.
-
-# This sshd was compiled with PATH=/usr/bin:/bin:/usr/sbin:/sbin
-
-# The strategy used for options in the default sshd_config shipped with
-# OpenSSH is to specify options with their default value where
-# possible, but leave them commented.  Uncommented options override the
-# default value.
-
-#Port 22
-#AddressFamily any
-#ListenAddress 0.0.0.0
-#ListenAddress ::
-
-#HostKey /etc/ssh/ssh_host_rsa_key
-#HostKey /etc/ssh/ssh_host_ecdsa_key
-#HostKey /etc/ssh/ssh_host_ed25519_key
-
-# Ciphers and keying
-#RekeyLimit default none
-
-# Logging
-#SyslogFacility AUTH
-#LogLevel INFO
-
-# Authentication:
-
-#LoginGraceTime 2m
-#PermitRootLogin prohibit-password
-#StrictModes yes
-#MaxAuthTries 6
-#MaxSessions 10
-
-#PubkeyAuthentication yes
-
-# The default is to check both .ssh/authorized_keys and
.ssh/authorized_keys2
-# but this is overridden so installations will only check
.ssh/authorized_keys
-#AuthorizedKeysFile	.ssh/authorized_keys
-
-#AuthorizedPrincipalsFile none
-
-#AuthorizedKeysCommand none
-#AuthorizedKeysCommandUser nobody
-
-# For this to work you will also need host keys in /etc/ssh/ssh_known_hosts
-#HostbasedAuthentication no
-# Change to yes if you don't trust ~/.ssh/known_hosts for
-# HostbasedAuthentication
-#IgnoreUserKnownHosts no
-# Don't read the user's ~/.rhosts and ~/.shosts files
-#IgnoreRhosts yes
-
-# To disable tunneled clear text passwords, change to no here!
-#PasswordAuthentication yes
-#PermitEmptyPasswords no
-
-# Change to yes to enable challenge-response passwords (beware issues with
-# some PAM modules and threads)
-ChallengeResponseAuthentication no
-
-# Kerberos options
-#KerberosAuthentication no
-#KerberosOrLocalPasswd yes
-#KerberosTicketCleanup yes
-#KerberosGetAFSToken no
-
-# GSSAPI options
-#GSSAPIAuthentication no
-#GSSAPICleanupCredentials yes
-
-# Set this to 'yes' to enable PAM authentication, account processing,
-# and session processing. If this is enabled, PAM authentication will
-# be allowed through the ChallengeResponseAuthentication and
-# PasswordAuthentication.  Depending on your PAM configuration,
-# PAM authentication via ChallengeResponseAuthentication may bypass
-# the setting of "PermitRootLogin without-password".
-# If you just want the PAM account and session checks to run without
-# PAM authentication, then enable this but set PasswordAuthentication
-# and ChallengeResponseAuthentication to 'no'.
-UsePAM yes
-
-#AllowAgentForwarding yes
-#AllowTcpForwarding yes
-#GatewayPorts no
-#X11Forwarding no
-#X11DisplayOffset 10
-#X11UseLocalhost yes
-#PermitTTY yes
-#PrintMotd yes
-#PrintLastLog yes
-#TCPKeepAlive yes
-#UseLogin no
-#PermitUserEnvironment no
-Compression no
-ClientAliveInterval 15
-ClientAliveCountMax 4
-#UseDNS no
-#PidFile /var/run/sshd.pid
-#MaxStartups 10:30:100
-#PermitTunnel no
-#ChrootDirectory none
-#VersionAddendum none
-
-# no default banner path
-#Banner none
-
-# override default of no subsystems
-Subsystem	sftp	/usr/libexec/sftp-server
-
-# Example of overriding settings on a per-user basis
-#Match User anoncvs
-#	X11Forwarding no
-#	AllowTcpForwarding no
-#	PermitTTY no
-#	ForceCommand cvs server
diff --git
a/recipes-connectivity/openssh/files/sshd_config.d/50-selinux.conf
b/recipes-connectivity/openssh/files/sshd_config.d/50-selinux.conf
new file mode 100644
index 0000000..775a24d
--- /dev/null
+++ b/recipes-connectivity/openssh/files/sshd_config.d/50-selinux.conf
@@ -0,0 +1,15 @@
+# 50-selinux.conf
+#
+# SELinux-specific SSHD configuration overrides
+# Managed by the meta-selinux layer in OpenEmbedded
+
+# Set this to 'yes' to enable PAM authentication, account processing,
+# and session processing. If this is enabled, PAM authentication will
+# be allowed through the ChallengeResponseAuthentication and
+# PasswordAuthentication.  Depending on your PAM configuration,
+# PAM authentication via ChallengeResponseAuthentication may bypass
+# the setting of "PermitRootLogin without-password".
+# If you just want the PAM account and session checks to run without
+# PAM authentication, then enable this but set PasswordAuthentication
+# and ChallengeResponseAuthentication to 'no'.
+UsePAM yes
diff --git a/recipes-connectivity/openssh/openssh_selinux.inc
b/recipes-connectivity/openssh/openssh_selinux.inc
index 07c25c5..259753d 100644
--- a/recipes-connectivity/openssh/openssh_selinux.inc
+++ b/recipes-connectivity/openssh/openssh_selinux.inc
@@ -2,5 +2,17 @@ inherit enable-selinux enable-audit

 FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

+SRC_URI += " \
+    file://50-selinux.conf \
+"
+
+do_install:append() {
+    install -d ${D}${sysconfdir}/ssh/sshd_config.d
+    install -m 0644 ${WORKDIR}/sources-unpack/50-selinux.conf \
+        ${D}${sysconfdir}/ssh/sshd_config.d/
+}
+
+FILES:${PN} += "${sysconfdir}/ssh/sshd_config.d/50-selinux.conf"
+
 PACKAGECONFIG[selinux] = "--with-selinux,--without-selinux,libselinux"
 PACKAGECONFIG[audit] = "--with-audit=linux,--without-audit,audit"

