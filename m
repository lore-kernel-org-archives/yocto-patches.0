Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA795C54754
	for <webhook@archiver.kernel.org>; Tue, 20 May 2025 00:06:47 +0000 (UTC)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
 by mx.groups.io with SMTP id smtpd.web10.9560.1747699604470380837
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 May 2025 17:06:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BpGleY1T;
 spf=pass (domain: gmail.com, ip: 209.85.166.180, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3db8356ee37so15142105ab.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 May 2025 17:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747699603; x=1748304403; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8Y27GpehOkhM0mXWllkPoahRR5UzHay9XiyQqeW2cY=;
        b=BpGleY1TQ6zn5+gebIbTt6dI/jIxVA/AEI0016kODIixpemac4MlrfTKJnhCkyomnU
         dHCU7aVr7QSl5s50lBdJKXVi1mcts0e9zwpJoatgMjLQQMpJqmiNdjwxnPL6o4nvqZn2
         ddLRtftqHVN3z+ZbKyjNBHEt5TPOX2tUV73Lfad7p4wIeItiJtJ21z1Y03ZVeWwkSyG+
         oQFc6ILeVeS7J1Fq+joi3NZeQI+v0ouByLpOEH45Vll0r56qXM3mRFjXHdGixmnSi+lh
         FfNHqp0iJfHh/2TN1SEuJghkmMziKCBAdmQcvBQDCdWuWTrpQjC/OTS8qjdcZdfk/32B
         zaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747699603; x=1748304403;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O8Y27GpehOkhM0mXWllkPoahRR5UzHay9XiyQqeW2cY=;
        b=BYC5sZk88usfJuo4MvhMIyBvxXa8DvDlezCfvAEU8Re1raiTnQPRLAW+RG7xl0nExZ
         LHgU+YdrVE4DKTbEjEN2syIUT4sm0vqWmLZRn8Ehrc5ljJl8ezuqK/p7GK0kDHbxTpAD
         0vAXiaPDB8ByILBIcunDGOjyqebH4a4PTkjWs7FdoVog3vw9FozYZLx6XwOwKzRlV/jc
         FKY+c6s2UpYexA4szx+rdwE1U5umoo1guM4rvaNh3VifNJS6w5JZjFEkbzgkw4usg+rR
         1sGhqQHsh/X4oH/YYyV4dK1Hb4kfxoXdRhvs4lahro/nCK3VaqHiR5XkjThdkENg8t0P
         UELw==
X-Forwarded-Encrypted: i=1; AJvYcCW2oIvxyJNfvicLyjDqBfV7IJs1/y+ezUoFfaFWHianNUWDNCyXNuhP70ontIdp8lYpjOvxkwPrgW78wrQY@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxXvRZb5Tbw+G9DSELXie55NZbVJiZbJyr8aT1l+PN8JRz6iAcT
	Ypl2lM55lgp9QPsUFCJd2KYyq/eq9bEGcmvNFr1cjQP49QEvSuahdO9D
X-Gm-Gg: ASbGncuRWOJLkXjLeoWM+MAW/7E8JmMYElYMdB2DfC6g0yNCE4uuW6z+1+CqjUnEeDk
	3ZkWOoXb2XHCvaCiwbSVCsZhQS21kxKa1/6Pcxy2NEdB4DNDbb9Xd0qg7J9JHPlyP1SMvLXicEZ
	OQVnEjVeXxYQLPkuAhsULAuYkf2N95OBfJkrxbz2xvDUs+Mb+sR2k4uW1fjROa+d3t9ZkQm5Fp/
	Wqg6sgunXsQDebZWQ4swfcIhyVo6AcgAqhdzwooJJlTARmNrpV4Cq04Q8zuKUaeFySA4ycbN311
	GZUU8NNAQmBF/QSHTyyWumR94gVwdN+foOdaLLoIyChTtc0qQIzMwIPy1/5u5f2AtxlOE0649nj
	3TThUNBn4nUy25PgBokQ48jAKwEeY
X-Google-Smtp-Source: AGHT+IGx5A0oN3v1+i+EXBNp1Vhu6JnypfJo+SHoKaV0rHNF6oLqlS1rQBegyREOsYrAsDd94J5G2A==
X-Received: by 2002:a05:6e02:351d:b0:3d0:47cf:869c with SMTP id e9e14a558f8ab-3db857b6555mr148570905ab.19.1747699603558;
        Mon, 19 May 2025 17:06:43 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc48c874sm1976007173.82.2025.05.19.17.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 17:06:43 -0700 (PDT)
Message-ID: <fef62919-c508-4ff7-af7f-9f02e3731f91@gmail.com>
Date: Mon, 19 May 2025 18:06:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: akuster808@gmail.com, yocto-patches@lists.yoctoproject.org
Cc: mikko.rapeli@linaro.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-security][PATCH] suricata: resolve TMPDIR QA issues in
 do_configure
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 20 May 2025 00:06:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1565

