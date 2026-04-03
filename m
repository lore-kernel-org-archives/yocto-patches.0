Return-Path: <halstead@happypunch.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5B4E88D6D
	for <webhook@archiver.kernel.org>; Fri,  3 Apr 2026 21:39:44 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5580.1775252380805050381
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 03 Apr 2026 14:39:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@happypunch.com header.s=google header.b=Zdu4wUdp;
 spf=pass (domain: happypunch.com, ip: 209.85.216.49, mailfrom: halstead@happypunch.com)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so1885943a91.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 14:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=happypunch.com; s=google; t=1775252380; x=1775857180; darn=lists.yoctoproject.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0W+ZTQZcTn3ewf0y0qEsHWfCb42vuPpKyH3Hd3Ii6Ug=;
        b=Zdu4wUdp6/6lXly5jfg1VAWah2cg8ckuUhNzTTAatw2wYLht7HlaM/6SEwyFnX4sHU
         DDxe3Q3h+BuPQAJovK2wz8tpPOfFCmR1crawy7KabezebWkywPBzqMnqGvpD9JUznoil
         O/cFdBhhm1uh889lxKyvINSQfUM6DUhak1YBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775252380; x=1775857180;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0W+ZTQZcTn3ewf0y0qEsHWfCb42vuPpKyH3Hd3Ii6Ug=;
        b=FAG/RGXCtSLIN32h9+vV9LVrAUEaMfP3DKj3sDKqyXlpfLo+ASr+iiBsF/PkQjBExo
         r2McRuQbvab4LjRKfa4BlPMWdcMMRjp6rknCxUE5a9CMx+uVd/+owpQBdUhnRHC7a7IK
         MfznX+l1mReTzra8SM4Ohq1+KjpsjbHJx3bbPgtGjWyLAxM6BX/T+SUzozpnPjWmONij
         Tu/stBVfW1r18hD/XSa3CTRFb8N/muv9C1uF/yElEj8VrECLcZFcfSpY/uoz4yXDxmgZ
         T4rmHsA2nAnEiA5351iBiHEk4ppXNR1ynoL5Grd91x6WqR+oMyiF1qenhOzwEQSlUwHx
         SS1w==
X-Gm-Message-State: AOJu0Yy0fWJQ8jWEoSmIPS+MsVnknfj9bHGjD5kgTX0SuBzrvMb1bss7
	W0tJ/lpc71H7eqR3+qg0/h8oE5hD60AFH0ImA5IVsnlnt1MAgalP3HjMumjvMkn2hAtNNUNQfQt
	jwx+1Gw==
X-Gm-Gg: AeBDieuzKLoGrt3kKVmhuKwunx7idQv3a62xj/FxI+SSF97UjOu+awkPV1rTBSaiBo4
	CgsRquiermXY0aIZYDZzoIyVBxoRzxUUOQ5gW8z34G8piSs3MJS8V4iNdwtynjBNwL2eXe/fiIl
	wN23rIrWuVXzKEgHfhU2tstZ+ZZdgS+I+V/w4FP6AzIhrb5XNL8mefYwcnE8ZEuiH9edOwDbndH
	hf72n5oFKPQVDALgnSO2Ij5TA47PNqjYk/7C4sYUSndnvzKip7mPOL9h3AaoaNpuyCHg2+gkuH/
	dHaopOypMJ6LUllfUWzimsAv+qz/LvgqiwwRWMVJqwAbODvKIxVMXObzg4Mwge9dHAYUIEH/4kG
	VdJzmbIi5Y0HhNqx/p2h5jv70jf/+VdGUjyIohIQr6I5WbV9NDtZc6KWMS6JAj8Q8SGJ8wg3g5I
	ZvEVIX6frswPDvTDZPCM6ijQ==
X-Received: by 2002:a17:902:7618:b0:2b2:81aa:f6c3 with SMTP id d9443c01a7336-2b281aaf76amr28912285ad.29.1775252379895;
        Fri, 03 Apr 2026 14:39:39 -0700 (PDT)
