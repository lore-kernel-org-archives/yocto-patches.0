Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EF5C3ABAC
	for <webhook@archiver.kernel.org>; Sun,  4 May 2025 12:59:58 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
 by mx.groups.io with SMTP id smtpd.web10.28070.1746363594436380127
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 04 May 2025 05:59:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Az77D2El;
 spf=pass (domain: gmail.com, ip: 209.85.208.49, mailfrom: skandigraun@gmail.com)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5fafcdac19aso300232a12.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 04 May 2025 05:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746363593; x=1746968393; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=J4Sl69SrtdGXW5EzlE5l+G0aJqndxv2fc7U0I2yS6M0=;
        b=Az77D2ElSlrOwOyGwf9FphJw5sr5GOGesCo+EYcjoPa1mp+8oCabaWw/m6qyFumER8
         OaNNc9Xcd1i8ZVRspGxlXq+1hxdx1itDAi716wD907wLVG2xpHEJ87KAM7fNhyOs6n8a
         UsgahqNS8Ilh/tWVqY86pECdFoM9WpPA/VrZtr1tgpsSCQo8M6OthhMsqzcL9xqC/EHl
         jZNG3slVDrrF1GdurW2fgzSsR+w43+QkPns9kouW+tWwaOUP1ahZ1pLCk8ubdH1jOcQa
         YTpdFdKUjmkBpqvOAF3Cwi5MhbqjoUbYkXXvp5ViVfO1i6PZ4Heexh36wZWX1Q0URW6E
         i3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746363593; x=1746968393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J4Sl69SrtdGXW5EzlE5l+G0aJqndxv2fc7U0I2yS6M0=;
        b=VPd2+6XJ4H35EnEn7DoWQ+e76t3SLbRkCNoelvPbjafiyAtfmEnGEb9BbHx0GhtpTs
         arZctocja2gLr6ZnpQNn6pvLHweMX8YmZ6EiykOPohtT3clI7RATJVAxOx9Vm9YfeaRD
         y1ToA2jnONuwD/7sdLlL+yjM2p47Eev3uoLDaj7uMv69KEfIDaoCc7dKyk2fLFSl0t6L
         hI4A6w8u5m3spnNaxAlwmawWO2IwzSV9S5+M5YWPVfWRoMBTEp45dRFUPo+ovG7Ok/Gw
         KDQDa4nDlLz8mMnPMSK5TRawtgbuLRbDOITKroAMG++NNWMs+af3nBcLyGZkPcR1JlyP
         Prtg==
X-Gm-Message-State: AOJu0Yz8fZW5PBDubCpLmhICDLwAjR0vdTJrqWIeduC5rYnxHEYRVu9R
	eu/njrvZQT02PNC8aPWJKFH6Buq7Aq79HDviIALaNNoumbfkZChLpnqjSQ==
X-Gm-Gg: ASbGncuuS859tj0sYad0aUwciWDLVV6HYh3BC9sdCGEJHJV1aVM3HIQAdoeH4EGa8Dy
	hi71dGTu1db2x7dvdg7S5BnQWwGdJ5wl0B/RBbStlrjt8VfdfIGo+DXVe0SAlJYp0Yelv62vuI+
	cbHUq6QYa9KCJdAfmOfMoYOu7FMdaIJkKal9m6eYhhJh96zoY8tM3FXNh/OvkWKm7Zdi7npcJam
	ycq6MoCctFwrHajoue9GTS3CeqpLsBhMVcnECp0DA/ALf8zDCXRicCxqMqiiLRfZg8H9SJ4rBRH
	dE2maibbueL1HL8ftnfvju1mYpz9EL0tKDwAWlzbEF+P+SmCXbvFh2NN2iiKR9DXEC8=
