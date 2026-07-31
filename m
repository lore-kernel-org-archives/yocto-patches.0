Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1895C55178
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:34 +0000 (UTC)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4596.1785497613153012685
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Bkp9PQpe;
 spf=pass (domain: konsulko.com, ip: 209.85.222.176, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e85499ffbso69623285a.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497612; x=1786102412; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hWN16qXvfMx8wUhM2pspVl1kTF6RWj/dQIGQ9DVTf7s=;
        b=Bkp9PQpeoF1T6Arn4WIHfCu/DbKGzkUGDxG16HUX+5vqz9Clf+tckw73EuyW6gavCd
         O4UCTOUkqj7UICXHIUJTBVR+nkaIlmAG7TDY64mlVgCYVqEaOc6buDYy7mnCHXAEgz4a
         TM71Yw5pLqKFIgoQ48QBeXLwSDoA/3i4HUJ3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497612; x=1786102412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hWN16qXvfMx8wUhM2pspVl1kTF6RWj/dQIGQ9DVTf7s=;
        b=glYzDW+nSjPDgQizvY8gctiFiIEEblXIIoDl3XIaxchfiM0zJ9+PYgMzHYnxyJ2DmR
         Lnby50pPp+NntUG+aSOqk4XxzVSKjLtUDCR2GIO6ZxJvCEZkga3DKjIORlt3KX4KVC0V
         b8LTWyBnioG3bQNojJi+i7PYojfREwo5VO+OTxCPQr9xtef2YQ7qvpJtNX2MKLMbK/wK
         ZWe7MXgAeRBbKHZlpwG1F6IL+jEpOYysH9TkkE9jeoB1/2OER6KHQ6aRq6Ab/DD2NwxY
         QqCZIi6PE/BFmGtOwSR3B02ntA8c5ZAxLdKYGccAOqu7jITHbFeBMmBMi6s+VBDzvdzo
         7Ljw==
X-Gm-Message-State: AOJu0YydofDxw7huJb+BCdu+vblofhpaUK4z2tHsFPbF4GK68/0+WT79
	OSbY9vYq5ntDIfJNqZ185jdVYMHyrzq9uuXu3AYhLBiECVeMSDaLKK/xsVUEwLft2xGbZq6+DJu
	waq+M
X-Gm-Gg: AR+sD113iXNTGsDd/62FhuZhgWqlvWArw8dwTljX835FLUEjRX8vyM9LGbRVoLT865i
	M0RjVlpIcorG1QA+D59UUCUwvxSSTFMghNMNM7VE/bt4pEvOXS6L4zqvBXBaNzh6hnVeGFnkaFW
	IU2krXlVkv8el4dE3o5/p34C8xZb5BCjjXHtHJ/FqJp0s0LPfa4IDmf8XYUC6Y1VbMBbOwK684Y
	A3rz+tH3iJ30dkkvNQXZs1k8o2I5Vl3v3sGvFEZB+Xn/YybLOZwUrRFHAh0fEEH7DDPXId4YCky
	AXgUpOR1Hbjo/+eaSa/vOyXaYGJAstUFoQHnWFUPchZG5bFEMEJRXyodV0QznVdP/CVv4kJAq1n
	raNyiHSM6Q+JQzlHVitbfG7Wo+W0U/NLzP5NeGsBFzvV7ktvZMUNlvFvpNp3FWNdG7tE1bnvodw
	KROxI/0SdZieJ6yDoI3s8WY+pshrrCiUX/80yeZBrIqpQwSk55x9v/jqusQGOmvS8TLJh0szldf
	AmlwFdq5/uyhTPQ9Kamz9CGCRoz11+Cqqt8ozBjFe4AVanZ3F2jicvTAjx0eA02iMs4V7m3a98c
	8nvULOh0/UtbJih1LFtk6Cr1ww==
X-Received: by 2002:a05:620a:2418:10b0:92e:fe10:3eed with SMTP id af79cd13be357-934968bf07bmr176845585a.44.1785497611944;
        Fri, 31 Jul 2026 04:33:31 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.31
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:31 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 19/35] librsvg: consolidate DEPENDS
Date: Fri, 31 Jul 2026 07:32:49 -0400
Message-ID: <4cda35732b4eb684b54422a0fc0cc5f43e9bcef5.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785496469.git.scott.murray@konsulko.com>
References: <cover.1785496469.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4595

From: Ross Burton <ross.burton@arm.com>

There's no reason to append cargo-native to BASEDEPENDS when it can just
be added to DEPENDS.

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 2038ae72a902539d88bd9f1e013cd201da2c3c78)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-gnome/librsvg/librsvg_2.61.3.bb | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/recipes-gnome/librsvg/librsvg_2.61.3.bb b/recipes-gnome/librsvg/librsvg_2.61.3.bb
index 06f08ba..1dbfab3 100644
--- a/recipes-gnome/librsvg/librsvg_2.61.3.bb
+++ b/recipes-gnome/librsvg/librsvg_2.61.3.bb
@@ -10,7 +10,7 @@ LICENSE = "LGPL-2.1-or-later"
 LIC_FILES_CHKSUM = "file://COPYING.LIB;md5=4fbd65380cdd255951079008b364516c"
 
 SECTION = "x11/utils"
-DEPENDS = "cairo gdk-pixbuf glib-2.0 libxml2 pango python3-docutils-native cargo-c-native"
+DEPENDS = "cairo gdk-pixbuf glib-2.0 libxml2 pango python3-docutils-native cargo-native cargo-c-native"
 RDEPENDS:${PN}-ptest += "rsvg liberation-fonts"
 BBCLASSEXTEND = "native nativesdk"
 
@@ -31,11 +31,6 @@ SRC_URI[archive.sha256sum] = "a56d2c80d744ad2f2718f85df466fe71d24ff1f9bc3e5ef588
 
 UPSTREAM_CHECK_REGEX = "librsvg-(?P<pver>\d+\.\d+\.(?!9\d+)\d+)"
 
-# librsvg is still autotools-based, but is calling cargo from its automake-driven makefiles
-# so we cannot use cargo class directly, but still need bits and pieces from it 
-# for cargo to be happy
-BASEDEPENDS:append = " cargo-native"
-
 export EXTRA_NATIVE_PKGCONFIG_PATH = "${B}/meson-uninstalled:"
 export RUST_BACKTRACE = "full"
 export RUSTFLAGS
-- 
2.55.0


