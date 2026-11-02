Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4440.1793659690619097514
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 02 Nov 2026 14:48:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Io+45+iq;
 spf=pass (domain: konsulko.com, ip: 209.85.221.44, mailfrom: scott.murray@konsulko.com)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e10a70540so1963118f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 02 Nov 2026 14:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1793659689; x=1794264489; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Rv1qFGPZTU5xjeLXptQVkNzLBOBWTm5zrEfl5xjrwMo=;
        b=Io+45+iqIzAogpn8jmzQbJyADKhhr4av4JBQjoUjGliYPS2HZ7h/tzRwNzEKh8ijHf
         BGQmDjS9EnznX6q7EIPLsFdqeDTDs7/vYZjJV88hQAV8IojH7kna+jZsy79oweHBe05w
         B+oZpYV6jiQ9gqp1/N2YohoA80kwchwQT0CBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793659689; x=1794264489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Rv1qFGPZTU5xjeLXptQVkNzLBOBWTm5zrEfl5xjrwMo=;
        b=LWgG40ivmt+DZJs7Rc3fyk9gEcVcCTCIvN0D9POTpRZgZ6+xgjre8uo52ijQXqPRre
         IVDpwJizH0ecpdF4Ydngp0NYmx6SvVc4rhNsq68g4k8gU9oeMhp1xD1zfWvmT4kcWsJ4
         KaHEBv2F+au1bc7zV91+0a15uUbz79A0N5ShcmNDcgQG3XVQezBA751lb5SOgigVXjsz
         AXRwuiXjFdecFFOUAe3b0nVGMd0KrZUhkhw08XMNS+AOi+ljF31jPa02Ru+TZ+JHBzBu
         ZIb1zs0ae6OlwfAGcAtY6tEwsNIVJHu2DQWNBN54AvPZpWC8HUSFeWLJmXGoHbqHJpTI
         BXig==
X-Gm-Message-State: APuU4Z9z+An3LnM3AnjyRt6AdPubAR9OqBmzTpTwft3SdoHmLb2R26Sg
	3mqAJGGNE9TIdl3nY3Z2SMddFHc9kZm0xNszSz4LAzqeRMAVTxtVcNpub2zOHZ3iluRe6SAErmn
	64W+TEj4=
X-Gm-Gg: AYBFou3vyoUOGa/kMKw4WX2VY4kyOszgf5oOEGRLNJD32pWaehznM4zE4932pE5WgEa
	dh2hThFN6iqW22Tc7u0pR/JE8rOHiPEcHWS2RaTSojQ/DCQEXtvVbEU6KSoFhio6+mncH8qRy2E
	odd+xMX6U025CObyS2USFdpt1Cq+yeziH3pysPwCZcUhErLLj3QdFITwx56zXrN1gVhhsodRx9P
	z5p0s9OxOKAk+G4s8ozl4yD55UBvyj/QoQEmg5jxXWvGNJvsZWXL4Ht88vDKO4loqjO2V7gkSgL
	ftBUStDMM0oIT9xvNtK9IpUk1AVX1ZvsjfJnHPvUx4vyTn+xyYZzydF6tuyqnIy5APltEQ5gDgL
	G8IN9HQZtA8ncNDkswXwfqedGX0VpGKUylUkDU8sP49JW5R/hAUCLur5eKYv/FpIT66EW1c+356
	yXUNnEi2POJFxWYaeDVhd7C2l9dDlZ9WHWpvOqF20EMbdyGxfJNcNaGJh4Lm7TpGsmn7dthXebL
	Uyiue9GWxKJhavIM4kuNBgUc+FB0Sw9YPUlQqVbj+5pP1ocR5mIx/kYjLDhlB382LKS2JQmKq4y
	u+JLCx/sPt1o46ICljKjcg/+FYYrUK3fNmYF0k1hg8cEcASsYqWkQOtgQwcdJ4zOrQyTTrHNQ8h
	lOuF24tukLjU5JOp3h+7yLORkZ1tJC7w=
X-Received: by 2002:a05:6000:46da:b0:48c:43a3:6a74 with SMTP id ffacd0b85a97d-48e6e2f65c1mr18989143f8f.12.1793659688706;
        Mon, 02 Nov 2026 14:48:08 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71ba7168sm23770828f8f.55.2026.11.02.14.48.07
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:48:07 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 3/4] tpm2-tss: update to 4.2.0
Date: Tue,  3 Nov 2026 00:47:47 +0200
Message-ID: <70d559289d526f5243aaab79df5ae2e268738f5e.1793659376.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1793659376.git.scott.murray@konsulko.com>
References: <cover.1793659376.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 02 Nov 2026 22:48:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5211
Content-Type: text/plain; charset="utf-8"

