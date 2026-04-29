Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDACCD3420
	for <webhook@archiver.kernel.org>; Wed, 29 Apr 2026 15:40:22 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14506.1777477220377058930
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Apr 2026 08:40:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=KyiJUWr5;
 spf=pass (domain: konsulko.com, ip: 209.85.222.182, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8ef5776530bso857509785a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Apr 2026 08:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1777477219; x=1778082019; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hbv8dLInH3oxT+DsOpOndjL+3PUqLKyKIhyjDpG4fN4=;
        b=KyiJUWr5eqA2jAfKJOInyNqOVai7jB5lSMusm+t3Wx1kLflPa0Jo6mUkr5FscSI2AW
         Nl7yiSn4yVDCiMhkeVruoN51jk00hGCRehAtFnQbeCd2j/alYJEOYTmuhK3IsLT4eKJh
         H65+t8a5zf9r+ax86RMuXPVCqaLXq/hzPWY4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777477219; x=1778082019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hbv8dLInH3oxT+DsOpOndjL+3PUqLKyKIhyjDpG4fN4=;
        b=M8iudhYN1eIKobAGB8XO+x6yeTNImDmKEMqHMSTDKD8atL3chDbpySK20xykdwnzbj
         LLAmY2D/QtI/yYCFuZ1SCQtR0JaCPiOSyvnkqrk/B85DWEDgDBGoRUxuUrMFXxMvFMvJ
         FBEOzjCsG/pr6CLk3uLen6izKk+qvVHi/DBhVlGFsKdxXMJ4uovo1WfzD6JjlzVxsOWH
         mS1/0Stf++apQHYKMK1gH7zYTUHPvuFdgjCGJJtGL8cZaTkKBI4hBl50S4GuxHc5fbm7
         Njfu5Dmt6fyPu+2h66TVvSIwS9AEfY67mEjG7Km3//U7u9snpLUMNaoZ6Eg0zmTefD6b
         D1+w==
X-Gm-Message-State: AOJu0Yxt9mx4GEVKSAuwahTCm7omEUAKf5oDJRYsme9qHDl6/JzsMJLz
	6MaUD+IzOHGvGK1jW/BCxKVzTUdIzBPKcutrtGpqenUS+9/Q2jyH0aNFR7D98ewX1eA/sg0Xodk
	+bVtC
X-Gm-Gg: AeBDieuJ8E+ELrFtElvcdXYuk+pXFEg7AEnhFMwzEWcbWyL/N0O18j7hhp5tsn+k9Hv
	WVYMe2Jx9LZ+gArmFNfZm0BK3dEWS11aXAR8ZVN6iE9OvJ0DnyL+tl+kn06EEH95eXrFJ7T5zyR
	Xp90vrss++hRQGSiV18wtfygD/37/dbYOtqY4nopFboMACVUBCRpk73e4ciQNGeD24PQruaBSWw
	o64kHLt6G8OMJzZqOKeztMMkZJ16ZY7xmTJO6kHUbvSo1jShoPB5Os2B9I2tmHof5yIZfmpxGHE
	GPvuKV/xRpi5VaC8lFBlqgivftfIaaiuHxpqDDjwzZq03FXNkrqIY9ADhXqIOWkJ33Cnk37MDQB
	FL5GVPzBjYwC2Nj++zqYm4KW9AbThFe1jfbWne4PQkK95BxS7gFWG0YVp22OxjfRPm8e/j5RTCB
	v81lKqYe1rcf4gf+ySl8OGE2qRwy0MothJg9HWRHQAPGQ4Fwa1h/r4q9bSbTDpTgf9lbZiFGlnX
	hmzq0EL+7o4w1XOa9IXmLT4y53ni9KTpD649HLNHV80pgOyq2QiueSFkDREVff8xaBizPFACxU=
X-Received: by 2002:a05:620a:2991:b0:8f2:c47b:962e with SMTP id af79cd13be357-8f7d9903ab5mr1139907385a.49.1777477219092;
        Wed, 29 Apr 2026 08:40:19 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f940340f1csm207924185a.44.2026.04.29.08.40.18
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:40:18 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 12/13] packagegroup-core-security: remove python3-privacyidea
Date: Wed, 29 Apr 2026 11:39:42 -0400
Message-ID: <5bcd679c2c9fb8312fbface4b95fc66e18486231.1777476608.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777476608.git.scott.murray@konsulko.com>
References: <cover.1777476608.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Apr 2026 15:40:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3886

To work around an install conflict between python3-cryptography and
python3-pyrad and unblock CI runs, remove python3-privacyidea from
the packagegroup dynamic bbappend temporarily.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../packagegroup/packagegroup-core-security.bbappend             | 1 -
 1 file changed, 1 deletion(-)

diff --git a/dynamic-layers/meta-python/recipes-core/packagegroup/packagegroup-core-security.bbappend b/dynamic-layers/meta-python/recipes-core/packagegroup/packagegroup-core-security.bbappend
index 828931d..aa12c94 100644
--- a/dynamic-layers/meta-python/recipes-core/packagegroup/packagegroup-core-security.bbappend
+++ b/dynamic-layers/meta-python/recipes-core/packagegroup/packagegroup-core-security.bbappend
@@ -1,7 +1,6 @@
 
 
 RDEPENDS:packagegroup-security-utils += "\
-    python3-privacyidea \
     python3-fail2ban \
     "
 
-- 
2.53.0


