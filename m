Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC833CD5BAB
	for <webhook@archiver.kernel.org>; Sun, 24 May 2026 12:16:04 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7102.1779624962116614455
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 24 May 2026 05:16:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=O1C3A7Js;
 spf=pass (domain: konsulko.com, ip: 209.85.219.53, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8b3fe2f19a4so94951346d6.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 05:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1779624961; x=1780229761; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nH0H2wjwUgo+A6BMjQKPEtejB0FTZReqWeMu9Y6fS+A=;
        b=O1C3A7JsxcpLfIzw8PgHdwK4DVhJmhDCnhw38lzFEex+fmm3CqJ3ZqwQgsve2Xe3Yq
         HmXmPmIj8Rg7V2UwododU0Gnz8O4tg+++D6PPkRusddmlJyiWBC6shQ8ivlblT3UfmJz
         UNyCdhgIbftZKz/xHN7PUiN1drCvZUhWIj/p0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779624961; x=1780229761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nH0H2wjwUgo+A6BMjQKPEtejB0FTZReqWeMu9Y6fS+A=;
        b=hC0n7ZkM0u/uCkQXhVG9YildIPgRSq+QWOG5MhcS6Hen5vLyXBn/ZWkSACfculOhKS
         kWqFmFJw/B652VlZma3hSWJ01nL06BLagimtA1s3q3hxmEXdRSw9obMmsX+AAYTDVHgz
         7RB0d1kcbqiHDWsftF8m/OPOIkz6H7Wx9mqHtVU6pljkk+aDlWL40BKmQeK2xGcJe0co
         H2yyiSQso8ldXjEJ2N6AJJmfOUV7sZwWotG84NgDBs5lw0iPuZP/Q2vnjU8FcqzS9V4u
         xERHXfxfiFY18N2+YPWzxO0SODrx0AdEV0ZhLMaymVQFL6lZvhczdinHEFQhDJfVoQaT
         r8AQ==
X-Gm-Message-State: AOJu0YzgHxS5BQbrnNLQyPtm5mJHJyjexteI0CZfz/F1+Rvspecprd3b
	POODX5OV8cYQQj9RxHi6OEkrXoxmphjKH/zQ/4TVktAuQ2FwRGv3zTjGs0Jll0cnMrH1kgjVGeA
	V7bfZ
X-Gm-Gg: Acq92OGI+InKvpmLaKqhmzxnfA5IgAPvkT7FU4/qYTsJAkTL3zxIIEeOUT8ZkEohL7z
	txlkVjEJhbgQxwJ5QahwJZtBHuwgwjxqLkOPQOxEzuLVvJCYs2CiarKtYohHwXqY/9gCRTemKMS
	f6O89fROF6HQjkR/QS9HILepyBOcGFDkQBQldkCDRKMBNZRgpHXb+JLQeqgqH5ASRs8o9F1/tjN
	ZgSt3lMqizWeot5TmKpJiOetEe4f0A73DHL/li5vu2wrAT9CAEAX4cscTmzps46eDt2q1DI3+kt
	9u3l/Driu8jnD07Gs6Byy4zvrLtPHOFsA2WLaSvD71StbmVQUkIYAT0AreeY1CGJg6ph97ZMQJ3
	G4yP/FUBg2tmi44zVwHuLfJRl6gNQRmgey8GUjfGy3ErGD0ROdzqepYu4mbjWDjKtjKaZWENjCt
	mLv+8AOaP23azOonh9nM/Ge4f/5F2mM5HjDVJiZZ2NwtFiIgYCnxpAVz/RutIcsotefp1w9es8W
	RB0m3CNy68rwXxkPMK0uC976JnfqRnIAKtK5NQ8wn756GeA8MglX3vI888VXNi7
X-Received: by 2002:a05:6214:2e48:b0:8ca:1cee:7c4b with SMTP id 6a1803df08f44-8cc7b67e09cmr190265906d6.39.1779624961003;
        Sun, 24 May 2026 05:16:01 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8130d540sm82385186d6.38.2026.05.24.05.16.00
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 05:16:00 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 07/13] parsec-service: do group membership modifications in useradd
Date: Sun, 24 May 2026 08:15:34 -0400
Message-ID: <a9384af621c5dd1b80bf3999bd3993190e8348f7.1779624335.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779624335.git.scott.murray@konsulko.com>
References: <cover.1779624335.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 12:16:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4013

From: Ross Burton <ross.burton@arm.com>

Instead of calling groupmems after creating the user, we can tell useradd
to do the group membership when creating the user.  There are several
reasons for this:

1) Consolidation of the calls into a single call means creation is atomic,
   it either worked or it did not.
2) The existing logic doesn't work if both TPM and TS were enabled.
3) GROUPMEMS_PARAM is broken in oe-core master[1] and this will not be
   fixed as groupmems has been removed from shadow[2].

Instead, construct a list of groups that parsec needs to be a member of,
and pass them to useradd.

[1] https://bugzilla.yoctoproject.org/show_bug.cgi?id=16277
[2] shadow 388ce70 "*/: groupmems(8): Remove program"

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../parsec-service/parsec-service_1.5.0.bb    | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.5.0.bb b/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.5.0.bb
index c5f9978..0268c0e 100644
--- a/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.5.0.bb
+++ b/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.5.0.bb
@@ -72,9 +72,22 @@ do_install () {
 inherit useradd
 USERADD_PACKAGES = "${PN}"
 GROUPADD_PARAM:${PN} = "-r parsec"
-USERADD_PARAM:${PN} = "-r -g parsec -s /usr/sbin/nologin -d ${localstatedir}/lib/parsec parsec"
-GROUPMEMS_PARAM:${PN} = "${@bb.utils.contains('PACKAGECONFIG_CONFARGS', 'tpm-provider', '-a parsec -g tss ;', '', d)}"
-GROUPMEMS_PARAM:${PN} += "${@bb.utils.contains('PACKAGECONFIG_CONFARGS', 'trusted-service-provider', '-a parsec -g tee', '', d)}"
+USERADD_PARAM:${PN} = "\
+    --system \
+    --gid parsec \
+    --shell /usr/sbin/nologin \
+    --home-dir ${localstatedir}/lib/parsec \
+    ${@parsec_groups(d)} \
+    parsec"
+
+def parsec_groups(d):
+    groups = []
+    config = d.getVar("PACKAGECONFIG").split()
+    if "TPM" in config:
+        groups.append("tss")
+    if "TS" in config:
+        groups.append("teeclnt")
+    return "--groups " + ",".join(groups) if groups else ""
 
 FILES:${PN} += " \
     ${sysconfdir}/parsec/config.toml \
-- 
2.53.0


