Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00144C19F32
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 13:51:03 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web10.13436.1741182653609346053
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Mar 2025 05:50:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=dQgTQtjc;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.172, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-223959039f4so81072375ad.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 05 Mar 2025 05:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1741182653; x=1741787453; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pE99wS4Iiv2XIz8qn9/jirbL6F1xjtzg18pEkIc8f8Y=;
        b=dQgTQtjcgtiRk2ag+6CTkSpU8tEtJc3zmJx4NTiFRqzHG7gtt7bvTwzwWfcZrb+skN
         DD3+U7YgBjwv9W+o4zIGfFw0Ob2vePlfY9b7RcuzrO0YWAgttPFymUWT68UWheFHCWjd
         oNhDl5BhA/CV5xXgzl3Q+3fXm8DKrCBDCInIzpAmhAYVIUbA9iiQxkNvU6wu7irDT+hb
         GPRmmcuDtONIUcjx57XMDcDuhnspCsI7NeHbClIIxMPsy9r4KP2inPbPdSJ5hyh620Ac
         q38T+MLpoaAC/XX2+CcLGadtvJ/hRMo2X9PAnhAPyIT3PYt5WyWNrDjG9DaF3k54UrCn
         U7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741182653; x=1741787453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pE99wS4Iiv2XIz8qn9/jirbL6F1xjtzg18pEkIc8f8Y=;
        b=reSbCH3noiMHxCp6rsP3N4V6TtnOweaHekYIoJxIIOu/1vkl49DvTWQnLBjUZEqMIN
         TnGLPBcGICcUTXd17p4pUXuPcol7+xnDU3alt982TJlqN2qO/JWYccNGcWr6ZXQNO718
         UhjTcTnviwGDVdRnnnfNs4bIAn72Qm0p6r3nKzXppK2mjdTysR519BXAXrQzK6wR/ZAF
         8DtsFbUv1Wgq39mzCmB9qLYCQ9CULz8U/1WbDa8pKzvjZH0CBGMc/YqjyGxYJ/b3S8rs
         QITpovVMQ4LIY4XCIyqTBCUtyC3+0uxYxsle+5bngUVWqjFBnc0luNT0YYSfycGhhnj/
         93ZQ==
X-Gm-Message-State: AOJu0YwGKAdD2o5r8wWGtpCx/xtP/2IU9LkgseLAW0IahWbqG/xnEuwP
	fAG6FR0JaC9g+apDzR8Z/934uUODEZ7E54PycWhDwBBkX016+WQmpMldroIN7da+38yXSpBVQ+/
	X
X-Gm-Gg: ASbGncuRHIEPkUphN82Poid/q5BTbeNc3EOfL2+MYr2NzJ8KYAdzpocR6BvntWe4v2E
	GymueBgK0tkvEyPg7Tw/PH44wxaxEFYes/8VT14ZnhHIQK4LZuSgqWALQnhLO7abIUaQCbRiMo0
	bVvUccUacl5Z8k8phTBtPSp5CcwTuyE/PnrKJMdyds3Tss5xywEZ/Jx/IcDky6/EaH3lw0VS7tB
	crbyFHlKYs7xsHd3IofHORVqObCnKdhgekuUHf4/3JtYl5o1GhmxKRDhj8LVhQzTB2tn3EEJoUx
	FU8ZDRIYtY15MAZDuBSGVMC/biY3PPc+ySc=
X-Google-Smtp-Source: AGHT+IEYg+N7JQRdbhZdkvqFsYvubpYsSGQWBRTq1hm6b998NXaU//xkp2135A7SNagcGfagW9Jgxw==
X-Received: by 2002:a05:6a00:14d6:b0:736:53c5:33ba with SMTP id d2e1a72fcca58-73682c8ca64mr3886070b3a.16.1741182652514;
        Wed, 05 Mar 2025 05:50:52 -0800 (PST)
