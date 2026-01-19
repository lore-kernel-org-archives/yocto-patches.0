Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B186D2ECE0
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 20:32:03 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44164.1768854722002903918
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Jan 2026 12:32:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=czxee89h;
 spf=pass (domain: konsulko.com, ip: 209.85.222.180, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c52c67f64cso496809485a.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 12:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1768854721; x=1769459521; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sG9WQ72C7eXpo4d0eRDXDrqmNRigG8E1WcVwNewoU0E=;
        b=czxee89hS93ikmqWyFv6CLz9FQ58U/+GMpq1WTjaGQX8IcnMovD6Rw4OOvWB4xKPdR
         Ht4GKWsOoD603s51QjepXiTPaI7cCC/wY9TW5vwNNUo96CEQhW+1Hg5CYD2ysslV0IfD
         40iuwkfC5aXDD3FINqzfivwnA84AVyNF/JQXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768854721; x=1769459521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sG9WQ72C7eXpo4d0eRDXDrqmNRigG8E1WcVwNewoU0E=;
        b=SrK3V3pYNcvOw0VEHp1vN8OBDMIpFw8I9b5jYWJLtu1g7n45ZuypJkXurcUQmOL4YP
         h8fsY/5jbRXml7U4PzTv6/A3QIgVqxYn5YbA04KoKi72qqW8RQj7RMu+51WjcZvYQv8u
         MuaN+kZJwmBZHTTDevDufp8DnX+99V2fCMMU2H08l6o7MDFH8SUCa6YtKrhEpAdqYzwY
         Wqoe8TArT5RWa6tLyo9tz0uZq/p8WLnDHeSyVQfOs993YxrrwS7pOjt0dJTl5KjoJiNN
         GtOT31iqy0itOf0kNwMcv+g6PWO9mMeGtw0eL/WtnflRUxl23HhvF2ZptWtc0tJ/jzgU
         hxlw==
X-Gm-Message-State: AOJu0Yx1HljuRL5Dmo0fcIIUO6frbUK4/OVsDPJbFc06sKuVERZ77lXB
	8QsESQ5USvFQ9pLICFxxVy8oZO27UeqOB5xIUb3HcNUYJn28CyfYnmuBWNamxeW5vYPOKDZ0l8T
	WoczF
X-Gm-Gg: AY/fxX4mOji+H8afeAADOAMSQv9eAQpIT/PnO7peTVMgM4gzA8x4N1vTRCn+swh2C8f
	BJzln3/MeOkSKz3G48Ic7P6Bq7KesRcqeHaVA81HmQVPxxDUkjoFloDCbWDleKiYV8eA5tKlcXe
	OPuemnQkoNW31ezI2MlZUKiCBDkfU8sCb26Jg47h/jfzuZ2ssJlud7qoMc5aiSLbF2VsZuwuDGJ
	aViNCizsrLLji9DTUi4yuUC2/cmfrV/snA6Yzcbswgwtg4bWATAA0aOOpFFBfylxPd3gXMS0FyI
	RP2ud9jjvfK9687vo1/rEGC8CKir5INbYh2eCmMFGO1/rrWur8Xpw9HCo9my98O9jJZsr70fOvF
	GvT5H93yDss7LDVDKwTmZGl9RRFc+9mYtjpLExOx1lIPvLm439YfJs6HUtsYAPCRzpc4T58bxx7
	seKBBJ4hvSip8iph2vpRIXoyfmBzYRa3UXFaYG00Do3La/xSmoN/6K2Cr/fwexaFF1tOLQajT7s
	Q9tVc2T10cmtxlbGSFBx8GgPXHmqFSJ0zfdjqowGDc/g/+5kckc
X-Received: by 2002:a05:620a:2947:b0:897:56e7:6aa3 with SMTP id af79cd13be357-8c6a676db0amr1705991885a.56.1768854720714;
        Mon, 19 Jan 2026 12:32:00 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a7248dcfsm860337485a.25.2026.01.19.12.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 12:32:00 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: [meta-lts-security][whinlatter][PATCH 2/3] suricata: add PACKAGECONFIG[seccomp] - MemoryDenyWriteExecute
Date: Mon, 19 Jan 2026 15:31:52 -0500
Message-ID: <252f97af420cd170c37f3c33c2c1e86afeaa25f5.1768854613.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1768854613.git.scott.murray@konsulko.com>
References: <cover.1768854613.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 20:32:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3020

From: Clayton Casciato <majortomtosourcecontrol@gmail.com>

Add option to prevent memory mappings that are both writable and
executable.

https://www.freedesktop.org/software/systemd/man/255/systemd.exec.html#MemoryDenyWriteExecute=

Core Suricata developer:
https://github.com/jasonish/suricata-rpms/blob/a606a810325dd0a4f3ee45b2756b96bda28e590b/7.0/suricata-4.1.1-service.patch#L23

Fedora:
https://src.fedoraproject.org/rpms/suricata/c/cfb3b996f54d28018cd01f9c6b9ecb77e59f344d

Resolve SELinux AVC denial:
type=PROCTITLE proctitle=/usr/bin/suricata
-c /etc/suricata/suricata.yaml -i eth0

type=SYSCALL arch=aarch64 syscall=mprotect success=no
exit=EACCES(Permission denied) a0=0x7fffa7d04000 a1=0x4000
a2=PROT_READ|PROT_WRITE|PROT_EXEC a3=0x21 items=0 ppid=1 pid=283
auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=root
sgid=root fsgid=root tty=(none) ses=unset comm=Suricata-Main
exe=/usr/bin/suricata subj=system_u:system_r:initrc_t:s0 key=(null)

type=AVC avc:  denied  { execmem } for  pid=283 comm=Suricata-Main
scontext=system_u:system_r:initrc_t:s0
tcontext=system_u:system_r:initrc_t:s0 tclass=process

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-ids/suricata/files/suricata.service |  1 +
 recipes-ids/suricata/suricata_7.0.13.bb     | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/recipes-ids/suricata/files/suricata.service b/recipes-ids/suricata/files/suricata.service
index bd7010d..4b774f4 100644
--- a/recipes-ids/suricata/files/suricata.service
+++ b/recipes-ids/suricata/files/suricata.service
@@ -14,6 +14,7 @@ ExecReload=/bin/kill -HUP $MAINPID
 PrivateTmp=yes
 ProtectHome=yes
 ProtectSystem=yes
+MemoryDenyWriteExecute=no
 
 [Install]
 WantedBy=multi-user.target
diff --git a/recipes-ids/suricata/suricata_7.0.13.bb b/recipes-ids/suricata/suricata_7.0.13.bb
index 469e42d..b0d2c82 100644
--- a/recipes-ids/suricata/suricata_7.0.13.bb
+++ b/recipes-ids/suricata/suricata_7.0.13.bb
@@ -38,7 +38,15 @@ CARGO_BUILD_FLAGS:append = " --offline"
 B = "${S}"
 
 # nfnetlink has a dependancy to meta-networking
-PACKAGECONFIG ??= "file pcre2 yaml python pcap cap-ng net"
+PACKAGECONFIG ??= "file \
+                   pcre2 \
+                   yaml \
+                   python \
+                   pcap \
+                   cap-ng \
+                   net \
+                   ${@bb.utils.filter('DISTRO_FEATURES', 'seccomp', d)} \
+                   "
 PACKAGECONFIG:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'ptest', 'unittests', '', d)}"
 
 PACKAGECONFIG[pcre2] = "--with-libpcre2-includes=${STAGING_INCDIR} --with-libpcre2-libraries=${STAGING_LIBDIR}, ,libpcre2 ,"
@@ -51,6 +59,7 @@ PACKAGECONFIG[nfq] = "--enable-nfqueue, --disable-nfqueue,libnetfilter-queue,"
 
 PACKAGECONFIG[file] = ",,file, file"
 PACKAGECONFIG[python] = "--enable-python, --disable-python, python3, python3-core"
+PACKAGECONFIG[seccomp] = ""
 PACKAGECONFIG[unittests] = "--enable-unittests, --disable-unittests,"
 
 export logdir = "${localstatedir}/log"
@@ -115,6 +124,10 @@ do_install () {
              -e s:/bin/kill:${base_bindir}/kill:g \
              -e s:/usr/lib:${libdir}:g \
              ${UNPACKDIR}/suricata.service > ${D}${systemd_unitdir}/system/suricata.service
+
+        if ${@bb.utils.contains('PACKAGECONFIG', 'seccomp', 'true', 'false', d)}; then
+            sed -i -e 's/^MemoryDenyWriteExecute=no$/MemoryDenyWriteExecute=yes/' ${D}${systemd_unitdir}/system/suricata.service
+        fi
     fi
 
     # Remove /var/run as it is created on startup
-- 
2.51.0


