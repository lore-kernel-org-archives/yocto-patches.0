Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A23ECFD341
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 23:45:33 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4860.1763941524418046960
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 23 Nov 2025 15:45:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=f1QDR6dY;
 spf=pass (domain: konsulko.com, ip: 209.85.222.179, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b21fc25ae1so365865185a.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 15:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763941523; x=1764546323; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iDlRUT895lVTddNYJvY1VS9HL4hMYqiOFtMWemS66+k=;
        b=f1QDR6dY/z5Pul6lWOaPIuK6dUCmVWMBrg7q6oLRDcH7QOk489Diycdsed4l9p7m7q
         T9SALuqoCwwa3EY/8CwsJJyZ50EDdBGhkyv5ap8CXIwLYoSyBZzxhKYu2E7u+2en3+T/
         qk7k52z/zJ/FEcFOnI4pPddPkk+zfAQ1e8s/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763941523; x=1764546323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iDlRUT895lVTddNYJvY1VS9HL4hMYqiOFtMWemS66+k=;
        b=E8u3/6dr3ZKSgOSOHWNU5VGzeDSrBdi33n4YjkyrPvw4h3jyjEjGG4RZjySRgZ1aFc
         FwynBidYW8ncnr3TmfBLBUcp06LD5eYS2rc6GTm+DcDRchgUFkby5awc7T2+pMqSnsUk
         smvqHFFIVKkg/UPBI04s+qxN9EgbPM7Yd9jP+MSzAzY1j0w5mm19DRudeLJ1ffC26I9i
         TjRUj1ysFGuf92fYKzMykiI2a+6xaT3mwFDoKKTbl9LTZL47hECZ/Oam30ELCycb2g5P
         Z/+6s22gfgieR8vtrB2+VVD+KFyZs9y0b4fQsAQFR+xettosDLk+4shf7RqsitBBntk0
         WarQ==
X-Gm-Message-State: AOJu0YzPaZOzwO0Jz77E1thnWvvrEGb3Mf+DataQA7MamtfHECBEZYX1
	ar8DaZhwpVH3XVzRA/DYarZY/ndUPNMVjbgNAmjIm0K60c09nxrcJ/vZs5FGFiDbesPuMWv5SxT
	HT94c
X-Gm-Gg: ASbGncuktZgG6ksh5jyiQjHBeUBOpmCIZQ/RYGTjoR5Ctit3ezeZ/9te33CSDv7kp9X
	XBYas53E7ouYJ7Y5I9bwJxbIk/2qOd3paaIfqELS8y8uT0CO93DjM68Z2QANY9U7wOC7bbYbntS
	uFlEZ1bNWe1be5UIQKi+kD6awaZR16oAQAoQrG5DvwaVPRLb4F+0lkUFK/E6zdHRznBH2lLkd86
	zUcUzhHK2Y86i+PHhmB9RK8f9l3OIYEmf1SJeuEpNVL7ZyhQ0dNDAxmMpGHr/3GVDaU5wT0abzG
	O8WzY2ikc3TGdzdRGEolz4NZT8l1UCntdhnmvby/T0fTDLbF0q0Smf2Jr6UPUTOcQhEf1RouB3Z
	Xt+GkD1Vu7WrjrgYixfsbX2nxY/q/UiLB+l/UiVD0u/mIF00gMlLRE1izC8wQmQpMI9kWBaSvdq
	MwEwcX0vSpO6gZcAYABrNmwOQ2iMEfZkOuN4Nrhq3a6/dHJ+PIfQiWth58WRJfTEk=
X-Google-Smtp-Source: AGHT+IGsGLQmT/fqz4ZdhoqeXBIAD0kFflNjnloNzk4kAXywALv6EyLOZQo0Dddm4CmrrnEu6S8G/g==
X-Received: by 2002:a05:620a:31a3:b0:8b2:e638:7dc8 with SMTP id af79cd13be357-8b33d1fe720mr1199680685a.31.1763941523091;
        Sun, 23 Nov 2025 15:45:23 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932db59sm843706585a.1.2025.11.23.15.45.22
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:45:22 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][scarthgap][PATCH 07/32] checksecurity: update the debian package
Date: Sun, 23 Nov 2025 18:44:47 -0500
Message-ID: <5f791761ffb9414966959335ec68aa4bf13d65b1.1763938436.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763938436.git.scott.murray@konsulko.com>
References: <cover.1763938436.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 23:45:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2665

From: Marta Rybczynska <marta.rybczynska@ygreky.com>

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
(adapted from 828a78314f51b919baf638d64e8e12c0c0a408ad)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../recipes-scanners/checksecurity/checksecurity_2.0.16.bb | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecurity_2.0.16.bb b/dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecurity_2.0.16.bb
index 8006c9f..6a223f8 100644
--- a/dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecurity_2.0.16.bb
+++ b/dynamic-layers/meta-perl/recipes-scanners/checksecurity/checksecurity_2.0.16.bb
@@ -4,14 +4,13 @@ SECTION = "security"
 LICENSE = "GPL-2.0-only"
 LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"
 
-SRC_URI = "http://ftp.de.debian.org/debian/pool/main/c/checksecurity/checksecurity_${PV}+nmu1.tar.gz \
+SRC_URI = "http://ftp.de.debian.org/debian/pool/main/c/checksecurity/checksecurity_${PV}+nmu3.tar.gz \
            file://check-setuid-use-more-portable-find-args.patch \
           "
 
-SRC_URI[sha256sum] = "9803b3760e9ec48e06ebaf48cec081db48c6fe72254a476224e4c5c55ed97fb0"
-
-S = "${WORKDIR}/checksecurity-${PV}+nmu1"
+SRC_URI[sha256sum] = "12b043dc7b38512cdf0735c7c147a4f9e60d83a397b5b8ec130c65ceddbe1a0c"
 
+S = "${WORKDIR}/checksecurity-${PV}+nmu3"
 
 # allow for anylocal, no need to patch
 LOGDIR="/etc/checksecurity"
-- 
2.47.3