Received: from hexa.. ([2602:feb4:3b:2100:2308:d28:2350:a5eb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73643b17286sm7299728b3a.157.2025.03.05.05.50.51
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 05:50:52 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2 1/1] config.py: enable ubuntu2404 for kirkstone, not honister
Date: Wed,  5 Mar 2025 05:50:40 -0800
Message-ID: <0a13e92c54d0f1433508906ce820994d6ca23853.1741182589.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741182589.git.steve@sakoman.com>
References: <cover.1741182589.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Mar 2025 13:51:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1156

A previous commit erroneously enabled ubuntu 2404 for honister instead
of kirkstone.  Fix this.

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 config.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.py b/config.py
index dc7d6c5..87244b3 100644
--- a/config.py
+++ b/config.py
@@ -194,8 +194,8 @@ workers_prev_releases = {
     "nanbield" : ("alma8", "alma9", "debian11", "debian12", "fedora37", "fedora38", "opensuse153", "opensuse154", "rocky9", "stream8", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "perf-"),
     "mickledore" : ("alma8", "alma9", "debian10", "debian11", "fedora35", "fedora36", "fedora37", "fedora38", "opensuse153", "opensuse154", "ubuntu1804", "ubuntu2004","ubuntu2204", "perf-"),
     "langdale" : ("alma8", "alma9", "debian10", "debian11", "fedora35", "fedora36", "opensuse153", "opensuse154", "ubuntu1804", "ubuntu2004","ubuntu2204", "perf-"),
-    "kirkstone" : ("alma8", "alma9", "centos7", "centos8", "debian8", "debian9", "debian10", "debian11", "fedora29", "fedora30", "fedora31", "fedora32", "fedora33", "fedora34", "fedora35", "fedora36", "fedora37", "fedora38", "fedora39", "fedora40", "opensuse150", "opensuse151", "opensuse152", "opensuse153", "ubuntu1604", "ubuntu1804", "ubuntu1904", "ubuntu2004", "ubuntu2110", "ubuntu2204", "perf-"),
-    "honister" : ("alma8", "centos7", "centos8", "debian8", "debian9", "debian10", "debian11", "fedora29", "fedora30", "fedora31", "fedora32", "fedora33", "fedora34", "fedora35", "opensuse150", "opensuse151", "opensuse152", "opensuse153", "ubuntu1604", "ubuntu1804", "ubuntu1904", "ubuntu2004", "ubuntu2110", "ubuntu2204", "ubuntu2404", "perf-"),
+    "kirkstone" : ("alma8", "alma9", "centos7", "centos8", "debian8", "debian9", "debian10", "debian11", "fedora29", "fedora30", "fedora31", "fedora32", "fedora33", "fedora34", "fedora35", "fedora36", "fedora37", "fedora38", "fedora39", "fedora40", "opensuse150", "opensuse151", "opensuse152", "opensuse153", "ubuntu1604", "ubuntu1804", "ubuntu1904", "ubuntu2004", "ubuntu2110", "ubuntu2204", "ubuntu2404", "perf-"),
+    "honister" : ("alma8", "centos7", "centos8", "debian8", "debian9", "debian10", "debian11", "fedora29", "fedora30", "fedora31", "fedora32", "fedora33", "fedora34", "fedora35", "opensuse150", "opensuse151", "opensuse152", "opensuse153", "ubuntu1604", "ubuntu1804", "ubuntu1904", "ubuntu2004", "ubuntu2110", "ubuntu2204", "perf-"),
     "hardknott" : ("centos7", "centos8", "debian8", "debian9", "debian10", "debian11", "fedora31", "fedora32", "fedora33", "fedora34", "opensuse152", "ubuntu1604", "ubuntu1804", "ubuntu2004", "perf-"),
     "gatesgarth" : ("centos7", "centos8", "debian8", "debian9", "debian10", "fedora30", "fedora31", "fedora32", "opensuse150", "opensuse151", "opensuse152", "ubuntu1604", "ubuntu1804", "ubuntu1904", "ubuntu2004", "perf-"),
     "dunfell" : ("alma8", "centos7", "centos8", "debian8", "debian9", "debian10", "debian11", "fedora29", "fedora30", "fedora31", "fedora32", "fedora33", "fedora34", "fedora35", "fedora36", "fedora37", "fedora38", "opensuse150", "opensuse151", "opensuse152", "opensuse153", "ubuntu1604", "ubuntu1804", "ubuntu1904", "ubuntu2004", "ubuntu2204", "perf-"),
-- 
2.43.0


