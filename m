Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C39C107636E
	for <webhook@archiver.kernel.org>; Wed,  1 Apr 2026 05:30:42 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6172.1775021432203291458
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 31 Mar 2026 22:30:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=m2KCs1fd;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48557c8ad47so50311025e9.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 31 Mar 2026 22:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775021430; x=1775626230; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dEetIYhEKb+KctjFs7JZMdCoiS+uZmVWEyXSM74Ri98=;
        b=m2KCs1fdYo/jvVRV5UzVbFnNOPT1YqTkj+Nu19afy4WqXYHkq15h8VJLxlmYmDBod+
         LupO7wZ8FvyLe5Z35G4HbuL3hbr7kLMMQEo5cdcZKoRHftN0TGqsY9heY1RmTDt2AQzr
         5m9BIVYWwbq7MZ5N36F50a4gulgym32HXXe5UVoQRXPIsC2cdlUYKlGPNUmRC4s6MIYd
         UvogAZhpvLFgPqaEGvkrR3mGWRiXGeh0ay+blpAP1R0MX6i9rJebGCbmFDBvZlF+mfi7
         duVGX9iFOUwXqgUj+Y9WR3XdMH7aB4GrXEb5Xqh5vRVuqBTnLMfU9OXi+Zrop5fZC1sP
         FXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775021430; x=1775626230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEetIYhEKb+KctjFs7JZMdCoiS+uZmVWEyXSM74Ri98=;
        b=Vcsns25NkVKOZy38E57PlzOv5u3BketWrbNi42T+W+TkTqaDJO3iaWa2obmtuCzkKh
         m3RI83ufP7wg98h+oEOxPyR+PIXH+APx3weDCytwlP7xNDu7jcYwyIeR98h2434VK3Kk
         o5yv3Eru3oFUT105tEsG80H9DGw46V9y3mRDJTPIgXcL4Ugm/4xLZbNaDnGfHHsyYRZF
         M8XRw4en727PwasGDrB4KcTZZayz+LYhDL52p+keSNvE5AACSvajxKm8/cKny74MBzfN
         azsABJpihuNsfOW/gJ8s2/Vwbz3C5EHO6ySq5ELMWZZ1QiB7P28xAvB0WWSPWGcbPxV4
         MUGQ==
X-Gm-Message-State: AOJu0YzTsoICX5ofcedTU0C9BAPpJCNvzXFvwRWv7qy+9gwqnno+fJ19
	Z7n73GPOh+ZZANTY477MmXof5gpxmokt9t8GL8x3Wz4QbJflVNELPEGNkRjn1w==
X-Gm-Gg: ATEYQzwrHx4qcZFg47wPoJee8bA4Ta86W3jYOt2C9G+R1W+JS9cHgg2kTHDt9jdIzE0
	TSUv4MNSVRvrBR1HajOpYKdxLQt36fp0KRs1dsCSLPVLRShjDVCdftxjeAAC4b1xSwXtqligEFu
	n0WypKx/frv1H/JZe10sfhibsb64CWnNHa7Equaff1VJKK/qrxJgFhBBdg9peAYuBvUVA7pFp/1
	Bz2j6ZICWRhRMduJRxepvJGvTNbTQHUHUQoCBqUFERuSJvKxIr2G4nch1g867+SvGFrWU4acnPW
	DF9Irw/HpZxtAcxZYv20bmHAgCzPFx8O5BFguJd9n5kX2goNZutkFgNXTmzx/dMYpzZSEot7hjK
	pf4xrfplDtIWWZtmQSBsZbXF9Nns9u2nnTmRlytWUs4svQkm+Oz3ySSGqsFbAH4fKDPZUf6PoLH
	/AbT0+EJ/Vx+Po7ZNKWgg3V4DJ94gymAe2VKWO
X-Received: by 2002:a05:600c:8184:b0:483:9139:4c1d with SMTP id 5b1f17b1804b1-48883590456mr31976455e9.14.1775021430112;
        Tue, 31 Mar 2026 22:30:30 -0700 (PDT)
Received: from localhost ([109.238.218.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c561750sm107899305e9.2.2026.03.31.22.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 22:30:29 -0700 (PDT)
From: martin.jansa@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: hongxu.jia@windriver.com,
	Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-tensorflow][PATCH] tensorflow-lite: don't install flatbuffers header files
Date: Wed,  1 Apr 2026 07:30:22 +0200
Message-ID: <20260401053022.96757-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Apr 2026 05:30:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3592

From: Martin Jansa <martin.jansa@gmail.com>

https://lists.yoctoproject.org/g/yocto-patches/message/2186
breaks a build for recipes which depend on both tensorflow-lite and flatbuffers because of conflicts in RSS as in:
ERROR: foo-1.0-r0 do_prepare_recipe_sysroot: The file /usr/include/flatbuffers/array.h is installed by both tensorflow-lite and flatbuffers, aborting

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 recipes-framework/tensorflow/tensorflow-lite_2.21.0.bb | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/recipes-framework/tensorflow/tensorflow-lite_2.21.0.bb b/recipes-framework/tensorflow/tensorflow-lite_2.21.0.bb
index 41646df..4951fbc 100644
--- a/recipes-framework/tensorflow/tensorflow-lite_2.21.0.bb
+++ b/recipes-framework/tensorflow/tensorflow-lite_2.21.0.bb
@@ -123,13 +123,6 @@ do_install() {
         install -D -m 0644 $header ${D}${includedir}/$header
     done
     cd -
-
-    cd ${WORKDIR}/bazel/output_base/external/flatbuffers/include
-    for header in `find ./flatbuffers -type f`; do
-        install -D -m 0644 $header ${D}${includedir}/$header
-    done
-    cd -
-
     # header installation done
 
     #echo "Installing pip package"

