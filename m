Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C5ED0BB56
	for <webhook@archiver.kernel.org>; Fri, 25 Oct 2024 08:22:56 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web10.7374.1729844566097079136
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 25 Oct 2024 01:22:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=bKtmWB+Y;
 spf=pass (domain: gmail.com, ip: 209.85.221.48, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d5045987dso139500f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 25 Oct 2024 01:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729844564; x=1730449364; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWzzuPcq0E/NAMykXkim/3So1g4FXiBdN6f1GNwjT0I=;
        b=bKtmWB+Ymh4soVoc/WqoDEy5JYp4CQpL52EEAOhbW3b0dHhR0WmyKVjY1oMYQPq2kr
         B5pp9qzDWtAciOrO4CgrOdqs3jnkOMORIDEo0D7UXWkkaCro0Bn0M0OAc90Y+AxJ3wIT
         5QpR451ovs/OTvCFHSIeyqNQcf4QqR2wbs4FWcbqy+w74KTkhGDFYPu0laDXwpzIrvRX
         ky7xC/BO1Rcr6S7q56gCwez0fpszsB7ADAtupsJdIQYsjhX0hXV67XsD4rwU/m2luw88
         GDC4b3dgorCuX1UXMB+rrtL10chB2IOG2b55v9ezoN9K+1uFGdKwXnGxSjMRR7JmImZ1
         i+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729844564; x=1730449364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BWzzuPcq0E/NAMykXkim/3So1g4FXiBdN6f1GNwjT0I=;
        b=HaTuSZmdKPKHOBed+ozoEDSP2wXIqQilCX1TQb0F4OLWkwOh3Jd/LBuIM0TkvXmGDJ
         Ew645OerU1bxsDyFb4ivdtfebccy7fYTLVOE7DagfSaUQJEu6h2W+B6DHkqM7O1sYhsw
         lcyB1rHL4CDuLnTIW+0ezy3y7Q7VbVSyRtJWilr5MDo5KeYTggozjpeOkpsiADB7iWnF
         8M8PDU7E1rQiWEpPlxHSIlNyLOcNGdm6+p1Fmwi5F1AHfmwxy88pcgQnF5uO3htF9M0v
         4o0R5Nz+PtYTtNT6nSQeozrwwShJLRt6kz4nX7Y72gaE+BRpXFzLBd9FWfgktUMlX/hR
         vAjw==
X-Gm-Message-State: AOJu0YxukoSzKvTQ6lVI8tSdaaYjCzdVw2f3pQouoBRs2ECx6v9DihWY
	14z/XBJTDcw72tunqfAq3zrkWsOMyXdc9EjLhUL11fvKEN06BCVEUdBTkEK3
X-Google-Smtp-Source: AGHT+IFcooI9/LEtpGnsoDFjyfacErK8h3GmisbJwg3PyzfkNWWr9h3vQ5IuncQm34o5aOMSI6RDIQ==
X-Received: by 2002:a05:6000:2a1:b0:37c:f388:cd48 with SMTP id ffacd0b85a97d-3805b49e562mr255506f8f.8.1729844563558;
        Fri, 25 Oct 2024 01:22:43 -0700 (PDT)
Received: from archlinux.. ([2a01:e0a:ce:f2f0:2a6b:35ff:feb8:77d9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70bc1sm907904f8f.70.2024.10.25.01.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 01:22:42 -0700 (PDT)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [meta-security][PATCH 01/10] sssd: add whitespace after ?= operator
Date: Fri, 25 Oct 2024 10:22:30 +0200
Message-ID: <20241025082239.3468351-2-gael.portay+rtone@gmail.com>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/749

This adds a whitespace after the operator ?= for the sake of
consistency.

Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
---
 .../networking-layer/recipes-security/sssd/sssd_2.9.2.bb        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
index f973ee1..fcf25bd 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
@@ -42,7 +42,7 @@ CACHED_CONFIGUREVARS = "ac_cv_member_struct_ldap_conncb_lc_arg=no \
     ac_cv_prog_HAVE_PYTHON3=${PYTHON_DIR} \
     "
 
-PACKAGECONFIG ?="nss autofs sudo infopipe"
+PACKAGECONFIG ?= "nss autofs sudo infopipe"
 PACKAGECONFIG += "${@bb.utils.contains('DISTRO_FEATURES', 'selinux', 'selinux', '', d)}"
 PACKAGECONFIG += "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd', '', d)}"
 
-- 
2.47.0


