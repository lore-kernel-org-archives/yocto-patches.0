Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDDFE7718F
	for <webhook@archiver.kernel.org>; Fri,  3 Jan 2025 15:25:17 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web10.33044.1735917915495143457
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 03 Jan 2025 07:25:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=me4nT7Du;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 71A851BF203;
	Fri,  3 Jan 2025 15:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735917913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H9axfQ3H2ZfPU63KHjfjxEcHieg/Z7g4mMD6BuvVuWk=;
	b=me4nT7DuDj611xgOwXrDTofYw0NGhr5c1chAQuCMxNmClTG7E8Y0joAd8mb/25V9VYAdLC
	eW5cHSpo4TiqNZWaOGytoki8skNDsh/mXU8AWPNl76Qkf2J0ntF7a6bGnyTE60e3qKqYgk
	IuURaLSUH4WbRHouuHF+3YzOZyKcCYwm2oUkAvBLLUYtwW4goK7nU7klbHqm+ZDWBip7+z
	QRgCHg4KhaTYOmFgf9C6zEfD9bKSWIf+Djg3p7ZnyIxU+66gIdu0EiDyNy6qCTXM+NBIuD
	KDHV2Er+4aRtbyylX6peHxIDchi/Z441dZtjFRkqH4edh5gWdAMeob5T8CMcPA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 03 Jan 2025 16:24:53 +0100
Subject: [yocto-autobuilder-helper][PATCH] config.json: add docs build
 config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-docs-config-v1-1-a0c3fd11ffbf@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAEQBeGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQwNj3ZT85GLd5Py8tMx03eQ0M0MLi1Qzy2TzRCWgjoKi1LTMCrBp0bG
 1tQBAoxGjXQAAAA==
X-Change-ID: 20250103-docs-config-cf6188e69c7a
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1422;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=7TbMRJ3hMmqMJqBc/gwbaTdRkpoK5nMu2A/4bVBMwHk=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBneAFZOhTHhkUbw4ydtXWGrgIB4sXgkhL8qJq/3
 KoU1bRV5JaJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZ3gBWQAKCRDRgEFAKaOo
 Nj4ZD/486G6dPHWQrfr3pywzksX0hfNyxRMrk+rYSnOpR586yF74h7bqIaK6sinEH464TygQas5
 LBLkE8hBpjJhdKSjNNzqn+FScOBNEs/CG13Vla+TCHu2PD2rkm6rrYEeUic3n7SDIZVV8vVDTqS
 jZpHJnJr5BNk2G0WkvXSoQpVRSlZnF+fMWi/92oqDFN6jtLfTN+ReBzit5dn+fu2LyyzttAWQFV
 Z2lh2Oq6Y+X/cnnv5cao/jiewcreTzWhYMbXvoeoqB5srqz7QPs5waucgGHysOqXbpInYozcsB8
 /O14QrPVWUdIg2+9wbE1hzI+keYLe27qsRHF5DbE7CnyLVLFxDBRCo6lWWnRv8PN9MMq2iOdS8r
 2SYi9Q0fSuJKrumWwZoVoINZ+PwW/0/JguOxb1s/gRCaYt0qBOMzleetvpRUXjRnrRcmn3cb/sv
 CYAN+KFRwG62U00BTPU0bUbTlb7aQcOngkotGcn7Y6gLUH/ExXV95WmGyMRUEmCZfhCFV41MRl5
 CIs0oi3RZKaaPPZfi8y7ChBXpv6H5KOppzxW3qcD1JYPeYAxz9/wemUrQNokkzNwAJQSKvxG7ZJ
 czli6w3AEluHIiWnd9hO09VTCstnZi7wfAHMvVcVoDlYLBh6OcV8YkjT0jiMwsRRyN3Cv0n/Bzk
 LMG0efHi32SkYWg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Jan 2025 15:25:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/966

Like other builds, declare the repos on which the docs build depends on
here. This is needed by the patch "docs: fetch yocto-docs and bitbake
using *shared-repos scripts" on yocto-autobuilder2.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 config.json | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/config.json b/config.json
index a6a4332bbd77a952e1886de74c038566cfc2378b..bbe151882da3fbecc5da5def5f3abe1eaac586d7 100644
--- a/config.json
+++ b/config.json
@@ -1817,6 +1817,9 @@
         "a-full-posttrigger" : {
             "TEMPLATE" : "trigger-build-posttrigger"
         },
+        "docs": {
+            "NEEDREPOS" : ["yocto-docs", "bitbake"]
+        },
         "patchtest" : {
             "NEEDREPOS" : ["poky", "meta-patchtest", "meta-openembedded"],
             "MACHINE" : "qemux86-64",
@@ -1962,6 +1965,12 @@
             "branch" : "master",
             "revision" : "HEAD",
             "no-layer-add" : true
+        },
+        "yocto-docs" : {
+            "url" : "ssh://git@push.yoctoproject.org/yocto-docs",
+            "branch" : "master",
+            "revision" : "HEAD",
+            "no-layer-add" : true
         }
     },
     "buildtools" : {

---
base-commit: e39db7b08eb81b012f2127f41dc1c2b8fa46c003
change-id: 20250103-docs-config-cf6188e69c7a

Best regards,
-- 
Antonin Godard <antonin.godard@bootlin.com>


