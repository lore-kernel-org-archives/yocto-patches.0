Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2479C87FCA
	for <webhook@archiver.kernel.org>; Thu, 24 Jul 2025 07:27:21 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web11.6900.1753342041095536911
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 24 Jul 2025 00:27:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AqcLSkI7;
 spf=pass (domain: gmail.com, ip: 209.85.221.49, mailfrom: rybczynska@gmail.com)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b611665b96so375664f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 24 Jul 2025 00:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753342039; x=1753946839; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyQiS9kXGyoF/yZq5jueymRo9pLyoBUY0gA1PIy4BcI=;
        b=AqcLSkI7zv/sO1K4AauQc+qejvQdtp4rOfVwN1j70X745T1QZJ/9ClTVDEfLpiIqh2
         8x+X6DhJJ7aGBaEwZt5+OviQNkvEpcOfYEQj4NFIOPAjmVrvUQpbrNpVrLLv2KO1TAfq
         WS30jzhJf5aGpcJWB1TKzUsFtUZaHIXKIcPoCjYa0KUgV85eTJcue+vVx1lNAhxUDcgW
         t/1dMHNY+NKQEG2TSK6w01mxtQqnrlHcyl3juyZtzZQvb2eXZUQ0YlWhIE5Sj/UEXTrz
         FKGyrepFagNl3me7zfeCMhkTvU5z84YDbEtKHGV+9pZos88/+p3pwqBw6da3TIfP7nzW
         mxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753342039; x=1753946839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RyQiS9kXGyoF/yZq5jueymRo9pLyoBUY0gA1PIy4BcI=;
        b=DZJ7CrhbNlmkGOw69O1Q2ZVRmkTV8N+YU2elow7akrJO+ZDpp83+H+TBs5yF2N3RS5
         otyA5PTX28PDihc6zdEqsoNHgZ3+CF37SgBzK6KmycQvzjcrSChglEi1F332qzvTSEp2
         fOADcVuYwW6KoGxBZeS5pU7ubgGNW30kcgvmGb9MMR34rKuaef93NE60uvOfCUsMZJRI
         LwjHpD0klF1AwB+DTKALLsgeFc40R3+vn3gXSlH+edxd8O2ghKo3P4K7HgYcfLIjQMjm
         tE4SSL7YZCatX5UVch4iNgHggZ4PxCGrMMdnNunuUh2X9ng+yyEgsLgVvjhyuKfNjaVy
         lLgg==
X-Gm-Message-State: AOJu0Yzoy/+2Lof8BSXH0Nd5dFjhQFrJ8NGKW5jDjHbgaeb5GILkeI8Q
	kJUwdmo7xEv3VQ4hTis0at4nIhTlNU3htKDwOZKhu7PCIILG83cQzT/ca1W4LA==
X-Gm-Gg: ASbGncsWAxtGRmdkTfUCBMQm1eUuUV+Fs4O84Bh0dkr/Nr/KvXEi3dZagS1Skwq3iUo
	igy8e2nJautLq3aL5NjZXMwMSxJMJ1QlUXEzSFWMvEKaFSI6tsdP/22yz8lhvZUa0d4draPnrle
	6FdPA0epytz4GgixnE+EzSyKRtPJtYsTMb4IqVw1rDxeZMNco3zEwzdMsFdAEksBv+RVXDlsjJh
	xdcdBPmcafgHETS6iVqwHIRNKMJ3dCbKEXUD+86B/EvKSvCnzhz00NRKPwvbW6x5npxE7ZEp0yz
	RYB3PitGuSdToZ6gjglqeXpYk6Cxmy90TaakHP0ugzY+4HQz3R+jF/zfz4DI75eJWI/y+eXSlr6
	8BUERFoZjTwBhPXiHNg0sZr/0RV+B3rP5N+c=
X-Google-Smtp-Source: AGHT+IGMiY8sOSCq62rCTP18oTMJnHp2WTHvUPx7nPIEy3xMPZ6uH26oWSLAh7tRk37/kX5eNkbJsQ==
X-Received: by 2002:a05:6000:2c10:b0:3b3:bd27:f2b0 with SMTP id ffacd0b85a97d-3b768f044dfmr3874921f8f.43.1753342038965;
        Thu, 24 Jul 2025 00:27:18 -0700 (PDT)
Received: from voyage.lan ([2a0d:3341:cd4f:d110:cf6f:2013:cd74:cf4e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad23bsm1231723f8f.44.2025.07.24.00.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 00:27:18 -0700 (PDT)
From: Marta Rybczynska <rybczynska@gmail.com>
X-Google-Original-From: Marta Rybczynska <marta.rybczynska@ygreky.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Subject: [PATCH 3/7] checksecurity: update the debian package
Date: Thu, 24 Jul 2025 09:25:45 +0200
Message-ID: <20250724072642.7358-4-marta.rybczynska@ygreky.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724072642.7358-1-marta.rybczynska@ygreky.com>
References: <20250724072642.7358-1-marta.rybczynska@ygreky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 24 Jul 2025 07:27:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1860

The previously used package (nmu1) is not longer available, use the latest current
one (nmu3). The changelog between the two:

checksecurity (2.0.16+nmu3) unstable; urgency=medium

  * Non-maintainer upload.
  * Fix "missing required debian/rules targets build-arch and/or build-
    indep": Add targets to debian/rules.
    (Closes: #999082)
  * Fix "Removal of obsolete debhelper compat 5 and 6 in bookworm":
    Bump to 7 in debian/{compat,control}.
    (Closes: #965448)
  * Fix some grave packaging errors:
    - move debhelper from Build-Depends-Indep to Build-Depends
    - remove temporary files debian/postrm.debhelper and debian/substvars from
      source package

 -- gregor herrmann <gregoa@debian.org>  Sun, 26 Dec 2021 01:56:10 +0100

checksecurity (2.0.16+nmu2) unstable; urgency=medium

  * Non maintainer upload by the Reproducible Builds team.
  * No source change upload to rebuild on buildd with .buildinfo files.

 -- Holger Levsen <holger@debian.org>  Fri, 01 Jan 2021 19:17:53 +0100

Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
---
 .../recipes-scanners/checksecurity/checksecurity_2.0.16.bb  | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecurity_2.0.16.bb b/dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecurity_2.0.16.bb
index 8dfb1cc..75e7783 100644
--- a/dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecurity_2.0.16.bb
+++ b/dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecurity_2.0.16.bb
@@ -4,13 +4,13 @@ SECTION = "security"
 LICENSE = "GPL-2.0-only"
 LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"
 
-SRC_URI = "http://ftp.de.debian.org/debian/pool/main/c/checksecurity/checksecurity_${PV}+nmu1.tar.gz \
+SRC_URI = "http://ftp.de.debian.org/debian/pool/main/c/checksecurity/checksecurity_${PV}+nmu3.tar.gz \
            file://check-setuid-use-more-portable-find-args.patch \
           "
 
-SRC_URI[sha256sum] = "9803b3760e9ec48e06ebaf48cec081db48c6fe72254a476224e4c5c55ed97fb0"
+SRC_URI[sha256sum] = "12b043dc7b38512cdf0735c7c147a4f9e60d83a397b5b8ec130c65ceddbe1a0c"
 
-S = "${UNPACKDIR}/checksecurity-${PV}+nmu1"
+S = "${UNPACKDIR}/checksecurity-${PV}+nmu3"
 
 # allow for anylocal, no need to patch
 LOGDIR = "/etc/checksecurity"
-- 
2.47.2


