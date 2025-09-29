Return-Path: <vanusuri@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AAFCAC5B5
	for <webhook@archiver.kernel.org>; Mon, 29 Sep 2025 04:50:32 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web10.46695.1759121427253366272
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 28 Sep 2025 21:50:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=MvCnnrIR;
 spf=pass (domain: mvista.com, ip: 209.85.215.178, mailfrom: vanusuri@mvista.com)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b554bb615dcso3259329a12.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 28 Sep 2025 21:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1759121426; x=1759726226; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMmQw675awILv+ppnryCsafcQCWSI2rI843MBxZ3tGI=;
        b=MvCnnrIRBleeOYaanlUi4xMBWLZrQu2Klo0r5RdSuh/fGhmhOQjznaZsM9fgrdOD5l
         NsqwIOev1gFv99CuqLpLnnbK8iE9WGnjKbFufoJifZWVCeQNncQ/RH1oQxYT8t4ct46w
         dmq8M6Dru11tsjWOXwofMUO6Vo+kD+AcaQ/nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759121426; x=1759726226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMmQw675awILv+ppnryCsafcQCWSI2rI843MBxZ3tGI=;
        b=OVGoofCHJ5PXeH7Gg0nEbu7iGET8RjIWtsD85wqe2LNlv9nc1iqK+B5fUFsbjk1ZCv
         GUl+TMMWWoAfK+2Zipg2Kj+hrG4RMUDBtqt1oL/eT8fiEdATAXxLAlJrM4NjWsJJygGM
         eyWYNi4EGNNnjE9SlgnUkGRF8nnGtuy+mdytn+FM9nmnaARkJxwAOepEH6azrfVCVmNQ
         pb5psLt35kjNo7rvfyMJ+czydf0bEizotWN0Eobysn/Y+W0cvPn+9SrP3w3kmeiLfvn4
         jwe1XNolYeAwbDXkNXTcMT6mRPU8p01MiChn27IVKlDwOoXl0ZrmGadY72iD+3bnSMBs
         oJXg==
X-Gm-Message-State: AOJu0Yx2mS+c56uRKiG4awpR+PJKx/GoklY/HzAt7lqlDIPPT7uvZp1j
	iLvk+dSK/kgosrL6NyplIVMwB2h3hgll9+CoOQPd/10pdj6qxP8pC6zegkCw0ObKDGmdp2Lonnx
	hnNicsxw=
X-Gm-Gg: ASbGncv6YbPhhOFmxsn7YaUasPCpBXIIu77wXb15IcsMhCVcIdEtp5P/uulT4dDG+wc
	ViTzpUKrVgo6usLOANVGFvIWZU3JxLDh+u57iNCoIgW6yBBg2uHMspZqVhr/jqIXdxopKuvU0OK
	P7xsl09LT+5AQSiLh31o5Nh7gahYdHxwDfKqSkXMRCgZQvegB2r/s6Q55t5seKKl+So8YFhze7r
	IyjhgqEitJn6lrAJkAKjjAQXh5krB1hNH2Ue6BMMJaUy2VG2TvTvdpiEtX/hHbJd2FU+o9ITpya
	tV/6/Jl6TD6AbmalyCw+dbdtHlYrTx3OGDwnSWhEgR/el1c0k68u5xAqzdCDcTvxCkNgYkdFKoc
	UiaK6dC/Bou5ebsKGZw5s8bvU6mSNKecQAdqRzDkhknsi46xD
X-Google-Smtp-Source: AGHT+IHVXFBEHJtK7eZa4OQ6iNFAApUgOxQnjsLvnM45eS9xWp0uzsYsMaZNZT28lwtnWG/MDuoUwQ==
X-Received: by 2002:a17:902:f785:b0:274:6d95:99d2 with SMTP id d9443c01a7336-27ed4a2d5d2mr170202155ad.39.1759121426162;
        Sun, 28 Sep 2025 21:50:26 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:8fcc:87df:9a55:2ec0:d047:5e02])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69a9668sm114277635ad.112.2025.09.28.21.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 21:50:25 -0700 (PDT)
From: vanusuri@mvista.com
To: yocto-patches@lists.yoctoproject.org
Cc: Vijay Anusuri <vanusuri@mvista.com>
Subject: [yocto-patches][meta-cgl][PATCH 3/3] ucarp: Fix the permissions
Date: Mon, 29 Sep 2025 10:20:07 +0530
Message-Id: <20250929045007.12623-3-vanusuri@mvista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250929045007.12623-1-vanusuri@mvista.com>
References: <20250929045007.12623-1-vanusuri@mvista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Sep 2025 04:50:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2248

From: Vijay Anusuri <vanusuri@mvista.com>

Gave write permission to po
List of Makefile.in.ins to update po/Makefile.in.in

Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
---
 meta-cgl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/meta-cgl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb b/meta-cgl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb
index d221814..8a2737b 100644
--- a/meta-cgl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb
+++ b/meta-cgl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb
@@ -42,6 +42,10 @@ EXTRA_OECONF += "--sysconfdir=${sysconfdir}/${BPN}"
 # fix the perms for config.rpath
 do_configure:prepend() {
     chmod 755 ${S}/config.rpath
+    # Make sure po directory is writable by current user
+    if [ -d "${S}/po" ]; then
+        chmod -R u+rw ${S}/po
+    fi
 }
 
 do_install:append() {
-- 
2.25.1


