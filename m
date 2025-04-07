Return-Path: <skandigraun@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61048C369A1
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 19:14:23 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
 by mx.groups.io with SMTP id smtpd.web10.56758.1744053259916990581
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 12:14:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=K7q/RbHJ;
 spf=pass (domain: gmail.com, ip: 209.85.208.41, mailfrom: skandigraun@gmail.com)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e61375c108so6753979a12.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 12:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744053258; x=1744658058; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p07MbSWWmVIEtkORuLBPVUNnzgIdYGrEA6HTNC5hFEY=;
        b=K7q/RbHJ8IyRFQ1W1D1tp6uS0TPccN4ShsB1Xlfz8pMpKGzddRk+yUjQdScTRln4vr
         JctFkGkSyUNzEPayhTu+otif5qS941FHYgPCj0e3vf2UfWqeRpOKixybGHP3yYBiDm6j
         oHtiBP38KTntwNNnNY/2X+bphlyENRwzznoRqSKerlk0T/T2xZ8Miifltj0uzFX9HJ+y
         A5GfAF5sS0xzy9Z2CP5oSrJmdgC50cu4H+N4p3UHi413z6yZg0U5CnUSg1H3hLjPEyUz
         9OpBqRwIPBYkHIj9hprQGLNRqjuK/m3L6gtX6paFzsCCjIw2Ziyv7aA9uAbcM/qZ+Ots
         tL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744053258; x=1744658058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p07MbSWWmVIEtkORuLBPVUNnzgIdYGrEA6HTNC5hFEY=;
        b=hK2aRslsxUcQbdJEYOOtpLli9rvtSR5iu3g5xlhR/eqXmaqi4cAhtFnwWnCoxw4z60
         Pj25lZcqtkADlMC06MZo7Xruqv2udq7RncR3ri2cbDNnhw31JdSVfUf04AY91MHsnU5w
         2X5OXjX3ihS0YWezUIIsnuWAsvWHlyC44V0kETSKI2IBzERyTOUbyV/SGbq9X9S3FtA3
         HZLANXNKzR149uHT9YEAv/icdLarQmvY3GckIWf23/dz63EOBISs8+RzAQ/qcq7k21Wy
         Psxj0hv1LbAZmK+GkBpmjh6tXcQME6iICQ8wfqiyDrlgbCLOmstwO0Bgulyt0v4oF5XK
         CuFQ==
X-Gm-Message-State: AOJu0YyOJTOSdb/6Oi2wHBYYd+pXDz3Vpe6gMKUho8JO/1982WPl5Wfw
	iVl6PX2mNJKyr/GU4h3m2tDK0HHGO8qEZaHdAx5nxhvTwbbBySXpFrwafA==
X-Gm-Gg: ASbGncvLHOTDQmd1DlnDCK0A61/J26pxrbMyYc7RST2KUjrc9kAsJ2X4b6iMl/6ANGK
	y2Xcn/ZBMsylpu4u/KszE3ClgXYF7SSzO12qFvS21LljaBjt+JqmXjNXsBtu3W7kZEcOGtFRghJ
	iwLayFNs9WlDIu5abn2mobiG7m8Q4UUizCHP0C2limM2pjT4enTh+fdzQc9LXuSKZEWzJk2ijIO
	LxCtJKp21TcQzArxkgqx/OfyHnWfzH4g9uFPsUlsZz22x4GuRu4uNS5mYxeNkNymYjLiRJY7eEA
	q+x6rl5E5gTkYrLmc6kTAEfeGoGSk2a777RM+TT6mvq3J4zNYmNdVqbfawml
X-Google-Smtp-Source: AGHT+IGTNxCXLwxqiYJoemtdNIixOezCtScR53f92tVdGGZyzWhH0k4sG3iN8s2zCAibzKldbZ9D3Q==
X-Received: by 2002:a05:6402:2807:b0:5e5:437c:1daf with SMTP id 4fb4d7f45d1cf-5f0b647cd9bmr9746493a12.16.1744053257603;
        Mon, 07 Apr 2025 12:14:17 -0700 (PDT)
