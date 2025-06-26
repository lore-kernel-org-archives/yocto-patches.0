Return-Path: <thune.a.tran@boeing.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E32C7EE33
	for <webhook@archiver.kernel.org>; Thu, 26 Jun 2025 20:58:21 +0000 (UTC)
Received: from clt-mbsout-01.mbs.boeing.net (clt-mbsout-01.mbs.boeing.net [130.76.144.162])
 by mx.groups.io with SMTP id smtpd.web11.6698.1750971498358606792
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Jun 2025 13:58:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@boeing.com header.s=boeing-s1912 header.b=I2gDOuvs;
 spf=pass (domain: boeing.com, ip: 130.76.144.162, mailfrom: thune.a.tran@boeing.com)
Received: from localhost (localhost [127.0.0.1])
	by clt-mbsout-01.mbs.boeing.net (8.15.2/8.15.2/DOWNSTREAM_MBSOUT) with SMTP id 55QKwE3D012872;
	Thu, 26 Jun 2025 16:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=boeing.com;
	s=boeing-s1912; t=1750971497;
	bh=OI1Nw2J4l5BRKCqWf2O9lRzBSte/YIc0NyNW/FkQ0HM=;
	h=From:To:Cc:Subject:Date:From;
	b=I2gDOuvsmfPU7Wpzvu9SKO25u186Fl8zcqpT/osUfwl9o6gotiC6VA/W1mJ3rgmmH
	 L19WJGfDkA88guwh8vNvnpvXubIMG+Y+T0J/5lG1PWOFiym+ITRAt6R+eLueHqG/wV
	 LAYKes+HZGMzVowq8bst5QAstp7Yik1Ppknooq9R36dJl15GEIAj15Q+92ZExb3hFp
	 +QLs6Wp2IY1xplrNaX5diaXzR9ZJXrMF0+x1D2zWoUD6JUEfRL9WE+EX803wvCr30r
	 6RiEYswEFvsdAuj8E1it5iDMJtXooq5WpC0VcmHijVL4H20J0ove+WwIf1RPyY5Lc8
	 iDbIDOEXNrjUw==
Received: from ewa-av-01.mbs.boeing.net (ewa-av-01.mbs.boeing.net [137.137.51.75])
	by clt-mbsout-01.mbs.boeing.net (8.15.2/8.15.2/8.15.2/UPSTREAM_MBSOUT) with ESMTPS id 55QKwBq1012858
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 16:58:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by ewa-av-01.mbs.boeing.net (8.15.2/8.15.2/DOWNSTREAM_RELAY) with SMTP id 55QKwAnw014135;
	Thu, 26 Jun 2025 13:58:10 -0700
Received: from A6360519.boeing.com (a6360519.nos.boeing.com [10.35.161.174])
	by ewa-av-01.mbs.boeing.net (8.15.2/8.15.2/UPSTREAM_RELAY) with ESMTP id 55QKw4Zo013752;
	Thu, 26 Jun 2025 13:58:04 -0700
From: Thune Tran <thune.a.tran@boeing.com>
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com, Thune Tran <thune.a.tran@boeing.com>
Subject: [meta-mingw][PATCH] mingw32-common: set TESTSDK_CASE_DIRS to sdkmingw
Date: Thu, 26 Jun 2025 20:58:02 +0000
Message-Id: <20250626205802.1341-1-thune.a.tran@boeing.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Jun 2025 20:58:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1703

Add TESTSDK_CASE_DIRS = "sdkmingw" for compatibility with the
simplified SDK test specification in openembedded-core.

Signed-off-by: Thune Tran <thune.a.tran@boeing.com>
---
 conf/machine-sdk/include/mingw32-common.inc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/conf/machine-sdk/include/mingw32-common.inc b/conf/machine-sdk/include/mingw32-common.inc
index 909fc06..56b8052 100644
--- a/conf/machine-sdk/include/mingw32-common.inc
+++ b/conf/machine-sdk/include/mingw32-common.inc
@@ -35,6 +35,9 @@ MACHINEOVERRIDES .= ":sdkmingw32"
 TESTSDK_CLASS_NAME = "oeqa.sdkmingw.testsdk.TestSDKMinGW"
 TESTSDKEXT_CLASS_NAME = ""
 
+# Directory that contains testcases
+TESTSDK_CASE_DIRS = "sdkmingw"
+
 WINDMC:mingw32 = "${HOST_PREFIX}windmc"
 WINDRES:mingw32 = "${HOST_PREFIX}windres --include-dir=${STAGING_INCDIR}"
 RC:mingw32 = "${WINDRES}"
-- 
2.34.1


