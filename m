Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B093DCC6B32
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 14:12:44 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14770.1791987157664292812
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 14 Oct 2026 07:12:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=KHw6mvCc;
 spf=pass (domain: snapchat.com, ip: 209.85.128.44, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1af482519so15183885e9.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 07:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1791987156; x=1792591956; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qHvZ1Kbkic6JbOMdL30tAfiBbPqa3U8RShO7LlmRs7o=;
        b=KHw6mvCcWQzoozGelAxIrsBoiKpRCsV3sDa/0MxE+kr5JhYVFEOxj6hEFjrcQcEnhy
         s5VR78aGnvrTUwa6EUw/aTgRao7kNjmd/azFCcZ0/aSGzD36/sKbqVZ4UpTAixkcTgVh
         6MHEFGcgotl4TY1gy/Z5dY607Zdn+mMyIUvrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791987156; x=1792591956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qHvZ1Kbkic6JbOMdL30tAfiBbPqa3U8RShO7LlmRs7o=;
        b=ju+9vIWw0M1fVu8oOXq3uk7ZP9CDpHKoS5h10O5bZyf5AV526NXP4O9hydIfY0oTA7
         Dm8FgMP0TyNacaS/5QTkuFejFCPzzKFjynhzyZ9Dj7GdL7CrxRYmOdskcGkB/QNxCPs/
         kGetNke/ENe2a/TuP5r7rXUCLTlTiNmBn6uuBs2rTSc4JCDpMBXe1UK/rP8qt//shDjW
         IuBHelJ00v3LoLo8m32yoZqd3051qMlmBx4NB+GtPWajg53drMknn6GGcxf05xN3nXNU
         SRj+RKMkVWWHcI7X8SsH4Vt++RIuVO8jF3rQVQ3v5lTDnDPLhcyFdDU09wMLUO3xEMeZ
         GDbA==
X-Gm-Message-State: AFq9FYLWln0oeT171RBCxlT1xzhgC0xwnjZUPBsrUmrdjy/COOyJlr1K
	BR7/+66X8jGCNUvZKWrglKMKISsbWYJq90lP9tRjepjQ4Ou9MfI34ECVm57x0gE9aoeO0DWa2oA
	PLTDFuHU=
X-Gm-Gg: AYBFou0eagLmfVPqeeMcPTm1u0JJkNt7IMALcaXgIjcO63Kckg+LD4f4Mhl0anXRBUH
	ytQcN5LbngE8qJKg2NA4To50Bwhm50gRctYCANUKDi42IVmV0ykxBJyeKgh1POlVIZVHbjL9QEW
	eDJ7JrJLtJhNWhiqFfUNBsGKhd1ZgGjxzTrs3Fp0bOMNlGFwhi5BP7PBGiwi8OdbNDJ0gCEZT3/
	T3pFxiJCfnVM0f82exayr/eUEE1YfbrZMBdmQ+GSm1MqdqoR+MZm93kOaO7F4Eq3Utn+drDZWvl
	enkqPIhIunirSO0FmIgAm7QoECruzrFT2XNRjv0cp2M0xGcCYWj+tw8SDmk5KxHUl5unaYr6QZU
	RGto4tZ6scHoxAbzpE0AeG/ytiwWcKV6Y4lbIKaMcgNMENl9Me9F5Z5XGrxqewacMAGd+sJ99n8
	Q9QvOz0KVjFK/Yo3y2CzHRuCZ7VgcoMv3b6va2CWeIv9j0YAKSHo9TWYBottJExNlkLxxogHsZA
	0ySPb6FKsL3OkOxaxvYhFRG9160ZH0c7sRmZrAS0oriP6VAjbW9
X-Received: by 2002:a05:600c:c10e:b0:4a1:93fd:913 with SMTP id 5b1f17b1804b1-4a193fd0ad6mr204365255e9.10.1791987155757;
        Wed, 14 Oct 2026 07:12:35 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd202e8esm299965e9.6.2026.10.14.07.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:12:35 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 11/21] sqlite3: fix Darwin nativesdk build (SONAME + shell link)
Date: Wed, 14 Oct 2026 16:10:32 +0200
Message-ID: <20261014141209.488034-11-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014141209.488034-1-ecordonnier@snap.com>
References: <20261014141209.488034-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 14:12:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5016

From: Etienne Cordonnier <ecordonnier@snap.com>

sqlite's autosetup configure treats an unsupported SONAME mechanism as
a soft warning, but escalates to a fatal error when --soname was
explicitly requested. sqlite3.inc always passes --soname=legacy, and
Darwin's linker supports neither the GNU (-Wl,-soname) nor HP
(-Wl,+h) flag autosetup probes for, so do_configure aborts for the
macOS NDK nativesdk build. sqlite's configure already sets
-install_name for Mac targets independently of this flag, so dropping
it is sufficient.

That gets do_configure passing but do_compile then fails linking the
sqlite3 CLI shell:

  Undefined symbols for architecture x86_64: "_sqlite3_db_status64",
  "_sqlite3_enable_load_extension", "_sqlite3_load_extension"

