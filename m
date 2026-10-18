Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7A4CCF2C4
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 02:03:36 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7993.1792289009655533261
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 19:03:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=gtyF/cI+;
 spf=pass (domain: gmail.com, ip: 209.85.216.49, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so588591a91.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 19:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792289009; x=1792893809; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pu0zPwOo7Oh4KtsDust3UP6Srwe7uh0ThTo4tDgs1sQ=;
        b=gtyF/cI+a2lP9VfTG1iIz4pPYy4W9P/Id18lzGmzdP95A3zHqYfLBpMqBr7QTLxNPP
         L+emFl8zFQhYvUfGc4wuAnwAKeGlbyFaOXlNF/yri9qFdGn9PlEa4NQhGIbyl0s+TFFx
         R2xEWxCNfZRHHzHu/fx90NSZKWW7TXiIBADsFxt14PauGwtWmYaQ52bFiCT3q8QLMiXi
         OEedQ6izXV9bcjF/Nv03Zrg1/noyM67Md8Z53NhApcd1o0ZEzBH0mRAih+tG9xTnfLGZ
         DGWuWzOHYB30RU1FU7o2O/pvFoGF/Q966PP0Cw5B1z4fyG9me5OXSrBx1DuT/CS6Rq0p
         N0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792289009; x=1792893809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pu0zPwOo7Oh4KtsDust3UP6Srwe7uh0ThTo4tDgs1sQ=;
        b=q65GY5BNL/yASKL0bGajLnUuqBl4WJn9urtAzQdDPTmQfm+aColWXuraxiMwup0IZK
         lwqD2QTaYZOCOHwEQixLhtOjuW8EEsrgjM49A7UvJyg4OwBCLzkjynYJs2U1S6bcRDxP
         bRPUg53QkVcawauwwpUzl4hXek8weOAVbHqm7u7qobxVIGPpRAOFqhfEhjQDxRL5581V
         qFkwrHdgJtTHzWKiR0iIgOtoQ1kzInlKtHgNHNRZfcsDEaRz6yj6Wx50nsznYoXD1s1I
         RudhJXagORwwDIA/40nyOwhEqjyUFgF618o6Rzewiem0QTr4CDcQUE54ynDwBM+bxobY
         nMhA==
X-Gm-Message-State: AFq9FYJlL4brds1DzFok+xTZPK8hUiOXAoDmy2Xn2BIW4KhfY5p0/OgG
	5ah4voWhEBwVGmO3h9ZxE50xGPDjNlH/Ft8DNk1ezzy69KQ69Ux6ANZalxOXWzyv
X-Gm-Gg: AYBFou2saGp7iOFh+PC1un4+iPgUCvQ345fftCdKQHk5bWhj8yAIqql9X9kz1RXedPF
	tmzLg2cpyn+V18sZx09RyRFBm+ECEGqGhLbmTDEhqIcE0qyiOGqCJiuA4BZaLQOMfUU0GQmngRb
	BNSy+FXT5nL7NzEcc8SC9mIelZ7o5MIq9YrDRoZHMk0HGXFcD5H9G7bAmT0iJw5IKR0LlOMeIbI
	MYHU/xOSM2dGlN8qWDWHI7xmX1TQ6FJBCiqaaUpiepIfEX0+lIS2r5FVSx6pK6K4DPyrwxiC93O
	jt8OztM60ajq5xgp3kwOb+kM5mOkPhK6gyNuwwmHuFBfwQ8p3cJHm3EvraRixteMeeB1TJgMdK7
	vJAaCZsrSJf9qu88QCBmpELkB7E6rRatb3Twa1Fj4IjtdWe7y2OeKeSCJgH+qpNC03RiT6wOAYX
	2u/MFJ2gnEA6ljAKBvJOQ1ntM7D2sdf/Alth3QPWZfmWMfudh3dLykMtz+VxCsnzxJdsKcWoEjz
	oU4jhtPdg7+QQJ9uWjOLV2Mi5vmkts=
X-Received: by 2002:a17:90b:55c4:b0:3ac:9669:8464 with SMTP id 98e67ed59e1d1-3aceec26e71mr3001602a91.24.1792289008928;
        Sat, 17 Oct 2026 19:03:28 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac947928b4sm14569131a91.11.2026.10.17.19.03.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 19:03:28 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [error-report-web][PATCH 4/4] Remove the obsolete .env.
Date: Sat, 17 Oct 2026 18:57:11 -0700
Message-ID: <20261018020116.75276-9-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018020116.75276-1-tim.orling@konsulko.com>
References: <20261018020116.75276-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 02:03:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5065

docker-compose.yaml now uses .env.dev.*; nothing reads it.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 .env | 5 -----
 1 file changed, 5 deletions(-)
 delete mode 100644 .env

diff --git a/.env b/.env
deleted file mode 100644
index a6ea41c..0000000
--- a/.env
+++ /dev/null
@@ -1,5 +0,0 @@
-# MySQL settings
-MYSQL_ROOT_PASSWORD=root
-MYSQL_DATABASE=errorreport_db
-MYSQL_USER=errorreport
-MYSQL_PASSWORD=errorreport
-- 
2.56.0


