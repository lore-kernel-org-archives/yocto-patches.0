Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6ADC83F17
	for <webhook@archiver.kernel.org>; Fri, 18 Jul 2025 14:11:23 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.web11.22067.1752847873682369345
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 18 Jul 2025 07:11:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=AH7pJlHI;
 spf=pass (domain: konsulko.com, ip: 209.85.222.174, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e32c95775aso206337185a.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 18 Jul 2025 07:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1752847872; x=1753452672; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyfwPjr4aiDBcR7zyq8OiX3qeV3uJUV0T463+JFxXtk=;
        b=AH7pJlHIsG9KvUoO4YJBBBqokriDKigYVi7XOXcWRELmTCh+1YadLI4220U/tS+WQn
         SPnMjUxlc4um0T67P5u7LZGfczwQ7S6WEqC0aMekRfAlwZnGNbkEqQ3rOz9UJlCDaKXA
         yA6c8m9i5HSK8TTo0cxKaBhWgUBHGEPmtMWz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752847872; x=1753452672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JyfwPjr4aiDBcR7zyq8OiX3qeV3uJUV0T463+JFxXtk=;
        b=iJTawrNYB2+uFnaUjTjgaWKjGKr3MKr6kS1VQojaVeyVeFxCjlXoJcNapehGxVszBa
         xbMpyZN5O5Rx02vyLxJQQvNPydbUFZz2MLUdUxLYdDATK9Ztwzc2zXGjl6FtkOqalHxs
         DCdlGPml6HIUS3bh9awb42c5RgB4Tv3jXNzwyWwFw7rrPZdP3ZM4cma1UaoZn9uH5OMj
         g1xwviDnOxKwSfoMADkIuefluDsd2Q4uWWuQu+H87NzFr8RVVLQseU0RXloGTc0LN2TZ
         2iwQp/m0eiSNHTU8LXc1FbCTUgFlSJSvsiWN74UlJGhms9Ign6WNUTksB1OIT2EvVb7v
         4hmg==
X-Gm-Message-State: AOJu0YxJb8Bowy0nKCh+g7XZPLsFXEJXaZds5Apv5wnF/NiK38IEZ3kO
	j+Ade4JKGjC/tuHTEX6O957n0DzIuDLIu77Ddk+vN90MgGQ/DnSrMnE0EIZgHn6AZUkA8POCUXC
	FMgIt
X-Gm-Gg: ASbGncuxw82hF6epWTjiO+VOilVFdhIzr8/sJ68APchv9jr6239fxyS/onhjnsu62jj
	UsiuZQZElT7Iq4cLFuYpHIKxvSZQ+EUdIyjdTJpL2ClX0+H6ELBdu3JHifSTiWYQy6NgIUlQh5a
	AXW5Yg8+ae5KyrXPoQetkexC0O+wyZwAuCJ4JYeTQfMnymeJyQctlJevNCBZyXWKbI0+1r2QuWJ
	ggjdLc2WVYAkHi7BVg+bJy7frqSOrr79W/+dZ4V2T6+juLNuIiAjltMyDfsk327hmUzv1ncrx8a
	kyUaO6WYAhP2WZ0r8pQvZnq3o8pBlES91WuFvHsnqB7zmjQyCUQ2OMhjXDGAL2VcFqWIASCTkbj
	hankihb42APfKd+Bx8FjWYYQlnB7o1cvi3VSv2aQ+l7tvE9EdYdSZtxnJvQuG0+bmFS6JySCgHw
	==
X-Google-Smtp-Source: AGHT+IF3LI6wrq4yAK5ghkAVgOGhpO0HSQsfrNcDIJ2hXYcbfVwGxPF9YEfGHsmv5cyOq77pEAgMNg==
X-Received: by 2002:a05:620a:7109:b0:7e3:4b99:9e7e with SMTP id af79cd13be357-7e34b99a4ebmr1249544285a.25.1752847872290;
        Fri, 18 Jul 2025 07:11:12 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356a0732dsm92368785a.0.2025.07.18.07.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 07:11:12 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: marta.rybczynska@ygreky.com
Subject: [meta-security][PATCH 4/4] samhain: Adapt test output to Automake format for ptest compatibility
Date: Fri, 18 Jul 2025 10:10:59 -0400
Message-ID: <06bd60600e8db1b843cf5cc0f074a11eac7e9a80.1752846514.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752846514.git.scott.murray@konsulko.com>
References: <cover.1752846514.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 18 Jul 2025 14:11:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1815

From: Haixiao Yan <haixiao.yan.cn@windriver.com>

Convert CuTest output to follow Automake-compatible format
(PASS:/FAIL:) so that ptest-runner can correctly parse and
report test results.

root@qemux86-64:~# ptest-runner samhain-standalone -t 3600
START: ptest-runner
2025-07-06T09:38
BEGIN: /usr/lib64/samhain-standalone/ptest
PASS: Test_quote_string_ok
PASS: Test_unquote_string_ok
PASS: Test_csv_escape_ok
PASS: Test_tiger
PASS: Test_tiger_file
PASS: Test_tiger_file_with_length
PASS: Test_sh_tools_safe_name_01
PASS: Test_sh_tools_safe_name_02
PASS: Test_sh_tools_safe_name_03
PASS: Test_sh_tools_safe_name_04
PASS: Test_sh_tools_safe_name_05
PASS: Test_sh_tools_safe_name_06
PASS: Test_sh_tools_safe_name_07
PASS: Test_is_numeric_01
PASS: Test_dnmalloc
PASS: Test_sh_unix_lookup_page
PASS: Test_sl_strlcpy
PASS: Test_sl_strlcat
PASS: Test_sh_util_acl_compact
PASS: Test_sh_util_strdup_ok
PASS: Test_sh_util_strconcat_ok
PASS: Test_sh_util_base64_enc_ok
PASS: Test_sh_util_dirname_ok
PASS: Test_sh_util_basename_ok
PASS: Test_sh_util_utf8_ok
PASS: Test_sh_util_obscure_ok
PASS: Test_sl_stale
PASS: Test_sl_snprintf
PASS: Test_sl_ts_strncmp
PASS: Test_sl_strcasecmp
PASS: Test_zAVLTree
PASS: Test_sha256
PASS: Test_entropy
PASS: Test_fifo
PASS: Test_file_lists
PASS: Test_file_dequote
PASS: Test_uuid
PASS: Test_ignore_ok
PASS: Test_inotify
PASS: Test_ipvx
PASS: Test_login
PASS: Test_login
PASS: Test_portcheck_lists
PASS: Test_processcheck_watchlist_ok
PASS: Test_processcheck_listhandle_ok
PASS: Test_restrict
PASS: Test_cmdlist
PASS: Test_srp
PASS: Test_string

DURATION: 0
END: /usr/lib64/samhain-standalone/ptest
2025-07-06T09:38
STOP: ptest-runner
TOTAL: 1 FAIL: 0
root@qemux86-64:~#

Signed-off-by: Haixiao Yan <haixiao.yan.cn@windriver.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...t-output-to-match-Automake-standards.patch | 102 ++++++++++++++++++
 recipes-ids/samhain/samhain.inc               |   1 +
 2 files changed, 103 insertions(+)
 create mode 100644 recipes-ids/samhain/files/0001-Format-test-output-to-match-Automake-standards.patch

diff --git a/recipes-ids/samhain/files/0001-Format-test-output-to-match-Automake-standards.patch b/recipes-ids/samhain/files/0001-Format-test-output-to-match-Automake-standards.patch
new file mode 100644
index 0000000..eccd242
--- /dev/null
+++ b/recipes-ids/samhain/files/0001-Format-test-output-to-match-Automake-standards.patch
@@ -0,0 +1,102 @@
+From 065813e5ec274942c4e8803d813ae863fb17313f Mon Sep 17 00:00:00 2001
+From: Haixiao Yan <haixiao.yan.cn@windriver.com>
+Date: Sun, 6 Jul 2025 14:34:08 +0800
+Subject: [PATCH] Format test output to match Automake standards
+
+Upstream-Status: Pending
+
+Signed-off-by: Haixiao Yan <haixiao.yan.cn@windriver.com>
+---
+ src/CuTest.c      | 63 +++++++++++++++--------------------------------
+ src/make-tests.sh |  1 -
+ 2 files changed, 20 insertions(+), 44 deletions(-)
+
+diff --git a/src/CuTest.c b/src/CuTest.c
+index c1884daedbd8..44007fdb97ff 100644
+--- a/src/CuTest.c
++++ b/src/CuTest.c
+@@ -302,49 +302,26 @@ void CuSuiteRun(CuSuite* testSuite)
+ 	}
+ }
+ 
+-void CuSuiteSummary(CuSuite* testSuite, CuString* summary)
+-{
+-	int i;
+-	for (i = 0 ; i < testSuite->count ; ++i)
+-	{
+-		CuTest* testCase = testSuite->list[i];
+-		CuStringAppend(summary, testCase->failed ? "F" : ".");
+-	}
+-	CuStringAppend(summary, "\n\n");
+-}
+-
+ void CuSuiteDetails(CuSuite* testSuite, CuString* details)
+ {
+-	int i;
+-	int failCount = 0;
+-
+-	if (testSuite->failCount == 0)
+-	{
+-		int passCount = testSuite->count - testSuite->failCount;
+-		const char* testWord = passCount == 1 ? "test" : "tests";
+-		CuStringAppendFormat(details, "OK (%d %s)\n", passCount, testWord);
+-	}
+-	else
+-	{
+-		if (testSuite->failCount == 1)
+-			CuStringAppend(details, "There was 1 failure:\n");
+-		else
+-			CuStringAppendFormat(details, "There were %d failures:\n", testSuite->failCount);
+-
+-		for (i = 0 ; i < testSuite->count ; ++i)
+-		{
+-			CuTest* testCase = testSuite->list[i];
+-			if (testCase->failed)
+-			{
+-				failCount++;
+-				CuStringAppendFormat(details, "%d) %s: %s\n",
+-					failCount, testCase->name, testCase->message);
+-			}
+-		}
+-		CuStringAppend(details, "\n!!!FAILURES!!!\n");
+-
+-		CuStringAppendFormat(details, "Runs: %d ",   testSuite->count);
+-		CuStringAppendFormat(details, "Passes: %d ", testSuite->count - testSuite->failCount);
+-		CuStringAppendFormat(details, "Fails: %d\n",  testSuite->failCount);
+-	}
++    int i;
++
++    for (i = 0; i < testSuite->count; ++i)
++    {
++        CuTest* testCase = testSuite->list[i];
++        if (testCase->failed)
++        {
++            CuStringAppendFormat(details, "FAIL: %s\n", testCase->name);
++        }
++        else
++        {
++            CuStringAppendFormat(details, "PASS: %s\n", testCase->name);
++        }
++    }
++
++    CuStringAppend(details, "\n");
++    CuStringAppendFormat(details, "# TOTAL: %d\n", testSuite->count);
++    CuStringAppendFormat(details, "# PASS:  %d\n", testSuite->count - testSuite->failCount);
++    CuStringAppendFormat(details, "# FAIL:  %d\n", testSuite->failCount);
+ }
++
+diff --git a/src/make-tests.sh b/src/make-tests.sh
+index b6cf814e7030..01399ca75775 100755
+--- a/src/make-tests.sh
++++ b/src/make-tests.sh
+@@ -45,7 +45,6 @@ cat $FILES | grep '^void Test' |
+ echo \
+ '
+     CuSuiteRun(suite);
+-    CuSuiteSummary(suite, output);
+     CuSuiteDetails(suite, output);
+     if (suite->failCount > 0)
+       fprintf(stderr, "%s%c", output->buffer, 0x0A);
+-- 
+2.34.1
+
diff --git a/recipes-ids/samhain/samhain.inc b/recipes-ids/samhain/samhain.inc
index 6b8d30e..fc4e423 100644
--- a/recipes-ids/samhain/samhain.inc
+++ b/recipes-ids/samhain/samhain.inc
@@ -19,6 +19,7 @@ SRC_URI = "https://la-samhna.de/archive/samhain_signed-${PV}.tar.gz \
            file://0008-Add-LDFLAGS-variable-for-compiling-samhain_setpwd.patch \
            file://0009-fix-build-with-new-version-attr.patch \
            file://0010-Fix-initializer-element-is-not-constant.patch \
+           file://0001-Format-test-output-to-match-Automake-standards.patch \
            "
 
 SRC_URI[sha256sum] = "0b5d3534fd60ecf45dfd79bd415e81f7a56eba7f1755771735e204f334033578"
-- 
2.50.0


