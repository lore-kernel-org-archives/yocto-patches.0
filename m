Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95D9E67A9E
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 10:20:07 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15132.1772533199211175993
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 03 Mar 2026 02:19:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=R3J8y7AM;
 spf=pass (domain: smile.fr, ip: 209.85.128.46, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48371bb515eso83165375e9.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 03 Mar 2026 02:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1772533197; x=1773137997; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aOlDlaSFOJWOWTuVjuOaPa/rgsHathkGQfC153lJf64=;
        b=R3J8y7AMFawtw0/qOaA7RfCM93aW2bcan7+7pYdci9RndVTWgtj6KewZ1AFqMjVjMH
         T6c2fKnncl7YgZjlFwJgIJUcV5Ar2f1E7RWODcwEZgPnV2R1K/f7XP6dFIPFzszc37Sh
         spMCDhZn7x27kBr552dTYeS0RX1oMJ8QhHhVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772533197; x=1773137997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOlDlaSFOJWOWTuVjuOaPa/rgsHathkGQfC153lJf64=;
        b=iKrfatJSm7liKjPLMHELrqYOhklk+3dZRcPkIi7i85a24HlA1q9p6tYNVOpJ/3Tytr
         UzlrZcJl3w51OIOz0wLLiJmBQJlu9GjxiF9dB54x8Je4PCtjpOaORS+8weep+FL748iA
         iCWYPuF+aOHsQ1LSL/4fo/H/toWgM/fmWxgdeFTvgQfm4sPWIp9IiFKJ6Np8cVncKQGL
         KS8nkqH7LqbK8EqSJ2ivIR9k3Hnpv7g6gLZ/6pycD5z8UUFqnHuqMc022q8FjHiy5e7L
         HTkTeiyAsSDNKctlsoK8U/ZzLPpHHZhAVkWwVuFY4IO8Ke6idFtOrL0dphcVy0ZeBWxW
         DZ1Q==
X-Gm-Message-State: AOJu0Yyui7gGg/cDLmU5ieY0OLL3xklbk27kqWi+zYx3/wiUGF1eyZjG
	bu9zwULhrgFBjb2aE+fBxq4rpVlsCjxKti8CJGEV0HIPZJIbsGy6AlErZ1a9Kk7GwxoIHHykD1z
	pg4Hf
X-Gm-Gg: ATEYQzzgWmVHSW4S/OjXLiPslbm7ZMZE+FhBBY65Ox0c725ZnQtAoH/ZJXmz1MIpW0d
	+Q0K4N9T7BCSR2aHj0s3brhFVTavIlHClS+W92tbKgUDJq98j3vQDiBYqsSkV3z4G/BvP8elp7U
	YVFFHiyjErlFVAl00uNt18S7Ra93pgisDQ73VDSloBCgTLvoHbMFNygAYMMi0exZdd72NTZjT66
	J3w8MuBWkTBmTo6PTt3JM2+ccOksLFRODYy3jZQ5rS1PRPuqoaQJyaC++OLjrXoF9y6pA0JDCa3
	li0D0ddVPN6q/XlNNheCD5dzyyA9OP+a2tZGdd2y+DFQSzgfs03m2rjQVoJYeHP9trVLhVdBSNa
	h9ZsuhdSfTMlNNPLnT/6abQEwhagpWgkSE07b1y7ExYwbCSg6O3TkPXnr4H/woTwNH0/dYbDdtJ
	D60JkhdWryoh3XANzAK6e9i6ZYACwOg+xnHdccdbAVVBJNDMm5nl/dLS9Db4vspj0LxCSj4B+ux
	vVzkugBLQvmAcLlHJajjDk3GHM1137ckFBxGOTtVDiy
X-Received: by 2002:a05:600c:4f50:b0:477:6d96:b3e5 with SMTP id 5b1f17b1804b1-483c9bb8ef7mr286003325e9.7.1772533197277;
        Tue, 03 Mar 2026 02:19:57 -0800 (PST)
Received: from FRSMI25-LASER.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b3ce8fsm341597785e9.4.2026.03.03.02.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 02:19:56 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder2][PATCH] schedulers: add missing stable branch selector for non-core repos
Date: Tue,  3 Mar 2026 11:19:37 +0100
Message-ID: <20260303101937.375207-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 03 Mar 2026 10:20:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3316

From: Yoann Congal <yoann.congal@smile.fr>

* whinlatter for meta-clang and meta-intel
* kirkstone for meta-qcom

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 schedulers.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/schedulers.py b/schedulers.py
index 38957ed..da9f906 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -76,7 +76,9 @@ branchdefaults = {
         'branch_bitbake': '2.16',
         'branch_meta-arm': 'whinlatter',
         'branch_meta-aws': 'whinlatter',
+        'branch_meta-clang': 'whinlatter',
         'branch_meta-gplv2': 'master',
+        'branch_meta-intel': 'whinlatter',
         'branch_meta-mingw': 'whinlatter',
         'branch_meta-openembedded': 'whinlatter',
         'branch_meta-virtualization': 'whinlatter',
@@ -222,6 +224,7 @@ branchdefaults = {
         'branch_meta-intel': 'kirkstone',
         'branch_meta-mingw': 'kirkstone',
         'branch_meta-openembedded': 'kirkstone',
+        'branch_meta-qcom': 'kirkstone',
         'branch_meta-qt6': '6.8.1',
         'branch_meta-security': 'kirkstone',
         'branch_meta-ti': 'kirkstone',

