Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99FAFDEE51
	for <webhook@archiver.kernel.org>; Thu, 23 Apr 2026 21:44:22 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8382.1776980656200284010
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 23 Apr 2026 14:44:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=O3nYd4wL;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso73938215e9.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 23 Apr 2026 14:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1776980654; x=1777585454; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ukNPU+nTnHmaK2YCMU+5QsGr4yjn4dqJsbXAaj4DK/E=;
        b=O3nYd4wLNnpTvZZSnAW2QRfeQ8/QDS86KcUq1EKexFkOezkwlNu80umC+q+Ymd2sFe
         hyEsMXDho3GzYth1LMte+49izm9OY3ieoH1aywZMwbsLnpXg5AHgad8LF7lFnmIxKfX6
         UFG1mhdNeuZzCVnvoTqSma6PTx4wvOqtTypyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776980654; x=1777585454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ukNPU+nTnHmaK2YCMU+5QsGr4yjn4dqJsbXAaj4DK/E=;
        b=Vehzu0P9i5jnaaBcER3R+6ElgGcP2GvVsXSTGTTq/E9Ps2zajhVbaVpYYLhOyDFuje
         1EyDzalDtUJe23EZvOAhAR6mw8wtUHJX12XHNie7wuYDulQXoCIxjGSA1CQTL7OEp+iu
         cVQrJWtHM81lbs1sLNYt2cqvotkhK405RAPQNQHkvcApcdNndxpO33ZwDcqvFNJPJsBG
         7NkKSBvQMmqYsTViqahPnjrk+Yq13UeGug8iXJgZH0B70xUXDVE2NBcdV5lb6Z8BHzTs
         4XWn7IZJfkV0dvmOsTUTqjSghDZ723DxaCK8nJ3UI3RDEtKBaD/xPKcHEJQ9KdxuJv6Y
         wWCQ==
X-Gm-Message-State: AOJu0Yy5c8CnqB9SuswTu/svpB5NHxwOV7bRi9F9pkcZS5vaEarffMIV
	5wdKdZLOrUDJ5CJXZxJYx5dUYAzXOATeYv9A6uFyS2GJWv296XULnoOOBcO9zDLjafG95XJ5QL0
	+0RuFc54=
X-Gm-Gg: AeBDiesScVpyFEkjAyZ297FaVN9jhFAXtM/esxHDjDPeUaKU3N8ahnhsZIKs7Lt0zNp
	cetyhT/Mea55+teeySi8pxxVLcXSWZfYvjUWKwc1fro/cr5NCxlIerp7zAP6ugJypetvuY50hrs
	lNuBHIrtOhc93F9uK8qMzbrHahxDXDxo04ExfzK1VHcnBDheIJi7zRU9+tCHy2Xk/MgOWop+9UZ
	dBrEii4rc6uKPLY/oHPo694v3oWSLTzOzd6qKZc2DwlKC7v3wdsOqnkSaDG67RiEPMGxoEqjRaP
	dqK0kMYLPNLuYbdhPOCavY1U6veV3zrxcR9RHARkNRPejZ/+wnCywmSrt/0YS4jUJBIVh/R0nN4
	0x6Dj+8/C4plnaTNEopKXJlvqj17BhkWM3vIIv9VEI3uWpl8hTHvECUpYduujE3l+23k+1JXJNF
	Qfl9vTZk8gD9RFhB8JKD1xOoad5lW80ThGlP/hXOoARCSyGXDAiURMHtDXDwKrWE8=
X-Received: by 2002:a05:600c:3e1a:b0:489:1ca2:eafd with SMTP id 5b1f17b1804b1-4891ca2ee65mr268542255e9.11.1776980653613;
        Thu, 23 Apr 2026 14:44:13 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:2813:1dbe:9c2b:249b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a4b329542sm466703225e9.3.2026.04.23.14.44.12
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 14:44:13 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH 1/2] schedulers: Add wrynose branch selections
Date: Thu, 23 Apr 2026 22:44:11 +0100
Message-ID: <20260423214412.2387367-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 Apr 2026 21:44:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3781

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 schedulers.py | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/schedulers.py b/schedulers.py
index da9f906f..ee8887d3 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -71,6 +71,24 @@ branchdefaults = {
         'branch_meta-openembedded': 'master',
         'branch_oecore': 'master',
     },
+    'wrynose': {
+        'branch': 'wrynose',
+        'branch_bitbake': '2.18',
+        'branch_meta-yocto': 'wrynose',
+        'branch_oecore': 'wrynose',
+        'branch_yocto-docs': 'wrynose',
+    },
+    'wrynose-nut': {
+        'reason': 'Stable maintenance - wrynose-nut',
+        'branch': 'wrynose',
+        'swat_monitor': False,
+        'repo_bitbake': 'ssh://git@push.openembedded.org/bitbake-contrib',
+        'branch_bitbake': 'stable/2.18-nut',
+        'repo_oecore': 'ssh://git@push.openembedded.org/openembedded-core-contrib',
+        'branch_oecore': 'stable/wrynose-nut',
+        'repo_meta-yocto': 'ssh://git@push.yoctoproject.org/meta-yocto-contrib',
+        'branch_meta-yocto': 'stable/wrynose-nut',
+    },
     'whinlatter': {
         'branch': 'whinlatter',
         'branch_bitbake': '2.16',
@@ -544,7 +562,7 @@ def parent_scheduler(target):
             name="branchselector",
             default="master",
             label="Release Shortcut Selector",
-            choices=["master", "master-next", "mathieu-next", "antonin-next", "mut", "whinlatter", "whinlatter-nut", "walnascar", "styhead", "scarthgap", "scarthgap-nut", "nanbield", "mickledore", "langdale", "kirkstone", "kirkstone-nut", "honister", "hardknott", "gatesgarth", "dunfell", "zeus", "warrior", "thud", "sumo", "rocko", "pyro", "morty"],
+            choices=["master", "master-next", "mathieu-next", "antonin-next", "mut", "wrynose", "wrynose-nut", "whinlatter", "whinlatter-nut", "walnascar", "styhead", "scarthgap", "scarthgap-nut", "nanbield", "mickledore", "langdale", "kirkstone", "kirkstone-nut", "honister", "hardknott", "gatesgarth", "dunfell", "zeus", "warrior", "thud", "sumo", "rocko", "pyro", "morty"],
             selectors=branchdefaults),
         util.BooleanParameter(
             name="swat_monitor",

