Return-Path: <alexis.lothore@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AEFC41513
	for <webhook@archiver.kernel.org>; Fri, 21 Jun 2024 15:57:41 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web10.76934.1718985456422545299
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 21 Jun 2024 08:57:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=jkVlrhsG;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: alexis.lothore@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BD2061C0005;
	Fri, 21 Jun 2024 15:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718985455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MmfSQ+IhhXL1sCwO+dYKFluyXTo124eeHvHM0i8I+FQ=;
	b=jkVlrhsGBLPpm2qzyNG4Xec1in04aGXYt+bXVsL5ovAnQYub2LkXAuPZ6+CoiX4aEsfNZ0
	hYiFcb1F2Up7tmPHVNmNdyOZrW8LoxxU9qH2uJ+RsqDQM0IGqc3tIMmu/TeK2Hkb/oGnkg
	FzbmzdR8H4l7zewsSd4EcgOXZWjmk+GdxMft0xlNVvwiFf3Fo90uSYj23iqyt6boylijtk
	t8usolia8AU1PTTqiiNk32L3uD8VuiiGEXq3CT7obkyrIKY95ZN7XJjncv8j90LhHv/mjr
	Ip/RHOqeTDbzB82uoZ9iesC5/Ry7MQ3RAZX1EolibBbI3Efk2VtFgVCedSX8DQ==
From: =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [yocto-autobuilder-helper][PATCH 2/3] scripts: test_send_qa_email: fix broken tests
Date: Fri, 21 Jun 2024 16:57:22 +0100
Message-ID: <20240621155723.33600-3-alexis.lothore@bootlin.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621155723.33600-1-alexis.lothore@bootlin.com>
References: <20240621155723.33600-1-alexis.lothore@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Jun 2024 15:57:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/367

From: Alexis Lothoré <alexis.lothore@bootlin.com>

Commit 1dc77f590875 ("scripts: send_qa_email: add dry-run mode") updated
the get_regression_base_and_target to allow it to receive a test result
url. Unfortunately, this function's tests have not been updated
accordingly, so they currently fail because of the missing parameter.

Add a default url in test case and update the function call with this
default value.

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 scripts/test_send_qa_email.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/scripts/test_send_qa_email.py b/scripts/test_send_qa_email.py
index 64ae80a1852d..8b19975c31d5 100755
--- a/scripts/test_send_qa_email.py
+++ b/scripts/test_send_qa_email.py
@@ -42,6 +42,8 @@ class TestVersion(unittest.TestCase):
         {"input": None, "expected":False}
     ]
 
+    test_results_url = "git://git.yoctoproject.org/yocto-testresults"
+
     # This data represent real data returned by utils.getcomparisonbranch
     # and the release argument passed to send-qa-email script
     regression_inputs = [
@@ -76,7 +78,12 @@ class TestVersion(unittest.TestCase):
         for data in self.regression_inputs:
             with self.subTest(data['name']):
                 base, target = send_qa_email.get_regression_base_and_target(
-                    data['input']['targetbranch'], data['input']['basebranch'], data['input']['release'], os.environ.get("POKY_PATH"), log)
+                    data['input']['targetbranch'],
+                    data['input']['basebranch'],
+                    data['input']['release'],
+                    os.environ.get("POKY_PATH"),
+                    self.test_results_url,
+                    log)
                 expected_base, expected_target = data["expected"]
                 # The comparison base can not be set statically in tests when it is supposed to be the previous tag,
                 # since the result will depend on current tags
-- 
2.45.2


