Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FB5CCF2C7
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 01:46:56 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7826.1792288013472378239
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 18:46:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=cswkRFFL;
 spf=pass (domain: gmail.com, ip: 209.85.214.171, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e9ae391a05so5458015ad.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 18:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792288013; x=1792892813; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NW3RIhbnXW7SLXrcJiKOnmH5XQGzdcPXNW3PuAb0Jqo=;
        b=cswkRFFLNI3wEEg6sA7xBe9Et5ymoHv72HJSMCHXhAWptS4bgyhQdq+suGbauiHkBK
         Tou2P/tn8JOnBTxRky/M12xgpABb+v5lheJI0ns80V5bM/lZdvqgVuU72GMwZrTTz4h8
         DvOJoa7DYbB796Lc8+jK19wG9sfhJIOp5ceDBdytEua25d1gYH/c5mTrGfwLL+08pJQq
         nXKEMukdFfB8DvwWdCSrDAMpYnjKE1gj46ZxOah8DmWxtGK9zkfOQ2jef2ZNKH75yjAv
         sFwAyGdLseSssc+n2xYkibwalOmkYI4iTAFB2xs+Q0MOMkv8vdKLvDz8wdC5NY9Dth1R
         SDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792288013; x=1792892813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NW3RIhbnXW7SLXrcJiKOnmH5XQGzdcPXNW3PuAb0Jqo=;
        b=gDFlFYwt8mZC0Usy75mcWSV3uebj8yd7+0ANuBamJDlYrzEqTS5B/Fd88FqdSygHBE
         CgqhFJHH0OQNdf20G+y1700FJH6QHBKTPZi9jcHZ2GSYh6rFQYvwurPYuPJHDTlIMrg0
         9OGUZLoQNo1/WAlhzooUIRKJAyqahpN92AXH3jH6G2I/82Rd5lT9+GQuz5XDe1ocn3O5
         L+H17orpRPX+OHb078cNziCbL8ahKrumBbc7jRfx8u38Ik87Lnkemo8Le+PN8+UPpYbx
         5MODpmEogK4rawFQbgEr+zSlXmrU+7a6b6jenLqanMQhUtspXECMjEdFreipPrNmsX0d
         vqKw==
X-Gm-Message-State: AFq9FYK22jsMlOBCgsCTPcOfcYjU6PvtfloedFNkemXFbsoCWlQnVHZn
	gscBZ5q7+vFBjYxOcTpMgpUlCqWRqawJDiOnBrQ36WFzFT/IEv+Hhr12hWeaZQ==
X-Gm-Gg: AYBFou10fnl7gchF+uDKXDLs7L/35wcCrjOMK6RwyJdWDIUrtU77i+GXQnBqFg2fdU8
	8CS9W079rrPbGVhomkLuEsUysYGNe+URFnxE0hB/eNm4mXcI8CjAeu9uBDMhE1GfVuieLWQgyFQ
	TqsApiwzQ2F2C7Y0RH/J8oeSyBebgkprtehJkKOi5Ict8/XWFl/Q8UggA+rdLg+4AoJXakIQOc3
	x5oRE+aJhlPxFRjafyHA93ak6Me5bbvW1JBKp7A7e+AUncQPua+pFKAZP6tWc9czpN9d6YlI7MU
	PrGyngsqfAENSBdAGZZxSLdlOojwFuzLK+ep2uh37WjRwEDu82SpkK7nml5Ac67ueIdOC7efmbq
	cPW4TvyKMLXoxpUFWxOs4EXSdHhz9nDvyAiW+1RrovVIzzCqBstQD4vd8lhLOS9HrF5IVnIFHBA
	HJSj/THwTq+GNbg1NT4LJGET0DGaeE2Zg3RPSrNCpC2IXDjjlRnuHaiQohw6Jn9Vv14ICuZcjlY
	l57K8anGJh6I0WUTeXwkJkMUYE3GR0=
X-Received: by 2002:a17:903:32c2:b0:2e8:5431:d18c with SMTP id d9443c01a7336-2e9a6e43863mr27050885ad.40.1792288012825;
        Sat, 17 Oct 2026 18:46:52 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e87836bsm25935655ad.47.2026.10.17.18.46.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 18:46:52 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [error-report-web][PATCH 4/5] Port culldb and purge.py to Python 3.
Date: Sat, 17 Oct 2026 18:44:02 -0700
Message-ID: <20261018014510.72203-9-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018014510.72203-1-tim.orling@konsulko.com>
References: <20261018014510.72203-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 01:46:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5048

Both used Python 2 print and failed with SyntaxError. culldb also used
option_list and optparse, removed in Django 1.10; declare the same
arguments with add_arguments(). Add culldb tests. Found by ruff.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 Post/management/commands/culldb.py | 36 +++++++++++++-----------------
 Post/purge.py                      |  2 +-
 Post/test.py                       | 21 +++++++++++++++++
 3 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/Post/management/commands/culldb.py b/Post/management/commands/culldb.py
index bd70ffc..46c586d 100644
--- a/Post/management/commands/culldb.py
+++ b/Post/management/commands/culldb.py
@@ -9,44 +9,38 @@
 # Create your views here.
 # vi: tabstop=8 expandtab shiftwidth=4 softtabstop=4
 
-from django.core.management.base import BaseCommand, CommandError
-from Post.models import Build, BuildFailure
-from optparse import make_option
+from django.core.management.base import BaseCommand
+from Post.models import Build
 import time
 import sys
 
 class Command(BaseCommand):
     help = 'Culls the database to size in rows'
-    args = '<size>'
-    option_list = BaseCommand.option_list + (
-        make_option('-i',
-                    '--info',
-                    dest='info',
-                    action="store_true",
-                    help='Show the current database size'),
-    )
+
+    def add_arguments(self, parser):
+        parser.add_argument('size', nargs='?', type=int,
+                            help='Number of builds to keep')
+        parser.add_argument('-i',
+                            '--info',
+                            action="store_true",
+                            help='Show the current database size')
 
     def handle(self, *args, **options):
         count = Build.objects.count()
 
         if options['info']:
-            print "Current builds table size: %d" % Build.objects.count()
+            print("Current builds table size: %d" % Build.objects.count())
             return
 
-        if len(args) > 0 and args[0]:
-            try:
-                new_size = int(args[0])
-            except ValueError:
-                print "Not a valid size"
-                return
-
+        if options['size'] is not None:
+            new_size = options['size']
 
             num_to_delete = count - new_size
-            print "\nReducing the database size to %d which will DELETE %d rows" % (new_size, num_to_delete)
+            print("\nReducing the database size to %d which will DELETE %d rows" % (new_size, num_to_delete))
             i = 1
             while i != 0:
                 i = i-1
-                print 'Ctrl+c TO CANCEL. Executing in... %d \r' % i,
+                print('Ctrl+c TO CANCEL. Executing in... %d \r' % i, end='')
                 sys.stdout.flush()
                 time.sleep(1)
 
diff --git a/Post/purge.py b/Post/purge.py
index dd58441..f4989fb 100644
--- a/Post/purge.py
+++ b/Post/purge.py
@@ -20,7 +20,7 @@ def main():
     #print query
     items = BuildFailure.objects.raw(query)
     for item in items:
-        print "Deleting: ", item.id
+        print("Deleting: ", item.id)
         item.delete()
 
 if __name__ == "__main__":
diff --git a/Post/test.py b/Post/test.py
index 734b99c..9527a9f 100755
--- a/Post/test.py
+++ b/Post/test.py
@@ -1,5 +1,7 @@
 import urllib.request, urllib.parse, urllib.error
 import json
+from unittest.mock import patch
+from django.core.management import call_command
 import re
 from django.test import Client, TestCase, override_settings
 from Post.models import BuildFailure, Build
@@ -385,3 +387,22 @@ class LinkBackSubmissionTest(TestCase):
         bf = self._submit("http://example.com/build/42")
         self.assertEqual(bf.BUILD.LINK_BACK, "http://example.com/build/42")
 
+
+
+@patch("Post.management.commands.culldb.time.sleep")
+class CullDbTest(TestCase):
+    def setUp(self):
+        for _ in range(3):
+            Build.objects.create()
+
+    def test_culls_to_size(self, _sleep):
+        call_command("culldb", "1")
+        self.assertEqual(Build.objects.count(), 1)
+
+    def test_zero_culls_everything(self, _sleep):
+        call_command("culldb", "0")
+        self.assertEqual(Build.objects.count(), 0)
+
+    def test_info_deletes_nothing(self, _sleep):
+        call_command("culldb", "--info")
+        self.assertEqual(Build.objects.count(), 3)
-- 
2.56.0


