Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0629BCA5FA1
	for <webhook@archiver.kernel.org>; Mon, 28 Sep 2026 21:10:30 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.68695.1790629827722814485
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 28 Sep 2026 14:10:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=mxLcyoqc;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-256628-202609282110260aa8d1254c000207a7-_6sb8c@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202609282110260aa8d1254c000207a7
        for <yocto-patches@lists.yoctoproject.org>;
        Mon, 28 Sep 2026 23:10:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=M5xphkKzk1KQalj/Dx42ZAMF+XPLyM3tddcA7YglYFY=;
 b=mxLcyoqcQz595UMjCCWVMP/2wwHvYXfmBHmQ7N8qQw9vo7b4+muhy6NuK+QYOubxFngttW
 7xGcxlKmDviOkmyE/YrPPDWBbKlpenY/NPauQqyp9LBYcdiTjhBX6QNbXOnqC+cccB68Ot5w
 Fz0y2ATunn4okEapkgo+ZO64TmJlCMx4ojp3Wr2xwuRniSKSYc58osRmbVM6e2VWeQXMHg3Z
 2waAXH8RafM6PdUJ9P91hvkgNRCgj7c/+pxpI2CBXZnor5CRzPmPSa/oeLN676S4gHBbsA+0
 pe6ioi27ozK4OUjyGLIlazy7NYCll6I5qdRYGF7x7FLGa//q1UtMKhcw==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [meta-virtualization][scarthgap][PATCH] crun: patch CVE-2026-88264
Date: Mon, 28 Sep 2026 23:09:50 +0200
Message-ID: <20260928210952.679090-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 28 Sep 2026 21:10:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4963

From: Peter Marko <peter.marko@siemens.com>

Pick patch referencing this CVE.
Additioanlly pick a refactoring patch to apply it cleanly.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 .../crun/crun/CVE-2026-88264-01.patch         | 124 ++++++++++++++++++
 .../crun/crun/CVE-2026-88264-02.patch         | 104 +++++++++++++++
 recipes-containers/crun/crun_git.bb           |   2 +
 3 files changed, 230 insertions(+)
 create mode 100644 recipes-containers/crun/crun/CVE-2026-88264-01.patch
 create mode 100644 recipes-containers/crun/crun/CVE-2026-88264-02.patch

