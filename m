Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B36C3DA6D
	for <webhook@archiver.kernel.org>; Tue, 20 May 2025 18:52:24 +0000 (UTC)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
 by mx.groups.io with SMTP id smtpd.web11.28824.1747767135176889164
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 20 May 2025 11:52:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gVx/IMKV;
 spf=pass (domain: gmail.com, ip: 209.85.166.179, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3da831c17faso20660845ab.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 20 May 2025 11:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747767134; x=1748371934; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58YbxmOQYd5i6QqgIWTOsz0IUgufAkGVVdYFmGgQD3U=;
        b=gVx/IMKVmF9FUlILUTz0Z1kEUwQKE91yOQcRomqzg26cd0VwQ5ThvExBtbHUiBzcxu
         d3BFr3zmXq0LJ0bWl8u+InHLnGUwRqpbKFINQH/ZoQ2L8ONOoMnG0VWW6LoQizOfIMfw
         2/0DJy+fGr1mwTg14jMDfQQfHFDJ8IbBSFUITW5AhJPwZ1SwVYb2E1/RurBKJ3Hadnr1
         MI6lNK2/684J+TQ93BK7Cv7jSKpApV28J4Tk9wLscS7/SQNT2Fg1EZ1wcei2i/yAQoi6
         wxQeV4ZRa3vyjhg7sDDWVUV7+OGnFYyV4A/CRdIwbz+U8UhGLcgbari4DqU0K21ZV62e
         oDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747767134; x=1748371934;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=58YbxmOQYd5i6QqgIWTOsz0IUgufAkGVVdYFmGgQD3U=;
        b=esD85tf6okYezdvW4hXu959sv0RyO3NdL3GurXmEuGj+ymR4fgXvBEpS4voDFcxw+V
         TvAbM3bpUiac1qLME91wQwl28ZjPPoEkufJaxwWsfyO9UY7XXlxTrTmUsdj7EGFB6w4K
         w3/NuHyehhQgVafXvUkJ9LmvH6q0yAD2OpepCAF0gWW47H1BtP1vB4u+ZHllts7hgsje
         1kKtAkyd+Cooqdnpp5NefgonqdXGCMGL77hdxNGGbedRljjlMmn1hLpiQgwyAQNI0kTW
         JYxxW7RfrlHMGOd/VfxA/NW5lF6rhatlqPiNKdrNJBx0WYX5xrdHumWyaROq9dn3TEXZ
         IKGg==
X-Forwarded-Encrypted: i=1; AJvYcCX2Oavh2WlOjFvhdBA9VVy162pWvgZgVThSPPtmd/oaHNhWKnCU5b0bqxZ+OVok33J2h5V2rsg+kr2NcZyU@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxORrsE5LfpXkS85V0oLEhj5WjcrQiZbMNdBWRbnLPvL0C/oo98
	qyq7/Wtgvn3Kwl1M3Gge/145aIgBwA1ER6t5XuEFMb1+oj+6Mm7T0CDv
X-Gm-Gg: ASbGnct111nFe6HqQCPBa4xSuZun5JhN04Y3EX/XXu54+fxlV3Aw0du/Hov8puAE0UW
	I1ZtyoVk5lHk6PYrTOMrEAJQXX8fZct0Y/p5TxIWk8vdn9r7NvKcQPH3eSQl7gok+gNwwNUxz3m
	nT4Uci9iTBJH1gPLOtCcOPq8aPdu+FkCabxcVPus0UjOkCvzhW5fbJvOeQPK1hehuFMkbPWbnou
	lj16iukrFroBuWZqMmbHSdT2Xc76GM4Miqfez1GRX1sE1P1u3jg2Vd+BtBaE8xvAhaEATMP6QWC
	4o1vaAbdmn03Ah2btO9cW/88jMeTUDyHEtwaxh/1yXn5s3qml4CyxgA8/vHGq+hyrEFkbWXYbq2
	ZxtA4LQ/dUj7XQQuB3BHI99ehzwUf
X-Google-Smtp-Source: AGHT+IGRTeu8cFEzEJ41wFlIUB7pjhaDrWNqKYlJgS+LkUfBWDV82Lpbr9pxCw3ICtE7dCKVIFXYKw==
X-Received: by 2002:a05:6e02:4404:10b0:3dc:757b:3fac with SMTP id e9e14a558f8ab-3dc757b42edmr48150675ab.16.1747767134193;
        Tue, 20 May 2025 11:52:14 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc4ec3b7sm2323555173.145.2025.05.20.11.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 11:52:13 -0700 (PDT)
Message-ID: <bbb71841-c224-4a65-8547-28e530ddf098@gmail.com>
Date: Tue, 20 May 2025 12:52:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: akuster808@gmail.com, yocto-patches@lists.yoctoproject.org
Cc: mikko.rapeli@linaro.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-security][PATCH v2] suricata: fix SEGV on startup (TMPDIR QA)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 20 May 2025 18:52:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1570

ERROR: suricata-7.0.0-r0 do_package_qa: QA Issue: File /usr/bin/suricata
in package suricata contains reference to TMPDIR [buildpaths]

ERROR: suricata-7.0.0-r0 do_package_qa: QA Issue: File
/usr/src/debug/suricata/7.0.0/src/build-info.h in package suricata-src
contains reference to TMPDIR [buildpaths]

The current resolution causes a SEGV:
root@beaglebone-yocto:~# journalctl -u suricata
May 20 18:30:51 beaglebone-yocto systemd[1]: Started Suricata IDS/IDP
daemon.
May 20 18:30:51 beaglebone-yocto systemd[1]: suricata.service: Main
process exited, code=dumped, status=11/SEGV
May 20 18:30:51 beaglebone-yocto systemd[1]: suricata.service: Failed
with result 'core-dump'.

Address references when src/build-info.h is being written

This is similar to Debian's approach:
https://sources.debian.org/patches/suricata/1:7.0.10-1~bpo12%2B1/reproducible.patch/

Restore the "already-stripped" check and CFLAGS info

Original resolution in commit c0e3fecc3bea ("suricata: fix QA warnings")

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
Sponsor: 21SoftWare LLC

v1: https://lists.yoctoproject.org/g/yocto-patches/topic/meta_security_patch/113203284
v2: update descriptions to indicate functional issue

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

