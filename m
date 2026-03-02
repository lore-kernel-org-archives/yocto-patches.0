Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C4EEB3632
	for <webhook@archiver.kernel.org>; Mon,  2 Mar 2026 20:18:11 +0000 (UTC)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1612.1772482690439865992
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 02 Mar 2026 12:18:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=C3VTKSJA;
 spf=pass (domain: gmail.com, ip: 209.85.167.172, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-46391f4c1f9so3387938b6e.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 02 Mar 2026 12:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772482689; x=1773087489; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i8pmp/2ocO+YV1XX5VYoK2dlnkR3FnztzppGCd6JDGg=;
        b=C3VTKSJAmWaVOEbmUaL3Z5xb0W78wdulY8oE9EqhCIrpq4XpkqM4MGqw0rvubjPHER
         jvsdJD0p0D3580t3tLRifn4O+OmRt5xjmUIsUZacSihp0urXgkG9N40p+AEYp8MOxnfU
         nuiY3hgRTjJW3rBLBNO9tr/qIo9YR0LBRn6TUUFf0MONl2hIc8DuWULtHBFJE3JamgGk
         ZQpnyxbtvkpDJoBGqemTn8I8gn3VY8CmodrKHpU8GYNt8zpHkiNsMsU0sNQPTui/uUiw
         X+ZeQGxgQ91677UB7jfK9l0ewcIdzGbBjUFKP8fz9lvLsZeVfgX+RL8Tuc0pD+6B+fHE
         hrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772482689; x=1773087489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8pmp/2ocO+YV1XX5VYoK2dlnkR3FnztzppGCd6JDGg=;
        b=UVIohTYWei9y1xiT4/SLAk6kxyj/D8NxdUfMqYKrLaMglKyE39aNSALTp3sx0vqbRc
         oKwn+yl5DPpUVRwEUPzG+QFSCagPPJZD7JjimJFzvk4YIUX0vhtFcsFQCSGi5frcCk1g
         yFDCnYlgBdMEj8qA13VFsy2l6mneYaGDyondVX/eQ3RpzL20DUeJqGyC01QO5UF2Neuq
         Od96a26xqv2R1iyYUGJHQa8o+O/kaTukhpyHteC37WV78WTxcAfmhXp+7pxpVDibgm/3
         iMJNT1MfUvFd0BcB2WvrmDpI6Q/8ZiNCIf8ADDGKg9zaA/QwIYAPCU/BxGB0R/GNAfPV
         +TEw==
X-Gm-Message-State: AOJu0YxpkvVnek0hO/TNZBp9NdVJAkmr/gX6RR42c0TDek0ZldmFdCMp
	c9dgYY5wQiWYy7xCVxITZTEd9uYzG8b1sJXjuv6qNKc7XjGG675ToL78StvBOw==
X-Gm-Gg: ATEYQzxZDohveA5GLaameucihGyylUurl7YnmwsPuqABhA+otVOw2EXnNww/7Zif3t0
	nIfxDPjyqktB51qgeB8yQjGKXGIDblP2gNrrLy4fDrLAZGIG4DEkcnaVnSz/IXjGqgNF1sONn7k
	kguR1QicK2p/PIlz4Zx19dj6/aMAauTpk30HrfemaihR3VNmW7OA547TS/xtIhY0ohmDoqhD9kc
	qNg0rC7NOpId+esoxhvs+0qF4F/PKRw6qC+jdaHxg3iCuLqFOOHnH16q+w30Zuy9GurCVWrTkDt
	35nqlnjnG4QXdrLsJ8NAYzEFVrTxepLArSkaklVaKlY5T21T9jeNDCVcLtRkZFUhFL63GPnIBaG
	kvhoZD2c13o7Bbsad1g11kmFFf27/B6TCJo3gi2WdF3D8cJULxVx3jEtfx/Hq2yZvgOpQUgkoSO
	6UGAQwjagJ4An/O6JQHTONqP1Gq0C95k8=
X-Received: by 2002:a05:6808:1786:b0:463:d796:ac9c with SMTP id 5614622812f47-464be98995cmr6559042b6e.17.1772482689465;
        Mon, 02 Mar 2026 12:18:09 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4200:11c0::ba6c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb352dc0sm8116668b6e.3.2026.03.02.12.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 12:18:09 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [yocto][meta-mingw][PATCH] Fix dynamic layer name
Date: Mon,  2 Mar 2026 13:18:05 -0700
Message-ID: <20260302201805.2172692-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 02 Mar 2026 20:18:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3315

Fixes the dynamic layer name from openembedded-layers ->
openembedded-layer. This was preventing the bbappends from properly
applying

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 .../recipes-devtools/abseil-cpp/abseil-cpp_%.bbappend             | 0
 .../recipes-devtools/grpc/grpc_%.bbappend                         | 0
 .../recipes-devtools/protobuf-c/protobuf-c_%.bbappend             | 0
 .../recipes-devtools/protobuf/protobuf_%.bbappend                 | 0
 .../recipes-support/c-ares/c-ares_%.bbappend                      | 0
 .../recipes-support/re2/re2_%.bbappend                            | 0
 6 files changed, 0 insertions(+), 0 deletions(-)
 rename dynamic-layers/{openembedded-layers => openembedded-layer}/recipes-devtools/abseil-cpp/abseil-cpp_%.bbappend (100%)
 rename dynamic-layers/{openembedded-layers => openembedded-layer}/recipes-devtools/grpc/grpc_%.bbappend (100%)
 rename dynamic-layers/{openembedded-layers => openembedded-layer}/recipes-devtools/protobuf-c/protobuf-c_%.bbappend (100%)
 rename dynamic-layers/{openembedded-layers => openembedded-layer}/recipes-devtools/protobuf/protobuf_%.bbappend (100%)
 rename dynamic-layers/{openembedded-layers => openembedded-layer}/recipes-support/c-ares/c-ares_%.bbappend (100%)
 rename dynamic-layers/{openembedded-layers => openembedded-layer}/recipes-support/re2/re2_%.bbappend (100%)

diff --git a/dynamic-layers/openembedded-layers/recipes-devtools/abseil-cpp/abseil-cpp_%.bbappend b/dynamic-layers/openembedded-layer/recipes-devtools/abseil-cpp/abseil-cpp_%.bbappend
similarity index 100%
rename from dynamic-layers/openembedded-layers/recipes-devtools/abseil-cpp/abseil-cpp_%.bbappend
rename to dynamic-layers/openembedded-layer/recipes-devtools/abseil-cpp/abseil-cpp_%.bbappend
diff --git a/dynamic-layers/openembedded-layers/recipes-devtools/grpc/grpc_%.bbappend b/dynamic-layers/openembedded-layer/recipes-devtools/grpc/grpc_%.bbappend
similarity index 100%
rename from dynamic-layers/openembedded-layers/recipes-devtools/grpc/grpc_%.bbappend
rename to dynamic-layers/openembedded-layer/recipes-devtools/grpc/grpc_%.bbappend
diff --git a/dynamic-layers/openembedded-layers/recipes-devtools/protobuf-c/protobuf-c_%.bbappend b/dynamic-layers/openembedded-layer/recipes-devtools/protobuf-c/protobuf-c_%.bbappend
similarity index 100%
rename from dynamic-layers/openembedded-layers/recipes-devtools/protobuf-c/protobuf-c_%.bbappend
rename to dynamic-layers/openembedded-layer/recipes-devtools/protobuf-c/protobuf-c_%.bbappend
diff --git a/dynamic-layers/openembedded-layers/recipes-devtools/protobuf/protobuf_%.bbappend b/dynamic-layers/openembedded-layer/recipes-devtools/protobuf/protobuf_%.bbappend
similarity index 100%
rename from dynamic-layers/openembedded-layers/recipes-devtools/protobuf/protobuf_%.bbappend
rename to dynamic-layers/openembedded-layer/recipes-devtools/protobuf/protobuf_%.bbappend
diff --git a/dynamic-layers/openembedded-layers/recipes-support/c-ares/c-ares_%.bbappend b/dynamic-layers/openembedded-layer/recipes-support/c-ares/c-ares_%.bbappend
similarity index 100%
rename from dynamic-layers/openembedded-layers/recipes-support/c-ares/c-ares_%.bbappend
rename to dynamic-layers/openembedded-layer/recipes-support/c-ares/c-ares_%.bbappend
diff --git a/dynamic-layers/openembedded-layers/recipes-support/re2/re2_%.bbappend b/dynamic-layers/openembedded-layer/recipes-support/re2/re2_%.bbappend
similarity index 100%
rename from dynamic-layers/openembedded-layers/recipes-support/re2/re2_%.bbappend
rename to dynamic-layers/openembedded-layer/recipes-support/re2/re2_%.bbappend
-- 
2.53.0


