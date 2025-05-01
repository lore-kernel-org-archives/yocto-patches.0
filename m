Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366C0C3ABB0
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:41:02 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
 by mx.groups.io with SMTP id smtpd.web11.4652.1746132054339008363
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:40:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=bSQ+BzLD;
 spf=pass (domain: konsulko.com, ip: 209.85.222.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c9376c4bddso163388985a.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746132053; x=1746736853; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=au9BV1vvh3a+Cgh708wwjdDBf4UAcZy4L1zxishz8Iw=;
        b=bSQ+BzLD4WE94Nv7t3ym3SLnUK13rV3lPks4Bkn3Yux3+158rg0GDenzWFaG8QT9TY
         B1+IlycwTe0iDzrNlGwtfgeFlXqbx9fsNjTSv+YDvm4aWJ+NvO5XLdmjr9nWBtiZ7lR3
         YeVnyQVAQ/EMfBO7cgQCgC8VQyrhwm0LbfeBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132053; x=1746736853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=au9BV1vvh3a+Cgh708wwjdDBf4UAcZy4L1zxishz8Iw=;
        b=cWj7Kq9x9rMiDsmhRcjAK72iuivJJ5oQVrw7Qa9rWXaaqtuQ5MXAs7K7hQIfL3z8cv
         SIzYifZKN4yOr8WCxpqSB5RH4B8u77zQySjXvKnfN8NZmBS1eMAXBNqMQDAQLpLWbJTo
         PRiudP8LOEqA9oZ+mYlYaCNXSdnXrWwzCmUqX5+AdDjRTcQQji6vc+1HIZUgw34lHwYb
         gtbwotKrnmMpOub53n6lS+e1rS9hPHDQOgpkSr56diTLi1X0EcifVe5O5X54eHRxHBA+
         t7KiM9ttv5mHZjfktZZlUkLg+R5LEJ/GMUOkypIEaAUHLgVw6cZgzEvyCmSdtf2LP/Yj
         6/aQ==
X-Gm-Message-State: AOJu0YwRZ/DlgI5VxOBNj2qlJZLn4Lz5R/qyG2Qm8CdXA2KWnBOMM86Q
	KeehtVh3rIrDh74oYJyXyK753QAgOKiukZTxSK7TamgH0fjKHmR/nBEww94C9M8GyYqBRDONOAC
	H
X-Gm-Gg: ASbGncuUN9uFb+GR62L47CjpTj9YUbx3Xu2e9dOt0QSeiQE1l0jChFji6ZNTUISnaug
	S+NUETl7FQAK3ro4DtgaQiLsKngolyicRnHpEqKHls7gHrtcRao7x9zNwvwkeu6V2GYM4DO/sRN
	91LnHPyz5P81gC8es0NS7YUy6bJAmIGfM5TWgXKPPir7bDZ10X1EivDSgaA+/B9u0GPxQYwmgGa
	Lo7qO68cX3CXT65tXpYGNMl3A/4z9QaEaJrEobmTy4sV3ehlk3lidCNYPVzp9euWcyEmDBJbGbZ
	JPfpOtH1Z1A7wvYNZXrjdTtggSJBpqhVxN3eFtWoXBoHSC4hmP/MR1iCfH0DjDK3vxLteqFNQIT
	m1x+6xEurlBaWuKgA
X-Google-Smtp-Source: AGHT+IFcHyYjAj70KeeiiPqabLH1N6f0q0Ll3pYrB5a6jYz2mWZYieq3qNfGC4i3pXsd9YwrALhzUQ==
X-Received: by 2002:a05:620a:290f:b0:7c7:93c7:f35d with SMTP id af79cd13be357-7cad5b5c15amr69593485a.31.1746132052815;
        Thu, 01 May 2025 13:40:52 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3b03ddsm9086216d6.7.2025.05.01.13.40.51
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:40:52 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 18/38] Backport newer Python setuptools-rust and setuptools
Date: Thu,  1 May 2025 16:39:54 -0400
Message-ID: <5b33fe5072c224b9f644272175ff4e3ea73166f9.1746130391.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746130391.git.scott.murray@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:41:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1445

