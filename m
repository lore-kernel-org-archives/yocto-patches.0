Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336DDCD5BD1
	for <webhook@archiver.kernel.org>; Mon,  1 Jun 2026 23:18:29 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12804.1780355904591640026
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Jun 2026 16:18:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=YSYSQKae;
 spf=pass (domain: konsulko.com, ip: 209.85.214.176, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bf1f074a12so38650525ad.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 16:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1780355904; x=1780960704; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBIw3hIjvJrIbgvIBjSdTntx3ahE30r50oyPmZupKrM=;
        b=YSYSQKaeJqw6NTqM5Gqb93BGlwJqoow2EO1BDW8i2WP6KgpWgDgS0TMHbcgNQFYgV0
         dlQUZRM1ylNRnN1/QFhnhURAWlImI2zE3pf013F6JWNUWGYJX70AeIukeDiI540SK5SH
         KBZRsqGyD2cEgzJZveQAbRNJ3QZmhv8kZyIqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780355904; x=1780960704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SBIw3hIjvJrIbgvIBjSdTntx3ahE30r50oyPmZupKrM=;
        b=SV3f7B/bE5sxrQehcp8Tu4Sxb83lDh3lSJ47NN49oFx73E4blh52ec4PTbzgT2MBGX
         DCdTDawz25rhylBYC+UBVpmrPKchagWdumMadPok5pJqH+e7usjocx36AW9Kdk+hDCM8
         eGkeNRL0bww2QIxcuha/7FqP1dj2CAvY7Aclzi2obG/CAfB0/9rJtPW9at01pyw8LkbF
         9LTNhfJMnGW9mX9cn7E0qBvup94wl2BwSObQe1hLEe2/YsZQOUqwiI+RmnMEEjN9FCr0
         zN/uAx7KjqchInuxaXm+p0CGkNd4ymx1zj4350PmhZvYpwl3FtSKPblQ0KkJKFlTViuc
         38DQ==
X-Gm-Message-State: AOJu0YxSCzoV24u1Zf4jTAxH173LAq4uUVNEeqZZyALKTATfVcWD8DQ5
	X5I9m74oR4Ax1ZNmKC12SiKFx0nu5PBGZr6vFGAYtvJsP9HOw1T5G25CqfBCUEKfdEcur8e7PkV
	tN1fd
X-Gm-Gg: Acq92OF31877NXXKU8PVMxtUGPevYboZtOThMh6fCGbmME9lW5szBpK/89/9C9qqBjJ
	n0LlHq10RHB71JbLCWDbDMT8bepvoBZheFOipUotCxPTZ8OIVQ3YbNQWhAWcwfJV7kiLTXpqOj0
	POM8epg9l4WUF4np7J2Fck8jqGl6/bR8f7jMseKdhqiZPvSu10cPwvw0OJwZ3bLLBYXRpQ4dVLX
	wRba3ugLPQ9LmjkAbvJBuJM2SbYrgvaGoJHsfEiw/s7KWz6sujlK/+kMFLX8XSyKbOSh435kNdE
	hZxEGWJpHSOQmuuc8CfUt86jj4+sv39LFJAduFEh7u+i6dLDcBshUyOR9WO305pp5pMvlk3cQuL
	qsbNF3GEyeyu5mxLOKnl+9AG442EC0lxxAxd/qxXdsTjQ8QcFGh6UbY7N3bbK1AsnUGjRRxlnfq
	WiIxvPXkSFo+RKQSEeyjkbNVA4B77Jp65Hbz6BinJuULIzDeX9mDVulLgJX/lkP3JSNBUwJaBc7
	g==
X-Received: by 2002:a17:903:17c8:b0:2bf:356f:4e17 with SMTP id d9443c01a7336-2bf367dbb52mr146935235ad.13.1780355903954;
        Mon, 01 Jun 2026 16:18:23 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b001a8sm117627545ad.40.2026.06.01.16.18.23
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 16:18:23 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH v2 01/10] scripts/utils: fix stale extraction dir when tarball is updated
Date: Mon,  1 Jun 2026 16:18:00 -0700
Message-ID: <ee99d892018112109ab1b0e6f3ec8899918bdc52.1780354513.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780354513.git.tim.orling@konsulko.com>
References: <cover.1780354513.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 23:18:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4098

From: Tim Orling <tim.orling@konsulko.com>

Previously the entire download/cache-validation block in
setup_tools_tarball() was guarded by `if not os.path.exists(btdir)`.
Once the extraction directory existed from a prior build, every
subsequent call was a no-op: the cached tarball was never re-validated,
so a freshly-published SDK (e.g. vcontainer-tarball-latest) was silently
ignored and the stale btdir kept being used.

