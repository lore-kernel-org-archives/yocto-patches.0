Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F76C0218D
	for <webhook@archiver.kernel.org>; Wed, 29 Jan 2025 15:11:37 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web10.14724.1738163488295272050
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Jan 2025 07:11:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nbcrzqsQ;
 spf=pass (domain: gmail.com, ip: 209.85.214.169, mailfrom: akuster808@gmail.com)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21644aca3a0so7587695ad.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jan 2025 07:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738163487; x=1738768287; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uQ6O8R/aZwtqq+MKoZF3RJmUZ0yDbwVwHey8MVePGaA=;
        b=nbcrzqsQFa586qm2s2ke6wskvayVQsTkTBhxLIXpCyQbtWtrfpyG0Blhs6zkIfiaI2
         SRq1GCmwFRoxYfbonBSzY+NVhBaJzwfMUbYTFJ1edxeWJYlU3ktGt0iLQo/+CYD3tDPQ
         mqTEPoIHExqy4Df1dsr9XujF1BsijL4C2JVWnWoZ/gUECmahuVQU3oQnPwPyJjMuFfJw
         VNeIfnIWZ7ePBEAk7ws69Y2lFWepxfu+H24vwPUtaib7VKOg9yP7vm9X4S8XrpaP9MzA
         Lw+zh64wl4tozJO/Ch5qI0lAiIPkbFODRosYp2uB91KPqPrEwZ2xLWIP/kyvLTdPcuFC
         acQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738163487; x=1738768287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQ6O8R/aZwtqq+MKoZF3RJmUZ0yDbwVwHey8MVePGaA=;
        b=RNXHnmguXb/Fk8tAJaLvtitZYVXBPpCDdWVaCkylqyuXXFHu8FObFCwPHBj/JZysqZ
         lhzufawW4sAvL0pWXqtuvTjwFrcmP0RZIdIueuUxxsXZQnW/l6lVdsBX9DCdVt1N3WEF
         7+aIGOeH/fqN3gjeAofpJ+Xm7/ajuI/pGf0fra0C9EeniVVzu7zgavutVTpWjfoYagAN
         7BixKLDVwe5Pbe7o9AN61qidWt75ZYsrSOW2P1cTQGoLgY6ZKCSPx7tzI54GadwGdVgx
         0e82JbBeDYlx97dfgVoL995hYtRj+hn3GF08RwveJGXp52+m1gK1OGLIynjngQaXl0rp
         /IMw==
X-Gm-Message-State: AOJu0YzTtRG/I5lhXfaHAOlpy9m02WZdrN+nTezmSIpcxRtS4Podhym7
	3RhW3rId0t2V70q52PWOCC15GCSBFU94cJLnIDUKSnzDw+F55I8hyjEfPQ==
X-Gm-Gg: ASbGncuff3xDPxFTgGmpML29/0CuPyP5rXIUF806I2Q+rccQ89Q4WqBsv29Y0gSOL+U
	1j7UBzmonQ1lcrL/aFnTpnLHs2n9T6Btu6Q7c0WuUSNPrzbEcJlqCnczY61W6u0hx+O/umH++RA
	RUbpPTGXBwTul75TDVl2xiThUtmyL2P98ql6US/+bQ/5ZD1Ep2b7fkP6i7kiwXReKBBwrzP2q46
	Yg19p42ilIx/r8V1UpJBWKE02mK9lOJ8tPDMp7mblaxwKc8mf6568PbH3vAMEfysv1HyJIjMd0I
	g9w7MbMzaqk=
X-Google-Smtp-Source: AGHT+IGar6lT+X0bQTS+nXr1qfTT1v1SqaRgXpE+8zvnK5mvLto8mOvrhaXuMHxSWge4QYdhIuv0bg==
X-Received: by 2002:a05:6a21:498:b0:1e1:a647:8a54 with SMTP id adf61e73a8af0-1ed7a640d32mr6268957637.20.1738163487142;
        Wed, 29 Jan 2025 07:11:27 -0800 (PST)
Received: from keaua.. ([50.240.203.141])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a760e2asm11308762b3a.88.2025.01.29.07.11.26
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 07:11:26 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH] lynis: update to 3.1.4
Date: Wed, 29 Jan 2025 07:11:24 -0800
Message-ID: <20250129151124.292270-1-akuster808@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jan 2025 15:11:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1012

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 recipes-compliance/lynis/{lynis_3.1.1.bb => lynis_3.1.4.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-compliance/lynis/{lynis_3.1.1.bb => lynis_3.1.4.bb} (93%)

diff --git a/recipes-compliance/lynis/lynis_3.1.1.bb b/recipes-compliance/lynis/lynis_3.1.4.bb
similarity index 93%
rename from recipes-compliance/lynis/lynis_3.1.1.bb
rename to recipes-compliance/lynis/lynis_3.1.4.bb
index f6fddd0..4059662 100644
--- a/recipes-compliance/lynis/lynis_3.1.1.bb
+++ b/recipes-compliance/lynis/lynis_3.1.4.bb
@@ -8,7 +8,7 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=3edd6782854304fd11da4975ab9799c1"
 
 SRC_URI = "https://downloads.cisofy.com/lynis/${BPN}-${PV}.tar.gz"
 
-SRC_URI[sha256sum] = "d72f4ee7325816bb8dbfcf31eb104207b9fe58a2493c2a875373746a71284cc3"
+SRC_URI[sha256sum] = "c4dbcddd429624d5b2319cd3b19728e18a7885b70b8eb0a9fdd3ca5f0ae28eb6"
 
 #UPSTREAM_CHECK = "https://downloads.cisofy.com/lynis"
 
-- 
2.43.0


