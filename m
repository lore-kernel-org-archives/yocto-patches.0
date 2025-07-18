Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7F5C83F3B
	for <webhook@archiver.kernel.org>; Fri, 18 Jul 2025 14:11:13 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.web10.21830.1752847873031736043
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 18 Jul 2025 07:11:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Z73jBILJ;
 spf=pass (domain: konsulko.com, ip: 209.85.222.182, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7e182e4171bso222365385a.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 18 Jul 2025 07:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1752847872; x=1753452672; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9M93dSYHu2d3PKS69ZDBnikVN6EHt2Yubky/6THd+Q=;
        b=Z73jBILJbnywYqXP0d8mUIwRL6mSh36pXl1Llw6O2NyM121Gt/DkY0OILDXvL+7Gky
         bNUZTVEqrW/3vrQrlCeLzUGyeCwuGuzp/6djb7j9v4IXu5rRsh1ai3NK0yb1TtaealfJ
         Ju0TB41OJVHFs+fODi9Bws7ARPYmuhZx/hCPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752847872; x=1753452672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9M93dSYHu2d3PKS69ZDBnikVN6EHt2Yubky/6THd+Q=;
        b=OSIUUhh2KYsX19RWAti8E3OEOdOTTHB+YLGmi6Jk0BOFzmztd+bvAhIalL1MWARlqe
         w/nuY3gZmTZQxo2qaIpCI/xCfF/beFI1U+WWqIC3SkrMeFol2dADjE7aT8Xel/2g9l5K
         EM1KrqyuMC2pBYHiV8rnjP3EwNSMVM66Ksaj1mdJi6fM5i5Zg1WiF5dTK1TX3Zspem5M
         hwiRftw5AeCXcwmwEhbKGhSkzaN1aVEmnjgtg6n4r4LwFb7FiLAhmU53IixJINa7dk2o
         phHhsWXkxm2FQlc1fYCVCltA4P34AxOIIzkD8ST3OHnqd+obmnMy54ncyeqhDjsS6a/s
         WeWw==
X-Gm-Message-State: AOJu0YyU2+LvaZXawmow7JLwFNqyHzbjtiQ6M2AINZW4j9C2uInVi2bB
	e9fLIQy+zBP+FHmxDDsIr6eJkc9iGjex6USMCjBtA4ucsI17kzSKNqOQOENLHBX+0xIwbvM70Cv
	AsYYv
X-Gm-Gg: ASbGncuOvzx4Jf6iYZfzJrL9IWfF1tYaXjYyTwyk9LBnqjE+X2jyx1SKIZj7YEyIGsp
	88YZAwIOdBqJl4aNDRBRBjX4JDUy5ACuECPY0LVXBNnqU3FQhvgiVff/laqZ4opLu+OHrfyuhEN
	jXmEz8KQsQkGjq4Gv//it2LQcHYMSnJHpkAxqtHA/6tFR3qs5KxOh5qkRx9EBF/4uz5aR1b3tfT
	svqYgrBpDXQUEsHCDJ8FaOOq32K1PjjmUdopQtpJUVzLPAgFsms7xo7o5olH2RXDFU/QtZKwFwA
	VpxOX53XVgPYaPfIl0N6UfcwpZ86bEsw6xJjzgyC7NsEU88UMewYAhtmQCoB6gDrr3h9nYG+JQo
	XoFlIYEHRTbQcpHYjSdwk1VbBYO7kv4jckykywYr9EplPYXJPearBNxQubeqNzYif7izI3wMSOA
	==
X-Google-Smtp-Source: AGHT+IGXV/3iEWAGaxGdVO1jR7VEX1y6ZbErXG76YW+AYtYwf1z0XEwX3ObhzMxwxfOMEf3jU4z/ag==
X-Received: by 2002:a05:6214:5681:b0:704:949e:9514 with SMTP id 6a1803df08f44-704f6a907d8mr184183566d6.19.1752847871637;
        Fri, 18 Jul 2025 07:11:11 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356a0732dsm92368785a.0.2025.07.18.07.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 07:11:11 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: marta.rybczynska@ygreky.com
Subject: [meta-security][PATCH 3/4] suricata: fix "interface" arg in systemd service
Date: Fri, 18 Jul 2025 10:10:58 -0400
Message-ID: <ca34a66f82caa95b6469f2dee5be6c26bbe2cecc.1752846514.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752846514.git.scott.murray@konsulko.com>
References: <cover.1752846514.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 18 Jul 2025 14:11:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1814

From: Clayton Casciato <majortomtosourcecontrol@gmail.com>

Fix service startup

https://docs.suricata.io/en/suricata-7.0.0/command-line-options.html#cmdoption-i

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
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
2.50.0


