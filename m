Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD67BD65C7E
	for <webhook@archiver.kernel.org>; Thu, 14 Nov 2024 11:46:38 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.35638.1731584797115167752
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 14 Nov 2024 03:46:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NaY+uIZz;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso6506225e9.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 14 Nov 2024 03:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1731584795; x=1732189595; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lrhRc2bXw/jT84rwjKLMAMDitk5XJFexbwELx7rZ3HQ=;
        b=NaY+uIZz1Jqw29VTS9mf64dtYI3OOwmaC9NkUTUyb/eojU/O+EwlRIgN6qgo3i9g19
         9Et5XZlJaMwQM8liIwAcxXvPjXVIQQPC10Nyjopa7vps5eS/bOrLAFGyX4lQaS4z3tkj
         kR15/Py90/UWOKFCvp1YAXuHGgvEGQOD383ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731584795; x=1732189595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lrhRc2bXw/jT84rwjKLMAMDitk5XJFexbwELx7rZ3HQ=;
        b=NBeYVVNfB6OZdxBRObdMdGg3keznLKan8rWM35MKajhgU9138/yJvsnMONJy7SDHdu
         G0ibkcD1T/Mq0iZA5RjcOVIBeSCI7zdCefOGtazV7EIuJxL3RWNZ/X/MvKVVhpSetjuk
         3oTnvfcR1vPIjlOhXcWIAEmaE0xAu9ojmP7J8UobfrhNuAZF/oeQ5JsyyG7vOxZm+jjF
         IY6edTGqDn8WGGE+R7+EEuOK1QDnbxDkVWsvAJNiZhNw5zKl2g0dCrGmy2wMJk3mHung
         TkVLzwHNOXGmZfxe4Pab+PcRFwaWTwk7FrYnyF9J99uAcVMY/JQMfCNKp42sgfU4n7jK
         jB1A==
X-Gm-Message-State: AOJu0YxaYM/guRMCteoADJUBCsRUeMqrbmco7KyXCCqW7YvZ5DiU3NtD
	UhN0vrHcSYY4fPWWrcXuRpABhytY2CDph53XheBfpSAds+S9gkRqbH7kD0P1iV95qwcOfn67UFL
	auJw=
X-Google-Smtp-Source: AGHT+IH1zvGNWG/fvZxi8HjYViNMdi/rdgR+QfOtfPb9oc6wm2FA4F2n5Q/FC5STLtwUGDzmYvpCqA==
X-Received: by 2002:a05:600c:314c:b0:431:9a26:3cf6 with SMTP id 5b1f17b1804b1-432da7a050fmr20834235e9.4.1731584795187;
        Thu, 14 Nov 2024 03:46:35 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:593b:1ea:4243:8543])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada3e65sm1249581f8f.13.2024.11.14.03.46.34
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 03:46:34 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] send_qa_email: Filter to specific revision to avoid OE-Core commits
Date: Thu, 14 Nov 2024 11:46:34 +0000
Message-ID: <20241114114634.389679-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 14 Nov 2024 11:46:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/801

Poky and OE-Core commits are being stored into the same branch of the test
results repo which causes confusion. Filter these to poky and ignore the
OE-Core result for now as the least bad option we have to avoid issues.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/send_qa_email.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/send_qa_email.py b/scripts/send_qa_email.py
index 39e9382..15e0c62 100755
--- a/scripts/send_qa_email.py
+++ b/scripts/send_qa_email.py
@@ -188,7 +188,7 @@ def send_qa_email():
             utils.printheader("Storing results")
 
             if not args.dry_run:
-                subprocess.check_call([resulttool, "store", args.results_dir, tempdir])
+                subprocess.check_call([resulttool, "store", "--revision", revision, args.results_dir, tempdir])
                 if basebranch:
                     subprocess.check_call(["git", "push", "--all", "--force"], cwd=tempdir)
                     subprocess.check_call(["git", "push", "--tags", "--force"], cwd=tempdir)

