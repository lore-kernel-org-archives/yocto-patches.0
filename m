Return-Path: <yannik.tannhaeuser@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBC9C2A09B
	for <webhook@archiver.kernel.org>; Fri,  7 Aug 2026 13:31:34 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.42493.1786109488679452768
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 07 Aug 2026 06:31:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=ZwwQB32x;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: yannik.tannhaeuser@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-496b7622a83so28642945e9.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 07 Aug 2026 06:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786109487; x=1786714287; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cCkO8tGuzrgk4dY+2W8fCEbpU9zf8ofTvq/bfJ38ytI=;
        b=ZwwQB32xEWBX7mewghVZzpKl9u8LkPmLzdSOCxWoCSxB5qgvZd1uULK7xdGT/Am9R1
         BiPiAo3y7FtC1S3yi1D9oTVZrsTFJD3T3HdNHmS4lYuN0GitGY1pej9zvWUYBQLJhp5K
         UpophCX4bBwHqg5boSmoVbsPu0fIloKsgFaHJGJ05YiJnmHUapW6EZ2pUSaCymBzBUvp
         6j92mNf1llIbmxbBGpU+JbxAp2d93aCnv+KIWOTVk/5oW7eYJ0v4ISlmPfP83h5sib69
         ZXP1XfuQsPm/SWfsVirkfz/cu9FXLe4Kc3E+AGFrBcouy+BBl9ylfxG6qw7pSZE7j3Pk
         Uvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786109487; x=1786714287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cCkO8tGuzrgk4dY+2W8fCEbpU9zf8ofTvq/bfJ38ytI=;
        b=iMlAIqv0GDOk5Q/OrezqDhxVn8WTGL708nCIop9J4t7vtKW/NTZogfdKv5jXWujeAi
         tQxmZIzHvOr8ktzIbiToQm1eph4Zcp89pZCSULzVExUgYhT+a8/ev2n+f7IfvnFxCXUe
         369mvG0KIoZQ8UQFmrQN/Yr0vz34dfL4fRdK30U722VtLg2rQgD4jEZFfu+1BRZ2HcET
         ME3HpcsORFT3zuLuRsrJQUN42EoFcphJbCLhm16i0c4Ei7tec3bsaTwJ+f0UxsFUgxjz
         fqQHFxGifxZTXPu5C202q3iWKGuHyokZ10pGCm7YhQPa8rF1nFVgbvtdLACYbJrH2ccc
         8Wew==
X-Gm-Message-State: AOJu0Yy3vm08AIzDOw5D3ZI8Apb2L/J06x/x6R5m24daHlxzH5xpm51Z
	o2O83ak9XXXKLu4gGxdDNCDVHPJbwWc9yNuYEolUVk6euhY07iVE631B/ARSkQ==
X-Gm-Gg: AR+sD12ToEOPxEkhpWaZ4FZk7mhZWFGl40wLvHMQdF+x5W3yPtibmaecyhjYIXT15Nf
	sY5Z04o/mNUcKMtP19LTKwiCr9KliOCHeRBUJLHcdVljhtLrdt+6H/TdASfMf/uW3Rf+lx7RfmZ
	yyd5M0yUk2WJrcPODV/rcP4LWVFlIbctBeoSeyKF57yvyFlOZ6m10UWc+WbhMjOjQ01DUKCAcKP
	XIXHHjSsa7hBRvMDm/3zTSm0XFyjd+0ZPFiPIx86y7GoNKDqnoJ/g1xGEfWrycn+fmEw94Gp157
	mUZP6DAp8Y7A5ExdsO/Dr01ztFm2/W+LrbBSrSNuG77Xc1Hi0aDpNFR1UJv7NGzrTLx93FsXJrW
	idxFrt+Jx8xFd8+sJoGyBrciBlHuKnTEVfW37Dj3Uc3Ck7H0+0FfbgA8JeixIepe0MPB8OjH7ii
	ZmKiIIIQe3XWH7GpBAujN7iKL+6UnxrUdcVDySC58CDcQlfqUbCC4jGIMi2FxfdHS/kAJ3KmlI/
	kDVPxU5c4ZgMLl8kAbUnjpygEtTG5dEgiD7e6QvqddazxtTqvZ3JLqGKKHi0F9ESc59YNkAqbmm
	QywZq5SAit8G1BLqXXAPAw==
X-Received: by 2002:a05:600d:4448:20b0:495:5e3d:15e1 with SMTP id 5b1f17b1804b1-4994e7d21fdmr276744915e9.16.1786109486753;
        Fri, 07 Aug 2026 06:31:26 -0700 (PDT)
Received: from ERL0724PF3HPJ22.global.ul.com (p200300f847017a0099d583c1a3d62c58.dip0.t-ipconnect.de. [2003:f8:4701:7a00:99d5:83c1:a3d6:2c58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995e9f0230sm36223905e9.6.2026.08.07.06.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:31:26 -0700 (PDT)
From: Yannik Tannhaeuser <yannik.tannhaeuser@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Yannik Tannhaeuser <yannik.tannhaeuser@gmail.com>
Subject: [meta-selinux][master][PATCH] libselinux: Reduce memory needed in libselinux
Date: Fri,  7 Aug 2026 15:31:23 +0200
Message-ID: <20260807133123.424089-1-yannik.tannhaeuser@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 07 Aug 2026 13:31:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4653

libselinux has a dependency to libpcre2, which seems
to require more memory. Use the introduced AGGRESSIVE_FREE_AFTER_REGEX_MATCH
preprocessor ifndef to have reduced memory usage in libselinux itself.

The workaround with AGGRESSIVE_FREE_AFTER_REGEX_MATCH was introduced
to libselinux with the following commit:
https://github.com/SELinuxProject/selinux/commit/30b3e9d25f417cf62f0d87d2c516c34555b28b32

Signed-off-by: Yannik Tannhaeuser <yannik.tannhaeuser@gmail.com>
---
 recipes-security/selinux/libselinux_3.10.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-security/selinux/libselinux_3.10.bb b/recipes-security/selinux/libselinux_3.10.bb
index 86c9168..24956ae 100644
--- a/recipes-security/selinux/libselinux_3.10.bb
+++ b/recipes-security/selinux/libselinux_3.10.bb
@@ -28,6 +28,8 @@ def get_policyconfigarch(d):
 EXTRA_OEMAKE = "${@get_policyconfigarch(d)}"
 EXTRA_OEMAKE:append:libc-musl = " FTS_LDLIBS=-lfts"
 
+CFLAGS:append = " -DAGGRESSIVE_FREE_AFTER_REGEX_MATCH"
+
 # LTO fat objects in static library embed original source paths in .gnu.lto_* IR
 # sections which are not affected by -ffile-prefix-map, causing buildpaths QA failure
 LTO = ""
-- 
2.43.0


