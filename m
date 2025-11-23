Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD9DCFD313
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 23:45:33 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4863.1763941530861916124
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 23 Nov 2025 15:45:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=CtyPUsXq;
 spf=pass (domain: konsulko.com, ip: 209.85.222.181, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b1e54aefc5so313222485a.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 15:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763941530; x=1764546330; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7THLSz2lr8pYVnGU6CseWh1dKjTeFxmIwP5ttjgEnE=;
        b=CtyPUsXq7PyccZaUFJD6Gv/9FNaGX7SMnVXpRDC0lbPzKPalkCAr5hmMPEg7nzoyDc
         kejkzLcCe3t0xj9X+NsaqgNri196VQmVEzcqZU1oudh5OGRpZZ3/Y9VHpkrplIMzgFBN
         Zox/HFWYWZk3RoM1kk5FbfVQ8cFLgIkne6u0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763941530; x=1764546330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l7THLSz2lr8pYVnGU6CseWh1dKjTeFxmIwP5ttjgEnE=;
        b=nJwdlwA7Guu43rKBimlPizUAmgBXoi1SIGGp4+6tuYKojbq+ZznM2zgRcTuKm3kYC9
         NDLlhRHE2cPSkS5UwdDTrHmrnklWwng0uEP4w/8VAy2PGKgcu2vn7j452QTccllLFLuU
         aMo82FFkacOxoo8HxaUFh83qQ7SklfKjUMwOMofCIgMCtMymNqdJLhVoTJiuMp4qKlSK
         IdFj3KJ8e/XjarxCQD3uKm0Wb+nx8eW3+6CXWPEDu6vq/yAGFknKGjl6uCV77ciDRh2i
         dCX/A0avQumecD+aCrarBqWTRqoZimL/dO1P64cjE0/HnQztu7wBhZuxptwg+M8BwfRd
         WhCg==
X-Gm-Message-State: AOJu0YzdYl22O6xvfmHyUjvxU3MbZxcEbuZgNHp0lpEBfVloS0I+Tcs1
	T5Ex9vugdHt5zX7PUTz13t10Y4Sfeh8bFTt9ES95IqHlOof9Jfd/H8au8RL/vhcl+huMaDZXK11
	lLruI
X-Gm-Gg: ASbGncsQDOJZSiqZ6obtOt7ZKdDc22cZMX6l5gb8wGMqv/T9+q787SArWEtwrPgmDRu
	h5ZpE7V8V0cRg/CVkVW3dEKtCWChi7YhkUzdqfOJEHO66OmeSANIKIy9aPYKMpZPV1EAXV0JrZc
	aPEzPbeqW3wUvXi3oNexcp1ozPpk46romfWvl0xy8Fbb1n+N3MNNcf5WU3T6vy3vPPJ0PrE6CBF
	733yvmUcMqdJ5yZx3QsWUq75axqPt24GkdUF2V+OJ/BygSI+KguTbxFxB1p/hwGpiaAfwxMwgsY
	muoQsH7gSEHjnVe27YkWBFUS7vntQo301Br1YmcOAS/8/Lm1bXFOPQrOAJSjvbS7BfDC2JtYeWi
	weI8nzKEUx4c8rYgxxVZL64dpnWryJdzDW6yeDuWk/0VOyxijkB+tFCut36gUqbgSnk5MUG9xnY
	5+5pmhOfERAhTvrWWhETMNQzGJxIpN8gueABUn5XP1BSMKu0256L5hP1Egfw2VRJ8=
X-Google-Smtp-Source: AGHT+IFQ5Q1/7ytryjiiYFcjBbC0CbWyJHFjDHgaXUdBJt353XjJQXKoTxg0v/BJuP1FwhdVBdxQzg==
X-Received: by 2002:a05:620a:4611:b0:8b2:dafb:9089 with SMTP id af79cd13be357-8b33d469027mr1287875985a.67.1763941529582;
        Sun, 23 Nov 2025 15:45:29 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932db59sm843706585a.1.2025.11.23.15.45.28
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:45:28 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][scarthgap][PATCH 13/32] harden-image-minimal: Fix usermod
Date: Sun, 23 Nov 2025 18:44:53 -0500
Message-ID: <056217207643a3d89d88fd1b6ffff1f0e1b4ac6e.1763938436.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763938436.git.scott.murray@konsulko.com>
References: <cover.1763938436.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 23:45:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2671

From: Armin Kuster <akuster808@gmail.com>

Signed-off-by: Armin Kuster <akuster808@gmail.com>
(cherry picked from commit c08a91e5e607806460854936ef622f6f78bb0f03)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 meta-hardening/recipes-core/images/harden-image-minimal.bb | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/meta-hardening/recipes-core/images/harden-image-minimal.bb b/meta-hardening/recipes-core/images/harden-image-minimal.bb
index 38771cd..4366961 100644
--- a/meta-hardening/recipes-core/images/harden-image-minimal.bb
+++ b/meta-hardening/recipes-core/images/harden-image-minimal.bb
@@ -18,9 +18,9 @@ DEFAULT_ADMIN_ACCOUNT ?= "myadmin"
 DEFAULT_ADMIN_GROUP ?= "wheel"
 DEFAULT_ADMIN_ACCOUNT_PASSWORD ?= "1SimplePw!"
 
-EXTRA_USERS_PARAMS = "${@bb.utils.contains('DISABLE_ROOT', 'True', "usermod -L root;", "usermod -P '${ROOT_DEFAULT_PASSWORD}' root;", d)}"
+EXTRA_USERS_PARAMS = "${@bb.utils.contains('DISABLE_ROOT', 'True', "usermod -L root;", "usermod -p '${ROOT_DEFAULT_PASSWORD}' root;", d)}"
 
 EXTRA_USERS_PARAMS:append = " useradd  ${DEFAULT_ADMIN_ACCOUNT};" 
 EXTRA_USERS_PARAMS:append = " groupadd  ${DEFAULT_ADMIN_GROUP};" 
-EXTRA_USERS_PARAMS:append = " usermod -P '${DEFAULT_ADMIN_ACCOUNT_PASSWORD}' ${DEFAULT_ADMIN_ACCOUNT};" 
+EXTRA_USERS_PARAMS:append = " usermod -p '${DEFAULT_ADMIN_ACCOUNT_PASSWORD}' ${DEFAULT_ADMIN_ACCOUNT};" 
 EXTRA_USERS_PARAMS:append = " usermod -aG ${DEFAULT_ADMIN_GROUP}  ${DEFAULT_ADMIN_ACCOUNT};" 
-- 
2.47.3


