Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3227.1794617411131339129
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 16:50:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=wUQfI7mp;
 spf=pass (domain: gmail.com, ip: 209.85.216.44, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b08cf16decso832720a91.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 16:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794617410; x=1795222210; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=itEFWd03zb92uX2upywOgrmiNOhU9daAI6HhFbeRHpQ=;
        b=wUQfI7mpWtVNvTc0cqZiIv0jav8zusrQoBAu5n/i/DAz/71rktpyuyRPZSZZJtOpu8
         +EyQn6Qcv7UnU7hQRFF3Wvt9ehmZEcFuNjo0neI3hzCeKBOsK659khabDLQxy+358ynI
         EJaR6yt+UXfz8yI/h3hPTDKP1Lh6ABqRZnD0c98bvyBV7ZpLcrfGvpBTpjt2+MVOJkit
         PssMj5ailTu3eqJtqKVv777vgg0M7kTUo7yhlIsV9rN/SFAQXu9jFZUOHm/mMryPmu6s
         F3nCShx7CYfO0ddv4OPnJpUvGbMsbKbYXjudVpFLCc2+xVOI0NwVrGaJgLswFWeW9ezg
         0vPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794617410; x=1795222210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=itEFWd03zb92uX2upywOgrmiNOhU9daAI6HhFbeRHpQ=;
        b=y+/KwEgGdguceYSsBLAl8VakLR7JRYa3A5SQFB34kHhi1hZA8Z3P9snSwHMbj0HqvR
         Jm/xxkd1FrLC1Vc6fC8GJjRMDwPiWB+J8f62QBkjxit5eKIz3YfUs89/l3Kl06y+5AFy
         vZu5fRI+/1sVPeTv2ClMyVMW8nx/YpyfgqIHh7LdVDYTHpmLJSUfGsDYXI88KYebniJC
         SpFOWtPeXnWyhnTUdjFdv/SOZ3XhWA27rZMtL9gbApGrwKihP1+efftqStZNegWXZXL+
         kI7AhkjLaMJRgxx13LHhxMEAs0USHdzaNl4v1WCdHUUCSN2bIcxYHcjIonwMoY7Lu9uK
         ELYw==
X-Gm-Message-State: APuU4Z+KEK8FFZSHmnR+bSeayfkHMR9h7NQ6QAwszb5FXcnpF1gwZUUI
	XocZrMbOJyWBcREpzr3EoyK4PzvrI7dQeOWP8KT4cphqzcLyk64UgFJtuVLp4A==
X-Gm-Gg: AYBFou355jLIxveJ6VgACfzZnaHCumgrsQegj+vy2rQXmapA/AuP2lWv74WCeiPTDk/
	WOGgWn8Fp2VfDskePyzSSB8ZYvdIq1wnPE0stG1gJvNyarHrEDG5rvjqvo5ukOoHZ+pmhkMbjWP
	fYOCLRT7HnYhoM7AZbQbMEMTb1LTbgjhG/GrUgEnpfHh+2AWH8TIb3WmzfV9vzNTE8Sx5uEhYU+
	M++UVKft/HP5obmOXMRuOc3AF1ozWb4z7nnNPMBHvLMqvmLxwYtDpBrAPLVMRZiLdHgKxXS9pqX
	UkRTG4SYwn7e3dspHWw2vRsWYK9+mB0SZnyZ9/5qrKNAtKlT4TJQcH3KY+aDTh84trqWgX0Ckxw
	2Qeg1gshTIdOqSD3glNN2BsML1UwWGow1zK6nVWkAXxg0SxJ/wWZfE2oYhuvYFkK3FoLPqrdIzX
	Tl5cwUAi5xNSdrD6vcqBUYgVNlwZ5h+Ir8BIXmSS4TXtMh+m84RtcYZOo17jcxytYtm3jiV8pfD
	C9+/8O7Yqxnbp+i3u8CmfO7glmD8Dqozh4snrXyZQPkYTml+1uA5ppH33inv9XYBBTdd8FPQrrf
	j6Ds8b/WaG5qxybpUcAGwyS15OxvGgEAdvIw7QL5Tge0myVmyPQcn16lYkUpfgzsr4koyPVatZu
	S+FZOT9Ui
X-Received: by 2002:a17:90b:5687:b0:3b0:91ce:672e with SMTP id 98e67ed59e1d1-3b1b0a407d6mr4097112a91.17.1794617410407;
        Fri, 13 Nov 2026 16:50:10 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197ce55c1sm11790295a91.3.2026.11.13.16.50.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 16:50:09 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: mhalstead@linuxfoundation.org,
	Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][RFC PATCH 0/2] uWSGI, and a docker-compose setup with nginx-proxy
Date: Fri, 13 Nov 2026 16:50:04 -0800
Message-ID: <20261114005006.28193-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 14 Nov 2026 00:50:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5350
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

Tested: the test suite passes in the image (75 passed, 1 skipped);
uWSGI starts, serves static files and stops cleanly on SIGTERM; and
the nginx-proxy setup serves pages and static files over HTTP locally.
The test instance has run uWSGI behind nginx-proxy, with Let's
Encrypt, since October.

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
 docker-compose.nginx-proxy.yml | 90 ++++++++++++++++++++++++++++++++++
 4 files changed, 119 insertions(+), 5 deletions(-)
 create mode 100644 .env.prod.proxy
 create mode 100644 docker-compose.nginx-proxy.yml


base-commit: 08e58cdece30019a6f9e5d14af16ebe20afa6177
-- 
2.56.0

