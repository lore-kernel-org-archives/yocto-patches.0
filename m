Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E7ECD5BD1
	for <webhook@archiver.kernel.org>; Sun, 24 May 2026 12:28:18 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7239.1779625691782124735
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 24 May 2026 05:28:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=oRB8bVtp;
 spf=pass (domain: konsulko.com, ip: 209.85.222.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-914bf8abeaeso166789585a.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 05:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1779625691; x=1780230491; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0h4IMj1xafCDkR6Bmp1bZLBgYlry7jUmO56RVKS4uI=;
        b=oRB8bVtpD69ufKSDtWb/SjoD8akyrIxxHZZa+4CxGx1IiwZsrUK7Aw01bkgzSzKHlD
         +76JnfUZVXbB9c56NTefeB6b7StxNHiZbmBjnCQpWr+ghESwtSOe3nVCXGbsoSj8snO2
         8wnogQQHmkTKuGmgc+blizp+sRl6TWZ+g5/iY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779625691; x=1780230491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V0h4IMj1xafCDkR6Bmp1bZLBgYlry7jUmO56RVKS4uI=;
        b=Miy8KqabsDQgf2m+4NEfIWKOGyyl916FifNFWlPA0hIfv9Y+DszwPdf6Irn31y8FG6
         PbjnzfjfLVBEAWpdeeW1oDwuoJKIhBKwfsKqejKQ8p6GlBlBbarZtBNt0zE5NiWrD7sL
         ilCNsnOXm9IphL30TpsdGJ6MOqL5KsBPjIgqPBPpSnGJbLJK04ZdeUSXzHHGjvJBEZzF
         nlL1pGKS/cGNRhdjaZlKQoUWcnyh8OxOMcqmVF5Y6WE2yogyn3RUc66/CJvQrBhrAt0o
         Xmy8ZzjTkhFG9B8UKTge0ZXNfz62lL8TFtQgpOI+iAchwbUl/uxWikpe3xW1W4vFTjM6
         YmXw==
X-Gm-Message-State: AOJu0YyRVr9jfyS0Mfn3xWN/UGj2W3hvq27gj2noN+/OHkAUugIeNkHX
	0o9JbaJYG5TZYy30d04Z+fzLDGY4GqXcUycd28Cq179bU0gc6VRu5+pNwaiJ0FIRFDm+iRZdZWe
	C2ezB
X-Gm-Gg: Acq92OHWnPZlyOeEp0QYoOwKHSXtcvjihLgCgF7IHw+88pkTkyHY+J98ZQ8FwV/X5Cw
	KtKX7De85fRAzHu6mVhWcRYRCfQ9APIAjFUu5EQWAbWpRF8flWyuesfWpQ+fzIlO9oaNTqh9h6x
	R5Ok05prG6FX1WHZIj8JedJchIYC/u+8i5GgowqFg5ef2DDtmi0GJC9kb7s6dsLCevRbUSXXI4o
	b98TOFyGytSopivZbPj/SM25rtIr69GI7uxVpt3R2EbBgpauWbCXYem0gBhRL8YKBTMXu0ej5M4
	I7GYnTzv7+xZFT44qAG+u8wIx5+z7wiXCPHc0q2C+prmLWUCnvhcJhX05CPiHfI8sPNl5+LIpvN
	aScnBQXiuL0DV755slzcGGhhdObQNfN4O3Ja/8wja8VvXfhGZ9omrxNpdZRrjH4PpU46eOxY7IP
	uND+PuPjCNa4aOWhMQ573Q5mLG0v/5FqTkmMvAullxMKFDS9/1ewPXCGjv7ECRFF6uqI+q+0JnR
	WhOeX6DHXqFN0KRmT12wpd62CmseyhKvAhKr+cNd2cLqgasOfTm7aCI9U1gHA8J
X-Received: by 2002:a05:620a:c4a:b0:913:dcd2:f142 with SMTP id af79cd13be357-914b49cfedfmr1585959085a.58.1779625690711;
        Sun, 24 May 2026 05:28:10 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb8c8034sm751989385a.7.2026.05.24.05.28.10
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 05:28:10 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 02/13] layer.conf: correct WARN_QA
Date: Sun, 24 May 2026 08:27:51 -0400
Message-ID: <05a1e64fbc03db276f744d580131561120a8d635.1779625557.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779625557.git.scott.murray@konsulko.com>
References: <cover.1779625557.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 12:28:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4022

From: Li Zhou <li.zhou@windriver.com>

Fix the typo "tmp-layer" in "WARN_QA:append".
The right name for this layer in OVERRIDES is layer-tpm-layer
by checking "bitbake -e <recipe_name> | grep ^OVERRIDES=".

Signed-off-by: Li Zhou <li.zhou@windriver.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 meta-tpm/conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-tpm/conf/layer.conf b/meta-tpm/conf/layer.conf
index c0fd7a7..3ea7c08 100644
--- a/meta-tpm/conf/layer.conf
+++ b/meta-tpm/conf/layer.conf
@@ -27,4 +27,4 @@ networking-layer:${LAYERDIR}/dynamic-layers/meta-networking/recipes-*/*/*.bbappe
 
 addpylib ${LAYERDIR}/lib oeqa
 
-WARN_QA:append:tmp-layer = " patch-status missing-metadata"
+WARN_QA:append:layer-tpm-layer = " patch-status missing-metadata"
-- 
2.53.0


