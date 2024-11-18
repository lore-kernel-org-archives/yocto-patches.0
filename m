Return-Path: <ryosuke.saito@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46F5D49237
	for <webhook@archiver.kernel.org>; Mon, 18 Nov 2024 15:31:28 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web11.44337.1731943882753352680
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 18 Nov 2024 07:31:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=g8hTkwBf;
 spf=pass (domain: linaro.org, ip: 209.85.216.45, mailfrom: ryosuke.saito@linaro.org)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ea1bc2a9c5so2069014a91.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 18 Nov 2024 07:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731943882; x=1732548682; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SL26rYsrtN4hmxA848OOs2L0AxWw3nY8w+G/tYjnXyE=;
        b=g8hTkwBfzN8/7XZXHLYMjznqnk+fRTipDiG4nNpRbLftrHxEixZbJoGYOF//9ReGvk
         brV0IJqiII+b8INPeWWPMMfISuAUGY5T5OY7+pLzjG+h+24rbtl+w6cyUypcZ4/XDd2n
         kuNuf6tsV41Z85kYwuzuzORcivi2/mxevcEOS0DNdmPsiL2OBC6VGDgINpop0JJbho7C
         WxtMdhnp+mGB4pyJzrmDNV9Op/GKGwhA4NHuv3288hJiye+nHrsdZpkaG19WaeSy6ewM
         +Q5HzbMVS0ytG8ZAompPoeKx9Zmch0rkRH+oL4s+mPXyL8vWJ5VWySd2KxRFGCtdkIwm
         mxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731943882; x=1732548682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SL26rYsrtN4hmxA848OOs2L0AxWw3nY8w+G/tYjnXyE=;
        b=VN8b4afzmaWB8+tmpQjVvN4s+mMPOCXrc4zo7goPI1qr/bQjywigCIrXxgR0HiIMbe
         0kjtsE+T5wwavTr1Fjt5xgXE+VFrYubiInh/yl7t9/x8iaIGDNBg3MLw2uv+eQCozRXX
         28rvQIWQ1cWSQDFvqQYm5DuU+au/W8iuZpu1vHtA6FTkczxIscwxo8RBUXCthNmVFP9H
         E7vQRxi+eg1jrhlvzpaTsoInm9TKzOUrHiD+Ork1hFLyEY9P4dnuzbUqQicOUXyYZcuY
         Fu4orGTfmBwKj/q99lfdPNKfnEwVZIL6gvcrz0NYHc3exxZrryc/wi6Xsd6+QJqMZJn5
         8JLA==
X-Gm-Message-State: AOJu0YxMCU7jTC1RWeWO333LfQI2DDnP2U5Rbo0iIv1iGT9P1HwT9H3Y
	qUgh383YBvg+BsfIPK9mff4ya4yk8GkqWGh6qUu99GOFGxbVxnn8HswD5wD07OvpaYcd4bo4BwM
	x
X-Google-Smtp-Source: AGHT+IHiPdMgpJOayUT2w8e9vZ6X9qxQaXqp2lOJfpXOHyOMIcTx/4ORKyjdxY9asKMhc0rUQ+t+NA==
X-Received: by 2002:a17:90b:35cd:b0:2ea:49a8:9169 with SMTP id 98e67ed59e1d1-2ea49a891b6mr11340031a91.7.1731943880523;
        Mon, 18 Nov 2024 07:31:20 -0800 (PST)
Received: from fedora.. ([240d:1a:3a7:a400:9a57:aa11:487a:b54f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea89d3678csm1483118a91.43.2024.11.18.07.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 07:31:20 -0800 (PST)
From: Ryosuke Saito <ryosuke.saito@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: raitosyo@gmail.com
Subject: [meta-cgl] [PATCH] ocfs2-tools: Add missing readline dependency
Date: Tue, 19 Nov 2024 00:31:17 +0900
Message-ID: <20241118153117.307424-1-ryosuke.saito@linaro.org>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 18 Nov 2024 15:31:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/819

This patch fixes a build error during the ./configure phase:

| checking for readline in -lreadline... no
| configure: error: Unable to find readline library

Adds readline to DEPENDS to resolve the issue, enabling proper linking
during the build process.

Signed-off-by: Ryosuke Saito <ryosuke.saito@linaro.org>
---
 meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb b/meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb
index 28b82c2cda94..69daff031a04 100644
--- a/meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb
+++ b/meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb
@@ -31,7 +31,7 @@ inherit autotools-brokensep pkgconfig systemd
 
 DEPENDS = "corosync pacemaker \
     libxml2 linux-libc-headers libaio \
-    e2fsprogs e2fsprogs-native \
+    e2fsprogs e2fsprogs-native readline \
 "
 
 
-- 
2.47.0


