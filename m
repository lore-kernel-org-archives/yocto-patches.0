Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2634CC3DA49
	for <webhook@archiver.kernel.org>; Wed, 17 Jul 2024 01:06:01 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web10.5281.1721178351371714374
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 16 Jul 2024 18:05:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=oMwCvdzu;
 spf=pass (domain: konsulko.com, ip: 209.85.210.172, mailfrom: tim.orling@konsulko.com)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70b1207bc22so5241386b3a.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 16 Jul 2024 18:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1721178350; x=1721783150; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LlQFEXhOtLr7+q8MEVNRwJ0PLkSdE9C0+Qp0wpfWwA4=;
        b=oMwCvdzuFlskmpETg0TJplz7/MRT5M9/0k5QK+32HrcAXw1HaAsBGc4ppmbDmNNHqJ
         UAPTADqMpYt4gt60sDz1tk6oDHmylUiPcN+I0BVfHwei8czQho8FvthTs84+PTx0+upb
         F0j/VhJD7s4nohr/yGHQuxdmIMsGZ5KaeaETE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721178350; x=1721783150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LlQFEXhOtLr7+q8MEVNRwJ0PLkSdE9C0+Qp0wpfWwA4=;
        b=i5KGdRS1wKRAYb8UJ1uMm3b1012TC0iNvp5NcbbLXQDa2aoVmlPXy202XdyjkrJhhf
         zeauXiqYtLIYwMpCmX4ZHH1AoHXwrmZelypp87cnzc3x3j3M28iEADqYitwfAtKyQ2OR
         xhSVMuvvMiAnib/qcfP697gTbdXs4mzt/LDSlkzBuAsSmDl26A/cJy2XsTMcgvlThMgs
         hmgbtdt0GEK60UI2c7fpt86Q276WFWirwXXOLZd6sm13+p2ZXPfY63mWt4EVqRSThtpB
         asFqKbegoMnszfUhgQMV0r9Ay2hCKBU6FRVviAle7e0at/eF2piW8/bU7I/Asa86qL5A
         fEFQ==
X-Gm-Message-State: AOJu0YwH8f8KyrFKnUuhU6tJm/VlRjwJtdt6BtPB+KrFm0r/gYD41moh
	xzEALrYs7r6/vfy6b8XdXthBGpbyZrVGBk68UJ/2EGQitoREr6wx1Kksl8hHzLiFDtVikEW3jth
	be5c=
X-Google-Smtp-Source: AGHT+IHD1Oqi5G1ikzjwO/QoRhhnH2kuazNBQ1aQ/IDLdAEBKJh2maihs+KSznInMvPSOqRFL5Hm1Q==
X-Received: by 2002:a05:6a21:9a01:b0:1bd:27fd:ff56 with SMTP id adf61e73a8af0-1c3fddfc8a7mr241095637.58.1721178349641;
        Tue, 16 Jul 2024 18:05:49 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb6ffdesm66709255ad.53.2024.07.16.18.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 18:05:49 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Cc: "dependabot [bot]" <support@github.com>,
	Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 1/2] build(deps): bump djangorestframework from 3.15.1 to 3.15.2
Date: Tue, 16 Jul 2024 18:05:06 -0700
Message-ID: <20240717010514.3386182-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jul 2024 01:06:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/433

From: "dependabot[bot]" <49699333+dependabot[bot]@users.noreply.github.com>

Bumps [djangorestframework](https://github.com/encode/django-rest-framework) from 3.15.1 to 3.15.2.
- [Release notes](https://github.com/encode/django-rest-framework/releases)
- [Commits](https://github.com/encode/django-rest-framework/compare/3.15.1...3.15.2)

---
updated-dependencies:
- dependency-name: djangorestframework
  dependency-type: direct:production
...

Signed-off-by: dependabot[bot] <support@github.com>
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/requirements.txt b/requirements.txt
index 8ab5e56..e4610e5 100644
--- a/requirements.txt
+++ b/requirements.txt
@@ -19,7 +19,7 @@ django-registration==3.4
 django-reversion==5.0.12
 django-reversion-compare==0.17.0
 django-simple-captcha==0.6.0
-djangorestframework==3.15.1
+djangorestframework==3.15.2
 gitdb==4.0.11
 GitPython==3.1.43
 kombu==5.3.7
-- 
2.45.2


