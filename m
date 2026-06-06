Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A839CD8C88
	for <webhook@archiver.kernel.org>; Sat,  6 Jun 2026 02:51:58 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9588.1780714309672795267
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Jun 2026 19:51:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=FwwneHtJ;
 spf=pass (domain: konsulko.com, ip: 209.85.214.170, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c0b944f6edso27029145ad.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 05 Jun 2026 19:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1780714309; x=1781319109; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZMHZo1p5cPVLHL8E/jw+HN4FWT+g9rk2ugPK84Qse8=;
        b=FwwneHtJJVg73EDpMqFAq2+ULG5sR+pOu8hIHjD6OThbv6ObiT8A4IJ1Mgqkh7IsPC
         +sTHa1GPHMsjMG4a8S35RIPYvJ5em9bmrVb7Mg9rLZ6vMECoIailoH9DHGdHFnMNcdoW
         mtTnSwm+0wUax4ApsPdWzo0u1VtHyhFOf6B5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780714309; x=1781319109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bZMHZo1p5cPVLHL8E/jw+HN4FWT+g9rk2ugPK84Qse8=;
        b=Pil+9IJRbKqSPpTHnYEwphrmLTslBIHGogtClOgFwSRWGGPsutFFt+sExRC6Rzd/vZ
         /A/P9Dtk99MvEZBViSbpSgiUEmwqOk+Lc94fo0QuMkE/fKnrjQaJetfzN3DXKxz2gZk9
         9c4SSFVoPYEOR7MuQkWQ21EenMEOB8NIn/Ns/2cOc+VWnNYN4N2MJcz1k1c8Uh0F3rPi
         e3CBUJ7X0dcLzyg0VGLSoHBebYjTPTFHTiT465w8RjTBgkrqzQngzk0k6BeahReCOdQq
         eDe047/fVt53M+zHE0IwFaikYJzibsg7pimuiZnH3AolQUHd+a6ZSWNfCxNuLX6c2UhB
         sVjw==
X-Gm-Message-State: AOJu0YxlsJuqXHT54CDMoem1rZQSoORVxkM4NK4b2mbw0WP9L/beVCiJ
	Gpx8id2qPfAQVoKrsoy/GM2aqZdjPEIBnnxji52AozLGuGzDkj5W7xjkzbbxQcfDqaeUq98Cuu6
	1DJmr
X-Gm-Gg: Acq92OH4JwBlr0pGnSMzkxFKkYoQyocx8QukfaIMGgh0hs0TlTJwCBull8KKWMXRINp
	22etHIrvRf45QXXoR87wAxRUVIups9ulJ3LXiUh58IPzvjNVAiomK10zKtLQUvcbZ0RaIbZb313
	9SLZ504B5ERmZ3zD7AMooo0ocbxan+ZVXGbvYAhtgkpIq7Aa4Aw8ForraGNwBC8DQiRBoG2omgX
	4qzsve+gGpBbrx3ySi4ybaIa2EkYw+MwzOspmswziIdDuOJO17UuCGbIKiItCk5elyi8tPPR1Zy
	4WrUf3pH9ciau7CvSDtWM/fWl3ll/a7pkbLggVY0uQbFMAwHdDzytOsumYuSWD4jgbPZ9qhf8Tq
	dTLMxVTZf/MCzsGlVNhWSdBrK7OaroNxdgVWlsG+0m0zYxhappZNobCSaUwUGeV63Nsc3iafoDH
	KeAH8Cwb0ESPoXXTm40hlAm/vyVHdkkgNeza6mKlFAG5Di/q8SZGkeU07daXUU8t4Mulivb3guX
	iF+rrzJUZ81
X-Received: by 2002:a17:902:da86:b0:2c0:f807:56b6 with SMTP id d9443c01a7336-2c1e7b3578cmr66590605ad.4.1780714309092;
        Fri, 05 Jun 2026 19:51:49 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d2bbsm112225495ad.1.2026.06.05.19.51.48
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 19:51:48 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2][PATCH v3 6/6] scripts/run-push-containers: remove all images before push
Date: Fri,  5 Jun 2026 19:51:20 -0700
Message-ID: <c21fe441965ef9fd801338f017109592dba8b9e0.1780710041.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780710041.git.tim.orling@konsulko.com>
References: <cover.1780710041.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 06 Jun 2026 02:51:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4161

From: Tim Orling <tim.orling@konsulko.com>

Workaround for errors like:
Error: reading blob sha256:<hash>: file integrity checksum failed for "<file>"
Error: reading blob sha256:<hash>: EOF

The first time the blob (e.g. bin/bash.bash) is copied, it succeeds. All subsequent
tries fail. Might possibly be an issue with sstate or a recent change to vcontainer-common
to allow for multiarch containers.

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 scripts/run-push-containers | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/run-push-containers b/scripts/run-push-containers
index cdef497..4f1ac53 100755
--- a/scripts/run-push-containers
+++ b/scripts/run-push-containers
@@ -94,6 +94,8 @@ script = [
     # password from stdin (see login case in vcontainer-common.sh).
     "trap '%s-$(arch) memres stop 2>/dev/null || true' EXIT" % runtime,
     "%s-$(arch) --config %s memres restart </dev/null" % (runtime, auth_config),
+    # workaround for 'Error: reading blob sha256:<hash>: file integrity checksum failed for "<file>"'
+    "%s-$(arch) image rm --all 2>/dev/null" % (runtime),
 ]
 tag_cmds = utils.getconfiglist("CONTAINER_TAG_CMDS", ourconfig, args.target, args.stepnum)
 version_recipe = utils.getconfigvar("CONTAINER_VERSION_RECIPE", ourconfig, args.target, args.stepnum)
-- 
2.43.0


