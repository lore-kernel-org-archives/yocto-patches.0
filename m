Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE005D6AB19
	for <webhook@archiver.kernel.org>; Fri,  3 Apr 2026 18:37:06 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2225.1775241422655042257
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 03 Apr 2026 11:37:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Rz6oxtYN;
 spf=pass (domain: gmail.com, ip: 209.85.222.178, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cfc085395fso194858485a.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 11:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775241421; x=1775846221; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Zu3hTZCarzyag0CM/ZvohYsdYYjcb+jdjJM64+Y/rU=;
        b=Rz6oxtYNg1Yi3kvGn+zk0dLwoqMOi5Rtf5sTxVR98DWRf7fV4Sed+iiYoULVPlrt7e
         +3ZSdKb8IZcOLnRtg+cGxP2V/tpA2ahbSIwUpzwiw3zngcHqcGl7jvgs1a7vlgZpv5k9
         tDR67xGJZhyWteLo2eLRnQnwqwgMf8LEZiGmW2903HaCwTYUYSGumcga3keCfK004+zR
         f02IM8m1LI3DdQkRfw7Ve+7qF0V8e76WOomjqgxuDF7nBjp3xC2hVledtowHaaJ+wAon
         E5bHY16W8+gybHvWWlNsl+qIYxO+0lfbwA3Lx2+HXaLRDGy1VPu1tMCnox9Y7emzA/W3
         5kAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775241421; x=1775846221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Zu3hTZCarzyag0CM/ZvohYsdYYjcb+jdjJM64+Y/rU=;
        b=bBMu0hZ77SoIBpG7m8F1ii7R64ajJlqUeTQDeGaS81jwi/tiZ1sULKxsxQe14JUeMG
         /U1AWJuMKeR9zqqSa2GmGXsdlLGQDQtssX7FIYOcJNeEmyZuX2jepjc6jA4U7POuJqK2
         d4iSSBkWoxHqs3neJMR20pMcurARLbLX/4+EH9jogVwgtvc8KEbVBgmk8pRp5ieox50V
         gzsj+ITSKbmR5T6jXtCdW0SJPvQ3jifUl7WpcUSGAhcsXsSa6AnGnt97lZnfr3vPdsfr
         wc/SbhxhNpz1LRTPfC1aOBsYjgFeYPZuNyQ124KYdOE3BMtdfuib4x0cHcFXB8jKkItt
         iSQg==
X-Gm-Message-State: AOJu0YxWrcA0reSm6CsezTkopIXaPhez5ELgHMJFwFVSCY7YCmN2atrH
	mh7J2chsH3XsyWSXBONqSUu42tBonkyuEyKKTp9k/aaSRxkN+0Zha1NEgjqKmgQo
X-Gm-Gg: ATEYQzx8VYZXUj24rP0Us+L7+i5N9Ll7hhf/N8uPEHYbFiC4Ch2MQis8K4ccgEV8wYa
	LPSd9cR97wN1oLRsbG1mv1TnNJnCXW6wIfZTWtfrBCDOC3jFyGdwcRBANW5XyuQwJ4vbu6La/mT
	uJvYp33YJTHCLGbCjE8WC/r7UxFi/pzSfFo0/ToONJuGGN1uBSlI1F1DZRiteTL/I9cdTX2uLLe
	bv7rOVas/C4GtY0cq1kcLqGufQrBSpzPEMEI0WZ2lRkG2JLFOiARqmpVYLMlosavdwgWK+Yb0Ld
	GtZ+PP4OeQL1vOSw84VSw0v1ZYMsPMhyMZvZBxpHbJYYoCy4jPcZtcsrNOoyVUXI9cbE35QTOnt
	NDR0ZwN8zavTp0i7r1m9sAbsA0QsNCnJyDtbUU2R1S4A1fd8eHkWR8W7HgDnEMoCGVtYl2detXC
	rjkE5c2v+1boN2BvUtkV1AHpTKYzTEwgOLy6JIoW72V64D3yAy5V/0itjN04qk+BKvYA==
X-Received: by 2002:a05:620a:294d:b0:8cf:de1c:edd6 with SMTP id af79cd13be357-8d419c563c4mr613542785a.28.1775241420770;
        Fri, 03 Apr 2026 11:37:00 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a874459asm472401785a.39.2026.04.03.11.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 11:37:00 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Bruce Ashfield <bruce.ashfield@gmail.com>,
	Mark Hatle <mark.hatle@kernel.crashing.org>
Subject: [wic][PATCH 4/9] add oe-core and bitbake helper packages
Date: Fri,  3 Apr 2026 14:36:39 -0400
Message-ID: <20260403183644.2783267-5-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260403183644.2783267-1-twoerner@gmail.com>
References: <20260403183644.2783267-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 18:37:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3630

When it was part of oe-core, wic used a couple packages from bitbake and
oe-core. Import those packages, with minor tweaks, so that the
independent wic will be able to function.

NOTE: this commit does not work as-is, but is being provided in order to
      explicitly show a clean transition from oe-core

Reviewed-by: Bruce Ashfield <bruce.ashfield@gmail.com>
Reviewed-by: Mark Hatle <mark.hatle@kernel.crashing.org>
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 pyproject.toml      |   4 +-
 src/bb/__init__.py  |  14 ++
 src/bb/utils.py     |  23 +++
 src/oe/__init__.py  |   1 +
 src/oe/bootfiles.py |  58 ++++++++
 src/oe/path.py      | 351 ++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 449 insertions(+), 2 deletions(-)
 create mode 100644 src/bb/__init__.py
 create mode 100644 src/bb/utils.py
 create mode 100644 src/oe/__init__.py
 create mode 100644 src/oe/bootfiles.py
 create mode 100644 src/oe/path.py

diff --git a/pyproject.toml b/pyproject.toml
index fdc1ce0f5ece..6ef29462f3f5 100644
--- a/pyproject.toml
+++ b/pyproject.toml
@@ -25,10 +25,10 @@ Repository = "https://git.yoctoproject.org/wic"
 wic = "wic.cli:main"
 
 [tool.hatch.build]
-packages = ["src/wic"]
+packages = ["src/wic", "src/oe", "src/bb"]
 
 [tool.hatch.build.targets.wheel]
-packages = ["src/wic"]
+packages = ["src/wic", "src/oe", "src/bb"]
 
 [build-system]
 requires = ["hatchling>=1.21"]
diff --git a/src/bb/__init__.py b/src/bb/__init__.py
new file mode 100644
index 000000000000..d83315486080
--- /dev/null
+++ b/src/bb/__init__.py
@@ -0,0 +1,14 @@
+"""
+Minimal stub of BitBake's bb module for standalone wic.
+Provides debug logging used by vendored oe helpers.
+"""
+import logging
+
+def debug(level, msg):
+    """
+    Mirror bb.debug signature but route to standard logging.
+    """
+    logging.getLogger("bb").debug(msg)
+
+# Expose utils so callers can access bb.utils.mkdirhier
+from . import utils
diff --git a/src/bb/utils.py b/src/bb/utils.py
new file mode 100644
index 000000000000..3750056ba563
--- /dev/null
+++ b/src/bb/utils.py
@@ -0,0 +1,23 @@
+"""
+Minimal subset of BitBake's bb.utils used by standalone wic.
+"""
+import os
+
+# from bitbake/lib/bb/utils.py
+def mkdirhier(directory):
+    """Create a directory like 'mkdir -p', but does not complain if
+    directory already exists list ``os.makedirs()``.
+
+    Arguments:
+
+    - ``directory``: path to the directory.
+
+    No return value.
+    """
+    if '${' in str(directory):
+        raise Exception("Directory name {} contains unexpanded bitbake variable. This may cause build failures and WORKDIR polution.".format(directory))
+    try:
+        os.makedirs(directory, exist_ok=True)
+    except OSError as e:
+        if e.errno != errno.EEXIST or not os.path.isdir(directory):
+            raise e
diff --git a/src/oe/__init__.py b/src/oe/__init__.py
new file mode 100644
index 000000000000..abefaa7a8f58
--- /dev/null
+++ b/src/oe/__init__.py
@@ -0,0 +1 @@
+# Minimal vendored OpenEmbedded helpers used by wic.
diff --git a/src/oe/bootfiles.py b/src/oe/bootfiles.py
new file mode 100644
index 000000000000..b67bb0fe9814
--- /dev/null
+++ b/src/oe/bootfiles.py
@@ -0,0 +1,58 @@
+#
+# SPDX-License-Identifier: MIT
+#
+# Copyright (C) 2024 Marcus Folkesson
+# Author: Marcus Folkesson <marcus.folkesson@gmail.com>
+#
+# Utility functions handling boot files
+#
+# Look into deploy_dir and search for boot_files.
+# Returns a list of tuples with (original filepath relative to
+# deploy_dir, desired filepath renaming)
+#
+# Heavily inspired of bootimg_partition.py
+#
+# from oe-core/meta/lib/oe/bootfiles.py
+def get_boot_files(deploy_dir, boot_files):
+    import re
+    import os
+    from glob import glob
+
+    if boot_files is None:
+        return None
+
+    # list of tuples (src_name, dst_name)
+    deploy_files = []
+    for src_entry in re.findall(r'[\w;\-\./\*]+', boot_files):
+        if ';' in src_entry:
+            dst_entry = tuple(src_entry.split(';'))
+            if not dst_entry[0] or not dst_entry[1]:
+                raise ValueError('Malformed boot file entry: %s' % src_entry)
+        else:
+            dst_entry = (src_entry, src_entry)
+
+        deploy_files.append(dst_entry)
+
+    install_files = []
+    for deploy_entry in deploy_files:
+        src, dst = deploy_entry
+        if '*' in src:
+            # by default install files under their basename
+            entry_name_fn = os.path.basename
+            if dst != src:
+                # unless a target name was given, then treat name
+                # as a directory and append a basename
+                entry_name_fn = lambda name: \
+                                os.path.join(dst,
+                                             os.path.basename(name))
+
+            srcs = glob(os.path.join(deploy_dir, src))
+
+            for entry in srcs:
+                src = os.path.relpath(entry, deploy_dir)
+                entry_dst_name = entry_name_fn(entry)
+                install_files.append((src, entry_dst_name))
+        else:
+            install_files.append((src, dst))
+
+    return install_files
diff --git a/src/oe/path.py b/src/oe/path.py
new file mode 100644
index 000000000000..47b0c1347b61
--- /dev/null
+++ b/src/oe/path.py
@@ -0,0 +1,351 @@
+#
+# Copyright OpenEmbedded Contributors
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+import errno
+import glob
+import shutil
+import subprocess
+import os.path
+
+import bb
+
+def join(*paths):
+    """Like os.path.join but doesn't treat absolute RHS specially"""
+    return os.path.normpath("/".join(paths))
+
+def relative(src, dest):
+    """ Return a relative path from src to dest.
+
+    >>> relative("/usr/bin", "/tmp/foo/bar")
+    ../../tmp/foo/bar
+
+    >>> relative("/usr/bin", "/usr/lib")
+    ../lib
+
+    >>> relative("/tmp", "/tmp/foo/bar")
+    foo/bar
+    """
+
+    return os.path.relpath(dest, src)
+
+def make_relative_symlink(path):
+    """ Convert an absolute symlink to a relative one """
+    if not os.path.islink(path):
+        return
+    link = os.readlink(path)
+    if not os.path.isabs(link):
+        return
+
+    # find the common ancestor directory
+    ancestor = path
+    depth = 0
+    while ancestor and not link.startswith(ancestor):
+        ancestor = ancestor.rpartition('/')[0]
+        depth += 1
+
+    if not ancestor:
+        print("make_relative_symlink() Error: unable to find the common ancestor of %s and its target" % path)
+        return
+
+    base = link.partition(ancestor)[2].strip('/')
+    while depth > 1:
+        base = "../" + base
+        depth -= 1
+
+    os.remove(path)
+    os.symlink(base, path)
+
+def replace_absolute_symlinks(basedir, d):
+    """
+    Walk basedir looking for absolute symlinks and replacing them with relative ones.
+    The absolute links are assumed to be relative to basedir
+    (compared to make_relative_symlink above which tries to compute common ancestors
+    using pattern matching instead)
+    """
+    for walkroot, dirs, files in os.walk(basedir):
+        for file in files + dirs:
+            path = os.path.join(walkroot, file)
+            if not os.path.islink(path):
+                continue
+            link = os.readlink(path)
+            if not os.path.isabs(link):
+                continue
+            walkdir = os.path.dirname(path.rpartition(basedir)[2])
+            base = os.path.relpath(link, walkdir)
+            bb.debug(2, "Replacing absolute path %s with relative path %s" % (link, base))
+            os.remove(path)
+            os.symlink(base, path)
+
+def format_display(path, metadata):
+    """ Prepare a path for display to the user. """
+    rel = relative(metadata.getVar("TOPDIR"), path)
+    if len(rel) > len(path):
+        return path
+    else:
+        return rel
+
+def copytree(src, dst):
+    # We could use something like shutil.copytree here but it turns out to
+    # to be slow. It takes twice as long copying to an empty directory.
+    # If dst already has contents performance can be 15 time slower
+    # This way we also preserve hardlinks between files in the tree.
+
+    bb.utils.mkdirhier(dst)
+    cmd = "tar --xattrs --xattrs-include='*' -cf - -S -C %s -p . | tar --xattrs --xattrs-include='*' -xf - -C %s" % (src, dst)
+    subprocess.check_output(cmd, shell=True, stderr=subprocess.STDOUT)
+
+def copyhardlinktree(src, dst):
+    """Make a tree of hard links when possible, otherwise copy."""
+    bb.utils.mkdirhier(dst)
+    if os.path.isdir(src) and not len(os.listdir(src)):
+        return
+
+    canhard = False
+    testfile = None
+    for root, dirs, files in os.walk(src):
+        if len(files):
+            testfile = os.path.join(root, files[0])
+            break
+
+    if testfile is not None:
+        try:
+            os.link(testfile, os.path.join(dst, 'testfile'))
+            os.unlink(os.path.join(dst, 'testfile'))
+            canhard = True
+        except Exception as e:
+            bb.debug(2, "Hardlink test failed with " + str(e))
+
+    if (canhard):
+        # Need to copy directories only with tar first since cp will error if two
+        # writers try and create a directory at the same time
+        cmd = "cd %s; find . -type d -print | tar --xattrs --xattrs-include='*' -cf - -S -C %s -p --no-recursion --files-from - | tar --xattrs --xattrs-include='*' -xhf - -C %s" % (src, src, dst)
+        subprocess.check_output(cmd, shell=True, stderr=subprocess.STDOUT)
+        source = ''
+        if os.path.isdir(src):
+            if len(glob.glob('%s/.??*' % src)) > 0:
+                source = './.??* '
+            if len(glob.glob('%s/**' % src)) > 0:
+                source += './*'
+            s_dir = src
+        else:
+            source = src
+            s_dir = os.getcwd()
+        cmd = 'cp -afl --preserve=xattr %s %s' % (source, os.path.realpath(dst))
+        subprocess.check_output(cmd, shell=True, cwd=s_dir, stderr=subprocess.STDOUT)
+    else:
+        copytree(src, dst)
+
+def copyhardlink(src, dst):
+    """Make a hard link when possible, otherwise copy."""
+
+    try:
+        os.link(src, dst)
+    except OSError:
+        shutil.copy(src, dst)
+
+def remove(path, recurse=True):
+    """
+    Equivalent to rm -f or rm -rf
+    NOTE: be careful about passing paths that may contain filenames with
+    wildcards in them (as opposed to passing an actual wildcarded path) -
+    since we use glob.glob() to expand the path. Filenames containing
+    square brackets are particularly problematic since the they may not
+    actually expand to match the original filename.
+    """
+    for name in glob.glob(path):
+        try:
+            os.unlink(name)
+        except OSError as exc:
+            if recurse and exc.errno == errno.EISDIR:
+                shutil.rmtree(name)
+            elif exc.errno != errno.ENOENT:
+                raise
+
+def symlink(source, destination, force=False):
+    """Create a symbolic link"""
+    try:
+        if force:
+            remove(destination)
+        os.symlink(source, destination)
+    except OSError as e:
+        if e.errno != errno.EEXIST or os.readlink(destination) != source:
+            raise
+
+def relsymlink(target, name, force=False):
+    symlink(os.path.relpath(target, os.path.dirname(name)), name, force=force)
+
+def find(dir, **walkoptions):
+    """ Given a directory, recurses into that directory,
+    returning all files as absolute paths. """
+
+    for root, dirs, files in os.walk(dir, **walkoptions):
+        for file in files:
+            yield os.path.join(root, file)
+
+
+## realpath() related functions
+def __is_path_below(file, root):
+    return (file + os.path.sep).startswith(root)
+
+def __realpath_rel(start, rel_path, root, loop_cnt, assume_dir):
+    """Calculates real path of symlink 'start' + 'rel_path' below
+    'root'; no part of 'start' below 'root' must contain symlinks. """
+    have_dir = True
+
+    for d in rel_path.split(os.path.sep):
+        if not have_dir and not assume_dir:
+            raise OSError(errno.ENOENT, "no such directory %s" % start)
+
+        if d == os.path.pardir: # '..'
+            if len(start) >= len(root):
+                # do not follow '..' before root
+                start = os.path.dirname(start)
+            else:
+                # emit warning?
+                pass
+        else:
+            (start, have_dir) = __realpath(os.path.join(start, d),
+                                           root, loop_cnt, assume_dir)
+
+        assert(__is_path_below(start, root))
+
+    return start
+
+def __realpath(file, root, loop_cnt, assume_dir):
+    while os.path.islink(file) and len(file) >= len(root):
+        if loop_cnt == 0:
+            raise OSError(errno.ELOOP, file)
+
+        loop_cnt -= 1
+        target = os.path.normpath(os.readlink(file))
+
+        if not os.path.isabs(target):
+            tdir = os.path.dirname(file)
+            assert(__is_path_below(tdir, root))
+        else:
+            tdir = root
+
+        file = __realpath_rel(tdir, target, root, loop_cnt, assume_dir)
+
+    try:
+        is_dir = os.path.isdir(file)
+    except:
+        is_dir = false
+
+    return (file, is_dir)
+
+def realpath(file, root, use_physdir = True, loop_cnt = 100, assume_dir = False):
+    """ Returns the canonical path of 'file' with assuming a
+    toplevel 'root' directory. When 'use_physdir' is set, all
+    preceding path components of 'file' will be resolved first;
+    this flag should be set unless it is guaranteed that there is
+    no symlink in the path. When 'assume_dir' is not set, missing
+    path components will raise an ENOENT error"""
+
+    root = os.path.normpath(root)
+    file = os.path.normpath(file)
+
+    if not root.endswith(os.path.sep):
+        # letting root end with '/' makes some things easier
+        root = root + os.path.sep
+
+    if not __is_path_below(file, root):
+        raise OSError(errno.EINVAL, "file '%s' is not below root" % file)
+
+    try:
+        if use_physdir:
+            file = __realpath_rel(root, file[(len(root) - 1):], root, loop_cnt, assume_dir)
+        else:
+            file = __realpath(file, root, loop_cnt, assume_dir)[0]
+    except OSError as e:
+        if e.errno == errno.ELOOP:
+            # make ELOOP more readable; without catching it, there will
+            # be printed a backtrace with 100s of OSError exceptions
+            # else
+            raise OSError(errno.ELOOP,
+                          "too much recursions while resolving '%s'; loop in '%s'" %
+                          (file, e.strerror))
+
+        raise
+
+    return file
+
+def is_path_parent(possible_parent, *paths):
+    """
+    Return True if a path is the parent of another, False otherwise.
+    Multiple paths to test can be specified in which case all
+    specified test paths must be under the parent in order to
+    return True.
+    """
+    def abs_path_trailing(pth):
+        pth_abs = os.path.abspath(pth)
+        if not pth_abs.endswith(os.sep):
+            pth_abs += os.sep
+        return pth_abs
+
+    possible_parent_abs = abs_path_trailing(possible_parent)
+    if not paths:
+        return False
+    for path in paths:
+        path_abs = abs_path_trailing(path)
+        if not path_abs.startswith(possible_parent_abs):
+            return False
+    return True
+
+def which_wild(pathname, path=None, mode=os.F_OK, *, reverse=False, candidates=False):
+    """Search a search path for pathname, supporting wildcards.
+
+    Return all paths in the specific search path matching the wildcard pattern
+    in pathname, returning only the first encountered for each file. If
+    candidates is True, information on all potential candidate paths are
+    included.
+    """
+    paths = (path or os.environ.get('PATH', os.defpath)).split(':')
+    if reverse:
+        paths.reverse()
+
+    seen, files = set(), []
+    for index, element in enumerate(paths):
+        if not os.path.isabs(element):
+            element = os.path.abspath(element)
+
+        candidate = os.path.join(element, pathname)
+        globbed = glob.glob(candidate)
+        if globbed:
+            for found_path in sorted(globbed):
+                if not os.access(found_path, mode):
+                    continue
+                rel = os.path.relpath(found_path, element)
+                if rel not in seen:
+                    seen.add(rel)
+                    if candidates:
+                        files.append((found_path, [os.path.join(p, rel) for p in paths[:index+1]]))
+                    else:
+                        files.append(found_path)
+
+    return files
+
+def canonicalize(paths, sep=','):
+    """Given a string with paths (separated by commas by default), expand
+    each path using os.path.realpath() and return the resulting paths as a
+    string (separated using the same separator a the original string).
+    """
+    # Ignore paths containing "$" as they are assumed to be unexpanded bitbake
+    # variables. Normally they would be ignored, e.g., when passing the paths
+    # through the shell they would expand to empty strings. However, when they
+    # are passed through os.path.realpath(), it will cause them to be prefixed
+    # with the absolute path to the current directory and thus not be empty
+    # anymore.
+    #
+    # Also maintain trailing slashes, as the paths may actually be used as
+    # prefixes in sting compares later on, where the slashes then are important.
+    canonical_paths = []
+    for path in (paths or '').split(sep):
+        if '$' not in path:
+            trailing_slash = path.endswith('/') and '/' or ''
+            canonical_paths.append(os.path.realpath(path) + trailing_slash)
+
+    return sep.join(canonical_paths)
-- 
2.51.0


