Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86472CCF2C1
	for <webhook@archiver.kernel.org>; Sat, 17 Oct 2026 16:57:22 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.344.1792256237647988105
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 09:57:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=gNlmIbFW;
 spf=pass (domain: gmail.com, ip: 209.85.214.174, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d6e954afbdso3154705ad.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 09:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792256237; x=1792861037; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8wm9D5pauQn6BW4QYJe97LRVa6Fhbs6wxLAwXmHeAvk=;
        b=gNlmIbFW0cKaw/fQqs8CQ7OxHHUS53pos95YzH2e7KuJ+OLSMcZ+cqw7FiCjM2eVud
         A+ImrQH/wAoyC/QSK2WeIz6z9rWGL+ZjP7uCaatJg9/zh4HIdJuorLjO2t1EuK/jmwd0
         cireJEJswB9HxEaS1G6Ns4jTBNgfAdGsZ0twNbs+nVttP5nxLkf6WIZFITFjk83DNoBs
         QFikqmBFPZJthFy1QNtBvNVixObV9FcAAtPZwDA5s2qHJiT7xrw80vSVYcDjOIyhz5IW
         qUxMfU8rNIs6Xm+gWoVDbIaMU5OXo7LVzQYG6PvjsL3eOEjSP6S/lRoLuL6MalNKf98m
         m/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792256237; x=1792861037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8wm9D5pauQn6BW4QYJe97LRVa6Fhbs6wxLAwXmHeAvk=;
        b=yt1l9WYShIgVz1pZPl9BqUqPZewtSBjBOph+hqSb9YEe55Ln/GAgqalyiWdZ0E19P0
         MvgS9gY1WqREg9tfrYfiPCssSTPPEZO3qYgwmtwui5k61i8Qn8J9GUbXsAO0vszsjTN4
         b3AqcnKiiKN6AJJUWSOivvN2AKyY4y4+qQryhUS+wlzwncZZlot3aUTnUX3Pu9ObZKOy
         c5oGiamLT922CmGYUTebLFTw6YeYkAXQ2icTu9vWYwEO2eyPeOOnmrn8CFkVDbq1Cp1+
         TzfmTXAdMuTMbEyosQe7WzkvMPvtZBeaIn1vj5zYJ8l2OXd5S6iJgVBFO89qhy56GvE0
         CJoA==
X-Gm-Message-State: AFq9FYLWmEmOa+9bTvuvKy8pI/Uge0FV9E5fHzYKQYlQvG8X6R2qXxpy
	nTdeYOv8GQczbUFfQUpjm4UusPB3BTWOWg5m/Ji3PRrc749PThGtBGF5hPEteA==
X-Gm-Gg: AYBFou2XIsyXRzzZpbUHQnXQFg9dfLA3i3jhRhogjKADoEN3HlwlSXGL1Zgwvc9fG3R
	Zp3WIpKSrJq9uwCMYZ67LevBUTdHkYJTuc+/8dzNLJSsHz0h1PG2MZ/C8MPgwNGqRPEuacfHk/c
	+E7HGv4DYer2QJF0HbUryHQwj3zrQ3WHzEL1x2rKhVKsMi+yGym5tmA7vID8E2O8OIlJjJ3lbTF
	FLQ4ihg9tnGT2DRvMXBhpHimyPTGwWMgZ4xqq3Wbxfulopbi0XBbLnn+jm0fhkp2vfhJgLvaZTq
	73bDGD1fiWXV1mjeQtq4LEW3/9m64vtK/1p+Lul6CTr4BqTx6EHkuSjGEDpJg/xuq14oJgIoHpk
	6gDa2Pw2likO6h/N1hYA5luJNUQMEtARE+RafimrsPgGwkjp6EJ5qD2ssDkJcH3mFBDpnF94uJe
	F0rFG4j239JY4VBLur/GSTFpbi9Vu76aqGlZdJ72mZ9FbGadc0faiQxkY80bVXfj5vyBB64HP0g
	z+UONM/Vl4Mn1FNKOlZ52l2zQZoObY=
X-Received: by 2002:a17:902:e949:b0:2e2:d02d:a173 with SMTP id d9443c01a7336-2e9a6f59777mr28720925ad.49.1792256236956;
        Sat, 17 Oct 2026 09:57:16 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e5d7efcsm22402035ad.5.2026.10.17.09.57.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 09:57:16 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 2/3] branchcompare.html: don't submit layer checkboxes
Date: Sat, 17 Oct 2026 09:57:02 -0700
Message-ID: <20261017165703.70617-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017165703.70617-1-tim.orling@konsulko.com>
References: <20261017165703.70617-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 16:57:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5037

The selected layers are submitted via the hidden 'layers' field, which
is filled in from the checkboxes when the layer dialog is closed. The
checkboxes themselves were also named 'l', so every comparison URL
carried a redundant l=<id> parameter for each layer that the view never
used. Drop the name so only 'layers' is submitted.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 templates/layerindex/branchcompare.html | 1 -
 1 file changed, 1 deletion(-)

diff --git a/templates/layerindex/branchcompare.html b/templates/layerindex/branchcompare.html
index 83561fd..c9fe5f5 100644
--- a/templates/layerindex/branchcompare.html
+++ b/templates/layerindex/branchcompare.html
@@ -45,7 +45,6 @@
                                                 <td class="checkboxtd"><input
                                                     type="checkbox"
                                                     class="filterlayercheckbox"
-                                                    name="l"
                                                     value="{{ layer.id }}" id="id_layercheckbox_{{layer.id}}"
                                                     {% if showlayers and layer.id in showlayers %}
                                                         checked
-- 
2.56.0


