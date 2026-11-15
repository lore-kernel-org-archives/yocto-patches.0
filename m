Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7558.1794702930682029185
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 14 Nov 2026 16:35:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=erVy9lRf;
 spf=pass (domain: gmail.com, ip: 209.85.215.180, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cdab938dc83so1089449a12.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 16:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794702930; x=1795307730; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EJnI+aNKMFlsVqR1hCwKw1ABy0I+ha6c8y5pPwE561A=;
        b=erVy9lRfoFQG1De/4ny3ROsRXwdQgFJJZt8dM7NqELkBZfzcC+178e2GRfCgDX95Wb
         uBNvADhpaOaLfsDbhDAZiS6GCoXv2Sa63WD/I7Ci8ITkHX/ztusqbnmfkcQQf19xU91t
         qV7jIJX38HO4PBFWzmHPbEpQwkhm/I8sWP8jyZVBYxka8Sn4hUJcLkijVmMKUShDri9s
         T5TrYGeZny95+B0W+jUZ9N6bJ2y75XO0K5D/DFqqBPDnAKm4slRi+v3xcGrTQSeAISvm
         8vZLRIJf7jaVhivoqCjN+SN5o9+dDFOK871hY7/agPJMvYTME5f9eoQLFBNtKIAffceQ
         1LHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794702930; x=1795307730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EJnI+aNKMFlsVqR1hCwKw1ABy0I+ha6c8y5pPwE561A=;
        b=tM2G6UuZncJ/66kZsF1CtbZouRRhnaEQtdvv5bX3pG+HUZrU7eGFhjQbBlh2q+U2tH
         tHfg6ERA7Iwb4sxoRY6+ddFVqRTDY9+eRvv6vpJon498YNghzFuP6n8cRH2mr3DP6GAo
         fPot1H4himqVN4TjiOsoU59XXzD29qqrxZSY96SSfUVlsoGh891uqy7zCnTF1HUMCRSf
         Vb9+etNr9OnxNvPYF4ReCrvJix0LEjr5uwdH0ZLkM8WmpzMSHv+Vvgt0696uGstV9b2N
         oAFbsrIjcHtRO1IzxvRnh3YznJDXZ//D0EjOtbWUSBSTqyIWYAuzIWZeAIhIJq/7xzej
         z1pA==
X-Gm-Message-State: APuU4Z+fOAPaE/aeXmi1W+r1it2rnMzhz5/DXsHojQFJfufP5gK7+/jF
	lBaQzU+uix4oJNEmT+Z0bTb24+XEvkjZB8cZ7mO37XtX7mG/PTxQ1J66W4c2Eg==
X-Gm-Gg: AYBFou2FElQaJsDKkdgegs8UX9F9MYfAzl/SE45Xf3uT/+rwQ7udzylWcMh0lzvmkaj
	pm9BvFFgdftfi1/q+fedaeCsVIhXJI4+WmDP3vjwYyPh3zXcgvd75seLhMW5FMWpJgwW8/x+sI0
	YtJy4p3IL14VQS/D9vzECHWqHWfcxy34AeOqfXkf8yFm7RQzIdq17mJyET9FWhh0r9px9eTsMjg
	qvNzZP7IWsCIOA7zQTB6JYxk7RYG7e5vAtrG7FKINRsVNJrxfm3iy5KA6wVVh5KIMBsWzBsNvj8
	xirxglP2TtTy2kqet0mqjY7Ej5Ton39RIMFEdHAAt+JD+bwumybX8I98JBdrfwLenaB/ax/gW9N
	rL+wm99/YT/75HH62r2w2lRE3JrY8idKfCXuYijd8BUdKtqje6CLXLy1uusEJE3wgWbzLtahBW5
	BEZQNkSJioBh9EXwXUT2WqVixtdRwrsXXFVYXWdCkJKk7VPc9WSZKvWdZVKwG3O+3Rzhh6nZ7wf
	J+dZ5ijMWdo7fjirceTkKo1I5HUh1OntHIqAmHjFJ2aQvtEKfvKnpDYY8D3NWcw9OAryZy9SMe+
	T3oMGp0AxZXzEEeguotiMJcqNfGWHF9jzX9e9V7JRpmspVZPlc+489hFJM8Gfw==
X-Received: by 2002:a17:90a:c88b:b0:3ac:8741:e2e4 with SMTP id 98e67ed59e1d1-3b1b0a4e341mr6527182a91.52.1794702929885;
        Sat, 14 Nov 2026 16:35:29 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b39fb9a3sm5464089a91.3.2026.11.14.16.35.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 16:35:27 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 3/6] rrs_upgrade_history: use the right BitBake around the 2025 fragments change
