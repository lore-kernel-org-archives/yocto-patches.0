Return-Path: <gael.portay@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF1CC30659
	for <webhook@archiver.kernel.org>; Wed, 26 Jun 2024 13:40:01 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.27021.1719409196215474174
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Jun 2024 06:39:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mtir9GPX;
 spf=pass (domain: gmail.com, ip: 209.85.221.44, mailfrom: gael.portay@gmail.com)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-364a3d5d901so4566491f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Jun 2024 06:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719409194; x=1720013994; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrWsSMLSc57sTZxFc1FJtgniB+QwqRbXWCAf0m+0r+E=;
        b=mtir9GPXP9FRnpSAJP8jrLzwVco7M5nZWuuFGUU24yT2ZkmbdOeTYFYX3ILoNwLIvh
         OriEBOLAsqX3Hm1thMmzb89P2yQ1BoskxiTH5zUOk5YFHvm7Ul8fox/bLMtk8QEX3o2l
         JRxVenP/q29t/sKC2P2eXZZpn9La5WSx9GsjyiF9iqd9V/CZAeyUIpRTzI3Q2WQu5557
         mFtz91ZAv3+NU0R/yPtkh3+RCtTNFgEIC/w1PU8gPdE8ASycpaham1vBFwge7qH4VSGy
         hUvKQFNXPR7f4Ms29/vY2C3jghwPxLrdRHg2GhDVCxNznSypyE9BEzAeHSwM2ZjMfrUk
         tjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719409194; x=1720013994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GrWsSMLSc57sTZxFc1FJtgniB+QwqRbXWCAf0m+0r+E=;
        b=Tiwp2no2fjK5iR0vHWli7CcogpuEu84E+BBWAtaQvHdId3gk53Yajlk+yneIJkZevW
         b/+WvAyIuvyJ7H4aHA7GLMwbQwfgO6eD5t6IlF1zHK5pUogRw33CXVfaLNXRf0zoBo3E
         3mEqhgTvUjQRBORmZJ0LIYzN/1wTawX+OLyracwOsChYHVVi0vJeVnUBtGhLVWU1dXUg
         HNVp3ykx6DZjNSar1gM/NeBGvZhlKUfaPePSTX9MNoD2sHsnyV66rufKG/ubRb6zkf5e
         4zAGtrtnJokWfiNQX2dptVQ0LeA1Yd863vZjeufBZCKoyTIrTMKAwH5cbAVw0y/FnrOq
         KMUA==
X-Gm-Message-State: AOJu0YyyDGNlZRMN7EvXNsjHzEk/SPLWqV4/4VuClQQybQPVnriXj0BN
	IAIZVPiMvjX9JrkX5gFYblTvYo494A88wokp3XWIC7atGzP+nRF7ZSpxjPip
X-Google-Smtp-Source: AGHT+IGapkMY2v/0BjzTZTkySDCBA0EKw/JFlIebKbMBwxNGASrIOwlG0YOGwCNzJGmPv1kRTvc1JA==
X-Received: by 2002:a05:6000:2c2:b0:366:ef25:de51 with SMTP id ffacd0b85a97d-366ef25df70mr8031075f8f.49.1719409193838;
        Wed, 26 Jun 2024 06:39:53 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:ce:f2f0:2a6b:35ff:feb8:77d9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c7befsm15802533f8f.95.2024.06.26.06.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:39:52 -0700 (PDT)
From: "=?UTF-8?q?Ga=C3=ABl=20PORTAY?=" <gael.portay@gmail.com>
X-Google-Original-From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@rtone.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: gael.portay+yocto@gmail.com,
	=?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@rtone.fr>
Subject: [meta-security,kirkstone][PATCH 5/5] sssd: fix path to python3 interpreter
Date: Wed, 26 Jun 2024 15:39:13 +0200
Message-ID: <20240626133913.790145-6-gael.portay@rtone.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626133913.790145-1-gael.portay@rtone.fr>
References: <20240626133913.790145-1-gael.portay@rtone.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Jun 2024 13:40:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/379

The project uses /usr/bin/python as the path to the python3 interpreter
in the shebang of the python3 script /usr/sbin/sss_obfuscate[1].

OpenEmbedded uses /usr/bin/python3, and thus, it causes bitbake to raise
the QA issue attached below.

This fixes the path to the python3 interpreter by sed'ing the shebang at
do_install if the python3 is set in the PACKAGECONFIG.

Fixes:

	ERROR: sssd-2.5.2-r0 do_package_qa: QA Issue: /usr/sbin/sss_obfuscate contained in package sssd-python requires /usr/bin/python, but no providers found in RDEPENDS:sssd-python? [file-rdeps]
	ERROR: sssd-2.5.2-r0 do_package_qa: Fatal QA errors were found, failing task.

[1]: https://github.com/SSSD/sssd/blob/2.5.2/src/tools/sss_obfuscate#L1

Signed-off-by: Gaël PORTAY <gael.portay@rtone.fr>
---
 recipes-security/sssd/sssd_2.5.2.bb | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/recipes-security/sssd/sssd_2.5.2.bb b/recipes-security/sssd/sssd_2.5.2.bb
index 4084d07..92e339a 100644
--- a/recipes-security/sssd/sssd_2.5.2.bb
+++ b/recipes-security/sssd/sssd_2.5.2.bb
@@ -109,6 +109,10 @@ do_install () {
         echo "d ${SSSD_UID}:${SSSD_GID} 0755 ${localstatedir}/log/${BPN} none" > ${D}${sysconfdir}/default/volatiles/99_${BPN}
     fi
 
+    if ${@bb.utils.contains('PACKAGECONFIG', 'python3', 'true', 'false', d)}; then
+        sed '1s,/usr/bin/python,/usr/bin/python3,' -i ${D}${sbindir}/sss_obfuscate
+    fi
+
     # Remove /run as it is created on startup
     rm -rf ${D}/run
 
-- 
2.45.2


