Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26905CD8C85
	for <webhook@archiver.kernel.org>; Sat,  6 Jun 2026 19:55:10 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21926.1780775709265982005
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 06 Jun 2026 12:55:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=VcHFis+C;
 spf=pass (domain: gmail.com, ip: 209.85.215.180, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c8584bbbf2cso1998072a12.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 06 Jun 2026 12:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780775709; x=1781380509; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/YOKm1nJb3S5pFoA9PxW/Ts4pIlulHZWc+XmLv3AjQ=;
        b=VcHFis+ChBdf7QTDT9dDylcuc/u26GNS4CjHVrFdEIkwnlebRYtNkmwoV2RFymTzyi
         zJrKC8uvKQAMlREQXONsOvFwYQuEq1Lg9l7mb/BOdWmqn4dN2FzDrp8hOW9VHKnL5WlX
         jCvFdOg16/eQd1+9wQj6ZtoWZEUSTwfx22GdeiLGK6cvOwZ4WPBwocY0i4zmtt6o80LU
         Wf71+XQnah+L70nbxRaQyBL7Gu/P5eOrricOCJ1s+0WLFuoikZmtPsOlvH3QdPXlyoEa
         BGI1KsMfz2cafGWqk/3xdIJSM03KawqmwBgZ08UqgagEsaVDavv2Wxktslge8GpPZiJx
         Kq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780775709; x=1781380509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+/YOKm1nJb3S5pFoA9PxW/Ts4pIlulHZWc+XmLv3AjQ=;
        b=gdWQajhvZ7oBq1hj3yBQjGConWn5EbbZVinM3ojYRdvB0C3zP94o1xfljC9BL5zQwi
         46aewkjQXbmrFLPV97CfypXDMcB2NeBR34zUNdIphcWeR/USkCzzKRI7E8RHmIQQKOsv
         IQ4GSOPKzPgM5LvJ5m7vRz5hct7N0TipXEPSesSXFCHvWdaGiFR8LgrTu68Uo8IE8iOB
         ndNNEVFqXoh8sZeX2Tl2ei0z7ajwUvaQvV+8a35kVwww7NNSAnaUF7QbLTaopBqohvmG
         DzQfWuQP976IRXtwXYbruBLkS4zSNsMpUQGGKL9AiRocC6yaFnJNxcnKv8glWByGLGBi
         dOuA==
X-Gm-Message-State: AOJu0Yykxh9yuXwqKKQ4DOJzeSvvRnls4pTT6LQ1Zym5u4w6TD7kHeMi
	HIKi/nIgx9I3gmVHsruQI1g/68IMay3B7g7lOL4W/8kWW2+b1o12bD5Wc0tuEQ==
X-Gm-Gg: Acq92OGqI3DF7rbXkjcLn5QPZpAgRJ27XetWIE+VYhbVGOCQa2Oz1CXT4qBP3FJZ7Ql
	ye5WvJXSCeL1UWAq8xIQqPVVccUmeYbFS0/YVB5sK4QL0unm7Ni7cb4JsB9Pz7IfafQgyJ3c0jU
	dkKS7GMhkk9oh8n0YLQaAQpmp6btPEJ29byKyPSlc3HuTHf0lmATnQmgGQHjquGJhUCvCB6yFno
	i8AzJc8TfXmUhMynOZPT+TBm4heAeFPalSfJnfmcwlATsi920A4TKw8Vag7P6fSEDnFTcYOMXf3
	Y9oTbvh/2MDbYwYJEcyzfyq6JJu0AxKUJLW4tzfi7+QNv0RuO8wUTDEQpkzlTt2WAn/VY+/a5Ai
	5MCJ00MSE1hcZ+/RyAYVLpKlH2kTgyyj0v9XxbkVi99K3IIaSPDeUHOIsHwWDrAQyJgMt7VufTq
	8a9Gy/zTBOdPrib17h6lsjsME8d9ML2VcRwa/Ez1AJMaI73wyaxdhIccPMGVt9+3nUgIrlw/Nat
	3MpF3qhnDwKNcJNsJkVEsVV6PfXUEWZUg==
X-Received: by 2002:a05:6300:67c7:b0:3b4:b30e:1b4d with SMTP id adf61e73a8af0-3b4cd04c26cmr12020686637.40.1780775708491;
        Sat, 06 Jun 2026 12:55:08 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04311bsm10943179a12.9.2026.06.06.12.55.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 06 Jun 2026 12:55:07 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 3/3]  layerindex/management/commands/update_git_urls.py
Date: Sat,  6 Jun 2026 12:54:50 -0700
Message-ID: <20260606195450.59191-3-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606195450.59191-1-tim.orling@konsulko.com>
References: <20260606195450.59191-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 06 Jun 2026 19:55:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4168

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
 layerindex/management/__init__.py             |   0
 layerindex/management/commands/__init__.py    |   0
 .../management/commands/update_git_urls.py    | 139 ++++++++++++++++++
 3 files changed, 139 insertions(+)
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
index 0000000..518a548
--- /dev/null
+++ b/layerindex/management/commands/update_git_urls.py
@@ -0,0 +1,139 @@
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


