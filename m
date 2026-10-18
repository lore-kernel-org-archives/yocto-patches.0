Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FD2CCF2C7
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 01:50:26 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7868.1792288226178279086
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 18:50:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=TWO2wo/U;
 spf=pass (domain: gmail.com, ip: 209.85.214.172, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d71d1cc8b2so5799035ad.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 18:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792288225; x=1792893025; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9BtWE7R9zMiQ/M455k1HDoT1LD1Pd5kXaCUctU9/nfA=;
        b=TWO2wo/UIDBuYG/O+2V4MKV95S1vLYjEd+azmS0qw/OyI1jUsqX/n2DNuCvO9om8YM
         AgspjGgw+AU96yZUidgIVPhTiFYh8WxsUPJIOUZ1glmpL9FunGZPd4Mscv2C4DiI3Mlw
         /1XiYSMp0GeHGZh/nSq8rCoaXbnOGoEcWNxIqSO+0nBz2p5PbnLTeJI/qaYE/4BGOccC
         ymqxxbP9mmuhoHiVVwtE3+iaOhASql+0SDEIgtSbgY0k9LbxMKxO8excebyHZxS8wq/B
         0YA33v7kEhFg9PYkgLzUh2zb32debiX6w6rZIrIvn3IFd8deXurg5YXqO8+lBq10SauO
         ARHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792288225; x=1792893025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9BtWE7R9zMiQ/M455k1HDoT1LD1Pd5kXaCUctU9/nfA=;
        b=dlOutRjIs9Rm8F8KXa9U44e7wyDUvUHZonJaCaKNHkfs0gA9xr9Y/GeTCGigGdcERB
         7l071/sy7aJX/GWzXOx95xxV0k3SgOhb5oPc6G9p/txPAEVh+4KGmVOHz6QkoggqDLIX
         j2m8KGMFJ5uam2VoIYrq/TqMq5ua4/4JxzPB2p0l5mN5ND/zKwkK1TDZ4K1NcXdmI9qR
         tDdITY+Qp+fH1INcnzsa/lQyznbl3+wH1s1aYWPjI/dTbWpNqJDqa3ZLMsoI4p1WJoUe
         +gMwAWxRN0STj87kIrY9GWlbNGxWaN/wzh4fN8TjH3DUqyWcp9Tj+Led345/5r28bS0R
         ICjA==
X-Gm-Message-State: AFq9FYLf9cbY9USG0GjcZUK3dhqE4dA+dzF8T1c3CysW88InVKaan0Cf
	+jGOgy1f/lc6dxPgoS5014Uvy3Jk3HadceTVsTNtWx2AWDMobLAtYm4IBmjC/g==
X-Gm-Gg: AYBFou0EUoloDDtxkpwELxdbixGsZS88Fa6gHAkvoydsVDLjbiAFPV1SjFvo00S/gIM
	QBgbjA6l8iaaRsuhIQokVgwwUfSrJk78pZrXbmivTVZjWqZeXjk1c1G3S4Q6FVh3i5cwtXtI7qo
	j/TT+Kbl0Ep4q/3lr2HXBdanR/pSqN9uz1tPFQphwESDrxBOrX7KXQnrLLSEfyHR71F1x+3TG23
	oIhh1GUUHFZaS33hqYn92FmcldzqFga0FiSwMUYHHrcQ+z7NNj2C9A+u1Gyx6NH4z4oEPd799JM
	sMX/3iJ+NjQ1VBmwMwDw5Bu1jTFQkxtUXgR4/AdRLkQbTWCg+79CRVDEDSDB14mfvrjGxi2GeWo
	u8Ej4XPhyU0mQhRU2FpPynxjEtznCS3edMBsoUsEMVRJaO1hC6g/QO9ulUcxXp2TjYWM0C3OL6/
	P21BMp3RfHPvZ95YhaZK4mhwmpOcL6UYIQhtPAdRH7Hr+ZiXRcSOzZCs9YtNv8lGbOpbROPWvvY
	RaFakHV6h/jJ5V9EKPfjA1diohSVXo=
X-Received: by 2002:a17:902:e852:b0:2e9:7dda:bfd1 with SMTP id d9443c01a7336-2e9a69f9512mr33724315ad.30.1792288225442;
        Sat, 17 Oct 2026 18:50:25 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e87994bsm25005515ad.60.2026.10.17.18.50.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 18:50:24 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [error-report-web][PATCH 3/3] Add a GitHub Actions workflow to scan dependencies with Safety.
Date: Sat, 17 Oct 2026 18:47:47 -0700
Message-ID: <20261018014924.73070-7-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018014924.73070-1-tim.orling@konsulko.com>
References: <20261018014924.73070-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 01:50:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5053

Scan the packages installed in the image, weekly and on push, as
layerindex-web does. Skipped without SAFETY_API_KEY.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 .github/workflows/safety.yml | 39 ++++++++++++++++++++++++++++++++++++
 .safety-project.ini          |  5 +++++
 2 files changed, 44 insertions(+)
 create mode 100644 .github/workflows/safety.yml
 create mode 100644 .safety-project.ini

diff --git a/.github/workflows/safety.yml b/.github/workflows/safety.yml
new file mode 100644
index 0000000..768229d
--- /dev/null
+++ b/.github/workflows/safety.yml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: MIT
+
+name: Safety
+
+on:
+  push:
+    branches: [master,master-next]
+  schedule:
+    - cron: '0 6 * * 1'
+  workflow_dispatch:
+
+permissions:
+  contents: read
+
+jobs:
+  scan:
+    runs-on: ubuntu-latest
+    timeout-minutes: 15
+    env:
+      SAFETY_API_KEY: ${{ secrets.SAFETY_API_KEY }}
+    # Skipped where the secret isn't set, e.g. forks.
+    steps:
+      - uses: actions/checkout@v5
+
+      - name: Build image
+        if: env.SAFETY_API_KEY != ''
+        run: docker build -t error-report-web-test .
+
+      # Scan what's installed, not requirements.txt ranges.
+      - name: Safety scan
+        if: env.SAFETY_API_KEY != ''
+        run: |
+          mkdir safety-scan
+          cp .safety-project.ini safety-scan/
+          docker run --rm error-report-web-test pip3 freeze > safety-scan/requirements.txt
+          # typer pinned: newer releases break safety 3.7.0 ("no active click context")
+          python3 -m venv /tmp/safety
+          /tmp/safety/bin/pip install -q safety==3.7.0 typer==0.23.0
+          /tmp/safety/bin/safety scan --target safety-scan --detailed-output
diff --git a/.safety-project.ini b/.safety-project.ini
new file mode 100644
index 0000000..29b7a3b
--- /dev/null
+++ b/.safety-project.ini
@@ -0,0 +1,5 @@
+[project]
+id = error-report-web
+url = /codebases/error-report-web/findings
+name = error-report-web
+
-- 
2.56.0


