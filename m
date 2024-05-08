Return-Path: <ninette@thehoodiefirm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BCFC25B74
	for <webhook@archiver.kernel.org>; Wed,  8 May 2024 15:31:43 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
 by mx.groups.io with SMTP id smtpd.web11.15790.1715182296260206922
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 08 May 2024 08:31:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thehoodiefirm-com.20230601.gappssmtp.com header.s=20230601 header.b=Z1/0SSNr;
 spf=neutral (domain: thehoodiefirm.com, ip: 209.85.218.48, mailfrom: ninette@thehoodiefirm.com)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a4702457ccbso1203456066b.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 08:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1715182295; x=1715787095; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kiukrrle2t1gdH3tonyv8YGokeziqsLQSONLhh34B9I=;
        b=Z1/0SSNraek436fFOzz0S6oiMrAghXtBe3q1LfeAOrArjspqCLaT3Ffm7VfOpPVWIV
         m5G4c9yOkHS92kz8ECW7POa/u8/3Ji528qI8hTqLqNm2jVoMKagRjYJM+RqaXH4TonPN
         Tn5hjAyYBMvK/0DNQdJ2Dt0L/KEu77I6z155P3/tQCm49lsQJz+YjSQHCQSPIRWGM2Oy
         4s9vVtVr5FNdpNLBN82y5g9XrFRmgSmas3a/cxGLQFgSGuBuMNr8qmGupSnmXJLcJ+sY
         ZOSHUPwn0ybuamY9Vbi+//sspv2pGuFOqagCUteTN46XeZg7PYLUXSJyvnoDyY1VRbqw
         7f1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715182295; x=1715787095;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kiukrrle2t1gdH3tonyv8YGokeziqsLQSONLhh34B9I=;
        b=FKcxdE4AQn5KyGlYp4lnCQOgrNZ3adVOKAYYu3fLERgpnMTsxAxu4Yk8darO+YZ5mk
         XUnAK4t+MgQF9kHid3kzG2aeqeyEuX2wena4giYN9ZGadYbtcjc++Ejt9DIybpgcLkPD
         qzAj+UNRQdsiFo6v4vuQSbFFCGj2J2evEVlPg8qModOQusOvjSxQuvdG4xOPV5kac6tZ
         m9U//gwsbA3pjwTg0ph53fIB34yihh9aY8iehigkG9HyfJywUfIVagH+WSvcOC4v7B0y
         L6o2bAvTGbaBcAdvXuSWNy6tEMUB9T/FoDfzT8RM5hcUBay56k6QavauDl6P0HKr9wdi
         /rKg==
X-Gm-Message-State: AOJu0YynoaJADD2Z+py3pFHf0ulDIITwqvZppD0Hjg/lDXJLqzOXNgIe
	cRzZpzK0mESLLoq3oPDXCpn4xVnodGNKcCXFpjva7T0XslmpD7/edqGDfa2Ziax36nh91Cy9Rgc
	r
X-Google-Smtp-Source: AGHT+IGqkvtE6mTbtLdanEIG5EhVi6hActhh/AedFRfhoNVEn5rNwsKRaB6YrF90M+P+ZCfSK4kMwA==
X-Received: by 2002:a17:906:794a:b0:a59:ca33:683f with SMTP id a640c23a62f3a-a59fb94db6amr203103066b.28.1715182294712;
        Wed, 08 May 2024 08:31:34 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aeba4.dynamic.kabel-deutschland.de. [95.90.235.164])
        by smtp.gmail.com with ESMTPSA id c17-20020a1709060fd100b00a526a992d82sm7784897ejk.4.2024.05.08.08.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 08:31:34 -0700 (PDT)
From: Ninette Adhikari <ninette@thehoodiefirm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie,
	Alex Feyerke <hello@alexfeyerke.com>
Subject: [PATCH 01/12] patch-status: add .gitignore file
Date: Wed,  8 May 2024 17:31:16 +0200
Message-ID: <20240508153131.94270-2-ninette@thehoodiefirm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240508153131.94270-1-ninette@thehoodiefirm.com>
References: <20240508153131.94270-1-ninette@thehoodiefirm.com>
Reply-To: engineering@neighbourhood.ie
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 15:31:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/92

From: Alex Feyerke <hello@alexfeyerke.com>

Don't commit generated files used for local development.

Signed-off-by: Alex Feyerke <hello@alexfeyerke.com>
---
 .gitignore | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 .gitignore

diff --git a/.gitignore b/.gitignore
new file mode 100644
index 00000000..314548a8
--- /dev/null
+++ b/.gitignore
@@ -0,0 +1,4 @@
+# ignore generated data files
+patch-status/cve-count-byday.json
+patch-status/cve-status-*.txt
+patch-status/patch-status-*.json
\ No newline at end of file
-- 
2.39.3 (Apple Git-145)


