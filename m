Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C19C44501
	for <webhook@archiver.kernel.org>; Thu,  9 Jul 2026 20:52:51 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.959.1783630369094074989
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 09 Jul 2026 13:52:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=J8nbtKPX;
 spf=pass (domain: gmail.com, ip: 209.85.219.54, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8eff5ce3b95so2677986d6.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 09 Jul 2026 13:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783630368; x=1784235168; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1MZXIBj4uSLo0hGPYjb+s/MPK/IOTMyIR81VKB391bg=;
        b=J8nbtKPXj5YIvKCOLZnxu3A9hLGlijVCb8A54yJLu6+16ex8s/nLBiG3ZejM1K5nAb
         VVURQBJP/LW84eShHCJhZGj31WJAUTQlBvvQakoVgtIK99KPLEAgjrrD35K534xcIFpA
         AaCJb0UKyii2jpeoSbyDZxmI7c8JOPjAclI84YLd6cQQrZPcYbzgMaWQewTT0sj0/G8g
         MnznF79aF7ojOv2bD4JW3ZWGlQsBogccmsMEouIp//yjNg418Ur+P1rs2HM63/LnzSZ/
         1MmQo/rBv2BLq0Uqmgz89vwvCMGWA8I3QAbXRmzl9zHBVTkSld4ad7nMe1AUT3dhC9Gn
         Jk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630368; x=1784235168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1MZXIBj4uSLo0hGPYjb+s/MPK/IOTMyIR81VKB391bg=;
        b=L0kWsGenYHL/3PKbT9kbLM+xeGu23RL3FUd3mpPnDDdxVwV8mDuAwhI8nmM9WrO/0g
         c7CCVaPaHOfFuTeSnZGm2pS1tE2x9flzPS0yKci+8At4zjhlIV6rYvxTT2iuLoPo9JI+
         2x/7GjaLTGIZEOUifkzoloFulBEOghxsufn0oPDxqd4viYdsfLdqAk1zsZL1Ih8cZsgm
         45TNXTHCS3MzngvP7TXoYE9jKie0d+fTQwjv9n9v9pgEDLVlHUJWZLuXBDZAapOo7wuy
         oC0yNG35d2QyBIwqV9hjOmv9dsCc9qnygaNBAkCl435rYVVMwy4xQfsWlivdZ+ixdjLr
         HMLg==
X-Gm-Message-State: AOJu0Yxc9UaFv6Hpu9eV7ajkmm6etK/TQaVbtfXAk6AbtO/rXd9TLvaF
	1CrVcJZaNGAwXpvgVpbGno+L/qaWwnrgVl8LvlY3rv0fUahguyipTKXO8xXmxw==
X-Gm-Gg: AfdE7ckOM6UFCYEA1mPTAjWguIi+P3LbYN322J4AZIdkT+TUSng2D7+JuSvoUIcgUhd
	NWHMFx8MArOZLW1c5DTSHCuP9ef0tMxG04HH03QATCLtP0H5zUJ6wIc3A+cYrujFKMyQnblSqWb
	3Wf/JrNQeDMTExid9E7iPIZCDEOm39oph4RQ1vfKbCCMCh3tT1+jaoXgVTw0rDZJaWXlG7nMTZ6
	ndJG0zZP62yXWdqvcBeSws34aepaGha/LlLpm2PX9htUib/Er6pjOEzb6UwFSZ+INxMKmEETaCB
	WF19hJHJovx+uWCyM08VxEGuGep/MJBkQ/Yw4S0DHsnPD1HCqu6cgQ+fJWFdOmpTowkt7Bp+xPJ
	uI0qprxl50XmYWCuUP3IKgXuviEJDU27cVz/iq+fDmuFDO66xwVsgoutBGNhfemTmwJxbYE9QFV
	CadvHaZXEh2NRkZOp9Ia+cUyx5ZgHKxGfLgMw8s07FL+rS15znLqRsOG8=
X-Received: by 2002:a05:620a:444e:b0:92e:c118:18aa with SMTP id af79cd13be357-92ecf940e8bmr908524885a.93.1783630367911;
        Thu, 09 Jul 2026 13:52:47 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d37540sm32893085a.38.2026.07.09.13.52.46
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:52:47 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH 2/4] oe/path: don't glob-expand the destination in symlink(force=True)
Date: Thu,  9 Jul 2026 16:52:25 -0400
Message-ID: <20260709205227.3470712-3-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260709205227.3470712-1-twoerner@gmail.com>
References: <20260709205227.3470712-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 Jul 2026 20:52:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4461

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


