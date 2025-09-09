Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF18CAC593
	for <webhook@archiver.kernel.org>; Tue,  9 Sep 2025 18:50:30 +0000 (UTC)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
 by mx.groups.io with SMTP id smtpd.web10.3379.1757443826057637140
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Sep 2025 11:50:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=TtbYG+mX;
 spf=pass (domain: konsulko.com, ip: 209.85.160.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b5fbd77f40so47849831cf.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 11:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1757443825; x=1758048625; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E7/9wZzKSzVEonR8G4NBjMHmSf/+DBQPS7FiltwueDA=;
        b=TtbYG+mXRBXSpD1/jgs0hT+VB2hc9WdqhiBL+sIzAMKnv9BII6Q3dwV1zd6FHZMdMr
         AyUmP/SnkBne38KpNonuL3dnYysHasdXEdX/PzCxv6QqDq8jB36G1hxrvbvAB8bet7ji
         o00wIBPXmvkS+V5cR1VEKfKM17mPHYn8R0CJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757443825; x=1758048625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7/9wZzKSzVEonR8G4NBjMHmSf/+DBQPS7FiltwueDA=;
        b=ikmo9RgkUpQDXKiitJOMpeeazWZU0ngiZMCs+VlhVjoOF7r+TyphAkADHeN469TsNA
         eQqPG33jd6O58aIbmlwoCa+yHlpr1mAq3jWtuXILdt8i006nfQQlfNcAGtlWY7mb2IFJ
         pF6U1PUXmwk6sThOaGBajDzve/fIMjqj+NmLyK+vozkCIIJdKuqu9JF6V4x5Di7SrO/z
         wWnheD8k8KzNzeP4WqJr67mvNs6/AJb6bBNW+3pkDm4hnoLxiQxwrT8FHmstb7cNO6vT
         ze3pQjNbFrAKDPiHtkhWK2kDziY41byyW62Tsjiy3mGtUSeoeLcAtVPh+2D5xwxRFtRo
         J9ow==
X-Gm-Message-State: AOJu0YxFCDX+30D96F5UCOX/f314J4ayPcduF+g6W42mUgVpjIQ+2IGL
	4xO47yCmNorqfeQ4UFnUOqrB8Yw0+LNqbTOBEQ/21Jam2KKhM4vZ/LdbtmCXANa7fd0tLUmbWt5
	dyrmW
X-Gm-Gg: ASbGnculQZUCmtU+p1me8PuaarUWIvQQhLIfS81qggKru00njHpB5n2hYyOecbHSZyp
	hWXLXs8EVj8l2kdMmqMffHteZettLDl4Iy9fjEmxV5PCMgj1AixPYm3yMq50rplIj/RNmlabzje
	W4Qo+WcV6G9QFAlNUF+ZgjNNnmiIrEjk2LM0gwzE1f3CzZUAjgGmcG1zoLYSIr0jsPeC7EVaidf
	Nt0FysljusJzo7xhCb8aJZwOq+O6ru2LdG0ovCiy936gF8dXfFPyVkcGp6LaYteajTEgtPkhha/
	hso+oIJJkDmWNkP+VrMJCLSjkfFCD79KSLW2B9ZGUGqFDcQHEWhkvHEnVGdDZf69+OuOVsiY1dT
	3TyW+q+BfZoFBqhRW8KZar8E9TKSR8xmKjuFU7aZ5lpD4byCIW5/jECkDWYyScjfyWqnPQ6gy7g
	==
X-Google-Smtp-Source: AGHT+IEmZ34xwEcxYRD9DfLnTVor6oHjiVAfi8ihw8ACz+v28cHiqoudkbRKdqSVLVlNsj04Mvzq2A==
X-Received: by 2002:ac8:594a:0:b0:4ab:7f61:4339 with SMTP id d75a77b69052e-4b5f83b411bmr141452711cf.31.1757443824814;
        Tue, 09 Sep 2025 11:50:24 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5ec7d3c8sm161168685a.46.2025.09.09.11.50.24
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:50:24 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 6/9] ptest-cargo: move run-ptest rc variable initialisation
Date: Tue,  9 Sep 2025 14:49:54 -0400
Message-ID: <1e842b980ba71ff3f767211c35113184acc66b85.1757443674.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1757443674.git.scott.murray@konsulko.com>
References: <cover.1757443674.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 18:50:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2172

From: Yoann Congal <yoann.congal@smile.fr>

ptest-cargo run-ptest can be generated in two fashions: generated from
scratch or appended to an exiting run-ptest file. The rc variable used
to track tests failure was only initialized in "generated from scratch"
case. Which lead to errors in the "appended" case.

Move the rc variable initialisation to the common code of both case to
fix this problem.

Only initialize rc if it was not already affected in the recipe provided
run-ptest.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
Cc: Gyorgy Sarvari <skandigraun@gmail.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 177c47b7decd8e2d1e24738d10b0f7db2777a772)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/ptest-cargo.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes-recipe/ptest-cargo.bbclass b/classes-recipe/ptest-cargo.bbclass
index ece25ff..8351644 100644
--- a/classes-recipe/ptest-cargo.bbclass
+++ b/classes-recipe/ptest-cargo.bbclass
@@ -103,10 +103,10 @@ python do_install_ptest_cargo() {
     with open(ptest_script, "a") as f:
         if not script_exists:
             f.write("#!/bin/sh\n")
-            f.write("rc=0\n")                
         else:
             f.write(f"\necho \"\"\n")
             f.write(f"echo \"## starting to run rust tests ##\"\n")               
+        f.write("if [ -z \"$rc\" ]; then rc=0; fi\n")
         for test_path in test_paths:
             script = textwrap.dedent(f"""\
                 if ! {test_path} {rust_test_args}
-- 
2.50.1


