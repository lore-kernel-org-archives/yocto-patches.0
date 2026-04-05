Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBB0E9D805
	for <webhook@archiver.kernel.org>; Sun,  5 Apr 2026 14:42:28 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.36209.1775400147576068612
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 05 Apr 2026 07:42:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=d7wDIMir;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so2960485e9.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 05 Apr 2026 07:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1775400145; x=1776004945; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X6ALKjTWYy4VsYn5uaYP8qY11/NA2LWCiypChR8qgJ8=;
        b=d7wDIMirOYoT2/XZHVcHkR+X8jsKICIoAI2kgK7O5N4olR5gz734eI/fzgFV8fJZ9d
         QnbxJWS2HDN8kMj0VmCXc1gz3Kp1KbnWQRTZeXUBDXyvKOIa7/9Hk2S8oVdqF2DeiUQD
         lY4WQKgKzqJd9czpQ6KefHzuXOTnwRllwofuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775400145; x=1776004945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X6ALKjTWYy4VsYn5uaYP8qY11/NA2LWCiypChR8qgJ8=;
        b=NEbOcs330SQ8KL461kIMH6wr5gO/xRSluFHjxN9J2TgOtbVZhcS0846LkJQldPQdUi
         TsFiWSr7xEVVWE1CTIupcuUs+dWGFqD9L7ctAQlnmIekJUV9L39IG8N4AJOOhMNiTRoS
         1xq9gv+QpLcc9hSDn6UUMTiFdNxuJHKtlaKAydfnyt4X0UArRlERii/cY4E/cYRUa1bU
         OH/93nhbUE5oxw+/LYW02y+rFId5YCQo5Q0leQwl40c6Ak1vg9qk0FA3CUq7hmmFsGJ1
         ifkn4Zuq+x+C5juMYupLkxkC8sqVImntCmL3zggAh6i8Ww9GvJeW4gTUNWuzQGAe1o6o
         HsDA==
X-Gm-Message-State: AOJu0YwYf9SoBex1mIlTEvT1n3T2/XqD8j98UQ8XaXtcOYcKvPv+4rCz
	sbq7vq2FYAu5UjZR4DgaBfZR96vdeYkoSgrN0u5lkKiF/P6qA2U/mOu/+sF5V04ItNX4JZ6SC3X
	sAYbk
X-Gm-Gg: AeBDiesmNbjsPmlJUTZZgGWDmg0zxp5ZySZyq7//nyj2lmd2U9Cl8JjmPdfef+X0vJP
	orNuyK97jT73mto3iJXxOMf2bD0Xr/JYPW/BfBflZkID3AOPzAWk0oHqkeELzP0Lb3lyej+bgCy
	QQQjST6dUgjzmwcVW5SeU4OKXNHwl7bENfWETfJIaDr0ASrlYtWMfRNhv2Kp89Qr1Nr0D2T1Ugw
	E/FEQA8BRBctCE5ZXGAsvAILH7MJNoCOsuEnA/gN/9Pd6Hu0VZ2LD+QIc0hWnAh28FojiQHeg/o
	WTXCvAzyh9W0zHJ82pqD/u3IMkCjsSdSbcUm9XLfEG6oNCY/pvFmBwwQgijvBDldyq638pAQcb+
	+Y2PkvZ2tdx4wja/BrpuzCHvf32UlSmPdKhZekldaO8vCWFthCs04sfXNBIjyyeEq4bYa0xo5d+
	34u/bEJx88MlEl1/KpKgtSDWOvoVLw2CFKn+TvgcpHgo3GwASGYGp1
X-Received: by 2002:a05:600c:5247:b0:488:b187:3c with SMTP id 5b1f17b1804b1-488b1870244mr6668135e9.14.1775400145216;
        Sun, 05 Apr 2026 07:42:25 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:5e42:a555:17a8:9bbc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a9242d63sm80626895e9.13.2026.04.05.07.42.24
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 07:42:24 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic] [PATCH 2/2] wic/engine: Simplify search paths
Date: Sun,  5 Apr 2026 15:42:22 +0100
Message-ID: <20260405144222.3733875-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260405144222.3733875-1-richard.purdie@linuxfoundation.org>
References: <20260405144222.3733875-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 05 Apr 2026 14:42:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3643

Drop "wic" and "scripts/lib/wic/canned-wks" as search paths and just use "files/wic"
as the default location for files. Also use BBPATH, not BBLAYERS, which aligns with
the search paths in OE-Core's classes by default.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 src/wic/engine.py | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/src/wic/engine.py b/src/wic/engine.py
index 3612017..dcc3527 100644
--- a/src/wic/engine.py
+++ b/src/wic/engine.py
@@ -43,24 +43,14 @@ def verify_build_env():
     return True
 
 
-CANNED_IMAGE_DIR = "lib/wic/canned-wks" # relative to scripts
-SCRIPTS_CANNED_IMAGE_DIR = "scripts/" + CANNED_IMAGE_DIR
-WIC_DIR = "wic"
-WIC_FILES_DIR = "files/wic"
-
 def build_canned_image_list(path):
-    layers_path = get_bitbake_var("BBLAYERS")
+    bbpath = (get_bitbake_var("BBPATH") or "").split(":")
     canned_wks_layer_dirs = []
 
-    if layers_path is not None:
-        for layer_path in layers_path.split():
-            for wks_path in (WIC_FILES_DIR, WIC_DIR, SCRIPTS_CANNED_IMAGE_DIR):
-                cpath = os.path.join(layer_path, wks_path)
-                if os.path.isdir(cpath):
-                    canned_wks_layer_dirs.append(cpath)
-
-    cpath = os.path.join(path, CANNED_IMAGE_DIR)
-    canned_wks_layer_dirs.append(cpath)
+    for layer_path in bbpath:
+        cpath = os.path.join(layer_path, 'files', 'wic')
+        if os.path.isdir(cpath):
+            canned_wks_layer_dirs.append(cpath)
 
     return canned_wks_layer_dirs
 

