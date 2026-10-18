Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81924CCF2C4
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 01:46:36 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7793.1792287988209821647
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 18:46:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=VDml63jQ;
 spf=pass (domain: gmail.com, ip: 209.85.214.181, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e98798cbddso3505005ad.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 18:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792287987; x=1792892787; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3rIrMo220QotMJQgy8K0MRCyV17OJ0Bxjt04sRaO+Ug=;
        b=VDml63jQ36ihoP+5ltly6wSyqalLXi41o6AIzyJYQqpezbTj3VAWIxGtDcfYoIRiKK
         ympOhTVBfBBSZv51/Dr1DKTd4qOy0QyEeYOQ/0Nvv6XxAR9wOJWvVU5HcsN8O7MuKNSs
         q47X8isHhy0cA3F+Q/5Qq6qt3wK/gYRwsnEcpgXKHdHeibR3a1iVGEdSNkfkfxiYGv+v
         rjEhARQaadhMOYFNWWvtsunLcFQgN+EvBrnPCirtI9Ow/sum768c4sPd9FF/Lm+Rk+Ui
         D0y4mcfDFuO3+P5Xx5qYDOJlqYinki2MPxk5hPQ3H35SiV/RlSIF/qXWlKaziCGRXd6H
         gw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792287987; x=1792892787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3rIrMo220QotMJQgy8K0MRCyV17OJ0Bxjt04sRaO+Ug=;
        b=G21YUvLFRgJh7Ty/CKeQ2A+ce/3XW9HzCD4NkU+EQyAgdQaezxPrQyIA9GVH4UFtZt
         ZmPn1JEWvu4NtenX64jnL5LnsliybnOEKdMT5gyn5Yfd7XKMaE/DDvFKOJjsz8k8m0YL
         3Gb5R9vrIIYPrnqEjXHT3z1M9DdfdBU0i/taAqPRhQ4MQ3tvalBGVJ6tv9FWyKRnb3Ec
         4tZMC/QSauY59skL1r8pFYpMMRtj7q7SWWe0SfkBqBuQJ4WwCKPIcXjyBUNap3KA9seO
         QgCGTF+jHv2LrFlmthkptqeNnRTh72D0WtSGIntwwisXPfpNplfxbfp4CGoS6b4KbR/r
         IGKg==
X-Gm-Message-State: AFq9FYJ56N7IOexmwOjuvCRGII7oKDpabS5cmb7IzwmnauPXLjuNsLpW
	HQYnloUDzERPnV2VtfWs9T5GJSNPlBxsstHjEyGXwikirvWhQsz2gHFUa1bjUQ==
X-Gm-Gg: AYBFou3tLtpGEBW6E7hJybjKK7a7Ivi/eKNoANV8+30++fbAXTiDnDIt+EJtj11x0wd
	HpvbdCvGvDhj8vKyJ5otY3MAcKv4N01wXad2r/+ej8iUj6k9oHcIDOWTDmXw9H+EUCwBEwMkgF/
	wcuVUB3w0vyot7DKZqLc032N+tGvAXqop1wLfQslBF4p7A8V/raMvzshm3xKTs0mkK18u3/r5RK
	FkVDT/9By4yBEYwAya8u7D6+DwOvZ0WRRJnb4MVbiFuXfE5q7ZK8To4K8zrRqRkK7SnHJWTXJ4h
	aH3e/gnqxM3JEK4U5FrIBOLrhgfba1lGHK2i4oXOI2h1Y0Wt4nLYwhNl4SyPu8BekBDh7ZobHn1
	6jM9xNVSe1gIVrR40DwvamIyPpOHo3CeaL1tR8hJwZ7ec8sxtb6H/1Q9wJoVHQknJgeFcWP5AAl
	emu7Bis8JlPfDUMszNrXLhX5sUnb5/LkbtOsGI85k/l+prfImAHZeOI8nwxLCNzBTlbQcJL6OMl
	YB+4E83j064hJZNKLgc1o5VxTLRrOM=
X-Received: by 2002:a17:903:1b4c:b0:2e9:734c:5027 with SMTP id d9443c01a7336-2e9a69e9de2mr34324265ad.15.1792287987464;
        Sat, 17 Oct 2026 18:46:27 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e87836bsm25935655ad.47.2026.10.17.18.46.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 18:46:26 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [error-report-web][PATCH 3/5] Add a GitHub Actions workflow to run the tests.
Date: Sat, 17 Oct 2026 18:44:00 -0700
Message-ID: <20261018014510.72203-7-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018014510.72203-1-tim.orling@konsulko.com>
References: <20261018014510.72203-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 01:46:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5047

Runs docker/run-tests.sh, as layerindex-web does.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 .github/workflows/ci.yml | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 .github/workflows/ci.yml

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
new file mode 100644
index 0000000..74405ac
--- /dev/null
+++ b/.github/workflows/ci.yml
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: MIT
+
+name: CI
+
+on:
+  push:
+    branches: [master,master-next]
+  pull_request:
+    branches: [master]
+
+permissions:
+  contents: read
+
+jobs:
+  test:
+    runs-on: ubuntu-latest
+    timeout-minutes: 30
+    steps:
+      - uses: actions/checkout@v5
+
+      - name: Build image and run tests
+        run: docker/run-tests.sh
-- 
2.56.0


