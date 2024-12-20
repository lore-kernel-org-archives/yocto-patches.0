Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE13E7718B
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 14:05:42 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
 by mx.groups.io with SMTP id smtpd.web10.152500.1734703533594633754
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Dec 2024 06:05:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=Ll9yzU68;
 spf=pass (domain: linaro.org, ip: 209.85.208.181, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3004028c714so21534601fa.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 06:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734703532; x=1735308332; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q66dSHG8CXwyab8rm7ANHU0shijyLRm5+GYmTaBeaT0=;
        b=Ll9yzU68i/curAzibuKjGVzH4m49MPMoiJ7ED/JNjEEZWokPJJHityAVMOCtRuaIHS
         MCO9yCXwtlqV9d90sawaRo4VWyVxCNNEEJTbXB5xnEr6/a1XVdwbPtMHCvigoeeStsTT
         1yIce/ghYyM7FDQp4jWaMIP2jwZnE+coYlqGlL9y3CbaEVD0A7ZH/RzGr60EAqIFVK5N
         wjddvR8f4pCgSMazbqPJNpwoEnZHY8v7+mffhJ2l+6Z4JhUdvWch9csZYVAuBm2Sn2zD
         wdHHB1vCnxAkCRhS+Sns+KPjrK8lDm8NviNdloAj+2okap/nim7E2IZT51l4CEZp+jrZ
         Y2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734703532; x=1735308332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q66dSHG8CXwyab8rm7ANHU0shijyLRm5+GYmTaBeaT0=;
        b=DIlci8hsapYjyq6sp66CC/CY08CCdG/Lb6/K6kzqXW40+uulsiYw+5iZc9vJCau0GY
         9FLjcSZ44BFh9cl4yagikteEyQ8u0AlEvVWQ+q9Aulgf+oby69hM6dFeXVg6Pro2//5B
         gPznKckM5SUDngD4ep1GQ5Mvu9g4HNi7Lid+AXLiKPE0lRZMYx9Mdtr/VhJL4zH88GYM
         BIdtWIkbc31enYhAYnraCD7a79mbnhMB71AGwSSkRxzr62ge55MXlJ2zonWh5NEBHGhg
         C4zMfPox2lbYzGU8IxH1qFj4ZksWw27tjwL+S1Tu2cxDpwSQW9LHmMzlE9iiRHDcp4pr
         zcMg==
X-Gm-Message-State: AOJu0YwqhJEaDM1n9rVxiFzYp8ZvtYsVbY0dkCPcI3QlJFOS3H5b4d+C
	KhPDLTVPftGydVx9BhUYtmZaUsoBfcXv7A5hRaj+o1WstKuZvaKWBVWJ0G8HiFuLcxoQsLJN/Us
	hUtY=
X-Gm-Gg: ASbGncs8ILhumcM4r+ZDMsm+7R8h4RhkZucGYxahYP+fEcCyLR5LVVWRgvU5WZAJR3I
	c8pIJ+tocweTJqHPWeUYdQwMxptHI3e0605yMDOM8Ghk1SUVdcEILpqMUmeCRnvdYWpRGaUkzdL
	d0arCaYefRIXllV3EkGmzGH674lh1hxBbyJcGg+DYVekyIIRynL2e6tJ/oPETnjUnCroyogiI8O
	YsJroHnMLlZCHuSEU1iBVdrkb/+NW0sonJ7CzZVyOhzXAmv6WSU0oNbV81x2xKGs8cdkUEvrmz9
	jJ96NcFR+3rhQzlFQZvGB9dDxQ==
X-Google-Smtp-Source: AGHT+IFHhqpqzqm5F3vdBVb0qfHqaA1yjQfhibjayXR3QYP71IMa32+vT8RRz9UwsLV7WTlqNA3AyQ==
X-Received: by 2002:a05:651c:4cb:b0:300:1448:c526 with SMTP id 38308e7fff4ca-3046861f16emr8352071fa.37.1734703531534;
        Fri, 20 Dec 2024 06:05:31 -0800 (PST)
Received: from localhost.localdomain (78-27-76-97.bb.dnainternet.fi. [78.27.76.97])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad6ca8fsm5227191fa.14.2024.12.20.06.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 06:05:30 -0800 (PST)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH 09/18] swtpm: update from 0.8.2 to 0.10.0
Date: Fri, 20 Dec 2024 16:04:32 +0200
Message-ID: <20241220140441.271395-10-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220140441.271395-1-mikko.rapeli@linaro.org>
References: <20241220140441.271395-1-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Dec 2024 14:05:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/948