Date: Sat, 14 Nov 2026 16:35:03 -0800
Message-ID: <20261115003506.53654-4-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261115003506.53654-1-tim.orling@konsulko.com>
References: <20261115003506.53654-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Nov 2026 00:35:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5381
Content-Type: text/plain; charset="utf-8"

BitBake 3b9d7bea9 ("parse/ast: add support for 'built-in' fragments",
2025-06-18) changed the addfragments syntax, which OE-Core only
followed in e959f916b4 (2025-06-20). The OE-Core commits in between got
that BitBake, could not be parsed with it, and the BitBake server then
waited for ever, so the upgrade history never got past them.

Use the BitBake revision before the change for those commits. The
table of BitBake ranges to replace only matched on the BitBake
revision, so let an entry apply only to commits before a given date,
since OE-Core commits from e959f916b4 on need the new revision.

[YOCTO #16500]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 rrs/tools/rrs_upgrade_history.py  | 32 ++++++++++++++++++-----
 tests/test_rrs_upgrade_history.py | 43 +++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 7 deletions(-)
 create mode 100644 tests/test_rrs_upgrade_history.py

diff --git a/rrs/tools/rrs_upgrade_history.py b/rrs/tools/rrs_upgrade_history.py
index 6326914..6bf230b 100755
--- a/rrs/tools/rrs_upgrade_history.py
+++ b/rrs/tools/rrs_upgrade_history.py
@@ -16,7 +16,7 @@ import sys
 import os.path
 import optparse
 import logging
-from datetime import date, datetime, timedelta
+from datetime import date, datetime, timedelta, timezone
 
 sys.path.insert(0, os.path.realpath(os.path.join(os.path.dirname(__file__))))
 from common import common_setup, get_logger
@@ -42,6 +42,16 @@ bitbakepath = os.path.join(fetchdir, bitbakeitem.get_fetch_dir())
 if getattr(settings, 'BITBAKE_PATH', ''):
     bitbakepath = os.path.join(bitbakepath, settings.BITBAKE_PATH)
 
+def remapped_bitbake_rev(bitbake_rev, commitdate, bitbake_map, logger):
+    """The bitbake revision to use for a layer commit made at commitdate
+    (local time), given the latest bitbake revision before it"""
+    check_rev, until = bitbake_map.get(bitbake_rev, (None, None))
+    # until is timezone-aware, so compare as timestamps
+    if check_rev and (until is None or commitdate.timestamp() < until.timestamp()):
+        logger.debug('Preferring bitbake revision %s over %s' % (check_rev, bitbake_rev))
+        return check_rev
+    return bitbake_rev
+
 def run_internal(maintplanlayerbranch, commit, commitdate, options, logger, bitbake_map, initial=False):
     from layerindex.models import PythonEnvironment
     from rrs.models import Release
@@ -63,10 +73,7 @@ def run_internal(maintplanlayerbranch, commit, commitdate, options, logger, bitb
 
     bitbake_rev = utils.runcmd(['git', 'rev-list', '-1', '--before=%s' % str(commitdate), 'origin/master'],
                     bitbakepath, logger=logger)
-    check_rev = bitbake_map.get(bitbake_rev, None)
-    if check_rev:
-        logger.debug('Preferring bitbake revision %s over %s' % (check_rev, bitbake_rev))
-        bitbake_rev = check_rev
+    bitbake_rev = remapped_bitbake_rev(bitbake_rev, commitdate, bitbake_map, logger)
 
     cmd = '%s upgrade_history_internal.py %s %s' % (cmdprefix, maintplanlayerbranch.layerbranch.id, commit)
     if initial:
@@ -174,7 +181,10 @@ def upgrade_history(options, logger):
                 commit_list = commits.split('\n')
 
                 bitbake_map = {}
-                def remap_range(start, end, replacewith=None):
+                def remap_range(start, end, replacewith=None, until=None):
+                    """Use replacewith (by default end) instead of the
+                    bitbake revisions from start up to end, for layer
+                    commits before until (all if None)"""
                     if replacewith is None:
                         replacewith = end
                     bitbake_commits = utils.runcmd(['git', 'rev-list', '%s^..%s^' % (start, end)],
@@ -182,12 +192,20 @@ def upgrade_history(options, logger):
                                         logger=logger)
                     bitbake_commit_list = bitbake_commits.splitlines()
                     for commit in bitbake_commit_list:
-                        bitbake_map[commit] = replacewith
+                        bitbake_map[commit] = (replacewith, until)
 
                 # Filter out some bad commits
                 remap_range('fef18b445c0cb6b266cd939b9c78d7cbce38663f', '39780b1ccbd76579db0fc6fb9369c848a3bafa9d')
                 remap_range('5796ed550d127853808f38257f8dcc8c1cf59342', '547128731e62b36d2271c4390b3fee2b16c535dc')
                 remap_range('a06619951a43acb80b80d92e0caac560657ca249', '2117db3146ce38bb4a6e2df40b6cd2ab11b514d5')
+                # "parse/ast: add support for 'built-in' fragments" changed the
+                # addfragments syntax, which OE-Core only followed in
+                # e959f916b4 "bitbake.conf: enable built-in fragments for MACHINE
+                # and DISTRO" (2025-06-20 11:03:34 UTC); before that use the
+                # bitbake revision before the change
+                remap_range('3b9d7bea915dc7f10e845854f1dae325743f9456', 'f1175778108a559e1dd0d55cb68f42816c86f393',
+                            replacewith='378db0fdd95f8704fccd852452555bfddcad384d',
+                            until=datetime(2025, 6, 20, 11, 3, 34, tzinfo=timezone.utc))
 
                 if options.stop_commit and (options.stop_commit not in [x.split()[0] for x in commit_list]):
                     logger.error('Stop commit %s is not in repository %s' % (options.stop_commit, repodir))
diff --git a/tests/test_rrs_upgrade_history.py b/tests/test_rrs_upgrade_history.py
new file mode 100644
index 0000000..6bf3582
--- /dev/null
+++ b/tests/test_rrs_upgrade_history.py
@@ -0,0 +1,43 @@
+# layerindex-web - tests for the BitBake revision rrs_upgrade_history.py uses
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+
+import logging
+import os
+import sys
+from datetime import datetime, timezone
+
+import pytest
+
+sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'rrs', 'tools'))
+
+NEW = '3b9d7bea915dc7f10e845854f1dae325743f9456'   # changed the addfragments syntax
+OLD = '378db0fdd95f8704fccd852452555bfddcad384d'   # the revision before it
+SWITCH = datetime(2025, 6, 20, 11, 3, 34, tzinfo=timezone.utc)
+
+
+def local(dt):
+    # The script works with naive local times (datetime.fromtimestamp())
+    return datetime.fromtimestamp(dt.timestamp())
+
+
+@pytest.mark.parametrize('commitdate, expected', [
+    # [YOCTO #16500] OE-Core commits before it switched need the old revision
+    (local(datetime(2025, 6, 19, 10, 5, 42, tzinfo=timezone.utc)), OLD),
+    # ... and those from the switch on need the new one
+    (local(SWITCH), NEW),
+    (local(datetime(2025, 6, 21, 9, 0, 0, tzinfo=timezone.utc)), NEW),
+])
+def test_bitbake_revision_for_commit(commitdate, expected):
+    from rrs_upgrade_history import remapped_bitbake_rev
+    bitbake_map = {NEW: (OLD, SWITCH)}
+    assert remapped_bitbake_rev(NEW, commitdate, bitbake_map, logging.getLogger('test')) == expected
+
+
+def test_bitbake_revision_without_limit():
+    from rrs_upgrade_history import remapped_bitbake_rev
+    log = logging.getLogger('test')
+    assert remapped_bitbake_rev('a', datetime(2030, 1, 1), {'a': ('b', None)}, log) == 'b'
+    assert remapped_bitbake_rev('c', datetime(2030, 1, 1), {'a': ('b', None)}, log) == 'c'
-- 
2.56.1

