Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9698.1795884894568611509
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Nov 2026 08:54:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=RyqusXh5;
 spf=pass (domain: konsulko.com, ip: 209.85.128.53, mailfrom: scott.murray@konsulko.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb6ba3b244so92681255e9.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 08:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795884893; x=1796489693; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4wrptToHUiH326jKHsRNQ9gi0HlC5Ou1sG92M128iew=;
        b=RyqusXh5wrzr/wbA2xDY/BPtPK+YsK5TuWEFAtAXVYkFyBlatO6a3HmuVamf+13H3i
         vjvBJkyDX3FGdLn2J1yzjsGM5QWtwgnwQItXKk8jq0GN9dHTdJraL0Dxd0Zswl1WCk5/
         IItxU+enhb7NGQ+PGPfYzwtrwz2ZKmz7rmgoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795884893; x=1796489693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4wrptToHUiH326jKHsRNQ9gi0HlC5Ou1sG92M128iew=;
        b=au0JntRVJjZQuQOrClXMl8FAve4+k6edKhYHVbzCMpqbraal8JwfrWg7ek83dbeEgy
         ldFdLHrVPcNrt+oR/NiTz89kEGFTZufTKGTyBaymk3Ig59XygunAkcJ5znrgavl5JU4e
         lBFs/TAq8Cu87gybgZKYjOkZVXn6Ju+TznquARHMhcOf7O0j00U12wVy3mZnkQ6NGF5v
         3uhKNmhOaTe697b0wMGwJ/85seHXBTQiZ+XIxG21oHcY+47OvXwHT3sgPVVLumyFLklF
         gUOLoCE2kN6SEjmyieqpmSdVLJQNjM15W+9SraKCEOfF64c+TX5NfOclmfgIY56enAou
         LuJw==
X-Gm-Message-State: APuU4Z/qGIThVaFvn1sIapbkLQDkCFDJK8EKUWygtSAQ+8KAV/EkgVd4
	IBJOtXJOUjoXlCMuNXUOIeaYiVAihCZYo50UmBz6xsOZN3o5VrHK8j5noiGixY6J3ftlS2Okpl/
	8PrHNIyc=
X-Gm-Gg: AZFdTZcDxEvHfqhrObggtW50y9Y8V9C9/QcooS9cYYMj40RvC8oxhdCPGALxyFVW5lY
	dSwNqG/GGXwht/1GL98f7fq4Px2t9vqwp1uNU3sZIBWKliA2wQY4elpkEOX/C7m8mzenW+l3V+Q
	wfS0dkLpCFoNXWEh6oXzycxUBwU8vn0yFBPUIN7+NoGzgh9HG+mvgxuJvGfCz/LvdrCWk7oy/yO
	yv4pfh7as9B7p65K7UL5g9GuDjpeCy/AGtrlmNPq5Oh/Gwi9psdvP5fOOz3ww0BvUN6PhwqI7zy
	HXfzntMyh+GpYZVeh6h+E57fd/ppv8PBp/OUFErbT3u8tKA3b7yBPYmt1+mTcr4RF0itgRySNNL
	PedB/4OhGI/IWAlM0+i1Whtl0x0xTtlYmdQxTA8FE5lBcJekNtQGE939Lu3JfE/kBFnE4/APaDf
	lmSzVcMSuhCctrxw4HaKozcVetP0gJr36g1WAZDcZqM8+bBAs/BRjj3KyeMXCbw08dI4ACpgIOj
	U2vvHnK3LlMoOCllyi0gl96w2n8HrpI5W6X7+jzx7uJKWzvwt7OOldAfC+2H5T6Lq7z0BtUSMPE
	mBu4iLgz4n1Wr/E+sX+adhtqCMF/dG7VwSGfVCWTvnL429RecC/AdFEX3Pq2nkXQaXiR7qdEmgQ
	x1Ubho0BUVN5hsfPdgnCM2SUq71mb0A==
X-Received: by 2002:a05:600c:820d:b0:4bb:6cef:d14b with SMTP id 5b1f17b1804b1-4bb887c34f1mr559733045e9.2.1795884892782;
        Sat, 28 Nov 2026 08:54:52 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853ca452sm755951155e9.15.2026.11.28.08.54.52
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 08:54:52 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 07/14] systemd: do not enable efi for tpm2
Date: Sat, 28 Nov 2026 18:54:25 +0200
Message-ID: <6a983f07b9ddbc9d44e79b709d2bf14c2c1a9aa3.1795883420.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795883420.git.scott.murray@konsulko.com>
References: <cover.1795883420.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 28 Nov 2026 16:55:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5577
Content-Type: text/plain; charset="utf-8"

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Do not implicitly enable systemd EFI support when tpm2 is enabled in
DISTRO_FEATURES, as this builds and enables bootctl and
systemd-boot-update.service on machines that do not boot through UEFI.

Rely on the existing EFI configuration mechanism in OE-Core which
already enable systemd EFI support when efi is present in
DISTRO_FEATURES.

Fixes: 6eb3098e5788 ("systemd: enable TPM support")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 meta-tpm/recipes-core/systemd/systemd_%.bbappend | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-tpm/recipes-core/systemd/systemd_%.bbappend b/meta-tpm/recipes-core/systemd/systemd_%.bbappend
index 867c111..0568ab5 100644
--- a/meta-tpm/recipes-core/systemd/systemd_%.bbappend
+++ b/meta-tpm/recipes-core/systemd/systemd_%.bbappend
@@ -2,7 +2,7 @@ PACKAGECONFIG:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'tpm2', 'tpm2',
 
 # for encrypted filesystems
 PACKAGECONFIG:append = " \
-    ${@bb.utils.contains('DISTRO_FEATURES', 'tpm2', 'cryptsetup cryptsetup-plugins efi openssl repart', '', d)} \
+    ${@bb.utils.contains('DISTRO_FEATURES', 'tpm2', 'cryptsetup cryptsetup-plugins openssl repart', '', d)} \
 "
 
 # ukify.py and systemd-measure don't work in cross compile environment without
-- 
2.47.3

