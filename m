Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B700BCCF2C7
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 02:01:36 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8016.1792288888169968203
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 19:01:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=qFR918Ew;
 spf=pass (domain: gmail.com, ip: 209.85.216.47, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso621226a91.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 19:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792288887; x=1792893687; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ThuZ+l/+P9HkB7TktU+zlPcrD7NmmBTlyOwFF5IcQFw=;
        b=qFR918Ews7tH3rV7TlzBDTqC6RKQwAzNDlVXmWJOI3jQsOoCzFn0pYSoz/rRV/7Gvm
         Wz2oWUXdVsYC2mTTqp4SnZyMAi3lnXWWBeI3BRfwsUX4512SO4RBBSSZvlrVq0KJYfUs
         26GLK6no6YMeYxrqjF6YPG9NAZGfkNMUwWLn5ztap/tKcVmmNuBsJ1N3ECNFDTtZLVYu
         PGFwqwLlvoDM1xhi5LgUO7/Ig/ZRTiZ73GY77Va+J5REA/iQVJ3ChpCCQqnR/jjlRKZK
         SaWh2mta2rWn/MHFiJaldak4aYhW9iRkqIiTagzIKxzCqP+YJ/o3UYN6ihtUXT8w2oR8
         1I5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792288887; x=1792893687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ThuZ+l/+P9HkB7TktU+zlPcrD7NmmBTlyOwFF5IcQFw=;
        b=lSs/zG0uYqxE/xWl8e5QpE+F4RVhKNFy4picdzXdCB6XgzG11hn6fUBs+ugSd/7SmD
         AMLRlhLU/q3gdWxg+3pIDkHuiWZEu+LA0Y0kSYTxa/cOAmKCtEsA4y3DwjwdOIhdbdf8
         AWzusKo9zebkyU9ZI3xTPTn35YI7eMAA4aQrLZY/51Qa0oQhiV9fAAkAZyaphu/cqG7W
         xFwdMoauTORmfQcJqXfvytSzfSuLtdBDTVnJUx1+2SSaLxJeCoa9WNjlcdpJPeHXZI2r
         rPaZOeXIcJzs0DvZFBch/PYHC9TxtUu/bKY2t1O+3FpZVPPcqYnHC0Q5x2MEhT2TQum+
         a4ww==
X-Gm-Message-State: AFq9FYLiYlyv24Nw2Rs/wlWoV1N8nyDZOBIn4Mx4GuXFVDFqH/AC9+Gw
	lY3ix8iqtSTsZghvqBE22hS2ZXhe3YtZCyj8eWDZTdHxBDggkLWsVUb8x9rVEWlh
X-Gm-Gg: AYBFou3zyQn5TlbGSlehW2XWAqO3m4Vauw51GnHzPdbQpzFV+u6ARugLugPtXkw8NX5
	AIech5+5SHUMSkkBTdtF9rd5eGrCeEKQKpCBIqHtoj1W7hiYWGSPlD5WU0BIf4ESzdmfdi7di4U
	euWKvxJ0DKwOGEDasNPqNt/y7uGXbKRJBYjMpojaIyCDo/zFt27QwN+95JG/RgbPzESoQ7hEIQx
	Qx5IwRo8FIfmMO2QZUqQgXU5NkflrFRLxvaiY+8SVVB3pEbtyEDNwTLx7k7SeFdOWNOUG7OqxZf
	mmrCyf12X6frs/HI3FNyw5scoWZsp9BSneYUDiY5UItAekfGzsg5xOp0X1El9TYgv3nsAEh5j0o
	9ZxEME9r/URsyx2ggiXxsznePGa0BgWrM8cQ5zxCiUyxhTvRufOmoPRQ0tbkz6bgj4lX3oO4tS2
	LZbFFvWq1YnS4BXoZZCvBNp4M8CE6fo6RBZ1u5MzhSsGmq7PM/eZtW+lhWaB/hhQYby1xoFvSRE
	RjsoIpOHLhIz6rEf5/4rDgs7SvZX14=
X-Received: by 2002:a17:90b:57ec:b0:3ac:6fcf:81a2 with SMTP id 98e67ed59e1d1-3acef5c49bbmr3440794a91.57.1792288887267;
        Sat, 17 Oct 2026 19:01:27 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac947928b4sm14569131a91.11.2026.10.17.19.01.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 19:01:23 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [error-report-web][PATCH 0/4] Deploy with gunicorn behind nginx
Date: Sat, 17 Oct 2026 18:57:03 -0700
Message-ID: <20261018020116.75276-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 02:01:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5061

Align docker-compose with layerindex-web and deploy with gunicorn
behind an nginx reverse-proxy. We may move to uwsgi (better handles
static pages) and Caddy (better handles Let's Encrypt certs) in the
future, but for now set up better best practices.

Move the .env setup to dev, prod and staging flavors. The difference
between prod and staging is that Let's Encrypt staging server is
used for staging.

Add docker/nginx*.conf, similar to what is in layerindex-web and
provide a settings.py.docker example file.

We may need to align settings.py better with production, but for
now this is an improvement.

Tim Orling (4):
  Run gunicorn behind nginx in docker-compose.
  Add staging and production docker-compose setups with env files.
  Add a VS Code devcontainer.
  Remove the obsolete .env.

 .devcontainer/devcontainer.json      | 63 ++++++++++++++++++++++++
 .devcontainer/docker-compose.dev.yml | 15 ++++++
 .dockerignore                        |  2 +
 .env                                 |  5 --
 .env.dev.app                         |  8 ++++
 .env.dev.db                          |  5 ++
 .env.prod.app                        |  9 ++++
 .env.prod.db                         |  6 +++
 .env.staging.app                     |  9 ++++
 .env.staging.db                      |  6 +++
 .gitignore                           |  1 +
 Dockerfile                           |  2 +-
 README                               | 39 +++++++++++++++
 docker-compose.prod.yaml             | 55 +++++++++++++++++++++
 docker-compose.staging.yaml          | 55 +++++++++++++++++++++
 docker-compose.yaml                  | 32 ++++++++-----
 docker/nginx-ssl.conf                | 72 ++++++++++++++++++++++++++++
 docker/nginx.conf                    | 49 +++++++++++++++++++
 project/settings.py.docker           |  3 +-
 19 files changed, 418 insertions(+), 18 deletions(-)
 create mode 100644 .devcontainer/devcontainer.json
 create mode 100644 .devcontainer/docker-compose.dev.yml
 delete mode 100644 .env
 create mode 100644 .env.dev.app
 create mode 100644 .env.dev.db
 create mode 100644 .env.prod.app
 create mode 100644 .env.prod.db
 create mode 100644 .env.staging.app
 create mode 100644 .env.staging.db
 create mode 100644 docker-compose.prod.yaml
 create mode 100644 docker-compose.staging.yaml
 create mode 100644 docker/nginx-ssl.conf
 create mode 100644 docker/nginx.conf


base-commit: 752b7188d04c2fd0e2f32f0cd2dd437c43058d82
prerequisite-patch-id: 9c9d012e1163dd1d335531d0451657823f17eb64
prerequisite-patch-id: ddb4df3e54736ed25846f91d4918299e601f4071
prerequisite-patch-id: ab69f4aa494291611cbe0e916f18b07f4aeebe57
prerequisite-patch-id: ac2b802ea065536df3854c48e265f5508d201cff
prerequisite-patch-id: 81a7de0e9568848efc8c66d397abb5f56218db95
prerequisite-patch-id: cf32dcaef20903890a020211a35f46b2384207da
prerequisite-patch-id: 6920bc5c70071bbd42b55b08bfc2bff04133c3ab
prerequisite-patch-id: a72bee4356db80ccb45321967d18081961f60860
prerequisite-patch-id: a2285b682329ba20d838085588b7c6681a86d273
prerequisite-patch-id: c3980e46d49b00b419cf4a7c2bc32c346478a453
prerequisite-patch-id: 627f58daa68852066f56558f08b07ad4af7bef9f
prerequisite-patch-id: 2d1b78495c909de035dbed74af06db5683701d1b
prerequisite-patch-id: 028165edb39ba03ad70f83ae9e2f36dff8c7e912
-- 
2.56.0


