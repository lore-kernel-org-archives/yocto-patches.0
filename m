Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4441.1793659691885156958
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 02 Nov 2026 14:48:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=sRujVjG+;
 spf=pass (domain: konsulko.com, ip: 209.85.221.42, mailfrom: scott.murray@konsulko.com)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48df4f540ebso1624079f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 02 Nov 2026 14:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1793659690; x=1794264490; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6oXx2Wcz1FED2rBIXkOva73MFQLINBc1rdzcsezelTY=;
        b=sRujVjG+IaA9Mk6DYQQ2n+pliFsmNFnr5zX5zRg5qw2274OMZu1mWYjoUp7vnp0ejd
         WYCD39oOVIV2mPcRNw8r1pHAh0HYe9E+JlyBzzPX00TDQqeyGInf2z5Q8ne8QEHA5S9H
         ZqD2scKhbnxQb9qN7vmrx8RVbC6fVYUWUc8Og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793659690; x=1794264490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6oXx2Wcz1FED2rBIXkOva73MFQLINBc1rdzcsezelTY=;
        b=DiEgwSQXCVZazD65s5e5GyNOWg97mjCAZzoGLpRByJyfbUROCAgr1+/FJqUBtL/mIB
         PZHcDIpoGC1Pca+Xo8k6nJkx93omLzqkPAkLgBypdxlhs3Oqf768GSewcda51apNpU4O
         ObJwvp9GZi030GUdwhoBC9eBBXN4BJO3UVl7KBsgOUXxZKcK2RHLzzGyskQ3/fQ+uPc8
         zEwWz2/Sk4phoRpXcJ1xhCYdQamy2v3mwG6eiGcZ1QsJp+sCYGEFzKR1iDwmdFeh7/r7
         G6sfqmMRPe1IG47+GiCN0qm0SJT+cG7nF0NRwQ1wbAritdSC0FnJetT15zY5HsHY/+qQ
         cyug==
X-Gm-Message-State: APuU4Z8Dm1JkRrKvX/gbbpDv4C5f+HuVdxfLa8iegUCtMQOZcK0g0pyg
	WdlrTSeAm1XOI9TxiF9OyVmcyE0zfpznGOPb1KDcw+IGz6my4MP3k2YjtKeh9q7T4eO9bKjWSxk
	eU6qO7SM=
X-Gm-Gg: AYBFou2dUj60dpgm4aiWMSM96hkMXZCX51K85WYzWlIVWH6/qXklz+/CeYrIbWLOlgk
	ZOmtzULss8BW7crqGuPo0ECUVDrUHkwR+XHuy1ik6cobKbpjptlv1kUA9QMs4KstGderEm/80Ih
	bpq54YSIf+f139D1JBoNM1Jelh4EpAnykAMYjrot1jQCTGyIVi+USu/Gc+EwskIEQsA+qQWAbnP
	xJ/Hko0/M6U6iXMvbEu3DaoRmc30wB7U3f+rlmElHvtjh17Y7PwB0TMZi60oZHo+Cd65dpkfqv4
	S/Vy7ODMPjbMgG1H7XflIyaD8BnmV2989f3+p4m4qH0EZIsgNwy6USg0s7Dd3n9NNq0Z1eYYlNJ
	NtznUnaXxcmvEvLBA9DAJQKKOC3ZTcy972ONnMEkqZQuOsJPURsw8ZHUl58BnCPm6Fxmj8UVvZG
	TkyzqhQ8gdHWxnwaggzLhR3VK0bejv25Js3W4Qg9eLpJg5OjeV92unkmJ2KinkCBoMXjWwXd5/u
	K7rZV9bdyfTsVmkUk/n6NjgPK4fSllxx8OSXT2Ul+i1Ovvpr4cImrLJOs5040PkAxknMjqi6pRg
	dDmrod6nV6eDdOJz3g5BTfum1RtpmOHug7yTzmmhd/8Z8IjiZ2LsLvO6othoSDPUGAheY+/6d9f
	JKHM3ucu4Ll4pkW0uSfSm+dGJ4qlkxITnCJriW6+2ni0uW/572gD9
X-Received: by 2002:a05:6000:400c:b0:48e:35d4:55b5 with SMTP id ffacd0b85a97d-48e6e518368mr23402719f8f.52.1793659689694;
        Mon, 02 Nov 2026 14:48:09 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71ba7168sm23770828f8f.55.2026.11.02.14.48.08
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:48:09 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 4/4] python3-tpm2-pytss: Upgrade 2.3.0 -> 3.0.0
Date: Tue,  3 Nov 2026 00:47:48 +0200
Message-ID: <2b1550639ec262f3f0c9a3a2708aca1a1e10fb4f.1793659376.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1793659376.git.scott.murray@konsulko.com>
References: <cover.1793659376.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 02 Nov 2026 22:48:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5212
Content-Type: text/plain; charset="utf-8"

