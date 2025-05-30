Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58406C5B543
	for <webhook@archiver.kernel.org>; Fri, 30 May 2025 17:22:49 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.web10.947.1748625767516194058
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 30 May 2025 10:22:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Nf0hn6Hg;
 spf=pass (domain: gmail.com, ip: 209.85.219.47, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fad0820112so10721056d6.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 30 May 2025 10:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748625766; x=1749230566; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nHePsYzAfn1nDztr4Wad4YLfxz+uWeVhj62nyBzrLSw=;
        b=Nf0hn6HgVj8dT0E80jEwi3t2ZUdf0KBNYIXsEzUaS6zOpgsmiSxk14h23gA/hrFBjp
         jOIU9Ce7eybAbmTeL7YWBY/ti36eygbQ/tfME5rV0cAixnczp1knXRcBzgk5LU4qvs9Q
         5BmjdGDMoJ2jn5M2VvejOW5nxNebSenv30bCZIC/9C0EJLnD6OX0/77xvUBFgRn990ZP
         4D9EIfsbFgPyAjIXvlNwtQeUZGDn1vHpPO5HQhzZzewhW6IbyhhISLcw+8a+UfjseLQH
         V5SDI/DztyA7oKlHxsYl2LeT0zOqB+gfOXe+fZcubzK/OBUtGn1BSlzK2EcSY9QBZWUP
         ZTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748625766; x=1749230566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nHePsYzAfn1nDztr4Wad4YLfxz+uWeVhj62nyBzrLSw=;
        b=k00Ce+t5wb3Ldxg9AStwXSLPh4UbXZhe/VHuZ7IPyUfBvD4IpukO9h0s6nh7GEQNU+
         RNVWV3ZinhTKD+Vspq7dve95iooepPkM4vl3iRLwJqLYO3OIlPqwUw6fowl+NKsaSnHW
         mA/POkOlGm4Su4Ql11c0CMNWWa8CS7xlwbonaBc6u5ij3gqE78KGEiKnfqDfT5Kbaiqu
         apEGuaVUpQ6Mqg6W7Rwy10/JxVIRSL2NkDhDdiGc4Q5a0jzIqELaY6BDA8ggNQE5lg4i
         DI4H/Zy8CmPXqzAd8rHOvNx4p0mql79MW0lXfdQLq0pCVHmBuSaT8fMiYjZM7UuKa1vp
         CJCA==
X-Gm-Message-State: AOJu0YwQYydpUwt8+TTatUBCsNwkL6iZbLPfB9As5qU81wNJCJ/vlVkt
	w4SRjlrTq7OKTzIRx4QeSNaQ4bxTb1w3oPAKY6WuvCIY9F7A4q+mG1ncYSHF3A==
X-Gm-Gg: ASbGncv7rzpPYtZyfidoxRXBB0eR2eeBKqt7YnylmWoDhiApjGb/hCzHEXBHSn8+R/R
	2MSlKnV57pv0Q59sofx2IvcA3Uk29NaJ6FTB3tW6xG200Qwre6VQisqFJIdD2YlWIuEYdZM8oTx
	U6NNQsY+e+pURwauVa1RluNg0B0aN1AfAu4odHPT9P90GN9LBDmbN/Ruu7XQjQSOP5QlARTJJ0j
	swHanty0ztcQHrV/vmxQx6f/oDgAFdirTSEFnq1l6Wk8btJo7WS3DwIowcdvAxZfbGsmeXV71LY
	Y4oITaHloA5kiGkahkstf+2HtHqPdecUUO/z9+Gr2jvqz99mNIo/sN5wmxYQFENr4fXqkb3FYCI
	eL7lup9w/utXSCO5WHydbMHbM38ACLw==
X-Google-Smtp-Source: AGHT+IG0E6kn9tcVR/3rH+jgLMoYOcatQLegDi00zDigaxDoJ93O5OP5ifg8pfKF9eji+wR0dL96FA==
X-Received: by 2002:a05:6214:528b:b0:6f8:ad11:276a with SMTP id 6a1803df08f44-6facf4eac8fmr70483866d6.19.1748625765850;
        Fri, 30 May 2025 10:22:45 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6e2fc45sm26027936d6.122.2025.05.30.10.22.44
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 10:22:45 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][scarthgap][PATCH 1/2] rauc-conf: adjust PACKAGE_ARCH only when using the demo
Date: Fri, 30 May 2025 13:22:33 -0400
Message-ID: <20250530172234.7393-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 30 May 2025 17:22:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1603

Make setting the PACKAGE_ARCH occur only when the user has enabled the
rk-rauc-demo feature.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 .../rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend           | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend b/dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend
index 9b338e7b76dd..c2a68e6236a9 100644
--- a/dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend
+++ b/dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend
@@ -1,6 +1,6 @@
 inherit rk-rauc-demo-features-check
 
-PACKAGE_ARCH = "${MACHINE_ARCH}"
+PACKAGE_ARCH:rk-rauc-demo = "${MACHINE_ARCH}"
 
 FILESEXTRAPATHS:prepend:rk-rauc-demo := "${THISDIR}/files:"
 
-- 
2.44.0.478.g7774cfed6261


