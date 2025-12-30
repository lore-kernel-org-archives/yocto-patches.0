Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041D9EE499A
	for <webhook@archiver.kernel.org>; Tue, 30 Dec 2025 19:32:15 +0000 (UTC)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.71121.1767123129640831079
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 30 Dec 2025 11:32:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=liRSjJ0Y;
 spf=pass (domain: gmail.com, ip: 209.85.160.43, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-3f13043e2fdso3391372fac.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 30 Dec 2025 11:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767123129; x=1767727929; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FabEMqL1d5FC1zujAo7YlBMvxKD4cTlyjURqJbyl7Us=;
        b=liRSjJ0Y6noJBv6fpJ4WfVOa3YIDRATNtkar5E52TPlckAN6FVpshTtYbpFQ/FWLqB
         9pnXKmRaO21Krm6ITdveKU0JGCskIH5dFCztR3ta3hb6ttf3GWjsExfEudQ1LYuRZ+gp
         dcfZy4eNy4PJVmymTFet06WzlF3GvOlA2ChRu4D/zXikGGDF2ohz+7FKofZtNYUoNwjC
         wW06dWRjKwcdtCpCaxzoLZurtIMPlvcaCwvrzlXzoUlG2h4H1Kg1k5F5uhd4RdRCoNEA
         uiGPNwCclqGDVy+PSRFE+mCfqt/qWsJdMcWfJK1mHkCxJW9l/+ocHVVtuJOk+IWBoTyy
         HEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767123129; x=1767727929;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FabEMqL1d5FC1zujAo7YlBMvxKD4cTlyjURqJbyl7Us=;
        b=Qb1Q/QoEdy27Tcd5xI72YcTVTPgni0iz5zAc27b86fHmFZFBzNvYTGOY20JHSX5xXW
         v9a2HF/67p1G+AtZQqS/kPhSBaOHPpOj2wdWOK7hlFY7Nm87egySxAqfPoxnBbD3j1YE
         Cm3/L/9NdEc8IRDyWWFXS7RjngUIjM6F9Z9pP+Mgoec8QY+ms6PRNGpEXbq75wVgyttK
         sU8o2q/eaMG5g2jIuw+dAwKNT6FrY3/93549DKVN+1X2SBKsK8DIPAulWQiLug0ROR3N
         b31GsPdEmYk5bB9ONct/IwcA4nqgPrvdULld0zMjU77AzvN0kdXWSHpXyDHJG76shyaR
         qYkA==
X-Gm-Message-State: AOJu0Yw3FcneYjWDqGPPk7pTo3gaUbb1HqaJWxVwQ6WKj8HPd/1T950K
	Vn59ZbY+ULfLuXXAJwoCL0tC54jPny/8d2iP6KYH7ELHoL+pEEMUyr9N2udZqg==
X-Gm-Gg: AY/fxX4D0/lZ5R2r36nBmgWnhQB9fzjJ9MLiyFct4sUyIh0P5jEakNGHzFXeWnDmE9C
	kZYTdyGhPS35LNfHTO1vcqnuk4cquSEy/Z8yOLFT3N9XhDIOWJ/F85j3GGJ0XbYJz4xAsR9he7X
	0w2zF2Wtbad9yg8ormXEgDJBIEWm2vrKMBk5WoK44eH4SSppGRvRGUJatca8re9O+EsDn9+JcBm
	jK8AtiOGI5/8GLUQ8B6w+/vAlflWIsWOF8JX2nDADtNBRwF4sD4H4vwBdZQcJPs8fvZlZzBjTzW
	Uw/UWmFpcZPv7bK2kAaRg2ot8q7pM6yPBzAg9CtWaixPPxByyDl686qePIgxBjvVl6jBp4ofmm7
	QewwTDCXuHaOhB+R/FSO2Sbhmj8I1xGF8HGOvjTQTXQn5Z5+thSx+EZnX5zid6QAx7EReAM88VB
	5kh5DdzBV1H2B9VJjzjmHnKLY+wUC4ywld7FMIXUWyDVHOdwqe02dgH5mxKB693A==
X-Google-Smtp-Source: AGHT+IENQeNBAoD5Hf+ewahz/M/jeAt5ToQ9LMb2bCpPtIbpCckjJCvQ4LGGrvtvSKaNJq8HHEFZMw==
X-Received: by 2002:a4a:ddd8:0:b0:65c:fda0:ea8d with SMTP id 006d021491bc7-65d0eafe27dmr10346242eaf.83.1767123128671;
        Tue, 30 Dec 2025 11:32:08 -0800 (PST)
Received: from [172.26.252.3] (75-166-169-44.hlrn.qwest.net. [75.166.169.44])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fdaa9370c4sm21472743fac.9.2025.12.30.11.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 11:32:08 -0800 (PST)
Message-ID: <03a151fe-dc05-437e-a31b-2a844b6d8d75@gmail.com>
Date: Tue, 30 Dec 2025 12:32:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org,
 Scott Murray <scott.murray@konsulko.com>, rybczynska@gmail.com
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-security][PATCH] suricata: update PACKAGECONFIG[jansson] option
 to required
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Dec 2025 19:32:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2887

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
---
Sponsor: 21SoftWare LLC

 recipes-ids/suricata/suricata_7.0.13.bb | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/recipes-ids/suricata/suricata_7.0.13.bb b/recipes-ids/suricata/suricata_7.0.13.bb
index 0635bf3..cbd2ff1 100644
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

