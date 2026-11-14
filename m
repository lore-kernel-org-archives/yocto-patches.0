Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6902.1794640138105894781
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 23:08:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qbee.io header.s=google header.b=Oxubc8nu;
 spf=pass (domain: qbee.io, ip: 209.85.221.51, mailfrom: piotr@qbee.io)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so1764585f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 23:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qbee.io; s=google; t=1794640136; x=1795244936; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QjFxy5A79bkWT+cxScoCNqj3x8xj6M0Fv5wOtt+LjXk=;
        b=Oxubc8nukEYzmmRLLlUyiyZb3sxqSIEmBr8XSOP17aZgk8xwAVPGdVdHjahdVE3w3O
         CTy4BQt7OkX0PtEGcoinpMw+XYKPy3y7QUH3MEMehOVB7CYdTEifrJP7ntl+P8lBMx9M
         8M9eLWCey+jl7lHNiFLN54el5gUJRofkwamts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794640136; x=1795244936;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QjFxy5A79bkWT+cxScoCNqj3x8xj6M0Fv5wOtt+LjXk=;
        b=lL0g2A5gYlXFyKHwKmnqbgzk8Iv9hGBlenqp1OYUUL5yASYss8M7xaDY6Nu6Z1jcHf
         pU1w2BNHMMc2BsK6K27VvocqL0wgQ5LWUISGqu6YPjcS19zZx7/v/Vururp4tioPgLIT
         vokMLOoDJMIpM8LKDaLaRg4t8FwKDa9gyX0Dly2lZMdED84FMXoY2CdtcRS+WRqj8vgm
         wvvyVEvR6Wl/puzoQRynjhlhMonadWysx7aCvaIUYBMxwtwGR0I58ErLMIhviSqBC8sa
         QpSzR3opPgWXJF48Updeq7mKplcX9dBC7eyvxTur6KijHQkeiJ/csEn04wGHTSrbNC75
         knkg==
X-Gm-Message-State: APuU4Z8p6/A0jN1takWh8oww+BY959ckfO9/eDYZfFupyU40y87ZZYkV
	zP3bmwAquE/v43x2p4NJ/Cm+tcFtoTn/uNBskb5LHSuo7CXnq88tgt1akxGAxhesIzi917nhdQ2
	NSiirjjU=
X-Gm-Gg: AYBFou2JAIfQWuwdirv7PvVhC0+pJkchbfuBar046By58MEOlCz5HMtfkg4udFKos4h
	E4fr5N4vpMgfwDdSjYGRKFe1DKvUtyVfcFLt4G5x2l4r1P3YZpsN5Nz6FUkp636IrUABD2R52vJ
	Fa2I6kKpOI2iVi0QPJxj5XUZ8Oxz4cb4xCed6R76VnkE0yHNxmDDYnCGIBYqsR5QL+fyhW3LWMQ
	l0L6j0MDAagiMya27ByhaODwNgp/W3NTrj94SR1ZdLls9yglKOgXEvf7bCM4iY1oAi/n1e8IaJV
	b9DfshJuRV67V8wHNlDf52joxAcMYxTGvjPEeR6GIWLtHqTK0RoqDsbLV3BOeFZ6MlpvJxwjdNp
	io+HtanCOt3w1DnDBfuDrsCE7tqWqK7Wen8l6BFKuF7PowH3FQUVBNz87HRivWavsUZ2H00rbVD
	jOIsUSciw7ZfMlDKe54WEwFus8AqIemi6vLoqvofgKLoy+1PmUXUvEAII9pzt6HXZ0THw/MWRAD
	ll2iYMwUxrJWvPrW9Tejgdq0fnlqtQUvkYzpXs2Z3QmYae/YMLBXYta9G1K3QmEHJJDbTpF3WQi
	59/l9JzG3Qrd9QG7oLvglmDm7meDe/BTzQLtdTN6fPpV5Jx3XRLiH3d46ubA
X-Received: by 2002:adf:e18e:0:b0:48d:fbdd:4132 with SMTP id ffacd0b85a97d-49c70b051c6mr9433849f8f.18.1794640135702;
        Fri, 13 Nov 2026 23:08:55 -0800 (PST)
Return-Path: <piotr@qbee.io>
Received: from localhost ([9.246.55.32])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-49c609c651esm9567516f8f.47.2026.11.13.23.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 23:08:55 -0800 (PST)
From: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Piotr=20Buli=C5=84ski?= <piotr@qbee.io>,
	"Claude Fable 5.2" <noreply@anthropic.com>
Subject: [layerindex-web][PATCH] requirements-dev.txt: pin the development and test tools
Date: Sat, 14 Nov 2026 08:08:52 +0100
Message-ID: <20261114070852.41000-1-piotr@qbee.io>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 07:09:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5376
Content-Type: text/plain; charset="utf-8"

