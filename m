Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13222CD3423
	for <webhook@archiver.kernel.org>; Wed, 29 Apr 2026 15:40:22 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14377.1777477219825667353
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Apr 2026 08:40:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=iiM3vbMp;
 spf=pass (domain: konsulko.com, ip: 209.85.222.182, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c70b5594f4so108683685a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Apr 2026 08:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1777477219; x=1778082019; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NBpZ+pcLs017on6OseogMEJeLsR8osE3UQ/Si2I7kdA=;
        b=iiM3vbMpfh+6l/XfmQo/NSRanU+NTWyciRymuVfGkAxRH6UrsS5Xk6jVn+8OSpQ3CH
         75T7CNTZyWB1sqC8R4KYullM2kGZhPTfrMbbIdyduyf0NsJy1dAMcQXZaertE6NmCl64
         fSr6mo8heTezmGsMTQaFLifVE9q7N8cFI2D4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777477219; x=1778082019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NBpZ+pcLs017on6OseogMEJeLsR8osE3UQ/Si2I7kdA=;
        b=qghSRO1k02UXIaCUs7vLC9Q8xVrscZtE+4sV6FQENTiFmDROwkRQq4sUJibgPkfko4
         59F5+hHh8/qUVPcn88YVXm00ZlNi3NuZvHg881wC1gXkp7tbtIwcM+GROrDgc194dcyx
         IO11bmK/cFdmartHXIln4CT6/zVufiPWkr9Yra9hb8aFgaYIqoChQYceMJ9/UsSOyXgY
         GocvUUxxom0OKeRdaqtRPuCSQUj4vgm2moABSfaeiQCMpOybeUHQHXLeCy0rtUegkkkG
         N8/SsqSP/PHeYW/bpb+OWSSB1EMV1Z84e2HuRpxlJPE+XiO6dKE/x9rmlyAf4ifWyAa+
         RXBg==
X-Gm-Message-State: AOJu0Yy37THrUCj2R/MIrNPspk4poBeQKPbobag66kukbWcL2arKH3WL
	q/frBBf3Ggf+EeVvfJY+5KMQUEzDqb6gH8Y43ZTMiJiHI58gilYUIjGJSZyojMzYmDXg7E30BBn
	hsl9V
X-Gm-Gg: AeBDieuCTpO+bbphr1paf81ja3nF3T+EFfEaoty7N8phKIYlZQI0B8RhvlPrlP1euSO
	lLX0FuM1k00U0I0CLyiIGkB/GdRe+Z/PZBgRsCPA3C/eoQRDTmtfAZUXIcp6MK//OGX9O2ckQWe
	Zc+dS2P1HR5NAVNjIJV4ScKbK2gVBZQYRp/2JO20vZBLDAIiB54ava9r3e0ybJIvz3aTol4Fzd/
	c5mq/lcD5L43ypHwKXW7uaWzj2wyM3bWIvsE02TSmlqzGC6UMtmYHGNcfaaI5Fuh2YZTz0b3yx2
	Bswco48QGe7RjWnwrtqgMLxDS3ObJ/yPucKcyvMEtpcSe4tTJVYt7KzFqK7u+9TyGrMRWakLewV
	nXRfPGSVMKotq6W8JHAmASYaEHpR+NKKdRcYm6MEWds2n0m2+nZOSpbQZIhBdOAaal9ENDlKYmv
	vw4/xZ2BNtY5Z1kaL1kUrlFByBm4pUVfnICpqTfRB7XHtTqjHbfP6yJgYostn3G7iiI/Rfx6MfZ
	BUkn5J+1jlNwF/TwbA4Ye2y2IvGtWAnNxCosW3fmR0g0YtbDBc+lKw61iHO9X7Eaov2ZysJfAs=
X-Received: by 2002:a05:620a:4591:b0:8ee:fc5e:e2e9 with SMTP id af79cd13be357-8f91742ff33mr479845785a.13.1777477218475;
        Wed, 29 Apr 2026 08:40:18 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f940340f1csm207924185a.44.2026.04.29.08.40.18
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:40:18 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 11/13] packagegroup-core-security: Add missing packages
Date: Wed, 29 Apr 2026 11:39:41 -0400
Message-ID: <5a333f46463b4c2b24d97472dc995b24dad5e4f1.1777476608.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777476608.git.scott.murray@konsulko.com>
References: <cover.1777476608.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Apr 2026 15:40:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3885

Add aircrack-ng, crowdsec, ncrack, and opendnssec where appropriate
now that they have been updated to build again.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-core/packagegroup/packagegroup-core-security.bb | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/recipes-core/packagegroup/packagegroup-core-security.bb b/recipes-core/packagegroup/packagegroup-core-security.bb
index 101bc6d..6aa7a82 100644
--- a/recipes-core/packagegroup/packagegroup-core-security.bb
+++ b/recipes-core/packagegroup/packagegroup-core-security.bb
@@ -30,6 +30,7 @@ RDEPENDS:packagegroup-core-security = "\
 
 SUMMARY:packagegroup-security-utils = "Security utilities"
 RDEPENDS:packagegroup-security-utils = "\
+    aircrack-ng \
     bubblewrap \
     checksec \
     cryptmount \
@@ -39,7 +40,9 @@ RDEPENDS:packagegroup-security-utils = "\
     glome \
     keyutils \
     libgssglue \
+    ncrack \
     nmap \
+    opendnssec \
     pinentry \
     softhsm \
     sshguard \
@@ -88,6 +91,7 @@ RDEPENDS:packagegroup-security-ids = " \
     python3-suricata-update \
     ossec-hids \
     aide \
+    crowdsec \
     "
 
 RDEPENDS:packagegroup-security-ids:remove:powerpc = "suricata python3-suricata-update"
-- 
2.53.0


