Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D104ECD3440
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 19:07:21 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5625.1762974431790756445
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 12 Nov 2025 11:07:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=diQkT5JR;
 spf=pass (domain: konsulko.com, ip: 209.85.222.169, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b25ed53fcbso3975285a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 12 Nov 2025 11:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1762974431; x=1763579231; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aBbmsLDcnkyk2rki+hej6KKChtDzhPd1/JQI60uDWgo=;
        b=diQkT5JRejPuTUQXp5teMGqcnAmx1PYEFB+Zz1XlaLvWC5JbBACZGXqQoZrXMkn2Yq
         4kVQCgDsINlOzm/UefqjYotYkVgaF2FWIpjVCSQ0WsNZRLQLRSUZ0T6h9Dvhql0LoHFm
         bPRQsr1peLgGm74HiLnDYt91EqEyI8GNt0YYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762974431; x=1763579231;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aBbmsLDcnkyk2rki+hej6KKChtDzhPd1/JQI60uDWgo=;
        b=DKCVRgu7OJ996jm2obagLWclOOslPyLqrVg3Y608TGvl/MNWEAcTiIPcK0muBGm4Zw
         dNO+DP85Oi5XfdFuXEaIQ5KdeqsGcquA0yXGW8/M88jfhBWntvpaRgRfb3WkeSCOWqR6
         yO/YrSnZLJ3mnHpqGlc3ZkgskR36dx1a4GJWDzLcoi7JefOVOPzufRrnNSU2vKIEp+Mh
         f40l+kMlhxZshOf/JhwRzbwmtpQkCq2liVNBSCKhFPcKqAfHdXJ4y8k6GtRL0cRKGJ7A
         YYbLs8zjt55bEk9N7NeE8hEiZa/ctB5pWYJ7nokh3R8G89T5sDJMcaJUmZMNRHl9g88s
         kSMg==
X-Gm-Message-State: AOJu0Yw7o+gEZNJaaLNK+YV0RmzSbHunrWE04ff3Z4yPUdyfUNgpGu+s
	X75sXgrmRc7P/BxVXzxZh1RC3q3BuTGsl+2M+iP0f3bcPcjG1b9OXdzYKkccDkvoJiY=
X-Gm-Gg: ASbGncvwjLq5XIrm52FohngxCasU5UxGSEM9Lfvqln8dAkMFR9WcWt/26vhxEWHcCLE
	+opQcWo/O4kDzOygx1XwwRbbuBbE87RCoy0CLZJSSzBlVkXMRTW6tWXa++I142O4Ybo7nrc+3gK
	mMCOb647YQ7SGRp/cSNtVqQtID2mqxDthuPnaH3kw5DwcnP5ZHGI1q9UrjmiczrSeqEtjy01HS6
	whvEIby6jCl1q+HPqhTDsJtl2gp4AVItAnlyDuO8ai+h6FRclB9KvFZ+DcmEwUt12OIiqghQkJw
	IXj4G5vnn9Xd0B8Vq4r2TB/6DYb/OJAfCOVndRraqxWBakzTmy24zggGIc68TP0B8wMXws/ZWbU
	K0BYEloEqnESS3CLEhDfkYTD7QhruEDAPUqMLt4++tx767cc7GGbZMdC015wIR4jut0/GN19sAh
	MGrNdxp81Ks8NADrNN4idWZI+IqP/gbfmDdiA=
X-Google-Smtp-Source: AGHT+IGueuNcho5dc0sCe2gQnGLdSd4HBZKlCtnj/w17u9QdKoZd7Ozm/h5NnpNMvSyrihDq54Yafg==
X-Received: by 2002:a05:620a:17a3:b0:8b2:34b8:16e9 with SMTP id af79cd13be357-8b29b7c74f3mr499085785a.48.1762974430355;
        Wed, 12 Nov 2025 11:07:10 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29aa27893sm241113085a.56.2025.11.12.11.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 11:07:10 -0800 (PST)
Date: Wed, 12 Nov 2025 14:07:09 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: Hemant Jadhav <hemant.jadhav@emerson.com>
cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-security][PATCH v3 1/2] clamav: Add ClamAV
 1.4.3 recipe with enhanced security and Rust support
In-Reply-To: <20251111144857.80186-1-hemant.jadhav@emerson.com>
Message-ID: <76cdfeb3-b214-a87a-f6bf-3df119784887@konsulko.com>
References: <20251111144857.80186-1-hemant.jadhav@emerson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 12 Nov 2025 19:07:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2499

