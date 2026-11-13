Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2205.1794613964065692297
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Nov 2026 15:52:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=TE3eHmMZ;
 spf=pass (domain: gmail.com, ip: 209.85.216.48, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b09c07b3d2so932230a91.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 15:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794613963; x=1795218763; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pGlx74vQoRxhcso24XAv45u3g805RM3SausDEHvcUgw=;
        b=TE3eHmMZtU0m0WM4SAFm4jWvQMpVtlIGkK6M+rmk4HaIl0Z8LTpu+330UqJZUvJkU5
         mFBtUXM8ExqXL4h//UYCmMrp0P+Qc+ZR4zRW4POamAzONtujPS6D1+huwVA4lx5FsFDS
         929LxYSb/fiyU4hDCKnx8mMPk3SPueLtBtPOM6w9Drm6tJr+6K8WSFPJ2FoZ7d+OBiF1
         9YnojDzuPH6+w50oj1345saA72DxaxZaSIrYoF5js1OuJYRbFc37SYd1hVZiSrBm81xl
         IwOGZxo8jrx1hhyYNf9uxp9Msyf7kkI6fH/XuAlcoTTmGuMu6kXlE0BJT+jXk9UQQXKq
         ccfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794613963; x=1795218763;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pGlx74vQoRxhcso24XAv45u3g805RM3SausDEHvcUgw=;
        b=zWAOySnLvB/o3+BKNTJ5jyjt86KJslpqGJXiNYhM/xRktyOLXeYU+WteBPRE6ga/sV
         4ug/4sOOYIR4D5EHGOvR1HlIk6iuXf8IstDTvrLVQZJKvfsP77txuLuBR4e/v2nMcN4F
         g9RH8UYs6A/nrRxLSvhYxxHASIIb29lY1er/Nlowp0rdIV9wL2rDQrRTJZbSZzmkqUe3
         wvRxqrAfir+Rj2cvct23ntZdEuUWrxYoOKFb1i+anLxAd2ZDq05KRW40u7dRKzwOD6pY
         JBNIXbCd01zYw/+getTXE+Ju7aAAECRguP4ZTdmrZffRSly84SM5FvXp6gC3XSL+i9he
         ecUQ==
X-Gm-Message-State: APuU4Z+ONoyLQgiHtI+Nuzc/5PRdn0Jsu2KO+5gkvJDub7GDG+zY+/p5
	NdvpYvA1RsCHZ2WRQx7Ai00nr+67SbKri58B/Xp/aXUvWTOCG4DDV8J/xZ3lICFE
X-Gm-Gg: AYBFou2yvG/oohhV76HouljhU0QTD9UPyrt80PA0JQ7QdKIoMfjd8snxgqgbNHYjZyB
	79lUSXm8Lhh+jU+qurgyIfcCRlysmVxypvMDmv1dDo20f582Mq5xiuY723XDcDoNXNI8fnXOKsW
	7IwtuhX550SdS4iMkaMNwuzgjtNqPgGn31+0MSkC686ASj6c9wvBDLJYvC0K7Baz3Tl6bmXh6uk
	2QK/Y2opz5dO9mh0FqEWucNUBrYFEeJEZQcbk3Qky20mAdiL5CnBFQb7vzSsZfNNQjqY+gqSldy
	Rww/4KxtcRbL/gXWGrXs7jbgCIUOtoBygPiyRjBe2xqNYtiNiQ4hr/tA3Sja+AiRIgP10fZ7Tur
	qjweQG0BsIyDgpDem41DkVnFpxXOOT4tOOjbmUXgHoW0b3jeUSwIIyyWZWlMnZk51NSQJ1SE+T+
	abHeHRWBogUlwH0CtfVnXCMWSMG6dSI0hUujRqLaJ04MwMw6PcSgEZVyo2YXGPVu32AF2j0E5/q
	CBC+ft4SqNhpT7e/rK9+OBnIXQnRlSYEnIv+NRefEmwaSRoV8BESTBlCwRspO97P44yrrn3fU0r
	EqhXvA4yE1Ayga8d6UCGYD2KqIFVSvf4054+Shc0v+hXKaQfow2dOekK++EydU4=
X-Received: by 2002:a17:90b:3848:b0:3ad:a232:403f with SMTP id 98e67ed59e1d1-3b1b0ca326amr4166791a91.56.1794613963148;
        Fri, 13 Nov 2026 15:52:43 -0800 (PST)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1ae8be5adsm6493068a91.0.2026.11.13.15.52.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 15:52:42 -0800 (PST)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH] about: add missing contributors to the credits
Date: Fri, 13 Nov 2026 15:52:36 -0800
Message-ID: <20261113235236.6050-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Nov 2026 23:52:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5344
Content-Type: text/plain; charset="utf-8"

Add everyone with commits in the repository who was not yet listed,
in the order of their first commit, and spell Belén's name as she
signs it.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
Contributors were taken from git shortlog. Belén signs her mail
"Belén"; Jose signs his without an accent, so that is left as it is.

 templates/layerindex/about.html | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/templates/layerindex/about.html b/templates/layerindex/about.html
index 5acba08..5fc0542 100644
--- a/templates/layerindex/about.html
+++ b/templates/layerindex/about.html
@@ -39,7 +39,7 @@
 
 <ul>
 <li>Paul Eggleton</li>
-<li>Belen Barros Pena</li>
+<li>Belén Barros Pena</li>
 <li>Alexandru Damian</li>
 <li>Michael Halstead</li>
 <li>Liam R. Howlett</li>
@@ -53,6 +53,21 @@
 <li>Aníbal Limón</li>
 <li>Amber Elliot</li>
 <li>Tim Orling</li>
+<li>Mariano Lopez</li>
+<li>Alex Franco</li>
+<li>Elliot Smith</li>
+<li>Yi Zhao</li>
+<li>Konrad Scherer</li>
+<li>Terri Oda</li>
+<li>Pranay Mankad</li>
+<li>Meh Mbeh Ida Delphine</li>
+<li>Chee Yang Lee</li>
+<li>Chuck Wolber</li>
+<li>Mathieu Dubois-Briand</li>
+<li>Jean-Pierre Geslin</li>
+<li>Piotr Buliński</li>
+<li>Antonin Godard</li>
+<li>Sandeep Gundlupet Raju</li>
 </ul>
 
 <p>The code is Open Source and can be found on <a href="https://git.yoctoproject.org/layerindex-web/">git.yoctoproject.org</a>. Patches welcome!</p>

base-commit: 08e58cdece30019a6f9e5d14af16ebe20afa6177
-- 
2.56.0

