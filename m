Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAEAC5B543
	for <webhook@archiver.kernel.org>; Fri, 30 May 2025 17:22:19 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.web11.972.1748625729192765616
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 30 May 2025 10:22:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VzdcqgDj;
 spf=pass (domain: gmail.com, ip: 209.85.222.179, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7d098f7bd77so236048485a.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 30 May 2025 10:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748625727; x=1749230527; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xel3u2V8FBbcYy5FJgwCxaZcV4WRw0YnVRqeOyOT1GE=;
        b=VzdcqgDj2YhTu3bL3lxXax9AIOcrbsEtPvQWpujIwCJFeBH9sOi0a4MtS2FaOYcU0/
         wip5hprrUOeyjTjSZ/vrz2ART/bAt+qKrICINdlWodZVfiBOCth6lijlNFrOla3LgNOM
         cnnQMmwuY8h5viJOzBJUsptQ+TVX3XcZbGO3cmIvYdGVd/iqjQQdxEp2ehOjN2s7+TfT
         lgTft2peiR8Ibv1BMQzWC/qq6czB9vXoEduLZKDk+0Tk1pvlxQ7vZsuH03PD0P7yGpWd
         OF2UwtYITpMcYw2DT2wNzs05wWsyqr0R34ozObSmrKE7hAmdNHn6/blAA6UVw7SIPlJX
         tldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748625727; x=1749230527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xel3u2V8FBbcYy5FJgwCxaZcV4WRw0YnVRqeOyOT1GE=;
        b=J0UsgnII0XGT01gVz3DTVDjBZFaFAT1G7b8QwftZ8a+4mF6+ZiHqtR8ssKNP/uFImk
         s8WVxKjkBa/rIiI/RD5PtKVJCfjE/i2DeXbRhpnynERX3rKnLrILLfbtwTBOYE835a22
         rmAb8WiPi02vJzkEcgtWM6+CvobGSTllWmG5qHyDsg6vVVwAT+d/f1FjPVS/qf6RLy1i
         lnaEv4+KhRUHZUU3uQlYvWyv3wQ4il8edgbp3pivmpa9pnDWw48PZv7WjWgfm06hCO9g
         RdVIN6HxMDh2AnThdr0CFdalm0EEKC/kohaBoFVxtQfO4NyNK2BZ9Mn0IphGqy84dXfW
         2CYA==
X-Gm-Message-State: AOJu0Yxl+Jo1rvApS2Ftf2h2f4CVlSb2N0wTe7fc1SZ6few7154AT53J
	PpH1ZETdR5jkXPsYR9nU9MY0QjN4zD4GP4kSm4Sr1scT+nSoS8EP6IL8QXxHBw==
X-Gm-Gg: ASbGncsyrkOl0h7ErqTkuKbQIA52khbU8YzPa0eW7h+JAxGvyej8s4S9YlOZNXH2eEI
	8uiUj6Dvt+865XZoxN0e7ESgk1UTDdxRVSaBfBvj5TyuxgEGDF5eqxPNyYg5i0Pp7LSNk5vIcqn
	A6fPUzPmoRol1eXGsnHt/kJEI2UCZ0+ptfVkccb+k4ia8NQKa23B5TlI/TVTYBfomCimHC84R4c
	dkqjqXJFTmTG89D3wNMkLEkzqm+HBDfddWccOIrz0f2m7p7YJdiQpTYlSG/CrWpJJ7hzbANnJgJ
	MvfWPK8cwyrc+XoWDxiuc1kYmt88hW14mh7Q+sqLqY8aZfk45Sim26pQLZNoN88tZvGM9zibjb9
	SXIlr96MbWPvlZC3UQUsjElA3HCbZZw==
X-Google-Smtp-Source: AGHT+IFIEn/oHs+kikPzDNghjjLEtFUNsDm50M9AzhUyQZSaqHqoB1jHk69/tWjkBSxdf97cVPe/vg==
X-Received: by 2002:a05:620a:a518:b0:7d0:a2c1:975b with SMTP id af79cd13be357-7d0a2c19821mr554309985a.14.1748625727368;
        Fri, 30 May 2025 10:22:07 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a195d7dsm264984385a.78.2025.05.30.10.22.06
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 10:22:06 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH 2/3] mesa: enable libclc for panfrost
Date: Fri, 30 May 2025 13:21:55 -0400
Message-ID: <20250530172156.7199-2-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
In-Reply-To: <20250530172156.7199-1-twoerner@gmail.com>
References: <20250530172156.7199-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 30 May 2025 17:22:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1601

When building the panfrost mesa driver, also enable libclc in order for the
build to succeed.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 recipes-graphics/mesa/mesa.bbappend | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-graphics/mesa/mesa.bbappend b/recipes-graphics/mesa/mesa.bbappend
index 9e9bf9afc4a0..ae68fbe680a5 100644
--- a/recipes-graphics/mesa/mesa.bbappend
+++ b/recipes-graphics/mesa/mesa.bbappend
@@ -1,4 +1,4 @@
-PACKAGECONFIG:append:rockchip = " ${@bb.utils.contains('RK_MESA_DRIVER', 'panfrost', 'panfrost', '', d)}"
+PACKAGECONFIG:append:rockchip = " ${@bb.utils.contains('RK_MESA_DRIVER', 'panfrost', 'libclc panfrost', '', d)}"
 PACKAGECONFIG:append:rockchip = " ${@bb.utils.contains('RK_MESA_DRIVER', 'lima', 'lima', '', d)}"
 
 RRECOMMENDS:mesa-megadriver:append:rk3588s = " linux-firmware-mali-csffw-arch108"
-- 
2.44.0.478.g7774cfed6261


