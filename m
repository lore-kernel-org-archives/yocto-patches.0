Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14461.1795779652966180856
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Nov 2026 03:40:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=tTLq2ocu;
 spf=pass (domain: gmail.com, ip: 209.85.219.43, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-9212a5a66f8so65090116d6.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Nov 2026 03:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795779652; x=1796384452; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l3E28tf5yEd3Z7UqUBIu4uJaEa4GxC+zJw1mDIRJzzs=;
        b=tTLq2ocuMhRG078qZvdWT+surL0dlrTTMcVAmo3VhTYPbf7TfVGfSXWMvPlh4xJfWA
         f+4cCVUIss8vmiFNM2+1IVecCjE/KxzCNzUz+whs1UZdhA2JWXxzDO1kTYVYqoJQ23kP
         pV1mCvnxjliLJzsjNIHj0yls3k+LiVlvaYYB2m2pqmMLk3AOV0PdBYiK2pfvoFhPIhCh
         hKS1wpJlTbRe4HgGdETbFZFJgLbXiefQ1Qs1l051RAkZHwWKEpxzLfnK0QMiDqWJgtCi
         vkVRy7mLkBdNuAW/5b+Se4faHpoE5NTqLiwXkh40Ecd+Mdg0l0lsIyVQhsh/pkJPzhRL
         rixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795779652; x=1796384452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l3E28tf5yEd3Z7UqUBIu4uJaEa4GxC+zJw1mDIRJzzs=;
        b=h0UeztXWnA3x3ClJTG7uustr16X3boOC8/FG3F1kE4ONn2hPR6/e/5YdyR1y05jF23
         bkUT24s829HnX4OH/D8jEUhvAEaZadXcfguTMTjxebPm3aUaK1KN6vVqq4CuZKQzxBVM
         qVD5hvXYf4wDoMpcMzblGisGtUNQzKSs9QmaRNAb+zUHrny3ryCgeMtmSZe1S5OgPHyM
         Wdb4ekz0/CAoHdn7LslySAAwNj/NgS327/2enNzPXb86/l6qG++kO7cD8v/VXZlYyfKM
         9voNBUn4kXw6cBo3g9UhcUHypnDZrtZb5/sFh+vwbLoF3yz9X4UhdKcg9BG42bokdq4f
         XQdw==
X-Gm-Message-State: APuU4Z+tqsAckezjZDF+1tVkXljo2Z1yzVYLusGHbPIlbqfoT4GVteL5
	SnIm37Khyg1yWchscR1kWNqFRGmHHtwZ5vBgGPza4crcGJXEqF0kr7TJMQl/dA==
X-Gm-Gg: AZFdTZdUzkrnLPoJ5AHNZXaZ4XClvypaDlEQxNkpYvpz7URC4nOr3WsGLQhO1d44dx5
	mSuw2kGIBbEFdglD9blXVYPCVeTgacu6H8e0Ey10V2a+V6ScbD0ccn/VmY8P43nY2FOnWPtKs/1
	ZVQyjlSEGb7ZWiWJXMe2s57ZPOvOuOIEfVu2dihbeGKf7tEiSSpm/LOaYCGCtGa+J0pwn2m43mi
	fN4pI4i7ce+2zQ9080tvLnxnPdb/HYhC8pKXDycV5/oEuosFlRNi5fKs6txjERH+eI1cqEHV1LK
	FkBU2uU9BaZGLg55E75Jh2dBxikn695gs+RH/Tg4vuheYpawOHp2TqFVkusj7zuYIxMSU9RnR5A
	VkMlppsXHCMIc5TfhhGDrYP3ycTHUPawzRwyPj4m0iHw9UJMwCpFKen1yTbkFsHcc+GdtoANEch
	MmQcuH9cA75sSFPl+O6btf+nM15NjlhbTogvRmPL6rr4iTqMkFE/GYlE2+L41/Y9bVaOtjjyu8o
	GnPg3sNi0Yzb6ndd6gntDKOAPaK5ME31rf+nvY6tubHBTsYp6JdfHSSq0di7tEONsLSePwsIrYt
	zKXUquggM1jeTbqm61VvZA4ZwEyCFA82FYf6hNqybEGNE4pbVtI4PwR9gko5frwj5H/yZyepv1z
	7Sq7bA+IdGslnwzLmSkinpG8xLE6tbIQ=
X-Received: by 2002:a05:620a:4591:b0:949:6ec7:68e1 with SMTP id af79cd13be357-949ba9b4a81mr4287574885a.18.1795779651878;
        Fri, 27 Nov 2026 03:40:51 -0800 (PST)
Return-Path: <twoerner@gmail.com>
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb031601sm1800526485a.6.2026.11.27.03.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 03:40:51 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Subject: [meta-rockchip][PATCH 1/2] kernel: only add the rocket NPU fragment on rk3588s
Date: Fri, 27 Nov 2026 06:40:48 -0500
Message-ID: <20261127114049.3566943-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Nov 2026 11:40:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5547
Content-Type: text/plain; charset="utf-8"

The fragment was appended for every rockchip machine, so setting
ENABLE_UPSTREAM_RKNPU made the kernel config audit warn on all the
others: the driver only supports RK3588's NPU, and on 32-bit machines it
cannot be enabled at all. Use the rk3588s override, as the mesa
PACKAGECONFIG already does.

Cc: Quentin Schulz <quentin.schulz@cherry.de>
AI-Generated: codex/claude-opus 5.5 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 recipes-kernel/linux/linux-rockchip.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/linux-rockchip.inc b/recipes-kernel/linux/linux-rockchip.inc
index f91492ee7968..006d9f0ecf14 100644
--- a/recipes-kernel/linux/linux-rockchip.inc
+++ b/recipes-kernel/linux/linux-rockchip.inc
@@ -37,4 +37,4 @@ SRC_URI:append:nanopi-r4s = " file://realtek-r8169.cfg"
 KERNEL_FEATURES:append:rockchip = " bsp/rockchip/lttng.scc"
 KERNEL_FEATURES:append:rockchip:arm = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
 KERNEL_FEATURES:append:rockchip:aarch64 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
-KERNEL_FEATURES:append:rockchip = "${@' bsp/rockchip/rocket-npu.scc' if bb.utils.to_boolean(d.getVar('ENABLE_UPSTREAM_RKNPU'), False) else ''}"
+KERNEL_FEATURES:append:rk3588s = "${@' bsp/rockchip/rocket-npu.scc' if bb.utils.to_boolean(d.getVar('ENABLE_UPSTREAM_RKNPU'), False) else ''}"
-- 
2.50.0.173.g8b6f19ccfc3a

