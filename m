Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F37C43458
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 16:06:54 +0000 (UTC)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.25078.1782835606600549001
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 30 Jun 2026 09:06:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=WgVlzqNF;
 spf=pass (domain: gmail.com, ip: 209.85.222.176, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e501244f5so132055485a.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 30 Jun 2026 09:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782835605; x=1783440405; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Au9wk365wXNJ0WVz+5fX5E5Lq6YpU6FI82ckvlMjCfM=;
        b=WgVlzqNFwKjWDmaT+fQJp5lb7jlu8Pl6gkyGN1txpizXLNi3gW0AVNzrWl38ZVdAVF
         g1Rjc+ikvWxBIbudE2uQGUUmZ3Mw8pmfv/e/wDKaVstGFdbAIyb4WZET+kOtzkjsUznC
         p3d6b5jTMaxWxBsw761oMFO0GbMkFT9WWqfpciFpgjE5UTKa72WSvIwuVzgSEd8hQLzZ
         q7qbBo7vOsLyzR2+6CfJsXjdZdhEXTvPS2XkfQHtIGFEamOx0nTPc6nsrs0TrU+B+K4l
         WsW/E6V3+KRMOoIzZOuuJOz2c78X+tiebZsTF6ShC/u0C03+IzcZJUTnCvWKiNc9CG4r
         KWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782835605; x=1783440405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Au9wk365wXNJ0WVz+5fX5E5Lq6YpU6FI82ckvlMjCfM=;
        b=FH0mcYReG1r009Jq+d7ioseQs+gYFQ0fvLl9GNu5LUfCIKcvxxBt1Fgbq/ctFNYHe3
         s39CCLuUNFQ8kmEE/RaLFU8Haa1eQruxaPX7FXgPmo3k9LJh1QJpSMqA8+Buiq87qFUS
         Q1uorDJLIiW9DbVx9gxe68A9a0iQ6Ab4iwGXLUoTJddar+GXWhW+WdmWcXlTUj0PZuMG
         K9IaiS6dO/xxBCGy3+5eCZ6UbifAC7a2p0lhDJTuq8NPmyUwDtb48BgSQK/AM/O9KRxN
         fjRXLhXCXzz+4+4kjeRl2p8aunIZzvZMy1wUPPdfGcnlFBBfyYkpu2JnKxNJJa08zwTB
         hgYA==
X-Gm-Message-State: AOJu0YzyajVJcAjtzwOQHoLJ6sS9w0Jepu19NxY49zRHMGND0KakJANV
	mvSlc3AbiYF2b3lp9KUO5gOXvwTuioXlMpWGiwIwoJAgUrxTR4FROq1R+aorlQ==
X-Gm-Gg: AfdE7ckJYExxlq3ypYflKzGoZzk260waYDaQGHamLqMNesq4pqqLBRqlZSKUvBn5CzD
	REremTWVBFE9G19ngoI6zBNM36NpSyUZOg3Iy88CGJV6dZKf3ObU6o7EVoSSk/wO03ON5ocguez
	4S2fQeukALRxIE0n7ZKDtjSemuDf3YXEwbr0+EtbtGqZFwWM9N7yY1dwAtTHdx933ZotUnyHlSS
	LM6lg17Lr2yPNHiu78u86kCUtRY1ckB5XBSfoeI87XpRe7qpIWVg5UfDB5U7JwEosys0ze0/H4Y
	kTctpJezsR3gYVBSGTkSsh2aD6LnAaRP1fkc9wZxfB/LkYYvUeW/VqvemW1uQELpjS0R4x1QCkt
	0oHjIDBF/rKTDLSCd4Iq5dB877lTojySh8lVBCabmWky5AWHSKCEhodjFgEb+pCAbMtpFs2zsr/
	57s+7kdlnfUwM5IqN0pwc8TA4kX4xszpyFCyaqKLKjfn6KLOp0f7USn7M=
X-Received: by 2002:a05:620a:2304:20b0:92e:6430:3c73 with SMTP id af79cd13be357-92e64304068mr419713885a.21.1782835602669;
        Tue, 30 Jun 2026 09:06:42 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e621374dbsm272461785a.4.2026.06.30.09.06.40
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:06:41 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH v2 2/9] tests: add a session banner via conftest.py
Date: Tue, 30 Jun 2026 12:06:05 -0400
Message-ID: <20260630160612.1005451-3-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260630160612.1005451-1-twoerner@gmail.com>
References: <20260630160612.1005451-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Jun 2026 16:06:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4323

When a test run starts it is useful to see, at a glance, exactly what
is being tested: which host the run is on, which Python and pytest are
in use, and -- most importantly -- which wic the suite imported and
what version it reports. Without that, a passing or failing run is
hard to attribute, especially when more than one wic checkout or
virtualenv is in play.

pytest looks for a file named conftest.py and, among other things,
calls its pytest_report_header() hook to print extra lines in the
session header before collection begins. This commit adds that file
with a single hook that prints a short banner:

  - the host node name, operating system, and machine type;
  - the running Python version and the pytest version;
  - the version wic reports and the filesystem path the wic module was
    imported from.

The wic lookup is defensive: if wic cannot be imported (for example
the test extras were not installed, or the suite is being run outside
the checkout) the banner says so rather than aborting the run, so the
failure is visible in the header instead of as an opaque collection
error.

The file name conftest.py is mandatory; pytest discovers it by name,
so it cannot be called anything else.

AI-Generated: codex/claude-opus 4.7 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes in v2:
- v1 submitted the entire test suite as a single commit; v2 breaks
  the work into a reviewable series, and this patch is one step of it.
---
 tests/conftest.py | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 tests/conftest.py

diff --git a/tests/conftest.py b/tests/conftest.py
new file mode 100644
index 000000000000..1c368ebf8595
--- /dev/null
+++ b/tests/conftest.py
@@ -0,0 +1,38 @@
+# Session banner for the wic test suite.
+#
+# Before collection, print the environment the tests exercise:
+#   - the host
+#   - the Python and pytest versions
+#   - the wic under test (its version and the module path of its import)
+
+import platform
+
+import pytest
+
+
+def _wic_under_test():
+    """Return (version, module_path) for the wic being tested."""
+    try:
+        import wic.cli as wic_cli
+    except Exception as exc:  # pragma: no cover - reported in the banner
+        return ("(import failed: %s)" % exc, "(unimported)")
+    version = getattr(wic_cli, "__version__", "(unknown)")
+    module_path = getattr(wic_cli, "__file__", "(unknown)")
+    return (version, module_path)
+
+
+def _format_banner():
+    wic_version, wic_path = _wic_under_test()
+    lines = [
+        "wic test suite",
+        "  host:   %s  %s %s" % (
+            platform.node(), platform.system(), platform.machine()),
+        "  python: %s   pytest: %s" % (
+            platform.python_version(), pytest.__version__),
+        "  wic:    %s  (%s)" % (wic_version, wic_path),
+    ]
+    return "\n".join(lines)
+
+
+def pytest_report_header(config):
+    return _format_banner()
-- 
2.50.0.173.g8b6f19ccfc3a


