Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4C3CCA490
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 22:03:43 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22528.1792361014741398185
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 18 Oct 2026 15:03:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=NputjcU2;
 spf=pass (domain: gmail.com, ip: 209.85.216.42, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ac6794fe45so1267321a91.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 15:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792361014; x=1792965814; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3imi8wcbzPfsOeZnt2hFIRAbxNtFiuhb0dG1ZSpHnyQ=;
        b=NputjcU2SFBScSycSeNXSoS/HSkZYGmXHrvGI15y4nTH0BvOCNLcJ8m0vDxTCbVt7q
         hc0wfWD5+C5Hrtu/hjsxCODyt7wswpWerhMX/g6VrSyCN4ZnBj8LOk9x5AvP8R7O9zn8
         Mj5ijn1+c/tBUq7c78WMY3r9zF1PvQMTHbp+tgkB13xRuBCgVFxvT34MuYYyfH4LxQR7
         OukVK/YYC/I892GCTSEEYF2On7MVKm8HmzCkaJ969j/kug3YxmDkmf6tmhspGOdIt/ut
         oJKv5zMrXqzWJ5fsQdB8mNnGpSUvUOfLz0nIO0ymRvZzybRMjuqr3n/P9ZS3NHuvPyl9
         hveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792361014; x=1792965814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3imi8wcbzPfsOeZnt2hFIRAbxNtFiuhb0dG1ZSpHnyQ=;
        b=Dt3MZxXgtPy71h7zRu0oU98+23AyeZJa/xL5tgQUdJIj9gCEFoAQja3uxTeBi+M+Yq
         v8w6wGiwUSQT04oPmezRr1YCGUoJRrKYjxQAtNSpWL17xY+4W8zrS8i/V1jP88bPwi5f
         CFGFq8GGwwLgGJylH83exyPHqj58dHV7wV7WDiwHkGy4VvKKcBIPzL/dMq13o6ZOuSCc
         ayW2AWV1ZcDRWH8FNNOJz2l2eaC2P+K2VyLy7fR3EW+s8bi6yYfPF66VRPQgbNq/ts09
         BfQT0ef8v2ifo1QnZJuhtVjmP4S9D8uwEEiCPPvvs0nBCWwID0LnJ8i0/k/2ssQjFBqH
         0/Tw==
X-Gm-Message-State: AFq9FYLFA1AVefIBNWLrBHicpWPgRJO8GnOBUGxrQ19+un7b9gW1wZe5
	UPYgGsvWg1V72Q+VB0vQ3+oyoQNvpjFehzhe+Xe5iwbJhZw9o0yVTvVD8TB9lg==
X-Gm-Gg: AYBFou3xOSxwCj/47k9v/3rusfPooGONs9ONw6XeWZK62RER89ZBE9quSGL7S3K4nu4
	cdkKgwymhlT6bnSWCA9nVs1d7dvOhI4uLuiGqT4Tl8d/ihIIYXl13j/jcu0QhZG+ruNGi9CBPR9
	KHirE85vEUdIRz/iYa+JvBpFPM8beAjQIaqKqosSTj99DSsN/GPn2ZipGqmm9xB/tuLAQVJMKRh
	jGIViQhAhtYSGb7EYCsoPDr6jtaimPbQR5BddYOI1VNV8T1VYP6UE7llf33CPxmcb+k4+EG20P9
	P/a2OZGfmJNTn+JH9/AB2hfu4Ctne7HYyInOn0MWFxD2CY/Z2LHjupnvF/wKR33FJZYGHlUjXPa
	sO/2w0akAH81OGTmh5rhjVpAv4BCRzXVFlHybp3ZvXVTEM2mA0B6xf/UktroH9JGdS0VH/AvrLX
	BBLis2ySKwttDj//QHtF+53GI8/oS+knIUige/WwcqHM6vEANMtWgzI0ViukN0SK9VM4fDY0Ubn
	4QMtajvlHplGI/F6wwXUsLbElAiDwo=
X-Received: by 2002:a17:90a:e7ca:b0:3a8:878:ebab with SMTP id 98e67ed59e1d1-3acef0c8905mr5377809a91.35.1792361014026;
        Sun, 18 Oct 2026 15:03:34 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac945e72c6sm17714440a91.5.2026.10.18.15.03.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 15:03:31 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 08/10] README.md: fix the REST API note, a JSON example and a typo
Date: Sun, 18 Oct 2026 15:03:06 -0700
Message-ID: <20261018220308.72731-9-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018220308.72731-1-tim.orling@konsulko.com>
References: <20261018220308.72731-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 22:03:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5090

The security notes said the REST API had been disabled because it has
no access controls. It is enabled: it is read-only, needs no login and
serves the published layer data, including maintainer email addresses,
to tools such as bitbake-layers layerindex-fetch and Toaster. Say so.

Also add the missing quote in the /etc/docker/daemon.json example and
drop a doubled "the".

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 README.md | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/README.md b/README.md
index d33bb5d..e53ddfa 100644
--- a/README.md
+++ b/README.md
@@ -121,7 +121,7 @@ Other settings the app and celery files can set:
   `/etc/docker/daemon.json`:
 
   ```json
-  {"dns": ["xx.xx.xx.xx] }
+  {"dns": ["xx.xx.xx.xx"]}
   ```
 
 
@@ -473,12 +473,12 @@ Some things to be aware of from a security perspective:
 
   - By account for too many incorrect password reset attempts. To remove
     this lockout, log into the admin interface, go to Users, click on the
-    the user, tick the Active checkbox and then save.
+    user, tick the Active checkbox and then save.
 
-- The REST API inherited from the OpenEmbedded layerindex upon which this
-  application is based has been disabled, since it has no access controls
-  on querying data (since the OE layer index operates entirely on publicly
-  accessible information, whereas this application may not in actual usage).
+- The REST API at `/layerindex/api/` is read-only and needs no login. It
+  serves the same information as the public web pages for published layers,
+  including the names and email addresses of layer maintainers, and is used
+  by tools such as `bitbake-layers layerindex-fetch` and Toaster.
 
 
 ## Backup and restore
-- 
2.56.0