On Tue, 11 Nov 2025, Hemant Jadhav via lists.yoctoproject.org wrote:

> Add modern ClamAV 1.4.3 recipe with comprehensive improvements over
> the legacy 0.104.4 version.

How are you testing this?  ATM it fails to build since only cargo_common's
do_configure is getting run, leaving CMake unconfigured:

$ less temp/log.do_compile
DEBUG: Executing shell function do_compile
NOTE: VERBOSE=1 cmake --build
/ws2/scottm/dev/oe/test.meta-security/build/tmp/work/x86-64-v3-oe-linux/clamav/1.4.3/build
--target all --
Error: not a CMake build directory (missing CMakeCache.txt)
WARNING: exit code 1 from a shell command.

At the very minimum you'll need a custom do_configure that calls both
cmake_do_configure and cargo_common_do_configure.  Please do not send a
v4 until you have a build reproducibly working from a clean build tree
(i.e. either from scratch or at least with tmp removed).

Scott

> Major changes in 1.4.3:
> - Upgraded core engine with improved threat detection capabilities
> - Added Rust components requiring cross-compilation support
> - Updated CMake build system replacing legacy autotools
> - Modernized library dependencies (LLVM, JSON-C, PCre2)
> - Added comprehensive license compliance for multi-component package
> - Enhanced cross-compilation support for all target architectures
>
> The recipe leverages cargo_common class for automatic Rust toolchain
> configuration, eliminating manual Cargo setup. File paths use UNPACKDIR
> for compatibility with master branch.
>
> - Implemented CMake cache variables for cross-compilation
> - Updated all license checksums for compliance
> - Added Rust toolchain integration with automatic environment setup
>
> Security rationale:
> - ClamAV 0.104.4 reached end-of-life and is no longer maintained
> - Upstream strongly recommends migration to 1.4.x for security updates
>
> Signed-off-by: Hemant Jadhav <hemant.jadhav@emerson.com>
> ---
> v2: Address review comments:
> - Remove S variable (auto-detected in master branch)
> - Use cargo_common instead of rust-common (handles config.toml automatically)
> - Remove manual Cargo configuration in do_configure:prepend()
> - Change ${WORKDIR} to ${UNPACKDIR} for file path references
>
> v3: Remove S variable that was mistakenly left in v2
> ---
>  recipes-scanners/clamav/clamav_1.4.3.bb       | 181 ++++++++++++++++++
>  recipes-scanners/clamav/files/tmpfiles.clamav |   1 +
>  .../clamav/files/volatiles.03_clamav          |   1 +
>  3 files changed, 183 insertions(+)
>  create mode 100644 recipes-scanners/clamav/clamav_1.4.3.bb
>
> diff --git a/recipes-scanners/clamav/clamav_1.4.3.bb b/recipes-scanners/clamav/clamav_1.4.3.bb
> new file mode 100644
> index 0000000..f6b97d3
> --- /dev/null
> +++ b/recipes-scanners/clamav/clamav_1.4.3.bb
> @@ -0,0 +1,181 @@
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
> +
> +COMPATIBLE_HOST:libc-musl:class-target = "null"
> +
> +LEAD_SONAME = "libclamav.so"
> +SO_VER = "12.0.0"
> +BINCONFIG = "${bindir}/clamav-config"
> +
> +inherit cmake chrpath pkgconfig useradd systemd multilib_header multilib_script cargo_common
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
> +MULTILIB_SCRIPTS = "${PN}-dev:${bindir}/clamav-config"
> +
> +do_install:append() {
> +    install -d ${D}/${sysconfdir}
> +    install -d ${D}/${localstatedir}/lib/clamav
> +    install -d ${D}${sysconfdir}/clamav ${D}${sysconfdir}/default/volatiles
> +
> +    install -m 644 ${UNPACKDIR}/clamd.conf ${D}${sysconfdir}
> +    install -m 644 ${UNPACKDIR}/freshclam.conf ${D}${sysconfdir}
> +    install -m 0644 ${UNPACKDIR}/volatiles.03_clamav  ${D}${sysconfdir}/default/volatiles/03_clamav
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
> +        install -m 0644 ${UNPACKDIR}/tmpfiles.clamav ${D}${sysconfdir}/tmpfiles.d/clamav.conf
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
>

