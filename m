Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38ECDCCF2C9
	for <webhook@archiver.kernel.org>; Sat, 17 Oct 2026 18:34:23 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1963.1792262057307064126
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 11:34:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=XqPwmL4L;
 spf=pass (domain: gmail.com, ip: 209.85.216.43, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3acdcfa2bd3so874250a91.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 11:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792262057; x=1792866857; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kdT3lN5TdbGomE2oDEOJM1AihZpr/j6rMKJKkoA9Pww=;
        b=XqPwmL4LP/nAJVwiEpPBYQDRdbcVQrK/ziP0zduc/TcoRvMZh3sgDJVi+XlpXvEiQx
         NdTti0W4rnSifErBpNl+bQ4nzmfscbz15id5yBGzYGBNGDYDi00ZwXuIbSMlbrHv6bQ3
         FBJUhGX0A/543QpDySMvzomSgdYvfNkQaa1ood7nlBvABYMvd2CqkidGJGSJV55B7WV2
         COBPGDtBbKt3Opc39pqRS/lIVmDGT3QyNtgviK2xOy92MZg1EY1TILCZvkDSWqpF9DR6
         E5Yn1/ClF6XiQ3xDp2+yF2QvueCA95RcXJ5yAK/hP6YMjwS4jQG2RmxzxJJNvXH8yDe0
         jqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792262057; x=1792866857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kdT3lN5TdbGomE2oDEOJM1AihZpr/j6rMKJKkoA9Pww=;
        b=UQ1HgzdXAArw0KFtJ50yMZ0jBj7LCzX/i9JMwX9URMUcJbJZRnKV9UP1+NCNSAkM2O
         4Zk6++NDi3vqVo5eRdiEx6hajBXPt+iO1tBhYfWHU7YqGYCGbXgNcRa4B2PjOveWyMHz
         p7u9RrVi2MhnZlCPfH2KNy/z4Gzb+qXcqxM9qvtQzT8lD+VpEgHasZx0h/RXKhUbFuoy
         /8LVYvEd7jisUQqahNyh3UWs/9nO0djkgZF/rXVSvtrqw/gppX7BiDGzdkQs24nZKOmw
         def3gXsV0bGgBniJ7Lv1lEwFmaLAzgwLuhU1+kUiJugKhVWJhC3WKasaibdwterKqlqD
         8LfA==
X-Gm-Message-State: AFq9FYKViU6NowTyZqbZZP42u2VFMux1HLfr0EFObvPGNCHIAWD+xzd1
	OtsUYQVesC4dzt6JhTtV2+vxf+DfsbbmkwS3iM2dfcLVpa+Q2jXIcu7TCj29tQ==
X-Gm-Gg: AYBFou04gPRQrPbK8mB4nlOcu0i8CbZly7ZGFVQx8XYvzT8n7KogbmJWAlRq2h4qh2H
	iOz5lZmigx6RDJ29C1DVsQe2HJRiLhPJiKgPDMZ8UJm+vdX6EML0mEhgOtEkJlX3JBNSG8GVqbL
	XqC2HEShmYWkJud0zdjDUeGL3NQPbvn8CCuo2aP+2ex+z6ShnDlgCYHvI/wNXTT9W/MrM1T1h/f
	M0NflxkWTCKDbmgnK+6h55zn/7o0mcb83cYkyjXOR9brJHLXQ7qtYK5bQ+LlvuaR+UGaqQYueli
	h33/CMrat/PRF6a98tILA9G9NAaN/MJBaVNcgU5kN06Dk4zhh0jrGEgxEUSB3yljKYrOcodbYZN
	pWgvb85ihkp2xSc8A9X0XtDED6gO4Olmbi9eZAMy3Ic5nB6z8fyJOkcGM2AOlGJWo7RghIl6+aQ
	nMTle4OvlwfWd6JmvWJMJ3cfEUnc0RKRfsZ2Inu8+LUe2Ybduh/3CBzmUGpZVnYu53QXTYgfClt
	Fuj6HWnB8Of1m1mCyUnVdOFc5ybX/U=
X-Received: by 2002:a17:90b:1a8c:b0:3ab:be66:ddba with SMTP id 98e67ed59e1d1-3aceec7995bmr3142563a91.23.1792262056516;
        Sat, 17 Oct 2026 11:34:16 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc492fa54sm8933552a91.13.2026.10.17.11.34.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 11:34:15 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH] Add GitHub Actions CI running the test suite in Docker
Date: Sat, 17 Oct 2026 11:34:11 -0700
Message-ID: <20261017183411.91297-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 18:34:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5043

docker/run-tests.sh builds the production image, starts a throwaway
MariaDB 10.11 on a private network and runs the full test suite inside
the image, so tests/test_update.py can run bitbake on Linux. Test data
comes only from migrations and public git repositories; the database
password is the public default from docker/settings.py. The script can
also be run locally from the repository root.

A separate Safety workflow runs 'safety scan' on 'pip freeze' output
from the image, so version ranges in requirements.txt (e.g. Django)
cannot hide vulnerable releases. It runs on push, weekly and on demand,
so newly published vulnerabilities are reported without a code change,
and is skipped when SAFETY_API_KEY is not available.

