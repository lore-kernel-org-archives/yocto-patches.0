Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16905.1792894016958512482
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 24 Oct 2026 19:06:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=AK7f1NiZ;
 spf=pass (domain: gmail.com, ip: 209.85.216.44, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-398a4dcf289so1058791a91.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 24 Oct 2026 19:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792894016; x=1793498816; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0fTWnuvX0BR5ApweuBk7769Co0yLukKOXak7JH2wXD8=;
        b=AK7f1NiZpDmE/NK8z3eRBvTKPGlpdfXbv4voMSC6gUO4nE/HovoRIiYGl4yjtHhx7/
         g61jAYxR5xlIBaWfKaZTDdEpaK6t9zEJi94A+W8hT/AU8jyIgxvRg+QoboaZ40a7FC/V
         HFacLozKled+MV70hQPGcLzcZ9ToW8NB6jpOLZjbWepVJWwcnzIueWfu3ccylp4OTDJc
         ka0rxXNnWKjmCbRoSXKEfO8mPErmWxFbiIKZh2ArsKCm5oukh7D+jKBfrLeOUfBcVCNN
         Qgv9IPz/0yJyjsrdQQ2jGji6DNig0kA0kL3CApfcMtXp1aNaAL6f35GIWuInFaT7rZun
         xzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792894016; x=1793498816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0fTWnuvX0BR5ApweuBk7769Co0yLukKOXak7JH2wXD8=;
        b=OzD2RWdnckp0Uy6twhWfUKMYbYgngwsSAf54ZfYQHUvYpV1lqASm5pJyljcsvtfLyZ
         9KHADfZqtXJIgFTb9DyqjplkaleZu/ReDTfCxco48iZtMGoT4eFs5W2gwBEOZFAVMR4V
         oM/vyC62Aqf5VAf34yAmMI3wleDdvDVUQmhH8bdeup872tLusptJmFrqj0Q1zR4JiVYb
         KoHMwLHo+GzkZEaJN493B9mBq6Nk8/FKiA7LetlsfNlF1+sB75OZ8NohlxzbHWBsXGb1
         vrL0scrjLXaFIg/XFsXM26XXEJ3TnOu72b0dQES+XEnpeu28Hvq/QxCLwwPEcAKFY2fH
         g0VQ==
X-Gm-Message-State: AFq9FYJFGWl5YsmjnqucxnKgFFEkcxkvKGBRywrV0cW01mzNU5ddUiar
	zAK/GbtQGZBAwpsR8aaGMHLTdXpG1TY0JqE8xcIKK25X5uMhnUKlX4Ga1dGlfw==
X-Gm-Gg: AYBFou0E8Hbq59n5FMv8VBM7T+gtmjlj6IkGG3sYpGn9+KsbnCRNK2SLO+7C1jHEEM6
	vpu+oclglNcAIzQ74omcqdP5FrODbSBwJWZPjX1OPSn7E9WbmkvJKv3dw8BrWZJmIVLtbEmrYb6
	bZ/yL2pQIOoK0ExNIypRrJaecHm/TB8JVgKCA1iImdKEYc3RHouE0HFH8IMkz3lKT8XnxckTVgl
	1K37h8muqXHYy8Y2UcemUU+gAYY4c3RHdAjC11OnMNAU6q+drXU0Rp0WUFaeNiit9ALYqUu82ID
	YiaLGitLumUo+GBoozeSrkPCHviEg2Hb3uK8xXs4f4oAh9FH6Rf0+CxmjDjQQ+8S9+o4ZHMT5+P
	IuQNrxiFmli5CFyMIujtF6qmpw/VOZDp/npZZujeaXvhQZxQRmJqehtyeylr5h0mU2jBFEuGQGQ
	HPAMrkNCeCFiauIhDFyxNrOKLqzoLk1lKtmMEzkxDZQ31TpbZVYN5PBVPeKChoiVOaDsNDT0m/T
	T3ysbqg3C6WpbOp/RH5wJtkSrwghs5278f4SHGu01zJJyrxdFt6b1+McgaDz4s6rnW+kM6X+r34
	Ip2rhhe2lI+e
X-Received: by 2002:a17:90b:224b:b0:3ac:d19e:85f1 with SMTP id 98e67ed59e1d1-3adeafd6bc7mr2581579a91.53.1792894016212;
        Sat, 24 Oct 2026 19:06:56 -0700 (PDT)
Return-Path: <ticotimo@gmail.com>
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb0718esm3966914a91.11.2026.10.24.19.06.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Oct 2026 19:06:55 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 2/2] templates: link to Bugzilla for reporting bugs
Date: Sat, 24 Oct 2026 19:06:46 -0700
Message-ID: <20261025020646.89376-2-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261025020646.89376-1-tim.orling@konsulko.com>
References: <20261025020646.89376-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sun, 25 Oct 2026 02:07:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5150
Content-Type: text/plain; charset="utf-8"