From: Leonard Anderweit <L.Anderweit@phytec.de>

Update to version 4.2.0 and rebase the patch accordingly.
Also, remove the CVE_STATUS for CVE-2024-29040 because it is now
properly detected as fixed.

Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../tpm2-tss/tpm2-tss/fixup_hosttools.patch         | 13 +++++++------
 .../{tpm2-tss_4.1.3.bb => tpm2-tss_4.2.0.bb}        |  4 +---
 2 files changed, 8 insertions(+), 9 deletions(-)
 rename meta-tpm/recipes-tpm2/tpm2-tss/{tpm2-tss_4.1.3.bb => tpm2-tss_4.2.0.bb} (94%)

diff --git a/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss/fixup_hosttools.patch b/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss/fixup_hosttools.patch
index 8822d1b..798a0c7 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss/fixup_hosttools.patch
+++ b/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss/fixup_hosttools.patch
@@ -1,4 +1,4 @@
-From ab120a9642516cdfdae5c5b8a91e42e2c9898172 Mon Sep 17 00:00:00 2001
+From 8913c8c4b207ae6dfd3ae58d886e2074d53cc268 Mon Sep 17 00:00:00 2001
 From: Valentin Kunin <kunin@google.com>
 Date: Mon, 20 May 2024 21:09:27 +0000
 Subject: [PATCH] revert configure: add checks for all tools used by make
@@ -15,10 +15,10 @@ Signed-off-by: Valentin Kunin <kunin@google.com>
  1 file changed, 11 deletions(-)
 
 diff --git a/configure.ac b/configure.ac
-index eb6051ea..a52c4725 100644
+index 4a1f1b022772..5a745e9c5c22 100644
 --- a/configure.ac
 +++ b/configure.ac
-@@ -663,17 +663,6 @@ AM_CONDITIONAL([SYSD_SYSUSERS], [test "x$systemd_sysusers" = "xyes" && test "x$s
+@@ -658,17 +658,6 @@ AM_CONDITIONAL([SYSD_SYSUSERS], [test "x$systemd_sysusers" = "xyes" && test "x$s
  AC_CHECK_PROG(systemd_tmpfiles, systemd-tmpfiles, yes)
  AM_CONDITIONAL([SYSD_TMPFILES], [test "x$systemd_tmpfiles" = "xyes" && test "x$tmpfilesdir" != "xno"])
  
@@ -29,12 +29,13 @@ index eb6051ea..a52c4725 100644
 -      AC_CHECK_PROG(adduser, adduser, yes)
 -      AC_CHECK_PROG(addgroup, addgroup, yes)
 -      AS_IF([test "x$addgroup" != "xyes" && test "x$groupadd" != "xyes" ],
--         [AC_MSG_ERROR([addgroup or groupadd are needed.])])
+-         [AC_MSG_WARN([addgroup or groupadd are needed for install.])])
 -      AS_IF([test "x$adduser" != "xyes" && test "x$useradd" != "xyes" ],
--         [AC_MSG_ERROR([adduser or useradd are needed.])])])
+-         [AC_MSG_WARN([adduser or useradd are needed for install.])])])
 -
  AC_SUBST([PATH])
  
  dnl --------- Doxy Gen -----------------------
 -- 
-2.45.0.rc1.225.g2a3ae87e7f-goog
+2.43.0
+
diff --git a/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb b/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.2.0.bb
similarity index 94%
rename from meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb
rename to meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.2.0.bb
index 30e984e..0d5b36a 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.2.0.bb
@@ -11,7 +11,7 @@ SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN
            file://fixup_hosttools.patch \
            "
 
-SRC_URI[sha256sum] = "37f1580200ab78305d1fc872d89241aaee0c93cbe85bc559bf332737a60d3be8"
+SRC_URI[sha256sum] = "b53f0c5c8c4ce17f05701a410ca9688f725ca380c9bc4640eacd0eadb1fea124"
 
 UPSTREAM_CHECK_URI = "https://github.com/tpm2-software/${BPN}/releases"
 
@@ -94,5 +94,3 @@ FILES:${PN} = "\
     ${sysconfdir}/sysusers.d"
 
 BBCLASSEXTEND = "native nativesdk"
-
-CVE_STATUS[CVE-2024-29040] = "fixed-version: Fixed since version 4.1.0"
-- 
2.47.3