To fix building python3-cryptography with Rust >= 1.83, a newer
python3-setuptools-rust is required.  As a consequence, newer
python3-setuptools is also required to satisfy its dependencies.
To simplify maintenance, the versions from scarthgap branch have
been used for the backport (1.9.0 and 69.1.1, respectively).

Note that extracting the specific cross-compilation fixes from
setuptools-rust was considered, but rejected due to the effort
required to get all of the required pieces untangled from its
commit history, and it not being obvious how to guarantee that
the result would not break some downstream usages.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 README.md                                     |   5 +
 conf/layer.conf                               |   4 +
 .../python/python3-setuptools-rust_1.9.0.bb   |  35 ++
 .../python3-setuptools-scm_6.4.2.bbappend     |   2 +
 ...nfig.py-make-it-possible-to-substite.patch |  58 ++++
 ...ly-do-not-fetch-code-by-easy_install.patch |  31 ++
 .../python3-setuptools/CVE-2024-6345.patch    | 312 ++++++++++++++++++
 .../python/python3-setuptools_69.1.1.bb       |  58 ++++
 8 files changed, 505 insertions(+)
 create mode 100644 recipes-devtools/python/python3-setuptools-rust_1.9.0.bb
 create mode 100644 recipes-devtools/python/python3-setuptools-scm_6.4.2.bbappend
 create mode 100644 recipes-devtools/python/python3-setuptools/0001-_distutils-sysconfig.py-make-it-possible-to-substite.patch
 create mode 100644 recipes-devtools/python/python3-setuptools/0001-conditionally-do-not-fetch-code-by-easy_install.patch
 create mode 100644 recipes-devtools/python/python3-setuptools/CVE-2024-6345.patch
 create mode 100644 recipes-devtools/python/python3-setuptools_69.1.1.bb

diff --git a/README.md b/README.md
index 13962b4..dc31161 100644
--- a/README.md
+++ b/README.md
@@ -38,6 +38,11 @@ Notes
   more potential impact due to upstream API changes and its known to be
   finicky build.  This may change if sufficient rationale for doing the
   backport becomes apparent.
+- To support building python3-cryptography with Rust >= 1.83, newer
+  python3-setuptools-rust and python3-setuptools have been backported
+  from scarthgap branch.  The setuptools backport is higher impact than
+  desired, but it seems lower risk than accidentally breaking a downstream
+  use of setuptools-rust trying to patch it to a working state.
 - While changes to Rust recipe and class files related to oe-selftest
   support are included by necessity, and the Rust selftest is backported
   (as "rust_mixin") to simplify the backporting workflow, note that no
diff --git a/conf/layer.conf b/conf/layer.conf
index 696ac90..42ea869 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -20,6 +20,10 @@ RUSTVERSION ?= "1.83%"
 # and several of them result in parse warnings.
 BBMASK:append = " meta/recipes-devtools/cargo/ meta/recipes-devtools/rust/ meta/recipes-gnome/librsvg"
 
+# Mask out old python3-setuptools-rust-native to avoid any conflicts with
+# the newer BBCLASSEXTEND version that we carry.
+BBMASK:append = " meta/recipes-devtools/python/python3-setuptools-rust-native_%"
+
 # These are in bitbake.conf in langdale and up, adding them here to make
 # using the layer more turn-key seems reasonable.
 BB_BASEHASH_IGNORE_VARS:append = " RUST_BUILD_SYS RUST_HOST_SYS RUST_TARGET_SYS"
