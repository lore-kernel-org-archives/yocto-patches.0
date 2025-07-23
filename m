Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93601C83F1A
	for <webhook@archiver.kernel.org>; Wed, 23 Jul 2025 18:40:38 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.web10.22551.1753296034351814689
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Jul 2025 11:40:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=tDiBg7Qe;
 spf=pass (domain: konsulko.com, ip: 209.85.222.169, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e169ac6009so27390485a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 11:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1753296033; x=1753900833; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrFeu9DJ8c68IkqrqaBc7AUZLjSTLwy4NnjgOhTFvEQ=;
        b=tDiBg7QeDaEC20PrJEGaUYMasWMalWdtg7OtLkW69WhkMqLYOaSgbrXNpMLyE4SVNN
         JjMTQlp8J4zeXw0+TDc+7PICbNg8k3zcb3XO0PIPMX/Q9FtKgDoqY9F8+EW5uvjswgb2
         xngIJ9cQU5fWWfmQlQtHeP9WDnUsCa0aB7G6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753296033; x=1753900833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrFeu9DJ8c68IkqrqaBc7AUZLjSTLwy4NnjgOhTFvEQ=;
        b=pesax4FPCOiPv8zn70hfjXvm9dXrvGD2s0DzAFuakIFicVAxEw+p375pb8en6wp4Ib
         ap/OAmB6KdFmZWJtOFFdrFNUo0FcnixQcPfcIEiRSdi8QwsvROd8/ElLG0hrikQ3pkju
         Uxeb6qupteAVEDTPiJ7m+WqcXwEO93aDMeXEmhBgX3oxCo+IKJ+kZZMnP1azLJgTm4tV
         Vk2E3ObQy8UE3bapPeQcTb91XxkLtxO8EGc8uvp3uXTPVU+k9xn1mhITZbRa1g2MstyI
         jlQnVLYukjSITRHUMxitWlmi2GAYMGq4Rn9wuuJS+MZc0pav05h/G3iXC7L+gA6x0beq
         OpTg==
X-Gm-Message-State: AOJu0YzyITC6zp16Te4Arj6HahYw+vLAIPQ3QSIWZ1NGYYHdqPYdW4Ho
	aGqWY0L2jGijLuFlwjRHDJOeOiOhxIMAb35xdCmN9Fk+Y4obDIHAtmImD1iCj4KprK+60iICDJK
	Cqbg5
X-Gm-Gg: ASbGncu63rff9LsuaVDwPwKCdxH12D5ltSLOKPAOjFamcaBuYnmEkYmMFHWcxghPEfm
	Tg6D9j127IDymeT78uxv1oFWy1Ztuz/DGSJmqJQpqeEi06pQaA//5tC46BxBL1sAPDRD5il6aS0
	n2ArMxEpVqI46ROFf53x6NfmQ+Djt5JstbkHcYeHGM1nd1fC0+tmJJS40Wx7+jPLrbR9Vupyigp
	fyrA1bjkS2v8wFAM8HoOBrdEZcY+flnqdISIzDaP/uidGtzyhU2mzZmdJCgFEl+l+lDa19bbozv
	u5+/K+15TDnzNXxwi82B20DOFoLC6Url2c620kleYdX/EWt5j1wFO3XNDYo+exJuTO0JHo/HJUp
	dr1GFvb83eM0oJYU27rxIm4di731y2CiEFiUET/Ik6JKNvlvlNO6hbdsD90XR9I0dOYQ1gCDKAw
	==
X-Google-Smtp-Source: AGHT+IHXNgmNTLg5qTerfxsZWA0IkZpl7ARWnxL4CnhK8EItL5ymEbVq1qANK8OocBvn+MWBA9/2Kg==
X-Received: by 2002:a05:620a:1aa9:b0:7e3:3ec0:395b with SMTP id af79cd13be357-7e62a0b6d82mr392944285a.8.1753296032836;
        Wed, 23 Jul 2025 11:40:32 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c77a1bsm697255985a.85.2025.07.23.11.40.32
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 11:40:32 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 01/13] ptest-cargo: fix tests output format for testimage
Date: Wed, 23 Jul 2025 14:40:01 -0400
Message-ID: <9a916901a49feca16528ee191fc9ea2ba1ecfc4c.1753295655.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753295655.git.scott.murray@konsulko.com>
References: <cover.1753295655.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 18:40:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1828

From: Ines KCHELFI <ines.kchelfi@smile.fr>

In testimage, the ptest-runner output parser expects test results to follow
a specific format,with lines beginning with PASS:, FAIL:, or SKIP:. ptest-cargo,
currently, does not emit any of those lines and the parser treats the test
section as having no results, causing a test failure with :

AssertionError:
ptests which had no test results:
['<package>']

This patch ensures that the recipes using ptest-cargo class explicitly emits
PASS: or FAIL: lines, making the results compatible with the test parser and
preventing test failures.

Signed-off-by: Ines KCHELFI <ines.kchelfi@smile.fr>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 6a9356346f13556a06d4a99bd7924992c7e29d66)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/ptest-cargo.bbclass | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/classes-recipe/ptest-cargo.bbclass b/classes-recipe/ptest-cargo.bbclass
index 7b18d43..ece25ff 100644
--- a/classes-recipe/ptest-cargo.bbclass
+++ b/classes-recipe/ptest-cargo.bbclass
@@ -77,6 +77,7 @@ python do_compile_ptest_cargo() {
 
 python do_install_ptest_cargo() {
     import shutil
+    import textwrap
 
     dest_dir = d.getVar("D")
     pn = d.getVar("PN")
@@ -107,7 +108,16 @@ python do_install_ptest_cargo() {
             f.write(f"\necho \"\"\n")
             f.write(f"echo \"## starting to run rust tests ##\"\n")               
         for test_path in test_paths:
-            f.write(f"if ! {test_path} {rust_test_args}; then rc=1; fi\n")
+            script = textwrap.dedent(f"""\
+                if ! {test_path} {rust_test_args}
+                then
+                    rc=1
+                    echo "FAIL: {test_path}"
+                else
+                    echo "PASS: {test_path}"
+                fi
+            """)
+            f.write(script)
         
         f.write("exit $rc\n")
 
-- 
2.50.0


