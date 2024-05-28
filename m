Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCB8C25B7C
	for <webhook@archiver.kernel.org>; Tue, 28 May 2024 18:14:44 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
 by mx.groups.io with SMTP id smtpd.web11.29845.1716920080318190046
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 May 2024 11:14:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hJN18fwZ;
 spf=pass (domain: gmail.com, ip: 209.85.128.171, mailfrom: akuster808@gmail.com)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-627dfbcf42aso11472057b3.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 28 May 2024 11:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716920079; x=1717524879; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PiMB9cg9SbFdfXosJgYmRGUN5BlCxjkxybDUenXFowE=;
        b=hJN18fwZ9sxqlkzKenUCz+ORhSNl7BhTAnw5TXeaLpdJOLXOvw8MjyWEciGtRC8Za9
         PMKYZsNZlJNQGlNjeLSopuoMEaI/lV+4EvzNNwOhYcbK5JXSQL6COanIN2k39Pdjbrvo
         miMx2OPEQszFw5We9mYXE7S9HZG6cEghsCJT4JKrw0IrFZDg9yzDW8jGl7bJFr+NFAD4
         g18qRtRdpryxNRLVjrGcOCgFgVbMUFRCUW1xjLXQZWecKjSs5DqEVu2xwMD3xH3a0wjL
         wFkaDnmVQBjyJjpRiccFYDk49zDCYRC8xvg/LZFFnHw9kaukdTATFmQg/rcVCpVbajkR
         9b7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716920079; x=1717524879;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PiMB9cg9SbFdfXosJgYmRGUN5BlCxjkxybDUenXFowE=;
        b=JoyYEpXLsT77BTe0MunjA6uYfZ3WgXsFxZOEPaJgNsOHCaMh639E5zQiTdc+pcJyx2
         pqbklVxnCxypOR82JY2QRFzmhRPsabkAZ9D8v6ONmpdA+19TTLFXUBA7uU/InRxi9VAY
         PrxOViPt26sSie3RTvX+tlmTg0RqBbyPMyTu0KaQy4UJOk5Zbktlo7Q/5WA/CzkKMEj8
         /+27WDCMHEybS2p51ENprAZ0sFUXGvMBO8YEPReCbQD18tJIQBTAUMscnrQXBvVUFq/M
         +Pt1fxdkDiMS3uEVC8zboxr/R9MtfSqx/hJUHPgk8qaJA4d4V+E1qiNB9uovpeVQfvdv
         Kl+w==
X-Gm-Message-State: AOJu0YyCe6be0a1I8fchHjOi4D4u1rcHs5/ce6VeHUpkeIrH7SWB+jfH
	n1m4IUizOJbz1i08tTvDOp1SeT7tNtg4YDkX2G8K2vJBoH0qzele
X-Google-Smtp-Source: AGHT+IFf3UXJrnFXfKLAtkR+9MWruFJbnU7TkRNLxEE5L9lIvGyBtXx3PSmYlBoda7ymLi/aqxfYvQ==
X-Received: by 2002:a81:b662:0:b0:628:c1f0:d8fd with SMTP id 00721157ae682-62a08f33ecemr127837277b3.52.1716920079118;
        Tue, 28 May 2024 11:14:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:45dd:7000:9f87:6ec9:14e6:1b94? ([2600:1700:45dd:7000:9f87:6ec9:14e6:1b94])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a37cda2sm21514047b3.9.2024.05.28.11.14.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 11:14:38 -0700 (PDT)
Message-ID: <348e3fd7-76d0-404e-881c-604433956c7c@gmail.com>
Date: Tue, 28 May 2024 14:14:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][PATCH] recipes: WORKDIR ->
 UNPACKDIR transition
To: changqing.li@windriver.com
References: <20240528054406.4031866-1-changqing.li@windriver.com>
Content-Language: en-US
Cc: yocto-patches@lists.yoctoproject.org
From: akuster808 <akuster808@gmail.com>
Autocrypt: addr=akuster808@gmail.com; keydata=
 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
 ApZ86eOP
In-Reply-To: <20240528054406.4031866-1-changqing.li@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 May 2024 18:14:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/237



