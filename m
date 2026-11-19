Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14149.1795094389709785041
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 19 Nov 2026 05:19:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=SPHcKF1+;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 210EEC4CBF5;
	Thu, 19 Nov 2026 13:19:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D831360237;
	Thu, 19 Nov 2026 13:19:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 10D7E11BC0B86;
	Thu, 19 Nov 2026 14:19:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795094387; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3odTAjxlYFF0v8uV/PZ166xL4yYWm3vgotW1wwXcJz8=;
	b=SPHcKF1+nTcn5OwGnTYoWu70huk1ZyQqWck752IuAZuIma+Ex1kLHMjoRbrpKVH5oFl9sD
	a8W/g6FLEzsyW6mioHm7UrX966OZ1vPCA8l6ZBqXyG9rPhbcpDBFkFkA+j9G+NbENq2H3K
	M2JfTaC4Z6fDdomzPTPeHRAlF5rnkvATw7XdxxjIW0WAZwzrguRc/MvzfDkrZMSP2ejUhT
	dp1j11BVmmHqli+3PSXmsfoKbvuFbqCoqReCD5vxF6N7Dcu7AxufD9HtSQe4juhqMYlv2/
	yCa96bq09W6CwbJH5aZSnOvtRUwwayBUOLcRy27DRW8hyJhvhrcNBmeWwEdVJA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Thu, 19 Nov 2026 14:19:35 +0100
Subject: [PATCH yocto-autobuilder2 3/3] yocto_console_view: Fix CSS for
 buildbot 4.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-mathieu-buildbot-4-4-b4-v1-3-76774afaee1d@bootlin.com>
References: <20261119-mathieu-buildbot-4-4-b4-v1-0-76774afaee1d@bootlin.com>
In-Reply-To: <20261119-mathieu-buildbot-4-4-b4-v1-0-76774afaee1d@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Michael Halstead <mhalstead@linuxfoundation.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795094383; l=1539;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=4aVcekz4kS+aB7NFzEQbdvikSo08LHCVWOYpQYqkuaQ=;
 b=I2AN3VCdTqfIZfoaq21lieatq9gmrmxrz/VSwfEJXo9jmNhOLXlbA3TaVf9rxB9Ip3IaCQ5+m
 +4tq+q0R9VPB9MAzpUB0ufo+SWP45pZfxvHcg4ikNO6inQetGCBSMbz
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 19 Nov 2026 13:19:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5480

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 .../src/views/ConsoleView/ConsoleView.scss         | 29 ++++++++++++++++------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/yocto_console_view/src/views/ConsoleView/ConsoleView.scss b/yocto_console_view/src/views/ConsoleView/ConsoleView.scss
index 15dd3a61bcbd..3f693917f13c 100644
--- a/yocto_console_view/src/views/ConsoleView/ConsoleView.scss
+++ b/yocto_console_view/src/views/ConsoleView/ConsoleView.scss
@@ -55,32 +55,45 @@ div.form-group {
   div.col-sm-10 {
     display: inline-block;
     width: 80%;
+    vertical-align: middle;
   };
 
   label {
-    display: inline-block;
     width: 20%;
     font-weight: bold;
-    margin-bottom: 0;
-    top: .5em;
+    padding-right: .5em;
+    vertical-align: middle;
   }
 
   .control-label {
     text-align: right;
-    float: left;
   }
 
   div.col-sm-10.col-sm-offset-2 {
     width: 100%;
     max-width: 100%;
+    margin-left: 0;
+
     label {
-      width: 80%;
-      float: right;
-      padding-left: 8px;
+      display: grid;
+      grid-template-columns: 20% 1fr auto;
+      align-items: center;
+      width: 100%;
+      float: none;
+      padding-left: 0;
+
+      input[type="checkbox"] {
+        justify-self: end;
+        margin-right: .5em;
+      }
     }
-  };
+  }
 
   .row > div.col-sm-6 {
     margin-bottom: 5px;
   }
+
+  label.col-sm-10 {
+    text-align: right;
+  }
 };

-- 
2.47.3

