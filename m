Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C9A10F3DCD
	for <webhook@archiver.kernel.org>; Mon, 30 Mar 2026 14:17:21 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.52625.1774880231686185016
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 30 Mar 2026 07:17:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=ROHv9y6Y;
 spf=pass (domain: smile.fr, ip: 209.85.128.54, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-486fd5360d4so60535015e9.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 30 Mar 2026 07:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1774880230; x=1775485030; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HgjbZuVNQk5u6q2sJuq+IlunG94WdQeiaypXSMwpYFQ=;
        b=ROHv9y6Yji2Xe5r/vDK7+1HpxZX3r11OZFm0ojMsnoXWggQPeWoKMdo/wfIXcgAMTu
         t1e3jMA8La7rId8cSgEK5zo/dRYmvuMEPfHuAhSFXNOe8m71GtpbsZTZ2mzHn61gsluK
         zBJ5cDTcl8DlDH/ZdQuxelFy5BDSFRCByZWm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774880230; x=1775485030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgjbZuVNQk5u6q2sJuq+IlunG94WdQeiaypXSMwpYFQ=;
        b=DqcfKWKa7ifPbHZHbb2XgzlgPvYkssgMqRFJSB6LR+pgGuUUP90u3Sg1XDjyAAxCz/
         J/feg55iYyolmMWe2Afvt1JA4mA95nHoyRUsbyH6tverYRtZC81lgWCh65j3ppoTQa4I
         82uVKK1GgzONHpMaAr0O5+Oc08ouahXfjildtHCmlsSU+VElflIJbu0j+ReYphdB1srQ
         UoOEmlRkkCppkVs0KhbWHb6efQiXUj55TwCVRdNFy9HyQudXPtHV18i6nh1FQZjoHpIX
         0XsvgMAU3aQzpBlZ73Mt1ItONRr5TrnTPdk67WY6rt7XRdhPdg8rC1Kqm3rtF2JQAyu/
         qcAQ==
X-Gm-Message-State: AOJu0YxfXyi1Sd+K3K6xgkjtW+YqDhSe70rQaIUy24nSPVBErjmPSaAF
	1dkoi5lPyr3E7uOszxDK4jpHvnWQi5HYbh6xFjmYvi8GOUtcQosDMpDOOAYml6V/xIybsnoP4Vy
	U/0LrqJE=
X-Gm-Gg: ATEYQzxd6HwaAFhn/VM71p8NY4Y44+UIDI1+RGzOeiSkZrsDiUJFiaqYJa3GZJaKbux
	XVneJzgh3iM7S0vehyVDrpsPVkFB5RMqVfUj8uxMy84tWbhPv3NGD2leUCdF6U9Q8NieoFmIm4u
	KvUvPVhH2Rq3y8ft5rqB+JyS6xwzHWF9ptCObS39xUtqg9tvaFnOUML0qZpVMiT32Jh56okyDWA
	MwkD7/TC8BtJ+74eIFjYHpDc0+WRW8BGwPFAMzaIlStxJcGia/1uZEkNrMWV0FdwCJ64fzaKb8x
	XYoXwVntG3FjrmYw4jRiu7ceHXuDdk6ursl65ejknECzdeTZCXt9AkaHrNdm6TpBeApvVsRFBXD
	uKCw8VA6L5CTCnZ+WQb3/owbl3zFKLWrl4ZlOiTJKwkQgYHV4lZuO7yu1+zBAsuV8SqLEYFG0zN
	F0w3D+9PiLtK58eT3KJ+JdKw+z79yQKwGhQxbFrttHw7VC8VBQMvfcnrJMOae0C/TxINzQBdi36
	iLkP8IZGn6ghalILrvFkUYqMsRxAiPwHQ1mJ9KHpEuR
X-Received: by 2002:a05:600c:4e02:b0:485:3b9e:caa7 with SMTP id 5b1f17b1804b1-48727edf669mr204672735e9.23.1774880229583;
        Mon, 30 Mar 2026 07:17:09 -0700 (PDT)
Received: from FRSMI25-LASER.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487351fb38csm193616055e9.4.2026.03.30.07.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 07:17:08 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder-helper][scarthgap][PATCH] run-config: drop one more checkvnc usage
Date: Mon, 30 Mar 2026 16:16:40 +0200
Message-ID: <20260330141640.3531342-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 30 Mar 2026 14:17:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3583

From: Yoann Congal <yoann.congal@smile.fr>

Reference was missed during a global removal in
commit e45f35e484b1 ("config.json: Drop checkvnc usage").

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
index fb71721..02bb8cc 100755
--- a/scripts/run-config
+++ b/scripts/run-config
@@ -290,7 +290,7 @@ def handle_stepnum(stepnum):
             addstepentry("test-targets", "QA targets", shortdesc, desc, str(sanitytargets), str(stepnum))
         elif args.stepname == "test-targets":
             hp.printheader("Step %s/%s: Running bitbake %s" % (stepnum, maxsteps, sanitytargets))
-            bitbakecmd(args.builddir, "%s/checkvnc; DISPLAY=:1 bitbake %s -k" % (scriptsdir, sanitytargets), report, stepnum, args.stepname)
+            bitbakecmd(args.builddir, "DISPLAY=:1 bitbake %s -k" % sanitytargets, report, stepnum, args.stepname)
 
     # Run any extra commands specified
     cmds = utils.getconfiglist("EXTRACMDS", ourconfig, args.target, stepnum)

