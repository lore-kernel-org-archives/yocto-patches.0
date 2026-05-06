Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98DDCD342C
	for <webhook@archiver.kernel.org>; Wed,  6 May 2026 16:35:03 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23202.1778085296386618557
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 06 May 2026 09:34:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=B9mRp3wl;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44a786a9a35so3739072f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 06 May 2026 09:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1778085294; x=1778690094; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RMRcjiGwEOT2Ffv/Vo8MQgsoxW38+zQf4cANz4YtEjM=;
        b=B9mRp3wlVr9tqA6LGBlpi1sUwNa0cFcCwfJlKxk38lD/H5tqxCv9dqcCtjygVgXrZB
         9LmcwYPLghqK8oeIC/nLP9weAuqb7QcmHhOGKEk8eyetjLM/b7jYWyxzc2HcpJsIw0PT
         DOi4sDBtQcsrPB1m4yuqw+DPd3a6j7/P8n9X8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778085294; x=1778690094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RMRcjiGwEOT2Ffv/Vo8MQgsoxW38+zQf4cANz4YtEjM=;
        b=M1KEyiAp2j4HxEGemvpV5qGyw0Dm3x2q6EYXGkRy9s3G4B+a95A4tkUP1Arq1Aai4w
         KYPEqlvcfTuV//MOrkG2HVBCF21cDSSALFBde5UgMMu9ToCU9ACO9kAQtYBN5+FzCqZE
         g0bRjc29CVwzK9hyUO2+Rs6Nqj+nc4R3fL032dkofYs2vNCVnVnCuyhLhbvV2txIbGSY
         Nw3I043g2bLWxIPbuaePhcpUC+6QhFVDcTzkJLqgA9kLzImXfyB3W5SJcsosdwmgqZnY
         Y0+h0u+JUxwppqswsipFC47k0Y6NL2n1tx0ZoTvgT/GDrAk3YPK0TR+E9Lum04rvHIfv
         jL/A==
X-Gm-Message-State: AOJu0YwcNLeirr29Krt8PYD1xkqzc7Qtqr7VR9f0lDhoaQc0lDK3nVg1
	4QYzk8ilaVwziwzCPqfXFCfmTA5iQX/G5fjX29EebDFxeh09qkPp/51JzkCWMgvkdlGXGJUdyzT
	bfkuJ
X-Gm-Gg: AeBDieupv2Nwn0iysRBZrvKGK04HC672RmASHSlPflUuvNaywv0LUxxMuznKWzSR6cJ
	+zEdnKZPyll2UzFuRj1xf3gpiiqyvQ35b2hqN5VEFnwBN3gXQiyrvV191i9Rh8SgmmYYS1xbi+y
	IqkJjjDO0amiqJ2wF6tyVbx1qNaYycp8klb6qhwWcRMRVh4x2sAc+Y3sBz5D/9lnNUTa/9yU+yN
	4LJrggjj7bBlTg7rZnFb3SMJ/CKfXnZwYQXeC0jk3TL8z1qV0plncvTBXRK+h4DAMhhJ5B11+ve
	HTxsr8Cwvmbgwp2lGjpjjXe2PyePZSWyL6E06HUVlrvj7CH+gg/8i283JGxMcYkWP9SRGnL0Qgg
	1ZuTtGLVgOc9YobGQ9Sg+OULuniRre6NA4uYUmg1oFDF3gVmKlBLMQVm9Pv7C70tphCMNiY36gg
	z/UmlUcQUrFSst33JIhI59Om/6OCW9q8ErTYwPOah/W3Sd9yXfjDKnhTOwrQU7nNs=
X-Received: by 2002:a5d:6282:0:b0:451:be9b:5f79 with SMTP id ffacd0b85a97d-451be9b6047mr3883161f8f.2.1778085294382;
        Wed, 06 May 2026 09:34:54 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:5409:94a2:bd3e:6c21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960fd6sm14363629f8f.31.2026.05.06.09.34.53
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:34:53 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH 2/2] publish-artefacts: Update to include newer machines
Date: Wed,  6 May 2026 17:34:52 +0100
Message-ID: <20260506163452.2086-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506163452.2086-1-richard.purdie@linuxfoundation.org>
References: <20260506163452.2086-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 06 May 2026 16:35:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3929

Add genericarm64 and qemuriscv64 to the toolchains list
Add qemuriscv64 to the published images list

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/publish-artefacts | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/publish-artefacts b/scripts/publish-artefacts
index b024c09..e56e131 100755
--- a/scripts/publish-artefacts
+++ b/scripts/publish-artefacts
@@ -22,7 +22,7 @@ sha256sums(){
 TMPDIR=$WORKDIR/tmp
 
 case "$target" in
-    "qemuarm"|"qemuarm64"|"qemux86"|"qemux86-64"|"genericx86"|"genericx86-64"|"beaglebone")
+    "qemuarm"|"qemuarm64"|"qemux86"|"qemux86-64"|"qemuriscv64"|"genericx86"|"genericx86-64"|"genericarm64"|"beaglebone")
         sha256sums $TMPDIR/deploy/sdk
         for arch in i686 x86_64 aarch64; do
             mkdir -p $DEST/toolchain/$arch
@@ -131,6 +131,11 @@ case "$target" in
         sha256sums $TMPDIR/deploy/images/genericx86
         cp -R --no-dereference --preserve=links $TMPDIR/deploy/images/genericx86/*genericx86* $DEST/machines/genericx86-alt
         ;;
+    "qemuriscv64")
+        mkdir -p $DEST/machines/qemuriscv64
+        sha256sums $TMPDIR/deploy/images/qemuriscv64
+        cp -R --no-dereference --preserve=links $TMPDIR/deploy/images/qemuriscv64/*qemuriscv64* $DEST/machines/qemuriscv64
+        ;;
     "poky-tiny")
         mkdir -p $DEST/machines/qemu/qemu-tiny
         sha256sums $TMPDIR/deploy/images/qemux86

