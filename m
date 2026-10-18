Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AB7CCF2C9
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 21:42:13 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22274.1792359723018867163
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 18 Oct 2026 14:42:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=AcFzUy51;
 spf=pass (domain: gmail.com, ip: 209.85.214.172, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e987b4a710so11176005ad.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 14:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792359722; x=1792964522; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QiHWvpKYZj4oLnSnFMq/rF6V9Elh/d70t9SayG8NwE0=;
        b=AcFzUy51D9hcM98lapZX7I4ZbiiSPrevV1+oqc06LZBtktKp1Jn/aKt+e+B8ULtMgB
         r+XppsDjU6XnMCNcJ/Pkbm+U7qAYKJoVatgoHa74HQq9zNEGPQVj4pl59N2ox/lTGGzs
         CuY6SVUKrGbm+MGKGBHyw0dpHNFg4rYDpoyKIOoeFrwBLCZq4jfRuGJG0UvvSlhq4eI0
         FWrp2rM3i7AUTwPffue0nDgcxb4VzLq4uaYRpLp8+vyTobkmv3EP+QVulukG12ZoW4dg
         qyyh+Cio0EhtviEj/lMFYl2UQelD3GF034g6seJnVyasLnjXHdjbVJiKICfFjAGM3iz4
         BhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792359722; x=1792964522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QiHWvpKYZj4oLnSnFMq/rF6V9Elh/d70t9SayG8NwE0=;
        b=X7dHzuCvIz2NX2vWZ7jcD30o2zM2uUsvCHH2APJBjocWf1TcsqgqLOlRZp8Lb6/rTu
         zDh54CmpMbb6faEWZYmNCtvzotlXTOoC3V9BfXBtS5DcblCOgwElsIYEzcLgBjc26FLE
         OpnRY6hL9vikJKjSkiXjWMP2bssoAi4qrY5YAbvQOu7ASpkaE9FAmGtQucQHlnouo1tW
         EGiJB61sOIhEm6Guhqqq9CuvhVIbIPqQq/eFHSUurDMtNg4IsstMqMvIqRa5Szf9MZZ2
         Omwwg/tuw6aUUIKqYxfhxGC1J5tdVIbeZFYoAuh4Nmqym8aGEEO1AyT7uvRaa1UjtUAn
         oEdg==
X-Gm-Message-State: AFq9FYJwlrIQtMbmAkGyMUFCYADzXI5GllTK/Cvj+4lsYADobdIwot0l
	yEZbAuk9A0CFhDHVuUf9kMbXAFDjicySLctXrttLavIR1pvwuOrfB60QMov6otfO
X-Gm-Gg: AYBFou2iAC/9EUVqPS3krq7GUtTEJiV0P0b2uBfcL4oc/JDn5qHEItA+ZqnLcU+4GIg
	0mu95kz5/hThlC/CADqfImSQ+dSU12QGT4v50Hs4e+pauKJADgddLzAxkhn5+PuRDSkb7+V/6jM
	R3CWwm6I7Y/d4G/03mlsGxM9913qtP5qSbwrXOxuNs8PcR2PqAbkLrgLuvezHK9+mpEm373GutX
	v6aDedfOSWvzpCfk723s++kll/j2IFApBuQWCbf7vpiCfXan9hlok+JD2CuKx9mDkaJ3+FtPXkW
	fm/G2lU3nold03VGeq8RX2U/E8ZH07PDq0bsZPHlXuIrAhs6zh13RKDZ9GHWI3v81KXU1ZQihbj
	Qj6qet8Dm0OFMebsuaQL3DzAxgjQMc+iSms1boAQeibmlBfUnrIZ22UOPyzEcPSF9lyfjppK0M/
	kcsD5FA4JsXQkdXNCfyE9dEzOf+wyeYDpjpaDX8lHNPBrmsZc1YCSkb4th7XimI6ny7BQUFrBMH
	88I4EMDjIO6kDgZyj3Dx6cE2kKEFPR+qhpryAYOJw==
X-Received: by 2002:a17:903:388f:b0:2e8:7a31:58f3 with SMTP id d9443c01a7336-2e9a6a071b2mr35296515ad.19.1792359722278;
        Sun, 18 Oct 2026 14:42:02 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e9d3fa9ffdsm9004155ad.58.2026.10.18.14.41.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 14:42:00 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 2/4] docker: set X-Forwarded-Proto in the nginx configs
Date: Sun, 18 Oct 2026 14:41:44 -0700
Message-ID: <20261018214146.67856-3-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018214146.67856-1-tim.orling@konsulko.com>
References: <20261018214146.67856-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 21:42:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5074

docker/settings.py sets SECURE_PROXY_SSL_HEADER to trust
X-Forwarded-Proto, but nginx never sent it, so Django treated every
request as plain HTTP even when served over HTTPS: request.is_secure()
was false and absolute URLs it built used http://. Set it from $scheme,
which also overwrites any value the client sends.

This also fixes the 403 on login when the site is served on a
non-default HTTPS port such as https://localhost:8081: Django now sees
the request as secure, so the browser's Origin matches the request
without listing the port in CSRF_TRUSTED_ORIGINS.

Fixes [YOCTO #15329]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 docker/nginx-ssl.conf | 2 ++
 docker/nginx.conf     | 1 +
 2 files changed, 3 insertions(+)

diff --git a/docker/nginx-ssl.conf b/docker/nginx-ssl.conf
index 9776b8f..75f01ee 100644
--- a/docker/nginx-ssl.conf
+++ b/docker/nginx-ssl.conf
@@ -70,6 +70,7 @@ http {
 
         location @proxy_to_app {
             proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
+            proxy_set_header X-Forwarded-Proto $scheme;
             proxy_set_header Host $http_host;
             proxy_redirect off;
 
@@ -132,6 +133,7 @@ http {
 
         location @proxy_to_app {
             proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
+            proxy_set_header X-Forwarded-Proto $scheme;
             proxy_set_header Host $http_host;
             proxy_redirect off;
 
diff --git a/docker/nginx.conf b/docker/nginx.conf
index eda3474..0a47a1c 100644
--- a/docker/nginx.conf
+++ b/docker/nginx.conf
@@ -37,6 +37,7 @@ http {
 
         location @proxy_to_app {
             proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
+            proxy_set_header X-Forwarded-Proto $scheme;
             proxy_set_header Host $http_host;
             proxy_redirect off;
 
-- 
2.56.0


