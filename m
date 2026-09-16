Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784B6C982D0
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 21:58:50 +0000 (UTC)
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.26507.1789595920081348772
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 14:58:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=UiM593K0;
 spf=pass (domain: konsulko.com, ip: 74.125.230.204, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939109f067eso14881185a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 14:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789595919; x=1790200719; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/KynRcpp+JDjr540yKqjL5AqMCR7AnmsSTuTw658Yi4=;
        b=UiM593K0bFzH5ZpUbuRfnGGdg1oYkoGk31pDlUDZxhEWoTMTgh+FEqm8raWVJb/6bg
         PdzxICJbAMBb9XLzskNKJrbRzHZDNqUCh9A4T51hplsRWovH36GjQqmCqcavm73+6XK5
         l60PbF2U7eI9nlAEYnS03bktlYzxVZhC8WxZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789595919; x=1790200719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/KynRcpp+JDjr540yKqjL5AqMCR7AnmsSTuTw658Yi4=;
        b=MhKtQIoSgStErpSUKwqHerczz650dzRldYJKmhQBDotY1zqXydLDrXT4GZ0d6m8Ygt
         Ewtn7g9XGyEjuLBYkvQ6dktcOHQQRcCuAoPR3dz9lYkAfsrRwsXOl/Gp31O5m91tnysL
         HfSxOqnqPS2f+NgBxPoLJ7XG2Ch1xlAIfIf9N1YVzsn+tXaSLnlmc0+q40p11tJATZcb
         jcu6BL+gTkxlOObseXx9ijhxLHqQDUIqifVZzwUObw28/sArcurCm4mllhGr0LxWyLoK
         o8iwlA62dzr/x3ERs0f4QQ2lqO7N4ZS3YO/fx01VCq9+RlQKq75ylAujbujqDqrH7fcN
         ukqQ==
X-Gm-Message-State: AFuF++l2LWikU68pNY7/SyVWZN8k4MqwdO2QZ4oxvRnD9wlhN5YCjl63
	1wfx+TL8lqNLDD1RWbTX13KFmw284B8l0QlbRssEc3JNiTrApYAde1vaboPRqojAJl3rtkzjWKW
	j6twD
X-Gm-Gg: AYBFou2Zyi8/HdRPStlLfwzVlxkcVu+IHatX6BPcLKVV7+ZpuPDbcWRehzIgSiofmmi
	i8J0m8K2UMfGnYH3J+la6bGWWtlt1jLkKG2D2eUgf8ALSl08AJUTQ3cPe8xJ/NHqIb4AS9jvfaj
	Tc3CgfQ3DauEypyPgz9Z+ID2WVcpPpaZJLSAFgyqHywL/C5RdlbsgkdzoCVAOvzyFwi9IC6LdEB
	gco1ScXnQMK0xWfdnCnv6I71uX1c9bvwy25G/hK32nKau0eAOF03FWfZ4U4figrXPrZbFxAhqqs
	qN5iCjW5QPsvQC3Z50YlmvLgmob45QDWhzixjEDba9lUmaVUExGtLM56Ws4UbC8vihhrVbFrNJp
	FYbK3T4j0Rscw5/wNhC8Z0K+xNHeNDpps/nIL5RzrqCoZRBbHQs/G3Yata0Ebjkyqxy+V/MHWCW
	/rfc0jqSNQORQnrIrB6ew27pg49mXSUCCCfxviN5dVaZtsBOABPdaPaoD1L3zP0jnE9RQVY1Hcz
	KPolmXqnlDdJg4VL9qg2ADXA/JXod2+CYppqkM6gsQ/CcFOq49QgXgTEMe74z/IfVqugrwfl9ae
	DCaLXIym76sFt46SrHwFICo2jbPaUV0LjEvXB6vPo86ruQ==
X-Received: by 2002:a05:620a:6085:b0:939:c9e9:81a1 with SMTP id af79cd13be357-93bb785d086mr717697185a.42.1789595918833;
        Wed, 16 Sep 2026 14:58:38 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781def43sm323293085a.16.2026.09.16.14.58.37
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:58:37 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 02/19] openscap: upgrade 1.4.3 -> 1.4.4
Date: Wed, 16 Sep 2026 17:58:02 -0400
Message-ID: <54deebf9dd04387b29360030a7ae872832cfc96b.1789595456.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789595456.git.scott.murray@konsulko.com>
References: <cover.1789595456.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 21:58:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4858

Upgrade to 1.4.4 and backport an unreleased change to fix building
with SWIG 4.5.x.

Release notes:
https://github.com/OpenSCAP/openscap/releases/tag/1.4.4

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...Python-2-C-API-macros-for-SWIG-4.5.0.patch | 87 +++++++++++++++++++
 .../{openscap_1.4.3.bb => openscap_1.4.4.bb}  |  5 +-
 2 files changed, 90 insertions(+), 2 deletions(-)
 create mode 100644 recipes-compliance/openscap/files/0002-Replace-removed-Python-2-C-API-macros-for-SWIG-4.5.0.patch
 rename recipes-compliance/openscap/{openscap_1.4.3.bb => openscap_1.4.4.bb} (96%)

