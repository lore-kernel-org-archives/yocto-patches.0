Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103DFF30271
	for <webhook@archiver.kernel.org>; Sun, 15 Mar 2026 14:26:44 +0000 (UTC)
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.28143.1773578754971352584
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Mar 2026 05:45:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@cisco.com header.s=iport01 header.b=J8qmMEg+;
 spf=pass (domain: cisco.com, ip: 173.37.142.88, mailfrom: deeratho@cisco.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=891; q=dns/txt;
  s=iport01; t=1773578755; x=1774788355;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Vu73CS7UiRvb+/W3b1nZG3c8v5yTNlKrktwb/O7SNdU=;
  b=J8qmMEg+R2TN9yotrAKVlESOpHjHh8GnwHhZXmBNYTU+JvUbY2i3c6HM
   nAh2sOsH37scplABfHEYs6QdJVZ/RKKN7m6QxJV5CMOCnGpMmfGCCcWRU
   4fklCR3TnKeWwQ4ATcAtqY5dPq+NGGeEKein8bWt8FKDDpgCLTuUOkOqs
   /DtEIMOMdmuFAZ/InOZr7N/Z8254JcbiZaghHLATUFFyz4fM+MJ6JQrmV
   Ybc2o2vtML53QtCjj958w4lCJVd57bhDO6r3P9HzyftjQ4u0FkNbfRXjI
   0Sso+afg+LKVmMdLUYx6qfT4RX5o73RReaC/I9GTTDPD2vNgUqwXD23Ic
   A==;
X-CSE-ConnectionGUID: S8yjlNzpQ8i1WRXzgVj86g==
X-CSE-MsgGUID: sBC5BoraRrCN6uhJ2iq75g==
X-IPAS-Result: =?us-ascii?q?A0CuBQBWqbZp/4//Ja1aglmCSA9xX0JJlCqCJJ4agX8PA?=
 =?us-ascii?q?QEBDzcaBAEBhQcCjSICJjUIDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBA?=
 =?us-ascii?q?QECAQcFgQ4ThlyGWwIBAzIBViAxKysZgwIBgnMCAbF5giyBAYR82yYBCxQBg?=
 =?us-ascii?q?TiFPIgZdIR6JxsbgXKEB3aFEIV3BIIigQ6Bf5EtSIEeA1ksAVUTDQoLBwWBZ?=
 =?us-ascii?q?gM1EioVbjIdgSM+F4ELGwcFhRoPiHJ0bYETgy0DCxgNSBEsNxQbBD5uB416P?=
 =?us-ascii?q?YIzPoIYPykBKKV0oQ4KKIN0jB6VOhozqmuZBqRZhGiBaQE6gVlwFYMiCUkZD?=
 =?us-ascii?q?45fzHYjNT0CBwIHDQMLk2UBAQ?=
IronPort-Data: A9a23:dWUkwq5Z8/kHiMKnYZYWbQxRtG3GchMFZxGqfqrLsTDasY5as4F+v
 jNMD2+APauOYmPzeIggb4m28B4Av8Ldzd5kTgtuq3szZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyGa/lH2dOC98RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wo+KUzBHf/g2QqajlNtvrawP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4eBt0J+OJRE3l3p
 f1BFwo9fB+9hbLoz+fuIgVsrpxLwMjDJogTvDRkiDreF/tjGc6FSKTR7tge1zA17ixMNa+BP
 IxCNnw1MUmGOkEUUrsUIMpWcOOAinTyaTREqFW9rqss6G+Vxwt0uFToGISEJIXUHp4FxC50o
 Erd1U+kKBYAPeaF4hzb73KO3O7Wwn70Ddd6+LqQs6QCbEeo7n0UAwEREEOyvfK5h1WWX9NEN
 1dS6y0lsa8q7kupQ9LhGRqirxa5UgU0QdFcFag+rQqK0KeRu1jfDWkfRTkHY9sj3CMreQEXO
 payt4uBLVRSXHe9EBpxKp/8QeuOBBUo
IronPort-HdrOrdr: A9a23:ptJOLajlVkQ4QuL9aXkTUH3vPnBQXtsji2hC6mlwRA09TyX+rb
 HLoB1173HJYVoqNU3I3OrwW5VoIkmskKKdn7NxAV7KZmCP0wGVxcNZnOnfKlbbdBEWmNQw6U
 4ZSchD4BmaNykdsS48izPIdOod/A==
X-Talos-CUID: 9a23:SBNSqWA/yefUPXL6ExI35UwQPNI9Sy3clUjqE123N2Q5FrLAHA==
X-Talos-MUID: 9a23:N4T2aQTf89gCVd11RXT3rho/HsBy6p60I2ZTjJUk4cidanF/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,122,1770595200"; 
   d="scan'208";a="696163382"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by alln-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 15 Mar 2026 12:45:54 +0000
Received: from sjc-ads-3552.cisco.com (sjc-ads-3552.cisco.com [171.68.249.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTPS id F017918000486
	for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Mar 2026 12:45:53 +0000 (GMT)
Received: by sjc-ads-3552.cisco.com (Postfix, from userid 1795984)
	id 9F157CC12B5; Sun, 15 Mar 2026 05:45:53 -0700 (PDT)
From: "Deepak Rathore" <deeratho@cisco.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][master][PATCH 1/4] checkpolicy: extend SELinux tooling for nativesdk builds
Date: Sun, 15 Mar 2026 05:44:05 -0700
Message-Id: <20260315124408.2966368-2-deeratho@cisco.com>
X-Mailer: git-send-email 2.35.6
In-Reply-To: <20260315124408.2966368-1-deeratho@cisco.com>
References: <20260315124408.2966368-1-deeratho@cisco.com>
MIME-Version: 1.0
X-Outbound-SMTP-Client: 171.68.249.250, sjc-ads-3552.cisco.com
X-Outbound-Node: rcdn-l-core-06.cisco.com
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 15 Mar 2026 14:26:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3463

From: Deepak Rathore <deeratho@cisco.com>

Some SDK dependency chains require SELinux tools to be available as host/SDK
artifacts. The current recipes only partially provide this, which can lead to
dependency resolution failures when these tools are pulled into SDK-oriented
builds.

This change does not alter target package behavior; it only enables required
nativesdk variant for build and SDK integration paths.

Signed-off-by: Deepak Rathore <deeratho@cisco.com>

diff --git a/recipes-security/selinux/checkpolicy_3.10.bb b/recipes-security/selinux/checkpolicy_3.10.bb
index 7ee9269..55a5ba0 100644
--- a/recipes-security/selinux/checkpolicy_3.10.bb
+++ b/recipes-security/selinux/checkpolicy_3.10.bb
@@ -18,4 +18,4 @@ do_install:append() {
     install test/dispol ${D}/${bindir}/sedispol
 }
 
-BBCLASSEXTEND = "native"
+BBCLASSEXTEND = "native nativesdk"
-- 
2.35.6


