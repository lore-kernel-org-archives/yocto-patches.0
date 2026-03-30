Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E194310F3DFD
	for <webhook@archiver.kernel.org>; Mon, 30 Mar 2026 14:25:50 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.52576.1774880740735953379
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 30 Mar 2026 07:25:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=qhF4bqp3;
 spf=pass (domain: smile.fr, ip: 209.85.221.46, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43cf906b007so883602f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 30 Mar 2026 07:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1774880739; x=1775485539; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gc6CrZbBDW59FfO6lF8Ln4qbLCdZkyloAJY+nxqEzoM=;
        b=qhF4bqp3fr6BgYNJH1EfumBpwTUvTB8gaFPJEpXuQeZWsKJ8N3aKZul5EdnNZm/t3c
         Jfse3DL1yAl1rZEaELJpYZuE0roSOZXsETj2/XQtTLERNrvyZEoj0kIliRZSXMtQ3+ad
         VoCGJLIZQLPzAgFYousQUCxYZIei5SRHdmiJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774880739; x=1775485539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gc6CrZbBDW59FfO6lF8Ln4qbLCdZkyloAJY+nxqEzoM=;
        b=KFr9VD8HElYFj9ixFFhKTitpnSI7nrs606qrN5hCruhh/NVvk6zN8DVFej90f2Pa5w
         GTlrNp4qC5VyA58A0TMmXkLuyRmcFop5bHqhREu88UQ0002EJ4KK/yT4sGz4QW9Mbk4K
         cRYjSgUoU/HSlSP4ZcMD922XWtDImBVzauAuLBejy/Bqj3omO5JLQMDEgGs44TfvTB16
         yD2K7U5BH8XbfBrLQSseqtVlegCO/wDQ+LBX/VE+wMlBM5jEExumw/13hlJh48eDlkiw
         XgBGBE3D3BjqQFH6nDnT7hDEl31jS3jxbr0xHhOuQm9yqd7Q/DwEjpzqjkVk4XTlCqgT
         pycw==
X-Gm-Message-State: AOJu0YwlvpZjMBDj/Z8OBAP2tbJWIeEUbECXIZ6tfGIMOYChG4nh3Vuj
	OTpqnY0zfwUNQ5A1AsLFGIxUD9JQEcIpaXvuTFHRVnUnIEcZtUkIZ8v5WAn+vP2wHoQJJN8+RaW
	0vzVMpaM=
X-Gm-Gg: ATEYQzz2XQyFaIU2JNJQJjgGwzbEQWGt02OH/qufk84oTKHBGpaq2dccxdNZR9M99sN
	cm7zue2nx9IOVguyH+g+w2PN9NXyiRJkyrj5ypErVMd/YozP4brNKGfhfkfckMsTkfzB3ACEknk
	/AqQ4zU7lDlVkMi62m4KR4BubktMwzRQiv6Y8PBaiu5JYAqRsERgDMqhpAkjNtbr7CGxA/zuT2Y
	ypsOxUHedwb+s5wyBgA5NS4ZPYGC1/OiNtAoggXTRertayeHL/yZhfg0fnbhm5JCJNrdfMnlsr/
	fyJs3iJVk8k5lV/k8foCwaePZ7MhtwRzW634MudB7zEmFhfuv4Gu+FpWhMt+ULxB1V8JRAa1qPP
	CrL3zE01XPoxP9RF8/xBehtlWrYFcByT9cL8sr0bClnM214gZMRfNO8j7E6ut/3KqgYurnF+YdN
	bn19dJAx7+GUe/+pKyqza3Y9Ez8SabqpgbDs/a/oprYuUgm1LlQ5cfz65+q15tHoINGrXsMzGJg
	58/CynmVSNd8/T9sEFsRZcKW1dDbLoK4Q==
X-Received: by 2002:a05:6000:24c4:b0:43d:61:6527 with SMTP id ffacd0b85a97d-43d0061672bmr5079360f8f.27.1774880738774;
        Mon, 30 Mar 2026 07:25:38 -0700 (PDT)
Received: from FRSMI25-LASER.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf2580194sm17906558f8f.37.2026.03.30.07.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 07:25:38 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder-helper][kirkstone][PATCH] run-config: drop one more checkvnc usage
Date: Mon, 30 Mar 2026 16:25:36 +0200
Message-ID: <20260330142536.3535343-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 30 Mar 2026 14:25:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3585

From: Yoann Congal <yoann.congal@smile.fr>

Reference was missed during a global removal in
commit 5a90d0a5792b ("config.json: Drop checkvnc usage").

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
index a483e96..14c45f8 100755
--- a/scripts/run-config
+++ b/scripts/run-config
@@ -268,7 +268,7 @@ def handle_stepnum(stepnum):
             addstepentry("test-targets", "QA targets", shortdesc, desc, str(sanitytargets), str(stepnum))
         elif args.stepname == "test-targets":
             hp.printheader("Step %s/%s: Running bitbake %s" % (stepnum, maxsteps, sanitytargets))
-            bitbakecmd(args.builddir, "%s/checkvnc; DISPLAY=:1 bitbake %s -k" % (scriptsdir, sanitytargets), report, stepnum, args.stepname)
+            bitbakecmd(args.builddir, "DISPLAY=:1 bitbake %s -k" % sanitytargets, report, stepnum, args.stepname)
 
     # Run any extra commands specified
     cmds = utils.getconfiglist("EXTRACMDS", ourconfig, args.target, stepnum)

