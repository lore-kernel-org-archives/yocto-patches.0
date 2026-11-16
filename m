Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5008.1794867266456780934
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 14:14:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=WiuttrQv;
 spf=pass (domain: konsulko.com, ip: 209.85.128.47, mailfrom: scott.murray@konsulko.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4b467581b98so35393085e9.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 14:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1794867265; x=1795472065; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eKf6cAJ4G3hiE7n8I06ppu4cRB52GYfMMu9k0qd0SaA=;
        b=WiuttrQvxzKpabXqHOPUMp+IhtRRJwIdRSw7l7dZSGKAbHloMr23JoYtguyPFFVIyQ
         uzski6YwDL1FGmyS+2F4rn0zwER5zoyacOWzg2U4FWIr+i+ZneXONvHWJTn7AM/TrneR
         msk+jTAWywTNGkZ5atQ/uw57fnif22+7c5fL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794867265; x=1795472065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=eKf6cAJ4G3hiE7n8I06ppu4cRB52GYfMMu9k0qd0SaA=;
        b=X941J3V/QMFBabiYemKgy0PnP3xKOsG3hE1/89yYkF14VwEJuiq/M4Carz/5ZwiG1o
         7xluitHY9e2+wNZWlyHyZpQtTUgnV4SJyJZc1i20DmY5K1EIJxYI/jAQrfalsp3wx2aj
         hSjAMy9wcozLWOsDjrxyWkA2yNhn4MOKkibVVhR3LvLWldsGBE7ho4wIeFp1inQbGr6T
         bpqQTmPY9QD+3Ap4VYDeabT3R9vbyOzMBz3VVwynaSlnrIS7DmPJ8w7rsb6703p77B6z
         RL/M1Y2dQwMX0zY1LwiPrN2tLSArATXMiHnci7gNLNZa9CaVUGWFGHFPIg5z0rvsbw25
         6+/A==
X-Gm-Message-State: APuU4Z+8Jm9ITkSI323FTu/Ly3zimTuVYCDRxIDuzaqNuARVngF2Exy1
	MhgON9fabxhSogj6bV2T4cNrPrtHqBSG2kcQyfpxi2tzBy7/6dtshDe3tKjgQYmZRhSLC43KLDI
	L9iNMYP4=
X-Gm-Gg: AYBFou1NbXpPm0gt/GSkwPaeoSwz6O5x4TMmuSDtt54l3CXqMttRIof3aen0MPDtrt8
	h9GeMpFQPKCRWRNw5le7z6lg5RtmXbTtOI/ce+2jqD1ASuvvErvk9T+ZvTI5nEfFSyDkPeknheZ
	nhJPHVER+II2UjXccGFnePaA1E9c8r6Yk2Jzhejov5gUcZbi9KTEvzqSXMSi61nZOvgZQS9wbCj
	lUcP+iKd07CwVjgs9hNYMeb2yCsuXTBjfGgpo3AGn5ftkE/8V/SbVqTpeN+UWdydtnq211K3r1p
	5zXyKvq7Tw2FtdUM9zJbhw1aAny+uaL3HgBSlxKEGe5lFloGvc8ArmBaA+RHM4pck654zU5lbne
	ZNwrRLI0GV6pF8p5JWHRHoD+d/oABrMSQbVI8YMM1WNRLHaGF/vtYPfXGkEQLEW1TcYhPZMMf0Q
	x06JQJsd0H+/Ird4c9YM64xM95zpoDdloWF9fw6m7ySXYww2imkEmnso09NvHNefAWA1xmQPeop
	3sckeriU4EpGy1hGBv9PKkihhiFM1eVHs4DPaP/SPCXesrHJGmi0cvpjhY0QHvZs5ExDGcRTWH1
	2moM31aC0XrWsrlOEdYVf56EZcBe/psSEqY4Bq8gaDU1Oio38fESCYaQ8BFRho3tkUc8yAH76g0
	wq2rtin9j/695oQSiQQ+qa++Zsr45Cx1EkW7GERvfr0NEfaZhYGA=
X-Received: by 2002:a05:600c:4752:b0:4a3:59c9:a754 with SMTP id 5b1f17b1804b1-4bb55ab2b89mr251113765e9.22.1794867264529;
        Mon, 16 Nov 2026 14:14:24 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c888b90d4sm24346413f8f.9.2026.11.16.14.14.22
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:14:22 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 2/2] dm-verity-image-initramfs: Fix IMAGE_PREPROCESS_COMMAND
Date: Tue, 17 Nov 2026 00:14:07 +0200
Message-ID: <f8a960e2c7094b8547b7d872cb98b052b286a7a0.1794866391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1794866391.git.scott.murray@konsulko.com>
References: <cover.1794866391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 22:14:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5428
Content-Type: text/plain; charset="utf-8"

Remove semi-colon to quiet new warning about them being incorrect in
IMAGE_PREPROCESS_COMMAND.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-core/images/dm-verity-image-initramfs.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/images/dm-verity-image-initramfs.bb b/recipes-core/images/dm-verity-image-initramfs.bb
index 7ed83dc..294c234 100644
--- a/recipes-core/images/dm-verity-image-initramfs.bb
+++ b/recipes-core/images/dm-verity-image-initramfs.bb
@@ -40,4 +40,4 @@ deploy_verity_hash() {
         ${STAGING_VERITY_DIR}/${DM_VERITY_IMAGE}.${DM_VERITY_IMAGE_TYPE}.verity.env \
         ${IMAGE_ROOTFS}${datadir}/misc/dm-verity.env
 }
-IMAGE_PREPROCESS_COMMAND += "deploy_verity_hash;"
+IMAGE_PREPROCESS_COMMAND += "deploy_verity_hash "
-- 
2.47.3

