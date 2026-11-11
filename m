Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2571.1794370865753443246
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:21:05 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4L3ls2428068
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:21:05 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 08/34] patches/yocto-older-glibc-symbols.patch: Update to latest YP version
Date: Tue, 10 Nov 2026 22:20:36 -0600
Message-Id: <1794370862-30908-9-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:21:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5268
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

As of openembedded-core:

commit 994e508b2a0ede8b5cc4fe39444cf25dc9a53faf
Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Tue May 6 10:01:21 2025 +0100

    pseudo: Upgrade to version 1.9.1

    This brings in:
     * nftw, nftw64: add wrapper
     * ftw, nftw, ftw64, nftw64: add tests
     * Move ftw and ftw64 to calling ntfw and nftw64
     * makewrappers: Introduce 'array' support
     * pseudo_util.c: Avoid warning when we intentionally discard const
     * pseudo_client.c: Fix warning
     * yocto-older-glibc-symbols.path: Add as a reference patch
     * pseudo/pseudo_client: Add wrapper functions to operate correctly with glibc 2.38 onwards
     * configure: Prune PIE flags
     * test/test-parallel-rename.sh: Add parallel rename test
     * test/test-parallel-symlinks.sh: Add parallel symlink test
     * ports/linux/guts: Add .gitignore to ignore generated files

    Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 patches/yocto-older-glibc-symbols.patch | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/patches/yocto-older-glibc-symbols.patch b/patches/yocto-older-glibc-symbols.patch
index c453b5f..f42b32b 100644
--- a/patches/yocto-older-glibc-symbols.patch
+++ b/patches/yocto-older-glibc-symbols.patch
@@ -28,10 +28,10 @@ diff --git a/Makefile.in b/Makefile.in
 @@ -120,7 +120,7 @@ $(PSEUDODB): pseudodb.o $(SHOBJS) $(DBOBJS) pseudo_ipc.o | $(BIN)
  libpseudo: $(LIBPSEUDO)
  
- $(LIBPSEUDO): $(WRAPOBJS) pseudo_client.o pseudo_ipc.o $(SHOBJS) | $(LIB)
+ $(LIBPSEUDO): $(WRAPOBJS) pseudo_client.o pseudo_client_scanf.o pseudo_ipc.o $(SHOBJS) | $(LIB)
 -	$(CC) $(CFLAGS) $(CFLAGS_PSEUDO) -shared -o $(LIBPSEUDO) \
 +	$(CC) $(CFLAGS)  -Lprebuilt/$(shell uname -m)-linux/lib/ $(CFLAGS_PSEUDO) -shared -o $(LIBPSEUDO) \
- 		pseudo_client.o pseudo_ipc.o \
+ 		pseudo_client.o pseudo_client_scanf.o pseudo_ipc.o \
  		$(WRAPOBJS) $(SHOBJS) $(LDFLAGS) $(CLIENT_LDFLAGS)
  
 diff --git a/pseudo_wrappers.c b/pseudo_wrappers.c
-- 
1.8.3.1

