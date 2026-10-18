Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AC5CCF2CA
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 22:03:43 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22625.1792361020749239867
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 18 Oct 2026 15:03:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=qT1VLAhN;
 spf=pass (domain: gmail.com, ip: 209.85.214.173, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso7006085ad.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 15:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792361020; x=1792965820; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cYTJ3FCV/CLjDbnpx0gnFh62gPC35QakzO0sJliEJrM=;
        b=qT1VLAhNaUSU82m4EJBu1O7Et7mvvpoIqFgAhh3gtLI+6RcAMOrLRE74tce/dung6Z
         9T7weMHIPHhJ+s9KQAQrzdJnyKuDXI5CMbvFucyEv29TZApjTFU3fHuYcKk6kTPPlIkz
         j0GptnjfioiRQkhykrDicKJH9z52VE2w2X6CrJbed0yGXOxJF8Vl9XSg0GpJDwdlbx3o
         1HlHquO4T7TEPiFAqjGZYnCJqkeu3X6YWBNdxc17kbZjKnNPD+3F05Z5AJ3H1cW26X3y
         NY1/+IcI9UH1REenuS9LNxj/O06b3rkpgsVmub8KP7bhViQIwzQeoiQZtXqdM+zrFeaT
         HTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792361020; x=1792965820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cYTJ3FCV/CLjDbnpx0gnFh62gPC35QakzO0sJliEJrM=;
        b=Xr94+92G5iFLQQKRJaKgHysDlXFvkt89aT1GXs9n8TCXc5NqM1LY3yMTLmdZHiTmDy
         px2Wi/YOLyDw0XrVWU9MfGf36COXrSuXYW5+gAte9y9VxrBkiyObVRusqoZw39aLX2V/
         O1aLU5MhKZvWw24gbEmeyL9bKyiVthH3mlfkqRvYR2WOlJoBThxVeiiWN4rYMwdmmPjk
         1XGjGI2WQrnEsYmjvw0PDNr2bBl36wWQwl+xAOs1kHdtriYdl3Xy3NTbnv6wksMK5mfW
         2xxpVqRk/i680vm9H8HVXFSNQW6AFXGj9nIZyWVq85dYezzBCk9Dz+RP0RiJ7VJoOSUC
         DoSA==
X-Gm-Message-State: AFq9FYK68k9ceTpKYjHpTpAuClfSs3FKKbhE9dnC3Pv3CTZyI+F6AfQz
	eqSClqL3/awz0yRFl6gjCucg3D8Fx3UHLHvHG6MJs8Sv93+GyjIHCvdMxSexh4jp
X-Gm-Gg: AYBFou39j6tDRmWIhQihCCnCSOD9xPh0Toh1s7DKD7e7lRPlXbXWRGTjptU/wnYlu9T
	6NAISSQQpQWbzDQCuQSvz2H7abHxwkR3mQcGtqByCFB5pO7aRzs+ieDv7Ekb7r02f8xe2x/7ONy
	lhQAmEkYj/ul2Z1gGdcPXbycgjpx+qML+VdpQZ+fL7RXOHrLdV3lDeEiqGUfu6jrK8jz9m4NCIR
	r0W/uO0evDKxEE5FymTuLA/APLJOic9e+X0KVTh6f0SlTkdutVlNgIc+YlzPWuLUm3mCysYov4a
	hmLXsLcHHQ38W+bxXCZ1eWS3edFM3+9xdQRezNyuP9wI3CPjFlo6jJ8zLedQZYE45sIGvuU6fBR
	jW6PJ83cvg7P6qo31lAJwXYpYT0NSFBHtYzNB6G+C3mdTZdU5Didqikuaan8CpL2EFlhUOtaL6F
	aZyB/Ro7Ahq7UI6XwuJ4+oHjDDgmdsU3GBrcI2idqesd8/jlwwZtehYwJAC0Ihghsdm8hoWrK1b
	FspchKmBfxpKigCKWB4LYuYUwfAOKw=
X-Received: by 2002:a17:90b:2701:b0:3aa:f2c4:12ea with SMTP id 98e67ed59e1d1-3aceefc5389mr4486139a91.20.1792361020102;
        Sun, 18 Oct 2026 15:03:40 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac945e72c6sm17714440a91.5.2026.10.18.15.03.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 15:03:39 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 10/10] README.md: show how to configure git for sending patches
Date: Sun, 18 Oct 2026 15:03:08 -0700
Message-ID: <20261018220308.72731-11-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018220308.72731-1-tim.orling@konsulko.com>
References: <20261018220308.72731-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 22:03:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5092

Contributions go to the yocto-patches mailing list with
'[layerindex-web]' in the subject. Show the git config settings that
make git format-patch and git send-email do that, as the
error-report-web README does, and drop "pull requests", which the list
does not take.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 README.md | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/README.md b/README.md
index a34457f..a1f6087 100644
--- a/README.md
+++ b/README.md
@@ -508,9 +508,14 @@ The latest version of the code can always be found here:
 
 https://git.yoctoproject.org/layerindex-web/
 
-Contributions are welcome. Please send patches / pull requests to
+Contributions are welcome. Please send patches with git send-email to
 yocto-patches@lists.yoctoproject.org with '[layerindex-web]' in the
-subject.
+subject. To set this up in your clone:
+
+```sh
+git config format.subjectPrefix "layerindex-web][PATCH"
+git config sendemail.to yocto-patches@lists.yoctoproject.org
+```
 
 
 ## License
-- 
2.56.0


