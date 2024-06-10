Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E85C27C55
	for <webhook@archiver.kernel.org>; Mon, 10 Jun 2024 14:32:31 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web10.21141.1718029945846723102
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 10 Jun 2024 07:32:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=flEyvhjM;
 spf=pass (domain: snapchat.com, ip: 209.85.218.47, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6efae34c83so248482966b.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 10 Jun 2024 07:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1718029943; x=1718634743; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EPLasGHzlHW+xQR3tpjf4rXiczOTmT6wLQTxzcy6uxI=;
        b=flEyvhjMfkU4+xHpsWeMbcPqmrGF8zfo7YGgWK4YsrWbIMtIOa3fnUJ1eJOs17RWK1
         tbE6riGVfxc+6pM0MKWGl+UxDWQt4MNaM9fRQ03eZyem4Wpk+h7nsIjS8wBhFdpaFE7l
         /R8Bx1O7B9aFuQ5d+2mFrdNy2+5T7QlBauH7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718029943; x=1718634743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EPLasGHzlHW+xQR3tpjf4rXiczOTmT6wLQTxzcy6uxI=;
        b=XsQR5seOvyqNxZNnQYnP4C9tkl1vH7toupWeipOfWZ6LU5EcFnUzeADlr6Ljskk+Aq
         K381Dv/QuwwXyZ/nUYgJTpvdFobQJsnQqoKceRq8KHOt7A0pg9HCJavDbWLKzk4IL1Yo
         dynA2ukDHlKFbXFaxVZMU865/vtnhbgu5pEcTA+xFbnFzZYmD/4DqVedB3z8vpN2FQSS
         OG2GaOtaDpAdAVDfZ9VYj7E7mhnBh3Fx9YWcQCcl64n6ynCs/Kvn/sGTD6ce/QMryShK
         diD/mO66j0dA1B72+4LWhooEQwyOM0fEbaJw/EPc0YgB3zSmeilpYxIIVLJ0teMQivOs
         ezyQ==
X-Gm-Message-State: AOJu0Yy7Fd/ZL1f+ktBhwLPDsWgTi1Pdp/utV6s8rLR6RBt2qWmMwryl
	22YeKr3gnZlLyrT/TwppderVhfIY6D5juT9fK52DB8bPxJ1+zCu0zp11M8XW63wzKIFx6UIIeLY
	wtvA=
X-Google-Smtp-Source: AGHT+IGZNOjk+WtUlaCLkIz0QhDEno0M5p4DcduGfvfrSBqA7F+8ZTd6olgkwL6FHqxQzBPB5KLydA==
X-Received: by 2002:a17:907:9720:b0:a6f:10bb:967a with SMTP id a640c23a62f3a-a6f10bb975cmr361990866b.37.1718029943447;
        Mon, 10 Jun 2024 07:32:23 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([213.249.125.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae237408sm7504233a12.93.2024.06.10.07.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 07:32:23 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 01/11] layer.conf/README: update to scarthgap
Date: Mon, 10 Jun 2024 16:32:04 +0200
Message-Id: <20240610143214.2376414-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 10 Jun 2024 14:32:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/283

From: Etienne Cordonnier <ecordonnier@snap.com>

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 README          | 4 ++--
 conf/layer.conf | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/README b/README
index 77ffdcc..4cea8d6 100644
--- a/README
+++ b/README
@@ -32,11 +32,11 @@ This layer depends on:
 
  URI: git://git.openembedded.org/openembedded-core
  layers: meta
- branch: kirkstone
+ branch: scarthgap
 
  URI: https://github.com/kraj/meta-clang.git
  layers: meta-clang
- branch: kirkstone
+ branch: scarthgap
 
 Layer Maintainers: Richard Purdie <richard.purdie@linuxfoundation.org>
                    Dominik Schnitzer <dominik@snap.com>
diff --git a/conf/layer.conf b/conf/layer.conf
index cdac803..2f14754 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -1,7 +1,7 @@
 # We have a conf and classes directory, add to BBPATH
 BBPATH := "${BBPATH}:${LAYERDIR}"
 
-LAYERSERIES_COMPAT_meta-darwin = "kirkstone"
+LAYERSERIES_COMPAT_meta-darwin = "scarthgap"
 
 # We have a packages directory, add to BBFILES
 BBFILES += "${LAYERDIR}/recipes*/*/*.bb ${LAYERDIR}/recipes*/*/*.bbappend"
-- 
2.36.1.vfs.0.0


