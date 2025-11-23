Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E039CFD316
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 23:45:53 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4872.1763941549302684123
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 23 Nov 2025 15:45:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=JA0rh2VS;
 spf=pass (domain: konsulko.com, ip: 209.85.222.181, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b2148ca40eso540843585a.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 15:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763941548; x=1764546348; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZzQXVsLmVEUEr5PzTxZUGAlLe58q9cxQZB6QXPi9NX8=;
        b=JA0rh2VSQskig/C/U4Mqd+YkujAmJKGNmeDZx2Sm3AwWKIbvcj7m8u3CVWLyuXs1wb
         I9cKkLmglQS1Eu1jqOd3/xxt87lJxq4Z8lsOu7xOw41KZZa7hQMc+6zm782WUk3sPXd1
         zPrPyOm9wQNBQLCGUZievTpRZp+SFwfWRKqUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763941548; x=1764546348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZzQXVsLmVEUEr5PzTxZUGAlLe58q9cxQZB6QXPi9NX8=;
        b=kIkak8cyqXJRx7cjVzRKk846UV9ma0CswqrvGYNS6YFIQjU0QM1jHiMNpcjiclPy/w
         8EXaw/B7j2CtlnsXtD368jgvfLnJ54riawJeZ1Vqo5XDNG2v3iEpwL2/E5CaNW9OT1RH
         aSOMS4vx2Hwz2w++pAGXd1vNAqtAEJRL6K59oZulv3z/OW4an4wgEOy8NSWo4XjgPBeN
         YQEsfnAMU+fV2iiFYQhRz95+1sqi893BKB2A9ny0G+j4tuW1qJuY4yOW8LvpnX7Fw77d
         GBAigtQQub4DOc/dFMG91vCJjkuOVs8vTfYPX8BvoYJZqMu4QqVob9hRftvdpSXOliU3
         639Q==
X-Gm-Message-State: AOJu0YyUfFvEbdByRuKocjE3cOPja72gvfATRl6z6swotxQm8Eo10tS3
	qCLLBOmYpJDnBDCdblijg8GXCH01EDjptJjad8pzjKN6wuYe69l4DNKndi7nnP7JTjG+ujuc24W
	bUImR
X-Gm-Gg: ASbGnctDLf8CjHZ0g7kEE2JwCdjfAqc569jWDaXU1IA6AeQ0V4UvBVbtK4DRjNPVvzr
	311cBKBIYr/huWRXrMEuPjX2meAEVc1cxpNwu4t5hl0V7O+u5Bxg+85LaU/jivmBw0SK2J06SGH
	meAHaISGkTjLZgbKOZWo/2M8mSMo3m0UOgUMVD90ngvJHut1Ts4Yy2+fMLTKZ/tInIOJ6dWsTQ1
	V/yXWFVU5WioNUB5zgLLEwcepG+08NbBr0bS+U2yySuCQsbnPEQeuaRYLjlr8pEogrXcAB1f7td
	r5TXg/bWF5hPSCsNu/jiCUAxyRNLFT8211TlFb+aInYCU+iSwxoRY1/R1seupYeRdx4E8lW1uro
	zgm39XEZGjsaJpvm8JBno0QplphaB34onbZorWIs5S5FYap+wieXtat/4ZzZ1OgW/eNa8F3WXtY
	ywAL1fGNzFVl05fsaSpdpCd9pfkmfSjAGS4t4BGA/Lwgbk8QLxBO7Gog1E8WeFWSc=
X-Google-Smtp-Source: AGHT+IGMncHg2o7YYKe+UBpsBINdKU0EaY3GMDZIWS1vDg3rG78hWekxAblKfx+X5hA43pN4kCgMjg==
X-Received: by 2002:a05:620a:45ab:b0:8b2:f269:f899 with SMTP id af79cd13be357-8b33d479781mr1235544585a.56.1763941548019;
        Sun, 23 Nov 2025 15:45:48 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932db59sm843706585a.1.2025.11.23.15.45.46
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:45:47 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][scarthgap][PATCH 29/32] suricata: fix "interface" arg in systemd service
Date: Sun, 23 Nov 2025 18:45:09 -0500
Message-ID: <6fd611cce084924da3574d70fbb139e15bac55de.1763938436.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763938436.git.scott.murray@konsulko.com>
References: <cover.1763938436.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 23:45:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2687

From: Clayton Casciato <majortomtosourcecontrol@gmail.com>

Fix service startup

https://docs.suricata.io/en/suricata-7.0.0/command-line-options.html#cmdoption-i

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
(cherry picked from commit ca34a66f82caa95b6469f2dee5be6c26bbe2cecc)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-ids/suricata/files/suricata.service | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-ids/suricata/files/suricata.service b/recipes-ids/suricata/files/suricata.service
index a99a76e..bd7010d 100644
--- a/recipes-ids/suricata/files/suricata.service
+++ b/recipes-ids/suricata/files/suricata.service
@@ -9,7 +9,7 @@ Documentation=https://redmine.openinfosecfoundation.org/projects/suricata/wiki
 Type=simple
 CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_RAW
 RestrictAddressFamilies=
-ExecStart=/usr/bin/suricata -c /etc/suricata/suricata.yaml eth0
+ExecStart=/usr/bin/suricata -c /etc/suricata/suricata.yaml -i eth0
 ExecReload=/bin/kill -HUP $MAINPID
 PrivateTmp=yes
 ProtectHome=yes
-- 
2.47.3