On 5/28/24 1:44 AM, Changqing Li via lists.yoctoproject.org wrote:
> From: Changqing Li <changqing.li@windriver.com>
>
> * WORKDIR -> UNPACKDIR transition
> * Switch away from S = WORKDIR
>
> Signed-off-by: Changqing Li <changqing.li@windriver.com>
> ---
>   .../recipes-security/sssd/sssd_2.9.2.bb       |  2 +-
>   .../recipes-core/systemd/systemd_%.bbappend   |  2 +-
>   .../tpm2-abrmd/tpm2-abrmd_3.0.0.bb            |  4 +--
>   .../initrdscripts/initramfs-framework.inc     |  2 +-
>   recipes-ids/samhain/samhain-server.bb         |  4 +--
>   recipes-ids/samhain/samhain.inc               | 14 ++++-----
>   recipes-mac/smack/mmap-smack-test_1.0.bb      |  4 ++-
>   recipes-mac/smack/smack-test_1.0.bb           |  3 +-
>   recipes-mac/smack/tcp-smack-test_1.0.bb       |  3 +-
>   recipes-mac/smack/udp-smack-test_1.0.bb       |  3 +-

I dropped the 4 smack changes as Martin sent a patch earlier.

thanks,
Armin
>   .../ecryptfs-utils/ecryptfs-utils_111.bb      |  2 +-
>   recipes-security/libmhash/libmhash_0.9.9.9.bb |  4 +--
>   .../redhat-security/redhat-security_1.0.bb    | 29 ++++++++++---------
>   13 files changed, 41 insertions(+), 35 deletions(-)
>
> diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
> index d61471c..c53ec58 100644
> --- a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
> +++ b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
> @@ -91,7 +91,7 @@ do_install () {
>       install -d ${D}/${PYTHON_SITEPACKAGES_DIR}
>       mv ${D}/${BPN}  ${D}/${PYTHON_SITEPACKAGES_DIR}
>   
> -    install -m 600 ${WORKDIR}/${BPN}.conf ${D}/${sysconfdir}/${BPN}
> +    install -m 600 ${UNPACKDIR}/${BPN}.conf ${D}/${sysconfdir}/${BPN}
>   
>       # /var/log/sssd needs to be created in runtime. Use rmdir to catch if
>       # upstream stops creating /var/log/sssd, or adds something else in
> diff --git a/meta-integrity/recipes-core/systemd/systemd_%.bbappend b/meta-integrity/recipes-core/systemd/systemd_%.bbappend
> index 57b3684..f140f02 100644
> --- a/meta-integrity/recipes-core/systemd/systemd_%.bbappend
> +++ b/meta-integrity/recipes-core/systemd/systemd_%.bbappend
> @@ -8,6 +8,6 @@ SRC_URI += " \
>   do_install:append () {
>       for i in machine-id-commit random-seed; do
>           install -d ${D}/${systemd_system_unitdir}/systemd-$i.service.d
> -        install -m 0644 ${WORKDIR}/$i-sync.conf ${D}/${systemd_system_unitdir}/systemd-$i.service.d
> +        install -m 0644 ${UNPACKDIR}/$i-sync.conf ${D}/${systemd_system_unitdir}/systemd-$i.service.d
>       done
>   }
> diff --git a/meta-tpm/recipes-tpm2/tpm2-abrmd/tpm2-abrmd_3.0.0.bb b/meta-tpm/recipes-tpm2/tpm2-abrmd/tpm2-abrmd_3.0.0.bb
> index ea2433c..24fd5b5 100644
> --- a/meta-tpm/recipes-tpm2/tpm2-abrmd/tpm2-abrmd_3.0.0.bb
> +++ b/meta-tpm/recipes-tpm2/tpm2-abrmd/tpm2-abrmd_3.0.0.bb
> @@ -40,10 +40,10 @@ PACKAGECONFIG[systemd] = "--with-systemdsystemunitdir=${systemd_system_unitdir},
>   
>   do_install:append() {
>       install -d "${D}${sysconfdir}/init.d"
> -    install -m 0755 "${WORKDIR}/tpm2-abrmd-init.sh" "${D}${sysconfdir}/init.d/tpm2-abrmd"
> +    install -m 0755 "${UNPACKDIR}/tpm2-abrmd-init.sh" "${D}${sysconfdir}/init.d/tpm2-abrmd"
>   
>       install -d "${D}${sysconfdir}/default"
> -    install -m 0644 "${WORKDIR}/tpm2-abrmd.default" "${D}${sysconfdir}/default/tpm2-abrmd"
> +    install -m 0644 "${UNPACKDIR}/tpm2-abrmd.default" "${D}${sysconfdir}/default/tpm2-abrmd"
>   }
>   
>   FILES:${PN} += "${libdir}/systemd/system-preset \
> diff --git a/recipes-core/initrdscripts/initramfs-framework.inc b/recipes-core/initrdscripts/initramfs-framework.inc
> index 1a724d6..aa04348 100644
> --- a/recipes-core/initrdscripts/initramfs-framework.inc
> +++ b/recipes-core/initrdscripts/initramfs-framework.inc
> @@ -6,7 +6,7 @@ SRC_URI:append = "\
>   
>   do_install:append() {
>       # dm-verity
> -    install ${WORKDIR}/dmverity ${D}/init.d/80-dmverity
> +    install ${S}/dmverity ${D}/init.d/80-dmverity
>   }
>   
>   PACKAGES:append = " initramfs-module-dmverity"
> diff --git a/recipes-ids/samhain/samhain-server.bb b/recipes-ids/samhain/samhain-server.bb
> index 8bae2d2..030ec2b 100644
> --- a/recipes-ids/samhain/samhain-server.bb
> +++ b/recipes-ids/samhain/samhain-server.bb
> @@ -16,11 +16,11 @@ TARGET_CC_ARCH += "${LDFLAGS}"
>   do_install:append() {
>       if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
>           install -d ${D}${sysconfdir}/tmpfiles.d
> -        install -m 0644 ${WORKDIR}/samhain-server-volatiles.conf \
> +        install -m 0644 ${UNPACKDIR}/samhain-server-volatiles.conf \
>               ${D}${sysconfdir}/tmpfiles.d/samhain-server.conf
>       else
>           install -d ${D}${sysconfdir}/default/volatiles
> -        install -m 0644 ${WORKDIR}/samhain-server-volatiles \
> +        install -m 0644 ${UNPACKDIR}/samhain-server-volatiles \
>               ${D}${sysconfdir}/default/volatiles/samhain-server
>       fi
>   
> diff --git a/recipes-ids/samhain/samhain.inc b/recipes-ids/samhain/samhain.inc
> index f5bea1d..61ec0da 100644
> --- a/recipes-ids/samhain/samhain.inc
> +++ b/recipes-ids/samhain/samhain.inc
> @@ -64,8 +64,8 @@ EXTRA_OEMAKE:append:aarch64 = " CPPFLAGS+=-DCONFIG_ARCH_AARCH64=1"
>   EXTRA_OEMAKE:append:mips64 = " CPPFLAGS+=-DCONFIG_ARCH_MIPS64=1"
>   
>   do_unpack_samhain() {
> -    cd ${WORKDIR}
> -    tar -xzvf samhain-${PV}.tar.gz
> +    cd ${UNPACKDIR}
> +    tar -xzvf samhain-${PV}.tar.gz -C ${WORKDIR}
>   }
>   
>   python do_unpack:append() {
> @@ -129,19 +129,19 @@ do_compile:prepend:libc-musl () {
>   do_install:append () {
>   	oe_runmake install DESTDIR='${D}' INSTALL=install-boot
>   
> -	install -D -m 755 ${WORKDIR}/${INITSCRIPT_NAME}.init \
> +	install -D -m 755 ${UNPACKDIR}/${INITSCRIPT_NAME}.init \
>   		${D}${sysconfdir}/init.d/${INITSCRIPT_NAME}
>   
> -	install -D -m 755 ${WORKDIR}/${INITSCRIPT_NAME}.default \
> +	install -D -m 755 ${UNPACKDIR}/${INITSCRIPT_NAME}.default \
>   		${D}${sysconfdir}/default/${INITSCRIPT_NAME}
>   
>   	if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
>   		if [ "${SAMHAIN_MODE}" = "no" ]; then
> -		    install -D -m 0644 ${WORKDIR}/samhain.service ${D}/${systemd_system_unitdir}/samhain.service
> +		    install -D -m 0644 ${UNPACKDIR}/samhain.service ${D}/${systemd_system_unitdir}/samhain.service
>   		else
> -		    install -D -m 0644 ${WORKDIR}/samhain.service ${D}/${systemd_system_unitdir}/${BPN}.service
> +		    install -D -m 0644 ${UNPACKDIR}/samhain.service ${D}/${systemd_system_unitdir}/${BPN}.service
>   		fi
> -		install -D -m 0755 ${WORKDIR}/${BPN}.init ${D}/${libexecdir}/${BPN}
> +		install -D -m 0755 ${UNPACKDIR}/${BPN}.init ${D}/${libexecdir}/${BPN}
>   		sed -i -e 's,@LIBDIR@,${libexecdir},' \
>   		       -e 's,@SAMHAIN_HELPER@,${BPN},' \
>   		       -e 's,@MODE_NAME@,${MODE_NAME},' \
> diff --git a/recipes-mac/smack/mmap-smack-test_1.0.bb b/recipes-mac/smack/mmap-smack-test_1.0.bb
> index 9d11509..b11fbf3 100644
> --- a/recipes-mac/smack/mmap-smack-test_1.0.bb
> +++ b/recipes-mac/smack/mmap-smack-test_1.0.bb
> @@ -5,7 +5,9 @@ LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda
>   
>   SRC_URI = "file://mmap.c"
>   
> -S = "${WORKDIR}"
> +S = "${WORKDIR}/sources"
> +UNPACKDIR = "${S}"
> +
>   do_compile() {
>       ${CC} mmap.c ${LDFLAGS} -o mmap_test
>   }
> diff --git a/recipes-mac/smack/smack-test_1.0.bb b/recipes-mac/smack/smack-test_1.0.bb
> index 3ab57c6..cb5327a 100644
> --- a/recipes-mac/smack/smack-test_1.0.bb
> +++ b/recipes-mac/smack/smack-test_1.0.bb
> @@ -10,7 +10,8 @@ SRC_URI = " \
>              file://test_smack_onlycap.sh \
>   "
>   
> -S = "${WORKDIR}"
> +S = "${WORKDIR}/sources"
> +UNPACKDIR = "${S}"
>   
>   inherit features_check
>   
> diff --git a/recipes-mac/smack/tcp-smack-test_1.0.bb b/recipes-mac/smack/tcp-smack-test_1.0.bb
> index d2b3f6b..020d4b4 100644
> --- a/recipes-mac/smack/tcp-smack-test_1.0.bb
> +++ b/recipes-mac/smack/tcp-smack-test_1.0.bb
> @@ -8,7 +8,8 @@ SRC_URI = "file://tcp_server.c \
>              file://test_smack_tcp_sockets.sh \
>   "
>   
> -S = "${WORKDIR}"
> +S = "${WORKDIR}/sources"
> +UNPACKDIR = "${S}"
>   
>   do_compile() {
>       ${CC} tcp_client.c ${LDFLAGS} -o tcp_client
> diff --git a/recipes-mac/smack/udp-smack-test_1.0.bb b/recipes-mac/smack/udp-smack-test_1.0.bb
> index 9193f89..edef801 100644
> --- a/recipes-mac/smack/udp-smack-test_1.0.bb
> +++ b/recipes-mac/smack/udp-smack-test_1.0.bb
> @@ -7,8 +7,9 @@ SRC_URI = "file://udp_server.c \
>              file://udp_client.c \
>              file://test_smack_udp_sockets.sh \
>   "
> +S = "${WORKDIR}/sources"
> +UNPACKDIR = "${S}"
>   
> -S = "${WORKDIR}"
>   do_compile() {
>       ${CC} udp_client.c ${LDFLAGS} -o udp_client
>       ${CC} udp_server.c ${LDFLAGS} -o udp_server
> diff --git a/recipes-security/ecryptfs-utils/ecryptfs-utils_111.bb b/recipes-security/ecryptfs-utils/ecryptfs-utils_111.bb
> index 00e8997..83d37d6 100644
> --- a/recipes-security/ecryptfs-utils/ecryptfs-utils_111.bb
> +++ b/recipes-security/ecryptfs-utils/ecryptfs-utils_111.bb
> @@ -62,7 +62,7 @@ do_install:append() {
>              -e 's:-L${STAGING_LIBDIR}::' ${D}/${libdir}/pkgconfig/libecryptfs.pc
>       sed -i -e "s: ${base_sbindir}/cryptsetup: ${sbindir}/cryptsetup:" ${D}${bindir}/ecryptfs-setup-swap
>       if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
> -        install -D -m 0644 ${WORKDIR}/ecryptfs.service ${D}${systemd_system_unitdir}/ecryptfs.service
> +        install -D -m 0644 ${UNPACKDIR}/ecryptfs.service ${D}${systemd_system_unitdir}/ecryptfs.service
>       fi
>   }
>   
> diff --git a/recipes-security/libmhash/libmhash_0.9.9.9.bb b/recipes-security/libmhash/libmhash_0.9.9.9.bb
> index 49139d2..f725a26 100644
> --- a/recipes-security/libmhash/libmhash_0.9.9.9.bb
> +++ b/recipes-security/libmhash/libmhash_0.9.9.9.bb
> @@ -31,8 +31,8 @@ do_install:append() {
>   
>   do_compile_ptest() {
>       if [ ! -d ${S}/demo ]; then mkdir ${S}/demo; fi
> -    cp ${WORKDIR}/Makefile.test ${S}/demo/Makefile
> -    cp ${WORKDIR}/mhash.c ${S}/demo/
> +    cp ${UNPACKDIR}/Makefile.test ${S}/demo/Makefile
> +    cp ${UNPACKDIR}/mhash.c ${S}/demo/
>       make -C ${S}/demo CFLAGS="${CFLAGS} -I${S}/include/" LDFLAGS="${LDFLAGS} -L${S}/lib/.libs"
>   }
>   
> diff --git a/recipes-security/redhat-security/redhat-security_1.0.bb b/recipes-security/redhat-security/redhat-security_1.0.bb
> index c47688f..1f0ba6c 100644
> --- a/recipes-security/redhat-security/redhat-security_1.0.bb
> +++ b/recipes-security/redhat-security/redhat-security_1.0.bb
> @@ -18,23 +18,24 @@ SRC_URI = "file://find-chroot-py.sh \
>              file://selinux-check-devices.sh \
>              file://selinux-ls-unconfined.sh"
>   
> -S = "${WORKDIR}"
> +S = "${WORKDIR}/sources"
> +UNPACKDIR = "${S}"
>   
>   do_install() {
>   	install -d ${D}${bindir}
> -	install -m 0755 ${WORKDIR}/find-chroot-py.sh    ${D}${bindir}
> -	install -m 0755 ${WORKDIR}/find-chroot.sh    ${D}${bindir}
> -	install -m 0755 ${WORKDIR}/find-elf4tmp.sh    ${D}${bindir}
> -	install -m 0755 ${WORKDIR}/find-execstack.sh    ${D}${bindir}
> -	install -m 0755 ${WORKDIR}/find-hidden-exec.sh    ${D}${bindir}
> -	install -m 0755 ${WORKDIR}/find-nodrop-groups.sh    ${D}${bindir}
> -	install -m 0755 ${WORKDIR}/find-sh4errors.sh    ${D}${bindir}
> -	install -m 0755 ${WORKDIR}/find-sh4tmp.sh    ${D}${bindir}
> -	install -m 0755 ${WORKDIR}/lib-bin-check.sh    ${D}${bindir}
> -	install -m 0755 ${WORKDIR}/rpm-chksec.sh    ${D}${bindir}
> -	install -m 0755 ${WORKDIR}/rpm-drop-groups.sh    ${D}${bindir}
> -	install -m 0755 ${WORKDIR}/selinux-check-devices.sh    ${D}${bindir}
> -	install -m 0755 ${WORKDIR}/selinux-ls-unconfined.sh    ${D}${bindir}
> +	install -m 0755 ${S}/find-chroot-py.sh    ${D}${bindir}
> +	install -m 0755 ${S}/find-chroot.sh    ${D}${bindir}
> +	install -m 0755 ${S}/find-elf4tmp.sh    ${D}${bindir}
> +	install -m 0755 ${S}/find-execstack.sh    ${D}${bindir}
> +	install -m 0755 ${S}/find-hidden-exec.sh    ${D}${bindir}
> +	install -m 0755 ${S}/find-nodrop-groups.sh    ${D}${bindir}
> +	install -m 0755 ${S}/find-sh4errors.sh    ${D}${bindir}
> +	install -m 0755 ${S}/find-sh4tmp.sh    ${D}${bindir}
> +	install -m 0755 ${S}/lib-bin-check.sh    ${D}${bindir}
> +	install -m 0755 ${S}/rpm-chksec.sh    ${D}${bindir}
> +	install -m 0755 ${S}/rpm-drop-groups.sh    ${D}${bindir}
> +	install -m 0755 ${S}/selinux-check-devices.sh    ${D}${bindir}
> +	install -m 0755 ${S}/selinux-ls-unconfined.sh    ${D}${bindir}
>   }
>   
>   RDEPENDS:${PN} = "file libcap-ng procps findutils"


