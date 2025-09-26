Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5589ECAC5B8
	for <webhook@archiver.kernel.org>; Fri, 26 Sep 2025 15:39:43 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.20520.1758901181239788622
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 26 Sep 2025 08:39:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gYYClT3w;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46b7bf21fceso17648815e9.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 26 Sep 2025 08:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758901179; x=1759505979; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nXPIx9fKx6zyhh/H4jMMKEPyC3w9VwzKc/FDOt7Oinc=;
        b=gYYClT3w/Pj6/00AXbszb9mcn1NSg26A55SBVJAr+0pDhsXW1afbY65tBKBGkfPf7q
         kir4mErNvdBEuVUIzgloAHzdKaVRFbqOJ8d+qGy5pwLHpaRhdCpOqxxsJ2/f2Vil3y1Q
         +hIu5o3OXHerR3WL3MQhWc5oGMiKbHzkRdM80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758901179; x=1759505979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nXPIx9fKx6zyhh/H4jMMKEPyC3w9VwzKc/FDOt7Oinc=;
        b=ZMJ8Ig3IIwYoIEJ79PNw5qc1tXk3uDn/HexteyYAchbjU+bcA8uGMwXIcAiS8Z+4q8
         3NcebWTUV/h/ryCp/fAezZvcIhff5PiTP3ZpLDOdxD2U7dHnMbZmugKfZXZhYR3r3KKW
         rEMNycrvMbkDVkYwUGGszsPguuS9OV1qjtfFhmRLZh7xvsI30mnsPhqH0DZhxQ6GGV7i
         AM2WAXQv0/b4ummTyLwEDhl60lWqtYdrwIkcuWTtmM9Ilsbl28f80n5bI43gHnPDNJxt
         r/2Jb7cNJf6SOOrC+Tv7spxXKPR4L9mdWH9+sSydWVhK6NH8r4PEN2VXSz3qotBhcloc
         zY/g==
X-Gm-Message-State: AOJu0Yy6uBdMSb/SweNEnbb+aJYKWdXUN224jsc272pxLWepFjwcNYkS
	MwhnLXghxzCJLTSF5/ob10x0YMmC1hUYWL+nBQ874xjkcJ68+be6J84Fss37vNcV3o/8/98wORn
	5Pf0I
X-Gm-Gg: ASbGnculzLzmvmgCH/Y21IOVg/KSO6P+eTYeqRF4ks0X+W/bORXHywTMzO8Gf5i4F9q
	5ekDpAQ8IxqMtVGIpoG91Uaxgt9nkm59LyRjkM6ZrgLqp9BO2oWbKPNdXMuZGqS0zNecgi+HYoW
	wEdYq6Uyg4I2/FXu56Rqca0Sdw6tnlzES6FcxiVXWwWGjIhVNA5rnuZJY/6v8lSJKixu0MlVNHw
	1OccY4c/dHtBaodtb4j0utjZftLIUlCyYKAMzFF2pDKDV6Eui8d8XuQ/a9C/IHaxzpfEfRCMF7S
	B5tcsAcXosGuz3I0ssSH4JYh8DowmlH/wa95xDEVGk4F+ZgTefBtV5+bT9ptvp/JTlyWmLSflz+
	zb5A1rA0RDKPjIIju4dYnm1C1fcux0KKV8P9qHaCMs8AA5czb7lU=
X-Google-Smtp-Source: AGHT+IHJcfGPGu8ZyYmKT0ynGGY+Q3SW4Xrrgu8l3D7BuDzf4LOIbQVTtXgJ/0ZflkKWApUMGv7TGg==
X-Received: by 2002:a05:600c:35d3:b0:46d:5846:df18 with SMTP id 5b1f17b1804b1-46e329bbf67mr93863465e9.15.1758901178609;
        Fri, 26 Sep 2025 08:39:38 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:8a7a:1fb6:e6df:2fa7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb6b7sm8093795f8f.2.2025.09.26.08.39.37
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 08:39:37 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] scripts/getproperties.py: Add script to return revision/branch information
Date: Fri, 26 Sep 2025 16:39:36 +0100
Message-ID: <20250926153936.24324-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 26 Sep 2025 15:39:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2235

Rather than calling git commands directly, put these into a script so that
different branches of the helper can handle returning this information in
different ways and from different sources.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/getproperties.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100755 scripts/getproperties.py

diff --git a/scripts/getproperties.py b/scripts/getproperties.py
new file mode 100755
index 0000000..5f396a9
--- /dev/null
+++ b/scripts/getproperties.py
@@ -0,0 +1,15 @@
+#!/usr/bin/env python3
+
+import json
+import subprocess
+import sys
+
+builddir = sys.argv[1]
+
+jsonprops = {}
+jsonprops['yp_build_revision'] =  subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=builddir).decode('utf-8').strip()
+jsonprops['yp_build_branch'] = subprocess.check_output(["git", "rev-parse", "--abbrev-ref", "HEAD"], cwd=builddir).decode('utf-8').strip()
+
+print(json.dumps(jsonprops, indent=4, sort_keys=True))
+
+

