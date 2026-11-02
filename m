Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4368.1793659687279540128
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 02 Nov 2026 14:48:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=mFzXZ122;
 spf=pass (domain: konsulko.com, ip: 209.85.128.42, mailfrom: scott.murray@konsulko.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so36748095e9.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 02 Nov 2026 14:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1793659685; x=1794264485; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=62N4e2CYymCMwFaAsxlERSQjEIhU3OXXzyfUTcSfN3c=;
        b=mFzXZ122Dx6XOF7NraWSdy8crdOAlJmOA42a6EZR2rTfAD4V/M0ocd2fL+JfOUAxVS
         8yW3yfKtVN/Yww4MDAmKAaA+Aqq0RILGP5LeHGDUhIThKjtCNck4FdT0jwuAYkqnQLLo
         RzS5ys7C5sh1Xql4LG8+pD6xKja0CrPIUC3S8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793659685; x=1794264485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=62N4e2CYymCMwFaAsxlERSQjEIhU3OXXzyfUTcSfN3c=;
        b=bnSM2iY0NrCTdIolsCsZKeoXT3dlPtKwA24UeaGRLoXA0g2D0K7/ZQ49lY2103yIXs
         ULz92rkdjfhevNqxBOQe2/KGqEhLNIKoz8P2G/MvLgB9aC00sS6uqBpzBckkDUPeAX9M
         0JxtFHwMh/PRWuSrWZMCZ0vVLgrRZDwl6Z5aXaZ1qgtEtwJWI+2BxfB6uG11H5FbzE5z
         oR5kEkUFu6PkYsNV+phKhw9dcd/I19KhM/Gzn4nlLRSI4/g6KMqaer1xCfeBGV4sMniy
         XAoVubFTii2D7J1AfVWhHIImtTPnGesqSeBMetCirUOY9bAMN+ImdGD0w+CY3F5IU4al
         DhWw==
X-Gm-Message-State: APuU4Z/ZhCbMdmcOp70LFdStY5G/66TpD/37LEAbd+vILx9lYs+rGANm
	x/KxrX5aTw9VcslH2UtrtLEhCzRt01eic6/PjgXb0WjXjrE6FbdvWnNI9VqDMkPYglUp10tqwfi
	XIppEnIo=
X-Gm-Gg: AYBFou007INbl8km/mNlQyaFfr5ZKIH8rxjLKMuVCEhkooPq1DBT76zOF+OKNnmsDAo
	1vRL1cymRe+AmNgzYoqwM0ek/d3L+as+UxLNFevh3caff6zo9UlUXKHoCUYmVKfQa7hUN4At90J
	fVWXK9K1OnUP+vpAnZK2tuVFA3QTJHHTyHtxAX5wM2huhdMk8DvpMxZgzCWaX8LFelhMthGbs/G
	Cf1S2Nt34JyreRsvLrW7cdFC2o9DKH3VfBBxT/2bn3ckY5a4DzJ4fBCsRRAeFzMd9iIRcbl6NkD
	9Nw7UVf2QSkXFusyF3+Wx4fh/PoflcwE3FEnQ97VAeJn79MvWLicQQGUF2pUxwXussZhZ71Zbu6
	cqQ4pcqiM6etwfpuW1evioGJq66QlojwP5hssPmRlw+lkYnpLs6KyZa3ZrHrPvFqqnkY5ZOTL91
	hdlPKoOG+K1+qux7LEidmU/VYvM+yXR2kDhn1HFrFKG1YCWVRYnKLCg7VWU35l7ZqNRUE0cZtwG
	WfdL5umcmjpS+NMRBwtPh2NitpgXCKjGR69VRoaRTCWxO4Vs8nFaiyhtcu6k6/gJCSlWy96YqiL
	jWhm+ET4kCX7y8Jhc7GuDc9NYObQVKIDru9ap/JiLteNTeOWZyweBzLiWeynLFf/VrT+IX3YtE/
	63sWXkDKKa2D6JktanrLu3jE1YIhh/A==
X-Received: by 2002:a05:6000:2805:b0:48b:4c8:7b07 with SMTP id ffacd0b85a97d-48e6e306d31mr18168102f8f.52.1793659685214;
        Mon, 02 Nov 2026 14:48:05 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71ba7168sm23770828f8f.55.2026.11.02.14.48.02
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:48:03 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 1/4] ding-libs: update to 0.7.0
Date: Tue,  3 Nov 2026 00:47:45 +0200
Message-ID: <8865b29b22110e49b6197159a67ef85ac3b12f9f.1793659376.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1793659376.git.scott.murray@konsulko.com>
References: <cover.1793659376.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 02 Nov 2026 22:48:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5209
Content-Type: text/plain; charset="utf-8"

The download URL being used for a ding-libs 0.6.1 tarfile is no
longer valid, so update to 0.7.0 using the actual upstream location
on github.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-security/ding-libs/ding-libs_0.7.0.bb | 11 +++++++++++
 recipes-security/libdhash/ding-libs_0.6.1.bb  | 12 ------------
 2 files changed, 11 insertions(+), 12 deletions(-)
 create mode 100644 recipes-security/ding-libs/ding-libs_0.7.0.bb
 delete mode 100644 recipes-security/libdhash/ding-libs_0.6.1.bb

diff --git a/recipes-security/ding-libs/ding-libs_0.7.0.bb b/recipes-security/ding-libs/ding-libs_0.7.0.bb
new file mode 100644
index 0000000..ba612ab
--- /dev/null
+++ b/recipes-security/ding-libs/ding-libs_0.7.0.bb
@@ -0,0 +1,11 @@
+SUMMARY = "'DING is not GNU' helper libraries for SSSD and FreeIPA"
+HOMEPAGE = "https://github.com/SSSD/ding-libs"
+SECTION = "base"
+LICENSE = "GPL-3.0-or-later AND LGPL-3.0-or-later"
+LIC_FILES_CHKSUM = "file://COPYING;md5=d32239bcb673463ab874e80d47fae504"
+
+SRC_URI = "https://github.com/SSSD/${BPN}/releases/download/${PV}/${BP}.tar.gz"
+
+inherit autotools pkgconfig gettext
+
+SRC_URI[sha256sum] = "5df2f202f892b4c1a6caf87f0056398a8288b281da9d7e65cd7637978ec20ef3"
diff --git a/recipes-security/libdhash/ding-libs_0.6.1.bb b/recipes-security/libdhash/ding-libs_0.6.1.bb
deleted file mode 100644
index 843850f..0000000
--- a/recipes-security/libdhash/ding-libs_0.6.1.bb
+++ /dev/null
@@ -1,12 +0,0 @@
-SUMMARY = "Dynamic hash table implementation"
-DESCRIPTION = "Dynamic hash table implementation"
-HOMEPAGE = "https://fedorahosted.org/released/ding-libs"
-SECTION = "base"
-LICENSE = "GPL-3.0-or-later"
-LIC_FILES_CHKSUM = "file://COPYING;md5=d32239bcb673463ab874e80d47fae504"
-
-SRC_URI = "https://fedorahosted.org/released/${BPN}/${BP}.tar.gz"
-
-inherit autotools pkgconfig
-
-SRC_URI[sha256sum] = "a319a327deb81f2dfab9ce4a4926e80e1dac5dcfc89f4c7e548cec2645af27c1"
-- 
2.47.3

