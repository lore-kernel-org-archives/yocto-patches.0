Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97C5CA0EE4
	for <webhook@archiver.kernel.org>; Sat, 23 Aug 2025 19:14:55 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.web10.3132.1755976377656882737
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 23 Aug 2025 12:12:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@underview.tech header.s=google header.b=VlaFAKmf;
 spf=pass (domain: underview.tech, ip: 209.85.222.177, mailfrom: vince@underview.tech)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e8706764d2so440293785a.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 23 Aug 2025 12:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=underview.tech; s=google; t=1755976376; x=1756581176; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZV/t7014RW/krF6kJCRBqi/0psSvIMpB6tL6Tdaklk=;
        b=VlaFAKmfw1A9wryfxwSUQd0KaAMYIyR0IKDZCHR8dbS8zu7CFxDNvD70cDbGuqExnk
         nc0pA+GJKCVhHjqe3HXuApAuhRAqEBJPAnoUIz20mVR4xnwr8ZmHeJwPvkBJZ7ANCLgH
         GwpSHeKu0R4Z3x2Tfv1EtA52DnAVfTlGjvipikCo02fdEPVnXaW57Mo5Csfai6XlZ7GD
         dR6YNpz0oSMTzu5jK5RycT03wD7vlWIVRfzbKKjBD6P8KIt0jKU6AdurxS1Wwe3jqT+L
         sG9GL3MmcDVPlFMc9fzjScoB2vTPLxCYwN660RHouaAuxinFmR5LTOlEa8yyPeOoWbct
         CF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755976376; x=1756581176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ZV/t7014RW/krF6kJCRBqi/0psSvIMpB6tL6Tdaklk=;
        b=o/KYn/pbYWINMppHjhanA0MnseIdzICTf0TXLpUKzH07X2N7e0SbSWobQkm5vFOjVf
         eJumTesJBjbXBbLl1H/zGeTbfhhNtYQCM0zH//HSKAI2fQ1GT6Xzl1TIcK5dSdU/xj2k
         IEziZ1QRe+8bZC2QWiKVmrRkRBzf4tUH3Xsvd4GHdAKY1F6Upp1IyvBdRZ9tkkSHD11Q
         BamniETqvfaeXaXDUczSqXQdCcZcUy/0YfT6IMqDfjNbJ52jrNNjcQawu8bhc9HhQqGE
         tDR/kZxImleywx/CJZQDKLYZI41XvSdMScwh99lOn8kF+o0YfMvD4AsJaJxA/o2Ukykw
         T9jg==
X-Gm-Message-State: AOJu0YyLd7hGGRi1k1vXEAGV9d5jN6YYcvuKo+pMMMWMKqpRIF4EawPt
	yeFccypV662n9hCpu7iSZesmWrdVHQlMYuSQcUEYzs80UdPI2DLVS9BkYxulbJYOsHqlDYr/mJM
	ot/vI
X-Gm-Gg: ASbGncv68OFsN57WivSr2BNyeKfo6JsGhUycxUaQHzX3VoByOO/pBBBCA0Bb2ZLHHYf
	XO00/V5Dz0o8cGkQdnZIC0Rkmg1JXuSERKcg81os7vpWp0ZSLXsxErrxjwz6nlt5indtZ30R2QU
	4voBvMp4e9B2ajaB7zFbXWOgHlvioABAaElkQhI/GgXML9xwblEdLvLZY3FU9zrjfWhe7txMHGJ
	UWB0gwrU4eCSVQzkA3jkHA8aBeNaaB6q4VsgaoFBmADzU7vl4FebZrba0dSLNXYdnfAiGaULh/t
	WI+Ek3zY0y4iN+67moqacfGAIQgHYW2oWeGegGiePMRKul2VX4XCZe0AMts1Mw96Ozscgk6pOyc
	ubcBZ+3ZdWCg=
X-Google-Smtp-Source: AGHT+IF2ssgc8wnbPIwBzuHivVFrOb3CIeOLy/ZNxr5C1Pgimch22iyXcYL0OkreNDVrSZgeiBzHdg==
X-Received: by 2002:a05:620a:4409:b0:7ea:1060:ccc0 with SMTP id af79cd13be357-7ea10f53884mr706468385a.8.1755976376227;
        Sat, 23 Aug 2025 12:12:56 -0700 (PDT)
Received: from vince-server.. ([2601:406:4d01:1820::6d26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebed8902fcsm190959885a.20.2025.08.23.12.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 12:12:55 -0700 (PDT)
From: "Vincent Davis Jr" <vince@underview.tech>
To: yocto-patches@lists.yoctoproject.org
Cc: Vincent Davis Jr <vince@underview.tech>
Subject: [meta-selinux][PATCH 2/2] selinux-python: fix No module named pip
Date: Sat, 23 Aug 2025 15:12:44 -0400
Message-ID: <20250823191244.574665-2-vince@underview.tech>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250823191244.574665-1-vince@underview.tech>
References: <20250823191244.574665-1-vince@underview.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 23 Aug 2025 19:14:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2080

When running the do install task run
into No modules named pip.

Add python3-pip-native to DEPENDS
so that pip it available.

PREFIX variable not being set also
appears to effect whether pip is
found or not. Unclear was to why
that is as of commit.

Signed-off-by: Vincent Davis Jr <vince@underview.tech>
---
 recipes-security/selinux/selinux-python_3.9.bb | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/recipes-security/selinux/selinux-python_3.9.bb b/recipes-security/selinux/selinux-python_3.9.bb
index b452887..88850ad 100644
--- a/recipes-security/selinux/selinux-python_3.9.bb
+++ b/recipes-security/selinux/selinux-python_3.9.bb
@@ -16,7 +16,7 @@ SRC_URI += "file://0001-sepolicy-fix-install-path-for-new-pymodule-sepolicy.patc
 
 S = "${UNPACKDIR}/${BP}/python"
 
-DEPENDS = "libsepol libselinux gettext-native python3-setuptools-scm-native"
+DEPENDS = "libsepol libselinux gettext-native python3-setuptools-scm-native python3-pip-native"
 
 RDEPENDS:${PN} = "\
         python3-core \
@@ -111,7 +111,9 @@ FILES:${PN} += "\
 "
 
 do_install() {
-    oe_runmake DESTDIR="${D}" \
+    oe_runmake \
+        DESTDIR="${D}" \
+        PREFIX=${prefix} \
         PYLIBVER='python${PYTHON_BASEVERSION}' \
         PYTHONLIBDIR='${PYTHON_SITEPACKAGES_DIR}' \
         install
-- 
2.43.0


