Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3112CCCF2D2
	for <webhook@archiver.kernel.org>; Sat, 17 Oct 2026 18:32:23 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1908.1792261938289711201
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 11:32:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=VtMQcQyM;
 spf=pass (domain: gmail.com, ip: 209.85.216.52, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38759bcd877so543992a91.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 11:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792261938; x=1792866738; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S4AuhXY4qjQvLP9ruucqYU6jZ+aotqdWoKHzCsIca7Q=;
        b=VtMQcQyMFw/ZKI6+2/I2r8R9Xon5abEVm4DrNBhHABCZiR/z4gbBPiFCD9ew9OkR0i
         6COGxGqr0EM/bxD9UuUQF9Ln/zDAGQ59nHsP/RSKD6RjQLjJIBI4S0SKm3Tv+4XEaAtJ
         p0JUsYqDIpVklqVOncBNa4a6pjvP1JBoC85mwiAdWaJEYv6QSmizWvYQrXh5JY9hpedd
         T1s7epUi0AxjQulVDOz3mtpv71fFV2lTO6rS+rfLVmjzdDH7Fx1ql8lKwnMjtNDWmhXj
         hu8tS4i4UsS9j3en6VgcnN9VCofq2wuRdU20mEQDi2hzqHrpEjCh3niCVouP7wGXPHDR
         xh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792261938; x=1792866738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S4AuhXY4qjQvLP9ruucqYU6jZ+aotqdWoKHzCsIca7Q=;
        b=21Rfa4LSJO2rt3rHiqS6K5CQht5BCmDkQhUXPknR7eSZqtgOKO18xtkgSJsrrCKdjA
         Z9dRfRuqjjze9yywxPipRe3g+6E15L2F7XsQJ8IvQONtuqJbNxzMl+2BjM6u1YxgsGzx
         56e9qMDvvvIxjIalvrqI0TXllQUGWkRo6ChowGDDBzr3nlCQxQN+Q35oqXhgP0aUdUnO
         +9UeIa+tlhsVqrFQih97b8pqcSaFlEyJ02XKpCbktmj3FVvM/+ShjngIVssQ0AUhlWvj
         Y0H/IPEU1/0NcdAC9GVJk6wmSskqGjN55ixdylcM4Jp91x5exJ/5xMi2zVTCQuhsf2EH
         0NxA==
X-Gm-Message-State: AFq9FYJ3C0DN1IwWs+fscksojFIkLr1w0lRbegZq4WqjFUWq/z0I5zw3
	CWXuX9NW9keyEPz1NeaZ3xDpu6bYw09HxR8IokXoNIhUZLCSZ7xrxUbr66cfEg==
X-Gm-Gg: AYBFou1Fbc4sELWEzf3t0EpmtbGx9L4eIbvjHz/5T62WrouramuIgqag3UF9BxHzhg8
	xuG99s6VL3Sgc2YWzYxuaVQUSZrARlrJeyW1UfOvDnCiv3nPlwGPh/A4fcCzVI7yjKxgb+NHe1U
	73OJgma1HyqbtlzLLQXrr1xqkw06QQZ5gpaOlILCtK0Y97DJKTGrkf4+LxWb1EkGbYq5Ba7I2rA
	bfzbIn7EuhHr4CdBp5meun2dr0oDzA6NbK6c6kPZPd6PhNztQrpRT7g7r/wP0udFsIy9VXAkbXz
	kx4ONWBHbaJCrqDWVd2pqv4Dg1KCE52jX2LM1mwRqrkVSGfFPkpEbGPsAh/QVpfPOXwXMIamiO+
	x+xPZEXbAbjM+FzzblspNT8npX3yzLc7dqR61xXyMbGBVozHVw9s2duldVr+3Zz9qgjUMFUsyGj
	o2lvBMeQH8lwUQ4KobgyFWZTqLO55CNs6mDQWFpVOuaJ02scYG4xPRiderU5ZLr9At9/FVLQzuO
	blFm2ldwBJ/VANmumUEMAtE18u9Jm8=
X-Received: by 2002:a17:90b:5111:b0:3aa:f4af:1e0f with SMTP id 98e67ed59e1d1-3acee292795mr3153738a91.8.1792261937551;
        Sat, 17 Oct 2026 11:32:17 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ace34c8d9asm5634097a91.5.2026.10.17.11.32.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 11:32:16 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 2/3] tools: use raw strings for regular expressions
Date: Sat, 17 Oct 2026 11:32:08 -0700
Message-ID: <20261017183209.90930-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017183209.90930-1-tim.orling@konsulko.com>
References: <20261017183209.90930-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 18:32:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5041

