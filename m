Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0D4CF11D1
	for <webhook@archiver.kernel.org>; Thu, 10 Oct 2024 11:35:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.41053.1728560120319039060
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 10 Oct 2024 04:35:20 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DF83497;
	Thu, 10 Oct 2024 04:35:49 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.oss.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E6F533F58B;
	Thu, 10 Oct 2024 04:35:18 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: anibal@limonsoftware.com
Subject: [ptest-runner][PATCH 1/2] Makefile: remove redundant rule
Date: Thu, 10 Oct 2024 12:35:08 +0100
Message-Id: <20241010113509.3874077-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 10 Oct 2024 11:35:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/699

Make already knows how to build a .o from a .c.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Makefile b/Makefile
index 168cf5a..08bc19c 100644
--- a/Makefile
+++ b/Makefile
@@ -45,9 +45,6 @@ $(TEST_EXECUTABLE): $(TEST_OBJECTS)
 check: $(TEST_EXECUTABLE)
 	PATH=3D.:$(PATH) ./$(TEST_EXECUTABLE) -d $(TEST_DATA)
=20
-.c.o:
-	$(CC) $(CFLAGS) -c $< -o $@
-
 clean:
 	rm -rf $(EXECUTABLE) $(OBJECTS) $(TEST_EXECUTABLE) $(TEST_OBJECTS)
=20
--=20
2.34.1


