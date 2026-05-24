Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80748CD5BC7
	for <webhook@archiver.kernel.org>; Sun, 24 May 2026 12:16:06 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7162.1779624965808596248
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 24 May 2026 05:16:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=aF5/1bVt;
 spf=pass (domain: konsulko.com, ip: 209.85.219.45, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8cc0ef7c306so57667026d6.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 05:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1779624965; x=1780229765; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kFH7foQyZ/rkNWZkhpDpHnf66hqIv7cllgmxX9Zg674=;
        b=aF5/1bVt3Wc+y+mxyObLUUM77hfMdbGZQVhK+QnvHUD0tbsGoH747oVyYv6a4wHgfu
         R+6/VagZrn2T7T9LLiuid7P2TL8te887b0ib152ajgqfPOwkRSnQA+0wpvXMMzmpyKDk
         g7ceMePzGVom7OWGh2ajY/tXOK+doflIrQpHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779624965; x=1780229765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kFH7foQyZ/rkNWZkhpDpHnf66hqIv7cllgmxX9Zg674=;
        b=adFD0GgVoqArLYDHym98OGh24SiwbyQv+6efdSZPesLufrbU4kdvbLDzuXqD/nUO8P
         rtxj8+G6Uvx638FY8pPj5BLm5Sj81X74sJr7AqYowQJmTi20Gf5or4D8TenXLsoH1ob6
         DyKBS9jfXQ5o04uZ5VaUCq3H1dcCMvKHmNFRoYTZQKa2PfnD8SYJqRGwgD4UfEVfSivb
         OrvVXKT5CB3rIptnELu1jhrIs5Xvw7N6X2/aVcVAYNU1nEKTiUK62fXqewJwBcoMH/Ec
         qCWJsDVRX0F25NwF6yeqlwwzaMTrQNtY91eaRkItIJ9J6Xt0dyPYXEMJN+YU/JaCWfT6
         kzjQ==
X-Gm-Message-State: AOJu0Yyn5/xb6OUTLzmkCUuG8DI2ra1FTjaoLRPNRQyB6l1I9UIcFs8r
	glZaXjtkcmQygSTz1zf9xhPgxVrM5275CDvr/uEzsFZvUfOr7/zt11wYgPR2bkU8Z6kXgbsaRue
	v67US
X-Gm-Gg: Acq92OEGiKVaqIN8meo3PJyXgW1qPybO/ELxyQS5eh0rsbDwuZQhvYVg88uHhWLzloB
	CZyowcJxavWyTNvcD8qEVCQCFJy396fvv2xDAE9hM4Ws36lSjljDJq/O8VO3NVR+OR9+UyGLDdQ
	xN2rXRNk3w9dfBlMH6HPASHkmUCGDamEJYS2NaLVzqJtLNizXw5yDAmnM06SAYhVOniGaDz2qHk
	jXD9ODi7cBOjyV2tFVJ7YaOOBXcKiOeGLYSsEKAVNLXfsJfmz0VcLM5Mo5UsBbf5M6ko2Ckejz3
	8RTfTkF4Fixra8HFkczkmXWjAPBtY9okVRNZB3A5cBHYN5GVeQgLczz8reP5greA+PIFz+6P1d0
	c2zPy+sSa23WO6TzcM0y58gQBnEYn00w66BcGg4C9v+otGl0sMyOdTy7Hk0Grimf0u3zuutUW79
	g6YQEBy+RNXSX9R/b1mBtWVI5jbHSo7DHPTeeHSxqjGnO+jDaxnLC419fgskvIj5dg+JZMRgqYU
	zDGh4pkUGCFYK/g0QoKS9lYD7Pm3sMzWLk2EZwojiqXrlt1lufHCd9ZeR71qYp3
X-Received: by 2002:a05:6214:29e1:b0:8ac:b4d5:50ec with SMTP id 6a1803df08f44-8cc7b5b94fcmr168599756d6.38.1779624964695;
        Sun, 24 May 2026 05:16:04 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8130d540sm82385186d6.38.2026.05.24.05.16.04
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 05:16:04 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 12/13] aide: fix pkg_postinst_ontarget shell script
Date: Sun, 24 May 2026 08:15:39 -0400
Message-ID: <9d749026dd1054104a946565710152b50c6330ea.1779624335.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779624335.git.scott.murray@konsulko.com>
References: <cover.1779624335.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 12:16:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4018

From: "jason.lau" <Haitao.Liu@windriver.com>

- Fix conditional checks for AIDE_SCAN_POSTINIT and AIDE_RESCAN_POSTINIT:
  '[ 0 ]' always evaluates to true since it's a non-empty string.
  Use string comparison '= "1"' instead.
- Fix invalid use of '&&' inside '[ ]' test brackets. Use separate
  test expressions joined by shell '&&'.

Signed-off-by: Haitao Liu <haitao.liu@windriver.com>
(reworked for 0.19.3, fixed indentation)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-ids/aide/aide_0.19.3.bb | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-ids/aide/aide_0.19.3.bb b/recipes-ids/aide/aide_0.19.3.bb
index 9a94ce2..68e3bfa 100644
--- a/recipes-ids/aide/aide_0.19.3.bb
+++ b/recipes-ids/aide/aide_0.19.3.bb
@@ -62,10 +62,10 @@ CONF_FILE = "${sysconfdir}/aide.conf"
 FILES:${PN} += "${libdir}/${PN} ${sysconfdir}/aide.conf"
 
 pkg_postinst_ontarget:${PN} () {
-    if [ ${AIDE_SCAN_POSTINIT} ]; then
+    if [ "${AIDE_SCAN_POSTINIT}" = "1" ]; then
         ${bindir}/aide -i
     fi
-    if [ ${AIDE_RESCAN_POSTINIT}  && -e ${libdir}/aide/aide.db.gz ]; then
+    if [ "${AIDE_RESCAN_POSTINIT}" = "1" ] && [ -e ${libdir}/aide/aide.db.gz ]; then
         ${bindir}/aide -C
     fi
 }
-- 
2.53.0


