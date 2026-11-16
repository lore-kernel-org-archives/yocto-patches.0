Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2406.1794860554839526611
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 12:22:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=PGpUogdr;
 spf=pass (domain: snapchat.com, ip: 209.85.128.46, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so14610505e9.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 12:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1794860553; x=1795465353; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZvfK9DKFGINryZm1itVPmloBLih5sCQVd+50gFC/BZY=;
        b=PGpUogdrzMdH4g6gk7uSPS2j4nbOU6S0qQ3H2p5l4l5/rSZoeB0dIc8Bosd9NhR3Q7
         +PnqDP/j3z6weJ+KqY1rfCpG5Eg+DdlSiNgkWGoWzQAqrUsyN7mHK7aeQZPjRqAzcpS+
         czjSCjL1ZjQBbzACMEfH7LSYQ0gKdC3cq8QBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794860553; x=1795465353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZvfK9DKFGINryZm1itVPmloBLih5sCQVd+50gFC/BZY=;
        b=KpG8na156asTp6RJSuNkohpL9S8Vi9/Fy9pP+1mLaVk7+3xEH7EkRGKbFuxvOfSdmf
         pKrJlQNPkD6l88ZRewd4qTmMGvz1pOAw/SbB8rhXYqL65GkGAuiX7FbA4PTYTPqwW5vL
         gjr5n/VdUt3rfXyK3CZYeUgTuDngsoHSnIL9DUhhD+qKM0UPIP6khRj24D53XOV9k8Aj
         SGL0VjTIM3PjMjfOWA12e7M7YCXkOyo53zEo3kt6Jic0pWqi+Q9GAd3C/i79aZXKfjZA
         QN0jFwBzSyzUNwaRY4VRes7+9j0F3p8jwLddl+JdnkT++5DPn9ouvC8TR7XbSbOu2J1y
         5OZg==
X-Gm-Message-State: APuU4Z9hsLnRK+SZlrOwHuwz1zxiF5VGlRHR93TQvFMVuGwCDIbevh0j
	DxHYuPGR3++XAo/IK91STJYUvqP8RVlTxA+h40qrocLtn5g4N/c1b676J52uW3m29zMGg20QhM8
	TneEMshU=
X-Gm-Gg: AYBFou2VgeDXICjqqebkJ6IYgfZ7UdePAUwzAwA28YceuG6yOZGNFm3AdjXfksfPgt1
	o4VsfWACZ1FKeOYEQ7fpaXUwnkdoBpH2h9kXSIRbOdvhYuSfu/+5nwRf0gs/+rAiGqQ2C6GPAIc
	WspxGk256OGITOGaVjUT0/Ya8Jh6CdxFoLWAk42nWmCnk/XnieQxLWBhxn72VKWh6URlvb0Bdvv
	RkSxLPwzThjCDaFmw3YckOrdlWFlbGOaefWzM7yMiA3pIh0B8CoPDxI2SGbi9fs94BWw6AcxBqu
	9dhHnDv8gvdo6qhnbe3UdsUgEwthYRYpJAlN0+r6Ma5NCG3ruqItLgRYPi+3RUBgi1SLeJaIg4i
	edmIKYpoRC4KzM2E2BpcsaBy0SYa+hdJyfUft737ki0FrXvipwdDBYcvR4v6+uLHFc9C1Ur+aZK
	h7VOeLQkOTy7yK030M9sRcuRquIHtQT2beND95nHctdU+ITzvG8HkyUz28ywqoZ5uXqmGWRaCJL
	mPfcS4Gr5cRbwhSFKANz7nfYC6ZAzc1+jlG7lkBIp0YgVjqfpMKlWw+YIZ/fwhOEF2BVoj06EJw
	N3B//NpUPSmfa/bNU+ckKf5k9p+Zaw3tw3jAQ5nPU6ZsBtK8W0kEZRCeLw+hYVcJ5HN5jM+/GoE
	U/KvysPfAgXEFmjLfeUmqtijYRFF0JuUlPXo7guKUSsuB5FOP4c/i8OrowQOGyJbxcb2u+dgw7+
	4arCv9a2ShnH2NWy3XWmH0
X-Received: by 2002:a05:600c:46d1:b0:4a7:7f3f:6f8e with SMTP id 5b1f17b1804b1-4bb76d62556mr46641865e9.0.1794860552849;
        Mon, 16 Nov 2026 12:22:32 -0800 (PST)
Return-Path: <ecordonnier@snapchat.com>
Received: from localhost.localdomain (80-108-196-96.cable.dynamic.surfer.at. [80.108.196.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78430918sm10724165e9.13.2026.11.16.12.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:22:32 -0800 (PST)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 1/5] file: disable lzlib
Date: Mon, 16 Nov 2026 21:22:19 +0100
Message-ID: <20261116202223.654-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 20:22:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5420
Content-Type: text/plain; charset="utf-8"

From: Etienne Cordonnier <ecordonnier@snap.com>

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 recipes-devtools/file/file_%.bbappend | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 recipes-devtools/file/file_%.bbappend

diff --git a/recipes-devtools/file/file_%.bbappend b/recipes-devtools/file/file_%.bbappend
new file mode 100644
index 0000000..7324ecd
--- /dev/null
+++ b/recipes-devtools/file/file_%.bbappend
@@ -0,0 +1,5 @@
+# lzlib does not support Darwin: its build system hardcodes ELF shared library
+# naming (liblz.so.N), which doesn't match SOLIBS=".dylib" and makes
+# nativesdk-lzlib fail do_package with [installed-vs-shipped]. Disable the
+# optional lzlib support (lzip decompression for "file -z") on darwin21.
+PACKAGECONFIG:remove:darwin21 = "lzlib"
-- 
2.43.0

