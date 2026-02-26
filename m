Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3DBFCE06E
	for <webhook@archiver.kernel.org>; Thu, 26 Feb 2026 12:47:30 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.69016.1772110049771526930
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Feb 2026 04:47:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QJ43C0AD;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4398ebdf520so1243308f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Feb 2026 04:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1772110048; x=1772714848; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=goSjPxdjmqbuVM5JpYLE5QbGZRfVBziVWSTqXSIvUiM=;
        b=QJ43C0ADjGA7HJrTOYZamEW+UQN2QWahI9zWDAST0SUS7upU9Iayips2cE+nsj2Q5Y
         gpmkTs191Wd2OFcUTYpPZmCaJ+YDiMJDuklNph4fP7XbRNyKK1FMdvPvTjCd/c2QG/ex
         0gdTmjtJtDm9ICh33NBdzPtXBGSQwRf+wlA2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772110048; x=1772714848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=goSjPxdjmqbuVM5JpYLE5QbGZRfVBziVWSTqXSIvUiM=;
        b=S1/khVtyOJLPm2UqFMc04MG6/oaGDurPZfuD+AyUSnpDx+B2alMEif9DOxGbi9CBbK
         fUMWz3V6Q2JVzydoLrM2YUh1B7Pu/NBduY3Lr4NO046epxTVIbGSVQ38cGiXwlklnPDB
         kVY7jYUNRw/jCPJXrELksg1hRqWwBpE/RW8hRgDGjy9EiciA5kZwWf6twzeB5DwQry8R
         AQUDAYGfnDka5yrvq/lwKHyv9D3Oky+dLOO+GZYvB359OXWuvAidZPoxDyRWCvfMsey5
         IZ/bD5tcs/N3CaPv0PQm59Fr+bsBxGSPJpovF/gIN1lNZS02HmBxYywKEyMqSlxcab+g
         YDXw==
X-Gm-Message-State: AOJu0YwvoCcJe6FEzIvJsqMFbHzASXYiiLowoA1u2QAybfGsEV5+eKb7
	7E0IHt6JuT/gObZJEb01OTKATFKxHPacF8pnSPPZJMgeIPcABOGmV56VcAC/tVUSgXAZk3aO/o4
	mx14Ye/A=
X-Gm-Gg: ATEYQzwDmTY7zFG8jywUjkQED0kztuXmlx3vMRtY0eFiF4qIpf7AdUy6k9Rm9ZcUNJ3
	roEU36cEAbvBSLWFzxMcu6p7neOMGaBpcunyQNxUbFoJ7Q90vqVgfcO5y0bGTjT3CJa1z8UG6VY
	cgkQJTxbUApmZ3vdvTt6o52nNwjDzy40+Vz/fC40w3RS8kBwBMG7sLhZh5goiPkf0ibE+zz18tR
	vGawLDkl32OGEJF3TDUCWYkzg6dBWLVjOKPRkX16RoqTISxhaXU9kjmJTB1M+0ivu61JbbVuSDM
	isKtwkmL/JbsRpGZ9BhbPYZfFl5WdnIuA0xBevrjZAMMAbvFBe3aETEt+1SPUM7G+a/UB/2baas
	haVN4kXHCRIVAvluneLINTXghOlr46iepaFrlyHxzRmwKJ48OD6egs+P8kFrb12Ruiyhw7tceIH
	+U21COB1FwKRk1o+Ic6mjBaTHjCop/Kky1gepK/LTbQaUrXbX/hqA=
X-Received: by 2002:a05:6000:144c:b0:439:909f:c594 with SMTP id ffacd0b85a97d-439971ae7f0mr5724431f8f.10.1772110047574;
        Thu, 26 Feb 2026 04:47:27 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:caa1:9aad:9b9e:38c6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4398fefa3f8sm10855302f8f.36.2026.02.26.04.47.26
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 04:47:26 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH 3/3] config: Fix riscv build triggering
Date: Thu, 26 Feb 2026 12:47:23 +0000
Message-ID: <20260226124724.717336-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260226124724.717336-1-richard.purdie@linuxfoundation.org>
References: <20260226124724.717336-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Feb 2026 12:47:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3284

Having builds added to 'master' like this is problematic as it doesn't work when
we branch for releases. Rework the code to remove riscv on the older releases
where this was never tested instead.

