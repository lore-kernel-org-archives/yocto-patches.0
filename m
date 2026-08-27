Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8369C61DB9
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 08:40:47 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31588.1787820045574762909
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Aug 2026 01:40:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=oT3VqNtP;
 spf=pass (domain: smile.fr, ip: 209.85.221.51, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4815bce4652so1145384f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Aug 2026 01:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1787820043; x=1788424843; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E+M3nzW/LczqjvDHMBOGXVf4rOgDQ3xQ40XkGU32pvA=;
        b=oT3VqNtPHtidVN2EBqYjZlXPPlD7qxYyFejSJyZoxoKBLlEFLyz5TG3ftneQgmicTl
         QD6SuJCoodhPrGmaLWRq2TX5rLGQG6Tr/Z/SPTvGXQWL29ba1kwOlXII8ZSzivuF7kCD
         1ldM48aiz3IH5fN2l1Hb54qPQdk2H3Y1mtS7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787820043; x=1788424843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E+M3nzW/LczqjvDHMBOGXVf4rOgDQ3xQ40XkGU32pvA=;
        b=hCv9mHV7nmQWJ4RgdsJ8HwEhbYZ4kpcyhBr38PXQttzjTk/wgUdyFAu3YEJDWkmuP1
         z8MElJOQt3HSFtzvxGfjfHZrGh+mpYtJt3QiUUJboEYMy4q7rAFRWcpM2NWHVd9Gujxy
         3sNelIfChH6ZcTb02R6hzO46aeSmhhT7p9gL62TpNjjRDN6Q8PMn+MX3xyhQM2Whu2qE
         NGxflBf3qOITQ7EUW4zwjRPbKTe8YpNSnECJ1fIIdVhGNsw1jpQBw66WPsXJZ438GWFT
         sMZg/gXi84Xz9CvRx/miy3ucczhtfNdxljY4qbgcJ+9UD4YOnt4LBY194lXMzJxEAWXK
         uHhg==
X-Gm-Message-State: AFuF++khHcEXtOOY2+UaXOWPwGTi28BAVMxpTT410kvIq9mBqc2wKrdj
	Odb1j8e/X51qn+Quk0Bkm6KkACNRjW1BNm44FgfUBU6GLVASs7904FsQHCbqxmkswRprgFVwNpz
	tVn6OraE=
X-Gm-Gg: AR+sD12SDild6/bAEBXKOy8B4f3pNppNN4LcbUl59ym4CpIEbE22lKE5GAQxRnZKBWu
	c1BEsxgtWHWlfixFbLPg9kOvI/H8g1Sd1F/FvuIEQ1ffx+ZeRjJ4KH2piD6BQr/retySpY3DuTB
	u9Kov4MWZf+Fp6Tf1KJTW4uJn7bxht29Xob7OnQAJPxPX3TlIQl/yj2N0dgBnL1HHyedUIWp4fn
	KwHmSIkVazQqSiUOdVjUv9aDkAhXOf9RRN2m1c2+FjA2ZYF0LAuTzcY2FgVwAwClooSIyCnzGro
	c1c0trHH1SuEk62rprGjLQSGMJM8eFpfhNYF+8xSETEQ3mPfOoPwxaLjdEizMUDiLgqrxBN37oM
	446bFe/YJ1djcLE9L24mZiEo+VIjWEfDLOXlmO3uJSBCf2Q04ews+11iRWqVdEqF56wNisFkOWM
	gkAKGjMVwPjn6CU30TmzOHMS09KbDk3O4EWvcySIOsn5sQTNhW3aDu2sI1pRpb0VKDVCxdf/ibB
	dWNTgIsh4uKtxBrDZzpjooi79lpHY0+ZsCeJRtv3Ooe2Yi4qODsC1D9Jl3QZxrI
X-Received: by 2002:a05:600c:4e4d:b0:495:5890:8f6c with SMTP id 5b1f17b1804b1-499dc7081f2mr148957955e9.7.1787820043490;
        Thu, 27 Aug 2026 01:40:43 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499fa55f4f3sm43031585e9.0.2026.08.27.01.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 01:40:43 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder2][PATCH] config: add mixin-wrynose-linux-firmware repo to a-full
Date: Thu, 27 Aug 2026 10:40:28 +0200
Message-ID: <20260827084028.1896945-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 27 Aug 2026 08:40:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4709

From: Yoann Congal <yoann.congal@smile.fr>

Without this, meta-qcom/wrynose does not find
mixin-wrynose-linux-firmware in the shared repos archive[0]:
| ===========================================================
| Copying in repo mixin-wrynose-linux-firmware (1787813774.7)
| ===========================================================
|
| tar: ./mixin-wrynose-linux-firmware: Not found in archive
| tar: Exiting with failure status due to previous errors
| Traceback (most recent call last):
|   File "/srv/pokybuild/yocto-worker/meta-qcom/yocto-autobuilder-helper/scripts/shared-repo-unpack", line 71, in <module>
|     subprocess.check_call(["tar", "-I", "zstd", "-C", targetsubdir, "-xf", "%s.tar.zst" % args.cache_dir, "./" + repo])
|     ~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
|   File "/usr/lib/python3.14/subprocess.py", line 420, in check_call
|     raise CalledProcessError(retcode, cmd)
| subprocess.CalledProcessError: Command '['tar', '-I', 'zstd', '-C', '/srv/pokybuild/yocto-worker/meta-qcom/build/repos', '-xf', '/srv/autobuilder/repos/a-full-4593.tar.zst', './mixin-wrynose-linux-firmware']' returned non-zero exit status 2.

[0]: https://autobuilder.yoctoproject.org/valkyrie/#/builders/113/builds/1490

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 config.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.py b/config.py
index 615c5ae..6058a9a 100644
--- a/config.py
+++ b/config.py
@@ -8,7 +8,7 @@ baserepos = ["bitbake", "oecore", "meta-yocto", "yocto-docs", "poky"]
 # Repositories used by each builder
 buildertorepos = {
     "a-quick": baserepos + ["meta-intel", "meta-mingw", "meta-gplv2"],
-    "a-full": baserepos + ["meta-intel", "meta-mingw", "meta-gplv2", "meta-arm", "meta-aws", "meta-agl", "meta-openembedded", "meta-virtualization", "meta-clang", "meta-qcom"],
+    "a-full": baserepos + ["meta-intel", "meta-mingw", "meta-gplv2", "meta-arm", "meta-aws", "meta-agl", "meta-openembedded", "meta-virtualization", "meta-clang", "meta-qcom", "mixin-wrynose-linux-firmware"],
     "non-gpl3": baserepos + ["meta-gplv2"],
     "meta-mingw": baserepos + ["meta-mingw"],
     "meta-oe": baserepos + ["meta-openembedded"],

