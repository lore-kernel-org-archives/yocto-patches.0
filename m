Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410AAC982C9
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 21:59:01 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.26517.1789595936483857593
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 14:58:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=J/LxWgPz;
 spf=pass (domain: konsulko.com, ip: 209.85.222.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-939f5f82829so12783285a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 14:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789595935; x=1790200735; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wyucqu1srvY84IACRcsA5X5xV0/lu/KQe4R53T6nA6Y=;
        b=J/LxWgPzgSPF5cjxlIp/dbEPHgjIWaSC6mfMXo8eWFV0TSy38ltmDZWXdBQ59blieW
         fWNRAEYxfJhujRJKfUEmmczsmz3E3YexjYZLd/46vfPt9B1grA0XMZAV/Vza1bnJy7Fu
         Ibux/BZNDk94RPpM1dJnsWSvoQakCceWffDTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789595935; x=1790200735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wyucqu1srvY84IACRcsA5X5xV0/lu/KQe4R53T6nA6Y=;
        b=toBGh2gmxh9+VT0sj/V8qjhqmRVtP4BfEAez6gsBnu63uJtPOZs15xq0/JfrcBzrN4
         B/YOjPwnhIBBXdC0ILR1h17TC+5M9NgNcRj08C362gtc20B2FAaeHV3yqqmuE6ttozme
         qTka7J0W+0LzAmnH7st4cx/PBrYxkaY03tthNcOg4qHd1XySl9C0TOA3ynQg15sxHxZd
         d99cz5Dhqeazkcjq9wkGGnPz764tYwxJ/recMZrgyHoHAOxqARTET9QjlszuAcBMeecs
         g4K2TWpb+6DoOEz9vtw9FFCxDNY2tde9b61mJwUUatIL4A8s+F95oAz7soej3SJxsFQ4
         rlZw==
X-Gm-Message-State: AFuF++lDUWzObn5YgVP7fRPWh4B1E7hZOIpSXlaA6n46lKUoiz9LJ5ZN
	rpsDpDomFBA49Y8IT5uujHd9+jzdx9cxDqv8CTXN8aqdNsW53dCApa+e/AhlJxwjeCqZ1YvTuNb
	6k/7u
X-Gm-Gg: AYBFou2KhByLbNrjAT29eJNs5wBVz7OWryL2zHVafza2gzLmqKDmIm7kbNiBf/G005i
	axUtZ34xdIKdRAaeXjpwMBaHzdte3T61yFTRnUbFgCNCuJSYdQjvwx5OobwwEAVumxEv8ppQ6uA
	pqtg3Djdcwo9nynJ2wuIBxp02P52Yn8PK6CgOuH6G4rZLtIHW2nlUM4qYfgYeSzqW579Ol4LYRh
	RryNYn92h4w5VxEDNll0ZtQf2gEJ10N7Jse/rE8CEF9/eYZ2d9DFD/VlOw9DKuC2WTfqbj/2Xsu
	fpbgfKbfO3rz5/ZbLxJsPlK5QHviBeqPvFDCjQbSGmF98knkrg5iXVO8aic9fZR80VXyXwBRVEp
	aKWGndR5X3kGx2IjdEItE3cz7QS0gOmldHdEevUDAsYgaGL+gsR/gAt2s3NC7IkPqBYmrOXfVUq
	qfXthgjlIfy1OoncAk11f0YORJkvNdZMRmW56AgZ4uZD4qp9fT4tpBXhQba5kGKvL26gZNeOMNV
	VN4STl+AH7I0DFV1gGZq5sao8CnRnB9i6e034kWuurRsTMM9HUxHPxWkON6ZKmJsA20VM9BgYtC
	zleNJfkrKjy4hQdEjU3fiTTaFDyVUWwUrlI=
X-Received: by 2002:a05:620a:1a13:b0:939:a095:e458 with SMTP id af79cd13be357-93bc6240a74mr199491185a.3.1789595935056;
        Wed, 16 Sep 2026 14:58:55 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781def43sm323293085a.16.2026.09.16.14.58.54
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:58:54 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 19/19] lynis: upgrade 3.1.6 -> 3.1.7
Date: Wed, 16 Sep 2026 17:58:19 -0400
Message-ID: <08d4b877fe1271b64f885364424391845c942561.1789595456.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789595456.git.scott.murray@konsulko.com>
References: <cover.1789595456.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 21:59:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4874

Release notes:
https://github.com/CISOfy/lynis/releases/tag/3.1.7

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-compliance/lynis/{lynis_3.1.6.bb => lynis_3.1.7.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-compliance/lynis/{lynis_3.1.6.bb => lynis_3.1.7.bb} (96%)

diff --git a/recipes-compliance/lynis/lynis_3.1.6.bb b/recipes-compliance/lynis/lynis_3.1.7.bb
similarity index 96%
rename from recipes-compliance/lynis/lynis_3.1.6.bb
rename to recipes-compliance/lynis/lynis_3.1.7.bb
index 0b81ea9..be37f15 100644
--- a/recipes-compliance/lynis/lynis_3.1.6.bb
+++ b/recipes-compliance/lynis/lynis_3.1.7.bb
@@ -8,7 +8,7 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=3edd6782854304fd11da4975ab9799c1"
 
 SRC_URI = "git://github.com/CISOfy/lynis.git;branch=master;protocol=https"
 
-SRCREV = "06153321ea50d53a27446084e646d9f43fe46e0e"
+SRCREV = "2e99f92265760b73fd6b139868eb8d4116624030"
 
 #UPSTREAM_CHECK = "https://downloads.cisofy.com/lynis"
 
-- 
2.55.0


