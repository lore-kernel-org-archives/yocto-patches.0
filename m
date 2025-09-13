Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D2FCAC587
	for <webhook@archiver.kernel.org>; Sat, 13 Sep 2025 17:38:48 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.web10.2791.1757785123522836454
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 13 Sep 2025 10:38:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DzQ8g5jP;
 spf=pass (domain: gmail.com, ip: 209.85.218.44, mailfrom: skandigraun@gmail.com)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b0415e03e25so381269266b.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 13 Sep 2025 10:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757785122; x=1758389922; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TYrELr+Cs3IgBkFtIYqDQu7J8E8fRvj3T6kAZkx1u4k=;
        b=DzQ8g5jPjZCCJx7OSsR4c4Fk3FJsq+AcsxwJxaI9H1/kqiMFr42u2KA0asLs2TzJMX
         i3w7MSfwKoPZA3QTvytccTCPO13toe3Y5rV/bHWWSt9Evnyd0cLV9Ce8my4PXjch+njZ
         C/0Bw3ojfUDcG3IKM6hbREvG8RjUZksYkPxPFswYVswxkIlJ98FkZ4JbJlIa7DE+fSqD
         GiebjxR7MIOpJUDP1LP02hazP395f5BO1DFVulWZ4hVHOYEqnLueoS+nA5pcv7BpRUSd
         cM+DQVyF8qdQDLUPgHhZhwl+8SKsC0JQU/Tb8Vomos0AW+zfAqzH+9snfTPInljXmvqC
         8J1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757785122; x=1758389922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TYrELr+Cs3IgBkFtIYqDQu7J8E8fRvj3T6kAZkx1u4k=;
        b=hIsSglFSaxDxOw2G/4Wg+r+hjpiuaFYRo4IX/c598vIkNTVIDDInZK536WNFiKaAyB
         210hx71uU0HzoRfTgcO6qmMvFwr7iQWo58CUxfmg5fo6At3uyDTHSRDcqy2dmqyvJnlO
         +7JaPi8JHZ53nB4DfNaVUdqsmeuFk2Sh8Ud2bIUSFCF1D+UDHjHL56x8CWkjSHzpUTAj
         YwyWZjrWUHjcqPoBjWdUtPBNqcB9sJaGJpnhGDJk1loF9V9WFFrDBIjH2K0cNlU1jUY5
         TyGtwX+XelZtRj+XT9TZbzI6bWw/wzGsMjiwiZ0uDXKMXU3+8paGJ3jjCwZ9M9LJY5E2
         X+VQ==
X-Gm-Message-State: AOJu0Yzsd13ahSO5KbFSmutaIgZj1PHco7/egyz4wu6dToS3FpbEPGxK
	v8GQl5bo09HXIuE+4FNhCvy8doYK5m359q942B5PKJSgQ3CmGebVZCQN1VlvXw==
X-Gm-Gg: ASbGncufjadaLbKEdwd4Q0Ab4Nlbx/v5HB0yMiAZ1unt/R7/vrVa5KoZvGCDzjKxFyv
	WPUXteXyA3ugbHLfZz/8LWRT5GeMTHXmTN+jQDKsY8RaW/7cXr7rRdRY2bh92FA5G43/3hJ3wqX
	+km7s+TCruDkXGepEMTfFBAX5j9+HHm8LFFF2l2DmrxzKS/vIW71X7w8Ngr61hZoGxN5OMsmMK1
	0GW4MWuPtyxYx7fjbs3jKQzJpPXBygzY2Z3hb0cQegBD4cPHFXCV49lMe0sQV9OnftpD6tVpgj/
	rmmqUvbDIwfTGF/+TUVGvxnKX+PZJpugS/KbP1vpmyFVs1KnBUEpgmw2SsCD6omMIyQi4zONC5M
	EHmQ4mNXels7hzluOS3d/GXb70kU9HIBgP1aPEL57UA==
X-Google-Smtp-Source: AGHT+IEIwUTTsx/4Y8rANAgxMAeh2paXWuFSX/ZT7cOjWo+4zWhO7xLTcf9wesEOHdbxPsBX9gaetQ==
X-Received: by 2002:a17:907:3cc5:b0:b04:470b:64b0 with SMTP id a640c23a62f3a-b07c3820681mr757430866b.30.1757785121538;
        Sat, 13 Sep 2025 10:38:41 -0700 (PDT)
Received: from desktop ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b334e4fesm603031866b.106.2025.09.13.10.38.40
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 10:38:41 -0700 (PDT)
From: Gyorgy Sarvari <skandigraun@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-tensorflow][PATCH] tensorflow-lite: package headers
Date: Sat, 13 Sep 2025 19:38:40 +0200
Message-ID: <20250913173840.3216545-1-skandigraun@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 13 Sep 2025 17:38:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2186

The headers are not packages with tensorflow-lite, making it not easy to
compile any applications using them.

This patch copies the headers from the source and output folder to
the includedir.

The patch was derived from the content of a pre-compiled tflite package[1],
and from compilation error messages that were returned by rpicam-apps
recipe (which uses this recipe as an optional dependency)

[1]: https://github.com/prepkg/tensorflow-lite-raspberrypi/releases/tag/2.20.0

Signed-off-by: Gyorgy Sarvari <skandigraun@gmail.com>
---
 .../tensorflow/tensorflow-lite_2.19.0.bb      | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/recipes-framework/tensorflow/tensorflow-lite_2.19.0.bb b/recipes-framework/tensorflow/tensorflow-lite_2.19.0.bb
index 14a538a..786507e 100644
--- a/recipes-framework/tensorflow/tensorflow-lite_2.19.0.bb
+++ b/recipes-framework/tensorflow/tensorflow-lite_2.19.0.bb
@@ -114,6 +114,29 @@ do_install() {
         ${D}${datadir}/label_image
 
 
+    # install the headers also
+    cd ${S}
+    for header in `find ./tensorflow/lite -type f -name *.h`; do
+        install -D -m 0644 $header ${D}${includedir}/$header
+    done
+
+    for header in `find ./tensorflow/compiler/mlir -type f -name *.h`; do
+        install -D -m 0644 $header ${D}${includedir}/$header
+    done
+
+    for header in `find ./tensorflow/core/public -type f -name *.h`; do
+        install -D -m 0644 $header ${D}${includedir}/$header
+    done
+    cd -
+
+    cd ${WORKDIR}/bazel/output_base/external/flatbuffers/include
+    for header in `find ./flatbuffers -type f`; do
+        install -D -m 0644 $header ${D}${includedir}/$header
+    done
+    cd -
+
+    # header installation done
+
     #echo "Installing pip package"
     install -d ${D}/${PYTHON_SITEPACKAGES_DIR}
     ${STAGING_BINDIR_NATIVE}/pip3 install --disable-pip-version-check -v \

