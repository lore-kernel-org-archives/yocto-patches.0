Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74471CD3444
	for <webhook@archiver.kernel.org>; Wed,  6 May 2026 16:21:53 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22869.1778084508318738711
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 06 May 2026 09:21:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=flpMDiyY;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d77f6092eso4192608f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 06 May 2026 09:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1778084506; x=1778689306; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hHe0kC856rSlaTn0YTxcMZWEGDV5l4bfGT3yh23Ewvc=;
        b=flpMDiyYjdNmUM4KTnepQf39enrr9rM2ani6NotsbugM1WPiHDfFx8wqhQOhuzhmyh
         zYDiwm2Kx8afvEhPRy19LtaEJuzHOSdUmyTvW0EgQInhK/nvhXDJd9BbnGndHFErjX0L
         9xaFSG453E/rdlWSNmS/5QiermUXzXaQ1sOPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778084506; x=1778689306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hHe0kC856rSlaTn0YTxcMZWEGDV5l4bfGT3yh23Ewvc=;
        b=VO/AUr76FuhlEsNcmF7P2bCbjDtBWMkSTGYlomManEDZTNW7qc9Uz99xK3kPo2/vTe
         2G8z/c3Z7bK6aKB0Q2mQZyKHw2yZHPQog+hZkmdad9hGsSBPsexKRMcqvOxOFBIkB77K
         0ewZoN4ZFfUkFzXMkwyEz9rv+XvI8jwnAUAJsSJhKwH/m2UNsYlL6QopXk/vteOfb1th
         Erzf0MaHSeghea5G17TpQh/WJxEaB68+t3F/CkLPAWfOuk501j47NqynEludmAd94PYk
         tKSJmStwTElEmxujn0dsxbo5L63YF4hZmH2eUZQukC3ZzANvQRU0V+VL+ZaxvzV1Ly31
         SBkQ==
X-Gm-Message-State: AOJu0YyHvU5TT3XWvdYe1Vn/q/PrOOCZyvJewftrczEj05UKkYp9i2qa
	5gDh7xvGJ+UssoWKNWAFL6P6hRWez7BtWa3OjqfGwwrslc6ST2XwlTr9uVON9gjxk+Y5F1Ytpvt
	EwRcg
X-Gm-Gg: AeBDieui63DPtdk84WShUltOrHQYKq71gFr4gsWpb+6UiTOYUMackFFNumRzLyGXfFy
	kgY9XyIgaWiR3lfF+Y0UJ3DUaN4YgNg9GxvLGbFVR6dhBgsubgGRjQ1IynoFa0njimlU5OsUYXU
	BH0vW0g5q30XLMca+pdYdQS/dtMYd/Ec4LD3xC0AmLgWROXyuyg9aP960V5fF4DovanprW1sqDT
	rHXNPSh8gmnWLXwzB/a/fLpbJVE5yD+ao4WK4DHwKf7Z1IVVlm1qegVD3zs/aHu/w5mexqgMuwy
	27CgLnzxvgsYnMEzdjBmq1bG15ldzX63T28a23MGR4TbCNwQlqabuCAJwRaFNGUJMuvNBg+z5B3
	fSHPCxPyV180eM3XlfJb7XnNVammZS9LXSgb7aleMc+rB0W/aDyQrYN6dvUM70CmaF8PNX4VkLp
	gTFDu/xes/8u7OZtnTPEa4EbZEEwCt+BRB2ii2AUR4Bno5LMbyN9MP3em6G1h46ik=
X-Received: by 2002:a05:6000:2084:b0:44a:2f78:e873 with SMTP id ffacd0b85a97d-4515ad76c74mr7218843f8f.17.1778084506059;
        Wed, 06 May 2026 09:21:46 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:5409:94a2:bd3e:6c21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960811sm14318822f8f.27.2026.05.06.09.21.44
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:21:44 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH 4/6] publish-artefacts: Drop obsolete targets
Date: Wed,  6 May 2026 17:21:35 +0100
Message-ID: <20260506162137.4180049-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506162137.4180049-1-richard.purdie@linuxfoundation.org>
References: <20260506162137.4180049-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 06 May 2026 16:21:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3925

These builders no longer exist and the code can be removed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/publish-artefacts | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/scripts/publish-artefacts b/scripts/publish-artefacts
index ddf6765..3537506 100755
--- a/scripts/publish-artefacts
+++ b/scripts/publish-artefacts
@@ -154,14 +154,6 @@ case "$target" in
         sha256sums $TMPDIR/deploy/images/genericx86-64
         cp -R --no-dereference --preserve=links $TMPDIR/deploy/images/genericx86-64/*genericx86-64* $DEST/machines/genericx86-64-alt
         ;;
-    "nightly-x86-64-bsp")
-        rm -rf $DEST/$target/images/intel-corei7-64/*
-        mkdir -p $DEST/$target/images/intel-corei7-64
-        sha256sums $TMPDIR/deploy/images/intel-corei7-64
-        cp -R --no-dereference --preserve=links $TMPDIR/deploy/images/intel-corei7-64/bzImage* $DEST/$target/images/intel-corei7-64
-        cp -R --no-dereference --preserve=links $TMPDIR/deploy/images/intel-corei7-64/*core-image-sato-sdk-intel-corei7-64*tar* $DEST/$target/images/intel-corei7-64
-        cp -R --no-dereference --preserve=links $TMPDIR/deploy/images/intel-corei7-64/*modules-* $DEST/$target/images/intel-corei7-64
-        ;;
     "qemux86")
         mkdir -p $DEST/machines/qemu/qemux86
         sha256sums $TMPDIR/deploy/images/qemux86
@@ -192,19 +184,5 @@ case "$target" in
         sha256sums $TMPDIR/deploy/images/qemux86-64
         cp -R --no-dereference --preserve=links $TMPDIR/deploy/images/qemux86-64/*qemux86* $DEST/patchtest
         ;;
-    "eclipse-plugin-neon")
-        DIR=$WORKDIR/../scripts
-        # create sha256sums only for the zip files
-        for x in `ls $DIR/*.zip`; do sha256sum $x >> $x.sha256sum; done
-        mkdir -p $DEST/eclipse-plugin/neon
-        cp --no-dereference --preserve=links $DIR/org.*.zip $DIR/org.*.sha256sum $DEST/eclipse-plugin/neon
-        ;;
-    "eclipse-plugin-oxygen")
-        DIR=$WORKDIR/../scripts
-        # create sha256sums only for the zip files
-        for x in `ls $DIR/*.zip`; do sha256sum $x >> $x.sha256sum; done
-        mkdir -p $DEST/eclipse-plugin/oxygen
-        cp --no-dereference --preserve=links $DIR/org.*.zip $DIR/org.*.sha256sum $DEST/eclipse-plugin/oxygen
-        ;;
 esac
 

