Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347A4F433FE
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 07:07:56 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8019.1776323269183943303
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Apr 2026 00:07:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=q16RQZSO;
 spf=pass (domain: smile.fr, ip: 209.85.221.43, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43cfce3a195so4666372f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Apr 2026 00:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1776323267; x=1776928067; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xSe+ATa0AHe1x374EiD5miXmck34Vlc6JcZ3qZti+vY=;
        b=q16RQZSOVcQsCLjo4H1nzHs+/Mh9OdvielpZN/x01llknbYxujWOU4fpH1rfCjfSKC
         ErMq7ree6SPK+2yykwg5isRWFoNnN/DzeO5SLe/Xo2l3mYTH3rgUuqSpUaTNVU33xZMn
         x7b016xfMzjlp6oGr/IqAR+WsAmzt7IkPFFjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776323267; x=1776928067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xSe+ATa0AHe1x374EiD5miXmck34Vlc6JcZ3qZti+vY=;
        b=Z09QZGMAl5gjB6qQV+d/eCp7oqOFqKOw1naYZ1lz1B/oYUJHWRZ/Swxpz/zuMkXqPM
         Lef8IIqEnVDOhIkLwYf6XHICKPKXUAeraBOPmcEfK7XwJ/5aJ1LMtYghYM+n0fUWRld8
         CmRI+2MqEC2S3lU74HpPDTBpRq1WGHlVLH10ScJeMyYQzSjCUpQuinOOTamQr8P+Izc7
         P/sx6Ue6CARyU+ujEpOU9BB2g1tleW8kHoaVvKtn1p3KRr6aqc8Ftxvzsw44EtV5ucUj
         F+o44AY3tJYgEJ2wAkJaKgYlWQNb71cKGWOOf8N3NUwI5X7v4H09dfkpzNHGOcKkyl0k
         vQqA==
X-Gm-Message-State: AOJu0Yw4ucd9kXl7izlNcM9Sb3/mcq7LceS3LqzCcFzIHQhEvH17lq7d
	loxtHPubkr+dsQLQ0o05laOiMrxxHy+yQ7ZSfP7Z4LgJtJh2wH3cyOLjdVtKg0rPtpJXAIqbwpx
	BxLiAlrH5FQ==
X-Gm-Gg: AeBDiet3L/V3SAvRfrqs8cuLc6ygn+9D1wBQpT+w/gnzR7FHWyqYMl4SG6YzruZz559
	LhX1/HGTupxicidzTTaak3UyZnmuI4G00UogGvLsGWZi0VPDb3gDmM9J9/OgweX8sGZQH3l/lB9
	tBF+5Q5vExDMZjGFG3p9dhYhY1jjSh/EVLbEbGI2w31GBGA4A3LYNLDXbj4KFfDsxedqmgX57gA
	lCaECQyzBjM47hxW2tD6DvYv+w6HeCZTkITh4li/weds4PWPs7to+gTOpzeyjgL85nOgvWodY4H
	gNSaalub5NAOAoxvUdEabHmi4hVoIZENzAZZcwwV61ifnYZoBKoIvqBSlh1M7UMHHU6TitawERn
	m709NIeRb/XZILmBG+GPwn2OwmD8j11H5FXXKWOTq+Rl1IyIPUoxk4N79/LngpoVaSKAtvcKotO
	wOqwaUnI9Rz1CBhbY/2ABHPHZ0gufI9kZ8AZ0TqD4WRbrpCPCAKqD+xy2zbcBkUn87aY7B4Q61W
	+h2ujc9Ce/rU0isRiATO5ZyOzGqgJLBBn11+A==
X-Received: by 2002:a05:6000:26cf:b0:43c:fe59:40da with SMTP id ffacd0b85a97d-43d642bd652mr36708485f8f.47.1776323267137;
        Thu, 16 Apr 2026 00:07:47 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5f06sm11602449f8f.17.2026.04.16.00.07.46
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 00:07:46 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][whinlatter 4/5] scripts/utils: Milestones are now yocto- prefixed
Date: Thu, 16 Apr 2026 09:07:39 +0200
Message-ID: <7fbedceeee77bd81219660a0254a68721beec750.1776323183.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1776323183.git.yoann.congal@smile.fr>
References: <cover.1776323183.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Apr 2026 07:07:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3720

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 1a4d66183644561412603af75ef5e90e54680a24)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 scripts/utils.py | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/scripts/utils.py b/scripts/utils.py
index b472451..88842f0 100644
--- a/scripts/utils.py
+++ b/scripts/utils.py
@@ -524,10 +524,7 @@ def get_string_from_version(version, milestone=None, rc=None):
     return result
 
 def get_tag_from_version(version, milestone):
-    if not milestone:
-        return "yocto-" + get_string_from_version(version, milestone)
-    return get_string_from_version(version, milestone)
-
+    return "yocto-" + get_string_from_version(version, milestone)
 
 def get_version_from_string(raw_version):
     """ Get version as list of int from raw_version.

