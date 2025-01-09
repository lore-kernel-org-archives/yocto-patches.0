Return-Path: <akash.hadke27@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E6EE77197
	for <webhook@archiver.kernel.org>; Thu,  9 Jan 2025 10:44:08 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.45333.1736419446341219062
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 09 Jan 2025 02:44:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=e+n2IOyw;
 spf=pass (domain: gmail.com, ip: 209.85.214.178, mailfrom: akash.hadke27@gmail.com)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2162c0f6a39so32852555ad.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 09 Jan 2025 02:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736419445; x=1737024245; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GW38dDrs2+R9UqU0suVkLp1MslExMOXzY1xAUpBFrQQ=;
        b=e+n2IOywrlCjBdKeb6bIruJdxIpFkkL2BwH/0dRd2oV3Nr+VYwzMVJ5a+/o3gF3blK
         PdUknhF4l+Q0RoATQCeF6nfgpdA+LXiDSSpXqx3jwFsgamax8ejbnRpGBttDTXfhZXKc
         imo+AlO9kHiE0J/1fGblWwN4B/Hrv4jGRNg9+mhT4XDjqbjdCL2Wfl+yANy23Y3GcSXm
         xgOmiVCew6b8vBG9l3s+UCm+2ffB3WJtQ46k3L2G79EEANDs3rln71gnRUDlpHYiqQx3
         ExeuQg4Cmx65ZcVzKu8j+ymCseH5yLY5uPawMN7w+slaeZW6I65LQsdLi6ayP5Dpop5q
         +xsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736419445; x=1737024245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GW38dDrs2+R9UqU0suVkLp1MslExMOXzY1xAUpBFrQQ=;
        b=t8iuRcccDQ1rPtWBznVBwRHL/lyvPNwpPIi1ad/5fwGZZHjSV/sUXBN/tVhDqn71FZ
         f8l9x2hnfyETne0NBIPhWydRXYL19EODN4RNO0LqENLj7RWtOKb6fmozjOjaWlvewmYd
         BQWiQa4omB7txCNRAEwroYvVFB5OaMBaMUCFDkUkh0JrXjb7kgyn7GYDe20WM2ykgtux
         +AU05bww372cFMN5jb7Hrr7Vclb0JoYM3zVAKyFHVuU2hHHxGY1PQVD0xy8S3CeH8oko
         isovuOY9rr253C+8rTGdeJ5QSaM26x2ykou6XA0/7thVyCaJD4kNa7AyYhWHN01H3Ikq
         r+FA==
X-Gm-Message-State: AOJu0YzwyZWaEGjqYRHqv6Ryfz9SXKSYj7NFD5e+sbrJWrFBFHkttFRz
	W1HAMc6yKz6mHAfMOYh0kMGiq1RwF6Oaq8jNugG1846V97UJqffzxn2aXubI
X-Gm-Gg: ASbGnct2otHwTJTYXAta9N7RGn/uLrGEgtTBJ3GXtlpm0Tk2n9Iuas43LnQsqGz41e3
	rgcdKZHuFwWQR8QRDpwQH7ejIiqTpUFYtmxttGBy0uS55hWj/h5nwHuAD0ZDlJ2QqE3yD5RxjCd
	9om5H8+0WU63p1b8ukCqHYjqPAkjy5G1c9L2Ve22+q6QmTjChJSzRg54ML5PXpGamb1c8V+J4kM
	kPPAwWXHzagtOriqoBP+ldRMQyjZi5BGOJhW5b4/7D1xQ2pX84L8OyefJzz5ajG
X-Google-Smtp-Source: AGHT+IHXI2AXSCZVUT7bme5f6td64AXDgp65K7MAi5OAm2W3slZW8EXvJ1dPgtE19e3uNwl5WmWjZA==
X-Received: by 2002:a05:6a00:39a8:b0:728:f21b:ce4c with SMTP id d2e1a72fcca58-72d324bf1c1mr3075434b3a.5.1736419444881;
        Thu, 09 Jan 2025 02:44:04 -0800 (PST)
Received: from L-18010.kpit.com ([49.36.49.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad836d0fsm36752220b3a.73.2025.01.09.02.44.02
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 02:44:04 -0800 (PST)
From: Akash Hadke <akash.hadke27@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][master][PATCH] meta-security: Remove True option to getVar calls
Date: Thu,  9 Jan 2025 16:13:48 +0530
Message-Id: <20250109104348.60819-1-akash.hadke27@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 Jan 2025 10:44:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/972

getVar() now defaults to expanding by default, thus remove the True
option from getVar() calls with a regex search and replace.

Signed-off-by: Akash Hadke <akash.hadke27@gmail.com>
---
 meta-integrity/classes/ima-evm-rootfs.bbclass                 | 2 +-
 .../recipes-parsec/parsec-service/parsec-service_1.4.1.bb     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/meta-integrity/classes/ima-evm-rootfs.bbclass b/meta-integrity/classes/ima-evm-rootfs.bbclass
index 7ec2751..d50a025 100644
--- a/meta-integrity/classes/ima-evm-rootfs.bbclass
+++ b/meta-integrity/classes/ima-evm-rootfs.bbclass
@@ -61,7 +61,7 @@ ima_evm_sign_rootfs () {
     #
     # Deduplicates iversion in case that this gets called more than once.
     if [ -f etc/fstab ]; then
-       perl -pi -e 's;(\S+)(\s+)(${@"|".join((d.getVar("IMA_EVM_ROOTFS_IVERSION", True) or "no-such-mount-point").split())})(\s+)(\S+)(\s+)(\S+);\1\2\3\4\5\6\7,iversion;; s/(,iversion)+/,iversion/;' etc/fstab
+       perl -pi -e 's;(\S+)(\s+)(${@"|".join((d.getVar("IMA_EVM_ROOTFS_IVERSION") or "no-such-mount-point").split())})(\s+)(\S+)(\s+)(\S+);\1\2\3\4\5\6\7,iversion;; s/(,iversion)+/,iversion/;' etc/fstab
     fi
 
     # Detect 32bit target to pass --m32 to evmctl by looking at libc
diff --git a/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.4.1.bb b/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.4.1.bb
index 1d7c6e8..49467cd 100644
--- a/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.4.1.bb
+++ b/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.4.1.bb
@@ -28,11 +28,11 @@ PACKAGECONFIG[MBED-CRYPTO] = "mbed-crypto-provider,"
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


