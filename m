Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C8CD358F9
	for <webhook@archiver.kernel.org>; Thu, 29 Jan 2026 10:33:56 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12035.1769682492331632793
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 29 Jan 2026 02:28:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=cZHHru3m;
 spf=pass (domain: gmail.com, ip: 209.85.216.43, mailfrom: nitin.wankhade333@gmail.com)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34ab4ac9a34so60286a91.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 29 Jan 2026 02:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769682491; x=1770287291; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ipYt3VSz5xdn4iFPwBHOIwEvmpEG+Drii0237Ses+L8=;
        b=cZHHru3mBFI56PUjHILNrZ2j0LhU5/67nO3ZzOG7iCGYNk7akuGptX/WG7MwmHzXLg
         a6dfvdp7kakVxS8pW4Mz2uE8cnlkEPFIEmnnzcDD9hoMcIiX+IF5HVPLh6u0qleLAM4Z
         DTKRqTpuoCHtSQRpgMUkq55VqhgHVxsMV20q/nAlkB2YTyXaif4F6WZ07VqDBss3zL6E
         MMSOW2MMrsaXhS9+TXNfrThORKEA1arO9wDB47mPWuVzpwbhPI5LCTEdLgHrxSfjvbgO
         mMkfiD3pNOnfwGudxBd4y4nxXHwBozU0lJLIN3FzW1aOfqILaux81StgaxiQJrXkPWOd
         7UGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769682491; x=1770287291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipYt3VSz5xdn4iFPwBHOIwEvmpEG+Drii0237Ses+L8=;
        b=wWMpI7706JuLGtgsH3LdSRfzkZ5Y6WlN/HYApMQR+qXh9B+TB2NqdeIH9up3ZV32uK
         Mr4JCPgH5cG7ByjUWS+dTiwepO1r/hupE0DAdx7yVit7TWGy6iSMIczK2FeIusv6SAQy
         60Oniq8AxB40mwuLbiT4VY1yi93BzfVS8QpVg19I45z5Nc5rFIGe2S8VVvC0kBym2S2/
         36/57vV1IrJCSINbJDXlOZN7PIC9x1pilZ0/jGdzYvCF9j6i+BWfIL/5NgLeDBaZsPVN
         Qlb3ZcFjGEJoz0bCn6OLnox812vGAlwg0omBF/AZd3cuMhAI9uvYnagBejSSzzmj07W8
         W/gg==
X-Gm-Message-State: AOJu0YwmsqqFTlXqvF8R06N1E4xU5zYRmhVVM3MtmyAVnKj7nhyc3zkw
	+f5B/RKhHtp0cVm2ScwX1rA/KNgZANr5039Mh4U4KiBL+PZ1k7iI5/Gmmd7g2w==
X-Gm-Gg: AZuq6aK8mMcmPFmUTEe1PIJJigFohPL3J5elV9W/dWAUIzzU2RKV1ChhPYXJhMADN7D
	vb8Rc+rAj/soHH60Nzj6XoSXNuXuDOKfpBb7hEIVsvtoKIVdJAvb8Xty/OaczwpZjYNQ5IEOpck
	hSpqvWzVrdFVfWbyMjoBqkxj+befU5rFPcmIr1O3flLcHfZaGz+L77uBYlYvNuwpa/Ocu+qJAXd
	csalCVQSKOFidbNWTodYZ5CTZMlQ6ArUmadw1E/0CxczKWbu58dMwdf7BA3yYtMGHFBhQWMqB9o
	ecD5xv4RdFiKnYaXfrjJlHzmGs92t2mYHZZ69FA7UdhMs0al9ae7wve4yxflpT9lUggJfOxVkM+
	A22K4tDOBHPhbvWsW+8VgFNayrwDsF1lr8mKtVquLA+Nlm5z3B5DIywDqWoq3u3/Cv8c3KPRBcb
	VJzkZqTfvhz3rTH7aNbDwIcZnC
X-Received: by 2002:a17:90b:564f:b0:34f:4416:33b5 with SMTP id 98e67ed59e1d1-35426d46080mr2151985a91.8.1769682491234;
        Thu, 29 Jan 2026 02:28:11 -0800 (PST)
Received: from LL-3324L.kpit.com ([122.167.116.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f61e0230sm8119613a91.11.2026.01.29.02.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 02:28:10 -0800 (PST)
From: "Nitin Wankhade" <nitin.wankhade333@gmail.com>
X-Google-Original-From: Nitin Wankhade <nitin.wankhade@kpit.com>
To: yocto-patches@lists.yoctoproject.org,
	scott.murray@konsulko.com
Cc: mail2szahir@gmail.com,
	zahir.basha@kpit.com
Subject: [meta-lts-mixins][kirkstone/rust-1.75][PATCH] rust-cross-canadian: Ignore CVE-2024-43402
Date: Thu, 29 Jan 2026 16:01:57 +0530
Message-Id: <20260129103157.1739640-1-nitin.wankhade@kpit.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 29 Jan 2026 10:33:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3142

From: Zahir Hussain <zahir.basha@kpit.com>

Ignore CVE-2024-43402 as it is not applicable for Linux;
the CVEs are specific to Microsoft Windows.

CVE-2024-43402 is still reporting under the rust-cross-canadian component,so
the same change has been added to rust-cross-canadian.inc to ignore this CVE.

CVE: CVE-2024-43402

Signed-off-by: Zahir Hussain <zahir.basha@kpit.com>
---
 recipes-devtools/rust/rust-cross-canadian.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-devtools/rust/rust-cross-canadian.inc b/recipes-devtools/rust/rust-cross-canadian.inc
index 45cb402..996e8c8 100644
--- a/recipes-devtools/rust/rust-cross-canadian.inc
+++ b/recipes-devtools/rust/rust-cross-canadian.inc
@@ -90,3 +90,5 @@ do_install () {
 
 FILES:${PN} += "${base_prefix}/environment-setup.d"
 
+# These CVEs are specific to Microsoft Windows
+CVE_CHECK_IGNORE += "CVE-2024-43402"
-- 
2.34.1


