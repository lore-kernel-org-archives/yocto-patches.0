Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E91BF30273
	for <webhook@archiver.kernel.org>; Sun, 15 Mar 2026 14:26:44 +0000 (UTC)
Received: from alln-iport-8.cisco.com (alln-iport-8.cisco.com [173.37.142.95])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.28146.1773578758490099142
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Mar 2026 05:45:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@cisco.com header.s=iport01 header.b=bHv8zbJH;
 spf=pass (domain: cisco.com, ip: 173.37.142.95, mailfrom: deeratho@cisco.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=855; q=dns/txt;
  s=iport01; t=1773578758; x=1774788358;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ATOaFBFZsfNz/drkCNFy6I3WT/ATZau+aXZU2dGzbgk=;
  b=bHv8zbJHTimnLeyw1tSkulphT5SWB77LzqOCyEyxgjl2XHru5XQHPj9Q
   FveJiivttt7aCalPYnZrT/2b1pBPhFr0DLdotax331I0PNiwrB3+pyRAs
   84W37H1PvCs6KlmAs2Pj4L7CnlfrLKrVg08xNVhA8t3Pbubdvb2c+CWDH
   iWE+R9ocp0Sr34IV2hxLEa+z0rSGyLusnWiP93b2L4HBjV8k75nwDWt9V
   iCl08+mCuIeqSwYRTMjmGoEUkltq5M93tx0dFW2cBxGXgD/oQpym+njih
   YIAS7MOeLLfHHPDnIV/wHfnazNoUh7bKX65TEtdYXOt7yBwnZvVkze8Vo
   Q==;
X-CSE-ConnectionGUID: LNwmjAOdRvGrQEFrbtfX3Q==
X-CSE-MsgGUID: sNm8VWvdSLGyt76WSOq1DQ==
X-IPAS-Result: =?us-ascii?q?A0CnBABWqbZp/4r/Ja1aglmCSA9xX0JJlCqCJJ4agX8PA?=
 =?us-ascii?q?QEBDzcaBAEBhQcCjSICJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBA?=
 =?us-ascii?q?QECAQcFgQ4ThlyGWwIBAzIBViAxKysZgwIBgnMCAbF5giyBAYR82yYBCxQBg?=
 =?us-ascii?q?TiFPIgZdIR6JxsbgXKEB3aFEIV3BIIigQ6TLEiBHgNZLAFVEw0KCwcFgWYDN?=
 =?us-ascii?q?RIqFW4yHYEjPheBCxsHBYUaD4hydG2BE4MtAwsYDUgRLDcUGwQ+bgeNej2CM?=
 =?us-ascii?q?z6CGD8pASildKEOCiiDdIwelToaM6prmQakWYRogWg8gVlwFYMiCUkZD45fz?=
 =?us-ascii?q?HYjNT0BAQcCBw0DC4FokX0BAQ?=
IronPort-Data: A9a23:SzzjRqxh78mdtGHveLh6t+dixyrEfRIJ4+MujC+fZmUNrF6WrkUEn
 2ZOXjzUPfnYazT0Lox0OYq+9RlXscDUzNY1TVZkpFhgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlqCCea/VH1buSJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 4iaT/H3Ygf/hWYvaz9MsspvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE8NvK6X
 evK0Iai9Wrf+Ro3Yvv9+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+vpT2M4nVKtio27hc+adZ
 zl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CCe5xWuTpfi/xlhJGUQIoga08F7O39h7
 8U1BioHch6z3NvjldpXSsE07igiBNPgMIVavjRryivUSK5/B5vCWK7No9Rf2V/chOgXQq2YP
 JVfM2cyKk2bM3WjOX9PYH46tOuli2P2bz1fgFmUvqEwpWPUyWSd1ZCzYYOLK4LSGpo9ckCwv
 UTDr1rGHB0hEPOO1WXbzUmLn7bjpHauMG4VPPjinhJwu3WCwWcPD1gOXEewofSiokq/QM5Eb
 V0T8TYptbI19kGgUp/6RRLQnZKflgQXV9wVF6gx7xuAj/KNpQ2YHWMDCDVGbbTKqfMLeNDj7
 XfR9/uBONClmOT9pa61nltMkQ6PBA==
IronPort-HdrOrdr: A9a23:cJyC5q+afFHMzJuL/Qxuk+DZI+orL9Y04lQ7vn2ZLiYlFvBw+P
 rBoB1273LJYXMqKRIdcLO7Scy9qA3nlKKdiLN5VdzJYOClghrLEGgI1+TfKlPbdxEWjtQ86U
 +lGJIObuEZyjNB/KHH3DU=
X-Talos-CUID: 9a23:Cdyn1m4ekw6AI+eyn9ss0GgLH8IMVXHn0ljKGmKWE2x1Ro3OcArF
X-Talos-MUID: 9a23:A7GpSgj+Jhg1nJa7iOCLecMpL+Fts5qRFkw2tboXp5baChdXIm6xtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,122,1770595200"; 
   d="scan'208";a="691696077"
Received: from rcdn-l-core-01.cisco.com ([173.37.255.138])
  by alln-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 15 Mar 2026 12:45:57 +0000
Received: from sjc-ads-3552.cisco.com (sjc-ads-3552.cisco.com [171.68.249.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-01.cisco.com (Postfix) with ESMTPS id 838E4180001E8
	for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Mar 2026 12:45:57 +0000 (GMT)
Received: by sjc-ads-3552.cisco.com (Postfix, from userid 1795984)
	id 27C0CCC12B5; Sun, 15 Mar 2026 05:45:57 -0700 (PDT)
From: "Deepak Rathore" <deeratho@cisco.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][master][PATCH 2/4] libsepol: extend SELinux tooling for nativesdk builds
Date: Sun, 15 Mar 2026 05:44:06 -0700
Message-Id: <20260315124408.2966368-3-deeratho@cisco.com>
X-Mailer: git-send-email 2.35.6
In-Reply-To: <20260315124408.2966368-1-deeratho@cisco.com>
References: <20260315124408.2966368-1-deeratho@cisco.com>
MIME-Version: 1.0
X-Outbound-SMTP-Client: 171.68.249.250, sjc-ads-3552.cisco.com
X-Outbound-Node: rcdn-l-core-01.cisco.com
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 15 Mar 2026 14:26:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3464

From: Deepak Rathore <deeratho@cisco.com>

Some SDK dependency chains require SELinux tools to be available as host/SDK
artifacts. The current recipes only partially provide this, which can lead to
dependency resolution failures when these tools are pulled into SDK-oriented
builds.

This change does not alter target package behavior; it only enables required
nativesdk variant for build and SDK integration paths.

Signed-off-by: Deepak Rathore <deeratho@cisco.com>

diff --git a/recipes-security/selinux/libsepol_3.10.bb b/recipes-security/selinux/libsepol_3.10.bb
index 0423a2a..6cf4509 100644
--- a/recipes-security/selinux/libsepol_3.10.bb
+++ b/recipes-security/selinux/libsepol_3.10.bb
@@ -13,4 +13,4 @@ inherit lib_package
 
 DEPENDS = "flex-native"
 
-BBCLASSEXTEND = "native"
+BBCLASSEXTEND = "native nativesdk"
-- 
2.35.6


