Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFE9CCD1A3
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 21:22:44 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.web10.1659.1760649755667362965
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Oct 2025 14:22:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ZNPHcV9T;
 spf=pass (domain: konsulko.com, ip: 209.85.219.50, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-87c11268b97so20479606d6.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 14:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1760649754; x=1761254554; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MS87alHhSABD93QlOP7Xn0TuLltjwUxEwtFmTKYdYms=;
        b=ZNPHcV9TsK5nSlCIqsxzFHQdDIc0vCoocPBxr6S1bnojV92YzGBq4+jMlJ21xR+TCx
         mq4xndrx9TNx1s6YbHyBklZI5IuUooHFvm3Vi4xJmWXRtjZCK/AQU1DHZUReENEDMQMN
         OVyyQT3GZ90JsIAXpDQ9EPAlFtsaOdEku6BSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760649754; x=1761254554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MS87alHhSABD93QlOP7Xn0TuLltjwUxEwtFmTKYdYms=;
        b=O3974vMPsPZQVx4KTSN/+Bg6DnqfjcTeLOa0xuC/kfechDof3I98D7YNjVtuGYceUK
         pTGzEsNB8MXP1F+JJ7l6r8oz6K4ob7SU9LCsh6wxFDbIRWfWOZftxhblOle9mQYdnNTy
         R9ZR1siFkQUfgaiEsNV1sH13tslMa3VKeFCfOSPhaG3PRUmAYwR+TY3rEg+cWcPG8sau
         6gI3qoKZ49H9mK8x5x7sxMNzCjNDNTPFuO/8GF7aPuarcW3RPeO+23BLP4m9XxYE/1oY
         TUshFq7Q+By+TaT+HkNSlDEiBPGNJKRGZaMXC//atI0BK1r8sEU74d1CLbtg+ZHgPxCp
         lf8Q==
X-Gm-Message-State: AOJu0YzGnLC7MPTtXA3zSsNJ9ZeZ6+cXIdx0FR0t1GKOQ5jJeWEJUgaN
	GiKUL6XQcNS0AhVmYSVdOkcS7vmA+W+p0aU1BpiJIdTcCPCThgZ1Jhw9yxNdahc8Uw5klG80oEA
	PUNGi
X-Gm-Gg: ASbGnct2ZTaj2EWY4rif9ltUYQY/MwLMvDXCnkJ6W9WQ1SjFfWh5ib6kk0FfJyOwWS9
	Sye7Jk5thKpfU+IvIv64N4yIyCHxxFwnLqm5T+sAvgSx12dXkD1Ves6W8SMLH3yQU6XyV6VCJvN
	I2xoRiqHgKeEMD8Jb5FtZHRjJdsNUuJ0WfZY3JbQkzdfNjIyQQe6wsh8tAv7WtOyGlUQhKCCWc2
	8z6cL8fg3I2CnQYsqCxDGzO+FvaLcT1FYNQZJh9NgsZiK1Gq0VhvzYFA0GzWoOC5wSmj0300szI
	hpItsQjsPS2t3c6agAK73iqYeB/PUxazH7Sa4Qp8fBOiI5lO9W2ygI4UObzjzSVQqBcHSGuleIR
	72AaTTuYhSv8uZmcizl8pYwjT8uxrXSJYGZj041nU8g1qtDHlaNPhjmERIMz3ytE4yz3HlEWZF3
	53RAqQw4J5yX8dn5TtJrDi9uWZq8snk0Y3BMD/IwSaICffJrcVTQptel1vg6fFx0o=
X-Google-Smtp-Source: AGHT+IE0fwk5+BlUb+NhlnzDzqaux3jv1vobVpQ/i4t1IHLIf/Tk2fl0+Ou/44aKza9PtRzTD0Mxzg==
X-Received: by 2002:a05:6214:21e7:b0:87c:1fd9:da52 with SMTP id 6a1803df08f44-87c2070ce9cmr23970746d6.9.1760649754305;
        Thu, 16 Oct 2025 14:22:34 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c1c2fd4f4sm14647466d6.7.2025.10.16.14.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 14:22:33 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Subject: [meta-security][PATCH 03/15] chipsec: update to 1.13.16
Date: Thu, 16 Oct 2025 17:22:02 -0400
Message-ID: <f0d7a26159694c2c4ad4fa2b8a6c3722d31bf4c6.1760648348.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760648348.git.scott.murray@konsulko.com>
References: <cover.1760648348.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 21:22:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2328

From: Marta Rybczynska <marta.rybczynska@ygreky.com>

Update from 1.9.1 (October 2022) to the latest 1.x release, 1.13.16.

Changelog: https://github.com/chipsec/chipsec/releases

Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
---
 .../chipsec/{chipsec_1.9.1.bb => chipsec_1.13.16.bb}            | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-security/chipsec/{chipsec_1.9.1.bb => chipsec_1.13.16.bb} (95%)

diff --git a/recipes-security/chipsec/chipsec_1.9.1.bb b/recipes-security/chipsec/chipsec_1.13.16.bb
similarity index 95%
rename from recipes-security/chipsec/chipsec_1.9.1.bb
rename to recipes-security/chipsec/chipsec_1.13.16.bb
index ef293bc..5d65e89 100644
--- a/recipes-security/chipsec/chipsec_1.9.1.bb
+++ b/recipes-security/chipsec/chipsec_1.13.16.bb
@@ -10,7 +10,7 @@ LIC_FILES_CHKSUM = "file://COPYING;md5=bc2d1f9b427be5fb63f6af9da56f7c5d"
 DEPENDS = "virtual/kernel nasm-native"
 
 SRC_URI = "git://github.com/chipsec/chipsec.git;branch=main;protocol=https"
-SRCREV = "d8c2a606bf440c32196c6289a7a458f3ae3107cc"
+SRCREV = "c5e396716caf3749f728e43d0895317b593f5b95"
 
 inherit module setuptools3
 
-- 
2.51.0


