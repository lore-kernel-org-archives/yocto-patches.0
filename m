Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71844CD98C5
	for <webhook@archiver.kernel.org>; Mon, 15 Jun 2026 14:56:47 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.131664.1781535402772413975
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 15 Jun 2026 07:56:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=dk3ALwey;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490b915ded5so33634805e9.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 15 Jun 2026 07:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781535401; x=1782140201; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2mG4Pe+DoWqlo1Ds1medh/Dm9B13YZIkppqTPqpy/cU=;
        b=dk3ALweylfOOcnN+oHydz79c2I7tylGuJh0d+lJt/VKs8rjRftWh5shuoforA8Vhsm
         9fjhauKegwguLGPFxqX7/AnCpVq3dpCnAZDI4LkihdbBWm2RvLudhKQR54K3tahLN7sn
         BRE9foKqXCW3Ym15/NULVOtd87JMKO/TjUGa9gzdeOsG24lb0NWOPgscoXoQATblQhqS
         DiKkebNsM73OVUd/8gVIvHld/J15PfZqJbORqV/69AHtiZwk+oeo474BMef/0aUIS5fx
         bE0Y0b18Q0OXIuk51awfkL4JBEsJofhowdR0vlkle4rsGz3zJctf4skcDO3xvmauOAfs
         DFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781535401; x=1782140201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mG4Pe+DoWqlo1Ds1medh/Dm9B13YZIkppqTPqpy/cU=;
        b=V01aBRMRGzi2/6xRl7RwsdUw9qE5IzsN7WFs8xDe2ETK5TYWwgryXHR2x6xhnIE69w
         CM7Z9mZ1/IXiwPxVqRMe51TpEj2dTs/h3k3cdeihrOL+HO0a9RjxlSe/7kzWSIoOlEqu
         Ddh2GjgERTrz9FmkWFuqQSvO74DoFR3IjYmMUjvXKPaEYTC86IvuwzuYsM6EyG0bKwdA
         TIu4Ujob8Cj7ANDL/eHMr/yEj1/AXeYLXUrsqJF/xex92SaBztck42Gxh2jWang0ub6X
         +USOuMbqgZJXQ6JkD1V8DEKtaqNBuroTAd/kejfFs7LjPYlaTSSco+zbNowDLY4E7PEc
         PqVQ==
X-Gm-Message-State: AOJu0YxrX6Xa/2GgDIOP6su0YO2R4t5ZjBz2pIIH3i/G8KZk1gtiYu/B
	GpndySZIr6/hjgoPwr0WkEpdRCzF44bSXIOUR4vxgBRsfIpuQA5pTo9XJ2JCkDvq
X-Gm-Gg: Acq92OFIWtaIcwmMMIF6P/ZvxmgoHKopKCSd4WsQMZb1egomT4/184HI5xqhvAqlU79
	NSkrr5LlirE89ow63bTkTKO0ogG1e1cfGq28397pob/gKiCzKaL41TXSo83AH8DdmeMrDOXfkOm
	N+YNxGrMREbpmC4MNfGPY/61B+GEVZ86cPqWHyC2X0jnLwqLTnHonwz/LF3c7xnyrXliq8c7+Ao
	H6hBVUbFip8Z2UDECgCb+ADndQKVTDebZ1HNHwMhO0D7btBjbAxd8Wmk3MLQ2Octnwsq0L/F0/c
	onRx8wtCBn9kfzFXsuMZGUQxJmAYl0kwqwGF47EBBfBCIyAPOFamc+9eMwEd8z7CaeL0u+gesAB
	JDnK5xclbu1+ls+n6XXgf0X41HO9SK4hlgw81BUnyMzO+XjdROPekytSulhpQ1uLt5Kin1Re3ri
	ACS+GlwkxZWvwy/piA2gz6Z0rGqZrgT1rvZtoX1YkqyGwRy6+IS31f6FsXxRg=
X-Received: by 2002:a05:600c:3583:b0:490:5466:8591 with SMTP id 5b1f17b1804b1-490ec4e74dbmr237816465e9.12.1781535400781;
        Mon, 15 Jun 2026 07:56:40 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492201fad25sm267064365e9.0.2026.06.15.07.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 07:56:40 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
X-Google-Original-From: Alexander Kanavin <alex@linutronix.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [auh][PATCH] modules/statistics: include information about skipped recipes into summary emails
Date: Mon, 15 Jun 2026 16:54:58 +0200
Message-ID: <20260615145458.193385-1-alex@linutronix.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 15 Jun 2026 14:56:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4229

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 modules/statistics.py | 10 ++++++++++
 upgrade-helper.py     |  1 +
 2 files changed, 11 insertions(+)

diff --git a/modules/statistics.py b/modules/statistics.py
index 227f0be..5126a39 100644
--- a/modules/statistics.py
+++ b/modules/statistics.py
@@ -32,6 +32,7 @@ class Statistics(object):
         self.upgrade_stats = dict()
         self.maintainers = set()
         self.total_attempted = 0
+        self.skipped = []
 
     def _update(self, pn, new_ver, maintainer, error):
         if error is None:
@@ -65,6 +66,10 @@ class Statistics(object):
         for p in group['pkgs']:
             self._update(p['PN'],p['NPV'],p['MAINTAINER'],group['error'])
 
+    def skip(self, group, reason):
+        for p in group['pkgs']:
+            self.skipped.append((p['PN'],p['NPV'],p['MAINTAINER'],reason))
+
     def _pkg_stats(self):
         stat_msg = "Recipe upgrade statistics:\n\n"
         for status in self.upgrade_stats:
@@ -78,6 +83,11 @@ class Statistics(object):
                         stat_msg += ", " + maintainer
                     stat_msg += "\n"
 
+        if self.skipped:
+            stat_msg += "    * Skipped: {}\n".format(len(self.skipped))
+            for (pkg, new_ver, maintainer, reason) in self.skipped:
+                stat_msg += "        {}, {}, {}, {}\n".format(pkg, new_ver, reason, maintainer)
+
         if self.total_attempted == 0:
             percent_succeded = 0
             percent_failed = 0
diff --git a/upgrade-helper.py b/upgrade-helper.py
index b4aa99a..eea0fd7 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -499,6 +499,7 @@ class Updater(object):
                 r = self.state.check(pn, npv)
                 if r['skip']:
                     I(" %s %s: skipping (%s)" % (pn, npv, r['reason']))
+                    self.statistics.skip(g, r['reason'])
                 else:
                     kept.append(g)
             I(" %d/%d package groups skipped (incremental mode)"
-- 
2.47.3


