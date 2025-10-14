Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C52DCCD187
	for <webhook@archiver.kernel.org>; Tue, 14 Oct 2025 10:23:59 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web11.12008.1760437429267933747
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 14 Oct 2025 03:23:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=V8kLSHAY;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-41174604d88so2326084f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 14 Oct 2025 03:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760437427; x=1761042227; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CGhLmae51waANxHOf+H6pFKKInFwA/TOtKnJiVU2LxU=;
        b=V8kLSHAYCM3Z2TrFZJdTXkTZOGAo3suBOa/KU3sYX5xy1+u1h5jAzx3xPaQ7iNEk6O
         l2g/RlOWlMToagFYppaSh5BKciIflP+c4R7p91IAsyR6bFnWKh6aPh95jQyEn5RpEyy6
         I97Bv7hKhRlnFxkzQj/N4yp8ijgK6FP4j5Fnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760437427; x=1761042227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGhLmae51waANxHOf+H6pFKKInFwA/TOtKnJiVU2LxU=;
        b=lZsaEkPcfqFSOyWqkM+4cks0rCtO2rERyo0FX5ugV8LGtE2fAJWClKZVhnj9McZtF3
         rQIngBiKK3qMqbC69ia+m/BuKh/Eu/yT5sQnYY+ssSqfofCLxNe4TGE94nafEMub9RkP
         +XPPXLbPlAXVakacdGMqXSdBBb+nTOwh5GcAoLwOSKralkgeVrQLBa6dk210wEg3x4Ks
         51Kby3JFu1l3Sbhq1enhYaZY5lFvzvfsHq8pDNNtLuEo9P83Un5iXbWHGw69QCia9Iud
         vav1ViAFA/FKrB35SLcnqYdtFAjdeqXUbgjqmxPq1uwT3fEggynbBfGnUBZnLyqb58tj
         bTdw==
X-Gm-Message-State: AOJu0YzmiOAacBgS+3N3jPGBDAayEGaN+24qLcfaT5p+coLRIVXurs1d
	rkJpEa1OOo5dm4hWtXltns0hzEKqyh04Yzz4oIc/sJCH7hI6sBrZwAJWGR0IIw2+audG3a0FEFs
	kn8IQ
X-Gm-Gg: ASbGnctC1KBOPMxnOMGL54V9JLug9Hyj3AzefrWVwCQN5nEkr+4GYRYaMxTaZoog1Ou
	C3ogm2KoE451hXTmHqOazIo5IC+tzvIGJm8sqWZ9ZMvWHl2SEUdvuUZhLuFgAwqfom8+4nSNJzi
	3sDsz7quJHSe3nG5umJ4P588g+VO7Iyk+yXTWQ74ZfJy6ec0ip31Jc1hSNK/THhywt3eUkemzVl
	mTXT3Jxg54Oyt6sWTS4DRkIyyD48Ga4AfP1gYSWAqK5fmbYAB8P3vb/kYwGa6nIttOvzEU4ZQvE
	CVbM3rsU2LL+nJAbRd0PhxwCcTLSEi6JCjU2mimEb2q1nhGrqJJZ0qx7lWTTB+IvIAGDVt9D8Qs
	BQQvZ6tzA6RoXsNcYXatiOV/4IcSNAwKbbu7YeswygM9EnGbxYpNLudmJtLDVUtT5/sET
X-Google-Smtp-Source: AGHT+IExLNzbJFxZJThbolS+zyskXIvAWbQLTb7IrYDxO3lPzwr4enBHZlLYO+3sUC/Vw6NApxmPlQ==
X-Received: by 2002:a05:6000:1888:b0:401:c52f:62de with SMTP id ffacd0b85a97d-42666ac39fdmr14133064f8f.12.1760437426911;
        Tue, 14 Oct 2025 03:23:46 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:2ac0:755:9ed5:f113])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb49bdfd0sm233715225e9.10.2025.10.14.03.23.46
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:23:46 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH 2/2] scripts/getproperties: Update to return all revisions/branches and compute build_revision
Date: Tue, 14 Oct 2025 11:23:44 +0100
Message-ID: <20251014102344.645363-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251014102344.645363-1-richard.purdie@linuxfoundation.org>
References: <20251014102344.645363-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 14 Oct 2025 10:23:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2301

