Return-Path: <akash.hadke27@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BBCE77197
	for <webhook@archiver.kernel.org>; Thu,  9 Jan 2025 10:47:08 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web11.45358.1736419622780657511
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 09 Jan 2025 02:47:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Nd81dyMF;
 spf=pass (domain: gmail.com, ip: 209.85.214.171, mailfrom: akash.hadke27@gmail.com)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21619108a6bso10973655ad.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 09 Jan 2025 02:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736419622; x=1737024422; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KMB4Ii1DEiamuQ+abGd4Y9gDv/ayPAASwA4d/Njxysc=;
        b=Nd81dyMFjcAvOJhLAV5BaL2NIVlM9UlZ+saQL1v/Dd4kMwyBa1CyslH1/eBIb012JD
         icMY1zBrSVt6bqQqudc+SVxoXJSH0KKNr8jmpW3c4MyJNOPl4MooAOkeffpm+I5v8Njx
         t5I6WVnwz/y+n0eQNC/exFBCsj6F24jD2gWGFXssGlw1lrmXCRoYEI4x5VGwqGFCAEfS
         9xPEy5PbdcwuiiM8gX1nI3E83ejWdSeJnqWggOGJFiYnX51iCBuaMvgEJlhgWMKTBzB9
         O9cZwtJkWxlVR2brBc3mOKQfEQQXe/CTWTVLj/iRXLUn5LtyYP3m0NcZ4J4gzZNefwlj
         oAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736419622; x=1737024422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KMB4Ii1DEiamuQ+abGd4Y9gDv/ayPAASwA4d/Njxysc=;
        b=Gf2JBi6h9pdK+QCZGb9L7r4iwZ3tetwoEeBnJdsciBML0O1HXGJtJnztVE9ZEqewLt
         xuBz2sGJuIf8Cux+jSYE3JBTaMozK8kwbmOBiAh75s6hDjgm6V/ZCrv+haPlxk9YQGJa
         DuiBEe9KD3uS7FKLaPcCCXJhf/1TRPr180U5RKUWxFDlXI1WkbD1t5I86m8pC5/V/G7O
         5lJRWR1AZObVk334Y3suO/8YzPByhde+2OWRvXvp7mpV0+dvUq5Lnmi8V/GwLyuWcpLF
         BEiM393Eq0JUHlO4KdbvuT0UIYRtodw2W/oxBr5YEwEeTlK3fQNvnQ8/On7w1fq+iNZl
         SHCg==
X-Gm-Message-State: AOJu0YxkLOC5s8lZTNqb57Q59Z2rjbKWO6IvmoaCYru5GMrAaI0PwVBg
	J1wD/5+cQwn8FsSvgkc6MCtRovf/K1d95gr7kERcGt6F9CYi6KeULgNvhEVW
X-Gm-Gg: ASbGncsFxDMo1EDOL3VQ93u86Cnw/YhS06d0eQQoMk7lD25HxJLwuTU4cWzlpenmsuY
	/4wI5XXA055o1iBnZJuw0fC+Fp9awaXNAqSmdDnpIK59KRiNZ6mTBdUYixaFPe6uzjsPsqrjDdH
	sXIPcx4ArrwsI7ifkjFTO4cumdfNmkU1yKE2IK6v4M/GzjqZNmezJEI8C3aAkYsRzJel0k6u6/2
	T2SFmGlLK8pmriJRB+iVhqARr01fARj4AHtFc5M75xuADCBnF/3I6egKnnWn38f
X-Google-Smtp-Source: AGHT+IFsBDusLeSCvLFdBQOwTSGSmusF6tW31xgJtRAIkHWGePEkF5DzqYqyfNlRMpNPvk4J23xLNw==
X-Received: by 2002:a17:902:f549:b0:215:6b4c:89fa with SMTP id d9443c01a7336-21a83f370a5mr90561285ad.8.1736419621688;
        Thu, 09 Jan 2025 02:47:01 -0800 (PST)
Received: from L-18010.kpit.com ([49.36.49.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a83bf1145sm29759905ad.159.2025.01.09.02.47.00
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 02:47:01 -0800 (PST)
From: Akash Hadke <akash.hadke27@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][scarthgap][PATCH] meta-security: Remove True option to getVar calls
Date: Thu,  9 Jan 2025 16:16:53 +0530
Message-Id: <20250109104653.61469-1-akash.hadke27@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 Jan 2025 10:47:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/973

getVar() now defaults to expanding by default, thus remove the True
option from getVar() calls with a regex search and replace.

Signed-off-by: Akash Hadke <akash.hadke27@gmail.com>
---
 meta-integrity/classes/ima-evm-rootfs.bbclass                 | 2 +-
 .../recipes-parsec/parsec-service/parsec-service_1.3.0.bb     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/meta-integrity/classes/ima-evm-rootfs.bbclass b/meta-integrity/classes/ima-evm-rootfs.bbclass
index 7b73373..8b2e767 100644
--- a/meta-integrity/classes/ima-evm-rootfs.bbclass
+++ b/meta-integrity/classes/ima-evm-rootfs.bbclass
@@ -59,7 +59,7 @@ ima_evm_sign_rootfs () {
     #
     # Deduplicates iversion in case that this gets called more than once.
     if [ -f etc/fstab ]; then
-       perl -pi -e 's;(\S+)(\s+)(${@"|".join((d.getVar("IMA_EVM_ROOTFS_IVERSION", True) or "no-such-mount-point").split())})(\s+)(\S+)(\s+)(\S+);\1\2\3\4\5\6\7,iversion;; s/(,iversion)+/,iversion/;' etc/fstab
+       perl -pi -e 's;(\S+)(\s+)(${@"|".join((d.getVar("IMA_EVM_ROOTFS_IVERSION") or "no-such-mount-point").split())})(\s+)(\S+)(\s+)(\S+);\1\2\3\4\5\6\7,iversion;; s/(,iversion)+/,iversion/;' etc/fstab
     fi
 
     # Detect 32bit target to pass --m32 to evmctl by looking at libc
diff --git a/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.3.0.bb b/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.3.0.bb
index 477988e..6887b9f 100644
--- a/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.3.0.bb
+++ b/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.3.0.bb
@@ -27,11 +27,11 @@ PACKAGECONFIG[MBED-CRYPTO] = "mbed-crypto-provider,"
 PACKAGECONFIG[CRYPTOAUTHLIB] = "cryptoauthlib-provider,"
 PACKAGECONFIG[TS] = "trusted-service-provider,,libts,libts"
 
-PARSEC_FEATURES = "${@d.getVar('PACKAGECONFIG_CONFARGS',True).strip().replace(' ', ',')}"
+PARSEC_FEATURES = "${@d.getVar('PACKAGECONFIG_CONFARGS').strip().replace(' ', ',')}"
 CARGO_BUILD_FLAGS += " --features ${PARSEC_FEATURES}"
 
 export BINDGEN_EXTRA_CLANG_ARGS
-target = "${@d.getVar('TARGET_SYS',True).replace('-', ' ')}"
+target = "${@d.getVar('TARGET_SYS').replace('-', ' ')}"
 BINDGEN_EXTRA_CLANG_ARGS = "${@bb.utils.contains('target', 'arm', \
                               '--sysroot=${WORKDIR}/recipe-sysroot -I${WORKDIR}/recipe-sysroot/usr/include -mfloat-abi=hard', \
                               '--sysroot=${WORKDIR}/recipe-sysroot -I${WORKDIR}/recipe-sysroot/usr/include', \
-- 
2.25.1


