Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237B9D4A607
	for <webhook@archiver.kernel.org>; Fri, 16 Jan 2026 06:47:54 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.837.1768546072883613187
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 22:47:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=SIAdwnbg;
 spf=pass (domain: gmail.com, ip: 209.85.221.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42fbc544b09so1163127f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 22:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768546071; x=1769150871; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=73O40v+kq1Mf99Oi+ZiiqhXRZKkTMV9qCku+VLwad7A=;
        b=SIAdwnbgvRPuDSpEHbrJlsRFe0RnuGTrII54KPd70CUVM7D+bvUmnIP5qdYFvxK1Of
         qplJyOFpv2vl/m4CMT7Z1lobXwYlWgNa1HtIgALWnnhnIdwiDBI95Uayx+AHsEd0tIpm
         Jf4uH6KpS0u6GaivVlZ7qMhmv3UOkZI2XFUZ4eGNQ8mZ1IDwtUO63lkT8uGY0+L7aZ19
         vEJabAolj97/g+O6XNaTkjpcDs9T4r17lndlraQGHrrLem9sfrL28e4uOTuEr+nn/vIJ
         pcz5o1/lbrOcCYa2rhiKOyqSUo8NxsCLWDBTLLfD0FzU68TydixFzjLBLMravXNIJAZn
         JbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768546071; x=1769150871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73O40v+kq1Mf99Oi+ZiiqhXRZKkTMV9qCku+VLwad7A=;
        b=lqjmQYc+9on18dvoPpD0DcX1Zp59jHuy8KCYylBMInfnmRrjxBG+mZca2xokmaOnuW
         mX6IiGSDaT6AgZ7dUOwyCUXkGuSVyD8N3WOIl0nrqxZ3ueeSYRrKJok8whTP6ofKXQpM
         ckX0GigxUvBWSnG3QHxDaU0wepRv7nQaUMi1ucRILyab2LR67l3RwAvIBOU3ThkSNMmV
         AfJcBa3xItkaxkYRFkV6oiFbuJ++cVVoslZ3QGsUObnVRWc7xjXtAd6oqwOM/yfrAGHl
         yde6smPClIySQSXYn7lNbDmmDbbCxGIzZVvlMrrSBE/xJDRbJmTlJ0Q73h0fCfbbxVHl
         qdmA==
X-Gm-Message-State: AOJu0YyNpMdddQoq1HVw6oUFqdDfkAf56PuXJgOBslX+v/3NmrtWuDG7
	gs48QMybboVpLLdH9/MYd2L9JpbMA7TAfm7BXXCDjyodwX4eqseX5Y2o6CcycDI8
X-Gm-Gg: AY/fxX74G7R8rxM+ANqLpXMxOlzic8YC/gWttUG2vc1MlEep+eeKPQfSHK+ScEqmYqC
	E3o5NFfnXg2DOeqOq/ibzwXxjpktXAPC/k+6XdrBWLHiQR13G2rRQCoeYUsyRfAVxosOpYTBO6M
	gdIGqaTEcTZJE0BzPkHHO6T6HYAL3AmzFKauQgUWteMQLdmbexdgWn5p9Xyh1xPrm1n+aFQqvP8
	IVViqu6+Fyy4Ab6Xhc+CgCNXXJyXiySUGxDZqYiPtaZE0s9nhgFUJ+nljrYyY1qAJFyoRSwCW13
	3LAi1LOskuBIAjzxdJOO/w0y/cBTDlX3NUbgS3L+Y8BMBp7p3NyOzyiaaJY8DRL+ug4CEBD37Of
	+T3DtjJ2uZK70K5QiA6MBnZWOPMqzgdTMYr+YvK/i7MidC9D/HZLkLnWLc9VpXeI4ExfhdAFoAm
	JMcQQz5v4T6eNKMuKPeT6uN7bD5KtGzI2VxF5/e/1WqQpb9y8=
X-Received: by 2002:a05:6000:144b:b0:431:344:5a2d with SMTP id ffacd0b85a97d-43569bbadf7mr2026304f8f.41.1768546070909;
        Thu, 15 Jan 2026 22:47:50 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996d02dsm3271413f8f.23.2026.01.15.22.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 22:47:50 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
X-Google-Original-From: Alexander Kanavin <alex@linutronix.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [auh][PATCH 1/2] commit_changes: handle lack of recipe_dir gracefully
Date: Fri, 16 Jan 2026 07:47:44 +0100
Message-ID: <20260116064746.3584094-1-alex@linutronix.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 16 Jan 2026 06:47:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2997

Recent changes exposed this issue: if recipe_dir is not
set, then the code should not try to access it, and instead
simply skip the recipe, and handle it as a 'nothing to commit'
situation.

recipe_dir may not be set when for some reason reading the
recipe environment has failed.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 upgrade-helper.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/upgrade-helper.py b/upgrade-helper.py
index c1c26c0..2f38e0a 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -393,7 +393,8 @@ class Updater(object):
 
             I(" %s: Auto commit changes ..." % pns)
             for p in g['pkgs']:
-                self.git.add(p['recipe_dir'])
+                if 'recipe_dir' in p:
+                    self.git.add(p['recipe_dir'])
             self.git.commit(g['commit_msg'], self.opts['author'])
 
             stdout = self.git.create_patch(g['workdir'])
-- 
2.47.3


