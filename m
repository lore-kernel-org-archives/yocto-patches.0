Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B44CCF9E3
	for <webhook@archiver.kernel.org>; Mon, 10 Nov 2025 08:12:42 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43742.1762762353394421513
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 10 Nov 2025 00:12:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Sr5FpXiL;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: skandigraun@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4775ae77516so32178925e9.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 10 Nov 2025 00:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762762351; x=1763367151; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p3q6WstlIQQpJG1b7Y+5g2esyBv9DLS2s/+aZw6bHtE=;
        b=Sr5FpXiL1Me2zxYqqTLdrwtzkpjbmGLh/2gG5HDyZJvI4gTli/8N7Om0N3yoBP1OtC
         mjDvlAel2QiTGp2jlfLvIaWnSt7xAvXHmFqmkT6HB8kWVdqiaMj5EJ9mlTXqvAtOi9c9
         O95L4VKo/YPwvlWtJFx3e3kfHtp/Qo0zZoxQuUewxTJJC5FIY4nAYIkEirMXkHkZdKek
         j9HO+D32DTjtPi4wspg+xesINQjfrPBpxBMkvG+NFvg2sUuK48Bn7sNTJJYVK43xqEZh
         Y+FrvjqdX8zJ6WYZrR3lOw+t9vChZkryrl121rm2kCdfxt8P+0KLMXigHJ6eIkyT9oqv
         wj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762762351; x=1763367151;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p3q6WstlIQQpJG1b7Y+5g2esyBv9DLS2s/+aZw6bHtE=;
        b=FqVf4CgtBO6TPDyvwHDBqfZSXQvW+rQnAaJ8W/kh76LrnVjI7MB0VIiWjv/b0PQHc/
         MJsbeAQzWvRctoubye78p88gM6TKEuAt2fzn3svMHI3pgGtu7irnhJlCDB3APGHJB443
         3mEl/8rTiGJELUcbUF/RXGQqXIhprep8agFM1ObeJRAVGfs6E6AZKV/eX6ESsUEXdYVp
         OJAUZPPa8KCOwT3mEsja6PFA+CLgAX5JL1mAOvzeOdxgrZQa81NCu1oWlHD5ZPoG9Xbw
         7PD8/4ipo/xSLcfY1k8JgqCEcOymfZo+T2PZefTpOQYzVkdBjR9UE02riEg1Q2N8vtkQ
         13wg==
X-Gm-Message-State: AOJu0YyHkhJoGhKo9+PkoI8cBK6eAULC4NAk/mVtdxiL0UhKZ9XIJYBV
	Wj04RHb471zIufKldUP+xVMwrcg67VTpPvYjkDJi6uSAXp3YKqFJY3f1JZtjpDrx
X-Gm-Gg: ASbGnctwTq0j9XsJRbgo6etaK8e8ZSNbk5vShkpgsXn/Wx/uMBsEMzD7Mj/BPMRJ0pO
	J/4Nl1ZgaO045WZjTQy/8yKrm6wrIUtEpdD6Z6xbYaMrv2H+mtqX8jEZKNPrxeGPxMoWRUYEbYU
	uJTh4IXp17b52fL0A8wE+Tp7uzVU1c+uTREG4yc3pbE73C+7cII0wQibhelpggUwlTodfNOC3KZ
	kac3CMhopEROeeLJm0NhkDX/rXCBxlERcv7aW7gN/PTC3FyRRqqqKtbs9WKABACF2fb+de7/YX+
	DwoeQo3zguLsNZaqUSoZ4qkg7Tl4OheNVlVytK4Et4y2voFABwBw7NTc/YIpSob6/M3NGm6vzdm
	izZwarWQ+nfAwUJ88cziZdZY/F7xSRP2X/E9atcx9j/9ttKALeM03IgSwNvyM+XOrsXkWzVw7kV
	97grSuLjUcV7zYEiFo64w=
X-Google-Smtp-Source: AGHT+IGijTNXm4LkE8vEovmMCOH54VlnKSy80FaobHV8wCn4Fk+VjZg6dozwNMjI2jUn44fR54XPMQ==
X-Received: by 2002:a05:600c:4453:b0:45d:5c71:769a with SMTP id 5b1f17b1804b1-4777327cb45mr47101895e9.26.1762762351403;
        Mon, 10 Nov 2025 00:12:31 -0800 (PST)
