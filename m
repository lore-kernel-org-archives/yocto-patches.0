Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D151D73094
	for <webhook@archiver.kernel.org>; Fri,  3 Apr 2026 18:37:17 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2229.1775241427038947269
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 03 Apr 2026 11:37:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=SqXcRewo;
 spf=pass (domain: gmail.com, ip: 209.85.222.170, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8d00cf835b7so280060585a.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 11:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775241425; x=1775846225; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i68CMJ/r48OkCGm9ByfM55xhCEziPkDtNTzDoKQwgDo=;
        b=SqXcRewoVwZua8MdYQ8rECsrkroCa/BS5PHWANzrADKRMY4/fp1FguWM3sIbCc4sTn
         8qOZGFer4QsdIxzgo6q9lKQDZN7zkNr+d3AJhwVp4ciDnqCq1EQP5kuATvuKnNBzADB+
         4I6tWDQwDXXNTWmRlWhgNXyLNcROQajXzx+p0CHMieYtVyLWNp6FMnqUof7yQS2I3H3s
         aRn2epltTCM3P0GwBZ51uJHJ8Q9s5KBk5X9Z+1oq68wJXHeGVWjhkBD63jfXEascX4le
         Sw+xhkjvudHakFRcaB9sHKz1OWDXKhUB3Q6fqatzIaLXajS4hlAqUINOmJBKD9cwmfls
         pwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775241425; x=1775846225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i68CMJ/r48OkCGm9ByfM55xhCEziPkDtNTzDoKQwgDo=;
        b=tHu2VVa+tIMIVjJap5X0NtPnhvojs0n64hWUCogRjXlpAG9Z5EBBd1ye9MfiEz5PJF
         bzsE6AGRyP1/LP5+VmRS0U3dMXBgo/47/M24giSmUbrgaio9FV6Hpw9vIEh0ZhkFycHk
         mLSy0Hvmz1k8X39EuBGYe7PHFvBDM2+4kLSsPMHOalPBaUbQ2d9dpxif8auCZEDNNAp/
         jilvPk86tD09ZHU0N1Sb71BS9ih2eag0WrqGFyCTaKlCN2Fh+WaZQ9B+UY7DrbpIC8+r
         4OHua0kOn76gi7QfO3eySCL0p79jdZEpbu4HWymsC/Uy4bT0wYH2QGn/6dbh9RV100Nn
         EFjg==
X-Gm-Message-State: AOJu0Yy/XF6jB9p1yh396DpT8A15iOjc8L6GwSP/tnD6w+eIerNxJC8q
	3onsBk4sFJMYSKE2kcG7D0SrFlJqMu5jNsMoLux6zfjjp9gVkNgGfwAdZfueSti8
X-Gm-Gg: ATEYQzzEiZRaNt3IC1YPJtFsQImy+uuc69RtO+e0LZOiJ0MR0JwaaJNUrN4yZEB6F1Z
	wmc/4m+PFci0STGd5qf8TApyInfZQJKuV4ILl9mNuNAddFVvLLbgszSJ/Xrh+5jqE8SG62kKUYZ
	Epqpe3RDDYJCwHFleC5hWQn37mQ9Y5Kn4ue7kXomsBd8HkIPeTTi4lIMi9ppr2zY/TGz1l9hYTa
	oI/9ADwfo28YUa521jG44daeaTVVKPe5b7oyUeYfFkPQK8+Y2swDDZ7r6NAIGv0hs82yWj+LH2C
	GjawirevgtURfkA90TvhlSoKD5IcRjyajTECVV3jdya6/bojcRT2PzygLLG4/aFgZ2zKMcCgSIk
	en0obPyR9dNhGfQVr2dFuRz91nY61Nw8CdsWV7C9o7VtqOMR5PZMdvI+aaDjTPORfCLht9SDlIs
	7/K/S73YEEWauuL+TBz2LHPuamyxYmBcc/TNeTdVfDFbL4cKoR14voUHPWYZsNlJf1eg==
X-Received: by 2002:a05:620a:4442:b0:8b2:ea5a:4149 with SMTP id af79cd13be357-8d41ec08f6cmr540410385a.65.1775241425096;
        Fri, 03 Apr 2026 11:37:05 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a874459asm472401785a.39.2026.04.03.11.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 11:37:04 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Bruce Ashfield <bruce.ashfield@gmail.com>,
	Mark Hatle <mark.hatle@kernel.crashing.org>
Subject: [wic][PATCH 7/9] plugins/source/bootimg_biosplusefi.py: add import os
Date: Fri,  3 Apr 2026 14:36:42 -0400
Message-ID: <20260403183644.2783267-8-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260403183644.2783267-1-twoerner@gmail.com>
References: <20260403183644.2783267-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 18:37:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3633

BitBake's bb/build.py:55 deliberately injects os (and bb) into Python's
__builtins__ at the module level:

    # When we execute a Python function, we'd like certain things
    # in all namespaces, hence we add them to __builtins__.
    # If we do not do this and use the exec globals, they will
    # not be available to subfunctions.
    if hasattr(__builtins__, '__setitem__'):
        builtins = __builtins__
    else:
        builtins = __builtins__.__dict__

    builtins['bb'] = bb
    builtins['os'] = os

When wic was part of oe-core this injection would occur, and once
os is in __builtins__, Python's name resolution (locals -> globals
-> builtins) finds it for any code in the process, even modules
that never explicitly import os. So when bootimg_biosplusefi.py's
__instanciateSubClasses referenced os.path.join(...), Python resolved os
from builtins rather than the module's own globals.

Since wic is now split out from oe-core (and bitbake) this plugin fails
with:
	NameError: name 'os' is not defined.

Therefore, add "import os" to bootimg_biosplusefi.py.

NOTE: this commit does not work as-is, but is being provided in order to
      explicitly show a clean transition from oe-core

AI-Generated: codex/claude-opus-4-6 (xhigh)
Reviewed-by: Bruce Ashfield <bruce.ashfield@gmail.com>
Reviewed-by: Mark Hatle <mark.hatle@kernel.crashing.org>
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 src/wic/plugins/source/bootimg_biosplusefi.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/wic/plugins/source/bootimg_biosplusefi.py b/src/wic/plugins/source/bootimg_biosplusefi.py
index 4279ddded83a..cd7cd270a970 100644
--- a/src/wic/plugins/source/bootimg_biosplusefi.py
+++ b/src/wic/plugins/source/bootimg_biosplusefi.py
@@ -19,6 +19,7 @@
 # William Bourque <wbourque [at) gmail.com>
 
 import types
+import os
 
 from wic.pluginbase import SourcePlugin
 from importlib.machinery import SourceFileLoader
-- 
2.51.0


