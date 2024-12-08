Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F46E77173
	for <webhook@archiver.kernel.org>; Sun,  8 Dec 2024 17:53:26 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
 by mx.groups.io with SMTP id smtpd.web11.82922.1733680400462111524
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 08 Dec 2024 09:53:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=e8b4XES8;
 spf=pass (domain: gmail.com, ip: 209.85.128.178, mailfrom: akuster808@gmail.com)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6f006748fd1so4139877b3.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 08 Dec 2024 09:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733680399; x=1734285199; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hwbFmYIDwLNBy3TmIydM0/o2K44vW3QOuQBFoRyIUAQ=;
        b=e8b4XES8CEHnOR66MnIDlM5JtR0bVkUT9cWHEvVYwubdeMrFBUfj+reseQxrnF6bm3
         8WyMa7o7HIzcCkZYEAp/tevXCc6Eg7SIB6+lGjXzm/aBWBss4F7CvZYPnmhe64zGynk8
         FsFj1FS59iJrecbO0DbBywo9W47GXXcqVpCUiAyH1Yxb5X4cqA+hDv2ZTrK2mpZz0NoN
         +Y7jkfHsQlfvLnsuvP54A34sAbswjT/vngMTPjPD1tagjjmr9m9yleSpz4p3iceSWpUt
         rKDQ4QL+JxwRrTkyyKa/FmO97lHg9xmymR5SQV8mn2Z6UwsD65jJh/vO+A/DjfP4E5lz
         syZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733680399; x=1734285199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hwbFmYIDwLNBy3TmIydM0/o2K44vW3QOuQBFoRyIUAQ=;
        b=GpY/VIDzgy+QxkgHOblSlY6F+tn+ePKAodncwQcAB9zh9dtgfg+L1x0YwOMb5Rw6lg
         ATmzuJGvDlq2KqTsC8dReRaIUlYHxnWZUotUYJg27kjHvU7f0XE6EV8aCxVe3oUbz0dr
         fosIe6LOA7SkKAdOSEUQ10gzEZyju5sjre9axEMKaX1SF/wUqcJZaB+PNdS/9GP8rUeq
         VDRK9l0oDch+Lr6fAP+fpvn75d8F5cDzfOIphbc59vnZJYDyKG9IAkWXWnDTH+2t1O/o
         GnznX+ME0gXveCZWloudKhlRomhgi0DYFXaskLpBSztXitkU7bHXoEJeNm7WWuOvX2Q8
         8ztQ==
X-Gm-Message-State: AOJu0YybGdlrJqdrE1468IsoT8/IhXSF0FEnTtibEio1/8D/NcgUklFW
	8EzJq0TjYUTKIiiuXt3khOTTChDJ236/0FbCzS4NffU5D6x7KaNB2/4BwXFu
X-Gm-Gg: ASbGncvjCI8eMRluG+UYPWlEG8Plf+K6yH2IR0uGNpdBd+1hIr430z0NrU2Hnhf+7vV
	yAggMgHVr5iV0YKukIiO0qCoD9LKWjRknK9zadmHn/foDuLI8g7sM/5Z5aaD0mOefNSpWIos6gD
	xwNTKblO5c6KVF8Hhpv4Jj8TVy2rQGoMjoWjlIHyNxzpnqMyO+p86OO1t7Ee1l8TujCNpEflqAp
	hftv6jcGheyiAOIfQU991t1hScXdFBYAdd5jhImXg==
X-Google-Smtp-Source: AGHT+IGio1MEqhsGX7A6kxOM4ZgC16GPkbba+vr66TM5NmS1Y8LqaL074TGOtcTXbKQovJiePdxTxQ==
X-Received: by 2002:a05:690c:6f05:b0:6ea:8a73:c0b with SMTP id 00721157ae682-6efe3bceb08mr111745607b3.7.1733680399380;
        Sun, 08 Dec 2024 09:53:19 -0800 (PST)
Received: from keaua.attlocal.net ([2600:1700:45dd:7000::d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6efd384eadesm19103777b3.26.2024.12.08.09.53.18
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 09:53:18 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 1/2] harden.conf: drop debug-tweaks
Date: Sun,  8 Dec 2024 12:53:17 -0500
Message-ID: <20241208175318.833015-1-akuster808@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 08 Dec 2024 17:53:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/869

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 meta-hardening/conf/distro/harden.conf | 1 -
 1 file changed, 1 deletion(-)

diff --git a/meta-hardening/conf/distro/harden.conf b/meta-hardening/conf/distro/harden.conf
index 1a5eb3d..fe87270 100644
--- a/meta-hardening/conf/distro/harden.conf
+++ b/meta-hardening/conf/distro/harden.conf
@@ -6,6 +6,5 @@ DISTRO_FEATURES = " acl xattr pci ext2 pam ipv4 ipv6 ipsec largefile usbhost"
 
 VIRTUAL-RUNTIME_base-utils-syslog ?= "rsyslog"
 IMAGE_ROOTFS_EXTRA_SPACE = "524288"
-EXTRA_IMAGE_FEATURES:remove = "debug-tweaks"
 
 DISABLE_ROOT ?= "True"
-- 
2.43.0


