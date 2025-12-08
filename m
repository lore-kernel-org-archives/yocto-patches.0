Return-Path: <t.f.g.geelen@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB63FD3B7E2
	for <webhook@archiver.kernel.org>; Mon,  8 Dec 2025 22:31:38 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5889.1765233094409376320
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 08 Dec 2025 14:31:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=cSHvQYqA;
 spf=pass (domain: gmail.com, ip: 209.85.208.46, mailfrom: t.f.g.geelen@gmail.com)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640860f97b5so6493782a12.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 08 Dec 2025 14:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765233092; x=1765837892; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/mB824KNwjoxxdu686mT9/MHn9SfkojoD59o0J9TxcA=;
        b=cSHvQYqAeIFrh4fYjSIqdDWSSMetN50d+TkZ3iRbPLVcH7YrScdQeXhpJXAVD3qXJa
         Cu6GhZrSiolvOtxOzOluvbI+SpzTsukCcz0C5v3ruMqjHMAp9wfK/W1HuKv4BtHLZFrI
         8Xz2k1LmmVLvBj5bdoQwTfnGDJ8/X9cLawQgicLwzxTUNEfJn1KOp4zq5t6vz7rshw29
         8fjXjt1OsJLQWKHzq9310JqB4aMGJZTXvsPH7DdScZAJrsYbbIpdYeM8QW0oblJrt5ry
         2IjJ1desQqiBocsf8BoTGwdyDyl7Ld0MQwe6n9bfuONtPzFiSKXYw3P0Kz2tSWQ1xqS7
         OoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765233092; x=1765837892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mB824KNwjoxxdu686mT9/MHn9SfkojoD59o0J9TxcA=;
        b=CAvrifu7wrt7Iw98/lZr0aYBMDSiV4GkgqwrWMKVdpNapQu4VkwssKqJrQ/18xcWU5
         SvWBMHQqwyUdd+1vh1IdPPWRGTUSEkeliC+f1IoiGbgTW9VtIS65GCdnpflAgmVY+5KL
         oJVqnFdNMNfORB01R3SOJBkJm9xa83aUoMtENSLQQiv32gSuY/+PSqlAqSlxZNv6whPj
         5kh3CbpiH7UFswwijJmIrwCpXLTAHbfz0wv3vPPBKJonj4mwBB+tkdM0DA9wN1oXG0Mh
         +o0sNYrSZlgEa3C/bVmFKy55QInolHhUcoLuGPpkKpw+jx6HOP+1uaUrYiPzL/9m3LEm
         FjRA==
X-Gm-Message-State: AOJu0YwGeVp5/R9YpySWOHIFvWQfe72lXL103rTFbW1xQhAX/LidSeET
	dCJhphpXsop2LUcWXrsuncw9I8iw7SMmK7NEDcrqhI0AXNneG2nV96WAlDg6RQ==
X-Gm-Gg: ASbGncs3hWDPYpPZMFVARVmgSHhQdyRa2y5ONH+B+6ZWDFMXwTB+3e5Xz26zgM4EPpi
	IcxyxSLHcQXeJ2FOzf0b4dkEmf29KA2eRJRvHE60OeQJUjhaSKxCuOrbRum8qmRtSFIdX31I4Zk
	4+xOJPWeSrgUeWUe/zklszhgCar3PUIJz51+wmTCkTJRIh58MOkUB0pmEbea2i3vI3fCV2LPj94
	aLp9fKUJodhXYQRdiGf/BgS9kSD5+q1lXY7EK2I9I+pw3/n5UrK5TcltYhLK2ug0uqCu86m8sI/
	ZbXU+hjDx/8LLNO5q9XppmYPNAgyloff2ZKBaug/O2HcLBRtkF6A9V8baiAAKkjlvYOlESST2R9
	z4cq1Q5b+1eXZhGnVnUAphCmh3jzJVJwRaViBAt0P6QGTUomgOi7hPff9NJAEhpLfDk+iESOG4H
	FknRrvXU4YqfHLe27IFjnG+HLP8gGQ+vRIVeOhi9VznWbXLaXj1plTf+rKUF70Wow2
X-Google-Smtp-Source: AGHT+IGEK2glSeCvMneLjnKrfXJIDgqJL0WNjQ8kEWoR8l0+2F2dmViCIgm0F/FMcZHAN5IXJpnFxQ==
X-Received: by 2002:a05:6402:2347:b0:640:eb29:fc7e with SMTP id 4fb4d7f45d1cf-6491abf209fmr7737748a12.20.1765233092080;
        Mon, 08 Dec 2025 14:31:32 -0800 (PST)
