Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C4AC982C9
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 22:30:42 +0000 (UTC)
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.27122.1789597840262493031
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 15:30:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=V7Qjps29;
 spf=pass (domain: konsulko.com, ip: 74.125.230.204, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939109f067fso17624085a.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 15:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789597839; x=1790202639; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=I31Vdyl6cARUirtJO4XD3a1m7dRZ6vcf3KuG8CoR+vg=;
        b=V7Qjps29qZULypT/kDsYPqencZ2LLdwWCkJRzC6HcZKKgJDquwXZ3XtN5KviP4wBmu
         NDQ2YRCaeQ12A8usteZzNeQQ9Hc0jUjJUSDMdH3RuYMykSzoyzp6zUJPOOOTlstM7v4s
         vvuE5KlLP0w6QCZjJwtNHdrVjKtz+Q1JD/MUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789597839; x=1790202639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=I31Vdyl6cARUirtJO4XD3a1m7dRZ6vcf3KuG8CoR+vg=;
        b=p9R6Bq5Zg1yi93STkIrB86av2BZvtjS3xO4auTp0QhgrZ/bhvGSPNZWERSwYRapBBM
         72xRNiSafeQOxSNfDaTuzdh+jDZDZubDDuyKBCRny4s08UDcQeKZRArCNkV0h6ouQ46U
         kIb7rsbH6a6QxPIGYsEvYWJIdrWq/TeLC6ppp2uNXhHJD3bycMhjZthhEGOcZQEqIzpR
         CRsdUYW9I7ZgHGJCpwwzSA/nhGl69jthWpuXLI7baJHrrn0h4iyh1HNydb/KHhrJBMse
         ssouaBHiUYV6nbg/Zf9aehYdLFK7NldV2wZiTRca2MShz2pKzNQmmYkpmvhdsfEVdUTA
         P+yA==
X-Gm-Message-State: AFuF++mZGHDFk8wBDW6WkhbLYjbgRlM+2wGceHNvWm3//9OFCGD9l+Mc
	b8JF8tGIHtmMLskfA76Jd/SQ9LPxUVwfepPngqc30L/aevtpi0BI12xiOqND8ikBcaxDnev+RIk
	/jnQJ
X-Gm-Gg: AYBFou2COIQ3ASsBGuSS4gJjK3bD0sSAURBw0SS3ZFeiV3x1ELF8uIEuraOrq2T0YNV
	MZWNnOHqUHqMsnHT6b3dHDTrvsvlHqAr791R04x3d+yqQGHWWpAzrO4ra+x4JwF8oSJ2Xds9UJ4
	LiSV1fsAsHDjgus+FH9Ez7RKB1gAFI31yo+rUo9+nr9qVDWxV8zmP+M2LK/tpdZ1GstTTs4V7uo
	5GgPr7vvJK1RxSi0IfWZU+AXjroy1Geuarf3LtFXxWGAa9dHaAkV+stlKZmMJ3In2OqTxKEEtLJ
	LFjqHn3A6Gjg+2ZBr7xRowJXcR2AlfXMqGHMwgPYiehPNaecAAtHQQGbqNOHvGFSobkH6uNrZfl
	/na64VPsnDUz7oCXwmg049K7rl8hAfRvm4Goh4kc4kBKdi5Ce+bkbU0QT9EdfyptdKJ5ttahOMc
	IxxZ4B5CxFyzgKuraI9JYtuI9gaTcjzfHdAJqrKGYiyZdhSZeluYGNpf8OBTSuWPDtUu94+mI1y
	aiDoyKakf8jq5wu6DXHf26YQtGB/4Cr5imbar8+z5D0cQ87FZYuNDTXkxJVIsqno8cn0cjFFO77
	Ea/UDszuMn9UZYo/x01MNDjDsEx9aIgJ1nU=
X-Received: by 2002:a05:620a:440c:b0:936:bc40:cae2 with SMTP id af79cd13be357-93bb7837b12mr738688285a.39.1789597839149;
        Wed, 16 Sep 2026 15:30:39 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781d94c0sm310900685a.10.2026.09.16.15.30.38
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 15:30:38 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 09/24] tpm2-tools: fix PACKAGECONFIG typo
Date: Wed, 16 Sep 2026 18:30:03 -0400
Message-ID: <6df247cb9bcc6316e04a8d9f9319fcf07a236223.1789597604.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789597604.git.scott.murray@konsulko.com>
References: <cover.1789597604.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 22:30:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4885

From: Krupal Ka Patel <krkapate@cisco.com>

Correct the misspelled PACKAGECONFIG variable so efivar is enabled by
default as intended by commit cdb4e444acbb2b9df467d716241a206c9ea6d3b0.

Signed-off-by: Krupal Ka Patel <krkapate@cisco.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
index 5c968dd..7c5d156 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
@@ -15,7 +15,7 @@ UPSTREAM_CHECK_URI = "https://github.com/tpm2-software/${BPN}/releases"
 
 inherit autotools pkgconfig bash-completion
 
-PACKAGECONGIG ??= "efivar"
+PACKAGECONFIG ??= "efivar"
 PACKAGECONFIG[efivar] = "--with-efivar,--without-efivar,efivar"
 
 BBCLASSEXTEND = "native nativesdk"
-- 
2.55.0


