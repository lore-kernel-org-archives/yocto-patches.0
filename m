Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F183CD98DA
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 20:14:23 +0000 (UTC)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2216.1763064854310353599
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 12:14:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=siRjHqBG;
 spf=pass (domain: konsulko.com, ip: 209.85.160.181, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4eddfc251d0so11691241cf.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 13 Nov 2025 12:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763064853; x=1763669653; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ICTRuzZIVV9VRG9/aLITJKFRyg8QF7TocF6goLOSl10=;
        b=siRjHqBGIPbOenFafxt4NKJszvmAb31JNHwPlfG2qJH+7upHE+yGH6teNt3iNp9vDN
         XWoTX5wp97weUssJr08L4VUWFhfST/D+Ld4dSt1qtvg3bEHsAgk1d8eBpq7eCxfIjfl/
         /dlTO9KYAM/FDM1UmOPj+bDXRiqk3I8bMnpBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763064853; x=1763669653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ICTRuzZIVV9VRG9/aLITJKFRyg8QF7TocF6goLOSl10=;
        b=SKAiobbdxs/yv0Nyohv65JDuT5eKGVnsHXSNINKrnNOMs3ipFRKZXqdnOm5qHvVxN9
         EhwRwbMH3kDASzDU1kY3MEkCMCNVrA+Tm6VWum48STguRZl2uZ4On78PL1v4jmyw7EqT
         CmNSU8CsKCuSi5SKhW+o76HZKaBtBrwf0FDq3L0RDXBcymGQ27yRH2r3oh1X9nJJdBxO
         8P37kE3qhOW/r3pwr2pRdHXv7rtu26h59l8V2WVifmFEaPejfJV/lZKV8oEaIKTIhlDq
         y3B1NxeIZU+ux29+bSFMs1NIGm13uO+0Ez/wR7CBSKcAtPofGp7HP/ySf1DT4Rs50PdT
         Qe8Q==
X-Gm-Message-State: AOJu0YxR3xsyURZkNzjxh/KlKIm+DoZ3v75B6IaLw1HTC8QBlvUAmjqm
	zyCWgaXggQnWmEHkMPDoegxkVQ4WAvN5A0VYE0YK/2koQjId9HXlV61nR3HOpUZhtud+2ELbVXg
	4IDjF
X-Gm-Gg: ASbGncu0J9Tnz+i/cRFoZby2/8Ljz/Y8ZtapPTgCc+bT4nveeRB6Aj6JL5sCEzc6FyP
	Fayd/k359s3RV7orWb4tZiXSufCHkI/QraLcCT22AKobW1bEopDFnft3LQYLeemhjIBYlI8G2OC
	5A+qlBjut6KI84Dw6uGsXRzye00r92apXBzVb4Bo2uWhHNNoyAReGqOyKkdbfqTH9RQXAe5JlVC
	n5YL5UdlaRQAVD8T6wJD26DNillQDi3wBLyYUMyx7W1HrnsuNRzVlw4rpC6SAiOoY9CwiOqTt2k
	RckuL2KrvDZa80GCahRG8q7fvzI+uwYvRF1AxkA5ii83/+e1vSpSxUj379tXfTX55Jgr82bQwrN
	Ynzi5GbZO6wRvOknHF6cHTo5jMPSO2JOMrVJX05Ex7P+Qjfvs2hWv0kmwBth+Uo90XyUagzcVkL
	QuBNx01+E2lexOI57ytkMvOCH7QJvPg6GOLlI9Ach5PWw19meyAPgR
X-Google-Smtp-Source: AGHT+IGvb4BOIeuCaZddB1YO5PJ7skyIrYG1YdwLorr5iTIPGzKjcBHHMccaz4z3N6za0v2Bj/onMQ==
X-Received: by 2002:a05:622a:1647:b0:4ec:fb4d:105e with SMTP id d75a77b69052e-4edf212a426mr13743781cf.69.1763064853124;
        Thu, 13 Nov 2025 12:14:13 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ede881acc7sm17636211cf.28.2025.11.13.12.14.11
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 12:14:11 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 4/6] fail2ban: replace fail2ban-python shebang with python3
Date: Thu, 13 Nov 2025 15:13:40 -0500
Message-ID: <dec36ead2ebee374c542a70e4f0e9177443dbd48.1763064477.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763064477.git.scott.murray@konsulko.com>
References: <cover.1763064477.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Nov 2025 20:14:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2548

From: Haixiao Yan <haixiao.yan.cn@windriver.com>

In Yocto, there is only one Python interpreter (python3), and the
auto-generated "fail2ban-python" symlink is not used. To ensure
all installed scripts can run correctly, replace the shebang line
from "#!/usr/bin/env fail2ban-python" to "#!/usr/bin/env python3"
during installation.

Signed-off-by: Haixiao Yan <haixiao.yan.cn@windriver.com>
---
 .../recipes-security/fail2ban/python3-fail2ban_git.bb          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
index 4238c9f..cb7a4ad 100644
--- a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
@@ -40,6 +40,7 @@ do_install:append () {
 
     chown -R root:root ${D}/${bindir}
     rm -rf ${D}/run
+    find ${D}${sysconfdir} -type f -exec sed -i '1s/env fail2ban-python/env python3/' {} +
 }
 
 do_install_ptest:append () {
@@ -57,6 +58,8 @@ do_install_ptest:append () {
     install -m 0644 ${S}/README.md ${D}${PTEST_PATH}
     sed -i -e 's|^logpath = README.md|logpath = ${PTEST_PATH}/README.md|g' \
             ${D}${PYTHON_SITEPACKAGES_DIR}/fail2ban/tests/config/jail.conf
+    find ${D}${PYTHON_SITEPACKAGES_DIR} -type f -exec sed -i \
+            '1s/env fail2ban-python/env python3/' {} +
 }
 
 INITSCRIPT_PACKAGES = "${PN}"
-- 
2.51.0


