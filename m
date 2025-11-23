Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F6ECFD342
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 23:45:33 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5041.1763941533025957844
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 23 Nov 2025 15:45:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=DhLAUcUz;
 spf=pass (domain: konsulko.com, ip: 209.85.222.182, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8b2dcdde698so560430985a.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 15:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763941532; x=1764546332; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zmlzo+NDmx/qphuzY7X0BQZMShXeJivTAS5UUPo0tc0=;
        b=DhLAUcUzucCoQE8xhHVLZ+RRicVmYhYGagH25HV5JpZUzsEqAg84MNH/Ney23v2kbJ
         2klS034jerRUxQP00DEZHKMHbf/YpwNe8gRxEdH2TixVDmMKtcpdXjU82qRbCPxMKx4U
         BBX1aiqM/khIcbrFPMofG/tput9V62zsVqTz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763941532; x=1764546332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zmlzo+NDmx/qphuzY7X0BQZMShXeJivTAS5UUPo0tc0=;
        b=BXvHpns5A55l0UVLY5/Mpv4VKzZepUhFE1IVZ2mguB+GXHRMt912dOUK/ALkaIhFw4
         Cu15SQE9lc4RW5c7LLS3p8Rk25774jcv6ieiavsPvMna9JXBwRQ0WEKO2PU3B3+IL41I
         dDwTS9qYEXdgDqYKIM66d7sx5XJ3Xbk9SyrXGBXu1q/NT4an765DjUcaBXdp62/e1Z7B
         d36ToXGOkmCsbTGMJO9DJsMJALU8/9TE5vb+7ZjYTpnZEKYoySBNPtdXnjy0V+PFiamX
         gTvAfPmSh4HmzlpY8gmbthdzm9aATExlTuH+jboeOogAATI+vp3ZPB1JbBcRtZetl3Pj
         gldQ==
X-Gm-Message-State: AOJu0YwbGjFUrw5dHS10VLM1mZIeOLqM0EYtWnTpFPhxzuCyjQOez8rA
	TWOjj6wOmiUtMZQvFUnATIrX/h3oeoD7GMlo4QgZ6O1iflI/nFZqDg8NLnxpqmLHTBZCX64RJiq
	7yRd5
X-Gm-Gg: ASbGncuTuEVbG7gjbStPG8N4hEliFOfVFAXnvaqtMrwUg+SuCme226aBu7GNUjpHZqo
	8o70TOE6lJapo/rsZ1GJql3bCAdEQ09S3YBaIH2SoTvdKgrqFfj3iuwGqPrzpvHJoc4uXVrDt+u
	h3iLU5aYshJZ7OKiUAWtcbeMh0v80a9x4NsmUHV15+Ehz7H5PPUluw0Vu1d87mlqww8AZ+ljxq0
	ygM1/GPUMZjBc/Kcd0xQ1zTkNXDA37RILCrse0w2nvVJuvgX7Aiy/COCPjFmv/VKlXnXADWkrp3
	xKeI15Ausnlt0nmqUkxoWxMVEr6vhKZ4poI//MXR7KfzZ+zplzhtO9AtIzno14oRSHtV/9mg+d7
	ifkBBvinTUL9H/gaNkA7F4WdirvR0MQ3yGl3GDq+IzeJVwFBLd1WRN52++BuavMHxSKh+Ljw/Dl
	j4fkvebZXKQ7zqTRT4B9ind6rTJ5lgHlGDp3O+CWVhT8VavRJ868eDEChpAA9jlwM=
X-Google-Smtp-Source: AGHT+IHjEaXcxNkPfuEGDaeAbonAce1O2tUJ0WUJJTU7x8S2zdECwgS1ddgBp5jp3H1208fp007wAA==
X-Received: by 2002:a05:620a:2915:b0:892:63c8:2861 with SMTP id af79cd13be357-8b33d211259mr1114535085a.40.1763941531629;
        Sun, 23 Nov 2025 15:45:31 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932db59sm843706585a.1.2025.11.23.15.45.30
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:45:31 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][scarthgap][PATCH 15/32] meta-security: Remove True option to getVar calls
Date: Sun, 23 Nov 2025 18:44:55 -0500
Message-ID: <0b3cb32abdb35a774c6c11611720f2b19987af19.1763938436.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763938436.git.scott.murray@konsulko.com>
References: <cover.1763938436.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 23:45:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2673

From: akash hadke <akash.hadke27@gmail.com>

getVar() now defaults to expanding by default, thus remove the True
option from getVar() calls with a regex search and replace.

Signed-off-by: Akash Hadke <akash.hadke27@gmail.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
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
2.47.3


