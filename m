Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F226CCD183
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 21:22:55 +0000 (UTC)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
 by mx.groups.io with SMTP id smtpd.web11.1678.1760649766496865460
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Oct 2025 14:22:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=HjFLZuEP;
 spf=pass (domain: konsulko.com, ip: 209.85.222.176, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-88f239686f2so155133185a.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 14:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1760649765; x=1761254565; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrhsAjEyPPEONGf6+MKW7l+t5yIrkIEdrb3tXFh98Pk=;
        b=HjFLZuEPL5J6uiRh+lZyggNzuG/RZL9mYxASWHkFKhgZHivONJQ95MgWtnUBz6IuQt
         XCjN0RDWZ3UVRda2ounWxeP3EwIMZkXkBVbqi2MRGgl+g+4fMsWw2u0N4oiDmnDxirKs
         6T19V3/keeO5LUgRFNYMyG6H3+5ntNzWkEK6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760649765; x=1761254565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrhsAjEyPPEONGf6+MKW7l+t5yIrkIEdrb3tXFh98Pk=;
        b=I8RGolAo25LNQebyygaGHYowhNRr/rSZBhYjS8NqcWj9ZqJwjdysLF9gq5xoXLVFxT
         /Gzc4PhgrCwt7y/SAlThkNvP/pahE8Pbmlkh35RikWlBr3HPeB/I52qXs8OiYvwly03B
         LHx6wHi8Sgfo2VRRecMFTrn6aWZ2G7WKpj8T0IrYgD0ZIpu+0TVZbGf8j7daq8RXAzVM
         b+Kgz4h11Hm/3irLnYUHA1sOaaxGXe/vDjKQhU+0GPJACpGMqlfOpA1CGUCCR1xkQtj/
         L9io134ny+IBFOB+gEyT6SML1pBr+nYxtexyLYcJqTtAWooeHWsGEnDb/lsezwFN50cA
         zmPQ==
X-Gm-Message-State: AOJu0YzhDJQK0AwBaSoZ4jlgbXqEfyvb+dVkDQMlk924rdO+dSIwrTKU
	aVfCrMa8PiHjzkxuRwzRiD6XUrDbFJsSuBMH5c+cluXiHz/B03nQOiwsrwEdhtEBToqPlO3fyAP
	ixthX
X-Gm-Gg: ASbGncvrU8dqbXCXievtImMv4Otq8NyTYH9ctdyDKSCH6k4FM+ZDqC+irM5am2w42tN
	r+dXCM8yr3/C1oSNjmJ78XZkkxFChth4T4tabx8FoJugLyGlwJDz+/3HPXk3gikXhL5hIRssDFG
	4LyBe1bmI/VZcqD5T8UkzjNj/0js+f/umUf/mc6vVFUfJMuNbDG3WWlisXBDDE2MU7U2ad0Ka5d
	jTC8nccRu1rEWboBPeMShQ2Ta1hNQ5tLH9cNPbPTdV41UbxS0rhqsl+KZtjDFbcyxn48DOVyiEc
	ChidVi0VWqFN3xhE2ImuytDSKjDAhkbhbnE4cLFoKvH/dJDKUNqi0ljAsl663lGXL0nq/6X6oiz
	Ys2/M27cB1jvJ0BmOSb1hvOYssvHem4RmssDHbFrdfaC31zhRfXSMBQtEOklQWOv9qf6St9KovG
	NLPMxnD8YLiLyjrJzaB5HLYxR1knZswRGXcIDluK7nk8k0J/zc+ElV
X-Google-Smtp-Source: AGHT+IHXAvHOBbR2fdjHnZ+4PETsSx2jM24C7aJuQ9AIOF4ORf++Y1UTtqoW45yTibgIeahYqbo77w==
X-Received: by 2002:ac8:7fc9:0:b0:4da:bbcd:2b89 with SMTP id d75a77b69052e-4e89d2818d1mr24968061cf.18.1760649765119;
        Thu, 16 Oct 2025 14:22:45 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c1c2fd4f4sm14647466d6.7.2025.10.16.14.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 14:22:44 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Subject: [meta-security][PATCH 14/15] packagegroup-core-security: update for recent changes
Date: Thu, 16 Oct 2025 17:22:13 -0400
Message-ID: <f2604bdc5ff14f2a95f106c3190fef70f098f333.1760648348.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760648348.git.scott.murray@konsulko.com>
References: <cover.1760648348.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 21:22:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2339

Changes:
- Add libmhash and libgssglue so they will get tested by CI.
- Switch to MACHINE_ARCH to facilitate the above, but it makes sense
  anyway due to all the machine overrides used in the packagegroup
  definition.
- Add the recently added python3-suricata-update so it will get
  tested by CI.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../packagegroup/packagegroup-core-security.bb    | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/recipes-core/packagegroup/packagegroup-core-security.bb b/recipes-core/packagegroup/packagegroup-core-security.bb
index 7fb7b62..9c14240 100644
--- a/recipes-core/packagegroup/packagegroup-core-security.bb
+++ b/recipes-core/packagegroup/packagegroup-core-security.bb
@@ -3,6 +3,8 @@ LICENSE = "MIT"
 LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302 \
                     file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"
 
+PACKAGE_ARCH = "${MACHINE_ARCH}"
+
 inherit packagegroup
 
 PACKAGES = "\
@@ -36,6 +38,8 @@ RDEPENDS:packagegroup-security-utils = "\
     fscryptctl \
     glome \
     keyutils \
+    libgssglue \
+    libmhash \
     nmap \
     pinentry \
     softhsm \
@@ -80,15 +84,16 @@ SUMMARY:packagegroup-security-ids = "Security Intrusion Detection systems"
 RDEPENDS:packagegroup-security-ids = " \
     samhain-standalone \
     suricata \
+    python3-suricata-update \
     ossec-hids \
     aide \
     "
 
-RDEPENDS:packagegroup-security-ids:remove:powerpc = "suricata"
-RDEPENDS:packagegroup-security-ids:remove:powerpc64le = "suricata"
-RDEPENDS:packagegroup-security-ids:remove:powerpc64 = "suricata"
-RDEPENDS:packagegroup-security-ids:remove:riscv32 = "suricata"
-RDEPENDS:packagegroup-security-ids:remove:riscv64 = "suricata"
+RDEPENDS:packagegroup-security-ids:remove:powerpc = "suricata python3-suricata-update"
+RDEPENDS:packagegroup-security-ids:remove:powerpc64le = "suricata python3-suricata-update"
+RDEPENDS:packagegroup-security-ids:remove:powerpc64 = "suricata python3-suricata-update"
+RDEPENDS:packagegroup-security-ids:remove:riscv32 = "suricata python3-suricata-update"
+RDEPENDS:packagegroup-security-ids:remove:riscv64 = "suricata python3-suricata-update"
 RDEPENDS:packagegroup-security-ids:remove:libc-musl = "ossec-hids"
 RDEPENDS:packagegroup-security-ids:remove:libc-musl = "aide"
 
-- 
2.51.0


