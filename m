Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3317C52CDA
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 01:06:40 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
 by mx.groups.io with SMTP id smtpd.web11.46855.1722215196923825649
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 28 Jul 2024 18:06:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=g1cxGAqV;
 spf=pass (domain: gmail.com, ip: 209.85.128.182, mailfrom: akuster808@gmail.com)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6659e81bc68so15511027b3.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 28 Jul 2024 18:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722215196; x=1722819996; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RySEZOSlgxdsR7Kn6hryk72oVJVoq7xmCYRduosdzRo=;
        b=g1cxGAqVxUdXbYQLvEn+Bd1tTu04kt9n+aOFtu+grvXmyqwfeIQLO0x5Iu1uhjEl6F
         9THDfr1hINTKboDUw6OEHwGhdBnAVLLSQ/0eCLxMbhQr+R+oBkWzu+2rd3QPPwFWsXeu
         aqNkkil+xbXtyIK2HK8om1MPRodaulgD1LfNC6ojElV6BnGHZoqN/vY8K4yjOzCaeYP3
         4zi1ZSErfiEeP3FuHWzrtvvOWjTi5G11shoZt4jfxc49VioxsQMAumDvvkQY49f0vbqV
         p1ODH+9ZWtWPtaAIzh4Dts1PyO9s1RFUKJP0qA6xZM3olsWjWUnEZKAJWWgiABUiE5SP
         QEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722215196; x=1722819996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RySEZOSlgxdsR7Kn6hryk72oVJVoq7xmCYRduosdzRo=;
        b=WzLIQLYDn5yueFyv6w+5sMiQvJpyVm81Re50t44G62Fp27KVKjpY3qq+Ca1itj/zAD
         vzZLPB3cU7tcvQMdWzMyCIfTHkas0bFr/QKbQamY02ji7JizRzvQJ4B0D12Y00tGQ8Zn
         8vso+kywN0N24di3xwffdgAsxqycmRHO+rXOvmrfPnN0GIdQaNPPoII+vFbqxAkz2EaI
         gv70Zmr2TE0WvJwgruPqS5LC063wMM8TMn0Uzgd+quzfOOdO3yI0FRXGTw0sXoWI6MdE
         KI7l0kyQojoyAVv3WsU5fD3SlKypkEgLXEzQx+chOdQeZA9IvbJ4H0gbv88a5s9ELO4B
         QYrg==
X-Gm-Message-State: AOJu0YylQ+ucWnp8a9FzSDrnI3WMxr8xgEPzF2bWyvktVx8wzz3CxrkM
	B7qIXgDSlEhhh1H0cgUuZJT9QYQlKz6QzymMZNbZNsek3URnXOX71oV4mg==
X-Google-Smtp-Source: AGHT+IGudup1sEabBAS7iT4F7RxGq7HcNr5JXnvkHKfnQq1eEZ4vhrWI0Mf3iF3bfV5YVonlAWamXg==
X-Received: by 2002:a81:8901:0:b0:64a:e7ec:f3d with SMTP id 00721157ae682-67a06a0c0f2mr68129257b3.18.1722215195940;
        Sun, 28 Jul 2024 18:06:35 -0700 (PDT)
Received: from keaua.attlocal.net ([2600:1700:45dd:7000:47bc:453d:d517:b47])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756bc9edd8sm18543157b3.130.2024.07.28.18.06.35
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 18:06:35 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 2/6] python3-fail2ban: convert WORKDIR->UNPACKDIR
Date: Sun, 28 Jul 2024 21:06:30 -0400
Message-Id: <20240729010634.1991558-2-akuster808@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729010634.1991558-1-akuster808@gmail.com>
References: <20240729010634.1991558-1-akuster808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jul 2024 01:06:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/482

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 .../recipes-security/fail2ban/python3-fail2ban_git.bb         | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
index 1d0fb62..52d35f8 100644
--- a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
@@ -26,13 +26,13 @@ inherit systemd
 
 SYSTEMD_SERVICE:${PN} = "fail2ban.service"
 
-S = "${WORKDIR}/git"
+S = "${UNPACKDIR}/git"
 
 do_install:append () {
     rm  -f ${D}/${bindir}/fail2ban-python
     install -d ${D}/${sysconfdir}/fail2ban
     install -d ${D}/${sysconfdir}/init.d
-    install -m 0755 ${WORKDIR}/initd ${D}${sysconfdir}/init.d/fail2ban-server
+    install -m 0755 ${UNPACKDIR}/initd ${D}${sysconfdir}/init.d/fail2ban-server
 
     if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
         install -d ${D}${systemd_system_unitdir}
-- 
2.34.1


