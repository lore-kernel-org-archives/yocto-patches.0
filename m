Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487F5D65544
	for <webhook@archiver.kernel.org>; Tue, 26 Nov 2024 18:12:24 +0000 (UTC)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
 by mx.groups.io with SMTP id smtpd.web10.53092.1732644735324003342
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 26 Nov 2024 10:12:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=N6Ng71uJ;
 spf=pass (domain: konsulko.com, ip: 209.85.160.174, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-466a0ac9211so11934791cf.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 26 Nov 2024 10:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1732644734; x=1733249534; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b29HAICtxgZjkdgptgRzxslKSm9pDMY4HGxHK7mDgrQ=;
        b=N6Ng71uJOKzsxBMpXafqJOXntw+psfZvlq4QPQ8b5panEQLiNljOLW6YAyGmQ9jRMc
         L9JuayHILN8Fb4AGxDIAwQIaOoWUAFor3AzPEpJFYu3I89xp8x89Tq4uw5d9Rvrwc+5Q
         Z1tSzvvLGAXjS0jgX8mjgW8YRnrYJ3bDrZVp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732644734; x=1733249534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b29HAICtxgZjkdgptgRzxslKSm9pDMY4HGxHK7mDgrQ=;
        b=SPt+IkGv6oVVEWnM3WX4PKiAUfuFBSrcODAEqh0EoFUJM+YGkdfg/HeuUKJCDNWooC
         6DOW/nDx7eS4Qg+Mv1Mfuwuv07Y1qPF4imMV+VmOd2b2iMMLe/VgyhT1aXjAPBfQJWYm
         jEjdly87iL3mb93hfrthD9zpZINcdvGTHHlyRy5pEbE+3BYR0rrT5J0aV7PDzPwQJ0JT
         W4In6i19zQ0s+568T/AqiLpP+94XrPVWUcSCHY+wwaifEmAQeegc7iNn7DXpc7K+6+x1
         syefdS48V9DvAsMV0t5i2tn4XFczHAGGcnd3EnLYw5PHtK4+A+ArtyfW7raC8lx0bcrH
         5sdA==
X-Gm-Message-State: AOJu0YxU5I1rV8PkWzhTYpjanV3UktqJ+j2HQRLH7eO2H0uHJx5apydS
	zlCNZRClxeUwbQAH03B5cROyU6QFxCPH7MmyQR8wOwfS4VbDoYmPiUg8L/PSLSf3GlBGLrJMjpe
	f
X-Gm-Gg: ASbGnctA6kKNzke1OKlctrZPpHUrJdjPtdkH2PltuhtHcWXeOgEc+3Y1AN5WInqBXsM
	Ehvp60WJRgi19Xp80gI+N9rGUGrQM0N3xHZX4IrOkRHSFBX08vBwtRPPubathkA9jusNpJLQZhx
	CErbUQITVeHANBSoqRZFMvQIAyQWOzjqjk+xUaLXiACzeLskvwHuaVzkwdzCoT4lF/KirnDjwM1
	Txzeiwpfycl376GqPMzD4yDuxwYuyH5Kvonv39iVD0qAmYWnqxiDSDdnLgN+YdwP+w2MVqdxUSp
	CY8yXa20oWyM6pYW5rkJYuO9Vg==
X-Google-Smtp-Source: AGHT+IGumPBq9FaQaL5O00VHUjNE0UR9WYNb+ZqXE0hVcwjRrsoYPWSscc0VcZP2PDAalUD9eHkIpg==
X-Received: by 2002:a05:6214:c85:b0:6d3:9da1:d416 with SMTP id 6a1803df08f44-6d864d3ead5mr494616d6.20.1732644733998;
        Tue, 26 Nov 2024 10:12:13 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a83ea2sm58171276d6.22.2024.11.26.10.12.13
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 10:12:13 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 3/9] rust: set CVE_STATUS for CVE-2024-43402
Date: Tue, 26 Nov 2024 13:11:34 -0500
Message-ID: <20241126181152.407253-4-scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241126181152.407253-1-scott.murray@konsulko.com>
References: <20241126181152.407253-1-scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 26 Nov 2024 18:12:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/835

From: Ranjitsinh Rathod <ranjitsinh.rathod@kpit.com>

As per NVD, this CVE only affects to Windows platform
Link: https://nvd.nist.gov/vuln/detail/CVE-2024-43402

Signed-off-by: Ranjitsinh Rathod <ranjitsinh.rathod@kpit.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit dcb3016f9c0e8e72642cccf335da65345a2f0c92)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust-source.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index becaf2b..929a4a9 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -18,3 +18,4 @@ UPSTREAM_CHECK_URI = "https://forge.rust-lang.org/infra/other-installation-metho
 UPSTREAM_CHECK_REGEX = "rustc-(?P<pver>\d+(\.\d+)+)-src"
 
 CVE_STATUS[CVE-2024-24576] = "not-applicable-platform: Issue only applies on Windows"
+CVE_STATUS[CVE-2024-43402] = "not-applicable-platform: Issue only applies on Windows"
-- 
2.47.0


