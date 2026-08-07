Return-Path: <yannik.tannhaeuser@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF5CC5AC7A
	for <webhook@archiver.kernel.org>; Fri,  7 Aug 2026 13:05:34 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.41991.1786107929826822132
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 07 Aug 2026 06:05:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=VfSOM6GY;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: yannik.tannhaeuser@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49553515a8bso50130355e9.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 07 Aug 2026 06:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786107928; x=1786712728; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cCkO8tGuzrgk4dY+2W8fCEbpU9zf8ofTvq/bfJ38ytI=;
        b=VfSOM6GYR889OSHs8HaEE11c0fDgJIYimX2UKuMD23P7VU+SMq9XneJe0aH++tdthw
         LlCMforpklL9D80brK+ue8DffF62XainZXrHcM/Vxt3e0cPRBKntp7l7/fRSVkrkmKgc
         spyyiaXTS3EJlMifYJnHbuyTpOAYXQBhkD1UTU/47+xC4SRVv9Yaz3guCb994D9VS/l/
         oyougHEypQz5046ZoPZcjHsdCtBBbmns590cD2eS6N4ajodtN/K4eyfGRu01bgf0pRjE
         YxYvP6VScJMT8ibKy2jtyLuZJ8ZupmLUYyxrqmacHIMxT89JM/PznCm84HZNUTkTBvBo
         tKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786107928; x=1786712728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cCkO8tGuzrgk4dY+2W8fCEbpU9zf8ofTvq/bfJ38ytI=;
        b=hSI9lZ1Y0rbTCY+AYLe1knHKkyTBeTqyghMxr3VMoQvEFqcvA4pMIgPxQJ+egQgBvw
         VKmhYmLa69oqSdzo0aMK/aBBVlkalln0q4xN0uVDx86YfZEUqpWyJScH6pMsQKIO29n4
         4RkW4pPGxaFjcD0FDnyj6MbhSjYXI64TwNAPJSZ+kbZV1U5Y2W9S/4FscWJX4pe2dacV
         QxwH0QE9XlCAvCi9ZQ4pKAJkDEGwxYQwZt1DDBjO4OjiWj1U6rTO0Cf+5eBv9FzR+QJe
         RVxvg1f3I5He9qj5LQLD2crJY+FT2K0zA6eAmsvTTw77VOB+HwCp43OKbK1NN4P1+2df
         deqA==
X-Gm-Message-State: AOJu0YzQQsv4nmhauUmfdsGs1bD4uPqnx6+WBVhxVItIkOXtEaDGTeeY
	br30P/KYK+24qs6knMdDJCpvGDg8eQdOy5MXkQn4Izp6E75ySErLZbhciPcwTg==
X-Gm-Gg: AR+sD10OGi7h2237SUKmWlMzu2kuTNAkPDOA2tt/YSMny1kHZtyytVh2N0/U5f3LQEw
	6POlBFF6yQrhNRuKcqk0mCWOW8tlTS2IYHPVg2d0MPDRhFwD1iOf+/Th7vcYNI3FqzumRjAS0ip
	xic7LcKLBbAPr8G8AdiNUoi+YRB6INt096VroabwJ+r1YIrXgHDktjklr9KJ7oEVTuIejGQiRiA
	/jJgTsz6nx3815gKVPwTlWiZ9ygUWV/HkXCXpVyiFdwRmK8E2PHuz5iMdZyjS9IUUj5/5muWukA
	rvI7KGG2Y5yHoyHjGrLRMPIFjBUS1SVMq66BIRAuuk9tvKmcb18/a6BHy5jETaGjbif/ZtRpnrq
	ypE2OgwxIjqTXOSGsLa6g9uLyICb0QB4bknxovMNqmAoMrE7O/OUaQ7kl9l5DS5fx7z/7/BhwiO
	37GmvCB9Hgr5bRiPwTCqPpL05FdZW4oi/OqfupgeqbmsCfsGVKnWYK8BOC6GMwwd80/GrOlVhHR
	FHq5iZBC+fhnLlI09USlZL7KCznrrGo7rYFmzddQK84epGUcRVtoQT0yRSnfknVVuGPzjfZ7x0D
	Ryny3U50a7xe/RTcmKnQ
X-Received: by 2002:a05:600c:190a:b0:495:7a04:b006 with SMTP id 5b1f17b1804b1-49959e0e2fdmr119725315e9.8.1786107927483;
        Fri, 07 Aug 2026 06:05:27 -0700 (PDT)
Received: from ERL0724PF3HPJ22.global.ul.com (p200300f847017a0099d583c1a3d62c58.dip0.t-ipconnect.de. [2003:f8:4701:7a00:99d5:83c1:a3d6:2c58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995ea2dc4esm42920725e9.13.2026.08.07.06.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:05:27 -0700 (PDT)
From: Yannik Tannhaeuser <yannik.tannhaeuser@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Yannik Tannhaeuser <yannik.tannhaeuser@gmail.com>
Subject: [meta-selinux][wrynose][PATCH] libselinux: Reduce memory needed in libselinux
Date: Fri,  7 Aug 2026 15:04:55 +0200
Message-ID: <20260807130455.421587-1-yannik.tannhaeuser@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 07 Aug 2026 13:05:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4650

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