The shell links with "-L. -lsqlite3" against the dylib just built in
the same directory. CC for this target always carries an extra -L for
the macOS SDK's own library dir (needed for other libSystem symbols),
and that same directory ships Apple's own libsqlite3 stub - missing
exactly these three newer/optional APIs - ahead of "-L." on the
command line, so the linker resolves -lsqlite3 against Apple's stub
instead of our library. Patch Makefile.in to link the shell against
$(libsqlite3.DLL) by path instead of via -l, which is unambiguous
regardless of -L search order. Scoped to darwin21 only.

AI-Generated: Claude Sonnet 5

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 ...ink-against-libsqlite3-by-path-not-l.patch | 41 +++++++++++++++++++
 recipes-support/sqlite/sqlite3_%.bbappend     | 17 ++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 recipes-support/sqlite/files/0001-shell-link-against-libsqlite3-by-path-not-l.patch
 create mode 100644 recipes-support/sqlite/sqlite3_%.bbappend

diff --git a/recipes-support/sqlite/files/0001-shell-link-against-libsqlite3-by-path-not-l.patch b/recipes-support/sqlite/files/0001-shell-link-against-libsqlite3-by-path-not-l.patch
new file mode 100644
index 0000000..e11155f
--- /dev/null
+++ b/recipes-support/sqlite/files/0001-shell-link-against-libsqlite3-by-path-not-l.patch
@@ -0,0 +1,41 @@
+From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
+From: Etienne Cordonnier <ecordonnier@snap.com>
+Date: Fri, 19 Sep 2026 12:00:00 +0200
+Subject: [PATCH] Makefile.in: link sqlite3 shell against libsqlite3 by path,
+ not -l
+
+The shell binary links against the just-built shared library with
+"-L. -lsqlite3". On Darwin, CC always carries an extra -L for the
+macOS SDK's own system library directory (needed for other libSystem
+symbols), and that directory also happens to ship Apple's own
+libsqlite3 stub - which is missing sqlite3_load_extension,
+sqlite3_enable_load_extension and sqlite3_db_status64. Since that -L
+comes before "-L. -lsqlite3" on the command line, the linker resolves
+-lsqlite3 against Apple's stub instead of the library this recipe just
+built, and the shell fails to link with undefined symbols.
+
+Link directly against the just-built $(libsqlite3.DLL) by path instead
+of via -l, which is unambiguous regardless of -L search order. This is
+a no-op on non-Darwin targets, where "-L. -lsqlite3" and "./libsqlite3.so"
+resolve to the same file.
+
+Upstream-Status: Inappropriate [OE/Darwin specific]
+---
+ Makefile.in | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/Makefile.in b/Makefile.in
+index 1111111111a..2222222222b 100644
+--- a/Makefile.in
++++ b/Makefile.in
+@@ -240,7 +240,7 @@
+ # https://sqlite.org/forum/forumpost/d80ecdaddd
+ ENABLE_STATIC_SHELL = @ENABLE_STATIC_SHELL@
+ sqlite3-shell-link-flags.1 = $(TOP)/sqlite3.c $(LDFLAGS) $(LDFLAGS.libsqlite3)
+-sqlite3-shell-link-flags.0 = $(LDFLAGS) -L. -lsqlite3 $(LDFLAGS.zlib) $(LDFLAGS.math)
++sqlite3-shell-link-flags.0 = $(LDFLAGS) ./$(libsqlite3.DLL) $(LDFLAGS.zlib) $(LDFLAGS.math)
+ sqlite3-shell-deps.1 = $(TOP)/sqlite3.c
+ sqlite3-shell-deps.0 = $(libsqlite3.DLL)
+ #
+--
+2.43.0
diff --git a/recipes-support/sqlite/sqlite3_%.bbappend b/recipes-support/sqlite/sqlite3_%.bbappend
new file mode 100644
index 0000000..74696d0
--- /dev/null
+++ b/recipes-support/sqlite/sqlite3_%.bbappend
@@ -0,0 +1,17 @@
+# Darwin's linker has neither -Wl,-soname nor HP's -Wl,+h; sqlite's own
+# configure already sets -install_name for Mac targets independently of
+# this flag, so don't force the ELF/HP-style soname check to be fatal here.
+EXTRA_OECONF:remove:darwin21 = "--soname=legacy"
+
+FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
+
+# The shell binary's "-L. -lsqlite3" link resolves against the macOS SDK's
+# own (feature-incomplete) libsqlite3 stub instead of the library just built
+# here - see the patch for details.
+SRC_URI:append:darwin21 = " \
+    file://0001-shell-link-against-libsqlite3-by-path-not-l.patch \
+"
+
+# The Darwin libraries are named libsqlite3.<version>.dylib, which the default
+# "${libdir}/*.so.*" doesn't match.
+FILES:lib${BPN}:append:darwin21 = " ${libdir}/libsqlite3*.dylib"
-- 
2.43.0


