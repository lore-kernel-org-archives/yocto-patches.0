Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3F2C88E5A
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:14:03 +0000 (UTC)
Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48531.1789157642359322328
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:14:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=FI3hkvzl;
 spf=pass (domain: konsulko.com, ip: 74.125.230.205, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb76ef1d1so3376421cf.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157641; x=1789762441; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DFqzv02veR/koBIH/CNrnQ+rjuZxMth2zULaKdsMuag=;
        b=FI3hkvzl/TlSoz9I7t791jMcERf9Niq/nKh/qrwgBEJ1+2ZGdMuO8P7+gQoPWrYP0/
         EjIcS/hGtgGh12upTldxxTaGpGInUmuVHnqBy4hgCWB9aNYSA0rLmdWFhaD4nC/BVH46
         Z3pNifNJGVxBtOCR20G1BDiULxeZhrCt7+Gsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157641; x=1789762441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DFqzv02veR/koBIH/CNrnQ+rjuZxMth2zULaKdsMuag=;
        b=XrrnPx3cJRHul86VzcS4KfZ97C0R63OrsvEu8p97uJbKTDpk3ZoAk3g16nOiob5wCq
         TwFvq0HDsKTAoCCBJuh0JpphxsyPQ6Lup20AyFdokteNqbsHtb6dG5d9k8wQ2b/5fOwK
         xBhawXpjvk756sD5yCjhqxNQYsbLZ59pJNrF4m6h3fWxDuZluH/sal1y+9O9IsctyIcW
         pr22FcRmhU74YsUTrmphj9I85w3qWZrvb8EVX3AZQuwrOtpLRbns3sLshxCU+ynYKv5/
         XqPhylvgTbhlI8q/QhyG5Xy4G5NdqFF45BqzFzdq+Oyjf8BCf19fKBIKq0UrliuQ4w7a
         3+AA==
X-Gm-Message-State: AFuF++l3TovGn+ULxVMBLaGZt6ndlf4wfvX6QhzjVmt2KFz8LWEMQzyR
	gDErpjS6/KCEePJtPD14z78dU83C6uliwq/QDywlGPsFVe3VgxIAUjWHLGZo7SO2a5xYvF71gzu
	Fmw8O
X-Gm-Gg: AYBFou0NbrTzAzCf7J6QRefrZGbE7MMGti1Vg8Z78wK+R0f9lV2MGU11f7nnZjXjuDH
	06A9bOAD3sW/Y4Sms5np8hurUGbfLeAAUBIw7c798u2toQ1gX++G8/QqLuBzGxYsPMxVF5ap+8b
	B4/BYuRGaAtZXU/jsc/UqQrdqevpqO7Du+Mjwg8Ua1k0q7Ut2G6nlqfwFbcqbvGt10RBl6BshiZ
	yeCJ+F2CNE6EGvUqbuQM4GVTn77xHDxsKUMehSoNRfAasm1emn1u+HV+AZIwlXHSjWq+Lg1BQrz
	Sq+RZ0U3GraRi0CzD/vgYjd3sb36RDwFlJAW8tiGRWKDDVFbHz1lK2JBplLSUeTx5pOiPChQskK
	aNw1B4dKzDY61FKGEXFjRlgiChsmiaB3OjFgZR1r5aCB4HzN/6nyUNutN+8NZljMHIy1kf0AVNC
	DjkjbEdTYNZ+6b0OigaQNqfB2BaX/i9XX5nO1Teit4yb9i8rBO0NFRQJ8VDtXtO4RS79rCZr2lK
	v3CBGWUTQ4JPpzVNDvqnxyOod6ZlrTGCgqpy3ioDZC10E+2bsnI4cBlcU90TXYzyNgFqHOdZeOY
	/Y6KQ2wZeRZS5qW04JQjQK/GhxkMsUIWWSU=
X-Received: by 2002:ac8:7d44:0:b0:51c:2135:b00a with SMTP id d75a77b69052e-530c872b8b6mr88180871cf.40.1789157641024;
        Fri, 11 Sep 2026 13:14:01 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530cc781402sm25826061cf.7.2026.09.11.13.14.00
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:14:00 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 24/37] classes/cargo-c: pass flags via CARGO_BUILD_FLAGS
Date: Fri, 11 Sep 2026 16:13:10 -0400
Message-ID: <09042a422364e3eef9e1b3edea7da48e1b0ea0c0.1789156653.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789156653.git.scott.murray@konsulko.com>
References: <cover.1789156653.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:14:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4790

From: Ross Burton <ross.burton@arm.com>

We need to pass the same flags to cbuild and cinstall, as otherwise it
will build in do_compile and then rebuild with the right paths in
do_install.

Add the flags to CARGO_BUILD_FLAGS so that they get used in all calls
and do_install no longer does any building. Example from buildstats:

PKG                        TASK        ABSDIFF  RELDIFF  WALLTIME1 -> WALLTIME2
gstreamer1.0-plugins-rs    do_install  -263.6s   -99.0%     266.2s -> 2.7s

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 9079283776997287d455ef32696895d756bc37b3)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/cargo_c.bbclass | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/classes-recipe/cargo_c.bbclass b/classes-recipe/cargo_c.bbclass
index e68ac93..cd486b2 100644
--- a/classes-recipe/cargo_c.bbclass
+++ b/classes-recipe/cargo_c.bbclass
@@ -16,6 +16,13 @@ BASEDEPENDS:append = " cargo-c-native"
 
 B = "${WORKDIR}/build"
 
+CARGO_BUILD_FLAGS += "\
+    --destdir ${D} \
+    --prefix ${prefix} \
+    --libdir ${libdir} \
+    --library-type cdylib \
+    "
+
 do_compile[progress] = "outof:\s+(\d+)/(\d+)"
 cargo_c_do_compile() {
     oe_cargo_fix_env
@@ -27,11 +34,7 @@ cargo_c_do_compile() {
 cargo_c_do_install() {
     oe_cargo_fix_env
     export RUSTFLAGS="${RUSTFLAGS}"
-    cargo-cinstall cinstall ${CARGO_BUILD_FLAGS} \
-        --destdir ${D} \
-        --prefix ${prefix} \
-        --libdir ${libdir} \
-        --library-type cdylib
+    cargo-cinstall cinstall ${CARGO_BUILD_FLAGS}
 }
 
 EXPORT_FUNCTIONS do_compile do_install
-- 
2.55.0


