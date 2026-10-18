Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6ABCCF2C4
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 01:53:56 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7877.1792288429962023832
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 18:53:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=VhMfJtBt;
 spf=pass (domain: gmail.com, ip: 209.85.214.179, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e9995ce866so7739635ad.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 18:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792288429; x=1792893229; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Cry8Rz5c8206kZiXrruKP4iuJGuhCHyOpGfTosi1sc=;
        b=VhMfJtBtlBSBQD0TheknK2JY58XWjxqaPtnK1sYwabiOL9d+vlPblHRla6R2r8mc4w
         yfufaMMMIQzYmthwCBbsLyRBhl6HfHE7gxUN6haoLHDyGEMCszta0jR8tXVkEP/SHXOQ
         IcyxpfzEImAqmkdM0K2ZHrN6E7tAvDAdAuHV9DvX2RLWSEHwALQM4XEMx/vnfcvsvS1x
         56kJySLbjJpCJE5c3K3e9G22ac0RYFLyY38oB3+Rz+W/nDoFDpGUTe3PeBtZxeHPwMO5
         ZhiPMiIg0dokEzbViA/Y49uJz9ZeuqoGlTNz5d3nTRvM8Fuh3BW8hO1sQiqBuLnrQgmt
         fCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792288429; x=1792893229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Cry8Rz5c8206kZiXrruKP4iuJGuhCHyOpGfTosi1sc=;
        b=hrJgWmHYfQNrRIsTAy9fOUZHMxQCLUssvj17xOiO4ib6YcJWWrufNeIbSmrPVO7tHC
         AjdG63p2j4n8r9PQ2Hy1NUma4Sai9289r6NWUDciCQg+nIZzkBoMkYdHM06sr+wvG0fE
         BoYEK2sam554JqQyGePuiR0kone7eMLxUYTYtuJR2KK7vO70SjJmZalAB9785NapvXOS
         rJhtF81d4fGujbXAx4LVkXjy0Fp3KRGAOE/vwsP7CMM2UXzTSab6GG+SMtdsEnCYwuTa
         V4zl/Jz2rhVGEAjIheZejUaMMOp4t/rPpRpjffgFc3KFTiRyE5IUD3O9lJJf2p6NnTis
         Gtfg==
X-Gm-Message-State: AFq9FYLy15gMTW2AVLIzVtSvM9I39Whap6VePlwj+mV+fkCrBQHFyPAp
	sorHFN1ksv8VDugs9LKd/dB4JSFwDgasMXeVo0l3RyW/vzxEjlxyqGWTNi9Tqfz0
X-Gm-Gg: AYBFou05q9gZ+CelXCI9DuZ1AQ95YgumBdF7sXNpBQ0XbEsnH6rPUjixakCSs0oir18
	2bLJRKxv/odKhUdYglIlbutv9HXdx5bKHROpSOXtllCYqh361INvYvHvTzbXDDVd0VPwrBqi1KZ
	RPoiZqUyS8u+/5/7OCv/SrJTkg+nDqQaoRyKXKRUSs5hRh1atxtSfyekWl71kFd5JnTz5u9n4v4
	K64jgy9f0zwdF6XrJCBDmV9TORb03LVXJxh5n6u2ZvuOEHh8vLC3Xxt9gjzC/2DMqWjZnAdsWQJ
	A4bzRxs2b8hPAnSHEKEYU1GP86itPwn2Tr59mevkmKQTxBCawCJzIFT6bol+fJOztIeSx2EwAMD
	fLlVjXnHVEt3s7+xVMk4z8Hzk3Xs+9zoJCAPjlLFmkQcGchOIjSg6mGUFjLzNHskWpLTtM+8I5F
	PXVhY8AEApXss9EPXyOsLuE2aAoOccqWAbX3X0OIPQLCU/iNSgm1qlvv7r1UFVBa20e0sPz90N+
	uB08OYy6lpIibyl2VmwbjaekybEMsE=
X-Received: by 2002:a17:902:d2cb:b0:2e9:5b4e:b8a1 with SMTP id d9443c01a7336-2e9a6c22dcamr35726455ad.55.1792288429206;
        Sat, 17 Oct 2026 18:53:49 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e5d51b5sm24626155ad.8.2026.10.17.18.53.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 18:53:48 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [error-report-web][PATCH 1/3] Apply common_context through TEMPLATES.
Date: Sat, 17 Oct 2026 18:50:36 -0700
Message-ID: <20261018015326.73748-3-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018015326.73748-1-tim.orling@konsulko.com>
References: <20261018015326.73748-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 01:53:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5055

TEMPLATE_CONTEXT_PROCESSORS has been ignored since Django 1.10, so
common_context never ran and the SPECIAL_SUBMITTER tab never showed.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 Post/test.py               | 11 +++++++++++
 project/settings.py        |  7 +------
 project/settings.py.docker |  7 +------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/Post/test.py b/Post/test.py
index 2a98bfc..d33cf97 100755
--- a/Post/test.py
+++ b/Post/test.py
@@ -400,6 +400,17 @@ class PaginationTest(TestCase):
             self.assertEqual(response.status_code, 200)
 
 
+@override_settings(ALLOWED_HOSTS=["testhost"])
+class SpecialSubmitterTest(TestCase):
+    def test_tab_shown_only_when_configured(self):
+        client = Client(HTTP_HOST="testhost")
+        self.assertNotContains(client.get("/Errors/Latest/"), "Latest Autobuilder errors")
+        with self.settings(SPECIAL_SUBMITTER={"name": "yocto-autobuilder",
+                                              "title": "Autobuilder",
+                                              "link": "Autobuilder"}):
+            self.assertContains(client.get("/Errors/Latest/"), "Latest Autobuilder errors")
+
+
 @patch("Post.management.commands.culldb.time.sleep")
 class CullDbTest(TestCase):
     def setUp(self):
diff --git a/project/settings.py b/project/settings.py
index bc63c49..529086b 100644
--- a/project/settings.py
+++ b/project/settings.py
@@ -159,6 +159,7 @@ TEMPLATES = [
                 'django.template.context_processors.request',
                 'django.contrib.auth.context_processors.auth',
                 'django.contrib.messages.context_processors.messages',
+                'Post.views.common_context',
             ],
        },
     },
@@ -208,12 +209,6 @@ LOGGING = {
     }
 }
 
-TEMPLATE_CONTEXT_PROCESSORS = (
-  'django.contrib.auth.context_processors.auth',
-  'django.core.context_processors.request',
-  'Post.views.common_context',
-)
-
 BUGZILLA_URL = 'https://bugzilla.yoctoproject.org'
 
 ACCOUNT_ACTIVATION_DAYS = 2
diff --git a/project/settings.py.docker b/project/settings.py.docker
index 680b485..b98006e 100644
--- a/project/settings.py.docker
+++ b/project/settings.py.docker
@@ -153,6 +153,7 @@ TEMPLATES = [
                 'django.template.context_processors.request',
                 'django.contrib.auth.context_processors.auth',
                 'django.contrib.messages.context_processors.messages',
+                'Post.views.common_context',
             ],
        },
     },
@@ -202,12 +203,6 @@ LOGGING = {
     }
 }
 
-TEMPLATE_CONTEXT_PROCESSORS = (
-  'django.contrib.auth.context_processors.auth',
-  'django.core.context_processors.request',
-  'Post.views.common_context',
-)
-
 BUGZILLA_URL = 'https://bugzilla.yoctoproject.org'
 
 ACCOUNT_ACTIVATION_DAYS = 2
-- 
2.56.0


