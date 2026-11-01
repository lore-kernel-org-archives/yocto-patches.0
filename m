Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11002.1793517617599759634
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 01 Nov 2026 00:20:18 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wCnG9zA5+ZqENoAAA--.4653S3;
	Sun, 01 Nov 2026 15:18:25 +0800 (CST)
Received: from chenqi-Redmi.. (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowABH2Ghq5+Zqq80pAA--.21820S2;
	Sun, 01 Nov 2026 15:17:00 +0800 (CST)
From: chenqi_hycx@cetc.com.cn
To: yocto-patches@lists.yoctoproject.org
Cc: chen_q07@163.com
Subject: [meta-selinux][PATCH] selinux: upgrade 3.10 -> 3.11
Date: Sun,  1 Nov 2026 15:20:05 +0800
Message-ID: <20261101072005.762131-1-chenqi_hycx@cetc.com.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowABH2Ghq5+Zqq80pAA--.21820S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAQYSCmrl8FED4AABsT
X-CM-DELIVERINFO: =?B?vRqGK6c9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoODccrEFRh21h5V2HAX9q96e1522XSszx503648eB8n52dt4FAhYXn/vL+4pa8ZX8UCUT
	zyUl651oRVmjIvU0BuaNppZfu/V0KvDXhnatrK135zYak/x82b0Sfic1aJUOnQ==
X-Coremail-Antispam: 1Uk129KBj9fXoWfur17WryDtFWUtFW5Jr1rZrc_yoW5CFy8Zo
	WSvw4Svw1UGr13G3yjyF47Zay7GFyFgF4fAFWSqr4DJw13JFyUKryvka13ZFWIvr4UGr97
	WFy8Gry0qrs5KF15l-sFpf9Il3svdjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn5kqx4xG64xvF2IEw4CE5I8CrVC2j2Wlc2xSY4AK67AK6r4xYxn0WfAS
	r-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUUbsAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI
	8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJ
	M28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vE
	x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
	6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lw4CEc2x0rVAKj4xxMxkIecxEwVAFwVW8CwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
	s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
	1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
	JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
	1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUv
	cSsGvfC2KfnxnUUI43ZEXa7IU8oSoJUUUUU==
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sun, 01 Nov 2026 07:20:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5204
Content-Type: text/plain; charset="utf-8"

From: Chen Qi <chenqi_hycx@cetc.com.cn>

All recipes come from the same SELinuxProject/selinux checkout, so they
are upgraded together.

ChangeLog:
https://github.com/SELinuxProject/selinux/releases/tag/3.11

* Several security improvements in libselinux, dbus, gui, mcstrans and
  sandbox
* Rewrote libselinux selinux_restorecon(3) to eliminate TOCTOU issues in
  file relabeling
* Rewrote restorecond and sandbox/seunshare to eliminate TOCTOU issues on
  their path-based operations
* restorecon only logs an error on a read-only filesystem instead of
  failing, allowing relabeling with read-only BTRFS subvolumes
* Added setfiles -A option to disable SELINUX_RESTORECON_ADD_ASSOC
* Added SELINUX_RESTORECON_SKIP_MULTILINK flag to selinux_restorecon(3)
  and made restorecond always pass it to avoid mislabeling hard links
* Improved restorecond.service to use the new restorecond -F option to
  run in the foreground
* Added secilcheck program to check CIL neverallows against binary
  policies
* Dropped legacy fscon statement support from checkpolicy
* Fixed checkpolicy handling of out-of-range and complement at range
  boundaries for xperm rules
* Fixed sandbox/seunshare remounting of /tmp and /var/tmp within the
  sandbox, its getopt flags and its interactive prompt for saving files
* Dropped sandbox/seunshare -k/--kill support
* Added a cache size cap, max client cap, receive timeout and maxbit cap
  to mcstrans to reduce the risk of DoS from misbehaving clients
* Fixed mcstrans UAF on SIGHUP reload of its configuration files
* Fixed semanage audit fd creation to avoid hitting RLIMIT_NOFILE on
  large semanage import operations
* Fixed libsepol generation of constraint expressions with a list of
  names when writing policy.conf from CIL
* Fixed libsepol to generate constrain/validatetrans instead of
  mlsconstrain/mlsvalidatetrans when converting a module to CIL
* Fixed libsepol selection of tunableif or booleanif, CIL source file
  info reporting, xperm rule permission linking and an off-by-one error
  in cats_ebitmap_len()
* Fixed libselinux constructor to not clobber errno
* Fixed libselinux selabel_partial_match(3) to correctly find partial
  matches
* Fixed libselinux selinux_init_policy_load() to still try to mount
  selinuxfs when the mount of sysfs on /sys fails
* Dropped Python 2 support from audit2why
* Reformatted entire tree based on .clang-format
* Updated pywrap and sepolicy build targets to use the Python3 build
  module
* Fixed build errors with glibc 2.43, non-pthread and uclibc builds
* Fixed multiple musl/llvm-based build issues
* Bug fixes

Recipe changes:

* Drop the patches that are upstream now: the libselinux LSF
  transitional API removal and the sepolicy releasever workaround.  The
  libselinux recipe has no patches left, so its recipe-local
  FILESEXTRAPATHS goes away too.
* Refresh the remaining patches for the reformatted sources.  No
  functional change.
* pywrap and sepolicy now build wheels with "python3 -m build
  --no-isolation", so libselinux-python and selinux-python depend on
  python3-build-native and python3-wheel-native.

Assisted-by: Codewhale:deepseek-v4-flash
Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
---
 ...heckpolicy_3.10.bb => checkpolicy_3.11.bb} |  0
 ...thon_3.10.bb => libselinux-python_3.11.bb} |  4 +-
 ...hon-modules-install-path-for-multili.patch | 11 ++--
 ...T-and-rely-on-the-installed-file-nam.patch | 10 +--
 ...re-drop-the-obsolete-LSF-transitiona.patch | 40 ------------
 ...{libselinux_3.10.bb => libselinux_3.11.bb} |  5 --
 ...anage-Fix-execve-segfaults-on-Ubuntu.patch |  9 +--
 ...anage-allow-to-disable-audit-support.patch | 46 +++++++-------
 ...ibsemanage_3.10.bb => libsemanage_3.11.bb} |  0
 .../{libsepol_3.10.bb => libsepol_3.11.bb}    |  0
 .../{mcstrans_3.10.bb => mcstrans_3.11.bb}    |  0
 ...eutils_3.10.bb => policycoreutils_3.11.bb} |  0
 ...estorecond_3.10.bb => restorecond_3.11.bb} |  0
 .../{secilc_3.10.bb => secilc_3.11.bb}        |  0
 ...inux-dbus_3.10.bb => selinux-dbus_3.11.bb} |  0
 ...elinux-gui_3.10.bb => selinux-gui_3.11.bb} |  0
 ...stall-path-for-new-pymodule-sepolicy.patch | 13 ++--
 ...f.substitutions-releasever-to-empty-.patch | 61 -------------------
 ...-python_3.10.bb => selinux-python_3.11.bb} |  4 +-
 ...andbox_3.10.bb => selinux-sandbox_3.11.bb} |  0
 recipes-security/selinux/selinux_common.inc   |  2 +-
 ...e-utils_3.10.bb => semodule-utils_3.11.bb} |  0
 22 files changed, 41 insertions(+), 164 deletions(-)
 rename recipes-security/selinux/{checkpolicy_3.10.bb => checkpolicy_3.11.bb} (100%)
 rename recipes-security/selinux/{libselinux-python_3.10.bb => libselinux-python_3.11.bb} (94%)
 delete mode 100644 recipes-security/selinux/libselinux/0003-libselinux-restore-drop-the-obsolete-LSF-transitiona.patch
 rename recipes-security/selinux/{libselinux_3.10.bb => libselinux_3.11.bb} (86%)
 rename recipes-security/selinux/{libsemanage_3.10.bb => libsemanage_3.11.bb} (100%)
 rename recipes-security/selinux/{libsepol_3.10.bb => libsepol_3.11.bb} (100%)
 rename recipes-security/selinux/{mcstrans_3.10.bb => mcstrans_3.11.bb} (100%)
 rename recipes-security/selinux/{policycoreutils_3.10.bb => policycoreutils_3.11.bb} (100%)
 rename recipes-security/selinux/{restorecond_3.10.bb => restorecond_3.11.bb} (100%)
 rename recipes-security/selinux/{secilc_3.10.bb => secilc_3.11.bb} (100%)
 rename recipes-security/selinux/{selinux-dbus_3.10.bb => selinux-dbus_3.11.bb} (100%)
 rename recipes-security/selinux/{selinux-gui_3.10.bb => selinux-gui_3.11.bb} (100%)
 delete mode 100644 recipes-security/selinux/selinux-python/0002-sepolicy-set-conf.substitutions-releasever-to-empty-.patch
 rename recipes-security/selinux/{selinux-python_3.10.bb => selinux-python_3.11.bb} (96%)
 rename recipes-security/selinux/{selinux-sandbox_3.10.bb => selinux-sandbox_3.11.bb} (100%)
 rename recipes-security/selinux/{semodule-utils_3.10.bb => semodule-utils_3.11.bb} (100%)

