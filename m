Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D52C43458
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 06:54:31 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32154.1782716062890843794
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 28 Jun 2026 23:54:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=UoGGWvgs;
 spf=pass (domain: smile.fr, ip: 209.85.218.45, mailfrom: yoann.congal@smile.fr)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c126553552dso83913666b.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 28 Jun 2026 23:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1782716061; x=1783320861; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uDFLPvI1leWlaEjEF6inUXqxq3QhduhOkAYqt00r1n0=;
        b=UoGGWvgsQEhfqPCIITnTCWeQc9HujJHw0IqFd5PfjVomjNKMhK72YGim2Z7sqQAw0W
         irt/LX/eGLJd/U/yv0+Mjec9tWIAVOAykExJy5UB9BaAhr9Sl6QZ3tWQKnbYmFRbRwol
         30zhVywYK1o02T1PrFMk0dSXrQfX2kk3lY/I0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782716061; x=1783320861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDFLPvI1leWlaEjEF6inUXqxq3QhduhOkAYqt00r1n0=;
        b=FdZYfmrQH+DUNGoNwLnHi5LC+COOMz4LxPjX2/Kip4uNifJfDUP4r7blBZuE/WIF77
         YrcFZpAdKmwylxUvibBO951uOUE+f+28tSfQ/zxN77EbtJG6g6H6AO7CLwc4ycgOg98D
         k24k56s7WQEeKm+H8BplqkCm2k0BjTrqZUkE3frm+oS0pbwbUx74BXjEvkhpXlN3O9l3
         i97dJ/VozHQXKNCuXu7yptBYJWI5w77Hyj3/4svAQtwBBlDL5wEg7PvjADjMWJ9Mesan
         6hoEfQ+lTsE05nYCM1ZbOa1a5Cv1jAd7N/WgZADkHnCv0rr59+Xkh8wgtjkjeh18tNA2
         VJoQ==
X-Gm-Message-State: AOJu0YwhG19JhkpgBNBuC6eva60/mzmlyCu/APCiBZqMEAKsgeJWVVPv
	CCrKnS35Cz0mEpVcys/vrtXg3z7tW449UNQYU6SlyD6UGOz6f8svb+NlDRKGH/Uqjav+JPmmW71
	YAaoK
X-Gm-Gg: AfdE7cmouQjsGq/jx6C68hIzFC/3jOrSeQaaISfxeES0SEKgUuRqGt3ht+dft9BRY7E
	Gg7a8aaMsI8gYQKzey0+sDsOm/6rd0gEZxry2nY+OLsl20dbJ2bz/KdaHNWksD9WbUW7ftNDhs7
	wTut2zuxiZT9MPEp+K9O5WI5FA29ktns9WtvI6Vv1GGMwbkWxQQIoeP8Ee/sw56Ib0nnPrIWirr
	8cpfWB1oL+lXn/zJw7py39h8G5NN1n+6Xh0z3zZdsrZVXuZ3m4ltjkO9oWcXEDEsqYO/OBDSLJT
	apxJlx+H6DAJ1+Hm14/p1lgSW0z/BuYw5RyssbM4pGOAHMVnJcF/yGzMm+qn7hMtLAe2aGrRk06
	+YgAtIqyMB9Tf9m+/b57oFTp4vy2S1hI/Eu9VMpGvCs6bWwAzl1i+XXGWh5AKGdP4lQDLfVf2YM
	pRyQlz9zQGJy1MFDd5Pzi+sk3D3AZ8y83n9LrJ+2DzRHb8Jjyp69gIomss5RSv+Xfl5w6RmTlKD
	wJ0E7J7AbxAHFNpyvQbydonxvJFTg==
X-Received: by 2002:a17:907:8e95:b0:c12:68f5:e083 with SMTP id a640c23a62f3a-c1268f5e717mr96876266b.64.1782716061067;
        Sun, 28 Jun 2026 23:54:21 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-250d-69b5-f9da-de58-f051-1989.rev.sfr.net. [2a02:8440:250d:69b5:f9da:de58:f051:1989])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12376df39asm373156066b.16.2026.06.28.23.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 23:54:20 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder2][PATCH] Revert "config: add Ubuntu 26.04 to scarthgap worker list"
Date: Mon, 29 Jun 2026 08:54:03 +0200
Message-ID: <20260629065403.2863125-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jun 2026 06:54:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4313

From: Yoann Congal <yoann.congal@smile.fr>

This reverts commit 241a957b6f76c2e6eb31d2456cae923c6e3f96e2.

To avoid triggering:
  16058 – AB-INT: rust do_test_compile/do_install segfault
  https://bugzilla.yoctoproject.org/show_bug.cgi?id=16058
... for the upcoming 5.0.19 build.
---
 config.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.py b/config.py
index 63e8b56..d102c93 100644
--- a/config.py
+++ b/config.py
@@ -205,7 +205,7 @@ workers_prev_releases = {
     "whinlatter" : ("alma8", "alma9", "debian11", "debian12", "debian13", "fedora39", "fedora40", "fedora41", "fedora42", "opensuse155", "opensuse156", "rocky8", "rocky9", "stream9", "ubuntu2204", "ubuntu2404", "ubuntu2504", "ubuntu2510", "perf-"),
     "walnascar" : ("alma8", "alma9", "debian11", "debian12", "fedora39", "fedora40", "fedora41", "opensuse155", "opensuse156", "rocky8", "rocky9", "stream9", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "ubuntu2410", "perf-"),
     "styhead" : ("alma8", "alma9", "debian11", "debian12", "fedora38", "fedora39", "fedora40", "opensuse154", "opensuse155", "opensuse156", "rocky8", "rocky9", "stream8", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "perf-"),
-    "scarthgap" : ("alma8", "alma9", "debian11", "debian12", "fedora38", "fedora39", "fedora40", "fedora41", "opensuse154", "rocky8", "rocky9", "stream8", "stream9", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "ubuntu2604", "perf-"),
+    "scarthgap" : ("alma8", "alma9", "debian11", "debian12", "fedora38", "fedora39", "fedora40", "fedora41", "opensuse154", "rocky8", "rocky9", "stream8", "stream9", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "perf-"),
     "nanbield" : ("alma8", "alma9", "debian11", "debian12", "fedora37", "fedora38", "opensuse153", "opensuse154", "rocky9", "stream8", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "perf-"),
     "mickledore" : ("alma8", "alma9", "debian10", "debian11", "fedora35", "fedora36", "fedora37", "fedora38", "opensuse153", "opensuse154", "ubuntu1804", "ubuntu2004","ubuntu2204", "perf-"),
     "langdale" : ("alma8", "alma9", "debian10", "debian11", "fedora35", "fedora36", "opensuse153", "opensuse154", "ubuntu1804", "ubuntu2004","ubuntu2204", "perf-"),

