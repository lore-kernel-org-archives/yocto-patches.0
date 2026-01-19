Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF73EEE26E
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 20:28:43 +0000 (UTC)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44081.1768854522337027954
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Jan 2026 12:28:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=WGqaorMD;
 spf=pass (domain: konsulko.com, ip: 209.85.160.181, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ffbea7fdf1so38930131cf.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 12:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1768854521; x=1769459321; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sG9WQ72C7eXpo4d0eRDXDrqmNRigG8E1WcVwNewoU0E=;
        b=WGqaorMDq1W5MoY0eqPd6tDVwOxn/azKMiMSxcVXNeTpTRtQLOZEYJWNQNK3GbWHrG
         ZHafIZ+M4BnjmvRwrxbM7L4HHkYX0dmOqIbBAZPSJZVlm/BopvJldR50rtlHfbB5CUHR
         kAYw2+hmZivfdDdo34b/o5trIV4xngCkrSvTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768854521; x=1769459321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sG9WQ72C7eXpo4d0eRDXDrqmNRigG8E1WcVwNewoU0E=;
        b=lrG8+Q9CabyGCyG/IzinyPURLixnZUjhkyzlLBHj5Zmw61XdrmeuYZPi52vcRyGQUt
         XxwhuVVmluEnj5kfgVQmonpwkBcDZK/DXTzFYvXbl93IU0Q4UN10Lrcf98z7X4FdDWrR
         wM+fm7AXaiWALVQ5ZPuOjjxa40Zi9tEQPhFAkb14tZCqpmass3d12kQecxiRVAD4aIRQ
         WXJUf25QCZPDD/tARpjC7m1JonllJjaEmH0HrHUuC2cax0VGGfH9tHGOWvLalAZKlm+e
         wKRuUpZzXW1UMFw/iAK7fvLFQy7vGk29RkMrSFjSzhyBILRe5YT9q1E3lMwpYJqCpz9f
         H0jw==
X-Gm-Message-State: AOJu0Yy0rBcsSQTa/vhfPIn7meD0vLYXyMvgdOFbIbgzJVd0YmpgB0p6
	4RzWyK5uM3197RZvuqPkix8xzrhzkwgL4BhMOrHjR6bA+nzYyMJHqwJ5DBYxkjTw0iqNg/WDkq/
	qVOHL
X-Gm-Gg: AY/fxX6EpWh6d7ibcfG7cVrV74uJdnq7XlVwRNFOQCSW5onQY6HZEhi0FkR9K5HTMwE
	5tFQFDEL6CiYj9M69mg2UHebxFzyFp5wj43D/TEipItOhvWO6V1Q7CXO9H6KibTcnJsjlsoK+o+
	gFlJu8oRD4KC81nRQnqjbcqV18pB4BrkwFdWeq0deDepymjz9IipCVpBYBa7nZOEJPuSCDRj4ZR
	uBCx0/NPkUspFGcYAflLwGI8UI91E3H+xDsfJME2+OvUJE1YdP4aPENPe3u2TI5DIjWWQvWF7aM
	zVDKuw63bzGBS78SCD8Bmcw+ScJesC1D3tDoumot6fBMC8arZ4V5OMI8SgTsVZUd4MTf59QKDAg
	cM/inBoO2SOx8vhVld6dOE3ZLeaHEiJQwbWfWFHdAGyD8XsGnVK6npOZ9rhah4mYi7VSgEaqQoF
	2mcXEhkflAIRW1MFpg6M+ZIXqiEYZMQsOAzq2rI2n6x3gt5b1hN114agxc1pG2U+oFYf/kRNfmL
	dLpX2JPrNPpEwThi+csmTCA5MaV8rTn+ytdMS3saZb38Au8+2EWyz8R3RixcqY=
X-Received: by 2002:ac8:5e11:0:b0:4ff:c894:3bad with SMTP id d75a77b69052e-502a1e24107mr178574671cf.19.1768854521046;
        Mon, 19 Jan 2026 12:28:41 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1f21c9asm82661411cf.34.2026.01.19.12.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 12:28:40 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: [meta-lts-security][PATCH 2/3] suricata: add PACKAGECONFIG[seccomp] - MemoryDenyWriteExecute
Date: Mon, 19 Jan 2026 15:28:22 -0500
Message-ID: <c32a913012ddac4f70c86494576c70f6719b77ab.1768854292.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1768854292.git.scott.murray@konsulko.com>
References: <cover.1768854292.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 20:28:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3016

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


