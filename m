Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2456CD6E56
	for <webhook@archiver.kernel.org>; Mon,  1 Jun 2026 09:39:44 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22955.1780297960245329640
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Jun 2026 00:12:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=WRrFu5a8;
 spf=pass (domain: gmail.com, ip: 209.85.210.173, mailfrom: nmjain23@gmail.com)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8419ab3a297so2984140b3a.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 00:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780297959; x=1780902759; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XpXbjTaUSgYxbHKMQzQqqVTMsNm06VAI146hHn9ytsw=;
        b=WRrFu5a8l4KdVSyi2++eSTG/h8UM5cNADJ+n9lcFtJDX015WMc+QgwMdgvwVIT36WJ
         n6fv65rLjqOMhE7jGFuVhVzJamnt6fLaawCypVSUlTsYcdXPtgnzsQg9djfgeDUwxVJS
         PwSd6oatytCgT/DCfk/FoCcbO24THWXstLujWk3k+iluOe/3K5ac0Q1Gc75sqLqXBlJZ
         jVxurpbHDecvmWjsIQeQ1ybustz8GigJ6htPtn4nQwVvKFuPYGaue1cnHFBgEB2gGoW5
         uPomGU2qT8GgmCjd6W9TW+IAaTM8Sjha1X0wnfP4b4sUD2zaRnwZbklPeQ9oEsF0yrJz
         FLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780297959; x=1780902759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XpXbjTaUSgYxbHKMQzQqqVTMsNm06VAI146hHn9ytsw=;
        b=DUlsj1/q9HySTs6janWyUq+GNTKolB5hHlfJf/hz+UnnShRyX0+uSJzY1fQWYPexyD
         tqs8KEwjg2pYhNSQfIhQVNtNm9NW77YvrF3vSyR0kQ4TkKRLWZpfNfKlv5SeE+cpgP7R
         cXylbpTfXvdmHc51np8rdPkLE3h8x2GS4xegoru14fh2RuRQ9V7WaahaxJay7458x03D
         W3DxNfB2+eISj517SbQyba11rDBCigqVK5O9mMORpwvwdLxWFDhae1rlD9cCdPwS3ZCP
         ZLwuL6IhEj2N8oYER2p4TKgEFfM3Vd/Vn7Hme7PdvR+xtNa0fvMhnl2HyI1eZZPFlGim
         wWVw==
X-Gm-Message-State: AOJu0YxmSt7sfU879bvF2lBxi5la5z1jr39Oe8MZ93jeO1TxniXp2PNj
	zhprDfnTA7Yjmey716C+lNnWII5lqMeiAyx4HxINyXDnqaYPX7OI6ZXZZbDnaA==
X-Gm-Gg: Acq92OFvMRS3XfAE5bfuAkDv9+CCbFdlG7xFdPCOTQhh6d1hJrDH98xNpwbv/QBYwko
	ndbfMdQ7GA9kQC+J8Fb67giC9YYS75rayRZycWOtl4zMNzi9CrDfpAiZDZC2iUm6O56nvWWmIBY
	hn57TfBZVYiml2aGJDEH0ARFqhjzVOXOyKVKdh8LEaEbehPEIOa9icZJ7l/5HRvgjTOu7QCBYn9
	uJZ9XHumAl3FHlJLN5EufoNtI7h+JoX9FZg5pcYNBy8OVVzTgvbGdP7d4f/BOvNCP8WwFjQ5EXw
	PUkYNgJucxxKGaSq/2K6CbR69Fll/b9QiHqpimw7gQAmTZFpor1TsvY+aNyepM648rnAwJ++BXT
	gZoyvVLWlv5WOEGLgBZYnuI0yDbU5H99uFrcFflH9EjlD1Oego8N5UfEK8CPc6EL4zO+/rLAQYn
	xLnlX4jMyyOU/Oi8ivYiKgUjo2zTszuwrsrd+xwXw6hUZO7WJvFyulzZGGnR0O8pKpZ54O1oIuO
	kkZw0VHs4k=