Improves error reporting among other things. Changes:

https://github.com/stefanberger/swtpm/releases/tag/v0.10.0

version 0.10.0:

    swtpm:
        Requires libtpms v0.10.0
        Display tpmstate-opt-lock as a new capability
        Add support for lock option parameter to tpmstate option
        nvstore_linear: Add support for file-backend locking
        Remove broken logic to check for neither dir nor file backend
        Use ptm_cap_n to build PTM_GET_CAPABILITY response
        Define a structure to return PTM_GET_CAPABILITY result
        Implement --print-info to run TPMLIB_GetInfo with flags
        Support --profile fd= to read profile from file descriptor
        Support --profile file= to read profile from file
        Ignore remove-disabled parameter on non-'custom' profile
        Check for good entropy source in chroot environment
        Implement a check for HMAC+sha1 for testing future restriction
        Implement function to check whether a crypto algorithm is disabled
        Print cmdarg-print-profiles as part of capabilities
        Check whether SHA1 signature support is disabled in profile
        Use TPMLIB_WasManufactured to check whether profile was applied
        Determine whether OpenSSL needs to be configured (FIPs, SHA1 signature)
        Add support for --print-profiles option
        Print profile names as part of capabilities JSON
        Display new capability to allow setting a profile
        Add support for --profile option to set a profile on TPM 2
    swtpm_setup:
        Comment flags for storage primary key and deprecate --create-spk
        Implement --print-profiles to display all profile
        Add profile entries to swtpm_setup.conf written by swtpm_setup
        Add support for --profile-name option
        Accept profiles with name starting with 'custom:'
        Support default profile from file in swtpm_setup.conf
        Support --profile-file-fd to read profile from file descriptor
        Support --profile-file to read profile from file
        Always log the active profile
        Implement --profile-remove-fips-disabled option
        Read default profile from swtpm_setup.conf
        Print profile names as part of capabilities JSON
        Add support for --profile parameter
        Get default rsa keysize from setup_setup.conf if not given
    swtpm_ioctl:
        Use ptm_cap_n for non-CUSE PTM_GET_CAPABILITY response
    selinux:
        Change write to append for appending to log
        Add rule for logging to svirt_image_t labeled files from swtpm_t
    tests:
        Update IBMTSS2 test suite to v2.4.0
        Test activation of PCR banks when not all are available
        Enable SWTPM_TEST_PROFILE for running test_tpm2_ibmtss2 with profile
        Add a check for OPENSSL_ENABLE_SHA1_SIGNATURES in log file
        Consolidate custom profile test cases and check for StateFormatLevel
        Convert test_samples_create_tpmca to run installed
        Mention test_tpm2_libtpms_versions_profiles requiring env. variables
        allow running ibmtss2 tests against installed version
        Derive support for CUSE from SWTPM_EXE help screen
        Set OPENSSL_ENABLE_SHA1_SIGNATURES=1 for IBMTSS2 test
        Extend test case testing across libtpms versions
        Add test case for testing profiles across libtpms versions
        Test the --profile option of swtpm_setup and swtpm
        teach them to run installed
        add installed-runner.sh
        install tests on the system
        lookup system binaries if INSTALLED is set
    build-sys:
        enable 64-bit file API on 32-bit systems
        Add -Wshadow to the CFLAGS
        Require that libtpms v0.10 is available for TPMLIB_SetProfile
    debian:
        Add rule to allow usage of /var/tmp directory (QEMU)
        Add rules for reading profiles from distro and local dirs
        Allow non-owner file write access in /var/lib/libvirt/swtpm/
        Add sys_admin capability to apparmor profile

https://github.com/stefanberger/swtpm/releases/tag/v0.9.0

