Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB56FCCF2C4
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 22:03:43 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22624.1792361018642726266
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 18 Oct 2026 15:03:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=l8JoYwhN;
 spf=pass (domain: gmail.com, ip: 209.85.216.42, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ac6794fe45so1267335a91.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 15:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792361018; x=1792965818; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1dCUqZxHM9wIKo/TMeLgyvZ/EkqtlILk+rliCBRQVvg=;
        b=l8JoYwhNGNxIXnRESyRzswQim8LuRhIXDjvPcrjN41U8JjrgMoffXitNPp+6jm4BOL
         gGOAOQNBy/sVoelXG4b6RdbY6pyyGm4AAw6LXUX+vF3EeVRq4LCKLk9m3wrROKCv+TVW
         atbc5tin8Wp5eexjnfQq4iSQuyN5rUpK9RBbUQCCev1Ac1rYn/CNvSljBh97UVQ9NDf6
         6T/omT811ZdhWdD8JqQ35fP3yUsacFzCI8GkGo1sS70nbtWD2pLuFxdYL2zexEiOSknG
         Wm8GzT5ryogq7CN/+lj+3tTeZRh+WEKXr1Gq4WvRpqU5lBGddZyoZX56YSnvrbAS+Nst
         Dssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792361018; x=1792965818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1dCUqZxHM9wIKo/TMeLgyvZ/EkqtlILk+rliCBRQVvg=;
        b=cgJ2yHQz3Qz1FohuQrdC6EHEVhp9StDI4uMLHmkMYeqalld/5AGFcjFpHD8wcZBu4j
         Cg1W1MWpxgaWiWnD/b7rnykMc9BN20+UPbch7X1ahVNXqyF5u8CbKrHHP0hXI8/dDp7i
         Zcq9BlaOeu4MOI/DPVPuXUbSMMsOPal9HAPTNNkWj7fPhGHGpxV7uf+IKslrz2NqmK8R
         4nL3Sm3boYeWAqiYStXCj5AdOdeQfdALEcNul5K0gGdr+iMYvk+jGQmYb3+zcnzLeS7I
         2z0qfuq49PDhAXePRtcKcniR8gG8cnfG2+ecsXJdLYaudiLOY52x0z6h2eSCAEe8T8ql
         ioyQ==
X-Gm-Message-State: AFq9FYJTvJDe9Se9DWMMbfJo0h6HtqU+OD4xb0Tn5rw8pCVH95cTjB+p
	u+1wz5uLvOGHLGpy6XdiHXMGB5ipm2FfgNiY2nhvTjs4Nwz3lkx93V80lwUa9Vj1
X-Gm-Gg: AYBFou3fbpdCoJ3g0zT5Shj6NKajGLvuKOtKMnbnugry+G6pjmk/B/clWQl80Bhc8Yg
	6t3yW6PDem63uo0E7/+1ZZXvjQtUKHo24qClItV5i/bE8QGbOZF5ZWUFfv1+idxqwN0fYTmWqjw
	OkLvQ5X4Wg4huCauXaEi9sF0OS/XKMz8soGIhnFv0p7Jk4vQM+TkNaF5sOvMyiIe6uSGo37HqCb
	7G1rs9n3qzX6r5mY5vGFeVZQXZEoHz9skdnlKhujKuizDXiDsABa/D2XWVw53gaLWoVxt3W0N5Y
	X9SkMvgYg7Dt6UmSri7wK0aWk8rrGtuekkLVret9mMawQQyBhgVIsbUT4zaCcSldBCkQVSQGcDd
	cP7yg1sd0VAiiIAcM+9zf0KNJIsQp3zdCqCLN/mI1mEUSb9aqxgoZxfEjGFZN/CgKF8euTgC1fa
	XvWfWomMhxssIpAXDBNdswDl2Q1e5CWizpbZjqux6D7wy5LgpBLuRkbZv4K0LhsHnka2wwgR2Xi
	yv3tNsLEBsHqjWePckyxAQmthi9RdI=
X-Received: by 2002:a17:90a:e7d2:b0:3ac:a204:aa27 with SMTP id 98e67ed59e1d1-3acef55d72cmr5587440a91.66.1792361017865;
        Sun, 18 Oct 2026 15:03:37 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac945e72c6sm17714440a91.5.2026.10.18.15.03.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 15:03:37 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 09/10] README.md: use "docker compose"
Date: Sun, 18 Oct 2026 15:03:07 -0700
Message-ID: <20261018220308.72731-10-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018220308.72731-1-tim.orling@konsulko.com>
References: <20261018220308.72731-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 22:03:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5091

