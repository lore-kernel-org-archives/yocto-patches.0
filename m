Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E4FEDF152
	for <webhook@archiver.kernel.org>; Fri, 13 Feb 2026 11:06:32 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.69334.1770980789381125377
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Feb 2026 03:06:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=UpgLsM7j;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-481188b7760so6945865e9.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 13 Feb 2026 03:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1770980787; x=1771585587; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7zg8FfiGAY4GTopMRWIEApHne6QvvPGzpX2kT+SXIpw=;
        b=UpgLsM7j6eqIWtWyh9WMzrRUmutunaEhbtIOUPgvt5kME+l9eiwM57UgseaOJiJcN6
         Mte534NPmWi5mHK+3Mxq+OWQzSi9WIYwnTYC53fHWWBlsE09oLeOdfMEIoOVqKeUHhRs
         yVema6VaEMV+inrvHVfhLqobf+r74SnnJJ65M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770980787; x=1771585587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zg8FfiGAY4GTopMRWIEApHne6QvvPGzpX2kT+SXIpw=;
        b=g6uBUxhdPsLZvB24ScXCT8I7nmjr1F8yPR4xWu9+OqmsxgvtSGP7BSEeMfBGt+IS/L
         DLVvMmi9jEhuoo2DDjTDEQGfsOYn5TQowpeSHDWgyDvZ37g3NmCEG8fRfeHENtoZpKRV
         j8pnZWohJOQnffQikAjwyNCqxHFarg0Y1UPoIz/RvxOLHiiAdnE2nOX5vJw6OoEyofeJ
         hcwNxh4flROikbOWm4NRR1fq8/PJaTcNSuU0d5vULSs2jFUOrgNWDlSCtVO4Tx9ZgK3l
         IdpzLwoTEFJLXHdNW/eLSZcUo3+/ys10nyRVCOy8vogiXjHhGvd4REW/T0ldjmAkpKdZ
         1w/g==
X-Gm-Message-State: AOJu0YwLgQ/V9qHMOtrLjjCJEnC9K8tS3Yglm6d5sMA87PIWGmSdMoJj
	9NbDmZHcEBjf+kkexzx9iW35y9MHUc818U4Suzo9OBvzssnhN9nA9FkrzifNr7LZbppaPamf/Qz
	XJdsiqNU=
X-Gm-Gg: AZuq6aJHkIZsDT7DYLl/XyC5Njj+icdXNZ0jbI+d39mI9xMZdKKo0EiAFCk+VEztcLR
	lDObh0i99tfpQEvviJvOC/DzyUY4NtugBGTlGxEHpxS1ezFpcHJioI1rKSAAByN+757Cw3cM3If
	He8IIN/cJRwl8NOStIe4kv4lJu2JvBYgCKSs/somOSl/FeIP7ERbYUreaUqyPKYnfW5coAybBTZ
	3x5JUgQZpdOY772AgNyVzbeGbhpBN02UCbxAoLyy1Q+CzJ6ES3lYf0qml2VwrUveX4IaPGMq1VY
	KjC+lB5Zuhb3aUidpL7k8la0dySfZNMa4iRep47qeVZWEDo8yZlVT4517qB90ZEU7hdp5olFlPc
	xESowHWFm4MmQruth1mTd/ybCae+RO1NCnfciKcMHm1Av4nUtsm8mldc3q6/os2d1sHAkkLEgGX
	bojDvDt/280Biw3+ebymLgNyfAnbaIE2FgCmEo3fowNUnHwR2P1Gk=
X-Received: by 2002:a05:600c:a43:b0:477:89d5:fdb2 with SMTP id 5b1f17b1804b1-48373a0808amr20114805e9.14.1770980787118;
        Fri, 13 Feb 2026 03:06:27 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e20e:afdc:37ec:38d1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d82a4c4sm445473825e9.10.2026.02.13.03.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 03:06:26 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net,
	mark.hatle@kernel.crashing.org
Subject: [pseudo] [PATCH 1/2] ports/linux: Ensure SYS_openat2 is defined
Date: Fri, 13 Feb 2026 11:06:23 +0000
Message-ID: <20260213110624.1659480-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Feb 2026 11:06:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3232

Some systems such as Debian 11 and OpenSUSE 15.5 don't define SYS_openat2
which means the syscall intercept doesn't work if pseudo compiled on those
systems and then used on others which do use that syscall.

Add a define to catch this situation and resolve it. Also add a error
if the value is undefined to prevent us getting into this situation again.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 ports/linux/portdefs.h        | 5 +++++
 ports/linux/pseudo_wrappers.c | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/ports/linux/portdefs.h b/ports/linux/portdefs.h
index 1b4ce74..a8b2be6 100644
--- a/ports/linux/portdefs.h
+++ b/ports/linux/portdefs.h
@@ -53,3 +53,8 @@ GLIBC_COMPAT_SYMBOL(memcpy,2.0);
 #define _MKNOD_VER 1
 #endif
 #endif
+
+/* Debian 11 and Opensuse 15.5 need this */
+#ifndef SYS_openat2
+#define SYS_openat2 __NR_openat2
+#endif
diff --git a/ports/linux/pseudo_wrappers.c b/ports/linux/pseudo_wrappers.c
index df7de09..300b5a5 100644
--- a/ports/linux/pseudo_wrappers.c
+++ b/ports/linux/pseudo_wrappers.c
@@ -96,6 +96,8 @@ syscall(long number, ...) {
 
 		return wrap_openat2(dirfd, path, how, size);
 	}
+#else
+#error SYS_openat2 not defined
 #endif
 
 #ifdef SYS_renameat2

