Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12878.1794770097428424455
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Nov 2026 11:14:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=DTC3bP8a;
 spf=pass (domain: gmail.com, ip: 209.85.210.172, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8b3577deeb0so1262252b3a.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Nov 2026 11:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794770097; x=1795374897; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vKZSlaO8h3JLr3qJUPOUlHh+TvPiz+Zxjmkw7IqGAe8=;
        b=DTC3bP8ansAbchyTjmI6jma2edifJ60O8bOUuTPPxbtAfL7HlTTuOrKuE/Tk0V03Fe
         YMcvfABhfQBTdm4elxe4QL1N+DwjwqndpkHTeP1VNfxZS4poXVZA4UXKAbifQib77FnK
         J8ThNlHkQ9LOLA+3Bm3ThT/6wq9Wufkdlr7WNVjncXw2XBEnXL2vdR960AX4juHK1vuc
         CpkpyginyGdv158VoUAFC7k1QKjMGbLxw7WIH3b+u+3yWv7/KCZymiZ/E/QCaXgGjJI2
         aKocE5gmPu59Z/Fx51I64jSIhqggZ3KmpPDHZI57p4oqNAo0Nj7b3h3LZtpiCPySnHD0
         nWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794770097; x=1795374897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vKZSlaO8h3JLr3qJUPOUlHh+TvPiz+Zxjmkw7IqGAe8=;
        b=BkkpdgaIQj8rJhZp8M/9TU1fMH/R4ZuVjbiA9g2jACp2gHAMfguoUM5RAeIyEousTl
         RAC7KE6yZ5a9epvu9/Ib93vhCdtapVQ/58ftaF5s0nYaIKrPS9G/bwkXiXIB1K1ZarI4
         AIgBEqEsICfyZmhS3LhX2TDdZgp+vi8wJHklEw9Ek5ge/hHE4/oe2WTTjmuwK0oARIfa
         cSzbQNLnAOcAKCdcg5bj3u7V89xPgxK0f+CCmfEJmA6HckwyufSo50VZM1AdtdKD5sFK
         Wu0bthF8favAXJ3+ImHfBm8ldfQvltpPPUYotpE46OYs8AqWFziRFtCTYQDefHVK8Hoi
         n1/g==
X-Gm-Message-State: APuU4Z/ENONWPz9CKFZcMxXyEve7iBkWtecsn6hZjVyd+IJJRCTtoV5T
	GM+BlFbZTOJ3HkN9ydreIJTdYXIF8yLWbEedp0ROnChBe2vF4WZWy7usIntheg==
X-Gm-Gg: AYBFou3vDaUyEu8NtbWRK7o2yPscF6CcB477A4pH5pMbYDoyVI0ihlbi79kZZCsSAib
	eJHtNxbXqD4Lv5okuwnXEa11/hSpMRO8iecZoxZh5MF029f1FyPL1D8QbRm3P+ATH0QmZCdosp7
	23Un/HxkXR00uO5dbbrfA16gn3wvooVkM9VL15QpyOu8Rlx5T3Ordtz3/Juvi5gb53dc5kCfFeW
	fc84YN3JOA+VjOk6F+xobBXESKtc1FOsOgEPZAXYZP4f2e7gRpxj0hG9TqSQ6o2OhPP2bsiH6yi
	Fm7PyhDg/v7i8ZpNuh2vjDKkk+2gjKxU+7z4zTOTFiPTGMTaA+p+jzTiJGKc+wIW7HbrxzcjRMS
	mKVDm/WxHsTP6kNlJvVJi+i7PNAqWa/0Zt2ol35KBHU7bLyTvmcTnbf65RaskDq8MfdQXAjA14r
	Hov1mHcnyxFPGoIXqV9gkeL7EO4HL0JWh7vNKaeMwW+j1gQ9eRzAo2wKPXnnNr4uKD+0L2CldLu
	+bmC2twhLA3pQP79371j2yEaXRMVqQ5J56bq95+prCXENGFGh9u0NhY6hkWOhxQFAYJuibTJ2TF
	rc9korOdFSK9CGfyNIbSJRFwnt71Gtx7MVZB5uHwVkf2o0cBXv0Rj3h7FtdLrA==
X-Received: by 2002:a05:6a00:13aa:b0:874:705d:f63e with SMTP id d2e1a72fcca58-8beb63a251dmr7287454b3a.32.1794770096627;
        Sun, 15 Nov 2026 11:14:56 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2b190bfsm2789510b3a.50.2026.11.15.11.14.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Nov 2026 11:14:54 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH] docker-compose: run layersapp with an init process
