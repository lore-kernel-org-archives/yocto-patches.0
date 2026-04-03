Return-Path: <halstead@happypunch.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34371E88D6A
	for <webhook@archiver.kernel.org>; Fri,  3 Apr 2026 21:39:44 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5605.1775252379899138422
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 03 Apr 2026 14:39:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@happypunch.com header.s=google header.b=XSiwearu;
 spf=pass (domain: happypunch.com, ip: 209.85.214.182, mailfrom: halstead@happypunch.com)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so19924735ad.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 14:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=happypunch.com; s=google; t=1775252379; x=1775857179; darn=lists.yoctoproject.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Nak8hsIIOxYL8u7q56lLvPhDqj56Q7wphH3dpI+Ft4=;
        b=XSiwearu0e1FYRZ0mlws1ZS0+zJhPUWO+uywfpgvsQfh8U8wtiWxO/d29t6q77ea4N
         ur4oS0cpwU7bQQMjOIkEiBwOrdKmG8LQplPtJG2CD/F68VwXnDfuKABPRpdA0SwTHcbG
         BixRaQ3MqaHG8wYG1Agqq4yANFTMFHG4V04zA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775252379; x=1775857179;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5Nak8hsIIOxYL8u7q56lLvPhDqj56Q7wphH3dpI+Ft4=;
        b=UGBSO0EAFfYTgmFQwJiy7NWkocqwRDst9uoXrBlGU4nL0+WcfWY9vnKIGGlJdrjSNc
         sQCy/hVYutfP3B8iyrZ3n0P0AwdXKCrJL9i/Kr0vMeUnciR/w+CtCFi6e3pWCkeia8JF
         flmHbiHiaCkC2uX4KTIwB30sqSUIsLnK+etkflt/0shWjmQyEyo2b9tsrSLSOpsNX5CI
         1m6ZBmJtm/BZprVorgv+qUeC3gwtXjhjRusW36149vqtm44R9owAz0bjK0k2MegTqYME
         q+W0D7yuCufV8HPLCnmLMDXCRVK3jMIl/kESOUpZDSfH3QWZvkWXF+hXfC2Tz1KLm9oE
         5QUA==
X-Gm-Message-State: AOJu0YzopXkcpgFOrLqpQP/oODnf864/311TXIQ+CzxPmtRhcWzNOjMP
	CwhAUW8WnY/liojvg2hp2/XnySfz3gtG/qul3SWH22axCTpbizZLR9Rl1SkAwr0cVNzKOdp3EYy
	yRkiVsA==
X-Gm-Gg: AeBDieuWeA/siD0Rco6Gm3jSvikb7jfw7EqM16Ig28ZH2RhxRH38+xlFD/Fqq4Xuuap
	/Ztg5dMJTUm5YHG6wciqQnFaK85AZLvYTR01CXqZwpFX26JfCutMBILvZiwz1hhzVpOH4ibjXy6
	Mycq22+rsyEyZigV1UGZfvJPd/qiYbaLdMVrD4o77w9xqmXHLitYh2MpMJEE5R+uFowlRfN1Nhe
	kzD6r8ZUDhWahXH0O/NP3ko1L1VMwvDPUhwaRuYPBdms1505bLbG7RkBJ1J2O//mFkiGmCpy9yj
	p/vuyPm9RSgbCtIXzKkNTZSOV9HZ5RbOg7Acgxfdoiw25ONA5BFookvG2PZIhUBB4Vs9sQo1QYc
	14iNp57G4Y1fsTubC+M/AGAsPNFCOAc0TIXrCZvLVGw8sFyeNT+NqucHhdILG41tZXnI19/J88a
	DPewuJhBJGvaZSEkjrhuGugWakHtaGzUfi
X-Received: by 2002:a17:902:c405:b0:2b2:549f:7d2b with SMTP id d9443c01a7336-2b2816c2d9bmr48454285ad.11.1775252379107;
        Fri, 03 Apr 2026 14:39:39 -0700 (PDT)
