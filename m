Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301E1CCF2C9
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 21:49:13 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22360.1792360144769433463
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 18 Oct 2026 14:49:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=qVc9vqIJ;
 spf=pass (domain: gmail.com, ip: 209.85.210.170, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a05f2d5cd3so256889b3a.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 14:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792360144; x=1792964944; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0p8YMojJp75qu7Gb0juMvyOJ8ohUjuzJSQUrWK5ZQvs=;
        b=qVc9vqIJO9XNGdhKUuvRoNqwLh4qjnL8aHlzH4whykwlRts/8eI9lzP0J5b50X72Eu
         ccCdE305XIpLAa67VhY/CM59sdCavTNdmNYIRVBU7jUv1crP5YmzwfWg3WWCAbpGHWMH
         Qb9DQHxKng3mUxOaXFVUEugFCm9I2Gh7yuET8lXKCbPQpGSvUXqAesU5jHHwqjEnIbyJ
         LLVxnX6+B4xk2Kcj11i/MkyOm1IEs3cyqwUKaFXIgg/kBQ7+t8fO2azUPS4QCy5NXzrE
         EFeDRu2LFAyyYxt6pvb5Mv54ioTTck1yRh2ba5CGGWNGIKYGOzgbCAzusd9ArtgnV4xa
         gZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792360144; x=1792964944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0p8YMojJp75qu7Gb0juMvyOJ8ohUjuzJSQUrWK5ZQvs=;
        b=b+S6Q+C+cHi0HuR+2AQJEPW70PIfuYjPymQLrIbzz1h11zjo6dIEpdUanLRkbYd+hi
         n+hPP5lHi5E7qgLsmAHSTdJwJjGku8aD3fOzr2uEJomw7FWjXDcUug3kouokSAqZjSR0
         vYfvbmJvZqxTTMakOcFsBel2EWPczykZXFi2QsrZOlNtSpKG+U/Hh7fqnDX0cyS67GgO
         oSlwEHExOdDSDmyom/D++tJoJE4kC1XuXLerRRSKpz0UPoAff2xz93g7iZdhheERl183
         ChVmFpsqqcQbmibAvqmf5K47teD1bn3UGLCjzX8j6sWWhMxaT46EuiUA1AucNYR8tas7
         7RXg==
X-Gm-Message-State: AFq9FYLEN7apxvkM3wyfkMY7aEtYlImJ6c8xaBieVmebvAnWIEplmKx7
	329MvG0sdNQ4iULLTeh568IUVpORD4Bni2BUMWUsGVj+WOCtaBNjfWL+AMifjfBH
X-Gm-Gg: AYBFou24RVn517EV3f6YF1kMTO+q4n6v41n1eP1x+xqb8NHmhd0ShwIDMHIJ5NlPv0E
	qi9c8XN6zY5LWcpxk4ETGm2Mh58bfWjyBvbXU79y/ufN29CT8xluyOXgJTfdclpT/UxoYkVuXe9
	gQG1e+NXeBisGHcgMNPZ6Rvn7xSiKEvBGojdlXEVt9ghXsh38Vw4gSCZMQOJC4VAwmalpKHkzd4
	FsVqHoOz6jYWphVneGQOhIIkr4faTmMhGrsfNLKvJfS5VX+ZPn7k69m+o4lFWfj8aOvQxmjqMFb
	LMI110KheI1riO2qRP/BfIlx6+0tSIEg9iuWYlSC9Pi0I0xfaX9vdz7RKF7nOlPZ5WXe/kxOiuz
	fd3URMkP/9VJIjeAF6tadNDYF232p7bBvfgfE1/7O+9DIvN6z8sdplFItiYNKozzpY6DvVVONRR
	sPCh2BDurnZgd4lc1hkVuj35wqSd/Ll8DsEHpThClH2nxbcVMPORQdg9+91Y7Y+q8Ea2MBFwESy
	7Zxz07iOdjO8O9H08d4BNJqkPBq/h0=
X-Received: by 2002:a05:6a20:6a23:b0:3de:52c4:50bd with SMTP id adf61e73a8af0-3e225ae1709mr4531599637.0.1792360143818;
        Sun, 18 Oct 2026 14:49:03 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a04493551csm2010759b3a.44.2026.10.18.14.49.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 14:49:02 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 2/3] tests: add tests for the files dockersetup.py writes
Date: Sun, 18 Oct 2026 14:48:46 -0700
Message-ID: <20261018214847.69431-3-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018214847.69431-1-tim.orling@konsulko.com>
References: <20261018214847.69431-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 21:49:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5079

Check, against copies of the tracked files, that dockersetup.py:
- writes the generated secrets to .env.local.* with mode 0600, leaving
  unset email settings commented out and the .env.dev.* files alone