To fix build issues from the new version of python3-pycparser in
oe-core, upgrade to 3.0.0.  This uncovered a new pycparser related
issue, so a patch has been added to fix building under OE.

Changelog at:
https://github.com/tpm2-software/tpm2-pytss/releases/tag/3.0.0

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...0001-Handle-CC-values-with-arguments.patch | 51 +++++++++++++++++++
 ...s_2.3.0.bb => python3-tpm2-pytss_3.0.0.bb} |  5 +-
 2 files changed, 54 insertions(+), 2 deletions(-)
 create mode 100644 meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss/0001-Handle-CC-values-with-arguments.patch
 rename meta-tpm/recipes-tpm2/tpm2-pytss/{python3-tpm2-pytss_2.3.0.bb => python3-tpm2-pytss_3.0.0.bb} (80%)

diff --git a/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss/0001-Handle-CC-values-with-arguments.patch b/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss/0001-Handle-CC-values-with-arguments.patch
new file mode 100644
index 0000000..432c350
--- /dev/null
+++ b/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss/0001-Handle-CC-values-with-arguments.patch
@@ -0,0 +1,51 @@
+From 39f87887bcdf037fe077e04f582db927cb35d2bc Mon Sep 17 00:00:00 2001
+From: Scott Murray <scott.murray@konsulko.com>
+Date: Thu, 29 Oct 2026 19:46:41 +0200
+Subject: [PATCH] Handle CC values with arguments
+
+OpenEmbedded / Yocto Project builds pass a value for CC that includes
+several arguments (e.g. --sysroot).  The embedded spaces in the value
+break pycparser's expectation for the value of the cpp_path argument to
+its API calls.  To handle this, add logic to split the value of CC for
+use in cpp_path and cpp_args.  shlex is used to hopefully handle quoted
+spaces or potentially spaces in the compiler path, but this has not
+been tested.
+
+Upstream-Status: Pending
+Signed-off-by: Scott Murray <scott.murray@konsulko.com>
+---
+ setup.py | 11 +++++++++--
+ 1 file changed, 9 insertions(+), 2 deletions(-)
+
+diff --git a/setup.py b/setup.py
+index 1216065..0160a76 100644
+--- a/setup.py
++++ b/setup.py
+@@ -2,6 +2,7 @@ import site
+ import sys
+ import os
+ import platform
++import shlex
+ from setuptools import setup
+ from setuptools.command.build_ext import build_ext
+ from pkgconfig import pkgconfig
+@@ -22,11 +23,17 @@ site.ENABLE_USER_SITE = "--user" in sys.argv[1:]
+ 
+ 
+ def cpp_path():
+-    return os.environ.get("CC", "cc")
++    cc = os.environ.get("CC", "cc")
++    return shlex.split(cc)[0]
+ 
+ 
+ def cpp_args(args=[]):
+-    return ["-E"] + args
++    cc = os.environ.get("CC", "cc")
++    split = shlex.split(cc)
++    cc_args = ["-E"]
++    if len(split) > 1:
++        cc_args = split[1:] + ["-E"]
++    return cc_args + args
+ 
+ 
+ class type_generator(build_ext):
diff --git a/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb b/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_3.0.0.bb
similarity index 80%
rename from meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb
rename to meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_3.0.0.bb
index 60de4a6..1ce8cf6 100644
--- a/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_3.0.0.bb
@@ -4,9 +4,10 @@ HOMEPAGE = "https://github.com/tpm2-software/tpm2-pytss"
 LICENSE = "BSD-2-Clause"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=500b2e742befc3da00684d8a1d5fd9da"
 
-PYPI_PACKAGE_SDIST = "tpm2-pytss"
+PYPI_PACKAGE_SDIST = "tpm2_pytss"
 
-SRC_URI[sha256sum] = "20071129379656f5f3c3bc16d364612672b147d81191fb4eb9f9ff9fbee48410"
+SRC_URI += "file://0001-Handle-CC-values-with-arguments.patch"
+SRC_URI[sha256sum] = "c193cf1908b482f93c4aa464132920fe3a37d4b9d802e267974ff2dfe37d4433"
 
 inherit autotools pkgconfig pypi python_setuptools_build_meta
 
-- 
2.47.3

