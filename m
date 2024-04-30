Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAD0C10F16
	for <webhook@archiver.kernel.org>; Tue, 30 Apr 2024 20:33:53 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web11.26388.1714509229300774962
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 30 Apr 2024 13:33:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=hpF8OJy/;
 spf=pass (domain: konsulko.com, ip: 209.85.215.170, mailfrom: tim.orling@konsulko.com)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso4191701a12.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 30 Apr 2024 13:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1714509228; x=1715114028; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqbNu10cZ0e96rT1opGtOyr8cL5pEo70o50L8yLaSEk=;
        b=hpF8OJy/q07PeHm3BkflM7o+9DzRYqnpaZP90nRnjWnsMtqQzPe+DbK3TwaliPBRqv
         wNNWoChqPHJHsk5uewdiEDunYw8FmN5O4q9yY8njy5WvfUzXfq/bjpnC04B8bSjBsjFQ
         C8PE9zEvpf4ZkotmGC4/r8ytKvHswwZ6oE+3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714509228; x=1715114028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqbNu10cZ0e96rT1opGtOyr8cL5pEo70o50L8yLaSEk=;
        b=e5S91W08s1UcRcHn8eIypCROpyNQJd0yePY+uvppZYqTOr3Bj37vfnMZ+uulSMobev
         7ROeFVJrSFS+LBKdHLfi7a2CkPIzWRm7yALIf1UfGTViKDfGjG+OckeZeBZl+h6Te+Lb
         2gfBoewpmb8E7OOV9A1E8oVyxjgqhv2yldE0Cg7qc9LoWTwQgfmzxDoA3Hvi+cQPk+so
         KyzQyzQsNEFj2bv2lNeuj5XY7qzogLQKcT881XI7mhsQresSrbJi6hKq50hJEnmXo/1J
         nwjtERj4eKKTWIiJzKay68AQH+wyG6AxkNOesJxHnQRvLcN8clOUFQXRz2cWaKsdp8cT
         huNw==
X-Gm-Message-State: AOJu0Yw7veTGscKbHGDLhbXFbkzUDzb5DZ6itj2FsK44yODeEJ58kkVx
	NLcb+I0JFtPyg5Po4o+bqIwfWmr205pzmfn43L2lYRCIOPxHm4TNnnn6C0+hjPs+GpUIY3caAN+
	VsAw=
X-Google-Smtp-Source: AGHT+IHSeR4O72KtZqWEDOl/ex/fEIUagyzCRUoomkkUCvuwN1q00AaDIX/vED1OlELYtGGaez2RHQ==
X-Received: by 2002:a17:90b:8c:b0:2af:a2a:ad67 with SMTP id bb12-20020a17090b008c00b002af0a2aad67mr634951pjb.4.1714509228251;
        Tue, 30 Apr 2024 13:33:48 -0700 (PDT)
Received: from localhost ([2601:1c0:ca00:bd60:e8c5:20ec:b8be:259c])
        by smtp.gmail.com with ESMTPSA id n5-20020a6563c5000000b0060ec09873fbsm6614196pgv.7.2024.04.30.13.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 13:33:47 -0700 (PDT)
From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [meta-security][PATCH 4/4] tpm2-tss: BBCLASSEXTEND nativesdk
Date: Tue, 30 Apr 2024 13:33:35 -0700
Message-ID: <20240430203335.110707-4-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240430203335.110707-1-tim.orling@konsulko.com>
References: <20240430203335.110707-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Apr 2024 20:33:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/78

Dependency for nativesdk-swtpm

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.0.1.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.0.1.bb b/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.0.1.bb
index dceebc2..334b638 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.0.1.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.0.1.bb
@@ -94,4 +94,4 @@ FILES:${PN} = "\
 
 RDEPENDS:libtss2 = "libgcrypt"
 
-BBCLASSEXTEND = "native"
+BBCLASSEXTEND = "native nativesdk"
-- 
2.43.2


