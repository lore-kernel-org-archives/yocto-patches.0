Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BF5CCD1A7
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 21:22:45 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.web11.1674.1760649757257391480
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Oct 2025 14:22:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=aw98VDtb;
 spf=pass (domain: konsulko.com, ip: 209.85.219.52, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-87c11268b97so20479786d6.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 14:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1760649756; x=1761254556; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tn7uE9/mpOkhv+FT9PMcagqvGBR76ucPUG4f4CPey68=;
        b=aw98VDtbxispFjqSsYg7DuS8hSbJk3lV8deIiequuO1RVWiOyjKRCed4sqEcHaldBP
         IrfdQYnaidBlaG0YrJ5HpCtXHB5G2yDqLKv0R/NKkbgHQDv1MwlaaZ8c7oCwOZNNSStZ
         t3bWl+LSG/MOlAKCWXnMEyZqqPBE6y0IBiWUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760649756; x=1761254556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tn7uE9/mpOkhv+FT9PMcagqvGBR76ucPUG4f4CPey68=;
        b=Z0EhWbstc7VehAZenV4PDC4SadWBbnEa0jWhbNBlu7H2GwIY6HvlQeTDfWJ9t4LOWj
         ciyWaoB+7WjThIiVNyQ9onQWSWMTOiKQ5I904WFLgA8cef4Z3iSU9tisftXMXeQUkfD0
         mQkt6SaRfGc8VhgelGGblVekZQCBbMCiRNwbRjMTG6AJgoaDPZieQACTJyuLanJ/SJuF
         r+HXEp83xDvF4ggLAg3DwDBlw+xCv3c4/ZLvb3uAPHw7jQHFx4ENawqQwH+ltJ9pCfH4
         dO3tE9HbeAlqJoO0Cf9oWnHoi+RZgSQ7ckDE9clddXakR7rn80leL64e6BYT1IvAJ7dh
         UCyQ==
X-Gm-Message-State: AOJu0YyxksxqNGGfqe7BsSLgZjfNLwCGEL+a7liBXdB8ZLVnHdb2fY7f
	BhWANLs5rAi4ueTUUaJOSkR6+Lj7CEB6Ph91B86x0nRWjaRitNJjA50EH2YWPKe64B/R/7TEbAq
	9yCem
X-Gm-Gg: ASbGnctPwBPkE59Dx2MCa6EKzH9m9csBholwdzaGrZtcP5rNZHGyTwd5/awdy4yehlr
	pn+fh3bkFQ4h6JyFKkNSUzlPh6+S3zKv7e7hEVoBVj05WFDz56TDKIgcY4ep2AiUuLH+WJ+nC0C
	fFs/3ViTasZRbE+QaQfy2Hh+C9xYP7rttvTGParBpazSCEoCWuTF1M+qiBHSn8lxoj95BbD0cFG
	B1O/oMJ+a1QFVB9ahcFaU64cdghQVkwfyhD0DjwoEJ0BunfIrZSry27t5FiN4e5Lvk33GERUpdb
	II7TQhm/A3EkMswT6ezCHnwFYNa1mZR98TVSHMKPrZgMTxejVVxiAxG0xo09733ezV8ipaiF0TP
	drfNrJyLKtN9ZN4hNvnMXMz6LUDGWbB3tyYLdB16tu8zankKTyCyAylx4F1ht7pU7CMTCQuUYus
	36JqryyjwfZIKLjaiY2nx4zRwxrr8OHgV3CdQuKT30JeseBi4Q1B6g
X-Google-Smtp-Source: AGHT+IGB08zMIs093ce+67NeIrxcsJ0wIwBSP8wKtCnSX8g47aQdnoLszdGSUpUKxFd1hg4RFrjiww==
X-Received: by 2002:a05:6214:c29:b0:7f3:12ce:864c with SMTP id 6a1803df08f44-87c2070de60mr21124106d6.2.1760649756004;
        Thu, 16 Oct 2025 14:22:36 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c1c2fd4f4sm14647466d6.7.2025.10.16.14.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 14:22:35 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Subject: [meta-security][PATCH 05/15] test: allow root login for test images
Date: Thu, 16 Oct 2025 17:22:04 -0400
Message-ID: <b6eae19ced259baff4cd79f303eaa142c402dfe8.1760648348.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760648348.git.scott.murray@konsulko.com>
References: <cover.1760648348.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 21:22:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2330

From: Marta Rybczynska <marta.rybczynska@ygreky.com>

Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
---
 kas/qemux86-test.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kas/qemux86-test.yml b/kas/qemux86-test.yml
index 98f1e7f..c4609f9 100644
--- a/kas/qemux86-test.yml
+++ b/kas/qemux86-test.yml
@@ -6,5 +6,6 @@ header:
 local_conf_header:
   ptest: |
       DISTRO_FEATURES:append = " ptest"
+      EXTRA_IMAGE_FEATURES:append = " allow-empty-password allow-root-login empty-root-password"
 
 machine: qemux86
-- 
2.51.0


