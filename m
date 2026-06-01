Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1920ECD6E55
	for <webhook@archiver.kernel.org>; Mon,  1 Jun 2026 23:17:49 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12691.1780355868264496514
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Jun 2026 16:17:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=lyLQx5op;
 spf=pass (domain: konsulko.com, ip: 209.85.214.181, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf2e8ccca1so19789725ad.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 16:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1780355868; x=1780960668; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UushDgpJCHQe0Y2FluKNYZ7ooFItwXqIlxSI7Ww5DF0=;
        b=lyLQx5opdWLnZKik4WAKOmgqSAZ3gB8ONVVzLXCo/FqyiHQbJM2n88kOm6GVopjqp/
         wQPJ88OvZrYoDJgK44mtzoae7u0PzVA/y5BEZg/dE8FruXOadQU13Lt7PXP6j7sRykyN
         0pfsCvmxZrYPvzmhGx7ZnsozjppWPBvSzE0GQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780355868; x=1780960668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UushDgpJCHQe0Y2FluKNYZ7ooFItwXqIlxSI7Ww5DF0=;
        b=kgkvcKNN8kgOwOd81YrOECh3tarqzHsnt2zAmOsJNpNBoXD/sMNqaynoQaqfpJ/9bO
         XrtS020zQRQr+qsyClaayaZ8CQS/66QH8DMwnNFIddQv2ef4zd/kLagC28Njy4o8hiiN
         sGx2/L3gpn/Sy6aftr9OwRelbTgcoP+IWvSvKYoogcMv4KY6yMXvmVJQmtfqXOE+pB/p
         j/2dicrcxjux3lAaoPeMS0F27ueKVGzTiDvvQp4wjIt9ODMc4GQE5lOC71tHcViOMvID
         9OvFioSDfozyT4+s+7uWkAtvPuy4SUgluRlLoW4lmaejimgor81PSRk79qZ5WjxgRk+O
         QTHQ==
X-Gm-Message-State: AOJu0Yz9mctMjW/EUmSubdQGchN1yS9X18VEXQ3ANKZpW3B0pTCy1XYE
	RqBQsqOrfFFvvntGLU+4X54hCtpz/6Chlq1s+9Tz55EPvHcaVC61kHlJ/gJV4g+g5bvOkmGOFvO
	6NcId
X-Gm-Gg: Acq92OGvn0iv38d0eWXtqywIARJ2wSQ2AOghjX1aDd0q8Zxqu+3voeQtqTfmBec776+
	si+XLERUou1okJg8COKBwDS5RuYWLDkxGpEtbt5LWTLEXAlgNdN3687W1U674F8AIACfxToJ6Xy
	l0jT0+KcDaheyyB2Z2ee4pT4slZ2I3DcrhfpUZR63ww3S/aCQbp3RkqPvh5i/v61zRLgLwjwmLk
	8IgumqXCo8kQ036/yl+awzxJkMiHJXK7aTtwXQswfMR1OBWZeKSJTnY37mAjvOuEJ91Y1eHsBqd
	zzkp8sY8qijwYsQjj0omsxMasKQo4xtYL1J569bxLcYs38WM6mE+zhyO/kmdeW/me4VgwOOBQaj
	eZ2HZpBoA9837w99eVGb4HBXvAJxFjvRL51ybciw/7fZVpGN2EsjsQJgX3dNnReeXZCEIon2wHQ
	XHH31u0sWVIESSGUnwuEBGdM49yX1v+z0sPkfVgL9IpsWAqnDvJg5I9NhukF0e32w1sghXm9EFA
	A==
X-Received: by 2002:a17:903:986:b0:2b4:59bf:5728 with SMTP id d9443c01a7336-2bf3682a21bmr139534995ad.25.1780355867611;
        Mon, 01 Jun 2026 16:17:47 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c51f80sm119115075ad.80.2026.06.01.16.17.47
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 16:17:47 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2][PATCH v2 1/4] config.py: add vcontainers-tarball; containers tag
Date: Mon,  1 Jun 2026 16:17:26 -0700
Message-ID: <77f45f09767e9ddb3ecb3d0be1dd512b57bd4e4e.1780354388.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780354388.git.tim.orling@konsulko.com>
References: <cover.1780354388.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 23:17:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4093

From: Tim Orling <tim.orling@konsulko.com>

Initial steps towards containers jobs.
We will need vcontainers-tarball (similar to buildtools job).

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 config.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/config.py b/config.py
index b5b2b62..630c8d3 100644
--- a/config.py
+++ b/config.py
@@ -34,6 +34,7 @@ buildertorepos = {
     "metrics":  baserepos + ["meta-openembedded"],
     "metrics-gitstats":  baserepos + ["meta-openembedded", "yocto-docs"],
     "meta-webosose":  baserepos + ["meta-clang", "meta-openembedded", "meta-qt6", "meta-webosose", "meta-security"],
+    "vcontainer-tarball": baserepos + ["meta-openembedded", "meta-virtualization"],
     "default": baserepos
 }
 
@@ -159,7 +160,8 @@ builders_others = [
     "oe-selftest-ubuntu", "oe-selftest-centos", "oe-selftest-opensuse",
     "non-gpl3",
     "meta-webosose",
-    "meta-qcom"
+    "meta-qcom",
+    "vcontainer-tarball"
 ] + old_arch_full
 
 subbuilders = list(set(trigger_builders_wait_quick + trigger_builders_wait_full + trigger_builders_wait_perf + builders_others))
@@ -325,4 +327,6 @@ builder_tags = {
 
     "metrics": ["metrics"],
     "metrics-gitstats": ["metrics"],
+
+    "vcontainer-tarball": ["containers"],
 }
-- 
2.43.0