version 0.9.0:
Note: The SElinux policy for swtpm was completely redone. For systems
with an SELinux policy the same policy (>= 40.17) as used in
Fedora >= 40 is required due to changes in labels related to libvirt
that made the re-development of the SELinux policy necessary.

    swtpm:
        Use umask() to create/truncated state file rather than fchmod()
        Use fchmod to set mode bits provided by user
        Replace mkstemp with g_mkstemp_full (Coverity)
        fix typo in help message
        cuse: Fix Coverity complaints regarding locks
        Fix double free in error path
        Close fd after main loop
        Restore logging to stderr on log open failure
    swtpm_setup:
        Fail --pcr-banks without --tpm2
        Fail --decryption or --allow-signing without --tpm2
        Initialized argv in get_swtpm_capabilities()
        Flush spk after persisting to create room for another key
        Refactor duplicate code into swtpm_tpm2_write_cert_nvram
        Move persisting of certificate into tpm2_persist_certificate
        Pass key_type to function creating filename for key
        Add scheme parameter before curveid to createprimary_ecc
        Rename is_ek to preserve for future extension
        Mask-out EK and plaform certificate flags and set cert_flags
        Move common code into new function read_certificate_file()
        Exit with '0' upon --version rather than '1'
        Close file descriptors passed to swtpm process on parent side
        Make stdout unbuffered
        Use medium duration on TSC_PhysicalPresence to avoid timeouts
        Add poll() after write() and before read() to detect errors
    swtpm_localca:
        Add support for up to 20 bytes serial numbers
        Introduce --key as more generic alias for --ek
        Add missing NULL option to end of array
        Make stdout unbuffered
    swtpm_cert:
        Add support for serial numbers up to 20 bytes long
    swtpm_ioctl:
        Separate return code from flags
        Repeatedly call PTM_GET_INFO for long responses
    selinux:
        Re-add rule for svirt_tcg_t and user_tmp_t:sock_file (virt-install)
        New SELinux policy that requires Fedora 40 or later
    tests:
        Fixed occurrences of stray '' before '-'
        Rearrange order of test cases to run some also as 'root'
        Add tests for command line options and combinations of options
        Add softhsm_setup to shellcheck'ed files and fix issues
        Add missing 'exit 1' on unexpected file size on --reconfigure
        Add test cases for swtpm_cert with max serial number
        Fix spelling mistakes
        reformat regexs for easier readability and extension
        ibmtss2: Add patch to disable x509 test with older libtpms
        Upgrade to ibmtss2 v2.0.1
        Fixed several issues detected by shellcheck
    build-sys:
        Add support for --disable-tests to disable tests
        Display GMP_LIBS and GMP_CFLAGS
        Only display warning if pkg-config for gmp fails
        Add gmp library and devel package as dependency
        use PKG_CHECK_MODULES to check libtpms version
    rpm:
        Add gmp library and devel package as dependency
        Split off SELinux files to build an selinux package
    debian:
        Sync AppArmor profile with what is used by Ubuntu
        Add gmp library and devel package as dependency
        Allow apparmor access to qemu session bus swtpm files

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 .../swtpm/{swtpm_0.8.2.bb => swtpm_0.10.0.bb}          | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
 rename meta-tpm/recipes-tpm/swtpm/{swtpm_0.8.2.bb => swtpm_0.10.0.bb} (92%)

diff --git a/meta-tpm/recipes-tpm/swtpm/swtpm_0.8.2.bb b/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb
similarity index 92%
rename from meta-tpm/recipes-tpm/swtpm/swtpm_0.8.2.bb
rename to meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb
index b987f59..3e58c33 100644
--- a/meta-tpm/recipes-tpm/swtpm/swtpm_0.8.2.bb
+++ b/meta-tpm/recipes-tpm/swtpm/swtpm_0.10.0.bb
@@ -4,11 +4,11 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=fe8092c832b71ef20dfe4c6d3decb3a8"
 SECTION = "apps"
 
 # expect-native, socat-native, coreutils-native and net-tools-native are reportedly only required for the tests
-DEPENDS = "libtasn1 coreutils-native expect-native socat-native glib-2.0 net-tools-native libtpm json-glib"
+DEPENDS = "libtasn1 coreutils-native expect-native socat-native glib-2.0 net-tools-native libtpms json-glib"
 
-SRCREV = "507d14219dde88eb3eb2d10d15872d4044aa9d3e"
-SRC_URI = "git://github.com/stefanberger/swtpm.git;branch=stable-0.8;protocol=https"
-PE = "1"
+SRCREV = "54f4bb1e702a8b80d990ca00b6f72d5031dd131a"
+SRC_URI = "git://github.com/stefanberger/swtpm.git;branch=stable-0.10;protocol=https"
+PE = "2"
 
 S = "${WORKDIR}/git"
 
@@ -44,6 +44,6 @@ FILES:${PN}-cuse = "${bindir}/swtpm_cuse"
 
 INSANE_SKIP:${PN}   += "dev-so"
 
-RDEPENDS:${PN} = "libtpm"
+RDEPENDS:${PN} = "libtpms"
 
 BBCLASSEXTEND = "native nativesdk"
-- 
2.43.0


