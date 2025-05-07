Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0E6C3ABC5
	for <webhook@archiver.kernel.org>; Wed,  7 May 2025 08:47:11 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
 by mx.groups.io with SMTP id smtpd.web11.4025.1746607629066301670
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 07 May 2025 01:47:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=f9w6+FA4;
 spf=pass (domain: linaro.org, ip: 209.85.167.44, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54d6f933152so9047012e87.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 07 May 2025 01:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746607627; x=1747212427; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4mqTX0tJAJbPDwXuDtOXUPLyEQX3JaiqBFMOJsfdIFI=;
        b=f9w6+FA4VSGMmtDYtUxobKZyIRW67aR2P7s4+0Mk4tmdtg8F46/WNTROnotjR3U5fv
         lTQ3ZMHpsmwjDtBwlzrakS6Ww+DKxaCzwdVZiIQvYwXSbwKNCx9eTXUTrtcxYJXAakJ2
         slkJSU51MrZZnMREpfqzIDiQM92aNWO77KJGzCJFr3Re+h2mtcqR4v+YUXBbgfcb1Oj6
         m94YmTSuimCxrs3aL0BE7ub831Q+lQWfOBBrao2+SwvG/ammiUZEG2Mav/cb6Pc6LYlk
         6fXMJOlBJuZCSyWmb7nroZgtCQaEJsmpB9jxH2qXSXKy2UhwRcl39pbhABx4H48OiU11
         IFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746607627; x=1747212427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4mqTX0tJAJbPDwXuDtOXUPLyEQX3JaiqBFMOJsfdIFI=;
        b=FvWyAb4yLvzUtXeItdWCRjYbH56GjyYHbnBlIVhb2B9A/S0oIef5myzfozgKIWlO1c
         03za0GwYIj/Z1rgnNNl0ybp2Mr5T0GbGyuLNNxGmFtHhAykqB/Ve4JsskbGgcJLE5cKz
         TYWSJFUBdHtOI4Kxv9ZplxRRaK7L+q6uxzRGoLrMdhDwFCO0KFXbmgZqKyGi6gnAZggG
         k6cHz8QSSfISBfOT2CU4IM19q/wG68DddnHj6v6+14dIg/B+gfj9zmQFbLXmcRDilj4z
         TMLHxssm3yNrKRBG19oCuZl+QcXoyEGVxlMJ8b6biVh6ugfuC7PGvR9rs85FBKjp4kdh
         08Rw==
X-Gm-Message-State: AOJu0YyIKbiLYyqMDHGMcnuTUHH5pm2TYSc+766ZypVwoN18CgM9XUsB
	4C19ozxOANK7xmO3LvLeskGEwRtczB8+m++GkFLARZ2EMmuF+0bmgY8KY4Bas5P9tmi1s4G4an9
	05Lk=
X-Gm-Gg: ASbGncufLe4D60ZXj+ZjL9U9bVLzfZ5Ty6s8GuMaA2N3nz4eXK1UxgJSpQUbfGPuSqJ
	0KjofG/MLYdJ9GmQNNFyKA9W2TIEGTwU7lLZo+zbJiENmUYIyNVZIhkNeF+lUSrsPXwwh8BhfcB
	i1ajgl/t//D/s5niK+rsIU2fKTfmI0nFfee66G2Dy6URrcuqF9nqJ4ikPO2mjL9QBvOpNjefZRX
	7BzetClvHmJY/sO/8Q5KP1F0ms26bRkRszmBodbwrBnJYWCvYOB2ySGnKFIE/auociA3wRelNr8
	PczG8ToWhDWuZennF0O21Anu41AFyat9KkEZgdhbcNAxVhYXWRwe6QKUxXzpQdiU1R09COLcR0m
	Iqk3rTJ2icq7YnDe+pdoLvRGQdfps
X-Google-Smtp-Source: AGHT+IER8xTPkzDKdM/a0EKw4Aumjq+BBhAQ8dyTuNJnQ9gf6R+ScczG14hjBaHCuUEGhiPDg8BrEA==
X-Received: by 2002:a05:6512:3d15:b0:545:1d13:c063 with SMTP id 2adb3069b0e04-54fb95fae61mr830566e87.14.1746607626996;
        Wed, 07 May 2025 01:47:06 -0700 (PDT)
Received: from localhost.localdomain (87-100-218-141.bb.dnainternet.fi. [87.100.218.141])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ea94ee13asm2297885e87.156.2025.05.07.01.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 01:47:06 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH] tpm2-abrmd: whitespace fix
Date: Wed,  7 May 2025 11:46:51 +0300
Message-ID: <20250507084651.1227631-1-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 07 May 2025 08:47:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1525

New bitbake version warns about these.

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 meta-tpm/recipes-tpm2/tpm2-abrmd/tpm2-abrmd_3.0.0.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-tpm/recipes-tpm2/tpm2-abrmd/tpm2-abrmd_3.0.0.bb b/meta-tpm/recipes-tpm2/tpm2-abrmd/tpm2-abrmd_3.0.0.bb
index 24fd5b5..1b8eff1 100644
--- a/meta-tpm/recipes-tpm2/tpm2-abrmd/tpm2-abrmd_3.0.0.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-abrmd/tpm2-abrmd_3.0.0.bb
@@ -35,7 +35,7 @@ USERADD_PACKAGES = "${PN}"
 GROUPADD_PARAM:${PN} = "tss"
 USERADD_PARAM:${PN} = "--system -M -d /var/lib/tpm -s /bin/false -g tss tss"
 
-PACKAGECONFIG ?="${@bb.utils.contains('DISTRO_FEATURES','systemd','systemd', '', d)}"
+PACKAGECONFIG ?= "${@bb.utils.contains('DISTRO_FEATURES','systemd','systemd', '', d)}"
 PACKAGECONFIG[systemd] = "--with-systemdsystemunitdir=${systemd_system_unitdir}, --with-systemdsystemunitdir=no"
 
 do_install:append() {
-- 
2.43.0


