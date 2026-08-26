Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36562C61DC6
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 20:59:04 +0000 (UTC)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22437.1787777934430968616
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Aug 2026 13:58:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=XJiKyUjD;
 spf=pass (domain: konsulko.com, ip: 209.85.160.177, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-52e2d1bdbc0so10469721cf.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 13:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1787777933; x=1788382733; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pn1ziw/2Ct0AV93+LleKcaEf4OfiR5j3sKq4oZLw3Ag=;
        b=XJiKyUjDjDDOS5Rm/fGiEuWRe3IzahB8b+hE1UMHWhetvPB7nQou75DMcz2PTyo64T
         x6hLN4V3WM33eK7R+BzCteUDuHqr9vFXwtbdJoWqDwBcjj/5ZfLzs8gq9K8K7AtGYBwf
         5hS8HEx3jrXcOwajLBsNaIBulqhFzEEfLQUkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787777933; x=1788382733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pn1ziw/2Ct0AV93+LleKcaEf4OfiR5j3sKq4oZLw3Ag=;
        b=A5g1rmbjU2JPD4esk9Co74lr453BaR7DdC5anaJh7GN/gcxpR0+vyXNnNNUlepPF6e
         EXKpukzDVQsp3ksE5m1o67yKahGpVhAEkrWxa4oHaWAvVRRr7PGS2vnmKieuRuPuLXmX
         CrJBjJH4j803dbbOtCsKb/G70Gd4vbyk+sEQ6eWEbaPC1PnO9gwvqWDgmJIO81XyTGCj
         Oxdk/cfckFbehNXoB/G8phUzw/SRE1VgnM+MxQUQ7PoBwTzwOsH1xE63dsfAzoPEhrlP
         2N+DTb7IDI2m+4/GtEEBl6s2jBq0uhEVFGHX98jkQytEVSnOnl3+La5wC5b9z6dMRmzp
         zgQQ==
X-Gm-Message-State: AFuF++m+ELrZ0PSHi+vzmr0qhYusQgc+Vdp7AmnsTGM6TdxKBDsMP4YS
	umdXPXFK9U2Y8E74aBOPmcr3hixVfYg76etpOkWf3buV7SCEzAS2ethLDJ/qSetdOXT0aTIdDxM
	E4+pb
X-Gm-Gg: AR+sD13fP0xWSdgoLbXBkePeQ/yFWX3KTxfQItLWcaC2G+jNa4hYgeA/XSRAazc1t3d
	+xQLFHL7EPFIh4Bg/BLFSaF4P/E9I5JXaxx2c5+CoYAcRiWwMiDM+K4nVEj9Z7yl6xcvwDzEyaf
	Fb7uXIkfgZJIGVHk5Ny8/1l38Nt0/TOmA7gT14uS7JcZYs1jM1A/y+xfJKEXYblGm8IQ5GaLFrM
	b6O0jNkbHcty3iSjvxQIYmCXUBUfK5Pjjvmu+5N8dBDwQfHQpYvaQQUUifLL0/nK2tQ5rQ/p0WB
	gfA2Z0ZJ8QvoboKd5ERThUVHvskucNAg+idhFvtyuOBfAafUQXU+CqOVwIihas89oU54Clt8C2w
	CCjk29Y3ug4ThbUv/oebsiZxv52F8Rt/XocZB7AFcYhspTlYU/qW34usQ7G742UyOUZjwccUUCl
	R2dG5eQXwwH7xEjSojBsEQe0k4DGkthiSNNJDjzCb4VrOBjU0NeUdRdLrYzFaekxL1UlRsrTVdW
	2RuhPeezZCzTjkEYzFB9FT7sq29yg905EfgMTOEe0P5SxCYjpF0Z27WSaEH1+dQD1PdNn/Rjg3u
	NYZ8YFERacFJsE1nnQZxG3otc94=
X-Received: by 2002:a05:622a:8e0a:b0:52f:a0b3:bcb2 with SMTP id d75a77b69052e-52fa0b42525mr30240751cf.35.1787777933262;
        Wed, 26 Aug 2026 13:58:53 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cc65093d5sm35135856d6.26.2026.08.26.13.58.52
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 13:58:52 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 10/15] tpm2-tss: set status for CVE-2024-29040
Date: Wed, 26 Aug 2026 16:57:44 -0400
Message-ID: <aa594ecd247349028ebb13fef357819462a05ac8.1787777775.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787777775.git.scott.murray@konsulko.com>
References: <cover.1787777775.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 20:59:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4702

From: Peter Marko <peter.marko@siemens.com>

CVE-2024-29040 is per Debian report [2] fixed in 4.1.0.

[1] https://security-tracker.debian.org/tracker/CVE-2024-29040

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb b/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb
index f8e87a5..30e984e 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb
@@ -94,3 +94,5 @@ FILES:${PN} = "\
     ${sysconfdir}/sysusers.d"
 
 BBCLASSEXTEND = "native nativesdk"
+
+CVE_STATUS[CVE-2024-29040] = "fixed-version: Fixed since version 4.1.0"
-- 
2.55.0


