Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.737.1794707546831794456
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 14 Nov 2026 17:52:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=yeP0kP0K;
 spf=pass (domain: gmail.com, ip: 209.85.210.169, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8b3577deeb0so1092173b3a.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 17:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794707546; x=1795312346; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kAEJ1hj/9mY/nMf+hV08LDr+XZE7wo6QDT6ZVAf9Q5A=;
        b=yeP0kP0KEhbSwlO8mwI/YBYHJHnBekwpx/wEzINaY0P6RB5YJGSqXDzJYgvQg4Bj6Z
         s82cZNjO7ECo0cgfNKEHAnsGI4pjCVRkL0LnUYjv9NaNMrMrYuOem4ZFOOIXPX5KPcUF
         P6tNijDl9ApBsdvpyxC0HI5TCV8Otfn6mZ+moKkiYFjEYOCLnvcfuh/0acblQ/eY3oBs
         3oVCrbihmBT0opwXjJ0zon2utgxxfjq3yw286pwpwojJ1eM0havRCy7pyY423w8mP9sJ
         +wfmZmQlHXuyJKWwck0ac72loRIy4ClVPHUu99aUbzxH0fTeUsVe6sUrk4GE1rLXxVoX
         wFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794707546; x=1795312346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kAEJ1hj/9mY/nMf+hV08LDr+XZE7wo6QDT6ZVAf9Q5A=;
        b=ABHh38MnUf+wspwsWGZDOdX/GZrxNCJDkPGMxyHabSr0XbPjDAAomv4ZkmfTTZYN8D
         NldFzM43z097pI39pof2EssjTM33AiNNRh7RALGQy58J3dSnVbl0vXuSN/WP0Y9J+rh/
         ECh2tNzZZJFKMHkkRn42Ne6b18Vpom+yBAxVHHKn/NNqgMFYjS3VTDPjtYbtJeRRhKjh
         eKK2fYgLYWXX4zDLZWZGybW7LMrn5TYHW/BtICN7TgGZhCBqm29U/H3KAEt1VqaSvXrm
         wJxUvupqCS5p1OFj2iQzAPlGaLLcdRdVmwsTNON7yA/xSOHPA/t7BOKGeHTvSMP24ulI
         odkQ==
X-Gm-Message-State: APuU4Z8MeDvaFi4qKA/VL7X9OXbw8D3dIX28SUgA02T7u80TnR07mY6k
	xrpewGvbU97EUlAmc3MWGhynL+eyBSGl1ZbrTlf/T+BqRc5fhPixDGedRzlbpA==
X-Gm-Gg: AYBFou00CLwMRs9P19ofLdx+66pjRJl4s2lWgymQPcXmb22JuK6ssYnnjF14hMHRvAY
	CWTxyYyE/0lBz9zKAZUodY8NP3/v6q7AK/hTw24BzAMhyJmVdwUbq+ERJt9+SVC33zBMYwB2F0y
	10zK0dya/Ba6qCRqbR8ERTyCpBGCrEVpwK3rSXWHCcIVWLD5aTTQwIDgqB6GW+r9qbrkDttyZQW
	OqJFxp8NdJJ1JtaAWAdWbZXDLEciN3+6iXG6vq6cP20GXJJ0f5p7c1hvukXxJRwLXD0HeGQg1wy
	J5DI1o4CaqRb8fvQeYAt+01TLj+s4pgFtH/Mx5iN52zzvIEaF+J6W0AbPhHh1e5wtIv3TerLu2n
	77SCI4kxJ5N+nOdP8BoMCuhB8XJcfpHIfytv/ActFgfCOKry+rHLXcH0JwTJXv9Ijg/J80o4LtA
	4hcMQY9SQjz6a83fIBOblvi/QJm+5ybI3qw3SGU02Nnsnr5HI0SrYLnndrUsfimy/+oyv+XOII5
	zrrCDEYSlmpqCeiPglg9IhxA5Hp0yrDfbNVoRs1mw4qmV+6KxkIuQxCqp91yV1/uJeUPOs5Yc6B
	j6wuW1Zh9NvgqP24Jd17Tzm/9/LEm+ELihGxHfp5miIPJeO5AVXb3k5kpua9lEaFMunJlKvfGtq
	oLs/xQvQ=
X-Received: by 2002:a05:6a00:1992:b0:888:4f06:903f with SMTP id d2e1a72fcca58-8beb677f17amr6200203b3a.38.1794707546016;
        Sat, 14 Nov 2026 17:52:26 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed20548fbsm2536558b3a.37.2026.11.14.17.52.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 17:52:25 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH v2] rrs_upgrade_history: skip a commit that takes too long to analyse
