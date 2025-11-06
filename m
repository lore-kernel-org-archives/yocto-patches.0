Return-Path: <mhalstead@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AE1CCFA18
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 21:58:22 +0000 (UTC)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9736.1762466293486826709
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 06 Nov 2025 13:58:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=L+VnOYn0;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.215.181, mailfrom: mhalstead@linuxfoundation.org)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b98a619f020so91874a12.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 06 Nov 2025 13:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762466292; x=1763071092; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7i4cMX9hy6iql7VuzCcfk0Hk+BWMs20yST/BN4IECAY=;
        b=L+VnOYn0qNoWHmRJ3NRzEoLZtSHghs1dbnwXiErkGXRmlQHhHYM+iniSDDg2LZnVpw
         nzI1beaZzdp83tKM5qRaw5DGfkaVglpoHODOAWjNcNErCjBUUQHa7NCgaPhKKpVnwumH
         zW+1PGFggDjhRxgey2UXkJljZq10pKgereYCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762466292; x=1763071092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7i4cMX9hy6iql7VuzCcfk0Hk+BWMs20yST/BN4IECAY=;
        b=faGEQUyBjaupqW5bY1lV2s2GM2JjUUYAztpN0RM05H9lm4zA/1iSwtaUEZkGgJMlnR
         gRh7AUk8lr7xf/niZRdhYnWyXsUI9K46yiNciZYQBZgp9PWwGBlA6LoGlx6GkQfPvKgi
         nwQPY+Xywbqdpp8E5vBRgUzxtghYvLLwAkkDDGaDKLg9/9qk/XnWIYMGoV/KMYIFCIkf
         C0Q8dPvoafJhl9y303ZlNztQVa9fxEwlCYTTHZyPizcgFY5MwykjSKi5fvkwCsqsdUbX
         cYovNwt2Zyy4MeUfS4wkHLR6MWU2wp4JeboQKvCwsmNEZ5ofQGMHL4PwLMMCrXZfJ2hh
         59uw==
X-Gm-Message-State: AOJu0YxpJ1dAsaq2NKIEgc9kN3cuIfZYQ/un1kqaHcL3pbrlaE6zoGfm
	zCuzp+16RAxkSiy+iYCmy1tQ7nVVgmormtfRBLyn9gAzY7ecmZ+e1M54UDVwY2pF4ugK/roRv/2
	A4AL9
X-Gm-Gg: ASbGnctXbkqQJ4BQSutJ8xdfGD8r6zataZNEFbGgZY3tndvXWs8lYudBbzM60xBpj07
	SFg2+fyz4RY5mSCSbRAp037HkX5ArKhrQ4CgXaJzGCgt+wY7eJ23TkB/NqajtRYH/89klZKM56u
	6656onTyVK2D8LTpAvWnGI8styqFLgBHDlpFEOoVELcWbmK85EdKjdXhV1kAWagYCFTDWtb5KUa
	3NuLtM8sp72CN/gRnQhsCmOwCmH5wwumFwNyD0psLVlH1AY42cgVeYoV0IkK4uuJSnVPcTKD4WY
	alI8bxdsez4ql8hp0Qwogk5ta0wew9jTaFwdB4XYjuw9z86fUZKR6a0yVAEE4NbAdZfIO2QYsY8
	yAROicLOJlsxcmzdpYkXPiCU6PRcTVtRbQ2kSflJmjSUXzJDeFnXgYNd5hz0yc+LkV/Don9X8bX
	lPahYVZPPukN6/Ks2EHjqNz1Nhu5hF4Bg/1pdJWHuovL1XQCZ29joSJ/1SBAui9wd05t6u3vNMj
	QnVOQ==
X-Google-Smtp-Source: AGHT+IH9hhQeWRnkZ7Eq0Delt5fGRZPdLLGZej1L10mZBws7TaUK0oGh2/5vnzpn+0ioMdC7WOyuTw==
X-Received: by 2002:a17:903:388b:b0:295:7f1d:b031 with SMTP id d9443c01a7336-297c04714bfmr12831425ad.52.1762466292069;
        Thu, 06 Nov 2025 13:58:12 -0800 (PST)
Received: from yoctolap.taild15c8.ts.net (static-23-234-80-56.cust.tzulo.com. [23.234.80.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ca1b8csm39464035ad.85.2025.11.06.13.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 13:58:11 -0800 (PST)
From: Michael Halstead <mhalstead@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Ryan Day <rday@linuxfoundation.org>
Subject: [PATCH][yocto-autobuilder2] config: add second debian13 worker
Date: Thu,  6 Nov 2025 13:57:59 -0800
Message-ID: <20251106215759.61976-2-mhalstead@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 06 Nov 2025 21:58:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2426

From: Ryan Day <rday@linuxfoundation.org>

Continue upgrading Debian 11 workers.

---
 config.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.py b/config.py
index 82c1200..54331e5 100644
--- a/config.py
+++ b/config.py
@@ -165,7 +165,7 @@ web_port = 8010
 workers_ubuntu = ["ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3", "ubuntu2204-vk-4", "ubuntu2404-vk-1", "ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2504-vk-1", "ubuntu2510-vk-1"]
 workers_centos = ["alma8-vk-1", "alma8-vk-2", "rocky8-vk-1", "alma9-vk-1", "alma9-vk-2", "stream9-vk-1", "rocky9-vk-1", "rocky9-vk-2", "rocky9-vk-3"]
 workers_fedora = ["fedora39-vk-1", "fedora39-vk-2", "fedora40-vk-1", "fedora40-vk-2", "fedora40-vk-3", "fedora40-vk-4", "fedora41-vk-1", "fedora42-vk-1"]
-workers_debian = ["debian11-vk-1", "debian11-vk-2", "debian11-vk-3", "debian12-vk-1", "debian12-vk-2", "debian12-vk-3", "debian12-vk-4", "debian12-vk-5", "debian12-vk-6", "debian12-vk-7", "debian12-vk-8", "debian12-vk-9", "debian13-vk-1"]
+workers_debian = ["debian11-vk-1", "debian11-vk-3", "debian12-vk-1", "debian12-vk-2", "debian12-vk-3", "debian12-vk-4", "debian12-vk-5", "debian12-vk-6", "debian12-vk-7", "debian12-vk-8", "debian12-vk-9", "debian13-vk-1","debian13-vk-2"]
 workers_opensuse = ["opensuse155-vk-1", "opensuse155-vk-2", "opensuse156-vk-1"]
 
 workers = workers_ubuntu + workers_centos + workers_fedora + workers_debian + workers_opensuse
-- 
2.47.3


