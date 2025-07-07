Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE981C8303C
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 14:44:00 +0000 (UTC)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
 by mx.groups.io with SMTP id smtpd.web11.69.1751899434748132532
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Jul 2025 07:43:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=M1anz0PT;
 spf=pass (domain: limonsoftware.com, ip: 209.85.167.172, mailfrom: anibal@limonsoftware.com)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-40a4bf1ebb7so1857397b6e.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Jul 2025 07:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1751899434; x=1752504234; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=thy6inCuIk9Kk8QH1qvdvrIaetmEjBseKVo5sDDrPlo=;
        b=M1anz0PTFbt/uk159CryiptfxD/xU20RSxspGmmb+fF0+XJcpHrPTd4gdAs47+uTF2
         YWfguB/04N9xhltr7EDBLktO+m1bPEszVaIJwvyIK2AJoN+D46FEra8Fx055G6TXOsmO
         VLyS6HTR25AqDSbiICqyJW8aHz6cFlyvQMDsmgvmmOrKHZ0sZNxZfHlJPaWh27CbwcjE
         tLYqMUUt34h9pA3QhcK4dNF6XEwJst+5esL03d5fCvd2VgWnEohLkjPW4/III5vY+NIn
         dDXfCgJJdbra0eJCBt5BTyVq4DO9PFA4HvxbNeb89bnFPF5Qeigf0m1FwtTCKcawZ2tu
         w2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751899434; x=1752504234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=thy6inCuIk9Kk8QH1qvdvrIaetmEjBseKVo5sDDrPlo=;
        b=FY/rDBTsj2cgrN9CkhkAwPmzNXArmGFNYqpVEEtloMRHBwUKnkGtBGtF9D31qfRfUY
         fUyA9XVAsS3A4k9mg1YkyyL2zmZJnsbUkWKP0VDCSIhwSdrM/Gd9/UPG9JeiCfVjK/Jb
         2MnvWmKo5vTxSV5p3fMZeekKpQTwQwkfPMAppIBVh1rlL5SzTr57X8zwV83lvLpvmGzY
         b1xMgiIZw5mwYFGHwAvFCStZNSSPkdLhSAilddBUPHQkpPvC1N96mW4DHoQwOZbkzDYS
         o2BnkC5Q1rCHbXRbK/JNP592sJyxRTdhVN+ANKyw85h8UyPpeP8D0/vURZZ8O4VAwCgC
         C3Yw==
X-Gm-Message-State: AOJu0YwBPqVNrcxz/Gns52GQfgtkNeN6FpWzLzv7Riq9vuXQh3u9lQHe
	eHdlF9Qf1MPfQTtdt+CpHxCsvRJbCBzfZSNu8Y4UC08//9lxsqFEGlTnD6d2D3bq/rLL+GLM5OZ
	04+zPDqa0oA==
X-Gm-Gg: ASbGncueBBIfWeqxP6zVEtSjUpCWaCnvCwIX5aWXrN6W2UcWw6oeSBzzRBNECXxHdkI
	LMHOa9FPWn/l7isRBeEIbwCJwEri39wmO5Cnr89vaF/dmSnyRfvV8u7LzGgfLQDIrLrDA+3RPCz
	4N3mxX2Mk55rvjGb3wtsz1lcRLgVLEAWzW0/eegvhdAZE3WPNqxqrXIvx1XhmTZjwPJHoyTdlKH
	GbloXzMgVhxsulF6GHH8rMcouavh7J7TXbNhxSdaZOmJCnKhCOgRilMweTv8PHCeL31yYmdzkvL
	pbVS+/mYj+O087epb+Jr0LoKdsvbjMKNYYrrMnDQtP1H5c+kvCSALvPgDoTF1wibYoQ=
X-Google-Smtp-Source: AGHT+IEOOFfjSPDhYDNGJHMt3f8WjucKhlnkFM2m4T0NeS8OtPoHafgIj/aEe6BWY4n0RFBx228GRQ==
X-Received: by 2002:a05:6808:1250:b0:409:f8e:7297 with SMTP id 5614622812f47-40d071d3a11mr7799820b6e.0.1751899433710;
        Mon, 07 Jul 2025 07:43:53 -0700 (PDT)
Received: from ls.ts.net ([189.162.146.188])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40d02adb990sm1325955b6e.38.2025.07.07.07.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 07:43:53 -0700 (PDT)
From: Anibal Limon <anibal@limonsoftware.com>
To: yocto-patches@lists.yoctoproject.org
Cc: erik.schumacher@iris-sensing.com,
	yoann.congal@smile.fr,
	joerg.sommer@navimatix.de,
	nata.dobrick@gmail.com,
	Anibal Limon <anibal@limonsoftware.com>
Subject: [ptest-runner][PATCH] Makefile: Improvements on rules mainly check (unittest)
Date: Mon,  7 Jul 2025 14:43:50 +0000
Message-Id: <20250707144350.2013683-1-anibal@limonsoftware.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Jul 2025 14:44:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1777

Commnly we built ptest-runner without unittest, so by default
only build ptest-runner executable (all target).
Move the -pthread flag into common CFLAGS upon.

Add pkg-config and check tests to let know the user this components
are expected to be in the system when build and/or run tests using
check.

Drop redundant tests rule and only keep check rule, if only wanna
build the ptest-runner-test executable can be made explicitly.

```
devel@ls:~/ptest-runner2$ make ptest-runner-test
devel@ls:~/ptest-runner2$ ./ptest-runner-test
Usage: ./ptest-runner-test <-d directory>

```

The check rule stay the same when execute it it builts ptest-runner-test
and execute unittests suite.