Date: Sun, 15 Nov 2026 11:14:27 -0800
Message-ID: <20261115191426.23332-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Nov 2026 19:15:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5394
Content-Type: text/plain; charset="utf-8"

In "docker compose run --rm layersapp .../update.py", and likewise for
the RRS tools, the script is process 1. Recipe parsing starts a bitbake
server that outlives the parse, and with no init process to reap it, it
stays as a zombie. A long run can then reach the container's process
limit, after which every parse fails with "Resource temporarily
unavailable". This happened to the RRS upgrade history on a test
instance after about 3400 commits. Set "init: true" so that Docker's
init reaps them; dockersetup.py copies the line unchanged.

layerscelery doesn't need it: celery, as process 1, already reaps
orphaned processes.

[YOCTO #16515]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 docker-compose.prod.yml    |  3 +++
 docker-compose.staging.yml |  3 +++
 docker-compose.yml         |  3 +++
 tests/test_dockersetup.py  | 17 +++++++++++++++++
 4 files changed, 26 insertions(+)

diff --git a/docker-compose.prod.yml b/docker-compose.prod.yml
index c8ec3fd..e779f72 100644
--- a/docker-compose.prod.yml
+++ b/docker-compose.prod.yml
@@ -13,6 +13,9 @@ services:
       - layersdb
     build: .
     image: halstead/layerindex-app
+    # "docker compose run" of update.py and the RRS tools: reap the
+    # bitbake servers that recipe parsing leaves behind
+    init: true
     hostname: localhost
     volumes:
      - layersmeta:/opt/workdir
diff --git a/docker-compose.staging.yml b/docker-compose.staging.yml
index 80ceef6..7365bcf 100644
--- a/docker-compose.staging.yml
+++ b/docker-compose.staging.yml
@@ -13,6 +13,9 @@ services:
       - layersdb
     build: .
     image: halstead/layerindex-app
+    # "docker compose run" of update.py and the RRS tools: reap the
+    # bitbake servers that recipe parsing leaves behind
+    init: true
     hostname: localhost
     volumes:
      - layersmeta:/opt/workdir
diff --git a/docker-compose.yml b/docker-compose.yml
index bafa64d..ab9c865 100644
--- a/docker-compose.yml
+++ b/docker-compose.yml
@@ -10,6 +10,9 @@ services:
       - layersdb
     build: .
     image: halstead/layerindex-app
+    # "docker compose run" of update.py and the RRS tools: reap the
+    # bitbake servers that recipe parsing leaves behind
+    init: true
     hostname: localhost
     volumes:
      - layersmeta:/opt/workdir
diff --git a/tests/test_dockersetup.py b/tests/test_dockersetup.py
index 0109c80..4d61ee7 100644
--- a/tests/test_dockersetup.py
+++ b/tests/test_dockersetup.py
@@ -200,3 +200,20 @@ def test_compose_command(monkeypatch, result, expected):
         assert calls == [['docker', 'compose', 'version']]
     finally:
         dockersetup.compose_command.cache_clear()
+
+
+@pytest.mark.parametrize('compose_file', ['docker-compose.yml', 'docker-compose.prod.yml',
+                                          'docker-compose.staging.yml'])
+def test_compose_layersapp_has_init(compose_file):
+    # [YOCTO #16515] in "docker compose run --rm layersapp ..." the script is
+    # process 1; without an init process the bitbake servers started by
+    # recipe parsing stay as zombies until the container's process limit is hit
+    with open(os.path.join(basepath, compose_file)) as f:
+        services = yaml.safe_load(f)['services']
+    assert services['layersapp'].get('init') is True
+
+
+def test_compose_keeps_init(workdir):
+    dockersetup.edit_dockercompose('layers.example.com', '8080:80,8081:443', False)
+    services = load_compose(workdir)['services']
+    assert services['layersapp']['init'] is True
-- 
2.56.1