- points docker-compose.yml at the .env.local.* files, sets the hostname
  and port mapping, and enables certbot only for Let's Encrypt
- reads the database root password back for update mode, including from
  installations made before .env.local.db existed
- sets and clears the proxy settings in the Dockerfile and git proxy
- writes an nginx SSL config it can read back

The Docker image doesn't contain dockersetup.py or those files, so the
tests are skipped by docker/run-tests.sh and run by a separate CI job on
the host, which needs only pytest and PyYAML.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 .github/workflows/ci.yml  |  13 ++++
 tests/test_dockersetup.py | 158 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 171 insertions(+)
 create mode 100644 tests/test_dockersetup.py

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index 74405ac..76a4cf9 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -20,3 +20,16 @@ jobs:
 
       - name: Build image and run tests
         run: docker/run-tests.sh
+
+  dockersetup:
+    runs-on: ubuntu-latest
+    timeout-minutes: 10
+    steps:
+      - uses: actions/checkout@v5
+
+      # dockersetup.py runs on the host, not in the image
+      - name: Test dockersetup.py
+        run: |
+          python3 -m venv /tmp/venv
+          /tmp/venv/bin/pip install -q pytest PyYAML
+          /tmp/venv/bin/python -m pytest -rs -p no:cacheprovider tests/test_dockersetup.py
diff --git a/tests/test_dockersetup.py b/tests/test_dockersetup.py
new file mode 100644
index 0000000..3a6d8ff
--- /dev/null
+++ b/tests/test_dockersetup.py
@@ -0,0 +1,158 @@
+# layerindex-web - tests for the file editing done by dockersetup.py
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+
+import os
+import shutil
+import stat
+
+import pytest
+import yaml
+
+# The Docker image doesn't contain dockersetup.py or the files it edits, so
+# these tests are skipped by docker/run-tests.sh; CI runs them on the host.
+dockersetup = pytest.importorskip('dockersetup')
+
+basepath = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
+
+TRACKED_FILES = [
+    'docker-compose.yml',
+    '.env.dev.app', '.env.dev.celery', '.env.dev.db', '.env.dev.rabbit',
+    'Dockerfile',
+    'docker/git-proxy', 'docker/.gitconfig', 'docker/nginx-ssl.conf',
+]
+
+
+@pytest.fixture
+def workdir(tmp_path, monkeypatch):
+    """A copy of the files dockersetup.py edits, as the current directory."""
+    for name in TRACKED_FILES:
+        dest = tmp_path / name
+        dest.parent.mkdir(parents=True, exist_ok=True)
+        shutil.copy(os.path.join(basepath, name), dest)
+    monkeypatch.chdir(tmp_path)
+    return tmp_path
+
+
+def read_env(path):
+    values = {}
+    for line in path.read_text().splitlines():
+        if line and not line.startswith('#'):
+            key, value = line.split('=', 1)
+            values[key] = value
+    return values
+
+
+def write_env_files(email_host=None, email_tls=False):
+    dockersetup.write_service_env_files('dbpw', 'rootpw', 'sekrit', 'mqpw', email_host, None,
+                                        None, None, False, email_tls)
+
+
+def test_env_files_get_generated_secrets(workdir):
+    write_env_files(email_host='smtp.example.com', email_tls=True)
+
+    app = read_env(workdir / '.env.local.app')
+    assert app['SECRET_KEY'] == 'sekrit'
+    assert app['DATABASE_USER'] == 'layers'
+    assert app['DATABASE_PASSWORD'] == 'dbpw'
+    assert app['RABBITMQ_DEFAULT_USER'] == 'layermq'
+    assert app['RABBITMQ_DEFAULT_PASS'] == 'mqpw'
+    assert app['EMAIL_HOST'] == 'smtp.example.com'
+    assert app['EMAIL_USE_TLS'] == 'True'
+    assert app['DEBUG'] == '0'
+    assert read_env(workdir / '.env.local.celery')['DATABASE_PASSWORD'] == 'dbpw'
+    assert read_env(workdir / '.env.local.db')['MYSQL_ROOT_PASSWORD'] == 'rootpw'
+    assert read_env(workdir / '.env.local.rabbit') == {'RABBITMQ_DEFAULT_USER': 'layermq',
+                                                       'RABBITMQ_DEFAULT_PASS': 'mqpw'}
+
+
+def test_env_files_are_private_and_leave_unset_email_commented(workdir):
+    write_env_files()
+    for service in ('app', 'celery', 'db', 'rabbit'):
+        path = workdir / ('.env.local.' + service)
+        assert stat.S_IMODE(path.stat().st_mode) == 0o600
+        assert 'not secret' not in path.read_text()
+    app = read_env(workdir / '.env.local.app')
+    assert 'EMAIL_HOST' not in app
+    assert 'EMAIL_USE_TLS' not in app
+    # The tracked defaults are left alone
+    assert read_env(workdir / '.env.dev.db')['MYSQL_ROOT_PASSWORD'] == 'testingpw'
+
+
+def load_compose(workdir):
+    return yaml.safe_load((workdir / 'docker-compose.yml').read_text())
+
+
+def test_compose_uses_local_env_files(workdir):
+    dockersetup.edit_dockercompose('layers.example.com', '8080:80,8081:443', False)
+    services = load_compose(workdir)['services']
+    for service, env in (('layersdb', 'db'), ('layersapp', 'app'),
+                         ('layersrabbit', 'rabbit'), ('layerscelery', 'celery')):
+        assert services[service]['env_file'] == ['.env.local.' + env]
+    assert services['layersapp']['hostname'] == 'layers.example.com'
+    assert services['layersweb']['ports'] == ['8080:80', '8081:443']
+    assert 'layerscertbot' not in services
+
+
+def test_compose_enables_certbot_for_letsencrypt(workdir):
+    dockersetup.edit_dockercompose('layers.example.com', '80:80,443:443', True)
+    services = load_compose(workdir)['services']
+    assert 'layerscertbot' in services
+    assert './docker/certs:/etc/letsencrypt' in services['layerscertbot']['volumes']
+    assert './docker/certs:/etc/letsencrypt' in services['layersweb']['volumes']
+
+
+def test_read_db_root_password(workdir):
+    assert dockersetup.read_db_root_password() == 'testingpw'
+    # Installations made before .env.local.db kept it in docker-compose.yml
+    compose = workdir / 'docker-compose.yml'
+    compose.write_text(compose.read_text() + '    environment:\n     - "MYSQL_ROOT_PASSWORD=oldpw"\n')
+    assert dockersetup.read_db_root_password() == 'oldpw'
+    write_env_files()
+    assert dockersetup.read_db_root_password() == 'rootpw'
+
+
+def test_dockerfile_proxy(workdir):
+    dockersetup.edit_dockerfile('http://proxy:3128', 'http://proxy:3128', 'localhost')
+    text = (workdir / 'Dockerfile').read_text()
+    assert 'ENV http_proxy http://proxy:3128\n' in text
+    assert 'ENV no_proxy localhost\n' in text
+    dockersetup.edit_dockerfile('', '', '')
+    lines = (workdir / 'Dockerfile').read_text().splitlines()
+    assert not [line for line in lines if line.startswith(('ENV http_proxy', 'ENV https_proxy', 'ENV no_proxy'))]
+
+
+@pytest.mark.parametrize('no_proxy, expected', [
+    ('localhost,.example.com', 'localhost|*.example.com'),
+    ('10.0.0.0/8,192.168.1.0/24,10.1.2.3/32', '10.*|192.168.1.*|10.1.2.3'),
+    ('172.16.0.0/12', ''),
+])
+def test_convert_no_proxy(no_proxy, expected):
+    assert dockersetup.convert_no_proxy(no_proxy) == expected
+
+
+def test_gitproxy(workdir):
+    dockersetup.edit_gitproxy('socks.example.com', '1080', 'localhost,.example.com')
+    proxy = (workdir / 'docker' / 'git-proxy').read_text()
+    assert 'PROXY=socks.example.com\n' in proxy
+    assert 'PORT=1080\n' in proxy
+    assert '    localhost|*.example.com)\n' in proxy
+    gitconfig = (workdir / 'docker' / '.gitconfig').read_text()
+    assert any('gitproxy' in line and not line.lstrip().startswith('#') for line in gitconfig.splitlines())
+
+    dockersetup.edit_gitproxy('', '', '')
+    gitconfig = (workdir / 'docker' / '.gitconfig').read_text()
+    assert all(line.lstrip().startswith('#') for line in gitconfig.splitlines() if 'gitproxy' in line)
+
+
+def test_nginx_ssl_conf_round_trip(workdir):
+    dockersetup.edit_nginx_ssl_conf('layers.example.com', '8081', '/opt/cert', 'cert.pem', 'key.pem')
+    edited = (workdir / 'docker' / 'nginx-ssl-edited.conf').read_text()
+    assert 'ssl_dhparam /opt/cert/dhparam.pem;' in edited
+    assert 'layers.openembedded.org' not in edited
+    # The template is left alone, so the hostname can be replaced again
+    assert 'layers.openembedded.org' in (workdir / 'docker' / 'nginx-ssl.conf').read_text()
+    assert dockersetup.read_nginx_ssl_conf('/opt/cert') == \
+        ('layers.example.com', '8081', '/opt/cert', 'cert.pem', 'key.pem')
-- 
2.56.0


