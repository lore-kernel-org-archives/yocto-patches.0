Return-Path: <t.f.g.geelen@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D74D3B7EA
	for <webhook@archiver.kernel.org>; Mon,  8 Dec 2025 22:36:48 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6049.1765233399578258163
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 08 Dec 2025 14:36:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VXJ9O3qg;
 spf=pass (domain: gmail.com, ip: 209.85.218.51, mailfrom: t.f.g.geelen@gmail.com)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b735e278fa1so834980366b.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 08 Dec 2025 14:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765233397; x=1765838197; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eOYD1KGUvzVf4sQ9d9O72HwxKlHs3e8Jue4iX5uYAg4=;
        b=VXJ9O3qgaCjUYr5PoaXrZ07VgsXP4f1B5YiUTcZqQcD7suySYWkI+F/e6y4bImhhzY
         B0hoH3T896A8RUZYYCfLpUZwTdds35LVlFqnnrkmr4U/7mAATspw4SimuOq0nmlZISHT
         zHD/ywhMQft2Q/WohwMSdLDrlldWyixMv68ojnj3BRV6B5GhEN91x/rTvKqKdUUepXWL
         rRXHnjFfr4TCIqBxMK6UChsSH2Gue2n6rnbC9MnQzU3PA6oaQB3EFTjnUJtYI25eetGM
         nxgsYTtlRIkMkLn7XNufwoARm3WMg8EIuw64bams4i/uy5EAfwFmAcK+JBC6BNKCwHAo
         U51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765233397; x=1765838197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOYD1KGUvzVf4sQ9d9O72HwxKlHs3e8Jue4iX5uYAg4=;
        b=lK9ZzSf+lPNIPZlM+HIfX4dHFonCJXnnb1Wuohj0lMEnQTobvdJPjq4u8LSQESPQg6
         FzAbt/ABjjyvlL8uZ6xiZNI3gTeqIIXXtkm5W0YDnG0/TxHZpA5EaJt5TyQGziiCOIs3
         9ITBWyuCg7OUas9uuh+SPylFHihSVb587anF5kYDGb4vmdzICjxUUPOTkc9N+1d4vr4A
         Kw94gnyPzA60rP6+a+ypa1aLqiDe1YsM6EVIUaEwfLEwsSoWLt6LHgq2b4iD28EDSRr5
         X8ljziuPfAQfSnlKfWwhsXjRMfsVMpdOjtEoIqU8Y3ym5W+3DGW/QsGczRX3OHWoP7BQ
         ccbw==
X-Gm-Message-State: AOJu0YwL/houRuSTm0+TcrEaJbANiptpvGiDAQpSB76u5qeWf/nhmET8
	ht1q8nX6iaqFPJDPjg9gAl7lILBdt4idSdD7p38D8lea9zmCYrJrnhST7UNM3g==
X-Gm-Gg: ASbGncuq6kL1dXCUBT739+Wsz7wNAu01vzSjjuL4Z5IjToDd1VPeUumdaoRX2NazaxC
	oReIOWLstufiVOa0ZpyUDERtSB9vI6oHefwRlEs9FHxA1yOm1amL0WIOoT0uY6ZhMeHduZRM4Uu
	W7Yx0rGdU6HpDopLwgEhzbkaz8a1m75lDdcTrmS0uDq/t9zcW1xClbD2x/KOaGMTKiQ9a/uDebO
	KtMhyntENJrZ6DJ1dZVMFDQDcoU+rv4UwR5/V1o+4j7wQtHE1KxlhriuDfFoBHwzYPOMeT6aKM+
	zGmSpjWdV1LNoPNZ3r8JiJI4l6uR8JKde+8GXU/rQNi5NZMfFuK5RvnBPm/KoegB5JnPvzYROCa
	FQ7Z45+pQviEHeiWPcg7QTbOVk9UERlQesQMXMM5HBKrv56iKsvaLi7rzLeDmM0tqqOgrpyokqA
	6fWS/p3+qsv631eeyHOFMWM8WbGMaYdvVWw8Yft75JKo59MbBARa3HeWXuIPSXjECz
X-Google-Smtp-Source: AGHT+IGlSjViRbHJ4IA6/Q+X4W1wzKyaInzLRRhC4EcBN9z6omX5EV7WmQJMlGH7gNvgk+qrLP7RzA==
X-Received: by 2002:a17:907:728e:b0:b73:9792:918b with SMTP id a640c23a62f3a-b7a24331131mr998351866b.27.1765233397097;
        Mon, 08 Dec 2025 14:36:37 -0800 (PST)
Received: from control-center.fritz.box (150-12-20-31.ftth.glasoperator.nl. [31.20.12.150])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b2edad10sm11897670a12.9.2025.12.08.14.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 14:36:36 -0800 (PST)
From: Tom Geelen <t.f.g.geelen@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Alex Kanavin <alex.kanavin@gmail.com>,
	Tom Geelen <t.f.g.geelen@gmail.com>
Subject: [auh][PATCH 1/2] testimage: update package installation logic to use groups
Date: Mon,  8 Dec 2025 23:36:08 +0100
Message-ID: <20251208223609.378679-1-t.f.g.geelen@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 08 Dec 2025 22:36:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2752

Incorrect variable pkgs_ctx was passed to _get_pkgs_to_install. It’s undefined in testimage().
_get_pkgs_to_install iterates groups of upgrade results and extracts PN and PTEST_ENABLED from per-recipe context via bitbake -e. Passing the wrong or undefined variable prevents building an image with the upgraded packages and their -ptest addons.

Signed-off-by: Tom Geelen <t.f.g.geelen@gmail.com>
---
 modules/testimage.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules/testimage.py b/modules/testimage.py
index 6377368..849a9f1 100644
--- a/modules/testimage.py
+++ b/modules/testimage.py
@@ -74,7 +74,7 @@ class TestImage():
 
     def testimage(self, groups, machine, image):
         os.environ['CORE_IMAGE_EXTRA_INSTALL'] = \
-            self._get_pkgs_to_install(pkgs_ctx)
+            self._get_pkgs_to_install(groups)
         os.environ['TEST_LOG_DIR'] = self.logdir
         os.environ['TESTIMAGE_UPDATE_VARS'] = 'TEST_LOG_DIR'
         I( " Installing additional packages to the image: {}".format(os.environ['CORE_IMAGE_EXTRA_INSTALL']))
-- 
2.43.0