Ask for Docker with the Compose plugin rather than docker-compose, and
use "docker compose" in the example commands. Current Docker installs
provide only the plugin; dockersetup.py now uses it, falling back to
the standalone docker-compose.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 README.md | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/README.md b/README.md
index e53ddfa..a34457f 100644
--- a/README.md
+++ b/README.md
@@ -29,12 +29,13 @@ containers, and do the initial database setup. It is advised that you start
 with a .sql database file to prepopulate your database. The following
 instructions will walk you through the setup.
 
-1. Install docker and docker-compose per instructions:
+1. Install Docker Engine (or Docker Desktop) with the Compose plugin, which
+   provides the `docker compose` command, per instructions:
 
    https://docs.docker.com/compose/install/
 
-   **Note:** for latest docker-compose version follow the directions above,
-   rather than using a perhaps outdated one provided by your distribution.
+   `dockersetup.py` uses `docker compose`, or the older standalone
+   `docker-compose` if the plugin is not installed.
 
 2. Run the setup script (`dockersetup.py`). You can optionally supply your
    hostname, proxy settings, a sql database file of layer mappings to import,
@@ -135,7 +136,7 @@ setup within it:
    public instance at layers.openembedded.org you can run the following:
 
    ```sh
-   docker-compose run --rm layersapp /opt/layerindex/layerindex/tools/import_layers.py https://layers.openembedded.org
+   docker compose run --rm layersapp /opt/layerindex/layerindex/tools/import_layers.py https://layers.openembedded.org
    ```
 
    Alternatively, you can populate the database manually -
@@ -205,21 +206,21 @@ following:
 Incremental update:
 
 ```sh
-docker-compose run --rm layersapp /opt/layerindex/layerindex/update.py
+docker compose run --rm layersapp /opt/layerindex/layerindex/update.py
 ```
 
 Reload all data (should only be needed if the database structure has
 changed as part of an upgrade of the application code):
 
 ```sh
-docker-compose run --rm layersapp /opt/layerindex/layerindex/update.py -r
+docker compose run --rm layersapp /opt/layerindex/layerindex/update.py -r
 ```
 
 Alternatively, you can update the data from an existing layer index instance
 (as per above during setup):
 
 ```sh
-docker-compose run --rm layersapp /opt/layerindex/layerindex/tools/import_layers.py https://layers.openembedded.org
+docker compose run --rm layersapp /opt/layerindex/layerindex/tools/import_layers.py https://layers.openembedded.org
 ```
 
 
@@ -430,7 +431,7 @@ Some things to be aware of from a security perspective:
   backend you can run the following command:
 
   ```sh
-  docker-compose exec layersapp /opt/layerindex/manage.py changepassword <username>
+  docker compose exec layersapp /opt/layerindex/manage.py changepassword <username>
   ```
 
 - The web-based password reset function will ask the user answers to
@@ -463,7 +464,7 @@ Some things to be aware of from a security perspective:
     immediately using the following command:
 
     ```sh
-    docker-compose exec layersapp /opt/layerindex/manage.py axes_reset
+    docker compose exec layersapp /opt/layerindex/manage.py axes_reset
     ```
 
     If you wish to disable this, remove or comment out "axes" in
@@ -488,14 +489,14 @@ following command (no need to substitute `${MYSQL_ROOT_PASSWORD}`, it's
 already present within the container environment):
 
 ```sh
-docker-compose exec layersdb /bin/sh -c '/usr/bin/mariadb-dump -u root --password=${MYSQL_ROOT_PASSWORD} --max_allowed_packet=512M layersdb' | gzip > backup-`date +%Y_%m_%d_%H%M`.sql.gz
+docker compose exec layersdb /bin/sh -c '/usr/bin/mariadb-dump -u root --password=${MYSQL_ROOT_PASSWORD} --max_allowed_packet=512M layersdb' | gzip > backup-`date +%Y_%m_%d_%H%M`.sql.gz
 ```
 
 To restore one of these backups you would run the following command (take
 care, this will overwrite the data immediately without prompting!):
 
 ```sh
-zcat backupfile.sql.gz | docker-compose exec -T layersdb /bin/sh -c '/usr/bin/mariadb -u root --password=${MYSQL_ROOT_PASSWORD} layersdb'
+zcat backupfile.sql.gz | docker compose exec -T layersdb /bin/sh -c '/usr/bin/mariadb -u root --password=${MYSQL_ROOT_PASSWORD} layersdb'
 ```
 
 
-- 
2.56.0


