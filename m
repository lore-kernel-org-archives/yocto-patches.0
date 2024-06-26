Return-Path: <gael.portay@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485AFC27C4F
	for <webhook@archiver.kernel.org>; Wed, 26 Jun 2024 13:40:01 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.web10.26800.1719409192089884505
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Jun 2024 06:39:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=QBcW4IHT;
 spf=pass (domain: gmail.com, ip: 209.85.167.41, mailfrom: gael.portay@gmail.com)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52cdebf9f6fso5515198e87.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Jun 2024 06:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719409190; x=1720013990; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6I0NZefWHyvAccPNvrXbtSSO1i4rXYG/swMM4oXYm+Q=;
        b=QBcW4IHTnFsvP1KZKoTeqI4qrTGxmkbiqrmn/MpNVso91V85xGk4M2V0t/dL6OhJMj
         DqjDp88AX93zNF41vP1fwQy9RbE5t0tXVfec9a8CCPagfcLOunYudqEtrmpQOExVXgrr
         QPlaF6HLUfArgKOtOZ2m7wNMWpnUBUb5rADg2iWv0Te59HquMEqQ3VPVMy1W+vDuKcmV
         qmWD/dC9DtxFu4g0pHxIbjEdwA3OynDGzR0YLpE77+laIO0wTJHxydvQa3za75EiPqcd
         qUc70us2L1zgtoIcfDMc3Vx6tKWHgGWza/ZX7JXS2LPIjEccbVI5rqLJIvfcysFFjbD9
         3+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719409190; x=1720013990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6I0NZefWHyvAccPNvrXbtSSO1i4rXYG/swMM4oXYm+Q=;
        b=aZf9BPgpw2OHMzcnAzwXO4cDLCgFikVV4c/ROsYhYltHXlbc1TXcqqmw4Dbe7Y8Y8r
         Gj5+nSrvVpMG88xi8QYacx/kSzpO6ZriN/5bkkWR0RvfKuyjul/d2evivIgeoMkmUYCV
         4fuIx4C/5fwvyLfGtUVT3q/w++Yv4bIJjzuYGveCZK1GBV5Cu+mGIoSKE5r2ChG/9Mqx
         nEL4IWZcvTrNPnsVcC5HluZD64KVjJagiqDyq3ENqE72rchc91eHqNt4wzGbYNq+j1RB
         dojrxPfqJoBedIUPQ0tmK8B3jTWaywVBi0ySBAV7bkzfEVLBL5o+iYQ75jqd5V9DE2Zp
         juiA==
X-Gm-Message-State: AOJu0YyzJurjKXir7ql7oy+Oy0a/qzIG93ORURKYaQ9htasONk0nFr/5
	YIzfDzRvDzgjvHDDkLJeA3MFuxavPyOLTdhDVUpHqgT6WZGZ6xOaTlyGYkis
X-Google-Smtp-Source: AGHT+IGjz/68mYSyv1rVd46kmm6hof3+zezv3zlDpsp79fkvTw8MTyP1QCQ5HJMOIGbneD3zglr+wg==
X-Received: by 2002:a05:6512:b0d:b0:52c:f3fa:86c with SMTP id 2adb3069b0e04-52cf3fa14famr4916294e87.18.1719409189494;
        Wed, 26 Jun 2024 06:39:49 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:ce:f2f0:2a6b:35ff:feb8:77d9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c7befsm15802533f8f.95.2024.06.26.06.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:39:47 -0700 (PDT)
From: "=?UTF-8?q?Ga=C3=ABl=20PORTAY?=" <gael.portay@gmail.com>
X-Google-Original-From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@rtone.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: gael.portay+yocto@gmail.com,
	=?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@rtone.fr>
Subject: [meta-security,kirkstone][PATCH 1/5] sssd: fix missing python3.X-config script
Date: Wed, 26 Jun 2024 15:39:09 +0200
Message-ID: <20240626133913.790145-2-gael.portay@rtone.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626133913.790145-1-gael.portay@rtone.fr>
References: <20240626133913.790145-1-gael.portay@rtone.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Jun 2024 13:40:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/375

The configure script checks for the utility python3.X-config to be in
$PATH; that script is shipped by the package python3-native.

The recipe does not depend on the package python3-native which causes
the task do_configure to fail.

The recipe inherits from the bbclass python3-dir that does not install
the required script to the sysroot. The bbclass python3native inherits
from (the already inherited bbclass) python3-dir and it adds the missing
dependency to python3-native.

This fixes the configure error by "upgrading" the inherit bbclass from
python3-dir to python3-native.

Fixes:

	| checking for python3.10-config... no
	| configure: error:
	| The program python3.10-config was not found in search path.
	| Please ensure that it is installed and its directory is included in the search
	| path. If you want to build sssd without python3 bindings then specify
	| --without-python3-bindings when running configure.
	| NOTE: The following config.log files may provide further information.

Signed-off-by: Gaël PORTAY <gael.portay@rtone.fr>
---
 recipes-security/sssd/sssd_2.5.2.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-security/sssd/sssd_2.5.2.bb b/recipes-security/sssd/sssd_2.5.2.bb
index c07559c..fe82452 100644
--- a/recipes-security/sssd/sssd_2.5.2.bb
+++ b/recipes-security/sssd/sssd_2.5.2.bb
@@ -33,7 +33,7 @@ CVE_CHECK_IGNORE += "\
     CVE-2018-16838 \
 "
 
-inherit autotools pkgconfig gettext python3-dir features_check systemd
+inherit autotools pkgconfig gettext python3native features_check systemd
 
 REQUIRED_DISTRO_FEATURES = "pam"
 
-- 
2.45.2


