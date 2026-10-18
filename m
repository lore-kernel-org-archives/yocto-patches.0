Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840FECCF2C7
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 01:46:16 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7822.1792287968826022476
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 18:46:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=AR/IQvuS;
 spf=pass (domain: gmail.com, ip: 209.85.214.178, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2dd76b1361dso4516565ad.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 18:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792287968; x=1792892768; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XiJGn5apn5u4JMa0QLznlKt0ZItDuecqbsRsua8szQE=;
        b=AR/IQvuSMPWqKufgao5dxhL4QFQAYw/j5hr8jNxRYEZffe5OISt7UnAx6vOVNGBdE9
         JxEksLnheOwC0LP0whoByF0HsW1zKRZQtO9Z52MObI/jcvKb88g9k6quZrVb09AItryo
         UPKB65bURzaofrcCxg+D3LVqjPfgUCXjllpyw/H0Vv+DHRIu6YsG9Nq8BFhSvmcroRuq
         S8ePyCTZFN6cU5J+5lWOiYjgIfQ3VHpSCXx8waZrYKYfVs06e+91/ulUm516GHqo3oz+
         blmkotrEMrwDtVQcqTOfFRVtvxWNldDeZckq7RJHvpf9MxvXfGPYgUhkyk/zi2emzYgH
         vO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792287968; x=1792892768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XiJGn5apn5u4JMa0QLznlKt0ZItDuecqbsRsua8szQE=;
        b=2V46rwBlNgAVLOpwgWDQFsNUFXZdYfhDFnjZDhMtjnafXNg3dSYZPJam5HOfF9R4mZ
         arFkb8uE1wJ0vnVnwABXus1xRWl/4Z/tr7q5fY6PpwPQmSR9zTRofT43GYe80sTZ3huA
         rYNHIqDbo6vK8l0xg4sy5eO9fDCg+xJT5WeZiR8irMszjKwoN9Oozpb2H9zvxSSxs3oq
         S78C63b6fs/Pv2PlwNJt4/NL2Angumjw92Mnolg4BDz7qaYKCIkJn6/LiCeDv4swgJqV
         2V7Inax/FEZJBdoi3OZ0HL7HeXfCyLTihuaV2U4sz2n+VojY74G9ZEQEsTiugqY3E4yb
         Itzg==
X-Gm-Message-State: AFq9FYJtvonwygIakjckpZBuPRVwljlZLN+JyeQk6CGoH/Jq5P0fYfSJ
	DRT9cEyqgYjP6wudivlpXpYHmb6uBM5yXkLWXBPruVzddVcWFoOLH7xo8hAzFQ==
X-Gm-Gg: AYBFou2FxVnQMdlnF55KR65p9MUA5qIzOeUg1Qd2IF2NvaRaH77XR2Gmn9D2PTRNOd2
	o4k6LKlrEtZeNEf0eem545N5G7JNggxTxUoqowXgEU9KqHke8td3KbsFOw6xcsIGqvh826lNQw/
	8egcHvfloSsFp5ihe5r78VSI6FyhCMn2gZn50l8v6LQiKp52aZTMrPNH1NmgGumrLTxg3D0SYfH
	wL/k6ETypde67OZVav7Ycinqw/+AJmgR3srg06CLsT4v+Vm972HSvKAWaWKlLmElCQd+Scz9GQX
	tTspZYEekj4n8JgAvkRnT6RTPLqE1wi77vF1W9G0TOqJfkYeSAPATYB/V04uLdlXpV4HfH5gXbs
	lGq8zHKuynuCH3eUZdrE2xoPxDhK3vr+AJ2tWHRzBfQ2wS1xNhRbpPHYd3JtEcd1+ZSWt5D9enR
	k9d+CbsDKgPzTH/+ib97sCu9LVAVBECiwpg96Ws5348NGvH8CHOVPmp7XoTjBegNlQwVHV4EjA9
	63ShWXFFOUYxeODHSRCRAIGaiUidmF3El1APpPYJA==
X-Received: by 2002:a17:903:2c8b:b0:2e9:5c55:c46a with SMTP id d9443c01a7336-2e9a6834a18mr34639815ad.7.1792287967822;
        Sat, 17 Oct 2026 18:46:07 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e87836bsm25935655ad.47.2026.10.17.18.46.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 18:46:07 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [error-report-web][PATCH 2/5] Add docker/run-tests.sh to run the tests in a container.
Date: Sat, 17 Oct 2026 18:43:58 -0700
Message-ID: <20261018014510.72203-5-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018014510.72203-1-tim.orling@konsulko.com>
References: <20261018014510.72203-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 01:46:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5046

Build the image and test against a throwaway MySQL, as layerindex-web
does. -Wa shows deprecation warnings. Read SECRET_KEY from the
environment in settings.py.docker, and keep .git and .env out of the
image and .env out of git.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 .dockerignore              | 10 ++++++++++
 .gitignore                 |  1 +
 docker/run-tests.sh        | 32 ++++++++++++++++++++++++++++++++
 project/settings.py.docker |  2 +-
 4 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100644 .dockerignore
 create mode 100755 docker/run-tests.sh

diff --git a/.dockerignore b/.dockerignore
new file mode 100644
index 0000000..adce5c5
--- /dev/null
+++ b/.dockerignore
@@ -0,0 +1,10 @@
+.git
+.env
+.devcontainer
+.ruff_cache
+__pycache__
+*.pyc
+*.sqlite3
+*.patch
+venv
+.venv
diff --git a/.gitignore b/.gitignore
index a6c3d2d..2b8f143 100644
--- a/.gitignore
+++ b/.gitignore
@@ -7,3 +7,4 @@
 pull-*/
 venv
 *.sqlite3
+.env
diff --git a/docker/run-tests.sh b/docker/run-tests.sh
new file mode 100755
index 0000000..54aaa8b
--- /dev/null
+++ b/docker/run-tests.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+# Run the tests in the app image against a throwaway MySQL. Used by CI.
+#
+# SPDX-License-Identifier: MIT
+
+set -e
+
+IMAGE=${IMAGE:-error-report-web-test}
+NET=error-report-web-test
+DB=error-report-web-test-db
+
+docker build -t "$IMAGE" .
+
+docker network create $NET >/dev/null
+trap 'docker rm -f $DB >/dev/null; docker network rm $NET >/dev/null' EXIT
+
+# Root so Django can create the test database; testingpw isn't a secret.
+docker run -d --name $DB --network $NET --network-alias db \
+    -e MYSQL_ROOT_PASSWORD=testingpw -e MYSQL_DATABASE=errorreport \
+    mysql:8.0.36 >/dev/null
+until docker exec $DB mysql -h127.0.0.1 -uroot -ptestingpw -e 'SELECT 1' >/dev/null 2>&1; do
+    if [ "$(docker inspect -f '{{.State.Running}}' $DB)" != true ]; then
+        docker logs $DB | tail -5; exit 1
+    fi
+    sleep 1
+done
+
+# -Wa shows deprecation warnings, i.e. what breaks on the next Django.
+docker run --rm --network $NET \
+    -e SECRET_KEY=ci-only \
+    -e MYSQL_DATABASE=errorreport -e MYSQL_USER=root -e MYSQL_PASSWORD=testingpw \
+    "$IMAGE" python3 -Wa manage.py test --noinput Post
diff --git a/project/settings.py.docker b/project/settings.py.docker
index b7ff669..9f98715 100644
--- a/project/settings.py.docker
+++ b/project/settings.py.docker
@@ -127,7 +127,7 @@ STATICFILES_FINDERS = (
 )
 
 # Make this unique, and don't share it with anybody.
-SECRET_KEY = 'changeme'
+SECRET_KEY = os.environ.get('SECRET_KEY', 'changeme')
 
 MIDDLEWARE = [
     'django.middleware.common.CommonMiddleware',
-- 
2.56.0


