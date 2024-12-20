Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C77E77188
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 14:05:52 +0000 (UTC)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
 by mx.groups.io with SMTP id smtpd.web10.152505.1734703546563075831
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Dec 2024 06:05:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=mRm57W01;
 spf=pass (domain: linaro.org, ip: 209.85.208.169, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30039432861so19134231fa.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 06:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734703545; x=1735308345; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTfZlznST/yf+1sY7mohvah9S8tmpSUqJywMpixElgw=;
        b=mRm57W010KRC+Ppj0OeUSbtQ9IMzxMEFqoup4dU3dlhB8aduYMCeUYGYUYzjzX7kPb
         WqH/MfNTr3Q/phBKw6auecV9eWAUAwz/iiPkzI+dJ3jnm8su9mEtFFt0laX06vbPQ/BF
         PG8UnUlvgK5V0cJhnejuApzkfHp/8bdHqaGNmVhXFLAuwTcSYriWI+iWA0AamNxAe91U
         XnXO5lwg3GSvggSlu1+Vzxo6gGinOypQzBJocWLXNRCSo9NmGrdjpymBMzWkm9PI+UbJ
         DA1xk/WNWSceotiEjut+LLWwsZUe/Gnj/RM2pZXL8u5xCv/+HBBXkYBtuKnzw6bpepgU
         9cPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734703545; x=1735308345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTfZlznST/yf+1sY7mohvah9S8tmpSUqJywMpixElgw=;
        b=tU8eHJuNRBh6VvsLzmvmS9cfM6f9yRLPNxH0btlnAzupPqrMEn/dXwGxKiDPnv3BWe
         sUol2qVw7L2sLCCkbXOwGidCFQEDOlVJy6YZku31Z9/0fFuigv2UmAdUEqzJCBY+4esu
         y6kd/J33UOAzM8b0DnFfgNYeIYAJ3WPSR4uvkN2vcLhXyMSVecVH1mCK3SsMevK0V4BK
         VcwaupinifRNifgXTZonoQljBDUM4cCu5C/4VVe1EqdgMuDLC5pLCM3wBgHNbBrIOk1x
         +gg/wYaQtkzyHXsWmyP4/amrZ1Hhfx+8Kc+ejD05hY2ea48e4ZQO2214aUj4Lz379pC0
         GK6Q==
X-Gm-Message-State: AOJu0YxZkfQMUQdoXIFP0mjQKlkNGdwOPPXbEiC6f3gzw1eg1sYN5+vA
	Vk8BOHSI5+01TlO8mlu9xGhA6/VIOMdIHCTbYxX9x+DtdeEYgq/hCFbVb1LvUY9cznc4X9qj251
	vPzo=
X-Gm-Gg: ASbGncvzG1rmWFgdpNOWWWb6yqaR1gvmpqoSGXYF2hjMRqdbpupxsrHjKyAonnahSiP
	lc/5SQtDj1GVA8cSYoILAJQXMZVXLSTqPUG1f2aCA3dYX1/ZpRHduR4/ijBDlj1/uYoojdfZRJl
	9GF6V0gVQIGqQl6QLPrCjawdVT4Umy6hxsUvUSL3T9wex2ARaN94+ucT3Ye6m1zH7XWDZEZrQY3
	l+KG46Va44d4hoxsDOJTaVBlXCiUKwR/yk02vTq9fsL3OlMASJ3/r9k3qvUZRjoFXprxHwz6J7w
	wmFDkynoRYi6vs0nP8VkyC4jxA==
X-Google-Smtp-Source: AGHT+IFbD1Y3Q8SzC7GhUkKJgIvvSb+EjshDNuuxrQXUMMwlwq0jJIHlKiQ2gnmZnsJ9ZXZ6IFHDww==
X-Received: by 2002:a2e:a69f:0:b0:300:16c0:b67 with SMTP id 38308e7fff4ca-304685d895cmr8861741fa.33.1734703544580;
        Fri, 20 Dec 2024 06:05:44 -0800 (PST)
Received: from localhost.localdomain (78-27-76-97.bb.dnainternet.fi. [78.27.76.97])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad6ca8fsm5227191fa.14.2024.12.20.06.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 06:05:42 -0800 (PST)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 12/18] systemd: enable TPM support
Date: Fri, 20 Dec 2024 16:04:35 +0200
Message-ID: <20241220140441.271395-13-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220140441.271395-1-mikko.rapeli@linaro.org>
References: <20241220140441.271395-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 14:05:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/951

Enable "tpm2" support if "tpm2" is in DISTRO_FEATURES.
Also enable cryptsetup, openssl and repart features which
are needed to use TPM device to encrypt filesystems with
systemd configuration. See:

https://www.freedesktop.org/software/systemd/man/latest/systemd-repart.html#--tpm2-device=

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 .../recipes-core/systemd/systemd_%.bbappend     | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 meta-tpm/recipes-core/systemd/systemd_%.bbappend

diff --git a/meta-tpm/recipes-core/systemd/systemd_%.bbappend b/meta-tpm/recipes-core/systemd/systemd_%.bbappend
new file mode 100644
index 0000000..82b79ba
--- /dev/null
+++ b/meta-tpm/recipes-core/systemd/systemd_%.bbappend
@@ -0,0 +1,17 @@
+PACKAGECONFIG:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'tpm2', 'tpm2', '', d)}"
+
+# for encrypted filesystems
+PACKAGECONFIG:append = " \
+    ${@bb.utils.contains('DISTRO_FEATURES', 'tpm2', 'cryptsetup cryptsetup-plugins efi openssl repart', '', d)} \
+"
+
+# ukify.py and systemd-measure don't work in cross compile environment without
+# a tpm2 device, thus switch from measured-uki (new in v256) back to tpm2 
+# (default before v256).
+# TODO: use swtpm-native to calculate TPM measurements
+do_install:append() {
+    if "${@bb.utils.contains('DISTRO_FEATURES', 'tpm2', 'true', 'false', d)}"; then
+        sed -i -e "s/^ConditionSecurity=measured-uki/ConditionSecurity=tpm2/g" \
+            $( grep -rl ^ConditionSecurity=measured-uki ${D} )
+    fi
+}
-- 
2.43.0


