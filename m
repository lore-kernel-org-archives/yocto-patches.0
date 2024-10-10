Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D18CF11D0
	for <webhook@archiver.kernel.org>; Thu, 10 Oct 2024 11:35:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.41194.1728560120777405814
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 10 Oct 2024 04:35:20 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2126DA7;
	Thu, 10 Oct 2024 04:35:49 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.oss.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B6AFA3F58B;
	Thu, 10 Oct 2024 04:35:19 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: anibal@limonsoftware.com
Subject: [ptest-runner][PATCH 2/2] Makefile: use pkg-config to obtain libcheck flags
Date: Thu, 10 Oct 2024 12:35:09 +0100
Message-Id: <20241010113509.3874077-2-ross.burton@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010113509.3874077-1-ross.burton@arm.com>
References: <20241010113509.3874077-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 10 Oct 2024 11:35:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/700

Don't hardcode the linkage, instead use pkg-config to find the required
flags.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 08bc19c..662ced7 100644
--- a/Makefile
+++ b/Makefile
@@ -27,8 +27,8 @@ EXECUTABLE=3Dptest-runner
 TEST_SOURCES=3Dtests/main.c tests/ptest_list.c tests/utils.c $(BASE_SOUR=
CES)
 TEST_OBJECTS=3D$(TEST_SOURCES:.c=3D.o)
 TEST_EXECUTABLE=3Dptest-runner-test
-TEST_LDFLAGS=3D-lm -lrt -lpthread
-TEST_LIBSTATIC=3D-lcheck -lsubunit -lutil
+TEST_CFLAGS=3D$(shell pkg-config --cflags check)
+TEST_LDFLAGS=3D$(shell pkg-config --libs check)
=20
 TEST_DATA=3D$(shell echo `pwd`/tests/data)
=20
@@ -40,7 +40,7 @@ $(EXECUTABLE): $(OBJECTS)
 tests: $(TEST_SOURCES) $(TEST_EXECUTABLE)
=20
 $(TEST_EXECUTABLE): $(TEST_OBJECTS)
-	$(CC) $(LDFLAGS) $(TEST_OBJECTS) -o $@ $(TEST_LIBSTATIC) $(TEST_LDFLAGS=
)
+	$(CC) $(LDFLAGS) $(TEST_OBJECTS) -o $@ $(TEST_CFLAGS) $(TEST_LDFLAGS)
=20
 check: $(TEST_EXECUTABLE)
 	PATH=3D.:$(PATH) ./$(TEST_EXECUTABLE) -d $(TEST_DATA)
--=20
2.34.1


