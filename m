Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CFECCD199
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 21:22:44 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.web11.1670.1760649755021273498
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Oct 2025 14:22:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=YBaPu11K;
 spf=pass (domain: konsulko.com, ip: 209.85.219.50, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-87c1f607e72so11784646d6.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 14:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1760649754; x=1761254554; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cs0R+hyzIa9bl+iu0N/1sn/3/0+Bp8jJ/sGqYurbw4c=;
        b=YBaPu11KIm1GFM/K8NA+w+t4wufvxm7+U/F2QQI5O1X892DKM1gynCNoM1hM5AkUHV
         CBDeaP1/GhyixvXTxaH8UUq7zkMZnBU4dSXfSIYqBRW0E9EC/qu3Bac5JxA1VXSLCaLx
         w+WbBZ+90nKJedaOH6ytWZCpRfNZjff+8CAy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760649754; x=1761254554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cs0R+hyzIa9bl+iu0N/1sn/3/0+Bp8jJ/sGqYurbw4c=;
        b=ApJigF/3Bok2HTyCey5lJfjkkzivGtuKnpWLXlvjD/34Kt6kS/KLJwty+2W914UGed
         hx1noIMgo8t+7UTg8euQW5G556svHfA56Q83UkjTgY00GaQJo0s/Liem7y4SF7p0YT68
         Z05/cG11yE3ymnv+DCzZx3nUZLeK7wzs0g2WVLaSN70jCcqwomgt7bnLSuNTgk+JXVr8
         wQyNgPMuACejxG6gBgLx/C5ANINhPhXK1NVoJeMOB056t1CGPLhLtG4iiS2KncdqesEu
         Hk5elBqyPfTecEqXUY4ibBYVTw2WzAWcCqRt/8vG434k+W6JdPTnmGiJpHpLCMbLGLTR
         LjNg==
X-Gm-Message-State: AOJu0YzrB0cnGbxM14q+fAjFEHer+vKe3/FV6z78vhspeOTDK9q3TIaS
	5rHfXK70+5XVjqbwa19FmUMuGQdP6Z4tHERriOADZp45qjZ9AMYhzrkKJDfgS2e9jxhjDKVij/W
	K40PD
X-Gm-Gg: ASbGncsKzdMbWrusDsQeF6OO0uh+sh8xATdLdSoHD5X45SBGUV8KgaXWt6/Z/6o6+eA
	E0YabYYCLnR2OWXHvx5uhgdNWY245TmfI9Bw2ewaHoC9KRv3S4oq9NSPBoEOJEt0di1ngCGoC6/
	m4cP4GFKXm81ojNtPvQupGKtrGjMpjNl8NjCGMd4KyG5cMOfNQrnHyzj7u+dvqHf9ZM1RZO7tGC
	gDyR5QcDib9kfo/6LRXnereLYvyCYsX2mkN4PATIP70BPf2I7pu/r6xQv1PckMWkWNOYc61RUA/
	X2/surfcNkJFuJ3J7f2EKtQNXIdSSSXE0Yywl5Mnw2N7qaug5cACn+9BoR/1cCFTz1GscMOyWeu
	91M1Ir1PB1XQUcQ2dGXL/WNSCdHwFjH6eHSwKplGv64b4ZCAfIKdih+RxFQrr6Xo6V+uDlp2Eh7
	soZnYIDCgHI4kbDXcUHulgKcV1W9yD4aKzlLWVpVDAluO8gQqd5Sp2
X-Google-Smtp-Source: AGHT+IETuITvB5Gy7F13O2gOpPGYGXlrPPOc+jFlO4brRlQThenLyoT/gcRvbuTwGhzJngn1+s1m9g==
X-Received: by 2002:a05:6214:e8e:b0:78d:592d:fd03 with SMTP id 6a1803df08f44-87c202ceaebmr26546986d6.25.1760649753581;
        Thu, 16 Oct 2025 14:22:33 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c1c2fd4f4sm14647466d6.7.2025.10.16.14.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 14:22:32 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Subject: [meta-security][PATCH 02/15] lynis: move to GitHub fetching
Date: Thu, 16 Oct 2025 17:22:01 -0400
Message-ID: <ba822ee5d7b67a971e8ecc561e0b842a7e53cf58.1760648348.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760648348.git.scott.murray@konsulko.com>
References: <cover.1760648348.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 21:22:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2327

From: Marta Rybczynska <marta.rybczynska@ygreky.com>

Move to fetching from GitHub hashes to avoid issues at releases,
when the last-recent release changes place.

Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
---
 recipes-compliance/lynis/lynis_3.1.5.bb | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/recipes-compliance/lynis/lynis_3.1.5.bb b/recipes-compliance/lynis/lynis_3.1.5.bb
index 3d1e8b7..51414c0 100644
--- a/recipes-compliance/lynis/lynis_3.1.5.bb
+++ b/recipes-compliance/lynis/lynis_3.1.5.bb
@@ -6,14 +6,12 @@ HOMEDIR = "https://cisofy.com/lynis/"
 LICENSE = "GPL-3.0-only"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=3edd6782854304fd11da4975ab9799c1"
 
-SRC_URI = "https://downloads.cisofy.com/lynis/${BPN}-${PV}.tar.gz"
+SRC_URI = "git://github.com/CISOfy/lynis.git;branch=master;protocol=https"
 
-SRC_URI[sha256sum] = "8d2c6652ba60116a82514522b666ca77293f4bfc69f1e581028769f7ebb52ba4"
+SRCREV = "380b414e09bbca70be59a1b7ddccfaed4c30e1aa"
 
 #UPSTREAM_CHECK = "https://downloads.cisofy.com/lynis"
 
-S = "${UNPACKDIR}/${BPN}"
-
 inherit autotools-brokensep
 
 do_compile[noexec] = "1"
-- 
2.51.0


