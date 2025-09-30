Return-Path: <vanusuri@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14773CAC5B8
	for <webhook@archiver.kernel.org>; Tue, 30 Sep 2025 03:49:57 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web10.17190.1759204192482482829
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Sep 2025 20:49:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=XFk4lCDL;
 spf=pass (domain: mvista.com, ip: 209.85.210.181, mailfrom: vanusuri@mvista.com)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-781001e3846so5016170b3a.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 29 Sep 2025 20:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1759204191; x=1759808991; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXK/kAgRvuttv8n6eoE9uUz743wIUr/8mSpKgiRbvOI=;
        b=XFk4lCDL/2mquSVfZVITPoTiv8sXXqzTriPw5bphiIysq2GzYSoGSmsbQ2suYK60xE
         7Dl2+mP/RIQKMXXdfa+Raxdg2sbqTZioJeaIYa+XkEouyez4UU7UakxH7zdexD9duwr3
         AVWsTsMqamD8OxGzMeAa6RbXP1yAVL3Wx29Qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759204191; x=1759808991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXK/kAgRvuttv8n6eoE9uUz743wIUr/8mSpKgiRbvOI=;
        b=s1ijGUZDp0015FJ/oJtP3jfdMn2mCKWN1ONidltJ+G6dzmHuuGbK+Nr+cV5tbZtgAG
         kuBmM2bSVLnR8Us9114IC6BxV2iSodhdR6Itz3hFm0U1PuNyP2DIz8KhUMiXYRNgWh3h
         Q3d7xCDIlk5YUfvBZHXkFK0ijvBcZZU1vpkZzN14zY8JQx/sj54ivSehrWRRC8Htv+Z+
         Ma55+yaAEdWaUjqAV7XbpWjI2S7KW2ztAHYdvUuF4LVF8t6+r+Gou4jvpBsmptqOsjKH
         r1mzUfSD8VEUnogTQKRIgoasolym1pa63yTcUVgzmmBQIuoqeprIX6M7t0CvIXIVsizl
         hsQg==
X-Gm-Message-State: AOJu0YwEQfRYjNp0P8ffpSyRbJKaEWEg9g8dofawOlXvduRDsIxaP8vT
	dhOMvKuX3Oo2bWoQnnIDzAP0cO39xDlEAZCaFbwmwtsg9/Itug9JyXAU7eYHT33Pk8Oa4nKnVfT
	0JsmhtXk=
X-Gm-Gg: ASbGncuzKzuDll5BzoLscV+4pjdoiOxt7LfXleqkC36XYUu76zd17nKEdxTULuInbGV
	jteYIIjJTU9ZC3I0BtVSx21G7nInf1JKL0SdhORLIl3e5b00DZLyP96f1stX29+gJ1GX+yafWJf
	PHbbG5mT25qw0MAZI9M4+SRrm02K48xhWPrdHcbcVX8iDhKsvBIZu5UpwoT1DEZlQN+aga5jGes
	1to7J4+tDADKzjwAy/b2xgNd8rC0L2l58ldSYlYrl5FQkNtY9F5Iu4YqWtfzx+JxTkGccBbLItR
	/yHxCQf+roJANzB2fpoYBEHCt+yrqa16DhtwuzRFLXHph3SHGIcWJqZntlengMfJzlPkupO6yLe
	J6ihv62CBpStJRLLlsagHrT/iCGGVD+S9Wos8mI1MSJMYdbflkq6e7e/GnhGw8N0=
X-Google-Smtp-Source: AGHT+IFMZ7KSCud9TAm6WkhilsL2YSt4eLEOlsSBnICE+2N7LHiRuTs9MOfE5vg1f9MMN7MGZAQTsQ==
X-Received: by 2002:a17:90b:1811:b0:338:3d07:5174 with SMTP id 98e67ed59e1d1-3383d0751bamr2596824a91.5.1759204191272;
        Mon, 29 Sep 2025 20:49:51 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:62d2:5a18:f11e:c6a0:64bc:a06c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b59671ce93fsm7176996a12.3.2025.09.29.20.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 20:49:50 -0700 (PDT)
From: vanusuri@mvista.com
To: yocto-patches@lists.yoctoproject.org
Cc: Vijay Anusuri <vanusuri@mvista.com>
Subject: [yocto-patches][meta-cgl][PATCH v2 2/3] racoon2: Fix contains reference to TMPDIR [buildpaths] warning
Date: Tue, 30 Sep 2025 09:19:34 +0530
Message-Id: <20250930034935.89622-2-vanusuri@mvista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250930034935.89622-1-vanusuri@mvista.com>
References: <20250930034935.89622-1-vanusuri@mvista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Sep 2025 03:49:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2258

From: Vijay Anusuri <vanusuri@mvista.com>

Pass OE cflags to makefile

ERROR: racoon2-202003018-r0 do_package_qa: QA Issue: File /usr/sbin/.debug/spmd in package racoon2-dbg contains reference to TMPDIR [buildpaths]
ERROR: racoon2-202003018-r0 do_package_qa: QA Issue: File /usr/sbin/.debug/spmdctl in package racoon2-dbg contains reference to TMPDIR [buildpaths]
ERROR: racoon2-202003018-r0 do_package_qa: Fatal QA errors were found, failing task.

Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
---
 meta-cgl-common/recipes-cgl/racoon2/racoon2_202003018.bb | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/meta-cgl-common/recipes-cgl/racoon2/racoon2_202003018.bb b/meta-cgl-common/recipes-cgl/racoon2/racoon2_202003018.bb
index 211b911..c3ebd5d 100644
--- a/meta-cgl-common/recipes-cgl/racoon2/racoon2_202003018.bb
+++ b/meta-cgl-common/recipes-cgl/racoon2/racoon2_202003018.bb
@@ -33,8 +33,6 @@ SRC_URI = "git://github.com/zoulasc/racoon2;branch=master;protocol=https \
           "
 
 SRCREV = "7b68950328454b0e91ba24698c10c4a790705cc1"
-SRC_URI[md5sum] = "2fa33abff1ccd6fc22876a23db77aaa8"
-SRC_URI[sha256sum] = "f23773e4d97cec823ec634085b5e60a7884a13467ff1bffc17daac14d02f9caa"
 
 inherit autotools-brokensep update-rc.d systemd
 
@@ -52,6 +50,8 @@ do_configure:prepend () {
     mkdir -p lib/m4 spmd/m4 iked/m4 kinkd/m4
 }
 
+EXTRA_OEMAKE += "CPPFLAGS='${CFLAGS}'"
+
 do_install:append() {
     install -d -m 0755 ${D}${sysconfdir}/init.d/
     cp -rfa ${D}${sysconfdir}/${BPN}/init.d/* ${D}${sysconfdir}/init.d/
-- 
2.25.1


