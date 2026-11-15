Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11418.1794764600550772932
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Nov 2026 09:43:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=iaVxN4Sk;
 spf=pass (domain: gmail.com, ip: 209.85.216.45, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso1374742a91.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Nov 2026 09:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794764600; x=1795369400; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gVRrB88cvGk4Len6RbzIDhXrGjZYPj/Bubd8QgEEIeg=;
        b=iaVxN4SklQ9KH5jE9l4TkEdtK8x2VxplxL8iK9upjTetSqidkjp5Y3z4KrhIvPiyH0
         4p8k3Mow3qdi9no+LuhtsDGBUxQipWdNWb9qL3g5q3vgOO7YwiiPOlL/lzvGiiEkfXhA
         uYD8fGsR+b2UBlx5AfyWApwlQVPQWcaH3bbSMNkIitlBPhL9fWvTyzAl6llQM3Ru7HkT
         6r5PaZQ9V8moG0gqCP5a8ThlEjm7WTmLMKhJl/d/iIRIyXFrI6E9rgnPzhZ/i9jpRMAf
         /3CzusSMA4gkMq+U557CVSGDzru6bw6Vgs21MrkRb7kQaCj+CHSgcYLkuY/Py22vIY60
         mz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794764600; x=1795369400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gVRrB88cvGk4Len6RbzIDhXrGjZYPj/Bubd8QgEEIeg=;
        b=h2zOyJL6B94B0yP8EwO8siIOvDoTYDXxIMgOyCqACYuIS8Q0rZ92UJvQnxK7JMKQvD
         9spiAWfiqrshrm2HY2Vht1exxr5+/EBSbwO9uBcxnth2C1Mse5s8Vyy1MBxS1FDpo2cp
         /Kfcj+t8Ur9wJOrF1hUxRR3cN4TsfraVpK8aZk21AsBeuN+X2BjfuKFit4jKYklH1Yih
         Hb1fTlj5ZDtl8cAExqp8bFyPS6xwCepXFLe6Hc1Q8Cf9gAGOiBIRLtObXChICB+JqiD+
         xknmXQSJcsau/tRbTj9NmwSwc4OxCxN+rSIPGVm+stKEiLNsaUzILfP4kD5bE+ggC8Y1
         9Kyw==
X-Gm-Message-State: APuU4Z9QOB3N57lmgJSvHm5h8ALaW8AGxQ2nRjtZePVmYBq0YdAWqlfr
	SJ5yMhMlv9gc5IduN0rTV6pYgNOIYaYd+JHN5XkMXcRp3WR0cNyFXhpxwGRuuA==
X-Gm-Gg: AYBFou14OVChHOMpWS1Icr9Zrses/qSnN4gMmcoGCk/soNAqRTFQY+isDUbJokQyfRa
	Jpae2YzyXNy1peTA2TyJ6eOmC5VznMbUAh7eB9wBlALbdvIZ2pIABywqZVw54e1YIpbfD0wQnCg
	pdnI8uCgDzmSzSzeGI+xngm3rbQRMDela4CXXIYuOo/vVQjermp/JO9vne9PyI4Xp0c2EenL8pI
	2K5lE5V8AAyyWHYGw2Pbd/tSYVKC4/OsHxqTMkiVHIHNdsqLUOhQ5yH+r3cRQe8f/hJeUmwpYbf
	sPslM4cREaeK5o/IdgvZz46q6i+VlzU9PTAClw/lzBE7cwUNXubbq3cSRcCPQx1EJeEKeZ77Q9k
	qpu+Ep9rB+adFXAuVJyx41p5gGkq9N0xPiGZXtnBncqriBS/j+aLGUNTBUGi0Z7dfckVwXfvgnU
	BypRLWkmIBXyLRlHshceAV0CEkPBvIEKt9zoMm1izuRTAfN2VvahNXRSFYS9f8fgAtA/GNzzIFU
	zrB5n0XDTpvO2bH36ZL3Fyktdz2LHmeHKwfGcvp48rFs9ZDQVOfI+mWMjWxPwFpWaGdFJ5bqCfy
	8xnV7+EfooAhfk+alH+kqUKqOMwqmrEMghX45mpqympdRn/sSvg/B3u9
X-Received: by 2002:a17:90b:5110:b0:3ab:1b1c:8a70 with SMTP id 98e67ed59e1d1-3b1b0b68e6cmr7932205a91.38.1794764599743;
        Sun, 15 Nov 2026 09:43:19 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197ce556dsm18369342a91.6.2026.11.15.09.43.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Nov 2026 09:43:18 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH] rrs_upgrade_history: don't save a failed commit as the checkpoint
Date: Sun, 15 Nov 2026 09:42:44 -0800
Message-ID: <20261115174243.10055-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Nov 2026 17:43:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5393
Content-Type: text/plain; charset="utf-8"

A commit whose analysis failed was still saved as the layer branch's
checkpoint, so it was never analysed again. On a test instance a
container that ran out of processes failed every commit for two hours
and moved three checkpoints to the latest commit. Stop the layer branch
at a failed commit instead, so the next run retries it, and exit with
status 1. A commit that times out is still skipped.

