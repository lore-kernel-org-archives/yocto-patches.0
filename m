Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CAFCA1015
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 19:45:41 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
 by mx.groups.io with SMTP id smtpd.web10.3931.1757015135704832957
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 04 Sep 2025 12:45:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VeqKsvwm;
 spf=pass (domain: gmail.com, ip: 209.85.160.173, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b338d7a540so18927581cf.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 04 Sep 2025 12:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757015134; x=1757619934; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a3KTYP0mbwT3up3IN6pbf9NKd/KHuqlx26iT8Gme9fY=;
        b=VeqKsvwm/F67FMPZ3a84Uq2A5PyKjVjVDR9aE1zur+qBx4NiRB/o9C9P+8X15za/+t
         X8iF8E2xgz7QE8HfIt+3TfhHcXwPza5ombKJ5D80oH/GDDe2ESyKzjQMn6exLvwkuTp8
         tyX+IewAUa5XnCePKhDIjBPXrixObvh11hLXX87S8cmmddtmDiie397pmDFLwzduRJ/D
         lJK0MZeKDk6AQcFMOZxPKiPnnIIOWh5W0mp3C03Gxrhde0ZguB3PtSW1G0e26jBQqtf9
         x8T2VGXZ8LvLQJOiA80MGoAzx2jN7ngz13Srh22oo3H/NwgZzsdwFDcm4AgVxyOGKk9q
         yHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757015134; x=1757619934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3KTYP0mbwT3up3IN6pbf9NKd/KHuqlx26iT8Gme9fY=;
        b=QRAL48RdR8ionN5H3e4ubVTLOydlZBi2opxLiB9/MgMJQ0iIVJMmAq/bvZ9WO3GyHw
         sgQPclSU3xUbeQEeAg6R2oSmtzDh3IvXD6uE6PcC7vFB9Lw6/F3mEzMzc8ouE/AOhjHT
         wXgVve0/kFVXedxOcYmIP1mTeXFKOrctKJ++wyR86xGYJ0hvzh0NtQ3lxfuaYvrphcKV
         uQ0cRYluc9+lvrdaXbZGkh9yJf7LjlfBL58wYeF/0qZRZaBy/Q2uJ2LpVcZXN1j/VrnG
         FIK2Zsrg7qNKerMlNlCqN2BiImjAaPFHy78aJ7CYEx3XJiGoCt4QJmLjkPD6S+KcECLm
         sfJw==
X-Gm-Message-State: AOJu0YxHJ6CzQtqQsWS52CPDtqkuFCh8LkAv5rOx0G5vJQnP80FNM3Qp
	SoQ4ng5T4e1mZOoRnXeEh4p5FUEMOleQ8Y2cAbBDlYYqgnKQNdWkNqu4w/6Gzw==
X-Gm-Gg: ASbGncvAocS/iPimoJqRQ05lCiaCAB+8XHCqbEiuOBg754TPpge04vbGt6nrv+EfM9a
	JboV+f0fE5m78Xs+4f9v+hXBTZ9fhne0APDHsmp87qokNKlRQgCc+6X9SZGoGEsbuA6Peo5Z4SE
	8T7vg83LeFAzpq5lrA3beIKOKz2WrRNluqz0PfJsBE4xsHSRjaq1URhYWBelTs9eUIgWu0zm6kO
	tfGXuCoy2CpwUt5NG5U8/8bF0o6dsnUEjuBsUrWR0DPKQkUFlclJeNLkgZtt+z+9CSxW9z3AB9W
	zsjsFpgYDy0vriacwcYWInlO+6nOf9HxXhwsCk97yFD4bjJSI//QCVO2y4HlbLAl1GuzvIUSp7+
	jraD9mUUHcECUWMEfwIvTurHJfLKw2KTapvXTpUF/y807qFYGHJUQvBGjGCVBDVJmeg==
X-Google-Smtp-Source: AGHT+IGuh2lfBcBnAVnE5koPxV8OdoxgAvBJicfwhwjUqpkflcfBlJ/BEzR9T2f7oCmTYeeg5qPm7g==
X-Received: by 2002:ac8:5786:0:b0:4b4:56b2:5c79 with SMTP id d75a77b69052e-4b456b25f12mr99989621cf.55.1757015133940;
        Thu, 04 Sep 2025 12:45:33 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f760fa9sm33525141cf.26.2025.09.04.12.45.32
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 12:45:33 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH 2/2] nanopi-r4s: enable r8169 built-in
Date: Thu,  4 Sep 2025 15:45:29 -0400
Message-ID: <20250904194529.22656-2-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
In-Reply-To: <20250904194529.22656-1-twoerner@gmail.com>
References: <20250904194529.22656-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 04 Sep 2025 19:45:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2137

Since the Realtek RTL8169 is part of this board, enable it unconditionally in
the kernel.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 recipes-kernel/linux/linux-yocto/realtek-r8169.cfg | 1 +
 recipes-kernel/linux/linux-yocto_%.bbappend        | 1 +
 2 files changed, 2 insertions(+)
 create mode 100644 recipes-kernel/linux/linux-yocto/realtek-r8169.cfg

diff --git a/recipes-kernel/linux/linux-yocto/realtek-r8169.cfg b/recipes-kernel/linux/linux-yocto/realtek-r8169.cfg
new file mode 100644
index 000000000000..811d42a79bf3
--- /dev/null
+++ b/recipes-kernel/linux/linux-yocto/realtek-r8169.cfg
@@ -0,0 +1 @@
+CONFIG_R8169=y
diff --git a/recipes-kernel/linux/linux-yocto_%.bbappend b/recipes-kernel/linux/linux-yocto_%.bbappend
index 5d68c7d56e2b..da1b172294e7 100644
--- a/recipes-kernel/linux/linux-yocto_%.bbappend
+++ b/recipes-kernel/linux/linux-yocto_%.bbappend
@@ -31,3 +31,4 @@ COMPATIBLE_MACHINE:rock64 = "rock64"
 COMPATIBLE_MACHINE:soquartz = "soquartz"
 
 SRC_URI:append:rockchip = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
+SRC_URI:append:nanopi-r4s = " file://realtek-r8169.cfg"
-- 
2.44.0.501.g19981daefd7c


