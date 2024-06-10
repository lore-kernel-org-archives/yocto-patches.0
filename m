Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFDEC27C55
	for <webhook@archiver.kernel.org>; Mon, 10 Jun 2024 14:33:01 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web10.21159.1718029978694331453
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 10 Jun 2024 07:32:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=DLgvZiT5;
 spf=pass (domain: snapchat.com, ip: 209.85.208.44, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57a1fe6392eso6501734a12.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 10 Jun 2024 07:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1718029977; x=1718634777; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ef3+8K0rbfHA8RlVjUkBhEawQATHVIqGwk0qq5eSrw=;
        b=DLgvZiT5I7l1aWYGt+S0CL9SDfDR+vPtm24i29UlNTbj+dXRvXW1UcA8ywSAolmjep
         O39p/asTyiMZShwXznIAC5MXO2l/9yDIvgkSC97WblxWkCWZjq4LDm9JVM9Q4YANGSyH
         lwPpg/cFzG9tNlRr0fdwe9dW+ELs/VwFY++hM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718029977; x=1718634777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ef3+8K0rbfHA8RlVjUkBhEawQATHVIqGwk0qq5eSrw=;
        b=ro5HCUOeNSuZ57CNb4YlUpMxZXDBnJ3N6zbTXekVwSCLROlw/jXUk8ZVhjiofX1v2g
         7pJ1lsM/AAyyB7FHQds2a3qj7J+eaNi7L6hA5wN6vkyYHusOo0AKkSC2ODT8cjzR9RcL
         TgtKlyoXXyIHWSxsFpF7fXMtjZHiCCLn2WSCBiE5bRidB8i4A6MGgrnA0S+S18SUQleH
         AcI9iOlNdkpp/pmiuey4hSBzPs1+pT8eNisbyxFsMiHT4fU42d1Kz9ZOUhvXunjKq+XH
         4JkYM3zib1oq73CXp0oq07XyW7A130SWHbG3Vdr5K2VaJnUEsdCsMFQavkZxWKpUBvyG
         /DPQ==
X-Gm-Message-State: AOJu0Yy05pSx/UuUQqdOnddVyn3B8tsFjcsSunaes48fawHSwOL8zv68
	VmWX4Xm0orTLZuH929ISrs4OetyPRf2apY5jsBfxo3xXZmTEoUonpIuIf4pKsNr9te7S+6lMEg4
	38hU=
X-Google-Smtp-Source: AGHT+IFHDairLONhV4dSVr4KRDZqAAGlm841GTghoVGrAvuho2C6ikP3lAYUwGhKianjNRPGBREeSw==
X-Received: by 2002:a50:8d18:0:b0:57c:8022:a3db with SMTP id 4fb4d7f45d1cf-57c8022a950mr2203878a12.6.1718029976950;
        Mon, 10 Jun 2024 07:32:56 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([213.249.125.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae237408sm7504233a12.93.2024.06.10.07.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 07:32:56 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 08/11] binutils-cross-canadian: disable gold linker
Date: Mon, 10 Jun 2024 16:32:11 +0200
Message-Id: <20240610143214.2376414-8-ecordonnier@snap.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
In-Reply-To: <20240610143214.2376414-1-ecordonnier@snap.com>
References: <20240610143214.2376414-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 10 Jun 2024 14:33:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/290

From: Etienne Cordonnier <ecordonnier@snap.com>

The gold linker doesn't compile for MacOS, however we're not using it so let's just disable it.

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 recipes-devtools/binutils/binutils-cross-canadian_2.%.bbappend | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/recipes-devtools/binutils/binutils-cross-canadian_2.%.bbappend b/recipes-devtools/binutils/binutils-cross-canadian_2.%.bbappend
index d3cf881..d47237c 100644
--- a/recipes-devtools/binutils/binutils-cross-canadian_2.%.bbappend
+++ b/recipes-devtools/binutils/binutils-cross-canadian_2.%.bbappend
@@ -1,2 +1,5 @@
 # Remove -rpath-link and -rpath
 LDFLAGS:darwinsdk = "${BUILDSDK_LDFLAGS}"
+
+# gold uses uchar.h which doesn't exist on MacOS
+LDGOLD = "--enable-gold=no"
-- 
2.36.1.vfs.0.0


