Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42243C55172
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:45 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4475.1785497616554478146
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=dihuS243;
 spf=pass (domain: konsulko.com, ip: 209.85.222.179, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e65e18969so45427785a.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497615; x=1786102415; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dSUnVVy/WXv7tdoU4z/C4VIZgCLOO+1/0CdqwE9S8Es=;
        b=dihuS2439gDQlUkLkXm1vMWYUGxcYC3dQnCm+FfDB3rPA3eId40Ohkg94UPy2FJbrm
         DX5ua9G9nkhzrdFLZN5fC4pF+daYueASKfIbojbmrilB4Hvw7mE3hKV30aCLTy59dkhZ
         LroyHUONrvzG+p989hRDMREaMNSTlXYq9Pdk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497615; x=1786102415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=dSUnVVy/WXv7tdoU4z/C4VIZgCLOO+1/0CdqwE9S8Es=;
        b=TpOD00fPNBqrt6feqLQWadhguu60389HJgRZsB/+jJNIadEQmapjuZyV41TOAnTGaz
         AQ0oUrA+3XV0K8+0UiN/xEbwJ7Tw+bkO55jxkOS461slx7vhGP+5fAOPmE4tFJZzv0u5
         ju3rSsvlOuC3ix8fmxEjzfK6w0PgMjTYXWWbgqJfIFUw8nIRzJQKqhNz+kilFeNoNWEV
         1KMFzq2uMJoOJ/vtURO399ECuigurbrzYYD19QI1YJq0YxhXtgsjFnS1kIDHXZXDy/uJ
         FImJNa2mPFZ9jq4tAc9GI7E1gnYq9LT1TMiaH5HIbV8jQwASC6Rfbu6W2WWNcixk0YYH
         UGiQ==
X-Gm-Message-State: AOJu0Ywk0ogBHdiAGwE+wFNgvhym+K6uNbl0Q6pwtKAqshb7vBAgcvpW
	49ZFVHGmlwtGAWoOiw2e+5i7eNJ3g0OItis/PYAh8Mu794pvC+kMEYr2obGjlRmqoEjJ0THi/Mp
	D4dXS
X-Gm-Gg: AR+sD10hlYh6j7NxUYHu8uXWwJ90y4T3SUsZ0D7F0U5JHi/FVMnuILpjFfMDjymnlJw
	WI9Wp6RkqY74ukbSWA1w2NU50Uf3cZngXre4mDseaYUqNYalogb6y6G+E4dGkS74euamMstmH/o
	IrEF0JTN0oRIxjxmbzPyP6PRik/xTzZUm2KIAOgqzA6D3OHtxgOK7rpexRtgxCKuysyHBI+Il92
	Fy/eNerDPEueV/QWe+OY3dtc+J2Oxz6l1rt1nSiyh06Z3WXpzKfLNHW9kCeGLDGLXIGzKJXNjT0
	iGucXWxrOGzzejeHZf2N8gZX6RYAvvlIeO406HIakJvEHk4QbGbauCGwps3EN8XiTPYRdfVXdsg
	LDRbw6pU+SlaDPeB0XB0FxED6es65WhTmPFv7gMDcpz+tCVrvz8W4xrJHn8KQcYgpUS8mPMIz0g
	bvUkZpPZgup1QtqLTrhrigox9RyqjjWnNBpQwGRXKDXFK3Uk1gOlO6kI5ZMWCK0DnrVyFcWNCFB
	CSmnwBVlb+MBQTnBRWUkQ4Li8nm212ByRQBfEI9po1EKsxZUsL4RjelfUFSyRG5toyG7dtcsXjJ
	f502fnoRWsonw8MGnuu5ABIuyg==
X-Received: by 2002:a05:620a:72c9:20b0:929:f78f:6bf9 with SMTP id af79cd13be357-93497bd6e5amr132741485a.16.1785497615279;
        Fri, 31 Jul 2026 04:33:35 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.34
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:34 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 23/35] librsvg: remove dependency on liberation-fonts
Date: Fri, 31 Jul 2026 07:32:53 -0400
Message-ID: <fc173c6a4c355e6939d6bf1a4ee8a6b2cd2c74cf.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785496469.git.scott.murray@konsulko.com>
References: <cover.1785496469.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4599

From: Ross Burton <ross.burton@arm.com>

librsvg 2.42 onwards[1] from 2018 ship the fonts they need for the test
suite instead of assuming the system has the right fonts, so we don't
need to depend on liberation-fonts for the tests.

[1] librsvg ec3353e89 ("Use a hard-coded font file to render test images,
    for predictable font rendering")

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 8b7c17ea76be679ca3f1ecf7d06ffc3ccaffcee8)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-gnome/librsvg/librsvg_2.61.3.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-gnome/librsvg/librsvg_2.61.3.bb b/recipes-gnome/librsvg/librsvg_2.61.3.bb
index a7494ac..cf8b1b6 100644
--- a/recipes-gnome/librsvg/librsvg_2.61.3.bb
+++ b/recipes-gnome/librsvg/librsvg_2.61.3.bb
@@ -11,7 +11,7 @@ LIC_FILES_CHKSUM = "file://COPYING.LIB;md5=4fbd65380cdd255951079008b364516c"
 
 SECTION = "x11/utils"
 DEPENDS = "cairo gdk-pixbuf glib-2.0 libxml2 pango python3-docutils-native cargo-native cargo-c-native"
-RDEPENDS:${PN}-ptest += "rsvg liberation-fonts"
+RDEPENDS:${PN}-ptest += "rsvg"
 BBCLASSEXTEND = "native nativesdk"
 
 inherit cargo_common gnomebase pixbufcache gobject-introspection rust vala gi-docgen cargo-update-recipe-crates ptest-cargo
-- 
2.55.0


