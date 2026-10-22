Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20854.1792669227241848796
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 22 Oct 2026 04:40:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FGD51skf;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a2001dd4e7so18483805e9.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 22 Oct 2026 04:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792669225; x=1793274025; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jWNpUmWviKrSa20fj5Qw8KSHf4DNVbcCAXBBPEPOE9U=;
        b=FGD51skffLswEVM2AWLwYn9jnkPIF4mg5ws/kA1xNJLohERKGPwf+PWnKeIFqGWHi5
         EabPnZFmNqkKzOfPWNdJpb5k92CnaH89hDkRyRzNDeOIPdbI/WshT6abUQuf1UKe8Bb1
         pCiy9os8b4QnczLeOLZnQjY2+xTHt4gGi8uv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792669225; x=1793274025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jWNpUmWviKrSa20fj5Qw8KSHf4DNVbcCAXBBPEPOE9U=;
        b=Vd4RS6RlGqxaWAWAXppObhddRgrJ/NDczZmnwe7RjgZwgrfX7+uEOZL6G3LYpo0lvP
         vgC82N/GVWeVb6Qv74SJtobLz/D894jjkEZUK24rWJ/pb9GlFpjv5wKVyk5ktyl0kZ4F
         vFE9XI2DEZronLueQP5yCPyxPEwiF8rHpL9wtI9qqY5jg7JRyg3DVHialWNSaGmBG+Ke
         o3bYAxPALPJqg1nQf62sVd58nCUNBbxcqGDZQzG2wERgNt19wMT8E247MMIEGWTVNrsc
         vf1RT+tkXHhnG8mhnq4s0Oc8IMvAlxF5YQPKq/5/NCnSqYTkH9yuZu4wXMY0QMxtFTvI
         Rjhg==
X-Gm-Message-State: AFq9FYLy1gKHTrFpCWb863VUtKg6H45/6p7CUKH37ovA3HLb6OAZr5c5
	JBSAZqcy1dncHXDeQTuaFWKGRC8XvGBREx3dzm/nekObxyr54QCKTJKOFPfpSqtg5WTn3IuV/uX
	VlqUH/9g=
X-Gm-Gg: AYBFou0aL9U5KeouJki96ugQnvv+QKSMThfAEYoMI9l5Z0jshaW+DkUI6+FM0vXseZX
	oujY+8STq+jDwKKdCV4MH5XHqWAoPYm8jftw830SIr2FViEdggqceQSJJyPIfOyemlQ7o8ujpFL
	49EVcm451SzvCrGizUN7AsN9CG21i9HO0ap6953OGqPi0nhbhAfo0XXDhNUWx8dzqWh9SJJD1m7
	oJPAusQfxhdfK5ODH3P2tPrPOTY0Zjv51BGlYkkWKc8pQv2MIpwpzeMsxA2YVn5FaqwjCZ+tCxC
	G/yQgy69+/4MBI2ZMisWWuxnOuUNuioiggkIQrHyoXSZvxNMtf8oj497iPQiW135YYJpDdihZjS
	T+O4MILvyGjY7vPQ7z6exuZsZXTCNmxHGMAqEyoaRscd4BCXCUenC5DLLvv/Mjj4naNAejNobUo
	X7t5PpUXeOtRvspbn3JDj/0EZ4VIGLfxznY/cXAZcw+njsEHFd5tqIKGn5zfTmLm8REaJAcEHVC
	mNZVXG02uRK2xCQY8y/x6VBwoZce6WVWXRa+aWcJu8MGe96RgUJik/4XiOwAIFq6S+pLcKFoiYl
	HRMHIXrg
X-Received: by 2002:a05:600c:3115:b0:4a1:fba8:b13d with SMTP id 5b1f17b1804b1-4a1fdaf7457mr102379565e9.9.1792669224969;
        Thu, 22 Oct 2026 04:40:24 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:b8c1:c201:8aca:1e39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203a3e9ddsm60237625e9.11.2026.10.22.04.40.23
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 04:40:24 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH 1/2] config: Add meta-ti target
Date: Thu, 22 Oct 2026 12:40:21 +0100
Message-ID: <20261022114023.3540668-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 22 Oct 2026 11:40:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5131
Content-Type: text/plain; charset="utf-8"

This has a dependency on meta-arm.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/config.py b/config.py
index 3a36e723..a2b43d82 100644
--- a/config.py
+++ b/config.py
@@ -20,6 +20,7 @@ buildertorepos = {
     "meta-aws": baserepos + ["meta-aws", "meta-openembedded"],
     "meta-qcom": baserepos + ["meta-qcom", "mixin-wrynose-linux-firmware"],
     "meta-clang": baserepos + ["meta-clang"],
+    "meta-ti": baserepos + ["meta-arm", "meta-ti"],
     "buildtools-docs": baserepos + ["meta-openembedded"],
     "qemuarm-oecore": ["oecore", "bitbake"],
     "checkuri": baserepos,
@@ -308,6 +309,7 @@ builder_tags = {
     "meta-agl-core": ["layers"],
     "meta-virt": ["layers"],
     "meta-qcom": ["layers"],
+    "meta-ti": ["layers"],
 
     "musl-qemux86": ["musl"],
     "musl-qemux86-64": ["musl"],