diff --git a/recipes-devtools/python/python3-setuptools-rust_1.9.0.bb b/recipes-devtools/python/python3-setuptools-rust_1.9.0.bb
new file mode 100644
index 0000000..8eb2513
--- /dev/null
+++ b/recipes-devtools/python/python3-setuptools-rust_1.9.0.bb
@@ -0,0 +1,35 @@
+SUMMARY = "Setuptools Rust extension plugin"
+DESCRIPTION = "setuptools-rust is a plugin for setuptools to build Rust \
+Python extensions implemented with PyO3 or rust-cpython.\
+\
+Compile and distribute Python extensions written in Rust as easily as if they were written in C."
+HOMEPAGE = "https://github.com/PyO3/setuptools-rust"
+BUGTRACKER = "https://github.com/PyO3/setuptools-rust/issues"
+
+LICENSE = "MIT"
+LIC_FILES_CHKSUM = "file://LICENSE;md5=011cd92e702dd9e6b1a26157b6fd53f5"
+
+SRC_URI = "${PYPI_SRC_URI} \
+           https://files.pythonhosted.org/packages/67/08/e1aa2c582c62ac76e4d60f8e454bd3bba933781a06a88b4e38797445822a/setuptools-rust-${PV}.tar.gz \
+           "
+SRC_URI[sha256sum] = "704df0948f2e4cc60c2596ad6e840ea679f4f43e58ed4ad0c1857807240eab96"
+
+inherit cargo pypi python_setuptools_build_meta
+
+DEPENDS += "python3-setuptools-scm-native python3-wheel-native"
+# remove when https://github.com/PyO3/setuptools-rust/commit/7ced8d2a8f36e1b4fc41b5544636defb7bd44bdf
+# is included
+DEPENDS += "python3-semantic-version-native"
+
+RDEPENDS:${PN} += " \
+    python3-json \
+    python3-semantic-version \
+    python3-setuptools \
+    python3-setuptools-scm \
+    python3-shell \
+    python3-toml \
+    python3-typing-extensions \
+    python3-wheel \
+"
+
+BBCLASSEXTEND = "native nativesdk"
diff --git a/recipes-devtools/python/python3-setuptools-scm_6.4.2.bbappend b/recipes-devtools/python/python3-setuptools-scm_6.4.2.bbappend
new file mode 100644
index 0000000..2828948
--- /dev/null
+++ b/recipes-devtools/python/python3-setuptools-scm_6.4.2.bbappend
@@ -0,0 +1,2 @@
+# This seems required to reliably build python3-setuptools-scm-native
+DEPENDS += "python3-tomli-native"
\ No newline at end of file
diff --git a/recipes-devtools/python/python3-setuptools/0001-_distutils-sysconfig.py-make-it-possible-to-substite.patch b/recipes-devtools/python/python3-setuptools/0001-_distutils-sysconfig.py-make-it-possible-to-substite.patch
new file mode 100644
index 0000000..0f6c9d2
--- /dev/null
+++ b/recipes-devtools/python/python3-setuptools/0001-_distutils-sysconfig.py-make-it-possible-to-substite.patch
@@ -0,0 +1,58 @@
+From d393759315b189a738e4b6a2ce31dc18dbbfae29 Mon Sep 17 00:00:00 2001
+From: Alexander Kanavin <alex@linutronix.de>
+Date: Wed, 11 May 2022 21:41:14 +0200
+Subject: [PATCH] _distutils/sysconfig.py: make it possible to substite the
+ prefix to target sysroot
+
+This is done by probing STAGING_INCDIR/STAGING_LIBDIRenv vars:
+not the most elegant solution, but distutils/sysconfig has been
+tweaked to do this for many, many year, and so it's easiest
+to replicate here as well, the original is
+meta/recipes-devtools/python/python3/12-distutils-prefix-is-inside-staging-area.patch
+
+I'm not sure exactly why setuptools now needs a copy, and what
+would happen to this module in light of distutils deprecation.
+
+Upstream-Status: Inappropriate [oe-core specific]
+Signed-off-by: Alexander Kanavin <alex@linutronix.de>
+---
+ setuptools/_distutils/sysconfig.py | 12 ++++++++++--
+ 1 file changed, 10 insertions(+), 2 deletions(-)
+
+diff --git a/setuptools/_distutils/sysconfig.py b/setuptools/_distutils/sysconfig.py
+index a40a723..14f35e7 100644
+--- a/setuptools/_distutils/sysconfig.py
++++ b/setuptools/_distutils/sysconfig.py
+@@ -119,6 +119,8 @@ def get_python_inc(plat_specific=0, prefix=None):
+     sys.base_exec_prefix -- i.e., ignore 'plat_specific'.
+     """
+     default_prefix = BASE_EXEC_PREFIX if plat_specific else BASE_PREFIX
++    if os.environ.get('STAGING_INCDIR', ""):
++        default_prefix = os.environ['STAGING_INCDIR'].rstrip('include')
+     resolved_prefix = prefix if prefix is not None else default_prefix
+     try:
+         getter = globals()[f'_get_python_inc_{os.name}']
+@@ -238,7 +240,13 @@ def get_python_lib(plat_specific=0, standard_lib=0, prefix=None):
+ 
+     early_prefix = prefix
+ 
+-    if prefix is None:
++    if os.environ.get('STAGING_LIBDIR', ""):
++        lib_basename = os.environ['STAGING_LIBDIR'].split('/')[-1]
++    else:
++        lib_basename = "lib"
++    if prefix is None and os.environ.get('STAGING_LIBDIR', ""):
++        prefix = os.environ['STAGING_LIBDIR'].rstrip(lib_basename)
++    elif prefix is None:
+         if standard_lib:
+             prefix = plat_specific and BASE_EXEC_PREFIX or BASE_PREFIX
+         else:
+@@ -253,7 +261,7 @@ def get_python_lib(plat_specific=0, standard_lib=0, prefix=None):
+             # Pure Python
+             libdir = "lib"
+         implementation = 'pypy' if IS_PYPY else 'python'
+-        libpython = os.path.join(prefix, libdir, implementation + get_python_version())
++        libpython = os.path.join(prefix, lib_basename, implementation + get_python_version())
+         return _posix_lib(standard_lib, libpython, early_prefix, prefix)
+     elif os.name == "nt":
+         if standard_lib:
diff --git a/recipes-devtools/python/python3-setuptools/0001-conditionally-do-not-fetch-code-by-easy_install.patch b/recipes-devtools/python/python3-setuptools/0001-conditionally-do-not-fetch-code-by-easy_install.patch
new file mode 100644
index 0000000..2a3c71f
--- /dev/null
+++ b/recipes-devtools/python/python3-setuptools/0001-conditionally-do-not-fetch-code-by-easy_install.patch
@@ -0,0 +1,31 @@
+From 40648dfa770f9f7b9b9efa501c9ef7af96be9f2d Mon Sep 17 00:00:00 2001
+From: Hongxu Jia <hongxu.jia@windriver.com>
+Date: Tue, 17 Jul 2018 10:13:38 +0800
+Subject: [PATCH] conditionally do not fetch code by easy_install
+
+If var-NO_FETCH_BUILD is set, do not allow to fetch code from
+internet by easy_install.
+
+Upstream-Status: Inappropriate [oe specific]
+
+Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
+---
+ setuptools/command/easy_install.py | 5 +++++
+ 1 file changed, 5 insertions(+)
+
+diff --git a/setuptools/command/easy_install.py b/setuptools/command/easy_install.py
+index 5d6fd5c..377e575 100644
+--- a/setuptools/command/easy_install.py
++++ b/setuptools/command/easy_install.py
+@@ -676,6 +676,11 @@ class easy_install(Command):
+             os.path.exists(tmpdir) and _rmtree(tmpdir)
+ 
+     def easy_install(self, spec, deps=False):
++        if os.environ.get('NO_FETCH_BUILD', None):
++            log.error("ERROR: Do not try to fetch `%s' for building. "
++                      "Please add its native recipe to DEPENDS." % spec)
++            return None
++
+         with self._tmpdir() as tmpdir:
+             if not isinstance(spec, Requirement):
+                 if URL_SCHEME(spec):
diff --git a/recipes-devtools/python/python3-setuptools/CVE-2024-6345.patch b/recipes-devtools/python/python3-setuptools/CVE-2024-6345.patch
new file mode 100644
index 0000000..ac520be
--- /dev/null
+++ b/recipes-devtools/python/python3-setuptools/CVE-2024-6345.patch
@@ -0,0 +1,312 @@
+From 88807c7062788254f654ea8c03427adc859321f0 Mon Sep 17 00:00:00 2001
+From: Jason R. Coombs <jaraco@jaraco.com>
+Date: Mon Apr 29 20:01:38 2024 -0400
+Subject: [PATCH] Merge pull request #4332 from pypa/debt/package-index-vcs
+
+Modernize package_index VCS handling
+
+CVE: CVE-2024-6345
+
+Upstream-Status: Backport [https://github.com/pypa/setuptools/commit/88807c7062788254f654ea8c03427adc859321f0]
+
+Signed-off-by: Soumya Sambu <soumya.sambu@windriver.com>
+---
+ setup.cfg                             |   1 +
+ setuptools/package_index.py           | 145 ++++++++++++++------------
+ setuptools/tests/test_packageindex.py |  56 +++++-----
+ 3 files changed, 106 insertions(+), 96 deletions(-)
+
+diff --git a/setup.cfg b/setup.cfg
+index edf9798..238d00a 100644
+--- a/setup.cfg
++++ b/setup.cfg
+@@ -65,6 +65,7 @@ testing =
+ 	sys_platform != "cygwin"
+ 	jaraco.develop >= 7.21; python_version >= "3.9" and sys_platform != "cygwin"
+ 	pytest-home >= 0.5
++	pytest-subprocess
+ testing-integration = 
+ 	pytest
+ 	pytest-xdist
+diff --git a/setuptools/package_index.py b/setuptools/package_index.py
+index 271aa97..00a972d 100644
+--- a/setuptools/package_index.py
++++ b/setuptools/package_index.py
+@@ -1,6 +1,7 @@
+ """PyPI and direct package downloading."""
+ 
+ import sys
++import subprocess
+ import os
+ import re
+ import io
+@@ -585,7 +586,7 @@ class PackageIndex(Environment):
+             scheme = URL_SCHEME(spec)
+             if scheme:
+                 # It's a url, download it to tmpdir
+-                found = self._download_url(scheme.group(1), spec, tmpdir)
++                found = self._download_url(spec, tmpdir)
+                 base, fragment = egg_info_for_url(spec)
+                 if base.endswith('.py'):
+                     found = self.gen_setup(found, fragment, tmpdir)
+@@ -814,7 +815,7 @@ class PackageIndex(Environment):
+             else:
+                 raise DistutilsError("Download error for %s: %s" % (url, v)) from v
+ 
+-    def _download_url(self, scheme, url, tmpdir):
++    def _download_url(self, url, tmpdir):
+         # Determine download filename
+         #
+         name, fragment = egg_info_for_url(url)
+@@ -829,19 +830,59 @@ class PackageIndex(Environment):
+ 
+         filename = os.path.join(tmpdir, name)
+ 
+-        # Download the file
+-        #
+-        if scheme == 'svn' or scheme.startswith('svn+'):
+-            return self._download_svn(url, filename)
+-        elif scheme == 'git' or scheme.startswith('git+'):
+-            return self._download_git(url, filename)
+-        elif scheme.startswith('hg+'):
+-            return self._download_hg(url, filename)
+-        elif scheme == 'file':
+-            return urllib.request.url2pathname(urllib.parse.urlparse(url)[2])
+-        else:
+-            self.url_ok(url, True)  # raises error if not allowed
+-            return self._attempt_download(url, filename)
++        return self._download_vcs(url, filename) or self._download_other(url, filename)
++
++    @staticmethod
++    def _resolve_vcs(url):
++        """
++        >>> rvcs = PackageIndex._resolve_vcs
++        >>> rvcs('git+http://foo/bar')
++        'git'
++        >>> rvcs('hg+https://foo/bar')
++        'hg'
++        >>> rvcs('git:myhost')
++        'git'
++        >>> rvcs('hg:myhost')
++        >>> rvcs('http://foo/bar')
++        """
++        scheme = urllib.parse.urlsplit(url).scheme
++        pre, sep, post = scheme.partition('+')
++        # svn and git have their own protocol; hg does not
++        allowed = set(['svn', 'git'] + ['hg'] * bool(sep))
++        return next(iter({pre} & allowed), None)
++
++    def _download_vcs(self, url, spec_filename):
++        vcs = self._resolve_vcs(url)
++        if not vcs:
++            return
++        if vcs == 'svn':
++            raise DistutilsError(
++                f"Invalid config, SVN download is not supported: {url}"
++            )
++
++        filename, _, _ = spec_filename.partition('#')
++        url, rev = self._vcs_split_rev_from_url(url)
++
++        self.info(f"Doing {vcs} clone from {url} to {filename}")
++        subprocess.check_call([vcs, 'clone', '--quiet', url, filename])
++
++        co_commands = dict(
++            git=[vcs, '-C', filename, 'checkout', '--quiet', rev],
++            hg=[vcs, '--cwd', filename, 'up', '-C', '-r', rev, '-q'],
++        )
++        if rev is not None:
++            self.info(f"Checking out {rev}")
++            subprocess.check_call(co_commands[vcs])
++
++        return filename
++
++    def _download_other(self, url, filename):
++        scheme = urllib.parse.urlsplit(url).scheme
++        if scheme == 'file':  # pragma: no cover
++            return urllib.request.url2pathname(urllib.parse.urlparse(url).path)
++        # raise error if not allowed
++        self.url_ok(url, True)
++        return self._attempt_download(url, filename)
+ 
+     def scan_url(self, url):
+         self.process_url(url, True)
+@@ -857,64 +898,36 @@ class PackageIndex(Environment):
+         os.unlink(filename)
+         raise DistutilsError(f"Unexpected HTML page found at {url}")
+ 
+-    def _download_svn(self, url, _filename):
+-        raise DistutilsError(f"Invalid config, SVN download is not supported: {url}")
+-
+     @staticmethod
+-    def _vcs_split_rev_from_url(url, pop_prefix=False):
+-        scheme, netloc, path, query, frag = urllib.parse.urlsplit(url)
++    def _vcs_split_rev_from_url(url):
++        """
++        Given a possible VCS URL, return a clean URL and resolved revision if any.
++        >>> vsrfu = PackageIndex._vcs_split_rev_from_url
++        >>> vsrfu('git+https://github.com/pypa/setuptools@v69.0.0#egg-info=setuptools')
++        ('https://github.com/pypa/setuptools', 'v69.0.0')
++        >>> vsrfu('git+https://github.com/pypa/setuptools#egg-info=setuptools')
++        ('https://github.com/pypa/setuptools', None)
++        >>> vsrfu('http://foo/bar')
++        ('http://foo/bar', None)
++        """
++        parts = urllib.parse.urlsplit(url)
+ 
+-        scheme = scheme.split('+', 1)[-1]
++        clean_scheme = parts.scheme.split('+', 1)[-1]
+ 
+         # Some fragment identification fails
+-        path = path.split('#', 1)[0]
+-
+-        rev = None
+-        if '@' in path:
+-            path, rev = path.rsplit('@', 1)
+-
+-        # Also, discard fragment
+-        url = urllib.parse.urlunsplit((scheme, netloc, path, query, ''))
+-
+-        return url, rev
+-
+-    def _download_git(self, url, filename):
+-        filename = filename.split('#', 1)[0]
+-        url, rev = self._vcs_split_rev_from_url(url, pop_prefix=True)
+-
+-        self.info("Doing git clone from %s to %s", url, filename)
+-        os.system("git clone --quiet %s %s" % (url, filename))
+-
+-        if rev is not None:
+-            self.info("Checking out %s", rev)
+-            os.system(
+-                "git -C %s checkout --quiet %s"
+-                % (
+-                    filename,
+-                    rev,
+-                )
+-            )
++        no_fragment_path, _, _ = parts.path.partition('#')
+ 
+-        return filename
++        pre, sep, post = no_fragment_path.rpartition('@')
++        clean_path, rev = (pre, post) if sep else (post, None)
+ 
+-    def _download_hg(self, url, filename):
+-        filename = filename.split('#', 1)[0]
+-        url, rev = self._vcs_split_rev_from_url(url, pop_prefix=True)
++        resolved = parts._replace(
++            scheme=clean_scheme,
++            path=clean_path,
++            # discard the fragment
++            fragment='',
++        ).geturl()
+ 
+-        self.info("Doing hg clone from %s to %s", url, filename)
+-        os.system("hg clone --quiet %s %s" % (url, filename))
+-
+-        if rev is not None:
+-            self.info("Updating to %s", rev)
+-            os.system(
+-                "hg --cwd %s up -C -r %s -q"
+-                % (
+-                    filename,
+-                    rev,
+-                )
+-            )
+-
+-        return filename
++        return resolved, rev
+ 
+     def debug(self, msg, *args):
+         log.debug(msg, *args)
+diff --git a/setuptools/tests/test_packageindex.py b/setuptools/tests/test_packageindex.py
+index 41b9661..e4cd91a 100644
+--- a/setuptools/tests/test_packageindex.py
++++ b/setuptools/tests/test_packageindex.py
+@@ -2,7 +2,6 @@ import distutils.errors
+ import urllib.request
+ import urllib.error
+ import http.client
+-from unittest import mock
+ 
+ import pytest
+ 
+@@ -171,49 +170,46 @@ class TestPackageIndex:
+             assert dists[0].version == ''
+             assert dists[1].version == vc
+ 
+-    def test_download_git_with_rev(self, tmpdir):
++    def test_download_git_with_rev(self, tmp_path, fp):
+         url = 'git+https://github.example/group/project@master#egg=foo'
+         index = setuptools.package_index.PackageIndex()
+ 
+-        with mock.patch("os.system") as os_system_mock:
+-            result = index.download(url, str(tmpdir))
++        expected_dir = tmp_path / 'project@master'
++        fp.register([
++            'git',
++            'clone',
++            '--quiet',
++            'https://github.example/group/project',
++            expected_dir,
++        ])
++        fp.register(['git', '-C', expected_dir, 'checkout', '--quiet', 'master'])
+ 
+-        os_system_mock.assert_called()
++        result = index.download(url, tmp_path)
+ 
+-        expected_dir = str(tmpdir / 'project@master')
+-        expected = (
+-            'git clone --quiet ' 'https://github.example/group/project {expected_dir}'
+-        ).format(**locals())
+-        first_call_args = os_system_mock.call_args_list[0][0]
+-        assert first_call_args == (expected,)
++        assert result == str(expected_dir)
++        assert len(fp.calls) == 2
+ 
+-        tmpl = 'git -C {expected_dir} checkout --quiet master'
+-        expected = tmpl.format(**locals())
+-        assert os_system_mock.call_args_list[1][0] == (expected,)
+-        assert result == expected_dir
+-
+-    def test_download_git_no_rev(self, tmpdir):
++    def test_download_git_no_rev(self, tmp_path, fp):
+         url = 'git+https://github.example/group/project#egg=foo'
+         index = setuptools.package_index.PackageIndex()
+ 
+-        with mock.patch("os.system") as os_system_mock:
+-            result = index.download(url, str(tmpdir))
+-
+-        os_system_mock.assert_called()
+-
+-        expected_dir = str(tmpdir / 'project')
+-        expected = (
+-            'git clone --quiet ' 'https://github.example/group/project {expected_dir}'
+-        ).format(**locals())
+-        os_system_mock.assert_called_once_with(expected)
+-
+-    def test_download_svn(self, tmpdir):
++        expected_dir = tmp_path / 'project'
++        fp.register([
++            'git',
++            'clone',
++            '--quiet',
++            'https://github.example/group/project',
++            expected_dir,
++        ])
++        index.download(url, tmp_path)
++
++    def test_download_svn(self, tmp_path):
+         url = 'svn+https://svn.example/project#egg=foo'
+         index = setuptools.package_index.PackageIndex()
+ 
+         msg = r".*SVN download is not supported.*"
+         with pytest.raises(distutils.errors.DistutilsError, match=msg):
+-            index.download(url, str(tmpdir))
++            index.download(url, tmp_path)
+ 
+ 
+ class TestContentCheckers:
+-- 
+2.40.0
+
diff --git a/recipes-devtools/python/python3-setuptools_69.1.1.bb b/recipes-devtools/python/python3-setuptools_69.1.1.bb
new file mode 100644
index 0000000..7663101
--- /dev/null
+++ b/recipes-devtools/python/python3-setuptools_69.1.1.bb
@@ -0,0 +1,58 @@
+SUMMARY = "Download, build, install, upgrade, and uninstall Python packages"
+HOMEPAGE = "https://pypi.org/project/setuptools"
+SECTION = "devel/python"
+LICENSE = "MIT"
+LIC_FILES_CHKSUM = "file://LICENSE;md5=141643e11c48898150daa83802dbc65f"
+
+inherit pypi python_setuptools_build_meta
+
+CVE_PRODUCT = "python3-setuptools python:setuptools"
+
+SRC_URI:append:class-native = " file://0001-conditionally-do-not-fetch-code-by-easy_install.patch"
+
+SRC_URI += " \
+            file://0001-_distutils-sysconfig.py-make-it-possible-to-substite.patch \
+            file://CVE-2024-6345.patch \
+"
+
+SRC_URI[sha256sum] = "5c0806c7d9af348e6dd3777b4f4dbb42c7ad85b190104837488eab9a7c945cf8"
+
+DEPENDS += "python3"
+
+RDEPENDS:${PN} = "\
+    python3-compile \
+    python3-compression \
+    python3-ctypes \
+    python3-email \
+    python3-html \
+    python3-json \
+    python3-netserver \
+    python3-numbers \
+    python3-pickle \
+    python3-pkg-resources \
+    python3-pkgutil \
+    python3-plistlib \
+    python3-shell \
+    python3-stringold \
+    python3-threading \
+    python3-unittest \
+    python3-xml \
+"
+
+BBCLASSEXTEND = "native nativesdk"
+
+# The pkg-resources module can be used by itself, without the package downloader
+# and easy_install. Ship it in a separate package so that it can be used by
+# minimal distributions.
+PACKAGES =+ "python3-pkg-resources "
+FILES:python3-pkg-resources = "${PYTHON_SITEPACKAGES_DIR}/pkg_resources/*"
+RDEPENDS:python3-pkg-resources = "\
+    python3-compression \
+    python3-email \
+    python3-plistlib \
+    python3-pprint \
+"
+
+# This used to use the bootstrap install which didn't compile. Until we bump the
+# tmpdir version we can't compile the native otherwise the sysroot unpack fails
+INSTALL_WHEEL_COMPILE_BYTECODE:class-native = "--no-compile-bytecode"
-- 
2.49.0


