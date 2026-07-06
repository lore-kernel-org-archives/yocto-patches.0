Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDFBC44501
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 22:29:25 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.162835.1783376961351528012
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Jul 2026 15:29:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=WWzw1cSq;
 spf=pass (domain: gmail.com, ip: 209.85.222.181, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e67555e24so163686785a.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 15:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783376960; x=1783981760; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=i4niLYMtCI3pGTTrb1BSmuCRjAIRYPUa5GLBitC2wPY=;
        b=WWzw1cSqpX+eSKPEbz53C6jU12CXXxwCB/eiEK0ItHIHQh27RKkQrxdJGkcrwjdTl7
         MVkVGzOrZvJ7Bw/1pSBSmqowgobXon36BJDsXElD910bX0DlNZQQ/TeqQKI4dSMjpqKQ
         RoxjSEeAbsZd+XM9pDzN3pHUNRgFtvWdr8CSkZR/68n7fJHLZgvEvcEMuabYiDunFu4f
         S1MmM2qMMO0Jg6S1082NcJl8fhO0AGj8c8exDugP0dFKyx3WHePrfLTOwuzkwoWa2vSy
         ARLNonXkcPAP0OPOhvDlxE3AX5ZowRGa+fDjMJI97D6XcrmV/2srWy9d9b1/g3BJphki
         HkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783376960; x=1783981760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=i4niLYMtCI3pGTTrb1BSmuCRjAIRYPUa5GLBitC2wPY=;
        b=TwDCYHhoxC9Q+LLwkOizyP4gAnd5CXTg0Z8L9qAy3OGJM0gzNzm3rrpMNxNEdNOgmP
         w8zSel7wTesuyRwhhnoGloWCa7aMMnivuoFw8naWDJ+IKeedFPUs0TtYtMLA/cZ+mmQ1
         a3cnWVqNjybWHF0mTQvUMmN2MtAVYeUdLN+G5JjJX0REOOMqxn9n+orFT7xr1lID+gnv
         DSTbawl5YLgJlV8rOEXkr3OX99UB+IqNQ/aCWMhEExMoWzM0rhrP7dv2UuA3Xfy37w4G
         1jqN3nDEXO+gwybc9yxUENeRxE8Csu5E4ugPOE1ltMHCk0d8nPM2n3viTJXzuIHitnP3
         9+Fw==
X-Gm-Message-State: AOJu0Yzd/QiNb7EbfyEqpYOziN+rUiiLFGYJ0Kr3ljDNV1cy1ugxbzQh
	GlI/ezbnpo+Kj9pLV5LLA76w2p1mPAHr9E68SFQ4hBm9QdN7UKiuVT3+JdEZydcz
X-Gm-Gg: AfdE7cmUfMrTH6Od48pNh7vIqSlwFJQY9pqdmTJrJCMdURSAJB2hRb/CBETEpdUdXNA
	anZZms7RdE4OMg4Zm7EKwhVnIJjdBROvmqVnwSpuHqGNu+OaIUE5ljltGMA5EeZkoly1+k8JVx5
	KGxNj+rGl5LQWXqQt7iIwXZN8L+bAAZGVlP8PR2+2XW0UAtFyYSwGcrKWdZDHKe/ewjmCbxPti0
	J0UsS4dxDuuXmI3pcJ4qB9La/Fa2pbnpkDJpqDIxGr+zW40zO4R7Uu20xG1bIGtQohRIcCRTd0x
	15wtaYDhxXNQd7Cz6Ni6IEC0MaU+/x/t9O3kE1Z+jeYSaf5+qucTlsgvsC2SkiRFsVtqpKu4jex
	rRx2J5zllffaNlBm5gqTeihI4lpK5Z7Hu6+pTTm+HeJ5q2LOQqZyxCoGJ7yESCilB9S76eOneWD
	ZQvfkreaJ9HTxxj3YCitUvSZPFET6nYbQofhbD7oWIJX7ep4SFSg9a5DxswAdBNo9ggA==
X-Received: by 2002:a05:6214:2521:b0:8ca:10aa:e1f9 with SMTP id 6a1803df08f44-8fcb4903b99mr32972886d6.42.1783376960159;
        Mon, 06 Jul 2026 15:29:20 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f472a9d8c0sm143663726d6.49.2026.07.06.15.29.19
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 15:29:19 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH v4 2/6] tests: add conftest with a wic-import preflight and session banner
Date: Mon,  6 Jul 2026 18:29:00 -0400
Message-ID: <20260706222904.664863-3-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260706222904.664863-1-twoerner@gmail.com>
References: <20260706222904.664863-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 22:29:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4444

tests/conftest.py prepares the suite and describes the run. It adds the
in-tree src/ to sys.path so the tests import the wic in the checkout
without an install, then imports wic once up front: if that fails, the
session stops immediately with pytest.exit() and the reason, rather than
letting every test error out one by one against a missing or wrong wic.

A pytest_report_header hook prints a short banner naming the host, the
Python and pytest versions, and the wic under test with its version and
imported path, so a run can be attributed when more than one checkout or
virtualenv is in play.

AI-Generated: codex/claude-opus 4.8 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes in v4:
- move the wic-import check here from the run-tests.sh wrapper, so
  it runs on every invocation regardless of how pytest is launched;
  on failure the session stops with pytest.exit().
changes in v3:
- no change in this revision.
changes in v2:
- v1 submitted the entire test suite as a single commit; v2 breaks
  the work into a reviewable series, and this patch is one step of it.
---
 tests/conftest.py | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 tests/conftest.py

diff --git a/tests/conftest.py b/tests/conftest.py
new file mode 100644
index 000000000000..13b8953cec40
--- /dev/null
+++ b/tests/conftest.py
@@ -0,0 +1,28 @@
+# Session setup and banner for the wic test suite.
+
+import platform
+import sys
+from pathlib import Path
+
+import pytest
+
+_SRC = Path(__file__).resolve().parent.parent / "src"
+if str(_SRC) not in sys.path:
+    sys.path.insert(0, str(_SRC))
+
+try:
+    import wic.cli as _wic_cli
+except Exception as exc:
+    pytest.exit("cannot import wic from %s: %s" % (_SRC, exc), returncode=1)
+
+
+def pytest_report_header(config):
+    return "\n".join([
+        "wic test suite",
+        "  host:   %s  %s %s" % (
+            platform.node(), platform.system(), platform.machine()),
+        "  python: %s   pytest: %s" % (
+            platform.python_version(), pytest.__version__),
+        "  wic:    %s  (%s)" % (
+            getattr(_wic_cli, "__version__", "(unknown)"), _wic_cli.__file__),
+    ])
-- 
2.50.0.173.g8b6f19ccfc3a


