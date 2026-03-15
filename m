Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CB3F3026E
	for <webhook@archiver.kernel.org>; Sun, 15 Mar 2026 14:26:44 +0000 (UTC)
Received: from alln-iport-4.cisco.com (alln-iport-4.cisco.com [173.37.142.91])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.28191.1773579006240429328
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 15 Mar 2026 05:50:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@cisco.com header.s=iport01 header.b=HS0RWbjX;
 spf=pass (domain: cisco.com, ip: 173.37.142.91, mailfrom: deeratho@cisco.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=981; q=dns/txt;
  s=iport01; t=1773579006; x=1774788606;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yMAH80k6Mdyn6ZPsr3PuKgOCngPm9Oc0lrnEtZRUgR8=;
  b=HS0RWbjX0WHP9eXphMfwvQxDBrlHqW3wvJcZaHeOI0mZCtyTc/pP39ge
   gubO9eh4Xmy3g6wzFFXjh0pgA4rnSXdVmlooBEie/HWc666VpYDzuCfIn
   NnrEHi4eHm/22NVZzNH5EjbCpdmui/+xQCcM+cVxwBgeS2W2ljCwEGoR+
   yiRTSn/t2r0PcEV5120+WMF84YxW75GlZcKOs7IXqeH8XD7BelhN06DUC
   RIoweDrXDbo51UXbXBeh+iuGzH+xktjM8P0cTsS23KTgcHXrDBV7xSo6H
   8K/nlKmQrYwK+qvKk7xcVaZwqEqLsVfgLfsfaHhvlrOrgufWGiC9z299X
   A==;
X-CSE-ConnectionGUID: NRfSJoRLSHCkci3OS78GeA==
X-CSE-MsgGUID: YRZ0oXaES++n4MStj2KCMA==
X-IPAS-Result: =?us-ascii?q?A0BpCgDPqbZp/4//Ja1aglmCSA9xX0JJk1oBT6A+gX8PA?=
 =?us-ascii?q?QEBDzcaBAEBkisCJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECA?=
 =?us-ascii?q?QcFgQ4ThlyHCAsBdlxEgwIBgnMCAbF1gXkzgQGEfNsmAQsUAYE4hTyIGXSEe?=
 =?us-ascii?q?icbG4FyhAd2hRCFdwSCIoEOgX+RLUiBHgNZLAFVEw0KCwcFgWYDNRIqFW4yH?=
 =?us-ascii?q?YEjPheBCxsHBYUaD4hydG2BE4MtAwsYDUgRLDcUGwQ+bgeNej2CMz6CGD8pA?=
 =?us-ascii?q?SildKEOCiiDdIwelToaM6prmQakWYRogWg8gVlwFYMiCUkZD45fzHYjNT0CB?=
 =?us-ascii?q?wIHDQMLk2UBAQ?=
IronPort-Data: A9a23:sGOJoa9LLardNaLjGdvEDrUD1X+TJUtcMsCJ2f8bNWPcYEJGY0x3n
 2BOWG6AMvzeNjCgf9Egatix/E0FsZbdnNExTQU/pXhEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEDmE4EzrauS9xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4mpyyHjEAX9gWAsaTtJs/vrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dsamR
 /zOxa2O5WjQ+REgELuNyt4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5nXBYoUnq7vh3S9zxHJ
 HqhgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/wmWeG0YAzcmCA2kQB4Mj2OFNJVpu3
 v8TKWsqVU/TqO+flefTpulE3qzPLeHxN48Z/3UlxjbDALN+H9bIQr7B4plT2zJYasJmRKmFI
 ZFGL2AyMVKZP0Yn1lQ/UPrSmM+ki3TleiFYr3qepLE85C7YywkZPL3FbouNKoDQGJsI9qqej
 lP8zTz+Mhg3D5/cz2agyW6u3MzkuAquDer+E5X9rJaGmma712sYFBpTTVKnqvm0kWa6WslDM
 AoF/SEyqrAo806mRcW7WAe3yENopTYGUNZWVul/4waXx++MvUCSB3MPSXhKb9lOWNIKeAHGH
 2Shx7vBbQGDepXMIZ5B3t94dQ+PBBU=
IronPort-HdrOrdr: A9a23:1w1boqrayuHYS9Ak27SQMlcaV5o+eYIsimQD101hICG9Ffbo9f
 xG88506faZslsssRIb6LO90de7IE80nKQdieJ6AV7IZmbbUQWTQL2KlbGD/9UlcBeOktK0Es
 xbAs1DNOE=
X-Talos-CUID: =?us-ascii?q?9a23=3AmZ8BJmoOzY26aRxEapd+O7PmUeYffEb/y030GG+?=
 =?us-ascii?q?TCm1oE5quFg+/9Yoxxg=3D=3D?=
X-Talos-MUID: 9a23:YddXbgZp9/fCQeBThgXe3DZSPepToOeoVGU2jZdcmOKhHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,122,1770595200"; 
   d="scan'208";a="690842565"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by alln-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 15 Mar 2026 12:50:05 +0000
Received: from sjc-ads-3552.cisco.com (sjc-ads-3552.cisco.com [171.68.249.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTPS id 6FAF518000486
	for <yocto-patches@lists.yoctoproject.org>; Sun, 15 Mar 2026 12:50:05 +0000 (GMT)
Received: by sjc-ads-3552.cisco.com (Postfix, from userid 1795984)
	id 15C9ACC12B5; Sun, 15 Mar 2026 05:50:05 -0700 (PDT)
From: "Deepak Rathore" <deeratho@cisco.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][master][PATCH 3/4] selinux-python: extend SELinux tooling for native builds
Date: Sun, 15 Mar 2026 05:46:42 -0700
Message-Id: <20260315124642.2968859-1-deeratho@cisco.com>
X-Mailer: git-send-email 2.35.6
MIME-Version: 1.0
X-Outbound-SMTP-Client: 171.68.249.250, sjc-ads-3552.cisco.com
X-Outbound-Node: rcdn-l-core-06.cisco.com
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 15 Mar 2026 14:26:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3466

From: Deepak Rathore <deeratho@cisco.com>

Some SDK dependency chains require SELinux tools to be available as host/SDK
artifacts. The current recipes only partially provide this, which can lead to
dependency resolution failures when these tools are pulled into SDK-oriented
builds.

This change does not alter target package behavior; it only enables required
native variant for build and SDK integration paths.

Signed-off-by: Deepak Rathore <deeratho@cisco.com>
---
Changes from v1->v2: Added new line at the end of recipe.

diff --git a/recipes-security/selinux/selinux-python_3.10.bb b/recipes-security/selinux/selinux-python_3.10.bb
index 7a4b781..5756c6a 100644
--- a/recipes-security/selinux/selinux-python_3.10.bb
+++ b/recipes-security/selinux/selinux-python_3.10.bb
@@ -127,3 +127,4 @@ do_install() {
     sed -i -e 's,${WORKDIR},,g' \
         ${D}${PYTHON_SITEPACKAGES_DIR}/sepolicy-${PV}.dist-info/direct_url.json
 }
+BBCLASSEXTEND += "native"
-- 
2.35.6


