Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3D1CFD64E
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 15:00:36 +0000 (UTC)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7744.1767798028662475160
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 07 Jan 2026 07:00:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=AcL2TrDb;
 spf=pass (domain: konsulko.com, ip: 209.85.160.176, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4eda6c385c0so15006931cf.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 07 Jan 2026 07:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1767798027; x=1768402827; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x/clH+wkBn/fC4aeLEvr8i/eBJOfx0yZ5n7VJtVgrX4=;
        b=AcL2TrDb/xu6DT+W2pkUxa2eQ7/dDNY0a93Knez7B4o7U/WU8W6CsHvMT2j0ScGaIa
         3q/wEgK0NG/IrilR9CrXVVXjuCP6n5Ttr9lNTOdCW1VRynH9cQxz8JSwhhZE2LORXbh0
         06QDKnzmebGD9JTGGqkitLNWsNRzsHliDeb1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767798027; x=1768402827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x/clH+wkBn/fC4aeLEvr8i/eBJOfx0yZ5n7VJtVgrX4=;
        b=Klr+7cuOwNbCinluldOqTRlrZFl4NE07fut8z+CNPgJhPpsib3RzMQaJwBoPdsfbM6
         qWJ71/MuCjRucqWtl6tfkeCw+snqv0vO4pk1Ag3xdo4TtbNWlJFmNDEwjt1iZ25pz18R
         0wG9653Xk+GuVVsGhYmb+5aXwtBt7GAKaQUFeTjdUQUlYUekeyuMlW6YO37mthDDXvsK
         JkLbWaJ1aTLqMZjebwaMsaAoH3HSRsvzzI/vOnSELo9DZRydGoh8zzRnN+/lfYuZmvGj
         s6w8DUEESpFA3PgygWdKX2VEI+uHyCtV77ZKrQmp0Aq5AGys69wI1FZEdtd6ewgJej/+
         ee0A==
X-Gm-Message-State: AOJu0YyxoEppLPqzZwGg7EPahTzUzL8fygk4B4rhU+u30W8FTCfTV3iP
	WH3u+I13nDcxgJvurwbhK7rmH1guBYPtOCJp0pxl86t6sugo575rQykg6iv6Ok6O7QI3T6bNzwD
	/ijgJ
X-Gm-Gg: AY/fxX6yopnr8/QxQqMeopZEOPX9+KJxgEpOxdYQGpeTRjSGUi5oiLMLIwmmaDKtbLq
	kICqRZbXwbPSycRuUjdCQJ2HRgLmKB15aIwgMx3RH3BpeKdzZP/wwLlM33k7o9c9yPjJl7wlIhZ
	gv/oTAE/YBqMQFoIVv5JalPJxzVHC7/FUbq3XSjQiLfyWXT6c54nqJuJ28JXB4xJlToTkGq+Pu2
	wHhfBmMWAwWe/0KcGm2DNGrHYQNawe5hVRFMscDydRHoYOaBmiGIHJBjaA68AHBIZuPoMnXHHzg
	lGzA63+V8onSWsHFyNJdegoWXYD2/RYMdB/JJmQHSeMjBpVairDq0cLgdwwks+mVULiO8m6vw+2
	Es3Hy2NPwZkPN8MnX6IFlDJenM2f6YCFBD/SvTCd4kmM+wH+o0REmRDFbfuI6jHI8TAJsVe/AYT
	SYrOBGQZwp0Xpohjcp6fJbAsyfy8npxCn32rCaaVRHbktewdPz8qBte9NjKWyA6dqBGRrD7VTxM
	n4pBoAicAUrqR2plAG2hSz4SqSwPt1wgIGlOLylDUwLBFCwSq21
X-Google-Smtp-Source: AGHT+IEpRhXM3KiPPHmypSIWzOYSKsmpKGBpA6jtVFTVnnEzgKMLMjorvGb4a6n9nMgenemtj4l3Mg==
X-Received: by 2002:a05:622a:88:b0:4ee:7ee:df70 with SMTP id d75a77b69052e-4ffb4a6069emr36978291cf.80.1767798025752;
        Wed, 07 Jan 2026 07:00:25 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8d568cbsm34113551cf.11.2026.01.07.07.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 07:00:25 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org,
	Marta Rybczynska <rybczynska@gmail.com>,
	Anton Antonov <Anton.Antonov@arm.com>
Subject: [meta-security][PATCH 2/4] suricata: update PACKAGECONFIG[jansson] option to required
Date: Wed,  7 Jan 2026 10:00:07 -0500
Message-ID: <635238de190ed0281fbdecec6ed3a2a517f71bc6.1767797568.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1767797568.git.scott.murray@konsulko.com>
References: <cover.1767797568.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 07 Jan 2026 15:00:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2910

From: Clayton Casciato <majortomtosourcecontrol@gmail.com>

jansson is required as of Suricata 5.0:
https://github.com/OISF/suricata/commit/e49c40428e1b9f7e5dcdb5857c3978d5cb859fd9

This is still required in the latest release:
https://github.com/OISF/suricata/blob/suricata-8.0.2/configure.ac#L828

On exclusion attempt:
[...]
| checking for jansson.h... no
| checking for json_dump_callback in -ljansson... no
|
|     ERROR: Jansson is now required.
|
|     Go get it from your distribution or from:
|       http://www.digip.org/jansson/
|
|     Ubuntu/Debian: apt install libjansson-dev
|     CentOS: yum install jansson-devel
|     Fedora: dnf install jansson-devel
|
| NOTE: The following config.log files may provide further information.
| NOTE: [...]/poky-whinlatter/build/tmp/work/cortexa57-poky-linux/suricata/7.0.13/sources/suricata-7.0.13/config.log
| ERROR: configure failed
| WARNING: exit code 1 from a shell command.
ERROR: Task ([...]/poky-whinlatter/layers/meta-security/recipes-ids/suricata/suricata_7.0.13.bb:do_configure) failed with exit code '1'

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-ids/suricata/suricata_7.0.13.bb | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/recipes-ids/suricata/suricata_7.0.13.bb b/recipes-ids/suricata/suricata_7.0.13.bb
index 7298f1b..469e42d 100644
--- a/recipes-ids/suricata/suricata_7.0.13.bb
+++ b/recipes-ids/suricata/suricata_7.0.13.bb
@@ -7,7 +7,7 @@ LIC_FILES_CHKSUM = "file://LICENSE;beginline=1;endline=2;md5=c70d8d3310941dcdfcd
 SRC_URI = "http://www.openinfosecfoundation.org/download/suricata-${PV}.tar.gz"
 SRC_URI[sha256sum] = "bbc94cf0a297f4560c64569ed72867c799287defdaf6e6572ce769f48dd2559b"
 
-DEPENDS = "lz4 libhtp"
+DEPENDS = "jansson lz4 libhtp"
 
 SRC_URI += " \
     file://volatiles.03_suricata \
@@ -27,6 +27,7 @@ EXTRA_OECONF += " --disable-debug \
     --enable-non-bundled-htp \
     --disable-suricata-update \
     --with-libhtp-includes=${STAGING_INCDIR} --with-libhtp-libraries=${STAGING_LIBDIR} \
+    --with-libjansson-includes=${STAGING_INCDIR} --with-libjansson-libraries=${STAGING_LIBDIR} \
     "
 
 CARGO_SRC_DIR = "rust"
@@ -37,7 +38,7 @@ CARGO_BUILD_FLAGS:append = " --offline"
 B = "${S}"
 
 # nfnetlink has a dependancy to meta-networking
-PACKAGECONFIG ??= "jansson file pcre2 yaml python pcap cap-ng net"
+PACKAGECONFIG ??= "file pcre2 yaml python pcap cap-ng net"
 PACKAGECONFIG:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'ptest', 'unittests', '', d)}"
 
 PACKAGECONFIG[pcre2] = "--with-libpcre2-includes=${STAGING_INCDIR} --with-libpcre2-libraries=${STAGING_LIBDIR}, ,libpcre2 ,"
