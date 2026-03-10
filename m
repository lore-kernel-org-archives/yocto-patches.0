Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E487BFD88D4
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 23:35:09 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9035.1773185704685563679
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 16:35:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=MhI0Bqua;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso110142635e9.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Mar 2026 16:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773185703; x=1773790503; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yikJt5wH0Tt9MBG3PSI1XI4stnP1L+ad9LhS4k171DI=;
        b=MhI0BquaNxwqngbqYIdWV6vwvd7uFgwi+KlFDF74HUYH4aw6KXh4BA7hKOqeHJ6yan
         Yh68UGk0ejMNAaDiPNY+/zBYuUm/lxgT6A9Rhmyyg1KwMZ7UgKvB6bUMftSy4NHIaPaL
         Z+dR/ksL1oITr+PpXdEHFk+hbiCG2e5NFULm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773185703; x=1773790503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yikJt5wH0Tt9MBG3PSI1XI4stnP1L+ad9LhS4k171DI=;
        b=Fu1PqOzygJSY72r89Te9IPf+9KG3CLZU4go7LR0GY1B6TiuH0HFIfnM5s7u1ToUan9
         2o/l5fWil4cZWnECbeJl39hACloXWDuLn4kE9xbLeJ0baCvwwYRUj0O6aXa9hD0PdmCl
         Swxb2FheyhAOU9i7/OsKA7q5M9ZPabTU2tm5uJ903+lPwbyX68w5k97UyisUicaqOcgH
         Rgr+DJKOy7T4ZHRsMZYQdRS9V4fPitDF/w0MTsx0QQPnZsrZbwNk159RFp8wFlekB1ZU
         CgL+8pjURVbBL3rnYtW2ON8/Rtdp0EQeFRSnruL/uvCbGg3/uo8Dwz15j6XdKJHpMNfL
         34SA==
X-Gm-Message-State: AOJu0YwkDrc1FJVsA/4CDRMmje8CKQaUWvG6ThzooCHpExWYguDYYxE6
	EYb32YusyCvzzjrF3gZF+LY0YhvDyY73Ga7TJOIOGzGLSDRxUbA6MegoBHq9sfLZHoFjf8Ss2s5
	4Tb8htTo=
X-Gm-Gg: ATEYQzwK84HO3gruKs9oard3ew8yLenviqMgnKQiyw2qX6VYOMQwbTKL6bTtYy+iGJi
	rTYPo4BkUiwiEHEUEWBEcvSATcbwjfC7umUACFi1ZIDrEeVcfZQPmL2h11nO8W9z66MGRraFfEF
	mIp7AMI+BjIaRosBrVU1b3XS2VenM7HUDAxB/sDsDOwHkjyfHztsyynXs9tC9bB79C0rEK+8jPH
	53fUOGDdHCQtyMOn1dHiDBo3ZnzC19t/8nss+hd4EuWFnBJQhOUKF/0BfgomfLOVxa2PlflgxDB
	gcGH/rmQHmFFSQ8Bexthg++ODQAqxLGd0KtzQpbo3ZWPXTeQPadjjv6hW8HcD5ijng6vgE9G4hP
	SVKdvIQ/UvahQV/6Wn7UPT+I0FpEbgt6ieBpmykuMSqLP3zOYna8x67rG6cWgk28AqHWd0uiM26
	AP4BS+e/JboBbZpJQ5Wl1QvidxXQilbFLdXDpbZOcikRnswwuEhpC8wfxmT5F6GQ==
X-Received: by 2002:a05:600c:4710:b0:485:3b00:f939 with SMTP id 5b1f17b1804b1-4854b0bafa5mr9685965e9.8.1773185702634;
        Tue, 10 Mar 2026 16:35:02 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:4968:9824:44c9:31a9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5e912fsm21643215e9.2.2026.03.10.16.35.01
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 16:35:02 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH 2/2] run-config: Drop DISPLAY setting
Date: Tue, 10 Mar 2026 23:35:00 +0000
Message-ID: <20260310233500.3364868-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260310233500.3364868-1-richard.purdie@linuxfoundation.org>
References: <20260310233500.3364868-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Mar 2026 23:35:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3401

We no longer need a DISPLAY set to allow testimage to work, we can use qemu's
inbuilt VNC server instead.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/run-config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/run-config b/scripts/run-config
index 7da11c4..e896234 100755
--- a/scripts/run-config
+++ b/scripts/run-config
@@ -300,7 +300,7 @@ def handle_stepnum(stepnum):
             addstepentry("test-targets", "QA targets", shortdesc, desc, str(sanitytargets), str(stepnum))
         elif args.stepname == "test-targets":
             hp.printheader("Step %s/%s: Running bitbake %s" % (stepnum, maxsteps, sanitytargets))
-            bitbakecmd(args.builddir, "%s/checkvnc; DISPLAY=:1 bitbake %s -k" % (scriptsdir, sanitytargets), report, stepnum, args.stepname)
+            bitbakecmd(args.builddir, "bitbake %s -k" % (sanitytargets), report, stepnum, args.stepname)
 
     # Run any extra commands specified
     cmds = utils.getconfiglist("EXTRACMDS", ourconfig, args.target, stepnum)

