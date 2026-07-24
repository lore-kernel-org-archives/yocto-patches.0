Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B24C531FF
	for <webhook@archiver.kernel.org>; Fri, 24 Jul 2026 11:50:38 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17430.1784893833047490751
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Jul 2026 04:50:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=YdQyaPpk;
 spf=pass (domain: gmail.com, ip: 209.85.219.54, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-907ae240ac3so1407076d6.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 24 Jul 2026 04:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784893832; x=1785498632; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JwC95TNA9OM0vRjfBduHlrjm64mEGMSsQWRPk1cqgmg=;
        b=YdQyaPpk355unbff4SwKe7IvX/ptvM+qlhbDRcvELLkWDNBSZVF4LsoZo2yF4KPv4g
         CQ0YQ7KHJKKsbtHbWsLpyryILnjhU54kG/quoS3gtpsWRpHYz6XWBPnnki0+F6qX5WS8
         B8buWQg0z77XXQTEnOb3KxGXd5Wnh0zu3nRzOmA0xz/LSBKRRMAYzfQD+A+4yLP6nX9t
         csx6tdXrFiJvV2G0uu2p1xU6OEkQyOix0F+zLPt+dgr4yf2gZw5CSMVup1QTsbjdHN+K
         WHXe4u/k1zb9Z+d/piTKOr61MAHPJ96hRE6DN5YIPlKrlhjaaTpnTFGkvoL4/yqqk0m/
         ECYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784893832; x=1785498632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JwC95TNA9OM0vRjfBduHlrjm64mEGMSsQWRPk1cqgmg=;
        b=TsCgYMWYS6kM2h9G8+9XjS2UlFlU0MkwBOBGPM181FHL4lahhOB5zCddWlW6p/2liw
         rKyb2FoNYvG9EPzgjVp6yOnQiaOmlch+HUYGeLuGTjEsSZkcAR9jl67SxVjaGhFYXrsx
         O8l53e6swi8Mo7X+DbxZhIA0XuBCbMF3kR9edk0aWHCrbUq7P0JqZPHStbXcp/Wx4J9b
         o6C8XEhHev2OhVFxpDR9kLg1QgI0chEFUvUVdm7NTJ33N8tRjOQPndytMFZOMu7PrNUH
         oX2SzHC1ctv3K+nWldX6uIFRskilzFFNxs7x9VA7JGbmXfWWDdYQ0EzcBRTON35G7i+Y
         zJlQ==
X-Gm-Message-State: AOJu0YwMcUIE5fvR8+Of5MvtMlnw0HgSuofTmL525oEdNJlRUenTcEx4
	56ZJuiADK57UzkwVQSrBEBpkLK+3eXhyAcuMCzzBH4IQChoXAq1wCNfppX+LYA==
X-Gm-Gg: AR+sD12skqUGwj5lOaed8bTYmQ/5DVt7NKy7ApxAMtRx9X4vY9ohaFIHaX7nLSjP20S
	lcMpverBAunHg6nNRCPKWu+27/tREgI/17GoOMiopwFsKk/Oij0DqRz7YqI8e1/N0x7WODArsq4
	V3Orm4+Oh8p4phnFbPbgsriafbbMp+p2w9yQG9WhU6McGO01KNyiKMmhmX+ju/tFNEFfztiZoS9
	mHagw8gXfeD4F44shD6qMJMKpWUegvC70/IHyrQ8+7Df5NKAeeUt0K7CG8iSC3nZQS1CkPv1ZbR
	I8Ap7rcBpi7LlKRUuu/dLjMRl43WPgK+UtdTYjeQcaksBe4EO/Z0nRHUzIcXfGVAlk15pwGkH2g
	gE2+gPY12FingqpjcFN3Jm+OvYwk6WbmeLdxcQO0jGDuhBPM0FLbet+/haCIfl71+flJEg6I6Qs
	TEeWQuOvWeoKmAAG3Wt7NeqKmr4K+03deFKQ2OE+C0iCKH
X-Received: by 2002:a05:6214:da1:b0:8f3:6c2:222 with SMTP id 6a1803df08f44-907ca57d0famr80312586d6.14.1784893831870;
        Fri, 24 Jul 2026 04:50:31 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907baa27cf1sm66582796d6.46.2026.07.24.04.50.30
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 04:50:30 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH v2 2/4] oe/path: don't glob-expand the destination in symlink(force=True)
Date: Fri, 24 Jul 2026 07:50:18 -0400
Message-ID: <20260724115020.38079-3-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260724115020.38079-1-twoerner@gmail.com>
References: <20260724115020.38079-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Jul 2026 11:50:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4534

symlink(source, destination, force=True) cleared an existing
destination by calling remove(destination). remove() is a rm -rf
helper that runs its argument through glob.glob() before unlinking, so
it treats the destination as a glob pattern rather than a literal path.

For ordinary names this is merely wasteful, but a destination that
contains glob metacharacters is actively dangerous. A name with a '['
may fail to match itself and silently leave the old link in place, and
a pattern that happens to match other entries could unlink files the
caller never named. remove() even warns about exactly this in its own
docstring.

Remove the literal destination directly instead: unlink it, fall back
to shutil.rmtree() when it turns out to be a directory (EISDIR), and
treat a missing destination (ENOENT) as success. This mirrors what
remove() does per matched name, minus the glob expansion.

AI-Generated: codex/claude-opus 4.8 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes in v2:
- No change; carried over from v1.
---
 src/wic/oe/path.py | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/src/wic/oe/path.py b/src/wic/oe/path.py
index 862edc532ade..13c52b363694 100644
--- a/src/wic/oe/path.py
+++ b/src/wic/oe/path.py
@@ -168,7 +168,18 @@ def symlink(source, destination, force=False):
     """Create a symbolic link"""
     try:
         if force:
-            remove(destination)
+            # Remove the exact destination path. Do not route this through
+            # remove(), which treats its argument as a glob pattern: a
+            # destination containing glob metacharacters (for example a
+            # '[' in the name) could fail to match, or match and delete
+            # unrelated files.
+            try:
+                os.unlink(destination)
+            except OSError as exc:
+                if exc.errno == errno.EISDIR:
+                    shutil.rmtree(destination)
+                elif exc.errno != errno.ENOENT:
+                    raise
         os.symlink(source, destination)
     except OSError as e:
         if e.errno != errno.EEXIST or os.readlink(destination) != source:
-- 
2.50.0.173.g8b6f19ccfc3a