@@ -48,7 +49,6 @@ PACKAGECONFIG[net] = "--with-libnet-includes=${STAGING_INCDIR} --with-libnet-lib
 PACKAGECONFIG[nfnetlink] = "--with-libnfnetlink-includes=${STAGING_INCDIR} --with-libnfnetlink-libraries=${STAGING_LIBDIR}, ,libnfnetlink ,"
 PACKAGECONFIG[nfq] = "--enable-nfqueue, --disable-nfqueue,libnetfilter-queue,"
 
-PACKAGECONFIG[jansson] = "--with-libjansson-includes=${STAGING_INCDIR} --with-libjansson-libraries=${STAGING_LIBDIR},,jansson, jansson"
 PACKAGECONFIG[file] = ",,file, file"
 PACKAGECONFIG[python] = "--enable-python, --disable-python, python3, python3-core"
 PACKAGECONFIG[unittests] = "--enable-unittests, --disable-unittests,"
@@ -138,4 +138,6 @@ PACKAGES =+ "${PN}-python"
 FILES:${PN} += "${systemd_unitdir} ${sysconfdir}/tmpfiles.d"
 FILES:${PN}-python = "${bindir}/suricatasc ${PYTHON_SITEPACKAGES_DIR}"
 
+RDEPENDS:${PN} += "jansson"
+
 CONFFILES:${PN} = "${sysconfdir}/suricata/suricata.yaml"
-- 
2.51.0


