Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5866.1792445728808583086
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Oct 2026 14:35:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=VXqxebly;
 spf=pass (domain: gmail.com, ip: 209.85.210.169, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a06e79e152so592581b3a.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Oct 2026 14:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792445728; x=1793050528; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WonUais3wbrsAOKZn2Ok1GFMVSxmjcFXngmV8veTCMU=;
        b=VXqxeblyvLv+5xX6UC0ZOgUDhSWpKJ5fXyz0CPZWjkmrgqjQaix+FPeZ30QTBy7aDM
         G2EpAgsu4eNTYxyd8J9FEVv+a5FuOSEEveAPyZSKW+/lkl37apwdJOSgc99MhWyWjNuW
         XzxbNheFahIP9ssq5wi7im+OfyifUEDFMTiZGUH2HpwG0Cug+Wr4caLF4/5DtYNJFy7x
         KZytNHJt7FgqTOGPGDi0l+XEuhtdRIcsQ63sLjTYukHWGwIeWawtHg38FbnxQLYoWMDy
         TDOnukkdfLN0OF5enkk1pM32/rTc+eobnMzl05COPyU2lH2ayHTlNejRfwdKEpa+JEED
         5vxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792445728; x=1793050528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WonUais3wbrsAOKZn2Ok1GFMVSxmjcFXngmV8veTCMU=;
        b=U7wakVCGX3yfCBtQiiXTDmCTwqlOPBpLox1uQInD9EaWIwZ4C2U7DDCJqP4ZYX2Zm/
         eGICB3UD4cy/nUkpUsqt3oRx/XUNhtCVUendUD1LFCM1M+Bf447F3+sfcOxsZ2aI+WJ6
         g1ZA8YZaMBxXNkcQbDqQTevqWjryqoj4AQfm4kVQs87l+9ktTjC819rS3vPvdBwNab31
         qSsWUOVjarmkdM8u50d1qGEY4+7K7M2sge1tY9XDoJBCV87RyXb7NRpP5+5rnYnHcuVM
         j4sTEcgPc+KpNJLfeIZnLiXxGSxbZzEl1K+iM4SHoFyR54Xv3CqvyLZlj6itK6itl3GL
         mGiw==
X-Gm-Message-State: AFq9FYJJXqwFKG5nYUQPvBYsWMecksw2YZK95twIB8a8yYXHjA7WkFkr
	7tGoW+04lqXvCXfYVueV4UgtjMGu4WH4QiUDGvIgdtbTa8p5xwlf+5NgbPtN+g1c
X-Gm-Gg: AYBFou0LfvNKtkQzcVJrQfw9pGqo9V1nQZtXhiqLrLql+Tk5H9+EWLJbiQrrp4Gs++N
	5Zrjtw/FfO18NnuZsmKVNjr7TLeMq9XSN6KxpMhiNHBYEW9kH1789FwMbyYa7jbkvOEyHFAHh9l
	iU+pVBByryhLNr8n9YpXgMa37X4UZLsHtw9azj87dZl6Ybw0JYjHax3v7AiFFdexobThFPIytuS
	XSjT/pa5MA1jCQTlljPZC0WbxBh7QFOxiZKnIhEdMLniJfXrWVT8FnXTfiCOTluU0cTyNF/bLJm
	mLN6iXbgl53c/+eCjNXAbhAT53eg8f2/KnZ0OOqfYP62qEYLIc0uUBYqRQX+OruGyvz1DALcnJW
	g006lGrCbdJN0nQm17tkNkqTgQXfwWQJRrTFnYLwTY9FzGhlvH1frNLGVoE2+Gv8yR7VIjAMUAy
	7NtWH7dHIG1pObq6iFK83nLtAAiWQOXnu11htTJ2sn7J5PtCsZGP81Y1lsYrKaA87ShrI1ESAIg
	sRGmgfV8aondEVQePuMGE3QOBQ/k1d2
X-Received: by 2002:a05:6a00:22ca:b0:891:d071:1e55 with SMTP id d2e1a72fcca58-8a04ba1ebf1mr5650900b3a.21.1792445728148;
        Mon, 19 Oct 2026 14:35:28 -0700 (PDT)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f5820b344sm4307747b3a.53.2026.10.19.14.35.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Oct 2026 14:35:26 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 3/4] recipeparse: don't add the core layer to BBPATH twice
Date: Mon, 19 Oct 2026 14:35:09 -0700
Message-ID: <20261019213510.4384-4-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019213510.4384-1-tim.orling@konsulko.com>
References: <20261019213510.4384-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Oct 2026 21:35:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5103
Content-Type: text/plain; charset="utf-8"

The core layer is in BBLAYERS, so its layer.conf already appends it to
BBPATH. Adding it to the initial BBPATH as well made include_all read
maintainers.inc twice, giving "Duplicate inclusion" warnings. Leave it
out of the initial BBPATH, and use core_layerdir in BBLAYERS instead of
assuming "meta".

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/recipeparse.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/layerindex/recipeparse.py b/layerindex/recipeparse.py
index d593def..d8486e7 100644
--- a/layerindex/recipeparse.py
+++ b/layerindex/recipeparse.py
@@ -66,10 +66,11 @@ def init_parser(settings, branch, bitbakepath, enable_tracking=False, nocheckout
             utils.checkout_repo(core_repodir, "origin/%s" % core_branchname, logger=logger)
         if not os.path.exists(os.path.join(core_layerdir, 'conf/bitbake.conf')):
             raise RecipeParseError("conf/bitbake.conf not found in core layer %s - is subdirectory set correctly?" % core_layer.name)
-        # The directory above where this script exists should contain our conf/layer.conf,
-        # so add it to BBPATH along with the core layer directory
+        # The directory above where this script exists should contain our conf/local.conf,
+        # so add it to BBPATH. The core layer is added by its layer.conf via BBLAYERS
+        # below; listing it here as well would put it in BBPATH twice.
         confparentdir = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
-        os.environ['BBPATH'] = str("%s:%s" % (confparentdir, core_layerdir))
+        os.environ['BBPATH'] = str(confparentdir)
 
     # Change into a temporary directory so we don't write the cache and other files to the current dir
     if not os.path.exists(settings.TEMP_BASE_DIR):
@@ -84,7 +85,7 @@ def init_parser(settings, branch, bitbakepath, enable_tracking=False, nocheckout
         if not classic:
             # We need this to avoid problems with AVAILABLE_LICENSES
             f.write('COREBASE = "%s"\n' % core_repodir)
-            f.write('BBLAYERS = "%s/meta"\n' % core_repodir)
+            f.write('BBLAYERS = "%s"\n' % core_layerdir)
         pass
 
     if logger:
-- 
2.56.0

