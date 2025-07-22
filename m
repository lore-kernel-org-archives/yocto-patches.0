Return-Path: <levi.shafter@elder-tomes.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C39C83F27
	for <webhook@archiver.kernel.org>; Tue, 22 Jul 2025 20:31:35 +0000 (UTC)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
 by mx.groups.io with SMTP id smtpd.web11.23774.1753216292843168277
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 22 Jul 2025 13:31:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@elder-tomes-com.20230601.gappssmtp.com header.s=20230601 header.b=ntWdekM9;
 spf=pass (domain: elder-tomes.com, ip: 209.85.166.180, mailfrom: levi.shafter@elder-tomes.com)
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3e292dcc066so44060715ab.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 22 Jul 2025 13:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elder-tomes-com.20230601.gappssmtp.com; s=20230601; t=1753216292; x=1753821092; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Na+L/TrcBmDGt8KOefrI28jxZ8ZDkox8PC2pHEU1R60=;
        b=ntWdekM9WxyJ0N8Trf29nhSbBmK3+3XpDG81givGJOp6n70k86IXp2ur0KlSLR9xWk
         pscUarHq9YPIofTMqEkHuVs5vs2BXJM8JbVFGvZiQjvLTdpMxnJ2d3mUISR/Jm9EXey5
         BxAROoH9nh0llK2NZJviUw4cSnuTQlvYCt+plMjVbN6DAB0H88RxukRm5xqvX5A9GIFA
         2maEIx23SBbeFhZzNghZKKNJM3siFACUxwyrcebn404KNoXSGEtxe/At8Gi8sH3jMuPT
         hXLaw5lhbnnV97nQg6wn/Ycn4dthM22Qb+4P0djcsjKrFTKiiZRloV8LUITvp7i3IW90
         sauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753216292; x=1753821092;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Na+L/TrcBmDGt8KOefrI28jxZ8ZDkox8PC2pHEU1R60=;
        b=EbakwZGdjUtAVv7SALodS4if9yPg6ip/48hr8mKk3KS4qpqNYd8Xeu/6zfMDugUvDY
         OscznOl4HFvqLJkD3do4awMF4iQ3xhPnUbWO0SHBBYAOsNQzglZxvmz/dpbbTBG1BAc4
         HsqJh9uwfyPl6LRqSmvZoWBCe9gHb1SBfTwAgPoa4mZWgi/nqDz8Jb75I1DrRzQQZgN9
         0XpE2LHe+8FRUJ/dSE3rY+KYWVWyP6e5zz2VQfuOm+HuyUAqTsUqVTRshKEJdlFh0TH7
         j4SZMuiM6CHS91C+Hq7ASGMQJLMnQ+bS+rfaQkINs2G90SoHMh4h4IlEC+eJ1qmTtqoi
         F7pA==
X-Gm-Message-State: AOJu0YxXVcX85IqwRBwxNV/iWAnjNxsXdzOVQ/CDrYKnnpMJPF99OS/e
	gHKGxyRH0QR2olCLXev+3hkcCGlgDHMt6MA0xndTa2hWR/iOA6FHFJShsX8rSanovvdcd4G05Ep
	CJ55QkX0=
X-Gm-Gg: ASbGnctzjrP+nOgwoE91/3scbxC2NYAqs027/DPxnieDvWFEr/HKuZLM2wDy03gpEck
	VVaT4+eacJ7EvrbUHkGIDmLQvXlWDyB1n19XyWgKOpOkZXL9y8MvdNJjjIXRWjtq6gd4jHhrU+f
	LNX5uBquIcTDZYOL9jjC2nw1UxCByOW8G6vdREphVeUqCub+km0aCztumbQdDZnWgj5t/Bq5xgq
	o/5FlAUOSn79WaGZ3si6PlT1leu2D6P/o7nGqeT2+wlAA3T8PTMnpuOGryA5TI08ol3aOCpI+Xg
	meZROwAVBbqh4t6WQF/EsU2znt+euVtZ4jM+PpiRVE7/bbDMmoZ5smLPJTBhVlvH8w/IjktHvPk
	7YaPfs5x5i2D7iBpKhm2l5lbjbrGVGHfLk5g6s1vCOgG6ltCqWzif2INkegVaNqkT/4VvNdk=
X-Google-Smtp-Source: AGHT+IFQunGtmY+4bmOmiX+z/FsAcmfNDi7/dUbu8x6q8ISfekTOenN/286isT5Ivo6jEYd/iVDB9g==
X-Received: by 2002:a05:6e02:32ca:b0:3e2:9e61:433c with SMTP id e9e14a558f8ab-3e335559aa0mr8779785ab.15.1753216291496;
        Tue, 22 Jul 2025 13:31:31 -0700 (PDT)
Received: from [192.168.1.8] (c-75-70-150-54.hsd1.co.comcast.net. [75.70.150.54])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e298160ddcsm33523305ab.19.2025.07.22.13.31.30
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 13:31:31 -0700 (PDT)
Message-ID: <01068fb4-eb25-4d6c-95c8-98007719d4ea@elder-tomes.com>
Date: Tue, 22 Jul 2025 14:31:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org
From: Levi Shafter <levi.shafter@elder-tomes.com>
Subject: [meta-selinux][PATCH] openssh: use config snippet instead of file
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 22 Jul 2025 20:31:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1823

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

Suggested-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Signed-off-by: Levi Shafter <levi.shafter@elder-tomes.com>
---
Sponsor: 21SoftWare LLC

Note: I am particularly interested in feedback regarding the naming of
the snippet. Since the only difference in requirements between oe-core
and meta-selinux is the fact that meta-selinux must have PAM
authentication enabled, I simply named it "selinux" in case future
configuration is required. However, this file name could be renamed in
this case, and one could argue that it would be better to specify what
the snippet actually does in its title.

Additionally, I was unsure which load-order prefix to give this snippet.
I stuck with a perfectly balanced 50, but I encourage feedback if you
might have a good reason to change this.

 .../openssh/files/sshd_config                 | 118 ------------------
 .../files/sshd_config.d/50-selinux.conf       |  15 +++
 2 files changed, 15 insertions(+), 118 deletions(-)
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

