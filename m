Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9281.1795883256824216475
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Nov 2026 08:27:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=n3tySozs;
 spf=pass (domain: konsulko.com, ip: 209.85.128.43, mailfrom: scott.murray@konsulko.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so74120505e9.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 08:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795883255; x=1796488055; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8I3IwqV/dezd+UXbvTY+DtjOPTO6IyH1DCZFseY3stQ=;
        b=n3tySozsmvTqx0eZlG1M5/zpoZXAnL3+I9jMwzFSN5yBgG3kKIHYjDT3Pvs6RAJMwW
         Gga4Sbddlvy+MkiI5Ue5fY31B8GL9sGCvI/B6fb0QtnjNdRGSAPy0olCbPPpbjGx+YG3
         OqDr8rhQvfWPvJdqoXoXdOV+HcH7PlSi+WyQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795883255; x=1796488055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8I3IwqV/dezd+UXbvTY+DtjOPTO6IyH1DCZFseY3stQ=;
        b=XrKGQR0HiiC1WBXUUxCaGguEvKOkASHphggf80JOtJbiahzAe6H1Uo8asVZMQTOQ+p
         F3nf06U2RqXMzTD0rB9sI4JhRIQLO2N1gznvN7qfkfMcMQsD7VnbU0bNp+EgJxomsMfr
         egWuGHPnYuKgTsk9ZjM4p23JjANCAgts53JXkA8qMSyz22Hcj8JO1f9O/J3sp5tyJmVD
         edjxH+r/BQV5OP1hPaOsv/Eq7AONEVMq/HaNDUw4GLGDcKdTTWGRDEKbWv44c1hVCBUW
         rOeQTrSr2OAi2Y7av3/5TuPp4wJJm7HlJI4+tq2ENLSh4Ykf+bBaJlp7TXT5IlmVf8xR
         odYA==
X-Gm-Message-State: APuU4Z/uzUm/TM0g7sF9MY6hoVRm5fDrovoA50KxnCqbqZdWjcZOCuPn
	Q787pt4mseIvEKQom40WuGFd+qia6hoLDutqo3BCnTt/malQgQm5pasL0gdfQDLFxE5BeLXKzBs
	pZsROKUM=
X-Gm-Gg: AZFdTZc80TYI3sxN33vJfUEWgGLpX8yXPSwPU4geKDRH6G87rsryzAAGQmJqDE5upE2
	QSMTACL7OsxGygar/JfdZ9Utxx2TEpIpXaYe1s9EXlsJIfoSm8apVgoRfOeXSduGchTd7rUTXlV
	VVOHzVBubrsp20JEHAL24E5njGyR6Fj455XX43Wzeb1Dmvi3z2zL22RNG+f3VwPoNRbz3gQjivj
	NekQdsrNOgOKKk7SAVBXFZajENvPFhZjkYunZUGhZScCpws4sWDsWpfbDeL+8AgBricE5pLD1nG
	jMV3iCRcqszC6SEzfkI18E9RnBFRTKHCOPC6SCOOKLwE8/ZGB3X3Oh7j4u0H6VQlTOXn8tK7fkW
	wRLzQhJQ3MHu9fkHeAHmGMux4MzkEMx92dhv0petymX+Anlliun/gJa2+H7EmFa8SalwfnnyKIY
	WSnmw9KjcEilFKF4+3SizA+6uHP4SNO15z2rkzxvFsWe1C+aTrrRTja5SLDi1peU+wAQq8sTHr/
	b3S6RoP8StTAmSyOOU37c1aUQsBymui72ja8sbVjG+Bagary1wgjQkVSQrK+Xb5+bbz+tzcHvhd
	pygRzcBEteygM6BfE2NfpQqLKNUHeHtbxK7r5RkXVORuM7gfQm/E/8LbASUJIrXfFin4ieLeuNG
	GoymHRGtXnmPdf5HcEHzOb6gF/NWYKr8U4/fIeO+mRlKh/nJFfxRS
X-Received: by 2002:a05:600c:190d:b0:4ba:2bfc:c8b5 with SMTP id 5b1f17b1804b1-4bb888267aemr572086245e9.10.1795883254951;
        Sat, 28 Nov 2026 08:27:34 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90655f5asm529202045e9.1.2026.11.28.08.27.34
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 08:27:34 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 10/10] ding-libs: Update LIC_FILES_CHKSUM
Date: Sat, 28 Nov 2026 18:27:13 +0200
Message-ID: <9c1310cd1257a9ae70179d20101ac4c2668e47c9.1795882913.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795882913.git.scott.murray@konsulko.com>
References: <cover.1795882913.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 16:27:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5569
Content-Type: text/plain; charset="utf-8"

Add COPYING.LESSER to LIC_FILES_CHKSUM to match recent addition of
LGPL to LICENSE.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-security/ding-libs/ding-libs_0.7.0.bb | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/recipes-security/ding-libs/ding-libs_0.7.0.bb b/recipes-security/ding-libs/ding-libs_0.7.0.bb
index ba612ab..81ffb76 100644
--- a/recipes-security/ding-libs/ding-libs_0.7.0.bb
+++ b/recipes-security/ding-libs/ding-libs_0.7.0.bb
@@ -2,7 +2,8 @@ SUMMARY = "'DING is not GNU' helper libraries for SSSD and FreeIPA"
 HOMEPAGE = "https://github.com/SSSD/ding-libs"
 SECTION = "base"
 LICENSE = "GPL-3.0-or-later AND LGPL-3.0-or-later"
-LIC_FILES_CHKSUM = "file://COPYING;md5=d32239bcb673463ab874e80d47fae504"
+LIC_FILES_CHKSUM = "file://COPYING;md5=d32239bcb673463ab874e80d47fae504 \
+                    file://COPYING.LESSER;md5=0ce682cee9e5b35c71c890b0458423f1"
 
 SRC_URI = "https://github.com/SSSD/${BPN}/releases/download/${PV}/${BP}.tar.gz"
 
-- 
2.47.3

