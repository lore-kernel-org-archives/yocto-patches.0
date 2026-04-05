Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE925E9D804
	for <webhook@archiver.kernel.org>; Sun,  5 Apr 2026 14:42:28 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.36074.1775400146724718027
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 05 Apr 2026 07:42:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=T6zwDXW6;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso7340875e9.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 05 Apr 2026 07:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1775400145; x=1776004945; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SlpNnoAVBLSpW/QeJkWXeLBvnKiRh4FN5iiNNzmSULA=;
        b=T6zwDXW6Lufz6N936sXR93A8iZJghWwxeMwXY6FQHEBM0J1kLVCf6Qqd7GTI8KSbW1
         AoTPpzVpK6cYEmyVIjCwvcdIfHxeM8p52G6WgwOYLYUh4gURnk5Yl8+kWge2J4GkgQm8
         zAGSYEy7CtR8m4HfRnbn0Vu19bhNhCWZklB90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775400145; x=1776004945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SlpNnoAVBLSpW/QeJkWXeLBvnKiRh4FN5iiNNzmSULA=;
        b=kaAmBqN+QYjlXzQpZ2m0zGfvfDcOhXE319z7srSvD9NeTtEkzQm00Fu+xPjHWpyNO3
         NF0RySlHkmziF1yYM+Q7IYyZs02YhacJ9qjkl9zD+FVtv5diwCMilO6F2INYKiAF1Yt5
         9vJdMOm7byQYpdUYpBGsQhiz/qX8aGCO/qYCqfbcPkHb/sq9HgegU/lZv+NU+NSxqqm2
         Mixtauu0fhoVCuIJkl2hOqrnrWLKMGSpcfyvTPK9FhZH5PWtgcUmSQM+XQHJwTUvi3vh
         ds93ao7o7IuMkW6D9T9TQZOdWprOIgUcIE3a69O1YJk0Yyd6bsYuPHoyyXYvdmxHshSg
         zXiQ==
X-Gm-Message-State: AOJu0YwhmIlhcIqJuiqNS28GnOhx+0UsYUJE3HD9Uu78wzqDBNC6fIIs
	cse/L1Gt8Zwpp9dc0itY1RUB5EtsiHVUiVt3kMg7qaHlxv7SJNCqJQhuqJlOoLiiS6aN3kgrT3A
	dlVlu
X-Gm-Gg: AeBDieuYSqWKVeR4cLWKmdmHbHDuTxKzoAfECGWbdOrwmFAlY/CKSuoMpuvKDDpFA+1
	0OSVPWLtFTBQaVz1nIlerk6sa985Ncf7ZkhKUgR4u11SuTgPzPaouZOKcbXfz1IyGqq/lZJuTvV
	OROQs+5vjkFeUHjF7ZfpgQHn8HvPNz8czgcpi4qWoTIQoaNRXKPZBqgEhjcLbycRWJ/iXu3rhHd
	ohkVUUUrCwHGxhxLUV6TO11si2gVFp9+kUqN/T/UqPOOQgekRWefiZ4zSkMWlM8AP3o7+i87tmB
	R/YCH8yHHp6fLargyih6DBs0xt3HNwl+s/TbLMGD0md7y9ZAVbWUbPWViwoBEES/i/CcoIIMd7T
	DIIatEg7QhkbJRI5HkD1ytdPLOPYv5Lmv9Ly+M78pu2Xd7S0IK9g3xrgOBEtehnT/zazVcZHGb/
	Mdp8PtoxONLbHf2fqE8zINqyaa7NU/lqjaWuz4BDzu+Skk7erTe1Jc
X-Received: by 2002:a05:600c:1d1c:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-488997d1392mr142483865e9.16.1775400144344;
        Sun, 05 Apr 2026 07:42:24 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:5e42:a555:17a8:9bbc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a9242d63sm80626895e9.13.2026.04.05.07.42.23
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 07:42:23 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic] [PATCH 1/2] wic/engine: Add files/wic to the search path
Date: Sun,  5 Apr 2026 15:42:21 +0100
Message-ID: <20260405144222.3733875-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 05 Apr 2026 14:42:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3642

Going forward, "files/wic" is the logical place for layers to place wic
files to fit in with usual layer file layouts. Add this to the search
path.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 src/wic/engine.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/wic/engine.py b/src/wic/engine.py
index e12eee8..3612017 100644
--- a/src/wic/engine.py
+++ b/src/wic/engine.py
@@ -46,6 +46,7 @@ def verify_build_env():
 CANNED_IMAGE_DIR = "lib/wic/canned-wks" # relative to scripts
 SCRIPTS_CANNED_IMAGE_DIR = "scripts/" + CANNED_IMAGE_DIR
 WIC_DIR = "wic"
+WIC_FILES_DIR = "files/wic"
 
 def build_canned_image_list(path):
     layers_path = get_bitbake_var("BBLAYERS")
@@ -53,7 +54,7 @@ def build_canned_image_list(path):
 
     if layers_path is not None:
         for layer_path in layers_path.split():
-            for wks_path in (WIC_DIR, SCRIPTS_CANNED_IMAGE_DIR):
+            for wks_path in (WIC_FILES_DIR, WIC_DIR, SCRIPTS_CANNED_IMAGE_DIR):
                 cpath = os.path.join(layer_path, wks_path)
                 if os.path.isdir(cpath):
                     canned_wks_layer_dirs.append(cpath)

