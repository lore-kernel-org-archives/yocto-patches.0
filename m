Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6663D2D11F
	for <webhook@archiver.kernel.org>; Tue, 13 Jan 2026 23:17:45 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.72586.1768346255684035748
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 13 Jan 2026 15:17:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Bvp369Lr;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477563e28a3so1803775e9.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 13 Jan 2026 15:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1768346254; x=1768951054; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnC+a81ZAQhXoZ+tD4f/rd5qFPFOCPRPBfeCtNBLZDY=;
        b=Bvp369LrOVGPz/rGvgwCZPH8+EWCkOU1SQiyI4SWPXlXVTO90kn03ezLcTA2NfdDmD
         UGdeEpHEbk4sljCVDGXZVbRjbJlIGoZjxizLIkwlDYzA7kcYTHgNacIigg4ZvOpHwFq8
         K7vgFo2RQ0I6umUL5zZIUa3fwdhqqJbmr//F0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768346254; x=1768951054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XnC+a81ZAQhXoZ+tD4f/rd5qFPFOCPRPBfeCtNBLZDY=;
        b=QE+tr1hEzzVGUPhECVsVneO4KeVkmT6cq2nY37Mt1mTIF2S26hZWdmLZ6Nl5dWfHVH
         /k8YEzkar241b1ZILLdmf22IxvZTpqYIndKbWekCego7zCftJRTPO9bjip5tNHJ8Wmm9
         BT4TmyoVm5v1KIVig4Wr4Bg6nD8BD3JC8xGF2z4e/nIUoJvLXueGg7bTwCEy1jC0W6OE
         xg0oqL9+TgWBBZhTISgK4Hn6yvHLyaaYpDCFrYClK/s2abizuheyhf6HqbkOMmhNx2mw
         +GGmkXE5+R2GSnQlkqfdHL4HJyYhsZMSbXzmyclIZ0QcWZ71J1A0L1bPoZRZ4z005ZNC
         mmDg==
X-Gm-Message-State: AOJu0Yywlg49CornkOp+VfXxehMozzZWHV1cX8bkMHbeP1habI5jxtSt
	AiVoIump27hWWjTXutCMsIH2GxPK3CYxPbcVrKUD4pNdqXMR8TEKCjFuWjmIipGO0FUx6zKXaET
	UlWi3okk=
X-Gm-Gg: AY/fxX6k373jsCF1810JIer4Bgw8Me5pi0NOPkz4sjkaUv+S9JV/b3ZNr1yw35La6bo
	GwBZ6/o7D2tSv5rXrk+gZCqSVGyyFNJNuYX9IwqZltbdY+nhFyYjASP/VX+2eqOeHo080rqL4zA
	lt4Z1ekW4mz+ILAcSnytDHl28Vfrys7l113Jt81w8G1kdHOT48LvJrRerWmyWfIMzebeHV99Enp
	mkWdTDQrxGqqenlUzL+sVZbRoC3wsjKWtUeygbyMZVQ+CsXmNLWNp+CCO/SlpJ9KFIBQF3PfIa/
	gZdMRyULlzq+eMg/cpgXB/Q0riWKTp05LBoTuZLeknXv/Uk6JtTEJxPemmOPLjY0FaqtbR7M4wo
	Dc1F9j+6wI1bQnm2wQ894sr+4LWqM9Tv6kMfyzVr/kNE9nqJKHHooMXz/GwfcfMHzITQ2FQU1QB
	aI1SJejA6h+J8QvIkYTiKxZYvRZBWFX/e78SG1jg==
X-Received: by 2002:a05:600c:a10f:b0:47e:e452:ec12 with SMTP id 5b1f17b1804b1-47ee452ed0bmr1825225e9.15.1768346253745;
        Tue, 13 Jan 2026 15:17:33 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:143:ebd4:ccef:c4b7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f695956sm436956115e9.6.2026.01.13.15.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 15:17:33 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net,
	mark.hatle@kernel.crashing.org
Subject: [pseudo] [PATCH 3/3] makewrappers: Enable a new efault option
Date: Tue, 13 Jan 2026 23:17:29 +0000
Message-ID: <20260113231729.2698563-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260113231729.2698563-1-richard.purdie@linuxfoundation.org>
References: <20260113231729.2698563-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 13 Jan 2026 23:17:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2953

From: "mark.hatle" <mark.hatle@kernel.crashing.org>

See Yocto Project Bugzilla 16075.

On Linux, some functions will return EFAULT if certain paths are NULL vs
empty.  RUST specifically uses this Linux specific behavior as an
optimization to detect if the statx function is available.

In my opinion, this is a horrible idea, even though the man page for
Linux/glibc says EFAULT is returned.  Looking through the call code
the EFAULT happens to occur when the kernel syscall attempts to copy
the path from userspace to kernel memory and then faults.  Relying on
this (posix) undefined behavior is really bad practice, but we have to
work with RUST and other tools.

Signed-off-by: mark.hatle <mark.hatle@kernel.crashing.org>
---
 makewrappers                   | 10 ++++++++++
 ports/linux/statx/wrapfuncs.in |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/makewrappers b/makewrappers
index 0d73cc1..154b489 100755
--- a/makewrappers
+++ b/makewrappers
@@ -245,6 +245,8 @@ class Function:
         self.async_skip = None
         # used for the copyright date when creating stub functions
         self.date = datetime.date.today().year
+        # Used to define pointers that should EFAULT if null
+        self.efault = None
     
         function, comments = line.split(';')
         comment = re.search(r'/\* *(.*) *\*/', comments)
@@ -392,6 +394,14 @@ class Function:
                     "asm(\"\" : \"+r\"(%s));"
                     "if (%s && !*%s && (flags & AT_EMPTY_PATH))\n"
                     "\t\t\tflags |= AT_SYMLINK_NOFOLLOW;" % (path, path, path))
+            if self.efault and path in self.efault.split('|'):
+                fix_paths.append(
+                    # Emulate EFAULT when path is null
+                    "if (%s == NULL) {\n"
+                    "\t\t\terrno = EFAULT;\n"
+                    "\t\t\trc = -1;\n"
+                    "\t\t\t%s\n"
+                    "\t\t}\n" % (path, self.rc_return()))
             fix_paths.append(
                 "%s = pseudo_root_path(__func__, __LINE__, %s%s, %s, %s);" %
                 (path, prefix, self.dirfd, path, self.flags))
diff --git a/ports/linux/statx/wrapfuncs.in b/ports/linux/statx/wrapfuncs.in
index 168234f..a81fb91 100644
--- a/ports/linux/statx/wrapfuncs.in
+++ b/ports/linux/statx/wrapfuncs.in
@@ -1 +1 @@
-int statx(int dirfd, const char *path, int flags, unsigned int mask, struct statx *statxbuf);
+int statx(int dirfd, const char *path, int flags, unsigned int mask, struct statx *statxbuf); /* efault=path */