X-Received: by 2002:a05:6a00:3904:b0:827:32de:d197 with SMTP id d2e1a72fcca58-842256d98a0mr8070860b3a.40.1780297959398;
        Mon, 01 Jun 2026 00:12:39 -0700 (PDT)
Received: from LL-3450LLL.kpit.com ([103.133.67.152])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8423a790c04sm5303193b3a.16.2026.06.01.00.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 00:12:39 -0700 (PDT)
From: "Naman Jain" <nmjain23@gmail.com>
X-Google-Original-From: Naman Jain <naman.jain@partner.bmw.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Naman Jain <namanj1@kpit.com>
Subject: [meta-lts-collab][kirkstone][PATCH] jq: Fix CVEs
Date: Mon,  1 Jun 2026 12:42:26 +0530
Message-Id: <20260601071226.2490096-1-naman.jain@partner.bmw.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 09:39:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4090

Fix the following CVEs-
CVE-2026-32316 CVE-2026-33947 CVE-2026-33948
CVE-2026-39979

Signed-off-by: Naman Jain <namanj1@kpit.com>
---
 .../jq/files/CVE-2026-32316.patch             |  55 +++++++++
 .../jq/files/CVE-2026-33947.patch             | 105 ++++++++++++++++++
 .../jq/files/CVE-2026-33948.patch             |  50 +++++++++
 .../jq/files/CVE-2026-39979.patch             |  33 ++++++
 meta-oe/recipes-devtools/jq/jq_%.bbappend     |   8 ++
 5 files changed, 251 insertions(+)
 create mode 100644 meta-oe/recipes-devtools/jq/files/CVE-2026-32316.patch
 create mode 100644 meta-oe/recipes-devtools/jq/files/CVE-2026-33947.patch
 create mode 100644 meta-oe/recipes-devtools/jq/files/CVE-2026-33948.patch
 create mode 100644 meta-oe/recipes-devtools/jq/files/CVE-2026-39979.patch
 create mode 100644 meta-oe/recipes-devtools/jq/jq_%.bbappend

