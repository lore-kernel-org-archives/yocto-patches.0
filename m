Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43304CC6B30
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 14:12:44 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14674.1791987155170819177
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 14 Oct 2026 07:12:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=fzKbbVDw;
 spf=pass (domain: snapchat.com, ip: 209.85.128.53, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso9236475e9.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 07:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1791987153; x=1792591953; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uu1hE4dd0B8MsScdJS1U9jVL+n0L2uMptmEOFQmJIf0=;
        b=fzKbbVDwWPT2CuNUN4Yh4FkGR+zbzUH3mmeh+WPpJXB6eeLuV8YRdPtsFHcFIBqf5w
         ippoxJAK1AAjLUT4Nr69a4WFu/VQgguIRcZAvFeBj0SnLhGNekqTAeA4oFR6th3LsCH2
         0Tzauapq2vPrzR/eWt2ctZpLbJFhtSjVDxJ1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791987153; x=1792591953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uu1hE4dd0B8MsScdJS1U9jVL+n0L2uMptmEOFQmJIf0=;
        b=T3J6oHImBF51X3MURTeg7qNdGMd+v06U9h5mMyWs4ka9tGUJK9UOG6T1EwhwzO461O
         g74YQQX2YMs1NmttiTj2W4/44ZNFxRJMNt3PmDUxRZaSApe181S/2IV35bHP/Bs252rg
         xDLr6YYdOuaejlsczRxIrEMWGjzzyrXdVjpuWVDuM3sIsOR06fzP6QXm6qHpvLE4pXwD
         MaM3fWzP4kkwkThgQBj1LXJezRUJMRKPnw5riGhh4DuHeEOHcRR95pS3bXO4bpZtavgD
         FI9dFqeSHHvIJeD6aFEn7JpFXFk9pZAB9H7NrhLFpzBXu8SPh0hzfqLeF42APAVCAc13
         jAeQ==
X-Gm-Message-State: AFq9FYKziLYM/zNtenamo73Avt6KRPm5ItCIMIhuRFa8QiVwAMvtB7LQ
	3i8R9koylUqyt/VG7r5iLhsmU8bCXtwgFfflkSPSJ/b6xyBntLfhgoFDLPc1Pj9os+9XEyq2OUl
	cd997E3w=
X-Gm-Gg: AYBFou0qR/UTyO58cf0adWDaeJJNADrsx82OKZT2FafXRNIOR5m3ik8mn1GrrE7HV4V
	yyaQB6km03jdtqHSSB31GTc5UrmOe62niZ600hDpSmZf1ewi6W4mahE49TiarzAmJIilohYUdyB
	rHzGJjzMlL43OWYZhbSBCSkb5qUP+w7rV7HrKJ5GHquIO4AxiKeLbTAD+KdV4HAx/iJ+OeFQE37
	wy04CZtXGEJlCWr9SjtGtkWRa4ThBptHkOrgYOnwAS+NXiwF7uIL5hNhDTMjxzoJSKItl2Pxpks
	kx2GbfePWoqp3jcJHo8WhkLfPCo3FCw82oNIArblXEzhBmfNescDw8D0d5R8lg+PUxF7XtGo9N9
	m+QJqynl4JHIIKUOSvHIiKebl+/+TS9PJpIIDxYlNZmIJ9FyPeNdF5dkLBhRAtAXTrKgTZ+zkvs
	MykHbZ1UqQ3m4nPvP/LrixC+SZjzEtHoko2yyn8d2zcWpYT2h4SWZrb6YoomcV+7rmRj8mDNjX3
	pd9ytgaY09COg2uIdSepxDMD2MYr3U9RyOqF+Qnrw==
X-Received: by 2002:a05:600c:8716:b0:4a1:62b8:9aa1 with SMTP id 5b1f17b1804b1-4a18e44885dmr329313795e9.2.1791987153303;
        Wed, 14 Oct 2026 07:12:33 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd202e8esm299965e9.6.2026.10.14.07.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:12:32 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 09/21] gcc: fix Darwin ICE from weak-alias __cpu_indicator_init_local
Date: Wed, 14 Oct 2026 16:10:30 +0200
Message-ID: <20261014141209.488034-9-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014141209.488034-1-ecordonnier@snap.com>
References: <20261014141209.488034-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 14:12:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5014

From: Etienne Cordonnier <ecordonnier@snap.com>

nativesdk-libgcc:do_compile fails building libgcc/config/i386/cpuinfo.c
for x86_64-snapndk-darwin21 with:

  libgcc/config/i386/cpuinfo.c:68:3: internal compiler error: in
  assemble_alias, at varasm.cc:6627

OE-core's 0020-libgcc_s-Use-alias-for-__cpu_indicator_init patch (a
2015 musl-compat fix, not OS-gated) adds a weak alias definition of
__cpu_indicator_init_local. GCC's Darwin/Mach-O backend cannot emit
that weak+alias combination and ICEs instead of erroring out.