Received: from [192.168.1.106] ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4777d9447eesm28348525e9.16.2025.11.10.00.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 00:12:30 -0800 (PST)
Message-ID: <b5a1a707-0e05-468d-8915-e8ae9b9c9fb8@gmail.com>
Date: Mon, 10 Nov 2025 09:12:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][PATCH 1/2] clamav: Add ClamAV
 1.4.3 recipe with enhanced security and Rust support
To: yocto-patches@lists.yoctoproject.org
References: <20251110040631.34843-1-hemant.jadhav@emerson.com>
Content-Language: en-US
From: Gyorgy Sarvari <skandigraun@gmail.com>
Cc: hemant.jadhav@emerson.com
In-Reply-To: <20251110040631.34843-1-hemant.jadhav@emerson.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 10 Nov 2025 08:12:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2468

On 11/10/25 05:06, Hemant Jadhav via lists.yoctoproject.org wrote:
> Add modern ClamAV 1.4.3 recipe with comprehensive improvements over
> the legacy 0.104.4 version.
>
> Major changes in 1.4.3:
> - Upgraded core engine with improved threat detection capabilities
> - Added Rust components requiring cross-compilation support
> - Updated CMake build system replacing legacy autotools
> - Modernized library dependencies (LLVM, JSON-C, PCre2)
> - Added comprehensive license compliance for multi-component package
> - Enhanced cross-compilation support for all target architectures
>
> The recipe includes dynamic Cargo configuration using Yocto variables
>     to support cross-compilation to any target architecture supported by
>     the build system, replacing hardcoded architecture assumptions.
>
> - Implemented CMake cache variables for cross-compilation
> - Updated all license checksums for compliance
> - Added Rust toolchain integration with proper environment setup
>
> Security rationale:
> - ClamAV 0.104.4 reached end-of-life and is no longer maintained
> - Upstream strongly recommends migration to 1.4.x for security updates
>
> Signed-off-by: Hemant Jadhav <hemant.jadhav@emerson.com>
> ---
>  recipes-scanners/clamav/clamav_1.4.3.bb       | 203 ++++++++++++++++++
>  recipes-scanners/clamav/files/tmpfiles.clamav |   1 +
>  .../clamav/files/volatiles.03_clamav          |   1 +
>  3 files changed, 205 insertions(+)
>  create mode 100644 recipes-scanners/clamav/clamav_1.4.3.bb
>
> diff --git a/recipes-scanners/clamav/clamav_1.4.3.bb b/recipes-scanners/clamav/clamav_1.4.3.bb
> new file mode 100644
> index 0000000..a19eb41
> --- /dev/null
> +++ b/recipes-scanners/clamav/clamav_1.4.3.bb
> @@ -0,0 +1,203 @@
> +SUMMARY = "ClamAV anti-virus utilities and scanner tools"
> +DESCRIPTION = "ClamAV is an open source antivirus engine for detecting trojans, viruses, malware & other malicious threats."
> +HOMEPAGE = "http://www.clamav.net/index.html"
> +SECTION = "security"
> +LICENSE = "GPL-2.0-only & LGPL-2.1-only & BSD-2-Clause & Zlib & Apache-2.0-with-LLVM-exception"
> +LIC_FILES_CHKSUM = "file://COPYING.txt;md5=2c0b5770a62017a3121c69bb9f680b0c \
> +                    file://COPYING/COPYING.LGPL;md5=2d5025d4aa3495befef8f17206a5b0a1 \
> +                    file://COPYING/COPYING.bzip2;md5=ae8d555c34b656ff864ea9437a10d3a0 \
> +                    file://COPYING/COPYING.zlib;md5=3648a0b9713ab246e11536055165a41a \
> +                    file://COPYING/COPYING.llvm;md5=c82fc668ef1809acdd0684811df93bfc \
> +                    file://COPYING/COPYING.unrar;md5=6a741ba21afc8b71aeaee3b5f86a8111 \
> +                    file://COPYING/COPYING.file;md5=e63a61022c36cff2fdfbf02dd51674bd \
> +                    file://COPYING/COPYING.curl;md5=be5d9e1419c4363f4b32037a2d3b7ffa \
> +                    "
> +
> +DEPENDS = "glibc llvm libtool db openssl zlib curl libxml2 bison pcre2 json-c libcheck rust-native cargo-native libmspack"
> +
> +SRC_URI = "git://github.com/Cisco-Talos/clamav;branch=rel/1.4;protocol=https \
> +           file://clamd.conf \
> +           file://freshclam.conf \
> +           file://volatiles.03_clamav \
> +           file://tmpfiles.clamav \
> +           "
> +
> +# ClamAV version 1.4.3
> +SRCREV = "d8b053865fd5995f7af98bfbcd98c9a5644bfe2b"
> +S = "${WORKDIR}/git"

