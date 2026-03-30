Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B83210F3DF1
	for <webhook@archiver.kernel.org>; Mon, 30 Mar 2026 14:22:31 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.52733.1774880541431670350
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 30 Mar 2026 07:22:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=avua8PGD;
 spf=pass (domain: smile.fr, ip: 209.85.128.46, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486fe655187so59461405e9.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 30 Mar 2026 07:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1774880539; x=1775485339; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MDnPflWYOG4Gt9dJ1ydVNl4r96B0szCEsdShvoL8wG8=;
        b=avua8PGDCHtHG2M2A/LxgiDbLOSFhPZl/3/f7LJh1GXTzLNccSQ62M6FFgivx+ELa/
         efmwiivWseKkbLirRQOqQwy7+rKOxrDEIsdowht15vdNy0YhFCedRp43EgZhiCTs1Tyd
         juV2iFgPy//FCHWoezRqbW0mAeRJGe4iK6Ld0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774880539; x=1775485339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDnPflWYOG4Gt9dJ1ydVNl4r96B0szCEsdShvoL8wG8=;
        b=BbDFcKbrmFoxyKXUJEfMTtXGPZltwx/SkND69aWTNsm/6SBUcQHN3zypMSkW+uop45
         jUGnqKzqugu+qQ5UdQsWJwyG7wx6/39fJaB492sC9omzfY+lqplNEf2fLaxBz+n+0Rdc
         F5lgwh9xWq+JEeS9bif8ccF7UNhegsvfhVgvFTeZcdKYE9Dhlnz8EkWlMi4wto86b0r4
         fDQuvzbLVxU7MbPFoG2s8JrTSsq+BbztPR32q7/1qOgnHSOQEZocVogrnoFJrOKYfisw
         BqiGqJL00/qaHBZbO0Qph0tsg4vmPhOpMeW3PMwBaYs6fKne+LPsn1/D/z+whAhusIgk
         B+rQ==
X-Gm-Message-State: AOJu0Yz1UK5yxC4EK1p+ndDAP6/MZ0qmRtSqNmZmqhzyclAFwNk2um8B
	HFscRSc5RGyy1ShcPUBdAoDINtDHNnrgiVCJODrUilQ4zhWxg5fsPJ0uTKRa4wqbxkWi0LMSeWF
	5VsRzHyk=
X-Gm-Gg: ATEYQzwhowC8yizEH/PzAOb7hAY6bC538KGGTesLvuVOT8NT3X9YE7RVuBrnpJBqxNO
	v4ZQZMCMf2nQv0BFvIBM8dVQRPz7mH6AXGln3ry8pr7ypREAQh+Jz1XeT/BjA42l6YcX4GKCqsP
	+vuhkf96xlCRLjtFADQf6KQEvFzN3IWsZB8P6tlwwLswzioiuuQzcyQ4myq2bsDrwxXjRkS5dD4
	PQ+EN1uafaKGXnzh09gJh358X3D039CnphjdKeaFW3fQ5DsjduaQ+pDk49sOh80S+RXyXMxXQpx
	Pq3aeT8+p5/4X/e5MpJWkYcK0Y8pgZgt36PbtE+EUfmC0P34oJ3kV/KzL9X4djfP6W3SVLiIR4n
	ibZvvuMc9Zmn8RLk2RT44D7Q/wJr9EPqxVq9P9O7AJ093HClD9rX6OsAd4b/kU0vm9hlEC4t5RN
	oczBNw5Wcujjtz9JEAQ0iNZiGneSmcREK8WnpQ2DtN4oToN7P5UVAaG1/jisnzhBraPCibz2RHC
	RqrdEtraRSOt3LAcqmHdB4/KU7WaFmCAQ==
X-Received: by 2002:a05:600c:a11a:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-48727ee5405mr145870955e9.29.1774880539287;
        Mon, 30 Mar 2026 07:22:19 -0700 (PDT)
Received: from FRSMI25-LASER.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4873bbcac33sm84715235e9.15.2026.03.30.07.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 07:22:18 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder-helper][whinlatter][PATCH] run-config: drop one more checkvnc usage
Date: Mon, 30 Mar 2026 16:22:14 +0200
Message-ID: <20260330142214.3533859-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 30 Mar 2026 14:22:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3584

From: Yoann Congal <yoann.congal@smile.fr>

Reference was missed during a global removal in
commit 29abc96b6310 ("config.json: Drop checkvnc usage").

This should prevent this warning on AB:
  Xvnc not running, attempting restart

  WARNING: vncserver has been replaced by a systemd unit and is now considered deprecated and removed in upstream.
  Please read /usr/share/doc/tigervnc/HOWTO.md for more information.
  Killing Xvnc process ID 4057
  Xvnc process ID 4057 already killed

  WARNING: vncserver has been replaced by a systemd unit and is now considered deprecated and removed in upstream.
  Please read /usr/share/doc/tigervnc/HOWTO.md for more information.

  New 'stream9-vk1:1 (pokybuild)' desktop is stream9-vk1:1

  Starting applications specified in /srv/pokybuild/.vnc/xstartup
  Log file is /srv/pokybuild/.vnc/stream9-vk1:1.log

[0]: https://autobuilder.yoctoproject.org/valkyrie/#/builders/68/builds/3580/steps/14/logs/stdio

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 scripts/run-config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/run-config b/scripts/run-config
index 7da11c4..a13cc58 100755
--- a/scripts/run-config
+++ b/scripts/run-config
@@ -300,7 +300,7 @@ def handle_stepnum(stepnum):
             addstepentry("test-targets", "QA targets", shortdesc, desc, str(sanitytargets), str(stepnum))
         elif args.stepname == "test-targets":
             hp.printheader("Step %s/%s: Running bitbake %s" % (stepnum, maxsteps, sanitytargets))
-            bitbakecmd(args.builddir, "%s/checkvnc; DISPLAY=:1 bitbake %s -k" % (scriptsdir, sanitytargets), report, stepnum, args.stepname)
+            bitbakecmd(args.builddir, "DISPLAY=:1 bitbake %s -k" % sanitytargets, report, stepnum, args.stepname)
 
     # Run any extra commands specified
     cmds = utils.getconfiglist("EXTRACMDS", ourconfig, args.target, stepnum)

