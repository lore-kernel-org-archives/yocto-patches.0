Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E92C71121
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 20:10:16 +0000 (UTC)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
 by mx.groups.io with SMTP id smtpd.web10.5978.1724875806194434120
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 13:10:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=iC6x9W5u;
 spf=pass (domain: konsulko.com, ip: 209.85.166.48, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-81fd9251d99so268476339f.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 13:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724875805; x=1725480605; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cLEnGopaq519aKSgreqFgp4ha+L/EawJG/DISXdOrKs=;
        b=iC6x9W5uonGeoc2Chs1cvk/B2WzT8iRjnJw1zhNfL66kwWSqYqqP4ZhFcCAZ4jQYTk
         M1Sx/f5grBQj9A6U4MNhWG010EW6TlbTttqzizPiskyV5ZSx8OsfLPeOC5RXLlCKGSPE
         uRplDbsM/wNP9+yDzrjLPtCRJp46a3RGNiYXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875805; x=1725480605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLEnGopaq519aKSgreqFgp4ha+L/EawJG/DISXdOrKs=;
        b=oh9aDg+btgjALJ2P+wPzC9VCKxBYMHRMj7LSO1NNP/DNO2yZuo4KKatLbGISfWbcik
         JWbjBXj7+gaVElZxgYVCK5rmjC5ukAlzolIHbj5bF2xYBVlb2qZsohsqVhZbet7ZyduP
         4qgYLGu6VyH3NM+lgXvq5VtF1K9P0VnnA2mJ0dOR4IPzRNH80cXOPZ4jTJP5u3rYxSNX
         ZefYUIrak+JRqZd2g1hOGoeUvKoCP7VoDs0++1eETKKtHAPtisdmn5pNuuaFdnBM0ztb
         cEbsUmBdA08SUuuwcPaT9edALcGMzRiepIKi1wDaUMqPasV5inpe5U/hxZlSTKsSnqA9
         TSMQ==
X-Gm-Message-State: AOJu0Yy6krOSok2gpmSkKXVRcA7/oj5ohQIU29B6dqAqHz1lsvMnPIoc
	RPyNaLYV2k74QI+V23rAN3R4KN49Byf5MUNCJr+UXG2GuFgLMBlhDwta1lb3asyRZm2kMyrL+uW
	X
X-Google-Smtp-Source: AGHT+IF4v3C5DRpwA4KMfgNgmFzOLq2C7yKH1pOLNSIwK1kJGG0RuITPznGKgc9k9xtUO9leVeZDdQ==
X-Received: by 2002:a05:6602:13c1:b0:81f:9826:19ff with SMTP id ca18e2360f4ac-82a110487eemr75731639f.9.1724875805091;
        Wed, 28 Aug 2024 13:10:05 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced0da0e2csm25431173.109.2024.08.28.13.10.04
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:10:04 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 21/33] librsvg: upgrade 2.58.1 -> 2.58.2
Date: Wed, 28 Aug 2024 16:09:07 -0400
Message-ID: <809eaf086d31a8f6595dd87032ccfa72d7e8a59d.1724874972.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724874972.git.scott.murray@konsulko.com>
References: <cover.1724874972.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 20:10:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/588

From: Wang Mingyu <wangmy@fujitsu.com>

Changelog:
=========
- #1087 - Don't leak XML entities when the XML document fails to parse.
- #1092 - Fix stack overflow in <use> reference cycle.

Signed-off-by: Wang Mingyu <wangmy@fujitsu.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 44d0a6a347b134e4dadabbcc5e2b833049203502)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-gnome/librsvg/{librsvg_2.58.1.bb => librsvg_2.58.2.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-gnome/librsvg/{librsvg_2.58.1.bb => librsvg_2.58.2.bb} (96%)

diff --git a/recipes-gnome/librsvg/librsvg_2.58.1.bb b/recipes-gnome/librsvg/librsvg_2.58.2.bb
similarity index 96%
rename from recipes-gnome/librsvg/librsvg_2.58.1.bb
rename to recipes-gnome/librsvg/librsvg_2.58.2.bb
index ed4ac38..08492a0 100644
--- a/recipes-gnome/librsvg/librsvg_2.58.1.bb
+++ b/recipes-gnome/librsvg/librsvg_2.58.2.bb
@@ -23,7 +23,7 @@ SRC_URI += " \
            file://disable-rsvg-loader-test.patch \
            "
 
-SRC_URI[archive.sha256sum] = "3728596290a8576d305d06ec8afdf473516feee9dff22e03235eac433d56824e"
+SRC_URI[archive.sha256sum] = "18e9d70c08cf25f50d610d6d5af571561d67cf4179f962e04266475df6e2e224"
 
 UPSTREAM_CHECK_REGEX = "librsvg-(?P<pver>\d+\.\d+\.(?!9\d+)\d+)"
 
-- 
2.46.0


