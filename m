Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11ED8CD37A7
	for <webhook@archiver.kernel.org>; Fri,  8 May 2026 02:00:54 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4654.1778205649238987498
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 07 May 2026 19:00:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=FgJjSL3r;
 spf=pass (domain: konsulko.com, ip: 209.85.215.180, mailfrom: tim.orling@konsulko.com)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so623830a12.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 07 May 2026 19:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1778205648; x=1778810448; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBIw3hIjvJrIbgvIBjSdTntx3ahE30r50oyPmZupKrM=;
        b=FgJjSL3ruj9od+FirZRoHsGudITjA2/tH93xleuLvR3tdmsF3uTfYdLIzLz2ZY7uqT
         /CKBMCtcdKhGs+zl4IupPMbQb8+cZUSuatGKzOBmzfnhoDC2WcxcNg3fSdkcneoBrp4I
         WDEF1VysGM9Mw7amp2589yHz4sK69ztPEYknk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778205648; x=1778810448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SBIw3hIjvJrIbgvIBjSdTntx3ahE30r50oyPmZupKrM=;
        b=OxChMkNkTvjuaogqNsxJMEuDz1tcbukpKsWiZ2a8SO+92YtDSc7xWRqe3LbZIoOWrN
         116PSu3c+/YgCjA2hS43y29wOMGdrxcTdVDAte0QTr93ZkKiCJ8oJd81aCJvcvO/GS9R
         /UlFktqhfhvzhBXoknJMoFDUNMYfgSCGQccZEkaJDaAWLRrM1+epcTC6uWmi6PX01aR9
         akHl0z0VoPUDXaiNkRXAlEd/2MYmQh/m5qWPxGvjI6il1ZmGYxdOx74m2u8LsCq3zoqD
         TBJM0i5IXhBu6+7RfSGo1RGu0Q/1AMxQ+JY9ASJKe5gQt9xpthM3agi2g1mtXC9LVJzo
         3xiQ==
X-Gm-Message-State: AOJu0Yx+7jCXd3SkV2fpNOxRzxxK/KkPwJ29r7rkfH5ucQRkEdCrupCW
	q2Aj4sozpRHWG8cRr9QZ2hQk8DbmD83nwkwQX1qZcOBqv7VDN71s14t4Ltlv0rmxQNAPdfLCpmY
	/hm1/
X-Gm-Gg: AeBDietV7cTcYR4jnnWhk2qkFZ2mIIqo71vLR5q2N3HBT3tPFlLnKeoBs5q9i4zvRi+
	hMfAhgiX0X62a6ce6a1JhDDX7aXzvO8D+Qy1yZbSSLzxCRWscE1Cl7vTRDoGlMlzlMkxjkih2K4
	Fyy7sxkQS/pGyZ9nIIkdVCAe+5azbtmYZgNPrpIUV1/GARR+alxbcgrLAdbABiCsSZEQUoKXeGw
	6VpBj13WBReFylLY6hJZ2NqU00oyzzJNCNKXwk1ECsKJXPiJ2sWNu9g4phKNsL+Wa1bxJ54sTL1
	FJxqqZXwmyPE8rnsve1wSpR6agIpTB6zLuNg0NQF1sp+dBFViCcU5TyCv8i0NSbjd+wfjDfaBlB
	Zlj40sVJG9C4/xeVxCehEVGXHVsTNh+S3L756iLIKrNgeNvWnxjBA3sBMR5Rs5yndjgEckee04f
	JEwUpGL5tIqJ/PqGVJK09TqhkdvyYVh+GewS4+zqAS3OejPm06evlJkT6MY5AUDnI=
X-Received: by 2002:a05:6a00:b8b:b0:82f:8696:5a75 with SMTP id d2e1a72fcca58-83a5d09b11dmr10020397b3a.28.1778205648331;
        Thu, 07 May 2026 19:00:48 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965d36a12sm9343236b3a.27.2026.05.07.19.00.47
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 19:00:47 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH 01/11] scripts/utils: fix stale extraction dir when tarball is updated
Date: Thu,  7 May 2026 19:00:24 -0700
Message-ID: <eeb8fe30fcf71f316f01475a62b5fdbc71eb3282.1778202125.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778202125.git.tim.orling@konsulko.com>
References: <cover.1778202125.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 08 May 2026 02:00:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3940

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


