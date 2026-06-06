Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD6ACD8C89
	for <webhook@archiver.kernel.org>; Sat,  6 Jun 2026 01:19:38 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8541.1780708774707855352
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Jun 2026 18:19:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=EJ9QekXY;
 spf=pass (domain: gmail.com, ip: 209.85.216.42, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36baeec21dcso1611637a91.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 05 Jun 2026 18:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780708774; x=1781313574; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ybno0JJuij+9yJQuFsJ65gSKBfnlgtKDWdq35r36whQ=;
        b=EJ9QekXYXqOPcb+XZ1rRgXzH3fQJTx1E1IZDOeCxVsic9fIsKvFfZ1OnU8D7bgPNV/
         SohSYpBzjKX8GIXY3+FffBL5gjijssfDtVAO0MIPyoc5551qbjm25m4WyXAKfEKCMC4G
         EnKjWlCQ1ZNHEWtzWW8rpnNxM/bfrXS8SVFygs0mrYoLG7C0mX6PFVmXnT0dLbvSoyRB
         ygroYO5/9xWOvpZlue0v+Dwj3s9zK8sd4R4PR9Gd8RNPvaS3y248IOHHMjLHP+I85/+D
         yK217BTOtZyHDAgUNK51kD6MalIPJBfQG+oQamv56wQJYqKlRanEnVWoIoe9A8LMQ2kO
         r24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780708774; x=1781313574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ybno0JJuij+9yJQuFsJ65gSKBfnlgtKDWdq35r36whQ=;
        b=qe+95aifC//WX2k+Ix8e/Ni6wgDusOxRENqZ7Yb6fXFQoOb7HvE0Dw2CzhLBTkvtwe
         UbmSd8ix0LkHUirz55NU7whle9cvCy9zavi/mnlzl2qmzpOX/vVDkpGCkgZ7m128lcFB
         uPm0fZ5g5Zz+EQtVNFfrF71yYUxa3B3J2in38+y6Xs8toMHULGxmp0WWmeWOpn6cNgx5
         +mTbbtuwfHLob7ETk8lQc8hO2XDNQsz0GLCXs59XqcCz6ykv5013N4MAkEOzvz2SeNVn
         to+gm9h3EiFhWgr+BGtAuNBopYQ6OP6ljqiNCLSAZyn/77wUFnrNahePLznlOmzbjIkT
         JbuQ==
X-Gm-Message-State: AOJu0Yz1JU1xE4FjvuT+LoqNcz0pFzLnaAjEiCgg3A9JT9bpVoPYn7Ld
	2DCBK5vW8K2WOyrKqaX8yH81SOxqrnvQcYjAt0oAw55D2nA0gZg9DRg4IPcuOg==
X-Gm-Gg: Acq92OHxSG+4y52WXWg8gDlQMaxWDXkVRA8FFGCVCag97AO3gKU3fAYsjuTs7aPh6nm
	EdX0KCNvPrr7OxfqY3lRlETIy4qCB7f2biageddFebEugiGfWZBoyn+ZLrhtBhjP7Cn6vHzPVzB
	uH6mTNOaJqAxb4b776KPu72uTey5WuckiaJdsWsjMe42fW5nlZNITWj3mAJVmrxHp5H4gLFrRbv
	mYc+SupGk/qvudYnq/p0caSzzajHKI5xvJxYvWvNonIfS8XME+kVWjE7gV8P2UVcSpg2Wl8mrgU
	/0/IjntiiVk7TgXvMXrFuOBVoYisWindwWgIq90ivc/tbuGYEfHI/X3rMv+EdF4SPyp2cflHkAI
	f+2hRzvsFoSorJyRT5MGE5PYHpuxfBimWZIZ3JAMJRafIsTwEdkFBDC8oe5+k7B7A2tYPD2KbCb
	4hMYgm+V3lM98wiK1PwNZCa65BWLiz10tHK52b9ZY54pZhF61AmolCbK6TeZsHvelCYtKigENAm
	z4iQ/5MBOSWg7giP9r3whpElc+YFPpkrg==
X-Received: by 2002:a17:90b:35c1:b0:36b:71e6:3e01 with SMTP id 98e67ed59e1d1-370f0678ed1mr6482258a91.16.1780708773977;
        Fri, 05 Jun 2026 18:19:33 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3712ef0add7sm3245226a91.0.2026.06.05.18.19.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 05 Jun 2026 18:19:33 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [yocto-autobuilder-helper][PATCH] scripts/utils.py: add timeout check for tarball extraction
Date: Fri,  5 Jun 2026 18:19:18 -0700
Message-ID: <20260606011918.61582-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <02f0c35f16a8a51bbe0e89145353008f67180a84.camel@pbarker.dev>
References: <02f0c35f16a8a51bbe0e89145353008f67180a84.camel@pbarker.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 06 Jun 2026 01:19:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4154

The while True, try, except OSError: pass loop has a risk of
getting caught in an infinite loop. Add an overall timeout
to ensure we raise the underlying OSError after we have tried
for 300 seconds/5 minutes.

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 scripts/utils.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/utils.py b/scripts/utils.py
index a4dd12e..4aa4468 100644
--- a/scripts/utils.py
+++ b/scripts/utils.py
@@ -506,6 +506,7 @@ def setup_tools_tarball(ourconfig, btdir, bttarball, name="buildtools"):
         # previous build.  tarball_updated is set to True whenever the cached
         # download is replaced, which triggers removal of the stale btdir.
         tarball_updated = False
+        tarball_timeout = time.monotonic() + 300  # 5 min, tune as needed
         while True:
             try:
                 with open(btlock, 'a+') as lf:
@@ -548,7 +549,10 @@ def setup_tools_tarball(ourconfig, btdir, bttarball, name="buildtools"):
                 break
             except OSError:
                 # We raced with someone else, try again
-                pass
+                if time.monotonic() > tarball_timeout:
+                    raise
+                time.sleep(1)
+
         # If the underlying tarball changed, remove any stale extraction
         # directory so it is re-extracted below.
         if tarball_updated and os.path.exists(btdir):
-- 
2.54.0


