Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19442C54F54
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:34 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4595.1785497612579084298
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=X6lI2Eu6;
 spf=pass (domain: konsulko.com, ip: 209.85.222.169, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e5cb052edso65838585a.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497611; x=1786102411; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JPOMLrotMJeo3L318RlZLmZ1U2ym0INUqvAmizM9iqg=;
        b=X6lI2Eu6W4yBLKcG3x6SMFlldBMlz9eHZclppqtUK3eU8c+a6tVxQHc4JoVBp4DpM5
         +jPpy8X/sc2nkLAZU3+EZVHJj0n3Hkh25iyFTMlTHHDpPvspOGVBH4A/GiHHaRHpmPoz
         5RHZEJgs4luEesRkVz2VgSB7CdaSRz1YKo5lU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497611; x=1786102411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=JPOMLrotMJeo3L318RlZLmZ1U2ym0INUqvAmizM9iqg=;
        b=MYqMKzwBikFkWbWlhOz4IzI+IomHSjcF9zDOs06rhhfEB7hcSZu7TCPX45nAqoCjAX
         dMt49wLR/bEniJ5MA3XvOAgg+apQcci/Q5n02SZ74tJSitCpeYeMlss7nAS6rmqp4yiF
         5O/Dao8IGDZ0YleOY3nBDHASkO6WFIMVlllBRNq0N+OJCfzkHhFsqr+1537rRYHeuhCK
         ESImWGE+D3fRGtSB8RV480+KO78mjQd5l8ZjEKrJEQHom1SqlGyvCVTZczYfoYHk1KMN
         pAs6ne9WHScGiZI4WbtLEN0jK5/HfaViMEqRAH0devP54qypWGr9QDwowyFiOMmhPEfN
         N6cw==
X-Gm-Message-State: AOJu0YzEI+Hj2gTh6YorimmkvJ+g7aWqfftyeP3b0jPMsE96FqU86VNr
	qB3aJIqwJpghQyyoqx2hD6TgE749DLJkdrdFEoYH1P6hkrMMk1N9ILNShnW5UaWhTy4uCSaRbK5
	Ycwkw
X-Gm-Gg: AR+sD10Ugw/cty2OyOWPZrQFJDBC89+Ls0hDcvcY3zLTBZLUUK3j4uAFDxavSjAI4zG
	ZcSzvE80Js7EBqaPHPuCrUud4r97GB2SmG3GTcA2dnPnnFW7jjBFT9wNgdFJsv2xWKrOy/vJZn4
	uiMlbgx7+hiGq/uZAJ9XlELeuoaaQfBl89sipItNwqUTzZKcpBTyQmwIG3Cb3yTXXNs9d6jXxte
	vnZfChPe9D3nRvhxy5sAAcmjS7kkugAygsZQw7Vz82bKTewfOg24vJ0Nl9WZ13aKhncUfR+VnqP
	sQMut3TCYHeEzT1kdLIW0T6RMqz93kPVMevKzriWKzu8waCOKpgwoaFvpHS+CYkue6xtYF5Rm0M
	G+f6CtHnSzYx3uu1L7apZ2DHhRpGM7PW8rJu9d3mzl5lduhIIy4857+nyYJsOJFyH/Hivrv2au+
	3xc5Y18lo8SELLgf9hrWCOslc/PK0+Gg6LEzWjmmRxIT4FlsqQPM/EfeDGOSZM9SHUZpmCkkNy3
	AQcwNPAEiB9mR5U6d3/wc8zcCMe4u1YyB8NfRyGKxB3wvD7TCd+etREwPg5SNQIxGOFsDOQV9cW
	8pinlU5UqfKMhyoUA6r6v1+I/A==
X-Received: by 2002:a05:620a:c4a:b0:92e:5444:9274 with SMTP id af79cd13be357-93496833eddmr205794985a.30.1785497611261;
        Fri, 31 Jul 2026 04:33:31 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.30
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:31 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 18/35] librsvg: remove obsolete .la deletion
Date: Fri, 31 Jul 2026 07:32:48 -0400
Message-ID: <f51397584cf7ff6be559f4012ab4d451212b86e7.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785496469.git.scott.murray@konsulko.com>
References: <cover.1785496469.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4594

From: Ross Burton <ross.burton@arm.com>

librsvg is built with Meson now, so there's no need to delete .a or .la
files that don't exist.

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 25b1f198ea69c7f1c08cd0638f322edf4121c199)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-gnome/librsvg/librsvg_2.61.3.bb | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/recipes-gnome/librsvg/librsvg_2.61.3.bb b/recipes-gnome/librsvg/librsvg_2.61.3.bb
index 419d5cc..06f08ba 100644
--- a/recipes-gnome/librsvg/librsvg_2.61.3.bb
+++ b/recipes-gnome/librsvg/librsvg_2.61.3.bb
@@ -68,11 +68,6 @@ PACKAGECONFIG[gdkpixbuf] = "-Dpixbuf-loader=enabled,-Dpixbuf-loader=disabled,gdk
 PACKAGECONFIG[vala] = "-Dvala=enabled,-Dvala=disabled"
 PACKAGECONFIG[apitest] = "-Dtests=true,-Dtests=false"
 
-do_install:append() {
-	# Loadable modules don't need .a or .la on Linux
-	rm -f ${D}${libdir}/gdk-pixbuf-2.0/*/loaders/*.a ${D}${libdir}/gdk-pixbuf-2.0/*/loaders/*.la
-}
-
 do_compile_ptest_cargo:prepend() {
     # The packageconfig is for meson, but the rust tests are compiled directly with cargo,
     # so these arguments don't apply. Note that this is Python, the intendation is intentional.
-- 
2.55.0


