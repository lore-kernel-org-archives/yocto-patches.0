Return-Path: <chuckwolber@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE2FD6A255
	for <webhook@archiver.kernel.org>; Thu, 14 Nov 2024 22:44:08 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web10.7509.1731624242689073179
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 14 Nov 2024 14:44:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HkRa/YHT;
 spf=pass (domain: gmail.com, ip: 209.85.210.181, mailfrom: chuckwolber@gmail.com)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e5130832aso886155b3a.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 14 Nov 2024 14:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731624242; x=1732229042; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iJoIg9JmB8MR2Jk1vvpPVlxN4Xo6qpEMbBdcGJs+O5Q=;
        b=HkRa/YHT9GhG3dMwykAMBLAGFqAZHQO2blpwCksUkh0W/SDYK3mITiXprQXBh71vkl
         Ox8yQg8vETi16wI3fddbsXkoFD2MOOmwxikuy+k3RBnANvcNN50WcUiluQzPQ21tvbsf
         KadqMFN1+3cY2flBiuflzuuQJgsloafpAGWFyUsLCPk/x7ADKz89lLpxx2mFDktkZrf0
         bt/G2Nvg+CgBoW0eBxfQg7LPMkmMu90hbRZ4FDqwmf4yASlPzWM5AkyRz6vtnoh0GUfZ
         b7oOk4GZwInnn6m4B+RMtOUmNbNwhnmRiy6yxyo/0y/AkH1+SOrP9Qfng4PqA7AUUCX/
         0dfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731624242; x=1732229042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iJoIg9JmB8MR2Jk1vvpPVlxN4Xo6qpEMbBdcGJs+O5Q=;
        b=aNUXH5AeyJlBTZimAEfCoilvr6t13s+VJoYZ3/gN5A/EurXQD2XZvG8OcAp1WHS3qZ
         MyrVnBfS8Kus4tR4J593csdVHHPvU6dWEPC1ngwxhCXaN2MfX1m32BgsEjuu7L8M1FmI
         5JiO4T++3IflH7l6NLjsfzRbBechbBAhW4avRVEAYsHnzSEPXbPNsisMm/SaYom4e/K0
         44T065775/gopnV159/2qh6+Kw8gW1aPU2/g4uYNJd56AgBuM2ajI54wk/8nvFdeBDeK
         n+JX8F+Z6cVp+m1byidnW3tSuaRuZxI6jdiEzdjtV7HzeEbMYzCu8SEWChxFwQDVCswW
         XhYA==
X-Gm-Message-State: AOJu0YxElKGnI2E62Erw14Fwqdn/sJyeQwbw6jGmLAwFWaAzITgD3d8Y
	bk7PGOh/9g9oklZhYLKQPepx4sFxfPHwqIls9+Nx41FeNRauabtG3O5ccQ==
X-Google-Smtp-Source: AGHT+IFsxJDm51eVHQorzF43qYISYa1HNhowwtogFmqWl6d87gbQmMjYgfdGu3ZreJOpDRbiVOqMPw==
X-Received: by 2002:a05:6a00:138d:b0:724:63f1:a522 with SMTP id d2e1a72fcca58-72476cd092dmr570529b3a.22.1731624241796;
        Thu, 14 Nov 2024 14:44:01 -0800 (PST)
Received: from tsi-6.wolber.net ([2601:601:cb7f:1401:5a47:caff:fe73:7b1c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771e1a69sm157409b3a.141.2024.11.14.14.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 14:44:01 -0800 (PST)
From: Chuck Wolber <chuckwolber@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Chuck Wolber <chuckwolber@gmail.com>,
	kweihmann@outlook.com,
	Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH] templates/base.html: fix broken FAQ link
Date: Thu, 14 Nov 2024 22:43:45 +0000
Message-ID: <20241114224345.10768-1-chuckwolber@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 14 Nov 2024 22:44:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/803

Fixed a broken link to the OpenEmbedded FAQ.

Fixes [YOCTO #15645]

Reported-by: <kweihmann@outlook.com>
Co-developed-by: Tim Orling <tim.orling@konsulko.com>
Signed-off-by: Chuck Wolber <chuckwolber@gmail.com>
---
 templates/base.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/templates/base.html b/templates/base.html
index a421c5f..5190576 100644
--- a/templates/base.html
+++ b/templates/base.html
@@ -128,7 +128,7 @@
         <div class="footer">
             <a href="{% url 'history_list' %}">change history</a>
             &bull; <a href="{% url 'about' %}">about this site</a>
-            &bull; <a href="http://www.openembedded.org/Layers_FAQ">FAQ</a>
+            &bull; <a href="https:/www.openembedded.org/wiki/Layers_FAQ">FAQ</a>
         </div>
 
         {% endblock %}
-- 
2.45.2


