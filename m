Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95203C369DC
	for <webhook@archiver.kernel.org>; Wed, 30 Apr 2025 01:14:26 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web11.6704.1745975664586736789
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 29 Apr 2025 18:14:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=S9P6J7vO;
 spf=pass (domain: gmail.com, ip: 209.85.210.176, mailfrom: raj.khem@gmail.com)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7394945d37eso5799894b3a.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 29 Apr 2025 18:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745975664; x=1746580464; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XaLQww8/dOHfqO77EBjRLYjlxj0DLX1de9VcwGYDWf0=;
        b=S9P6J7vOoBHC8R3FMqpfrHDb+sRfX3J7V17oFrIRbKLIEqJjLCVMGCYcEx+N5q0F8B
         oocvomN4dmF+EKMCphXLpQS8ZgqcJbNkszQOFUDhDlM2Oy3oOMwFQEbCE/RkSY7scKqS
         BOSGxYlTIDFYAaqhwE5LgTduJkofv6JN4U4AEIOWg2JvdN9svfSt2cOZjFwfRaWI3Mg8
         6MB/FXfy3j0dIqmwscu7Nld1XzG0lDTIhjpApjfCaW7a/nYVml1NGzDpnxl8EFD1uXry
         u2Ge7E9LGHK3ash9txTIBTbDxD/3lFAT4pT9+PweE0UnbC7apogfI0JOp0Wi4CAHeP/9
         sRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745975664; x=1746580464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XaLQww8/dOHfqO77EBjRLYjlxj0DLX1de9VcwGYDWf0=;
        b=QtOuPRQotX2AXRkswRunhzUNr0INYvX+9+rg1NNMlVR+7AdlTDPVQm96jTXNDK56cx
         DuibgLyVqaKrtrBQIt+wBGGL+zGbV7uvr0ClriBy4jVbkjvcvqOsKB5phsDadvfkiKpQ
         CBSqulimMfwGGwWhXfMvOZnMXJLoQkdTnVtq4i5LJ3Wkffyd7ObEXX1bKBTqJlkJC/rE
         cUsHr8ynJN9LFkW9mXg2Tm98J849694KylwCo8oQvE4V8huNzRQeafT+ljueIeP/lX+a
         uGhKsLp32bRXzAMRe5NkncWGubrzpd6YXmzsVvFR3/R7+GcZfgX/aqoZWrYfCQ7+1XfM
         2N9A==
X-Gm-Message-State: AOJu0YzVYROKHg1TPw9aNN2BqJqDE7/5D4suKT9A0K37D1lWr+L0pRl5
	n+P/OCyxUpzWwME1d3VAhK9t4MhRxV51W0kYEvwTX5VGuQ/DZZVXxdMbQPJl
X-Gm-Gg: ASbGncs/612rI7rpUe5GOyCZpxvAlCU8/RwyucuM3cfbWFl+LEEotgJdsrZBp2jcxui
	ZGhnS85G0TGV8T3ewl1FND4iNNcGeLyPWoJsMw4rMt937ZsVV4BCa0pOWfLN3ZxxYG/JJn2Slb1
	y0XEdQ6CrqHNf7Nl/rosmrgqAii9o8hvcIjoH7/uL6ds8ifPj1cyg6Ug7DRNfcnqV+L0eThAQFy
	QSFqz2vRvSZ4/1ormmWMQ0nA5ZzGALvyRNSRJmtsjMMMmtoZli8SjGLm432mHx5SJ6Ebln3CdAT
	A6FIA72ndZoPwninoq7ShMTXpzn5CzN9
X-Google-Smtp-Source: AGHT+IENIDt+V9jaqy2W68d1Ofog61cmFeB0Hmc6Wp0tbEpN3MTB3/dVoEhdJC1VxMZMkaMPieI/CA==
X-Received: by 2002:a05:6a00:4b05:b0:736:ff65:3fcc with SMTP id d2e1a72fcca58-7403a811bbfmr1089752b3a.16.1745975663508;
        Tue, 29 Apr 2025 18:14:23 -0700 (PDT)
Received: from apollo.localdomain ([2601:646:8201:fd20::b8ae])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a8fbe7sm381021b3a.160.2025.04.29.18.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 18:14:23 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com,
	Khem Raj <raj.khem@gmail.com>
Subject: [meta-mingw] [PATCH] libiconv: Upgrade to 1.18 release
Date: Tue, 29 Apr 2025 18:14:17 -0700
Message-ID: <20250430011417.3818902-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 30 Apr 2025 01:14:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1423

The libiconv and charset library is now licensed under the LGPL version 2.1
instead of the LGPL version 2.0 previously. Programs e.g. iconv are under
GPL 3.0

1.18 Release notes [1]

Helps fixing build breaks seen with GCC15

[1] https://savannah.gnu.org/news/?id=10703

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 .../libiconv/{libiconv_1.15.bb => libiconv_1.18.bb}    | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
 rename recipes-support/libiconv/{libiconv_1.15.bb => libiconv_1.18.bb} (82%)

diff --git a/recipes-support/libiconv/libiconv_1.15.bb b/recipes-support/libiconv/libiconv_1.18.bb
similarity index 82%
rename from recipes-support/libiconv/libiconv_1.15.bb
rename to recipes-support/libiconv/libiconv_1.18.bb
index 2f2b473..c7c6332 100644
--- a/recipes-support/libiconv/libiconv_1.15.bb
+++ b/recipes-support/libiconv/libiconv_1.18.bb
@@ -6,14 +6,14 @@ SECTION = "libs"
 NOTES = "Needs to be stripped down to: ascii iso8859-1 eucjp iso-2022jp gb utf8"
 PROVIDES = "virtual/libiconv"
 PR = "r1"
-LICENSE = "LGPL-3.0-only"
-LIC_FILES_CHKSUM = "file://COPYING.LIB;md5=9f604d8a4f8e74f4f5140845a21b6674 \
-                    file://libcharset/COPYING.LIB;md5=9f604d8a4f8e74f4f5140845a21b6674"
+LICENSE = "GPL-3.0-only & LGPL-2.1-only"
+LIC_FILES_CHKSUM = "file://COPYING;md5=d32239bcb673463ab874e80d47fae504 \
+					file://COPYING.LIB;md5=4bf661c1e3793e55c8d1051bc5e0ae21 \
+                    file://libcharset/COPYING.LIB;md5=4bf661c1e3793e55c8d1051bc5e0ae21"
 
 SRC_URI = "${GNU_MIRROR}/${BPN}/${BPN}-${PV}.tar.gz"
 
-SRC_URI[md5sum] = "ace8b5f2db42f7b3b3057585e80d9808"
-SRC_URI[sha256sum] = "ccf536620a45458d26ba83887a983b96827001e92a13847b45e4925cc8913178"
+SRC_URI[sha256sum] = "3b08f5f4f9b4eb82f151a7040bfd6fe6c6fb922efe4b1659c66ea933276965e8"
 
 S = "${WORKDIR}/libiconv-${PV}"
 

