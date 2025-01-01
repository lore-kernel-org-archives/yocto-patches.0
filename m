Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF17E7718F
	for <webhook@archiver.kernel.org>; Wed,  1 Jan 2025 19:59:00 +0000 (UTC)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
 by mx.groups.io with SMTP id smtpd.web10.21159.1735761535389967680
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Jan 2025 11:58:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XseJdGVC;
 spf=pass (domain: gmail.com, ip: 209.85.219.173, mailfrom: akuster808@gmail.com)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e3983426f80so13862256276.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jan 2025 11:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735761534; x=1736366334; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4qImPjylzB1qKKCnNB/G2cb8IiyoEFQiOtPn3RAinMo=;
        b=XseJdGVCuyZx2y+Y4uNYmF0YvYMlFJ5Xf5/3mJrk47OpmPSG5vWlqmqhgWp1QPoZha
         Zi4ziR4StdHY5t/nHKhNTnhncT1hRFlTnM2Y09bShzUHx8rqbaAucxVLq3axPtQu1rJ1
         8If9ULgQuEFeaB+lWt792EiWc+hf6e7YeMC17R7nNgm+R9T2gOqxy5e4bsQW3WNyQ1Vk
         2R1LspvAyLA0b7rKC6bSls8G50lBq/PUtYgpjvKTTm6RK9Jr+EhyXHDrSQ+goDQtffWC
         auI1Lqwxn0QXvUCR56bpZ5UTVpAUmITf+IgSmlp/jzXdj9ARsON3iWc4UjMCWTsI7+2v
         6pQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735761534; x=1736366334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4qImPjylzB1qKKCnNB/G2cb8IiyoEFQiOtPn3RAinMo=;
        b=eFW6m4qgI3Bq8+t7N00lqcwt57eHrfko7H1G8k+K6mnd1XXV5K7uFAsGKT+uS+k94B
         OU6WONy3R8vDJnWrVIl1jRl5JNxuiDdXIccbzCow6vdi7H9IBA4RVuIs6BgUiHBOavQr
         a8MLLtTHIErSEBDxXGBEYij3GixQXCNuTUphRdt4PDDMneqW2MkGHjtF1XaEGjXFST5l
         IfaGBW2hPn7QsfzS/sCE5w7wZ43RWBClZAydeDYRhHwvfSDtilqMVWi+ROHzs8fAidIR
         S0KOGRbsvdP/ofr0TKXaIhfATGftcxqIdjFTTi+tSwR9GNBHGWgDSjpA9vSSzehLcisS
         2dmg==
X-Gm-Message-State: AOJu0YxXJt6C69RU8Y2juLkWDpnM1tpdqHwfRn+RRr4Q+P5P+FFL9cb6
	Gb3Gve64r9rbQlD6+iMYw/W4dCBV+5D3T69vqkT/fOuB1dd12QV3K/tsK/8r
X-Gm-Gg: ASbGnctbhOx8xXXrTULnTW4sAXI0+xwDqA0ffYFcPYVcQtGGbfZywp2Zn3mMsadDvIr
	zT3kxTjcVCzf4TFFni/2b/i5fNpFa3WRvFRyzK1v09uIbWesl6rNTJrss8LQHQx959g6JKZPoP9
	5Z8HK4ye7UAeA5OhcHen0A1Drm0yfAK79yBlJZv0niS24gXrUZqZjO+uC5AsVewcmFkztsYY6UG
	V1LgX64IqyFNF9iVH6uiwp/VMBnNKMnyRUIv3bhxUciXcU3WtFmaV0G5UDY8vyLl5CEdwk=
X-Google-Smtp-Source: AGHT+IFnq9PqVUqKMZjWwjP6bXrqryJSMxqQaZ/WUsPG7BjPj8BPrBULMirGfrioDGM09breal4TnA==
X-Received: by 2002:a05:6902:2185:b0:e4d:c8d5:821a with SMTP id 3f1490d57ef6-e538c265824mr28548895276.27.1735761534364;
        Wed, 01 Jan 2025 11:58:54 -0800 (PST)
Received: from keaua.attlocal.net ([2600:1700:45dd:7000:96f5:c643:ece4:950a])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e537cbf425bsm7177487276.2.2025.01.01.11.58.53
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2025 11:58:53 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 1/2] kas: musl don't build apparmor
Date: Wed,  1 Jan 2025 14:58:52 -0500
Message-ID: <20250101195853.2653594-1-akuster808@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jan 2025 19:59:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/962

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 kas/qemuarm64-musl.yml | 1 +
 kas/qemux86-musl.yml   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/kas/qemuarm64-musl.yml b/kas/qemuarm64-musl.yml
index b353eb4..3033b4d 100644
--- a/kas/qemuarm64-musl.yml
+++ b/kas/qemuarm64-musl.yml
@@ -6,5 +6,6 @@ header:
 local_conf_header:
     musl: |
         TCLIBC = "musl"
+        DISTRO_FEATURES:remove = "ptest"
 
 machine: qemuarm64
diff --git a/kas/qemux86-musl.yml b/kas/qemux86-musl.yml
index 61d9572..e321c51 100644
--- a/kas/qemux86-musl.yml
+++ b/kas/qemux86-musl.yml
@@ -6,5 +6,6 @@ header:
 local_conf_header:
     musl: |
         TCLIBC = "musl"
+        DISTRO_FEATURES:remove = "ptest"
 
 machine: qemux86
-- 
2.43.0