Date: Sat, 14 Nov 2026 17:52:01 -0800
Message-ID: <20261115015200.64142-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Nov 2026 01:52:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5387
Content-Type: text/plain; charset="utf-8"

A commit that made the parse hang stalled the whole run, and kept the
update lock, until someone killed it. Add an optional timeout to
run_command_interruptible(), which kills the command's whole process
group (in the hangs seen, the stuck process was the BitBake server it
started), and a --commit-timeout option to rrs_upgrade_history.py,
default one hour. A commit that times out is logged and skipped.

[YOCTO #16508]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---

Changes in v2:
- tests: is_running() also treats ProcessLookupError as "not running".
  Reading /proc/<pid>/stat of a process that goes away after open()
  gives ESRCH, not ENOENT, which made
  test_command_that_hangs_is_killed_with_its_children fail about 1 run
  in 15.

This applies on top of the series "Get the RRS update scripts working
again" (patchwork 104071-104076), which also changes
rrs/tools/rrs_upgrade_history.py:
https://lore.kernel.org/all/20261115003506.53654-1-tim.orling@konsulko.com/

v1: https://lore.kernel.org/all/20261115011321.58851-2-tim.orling@konsulko.com/

 layerindex/utils.py               | 42 +++++++++++++++++--
 rrs/tools/rrs_upgrade_history.py  | 11 ++++-
 tests/test_run_command_timeout.py | 69 +++++++++++++++++++++++++++++++
 3 files changed, 118 insertions(+), 4 deletions(-)
 create mode 100644 tests/test_run_command_timeout.py

diff --git a/layerindex/utils.py b/layerindex/utils.py
index fd29de0..1c812bc 100644
--- a/layerindex/utils.py
+++ b/layerindex/utils.py
@@ -18,6 +18,7 @@ import signal
 import errno
 import shutil
 import codecs
+import threading
 import re
 from datetime import datetime
 from bs4 import BeautifulSoup
@@ -512,19 +513,50 @@ def setup_core_layer_sys_path(settings, branchname):
         sys.path.insert(0, os.path.join(core_layerdir, 'lib'))
 
 
-def run_command_interruptible(cmd):
+def run_command_interruptible(cmd, timeout=None):
     """
     Run a command with output displayed on the console, but ensure any Ctrl+C is
     processed only by the child process.
+
+    If timeout is given (in seconds) and the command is still running after
+    it, the command and every process it started are killed and
+    subprocess.TimeoutExpired is raised, with the output so far.
     """
     def reenable_sigint():
         signal.signal(signal.SIGINT, signal.SIG_DFL)
 
-    signal.signal(signal.SIGINT, signal.SIG_IGN)
+    process = None
+    timer = None
+    timed_out = threading.Event()
+
+    def forward_sigint(signum, frame):
+        if process:
+            os.killpg(process.pid, signal.SIGINT)
+
+    def kill_group():
+        # The command's own children (e.g. a BitBake server) may be the ones
+        # that hang, and they keep the output pipe open, so kill them all
+        timed_out.set()
+        for sig, wait in ((signal.SIGTERM, 10), (signal.SIGKILL, 0)):
+            try:
+                os.killpg(process.pid, sig)
+            except ProcessLookupError:
+                return
+            deadline = time.monotonic() + wait
+            while process.poll() is None and time.monotonic() < deadline:
+                time.sleep(0.1)
+
+    # With a timeout the command runs in its own process group so that it
+    # can be killed as a whole; Ctrl+C then reaches only us, so pass it on
+    signal.signal(signal.SIGINT, forward_sigint if timeout else signal.SIG_IGN)
     try:
         process = subprocess.Popen(
-            cmd, cwd=os.path.dirname(sys.argv[0]), shell=True, preexec_fn=reenable_sigint, stdout=subprocess.PIPE, stderr=subprocess.STDOUT
+            cmd, cwd=os.path.dirname(sys.argv[0]), shell=True, preexec_fn=reenable_sigint, start_new_session=bool(timeout), stdout=subprocess.PIPE, stderr=subprocess.STDOUT
         )
+        if timeout:
+            timer = threading.Timer(timeout, kill_group)
+            timer.daemon = True
+            timer.start()
 
         reader = codecs.getreader('utf-8')(process.stdout, errors='surrogateescape')
         buf = ''
@@ -538,7 +570,11 @@ def run_command_interruptible(cmd):
                 break
 
     finally:
+        if timer:
+            timer.cancel()
         signal.signal(signal.SIGINT, signal.SIG_DFL)
+    if timed_out.is_set():
+        raise subprocess.TimeoutExpired(cmd, timeout, output=buf)
     return process.returncode, buf
 
 
diff --git a/rrs/tools/rrs_upgrade_history.py b/rrs/tools/rrs_upgrade_history.py
index 6bf230b..b20ef4e 100755
--- a/rrs/tools/rrs_upgrade_history.py
+++ b/rrs/tools/rrs_upgrade_history.py
@@ -15,6 +15,7 @@
 import sys
 import os.path
 import optparse
+import subprocess
 import logging
 from datetime import date, datetime, timedelta, timezone
 
@@ -92,7 +93,11 @@ def run_internal(maintplanlayerbranch, commit, commitdate, options, logger, bitb
     if options.loglevel == logging.DEBUG:
         cmd += ' --debug'
     logger.debug('Running %s' % cmd)
-    ret, output = utils.run_command_interruptible(cmd)
+    try:
+        ret, output = utils.run_command_interruptible(cmd, timeout=options.commit_timeout or None)
+    except subprocess.TimeoutExpired:
+        logger.error('Analysing commit %s timed out after %d seconds; skipping it' % (commit, options.commit_timeout))
+        return
     if ret == 254:
         # Interrupted by user, break out of loop
         logger.info('Update interrupted, exiting')
@@ -299,6 +304,10 @@ if __name__=="__main__":
             help="Specify maintenance plan to operate on (default is all plans that have updates enabled)",
             action="store", dest="plan", default=None)
 
+    parser.add_option("--commit-timeout",
+            help="Seconds after which analysing one commit is stopped and the commit skipped, 0 for no limit (default %default)",
+            action="store", type="int", dest="commit_timeout", default=3600)
+
     parser.add_option("-F", "--filter-files",
             help="Only operate on a specified subset of files (filepath 'startswith')",
             action="store", dest="filter_files", default='')
diff --git a/tests/test_run_command_timeout.py b/tests/test_run_command_timeout.py
new file mode 100644
index 0000000..204a6b8
--- /dev/null
+++ b/tests/test_run_command_timeout.py
@@ -0,0 +1,69 @@
+# layerindex-web - tests for the timeout in run_command_interruptible()
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+
+import logging
+import os
+import subprocess
+import sys
+import time
+import types
+
+import pytest
+
+sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'rrs', 'tools'))
+
+from layerindex import utils
+
+
+def is_running(pid):
+    # A killed process that nobody has reaped yet is a zombie, not running.
+    # Reading the stat file of a process that goes away after open() gives
+    # ESRCH rather than ENOENT.
+    try:
+        with open('/proc/%d/stat' % pid) as f:
+            return f.read().rsplit(')', 1)[1].split()[0] != 'Z'
+    except (FileNotFoundError, ProcessLookupError):
+        return False
+
+
+@pytest.mark.parametrize('timeout', [None, 30])
+def test_command_that_finishes(timeout):
+    assert utils.run_command_interruptible('echo hello', timeout=timeout) == (0, 'hello\n')
+
+
+def test_command_that_hangs_is_killed_with_its_children():
+    # [YOCTO #16508] the shell's child keeps the output pipe open, like the
+    # BitBake server under upgrade_history_internal.py did, so only killing
+    # the shell would leave this waiting for ever
+    start = time.monotonic()
+    with pytest.raises(subprocess.TimeoutExpired) as e:
+        utils.run_command_interruptible('sleep 60 & echo started $!; wait', timeout=1)
+    assert time.monotonic() - start < 15
+    assert e.value.output.startswith('started ')
+    assert not is_running(int(e.value.output.split()[1]))
+
+
+def test_upgrade_history_skips_a_commit_that_times_out(monkeypatch, caplog):
+    import rrs_upgrade_history
+
+    def hang(cmd, timeout=None):
+        assert timeout == 5
+        raise subprocess.TimeoutExpired(cmd, timeout)
+
+    # The test settings don't install the rrs app; run_internal() only needs
+    # Release for an initial import
+    monkeypatch.setitem(sys.modules, 'rrs.models', types.SimpleNamespace(Release=None))
+    monkeypatch.setattr(utils, 'runcmd', lambda *args, **kwargs: 'abc123')
+    monkeypatch.setattr(utils, 'run_command_interruptible', hang)
+    plan_branch = types.SimpleNamespace(python3_switch_date=rrs_upgrade_history.datetime(2016, 6, 2),
+                                        python3_environment=None,
+                                        layerbranch=types.SimpleNamespace(id=1))
+    options = types.SimpleNamespace(commit_timeout=5, filter_files='', dry_run=False, loglevel=logging.INFO)
+    with caplog.at_level(logging.ERROR):
+        # Returns instead of exiting, so the next commit is analysed
+        rrs_upgrade_history.run_internal(plan_branch, 'deadbeef', rrs_upgrade_history.datetime(2026, 2, 27),
+                                         options, logging.getLogger('test'), {})
+    assert 'deadbeef timed out after 5 seconds' in caplog.text
-- 
2.56.1

