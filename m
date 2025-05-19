Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7A3C2D0CD
	for <webhook@archiver.kernel.org>; Mon, 19 May 2025 14:57:04 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.53012.1747666614600473482
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 May 2025 07:56:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=pYc6ok2C;
 spf=pass (domain: linaro.org, ip: 209.85.221.50, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a375888297so486427f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 May 2025 07:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747666613; x=1748271413; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GokZV/I+n32Q8lx/LbB9XBonUMAKIZ096C4sAHZV9A0=;
        b=pYc6ok2Cs89Bg5XN748s6kLn2w0jnoqdq5BUONxIHnlGBlTck769O9n3Z9ngXi+3rI
         o2jgdCgBiL8iD3YotNhkVxs8GnDWyn1Iu0UXhQvz/InOgih/qKE8MDAPngdQjiBkn8DB
         5poNBR+93KVufyQjL01Meq+7lr9qyN+CRx5CMVNAO8ocfhqW7rFWrRbMBUDcAuypBGvS
         PmvgxF3bW+W5vXrm3RVONLZ8QljAC955+e1fEO/C+AWc8NRmyWIbZD7cMf/Hu2lUxED0
         9OvtZ0Eyw7EKpKOC9Me7lSEmauOr6zfUkYMFMmxpM32xaEUeCFCLIkn56hv27f2dw0MF
         kvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747666613; x=1748271413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GokZV/I+n32Q8lx/LbB9XBonUMAKIZ096C4sAHZV9A0=;
        b=fgZL7WXpvo/DrRTVps6lw8UbHBA/1ALR23t7WtWzVj63FN8+9mKN4Cm4Pp7gi8LrT3
         lkh4ZZVKj2sQZUeSrqtVn068sqi6xQsaLZtqTvOpQZ7nQDuup+i+M7FpB3LNP3SqLFiy
         PNVlnvLm7ht8mI5RzjdG5cxkPwM6DyNYe7umGOluXG1odPbgivnPke0GaPiDr/+GOAKw
         jKcYZ0ZuXH+urRbo26TrV0/csDBdRR4Yx1AF6u73PDx7VpiF5VJDN3wCbkZ98MmmVO7E
         AhzUfGuk/m0T2EcReW+UhYVezm8BPer0WTCYStZ3JOjnnYDlyctQkqQMTOvestIweOsv
         n96A==
X-Gm-Message-State: AOJu0YzU6/fFNbcz198qx+9Dy49COtx4juTzQdkjp14ftGi4BMzeV/M1
	g4B0TmFHz9eGmoiTt9R/31cgIw+pMVVBaVZ65M2s5h/c/9lnb0yDvuCL+hbbwwLyiahpzlB/sOJ
	XxuBxAZA=
X-Gm-Gg: ASbGncu2gO844+N2e58g1CoNaqHO1bpH47wKhquXzWC5qSwogFw96bCYX06hMIXMWXH
	/EHwcGwSkvKLPdCpCLNE2874iWrxo9GyQlEAIsgfDdxTDi5u6OnhpIWUXL0CKTaQmR+fCYQdqC3
	Ehn+dQsHTfZM+ad/FDD82D92rvk+hUv/nYwaKlBz5d6f4r5AGop5LdIy5k6Iq0saPH/TAldAqaR
	M/RzfWKyqY6S5UGgSjxsYjoA2ucAfrk1M4OBsBBnQKCSpOJFxdyJx0m+n7Q/ikTNQe8W7B56jT8
	AKOGZ19JhEnYuDfkyz/TIuPj/cYTfXsdpUXYoC+ILcTfNatDH0P1WpI9UHoZEL3hQxjtLBFy
X-Google-Smtp-Source: AGHT+IE+elqzYqTyAY8cieOgZoBwGWLSCYeNUMoDF1U/SAdEt2Cqb0yl8jIFDBNk6nk6GK/r14dmVQ==
X-Received: by 2002:a5d:64c9:0:b0:39e:cbca:74cf with SMTP id ffacd0b85a97d-3a35ca76738mr12562362f8f.6.1747666613078;
        Mon, 19 May 2025 07:56:53 -0700 (PDT)
Received: from nuoska.customer.ask4.lan ([62.48.241.198])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca88990sm13402597f8f.68.2025.05.19.07.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 07:56:52 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH v2] systemd: fix empty file list with sed
Date: Mon, 19 May 2025 15:56:37 +0100
Message-ID: <20250519145637.24305-1-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 May 2025 14:57:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1564

If measured-uki support is not enabled or build is continuing
from previous stages, then the matching file list can be empty.
Fixes build failure where sed says no input files.

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 meta-tpm/recipes-core/systemd/systemd_%.bbappend | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

v2: fixed sed command to unquote FILES variable

v1: https://lists.yoctoproject.org/g/yocto-patches/message/1523

diff --git a/meta-tpm/recipes-core/systemd/systemd_%.bbappend b/meta-tpm/recipes-core/systemd/systemd_%.bbappend
index 82b79ba..867c111 100644
--- a/meta-tpm/recipes-core/systemd/systemd_%.bbappend
+++ b/meta-tpm/recipes-core/systemd/systemd_%.bbappend
@@ -11,7 +11,10 @@ PACKAGECONFIG:append = " \
 # TODO: use swtpm-native to calculate TPM measurements
 do_install:append() {
     if "${@bb.utils.contains('DISTRO_FEATURES', 'tpm2', 'true', 'false', d)}"; then
-        sed -i -e "s/^ConditionSecurity=measured-uki/ConditionSecurity=tpm2/g" \
-            $( grep -rl ^ConditionSecurity=measured-uki ${D} )
+        FILES=$( grep -rl ^ConditionSecurity=measured-uki ${D} || true )
+        if [ "$FILES" != "" ]; then
+            sed -i -e "s/^ConditionSecurity=measured-uki/ConditionSecurity=tpm2/g" \
+                $FILES
+        fi
     fi
 }
-- 
2.43.0


