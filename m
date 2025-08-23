Return-Path: <vince@underview.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE876CA0EE4
	for <webhook@archiver.kernel.org>; Sat, 23 Aug 2025 19:19:15 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.web11.3364.1755976745853452356
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 23 Aug 2025 12:19:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@underview.tech header.s=google header.b=Gxu5OqrB;
 spf=pass (domain: underview.tech, ip: 209.85.219.49, mailfrom: vince@underview.tech)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-70d903d0d59so11945206d6.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 23 Aug 2025 12:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=underview.tech; s=google; t=1755976744; x=1756581544; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNcIK5qUZ7p60Btr2yclWntZ+/2R6GMNHThw4jXm8yk=;
        b=Gxu5OqrBevCYZ0GgyW2oIps/Agh754CrRzZWS0Txp1LW9qOMTfU6luL+OWRl3K/sVi
         Em/5GJYxDOT5N87FmWnzCjtN00gDYHFis3x+5wQRAcf5/17SvzGGiirTMmP7HvZI0gGC
         hRfhizn7rBHUbi8bJ6X4xSFSBA6eiYYCIfUrR7ykKBzVmlLmfwEu8JLdQbQuBLeyjBIi
         doLhXilrM26rcILLWAf/COtPCQIxh4VPJeuGijoeqrUbVzhubzvHDGpHObBofdfG5GZy
         7DCNyQgJ2EIb73x3+YGKdByfIPwbIlitL3I2LGczL1YPUgxEhY4iASRvJkVN0TnJx7jv
         HrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755976744; x=1756581544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNcIK5qUZ7p60Btr2yclWntZ+/2R6GMNHThw4jXm8yk=;
        b=lN2PQ2m686BBtIqoaJ0GUX97vrNWaV+mK3pQUoKm2g51TzUmUVrHIzuXwDZ3/13f5y
         5gBI/OxKxGQfZ7iUhksmCYfnMKafMMerY1qYuAZjLywogOWRNAMWfDVCmtEYzByeOWP2
         VcvgZXPjHNJ7QsyWZ29r2mDK891O8y5eidt2dArMPIf2DRfe5cqgij5mDUhWTCX4X3Qq
         raHJXDrMOsG8ZdjEmpMCUxvuA6zLAnApzXM/wm1xZO/rCDn6cLbzSpzQKPnw7QX++ske
         8h7xuiLYBFoi5j/CqOchdLOhzOKtitmzdFGEkELJHxTh/PAUBl2NG1YYES++ZEqU0zYL
         rOXA==
X-Gm-Message-State: AOJu0YxUnrmwItv/QcdcDu9rxKXrgd3dUmr0q3ze3cOxlHchTfLFKNOw
	NZPRrt9ghGn2vFg6P5ToFogPBp43aGoUl/MV0Gdn1z4LwFAF6B5xNhVgI1GhzTqDXqhQ9v7YxPZ
	X+63N
X-Gm-Gg: ASbGncvYiHrKq+mtDIYjXSgXVrGFTskdAYaw8lGg4kdWH0vMtk+u0VZiHEObg/BpJfx
	IU2ToPgOQ91NJsBYZf6Ssj2LSGeBJY0TofJd4xjYAbtwYhu7tDsPrSSYwkEInd8YHaRe+qa43tt
	F06vY5RGGGKVH+k1KvaV4/pFqe9mJRReilX3BRBPlrm+vglk1vjyaGhC9a8Ux3Q/kStsgGs5UTp
	f8KoGryB4plnALWfurhN+1+O23CzbHfzHTE9QBGsZzERqrc6nhdgs01a0a5r0tZ5+x3S8M27C2S
	BB/e6vd8zzn7PUa4iGYoxZknWX+M0ezNvciqh1AaU1RAKkG6J/FSI/UE6A4Aa17bD3Q/8ZZWVl0
	qwbWBEnVuHg9YnHVeDskD7g==
X-Google-Smtp-Source: AGHT+IGlwc1/zZtjBmxpI+5aArgaoYPNz8CkfF5b64Iku8fndh0ef2I6rk3bzzjFncfnCDDC74Ys0A==
X-Received: by 2002:a05:6214:5191:b0:70b:ca6d:24fc with SMTP id 6a1803df08f44-70d972c5165mr78383466d6.24.1755976744527;
        Sat, 23 Aug 2025 12:19:04 -0700 (PDT)
Received: from vince-server.. ([2601:406:4d01:1820::6d26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da714727csm17583436d6.13.2025.08.23.12.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 12:19:04 -0700 (PDT)
From: Vincent Davis Jr <vince@underview.tech>
To: yocto-patches@lists.yoctoproject.org
Cc: Vincent Davis Jr <vince@underview.tech>
Subject: [meta-selinux][PATCH v2 2/2] selinux-python: fix No module named pip
Date: Sat, 23 Aug 2025 15:18:57 -0400
Message-ID: <20250823191857.602063-2-vince@underview.tech>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250823191857.602063-1-vince@underview.tech>
References: <20250823191857.602063-1-vince@underview.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 23 Aug 2025 19:19:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2082

When running the do install task run
into No modules named pip.

Add python3-pip-native to DEPENDS
so that pip it available.

PREFIX variable not being set also
appears to effect whether pip is
found or not. No reason was found
as to why that is.

Signed-off-by: Vincent Davis Jr <vince@underview.tech>
---
 recipes-security/selinux/selinux-python_3.9.bb | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/recipes-security/selinux/selinux-python_3.9.bb b/recipes-security/selinux/selinux-python_3.9.bb
index b452887..88850ad 100644
--- a/recipes-security/selinux/selinux-python_3.9.bb
+++ b/recipes-security/selinux/selinux-python_3.9.bb
@@ -16,7 +16,7 @@ SRC_URI += "file://0001-sepolicy-fix-install-path-for-new-pymodule-sepolicy.patc
 
 S = "${UNPACKDIR}/${BP}/python"
 
-DEPENDS = "libsepol libselinux gettext-native python3-setuptools-scm-native"
+DEPENDS = "libsepol libselinux gettext-native python3-setuptools-scm-native python3-pip-native"
 
 RDEPENDS:${PN} = "\
         python3-core \
@@ -111,7 +111,9 @@ FILES:${PN} += "\
 "
 
 do_install() {
-    oe_runmake DESTDIR="${D}" \
+    oe_runmake \
+        DESTDIR="${D}" \
+        PREFIX=${prefix} \
         PYLIBVER='python${PYTHON_BASEVERSION}' \
         PYTHONLIBDIR='${PYTHON_SITEPACKAGES_DIR}' \
         install
-- 
2.43.0