Fix the remaining "invalid escape sequence" warnings in the layerindex
and rrs tools, which the test suite does not import. Python 3.12 turns
these into SyntaxWarnings and a future release will make them errors.
The resulting pattern strings are unchanged.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/tools/import_layer.py       | 2 +-
 layerindex/tools/import_otherdistro.py | 6 +++---
 rrs/tools/common.py                    | 4 ++--
 rrs/tools/rrs_maintainer_history.py    | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/layerindex/tools/import_layer.py b/layerindex/tools/import_layer.py
index 0b203c3..0547223 100755
--- a/layerindex/tools/import_layer.py
+++ b/layerindex/tools/import_layer.py
@@ -205,7 +205,7 @@ def get_layer_type_choices():
     return (help_str, choices)
 
 def main():
-    valid_layer_name = re.compile('[-\w]+$')
+    valid_layer_name = re.compile(r'[-\w]+$')
 
     parser = optparse.OptionParser(
         usage = """
diff --git a/layerindex/tools/import_otherdistro.py b/layerindex/tools/import_otherdistro.py
index f6ee395..2a39fb4 100755
--- a/layerindex/tools/import_otherdistro.py
+++ b/layerindex/tools/import_otherdistro.py
@@ -52,8 +52,8 @@ def update_recipe_file(path, recipe, repodir, raiseexceptions=False):
     # yes, yes, I know this is all crude as hell, but it gets the job done.
     # At the end of the day we are scraping the spec file, we aren't trying to build it
 
-    pnum_re = re.compile('-p[\s]*([0-9]+)')
-    configure_re = re.compile('[/%]configure\s')
+    pnum_re = re.compile(r'-p[\s]*([0-9]+)')
+    configure_re = re.compile(r'[/%]configure\s')
 
     try:
         logger.debug('Updating recipe %s' % path)
@@ -294,7 +294,7 @@ def update_recipe_file(path, recipe, repodir, raiseexceptions=False):
                     patchsplit = line.split()
                     if '-P' in line:
                         # Old style
-                        patchid = re.search('-P[\s]*([0-9]+)', line)
+                        patchid = re.search(r'-P[\s]*([0-9]+)', line)
                         if patchid:
                             patchid = patchid.groups()[0]
                         else:
diff --git a/rrs/tools/common.py b/rrs/tools/common.py
index 1ce5dd5..0cac1f7 100644
--- a/rrs/tools/common.py
+++ b/rrs/tools/common.py
@@ -146,7 +146,7 @@ def get_recipe_pv_without_srcpv(pv, uri_type):
     sfx = ''
 
     if uri_type == 'git':
-        git_regex = re.compile("(?P<pfx>(v|r|))(?P<ver>((\d+[\.\-_]*)+))(?P<sfx>(\+|)(git|)(r|)(AUTOINC|)(\+|))(?P<rev>.*)")
+        git_regex = re.compile(r"(?P<pfx>(v|r|))(?P<ver>((\d+[\.\-_]*)+))(?P<sfx>(\+|)(git|)(r|)(AUTOINC|)(\+|))(?P<rev>.*)")
         m = git_regex.match(pv)
 
         if m:
@@ -154,7 +154,7 @@ def get_recipe_pv_without_srcpv(pv, uri_type):
             pfx = m.group('pfx')
             sfx = m.group('sfx')
     else:
-        regex = re.compile("(?P<pfx>(v|r|))(?P<ver>((\w+[\.\-_]*)+))")
+        regex = re.compile(r"(?P<pfx>(v|r|))(?P<ver>((\w+[\.\-_]*)+))")
         m = regex.match(pv)
         if m:
             pv = m.group('ver')
diff --git a/rrs/tools/rrs_maintainer_history.py b/rrs/tools/rrs_maintainer_history.py
index c509e5a..6465ac7 100755
--- a/rrs/tools/rrs_maintainer_history.py
+++ b/rrs/tools/rrs_maintainer_history.py
@@ -37,7 +37,7 @@ MAINTAINERS_INCLUDE_PATH = 'conf/distro/include/maintainers.inc'
 """
 def get_recipe_maintainer(line, logger):
     import re
-    regex = re.compile('^RECIPE_MAINTAINER[:_]pn-(?P<pn>.*)\s=\s"(?P<name>.+) <(?P<email>.*)>"$')
+    regex = re.compile(r'^RECIPE_MAINTAINER[:_]pn-(?P<pn>.*)\s=\s"(?P<name>.+) <(?P<email>.*)>"$')
 
     match = regex.search(line)
     if match:
-- 
2.56.0


