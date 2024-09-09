Return-Path: <vanusuri@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2746EECE579
	for <webhook@archiver.kernel.org>; Mon,  9 Sep 2024 12:51:14 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.web10.52115.1725886269577771632
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Sep 2024 05:51:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=hlo28gvt;
 spf=pass (domain: mvista.com, ip: 209.85.215.175, mailfrom: vanusuri@mvista.com)
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso3418243a12.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 09 Sep 2024 05:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1725886268; x=1726491068; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XjbFBuDvrAR12It/FMBZNONL4ZBwRGT7nzoTKP187do=;
        b=hlo28gvtZJZ8pG45VjvpHcK5qAyO8oFWKl1klXmDdXTPw9SteO4H2pAT3XQz8ywmYn
         UN6erEHGVyW7vq/1cLFtibrRVlrr++5WHSxdEZZ0USRHoikYfgyx3zn17eurJqvKQnMZ
         zeN+iL4dTsRXBauhvTwiEXy3ywxHFnUKzVK3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725886268; x=1726491068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XjbFBuDvrAR12It/FMBZNONL4ZBwRGT7nzoTKP187do=;
        b=BJa1BgtURJATu0rfqu+mLi9/2uG7IZ1okbeSMMNEKOolp2tBYZs98t1eslMIj7ekJD
         jkq3yk+DbVxoZgHtV1EDtBxgIuCax/4EX6JdMyPQdusxJT6DUF9xuBkree5LzRjaVwJ8
         zDLqYFXqDZmmBZFfHgzLOjpl2y34BkI0rUoLGc9yuO6uH0Bq0vjuXWNeq87V04U9vu8U
         QVJaMitt/5c6B9lacpI1W5VgsvMXV48SsCXwta91/mHo1GcLUGDb7SKO3azZhFNGOo0L
         +JUOegyJnbEIlRxZIf0sE5x+RU55xEbj5XfdzrjhWkx7rHHD0cdsOe72nutQDDKOxNfq
         y29g==
X-Gm-Message-State: AOJu0YwqL2MNcxgrpB4n2UpgmuuV7PL/BepJdCYzVRbokg3LxpFqMmVN
	ajm76cZg1F6FfbkSb19l2+9omWtLkBoW+L426cc32nz3OU0R67Uo+57wnAE75r5nd8XRe2GSEvO
	Ln9A=
X-Google-Smtp-Source: AGHT+IFibuTm6DkNan3y+yLhaL9rmlZcZuVa5etwxAN72HveVftcCfio3YJRCzSsh4WnioNxO5R+8g==
X-Received: by 2002:a17:903:22c3:b0:206:8acd:ef7d with SMTP id d9443c01a7336-206f0655fa9mr166352215ad.52.1725886268161;
        Mon, 09 Sep 2024 05:51:08 -0700 (PDT)
Received: from MVIN00020.mvista.com ([2401:4900:882d:7454:9674:8169:5358:32b5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f231ffsm33588805ad.241.2024.09.09.05.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 05:51:07 -0700 (PDT)
From: vanusuri@mvista.com
To: yocto-patches@lists.yoctoproject.org
Cc: Vijay Anusuri <vanusuri@mvista.com>
Subject: [meta-security][scarthgap][PATCH] tpm2-tss: upgrade 4.0.1 -> 4.0.2
Date: Mon,  9 Sep 2024 18:20:53 +0530
Message-Id: <20240909125053.6346-1-vanusuri@mvista.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 09 Sep 2024 12:51:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/623

From: Vijay Anusuri <vanusuri@mvista.com>

Changelog:
https://github.com/tpm2-software/tpm2-tss/releases/tag/4.0.2

Includes Security fix:
CVE-2024-29040

Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
---
 .../tpm2-tss/{tpm2-tss_4.0.1.bb => tpm2-tss_4.0.2.bb}           | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename meta-tpm/recipes-tpm2/tpm2-tss/{tpm2-tss_4.0.1.bb => tpm2-tss_4.0.2.bb} (97%)

diff --git a/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.0.1.bb b/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.0.2.bb
similarity index 97%
rename from meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.0.1.bb
rename to meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.0.2.bb
index dceebc2..e668115 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.0.1.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.0.2.bb
@@ -10,7 +10,7 @@ SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN
            file://fixup_hosttools.patch \
            "
 
-SRC_URI[sha256sum] = "532a70133910b6bd842289915b3f9423c0205c0ea009d65294ca18a74087c950"
+SRC_URI[sha256sum] = "e5f9b6055c29cb8d653ec7576853ff3863aa65dbd9cf4b3638ae8e8e7ce968ea"
 
 UPSTREAM_CHECK_URI = "https://github.com/tpm2-software/${BPN}/releases"
 
-- 
2.25.1


