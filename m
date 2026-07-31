Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951B4C55176
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:34 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4587.1785497606465865112
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=T5au+Z36;
 spf=pass (domain: konsulko.com, ip: 209.85.222.178, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e5c92c389so42170885a.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497605; x=1786102405; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qDgrQXecEwI4D37X7IDol5sILimsZxiwopEKNK4tXlc=;
        b=T5au+Z36tJ4itSgIs9Hn5sitfSJ1nr67MTAJh+6zJOVRW8EyaD20SzC1eTmAWd7wg3
         h2+EMZxVDWqKFpKrzjPMQj8oHmjKs7ek/kZJcJiB1kYDfkQDhMeAuYyJhuifP4YE2F7k
         19x35rbKA0QwvujI4lyfyevib5Ccj0TUy6dYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497605; x=1786102405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qDgrQXecEwI4D37X7IDol5sILimsZxiwopEKNK4tXlc=;
        b=s7NgCCAdveUyxRDj1RVr+glfgh8GJz/8N4nnV5TFRMSh2aW0KmCYDMT+ayfUoBvVyF
         sUpqeZw+/Id9wX3UAdliE5BXTP6kzfFkxYa4zSw7Wnw1stJYPruNQxtZCABbDwGuaIEQ
         rKC1Vj6hxXKU4dV34CrJ/9tF+G41CbNXKXcCJW7reeGwTjodXTSO7u8rQ8EhJA5RfsXD
         6WFOxtvzabnStqqwJGVkT4pz8sy/rMDK/MU5Q8dNwKIPQAzogJ6wh1w7qaAtq8yzPH88
         i/EthFml6mpyLsD/7jZgncxXmrzjOMapzWMItCM1YPVs0cIpC08aoZHULOBjQoeWLQbO
         dWxw==
X-Gm-Message-State: AOJu0Yy36L0LQhWjSoWDGxq44v+X1+vrzuyifO5xAXBah3qQLMj737Gx
	mSWjhgjiM5hExraMLhXIx0ZV93kZ16gXQroPRGJdsf4ebTvpkcttGOX7M8VolBeS5jnFkjlZu+F
	5U+y3
X-Gm-Gg: AR+sD10kq30X/nAlALyyyy4NC9sfTL5RiqqLYDoDhd/SGKOn9aVW9z87aEi+ob5QHHX
	BJyk4WUrwR/V2KUaAbZbgZdCMLmJCK30GxFHEkNhsixvXRahZ9ZP6pPyW4hQN+A7FTV5CjDTaYT
	K72fLQ6lnzVtJCDmni1cj2gVG0cnV/1KfA0ft/oGPwdfR7empq5bz2zJO13uk9rOSxeskrcZtwp
	+6Nk7TglT8/ak2wEByVcFgSJOL87sSUfBcin/62vSNZgJennvJvcBbD4tCfVbPVk5NdNxuE9Wzo
	LmCnX86kjFT/pzQHMCcZHLhk5nd81cYSZ/8qKQJvDgMkq3ROogjRZwU5hTGl9SOlQVFM3bAdjkg
	ysbM3xhCpd+IHRFND75s47Xk1iLS7F4pp30GNo2uzlj3v5zpLRf9pTrIPuicKjo+Eydl4z47uaz
	sp867pJnm6MWdgpCvAsOeLvTqHpI1Z7lMQkotfaPouvCo9shViWZ/uJB8RdpSRb3A2uAeTgCTim
	3/FFwxoJQiCpO7T9SXuWj/9M4/d/S2AUJfzkklv2HlluqSVniWeaIIcg/RZm0xJSSarfvPnmLv1
	EUGwsfGlxxPs+5b92LkPuVI1uw==
X-Received: by 2002:a05:620a:6f88:20b0:933:aa0:bb83 with SMTP id af79cd13be357-934974d6814mr145053585a.34.1785497605233;
        Fri, 31 Jul 2026 04:33:25 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.24
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:24 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 10/35] librsvg: move symlink file for ptest in package librsvg-ptest
Date: Fri, 31 Jul 2026 07:32:40 -0400
Message-ID: <8b3b5c89d316cbd6ca3fdc99b3a9261943092a99.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785496469.git.scott.murray@konsulko.com>
References: <cover.1785496469.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4586

From: Changqing Li <changqing.li@windriver.com>

In order to make ptest can find needed data, a symlink is created:
/usr/lib64/librsvg/rsvg -> ptest

package this symlink file in package librsvd-ptest, this can avoid
there is a dead link when ptest-pkgs is not installed.

Signed-off-by: Changqing Li <changqing.li@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 512a71ea5d41bdca5cbf78fd65f5dcd218076b27)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-gnome/librsvg/librsvg_2.61.3.bb | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-gnome/librsvg/librsvg_2.61.3.bb b/recipes-gnome/librsvg/librsvg_2.61.3.bb
index a12ffc3..419d5cc 100644
--- a/recipes-gnome/librsvg/librsvg_2.61.3.bb
+++ b/recipes-gnome/librsvg/librsvg_2.61.3.bb
@@ -103,6 +103,7 @@ FILES:rsvg = "${bindir}/rsvg* \
 	      ${datadir}/themes"
 FILES:librsvg-gtk = "${libdir}/gdk-pixbuf-2.0/*/*/*.so \
                      ${datadir}/thumbnailers/librsvg.thumbnailer"
+FILES:${PN}-ptest += "${libdir}/${BPN}/rsvg"
 RRECOMMENDS:librsvg-gtk = "gdk-pixbuf-bin"
 
 PIXBUF_PACKAGES = "librsvg-gtk"
-- 
2.55.0


