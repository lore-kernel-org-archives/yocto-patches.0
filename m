Return-Path: <vanusuri@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853C0CA1002
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 13:01:10 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web10.38861.1756990866347176324
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 04 Sep 2025 06:01:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=DtUxdcAn;
 spf=pass (domain: mvista.com, ip: 209.85.214.177, mailfrom: vanusuri@mvista.com)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2445806df50so9268095ad.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 04 Sep 2025 06:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1756990865; x=1757595665; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=17u7I6+8n17mHuxpBdEn4Nm99hSx8ggo9jB0nKqQXVY=;
        b=DtUxdcAn39rvg0dp84juSiG1pjBMhZ91O7N9LDeUid54+gaCO1lbqV4CDfF2pQ/jwl
         RJ+3q8L87Qx3prxglY/WtgNn3zj3agR+mw32k/wOmMIAJfJMQ+s2IPYVWi8WCZlehmdO
         VAqi4hzhx2WCC7PEi5eAglmAB8+lZRKBr/wnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756990865; x=1757595665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17u7I6+8n17mHuxpBdEn4Nm99hSx8ggo9jB0nKqQXVY=;
        b=RA/DaIQ4qUBOyhc+Y2u9MVOreMPqW4/dTuK+e2VcsRUzT+H96pCQcG7JXnUoc43Izt
         JINKIU19l2jRFuOAXWlbkpNNk4uIjxOurU3gcnHrRPQ1HNL/DFuFpfcy8K3EuuFU+0oH
         wxRBzyK7iPG7z7vJL4MbP6iyD6GcDnt9eA9mE7P+EnsmW87/4aB5+FX6xAEIYbI30PTX
         3/DY5Bx7fFjMdmeJCqxmKb1Bs+RotcAZw9aE+3N0dyjU5nQSYQlZqZnS0YhlYh1/M+sg
         9Y/rGD2vufBkWnMOfLJ+pINVOJYOq4e/B738mszi+xxxklxTZLcHRP90i83GRnQUipHv
         rFuw==
X-Gm-Message-State: AOJu0YxbyUr+rg5MItodCOae+mAHHfxYBkMg/IZFUXX4zv54JfckGQA7
	vfnKc0MKhOQnICcQ4Qw3yhAnLbXqRhq0PZhWkM4LLaNgs5AWd/aOPjNXgGJindaAMUhiVyxFsMy
	Vq7hO+yI=
X-Gm-Gg: ASbGncuGbtNJaecDB0uNUVBDoHrcgZwPPCo3IcfNd5oVm9KSdgJY7La3njA71+6K4ns
	VFKjsATDY4HfMSd/Mb9HK/yTsbzTIvzF5yO6HYAbnrVye2dOQWBkCUdRkfa11/JQkSYuqyKjHo/
	gupnmRyC63/XsujZBj9Sy+ImSYORcWJxC9Rc9JG67R700O2cud+Ge8aNkSQFmZJMJUjp8LKTUSC
	gm+JBG8pMTsVNWYFeFpNcPmIKwLodmmmzfoxjLrztlfKdbNllTjXgmCQ7THY5n65snktJ1XXoy5
	CFBF7U3OW5YNN/dAqQX7pGb3W7BMALl4f5GP6iZf3GcS+LmH+bM2rNiPvfa8M3e9LUg8Syn8Jfe
	oMuA4uBhruQvr3I+6lqn9ghwTblMHojcVo1bI1nAnEvc1
X-Google-Smtp-Source: AGHT+IEy1yaOyzwTc+O+VUAApk7Ec2BxtjJtptAIzHBD1twN8qqR6gWlzYgqCT53x3Mi7h2btCcqCg==
X-Received: by 2002:a17:903:18e:b0:24c:965a:f97e with SMTP id d9443c01a7336-24c965afa90mr76619405ad.2.1756990864719;
        Thu, 04 Sep 2025 06:01:04 -0700 (PDT)