The site gave no hint of where to report problems with it. Add a
"report a bug" link to the footer and a line on the About page, both
pointing to the Layer Index product in the Yocto Project Bugzilla.

[YOCTO #15039]

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 templates/base.html             |  1 +
 templates/layerindex/about.html |  2 ++
 tests/test_bug_report_link.py   | 23 +++++++++++++++++++++++
 3 files changed, 26 insertions(+)
 create mode 100644 tests/test_bug_report_link.py

diff --git a/templates/base.html b/templates/base.html
index e31238c..acf0a9f 100644
--- a/templates/base.html
+++ b/templates/base.html
@@ -130,6 +130,7 @@
             <a href="{% url 'history_list' %}">change history</a>
             &bull; <a href="{% url 'about' %}">about this site</a>
             &bull; <a href="https://www.openembedded.org/wiki/Layers_FAQ">FAQ</a>
+            &bull; <a href="https://bugzilla.yoctoproject.org/enter_bug.cgi?product=Layer%20Index">report a bug</a>
         </div>
 
         {% endblock %}
diff --git a/templates/layerindex/about.html b/templates/layerindex/about.html
index a2055fb..5acba08 100644
--- a/templates/layerindex/about.html
+++ b/templates/layerindex/about.html
@@ -57,6 +57,8 @@
 
 <p>The code is Open Source and can be found on <a href="https://git.yoctoproject.org/layerindex-web/">git.yoctoproject.org</a>. Patches welcome!</p>
 
+<p>If you find a problem with this site, please <a href="https://bugzilla.yoctoproject.org/enter_bug.cgi?product=Layer%20Index">report it</a> in the Yocto Project Bugzilla under the "Layer Index" product.</p>
+
 {% endautoescape %}
 {% endblock %}
 
diff --git a/tests/test_bug_report_link.py b/tests/test_bug_report_link.py
new file mode 100644
index 0000000..d4d1027
--- /dev/null
+++ b/tests/test_bug_report_link.py
@@ -0,0 +1,23 @@
+# layerindex-web - tests for the bug report link
+#
+# Licensed under the MIT license, see COPYING.MIT for details
+#
+# SPDX-License-Identifier: MIT
+
+import pytest
+from django.test import TestCase
+from django.urls import reverse
+
+BUG_URL = 'https://bugzilla.yoctoproject.org/enter_bug.cgi?product=Layer%20Index'
+
+
+@pytest.mark.django_db
+class TestBugReportLink(TestCase):
+
+    def test_footer_links_to_bugzilla(self):
+        response = self.client.get(reverse('history_list'))
+        self.assertContains(response, '<a href="%s">report a bug</a>' % BUG_URL)
+
+    def test_about_page_links_to_bugzilla(self):
+        response = self.client.get(reverse('about'))
+        self.assertContains(response, '<a href="%s">report it</a>' % BUG_URL)
-- 
2.56.0

