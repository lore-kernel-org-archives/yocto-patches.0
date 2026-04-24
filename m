Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84538FF884F
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 21:08:55 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32237.1777064930548769103
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Apr 2026 14:08:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=S1i++e4o;
 spf=pass (domain: smile.fr, ip: 209.85.221.53, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d73422431so7278017f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 14:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1777064929; x=1777669729; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mi2emXBi6DZfWnZxH1gC22Qh5wRVPN5SxRhyVHM2SYI=;
        b=S1i++e4ofrEC6nyRa2W2Vjfqu+u4veB3UmtDlyvR5MtYqbL8IFpB4YvX1E7nvxhTlt
         FHBEKp/GhNNlHyy3zyUhoyMUaap8YNDxnaAeeCjvjEPYky+UIOJ9uF0dIDyIERMlAVI9
         s++qQfC74sVLvZKnPeadx9YpNkMWkwT1FbuB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777064929; x=1777669729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mi2emXBi6DZfWnZxH1gC22Qh5wRVPN5SxRhyVHM2SYI=;
        b=Z+ut8W6cyKc0Y98l0zGyBQ3oCbgeSvIfSOCt/fzxVCwHcxhFLlv6j4ov1FyMgJzCp5
         hBNtH5SuNXJBNykgiwYplsjHwLvapr6yteYCGfkcb6a1K+Vm3JNjNyIVU1HfwMyoR2vm
         qJtR6Ajy7Dz1t13ZHweVNsyjGsDa4jNc3ya2uWLoAS2RqB7FX6D1vwmsDut3GWTrWf+8
         RyRmeNFSTbhWn15och2RgbOL1WK+ILryZyKyx1Pvv0dd0iZfZZyriL9uCVwlG8eJa2y9
         bAAQheNT/btU8qjXidzNXO3GeeorN/1zcGTJZdzCoWsNk9mlh7K+bLn/pzLtgGEzm2Ax
         yo0Q==
X-Gm-Message-State: AOJu0Yyq90MfO8gPq4R9H5W1AFxyBqdzrCBDzzuMTjO4ZUrdNkX2Nrn+
	k0DSzYcw9Nl+hQSNcHTu0AyFtaGLOEWH3LzCVlmVEHWP635w95THtnWC0pTKaO2zl7/Tar967fD
	HoLy6pjGjkg==
X-Gm-Gg: AeBDieunAGtg2jaASVXt4eHK7ll77TJmfgPIx+PIOEtZgGClBIL6/CmmKnWsXOcAYFk
	oU5G/v37uBgZ5294IfMXs0wB3AYTYK3Q+v9lE5kZEi1Qt8adHi1+wXeRDz8BCne05Ay/dFq5u3H
	rXiRNYfqvwhv/Gs9Bpv63PW8rkHRVarnuCyaedyEEeUbbRGxQpM/aMBz+UvrYMUTS57lFC5EPOl
	/RRwlOOD9x8I5VR3H1ONensH0488u9/9RqRjuMLzkqvtQG8IbTEkcJXNICgHVUu5UZbYC88UzkL
	Pe0qjqt9XF9S5HJ4W9GiOK18ZulSSdsHl+Ws6VKN2laQuo2BL5osuugmUGGqWmWZZBF9AshNhsE
	IFQtSqUOrI1PqYI8fuZ7vbI9Z8ZZKd5Ct+0bWIY4C/+dbUofLNVNQ7W7MrWDt+T3ND0acqGWe9c
	t5HB1emY84tTFqV5Qu8vlCeBzb8fx/yFaoiBrIA3awuGQrTEhfeRu3JSYkBqgf9qebGe7DfoV+x
	78Ql7fVKU5sWNGshvJNxfks11IqM2Uws7F7VQ==
X-Received: by 2002:a5d:64c4:0:b0:43d:7c6c:a0dd with SMTP id ffacd0b85a97d-43fe3e1603dmr50848987f8f.35.1777064928670;
        Fri, 24 Apr 2026 14:08:48 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4dc24cfsm61436286f8f.16.2026.04.24.14.08.48
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 14:08:48 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][scarthgap 2/2]  scripts/yocto-supported-distros: fix the centos stream regular expression
Date: Fri, 24 Apr 2026 23:08:42 +0200
Message-ID: <b7119bff3aa6faf31a2e72b33a8fe2040d407bd7.1777064869.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1777064869.git.yoann.congal@smile.fr>
References: <cover.1777064869.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 21:08:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3811

From: Antonin Godard <antonin.godard@bootlin.com>

The poky.conf file was wrongly referring these distros with
centosstream-*, but this is now fixed. Change the regular expression for CentOS
Stream to match this. Remove the CentOS (no Stream) definition as we do not
support it anymore and it conflicts with this one.

Cc: Yoann Congal <yoann.congal@smile.fr>
Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 scripts/yocto-supported-distros | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/scripts/yocto-supported-distros b/scripts/yocto-supported-distros
index cdd3967..3266d52 100755
--- a/scripts/yocto-supported-distros
+++ b/scripts/yocto-supported-distros
@@ -77,13 +77,9 @@ INPUT_REGEXES = {
         "ab": re.compile(r"^opensuse(\d{2})(\d{1})"),
         "lsb": re.compile(r"^opensuse-(\d{2})\.(\d{1})"),
     },
-    "centos": {
-        "ab": re.compile(r"^centos(\d+)"),
-        "lsb": re.compile(r"^centos-(\d+)"),
-    },
     "centosstream": {
         "ab": re.compile(r"^stream(\d+)"),
-        "lsb": re.compile(r"^stream-(\d+)"),
+        "lsb": re.compile(r"^centos-(\d+)"),
     },
     "rocky": {
         "ab": re.compile(r"^rocky(\d+)"),
@@ -112,12 +108,8 @@ OUTPUT_FORMATS = {
         "lsb": "opensuseleap-{}.{}",
         "docs": "-  OpenSUSE Leap {}.{}",
     },
-    "centos": {
-        "lsb": "centos-{}",
-        "docs": "-  CentOS {}",
-    },
     "centosstream": {
-        "lsb": "centosstream-{}",
+        "lsb": "centos-{}",
         "docs": "-  CentOS Stream {}",
     },
     "rocky": {