diff --git a/recipes-security/selinux/checkpolicy_3.10.bb b/recipes-security/selinux/checkpolicy_3.11.bb
similarity index 100%
rename from recipes-security/selinux/checkpolicy_3.10.bb
rename to recipes-security/selinux/checkpolicy_3.11.bb
diff --git a/recipes-security/selinux/libselinux-python_3.10.bb b/recipes-security/selinux/libselinux-python_3.11.bb
similarity index 94%
rename from recipes-security/selinux/libselinux-python_3.10.bb
rename to recipes-security/selinux/libselinux-python_3.11.bb
index 01b7b93..4ad16b8 100644
--- a/recipes-security/selinux/libselinux-python_3.10.bb
+++ b/recipes-security/selinux/libselinux-python_3.11.bb
@@ -14,13 +14,13 @@ FILESEXTRAPATHS:prepend := "${THISDIR}/libselinux:"
 SRC_URI += "\
         file://0001-Makefile-fix-python-modules-install-path-for-multili.patch;patchdir=.. \
         file://0002-Do-not-use-PYCEXT-and-rely-on-the-installed-file-nam.patch;patchdir=.. \
-        file://0003-libselinux-restore-drop-the-obsolete-LSF-transitiona.patch;patchdir=.. \
         file://0004-libselinux-Replace-PyString_FromString-with-PyUnicode.patch;patchdir=.. \
         "
 
 S = "${UNPACKDIR}/${BP}/libselinux"
 
