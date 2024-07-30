Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2B8C3DA4A
	for <webhook@archiver.kernel.org>; Tue, 30 Jul 2024 00:02:36 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
 by mx.groups.io with SMTP id smtpd.web10.6704.1722297751747916252
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Jul 2024 17:02:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HTYdtAHo;
 spf=pass (domain: gmail.com, ip: 209.85.128.178, mailfrom: akuster808@gmail.com)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-67b709024bfso28350527b3.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jul 2024 17:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722297751; x=1722902551; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qNe1Jlzl+ZGCykps/J1OVJ9OxsEEN2N7/ynoZW2HWw4=;
        b=HTYdtAHo14dvIhZppzq425UfGckjFuBaWrLPP/3eM9Ky4RvtXsKs3NZYKQRBmdKo+z
         t1TvjFq2hL5gh7pM/NmtAZ1Kuc61ZErSox207Vvr4adHNMP7Hm2mokO02yeP5zZo121g
         iyDVdP5tSpBotXjH3PDxNo+cO6dwxou7L2DNaVMG3Wpt71YGiE+uwcZJztpo50ZV+k55
         75I3xSkyOBeqkeIsBh+xvagEp3H6TYsreSqYey7R8rOiX6hw2nc7R53h1un/AGOSz7rB
         dqi7IKq1z+EMuedz2QhfiZsVRTOY7x+6URuBPU5uCAAoyhum6CoQ8csmq6a/naky7SgQ
         djzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722297751; x=1722902551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qNe1Jlzl+ZGCykps/J1OVJ9OxsEEN2N7/ynoZW2HWw4=;
        b=KmGbMmnv848Iw54KvEKuafJ6BLu5D67PGofgd8m97Ig/JEPLllMbSvPPT3BtXE0BUo
         4yGwIiEFxYaNHCm2qI+Q3QofVgmsiqfS6lyyU5O7OeLT9sbL0YtK5i05UpeJKbgx+JnJ
         K/Si9tJhGuaMStj8zRuYx2IjBSKQusO4XkfzGVFTMTpZdLZSJYCIEwLipd85GTODOHX0
         FAl8XBwn7E1v+S5aWwuycrwBGH8gfRN0MmN+ouOr5rxZUGrHY1lIIfcvfEsamLwRF0SR
         QkR5NBRN4h1qcJbgkEWtHoMiNcmVueyBbvPF7i5GKd5TjWfWqMo5yoejQRgUDSrEZLhq
         tWHA==
X-Gm-Message-State: AOJu0Yxlp423dWe5M5e0xhtbrmc7I3cHBvRr7m0HLoAZGkwGfia8iQ/2
	ObNB0r99kqKCE/rDdV4AcJNCSn7/8T5eYsKLjLXebBRtK5Hb9/JiNHifBw==
X-Google-Smtp-Source: AGHT+IE3fAY655kCkJKrWZ1jB047D0fDR5uRq2vSYxVHmituZKFVcgYR/Lw1WgKOhrDdQ5A4jUY5jg==
X-Received: by 2002:a05:690c:d87:b0:64b:ead:3e3f with SMTP id 00721157ae682-67a07b757bemr119407187b3.22.1722297747630;
        Mon, 29 Jul 2024 17:02:27 -0700 (PDT)
Received: from keaua.attlocal.net ([2600:1700:45dd:7000:8681:66fb:3bc3:40d0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756786a34asm23142017b3.41.2024.07.29.17.02.27
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 17:02:27 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH] ima-policy: Fix S=UNPACKDIR
Date: Mon, 29 Jul 2024 20:02:26 -0400
Message-Id: <20240730000226.694300-1-akuster808@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Jul 2024 00:02:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/498

Drop BP , these are files not src bundle

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 .../ima_policy_appraise_all/ima-policy-appraise-all_1.0.bb      | 2 +-
 .../recipes-security/ima_policy_hashed/ima-policy-hashed_1.0.bb | 2 +-
 .../recipes-security/ima_policy_simple/ima-policy-simple_1.0.bb | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/meta-integrity/recipes-security/ima_policy_appraise_all/ima-policy-appraise-all_1.0.bb b/meta-integrity/recipes-security/ima_policy_appraise_all/ima-policy-appraise-all_1.0.bb
index 121e9ff..b9aa352 100644
--- a/meta-integrity/recipes-security/ima_policy_appraise_all/ima-policy-appraise-all_1.0.bb
+++ b/meta-integrity/recipes-security/ima_policy_appraise_all/ima-policy-appraise-all_1.0.bb
@@ -4,7 +4,7 @@ LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384
 
 SRC_URI = " file://ima_policy_appraise_all"
 
-S = "${WORKDIR}/${BP}"
+S = "${UNPACKDIR}"
 
 inherit features_check
 REQUIRED_DISTRO_FEATURES = "ima"
diff --git a/meta-integrity/recipes-security/ima_policy_hashed/ima-policy-hashed_1.0.bb b/meta-integrity/recipes-security/ima_policy_hashed/ima-policy-hashed_1.0.bb
index 3de7497..8f0df9b 100644
--- a/meta-integrity/recipes-security/ima_policy_hashed/ima-policy-hashed_1.0.bb
+++ b/meta-integrity/recipes-security/ima_policy_hashed/ima-policy-hashed_1.0.bb
@@ -6,7 +6,7 @@ SRC_URI = " \
     file://ima_policy_hashed \
 "
 
-S = "${WORKDIR}/${BP}"
+S = "${UNPACKDIR}"
 
 inherit features_check
 REQUIRED_DISTRO_FEATURES = "ima"
diff --git a/meta-integrity/recipes-security/ima_policy_simple/ima-policy-simple_1.0.bb b/meta-integrity/recipes-security/ima_policy_simple/ima-policy-simple_1.0.bb
index 8b30858..440ce89 100644
--- a/meta-integrity/recipes-security/ima_policy_simple/ima-policy-simple_1.0.bb
+++ b/meta-integrity/recipes-security/ima_policy_simple/ima-policy-simple_1.0.bb
@@ -4,7 +4,7 @@ LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384
 
 SRC_URI = " file://ima_policy_simple"
 
-S = "${WORKDIR}/${BP}"
+S = "${UNPACKDIR}"
 
 inherit features_check
 REQUIRED_DISTRO_FEATURES = "ima"
-- 
2.34.1