Received: from [192.168.0.122] ([2a02:6ea0:d802:6232::23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a2e42sm61963335ad.56.2026.04.03.14.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 14:39:39 -0700 (PDT)
From: Michael Halstead <halstead@happypunch.com>
X-Google-Original-From: Michael Halstead <mhalstead@linuxfoundation.org>
Date: Fri, 03 Apr 2026 14:39:22 -0700
Subject: [yocto-autobuilder-helper PATCH 2/2] janitor/ab-janitor: modernize
 calls and minor cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-contrib-halstead-ab-janitor-v1-2-91b4bb47c0d7@linuxfoundation.org>
References: <20260403-contrib-halstead-ab-janitor-v1-0-91b4bb47c0d7@linuxfoundation.org>
In-Reply-To: <20260403-contrib-halstead-ab-janitor-v1-0-91b4bb47c0d7@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Michael Halstead <mhalstead@linuxfoundation.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4219;
 i=mhalstead@linuxfoundation.org; h=from:subject:message-id;
 bh=A++zUP5d7tqySiOFj8WANIq+KaCVsVGTPQ83nqHhusM=;
 b=owGbwMvMwCXmG1QSm3K4rprxtFoSQ+YF4xnv3D/MeW/V8Knbx3fpxdsr/yfmPJFk0TR/pJbk2
 nV/rm58RykLgxgXg6yYIovuJe2YxHexGpO1zFJh5rAygQxh4OIUgInM52b4Z9Do7tdSMdFE9H7Z
 LdZZHROyl77Y9O+xxv7IJWfuaZlq8jMyXDmUt8D1t2S2TlbQQq87535en1TevXVl9Pp1HAWcKSZ
 RDAA=
X-Developer-Key: i=mhalstead@linuxfoundation.org; a=openpgp;
 fpr=D1F2407285E571ED12A407A73373170601861969
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 21:39:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3639

Replaced bare exceptions, fixed variable shadowing, and removed
unreachable code. Corrected time in comment. Normalized spacing
and simplified string formatting.

Signed-off-by: Michael Halstead <mhalstead@linuxfoundation.org>
---
 janitor/ab-janitor | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/janitor/ab-janitor b/janitor/ab-janitor
index 281d7b9..16a4d57 100755
--- a/janitor/ab-janitor
+++ b/janitor/ab-janitor
@@ -7,11 +7,12 @@
 
 import signal
 import os
+import subprocess
 import sys
 import threading
 import time
 
-tmpfile = '/tmp/.buildworker-janitor'+os.getcwd().replace('/', '-')
+tmpfile = '/tmp/.buildworker-janitor' + os.getcwd().replace('/', '-')
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'scripts'))
 
@@ -19,8 +20,6 @@ import utils
 
 ourconfig = utils.loadconfig()
 
-
-
 trashdir = utils.getconfig("TRASH_DIR", ourconfig)
 mirrordir = utils.getconfig("REPO_STASH_DIR", ourconfig)
 
@@ -41,22 +40,21 @@ def trash_processor(trashdir):
         return
     while True:
         try:
-            files = os.listdir(trashdir)
-            if files:
-                for file in files:
-                    file_path = trashdir + "/" + file
-                    file_age = time.time() - os.path.getmtime(file_path)
+            entries = os.listdir(trashdir)
+            if entries:
+                for entry in entries:
+                    entry_path = os.path.join(trashdir, entry)
+                    file_age = time.time() - os.path.getmtime(entry_path)
                     if file_age >= 60:
-                        os.system("nice -n 10 ionice -c 3 rm %s -rf" % file_path)
+                        subprocess.run(["nice", "-n", "10", "ionice", "-c", "3",
+                                        "rm", "-rf", entry_path])
                     else:
-                        print("Not removing '%s' - age is only %s seconds. There may be another process using it" % (file_path, str(int(file_age))))
+                        print("Not removing '%s' - age is only %d seconds. There may be another process using it" % (entry_path, int(file_age)))
             else:
-                time.sleep(120*60) # 30 minutes
+                time.sleep(120 * 60) # 2 hours
         except Exception as e:
             print("Exception %s in trash cleaner" % str(e))
-            pass
-        time.sleep(60) # 1 minute timeout to prevent crazy looping (particularly in age is only)
-    return
+        time.sleep(60) # 1 minute timeout to prevent crazy looping
 
 def mirror_processor(mirrordir):
     print("Updating mirrors in %s" % mirrordir)
@@ -65,18 +63,16 @@ def mirror_processor(mirrordir):
         mirror = ourconfig["repo-defaults"][repo]["url"]
         mirrorpath = os.path.join(mirrordir, repo)
         mirrorpaths.append(mirrorpath)
-        while not os.path.exists(mirrorpath + "/refs"):
-            exit_code = os.system("git clone --bare --mirror %s %s" % (mirror, mirrorpath))
-            if exit_code == 0:
+        while not os.path.exists(os.path.join(mirrorpath, "refs")):
+            result = subprocess.run(["git", "clone", "--bare", "--mirror", mirror, mirrorpath])
+            if result.returncode == 0:
                 break
             print("Failed to clone %s. Retrying in 30 seconds..." % mirror)
             time.sleep(30)
     while True:
         for path in mirrorpaths:
-            os.chdir(path)
-            os.system("git fetch --prune --all")
-        time.sleep(30*60) # 30 minutes
-    return
+            subprocess.run(["git", "fetch", "--prune", "--all"], cwd=path)
+        time.sleep(30 * 60) # 30 minutes
 
 # Check to see if this is running already. If so, kill it and rerun
 if os.path.exists(tmpfile) and os.path.isfile(tmpfile):
@@ -109,7 +105,7 @@ elif os.path.exists(tmpfile) and not os.path.isfile(tmpfile):
     raise Exception("/tmp/.buildworker-janitor is a directory. remove it to continue.")
 try:
     os.unlink(tmpfile)
-except:
+except Exception:
     pass
 with open(tmpfile, 'w') as f:
     print(os.getpid(), file=f)

-- 
2.53.0


