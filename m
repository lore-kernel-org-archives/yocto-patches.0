Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89D6CCF2D4
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 23:06:54 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23456.1792364805578479818
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 18 Oct 2026 16:06:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=UvZI3L8F;
 spf=pass (domain: gmail.com, ip: 209.85.216.42, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so1450439a91.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 16:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792364805; x=1792969605; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rw74kOm/r/i3AhK/ISX8MlGZQQoMSXKN7Q+g2czWsSE=;
        b=UvZI3L8FcUAPQqW4x1xRHX5+w9bZPYF+qsvoJfxafaTO1Wud4ecKsiAOcquk8kG8rf
         dtESiD6GPy4tkZXkDk0QB9Rqo1xstbLz2UFbXAwoIkz4Pd8iZbyg9HfG9+dDMqVwUIgq
         TNvPEitGmk4xoW1DPyQPYrMtxTTFxhkV+tZfLHH8qFpUY39LGqvuLhNR6V7VmtNtOfwg
         uhgXQSOyDVB6EDF0wgFwJ6Ygiq51i/14oMLrlk+hVdHZC/B89dW7m7ST0IOYLhgDj0aL
         Enb3u33gynoS5Z5cSf1aDyZ7hCcpB7318zjCY3sNRWuC8M9AMtuS/3Rd1juZSbQDPuVc
         rtHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792364805; x=1792969605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rw74kOm/r/i3AhK/ISX8MlGZQQoMSXKN7Q+g2czWsSE=;
        b=VpaAeG5/2Pt7bksIuHEC67E6icAKZFJqOvee+sVEa59RJ09DE5DAuLQietB86FBmVv
         PCuIp9DNpP+hEpS/p+B84tpUNBlEjKk+O9TLQXQfzjMtvfIj4Rf8vg6Nx+S+PmEC3leQ
         qbWSF0ZMZmkqlyOMU0lS8HevYeVS45dSdGMl/RsjnMuMlupaQYQpAuuL6mRYpEAQIdeE
         EDZ6b0h/GROptwFS0JtjBHiQn0JdJKD2EXaqb1NA9q2ttpnyzREIvd5JXUmXMY5rPjGv
         xfccb33x4b8ofyxlec/baIHRfvwWa4DHaF5sbHRlkHiP72+41B+uc9NMBPQ1OP644Oz7
         1M6w==
X-Gm-Message-State: AFq9FYJC7q0EnFRtnKa8/AmsqoIuLQ56RW/2NAavHD5yVnxf5h4Jw6bG
	8/NlxqfzcPR4GqBwW72td/DQykvdE60w2LjzT2ZLCaIu4aKIBcNbNQpOiYcvzgR9
X-Gm-Gg: AYBFou1qq5AduMRDu+I+O+MkffIKQ7DjDg8qvvLaUtDddz3/rDt+4ixnSidg/fHY4sG
	rYr6n4CwD0LNJWeN9DeBIUBu3yAmj2F9zXi8xUZTj2RzszXsWW43P5uvp8LN0XfrGm1LGfda0O4
	mOBG8iE//5b9JCV4D/SIQ0trrI/FSa11lUPdgZtYsl7q2u+BHQA78QgFD+w/U6NNoHvIbQT7ABU
	eR+4qTLuf8WxzlF3vQJybJV8U04Prw6KTOPYGsPAmIQ3pwyzYg9A5HMxizaV6xbAwiVy07pJMSo
	2q7581YriemXFICWimDaAuHZ7Bi9XxBGpDDk2jnwHEtf6vLDuu+b7BKVLtiZfND1N0lrOuFyltV
	gVhRUgiWqznF+vCYuWsenW4FgnYXDOXl4D8Vm1WsqTIXGLF2x6ZoNWMGMM3/Xe5xYl8rwNSq4sy
	uWRwpHX2xTF5mmWLNpl7OjpCz0SYfoecmA6SC677mozwFUu3nf/UZQha34j5sigaoheDWMLq66e
	9sXVURg6AO173JDhuMex+aF744lG5s=
X-Received: by 2002:a17:90b:580f:b0:3a4:adea:50ad with SMTP id 98e67ed59e1d1-3aceebf6d03mr5096916a91.27.1792364804805;
        Sun, 18 Oct 2026 16:06:44 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc43a1981sm13117714a91.2.2026.10.18.16.06.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 16:06:44 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH] layerindex/utils.py: import bb in is_deps_satisfied()
