Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
 by mx.groups.io with SMTP id smtpd.web10.57322.1712448918392842507
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 06 Apr 2024 17:15:18 -0700
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-5c66b093b86so3312095a12.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 06 Apr 2024 17:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1712448918; x=1713053718; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vbada5gI4OLGzUWb3gRBE0CT1LG+S/VNbQlADEIZ+2Y=;
        b=pgaCAtmnYOc7StBjn0XZD0v28/Rea2EkUFpMr3vBh0P7aiUOVleLEC3eQJDO8rZz/E
         Bj2ZOzJnKL8+kSpoF4Vu752ZSa7ouIiKgrlx9vYvMh002jNhXy/rFjStPsFmN44mbeti
         02Ypte+NjPisll1VN6Rn4+OY+CjeH2kMHLSdg=
Return-Path: <tim.orling@konsulko.com>
From: "Tim Orling" <tim.orling@konsulko.com>
Subject: [meta-java][PATCH] README: move to yocto-patches mailing list
Date: Sat,  6 Apr 2024 17:15:07 -0700
Message-ID: <20240407001507.92675-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: openembedded-devel@lists.openembedded.org, yocto@lists.yoctoproject.org, yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
List-ID: <yocto-patches.lists.yoctoproject.org>

Since the definitive, canonical repository remains
https://git.yoctoproject.org/meta-java the official
mailing list should remain in the yoctoproject.org
domain. Move to the new yocto-patches@lists.yoctoproject.org.

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README b/README
index 8c55a41..9c987fb 100644
--- a/README
+++ b/README
@@ -67,7 +67,7 @@ Known Limitations/Bugs
    +--------+-----------------+-----------------+-----------------+
 
 If you encounter any other problems or bugs please report them to our mailing
-list at openembedded-devel@lists.openembedded.org.
+list at yocto-patches@lists.yoctoproject.org.
 
 Usage instructions
 ------------------
-- 
2.43.2

