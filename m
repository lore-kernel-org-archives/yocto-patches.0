Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3CCCAC58F
	for <webhook@archiver.kernel.org>; Tue,  9 Sep 2025 18:50:30 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.web10.3372.1757443821547204753
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Sep 2025 11:50:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=oF6lygY9;
 spf=pass (domain: konsulko.com, ip: 209.85.222.169, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-80e33b9e2d3so552074085a.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 11:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1757443820; x=1758048620; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fxdiAllBwmvJZ4Y+obHurUEDr5hVQYXmofjuNYjcRAo=;
        b=oF6lygY9uSICBBIz97E8mH8m6cY5YDKNX8lYe330MmcRUNFTHaeL0cN6+/jL3abt+e
         pbM5uCYzLfVkg8RziCXvliLzMYkoIsrD0V3JQT/BmeEW8A8FSsSwmhSzSEy2c/zEMEpJ
         RdyAqQB30DQK2DWfz1rP9aaYQrcD+rqFO/OhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757443820; x=1758048620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxdiAllBwmvJZ4Y+obHurUEDr5hVQYXmofjuNYjcRAo=;
        b=MwXJfUSZ2Pz1rK9yRBB8zJtBaf0+jpq8CPp+cSdPW8litSn6TSuEMefaevHxZy6L9f
         z5TiuiYZKk+I4cgu7w2SFnEy1tU+j3UpLBlRR5wLGqpiesWPVQ6vJUhMwEJvLNPxHfjk
         Qq8R5+u+1wO+oKPzWyqIpY0WFd9MCarbfi8fm3UzQVFfs3e2KfeZgu5YK0uGbLDiADqY
         nk1zrnkQPaHCWvzW1FWY3XV7rPANCEfM9CkzV4Z6U0z1cPRUyXE4C8huMIFJNHGCInrv
         TUsH3PaMx/TdUn0ZInkyaG03e0e3Qjp04rYmdEw1Ms9FjgQJS7iloRxHfnFF5xlQ62g1
         WG3w==
X-Gm-Message-State: AOJu0YzWbtfxJqBGS7VEM64N74ziBL89HVn6Zw2oE2+dAfo35rZTFBU+
	ZHAuypZ9AzI3/u2sIQN87IN6+U9S8lLHhv+VsqmwNod2BFKFoWVKYyDIwZ3uRuUrENNpzUza0xy
	H+uyf
X-Gm-Gg: ASbGncsjBCam3OS5KvtG2K0UnN3NVzKO5GQZDVKYeZp9mx+kEwrlaQFZwRAbW2wLyB1
	mIMuPuqDVasOc4nbljXNkbTocHkG8TlQANwy9qo0t54/bqCrYJqPnzGYrV/2V3RuPG+DCgUkaIH
	1iVXz29vHGlek7zC7XUb+h5R9PSJbbYJv2BLamI1mVgfgueVSHiAuadn7UVIG4OfdDQPNEww2/v
	I1iT7fdvvA1M+zRElZFpa1XiqlNuL6BGOjuv6RMnd1ozOh9N9dQWq1KAb8qUskZbELnKMMYD8KI
	MY1lTzah/djovt5qHAwWssUytYjyb3Z2SJdR+h8TIemA3EIyagtvkMC2pbSWRh3S6nqlVBMgJYs
	7dVu7APZF+O2MzG+b1laftRPBDfV/CdmxWbIyyVJhf5kJ/svJzremfJ3snHRr6bCzGvi7exfvKQ
	==
X-Google-Smtp-Source: AGHT+IF4i6szIcTD6cIFy5RMKR2iGYeClWAxa1lus6yVd1XZYdZIHgnmV2md9dbcJi88+yPzKPCcdw==
X-Received: by 2002:a05:620a:290a:b0:80e:1081:90e3 with SMTP id af79cd13be357-813bdf67d02mr1145577385a.11.1757443820256;
        Tue, 09 Sep 2025 11:50:20 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5ec7d3c8sm161168685a.46.2025.09.09.11.50.19
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:50:19 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 1/9] rust-target-config: Add has-thread-local option
Date: Tue,  9 Sep 2025 14:49:49 -0400
Message-ID: <a6ec757fc98f9b8a29b55d7321e4a184ef091e50.1757443674.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1757443674.git.scott.murray@konsulko.com>
References: <cover.1757443674.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Sep 2025 18:50:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2168

From: Per x Johansson <perxjoh@axis.com>

The "has-elf-tls" option was removed by the commit
8e1614a906086fb46c5dd7b7f2dffab91194165c. However is should have been
renamed to "has-thread-local", since it was renamed and not removed in
rust by this commit.
https://github.com/rust-lang/rust/commit/391332c5d9d5a5e97a0d36e011a87ad43045cfd3

Change-Id: Ia1fdf7698ebeef62a88052713645d5b499164353
Signed-off-by: Per x Johansson <perxjoh@axis.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
(adapted from oe-core commit 18a87dd1724e0934a669aefae36d20374c06c493)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/rust-target-config.bbclass | 1 +
 1 file changed, 1 insertion(+)

diff --git a/classes-recipe/rust-target-config.bbclass b/classes-recipe/rust-target-config.bbclass
index d4149b3..9677fbf 100644
--- a/classes-recipe/rust-target-config.bbclass
+++ b/classes-recipe/rust-target-config.bbclass
@@ -401,6 +401,7 @@ def rust_gen_target(d, thing, wd, arch):
     tspec['linker-is-gnu'] = True
     tspec['linker-flavor'] = "gcc"
     tspec['has-rpath'] = True
+    tspec['has-thread-local'] = True
     tspec['position-independent-executables'] = True
     tspec['panic-strategy'] = d.getVar("RUST_PANIC_STRATEGY")
 
-- 
2.50.1