Also keep local keys, logs, patches and virtualenvs out of the Docker
build context.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 .dockerignore                |  7 ++++++
 .github/workflows/ci.yml     | 22 +++++++++++++++++++
 .github/workflows/safety.yml | 40 +++++++++++++++++++++++++++++++++++
 .safety-project.ini          |  5 +++++
 docker/run-tests.sh          | 41 ++++++++++++++++++++++++++++++++++++
 5 files changed, 115 insertions(+)
 create mode 100644 .github/workflows/ci.yml
 create mode 100644 .github/workflows/safety.yml
 create mode 100644 .safety-project.ini
 create mode 100755 docker/run-tests.sh

diff --git a/.dockerignore b/.dockerignore
index b9ab463..3b82016 100644
--- a/.dockerignore
+++ b/.dockerignore
@@ -12,3 +12,10 @@ Dockerfile
 Dockerfile.web
 docker-compose.yml
 dockersetup.py
+*.pem
+*.log
+*.patch
+*.zst
+.venv
+.idea
+.DS_Store
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
diff --git a/.github/workflows/safety.yml b/.github/workflows/safety.yml
new file mode 100644
index 0000000..4840a08
--- /dev/null
+++ b/.github/workflows/safety.yml
@@ -0,0 +1,40 @@
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
+    # Steps are skipped where the secret isn't set, e.g. other forks.
+    steps:
+      - uses: actions/checkout@v5
+
+      - name: Build image
+        if: env.SAFETY_API_KEY != ''
+        run: docker build -t layerindex-test .
+
+      # Scans the versions actually installed in the image, so ranges in
+      # requirements.txt (e.g. Django) can't hide vulnerable releases.
+      - name: Safety scan
+        if: env.SAFETY_API_KEY != ''
+        run: |
+          mkdir safety-scan
+          cp .safety-project.ini safety-scan/
+          docker run --rm layerindex-test pip3 freeze > safety-scan/requirements.txt
+          # typer pinned: newer releases break safety 3.7.0 ("no active click context")
+          python3 -m venv /tmp/safety
+          /tmp/safety/bin/pip install -q safety==3.7.0 typer==0.23.0
+          /tmp/safety/bin/safety scan --target safety-scan --detailed-output
diff --git a/.safety-project.ini b/.safety-project.ini
new file mode 100644
index 0000000..e7ae822
--- /dev/null
+++ b/.safety-project.ini
@@ -0,0 +1,5 @@
+[project]
+id = layerindex-web
+url = /codebases/layerindex-web/findings
+name = layerindex-web
+
diff --git a/docker/run-tests.sh b/docker/run-tests.sh
new file mode 100755
index 0000000..e655611
--- /dev/null
+++ b/docker/run-tests.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+# layerindex-web - run the test suite in the production image against a
+# throwaway MariaDB. Used by CI; can also be run locally from the repo root.
+#
+# SPDX-License-Identifier: MIT
+
+set -e
+
+IMAGE=${IMAGE:-layerindex-test}
+NET=layerindex-test
+DB=layerindex-test-db
+
+docker build -t "$IMAGE" .
+
+docker network create $NET >/dev/null
+trap 'docker rm -f $DB >/dev/null; docker network rm $NET >/dev/null' EXIT
+
+# Alias "layersdb" matches the default DATABASE_HOST in docker/settings.py;
+# testingpw is that file's default password, not a real secret.
+docker run -d --name $DB --network $NET --network-alias layersdb \
+    -e MARIADB_ROOT_PASSWORD=testingpw mariadb:10.11 \
+    --character-set-server=utf8mb4 >/dev/null
+until docker exec $DB healthcheck.sh --connect --innodb_initialized >/dev/null 2>&1; do
+    sleep 1
+done
+
+# Runs as root only to prepare the container: tests/test_update.py rewrites
+# settings.py and bitbake writes its lock file next to it, the update scripts
+# expect bitbake already fetched, and the tests commit to git and call tree.
+docker run --rm --network $NET -u root \
+    -e SECRET_KEY=ci-only \
+    -e GIT_AUTHOR_NAME=ci -e GIT_AUTHOR_EMAIL=ci@example.com \
+    -e GIT_COMMITTER_NAME=ci -e GIT_COMMITTER_EMAIL=ci@example.com \
+    -v "$PWD/tests:/src/tests:ro" -w /opt/layerindex "$IMAGE" sh -ec '
+        apt-get update -qq && apt-get install -y -qq tree >/dev/null
+        cp -r /src/tests /opt/layerindex/
+        chown -R layers /opt/layerindex
+        su layers -s /bin/sh -c "set -e
+            git clone -q https://git.openembedded.org/bitbake /opt/workdir/https___git_openembedded_org_bitbake
+            pip3 install -q --user --no-warn-script-location pytest==9.0.3 pytest-django==4.12.0
+            python3 -m pytest -rfE -p no:cacheprovider tests/"'
-- 
2.56.0


