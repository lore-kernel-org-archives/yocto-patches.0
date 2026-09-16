Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6424BC982D2
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 22:30:42 +0000 (UTC)
Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.27118.1789597832902112213
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 15:30:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=kcA3Cbfs;
 spf=pass (domain: konsulko.com, ip: 74.125.230.234, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f42.google.com with SMTP id af79cd13be357-93910c3e6b1so6705585a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 15:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789597832; x=1790202632; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PgoYRivC98VWlnEnM/gDp3PQObMpW8IZE8KmclouLz4=;
        b=kcA3CbfsrN573Ua2HJY9vJlVFxOUeZyJGA/aGhXJ4tezfr97dpc0qLg6odN8EEN9WQ
         Uty2OnidGyv0I4BvpBwYtcIdp1ZiX6zjoHyQ9Ho0rWD6VLtkrf/BCtdJoryRqAuHpuR1
         a+zU7bm5dd/mSMcpXgEv9XiMTK40q2Fz4Cpa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789597832; x=1790202632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PgoYRivC98VWlnEnM/gDp3PQObMpW8IZE8KmclouLz4=;
        b=ajt7sNFYRAuE5b3gmFZV2LZ56JkUJkd8/ZoJ9l9nmaUxb4bUfo4qkLAZ6q2bqrrZZJ
         ZgNrucop47xMP1wN2wBzQGNlLrBX2lz8WFoB6m6H3QOAEG+ShNwlk95IvRE+K3I5NIOp
         oxCpq+SXjjGLQq+c2dCK8H+i1hbavamu332GRSakVUs93++DJ+NfaGnE+wH8RCDPPCsK
         hJjVtQnAea3pDvkgzPEseJRYUPvuqOEKcPHFNYvQkoEJ4HbSJnHC9f6cPiRlkwFC2o9d
         Jlde0nHZ3n43vbUr2hTsgQZ508Q0WcDbYX7brSgk5MRe5dZKl/UPJUe5HOSIYjuaOI/j
         jsSg==
X-Gm-Message-State: AFuF++nOlvNh+EcGXNp1hjj8/W7e3j6k98mGskvU59ZNoQzzz5uNB43T
	jHCddylEqumt0YvEE76vZgMoNwJeAeoCPkLe47GKZzxF8eX0eOIKx2xSQ6vkwGCM60U7YSBrYHs
	GHRcY
X-Gm-Gg: AYBFou0gk616mDotxvqQITjUQkW2vIh1ju5uaw3Er0WW9eiKpCFeycrG65P+Ji6POm7
	FM2rzVdqrUe0nuEJ8gY7bNIQ8NRHwgpwhxBpSLXiRrAPipPSDDJ46BUYoudBiqI0FBwQvvJrnrW
	tk8n1FuWLxnPRBE37mIttDTgK4J+pNG+YIUc6bDHpMlE1BKn85CkMcVHK4YuUZ0JjzU1ed9aySy
	cI9MiGzqD+CLleORNC1DI1ZBkkOQlL2H3KUGMVMO/NIJKVO99vD2VKA8Nk3FbAByT2IH3IkpWYf
	zor6d7c63HvKRqyGjWi3ASR8l13uBuio80v3FRBZ5kMIth77doTWQdbMRvl6jfKJfi89gvhWMo6
	f835JOrsPzmCQIUwXoNO+bGZ4StjIKFAZeYZIexDGQxIzCD7dIm800oMX1z3nh7Tcg60CIY4SvC
	MIkA3p0CDLlp9AlqzHx92RepABOaMEiAXLqdczJkcjq7tlL/fNyHNLLJWgsjb0oiqJtrNmXjvUG
	a2ypG73N4vjVmbUvqMDXdHW8hr/EFGhO3JQbxEyj6v83IkqWu1n9CmWoTUgk7f797O2OeVkEufL
	oxXzDjWkjTseKjjVk7THzfz5cF1Z4YgW3AvkILlqMKuKzg==
X-Received: by 2002:a05:620a:a007:b0:93b:beb1:55ec with SMTP id af79cd13be357-93bc6284b93mr154071685a.2.1789597831503;
        Wed, 16 Sep 2026 15:30:31 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781d94c0sm310900685a.10.2026.09.16.15.30.30
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 15:30:31 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 02/24] README: fix broken URLs in meta-integrity and ccs-tools
Date: Wed, 16 Sep 2026 18:29:56 -0400
Message-ID: <7bb182b14eef023ae9ad8c89b13c76f30b841012.1789597604.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789597604.git.scott.murray@konsulko.com>
References: <cover.1789597604.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 22:30:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4878

From: Sandeep J <Sandeep.J@windriver.com>

Update TOMOYO documentation URL:
   http://tomoyo.sourceforge.jp/1.8/index.html.en
to:
   https://tomoyo.sourceforge.net/1.8/index.html.en

Replace dead gmane.org permalink references with mail-archive.com
copies of the original Tizen dev mailing list messages:
   http://permalink.gmane.org/gmane.comp.handhelds.tizen.devel/6281
to:
   https://www.mail-archive.com/dev@lists.tizen.org/msg06106.html

   http://permalink.gmane.org/gmane.comp.handhelds.tizen.devel/6275
to:
   https://www.mail-archive.com/dev@lists.tizen.org/msg06100.html

Signed-off-by: Sandeep J <Sandeep.J@windriver.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 meta-integrity/README.md     | 4 ++--
 recipes-mac/ccs-tools/README | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/meta-integrity/README.md b/meta-integrity/README.md
index 92d24f8..9dcd518 100644
--- a/meta-integrity/README.md
+++ b/meta-integrity/README.md
@@ -270,5 +270,5 @@ No package manager is integrated with IMA/EVM. When updating packages,
 files will end up getting installed without correct IMA/EVM attributes
 and thus will not be usable when appraisal is turned on.
 
-[1] http://permalink.gmane.org/gmane.comp.handhelds.tizen.devel/6281
-[2] http://permalink.gmane.org/gmane.comp.handhelds.tizen.devel/6275
+[1] https://www.mail-archive.com/dev@lists.tizen.org/msg06106.html
+[2] https://www.mail-archive.com/dev@lists.tizen.org/msg06100.html
diff --git a/recipes-mac/ccs-tools/README b/recipes-mac/ccs-tools/README
index 0381814..dffb933 100644
--- a/recipes-mac/ccs-tools/README
+++ b/recipes-mac/ccs-tools/README
@@ -1,5 +1,5 @@
 Documentation:
-http://tomoyo.sourceforge.jp/1.8/index.html.en
+https://tomoyo.sourceforge.net/1.8/index.html.en
 
 
 To start via command line add:
-- 
2.55.0


