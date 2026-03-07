Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CCDFC9EEC
	for <webhook@archiver.kernel.org>; Sat,  7 Mar 2026 10:30:25 +0000 (UTC)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6855.1772879419439978188
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 07 Mar 2026 02:30:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=JgU19aGP;
 spf=pass (domain: konsulko.com, ip: 209.85.160.177, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5090c27d3f6so311471cf.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 02:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1772879418; x=1773484218; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8dBUS2qNALhJom0Xb1yNRSQsfOk5zRr6r7qOwssf/aQ=;
        b=JgU19aGPMje9X4aH1IZXPbYO21EDLRcXv3lCdQiW1BlAzmQVg7iYfi8ICbrQAyJw5W
         ioOvGqq0AZ4uq86uFy8yFq+IrCQPTy/DQNeDqjd7wisQI0ZIbg5oMq+qFiQlVumSuNaq
         QIoXxa5Q2j5JgAT6rDyqOPXUBmpyU0mYTgvPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772879418; x=1773484218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8dBUS2qNALhJom0Xb1yNRSQsfOk5zRr6r7qOwssf/aQ=;
        b=H1ywzzw5q6HmdDAOwwkU9Tlf3CPZ8l5igGAs9ZkI+/SBcA0cEnuO2WDK4upIYo7sAB
         rklu9yP2ze1NorsjXilNFkxYqnhpqgJpYRY/k2J5Ib86xR2K3iH5r3FkTERfs7FuxH0D
         X6qrrsDJQlENiC4RAHgbeALJCO7mGbJAYQD+FHV90urdNKAsQ9CEjQvpZOU4nmYtwrEJ
         UcLAdjeujcOuZ9fMyERlcAyuCp6KTXxyCuakqOVNAUvngofmIK2o9UDMdb1rIPBXgew2
         PLuKQNO7nnKDe2AWidCRqjvV+O5E8Z9Lomlc3zbDXvfprnL3HyQnJv/ihPskz0sTiJTk
         uDBg==
X-Gm-Message-State: AOJu0YxjoVxnNTO8Igd9UqnqNbe3XxyBC8C/4Ch6pc89/9eiUv7RDYfc
	0hHj/Lw/EbfxjLWZxBmXC3P1kTYTChUKWATLjMiojXCyWz55lx5bWYlS97QeLT0boXecy00lM+E
	V/dOK8II=
X-Gm-Gg: ATEYQzyENX4tbTiUZ8TRBw1aEUhJe983fhx2wGxjSU2xsjxoVMwi9qU6OxsXaWaL0PQ
	DzUvdzfyJOmIA0ssp9sL/T3EYuxy13EiVyFMfKdvuqdkscOulgZee9RvWxXOhlJodScsj1QrqNK
	PfUXPuZWYmy14+A1vEHo5TI3wyBUvOaiTIUBzl8OrfDb9XmnsbKkdX2hWQIu1reoCu4iaA0rrA4
	XhA65Fi5Xd/uFmQjhs2cNQbAaoKByLKkGpM4kt7UGPvB85GYdCf63+JxoGvlpLdRrxWEteNeMnK
	4j0Cvc8bXHvimcoGgrInAQm6cwq4hxEcd8U3fp3A478BAWGf5eoSX+NWhWkjDfeVpb9w19acJtr
	STYNKjMnfXkcMxUTw22RwrT8g9+eOlL8M3bIjgI/9GW9TeHymW5skarsv4zjIcE6E7AdncitKmQ
	FH3WpUE/a7i2Luj6t+LbFy6tvAcvfm/61Ij3TIjAcwXGALVDv9x6RrnUBnZnz8yk0IR1/LnES5o
	x8APxtNj/ef4SGDVYf8KmpuwinhgE+F055OoKepVPXflPRF4f28MPXtJrWpAWjo
X-Received: by 2002:a05:622a:14cd:b0:501:13d5:a755 with SMTP id d75a77b69052e-508f4705d62mr62740911cf.7.1772879418136;
        Sat, 07 Mar 2026 02:30:18 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a316ea1b1sm31472556d6.36.2026.03.07.02.30.17
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 02:30:17 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 6/7] nikto: fix branch
Date: Sat,  7 Mar 2026 05:30:00 -0500
Message-ID: <6320bcb7691f1c78e29f74e830e1d05ed9656fc9.1772879169.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1772879169.git.scott.murray@konsulko.com>
References: <cover.1772879169.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 10:30:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3371

Upstream has renamed their master branch to main, adjust SRC_URI to
match.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 dynamic-layers/meta-perl/recipes-security/nikto/nikto_2.1.6.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dynamic-layers/meta-perl/recipes-security/nikto/nikto_2.1.6.bb b/dynamic-layers/meta-perl/recipes-security/nikto/nikto_2.1.6.bb
index 6d83265..5668f87 100644
--- a/dynamic-layers/meta-perl/recipes-security/nikto/nikto_2.1.6.bb
+++ b/dynamic-layers/meta-perl/recipes-security/nikto/nikto_2.1.6.bb
@@ -7,7 +7,7 @@ LICENSE = "GPL-2.0-only"
 LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"
 
 SRCREV = "f1bbd1a8756c076c8fd4f4dd0bc34a8ef215ae79"
-SRC_URI = "git://github.com/sullo/nikto.git;branch=master;protocol=https \
+SRC_URI = "git://github.com/sullo/nikto.git;branch=main;protocol=https \
            file://location.patch"
 
 S = "${UNPACKDIR}/${BP}/program"
-- 
2.51.0


