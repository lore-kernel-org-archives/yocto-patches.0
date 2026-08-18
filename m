Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE19C5DF81
	for <webhook@archiver.kernel.org>; Tue, 18 Aug 2026 15:55:33 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12253.1787068522666389344
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 18 Aug 2026 08:55:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FPNf3Ufk;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so7475025e9.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 18 Aug 2026 08:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787068521; x=1787673321; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yoy8OBNTD9gFi1fPZSTpf0a4TWdWQYUjJVcJQ5IC0AY=;
        b=FPNf3UfkD9ovuH4f7iWh6QbjJOw3xuTFJLOGgWiMVeu16xCoeOItkKkNItRBOkRkc1
         X1XTJr7SKi9ED9EDVvKkweEx998Hx5n5zD6vgR/7NMdMbUsIx8Pf/jxu8F5GfL47kbtN
         jNblttgu0Nqw2F3AhvOjSrC69wBRx2g2mWI4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787068521; x=1787673321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Yoy8OBNTD9gFi1fPZSTpf0a4TWdWQYUjJVcJQ5IC0AY=;
        b=pxqDPiwpz4JMymirKPp4R1xTvAN+em6zPDnQ43Xdl309q/8DGxmS0AZ1eZF0RdC6TD
         iMzCRLnkxmTRNMA6XAZG0gbGIYt6whka4Mx3xvho5aHZJA8Jgtt+iBbfbX7IhweJ6kqp
         S+dxvrEy3jUT9dmizl6mVqOm/rk+fDKFfK/kip5TXy3E4IwsMg2rNfT5N/B9URMrh9Tm
         QEuKeawa2AdB6W4FUKSXmv+ax/ueE/DRyru9n2QlwnOyGrtUndW4akt+AnGndfM3wlq2
         uzlm6CzIYsBsWw5EBarYVmkZw77XdSp3kIVhXRuH0yG1Lc7uPurjMvWrIaa6Ab12ZvFq
         m3ng==
X-Gm-Message-State: AOJu0Yy6P6mHXRbf1j6E4CFmkYkd3UDSGSVgPMy4DISToV8pp2w2149A
	iKwVg/cZ7/RqVAhIDHylbS8pEv4fACr3Iwye0kqRmu1MXz1NC/KUbTqiI+0oIcNXliXR9FDIaTA
	j1WjjfaM=
X-Gm-Gg: AR+sD10f7mr/dV920F3bCBl60Eaf7NbEV3vivHC87WSn9eirMltQOoOziHEtr8Zk+Mw
	o64+VxDNbJ9oiIUt4ZvygoZToLuWxs9PMwNhDVx0H4D89FtfSTugf3YfY4wPSrHwHxL0KQw1yyy
	RHB+61CU+zcfH7CzVrW7sOpb2xTeIMeevzJ/oKeTBNVoYiKtX0gyiFMxBPCSq+tGjn+HXCRRPS0
	UjmjNhcZBnF6VcVbmpP5vdTNfyO3bg44QlDfNepU0t8IM9qcPM9DzW5GEtcgrnt9Hdrvyc95Dik
	cHMo42Z+fFg2FhGWeIslBRANIhMtghrTKyz9wnEXGP8JYYoZL5uaDIz26JhgrTHmEC3QcpyCjJj
	mEcNPYg99WZFP2mj9Feq4SGYjJjzIrUvmwpbpkGcPcMfRI/9ve/Ot4lvUgNjGa4TESxZEHoMd2L
	F1viC3MfIqu4QpRLA2v1/QUftOHPDCXnyw11r3YKdRD664Ug3I+hHOf7s40xlMcDbMn4mZAuFAS
	dpurpGZ+FTRZAKkwg==
X-Received: by 2002:a05:600c:35d1:b0:499:a0a5:e13f with SMTP id 5b1f17b1804b1-499a2040313mr109864565e9.2.1787068520720;
        Tue, 18 Aug 2026 08:55:20 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ee4b:f6b4:d308:732d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999d0fb85csm187558845e9.11.2026.08.18.08.55.19
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 08:55:19 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] utils: Improve buildtools env parsing
Date: Tue, 18 Aug 2026 16:55:19 +0100
Message-ID: <20260818155519.278450-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 18 Aug 2026 15:55:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4672

The current env scripts have includes which the current parsing code can't
handle and we miss the variables defined there. Switch to a different method
where source the scripts and print the environment, then parse that back in
instead.

There are quite a few variables which can cause problems which we don't want
to touch so skip over the ones we know don't make sense and the buildtools
environment is unlikely to need/change.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/utils.py | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/scripts/utils.py b/scripts/utils.py
index 4858d34..ab33734 100644
--- a/scripts/utils.py
+++ b/scripts/utils.py
@@ -460,19 +460,27 @@ def enable_tools_tarball(btdir, name, env_glob="/environment-setup*"):
     btenv = glob.glob(btdir + env_glob)
     print("Using %s %s" % (name, btenv))
     # We either parse or wrap all our execution calls, rock and a hard place :(
-    with open(btenv[0], "r") as f:
-        for line in f.readlines():
-            if line.startswith("export "):
-                line = line.strip().split(" ", 1)[1].split("=", 1)
-                if "$PATH" in line[1]:
-                    line[1] = line[1].replace("$PATH", os.environ["PATH"])
-                if line[1].startswith(("'", '"')):
-                    line[1] = line[1][1:-1]
-                os.environ[line[0]] = line[1]
-            elif line.startswith("unset "):
-                line = line.strip().split(" ", 1)[1]
-                if line in os.environ:
-                    del os.environ[line]
+    # Run the environment script, dump the output and parse back in.
+    output = subprocess.check_output(". %s; set" % btenv[0], shell=True, text=True)
+    skip = ['_', 'SHELL', 'OLDPWD', 'PWD', 'TERM', 'PS4', 'USER', 'SHELLOPTS', 'IFS', 'EUID', 'UID', 'HOME', 'SHLVL', 'DIRSTACK', 'OPTERR', 'OPTIND', 'PIPESTATUS', 'PPID', 'GROUPS', 'POSIXLY_CORRECT']
+    env = {}
+    for line in output.splitlines():
+        if "=" not in line:
+             continue
+        key, val = line.split("=", 1)
+        if key in skip:
+            continue
+        if key.startswith("BASH"):
+            continue
+        if val[0] == "'" and val[-1] == "'":
+            val = val[1:-1]
+        env[key] = val
+    for key in os.environ:
+        if key not in env and key not in skip:
+            del os.environ[key]
+
+    for key in env:
+        os.environ[key] = env[key]
 
 # Unlike buildtools (a host/worker property, keyed by worker name globs),
 # the vcontainer-tarball is only needed by specific jobs (e.g.

