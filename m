Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD7BC71155
	for <webhook@archiver.kernel.org>; Fri, 20 Jun 2025 09:08:46 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web11.3707.1750410518877104742
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Jun 2025 02:08:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=bAaSo6o0;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C4F8943AD6;
	Fri, 20 Jun 2025 09:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750410517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KKAv3yXFmK7dRhfvhOu0G9u+uc5W6oNSxriH2ojqdP4=;
	b=bAaSo6o0TEdH/fILd+qyMl0vcFFL5/WAneSNAko/c/6iGnFlOsvRHMajR/o2grFxCer/W2
	0eHlqL4evzPWuj456+1aJO/dstewyr8wEWkmmSM92SyWsuXee67lMgLoNZ26nj1Z3NiSxH
	7VAhYEUg0L0inDSVPG9qQVc2bzxvSmmv/DMFh58HCgEBatQFWsktxr/xb8SnZGN7QYPZo7
	Hbl348UmMrJNdo22S16aLOSuHBZsGPnyJqwuQmsfsjIMk1HRSoYDZJj8GL8H55MSQVMlRE
	VQlCL9QNy4nTZ++0kYWqUNtWCOmmJF9BaboYVtaWwruPA2RQUxbPez5EmVP6vw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 20 Jun 2025 11:08:15 +0200
Subject: [swat-tools][PATCH] Add a parent build column and filter
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-parent-build-filter-v1-1-4ddd7b3207c8@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAP4kVWgC/yXMTQrCMBBA4auUWTsQA4biVUoX+ZnqSEjKTKpC6
 d2NuvwW7+2gJEwK12EHoScr19JxPg0Q777cCDl1gzX2Ypw1uHqh0jBsnBMunBsJxmSi82FMo0v
 Qy1Vo4ffvOs1/6xYeFNt3NenLN2y1Zp3hOD4jrvlwgwAAAA==
X-Change-ID: 20250620-parent-build-filter-cd0c6ab8d86d
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3329;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=khZTMIUnUydZhbd2M5JhVr9luTycX7YT6ADpLvEdDrU=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBoVSUU71Z6MdKntKHYSthizU1ga2+fUPfDT3O1f
 f9qfODGx12JAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaFUlFAAKCRDRgEFAKaOo
 NqH7D/sGNc0rFiBLFF/iQ8nXerINIx7gjDoBc/2DFRssv97ACs86urYX4Mpg4nqk13ehwAEk09n
 1A0ZHZ+MdH9lgjFdhIQqjYHBF+m1RPECjjSEqyREDn9Q+kJTPRVAVkEhml6B+7GkuQJ5ifUj3gm
 Z/VvQkCR0wFY6quEyDjHjLx2rbGZ5g/LdmVrW7g9oAb3ubsQ74et2CfHTCD3hy0anZjaGu4LrKj
 utcycYY5p/M8cdq7JOd5NSvqKLQV9EP06QSDPzxu+Nn4XutBlwy90PMAmAj8wBVBbYQRAa/IzrN
 LmEwybXZIzMGLa48WR+DAwshe85AxWP9q9eDDK0dO59Oiw3Zn4fhRHmh/QvHHODG3DLUJhhLLW9
 reX0sU2TwPA7o43Pg1yeo4ZdH7dR3O51BE44xqGK2HpTRMY/+e7mK0qJHUfYSNXZoJZKCPsWuPr
 jSKxX/q0+lCiHx7ZrHRcSttuOPFaOiljNgPM4y0ts/FIW2ybuyRS5v1D6lDXNvqr3ah69lL3KiM
 i0WJw9cHCJUp3XcBjecYS2G9zY+ioUhgDyLp3vahKb1rbfBJzeVXYro9WBWZCYwrUpfUC9WYh13
 QQmy0B4UMXPNXB0NjjLKVi76xIhw+N+lpUM4lKazkBJx5LBcZTuxP2DAa5iKwq39+L42CFh1kDI
 vWnCUfz/KCqUI5A==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdektddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomheptehnthhonhhinhcuifhouggrrhguuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeileehffehteeutedvfeefgfegjefffedujeeiveeihfffjeegjedvteduvdejffenucffohhmrghinhepfhhivghlugdrsghuihhlugenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeftgekudemvggsrgejmedusgeksgemrgehtgelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeftgekudemvggsrgejmedusgeksgemrgehtgelpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepgedprhgtphhtthhopehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrt
 ghpthhtoheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohephihotghtohdqphgrthgthhgvsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhg
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Jun 2025 09:08:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1668

