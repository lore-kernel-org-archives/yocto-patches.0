Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABC9CA0EE4
	for <webhook@archiver.kernel.org>; Sun, 17 Aug 2025 21:08:23 +0000 (UTC)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
 by mx.groups.io with SMTP id smtpd.web10.61164.1755464893486311054
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 17 Aug 2025 14:08:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=MCHGd+Vu;
 spf=pass (domain: konsulko.com, ip: 209.85.160.171, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b274838c01so3171051cf.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 14:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1755464892; x=1756069692; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cPi+rkuz8le7fGml2RDXF5Cq+8XRqt5TWuZwmKOl4k=;
        b=MCHGd+VukrDRvDufhXQLGNRDnHVJ4B9iTSYVbHJC7dLJdaiwil+UwATgQPKvHz7T55
         qlL64AysNUjm2hDNK7r6H7R/yFcsTP9WjRxHHU/NffKVhwPDBt8oN6+u2io08BDyOifC
         qsZ/bKDap2ckP35leHpb9VQ4lIXW5eB4FRHCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755464892; x=1756069692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cPi+rkuz8le7fGml2RDXF5Cq+8XRqt5TWuZwmKOl4k=;
        b=jY9gFGMXoE6kGztFwi5EMQvFRZoe0EkCafpVaD1s8eZpbyrX1UglfgvTobTfcLw/Gz
         ADIOzFKUdxjW2YjpT41BIqXBUlAcVSgRUI52ZLRwVjRSwx+JxlinqtpC6tVD7D3K4XKg
         o6GTPwo9ezrvW1IbzxWW1pJtB19QX08Mv4FUtsndYc0ZUfaRhZA1xgl5pzJT/c4aG5j6
         LDP7mz+qpcuLL9nSEHAhT526f1eeP1E7qiCHhFubw6Q4FBtmySFBnxglA3yktDhx/GnO
         H0t9Mt6X4EShVW0RsrDogHCIVsglLcyLdH/pbq2wBtKT1oryAKflbJh3zU6btZw1pSbh
         3uTg==
X-Gm-Message-State: AOJu0Yzp1StwLq+jlhy+a90TnK5FNOerezbKplqUR+NBS0qQIRRdhU7J
	QQFRnLVMBzenkHes2klqrZWQnczr0MWWJaqPxg7JviqUBX1jSFUB7ZSJPYA0iML6LeGZmlBz6Qt
	2qeY1
X-Gm-Gg: ASbGncv/vGJUAsTocrCSywJludKuLmRezjhALVkSCbj6AXg7T76YKtDfnURxOtJ5TYh
	ucEwFk4Ipu1qpEzfKEi0iKmixGoKpgdeYZ5mEu4WvpphU8LXzWK05sOI3wjktV9vjnKFQuiS9zJ
	iPhQRFRhYXBA6XETZr/uM+bAoIpwSqEFpxXi+geUR37O4VYEILevj7q/0nnEu557OkQLnvkS5D1
	xjH9InQG+0mIuKPub2c1yYa9dgIlu6usYHfDBbvN2Z0h6u5SnDB/OCfRN5LQ85KzxZ1GNNdC4Jf
	Tw0NKDIp2JEG2X+prM8JZBdTO426E7GNs9lEo4rOzI138rbmS4jYQZM0ioRuccmQNcl0wVr+7gR
	ktdfDtWpgRBjxi15J42eTdkOkTVRQr/ET54X62EXMz/Ee2PoCsMISffh9eBnYiDnU20dPZ8G6bw
	==
X-Google-Smtp-Source: AGHT+IEeMMEbqzGRIXxh5n4zNYJIhGC4LYMBH67+pCcHX+ejt3JzExuOhruiPpduTascWofn/LJZsA==
X-Received: by 2002:ac8:5851:0:b0:4b1:103b:bb70 with SMTP id d75a77b69052e-4b11e32dabbmr125171251cf.62.1755464892303;
        Sun, 17 Aug 2025 14:08:12 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dddb0f4sm42215661cf.38.2025.08.17.14.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 14:08:11 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: marta.rybczynska@ygreky.com
Subject: [meta-security][walnascar][PATCH 2/7] CI: update build for new CI
Date: Sun, 17 Aug 2025 17:07:54 -0400
Message-ID: <f61a11f9d8b621cff81837400095a16653096151.1755464538.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755464538.git.scott.murray@konsulko.com>
References: <cover.1755464538.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 17 Aug 2025 21:08:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2025

From: Marta Rybczynska <marta.rybczynska@ygreky.com>

Update for Ubuntu 24.04 runners:
- use venv for installing kas
- add missing directories

Assume that python3 and pip are installed.

Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .gitlab-ci.yml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 46ab4a9..32ce2b9 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,10 +1,12 @@
 .before-my-script: &before-my-script
     - echo "$ERR_REPORT_USERNAME" > ~/.oe-send-error
     - echo "$ERR_REPORT_EMAIL" >> ~/.oe-send-error
+    - echo "$CI_PROJECT_DIR" >> ~/.ci_project_dir
     - export PATH=~/.local/bin:$PATH
-    - wget https://bootstrap.pypa.io/get-pip.py
-    - python3 get-pip.py
+    - python3 -m venv ~/kas_env/
+    - source ~/kas_env/bin/activate
     - python3 -m pip install kas
+    - mkdir -p $CI_PROJECT_DIR/build/tmp/log/error-report/
 
 .after-my-script: &after-my-script
     - cd $CI_PROJECT_DIR/poky
-- 
2.39.5


