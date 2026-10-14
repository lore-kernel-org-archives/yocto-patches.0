Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE6DCC6B1A
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 14:12:32 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14763.1791987143352147844
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 14 Oct 2026 07:12:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=eLx19VlH;
 spf=pass (domain: snapchat.com, ip: 209.85.128.54, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a180fbeef5so38072575e9.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 07:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1791987141; x=1792591941; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gq++ZxTkOerj6T+MnmkCNW2urA31JUWWKfFwVpv8xPI=;
        b=eLx19VlHVQuIswHsAhYOA8hUr7fFRgmJge3szv6EF2sH5g1tR+63aIv1mE2lcvi4Mp
         LrJ6R7DkIgMExNW54vcuqhfXFdKsfNt9T8Tdn50r8wDQbpzeM2s49wExJs1xC4tzG/Tx
         v69irOIaFkQGLzARb53RWFN/ry89Jdwv6g7S0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791987141; x=1792591941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gq++ZxTkOerj6T+MnmkCNW2urA31JUWWKfFwVpv8xPI=;
        b=pdZzqPJEHWTyY6AMANGMU0XQlRe1n9Gmq7x2pmNZhUrYkFnryavDNDWfwWGLx8ydGV
         b3i7xqpAKo0FlH73jfQDCpY7fZyGGwNWugXcEEyyzJaMh3QX/vB+/hiUJzkqSiWsS/wE
         2ap2UkcJ1+7jzy3NUIL/0pKNQtJ/yG0PGyZe92s53gSeivssuc47jShdjKTGWQ8g+Ccz
         pr4Vt/R1AAEaUaTaQCDMYW+AWVnjImxuskv8poG7e/gXs5pVuN1azbqO/70tYX1uRQQR
         pUxWI7uFyO3O9hqIT2cH2Hz9OGVz63eWpb3OwnQvkd7mW/YsrjljzpJDiMZLxSYw8Wqt
         ZDyw==
X-Gm-Message-State: AFq9FYJiwIl2VbtkhMkMx+vULoWmPGjnUGTZEfGvlI/wtHoUGg4pdNEk
	UxSmII4cJFOuB8rGeRJnEYLUrfG+DqZx/jIexNbUdxBNvSGpZvae9dklj6XM05crbZgRrhy3EtW
	6V39KQBc=
X-Gm-Gg: AYBFou0U9SXWM1WQmg7ZsIbvTRp2bJSicZec4BMx4mAUwmzKkOlmKY+MjLrDHiIVc1B
	Cl8nxv8Ezs7I9bFPfPFmwVIBXVQRl8jCPN9Rllq60sL7Qiao93dJolMhaOrRVBRh3eiflf+n/z+
	ywtmsB4PjowWjbjMKvJrNJmjMs6Q9+MypggjRaZDG3gurFlKs2P70uybISf0Ggr5dFFs8hjkBFv
	qJHnydSzDz+DHONArR8xx1w7AIujh3dn4rC5DasSeldIOTYOJH0cdkueFLKV2XcyCcSKGOXA60w
	caXGfGwVLXrbby7gPE0JQcLHHR7tC2kDUfafPkpQfr6B/8fdv93deVHHrobdse7d8yjSqeZqI84
	j6+gPbDkZMM5NYoLPVIG+Cc26xZl2drHQgjoNTeoiROAJzw66xH+nfeVtoOQz5Noc+yIVFFM7y/
	GAq8XiMjp2b8YKutAIjglA9/vPhxNIa/a/gMsQ8iiGL07pODQFdSV/4o64g3DJiPHjfSkD06qX3
	iyM+6r3aOBCCz0jbzpwTQ1eSJ42mRxR+BaTlJTY5w==
X-Received: by 2002:a05:600c:3f0c:b0:4a1:85d9:13be with SMTP id 5b1f17b1804b1-4a18e498471mr342128435e9.20.1791987141246;
        Wed, 14 Oct 2026 07:12:21 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd202e8esm299965e9.6.2026.10.14.07.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:12:20 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 01/21] meta-darwin: bump layer series to wrynose (6.0.3)
Date: Wed, 14 Oct 2026 16:10:22 +0200
Message-ID: <20261014141209.488034-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 14:12:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5006

From: Etienne Cordonnier <ecordonnier@snap.com>

AI-Generated: Composer 2.5

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 README          | 4 ++--
 conf/layer.conf | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/README b/README
index e04aa6e..ef2fec0 100644
--- a/README
+++ b/README
@@ -12,11 +12,11 @@ This layer depends on:
 
  URI: git://git.openembedded.org/openembedded-core
  layers: meta
- branch: scarthgap
+ branch: wrynose
 
  URI: https://github.com/kraj/meta-clang.git
  layers: meta-clang
- branch: scarthgap
+ branch: wrynose
 
 Layer Maintainers: Richard Purdie <richard.purdie@linuxfoundation.org>
                    Dominik Schnitzer <dominik@snap.com>
diff --git a/conf/layer.conf b/conf/layer.conf
index 6730f3b..1c00994 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -1,7 +1,7 @@
 # We have a conf and classes directory, add to BBPATH
 BBPATH := "${BBPATH}:${LAYERDIR}"
 
-LAYERSERIES_COMPAT_meta-darwin = "scarthgap"
+LAYERSERIES_COMPAT_meta-darwin = "wrynose"
 
 # We have a packages directory, add to BBFILES
 BBFILES += "${LAYERDIR}/recipes*/*/*.bb ${LAYERDIR}/recipes*/*/*.bbappend"
-- 
2.43.0


