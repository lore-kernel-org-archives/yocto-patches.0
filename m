Return-Path: <levi.shafter@elder-tomes.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0F9CA0EEB
	for <webhook@archiver.kernel.org>; Thu, 21 Aug 2025 18:40:45 +0000 (UTC)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
 by mx.groups.io with SMTP id smtpd.web11.4202.1755801643433612402
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 21 Aug 2025 11:40:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@elder-tomes-com.20230601.gappssmtp.com header.s=20230601 header.b=Ho3ZsaIi;
 spf=pass (domain: elder-tomes.com, ip: 209.85.166.45, mailfrom: levi.shafter@elder-tomes.com)
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-88432ccd787so79910539f.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 21 Aug 2025 11:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elder-tomes-com.20230601.gappssmtp.com; s=20230601; t=1755801642; x=1756406442; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:to:references
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hD92jBcAGudKlyKYd52cDLepbjeDpDutWNNevrmETU0=;
        b=Ho3ZsaIitGzslcbQne4mT1aUZvXsuhjaSfdLiKo6fvsxJlxWOb2e77c7uSfbtxO2Vy
         FW/VHdxdrkPWJRkf0c4OeuxNMutSYaZM1EeLNMuJXx2Qrsld0DlZzAqivBIM3A2hHGvW
         08503eXT3ksh62sQK/hOyR9sWB9ISq73frSzzcJ39GY0ZYy8aJqcD51+TaU4iWaHQdjd
         muGV4/11PDSt72TpUzUsZwx4NbxAh/SBQFt3rvtgxnLxmXGtpdDQj6p0hhpAsfxeHenW
         0Kqleb0nobIh1+E16M70j9nmB1F+ZHK4YwJ3kkYhg+YYZcmL2d1HdShozCQWuSXZoems
         PKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755801642; x=1756406442;
        h=content-transfer-encoding:in-reply-to:from:to:references
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hD92jBcAGudKlyKYd52cDLepbjeDpDutWNNevrmETU0=;
        b=si7K6AK1x1VHNJQvKg78QQp87TGmVSoArZa5Y9nu4pRbqIClwePmD2KomjngnbFYfI
         1IBamjaW6mGy2AZBmTrTOFjekdKScJQYy8QuKaIl2YnP+5sZO8XvLpZvAJxuDgu2ntfM
         Xp3477MFkJD2+bQ3wH7fJWvb8clFNaCKnqtoKTrZKC5FgGKGzhb4V4X1SJZwPVNsLQTU
         X+2tymeBzfUDJwOMEFK72NCRyKnIpLBqDcAaIssoB4PSJf5JH2iIN3lUlaLokZreqep8
         8dIJ1i2McuBmRp6QOqmlMR/8QLx8HdgZzqvGjdh86AsCW9ls60Y1jw+5oSzYPhmD3RtN
         0BQw==
X-Gm-Message-State: AOJu0YyLMJavG2VxSp+HeZymzQdoli8EFIiDeaHa+SwvZAQkcXdZJcMM
	6YaTKgcJWqoZFpfm526n39ANg2PlqAt7gjvgEkoMsQgFJNLHbsT37R05EkM6BXt0Z0g1MEt8BLL
	0VVURjpQ=
X-Gm-Gg: ASbGnctCaezlcxdFXF7PveaHRDefO9Qr+llqSaUBMnoIGYycnUeL83PAfQ95iP0qB3P
	wiAcxO2PJ2bwz7Bu514edVRKV2Tu3+o2ITiFqvNkHN+F0uQwuwBlr+iP1oj/qTo7p3ZHR6BXJas
	d2WhgX1xWTkBcRVPV4dKtQi7FyBucqKN1iIkTGq4ZSJZBcItdzu78v58xX0MImPRMDfnH6g4eAB
	HkzEQMm0+ZFuwrTyWdS+9H5/CXuc5bv+qqtWZy25UMQo0HurQ14yFYks2ahiWZ6rmlMCdb+5QEj
	RLz8WnWz2qLKgT/X6KQ9XNPgI+QoubICd2mchrsQVtkZ63OPqX9UMm9GdMt2QZ5Q4C59ZOnCJuj
	sjvy0LlLYAneOTZIb53szvE5IYyqFjNIpeZy7UtxWpODSKuwcfOXQP2XsB4X0QB7Tm/ybrQI=
