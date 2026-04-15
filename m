Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307E8F428E6
	for <webhook@archiver.kernel.org>; Wed, 15 Apr 2026 20:19:52 +0000 (UTC)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4578.1776284389927750561
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 Apr 2026 13:19:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=QCj6VIxI;
 spf=pass (domain: konsulko.com, ip: 209.85.160.171, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50b3488fb31so88997391cf.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 15 Apr 2026 13:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1776284389; x=1776889189; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5SFYSrjEPY51IgVCd8Dn7uKGYNSz1YWsQ5MkW70FFw=;
        b=QCj6VIxIJdU1P6kZkbcZw2fvXXlbwcJoVRBZoGp8r5KSbRZODd0v0yStRYb/7nvMJP
         Y6uNEvopxTuE3Gx2s2uVZWNlzdvAkd6CeWUD4JPLMZXl2HK1d/Acnz543o26gs83VdKw
         OwjG0tuOD+SewzLskmeFJDUOnNolp+UXAYAPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776284389; x=1776889189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q5SFYSrjEPY51IgVCd8Dn7uKGYNSz1YWsQ5MkW70FFw=;
        b=PIvDADJqXF0OZMSXOqtnaa8bydPtopOKdZfZeqMitW10bWGDUcbRah04w13ingIGxq
         EeHVEUiy6+J74rebjbUPRqKunPZQ1fz9Rh/0mhlrXzazSb0POVQWTe2Tt1AUabzIhrrb
         RSVG46jcp8z7WSUa8sM7D+4+thzB7IsoKcBgtmX6IbIssA3/tO7m9V/8UjCMorIY2GSX
         KsDqcJ/3CtcBq4Rwi3JV+Am2R+sMxuogrrHYxv1uw2CVml2ZPTlPS3cMKU0iOigMHS8O
         30DxVH55LCtDPSyg6xhrYe1B47ouK8wHStVjy1cE+k9GBreroJziPxtoV9sM+m34r8ro
         keag==
X-Gm-Message-State: AOJu0YwIAHDI0MzWjjkmvXaJzH6awtkQHF99BjVrR+BWed0iiiQENoyV
	agkXWmJPwbdhojqN9bO0yrQJV2+b70EVmEB5AhfGkafckt0WvKkVQ27mPWhciQFg1c1AWIDI1hf
	aMMel
X-Gm-Gg: AeBDieuor2TJZ1I/+hpA37u49k+ootv6KHQQdIJ5jC2p/3GpJMeLL4H4nNmfLa4o7Gu
	qtgv5gyU8bvk7BOfiBep5PfZwaJ3QHRkHnBZYTVqGDfOKwLfk+dmJ6SK940oeCGi3deSseoQt28
	awoYIdaIH9BoZU9cge/eZ4+Tye21uSLeHY90tZqWAZ19gwETWuX8YekaPolYCaNDW9IwxfWOMur
	9ajAI6m703sFaMMVToC4AW9ek28tXgagfLGLsHXUaHdrKz0uIBeHRovEzuMp5zc9wCPaT923Wi5
	NgccvhueCM2iiu3NA9aYVl3N+/+s62BRxHBpIcd9WF3FBQRfFDKP1jWqCx/C2mgL9T3wXeVSGPn
	kmwzOKayx/wBxhf9XwsBdGR72C5TgQw5fg15s9TKbMA5hUBHC9QVJTWNTgp818UWqbYNWw0ocDD
	h0FTV0FHcYVgbuVWzra6qaSaLWnjN2zKGb/ZQlgu0LIQtYW3lsQEjHiJzPOHRHfLqCJ+D0/SIVm
	9NjeEU/a218485YCkCQM1wIr89z2x2fY09Ylp8r+ATuFtkKV+hCvRm7wlAaMgQS
X-Received: by 2002:a05:622a:190e:b0:50b:6d63:6a2b with SMTP id d75a77b69052e-50e24abddb2mr16783341cf.2.1776284388599;
        Wed, 15 Apr 2026 13:19:48 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6ceb80f6sm18569376d6.46.2026.04.15.13.19.48
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 13:19:48 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 6/7] meta-security: fix incorrect HOMEPAGE variable names
Date: Wed, 15 Apr 2026 16:19:26 -0400
Message-ID: <c3ddb212cf514b20317598d657d691779a3d4b78.1776283733.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1776283733.git.scott.murray@konsulko.com>
References: <cover.1776283733.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 15 Apr 2026 20:19:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3714

From: Zhang Peng <peng.zhang1.cn@windriver.com>

Several recipes used non-standard variable names for the homepage
URL (HOME_PAGE, HOME_URL, HOMEDIR) which are not recognized by
bitbake. Rename them all to the correct HOMEPAGE variable.

