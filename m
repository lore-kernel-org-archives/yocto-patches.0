Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED416CAC582
	for <webhook@archiver.kernel.org>; Tue,  9 Sep 2025 18:44:19 +0000 (UTC)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
 by mx.groups.io with SMTP id smtpd.web10.3231.1757443456169468265
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Sep 2025 11:44:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=LHZTXpc2;
 spf=pass (domain: konsulko.com, ip: 209.85.160.182, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b109c6b9fcso47619261cf.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 11:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1757443455; x=1758048255; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XgPD4CkmU6tb9TmutCQwcqC0nPjfQIypgWodjvCiXM=;
        b=LHZTXpc22wXTp6gAYXNFbXaB18e6lVLKGTTseXu7rUiEFhkOaIxnKmgFsC3j15r7YC
         7BMktTW/pOGtiOcIH5hO0gTeeDSxAc3IHHHyClyqKfMXmjJLJQYwSbuUhBiAERZprgBn
         YoITttAo/kVJF160YI2jPbXlSbQNbqzWAbHNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757443455; x=1758048255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1XgPD4CkmU6tb9TmutCQwcqC0nPjfQIypgWodjvCiXM=;
        b=Oeo47XFnoELBxhU7CdGz89bSx0BK1TjpUh13TZHjgkGepFsR7Qc6zRNOOota4sKl9X
         Ai8obXR5qGRsGNNHxHqQ/9//Z6lumZFoWSUh8yWnRtEumzxISnx5DFPxjBmbAiuakFZk
         UzGo0eHdriXHMpMg3cvNStMDXWX/QreuuZuJVFUr3HCjEM3hJthMLRTO95BZLfb/e/X+
         VHRpSYS7khycdILkTwixkNL47MKZgWvN+10u5t7lDD96JdmQQ5e10bk8Qbnow0IZ84OO
         xVaipc3klIU0s5qnHY/1Fyo8+xJMP9rzTnKbZnElltvdoSBiEjRVzK41J6O1BLfQCUmk
         wNQQ==
X-Gm-Message-State: AOJu0YziZ3fVoCK8PVCYI14stkkXXXMNXDeP8LB6xeXP1M5x27NqAIGQ
	TAzjy2Q/zyqvbnfeUqOagmkuLXQY8gM3TyTBdPg13uGp37egXs4xjTbQbGfI7YyrshaXSJIR/vg
	bqwFH
X-Gm-Gg: ASbGncv5I0udi3FvhOurZOa8T4UqubugoqtTXpLOb25S856W4O20X7qaiNuRjPswcb6
	sPnLqAVOhzvrJ72tgP9mLCvdNJrjGTm7t3uC2uD0q09ZkOqUee1DRMLePH6JNi8PemsSGqwSatr
	xLrjOtDI7yhQHODisyjyt5+qqLVT0Dut508VC1s6956P09q4FL4wNSTiWZn15lYhM+HRZmd4/BI
	VYhmHsm+GeT0WDXHUyyuZ/khgpeJkh5KUJWdx0mPzvBGckFoNkD/eJb/1dGq+jsgRCfqadjlqRD
	zswIEYg3yZZeHs5PZ3uBjs0sRJAioeCXe6I2ol2220UiaG4DOlqBtq7eFglT/uDWO0hLBkT4zP2
	pnNmLgEW4zwKJaYHamdqfnhdWslS8KeZKvEaMIlKxZ+uXy+6mm3aDmK2cR4+dYBln1HZmY4jepd
	pCbszu+SA3
X-Google-Smtp-Source: AGHT+IGrlzW0YV+OskjnmeXget9Z1Z7nG33B9YsRd2VcHhmn0kdO6ZKNthMGJtFGcT5rheZb+AQyAA==
X-Received: by 2002:a05:622a:3d4:b0:4b5:4876:fcad with SMTP id d75a77b69052e-4b5f8473c60mr162529811cf.64.1757443454654;
        Tue, 09 Sep 2025 11:44:14 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5f715c0bsm160164985a.61.2025.09.09.11.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:44:13 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Soumya Sambu <Soumya.Sambu@windriver.com>
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 1/9] rust-target-config: Add has-thread-local option
Date: Tue,  9 Sep 2025 14:43:54 -0400
Message-ID: <2e2c5600a1c4b160656caa708e912896f7f89b2b.1757441699.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1757441699.git.scott.murray@konsulko.com>
References: <cover.1757441699.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 18:44:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2158

From: Per x Johansson <perxjoh@axis.com>

The "has-elf-tls" option was removed by the commit
8e1614a906086fb46c5dd7b7f2dffab91194165c. However is should have been
renamed to "has-thread-local", since it was renamed and not removed in
rust by this commit.
https://github.com/rust-lang/rust/commit/391332c5d9d5a5e97a0d36e011a87ad43045cfd3

Change-Id: Ia1fdf7698ebeef62a88052713645d5b499164353
Signed-off-by: Per x Johansson <perxjoh@axis.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
(adapted from oe-core commit 18a87dd1724e0934a669aefae36d20374c06c493)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes/rust-target-config.bbclass | 1 +
 1 file changed, 1 insertion(+)

diff --git a/classes/rust-target-config.bbclass b/classes/rust-target-config.bbclass
index c4a86e3..1efeabf 100644
--- a/classes/rust-target-config.bbclass
+++ b/classes/rust-target-config.bbclass
@@ -401,6 +401,7 @@ def rust_gen_target(d, thing, wd, arch):
     tspec['linker-is-gnu'] = True
     tspec['linker-flavor'] = "gcc"
     tspec['has-rpath'] = True
+    tspec['has-thread-local'] = True
     tspec['position-independent-executables'] = True
     tspec['panic-strategy'] = d.getVar("RUST_PANIC_STRATEGY")
 
-- 
2.50.1