Received: from [192.168.0.122] ([2a02:6ea0:d802:6232::23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a2e42sm61963335ad.56.2026.04.03.14.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 14:39:38 -0700 (PDT)
From: Michael Halstead <halstead@happypunch.com>
X-Google-Original-From: Michael Halstead <mhalstead@linuxfoundation.org>
Date: Fri, 03 Apr 2026 14:39:21 -0700
Subject: [yocto-autobuilder-helper PATCH 1/2] janitor/ab-janitor: handle
 invalid pidfile data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-contrib-halstead-ab-janitor-v1-1-91b4bb47c0d7@linuxfoundation.org>
References: <20260403-contrib-halstead-ab-janitor-v1-0-91b4bb47c0d7@linuxfoundation.org>
In-Reply-To: <20260403-contrib-halstead-ab-janitor-v1-0-91b4bb47c0d7@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Michael Halstead <mhalstead@linuxfoundation.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2396;
 i=mhalstead@linuxfoundation.org; h=from:subject:message-id;
 bh=Wbx73qdoamqFLF9EZNXxykbx/hYalhQPZgXirW5W+7o=;
 b=owGbwMvMwCXmG1QSm3K4rprxtFoSQ+YF4xlaGjaH/1j/Sc/vL1WV2xt70sVyv1LRX46SaRay1
 w5zGdV1lLIwiHExyIopsuhe0o5JfBerMVnLLBVmDisTyBAGLk4BmIjSfIb/URbvMwzc701Zta5d
 +e65EyKmmyfsa+Z4rpL3tjeX23nHF4b/pds1Nqffy8kzdOX7ZHbEcsfRG9pslf+5l7KWakw8Utf
 NAQA=
X-Developer-Key: i=mhalstead@linuxfoundation.org; a=openpgp;
 fpr=D1F2407285E571ED12A407A73373170601861969
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 21:39:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3638

Prevent stuck ab-janitor.service units by handling bad pidfile data.
Improve the exit logic for existing processes.

Signed-off-by: Michael Halstead <mhalstead@linuxfoundation.org>
---
 janitor/ab-janitor | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/janitor/ab-janitor b/janitor/ab-janitor
index 57749d6..281d7b9 100755
--- a/janitor/ab-janitor
+++ b/janitor/ab-janitor
@@ -78,25 +78,35 @@ def mirror_processor(mirrordir):
         time.sleep(30*60) # 30 minutes
     return
 
-#Check to see if this is running already. If so, kill it and rerun
+# Check to see if this is running already. If so, kill it and rerun
 if os.path.exists(tmpfile) and os.path.isfile(tmpfile):
     print("A prior PID file exists. Attempting to kill.")
     with open(tmpfile, 'r') as f:
-        pid=f.readline()
+        pid_str = f.readline().strip()
     try:
-        os.kill(int(pid), signal.SIGKILL)
-        # We need to sleep for a second or two just to give the SIGKILL time
-        time.sleep(2)
-    except OSError as ex:
-        print("""We weren't able to kill the prior buildworker-janitor. Trying again.""")
-        pass
-    # Check if the process that we killed is alive.
-    try:
-       os.kill(int(pid), 0)
-    except OSError as ex:
-       pass
+        pid = int(pid_str)
+    except ValueError:
+        print("PID file contains invalid data, ignoring.")
+        pid = None
+    if pid is not None:
+        # Check if the process is actually running before trying to kill it
+        try:
+            os.kill(pid, 0)
+        except OSError:
+            print("Prior process (PID %d) is not running, skipping kill." % pid)
+            pid = None
+    if pid is not None:
+        os.kill(pid, signal.SIGTERM)
+        for _ in range(10):
+            time.sleep(1)
+            try:
+                os.kill(pid, 0)
+            except OSError:
+                break
+        else:
+            print("Process %d did not exit after SIGTERM, giving up." % pid)
 elif os.path.exists(tmpfile) and not os.path.isfile(tmpfile):
-    raise Exception("""/tmp/.buildworker-janitor is a director. remove it to continue.""")
+    raise Exception("/tmp/.buildworker-janitor is a directory. remove it to continue.")
 try:
     os.unlink(tmpfile)
 except:

-- 
2.53.0


