Received: from mail-oo1-f67.google.com (mail-oo1-f67.google.com [209.85.161.67])
 by mx.groups.io with SMTP id smtpd.web11.154116.1712706989306231510
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Apr 2024 16:56:29 -0700
Received: by mail-oo1-f67.google.com with SMTP id 006d021491bc7-5aa4204bacdso1573488eaf.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Apr 2024 16:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1712706988; x=1713311788; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWHi+mN+MBl34g8OpGXm6sjOyFzPl07C17fnKXIe/oI=;
        b=PN4yTqjNzr46AZcwxEOqER+GR3ERvWjaGOv/qWXayz7nlPiO/WkPmmymrncLYr7Q46
         pEE5NeMdFkEdaeRISGZ0JxvUXDpHq+tCPT26DM3DcqGhu/qybrkX5qnw2ZMFb+G13d+G
         HjhRSaAFWPL26eQxPwP2l1KR7ZbYk6RfNFJas=
Return-Path: <tim.orling@konsulko.com>
From: "Tim Orling" <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 3/3] README: update to new yocto-patches mailing list
Date: Tue,  9 Apr 2024 16:55:45 -0700
Message-ID: <20240409235602.3362257-3-tim.orling@konsulko.com>
In-Reply-To: <20240409235602.3362257-1-tim.orling@konsulko.com>
References: <20240409235602.3362257-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: yocto@lists.yoctoproject.org, yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
List-ID: <yocto-patches.lists.yoctoproject.org>

Change the canonical, definitive place to send patches to
the new yocto-patches@lists.yoctoproject.org list.

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 README | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/README b/README
index 6fc4591..89dbd5b 100644
--- a/README
+++ b/README
@@ -431,7 +431,8 @@ The latest version of the code can always be found here:
   http://git.yoctoproject.org/cgit/cgit.cgi/layerindex-web/
 
 Contributions are welcome. Please send patches / pull requests to
-yocto@lists.yoctoproject.org with '[layerindex-web]' in the subject.
+yocto-patches@lists.yoctoproject.org with '[layerindex-web]' in the
+subject.
 
 
 
-- 
2.43.2