Received: from MVIN00020.mvista.com ([49.207.215.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ce9dd9373sm355285ad.85.2025.09.04.06.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 06:01:04 -0700 (PDT)
From: vanusuri@mvista.com
To: yocto-patches@lists.yoctoproject.org
Cc: Vijay Anusuri <vanusuri@mvista.com>
Subject: [yocto-patches][meta-cgl][PATCH 1/2] racoon2: fix Upstream-Status
Date: Thu,  4 Sep 2025 18:30:51 +0530
Message-Id: <20250904130052.32436-1-vanusuri@mvista.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 04 Sep 2025 13:01:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2124

From: Vijay Anusuri <vanusuri@mvista.com>

Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
---
 .../racoon2/racoon2/0001-Add-DESTDIR-to-install-commands.patch   | 1 +
 .../racoon2/racoon2/0002-Enable-turning-of-kinkd-and-iked.patch  | 1 +
 .../racoon2/0003-Replace-perl_bindir-with-usr-bin-env-perl.patch | 1 +
 .../racoon2/racoon2/0004-racoon2-disable-hard-limit-timer.patch  | 1 +
 .../racoon2/racoon2/0005-racoon2-fix-rekeying-reply.patch        | 1 +
 .../racoon2/0006-racoon2-fix-sadb_msg_seq-collision.patch        | 1 +
 .../racoon2/racoon2/0007-racoon2-fwrite-return-value.patch       | 1 +
 .../racoon2/racoon2/0008-racoon2-iked-needs-libcrypto.patch      | 1 +
 .../racoon2/racoon2/0009-racoon2-iked-initscript.patch           | 1 +
 .../racoon2/racoon2/0010-racoon2-kinkd-initscript.patch          | 1 +
 .../racoon2/racoon2/0011-racoon2-spmd-initscript.patch           | 1 +
 .../racoon2/0012-racoon2-remove-deprecated-do-clause.patch       | 1 +
 .../racoon2/racoon2/0013-racoon2-fix-hardcoded-sysconfdir.patch  | 1 +
 13 files changed, 13 insertions(+)

diff --git a/meta-cgl-common/recipes-cgl/racoon2/racoon2/0001-Add-DESTDIR-to-install-commands.patch b/meta-cgl-common/recipes-cgl/racoon2/racoon2/0001-Add-DESTDIR-to-install-commands.patch
index 5dd46ba..fb4a9bd 100644
--- a/meta-cgl-common/recipes-cgl/racoon2/racoon2/0001-Add-DESTDIR-to-install-commands.patch
+++ b/meta-cgl-common/recipes-cgl/racoon2/racoon2/0001-Add-DESTDIR-to-install-commands.patch
@@ -3,6 +3,7 @@ From: Jeremy Puhlman <jpuhlman@mvista.com>
 Date: Tue, 17 Mar 2020 21:11:28 +0000
 Subject: [PATCH 01/13] Add DESTDIR to install commands.
 
+Upstream-Status: Backport [https://github.com/zoulasc/racoon2/commit/517363b58ee491527ea9951577071b31b56c4dd0]
 ---
  pskgen/Makefile.am                    |  2 +-
  samples/Makefile.am                   | 24 ++++++++++----------
diff --git a/meta-cgl-common/recipes-cgl/racoon2/racoon2/0002-Enable-turning-of-kinkd-and-iked.patch b/meta-cgl-common/recipes-cgl/racoon2/racoon2/0002-Enable-turning-of-kinkd-and-iked.patch
index 169ed5f..223c494 100644
--- a/meta-cgl-common/recipes-cgl/racoon2/racoon2/0002-Enable-turning-of-kinkd-and-iked.patch
+++ b/meta-cgl-common/recipes-cgl/racoon2/racoon2/0002-Enable-turning-of-kinkd-and-iked.patch
@@ -3,6 +3,7 @@ From: Jeremy Puhlman <jpuhlman@mvista.com>
 Date: Tue, 17 Mar 2020 22:09:01 +0000
 Subject: [PATCH 02/13] Enable turning of kinkd and iked
 
+Upstream-Status: Pending
 ---
  Makefile.am  |  2 +-
  configure.ac | 22 +++++++++++++++++++++-
diff --git a/meta-cgl-common/recipes-cgl/racoon2/racoon2/0003-Replace-perl_bindir-with-usr-bin-env-perl.patch b/meta-cgl-common/recipes-cgl/racoon2/racoon2/0003-Replace-perl_bindir-with-usr-bin-env-perl.patch
index 7043d39..0a72ba0 100644
--- a/meta-cgl-common/recipes-cgl/racoon2/racoon2/0003-Replace-perl_bindir-with-usr-bin-env-perl.patch
+++ b/meta-cgl-common/recipes-cgl/racoon2/racoon2/0003-Replace-perl_bindir-with-usr-bin-env-perl.patch
@@ -3,6 +3,7 @@ From: Jeremy Puhlman <jpuhlman@mvista.com>
 Date: Tue, 17 Mar 2020 22:09:52 +0000
 Subject: [PATCH 03/13] Replace perl_bindir with /usr/bin/env perl
 
+Upstream-Status: Pending
 ---
  pskgen/pskgen.in | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)
diff --git a/meta-cgl-common/recipes-cgl/racoon2/racoon2/0004-racoon2-disable-hard-limit-timer.patch b/meta-cgl-common/recipes-cgl/racoon2/racoon2/0004-racoon2-disable-hard-limit-timer.patch
index 0ba724f..d47fb5d 100644
--- a/meta-cgl-common/recipes-cgl/racoon2/racoon2/0004-racoon2-disable-hard-limit-timer.patch
+++ b/meta-cgl-common/recipes-cgl/racoon2/racoon2/0004-racoon2-disable-hard-limit-timer.patch
@@ -3,6 +3,7 @@ From: Jeremy Puhlman <jpuhlman@mvista.com>
 Date: Wed, 18 Mar 2020 20:22:57 +0000
 Subject: [PATCH] racoon2-disable-hard-limit-timer
 
+Upstream-Status: Pending
 ---
  iked/ikev2_child.c | 14 +++++++-------
  1 file changed, 7 insertions(+), 7 deletions(-)
diff --git a/meta-cgl-common/recipes-cgl/racoon2/racoon2/0005-racoon2-fix-rekeying-reply.patch b/meta-cgl-common/recipes-cgl/racoon2/racoon2/0005-racoon2-fix-rekeying-reply.patch
index 3ee7edd..b783938 100644
--- a/meta-cgl-common/recipes-cgl/racoon2/racoon2/0005-racoon2-fix-rekeying-reply.patch
+++ b/meta-cgl-common/recipes-cgl/racoon2/racoon2/0005-racoon2-fix-rekeying-reply.patch
@@ -3,6 +3,7 @@ From: Jeremy Puhlman <jpuhlman@mvista.com>
 Date: Wed, 18 Mar 2020 18:46:16 +0000
 Subject: [PATCH 05/13] racoon2-fix-rekeying-reply
 
+Upstream-Status: Pending
 ---
  iked/ikev2.c | 2 ++
  1 file changed, 2 insertions(+)
diff --git a/meta-cgl-common/recipes-cgl/racoon2/racoon2/0006-racoon2-fix-sadb_msg_seq-collision.patch b/meta-cgl-common/recipes-cgl/racoon2/racoon2/0006-racoon2-fix-sadb_msg_seq-collision.patch
index 24b4f1c..6eb2de4 100644
--- a/meta-cgl-common/recipes-cgl/racoon2/racoon2/0006-racoon2-fix-sadb_msg_seq-collision.patch
+++ b/meta-cgl-common/recipes-cgl/racoon2/racoon2/0006-racoon2-fix-sadb_msg_seq-collision.patch
@@ -3,6 +3,7 @@ From: Jeremy Puhlman <jpuhlman@mvista.com>
 Date: Wed, 18 Mar 2020 18:49:16 +0000
 Subject: [PATCH 06/13] racoon2-fix-sadb_msg_seq-collision
 
+Upstream-Status: Pending
 ---
  iked/ike_pfkey.c | 10 +++++++++-
  1 file changed, 9 insertions(+), 1 deletion(-)
diff --git a/meta-cgl-common/recipes-cgl/racoon2/racoon2/0007-racoon2-fwrite-return-value.patch b/meta-cgl-common/recipes-cgl/racoon2/racoon2/0007-racoon2-fwrite-return-value.patch
index 80a0981..c41a292 100644
--- a/meta-cgl-common/recipes-cgl/racoon2/racoon2/0007-racoon2-fwrite-return-value.patch
+++ b/meta-cgl-common/recipes-cgl/racoon2/racoon2/0007-racoon2-fwrite-return-value.patch
@@ -3,6 +3,7 @@ From: Jeremy Puhlman <jpuhlman@mvista.com>
 Date: Wed, 18 Mar 2020 18:50:59 +0000
 Subject: [PATCH 07/13] racoon2-fwrite-return-value
 
+Upstream-Status: Pending
 ---
  lib/cftoken.l | 7 +++++++
  1 file changed, 7 insertions(+)
diff --git a/meta-cgl-common/recipes-cgl/racoon2/racoon2/0008-racoon2-iked-needs-libcrypto.patch b/meta-cgl-common/recipes-cgl/racoon2/racoon2/0008-racoon2-iked-needs-libcrypto.patch
index 703e192..c3d8531 100644
--- a/meta-cgl-common/recipes-cgl/racoon2/racoon2/0008-racoon2-iked-needs-libcrypto.patch
+++ b/meta-cgl-common/recipes-cgl/racoon2/racoon2/0008-racoon2-iked-needs-libcrypto.patch
@@ -3,6 +3,7 @@ From: Jeremy Puhlman <jpuhlman@mvista.com>
 Date: Wed, 18 Mar 2020 18:52:49 +0000
 Subject: [PATCH 08/13] racoon2-iked-needs-libcrypto
 
+Upstream-Status: Pending
 ---
  iked/Makefile.am | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)
diff --git a/meta-cgl-common/recipes-cgl/racoon2/racoon2/0009-racoon2-iked-initscript.patch b/meta-cgl-common/recipes-cgl/racoon2/racoon2/0009-racoon2-iked-initscript.patch
index 1290091..2a1fbcb 100644
--- a/meta-cgl-common/recipes-cgl/racoon2/racoon2/0009-racoon2-iked-initscript.patch
+++ b/meta-cgl-common/recipes-cgl/racoon2/racoon2/0009-racoon2-iked-initscript.patch
@@ -3,6 +3,7 @@ From: Jeremy Puhlman <jpuhlman@mvista.com>
 Date: Wed, 18 Mar 2020 18:58:05 +0000
 Subject: [PATCH 09/13] racoon2-iked-initscript
 
+Upstream-Status: Pending
 ---
  samples/init.d/iked.in | 9 ++++++++-
  1 file changed, 8 insertions(+), 1 deletion(-)
diff --git a/meta-cgl-common/recipes-cgl/racoon2/racoon2/0010-racoon2-kinkd-initscript.patch b/meta-cgl-common/recipes-cgl/racoon2/racoon2/0010-racoon2-kinkd-initscript.patch
index 8fe9689..2a396f5 100644
--- a/meta-cgl-common/recipes-cgl/racoon2/racoon2/0010-racoon2-kinkd-initscript.patch
+++ b/meta-cgl-common/recipes-cgl/racoon2/racoon2/0010-racoon2-kinkd-initscript.patch
@@ -3,6 +3,7 @@ From: Jeremy Puhlman <jpuhlman@mvista.com>
 Date: Wed, 18 Mar 2020 19:01:36 +0000
 Subject: [PATCH 10/13] racoon2-kinkd-initscript
 
+Upstream-Status: Pending
 ---
  samples/init.d/kinkd.in | 9 ++++++++-
  1 file changed, 8 insertions(+), 1 deletion(-)
diff --git a/meta-cgl-common/recipes-cgl/racoon2/racoon2/0011-racoon2-spmd-initscript.patch b/meta-cgl-common/recipes-cgl/racoon2/racoon2/0011-racoon2-spmd-initscript.patch
index 45db6d4..57e43d5 100644
--- a/meta-cgl-common/recipes-cgl/racoon2/racoon2/0011-racoon2-spmd-initscript.patch
+++ b/meta-cgl-common/recipes-cgl/racoon2/racoon2/0011-racoon2-spmd-initscript.patch
@@ -3,6 +3,7 @@ From: Jeremy Puhlman <jpuhlman@mvista.com>
 Date: Wed, 18 Mar 2020 19:06:54 +0000
 Subject: [PATCH 11/13] racoon2-spmd-initscript
 
+Upstream-Status: Pending
 ---
  samples/init.d/spmd.in | 9 ++++++++-
  1 file changed, 8 insertions(+), 1 deletion(-)
diff --git a/meta-cgl-common/recipes-cgl/racoon2/racoon2/0012-racoon2-remove-deprecated-do-clause.patch b/meta-cgl-common/recipes-cgl/racoon2/racoon2/0012-racoon2-remove-deprecated-do-clause.patch
index 8afe22c..858abdb 100644
--- a/meta-cgl-common/recipes-cgl/racoon2/racoon2/0012-racoon2-remove-deprecated-do-clause.patch
+++ b/meta-cgl-common/recipes-cgl/racoon2/racoon2/0012-racoon2-remove-deprecated-do-clause.patch
@@ -3,6 +3,7 @@ From: Jeremy Puhlman <jpuhlman@mvista.com>
 Date: Wed, 18 Mar 2020 19:08:42 +0000
 Subject: [PATCH 12/13] racoon2-remove-deprecated-do-clause
 
+Upstream-Status: Pending
 ---
  pskgen/pskgen.in | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)
diff --git a/meta-cgl-common/recipes-cgl/racoon2/racoon2/0013-racoon2-fix-hardcoded-sysconfdir.patch b/meta-cgl-common/recipes-cgl/racoon2/racoon2/0013-racoon2-fix-hardcoded-sysconfdir.patch
index b3fd55b..9a5f133 100644
--- a/meta-cgl-common/recipes-cgl/racoon2/racoon2/0013-racoon2-fix-hardcoded-sysconfdir.patch
+++ b/meta-cgl-common/recipes-cgl/racoon2/racoon2/0013-racoon2-fix-hardcoded-sysconfdir.patch
@@ -3,6 +3,7 @@ From: Jeremy Puhlman <jpuhlman@mvista.com>
 Date: Wed, 18 Mar 2020 19:54:51 +0000
 Subject: [PATCH 13/13] racoon2-fix-hardcoded-sysconfdir
 
+Upstream-Status: Pending
 ---
  pskgen/autogen.spmd.pwd.in  |  8 ++++----
  samples/hook/child-down.in  |  2 +-
-- 
2.25.1