Affected recipes:
- glome: HOME_PAGE -> HOMEPAGE
- google-authenticator-libpam: HOME_PAGE -> HOMEPAGE
- arpwatch: HOME_PAGE -> HOMEPAGE
- openscap: HOME_URL -> HOMEPAGE
- scap-security-guide: HOME_URL -> HOMEPAGE
- lynis: HOMEDIR -> HOMEPAGE

Signed-off-by: Zhang Peng <peng.zhang1.cn@windriver.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-compliance/lynis/lynis_3.1.6.bb                         | 2 +-
 recipes-compliance/openscap/openscap_1.4.3.bb                   | 2 +-
 .../scap-security-guide/scap-security-guide_0.1.80.bb           | 2 +-
 recipes-scanners/arpwatch/arpwatch_3.3.bb                       | 2 +-
 recipes-security/glome/glome_git.bb                             | 2 +-
 .../google-authenticator-libpam_1.09.bb                         | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/recipes-compliance/lynis/lynis_3.1.6.bb b/recipes-compliance/lynis/lynis_3.1.6.bb
index 722072f..0b81ea9 100644
--- a/recipes-compliance/lynis/lynis_3.1.6.bb
+++ b/recipes-compliance/lynis/lynis_3.1.6.bb
@@ -2,7 +2,7 @@
 # Released under the MIT license (see COPYING.MIT for the terms)
 
 SUMMARY = "Lynis is a free and open source security and auditing tool."
-HOMEDIR = "https://cisofy.com/lynis/"
+HOMEPAGE = "https://cisofy.com/lynis/"
 LICENSE = "GPL-3.0-only"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=3edd6782854304fd11da4975ab9799c1"
 
diff --git a/recipes-compliance/openscap/openscap_1.4.3.bb b/recipes-compliance/openscap/openscap_1.4.3.bb
index e1cb295..1b6d9af 100644
--- a/recipes-compliance/openscap/openscap_1.4.3.bb
+++ b/recipes-compliance/openscap/openscap_1.4.3.bb
@@ -2,7 +2,7 @@
 # Released under the MIT license (see COPYING.MIT for the terms)
 
 SUMMARY = "NIST Certified SCAP 1.2 toolkit"
-HOME_URL = "https://www.open-scap.org/tools/openscap-base/"
+HOMEPAGE = "https://www.open-scap.org/tools/openscap-base/"
 LIC_FILES_CHKSUM = "file://COPYING;md5=fbc093901857fcd118f065f900982c24"
 LICENSE = "LGPL-2.1-only"
 
diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.80.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.80.bb
index ab495db..3777e36 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.80.bb
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.80.bb
@@ -2,7 +2,7 @@
 # Released under the MIT license (see COPYING.MIT for the terms)
 
 SUMARRY = "SCAP content for various platforms, upstream version"
-HOME_URL = "https://www.open-scap.org/security-policies/scap-security-guide/"
+HOMEPAGE = "https://www.open-scap.org/security-policies/scap-security-guide/"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=9bfa86579213cb4c6adaffface6b2820"
 LICENSE = "BSD-3-Clause"
 
diff --git a/recipes-scanners/arpwatch/arpwatch_3.3.bb b/recipes-scanners/arpwatch/arpwatch_3.3.bb
index 84f93da..3ab5993 100644
--- a/recipes-scanners/arpwatch/arpwatch_3.3.bb
+++ b/recipes-scanners/arpwatch/arpwatch_3.3.bb
@@ -1,6 +1,6 @@
 SUMARRY = "The ethernet monitor program; for keeping track of ethernet/ip address pairings"
 LICENSE = "BSD-4-Clause"
-HOME_PAGE = "http://ee.lbl.gov/"
+HOMEPAGE = "http://ee.lbl.gov/"
 LIC_FILES_CHKSUM = "file://configure;md5=0f6cca2f69f384a14e2f5803210ca92e"
 
 DEPENDS += "libpcap"
diff --git a/recipes-security/glome/glome_git.bb b/recipes-security/glome/glome_git.bb
index 5a0300f..68f2132 100644
--- a/recipes-security/glome/glome_git.bb
+++ b/recipes-security/glome/glome_git.bb
@@ -1,5 +1,5 @@
 SUMMARY = "GLOME Login Client"
-HOME_PAGE = "https://github.com/google/glome"
+HOMEPAGE = "https://github.com/google/glome"
 DESCRIPTION = "GLOME is used to authorize serial console access to Linux machines"
 PV = "0.1+git${SRCPV}"
 
diff --git a/recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.09.bb b/recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.09.bb
index 60f2c9e..333caab 100644
--- a/recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.09.bb
+++ b/recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.09.bb
@@ -1,5 +1,5 @@
 SUMMARY = "Google Authenticator PAM module"
-HOME_PAGE = "https://github.com/google/google-authenticator-libpam"
+HOMEPAGE = "https://github.com/google/google-authenticator-libpam"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"
 LICENSE = "Apache-2.0"
 
-- 
2.53.0


