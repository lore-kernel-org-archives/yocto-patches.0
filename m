Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869CBCD5BC9
	for <webhook@archiver.kernel.org>; Mon, 25 May 2026 21:07:33 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24570.1779743243766144531
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 25 May 2026 14:07:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=mkJCQuhs;
 spf=pass (domain: smile.fr, ip: 209.85.128.43, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4903997fcb5so42730385e9.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 25 May 2026 14:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1779743242; x=1780348042; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiZzNiD9+Ethd+zKbI78t1JCRKiOYKlqiY6ctFDjwb8=;
        b=mkJCQuhs+dBNoycMrpnUGEKU1Fcfo95IXLjAlwTxwEZY5JruG+2exSU76r/jy5HgWP
         LkKt1CaVGIFsmU0/qKG4b5ufAeY2suDLpPKifYrXyUbeDet5swaGr6LdStrPIuzOM3bp
         3koux7jcqcJ8sjl6OVTs+IQGg8Gmhfzbnw2Fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779743242; x=1780348042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CiZzNiD9+Ethd+zKbI78t1JCRKiOYKlqiY6ctFDjwb8=;
        b=nUVuOc8EcoocamZF79F4wI3rj79wNQyE862Db+h+Jca6XTFBRrdUB5Jd7mNA/+16m6
         IQpkquXnf7dOg52nccNWdiMxJPHV8KSYVKY/RYmZAKh4iaaWQzj2dyVaxDPT1eAeAh2V
         DusntvB7VnP9Wkv9Ylx4iuFP3TxS+6w7mulnQICZQYuzQUzLQK+LOUEfNnd/DW19ybDU
         Q2zhXsX/rUNiK+BnWhQrDHM0nffF/LIukBCB5+KW935UnNyPcwq6lB1NY//KJf5Reqw8
         t8EDq0O4C4hcKiyTZ8cCDzcfVPg1LanQjqlP5loPH52u9tTTE2gODWN00CbpNb/iachd
         mUUw==
X-Gm-Message-State: AOJu0YwSMCSXL1DGjAlwDnbpuJLLCRqmTWKJtS6adCDGDF6vdCQvElis
	FDCPRwuIDRDsRFG5dAcLEpRuBYnBcUb4r6zgt15YQKa4+2l3d6c7w0zLcYi8c9DUYCOiIEc1vnT
	Q5Xoe
X-Gm-Gg: Acq92OFQuY5uK2WP64avdVE8SK3aC8kfCPPwxjps2SvFovhLL4J08h0gyK3owLIo32M
	kb+Wq/v0UzI7qsi0M8jP3cFaFLFemYus1IXL/n/SqyqapyoAZF0SF8UG10V/NKLp38hWzryn11r
	UUUv0Pt25BRfIkOij7Se70CALNWMP1SfedqXWaoqABrWY2047KSLUdZvymAHhS+knosoaKFOuXZ
	i1fKsMy/0/JC/IJWZat/7oKjjUKj/mkIlgo0sJW87vrzN2cFRY25gD334De7iia1ATH1vi4KeWJ
	HrMM8SPlAeN3wr849Qsr60H67sW+t+dtQtxX9Xmobvqeo3hzG7fzZKq3tIg7pPiJX1MY6Su9mF6
	+UXyihdk/9fPHYpurr9brMZw95gpDhdkALSxmunOODy901y81EN9uGZq6J9f2XRHUw/irBvvrWx
	+LjghNLn+LeHAng4lUtQE02UkH5RsbHu/UbC+ulzSyeiaGO9TwzhiaSdhUNJF8P8nd4pXuETrCw
	bbduk5h07PAqdJL6dOo8rA8rlBwiSTpEww9qw==
X-Received: by 2002:a05:600c:4583:b0:489:1b10:d896 with SMTP id 5b1f17b1804b1-49042252732mr259670945e9.0.1779743241992;
        Mon, 25 May 2026 14:07:21 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454ac6a6sm282941535e9.12.2026.05.25.14.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 14:07:21 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: Yocto Patches ML <yocto-patches@lists.yoctoproject.org>
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder2][PATCH 3/4] steps/runconfig: Refactor log helper to module-level add_to_log
Date: Mon, 25 May 2026 23:07:07 +0200
Message-ID: <20260525210708.2918572-3-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260525210708.2918572-1-yoann.congal@smile.fr>
References: <20260525210708.2918572-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 25 May 2026 21:07:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4051

From: Yoann Congal <yoann.congal@smile.fr>

This will allow to call add_to_log elsewhere in a later commit.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 steps/runconfig.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/steps/runconfig.py b/steps/runconfig.py
index a6d0dbd..18cdd7a 100644
--- a/steps/runconfig.py
+++ b/steps/runconfig.py
@@ -154,6 +154,14 @@ def get_runconfig_step(name, stepname, phase, description, usepty, posttrigger):
         timeout=16200)  # default of 1200s/20min is too short, use 4.5hrs
     return step
 
+@defer.inlineCallbacks
+def add_to_log(step, logName, message):
+    try:
+        log = step.getLog(logName)
+    except KeyError:
+        log = yield step.addLog(logName)
+    log.addStdout(message)
+
 class RunConfigCheckSteps(shell.ShellCommand):
     name = 'Check run-config steps to use'
     descriptionDone = ['Checked which run-config approach to use']
@@ -192,7 +200,7 @@ class RunConfigCheckSteps(shell.ShellCommand):
         try:
             jsonconfig = json.loads(logLines)
         except Exception as ex:
-            self._addToLog('stderr', 'ERROR: unable to parse data, exception {}: {}'.format(ex.__class__, ex))
+            add_to_log(self, 'stderr', 'ERROR: unable to parse data, exception {}: {}'.format(ex.__class__, ex))
 
         if rc == FAILURE or not jsonconfig:
             steps = [get_runconfig_legacy_step(self.posttrigger)]
@@ -209,14 +217,6 @@ class RunConfigCheckSteps(shell.ShellCommand):
         self.build.addStepsAfterCurrentStep(steps)
         return SUCCESS
 
-    @defer.inlineCallbacks
-    def _addToLog(self, logName, message):
-        try:
-            log = self.getLog(logName)
-        except KeyError:
-            log = yield self.addLog(logName)
-        log.addStdout(message)
-
 class TargetPresent(shell.ShellCommand):
     name = "Check if branch needs this target"
     command=[util.Interpolate("%(prop:builddir)s/yocto-autobuilder-helper/scripts/target-present"), util.Property("buildername")]

