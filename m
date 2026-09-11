Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807EAC88E4D
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:14:03 +0000 (UTC)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48520.1789157633607280569
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:13:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=EtSA6xfn;
 spf=pass (domain: konsulko.com, ip: 209.85.160.171, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-530e1b6a689so3232471cf.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157632; x=1789762432; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tCsPxXqlyhqigTo3uU/7f28ifNt0kjjEj67M/hunOgk=;
        b=EtSA6xfnu/Nb4bONhCoIf+z9+bNYnzDhKDpPEOoWM3CXI6IH7D/SYCjaVA6d3cZ8XN
         zDjzFspCfSlXeZsHu/GKfVsdnBvATJWqOfWAETkpBR19/ANyYTmB5dUUt8SNvTwuscQu
         EwJdkn+k857TxWYgU8uu/xfBQabWxQJQWHYS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157632; x=1789762432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tCsPxXqlyhqigTo3uU/7f28ifNt0kjjEj67M/hunOgk=;
        b=MWRrpp5e7mdPjMaLoVbGBECud9xn3iGwSSkj0hlkJt/E0TsxvzlyNoOS9wkjQDCMQ7
         aek/6oDVBymrv2xqeYXhoDhn5xDeWnqZ6HZsGl2qXq+84sa+Y+DftK+1d9zFiXYFETkm
         taV+dlUboORf2oLF694SZYD69QB3NC9M3pwJxkZVSDuC3LIp0psDoIKjuePC7ypWtnfC
         9ifSRchXbHXx1LzzM4dE3YImusg8ATyUFCb3XPMT0x1Eyw0lgKjbqsvEoy1+UI42B/jR
         wQY4LSV9gK9PkfK84tW0Qj1h8/XL0MRFXKgW2O2M+DQxAygtjdOXH8TsqQlGpKbipgqv
         sXkg==
X-Gm-Message-State: AFuF++nt9tDfkubDiSRrUh9+GQ9rcmLeQBTmqGuEjA43XN+76BJ5m51b
	pWHx13Nx1f3ysY87lOExEjcYYTVT00DRbvaTvXpCvT/Y0mMObVbLOQptRaxTzWW0D/P+cQqmdKi
	hQSNv
X-Gm-Gg: AYBFou3uxhmfRZXzxRr/3YZQTWq+NpIBt+afQgpAWsXmGuwE4IuAqDdXj0sNQh5JUKa
	/uJ4c8dtS5U0TCDW2E2BRJlXA0Q29SlhKtfc5+PCa+/psA9SLHfhHpJD73kuVjIYBnWQy6a9DIi
	7PJAedeuKWEFcsPBaHfhNjZn/WiCs5X4knLrOSn4+604CWGd7oLX4YWVcaasdAwbYdk/tlRQ09S
	4N4dmTaQw0jHo7WxGv03tG7vnvMiV2XRsFr7HXbiXefw6kiNddA2OsnGix6B5csv7hh1Yz/d0C2
	AZrwUfAc0B1lNAuCZTMKxxdhfvdHCqWvUcLtqRE+RK/AwdbFrtExkQK81Z9OwqhB2SQXcrmMkhD
	7J4IPS8+5J4PrBW3YEh3+eOwJWR//4TlLZE9Gr1JwcdickkIGF7lqziqGasC87Q7oj3spSqJfTb
	AdVfGlEFay9pABlR9UcMeT5GmbRZ1jXXqUX5b+Yx9SjS/fqagDv3MFb4BO115PFgFhPz/1lmjih
	66gfBedQnout0xyqjbODQQWITWnNN+XK7qArJJp9eUqTNv/JJJXoJ6eGJYUJxlo2JOa2kfLp1as
	HNOYng2kyx6Ivh7IhhwbhUNP3FjptJqKXNU=
X-Received: by 2002:a05:622a:550c:b0:530:2512:f6d8 with SMTP id d75a77b69052e-530c8226d41mr93832601cf.0.1789157632151;
        Fri, 11 Sep 2026 13:13:52 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530cc781402sm25826061cf.7.2026.09.11.13.13.51
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:13:51 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 14/37] cargo-c: add missing build dependencies
Date: Fri, 11 Sep 2026 16:13:00 -0400
Message-ID: <3fa4860fde509a0f355e1b09141c758343097a41.1789156653.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789156653.git.scott.murray@konsulko.com>
References: <cover.1789156653.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:14:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4780

From: Ross Burton <ross.burton@arm.com>

Now that we're disabling more vendoring, add missing build dependencies
for libgit2 and sqlite3.

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit d20e3170fa9a47a6fe8babf6f533738de30797d2)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/cargo-c/cargo-c_0.10.24+cargo-0.98.0.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-devtools/cargo-c/cargo-c_0.10.24+cargo-0.98.0.bb b/recipes-devtools/cargo-c/cargo-c_0.10.24+cargo-0.98.0.bb
index f4caeef..482a342 100644
--- a/recipes-devtools/cargo-c/cargo-c_0.10.24+cargo-0.98.0.bb
+++ b/recipes-devtools/cargo-c/cargo-c_0.10.24+cargo-0.98.0.bb
@@ -15,7 +15,7 @@ DEBUG_PREFIX_MAP += "-ffile-prefix-map=${CARGO_HOME}=${TARGET_DBGSRC_DIR}"
 
 inherit cargo cargo-update-recipe-crates pkgconfig
 
-DEPENDS = "openssl curl"
+DEPENDS = "openssl curl sqlite3 libgit2"
 
 require ${BPN}-crates.inc
 
-- 
2.55.0