X-Google-Smtp-Source: AGHT+IG92q0yT9ZkY1l76gxL7IP6JkQSqzX6EzfivmRm/HLUot1MRssG3VDq+gwx65LZ0ammGHqdJQ==
X-Received: by 2002:a17:907:2d07:b0:acb:5f9a:7303 with SMTP id a640c23a62f3a-ad1a4a0a0d5mr313546766b.35.1746363592335;
        Sun, 04 May 2025 05:59:52 -0700 (PDT)
Received: from localhost.localdomain ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1891a3c53sm331127766b.56.2025.05.04.05.59.51
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 May 2025 05:59:51 -0700 (PDT)
From: Gyorgy Sarvari <skandigraun@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo] [PATCH v4] ftw, nftw, ftw64, nftw64: add tests
Date: Sun,  4 May 2025 14:59:51 +0200
Message-ID: <20250504125951.3639531-1-skandigraun@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 04 May 2025 12:59:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1485

Add tests for nftw, ftw, nftw64 and ftw64 calls.

The tests try to exercise the main functionality of the call(s): walk a filetree
with different configurations, where applicable: ftw/ftw64 don't take much config,
they just walk a tree.

nftw/nftw64 take behavior modifying flags, which are verified if they still work:
FTW_SKIP_SIBLINGS, FTW_SKIP_SUBTREE, FTW_CHDIR, FTW_DEPTH flags are verified.

The main idea is that each test is executed with glibc and with pseudo shim also.
During execution, different important details are saved into a textfile (encountered filepath,
gid/uid ownership details, and current working directory for FTW_CHDIR flag)

The output of glibc is considered to be correct, and the pseudo output is compared to that.

Signed-off-by: Gyorgy Sarvari <skandigraun@gmail.com>
---
v1: https://lists.yoctoproject.org/g/yocto-patches/message/1208 - only nftw call is tested, includes
    main wrapper also.

v2: https://lists.yoctoproject.org/g/yocto-patches/message/1299 - Added tests for ftw, ftw64 and nftw64 also

v3: https://lore.kernel.org/yocto-patches/1746302395-8723-4-git-send-email-mark.hatle@kernel.crashing.org/T/#u
    Reposted by Mark Hatle, no changes compared to v3

v4: Refactored tests, in an attempt to make them less reliant on the order of encountering the
    file entries. The main logic has also changed. In previous versions the expected output was
    hardcoded, whether it was executed with or without pseudo. In this version the output of non-pseudo
    version is considered to be an oracle, and the output of pseudo version is compared to this.



 Makefile.in           |   4 +-
 test/ftw-test-impl.c  |  93 +++++++++++++++++
 test/nftw-test-impl.c | 163 +++++++++++++++++++++++++++++
 test/test-ftw.c       |   4 +
 test/test-ftw64.c     |   4 +
 test/test-nftw.c      |   4 +
 test/test-nftw.sh     | 232 ++++++++++++++++++++++++++++++++++++++++++
 test/test-nftw64.c    |   4 +
 8 files changed, 506 insertions(+), 2 deletions(-)
 create mode 100644 test/ftw-test-impl.c
 create mode 100644 test/nftw-test-impl.c
 create mode 100644 test/test-ftw.c
 create mode 100644 test/test-ftw64.c
 create mode 100644 test/test-nftw.c
 create mode 100755 test/test-nftw.sh
 create mode 100644 test/test-nftw64.c

diff --git a/Makefile.in b/Makefile.in
index 48fdbd2..27da831 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -55,7 +55,7 @@ GUTS=$(filter-out "$(GLOB_PATTERN)",$(wildcard $(GLOB_PATTERN)))
 
 SOURCES=$(wildcard *.c)
 OBJS=$(subst .c,.o,$(SOURCES))
