Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE09CD8C85
	for <webhook@archiver.kernel.org>; Sat,  6 Jun 2026 20:57:16 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22941.1780779428367268810
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 06 Jun 2026 13:57:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=nNGifq7G;
 spf=pass (domain: gmail.com, ip: 209.85.216.53, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36b903567fdso3098027a91.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 06 Jun 2026 13:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780779428; x=1781384228; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PiH5K+zrpLVGDqO9WMx98PotzZAKiEq3u9i0aPQa8os=;
        b=nNGifq7GvLauHW95fIpzNayMpyUNWlkQI8GSbWJbpCDe4VMsVkS/3CT/oXrZtqkYJG
         5vLhqoNzLJhxKeo4T3lxqQKJ3CP32Tqd+oZe05TySojPlNfewuBVT5/xGGVUMo9o8fPx
         YSM/J6OokrjvfLFf4ZT/V46cAmRXupwuagh0y48CQ2qOBMRRnnnOjboCDKMn6BIWzTXS
         dUzTfJrwq5+U2XFSfZOy8QvYJ/U43v5BRL+UzEIzmjlRj09vhhIZbYgoRxZ5NmKmiw6q
         yTaGIj9Q2Os1SIdwFXSwU2WlJ08db048DbW9SYs3D5HezbO7fATFHKLxL3ryYKXWGI1L
         bOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780779428; x=1781384228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PiH5K+zrpLVGDqO9WMx98PotzZAKiEq3u9i0aPQa8os=;
        b=Hm4LHnq8GXUsPpMW/0l6CaxXtCfPUidT5ds3FE3X1+/MKh/gKZdn+AsXgO6B0Pijv5
         G1ETjD6tulunmPQ8OpoLo2BZAiaiq64/Nuus/kH4qBAW1yWCSf2iuGa06bHKHRQyy/Q9
         JdD3yjS+BI+n+bRy2aRyovymRGBfNkKJHQ+fzUg22U98PjxW7UvuLJDtOnd+SlA/GqiA
         agV4Q7JUMSf9EuJreNliymmd9Qk0B2eeKCUCSwSmE4IIltJCYboEVR3HL4q3n0Vts35J
         b5wHNydnL7sZpk58truY5mRyM1X7/wSe1OxCY6owP80CJd9Tj3+mVs7CP4+yphenr3cY
         5FTA==
X-Gm-Message-State: AOJu0YwbOb0hF2eB6a8trFSz8QQi313aCi16NP9voLtiUzPC4y3MOUZX
	iQ0ZwLrJJuxoN9ry3HiF4aMTdzmNJhu9lG2BhEPWNoDP3D2d0wYrnWziNjrS0w==
X-Gm-Gg: Acq92OEiLnG60MkQHQAOur/WSTQxfjjjs5FyAmkuyQh+uvFuEMsgcPZZ2J8M1aO9deV
	DXaM8sB8/KWtcfVcauwl/piXawUsV/X7j5lhgRnlR38pfgrW4rWTt2Vvw8HEx0p2SYxFoDLszUT
	CxJ9NA+h6xzH3CKuFWn1amZ53froTi9nU0O2SehB9+4qy2cTinPzPGYzA5okp5yLjS7LlL9s0IC
	taEZLEOGu+pVvhZGm598vDBHyNzTjkzacNDZZQTx1oj4IZxH+eiYP3zou5Ihh6uTZ4Qy841KeCB
	cURLDwWrWB9Ahh11n6iaHUj3XfLdUSOrDwI9GwY7NPByWQdNd1kuuv9BBP/wPEHmoCvzfqXBFzE
	73O+2ZqcrtHpeAIltFeYL3uBmbPdsNj0Htdj2vZGXUVnoKzlj4SERmFF13wgk4hyUUK4NmCQauO
	2nObbkd8V5BiMXGL3ygqNDXMDdvhvXxl+Rk0sNKJfN2Napr7fy54bXaMliUGKWDV5y4zvEK3TI2
	ti31uboCcEaNZ4z69keFuC9dlVRJRufGw==
X-Received: by 2002:a05:6a21:62c8:b0:3b4:93b9:2b91 with SMTP id adf61e73a8af0-3b4ccd45993mr10137636637.12.1780779427562;
        Sat, 06 Jun 2026 13:57:07 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0bd337sm11391353a12.29.2026.06.06.13.57.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 06 Jun 2026 13:57:06 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH v2 3/3]  layerindex/management/commands/update_git_urls.py
