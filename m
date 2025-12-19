Return-Path: <ghaderer@wyplay.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10700D78783
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 14:06:10 +0000 (UTC)
Received: from mail-ed1-f100.google.com (mail-ed1-f100.google.com [209.85.208.100])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17396.1766153164000275155
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 19 Dec 2025 06:06:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@wyplay.com header.s=google header.b=sCQ/TCcL;
 spf=pass (domain: wyplay.com, ip: 209.85.208.100, mailfrom: ghaderer@wyplay.com)
Received: by mail-ed1-f100.google.com with SMTP id 4fb4d7f45d1cf-64ba74e6892so774089a12.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 19 Dec 2025 06:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wyplay.com; s=google; t=1766153162; x=1766757962; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jT0iuyxa6aTYoTU+JrbUBkNck/+iaetYN6jDxbRkusM=;
        b=sCQ/TCcLPzEBQMqd3j4Sgl0UhqYsafSHUNIx3I6jNZpTu6cB/pXOjCxdbAtsSN4lhL
         WAB5Qu45m+gbJqkMQlZ+vvne1poZA+gdv93sQwYWC6BWg7njly9awD7y+v9OGLNYUObE
         Lqm0Z8GHYrcwYiRyCKJzwje0zeqgpa+gmzkio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766153162; x=1766757962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jT0iuyxa6aTYoTU+JrbUBkNck/+iaetYN6jDxbRkusM=;
        b=ChMbKnxESeYC73c++aqX++Og52OIlD4ztK+jAhYsvcgYMHa7k/fYdwjasWAv15bqlg
         S1OP6RKIhy/IaES4xy83BWVVwl2AYhkl7J1FbWC1HXd3TaAeN30lCXna0TczcBLmCva8
         NhbFYWWnYXRB2bb4Wwv4HsDo7J28GW6jHVmShDAgpKv+lmCdugw6IHUrVeWJRNwX7kgz
         QI26ox3VpbeT44TvEPthYe+IQQh+J/MJ33+iXJCw4vzB5LL/nLOyi8Z9BI0MZpNH1yyk
         xIipEkscX9clsrk4Tht495MYkMvRXBmds74+QrsumNs+OTi9zjn4mKSUzDTC+Ikj1T/f
         jTCg==
X-Gm-Message-State: AOJu0Yw05sy1tAlmhyPHXRpW3ClFc2ztq/9wRt5+3pGrAiH+wQu+RHeG
	tBErFVbIN4c7whl4kznQI8ICsDpShXRQ92FPUq+X0zEMrPEOoGWSCQNClAmhDlKnV5VK6wusoRE
	A9+j/WSSdswvzQbh28CYnvvmDOnhs3eAYwdVOU3f53/kk
X-Gm-Gg: AY/fxX70eWcqnwfv1Ws9FPM3qS6pmeEUwYkqsBmvnFe21kfWAxP9UhFFRhb2L8kEJn3
	uDZEm3loaoHj3JitVszEgpvCX1xgSrzWrbgVndZXHIK/NLAtcCZFkZKAinUzUOOz+b/m7jrtwQS
	sijvd/kJWVs/lQwMcMHUY3PjR/qeuONyRvIMLC8LjknlIEU55JbVNKshDZzxKXWsCD2t6Vi78Mq
	pYsfZf5KcpTrNL0aRRS+p31OXgIi1b6RHbwj2CC1RUk63orsgaJ9J9ZvcupzVyqNg5rc47LC7hD
	pOBsNjuxGk82DSEHoynvaepYxOwrDYjP3b2bXNHkswqQQC6ktkD4pX/8OSw1VBaONJeW8QvtgJI
	Y9crS+ISdLh5XD7JEhgE=
X-Google-Smtp-Source: AGHT+IEert70yA0dI8n6yRtNclv5WEU4KqOZLBSCzYF1epL2xQFgLPA5RdetoPylZfrxkVjZ6tI/ANjDoZQd
X-Received: by 2002:a17:907:6d07:b0:b7a:1637:bd75 with SMTP id a640c23a62f3a-b80371d3473mr327104666b.46.1766153161990;
        Fri, 19 Dec 2025 06:06:01 -0800 (PST)
Received: from s5lxsystem04.wyplay.int ([5.50.77.90])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-b8037a0ecacsm19063966b.17.2025.12.19.06.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 06:06:01 -0800 (PST)
X-Relaying-Domain: wyplay.com
Received: from ghaderer-laptop.home (unknown [10.60.225.18])
	by s5lxsystem04.wyplay.int (Postfix) with ESMTP id 69CBAFF313;
	Fri, 19 Dec 2025 15:06:01 +0100 (CET)
From: Gauthier HADERER <ghaderer@wyplay.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Gauthier HADERER <ghaderer@wyplay.com>
Subject: [pseudo] [PATCH] unix: realpath fails if the resolved path doesn't exist.
Date: Fri, 19 Dec 2025 15:06:00 +0100
Message-ID: <20251219140600.212527-1-ghaderer@wyplay.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 19 Dec 2025 14:06:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2834

The pseudo implementation of `realpath()' may return a path which doesn't
exist. This is not POSIX compliant and causes troubles with uutils (coreutils
in Rust).

For example, the tail commands tries to determine the file path of its standard
input file descriptor by calling `realpath("/dev/fd/0")'. When the input is a
pipe, the GNU C library returns NULL but pseudo returns
`/proc/<pid>/fd/pipe:[xxxxxx]'. As it got a path, the tail command tries to
open it and fails.

Upstream-Status: Pending
---
 ports/unix/guts/realpath.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/ports/unix/guts/realpath.c b/ports/unix/guts/realpath.c
index 8d8118b..ee7d409 100644
--- a/ports/unix/guts/realpath.c
+++ b/ports/unix/guts/realpath.c
@@ -14,6 +14,14 @@
 		errno = ENAMETOOLONG;
 		return NULL;
 	}
+
+	/* We must fail if the target path doesn't exist. */
+	struct stat buf;
+
+	if (base_lstat(rname, &buf) == -1) {
+		return NULL;
+	}
+
 		len = strlen(rname);
 		char *ep = rname + len - 1;
 		while (ep > rname && *ep == '/') {
-- 
2.52.0


