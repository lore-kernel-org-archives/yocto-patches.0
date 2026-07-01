Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824D6C44500
	for <webhook@archiver.kernel.org>; Wed,  1 Jul 2026 07:40:41 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.39829.1782891638676099415
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Jul 2026 00:40:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=s2BEWoHz;
 spf=pass (domain: gmail.com, ip: 209.85.222.173, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-915ab38ac14so33678685a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 00:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782891637; x=1783496437; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+JbDIq7r4PS1tgWPnuiK0Rqjmn0yHxyhY8c27yUaxo=;
        b=s2BEWoHz0ebwEeLObYk5G+Jx1yX7+qsk+W7/ofLBs8F03fOK8jSE7amXRC5EML6I0x
         JsOakvmJgUnUhVVqQtMd/RTtQBALgVZ/9QDSxXpr8W9EcndQ2+4/mDzmVbxwsuppflki
         h4OtSw3SajvxAf12j1Q16Nz6eTbnzEDJslzmI1jVyQnK9zIUpDR+p+tkHiXR9twDfDJS
         WRzL3cSVCi/+v/F3hE0PzHh2fQEPv0jK4je7fOrRM3M7HUGCYn2Y/p17bdOFGedeG3hi
         N6Icvdejf0AYzXFYaHb89sF0+6LLGt+7bIHXaWKb1o4CiaN8MUAJkkC1Q4XrqUMO3b/N
         iFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782891637; x=1783496437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g+JbDIq7r4PS1tgWPnuiK0Rqjmn0yHxyhY8c27yUaxo=;
        b=W3/foCccb+8GsP2oDchS1Wayhga+oYLxFtVsa7ScyjqJ3KZabMwBXgdBn3eZlyIUFd
         bUph3l/1n51kbPddkB3fbPgnLib9Q8463Ue2u8x4mTsqoAuxdSonZzoWQNaios5+4i1y
         uWv/0heZEZl5IGXNBw2d74qwX6raQjW1k0HVvUuq672HC7FUSjPp4kLbA2LVFSWzUBtY
         /dntPG1td8iRw5ibNWR6ZyPguTkKjFAHW647IxB+8za6V8ZQaNkMrPsviz/IS/Yu8qWR
         mdOkFJwd4xTaQHhIhn+RQ2G9Ym1aVESkCD7pPCjtCknNU67QG0Rfctioygz2qpUef3RL
         e8BQ==
X-Gm-Message-State: AOJu0Yyqz5Q7UKtV2E6qr6kAxYzXbVW0bVTZd9JzBQShCEk3m9cP9vQw
	4gm8CBkd+kdDSjPZNCKwPuxTy5DoTmPcA4Yat0rdPjCy1Ks5ou/7gsvIZVkv7w==
X-Gm-Gg: AfdE7cnpqOQnccS2qd4BqCn1bJBWlXXSo2q9MS+b9baMU72LZKNxIVekpWgL9WbJ2s5
	6F2Eby92Ore4sn8roRMIGTZTIBVJLIU4EOqDRt2Eu7rF0qGtjXIrYeTviN9SpilQn4Z3Z6ZcaKL
	YPalmKuZ4ixL3Uor+gYaIuFmudSYUbftvZRdjsgC5597X4Tx/ocu9pY5IH/W41YjNRbX6AGHLFT
	QXt9YUdk9+4Dn1EJZpCmpDfTcKOmEgoEGtqU0N6HU4oM1tztAHUWs0YsJf2/sH4ZJOrUhmxFSO2
	2nF2jf6CS3zdjqzAzzhaCQWZganIz+CKjSPyJzWy9XiXNqCIRS0OCPj9CWWZOYugfQWEiRY7Gx0
	eHcil55IK18VN9nom3IBy6azhpJ/R2KBNJsB1cb5XrWSqZW9jnnssovHcdkaM54z72bA0vSb3h4
	M53V4dP8+Lwn494LAYruleTQfjMwgd4hjaXcfG6QPQeftk4cgcB8qcPNo=
X-Received: by 2002:a05:620a:408c:b0:92e:6bbf:9672 with SMTP id af79cd13be357-92e784d12f8mr73882985a.46.1782891637225;
        Wed, 01 Jul 2026 00:40:37 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f35e790229sm15822316d6.2.2026.07.01.00.40.35
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 00:40:35 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH v3 02/10] tests: add a session banner via conftest.py
Date: Wed,  1 Jul 2026 03:40:22 -0400
Message-ID: <20260701074030.1090807-3-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260701074030.1090807-1-twoerner@gmail.com>
References: <20260701074030.1090807-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 07:40:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4334

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
changes in v3:
- no change in this revision.
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


