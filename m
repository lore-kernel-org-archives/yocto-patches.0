Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03667E85399
	for <webhook@archiver.kernel.org>; Fri,  3 Apr 2026 18:37:17 +0000 (UTC)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2220.1775241428609077688
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 03 Apr 2026 11:37:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=CazRYbDJ;
 spf=pass (domain: gmail.com, ip: 209.85.222.176, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8d583bfc415so7437085a.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 11:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775241427; x=1775846227; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVlXJdTy+svRvIiWFlY0lVUTfly3eo0gZhZ3HhtXLLs=;
        b=CazRYbDJgt83qVlfUzFiYuNFNcpXT+7AeXXZv8ir5wrbbB6sGm8oh5IuJISpw8VMSp
         mngGQ1uUB7AyofoAHDuvW8AUlsFggZ7nmnik6FzREmqv21S173JGGOpwbhvnT2NizULs
         nxrHxz6AAHruq9+zi1SCSDVqLyjN2Fy3tpITg0iIKPI7eC2xVElG7DcQlkbZZw/RsEYI
         vz8rkAXYiRDJ+OjklFHc+w+47Ew0LRdboO1lq57gKnVuBPZnggfF9vpjIgsLRpujUKyF
         U7UE1qaADDy0Az4CiMYtUvKLkqp5K+TxA7PGG8abG9Fvl/fQskQZIaZ2X3Df409pxG0N
         1GgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775241427; x=1775846227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rVlXJdTy+svRvIiWFlY0lVUTfly3eo0gZhZ3HhtXLLs=;
        b=K/04+S7Ckmhzu+eDeNd6qvLpdyqZHpU0idlDe+/cQi7nSTJ9qdKJqOpHYl38NAeqxg
         uEbwMyO3Kv1Ucjh82nWzg+MzUE4JONZ+TNkp2uFAHDmhKHw5foE9KdIBatHxEFFusFFo
         E/kjtTPeJ9ufUnAZQtigqZtFORtqdWet7TdKcokvA9+8n2JqhH8laWELbXfxCdonGucN
         BVHTE70R+py3wmfhztnyNAcZ4Ykg2wHBa8cuvgoaKkOfcqKC0SvPmihPKUU/DCUKxE3D
         uUhV4Uv5gj6tUFmypSIdf56ePl6GSZWhghekfbdMc9hrJRIRYjJUWx5YISIx4vObJJ9w
         PXgA==
X-Gm-Message-State: AOJu0Ywwl3B0iqxqxeVfbhxLi7XfDpmDCfOAQGkLjVkeGnCQUK8kpsYe
	37QkNmBX30tP2u2y3BpSlKdymyffx/CiYP81CsFTSwQVdFKHjGZy5bW2XgzWdnH3
X-Gm-Gg: ATEYQzyx3i+HH0NkTtonhbtsNlZbLZoHpujCqMp0FSbFfHhvTFFMLVThD1DcrZIppDv
	ma4obqgn6VSPgiU0EMN1vf+lbsoo9pl5Ommi7+7S0YYCD+91Lep6eSBdu6Evb7PDADfaV6qBnPb
	s/El6ZfaZ85z31q/D/Sv6aVV7fWgyUKcH1DrYKxQ+25uOUZVVT7uOg6pz4kUwtsTiR3nsJTHsdT
	uGhS7edKcbJAFRTTS81/fLyVv5OSaMV0EYHT6n2OJm41IvByvMJUyZ2+EfXkMKIhDTP44pTsI0N
	FcTAiqptplAIKvgmRhuMPy7UtliuyJq08VNoOp5n/Klld7wERtcev2vKU4JcLSjFRciLarsnxXL
	eNHgb3MYS81yyHISscNbNZirxjmpaiqWbpydfPy7d5AOP2yQCwCbOfXvU0bAqKLVSOahUpF4YM4
	AV0boC0axT2pEsRrsgyBr8SvbPIkgujrliihy9nmc/+SAkAXXCKweOllfygi8NtEyxiiqC6/zzL
	sTj
X-Received: by 2002:a05:620a:1788:b0:8cf:d3a9:60d4 with SMTP id af79cd13be357-8d4188c2077mr563797585a.5.1775241427149;
        Fri, 03 Apr 2026 11:37:07 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a874459asm472401785a.39.2026.04.03.11.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 11:37:05 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Bruce Ashfield <bruce.ashfield@gmail.com>,
	Mark Hatle <mark.hatle@kernel.crashing.org>
Subject: [wic][PATCH 8/9] ksparser.py: search for *inc files
Date: Fri,  3 Apr 2026 14:36:43 -0400
Message-ID: <20260403183644.2783267-9-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260403183644.2783267-1-twoerner@gmail.com>
References: <20260403183644.2783267-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 18:37:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3634

If a *wks file has an "include" directive, try looking for the include
file at the path where the *wks file was found.

NOTE: this commit does not work as-is, but is being provided in order to
      explicitly show a clean transition from oe-core

AI-Generated: codex/gpt-5.4 (high)
Reviewed-by: Bruce Ashfield <bruce.ashfield@gmail.com>
Reviewed-by: Mark Hatle <mark.hatle@kernel.crashing.org>
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 src/wic/ksparser.py | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/src/wic/ksparser.py b/src/wic/ksparser.py
index 4ccd70dc555a..8e5fbfadd81f 100644
--- a/src/wic/ksparser.py
+++ b/src/wic/ksparser.py
@@ -101,6 +101,15 @@ def overheadtype(arg):
 
     return result
 
+def resolve_canned_path(arg, current_confpath=None):
+    if current_confpath:
+        current_dir = os.path.dirname(os.path.abspath(current_confpath))
+        relative_path = os.path.join(current_dir, arg)
+        if os.path.exists(relative_path):
+            return relative_path
+
+    return None
+
 def cannedpathtype(arg):
     """
     Custom type for ArgumentParser
@@ -202,7 +211,7 @@ class KickStart():
         bootloader.add_argument('--source')
 
         include = subparsers.add_parser('include')
-        include.add_argument('path', type=cannedpathtype)
+        include.add_argument('path')
 
         self._parse(parser, confpath)
         if not self.bootloader:
@@ -289,7 +298,12 @@ class KickStart():
                         self.partnum += 1
                         self.partitions.append(Partition(parsed, self.partnum))
                     elif line.startswith('include'):
-                        self._parse(parser, parsed.path)
+                        include_path = resolve_canned_path(parsed.path, confpath)
+                        if not include_path:
+                            err = "%s:%d: argument path: file not found: %s" % \
+                                  (confpath, lineno, parsed.path)
+                            raise KickStartError(err)
+                        self._parse(parser, include_path)
                     elif line.startswith('bootloader'):
                         if not self.bootloader:
                             self.bootloader = parsed
-- 
2.51.0


