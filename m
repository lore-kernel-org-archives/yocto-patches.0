Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB8ECCD1A2
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 21:22:44 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.web11.1677.1760649762495547502
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Oct 2025 14:22:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ta+yp1Xu;
 spf=pass (domain: konsulko.com, ip: 209.85.219.54, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-87c1f61ba98so10228006d6.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 14:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1760649761; x=1761254561; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wxj7Y0sT5x6x0ff75J4Lc54Y81wQBlNbRxfbZMXW8bo=;
        b=ta+yp1Xuc8skVigG4xYVOTI+0JiAnGk/1mmudDgM0QqygaX11OSmiDGwUoH5lG9PPR
         GuUmNPrtNYIR4TYdFb6om2YTWX+20pi8nF3wXPaCD61Dxp5W/cqRpjmrooTcSIIGJ62l
         GGP9HGruKFtYuUdJ4spIdt5wzD1L3kySFzPIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760649761; x=1761254561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wxj7Y0sT5x6x0ff75J4Lc54Y81wQBlNbRxfbZMXW8bo=;
        b=b5JNwLiALxyMyTbdaoahK9c7YtQ15q4Bsq/KyloLE1RyuoDFn2mJhquSmiPoqQc12s
         x87op2cLPhB7byZBtB+LWDOjFvv0lNnj0lhU8PiQN8cxTyAyrZlzrQpxbxFkfHY45HY5
         DbbZvMaBI4tUu07sPmWrvN32QZpSTMswrhCX/m+IvTQ4fTuikEEeSWaIaFxlx4lYqMhk
         QYGYYgVW+yg03O28BYmvzCM0xaY7KARO0QUWLgtPzyTqsL/tE3XHFxGY59D4UyxCJS5h
         m+98fl8XL8PQDDEkEOAPsUpPFJriahLP2O6ThOS863tznpm8dwKwysEx6PwdDbjWCapn
         yeaw==
X-Gm-Message-State: AOJu0YzDdC9TW21raUXup61EUJpmFjJw2phgCPtqUg8cG7HgRoi+6t9E
	9IhCvcPjpXBIUzZy+AQHsYRYTZoLp/WIV7ZGC8RpV6C7D9++gZxiJLQhh+ZJB48fNE/oZxNCDOK
	rdxAx
X-Gm-Gg: ASbGncvQDmZn9TIqQf4mpOOOuVgriMSkEYmhmQJJZbE+RjnP2CeFczQTNZAVbxYbUA5
	1JxA5lo1OOmRhikvX1X71gIrk7YmyjzpgJ+Bg76hpFnoWdCQyEoE8jASyRVh+jCxDFksD7s3u9W
	uJeY9cneuMkv9qdJMFjtbY7H6MnQaQrG+TmBfW/KeFl4F5XKVnImQTUI+lPgKbULfdxRDRTVDZQ
	0WfSxLD/1Qgm3XebWaRCg3o3LrRhBK3I4YnBHONJhkJcYizYPIHST+eDyLS8Xs9UW9jf4gb9ekt
	nUAgcHc//kxk3yVbyJ9Fuh6rtO/pQfZTsGsJpuK4dr5/vfMDP1Kq2+o4yrE15dmSu5+gIQUvP4Y
	N94JR3KpZQ+vDsQMHc9gHXHCv1rj2nBodrcrHem3T42nGAUZO6HzFTHFhnJwscEjBves6312+YH
	Gf57Oo45MR6BgraJQUF/XuxqPmJVCRzFTiAbwTq0xdRSdYr4RO+inB
X-Google-Smtp-Source: AGHT+IHGu/pYhxlVmhAWW2cKoiebt3pfwd8N/wvfzqLb4Uu0k7k7l1wmKBOFr1FFu6HQ0CZcVQxG+w==
X-Received: by 2002:a05:6214:410d:b0:87c:22e6:94f6 with SMTP id 6a1803df08f44-87c22e69830mr8471956d6.32.1760649761282;
        Thu, 16 Oct 2025 14:22:41 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c1c2fd4f4sm14647466d6.7.2025.10.16.14.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 14:22:40 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Subject: [meta-security][PATCH 10/15] libmhash: fix build with gcc 15
Date: Thu, 16 Oct 2025 17:22:09 -0400
Message-ID: <7de971f4e339bfb13a605211bd71f881b7e05448.1760648348.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760648348.git.scott.murray@konsulko.com>
References: <cover.1760648348.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 21:22:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2335

From: Yi Zhao <yi.zhao@windriver.com>

GCC 15 switched to C23 by default, which libmhash does not yet support.
So keep using C17.

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 recipes-security/libmhash/libmhash_0.9.9.9.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-security/libmhash/libmhash_0.9.9.9.bb b/recipes-security/libmhash/libmhash_0.9.9.9.bb
index f5518d2..805cf05 100644
--- a/recipes-security/libmhash/libmhash_0.9.9.9.bb
+++ b/recipes-security/libmhash/libmhash_0.9.9.9.bb
@@ -25,6 +25,8 @@ SRC_URI[sha256sum] = "56521c52a9033779154432d0ae47ad7198914785265e1f570cee21ab24
 
 inherit autotools-brokensep ptest multilib_header
 
+CFLAGS += "-std=gnu17"
+
 do_install:append() {
     oe_multilib_header mutils/mhash_config.h
 }
-- 
2.51.0