X-Google-Smtp-Source: AGHT+IF5WbQxXJ/Q/w2JgjRvWFHzMxWOL9Alu7dmue6gl+jntvELPKoLY4OnSKbfYcLzCaG8bm3vlg==
X-Received: by 2002:a05:6e02:1549:b0:3e5:4c7d:b799 with SMTP id e9e14a558f8ab-3e921a5c454mr6144635ab.13.1755801641684;
        Thu, 21 Aug 2025 11:40:41 -0700 (PDT)
Received: from [192.168.1.8] (c-73-169-9-114.hsd1.co.comcast.net. [73.169.9.114])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e6657e5230sm63218675ab.52.2025.08.21.11.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 11:40:41 -0700 (PDT)
Message-ID: <80908ee2-bd66-4c1a-b4e4-1caa4bccff09@elder-tomes.com>
Date: Thu, 21 Aug 2025 12:40:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [meta-selinux][PATCH] openssh: use config snippet instead of file
Content-Language: en-US
References: <bb24ee8c-b074-4b54-be64-2d1a09e5359f@elder-tomes.com>
To: yocto-patches@lists.yoctoproject.org, yi.zhao@windriver.com,
 joe.macdonald@siemens.com
From: Levi Shafter <levi.shafter@elder-tomes.com>
In-Reply-To: <bb24ee8c-b074-4b54-be64-2d1a09e5359f@elder-tomes.com>
X-Forwarded-Message-Id: <bb24ee8c-b074-4b54-be64-2d1a09e5359f@elder-tomes.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 21 Aug 2025 18:40:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2076

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

v3: Address code review comments
v2: https://lists.yoctoproject.org/g/yocto-patches/message/1878
v1: https://lists.yoctoproject.org/g/yocto-patches/message/1818

 .../openssh/files/50-selinux.conf             |  15 +++
 .../openssh/files/sshd_config                 | 118 ------------------
 .../openssh/openssh_selinux.inc               |  13 ++
 3 files changed, 28 insertions(+), 118 deletions(-)
 create mode 100644 recipes-connectivity/openssh/files/50-selinux.conf
 delete mode 100644 recipes-connectivity/openssh/files/sshd_config

diff --git a/recipes-connectivity/openssh/files/50-selinux.conf
b/recipes-connectivity/openssh/files/50-selinux.conf
new file mode 100644
index 0000000..775a24d
--- /dev/null
+++ b/recipes-connectivity/openssh/files/50-selinux.conf
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
diff --git a/recipes-connectivity/openssh/openssh_selinux.inc
b/recipes-connectivity/openssh/openssh_selinux.inc
index 07c25c5..9fab8b9 100644
--- a/recipes-connectivity/openssh/openssh_selinux.inc
+++ b/recipes-connectivity/openssh/openssh_selinux.inc
@@ -2,5 +2,18 @@ inherit enable-selinux enable-audit

 FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

+SRC_URI += " \
+    file://50-selinux.conf \
+"
+
+do_install:append() {
+    install -d ${D}${sysconfdir}/ssh/sshd_config.d
+    install -m 0644 ${UNPACKDIR}/50-selinux.conf \
+        ${D}${sysconfdir}/ssh/sshd_config.d/50-selinux.conf
+}
+
+FILES:${PN}-sshd:append = "
${sysconfdir}/ssh/sshd_config.d/50-selinux.conf"
+
 PACKAGECONFIG[selinux] = "--with-selinux,--without-selinux,libselinux"
 PACKAGECONFIG[audit] = "--with-audit=linux,--without-audit,audit"

