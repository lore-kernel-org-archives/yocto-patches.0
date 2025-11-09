Return-Path: <aalto.johannes@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26716CCFA13
	for <webhook@archiver.kernel.org>; Sun,  9 Nov 2025 17:53:48 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.29695.1762710823528238259
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 09 Nov 2025 09:53:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=H4Fwmejp;
 spf=pass (domain: gmail.com, ip: 209.85.167.42, mailfrom: aalto.johannes@gmail.com)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59431f57bf6so2191525e87.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 09 Nov 2025 09:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762710821; x=1763315621; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f5TrNbKGv4Ab6Uoe68x+nPLtFMAfP+My1njNlTx6BNM=;
        b=H4FwmejpZnnQfPgSfkNJWvcLZ87Ye1G081x7mt9Fe1SmTyMT2QZa85JlCTESy6GWx2
         eBXxJO8bwE4MTxr3sM6g8lvzJg2JrnGz13s9T5xOkzMIODLYiqEXmU2hQuBhY8U4Megi
         5nLPqnvyteqs6r7BWIYQmwl+RVagkbwY/YYRxrNvLKa/wNdKgZxQ729e3POwU7BAxdsu
         1p3FXUQV/U3MqnnrMNy0HRTPDPWx/YT8bRPCdhOk1bXXHMHTS4UALPNnen1OyKDYzCpR
         4EmHDcXt4BWX7H2rUp3K59X2IRFWBGl3rRfghI+ddjp4ApV793XA9H01/pet2ua/4q0Z
         YqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762710821; x=1763315621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5TrNbKGv4Ab6Uoe68x+nPLtFMAfP+My1njNlTx6BNM=;
        b=soZTmG0T/ZOkLUVz8GzZeifjD4IJWqWURFvRmIWD83cOwPjBtaljJA7QT5o0h0Zu78
         UurA4ShDojryA0xT+1TmqL3m9aj8jgkn940bRAkvQsvQaf1lbIPEY6QhJ2cgizul+DSB
         pNpW0TAI/6pD8/oOsi18gXa7836v4K0049qT0KbGgejQqmShQW8rcuq5su/2tRDxgMMq
         egABNVKe0rLKhDdjEmdGOBORNKGYeU7YidGCgg29f3gYAfw3RQUFXfal+bBTvxaplP7O
         PPQY+apU6l8w8pQUXZIwm+IB01fy8172sAP25UeNG6Zvm53WScdE9O45a5x4UmnLvWR/
         5DLA==
X-Gm-Message-State: AOJu0YygHYvZ4D9y+i1aEL1ugJkYNgUpskkWtQ/uNbU7elSqBIehVByT
	GOflXX6sNsJquSAsAyO9VREe77FhpQMymScIQRlSfl9BwC5E8FZf6gvx4ICFoQ==
X-Gm-Gg: ASbGncsbKFplG0YV6+o48j0H1FtRQ5UODEnlnpE4FL04hMrkmOJ8eDk4U/jEbAhhy6S
	7IL4SEcttobf/nlNVLwLMiND3kcSRa45JrsLp6YlNL+TJKfagxTx4WkvuqbCphqRVgERTpgKl4q
	lCipNIQKobzJFhAtXmv2UBjsdZfZy7g/jI3UIAfXs9FMMwWFo+kqM4axnS4MkGY+eZpovUjVXFY
	B/L/BrXjvzpXE9lp++YicJ+h2irEixIC2kv+2j+Q5KUIRo+nw5A24Bdq75fnwTirLdpOtxGbhV9
	3zgQDjiMdFypvj61aFRDr+8Ywxowy0geWRqgPu3cZsDw2icVwgmZUTW9mevML3w+9hYX1w2fvHG
	OtD/dNiPDRRx7uJJ7BAIH03LQFopfxcmRhTPdOV4ASJz+aRUHVNEn9RGBiOzhq31MZg9b1dJhNC
	i4G+MUIrzFuwlSHpxGDqT+oqL57d1meh9j8QdPm+4rvXNYdKh7ga17cfyzwhpdu8ax
X-Google-Smtp-Source: AGHT+IEoCr+BoVPoMpcuoN3NmOLov0LMDXsSM4hU4IcWnWsPdIEL/KfX5tYElKQiFGxiSyxZyLR14Q==
X-Received: by 2002:a05:6512:234d:b0:594:490b:447a with SMTP id 2adb3069b0e04-5945f1f8c66mr1432397e87.53.1762710820966;
        Sun, 09 Nov 2025 09:53:40 -0800 (PST)
Received: from localhost.localdomain (185-163-14-193.cust.suomicom.net. [185.163.14.193])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a590d44sm3150226e87.91.2025.11.09.09.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 09:53:40 -0800 (PST)
From: Johannes Aalto <aalto.johannes@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Johannes Aalto <aalto.johannes@gmail.com>
Subject: [meta-lts-mixins][scarthgap/rust][PATCH] Update README.md with SDK configuration instructions
Date: Sun,  9 Nov 2025 17:53:36 +0000
Message-Id: <20251109175336.257896-1-aalto.johannes@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 09 Nov 2025 17:53:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2464

Add the required configuration for creating the SDK.
Motivation for the change is that the steps seem to be slightly different
than the config for plain poky version of rust (and I guesskirkstone/rust
branch too).

Especially, line like:
 SDK_TOOLCHAIN_LANGS += 'rust'
and/or
 TOOLCHAIN_TARGET_TASK:append = " libstd-rs"

seems to create a broken set of libraries due to having duplicate libraries causing build
errors like:
 error[E0464]: multiple candidates for `rlib` dependency `std` found
   |
   = note: candidate #1: /opt/poky/5.0.10/sysroots/cortexa72-poky-linux/usr/lib/rustlib/aarch64-poky-linux-gnu/lib/libstd-370fbb2cfd29928b.rlib
   = note: candidate #2: /opt/poky/5.0.10/sysroots/cortexa72-poky-linux/usr/lib/rustlib/aarch64-poky-linux-gnu/lib/libstd.so

(although, I'm not quite sure if this difference in config is intended behavior)

Signed-off-by: Johannes Aalto <aalto.johannes@gmail.com>
---
 README.md | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/README.md b/README.md
index a00a00e..0f5c30d 100644
--- a/README.md
+++ b/README.md
@@ -29,6 +29,10 @@ Notes
   support are included, and the backported Rust test is included as the
   "rust_mixin", it is not guaranteed that it will always be in a passing
   state.
+- To include Rust support in a SDK, do the following in e.g. local.conf:
+  ```
+  TOOLCHAIN_HOST_TASK:append = " packagegroup-rust-cross-canadian-${MACHINE}"
+  ```
 - The intent is to track any further upgrades that occur in the master
   branch of oe-core, with an expected end of support in April 2028, the
   same as Yocto Project's planned EOL for Scarthgap (per
-- 
2.39.5