The tools needed to work on the code were installed in two places that
did not agree. docker/run-tests.sh, which CI uses, installed pinned
versions of pytest and pytest-django. The dev container installed
unpinned ruff and pytest and no pytest-django, so the tests that need
Django could not be run in it at all.

Add requirements-dev.txt listing pytest, pytest-django and ruff with
pinned versions, to be installed on top of requirements.txt, and install
from it in both the dev container's postCreateCommand and
docker/run-tests.sh. pytest and pytest-django stay at the versions CI
already used; ruff is pinned to the version currently installed in the
dev container. docker/run-tests.sh mounts the file from the source tree,
like the tests, so changing it does not need an image rebuild.

Describe the file in the "Running the tests" section of README.devel.md.

Tested by installing from requirements-dev.txt in an existing dev
container and running the test suite other than tests/test_update.py,
which passes (89 tests). docker/run-tests.sh was not run, as Docker is
not available inside the dev container, and the dev container was not
rebuilt.

Signed-off-by: Piotr Buliński <piotr@qbee.io>
Co-Authored-By: Claude Fable 5.2 <noreply@anthropic.com>
---
 .devcontainer/devcontainer.json | 2 +-
 README.devel.md                 | 7 +++++--
 docker/run-tests.sh             | 6 ++++--
 requirements-dev.txt            | 3 +++
 4 files changed, 13 insertions(+), 5 deletions(-)
 create mode 100644 requirements-dev.txt

diff --git a/.devcontainer/devcontainer.json b/.devcontainer/devcontainer.json
index 0642115..039a21f 100644
--- a/.devcontainer/devcontainer.json
+++ b/.devcontainer/devcontainer.json
@@ -7,7 +7,7 @@
   // works, alongside the usual Python setup.
   "postCreateCommand": {
     "bitbake": "test -d /opt/workdir/https___git_openembedded_org_bitbake || git clone https://git.openembedded.org/bitbake /opt/workdir/https___git_openembedded_org_bitbake",
-    "python": "pip install ruff pytest && python3 manage.py migrate"
+    "python": "pip install -r requirements-dev.txt && python3 manage.py migrate"
   },
   "remoteEnv": {
     "PYTHONPATH": "/opt/workdir/https___git_openembedded_org_bitbake/lib:${containerEnv:PYTHONPATH}"
diff --git a/README.devel.md b/README.devel.md
index f5b56ec..64106d0 100644
--- a/README.devel.md
+++ b/README.devel.md
@@ -170,10 +170,13 @@ worker, for emails sent from background tasks) instead of being sent.
 
 ## Running the tests
 
-The tests use pytest and pytest-django, which are not in `requirements.txt`:
+The tests use pytest and pytest-django. These and the other development tools
+are pinned in `requirements-dev.txt`, which the dev container and
+`docker/run-tests.sh` install for you. Elsewhere, install them on top of
+`requirements.txt`:
 
 ```sh
-pip install pytest pytest-django
+pip install -r requirements-dev.txt
 ```
 
 To run the full suite as CI does, in the Docker image against a throwaway
diff --git a/docker/run-tests.sh b/docker/run-tests.sh
index e655611..5da56b3 100755
--- a/docker/run-tests.sh
+++ b/docker/run-tests.sh
@@ -31,11 +31,13 @@ docker run --rm --network $NET -u root \
     -e SECRET_KEY=ci-only \
     -e GIT_AUTHOR_NAME=ci -e GIT_AUTHOR_EMAIL=ci@example.com \
     -e GIT_COMMITTER_NAME=ci -e GIT_COMMITTER_EMAIL=ci@example.com \
-    -v "$PWD/tests:/src/tests:ro" -w /opt/layerindex "$IMAGE" sh -ec '
+    -v "$PWD/tests:/src/tests:ro" \
+    -v "$PWD/requirements-dev.txt:/src/requirements-dev.txt:ro" \
+    -w /opt/layerindex "$IMAGE" sh -ec '
         apt-get update -qq && apt-get install -y -qq tree >/dev/null
         cp -r /src/tests /opt/layerindex/
         chown -R layers /opt/layerindex
         su layers -s /bin/sh -c "set -e
             git clone -q https://git.openembedded.org/bitbake /opt/workdir/https___git_openembedded_org_bitbake
-            pip3 install -q --user --no-warn-script-location pytest==9.0.3 pytest-django==4.12.0
+            pip3 install -q --user --no-warn-script-location -r /src/requirements-dev.txt
             python3 -m pytest -rfE -p no:cacheprovider tests/"'
diff --git a/requirements-dev.txt b/requirements-dev.txt
new file mode 100644
index 0000000..489651e
--- /dev/null
+++ b/requirements-dev.txt
@@ -0,0 +1,3 @@
+pytest==9.0.3
+pytest-django==4.12.0
+ruff==0.17.5
-- 
2.34.1

