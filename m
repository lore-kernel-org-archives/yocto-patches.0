Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9723CCCF2C4
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 02:06:26 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8016.1792289178525945327
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 19:06:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=PR74bS8W;
 spf=pass (domain: gmail.com, ip: 209.85.216.45, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-398a4dcf289so569684a91.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 19:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792289178; x=1792893978; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RlT13S1OEXMnwWEPOPM5zDklmSAdD00qmkKyU2B6cVA=;
        b=PR74bS8WQycq66mzef4qOMPLHC3OBM2qLgK8QEMcDhjBD6/KUbE4GDZZM8UGWuhMPJ
         DVXqloy2YK8++UWoF0RQKXOVIyK3bmenNHKEce1f8Yt5Xn+n0ElogvSCv9peufXGDZuX
         CHvbf1qZJqha8hiVvr+nwwalM2tZkan0M0H8aHVAdtXpuG8MxrLjgCwTexczh4Waa99C
         Vv3ilGgHrcptdl3/PBPxzA5j5lbnaZcCzbPkDifZL81b+jxEV3yMAUNn0srM/xbXgcbQ
         AyqeMh3Qdn8gUOVDR/17IPUp87dfZRkyltdEPVObhIiPoKSQUkAYRQ9nHhSNJZ/EP/fr
         mYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792289178; x=1792893978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RlT13S1OEXMnwWEPOPM5zDklmSAdD00qmkKyU2B6cVA=;
        b=jH1Om6lZ4gJTBI2fi0d6Yp9p4eSxmLYs8LKgMJxk/fyGPQkOLwN1G1NH96iusgPLJa
         OKf9FfzeiEOYJEJl9o/5MXSoBs7xRkZmduqGLvOuvz2FEzPXMsn+44QI3hqcTa+3XAXD
         dxc6JDX5cRdHyPTt+sS5+mzMx757ofM237HrCj4YB6Q7Qt6azYm0j3hD4AFn4a3dyfO5
         ceDtqyHv+gu3FIVu/srxdYJrLqdJKeXN5hj/+VVSxKIlxCMLJPQH3quQRSOFNzXQhLyM
         atp0pLsmznXrXNTJSWTcIdfpobQ0y0POVor1XcJMS/cdayGqo616M4JU1TDqpmtTxzgE
         a68Q==
X-Gm-Message-State: AFq9FYL/8M9klwKCRs/4Ug/16xTCNaP4lsZxSIFDGtH97UaU9HzB2RQR
	y/jdteahSzVL39vJMT2op5xPPkXsnbPk4zNHcpoqJZuVMXYoatxIpw0L3mooFnc/
X-Gm-Gg: AYBFou3FvnBCgH/oWqVbnRbzLRl6ENloGO7smtdkuT6oPCxQds4B4OrVW4Cy++AXIAJ
	hRokgYy4IwWBmBh7HNRmtSESTbm8lzpB8c7MrbZB4g3la8LTleJt8+AFZ+W0sLmRLNfw6hvYW/C
	7GwqKKFfRcsb9wSEC5F0MCVzc1Sr1H+Zx/V+4yVdVmljvxCyTKc7lV0f1RqL/Q3vy/RjYM7BYRm
	m2LSHN8i2SRFDR4CkrCBU3e51vQZsSSxLiwefnoLDHDxeSo9ccPj7pqprAimakEX+l0ZuBfgh4J
	zXD7+4gxiSWdw3fxPqwNx7l3iTy5P1nYCd99yb/7TmuEb1B2O0SxoxluqzoXBqeSBZX8wV012Hx
	ULYeFrI5EGf9Kno7y6kV7w2khI/+JnOi0rlKSgji1OhPmkMrtvqlAMjcmz3rhA2SNTUyAf+9kDd
	y2MdpyI++amn+hv0BneRqvZkH5eC0FuJZtEM4nF+xgjb8IX6Jq9V7nuakuHiUpUHeYuzm/ywepn
	1qooLKAtA9nkHJGeW0p7QlBO40yoDk=
X-Received: by 2002:a17:90b:3ec5:b0:3a8:13d6:f740 with SMTP id 98e67ed59e1d1-3aceec259d1mr3594047a91.22.1792289177863;
        Sat, 17 Oct 2026 19:06:17 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc98139ccsm5775584a91.0.2026.10.17.19.06.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 19:06:16 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [error-report-web][PATCH 2/2] Remove bleach and store submitted data as sent.
Date: Sat, 17 Oct 2026 19:03:56 -0700
Message-ID: <20261018020518.76802-5-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018020518.76802-1-tim.orling@konsulko.com>
References: <20261018020518.76802-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 02:06:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5068

bleach stored escaped text, so "<" or "&" showed as "&lt;" or "&amp;".
Escaping on output covers every place the data is shown, and bleach is
deprecated. Existing reports keep their escaped text.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 Post/parser.py   | 10 ----------
 Post/test.py     | 10 ++++++++++
 requirements.txt |  1 -
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/Post/parser.py b/Post/parser.py
index 092ce24..e221bcf 100644
--- a/Post/parser.py
+++ b/Post/parser.py
@@ -10,7 +10,6 @@
 
 import json
 import re
-import bleach
 from Post.models import Build, BuildFailure, ErrorType
 from Post.validators import clean_link_back
 from django.conf import settings
@@ -30,15 +29,6 @@ class Parser:
         except Exception:
              return  { 'error' : 'Invalid json' }
 
-        # Bleach data going directly into the database so that
-        # displaying in any of the graphing doesn't introduce XSS
-        for key,val in jsondata.items():
-            if key == 'failures':
-                continue
-            if not isinstance(val, str):
-                continue
-            jsondata[key] = bleach.clean(val)
-
         b = Build.objects.create()
         try:
             b.MACHINE = str(jsondata['machine'])
diff --git a/Post/test.py b/Post/test.py
index 0a358d1..51ae0b9 100755
--- a/Post/test.py
+++ b/Post/test.py
@@ -462,6 +462,16 @@ class SubmittedHtmlTest(TestCase):
         self.assertNotContains(response, "data-content")
         self.assertNotContains(response, "data-html")
 
+    def test_build_fields_are_stored_as_sent_and_escaped(self):
+        client, bf = self.submit(machine="<script>alert(1)</script>")
+        # Stored as sent; escaped on output.
+        self.assertEqual(bf.BUILD.MACHINE, "<script>alert(1)</script>")
+        for url in ("/Errors/Latest/", "/Errors/Details/%d/" % bf.id,
+                    "/Errors/Statistics/MACHINE"):
+            response = client.get(url)
+            self.assertEqual(response.status_code, 200, url)
+            self.assertNotContains(response, "<script>alert", msg_prefix=url)
+
     def test_tooltips_are_not_html(self):
         with open("Post/static/js/main.js") as f:
             self.assertNotRegex(f.read(), r"tooltip\(\{[^}]*html: true")
diff --git a/requirements.txt b/requirements.txt
index 40f3433..59c10a9 100644
--- a/requirements.txt
+++ b/requirements.txt
@@ -1,4 +1,3 @@
 Django>=5.2.18,<5.3
 python-Levenshtein==0.27.4
-bleach==6.4.0
 mysqlclient==2.3.0
-- 
2.56.0


