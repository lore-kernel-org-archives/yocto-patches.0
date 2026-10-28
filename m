Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.38967.1793179981384199286
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Oct 2026 02:33:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=gouravsingh@siemens.com header.s=fm2 header.b=O31WgjmL;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1333022-20261028093257632d30397d00020708-_yyqhl@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20261028093257632d30397d00020708
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 28 Oct 2026 10:32:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=gouravsingh@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=7WENghepcnIb9VjZyB5LZ8kPbVRGQ8hfB/RvGrDXlI4=;
 b=O31WgjmLRiy9k6OIyqO2z5binXbtRAU/9fwGutl4kyQki87Uw8p26yERHISWFn6/V7jbOi
 RAIJyLcJU//ZQ5NCZ92PhIa0usvAiR6ndWVibtDT8V3f1aongfFHJGawxbklpziZYMPIol9a
 WxoHG8ldzpgrgg5Ws2+i7T1k3pSvdQEFuiofV4VqyHt/IwMlBAfjN2wJL1Tz/ZuFeLSdJrJx
 YNcHK32bEuhWF1QAKq6tOHzuQ+URzwC/Royn1/5A5DZD9nI9XhYNGKlRY0xgRIEBDWPSHDz4
 1W/RrHVH545FG+2pKu6AYaHU0UFdLYyxyX0fNr6RzeQSXmKCRzdeWOSw==;
From: Gourav Singh <gouravsingh@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com,
	Gourav Singh <gouravsingh@siemens.com>
Subject: [wic][PATCH] wic-plugins: use iso-level 3 in isohybrid plugins for >4GB files
Date: Wed, 28 Oct 2026 15:02:40 +0530
Message-Id: <20261028093240.614428-1-gouravsingh@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1333022:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Oct 2026 09:33:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5167
Content-Type: text/plain; charset="utf-8"

When creating an ISO image containing files larger than 4 GiB,
xorriso fails with:
  xorriso : FAILURE : File exceeds size limit of 4294967295 bytes
ISO-9660 Level 2 enforces a strict 4 GiB single-file limit. Bump
iso-level from 2 to 3 in both isoimage-isohybrid plugins. Level 3
enables multi-extent files, allowing individual files greater than
4 GiB while maintaining full compatibility with modern systems.

Signed-off-by: Gourav Singh <gouravsingh@siemens.com>
---
 src/wic/plugins/source/isoimage_isohybrid.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/wic/plugins/source/isoimage_isohybrid.py b/src/wic/plugins/source/isoimage_isohybrid.py
index 0a3ecd3..73a3902 100644
--- a/src/wic/plugins/source/isoimage_isohybrid.py
+++ b/src/wic/plugins/source/isoimage_isohybrid.py
@@ -419,7 +419,7 @@ class IsoImagePlugin(SourcePlugin):
 
         mkisofs_cmd = "mkisofs -V %s " % part.label
         mkisofs_cmd += "-o %s -U " % iso_img
-        mkisofs_cmd += "-J -joliet-long -r -iso-level 2 -b %s " % iso_bootimg
+        mkisofs_cmd += "-J -joliet-long -r -iso-level 3 -b %s " % iso_bootimg
         mkisofs_cmd += "-c %s -no-emul-boot -boot-load-size 4 " % iso_bootcat
         mkisofs_cmd += "-boot-info-table -eltorito-alt-boot "
         mkisofs_cmd += "-eltorito-platform 0xEF -eltorito-boot %s " % efi_img
-- 
2.39.5

