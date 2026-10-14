Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8DDCC6B2D
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 14:12:43 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14771.1791987159413577903
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 14 Oct 2026 07:12:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=BZsOxZSb;
 spf=pass (domain: snapchat.com, ip: 209.85.128.41, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49fbb2acc90so36169635e9.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 07:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1791987158; x=1792591958; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/z/FNUgCGcWavIqHGPVIh5jySzCtH/ebe3apcQvu6UU=;
        b=BZsOxZSbApJsAsEtdjtUy30D3iZOSYeB26Prq+J+xn3BgzMrwQUrKUnzle3ibn4DqA
         QLUV3fx6AanLJf5QIk2LE1cK/DvMFgztYefN23MgCK/XAkfDy957UqB9IyuCR+cQz8u0
         4y/wnwR413Ucjgj/Ji1vBxaNbcPvjond4GKu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791987158; x=1792591958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/z/FNUgCGcWavIqHGPVIh5jySzCtH/ebe3apcQvu6UU=;
        b=xGELEf2Hm9pXZ3YvT2xlz4MDxfl59JFj8Ffte97Kb6gExUmDhnBt8i/uBPLPjnFxLh
         OVnv86tT9WcJ0xDjxI4CJ2/aOlMuqzheA/LZnvvX1VWygcl+efVjzq5sI5MUt2w8x6jI
         fdFyfx2oiGHOkln4iBSKmHA/FuxfW/deWRGqGnlNSyW78UePwDx/atdX1XwjJD4P5kb7
         ZebOCvyq1nWMRNw35eGVV1yG0rjJ2r/hAB6X+1ueqkc6dNd4htiTBA+98h+XKJ4Z8Ubs
         vos+E6trFmKVHudYwoi7mZa2ri1w93jrICYU9TC0YG7kcHrLZn53NoIK2rg7y6nBzJ63
         GpVw==
X-Gm-Message-State: AFq9FYKVYh00CrHwzry81hu2GEeK+LM5Cw95izuYr9wy4NAEAUoDaFXt
	9W5+zCFbJR7osuS01wJikV4wKqY76/WNPfvqlRFXrYynPpPD95NsBYl7cG0f53maB/K1NkkPeCw
	lWv+dEMo=
X-Gm-Gg: AYBFou1b2L1F7nz4Wrg3t4lr2A1otayxj50l0zgkSGwWgCWd0u7Q5N3gGFhlcK7iZe6
	YCL/RgngUR3I/lJfc9VZt24rr2j4BhdmFB8OmrO+9Khg/P9773G4hPKEWjFwu8Yjfw2db0kneDe
	pYmnpS+dr7isPSE/DFTVzeMeiROl69hgisC8cvnaEMciGqm36yEusmQu6oo1qdiAM7F1Q7BXj5m
	wpARUkGTvYEH9gn6e6h6QBVjjaFonbSWyv119E+H5xqL9LTvaNChLccsK9JNb3j24kdbPn4CW8t
	NJKEs6tm87JY5cg6urOILrwbp6tC2L3aucLC3oJ5g4Ys65oTLreZpYoAdAqcFbUTunm/VNhkuY2
	/4Xi8Nwjq6XFzaC2utHtqgaxbr4wm0NrkdP4f4k3/bqwd040aSfOCswWQe2fdBj8sLcXOLOxX1c
	Zd76NkWR4gMXCkdxkCPC+UNDq2QUOV6nEdpX3C5gOORidFnWHJy6iFynEz9VvY7bpsE11uZ5LQ2
	w0/1MHoziyrNWDvj4Enof4fFADWccnFffHoReJTonNzmdfR29sx
X-Received: by 2002:a05:600c:3111:b0:4a0:1e87:910 with SMTP id 5b1f17b1804b1-4a18e4cb7a9mr325472245e9.20.1791987157411;
        Wed, 14 Oct 2026 07:12:37 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd202e8esm299965e9.6.2026.10.14.07.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:12:36 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 12/21] libarchive: drop acl/xattr PACKAGECONFIGs for Darwin nativesdk
Date: Wed, 14 Oct 2026 16:10:33 +0200
Message-ID: <20261014141209.488034-12-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014141209.488034-1-ecordonnier@snap.com>
References: <20261014141209.488034-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 14:12:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5017

From: Etienne Cordonnier <ecordonnier@snap.com>

Both pull in nativesdk-attr (and nativesdk-acl also DEPENDS on it), which
fails to build for Darwin: attr's libattr.c/getfattr.c/attr_copy_file.c use
the GNU/Linux <attr/xattr.h> API unconditionally, and upstream has never
grown any __APPLE__/Darwin support. Darwin's own xattr() family takes a
different signature (extra position/options args) and has no lXXX-prefixed
symlink variants, so attr's calls don't even parse there, let alone link.
Same story for acl's libacl, which uses the POSIX.1e acl_get_file() family
that Darwin doesn't implement at all.

libarchive only uses these for optional xattr/ACL preservation when reading
or writing archives; dropping them for the Darwin nativesdk build (which
only needs libarchive to link nativesdk-elfutils' debuginfod client) loses
that preservation but nothing else.

AI-Generated: Claude Sonnet 5

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 recipes-extended/libarchive/libarchive_%.bbappend | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 recipes-extended/libarchive/libarchive_%.bbappend

diff --git a/recipes-extended/libarchive/libarchive_%.bbappend b/recipes-extended/libarchive/libarchive_%.bbappend
new file mode 100644
index 0000000..e3c1941
--- /dev/null
+++ b/recipes-extended/libarchive/libarchive_%.bbappend
@@ -0,0 +1,6 @@
+# libattr/libacl are the GNU/Linux implementations of xattr and POSIX.1e ACL
+# support; Darwin's own xattr/ACL syscalls are real but have a different,
+# incompatible signature/model and neither upstream library has ever grown a
+# Darwin port. Drop both PACKAGECONFIGs here: libarchive still reads/writes
+# archives fine without xattr/ACL preservation.
+PACKAGECONFIG:remove:class-nativesdk:darwin21 = "acl xattr"
-- 
2.43.0


