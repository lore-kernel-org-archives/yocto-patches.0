Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999A0C25B74
	for <webhook@archiver.kernel.org>; Mon, 27 May 2024 21:48:17 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.4990.1716836763995550002
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 May 2024 12:06:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@rtone.fr header.s=google header.b=GxhmdS/B;
 spf=pass (domain: rtone.fr, ip: 209.85.221.46, mailfrom: gael.portay@rtone.fr)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-35507a3a038so40920f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 12:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rtone.fr; s=google; t=1716836761; x=1717441561; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nkF1Nti28fkqxAUWG7orbnnXgdf0eP5BSEnJaQ05zqM=;
        b=GxhmdS/BHk4fsj4fIJEqFb15Q5hd9bkAN9MuVOua8g+Bdk5VnNa317yKrn/ZMmkzil
         oeAyQDy36+L7jEryQ71Ep+Lvm7iRtfi+swhQ6j86qXqNOELRd2ygErXEv8XRX/k4xTDD
         Ok23v0nex9WG+Tg3bt4aJfsDe7apgtJdKKTG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716836761; x=1717441561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nkF1Nti28fkqxAUWG7orbnnXgdf0eP5BSEnJaQ05zqM=;
        b=PvDTrrQRyvriVNXv2L3/5Qa7EV+hly8GAtzPBOnP87i1XjofqXuW9MQGWW4JmtShK+
         ydaQJe4f+Yu/MbRKARsgOKlIr0RgAETwjEQag0xOLpbTcv4IgAmlRR283bWTB1VD3cuC
         SBwE+RxpSvnccQlgc+uwSlVR+ZlE7sAEqJKsNZLw4OD8E0F0kpxY1J0cD89tik5CcSU6
         Jts7SdBHOLgIEoeWf9Wo8Rc+RLPiVxvnaftG35/3wP1yyzdIxzbmY4NJ5GWJ8GWr8sUn
         vGE77Q87f83jmhGTAO8wNeSJNjofd5EzezW1noyE4a2aWoWu8SDAV80ivnz8Di8ON9+V
         llVQ==
X-Gm-Message-State: AOJu0YxrcMu3FgKe7VRMmvjAQkIaUSO9sxhr+h6caZvxRGXa6Z+doqIg
	whautMKlkLLAILehtMqYA4i3DT+CytOq6Tmnq1MlFof0jcnpLGZ5t98TKSlsfCo01BMqWihSDVI
	kNfA=
X-Google-Smtp-Source: AGHT+IG4tMPoXvA7IpFf0ddBE84B6Q/+l/HmQi6pIHh7kfqsoNjAa8OjA+ijbwj9aWbMSoo+LOUbiA==
X-Received: by 2002:a5d:64c4:0:b0:347:3037:188d with SMTP id ffacd0b85a97d-35526c5b6a5mr11217067f8f.34.1716836761361;
        Mon, 27 May 2024 12:06:01 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:ce:f2f0:3a7c:76ff:fe01:6f05])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a1c9303sm9789167f8f.88.2024.05.27.12.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 12:06:01 -0700 (PDT)
From: "Gael PORTAY" <gael.portay@rtone.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@rtone.fr>
Subject: [meta-security][PATCH] sssd: remove duplicate option --without-python2-bindings
Date: Mon, 27 May 2024 21:05:29 +0200
Message-ID: <20240527190530.1894157-1-gael.portay@rtone.fr>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 May 2024 21:48:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/222

The option --without-python2-bindings was added twice, by the commit
4375507f39ed4bc62e1304838870be65f3a81460, and then after python2 was
deprecated with the commit 96737082ad20eabcbbaa82b0cacee0d05d50eaab.

This removes the latter.

Signed-off-by: Gaël PORTAY <gael.portay@rtone.fr>
---
 .../networking-layer/recipes-security/sssd/sssd_2.9.2.bb         | 1 -
 1 file changed, 1 deletion(-)

diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
index d61471c..4c76bd9 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
@@ -66,7 +66,6 @@ EXTRA_OECONF += " \
     --without-ipa-getkeytab \
     --without-python2-bindings \
     --enable-pammoddir=${base_libdir}/security \
-    --without-python2-bindings \
     --with-xml-catalog-path=${STAGING_ETCDIR_NATIVE}/xml/catalog \
     --with-pid-path=/run \
 "
-- 
2.44.0


