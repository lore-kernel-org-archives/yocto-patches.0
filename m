Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD691112248
	for <webhook@archiver.kernel.org>; Thu,  2 Apr 2026 00:16:58 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5439.1775089017325611952
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Apr 2026 17:16:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=a4qoZEr9;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486ff201041so2243815e9.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Apr 2026 17:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775089015; x=1775693815; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LhYHjSWfuomVZ9xqrcTFzImVv9935VJZbtt9v7qJbO0=;
        b=a4qoZEr9FU9GtJ7/G5hDiT4ZSpRpi8DxlpHkhJA+K5i7TXbX82WCQsFHpyMCI5DOmw
         pxvnaAyp2anqpSyrYjwVSFXEnpAE4KdIBPJYSSoMQGRTHWk8jGNLnhfodYAqTiRLPDVS
         p7q7XVzw9WtpQVOvZPlAmyLp9atPX1HvezMN8d2CAOP0Rgx0OoyeeoyCEbzbsKu3Jd7q
         BB8pg0iOF6EFUT/uIrauLFuhZu7l07AK5qH6lyXutssYseOEhrzTDlgcxFS0/A99yTb1
         yfCAs5NC6TKG2sbJytY0Hjs+sUyY1AuVBxiMdO3d5sINoI3N7/oH3p0+ncJM2yZbNZVD
         z2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775089015; x=1775693815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhYHjSWfuomVZ9xqrcTFzImVv9935VJZbtt9v7qJbO0=;
        b=nf1TJWxRyZ6+TDRPeJjSBf8qnL7JIVUsD8qoLCBz0cpqzzcv7k+PCK5DTvbp2kNC63
         dyvyJtc9Dawl9qcavAvyJXDmqyHxkrLMnTkmiIJvbjARJl7eUFQpUs4FWMrj+VzQqLxW
         N4Psorxq14v7O+AzJW4SFwKCIQ5DJtDfn2Fu6YgNYtN4GAUUS8n+UjEoV/wKoQOvBBsv
         Kf+yKmVlL26Ps47ado0TtbWx7XemtApDEzyVprVB4/X3ICrQBfBkMUT+pYE5V6ekFvK5
         3f1kZsf0wGjm7pMMJYt4N42bc13PHsB+wj8LVPEyAndfizR8fd4D0oCg+VIxLElVSuKr
         bx3w==
X-Gm-Message-State: AOJu0YzhlYdLbm+2lcu/+VhI9AxXEiUMrOzb0J3+d76QZBxuyWB7+Cwm
	rkoeIVXkXBYj2tti+TZEYKyjhEWx3a8tCzBrj0Akou7h1wzW40S0oc0kWPY1IQ==
X-Gm-Gg: ATEYQzxCS7dUbb8nXoOD2hCbo7uk5keyoHu6dPUaRppAsagYtSpuvPORq+D15Daat32
	w18NNMlhVwKKTYK/jWvDAKKYPW4E4NDTvR7+zRGGEYqTeTKKbPXkjE0luOXpKOq6hA4exku+4iF
	xEoB76DY0YoUalX+BRuE24tJ+YxmsVnr5NH5i8v3faRA4ggW4tZcqDk9pZ6RestaT5SAcFjOWqa
	x0rvW4sdi36TRkbWvZMJNUfk28qi3KaMFF3GVn9sATNYk2/EtehS35XoXzHPZkd7pnvmD/QVUXt
	/DEGTrqpbjpdXR3xn8FHsZfaH5mMR2tqjr9Q5aBJmkd32s2SoYDt8WJ7fAsMjkPNDcI4gCVocxN
	3WgYLc13wp8fpFmeF1jnjmIb5omFivumJQokEGdfkoY9mz8/sUnpkzOZJP33n4NE2XyTOODCYLk
	DBSl8I7GIDbzM26fILN5wUKhEYjw==
X-Received: by 2002:a05:6000:4014:b0:43c:f664:d846 with SMTP id ffacd0b85a97d-43d1f1c3854mr2213352f8f.11.1775089015385;
        Wed, 01 Apr 2026 17:16:55 -0700 (PDT)
Received: from localhost ([109.238.218.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f5016sm3774602f8f.33.2026.04.01.17.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 17:16:54 -0700 (PDT)
From: martin.jansa@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: hongxu.jia@windriver.com,
	Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-tensorflow][PATCH 1/3] bazel: fix typo in .patch file
Date: Thu,  2 Apr 2026 02:16:43 +0200
Message-ID: <20260402001645.1717722-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Apr 2026 00:16:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3599

From: Martin Jansa <martin.jansa@gmail.com>

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 recipes-devtools/bazel/bazel-native_7.7.0.bb                    | 2 +-
 ...o.patch => 0001-customize-native-toolchains-for-Yocto.patch} | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename recipes-devtools/bazel/files/{0001-cutsomize-native-toolchains-for-Yocto.patch => 0001-customize-native-toolchains-for-Yocto.patch} (95%)

diff --git a/recipes-devtools/bazel/bazel-native_7.7.0.bb b/recipes-devtools/bazel/bazel-native_7.7.0.bb
index 76c3983..5fcd55a 100644
--- a/recipes-devtools/bazel/bazel-native_7.7.0.bb
+++ b/recipes-devtools/bazel/bazel-native_7.7.0.bb
@@ -8,7 +8,7 @@ SRC_URI = "https://github.com/bazelbuild/bazel/releases/download/${PV}/bazel-${P
            file://0001-HttpDownloader-save-download-tarball-to-distdir.patch \
            file://0001-fix-unzip-command-not-found.patch \
            file://0001-add-Yocto-native-sysroot-dir-to-the-default-Bazel-to.patch \
-           file://0001-cutsomize-native-toolchains-for-Yocto.patch \
+           file://0001-customize-native-toolchains-for-Yocto.patch \
 "
 
 UPSTREAM_CHECK_URI = "https://github.com/bazelbuild/bazel/releases/"
diff --git a/recipes-devtools/bazel/files/0001-cutsomize-native-toolchains-for-Yocto.patch b/recipes-devtools/bazel/files/0001-customize-native-toolchains-for-Yocto.patch
similarity index 95%
rename from recipes-devtools/bazel/files/0001-cutsomize-native-toolchains-for-Yocto.patch
rename to recipes-devtools/bazel/files/0001-customize-native-toolchains-for-Yocto.patch
index 5de56dd..3f5fce5 100644
--- a/recipes-devtools/bazel/files/0001-cutsomize-native-toolchains-for-Yocto.patch
+++ b/recipes-devtools/bazel/files/0001-customize-native-toolchains-for-Yocto.patch
@@ -1,7 +1,7 @@
 From f0c6f3420acdbfd22e06603ca3bbeae3e7d98fc2 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
 Date: Wed, 11 Mar 2026 01:48:31 -0700
-Subject: [PATCH] cutsomize native toolchains for Yocto
+Subject: [PATCH] customize native toolchains for Yocto
 
 Yocto use environment HOSTTOOLS_DIR to provide native toolchains,
 explicitly set it rather than detect