ERROR: suricata-7.0.0-r0 do_package_qa: QA Issue: File /usr/bin/suricata
in package suricata contains reference to TMPDIR [buildpaths]

ERROR: suricata-7.0.0-r0 do_package_qa: QA Issue: File
/usr/src/debug/suricata/7.0.0/src/build-info.h in package suricata-src
contains reference to TMPDIR [buildpaths]

Address references when src/build-info.h is being written

This is similar to Debian's approach:
https://sources.debian.org/patches/suricata/1:7.0.10-1~bpo12%2B1/reproducible.patch/

Restore the "already-stripped" check and CFLAGS info

Original resolution in commit c0e3fecc3bea ("suricata: fix QA warnings")

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 recipes-ids/suricata/suricata_7.0.0.bb | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/recipes-ids/suricata/suricata_7.0.0.bb b/recipes-ids/suricata/suricata_7.0.0.bb
index 910e21e..dc55fdf 100644
--- a/recipes-ids/suricata/suricata_7.0.0.bb
+++ b/recipes-ids/suricata/suricata_7.0.0.bb
@@ -68,6 +68,8 @@ do_configure:prepend () {
     # use host for RUST_SURICATA_LIB_XC_DIR
     sed -i -e 's,\${host_alias},${RUST_HOST_SYS},' ${S}/configure.ac
     sed -i -e 's,libsuricata_rust.a,libsuricata.a,' ${S}/configure.ac
+    # Address build configuration written to src/build-info.h
+    sed -i -e 's,\(| sed -e '\''s/^/"/'\''\)\( |\),\1 -e '\''s#${WORKDIR}#\\.#g'\''\2,' ${S}/configure.ac
     autotools_do_configure
 }
 
@@ -126,10 +128,6 @@ do_install () {
     sed -i -e "s:#!.*$:#!${USRBINPATH}/env python3:g" ${D}${bindir}/suricatasc
     sed -i -e "s:#!.*$:#!${USRBINPATH}/env python3:g" ${D}${bindir}/suricatactl
     sed -i -e "s:#!.*$:#!${USRBINPATH}/env python3:g" ${D}${libdir}/suricata/python/suricata/sc/suricatasc.py
-    # The build process dumps config logs into the binary, remove them.
-    sed -i -e 's#${RECIPE_SYSROOT}##g' ${D}${bindir}/suricata
-    sed -i -e 's#${RECIPE_SYSROOT_NATIVE}##g' ${D}${bindir}/suricata
-    sed -i -e 's#CFLAGS.*##g' ${D}${bindir}/suricata
 }
 
 pkg_postinst_ontarget:${PN} () {
@@ -147,4 +145,3 @@ FILES:${PN} += "${systemd_unitdir} ${sysconfdir}/tmpfiles.d"
 FILES:${PN}-python = "${bindir}/suricatasc ${PYTHON_SITEPACKAGES_DIR}"
 
 CONFFILES:${PN} = "${sysconfdir}/suricata/suricata.yaml"
-INSANE_SKIP:${PN} = "already-stripped"

