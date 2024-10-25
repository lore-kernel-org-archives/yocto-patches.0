Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2F6D0C5E4
	for <webhook@archiver.kernel.org>; Fri, 25 Oct 2024 08:22:56 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web10.7375.1729844567305149069
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 25 Oct 2024 01:22:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CoARMUAH;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315b0bd4ddso2595845e9.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 25 Oct 2024 01:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729844565; x=1730449365; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVtLVEK95DnX+oAm+4xjFZf7+LiQCShoHQ7WPtiDrrw=;
        b=CoARMUAHaMnZB+CIFdLpTgBFAgaWLKIr9dZaL5vj1cm5nGjEYzUtjcXAbp6dbZ7VIT
         tyf08Qqrui7/V4OkyiVTHvlz8peTtdXl7iEZcK97L0QMu7Vwheast9zClCIMHVzberiM
         cGZbw/6svcGlHDuGcsQO/TYWdi8D1rPUGHkW2pvqmJZnMnr7/FjcmHifbqSurb/9PIos
         0JypNQExM4pk5ji/cks9wyjyMaI0u3fN5Yt0jp+Ub3k1hxI4T6LN/TL00Em93+RN4DtC
         OLogPcsrng+uSJP9yiM9hpKbOg3EoFytZN5xT04T0CgExcXGzbdALFoXi/1rvxW4McJ7
         VLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729844565; x=1730449365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XVtLVEK95DnX+oAm+4xjFZf7+LiQCShoHQ7WPtiDrrw=;
        b=o1xH67/H36QPZsw1qfSgpBkWwgSOoR4wprDhvB9hQi/Yz5ieTFqQErC918UBLOULAE
         zVixqDD3JX8iXibiKam31KgHTdDPkUseBRpYLKq79iUUux58e+kKw7HbYVkQA9m6fgUV
         JBZvYkIYH+P+/h9qzQsZRH93D5hWmOKDdi5S5R5hwCmmJaTcC+PTObURFQD6EayLNKEc
         F3T1tDfFEX8XKloWpJLKIv+rUFTUyZxeMlZ1whom6HSlbVyCTEtTkGx8hG/et8gMLs/X
         aeIdiJ5fF84x17poIoNABGLsFnXFssJyVvxh9v2pACxkp3BaO86+7GVVrAgohjgmR/kV
         dLyg==
X-Gm-Message-State: AOJu0YwdSxBK5AL3PUipiNqT3xjj1dvSjqnb/nOfeZUVx1WlqNMjXjte
	gYUBaiGHCxuOCcenUajpE6aw1WPWw3huEJWIQBGdNzxOuMtSNTlfJKy4JCEn
X-Google-Smtp-Source: AGHT+IHUKjwC6Z1QD27dAbasHocxlXVUtVQyd2+NhZO6OQgBzsR/IdN9WGW4UitFNxzamgxy3/bi0g==
X-Received: by 2002:a5d:6c64:0:b0:37d:487e:4d9d with SMTP id ffacd0b85a97d-3805b461465mr292578f8f.8.1729844565179;
        Fri, 25 Oct 2024 01:22:45 -0700 (PDT)
Received: from archlinux.. ([2a01:e0a:ce:f2f0:2a6b:35ff:feb8:77d9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70bc1sm907904f8f.70.2024.10.25.01.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 01:22:43 -0700 (PDT)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [meta-security][PATCH 02/10] sssd: fix missing python3-core run-time dependency
Date: Fri, 25 Oct 2024 10:22:31 +0200
Message-ID: <20241025082239.3468351-3-gael.portay+rtone@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025082239.3468351-1-gael.portay+rtone@gmail.com>
References: <20241025082239.3468351-1-gael.portay+rtone@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 25 Oct 2024 08:22:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/750

The internal tool sss_analyze is a python script run by the sssctl
command analyze.

The script sss_analyze is shipped by the package sssd since 2.6.0.

However, the package sssd lacks installing the python interpreter that
is required to run the script.

This adds the missing run-time dependency python3-core to ensure the
interpreter python3 comes along the package sssd.

Fixes:

	root@qemux86-64:~# sssctl analyze
	env: can't execute 'python3': No such file or directory
	Command '/usr/libexec/sssd/sss_analyze' failed with [127]

Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
---
 .../networking-layer/recipes-security/sssd/sssd_2.9.2.bb        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
index fcf25bd..f6bbac3 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
@@ -156,4 +156,4 @@ FILES:${PN} += "${base_libdir}/security/pam_sss*.so  \
 
 FILES:libsss-sudo = "${libdir}/libsss_sudo.so"
 
-RDEPENDS:${PN} = "bind bind-utils dbus libldb libpam libsss-sudo"
+RDEPENDS:${PN} = "bind bind-utils dbus libldb libpam libsss-sudo python3-core"
-- 
2.47.0


