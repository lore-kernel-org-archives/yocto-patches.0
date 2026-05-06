Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85445CD3447
	for <webhook@archiver.kernel.org>; Wed,  6 May 2026 16:21:53 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22613.1778084509539086689
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 06 May 2026 09:21:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CVs8Q42x;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43fe3e22e33so3911866f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 06 May 2026 09:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1778084507; x=1778689307; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pX7UewRStWNCeg3TAcz+rtFB6d+ye1y5zxX8PnV4lJE=;
        b=CVs8Q42x1qJi4PJuweiHz4QhPUqYARuTeeEQiwH2EUJaGBip7ltJyswtJazAHyt8QM
         JMnCvZDQWu+lHH7f83aJY4yupooimy75/rXlbM2e5GacwzjOADIvurkxDI8HYCBobKgG
         XsN84J5olHEgdA26imUXK/jSNVwKoBfDMsrQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778084507; x=1778689307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pX7UewRStWNCeg3TAcz+rtFB6d+ye1y5zxX8PnV4lJE=;
        b=gp/vqzhCmbtoYbNWbHgaSVqFRnPwtK78YCh2H7LErqPO7l8maiN2cHv5B0NrT/zcFf
         nYg6RISY/LY/hy5AmaeyLHOXH7HLkm0fAnYOVkzpd8TIQJ0MXYKTbVf6fhEscI+i9qc9
         2QAhBfVoLKwClYaHHmKte36Y0/b3yGez/70rFweXxsSfaDF82mB9mKwmyo0vWsXKxHtN
         T65wytWTXsjifWEj3ubZ+Vjk8QbeNE9euoz6yWhBgPkL/7pjEC9B3I+KnTW+va40gQe9
         0QrMog40jMsacBx46hEPnFXQlxZo4u1onJq8fffM6pVCAfXZAQXlvAzhtAwEzW/8MHdY
         vOVA==
X-Gm-Message-State: AOJu0YwppS98C0800KBscYPRonBZdjQXihraNHbPO2ZALauGR7Y0rhzh
	6R1EsEScW5C7c7iy39BTTlXulCjactr9oRE3n3Qs7TKdwRjR8eZ4/zzklXBk/UpXs3ih9fPilOp
	6bZb+
X-Gm-Gg: AeBDietqh0c3mla/Lnh5b/ei9nwHM0Uv+xi2cvsUsq3HsGttR46vihPljvoxZzjD6ho
	sLz8tCkcl9TG8AxEoqeYj7C9uWL5eXsiK64+PYk59kH1M+/OHwVBVz/ZyX4bSLCRoInoIvPY9xQ
	LJ6SOLaX3xgiTIiokpIYOkb7uJ4HVTrvBfOFvXxSl+9yrmKvWiDRK9sHVuTPyAT+XFyG96cASI9
	bCklDUpuvLJoHhQ0fH7Gtztyq81tS2yQoo7bDbXjirp4qpRnhdb7i0yQXo7aZUZMnvYkb77N8yV
	cz+AHCa+zKDHbrUxu5t+brAqoBT78AFAvRtIOv7/rLX0UxmSOBacBh3jWAub4mt2fV64fhlAGbV
	0V/z4cUqaWFT+kRU/Ggl09iSC58mwOrOq2NFCKkqtaIa7eozDiu+JDCbCE7tIDqgwZbOeXjhjVb
	OJpyw2MxBTjMbQwjhu2zOn8gPcyI+xOtQKgbjpl6nsfKJY355KTKJOplLK4eg+004=
X-Received: by 2002:a5d:5d84:0:b0:43c:fe66:43ec with SMTP id ffacd0b85a97d-4515ad7670emr7599717f8f.14.1778084507390;
        Wed, 06 May 2026 09:21:47 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:5409:94a2:bd3e:6c21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960811sm14318822f8f.27.2026.05.06.09.21.46
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:21:46 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH 5/6] publish-artefacts: Drop wic test images from releases
Date: Wed,  6 May 2026 17:21:36 +0100
Message-ID: <20260506162137.4180049-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506162137.4180049-1-richard.purdie@linuxfoundation.org>
References: <20260506162137.4180049-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 06 May 2026 16:21:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3926

The wic images are just for standalone wic image testing. We don't need to
publish them when we have the main images for the generic* machines which are
also in wic format.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/publish-artefacts | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/scripts/publish-artefacts b/scripts/publish-artefacts
index 3537506..bcfc97b 100755
--- a/scripts/publish-artefacts
+++ b/scripts/publish-artefacts
@@ -106,24 +106,6 @@ case "$target" in
         sha256sums $TMPDIR/deploy/images/qemuppc
         cp -R --no-dereference --preserve=links $TMPDIR/deploy/images/qemuppc/*qemuppc* $DEST/machines/qemu/qemuppc-alt
         ;;
-    "wic")
-        mkdir -p $DEST/machines/qemu/qemux86
-        sha256sums $TMPDIR/deploy/wic_images/qemux86
-        cp -R --no-dereference --preserve=links $TMPDIR/deploy/wic_images/qemux86/*/*/*.direct $DEST/machines/qemu/qemux86
-        cp -R --no-dereference --preserve=links $TMPDIR/deploy/wic_images/qemux86/*/*/*.direct.sha256sum $DEST/machines/qemu/qemux86
-        mkdir -p $DEST/machines/genericx86
-        sha256sums $TMPDIR/deploy/wic_images/genericx86
-        cp -R --no-dereference --preserve=links $TMPDIR/deploy/wic_images/genericx86/*/*/*.direct $DEST/machines/genericx86
-        cp -R --no-dereference --preserve=links $TMPDIR/deploy/wic_images/genericx86/*/*/*.direct.sha256sum $DEST/machines/genericx86
-        mkdir -p $DEST/machines/qemu/qemux86-64
-        sha256sums $TMPDIR/deploy/wic_images/qemux86-64
-        cp -R --no-dereference --preserve=links $TMPDIR/deploy/wic_images/qemux86-64/*/*/*.direct $DEST/machines/qemu/qemux86-64
-        cp -R --no-dereference --preserve=links $TMPDIR/deploy/wic_images/qemux86-64/*/*/*.direct.sha256sum $DEST/machines/qemu/qemux86-64
-        mkdir -p $DEST/machines/genericx86-64
-        sha256sums $TMPDIR/deploy/wic_images/genericx86-64
-        cp -R --no-dereference --preserve=links $TMPDIR/deploy/wic_images/genericx86-64/*/*/*.direct $DEST/machines/genericx86-64
-        cp -R --no-dereference --preserve=links $TMPDIR/deploy/wic_images/genericx86-64/*/*/*.direct.sha256sum $DEST/machines/genericx86-64
-        ;;
     "qemux86-64")
         mkdir -p $DEST/machines/qemu/qemux86-64
         sha256sums $TMPDIR/deploy/images/qemux86-64

