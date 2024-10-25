Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD7DD1039D
	for <webhook@archiver.kernel.org>; Fri, 25 Oct 2024 08:22:56 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.7398.1729844574192050179
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 25 Oct 2024 01:22:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=OqzbY74+;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43158124a54so2501925e9.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 25 Oct 2024 01:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729844572; x=1730449372; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFxYzpa4BhKxqab45ynZXcXPb3S5mzOjWmA69N8mguU=;
        b=OqzbY74+2Zo9FUn7Y48SE76cF1X2ly4sw2SWih8jAld27Ko4/bL/+qbBDownm9NHPP
         /fF4tX8FfZvLyeMR830WpTI0rR/wDd5FL8vgTWfUeX95eW68Yo36pz2Ai0KCdDbYWO1l
         eNP7ymE/TJjKaYKbq9FU3+nbbeZlABCIJl4b4SjvRL72mjup+4pDschEzIgZdzPeuOSY
         W6vhPS0RpqC9sw4om7/k3x6LM5rCbF/n3B6E48QBEBJZSElSDIDcolgZn9zQ/dQBxbvP
         1HI/+wbY2nZMjGyzejl9B3CyaRQ1d3mfBYfTmEqLr2ipCLEY5ZrePxAYJWMoKEI8Gicf
         JHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729844572; x=1730449372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nFxYzpa4BhKxqab45ynZXcXPb3S5mzOjWmA69N8mguU=;
        b=Jo/RXYYIjLXHdL9TDm8e1udgFic40cvlaj+pw0t+FgVCoxsASKLkfi566JJWNpWAIc
         YcBy3rF4dSS+kVCQEKLUwCq3ciaqxii/MYtR+MvikatMP+XwqD+7hRV1rpOk0Qm1G/1R
         EcAsSvr13Y5zVtFPnXILBq4cWBZs2rFPj2BGc74Y3A+0chmfg4TwaTkT3i0pV5f5MJJi
         MeL4rG3ZqhVFwZC6KkejNm1/Augucgg/K+daklRqLy7cJ2ydW3yp2CjalQzC9wRMxphO
         2NveBRYnxWAMAy4aogWBw0jYKntfWgN7gGU9edmC0hg+RAujxN5ce7yUkdwvonXN6AX/
         jtWQ==
X-Gm-Message-State: AOJu0YxLaVrO0RTmG3ywUFGRqDszq3SAOoycFtJBIoZd7IpRgs0Dc8Mh
	7U+aXfGr0DUV+qmms8RQZWQAcAQ+mTWaQAnlUuhk2mkbC4lYyKEsIVvWdC2+
X-Google-Smtp-Source: AGHT+IF5MKOBO2uVKAvoprm+W07GWcMuYVhLL4ih7ufAy3neYPoAPFQipyFaO1IqyBhs8MB+98Zilw==
X-Received: by 2002:a5d:648c:0:b0:37c:cf75:3945 with SMTP id ffacd0b85a97d-3805b4ad8c2mr262625f8f.13.1729844572116;
        Fri, 25 Oct 2024 01:22:52 -0700 (PDT)
Received: from archlinux.. ([2a01:e0a:ce:f2f0:2a6b:35ff:feb8:77d9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70bc1sm907904f8f.70.2024.10.25.01.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 01:22:51 -0700 (PDT)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@rtone.fr>,
	=?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [meta-security][PATCH 07/10] sssd: fix issue if build machine is Debian
Date: Fri, 25 Oct 2024 10:22:36 +0200
Message-ID: <20241025082239.3468351-8-gael.portay+rtone@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025082239.3468351-1-gael.portay+rtone@gmail.com>
References: <20241025082239.3468351-1-gael.portay+rtone@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 25 Oct 2024 08:22:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/755

From: Gaël PORTAY <gael.portay@rtone.fr>

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

	| Traceback (most recent call last):
	|   File "/home/gportay/src/openembedded-tests/build/tmp/work/core2-64-poky-linux/sssd/2.9.2/build/src/config/setup.py", line 25, in <module>
	|     from distutils.core import setup
	| ModuleNotFoundError: No module named 'distutils'

Note: Upstream has introduced the "unknown" operating systemd with the
upcoming version 2.10.0[6][7]. The change can be backported.

[1]: https://github.com/SSSD/sssd/blob/2.5.2/src/external/platform.m4#L1-L31
[2]: https://github.com/SSSD/sssd/commit/e6ae55d5423434d5dc6c236e8647b33610d30e2e
[3]: https://github.com/SSSD/sssd/blob/2.5.2/Makefile.am#L32-L35
[4]: https://sources.debian.org/patches/setuptools/68.1.2-2/install-layout.diff/#L7
[5]: https://git.openembedded.org/openembedded-core/tree/meta/recipes-devtools/python/python3-setuptools_59.5.0.bb?h=kirkstone
[6]: https://github.com/SSSD/sssd/commit/7b32dc0ab877a9061b52868b8efe6866c3144b63
[7]: https://github.com/SSSD/sssd/pull/7398

Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
---
 .../networking-layer/recipes-security/sssd/sssd_2.9.2.bb         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
index 16e1c24..6a74a51 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
@@ -69,6 +69,7 @@ EXTRA_OECONF += " \
     --enable-pammoddir=${base_libdir}/security \
     --with-xml-catalog-path=${STAGING_ETCDIR_NATIVE}/xml/catalog \
     --with-pid-path=/run \
+    --with-os=fedora \
 "
 
 do_configure:prepend() {
-- 
2.47.0


