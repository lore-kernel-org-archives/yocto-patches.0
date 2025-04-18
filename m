Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DCCC369AB
	for <webhook@archiver.kernel.org>; Fri, 18 Apr 2025 14:43:10 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
 by mx.groups.io with SMTP id smtpd.web11.13456.1744987385122256162
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 18 Apr 2025 07:43:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=N3aMvmHj;
 spf=pass (domain: snapchat.com, ip: 209.85.208.41, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e61d91a087so2989555a12.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 18 Apr 2025 07:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1744987383; x=1745592183; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wJ2ILV5HrFohislroMG6JziS4YvU8A40692xDhdGYOE=;
        b=N3aMvmHjypbZ2osiWhjE0mn3Kx4V9Yr/2++LEntnPZWsLeHjXgJc8RM77PcKn+6wkg
         DMvXui9OCTlxnboWDFtf6Ekg6PYKcxeqALSdXooT8hXBEXQ/VoIUZF9YPB0OOA/ADWqf
         dQiWApMbQNPQ4D4ta+UNO+udQsKEKF6jg3Tws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744987383; x=1745592183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJ2ILV5HrFohislroMG6JziS4YvU8A40692xDhdGYOE=;
        b=PgREje6KL/DXZd8l2+I0SzGx2qK3W9TB7llwONIuc1hoYJXUkMEQCzetWfhVJhOlrL
         Urz3FaiwM7JBTz62N8CpIysHCi90PAI7DdrT5r6B6KfYuc3kEESbo5e2exg/m21SwheN
         OcLZThAvPnagqTeNZqAD3b70q3vIffhjsEshLyrp37fUpSknvSuubiqbiPRlNiy2CERM
         y3TYHZHDMw2pprSMIzEqwBQ0TcfaCGzgTa15sFmxwzt3qonWcrBMPp6nEmZ4vrCI4LJd
         VK6JEi1GKK9hh0BX66axzTdsLC9Ce9UcsoWUB7pfU8Px/bz06fqwx1y5CD7SzRizl4FN
         uFZg==
X-Gm-Message-State: AOJu0YwlEcJOGwv1RJPbINhojmu1c7K1avSzuzry66r/QKHfNZaHNsGG
	EfQh/5zGxQt994ZLIX1JLU1OLCoZVl7GvFWerdqAtZxronG6ngulLYNtBc114WENl64cDkl9ksD
	XsbM=
X-Gm-Gg: ASbGncuMaLVbuOo/SaU7netCP+SPtYqSc+721FkNo3JanueulKUDUD7fUo4F7SeLZdN
	vnWiPLCkcEo8feYnyOtKoy4ftVrCp3rSAerUfsk5VLXfdhb4IjNicynCP8bn/Fh3cEJ2z+0UjBB
	53nXt0XRA3n7is6r/plwY48Uo64HDurt24t/BRvx5UA8c3SCcZu+TLAFk5ZirrAZVfuKTOxTJZq
	kuTRA/QJgnXlHX2IZ6/NLRFgNuwaQcsFO6zK/dvP01I5JaDyJjJsazyHc0tuvq3QtV57N+h/WMg
	VIwISg/QeWWah3fz1e0PoOYkGBlc22nZTtezlvLQvdpRa2B5rXVF
X-Google-Smtp-Source: AGHT+IEtZ4gPStkPDk3oiTTkkkKdu2fUrETcLxf198gjFmR5ykh4TrCYRdozObxwUEPMLA7rq2kscA==
X-Received: by 2002:a05:6402:1d48:b0:5e6:1842:1346 with SMTP id 4fb4d7f45d1cf-5f62860e171mr2319894a12.30.1744987383234;
        Fri, 18 Apr 2025 07:43:03 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f625a3e212sm1041281a12.78.2025.04.18.07.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 07:43:03 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH] Fix libzstd error on MacOS>=15.4
Date: Fri, 18 Apr 2025 16:42:53 +0200
Message-ID: <20250418144253.780489-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 18 Apr 2025 14:43:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1386

From: Etienne Cordonnier <ecordonnier@snap.com>

libzstd duplicates the LDFLAGS when compiling libzstd, and the dynamic loader of MacOS
version 15.4 treats this duplicated LC_RPATH (two LC_RPATH pointing to the same path) as an error
and refuses to load the library.