Now that bitbake-setup is fetching the layers, we need to report back the revisions
fetched back to buildbot. We can do this by sharing extra properties back
to the controller from this script.

The buildbot UI needs a way to group the "same" builds together. Compute a dummy
sha1 hash of the bitbake/oecore/helper revisions to do that which can be used in
place of the poky hash there.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/getproperties.py | 66 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/scripts/getproperties.py b/scripts/getproperties.py
index 5ce6204..0d8eab2 100755
--- a/scripts/getproperties.py
+++ b/scripts/getproperties.py
@@ -1,17 +1,75 @@
 #!/usr/bin/env python3
 
+import hashlib
 import json
+import os
 import subprocess
 import sys
 
+import utils
+
 builddir = sys.argv[1]
 
-builddir = builddir + "/layers/openembedded-core/"
+
+with open(builddir + "/../layerinfo.json") as f:
+    repos = json.load(f)
+
+utils.filterrepojson(repos)
+
+def get_revision(repopath):
+    return subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=repopath).decode('utf-8').strip()
+
+def get_branch(repopath):
+   return subprocess.check_output(["git", "rev-parse", "--abbrev-ref", "HEAD"], cwd=repopath).decode('utf-8').strip()
 
 jsonprops = {}
-jsonprops['yp_build_revision'] =  subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=builddir).decode('utf-8').strip()
-jsonprops['yp_build_branch'] = subprocess.check_output(["git", "rev-parse", "--abbrev-ref", "HEAD"], cwd=builddir).decode('utf-8').strip()
+jsonprops['commit_yocto-autobuilder-helper'] = get_revision(builddir + "/../yocto-autobuilder-helper/")
+jsonprops['branch_yocto-autobuilder-helper'] = get_branch(builddir + "/../yocto-autobuilder-helper/")
+#set below to a combined hash
+#jsonprops['yp_build_revision'] = get_revision(builddir + "/layers/openembedded-core/")
+jsonprops['yp_build_branch'] = get_branch(builddir + "/layers/openembedded-core/")
 
-print(json.dumps(jsonprops, indent=4, sort_keys=True))
+done = []
+
+def getrevs(jsonprops, layerpath, layername):
+    jsonprops['commit_' + layername] = get_revision(layerpath)
+    jsonprops['branch_' + layername ] = get_branch(layerpath)
 
+for layer in os.listdir(builddir + "/layers"):
+    layerpath = builddir + "/layers/" + layer
+    if layer == "logs" or os.path.islink(layerpath):
+        continue
+    if not os.path.isdir(layerpath):
+        continue
+
+    layername = layer
+    if layer == "openembedded-core":
+        layername = "oecore"
+    getrevs(jsonprops, layerpath, layername)
+    done.append(layername)
+
+for repo in sorted(repos.keys()):
+    if repo in done:
+        continue
+    layerpath = builddir + '/' + repo
+    if not os.path.exists(layerpath):
+        # layer may not be used by the build and hence not moved into final position
+        layerpath = builddir + '/repos/' + repo
+    #if not os.path.exists(layerpath):
+    #    # Repos is specified on the controller but not used in the helper config
+    #    continue
+    getrevs(jsonprops, layerpath, repo)
+
+# We need a way to match builds which are the same in the buildbot UI. Traditionally this was
+# done with an poky revision.
+# Compute a dummy sha1 of the combination of oecore, bitbake and the helper revisions
+buildid = ""
+for repo in ['oecore', 'bitbake', 'yocto-autobuilder-helper']:
+    if 'commit_' + repo in jsonprops:
+        buildid += jsonprops['commit_' + repo]
+buildid = hashlib.sha1(buildid.encode("utf-8")).hexdigest()
+
+jsonprops['yp_build_revision'] = buildid
+
+print(json.dumps(jsonprops, indent=4, sort_keys=True))
 