```
devel@ls:~/ptest-runner2$ make check
PATH=".:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games" ptest-runner-test -d /workspace/ptest-runner2/tests/data
Running suite(s): ptest_list
100%: Checks: 9, Failures: 0, Errors: 0
tests/ptest_list.c:47:P:Core:test_alloc_free:0: Passed
tests/ptest_list.c:55:P:Core:test_add:0: Passed
tests/ptest_list.c:66:P:Core:test_free_all:0: Passed
tests/ptest_list.c:89:P:Core:test_length:0: Passed
tests/ptest_list.c:110:P:Core:test_search:0: Passed
tests/ptest_list.c:143:P:Core:test_remove:0: Passed
tests/ptest_list.c:165:P:Core:test_remove_first:0: Passed
tests/ptest_list.c:188:P:Core:test_remove_last:0: Passed
tests/ptest_list.c:203:P:Core:test_remove_all:0: Passed
Running suite(s): utils
dmesg: read kernel buffer failed: Operation not permitted
XML File './' could not be created. Is a directory.
100%: Checks: 9, Failures: 0, Errors: 0
tests/utils.c:88:P:Core:test_get_available_ptests:0: Passed
tests/utils.c:134:P:Core:test_print_ptests:0: Passed
tests/utils.c:161:P:Core:test_filter_ptests:0: Passed
tests/utils.c:193:P:Core:test_run_ptests:0: Passed
tests/utils.c:224:P:Core:test_run_timeout_duration_ptest:0: Passed
tests/utils.c:254:P:Core:test_run_signal_ptest:0: Passed
tests/utils.c:284:P:Core:test_run_fail_ptest:0: Passed
tests/utils.c:328:P:Core:test_xml_pass:0: Passed
tests/utils.c:338:P:Core:test_xml_fail:0: Passed
```

Signed-off-by: Anibal Limon <anibal@limonsoftware.com>
---
 Makefile | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/Makefile b/Makefile
index 662ced7..7ad4161 100644
--- a/Makefile
+++ b/Makefile
@@ -17,35 +17,46 @@ endif
 ifeq ($(MEMCHECK), 1)
 CFLAGS+= -DMEMCHECK
 endif
+CFLAGS+= -pthread
 LDFLAGS=
 
 BASE_SOURCES=utils.c ptest_list.c
-SOURCES=main.c $(BASE_SOURCES)
+BASE_OBJECTS=$(BASE_SOURCES:.c=.o)
+SOURCES=main.c
 OBJECTS=$(SOURCES:.c=.o)
 EXECUTABLE=ptest-runner
 
-TEST_SOURCES=tests/main.c tests/ptest_list.c tests/utils.c $(BASE_SOURCES)
+PKGCONFIG_BIN:=pkg-config
+CHECK_LIB:=check
+TEST_SOURCES=tests/main.c tests/ptest_list.c tests/utils.c
 TEST_OBJECTS=$(TEST_SOURCES:.c=.o)
 TEST_EXECUTABLE=ptest-runner-test
-TEST_CFLAGS=$(shell pkg-config --cflags check)
-TEST_LDFLAGS=$(shell pkg-config --libs check)
+TEST_CFLAGS=$(shell $(PKGCONFIG_BIN) --cflags $(CHECK_LIB) 2>/dev/null)
+TEST_LDFLAGS=$(shell $(PKGCONFIG_BIN) --libs $(CHECK_LIB) 2>/dev/null)
 
 TEST_DATA=$(shell echo `pwd`/tests/data)
 
-all: $(SOURCES) $(EXECUTABLE)
-
-$(EXECUTABLE): $(OBJECTS)
-	$(CC) $(LDFLAGS) $(OBJECTS) -pthread -lutil -o $@
-
-tests: $(TEST_SOURCES) $(TEST_EXECUTABLE)
-
-$(TEST_EXECUTABLE): $(TEST_OBJECTS)
-	$(CC) $(LDFLAGS) $(TEST_OBJECTS) -o $@ $(TEST_CFLAGS) $(TEST_LDFLAGS)
+all: $(EXECUTABLE)
 
 check: $(TEST_EXECUTABLE)
-	PATH=.:$(PATH) ./$(TEST_EXECUTABLE) -d $(TEST_DATA)
+	PATH=".:$(PATH)" $(TEST_EXECUTABLE) -d $(TEST_DATA)
 
 clean:
-	rm -rf $(EXECUTABLE) $(OBJECTS) $(TEST_EXECUTABLE) $(TEST_OBJECTS)
+	rm -rf $(BASE_OBJECTS) $(EXECUTABLE) $(OBJECTS) $(TEST_EXECUTABLE) $(TEST_OBJECTS)
+
+$(EXECUTABLE): $(BASE_OBJECTS) $(OBJECTS)
+	$(CC) $(LDFLAGS) $^ -o $@
+
+$(TEST_EXECUTABLE): $(BASE_OBJECTS) $(TEST_OBJECTS)
+ifeq ($(shell command -v $(PKGCONFIG_BIN)),)
+	$(error Please install `$(PKGCONFIG_BIN)`, use to get compilation flags.)
+endif
+ifeq ($(TEST_LDFLAGS),)
+	$(error Please install `$(CHECK_LIB)`, can't get LDFLAGS via pkg-config.)
+endif
+ifeq ($(TEST_CFLAGS),)
+	$(error Please install `$(CHECK_LIB)`, can't get CFLAGS via pkg-config.)
+endif
+	$(CC) $(TEST_CFLAGS) $^ -o $@ $(LDFLAGS) $(TEST_LDFLAGS)
 
-.PHONY: clean tests
+.PHONY: all check clean
-- 
2.39.5