-TESTS=$(patsubst %.c,%,$(wildcard test/*.c))
+TESTS=$(patsubst %.c,%,$(wildcard test/test-*.c))
 
 SHOBJS=pseudo_tables.o pseudo_util.o
 DBOBJS=pseudo_db.o
@@ -78,7 +78,7 @@ all: $(LIBPSEUDO) $(PSEUDO) $(PSEUDODB) $(PSEUDOLOG) $(PSEUDO_PROFILE)
 test: all $(TESTS) | $(BIN) $(LIB)
 	./run_tests.sh -v
 
-test/%: test/%.c
+test/test-%: test/test-%.c
 	$(CC) $(CFLAGS) $(CFLAGS_PSEUDO) -o $@ $<
 
 install-lib: $(LIBPSEUDO)
diff --git a/test/ftw-test-impl.c b/test/ftw-test-impl.c
new file mode 100644
index 0000000..b117bd8
--- /dev/null
+++ b/test/ftw-test-impl.c
@@ -0,0 +1,93 @@
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <ftw.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdlib.h>
+
+static int current_recursion_level = 0;
+static int max_recursion = 0;
+
+static int print_filename = 0;
+static int print_ownership = 0;
+
+
+static int callback(const char* fpath, const struct FTW_STAT_STRUCT *sb, int __attribute__ ((unused)) typeflag){
+    if (current_recursion_level < max_recursion) {
+        ++current_recursion_level;
+        if (FTW_NAME("./walking/a1", callback, 10) != 0) {
+            printf("Recursive call failed\n");
+            exit(1);
+        }
+    }
+
+    if (print_filename) {
+        char *absolute_path = realpath(fpath, NULL);
+        printf("%s\n", absolute_path);
+        free(absolute_path);
+    }
+
+    if (print_ownership) {
+        printf("%d - %d\n", sb->st_gid, sb->st_uid);
+    }
+
+    return 0;
+}
+
+static int run_test() {
+    int ret;
+    ret = FTW_NAME("./walking", callback, 10);
+    return ret;
+}
+
+/*
+ * Walk the given directory structure, and print the given details
+ * (ownership or absolute path) of the entries encountered.
+ */
+static int test_walking(){
+    return run_test();
+}
+
+/*
+ * This test is very similar to test_walking(), but the callback at the
+ * start also calls ftw(), "max_recursion" times.
+ * It is trying to test pseudo's implementation of handling multiple
+ * concurrent (n)ftw calls in the same thread.
+ */
+static int test_walking_recursion(){
+    max_recursion = 3;
+    return run_test();
+}
+
+/*
+ * Arguments:
+ * argv[1]: the test name
+ * argv[2]: "filename" or "ownership" - determine which detail to print
+ */
+int main(int argc, char* argv[])
+{
+    if (argc != 3) {
+        printf("Usage: %s TESTNAME DETAILS\n", argv[0]);
+        printf("TESTNAME is one of: no_recursion, recursion\n");
+        printf("DETAILS is one of: filename, ownership\n");
+        return 1;
+    }
+
+    if (strcmp(argv[2], "filename") == 0) {
+        print_filename = 1;
+    } else if (strcmp(argv[2], "ownership") == 0) {
+        print_ownership = 1;
+    } else {
+        printf("Unknown second parameter");
+        return 1;
+    }
+    
+    if (strcmp(argv[1], "no_recursion") == 0) {
+        return test_walking();
+    } else if (strcmp(argv[1], "recursion") == 0) {
+        return test_walking_recursion();
+    } else {
+        printf("Unknown test name: %s\n", argv[1]);
+        return 1;
+    }
+}
diff --git a/test/nftw-test-impl.c b/test/nftw-test-impl.c
new file mode 100644
index 0000000..714da76
--- /dev/null
+++ b/test/nftw-test-impl.c
@@ -0,0 +1,163 @@
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <ftw.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdlib.h>
+
+#define TEST_CHDIR 1
+#define TEST_NO_CHDIR 0
+
+static int print_filename = 0;
+static int print_ownership = 0;
+static int print_cwd = 0;
+
+static int skip_subtree = 0;
+static int skip_subtree_counter = 0;
+
+static int skip_siblings = 0;
+char* basedir;
+
+
+// When FTW_CHDIR is enabled, cwd changes each time, so realpath
+// might not be able to resolve the path
+//char* filepath = realpath(fpath, NULL);
+char* get_absolute_path(const char* fpath) {
+    char* filepath = realpath(fpath, NULL);
+
+    if (filepath == NULL) {
+        if (fpath[0] == '/') {
+            filepath = malloc(strlen(fpath) + 1);
+            strcpy(filepath, fpath);
+        } else {
+            filepath = malloc(strlen(fpath) + strlen(basedir));
+            memset(filepath, 0, strlen(fpath) + strlen(basedir));
+            strcat(filepath, basedir);
+            // skip the initial "."
+            strcat(filepath, fpath + 1);
+        }
+    }
+    return filepath;
+}
+
+static int callback(const char* fpath, const struct NFTW_STAT_STRUCT *sb, int typeflag, struct FTW *ftwbuf){
+    if (print_filename) {
+        char* filepath = get_absolute_path(fpath);
+        printf("%s\n", filepath);
+        free(filepath);
+    }
+
+
+    if (print_ownership) {
+        printf("%d - %d\n", sb->st_gid, sb->st_uid);
+    }
+
+    if (print_cwd) {
+        char* cwd = getcwd(NULL, 0);
+        printf("%s\n", cwd);
+        free(cwd);
+    }
+
+
+    // if subtrees are skipped, don't skip immediately at the root,
+    // otherwise it's not much of a test. Skip it after encountering 2
+    // subfolders (which is an arbitrary numbers, without much science,
+    // admittedly, but better than 0)
+    if (skip_subtree && typeflag == FTW_D) {
+        if (skip_subtree_counter >= 2)
+            return FTW_SKIP_SUBTREE;
+
+        skip_subtree_counter++;
+    }
+
+    if (skip_siblings && typeflag == FTW_F) {
+        return FTW_SKIP_SIBLINGS;
+    }
+
+    return 0;
+}
+
+static int run_test(int flags) {
+    return NFTW_NAME("./walking", callback, 10, flags);
+}
+
+static int test_skip_siblings_file_depth_walking(int change_dir){
+    int flags = FTW_ACTIONRETVAL | FTW_DEPTH;
+
+    // store base_dir, because the fpath returned by (n)ftw can be relative to this
+    // folder - that way a full absolute path can be constructed and compared,
+    // if needed.
+    if (change_dir){
+        basedir = getcwd(NULL, 0);
+        flags |= FTW_CHDIR;
+    }
+
+    skip_siblings = 1;
+    return run_test(flags);
+}
+
+/*
+ * Every time a folder entry is sent to the callback, respond with FTW_SKIP_SUBTREE.
+ * This should skip that particular folder completely, and continue processing
+ * with its siblings (or parent, if there are no siblings).
+ * Return value is expected to be 0, default walking order.
+ */
+static int test_skip_subtree_on_folder(){
+    int flags = FTW_ACTIONRETVAL;
+    skip_subtree = 1;
+    return run_test(flags);
+}
+
+/*
+ * Arguments:
+ * argv[1]: always the test name
+ * argv[2], argv[3]: in case the test name refers to a test without using
+ *                   pseudo (no_pseudo), then they should be the gid and uid
+ *                   of the current user. Otherwise these arguments are ignored.
+ *
+ * skip_subtree_pseudo/skip_subtree_no_pseudo: these tests are calling nftw()
+ * with the FTW_ACTIONRETVAL flag, which reacts based on the return value from the
+ * callback. These tests check the call's reaction to FTW_SKIP_SUBTREE call,
+ * upon which nftw() should stop processing the current folder, and continue
+ * with the next sibling of the folder.
+ *
+ * skip_siblings_pseudo/skip_siblings_no_pseudo: very similar to skip_subtree
+ * tests, but it verified FTW_SKIP_SIBLINGS response, which should stop processing
+ * the current folder, and continue in its parent.
+ *
+ * skip_siblings_chdir_pseudo/skip_siblings_chdir_no_pseudoL same as skip_siblings
+ * tests, but also pass the FTW_CHDIR flag and verify that the working directory
+ * is changed as expected between callback calls.
+ */
+int main(int argc, char* argv[])
+{
+    if (argc != 3) {
+        printf("Usage: %s TESTNAME DETAILS\n", argv[0]);
+        printf("TESTNAME is one of: skip_subtree, skip_siblings, skip_siblings_chdir\n");
+        printf("DETAILS is one of: filename, ownership, cwd\n");
+        return 1;
+    }
+
+    if (strcmp(argv[2], "filename") == 0) {
+        print_filename = 1;
+    } else if (strcmp(argv[2], "ownership") == 0) {
+        print_ownership = 1;
+    } else if (strcmp(argv[2], "cwd") == 0) {
+        print_cwd = 1;
+    } else {
+        printf("Unknown second parameter\n");
+        return 1;
+    }
+
+
+    if (strcmp(argv[1], "skip_subtree") == 0) {
+        return test_skip_subtree_on_folder();
+    } else if (strcmp(argv[1], "skip_siblings") == 0) {
+        return test_skip_siblings_file_depth_walking(TEST_NO_CHDIR);
+    } else if (strcmp(argv[1], "skip_siblings_chdir") == 0) {
+        return test_skip_siblings_file_depth_walking(TEST_CHDIR);
+    } else {
+        printf("Unknown test name\n");
+        return 1;
+    }
+}
diff --git a/test/test-ftw.c b/test/test-ftw.c
new file mode 100644
index 0000000..5c47dd9
--- /dev/null
+++ b/test/test-ftw.c
@@ -0,0 +1,4 @@
+#define FTW_NAME ftw
+#define FTW_STAT_STRUCT stat
+
+#include "ftw-test-impl.c"
diff --git a/test/test-ftw64.c b/test/test-ftw64.c
new file mode 100644
index 0000000..0b8f906
--- /dev/null
+++ b/test/test-ftw64.c
@@ -0,0 +1,4 @@
+#define FTW_NAME ftw64
+#define FTW_STAT_STRUCT stat64
+
+#include "ftw-test-impl.c"
diff --git a/test/test-nftw.c b/test/test-nftw.c
new file mode 100644
index 0000000..ecadc1e
--- /dev/null
+++ b/test/test-nftw.c
@@ -0,0 +1,4 @@
+#define NFTW_NAME nftw
+#define NFTW_STAT_STRUCT stat
+
+#include "nftw-test-impl.c"
diff --git a/test/test-nftw.sh b/test/test-nftw.sh
new file mode 100755
index 0000000..fb4d78a
--- /dev/null
+++ b/test/test-nftw.sh
@@ -0,0 +1,232 @@
+#!/bin/bash
+#
+# Test nftw call and its behavior modifying flags
+#
+# The ./test/test-(n)ftw binaries print out different details of the filentries
+# they encounter during walking the test directory. These details are saved, both using
+# glibc (pseudo disabled), and with using the pseudo shim. glibc output is used
+# as the oracle, and it is expected that the two outputs are always the same - except
+# for ownership details. When it comes to file ownership, pseudo shim is expected to
+# return root owner, while glibc should return the current user.
+#
+# The verify_results() function compares the saved details, with- and without- pseudo:
+# filename, ownership and current_working_directory. If they don't match, the test fails.
+#
+# Below there are a number of tests executed, separated visually, they save different details
+# of the same testcases with and without pseudo, before calling the verification function.
+#
+# SPDX-License-Identifier: LGPL-2.1-only
+#
+
+trap "rm -rf ./walking ./with_pseudo* ./without_pseudo*" 0
+
+ret=0
+
+verify_results(){
+  current_user_uid=`env -i id -u`
+  current_user_gid=`env -i id -g`
+
+  # the list of files should match with and without pseudo
+  diff -Naur ./with_pseudo_filename ./without_pseudo_filename > /dev/null
+  file_list_result=$?
+
+  # in case there is a cwd file (recording the current working dir for each entry),
+  # than they should match also
+  cwd_list_result=0
+  if [ -f ./with_pseudo_cwd ]; then
+    diff -Naur ./with_pseudo_cwd ./without_pseudo_cwd > /dev/null
+    cwd_list_result=$?
+  fi
+
+  # ownership file's content is "$GID - $UID", per line
+  # when using pseudo, both GID and UID should be 0
+  incorrect_pseudo_ownership_count=`grep -vc "0 - 0" with_pseudo_ownership || true`
+
+  # when not using pseudo, the GID and UID should match the
+  # current user's IDs
+  incorrect_no_pseudo_ownership_count=`grep -vc "$current_user_gid - $current_user_uid" without_pseudo_ownership || true`
+
+  if [ $file_list_result -ne 0 ]; then
+    echo test-nftw: $1: Failed, invalid file list
+    ret=1
+  elif [ $incorrect_pseudo_ownership_count -ne 0 ]; then
+    echo test-nftw: $1: Failed, incorrect pseudo ownership details
+    ret=1
+  elif [ $incorrect_no_pseudo_ownership_count -ne 0 ]; then
+    echo test-nftw: $1: Failed, incorrect no pseudo ownership details
+    ret=1
+  elif [ $cwd_list_result -ne 0 ]; then
+    echo test-nftw: $1: Failed, incorrect current working directory
+    ret = 1
+  else
+    echo test-nftw: $1: Passed
+  fi  
+}
+
+
+
+mkdir -p walking/a1/b1/c1
+touch walking/a1/b1/c1/file
+mkdir walking/a1/b2
+mkdir walking/a1/b3
+touch walking/a1/b1/c1/file2
+touch walking/a1/b1/c1/file3
+touch walking/a1/b2/file4
+touch walking/a1/b2/file5
+
+
+
+
+# Test for ftw(), walk tree without recursion
+unset PSEUDO_DISABLED
+./test/test-ftw no_recursion filename > with_pseudo_filename
+./test/test-ftw no_recursion ownership > with_pseudo_ownership
+
+export PSEUDO_DISABLED=1
+./test/test-ftw no_recursion filename > without_pseudo_filename
+./test/test-ftw no_recursion ownership > without_pseudo_ownership
+
+verify_results "ftw no recursion"
+
+
+
+
+
+
+
+# Test for ftw64(), walk tree without recursion
+unset PSEUDO_DISABLED
+./test/test-ftw64 no_recursion filename > with_pseudo_filename
+./test/test-ftw64 no_recursion ownership > with_pseudo_ownership
+
+export PSEUDO_DISABLED=1
+./test/test-ftw64 no_recursion filename > without_pseudo_filename
+./test/test-ftw64 no_recursion ownership > without_pseudo_ownership
+
+verify_results "ftw64 no recursion"
+
+
+
+
+
+
+
+# Test for ftw(), walk tree while calling ftw() again recursively, from
+# within an ftw() callback itself
+unset PSEUDO_DISABLED
+./test/test-ftw recursion filename > with_pseudo_filename
+./test/test-ftw recursion ownership > with_pseudo_ownership
+
+export PSEUDO_DISABLED=1
+./test/test-ftw recursion filename > without_pseudo_filename
+./test/test-ftw recursion ownership > without_pseudo_ownership
+
+verify_results "ftw recursion"
+
+
+
+
+
+
+# Test for ftw64(), walk tree while calling ftw64() again recursively, from
+# within an ftw64() callback itself
+unset PSEUDO_DISABLED
+./test/test-ftw64 recursion filename > with_pseudo_filename
+./test/test-ftw64 recursion ownership > with_pseudo_ownership
+
+export PSEUDO_DISABLED=1
+./test/test-ftw64 recursion filename > without_pseudo_filename
+./test/test-ftw64 recursion ownership > without_pseudo_ownership
+
+verify_results "ftw64 recursion"
+
+
+
+
+
+# Test for nftw(), walk tree, but return SKIP_SUBTREE response each
+# time a directory entry is received by the callback.
+unset PSEUDO_DISABLED
+./test/test-nftw skip_subtree filename > with_pseudo_filename
+./test/test-nftw skip_subtree ownership > with_pseudo_ownership
+
+export PSEUDO_DISABLED=1
+./test/test-nftw skip_subtree filename > without_pseudo_filename
+./test/test-nftw skip_subtree ownership > without_pseudo_ownership
+
+verify_results "nftw skip_subtree"
+
+
+
+
+
+# Test for nftw64(), walk tree, but return SKIP_SUBTREE response each
+# time a directory entry is received by the callback.
+unset PSEUDO_DISABLED
+./test/test-nftw64 skip_subtree filename > with_pseudo_filename
+./test/test-nftw64 skip_subtree ownership > with_pseudo_ownership
+
+export PSEUDO_DISABLED=1
+./test/test-nftw64 skip_subtree filename > without_pseudo_filename
+./test/test-nftw64 skip_subtree ownership > without_pseudo_ownership
+
+verify_results "nftw64 skip_subtree"
+
+
+
+# Test for nftw(), walk tree, but return SKIP_SIBLINGS response each
+# time a file entry is received by the callback
+unset PSEUDO_DISABLED
+./test/test-nftw skip_siblings filename > with_pseudo_filename
+./test/test-nftw skip_siblings ownership > with_pseudo_ownership
+
+#export PSEUDO_DISABLED=1
+./test/test-nftw skip_siblings filename > without_pseudo_filename
+./test/test-nftw skip_siblings ownership > without_pseudo_ownership
+
+verify_results "nftw skip_siblings"
+
+
+
+
+
+
+# Test for nftw64(), walk tree, but return SKIP_SIBLINGS response each
+# time a file entry is received by the callback
+unset PSEUDO_DISABLED
+./test/test-nftw64 skip_siblings filename > with_pseudo_filename
+./test/test-nftw64 skip_siblings ownership > with_pseudo_ownership
+
+export PSEUDO_DISABLED=1
+./test/test-nftw64 skip_siblings filename > without_pseudo_filename
+./test/test-nftw64 skip_siblings ownership > without_pseudo_ownership
+
+verify_results "nftw64 skip_siblings"
+
+
+
+
+
+
+
+# Test for nftw(), walk tree, but return SKIP_SIBLINGS response each
+# time a file entry is received by the callback, and also set the
+# FTW_CHDIR flag on the call to switch to the corresponding folder
+
+unset PSEUDO_DISABLED
+./test/test-nftw skip_siblings_chdir filename > with_pseudo_filename
+./test/test-nftw skip_siblings_chdir ownership > with_pseudo_ownership
+./test/test-nftw skip_siblings_chdir cwd > with_pseudo_cwd
+
+
+
+export PSEUDO_DISABLED=1
+./test/test-nftw skip_siblings_chdir filename > without_pseudo_filename
+./test/test-nftw skip_siblings_chdir ownership > without_pseudo_ownership
+./test/test-nftw skip_siblings_chdir cwd > without_pseudo_cwd
+
+verify_results "nftw skip_siblings_chdir"
+
+
+
+exit $ret
diff --git a/test/test-nftw64.c b/test/test-nftw64.c
new file mode 100644
index 0000000..20f25af
--- /dev/null
+++ b/test/test-nftw64.c
@@ -0,0 +1,4 @@
+#define NFTW_NAME nftw64
+#define NFTW_STAT_STRUCT stat64
+
+#include "nftw-test-impl.c"

