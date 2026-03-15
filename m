Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5DCF30275
	for <webhook@archiver.kernel.org>; Sun, 15 Mar 2026 14:26:44 +0000 (UTC)
Received: from alln-iport-4.cisco.com (alln-iport-4.cisco.com [173.37.142.91])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.27957.1773578782156525616
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Mar 2026 05:46:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@cisco.com header.s=iport01 header.b=X+cdWlQ6;
 spf=pass (domain: cisco.com, ip: 173.37.142.91, mailfrom: deeratho@cisco.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=902; q=dns/txt;
  s=iport01; t=1773578782; x=1774788382;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=IycMxAjIb2cCXB257cvjQaxSe6THKJyqZaGIeNfvef4=;
  b=X+cdWlQ6Bc1tenDo1G/2TsbPiMvsj6YHkEH3Fa2KmRw/qEIr8Y7VnpXB
   r0O+tHiWNS8x//CY0bwDtWekw7xHRLVzkkW/6PQjrfcJUsRXnCtVB5jeh
   CAiWWdSI5s9JaXhmOXb7jiULWQ55HXcscq7WfVm6JnZWVkoR1tfD238jk
   4r3+L8OvBIKdceJgKjCyQAcguyvk394oP+ShpxlMJu32BXQGL0uyaxw6U
   0TYsvhGIqkJDFCH9c4d59HAT56qKbM2+zIBRPYoZUHh2pSQRAf/HEiVBs
   PvVSWAF1X2OgPJSuqsOVulaYNlzoCj3TdeU6bAxQQROej7HY0q1fk2Y3H
   w==;
X-CSE-ConnectionGUID: oUegj6k0QYaqKXPhkAKvhw==
X-CSE-MsgGUID: C1vcYAnyRW2hpPnxuTjv0w==
X-IPAS-Result: =?us-ascii?q?A0CoBABWqbZp/43/Ja1aglmCSA9xX0JJlCqCIQOeGoF/D?=
 =?us-ascii?q?wEBAQ83GgQBAYUHAo0iAiY0CQ4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEFA?=
 =?us-ascii?q?QEBAgEHBYEOE4ZchlsCAQMyAVYgMSsrGYMCAYJzAgGxeYIsgQHgIgELFAGBO?=
 =?us-ascii?q?IU8iBl0hHonGxuBcoQHdoUQhXcEgiKBDoF/kS1IgR4DWSwBVRMNCgsHBYFmA?=
 =?us-ascii?q?zUSKhVuMh2BIz4XgQsbBwWFGg+IcnRtgRODLQMLGA1IESw3FBsEPm4HjXo9g?=
 =?us-ascii?q?jM+UoFGPykBKKV0oQ4KKIN0jB6VOhozqmuZBqRZhGiBaDyBWXAVgyIJSRkPj?=
 =?us-ascii?q?l/MdiM1PQIHAgcNAwuTZQEB?=
IronPort-Data: A9a23:RxzuWaikUs26wbeQLvGzjVsXX161NREKZh0ujC45NGQN5FlHY01je
 htvCDiEM/iIY2vweNhzYN6y/UJVscKDzdVqTQBs/3wxRSljpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FH1dOOn9SUgvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZeEULOZ82QsaDxMsPve8EoHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqUfx+t4Az9Nr
 cUpISkuXiiDhMuV3rKkH7wEasQLdKEHPasFsX1miDWcBvE8TNWbH+PB5MRT23E7gcUm8fT2P
 pVCL2EwKk6dPlsWZg5/5JEWxI9EglHzfjBCoU6VooI84nPYy0p6172F3N/9JI3SFZkMzh3Az
 o7A10+gHBorHdqO8wXf8mqUgP/SoSHlAJ1HQdVU8dYv2jV/3Fc7GRodSVz+ufClgU6zQPpbK
 lcI4Ww/qqMu81SxSdvwVAH+p2SL1iPwQPJKGOE8rQXIwa3O7kPBWi4PTyVKb5ots8peqSEW6
 2JlVujBXVRH2IB5g1rEnltIhVte4RQoEFI=
IronPort-HdrOrdr: A9a23:/B4D0KpWYiWW9tKXC98zeWMaV5oqeYIsimQD101hICG9Ffbo8/
 xG88506faZslsssTQb6LO90cq7MBbhHOBOgLX5VI3KNGKNhILrFvAB0WKI+VLd8kPFmtK1rZ
 0BT0C7Y+eAa2STSq3BkW6FL+o=
X-Talos-CUID: 9a23:i16XUmFc9CLskvBbqmJgyUMbGJ4mKkTsxW7zE3e4Ck9KVr2KHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AsBeUzg2iD87FCuaBMoP71JC1pjUjyP2wA3Ekl4Q?=
 =?us-ascii?q?8hJOELRR2KyqhjirvXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,122,1770595200"; 
   d="scan'208";a="690841830"
Received: from rcdn-l-core-04.cisco.com ([173.37.255.141])
  by alln-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 15 Mar 2026 12:46:21 +0000
Received: from sjc-ads-3552.cisco.com (sjc-ads-3552.cisco.com [171.68.249.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-04.cisco.com (Postfix) with ESMTPS id 40737180005DC
	for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Mar 2026 12:46:21 +0000 (GMT)
Received: by sjc-ads-3552.cisco.com (Postfix, from userid 1795984)
	id E1E1CCC12B5; Sun, 15 Mar 2026 05:46:20 -0700 (PDT)
From: "Deepak Rathore" <deeratho@cisco.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][master][PATCH 4/4] semodule-utils: extend SELinux tooling for nativesdk builds
Date: Sun, 15 Mar 2026 05:44:08 -0700
Message-Id: <20260315124408.2966368-5-deeratho@cisco.com>
X-Mailer: git-send-email 2.35.6
In-Reply-To: <20260315124408.2966368-1-deeratho@cisco.com>
References: <20260315124408.2966368-1-deeratho@cisco.com>
MIME-Version: 1.0
X-Outbound-SMTP-Client: 171.68.249.250, sjc-ads-3552.cisco.com
X-Outbound-Node: rcdn-l-core-04.cisco.com
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 15 Mar 2026 14:26:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3465

From: Deepak Rathore <deeratho@cisco.com>

Some SDK dependency chains require SELinux tools to be available as host/SDK
artifacts. The current recipes only partially provide this, which can lead to
dependency resolution failures when these tools are pulled into SDK-oriented
builds.

This change does not alter target package behavior; it only enables required
nativesdk variant for build and SDK integration paths.

Signed-off-by: Deepak Rathore <deeratho@cisco.com>

diff --git a/recipes-security/selinux/semodule-utils_3.10.bb b/recipes-security/selinux/semodule-utils_3.10.bb
index 2015811..e8095f8 100644
--- a/recipes-security/selinux/semodule-utils_3.10.bb
+++ b/recipes-security/selinux/semodule-utils_3.10.bb
@@ -23,4 +23,4 @@ FILES:${PN}-semodule-package = "\
         ${bindir}/semodule_unpackage \
 "
 
-BBCLASSEXTEND = "native"
+BBCLASSEXTEND = "native nativesdk"
-- 
2.35.6


