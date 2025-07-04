Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B70C83F0E
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 17:11:58 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.web11.1103.1751649111233915699
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 04 Jul 2025 10:11:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=nteBE4Tw;
 spf=pass (domain: konsulko.com, ip: 209.85.160.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a43afb04a7so8855821cf.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 10:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1751649110; x=1752253910; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gBWi0Quz5Fb13rYqXrwLeyu3nQB5rO5kgQuoA6jenA=;
        b=nteBE4Twoza8xBDAeHcFgjOPxLh7R7U+4XV3/Qt6EdSblrZPvVatQfKOIvT9mcxOWe
         tpYQqafOsmueVJisJd1Wbw7Mkb+qCfeJWJpjfaTTvhfXgGAtgAwT5saQSt+yaqtb+gwg
         TdAxv2TbE0wM8r1a5Wo0TW7vxQnnD8qvak/QE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751649110; x=1752253910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8gBWi0Quz5Fb13rYqXrwLeyu3nQB5rO5kgQuoA6jenA=;
        b=W3tEmscSFkqdGQuU9gvDBfp5zsNJAbJEtwNFRMvtEoljeSQx5MLlg/TxxqvPGQN3kw
         cJFmzkriXqBO7tvNEI3CAY5MXs0wKJrqK9XRV+0tOWqFvP9zVVRQ8WYTSzJ7XaEwkdoE
         Y+WdlvK0uuC2exZfM26SSrsG1F14Al8cGSRRVVQU8ee+Af58Qjo8+W/n7Np8Zgf3ps+Z
         wdivMZxbIV/HhrZFPPgz2fYMB9B+Nf0zp4VgHAmV4X17eiANeNHLgkBZdzRm/6W96pgF
         dh90vEIpQq/id+1EqMIvgfGMUyqCXKKcEDQSqkGGgcT2UVWevkAjAGofQHM6ojmyMCu+
         bndQ==
X-Gm-Message-State: AOJu0YzJiKnmjXGIgqyJM7j/LBHj88gACj/T2at6JSvyqXwxxe2+g1bS
	JIIUFCtGhd9f+8MFQTMBamdbWvTSk3JTck0tZIwt/btxlm2qFR0z2H8P9b7MuNZiueLkOsbXqD/
	SIJFU
X-Gm-Gg: ASbGncssPycAV1J1MNW9lgioxBe38DE1MWcIGOZxzoW/+nXHKanA/uO2dqCl9tRTWQu
	ywwRu10Afe+KqU91eU9EFiCLx5AbbGuMc+yIhA0uic9nhynqLdk4ixZj4aWUQS97VotACzkGodN
	Qe0vb/YH3P2wPmLFbxUrpRqyRAFPtWXoSttg8MpRaXemKcETWkYH41cI6jmbspMA5+8i+sby933
	KIqDbf/w5bcRUXXnUzDsvAJ7EeeM1Up6LJTmMsefPda4i1Uy400jbWi9Ar7nFtmRYTTiWXwkEH2
	LSsK9neZNWbyAhdpdMF4D7DaZgHrbxagrct9fC0NfTGQBicay1xF3zmKcDXUsxjQQXkm6bXgA/t
	B0wDN05mUq1F2S6VfPBGN3lNmRLZNNdTz3A1jOw==
X-Google-Smtp-Source: AGHT+IHtFIhEN0PC8vuYC03/piAsA+6pImgu5OxwNh8oV0+nokndeaBz5NUvtbdH1RmQhar91ifaQA==
X-Received: by 2002:a05:622a:4d08:b0:4a9:80f6:19ad with SMTP id d75a77b69052e-4a99885a865mr37200411cf.45.1751649109897;
        Fri, 04 Jul 2025 10:11:49 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949f99dcsm17249611cf.19.2025.07.04.10.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 10:11:49 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Clayton Casciato <majortomtosourcecontrol@gmail.com>,
	Scott Murray <scott.murray@konsulko.com>
Subject: [meta-security][PATCH 02/12] smack: Use new CVE_STATUS variable
Date: Fri,  4 Jul 2025 13:11:06 -0400
Message-ID: <ef790621653f6b88adfe58be4a1f508408d48cd2.1751647559.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751647559.git.scott.murray@konsulko.com>
References: <cover.1751647559.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 17:11:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1754

From: Clayton Casciato <majortomtosourcecontrol@gmail.com>

Fix "CVE_CHECK_IGNORE is deprecated in favor of CVE_STATUS"

https://docs.yoctoproject.org/dev/ref-manual/variables.html#term-CVE_STATUS

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-mac/smack/smack_1.3.1.bb | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/recipes-mac/smack/smack_1.3.1.bb b/recipes-mac/smack/smack_1.3.1.bb
index 6c52392..7b20e6b 100644
--- a/recipes-mac/smack/smack_1.3.1.bb
+++ b/recipes-mac/smack/smack_1.3.1.bb
@@ -13,10 +13,9 @@ SRC_URI = " \
 
 PV = "1.3.1"
 
-# CVE-2014-0363, CVE-2014-0364, CVE-2016-10027 is valnerble for other product.
-CVE_CHECK_IGNORE += "CVE-2014-0363"
-CVE_CHECK_IGNORE += "CVE-2014-0364"
-CVE_CHECK_IGNORE += "CVE-2016-10027"
+CVE_STATUS[CVE-2014-0363] = "cpe-incorrect: different product"
+CVE_STATUS[CVE-2014-0364] = "cpe-incorrect: different product"
+CVE_STATUS[CVE-2016-10027] = "cpe-incorrect: different product"
 
 inherit autotools update-rc.d pkgconfig ptest
 inherit ${@bb.utils.contains('VIRTUAL-RUNTIME_init_manager','systemd','systemd','', d)}
-- 
2.50.0


