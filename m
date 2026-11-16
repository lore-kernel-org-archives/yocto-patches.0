Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2507.1794860556185876153
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 12:22:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=FXtRprQl;
 spf=pass (domain: snapchat.com, ip: 209.85.128.54, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso44590175e9.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 12:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1794860554; x=1795465354; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SsLnUdCauqqyqeVi348BmK6DjeaSVWmzAumyWOlPoGo=;
        b=FXtRprQl5xuEjF0Q/yIom2GBjGKVDwBLRblR3VYz0X3cIfaHcHYGs5XtTiWGhtCEHk
         tB2lAQGeQ6puu7XCimskk2rKKXLDjPbx5p5fiPkBmBPXrrT0trGO6FgEhb9zFRffnyLO
         4dB9/BhVYm2dQslpJDkMgJWPEvi+hFVbI4kYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794860554; x=1795465354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SsLnUdCauqqyqeVi348BmK6DjeaSVWmzAumyWOlPoGo=;
        b=u/sGaKn9RGAUbYkSUMgFvK8SuQ4QmtUs8WdfRGKm1dVxqnc72u4RSxTSomRg1PDXdZ
         Q5rVv2H5v5RA3lkdERFM1DoNGCTAm7rrS1wk2ZtKlJquA2OBT3djwKvjokDKeUppYCzi
         pZhO6pR954pxnPfwd/V7K3ZbevvsIj2Oqe0fd4oBrqSJvC0W6fDYaioxBw91L0DiCyfA
         d9DW1PVZmArgd+KsIIe1TCRVmEazz+AstThVJi+gXEcRGW30VNYiQ5y+ymweAnbmAAnW
         F3rETOCeIq5qIm2QORvmkHtMl0mrhaDG6WoCdR+maPt9pfxCPlUZieYYxibFF54Y+URO
         oMiA==
X-Gm-Message-State: APuU4Z9sp3tWdyrjs9MwT+ibPcmVRv2/ZRzxBIlns0lZzx+qp8Kre+kS
	idso9eflViBnANKmKIOupVmY5ZxJL4wXl1dAM8NM+Th0o0dVACd6e0J8JShZFpMxPWgTvlxwXuh
	y3G3wU1Q=
X-Gm-Gg: AYBFou2tWAV6BvnnGvq0xfI94F6Ool0IZQNFpDtv5kL7J71oX8KSDtG7ZEGFED5ACkD
	ZiDPk1M/5ctiGA00sN9Y77mFlZmsIqxAjyJ4oZqL7hzaR9KSCRHJa3BAQjrV3yLEryhiq3bzf4O
	MmpCAoHCG0ZyLETEd/8WWWtvOY9gQa9gHY3tAgeSlXBEmE2Q7HGJg+m6YvuTlzEKKLQYbJWk487
	nk7KlWIqddSnYNT5DLJjpzRPgfRgX6qjMc2XiCNls7QDPYCgfZ1hKGZ2jSuFdhzxUmk3wyg4aaf
	EUq+4VrXkbP48DmBb1SonuboqAdgfyTf7vJTVOrGRDDRrN/JH2WeuMKqITbJ16QFNJVa2Rv+ZeZ
	BBzAVnegIDWkVC66jADz+b2k2Ddo6BOX0lvZmQor9PetXQk2p/XJIuGLDSXu0fGHorcj2vx+unS
	3e7SwfWmaU8OjvfSqBryTAAYn7g3zjr8YVu3H3/zvRPoxgjwq1A0zr2s7mjGpWxRx/G5+mhQ4Kp
	aL72Nzlg366T21QUkO5EcwKdpXhvwyeHjsO+hNc6AZjQUIt/7sGgwTdV/+Zdje7p/L3kItac2qA
	5zi5iFCjdOlscCkIMd8udRtgkTXyquksIDmreFSvpJldVkrj+IgoEL8Exdw4NLwb6Q87ah9490d
	qDPdqdg4KNg5VCUjYVs/skcgZaybgw4BGLn81/Q+rs7P/OGwUD92hjx1zrV1W843jqWNwQbmbeW
	0=
X-Received: by 2002:a05:600c:482:b0:4a5:75d2:c104 with SMTP id 5b1f17b1804b1-4bb55a59c9dmr182886935e9.22.1794860554279;
        Mon, 16 Nov 2026 12:22:34 -0800 (PST)
Return-Path: <ecordonnier@snapchat.com>
Received: from localhost.localdomain (80-108-196-96.cable.dynamic.surfer.at. [80.108.196.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78430918sm10724165e9.13.2026.11.16.12.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:22:33 -0800 (PST)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 2/5] darwin-common: disable debuginfod
Date: Mon, 16 Nov 2026 21:22:20 +0100
Message-ID: <20261116202223.654-2-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116202223.654-1-ecordonnier@snap.com>
References: <20261116202223.654-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 20:22:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5421
Content-Type: text/plain; charset="utf-8"

From: Etienne Cordonnier <ecordonnier@snap.com>

debuginfod needs elfutils, which doesn't compile for darwin at the moment.

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 conf/machine-sdk/darwin-common.inc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/conf/machine-sdk/darwin-common.inc b/conf/machine-sdk/darwin-common.inc
index a23c605..6c8a85a 100644
--- a/conf/machine-sdk/darwin-common.inc
+++ b/conf/machine-sdk/darwin-common.inc
@@ -44,6 +44,12 @@ BUILDSDK_LDFLAGS = " \
 
 MACHINEOVERRIDES .= ":darwinsdk"
 
+# debuginfod needs elfutils (libdebuginfod/libelf), which upstream only supports
+# on Linux/glibc hosts: its configure fails on Darwin (e.g. the linker has no
+# --build-id and there is no readelf). Don't let the distro's debuginfod feature
+# reach nativesdk recipes until elfutils is ported.
+DISTRO_FEATURES_FILTER_NATIVESDK:remove:darwin21 = "debuginfod"
+
 TOOLCHAIN_SHAR_EXT_TMPL ?= "${DARWINBASE}/conf/files/darwin-toolchain-shar-extract.sh"
 
 SDK_POSTPROCESS_COMMAND:append = "${@bb.utils.contains('DARWIN_INSTALLER_PKG', '1', ' create_macos_pkg', '', d)}"
-- 
2.43.0

