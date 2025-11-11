Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB8BCCF9E3
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 09:45:37 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13877.1762854333023961693
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Nov 2025 01:45:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fQWravBs;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: skandigraun@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47774d3536dso5122725e9.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 11 Nov 2025 01:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762854331; x=1763459131; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=77gUhXaL1gQUlK30keSRyLrCz2GTmBLuBFNWpVbAIXU=;
        b=fQWravBs+/0rGuf4+vYA5HnVLcvKu9V5Z/KCe+7p6ObhINvJCnFB/dG/NrxXL1DGXn
         syJKtVNi/1bR/h0gT4XjzGoGsIq2YnQcc18cmYGM4Z0Ukw5xxgFyf4rRfHe/1lBzsj3L
         G0AJ8hlySGs+FTG7cJjsDkcaUyctgUgSaGnrwdWtnliz4Rvy08V1DkSzSy1K36fMCDz+
         235p8oD27Ofx7Ea9dcwL5/JMQbMuZVK6VYbPcw3FqgCY8WGGq5fYozGZ/swom8dSh8Qv
         6DWRVpjaiH2z3bxM81cYWCiuesTmlVLe+fx6QuD5YBlkoG1QsTA74jLm68XBj9Y5qIDA
         yTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762854331; x=1763459131;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=77gUhXaL1gQUlK30keSRyLrCz2GTmBLuBFNWpVbAIXU=;
        b=fQR3gaJbXrMxOln8MPSUSihKVoL5391dpqMsiLUJ6v/RN/3WKQ5eFuhLXtG7JWR9MH
         BMYAi89EstBLhPxv30TPsjLPJNaEL92E4tXNKQLN6q/krRpRBtqQSCIFVEHtLIMwHiUf
         LGs4lWEOhyQuliALcwaGlGREW+VVxP4egpYGbK8JTv7scV9pmT8Q21M7xOJwjG/QCOmn
         +YVGMneLxR8e7Izo74eV6AWbD5df+rMTqHQ5DIJ2atIIBjcpAOmAwXPirYOaaZ3JwMHS
         /b8CioQ+nqsl9CpRDWL+gKSN02cFhh7rA1ecGE9ZeN85fzapEjOCBnldj6cirOi/pC3E
         eVWg==
X-Gm-Message-State: AOJu0YxJEy991I9gcDPnzrOWBvlZ/N3X4LdmX/qXknatt2REBY1VM+mA
	sZXh40gTDCgPqWj2e4L4Co5Y0D05BgNyYVsOsfN6YNhrqDoNdEt2+/C997nIU81X
X-Gm-Gg: ASbGncvpAk0sooPJuHbFxKGKqNvjw0SUY1vpAO+1EusJViZGeP6Kxsnxwy0vC+NkS15
	GAhEwJNlZjtrWLITNGKLwN6DkDWulljPn3QlUpth7dejSTMGHticIDNkIHb9QjG6HOM4jbcrOlk
	989L+Z+0TQ9raqLsdSoQpeKKCtHzqYjOTPJueNfVTUL04ROlPXsoo4bF2N3I41HvEcf306H7hET
	fql2C7FQN0hnLB9FTOmO6cEw8Rbah/FYEJWRAmFmAAJH1H2zJ3V65xGfBVGo1OylOUzH6OXrvOU
	gGkat5y+6fFT5O06XniUXqb2ojmQ6pke2Erf4g63Tw+EsDeShG/kRR0raMgrMekLcWb6pcN1uOg
	+rdZI85Bi9iiSSBgU559+rh9xeqAUHSYNcdkpIAGDmX8DxAssdMaTPYpFZjSg+Q6KJcSBxWvdnj
	Qx16ReGhqO
X-Google-Smtp-Source: AGHT+IEF6cqFW7kUK+O8KjlfWN7zkuT3guAFR1KbzRtarScizuPAeMv6HHqSz/vZwgpE8OD3+E8WLQ==
X-Received: by 2002:a05:600c:c4b8:b0:46e:3b58:1b40 with SMTP id 5b1f17b1804b1-47781420169mr28585195e9.4.1762854331009;
        Tue, 11 Nov 2025 01:45:31 -0800 (PST)
Received: from [192.168.1.106] ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bd084d4sm311489585e9.14.2025.11.11.01.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 01:45:30 -0800 (PST)
Message-ID: <16921f34-c41c-47a1-90e5-fbcd5045b1e0@gmail.com>
Date: Tue, 11 Nov 2025 10:45:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][PATCH v2 1/2] clamav: Add ClamAV
 1.4.3 recipe with enhanced security and Rust support
To: yocto-patches@lists.yoctoproject.org
Cc: Hemant Jadhav <hemant.jadhav@emerson.com>
References: <20251110214435.69522-1-hemant.jadhav@emerson.com>
Content-Language: en-US
From: Gyorgy Sarvari <skandigraun@gmail.com>
In-Reply-To: <20251110214435.69522-1-hemant.jadhav@emerson.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Nov 2025 09:45:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2482

On 11/10/25 22:44, Hemant Jadhav via lists.yoctoproject.org wrote:
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
> ---
>  recipes-scanners/clamav/clamav_1.4.3.bb       | 182 ++++++++++++++++++
>  recipes-scanners/clamav/files/tmpfiles.clamav |   1 +
>  .../clamav/files/volatiles.03_clamav          |   1 +
>  3 files changed, 184 insertions(+)
>  create mode 100644 recipes-scanners/clamav/clamav_1.4.3.bb
>
> diff --git a/recipes-scanners/clamav/clamav_1.4.3.bb b/recipes-scanners/clamav/clamav_1.4.3.bb
> new file mode 100644
> index 0000000..469ef28
> --- /dev/null
> +++ b/recipes-scanners/clamav/clamav_1.4.3.bb
> @@ -0,0 +1,182 @@
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

Thank you for the new version, but this S is still lurking here

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


