Return-Path: <gael.portay@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5043FC41513
	for <webhook@archiver.kernel.org>; Wed, 26 Jun 2024 13:40:00 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.web10.26803.1719409193971081300
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Jun 2024 06:39:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kuoneWNw;
 spf=pass (domain: gmail.com, ip: 209.85.167.53, mailfrom: gael.portay@gmail.com)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52ce01403f6so4048979e87.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Jun 2024 06:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719409192; x=1720013992; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDZpnszQ2LqFoGieADXDq5MVS5vEWsmeErLhwQGFBZA=;
        b=kuoneWNwMWC5DTj5cowlEIwrjmgLao0DU0CXdvDJ2eKs2EsJ2eGxKjwc4rrSKdW/X3
         RgT2NERGzRcxORYuABblqORi9ar0pMIjR50Qt83gYhdsb32HMRtWgHg/ZiGwBY40YjlW
         NAaCJQYm0EbaaPLHdvsY5cFa7FrQf4x6ZWu+y6snpDG9txuq04iAiZ1ZSJE4ur7p72ZA
         xa3WZn8uWh+BGiy7Qn7gBgcL0Q4q8o2RngmZA6GQ9FG/HN+xJSkB2uNUpHZbjGR1nFXM
         FnVsRNDM80i0FmpskZh3QoTf8hx3Q17xTH2HUix/bd55BwZhL3+mKGm0icTMP2RDQwWB
         N7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719409192; x=1720013992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDZpnszQ2LqFoGieADXDq5MVS5vEWsmeErLhwQGFBZA=;
        b=RuZo8e70tChjbLSJXcVjHubmcqJAbON62GAdEoq0nuC7vVcOF3KB1kvCztjnJLdq6N
         nd8+xgMpvOeTg2By/lrhCN2GgfhEVxzionhAH5MUp+sOmBVlPvROCRQoamG+LOKZG9Dq
         5ZQvGXBd5mEHptRSawRDdklxvKKg2Q0cUigMH7c882I30bkVyJ4Ax3DJ3WnEELxv/GJn
         L/InBvKeQRc7Qw79S8J5qnZSuXIkzTDXAraou8tMo+KHuXyP/wLo+EMhhbjQ7mRqIDJt
         uDNCFnpEoZIC0dpFkZe05xCCv5AwA5XeY3PK/wolX2ZTpeeh9J3YYv7i6TjnSfi+LCD9
         jRvA==
X-Gm-Message-State: AOJu0YzHRC2Em2Oh47fQdRFBXBVNPYNPV9UhInaxRHrOa3iyLjXBxFV0
	OLS9XkP/7x7En1DDR8wAtvyOFoVIbtIlVIavLc++qif11IrN+40VO73IK7+F
X-Google-Smtp-Source: AGHT+IF8qtSAdskP0QC2ymnD7FIOO0qPBfGgyTJW46k1RvLQUhP38iIrQvtzVfsU1hGlGmQJJ5uCxA==
X-Received: by 2002:ac2:4a78:0:b0:52c:da77:d71c with SMTP id 2adb3069b0e04-52ce185ecb4mr6187694e87.54.1719409191610;
        Wed, 26 Jun 2024 06:39:51 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:ce:f2f0:2a6b:35ff:feb8:77d9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c7befsm15802533f8f.95.2024.06.26.06.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:39:50 -0700 (PDT)
From: "=?UTF-8?q?Ga=C3=ABl=20PORTAY?=" <gael.portay@gmail.com>
X-Google-Original-From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@rtone.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: gael.portay+yocto@gmail.com,
	=?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@rtone.fr>
Subject: [meta-security,kirkstone][PATCH 3/5] sssd: fix issue if build machine is Debian
Date: Wed, 26 Jun 2024 15:39:11 +0200
Message-ID: <20240626133913.790145-4-gael.portay@rtone.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626133913.790145-1-gael.portay@rtone.fr>
References: <20240626133913.790145-1-gael.portay@rtone.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Jun 2024 13:40:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/377

The configure script guesses the target system from the host if no
--with-os= is set[1]. It is untrue if cross-compiling.

The guessed host operating system is used then to do specific things
fort target build.

The commit[2] passes the downstream debian option --install-layout=deb
to setup.py[3] if the host system is debian based, and thus, it raises
the error attached below as that debian-specific option[4] is not part
of the openembedded[5] world.

This sets the Fedora operating system thanks to the existing configure
option --with-os=fedora, that is relatively sain operating system for
the needs of openembedded.

Fixes:

	| (...)/build/tmp/work/aarch64-poky-linux/sssd/2.5.2-r0/build/src/config/setup.py:25: DeprecationWarning: The distutils package is deprecated and slated for removal in Python 3.12. Use setuptools or check PEP 632 for potential alternatives
	|   from distutils.core import setup
	| usage: setup.py [global_opts] cmd1 [cmd1_opts] [cmd2 [cmd2_opts] ...]
	|    or: setup.py --help [cmd1 cmd2 ...]
	|    or: setup.py --help-commands
	|    or: setup.py cmd --help
	|
	| error: option --install-layout not recognized

Note: Upstream has introduced the "unknown" operating systemd with the
upcoming version 2.10.0[6][7]. The change can be backported.

[1]: https://github.com/SSSD/sssd/blob/2.5.2/src/external/platform.m4#L1-L31
[2]: https://github.com/SSSD/sssd/commit/e6ae55d5423434d5dc6c236e8647b33610d30e2e
[3]: https://github.com/SSSD/sssd/blob/2.5.2/Makefile.am#L32-L35
[4]: https://sources.debian.org/patches/setuptools/68.1.2-2/install-layout.diff/#L7
[5]: https://git.openembedded.org/openembedded-core/tree/meta/recipes-devtools/python/python3-setuptools_59.5.0.bb?h=kirkstone
[6]: https://github.com/SSSD/sssd/commit/7b32dc0ab877a9061b52868b8efe6866c3144b63
[7]: https://github.com/SSSD/sssd/pull/7398

Signed-off-by: Gaël PORTAY <gael.portay@rtone.fr>
---
 recipes-security/sssd/sssd_2.5.2.bb | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-security/sssd/sssd_2.5.2.bb b/recipes-security/sssd/sssd_2.5.2.bb
index 98a4b5e..9991667 100644
--- a/recipes-security/sssd/sssd_2.5.2.bb
+++ b/recipes-security/sssd/sssd_2.5.2.bb
@@ -73,6 +73,7 @@ EXTRA_OECONF += " \
     --without-secrets \
     --with-xml-catalog-path=${STAGING_ETCDIR_NATIVE}/xml/catalog \
     --with-pid-path=/run \
+    --with-os=fedora \
 "
 
 do_configure:prepend() {
-- 
2.45.2


