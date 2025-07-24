Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5691C83F1A
	for <webhook@archiver.kernel.org>; Thu, 24 Jul 2025 07:27:31 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web10.6918.1753342043116629821
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 24 Jul 2025 00:27:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BhrvWkW2;
 spf=pass (domain: gmail.com, ip: 209.85.221.48, mailfrom: rybczynska@gmail.com)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a6e2d85705so342863f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 24 Jul 2025 00:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753342041; x=1753946841; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3ORcBnRbAkwEXPSNBhBEAN4+0e5vLYXFWGV48vgpts=;
        b=BhrvWkW2eDUj20Dk4s46fJQMeqBHtLZLGZ6eS1eMJsYHYKcXUp+HLD92Xx0yEtZcXl
         pBGcxT6MBOts9q8vtD+UcFLc5/Ilc62vprPpF2n3n2Lv2IFIW+7nx3SXJZSgsE+RsQmh
         QrXRdcAhLLIpTei45asQZq+gPub4lJAunIcBi2LpYoIkZyFPrUcrreozHvM/+pQF2rxm
         XF3quh6shsXGgp/Qjma8DMTWiUYnqC56APr+fkYyKX2Yf/b62NMlkURp7dAIi4KD4r6X
         izOpz1vmZ0Ukv9Dj3Z6Hq2ZMl9SrsWR8whe+oUZMG2nevndZ+K62GPA9uPfmWeUBolPR
         PmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753342041; x=1753946841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3ORcBnRbAkwEXPSNBhBEAN4+0e5vLYXFWGV48vgpts=;
        b=rPKlGkxI6lsUw0wZOkJYl87Su/q4zIVq+PuE+4NMWAzfpr4O/r0mdbNfQUuMSR6uLU
         Zov+yDhuvBbkmifFM+XPFpHvPNxg1GGFHc5ZCkavZvYLzrhcZAVAEJFxkbdhwSDCB/1G
         7M1n+y6fWH340W4kxMTKj+vKvW7mztTlL8kVGzlC07m5fIEpPUUcKK+sj6628+ttew/v
         aVMPN758rdQH1bpkpj6xshwYw7lTNqje5AimnCtgifpyvmNmN4rFeD6VFj87mD1bFduw
         kVjDJCVzlgq0EdsKEgLWClm4j7wBnUBVvlASHh5iDaqVS3GOPAeTIQr8Iov8h0yCa2ip
         YCkw==
X-Gm-Message-State: AOJu0YxtKhVJ+EXU3HzlqVowuU7MYlujmkiLa4QMCfE1plBGuZ2Q0LLG
	EZiABXxkj0gP6b2enE1E3/7FpBoW0ZYYrbJMwZDnykoY7SYtRUx7KBTgBxWg2A==
X-Gm-Gg: ASbGncsLrtZCijibdX7itVoqSHWH5vmXZ7tdUJTNmva1sXIp5FjQK4SCdEroLc3b+1V
	hawxiNNFuQeZlAVvkplWqZCL+D0EPnftSmNeHgO3z5fyZ2/Xu2qyE4z6MRPVFMWJXSY9BLTRNN4
	l5B7lAopXhJ4gqu4c+fkqzTBnfxsgHFfhVZOgg6a3w7EILMkAgmARBfzM8mMoDDdLC+Bv2iJXwZ
	Z1rt40slN22EYHtWvTNpjBakYzcGsG79gqFzt8Fv3825sl02yLdHkDa2CS1Hzj2aHI3z0OECvry
	mjQrDf8Po1iPIvE43O+bQ+U8YrkA8njQEYhFWeXIPgjqstzM4IpNpcasN7ir/BIYZBXgYGl45mY
	exZVHMiqYzeV7vp46RMUN6gGFYJ9DK30+HIc=
X-Google-Smtp-Source: AGHT+IHyKhx69Za2gn+5qEB3LPHYzAA1b2iCVQstSQDQ0crNZDxj1bK66JBKQJplOuG9XVxv3Zw6Iw==
X-Received: by 2002:a05:6000:2389:b0:3aa:34f4:d437 with SMTP id ffacd0b85a97d-3b768ef9577mr4223711f8f.37.1753342040940;
        Thu, 24 Jul 2025 00:27:20 -0700 (PDT)
Received: from voyage.lan ([2a0d:3341:cd4f:d110:cf6f:2013:cd74:cf4e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad23bsm1231723f8f.44.2025.07.24.00.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 00:27:20 -0700 (PDT)
From: Marta Rybczynska <rybczynska@gmail.com>
X-Google-Original-From: Marta Rybczynska <marta.rybczynska@ygreky.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Subject: [PATCH 4/7] bastille: prevent host uids on files
Date: Thu, 24 Jul 2025 09:25:46 +0200
Message-ID: <20250724072642.7358-5-marta.rybczynska@ygreky.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724072642.7358-1-marta.rybczynska@ygreky.com>
References: <20250724072642.7358-1-marta.rybczynska@ygreky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 24 Jul 2025 07:27:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1861

We get an intermittent QA error about file permissions, happening roughly
on 1 build of 10.

The change adds chown to prevent host ids on files related to the
set_required_questions.py script, to avoid long debugging for now.

Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
---
 .../meta-perl/recipes-security/bastille/bastille_3.2.1.bb       | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.bb b/dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.bb
index b95ec2d..fa9a964 100644
--- a/dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.bb
+++ b/dynamic-layers/meta-perl/recipes-security/bastille/bastille_3.2.1.bb
@@ -146,6 +146,8 @@ do_install () {
 
 	${THISDIR}/files/set_required_questions.py ${D}${sysconfdir}/Bastille/config ${D}${datadir}/Bastille/Questions
 
+	chown root:root -R ${D}/${datadir}/Bastille
+
 	ln -s RevertBastille ${D}${sbindir}/UndoBastille
 
     # Create /var/log/Bastille in runtime.
-- 
2.47.2


