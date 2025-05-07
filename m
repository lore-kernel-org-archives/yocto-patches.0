Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED79C3ABC0
	for <webhook@archiver.kernel.org>; Wed,  7 May 2025 08:27:41 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.web10.3751.1746606456531898284
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 07 May 2025 01:27:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=QIxpekkM;
 spf=pass (domain: linaro.org, ip: 209.85.167.53, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-549b159c84cso7411981e87.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 07 May 2025 01:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746606455; x=1747211255; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tS2YSNKFqXLf9ZbNvdr6UKE6isHzZkHwwhpzalvs20=;
        b=QIxpekkMYBfMKY4YUvF5v00Uv+MmvZ8pxKe+hxlnMgaqWaOWvUNmFn6ksWdhl4t7nu
         r+uPlegaZZrwxVVjr1Qw26YN9KJ5/SG5vafODW5FXbrYlkRZGVPoXw9L7lE76dcy5NgP
         f3dOn32foZIRW/RylxuC91oQ9KoduxKbc4DS2EOvi53seysuiVd4L0uSr2fVSe0aOWKg
         R4G4U/fUBBhIG1/b1WMQegJXV5SvnPWlhaDoAauv6pv556QHTLv5c2xyOUYamNu/q5Ow
         I+0oTUzZfqf345N+zQn6DR+le8NEo3QnoMrWYhuX0w8AikIptMv3ZVrzUzPt9Pkq5XmN
         XbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746606455; x=1747211255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tS2YSNKFqXLf9ZbNvdr6UKE6isHzZkHwwhpzalvs20=;
        b=oteh6vjolDDAzVFoPHijSiWLDXH6yOkpfS9tkAJF5/61iLj8yLRfWwBlDh1lof/H5i
         zB/q4OXx6O3qfitRT+1D4jKn6M3+jG7khpEzwQlh6cMo8DCWRqCMP/I3XKxxSdvLBAZw
         dx57oMI/kQ9RuK9FmZMZvpZi6R97H08otmQfpfUtxjS+7tOTUayfPxPIvQPw4HVG2Plk
         /CV4Bakj4llmu5RjfXgHK26JC4v4XG1r/nYB4rQLhmwnX5Zazcopub12ilRJmYltKgnV
         MBkFLvYkOCV2rX0/PrQrCEo7sSb9IlorHOgKTrPnd+GYmyt1kALi4dINOoqwyInShxVn
         FnIg==
X-Gm-Message-State: AOJu0YyJaYrwLzLp7SeNHOFaCECWRtmf6X+VV81wdSFGCk4GWNMeWhYC
	6dUk1X9lCmb4Tku6nPPeHPR1tBC3MosYJjnWarZhWMA4iQHcpIdzquJGfYelrOltfS+qe3/MSU8
	45tc=
X-Gm-Gg: ASbGncvFIyoP5h9OvIFCZkgwLC8AOp9x2B9iEfyxFk2Gt/IEYC81sV/atqiD93CsWLA
	LbzUfP3W4J8qP+K6kAk+gTrMhi7QraQDzSF5QWdyCitfL3V8o6lZ7xj6t1Zaa6jeo/VYrXwtuAj
	DWEH287zcgU97PaKRLHLFzdDqQEn+gK+lCOV0Ai7Ygu9zEh1emqPRDQY4wu62F9YeCVuCvIm3Cr
	1gwhayrN5LxNgfLtRBze9860X1AQkwwzAA9V0fMiWtJVptS6si1eZoeg3Vv7JL9+A0gfdkMm4LS
	qqRDqd1Syhek/zkmPemnD/FbwxhsIy2S9RJIdK/dOiGPIlO4o0KKLZUFXmV7eA37HaXU5ClwHgG
	JHgTWAWEmASN3EgxigQ==
X-Google-Smtp-Source: AGHT+IHt6G06PAskMo7T1jM4t75T0T7P3CG29S1duhPIVs1MEl3SqJ5g5h57Niorb11dLUTuuXUJKw==
X-Received: by 2002:ac2:4c53:0:b0:54d:67e3:91d2 with SMTP id 2adb3069b0e04-54fb963001bmr896900e87.39.1746606454651;
        Wed, 07 May 2025 01:27:34 -0700 (PDT)
Received: from localhost.localdomain (87-100-218-141.bb.dnainternet.fi. [87.100.218.141])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ea94c8e7bsm2266719e87.101.2025.05.07.01.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 01:27:34 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 2/3] systemd: fix empty file list with sed
Date: Wed,  7 May 2025 11:27:18 +0300
Message-ID: <20250507082719.1220303-2-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507082719.1220303-1-mikko.rapeli@linaro.org>
References: <20250507082719.1220303-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 07 May 2025 08:27:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1523

If measured-uki support is not enabled or build is continuing
from previous stages, then the matching file list can be empty.
Fixes build failure where sed says no input files.

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 meta-tpm/recipes-core/systemd/systemd_%.bbappend | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/meta-tpm/recipes-core/systemd/systemd_%.bbappend b/meta-tpm/recipes-core/systemd/systemd_%.bbappend
index 82b79ba..c53b1e8 100644
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
+                "$FILES"
+        fi
     fi
 }
-- 
2.43.0


