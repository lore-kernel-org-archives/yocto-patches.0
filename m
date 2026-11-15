Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13007.1794770282333611945
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Nov 2026 11:18:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=JFzllBk3;
 spf=pass (domain: gmail.com, ip: 209.85.216.54, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ae1b34e0d2so1936025a91.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Nov 2026 11:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794770282; x=1795375082; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0me1NXNynjQtxomwy+23PKKcg498urhTRT0vCo6wvaE=;
        b=JFzllBk3oDaRXwfO2eFEO3Ahh/OjjbHTPsiAv6OpLHMHzr9Lt9AAtkmYFcifgWJS4d
         hnRKTuY+mpaNaPkXxfvy5vXTxH1h6EPqr/0elHwDVMAIJsCD3URV/qUntZV+Z6zP0RcR
         4RVLBcROQfAxqKb04NrsVmzNmDiTICF/ozsFa3o9ToG6kdENBu2MXUMJjjQVu2Im9QF8
         vnXBLqPyhELozLhrK2tNZ4zsKG31IM1ooebeB2gM82ikAj4DJaWRYEin7x3bwBONhYDN
         8zXyQJj3elTFowTSUV2Y8Wf4PV7iZgiIhgmK75/Zsn+c/YymKnsNt73Wl6euBmZMywBZ
         mcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794770282; x=1795375082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0me1NXNynjQtxomwy+23PKKcg498urhTRT0vCo6wvaE=;
        b=C6xdOLPcfQ91z5tnLQIw6ybb4gwa38yRFJEsgLD6Kdl0gBP6ubfq5mg9MSls0PQag9
         ntesq3BFSypOy2jrC4ZbnoOjDmvARUDUs1t0dyHH4X97IA5IsPK4zOd6hsviBEyL23sM
         8I5K1AfwHVHfDNzXihMtZpRMLfGEw5lK0nQmLTjk+tJX1YYkTVfmW2PB4RweCe9V0p8t
         wmMCnVnVDf9Y+M6fFXomOxI/j7NWmqWU3eklzWXC9YrUSQEsidommRNPWm2cWJBZt09y
         BCbsDSFM2YPVbxnleOHZuc7tLcwVSZNKJoivM6QBTjknwHf+8hleHHM3PgA+UEueq2h1
         p75Q==
X-Gm-Message-State: APuU4Z+SAu5dvXEqBdrOzAhUWbQcXBI2rIJFM5+KlpDIT6xzma4d5avS
	bkhi0dzzmsiXBhfxKgbS7OQAfsIQOemayn0pVSmM62kiS4ykh28OqUTya32dwA==
X-Gm-Gg: AYBFou08A4f50sk7EjBRLKh4qNUcyC+9/2zd+3fLuKg7n4CZ1SJDWc30kpD+kP+1zCm
	TS5wIIwU0SJmx86R/U8GvdeAHf6vMkthLbwMsAYPjJfwWEOJjD8Mfag2XAhkFCBI6GyTaTM6rVt
	xvTsL7/1Nhcn1WwhQhZ8CdV8Jx0PpyMKIHjkdYMOG2cM+8GnXqe2xguI7Ltn2k/VKdh95IvO1rf
	t23xc9WolBDs0KdLCv7uOtFstWRSkeKEoKyeYPogYH9tfql4d01wbP2A2lkfEkNx2IpRwnf0Q7K
	RrKmXAY1QZZSf7b4/NDTBjAi3a1nwMoviAVDGBhddH+4+4sZkoPjBo+BY6KySmVz7uedwmGEKO2
	JjDuXns2Y/TtdED6PPXLDgWU8B6D4CFGl91usurPS69KU1h65Ct3+Mwgd1Jm5fc9yv0UC+VHPUy
	CrELigQ3KyKMRBZAVytWKmLHkuGhBJ44pRicCwqnq2nGxcjxkZMvwMjEBAyENfQBJMS8LUyWbwp
	cAKc752J9eZ0mdKlBL/nNqS/riRubarkDtKcRDKMaPGGSNo2ghkSzigbcMbige7Z5VGPExWcJ6u
	LkLCkeM3FP24x7I9MzB3dwOsv7wAwTTOz8idr6MR1MFFeoVoDzb5H0dxOHz3dnXvAoJQrttyewd
	gt7E7GAk=
X-Received: by 2002:a17:90b:3a47:b0:3ac:860e:1af9 with SMTP id 98e67ed59e1d1-3b1b0d7e539mr6417844a91.41.1794770281604;
        Sun, 15 Nov 2026 11:18:01 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c6dd2dsm17977070a91.2.2026.11.15.11.17.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Nov 2026 11:18:00 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][RFC PATCH v2 0/2] uWSGI, and a docker-compose setup with nginx-proxy
Date: Sun, 15 Nov 2026 11:17:32 -0800
Message-ID: <20261115191734.23604-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Nov 2026 19:18:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5395
Content-Type: text/plain; charset="utf-8"

This is an RFC: I run the layer index test instance I use for these
patches this way, and would like to know if this is useful upstream,
and in particular whether the production site would use it.

1: Serves the application with uWSGI instead of gunicorn. uWSGI speaks
   HTTP, so the existing nginx configurations are unchanged. It also
   serves the static files, now collected into the image at build time.
2: Adds docker-compose.nginx-proxy.yml, with nginx-proxy and
   acme-companion in place of the layersweb (nginx) and layerscertbot
   containers: the certificate is obtained and renewed automatically,
   with no hand-edited nginx configuration. The existing compose files
   are unchanged.

Patch 1 can be taken on its own; patch 2 needs it for the static
files.

This series is based on "docker-compose: run layersapp with an init
process", sent separately, which isn't an RFC.

Changes in v2:
- 2: layersapp runs with "init: true", as in the other compose files
  after the patch above, and the compose file test covers
  docker-compose.nginx-proxy.yml too.

Tested: the test suite passes in the image; the test instance has run
uWSGI behind nginx-proxy, with Let's Encrypt, since October.

Open questions:
- Should uWSGI replace gunicorn, or be an option?
- dockersetup.py does not know about the nginx-proxy setup; should it?
- The test instance also waits for the database and runs migrate and
  collectstatic when the container starts, instead of in
  dockersetup.py. I left that out; is it wanted?

Tim Orling (2):
  Dockerfile: serve the application with uWSGI
  docker-compose.nginx-proxy.yml: add a production setup using
    nginx-proxy

 .env.prod.proxy                |  7 +++
 Dockerfile                     | 15 ++++--
 README.md                      | 12 +++++
 docker-compose.nginx-proxy.yml | 93 ++++++++++++++++++++++++++++++++++
 tests/test_dockersetup.py      |  3 +-
 5 files changed, 124 insertions(+), 6 deletions(-)
 create mode 100644 .env.prod.proxy
 create mode 100644 docker-compose.nginx-proxy.yml


base-commit: 08e58cdece30019a6f9e5d14af16ebe20afa6177
prerequisite-patch-id: 4ad6ed99d0c42ce111a25d4731d953218337e7cc
-- 
2.56.1

