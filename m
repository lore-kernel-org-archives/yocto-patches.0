Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B01AC8303C
	for <webhook@archiver.kernel.org>; Tue,  8 Jul 2025 07:24:52 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.13171.1751959482869292215
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 08 Jul 2025 00:24:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Xg4UC8iT;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4530921461aso27569475e9.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 08 Jul 2025 00:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751959481; x=1752564281; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chzxJ9IYo79uWEDsdishPs1yDr/QZZ1JIun+ufMW0mk=;
        b=Xg4UC8iTjoiqJGGCxduwrpKwUkMCndMRMLS3DQnGVAC8QtJB7tJuWgVEQJV9g0cA/G
         dsBg+XBhKwJRz1wMCY8v2WbS+8Zx1DDox0rtOeigFVhkweY+F5b0J3G0P3qLBGxoakgp
         EEmNlKyJ4e1lerSIixwYB7Hz8LUsxZRlW7AA+GtYgFTGzTvnOCsBEc+UmDMa8NgfLBNf
         9zsI1QKCoMG2haQOCzianu6tDTVRbysrUPYPace2S3MMKz+IFvF0y5ndQivs6n0s9DWl
         QpWTt5TlMLDDovhbolEUkV6rhdBot1TTw7FeGAnBNCScBtebNEXzOBkIjJvn9uIktV9i
         PIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751959481; x=1752564281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=chzxJ9IYo79uWEDsdishPs1yDr/QZZ1JIun+ufMW0mk=;
        b=LqkRvaBblrQZ3AAyn3UILqVO2C1W6LPww2P8vGao+c20GzTCCVcyGksTVAzfNZ/5as
         ccgcq+CXdzxFbJcSMDwDETm1QuQqvidZWdquSZDzPIP6Fp4HOXpdyoMOiK4NlV62zySz
         GGA6BlpXskH8umkb+fx4TDqAlhiEk0U6FBURfQ6bjyARFtNK9gWV69iBo6g9VY6bfMAh
         1deZLULsv9UY3LJEZ4EGnEcOdkaFuG6q9lGbCPQaWUbKbvHPxmRwL4vTMtiyfwIKsvMd
         neFiqAKvMe/AKrjoN7g903Q5bCysjUkAsx9XYdPk1eRf8MmzvuifaxYhjeXjPHpwzPiK
         raKA==
X-Gm-Message-State: AOJu0YxMOkF3VHOmk2xmAU3bpguAXBvZksa4DGjMXEDLW1eRlqoDD/Pk
	22Eo+OWATtMOALMZoaQk9SV8GF9CtSQ7GXPQHfrtlBgKFnZL7lbPFw/EFSd3zg==
X-Gm-Gg: ASbGncvFfOqZbeoC0tyhAuxaS+zimiXbEJGlAwWAqGHrt35JLHYT4fkiSjdzTpYf93B
	dyoebEWT6i+QJH4CoX1dBD8endbRgZgqZfR36abP353XWuJP5U3CdnWYVbHEww4OtJUFxEFaje4
	ldMoM32pFhS5PPYJQhmzU1DrW9tixS1YDZKmTW+W0GKq8Azy4GBPatWhhgSmS9zOJQkVPy3r86C
	kZoqMbUZaW2RcDqTB+NF9N2LVhS+knzTNna+PMUTgeVoSbG3MMvUezUHpBN19M1Khm2lqSMn0lE
	rO0xWtuUPMZVxZ9b8JI6MBapMRwvDeBTvq2ZcVfh+TU/eGZ43Al87XNCh+j5Flr3
X-Google-Smtp-Source: AGHT+IFAATuqidyi1z7VZ6Z5vVf2RYWxE+B0NtCQFrb86ZiPUipmwXX9stqinGsd/3vMg6DhtyL4dg==
X-Received: by 2002:a05:600c:530c:b0:450:d00d:cc with SMTP id 5b1f17b1804b1-454cd4ba75emr17628635e9.2.1751959480959;
        Tue, 08 Jul 2025 00:24:40 -0700 (PDT)
Received: from localhost ([109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b47285c9f9sm12370975f8f.93.2025.07.08.00.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 00:24:40 -0700 (PDT)
From: martin.jansa@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Martin Jansa <martin2.jansa@lgepartner.com>
Subject: [meta-tensorflow][PATCH 2/3] bazel-native: adapt to UNPACKDIR changes - avoid WORKDIR/sources
Date: Tue,  8 Jul 2025 09:24:35 +0200
Message-ID: <20250708072436.24522-2-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708072436.24522-1-martin.jansa@gmail.com>
References: <20250708072436.24522-1-martin.jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 08 Jul 2025 07:24:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1782

From: Martin Jansa <martin2.jansa@lgepartner.com>

Please see
https://git.yoctoproject.org/poky/commit/?id=4dd321f8b83afecd962393101b2a6861275b5265
for what changes are needed, and sed commands that can be used to make them en masse.

Signed-off-by: Martin Jansa <martin2.jansa@lgepartner.com>
---
 recipes-devtools/bazel/bazel-native_6.0.0.bb | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/recipes-devtools/bazel/bazel-native_6.0.0.bb b/recipes-devtools/bazel/bazel-native_6.0.0.bb
index 19b411b..ef9dfba 100644
--- a/recipes-devtools/bazel/bazel-native_6.0.0.bb
+++ b/recipes-devtools/bazel/bazel-native_6.0.0.bb
@@ -5,7 +5,8 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"
 SRC_URI[md5sum] = "f79f57d82795b591e95f9f7fa0f9a8da"
 SRC_URI[sha256sum] = "7bc0c5145c19a56d82a08fce6908c5e1a0e75e4fbfb3b6f12b4deae7f4b38cbc"
 
-SRC_URI = "https://github.com/bazelbuild/bazel/releases/download/${PV}/bazel-${PV}-dist.zip \
+# bazel-${PV}-dist.zip doesn't have top-level directory, use subdir
+SRC_URI = "https://github.com/bazelbuild/bazel/releases/download/${PV}/bazel-${PV}-dist.zip;subdir=${BP} \
            file://0001-HttpDownloader-save-download-tarball-to-distdir.patch \
            file://0001-fix-unzip-command-not-found.patch \
            file://0001-add-Yocto-native-sysroot-dir-to-the-default-Bazel-to.patch \
@@ -25,9 +26,6 @@ DEPENDS = "coreutils-native \
            openjdk-11-native \
           "
 
-S = "${WORKDIR}/sources"
-UNPACKDIR = "${S}"
-
 inherit bazel-base
 
 EXTRA_BAZEL_ARGS = " \

