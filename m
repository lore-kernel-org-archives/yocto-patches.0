Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D0FC61DCD
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 20:58:53 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22625.1787777926411811081
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Aug 2026 13:58:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=FqaHBFjC;
 spf=pass (domain: konsulko.com, ip: 209.85.222.177, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-936cda0e3fbso105319285a.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 13:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1787777925; x=1788382725; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=V89ZoqbV/9M7Aiv0Mcy7UNb/UquGwm9FfQy8p3qeYWg=;
        b=FqaHBFjCrxYkUdpBxbUotS6w8sH0DNOSyl3qJfdO3N2obYp4G4iFJvUEB7kR6b5yft
         wvzdJmXmfyb484qgZFhEPMU5RgWucXVAo7Ln9TEeB1yPiCCms5PmggkyaiONTGJfy5fO
         qcenVq3gRk1Ujxh9qrK2BqBbhmU4jJdIOQVfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787777925; x=1788382725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=V89ZoqbV/9M7Aiv0Mcy7UNb/UquGwm9FfQy8p3qeYWg=;
        b=Judg2tzC1GlqAws3f03iiqubpsZfSWl41JxEFv97Uo8TPzk1rIs0yAVlQhva2zoCoz
         KsF22orUlIk3Se4SuZkaoBFqW8PmG2xbcgxu3geExA6oYkZdwDzGck2UYKlLQAxYWOj9
         eMfTAvf0k84bZjJnii2n6SlVqsxBiMRLR3PDd9jmRGXERadIT3XGw80T6BZ6Xy1EPMdk
         WxvEsDP8yBrnkG/TIOsqPi9VeSSe1JUr5fx0DZd2b4N4RsszOxKlNS39zFZ5VbusaITv
         GP7psYT+zLjSrbHZAPl6JcBbf78GCmMnNg2k/XpiaJwRNhHTtjoeVbGclKFUcYaZtmDp
         ZxuA==
X-Gm-Message-State: AFuF++l4seqYqdoAl+LmblRLwDH9RmtlXEJV9/H8gDzufdormg1k7AO3
	a6v+Zz7MHNGP5ukBgUmpT5TxxJbGYsP9fz2bBVU9qaLcOU2xb9cjjkvO81A4hLeFvE0kXEC6xyL
	QIale
X-Gm-Gg: AR+sD10fG8sxsnqNDFIJhJroJl8pM+dGA3svyOh2Qmra6ckEHoLi7IL2mHP+NhT2SPZ
	QMrlXZ8nf4B4o8ePa4bz3KZAbIJnUtzoEuheCsvEQaJHsnaQGHB3s/NGDjV87mQE6cyZtRLjNU4
	clADZ1e7D3oR9T2rUTbEQO7lqkRILojXSm9cPBiGLyiofquhWMBY/SAo35Dvb5ZFUWwnkyJHJc9
	rY8XAVzkSZ2wamzvIy/cxE8KafHkBKZFFtXxpExc/V0dhMsJofaD9t4/LYx4qf1P7sbVMM1Oq/U
	So/EkPjrwZrKieMYL3JOos9lQXHDnPa/axShrjqxscF0IldwTtzB5EI+lCzGFYnxNfAEFLzH5ZC
	1y+KWPjQ0zRz45VZ//53aKY9w5MOvu9ZgGjWyU8AzAjRC+QhYykngcD41eHHhWfm5UABsxbX6RM
	2yPXCXjaYdnE46zsHO/WdDazdeyc7n93mrRqQHuldkgG18tyei1himzWBMMZk1QrVetNhY9Tubr
	FbvmaZ0FKbDiGlgLzORPcqDC09s47BpAvk2P9urlyDJKkFtgbdpZxzJykTmPWHgY5ZcSJzckCr9
	csS7/tJHnYsK7R/ODe2iF9HxuQ==
X-Received: by 2002:ae9:c213:0:b0:92e:5b92:98bb with SMTP id af79cd13be357-9378016e8d7mr863071285a.14.1787777924952;
        Wed, 26 Aug 2026 13:58:44 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cc65093d5sm35135856d6.26.2026.08.26.13.58.44
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 13:58:44 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 02/15] suricata: handle oe_cargo_build removal
Date: Wed, 26 Aug 2026 16:57:36 -0400
Message-ID: <74e55cf4fb2e4a6f58a487ede7d4fe39d6101448.1787777775.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787777775.git.scott.murray@konsulko.com>
References: <cover.1787777775.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 20:58:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4694

Handle upstream removal of oe_cargo_build function in oe-core commit
a64ac03a61 by renaming our local override to cargo_do_compile to get
the same effect.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-ids/suricata/suricata_8.0.4.bb | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/recipes-ids/suricata/suricata_8.0.4.bb b/recipes-ids/suricata/suricata_8.0.4.bb
index b3ab261..5ae0d97 100644
--- a/recipes-ids/suricata/suricata_8.0.4.bb
+++ b/recipes-ids/suricata/suricata_8.0.4.bb
@@ -86,12 +86,17 @@ CFLAGS += "-Wno-error=incompatible-pointer-types \
 # breaks building this recipe. Providing a copy of the original function
 # Armin 2025/04/01
 #
-oe_cargo_build () {
+# 08/2026 note - oe_cargo_build function inlined into cargo_do_compile
+# upstream in openembedded-core commit a64ac03a61, handle by renaming
+# our forked function to cargo_do_compile to override it directly.
+# This still works since before a64ac03a61 cargo_do_compile did nothing
+# but call oe_cargo_build.
+cargo_do_compile () {
     export RUSTFLAGS="${RUSTFLAGS}"
     bbnote "Using rust targets from ${RUST_TARGET_PATH}"
     bbnote "cargo = $(which ${CARGO})"
-    bbnote "${CARGO} build ${CARGO_BUILD_FLAGS}$@"
-    "${CARGO}" build ${CARGO_BUILD_FLAGS}"$@"
+    bbnote "${CARGO} build ${CARGO_BUILD_FLAGS} $@"
+    "${CARGO}" build ${CARGO_BUILD_FLAGS} "$@"
 }
 
 do_compile () {
-- 
2.55.0


