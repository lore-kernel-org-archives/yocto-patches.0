Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A06D13C3E
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 15:43:58 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22494.1769441870430651006
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Jan 2026 07:37:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=UHgB9hjV;
 spf=pass (domain: baylibre.com, ip: 209.85.128.45, mailfrom: ukleinek@baylibre.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47eddddcdcfso26982515e9.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 07:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769441869; x=1770046669; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XmpozehDiu6EqJEJ/yPG0FJ/Cp2U+yJfGdO5K8sC9xE=;
        b=UHgB9hjVzUNhv7Wo7LfpOlbeT7bZgFIxWXiTDUPpF7BMbnKQ1BpvBWUS8ovqEltWtw
         PYumOGs8qjHItIqm1PXoPxwvMkg4Vn2xfhUcjUU/LN71bi38gpsDPqWbiUPfGh3+yS0+
         VdQBql9o6b310LA9+MZgKXNRjJdTLSCjg3VulHd1BPpiAr7nWtByAYniJ5on6CB1cj/V
         18RI1NnnClfOhZ1wfzqd4LlTWbxfCiRfjFDlyi223PkAN4Qkx2n0D1Epy5xiNx99jz04
         QmHgWP6lJyqow/mp/zsFdsfbzKwSDCWpyFONc1lcCBIVEpk/5q8Q7Eq+xB8Ro+aya3zQ
         XBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769441869; x=1770046669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XmpozehDiu6EqJEJ/yPG0FJ/Cp2U+yJfGdO5K8sC9xE=;
        b=aqt+oL+C5dsyqg8VHxNk/Mudd0kHnwpqte2vq4z7/RxGsREPyc/dLuDdbikfFrkMOo
         65aGdYgVdiBHpXZwM7hKVPW+jSwcKxb17pC43SqEIk6ykbDMyT8b6wuLZR+ePWUT/sw2
         TT7ziWUuDtaWwrylLr7LuuilcaVfQ9EIDTQuPUqE724dcQhinE4kYxWSkhIERFzWabn7
         ZcjRWvDe3enbl1vCMqFMYAaF9ibPEVWPLJrn1XFvyBRtCkr3nhkXmFRs4HGew4iUktOq
         YTulRipDeO/XKKZXc/kL4o91glTtFJYNoMYavgHW/e7SMCBQwtmES4zlXgJEXuSBICik
         2olw==
X-Gm-Message-State: AOJu0YyNWqZ0eUD5LsbBYULjnh/hkXCvPiYL+4x8WW8sgD05eN0VZU9g
	k6MK5fQNph6/UEpxduDwZZxCcJfGWyA1x8PnHUeyfAUL7c4GrThaij4L6cFGH50xMNvom+3oUnd
	qb17W
X-Gm-Gg: AZuq6aJv0jyLrcuK/N4akhOUT2FS0tO+27muFxJkESNvnu+wnK81ipELgISVbnlisKo
	QdjMBaJklM0CFKqlwKvnJUxMsSTxfVqG8dEuRnt/Pp4jfPHRGi34wSZ9wa4/mpPYeO4c+pAIDhC
	5wmRmNMtsBQrETyej/SEoGhR2Ulgn4xPC9zqRpjvZaGyST8cRX4YElOOAH/vtEV7A9pEtk8nyGU
	ryVL1EHQkVkp5U+rIi4kBuAfX1UuYTBiWcCspT2GZ2v28WgOGHY3ArhoZSqt34f3m7XsXPzpJ0A
	022xKGZIlSI4xoAkyRuFYzAnQk10AToQxFHYT738K+WrxluVXBk3sCPxIdT/fbrAM8Seqxtg03t
	fqUomtB9Eeui59+W3MtqAa4iw9SWDG8qWjQzWSjHuhWwODspOzPz0Afw1BRzc3QVSTq5VX3ZQJW
	XwYMirdRl3Lm1K/tu0rEMv2SRP9Aw8PsGyZh8QvaaP4FwKVKTyFkn914nk9uUzktrnfbdYy6E1s
	ao=
X-Received: by 2002:a05:600c:1909:b0:480:1d16:2538 with SMTP id 5b1f17b1804b1-4805cf67512mr87311085e9.23.1769441868640;
        Mon, 26 Jan 2026 07:37:48 -0800 (PST)
Received: from localhost (p200300f65f20eb04e3c7513b867411b3.dip0.t-ipconnect.de. [2003:f6:5f20:eb04:e3c7:513b:8674:11b3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4804d8b4fc3sm281495245e9.13.2026.01.26.07.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 07:37:48 -0800 (PST)
From: =?UTF-8?B?IlV3ZSBLbGVpbmUtS8O2bmln?= <ukleinek@baylibre.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH] systemd: Explain background of creating /var/lib/systemd/backlight
Date: Mon, 26 Jan 2026 16:37:30 +0100
Message-ID: <20260126153729.2758442-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1102; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=IeCbl2qD1fd7ZxOw8R2QJ4AR1wPLlH0N+kSKxy+0GhI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpd4o5a6mIybiKYcZoFzPZTvuaVTqlUJKJt6a/4 wpHqMbAAA2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaXeKOQAKCRCPgPtYfRL+ ToeoCACkKLAu0AAQG9GqrLnP+5GCfY8WJrMyEBVoCiF+hOhfKNKXTPV+uD4jiPN3OLUt7DB00tH Sczlad06zLMl203l8iEqgPpFsOHAdNrFoajnaeGDFOcEE+5ajlS8h8oA7/YS9+N7IFl601sMunn rA1X/vhgJx/9DfYhX46gBbKmpED/Qy9FZSRtwbmb59OSS+YLgEIotyCrIp7s0R05dwaoEdJHjHL Wn6v2rSalwem0JUdS3uBzKaWAKvqMF8UlyReE4VPvx7s2ICLVZvcWNxMHz/juI2zf/vJL78F0z1 KbzH+fOK8Q9TzdC5ehAkLkw2WGXOOLjF0pXX7/A1It67cSyh
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 15:43:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3086

The reasoning is taken from commit 5d203f903979 ("systemd: create
/var/lib/systemd/backlight in advance").
---
 recipes-core/systemd/systemd_selinux.inc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/recipes-core/systemd/systemd_selinux.inc b/recipes-core/systemd/systemd_selinux.inc
index 7d466ee608c8..4eb7194444d2 100644
--- a/recipes-core/systemd/systemd_selinux.inc
+++ b/recipes-core/systemd/systemd_selinux.inc
@@ -1,5 +1,11 @@
 inherit enable-selinux enable-audit
 
+# The systemd-backlight@.service which is called after selinux-init.service
+# will create /var/lib/systemd/backlight with incorrect security labels,
+# this causes the systemd-backlight service to fail to start and to stop.
+#
+# Creating /var/lib/systemd/backlight in advance to make sure it could
+# always be relabelled by selinux-init while first booting.
 do_install:append() {
 	if ${@bb.utils.contains('PACKAGECONFIG', 'backlight', 'true', 'false', d)}; then
 		install -d ${D}${localstatedir}/lib/systemd/backlight

base-commit: 1db6bf1b573b9c908752602c1e2b6a30368da3b7
-- 
2.47.3