To be able to filter failures by parent build number, e.g. filter all
failures for a-full build number xyz, add a --parent-build-filter (-p)
option to swattool. The option can be passed multiple times and can be a
regular expression.

It is also displayed by default in show-pending-failures, after the
column "Build" as "Parent".

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 swattool/main.py      | 6 ++++++
 swattool/swatbuild.py | 4 +++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/swattool/main.py b/swattool/main.py
index a101340..7fe312d 100755
--- a/swattool/main.py
+++ b/swattool/main.py
@@ -73,6 +73,7 @@ def parse_filters(kwargs) -> dict[str, Any]:
         completed_before = kwargs['completed_before'].astimezone()
 
     filters = {'build': regex_filter(kwargs['build_filter']),
+               'parent_build_number': regex_filter(kwargs['parent_build_filter']),
                'test': regex_filter(kwargs['test_filter']),
                'ignore-test': regex_filter(kwargs['ignore_test_filter']),
                'status': statuses,
@@ -184,6 +185,8 @@ failures_list_options = [
                  help="Only show some tests"),
     click.option('--build-filter', '-b', multiple=True,
                  help="Only show some builds"),
+    click.option('--parent-build-filter', '-p', multiple=True,
+                 help="Only show some builds with parent build id"),
     click.option('--owner-filter', '-o', multiple=True,
                  help='Only show some owners ("none" for no owner)'),
     click.option('--ignore-test-filter', '-T', multiple=True,
@@ -223,6 +226,8 @@ def _format_pending_failures(builds: list[swatbuild.Build],
                              ) -> tuple[list[list[str]], list[str]]:
     # Generate a list of formatted builds on failures.
     def format_header(field):
+        if field == swatbuild.Field.PARENT_BUILD_NUMBER:
+            return "Parent"
         if field == swatbuild.Field.STATUS:
             return "Sts"
         return str(field)
@@ -284,6 +289,7 @@ def _show_failures(refresh: str, urlopens: set[str], limit: int,
 
     shown_fields_all = [
         swatbuild.Field.BUILD,
+        swatbuild.Field.PARENT_BUILD_NUMBER,
         swatbuild.Field.STATUS,
         swatbuild.Field.TEST,
         swatbuild.Field.OWNER,
diff --git a/swattool/swatbuild.py b/swattool/swatbuild.py
index 3d3c91c..4ccf32f 100644
--- a/swattool/swatbuild.py
+++ b/swattool/swatbuild.py
@@ -102,6 +102,7 @@ class Field(enum.StrEnum):
     USER_NOTES = 'Notes'
     USER_STATUS = 'New Triage'
     TRIAGE = 'Triage'
+    PARENT_BUILD_NUMBER = 'Parent Build Number'
 
 
 class Failure:
@@ -402,7 +403,8 @@ class Build:
         if not all(simple_match(field) for field in simple_filters):
             return False
 
-        regex_filters = [Field.BUILD, Field.OWNER, Field.TEST]
+        regex_filters = [Field.BUILD, Field.OWNER, Field.TEST,
+                         Field.PARENT_BUILD_NUMBER]
         if not all(regex_match(field) for field in regex_filters):
             return False
 

---
base-commit: 8930d3e3f71dc3d2a33e8df5ade430deeeb7019b
change-id: 20250620-parent-build-filter-cd0c6ab8d86d

Best regards,
-- 
Antonin Godard <antonin.godard@bootlin.com>