Date: Sun, 18 Oct 2026 16:06:39 -0700
Message-ID: <20261018230639.88187-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 23:06:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5093

is_deps_satisfied() calls bb.utils.vercmp_string_op() to check a
versioned dependency such as LAYERDEPENDS_foo = "core (>= 12)", but
utils.py never imports bb at module level: the import in
explode_dep_versions2() only binds bb inside that function. So as soon as
any layer had a versioned dependency on a collection with a
LAYERVERSION, update.py stopped while sorting the layers, before
updating any of them:

  File "layerindex/update.py", line 513, in main
    if utils.is_deps_satisfied(req_col, req_ver, collections):
  File "layerindex/utils.py", line 72, in is_deps_satisfied
    success = bb.utils.vercmp_string_op(existed_ver, dep_version, op)
  NameError: name 'bb' is not defined

Import bb.utils where it is used, as the other functions here do; by
then explode_dep_versions2() has put BitBake's lib directory on
sys.path.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/utils.py |  3 +++
 tests/test_utils.py | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 tests/test_utils.py

diff --git a/layerindex/utils.py b/layerindex/utils.py
index 7e7ebe4..e5bad40 100644
--- a/layerindex/utils.py
+++ b/layerindex/utils.py
@@ -68,6 +68,9 @@ def is_deps_satisfied(req_col, req_ver, collections):
                 # If there is no version in the found layer, then don't use this layer.
                 if not existed_ver:
                     continue
+                # bb is not imported at module level; by now
+                # explode_dep_versions2() has put BitBake's lib on sys.path
+                import bb.utils
                 (op, dep_version) = req_ver.split()
                 success = bb.utils.vercmp_string_op(existed_ver, dep_version, op)
                 if success:
diff --git a/tests/test_utils.py b/tests/test_utils.py
new file mode 100644
index 0000000..2b9ebcb
--- /dev/null
+++ b/tests/test_utils.py
@@ -0,0 +1,42 @@
+# layerindex-web - tests for layerindex/utils.py
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+
+import operator
+import sys
+import types
+
+import pytest
+
+from layerindex import utils
+
+
+@pytest.fixture
+def fake_bb(monkeypatch):
+    """A stand-in for BitBake's bb.utils, which update.py imports from the
+    BitBake checkout at runtime. Versions here are plain integers."""
+    ops = {'>=': operator.ge, '>': operator.gt, '=': operator.eq, '<=': operator.le, '<': operator.lt}
+    bb = types.ModuleType('bb')
+    bb.utils = types.ModuleType('bb.utils')
+    bb.utils.vercmp_string_op = lambda a, b, op: ops[op](int(a), int(b))
+    monkeypatch.setitem(sys.modules, 'bb', bb)
+    monkeypatch.setitem(sys.modules, 'bb.utils', bb.utils)
+
+
+@pytest.mark.parametrize('req_ver, collections, expected', [
+    # No version constraint: any matching collection will do
+    (None, {('core', '15')}, True),
+    (None, {('core', '')}, True),
+    # Versioned constraint against the collection's LAYERVERSION
+    ('>= 12', {('core', '15')}, True),
+    ('>= 16', {('core', '15')}, False),
+    ('= 15', {('core', '15')}, True),
+    # A collection without a version can't satisfy a versioned constraint
+    ('>= 12', {('core', '')}, False),
+    # Other collections don't count
+    ('>= 12', {('other', '15')}, False),
+])
+def test_is_deps_satisfied(fake_bb, req_ver, collections, expected):
+    assert utils.is_deps_satisfied('core', req_ver, collections) is expected
-- 
2.56.0