diff --git a/meta-oe/recipes-devtools/jq/files/CVE-2026-32316.patch b/meta-oe/recipes-devtools/jq/files/CVE-2026-32316.patch
new file mode 100644
index 0000000..e36c500
--- /dev/null
+++ b/meta-oe/recipes-devtools/jq/files/CVE-2026-32316.patch
@@ -0,0 +1,55 @@
+From e47e56d226519635768e6aab2f38f0ab037c09e5 Mon Sep 17 00:00:00 2001
+From: itchyny <itchyny@cybozu.co.jp>
+Date: Thu, 12 Mar 2026 20:28:43 +0900
+Subject: [PATCH] Fix heap buffer overflow in `jvp_string_append` and
+ `jvp_string_copy_replace_bad`
+
+In `jvp_string_append`, the allocation size `(currlen + len) * 2` could
+overflow `uint32_t` when `currlen + len` exceeds `INT_MAX`, causing a small
+allocation followed by a large `memcpy`.
+
+In `jvp_string_copy_replace_bad`, the output buffer size calculation
+`length * 3 + 1` could overflow `uint32_t`, again resulting in a small
+allocation followed by a large write.
+
+Add overflow checks to both functions to return an error for strings
+that would exceed `INT_MAX` in length. Fixes CVE-2026-32316.
+
+CVE: CVE-2026-32316
+
+Upstream-Status: Backport [https://github.com/jqlang/jq/commit/e47e56d226519635768e6aab2f38f0ab037c09e5]
+
+Comment: Refreshed the orignal patch based on 1.6 version of jq-native
+
+Signed-off-by: Naman Jain <namanj1@kpit.com>
+---
+ src/jv.c | 11 ++++++++++-
+ 1 file changed, 10 insertions(+), 1 deletion(-)
+ 
+--- a/src/jv.c	2026-05-25 11:15:59.348305000 +0530
++++ b/src/jv.c	2026-05-25 11:26:08.995124976 +0530
+@@ -1103,7 +1103,12 @@ static jv jvp_string_copy_replace_bad(co
+   const char* i = data;
+   const char* cstart;
+ 
+-  uint32_t maxlength = length * 3 + 1; // worst case: all bad bytes, each becomes a 3-byte U+FFFD
++  // worst case: all bad bytes, each becomes a 3-byte U+FFFD
++  uint64_t maxlength = (uint64_t)length * 3 + 1;
++  if (maxlength >= INT_MAX) {
++    return jv_invalid_with_msg(jv_string("String too long"));
++  }
++  
+   jvp_string* s = jvp_string_alloc(maxlength);
+   char* out = s->data;
+   int c = 0;
+@@ -1163,6 +1168,10 @@ static uint32_t jvp_string_remaining_spa
+ static jv jvp_string_append(jv string, const char* data, uint32_t len) {
+   jvp_string* s = jvp_string_ptr(string);
+   uint32_t currlen = jvp_string_length(s);
++  if ((uint64_t)currlen + len >= INT_MAX) {
++    jv_free(string);
++    return jv_invalid_with_msg(jv_string("String too long"));
++  }
+ 
+   if (jvp_refcnt_unshared(string.u.ptr) &&
+       jvp_string_remaining_space(s) >= len) {
diff --git a/meta-oe/recipes-devtools/jq/files/CVE-2026-33947.patch b/meta-oe/recipes-devtools/jq/files/CVE-2026-33947.patch
new file mode 100644
index 0000000..6112d36
--- /dev/null
+++ b/meta-oe/recipes-devtools/jq/files/CVE-2026-33947.patch
@@ -0,0 +1,105 @@
+From fb59f1491058d58bdc3e8dd28f1773d1ac690a1f Mon Sep 17 00:00:00 2001
+From: itchyny <itchyny@cybozu.co.jp>
+Date: Mon, 13 Apr 2026 11:23:40 +0900
+Subject: [PATCH] Limit path depth to prevent stack overflow
+
+Deeply nested path arrays can cause unbounded recursion in
+`jv_setpath`, `jv_getpath`, and `jv_delpaths`, leading to
+stack overflow. Add a depth limit of 10000 to match the
+existing `tojson` depth limit. This fixes CVE-2026-33947.
+
+CVE: CVE-2026-33947
+
+Upstream-Status: Backport [https://github.com/jqlang/jq/commit/fb59f1491058d58bdc3e8dd28f1773d1ac690a1f]
+
+Comment: Refreshed the orignal patch based on 1.6 version of jq-native
+
+Signed-off-by: Naman Jain <namanj1@kpit.com>
+---
+ src/jv_aux.c  | 21 +++++++++++++++++++++
+ tests/jq.test | 25 +++++++++++++++++++++++++
+ 2 files changed, 46 insertions(+)
+
+diff -pur r/jv_aux.c f/jv_aux.c
+--- a/src/jv_aux.c	2026-05-25 11:49:59.581352000 +0530
++++ a/src/jv_aux.c	2026-05-25 12:06:47.329046949 +0530
+@@ -333,6 +333,10 @@ static jv jv_dels(jv t, jv keys) {
+   return t;
+ }
+ 
++#ifndef MAX_PATH_DEPTH
++#define MAX_PATH_DEPTH (10000)
++#endif
++
+ jv jv_setpath(jv root, jv path, jv value) {
+   if (jv_get_kind(path) != JV_KIND_ARRAY) {
+     jv_free(value);
+@@ -340,6 +344,12 @@ jv jv_setpath(jv root, jv path, jv value
+     jv_free(path);
+     return jv_invalid_with_msg(jv_string("Path must be specified as an array"));
+   }
++  if (jv_array_length(jv_copy(path)) > MAX_PATH_DEPTH) {
++    jv_free(value);
++    jv_free(root);
++    jv_free(path);
++    return jv_invalid_with_msg(jv_string("Path too deep"));
++  }
+   if (!jv_is_valid(root)){
+     jv_free(value);
+     jv_free(path);
+@@ -390,6 +400,11 @@ jv jv_getpath(jv root, jv path) {
+     jv_free(path);
+     return jv_invalid_with_msg(jv_string("Path must be specified as an array"));
+   }
++  if (jv_array_length(jv_copy(path)) > MAX_PATH_DEPTH) {
++    jv_free(root);
++    jv_free(path);
++    return jv_invalid_with_msg(jv_string("Path too deep"));
++  }
+   if (!jv_is_valid(root)) {
+     jv_free(path);
+     return root;
+@@ -467,6 +482,12 @@ jv jv_delpaths(jv object, jv paths) {
+       jv_free(elem);
+       return err;
+     }
++    if (jv_array_length(jv_copy(elem)) > MAX_PATH_DEPTH) {
++      jv_free(object);
++      jv_free(paths);
++      jv_free(elem);
++      return jv_invalid_with_msg(jv_string("Path too deep"));
++    }
+     jv_free(elem);
+   }
+   if (jv_array_length(jv_copy(paths)) == 0) {
+--- a/tests/jq.test	2026-05-25 11:50:00.028352000 +0530
++++ a/tests/jq.test	2026-05-25 12:08:36.488505815 +0530
+@@ -1736,3 +1736,28 @@ true
+ "Invalid numeric literal at EOF at line 1, column 7 (while parsing 'NaN1000')"
+ "Invalid numeric literal at EOF at line 1, column 8 (while parsing 'NaN10000')"
+ "Invalid numeric literal at EOF at line 1, column 9 (while parsing 'NaN100000')"
++
++# regression test for CVE-2026-33947
++setpath([range(10000) | 0]; 0) | flatten
++null
++[0]
++
++try setpath([range(10001) | 0]; 0) catch .
++null
++"Path too deep"
++
++getpath([range(10000) | 0])
++null
++null
++
++try getpath([range(10001) | 0]) catch .
++null
++"Path too deep"
++
++delpaths([[range(10000) | 0]])
++null
++null
++
++try delpaths([[range(10001) | 0]]) catch .
++null
++"Path too deep"
diff --git a/meta-oe/recipes-devtools/jq/files/CVE-2026-33948.patch b/meta-oe/recipes-devtools/jq/files/CVE-2026-33948.patch
new file mode 100644
index 0000000..c049ca6
--- /dev/null
+++ b/meta-oe/recipes-devtools/jq/files/CVE-2026-33948.patch
@@ -0,0 +1,50 @@
+From 6374ae0bcdfe33a18eb0ae6db28493b1f34a0a5b Mon Sep 17 00:00:00 2001
+From: itchyny <itchyny@cybozu.co.jp>
+Date: Mon, 13 Apr 2026 08:46:11 +0900
+Subject: [PATCH] Fix NUL truncation in the JSON parser
+
+This fixes CVE-2026-33948.
+
+CVE: CVE-2026-33948
+
+Upstream-Status: Backport [https://github.com/jqlang/jq/commit/6374ae0bcdfe33a18eb0ae6db28493b1f34a0a5b]
+
+Comment: Refreshed the orignal patch based on 1.6 version of jq-native
+
+Signed-off-by: Naman Jain <namanj1@kpit.com>
+---
+ src/util.c   | 8 +-------
+ tests/shtest | 6 ++++++
+ 2 files changed, 7 insertions(+), 7 deletions(-)
+
+diff -pur a/util.c b/util.c
+--- a/src/util.c	2026-05-25 12:17:04.234082000 +0530
++++ b/src/util.c	2026-05-25 12:27:35.908436178 +0530
+@@ -315,13 +315,7 @@ static int jq_util_input_read_more(jq_ut
+       if (p != NULL)
+         state->current_line++;
+ 
+-      if (p == NULL && state->parser != NULL) {
+-        /*
+-         * There should be no NULs in JSON texts (but JSON text
+-         * sequences are another story).
+-         */
+-        state->buf_valid_len = strlen(state->buf);
+-      } else if (p == NULL && feof(state->current_input)) {
++      if (p == NULL && feof(state->current_input)) {
+         size_t i;
+ 
+         /*
+--- a/tests/shtest	2026-05-25 12:17:04.236082000 +0530
++++ b/tests/shtest	2026-05-25 12:29:18.067642190 +0530
+@@ -332,4 +332,10 @@ JQ_COLORS="0123456789123:0123456789123:0
+ cmp $d/color $d/expect
+ cmp $d/warning $d/expect_warning
+ 
++# CVE-2026-33948: No NUL truncation in the JSON parser
++if printf '{}\x00{}' | $JQ >/dev/null 2> /dev/null; then
++  printf 'Error expected but jq exited successfully\n' 1>&2
++  exit 1
++fi
++
+ exit 0
diff --git a/meta-oe/recipes-devtools/jq/files/CVE-2026-39979.patch b/meta-oe/recipes-devtools/jq/files/CVE-2026-39979.patch
new file mode 100644
index 0000000..2e39487
--- /dev/null
+++ b/meta-oe/recipes-devtools/jq/files/CVE-2026-39979.patch
@@ -0,0 +1,33 @@
+From 2f09060afab23fe9390cce7cb860b10416e1bf5f Mon Sep 17 00:00:00 2001
+From: itchyny <itchyny@cybozu.co.jp>
+Date: Mon, 13 Apr 2026 11:04:52 +0900
+Subject: [PATCH] Fix out-of-bounds read in jv_parse_sized()
+
+This fixes CVE-2026-39979.
+
+Co-authored-by: Mattias Wadman <mattias.wadman@gmail.com>
+
+CVE: CVE-2026-39979
+
+Upstream-Status: Backport [https://github.com/jqlang/jq/commit/2f09060afab23fe9390cce7cb860b10416e1bf5f]
+
+Signed-off-by: Naman Jain <namanj1@kpit.com>
+---
+ src/jv_parse.c | 3 ++-
+ 1 file changed, 2 insertions(+), 1 deletion(-)
+
+diff --git a/src/jv_parse.c b/src/jv_parse.c
+index aa2054cc09..56847b5eaa 100644
+--- a/src/jv_parse.c
++++ b/src/jv_parse.c
+@@ -893,8 +893,9 @@ jv jv_parse_sized_custom_flags(const char* string, int length, int flags) {
+ 
+   if (!jv_is_valid(value) && jv_invalid_has_msg(jv_copy(value))) {
+     jv msg = jv_invalid_get_msg(value);
+-    value = jv_invalid_with_msg(jv_string_fmt("%s (while parsing '%s')",
++    value = jv_invalid_with_msg(jv_string_fmt("%s (while parsing '%.*s')",
+                                               jv_string_value(msg),
++                                              length,
+                                               string));
+     jv_free(msg);
+   }
diff --git a/meta-oe/recipes-devtools/jq/jq_%.bbappend b/meta-oe/recipes-devtools/jq/jq_%.bbappend
new file mode 100644
index 0000000..2eba699
--- /dev/null
+++ b/meta-oe/recipes-devtools/jq/jq_%.bbappend
@@ -0,0 +1,8 @@
+FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
+
+SRC_URI += "\
+    file://CVE-2026-32316.patch \
+    file://CVE-2026-33947.patch \
+    file://CVE-2026-33948.patch \
+    file://CVE-2026-39979.patch \
+    "
-- 
2.34.1


