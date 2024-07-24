Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAAEC3DA63
	for <webhook@archiver.kernel.org>; Wed, 24 Jul 2024 09:54:39 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
 by mx.groups.io with SMTP id smtpd.web11.7072.1721814872367793428
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 24 Jul 2024 02:54:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=wupGol0f;
 spf=pass (domain: linaro.org, ip: 209.85.167.51, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52efa9500e0so4508157e87.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 24 Jul 2024 02:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721814870; x=1722419670; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=veLdn76Obd0jD5LshBCSZfUD+UMqNuq4GBXepavBB2k=;
        b=wupGol0fHDSEMpAK4vqKEXf25pY98HyTyAP6dg/M0qRUzRtjqS9+TJc0IO41thd7Hs
         cCZ7LeWIubn5jampKAIb7Hj2r0dR13ZhGENiCl9fb/Y/yFvDolXpDb2rtONjXM+1BNq7
         5cCn7FZ2LDOTxCKF/pAYQmtxJ0LZdZdhMP9xfKLA31JGRgixGoN5ODyX309l5pxAhi+f
         w0qa7Q8F2yyv55AxlSfTQXST+/S6sDMPbEdM2GGUYxKNZGm+mRnKZI98wVTtL5CGjqqc
         5KL1S0S2xBUkACSyp5vEehdXhRntXD8pQi2hkbt96G0BjQRnJJemu/QLAoV1+UI/DoQ9
         vOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721814870; x=1722419670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=veLdn76Obd0jD5LshBCSZfUD+UMqNuq4GBXepavBB2k=;
        b=szIodNC3dvdziMuEj8ewsQ9D/hhGY7u+1irWz7SdnpTywMM6VA90mIXI01ZYhtn2yu
         nFSRpw7Ntul1uOZ5h0rZMXOYD3mfQ2Eg7PfvMAfJwWGhVGfDDmtz3vI4AF/u+hC9LHEn
         NoTdh5rWmPpr6pH37QME41AU9m++tfo8+0pxzYkj8lrmwMliSgAOKghr+gfnIbYGOxkG
         R2bq8uAPqHN6UE18MfpoQOKnzl+92M6jWkfCXPObNb/GKVdouUNk5+iBpdZye8JUF0E1
         zI0FFu9F3Rln/EitchQ75ZOJp8bI2VVNJMlMq4/WxbRBdy2B3fBPIcMa4zUGgsPeF4jG
         y5Pg==
X-Gm-Message-State: AOJu0Yw90l0lKv6hBP2ShGdMtQPJgZsoSQCNja0ddEXaBDHKOvdrkD5C
	v4+5DaClrriDkLc9pQzGRGzm8hMfPsfLgCAyUeV4mKps28SUR2lOX/89mJsGCEdOrDrelFrqs1Z
	c
X-Google-Smtp-Source: AGHT+IED02+j93MVxKgwUhycF8li9CMt8KkGxuuZ1q+lW6fyE7f2C9Y1uNa1NYIaf70Tesw1UP7vVg==
X-Received: by 2002:a05:6512:3c87:b0:52c:df8c:72cc with SMTP id 2adb3069b0e04-52fcda64051mr1488100e87.43.1721814870190;
        Wed, 24 Jul 2024 02:54:30 -0700 (PDT)
Received: from localhost.localdomain (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52f000cc0a7sm1310659e87.66.2024.07.24.02.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 02:54:29 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [meta-security][PATCH] python3-tpm2-pytss: update from 2.1.0 to 2.3.0
Date: Wed, 24 Jul 2024 12:54:02 +0300
Message-ID: <20240724095402.45962-1-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 24 Jul 2024 09:54:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/449

Upstream changlog shows that python 3.12 support
was added/fixed in version 2.2.0:

https://github.com/tpm2-software/tpm2-pytss/blob/master/CHANGELOG.md

To fix build error:

| DEBUG: Executing python function autotools_aclocals
| DEBUG: SITE files ['endian-little', 'bit-64', 'arm-common', 'arm-64', 'common-linux', 'common-glibc', 'aarch64-linux', 'common']
| DEBUG: Python function autotools_aclocals finished
| DEBUG: Executing shell function do_compile
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/recipe-sysroot-native/usr/lib/python3.12/site-packages/setuptools/__init__.py:80: _DeprecatedInstaller: setuptools.installer and fetch_build_eggs are deprecated.
| !!
|
|         ********************************************************************************
|         Requirements should be satisfied by a PEP 517 installer.
|         If you are using pip, you can try `pip install --use-pep517`.
|         ********************************************************************************
|
| !!
|   dist.fetch_build_eggs(dist.setup_requires)
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:27: SyntaxWarning: invalid escape sequence '\('
|   s = re.sub("#define TSS2_RC_LAYER\(level\).*", "", s)
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:28: SyntaxWarning: invalid escape sequence '\('
|   s = re.sub("(#define.*)TSS2_RC_LAYER\(0xff\)", "\g<1>0xff0000", s)
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:28: SyntaxWarning: invalid escape sequence '\g'
|   s = re.sub("(#define.*)TSS2_RC_LAYER\(0xff\)", "\g<1>0xff0000", s)
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:31: SyntaxWarning: invalid escape sequence '\*'
|   s = re.sub("/\*.*?\*/", "", s, flags=re.MULTILINE)
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:34: SyntaxWarning: invalid escape sequence '\('
|   s = re.sub("(#define [A-Za-z0-9_]+) +\(\(.*?\) \(.*?\)\)", "\g<1>...", s)
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:34: SyntaxWarning: invalid escape sequence '\g'
|   s = re.sub("(#define [A-Za-z0-9_]+) +\(\(.*?\) \(.*?\)\)", "\g<1>...", s)
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:35: SyntaxWarning: invalid escape sequence '\('
|   s = re.sub("(#define [A-Za-z0-9_]+) +\(\(.*?\).*?\) ", "\g<1>...", s)
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:35: SyntaxWarning: invalid escape sequence '\g'
|   s = re.sub("(#define [A-Za-z0-9_]+) +\(\(.*?\).*?\) ", "\g<1>...", s)
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:37: SyntaxWarning: invalid escape sequence '\)'
|   "(#define [A-Za-z0-9_]+) .*\n.*?.*\)\)", "\g<1>...", s, flags=re.MULTILINE
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:37: SyntaxWarning: invalid escape sequence '\g'
|   "(#define [A-Za-z0-9_]+) .*\n.*?.*\)\)", "\g<1>...", s, flags=re.MULTILINE
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:39: SyntaxWarning: invalid escape sequence '\g'
|   s = re.sub("(#define [A-Za-z0-9_]+) .*", "\g<1>...", s)
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:42: SyntaxWarning: invalid escape sequence '\['
|   s = re.sub("\[.+?\]", "[...]", s)
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:77: SyntaxWarning: invalid escape sequence '\)'
|   "#define TPM2_MAX_TAGGED_POLICIES.*\n.*TPMS_TAGGED_POLICY\)\)",
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:262: SyntaxWarning: invalid escape sequence '\s'
|   "TSS2_RC\s+Tss2_MU_BYTE_Marshal\(.+?\);", s, re.DOTALL | re.MULTILINE
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:266: SyntaxWarning: invalid escape sequence '\s'
|   "TSS2_RC\s+Tss2_MU_BYTE_Marshal\(.+?\);", "", s, 1, re.DOTALL | re.MULTILINE
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:270: SyntaxWarning: invalid escape sequence '\s'
|   "TSS2_RC\s+Tss2_MU_BYTE_Unmarshal\(.+?\);", s, re.DOTALL | re.MULTILINE
| /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts/prepare_headers.py:274: SyntaxWarning: invalid escape sequence '\s'
|   "TSS2_RC\s+Tss2_MU_BYTE_Unmarshal\(.+?\);",
| adding path: /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/scripts
| Traceback (most recent call last):
|   File "/home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/tpm2-pytss-2.1.0/setup.py", line 280, in <module>
|     setup(
|   File "/home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/recipe-sysroot-native/usr/lib/python3.12/site-packages/setuptools/__init__.py", line 103, in setup
|     return distutils.core.setup(**attrs)
|            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
|   File "/home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/recipe-sysroot-native/usr/lib/python3.12/site-packages/setuptools/_distutils/core.py", line 146, in setup
|     _setup_distribution = dist = klass(attrs)
|                                  ^^^^^^^^^^^^
|   File "/home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/recipe-sysroot-native/usr/lib/python3.12/site-packages/setuptools/dist.py", line 307, in __init__
|     _Distribution.__init__(self, dist_attrs)
|   File "/home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/recipe-sysroot-native/usr/lib/python3.12/site-packages/setuptools/_distutils/dist.py", line 286, in __init__
|     self.finalize_options()
|   File "/home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/recipe-sysroot-native/usr/lib/python3.12/site-packages/setuptools/dist.py", line 659, in finalize_options
|     ep(self)
|   File "/home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/recipe-sysroot-native/usr/lib/python3.12/site-packages/setuptools/dist.py", line 679, in _finalize_setup_keywords
|     ep.load()(self, ep.name, value)
|   File "/home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/recipe-sysroot-native/usr/lib/python3.12/site-packages/cffi/setuptools_ext.py", line 216, in cffi_modules
|     add_cffi_module(dist, cffi_module)
|   File "/home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/recipe-sysroot-native/usr/lib/python3.12/site-packages/cffi/setuptools_ext.py", line 49, in add_cffi_module
|     execfile(build_file_name, mod_vars)
|   File "/home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/recipe-sysroot-native/usr/lib/python3.12/site-packages/cffi/setuptools_ext.py", line 25, in execfile
|     exec(code, glob, glob)
|   File "scripts/libtss2_build.py", line 69, in <module>
|     ffibuilder.cdef(open("libesys.h").read())
|   File "/home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/recipe-sysroot-native/usr/lib/python3.12/site-packages/cffi/api.py", line 112, in cdef
|     self._cdef(csource, override=override, packed=packed, pack=pack)
|   File "/home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/recipe-sysroot-native/usr/lib/python3.12/site-packages/cffi/api.py", line 126, in _cdef
|     self._parser.parse(csource, override=override, **options)
|   File "/home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/recipe-sysroot-native/usr/lib/python3.12/site-packages/cffi/cparser.py", line 389, in parse
|     self._internal_parse(csource)
|   File "/home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/recipe-sysroot-native/usr/lib/python3.12/site-packages/cffi/cparser.py", line 396, in _internal_parse
|     self._process_macros(macros)
|   File "/home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/recipe-sysroot-native/usr/lib/python3.12/site-packages/cffi/cparser.py", line 479, in _process_macros
|     raise CDefError(
| cffi.CDefError: only supports one of the following syntax:
|   #define TPM2_HR_PCR ...     (literally dot-dot-dot)
|   #define TPM2_HR_PCR NUMBER  (with NUMBER an integer constant, decimal/hex/octal)
| got:
|   #define TPM2_HR_PCR ...<< TPM2_HR_SHIFT)
| ERROR: 'python3 setup.py build ' execution failed.
| WARNING: /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/temp/run.do_compile.2430604:190 exit 1 from 'exit 1'
| WARNING: Backtrace (BB generated script):
| 	#1: bbfatal_log, /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/temp/run.do_compile.2430604, line 190
| 	#2: setuptools3_legacy_do_compile, /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/temp/run.do_compile.2430604, line 180
| 	#3: do_compile, /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/temp/run.do_compile.2430604, line 162
| 	#4: main, /home/builder/src/base/build/tmp_trs-qemuarm64/work/cortexa57-trs-linux/python3-tpm2-pytss/2.1.0/temp/run.do_compile.2430604, line 194
NOTE: recipe python3-tpm2-pytss-2.1.0-r0: task do_compile: Failed
ERROR: Task (/home/builder/src/base/build/../meta-security/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.1.0.bb:do_compile) failed with exit code '1'

Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 ...pytss_2.1.0.bb => python3-tpm2-pytss_2.3.0.bb} | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)
 rename meta-tpm/recipes-tpm2/tpm2-pytss/{python3-tpm2-pytss_2.1.0.bb => python3-tpm2-pytss_2.3.0.bb} (57%)

diff --git a/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.1.0.bb b/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb
similarity index 57%
rename from meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.1.0.bb
rename to meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb
index c98d4ab..ae7dcfa 100644
--- a/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.1.0.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb
@@ -3,13 +3,18 @@ HOMEPAGE = "https://github.com/tpm2-software/tpm2-pytss"
 LICENSE = "BSD-2-Clause"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=500b2e742befc3da00684d8a1d5fd9da"
 
-SRC_URI[sha256sum] = "5b5b4b1456fdc1aeef3d2c3970beaa078c8f7f2648c97a69bcf60c5a2f95c897"
-
 PYPI_PACKAGE = "tpm2-pytss"
 
-DEPENDS = "python3-pkgconfig-native python3-pycparser-native python3-asn1crypto-native"
-DEPENDS:append = " python3-cryptography-native tpm2-tss" 
+SRC_URI[sha256sum] = "20071129379656f5f3c3bc16d364612672b147d81191fb4eb9f9ff9fbee48410"
+
+inherit autotools pkgconfig pypi setuptools3
 
-inherit autotools pkgconfig pypi setuptools3_legacy
+DEPENDS = " \
+    python3-asn1crypto-native \
+    python3-cryptography-native \
+    python3-pkgconfig-native \
+    python3-pycparser-native \
+    tpm2-tss \
+"
 
 RDEPENDS:${PN} = "libtss2"
-- 
2.34.1