Date: Sat,  6 Jun 2026 13:55:58 -0700
Message-ID: <20260606205557.76595-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606195450.59191-3-tim.orling@konsulko.com>
References: <20260606195450.59191-3-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 06 Jun 2026 20:57:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4169

* Run with python manage.py update_git_urls [--dry-run] [--quiet]
* For docker compose, run with for example:
  docker compose exec layersapp python3 /opt/layerindex/manage.py update_git_urls
* Updates vcs_url, vcs_web_url, vcs_web_tree_base_url,
  vcs_web_file_base_url, vcs_web_commit_url on every LayerItem
* Rewrites git://git.openembedded.org/ and git://git.yoctoproject.org/
  → https://, and as a bonus rewrites the matching
  http://cgit.openembedded.org/ and http://git.yoctoproject.org/
  web-interface URLs to https://
* Rewrites git:// and http:// to https:// for github.com, gitlab.com
  and bitbucket.org.
* Wraps work in a transaction; --dry-run rolls back and just prints the
  diff per layer

Fixes [Yocto #16240]
Fixes [Yocto #16305]

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
Changes in v2:
add http://cgit.openembedded.org/cgit.cgi/ and https://cgit.openembedded.org/cgit.cgi/
pattern

 layerindex/management/__init__.py             |   0
 layerindex/management/commands/__init__.py    |   0
 .../management/commands/update_git_urls.py    | 141 ++++++++++++++++++
 3 files changed, 141 insertions(+)
 create mode 100644 layerindex/management/__init__.py
 create mode 100644 layerindex/management/commands/__init__.py
 create mode 100644 layerindex/management/commands/update_git_urls.py

diff --git a/layerindex/management/__init__.py b/layerindex/management/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/layerindex/management/commands/__init__.py b/layerindex/management/commands/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/layerindex/management/commands/update_git_urls.py b/layerindex/management/commands/update_git_urls.py
new file mode 100644
index 0000000..b6f285e
--- /dev/null
+++ b/layerindex/management/commands/update_git_urls.py
@@ -0,0 +1,141 @@
+# Update git:// URLs to https:// in layer metadata
+#
+# Replaces git://git.openembedded.org/ and git://git.yoctoproject.org/ with
+# their https:// equivalents on LayerItem records. Also rewrites legacy
+# http:// cgit web-interface URLs for those hosts to https:// so the
+# generated browse/tree/file/commit links work.
+#
+# References:
+#   https://bugzilla.yoctoproject.org/show_bug.cgi?id=16240
+#   https://bugzilla.yoctoproject.org/show_bug.cgi?id=16272
+#
+# Usage:
+#   python manage.py update_git_urls --dry-run
+#   python manage.py update_git_urls
+#
+# Copyright (C) 2026 Konsulko Group
+# SPDX-License-Identifier: MIT
+
+from django.core.management.base import BaseCommand
+from django.db import transaction
+
+from layerindex.models import LayerItem
+
+
+# Fields on LayerItem that may carry a URL we want to rewrite.
+LAYER_URL_FIELDS = (
+    'vcs_url',
+    'vcs_web_url',
+    'vcs_web_tree_base_url',
+    'vcs_web_file_base_url',
+    'vcs_web_commit_url',
+)
+
+# (old_prefix, new_prefix) replacements. Order matters: longer / more-specific
+# prefixes must come first so we never partially-match a shorter one.
+REPLACEMENTS = (
+    # Fetch URLs: git:// -> https://
+    ('git://git.openembedded.org/', 'https://git.openembedded.org/'),
+    ('git://git.yoctoproject.org/', 'https://git.yoctoproject.org/'),
+    ('git://github.com/', 'https://github.com/'),
+    ('git://gitlab.com/', 'https://gitlab.com/'),
+    ('git://bitbucket.org/', 'https://bitbucket.org/'),
+    # Old /cgit/cgit.cgi/ paths redirect to https://git...
+    ('http://cgit.openembedded.org/cgit/cgit.cgi/', 'https://git.openembedded.org/'),
+    ('https://cgit.openembedded.org/cgit/cgit.cgi/', 'https://git.openembedded.org/'),
+    ('http://cgit.openembedded.org/cgit.cgi/', 'https://git.openembedded.org/'),
+    ('https://cgit.openembedded.org/cgit.cgi/', 'https://git.openembedded.org/'),
+    ('http://git.openembedded.org/cgit/cgit.cgi/', 'https://git.openembedded.org/'),
+    ('https://git.openembedded.org/cgit/cgit.cgi/', 'https://git.openembedded.org/'),
+    ('http://git.yoctoproject.org/cgit/cgit.cgi/', 'https://git.yoctoproject.org/'),
+    ('https://git.yoctoproject.org/cgit/cgit.cgi/', 'https://git.yoctoproject.org/'),
+    # Web-interface URLs: http:// -> https:// for the same hosts. Both
+    # cgit.openembedded.org and git.yoctoproject.org redirect http to
+    # https, but storing https directly avoids the extra round-trip and
+    # mixed-content warnings inside the layer index UI.
+    ('http://cgit.openembedded.org/', 'https://git.openembedded.org/'),
+    ('http://git.yoctoproject.org/', 'https://git.yoctoproject.org/'),
+    ('http://github.com/', 'https://github.com/'),
+    ('http://gitlab.com/', 'https://gitlab.com/'),
+    ('http://bitbucket.org/', 'https://bitbucket.org/'),
+)
+
+
+def rewrite(value):
+    """Return (new_value, changed) after applying REPLACEMENTS."""
+    if not value:
+        return value, False
+    new_value = value
+    for old, new in REPLACEMENTS:
+        if new_value.startswith(old):
+            new_value = new + new_value[len(old):]
+            # A given URL only matches one prefix, so we can stop here.
+            return new_value, True
+    return value, False
+
+
+class Command(BaseCommand):
+    help = (
+        'Rewrite legacy git:// (and matching http:// cgit) URLs on layer '
+        'metadata to their https:// equivalents.'
+    )
+
+    def add_arguments(self, parser):
+        parser.add_argument(
+            '-n', '--dry-run',
+            action='store_true',
+            help='Show what would change without writing to the database.',
+        )
+        parser.add_argument(
+            '-q', '--quiet',
+            action='store_true',
+            help='Only print a summary line.',
+        )
+
+    def handle(self, *args, **options):
+        dry_run = options['dry_run']
+        quiet = options['quiet']
+
+        changed_layers = 0
+        changed_fields = 0
+
+        # Wrap the whole pass in a transaction so a --dry-run can be rolled
+        # back cleanly and a real run is atomic. We bail out at the end if
+        # this is a dry run.
+        with transaction.atomic():
+            for layer in LayerItem.objects.all().order_by('name'):
+                layer_changes = []
+                for field in LAYER_URL_FIELDS:
+                    old_value = getattr(layer, field)
+                    new_value, changed = rewrite(old_value)
+                    if changed:
+                        setattr(layer, field, new_value)
+                        layer_changes.append((field, old_value, new_value))
+
+                if layer_changes:
+                    changed_layers += 1
+                    changed_fields += len(layer_changes)
+                    if not quiet:
+                        self.stdout.write(
+                            self.style.MIGRATE_HEADING(
+                                'Layer "%s" (id=%d):' % (layer.name, layer.pk)
+                            )
+                        )
+                        for field, old_value, new_value in layer_changes:
+                            self.stdout.write(
+                                '  %s:\n    - %s\n    + %s'
+                                % (field, old_value, new_value)
+                            )
+                    if not dry_run:
+                        layer.save(update_fields=[c[0] for c in layer_changes])
+
+            if dry_run:
+                # Roll back any pending writes (there shouldn't be any since
+                # we skipped save(), but stay defensive).
+                transaction.set_rollback(True)
+
+        verb = 'Would update' if dry_run else 'Updated'
+        self.stdout.write(self.style.SUCCESS(
+            '%s %d field(s) across %d layer(s).'
+            % (verb, changed_fields, changed_layers)
+        ))
-- 
2.54.0


