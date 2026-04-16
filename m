Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47783FA0C23
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 07:07:56 +0000 (UTC)
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8017.1776323267273516393
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Apr 2026 00:07:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=jFAPs4i/;
 spf=pass (domain: smile.fr, ip: 209.85.221.68, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43d43e09de5so4542070f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Apr 2026 00:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1776323265; x=1776928065; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MDnPflWYOG4Gt9dJ1ydVNl4r96B0szCEsdShvoL8wG8=;
        b=jFAPs4i/9uBG20BruuUldS6BjbLXLFiDRTx1BPhE9jDh81hmJT5bijNBQlU3yf8h5P
         8iYhZCXaE1I3LXzZifegUnPmYIrQDIo3yVE94Oft6GDeSx3S35bxJ+D4uTHSmY3lHGIW
         BYNilZfFnHfPRPYfYzUvbkb3laIHVT1bpDPmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776323265; x=1776928065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MDnPflWYOG4Gt9dJ1ydVNl4r96B0szCEsdShvoL8wG8=;
        b=f39Ukqb3ojiZ2uw3+1SuV7dd3PA1dakAAOeAtH7ftoXdIp/x393HkEs8RhigcazMo/
         EASv6Lh2ZyB6EEtecu5/nrzdu9njO00NKR55xSu8R7w6GA1SLUIMs8HvdrasQsH00J+0
         Ryg7NMG+ZB1T4Hw2Pe6RA9MQmOHHtjH5Q6yqFhbv7vxtOD0Q6KHnSbbLoMGpWdqSHWlt
         jZh3Kuli8AP6uxQ9IldkKGACtOadR2YPAjnOX71HFOtN8SantuSORQ9mYDqiilMCQFuF
         cEOEjE+6ofCiiMk74cnRXfa55/7FMezLW9bzsVrMEIUfiLMcLCSPYwkJp97O/62kWXgg
         iENQ==
X-Gm-Message-State: AOJu0YwAGDaqBZC4WtU5tfxqFfCpkAtcuwr1dsdMhFslgCMr9LYsiCbS
	N6+5kvW3gKj4ShMTwZNxhBdLiV3OEDg7QGl5HjoKDrxaK6K29mhiKnz+lLtlCGNTjp5Rh+sOZSk
	d5RIm3Z0/YpR1
X-Gm-Gg: AeBDievc5MpRC/xQJuV6+FfodY4BSWsWDGf1K7rAN8PxqiRPQgqbB6uc8ZtBDXNd2Uy
	Eyuajv5rQ7aKM0selLrMidoum0rNlYse0AaisRuuXdqo5uc5xFzRb2zGaYz3UteGiZw0MOjOkqF
	F1l2HZ+SDQsh1sVaWWaf5kBfRgKFlFi++kjoelg221gFTHN/O3LfH+6K41ngJwgXYh71XzgIk/u
	ZIyXjw+qqJyKUgiaBhyaXUUtuGmf0ELctcHEnjYWqSrjjlPn3f76nMBc0fiu8djmkKTHALQCxO2
	8VQpEk+JXanc/FX7Vd7XVhFc46KICHN9TsluV8wNRB0/tJzVmDUv7ymtyTHmfqbuJQOFOAgIPPK
	mUNAvhEktjRXd2ymSCoQyK3PwfIL/pJSB9crg3guh3KGZhnczi9k1Zu0hgcDzPLkXuK1Rsyupu3
	DZ5BPyc6mS5lxALWiQodZf1cEJNZ/+5wWnbDsRH8gsz9iq+n8lPoJySykZolInfj4u59dZH05gg
	Hu/gRBFV0MLQkl10W+Yl07NVo0v48fgV9GYuw==
X-Received: by 2002:a5d:5d83:0:b0:43d:30af:a173 with SMTP id ffacd0b85a97d-43d64259b7emr36636169f8f.5.1776323264935;
        Thu, 16 Apr 2026 00:07:44 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5f06sm11602449f8f.17.2026.04.16.00.07.44
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 00:07:44 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][whinlatter 1/5] run-config: drop one more checkvnc usage
Date: Thu, 16 Apr 2026 09:07:36 +0200
Message-ID: <6de347e646c38d3461519e6227fb121362fe71b5.1776323183.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1776323183.git.yoann.congal@smile.fr>
References: <cover.1776323183.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Apr 2026 07:07:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3717

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

