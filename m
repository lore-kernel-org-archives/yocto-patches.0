Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CFF1112249
	for <webhook@archiver.kernel.org>; Thu,  2 Apr 2026 00:17:08 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5440.1775089018175848851
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Apr 2026 17:16:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=BFhhT2W5;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-486fe655187so3101385e9.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Apr 2026 17:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775089016; x=1775693816; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Btm4DCvMUgXkIds2vcIdkbXpaY+T5s7QKd9qleCuPSE=;
        b=BFhhT2W5/TqBRRidDoOyXQTwr3O8FYxJdN/inU3WYc9M5eoH+RMigT2YI0UqMcv9W3
         UclTToqu/eb/joU4LSltEu/GMiudsw56poh6sJ8M11NJ+M+4uLCg0nZqcrS+/ETcDP98
         +lrl1GF4lK0/babf0YKsUHwk09atT9+03sBGpEH3l7RdE8fE1o0yP3MWDFBpZskQO0rz
         Hxrj6b9AoDsKYjGP+bcwQnOqQRcz+0DldVlvvWsZLlmsHNSV2yhNjU2zqotABJCQtGZm
         t38KIx09rZ/vnh039960aOpnHRS1PtMJOyr6QZqaToUUeljgRXxdPVOrP7FSGZ+Hf6dc
         oW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775089016; x=1775693816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Btm4DCvMUgXkIds2vcIdkbXpaY+T5s7QKd9qleCuPSE=;
        b=Ak/JW79ShZAUWqy9FSrXn0nnneOFwJEvLQLilWIraoYTMHfjOyq9VoUd87INkuHGtL
         jB8lW84OcQ3A5/FPIFeOFtjRfN9k3A1MJnvBIYkjVqhNlkymDA9q0FonsSPzf0MzX9Px
         ggOMr9Fn4lQBRaBxwCDhzj1Qs4qMowo7VUYx2/ohcTfir1jvPKOpG8MZFSxbjIYvBW+f
         zQrCwmKz4hiHm/j4Xqw3izVN6BvyfDp4WX6PGMHsEHMapWpsetthwi8aDNxyCHSyg+02
         Vcz7erRuZqLwzCS6MujuE1lZ1da5gd0/qdiABJIdOBFiEWYFYQhJDltNQ+UxOizGyIa0
         tJgA==
X-Gm-Message-State: AOJu0YwIxhOdrvES5hregXR/ZHlIxxQpfZmT+KcDJEzUTNkQKSXXfA/7
	nJIMid3AgWcx0WDmgMJMFA99sOzDV1euCi2Jpjk8euZceJUHkLCId+pKsgeshg==
X-Gm-Gg: ATEYQzy7bOfp/+zORoiao2AQgjX0wO0zTUyLJcZTU6HcubS88gUVrgSRfyKg3OY59c4
	MspVj5yiY06sC3neNTqzjbTZG2vTXoHl9bZ4pTXCgIU6eKo7o3bliGfxzJpujjshfU9O4sSNIis
	SaxAGhecWbRvC8yNUUB/0ungKQ/BeGbwy0QZDqK892tl6WSnAeXb4sBN9GE1/F55zg8ghQrAvuk
	LUQvW7ic3BOcbv9n0LKfqMOo17hmliz9grAHI6vZLYafm9VrrglOHqsIEVdXBUSi7tuSWGvTmU/
	wKBkPkvZ/84pBK7zJBPd3t2YeR/L3n1H9QpdniY5STBwivYUgnBMwXSWeR12TRzWBHoHlDsRZ5S
	f9wc26vSj/4/L1koVBjIPWcDL1E5t7klzTcHvJ6zgQ5elP58c5ncUEsE382K8Yil0B60qCfYZeO
	5YTKR9cNfLmUthZUD8OhrKvJ/ZWQ==
X-Received: by 2002:a05:600d:1c:b0:485:40db:d40c with SMTP id 5b1f17b1804b1-4888b6eaa89mr18667065e9.3.1775089016491;
        Wed, 01 Apr 2026 17:16:56 -0700 (PDT)
Received: from localhost ([109.238.218.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f5bsm3601972f8f.7.2026.04.01.17.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 17:16:55 -0700 (PDT)
From: martin.jansa@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: hongxu.jia@windriver.com,
	Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-tensorflow][PATCH 2/3] bazel: disable color in bazel output
Date: Thu,  2 Apr 2026 02:16:44 +0200
Message-ID: <20260402001645.1717722-2-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402001645.1717722-1-martin.jansa@gmail.com>
References: <20260402001645.1717722-1-martin.jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Apr 2026 00:17:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3600

From: Martin Jansa <martin.jansa@gmail.com>

Doesn't interact well with the log files stored for bitbake tasks

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 classes/bazel.bbclass                        | 2 ++
 recipes-devtools/bazel/bazel-native_7.7.0.bb | 1 +
 2 files changed, 3 insertions(+)

diff --git a/classes/bazel.bbclass b/classes/bazel.bbclass
index 3d5e7b3..43e2c9c 100644
--- a/classes/bazel.bbclass
+++ b/classes/bazel.bbclass
@@ -113,6 +113,8 @@ build --python_path=python3
 fetch --distdir=${TS_DL_DIR}
 build --distdir=${TS_DL_DIR}
 
+build --color=no
+
 ${@bazel_get_flags(d)}
 
 EOF
diff --git a/recipes-devtools/bazel/bazel-native_7.7.0.bb b/recipes-devtools/bazel/bazel-native_7.7.0.bb
index 5fcd55a..042f456 100644
--- a/recipes-devtools/bazel/bazel-native_7.7.0.bb
+++ b/recipes-devtools/bazel/bazel-native_7.7.0.bb
@@ -33,6 +33,7 @@ EXTRA_BAZEL_ARGS = " \
     --tool_java_runtime_version=local_jdk \
     --python_path=python3 \
     --distdir=${TS_DL_DIR} \
+    --color=no \
     ${@oe.utils.conditional("BAZEL_JOBS", "", "", "--jobs=${BAZEL_JOBS}", d )} \
     ${@oe.utils.conditional("BAZEL_JOBS", "", "", "--local_cpu_resources=${BAZEL_JOBS}", d )} \
     ${@oe.utils.conditional("BAZEL_MEM", "", "", "--local_ram_resources=${BAZEL_MEM}", d )} \

