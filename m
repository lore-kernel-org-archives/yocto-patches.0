Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78824FF884A
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 21:08:55 +0000 (UTC)
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32236.1777064930062395039
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Apr 2026 14:08:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=v6mG/4n5;
 spf=pass (domain: smile.fr, ip: 209.85.221.67, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-43cfd832155so6075210f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 14:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1777064928; x=1777669728; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HgjbZuVNQk5u6q2sJuq+IlunG94WdQeiaypXSMwpYFQ=;
        b=v6mG/4n5e/vQH/NQxQjGr1vcM1/PsXZeguDHQchti2pt3Zz/so3gAF4ukLlIBjbOXh
         +qyHb2u1wLqBT2bepf0PImoStdibxIgz5OOetA2lv1Dnnx7e5YWSqvaiAtygevJVTgf4
         nr0JozPLe6j6rrRwQ8asWOrk0VxfjvT3scfoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777064928; x=1777669728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HgjbZuVNQk5u6q2sJuq+IlunG94WdQeiaypXSMwpYFQ=;
        b=M5cbFmKkuN7SYMtDwi9uzbxPN3qjDb9rbOdR3CRlcKUDIqDIkHEB8kKpwdnowoNAf4
         Hx0nsxUrtcv7YD6LLTPiknl98P3cwofV0K8ajY5rIAvT3f9wPm3C/V1yggC4xt7+KZ68
         7UiAuOz098Cu71xCmsh+awY21svH2r0gzahtI0FkeVXJ/3mLS5oaxjG2sxGC5Rs4f7cM
         MU+gV8I7vz+b1B0a6I8wCZ0sboOkcIUJUYewjnyGwKIrA4pkS39pZgLFuKZGLKdqOobr
         ErITVR4q+LLdRc6g4OlKAtW9RzlC6ejc39fJqjJ78zzkifd7OBA5vJAACM1PIPgre83W
         3PmA==
X-Gm-Message-State: AOJu0YzuD/xfRpCVfrEt27HXDlM5PxRB/P1lEjyjVxAehuEZv/+5oP/u
	1jQSSgURiFdGwccPFwvC9QjBgYUGdA6l29cv6s0eYxx5RydoRI0q0aryxLkhCE3rOuPPy7flzcx
	OsvBNdHY8/34U
X-Gm-Gg: AeBDievbK38CQ7N0MgDCNLNANcVDrIu7jIKYRGqPASEr4prGfh4G7uMinZwyp0aGa0e
	FVQ8wGR7bY77WHzNVcpoLCeOsjlz0NO252+H+PKbVvaAzL40QctFc7eWyr/ZGLXJlP5916xer69
	VE7GuNuhZxvG+SHReX2acem+QRyJgQYgkVivehrKI8pFLctLQ0aNESMmpfhPLMWDnm4rLTUlhN0
	YB7uHQKDrfpYhtPUMIzWMaCJ40oukFtBzmo3WQRlVPhAMQnyptQFPS/D3535ooRdwxz/USvMmds
	HvqXb37x0F/RG/KELi1Pp0llgzGj3sNW34OdKAHe7A6oZbEk8n34GWu4iYH+MlueMpPYu3c4y4a
	PAjCnRzOb1dhOrdt1SYVCDeOF6fZy9dr6t4FF4Q4ZAPkSzCrPs80Yv39+F9EGIQPhDvC0Ap93/v
	l3L5VDgS1Avyvp8iBf0BNmQVNDvJAQQCwFSg4fUsRfezeRUmOqyOJLg016yv2zuTxDG+q/2Qs01
	YTK2VwiLFT6Y+jNcljcbS41vVRVyjb9+9wDHlOcV4HNVedS
X-Received: by 2002:a5d:5d05:0:b0:43f:e22d:9a73 with SMTP id ffacd0b85a97d-43fe3db3cbfmr50789106f8f.2.1777064928075;
        Fri, 24 Apr 2026 14:08:48 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4dc24cfsm61436286f8f.16.2026.04.24.14.08.47
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 14:08:47 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][scarthgap 1/2] run-config: drop one more checkvnc usage
Date: Fri, 24 Apr 2026 23:08:41 +0200
Message-ID: <a7b6f0f6b42072139d7f2f30d6e7cc0e79d52c4d.1777064869.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1777064869.git.yoann.congal@smile.fr>
References: <cover.1777064869.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 21:08:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3810

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