Received: from localhost.localdomain ([51.154.145.205])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f087eedf61sm6916078a12.32.2025.04.07.12.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 12:14:17 -0700 (PDT)
From: Gyorgy Sarvari <skandigraun@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: landervanloock@gmail.com
Subject: [pseudo][PATCH v2 2/2] nftw, ftw: add tests
Date: Mon,  7 Apr 2025 21:14:14 +0200
Message-ID: <20250407191414.2992785-3-skandigraun@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407191414.2992785-1-skandigraun@gmail.com>
References: <20250407191414.2992785-1-skandigraun@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 19:14:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1299

Add tests for nftw, ftw, nftw64 and ftw64 calls.

Signed-off-by: Gyorgy Sarvari <skandigraun@gmail.com>
---
 Makefile.in           |   4 +-
 test/ftw-test-impl.c  | 226 ++++++++++++++++++++++++++++++++++++++++
 test/nftw-test-impl.c | 236 ++++++++++++++++++++++++++++++++++++++++++
 test/test-ftw.c       |   4 +
 test/test-ftw64.c     |   4 +
 test/test-nftw.c      |   4 +
 test/test-nftw.sh     |  84 +++++++++++++++
 test/test-nftw64.c    |   4 +
 8 files changed, 564 insertions(+), 2 deletions(-)
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
index 0000000..edd15eb
--- /dev/null
+++ b/test/ftw-test-impl.c
@@ -0,0 +1,226 @@
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <ftw.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdlib.h>
+
+#define LAST_VAL 999
+#define LAST_PATH "LAST_SENTINEL"
+
+#define TEST_WITH_PSEUDO 1
+#define TEST_WITHOUT_PSEUDO 0
+
+static int current_idx = 0;
+static int* current_responses;
+static char** expected_fpaths;
+
+static int pseudo_active;
+
+static unsigned int expected_gid;
+static unsigned int expected_uid;
+
+static int current_recursion_level = 0;
+static int max_recursion = 0;
+
+
+static int callback(const char* fpath, const struct FTW_STAT_STRUCT *sb, int typeflag){
+    if (current_recursion_level < max_recursion) {
+        ++current_recursion_level;
+        if (FTW_NAME("./walking/a1", callback, 10) != 0) {
+            printf("Recursive call failed\n");
+            exit(1);
+        }
+    }
+
+
+    int ret = current_responses[current_idx];
+    // printf("idx: %d, path: %s, ret: %d\n", current_idx, fpath, ret);
+
+    if (ret == LAST_VAL){
+        printf("Unexpected callback, it should have stopped already! fpath: %s\n", fpath);
+        return FTW_STOP;
+    }
+
+    char* expected_fpath_ending = expected_fpaths[current_idx];
+
+    if (strcmp(expected_fpath_ending, LAST_PATH) == 0){
+        printf("Unexpected fpath received: %s\n", fpath);
+        return FTW_STOP;
+    }
+
+    const char* actual_fpath_ending = fpath + strlen(fpath) - strlen(expected_fpath_ending);
+
+    if (strcmp(actual_fpath_ending, expected_fpath_ending) != 0){
+        printf("Incorrect fpath received. Expected: %s, actual: %s\n", expected_fpath_ending, actual_fpath_ending);
+        return FTW_STOP;
+    }
+
+    if (pseudo_active) {
+        if (sb->st_gid != 0 || sb->st_uid != 0) {
+            printf("Invalid uid/gid! Gid (act/exp): %d/%d, Uid (act/exp): %d/%d\n", sb->st_gid, 0, sb->st_uid, 0);
+            return FTW_STOP;
+        }
+    } else if (sb->st_gid != expected_gid || sb->st_uid != expected_uid) {
+        printf("Invalid uid/gid! Gid (act/exp): %d/%d, Uid (act/exp): %d/%d\n", sb->st_gid, expected_gid, sb->st_uid, expected_uid);
+        return FTW_STOP;
+    }
+
+    ++current_idx;
+    return ret;
+}
+
+static int run_test(int* responses, char** fpaths, int expected_retval, int with_pseudo) {
+    int ret;
+    current_responses = responses;
+    expected_fpaths = fpaths;
+    pseudo_active = with_pseudo;
+
+    ret = FTW_NAME("./walking", callback, 10);
+    current_responses = NULL;
+    expected_fpaths = NULL;
+
+    if (ret != expected_retval){
+        printf("Incorrect return value. Expected: %d, actual: %d\n", expected_retval, ret);
+        return 1;
+    }
+
+    if (responses[current_idx] != LAST_VAL){
+        printf("Not all expected paths were walked!\n");
+        return 1;
+    }
+    return 0;
+}
+
+/*
+ * This test just walks the whole test directory structure, and verifies that
+ * all expected files are returned.
+ */
+static int test_walking(int with_pseudo){
+    int responses[] = {FTW_CONTINUE, FTW_CONTINUE, FTW_CONTINUE, FTW_CONTINUE,
+                       FTW_CONTINUE, FTW_CONTINUE, FTW_CONTINUE, FTW_CONTINUE,
+                       FTW_CONTINUE, FTW_CONTINUE, FTW_CONTINUE, LAST_VAL};
+
+    char* fpaths[] = {"walking",
+                      "walking/a1",
+                      "walking/a1/b2",
+                      "walking/a1/b2/file5",
+                      "walking/a1/b2/file4",
+                      "walking/a1/b1",
+                      "walking/a1/b1/c1",
+                      "walking/a1/b1/c1/file",
+                      "walking/a1/b1/c1/file3",
+                      "walking/a1/b1/c1/file2",
+                      "walking/a1/b3",
+                      LAST_PATH};
+
+    int expected_retval = 0;
+
+    return run_test(responses, fpaths, expected_retval, with_pseudo);
+}
+
+/*
+ * This test is very similar to test_walking(), but the callback at the
+ * start also calls ftw(), "max_recursion" times.
+ * It is trying to test pseudo's implementation of handling multiple
+ * concurrent (n)ftw calls in the same thread.
+ */
+static int test_walking_recursion(int with_pseudo){
+    max_recursion = 3;
+
+    int responses[] = {FTW_CONTINUE, FTW_CONTINUE, FTW_CONTINUE, FTW_CONTINUE,
+                       FTW_CONTINUE, FTW_CONTINUE, FTW_CONTINUE, FTW_CONTINUE,
+                       FTW_CONTINUE, FTW_CONTINUE, FTW_CONTINUE, FTW_CONTINUE,
+                       FTW_CONTINUE, FTW_CONTINUE, FTW_CONTINUE, FTW_CONTINUE,
+                       FTW_CONTINUE, FTW_CONTINUE, FTW_CONTINUE, FTW_CONTINUE,
+                       FTW_CONTINUE, FTW_CONTINUE, FTW_CONTINUE, FTW_CONTINUE,
+                       FTW_CONTINUE, FTW_CONTINUE, FTW_CONTINUE, FTW_CONTINUE,
+                       FTW_CONTINUE, FTW_CONTINUE, FTW_CONTINUE, FTW_CONTINUE,
+                       FTW_CONTINUE, FTW_CONTINUE, FTW_CONTINUE, FTW_CONTINUE,
+                       FTW_CONTINUE, FTW_CONTINUE, FTW_CONTINUE, FTW_CONTINUE,
+                       FTW_CONTINUE, LAST_VAL};
+
+    char* fpaths[] = {"walking/a1",
+                      "walking/a1/b2",
+                      "walking/a1/b2/file5",
+                      "walking/a1/b2/file4",
+                      "walking/a1/b1",
+                      "walking/a1/b1/c1",
+                      "walking/a1/b1/c1/file",
+                      "walking/a1/b1/c1/file3",
+                      "walking/a1/b1/c1/file2",
+                      "walking/a1/b3",
+                      "walking/a1",
+                      "walking/a1/b2",
+                      "walking/a1/b2/file5",
+                      "walking/a1/b2/file4",
+                      "walking/a1/b1",
+                      "walking/a1/b1/c1",
+                      "walking/a1/b1/c1/file",
+                      "walking/a1/b1/c1/file3",
+                      "walking/a1/b1/c1/file2",
+                      "walking/a1/b3",
+                      "walking/a1",
+                      "walking/a1/b2",
+                      "walking/a1/b2/file5",
+                      "walking/a1/b2/file4",
+                      "walking/a1/b1",
+                      "walking/a1/b1/c1",
+                      "walking/a1/b1/c1/file",
+                      "walking/a1/b1/c1/file3",
+                      "walking/a1/b1/c1/file2",
+                      "walking/a1/b3",
+                      "walking",
+                      "walking/a1",
+                      "walking/a1/b2",
+                      "walking/a1/b2/file5",
+                      "walking/a1/b2/file4",
+                      "walking/a1/b1",
+                      "walking/a1/b1/c1",
+                      "walking/a1/b1/c1/file",
+                      "walking/a1/b1/c1/file3",
+                      "walking/a1/b1/c1/file2",
+                      "walking/a1/b3",
+                      LAST_PATH};
+    int expected_retval = 0;
+
+    return run_test(responses, fpaths, expected_retval, with_pseudo);
+}
+
+/*
+ * Arguments:
+ * argv[1]: always the test name
+ * argv[2], argv[3]: in case the test name refers to a test without using
+ *                   pseudo (no_pseudo), then they should be the gid and uid
+ *                   of the current user. Otherwise these arguments are ignored.
+ *
+ * ftw64 call only exists on Linux in case __USE_LARGEFILE64 is defined.
+ * If this is not the case, just skip this test.
+ */
+int main(int argc, char* argv[])
+{
+#if !defined(__USE_LARGEFILE64) && FTW_NAME == ftw64
+return 0
+#endif
+    if (argc < 2) {
+        printf("Need a test name as argument\n");
+        return 1;
+    }
+    
+    if (strcmp(argv[1], "pseudo_no_recursion") == 0) {
+        return test_walking(TEST_WITH_PSEUDO);
+    } else if (strcmp(argv[1], "no_pseudo_no_recursion") == 0) {
+        expected_gid = atoi(argv[2]);
+        expected_uid = atoi(argv[3]);
+        return test_walking(TEST_WITHOUT_PSEUDO);
+    } if (strcmp(argv[1], "pseudo_recursion") == 0) {
+        return test_walking_recursion(TEST_WITH_PSEUDO);
+    } if (strcmp(argv[1], "no_pseudo_recursion") == 0) {
+        expected_gid = atoi(argv[2]);
+        expected_uid = atoi(argv[3]);
+        return test_walking_recursion(TEST_WITHOUT_PSEUDO);
+    } else {
+        printf("Unknown test name: %s\n", argv[1]);
+        return 1;
+    }
+}
diff --git a/test/nftw-test-impl.c b/test/nftw-test-impl.c
new file mode 100644
index 0000000..5bef281
--- /dev/null
+++ b/test/nftw-test-impl.c
@@ -0,0 +1,236 @@
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <ftw.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdlib.h>
+
+#define PATH_MAX 1024
+#define LAST_VAL 999
+#define LAST_PATH "LAST_SENTINEL"
+
+#define TEST_WITH_PSEUDO 1
+#define TEST_WITHOUT_PSEUDO 0
+
+#define TEST_CHDIR 1
+#define TEST_NO_CHDIR 0
+
+static int current_idx = 0;
+static int* current_responses;
+static char** expected_fpaths;
+
+static int pseudo_active;
+static int verify_folder = 0;
+static char* base_dir = NULL;
+
+static unsigned int expected_gid;
+static unsigned int expected_uid;
+
+static int compare_paths(const char *path1, const char *path2){
+    char full_path1[PATH_MAX] = {0};
+    char full_path2[PATH_MAX] = {0};
+
+    if (path1[0] == '.'){
+        strcat(full_path1, base_dir);
+        strcat(full_path1, path1 + 1);
+    } else {
+        strcpy(full_path1, path1);
+    }
+
+    if (path2[0] == '.'){
+        strcat(full_path2, base_dir);
+        strcat(full_path2, path2 + 1);
+    } else {
+        strcpy(full_path2, path2);
+    }
+
+    return strcmp(full_path1, full_path2);
+}
+
+static int callback(const char* fpath, const struct NFTW_STAT_STRUCT *sb, int typeflag, struct FTW *ftwbuf){
+    int ret = current_responses[current_idx];
+//    printf("path: %s, ret: %d\n", fpath, ret);
+
+    if (ret == LAST_VAL){
+        printf("Unexpected callback, it should have stopped already! fpath: %s\n", fpath);
+        return FTW_STOP;
+    }
+
+    char* expected_fpath_ending = expected_fpaths[current_idx];
+
+    if (strcmp(expected_fpath_ending, LAST_PATH) == 0){
+        printf("Unexpected fpath received: %s\n", fpath);
+        return FTW_STOP;
+    }
+
+    const char* actual_fpath_ending = fpath + strlen(fpath) - strlen(expected_fpath_ending);
+
+    if (strcmp(actual_fpath_ending, expected_fpath_ending) != 0){
+        printf("Incorrect fpath received. Expected: %s, actual: %s\n", expected_fpath_ending, actual_fpath_ending);
+        return FTW_STOP;
+    }
+
+    if (pseudo_active) {
+        if (sb->st_gid != 0 || sb->st_uid != 0) {
+            printf("Invalid uid/gid! Gid (act/exp): %d/%d, Uid (act/exp): %d/%d\n", sb->st_gid, 0, sb->st_uid, 0);
+            return FTW_STOP;
+        }
+    } else if (sb->st_gid != expected_gid || sb->st_uid != expected_uid) {
+        printf("Invalid uid/gid! Gid (act/exp): %d/%d, Uid (act/exp): %d/%d\n", sb->st_gid, expected_gid, sb->st_uid, expected_uid);
+        return FTW_STOP;
+    }
+
+    if (verify_folder) {
+        int res;
+        char* cwd = NULL;
+        cwd = getcwd(NULL, 0);
+
+        char* exp_cwd = NULL;
+        if (typeflag == FTW_DP){
+            res = compare_paths(fpath, cwd);
+        } else {
+            char* exp_cwd = malloc(ftwbuf->base);
+            memset(exp_cwd, 0, ftwbuf->base);
+            strncpy(exp_cwd, fpath, ftwbuf->base - 1);
+            res = compare_paths(cwd, exp_cwd);
+        }
+
+        free(cwd);
+        free(exp_cwd);
+
+        if (res != 0) {
+            printf("Incorrect folder for %s\n", fpath);
+            return FTW_STOP;
+        }
+    }
+
+    ++current_idx;
+    return ret;
+}
+
+static int run_test(int* responses, char** fpaths, int expected_retval, int with_pseudo, int flags) {
+    int ret;
+    current_responses = responses;
+    expected_fpaths = fpaths;
+    pseudo_active = with_pseudo;
+
+    ret = NFTW_NAME("./walking", callback, 10, flags);
+    current_responses = NULL;
+    expected_fpaths = NULL;
+
+    if (ret != expected_retval){
+        printf("Incorrect return value. Expected: %d, actual: %d\n", expected_retval, ret);
+        return 1;
+    }
+
+    if (responses[current_idx] != LAST_VAL){
+        printf("Not all expected paths were walked!\n");
+        return 1;
+    }
+    return 0;
+}
+
+static int test_skip_siblings_file_depth_walking(int with_pseudo, int change_dir){
+    int responses[] = {FTW_SKIP_SIBLINGS, FTW_CONTINUE, FTW_SKIP_SIBLINGS, FTW_CONTINUE,
+                       FTW_CONTINUE, FTW_CONTINUE, FTW_CONTINUE, FTW_CONTINUE, LAST_VAL};
+    char* fpaths[] = {"walking/a1/b2/file5",
+                      "walking/a1/b2",
+                      "walking/a1/b1/c1/file",
+                      "walking/a1/b1/c1",
+                      "walking/a1/b1",
+                      "walking/a1/b3",
+                      "walking/a1",
+                      "walking",
+                      LAST_PATH};
+    int expected_retval = 0;
+    int flags = FTW_ACTIONRETVAL | FTW_DEPTH;
+
+    // store base_dir, because the fpath returned by (n)ftw can be relative to this
+    // folder - that way a full absolute path can be constructed and compared,
+    // if needed.
+    if (change_dir){
+        flags |= FTW_CHDIR;
+        base_dir = getcwd(NULL, 0);
+        verify_folder = 1;
+    }
+
+    return run_test(responses, fpaths, expected_retval, with_pseudo, flags);
+}
+
+/*
+ * Every time a folder entry is sent to the callback, respond with FTW_SKIP_SUBTREE.
+ * This should skip that particular folder completely, and continue processing
+ * with its siblings (or parent, if there are no siblings).
+ * Return value is expected to be 0, default walking order.
+ */
+static int test_skip_subtree_on_folder(int with_pseudo){
+    int responses[] = {FTW_CONTINUE, FTW_CONTINUE, FTW_SKIP_SUBTREE, FTW_SKIP_SUBTREE,
+                       FTW_SKIP_SUBTREE, LAST_VAL};
+    char* fpaths[] = {"walking",
+                      "walking/a1",
+                      "walking/a1/b2",
+                      "walking/a1/b1",
+                      "walking/a1/b3",
+                      LAST_PATH};
+    int expected_retval = 0;
+    int flags = FTW_ACTIONRETVAL;
+
+    return run_test(responses, fpaths, expected_retval, with_pseudo, flags);
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
+ *
+ * nftw64 call only exists on Linux in case __USE_LARGEFILE64 is defined.
+ * If this is not the case, just skip this test.
+ */
+int main(int argc, char* argv[])
+{
+#if !defined(__USE_LARGEFILE64) && NFTW_NAME == nftw64
+return 0
+#endif
+    if (argc < 2) {
+        printf("Need a test name as argument\n");
+        return 1;
+    }
+
+    if (argc > 2) {
+        expected_gid = atoi(argv[2]);
+        expected_uid = atoi(argv[3]);
+    }
+    
+    if (strcmp(argv[1], "skip_subtree_pseudo") == 0) {
+        return test_skip_subtree_on_folder(TEST_WITH_PSEUDO);
+    } else if (strcmp(argv[1], "skip_subtree_no_pseudo") == 0) {
+        return test_skip_subtree_on_folder(TEST_WITHOUT_PSEUDO);
+    } else if (strcmp(argv[1], "skip_siblings_pseudo") == 0) {
+        return test_skip_siblings_file_depth_walking(TEST_WITH_PSEUDO, TEST_NO_CHDIR);
+    } else if (strcmp(argv[1], "skip_siblings_no_pseudo") == 0) {
+        return test_skip_siblings_file_depth_walking(TEST_WITHOUT_PSEUDO, TEST_NO_CHDIR);
+    } else if (strcmp(argv[1], "skip_siblings_chdir_pseudo") == 0) {
+        return test_skip_siblings_file_depth_walking(TEST_WITH_PSEUDO, TEST_CHDIR);
+    } else if (strcmp(argv[1], "skip_siblings_chdir_no_pseudo") == 0) {
+        return test_skip_siblings_file_depth_walking(TEST_WITHOUT_PSEUDO, TEST_CHDIR);
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
index 0000000..c13e12b
--- /dev/null
+++ b/test/test-nftw.sh
@@ -0,0 +1,84 @@
+#!/bin/bash
+#
+# Test nftw call and its behavior modifying flags
+# SPDX-License-Identifier: LGPL-2.1-only
+#
+
+trap "rm -rf ./walking" 0
+
+check_retval_and_fail_if_needed(){
+  if [ $1 -ne 0 ]; then
+    echo $2
+    exit 1
+  fi
+}
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
+./test/test-nftw skip_subtree_pseudo
+check_retval_and_fail_if_needed $? "nftw subtree skipping with pseudo failed"
+
+./test/test-nftw skip_siblings_pseudo
+check_retval_and_fail_if_needed $? "nftw sibling skipping with pseudo failed"
+
+./test/test-nftw skip_siblings_chdir_pseudo
+check_retval_and_fail_if_needed $? "nftw sibling skipping chddir with pseudo failed"
+
+./test/test-nftw64 skip_subtree_pseudo
+check_retval_and_fail_if_needed $? "nftw64 subtree skipping with pseudo failed"
+
+./test/test-nftw64 skip_siblings_pseudo
+check_retval_and_fail_if_needed $? "nftw64 sibling skipping with pseudo failed"
+
+./test/test-ftw pseudo_no_recursion
+check_retval_and_fail_if_needed $? "ftw non-recursive walking with pseudo failed"
+
+./test/test-ftw pseudo_recursion
+check_retval_and_fail_if_needed $? "ftw recursive walking with pseudo failed"
+
+./test/test-ftw64 pseudo_no_recursion
+check_retval_and_fail_if_needed $? "ftw64 non-recursive walking with pseudo failed"
+
+./test/test-ftw64 pseudo_recursion
+check_retval_and_fail_if_needed $? "ftw64 recursive walking with pseudo failed"
+
+
+export PSEUDO_DISABLED=1
+
+uid=`env -i id -u`
+gid=`env -i id -g`
+
+./test/test-nftw skip_subtree_no_pseudo $gid $uid
+check_retval_and_fail_if_needed $? "nftw subtree skipping without pseudo failed"
+
+./test/test-nftw skip_siblings_no_pseudo $gid $uid
+check_retval_and_fail_if_needed $? "nftw sibling skipping without pseudo failed"
+
+./test/test-nftw skip_siblings_chdir_no_pseudo $gid $uid
+check_retval_and_fail_if_needed $? "nftw sibling skipping chdir without pseudo failed"
+
+./test/test-nftw64 skip_subtree_no_pseudo $gid $uid
+check_retval_and_fail_if_needed $? "nftw subtree skipping without pseudo failed"
+
+./test/test-nftw64 skip_siblings_no_pseudo $gid $uid
+check_retval_and_fail_if_needed $? "nftw sibling skipping without pseudo failed"
+
+./test/test-ftw no_pseudo_no_recursion $gid $uid
+check_retval_and_fail_if_needed $? "ftw non-recursive walking without pseudo failed"
+
+./test/test-ftw no_pseudo_recursion $gid $uid
+check_retval_and_fail_if_needed $? "ftw recursive walking without pseudo failed"
+
+./test/test-ftw64 no_pseudo_no_recursion $gid $uid
+check_retval_and_fail_if_needed $? "ftw non-recursive walking without pseudo failed"
+
+./test/test-ftw64 no_pseudo_recursion $gid $uid
+check_retval_and_fail_if_needed $? "ftw recursive walking without pseudo failed"
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

