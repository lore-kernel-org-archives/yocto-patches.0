Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE47C88E53
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:14:06 +0000 (UTC)
Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48533.1789157644700846948
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:14:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Gx6XNtaq;
 spf=pass (domain: konsulko.com, ip: 74.125.230.205, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb76798a2so749721cf.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157644; x=1789762444; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HKwl9US/X+gWA6F/4IkufsX29NLSvrhodlJQj4dAfaE=;
        b=Gx6XNtaqKX8pk1q4EENFKhDqFXQdcsjUhSnaIcnBk/UF57lxhbfc96R80YGlyoz53t
         o0mPEe7ruEVNgVltqpVR82bqmjIiG3XISxXCX8EG9WhgU2uuej74jus7epF3ozdXr7UN
         Hg7jmj3m/5oRL/6yFG64Fi/JVqAH2si2wk5do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157644; x=1789762444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HKwl9US/X+gWA6F/4IkufsX29NLSvrhodlJQj4dAfaE=;
        b=ScLzv7VhpR4tnj7j0zLFakO/XUUXVftbv8Akfn/E4EKp5QG3JsTDlye+pwoMYRma4u
         4xV2IA+2E3NwMAO384dLQnMtBGRKqwTS04wunjFENOt5xMSgADBPJWoOmpkwzYb+RohA
         RTwjC8zqC8xzCiSaiHPIiGjMK33JTYsTtDNXvg3MwtXCO4ZofekCBI03wB/Z/rsVf21L
         Eb4PSXwy5AUpZBVozKwIuBV6DQdTM8swhs7Jy1puTHJ08liut0SmA6nxh6IZWBowEKh0
         VBeXHPYAC3oRixj+YUtTVSqsxe0eH0uVuB8j5q6QhaQIe93L2VUOgyWFGu5BdOH7p/n/
         LT+Q==
X-Gm-Message-State: AFuF++mLyALmmwJnjIaVhBLepgBWz90FGSMkvn6OAHBGfX/M4eve5x9t
	E4covt8fwo1RsVHdk8WIYI90ycyKcZm5XsFNRFYqzi54JyCnx370qgyL0ywRIyCEIrvTudOeG39
	OoXtn
X-Gm-Gg: AYBFou3Z9Hu9lX48Jqj68D/U3B3rAW2giL96nUw+Id8rj0WBzBWdhQhy0lM3WxUvASP
	1BNY2YWp90iiKhhHWsOQB+KotAex9sH9ntOedkHfcndSS0M8MBJOktVhrkvqyLFvY18Km3MKdre
	Dz6F3xL+iLmhKPaHPtX451fxS+tMQY7v/I2pweJl0/nxIc5t0LV5BzTzEyyIhwa60xBXafNmFQz
	aKVU96QkU1/sGViImwnA+YbcKZWQ2c96LE9MsLkAdVeiCmWKw3fhF8O3YnuX9RNunD+UlRpqcQf
	N9ZcMFTOss/9+Qg2zBYBbDwDYzXZyzbe5REDHOXhoBeiTDXlO0LiFxdzZxSDPoyOXEDxGhUgyhA
	KF+64tdXnL7GUp8lfu5YvMvn32oAf8Tzoy33nDv17IhyFlfbZ6Hb4UuWY74qonQABMM6GXh6GlD
	6LEhu5v1694vo2MxnhPLUrKj2rRSMIBOqN26c8wUCmF1p6ZZCgVUqs7vwcdLNLl8lXMZjlBMi45
	820RzE6GR+8ppKaUAn4FfCf/k1gdcqtyc/Jklo7EXOBTV1NCAZe5kDbGKmuqqM4bTADjdk1ZDPu
	Q3mYwQsDhR7xe3Ka4o9fpkQCYlU+WdYVHF4=
X-Received: by 2002:ac8:5f4d:0:b0:530:90a6:d28b with SMTP id d75a77b69052e-530c8533b53mr71815951cf.8.1789157643211;
        Fri, 11 Sep 2026 13:14:03 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530cc781402sm25826061cf.7.2026.09.11.13.14.02
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:14:02 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 26/37] libgit2: set correct homepage URL
Date: Fri, 11 Sep 2026 16:13:12 -0400
Message-ID: <54deb3d307ce3d77a7e3516f554fcc01e744bc74.1789156653.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789156653.git.scott.murray@konsulko.com>
References: <cover.1789156653.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:14:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4792

From: Ross Burton <ross.burton@arm.com>

libgit2.github.com no longer resolves, the homepage is now libgit2.org.

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit ed4467f06e069573450c4746c506da40d959bb16)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-support/libgit2/libgit2_1.9.6.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-support/libgit2/libgit2_1.9.6.bb b/recipes-support/libgit2/libgit2_1.9.6.bb
index 38a03fb..67322cb 100644
--- a/recipes-support/libgit2/libgit2_1.9.6.bb
+++ b/recipes-support/libgit2/libgit2_1.9.6.bb
@@ -1,5 +1,5 @@
 SUMMARY = "the Git linkable library"
-HOMEPAGE = "http://libgit2.github.com/"
+HOMEPAGE = "https://libgit2.org/"
 LICENSE = "GPL-2.0-with-GCC-exception & MIT & OpenSSL & BSD-3-Clause & Zlib & ISC & LGPL-2.1-or-later & CC0-1.0 & BSD-2-Clause"
 LIC_FILES_CHKSUM = "file://COPYING;md5=8289345c8713c385f45ec0c6c8a0d080"
 
-- 
2.55.0


