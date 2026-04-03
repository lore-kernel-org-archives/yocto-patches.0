Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEF1E8539C
	for <webhook@archiver.kernel.org>; Fri,  3 Apr 2026 18:37:17 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2232.1775241430390047976
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 03 Apr 2026 11:37:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=n5mI1A3q;
 spf=pass (domain: gmail.com, ip: 209.85.222.180, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cd71fb9f06so137908685a.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 11:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775241429; x=1775846229; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fslr0ZTOSbC0GhFETUH0C3icsmKy2xY7g02WdO6Qqc=;
        b=n5mI1A3qBEMKz+rQCeXHD3em1QpdIS+jVotEkdDgzBlwQ7Qak92ygWZZo5WyevQ89F
         UqN5k8RjniBzUtPk3Y4QDHWhTlimw8h/9HLv3kv8t69gveSrY35E2Kn3THBW8PzJBcl0
         Pf7ihTEAuqI94pcFQeLe7XtzpvKy5nLhJhxm0AwaEPcgpQ6oQVzbvgoGjTJyEQ1J49SJ
         QABGIQvrctp4eQu1ncHQwOyXJ3QpYwRW7rwpU5Da1Zc5u2F/Vld1GAj8zT4bHZWKvDvp
         GlDz5MoizfAV649YDk17EQ543qybo/GtPd6yMgHqk7UOz5njN0m94Sdn4lNqXkRu2Kxp
         9eFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775241429; x=1775846229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8fslr0ZTOSbC0GhFETUH0C3icsmKy2xY7g02WdO6Qqc=;
        b=gyMW03N94PjOR02r47S/w5DQzVj4PZRHDrlt00tBDvNCm3NntiFv1Gpd+jF1wIeBgS
         1Bd/jYa5lc1pUxBRSmYwcl6pU/zNqQogVtVfwxvKfSssk1UnI9OHg1FEsn5vBRLQ9HsT
         1jGAhQNgB9xFK7TTds0LMzWQVybq+VlsxyFSVMtQDfDJBUa4Oj8DGkKiWJI9APScdP8U
         8Jv8NMK+/uxIOs99x0ExZvG+Y3051tVA6gwfNqqm7k/E71BNy2Q+e73IUePog4hDfA7A
         fc5UBL/E5m4ZKIJtvYC2shfQ6k2ininV2MpMGFDKnzv88nScJpY79Wi4b0UCgXlaQamr
         11bg==
X-Gm-Message-State: AOJu0Yx0d2Uy3UM5QwOuYhIJm416qtAPybdLWvM3sCeDTRQvyYe+oCJe
	hlTBYKfkpJp7oU5nHUsUOwleEZIPOdqYUtpOwk4G2HLC49UX1zY37AruIvPPHPpY
X-Gm-Gg: ATEYQzzHi6F6dAO+hjFBk4JJoFkSmScNO1kv/t67QuXUlzB/0VrBGmIOn2PlWTsljkP
	jjUvyXvUVf+qbB1w+AnY1oMhcokDyU4WI7XnT8hm2tRQraaAzjCMW+f7PHx4F9GY9l5Dr9adDiL
	o9hKefQLW6Gq48wssSN3ug9xUshdg6Gsq5SZtOPo04YbDqGNfRGDL0YyB77n+aLOlNXzLy2R/wY
	I1QjSMnmkzO/jqcTrrsK2rvcY+oEEYMGf4Zbez0mpL49bZ3N/awHOY2gK83DUxQscBtOQixt0Jo
	7y0PAfW8ZzcAZD1kOOBmG6FuLvQ/Max3x+OgEO2huskEK8mbd3tXJwCLosqAfjB/JIy2pGkleld
	1tmX+FUR4Stk6PjmNGdG1YwelrmqDLE8ZxgKuORKh6eMwGWOd2ViAs1671EJifFLx0tVf0xibjY
	x3CtjZNDYhexbBjHe0+bfAE+C9nTfmTD8BoS3cKp1CdGjtyMwubauBllfqKDe0hzRnXQ==
X-Received: by 2002:a05:620a:4890:b0:8cf:d88d:c46e with SMTP id af79cd13be357-8d41b3e9eebmr598305885a.48.1775241428786;
        Fri, 03 Apr 2026 11:37:08 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a874459asm472401785a.39.2026.04.03.11.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 11:37:07 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Bruce Ashfield <bruce.ashfield@gmail.com>,
	Mark Hatle <mark.hatle@kernel.crashing.org>
Subject: [wic][PATCH 9/9] cli.py: fix main() for standalone mode
Date: Fri,  3 Apr 2026 14:36:44 -0400
Message-ID: <20260403183644.2783267-10-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260403183644.2783267-1-twoerner@gmail.com>
References: <20260403183644.2783267-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 18:37:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3635

The generated hatch launcher calls wic.cli.main() with no arguments, but
wic defines main(argv). Update main() handling to match.

AI-Generated: codex/gpt-5.4 (high)
Reviewed-by: Bruce Ashfield <bruce.ashfield@gmail.com>
Reviewed-by: Mark Hatle <mark.hatle@kernel.crashing.org>
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 src/wic/cli.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/wic/cli.py b/src/wic/cli.py
index 04b2ad25cac5..cf3e51e3afad 100755
--- a/src/wic/cli.py
+++ b/src/wic/cli.py
@@ -590,7 +590,10 @@ class WicArgumentParser(argparse.ArgumentParser):
      def format_help(self):
          return hlp.wic_help
 
-def main(argv):
+def main(argv=None):
+    if argv is None:
+        argv = sys.argv[1:]
+
     parser = WicArgumentParser(
         description="wic version %s" % __version__)
 
-- 
2.51.0