Fix by moving the lock/download block outside the btdir existence guard
so cache validation always runs. Track tarball_updated to know when the
cached download was actually replaced, then remove the stale btdir when
True so the fresh tarball is re-extracted.

Also add an mtime-based staleness check for local-path (cp) sources so
that a newer source file automatically invalidates the cached copy.

AI-Generated: Claude Cowork Sonnet 4.6
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 scripts/utils.py | 64 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 23 deletions(-)

diff --git a/scripts/utils.py b/scripts/utils.py
index 88842f0..87acad6 100644
--- a/scripts/utils.py
+++ b/scripts/utils.py
@@ -481,31 +481,49 @@ def setup_tools_tarball(ourconfig, btdir, bttarball, name="buildtools"):
         if ";" in bttarball:
             bttarball, sha256 = bttarball.split(";")
         btdir = os.path.abspath(btdir)
+        btdlpath = getconfig("BASE_SHAREDDIR", ourconfig) + "/cluster-downloads-cache/" + os.path.basename(bttarball)
+        btlock = btdlpath + ".lock"
+        if not os.path.exists(os.path.dirname(btdlpath)):
+            os.makedirs(os.path.dirname(btdlpath), exist_ok=True)
+        # Always run the cache-validation / download step so that a freshly
+        # published tarball is detected even when btdir already exists from a
+        # previous build.  tarball_updated is set to True whenever the cached
+        # download is replaced, which triggers removal of the stale btdir.
+        tarball_updated = False
+        while True:
+            try:
+                with open(btlock, 'a+') as lf:
+                    fileno = lf.fileno()
+                    fcntl.flock(fileno, fcntl.LOCK_EX)
+                    if sha256 and os.path.exists(btdlpath):
+                        dl_sha256 = sha256_file(btdlpath)
+                        if dl_sha256 != sha256:
+                            os.unlink(btdlpath)
+                    elif bttarball.startswith("/") and os.path.exists(btdlpath):
+                        # For local-path sources (e.g. vcontainer-tarball-latest)
+                        # invalidate the cached copy when the source is newer so
+                        # that a freshly-published tarball is always picked up.
+                        if os.path.getmtime(bttarball) > os.path.getmtime(btdlpath):
+                            os.unlink(btdlpath)
+                        os.unlink(btdlpath)
+                    if not os.path.exists(btdlpath):
+                        if bttarball.startswith("/"):
+                            subprocess.check_call(["cp", bttarball, btdlpath])
+                        else:
+                            subprocess.check_call(["wget", "-O", btdlpath, bttarball])
+                        os.chmod(btdlpath, 0o775)
+                        tarball_updated = True
+                break
+            except OSError:
+                # We raced with someone else, try again
+                pass
+        # If the underlying tarball changed, remove any stale extraction
+        # directory so it is re-extracted below.
+        if tarball_updated and os.path.exists(btdir):
+            print("Removing stale %s extraction at %s" % (name, btdir))
+            subprocess.check_call(["rm", "-rf", btdir])
         if not os.path.exists(btdir):
-            btdlpath = getconfig("BASE_SHAREDDIR", ourconfig) + "/cluster-downloads-cache/" + os.path.basename(bttarball)
             print("Extracting %s %s" % (name, bttarball))
-            btlock = btdlpath + ".lock"
-            if not os.path.exists(os.path.dirname(btdlpath)):
-                os.makedirs(os.path.dirname(btdlpath), exist_ok=True)
-            while True:
-                try:
-                    with open(btlock, 'a+') as lf:
-                        fileno = lf.fileno()
-                        fcntl.flock(fileno, fcntl.LOCK_EX)
-                        if sha256 and os.path.exists(btdlpath):
-                            dl_sha256 = sha256_file(btdlpath)
-                            if dl_sha256 != sha256:
-                                os.unlink(btdlpath)
-                        if not os.path.exists(btdlpath):
-                            if bttarball.startswith("/"):
-                                subprocess.check_call(["cp", bttarball, btdlpath])
-                            else:
-                                subprocess.check_call(["wget", "-O", btdlpath, bttarball])
-                            os.chmod(btdlpath, 0o775)
-                    break
-                except OSError:
-                    # We raced with someone else, try again
-                    pass
             subprocess.check_call(["bash", btdlpath, "-d", btdir, "-y"])
         enable_tools_tarball(btdir, name)
 
-- 
2.43.0


