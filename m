Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAF3CAC58E
	for <webhook@archiver.kernel.org>; Tue,  9 Sep 2025 18:44:30 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
 by mx.groups.io with SMTP id smtpd.web11.2985.1757443459855763465
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Sep 2025 11:44:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=RMLhWZTz;
 spf=pass (domain: konsulko.com, ip: 209.85.222.180, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-817f23fea68so131907185a.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 11:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1757443459; x=1758048259; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXGbuU64QRJ9sA5HUFf69APWYtdZMI+qQWwR0ZPk/CE=;
        b=RMLhWZTzcsjeyuV5+aSiCvR8PaDuHdHS6e4GkZpG8TyYqKYuYVGqPScQEv/C+uUk4s
         lkM6PMZpGnIoR+MZPbDrpcCup9bZZM9uW1tI41imzSg03SvM9S1tsSfM+7NHAxqP/Yos
         //Dj4oujXI6na4kSF+aGgBqltfg/bVZaCXSGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757443459; x=1758048259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXGbuU64QRJ9sA5HUFf69APWYtdZMI+qQWwR0ZPk/CE=;
        b=Zqof39Zz0bEzr+LdbaV3V4tRnxgB9v1J4PC37ie3Tl8gaU746rTLcXsYS2C7uarTco
         ArtarSSKvY+onLSmSsIQ2HuPDTOM4d+CrhsJUF4VnJytWj1v933xxD0lVO7myP2Q60uL
         FegrwfQyiSCGxehbMdVYAHDIS+GOUNuPHK3zutFcBV7B5mt3hWbqXpltlB8EsUJneUfu
         1+UTAHBw5iQrkp4TqzWFzALOOfM2GNidJ8ZUQEgP/rQAUNN+tXFFm3xu8ONTLJuIy0/f
         hxblgyCkLki0WG7rtT0vl6G6butMK/YH7I6Yo8qHsl9AYd9++KkwGJS9tLifZr5c6u7Y
         whdw==
X-Gm-Message-State: AOJu0YxuHMYaczemhRzLHVQsf5mc++mRM7qIutQ2c/M5V9rier4EyUr9
	SExzJ87iEG+qEfnWaREJj8DXl40caWJs6+gRleAeaiE8MMu2Os8y2K4hgYNzJseoXK5nt2a8+ho
	3yADQ
X-Gm-Gg: ASbGncuNWGpt/6d3qrdulxVZcQqtWr/LMWpJCA85t97jxaYAfv25yWwULS7HjulR0dq
	JIdJYLggQ1IRktYzaaG2VprqNm/LVxj3KoUWJKNTSOvey1O9je2UWfk9aSOxsJy8gzStr7XEdmi
	1jHkPR+3bl/DC9YL+9hBfYl+ki8fu/kUdMBPcGmZPrD/HwdmcaN1hwfqjUjCCZAKJpEX09cihY6
	ACPPo/UUD/GLk3pbWcIhvzFS+zyWvDgj+BGsE2vNWW0JOG3KcKz0Q8qSIZ45IwK4V0/zRn9LzFe
	T5qPpYbKZ05va/jWvGuDfU95Rl2e66RMujxOQmZOUXlrJnhHpC+rflVUX2VmGOPCzypGHLeAJ3k
	Jhv0db8wOXj1HYOAH7G3RUvA0cK4QwJFqKpif8ZX5J0XPc5SqdCq4rw7AugIp0ONK/zNajNVs1M
	6wc3aT7DOTRVdYtHhIPD0=
X-Google-Smtp-Source: AGHT+IGw72SZNTM03isS+2yf8iCeIj+yCRL4IXe5RVPLVWkAokWz2pqju7omDatdP3g4SBf8n6LOiA==
X-Received: by 2002:a05:620a:17a3:b0:7e8:e77:5f9d with SMTP id af79cd13be357-813c2b23d08mr1262768985a.48.1757443458598;
        Tue, 09 Sep 2025 11:44:18 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5f715c0bsm160164985a.61.2025.09.09.11.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:44:18 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Soumya Sambu <Soumya.Sambu@windriver.com>
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 5/9] ptest-cargo: move run-ptest rc variable initialisation
Date: Tue,  9 Sep 2025 14:43:58 -0400
Message-ID: <48ee231cf1e7659212dc21b4980320a7b6241471.1757441699.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1757441699.git.scott.murray@konsulko.com>
References: <cover.1757441699.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 18:44:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2162

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
 classes/ptest-cargo.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/ptest-cargo.bbclass b/classes/ptest-cargo.bbclass
index ece25ff..8351644 100644
--- a/classes/ptest-cargo.bbclass
+++ b/classes/ptest-cargo.bbclass
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


