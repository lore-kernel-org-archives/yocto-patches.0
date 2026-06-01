Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C880CD5BD1
	for <webhook@archiver.kernel.org>; Mon,  1 Jun 2026 23:17:59 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12695.1780355872627880620
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Jun 2026 16:17:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=W3be7GHX;
 spf=pass (domain: konsulko.com, ip: 209.85.215.178, mailfrom: tim.orling@konsulko.com)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c85c531d4a9so366335a12.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 16:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1780355872; x=1780960672; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dEQxp5PKSiyinioidze4xQZtvDcT979QLwEYLu6wp5w=;
        b=W3be7GHXUFKGeFGDegNhmIWN6ZfhoRCXte1XeVfv+H1qaC7I+Z9IGxeS+zQLqk4242
         z/rSf5EXq4rEIsDsRWc6/lfnzV7CWnDsON5BJwjz9LJdo639MYOYSW6ymcnhSqruq17F
         FWx7Qc4YavquihBRw109PgMhOt5i0VWSwd4tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780355872; x=1780960672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dEQxp5PKSiyinioidze4xQZtvDcT979QLwEYLu6wp5w=;
        b=LDIUtBjBJ/yfAMhamJ9i8BGx8XaQ7issR90BXJaaBQcblFjZCPoEEmrbkVFyj+s0dW
         h6nvDiQVK8ldZfGT4agUmFeg5mGj12KRHxxougJqmkxBGv6N/gezhoNNQcZDYUUrj7M7
         2DgYYquL6ZlcsP9nDhfZGtSMkC2cp5Ml5JIZKoqBh0SSNzvBAdOlCnBkOEav5n4FkG4/
         SQvEb5+DmRuPuhett1dllVs9IvJ0SWLZ0avKg0EpZu1kAUlN5uxyiokAiPXQjE6yPNXu
         OfpjlzK8ZSG0ihRKuFwIaehwrsqdk5HKEhmNerbe79lVyhnvujoKXJGn/F7ZfWU4u0yk
         WoEA==
X-Gm-Message-State: AOJu0Ywj/XbpEBO9lUrj+GXwnWDGSjHpwHDL3Dhsv+XJ5/eNufGhaOl5
	sJ56Zxsgqh6N5P49aMT+cJfvxl+GGv4lt4+UBm5lY55/lGFaXGG5pbf7jB+Ve+42UzJektanraX
	zUwgF
X-Gm-Gg: Acq92OEagpr58TCaVRcNsE9LcrLVX/r+EAFd+382vfpXKCyC0TW5voue8bxaICoOPOD
	6ysQJvefn36flbWaoP6DMQOwUhdjofzyBw4jQPBFUpwlL4cramWe6lm06k6rEAk6j6mMK6p7lTt
	N07pa35pzuSJbNMS12rTTFYfocq1NkiayKaRypXSpBmx7Ng6fNGLeYcojyGwz+7mvo59qCy6Cy3
	ufj8d4Dj5Pe6G+bXux0dKn/iz4p5h3YLn3mwxO0imqZ1rGlX5x6FY8Fz7TWT/d7RcsHxkHNqTjE
	Qn2I/xVW9hkIegAodZIEnuCPIDaZ8MjHlP4w0e+uvtQr4jJCTw56+WWLrE0WnKhzlnHEd0MXa7W
	CMvQBPvlqP6805ErRJBAdO2iUA3WF/cxIyTqS5rdFGHevncjupSJIWfU+YSo48r1hw3N5FrX30f
	hGrEcMMebtTfnJDlvXaAeDCNa4ryGA7z3JwOjUBFbclap5VZjcQ27+5Hs+BEq1PjSH5cuPkc7qJ
	A==
X-Received: by 2002:a05:6a00:23c2:b0:842:68d3:e29f with SMTP id d2e1a72fcca58-84268d3f3ddmr1865398b3a.3.1780355871898;
        Mon, 01 Jun 2026 16:17:51 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214c92fd2sm10974405b3a.38.2026.06.01.16.17.51
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 16:17:51 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2][PATCH v2 3/4] config.py: add containers-library job
Date: Mon,  1 Jun 2026 16:17:28 -0700
Message-ID: <8c01e32910dd0f02b47568d7b31e5c78a848bffe.1780354388.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780354388.git.tim.orling@konsulko.com>
References: <cover.1780354388.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 23:17:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4095

From: Tim Orling <tim.orling@konsulko.com>

Add 'containers-library' which builds containers from the original
"container-cross-install" branch of meta-virtualization and newer
containers modeled after docker.io/library/*

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 config.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/config.py b/config.py
index 7c2353e..d102c93 100644
--- a/config.py
+++ b/config.py
@@ -36,6 +36,7 @@ buildertorepos = {
     "meta-webosose":  baserepos + ["meta-clang", "meta-openembedded", "meta-qt6", "meta-webosose", "meta-security"],
     "vcontainer-tarball": baserepos + ["meta-openembedded", "meta-virtualization"],
     "vcontainer-tests": baserepos + ["meta-openembedded", "meta-virtualization"],
+    "containers-library": baserepos + ["meta-openembedded", "meta-virtualization"],
     "default": baserepos
 }
 
@@ -164,6 +165,7 @@ builders_others = [
     "meta-qcom",
     "vcontainer-tarball",
     "vcontainer-tests",
+    "containers-library",
 ] + old_arch_full
 
 subbuilders = list(set(trigger_builders_wait_quick + trigger_builders_wait_full + trigger_builders_wait_perf + builders_others))
@@ -332,4 +334,5 @@ builder_tags = {
 
     "vcontainer-tarball": ["containers"],
     "vcontainer-tests": ["containers"],
+    "containers-library": ["containers"],
 }
-- 
2.43.0


