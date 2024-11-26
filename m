Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487C1D65543
	for <webhook@archiver.kernel.org>; Tue, 26 Nov 2024 18:12:24 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.web11.53413.1732644741328707488
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 26 Nov 2024 10:12:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=bSgWemhh;
 spf=pass (domain: konsulko.com, ip: 209.85.219.48, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d43b396c9bso42948966d6.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 26 Nov 2024 10:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1732644740; x=1733249540; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cdZjPjKouZZ33RteMDzOPlMJn8v00xP5CXO0lPjfqKg=;
        b=bSgWemhh2RIcjf1f+S2Zg9SfSCve5E1BYe+vjFUtWimYlz54hOPAN7+TVmXTkNr5aq
         XQx6kn3y8YiLXSEcMOaycMIX4VLuZa9Gqmxphoq8Go/ZEzYtpWWhNtv2CXso6k/oPP2A
         NQ1xqmgI9HzipPQ83BCmdcIzs9oYNRDy9mEM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732644740; x=1733249540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdZjPjKouZZ33RteMDzOPlMJn8v00xP5CXO0lPjfqKg=;
        b=j9talH7vDgXtReB3HDhLlKr6bVW/PPNE2ftnqxKt/4faC0eoXB1tHa8h/13QTaKuxh
         k2ltxKfENL08rSUgaalaL6gUy8BJs86nJZCDpGElpsX34jBan0piUdiqMZpZsjodg7hu
         xSTK+HHx1XHZYbFG0tdhLC+lZhAaV2VzVgEc1PYWK5lWRn5w8L2JUzSewbXDOfprgoTf
         PmP6L+FtdThH/c1b5B88LV+9l+HNb12PZJZ0bBSixOzbugUpTiaTTNyJw+tKkAU5FJXY
         rXiRNUXsMyvvDPxAXe943KstS87vOspHZDO6TeeuM2JxugqqnoEiSQUi/C0OofZd2Jwy
         zO+g==
X-Gm-Message-State: AOJu0YxOGfVMCF35d16lpSRzc0EJy15KNI7Lm6K7qDngOnqQrhoSCXsM
	gfaOWtRJkaBCerIB9fp6dVd1PixxpYIy4tQNJgKfFoNXMmxMdYq1FXptSqcrPcXWPjG2KEgJeCj
	x
X-Gm-Gg: ASbGncv73miXfdM+PcPq6FMxXVskRDis51M5u2WTJP+uiguSVFs1eUhqH07uRTwb7S+
	tIOAwaPBmjt1Me7HLNYUQfC2DaDPgdmshrxa8jSk6FKZmkgRX+t5elP43MkN5Pl+wCMzaF0z86n
	wGtxM6w21mLa8uGFSUlTy7M5riqoHzgYCy+fdC2W0DXFn3IJLvM+Gw1Vb9v1+lPMn7sBvEmws8U
	T4b37qEXfqzARJakuLOjfUyQT1P4i3zwqQSJgNLQ30N2PnD4NPRlZ3a0e3u0ctNpCdPVuHtPlpG
	b878ievGK4IeidLGKwkdRQSgbg==
X-Google-Smtp-Source: AGHT+IGDB1iBnw+rtoov929IV/eiOok5QIx+S84aSGj96ne5VhDHqqWJ4sNWs5ebG0PE3glo9tUtQA==
X-Received: by 2002:ad4:5fc6:0:b0:6d4:215d:91c3 with SMTP id 6a1803df08f44-6d864d95c5amr328966d6.28.1732644740223;
        Tue, 26 Nov 2024 10:12:20 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a83ea2sm58171276d6.22.2024.11.26.10.12.19
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 10:12:19 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 9/9] rust: Restore CVE_CHECK_IGNORE
Date: Tue, 26 Nov 2024 13:11:40 -0500
Message-ID: <20241126181152.407253-10-scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241126181152.407253-1-scott.murray@konsulko.com>
References: <20241126181152.407253-1-scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 26 Nov 2024 18:12:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/842

Backported changes converted the CVE_CHECK_IGNORE definition in
rust-source.inc to CVE_STATUS; restore the definition currently
used on the kirkstone branch so cve-check yields the expected
results.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust-source.inc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index c39c954..c21d1d8 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -20,3 +20,6 @@ UPSTREAM_CHECK_REGEX = "rustc-(?P<pver>\d+(\.\d+)+)-src"
 
 CVE_STATUS[CVE-2024-24576] = "not-applicable-platform: Issue only applies on Windows"
 CVE_STATUS[CVE-2024-43402] = "not-applicable-platform: Issue only applies on Windows"
+
+# These CVEs are specific to Microsoft Windows
+CVE_CHECK_IGNORE += "CVE-2024-24576 CVE-2024-43402"
-- 
2.47.0


