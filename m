Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72258C982D7
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 22:30:53 +0000 (UTC)
Received: from mail-qk2-f39.google.com (mail-qk2-f39.google.com [74.125.230.231])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.27128.1789597852150080876
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 15:30:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=mvyNF7Q5;
 spf=pass (domain: konsulko.com, ip: 74.125.230.231, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f39.google.com with SMTP id af79cd13be357-939922847efso16037785a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 15:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789597851; x=1790202651; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ilnrdiLVMzQV8DxHj240SbxvsIsE42nGCTRVB9ajU4o=;
        b=mvyNF7Q5y5U5nOOsUsHY6Ywh51xNMxXDs8k8hgg+p7hTWzNpcknba7pF7XMWkioJSI
         wbcucbkFzLx+V1jIcaJJauC9V+QaioBkWMp7h9OC3E1ZKN/f+3/4zzar+PS5xuZ/VVyR
         8aZ0IQE94y535EZfOx8PGWJQ1VrxP3z/wPGlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789597851; x=1790202651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ilnrdiLVMzQV8DxHj240SbxvsIsE42nGCTRVB9ajU4o=;
        b=KRIdKAvrw+oEsGyiwYM6WQPjucDHgEd50pyo45CiEcaq9iI4/TRbV8HMuANrqDyiW1
         iCXuWO/D8cyJYu27krqm7vUOLDw22pWheaP3Q7c5esWVaBRcPLgDuPhLvg51o6ODdd/K
         iTR182AlEl4U5m2R19XBD+cl+OEhOzP4jHUOFOiD/5dvusNuDvvbggOm6/Xw4gj/j2vU
         Zd09Ds77yTaK0utSARJtX0H2lMZWAJTumUFVaAAtL6W/6fSv4Xk058k6+HTtQzLm/rfT
         Q9GHOZiPMTanW0lX4VAtE4oAUOiuzlpYjXl+c2lX7KKxzGjMHNgVPCpQj8//XcL6htOm
         DRCA==
X-Gm-Message-State: AFuF++ncOxBc7Vt8epRX/2Z3tRamaPDdu3WbZK7kv7/8rhK2BCu5R/T+
	f2YLvArZxp0S+0aSOKfazF4Ers3OalUWk48whw4/TcT0Dx5ji9ODglSCezMfOf71LDSO5EROxtR
	zzT3V
X-Gm-Gg: AYBFou2LElk0Yol2E/xJszKuMMvxilePgNAibIvYL6OOXCl+hJn0kazkbFjZsJ0ooR7
	GR97fiEQocn2yLdlcqZw2aO5fePAgqgkjwKm7SSupvvasxj1Uvxw9TC8cYy5wUTBvBAIo4RJAwG
	Cw3DBMB3wORCi+Ahn0yfbxtwlYIWlJoNkZ30dVxYwvBNV240JFkfEKHpLmfvJTUv56P58LOk1iG
	mw2l9KAVTXdh0eUuLZXiyM7mJzvAE/e8niTU69TXueoS3j0J3XbxYdLl6Khc+SIh43UjUnt8nFJ
	Rz3J+WzbY7e8tZ4mfwgaSS8r/ipxJNqnDx9ULgd516q2RfcVI46I1jRa3HlWvLVPCdn+nMyvv0O
	Er3sFPPt/2n86Dnm8qJEQknsWh80OpJnKTcPl2dqTYHI08zRccmbzh4rkz5I2XcHo6YebvXYOb7
	LhZfkXrfL30oJy76e0GwU2ZFb8Q/UtBJGETNNAbJX+UO4Es5+Vg1i5G4R6yw2ZUeL/aBzGmCXU8
	pajwmSZCgTvmWH4faAiSAmj2xT/Ul6p97fL3tYrhHre4EaBzNWUb/kEJnnj5H36lYCUKYGjjmlL
	mknMBXFDEUfovdoUvdVpExpHhBEbiTCzEJwD
X-Received: by 2002:a05:620a:46a4:b0:939:9a09:6009 with SMTP id af79cd13be357-93bb785c5c1mr747011785a.33.1789597850864;
        Wed, 16 Sep 2026 15:30:50 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781d94c0sm310900685a.10.2026.09.16.15.30.50
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 15:30:50 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 21/24] aide: upgrade 0.19.3 -> 0.19.4
Date: Wed, 16 Sep 2026 18:30:15 -0400
Message-ID: <34dda49b4e56aeefbac2820652410c9a6b5c8431.1789597604.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789597604.git.scott.murray@konsulko.com>
References: <cover.1789597604.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 22:30:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4897

Release notes:
https://github.com/aide/aide/releases/tag/v0.19.4

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-ids/aide/{aide_0.19.3.bb => aide_0.19.4.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-ids/aide/{aide_0.19.3.bb => aide_0.19.4.bb} (96%)

diff --git a/recipes-ids/aide/aide_0.19.3.bb b/recipes-ids/aide/aide_0.19.4.bb
similarity index 96%
rename from recipes-ids/aide/aide_0.19.3.bb
rename to recipes-ids/aide/aide_0.19.4.bb
index 5daa295..9cdd601 100644
--- a/recipes-ids/aide/aide_0.19.3.bb
+++ b/recipes-ids/aide/aide_0.19.4.bb
@@ -10,7 +10,7 @@ SRC_URI = "https://github.com/aide/aide/releases/download/v${PV}/${BPN}-${PV}.ta
            file://aide.conf \
 "
 
-SRC_URI[sha256sum] = "6513170bb5b8c22802dd1b72f02d8aa9f432aef2b4470522db03e755212a3f47"
+SRC_URI[sha256sum] = "47ab7c696f0745911479a41f90d7ad99d26536e186d66c4aad093bc72d20ff5f"
 
 UPSTREAM_CHECK_URI = "https://github.com/${BPN}/${BPN}/releases"
 
-- 
2.55.0


