Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48E9C27C55
	for <webhook@archiver.kernel.org>; Mon, 10 Jun 2024 14:32:51 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.web11.21012.1718029970514124385
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 10 Jun 2024 07:32:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=ME+5ONrW;
 spf=pass (domain: snapchat.com, ip: 209.85.208.51, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57c6011d75dso3154030a12.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 10 Jun 2024 07:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1718029969; x=1718634769; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjmZQJt+vGYWbhxKGdtHd+MS508GRhF7Q6fV997Tz4o=;
        b=ME+5ONrWJJUlxnNRz2r/L0l0nMTpjVmwNrbURnQ0kK5/2ZrCZ0PZlwDBSQdCOWFcAT
         cSbS7x9xuKp+9D/T/jrl/MCbZ6qFlV31/FSh/oZE6noewC3T9hJxFyD0P1relmijOcoG
         DxTqiOSspAlIuCfELkko2FK1OLp5EfWeEm01g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718029969; x=1718634769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CjmZQJt+vGYWbhxKGdtHd+MS508GRhF7Q6fV997Tz4o=;
        b=eOoUzflE3nPE+xUMyieCYTsaTt5HnDyKWQPFWApYy9Noswh8DtOzoILU6h2sczlmat
         namCJ+MhLlzsoXG+lpx4kfBf8dcZeq8D2QbMxuyRaV9NkQ6Fs3ZmSODj3nTtxKZBtxGJ
         L+Y60Kmfhb/rnSiK6P4QDZfy9fP+XegO9kR6Zbux2jiX4i5npoDltTIMhg/NB0K+UPpx
         in34r5a8qeiHxq0kHOPhgJpO27SPf0XOX508l4cYublsGAiuexzHUa1UQ+Xd2lkkgW4M
         EG+fkT52j3uJ2zXM2ErHnU0Lh+yJisBG4M2EeDH5z11vpUvhphZ+osHlWENwyPX7GNxp
         HWkg==
X-Gm-Message-State: AOJu0Yxgm67s+Sb9nWu5JmUNSMUARyh1VCnZuCpQ2DnSWIuUOcBQOYCh
	2pltAsZHu3XlYMPGs4Oyh4jKhR5SU+bt8SWCrm8/5vjpyg+onGMNZoHVmQJPX/QYi3aA59G4XEd
	hXmw=
X-Google-Smtp-Source: AGHT+IHZRfTHm7UoHiQl0h7pUmD4bOAnpylzYoUHfgbdq0NHXIhCDGMNIzLKn/vlehsnvSj/hW6IhQ==
X-Received: by 2002:a50:8d01:0:b0:57c:61a3:54c with SMTP id 4fb4d7f45d1cf-57c61a30661mr4522925a12.0.1718029968666;
        Mon, 10 Jun 2024 07:32:48 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([213.249.125.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae237408sm7504233a12.93.2024.06.10.07.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 07:32:48 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 05/11] automake: disable ar 'D' option
Date: Mon, 10 Jun 2024 16:32:08 +0200
Message-Id: <20240610143214.2376414-5-ecordonnier@snap.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
In-Reply-To: <20240610143214.2376414-1-ecordonnier@snap.com>
References: <20240610143214.2376414-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 10 Jun 2024 14:32:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/287

From: Etienne Cordonnier <ecordonnier@snap.com>

This option (deterministic mode) does not exist on MacOS.

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 .../automake/0001-Remove-ar-D-argument.patch  | 29 +++++++++++++++++++
 recipes-devtools/automake/automake_%.bbappend |  5 ++++
 2 files changed, 34 insertions(+)
 create mode 100644 recipes-devtools/automake/automake/0001-Remove-ar-D-argument.patch
 create mode 100644 recipes-devtools/automake/automake_%.bbappend

diff --git a/recipes-devtools/automake/automake/0001-Remove-ar-D-argument.patch b/recipes-devtools/automake/automake/0001-Remove-ar-D-argument.patch
new file mode 100644
index 0000000..e66b5ad
--- /dev/null
+++ b/recipes-devtools/automake/automake/0001-Remove-ar-D-argument.patch
@@ -0,0 +1,29 @@
+From 862a7ca3269b54a595051454c6fbb3c45688d929 Mon Sep 17 00:00:00 2001
+From: Etienne Cordonnier <ecordonnier@snap.com>
+Date: Sat, 8 Jun 2024 22:39:08 +0200
+Subject: [PATCH] Remove ar 'D' argument
+
+Poky patch "automake/0001-Drop-ar-u-argument.patch" adds the argument 'D' (deterministic mode),
+however this option does not exist on MacOS.
+
+Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
+---
+ bin/automake.in | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/bin/automake.in b/bin/automake.in
+index dbcf47c..0f2b84b 100644
+--- a/bin/automake.in
++++ b/bin/automake.in
+@@ -2678,7 +2678,7 @@ sub handle_libraries ()
+     }
+ 
+   define_variable ('AR', 'ar', INTERNAL);
+-  define_variable ('ARFLAGS', 'crD', INTERNAL);
++  define_variable ('ARFLAGS', 'cr', INTERNAL);
+   define_verbose_tagvar ('AR');
+ 
+   foreach my $pair (@liblist)
+-- 
+2.34.1
+
diff --git a/recipes-devtools/automake/automake_%.bbappend b/recipes-devtools/automake/automake_%.bbappend
new file mode 100644
index 0000000..4820dd9
--- /dev/null
+++ b/recipes-devtools/automake/automake_%.bbappend
@@ -0,0 +1,5 @@
+FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
+
+SRC_URI:append = " \
+    file://0001-Remove-ar-D-argument.patch \
+    "
-- 
2.36.1.vfs.0.0


