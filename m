Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6966C52CDC
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 01:06:40 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
 by mx.groups.io with SMTP id smtpd.web11.46856.1722215198137665758
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 28 Jul 2024 18:06:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=X+lmdj5/;
 spf=pass (domain: gmail.com, ip: 209.85.128.179, mailfrom: akuster808@gmail.com)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-66493332ebfso14414667b3.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 28 Jul 2024 18:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722215197; x=1722819997; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ReE02gsRsLDdLVLXdegxbTLkHkrqUI9MohPGEHOtrSE=;
        b=X+lmdj5/dysSsIfBECQokXBMGpHBReCupnm9f6GIW2lFpb4+x/ayVcZ1pVDApszpbn
         HCWlQ5L7GuORnCP1Moc5RJvd2vb4495fP73l/fKb4zi/4i1sHP1rafRbGCEwH1x3SMV9
         evCEBmlOXQSoTg5273uIJOKMHHpSwvJbVYgwOb8Q82xYqr2P9HItRfQajtCoQafut/Zc
         qMha026Myd9+qevr3P0nTokIdz/pu50fkEzjM6sjQZMEHiJZCzCwY5ast8p58SZXCBOT
         xMPz/qbmmUv+W89UyP9kV8IOJRgGthOPrdTZGzI0VfEPsGUNOEk3HNjgIILFtLFY3yKI
         Jh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722215197; x=1722819997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ReE02gsRsLDdLVLXdegxbTLkHkrqUI9MohPGEHOtrSE=;
        b=s1QWwiz9TbedCDHMEXPX9KCg1Q8yF0+h67Ee/cr7RuYiNGzqa9cM5aHpPe1y5YUgyp
         I9r3wEDuLoD0I/xAAaa5uUs1/lDn4EyI6IdRiE+IkdmFkTgD1n1xotOgRi1Mr8U4Cjgz
         NPjzuruXc3HtZag70WuiTFLsB3mtaraIG4oUfM1R8k8tM9FM3HKNvJDXTUse/eeO+4g4
         /gcwdBw/F0A9EqGcoGAmUTsXwM4+8v3OraPNFOMPf8zyfRWCGFWF/uRwiBeU9UY3H+gL
         Wx3DgQmcHXYFdx0t/ApBptv7MF/aWwY7KMvbj7URMyZPVwxKVelrK5ATClrRkf8tfE5P
         o2ZQ==
X-Gm-Message-State: AOJu0YyQnUG4R7QSqd6GxaQ371odM6+s0GiYU8v6bf64emEEWMyKt5XO
	YeZL+tmfdbwcwuNND+JXSycRxXTH0/uYzHVmH3VpuGh2J9r/OEgv7DcRWA==
X-Google-Smtp-Source: AGHT+IFqwGHyEa7WZ9eXEl+IPmPmKgj3J60jjQhLXXBmUQ4nxFc2O42wv23y1gTqgIW0E74+YrPmvw==
X-Received: by 2002:a81:8682:0:b0:643:93dc:731c with SMTP id 00721157ae682-67a06ede635mr80232527b3.17.1722215197038;
        Sun, 28 Jul 2024 18:06:37 -0700 (PDT)
Received: from keaua.attlocal.net ([2600:1700:45dd:7000:47bc:453d:d517:b47])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756bc9edd8sm18543157b3.130.2024.07.28.18.06.36
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 18:06:36 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 4/6] suricata: fix QA warnings
Date: Sun, 28 Jul 2024 21:06:32 -0400
Message-Id: <20240729010634.1991558-4-akuster808@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729010634.1991558-1-akuster808@gmail.com>
References: <20240729010634.1991558-1-akuster808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jul 2024 01:06:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/484

ERROR: suricata-7.0.0-r0 do_package: QA Issue: File '/usr/bin/suricata' from suricata was already stripped, this will prevent future debugging! [already-stripped]

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 recipes-ids/suricata/suricata_7.0.0.bb | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/recipes-ids/suricata/suricata_7.0.0.bb b/recipes-ids/suricata/suricata_7.0.0.bb
index a137498..9795e95 100644
--- a/recipes-ids/suricata/suricata_7.0.0.bb
+++ b/recipes-ids/suricata/suricata_7.0.0.bb
@@ -114,6 +114,10 @@ do_install () {
     sed -i -e "s:#!.*$:#!${USRBINPATH}/env python3:g" ${D}${bindir}/suricatasc
     sed -i -e "s:#!.*$:#!${USRBINPATH}/env python3:g" ${D}${bindir}/suricatactl
     sed -i -e "s:#!.*$:#!${USRBINPATH}/env python3:g" ${D}${libdir}/suricata/python/suricata/sc/suricatasc.py
+    # The build process dumps config logs into the binary, remove them.
+    sed -i -e 's#${RECIPE_SYSROOT}##g' ${D}${bindir}/suricata
+    sed -i -e 's#${RECIPE_SYSROOT_NATIVE}##g' ${D}${bindir}/suricata
+    sed -i -e 's#CFLAGS.*##g' ${D}${bindir}/suricata
 }
 
 pkg_postinst_ontarget:${PN} () {
@@ -131,3 +135,4 @@ FILES:${PN} += "${systemd_unitdir} ${sysconfdir}/tmpfiles.d"
 FILES:${PN}-python = "${bindir}/suricatasc ${PYTHON_SITEPACKAGES_DIR}"
 
 CONFFILES:${PN} = "${sysconfdir}/suricata/suricata.yaml"
+INSANE_SKIP:${PN} = "already-stripped"
-- 
2.34.1


