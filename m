Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8DEC53215
	for <webhook@archiver.kernel.org>; Fri, 24 Jul 2026 11:50:38 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17521.1784893834678906403
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Jul 2026 04:50:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Vu5iviG4;
 spf=pass (domain: gmail.com, ip: 209.85.160.179, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c2b2c9eccso2720481cf.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 24 Jul 2026 04:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784893833; x=1785498633; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mmKhOv0CIUEqpuwyEHDjce+ikELz9iUmQMFa7zd/F/s=;
        b=Vu5iviG474c6A+y9O1zCsSsKk8G4T9BHyeLbuKVQk/VPOi7tBCnso/BQHp1hiKhO39
         qf2l1IHyNISobLDVhapxnxpXZDqRO11Xg1KlyEHUxOorGTbyc2XSuIhaQpmng3/qm2ZY
         Bf1mXT/74h9djNLEEK2iqkpi9xU9u4/6H/DaJGOCJ59ml4i83a5glzR3TCxBG2Dm7R2E
         imR2f9bTY4bF+Hems1qdGpQ1mkJiCHiCUUXOWp46bct+ZBCLXKS/Me1xKUHvcbnsqaAQ
         d3jIxcDssaAoJBJSncvuMPJgbQ7kZEgK8/C4SmV1UhMB704iljFqkQX10dYjEunhPFFD
         8/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784893833; x=1785498633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mmKhOv0CIUEqpuwyEHDjce+ikELz9iUmQMFa7zd/F/s=;
        b=VGBioRa+Dp2rV/kUzp2bd88EMyGhjTU6c3+Gb/v+lDSq8I080ku3TMkxiS2ROu5/pP
         OhAr/4XJwTKg+yzEMTlRO5chdRdHTCX5otsA3uuneUVND7ryTAYFSOQ1RLf8HO6q02Qe
         3SiaGPlyPVXwB2iiDP5CDtL/QMNpyMJFy6h3ZXIJvREkCH30J/7YmU+VaBLcaX3m/fJA
         5/OcZoki6flCWj5XXseri3VQQ5h8bE5GW6q/Z/+vvyWdEOOlCDhbH4wWvIazTp2H/+B1
         3LbfMjNCYSOSjxqpQZjW0kujci9vOFtzZ1tr//wlykMXU5hfRswLwsR34VWXtqnRW2z/
         YcLw==
X-Gm-Message-State: AOJu0YwYAtejH3g+wWL+vJhwlBQhIxgrEP2GOW0gFDcHtTVHM8aychja
	CVbGTdwWwLb+chGsZ3uyUEMLsLhj96vlrK+3Zuzw4M3bAbVkSdjsbQHANcjb7Q==
X-Gm-Gg: AR+sD13jAEY2maRMsBZYIueA4h0MyC+CV17TGJ1EYY5u5bPE6f20BuiiqVACETiWPz1
	8JNBhbLIpuXRso7yv+VuzuVKNGp7yexyjsf/FLhT//RsY67SfqnR/jdsM0yQqlrVABQbFj/KTQI
	GNxeVDKuMK3NFcldmwNMhygmm8mAllj+rd2Wqu3alMAr+eS6MPgleVfY50+wDOAd2OkM7EoYEXo
	zi6xzfI4wnFlQ5pmdCBe6tljuKA+adveRZXjJg+Rz2dCWpkfYAEjaPjrneoMRPKI6yIUyWS72lW
	U4dcxwGKt/0H/AyUZ4lSO6/DDxaKMd7Z98vOwA0XTOEvteOmCzwhJQmD8osqCO7eTLoIflID38m
	FQpnvAjEw8lm2QmuHKO5Xspw606+1kHq99SpVqlFvLR6fUU79KVrS7Aeneq5BAl0vumLmc/UyJs
	zemgedqDEzKIWO1UVMz57ZmW5Vd70PECH9XJltKkG70KcI9uQkT2kgg10=
X-Received: by 2002:ac8:5c83:0:b0:51a:8696:cb38 with SMTP id d75a77b69052e-5283ddc7ad0mr68939441cf.7.1784893833491;
        Fri, 24 Jul 2026 04:50:33 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907baa27cf1sm66582796d6.46.2026.07.24.04.50.32
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 04:50:32 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [wic][PATCH v2 3/4] oe/path: canonicalize('') should return '' rather than the cwd
Date: Fri, 24 Jul 2026 07:50:19 -0400
Message-ID: <20260724115020.38079-4-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260724115020.38079-1-twoerner@gmail.com>
References: <20260724115020.38079-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Jul 2026 11:50:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4535

canonicalize() splits its input on the separator and, for every token
that does not contain an unexpanded bitbake variable, appends
os.path.realpath(path). It never guarded against an empty token, and
os.path.realpath('') returns the current working directory. So
canonicalize('') and canonicalize(None) produced the cwd instead of an
empty result, and a stray separator such as 'a,,b' injected a spurious
cwd entry between the real paths.

Skip empty tokens alongside the '$' tokens the loop already skips, so
empty input canonicalizes to '' and redundant separators no longer
introduce phantom cwd entries.

AI-Generated: codex/claude-opus 4.8 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes in v2:
- No change; carried over from v1.
---
 src/wic/oe/path.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/wic/oe/path.py b/src/wic/oe/path.py
index 13c52b363694..95bb9648fab6 100644
--- a/src/wic/oe/path.py
+++ b/src/wic/oe/path.py
@@ -355,7 +355,11 @@ def canonicalize(paths, sep=','):
     # prefixes in sting compares later on, where the slashes then are important.
     canonical_paths = []
     for path in (paths or '').split(sep):
-        if '$' not in path:
+        # Skip empty tokens as well as unexpanded bitbake variables: an
+        # empty path would otherwise reach os.path.realpath(''), which
+        # returns the current working directory, so canonicalize('') or
+        # canonicalize(None) would wrongly produce the cwd instead of ''.
+        if path and '$' not in path:
             trailing_slash = path.endswith('/') and '/' or ''
             canonical_paths.append(os.path.realpath(path) + trailing_slash)
 
-- 
2.50.0.173.g8b6f19ccfc3a