Reported upstream as https://github.com/facebook/zstd/issues/4369

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 ...ix-duplicate-LC_RPATH-error-on-MacOS.patch | 48 +++++++++++++++++++
 recipes-extended/zstd/zstd_%.bbappend         |  2 +
 2 files changed, 50 insertions(+)
 create mode 100644 recipes-extended/zstd/zstd/0001-Fix-duplicate-LC_RPATH-error-on-MacOS.patch

diff --git a/recipes-extended/zstd/zstd/0001-Fix-duplicate-LC_RPATH-error-on-MacOS.patch b/recipes-extended/zstd/zstd/0001-Fix-duplicate-LC_RPATH-error-on-MacOS.patch
new file mode 100644
index 0000000..b765082
--- /dev/null
+++ b/recipes-extended/zstd/zstd/0001-Fix-duplicate-LC_RPATH-error-on-MacOS.patch
@@ -0,0 +1,48 @@
+From 30a4af206739e37d6203747792a6b15bf952483d Mon Sep 17 00:00:00 2001
+From: Etienne Cordonnier <ecordonnier@snap.com>
+Date: Fri, 18 Apr 2025 14:37:50 +0200
+Subject: [PATCH] Fix duplicate LC_RPATH error on MacOS
+
+After the update to MacOS 15.4, the dynamic loader dyld treats duplicated LC_RPATH as an error.
+The `FLAGS` variable already contains `LDFLAGS`, thus using both `FLAGS` and `LDFLAGS`
+duplicates all `LDFLAGS`, including `-Wl,rpath` parameters.
+
+The duplicate LC_RPATH causes this kind of errors:
+
+```
+dyld[29361]: Library not loaded: @loader_path/../lib/libzstd.1.dylib
+      Referenced from: <7131C877-3CF0-33AC-AA05-257BA4FDD770> /Users/foobar/...
+      Reason: tried: '/Users/foobar/..../lib/libzstd.1.dylib' (duplicate LC_RPATH '/usr/mypath.../lib')
+```
+
+Upstream-Status: Pending
+Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
+---
+ lib/Makefile | 4 ++--
+ 1 file changed, 2 insertions(+), 2 deletions(-)
+
+diff --git a/lib/Makefile b/lib/Makefile
+index a4cf61ab..e1ffba91 100644
+--- a/lib/Makefile
++++ b/lib/Makefile
+@@ -160,7 +160,7 @@ $(ZSTD_DYNLIB): $(ZSTD_DYNLIB_OBJ)
+ 	$(if $(filter -DZSTD_MULTITHREAD,$(CPPFLAGS)),\
+     @echo compiling multi-threaded dynamic library $(LIBVER),\
+     @echo compiling single-threaded dynamic library $(LIBVER))
+-	$(CC) $(FLAGS) $^ $(LDFLAGS) $(SONAME_FLAGS) -o $@
++	$(CC) $(FLAGS) $^ $(SONAME_FLAGS) -o $@
+ 	@echo creating versioned links
+ 	ln -sf $@ libzstd.$(SHARED_EXT_MAJOR)
+ 	ln -sf $@ libzstd.$(SHARED_EXT)
+@@ -236,7 +236,7 @@ libzstd-nomt: LDFLAGS += -shared
+ libzstd-nomt: $(ZSTD_NOMT_FILES)
+ 	@echo compiling single-thread dynamic library $(LIBVER)
+ 	@echo files : $(ZSTD_NOMT_FILES)
+-	$(CC) $(FLAGS) $^ $(LDFLAGS) $(SONAME_FLAGS) -o $@
++	$(CC) $(FLAGS) $^ $(SONAME_FLAGS) -o $@
+ 
+ .PHONY: clean
+ clean:
+-- 
+2.43.0
+
diff --git a/recipes-extended/zstd/zstd_%.bbappend b/recipes-extended/zstd/zstd_%.bbappend
index bb583f6..8572d37 100644
--- a/recipes-extended/zstd/zstd_%.bbappend
+++ b/recipes-extended/zstd/zstd_%.bbappend
@@ -1,3 +1,5 @@
 FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
 
 EXTRA_OEMAKE:append:darwin21 = " UNAME='Darwin'"
+
+SRC_URI:append:class-nativesdk = " file://0001-Fix-duplicate-LC_RPATH-error-on-MacOS.patch"
-- 
2.43.0


