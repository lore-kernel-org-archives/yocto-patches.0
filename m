Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A0CCCFA18
	for <webhook@archiver.kernel.org>; Sat,  8 Nov 2025 20:16:20 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13111.1762632971163557759
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 08 Nov 2025 12:16:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ekcpAL57;
 spf=pass (domain: konsulko.com, ip: 209.85.219.47, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-88246401c9eso1673196d6.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 12:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1762632970; x=1763237770; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BWhUp0kiLkflOjZ6KYSsZX9hSQqPHOlZEGEkj6Qktz4=;
        b=ekcpAL57ggztQvZVf5sS0N8357OTqrjp+JQgcR1Mm8ppGecFSV6a483XxPb83YnTg/
         HDmNiO+bymrRsN0UdxPWxBCrTlAybrywR7DlhFCts1NYRCfNXAZHHMu2HXFb+bsOUpKS
         bmAvw76lujuBlguiGCetq+LCyeEg6MLbEYdIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762632970; x=1763237770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BWhUp0kiLkflOjZ6KYSsZX9hSQqPHOlZEGEkj6Qktz4=;
        b=DK9RQkivr2TmeRxp2shkJYilSVwaV1HUp15VIJ2Kc27tkb1zzP/EKTy7/1CydeDc4A
         hc8UW+17Mdx4GfYy/pWW0i0FBZUnI8MJrXehAZ42k4ZOMxT3l3kvuCSuRSlqRNXPMzL+
         E04AruXYGiq5MyILlNuTloqD9q33lC+8I4dI97OqY7XMI2cORlQ+/6mtddx1rVYmsMC0
         eA8z0SYODFy4QjKBJAiX5HHZdg9GqriLf9zaVp624hE5rtgOKaWQRXvQsBB4FtcD5i7k
         M9r5IjsptVdQ/27oopI0ozf35Yy81eJkovT/PL/yGRGwkSSDDhvMQnWlcIUsxxQt+Zk7
         XtbQ==
X-Gm-Message-State: AOJu0YzM4O7ApthwJk1IgDZn7Ufq6tXZr2bWna9L8Ce2JsGRqjl+nmYc
	aV3a06oNmFb0XbhrDZvVK/6yXJcLUrClE/evfQBhTiyqDpaGHb2xq/nKOAPiUfYPevlvUmv9a7s
	bVtr+
X-Gm-Gg: ASbGncvHtWdhWa31tlLqzHzv01zhkxqEDwPx1JocmFb4sJVVYJOgOFalh6RgXM1Ji+b
	+2zMxY96Q9u8SXlWIlZecT0EPXn612xQkfv8rh7X9eqshswj7f+2TeXKwUyBTBX09a/e+LXlw5m
	jgA0AEAJX6ad8eDHsZjR1tO06ZCs7N++kDI8PKeQBEe7tRPXUzIFCChuZUQAk9YNLJI6VpbK0Vb
	cWZDFX1wrhfKpo3CPijQiu5Lh+NhZQJu1QFNd5Mc6UpPFmNaPDSkU9oPuq3aEkUoCA5pKT2WAiA
	RthnNMk3QPlvz/ZL/aw2mBjhQvD4xML7GcsXyP26B6YCElkTOl2WdTF9o93Uh8e+GwpBkZQxV/6
	iUyKiH5IiOf5H2CjrD+b3bEZoTTQnIO0NZkNrkC6gmYyp2Y9RX24cKyrsy4OVzMCpmOVdISzkT6
	v8WmKhDJDS8eARbDxI30lTV24SZ/y+GmX/kV9BpGtH2Nk4T33ZLssDT/ejnEQsmCQ=
X-Google-Smtp-Source: AGHT+IEGAxV8xlrRz6qtourIeXXlefQbKnL/F5FN2cPEyRRFAcaHsf7mYq4o0LBnrbzwQtsDVWMmTg==
X-Received: by 2002:ad4:5fc9:0:b0:880:2d04:fa07 with SMTP id 6a1803df08f44-88238689559mr49249226d6.32.1762632969757;
        Sat, 08 Nov 2025 12:16:09 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238b91b22sm20001896d6.53.2025.11.08.12.16.08
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 12:16:09 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 09/11] classes/cargo_common: ensure B is clean
Date: Sat,  8 Nov 2025 15:15:51 -0500
Message-ID: <ed392c09a516ed398d4ba7a6032538b116e451ed.1762632742.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762632742.git.scott.murray@konsulko.com>
References: <cover.1762632742.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 08 Nov 2025 20:16:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2444

From: Ross Burton <ross.burton@arm.com>

The cargo class defaults to out-of-tree builds in WORKDIR/build, but
at no point was that directory cleaned.  This causes problems with the
rust standard library recipe (libstd-rs) which installs manually with cp,
so rebuilds can be contaminated with the contents of previous builds.

I believe that post-release we should switch cargo.bbclass to mandating
out-of-tree builds to reduce the complexity, but for now in out-of-tree
builds we can just delete the ${B}/target directory.

Note that we use ${B}/target because there at least were reasons to use
that name[1], it is unclear if these limitations still hold. We can't
simply clean ${B} because that will break recipes that use cargo and
something else to build, for example librsvg.

[1] https://github.com/rust-lang/cargo/pull/1657

(From OE-Core rev: 1452ac7a44196454a52f3f6d883290ddcccfd3f8)

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 9d9ce457630ea7403ffe7028e3370647db0b83fa)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes/cargo_common.bbclass | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/classes/cargo_common.bbclass b/classes/cargo_common.bbclass
index e417214..7e86930 100644
--- a/classes/cargo_common.bbclass
+++ b/classes/cargo_common.bbclass
@@ -110,6 +110,10 @@ cargo_common_do_configure () {
 	# Put build output in build directory preferred by bitbake instead of
 	# inside source directory unless they are the same
 	if [ "${B}" != "${S}" ]; then
+		# We should consider mandating out-of-tree builds and just using [cleandirs]
+		rm -rf ${B}/target
+		mkdir -p ${B}
+
 		cat <<- EOF >> ${CARGO_HOME}/config.toml
 
 		[build]
-- 
2.51.0


