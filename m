Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECB7CA0EFF
	for <webhook@archiver.kernel.org>; Sun, 31 Aug 2025 11:41:22 +0000 (UTC)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
 by mx.groups.io with SMTP id smtpd.web10.27758.1756640475975153732
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 31 Aug 2025 04:41:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Hrp7O1Z8;
 spf=pass (domain: gmail.com, ip: 209.85.160.172, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b109c59dc9so43531311cf.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 31 Aug 2025 04:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756640474; x=1757245274; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZHqDvhwChwTVS524rXUmQ8DqhSZWMEWBDE06+kXVkMM=;
        b=Hrp7O1Z8qZ2FHe2DVXobz1aFZpauohXjCGU9EKL+eTxZR+jK14442lMjD2130hWVly
         vFiGW8nOgj+tMHUSurTPY58QPg9CGkv8HptzjNEQOEkZOhdKaEn2r9KVV4Pyh5yPDIot
         Tgz5vkxauhoWmGwUjyB691BbPu32C5AGq9hEmIIp9C47Uk6S8RZ9Kw4pql+MqvosnM9i
         eQzdd20+5QJzQ2Mtib2Kst83sOyI1gW7AD95KfUgNm+husmIuThU9cqLafltMwgUy9wO
         CXXjaoM0PtLZBJPcBsAOfo836nzrOsKqbU/yasS6wBRUJ78fhYerpgVs7JhshSbCkg4I
         d5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756640474; x=1757245274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHqDvhwChwTVS524rXUmQ8DqhSZWMEWBDE06+kXVkMM=;
        b=Nz01S4+GcKNH9ZCGEhLBfc9lz9xEYkGxwQApCfobpYPo1x2VvoWBnyYf86VSNqedK/
         I10uoaKT1le8LrVkrK3jsvT+DnwiaNWkRNgZKtQot9LR9A+4ExzoImxO44n1nfHUbaAl
         Oiuhh2rEoU9eqRncO3kSrZ55ixWu0q4NGUt0YAxcmHxlkEW9kzUP/5aBvwZ0L/HVpt5b
         zniqBmQtfwN6pBBS0pSSTkZJREgwEfkQABPWBpgBFl4gNfi+YiDKBtzEhTUVqD92d9J2
         BLgWCxWZd45fNxWWxYO9IS/WHdp/nEz7kNKY0UpN0vIgH+KySUIrELkO+bC7AWthaeRj
         dZZg==
X-Gm-Message-State: AOJu0Yyu+OkY+QyC55qEWMpcJNvh8EvofiBiToc8SJTYnACVbTAF+C97
	VB4RJwI2iuvT1tNwMZkdV34slY5umRtRm3b7fCUmDgaDiK2+b6ntkOffzGyPpQ==
X-Gm-Gg: ASbGnctkXSDSqEYuCLRYO0zWCJPnsmSU4i2C9oDl0pq1mOsqgIp8NuaODEidTkGZJG1
	RAJA6POOtuqIsP0iLqIjbpkgsz1OKNDELIRYpg4u/n4VXASmDIpdsj2ES62amX3v8agzmzl+kTo
	AogN3iHBcl9pvKS1YbMu30x7W32mqryKUH8SjCSXtD2+IetbOB22icsXOA1BHeIv5npcPtOLX4e
	BURP451sRkVBqJtpz9P0KqWwdkbu5aQ0kCAj/XtxlQYdL2Icbau+LvidOm9HCzK+eIWW0q/b+19
	kGMqalqQ8w+rx1VjNim8yOYgp+aXeBts0q5eL8MokqH2WwJeLbDE9MxIjT3/no40qOJmxfa3ME1
	XsDCQ4cSzHn7a8pehp18qzuFolVlZ2X7AIwfLaaxzYDs8+P2+RYUSHQcpmmy+s/mCcf0RxkbFd1
	WK
X-Google-Smtp-Source: AGHT+IHdOcL/3o5HcNgNQx3jY/hqA17obLcpvOPbQlUkszdDFSkQ4QmaFl7Xn6rSQd6ipDpBeN7dkg==
X-Received: by 2002:a05:622a:230c:b0:4b2:8ac4:f084 with SMTP id d75a77b69052e-4b31dd2c28amr54070981cf.66.1756640474248;
        Sun, 31 Aug 2025 04:41:14 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b6fd490sm45174911cf.53.2025.08.31.04.41.13
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 04:41:13 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH 4/4] nanopc-t6: use non -dev kernel
Date: Sun, 31 Aug 2025 07:41:05 -0400
Message-ID: <20250831114105.27494-4-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
In-Reply-To: <20250831114105.27494-1-twoerner@gmail.com>
References: <20250831114105.27494-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 31 Aug 2025 11:41:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2096

Now that 6.16.y is the preferred version of the linux-yocto kernel, the
nanopc-t6 machine that had been using the linux-yocto-dev kernel can be
switched to using the linux-yocto kernel instead.

NOTE: keep the various pieces of linux-yocto-dev infrastructure in place
      so it can be used more easily again should it be needed

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 conf/machine/nanopc-t6.conf                   | 1 -
 recipes-kernel/linux/linux-yocto-dev.bbappend | 4 +---
 recipes-kernel/linux/linux-yocto_%.bbappend   | 1 +
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/conf/machine/nanopc-t6.conf b/conf/machine/nanopc-t6.conf
index 5ed413d1c0e5..8d524bd764f6 100644
--- a/conf/machine/nanopc-t6.conf
+++ b/conf/machine/nanopc-t6.conf
@@ -5,7 +5,6 @@
 
 require conf/machine/include/rk3588.inc
 
-PREFERRED_PROVIDER_virtual/kernel = "linux-yocto-dev"
 KERNEL_DEVICETREE = " \
     rockchip/rk3588-nanopc-t6.dtb \
     rockchip/rk3588-nanopc-t6-lts.dtb \
diff --git a/recipes-kernel/linux/linux-yocto-dev.bbappend b/recipes-kernel/linux/linux-yocto-dev.bbappend
index 6f4981fe29e6..e06c8a4f717d 100644
--- a/recipes-kernel/linux/linux-yocto-dev.bbappend
+++ b/recipes-kernel/linux/linux-yocto-dev.bbappend
@@ -1,5 +1,3 @@
 FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
 
-COMPATIBLE_MACHINE:nanopc-t6 = "nanopc-t6"
-
-SRC_URI:append:nanopc-t6 = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
+SRC_URI:append = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
diff --git a/recipes-kernel/linux/linux-yocto_%.bbappend b/recipes-kernel/linux/linux-yocto_%.bbappend
index 45cfb1c10b48..470aeb8f16b1 100644
--- a/recipes-kernel/linux/linux-yocto_%.bbappend
+++ b/recipes-kernel/linux/linux-yocto_%.bbappend
@@ -8,6 +8,7 @@ COMPATIBLE_MACHINE:tinker-board = "tinker-board"
 COMPATIBLE_MACHINE:tinker-board-s = "tinker-board-s"
 COMPATIBLE_MACHINE:vyasa-rk3288 = "vyasa-rk3288"
 
+COMPATIBLE_MACHINE:nanopc-t6 = "nanopc-t6"
 COMPATIBLE_MACHINE:nanopi-m4 = "nanopi-m4"
 COMPATIBLE_MACHINE:nanopi-m4-2gb = "nanopi-m4-2gb"
 COMPATIBLE_MACHINE:nanopi-m4b = "nanopi-m4b"
-- 
2.44.0.501.g19981daefd7c