Setting S like this is not needed in the master branch anymore, it is
set automatically. (Using ${WORKDIR} here causes also a fatal error)

> +
> +COMPATIBLE_HOST:libc-musl:class-target = "null"
> +
> +LEAD_SONAME = "libclamav.so"
> +SO_VER = "12.0.0"
> +BINCONFIG = "${bindir}/clamav-config"
> +
> +inherit cmake chrpath pkgconfig useradd systemd multilib_header multilib_script rust-common
> +
> +
> +UPSTREAM_CHECK_COMMITS = "1"
> +
> +CLAMAV_USER ?= "clamav"
> +CLAMAV_GROUP ?= "clamav"
> +
> +PACKAGECONFIG ?= "clamonacc \
> +                  ${@bb.utils.contains("DISTRO_FEATURES", "systemd", "systemd", "", d)}"
> +PACKAGECONFIG[milter] = "-DENABLE_MILTER=ON ,-DENABLE_MILTER=OFF, curl, curl"
> +PACKAGECONFIG[clamonacc] = "-DENABLE_CLAMONACC=ON ,-DENABLE_CLAMONACC=OFF,"
> +PACKAGECONFIG[unrar] = "-DENABLE_UNRAR=ON ,-DENABLE_UNRAR=OFF,"
> +PACKAGECONFIG[freshclamdnsfix] = "-DENABLE_FRESHCLAM_DNS_FIX=ON ,-DENABLE_FRESHCLAM_DNS_FIX=OFF,"
> +PACKAGECONFIG[systemd] = "-DENABLE_SYSTEMD=ON -DSYSTEMD_UNIT_DIR=${systemd_system_unitdir}, -DENABLE_SYSTEMD=OFF, systemd"
> +
> +EXTRA_OECMAKE = "-DCMAKE_BUILD_TYPE=Release -DOPTIMIZE=ON -DENABLE_JSON_SHARED=OFF \
> +                 -DCLAMAV_GROUP=${CLAMAV_GROUP} -DCLAMAV_USER=${CLAMAV_USER} \
> +                 -DENABLE_TESTS=OFF -DBUILD_SHARED_LIBS=ON \
> +                 -DDO_NOT_SET_RPATH=ON \
> +                 -DCMAKE_INSTALL_PREFIX=${prefix} \
> +                 -DCMAKE_INSTALL_SYSCONFDIR=${sysconfdir} \
> +                 -DCMAKE_INSTALL_FULL_SYSCONFDIR=${sysconfdir} \
> +                 -DSYSCONFDIR=${sysconfdir} \
> +                 -DHAVE_SIGNED_RIGHT_SHIFT=1 \
> +                 -DHAVE_UNAME_SYSCALL=1 \
> +                 -DHAVE_FD_PASSING=1 \
> +                 -Dtest_run_result=0 \
> +                 -Dtest_run_result__TRYRUN_OUTPUT='' \
> +                 -DCMAKE_C_FLAGS='${CFLAGS} -Wno-error=format-truncation -Wno-error=unused-function' \
> +                 "
> +
> +# Rust Cross-Compilation Configuration for Yocto
> +export CARGO_TARGET_DIR = "${WORKDIR}/cargo_target"
> +
> +MULTILIB_SCRIPTS = "${PN}-dev:${bindir}/clamav-config"
> +
> +# Create Cargo configuration for cross-compilation
> +do_configure:prepend() {
> +    mkdir -p ${WORKDIR}/.cargo
> +    
> +    cat > ${WORKDIR}/.cargo/config.toml << EOF
> +[build]
> +target = "${RUST_TARGET_SYS}"
> +
> +[target.${RUST_TARGET_SYS}]
> +linker = "${RUST_TARGET_CC}"
> +
> +[target.${RUST_BUILD_SYS}]
> +linker = "${RUST_BUILD_CC}"
> +EOF
> +    

Is this config.toml required here? Wouldn't it work if cargo_common
class would be inherited instead of rust-common, and let it create
config.toml?

> +    export CARGO_TARGET_DIR="${WORKDIR}/cargo_target"

This export is set a few lines above already outside of the task (which
makes it being available for all tasks).

> +}
> +
> +do_install:append() {
> +    install -d ${D}/${sysconfdir}
> +    install -d ${D}/${localstatedir}/lib/clamav
> +    install -d ${D}${sysconfdir}/clamav ${D}${sysconfdir}/default/volatiles
> +
> +    install -m 644 ${WORKDIR}/clamd.conf ${D}${sysconfdir}
> +    install -m 644 ${WORKDIR}/freshclam.conf ${D}${sysconfdir}
> +    install -m 0644 ${WORKDIR}/volatiles.03_clamav  ${D}${sysconfdir}/default/volatiles/03_clamav

I think these are in UNPACKDIR now, not in WORKDIR.

> +    
> +    if [ -d ${D}${prefix}/etc ]; then
> +        cp -r ${D}${prefix}/etc/* ${D}${sysconfdir}/ 2>/dev/null || true
> +        rm -rf ${D}${prefix}/etc
> +    fi
> +    
> +    sed -i -e 's#${STAGING_DIR_HOST}##g' ${D}${libdir}/pkgconfig/libclamav.pc
> +    rm ${D}/${libdir}/libclamav.so
> +    if [ "${INSTALL_CLAMAV_CVD}" = "1" ]; then
> +        install -m 666 ${S}/clamav_db/* ${D}/${localstatedir}/lib/clamav/.
> +    fi
> +
> +    rm ${D}/${libdir}/libfreshclam.so
> +
> +    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)};then
> +        install -d ${D}${sysconfdir}/tmpfiles.d
> +        install -m 0644 ${WORKDIR}/tmpfiles.clamav ${D}${sysconfdir}/tmpfiles.d/clamav.conf
> +    fi
> +    oe_multilib_header clamav-types.h
> +}
> +
> +pkg_postinst:${PN} () {
> +    if [ -z "$D" ]; then
> +        if command -v systemd-tmpfiles >/dev/null; then
> +            systemd-tmpfiles --create ${sysconfdir}/tmpfiles.d/clamav.conf
> +        elif [ -e ${sysconfdir}/init.d/populate-volatile.sh ]; then
> +            ${sysconfdir}/init.d/populate-volatile.sh update
> +        fi
> +    fi
> +}
> +
> +PACKAGES += "${PN}-daemon ${PN}-clamdscan ${PN}-freshclam ${PN}-libclamav ${PN}-libclammspack"
> +
> +FILES:${PN} = "${bindir}/clambc ${bindir}/clamscan ${bindir}/clamsubmit ${sbindir}/clamonacc \
> +               ${bindir}/*sigtool ${mandir}/man1/clambc* ${mandir}/man1/clamscan* \
> +               ${mandir}/man1/sigtool* ${mandir}/man1/clambsubmit* \
> +               ${docdir}/clamav/*"
> +
> +FILES:${PN}-clamdscan = "${bindir}/clamdscan \
> +                         ${docdir}/clamdscan/* \
> +                         ${mandir}/man1/clamdscan* \
> +                         "
> +
> +FILES:${PN}-daemon = "${bindir}/clamconf ${bindir}/clamdtop ${sbindir}/clamd \
> +                      ${mandir}/man1/clamconf* ${mandir}/man1/clamdtop* \
> +                      ${mandir}/man5/clamd* ${mandir}/man8/clamd* \
> +                      ${sysconfdir}/clamd.conf* \
> +                      ${systemd_system_unitdir}/clamav-daemon/* \
> +                      ${docdir}/clamav-daemon/* ${sysconfdir}/clamav-daemon \
> +                      ${sysconfdir}/logcheck/ignore.d.server/clamav-daemon \
> +                      ${systemd_system_unitdir}/clamav-daemon.service \
> +                      ${systemd_system_unitdir}/clamav-clamonacc.service \
> +                      "
> +
> +FILES:${PN}-freshclam = "${bindir}/freshclam \
> +                         ${sysconfdir}/freshclam.conf* \
> +                         ${sysconfdir}/clamav ${sysconfdir}/default/volatiles \
> +                         ${sysconfdir}/tmpfiles.d/*.conf \
> +                         ${localstatedir}/lib/clamav \
> +                         ${docdir}/${PN}-freshclam ${mandir}/man1/freshclam.* \
> +                         ${mandir}/man5/freshclam.conf.* \
> +                         ${systemd_system_unitdir}/clamav-freshclam.service"
> +
> +FILES:${PN}-libclamav = "${libdir}/libclamav.so* \
> +                         ${libdir}/libfreshclam.so* ${docdir}/libclamav/* \
> +                         "
> +
> +FILES:${PN}-libclammspack = "${libdir}/libclammspack.so* \
> +                             ${libdir}/libmspack.so* \
> +                             "
> +
> +FILES:${PN}-dev = "${bindir}/clamav-config ${libdir}/*.la \
> +                   ${libdir}/pkgconfig/*.pc \
> +                   ${mandir}/man1/clamav-config.* \
> +                   ${includedir}/*.h ${docdir}/libclamav*"
> +
> +FILES:${PN}-staticdev = "${libdir}/*.a"
> +
> +FILES:${PN}-doc = "${mandir}/man/* \
> +                   ${datadir}/man/* \
> +                   ${docdir}/* \
> +                   "
> +
> +RDEPENDS:${PN} = "openssl ncurses-libncurses libxml2 libbz2 ncurses-libtinfo curl libpcre2 clamav-libclamav"
> +RDEPENDS:${PN}-daemon = "clamav clamav-freshclam"
> +RDEPENDS:${PN}-freshclam = "clamav"
> +RDEPENDS:${PN}-libclamav = "clamav-libclammspack"
> +
> +RRECOMMENDS:${PN} = "clamav-freshclam"
> +
> +RPROVIDES:${PN} += "${PN}-systemd"
> +RREPLACES:${PN} += "${PN}-systemd"  
> +RCONFLICTS:${PN} += "${PN}-systemd"
> +
> +SYSTEMD_PACKAGES = "${PN}-daemon ${PN}-freshclam"
> +SYSTEMD_SERVICE:${PN}-daemon = "clamav-daemon.service"
> +SYSTEMD_SERVICE:${PN}-freshclam = "clamav-freshclam.service"
> +
> +USERADD_PACKAGES = "${PN}-freshclam"
> +GROUPADD_PARAM:${PN}-freshclam = "--system ${CLAMAV_GROUP}"
> +USERADD_PARAM:${PN}-freshclam = "--system -g ${CLAMAV_GROUP} --home-dir \
> +                                 ${localstatedir}/lib/${BPN} \
> +                                 --no-create-home --shell /sbin/nologin ${CLAMAV_USER}"
> +
> +INSANE_SKIP:${PN}-libclamav += "dev-so"
> +INSANE_SKIP:${PN}-libclammspack += "dev-so"
> diff --git a/recipes-scanners/clamav/files/tmpfiles.clamav b/recipes-scanners/clamav/files/tmpfiles.clamav
> index fd5adfe..8e0849e 100644
> --- a/recipes-scanners/clamav/files/tmpfiles.clamav
> +++ b/recipes-scanners/clamav/files/tmpfiles.clamav
> @@ -1,3 +1,4 @@
>  #Type Path        Mode UID  GID  Age Argument
> +d /var/lib/clamav 0755 clamav clamav -
>  d /var/log/clamav 0755 clamav clamav -
>  f /var/log/clamav/freshclam.log 0644 clamav clamav -
> diff --git a/recipes-scanners/clamav/files/volatiles.03_clamav b/recipes-scanners/clamav/files/volatiles.03_clamav
> index ee2153c..0561c4d 100644
> --- a/recipes-scanners/clamav/files/volatiles.03_clamav
> +++ b/recipes-scanners/clamav/files/volatiles.03_clamav
> @@ -1,3 +1,4 @@
>  # <type> <owner> <group> <mode> <path> <linksource>
> +d clamav clamav 0755 /var/lib/clamav none
>  d clamav clamav 0755 /var/log/clamav none
>  f clamav clamav 0655 /var/log/clamav/freshclam.log none