diff --git a/recipes-containers/crun/crun/CVE-2026-88264-01.patch b/recipes-containers/crun/crun/CVE-2026-88264-01.patch
new file mode 100644
index 00000000..39a69166
--- /dev/null
+++ b/recipes-containers/crun/crun/CVE-2026-88264-01.patch
@@ -0,0 +1,124 @@
+From 490d550204f22765d04dd012f51f1bf74b8c4543 Mon Sep 17 00:00:00 2001
+From: =?UTF-8?q?Erik=20Sj=C3=B6lund?= <erik.sjolund@gmail.com>
+Date: Wed, 29 Jan 2025 18:42:02 +0100
+Subject: [PATCH] linux, utils: remove dead code crun_ensure_file*()
+MIME-Version: 1.0
+Content-Type: text/plain; charset=UTF-8
+Content-Transfer-Encoding: 8bit
+
+Remove dead code.
+
+Use 0620 instead of 0700 as mode
+for the new file.
+
+Signed-off-by: Erik Sjölund <erik.sjolund@gmail.com>
+
+CVE: CVE-2026-88264
+Upstream-Status: Backport [https://github.com/containers/crun/commit/490d550204f22765d04dd012f51f1bf74b8c4543]
+Signed-off-by: Peter Marko <peter.marko@siemens.com>
+---
+ src/libcrun/linux.c |  2 +-
+ src/libcrun/utils.c | 37 +++++--------------------------------
+ src/libcrun/utils.h |  6 +-----
+ 3 files changed, 7 insertions(+), 38 deletions(-)
+
+diff --git a/src/libcrun/linux.c b/src/libcrun/linux.c
+index acfb5b0b..6ecbaaac 100644
+--- a/src/libcrun/linux.c
++++ b/src/libcrun/linux.c
+@@ -1836,7 +1836,7 @@ create_missing_devs (libcrun_container_t *container, bool binds, libcrun_error_t
+ 
+   if (container->container_def->process && container->container_def->process->terminal)
+     {
+-      ret = crun_ensure_file_at (devfd, "console", 0620, true, err);
++      ret = create_file_if_missing_at (devfd, "console", 0620, err);
+       if (UNLIKELY (ret < 0))
+         return ret;
+     }
+diff --git a/src/libcrun/utils.c b/src/libcrun/utils.c
+index fd40110a..38d86c82 100644
+--- a/src/libcrun/utils.c
++++ b/src/libcrun/utils.c
+@@ -242,17 +242,17 @@ get_file_type (mode_t *mode, bool nofollow, const char *path)
+ }
+ 
+ int
+-create_file_if_missing_at (int dirfd, const char *file, libcrun_error_t *err)
++create_file_if_missing_at (int dirfd, const char *file, mode_t mode, libcrun_error_t *err)
+ {
+-  cleanup_close int fd_write = openat (dirfd, file, O_CLOEXEC | O_CREAT | O_WRONLY, 0700);
++  cleanup_close int fd_write = openat (dirfd, file, O_CLOEXEC | O_CREAT | O_WRONLY, mode);
+   if (fd_write < 0)
+     {
+-      mode_t mode;
++      mode_t tmp_mode;
+       int ret;
+ 
+       /* On errors, check if the file already exists.  */
+-      ret = get_file_type_at (dirfd, &mode, false, file);
+-      if (ret == 0 && S_ISREG (mode))
++      ret = get_file_type_at (dirfd, &tmp_mode, false, file);
++      if (ret == 0 && S_ISREG (tmp_mode))
+         return 0;
+ 
+       return crun_make_error (err, errno, "creating file `%s`", file);
+@@ -635,33 +635,6 @@ crun_ensure_directory (const char *path, int mode, bool nofollow, libcrun_error_
+   return crun_ensure_directory_at (AT_FDCWD, path, mode, nofollow, err);
+ }
+ 
+-int
+-crun_ensure_file_at (int dirfd, const char *path, int mode, bool nofollow, libcrun_error_t *err)
+-{
+-  cleanup_free char *tmp = xstrdup (path);
+-  size_t len = strlen (tmp);
+-  char *it = tmp + len - 1;
+-  int ret;
+-
+-  while (*it != '/' && it > tmp)
+-    it--;
+-  if (it > tmp)
+-    {
+-      *it = '\0';
+-      ret = crun_ensure_directory_at (dirfd, tmp, mode, nofollow, err);
+-      if (UNLIKELY (ret < 0))
+-        return ret;
+-      *it = '/';
+-    }
+-  return create_file_if_missing_at (dirfd, tmp, err);
+-}
+-
+-int
+-crun_ensure_file (const char *path, int mode, bool nofollow, libcrun_error_t *err)
+-{
+-  return crun_ensure_file_at (AT_FDCWD, path, mode, nofollow, err);
+-}
+-
+ static int
+ get_file_size (int fd, off_t *size)
+ {
+diff --git a/src/libcrun/utils.h b/src/libcrun/utils.h
+index ed83344e..0025648f 100644
+--- a/src/libcrun/utils.h
++++ b/src/libcrun/utils.h
+@@ -265,12 +265,8 @@ int write_file_at_with_flags (int dirfd, int flags, mode_t mode, const char *nam
+ 
+ int crun_ensure_directory (const char *path, int mode, bool nofollow, libcrun_error_t *err);
+ 
+-int crun_ensure_file (const char *path, int mode, bool nofollow, libcrun_error_t *err);
+-
+ int crun_ensure_directory_at (int dirfd, const char *path, int mode, bool nofollow, libcrun_error_t *err);
+ 
+-int crun_ensure_file_at (int dirfd, const char *path, int mode, bool nofollow, libcrun_error_t *err);
+-
+ int crun_safe_create_and_open_ref_at (bool dir, int dirfd, const char *dirpath, size_t dirpath_len, const char *path, int mode, libcrun_error_t *err);
+ 
+ int crun_safe_ensure_directory_at (int dirfd, const char *dirpath, size_t dirpath_len, const char *path, int mode,
+@@ -285,7 +281,7 @@ int crun_dir_p_at (int dirfd, const char *path, bool nofollow, libcrun_error_t *
+ 
+ int detach_process ();
+ 
+-int create_file_if_missing_at (int dirfd, const char *file, libcrun_error_t *err);
++int create_file_if_missing_at (int dirfd, const char *file, mode_t mode, libcrun_error_t *err);
+ 
+ int check_running_in_user_namespace (libcrun_error_t *err);
+ 
diff --git a/recipes-containers/crun/crun/CVE-2026-88264-02.patch b/recipes-containers/crun/crun/CVE-2026-88264-02.patch
new file mode 100644
index 00000000..88c89b8b
--- /dev/null
+++ b/recipes-containers/crun/crun/CVE-2026-88264-02.patch
@@ -0,0 +1,104 @@
+From ef32479522af883568ce4a5482358069ff71dc8f Mon Sep 17 00:00:00 2001
+From: Giuseppe Scrivano <gscrivan@redhat.com>
+Date: Fri, 11 Sep 2026 09:25:48 +0000
+Subject: [PATCH] utils: do not follow symlinks when creating /dev/console
+
+create_file_if_missing_at() is only used to create `/dev/console` in the
+container rootfs when a terminal is requested, and it opened the file
+with O_CREAT but without O_NOFOLLOW.  A rootfs providing `/dev/console`
+as a symlink made the open follow it, and since the devices are created
+before the pivot_root the target was resolved against the host file
+system, so crun created a root owned file at a path chosen by the
+container image.
+
+Open the file with O_NOFOLLOW, and check for an already existing file
+without following symlinks either, so that a symlink is not mistaken for
+a regular file that is already there.
+
+This is only reachable when nothing is mounted over /dev, so the rootfs
+entry stays visible; the configurations generated by Docker, Podman,
+containerd, CRI-O and `crun spec` mount a tmpfs there.
+
+Add a test case.
+
+Fixes: CVE-2026-88264
+Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
+
+CVE: CVE-2026-88264
+Upstream-Status: Backport [https://github.com/containers/crun/commit/ef32479522af883568ce4a5482358069ff71dc8f]
+Signed-off-by: Peter Marko <peter.marko@siemens.com>
+---
+ src/libcrun/utils.c   |  4 ++--
+ tests/test_devices.py | 36 ++++++++++++++++++++++++++++++++++++
+ 2 files changed, 38 insertions(+), 2 deletions(-)
+
+diff --git a/src/libcrun/utils.c b/src/libcrun/utils.c
+index ce44c261..76175411 100644
+--- a/src/libcrun/utils.c
++++ b/src/libcrun/utils.c
+@@ -244,14 +244,14 @@ get_file_type (mode_t *mode, bool nofollow, const char *path)
+ int
+ create_file_if_missing_at (int dirfd, const char *file, mode_t mode, libcrun_error_t *err)
+ {
+-  cleanup_close int fd_write = openat (dirfd, file, O_CLOEXEC | O_CREAT | O_WRONLY, mode);
++  cleanup_close int fd_write = openat (dirfd, file, O_CLOEXEC | O_CREAT | O_WRONLY | O_NOFOLLOW, mode);
+   if (fd_write < 0)
+     {
+       mode_t tmp_mode;
+       int ret;
+ 
+       /* On errors, check if the file already exists.  */
+-      ret = get_file_type_at (dirfd, &tmp_mode, false, file);
++      ret = get_file_type_at (dirfd, &tmp_mode, true, file);
+       if (ret == 0 && S_ISREG (tmp_mode))
+         return 0;
+ 
+diff --git a/tests/test_devices.py b/tests/test_devices.py
+index 6956e2bd..a99753a3 100755
+--- a/tests/test_devices.py
++++ b/tests/test_devices.py
+@@ -214,8 +214,44 @@ def test_mknod_device():
+         return -1
+     return 0
+ 
++def test_dev_console_symlink_does_not_escape_rootfs():
++    escaped = os.path.join(get_tests_root(), "escaped-console")
++
++    conf = base_config()
++    add_all_namespaces(conf)
++    conf['process']['terminal'] = True
++    conf['process']['args'] = ['/init', 'true']
++    conf['mounts'] = [i for i in conf['mounts'] if not i['destination'].startswith("/dev")]
++    # a hook forces the deferred pivot_root, so the rootfs is still reached
++    # through the host file system when the devices are created.
++    conf['hooks'] = {"createRuntime": [{"path": "/bin/true"}]}
++
++    def prepare_rootfs(rootfs):
++        os.symlink(escaped, os.path.join(rootfs, "dev", "console"))
++
++    output = None
++    try:
++        run_and_get_output(conf, callback_prepare_rootfs=prepare_rootfs)
++    except Exception as e:
++        output = e.output.decode()
++
++    if os.path.lexists(escaped):
++        logger.error("`%s` was created outside the rootfs", escaped)
++        return -1
++
++    if output is None:
++        logger.error("the container was not refused")
++        return -1
++
++    if "create file `console`" not in output:
++        logger.error("the container failed for a different reason: %s", output)
++        return -1
++
++    return 0
++
+ 
+ all_tests = {
++    "dev-console-symlink-does-not-escape-rootfs": test_dev_console_symlink_does_not_escape_rootfs,
+     "owner-device" : test_owner_device,
+     "deny-devices" : test_deny_devices,
+     "allow-device" : test_allow_device,
diff --git a/recipes-containers/crun/crun_git.bb b/recipes-containers/crun/crun_git.bb
index 8d72e5f6..0bcc51aa 100644
--- a/recipes-containers/crun/crun_git.bb
+++ b/recipes-containers/crun/crun_git.bb
@@ -16,6 +16,8 @@ SRC_URI = "git://github.com/containers/crun.git;branch=main;name=crun;protocol=h
            git://github.com/opencontainers/image-spec.git;branch=main;name=ispec;destsuffix=git/libocispec/image-spec;protocol=https \
            git://github.com/containers/yajl.git;branch=main;name=yajl;destsuffix=git/libocispec/yajl;protocol=https \
            file://CVE-2025-24965.patch \
+           file://CVE-2026-88264-01.patch \
+           file://CVE-2026-88264-02.patch \
           "
 
 PV = "v1.14.3+git${SRCREV_crun}"