diff --git a/recipes-compliance/openscap/files/0002-Replace-removed-Python-2-C-API-macros-for-SWIG-4.5.0.patch b/recipes-compliance/openscap/files/0002-Replace-removed-Python-2-C-API-macros-for-SWIG-4.5.0.patch
new file mode 100644
index 0000000..8711dec
--- /dev/null
+++ b/recipes-compliance/openscap/files/0002-Replace-removed-Python-2-C-API-macros-for-SWIG-4.5.0.patch
@@ -0,0 +1,87 @@
+From 26b6cb16a1450d10eb5e14fa4f0ff62d48ff62fd Mon Sep 17 00:00:00 2001
+From: Matthew Burket <mburket@redhat.com>
+Date: Tue, 1 Sep 2026 11:02:05 -0500
+Subject: [PATCH] Replace removed Python 2 C API macros for SWIG 4.5.0
+ compatibility
+
+Back ported from https://src.fedoraproject.org/rpms/openscap/pull-request/35
+
+Co-authored-by: Jitka Plesnikova <jplesnik@redhat.com>
+Upstream-Status: Backport [https://github.com/OpenSCAP/openscap/commit/26b6cb16]
+Signed-off-by: Scott Murray <scott.murray@konsulko.com>
+---
+ swig/openscap.i | 16 +++++++---------
+ 1 file changed, 7 insertions(+), 9 deletions(-)
+
+diff --git a/swig/openscap.i b/swig/openscap.i
+index 7970481f0..1d23b0a32 100644
+--- a/swig/openscap.i
++++ b/swig/openscap.i
+@@ -48,8 +48,6 @@
+ {
+     if (PyLong_Check($input))
+         $1 = (time_t) PyLong_AsLong($input);
+-    else if (PyInt_Check($input))
+-        $1 = (time_t) PyInt_AsLong($input);
+     else if (PyFloat_Check($input))
+         $1 = (time_t) PyFloat_AsDouble($input);
+     else {
+@@ -80,8 +78,8 @@
+     $1 = (char **) malloc((size+1)*sizeof(char *));
+     for (i = 0; i < size; i++) {
+       PyObject *o = PyList_GetItem($input,i);
+-      /*if (PyString_Check(o))*/
+-        $1[i] = PyString_AsString(PyList_GetItem($input,i));
++      /*if (PyBytes_Check(o))*/
++        $1[i] = PyBytes_AsString(PyList_GetItem($input,i));
+       /*else {
+         PyErr_SetString(PyExc_TypeError,"list must contain strings");
+         free($1);
+@@ -329,7 +327,7 @@ int rule_result_output_callback_wrapper(struct xccdf_rule_result* rule_result, v
+         return -1;
+     }
+     Py_DECREF(arglist);
+-    dres = PyInt_AsLong(result);
++    dres = PyLong_AsLong(result);
+     Py_XDECREF(result);
+     PyGILState_Release(state);
+     return dres;
+@@ -366,7 +364,7 @@ int rule_start_callback_wrapper(struct xccdf_rule* rule, void *arg)
+         return -1;
+     }
+     Py_DECREF(arglist);
+-    dres = PyInt_AsLong(result);
++    dres = PyLong_AsLong(result);
+     Py_XDECREF(result);
+     PyGILState_Release(state);
+     return dres;
+@@ -403,7 +401,7 @@ int agent_reporter_callback_wrapper(const struct oval_result_definition* res_def
+         return -1;
+     }
+     Py_DECREF(arglist);
+-    dres = PyInt_AsLong(result);
++    dres = PyLong_AsLong(result);
+     Py_XDECREF(result);
+     PyGILState_Release(state);
+     return dres;
+@@ -438,7 +436,7 @@ int validate_callback_wrapper(const char* file, int line, const char* msg, void
+         return -1;
+     }
+     Py_DECREF(arglist);
+-    dres = PyInt_AsLong(result);
++    dres = PyLong_AsLong(result);
+     Py_XDECREF(result);
+     PyGILState_Release(state);
+     return dres;
+@@ -474,7 +472,7 @@ char * sub_callback_wrapper(xccdf_subst_type_t type, const char *id, void *arg)
+         return NULL;
+     }
+     Py_DECREF(arglist);
+-    dres = PyString_AsString(result);
++    dres = PyBytes_AsString(result);
+     if (dres == NULL) {
+         if (PyErr_Occurred() != NULL)
+             PyErr_PrintEx(0);
+-- 
+2.47.3
+
diff --git a/recipes-compliance/openscap/openscap_1.4.3.bb b/recipes-compliance/openscap/openscap_1.4.4.bb
similarity index 96%
rename from recipes-compliance/openscap/openscap_1.4.3.bb
rename to recipes-compliance/openscap/openscap_1.4.4.bb
index 1b6d9af..8f498df 100644
--- a/recipes-compliance/openscap/openscap_1.4.3.bb
+++ b/recipes-compliance/openscap/openscap_1.4.4.bb
@@ -11,9 +11,10 @@ DEPENDS:class-native = "pkgconfig-native swig-native curl-native libxml2-native
 
 SRC_URI = "git://github.com/OpenSCAP/openscap.git;branch=main;protocol=https \
            file://0001-CMakeLists.txt-fix-installation-directory-for-system.patch \
-          "
+           file://0002-Replace-removed-Python-2-C-API-macros-for-SWIG-4.5.0.patch \
+"
 
-SRCREV = "24986066961363e24fcff83294995b3cfe4058ba"
+SRCREV = "4ac56ce0e6dfdea7215b5ad202b3db20855d2507"
 
 COMPATIBLE_HOST:libc-musl = "null"
 
-- 
2.55.0


