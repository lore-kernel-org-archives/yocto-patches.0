Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF56C02196
	for <webhook@archiver.kernel.org>; Thu,  6 Feb 2025 14:29:35 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.web11.42575.1738852170543481745
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 06 Feb 2025 06:29:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IBIucLfG;
 spf=pass (domain: gmail.com, ip: 209.85.208.43, mailfrom: martin.jansa@gmail.com)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dcd8d6f130so2000452a12.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 06 Feb 2025 06:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738852169; x=1739456969; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJJDBg3gVxo/aK+WaqOb/4Nx5GPpVic/6bYWeXYjb7s=;
        b=IBIucLfGUUJ42PVKqgK+TcdVdbX6ClTbaSzJFcGZxWpne4uPCns/6VK91XyhVyQ0+6
         BAtxDd8Yqiz0U2u2YBA4wBbBdHVz4i8+I9JUMkwYF3OW7Ygxybwv1vQWV5f1dgBl/GxQ
         DTl0QktrMoasG5Ms4dYqKLHjBpZt0pgpXmJDnqetrdOvkLLrE8vqK4wCjmbQIgWPHpOm
         jovGVz+HO4Z5GQ2M+v+nJmmRkUgachM3ple+sgOMqXGvPUOLICVoWOdbs5x7cJL2rQcY
         YHoper61XPgmZ3irQIhKqKgI4JpnN+WRA1P6vBk3sVKNnu4zrQWQ9+1rwcIwh83MGNoD
         xNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738852169; x=1739456969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJJDBg3gVxo/aK+WaqOb/4Nx5GPpVic/6bYWeXYjb7s=;
        b=Ft+XeMRhhwvkMGxPdcM59l+e7BScCzrlxWrM/82Q6FW6jmjAdY2+YS0DXwWSMoI/87
         oCBOWtu++CXr3F4dTa7MjII5fjeewqobaUwm93u1K71OS6SZe3/KAYkOJpAHcumxMBO7
         Srk2G6hRrBTFVESfqxN1gTuUjgSmQBuf7JZuReZixhkL+6bW1sCc2d7NJsPM5VOtxOzo
         ff5mN2Q0qk1rldrlhsTmMd41zTYF+F53LrxXOeSlKOPmDYs6Xynvaodt2rcPOok3RHCc
         iNS4l5rS5FeoUN5qIQWnAtJ0goRyg/sXKUL5XZi+NmntOL6UdEknML/58YrJWZmBQ1ul
         aM5Q==
X-Gm-Message-State: AOJu0YxEaT3onNb7UG19EPcIl/nj0DX1kDEBIgyntvNs2pdgw3qkZ9Av
	n7o6yV8Vfa87eqD8VtKcp1TTf89/yoCtFkFfwUnR0wxXhXHsQUxsALu2Ng==
X-Gm-Gg: ASbGncvSKUaUoVB1AParzOLVxF9lfqoP6V/QEkNSryivspWC2qOnJMbeOYh7SV26CbJ
	BLZm45EvXx7m3FF3Rwd5Rs3lwvPoKj3SNDdTkXdcLx5goCQxysec6ffpG+TJlu73de8ikZw4s8t
	XdEZl5HWTyd76iz6gx5Yvv+FZnn8V8u/0Jhk9YzIl3ZKcqZNRA8UjRVW3Kiad6rPkq18QSZ9HXF
	mmcAUjIJgS4BoQvcQTZfjyISLQZS4qRcnhXjGV7RJGacdZeNQf2VUSdk8JRbJWluK+E4NFSMA5t
	PCN037xBxJcWcmc5TQ==
X-Google-Smtp-Source: AGHT+IFDsEyqoYY55kSv6AkPfzBVMcxI+JIX21jBmD7dNwZYiZlFBlGlXy5Jrlzw4cDDr8wNLmykaw==
X-Received: by 2002:a05:6402:51ce:b0:5dc:d8f2:3780 with SMTP id 4fb4d7f45d1cf-5dcdb778180mr7212160a12.24.1738852168772;
        Thu, 06 Feb 2025 06:29:28 -0800 (PST)
Received: from localhost ([109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5dcf1b742acsm932265a12.2.2025.02.06.06.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 06:29:28 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-tensorflow][mickledore][PATCH 3/3] MAINTAINERS.md: fix e-mail address
Date: Thu,  6 Feb 2025 15:29:20 +0100
Message-ID: <20250206142920.17790-3-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206142920.17790-1-martin.jansa@gmail.com>
References: <20250206142920.17790-1-martin.jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 06 Feb 2025 14:29:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1044

yocto@yoctoproject.org doesn't exist and yocto-patches is probably better than
yocto@lists.yoctoproject.org

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 MAINTAINERS.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS.md b/MAINTAINERS.md
index 09a0cef..e049457 100644
--- a/MAINTAINERS.md
+++ b/MAINTAINERS.md
@@ -20,7 +20,7 @@ When sending patches please take a look at the contribution guide available
 here: https://wiki.yoctoproject.org/wiki/Contribution_Guidelines
 
 example:
-git send-email -1 -M --to yocto@yoctoproject.org  --subject-prefix=meta-tensorflow][PATCH
+git send-email -1 -M --to yocto-patches@lists.yoctoproject.org  --subject-prefix=meta-tensorflow][PATCH
 ```
 
 ### 2. Github
-- 
2.48.1


