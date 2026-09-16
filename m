Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C086AC982D6
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 21:58:50 +0000 (UTC)
Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.26472.1789595927318831106
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 14:58:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Pbk2oRNh;
 spf=pass (domain: konsulko.com, ip: 74.125.230.140, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfe57a3aso1338836d6.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 14:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789595926; x=1790200726; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/XAvRnGECGwdT+fddAEPlgc/pDAOtHMcKoay26GJ1hg=;
        b=Pbk2oRNh9jW9qJyLeGEa8HllLV3fB4dG8S5w52GQ2YXRvdKwbG/g4k70etptgE8JRt
         Yt0Ww24fCThumLpZR4lA/uvSsdYE2GqbIGfR2iW1OBzYSi3uyq+rHu8tPUrURqw8GW6i
         Qtu2xMsfJRvIxspvStVl5fzKnFUvc/QxnV/5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789595926; x=1790200726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/XAvRnGECGwdT+fddAEPlgc/pDAOtHMcKoay26GJ1hg=;
        b=w2j++A5DwsAsYogWNGq6Bv5lXi0Qwdsc88Ti6Icm0sNEXBth+fR5kyVO7BbFuEhHIs
         ltw/050KgInjn4670FJGwLKVL1vkoEAoiY097DU2Elza243pBGwWZAnu38IzFNzwVNMV
         hOeBE1wAH16voqLlGImcl/TsEv5u0ypVaJ48uoPvjj9EzydjFxGwgT0u/rlglCKuVPzj
         3vFQaihetq7NQpEUAF/D98B75SN+rYrpFaXwHcqk/z8MNlyCPmPBknbvRuXT75LHp6ZK
         y5JcHcHQcCjAQ2ZHNKA6NXy/59KTe9RcYADvibJULmrVMsvxDvTHQtB/CcLpPfgiVfaz
         wp3w==
X-Gm-Message-State: AFuF++kKA9Gc2PxdDUSqTr6t39xQ711RzfGUudhFyvFvyo2wkeS0vn+I
	VaCSCBW4QrP0zY7hi1T/L9dOpAaRBWWEMTRsGTh6C4XzbzLZZaG39IeTiEPVQi8RJYOvljfch6Y
	DGp9w
X-Gm-Gg: AYBFou3iL2Nkh7JeJLJKToTFiSkIl0A+S1DxCEhn3tSNysewk4ffsOvgzOcYnp0A70g
	u/w1hHn56F1dn3T7W1AORP+ksIyr1DkZrLFiXeh0GBmedPlqi5qAeVT74P+IEpFWpTLk9zUuz7f
	DxwzB7jqjhS7QEb6FwIcYQBCFsK8F44eYYZkHEjdQ1yezN0htfWlxXn1hWkgy3WfjcG9GG1i1+o
	mDqAwSkeso/f9MGrVZN00jfUBD37yVymptIJg6MPmRKbrRuJ9RpKFB/8tCE+c0CSpsq+QAkGA8o
	D10/N+Rb8ceOtdz9tUODhjX9TW1Ztts/fUaTPziY/8OffCNBJ1A1SCWPsTB+JOwpKE3ODhZ/bsn
	2ZI48mEgJv9L56Xz4O2xTglIzPgyg0tDdFop/huR8knpNxofDDXez1mknHEnXyEydoQLr+OpEdj
	pw9/yTxh8c31LRHpmM9T0JD8SDg8TlvVdspI16luzvSlMx5KP5R9SBwxYsyZWUFnQpZYKcKkguA
	J3CSRxSf75KewGyb4quLPfHYSI8bgZe1g6iLxpNWb5r7ew+Os4Lb2wtbC00/QU9DXSo1UGzx9jL
	vaT2WWiMQWbRxcMEPQ2FMB1j1BXHFw/IqGI=
X-Received: by 2002:a05:620a:648d:b0:939:ef88:4af4 with SMTP id af79cd13be357-93bb7667542mr757683185a.10.1789595926162;
        Wed, 16 Sep 2026 14:58:46 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781def43sm323293085a.16.2026.09.16.14.58.45
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:58:45 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 09/19] ccs-tools: upgrade 1.8.9 -> 1.8.14
Date: Wed, 16 Sep 2026 17:58:09 -0400
Message-ID: <128e00f84f306f939e7ce46fa0392b97e1ac87f6.1789595456.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789595456.git.scott.murray@konsulko.com>
References: <cover.1789595456.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 21:58:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4864

From: Wang Mingyu <wangmy@fujitsu.com>

Signed-off-by: Wang Mingyu <wangmy@fujitsu.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../ccs-tools/{ccs-tools_1.8.9.bb => ccs-tools_1.8.14.bb}   | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
 rename recipes-mac/ccs-tools/{ccs-tools_1.8.9.bb => ccs-tools_1.8.14.bb} (84%)

diff --git a/recipes-mac/ccs-tools/ccs-tools_1.8.9.bb b/recipes-mac/ccs-tools/ccs-tools_1.8.14.bb
similarity index 84%
rename from recipes-mac/ccs-tools/ccs-tools_1.8.9.bb
rename to recipes-mac/ccs-tools/ccs-tools_1.8.14.bb
index 3f754e9..aaf17b0 100644
--- a/recipes-mac/ccs-tools/ccs-tools_1.8.9.bb
+++ b/recipes-mac/ccs-tools/ccs-tools_1.8.14.bb
@@ -7,10 +7,10 @@ LIC_FILES_CHKSUM = "file://COPYING.ccs;md5=751419260aa954499f7abaabaa882bbe"
 
 DEPENDS = "ncurses"
 
-DS = "20210910"
-SRC_URI = "http://osdn.dl.sourceforge.jp/tomoyo/49693/${BPN}-${PV}-${DS}.tar.gz"
+DS = "20250707"
+SRC_URI = "https://sourceforge.net/projects/tomoyo/files/ccs-tools/1.8/${BPN}-${PV}-${DS}.tar.gz"
 
-SRC_URI[sha256sum] = "7900126cf2dd8706c42c2c1ef7a37fd8b50f1505abd7d9c3d653dc390fb4d620"
+SRC_URI[sha256sum] = "b62e344cc357a982310a08760f2a2cebf4cf48b1341ea9bd3990ae55f45bab03"
 
 S = "${UNPACKDIR}/${BPN}"
 
-- 
2.55.0


