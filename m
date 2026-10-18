Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4B0CCF2C9
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 21:42:03 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22119.1792359718518376138
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 18 Oct 2026 14:41:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=WWcz3Mty;
 spf=pass (domain: gmail.com, ip: 209.85.214.182, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e977109392so5847505ad.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 14:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792359718; x=1792964518; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Dnm33/EW1CwdgfXI1cCFr6AsYRPeXktA7UMS/jMkC0=;
        b=WWcz3Mtyp7OK9yoLCVZrPflQeV2nwxz9ET1EMlsQXpBC7zN1AQSqT5WjYA95GlCDQn
         /JZQ1dcLZdAA7968I51HtmCU88+faLd9yIWIaxGIDuI3QqGLZsBeKOd2QIGHC2zEixB+
         Nd6Fg2pKr0bb5L9jawSrMYxOqeb3yZ5pBS5lLqIi6h71vcuDqthrLK4jgoOYlHvYNsIy
         ww9PTwRBNNlzYoWcGwX9hrCsojOqhXGwfJSTGNPU0Nu2CvTpFXk/Ai2lhix5V3mGBezn
         zxDLUFWHgXWQFKSu0DNExjt2uQM9opWpN7WktoDkPq03OiCcA426CAwFmPBFDA+dtgvs
         /5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792359718; x=1792964518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Dnm33/EW1CwdgfXI1cCFr6AsYRPeXktA7UMS/jMkC0=;
        b=VcyRheAsaQmPdBKN2kou4emAmeoLxN95PMs8vDOpNZSwp/D0fA561y4qH9SAwZ5u6g
         H04Yf5Qt7ei50vni54j7lkO0V0KqUtBukEYl9hZJ1vViAI//hgrwihLQ0jpW/UgAkneV
         D2Epqr9iYrjiY3PAHq9NaRVLDX2aOY9gs42mUNkis83Vk4QD5VA3IkNO/pc13Qyx/CaQ
         09bAS6WnSA3vvlNRx4SvNquO2FWMiyW3sEmzAblNP8NOsnYw31wyP1tGvpOZo4Madngl
         3NYEVx+Peh1CJyQF2JWZwBijZoQ7ZrI0S6ASZItUnQ2TbcfWDuUzk1o6ziSI7DeHFzCd
         hkIg==
X-Gm-Message-State: AFq9FYKXZcIZ/kCl1+wHhTZFxdNG/vQVCi7ajxjmmTmHHD+U7B2cZTf+
	olMQaLpmoxhaLFk0EipizFR9SLW6YPeCL0lByif0/Y6LsuDI77Hgq5Xoh9UbJYVP
X-Gm-Gg: AYBFou1irHVvlqQKNaMR4oPMX+lNg6zR2Yk1D79kEFw+k06jP9z93bM5wpKji0flkDY
	1feZGTP4s8JP2J7aZM0LlB0W3Q0qIQLln9aKWSo4Fl4TOID+VYVoqc1kiOcWb0Vl7Z9As4TI47b
	d0lcNlLaLy0MZiHfvoqg7OFACYprPhMC9Qc7Pb6Q04MsYmbnN1gEZ6J6YFYghA3sFTbT7gayc1n
	LKu82NV3Cv7KyGq1v8LLqOH88CxL9BtELCNQShoM1NUUwoaAuofxE5H+MsI1o0u8yJeGYNMoIbI
	CybhKI57dTHkoDGq9MwYF0bT/tMJSuWINKUd2Dgsz3oDYYw4kQUUU1BdDyQcf0+7UVxS0V3g8F7
	tAL8CkFIey6PGirHhDNEz94lXtPBGxQjhY6ACvdWrYQobb6FEaleWXogozB34jFnbghZFeOHFcI
	b0YuGsaOJdbLbbJWGddIRD3Q/s/X9UcqvCiHG4vIz+rmlBUhzdhff4l1h2v68MVvOrw7iLWPwag
	UqV67q0T88ODw671KeD331FeTrMNxZFdv+478BTXA==
X-Received: by 2002:a17:902:f543:b0:2e2:dd98:59e8 with SMTP id d9443c01a7336-2e9a6834bd3mr47578285ad.3.1792359717825;
        Sun, 18 Oct 2026 14:41:57 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e9d3fa9ffdsm9004155ad.58.2026.10.18.14.41.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 14:41:55 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 1/4] docker/settings.py: don't enable DEBUG when DEBUG=0
Date: Sun, 18 Oct 2026 14:41:43 -0700
Message-ID: <20261018214146.67856-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018214146.67856-1-tim.orling@konsulko.com>
References: <20261018214146.67856-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 21:42:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5073

os.getenv() returns a string, and any non-empty string is true, so
DEBUG=0 (or DEBUG=False) turned debug mode on, exposing tracebacks and
settings on error pages. Only enable it for 1, true or yes.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 docker/settings.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docker/settings.py b/docker/settings.py
index 90bc5f4..c33731c 100644
--- a/docker/settings.py
+++ b/docker/settings.py
@@ -7,7 +7,7 @@
 
 import os
 
-DEBUG = os.getenv('DEBUG', False)
+DEBUG = os.getenv('DEBUG', '0').lower() in ('1', 'true', 'yes')
 
 ADMINS = (
     # ('Your Name', 'your_email@example.com'),
-- 
2.56.0


