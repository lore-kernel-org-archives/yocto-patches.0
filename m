Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4534.1794623204535245827
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 18:26:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=Ig1s8qaE;
 spf=pass (domain: gmail.com, ip: 209.85.216.48, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b08cf16decso853265a91.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 18:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794623204; x=1795228004; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F5lstnEuvfYsTpRFzgKSL108vqmoOUd4PKLeqnxUOWw=;
        b=Ig1s8qaEli26CffO4WN0fJ2CHj9eq2Ofz5tzPG9WaHas7/4EKJ//iDZ0LX/ynGWRcm
         t3+eatpOCGJr0j2lfULXq8WsdPFK6QVcqghlAKxi+EKk3Jv0s2zS8iG/YIRSscoL/nIW
         3wpLKd4hR4eIfYmJwgk3g743qtqwyCQAlUXFeS8+iVBlj2ZrJiVZaBrN0+tG4SKPmgeq
         2EI93a35FKqhuPOgIA3WOcsPA5Pv6JEWgOqLjpMVoJfS+tygSeeyMCI0Jfkv5ylFV3JT
         De8O61zuH2Jw++TzJ9JvndBwPWnT2IeOCZ4bA2GGl7955rf4DNkbbxWOxLMxeznt0ytK
         Aa2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794623204; x=1795228004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F5lstnEuvfYsTpRFzgKSL108vqmoOUd4PKLeqnxUOWw=;
        b=UqmminUHQVu+/o2NxTvZt3cMOGw+uNjbx9fMnE6t5Kx1cULQ1/oxz0qo6XtsCaqABd
         q/UbzuqmQDsfoyUUWPX/Qcz67oXONt8po/dcVduZishmW/xpYEv7xF16EK0bRcuwO4tx
         nqGdqkk0JYBeZRkSl/+GWdJMK41hau7zmp8JOhvIpObnrlc8o9F6KaU8GHtHK82Ec7/S
         kD+mEkV8v9WKnU6YDCUP6JqejIJd5zwhwUEkTWYYrt9LpIbKb4u2/NYFbqvanZWYUYF0
         YavImD9Tfl/pNbVWbWpn67g1E4Tt2RIp5cn8NuhVetcKQI8KrP0KHu3GwnHgG8hzk1eZ
         3TRg==
X-Gm-Message-State: APuU4Z/EYZ1QsmtOBxXh9Gh3m8zgBkrr0t0jbV4aHwHs5iYmxl4FgYHO
	riaVxlMROMJoOMpAWmTK/ibIH/b1NK5nSIQPN9yCnit3PBtmCNRq5zQRHG7Slw==
X-Gm-Gg: AYBFou1rTwNBP5h05JMOkX19nRsDo6JlbdboRu5U/1fLN0zZqqr5FGfDXleifkk9lkl
	ykv2QKPT3q9I9hWhA4fD463zgJ4tW19J/w0EYKycs8h2aV1Kfa+uGcogzKo6hi2V8ilXqNBumqi
	sPYU+miUTJaW3+bohNkC6w0f1Ud+vfL2aE9HcY73pCwoU/5DFOPJU5mBP/FQ1djwK7Jl2YwwMje
	G5Vs3PwRxQrZbCdsvcVpu7xjmpfTHVnST8kosPp9+UK90tHLcdYILBz8W+LfCTu+FTI/j+lGyIG
	cJiCGJKBYR1uTikQWVPHqfu45hqSzwwqJMvgt1rFiQU3/sRRgC5yisiUetmd4lGwEHWrLlIniy6
	CoSTytcUAAfEcUZMaoWi69X3CbqtJSzhnY8Q6ffyZ2fsy2U/jjH+m923FSo/h2Q36mjmnYyoQNJ
	4/kKazbNR/BY/fcXrcpdE8CYTR2Loc0jqNSOUofmG0+DTxUDAyuA5jRsOg5Xmjr9YV0teBYhgE0
	NC2w246paQIbiyciXG+FODTuXoOCVYvB/TvRKRKpTi9HEgZYryeQ/z96Moiw6aUVhnWEMn90nO+
	9G09FUOESM1GKu6fdDRNS+g4vHTlcl97nszV32O5W+3CozVJrc1jBbpawzdkTtvaNfbsVUoW+vZ
	71/Ll7xc=
X-Received: by 2002:a17:90b:5627:b0:3ab:17b6:9a93 with SMTP id 98e67ed59e1d1-3b1b0ba8ec8mr4452696a91.52.1794623203879;
        Fri, 13 Nov 2026 18:26:43 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec622b6sm7433636a91.11.2026.11.13.18.26.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 18:26:42 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 1/3] update: don't print the initial layer.conf values
Date: Fri, 13 Nov 2026 18:26:35 -0800
Message-ID: <20261114022637.60789-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114022637.60789-1-tim.orling@konsulko.com>
References: <20261114022637.60789-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 02:26:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5357
Content-Type: text/plain; charset="utf-8"

update.py gets BBFILE_COLLECTIONS, LAYERVERSION, LAYERDEPENDS and
LAYERRECOMMENDS for each layer by running update_layer.py --initial,
which printed them, so they appeared on the console and in the update
log of every layer. Have update_layer.py write them to a file that
update.py names instead; errors are still shown as before.

