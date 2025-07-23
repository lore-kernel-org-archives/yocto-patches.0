Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBF3C83F1A
	for <webhook@archiver.kernel.org>; Wed, 23 Jul 2025 19:05:49 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.web11.23581.1753297546355408521
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Jul 2025 12:05:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ZywCpZY8;
 spf=pass (domain: konsulko.com, ip: 209.85.222.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e1f3b95449so135167785a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 12:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1753297545; x=1753902345; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLHrUC3z2KRgPfH+uF85QKIdODDZHdp/CHUENIZ0N88=;
        b=ZywCpZY8Bcxv62+6IjJ7Vf1X4DNEGAvWnMe3bk7Pny0fJBN/3ljvvnHVSeovy2WyAI
         ua36epcmRMm+X5RTsZpGyu/mNwPN+aVq9IA6yK7/luos5CXai56687e186MLAlKZEZdx
         jubyQfMdxHClh77ZDBBiqXpuVCKGbRugfvaF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753297545; x=1753902345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLHrUC3z2KRgPfH+uF85QKIdODDZHdp/CHUENIZ0N88=;
        b=IAK4MMBzuaPEPYEKS/aqcpoml1E6wHLFgRhIKKbV5rjxZ09XqESVlYQ5/dHVnmx7uS
         y/nbTO/S3DszZV+AimwznXnMTcSWLzhILkOqaLVi/JqKEb3LXlQMYjocJZXPcm3dtnvs
         V565Tn7x0bi1gHgcM/gEZ+wAXBAvyzSKoiaPonTjcZ2gqTCrIicyqxGYUQm59oeqbBIh
         Dr9nsPxTksLMV0jQr8iD8wuldJH4GyHPQ34gWUEL69U+45uLXXl7lXSqLGvQ7fgZ7NZv
         XU/y+FHhFcJA8SNJQemg7xVvGFL5ow4XNW4kMeMNv1PrJj9HfzSqCBnp3EnYSRYDYvlF
         k1NA==
X-Gm-Message-State: AOJu0YwGZWa00bpVzs6sLo1TG7RK3VEd/hgWHkUUmlpxZHLPGEdptYaB
	PN5dKqCGqNZef7DKbqpxgKtAiPYZVmlPn0JBIMDo/qatMlciOA872Ix5MQo4iG1rT+xrTyn/TAr
	pCf4G
X-Gm-Gg: ASbGnctBaI4uA38mcI6RNAER65HyZMlXSF1pMFW8Zk6LqwWIpR+5TlP25iQBoiOEopk
	bj2VZ1fUQhHAadVo73B62PD6aF+vtnKohmPB6rt7qbAbXmCpq/f0d9Sdt535ELu2Aqmqw5bjc5v
	gFPYGsi9k7H9qBrCfefwvOQWH/tI0a9SJWx0jMNN6KsvzLKyaK0TJGsnEd/CLkLBz5iqMuj6+PV
	wd5kraXaqTEwuRemTPuY8DL06sKljnV3HEqQ1MJ3MEjApQ8Rb6dZEihDcbL+wtv1Z/g7F7qY40t
	sOP2lNMsYtq3vLRXNuGZi0sBNyCARDFZJWP2m/Mq0peDktHNkUwoZm+unvWIrr4rrDhlxkW22u4
	csDXDwfyvA+TjGDkr4ibNEoqHc19xBUfjkBWR9vZWUv46v6Ln9+VtWAdwi/SzgDs7uSHcgDANcg
	==
X-Google-Smtp-Source: AGHT+IGEPkUgCE3MkgkHc7/G5cq+nWOY3fdmDFN+Umitb6m/D8Ft2A5s4WInS6wpDQDJJG+zfA/6HQ==
X-Received: by 2002:a05:620a:438b:b0:7e0:e2d7:e03 with SMTP id af79cd13be357-7e62a8af300mr504297885a.7.1753297545111;
        Wed, 23 Jul 2025 12:05:45 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c75cf5sm703576085a.84.2025.07.23.12.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 12:05:44 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: soumya.sambu@windriver.com
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 01/13] ptest-cargo: fix tests output format for testimage
Date: Wed, 23 Jul 2025 15:05:20 -0400
Message-ID: <efd603776a911911f8ee3c82beceba1741365feb.1753296167.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753296167.git.scott.murray@konsulko.com>
References: <cover.1753296167.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 19:05:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1842

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
 classes/ptest-cargo.bbclass | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/classes/ptest-cargo.bbclass b/classes/ptest-cargo.bbclass
index 7b18d43..ece25ff 100644
--- a/classes/ptest-cargo.bbclass
+++ b/classes/ptest-cargo.bbclass
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


