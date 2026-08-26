Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B83C61DBE
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 19:58:35 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21291.1787774313083318536
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Aug 2026 12:58:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=nI5HZxI3;
 spf=pass (domain: smile.fr, ip: 209.85.128.52, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49978908b35so9525275e9.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 12:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1787774311; x=1788379111; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oBSprQBFPqEzKg6cuPkbL85SPZpfhuiFXK54dWzUtGg=;
        b=nI5HZxI3MDv1FCLTV1h7LEfOY0amSindDXsn1oKjci6JvpuhRUhgh4pbwk7a7v5bOW
         5vlSQLFH/00CnlhGjnRAk8yTx+33Cj9bwb8gjf3SBUiu28cvTATpIbODy7N3vjic1vJ5
         u2L3G3Ue8Pcfg3BO+FGxn4o59oj1JdIK2KanQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787774311; x=1788379111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oBSprQBFPqEzKg6cuPkbL85SPZpfhuiFXK54dWzUtGg=;
        b=ozTvYiFkrzJ+yMe0z3GKkyMrJadLHf1NtOnbExxjoKCN/jFpIWxIZ/oOcp1ZWCXY/f
         a067sBBqcHnAuXZejBHoN5HKCi+7uVRjHi4/Y3NhZ9WR5OmWYEGF9C8Z0D0CSjkwUX4J
         pZU/NkQWk31Gn3q7RwrOtKScaWl+nZaRVrpchr9rJK1KOO0LtFF4qSiJVf7GqqOOfpiW
         6ikuMKaDUh7Xib4AHCmXYGWQ1mfyqAFhjdWuTsxNKQ+w76l6CrwCWPCClm6k8astF0fY
         q7dvKnUxT+N+NPgMX3juWU/uJ416vXPJPHksC0as/8gx/uHjl9DWX8iyqN1oljtDDVJ7
         Xqmg==
X-Gm-Message-State: AFuF++mwNZ7LucSCS5QLKt70jBNXIbOmiZOkxmIduGtPcKSh3ud2rFNr
	sb7qoW58b9WFjvuqfKCHep8pXy7e3PPlbNUm3XqAjPk+taSaDCV2bzPiV5o/2zEQosW/he5Q48s
	18+AO4HQ=
X-Gm-Gg: AR+sD10LKvTeA/6H4thYHUtOEGe5m8/Ez2tIc4gsqcxel1kliefOkbPKmjwOUxJHowS
	4EXsqnW3gpK6RALFdkKXMcBfCRxf4yC638w5oZDUvmpVSSTAnFYJsNqufWWZglwNKPrYTq2L+tk
	xYi+3cl61UxDSANnePwyxvVY33mEnip+77u9CrjxbG58E86WI6Q12x/B/gkggbzbqpyMCjHBxlW
	uZjfn3ebF9hyCk9fU4erwhhRFTFt6w+YZCT/C13L42rE6yO4GGgGSKHkBxnTVFo8Bg+5ed0Wplh
	wpgp4/TWjvV0PZh89yWgr0gVEA5naIvmT7vkzcDlU+jcHiYk7o7UpOoB9Bkk2+esin0k9GPerVA
	OVkl6BxfKZ0qoT0+kFFRjDcuVy8FijlIjo8bryLWO2C5uyEk/09m9WCndpDmKqzwMEgMRfV3/j0
	R3d/GIx9TYse9hsyZibtIWBmLAoA/PikdLwK0m9Z4m9xGrZ+I7fAXPErPgOqyQanG7dga5/+k0Y
	lrw0L6tCchdcIzFNdlVNhv0LnjMK0LDoYW3k8sIWjVy7mmUoP82bbv4RWDrTAUM
X-Received: by 2002:a05:600c:3f0e:b0:495:4749:16a7 with SMTP id 5b1f17b1804b1-499dc825cfamr109269385e9.14.1787774311176;
        Wed, 26 Aug 2026 12:58:31 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499dca9e10csm37208195e9.7.2026.08.26.12.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 12:58:30 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder2][PATCH] config: Add mixin-wrynose-linux-firmware to meta-qcom builders
Date: Wed, 26 Aug 2026 21:58:19 +0200
Message-ID: <20260826195819.1136698-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 19:58:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4691

From: Yoann Congal <yoann.congal@smile.fr>

The wrynose branch of meta-qcom depends on the lts-linux-firmware-mixin
layer. The repo was added to the repos dict in c12bde1 (config.py: Add
wrynose/linux-firmware branch of meta-lts-mixin, 2026-07-10), but not to
buildertorepos, so it never reaches layerinfo.json and
shared-repo-unpack never clones it.  layer-config then fails on the
missing directory:

  File ".../yocto-autobuilder-helper/scripts/layer-config", line 43
      for f in os.listdir(source):
  FileNotFoundError: [Errno 2] No such file or directory:
  '/srv/pokybuild/yocto-worker/meta-qcom/build/repos/mixin-wrynose-linux-firmware'

See https://autobuilder.yoctoproject.org/valkyrie/#/builders/113/builds/1473
and https://github.com/qualcomm-linux/meta-qcom/issues/2457

Branches other than wrynose are unaffected: the extra layerinfo.json entry
is ignored unless the target's NEEDREPOS asks for it.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 config.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.py b/config.py
index 23a129a..615c5ae 100644
--- a/config.py
+++ b/config.py
@@ -18,13 +18,13 @@ buildertorepos = {
     "meta-arm": baserepos + ["meta-arm"],
     "meta-agl-core": baserepos + ["meta-agl"],
     "meta-aws": baserepos + ["meta-aws", "meta-openembedded"],
-    "meta-qcom": baserepos + ["meta-qcom"],
+    "meta-qcom": baserepos + ["meta-qcom", "mixin-wrynose-linux-firmware"],
     "meta-clang": baserepos + ["meta-clang"],
     "buildtools-docs": baserepos + ["meta-openembedded"],
     "qemuarm-oecore": ["oecore", "bitbake"],
     "checkuri": baserepos,
     "check-layer": baserepos + ["meta-mingw", "meta-gplv2"],
-    "check-layer-nightly": baserepos + ["meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-openembedded", "meta-virtualization", "meta-ti", "meta-security", "meta-clang", "meta-exein", "meta-qcom", "meta-riscv"],
+    "check-layer-nightly": baserepos + ["meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-openembedded", "meta-virtualization", "meta-ti", "meta-security", "meta-clang", "meta-exein", "meta-qcom", "meta-riscv", "mixin-wrynose-linux-firmware"],
     "docs": ["yocto-autobuilder-helper", "yocto-docs", "bitbake"],
     "reproducible-meta-oe": baserepos + ["meta-openembedded"],
     "patchtest": baserepos + ["meta-patchtest", "meta-openembedded"],