-DEPENDS = "libsepol libpcre2 swig-native python3-setuptools-scm-native python3-pip-native"
+DEPENDS = "libsepol libpcre2 swig-native python3-setuptools-scm-native python3-pip-native \
+           python3-build-native python3-wheel-native"
 DEPENDS:append:libc-musl = " fts"
 
 RDEPENDS:${PN} = "libselinux python3-core python3-shell"
diff --git a/recipes-security/selinux/libselinux/0001-Makefile-fix-python-modules-install-path-for-multili.patch b/recipes-security/selinux/libselinux/0001-Makefile-fix-python-modules-install-path-for-multili.patch
index 8002149..0d0ebe6 100644
--- a/recipes-security/selinux/libselinux/0001-Makefile-fix-python-modules-install-path-for-multili.patch
+++ b/recipes-security/selinux/libselinux/0001-Makefile-fix-python-modules-install-path-for-multili.patch
@@ -11,18 +11,15 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+), 1 deletion(-)
 
 diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
-index 0dbba7f4..d8011c99 100644
+index 9ecdbd4d..5158959c 100644
 --- a/libselinux/src/Makefile
 +++ b/libselinux/src/Makefile
-@@ -198,7 +198,7 @@ ifneq ($(DISABLE_SHARED),y)
+@@ -196,7 +196,7 @@ ifneq ($(DISABLE_SHARED),y)
  endif
  
  install-pywrap: pywrap
