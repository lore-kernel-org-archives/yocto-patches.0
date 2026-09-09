Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A437BC79FB7
	for <webhook@archiver.kernel.org>; Wed,  9 Sep 2026 16:15:47 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16654.1788970542550600990
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 09 Sep 2026 09:15:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=b4NZBnFk;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so70954645e9.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 09 Sep 2026 09:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788970540; x=1789575340; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HatvxE3q1AD4BkcZArnw5ta7tB6magWenIWgbd5lV6c=;
        b=b4NZBnFk/T8EXq8R2DqkWLID7KFoD5PIUjzyEOIyJWfjZlz+wFl9qvdmOalePZI1CF
         wb5D1FUoI2vwPSF48k1IshujZPagQsNdBsRI5LJWjYT3E5roh7dAIjOdT/RCaThdzufH
         9RuXPCosm9Bcb9pcQzKhD8VP3Ck4p1SMc8FVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788970540; x=1789575340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HatvxE3q1AD4BkcZArnw5ta7tB6magWenIWgbd5lV6c=;
        b=ZA/Mke3mzBTOuGvP+yGx7tB+IvvQroAZXmgvqC0v50Lz6pxpQPCXa0bksgfi4mTtZz
         QLYs599W/1sL0afbPUD1sFpxuGXJg3KqegrIGV3Bd5/j8D3b/zQ6KC4CCzoxGj2BXvR4
         LllQDiAh0j0SDCuR9y2v7cYrCAB9EPXQ5M7vmfNAvY1rt18ka1sHs04YyKveX3npS0qE
         VdPhs4X907/3JpI+mHvo6eeI3u2+JABtlarevJn2DweiGHJq8QbU8UQ1FqNypu1EitsE
         cjVTv3ZbkxcVqOvCMr7d7YtL/6GNuYfgEdKAH2iaKVjAz+RNbpCIA5JQLPunZfQwIngq
         40Gg==
X-Gm-Message-State: AFuF++lY/id7nxlcvSq+Xzf7fFrvmSvd8Q6rmYM/Aw+qppmUNdMzOJdC
	KfUfs7wJIbZ2CKjGhLjk8y89ffc3UGNOgXPLWMhuDiZdev57yIZdGbx0ShHQKhVTRVBpxyE1epH
	9fMcQjmQ=
X-Gm-Gg: AYBFou0u4LbwtMXyvUmDhlnrj5DdWgkKkDbt8hbcLyTYZo6QKEhOGqJCSDBsIYKbmoy
	TZ82KOBIyR6rcRzMzK41X7b4WIk0Kb5IF9c1nuN8Az7HsV1zqvN5AMVfS4AXKwjyRZ1w2EQI74B
	MNHQb7Ifq4sFhONBTjMF/0REsVr+7UBF/yAmqq12M4qIe2eb+O0w63FKYb4DjNIoW3ljCTEJ/DZ
	r3QR7akXpjhgS8Qzwo4GTl0CVlKeLb6m6//HXpuwXPb77IucCJGFe10U0szfq5XLvsbGEIFr4xK
	0vHsoD8qrXFCLuyK+F+b4y7eMPXGk4RfDmPkhUSTltVVS05JlAEpaT4kt/23RV9zLsM+Jl8fTjd
	P2uJzCy81E/kqfF7jcGJnyDEtMouQ6N+IULgYsf9STVLAFUwPRJEzxyQOcLHmizJ+MDLHhO5jrJ
	L+g62L9tgMW5eDZlrGJdcHR1LViY3/e54kGRogP93abZKATa5BS24CUfDKhFnqbNxpGA9KtvPNH
	16qe3gGbJF9Imhlwk5bfhurqbI=
X-Received: by 2002:a05:600c:35c3:b0:49c:fc6c:be10 with SMTP id 5b1f17b1804b1-49cfc6cc055mr327762975e9.22.1788970538661;
        Wed, 09 Sep 2026 09:15:38 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:a320:8b5c:de4:61f9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883acd33sm44956785f8f.18.2026.09.09.09.15.37
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 09:15:37 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH] steps: Handle wrynose mixin special case in non-wrynose builds
Date: Wed,  9 Sep 2026 17:15:36 +0100
Message-ID: <20260909161536.718818-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 09 Sep 2026 16:15:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4756

We don't want the wrynose mixin for qcom leaking into our other
builds. This workaround is horrible but the least worst solution I
could find.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 steps/writebbsetupjson.py | 4 ++++
 steps/writelayerinfo.py   | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/steps/writebbsetupjson.py b/steps/writebbsetupjson.py
index e1f14634..68a8b2db 100644
--- a/steps/writebbsetupjson.py
+++ b/steps/writebbsetupjson.py
@@ -39,6 +39,10 @@ class WriteBBSetupJson(steps.StringDownload):
             branch = self.getProperty("branch_{}".format(repo))
             revision = self.getProperty("commit_{}".format(repo))
 
+            # Skip mixin-wrynose-linux-firmware for non wrynose builds
+            if "wrynose" in repo and "wrynose" not in branch:
+                continue
+
             if revision and revision != "HEAD":
                 rev = revision
             else:
diff --git a/steps/writelayerinfo.py b/steps/writelayerinfo.py
index 741888b1..cdfd0657 100644
--- a/steps/writelayerinfo.py
+++ b/steps/writelayerinfo.py
@@ -29,6 +29,9 @@ class WriteLayerInfo(steps.StringDownload):
             location = self.getProperty("location_{}".format(repo))
             if location:
                 repodict["location"] = location
+            # Skip mixin-wrynose-linux-firmware for non wrynose builds
+            if "wrynose" in repo and "wrynose" not in repodict["branch"]:
+                continue
             layerinfo[repo] = repodict
 
         return json.dumps(layerinfo, sort_keys=True, indent=4,