Add a new patch (0103) via the shared gcc-source_%.bbappend that
replaces the alias with a plain forwarding function body, gated on
__APPLE__ so non-Darwin builds keep taking the original weak-alias
path unchanged. Preserves the __cpu_indicator_init_local symbol name
that gcc/config/i386/i386-expand.cc calls from __builtin_cpu_init.

This surfaced now because GCC was bumped 13.3 -> 15.3 as part of the
scarthgap -> wrynose migration; whether this specific Darwin-hosted
libgcc + 0020-patch combination ever actually compiled under GCC 13.3
is unverified (GCC 13.3 source isn't available locally to diff
varasm.cc/cpuinfo.c against).

AI-Generated: Claude Sonnet 5

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 ...-i386-cpuinfo-avoid-darwin-alias-ice.patch | 44 +++++++++++++++++++
 recipes-devtools/gcc/gcc-source_%.bbappend    |  7 +++
 2 files changed, 51 insertions(+)
 create mode 100644 recipes-devtools/gcc/files/0103-libgcc-i386-cpuinfo-avoid-darwin-alias-ice.patch

diff --git a/recipes-devtools/gcc/files/0103-libgcc-i386-cpuinfo-avoid-darwin-alias-ice.patch b/recipes-devtools/gcc/files/0103-libgcc-i386-cpuinfo-avoid-darwin-alias-ice.patch
new file mode 100644
index 0000000..3e9bb9b
--- /dev/null
+++ b/recipes-devtools/gcc/files/0103-libgcc-i386-cpuinfo-avoid-darwin-alias-ice.patch
@@ -0,0 +1,44 @@
+From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
+From: Etienne Cordonnier <ecordonnier@snap.com>
+Date: Thu, 18 Sep 2026 12:00:00 +0200
+Subject: [PATCH] libgcc/i386: avoid weak alias for __cpu_indicator_init_local
+ on Darwin
+
+0020-libgcc_s-Use-alias-for-__cpu_indicator_init-instead-.patch
+(carried from OE-core) adds a weak alias definition of
+__cpu_indicator_init_local in libgcc/config/i386/cpuinfo.c. GCC's
+assemble_alias (gcc/varasm.cc) cannot emit this weak+alias combination
+for the Darwin/Mach-O backend and ICEs instead of erroring out:
+
+  libgcc/config/i386/cpuinfo.c:68:3: internal compiler error: in
+  assemble_alias, at varasm.cc:6627
+
+Use a plain forwarding function body on Darwin instead of the
+weak alias. This keeps the same externally visible symbol name that
+gcc/config/i386/i386-expand.cc calls from __builtin_cpu_init, so
+non-Darwin targets (which take the weak-alias branch below unchanged)
+are unaffected.
+
+Upstream-Status: Inappropriate [OE specific]
+---
+ libgcc/config/i386/cpuinfo.c | 5 +++++
+ 1 file changed, 5 insertions(+)
+
+diff --git a/libgcc/config/i386/cpuinfo.c b/libgcc/config/i386/cpuinfo.c
+index e980030ef23..a1b2c3d4e5f 100644
+--- a/libgcc/config/i386/cpuinfo.c
++++ b/libgcc/config/i386/cpuinfo.c
+@@ -64,6 +64,11 @@
+ }
+
+ #ifndef SHARED
++#if defined(__APPLE__)
++/* weak+alias here ICEs GCC's assemble_alias for Mach-O (gcc/varasm.cc).  */
++int __cpu_indicator_init_local (void) { return __cpu_indicator_init (); }
++#else
+ int __cpu_indicator_init_local (void)
+   __attribute__ ((weak, alias ("__cpu_indicator_init")));
+ #endif
++#endif
+--
+2.43.0
diff --git a/recipes-devtools/gcc/gcc-source_%.bbappend b/recipes-devtools/gcc/gcc-source_%.bbappend
index 0f05b8e..de18cff 100644
--- a/recipes-devtools/gcc/gcc-source_%.bbappend
+++ b/recipes-devtools/gcc/gcc-source_%.bbappend
@@ -18,6 +18,13 @@ SRC_URI:append = " \
     file://0102-aarch64-on-aarch64.patch \
 "
 
+# 0020 (carried from OE-core) adds a weak alias for __cpu_indicator_init_local
+# in libgcc/config/i386/cpuinfo.c; GCC ICEs emitting that for Mach-O. Guarded
+# by __APPLE__, so this only changes behavior on Darwin.
+SRC_URI:append = " \
+    file://0103-libgcc-i386-cpuinfo-avoid-darwin-alias-ice.patch \
+"
+
 # gcc-15.3.0 tarball ships zlib/zlib.map with CRLF; 0101 tail hunk is LF-only.
 python do_patch:prepend() {
     import pathlib
-- 
2.43.0


