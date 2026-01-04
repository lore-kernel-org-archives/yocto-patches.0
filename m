Return-Path: <t.f.g.geelen@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DB0C2A065
	for <webhook@archiver.kernel.org>; Sun,  4 Jan 2026 00:47:59 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35361.1767487673327006990
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 03 Jan 2026 16:47:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fRto67KY;
 spf=pass (domain: gmail.com, ip: 209.85.208.54, mailfrom: t.f.g.geelen@gmail.com)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64baaa754c6so14585341a12.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 03 Jan 2026 16:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767487671; x=1768092471; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UMwOOcTi1gj+bzu0d3zD/WLvzIgwm0QQ3WbkoDDZe6I=;
        b=fRto67KY21fK8MOWOBAlurZEQ2qDRb86d4WSlJZwR+l42Z/MT7sC6GtFrLiMzuMJ/n
         v9qircNNezfZq0NrG+z6fZEUmR81dtw0TGxPsSFhXLzoQINjO0hZg0a1PgEtGBsd1rBa
         cCFCPUOZxEVl6QDn+x4VWvzfVQ0fBfjjOL40oFaiAtD/K0CDUmi5URIC7JI4bToX83yM
         6mxRyiwkyLcIBfZXaSfCgFHSJBoqcC1M2Gljt/KBBjJkfwuhUtoLoQGu4K9fkBQLOBZS
         pt7uq3hX5PBv/21EsgEOImJCItbdA5nChXPsB6X5lgKxVWJfPFRy0UbpEYnAFg5JMVMu
         MWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767487671; x=1768092471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMwOOcTi1gj+bzu0d3zD/WLvzIgwm0QQ3WbkoDDZe6I=;
        b=Or6ZPJj+mDhYSiw9PiFEekMv+r5co3uq7c9YGMHDYL0ogcGvwObEKbwCtnk98aRK7U
         JDzZW4G+aN7SDGOIQ1RJb7jucUlWum7zS+XHJzxow/kwI7qUGo7qHhhXZTKpGBPq4fHk
         m0WnTA2eLKpGHXXxDnGIRYMx8LJVsV9VcQY170yX0JdCwdZLdV1ZdIHHayLxBX1ne/8S
         BXc36A36g0XhNK9DahbZocVHKCDWe95ElPnjKzLnvllu6SYEd4UQBMR1Yod8HovE1U2H
         E0WmLpbJDg1N2yd6xBtcidQGuNQmuw1DhgKn4MVeDuXlcRwHSZ/6pv3klDdoGpRz357a
         65Vg==
X-Gm-Message-State: AOJu0YwxnYXBq/2hjNqFVM3Ew7mnNFnv8G9IJqZDH7l2H476sJ0aOjV6
	UeE7frSPLBJWfzfWbrn+R3lrhwcvfNhduWgu2HAcAMTZq/r2WFu76GeTKmzS7cQP
X-Gm-Gg: AY/fxX5qJfuYkIwFyXOnpZcAPnhPjpAy28G1j9BMpAstYssDPXS1dATDKN1GEJVz9Gv
	4DDkAe+hRyZTYReNgXepeoOpPSosjn8AGlRl9SmIZ6Lr9TifrYns+fEX6bD8rVcZNYlEn3V+KK9
	xvxj4XkMbb4I5QJDxrde+PBrmWj/VOKbs5tzgl/ih+Xqg7p43dVOhOsI7LRuqvB6lBWIIEWHsgv
	L7MpNuMbWC9FvD613BynKmzHRzV9xIwd5L2RGHa8JrP9Bj9aVgRop4AVmnWHHmA0jlzMIcFs+c+
	E+a2bFNA2ym3eD5mNPXGCPXLkWHBp/LiGaNZFzQw1d49FflGsRTaquyWM45og5tE87BXgMVInhO
	TtbeGWQTQC4JJuwMcC+yRrNuy1MnNPdCstohvpcPooD8BUigcLBRg/vAOUdBw5MnRVn4PRVJoYQ
	Tdx43LICNREhNSmFFzzV6I2++2mZOaswf6jDIKoc/o5uHjyQu1cXANEnf2hvmzqYan
X-Google-Smtp-Source: AGHT+IEGv2ObHzAv7xSv/d1ERGcoYnGt1iPR6pMdQfvwDXYvYj3oYotMb4FY9YDfKoCSl3ufVTXeuA==
X-Received: by 2002:a17:906:9fd2:b0:b73:42df:27a with SMTP id a640c23a62f3a-b8036f2fa8fmr4264786366b.1.1767487670800;
        Sat, 03 Jan 2026 16:47:50 -0800 (PST)
Received: from control-center.fritz.box (150-12-20-31.ftth.glasoperator.nl. [31.20.12.150])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037a5bdfesm5104839066b.10.2026.01.03.16.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 16:47:50 -0800 (PST)
From: Tom Geelen <t.f.g.geelen@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Alex Kanavin <alex.kanavin@gmail.com>,
	Tom Geelen <t.f.g.geelen@gmail.com>
Subject: [auh][PATCH 1/5] README: fix version numbering.
Date: Sun,  4 Jan 2026 01:46:57 +0100
Message-ID: <20260104004708.2494403-2-t.f.g.geelen@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 04 Jan 2026 00:47:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2889

The README had incorrect step numbering.

---
 README | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 3d0c3fa..f94c733 100644
--- a/README
+++ b/README
@@ -38,7 +38,7 @@ WARNING: if you are using the default maintainers.inc file supplied
          emails to the default maintainers. Please be careful not to
          do this :)
 
-4. If you want to enable buildhistory (optional) you need to enable it in
+3. If you want to enable buildhistory (optional) you need to enable it in
 upgrade-helper.conf, and also add the following lines to your conf/local.conf
 file:
 
@@ -52,7 +52,7 @@ $BUILDDIR/upgrade-helper/work/recipe/buildhistory-diff.txt.
 
 (Do not remove any other inherited class in the process).
 
-5. If you want to enable testimage (optional) you need to enable in
+4. If you want to enable testimage (optional) you need to enable in
 upgrade-helper.conf also add the following lines to your conf/local.conf
 file:
 
-- 
2.43.0


