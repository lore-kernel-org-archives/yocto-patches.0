Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8E8C52D7C
	for <webhook@archiver.kernel.org>; Sun, 18 Aug 2024 22:10:12 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web11.198143.1724019004558195169
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 18 Aug 2024 15:10:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=SaQEKser;
 spf=pass (domain: konsulko.com, ip: 209.85.210.178, mailfrom: tim.orling@konsulko.com)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7106cf5771bso2964438b3a.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 18 Aug 2024 15:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724019003; x=1724623803; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oyv5WXfYxil6uIwVZY0wqmILOLxBb1ewp/2W4vj9RlQ=;
        b=SaQEKserkPw+5N3N9kXExhlujbse+h+JlimxRYttV8fYW0Xx76LdgUQ7JXhUtwNnRy
         FYHu19aPwi53YoIxtq+FXWYWtyZmEllTET4NK4pBIMELg4wNO9IhbKITrPS+37anogjY
         wI2EqB2/yYG4mf1LE6KYlOT9XI7fVhTJlOio0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724019003; x=1724623803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oyv5WXfYxil6uIwVZY0wqmILOLxBb1ewp/2W4vj9RlQ=;
        b=gDlnz1uz/gAccLMi2ZsqQ6pTD6xxBcJHXcwUKFZ7S15dyB0AAB55woV0tLqkhf0KmW
         kg4w7nFaccS6kyLqQlBnX1HKwGR9NxyEI8Jr6HqJnmuEj8kSeSQ9weR/UlOhPNmZ42gc
         jVfROL6tMJa4wV0aC9DeezQfKyhn8Fdo0aN8m1oaXb/SsLa41UhZ2VPopKLgiSdloZ+C
         7lVQwUv6oRi1i/rfrMcJJtr1bbYa4Ziv3p0JZfdoPWmpVcPG4EcWEcMqCNqGBjhb5tDt
         fUCzKMTo84dT9Jj9sLkdX+sDJsziGT66lxO1aIz7gTurY+/Nc1483PuTSKWZYgfyTf3B
         ASFA==
X-Gm-Message-State: AOJu0Yx6HgVK3x/wWqFiDdlgN9GzM1gbzUTTF+CeyMMGLsV43jd6e8Pz
	IKy/lb6bStgB1nhyHWtt8gevdUadowOQh67AAHNz+0EDjtOZ53QteMid0ToMO7k6CPd6yMP2Y1z
	o0ek=
X-Google-Smtp-Source: AGHT+IEmW0P9BAjhl7Kt/+1MjQnEHT+oFcDLAbc9C148E5rxWwAlzzcHELTIqKg48Gie3EJrLIW9GA==
X-Received: by 2002:a05:6a00:6f04:b0:706:3580:ac4c with SMTP id d2e1a72fcca58-713c4e70ddbmr7582961b3a.17.1724019003355;
        Sun, 18 Aug 2024 15:10:03 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b63712adsm6404999a12.94.2024.08.18.15.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 15:10:02 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH] layerindex/views.py: tweak from_email
Date: Sun, 18 Aug 2024 15:09:19 -0700
Message-ID: <20240818220918.2372304-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Aug 2024 22:10:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/519

From: Tim Orling <tim.orling@konsulko.com>

In production, we use settings.DEFAULT_FROM_EMAIL as our primary source
of from_email, rather than settings.SUBMIT_EMAIL_FROM

Default to DEFAULT_FROM_EMAIL if it is not Null, fall back to SUBMIT_EMAIL_FROM

The real consumer (in production) is a Celery task in layerindex/tasks.py

@tasks.task
def send_email(subject, text_content, from_email=settings.DEFAULT_FROM_EMAIL, to_emails=[]):

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 layerindex/views.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/layerindex/views.py b/layerindex/views.py
index c7a1f09..4df2a09 100644
--- a/layerindex/views.py
+++ b/layerindex/views.py
@@ -1672,7 +1672,7 @@ def email_test_view(request):
         'help_contact': _get_help_contact(),
     }
     subject = '%s: test email' % site_name
-    from_email = settings.SUBMIT_EMAIL_FROM
+    from_email = settings.DEFAULT_FROM_EMAIL if settings.DEFAULT_FROM_EMAIL else settings.SUBMIT_EMAIL_FROM
     to_email = request.user.email
     text_content = plaintext.render(d)
     tasks.send_email.apply_async((subject, text_content, from_email, [to_email]))
-- 
2.46.0


