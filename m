Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F6FC83F0F
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 17:11:58 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.web11.1106.1751649116865797859
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 04 Jul 2025 10:11:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=a8CqhUnJ;
 spf=pass (domain: konsulko.com, ip: 209.85.160.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a44e94f0b0so14389701cf.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 10:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1751649115; x=1752253915; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tV5PCAWtLfSx/58wzTy4ytbhV/e6XFVT0/2dsinBTg=;
        b=a8CqhUnJH0xzt/vknVsEh8IxzAHT5QnI/WD8Em5r580fgzyZ91QwWBJzUdx6jVR31k
         nzJZMtFU2IKURGBcWzue9oInCo7neRTkY+3oio8odV2YZSeXYrU+WRMaY3dGnoqZpc/z
         hcA5yuBKKqsvs173uarPjj11ZrBHXeJbvm4lQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751649115; x=1752253915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tV5PCAWtLfSx/58wzTy4ytbhV/e6XFVT0/2dsinBTg=;
        b=lnkwepHNDBiED7cfDDXkoUkr+AUOOAqRJFCLamlWqgD+QwGOlZ4ksHjO+p6YoyRIa6
         PAy4UG/1hL6JQsqifsISo/7gTq40HRmnPKfDQ0CtS46n2lLQwu+jq97+L4/sYrfCfWGN
         RVqKysfvi1uVKp7D4UyJYWkLTT5OfvDngxYgjFsXvX8gy72V6LitbexrpHPvqz5ulMDU
         0C7f5nYcI01yDHwnZRe7geuP3xoxbYI9BtOeVvYahccBzKJvJ+Z8A1Qj3h2pXJdHl6s5
         Im1ibti8BIZIgcbOkDhKUxxSoTkUYAmf21xCu/ImX7ERBaVvx4qOoFrPGnzqvSFCTAuk
         4Wng==
X-Gm-Message-State: AOJu0YzTe1U72paFIeLfLCcHNHkmdJ9V3iIREddW+1WkhO0qgq6+SJuu
	u4/hzdkhEPkmbYuywRfM+ehDvrtfunTdYMXDQsX0qmssU4KiYXR04R3lnfjHZqxV7EWU96A84Ss
	dzBKL
X-Gm-Gg: ASbGnctY17n5CmP0oejcvOqiwDlokN+gqaf1P5zfBhZjmZC4Y5kAyK0+vvckN9Gjgmq
	c7C+5WkJ5WmGRBuZiN37Le4QJNKPtzqtuNhow6a4mfdb/yDbHLinCG6SaWA/upJDTfHgNGtZrqQ
	gVwGusqWE7MEMgrxYARqPbTKUlGila+icegnZH1cusRzbii6eVNTEbdwZRBGcfXOzyTZpOPHhEI
	MVsbiZ4zCAVVFCa6QojOvCRE3KdV3NfJALNXQYTABAoCMxaf6Nl/p+AIEO7kSC6mANJszqIbn8Y
	1fl46YSXKDHYQgfVUFwmRBysnNU999hivA0ZPlQERo7xqM7LST0Me6iPFzPjd9r/iSoF/8lkDEI
	mA+bjsqxFgmaNjZpX1JHfzTwVBEt5nHiYPfoQag==
X-Google-Smtp-Source: AGHT+IE+QrwToVlcPSW2dIu9e1Mx2Lyf3IN+zEq2Sn7GxXwLzRXp6duUAjT5xhf7A1VpP1p1uPjMYQ==
X-Received: by 2002:a05:622a:11c3:b0:4a5:aa42:49e6 with SMTP id d75a77b69052e-4a9964fee4bmr53762261cf.32.1751649115425;
        Fri, 04 Jul 2025 10:11:55 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949f99dcsm17249611cf.19.2025.07.04.10.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 10:11:54 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Scott Murray <scott.murray@konsulko.com>
Subject: [meta-security][PATCH 07/12] sshguard: Update to 2.5.1
Date: Fri,  4 Jul 2025 13:11:11 -0400
Message-ID: <abddea907bee174d3690003a34e7661c03a47c2c.1751647559.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751647559.git.scott.murray@konsulko.com>
References: <cover.1751647559.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 17:11:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1759

This picks up required gcc 15 fixes.

Changelog: https://bitbucket.org/sshguard/sshguard/src/master/CHANGELOG.rst

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../sshguard/{sshguard_2.4.3.bb => sshguard_2.5.1.bb}           | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-security/sshguard/{sshguard_2.4.3.bb => sshguard_2.5.1.bb} (79%)

diff --git a/recipes-security/sshguard/sshguard_2.4.3.bb b/recipes-security/sshguard/sshguard_2.5.1.bb
similarity index 79%
rename from recipes-security/sshguard/sshguard_2.4.3.bb
rename to recipes-security/sshguard/sshguard_2.5.1.bb
index de3d856..db5bad8 100644
--- a/recipes-security/sshguard/sshguard_2.4.3.bb
+++ b/recipes-security/sshguard/sshguard_2.5.1.bb
@@ -6,6 +6,6 @@ LICENSE = "BSD-1-Clause"
 
 SRC_URI = "https://sourceforge.net/projects/sshguard/files/sshguard/${PV}/sshguard-${PV}.tar.gz"
 
-SRC_URI[sha256sum] = "64029deff6de90fdeefb1f497d414f0e4045076693a91da1a70eb7595e97efeb"
+SRC_URI[sha256sum] = "997a1e0ec2b2165b4757c42f8948162eb534183946af52efc406885d97cb89fc"
 
 inherit autotools-brokensep
-- 
2.50.0