[YOCTO #12130]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/update.py       | 23 +++++++++++++++--------
 layerindex/update_layer.py | 12 +++++++-----
 tests/test_update.py       | 11 +++++++++++
 3 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/layerindex/update.py b/layerindex/update.py
index ca68e3e..ccf44a3 100755
--- a/layerindex/update.py
+++ b/layerindex/update.py
@@ -16,6 +16,8 @@ import optparse
 import codecs
 import logging
 import subprocess
+import shlex
+import tempfile
 from datetime import datetime, timedelta
 from packaging_legacy.version import parse as parse_version
 import utils
@@ -36,7 +38,7 @@ except ImportError:
     sys.exit(1)
 
 
-def prepare_update_layer_command(options, branch, layer, initial=False):
+def prepare_update_layer_command(options, branch, layer, initial=None):
     """Prepare the update_layer.py command line"""
     if branch.update_environment:
         cmdprefix = branch.update_environment.get_command()
@@ -54,7 +56,7 @@ def prepare_update_layer_command(options, branch, layer, initial=False):
     if options.dryrun:
         cmd += ' -n'
     if initial:
-        cmd += ' -i'
+        cmd += ' -i %s' % shlex.quote(initial)
     if options.loglevel == logging.DEBUG:
         cmd += ' -d'
     elif options.loglevel == logging.ERROR:
@@ -448,10 +450,15 @@ def main():
                             logger.error("conf/layer.conf not found for layer %s (branch %s) - is subdirectory set correctly?" % (layer.name, branch))
                             continue
 
-                    cmd = prepare_update_layer_command(options, branchobj, layer, initial=True)
+                    fd, initial_fn = tempfile.mkstemp(prefix='layerindex-initial-')
+                    os.close(fd)
+                    cmd = prepare_update_layer_command(options, branchobj, layer, initial=initial_fn)
                     logger.debug('Running layer update command: %s' % cmd)
                     ret, output = utils.run_command_interruptible(cmd)
                     logger.debug('output: %s' % output)
+                    with open(initial_fn) as f:
+                        initial_values = f.read()
+                    os.remove(initial_fn)
                     if ret == 254:
                         # Interrupted by user, break out of loop
                         logger.info('Update interrupted, exiting')
@@ -470,14 +477,14 @@ def main():
                             layerupdate.save()
                         continue
 
-                    col = extract_value('BBFILE_COLLECTIONS', output)
+                    col = extract_value('BBFILE_COLLECTIONS', initial_values)
                     if not col:
-                        logger.error('Unable to find BBFILE_COLLECTIONS value in initial output')
+                        logger.error('Unable to find BBFILE_COLLECTIONS value in initial values')
                         # Assume (perhaps naively) that it's an error specific to the layer
                         continue
-                    ver = extract_value('LAYERVERSION', output)
-                    deps = extract_value('LAYERDEPENDS', output)
-                    recs = extract_value('LAYERRECOMMENDS', output)
+                    ver = extract_value('LAYERVERSION', initial_values)
+                    deps = extract_value('LAYERDEPENDS', initial_values)
+                    recs = extract_value('LAYERRECOMMENDS', initial_values)
 
                     if not options.nocheckout:
                         # We need to check this out because we're using stuff from bb.utils
diff --git a/layerindex/update_layer.py b/layerindex/update_layer.py
index 0f49371..c11c002 100644
--- a/layerindex/update_layer.py
+++ b/layerindex/update_layer.py
@@ -290,8 +290,8 @@ def main():
             help = "Stop on first parsing error",
             action="store_true", default=False, dest="stop_on_error")
     parser.add_option("-i", "--initial",
-            help = "Print initial values parsed from layer.conf only",
-            action="store_true")
+            help = "Write the initial values parsed from layer.conf to FILE, and do nothing else",
+            action="store", metavar="FILE")
     parser.add_option("-a", "--actual-branch",
             help = "Specify actual_branch for git checkout",
             action="store", dest="actual_branch", default=None)
@@ -454,9 +454,11 @@ def main():
                     sys.exit(1)
                 utils.set_layerbranch_collection_version(layerbranch, layer_config_data, logger=logger)
                 if options.initial:
-                    # Use print() rather than logger.info() since "-q" makes it print nothing.
-                    for i in ["BBFILE_COLLECTIONS", "LAYERVERSION", "LAYERDEPENDS", "LAYERRECOMMENDS"]:
-                        print('%s = "%s"' % (i, utils.get_layer_var(layer_config_data, i, logger)))
+                    # Write these to a file rather than the output, which is
+                    # shown on the console and in the update log
+                    with open(options.initial, 'w') as f:
+                        for i in ["BBFILE_COLLECTIONS", "LAYERVERSION", "LAYERDEPENDS", "LAYERRECOMMENDS"]:
+                            f.write('%s = "%s"\n' % (i, utils.get_layer_var(layer_config_data, i, logger)))
                     sys.exit(0)
 
                 # Set up for recording patch info
diff --git a/tests/test_update.py b/tests/test_update.py
index a0ac897..1e1db0d 100644
--- a/tests/test_update.py
+++ b/tests/test_update.py
@@ -163,6 +163,17 @@ def test_add_recipe(import_layer, repo, db_access_without_rollback_and_truncate)
     assert recipe.summary == "Brand new recipe"
     assert recipe.license == "MIT"
 
+def test_initial_values_not_in_output(import_layer):
+    # [YOCTO #12130] update.py gets the values it needs from the first parse
+    # of conf/layer.conf through a file, not from the output it shows
+    result = subprocess.run("layerindex/update.py -r -n -l meta-layerindex-test --nofetch --nocheckout",
+                            shell=True, cwd=basepath, stdout=subprocess.PIPE,
+                            stderr=subprocess.STDOUT, text=True)
+    assert result.returncode == 0, result.stdout
+    assert 'BBFILE_COLLECTIONS = ' not in result.stdout
+    assert 'Unable to find BBFILE_COLLECTIONS' not in result.stdout
+
+
 
 
 # FIXME test recipe modify
-- 
2.56.0

