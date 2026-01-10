Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF55D277F0
	for <webhook@archiver.kernel.org>; Sat, 10 Jan 2026 15:27:44 +0000 (UTC)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10295.1768058858382528775
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 10 Jan 2026 07:27:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=E/xgbCij;
 spf=pass (domain: gmail.com, ip: 209.85.167.179, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-455bef556a8so3481409b6e.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 10 Jan 2026 07:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768058857; x=1768663657; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOaMbA51eDSGPJjC6xn6a3xFeKCt1BJB1fgnyUqMQuI=;
        b=E/xgbCijTW9O8J0+lQAryv5+euFcxY7ze1tQjFj4Z5W4W+MG1Y7CJezdRLGo3ip3m3
         xU+ckRKCZr6Ex2s3AXSYu7uI4nbT5afyMvC557qexxHK0nr8aQerD5I2sHQxcGieyaMQ
         eFGpJLkfECJM9FRCyBEZwIQfKabAJvadhTsXNa57mvETr/vX68FgELb7ZD3Uaaz1t/3g
         nvb86WXGhFeTNOm1J1gayk2OkW07Q/pP5CTG0bkPNGibsFWIISOpOJG7FPr8CuZ+s3tx
         XU18dL+o6TQ750yo5rSpi/5Y6+LzX0WT2/pb/Xf7LCcyKup3pVuiJSOEnljLsPGvm/GQ
         d1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768058857; x=1768663657;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HOaMbA51eDSGPJjC6xn6a3xFeKCt1BJB1fgnyUqMQuI=;
        b=lcuhyqabScNM9NydGJKhLFvABBuVNkuY6U2wweYiLyFrAuF4oIc9om/tlf/EzrkMwk
         Q3x1oMQ490iUFI5UOjYe/k4VlwLtGZiSJdrh6K0l72m8K7/793kxz+sQfHOqPgBOLLk8
         2z9NxAvoKpRvXcfY/TvBuXb1We3VIfOkBXkwDX8qQTb/8NWx02txMoEZ3j8pGlK6yi0r
         BscoAfSkbLayGWIj0GsCmAC/1BU5uM340AQs8ewKCBI3CVUHCywICoHinB4LZ6kYXRnG
         MiKsy7pfQAz2tIrPaZJe4QcQXhHR8hKo2PQDR7Fjx9Xfn98q/INik2jIW4hMrBbhNBuQ
         BChA==
X-Gm-Message-State: AOJu0Yw3N0EBiVUF6BgESB87qGa3HEPfjD2rMJlWQG0XTntFo9q9LrVe
	O/VwbBOMezoyUA+MYGPQkhMWw/QEowHSclvqEacbqlYsJZGWRi2iEiSKxcEl3g==
X-Gm-Gg: AY/fxX46CsrwMu/108cM2O4NHcWJ65RKsj7AtjAKgPPMFR6gYao6Zoo6ZaI1r3HUPEw
	3cvqBNNYgsPcDQW2UtpwepgPR7+9O6PWH9eEx+AIroBdp/tqFg+WstcnYeBdxVXbqAhyCrUPQQn
	FpB2BhXtXXvG71Z5nvqXjkGLRJWNVO7GwJMTX8VhikS6volJ5ze5fVugh1fgvlnS/fWkk1KZUe7
	+UiOwI4+fKNiT0kOmGJm03uDvJgbV6dIFD4/oLlmfxNmXnFXtmLM1Mcu+u/TfpcawGRD3uYyHTC
	umqhBb8MqjJXTjIHeJfnsjHIdN6xbJaYCTcPJC7+143ZfNRTpQSIS3Exgkaw6W97ZjeNvUEZ6zm
	VDhog7TDQO6BC0z0V6k33sR6zEIBCQ+8632AXomjO+zivJe5Qc2Rvc0FedKkrtjrQI3aKNRFukr
	dqcjSXiQtjtf8Dauw3DtItLE6evPKxnCwE4HI1uz1GGchGoM36PR0nEfAih4EtzA==
X-Google-Smtp-Source: AGHT+IGRvGLvOg8w9vxk3A0xM++yYiVxP7FsMPelFnwuwnnlQw8sIWhaccPnKKRvTo3DBIh/gWFz0w==
X-Received: by 2002:a05:6808:179c:b0:450:ac57:48a7 with SMTP id 5614622812f47-45a6bec27dfmr6538419b6e.59.1768058857567;
        Sat, 10 Jan 2026 07:27:37 -0800 (PST)
Received: from [172.26.252.3] (75-166-169-44.hlrn.qwest.net. [75.166.169.44])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4de539bsm8757521fac.4.2026.01.10.07.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jan 2026 07:27:37 -0800 (PST)
Message-ID: <a76cd1ab-7226-4bda-bd51-b53438888458@gmail.com>
Date: Sat, 10 Jan 2026 08:27:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org, scott.murray@konsulko.com,
 rybczynska@gmail.com
Cc: yi.zhao@windriver.com, joe.macdonald@siemens.com
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-security][PATCH] suricata: add PACKAGECONFIG[seccomp] -
 MemoryDenyWriteExecute
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 10 Jan 2026 15:27:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2932

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
---
Sponsor: 21SoftWare LLC

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