This does mean the builds will be added back to whinlatter where it was accidentally
missing. Take the opportunity to add fast ptests to a-quick for riscv too.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/config.py b/config.py
index 947b15f2..f68f1207 100644
--- a/config.py
+++ b/config.py
@@ -74,6 +74,7 @@ trigger_builders_wait_shared = [
     "qemuarm64", "qemuarm64-alt",
     "qemux86", "qemux86-alt",
     "qemux86-64", "qemux86-64-alt",
+    "qemuriscv64",
     "qemuarm-oecore",
     "qemux86-64-x32", "qemux86-world",
     "multilib",
@@ -94,7 +95,7 @@ trigger_builders_wait_shared = [
 ]
 
 trigger_builders_wait_quick = trigger_builders_wait_shared + [
-    "oe-selftest", "qemux86-64-ptest-fast", "qemuarm64-ptest-fast"
+    "oe-selftest", "qemux86-64-ptest-fast", "qemuarm64-ptest-fast", "qemuriscv64-ptest-fast"]
 ]
 
 trigger_builders_wait_full = trigger_builders_wait_shared + [
@@ -104,25 +105,28 @@ trigger_builders_wait_full = trigger_builders_wait_shared + [
     "meta-intel", "meta-arm", "meta-aws", "meta-agl-core", "meta-virt", "meta-qcom",
     "qemuarmv5",
     "qemuarm-tc", "qemuarm64-tc", "qemux86-tc", "qemux86-64-tc"
+    "qemuriscv64-tc", "qemuriscv64-ptest",
 ]
 
+trigger_builders_wait_quick_noriscv = [x for x in trigger_builders_wait_quick if 'riscv' not in x]
+
 trigger_builders_wait_quick_releases = {
     "master" : trigger_builders_wait_quick,
-    "styhead" : trigger_builders_wait_quick + ["qemumips", "qemumips64", "qemuppc"],
-    "scarthgap" : trigger_builders_wait_quick + ["qemumips", "qemumips64", "qemuppc"],
-    "kirkstone" : trigger_builders_wait_quick + ["edgerouter", "non-gpl", "qemumips", "qemumips64", "qemuppc"],
+    "styhead" : trigger_builders_wait_quick_noriscv + ["qemumips", "qemumips64", "qemuppc"],
+    "scarthgap" : trigger_builders_wait_quick_noriscv + ["qemumips", "qemumips64", "qemuppc"],
+    "kirkstone" : trigger_builders_wait_quick_noriscv + ["edgerouter", "non-gpl", "qemumips", "qemumips64", "qemuppc"],
 }
 
 old_arch_full = ["qemumips", "qemumips-alt", "qemumips64", "qemuppc", "qemuppc-alt", "qemumips-tc", "qemumips64-tc", "qemuppc-tc", "meta-mingw"]
-riscv = ["qemuriscv64", "qemuriscv64-tc", "qemuriscv64-ptest"]
+trigger_builders_wait_full_noriscv = [x for x in trigger_builders_wait_full if 'riscv' not in x]
 
 trigger_builders_wait_full_releases = {
-    "master" : trigger_builders_wait_full + riscv,
+    "master" : trigger_builders_wait_full,
     "whinlatter" : trigger_builders_wait_full + ["meta-mingw"],
-    "walnascar" : trigger_builders_wait_full + ["meta-mingw"],
-    "styhead" : trigger_builders_wait_full + old_arch_full,
-    "scarthgap" : trigger_builders_wait_full + old_arch_full,
-    "kirkstone" : trigger_builders_wait_full + ["edgerouter", "edgerouter-alt", "non-gpl3"] + old_arch_full,
+    "walnascar" : trigger_builders_wait_full_noriscv + ["meta-mingw"],
+    "styhead" : trigger_builders_wait_full_noriscv + old_arch_full,
+    "scarthgap" : trigger_builders_wait_full_noriscv + old_arch_full,
+    "kirkstone" : trigger_builders_wait_full_noriscv + ["edgerouter", "edgerouter-alt", "non-gpl3"] + old_arch_full,
 }
 
 trigger_builders_wait_perf = ["buildperf-debian11", "buildperf-alma8"]

