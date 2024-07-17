Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0972C3DA60
	for <webhook@archiver.kernel.org>; Wed, 17 Jul 2024 18:23:30 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.341.1721240605206625412
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 17 Jul 2024 11:23:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IaUD9ezY;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-36796d2e5a9so869f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jul 2024 11:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721240603; x=1721845403; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ItygzvNfk2AznhdN31ej/4DpV5T/EXj+kv6Raj3Ycc=;
        b=IaUD9ezYoxq5CxWElQzfDGp5eIWwf8tXi9seplycPyNE5rzOsZ+I8Mg/L68LTam2yw
         126zLZDtNycG+oxZBxX8gZYY88ezhkCfnFSLRjo4N4G0ALSuNejr4vsmsfTaIMQHiCFr
         2xq27csKAgiZuqhrTokFQzU76rk6K/MoHZWsH2TOsgVCtDzXYUUOWPG8mkhd0VVA2Tg7
         M/zP2JnUF3WXQCERgJg/qg4NVaJHzNquXKbQ3qWXOy1/WxDNr+oeItpADlGpwglY9JBC
         1mX1YZUlzyCSpkE57b+uBU+Ou28FLJOlvdWjO8Kt5hdtiDjNXZe/BOeODW5WRVMmK0p2
         pF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721240603; x=1721845403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ItygzvNfk2AznhdN31ej/4DpV5T/EXj+kv6Raj3Ycc=;
        b=BxQHlXBej+w0c89Vha/uaFWWswJWyUiP+h+5oknQI9Jh6R0AWy7IVDlVlRyowwfHO5
         dNt9aomRik6TdypG33nQSEnUQDTl545ZNGP7t63onhwaNTPjOSbaUisOAU+AzkFmhesg
         0Vw3cJCnDQSPkrDTByFFwcLNJwojfEicZpH3kSzlWMJjGSB75qb+lJ59r5QNUEhqTrBH
         VzPLsxBKrZJSF4bP11/JPtlbsV0mKCxBMIvcD626NkoRRuzLa6vzMUARNkW5qTWQjfiB
         dMX+1f0oPVIF8S0oFziobliRCqUJFnLzoa9uH4WL+bGC29h+Nyq2oU7iV6qQqiVhLcMl
         mmqQ==
X-Gm-Message-State: AOJu0YyAkvqPtplVwDWDEnmGDOR1pqLBKWf4gldlE3RLad2vA/QjSs7U
	KRuh0NVnc3dPaaJ390P9WoGOHlWRdWfyqlNOOA4kvajY8F/wreaH3GsyYg==
X-Google-Smtp-Source: AGHT+IEYGg6IJq+Q0dzfy8JYVQBWfHI01YPCwMsTwYxQhey76h7Tz1iKbuWYdCfNUDw2xnPRoCXWYw==
X-Received: by 2002:a5d:58cf:0:b0:367:918e:a106 with SMTP id ffacd0b85a97d-368317463b0mr1717317f8f.59.1721240603677;
        Wed, 17 Jul 2024 11:23:23 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c7799f2asm7157925e9.1.2024.07.17.11.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 11:23:23 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
X-Google-Original-From: Alexander Kanavin <alex@linutronix.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [auh][PATCH 2/2] README: use yocto-patches list for contributions
Date: Wed, 17 Jul 2024 20:23:19 +0200
Message-Id: <20240717182319.1661071-2-alex@linutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717182319.1661071-1-alex@linutronix.de>
References: <20240717182319.1661071-1-alex@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jul 2024 18:23:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/439

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README b/README
index ed34140..3d0c3fa 100644
--- a/README
+++ b/README
@@ -110,7 +110,7 @@ The latest version of the code can always be found here:
   http://git.yoctoproject.org/cgit/cgit.cgi/auto-upgrade-helper/
 
 Contributions are welcome. Please send patches / pull requests to
-yocto@lists.yoctoproject.org with '[auh]' in the subject also CC the
+yocto-patches@lists.yoctoproject.org with '[auh]' in the subject also CC the
 current maintainer: Alex Kanavin <alex.kanavin@gmail.com>.
 
 License
-- 
2.39.2