[YOCTO #16515]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
This applies on top of "rrs_upgrade_history: skip a commit that takes too
long to analyse" (v2), which is on master-next.

Tested on a test instance: run in a container without --init and with
--pids-limit 80, the analysis started failing after about 70 commits;
each layer branch stopped at its first failed commit, kept the last good
one as its checkpoint, and the script exited 1.

 rrs/tools/rrs_upgrade_history.py  | 22 ++++++++++++++---
 tests/test_rrs_upgrade_history.py | 40 +++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/rrs/tools/rrs_upgrade_history.py b/rrs/tools/rrs_upgrade_history.py
index b20ef4e..fff98d2 100755
--- a/rrs/tools/rrs_upgrade_history.py
+++ b/rrs/tools/rrs_upgrade_history.py
@@ -97,11 +97,17 @@ def run_internal(maintplanlayerbranch, commit, commitdate, options, logger, bitb
         ret, output = utils.run_command_interruptible(cmd, timeout=options.commit_timeout or None)
     except subprocess.TimeoutExpired:
         logger.error('Analysing commit %s timed out after %d seconds; skipping it' % (commit, options.commit_timeout))
-        return
+        return True
     if ret == 254:
         # Interrupted by user, break out of loop
         logger.info('Update interrupted, exiting')
         sys.exit(254)
+    if ret:
+        # The caller then doesn't save this commit as the checkpoint, so the
+        # next run tries it again (AI-generated, Claude Opus 5.5)
+        logger.error('Analysing commit %s failed with exit code %d' % (commit, ret))
+        return False
+    return True
 
 """
     Upgrade history handler.
@@ -137,6 +143,7 @@ def upgrade_history(options, logger):
     if not lockfile:
         logger.error("Layer index lock timeout expired")
         sys.exit(1)
+    failed = False
     try:
         for maintplan in maintplans:
             # Check releases and milestones
@@ -221,7 +228,10 @@ def upgrade_history(options, logger):
 
                     ct, ctepoch = commit_list.pop(0).split()
                     ctdate = datetime.fromtimestamp(int(ctepoch))
-                    run_internal(maintplanbranch, ct, ctdate, options, logger, bitbake_map, initial=True)
+                    if not run_internal(maintplanbranch, ct, ctdate, options, logger, bitbake_map, initial=True):
+                        logger.error('%s: initial import failed, skipping this layer branch' % layerbranch)
+                        failed = True
+                        continue
 
                 if layerbranch.vcs_subdir:
                     layersubdir_start = layerbranch.vcs_subdir
@@ -263,13 +273,19 @@ def upgrade_history(options, logger):
                             logger.debug("Skipping commit %s" % ct)
                             continue
                         logger.debug("Analysing commit %s ..." % ct)
-                        run_internal(maintplanbranch, ct, ctdate, options, logger, bitbake_map)
+                        if not run_internal(maintplanbranch, ct, ctdate, options, logger, bitbake_map):
+                            # Stop here so the next run starts again from this commit
+                            logger.error('%s: stopping at commit %s' % (layerbranch, ct))
+                            failed = True
+                            break
                         if not (options.dry_run or options.filter_files):
                             maintplanbranch.upgrade_rev = ct
                             maintplanbranch.upgrade_date = ctdate
                             maintplanbranch.save()
     finally:
         utils.unlock_file(lockfile)
+    if failed:
+        sys.exit(1)
 
 if __name__=="__main__":
     parser = optparse.OptionParser(usage = """%prog [options]""")
diff --git a/tests/test_rrs_upgrade_history.py b/tests/test_rrs_upgrade_history.py
index 6bf3582..7788c33 100644
--- a/tests/test_rrs_upgrade_history.py
+++ b/tests/test_rrs_upgrade_history.py
@@ -41,3 +41,43 @@ def test_bitbake_revision_without_limit():
     log = logging.getLogger('test')
     assert remapped_bitbake_rev('a', datetime(2030, 1, 1), {'a': ('b', None)}, log) == 'b'
     assert remapped_bitbake_rev('c', datetime(2030, 1, 1), {'a': ('b', None)}, log) == 'c'
+
+
+def run_internal_with(monkeypatch, result):
+    import subprocess
+    import types
+    from layerindex import utils
+    import rrs_upgrade_history
+
+    def run(cmd, timeout=None):
+        if isinstance(result, Exception):
+            raise result
+        return result, ''
+
+    # The test settings don't install the rrs app; run_internal() only needs
+    # Release for an initial import
+    monkeypatch.setitem(sys.modules, 'rrs.models', types.SimpleNamespace(Release=None))
+    monkeypatch.setattr(utils, 'runcmd', lambda *args, **kwargs: 'abc123')
+    monkeypatch.setattr(utils, 'run_command_interruptible', run)
+    plan_branch = types.SimpleNamespace(python3_switch_date=datetime(2016, 6, 2),
+                                        python3_environment=None,
+                                        layerbranch=types.SimpleNamespace(id=1))
+    options = types.SimpleNamespace(commit_timeout=5, filter_files='', dry_run=False, loglevel=logging.INFO)
+    return rrs_upgrade_history.run_internal(plan_branch, 'deadbeef', datetime(2026, 2, 27),
+                                            options, logging.getLogger('test'), {})
+
+
+def test_run_internal_success(monkeypatch):
+    assert run_internal_with(monkeypatch, 0) is True
+
+
+def test_run_internal_failure(monkeypatch, caplog):
+    # [YOCTO #16515] a failed commit must not be saved as the checkpoint
+    with caplog.at_level(logging.ERROR):
+        assert run_internal_with(monkeypatch, 1) is False
+    assert 'deadbeef failed with exit code 1' in caplog.text
+
+
+def test_run_internal_timeout_is_skipped(monkeypatch):
+    import subprocess
+    assert run_internal_with(monkeypatch, subprocess.TimeoutExpired('cmd', 5)) is True
-- 
2.56.1

