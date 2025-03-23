Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E7EC28B30
	for <webhook@archiver.kernel.org>; Sun, 23 Mar 2025 10:42:35 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.13559.1742726548669185906
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 23 Mar 2025 03:42:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=B0nXbjAy;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf848528aso29158205e9.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 23 Mar 2025 03:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742726546; x=1743331346; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eklms86mxhOk6/mrVgQl+tXcG0wbYxfnsdeOWgdXhJU=;
        b=B0nXbjAydditM64WQcx/mSo3IBjL0kmuQFJkJKTgxn0gzKAh+t8GGBHdb04UkEsLb6
         0VCXCsQxQAXaFAGN66S6+SE+SrVWsZ3KafmHc9vGXH4/Lbn7USR7Jl6Vl3Bo6zbfdsmc
         DRoY1iUTtn3NbZvBvL2TKJoS0+ZbJvPNfJSnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742726546; x=1743331346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eklms86mxhOk6/mrVgQl+tXcG0wbYxfnsdeOWgdXhJU=;
        b=CuGuX6Vh+bXMbIo9D5sURMDkDbzEx3kZgx+9KDfDbFKStPNsC8dUFUKUwgMJZW/OPT
         yRetD25jstIX9+s/CiOTiitPiXc/KyMmKY4byfAnzTxm/TOy4+8ClFk7DlpZwPo7Q9Ui
         U6EibFsv2sOID2huymo4rg/+x0FUsQAcpwFmndzBovruCfkr2Iwl0IcXy9VyvwrFem14
         9O3vpUytqipEjKmHpGkGmdjGu3ON9RgSIlpVYKEWsn0QvKE704aDcTKpjzTJiZWmJJXT
         i4Puo5QN5esHlWrpjFMdUHUFlGCmffNFrCsWOpmoI4njH2+g2ABO3tZZSK7wlNKUXHwP
         TarQ==
X-Gm-Message-State: AOJu0YxsD8ezz5+JO9TfLhA8DMfNUoEswgi/Jbii6iMMkvIcN+uSY0Ro
	bmdOVrJsSREvf7zw7/xp6R4AjmVZHaLYUjuGSbtkjQd1QHZp+2FIKZnpKM49rmZ30974dO3XIGR
	O
X-Gm-Gg: ASbGncsmhurRGqamvV90FilqgQhYywtkBAB9Mq8d9VtSc3yOwW1UQpoXqmRGzwN33Y8
	z0syMtpZdeYzLD557atbWqcfk+SPyIozriI+FacUgd/DTedyaS0ChyBouG9NeQI0ZJReXrEdNgj
	gKA2t/IMoyFcpPqaPLu8b2qf8KhwFBbq29VlgqJd+uxe56p55y6cw+vrWQ3mcG/ClQIPAeCLxyU
	PHwjpDJHs3d/I5wgcBNVWPeSbfdTOBU6dyTd3uRDE6mhj1JcULput7lzzuz4eDlr47jdw1UBcNm
	9mvQQ73cY3MExD6tBZW9P0c/McQVE0BKfQqY5UvO493jWuU3bS5a5zQLcqrziKR92tl3Zd1j
X-Google-Smtp-Source: AGHT+IG3fZKXuIheTFUCZvwOu3gXKWt92dWhCmbfthr/+lE7gWxa0mbVGfwmhLucbOXwg8q9Z8khfg==
X-Received: by 2002:a05:600c:1548:b0:43c:f78d:82eb with SMTP id 5b1f17b1804b1-43d509f5985mr100522965e9.15.1742726546161;
        Sun, 23 Mar 2025 03:42:26 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:975:45cc:33c7:7995])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3f76sm7509938f8f.37.2025.03.23.03.42.25
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 03:42:25 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] config.json: Switch to a buildtools that has IPv6 support
Date: Sun, 23 Mar 2025 10:42:24 +0000
Message-ID: <20250323104224.1178195-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 23 Mar 2025 10:42:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1243

Some autobuilder workers don't have IPv4 addresses and were failing some selftest
with problems connecting to downloads.yoctoproject.org.

Using a buildtools tarball with IPv6 support fixes this.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.json b/config.json
index 23e5cfc..e01eef3 100644
--- a/config.json
+++ b/config.json
@@ -7,8 +7,8 @@
     "BUILD_HISTORY_REPO" : "ssh://git@push.yoctoproject.org/poky-buildhistory",
     "BUILD_HISTORY_FORKPUSH" : {"poky-contrib:ross/mut" : "poky:master", "poky-contrib:abelloni/master-next": "poky:master", "poky:master-next" : "poky:master"},
 
-    "BUILDTOOLS_URL" : "https://downloads.yoctoproject.org/releases/yocto/yocto-5.0.4/buildtools/x86_64-buildtools-extended-nativesdk-standalone-5.0.4.sh",
-    "BUILDTOOLS_ARM_URL" : "https://downloads.yoctoproject.org/releases/yocto/yocto-5.0.4/buildtools/aarch64-buildtools-extended-nativesdk-standalone-5.0.4.sh",
+    "BUILDTOOLS_URL" : "https://downloads.yoctoproject.org/releases/yocto/milestones/yocto-5.2_M2/buildtools/x86_64-buildtools-extended-nativesdk-standalone-5.1.sh",
+    "BUILDTOOLS_ARM_URL" : "https://downloads.yoctoproject.org/releases/yocto/milestones/yocto-5.2_M2/buildtools/aarch64-buildtools-extended-nativesdk-standalone-5.1.sh",
     "BUILDTOOLS_MAKE_URL" : "https://downloads.yoctoproject.org/releases/yocto/yocto-5.0.4/buildtools/x86_64-buildtools-make-nativesdk-standalone-5.0.4.sh",
     "EXTRATOOLS_URL" : "https://downloads.yoctoproject.org/tools/buildtools/x86_64-buildtools-imagemagick-nativesdk-standalone-4.3+snapshot-5f2ba20f203114db9a3b11264467f8c23a05041d.sh",
 