Received: from control-center.fritz.box (150-12-20-31.ftth.glasoperator.nl. [31.20.12.150])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b412e2d8sm12229930a12.34.2025.12.08.14.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 14:31:31 -0800 (PST)
From: Tom Geelen <t.f.g.geelen@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tom Geelen <t.f.g.geelen@gmail.com>
Subject: [auh][PATCH 2/2] testimage: adjust qmp detection for testimage
Date: Mon,  8 Dec 2025 23:31:18 +0100
Message-ID: <20251208223118.374387-2-t.f.g.geelen@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 08 Dec 2025 22:31:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2751

When defining a testimage it will try to run an image via Qemu and need qmp. QMP is assumed to be provided. However this throws an error. Use the RECIPE_SYSROOT_NATIVE of the testimage and set up the paths using this.

Signed-off-by: Tom Geelen <t.f.g.geelen@gmail.com>
---
 modules/testimage.py | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/modules/testimage.py b/modules/testimage.py
index 849a9f1..0a0f924 100644
--- a/modules/testimage.py
+++ b/modules/testimage.py
@@ -73,10 +73,46 @@ class TestImage():
         return ' '.join(pkgs_out)
 
     def testimage(self, groups, machine, image):
+        # Minimal: derive native sysroot from the image's environment and expose it via PYTHONPATH.
+        try:
+            # Use the image-specific environment; this matches what succeeds outside AUH
+            bb_env = self.bb.env(image)
+            rsn = bb_env.get('RECIPE_SYSROOT_NATIVE')
+            if rsn:
+                I(f"AUH: RECIPE_SYSROOT_NATIVE (image)={rsn}")
+                pythonpaths = []
+                libdir = os.path.join(rsn, 'usr', 'lib')
+                if os.path.isdir(libdir):
+                    for entry in os.listdir(libdir):
+                        if entry.startswith('python'):
+                            sp = os.path.join(libdir, entry, 'site-packages')
+                            if os.path.isdir(sp):
+                                pythonpaths.append(sp)
+                    qp = os.path.join(libdir, 'qemu-python')
+                    if os.path.isdir(qp):
+                        pythonpaths.append(qp)
+
+                if pythonpaths:
+                    new_py = os.pathsep.join(pythonpaths)
+                    os.environ['OEQA_PYTHONPATH_NATIVE'] = new_py
+                    os.environ['PYTHONPATH'] = new_py + os.pathsep + os.environ.get('PYTHONPATH', '')
+                    os.environ['BB_ENV_PASSTHROUGH_ADDITIONS'] = os.environ.get('BB_ENV_PASSTHROUGH_ADDITIONS', '') + ' OEQA_PYTHONPATH_NATIVE PYTHONPATH'
+                    # Ensure oeqa picks up changes during task execution
+                    os.environ['TESTIMAGE_UPDATE_VARS'] = (os.environ.get('TESTIMAGE_UPDATE_VARS', '') + ' OEQA_PYTHONPATH_NATIVE PYTHONPATH').strip()
+                    I(f"AUH: OEQA_PYTHONPATH_NATIVE set to: {new_py}")
+                else:
+                    W('Native sysroot found but no python paths; qmp import may fail')
+            else:
+                W('RECIPE_SYSROOT_NATIVE not present; ensure qemu-native/qemu-system-native are available')
+        except Exception as ex:
+            W('Failed to configure PYTHONPATH for qmp: {}'.format(ex))
+
         os.environ['CORE_IMAGE_EXTRA_INSTALL'] = \
             self._get_pkgs_to_install(groups)
         os.environ['TEST_LOG_DIR'] = self.logdir
-        os.environ['TESTIMAGE_UPDATE_VARS'] = 'TEST_LOG_DIR'
+        # Keep TEST_LOG_DIR propagating alongside any previously set vars
+        prev_update = os.environ.get('TESTIMAGE_UPDATE_VARS', '')
+        os.environ['TESTIMAGE_UPDATE_VARS'] = (prev_update + ' TEST_LOG_DIR').strip()
         I( " Installing additional packages to the image: {}".format(os.environ['CORE_IMAGE_EXTRA_INSTALL']))
 
         I( "   building %s for %s ..." % (image, machine))
-- 
2.43.0