--	CFLAGS="$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pip install --no-build-isolation --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
-+	CFLAGS="$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pip install --no-build-isolation --prefix=$(PREFIX) --root $(DESTDIR) --ignore-installed --no-deps $(PYTHON_SETUP_ARGS) .
+-	$(PYTHON) -m pip install --no-build-isolation --force-reinstall --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` dist/*.whl
++	$(PYTHON) -m pip install --no-build-isolation --force-reinstall --prefix=$(PREFIX) --root $(DESTDIR) --ignore-installed --no-deps dist/*.whl
  	install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init__.py
  	ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux$(PYCEXT) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
  
--- 
-2.34.1
-
diff --git a/recipes-security/selinux/libselinux/0002-Do-not-use-PYCEXT-and-rely-on-the-installed-file-nam.patch b/recipes-security/selinux/libselinux/0002-Do-not-use-PYCEXT-and-rely-on-the-installed-file-nam.patch
index b6bd671..b9a54fe 100644
--- a/recipes-security/selinux/libselinux/0002-Do-not-use-PYCEXT-and-rely-on-the-installed-file-nam.patch
+++ b/recipes-security/selinux/libselinux/0002-Do-not-use-PYCEXT-and-rely-on-the-installed-file-nam.patch
@@ -27,10 +27,9 @@ Signed-off-by: Changqing Li <changqing.li@windriver.com>
  1 file changed, 1 insertion(+), 2 deletions(-)
 
 diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
-index d8011c99..c611422d 100644
 --- a/libselinux/src/Makefile
 +++ b/libselinux/src/Makefile
-@@ -15,7 +15,6 @@ INCLUDEDIR ?= $(PREFIX)/include
+@@ -18,7 +18,6 @@
  PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
  PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
  PYTHONLIBDIR ?= $(shell $(PYTHON) -c "import sysconfig; print(sysconfig.get_path('platlib', vars={'platbase': '$(PREFIX)', 'base': '$(PREFIX)'}))")
@@ -38,15 +37,12 @@ index d8011c99..c611422d 100644
  RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
  RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIBRUBYARG_SHARED"]')
  RUBYINSTALL ?= $(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
-@@ -200,7 +199,7 @@ endif
+@@ -198,7 +197,7 @@
  install-pywrap: pywrap
- 	CFLAGS="$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pip install --no-build-isolation --prefix=$(PREFIX) --root $(DESTDIR) --ignore-installed --no-deps $(PYTHON_SETUP_ARGS) .
+ 	$(PYTHON) -m pip install --no-build-isolation --force-reinstall --prefix=$(PREFIX) --root $(DESTDIR) --ignore-installed --no-deps dist/*.whl
  	install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init__.py
 -	ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux$(PYCEXT) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
 +	ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux*.so $(DESTDIR)$(PYTHONLIBDIR)/
  
  install-rubywrap: rubywrap
  	test -d $(DESTDIR)$(RUBYINSTALL) || install -m 755 -d $(DESTDIR)$(RUBYINSTALL) 
--- 
-2.34.1
-
diff --git a/recipes-security/selinux/libselinux/0003-libselinux-restore-drop-the-obsolete-LSF-transitiona.patch b/recipes-security/selinux/libselinux/0003-libselinux-restore-drop-the-obsolete-LSF-transitiona.patch
deleted file mode 100644
index 2c7a70e..0000000
--- a/recipes-security/selinux/libselinux/0003-libselinux-restore-drop-the-obsolete-LSF-transitiona.patch
+++ /dev/null
@@ -1,40 +0,0 @@
-From c4cb7a15e3f5c4081e3a459f15da3e58449cc4de Mon Sep 17 00:00:00 2001
-From: Renato Caldas <renato@calgera.com>
-Date: Thu, 29 Jun 2023 13:59:11 +0100
-Subject: [PATCH] libselinux: restore: drop the obsolete LSF transitional API.
-
-The preferred way to enable LSF support on 32 bit systems is to define
-_FILE_OFFSET_BITS=64 when building selinux.
-
-Upstream-Status: Submitted [https://github.com/SELinuxProject/selinux/pull/401]
-
-Signed-off-by: Renato Caldas <renato@calgera.com>
----
- libselinux/src/selinux_restorecon.c | 4 ++--
- 1 file changed, 2 insertions(+), 2 deletions(-)
-
-diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
-index 8fadf4d2..f23bad0c 100644
---- a/libselinux/src/selinux_restorecon.c
-+++ b/libselinux/src/selinux_restorecon.c
-@@ -443,7 +443,7 @@ static int filespec_add(ino_t ino, const char *con, const char *file,
- 	file_spec_t *prevfl, *fl;
- 	uint32_t h;
- 	int ret;
--	struct stat64 sb;
-+	struct stat sb;
- 
- 	__pthread_mutex_lock(&fl_mutex);
- 
-@@ -457,7 +457,7 @@ static int filespec_add(ino_t ino, const char *con, const char *file,
- 	for (prevfl = &fl_head[h], fl = fl_head[h].next; fl;
- 	     prevfl = fl, fl = fl->next) {
- 		if (ino == fl->ino) {
--			ret = lstat64(fl->file, &sb);
-+			ret = lstat(fl->file, &sb);
- 			if (ret < 0 || sb.st_ino != ino) {
- 				freecon(fl->con);
- 				free(fl->file);
--- 
-2.34.1
-
diff --git a/recipes-security/selinux/libselinux_3.10.bb b/recipes-security/selinux/libselinux_3.11.bb
similarity index 86%
rename from recipes-security/selinux/libselinux_3.10.bb
rename to recipes-security/selinux/libselinux_3.11.bb
index 98fc5c8..ead3452 100644
--- a/recipes-security/selinux/libselinux_3.10.bb
+++ b/recipes-security/selinux/libselinux_3.11.bb
@@ -10,11 +10,6 @@ require selinux_common.inc
 
 inherit lib_package pkgconfig
 
-FILESEXTRAPATHS:prepend := "${THISDIR}/libselinux:"
-SRC_URI += "\
-        file://0003-libselinux-restore-drop-the-obsolete-LSF-transitiona.patch;patchdir=.. \
-        "
-
 DEPENDS = "libsepol libpcre2"
 DEPENDS:append:libc-musl = " fts"
 
diff --git a/recipes-security/selinux/libsemanage/libsemanage-Fix-execve-segfaults-on-Ubuntu.patch b/recipes-security/selinux/libsemanage/libsemanage-Fix-execve-segfaults-on-Ubuntu.patch
index 2ec8a62..bb2b6d6 100644
--- a/recipes-security/selinux/libsemanage/libsemanage-Fix-execve-segfaults-on-Ubuntu.patch
+++ b/recipes-security/selinux/libsemanage/libsemanage-Fix-execve-segfaults-on-Ubuntu.patch
@@ -17,18 +17,15 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+), 1 deletion(-)
 
 diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
-index 1731c5e8..c6ace295 100644
+index f14ebe97..2a50605f 100644
 --- a/libsemanage/src/semanage_store.c
 +++ b/libsemanage/src/semanage_store.c
-@@ -1445,7 +1445,7 @@ static int semanage_exec_prog(semanage_handle_t * sh,
+@@ -1505,7 +1505,7 @@ static int semanage_exec_prog(semanage_handle_t *sh, external_prog_t *e,
  	if (forkval == 0) {
  		/* child process.  file descriptors will be closed
  		 * because they were set as close-on-exec. */
 -		execve(e->path, argv, NULL);
 +		execv(e->path, argv);
- 		_exit(EXIT_FAILURE);	/* if execve() failed */
+ 		_exit(EXIT_FAILURE); /* if execve() failed */
  	}
  
--- 
-2.34.1
-
diff --git a/recipes-security/selinux/libsemanage/libsemanage-allow-to-disable-audit-support.patch b/recipes-security/selinux/libsemanage/libsemanage-allow-to-disable-audit-support.patch
index 30d2afb..ab9c9f7 100644
--- a/recipes-security/selinux/libsemanage/libsemanage-allow-to-disable-audit-support.patch
+++ b/recipes-security/selinux/libsemanage/libsemanage-allow-to-disable-audit-support.patch
@@ -8,12 +8,12 @@ Upstream-Status: Inappropriate [embedded specific]
 Signed-off-by: Wenzong Fan <wenzong.fan@windriver.com>
 ---
  libsemanage/src/Makefile        | 10 +++++++++-
- libsemanage/src/seusers_local.c | 13 +++++++++++++
+ libsemanage/src/seusers_local.c | 10 ++++++++++
  libsemanage/tests/Makefile      | 10 +++++++++-
- 3 files changed, 31 insertions(+), 2 deletions(-)
+ 3 files changed, 28 insertions(+), 2 deletions(-)
 
 diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
-index fa3449fb..66c3010f 100644
+index 63c1499c..f6f76f0d 100644
 --- a/libsemanage/src/Makefile
 +++ b/libsemanage/src/Makefile
 @@ -27,6 +27,14 @@ ifeq ($(DEBUG),1)
@@ -31,17 +31,17 @@ index fa3449fb..66c3010f 100644
  LEX = flex
  LFLAGS = -s
  YACC = bison
-@@ -93,7 +101,7 @@ $(LIBA): $(OBJS)
+@@ -98,7 +106,7 @@ $(LIBA): $(OBJS)
  	$(RANLIB) $@
  
  $(LIBSO): $(LOBJS)
--	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L../../libselinux/src -lsepol -laudit -lselinux -lbz2 -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
-+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L../../libselinux/src -lsepol $(LIBAUDIT) -lselinux -lbz2 -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
+-	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -fPIC -shared -o $@ $^ -L../../libselinux/src -lsepol -laudit -lselinux -lbz2 -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
++	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -fPIC -shared -o $@ $^ -L../../libselinux/src -lsepol $(LIBAUDIT) -lselinux -lbz2 -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
  	ln -sf $@ $(TARGET)
  
  $(LIBPC): $(LIBPC).in ../VERSION
 diff --git a/libsemanage/src/seusers_local.c b/libsemanage/src/seusers_local.c
-index eb3f82bc..45da8257 100644
+index 865fe461..b959154c 100644
 --- a/libsemanage/src/seusers_local.c
 +++ b/libsemanage/src/seusers_local.c
 @@ -8,7 +8,11 @@ typedef struct semanage_seuser record_t;
@@ -56,44 +56,43 @@ index eb3f82bc..45da8257 100644
  #include <errno.h>
  #include "user_internal.h"
  #include "seuser_internal.h"
-@@ -56,6 +60,7 @@ static char *semanage_user_roles(semanage_handle_t * handle, const char *sename)
+@@ -57,6 +61,7 @@ static char *semanage_user_roles(semanage_handle_t *handle, const char *sename)
  	return roles;
  }
  
 +#ifndef DISABLE_AUDIT
- static int semanage_seuser_audit(semanage_handle_t * handle,
- 			  const semanage_seuser_t * seuser,
- 			  const semanage_seuser_t * previous,
-@@ -120,6 +125,7 @@ err:
+ static int semanage_seuser_audit(semanage_handle_t *handle,
+ 				 const semanage_seuser_t *seuser,
+ 				 const semanage_seuser_t *previous,
+@@ -123,6 +128,7 @@ err:
  	free(proles);
  	return rc;
  }
 +#endif
  
- int semanage_seuser_modify_local(semanage_handle_t * handle,
- 				 const semanage_seuser_key_t * key,
-@@ -165,8 +171,11 @@ int semanage_seuser_modify_local(semanage_handle_t * handle,
- 	(void) semanage_seuser_query(handle, key, &previous);
+ int semanage_seuser_modify_local(semanage_handle_t *handle,
+ 				 const semanage_seuser_key_t *key,
+@@ -170,9 +176,11 @@ int semanage_seuser_modify_local(semanage_handle_t *handle,
+ 	(void)semanage_seuser_query(handle, key, &previous);
  	handle->msg_callback = callback;
  	rc = dbase_modify(handle, dconfig, key, new);
-+
 +#ifndef DISABLE_AUDIT
- 	if (semanage_seuser_audit(handle, new, previous, AUDIT_ROLE_ASSIGN, rc == 0) < 0)
+ 	if (semanage_seuser_audit(handle, new, previous, AUDIT_ROLE_ASSIGN,
+ 				  rc == 0) < 0)
  		rc = -1;
 +#endif
  err:
  	if (previous)
  		semanage_seuser_free(previous);
-@@ -182,8 +191,12 @@ int semanage_seuser_del_local(semanage_handle_t * handle,
+@@ -188,9 +196,11 @@ int semanage_seuser_del_local(semanage_handle_t *handle,
  	dbase_config_t *dconfig = semanage_seuser_dbase_local(handle);
  	rc = dbase_del(handle, dconfig, key);
  	semanage_seuser_query(handle, key, &seuser);
-+
 +#ifndef DISABLE_AUDIT
- 	if (semanage_seuser_audit(handle, NULL, seuser, AUDIT_ROLE_REMOVE, rc == 0) < 0)
+ 	if (semanage_seuser_audit(handle, NULL, seuser, AUDIT_ROLE_REMOVE,
+ 				  rc == 0) < 0)
  		rc = -1;
 +#endif
-+
  	if (seuser)
  		semanage_seuser_free(seuser);
  	return rc;
@@ -121,6 +120,3 @@ index 241ff17a..fa03fb66 100644
  
  OBJECTS = $(SOURCES:.c=.o)
  POLICIES = $(CILS:.cil=.policy)
--- 
-2.34.1
-
diff --git a/recipes-security/selinux/libsemanage_3.10.bb b/recipes-security/selinux/libsemanage_3.11.bb
similarity index 100%
rename from recipes-security/selinux/libsemanage_3.10.bb
rename to recipes-security/selinux/libsemanage_3.11.bb
diff --git a/recipes-security/selinux/libsepol_3.10.bb b/recipes-security/selinux/libsepol_3.11.bb
similarity index 100%
rename from recipes-security/selinux/libsepol_3.10.bb
rename to recipes-security/selinux/libsepol_3.11.bb
diff --git a/recipes-security/selinux/mcstrans_3.10.bb b/recipes-security/selinux/mcstrans_3.11.bb
similarity index 100%
rename from recipes-security/selinux/mcstrans_3.10.bb
rename to recipes-security/selinux/mcstrans_3.11.bb
diff --git a/recipes-security/selinux/policycoreutils_3.10.bb b/recipes-security/selinux/policycoreutils_3.11.bb
similarity index 100%
rename from recipes-security/selinux/policycoreutils_3.10.bb
rename to recipes-security/selinux/policycoreutils_3.11.bb
diff --git a/recipes-security/selinux/restorecond_3.10.bb b/recipes-security/selinux/restorecond_3.11.bb
similarity index 100%
rename from recipes-security/selinux/restorecond_3.10.bb
rename to recipes-security/selinux/restorecond_3.11.bb
diff --git a/recipes-security/selinux/secilc_3.10.bb b/recipes-security/selinux/secilc_3.11.bb
similarity index 100%
rename from recipes-security/selinux/secilc_3.10.bb
rename to recipes-security/selinux/secilc_3.11.bb
diff --git a/recipes-security/selinux/selinux-dbus_3.10.bb b/recipes-security/selinux/selinux-dbus_3.11.bb
similarity index 100%
rename from recipes-security/selinux/selinux-dbus_3.10.bb
rename to recipes-security/selinux/selinux-dbus_3.11.bb
diff --git a/recipes-security/selinux/selinux-gui_3.10.bb b/recipes-security/selinux/selinux-gui_3.11.bb
similarity index 100%
rename from recipes-security/selinux/selinux-gui_3.10.bb
rename to recipes-security/selinux/selinux-gui_3.11.bb
diff --git a/recipes-security/selinux/selinux-python/0001-sepolicy-fix-install-path-for-new-pymodule-sepolicy.patch b/recipes-security/selinux/selinux-python/0001-sepolicy-fix-install-path-for-new-pymodule-sepolicy.patch
index 0e8354b..a5640e9 100644
--- a/recipes-security/selinux/selinux-python/0001-sepolicy-fix-install-path-for-new-pymodule-sepolicy.patch
+++ b/recipes-security/selinux/selinux-python/0001-sepolicy-fix-install-path-for-new-pymodule-sepolicy.patch
@@ -13,18 +13,15 @@ Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
  1 file changed, 1 insertion(+), 1 deletion(-)
 
 diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
-index 1a26cfdc..6e40691d 100644
+index 51812980..33a595d1 100644
 --- a/python/sepolicy/Makefile
 +++ b/python/sepolicy/Makefile
-@@ -27,7 +27,7 @@ test:
+@@ -26,7 +26,7 @@ test:
  	@$(PYTHON) test_sepolicy.py -v
  
- install:
--	$(PYTHON) -m pip install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
-+	$(PYTHON) -m pip install --prefix=$(PREFIX) --root $(DESTDIR) --ignore-installed --no-deps $(PYTHON_SETUP_ARGS) .
+ install: python-build
+-	$(PYTHON) -m pip install --no-build-isolation --force-reinstall --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` dist/*.whl
++	$(PYTHON) -m pip install --no-build-isolation --force-reinstall --prefix=$(PREFIX) --root $(DESTDIR) --ignore-installed --no-deps dist/*.whl
  	[ -d $(DESTDIR)$(BINDIR) ] || mkdir -p $(DESTDIR)$(BINDIR)
  	install -m 755 sepolicy.py $(DESTDIR)$(BINDIR)/sepolicy
  	(cd $(DESTDIR)$(BINDIR); ln -sf sepolicy sepolgen)
--- 
-2.34.1
-
diff --git a/recipes-security/selinux/selinux-python/0002-sepolicy-set-conf.substitutions-releasever-to-empty-.patch b/recipes-security/selinux/selinux-python/0002-sepolicy-set-conf.substitutions-releasever-to-empty-.patch
deleted file mode 100644
index e816be7..0000000
--- a/recipes-security/selinux/selinux-python/0002-sepolicy-set-conf.substitutions-releasever-to-empty-.patch
+++ /dev/null
@@ -1,61 +0,0 @@
-From 845f081ba3dab6c27aeac12ab20a45250fd9a8e6 Mon Sep 17 00:00:00 2001
-From: Yi Zhao <yi.zhao@windriver.com>
-Date: Tue, 24 Sep 2024 14:07:41 +0800
-Subject: [PATCH] sepolicy: set conf.substitutions['releasever'] to empty str
- when releasever is None
-
-For some distributions (e.g. Yocto) that do not provide
-system-release/distribution-release file, libdnf can not get releasever
-variable, causing conf.substitutions['releasever'] to not be set.
-This will cause 'sepolicy generate' command to fail with the following
-error on these distributions:
-
-$ sepolicy generate --init /usr/local/bin/foo
-Traceback (most recent call last):
-  File "/usr/bin/sepolicy", line 702, in <module>
-    args.func(args)
-  File "/usr/bin/sepolicy", line 569, in generate
-    mypolicy.gen_writeable()
-  File "/usr/lib/python3.12/site-packages/sepolicy/generate.py", line 1302, in gen_writeable
-    self.__extract_rpms()
-  File "/usr/lib/python3.12/site-packages/sepolicy/generate.py", line 1268, in __extract_rpms
-    base.read_all_repos()
-  File "/usr/lib/python3.12/site-packages/dnf/base.py", line 554, in read_all_repos
-    for repo in reader:
-                ^^^^^^
-  File "/usr/lib/python3.12/site-packages/dnf/conf/read.py", line 42, in __iter__
-    for r in self._get_repos(self.conf.config_file_path):
-             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-  File "/usr/lib/python3.12/site-packages/dnf/conf/read.py", line 109, in _get_repos
-    parser.setSubstitutions(substs)
-  File "/usr/lib/python3.12/site-packages/libdnf/conf.py", line 1643, in setSubstitutions
-    return _conf.ConfigParser_setSubstitutions(self, substitutions)
-           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-TypeError: in method 'ConfigParser_setSubstitutions', argument 2 of type 'std::map< std::string,std::string,std::less< std::string >,std::allocator< std::pair< std::string const,std::string > > > const &'
-
-Set conf.substitutions['releasever'] to empty str if releasever is None.
-
-Upstream-Status: Submitted [https://github.com/SELinuxProject/selinux/pull/444]
-
-Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
----
- python/sepolicy/sepolicy/generate.py | 3 +++
- 1 file changed, 3 insertions(+)
-
-diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepolicy/generate.py
-index adf65f27..56923dc4 100644
---- a/python/sepolicy/sepolicy/generate.py
-+++ b/python/sepolicy/sepolicy/generate.py
-@@ -1265,6 +1265,9 @@ allow %s_t %s_t:%s_socket name_%s;
-         import dnf
- 
-         with dnf.Base() as base:
-+            if base.conf.substitutions.get('releasever') is None:
-+                base.conf.substitutions['releasever'] = ''
-+
-             base.read_all_repos()
-             base.fill_sack(load_system_repo=True)
- 
--- 
-2.34.1
-
diff --git a/recipes-security/selinux/selinux-python_3.10.bb b/recipes-security/selinux/selinux-python_3.11.bb
similarity index 96%
rename from recipes-security/selinux/selinux-python_3.10.bb
rename to recipes-security/selinux/selinux-python_3.11.bb
index 61abd77..36f714c 100644
--- a/recipes-security/selinux/selinux-python_3.10.bb
+++ b/recipes-security/selinux/selinux-python_3.11.bb
@@ -11,12 +11,12 @@ require selinux_common.inc
 inherit python3targetconfig
 
 SRC_URI += "file://0001-sepolicy-fix-install-path-for-new-pymodule-sepolicy.patch;patchdir=.. \
-            file://0002-sepolicy-set-conf.substitutions-releasever-to-empty-.patch;patchdir=.. \
            "
 
 S = "${UNPACKDIR}/${BP}/python"
 
-DEPENDS = "libsepol libselinux gettext-native python3-setuptools-scm-native python3-pip-native"
+DEPENDS = "libsepol libselinux gettext-native python3-setuptools-scm-native python3-pip-native \
+           python3-build-native python3-wheel-native"
 
 RDEPENDS:${PN} = "\
         python3-core \
diff --git a/recipes-security/selinux/selinux-sandbox_3.10.bb b/recipes-security/selinux/selinux-sandbox_3.11.bb
similarity index 100%
rename from recipes-security/selinux/selinux-sandbox_3.10.bb
rename to recipes-security/selinux/selinux-sandbox_3.11.bb
diff --git a/recipes-security/selinux/selinux_common.inc b/recipes-security/selinux/selinux_common.inc
index 6932fea..5665bb3 100644
--- a/recipes-security/selinux/selinux_common.inc
+++ b/recipes-security/selinux/selinux_common.inc
@@ -1,7 +1,7 @@
 HOMEPAGE = "https://github.com/SELinuxProject"
 
 SRC_URI = "git://github.com/SELinuxProject/selinux.git;branch=main;protocol=https"
-SRCREV = "ca10fc4204ed60540d41d2499127c18ad0643f9e"
+SRCREV = "2233a23a4d4f1bf29054037babec13f30d038e65"
 
 require conf/selinux_refpolicy_common.inc
 
diff --git a/recipes-security/selinux/semodule-utils_3.10.bb b/recipes-security/selinux/semodule-utils_3.11.bb
similarity index 100%
rename from recipes-security/selinux/semodule-utils_3.10.bb
rename to recipes-security/selinux/semodule-utils_3.11.bb
-- 
2.43.0

