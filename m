Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA317CCFA13
	for <webhook@archiver.kernel.org>; Sun,  9 Nov 2025 16:23:17 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13028.1762632697084541287
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 08 Nov 2025 12:11:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dR8/PVdN;
 spf=pass (domain: gmail.com, ip: 209.85.221.46, mailfrom: osama.abdelkader@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b2a0c18caso834036f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 12:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762632695; x=1763237495; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VyEXchpZcXqjMLpzovmozQetXAo4os/uZXiinxHc6y0=;
        b=dR8/PVdNmWJNgRxZ5HLuQfWhcUhPmpQsWHTmQ8RsqmjA8au0jXb1J/rj7RWhyRkXB5
         vUlI0gVHCstIElLoRMdaKhNGOa85lkysU3hS9urvmCWP6dR0c3SkeT6n1+4ym9azHcae
         g+mMQfyQpjniKCfuUsZAvw8Xe6uRL7npH29tWb/W9i7d6uESKx0sFgqCx0bCG786qZ23
         hUqcZayifZ9bRaeW19DnikGXxHcwWmAMvXCUsMrVHX8lKkq3XLn1WeBanINVWmqBkVZF
         JkLbcmacgDeF1Cx0EhLfT9nljNh0kxJFQhvpaNm8iKKWDQoRy0v7SAl9YAUr66TvZR+9
         PLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762632695; x=1763237495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyEXchpZcXqjMLpzovmozQetXAo4os/uZXiinxHc6y0=;
        b=I9TQq86LRa7GhidMS1ZUDKvnZ6/g8VlawdPJQcjQYnjbmJvSdYGZCp4r/7eICe+C7C
         yXit/J+NL2u5TCXuSkYVqeRhfWN8Kjd5vQlmGnun2ZxnAKY3LVhTADgUWSLvv2Zlqvyd
         XmVctQVljpNZm5H61zI71sguzogxlOHPFWdXr0BY8vZKI+oKWmfNfEyRS++Q9ixHQ96a
         eWN9nw4EcRp0Q+ZIVi+BEn+MZvn/LoOArb6uVTPd0vz8INiqqVbV5dXsfMX6C6dfHXjv
         Q+WovXllpZDyPX3IIFLEPmQgMOs/B8lhbF4YhhydQD8OfA59sR2nBfQy4lkTzVpsJP5p
         TYAw==
X-Gm-Message-State: AOJu0YzM5rsjji2WgB4K/pASFReysilEc8QGij5FMSCaR8HXXFnDFHpQ
	AcX4HranaeHam38XTCIHKCqAlgp0ZXKXFvmmxhey1QYhdCjV2mAEEm0iUiB9k9o1
X-Gm-Gg: ASbGncunKhknxMPrNzdyL/zY8M1ULVTfYqskVg9KB6EOIzmOo1tFpF9dEyiceMcabNc
	p5SxlXxElEOOPmjo4sHLBgB+dltMc7cDmgMSdi+NCLB5lpf8p7CSODnuwPIaF6NW4FD1PgVDdAi
	gZkCyIWm3kcONfrTyJCBBAfetQX7017JVTv7ZbPS+/PfIHvX0/eYHdhtVk5VESr7gE8tx2ArnKZ
	o5XZZl1kU8zDJF+tOEpzk5IY2EoS28WNyrcOqjBor+O+Nqa6Mf2qfVMg778/xZwHgrmf4CrjE4m
	6T0+U4PNAi8uEPS29OPgrjBN5ZKnO3z7XLVhcxBZH1xKaUV/Z1CJZF7k+DYp4jI7hKFjObPw9xX
	1bkyYfAhjUzb556PJbanXrYTyG0izJs+J6cbjhhMFtGQGYqV9Bh++U846eq7extCPOuzLZI1+Fj
	H46v4q
X-Google-Smtp-Source: AGHT+IF4jT2mJSWhoFKKnTCr1C/F+X4B04xrU120173+iL/a9c6gNn0jG3mAl48T+3oppnE3lkf7wQ==
X-Received: by 2002:a05:6000:2885:b0:426:d820:a3f9 with SMTP id ffacd0b85a97d-42b2db822b0mr2299525f8f.0.1762632694981;
        Sat, 08 Nov 2025 12:11:34 -0800 (PST)
Received: from osama.. ([156.223.140.230])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac675ca86sm13302074f8f.31.2025.11.08.12.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 12:11:34 -0800 (PST)
From: "Osama Abdelkader" <osama.abdelkader@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] poky: fix typo in README
Date: Sat,  8 Nov 2025 22:11:30 +0200
Message-ID: <20251108201131.13079-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 09 Nov 2025 16:23:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2463

ut meant -> it meant

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README b/README
index 84f3937d1f..7cf111ed14 100644
--- a/README
+++ b/README
@@ -50,7 +50,7 @@ developing layers, we made the artificial "poky" repository construct
 as a way to let people easily and quickly get started with the project.
 without cloning and managing multiple repositories. Layers were a new
 idea with lots of rough edges. kas didn't exist, I think repo was only
-just created and it was a different world. For us, ut meant hacking up
+just created and it was a different world. For us, it meant hacking up
 a quick tool, "combo-layer" and it was really a temporary solution to
 fill a gap and it was at least as functional as repo of the era. It was
 assumed we'd work it out properly in the future.
-- 
2.43.0


