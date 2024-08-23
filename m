Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8074CC52D7C
	for <webhook@archiver.kernel.org>; Fri, 23 Aug 2024 11:44:32 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.web10.14145.1724413465951700578
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 23 Aug 2024 04:44:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ldmQoh/g;
 spf=pass (domain: gmail.com, ip: 209.85.218.46, mailfrom: martin.jansa@gmail.com)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a868b739cd9so236119466b.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 23 Aug 2024 04:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724413464; x=1725018264; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JCTARa4fvfZQUWxxf7bpwovA+4pjMQzKoNuMdZ71Hdw=;
        b=ldmQoh/gyx5zLSpuTc2C1xKY9QGf4f4876wBsqzwyr2NVtR2iKm6mx7a7Vw6EiCIo+
         eUSOD2YgUxXaSxkxSKdrKau71JGcyXfUDs2uVQ0LIZhXjUZ1QEb035CZFvpArrtL8rbJ
         LpAW9UV14ZB0F2jgrWEvz0OkMAXd4sPo7ITC41KSid0w2qezgdrHvcO6A58bYuzhMIS5
         E0NDbeyXUJjWxnSwGhPz+lcAOYgo/T9K58lzDfWgMEAYtYmzdwmzDv9TxFJ1L5zABeoa
         z630x03F6/6LkGVXyR1sbmgL1/TuiWiabO6trM7qF8QEaREMGjv02ydNB36L5MryfxRR
         psrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724413464; x=1725018264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JCTARa4fvfZQUWxxf7bpwovA+4pjMQzKoNuMdZ71Hdw=;
        b=EqdJOfZLQir0bq7f0wEUyhRT68YBBmDIn/9kCZBpBsWccSGkdC7uNv0bl2PRb+P49M
         HCEhocEIikAt/fZrso6nvedrYW1XpQahQpkZ+BjYOMdrr9OUKCgdCJM5DxsxSpSFnVMk
         kpoVa9H5Sn+TzZucKBt3cdD8CNYu+kFUtvIxAjc4RN7WcLYKO3s7vRQimG7oXVjv9Y/m
         ouLzpj6Sw0YseD6yenbfZ9iSw+9LWupIJGD9rSwX7KyEQGybIIL4iKOcadoQ0ckDDxVm
         GXFIsr0gF5SgFHhdepRPScbqCXwakAym2MqnhiWgShZDQhiG6h3zQXwgE9xmlo14Zqqr
         HIYA==
X-Gm-Message-State: AOJu0YzffZksEIJoSFvqg8+74YdgjMNDPV337G+FD4xfbXBYmUIN+D6x
	HhGrfz0RhV4/74gC8oER7to6+XmypuEcQf8BgEXA148lB0T6NrlubsTsgQ==
X-Google-Smtp-Source: AGHT+IGXZCW8H1+ulukTRsr6q4hQHamjQge4WKjQoeiwzQk7sZx/61Uw/+oQuXGVjukgoHGSEDqMPA==
X-Received: by 2002:a17:907:c1e:b0:a86:93fe:7a94 with SMTP id a640c23a62f3a-a86a54a966emr156526466b.47.1724413463237;
        Fri, 23 Aug 2024 04:44:23 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f436330sm249581666b.112.2024.08.23.04.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 04:44:22 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com,
	Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-rockchip] [PATCH] mesa: rename bbappend to match new recipe name from oe-core
Date: Fri, 23 Aug 2024 13:44:07 +0200
Message-ID: <20240823114407.787597-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 23 Aug 2024 11:44:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/551

Otherwise it will fail to parse.

Renamed in:
https://git.openembedded.org/openembedded-core/commit/?id=f5cfb3e23603cefb2f3f6bfe776afaedefd10808
---
 recipes-graphics/mesa/{mesa_%.bbappend => mesa.bbappend} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename recipes-graphics/mesa/{mesa_%.bbappend => mesa.bbappend} (100%)

diff --git a/recipes-graphics/mesa/mesa_%.bbappend b/recipes-graphics/mesa/mesa.bbappend
similarity index 100%
rename from recipes-graphics/mesa/mesa_%.bbappend
rename to recipes-graphics/mesa/mesa.bbappend
-- 
2.46.0


