Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C556CC3DA49
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 01:06:40 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
 by mx.groups.io with SMTP id smtpd.web10.46506.1722215197597103986
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 28 Jul 2024 18:06:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mb8Svfxg;
 spf=pass (domain: gmail.com, ip: 209.85.128.173, mailfrom: akuster808@gmail.com)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-66526e430e0so14436617b3.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 28 Jul 2024 18:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722215196; x=1722819996; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8VX7ESJZSJ+ruHr+2rQCLvMbWOjfCmx3vRkprKOJP/Y=;
        b=mb8SvfxgIFgsyDfdP7DBAnUB2iva8GbmPjfw07oGhnlKzcogCwe2M8ZZG32RItdZsa
         axy0dJRgE/Fpd1mVSzWGwvfH4LXCMUharn9jZxU6amrUWKa45khVPWsDX3Y/cxmMIdSs
         szpqJMdAIkaa7vwR3rGUIzemXJTxR4bZ4IkuN4ZBI996fnQWYUG2o/VJPM7qlozf53e4
         d8/aQUscD5aso+M8kUaB34Cte2TNa5/AA+dyWockl0v0bId4sVUVL4fFntZcKsi6sO52
         d6HmanTWN5XdVL9yEbbfOpFNuceFmOp4/XIWiS0p/bV0/gKgkb1BbYqnyXvDU9wyNpcG
         qnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722215196; x=1722819996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8VX7ESJZSJ+ruHr+2rQCLvMbWOjfCmx3vRkprKOJP/Y=;
        b=Snr/Plk8eC7HfMn/KYb38Txx3Ckh6g12dIkMXTjSYo+AsNYXD34y+UOgMfIP339g63
         Ip3WIGb5glJpmiVya4oU+qXHdnTLbBU0XiSqAQ7yDM2mKzNx2pdP7iYK6yA2TDUsixD6
         hLrLOGwME5uSbSORWcbz9tF+/JkxM+Zco98rB+JXEcC1x3JJrPNquyKXuGPaCkwvxE9r
         xAV6+f0G8upQZRDc4idAxMMI2SmaVaF/MFm6QjB0RxKvvn9wJYCW5r1UDlc6LiJvGDxn
         85lUpSxAXtSmbo+FdKeuoZoWPeGfgjsNbz3LbdPRbrRg2IMlJO1pBidswduNHoprDxtw
         ocog==
X-Gm-Message-State: AOJu0YxIfRSaamCagP1q2vF8cA4qaRWfcVwKlg5+jxIX3L9ymrcQN+pO
	9FF/mhpGdYGWzu1OEEA0BVEJPxgZCw0Pq5nrySiTuHiO1zQPPn6KXReShA==
X-Google-Smtp-Source: AGHT+IEMLDd5y5/5NAKJhx+ysqkFn/pYtUD5zjfEwqzN+VOgzpX+2ya75ETp1WgRCiJMt12AgNs75g==
X-Received: by 2002:a05:690c:3811:b0:64a:5f5a:b38c with SMTP id 00721157ae682-67a075a67d6mr76122357b3.26.1722215196629;
        Sun, 28 Jul 2024 18:06:36 -0700 (PDT)
Received: from keaua.attlocal.net ([2600:1700:45dd:7000:47bc:453d:d517:b47])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756bc9edd8sm18543157b3.130.2024.07.28.18.06.36
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 18:06:36 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 3/6] krill: Fix QA warnings
Date: Sun, 28 Jul 2024 21:06:31 -0400
Message-Id: <20240729010634.1991558-3-akuster808@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729010634.1991558-1-akuster808@gmail.com>
References: <20240729010634.1991558-1-akuster808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jul 2024 01:06:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/483

ERROR: krill-0.12.3-r0 do_package_qa: QA Issue: File /usr/bin/.debug/krill in package krill-dbg contains reference to TMPDIR
File /usr/bin/.debug/krillc in package krill-dbg contains reference to TMPDIR
File /usr/bin/.debug/krillup in package krill-dbg contains reference to TMPDIR [buildpaths]

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 recipes-security/krill/krill_0.12.3.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-security/krill/krill_0.12.3.bb b/recipes-security/krill/krill_0.12.3.bb
index 2e200dd..d5917a1 100644
--- a/recipes-security/krill/krill_0.12.3.bb
+++ b/recipes-security/krill/krill_0.12.3.bb
@@ -26,6 +26,7 @@ do_install:append () {
 
     install -m 664 ${S}/defaults/krill.conf ${D}${sysconfdir}/.
     install ${S}/defaults/* ${D}${datadir}/krill/.
+    find  ${D}${bindir}/ -name "krill*"  -exec sed -i -e 's#${CARGO_HOME}/bitbake##g' {} +
 }
 
 KRILL_UID ?= "krill"
@@ -38,5 +39,6 @@ USERADD_PARAM:${PN} = "--system -g ${KRILL_GID} --home-dir  \
                        --shell /sbin/nologin ${BPN}"
 
 FILES:${PN} += "{sysconfdir}/defaults ${datadir}"
+INSANE_SKIP:${PN} = "already-stripped"
 
 COMPATIBLE_HOST = "(i.86|x86_64|aarch64).*-linux"
-- 
2.34.1


