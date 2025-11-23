Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8262CFD340
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 23:45:53 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5051.1763941545908609959
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 23 Nov 2025 15:45:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ozcXJCwy;
 spf=pass (domain: konsulko.com, ip: 209.85.222.182, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8b2dcdde698so560446085a.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 15:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763941545; x=1764546345; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YuSXdBYrl3w5a84464sHxAPQ1UzSF2krdp7cjTU41LY=;
        b=ozcXJCwyP539Qry5OLKHz353OlAofqDOWZes4LT/HqkoUZtpBiG5DElPdizyvKHU8r
         2Kcp2I+CjtANIk465Y0Maw+jq/zdn8NDnBrzVMpWkhw0zZEhHYwHJpw6BisNAu7H493E
         sx0AN00nFiqOW+U7b3MSa1FgvB9mueOpctV3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763941545; x=1764546345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YuSXdBYrl3w5a84464sHxAPQ1UzSF2krdp7cjTU41LY=;
        b=GpdImvwYvpz7dwGN8i7qwp1rd9kZ59Wz0V8/94urVWgqr/9luk8qtOInP7UhYDcckV
         A37LrTgFuCzxZyv2j4k/3Ye0tvoig/oGoVJ0pPjtZBpGeMYh23CVCFRuyeJD5L43W+OH
         ltN77VJ5qbWq6dAfbaA0nQjJxpStVoapPB7s7NvTfGGMerpMorJQAFzw92/zMghgiwqk
         LtOZh2Zoon2Go2f6BrBCcHPL5Z/EndG4DNs1OhDdfo8vXjC0pg66sTbxQJcIUuxS33hS
         1fIYBbFQiwIB4lcFFrNnYVpdxKl3GXJDzb5hmwgJ8BbC0nrWHKNAO+7m5imOSgSWm3UT
         6SQw==
X-Gm-Message-State: AOJu0Yy+EWhript+M2W2MSWFPqEpeDc301jmE58DkRjfAnV1pgRM39ME
	0Q1pRx4qb2EkQKxuOpW9lHQd0tdI10mvSINsL3jUCOxgAM/H9VBF5gCXvD1nNyum/euQbmb3nho
	lQrf7
X-Gm-Gg: ASbGncttMvjKhBGPZJEhart45NJm60DzHPHSIXtm8LzWB5t2EObjxUSnqVfdlhtp5m2
	HOYAcD5Rqyay2K9AtxfYAElNMEQpU8+kT75nL9wCfYCDKE1PD8k1IBvIPAl/bL1xOzWCy2oM+7a
	YCjYlKxG7TbdQFDkmkkrtoTczdQIrnZjiYrov3kB2o8BGvEOzUNSaWbsh8rST/avCArVg55kdZH
	ukGBddk1UD0ErkjM6ngd8kDOjVXxttfiJZD3vriBL7MmEKBxhao4By3bYkTEnm2jbgOC60EZE6y
	21CzWM1I3Otn1uBe/g/cuCkGO5yWp8Am10PrKrzZR0wnmMfZSHZNQLJm4VFXtfnJf0GXfpRIopa
	gBZRgXi11yGxVx/Q964Ew+AJH10x3MZi3Fimdv9jdRr1hk/S0kGT0nDzLj+TZcLWb/qLRVim64W
	pX94oQa9uhqQLftylcndoZIsBbdUgVjWUoIw5HimxiFMbfHigGBdHYC5jW9sxkoTU=
X-Google-Smtp-Source: AGHT+IHWm8Jvnggevaq3TAwCXv4DALnZVvq5hqfDFSWH41Wn2AGoX+fcn9f80fBjFW52vEXOF7FrAA==
X-Received: by 2002:a05:620a:2907:b0:89f:2d97:98fd with SMTP id af79cd13be357-8b33d1cf940mr1156932985a.2.1763941544618;
        Sun, 23 Nov 2025 15:45:44 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932db59sm843706585a.1.2025.11.23.15.45.43
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:45:43 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][scarthgap][PATCH 26/32] fail2ban: replace fail2ban-python shebang with python3
Date: Sun, 23 Nov 2025 18:45:06 -0500
Message-ID: <4c8212c19ff9482f97abaff6d5d7a93531c2ea89.1763938436.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763938436.git.scott.murray@konsulko.com>
References: <cover.1763938436.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 23:45:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2684

From: Haixiao Yan <haixiao.yan.cn@windriver.com>

In Yocto, there is only one Python interpreter (python3), and the
auto-generated "fail2ban-python" symlink is not used. To ensure
all installed scripts can run correctly, replace the shebang line
from "#!/usr/bin/env fail2ban-python" to "#!/usr/bin/env python3"
during installation.

Signed-off-by: Haixiao Yan <haixiao.yan.cn@windriver.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../recipes-security/fail2ban/python3-fail2ban_git.bb          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
index 72a932b..e95048f 100644
--- a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
@@ -44,6 +44,7 @@ do_install:append () {
 
     chown -R root:root ${D}/${bindir}
     rm -rf ${D}/run
+    find ${D}${sysconfdir} -type f -exec sed -i '1s/env fail2ban-python/env python3/' {} +
 }
 
 do_install_ptest:append () {
@@ -61,6 +62,8 @@ do_install_ptest:append () {
     install -m 0644 ${S}/README.md ${D}${PTEST_PATH}
     sed -i -e 's|^logpath = README.md|logpath = ${PTEST_PATH}/README.md|g' \
             ${D}${PYTHON_SITEPACKAGES_DIR}/fail2ban/tests/config/jail.conf
+    find ${D}${PYTHON_SITEPACKAGES_DIR} -type f -exec sed -i \
+            '1s/env fail2ban-python/env python3/' {} +
 }
 
 INITSCRIPT_PACKAGES = "${PN}"
-- 
2.47.3


